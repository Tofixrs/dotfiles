{
  inputs,
  pkgs,
  ...
}: let
  spicePkgs = inputs.spicetify-nix.packages.${pkgs.system}.default;
  beautiful-lyrics-src = pkgs.fetchFromGitHub {
    owner = "surfbryce";
    repo = "beautiful-lyrics";
    rev = "3f4cfdc05c8217d37f041cc09f30376c2af27612";
    hash = "sha256-K01zSEL/t8RxbDdWI/2oGaZh0Wi5fbJXyIPAIh17GJ4=";
  };
  beautiful-lyrics = {
    src = "${beautiful-lyrics-src}/Builds/Release";
    filename = "beautiful-lyrics.mjs";
  };
in {
  imports = [inputs.spicetify-nix.homeManagerModule];

  programs.spicetify = {
    enable = true;
    theme = spicePkgs.themes.catppuccin;
    colorScheme = "mocha";
    enabledExtensions = with spicePkgs.extensions; [
      hidePodcasts
      shuffle
      adblock
      playlistIcons
      lastfm
      historyShortcut
      bookmark
      fullAlbumDate
      groupSession
      popupLyrics
      beautiful-lyrics
    ];
  };
}
