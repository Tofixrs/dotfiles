_: {
  programs.git = {
    enable = true;
    settings.user = {
      name = "Tofixrs";
      email = "73693639+Tofixrs@users.noreply.github.com";
    };
    signing = {
      key = "FD76B900B0F9DDD8";
      format = "openpgp";
      signByDefault = true;
    };
  };
}
