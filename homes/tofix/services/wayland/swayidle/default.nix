{
  osConfig,
  pkgs,
  lib,
  ...
}: let
  env = osConfig.modules.usrEnv;

  swaylock-cmd = "${lib.getExe pkgs.swaylock} -f --show-failed-attempts --indicator --indicator-radius=200 --clock --effect-blur=10x0.2";

  dpmsOnCommand =
    if env.desktop == "Hyprland"
    then "timeout 300 'hyprctl dispatch dpms on' \\\\"
    else "";
  dpmsOffCommand =
    if env.desktop == "Hyprland"
    then "resume 'hyprctl dispatch dpms off' \\\\"
    else "";

  sleep =
    if osConfig.networking.hostName != "tofipc"
    then "timeout 400 'systemctl suspend' \\\\"
    else "";

  config = pkgs.writeText "config" ''
    timeout 150 '${swaylock-cmd}' \\
    ${dpmsOnCommand}
    ${sleep}
    before-sleep '${swaylock-cmd};
    ${dpmsOffCommand}
  '';
in {
  config = lib.mkIf (env.isWayland) {
    systemd.user.services.swayidle = {
      Unit.description = "Idle";
      Service = {
        ExecStart = "${lib.getExe pkgs.swayidle} -w -C ${config}";
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
      swaylock
    ];
  };
}
