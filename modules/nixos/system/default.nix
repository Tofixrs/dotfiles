_: {
  imports = [
    ./hardware
    ./boot
    ./display
    ./env
    ./networking
    ./security
    
    ./fs.nix
    ./nix.nix
    ./overlays.nix
    ./programs.nix
    ./services.nix
    ./swap.nix
    ./users.nix
    ./virtualization.nix
  ];
}
