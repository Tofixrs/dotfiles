{
  self,
  withSystem,
  ...
}: let
  inherit (self) inputs;
  inherit (self) lib;

  hm = inputs.home-manager.nixosModules.home-manager;
  age = inputs.agenix.nixosModules.default;

  modules = ../modules;
  coreModules = modules + /core;
  typeModules = coreModules + /types;

  laptop = typeModules + /laptop;
  # i suck at naming but this means my desktop vonfig like hyprland etc
  desktop = typeModules + /desktop;
  gaming = typeModules + /gaming;
  dev = typeModules + /dev;

  common = coreModules + /common;
  options = coreModules + /options;

  homesDir = ../homes;
  homes = [hm homesDir];

  shared = [
    common
    options
    age
  ];

  sharedArgs = {inherit inputs self lib;};
in {
  flake.nixosConfigurations = {
    tofipc = lib.builders.mkNixSystem {
      inherit withSystem;
      system = "x86_64-linux";
      modules =
        [
          {networking.hostName = "tofipc";}
          ./tofipc
          desktop
          gaming
        ]
        ++ lib.concatLists [shared homes];
      specialargs = sharedArgs;
    };
    lapfix = lib.builders.mkNixSystem {
      inherit withSystem;
      system = "x86_64-linux";
      modules =
        [
          {networking.hostName = "lapfix";}
          ./lapfix
          laptop
          desktop
          gaming
          dev
        ]
        ++ lib.concatLists [shared homes];
      specialargs = sharedArgs;
    };
  };
}
