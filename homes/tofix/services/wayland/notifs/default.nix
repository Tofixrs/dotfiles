# Too yeet in the future in favor of ags
{
  pkgs,
  lib,
  osConfig,
  ...
}: {
  config = lib.mkIf (osConfig.modules.usrEnv.isWayland) {
    systemd.user.services.notification = {
      Unit.description = "Notifs";
      Service = {
        ExecStart = "${lib.getExe pkgs.swaynotificationcenter}";
        Restart = "always";
      };
      Unit = {
        PartOf = ["graphical-session.target"];
        After = ["graphical-session.target"];
      };
      Install.WantedBy = ["graphical-session.target"];
    };
    home.packages = with pkgs; [
      swaynotificationcenter
    ];
    xdg.configFile."swaync/config.json".source = ./config.json;
    xdg.configFile."swaync/style.css".source = ./style.css;
  };
}
