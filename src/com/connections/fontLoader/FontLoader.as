package com.connections.fontLoader 
{
	import com.VO.MainVO;
	import flash.display.Loader;
	import flash.events.Event;
	import flash.events.EventDispatcher;
	import flash.net.URLRequest;
	import flash.system.ApplicationDomain;
	import flash.system.LoaderContext;
	import flash.system.SecurityDomain;
	import flash.text.Font;
	/**
	 * ...
	 * @author ЙА
	 */
	public class FontLoader extends EventDispatcher
	{
		public static const FONTS_LOADED:String = "fontsLoaded";
		
		public function FontLoader() 
		{
			
		}
		
		public function load():void {
			MainVO.dispatch(MainVO.SHOW_PRELOADER);
			
			var loaderContext:LoaderContext = new LoaderContext(); 
			//loaderContext.securityDomain = SecurityDomain.currentDomain;
			loaderContext.applicationDomain = ApplicationDomain.currentDomain;
			var request:URLRequest;
			if (MainVO.localTesting) {
				request = new URLRequest(MainVO.fontsXML.item[0]);
				//request = new URLRequest(MainVO.configXML.rootDir + "/" + MainVO.fontsXML.item[0]);
			}else{
				request = new URLRequest(MainVO.configXML.rootDir + "/" + MainVO.fontsXML.item[0]);
			}
			var loader:Loader = new Loader();
			loader.load(request,loaderContext);
			loader.contentLoaderInfo.addEventListener(Event.COMPLETE, onComplete);
		}
		
		private function onComplete(ev:Event):void {
			try {
				var runtimeClassRef:Class = ev.target.applicationDomain.getDefinition("FontsAsset")  as  Class;
				var greeter:Object  = new runtimeClassRef();
				MainVO.fontNamesArray = greeter.fontNamesArray();
				MainVO.fontNamesArray.sort();
				MainVO.fontClassesArray = greeter.fontClassesArray();
			}
			catch (a:Error) { 
				trace(a.message)
			};
		/*	for (var i:int = 0; i < MainVO.fontClassesArray.length; i++) {
				//trace(MainVO.fontClassesArray[i]);
				//trace(ev.target.applicationDomain.hasDefinition("FontsAsset_"+MainVO.fontClassesArray[i]));
				
				try {
					var NewFontClass:Class = ev.target.applicationDomain.getDefinition("FontsAsset_"+MainVO.fontClassesArray[i]) as Class;
					Font.registerFont(NewFontClass);
					//var nf:Font = new NewFontClass() as Font;
					//trace(nf.fontName);
				}
				catch (a:Error) { 
					trace(a.message)
				};
			}*/
			
			
			//var allFonts:Array = Font.enumerateFonts(false);
			//allFonts.sortOn("fontName", Array.CASEINSENSITIVE);
			MainVO.dispatch(MainVO.HIDE_PRELOADER);
			dispatchEvent(new Event(FONTS_LOADED));
		}
	}

}