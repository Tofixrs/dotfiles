{
  config,
  osConfig,
  ...
}: let
  theme = osConfig.modules.theme;
  palette = config.colorScheme.palette;

  # Map accents to base16 colors where possible, otherwise use base0E (Mauve) as fallback
  accentMap = {
    rosewater = palette.base06;
    flamingo = palette.base0F;
    pink = palette.base0E; # Catppuccin base16 often uses base0E for both pink/mauve
    mauve = palette.base0E;
    red = palette.base08;
    maroon = palette.base0F;
    peach = palette.base09;
    yellow = palette.base0A;
    green = palette.base0B;
    teal = palette.base0C;
    sky = palette.base0D;
    sapphire = palette.base0D;
    blue = palette.base0D;
    lavender = palette.base07;
  };

  accentHex = "#${accentMap.${theme.accent} or palette.base0E}";

  crusts = {
    latte = "#dce0e8";
    frappe = "#232634";
    macchiato = "#181926";
    mocha = "#11111b";
  };
  crust = crusts.${theme.flavor} or "#11111b";
in {
  programs.qs-config = {
    enable = true;
    colors = {
      background = "#${palette.base00}";
      foreground = "#${palette.base01}";
      foreground2 = crust;
      inactive = "#${palette.base04}";
      accent = accentHex;
      accept = "#${palette.base0B}";
      deny = "#${palette.base08}";
      active = "#${palette.base0D}";
      hover = "#${palette.base02}";
      text = "#${palette.base05}";
    };
  };
}
