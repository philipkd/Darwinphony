package
{	
	
	import net.flashpunk.*;
	import net.flashpunk.graphics.*;
	import net.flashpunk.utils.*;
	import net.flashpunk.masks.*;

	
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
		
		public var mom_cd:Number = 0;
		public var dad_cd:Number = 0;
		public var kid_cd:Number = 0;
		
		[Embed(source = 'assets/circles.png')] private static const CIRCLES:Class;
		private var circles:Spritemap = new Spritemap(CIRCLES,16,16);
		private static const cycle_length:Number = 8;

		private var timer:Number = 0;
		private var mute_tone_cd:Number = 0;		
		private var mute_harp_cd:Number = 0;		
		private var _sprites:*;
	
		
		public function Creature(sprites:*, seed:Boolean)
		{
			_sprites = sprites;
			frames = new Spritemap(sprites,12,12);
			graphic = new Graphiclist(frames,circles);
			circles.visible = false;
			frames.centerOO();
			
			circles.x = -frames.width * .5 - 2;
			circles.y = -frames.height * .5 - 2;
			
			mask = new Hitbox(12,12,-6,-6);
			
			type = 'creature';
			layer = Map.LAYER_KRILL;
			graphic.visible = false;

			if (seed)
				this.seed();
			
			super(x, y, graphic, mask);			
		}
		
		public function mute_tone():void {
			mute_tone_cd = .25;
		}
		
		public function mute_harp():void {
			mute_harp_cd = .25;
		}

		
		public function tone_muted():Boolean {
			return mute_tone_cd > 0;
		}

		public function harp_muted():Boolean {
			return mute_harp_cd > 0;
		}
		
		private function update_cooldowns():void {
			if (mute_tone_cd > 0)
				mute_tone_cd -= FP.elapsed;
			if (mute_harp_cd > 0)
				mute_harp_cd -= FP.elapsed;
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
			if (Math.random() < .5)
				amp_y = 50;
			else
				amp_y = 25;

			subs_x = 1;
			subs_y = 4;
			
			cos_y = true;
			
		}
			
		
		public override function render():void {
			if (kid_cd > 0) {
				kid_cd -= FP.elapsed;
				circles.frame = 0;
			}
			if (dad_cd > 0) {
				dad_cd -= FP.elapsed;
				circles.frame = 2;
			}
			if (mom_cd > 0) {
				mom_cd -= FP.elapsed;
				circles.frame = 1;
			}
			
			circles.visible = (dad_cd > 0) || (mom_cd > 0) || (kid_cd > 0);
			
			super.render();
		}
		
		public function mutate():void {
			var row:uint = frames.frame / frames.rows;
			var col:uint = frames.frame % frames.columns;
			
			if (Math.random() < .07)
				col = Math.random() * frames.columns;
			if (Math.random() < .07)
				row = Math.random() * frames.rows;
			
			if (Math.random() < .07) {
				if (amp_y == 50)
					amp_y = 30;
				else
					amp_y = 50;
			}
				

			frames.frame = row * frames.columns + col;
					
			anchor_x += Map.norm() * 40 - 20;

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
		
		public function mate(mom:Creature):Creature {
			dad_cd = .5;
			mom.mom_cd = .5;

			var baby:Creature;
			baby = this.clone();

			if (Math.random() < .5)
				baby.frames.frame = mom.frames.frame;
			if (Math.random() < .5)
				baby.anchor_x = mom.anchor_x;
			if (Math.random() < .5)
				baby.amp_y = mom.amp_y;
						
			Map.current.add(baby);
			
			baby.mutate();
			baby.kid_cd = .5;
			baby.setTimerToY(Input.mouseY)			
			baby.update();
			
			return baby;
		}
		
		public function setTimerToY(birth_y:Number):void {
			
			if (birth_y > (anchor_y + amp_y))
				birth_y = amp_y;
			if (birth_y < (anchor_y - amp_y))
				birth_y = anchor_y - amp_y;
			
			var rads:Number = Math.acos((birth_y - anchor_y) / amp_y);
						
			timer = (rads / Math.PI) * (cycle_length * .5 / Number(subs_y)); 
		}
		
		public function kill():void {
			FP.world.remove(this);
		}
	}
}