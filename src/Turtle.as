package
{
	import flash.display.BlendMode;
	
	import net.flashpunk.*;
	import net.flashpunk.Entity;
	import net.flashpunk.graphics.Graphiclist;
	import net.flashpunk.graphics.Image;
	import net.flashpunk.graphics.Text;
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
		private var text:Text;
			
		public function Turtle(turtle_type_value:int)
		{			
			turtle_type = turtle_type_value;
			
			if (turtle_type == TURTLE_TYPE_LAND)
				layer = Map.LAYER_TURTLES;
			
			
			img = new Image(TURTLE);
			img.x = -img.width * .5;
			img.y = -img.height * .5;
			
			if (turtle_type == TURTLE_TYPE_CURSOR) {
				type = 'cursor';
				img.alpha = .5;
				x = Input.mouseX;
				y = Input.mouseY;
				graphic = img;
			} else if (turtle_type == TURTLE_TYPE_LAND) {
				type = 'turtle';
				img.alpha = .5;			
				graphic = img;
			} else {
				type = 'menu';
				text = new Text('2');
				text.centerOO();
				text.y = -13;
				text.scale = .5;				
				graphic = new Graphiclist(text, img);
			}
			
			
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
			
				const cycle:int = 2;
				
				timer += FP.elapsed;
				if (timer > cycle)
					timer -= cycle;
				
				var creatures:Array = new Array();
				collideInto('creature',x,y,creatures);
				
				if (creatures.length > 0) {
					for each (var c:Creature in creatures) {
						if (c.amp_y > 30 && !c.tone_muted()) {
							Notes.shared().play_tone(c.frames.frame);
							c.mute_tone();
						} else if (!c.harp_muted()) {
							Notes.shared().play_harp(c.frames.frame);
							c.mute_harp();
							
						}
						
					}
					img.alpha = 1;
				} else {
					img.alpha = .5; 
				}
				
			}
			
			if (turtle_type == TURTLE_TYPE_MENU) {
				var hover:Boolean = collidePoint(x,y,Input.mouseX,Input.mouseY);
				
				text.visible = hover;
				
				if (Input.pressed(Key.DIGIT_2) || (hover && Map.current.cursor() != this)) {
					Map.current.clear_cursor();
					FP.world.add(new Turtle(TURTLE_TYPE_CURSOR));
				}
				
			}
			
			if (turtle_type == TURTLE_TYPE_CURSOR) {
				
				if (Input.mousePressed && !Map.current.menuHover() && Map.current.ready) {
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