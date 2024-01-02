import { Widget } from "resource:///com/github/Aylur/ags/widget.js";
import PopupWindow from "./misc/PopupWindow.js";
import Cliphist from "./services/cliphist.js"
import ClipItem from "./misc/ClipItem.js";
import icons from "./icons.js";
import FontIcon from "./misc/FontIcon.js";

const Header = () => Widget.Box({
  class_name: 'header',
  children: [
    Widget.Label({ label: 'Clipboard', hexpand: true, xalign: 0 }),
    ClearButton(),
  ],
});

const ClearButton = () => Widget.Button({
  on_primary_click_release: () => Cliphist.wipe(),
  child: Widget.Box({
    children: [
      Widget.Label('Clear '),
      Widget.Icon({
        binds: [['icon', Cliphist, "list", n =>
          n.length > 0 ? icons.trash.full : icons.trash.empty]]
      }),
    ],
  }),
})

const ClipboardItems = () => Widget.Box({
  vertical: true,
  vexpand: true,
  class_name: 'clipboard-items',
  connections: [[Cliphist, box => {
    box.children = Cliphist.list.map(ClipItem);
    box.visible = Cliphist.list.length > 0;
  }]],
});

const Placeholder = () => Widget.Box({
  class_name: 'placeholder',
  vertical: true,
  vpack: 'center',
  hpack: 'center',
  vexpand: true,
  hexpand: true,
  children: [
    FontIcon({ icon: icons.clipboard.off }),
    Widget.Label('Your clipboard history is empty'),
  ],
  binds: [['visible', Cliphist, 'list', n => n.length === 0]],
});

const ClipboardBox = () => Widget.Box({
  class_name: "clipboard-box",
  children: [
    Widget.Scrollable({
      vexpand: true,
      class_name: 'clipboard-scrollable',
      child: ClipboardItems(),
    }),
    Placeholder(),
  ],
})

export default () => PopupWindow({
  name: 'clipboard',
  transition: "slide_down",
  anchor: ["top", "right"],
  child: Widget.Box({
    vertical: true,
    children: [
      Header(),
      ClipboardBox(),
    ]
  }),
});
