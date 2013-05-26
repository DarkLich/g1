package controller 
{
		import flash.display.DisplayObjectContainer;
		import flash.events.Event;
		import flash.events.EventDispatcher;
		import flash.events.KeyboardEvent;
		import flash.events.MouseEvent;
		import go.GO;
		import view.GameHolderV;
	/**
	 * ...
	 * @author DarkLich
	 */
	public class GameHolderC extends EventDispatcher 
	{
		public var gameHolderV:GameHolderV = new GameHolderV();
		
		public function GameHolderC(container:DisplayObjectContainer) 
		{
			container.addChild(gameHolderV);
			
			GO.stage.addEventListener(Event.ENTER_FRAME, onEnterFrame);
			GO.stage.addEventListener(KeyboardEvent.KEY_DOWN, onKeyDown);
			GO.stage.addEventListener(MouseEvent.MOUSE_DOWN, onMouseDown);
			GO.stage.addEventListener(MouseEvent.MOUSE_UP, onMouseUp);
		}
		
		private function onEnterFrame(ev:Event):void {
			//if (GO.stage.mouseX > GO.stageWidth - 10) gameHolderV.x -= 5;
			//if (GO.stage.mouseX < 0 + 10) gameHolderV.x += 5;
			//if (GO.stage.mouseY > GO.stageHeight - 10) gameHolderV.y -= 5;
			//if (GO.stage.mouseY < 0 +  10) gameHolderV.y += 5;
			if (gameHolderV.x < GO.stageWidth - GO.mapSizePixels.x) gameHolderV.x = GO.stageWidth - GO.mapSizePixels.x;
			if (gameHolderV.y < GO.stageHeight - GO.mapSizePixels.y) gameHolderV.y = GO.stageHeight - GO.mapSizePixels.y;		
			if (gameHolderV.x > 0 ) gameHolderV.x = 0;
			if (gameHolderV.y > 0 ) gameHolderV.y = 0;
		}
		
		private function onKeyDown(ev:KeyboardEvent):void {
			switch (ev.keyCode) {
				case 39:
						gameHolderV.x --;
				break;
				case 37:
						gameHolderV.x ++;
				break;
				case 40:
						gameHolderV.y --;
				break;
				case 38:
						gameHolderV.y ++;
				break;
			}
		}
		
		private function onMouseDown(ev:MouseEvent):void {
			gameHolderV.startDrag();
		}
		private function onMouseUp(ev:MouseEvent):void {
			gameHolderV.stopDrag();
		}
		
		
	}

}