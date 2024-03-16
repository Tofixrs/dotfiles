{pkgs, ...}: {
  fonts.fontconfig.defaultFonts = {
    emoji = ["Twitter Color Emoji"];
  };
  fonts.packages = with pkgs; [
    noto-fonts
    noto-fonts-cjk
    liberation_ttf
    fira-code
    fira-code-symbols
    mplus-outline-fonts.githubRelease
    dina-font
    proggyfonts
    twitter-color-emoji
    comfortaa
    corefonts
  ];
}
