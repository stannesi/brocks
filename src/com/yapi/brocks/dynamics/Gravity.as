package com.yapi.brocks.dynamics
{
	import flash.events.TimerEvent;
	import flash.utils.Timer;

	public class Gravity extends Object
	{
		private var _timer:Timer;
		private const DELAY:uint = 700;
		private const SWIFT_DELAY:uint = 25;
		private var _velocity:uint;
		
		public function Gravity()
		{
			this._timer = new Timer(700 - 50 * this._velocity);
			return;
		}
		
		public function set velocity(val:uint):void
		{
			if (val < 13)
			{
				this._velocity = val;
			}
			this._timer.delay = 700 - 50 * this._velocity;
			return;
		}

		public function start():void
		{
			this._timer.start();
			return;
		}

		public function stop():void
		{
			this._timer.stop();
			return;
		}

		public function register(func:Function):void
		{
			this._timer.addEventListener(TimerEvent.TIMER, func);
			return;
		}

		public function unregister(func:Function):void
		{
			this._timer.removeEventListener(TimerEvent.TIMER, func);
			return;
		}
		
		public function set swiftDropMode(val:Boolean):void
		{
			if (val)
			{
				this._timer.delay = this.SWIFT_DELAY;
			} else {
				this._timer.delay = 700 - 50 * this._velocity;
			}
			return;
		}

		public function get swiftDropMode():Boolean
		{
			return this._timer.delay == this.SWIFT_DELAY;
		}
	}
}