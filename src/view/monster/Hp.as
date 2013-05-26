package view.monster 
{
	import flash.display.Sprite;
	import flash.text.TextField;
	
	/**
	 * ...
	 * @author DarkLich
	 */
	public class Hp extends Sprite 
	{
		private var mWidth: int;
		private var sHp: int;
		private var tf:TextField = new TextField();
		
		public function Hp(monsterWidth:int, startHp:int) 
		{
			y = -15;
			tf.textColor = 0xFF0000;
			addChild(tf);
			tf.text = String(startHp);
			mWidth = monsterWidth;
			sHp = startHp;
			graphics.beginFill(0x00FF00, 1);
			graphics.drawRect(0, 0, mWidth, 2);
		}
		
		public function updateHp(hp:int):void {
			tf.text = String(hp);
			graphics.beginFill(0xFF0000, 1);
			graphics.drawRect(hp/sHp*mWidth, 0, mWidth-hp/sHp*mWidth, 2);
		}
		
	}

}