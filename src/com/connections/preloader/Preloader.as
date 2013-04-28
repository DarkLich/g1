package  com.connections.preloader
{
	import com.VO.MainVO;
	import flash.display.Sprite;
	import flash.events.Event;
	
	/**
	 * ...
	 * @author ЙА
	 */
	public class Preloader extends Sprite 
	{
		private var _circle			:PreloaderImage;
		private var i				:int;
		public function Preloader() 
		{
			visible = true;
			//this.mouseChildren = false;
			//this.mouseEnabled = false;
			var background:Sprite = new Sprite();
			background.graphics.beginFill(0, 0.5);
			background.graphics.drawRect(0, 0, MainVO.stageWidth, MainVO.stageHeight);
			addChild(background);
			_circle = new PreloaderImage();
			_circle.x = MainVO.stageWidth/2;
			_circle.y = MainVO.stageHeight/2;
			this.addChild(_circle);	
			MainVO.dispatcher.addEventListener(MainVO.SHOW_PRELOADER,showPreloader);
			MainVO.dispatcher.addEventListener(MainVO.HIDE_PRELOADER,hidePreloader);
		}
		
		public function showPreloader(ev:Event):void {
			this.addEventListener(Event.ENTER_FRAME, rotate);
			this.visible = true;
		}
		
		public function hidePreloader(ev:Event):void {
			this.removeEventListener(Event.ENTER_FRAME, rotate);
			this.visible = false;
		}
		
		private function rotate(ev:Event):void {
			i+=15;
			if (i > 360) i = 0;
			if (i%45==0) _circle.rotation = i;
		}
		
	}

}