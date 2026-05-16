_: {
  programs.git = {
    enable = true;
    settings.user = {
      name = "Tofixrs";
      email = "73693639+Tofixrs@users.noreply.github.com";
    };
    signing = {
      key = "C9F8078D690686C4";
      format = "openpgp";
      signByDefault = true;
    };
  };
}
