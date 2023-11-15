# Too yeet in the future in favor of ags
{
  pkgs,
  lib,
  osConfig,
  ...
}: {
  config = lib.mkIf (osConfig.modules.usrEnv.isWayland) {
    home.packages = with pkgs; [
      swaynotificationcenter
    ];
    xdg.configFile."swaync/config.json".source = ./config.json;
    xdg.configFile."swaync/style.css".source = ./style.css;
  };
}
