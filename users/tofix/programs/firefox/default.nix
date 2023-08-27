{pkgs, ...}: {
  home.packages = with pkgs; [
    firefox
  ];
  home.file.".mozilla/user.js".source = ./user.js;
}
