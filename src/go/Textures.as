package go 
{
	import com.connections.imageLoaders.ImLoader;
	import flash.display.BitmapData;
	import flash.display.Sprite;
	import flash.events.Event;
	import flash.events.EventDispatcher;
	
	/**
	 * ...
	 * @author Lich
	 */
	public class Textures extends EventDispatcher 
	{
		private static var _instance:Textures = null;
		private var imagesToLoad:int = 0;
		private var loadedImages:int = 0;
		
		public var grass:BitmapData;
		public var mob:BitmapData;
		public var road:BitmapData;
		public var water:BitmapData;
		public var terra:BitmapData;
		public var none:BitmapData;
		public var tower1:BitmapData;
		public var tower2:BitmapData;
		public var tower3:BitmapData;
		public var tower4:BitmapData;
		
		public static const TEXTURES_LOADED:String = "textures_loaded";
		
		public function Textures() 
		{
			trace("new instance of Textures created");
		}
		
		public function loadTextures(imagesXML:XML):void {
			for (var i:int = 0; i < imagesXML.images.elements("*").length(); i++) {
				var imLoader:ImLoader = new ImLoader(imagesXML.images.elements("*")[i].src);
				imLoader.name = imagesXML.images.elements("*")[i].name;
				imLoader.addEventListener(ImLoader.IMG_LOADED, onLoaded);
				imagesToLoad++;
			}
		}
		
		private function onLoaded(ev:Event):void {
			switch(String(ev.currentTarget.name)) {
				case "Grass":
						grass = ev.currentTarget.loadedBitmapData;
				break;		
				case "Mob1":
						mob = ev.currentTarget.loadedBitmapData;
				break;	
				case "Road":
						road = ev.currentTarget.loadedBitmapData;
				break;	
				case "Water":
						water = ev.currentTarget.loadedBitmapData;
				break;	
				case "Terra":
						terra = ev.currentTarget.loadedBitmapData;
				break;	
				case "None":
						none = ev.currentTarget.loadedBitmapData;
				break;	
				case "Tower1":
						tower1 = ev.currentTarget.loadedBitmapData;
				break;	
				case "Tower2":
						tower2 = ev.currentTarget.loadedBitmapData;
				break;	
				case "Tower3":
						tower3 = ev.currentTarget.loadedBitmapData;
				break;	
				case "Tower4":
						tower4 = ev.currentTarget.loadedBitmapData;
				break;	
			}
			loadedImages++;
			if (loadedImages == imagesToLoad) {
				dispatchEvent(new Event(TEXTURES_LOADED));
			}
		}
        
		public static function getInstance():Textures{
				if(_instance==null){
						_instance = new Textures();
				}
				return _instance;
		}
		
	}

}