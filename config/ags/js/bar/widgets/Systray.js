import Widget from 'resource:///com/github/Aylur/ags/widget.js';
import SystemTray from 'resource:///com/github/Aylur/ags/service/systemtray.js';
import HoverableBtn from '../../misc/HoverableBtn.js';
import Gdk from 'gi://Gdk';

/** @param {import('types/service/systemtray').TrayItem} item */
const SysTrayItem = item => HoverableBtn({
  tooltip_markup: item.bind('tooltip_markup'),
  child: Widget.Icon({ icon: item.bind("icon") }),
  setup: self => {
    item.menu?.toggleClassName("tray-menu");
    const id = item.menu?.connect('popped-up', menu => {
      self.toggleClassName('active');
      menu.connect('notify::visible', menu => {
        self.toggleClassName('active', menu.visible);
      });
      menu.disconnect(id);
    });
  },

  onPrimaryClick: btn =>
    item.menu?.popup_at_widget(btn, Gdk.Gravity.SOUTH, Gdk.Gravity.NORTH, null),

  onSecondaryClick: btn =>
    item.menu?.popup_at_widget(btn, Gdk.Gravity.SOUTH, Gdk.Gravity.NORTH, null),
});

export default () => Widget.Box().bind("children", SystemTray, "items", i => i.map(SysTrayItem));
