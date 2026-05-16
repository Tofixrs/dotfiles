_: {
  imports = [./pkgs.nix ./vars.nix ./locale.nix];

  services.udev.extraRules = ''
    SUBSYSTEM=="misc", KERNEL=="uinput", MODE="0666"
  '';
}
