package
{
	import net.flashpunk.*;
	import net.flashpunk.Entity;
	import net.flashpunk.graphics.*;
	import net.flashpunk.graphics.Image;
	import net.flashpunk.masks.Hitbox;
	import net.flashpunk.masks.Pixelmask;
	import net.flashpunk.utils.*;
	
	public class Finch extends Entity
	{
		
		
		[Embed(source = 'assets/cursor-finch.png')] private static const FINCH:Class; 
		
		public static const FINCH_TYPE_INERT:int = 0;
		public static const FINCH_TYPE_CURSOR:int = 1;
		
		public var finch_type:int;
		
		private var img:Image;
		
		public function Finch(finch_type_value:int)
		{
			finch_type = finch_type_value;
			
			img = new Image(FINCH);
			graphic = img;
			img.x = -18;
			img.y = -3
		
			if (finch_type == FINCH_TYPE_CURSOR) {
				mask = new Hitbox(6,4,-3,-2);
				img.alpha = .5;
				type = 'cursor';
				x = Input.mouseX;
				y = Input.mouseY;
			} else {
				mask = new Hitbox(img.width,img.height,img.x,img.y);
			}
			
			super(x, y, graphic, mask);
		}
		
		public override function update():void {

			if (finch_type == FINCH_TYPE_CURSOR) {
			
				if (Input.mouseDown) {
					var creatures:Array = new Array();
					collideInto('creature',x,y,creatures);
					
					if (creatures.length > 0) {
						for each (var c:Creature in creatures) {
							c.kill();
						}
					}
	
					var turtles:Array = new Array();
					collideInto('turtle',x,y,turtles);
					
					if (turtles.length > 0)
						for each (var t:Turtle in turtles)
							t.kill();
					img.alpha = 1;
				} else {
					img.alpha = .5;
				}
				
				x = Input.mouseX;
				y = Input.mouseY;
				
			}
			
			if (finch_type == FINCH_TYPE_INERT) {
				if (Input.check(Key.DIGIT_1)) {
					MyWorld.current.clear_cursor();
					FP.world.add(new Finch(FINCH_TYPE_CURSOR));
				}
					
			}
		}
	}
}