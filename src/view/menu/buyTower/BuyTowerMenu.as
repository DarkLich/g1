package view.menu.buyTower 
{
	import flash.display.Sprite;
	import flash.events.Event;
	import flash.events.MouseEvent;
	import flash.text.TextField;
	import go.GO;
	import model.tower.Tower;
	import view.TowerV;
	
	/**
	 * ...
	 * @author Dark Lich
	 */
	public class BuyTowerMenu extends Sprite 
	{
		private var numTowers:int = 0;
		
		public var selectedTower:String;
		
		public static const TOWER_SELECTED:String = "tower_selected";
		
		public function BuyTowerMenu() 
		{
			//var textF:TextField = new TextField();
			//textF.text = "buy";
			//textF.mouseEnabled = false;
			//addChild(textF);
		}
		
		public function addTowerType(towerModel:Tower):void {
			var towerIcon:TowerV = new TowerV(towerModel);
			addChild(towerIcon);			
			towerIcon.x = towerIcon.width * numTowers;
			numTowers++;
			towerIcon.addEventListener(MouseEvent.CLICK, onMouseClick);	
			updateMenuSize();
		}
		
		private function updateMenuSize():void {
			graphics.beginFill(0x00cc00);
			graphics.drawRect(0, 0, width, height);
		}
		
		private function onMouseClick(ev:MouseEvent):void {
			selectedTower = ev.currentTarget.towerModel.type;
			//GO.towerDragging = true;
			dispatchEvent(new Event(TOWER_SELECTED));
		}
		
	}

}