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
		private var text:Text;
		
		public function Finch(finch_type_value:int)
		{
			finch_type = finch_type_value;
			
			img = new Image(FINCH);
			img.x = -18;
			img.y = -3
		
			if (finch_type == FINCH_TYPE_CURSOR) {
				mask = new Pixelmask(FINCH,img.x,img.y);
				
				img.alpha = .5;
				type = 'cursor';
				x = Input.mouseX;
				y = Input.mouseY;
				graphic = img;
			} else {
				type = 'menu'
				mask = new Hitbox(img.width,img.height,img.x,img.y);
				text = new Text('1');
				text.centerOO();
				text.y = -8;
				text.x = -5;
				text.scale = .5;
				graphic = new Graphiclist(img,text);
				
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
							Notes.shared().play_tap();
						}
					}
	
					var turtles:Array = new Array();
					collideInto('turtle',x,y,turtles);
					
					if (turtles.length > 0) {
						for each (var t:Turtle in turtles) {
							t.kill();
							Notes.shared().play_tap();
						}
					}
					img.alpha = 1;
				} else {
					img.alpha = .5;
				}
				
				x = Input.mouseX;
				y = Input.mouseY;
				
			}
			
			if (finch_type == FINCH_TYPE_INERT) {
				
				var hover:Boolean = (collidePoint(x,y,Input.mouseX, Input.mouseY));
				
				text.visible = hover;
				
				if (Input.pressed(Key.DIGIT_1) || (hover && Map.current.cursor() != this && Map.current.ready)) {
					Map.current.clear_cursor();
					FP.world.add(new Finch(FINCH_TYPE_CURSOR));
				}
					
			}
		}
	}
}