_: {
  programs.neovim-flake.settings.vim.statusline.lualine = {
    enable = true;
    sectionSeparator = {
      left = "";
      right = "";
    };
    activeSection = {
      a = [
        "{'mode', separator = { left = '' }, right_padding = 2 }"
      ];
      b = [
        "{'branch'}"
        "{'diagnostics'}"
        "{'filename', separator = { right = ''}}"
      ];
      c = [];
      x = [];
      y = [
        "{'filetype', separator = {left = ''}}"
        "{'progress'}"
      ];
      z = [
        "{ 'location', separator = { right = '' }, left_padding = 2 }"
      ];
    };
    inactiveSection = {
      a = [
        "{'filename'}"
      ];
      b = [];
      c = [];
      x = [];
      y = [];
      z = [
        "{'location'}"
      ];
    };
  };
}
