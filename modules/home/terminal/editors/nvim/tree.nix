_: {
  programs.neovim-flake.settings.vim.filetree.nvimTree = {
    enable = true;
    setupOpts = {
      modified.enable = true;
      git.enable = true;
      filesystem_watchers.enable = true;
      disable_netrw = true;
      diagnostics.enable = true;
      actions = {
        open_file.quit_on_open = true;
      };
    };
  };
}
