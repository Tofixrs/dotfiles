{
  inputs',
  pkgs,
  lib,
  osConfig,
  ...
}: let
  sys_monitor =
    if osConfig.networking.hostName == "lapfix"
    then ["eDP-1,1920x1080@144,0x0,1,vrr,1"]
    else [];
  binds = import ./binds.nix {
    inherit inputs' lib pkgs osConfig;
  };
  env = osConfig.modules.usrEnv;
in {
  config = lib.mkIf (env.desktop == "Hyprland") {
    wayland.windowManager.hyprland = {
      enable = true;
      systemd.enable = false;
      package = inputs'.hyprland.packages.hyprland;
      settings = {
        "$mainMod" = "SUPER";
        inherit binds;
        windowrulev2 = import ./windowrules.nix;
        exec-once = import ./autostart.nix {inherit inputs' lib;};
        workspace = import ./workspacerules.nix;
        monitor = sys_monitor;
        input = {
          kb_layout = "pl";
          numlock_by_default = true; #why the FUCK isnt this on by default
          touchpad.natural_scroll = true;
        };
        layerrule = [
          "blur,desktop-top"
        ];
        gestures = {
          workspace_swipe = true;
          workspace_swipe_create_new = true;
          workspace_swipe_forever = true;
        };
        general = {
          "col.active_border" = "rgb(cba6f7) rgb(f38ba8) 45deg";
          "col.inactive_border" = "rgb(313244)";
          border_size = 2;
          gaps_in = 2.5;
          gaps_out = 7;
        };
        decoration = {
          rounding = 5;
          shadow = {
            color = "rgb(11111b)";
          };
          inactive_opacity = 0.9;
        };
        animations = {
          enabled = true;
          bezier = [
            "md3_standard, 0.2, 0, 0, 1"
            "md3_decel, 0.05, 0.7, 0.1, 1"
            "md3_accel, 0.3, 0, 0.8, 0.15"
            "overshot, 0.05, 0.9, 0.1, 1.1"
            "crazyshot, 0.1, 1.5, 0.76, 0.92 "
            "hyprnostretch, 0.05, 0.9, 0.1, 1.0"
            "fluent_decel, 0.1, 1, 0, 1"
            "easeInOutCirc, 0.85, 0, 0.15, 1"
            "easeOutCirc, 0, 0.55, 0.45, 1"
          ];
          animation = [
            "windows, 1, 3, md3_decel, popin 60%"
            "border, 1, 10, default"
            "fade, 1, 2, default"
            "workspaces, 1, 3.5, md3_decel, slide"
            "specialWorkspace, 1, 3, md3_decel, slidefadevert 15%"
          ];
        };
        dwindle = {
          pseudotile = true;
          preserve_split = true;
        };
        master = {
          new_status = "master";
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
      };
    };
  };
}
