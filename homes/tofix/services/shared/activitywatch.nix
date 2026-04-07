{pkgs, ...}: {
  services.activitywatch = {
    enable = true;
    package = pkgs.activitywatch;
    watchers = {
      aw-watcher-afk.package = pkgs.activitywatch;
      aw-watcher-window = {
        package = pkgs.activitywatch;
        settings = {
          poll_time = 1;
          exclude_title = false;
        };
      };
    };
  };
}
