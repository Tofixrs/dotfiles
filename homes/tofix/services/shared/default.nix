_: {
  imports = [./polkit.nix ./syncthing.nix];
  services.kdeconnect = {
    enable = true;
    indicator = true;
  };
}
