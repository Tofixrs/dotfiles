import {cpuUsage} from "../../modules/cpu.js"

const {Box} = ags.Widget;

export const sysStats = () => Box({
	className: "panel-button",
	children: [cpuUsage()]
})
