import Widget from "resource:///com/github/Aylur/ags/widget.js";
import Hyprland from "resource:///com/github/Aylur/ags/service/hyprland.js";
import { range } from "../../util.js";
import { execAsync } from "resource:///com/github/Aylur/ags/utils.js";

/** @param {any} arg */
const dispatch = arg => execAsync(`hyprctl dispatch workspace ${arg}`);

const ws = 10;

const Workspaces = () => {
  return Widget.Box({
    children: range(ws).map(i => Widget.Button({
      attribute: i,
      on_clicked: () => dispatch(i),
      label: `${i % 10}`,
      class_name: 'indicator',
      vpack: 'center',
      setup: self => self.hook(Hyprland, () => {
        self.toggleClassName('active', Hyprland.active.workspace.id === i);
        self.toggleClassName('occupied', (Hyprland.getWorkspace(i)?.windows || 0) > 0);
      }),
    })),
  });
};

export default () => Widget.EventBox({
  class_name: 'workspaces',
  child: Widget.Box({
    child: Widget.EventBox({
      on_scroll_up: () => dispatch('m+1'),
      on_scroll_down: () => dispatch('m-1'),
      class_name: 'eventbox',
      child: Workspaces(),
    }),
  }),
});
