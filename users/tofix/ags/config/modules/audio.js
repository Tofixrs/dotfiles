const { Audio } = ags.Service;
const { Icon, Stack, Slider, Box, Label, Button } = ags.Widget;

export const microphoneMuteIndicator = ({
		muted = Icon('audio-input-microphone-muted-symbolic'),
		unmuted = Icon('microphone-sensitivity-high-symbolic'),
		...props
} = {}) => Stack({
		...props,
		items: [
				['true', muted],
				['false', unmuted],
		],
		connections: [[Audio, stack => {
				stack.shown = `${Audio.microphone?.isMuted}`;
		}, 'microphone-changed']],
});

export const volumeIndicator = ({
	muted = Icon("audio-volume-muted-symbolic"),
	low = Icon("audio-volume-low-symbolic"),
	medium = Icon("audio-volume-medium-symbolic"),
	high = Icon("audio-volume-high-symbolic"),
	veryHigh = Icon("audio-volume-overamplified-symbolic"),
	...props
} = {}) => Stack({
	items: [
		["0", muted],
		["1", low],
		["34", medium],
		["69", high],
		["101", veryHigh]
	],
	connections: [[Audio, stack => {
		if (!Audio.speaker) return;
		const vol = Audio.speaker.volume * 100;
		if (Audio.speaker.muted) return stack.shown = "0";

		for (const threshold of [100, 68, 33, 0, -1 ]) {
			if (vol > threshold + 1) return stack.shown =	`${threshold + 1}`
		}
	}, 'speaker-changed']],
	...props
})

const iconSubstitute = item => {
	const substitues = [
		{ from: 'audio-headset-bluetooth', to: 'audio-headphones-symbolic' },
		{ from: 'audio-card-analog-usb', to: 'audio-speakers-symbolic' },
		{ from: 'audio-card-analog-pci', to: 'audio-card-symbolic' },
	];

	for (const { from, to } of substitues) {
		if (from === item) return to;
	}
	return item;
};

export const speakerTypeIndicator = props => Icon({
	...props,
	connections: [[Audio, icon => {
		if (Audio.speaker) icon.icon = iconSubstitute(Audio.speaker.iconName);
	}]],
});
export const speakerSlider = ({min = 0, max = 100, ...props} = {}) => Slider({
	...props,
	drawValue: false,
	max,
	min,
	onChange: ({ value }) => Audio.speaker.volume = value / 100,
	connections: [[Audio, slider => {
		if (!Audio.speaker) return;

		slider.sensitive = !Audio.speaker.isMuted;
		slider.value = Audio.speaker.volume * 100;
	}, 'speaker-changed']],
});

export const appMixer = props => Box({
	...props,
	vertical: true,
	connections: [[Audio, box => {
		box.children = Array.from(Audio.apps.values())
			.filter((stream) => stream.description != "")
			.map((stream) => appItem(stream))
	}]]
})

const appItem = stream => {
	const icon = Icon();
	const label = Label({ xalign: 0, justify: 'left', wrap: true, ellipsize: 3 });
	const percent = Label({ xalign: 1 });
	const slider = Slider({
		hexpand: true,
		drawValue: false,
		onChange: ({ value }) => stream.volume = value,
	});
	const sync = () => {
		icon.icon = stream.iconName;
		icon.tooltipText = stream.name;
		slider.value = stream.volume;
		percent.label = `${Math.floor(stream.volume * 100)}%`;
		label.label = stream.description || '';
	};
	const id = stream.connect('changed', sync);
	return Box({
		hexpand: true,
		children: [
			icon,
			Box({
				children: [
					Box({
						vertical: true,
						children: [
							label,
							slider,
						],
					}),
					percent,
				],
			}),
		],
		connections: [['destroy', () => stream.disconnect(id)]],
		setup: sync,
	});
};

export const microphoneMuteToggle = props => Button({
	...props,
	onClicked: 'wpctl set-mute @DEFAULT_SOURCE@ toggle',
	connections: [[Audio, button => {
		if (!Audio.microphone) return;

		button.toggleClassName('on', Audio.microphone.isMuted);
	}, 'microphone-changed']],
});
