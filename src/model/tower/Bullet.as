package model.tower
{
	/**
	 * ...
	 * @author LoloL
	 */
	public class Bullet 
	{
		public var speed:int; // скорость полёта
		public var minDmg:int;
		public var maxDmg:int;
		public var ability:Array = new Array(); // различные характеристики ( на будущее )
		public var image:int; // картинка пульки
		public var radius:int; // область поражения
		public var lifeTime:int; // время жизни

		
		public function Bullet(speed:int, minDmg:int, maxDmg:int, radius:int) 
		{
			this.speed = speed;
			this.minDmg = minDmg;
			this.maxDmg = maxDmg;
			this.radius = radius;
		}
		
		public function getSpeed() {
			return speed;
		}
		
		public function getRadius() {
			return radius;
		}
		
		public function getDamage() {
			return Math.floor(Math.random() * (maxDmg - minDmg) + minDmg);
		}
		
	}

}