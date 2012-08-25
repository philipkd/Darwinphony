package
{
	import flash.display.Bitmap;
	
	import net.flashpunk.*;
	import net.flashpunk.graphics.Image;
	
	public class MyWorld extends World
	{
		
		[Embed(source = 'assets/map-shore.png')] private static const MAP:Class;
		
		public static var current:MyWorld;
		
		public function MyWorld()
		{
			super();
			current = this;
		}
		
		public function addCreature():void {
			add(new Creature((FP.screen.width - 50) * Math.random() + 25, (FP.screen.height - 50) * Math.random() + 25)); 
						
		}
		
		public override function begin():void {
			add(new Entity(0,0,new Image(MAP)));
						
			var darwin:Darwin = new Darwin();
			darwin.x = darwin.halfWidth;
			darwin.y = FP.screen.height - darwin.halfHeight;
			add(darwin); 
			
			super.begin();
		}
	}
}