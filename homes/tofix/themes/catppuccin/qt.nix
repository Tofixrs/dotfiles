{pkgs, ...}: {
  home.packages = with pkgs; [
    (catppuccin-kvantum.override {
      accent = "Mauve";
      variant = "Mocha";
    })
  ];
  xdg.configFile."Kvantum/kvantum.kvconfig".source = (pkgs.formats.ini {}).generate "kvantum.kvconfig" {
    General.theme = "Catppuccin-Mocha-Mauve";
  };
}
