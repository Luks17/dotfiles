import Notifications from 'resource:///com/github/Aylur/ags/service/notifications.js';
import Widget from 'resource:///com/github/Aylur/ags/widget.js';
import Notification from './misc/Notification.js';
import { timeout } from 'resource:///com/github/Aylur/ags/utils.js';

/** @param {import('types/widgets/revealer').default} parent */
const Popups = parent => {
  const map = new Map();

  const onDismissed = (_, id, force = false) => {
    if (!id || !map.has(id))
      return;

    if (map.get(id).isHovered() && !force)
      return;

    if (map.size - 1 === 0)
      parent.reveal_child = false;

    timeout(200, () => {
      map.get(id)?.destroy();
      map.delete(id);
    });
  };

  /** @param {import('types/widgets/box').default} box */
  const onNotified = (box, id) => {
    if (!id || Notifications.dnd)
      return;

    const n = Notifications.getNotification(id);
    if (!n)
      return;

    map.delete(id);
    map.set(id, Notification(n));
    box.children = Array.from(map.values()).reverse();
    timeout(10, () => {
      parent.reveal_child = true;
    });
  };

  return Widget.Box({ vertical: true })
    .hook(Notifications, onNotified, 'notified')
    .hook(Notifications, onDismissed, 'dismissed')
    .hook(Notifications, (box, id) => onDismissed(box, id, true), 'closed');
};

/** @param {import('types/widgets/revealer').RevealerProps['transition']} transition */
const PopupList = (transition = 'slide_down') => Widget.Box({
  css: 'padding: 1px',
  children: [
    Widget.Revealer({
      transition,
      setup: self => self.child = Popups(self),
    }),
  ],
});

/** @param {number} monitor */
export default monitor => Widget.Window({
  monitor,
  name: `notifications${monitor}`,
  class_name: 'notifications',
  anchor: ["top", "left"],
  child: PopupList(),
});
