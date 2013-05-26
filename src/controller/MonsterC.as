package controller 
{
	import flash.display.DisplayObjectContainer;
	import flash.events.Event;
	import flash.events.EventDispatcher;
	import flash.geom.Point;
	import go.GO;
	import model.IUpdate;
	import model.monster.Monster;
	import model.tower.Tower;
	import view.MonsterLayerV;
	import view.monster.MonsterV;
	
	/**
	 * ...
	 * @author Dark Lich
	 */
	public class MonsterC extends EventDispatcher 
	{
		private var monstersArr:Vector.<Monster> = new Vector.<Monster>;
		private var deadMonsters:Vector.<Monster> = new Vector.<Monster>;
		private var z:int = 0;
		
		public function MonsterC(conteiner:DisplayObjectContainer) {
			var monsterLayerV:MonsterLayerV = new MonsterLayerV();
			conteiner.addChild(monsterLayerV);
			for (var i:int = 0 ; i < 100; i++) {
					var monster:Monster = new Monster(GO.levelMap.wayVector, i * Math.random() * 150);
					monstersArr.push(monster);
					var monsterV:MonsterV = new MonsterV(monster);
					monsterLayerV.addChild(monsterV);
					addListeners(monster,monsterV);
			}
			GO.main.addEventListener(Event.ENTER_FRAME, onEnterFrame);
		}
		
		private function addListeners(monster:Monster, monsterV:MonsterV):void {
			monster.addEventListener(Monster.FINISH, finish);
			monster.addEventListener(Monster.POSITION_CHANGED, onPositionChanged);
			monster.addEventListener(Monster.DIE, onDie);
		}
		
		private function removeListeners(monster:Monster):void {
			monster.removeEventListener(Monster.FINISH, finish);
			monster.removeEventListener(Monster.POSITION_CHANGED, onPositionChanged);
			monster.removeEventListener(Monster.DIE, onDie);
		}
		
		private function onEnterFrame(ev:Event):void {
			z++;
			if (z>1){
					for each (var mon:IUpdate in monstersArr) {
						mon.update();
					}
					z = 0;
			}
		}
		
		private function finish(ev:Event):void {	
			monstersArr.splice(monstersArr.indexOf(ev.currentTarget), 1);
		}
		
		private function onDie(ev:Event):void {
			var monster:Monster = ev.currentTarget as Monster;
			var monsterIndex:int = monstersArr.indexOf(monster);
			for each (var aTow:Tower in monster.attackingTowers) {
				aTow.removeMonster(monster);
				monster.removeTowers();
			}
			removeListeners(monster);
			deadMonsters.push(monster);
			monstersArr.splice(monstersArr.indexOf(monster), 1);
		}
		
		private function onPositionChanged(ev:Event):void {
			var monster:Monster = ev.currentTarget as Monster;
			if (monster.getWayPosition() > 0) {
				for each (var aTow:Tower in monster.attackingTowers) {
					if (GO.wayCover[monster.getWayPosition()].indexOf(aTow) < 0) {
						aTow.removeMonster(monster);
						monster.removeTower(aTow);
					}
				}
			}
			if (monster.getWayPosition()+1 < monster.way.length) {
				for each (var tower:Tower in GO.wayCover[monster.getWayPosition() + 1]) {
					tower.addMonster(monster);
					monster.addTower(tower);
				}  
			} else {
				for each (var tow:Tower in GO.wayCover[monster.getWayPosition()]) {
					tow.removeMonster(monster);
				}
				monster.removeTowers();
			}
		}
	}

}