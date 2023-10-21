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
    gh
    playerctl
    swww
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
    #    inputs.getchoo.packages.${pkgs.system}.modrinth-app
  ];
}
