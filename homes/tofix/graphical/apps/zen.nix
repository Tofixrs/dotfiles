{
  pkgs,
  inputs,
  ...
}: {
  imports = [inputs.zen-browser.homeModules.default];
  programs.zen-browser = {
    enable = true;
    nativeMessagingHosts = [pkgs.kdePackages.plasma-browser-integration];
  };
}
