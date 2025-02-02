# Swicth to using nvim flake from NotAShelf
{inputs, ...}: {
  imports = [inputs.neovim-flake.homeManagerModules.default ./tree.nix ./lsp.nix ./terminal.nix ./keybinds.nix ./statusline.nix ./tabline.nix ./notes.nix ./visuals.nix ./utils.nix];
  programs.neovim-flake = {
    enable = true;

    settings.vim = {
      theme = {
        enable = true;
        name = "catppuccin";
        style = "mocha";
        transparent = true;
      };
      globals.editorconfig = true;
      enableLuaLoader = true;
      options = {
        autoindent = true;
        tabstop = 2;
        shiftwidth = 2;
      };
      autocomplete.nvim-cmp.enable = true;
      autopairs.nvim-autopairs.enable = true;
      bell = "visual";
      binds = {
        cheatsheet.enable = true;
        whichKey.enable = true;
      };
      comments = {
        comment-nvim.enable = true;
      };
      dashboard.alpha.enable = true;
      viAlias = true;
      vimAlias = true;
      telescope = {
        setupOpts.file_ignore_patterns = ["file.lock" "@girs"];
        enable = true;
      };
      snippets.luasnip.enable = true;
      notify.nvim-notify.enable = true;
      projects.project-nvim.enable = true;
      ui = {
        noice.enable = true;
        colorizer.enable = true;
        fastaction.enable = true;
      };
      session.nvim-session-manager.enable = true;
    };
  };
}
