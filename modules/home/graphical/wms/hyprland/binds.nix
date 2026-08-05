{
  config,
  inputs',
  lib,
  pkgs,
  ...
}: let
  mkBind = {
    key,
    dsp,
    flags ? {},
  }: {
    _args = [key (lib.generators.mkLuaInline dsp) flags];
  };

  mainMod = "SUPER";
  workspace = map (i: let
    workspaceId =
      if i == 0
      then 10
      else i;
  in
    mkBind {
      key = "${mainMod} + ${toString i}";
      dsp = "hl.dsp.focus({workspace = ${toString workspaceId}})";
    }) (lib.range 0 9);

  moveToWorkspace = map (i: let
    workspaceId =
      if i == 0
      then 10
      else i;
  in
    mkBind {
      key = "${mainMod} + SHIFT + ${toString i}";
      dsp = "hl.dsp.window.move({workspace = ${toString workspaceId}, follow = true})";
    }) (lib.range 0 9);

  moveToWorkspaceSilent = map (i: let
    workspaceId =
      if i == 0
      then 10
      else i;
  in
    mkBind {
      key = "${mainMod} + CONTROL + ${toString i}";
      dsp = "hl.dsp.window.move({workspace = ${toString workspaceId}})";
    }) (lib.range 0 9);

  moveWorkspaceToMonitor = map (i: let
    workspaceId =
      if i == 0
      then 10
      else i;
  in
    mkBind {
      key = "${mainMod} + ALT + ${toString i}";
      dsp = "hl.dsp.workspace.move({monitor = ${toString workspaceId}})";
    }) (lib.range 0 9);

  zoomScript = pkgs.writeTextFile {
    name = "zoom-hyprland";
    executable = true;
    text = ''
      if step == 0 then
        hl.config({ cursor = { zoom_factor = 1.0 } })
        return
      end

      local current_zoom = hl.get_config("cursor:zoom_factor")
      if not current_zoom then return end

      local next_zoom = current_zoom + step

      if next_zoom < 0.50 then
        hl.config({ cursor = { zoom_factor = 1.0 } })
        return
      end

      hl.config({ cursor = { zoom_factor = next_zoom } })
    '';
  };

  zoom = step: "function () step = ${builtins.toString step}; dofile('${zoomScript}'); end";

  lockCommand = "loginctl lock-session";
  changeBrightness = delta: "qs ipc call brightness change ${builtins.toString delta}";
  openPanel = panel: "qs ipc call panels toggle ${panel}";
  openLauncherMode = mode: "qs ipc call launcher toggle ${builtins.toString mode}";
