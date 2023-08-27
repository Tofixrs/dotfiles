import * as shared from "./shared.js";
import {PanelButton as Dashbord} from "./widgets/dashboard.js"
import {distroIcon, seperator} from "../modules/misc.js"
import {workspaces, client} from "./widgets/hyprland.js"
import {powerMenu} from "./widgets/powermenu.js"
import { quickSettings } from "./widgets/quickSettings.js";
import { sysStats } from "./widgets/sysStats.js";
const {Button, Box} = ags.Widget;
const {exec} = ags.Utils;

const topBar = monitor => shared.Bar({
  anchor: 'top left right',
  monitor,
  start: [
    Button({ child: distroIcon(), className: "panel-button", onClicked: () => exec("anyrun")}),
    seperator({ valign: "center"}),
    workspaces(),
    seperator({ valign: "center"}),
    client()
  ],
  center: [
    Dashbord({ format: "%H:%M %b %e %a"})
  ],
  end: [
    Box({hexpand: true}),
    sysStats(),
    seperator({ valign: "center" }),
    quickSettings(),
    seperator({ valign: "center" }),
    powerMenu() 
  ]
});

export default monitors => ([
    ...monitors.map(mon => [
        topBar(mon),
    ]),
    shared.quickSettings({ position: 'top right' }),
]).flat(2);
