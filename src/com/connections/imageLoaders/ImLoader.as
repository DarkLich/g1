package com.connections.imageLoaders
{
	import flash.display.Bitmap;
	import flash.display.BitmapData;
	import flash.display.Loader;
	import flash.display.Sprite;
	import flash.events.Event;
	import flash.events.ProgressEvent;
	import flash.net.SharedObjectFlushStatus;
	import flash.net.URLRequest;
	import flash.system.LoaderContext;
	import flash.text.TextField;
	import flash.text.TextFieldAutoSize;
	
	/**
	 * ...
	 * @author ЙА
	 */
	public class ImLoader extends Sprite 
	{		
		private var _preloader				:Sprite;
		private var _loader					:Loader;
		private var _loadStatus				:TextField;
		private var	_load_width_height		:Number;
		private var _imWidth				:Number;
		private var _imHeight				:Number;
		private var _loadedBitmap			:Bitmap;
		private var _centering				:Boolean;
		private var _cellCentering			:Boolean;
		private var _proportionality		:Boolean;
		private var _loadedBitmapData		:BitmapData;
		
		public var _originalWidth			:Number;
		public var _originalHeight			:Number;
		public var _imURL					:String;
		
		public static const IMG_LOADED		:String = 'imageLoaded';
		
		public function ImLoader(imURL:String, imWidth:Number=100, imHeight:Number=100, centering:Boolean=false, proportionality:Boolean=true, cellCentering:Boolean=false) {
			_imWidth = imWidth;
			_imHeight = imHeight;
			_centering = centering;
			_proportionality = proportionality;
			_cellCentering = cellCentering;
			_imURL = imURL;
			var loaderContext:LoaderContext = new LoaderContext(); 
			loaderContext.checkPolicyFile = true; 
			var request:URLRequest = new URLRequest(imURL);
			_loader = new Loader();
			_loader.load(request,loaderContext);
			_loader.contentLoaderInfo.addEventListener(Event.OPEN,displayPreloader);
			_loader.contentLoaderInfo.addEventListener(ProgressEvent.PROGRESS,updatePreloader);
			_loader.contentLoaderInfo.addEventListener(Event.COMPLETE, displayImage);
		}
		private function displayPreloader(evt:Event):void {
			_preloader = new Sprite();
			if (_centering) {
				_preloader.graphics.lineStyle(1, 0, 1, false, "none");
				_preloader.graphics.drawRect(-_imWidth/2, _imHeight / 2 - 5, _imWidth, 10);
			}else{
				_preloader.graphics.lineStyle(1, 0, 1, false, "none");
				_preloader.graphics.drawRect(0, _imHeight / 2 - 5, _imWidth, 10);
			}
			addChild(_preloader);
			//_loadStatus = new TextField;
			//_loadStatus.textColor = 0xFF00FF;
			//_loadStatus.autoSize = TextFieldAutoSize.LEFT;
			//addChild(_loadStatus);
		}
		private function updatePreloader(evt:ProgressEvent):void {
			_preloader.graphics.beginFill(0xFF0000, 0.9);
			if (_centering) {
				_preloader.graphics.drawRect( -_imWidth / 2, _imHeight / 2 - 5, (_imWidth) * evt.bytesLoaded / evt.bytesTotal, 10);
			}else {
				_preloader.graphics.drawRect(0, _imHeight / 2 - 5, (_imWidth) * evt.bytesLoaded / evt.bytesTotal, 10);
			}
			//_loadStatus.text = "loaded:"+evt.bytesLoaded+" from "+evt.bytesTotal;
		}
		private function displayImage(evt:Event):void {
			//removeChild(_loadStatus);
			removeChild(_preloader);
			addChild(_loader);
			_originalWidth = _loader.width;
			_originalHeight = _loader.height;
			evt.target.content.smoothing = true;
			_loadedBitmap = evt.target.content;
			_loadedBitmapData = _loadedBitmap.bitmapData;
			if (_proportionality){
				if (_loader.width>=_imWidth){
					_load_width_height=_loader.height/_loader.width;
					_loader.width=_imWidth;
					_loader.height = _loader.width * _load_width_height;
				}
				if (_loader.height>=_imHeight){
					_load_width_height=_loader.width/_loader.height;
					_loader.height=_imHeight;
					_loader.width = _loader.height * _load_width_height;
				}
			} else {
				_loader.width = _imWidth;
				_loader.height = _imHeight;
			}
			
			
			if (_centering) {
				_loader.x = _loader.x - _loader.width / 2;
				_loader.y = _loader.y - _loader.height / 2;
			}
			
			if (_cellCentering) {
				_loader.x = (_imWidth-_loader.width) / 2;
				_loader.y = (_imHeight - _loader.height) / 2;
			}
			
			mouseChildren = false;
			mouseEnabled = true;
			dispatchEvent(new Event(IMG_LOADED,true));
		}
		
		public function get sizeCoefficient():Number {
			return _loader.width / _originalWidth;
		}
		
		public function get imWidth():Number {
			return _loader.width;
		}
		public function get imHeight():Number {
			return _loader.height;
		}
		
		public function get imX():Number {
			return _loader.x;
		}
		public function get imY():Number {
			return _loader.y;
		}
		public function get loadedBitmap():Bitmap {
			return _loadedBitmap;
		}
		public function get loadedBitmapData():BitmapData {
			return _loadedBitmapData;
		}
	}

}