import Service from "resource:///com/github/Aylur/ags/service.js";
import {
  USER,
  exec,
  execAsync,
  monitorFile,
} from "resource:///com/github/Aylur/ags/utils.js";

class Wallpaper extends Service {
  static {
    Service.register(this, {}, {});
  }

  #wallpaperDir = `/home/${USER}/.config/hypr/wallpapers`;

  #current = -1;
  #list = exec(`find ${this.#wallpaperDir} -type f`).split("\n");

  cycle() {
    this.#current = (this.#current + 1) % this.#list.length;
    execAsync(
      `swww img ${this.#list[this.#current]} --transition-type grow --transition-pos "top-right" --transition-duration 3`,
    ).catch((e) => print(e));
  }

  #onDirChange() {
    this.#list = exec(`find ${this.#wallpaperDir} -type f`).split("\n");
    this.#current = -1;
  }

  constructor() {
    super();

    monitorFile(this.#wallpaperDir, () => this.#onDirChange());
  }
}

export default new Wallpaper();
