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
        resumeCommand = "${hyprctl} dispatch on";
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
      extraArgs = ["-w"];
      events = [
        {
          event = "before-sleep";
          command = "${pkgs.systemd}/bin/loginctl lock-session";
        }
        {
          event = "lock";
          command = "${pkgs.swaylock-effects}";
        }
      ];
      timeouts =
        [
          {
            timeout = 150;
            command = "${pkgs.swaylock-effects}";
          }
        ]
        ++ dpms
        ++ sleep;
    };
  };
}
