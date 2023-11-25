{
  osConfig,
  pkgs,
  lib,
  config,
  ...
}: let
  env = osConfig.modules.usrEnv;
  hyprctl = "${config.wayland.windowManager.hyprland.package}/bin/hyprctl";
  dpms =
    if env.desktop == "Hyprland"
    then [
      {
        timeout = 300;
        command = "${hyprctl} dispatch dpms off";
        resumeCommand = "${hyprctl} dispatch dpms on";
      }
    ]
    else [];

  sleep =
    if osConfig.networking.hostName != "tofipc"
    then [
      {
        timeout = 400;
        command = "${pkgs.systemd}/bin/systemctl suspend";
      }
    ]
    else [];
in {
  config = lib.mkIf (env.isWayland) {
    systemd.user.services.swayidle.Install.WantedBy = lib.mkForce ["hyprland-session.target"];
    services.swayidle = {
      enable = true;
      extraArgs = ["-w" "-d"];
      events = [
        {
          event = "before-sleep";
          command = "${pkgs.systemd}/bin/loginctl lock-session";
        }
        {
          event = "lock";
          command = "${lib.getExe pkgs.swaylock-effects} -f";
        }
      ];
      timeouts =
        [
          {
            timeout = 150;
            command = "${lib.getExe pkgs.swaylock-effects} -f";
          }
        ]
        ++ dpms
        ++ sleep;
    };
  };
}
