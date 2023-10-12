{
  description = "System configuration";

  outputs = inputs @ {
    nixpkgs,
    home-manager,
    ...
  }: let
    system = "x86_64-linux";
    pkgs = nixpkgs.legacyPackages.${system};
    flake_path = "$HOME/dotfiles";
  in {
    nixosConfigurations = {
      tofipc = let
        host="tofipc";
      in nixpkgs.lib.nixosSystem {
        inherit system;
        specialArgs = {inherit inputs flake_path system host;};
        modules = [
          ./systems/${host}
        ];
      };
      lapfix = let 
        host = "lapfix";
      in nixpkgs.lib.nixosSystem {
        inherit system;
        specialArgs = {inherit inputs flake_path system host;};
        modules = [
          ./systems/${host}
        ];
      };
    };
    homeConfigurations = {
      tofix = home-manager.lib.homeManagerConfiguration {
        extraSpecialArgs = {inherit inputs flake_path system;};
        modules = [./users/tofix];
        pkgs = import nixpkgs {
          inherit system;
          config = {
            allowUnfree = true;
          };
          overlays = [(import ./packages)];
        };
      };
    };
    nixConfig = {
      substituters = [
        "https://hyprland.cachix.org"
        "https://anyrun.cachix.org"
        "https://cache.garnix.io"
      ];
      trusted-public-keys = [
        "anyrun.cachix.org-1:pqBobmOjI7nKlsUMV25u9QHa9btJK65/C8vnO3p346s="
        "hyprland.cachix.org-1:a7pgxzMz7+chwVL3/pzj6jIBMioiJM7ypFP8PwtkuGc="
        "cache.garnix.io:CTFPyKSLcx5RMJKfLo5EEPU0bbA78b0YQ2DTCJXqr9g="
      ];
    };
    formatter."${system}" = pkgs.alejandra;
  };

  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-unstable";
    home-manager = {
      url = "github:nix-community/home-manager";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    anyrun = {
      url = "github:Kirottu/anyrun";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    hyprland = {
      url = "github:hyprwm/hyprland";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    hyprland-contrib = {
      url = "github:hyprwm/contrib";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    spicetify-nix = {
      url = "github:the-argus/spicetify-nix";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    ags = {
      url = "github:Aylur/ags";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    getchoo = {
      url = "github:getchoo/nix-exprs";
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };
}
