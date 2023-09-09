const { Box } = ags.Widget;
const { SystemTray } = ags.Service;

export const tray = ({
	...props
} = {}) => Box({
	connections: [[SystemTray, box => {
	}]]
})
