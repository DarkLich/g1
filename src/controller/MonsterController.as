package controller 
{
	import flash.display.DisplayObjectContainer;
	import flash.events.Event;
	import flash.events.EventDispatcher;
	import flash.geom.Point;
	import go.GO;
	import model.IUpdate;
	import model.Monster;
	import view.MonstersV;
	import view.MonsterV;
	
	/**
	 * ...
	 * @author Dark Lich
	 */
	public class MonsterController extends EventDispatcher 
	{
		private var monstersArr:Vector.<Monster> = new Vector.<Monster>;
		public function MonsterController(mainV:DisplayObjectContainer) {
			var monstersV:MonstersV = new MonstersV();
			mainV.addChild(monstersV);
			
			var monster:Monster = new Monster(GO.levelMap.wayVector);
			monstersArr.push(monster);
			var monsterV:MonsterV = new MonsterV(monster);
			monstersV.addChild(monsterV);
			monster.addEventListener(Monster.UPDATED, monsterV.update);
			monster.addEventListener(Monster.FINISH, finish);
			monster.addEventListener(Monster.FINISH, monsterV.finish);
			
			GO.main.addEventListener(Event.ENTER_FRAME, onEnterFrame);
		}
		
		private function onEnterFrame(ev:Event):void {
			for each (var mon:IUpdate in monstersArr) {
				mon.update();
			}
		}
		
		private function finish(ev:Event):void {
			monstersArr.splice(monstersArr.indexOf(ev.currentTarget), 1);
		}
	}

}