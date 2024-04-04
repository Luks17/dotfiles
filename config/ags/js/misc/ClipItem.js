import cliphist from "../services/cliphist.js";
import Widget from "resource:///com/github/Aylur/ags/widget.js";

/** @param {String} clipitem */
export default (clipitem) => {
  const content = Widget.Label({
    xalign: 0,
    justification: "left",
    hexpand: true,
    max_width_chars: 24,
    truncate: "end",
    wrap: true,
    label: clipitem.split("\t", 2)[1],
  });

  return Widget.Button({
    class_name: "clipboard-item",
    vexpand: false,
    on_primary_click_release: () => cliphist.copy(clipitem),
    on_middle_click_release: () => cliphist.delete(clipitem),
    child: content,
  });
};
