_: {
  programs.neovim-flake.settings.vim.filetree.nvimTree = {
    enable = true;
    setupOpts = {
      view.float.enable = true;
      modified.enable = true;
      git.enable = true;
      filesystemWatchers.enable = true;
      disableNetrw = true;
      diagnostics.enable = true;
      actions = {
        open_file.quit_on_open = true;
      };
    };
  };
}
