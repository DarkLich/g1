package model.map 
{
	import flash.geom.Point;
	/**
	 * ...
	 * @author Dark Lich
	 */
	public class MapGenerator implements IMap 
	{
		private var _mapSize:Point;
		private var _mapArray:Array;
		private var _mapVector:Vector.<MapSector>;
		private var _wayVector:Vector.<Point> = new Vector.<Point>();
		
		public function MapGenerator(mapWidth:int, mapHeight:int) 
		{
			_mapSize = new Point(mapWidth, mapHeight);
			_mapVector = new Vector.<MapSector>();
			generateCleanMap();
			generateWay();
			updateMapWithWays();
		}
		
		private function generateCleanMap():void {
			_mapArray = [];
			for (var j:int = 0; j < _mapSize.y; j++) {
				_mapArray[j] = [];
				for (var i:int = 0; i < _mapSize.x; i++) {
					var mapSector:MapSector = new MapSector();
					mapSector.kind = "G";
					mapSector.position = new Point(i, j);
					_mapArray[j][i] = mapSector;
					_mapVector.push(mapSector);
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
			_wayVector.push(new Point(3, 5));
			_wayVector.push(new Point(3, 6));
			_wayVector.push(new Point(4, 7));
			_wayVector.push(new Point(4, 8));
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
		
		public function get mapVector():Vector.<MapSector> 
		{
			return _mapVector;
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