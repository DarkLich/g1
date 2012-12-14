package controller 
{
	import flash.display.DisplayObjectContainer;
	import flash.events.EventDispatcher;
	import go.GO;
	import model.LevelMap;
	import model.map.MapGenerator;
	import view.MapV;
	
	/**
	 * ...
	 * @author Dark Lich
	 */
	public class MapController extends EventDispatcher 
	{
		
		public function MapController(mainView:DisplayObjectContainer) 
		{
			var levelMap:MapGenerator = new MapGenerator(9, 9);
			GO.levelMap = levelMap;
			var map:MapV = new MapV(levelMap);
			mainView.addChild(map);
		}
		
	}

}