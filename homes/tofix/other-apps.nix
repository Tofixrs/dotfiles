{
  pkgs,
  inputs',
  self',
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
    wineWowPackages.stable
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
    nemo-with-extensions
    glib
    inputs'.SMGui.packages.default
    inputs'.vencord.packages.default
  ];
}
