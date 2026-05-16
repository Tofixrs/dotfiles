{ inputs, osConfig, ... }:
let
  theme = osConfig.modules.theme;
in {
  imports = [ ./gtk.nix ./qt.nix inputs.nix-colors.homeManagerModules.default ];
  colorScheme = inputs.nix-colors.colorSchemes."catppuccin-${theme.flavor}";
}
