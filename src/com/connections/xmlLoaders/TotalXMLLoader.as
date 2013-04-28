package com.connections.xmlLoaders 
{
	import com.VO.MainVO;
	import flash.events.Event;
	import flash.events.EventDispatcher;
	
	/**
	 * ...
	 * @author ЙА
	 */
	public class TotalXMLLoader extends EventDispatcher 
	{
		public var configXML			:XML;
		private var xmlCount			:int=0;	//количество XML файлов, ожидающих загрузки
		private var xmlLoaded			:int=0;	//количество загруженых XML файлов
		
		public static const LOADING_COMPLETE	:String = "loaded_complete";
		
		public function TotalXMLLoader() 
		{
			
		}
		
		public function load(configXMLurl:String):void {
			var configXMLLoader:SimpleXMLLoader = new SimpleXMLLoader();
			configXMLLoader.addEventListener(SimpleXMLLoader.LOADED, configXMLWasLoaded);
			configXMLLoader.load(configXMLurl);
		}
		
		private function configXMLWasLoaded(ev:Event):void {
			configXML = ev.target.loadedXML;
			MainVO.configXML = configXML;
			for (var i:int = 0; i < configXML.xmlFiles.item.length(); i++) {
				xmlCount++;
				var fileName:String = configXML.xmlFiles.item[i];
				var simpleXMLLoader:SimpleXMLLoader = new SimpleXMLLoader();
				simpleXMLLoader.addEventListener(SimpleXMLLoader.LOADED, simpleXMLLoaded);
				simpleXMLLoader.label = configXML.xmlFiles.item[i].@name;
				if (configXML.xmlFiles.item[i].@name == "interfaceXML") {
					fileName = configXML.xmlFiles.item[i].en;
					if (MainVO.localTesting) fileName = configXML.xmlFiles.item[i].de;
					
					if (MainVO.flashVarsObject["language"] == "de") fileName = configXML.xmlFiles.item[i].de;
					if (MainVO.flashVarsObject["language"] == "en") fileName = configXML.xmlFiles.item[i].en;
				}
				simpleXMLLoader.load(configXML.rootDir+"/"+fileName);
			}
			
		}
		
			
		private function simpleXMLLoaded(ev:Event):void {
			if (ev.target.label=="fotoliaCategoriesXML"){
				MainVO.fotoliaCategoriesXML = ev.target.loadedXML;
			}
			if (ev.target.label=="serverCategoriesXML"){
				MainVO.serverCategoriesXML = ev.target.loadedXML;
			}
			if (ev.target.label=="clipartCategoriesXML"){
				MainVO.clipartCategoriesXML = ev.target.loadedXML;
			}
			if (ev.target.label=="stickerCategoriesXML"){
				MainVO.stickerCategoriesXML = ev.target.loadedXML;
			}
			if (ev.target.label == "fontsXML") {
				MainVO.fontsXML = ev.target.loadedXML;
			}
			if (ev.target.label == "interfaceXML") {
				MainVO.interfaceXML = ev.target.loadedXML;
			}
			xmlLoaded++;
			if (xmlLoaded==xmlCount) loadingComplete();
		}
		
		private function loadingComplete():void {
			dispatchEvent(new Event(LOADING_COMPLETE));
		}
	}

}