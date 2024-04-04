import icons from "../../icons.js";
import FontIcon from "../../misc/FontIcon.js";
import HoverableBtn from "../../misc/HoverableBtn.js";
import App from "resource:///com/github/Aylur/ags/app.js";
import wallpaper from "../../services/wallpaper.js";
import Widget from "resource:///com/github/Aylur/ags/widget.js";
import keyboardLayout from "../../services/keyboardLayout.js";

const WallpaperBtn = () =>
  HoverableBtn({
    class_name: "wallpaper-button",
    label: "  ",
    on_clicked: () => wallpaper.cycle(),
  });

const ClipboardBtn = () =>
  HoverableBtn({
    class_name: "clipboard-button",
    on_clicked: () => App.toggleWindow("clipboard"),
    child: Widget.Box({
      children: [
        FontIcon({ icon: icons.clipboard.tray, css: "font-size: 14px;" }),
      ],
      class_name: "clipboard-icon",
    }),
  });

const KbdLayoutBtn = () =>
  HoverableBtn({
    class_name: "kbd-layout-button",
    on_clicked: () => keyboardLayout.next(),
    child: FontIcon({ icon: icons.keyboard, css: "font-size: 20px;" }),
  });

export default () =>
  Widget.Box({
    class_name: "utils-panel",
    children: [ClipboardBtn(), WallpaperBtn(), KbdLayoutBtn()],
  });
