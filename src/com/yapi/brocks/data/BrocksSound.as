package com.yapi.brocks.data
{
	import flash.events.Event;
	import flash.events.TimerEvent;
	import flash.media.Sound;
	import flash.media.SoundChannel;
	import flash.media.SoundTransform;
	import flash.utils.Timer;

	public class BrocksSound extends Object
	{
		// timer
		private var _timer:Timer;

		// whether to call destroy() when the sound has finished.
		public var autoDestroy:Boolean;

		// active
		public var active:Boolean;
		
		// internal tracker for a Flash sound obj
		private var _snd:Sound;
		
		// internal tracker for a Flash sound channel object.
		private var _sndChannel:SoundChannel;
		
		// internal tracker for a Flash sound transform object.
		private var _sndTransform:SoundTransform;
		
		// internal tracker for the position in runtime of the music playback.
		private var _pos:Number;
		
		// internal tracker for sound volume
		private var _vol:Number;
		
		// Internal tracker for total volume adjustment.
		private var _volAdjust:Number;
		
		// Internal tracker for whether the sound is looping or not.
		private var _looped:Boolean;
		
		// internal tracker for the sound's "target" (for proximity and panning).
		private var _targetObj:Object;
				
		// internal timer used to keep track of requests to fade out the sound playback.
		private var _fadeOutTimer:Number;

		// Internal helper for fading out sounds.
		private var _fadeOutTotal:Number;

		// Internal timer for fading in the sound playback.
		private var _fadeInTimer:Number;
		
		// internal helper for fading in sounds.
		private var _fadeInTotal:Number;

		// internal flag for whether to pause or stop the sound when it's done fading out.
		private var _pauseOnFadeOut:Boolean;

		public function BrocksSound()
		{
			this._createSound();
			return;
		}
		
		private function _createSound():void
		{
			destroy();
		
			this._timer = new Timer(500);
			
			if (this._sndTransform == null)
				this._sndTransform = new SoundTransform();
			
			this._sndTransform.pan = 0
			this._snd = null;
			this._pos =0
			this._vol = 1.0;
			this._volAdjust = 1.0;
			this._looped = false;
			this._targetObj = null;
			this.active = false;
			this.autoDestroy = false;
			
			this._fadeOutTimer = 0;
			this._fadeOutTotal = 0;
			this._pauseOnFadeOut = false;
			this._fadeInTimer = 0;
			this._fadeInTotal = 0;
			
			return;
		}
		
		public function destroy():void
		{
			if(_sndChannel != null)
				this.stop();
			
			this._sndTransform = null;
			this._snd = null;
			this._sndChannel = null;
			this._targetObj = null;
			this._timer = null;
			
			return;
		}
		
		public function loadEmbeded(clsSound:Class, loop:Boolean = false, autoDestroy:Boolean = false):BrocksSound
		{
			this.stop();
			this._createSound();
			this._snd = new clsSound();
			this._looped = loop;
			this._updateTransform();
			return this;
		}
		
		public function play(forceStart:Boolean = false):void
		{
			if (this._pos < 0)
				return;
			
			if (forceStart)
			{
				var oldAutoDestroy:Boolean = this.autoDestroy;
				this.autoDestroy = false;
				this.stop();
				this.autoDestroy = oldAutoDestroy;
			}

			if (this._looped)
			{
				if (this._pos == 0)
				{
					if (this._sndChannel == null)
					{
						if (this._sndChannel == null)
							this._sndChannel = this._snd.play(0, 9999, this._sndTransform);
					}
				} else {
					this._sndChannel =  this._snd.play(this._pos, 0, this._sndTransform);
					this._sndChannel.addEventListener(Event.SOUND_COMPLETE, this._onLooped);
				}
			} else {
				if (this._pos == 0)
				{
					if (this._sndChannel == null)
					{
						this._sndChannel = this._snd.play(0, 0, this._sndTransform);
						this._sndChannel.addEventListener(Event.SOUND_COMPLETE, this._onStopped);
					}
				} else {
					this._sndChannel = this._snd.play(this._pos, 0, this._sndTransform);
				}					
			}
						
			this.active = (this._sndChannel != null);
			this._pos = 0;

			if (this.active)
			{
				this._timer.addEventListener(TimerEvent.TIMER, this._onTimer);
				this._timer.start();
			}
			
			return;
		}
		
		public function resume():void
		{
			if (this._pos <= 0)
				return;
			
			if (this._looped)
			{
				this._sndChannel = this._snd.play(this._pos, 0, this._sndTransform);
				this._sndChannel.addEventListener(Event.SOUND_COMPLETE, this._onLooped);
			} else {
				this._sndChannel = this._snd.play(this._pos, 0, this._sndTransform);
			}
			
			this.active = (this._sndChannel != null);

			if (this.active)
			{
				this._timer.addEventListener(TimerEvent.TIMER, this._onTimer);
				this._timer.start();
			}
			
			return;
		}
		
		public function pause():void
		{
			if (this._sndChannel == null)
			{
				this._pos = -1;
				return;
			}
			
			this._pos = this._sndChannel.position;
			this._sndChannel.stop();
			
			if (this._looped)
			{
				while (this._pos >= this._snd.length)
					this._pos -= this._snd.length;
			}
			if (this._pos <= 0)
				this._pos = -1;
			
			this._sndChannel = null;
			
			this.active = false;

			if (!this.active)
			{
				this._timer.stop();
				this._timer.removeEventListener(TimerEvent.TIMER, this._onTimer);

			}
			
			return;
		}
		
		public function stop():void
		{
			this._pos = 0;
			if (this._sndChannel != null)
			{
				this._sndChannel.stop();
				this._onStopped();
			}

			if (!this.active)
			{
				this._timer.stop();
				this._timer.reset();
				this._timer.removeEventListener(TimerEvent.TIMER, this._onTimer);
				
			}
			
			return;
		}
		
		public function get volume():Number
		{
			return this._vol;
		}
		
		public function set volume(vol:Number):void
		{
			this._vol = vol;
			
			if (this._vol < 0)
				this._vol = 0;
			else if (this._vol > 1)
				this._vol = 1;
			
			this._updateTransform();
			return;
		}
		
		private function _updateTransform():void
		{
			this._sndTransform.volume = 1 * this._vol * this._volAdjust;
			
			if (this._sndChannel != null)
				this._sndChannel.soundTransform = this._sndTransform;
			
			return;
		}
		
		private function _onLooped(e:Event=null):void
		{
			if (this._sndChannel == null)
				return;
			
			this._sndChannel.removeEventListener(Event.SOUND_COMPLETE, this._onLooped);

			return;
		}
		
		private function _onStopped(e:Event = null):void
		{
			if (!this._looped)
				this._sndChannel.removeEventListener(Event.SOUND_COMPLETE, this._onStopped);
			else
				this._sndChannel.removeEventListener(Event.SOUND_COMPLETE, this._onLooped);
			
			this._sndChannel = null;
			
			this.active = false;
			
			if (this.autoDestroy)
				this.destroy();
			
			return;
		}
		
		private function _onTimer(e:TimerEvent = null):void
		{
			this.update();
		}
		
		private function update():void
		{
			if(this._pos != 0)
				return;
			
			var radial:Number = 1.0;
			var fade:Number = 1.0;
			
			if(this._fadeOutTimer > 0)
			{
				this._fadeOutTimer -= this._timer.currentCount;
				if(this._fadeOutTimer <= 0)
				{
					if (this._pauseOnFadeOut)
						this.pause();
					else
						this.stop();
				}
				
				fade = this._fadeOutTimer/this._fadeOutTotal;
				
				if (fade < 0)
					fade = 0;
			
			} else if (this._fadeInTimer > 0) {
				this._fadeInTimer -= this._timer.currentCount;
				
				fade = this._fadeInTimer/this._fadeInTotal;
				
				if (fade < 0)
					fade = 0;
				
				fade = 1 - fade;
			}
			
			this._volAdjust =  radial * fade;
			this._updateTransform();
			
			return;
		}
		
		// call this function to make this sound fade out over a certain time interval.
		public function fadeOut(seconds:Number, pause:Boolean = false):void
		{
			this._pauseOnFadeOut = pause;
			this._fadeInTimer = 0;
			this._fadeOutTimer = seconds;
			this._fadeOutTotal = this._fadeOutTimer;
			return
		}

		// call this function to make a sound fade in over a certain time interval 
		// (calls this.play() automatically)
		public function fadeIn(seconds:Number):void
		{
			this._fadeOutTimer = 0;
			this._fadeInTimer = seconds;
			this._fadeInTotal = this._fadeInTimer;
			this._volAdjust = 0;
			this._updateTransform();
			this.play();
			return;
		}
	}
}