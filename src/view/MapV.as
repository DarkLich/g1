package view 
{
	import flash.display.Bitmap;
	import flash.display.Sprite;
	import flash.text.TextField;
	import flash.text.TextFormat;
	import go.GO;
	import go.Textures;
	import model.map.IMap;
	
	/**
	 * ...
	 * @author Dark Lich
	 */
	public class MapV extends Sprite 
	{
		
		public function MapV(mapModel:IMap) 
		{
			var cou:int = 0;
			for (var i:int = 0; i < mapModel.mapSize.x; i++ ) {
				for (var j:int = 0; j < mapModel.mapSize.y; j++ ) {
					var field:Bitmap;
					var tf:TextFormat = new TextFormat();
					tf.size = 12;
					var text_f:TextField = new TextField();
					text_f.defaultTextFormat = tf;
					
					text_f.textColor = 0xFF0000;
					
					switch(String(mapModel.mapArray[j][i].kind)) {
						case "grass":
							 field = new Bitmap(Textures.getInstance().grass);
							 text_f.text = String(mapModel.mapArray[j][i].kind);// +"\n" + String(mapModel.mapArray[j][i].position);
						break;
						case "water":
								field = new Bitmap(Textures.getInstance().water);
								text_f.text = String(mapModel.mapArray[j][i].kind);// +"\n"+ String(mapModel.mapArray[j][i].position);
						break;
						case "terra":
								field = new Bitmap(Textures.getInstance().terra);
								text_f.text = String(mapModel.mapArray[j][i].kind);// +"\n"+ String(mapModel.mapArray[j][i].position);
						break;
						case "L":
						case "R":
						case "W":
						case "S":
						case "F":
							cou ++;
							field = new Bitmap(Textures.getInstance().road);
							text_f.text = String(mapModel.mapArray[j][i].kind) +"\n"+ String(mapModel.mapArray[j][i].position);
						break;	
						default:
							field = new Bitmap(Textures.getInstance().none);
						break;
					}
					//field.scaleX = field.scaleY = 2;
					field.x = i * GO.fieldSize.x * field.scaleX;
					field.y = j * GO.fieldSize.y * field.scaleX;
					addChild(field);
					text_f.x = field.x;
					text_f.y = field.y;
					//addChild(text_f);
					
				}
			}
			
		}
		
	}

}