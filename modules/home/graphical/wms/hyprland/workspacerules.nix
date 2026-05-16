{
  lib,
  osConfig,
  ...
}: let
  env = osConfig.modules.usrEnv;
in {
  config = lib.mkIf (env.desktop == "Hyprland") {
    wayland.windowManager.hyprland.settings.workspace_rule = [
      {
        workspace = "1";
        persistent = true;
        monitor = "eDP-1";
        default = true;
      }
      {
        workspace = "2";
        persistent = true;
        monitor = "HDMI-A-1";
        default = true;
      }
    ];
  };
}
