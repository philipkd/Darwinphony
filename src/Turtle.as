package
{
	import flash.display.BlendMode;
	
	import net.flashpunk.*;
	import net.flashpunk.Entity;
	import net.flashpunk.graphics.Image;
	import net.flashpunk.masks.Pixelmask;
	import net.flashpunk.utils.*;
	
	public class Turtle extends Entity
	{

		public static const TURTLE_TYPE_LAND:int = 1;
		public static const TURTLE_TYPE_CURSOR:int = 2;
		public static const TURTLE_TYPE_MENU:int = 3;

		public var turtle_type:int;		
		
		[Embed(source = 'assets/cursor-turtle.png')] private const TURTLE:Class;

		private var timer:Number = 0;
		private var img:Image;
			
		public function Turtle(turtle_type_value:int)
		{			
			turtle_type = turtle_type_value;
			
			if (turtle_type == TURTLE_TYPE_LAND)
				layer = MyWorld.LAYER_TURTLES;
			
			
			img = new Image(TURTLE);
			img.x = -img.width * .5;
			img.y = -img.height * .5;
			
			if (turtle_type == TURTLE_TYPE_CURSOR) {
				type = 'cursor';
				img.alpha = .5;
				x = Input.mouseX;
				y = Input.mouseY;
			} else if (turtle_type == TURTLE_TYPE_LAND) {
				type = 'turtle';
				img.alpha = .5;			
			}
			
			graphic = img;
			
			mask = new Pixelmask(TURTLE, img.x, img.y);
			
			super(x, y, graphic, mask);
		}
		
		public function drop_copy():void {
			var baby:Turtle = new Turtle(TURTLE_TYPE_LAND);
			baby.x = x;
			baby.y = y;
			FP.world.add(baby);
		}
		
		public override function update():void {
			if (turtle_type != TURTLE_TYPE_MENU) {
			
				const tps:int = 8;
				const cycle:int = 2;
				
				timer += FP.elapsed;
				if (timer > cycle)
					timer -= cycle;
				
				var creatures:Array = new Array();
				collideInto('creature',x,y,creatures);
				
				if (creatures.length > 0) {
					for each (var c:Creature in creatures) {
						if (!c.muted()) {
							Tones.shared().play(c.frames.frame,int(timer * tps));
							c.mute();
						}
					}
					img.alpha = 1;
				} else {
					img.alpha = .5; 
				}
				
			}
			
			if (turtle_type == TURTLE_TYPE_MENU) {
				if (Input.check(Key.DIGIT_2)) {
					MyWorld.current.clear_cursor();
					FP.world.add(new Turtle(TURTLE_TYPE_CURSOR));
				}
				
			}
			
			if (turtle_type == TURTLE_TYPE_CURSOR) {
				
				if (Input.mousePressed) {
					drop_copy();
				}
				
				x = Input.mouseX;
				y = Input.mouseY;

			}
		}
		public function kill():void {
			FP.world.remove(this);
		}
	}
}