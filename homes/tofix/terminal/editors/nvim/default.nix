# Swicth to using nvim flake from NotAShelf
{inputs, ...}: {
  imports = [inputs.neovim-flake.homeManagerModules.default ./tree.nix ./lsp.nix ./terminal.nix ./keybinds.nix ./notifs.nix ./statusline.nix ./tabline.nix];
  programs.neovim-flake = {
    enable = true;

    settings.vim = {
      theme = {
        enable = true;
        name = "catppuccin";
        style = "mocha";
        transparent = true;
      };
      enableEditorconfig = true;
      enableLuaLoader = true;
      autoIndent = true;
      autocomplete.enable = true;
      autopairs.enable = true;
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
      telescope.enable = true;
      snippets.vsnip.enable = true;
      visuals.nvimWebDevicons.enable = true;
    };
  };
}
