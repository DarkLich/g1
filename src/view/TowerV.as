package view
{
	import flash.display.Bitmap;
	import flash.display.Sprite;
	import flash.events.Event;
	import flash.geom.Point;
	import go.GO;
	import go.Textures;
	import model.tower.Tower;
	/**
	 * ...
	 * @author Dark Lich
	 */
	public class TowerV extends Sprite
	{		
		public var towerModel:Tower;
		
		public function TowerV(tower:Tower) 
		{
			towerModel = tower;
			
			towerModel.addEventListener(Tower.FIRE, fire);
			if (tower.type == "Tower1") addChild(new Bitmap(Textures.getInstance().tower1));
			if (tower.type == "Tower2") addChild(new Bitmap(Textures.getInstance().tower2));
			if (tower.type == "Tower3") addChild(new Bitmap(Textures.getInstance().tower3));
			if (tower.type == "Tower4") addChild(new Bitmap(Textures.getInstance().tower4));
			x = tower.position.x * GO.fieldSize.x;
			y = tower.position.y * GO.fieldSize.y;
			var col:int;
			if (tower.active) {
				col = 0x00ff00;
			}else {
				col = 0xff0000;
			}
			graphics.beginFill(col, 0.5);
			for (var i:int = 0; i < towerModel.relFieldCover.length;i++){
				graphics.drawRect(towerModel.relFieldCover[i].x * GO.fieldSize.x, towerModel.relFieldCover[i].y * GO.fieldSize.y, GO.fieldSize.x,GO.fieldSize.y);
			}
		}
		
		public function update(ev:Event):void {
			//alpha = Math.random();
		}
		public function activate():void {
			var col:int = 0x00ff00;
			graphics.clear();
			graphics.beginFill(col, 0.5);
			for (var i:int = 0; i < towerModel.relFieldCover.length;i++){
				graphics.drawRect(towerModel.relFieldCover[i].x * GO.fieldSize.x, towerModel.relFieldCover[i].y * GO.fieldSize.y, GO.fieldSize.x,GO.fieldSize.y);
			}
		}
		
		private function fire(ev:Event):void {
			alpha = Math.random();
		}
		
	}

}