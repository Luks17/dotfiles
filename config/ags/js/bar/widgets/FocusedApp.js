import { lookUpIcon } from "resource:///com/github/Aylur/ags/utils.js";
import { Widget } from "resource:///com/github/Aylur/ags/widget.js";
import Hyprland from "resource:///com/github/Aylur/ags/service/hyprland.js";

export default () => Widget.Box({
  class_name: 'focused-app',
  children: [
    Widget.Icon({
      size: 18,
      connections: [
        [Hyprland.active.client, icon => {
          if (lookUpIcon(Hyprland.active.client.class))
            icon.icon = Hyprland.active.client.class;
          else
            icon.icon = "application-x-windows-themepack";
        }],
      ],
    }),
    Widget.Label({
      xalign: 0,
      connections: [
        [Hyprland.active.client, label => { // Hyprland.active.client
          label.label = String(Hyprland.active.client.class.length === 0 ? "desktop" : Hyprland.active.client.class);
        }],
      ],
    }),
  ],
});
