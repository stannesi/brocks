package com.yapi.brocks.display
{
	import com.yapi.brocks.data.Brocket;
	import com.yapi.brocks.data.BrocksSound;
	import com.yapi.brocks.data.Grid;
	import com.yapi.brocks.dynamics.Gravity;
	import com.yapi.brocks.dynamics.MotionManager;
	import com.yapi.brocks.events.BrocksEvent;
	
	import flash.display.Sprite;
	import flash.events.KeyboardEvent;
	import flash.events.TimerEvent;
	import flash.ui.Keyboard;
	
	public class BrocksCanvas extends Sprite
	{
		[Embed(source = "/Brocks/src/com/yapi/brocks/data/sounds/rotate.mp3")] private var _rotateSFX:Class;
		[Embed(source = "/Brocks/src/com/yapi/brocks/data/sounds/level-up.mp3")] private var _levelUpSFX:Class;
		[Embed(source = "/Brocks/src/com/yapi/brocks/data/sounds/drop.mp3")] private var _dropSFX:Class;
		[Embed(source = "/Brocks/src/com/yapi/brocks/data/sounds/drop-1.mp3")] private var _scoresSFX:Class;
		[Embed(source = "/Brocks/src/com/yapi/brocks/data/sounds/game-over.mp3")] private var _gameOverSFX:Class;
		
		private var _rotateFX:BrocksSound, _levelUpFX:BrocksSound, _dropFX:BrocksSound,
					_scoresFX:BrocksSound, _gameOverFX:BrocksSound;
		
		private static const ROWS:uint = 20;
		private static const COLS:uint = 10;
		
		private var _bgColors:Array = new Array("0x444444", "0x555555");
		private var _lineColor:uint = 0x000000;
		

		private var _mainHolder:Sprite;
		private var _brocketHolder:Sprite;
		
		private var _curBrocket:Brocket;
		private var _nextBrocket:Brocket;
		
		private var _grid:Grid;
		
		private var _gravity:Gravity;
		private var _mtnManager:MotionManager;
				
		private var _level:uint;
		private var _clearedLines:uint;
		
		public function BrocksCanvas(lineColor:uint, bgColors:Array)
		{
			this._loadSounds();
			this._lineColor = lineColor;
			this._bgColors = bgColors;
			this._loadField();
			return;
		}
		
		private function _loadField():void
		{
			this._grid = new Grid(ROWS, COLS);
			this._draw();
			this._init();
			return;
		}
		
		private function _loadSounds():void
		{
			this._rotateFX = new BrocksSound();
			this._rotateFX.loadEmbeded(this._rotateSFX);
			
			this._levelUpFX = new BrocksSound();
			this._levelUpFX.loadEmbeded(this._levelUpSFX);
			
			this._dropFX = new BrocksSound();
			this._dropFX.loadEmbeded(this._dropSFX);

			this._scoresFX = new BrocksSound();
			this._scoresFX.loadEmbeded(this._scoresSFX);

			this._gameOverFX = new BrocksSound();
			this._gameOverFX.loadEmbeded(this._gameOverSFX);
		}
	
		private function _draw():void
		{
			graphics.clear();
			graphics.lineStyle(1, this._lineColor, 0.8, true, "none");
			for (var i:int = 0; i < ROWS; i++) {
				for (var j:int = 0; j < COLS; j++) {
					graphics.beginFill(this._bgColors[(j%2 + i%2)%2], 0.1);
					graphics.drawRoundRect(Rock.SIZE * j, Rock.SIZE * i, Rock.SIZE, Rock.SIZE, 10, 10);
					//graphics.drawRect(SIZE * j, SIZE * i, SIZE, SIZE);
					graphics.endFill();
				}
			}
			return;
			//filters = [new GlowFilter(26265, 0.8, 5, 5, 2, 10)];
		}
		
		private function _init():void
		{
			this._gravity = new Gravity();
			this._mtnManager = new MotionManager(this._grid);
			this._brocketHolder = new Sprite();
			this._mainHolder = new Sprite();
			
			//this._addMask();
			addChild(this._brocketHolder);
			addChild(this._mainHolder);
			return;
		}
		
		private function _createBrockets():void
		{
			if (!this._nextBrocket)
			{
				this._nextBrocket = new Brocket();
			}
			
			this._curBrocket = this._nextBrocket;
			this._nextBrocket = new Brocket();
			this._offsetBrocket();
			
			dispatchEvent(new BrocksEvent(BrocksEvent.BROCKET_UPDATE, {brocketType: this._nextBrocket.type}));
			return;
		}
		
		private function _offsetBrocket():void
		{
			if (this._curBrocket.type == 0)
			{
				this._curBrocket.brock1.x = this._curBrocket.brock1.x + 3;
				this._curBrocket.brock2.x = this._curBrocket.brock2.x + 3;
				this._curBrocket.brock3.x = this._curBrocket.brock3.x + 3;
				this._curBrocket.brock4.x = this._curBrocket.brock4.x + 3;

				this._curBrocket.brock1.y = this._curBrocket.brock1.y + -1;
				this._curBrocket.brock2.y = this._curBrocket.brock2.y + -1;
				this._curBrocket.brock3.y = this._curBrocket.brock3.y + -1;
				this._curBrocket.brock4.y = this._curBrocket.brock4.y + -1;
			} else {
				this._curBrocket.brock1.x = this._curBrocket.brock1.x + 4;
				this._curBrocket.brock2.x = this._curBrocket.brock2.x + 4;
				this._curBrocket.brock3.x = this._curBrocket.brock3.x + 4;
				this._curBrocket.brock4.x = this._curBrocket.brock4.x + 4;
				
				this._curBrocket.brock1.y = this._curBrocket.brock1.y + -2;
				this._curBrocket.brock2.y = this._curBrocket.brock2.y + -2;
				this._curBrocket.brock3.y = this._curBrocket.brock3.y + -2;
				this._curBrocket.brock4.y = this._curBrocket.brock4.y + -2;				
			}
			return;
		}
		
		private function _setBrocks():void
		{
			if (this._curBrocket.brock1.y > 0 && this._curBrocket.brock2.y > 0 && this._curBrocket.brock3.y > 0 && this._curBrocket.brock4.y > 0)
			{
				this._grid.setBrock(this._curBrocket.brock1);
				this._grid.setBrock(this._curBrocket.brock2);
				this._grid.setBrock(this._curBrocket.brock3);
				this._grid.setBrock(this._curBrocket.brock4);
			} else {
				this._gameOverFX.play();
				dispatchEvent(new BrocksEvent(BrocksEvent.GAME_OVER));
				this.stop();
			}
			return;
		}
		
		private function _levelUp():void
		{
			this._clearedLines = 0;
			this._level += 1;
			dispatchEvent(new BrocksEvent(BrocksEvent.LEVEL_UP, {level:this._level}));
			this._gravity.velocity = this._level;
		}
		
		private function _removeOld():void
		{
			while(this._brocketHolder.numChildren > 0)
			{
				this._brocketHolder.removeChildAt((this._brocketHolder.numChildren - 1));
			}
		}

		private function _removeFullLines():void
		{
			var clines:uint = this._grid.clearFullLines();
			
			if (clines > 0)
			{
				this._scoresFX.play();
				
				this._clearedLines = this._clearedLines + clines;
				this._updateMain();
				dispatchEvent(new BrocksEvent(BrocksEvent.SCORE_UPDATE, {lines:clines}));
				if (this._clearedLines > 9)
				{
					this._levelUpFX.play();
					this._levelUp();
				}
			}
		}

		private function _removeAllFromMain():void
		{
			while (this._mainHolder.numChildren > 0)
			{
				this._mainHolder.removeChildAt((this._mainHolder.numChildren - 1));
			}
		}
		private function _updateMain():void
		{
			this._removeAllFromMain();
			
			for (var i:int = 0; i < this._grid.rows; i++) {
				for (var j:int = 0; j < this._grid.cols; j++) {
						if (this._grid.isBrockAt(j, i))
							{
								this._mainHolder.addChild(this._grid.getBrockAt(j, i).render());
							}
					}
			}
		}
		
		private function _updateView():void
		{
			this._removeOld();
			this._addNew();			
		}

		private function _addNew():void
		{
			this._brocketHolder.addChild(this._curBrocket.brock1.render());
			this._brocketHolder.addChild(this._curBrocket.brock2.render());
			this._brocketHolder.addChild(this._curBrocket.brock3.render());
			this._brocketHolder.addChild(this._curBrocket.brock4.render());
		}
		
		private function _onKeyPress(e:KeyboardEvent):void
		{
			switch (e.keyCode)
			{
				case Keyboard.LEFT:
				{
					this._moveLeft();
					break;
				}
					
				case Keyboard.RIGHT:
				{
					this._moveRight();
					break;
				}

				case Keyboard.UP:
				{
					this._rotateFX.play();
					this._rotate("right");
					break;
				}

				case Keyboard.DOWN:
				{
					this._swiftDrop();
					break;
				}
					
				default:
				{
					break;
				}
			}
			
			if (e.charCode == "x".charCodeAt())
			{
				this._rotate("right");	
			}
			if (e.charCode == "z".charCodeAt())
			{
				this._rotate("left");	
			}
			
			stage.addEventListener(KeyboardEvent.KEY_UP, this._onKeyUp);
			this._unregKeys();
			this._updateView();
		}
		
		private function _onKeyUp(e:KeyboardEvent):void
		{
			if (e.keyCode == Keyboard.DOWN)
			{
				this._gravity.swiftDropMode = false;
			}
			stage.removeEventListener(KeyboardEvent.KEY_UP, this._onKeyUp);
			this._regKeys();
			this._updateView();
		}
		
		private function _landBrocket():void
		{
			this._removeOld();
			this._mainHolder.addChild(this._curBrocket.brock1.render());
			this._mainHolder.addChild(this._curBrocket.brock2.render());
			this._mainHolder.addChild(this._curBrocket.brock3.render());
			this._mainHolder.addChild(this._curBrocket.brock4.render());
			this._setBrocks();
			
			this._dropFX.play();
			
			this._removeFullLines();

			dispatchEvent(new BrocksEvent(BrocksEvent.DROP_UPDATE));
			return;
		}
		
		private function _moveBrocket(e:TimerEvent = null):void
		{
			if (!this._mtnManager.moveDown(this._curBrocket))
			{
				this._gravity.swiftDropMode = false;
				this._landBrocket();
				this._createBrockets();
				this._updateView();
			}
			return;
		}
		
		private function _moveLeft():void
		{
			this._mtnManager.moveLeft(this._curBrocket);
			return;
		}

		private function _moveRight():void
		{
			this._mtnManager.moveRight(this._curBrocket);
			return;
		}

		private function _rotate(dir:String):void
		{
			if (dir == "right")
			{
				this._mtnManager.rotate(this._curBrocket);
			}
			else if (dir == "left")
			{
				this._mtnManager.rotate(this._curBrocket, -90);
			}
			return;
		}
		
		private function _regKeys():void
		{
			if (stage)
			{
				stage.addEventListener(KeyboardEvent.KEY_DOWN, this._onKeyPress);
			}
			return;
		}
		
		private function _unregKeys():void
		{
			if (stage)
			{
				stage.removeEventListener(KeyboardEvent.KEY_DOWN, this._onKeyPress);
			}
			return;
		}
		
		private function _swiftDrop():void
		{
			this._unregKeys();
			stage.addEventListener(KeyboardEvent.KEY_UP, this._onKeyUp);
			this._gravity.swiftDropMode = true;
			return;
		}
		
		public function start(level:uint = 0):void
		{
			this._removeAllFromMain();
			this._createBrockets();
			this._updateView();
			this._level = level;
			this._gravity.velocity = level;
			this._gravity.register(this._moveBrocket);
			this._gravity.start();
			this._clearedLines = 0;
			this._grid.clearLines();
			this._regKeys();
			return;
		}

		public function stop():void
		{
			this._gravity.stop();
			this._gravity.unregister(this._moveBrocket);
			this._unregKeys();
			this._nextBrocket = null;
			this._curBrocket = null;
			return;
		}

		public function pause():void
		{
			this._gravity.stop();
			this._unregKeys();
			return;
		}

		public function resume():void
		{
			this._gravity.start();
			this._regKeys();
			return;
		}
	}
}