package go 
{
	import flash.display.DisplayObjectContainer;
	import flash.display.Stage;
	import flash.events.Event;
	import flash.events.EventDispatcher;
	import flash.geom.Point;
	import model.map.IMap;
	import model.tower.Tower;
	/**
	 * ...
	 * @author Dark Lich
	 */
	public class GO extends EventDispatcher
	{
		public static var stage:Stage;
		public static var configXml:XML;
		public static var stageWidth:int;
		public static var stageHeight:int;
		public static var levelMap:IMap;
		public static var main:DisplayObjectContainer;
		//public static var towerDragging:Boolean = false;
		public static var fieldSize:Point = new Point(64, 64);
		public static var mapSizeFields:Point = new Point(1, 1);
		public static var mapSizePixels:Point = new Point(64, 64);
		public static var wayCover:Vector.<Vector.<Tower>> = new Vector.<Vector.<Tower>>;
		public static var monstersCount:int = 0;
		public static var towersCount:int = 0;
		
		public static var dispatcher:EventDispatcher = new EventDispatcher();				//диспатчер (на него вешаем листенеры)
		
		public function GO() 
		{
			
		}
		
		public static function dispatch(dispEvent:String):void {
			dispatcher.dispatchEvent(new Event(dispEvent));
		}
		
	}

}