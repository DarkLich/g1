package 
{
	import controller.MainController;
	import flash.display.Sprite;
	import flash.events.Event;
	import flash.text.TextField;
	import go.GO;
	import model.map.MapGenerator;
	import model.map.MapSector;
	
	/**
	 * ...
	 * @author Dark Lich
	 */
	public class Main extends Sprite 
	{
		
		public function Main():void 
		{
			if (stage) init();
			else addEventListener(Event.ADDED_TO_STAGE, init);
		}
		
		private function init(e:Event = null):void 
		{
			removeEventListener(Event.ADDED_TO_STAGE, init);
			// entry point
			GO.stageWidth = stage.stageWidth;
			GO.stageHeight = stage.stageHeight;
			GO.main = this;
			var mainController:MainController = new MainController(this);
			var mg:MapGenerator = new MapGenerator(10, 10);
		}
		
	}
	
}