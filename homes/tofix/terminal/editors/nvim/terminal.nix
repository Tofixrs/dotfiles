_: {
  programs.neovim-flake.settings.vim.terminal.toggleterm = {
    enable = true;
    lazygit.enable = true;
    setupOpts = {
      direction = "float";
    };
  };
}
