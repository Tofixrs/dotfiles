const { Box, Label, Overlay } = ags.Widget;
const { exec } = ags.Utils;

export const fontIcon = ({ icon = '', ...props }) => {
	return Label({
		label: icon,
		halign: 'center',
		valign: 'center',
		...props
	});
};


export const distroIcon = props => fontIcon({
	...props,
	className: 'distro-icon',
	icon: (() => {
		// eslint-disable-next-line quotes
		const distro = exec(`bash -c "cat /etc/os-release | grep '^ID' | head -n 1 | cut -d '=' -f2"`)
			.toLowerCase();

		switch (distro) {
			case 'fedora': return '';
			case 'arch': return '';
			case 'nixos': return '';
			case 'debian': return '';
			case 'opensuse-tumbleweed': return '';
			case 'ubuntu': return '';
			case 'endeavouros': return '';
			default: return '';
		}
	})(),
});

export const seperator = ({ className = "", ...props } = {}) => Box({
	hexpand: false,
	vexpand: false,
	...props,
	className: [...className.split(' '), 'seperator'].join('')
});
