const {Audio} = ags.Service;
const {Icon, Stack, Slider} = ags.Widget;

export const MicrophoneMuteIndicator = ({
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
      if (vol > threshold + 1) return stack.shown =  `${threshold + 1}`
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
        if (from === item)
            return to;
    }
    return item;
};

export const speakerTypeIndicator = props => Icon({
    ...props,
    connections: [[Audio, icon => {
        if (Audio.speaker)
            icon.icon = iconSubstitute(Audio.speaker.iconName);
    }]],
});
export const speakerSlider = props => Slider({
    ...props,
    drawValue: false,
    onChange: ({ value }) => Audio.speaker.volume = value,
    connections: [[Audio, slider => {
        if (!Audio.speaker)
            return;

        slider.sensitive = !Audio.speaker.isMuted;
        slider.value = Audio.speaker.volume;
    }, 'speaker-changed']],
});
