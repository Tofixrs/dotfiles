{
  pkgs,
  inputs',
  self',
  ...
}: {
  fonts.fontconfig.enable = true;
  programs.obs-studio = {
    enable = true;
    package = pkgs.obs-studio.override {
      cudaSupport = true;
    };
    plugins = with pkgs.obs-studio-plugins; [
      obs-vaapi
      droidcam-obs
    ];
  };
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
    (prismlauncher.override {
      additionalLivs = [vlc];
    })
    pnpm
    nodejs
    ripgrep
    lazygit
    (pkgs.lutris-free.override {
      # Override the underlying lutris package
      lutris = pkgs.lutris.override {
        # Intercept buildFHSEnv to modify target packages
        buildFHSEnv = args:
          pkgs.buildFHSEnv (args
            // {
              multiPkgs = envPkgs: let
                # Fetch original package list
                originalPkgs = args.multiPkgs envPkgs;

                # Disable tests for openldap
                customLdap = envPkgs.openldap.overrideAttrs (_: {doCheck = false;});
              in
                # Replace broken openldap with the custom one
                builtins.filter (p: (p.pname or "") != "openldap") originalPkgs ++ [customLdap];
            });
      };
    })
    wineWow64Packages.waylandFull
    nil
    alejandra
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
    self'.packages.legcord
    postman
    openai-whisper
    bun
    ollama
    opencode
  ];
}
