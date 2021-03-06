package controller 
{
	import flash.display.DisplayObjectContainer;
	import flash.events.EventDispatcher;
	import go.GO;
	import model.LevelMap;
	import model.map.Map;
	import view.MapV;
	
	/**
	 * ...
	 * @author Dark Lich
	 */
	public class MapC extends EventDispatcher 
	{
		
		public function MapC(conteiner:DisplayObjectContainer) 
		{
			var levelMap:Map = new Map(GO.mapSizeFields.x, GO.mapSizeFields.y);
			GO.levelMap = levelMap;
			var map:MapV = new MapV(levelMap);
			conteiner.addChild(map);
		}
		
	}

}