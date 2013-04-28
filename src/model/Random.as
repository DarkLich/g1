package model 
{
	/**
	 * ...
	 * @author LoloL
	 */
	public class Random
	{
		
		public function Random() 
		{
			
		}
		
		public static function random(x:int, y:int):int {
			var a:int = (x < y)?x:y;
			return Math.random() * Math.abs(y - x) + a;
		}
		
	}

}