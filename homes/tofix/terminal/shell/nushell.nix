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
      use "${inputs.bash-env-nushell}/bash-env.nu"
      bash-env ${config.home.sessionVariablesPackage}/etc/profile.d/hm-session-vars.sh | load-env
    '';
    extraLogin = ''
      try {
        uwsm check may-start
        uwsm select
        exec systemd-cat -t uwsm_start uwsm start default
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
