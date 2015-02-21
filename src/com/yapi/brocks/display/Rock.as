package com.yapi.brocks.display
{
	import com.yapi.brocks.data.Brocket;
	
	import flash.display.Bitmap;
	import flash.display.BitmapData;
	import flash.display.Sprite;
	import flash.filters.BevelFilter;
	import flash.geom.Matrix;
	import flash.geom.Point;

	public class Rock extends Sprite
	{
		[Embed(source = "/Brocks/src/com/yapi/brocks/data/imgs/brocks_sprites.png")] private var spritePNG:Class; 
		
		private var _color:uint;
		private var _spriteOffset:uint;
		public static const SIZE:uint = 28;
		
		private var _bmpData:BitmapData;
		private var _bmpCanvasBuffer:Bitmap; 
		
		public function Rock(color:uint, sprite:Boolean = false)
		{
			if (!sprite)
			{
				this._color = color;
				this._draw();
			} else {
				this._spriteOffset = color;
				this._loadBmp();
				this._drawBmp();
			}
			this._addEffects();
		}
		
		private function _loadBmp():void
		{
			this._bmpData = (new spritePNG).bitmapData;
		}

		private function _drawBmp():void
		{
			this._bmpData = (new spritePNG).bitmapData;
			var matrix:Matrix = new Matrix();
			
			var x:uint = Brocket._shadeX;
			matrix.translate(x * Rock.SIZE + 1, this._spriteOffset + 1);
			
			graphics.clear();
			graphics.beginBitmapFill(this._bmpData, matrix,true, true);
			graphics.drawRoundRect(1, 1, SIZE, SIZE, 15, 15);
			graphics.endFill();			
		}
		
		private function _draw():void
		{
			graphics.clear();
			graphics.lineStyle(1, this._color, 0.9, true, "none");
			graphics.beginFill(this._color);
			graphics.drawRoundRect(1, 1, SIZE - 2, SIZE - 2, 10, 10);
			graphics.endFill();
		}
		
		private function _addEffects():void
		{
			var bFx:BevelFilter = new BevelFilter(1, 45, 0xffffff, 0.4, 0x000000, 0.5, 2, 2, 10, 10)
			filters = [bFx];
		}
	}
}