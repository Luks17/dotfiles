import Widget from "resource:///com/github/Aylur/ags/widget.js";
import * as battery from "../../misc/battery.js";

export default () =>
  Widget.Box({
    class_name: "battery-bar",
    hpack: "end",
    children: [battery.Indicator(), battery.LevelLabel()],
  });
