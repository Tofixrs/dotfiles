{
  config,
  lib,
  inputs',
  ...
}: let
  inherit (lib) mkIf;
  sys = config.modules.system;
  env = config.modules.usrEnv;
in {
  config = mkIf (env.desktop == "Hyprland" && env.isWayland) {
    xdg.portal.extraPortals = [
      inputs'.xdg-portal.hyprland.packages.xdg-desktop-portal-hyprland
    ];
  };
}
