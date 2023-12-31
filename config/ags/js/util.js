import GLib from 'gi://GLib';
import Gdk from "gi://Gdk";
import { CACHE_DIR, ensureDirectory, exec, execAsync, subprocess } from "resource:///com/github/Aylur/ags/utils.js";
import icons from './icons.js';
import Battery from 'resource:///com/github/Aylur/ags/service/battery.js';
import App from 'resource:///com/github/Aylur/ags/app.js';

/**
  * @param {number} length
  * @param {number=} start
  * @returns {Array<number>}
  */
export function range(length, start = 1) {
  return Array.from({ length }, (_, i) => i + start);
}

/**
  * @param {Array<[string, string] | string[]>} collection
  * @param {string} item
  * @returns {string}
  */
export function substitute(collection, item) {
  return collection.find(([from]) => from === item)?.[1] || item;
}

/**
  * @param {(monitor: number) => any} widget
  * @returns {Array<import('types/widgets/window').default>}
  */
export function forMonitors(widget) {
  const n = Gdk.Display.get_default()?.get_n_monitors() || 1;
  return range(n, 0).map(widget).flat(1);
}

/** @param {string} img - path to an img file */
export function blurImg(img) {
  const cache = CACHE_DIR + '/media';
  return new Promise(resolve => {
    if (!img)
      resolve('');

    const dir = cache + '/blurred';
    const blurred = dir + img.substring(cache.length);

    if (GLib.file_test(blurred, GLib.FileTest.EXISTS))
      return resolve(blurred);

    ensureDirectory(dir);
    execAsync(['convert', img, '-blur', '0x22', blurred])
      .then(() => resolve(blurred))
      .catch(() => resolve(''));
  });
}

/** @param {string} icon */
export function getAudioTypeIcon(icon) {
  const substitues = [
    ['audio-headset-bluetooth', icons.audio.type.headset],
    ['audio-card-analog-usb', icons.audio.type.speaker],
    ['audio-card-analog-pci', icons.audio.type.card],
  ];

  return substitute(substitues, icon);
}

/** @param {Array<string>} bins */
export function checkDependencies(bins) {
  const deps = bins.map(bin => {
    const has = exec(`which ${bin}`);
    if (!has)
      print(`missing dependency: ${bin}`);

    return !!has;
  });

  return deps.every(has => has);
}

export function warnOnLowBattery() {
  Battery.connect('changed', () => {
    const low = 15;
    if (Battery.percent <= low && !Battery.charging) {
      execAsync([
        'notify-send',
        `${Battery.percent}% on battery`,
        'Please charge your device',
        '-i', icons.battery.warning,
        '-u', 'critical',
      ]);
    }
  });
}

export function scssWatcher() {
  return subprocess(
    [
      'inotifywait',
      '--recursive',
      '--event', 'create,modify',
      '-m', App.configDir + '/scss',
    ],
    loadSassc,
    () => print('missing dependancy for css hotreload: inotify-tools'),
  );
}

export function loadSassc() {
  if (!checkDependencies(['sassc']))
    return;

  let scssDir = `${App.configDir}/scss`;

  // main scss file
  const scss = `${scssDir}/main.scss`;

  // target css file
  const css = `${App.configDir}/styles.css`;

  exec(`sassc ${scss} ${css}`);
  App.resetCss();
  App.applyCss(css);
}

