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
  mkIso = {
    modules,
    system,
    ...
  } @ args:
    lib.nixosSystem {
      inherit system;
      specialArgs = {inherit inputs lib self;} // args.specialArgs or {};
      modules =
        [
          "${self.nixpkgs}/nixos/modules/installer/cd-dvd/installation-cd-minimal.nix"
          "${self.nixpkgs}/nixos/modules/installer/cd-dvd/channel.nix"
        ]
        ++ args.modules or [];
    };
}
