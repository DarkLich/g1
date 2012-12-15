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
	public class MapC extends EventDispatcher 
	{
		
		public function MapC(mainView:DisplayObjectContainer) 
		{
			var levelMap:MapGenerator = new MapGenerator(9, 9);
			GO.levelMap = levelMap;
			var map:MapV = new MapV(levelMap);
			mainView.addChild(map);
		}
		
	}

}