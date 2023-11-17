{pkgs, ...}: {
  programs.firefox = {
    enable = true;
    package = pkgs.firefox-devedition;
  };
  home.file.".mozzila/user.js".source = ./user.js;
}
