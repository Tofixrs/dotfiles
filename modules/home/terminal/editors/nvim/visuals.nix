_: {
  programs.neovim-flake.settings.vim.visuals = {
    nvim-web-devicons.enable = true;
    cinnamon-nvim.enable = true;
    highlight-undo.enable = true;
    fidget-nvim = {
      enable = true;
      setupOpts = {
        integration.nvim-tree.enable = true;
        notification.window = {
          align = "top";
          border = "rounded";
          winblend = 0;
        };
      };
    };
  };
}
