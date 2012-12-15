package view.menu 
{
	import flash.display.Sprite;
	import flash.text.TextField;
	
	/**
	 * ...
	 * @author Dark Lich
	 */
	public class BuyTower extends Sprite 
	{
		
		public function BuyTower() 
		{
			graphics.beginFill(0x00cc00);
			graphics.drawRect(0, 0, 100, 30);
			var textF:TextField = new TextField();
			textF.text = "buy";
			textF.mouseEnabled = false;
			addChild(textF);
		}
		
	}

}