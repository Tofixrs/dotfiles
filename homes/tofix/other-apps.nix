{
  pkgs,
  inputs',
  ...
}: {
  fonts.fontconfig.enable = true;
  home.packages = with pkgs; [
    keepassxc
    nerd-fonts.jetbrains-mono
    material-symbols
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
    wineWowPackages.waylandFull
    nil
    brightnessctl
    alejandra
    (pkgs.obs-studio.override
      {
        cudaSupport = true;
      })
    zig
    qpwgraph
    btop
    libreoffice
    qbittorrent
    gimp3-with-plugins
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
    # inputs'.vencord.packages.default
    ryujinx
    libnotify
    inputs'.quickshell.packages.default
    inotify-tools
    jq # sanity
    pkgs.imagemagick
  ];
}
