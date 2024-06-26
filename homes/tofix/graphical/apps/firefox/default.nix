{pkgs, ...}: let
  profile-name = "dev-edition-default";
in {
  programs.firefox = {
    enable = true;
    profiles."${profile-name}" = {
      extraConfig = (import ./betterfoxjs.nix {}) + (import ./userjs.nix {});
    };
    package = pkgs.firefox-devedition;
  };
  home.file.".mozilla/firefox/${profile-name}/chrome".source = ./ArcWTF;
}
