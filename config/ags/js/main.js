import Clipboard from "./Clipboard.js";
import Notifications from "./Notifications.js";
import Bar from "./bar/Bar.js";
import Dashboard from "./dashboard/Dashboard.js";
import Menu from "./menu/Menu.js";
import { forMonitors, loadSassc, warnOnLowBattery } from "./util.js";

warnOnLowBattery();
loadSassc();
// scssWatcher();

globalThis.keyboardLayout = (
  await import("./services/keyboardLayout.js")
).default;

const windows = () => [
  forMonitors(Bar),
  forMonitors(Notifications),
  Dashboard(),
  Clipboard(),
  Menu(),
];

App.config({
  windows: windows().flat(1),
  closeWindowDelay: {
    "main-menu": 300,
    dashboard: 300,
    clipboard: 300,
  },
});
