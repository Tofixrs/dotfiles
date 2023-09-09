const { Button, Icon } = ags.Widget;
const {exec} = ags.Utils;

export const powerMenu = () => Button({
	className: "powermenu panel-button",
	onClicked: () => exec("/home/tofix/.config/hypr/power.sh"),
	child: Icon('system-shutdown-symbolic')
})
