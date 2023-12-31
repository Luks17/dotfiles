import Widget from "resource:///com/github/Aylur/ags/widget.js";
import Hyprland from "resource:///com/github/Aylur/ags/service/hyprland.js";
import { range } from "../../util.js";
import { execAsync } from "resource:///com/github/Aylur/ags/utils.js";

/** @param {any} arg */
const dispatch = arg => execAsync(`hyprctl dispatch workspace ${arg}`);

const ws = 10;

const Workspaces = () => {
  return Widget.Box({
    children: range(ws || 20).map(i => Widget.Button({
      setup: btn => btn.id = i,
      on_clicked: () => dispatch(i),
      label: `${i % 10}`,
      class_name: 'indicator',
      vpack: 'center',
      connections: [[Hyprland, btn => {
        btn.toggleClassName('active', Hyprland.active.workspace.id === i);
        btn.toggleClassName('occupied', Hyprland.getWorkspace(i)?.windows > 0);
      }]],
    })),
    connections: ws ? [] : [[Hyprland.active.workspace, box => box.children.map(btn => {
      btn.visible = Hyprland.workspaces.some(ws => ws.id === btn.id);
    })]],
  });
};

export default () => Widget.Box({
  class_name: 'workspaces',
  child: Widget.Box({
    child: Widget.EventBox({
      on_scroll_up: () => dispatch("m+1"),
      on_scroll_down: () => dispatch("m-1"),
      class_name: 'eventbox',
      child: Workspaces(),
    }),
  }),
});
