{pkgs, ...}: {
  programs.neovim.enable = true;
  programs.neovim.defaultEditor = true;
  programs.neovim.viAlias = true;
  programs.neovim.vimAlias = true;
  xdg.configFile."nvim" = {
    source = "${pkgs.nvchad}";
  };
  home.packages = with pkgs; [
    nvchad
    nodePackages.pnpm
    nodejs_20
    cargo
  ];
}
