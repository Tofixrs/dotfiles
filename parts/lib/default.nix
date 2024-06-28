{inputs, ...}: let
  inherit (inputs.nixpkgs) lib;

  extendedLib = lib.extend (self: _: {
    builders = import ./builders.nix {
      inherit inputs;
      lib = self;
    };
  });
in {
  perSystem = {
    imports = [{_module.args.lib = extendedLib;}];
  };
  flake.lib = extendedLib;
}
