/*
* Brocks v1.0
* copyright:	(c) Yapi Games
*
* @author:		Stanley Ilukhor (stannesi)
*/
package com.yapi.brocks
{
	import com.yapi.brocks.data.Brock;
	import com.yapi.brocks.data.Brocket;
	import com.yapi.brocks.data.BrocketType;
	import com.yapi.brocks.data.BrocksSound;
	import com.yapi.brocks.data.BrocksUpdate;
	import com.yapi.brocks.display.BrockButton;
	import com.yapi.brocks.display.BrocketDisplay;
	import com.yapi.brocks.display.BrocksCanvas;
	import com.yapi.brocks.display.ScoreDisplay;
	import com.yapi.brocks.events.BrocksEvent;
	
	import flash.display.Sprite;
	import flash.events.Event;
	import flash.events.MouseEvent;
	import flash.events.TimerEvent;
	import flash.media.Sound;
	import flash.media.SoundChannel;
	import flash.utils.Timer;
	
	import mx.core.ButtonAsset;
	
	[SWF(width = "600", height = "600", framerate ="31", backgroundColor = "#000000")]
	//[Frame(factoryClass = "BrocksPreloader")]
	
	public class Brocks extends Sprite
	{
		private var _gameCanvas:BrocksCanvas;
		
		private var _startButton:BrockButton;
		private var _pauseButton:BrockButton;
		private var _resumeButton:BrockButton;
		
		private var _updater:BrocksUpdate;
		private var _scoreDisplay:ScoreDisplay;
		private var _nextDisplay:BrocketDisplay;
		
		// sounds
		[Embed(source = "/Brocks/src/com/yapi/brocks/data/sounds/music-B.mp3")] private var _musicSFXA:Class;
		[Embed(source = "/Brocks/src/com/yapi/brocks/data/sounds/music-AM1.mp3")] private var _musicSFXB:Class;
		
		private var _musicFXA:BrocksSound, _musicFXB:BrocksSound, _musicFXC:BrocksSound; 
		
		public function Brocks()
		{
			this._loadSounds();
			this._loadBrocks();
			return;
		}
		
		private function _loadSounds():void
		{
			this._musicFXA = new BrocksSound();
			this._musicFXA.loadEmbeded(this._musicSFXA, true);
			//this._musicFXA.volume = 0.4;

			this._musicFXB = new BrocksSound();
			this._musicFXB.loadEmbeded(this._musicSFXB, true);
//			this._musicFXB.volume = 0.4;
			
			// menu Sound
			//this._musicFXA.play();
			this._musicFXA.fadeIn(10);
			
			return;
		}
		
		private function _loadBrocks():void
		{
			this._updater = new BrocksUpdate();
			this._addCanvas();
			this._addScoreDisplay();
			this._addBrocketDisplay();
			this._addButtons();
			return;
		}
		
		private function _addCanvas():void
		{
			var checkersColor:Array = new Array("0x444444", "0x555555");
			this._gameCanvas = new BrocksCanvas(0x000000, checkersColor);
			
			this._gameCanvas.x = 30;
			this._gameCanvas.y = 30;
			
			this._gameCanvas.addEventListener(BrocksEvent.DROP_UPDATE, this._onDropUpdate);
			this._gameCanvas.addEventListener(BrocksEvent.SCORE_UPDATE, this._onScoreUpdate);
			this._gameCanvas.addEventListener(BrocksEvent.LEVEL_UP, this._onLevelUp);
			this._gameCanvas.addEventListener(BrocksEvent.BROCKET_UPDATE, this._onBrocketUpdate);
			this._gameCanvas.addEventListener(BrocksEvent.GAME_OVER, this._onGameOver);
			
			addChild(this._gameCanvas);
			return;
		}

		private function _addScoreDisplay():void
		{
			this._scoreDisplay = new ScoreDisplay();
			this._scoreDisplay.x = this._gameCanvas.x + this._gameCanvas.width + 30;
			addChild(this._scoreDisplay);
			return;
		}

		private function _addBrocketDisplay():void
		{
			this._nextDisplay = new BrocketDisplay();
			addChild(this._nextDisplay);
			this._nextDisplay.x = this._scoreDisplay.x;
			this._nextDisplay.y = this._scoreDisplay.y + this._scoreDisplay.height;
			return;
		}

		private function _addButtons():void
		{
			this._startButton = new BrockButton("Start game");
			this._pauseButton = new BrockButton("Pause game");
			this._resumeButton = new BrockButton("Resume game");
			
			addChild(this._startButton);
			addChild(this._pauseButton);
			addChild(this._resumeButton);
			
			this._resumeButton.visible = false;
			this._pauseButton.enabled = false;
			
			this._resumeButton.x = this._nextDisplay.x;
			this._startButton.x = this._nextDisplay.x;
			this._pauseButton.x = this._nextDisplay.x;
			
			this._pauseButton.y = this._gameCanvas.y + this._gameCanvas.height - this._pauseButton.height - 10;
			this._resumeButton.y = this._gameCanvas.y + this._gameCanvas.height - this._resumeButton.height - 10;
			this._startButton.y = this._pauseButton.y - this._startButton.height - 10;
			
			this._startButton.addEventListener(MouseEvent.CLICK, _onStartClick);
			this._pauseButton.addEventListener(MouseEvent.CLICK, _onPauseResumeClick);
			this._resumeButton.addEventListener(MouseEvent.CLICK, _onPauseResumeClick);

			return;
		}

		private function _onStartClick(e:MouseEvent):void
		{
			this._gameCanvas.start();
			this._pauseButton .enabled = true;
			this._startButton.enabled = false;
			
			// stop menu sound
			this._musicFXA.stop();
			
			// play main brocks sound
			this._musicFXB.fadeIn(20);
		}

		private function _onPauseResumeClick(e:MouseEvent):void
		{
			if (e.target == this._pauseButton)
			{
				this._gameCanvas.pause();
				this._resumeButton.visible = true;
				this._pauseButton.visible = false;
				
			} else {
				this._gameCanvas.resume();
				this._resumeButton.visible = false;
				this._pauseButton.visible = true;				
			}
			
		}

		private function _onBrocketUpdate(e:BrocksEvent):void
		{
			if (BrocketType.isValidType(e.brocketType))
			{
				this._nextDisplay.brocket =  new Brocket(e.brocketType);	
			} else {
				this._nextDisplay.clear();
			}

			return;
		}

		private function _onDropUpdate(e:BrocksEvent):void
		{
			this._updater.updateDrop(e);
			this._scoreDisplay.updateScore(this._updater.score);
			return;
		}
		
		private function _onScoreUpdate(e:BrocksEvent):void
		{
			if (e.lines > 0) {
				this._updater.updateScore(e);
				this._scoreDisplay.updateScore(this._updater.score);
			} else {
				this._updater.reset()
				this._scoreDisplay.reset();
			}
			return;
		}

		private function _onLevelUp(e:BrocksEvent):void
		{
			this._updater.updateLevel(e);
			this._scoreDisplay.updateLevel(this._updater.level);
			return;
		}

		private function _onGameOver(e:BrocksEvent):void
		{
			_musicFXB.stop();
			_musicFXA.play();
			
			this._startButton.enabled = true;
			this._resumeButton.visible = false;
			this._pauseButton.enabled = false;			
			this._gameCanvas.stop();
			return;
		}
	}
}