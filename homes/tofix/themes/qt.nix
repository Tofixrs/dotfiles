{pkgs, ...}: {
  qt.enable = true;
  home.packages = with pkgs; [
    libsForQt5.qtstyleplugin-kvantum
    #nixpkgs for fuck sake PLEASE ass a naming convention for you packages why isnt this libForQt6.[...] but fucking kdePackages.[...]
    kdePackages.qtstyleplugin-kvantum
  ];
  home.sessionVariables = {QT_STYLE_OVERRIDE = "kvantum";};
}
