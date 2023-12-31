import Clock from "../../misc/Clock.js";
import HoverableButton from "../../misc/HoverableBtn.js";
import App from 'resource:///com/github/Aylur/ags/app.js';

export default ({
  format = '%a %d %b, %H:%M',
} = {}) => HoverableButton({
  cursor: 'pointer',
  on_clicked: () => App.toggleWindow('dashboard'),
  class_name: 'clock',
  child: Clock({ format }),
});
