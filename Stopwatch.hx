package;

using api.IdeckiaApi;

import datetime.DateTime;

typedef Props = {
	@:editable("prop_precission", 's', ['m', 's'])
	var precission:String;
}

@:name('stopwatch')
@:description('action_description')
@:localize
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
				core.log.error('Not identified precission: $x. Using the default "s".');
				SECONDS_PRECISSION;
		}

		paused = true;
		return js.lib.Promise.resolve(initialState);
	}

	function newTimer() {
		timer = new haxe.Timer(precissionMs);
		timer.run = timerRun;
	}

	function timerRun() {
		time = time.add((precissionMs == MINUTES_PRECISSION) ? Minute(1) : Second(1));
		state.text = time.format('%T');
		core.updateClientState(state);
	}

	public function execute(currentState:ItemState):js.lib.Promise<ActionOutcome> {
		state = currentState;
		if (paused) {
			newTimer();
		} else {
			timer.stop();
			timer = null;
		}

		paused = !paused;

		currentState.bgColor = paused ? 'ffaa0000' : 'ff00aa00';

		return js.lib.Promise.resolve(new ActionOutcome({state: currentState}));
	}

	override function onLongPress(currentState:ItemState):js.lib.Promise<ActionOutcome> {
		time = 0;
		return super.onLongPress(currentState);
	}
}
