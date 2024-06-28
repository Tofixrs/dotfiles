_: {
  programs.neovim-flake.settings.vim = {
    comments.comment-nvim.mappings = {
      toggleCurrentBlock = "<leader>/b";
      toggleCurrentLine = "<leader>/";
    };
    tabline.nvimBufferline.mappings = {
      closeCurrent = "<leader>bc";
      pick = null;
    };
  };
}
