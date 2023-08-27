{
  pkgs,
  inputs,
  ...
}: {
  fonts.fontconfig.enable = true;
  home.packages = with pkgs; [
    keepassxc
    (nerdfonts.override {fonts = ["JetBrainsMono"];})
    libsForQt5.polkit-kde-agent
    inputs.hyprland-contrib.packages.${pkgs.system}.grimblast
    git
    cliphist
    wl-clipboard
    viewnior
    libsForQt5.ark
    lxqt.pcmanfm-qt
    hyprpaper
    gh
  ];
}
