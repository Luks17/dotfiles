import Service from "resource:///com/github/Aylur/ags/service.js";
import { exec, execAsync } from "resource:///com/github/Aylur/ags/utils.js";
import { Variable } from "resource:///com/github/Aylur/ags/variable.js";

class Cliphist extends Service {
  static {
    Service.register(
      this,
      {},
      {
        list: ["jsobject"],
      },
    );
  }

  /** @type {Variable<string[]>} */
  #list = new Variable([], {
    listen: [
      "wl-paste --watch wl-paste",
      (_) => exec("cliphist list").split("\n"),
    ],
  });

  get list() {
    // needed because ags keeps converting [] to [""]
    if (this.#list.value.length === 1 && this.#list.value[0] === "") {
      return [];
    }
    return this.#list.value;
  }

  /** @param {String} item */
  copy(item) {
    execAsync([
      "bash",
      "-c",
      `echo "${item}" | cliphist decode | wl-copy`,
    ]).catch((e) => print(e));
  }

  /** @param {String} item */
  delete(item) {
    execAsync(["bash", "-c", `echo "${item}" | cliphist delete`]).catch((e) =>
      print(e),
    );
  }

  wipe() {
    execAsync("cliphist wipe")
      .then(() => this.#list.setValue([]))
      .catch((e) => print(e));
  }

  constructor() {
    super();

    this.#list.connect("changed", () => this.changed("list"));

    this.#list.setValue(exec("cliphist list").split("\n"));
  }
}

export default new Cliphist();
