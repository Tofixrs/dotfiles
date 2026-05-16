{
  self,
  withSystem,
  ...
}: let
  inherit (self) inputs lib;

  nixosModules = ../modules/nixos;
  profiles = nixosModules + /profiles;
  
  # Helper to create a system with common modules
  mkHost = {
    name,
    system ? "x86_64-linux",
    extraModules ? [],
  }: lib.builders.mkNixSystem {
    inherit withSystem system;
    modules = [
      { networking.hostName = name; }
      ./${name}
      nixosModules
      ../modules/options
      inputs.agenix.nixosModules.default
      inputs.home-manager.nixosModules.home-manager
      ../homes
    ] ++ extraModules;
    specialArgs = { inherit inputs self lib; };
  };
in {
  flake.nixosConfigurations = {
    tofipc = mkHost {
      name = "tofipc";
      extraModules = [
        profiles/desktop
        profiles/gaming
      ];
    };
    lapfix = mkHost {
      name = "lapfix";
      extraModules = [
        profiles/laptop
        profiles/desktop
        profiles/gaming
        profiles/dev
      ];
    };
  };
}
