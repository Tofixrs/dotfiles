{pkgs, ...}: {
  programs.firefox = {
    enable = true;
    package = pkgs.floorp;
  };
  home.file.".mozzila/user.js".source = ./user.js;
}
