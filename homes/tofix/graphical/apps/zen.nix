{
  pkgs,
  inputs',
  ...
}: let
  configPath = ".zen";
  # Too lazy to make a proper module for this so its hardcoded lol
  profileName = "4o9u1vf1.default";
  nativeMessagingHostsPath = "${configPath}/native-messaging-hosts";
  nativeMessagingHostsJoined = pkgs.symlinkJoin {
    name = "ff_native-messaging-hosts";
    paths =
      [
        # Link a .keep file to keep the directory around
        (pkgs.writeTextDir "lib/mozilla/native-messaging-hosts/.keep" "")
        # Link package configured native messaging hosts (entire Firefox actually)
        inputs'.zen-browser.packages.default
      ]
      # Link user configured native messaging hosts
      ++ [pkgs.kdePackages.plasma-browser-integration];
  };
in {
  home = {
    file = {
      "${nativeMessagingHostsPath}" = {
        source = "${nativeMessagingHostsJoined}/lib/mozilla/native-messaging-hosts";
        recursive = true;
      };
    };
    packages = [
      inputs'.zen-browser.packages.default
    ];
  };
}
