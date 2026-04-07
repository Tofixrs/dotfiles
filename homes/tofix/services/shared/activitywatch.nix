{pkgs, ...}: {
  services.activitywatch = {
    enable = true;
    package = pkgs.activitywatch;
    watchers = {
      awatcher.package = pkgs.awatcher;
    };
  };
}
