import { lookUpIcon } from "resource:///com/github/Aylur/ags/utils.js";
import { Widget } from "resource:///com/github/Aylur/ags/widget.js";
import Hyprland from "resource:///com/github/Aylur/ags/service/hyprland.js";

export default () => Widget.Box({
  class_name: 'focused-app',
  children: [
    Widget.Icon({
      size: 18,
      icon: Hyprland.active.client.bind("class").transform(label =>
        lookUpIcon(label) ? label : "application-x-windows-themepack"
      )
    }),
    Widget.Label({
      xalign: 0,
      label: Hyprland.active.client.bind("class").transform(label =>
        String(label.length === 0 ? "desktop" : label)
      )
    }),
  ],
});
