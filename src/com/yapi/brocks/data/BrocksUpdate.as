package com.yapi.brocks.data
{
	import com.yapi.brocks.events.BrocksEvent;
	
	public class BrocksUpdate extends Object
	{
		[Embed(source = "/Brocks/src/com/yapi/brocks/data/sounds/combo.mp3")] private var _comboSFX:Class;
		[Embed(source = "/Brocks/src/com/yapi/brocks/data/sounds/d-combo.mp3")] private var _dComboSFX:Class;
		[Embed(source = "/Brocks/src/com/yapi/brocks/data/sounds/t-combo.mp3")] private var _tComboSFX:Class;
		[Embed(source = "/Brocks/src/com/yapi/brocks/data/sounds/u-combo.mp3")] private var _uComboSFX:Class;

		[Embed(source = "/Brocks/src/com/yapi/brocks/data/sounds/break.mp3")] private var _breakSFX:Class;
		
		private var _comboFX:BrocksSound, _dComboFX:BrocksSound, _tComboFX:BrocksSound, _uComboFX:BrocksSound;
		private var _breakFX:BrocksSound;
		
		private var _lines:uint = 0;
		private var _level:uint = 1;
		private var _score:uint= 0;

		public static const DROPPOINTS:uint = 1;
		public static const LINEPOINTS:uint = 10;
		public static const LEVELINC:uint = 100;
		
		public function BrocksUpdate()
		{
			//this._lines += e.lines ;
			//this._level = e.level;
			//this._score = 0;
			this._loadSounds();
			return;
		}

		private function _loadSounds():void
		{
			this._comboFX = new BrocksSound();
			this._comboFX.loadEmbeded(this._comboSFX);
			
			this._dComboFX = new BrocksSound();
			this._dComboFX.loadEmbeded(this._dComboSFX);
			
			this._tComboFX = new BrocksSound();
			this._tComboFX.loadEmbeded(this._tComboSFX);
			
			this._uComboFX = new BrocksSound();
			this._uComboFX.loadEmbeded(this._uComboSFX);

			this._breakFX = new BrocksSound();
			this._breakFX.loadEmbeded(this._breakSFX);
			this._breakFX.volume= 0.5;
		}
		
		public function updateLines(e:BrocksEvent):void
		{
			this._lines += e.lines;
			return;
		}

		public function updateLevel(e:BrocksEvent):void
		{
			this._level = e.level + 1;
			this._score += LEVELINC;
			return;
		}

		public function updateDrop(e:BrocksEvent):void
		{
			var score:uint = 0;
			score = DROPPOINTS * this._level;
			this._score += score;
			return
		}
	
		public function updateScore(e:BrocksEvent):void
		{
			var score:uint = 0;
			switch (e.lines)
			{
				case 1:
				{
					this._comboFX.play();
					score = LINEPOINTS * this._level;
					break;
				}
				case 2:
				{
					this._dComboFX.play();
					score = (LINEPOINTS * 4) * this._level;
					break;					
				}
				case 3:
				{
					this._tComboFX.play();
					score = (LINEPOINTS * 6) * this._level;
					break;					
				}
				case 4:
				{
					this._uComboFX.play();
					score = (LINEPOINTS * 8) * this._level;
					break;					
				}
				default:
				{
					score = DROPPOINTS  * this._level;
					break;					
				}
			}
	//		this._breakFX.play();
			this._score += score;
			return;
		}
		
		public function reset():void
		{
			this._lines = 0;
			this._level = 1;
			this._score = 0;
		}

		// setters
		public function set lines(val:uint):void
		{
			this._lines = val;
			return;
		}
		
		public function set level(val:uint):void
		{
			this._level = val;
			return;
		}
		
		public function set score(val:uint):void
		{
			this._score = val;
			return;
		}
		
		// getters
		public function get lines():uint
		{
			return this._lines;
		}
		
		public function get level():uint
		{
			return this._level;
		}
		
		public function get score():uint
		{
			return this._score;
		}
	}
}