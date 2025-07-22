{
  pkgs,
  inputs',
  ...
}: {
  i18n.inputMethod = {
    enable = true;
    type = "fcitx5";
    fcitx5 = {
      waylandFrontend = true;
      addons = [
        inputs'.ua-pl-phonetic.packages.default
      ];
    };
  };
  home.packages = with pkgs; [
    catppuccin-fcitx5
  ];
}
