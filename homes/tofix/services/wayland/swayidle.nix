{
  osConfig,
  pkgs,
  lib,
  ...
}: let
  sleep =
    if osConfig.networking.hostName != "tofipc"
    then [
      {
        timeout = 400;
        command = "${pkgs.systemd}/bin/systemctl suspend";
      }
    ]
    else [];
  lockCommand =
    if osConfig.modules.usrEnv.screenLocker == "hyprlock"
    then "${lib.getExe pkgs.hyprlock}"
    else "${lib.getExe pkgs.swaylock} -f";
in {
  systemd.user.services.swayidle.Install.WantedBy = lib.mkForce ["hyprland-session.target"];
  services.swayidle = {
    enable = true;
    extraArgs = ["-d"];
    events = [
      {
        event = "before-sleep";
        command = "${pkgs.systemd}/bin/loginctl lock-session";
      }
      {
        event = "lock";
        command = lockCommand;
      }
    ];
    timeouts =
      [
        {
          timeout = 150;
          command = lockCommand;
        }
      ]
      ++ sleep;
  };
}
