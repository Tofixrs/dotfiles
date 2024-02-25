_: {
  systems = [
    "x86_64-linux"
  ];

  perSystem = {pkgs, ...}: {
    packages = {
      astronvim = pkgs.callPackage ./astronvim {};
      warp-term-linux = pkgs.callPackage ./warp-term-linux.nix {}; # till this gets merged https://github.com/NixOS/nixpkgs/pull/290731
    };
  };
}
