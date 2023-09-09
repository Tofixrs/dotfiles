const {Box, Button, Label, Icon} = ags.Widget;
const {execAsync, lookUpIcon} = ags.Utils;
const {Hyprland} = ags.Service;

export const workspaces = ({indicator, fixed = 5} = {}) => Box({
	children: Array.from({length: fixed}, (_, i) => i+1).map(i => workspaceBtn(i, indicator)),
	connections: [[Hyprland, box => {
		const {workspaces} = Hyprland;
		const otherWs = getOtherWorkspaces(workspaces, fixed);

		if (otherWs.length > 0) {
			const otherWsIDs = otherWs.map(ws => ws.id);
			box.children = Array.from({length: fixed}, (_, i) => i+1)
				.concat(otherWsIDs)
				.map(i => workspaceBtn(i, indicator));
		} else if (box.children.length > 5) {
			box.children = Array.from({length: fixed}, (_, i) => i+1).map(i => workspaceBtn(i, indicator));
		}
	}]]
});

function getOtherWorkspaces(workspaces, fixed) {
	const ws = Array.from(workspaces.values());
	return ws.filter(workspace => workspace.id > fixed)
}

function workspaceBtn(id, indicator) {
	return Button({
		onClicked: () => execAsync(`hyprctl dispatch workspace ${id}`),
		child: indicator ? indicator() : Label(`${id}`),
		connections: [[Hyprland, btn => {
			const {workspaces, active} = Hyprland;
			const occupied = workspaces.has(id) && workspaces.get(id).windows > 0;
			btn.toggleClassName('active', active.workspace.id === id);
			btn.toggleClassName('occupied', occupied);
			btn.toggleClassName('empty', !occupied);
		}]]
	})
}

export const clientLabel = ({
	show = 'title', // "class"|"title"
	substitutes = [], // { from: string, to: string }[]
	fallback = '',
	...props
} = {}) => Label({
	...props,
	connections: [[Hyprland, label => {
		let name = Hyprland.active.client[show] || fallback;
		substitutes.forEach(({ from, to }) => {
			if (name === from) name = to;
		});
		label.label = name;
	}]],
});

export const clientIcon = ({
	symbolic = false,
	substitutes = [], // { from: string, to: string }[]
	fallback = '',
	...props
} = {}) => Icon({
	...props,
	connections: [[Hyprland, icon => {
		let classIcon = `${Hyprland.active.client.class}${symbolic ? '-symbolic' : ''}`;
		let titleIcon = `${Hyprland.active.client.title}${symbolic ? '-symbolic' : ''}`;
		substitutes.forEach(({ from, to }) => {
			if (classIcon === from) classIcon = to;

			if (titleIcon === from) titleIcon = to;
		});
		const hasTitleIcon = lookUpIcon(titleIcon);
		const hasClassIcon = lookUpIcon(classIcon);

		if (fallback) icon.icon = fallback;

		if (hasClassIcon) icon.icon = classIcon;

		if (hasTitleIcon) icon.icon = titleIcon;

		icon.visible = fallback || hasTitleIcon || hasClassIcon;
	}]],
});

