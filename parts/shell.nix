{
  perSystem = {
    pkgs,
    inputs',
    ...
  }: {
    devShells.default = pkgs.mkShellNoCC {
      name = "dotfiles";
      packages = [
        (pkgs.writeShellApplication {
          name = "switch";
          text = ''sudo nixos-rebuild switch --flake "git+file://$(pwd)?submodules=1#lapfix" --show-trace'';
        })
        (pkgs.writeShellApplication {
          name = "clean";
          text = ''sudo nix-collect-garbage -d && nix-collect-garbage -d'';
        })
        (pkgs.writeShellApplication {
          name = "print-roots";
          text = ''nix-store --gc --print-roots | grep -E "$(hostname)|home-manager" | column -t | sort -k3 -k1'';
        })

        inputs'.agenix.packages.default
      ];
    };
  };
}
