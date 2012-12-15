package view 
{
	import flash.display.Bitmap;
	import flash.display.Sprite;
	import flash.events.Event;
	import flash.text.TextField;
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
			this.monsterModel = monsterModel;
			var pic:Bitmap = new Textures.Mob();
			addChild(pic);
			x = monsterModel.position.x * 64;
			y = monsterModel.position.y * 64;
		}
		
		public function update(ev:Event):void {
			x = monsterModel.position.x * 64;
			y = monsterModel.position.y * 64;
		}
		
		public function finish(ev:Event):void {
			var t:TextField = new TextField();
			t.textColor = 0x00FF00;
			t.text = "LoloL";
			addChild(t);
		}
		
	}

}