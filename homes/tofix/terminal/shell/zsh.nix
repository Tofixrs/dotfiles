_: {
  programs.zsh = {
    enable = true;
    autocd = true;
    enableCompletion = true;
    syntaxHighlighting.enable = true;
    loginExtra = ''
      [ -z "$(pgrep "Hyprland")"] && Hyprland
    '';
  };
  programs.carapace.enable = true;
}
