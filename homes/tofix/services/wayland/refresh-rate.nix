{
  lib,
  pkgs,
  osConfig,
  ...
}: let
  env = osConfig.modules.usrEnv;
  refreshScript = pkgs.writeShellApplication {
    name = "hypr-refresh-rate";
    runtimeInputs = with pkgs; [
      coreutils
      gawk
      jq
    ];
    text = ''
      AC_PATH="/sys/class/power_supply/ACAD/online"
      MONITOR_NAME="eDP-1"
      BATTERY_REFRESH="60"
      AC_REFRESH="144.00301"

      if [ ! -r "$AC_PATH" ]; then
        exit 0
      fi

      if ! hyprctl -j instances >/dev/null 2>&1; then
        exit 0
      fi

      instance="$(hyprctl -j instances | jq -r '.[0].instance // empty')"
      if [ -z "$instance" ]; then
        exit 0
      fi

      monitor_json="$(hyprctl -i "$instance" -j monitors all | jq -c --arg name "$MONITOR_NAME" '.[] | select(.name == $name)' | head -n1)"
      if [ -z "$monitor_json" ]; then
        exit 0
      fi

      if [ "$(cat "$AC_PATH")" = "1" ]; then
        target_refresh="$AC_REFRESH"
      else
        target_refresh="$BATTERY_REFRESH"
      fi

      current_refresh="$(printf '%s\n' "$monitor_json" | jq -r '.refreshRate // .refresh // 0')"
      width="$(printf '%s\n' "$monitor_json" | jq -r '.width')"
      height="$(printf '%s\n' "$monitor_json" | jq -r '.height')"
      pos_x="$(printf '%s\n' "$monitor_json" | jq -r '.x')"
      pos_y="$(printf '%s\n' "$monitor_json" | jq -r '.y')"
      scale="$(printf '%s\n' "$monitor_json" | jq -r '.scale')"
      transform="$(printf '%s\n' "$monitor_json" | jq -r '.transform // 0')"

      if awk -v current="$current_refresh" -v target="$target_refresh" 'BEGIN { diff = current - target; if (diff < 0) diff = -diff; exit !(diff < 0.5) }'; then
        exit 0
      fi

      monitor_arg="$MONITOR_NAME,''${width}x''${height}@''${target_refresh},''${pos_x}x''${pos_y},''${scale}"
      if [ "$transform" != "0" ]; then
        monitor_arg="$monitor_arg,transform,''${transform}"
      fi

      hyprctl -i "$instance" keyword monitor "$monitor_arg" >/dev/null
    '';
  };
in {
  config = lib.mkIf (env.desktop == "Hyprland") {
    home.packages = [refreshScript];

    systemd.user.services.hypr-refresh-rate = {
      Unit = {
        Description = "Adjust the Hyprland internal display refresh rate based on AC power";
        After = ["graphical-session.target"];
        PartOf = ["graphical-session.target"];
      };
      Service = {
        Type = "oneshot";
        ExecStart = lib.getExe refreshScript;
      };
      Install.WantedBy = ["graphical-session.target"];
    };

    systemd.user.timers.hypr-refresh-rate = {
      Unit.Description = "Periodically sync the Hyprland internal display refresh rate with AC power";
      Timer = {
        OnBootSec = "20s";
        OnUnitActiveSec = "30s";
        Unit = "hypr-refresh-rate.service";
      };
      Install.WantedBy = ["timers.target"];
    };
  };
}
