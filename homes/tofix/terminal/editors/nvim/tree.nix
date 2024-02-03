_: {
  programs.neovim-flake.settings.vim.filetree.nvimTree = {
    enable = true;
    actions = {
      openFile.quitOnOpen = true;
    };
    diagnostics.enable = true;
    disableNetrw = true;
    filesystemWatchers.enable = true;
    git.enable = true;
    modified.enable = true;
    view.float.enable = true;
  };
}
