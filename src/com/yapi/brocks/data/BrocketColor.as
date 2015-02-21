package com.yapi.brocks.data
{
	import com.yapi.brocks.display.Rock;
	
	public class BrocketColor extends Object
	{
		public var _color:uint;
		public var _spriteOffset:uint;
		
		public function BrocketColor(type:uint)
		{
			this._color = getColor(type);
			
			this._spriteOffset = getSprite(type);
		}

		public static function getColor(type:uint):uint
		{
			var color:uint = 0;
			
			switch(type)
			{
				// brocket I
				case 0:
				{
					color = 0x00FFFF;
					break;
				}
					// brocket T
				case 1:
				{
					color = 0x767676;
					break;
				}
					// brocket L
				case 2:
				{
					color = 0xFFA500;
					break;
				}
					// brocket J
				case 3:
				{
					color = 0x0000FF;
					break;
				}
					// brocket Z
				case 4:
				{
					color = 0xFF0000;
					break;
				}
					// brocket S
				case 5:
				{
					color = 0x00FF00;
					break;
				}
					// brocket O
				case 6:
				{
					color = 0xFFFF00;
					break;
				}
				default:
				{
					throw new Error("Invalid Brocket type");
					break;
				}
			}
			return color;
		}

		public static function getSprite(type:uint):uint
		{
			var spriteOffset:uint = 0;
			
			spriteOffset = Rock.SIZE * type; 
			
			return spriteOffset;
		}

		// getters
		public function toBrock():uint
		{
			return this._color;
		}
	}
}