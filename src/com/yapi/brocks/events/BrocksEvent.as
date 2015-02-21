package com.yapi.brocks.events
{
	import flash.events.Event;
	
	public class BrocksEvent extends Event
	{
		private var _lines:uint = 0;
		private var _level:uint = 0;
		private var _brocketType:uint;
		private var _obj:Object;
		
		public static const BROCKET_UPDATE:String = "brocketUpdate";
		public static const SCORE_UPDATE:String = "scoreUpdate";
		public static const DROP_UPDATE:String = "dropUpdate";
		public static const GAME_OVER:String = "gameOver";
		public static const LEVEL_UP:String = "levelUp";
		public static const GROUND_ZERO:String = "GroundZero";
		
		public function BrocksEvent(type:String, obj:Object = null, bubbles:Boolean = false, cancelable:Boolean = false)
		{
			this._obj = obj;
			super(type, bubbles, cancelable);
			if (this._obj)
			{
				this._level = obj.hasOwnProperty("level") ? (obj.level) : (0);
				this._lines = obj.hasOwnProperty("lines") ? (obj.lines) : (0);
				this._brocketType = obj.hasOwnProperty("brocketType") ? (obj.brocketType) : (0);
			}
		}
		
		public function get level():uint
		{
			return this._level;
		}

		public function get lines():uint
		{
			return this._lines;
		}
		
		public function get brocketType():uint
		{
			return this._brocketType;
		}

		override public function clone():Event
		{
			return new BrocksEvent(type, this._obj, bubbles,  cancelable);
		}
	
		override public function toString():String
		{
			return formatToString("BrocksEvent", "type", "bubbles", "cancelable", "eventPhase");
		}
	}
}