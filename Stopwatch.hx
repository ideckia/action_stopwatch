package;

using api.IdeckiaApi;

import datetime.DateTime;

typedef Props = {
	@:editable("The timer will run at the interval of this value.", 's', ['m', 's'])
	var precission:String;
	@:editable("If true it will reset the timer to 0. If false, it will continue from where it was paused.", false)
	var ?reset:Bool;
}

@:name('stopwatch')
class Stopwatch extends IdeckiaAction {
	static inline var MINUTES_PRECISSION:UInt = 60 * 1000;
	static inline var SECONDS_PRECISSION:UInt = 1000;

	var state:ItemState;
	var precissionMs:UInt = 0;
	var paused:Bool;
	var timer:haxe.Timer;
	var time:DateTime = 0;

	override public function init(initialState:ItemState):js.lib.Promise<ItemState> {
		precissionMs = switch this.props.precission {
			case 'm':
				MINUTES_PRECISSION;
			case 's':
				SECONDS_PRECISSION;
			case x:
				server.log.error('Not identified precission: $x. Using the default "s".');
				SECONDS_PRECISSION;
		}

		paused = true;
		return new js.lib.Promise((resolve, reject) -> resolve(initialState));
	}

	function newTimer() {
		timer = new haxe.Timer(precissionMs);
		timer.run = timerRun;
	}

	function timerRun() {
		time = time.add((precissionMs == MINUTES_PRECISSION) ? Minute(1) : Second(1));
		state.text = time.format('%T');
		server.updateClientState(state);
	}

	public function execute(currentState:ItemState):js.lib.Promise<ItemState> {
		state = currentState;
		if (paused) {
			if (props.reset)
				time = 0;
			newTimer();
		} else {
			timer.stop();
			timer = null;
		}

		paused = !paused;

		currentState.bgColor = paused ? 'ffaa0000' : 'ff00aa00';

		return new js.lib.Promise((resolve, reject) -> resolve(currentState));
	}
}
