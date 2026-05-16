{
  config,
  lib,
  inputs',
  ...
}: let
  inherit (lib) mkIf;
  env = config.modules.usrEnv;
in {
  config = mkIf (env.desktop == "Hyprland" && env.isWayland) {
    programs.hyprland = {
      withUWSM = true;
      enable = true;
      package = inputs'.hyprland.packages.hyprland;
      portalPackage = inputs'.hyprland.packages.xdg-desktop-portal-hyprland;
    };
  };
}
