_: {
  services = {
    # Mounting
    gvfs = {
      enable = true;
    };
    udisks2 = {
      enable = true;
      mountOnMedia = true;
    };
  };
}
