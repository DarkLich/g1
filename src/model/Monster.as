package model 
{
	import flash.events.Event;
	import flash.events.EventDispatcher;
	import flash.geom.Point;
	import go.GO;
	import model.tower.Tower;
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
		public var respTime:int = 0;
		public var id:int;
		public var attackingTowers:Vector.<Tower> = new Vector.<Tower>;
		
		public static const UPDATED:String = "updated";
		public static const START:String = "start";
		public static const FINISH:String = "finish";
		public static const POSITION_CHANGED:String = "posititon_changed";
		
		public function Monster(way:Vector.<Point>, respTime:int) 
		{
			id = GO.towersCount++;
			this.respTime = respTime;
			this.way = way;
			speed = 0.05;
			positionNum = 0;
			position = new Point(way[positionNum].x, way[positionNum].y);
		}
		
		public function update():void {
			if (respTime < 0){ 
				if (positionNum+1 == way.length) {
						dispatchEvent(new Event(FINISH));
				} else {
						if (position.x < way[positionNum + 1].x) {
							position.x += speed;
						}
						if (position.x > way[positionNum + 1].x) {
							position.x -= speed;
						}
						if (position.y < way[positionNum + 1].y) {
							position.y += speed;
						}
						if (position.y > way[positionNum + 1].y) {
							position.y -= speed;
						}
						if ((Math.abs(position.x - way[positionNum + 1].x) <= speed )&&(Math.abs(position.y - way[positionNum + 1].y) <= speed)) {
							positionNum++;
							if (!(positionNum+1 == way.length)) {
								dispatchEvent(new Event(POSITION_CHANGED));
							}
						}
						//position = new Point(position.x, position.y);
						dispatchEvent(new Event(UPDATED));
				}
			} else {
				respTime--;
				if (respTime < 0) { 
					dispatchEvent(new Event(START));
				}
			}
			//trace(position.y);
		}
		
		public function getWayPosition():int {
			return positionNum;
		}
		
		public function addTower(tower:Tower):void {
			var towerAdded:Boolean = false;
			for each (var tow:Tower in attackingTowers) {
				if (tow.id == tower.id) {
					towerAdded = true;
				}
			}
			if (!towerAdded){
				attackingTowers.push(tower);
			}
		}
		
		public function removeTowers():void {
			attackingTowers = new Vector.<Tower>;
		}
		
	}

}