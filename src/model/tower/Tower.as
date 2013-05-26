package model.tower 
{
	import flash.display.BitmapData;
	import flash.display.Sprite;
	import flash.events.Event;
	import flash.events.EventDispatcher;
	import flash.geom.Point;
	import go.GO;
	import model.IUpdate;
	import model.monster.Monster;
	
	/**
	 * ...
	 * @author Dark Lich
	 */
	public class Tower extends EventDispatcher implements IUpdate
	{
		public var hp:int;
		public var mp:int;
		public var attackSpeed:int;
		public var dmg:int = 1;
		public var range:int = 1;
		public var bullet:Bullet;
		public var cost:int;
		public var position:Point;
		public var type:String;
		public var active:Boolean = true;
		public var monstersInRange: Vector.<Monster> = new Vector.<Monster>;
		public var relFieldCover:Vector.<Point> = new Vector.<Point>;
		public var absFieldCover:Vector.<Point> = new Vector.<Point>;
		public var id:int;
		public var targetMonster:Monster;
		
		public static const UPDATED:String = "updated";
		public static const FIRE:String = "fire";
		
		public function Tower(x:int = 0, y:int = 0) {
			id = GO.towersCount++;
			position = new Point(x, y);
			
			var c:int = 0;
			for (var i:int = -range; i <= range; i++) {
				for (var j:int = -range; j <= range; j++) {
					relFieldCover[c] = new Point(i, j);
					c++;
				}
			}
			//var c:int = 0;
			//for (var i:int = -range; i <= range; i++) {
				//relFieldCover[c] = new Point(i,j);
				//for (var j:int = Math.abs(i) - range; j <= range - Math.abs(i); j++) {
					//relFieldCover[c] = new Point(i,j);
					//c++;
				//}
			//}
		}
		
		/* INTERFACE model.IUpdate */
		
		public function update():void 
		{
			if (monstersInRange.length > 0) {
				monstersInRange[0].hit(dmg);
				dispatchEvent(new Event(FIRE));
			}
			//for each (var mon:Monster in monstersInRange) {
				//targetMonster.hit(dmg);
				//dispatchEvent(new Event(FIRE));
			//}
			dispatchEvent(new Event(UPDATED));
		}
		
		public function addMonster(monster:Monster):void {
			var monsterAdded:Boolean = false;
			if (monstersInRange.indexOf(monster) >= 0) {
				monsterAdded = true;
			}
			if (!monsterAdded){
				monstersInRange.push(monster);
			}
			targetMonster = monstersInRange[0];
		}
		
		public function removeMonster(monster:Monster):void {
			monstersInRange.splice(monstersInRange.indexOf(monster), 1);
		}
		
	}

}