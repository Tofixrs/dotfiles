{
  pkgs,
  inputs',
  lib,
  ...
}: {
  home.packages = [
    (import ./screenshot.nix {inherit pkgs inputs' lib;})
  ];
}
