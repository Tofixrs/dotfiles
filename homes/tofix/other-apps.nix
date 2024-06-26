{
  pkgs,
  inputs',
  self',
  inputs,
  ...
}: {
  fonts.fontconfig.enable = true;
  home.packages = with pkgs; [
    keepassxc
    (nerdfonts.override {fonts = ["JetBrainsMono"];})
    inputs'.hyprland-contrib.packages.grimblast
    viewnior
    libsForQt5.ark
    gh
    playerctl
    hyprpicker
    swappy
    prismlauncher
    nodePackages.pnpm
    nodejs_20
    ripgrep
    lazygit
    lutris
    wine
    nil
    brightnessctl
    alejandra
    obs-studio
    zig
    qpwgraph
    btop
    libreoffice
    qbittorrent
    gimp
    clang
    cmake
    gnumake
    ventoy
    mpv
    (nvtopPackages.full.override {
      nvidia = true;
      amd = true;
    })
    android-studio
    cinnamon.nemo-with-extensions
    glib
  ];
}
