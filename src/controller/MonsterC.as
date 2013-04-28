package controller 
{
	import flash.display.DisplayObjectContainer;
	import flash.events.Event;
	import flash.events.EventDispatcher;
	import flash.geom.Point;
	import go.GO;
	import model.IUpdate;
	import model.Monster;
	import model.tower.Tower;
	import view.MonsterLayerV;
	import view.MonsterV;
	
	/**
	 * ...
	 * @author Dark Lich
	 */
	public class MonsterC extends EventDispatcher 
	{
		private var monstersArr:Vector.<Monster> = new Vector.<Monster>;
		private var z:int = 0;
		
		public function MonsterC(conteiner:DisplayObjectContainer) {
			var monsterLayerV:MonsterLayerV = new MonsterLayerV();
			conteiner.addChild(monsterLayerV);
			for (var i:int = 0 ; i < 3; i++) {
					var monster:Monster = new Monster(GO.levelMap.wayVector, i * Math.random() * 150);
					monstersArr.push(monster);
					var monsterV:MonsterV = new MonsterV(monster);
					monsterLayerV.addChild(monsterV);
					monster.addEventListener(Monster.UPDATED, monsterV.update);
					monster.addEventListener(Monster.FINISH, finish);
					monster.addEventListener(Monster.FINISH, monsterV.finish);
					monster.addEventListener(Monster.START, monsterV.start);
					monster.addEventListener(Monster.POSITION_CHANGED, onPositionChanged);
			}
			GO.main.addEventListener(Event.ENTER_FRAME, onEnterFrame);
		}
		
		private function onEnterFrame(ev:Event):void {
			//z++;
			//if (z>10){
					for each (var mon:IUpdate in monstersArr) {
						mon.update();
					}
					//z = 0;
			//}
		}
		
		private function finish(ev:Event):void {	
			monstersArr.splice(monstersArr.indexOf(ev.currentTarget), 1);
		}
		
		private function onPositionChanged(ev:Event):void {
			var monster:Monster = ev.currentTarget as Monster;
			for each (var tow:Tower in monster.attackingTowers) {
				tow.removeMonster(monster);
			}
			monster.removeTowers();
			for each (var tower:Tower in GO.wayCover[monster.getWayPosition() + 1]) {
				tower.addMonster(monster);
				monster.addTower(tower);
			}
			
		}
	}

}