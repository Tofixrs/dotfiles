{
  inputs',
  lib,
  osConfig,
  pkgs,
}: let
  grimblast = mode: "${lib.getExe inputs'.hyprland-contrib.packages.grimblast} --freeze save ${mode} - | swappy -f - -o ~/Pictures/screenshots/$(date +'%s_grim.png')";
  workspace = map (i:
    if i != 10
    then "$mainMod, ${toString i}, workspace, ${toString i}"
    else "$mainMod, 0, workspace, 10") (lib.range 1 10);
  moveToWorkspace = map (i:
    if i != 10
    then "$mainMod SHIFT, ${toString i}, movetoworkspace, ${toString i}"
    else "$mainMod SHIFT, 0, movetoworkspace, 10") (lib.range 1 10);
  moveToWorkspaceSilent = map (i:
    if i != 10
    then "$mainMod CONTROL, ${toString i}, movetoworkspacesilent, ${toString i}"
    else "$mainMod CONTROL, 0, movetoworkspacesilent, 10") (lib.range 1 10);
  lockCommand =
    if osConfig.modules.usrEnv.screenLocker == "hyprlock"
    then "${lib.getExe pkgs.hyprlock}"
    else "${lib.getExe pkgs.swaylock} -f";
in {
  bind =
    [
      # Possibly some module to set a terminal
      "$mainMod, RETURN, exec, $TERMINAL"
      "$mainMod, M, exit"
      "$mainMod, C, killactive"
      "$mainMod, R, exec, anyrun"
      "$mainMod, F, togglefloating"
      "$mainMod CONTROL, F, fullscreen, 0"
      "$mainMod, left, movefocus, l"
      "$mainMod, right, movefocus, r"
      "$mainMod, up, movefocus, u"
      "$mainMod, down, movefocus, d"
      "$mainMod SHIFT, left, movewindow, l"
      "$mainMod SHIFT, right, movewindow, r"
      "$mainMod SHIFT, up, movewindow, u"
      "$mainMod SHIFT, down, movewindow, d"
      "$mainMod, mouse_down, workspace, e+1"
      "$mainMod, mouse_up, workspace, e-1"
      "$mainMod, Print, exec, ${grimblast "area"}"
      ", Print, exec, ${grimblast "screen"}"
      "$mainMod, TAB, exec, ags --toggle-window dashboard"
      "$mainMod, V, exec, ags --toggle-window clipboard"
      "$mainMod, X, exec, ags --toggle-window powermenu"
      ", xf86audioplay, exec, playerctl play-pause"
      ", xf86audionext, exec, playerctl next"
      ", xf86audioprev, exec, playerctl previous"
      ", xf86audiostop, exec, playerctl stop"
      ", xf86audiomute, exec, wpctl set-mute @DEFAULT_SINK@ toggle"
      ", xf86monbrightnessup, exec, brightnessctl set 50-"
      ", xf86monbrightnessdown, exec, brightnessctl set 50+"
      ", code:179, exec, spotify"
      "CTRL, xf86audionext, exec, playerctl position 5"
      "CTRL, xf86audioprev, exec, playerctl position 5 -"
      "$mainMod, l, exec, ${lockCommand}"
      "$mainMod CTRL, C, exec, hyprpicker -a -r -f hex"
    ]
    ++ workspace
    ++ moveToWorkspace
    ++ moveToWorkspaceSilent;
  bindm = [
    "$mainMod, mouse:272, movewindow"
    "$mainMod, mouse:273, resizewindow"
  ];
  binde = [
    "$mainMod CONTROL, up, resizeactive, 0 -20"
    "$mainMod CONTROL, down, resizeactive, 0 20"
    "$mainMod CONTROL, left, resizeactive, -20 0"
    "$mainMod CONTROL, right, resizeactive, 20 0"
    ", xf86audiolowervolume, exec, wpctl set-volume @DEFAULT_SINK@ 5%-"
    ", xf86audioraisevolume, exec, wpctl set-volume @DEFAULT_SINK@ 5%+"
  ];
}
