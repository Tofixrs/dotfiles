_: {
  perSystem = {pkgs, ...}: {
    packages = {
      bt-dualboot = pkgs.callPackage ./bt-dualboot.nix {};
      legcord = pkgs.callPackage ./legcord.nix {};
    };
  };
}
