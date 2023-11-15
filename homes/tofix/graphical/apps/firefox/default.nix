{pkgs, ...}: {
  home.packages = with pkgs; [
    firefox
  ];
  home.file.".mozzila/user.js".source = ./user.js;
}
