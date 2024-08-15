{
  inputs',
  lib,
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
  lockCommand = lib.getExe pkgs.hyprlock;
  zoomScript = pkgs.writeShellScript "zoom-hyprland" ''
    if [[ $1 == "0" ]]; then
      hyprctl keyword cursor:zoom_factor 0
      exit 1
    fi;
    currentZoom=$(hyprctl getoption cursor:zoom_factor | grep float | sed 's/^.*: //')
    nextZoom=$(awk "BEGIN{printf \"%.2f\", "$currentZoom$1$2"}")
    if [[ $nextZoom == "0.50" ]]; then
      hyprctl keyword cursor:zoom_factor 1
      exit 1
    fi
    hyprctl keyword cursor:zoom_factor $nextZoom
  '';
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
      "$mainMod, Print, exec, ${grimblast "area"}"
      ", Print, exec, ${grimblast "output"}"
      "SHIFT, Print,  exec, ${grimblast "screen"}"
      "$mainMod, TAB, exec, ags --toggle-window dashboard"
      "$mainMod, V, exec, ags --toggle-window clipboard"
      "$mainMod, X, exec, ags --toggle-window powermenu"
      "$mainMod, D, exec, ags --toggle-window desktop-top"
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
      "$mainMod, mouse:274, exec, ${zoomScript} 0"
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
    "$mainMod, equal, exec, ${zoomScript} + 0.5"
    "$mainMod, minus, exec, ${zoomScript} - 0.5"
  ];
}
