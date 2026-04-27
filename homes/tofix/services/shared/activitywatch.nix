{lib, pkgs, ...}: let
  waitForServer = pkgs.writeShellScript "activitywatch-wait-for-server" ''
    for _ in $(seq 1 30); do
      if ${lib.getExe pkgs.curl} -fsS http://127.0.0.1:5600/api/0/info >/dev/null; then
        exit 0
      fi
      sleep 1
    done

    echo "ActivityWatch server did not become ready in time" >&2
    exit 1
  '';
in {
  services.activitywatch = {
    enable = true;
    package = pkgs.activitywatch;
    watchers = {
      aw-watcher-afk.package = pkgs.aw-watcher-afk;
      aw-watcher-window-wayland.package = pkgs.aw-watcher-window-wayland;
    };
  };

  systemd.user.services.activitywatch-watcher-aw-watcher-afk = {
    Unit.After = ["graphical-session.target"];

    Service = {
      ExecStartPre = waitForServer;
      Restart = "always";
      RestartSec = 5;
    };
  };

  systemd.user.services.activitywatch-watcher-aw-watcher-window-wayland = {
    Unit.After = ["graphical-session.target"];

    Service = {
      ExecStartPre = waitForServer;
      Restart = "always";
      RestartSec = 5;
    };
  };
}
