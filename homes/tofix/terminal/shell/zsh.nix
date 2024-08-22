_: {
  programs.zsh = {
    enable = true;
    autocd = true;
    enableCompletion = true;
    syntaxHighlighting.enable = true;
    loginExtra = ''
      if  [[ $(tty) == "/dev/tty1" ]]; then Hyprland; fi
    '';
  };
  programs.carapace.enable = true;
}
