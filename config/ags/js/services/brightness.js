import Service from 'resource:///com/github/Aylur/ags/service.js';
import { checkDependencies } from '../util.js';
import { exec, execAsync } from 'resource:///com/github/Aylur/ags/utils.js';

class Brightness extends Service {
  static {
    Service.register(this, {}, {
      'screen': ['float', 'rw'],
    });
  }

  #screen = 0;

  get screen() { return this.#screen; }


  set screen(percent) {
    if (!checkDependencies(['brightnessctl']))
      return;

    if (percent < 0)
      percent = 0;

    if (percent > 1)
      percent = 1;

    execAsync(`brightnessctl s ${percent * 100}% -q`)
      .then(() => {
        this.#screen = percent;
        this.changed('screen');
      })
      .catch(console.error);
  }

  constructor() {
    super();

    if (checkDependencies(['brightnessctl'])) {
      this.#screen = Number(exec('brightnessctl g')) / Number(exec('brightnessctl m'));
    }
  }
}


export default new Brightness();
