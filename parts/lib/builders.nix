{
  lib,
  inputs,
  ...
}: let
  inherit (inputs) self;
in {
  mkNixSystem = {
    modules,
    system,
    withSystem,
    ...
  } @ args:
    withSystem system ({
      inputs',
      self',
      ...
    }:
      lib.nixosSystem {
        inherit modules system;
        specialArgs = {inherit lib inputs self inputs' self';} // args.specialArgs or {};
      });
}
