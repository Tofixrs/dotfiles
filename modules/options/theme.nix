{lib, ...}:
with lib; {
  options.modules.theme = {
    flavor = mkOption {
      type = types.enum ["latte" "frappe" "macchiato" "mocha"];
      default = "macchiato";
      description = "The Catppuccin flavor to use";
    };
    accent = mkOption {
      type = types.enum ["rosewater" "flamingo" "pink" "mauve" "red" "maroon" "peach" "yellow" "green" "teal" "sky" "sapphire" "blue" "lavender"];
      default = "mauve";
      description = "The Catppuccin accent color";
    };
  };
}
