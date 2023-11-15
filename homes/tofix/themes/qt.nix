{pkgs, ...}: {
  qt.enable = true;
  home.packages = with pkgs; [
    libsForQt5.qtstyleplugin-kvantum
  ];
  home.sessionVariables = {QT_STYLE_OVERRIDE = "kvantum";};
}
