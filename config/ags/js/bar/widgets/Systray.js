import Widget from 'resource:///com/github/Aylur/ags/widget.js';
import SystemTray from 'resource:///com/github/Aylur/ags/service/systemtray.js';
import HoverableBtn from '../../misc/HoverableBtn.js';
import Gdk from 'gi://Gdk';

const SysTrayItem = item => HoverableBtn({
  binds: [['tooltipMarkup', item, 'tooltip-markup']],
  child: Widget.Icon({ binds: [['icon', item, 'icon']] }),
  setup: btn => {
    item.menu.toggleClassName("tray-menu");
    const id = item.menu.connect('popped-up', menu => {
      btn.toggleClassName('active');
      menu.connect('notify::visible', menu => {
        btn.toggleClassName('active', menu.visible);
      });
      menu.disconnect(id);
    });
  },
  onPrimaryClick: btn =>
    item.menu.popup_at_widget(btn, Gdk.Gravity.SOUTH, Gdk.Gravity.NORTH, null),
  onSecondaryClick: btn =>
    item.menu.popup_at_widget(btn, Gdk.Gravity.SOUTH, Gdk.Gravity.NORTH, null),
});

export default () => Widget.Box({
  class_name: 'tray',
  binds: [['children', SystemTray, 'items', i => i.map(SysTrayItem)]],
});
