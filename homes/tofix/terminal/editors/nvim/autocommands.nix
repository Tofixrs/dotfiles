{lib, ...}: {
  programs.neovim-flake.settings.vim.autocmds = [
    {
      event = ["FileType"];
      pattern = ["rust"];
      enable = true;
      callback = lib.generators.mkLuaInline ''
        function ()
          vim.o.shiftwidth = 2;
        end
      '';
    }
  ];
}
