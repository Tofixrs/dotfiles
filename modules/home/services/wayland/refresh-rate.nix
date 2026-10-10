{
  lib,
  pkgs,
  osConfig,
  ...
}: let
  env = osConfig.modules.usrEnv;

  monitorName = "eDP-1";
  acRefresh = "144.00301"; # exact mode string as listed by hyprctl monitors
  batteryRefresh = "60";

  refreshScript = pkgs.writeShellApplication {
    name = "hypr-refresh-rate";
    runtimeInputs = [
      osConfig.programs.hyprland.package # fallback hyprctl if the running one can't be found
      pkgs.coreutils
      pkgs.gawk
      pkgs.jq
      pkgs.procps # pgrep
      pkgs.systemd # udevadm
    ];
    text = ''
      MON="${monitorName}"
      AC_HZ="${acRefresh}"
      BAT_HZ="${batteryRefresh}"

      # Log to stderr (-> journal), skipping consecutive duplicate messages
      # so the 30 s re-check doesn't flood the log.
      last_msg=""
      log() {
        if [ "$*" != "$last_msg" ]; then
          echo "$*" >&2
          last_msg="$*"
        fi
      }

      on_ac() {
        local ps
        for ps in /sys/class/power_supply/*; do
          if [ "$(cat "$ps/type" 2>/dev/null)" = "Mains" ] \
             && [ "$(cat "$ps/online" 2>/dev/null)" = "1" ]; then
            return 0
          fi
        done
        return 1
      }

      # Newest live Hyprland instance (changes every time Hyprland restarts)
      find_instance() {
        local newest="" d
        for d in "$XDG_RUNTIME_DIR"/hypr/*/; do
          [ -S "$d/.socket.sock" ] || continue
          if [ -z "$newest" ] || [ "$d" -nt "$newest" ]; then
            newest="$d"
          fi
        done
        [ -n "$newest" ] || return 1
        basename "$newest"
      }

      # hyprctl from the same store path as the running compositor,
      # so client and compositor versions always match
      find_hyprctl() {
        local pid exe dir
        pid="$(pgrep -x -u "$(id -u)" 'Hyprland|\.Hyprland-wrapped' | head -n1)"
        [ -n "$pid" ] || return 1
        exe="$(readlink -f "/proc/$pid/exe")" || return 1
        dir="$(dirname "$exe")"
        [ -x "$dir/hyprctl" ] || return 1
        echo "$dir/hyprctl"
      }

      apply() {
        local sig state target all json cur new w h x y s t lua out HCTL

        if ! sig="$(find_instance)"; then
          log "no live Hyprland instance found in $XDG_RUNTIME_DIR/hypr"
          return 0
        fi
        export HYPRLAND_INSTANCE_SIGNATURE="$sig"

        HCTL="$(find_hyprctl || echo hyprctl)"
        log "using $HCTL: $("$HCTL" version 2>&1 | head -n1 || true)"

        if on_ac; then
          state="AC"
          target="$AC_HZ"
        else
          state="battery"
          target="$BAT_HZ"
        fi

        if ! all="$("$HCTL" -j monitors all 2>&1)"; then
          log "hyprctl monitors failed: $all"
          return 0
        fi

        if ! json="$(jq -c --arg n "$MON" '.[] | select(.name == $n)' <<<"$all" | head -n1)"; then
          log "could not parse hyprctl output: $all"
          return 0
        fi
        if [ -z "$json" ]; then
          log "monitor $MON not found; available: $(jq -r '[.[].name] | join(", ")' <<<"$all")"
          return 0
        fi

        cur="$(jq -r '.refreshRate // .refresh // 0' <<<"$json")"
        log "state=$state current=$cur target=$target (instance $sig)"

        # Already at the target rate (within 0.5 Hz)? Nothing to do.
        if awk -v c="$cur" -v t="$target" 'BEGIN { d = c - t; if (d < 0) d = -d; exit !(d < 0.5) }'; then
          return 0
        fi

        read -r w h x y s t < <(jq -r '[.width, .height, .x, .y, .scale, (.transform // 0)] | @tsv' <<<"$json")

        # Lua config (Hyprland 0.55+): set the monitor through eval + hl.monitor
        lua="hl.monitor({ output = \"$MON\", mode = \"''${w}x''${h}@''${target}\", position = \"''${x}x''${y}\", scale = $s"
        if [ "$t" != "0" ]; then
          lua="$lua, transform = $t"
        fi
        lua="$lua })"

        out="$("$HCTL" eval "$lua" 2>&1)" || true
        log "hyprctl eval $lua -> $out"

        sleep 1
        new="$("$HCTL" -j monitors all 2>/dev/null | jq -r --arg n "$MON" '.[] | select(.name == $n) | .refreshRate' | head -n1)" || true
        log "after switch: $MON is at $new Hz"
      }

      log "starting: monitor=$MON ac=$AC_HZ bat=$BAT_HZ runtime_dir=$XDG_RUNTIME_DIR"
      for ps in /sys/class/power_supply/*; do
        log "supply $(basename "$ps"): type=$(cat "$ps/type" 2>/dev/null || echo n/a) online=$(cat "$ps/online" 2>/dev/null || echo n/a)"
      done

      # Re-check on every power_supply event, and at least every 30 s
      # (covers resume from suspend and Hyprland restarts)
      exec 3< <(udevadm monitor --udev --subsystem-match=power_supply)
      while true; do
        apply || true
        read -r -t 30 -u 3 _ || true
        sleep 1
      done
    '';
  };
in {
  config = lib.mkIf (env.desktop == "Hyprland") {
    systemd.user.services.hypr-refresh-rate = {
      Unit = {
        Description = "Switch Hyprland refresh rate on AC/battery";
        After = ["graphical-session.target"];
        PartOf = ["graphical-session.target"];
      };
      Service = {
        ExecStart = lib.getExe refreshScript;
        Restart = "on-failure";
        RestartSec = 3;
      };
      Install.WantedBy = ["graphical-session.target"];
    };
  };
}
