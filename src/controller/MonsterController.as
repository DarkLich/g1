package controller 
{
	import flash.display.DisplayObjectContainer;
	import flash.events.Event;
	import flash.events.EventDispatcher;
	import flash.geom.Point;
	import go.GO;
	import model.IUpdate;
	import model.Monster;
	import view.MonstersView;
	import view.MonsterView;
	
	/**
	 * ...
	 * @author Dark Lich
	 */
	public class MonsterController extends EventDispatcher 
	{
		private var monstersArr:Vector.<Monster> = new Vector.<Monster>;
		public function MonsterController(mainView:DisplayObjectContainer) {
			var monstersView:MonstersView = new MonstersView();
			mainView.addChild(monstersView);
			
			var monster:Monster = new Monster(GO.levelMap.wayVector);
			monstersArr.push(monster);
			var monsterView:MonsterView = new MonsterView(monster);
			monstersView.addChild(monsterView);
			monster.addEventListener(Monster.UPDATED, monsterView.update);
			monster.addEventListener(Monster.FINISH, finish);
			monster.addEventListener(Monster.FINISH, monsterView.finish);
			
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