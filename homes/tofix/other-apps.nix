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
    kdePackages.ark
    gh
    playerctl
    hyprpicker
    swappy
    prismlauncher
    nodePackages.pnpm
    nodejs_20
    bun
    ripgrep
    lazygit
    lutris
    wineWow64Packages.waylandFull
    nil
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
    ryubing
    libnotify
    inputs'.quickshell.packages.default
    inotify-tools
    jq # sanity
    imagemagick
    libqalculate
    kdePackages.qtimageformats
    kdePackages.qtmultimedia
    nix-index
    (poedit.override {boost = boost188;})
    vesktop
    postman
  ];
}
