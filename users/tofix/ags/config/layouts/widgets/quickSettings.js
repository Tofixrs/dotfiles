import * as audio from "../../modules/audio.js"
import * as network from "../../modules/network.js"
import { tray } from "../../modules/tray.js"
import { fontIcon } from "../../modules/misc.js"
const { Button, Box, Revealer, Label } = ags.Widget;
const { Audio } = ags.Service;
const { App, Service } = ags;

class QSMenu extends Service {
	static { Service.register(this); }
	static instance = new QSMenu();
	static opened = '';
	static toggle(menu) {
		QSMenu.opened = QSMenu.opened === menu ? '' : menu;
		QSMenu.instance.emit('changed');
	}

	constructor() {
		super();
		App.instance.connect('window-toggled', (_a, name, visible) => {
			if (name === 'quicksettings' && !visible) {
				QSMenu.opened = '';
				QSMenu.instance.emit('changed');
			}
		});
	}
}

const revealerMenu = (name, child) => Box({
	children: [Revealer({
		transition: 'slide_down',
		connections: [[QSMenu, r => r.reveal_child = name === QSMenu.opened]],
		child,
	})],
});


export const quickSettings = () => Button({
	className: "quickSettings panel-button",
	onScrollUp: () => { Audio.speaker.volume += 0.05; },
	onScrollDown: () => { Audio.speaker.volume -= 0.05; },
	onClicked: () => App.toggleWindow('quicksettings'),
	child: Box({
		children: [
			audio.microphoneMuteIndicator({ unmuted: null }),
			audio.volumeIndicator(),
			network.indicator()
		]
	})
})

export const popupContent = () => Box({
	className: "quicksettings",
	vertical: true,
	hexpand: true,
	children: [
		Box({ hexpand: true, children: [tray()] }),
		Box({ hexpand: true, children: [Label("Quick Settings")] }),
		volumeBox(),
		Box({
			className: 'toggles-box',
			children: [
				Box({
					vertical: true,
					className: 'arrow-toggles',
					children: [],
				}),
				Box({
					vertical: true,
					className: 'small-toggles',
					vexpand: true,
					hexpand: false,
					children: [
						Box({ children: [appmixerToggle(), muteToggle()] }),
					],
				}),
			],
		}),
		appMixer()
	]
})

const submenu = ({ menuName, icon, title, contentType }) => revealerMenu(menuName, Box({
	vertical: true,
	className: `submenu ${menuName}`,
	children: [
		Box({ className: 'title', children: [icon, Label(title)] }),
		contentType({ className: 'content', hexpand: true }),
	],
}));

const volumeBox = () => Box({
	vertical: true,
	className: "volume-box",
	children: [
		Box({
			className: "volume",
			children: [
				Button({
					child: audio.speakerTypeIndicator(),
					onClicked: 'wpctl set-mute @DEFAULT_SINK@ toggle'
				}),
				audio.speakerSlider({ hexpand: true })
			]
		})
	]
})
const appMixer = () => submenu({
	menuName: 'app-mixer',
	title: 'App Mixer',
	contentType: audio.appMixer,
})

const appmixerToggle = () => Button({
	className: 'toggle',
	onClicked: () => QSMenu.toggle('app-mixer'),
	child: fontIcon({ icon: '' }),
	tooltipText: 'App Mixer',
	connections: [[QSMenu, w => w.toggleClassName('on', QSMenu.opened === 'app-mixer')]],
});

const smallToggle = (toggle, indicator) => toggle({
	className: 'toggle',
	halign: 'fill',
	hexpand: true,
	vexpand: true,
	child: indicator({ halign: 'center' }),
});
const muteToggle = () => smallToggle(
	audio.microphoneMuteToggle,
	audio.microphoneMuteIndicator,
);
