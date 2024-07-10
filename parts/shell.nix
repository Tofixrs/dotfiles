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
        inputs'.agenix.packages.default
      ];
    };
  };
}
