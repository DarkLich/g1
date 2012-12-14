package model 
{
	import flash.events.Event;
	import flash.events.EventDispatcher;
	import flash.geom.Point;
	/**
	 * ...
	 * @author Dark Lich
	 */
	public class Monster extends EventDispatcher implements IUpdate
	{
		public var hp:int, mp:int, speed:Number, agro:int;
		public var armor:Vector.<String> = new Vector.<String>;
		public var attack:Vector.<int> = new Vector.<int>;
		public var ability:Vector.<String>  = new Vector.<String>();
		private var positionNum:int;
		public var position:Point;
		public var way:Vector.<Point>;
		
		public static const UPDATED:String = "updated";
		public static const FINISH:String = "finish";
		
		public function Monster(way:Vector.<Point>) 
		{
			this.way = way;
			speed = 0.05;
			positionNum = 0;
			position = way[positionNum];
		}
		
		public function update():void {
			trace("Monster > ",positionNum, way.length);
			if (positionNum+1 == way.length) {
				trace("Monster > ","FINISH");
				dispatchEvent(new Event(FINISH));
			} else {
				if (position.x < way[positionNum + 1].x) {
					position.x = position.x + speed;
				}
				if (position.x > way[positionNum + 1].x) {
					position.x = position.x - speed;
				}
				if (position.y < way[positionNum + 1].y) {
					position.y = position.y + speed;
				}
				if (position.y > way[positionNum + 1].y) {
					position.y = position.y - speed;
				}
				if ((Math.abs(position.x - way[positionNum + 1].x) <= speed )&&(Math.abs(position.y - way[positionNum + 1].y) <= speed)) {
					positionNum++;
				}
				//position = new Point(position.x, position.y);
			}
			
			dispatchEvent(new Event(UPDATED));
		}
		
	}

}