package com.yapi.brocks.data
{
	public class BrocketType extends Object
	{
		private var _type:uint;
		public static const I:uint = 0;
		public static const T:uint = 1;
		public static const L:uint = 2;
		public static const J:uint = 3;
		public static const Z:uint = 4;
		public static const S:uint = 5;
		public static const O:uint = 6;
		
		private static const NUM_OF_TYPES:uint = 7;
		
		private static const ALL:Array = [I, T, L, J, Z, S, O];
		private static var _history:Array = [S, Z, O, ""];
		
		public function BrocketType(type:uint)
		{
			this._type = type;
			return;
		}
		
		public function set type(type:uint):void
		{
			if (isValidType(type))
			{
				this.type = type;
			} else {
				throw new Error ("Invalid Brocket type specified");
			}
			return;
		}
		
		public function get type():uint
		{
			return this._type;
		}

		public static function get random():uint
		{
			var type:uint;
			
			for (var i:int = 0; i < 4; i++) {
				type = ALL[randomPos];
				if (_isRecent(type))
				{
					
				} else {
					break;
				}
			}
			
			_addToHistory(type);
			
			return type;
		}
		
		private static function get randomPos():uint
		{
			return Math.floor(Math.random() * NUM_OF_TYPES);
		}
		
		public static function isValidType(type:uint):Boolean
		{
			switch(type) {
				case I:
				case T:
				case L:
				case J:
				case Z:
				case S:
				case O:
				{
					return true;
				}
				default:
				{
					return false;
					break;
				}
			}
		}

		private static function _isRecent(type:uint):Boolean
		{
			return _history.indexOf(type) != -1;
		}
		
		private static function _addToHistory(type:uint):void
		{
			_history.pop();
			_history.unshift(type);
			return;
		}
	}
}