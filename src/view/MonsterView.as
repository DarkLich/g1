package view 
{
	import flash.display.Bitmap;
	import flash.display.Sprite;
	import flash.events.Event;
	import flash.text.TextField;
	import model.Monster;
	
	/**
	 * ...
	 * @author Dark Lich
	 */
	public class MonsterView extends Sprite 
	{
		private var monsterModel:Monster;
		public function MonsterView(monsterModel:Monster) 
		{
			this.monsterModel = monsterModel;
			var textures:Textures = new Textures();
			var pic:Bitmap = new textures.Mob();
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