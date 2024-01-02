import { Widget } from "resource:///com/github/Aylur/ags/widget.js";
import Launcher from "./widgets/Launcher.js";
import Workspaces from "./widgets/Workspaces.js";
import FocusedApp from "./widgets/FocusedApp.js";
import Clock from "./widgets/Clock.js";
import Submenu from "./widgets/Submenu.js";
import Systray from "./widgets/Systray.js";
import Variable from "resource:///com/github/Aylur/ags/variable.js";
import SystemTray from 'resource:///com/github/Aylur/ags/service/systemtray.js';
import SystemIndicators from "./widgets/SystemIndicators.js";
import BatteryBar from "./widgets/BatteryBar.js";
import Powermenu from "./widgets/Powermenu.js";
import Utils from "./widgets/Utils.js";

const submenuItems = Variable(1);
SystemTray.connect('changed', () => {
  submenuItems.setValue(SystemTray.items.length + 1);
});

const Separator = () => Widget.Box({
  hexpand: false,
  vexpand: false,
  class_name: "separator"
});

const Start = () => Widget.Box({
  class_name: "bar_start",
  children: [
    Launcher(),
    Separator(),
    Workspaces(),
    Separator(),
    FocusedApp(),
    Widget.Box({ hexpand: true }),
  ]
})

const Center = () => Widget.Box({
  class_name: "bar_center",
  children: [
    Clock(),
  ]
})

const End = () => Widget.Box({
  class_name: "bar_end",
  children: [
    Widget.Box({ hexpand: true }),
    Submenu({
      items: Variable(1),
      children: [
        Systray(),
      ],
    }),
    Separator(),
    SystemIndicators(),
    Separator(),
    Utils(),
    Separator(),
    BatteryBar(),
    Separator(),
    Powermenu(),
  ]
})

/** @param {number} monitor */
export default monitor => Widget.Window({
  name: `bar${monitor}`,
  class_name: "transparent",
  anchor: ["top", "left", "right"],
  exclusivity: "exclusive",
  monitor,
  child: Widget.CenterBox({
    class_name: "panel",
    start_widget: Start(),
    center_widget: Center(),
    end_widget: End(),
  }),
})
