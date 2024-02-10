import Battery from 'resource:///com/github/Aylur/ags/service/battery.js';
import Widget from 'resource:///com/github/Aylur/ags/widget.js';

const icons = charging => ([
  ...Array.from({ length: 10 }, (_, i) => i * 10).map(i => ([
    `${i}`, Widget.Icon({
      class_name: `${i} ${charging ? 'charging' : 'discharging'}`,
      icon: `battery-level-${i}${charging ? '-charging' : ''}-symbolic`,
    }),
  ])),
  ['100', Widget.Icon({
    class_name: `100 ${charging ? 'charging' : 'discharging'}`,
    icon: `battery-level-100${charging ? '-charged' : ''}-symbolic`,
  })],
]);

const Indicators = charging => Widget.Stack({
  items: icons(charging),
  shown: Battery.bind("percent").transform(p => `${Math.floor(p / 10) * 10}`)
});

export const Indicator = ({
  charging = Indicators(true),
  discharging = Indicators(false),
  ...props
} = {}) => Widget.Stack({
  ...props,
  class_name: 'battery__indicator',
  items: [
    ['true', charging],
    ['false', discharging],
  ],
  setup: self => self.hook(Battery, () => {
    const { charging, charged } = Battery;
    self.shown = `${charging || charged}`;
    self.toggleClassName('charging', Battery.charging);
    self.toggleClassName('charged', Battery.charged);
    self.toggleClassName('low', Battery.percent < 30);

  })
});

export const LevelLabel = props => Widget.Label({
  ...props,
  label: Battery.bind("percent").transform(p => `${p}%`)
});

