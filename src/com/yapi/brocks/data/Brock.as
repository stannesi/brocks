package com.yapi.brocks.data
{
	import com.yapi.brocks.display.Rock;

	public class Brock extends Object
	{
		private var _x:int, _y:int;
		private var _type:uint;
		private var _color:uint;
		private var _rock:Rock;
		
		public function Brock(x:int, y:int)
		{
			this._x = x;
			this._y = y;
		}
		
		// setters
		public function set x(val:int):void
		{
			this._x = val;
			if (this._rock)
				this._rock.x = this._x * Rock.SIZE;
		}

		public function set y(val:int):void
		{
			this._y = val;
			
			if (this._rock)
				this._rock.y = this._y * Rock.SIZE;
		}
		
		public function set type(val:uint):void
		{
			this._type = val;
		}

		public function set color(val:uint):void
		{
			this._color = val;
		}

		// getters
		public function get x():int
		{
			return this._x;
		}
		
		public function get y():int
		{
			return this._y;
		}
		
		public function get type():uint
		{
			return this._type;
		}

		public function get color():uint
		{
			return this._color;
		}
		
		public function render():Rock
		{
			//this._rock = this._rock ? (this._rock) : new Rock(BrocketColor.getColor(this.type));
			this._rock = this._rock ? (this._rock) : new Rock(BrocketColor.getSprite(this.type), true);
			this._rock.x = this.x * Rock.SIZE;
			this._rock.y = this.y * Rock.SIZE;
			return _rock;
		}
	}
}