package model.map 
{
	import flash.geom.Point;
	import go.GO;
	import model.Random;
	/**
	 * ...
	 * @author Dark Lich
	 */
	public class MapGenerator implements IMap 
	{
		private var _mapSize:Point;
		private var _mapArray:Array;
		private var _wayVector:Vector.<Point> = new Vector.<Point>();
		
		public function MapGenerator(mapWidth:int, mapHeight:int) 
		{
			_mapSize = new Point(mapWidth, mapHeight);
			generateCleanMap();
			generateWay();
			updateMapWithWays();
		}
		
		private function generateCleanMap():void {
			var terrArr:Array = ["grass","none","terra","water"];
			_mapArray = [];
			for (var j:int = 0; j < _mapSize.y; j++) {
				_mapArray[j] = [];
				for (var i:int = 0; i < _mapSize.x; i++) {
					var mapSector:MapSector = new MapSector();
					mapSector.kind = terrArr[Random.random(0,4)];
					mapSector.position = new Point(i, j);
					_mapArray[j][i] = mapSector;
				}
			}
		}
		
		private function generateWay():void {
			_wayVector.push(new Point(3, 0));
			_wayVector.push(new Point(3, 1));
			_wayVector.push(new Point(4, 1));
			_wayVector.push(new Point(4, 2));
			_wayVector.push(new Point(4, 3));
			_wayVector.push(new Point(4, 4));
			_wayVector.push(new Point(4, 5));
			_wayVector.push(new Point(4, 6));
			_wayVector.push(new Point(4, 7));
			_wayVector.push(new Point(3, 7));
			_wayVector.push(new Point(2, 7));
			_wayVector.push(new Point(2, 6));
			_wayVector.push(new Point(2, 5));
			_wayVector.push(new Point(1, 5));
			_wayVector.push(new Point(0, 5));
			_wayVector.push(new Point(0, 6));
			_wayVector.push(new Point(0, 7));
			_wayVector.push(new Point(0, 8));
			//for (var j:int = 0; j < mapSize.y; j++) {
				//_wayVector
			//}
		}
		
		private function updateMapWithWays():void {
			for each (var value:Point in _wayVector) {
				var mapSector:MapSector = new MapSector();
				mapSector.kind = "R";
				mapSector.position = value;
				_mapArray[value.y][value.x] = mapSector;
			}
		}
		
		/* INTERFACE model.map.IMap */
		
		public function get mapArray():Array 
		{
			return _mapArray;
		}
		
		public function get mapSize():Point 
		{
			return _mapSize;
		}
		
		public function get wayVector():Vector.<Point> 
		{
			return _wayVector;
		}
		
	}

}