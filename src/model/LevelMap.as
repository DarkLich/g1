package model
{
	
	import flash.errors.InvalidSWFError;
	import flash.geom.Point;
	import flash.text.TextField;
	import model.map.IMap;
	/**
	 * ...
	 * @author LoloL
	 * Генерирует карту уровня
	 * входные данные:
		 * размеры х у
		 * количество точек входа монстряшек
		 * количество конечных точек 
	 *
	 * 
	 */
	public class LevelMap implements IMap
	{
		private var _mapSize:Point;
		private var _wayVector:Vector.<String> = new Vector.<String>();
		
		public var coordX:int;
		public var coordY:int;
		
		public var countStartPoint:int;
		public var countFinalPoint:int;
		
		public var _mapArray:Array = new Array(); // двумерный массив (х у)
		public var startArr:Array = new Array(); // содержит координаты старта
		public var finishArr:Array = new Array();// содержит координаты финиша
		
		public function LevelMap(x:int, y:int, countFinal:int, countStart:int)
		//public function LevelMap()
		{
			_mapSize = new Point(x, y);
			coordX = x;
			coordY = y;
			countStartPoint = countStart;
			countFinalPoint = countFinal;
			generateStart();
			generateFinish();
			generateLevelMap();
			generanteWays();
		}
		
		public function generateStart():void {
			// генерирует массив точек старта
			// добавляет в массив карты точки старта
			
			var miniArr:Array = new Array();
			for (var i:int = 0; i < this.countStartPoint ; i++) {
				var j:int = Math.random() * coordY;
				miniArr[j] = 'S';
				this.startArr.push(j);
			}
			this._mapArray[this.coordX] = miniArr;			
		}
		
		public function generateFinish():void {
			// генерирует массив точек финиша
			// Добавляет в массив карты точки финиша
			var miniArr:Array = new Array();
			for (var i:int = 0; i < this.countFinalPoint ; i++) {
				var j:int = Math.random() * coordY;
				miniArr[j] = 'F';
				this.finishArr.push(j);
			}
			this._mapArray[0] = miniArr;
		}
		
		public function generanteWays():void {
			//прокладка путей от каждой точки старта до случайной точки финиша
			var i:int = 0;
			for (i = 0; i < this.countStartPoint; i++) {
				//собснно лыжня
				//получаем координаты случайной точки финиша
				var start:int = this.getRandomFinishPoint();
				trace(i+"-"+finiw+" "+start);
				 //определяем на каком уровне пролегает текущий путь
				var finiw:int = this.startArr[i];
				var currentPosition:int = start;
				
				// vector
				_wayVector.push("S");
				
				// рисуем на карте
				for (var z:int = 1; z < coordX; z++){
					_mapArray[z][currentPosition] = 'W';
					_wayVector.push("W");
					if (currentPosition != finiw) {
						// Определяем поворот
						var turn:int = Math.random() * 2;
						if (turn == 1) {
							var way:String;
							if (currentPosition < finiw) {
								// мы находимся снизу, поворот наверх
								currentPosition++;
								way = "R";
							} else {
								// мы находимся сверху, поворот вниз
								currentPosition--;
								way = "L";
							}
							_wayVector.push(way);
							_mapArray[z][currentPosition] = way;
						}
					}
					//_wayVector.push(_mapArray[z][currentPosition]);
				}
				// _mapArray[z][currentPosition] = 1;
				// проверяем дошли ли мы до финиша.
				checkMap(currentPosition, finiw);
			}
		}
		
		public function checkMap(curPos:int, finiw:int):void {
			if (curPos != finiw) {
				var way:String;
				if (curPos < finiw) {
					curPos++
					way = "R";
				} else {
					curPos--;
					way = "L";
				}
				var m:int = coordX - 1;
				_wayVector.push(way);
				_mapArray[coordX - 1][curPos] = way;
				trace("карта построена неверно");
				checkMap(curPos, finiw);
			}
		}
		
		public function getRandomFinishPoint():int { // возвращает координаты случайной точки финиша
			return this.finishArr[Math.floor(Math.random() * this.countFinalPoint)];
		}
		
		public function generateLevelMap():void {
			// генерируем карту ( матрица 2х2 )
			// в координате х=0 будет вертикаль конечных точек.
			// в координате this.coordX вертикаль стартовых точек.
			//this.generateStart();
			//this.generateFinish();
			
			// прокладка маршрутов от стартовых до конечных точек
			// зарисовка остальной части карты
			for (var i:int = 0; i <= this.coordX; i++) {
				
					//trace(_mapArray[i][j]);
					if (this._mapArray[i] != undefined) {
						for (var j:int = 0; j < this.coordY ; j++) {
							if (this._mapArray[i][j] != 9 && this._mapArray[i][j] != 5) {
								this._mapArray[i][j] = " ";
							}
						}
					} else {
						_mapArray[i] = [];
						for (var j:int = 0; j < this.coordY ; j++) {
							_mapArray[i][j] = " ";
						}
					}
				}
			//trace(this.coordX);
		}
		
		public function printText(text:String):TextField {
			var te:TextField = new TextField();
			te.text = text;
			return te;
		}
		
		/* INTERFACE model.Mapable */
		
		public function get mapSize():Point 
		{
			return _mapSize;
		}
		
		public function get mapArray():Array 
		{
			return _mapArray;
		}
		
		public function get wayVector():Vector.<String> 
		{
			return _wayVector;
		}
		
	}

}