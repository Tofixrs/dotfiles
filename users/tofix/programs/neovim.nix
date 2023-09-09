{pkgs, ...}: {
  programs.neovim = {
    enable = true;
    defaultEditor = true;
    vimAlias = true;
    viAlias = true;
    withNodeJs = true;
    withPython3 = true;
  };
  xdg.configFile."nvim" = {
    source = "${pkgs.astrovim}";
  };
  home.packages = with pkgs; [
    astrovim
    lua-language-server
  ];
}
