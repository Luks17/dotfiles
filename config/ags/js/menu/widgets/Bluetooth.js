import Bluetooth from 'resource:///com/github/Aylur/ags/service/bluetooth.js';
import Widget from 'resource:///com/github/Aylur/ags/widget.js';
import icons from '../../icons.js';
import { Menu, ArrowToggleButton } from '../ToggleButton.js';
import Applications from 'resource:///com/github/Aylur/ags/service/applications.js';
import { execAsync } from 'resource:///com/github/Aylur/ags/utils.js';

export const BluetoothToggle = () => ArrowToggleButton({
  name: 'bluetooth',
  icon: Widget.Icon({
    connections: [[Bluetooth, icon => {
      icon.icon = Bluetooth.enabled
        ? icons.bluetooth.enabled
        : icons.bluetooth.disabled;
    }]],
  }),
  label: Widget.Label({
    truncate: 'end',
    connections: [[Bluetooth, label => {
      if (!Bluetooth.enabled)
        return label.label = 'Disabled';

      if (Bluetooth.connected_devices.length === 0)
        return label.label = 'Not Connected';

      if (Bluetooth.connected_devices.length === 1)
        return label.label = Bluetooth.connected_devices[0].alias;

      label.label = `${Bluetooth.connected_devices.length} Connected`;
    }]],
  }),
  connection: [Bluetooth, () => Bluetooth.enabled],
  deactivate: () => execAsync("systemctl stop bluetooth.service").catch(e => print(e)),
  activate: () => {
    if (!Bluetooth.enabled)
      execAsync("systemctl start bluetooth.service").catch(e => print(e));
  },
});

const DeviceItem = device => Widget.Box({
  class_name: "device-item",
  children: [
    Widget.Icon(device.icon_name + '-symbolic'),
    Widget.Label(device.name),
    Widget.Label({
      label: ` ${device.battery_percentage}%`,
      binds: [['visible', device, 'battery-percentage', p => p > 0]],
    }),
    Widget.Box({ hexpand: true }),
    Widget.Spinner({
      binds: [
        ['active', device, 'connecting'],
        ['visible', device, 'connecting'],
      ],
    }),
    Widget.Switch({
      active: device.connected,
      binds: [['visible', device, 'connecting', c => !c]],
      connections: [['notify::active', ({ active }) => {
        device.setConnection(active);
      }]],
    }),
  ],
});

export const BluetoothDevices = () => Menu({
  name: 'bluetooth',
  icon: Widget.Icon(icons.bluetooth.disabled),
  title: Widget.Label('Bluetooth'),
  content: [
    Widget.Box({
      hexpand: true,
      vertical: true,
      binds: [['children', Bluetooth, 'devices', ds => ds
        .filter(d => d.name)
        .map(DeviceItem)]],
    }),
    Widget.Separator(),
    Widget.Button({
      on_clicked: () => Applications.query('blueman-manager')?.[0].launch(),
      child: Widget.Box({
        children: [
          Widget.Icon(icons.ui.settings),
          Widget.Label('Connections'),
        ],
      }),
    }),
  ],
});
