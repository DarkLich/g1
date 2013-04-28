package com.connections.preloader 
{
	import flash.display.Sprite;
	
	/**
	 * ...
	 * @author ЙА
	 */
	public class PreloaderImage extends Sprite 
	{
		
		public function PreloaderImage() 
		{
			var R:int = 40;
			for (var i:int = 0; i < 8; i++) {
				alpha = (360 / 8 * i)/180*Math.PI;
				var circle:Sprite = new Sprite();
				circle.graphics.lineStyle(1, 0, 1/(i*8+1));
				circle.graphics.beginFill(0xFFFFFF, 1/(i*8+1));
				circle.graphics.drawCircle(0, 0, 10);
				circle.x = R * Math.sin(alpha);
				circle.y = R * Math.cos(alpha);
				this.addChild(circle);
			}
		}
		
	}

}