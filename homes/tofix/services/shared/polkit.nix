{pkgs, ...}: {
  # gnome polkit agent
  systemd.user.services.polkit-pantheon-authentication-agent-1 = {
    Service.ExecStart = "${pkgs.pantheon.pantheon-agent-polkit}/libexec/policykit-1-pantheon/io.elementary.desktop.agent-polkit";
    Unit = {
      PartOf = ["graphical-session.target"];
      After = ["graphical-session.target"];
    };
    Install.WantedBy = ["graphical-session.target"];
  };
  home.packages = with pkgs; [
    pantheon.pantheon-agent-polkit
  ];
}
