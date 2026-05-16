{ osConfig, ... }:
let
  theme = osConfig.modules.theme;
in {
  xdg.configFile."qs-shell/colors.json".text = builtins.toJSON {
    flavor = theme.flavor;
    accent = theme.accent;
  };
}
