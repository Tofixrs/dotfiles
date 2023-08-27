import * as audio from "../../modules/audio.js"
import * as network from "../../modules/network.js"
const { Button, Box } = ags.Widget;
const { Audio } = ags.Service;
const {App} = ags;

export const quickSettings = () => Button({
  className: "quickSettings panel-button",
  onScrollUp: () => {Audio.speaker.volume += 0.05;},
  onScrollDown: () => {Audio.speaker.volume -= 0.05;},
  onClicked: () => App.toggleWindow('quicksettings'),
  child: Box({
    children: [
      audio.MicrophoneMuteIndicator({ unmuted: null}),
      audio.volumeIndicator(),
      network.indicator()
    ]
  })
})

export const popupContent = () => Box({
  className: "quicksettings",
  vertical: true,
  hexpand: false,
  children: [
    volumeBox()
  ]
})

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
        audio.speakerSlider()
      ]
    })
  ]
})
