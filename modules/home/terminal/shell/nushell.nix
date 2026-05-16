{
  pkgs,
  lib,
  inputs,
  inputs',
  config,
  ...
}: {
  programs.nushell = {
    enable = true;
    settings = {
      show_banner = false;
    };
    extraEnv = ''
      use std "path add";
      use "${inputs.bash-env-nushell}/bash-env.nu"
      bash-env ${config.home.sessionVariablesPackage}/etc/profile.d/hm-session-vars.sh | load-env
      path add ~/.cache/.bun/bin
      path add ~/.config/composer/vendor/bin
      path add ~/go/bin
    '';
    extraLogin = ''
      try {
        uwsm check may-start
        uwsm select
        exec systemd-cat -t uwsm_start uwsm start default
      }
    '';
    extraConfig = ''
      export def --env clone [link: string] {
        cd /documents/Projects/;
        git clone $"($link)";
        let paths = $link | url parse | get path | split row "/";
        cd ($paths | get (($paths | length) - 1))
      }
    '';
  };
  home.packages = [
    inputs'.bash-env-nushell.packages.default
    inputs'.bash-env-json.packages.default
  ];
  home.sessionVariables = {
    SHELL = lib.getExe pkgs.nushell;
  };
}
