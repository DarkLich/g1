package view 
{
	import flash.display.Bitmap;
	import flash.display.Sprite;
	
	/**
	 * ...
	 * @author Lich
	 */
	public class Textures extends Sprite 
	{
		[Embed(source = "../../lib/images/grass.jpg")]
		public var Grass:Class;
		[Embed(source = "../../lib/images/road.jpg")]
		public var Road:Class;
		[Embed(source = "../../lib/images/mob.png")]
		public var Mob:Class;
		
		public function Textures() 
		{
			
		}
		
		//public function get grass():Bitmap {
			//return new Grass();
		//}
		
	}

}