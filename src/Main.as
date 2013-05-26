package 
{
	import controller.MainC;
	import flash.display.Sprite;
	import flash.display.StageAlign;
	import flash.display.StageScaleMode;
	import flash.events.Event;
	import flash.geom.Point;
	import flash.text.TextField;
	import go.GO;
	import model.map.Map;
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
			stage.scaleMode = StageScaleMode.NO_SCALE;
			stage.align = StageAlign.TOP_LEFT;
			removeEventListener(Event.ADDED_TO_STAGE, init);
			// entry point
			var configXml:ConfigXML = new ConfigXML();
			GO.configXml = configXml.xml;
			GO.stage = stage;
			GO.stageWidth = stage.stageWidth;
			GO.stageHeight = stage.stageHeight;
			GO.main = this;
			GO.fieldSize = new Point(64, 64);
			GO.mapSizeFields = new Point(20, 20);
			GO.mapSizePixels = new Point(GO.mapSizeFields.x * GO.fieldSize.x, GO.mapSizeFields.y * GO.fieldSize.y);
			var mainController:MainC = new MainC(this);			
		}
		
	}
	
}