{inputs, ...}: {
  imports = [./gtk.nix ./qt.nix inputs.nix-colors.homeManagerModules.default];
  colorScheme = inputs.nix-colors.colorSchemes.catppuccin-mocha;
}
