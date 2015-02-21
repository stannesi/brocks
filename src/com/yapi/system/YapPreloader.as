package com.yapi.system
{
	import flash.display.Bitmap;
	import flash.display.BitmapData;
	import flash.display.DisplayObject;
	import flash.display.MovieClip;
	import flash.display.Sprite;
	import flash.display.StageAlign;
	import flash.display.StageScaleMode;
	import flash.events.Event;
	import flash.events.MouseEvent;
	import flash.net.URLRequest;
	import flash.net.navigateToURL;
	import flash.text.TextField;
	import flash.text.TextFormat;
	import flash.utils.getDefinitionByName;
	import flash.utils.getTimer;
	
	public class YapPreloader extends MovieClip
	{
		[Embed(source="../data/yapi_logo.png")] protected var imgLogo:Class;
		[Embed(source="../data/logo_corners.png")] protected var ImgLogoCorners:Class;
		[Embed(source="../data/logo_light.png")] protected var ImgLogoLight:Class;
		
		protected var _init:Boolean;
		
		protected var _buffer:Sprite;
		
		protected var _bmpBar:Bitmap;
		
		protected var _text:TextField;
		
		protected var _width:uint;
		
		protected var _height:uint;
		
		protected var _logo:Bitmap;

		protected var _logoGlow:Bitmap;
		
		protected var _min:uint;
		
		public var className:String;
		
		public var myURL:String;
		
		public var minDisplayTime:Number;
		
		
		public function YapPreloader()
		{
			minDisplayTime = 0;
			
			stop();
			stage.scaleMode = StageScaleMode.NO_SCALE;
			stage.align = StageAlign.TOP_LEFT;
			
			if ((myURL != null) && (root.loaderInfo.url.indexOf(myURL) < 0)) {
				var tmp:Bitmap;
				tmp = Bitmap(new BitmapData(stage.stageWidth, stage.stageHeight, true, 0xffffff));
				addChild(tmp);
				
				var txtFrmtInfo:TextFormat = new TextFormat;
				txtFrmtInfo.color = 0x000000;
				txtFrmtInfo.size = 16;
				txtFrmtInfo.align = "center";
				txtFrmtInfo.bold = true;
				txtFrmtInfo.font = "system";
				
				var txtInfo:TextField = new TextField;
				txtInfo.width = tmp.width - 16;
				txtInfo.height = tmp.height - 16;
				txtInfo.y = 8;
				txtInfo.multiline = true;
				txtInfo.wordWrap = true;
				txtInfo.embedFonts = true;
				txtInfo.defaultTextFormat = txtFrmtInfo;
				txtInfo.text = "Oops! It looks like somebody copied this game without my permission.  Just click anywhere, or copy-paste this URL into your browser.\n\n" + myURL + "\n\nto play the game at my site.  Thanks, and have fun!";
				
				addChild(txtInfo);
				
				txtInfo.addEventListener(MouseEvent.CLICK, gotoURL);
				tmp.addEventListener(MouseEvent.CLICK, gotoURL);
				return;
			}
			
			this._init = false;
			addEventListener(Event.ENTER_FRAME, onEnterFrame); 
		}
		
		private function gotoURL(evt:MouseEvent = null):void {
			navigateToURL(new URLRequest("http://" + myURL));
		}
		
		private function onEnterFrame(evt:Event):void {
			if (!this._init) {
				if ((stage.stageWidth <= 0) ||(stage.stageHeight <= 0)) {
					return;
					create();
					this._init = true;
				}
				
				graphics.clear();
				var time:uint =  getTimer();
				if ((framesLoaded >= totalFrames) && (time > _min)){
					removeEventListener(Event.ENTER_FRAME, onEnterFrame);
					nextFrame();
					init();
					
				} else {
					var percent:Number = root.loaderInfo.bytesLoaded / root.loaderInfo.bytesTotal;
					
					if ((_min > 0) && (percent > time/_min))
						percent = time/_min;
						
					update(percent);
				}
			}
		}

		/**
		 * 
		 */
		private function init():void {
			var mainClass:Class = Class(getDefinitionByName(className));
			if (mainClass) {
				var app:Object = new mainClass;
				addChild(app as DisplayObject);
			}	
		}

		/**
		 * Override this to create your own preloader objects.
		 * Highly recommended you also override update()!
		 */
		protected function create():void {
			_min = 0;
			_buffer = new Sprite();
			_buffer.scaleX = 2;
			_buffer.scaleY = 2;
			addChild(_buffer);
			_width = stage.stageWidth / _buffer.scaleX;
			_width = stage.stageHeight / _buffer.scaleY;
			_buffer.addChild( new Bitmap(new BitmapData(_width, _height, false, 0x00345e)));
			
			var bitmap:Bitmap = ImgLogoLight();
			bitmap.smoothing = true;
			bitmap.width = bitmap.height = _height;
			bitmap.x = (_width - bitmap.width) / 2;
			
			_buffer.addChild(bitmap);
			
			_bmpBar = new Bitmap(new BitmapData(1, 7, false, 0x5f6aff));
			_bmpBar.x = 4;
			_bmpBar.y = _height - 11;
			
			_text = new TextField();
			_text.defaultTextFormat = new TextFormat("system", 0x5f6aff);
			_text.embedFonts = true;
			_text.selectable = false;
			_text.multiline = false;
			_text.x = 2;
			_text.y = _bmpBar.y = 11;
			_text.width = 80;
			
			_buffer.addChild(_text);
			
			_logo = new imgLogo();
			_logo.scaleX = _logo.scaleY = _height / 8
			_logo.x = (_width - _logo.width) / 2;
			_logo.y = (_height - _logo.height) / 2;
			
			_buffer.addChild(_logo);
			
			_logoGlow = new imgLogo();
			_logoGlow.smoothing = true;
			_logoGlow.blendMode = "screen";
			_logoGlow.scaleX = _logoGlow.scaleY = _height / 8;
			_logoGlow.x = (_width-_logoGlow.width) / 2;
			_logoGlow.y = (_height-_logoGlow.height) / 2;
			
			_buffer.addChild(_logoGlow);
			
			bitmap.smoothing = true;
			bitmap.width = _width;
			bitmap.height = _height;
			
			_buffer.addChild(bitmap);
			
			bitmap = new Bitmap(new BitmapData(_width, _height, false, 0xffffff));
			
			var i:uint =0;
			var j :uint = 0;
			
			while(i < _height) {
				j = 0;
				while(j < _width)
					bitmap.bitmapData.setPixel(j++,i,0);
				i+=2;
			}
			bitmap.blendMode = "overlay";
			bitmap.alpha = 0.25;
			
			_buffer.addChild(bitmap);
		}

		protected function destroy():void
		{
			removeChild(_buffer);
			_buffer = null;
			_bmpBar = null;
			_text = null;
			_logo = null;
			_logoGlow = null;
		}

		/**
		 * Override this function to manually update the preloader.
		 * 
		 * @param	Percent		How much of the program has loaded.
		 */
		protected function update(percent:Number):void {

			_bmpBar.scaleX = percent * (_width - 8);
			_text.text = ".:: YAPI GAMES ::. " + Math.floor(percent * 100)+"%";
			_text.setTextFormat(_text.defaultTextFormat);
			
			if(percent < 0.1) {
				_logoGlow.alpha = 0;
				_logo.alpha = 0;
			} else if(percent < 0.15) {
				_logoGlow.alpha = Math.random();
				_logo.alpha = 0;
			} else if(percent < 0.2) {
				_logoGlow.alpha = 0;
				_logo.alpha = 0;
			} else if(percent < 0.25) {
				_logoGlow.alpha = 0;
				_logo.alpha = Math.random();
			} else if(percent < 0.7) {
				_logoGlow.alpha = (percent - 0.45) / 0.45;
				_logo.alpha = 1;
			} else if((percent > 0.8) && (percent < 0.9)) {
				_logoGlow.alpha = 1-(percent - 0.8) / 0.1;
				_logo.alpha = 0;
			} else if(percent > 0.9) {
				_buffer.alpha = 1 - (percent - 0.9) / 0.1;
			}
		}
	}
}