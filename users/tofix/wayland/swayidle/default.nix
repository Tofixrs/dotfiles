{pkgs, ...}: {
  home.packages = with pkgs; [
    swayidle
  ];
  xdg.configFile."swayidle".source = ./swayidle;
}
