{
  lib,
  pkgs,
  ...
}: let
  syncOnAc = pkgs.writeShellScript "syncthing-ac-state.sh" ''
    ac_state="$(cat /sys/class/power_supply/ACAD/online 2>/dev/null || echo 0)"

    if [ "$ac_state" = "1" ]; then
      systemctl --user start syncthing.service
    else
      systemctl --user stop syncthing.service
    fi
  '';
  syncNow = pkgs.writeShellApplication {
    name = "sync-now";
    text = ''
      systemctl --user start syncthing.service
      systemctl --user status --no-pager syncthing.service
    '';
  };
in {
  services.syncthing = {
    enable = true;
  };

  home.packages = [syncNow];

  systemd.user.services.syncthing.Install.WantedBy = lib.mkForce [];

  systemd.user.services.syncthing-ac-state = {
    Unit = {
      Description = "Start Syncthing on AC and stop it on battery";
      After = ["graphical-session.target"];
      PartOf = ["graphical-session.target"];
    };
    Service = {
      Type = "oneshot";
      ExecStart = syncOnAc;
    };
    Install.WantedBy = ["graphical-session.target"];
  };

  systemd.user.timers.syncthing-ac-state = {
    Unit.Description = "Periodically sync Syncthing state with AC power";
    Timer = {
      OnBootSec = "30s";
      OnUnitActiveSec = "2m";
      Unit = "syncthing-ac-state.service";
    };
    Install.WantedBy = ["timers.target"];
  };
}
