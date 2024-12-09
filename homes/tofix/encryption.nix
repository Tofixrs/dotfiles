{
  config,
  pkgs,
  ...
}: {
  programs.gpg = {
    enable = true;
    settings = {
      default-key = "2814 E63B 19D4 74CF 6213  7CB9 89BC 99F9 1C0D 511E";
      default-recipient-self = true;
      auto-key-locate = "local,wkd,keyserver";
      keyserver = "hkps://keys.openpgp.org";
      auto-key-retrieve = true;
      auto-key-import = true;
      keyserver-options = "honor-keyserver-url";
    };
    homedir = "${config.xdg.configHome}/gnupg";
  };
  services.gpg-agent = {
    enable = true;
    enableSshSupport = true;
    defaultCacheTtl = 360; # 6 hours
    defaultCacheTtlSsh = 360; # 6 hours
    maxCacheTtl = 876000; # 100 years
    maxCacheTtlSsh = 876000; # 100 years
    pinentryPackage = pkgs.pinentry-qt;
  };
}
