import Widget from 'resource:///com/github/Aylur/ags/widget.js';
import PopupWindow from '../misc/PopupWindow.js';
import { AppMixer, Microhone, SinkSelector, Volume } from './widgets/Volume.js';
import Brightness from './widgets/Brightness.js';
import Media from './widgets/Media.js';
import { NetworkToggle, WifiSelection } from './widgets/Network.js';
import { BluetoothDevices, BluetoothToggle } from './widgets/Bluetooth.js';
import DND from './widgets/DND.js';

const Row = (toggles = [], menus = []) => Widget.Box({
  vertical: true,
  children: [
    Widget.Box({
      class_name: 'row horizontal',
      children: toggles,
    }),
    ...menus,
  ],
});

const Homogeneous = toggles => Widget.Box({
  homogeneous: true,
  children: toggles,
});

export default () => PopupWindow({
  name: 'main-menu',
  transition: "slide_down",
  anchor: ["top", "right"],
  child: Widget.Box({
    vertical: true,
    children: [
      Widget.Box({
        class_name: 'sliders-box vertical',
        vertical: true,
        children: [
          Row(
            [Volume()],
            [SinkSelector(), AppMixer()],
          ),
          Microhone(),
          Brightness(),
        ],
      }),
      Row(
        [Homogeneous([NetworkToggle(), BluetoothToggle()]), DND()],
        [WifiSelection(), BluetoothDevices()],
      ),
      Media(),
    ],
  }),
});
