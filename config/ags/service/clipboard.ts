import { bash } from "lib/utils";

class Clipboard extends Service {
	static {
		Service.register(this, {}, {});
	}

	readonly open = async () => {
		bash("kitty --title fly_is_kitty -e clipse");
	};
}

export default new Clipboard();
