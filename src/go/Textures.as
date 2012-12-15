package go 
{
	import flash.display.Bitmap;
	import flash.display.Sprite;
	
	/**
	 * ...
	 * @author Lich
	 */
	public class Textures extends Sprite 
	{
		private static var _instance:Textures = null;
		
		[Embed(source = "../../lib/images/grass.jpg")]
		public static var Grass:Class;
		[Embed(source = "../../lib/images/road.jpg")]
		public static var Road:Class;
		[Embed(source = "../../lib/images/mob.png")]
		public static var Mob:Class;
		[Embed(source = "../../lib/images/pumpkin_tower.png")]
		public static var PTower:Class;
		
		public function Textures() 
		{
			trace("new instance of Textures created");
		}
		
        public static function getInstance():Textures{
            if(_instance==null){
                _instance = new Textures();
            }
            return _instance;
        }
		//public function get grass():Bitmap {
			//return new Grass();
		//}
		
	}

}