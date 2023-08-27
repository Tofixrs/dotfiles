import {clock} from "../../modules/clock.js"

const {Button} = ags.Widget;
const {exec} = ags.Utils;

export const PanelButton = ({ format } = {}) => Button({
    className: 'dashboard panel-button',
    onClicked: () => exec("swaync-client -t"),
    child: clock({
        format,
        justification: 'center',
    }),
});
