_: {
  programs = {
    dconf.enable = true;
    zsh = {
      enable = true;
      syntaxHighlighting.enable = true;
      enableCompletion = true;
      autosuggestions.enable = true;
      setOptions = ["PROMPT_SUBST" "appendhistory"];
    };
  };
}
