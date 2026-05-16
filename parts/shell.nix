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
          text = ''
            # Check if there are any changes (tracked or untracked)
            if [ -n "$(git status --porcelain)" ]; then
              if [ "$#" -eq 0 ]; then
                echo "Error: Uncommitted changes detected, but no commit message provided."
                exit 1
              fi
              echo "Changes detected. Committing..."
              git add .
              git commit -m "$*"
            else
              echo "No changes to commit. Proceeding with rebuild..."
            fi

            sudo nixos-rebuild switch \
              --flake "git+file://$(pwd)?submodules=1#$(hostname)" \
              --show-trace
          '';
        })
        (pkgs.writeShellApplication {
          name = "clean";
          text = "sudo nix-collect-garbage -d && nix-collect-garbage -d";
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
