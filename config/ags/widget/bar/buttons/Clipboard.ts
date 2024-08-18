import PanelButton from "../PanelButton";
import clipboard from "service/clipboard";

export default () =>
	PanelButton({
		class_name: "clipboard",
		child: Widget.Icon("clipboard"),
		on_clicked: clipboard.open,
		tooltip_text: "Browse clipboard",
	});
