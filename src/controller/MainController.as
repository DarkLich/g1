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
	public class MainController extends EventDispatcher 
	{
		
		public function MainController(main:DisplayObjectContainer) 
		{
			var mainView:MainView = new MainView();
			main.addChild(mainView);
			
			var mapController:MapController = new MapController(mainView);
			
			var monsterController:MonsterController = new MonsterController(mainView);
			
			var menu:Menu = new Menu();
			mainView.addChild(menu);
		}
		
	}

}