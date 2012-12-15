package controller 
{
	import flash.display.DisplayObjectContainer;
	import flash.events.EventDispatcher;
	import view.MainView;
	import view.menu.Menu;
	
	/**
	 * ...
	 * @author Dark Lich
	 */
	public class MainC extends EventDispatcher 
	{
		
		public function MainC(main:DisplayObjectContainer) 
		{
			var mainView:MainView = new MainView();
			main.addChild(mainView);
			
			var mapC:MapC = new MapC(mainView);
			
			var monsterC:MonsterC = new MonsterC(mainView);
			
			var towerC:TowerC = new TowerC(mainView);
			
			var menu:Menu = new Menu();
			mainView.addChild(menu);
		}
		
	}

}