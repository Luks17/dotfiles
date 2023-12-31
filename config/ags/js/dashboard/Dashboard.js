import Widget from 'resource:///com/github/Aylur/ags/widget.js';
import DateColumn from './DateColumn.js';
import NotificationColumn from './NotificationColumn.js';
import PopupWindow from '../misc/PopupWindow.js';

export default () => PopupWindow({
  name: 'dashboard',
  anchor: ["top"],
  transition: "slide_down",
  child: Widget.Box({
    children: [
      NotificationColumn(),
      Widget.Separator({ orientation: 1 }),
      DateColumn(),
    ],
  }),
});
