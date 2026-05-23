{
  description = "Description for the project";

  outputs = inputs @ {
    self,
    flake-parts,
    ...
  }:
    flake-parts.lib.mkFlake {inherit inputs;} (_: {
      imports = [
        {config._module.args._inputs = inputs // {inherit (inputs) self;};}
        inputs.flake-parts.flakeModules.easyOverlay
        ./parts
        ./hosts
      ];
      systems = ["x86_64-linux"];
    });

  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-unstable";
    ua-pl-phonetic = {
      url = "github:Tofixrs/ua-pl-phonetic";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    flake-parts = {
      url = "github:hercules-ci/flake-parts";
      inputs.nixpkgs-lib.follows = "nixpkgs";
    };

    home-manager = {
      url = "github:nix-community/home-manager";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    nix-gaming = {
      url = "github:fufexan/nix-gaming";
    };

    hyprland = {
      url = "github:hyprwm/Hyprland";
    };

    hyprpicker = {
      url = "github:hyprwm/hyprpicker";
    };
    hyprsunset.url = "github:/hyprwm/hyprsunset";

    nix-colors = {
      url = "github:Misterio77/nix-colors";
    };

    spicetify-nix = {
      url = "github:Gerg-L/spicetify-nix";
    };

    hyprland-contrib = {
      url = "github:hyprwm/contrib";
    };

    anyrun.url = "github:Kirottu/anyrun";
    neovim-flake = {
      url = "github:notashelf/neovim-flake";
      inputs = {
        flake-parts.follows = "flake-parts";
      };
    };
    agenix = {
      url = "github:ryantm/agenix";
      inputs = {
        home-manager.follows = "home-manager";
      };
    };
    SMGui.url = "github:/Tofixrs/SMLayoutEditor";
    zen-browser = {
      url = "github:0xc000022070/zen-browser-flake";
    };
    quickshell.follows = "qs-config/quickshell";
    qs-config = {
      url = "github:Tofixrs/qs-config";
    };
    lanzaboote = {
      url = "github:nix-community/lanzaboote/v1.0.0";
    };
    bash-env-nushell = {
      url = "github:tesujimath/bash-env-nushell";
    };
    bash-env-json = {
      url = "github:tesujimath/bash-env-json";
    };
  };

  nixConfig = let
    caches = import ./modules/nixos/system/nix/caches.nix;
  in {
    extra-substituters = caches.substituters;
    extra-trusted-public-keys = caches.trusted-public-keys;
  };
}
