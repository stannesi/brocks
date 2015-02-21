package com.yapi.brocks.display
{
	import flash.display.Sprite;
	import flash.events.MouseEvent;
	import flash.filters.GlowFilter;
	import flash.text.AntiAliasType;
	import flash.text.TextField;
	import flash.text.TextFieldAutoSize;
	import flash.text.TextFormat;
	
	public class BrockButton extends Sprite
	{
		private var _enabled:Boolean;
		private var _field:TextField;
		
		public function BrockButton(val:String = "")
		{
			this._createField();
			this.label = val;
			var btnMode:Boolean = true;
			this._enabled = true;
			this.buttonMode = btnMode;
			this.mouseChildren = false;
			this.addEventListener(MouseEvent.MOUSE_OVER, this._onMouseEvent);
			this.addEventListener(MouseEvent.MOUSE_OUT, this._onMouseEvent);
			return;
		}
		
		private function _createField() :void
		{
			this._field = new TextField();
			addChild(this._field);
			var txtFormat:TextFormat = new TextFormat();
			txtFormat.font = "Arial";
			txtFormat.size = 20;
			txtFormat.color = 25277;
			this._field.autoSize = TextFieldAutoSize.LEFT;
			this._field.defaultTextFormat = txtFormat;
			this._field.selectable = false;
			//this._field.embedFonts = true;
			this._field.sharpness = 50;
			this._field.antiAliasType = AntiAliasType.ADVANCED;
			return;
		}

		public function _draw(mouseOvr:Boolean = false):void
		{
			this.graphics.clear();
			this.graphics.lineStyle(2, 26265, 1, true, "none", "square");
			
			if (mouseOvr)
			{
				this.graphics.beginFill(26265, 0.2);
			}
			this.graphics.drawRect(0, 0, 140, this._field.height);
			if (mouseOvr)
			{
				this.graphics.endFill();
			}
			this.filters = [new GlowFilter(16793, 0.8, 2, 2, 2, 10)];
			this._field.x = this.width * 0.5 - this._field.width * 0.5;
			return;
		}
		private function _onMouseEvent(e:MouseEvent):void
		{
			if (e.type == MouseEvent.MOUSE_OVER)
			{
				this._draw(true);
			}
			else if (e.type == MouseEvent.MOUSE_OUT) {
				this._draw(false);
			}
			return;
		}
		// setters
		public function set label(val:String):void
		{
			this._field.text = val;
			this._draw();
			return;
		}
		
		public function set enabled(val:Boolean):void
		{
			this._enabled = val;
			this.mouseEnabled = this._enabled;
			this.alpha = this._enabled ? (1) : (0.4);
			return;
		}
		
		// getters
		public function get enabled():Boolean
		{
			return this._enabled;
		}

		public function get label():String
		{
			return this._field.text;
		}
	}
}