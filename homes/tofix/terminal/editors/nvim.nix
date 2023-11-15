# Swicth to using nvim flake from NotAShelf
{
  pkgs,
  self',
  ...
}: {
  programs.neovim = {
    enable = true;
    defaultEditor = true;
    vimAlias = true;
    viAlias = true;
    withNodeJs = true;
    withPython3 = true;
  };
  xdg.configFile."nvim" = {
    source = "${self'.packages.astronvim}";
  };
  home.packages = with pkgs; [
    self'.packages.astronvim
    lua-language-server
  ];
}
