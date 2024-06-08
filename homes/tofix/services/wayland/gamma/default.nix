{
  osConfig,
  pkgs,
  lib,
  inputs',
  ...
}: let
  inherit (lib) mkIf;
  env = osConfig.modules.usrEnv;
  shader = ./blue-light-filter.glsl;
in {
  config = mkIf (env.desktop == "Hyprland") {
    systemd.user.services = {
      hyprshade = {
        Service = {
          ExecStart = "${pkgs.writeShellScript "gamma.sh" ''
            hour=`date +%-H`

            if ((hour >= 22)); then
              hyprctl keyword decoration:screen_shader ${shader}
            fi

            if ((hour >= 6 && hour < 22)); then
              hyprctl keyword decoration:screen_shader ""
            fi;
          ''}";
          Type = "oneshot";
          Environment = "PATH=$PATH:${lib.makeBinPath [inputs'.hyprland.packages.hyprland]}:/run/current-system/sw/bin/";
        };
        Unit = {
          Description = "Apply screen filter";
          PartOf = ["graphical-session.target"];
          After = ["graphical-session.target"];
        };
        Install.WantedBy = ["graphical-session.target"];
      };
    };
    systemd.user.timers = {
      hyprshade = {
        Unit = {
          Description = "Apply screen filter on schedule";
        };
        Timer = {
          OnCalendar = [
            "*-*-* 6:0:0"
            "*-*-* 22:0:0"
          ];
          Persistent = true;
        };
        Install.WantedBy = ["timers.target"];
      };
    };
  };
}
