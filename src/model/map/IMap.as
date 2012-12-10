package model.map
{
	import flash.geom.Point;
	
	/**
	 * ...
	 * @author Dark Lich
	 */
	public interface IMap
	{
		function get mapArray():Array;
		function get mapVector():Vector.<MapSector>;
		function get mapSize():Point;
		function get wayVector():Vector.<Point>;
	}
	
}