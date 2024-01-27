_: {
  systems = [
    "x86_64-linux"
  ];

  perSystem = {pkgs, ...}: {
    packages = {
      astronvim = pkgs.callPackage ./astronvim {};
      vinegar = pkgs.callPackage ./vinegar.nix {};
    };
  };
}
