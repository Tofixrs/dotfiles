{lib, ...}:
with lib; {
  imports = [./boot.nix];

  options.modules.system = {
    fs = mkOption {
      type = with types; listOf str;
      default = ["vfat" "ext4" "btrfs" "ntfs"]; # TODO: zfs, ntfs
      description = ''
        A list of filesystems available supported by the system
        it will enable services based on what strings are found in the list.

        It would be a good idea to keep vfat and ext4 so you can mount common external storage.
      '';
    };
    users = mkOption {
      type = with types; listOf str;
      default = ["tofix"];
      description = "A list of home-manager users on the system.";
    };
  };
}
