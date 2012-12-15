package  
{
	import flash.display.Bitmap;
	import flash.display.Sprite;
	import view.Textures;
	/**
	 * ...
	 * @author LoloL
	 */
	public class TowerV extends Sprite
	{
		public var hp:int;
		public var mp:int;
		public var attackSpeed:int;
		public var range:int;
		public var bullet:Bullet;
		public var cost:int;
		//public var armor:Array = new Array();
		//public var attack:Array = new Array();
		//public var ability:Array = new Array();
		
		public function TowerV() 
		{
			var a:Textures
			var bit:Bitmap = new Textures.PTower();
			addChild(bit);
		}
		
	}

}