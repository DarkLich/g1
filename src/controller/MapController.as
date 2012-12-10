package controller 
{
	import flash.display.DisplayObjectContainer;
	import flash.events.EventDispatcher;
	import go.GO;
	import model.LevelMap;
	import model.map.MapGenerator;
	import view.Map;
	
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
			var map:Map = new Map(levelMap);
			mainView.addChild(map);
		}
		
	}

}