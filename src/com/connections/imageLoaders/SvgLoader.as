package com.connections.imageLoaders
{
	import com.lorentz.SVG.display.SVGDocument;
	import com.lorentz.SVG.events.SVGEvent;
	import flash.display.Bitmap;
	import flash.display.Loader;
	import flash.display.Sprite;
	import flash.events.Event;
	import flash.events.ProgressEvent;
	import flash.net.SharedObjectFlushStatus;
	import flash.net.URLLoader;
	import flash.net.URLRequest;
	import flash.system.LoaderContext;
	import flash.text.TextField;
	import flash.text.TextFieldAutoSize;
	
	/**
	 * ...
	 * @author ЙА
	 */
	public class SvgLoader extends Sprite 
	{		
		private var _preloader				:Sprite;
		public var holder					:Sprite;
		//private var _loader					:Loader;
		private var _urlLoader				:URLLoader;
		private var _xmlArray				:Vector.<XML>;
		private var _svgElementsArray		:Vector.<SVGDocument>;
		private var _paleteArray			:Array=[];
		private var _elementsColor			:Array=[];
		private var _loadStatus				:TextField;
		private var	_load_width_height		:Number;
		private var _imWidth				:Number;
		private var _imHeight				:Number;
		//public var _targetUrl				:String;
		private var _loadedBitmap			:Bitmap;
		private var _centering				:Boolean;
		private var _cellCentering			:Boolean;
		private var _proportionality		:Boolean;
		public var index					:int = 0;
		private var parsedElementsNum		:int = 0;
		
		public var _originalWidth			:Number;
		public var _originalHeight			:Number;
		public var _imURL					:String;
		
		public static const IMG_LOADED		:String = 'imageLoaded';
		
		public function SvgLoader(imURL:String, imWidth:Number=100, imHeight:Number=100, centering:Boolean=false, proportionality:Boolean=true, cellCentering:Boolean=false) {
			//_targetUrl = targetUrl;
			_imWidth = imWidth;
			_imHeight = imHeight;
			_centering = centering;
			_proportionality = proportionality;
			_cellCentering = cellCentering;
			_imURL = imURL;
			
			holder = new Sprite();
			addChild(holder);
			holder.visible = false;
		//	holder.addEventListener(Event.ADDED, onad);
			
			_urlLoader = new URLLoader();
			_urlLoader.load(new URLRequest(imURL));
			_urlLoader.addEventListener(Event.OPEN, displayPreloader);
			_urlLoader.addEventListener(ProgressEvent.PROGRESS,updatePreloader);
			_urlLoader.addEventListener(Event.COMPLETE, onComplete);
		}
		
		private function onComplete(ev:Event):void {
			var svgXML:XML = new XML(ev.target.data);
			
			_xmlArray = new Vector.<XML>();
			
			/*_svgElementsArray = new Vector.<SVGDocument>();
			var svgDoc:SVGDocument = new SVGDocument();
				svgDoc.addEventListener(SVGEvent.PARSE_COMPLETE, onParseComplete);
				svgDoc.parse(svgXML);
				_svgElementsArray.push(svgDoc);
				addChild(svgDoc);
			_xmlArray.push(svgXML)*/;
				
			if (svgXML.children().length() > 0) 
			{
				for (var i:int = 0; i < svgXML.children().length(); i++ ) {
					//var svgXMLPart:XML = <svg version="1.1" id="Ebene_1" xmlns="http://www.w3.org/2000/svg" xmlns:xlink="http://www.w3.org/1999/xlink" x="0px" y="0px"
							  //width="170.079px" height="120.014px" viewBox="0 0 170.079 120.014" enable-background="new 0 0 170.079 120.014"
							  //xml:space="preserve">
								//
							 //</svg>
					
					if (svgXML.children()[i].name().localName=="g"){
						for (var j:int = 0; j < svgXML.children()[i].children().length(); j++ ) {
							var svgXMLPart:XML =<svg/>;
							svgXMLPart.setChildren(svgXML.children()[i].children()[j]);
							_xmlArray.push(svgXMLPart);
						}
					}else {
						var svgXMLPart:XML =<svg/>;
						svgXMLPart.setChildren(svgXML.children()[i]);
						_xmlArray.push(svgXMLPart);
					}
				}
			}
			
			var paleteIsFull:Boolean = false;
			for (var k:int = 0; k < _xmlArray.length; k++ ) {
				_elementsColor.push(-1);
				if (_xmlArray[k].children()[0].@fill.length() != 0) {
					var col:int = int("0x"+String(_xmlArray[k].children()[0].@fill).slice(1));
					for (var j:int = 0; j < _paleteArray.length; j++) {
						if (_paleteArray[j] == col) {
							_elementsColor[k] = j;
							col = -1;
						}
					}
					if (col > -1 && !paleteIsFull) {
						_elementsColor[k] = _paleteArray.length;
						_paleteArray.push(col);
						
					}
				}
				if (_paleteArray.length >= 5) paleteIsFull=true;
			}
			
			_svgElementsArray = new Vector.<SVGDocument>();
			
			//for (var jj:int = 0; jj < _xmlArray.length; jj++ ) {
				//var svgDoc:SVGDocument = new SVGDocument();
				//svgDoc.addEventListener(SVGEvent.PARSE_COMPLETE, onParseComplete);
				//svgDoc.parse(_xmlArray[jj]);
				//_svgElementsArray.push(svgDoc);
				//addChild(svgDoc);
			//}
			if (_xmlArray.length > 0) {
				beginParse(0);
			}
			
		}
		
		private function beginParse(element:int):void {
			var svgDoc:SVGDocument = new SVGDocument();
			svgDoc.addEventListener(SVGEvent.PARSE_COMPLETE, onParseComplete);
			svgDoc.parse(_xmlArray[element]);
			_svgElementsArray.push(svgDoc);
			holder.addChild(svgDoc);
		}
		
		private function onParseComplete(ev:Event):void {
			parsedElementsNum++;
			if (parsedElementsNum == _xmlArray.length) {
				addEventListener(Event.ENTER_FRAME, onEnterFrame);
			}else {
				beginParse(parsedElementsNum);
			}
			
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
		
		private function onEnterFrame(ev:Event):void {
			if (holder.width > 0 || holder.height > 0) {
				removeEventListener(Event.ENTER_FRAME, onEnterFrame);
				displayImage(null);
			}
		}
		
		private function displayImage(evt:Event):void {
			//removeChild(_loadStatus);
			removeChild(_preloader);
			holder.visible = true;
			_originalWidth = holder.width;
			_originalHeight = holder.height;
			
			if (_proportionality){
				if (holder.width>=_imWidth){
					_load_width_height=holder.height/holder.width;
					holder.width=_imWidth;
					holder.height = holder.width * _load_width_height;
				}
				if (holder.height>=_imHeight){
					_load_width_height=width/holder.height;
					holder.height=_imHeight;
					holder.width = holder.height * _load_width_height;
				}
			} else {
				holder.width = _imWidth;
				holder.height = _imHeight;
			}
			
			
			if (_centering) {
				x = x - holder.width / 2;
				y = y - holder.height / 2;
			}
			
			if (_cellCentering) {
				x = (_imWidth-holder.width) / 2;
				y = (_imHeight - holder.height) / 2;
			}
			
			mouseChildren = false;
			mouseEnabled = true;
			
			dispatchEvent(new Event(IMG_LOADED, true));
			
		}
		
		public function get palete():Array {
			return _paleteArray;
		}
		
		public function get elementsArray():Vector.<SVGDocument> {
			return _svgElementsArray;
		}
		
		public function get elementsColor():Array {
			return _elementsColor;
		}
	}

}