in {
  wayland.windowManager.hyprland.extraConfig = ''
    function start_mute_timer()
      return hl.timer(function()
        hl.exec_cmd("wpctl set-mute @DEFAULT_SOURCE@ 1")
        hl.exec_cmd("${pkgs.ffmpeg-full}/bin/ffplay -nodisp ${./ptt-off.mp3}")
      end, {timeout = 250, type = "oneshot"})
    end
    local mute_timer = start_mute_timer()
    hl.bind("F10", function ()
      mute_timer:cancel()
      hl.exec_cmd("wpctl set-mute @DEFAULT_SOURCE@ 0")
        hl.exec_cmd("${pkgs.ffmpeg-full}/bin/ffplay -nodisp ${./ptt-on.mp3}")
    end)

    hl.bind("F10", function ()
      mute_timer = start_mute_timer()
    end, {release = true})
  '';
  wayland.windowManager.hyprland.settings.bind =
    [
      (mkBind {
        key = "${mainMod} + RETURN";
        dsp = "hl.dsp.exec_cmd(\"uwsm app -- $TERMINAL\")";
      })
      (mkBind {
        key = "${mainMod} + M";
        dsp = "hl.dsp.exec_cmd(\"uwsm stop\")";
      })
      (mkBind {
        key = "${mainMod} + C";
        dsp = "hl.dsp.window.close()";
      })
      (mkBind {
        key = "${mainMod} + R";
        dsp = "hl.dsp.exec_cmd(\"${openPanel "appLauncher"}\")";
      })
      (mkBind {
        key = "${mainMod} + F";
        dsp = "hl.dsp.window.float({ action = \"toggle\" })";
      })
      (mkBind {
        key = "${mainMod} + CONTROL + F";
        dsp = "hl.dsp.window.fullscreen({mode = \"fullscreen\", action = \"toggle\"})";
      })
      (mkBind {
        key = "${mainMod} + A";
        dsp = "hl.dsp.focus({ direction = \"l\" })";
      })
      (mkBind {
        key = "${mainMod} + D";
        dsp = "hl.dsp.focus({ direction = \"r\" })";
      })
      (mkBind {
        key = "${mainMod} + W";
        dsp = "hl.dsp.focus({ direction = \"u\" })";
      })
      (mkBind {
        key = "${mainMod} + S";
        dsp = "hl.dsp.focus({ direction = \"d\" })";
      })
      (mkBind {
        key = "${mainMod} + SHIFT + A";
        dsp = "hl.dsp.window.move({ direction = \"l\" })";
      })
      (mkBind {
        key = "${mainMod} + SHIFT + D";
        dsp = "hl.dsp.window.move({ direction = \"r\" })";
      })
      (mkBind {
        key = "${mainMod} + SHIFT + W";
        dsp = "hl.dsp.window.move({ direction = \"u\" })";
      })
      (mkBind {
        key = "${mainMod} + SHIFT + S";
        dsp = "hl.dsp.window.move({ direction = \"d\" })";
      })
      (mkBind {
        key = "${mainMod} + Print";
        dsp = "hl.dsp.exec_cmd(\"screenshot area\")";
      })
      (mkBind {
        key = "Print";
        dsp = "hl.dsp.exec_cmd(\"screenshot output\")";
      })
      (mkBind {
        key = "SHIFT + Print";
        dsp = "hl.dsp.exec_cmd(\"screenshot screen\")";
      })
      (mkBind {
        key = "${mainMod} + TAB";
        dsp = "hl.dsp.exec_cmd(\"${openPanel "dashboard"}\")";
      })
      (mkBind {
        key = "${mainMod} + V";
        dsp = "hl.dsp.exec_cmd(\"${openLauncherMode 6}\")";
      })
      (mkBind {
        key = "${mainMod} + O";
        dsp = "hl.dsp.exec_cmd(\"${openPanel "desktopOverlay"}\")";
      })
      (mkBind {
        key = "${mainMod} + X";
        dsp = "hl.dsp.exec_cmd(\"${openLauncherMode 4}\")";
      })
      (mkBind {
        key = "${mainMod} + CONTROL + SHIFT + R";
        dsp = "hl.dsp.exec_cmd(\"systemctl --user restart qs-config\")";
      })
      (mkBind {
        key = "XF86AudioPlay";
        dsp = "hl.dsp.exec_cmd(\"playerctl play-pause\")";
      })
      (mkBind {
        key = "XF86AudioNext";
        dsp = "hl.dsp.exec_cmd(\"playerctl next\")";
      })
      (mkBind {
        key = "XF86AudioPrev";
        dsp = "hl.dsp.exec_cmd(\"playerctl previous\")";
      })
      (mkBind {
        key = "XF86AudioStop";
        dsp = "hl.dsp.exec_cmd(\"playerctl stop\")";
      })
      (mkBind {
        key = "XF86AudioMute";
        dsp = "hl.dsp.exec_cmd(\"wpctl set-mute @DEFAULT_SINK@ toggle\")";
      })
      (mkBind {
        key = "XF86MonBrightnessUp";
        dsp = "hl.dsp.exec_cmd(\"${changeBrightness 0.05}\")";
      })
      (mkBind {
        key = "XF86MonBrightnessDown";
        dsp = "hl.dsp.exec_cmd(\"${changeBrightness (-0.05)}\")";
      })
      (mkBind {
        key = "code:179";
        dsp = "hl.dsp.exec_cmd(\"uwsm app -- spotify.desktop\")";
      })
      (mkBind {
        key = "CTRL + XF86AudioNext";
        dsp = "hl.dsp.exec_cmd(\"playerctl position 5\")";
      })
      (mkBind {
        key = "CTRL + XF86AudioPrev";
        dsp = "hl.dsp.exec_cmd(\"playerctl position 5 -\")";
      })
      (mkBind {
        key = "${mainMod} + l";
        dsp = "hl.dsp.exec_cmd(\"${lockCommand}\")";
      })
      (mkBind {
        key = "${mainMod} + CTRL + C";
        dsp = "hl.dsp.exec_cmd(\"uwsm app -- hyprpicker -a -r -f hex\")";
      })
      (mkBind {
        key = "${mainMod} + mouse:274";
        dsp = zoom 0;
      })
      (mkBind {
        key = "${mainMod} + mouse_up";
        dsp = zoom 0.25;
      })
      (mkBind {
        key = "${mainMod} + mouse_down";
        dsp = zoom (-0.25);
      })
      (mkBind {
        key = "${mainMod} + CONTROL + W";
        dsp = "hl.dsp.window.resize({x = 0, y = -20, relative = true})";
        flags = {repeating = true;};
      })
      (mkBind {
        key = "${mainMod} + CONTROL + S";
        dsp = "hl.dsp.window.resize({x = 0, y = 20, relative = true})";
        flags = {repeating = true;};
      })
      (mkBind {
        key = "${mainMod} + CONTROL + A";
        dsp = "hl.dsp.window.resize({x = -20, y = 0, relative = true})";
        flags = {repeating = true;};
      })
      (mkBind {
        key = "${mainMod} + CONTROL + D";
        dsp = "hl.dsp.window.resize({x = 20, y = 0, relative = true})";
        flags = {repeating = true;};
      })
      (mkBind {
        key = "XF86AudioLowerVolume";
        dsp = "hl.dsp.exec_cmd(\"wpctl set-volume @DEFAULT_SINK@ 5%-\")";
        flags = {repeating = true;};
      })
      (mkBind {
        key = "XF86AudioRaiseVolume";
        dsp = "hl.dsp.exec_cmd(\"wpctl set-volume @DEFAULT_SINK@ 5%+\")";
        flags = {repeating = true;};
      })
      (mkBind {
        key = "${mainMod} + equal";
        dsp = zoom 0.25;
        flags = {repeating = true;};
      })
      (mkBind {
        key = "${mainMod} + minus";
        dsp = zoom (-0.25);
        flags = {repeating = true;};
      })
      (mkBind {
        key = "switch:off:[Lid Switch]";
        dsp = "hl.dsp.exec_cmd(\"playerctl pause -a\")";
        flags = {locked = true;};
      })
      (mkBind {
        key = "switch:off:[Lid Switch]";
        dsp = "hl.dsp.exec_cmd(\"${lockCommand}\")";
        flags = {locked = true;};
      })
      (mkBind {
        key = "${mainMod} + mouse:272";
        dsp = "hl.dsp.window.drag()";
        flags = {mouse = true;};
      })
      (mkBind {
        key = "${mainMod} + mouse:273";
        dsp = "hl.dsp.window.resize()";
        flags = {mouse = true;};
      })
    ]
    ++ workspace ++ moveToWorkspace ++ moveToWorkspaceSilent ++ moveWorkspaceToMonitor;
}
