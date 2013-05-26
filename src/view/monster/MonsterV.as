package view.monster 
{
	import flash.display.Bitmap;
	import flash.display.Sprite;
	import flash.events.Event;
	import flash.text.TextField;
	import go.GO;
	import go.Textures;
	import model.monster.Monster;
	
	/**
	 * ...
	 * @author Dark Lich
	 */
	public class MonsterV extends Sprite 
	{
		private var monsterModel:Monster;
		private var hp:Hp;
		private var pic:Bitmap;
		
		public function MonsterV(monsterModel:Monster) 
		{
			visible = false;
			this.monsterModel = monsterModel;
			pic = new Bitmap(Textures.getInstance().mob);
			addChild(pic);
			x = monsterModel.position.x * GO.fieldSize.x;
			y = monsterModel.position.y * GO.fieldSize.y;
			hp = new Hp(pic.width,monsterModel.hp);
			addChild(hp);
			
			monsterModel.addEventListener(Monster.UPDATED, update);
			monsterModel.addEventListener(Monster.FINISH, finish);
			monsterModel.addEventListener(Monster.START, start);
			monsterModel.addEventListener(Monster.DIE, die);
		}
		
		private function update(ev:Event):void {
			hp.updateHp(monsterModel.hp);
			x = monsterModel.position.x * GO.fieldSize.x;
			y = monsterModel.position.y * GO.fieldSize.y;
		}
		
		private function finish(ev:Event):void {
			visible = false;
			var t:TextField = new TextField();
			t.textColor = 0x00FF00;
			t.text = "LoloL";
			addChild(t);
		}
		private function start(ev:Event):void {
			visible = true;
		}
		
		private function die(ev:Event):void {
			removeChild(hp);
			removeChild(pic);
			parent.addChildAt(this, 0);
			var picD:Bitmap = new Bitmap(Textures.getInstance().take["deadMob1"]);
			addChild(picD);
		}
	}

}