package
{
	import flash.ui.Mouse;
	
	import flashx.textLayout.operations.CreateDivOperation;
	
	import net.flashpunk.*;
	import net.flashpunk.Entity;
	import net.flashpunk.Graphic;
	import net.flashpunk.graphics.Image;
	import net.flashpunk.graphics.Spritemap;
	import net.flashpunk.masks.Hitbox;
	import net.flashpunk.masks.Pixelmask;
	import net.flashpunk.utils.*;
	
	public class Creature extends Entity
	{

		public var frames:Spritemap = new Spritemap(CREATURES,12,12);		
		
		public var initial_x:Number;
		public var initial_y:Number;		
		
		public var amp_x:Number;
		public var amp_y:Number;
		
		public var subs_x:Number;
		public var subs_y:Number;

		public var cos_x:Boolean;
		public var cos_y:Boolean;
		
		
		[Embed(source = 'assets/creatures.png')] private static const CREATURES:Class;
		private static const cycle_length:Number = 8;

		private var timer:Number = 0;
				
		
		public function Creature(seed:Boolean)
		{
			graphic = frames;
			frames.centerOO();
			mask = new Hitbox(12,12,-6,-6); 
			type = 'creature';
			graphic.visible = false;

			if (seed)
				this.seed();
			
			super(x, y, graphic, mask);			
		}
		
		public override function update():void {
									
			timer += FP.elapsed;			
			if (timer > cycle_length)
				timer -= cycle_length;

			if (cos_x)
				x = amp_x * Math.cos(2 * Math.PI * (timer / cycle_length) * subs_x) + initial_x; 
			else
				x = amp_x * Math.sin(2 * Math.PI * (timer / cycle_length) * subs_x) + initial_x;
			
			if (cos_y)
				y = amp_y * Math.cos(2 * Math.PI * (timer / cycle_length) * subs_y) + initial_y; 
			else
				y = amp_y * Math.sin(2 * Math.PI * (timer / cycle_length) * subs_y) + initial_y;


			if (collidePoint(x,y,Input.mouseX, Input.mouseY)) {
				
				if (Input.mouseDown) {
					FP.world.remove(this);
				}
				
				
			}
					
			graphic.visible = true;

		}
		
		public function seed():void {
			
			initial_x = FP.screen.width * .25 + Math.random() * FP.screen.width * .5;
			initial_y = FP.screen.height * .25 + Math.random() * FP.screen.height * .5;
			
			frames.frame = Math.random() * frames.frameCount;
			
			amp_x = Math.min(initial_x, FP.screen.width - initial_x) * Math.random() * .5;
			amp_y = Math.min(initial_y, FP.screen.height - initial_y)  * Math.random() * .5;

			subs_x = int(Math.random() * 5 + 1);
			subs_y = int(Math.random() * 5 + 1);
			
			cos_x = Math.random() < .5;
			cos_y = Math.random() < .5;
			
			amp_y = 50;
			amp_x = 0;
			
		}
	
		
		public function mutate():void {
			var row:uint = frames.frame / frames.rows;
			var col:uint = frames.frame % frames.columns;
			
			if (Math.random() < .05)
				col = Math.random() * frames.columns;
			if (Math.random() < .05)
				row = Math.random() * frames.rows;

			frames.frame = row * frames.columns + col;
					
			initial_x += MyWorld.norm() * 36 - 18;
			initial_y += MyWorld.norm() * 36 - 18;
			
			if (initial_x < 20)
				initial_x = 20;
			else if (initial_x > FP.screen.width - 20)
				initial_x = FP.screen.width - 20;
			
			if (initial_y < 16)
				initial_y = 16;
			else if (initial_y > FP.screen.height - 16)
				initial_y = FP.screen.height - 16;
			

			
			amp_y += MyWorld.norm() * 48 - 24;
			
			if (amp_y >= FP.screen.height * .5)
				amp_y = FP.screen.height * .5;
			else if (amp_y < 0)
				amp_y = 0;
			

			if (subs_x == 4) {
				subs_x += -1 * int(Math.random() * 3);
			} else {
				subs_x += int(Math.random() * 3) - 1;
				if (subs_x > 4)
					subs_x = 4;
				else if (subs_x < 0)
					subs_x = 0;
			}
			
			if (subs_y == 4) {
				subs_y += -1 * int(Math.random() * 3);
			} else {
				subs_y += int(Math.random() * 3) - 1;
				if (subs_y > 4)
					subs_y = 4;
				else if (subs_y < 0)
					subs_y = 0;
			}
			
			if (Math.random() < .1)
				cos_x = !cos_x;
			if (Math.random() < .1)
				cos_y = !cos_y;
		}
		
		public function clone():Creature {
			var baby:Creature = new Creature(false);

			baby.frames.frame = frames.frame;
			
			baby.initial_x = x;
			baby.initial_y = y;
			
			baby.amp_x = amp_x;
			baby.amp_y = amp_y;
			
			baby.subs_x = subs_x;
			baby.subs_y = subs_y;
			
			baby.cos_x = cos_x;
			baby.cos_y = cos_y;
		
			return baby;
		}
		
		public function divide():void {
			var baby:Creature = this.clone();
			MyWorld.current.add(baby);
			
			baby.mutate();
		}
	}
}