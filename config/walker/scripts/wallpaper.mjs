import { readdirSync } from "node:fs";
import { join } from "node:path";

const WALLPAPER_DIR = "/home/luks/.config/hypr/wallpapers";

const getCmd = (file) =>
  `swww img --transition-fps 60 --transition-duration 2 --transition-type any "${file}"`;
const isImage = (f) => /\.(jpe?g|png|bmp|webp|gif)$/i.test(f);

const files = readdirSync(WALLPAPER_DIR)
  .filter(isImage)
  .map((name) => join(WALLPAPER_DIR, name));

files.forEach((file) => {
  // Output one KV line per entry; Walker’s “kv” parser will split on `;` and `=`
  console.log(
    [
      `label=${file.split("/").pop()}`,
      `image=${file}`,
      `exec=${getCmd(file)}`,
      `matching=1`,
      `drag_drop=true`,
      `drag_drop_data=${file}`,
      `class=pic`,
    ].join(";"),
  );
});
