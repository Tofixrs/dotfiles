_: let
  browser = "firefox.desktop";
  image_viewer = "viewnior.desktop";
  archiver = "org.kde.ark.desktop";
  editor = "nvim.desktop";
  file_manager = "pcmanfm-qt.desktop";
in {
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
}
