import { USER, execAsync } from "resource:///com/github/Aylur/ags/utils.js";
import HoverableBtn from "../../misc/HoverableBtn.js";
import Widget from "resource:///com/github/Aylur/ags/widget.js";
import FontIcon from "../../misc/FontIcon.js";
import icons from "../../icons.js";

export default () =>
  HoverableBtn({
    class_name: "powermenu",
    on_primary_click: () =>
      execAsync(
        `/usr/bin/sh -c 'sleep 0.2s && /home/${USER}/.config/rofi/powermenu/powermenu.sh'`,
      ),
    child: Widget.Box({
      children: [FontIcon({ icon: icons.power })],
      class_name: "power_icon",
    }),
  });
