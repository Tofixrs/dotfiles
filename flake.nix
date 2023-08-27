{
  description = "System configuration";

  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-unstable";
    home-manager = {
      url = "github:nix-community/home-manager";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    hyprland.url = "github:hyprwm/Hyprland";
    anyrun = {
      url = "github:Kirottu/anyrun";
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
  };

  outputs = inputs @ {
    nixpkgs,
    home-manager,
    ...
  }: let
    system = "x86_64-linux";
    pkgs = nixpkgs.legacyPackages.${system};
    flake_path = "~/dotfiles";
  in {
    nixosConfigurations = {
      tofipc = nixpkgs.lib.nixosSystem {
        inherit system;
        specialArgs = {inherit inputs flake_path system;};
        modules = [
          ./systems/pc
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
    formatter."${system}" = pkgs.alejandra;
  };
}
