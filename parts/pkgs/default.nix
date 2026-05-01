_: {
  perSystem = {pkgs, ...}: {
    packages = {
      bt-dualboot = pkgs.callPackage ./bt-dualboot.nix {};
    };
  };
}
