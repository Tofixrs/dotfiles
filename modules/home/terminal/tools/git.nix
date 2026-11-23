{config, ...}: {
  programs.git = {
    enable = true;
    settings.user = {
      name = "Tofixrs";
      email = "73693639+Tofixrs@users.noreply.github.com";
    };
    includes = [
      {
        condition = "hasconfig:remote.*.url:https://github.com/**";
        contents = {
          userName = "Tofixrs";
          userEmail = "73693639+Tofixrs@users.noreply.github.com";
        };
      }
      {
        condition = "hasconfig:remote.*.url:https://git.nothing-mod.dev/**";
        contents = {
          userName = "to.fix";
          userEmail = "tofix.rs@proton.me";
        };
      }
    ];
    settings.credential.helper = "libsecret";
    signing = {
      key = "${config.home.homeDirectory}/.ssh/id_ed25519.pub";
      format = "ssh";
      signByDefault = true;
    };
  };
}
