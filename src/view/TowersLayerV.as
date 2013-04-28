package view 
{
	import flash.display.Sprite;
	import go.GO;
	
	/**
	 * ...
	 * @author DarkLich
	 */
	public class TowersLayerV extends Sprite 
	{
		
		public function TowersLayerV() 
		{
				graphics.beginFill(0xFFFFFF, 0.001);
				graphics.drawRect(0, 0, GO.mapSizePixels.x, GO.mapSizePixels.y);
		}
		
	}

}