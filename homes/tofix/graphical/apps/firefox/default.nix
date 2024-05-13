_: {
  programs.firefox = {
    enable = true;
    profiles.default = {
      extraConfig = (import ./betterfoxjs.nix {}) + (import ./userjs.nix {});
    };
  };
  home.file.".mozilla/firefox/default/chrome".source = ./ArcWTF;
}
