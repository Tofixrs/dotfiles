_: {
  programs.neovim-flake.settings.vim = {
    comments.comment-nvim.mappings = {
      toggleCurrentLine = "<leader>/";
      toggleSelectedLine = "<leader>/";
      toggleSelectedBlock = "<leader>/b";
    };
    keymaps = [
      {
        key = "<C-ESC>";
        mode = "t";
        silent = true;
        desc = "Leave terminal mode";
        action = "<C-\\><C-n>";
      }
      {
        key = "rc";
        mode = ["n" "v"];
        desc = "Replace word at cursor";
        action = ''
          function()
            vim.fn.feedkeys("viw");
            vim.fn.feedkeys(":s/\\%V" .. vim.fn.expand("<cword>") .. "/");
          end
        '';
        lua = true;
      }
      {
        key = "rcg";
        mode = ["n" "v"];
        desc = "Replace word at cursor in the whole line";
        action = ''
          function()
            local left = vim.keycode("<Left>")
            local word = vim.fn.expand("<cword>")
            local cmd = ":s/" .. word .. "//g";
            vim.fn.feedkeys(cmd .. left .. left);
          end
        '';
        lua = true;
        expr = true;
      }
    ];
  };
}
