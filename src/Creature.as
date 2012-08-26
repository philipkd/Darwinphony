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
		private var mute_cooldown:Number = 0;		
		
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
		
		public function mute():void {
			mute_cooldown = .25;
		}
		
		public function muted():Boolean {
			return mute_cooldown > 0;
		}
		
		private function update_cooldowns():void {
			if (mute_cooldown > 0)
				mute_cooldown -= FP.elapsed;  
		}
		
		public override function update():void {
			
			update_cooldowns();
			
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
			initial_y = FP.screen.height * .5;
			
			frames.frame = Math.random() * frames.frameCount;
			
			amp_x = 0;
			amp_y = 50;

			subs_x = 1;
			subs_y = 4;
			
			cos_y = true;
			
		}
			
		public function mutate():void {
			var row:uint = frames.frame / frames.rows;
			var col:uint = frames.frame % frames.columns;
			
			if (Math.random() < .07)
				col = Math.random() * frames.columns;
			if (Math.random() < .07)
				row = Math.random() * frames.rows;

			frames.frame = row * frames.columns + col;
					
			initial_x += MyWorld.norm() * 50 - 25;

			if (initial_x < 20)
				initial_x = 20;
			else if (initial_x > FP.screen.width - 20)
				initial_x = FP.screen.width - 20;

		}
		
		public function clone():Creature {
			var baby:Creature = new Creature(false);

			baby.frames.frame = frames.frame;
			
			baby.initial_x = initial_x;
			baby.initial_y = initial_y;
			
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