_: {
  imports = [
    ./boot
    ./fs.nix
    ./services.nix
    ./secutiy
    ./env
    ./users.nix
    ./programs.nix
    ./display
    ./nix.nix
  ];

  networking.networkmanager.enable = true;
}
