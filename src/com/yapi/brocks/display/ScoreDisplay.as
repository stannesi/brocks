package com.yapi.brocks.display
{
	import com.yapi.brocks.data.fonts.*;
	import com.yapi.brocks.events.BrocksEvent;
	
	import flash.display.Sprite;
	import flash.text.AntiAliasType;
	import flash.text.TextField;
	import flash.text.TextFieldAutoSize;
	import flash.text.TextFormat;
	import flash.text.TextFormatAlign;
	
	public class ScoreDisplay extends Sprite
	{
		private var _level:uint = 1;
		private var _scoreField:TextField;
		private var _levelField:TextField;
		private var _score:uint;
		
		public function ScoreDisplay()
		{
			this._scoreField = new TextField();
			this._levelField =  new TextField();
			
			this._addField(this._scoreField);
			this._addField(this._levelField);
			
			this._setScoreText();
			this._setLevelText();
			
			this._levelField.y = this._scoreField.y + this._scoreField.height;
			this._draw();
			
			return;
		}
		
		private function _draw():void
		{
			graphics.clear();	
			graphics.drawRect(0, 0, 7 * Rock.SIZE, 3 * Rock.SIZE);
			return;
		}
		
		private function _addField(obj:TextField):void
		{
			addChild(obj);
			var txtFormat:TextFormat = new TextFormat();
			txtFormat.font = "Arial";
			txtFormat.size = 20;
			txtFormat.bold = true;
			txtFormat.italic = true;
			txtFormat.color = 25277;
			txtFormat.align = TextFormatAlign.JUSTIFY;
			
			obj.autoSize = TextFieldAutoSize.LEFT;
			obj.defaultTextFormat = txtFormat;
			obj.selectable = false;
			obj.antiAliasType = AntiAliasType.ADVANCED;
			//obj.embedFonts = true;
			obj.sharpness = 50;
			return;
		}
		
		public function updateLevel(val:uint):void
		{
			this._level = val;
			this._setLevelText()
			return;
		}
			
		public function updateScore(val:uint):void
		{
			this._score = val;
			this._setScoreText();
			return;
		}
		
		private function _setLevelText():void
		{
			this._levelField.text = "Level:\t      ";
			
			if (this._level < 10)
			{
				this._levelField.appendText(" " + this._level.toString());
			} else {
				this._levelField.appendText(this._level.toString());
			}
			return;
		}
		
		private function _setScoreText():void
		{
			this._scoreField.text = "Score: ";
			this._scoreField.appendText(this._addCommas(this._score.toString()));
			return;
		}
		
		public function reset():void
		{
			this._score = 0;
			this._level = 1;
			this._setScoreText();
			this._setLevelText();
			return;
		}
		
		private function _addCommas(str:String):String
		{
			var len:uint = str.length;
			var retStr:String = "";
			
			for (var i:uint = 0; i <= len; i++) {
				retStr = str.charAt(len - i) + retStr;
				if (i%3 == 0 && i > 0 && i < len) retStr = "," + retStr;
			}
			return retStr;
		};
	}
}