{pkgs, ...}: let
  profile-name = "default";
in {
  programs.firefox = {
    enable = true;
    profiles."${profile-name}" = {
      extraConfig = (import ./betterfoxjs.nix {}) + (import ./userjs.nix {});
    };
    package = pkgs.firefox;
    nativeMessagingHosts = [pkgs.kdePackages.plasma-browser-integration];
  };
  home.file.".mozilla/firefox/${profile-name}/chrome".source = ./ArcWTF;
}
