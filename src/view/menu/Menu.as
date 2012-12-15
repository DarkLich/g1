package view.menu 
{
	import flash.display.Sprite;
	
	/**
	 * ...
	 * @author Dark Lich
	 */
	public class Menu extends Sprite 
	{
		
		public function Menu() 
		{
			var buyTower:BuyTower = new BuyTower();
			addChild(buyTower);
		}
		
	}

}