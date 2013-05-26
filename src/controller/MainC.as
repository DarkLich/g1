package controller 
{
	import flash.display.DisplayObjectContainer;
	import flash.events.Event;
	import flash.events.EventDispatcher;
	import flash.events.KeyboardEvent;
	import flash.events.MouseEvent;
	import flash.geom.Point;
	import go.GO;
	import go.Textures;
	import view.MainV;
	import view.menu.Menu;
	
	/**
	 * ...
	 * @author Dark Lich
	 */
	public class MainC extends EventDispatcher 
	{
		private var _main:DisplayObjectContainer;
		private var mainView:MainV = new MainV();
		private var gameHolderC:GameHolderC;
		
		public function MainC(main:DisplayObjectContainer) 
		{
			_main = main;
			
			Textures.getInstance().loadTextures(GO.configXml);
			Textures.getInstance().addEventListener(Textures.TEXTURES_LOADED, onTexturesLoaded);	
		}
		
		private function onTexturesLoaded(ev:Event):void {
			_main.addChild(mainView);	
			
			gameHolderC = new GameHolderC(mainView);	
			
			var mapC:MapC = new MapC(gameHolderC.gameHolderV);
			
			
			
			var menu:Menu = new Menu();
			var towerC:TowerC = new TowerC(gameHolderC.gameHolderV, menu.buyTowerMenu);
			var monsterC:MonsterC = new MonsterC(gameHolderC.gameHolderV);
			
			_main.addChild(menu);
		}
		
	
		
	}

}