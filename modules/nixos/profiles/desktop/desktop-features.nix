{pkgs, ...}: {
  services = {
    # Mounting
    gvfs = {
      enable = true;
    };
    udisks2 = {
      enable = true;
      mountOnMedia = true;
    };
    # Needed for portals
    dbus = {
      enable = true;
      packages = with pkgs; [dconf gcr udisks2];
      implementation = "broker";
    };
  };
}
