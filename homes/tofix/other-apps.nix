{
  pkgs,
  inputs',
  ...
}: {
  fonts.fontconfig.enable = true;
  home.packages = with pkgs; [
    keepassxc
    (nerdfonts.override {fonts = ["JetBrainsMono"];})
    inputs'.hyprland-contrib.packages.grimblast
    viewnior
    libsForQt5.ark
    lxqt.pcmanfm-qt
    gh
    playerctl
    hyprpicker
    swappy
    prismlauncher-qt5
    nodePackages.pnpm
    nodejs_20
    ripgrep
    lazygit
    lutris
    wine
    nil
    vlc
    nvtop
    brightnessctl
    alejandra
    obs-studio
    zig
  ];
}
