import icons from "../../icons.js";
import FontIcon from "../../misc/FontIcon.js";
import HoverableBtn from "../../misc/HoverableBtn.js";
import App from "resource:///com/github/Aylur/ags/app.js";
import { Widget } from "resource:///com/github/Aylur/ags/widget.js";

const ClipboardBtn = () => HoverableBtn({
  class_name: "clipboard-button",
  on_clicked: () => App.toggleWindow('clipboard'),
  child: Widget.Box({
    children: [FontIcon({ icon: icons.clipboard.tray, css: "font-size: 14px;" })],
    class_name: 'clipboard-icon',
  }),
});

export default () => Widget.Box({
  class_name: 'utils-panel',
  children: [
    ClipboardBtn(),
  ],
});