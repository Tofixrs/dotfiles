import { popupLayout } from "./widgets/popuplayout.js";
import * as quicksettings from './widgets/quickSettings.js';

const { Window, CenterBox, Box, Button } = ags.Widget;

export const Bar = ({ start, center, end, anchor, monitor }) => Window({
	name: `bar${monitor}`,
	exclusive: true,
	monitor,
	anchor,
	child: CenterBox({
		className: "panel",
		startWidget: Box({ children: start, className: 'start' }),
		centerWidget: Box({ children: center, className: 'center' }),
		endWidget: Box({ children: end, className: 'end' }),
	})
});

export const quickSettings = ({ position }) => Window({
	name: 'quicksettings',
	popup: true,
	focusable: true,
	anchor: position,
	child: popupLayout({
		layout: position,
		window: "quicksettings",
		child: quicksettings.popupContent()
	})
})
