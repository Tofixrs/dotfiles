{flake_path, ...}: let
  browser = "firefox.desktop";
  image_viewer = "viewnior.desktop";
  archiver = "org.kde.ark.desktop";
  editor = "nvim.desktop";
  file_manager = "pcmanfm-qt.desktop";
in {
  imports = [./wayland ./themes ./programs ./ags];

  home.shellAliases = {
    home-switch = "home-manager switch --flake ${flake_path}#tofix";
  };

  home.sessionVariables = {
    XCURSOR_SIZE = 12;
    EDITOR = "nvim";
    TERMINAL = "kitty";
    TERM = "kitty";
    WINIT_UNIX_BACKEND = "wayland";
  };

  xdg.enable = true;
  xdg.userDirs.enable = true;
  xdg.mimeApps = {
    enable = true;
    defaultApplications = {
      "x-scheme-handler/http" = "${browser}";
      "x-scheme-handler/https" = "${browser}";
      "x-scheme-handler/chrome" = "${browser}";
      "application/x-extension-htm" = "${browser}";
      "application/x-extension-html" = "${browser}";
      "application/x-extension-shtml" = "${browser}";
      "application/xhtml+xml" = "${browser}";
      "application/x-extension-xhtml" = "${browser}";
      "application/x-extension-xht" = "${browser}";
      "application/x-compressed-tar" = "${archiver}";
      "image/tiff" = "${image_viewer}";
      "image/vnd.zbrush.pcx" = "${image_viewer}";
      "image/x-xbitmap" = "${image_viewer}";
      "image/svg+sml" = "${image_viewer}";
      "image/x-icns" = "${image_viewer}";
      "image/webp" = "${image_viewer}";
      "image/png" = "${image_viewer}";
      "image/svg+xml-compressed" = "${image_viewer}";
      "image/gif" = "${image_viewer}";
      "image/x-tga" = "${image_viewer}";
      "image/x-xpixmap" = "${image_viewer}";
      "image/x-portable" = "${image_viewer}";
      "image/vnd.microsoft.icon" = "${image_viewer}";
      "image/bmp" = "${image_viewer}";
      "image/vnd.wap.wbmp" = "${image_viewer}";
      "image/jpeg" = "${image_viewer}";
      "inode/directory" = "${file_manager}";
      "text/plain" = "${editor}";
    };
  };
  xdg.configFile."nixpkgs/config.nix".text = ''
    {
      packageOverrides = pkgs: {
        nur = import (builtins.fetchTarball "https://github.com/nix-community/NUR/archive/master.tar.gz") {
          inherit pkgs;
        };
      };
    }
  '';
  home.username = "tofix";
  home.homeDirectory = "/home/tofix";
  home.stateVersion = "22.11";
  programs.home-manager.enable = true;
}
