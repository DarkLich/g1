package view 
{
	import flash.display.Bitmap;
	import flash.display.Sprite;
	import flash.events.Event;
	import flash.text.TextField;
	import go.GO;
	import go.Textures;
	import model.Monster;
	
	/**
	 * ...
	 * @author Dark Lich
	 */
	public class MonsterV extends Sprite 
	{
		private var monsterModel:Monster;
		public function MonsterV(monsterModel:Monster) 
		{
			visible = false;
			this.monsterModel = monsterModel;
			var pic:Bitmap = new Bitmap(Textures.getInstance().mob);
			addChild(pic);
			x = monsterModel.position.x * GO.fieldSize.x;
			y = monsterModel.position.y * GO.fieldSize.y;
		}
		
		public function update(ev:Event):void {
			x = monsterModel.position.x * GO.fieldSize.x;
			y = monsterModel.position.y * GO.fieldSize.y;
		}
		
		public function finish(ev:Event):void {
			visible = false;
			var t:TextField = new TextField();
			t.textColor = 0x00FF00;
			t.text = "LoloL";
			addChild(t);
		}
		public function start(ev:Event):void {
			visible = true;
		}
		
	}

}