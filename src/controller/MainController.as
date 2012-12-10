package controller 
{
	import flash.display.DisplayObjectContainer;
	import flash.events.EventDispatcher;
	import view.MainView;
	
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
		}
		
	}

}