const { EventBox, CenterBox, Box, Revealer } = ags.Widget;
const { App } = ags;

const padding = windowName => EventBox({
	className: 'padding',
	hexpand: true,
	vexpand: true,
	connections: [['button-press-event', () => App.toggleWindow(windowName)]],
});

const popupRevealer = (windowName, transition, child) => Box({
	style: 'padding: 1px;',
	children: [Revealer({
		transition,
		child,
		transitionDuration: 350,
		connections: [[App, (revealer, name, visible) => {
			if (name === windowName) revealer.reveal_child = visible;
		}]],
	})],
});

const layouts = {
	'center': (windowName, child) => CenterBox({
		className: 'shader',
		children: [
			padding(windowName),
			CenterBox({
				vertical: true,
				children: [
					padding(windowName),
					child,
					padding(windowName),
				],
			}),
			padding(windowName),
		],
	}),
	'top': (windowName, child) => CenterBox({
		children: [
			padding(windowName),
			Box({
				vertical: true,
				children: [
					popupRevealer(windowName, 'slide_down', child),
					padding(windowName),
				],
			}),
			padding(windowName),
		],
	}),
	'top right': (windowName, child) => Box({
		children: [
			padding(windowName),
			Box({
				hexpand: false,
				vertical: true,
				children: [
					popupRevealer(windowName, 'slide_down', child),
					padding(windowName),
				],
			}),
		],
	}),
	'bottom right': (windowName, child) => Box({
		children: [
			padding(windowName),
			Box({
				hexpand: false,
				vertical: true,
				children: [
					padding(windowName),
					popupRevealer(windowName, 'slide_up', child),
				],
			}),
		],
	}),
};

export const popupLayout = ({ layout, window, child }) => layouts[layout](window, child);
