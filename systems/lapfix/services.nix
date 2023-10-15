_: {
  services.btrfs.autoScrub = {
    enable = true;
    interval = "monthly";
  };
  services.upower = {
    enable = true;
    percentageCritical = 5;
    percentageLow = 15;
  };
}
