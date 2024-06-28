{pkgs, ...}: {
  programs.neovim-flake.settings.vim = {
    utility = {
      ccc.enable = true;
      vim-wakatime.enable = true;
      icon-picker.enable = true;
      surround.enable = true;
      diffview-nvim.enable = true;
      motion.leap.enable = true;
    };
  };
  home.packages = with pkgs; [
    wakatime
  ];
}
