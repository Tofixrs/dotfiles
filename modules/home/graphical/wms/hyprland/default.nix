{
  inputs',
  pkgs,
  lib,
  osConfig,
  config,
  ...
}: let
  env = osConfig.modules.usrEnv;
in {
  imports = [
    ./workspacerules.nix
    ./windowrules.nix
    ./binds.nix
    ./animations.nix
  ];

  config = lib.mkIf (env.desktop == "Hyprland") {
    wayland.windowManager.hyprland = {
      enable = true;
      configType = "lua";
      systemd.enable = false;
      package = inputs'.hyprland.packages.hyprland;
      portalPackage = inputs'.hyprland.packages.xdg-desktop-portal-hyprland;
      systemd.variables = ["--all"];
      extraConfig = ''
        dofile("${config.xdg.configHome}/hypr/hyprland_monitor.lua")
      '';
      settings = {
        config = [
          {
            binds.scroll_event_delay = 0;
            input = {
              kb_layout = "pl";
              numlock_by_default = true; #why the FUCK isnt this on by default
              touchpad.natural_scroll = true;
            };
            gestures = {
              workspace_swipe_create_new = true;
              workspace_swipe_forever = true;
            };
            general = {
              "col.active_border" = {
                colors = ["rgb(cba6f7)" "rgb(f38ba8)"];
                angle = 45;
              };
              "col.inactive_border" = "rgb(313244)";
              border_size = 2;
              gaps_in = 2.5;
              gaps_out = 7;
              layout = "scrolling";
            };
            decoration = {
              rounding = 5;
              shadow = {
                color = "rgb(11111b)";
              };
              inactive_opacity = 0.9;
            };
            misc = {
              disable_hyprland_logo = true;
              vrr = 1;
              mouse_move_enables_dpms = true;
              key_press_enables_dpms = true;
            };
            debug = {
              disable_logs = false;
            };
            cursor = {
              no_hardware_cursors = true;
            };
          }
        ];
      };
    };
  };
}
