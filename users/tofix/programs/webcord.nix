{
  pkgs,
  lib,
  ...
}: let
  catppuccin-mocha = pkgs.fetchFromGitHub {
    owner = "catppuccin";
    repo = "discord";
    rev = "c04f4bd43e571c19551e0e5da2d534408438564c";
    hash = "sha256-3uEVrR2T39Pj0puUwUPuUfXcCPoOq2lNHL8UpppTOiU=";
  };
  # dark-matter = pkgs.fetchFromGitHub {
  #   owner = "DiscordStyles";
  #   repo = "DarkMatter";
  #   rev = "6678a3fb642c94a6f194202255f3fe73b2a829e9";
  #   hash = "sha256-RunuOehHyT+HlC+ggabv+B6WOaolN9l56Q8W8X3My7Q=";
  # };
in {
  home.packages = with pkgs; [
    webcord-vencord # webcord with vencord extension installed
  ];

  xdg.configFile = {
    "WebCord/Themes/DarkMatter" = {
      source = "${catppuccin-mocha}/themes/mocha.theme.css";
      # source = "${dark-matter}/DarkMatter.theme.css";
    };

    # # share my webcord configuration across devices
    # This shit doesnt work lulz
    # "WebCord/config.json".source = ./vencord.json;
  };
}
