{
  inputs,
  pkgs,
  ...
}: let
  anyrun-stdin = "${inputs.anyrun.packages.${pkgs.system}.stdin}/lib/libstdin.so";
  grimblast = mode: "grimblast --freeze save ${mode} - | swappy -f - -o ~/Pictures/screenshots/$(date +'%s_grim.png')";
in {
  wayland.windowManager.hyprland = {
    enable = true;
    package = inputs.hyprland.packages.${pkgs.system}.hyprland;
    enableNvidiaPatches = true;
    settings = {
      "$mainMod" = "SUPER";
      input = {
        kb_layout = "pl";
        numlock_by_default = true; #why the FUCK isnt this on by default
      };
      bind = [
        "$mainMod, 1, workspace, 1"
        "$mainMod, 2, workspace, 2"
        "$mainMod, 3, workspace, 3"
        "$mainMod, 4, workspace, 4"
        "$mainMod, 5, workspace, 5"
        "$mainMod, 6, workspace, 6"
        "$mainMod, 7, workspace, 7"
        "$mainMod, 8, workspace, 8"
        "$mainMod, 9, workspace, 9"
        "$mainMod, 0, workspace, 10"
        "$mainMod, RETURN, exec, kitty"
        "$mainMod SHIFT, 1, movetoworkspace, 1"
        "$mainMod SHIFT, 2, movetoworkspace, 2"
        "$mainMod SHIFT, 3, movetoworkspace, 3"
        "$mainMod SHIFT, 4, movetoworkspace, 4"
        "$mainMod SHIFT, 5, movetoworkspace, 5"
        "$mainMod SHIFT, 6, movetoworkspace, 6"
        "$mainMod SHIFT, 7, movetoworkspace, 7"
        "$mainMod SHIFT, 8, movetoworkspace, 8"
        "$mainMod SHIFT, 9, movetoworkspace, 9"
        "$mainMod SHIFT, 0, movetoworkspace, 10"
        "$mainMod, M, exit"
        "$mainMod, C, killactive"
        "$mainMod, R, exec, anyrun"
        "$mainMod, F, togglefloating"
        "$mainMod CONTROL, F, fullscreen, 1"
        "$mainMod, left, movefocus, l"
        "$mainMod, right, movefocus, r"
        "$mainMod, up, movefocus, u"
        "$mainMod, down, movefocus, d"
        "$mainMod CONTROL, 1, movetoworkspacesilent, 1"
        "$mainMod CONTROL, 2, movetoworkspacesilent, 2"
        "$mainMod CONTROL, 3, movetoworkspacesilent, 3"
        "$mainMod CONTROL, 4, movetoworkspacesilent, 4"
        "$mainMod CONTROL, 5, movetoworkspacesilent, 5"
        "$mainMod CONTROL, 6, movetoworkspacesilent, 6"
        "$mainMod CONTROL, 7, movetoworkspacesilent, 7"
        "$mainMod CONTROL, 8, movetoworkspacesilent, 8"
        "$mainMod CONTROL, 9, movetoworkspacesilent, 9"
        "$mainMod CONTROL, 0, movetoworkspacesilent, 10"
        "$mainMod SHIFT, left, movewindow, l"
        "$mainMod SHIFT, right, movewindow, r"
        "$mainMod SHIFT, up, movewindow, u"
        "$mainMod SHIFT, down, movewindow, d"
        "$mainMod, mouse_down, workspace, e+1"
        "$mainMod, mouse_up, workspace, e-1"
        "$mainMod, Print, exec, ${grimblast "area"}"
        ", Print, exec, ${grimblast "screen"}"
        "$mainMod, TAB, exec, swaync-client -t"
        "$mainMod, V, exec, cliphist list | anyrun --plugins ${anyrun-stdin} -c ~/.config/clipboard | cliphist decode | wl-copy"
        "$mainMod, X, exec, ~/.config/hypr/power.sh"
        ", xf86audioplay, exec, playerctl play-pause"
        ", xf86audionext, exec, playerctl next"
        ", xf86audioprev, exec, playerctl previous"
        ", xf86audiostop, exec, playerctl stop"
        ", code:179, exec, spotify"
        "CTRL, xf86audionext, exec, playerctl position 5"
        "CTRL, xf86audioprev, exec, playerctl position 5 -"
        "$mainMod, l, exec, swaylock"
      ];
      windowrulev2 = [
        "float, class:^(org.kde.polkit-kde-authentication-agent-1)$"
        "float, class:^(Steam)$ title:^(Friends List)$"
        "size 500 500, class:^(Steam)$ title:^(Friends List)$"
        "float, class:^(steam)$ title:^(Friends List)$"
        "size 500 500, class:^(steam)$ title:^(Friends List)$"
        "size 930 495, class:^(firefox)$ title:^(Picture-in-Picture)$"
        "float, class:^(firefox)$ title:^(Picture-in-Picture)$"
        "nofullscreenrequest, class:^(firefox)$ title:^(Picture-in-Picture)$"
        "nofullscreenrequest, class:^(libreoffice-startcenter)$"
        "float, class:^(firefox)$, title:^(Firefox — Sharing Indicator)$"
        "move 0 0, class:^(firefox)$, title:^(Firefox — Sharing Indicator)$"
        "nofullscreenrequest, class:^(firefox)$, title:^(Firefox — Sharing Indicator)$"
        "noinitialfocus, class:^(steam)$, title:^(notificationtoasts)"
        "float, class:^(com-atlauncher-App)$ title:^(ATLauncher Console)$"
        "opacity 0.85, class:^(kitty)$"
        "opacity 0.9, class:^(WebCord)$"
      ];
      exec-once = [
        "sleep 3 && swww init && swww img /home/tofix/Pictures/Wallpapers/astro_catpuccin-mocha.png"
        "${pkgs.libsForQt5.polkit-kde-agent}/libexec/polkit-kde-authentication-agent-1"
        "hyprctl setcursor Bibata-Modern-Classic 12"
        "~/.config/hypr/autostart.sh"
        "wl-paste --type text --watch cliphist store"
        "wl-paste --type image --watch cliphist store"
        "swaync"
        "ags"
        "swayidle -w"
      ];
      bindm = [
        "$mainMod, mouse:272, movewindow"
        "$mainMod, mouse:273, resizewindow"
      ];
      binde = [
        "$mainMod CONTROL, up, resizeactive, 0 -20"
        "$mainMod CONTROL, down, resizeactive, 0 20"
        "$mainMod CONTROL, left, resizeactive, -20 0"
        "$mainMod CONTROL, right, resizeactive, 20 0"
      ];
      general = {
        "col.active_border" = "rgb(cba6f7) rgb(f38ba8) 45deg";
        "col.inactive_border" = "rgb(313244)";
        border_size = 2;
        gaps_in = 2.5;
        gaps_out = 7;
      };
      decoration = {
        rounding = 5;
        "col.shadow" = "rgb(11111b)";
        inactive_opacity = 0.9;
      };
      animations = {
        enabled = true;
        bezier = "myBezier, 0.05, 0.9, 0.1, 1.05";
        animation = [
          "windows, 1, 7, myBezier"
          "windowsOut, 1, 7, default, popin 80%"
          "border, 1, 10, default"
          "borderangle, 1, 8, default"
          "fade, 1, 7, default"
          "workspaces, 1, 6, default"
        ];
      };
      dwindle = {
        pseudotile = true;
        preserve_split = true;
      };
      master = {
        new_is_master = true;
      };
      misc = {
        enable_swallow = true;
        swallow_regex = "^(kitty)$";
        disable_hyprland_logo = true;
      };
    };
  };
  xdg.configFile."hypr/autostart.sh".source = ./autostart.sh;
  xdg.configFile."hypr/power.sh" = {
    executable = true;
    text = ''
      #!/usr/bin/env bash

      entries="⇠ Logout\n⏻ Shutdown\n⭮ Reboot"
      selected=$(echo -e $entries | anyrun --plugins ${anyrun-stdin} -c ~/.config/power-menu/ | awk '{print tolower($2)}')
      echo $selected

      case $selected in
        logout)
          hyprctl dispatch exit;;
        reboot)
          exec systemctl reboot;;
        shutdown)
          exec systemctl poweroff -i;;
        #sleep) nvidia drivers go brrr (they fuck you up)
        #  exec systemctl suspend;;
      esac
    '';
  };
  xdg.configFile."clipboard".source = ../clipboard;
  xdg.configFile."power-menu".source = ../power-menu;
}
