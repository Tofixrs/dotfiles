_: {
  programs.zsh = {
    enable = true;
    autocd = true;
    enableCompletion = true;
    syntaxHighlighting.enable = true;
    loginExtra = ''
      if uwsm check may-start && uwsm select; then
      	exec systemd-cat -t uwsm_start uwsm start default
      fi
    '';
  };
}
