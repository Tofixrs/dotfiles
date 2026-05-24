{pkgs, ...}: {
  i18n.inputMethod = {
    enable = true;
    type = "fcitx5";
    fcitx5 = {
      waylandFrontend = true;
    };
  };
  home.packages = with pkgs; [
    catppuccin-fcitx5
  ];
}
