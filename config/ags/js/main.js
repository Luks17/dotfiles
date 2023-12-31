import Notifications from "./Notifications.js";
import Bar from "./bar/Bar.js";
import Dashboard from "./dashboard/Dashboard.js";
import Menu from "./menu/Menu.js";
import { forMonitors, loadSassc, scssWatcher, warnOnLowBattery } from "./util.js";

warnOnLowBattery();
loadSassc();
scssWatcher();

const windows = () => [
  forMonitors(Bar),
  forMonitors(Notifications),
  Dashboard(),
  Menu()
]

export default {
  windows: windows().flat(1),
  maxStreamVolume: 1.5,
  cacheNotificationActions: false,
  closeWindowDelay: {
    'main-menu': 300,
    'dashboard': 300,
  },
};
