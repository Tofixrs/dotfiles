{
  self,
  lib,
  withSystem,
  ...
}: let
  inherit (self) inputs;

  hm = inputs.home-manager.nixosModules.home-manager;

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
  ];

  sharedArgs = {inherit inputs self lib;};
in {
  tofipc = lib.mkNixSystem {
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
  lapfix = lib.mkNixSystem {
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
}
