{
  osConfig,
  pkgs,
  lib,
  ...
}: let
  env = osConfig.modules.usrEnv;

  dpmsOnCommand =
    if env.desktop == "Hyprland"
    then "timeout 300 'hyprctl dispatch dpms on' \\"
    else "";
  dpmsOffCommand =
    if env.desktop == "Hyprland"
    then "after-resume 'hyprctl dispatch dpms off' \\"
    else "";

  sleep =
    if osConfig.networking.hostName != "tofipc"
    then "timeout 400 'systemctl suspend' \\"
    else "";
in {
  config = lib.mkIf (env.isWayland) {
    systemd.user.services.swayidle = {
      Unit.description = "Idle";
      Service = {
        ExecStart = ''          ${lib.getExe pkgs.swayidle} -w \
          timeout 150 'swaylock -f' \
          ${dpmsOnCommand}
          ${sleep}
          ${dpmsOffCommand}
          before-sleep 'swaylock -f'
        '';
        Restart = "always";
      };
      Unit = {
        PartOf = ["graphical-session.target"];
        After = ["graphical-session.target"];
      };
      Install.WantedBy = ["graphical-session.target"];
    };
    home.packages = with pkgs; [
      swayidle
      swaylock-effects
    ];
  };
}
