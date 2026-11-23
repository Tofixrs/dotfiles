_: {
  imports = [./polkit.nix ./syncthing.nix];
  services.ssh-agent.enable = true;
  services.kdeconnect = {
    enable = true;
    indicator = true;
  };
  services.arrpc.enable = false;
}
