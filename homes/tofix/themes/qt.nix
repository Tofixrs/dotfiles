{pkgs, ...}: {
  qt = {
    enable = true;
    platformTheme.name = "qtct";
  };
  home = {
    packages = with pkgs; [
      libsForQt5.qtstyleplugin-kvantum
      #nixpkgs for fuck sake PLEASE ass a naming convention for you packages why isnt this libForQt6.[...] but fucking kdePackages.[...]
      kdePackages.qtstyleplugin-kvantum
    ];
  };
  xdg.configFile.qt6ct.source = ./qt6ct;
  xdg.configFile.qt5ct.source = ./qt5ct;
}
