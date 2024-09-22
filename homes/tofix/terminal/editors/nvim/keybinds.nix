_: {
  programs.neovim-flake.settings.vim = {
    comments.comment-nvim.mappings = {
      toggleCurrentLine = "<leader>/";
      toggleSelectedLine = "<leader>/";
      toggleSelectedBlock = "<leader>/b";
    };
    tabline.nvimBufferline.mappings = {
      closeCurrent = "<leader>bc";
      pick = null;
    };
  };
}
