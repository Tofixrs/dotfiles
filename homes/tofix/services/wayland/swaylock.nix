{
  pkgs,
  config,
  ...
}: {
  programs.swaylock = let
    inherit (config.colorscheme) palette;
  in {
    enable = true;
    package = with pkgs; swaylock-effects;
    settings = {
      clock = true;
      color = "${palette.base00}";
      font = "JetBrainsMono Nerd Font";
      show-failed-attempts = true;
      indicator = true;
      indicator-radius = 200;
      indicator-thickness = 20;
      line-color = "${palette.base00}";
      ring-color = "${palette.base04}";
      inside-color = "${palette.base00}";
      key-hl-color = "${palette.base0F}";
      separator-color = "00000000";
      text-color = "${palette.base05}";
      text-caps-lock-color = "";
      line-ver-color = "${palette.base0F}";
      ring-ver-color = "${palette.base0F}";
      inside-ver-color = "${palette.base00}";
      text-ver-color = "${palette.base05}";
      ring-wrong-color = "${palette.base08}";
      text-wrong-color = "${palette.base08}";
      inside-wrong-color = "${palette.base00}";
      inside-clear-color = "${palette.base00}";
      text-clear-color = "${palette.base05}";
      ring-clear-color = "${palette.base0B}";
      line-clear-color = "${palette.base00}";
      line-wrong-color = "${palette.base00}";
      bs-hl-color = "${palette.base08}";
      line-uses-ring = false;
      datestr = "%d/%m/%Y";
      fade-in = "0.1";
      ignore-empty-password = true;
    };
  };
}
