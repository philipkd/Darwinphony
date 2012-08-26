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
	
	public class Creature extends Entity {

		public var frames:Spritemap;		
		
		public var anchor_x:Number;
		public var anchor_y:Number;		
		
		public var amp_x:Number;
		public var amp_y:Number;
		
		public var subs_x:Number;
		public var subs_y:Number;

		public var cos_x:Boolean;
		public var cos_y:Boolean;
		
		private static const cycle_length:Number = 8;

		private var timer:Number = 0;
		private var mute_cooldown:Number = 0;
		
		private var _sprites:*;
		
		public function Creature(sprites:*, seed:Boolean)
		{
			_sprites = sprites;
			frames = new Spritemap(sprites,12,12);
			graphic = frames;
			frames.centerOO();
			mask = new Hitbox(12,12,-6,-6); 
			type = 'creature';
			layer = Map.LAYER_KRILL;
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
				x = amp_x * Math.cos(2 * Math.PI * (timer / cycle_length) * subs_x) + anchor_x; 
			else
				x = amp_x * Math.sin(2 * Math.PI * (timer / cycle_length) * subs_x) + anchor_x;
			
			if (cos_y)
				y = amp_y * Math.cos(2 * Math.PI * (timer / cycle_length) * subs_y) + anchor_y; 
			else
				y = amp_y * Math.sin(2 * Math.PI * (timer / cycle_length) * subs_y) + anchor_y;
			
			graphic.visible = true;

		}

		
		public function seed():void {
			
			anchor_x = FP.screen.width * .25 + Math.random() * FP.screen.width * .5;
			anchor_y = FP.screen.height * .5;
			
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
					
			anchor_x += Map.norm() * 20 - 10;

			if (anchor_x < 20)
				anchor_x = 20;
			else if (anchor_x > FP.screen.width - 20)
				anchor_x = FP.screen.width - 20;

		}
		
		public function clone():Creature {
			var baby:Creature = new Creature(_sprites, false);

			baby.frames.frame = frames.frame;
			
			baby.anchor_x = anchor_x;
			baby.anchor_y = anchor_y;
			
			baby.amp_x = amp_x;
			baby.amp_y = amp_y;
			
			baby.subs_x = subs_x;
			baby.subs_y = subs_y;
			
			baby.cos_x = cos_x;
			baby.cos_y = cos_y;
		
			return baby;
		}
		
		public function spawn():Creature {
			var baby:Creature = this.clone();
			Map.current.add(baby);
			
			baby.mutate();
			
			return baby;
		}
		
		public function setTimerToY(birth_y:Number):void {
			
			if (birth_y > (anchor_y + amp_y))
				birth_y = amp_y;
			if (birth_y < (anchor_y - amp_y))
				birth_y = anchor_y - amp_y;
			
			var rads:Number = Math.acos((birth_y - anchor_y) / amp_y);
			
			trace(rads, (rads / Math.PI), (rads / Math.PI) * (cycle_length * .5));
						
			timer = (rads / Math.PI) * (cycle_length * .5 / Number(subs_y)); 
		}
		
		public function kill():void {
			FP.world.remove(this);
		}
	}
}