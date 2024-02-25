{self', ...}: {
  home.packages = [
    self'.packages.warp-term-linux
  ];
  xdg.dataFile."warp-terminal/themes".source = ./themes;
}
