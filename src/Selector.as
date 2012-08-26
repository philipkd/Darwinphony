package
{
	import net.flashpunk.World;
	import net.flashpunk.*;
	import net.flashpunk.graphics.*;
	import net.flashpunk.utils.*;
	
	public class Selector extends World
	{
		[Embed(source = 'assets/map-selector.png')] private static const SELECTOR:Class;
		
		public function Selector()
		{
			super();
		}
		
		public override function begin():void {
			var map:Entity = new Entity(0,0,new Image(SELECTOR));
			add(map);	
		}
		
		public override function update():void {
			
			if (Input.mousePressed) {
				if (Input.mouseX < FP.screen.width * .5) {
					if (Input.mouseY < FP.screen.height * .5)
						Darwination.current.select_shore();
					else
						Darwination.current.select_tundra();
				} else {
					if (Input.mouseY < FP.screen.height * .5)
						Darwination.current.select_forest();
					else
						Darwination.current.select_flowers();
				}
			}
			super.update();
		}
	}
}