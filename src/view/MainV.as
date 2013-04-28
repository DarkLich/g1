package view 
{
	import flash.display.Sprite;
	import go.GO;
	
	/**
	 * ...
	 * @author Dark Lich
	 */
	public class MainV extends Sprite 
	{
		
		public function MainV() 
		{
			graphics.beginFill(0);
			graphics.drawRect(0, 0, GO.stageWidth, GO.stageHeight);
		}
		
	}

}