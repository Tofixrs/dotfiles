_: {
  imports = [./polkit.nix ./syncthing.nix ./activitywatch.nix];
  services.kdeconnect = {
    enable = true;
    indicator = true;
  };
  services.arrpc.enable = true;
}
