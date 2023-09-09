import * as hyprland from "../../modules/hyprland.js"
const {Box, EventBox, Button } = ags.Widget;

export const workspaces = props => Box({
	...props,
	className: "workspaces panel-button",
	children: [EventBox({
		className: "eventbox",
		child: hyprland.workspaces({
			indicator: () => Box({
				className: "indicator",
				valign: "center",
				children: [Box({ className: "fill"})]
			})
		})
	})]
});

export const client = (props) => Button({
	...props,
	className: "client panel-button",
	onSecondaryClick: () => execAsync("hyprctl dispatch killactive"),
	child: Box({
		children: [
			hyprland.clientIcon({
				symbolic: true,
				substitutes: [
					{
			  	  	  from: "com.transmissionbt.Transmission._43_219944-symbolic",
			  	  	  to: "com.transmissionbt.Transmission-symbolic",
					},
					{
			  	  	  from: "com.transmissionbt.Transmission._40_219944-symbolic",
			  	  	  to: "com.transmissionbt.Transmission-symbolic",
					},
					{
			  	  	  from: "com.transmissionbt.Transmission._37_219944-symbolic",
			  	  	  to: "com.transmissionbt.Transmission-symbolic",
					},
					{ from: "blueberry.py-symbolic", to: "bluetooth-symbolic" },
					{
			  	  	  from: "org.wezfurlong.wezterm-symbolic",
			  	  	  to: "folder-code-symbolic",
					},
					{ from: "Caprine-symbolic", to: "facebook-messenger-symbolic" },
					{ from: "-symbolic", to: "preferences-desktop-display-symbolic" },
					{ from: "WebCord-symbolic", to: "webcord" },
					{ from: "kitty-symbolic", to: "utilities-terminal-symbolic" },
					{ from: "org.keepassxc.KeePassXC-symbolic", to: "password-manager-symbolic" },
				],
			}),
			hyprland.clientLabel({
				show: "class",
				substitutes: [
					{
			  	  	  from: "com.transmissionbt.Transmission._43_219944",
			  	  	  to: "Transmission",
					},
					{
			  	  	  from: "com.transmissionbt.Transmission._40_219944",
			  	  	  to: "Transmission",
					},
					{
			  	  	  from: "com.transmissionbt.Transmission._37_219944",
			  	  	  to: "Transmission",
					},
					{ from: "com.obsproject.Studio", to: "OBS" },
					{ from: "com.github.wwmm.easyeffects", to: "Easy Effects" },
					{ from: "org.gnome.TextEditor", to: "Text Editor" },
					{ from: "org.gnome.design.IconLibrary", to: "Icon Library" },
					{ from: "org.wezfurlong.wezterm", to: "Wezterm" },
					{ from: "firefox", to: "Firefox" },
					{ from: "org.gnome.Nautilus", to: "Files" },
					{ from: "libreoffice-writer", to: "Writer" },
					{ from: "", to: "Desktop" },
					{ from: "WebCord", to: "Discord" },
					{ from: "kitty", to: "Kitty" },
					{ from: "org.keepassxc.KeePassXC", to: "KeePassXC" },
				],
			}),
	  	],
	}),
});
