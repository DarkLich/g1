package com.connections.xmlLoaders 
{
	import flash.errors.IOError;
	import flash.events.Event;
	import flash.events.EventDispatcher;
	import flash.events.IOErrorEvent;
	import flash.net.URLLoader;
	import flash.net.URLRequest;
	/**
	 * ...
	 * @author ЙА
	 */
	public class SimpleXMLLoader extends EventDispatcher 
	{
		private var _loadedXML		:XML;
		private var _error			:String;
		public var label			:String = "";
		
		public static const LOADED:String = "loaded";
		public static const LOADING_ERROR:String = "loadingError";
		
		public function SimpleXMLLoader() 
		{
			
		}
		
		public function load(url:String):void {
			var xmlUrlRequest:URLRequest = new URLRequest(url+"?random="+new Date().getTime());
			var xmlLoader:URLLoader = new URLLoader();
			xmlLoader.load(xmlUrlRequest);
			xmlLoader.addEventListener(Event.COMPLETE, onComplete);
			xmlLoader.addEventListener(IOErrorEvent.IO_ERROR, onError);
		}
		
		private function onComplete(ev:Event):void {
			try {
				_loadedXML = new XML(ev.target.data);
				dispatchEvent(new Event(LOADED));
			}
			catch (error:Error) {
				trace("wrong XML file"); //xml загрузилось но не то )
				dispatchEvent(new Event(LOADING_ERROR));
			}
		}
		
		private function onError(ev:IOErrorEvent):void {
			trace("Loading XML error",ev.text);
			_error = ev.text;
			dispatchEvent(new Event(LOADING_ERROR));
		}
		
		public function get loadedXML():XML {
			return _loadedXML;
		}
		
		public function get error():String {
			return _error;
		}
	}
}
