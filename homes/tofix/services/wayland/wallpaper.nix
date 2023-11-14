{
  pkgs,
  lib,
  osConfig,
  ...
}: let
  swww = lib.getExe pkgs.swww;
in {
  config = lib.mkIf (osConfig.modules.usrEnv.isWayland) {
    systemd.user.services.swww = {
      Unit.Description = "Wallpaper";
      Service = {
        ExecStart = "sleep 3 && ${swww} init && ${swww} img /home/tofix/Pictures/Wallpapers/astro_catpuccin-mocha.png";
        Restart = "always";
      };
      Unit.PartOf = ["graphical-session.target"];
      Unit.After = ["graphical-session.target"];
      Install.WantedBy = ["graphical-session.target"];
    };

    home.packages = [
      pkgs.swww
    ];
  };
}
