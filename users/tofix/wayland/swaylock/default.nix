{pkgs, ...}: {
  home.packages = with pkgs; [
    swaylock-effects
  ];
  xdg.configFile."swaylock/config".source = ./swaylock;
  home.file."screen-lock.jpg".source = ./screen-lock.jpg;
}
