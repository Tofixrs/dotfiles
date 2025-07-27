{
  lib,
  pkgs,
  config,
  ...
}: let
  browser = ["Zen.desktop"];
  image_viewer = ["viewnior.desktop"];
  archiver = ["org.kde.ark.desktop"];
  editor = ["nvim.desktop"];
  file_manager = ["nemo.desktop"];
  media_player = ["mpv.desktop"];

  associations = {
    "x-scheme-handler/http" = browser;
    "x-scheme-handler/https" = browser;
    "x-scheme-handler/chrome" = browser;
    "application/x-extension-htm" = browser;
    "application/x-extension-html" = browser;
    "application/x-extension-shtml" = browser;
    "application/xhtml+xml" = browser;
    "application/x-extension-xhtml" = browser;
    "application/x-extension-xht" = browser;
    "application/x-compressed-tar" = archiver;
    "image/tiff" = image_viewer;
    "image/vnd.zbrush.pcx" = image_viewer;
    "image/x-xbitmap" = image_viewer;
    "image/svg+sml" = image_viewer;
    "image/x-icns" = image_viewer;
    "image/webp" = image_viewer;
    "image/png" = image_viewer;
    "image/svg+xml-compressed" = image_viewer;
    "image/gif" = image_viewer;
    "image/x-tga" = image_viewer;
    "image/x-xpixmap" = image_viewer;
    "image/x-portable" = image_viewer;
    "image/vnd.microsoft.icon" = image_viewer;
    "image/bmp" = image_viewer;
    "image/vnd.wap.wbmp" = image_viewer;
    "image/jpeg" = image_viewer;
    "inode/directory" = file_manager;
    "text/plain" = editor;
    "video/x-flic" = media_player;
    "video/mpeg" = media_player;
    "video/vnd.rn-realvideo" = media_player;
    "video/x-ogm+ogg" = media_player;
    "video/vnd.mpegurl" = media_player;
    "video/3gpp" = media_player;
    "video/x-ms-wmv" = media_player;
    "video/quicktime" = media_player;
    "video/x-anim" = media_player;
    "video/ogg" = media_player;
    "video/x-nsv" = media_player;
    "video/mp4" = media_player;
    "video/webm" = media_player;
    "video/x-theora+ogg" = media_player;
    "video/x-msvideo" = media_player;
    "video/mp2t" = media_player;
    "video/3gpp2" = media_player;
    "video/x-matroska" = media_player;
    "video/x-flv" = media_player;
    "video/dv" = media_player;
    "x-scheme-handler/steam" = ["steam.desktop"];
  };
  terminal = lib.getExe pkgs.kitty;
in {
  xdg = {
    enable = true;
    userDirs = {
      enable = true;
      createDirectories = true;
      desktop = "$HOME/Desktop";
      documents = "$HOME/Documents";
      download = "$HOME/Downloads";
      videos = "$HOME/Videos";
      music = "$HOME/Music";
      pictures = "$HOME/Pictures";
    };
    mimeApps = {
      enable = true;
      associations.added = associations;
      defaultApplications = associations;
    };
  };

  dconf.settings = {
    "org/cinnamon/desktop/applications/terminal" = {
      exec = terminal;
    };
  };

  home.sessionVariables = {
    EDITOR = "nvim";
    TERMINAL = terminal;
    FILE_MANAGER = "nemo";
  };

  xdg.desktopEntries = {
    nvim = {
      name = "Neovim";
      genericName = "Text Editor";
      comment = "Edit text files";
      exec = "${terminal} -e nvim %F";
      type = "Application";
      icon = "nvim";
      categories = ["Utility" "TextEditor"];
      startupNotify = false;
      mimeType = ["text/english" "text/plain" "text/x-makefile" "text/x-c++hdr" "text/x-c++src" "text/x-chdr" "text/x-csrc" "text/x-java" "text/x-moc" "text/x-pascal" "text/x-tcl" "text/x-tex application/x-shellscript" "text/x-c" "text/x-c++"];
    };
  };
  xdg.configFile."uwsm/env".text =
    ''
      ${config.lib.shell.exportAll config.home.sessionVariables}
    ''
    + lib.optionalString (config.home.sessionPath != []) ''
      export PATH="$PATH''${PATH:+:}${builtins.concatStringsSep ":" config.home.sessionPath}"
    ''
    + config.home.sessionVariablesExtra;
}
