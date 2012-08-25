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
		
		
		public override function begin():void {
			add(new Entity(0,0,new Image(MAP)));
						
			var darwin:Darwin = new Darwin();
			darwin.x = darwin.halfWidth;
			darwin.y = FP.screen.height - darwin.halfHeight;
			add(darwin); 
			add(new Creature(true)); 
			add(new Finch);
			super.begin();
		}
		
		public function reset():void {
			var creatures:Array = new Array();
			FP.world.getType('creature',creatures);
			for each (var creature:Creature in creatures)
				remove(creature);
			
			add(new Creature(true)); 			
		}
		
		public static function norm():Number {
			return (Math.random() + Math.random() + Math.random() + Math.random()) / 4.0
		}
	}
}