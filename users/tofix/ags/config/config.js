import topBar from "./layouts/topBar.js";

const monitors = ags.Service.Hyprland.HyprctlGet("monitors").map(
  (mon) => mon.id,
);

const scss = ags.App.configDir + '/style/scss/main.scss';
const css = ags.App.configDir + '/style/css/main.css';

// make sure sassc is installed on your system
ags.Utils.exec(`mkdir ${ags.App.configDir + "/style/css"}`)
ags.Utils.exec(`sass ${scss} ${css}`);

export default {
  style: css,
  windows: [
    ...topBar(monitors)
  ]
}
