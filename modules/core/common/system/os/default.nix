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
  ];

  networking.networkmanager.enable = true;
}
