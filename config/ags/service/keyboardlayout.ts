import Service from "resource:///com/github/Aylur/ags/service.js";
import { execAsync } from "resource:///com/github/Aylur/ags/utils.js";

const layouts = ["English", "Português"];

class KeyboardLayout extends Service {
  static {
    Service.register(this, {}, {});
  }

  #current = 0;

  #layout = "";

  get layout() {
    return this.#layout;
  }

  #notify() {
    execAsync(`notify-send "Keyboard Layout" "${this.#layout}"`).catch((e) =>
      print(e),
    );
  }

  async next() {
    this.#current = (this.#current + 1) % layouts.length;

    this.#layout = layouts[this.#current];

    await execAsync(
      "hyprctl switchxkblayout at-translated-set-2-keyboard next",
    ).catch((e) => print(e));
    this.#notify();
  }

  constructor() {
    super();

    this.#layout = layouts[this.#current];
  }
}

const keyboardlayout = new KeyboardLayout();
Object.assign(globalThis, { keyboardlayout });
