import App from 'resource:///com/github/Aylur/ags/app.js';
import Widget from 'resource:///com/github/Aylur/ags/widget.js';
import Notifications from 'resource:///com/github/Aylur/ags/service/notifications.js';
import Bluetooth from 'resource:///com/github/Aylur/ags/service/bluetooth.js';
import Audio from 'resource:///com/github/Aylur/ags/service/audio.js';
import Network from 'resource:///com/github/Aylur/ags/service/network.js';
import HoverRevealer from '../../misc/HoverRevealer.js';
import Indicator from '../../services/onScreenIndicator.js';
import icons from '../../icons.js';
import HoverableBtn from '../../misc/HoverableBtn.js';


const MicrophoneIndicator = () => Widget.Icon().hook(Audio, icon => {
  if (!Audio.microphone)
    return;

  const { muted, low, medium, high } = icons.audio.mic;
  if (Audio.microphone.is_muted)
    return icon.icon = muted;

  /** @type {Array<[number, string]>} */
  const cons = [[67, high], [34, medium], [1, low], [0, muted]];
  icon.icon = cons.find(([n]) => n <= Audio.microphone.volume * 100)?.[1] || '';

  icon.visible = Audio.recorders.length > 0 || Audio.microphone.is_muted;
}, 'speaker-changed');

const DNDIndicator = () => Widget.Icon({
  visible: Notifications.bind('dnd'),
  icon: icons.notifications.silent,
});

const BluetoothDevicesIndicator = () => Widget.Box().hook(Bluetooth, box => {
  box.children = Bluetooth.connected_devices
    .map(({ icon_name, name }) => HoverRevealer({
      indicator: Widget.Icon(icon_name + '-symbolic'),
      child: Widget.Label(name),
    }));

  box.visible = Bluetooth.connected_devices.length > 0;
}, 'notify::connected-devices');

const BluetoothIndicator = () => Widget.Icon({
  class_name: 'bluetooth',
  icon: icons.bluetooth.enabled,
  visible: Bluetooth.bind('enabled'),
});

const NetworkIndicator = () => Widget.Icon().hook(Network, self => {
  const icon = Network[Network.primary || 'wifi']?.icon_name;
  self.icon = icon || '';
  self.visible = !!icon;
});

const AudioIndicator = () => Widget.Icon().hook(Audio, self => {
  if (!Audio.speaker)
    return;

  const { muted, low, medium, high, overamplified } = icons.audio.volume;
  if (Audio.speaker.is_muted)
    return self.icon = muted;


  /** @type {Array<[number, string]>} */
  const cons = [[101, overamplified], [67, high], [34, medium], [1, low], [0, muted]];
  self.icon = cons.find(([n]) => n <= Audio.speaker.volume * 100)?.[1] || '';
}, 'speaker-changed');

export default () => HoverableBtn({
  class_name: 'panel-button',
  on_clicked: () => App.toggleWindow('main-menu'),
  setup: self => self
    .hook(App, (_, win, visible) => {
      self.toggleClassName('active', win === 'main-menu' && visible);
    }),
  on_scroll_up: () => {
    Audio.speaker.volume += 0.02;
    Indicator.speaker();
  },
  on_scroll_down: () => {
    Audio.speaker.volume -= 0.02;
    Indicator.speaker();
  },
  child: Widget.Box({
    class_name: "system-indicators",
    children: [
      DNDIndicator(),
      BluetoothDevicesIndicator(),
      BluetoothIndicator(),
      NetworkIndicator(),
      AudioIndicator(),
      MicrophoneIndicator(),
    ],
  }),
});