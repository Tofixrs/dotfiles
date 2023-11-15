{
  config,
  lib,
  inputs',
  ...
}: let
  inherit (lib) mkIf;
  env = config.modules.usrEnv;
in {
  disabledModules = ["programs/hyprland.nix"];
  config = mkIf (env.desktop == "Hyprland" && env.isWayland) {
    xdg.portal.extraPortals = [
      inputs'.xdg-portal-hyprland.packages.xdg-desktop-portal-hyprland
    ];
  };
}
