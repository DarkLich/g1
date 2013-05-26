package  
{
	/**
	 * ...
	 * @author DarkLich
	 */
	public class ConfigXML 
	{
		private var _xml:XML
		
		public function ConfigXML() 
		{
			_xml = <data>
							<images>
								<tower>
										<name>Tower1</name>
										<src>images/towers/1.png</src>
								</tower>
								<tower>
										<name>Tower2</name>
										<src>images/towers/2.png</src>
								</tower>
								<tower>
										<name>Tower3</name>
										<src>images/towers/3.png</src>
								</tower>
								<tower>
										<name>Tower4</name>
										<src>images/towers/4.png</src>
								</tower>
								<terrain>
										<name>Grass</name>
										<src>images/terra/grass_full.png</src>
								</terrain>
								<terrain>
										<name>Road</name>
										<src>images/terra/road.jpg</src>
								</terrain>
								<terrain>
										<name>Terra</name>
										<src>images/terra/terra.jpg</src>
								</terrain>
								<terrain>
										<name>Water</name>
										<src>images/terra/water.jpg</src>
								</terrain>
								<terrain>
										<name>None</name>
										<src>images/terra/none.jpg</src>
								</terrain>
								<monster>
										<name>Mob1</name>
										<src>images/mob1_front.png</src>
								</monster>
								<dead_monster>
										<name>deadMob1</name>
										<src>images/deadmob.png</src>
								</dead_monster>
							</images>
						</data>
		}
		
		public function get xml():XML {
			return _xml;
		}
		
	}

}