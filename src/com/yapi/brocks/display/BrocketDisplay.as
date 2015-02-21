package com.yapi.brocks.display
{
	import com.yapi.brocks.data.Brocket;
	
	import flash.display.Sprite;
	import flash.text.AntiAliasType;
	import flash.text.TextField;
	import flash.text.TextFieldAutoSize;
	import flash.text.TextFormat;
	
	public class BrocketDisplay extends Sprite
	{
		private var _label:TextField;
		private var _text:String;
		
		public function BrocketDisplay(str:String = "Next")
		{
			this._text = str;
			this._label = new TextField();
			addChild(this._label);
			this._draw();
			this._setLabel();
			return;
		}
		
		private function _setLabel():void
		{
			var txtFormat:TextFormat = new TextFormat();
			txtFormat.font = "Arial";
			txtFormat.size = 20;
			txtFormat.bold = true;
			txtFormat.color = 25277;
			txtFormat.italic = true;
			this._label.autoSize = TextFieldAutoSize.LEFT;
			this._label.defaultTextFormat = txtFormat;
			this._label.text = this._text;
			this._label.selectable = false;
			this._label.antiAliasType = AntiAliasType.ADVANCED;
			//this._label.embedFonts = true;
			this._label.sharpness = 50;
			return;
		}
		
		private function _draw():void
		{
			graphics.clear();
			graphics.drawRect(0, 0, 7 * Rock.SIZE, 5 * Rock.SIZE);
			return;
		}

		private function _offsetBrocket(brocket:Brocket):void
		{
			brocket.brock1.x + 1;
			brocket.brock1.y = brocket.brock1.y + 2;
			
			brocket.brock2.x + 1;
			brocket.brock2.y = brocket.brock2.y + 2;
			
			brocket.brock3.x + 1;
			brocket.brock3.y = brocket.brock3.y + 2;
			
			brocket.brock4.x + 1;
			brocket.brock4.y = brocket.brock4.y + 2;
			
			return;
		}
		
		public function set brocket(brocket:Brocket):void
		{
			this.clear();
			this._addNew(brocket);
			return;
		}
		
		public function clear():void
		{
			while (numChildren > 1)
			{
				if (getChildAt((numChildren - 1)) !==  this._label)
				{
					removeChildAt(numChildren - 1);
					continue;
				}
				continue;
			}
			return;
		}

		private function _addNew(brocket:Brocket):void
		{
			this._offsetBrocket(brocket);
			addChild(brocket.brock1.render());
			addChild(brocket.brock2.render());
			addChild(brocket.brock3.render());
			addChild(brocket.brock4.render());
			return;
		}
	}
}