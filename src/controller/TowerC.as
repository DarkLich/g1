package controller 
{
	import flash.display.Bitmap;
	import flash.display.DisplayObjectContainer;
	import flash.events.Event;
	import flash.events.EventDispatcher;
	import flash.events.MouseEvent;
	import flash.geom.Point;
	import go.GO;
	import go.Textures;
	import model.IUpdate;
	import model.tower.Tower;
	import view.menu.buyTower.BuyTowerMenu;
	import view.TowersLayerV;
	import view.TowerV;
	
	/**
	 * ...
	 * @author Dark Lich
	 */
	public class TowerC extends EventDispatcher 
	{
		private var _conteiner:DisplayObjectContainer;
		private var movingTower:TowerV;
		private var towersLayer:TowersLayerV;
		private var towersArr:Vector.<Tower> = new Vector.<Tower>;
		
		public function TowerC(conteiner:DisplayObjectContainer, buyTowerMenu:BuyTowerMenu) 
		{
			_conteiner = conteiner;
			towersLayer = new TowersLayerV();
			_conteiner.addChild(towersLayer);
			
			for (var i:int = 0; i < GO.levelMap.wayVector.length; i++ ) {
				GO.wayCover.push(new Vector.<Tower>);
			}
			
			var towerType1:Tower = new Tower();
			towerType1.type = "Tower1";
			towerType1.active = false;
			buyTowerMenu.addTowerType(towerType1);
			
			var towerType2:Tower = new Tower();
			towerType2.type = "Tower2";
			towerType2.active = false;
			buyTowerMenu.addTowerType(towerType2);
			
			var towerType3:Tower = new Tower();
			towerType3.type = "Tower3";
			towerType3.active = false;
			buyTowerMenu.addTowerType(towerType3);
			
			var towerType4:Tower = new Tower();
			towerType4.type = "Tower4";
			towerType4.active = false;
			buyTowerMenu.addTowerType(towerType4);
			
			buyTowerMenu.addEventListener(BuyTowerMenu.TOWER_SELECTED, onBuyTowerSelected);
			
			var tower:Tower = new Tower(5, 2);
			tower.type = "Tower1";
			towersArr.push(tower);
			var towerV:TowerV = new TowerV(tower);
			updateWayCover(tower);	
			towersLayer.addChild(towerV);
			listenTowerModels(towerV);
			
			var tower2:Tower = new Tower(3, 6);
			tower2.type = "Tower2";
			towersArr.push(tower2);
			var towerV2:TowerV = new TowerV(tower2);
			updateWayCover(tower2);	
			towersLayer.addChild(towerV2);
			listenTowerModels(towerV2);
			
			
			
			
			GO.main.addEventListener(Event.ENTER_FRAME, onEnterFrame);
		}
		
		private function listenTowerModels(t:TowerV):void {
			t.towerModel.addEventListener(Tower.UPDATED, t.update);
		}
		
		private function onEnterFrame(ev:Event):void {
			for each (var tow:IUpdate in towersArr) {
				tow.update();
			}
		}
		
		private function onBuyTowerSelected(ev:Event):void {
			var buyTowerMenu:BuyTowerMenu = ev.currentTarget as BuyTowerMenu;
			towerInstalling(buyTowerMenu.selectedTower);
		}
		
		private function towerInstalling(type:String):void {
			var tower:Tower = new Tower();
			tower.active = false;
			tower.type = type;
			movingTower = new TowerV(tower);
			towersLayer.addChild(movingTower);
			onMouseMove(null);
			_conteiner.addEventListener(MouseEvent.MOUSE_MOVE, onMouseMove);
			towersLayer.addEventListener(MouseEvent.CLICK, placeTower);
		}
		
		private function onMouseMove(ev:MouseEvent):void {
			movingTower.x = Math.floor((GO.stage.mouseX - _conteiner.x) / GO.fieldSize.x) * GO.fieldSize.x;
			movingTower.y = Math.floor((GO.stage.mouseY - _conteiner.y) / GO.fieldSize.y) * GO.fieldSize.y;
		}
		
		private function placeTower(ev:MouseEvent):void {
			_conteiner.removeEventListener(MouseEvent.MOUSE_MOVE, onMouseMove);
			movingTower.activate();
			movingTower.towerModel.position = new Point(movingTower.x/GO.fieldSize.x, movingTower.y/GO.fieldSize.y);
			updateWayCover(movingTower.towerModel);
			towersArr.push(movingTower.towerModel);
			listenTowerModels(movingTower);
		}
		
		private function updateWayCover(tower:Tower):void {
			for (var i:int = 0; i < GO.levelMap.wayVector.length; i++ ) {
				for each (var fieldCover:Point in tower.relFieldCover) {			
					if (tower.position.x + fieldCover.x == GO.levelMap.wayVector[i].x && tower.position.y + fieldCover.y == GO.levelMap.wayVector[i].y) {
						GO.wayCover[i].push(tower);
					}
				}
			}
			trace(GO.wayCover);
		}
		
	}

}