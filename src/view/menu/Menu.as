package view.menu 
{
	import flash.display.Sprite;
	import go.GO;
	import view.menu.buyTower.BuyTowerMenu;
	
	/**
	 * ...
	 * @author Dark Lich
	 */
	public class Menu extends Sprite 
	{
		public var buyTowerMenu:BuyTowerMenu = new BuyTowerMenu();
		
		public function Menu() 
		{
			x = GO.stageWidth - 200;
			y = GO.stageHeight - 200;
			
			addChild(buyTowerMenu);
		}
		
	}

}