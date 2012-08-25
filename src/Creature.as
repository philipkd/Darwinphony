package
{
	import flash.ui.Mouse;
	
	import flashx.textLayout.operations.CreateDivOperation;
	
	import net.flashpunk.*;
	import net.flashpunk.Entity;
	import net.flashpunk.Graphic;
	import net.flashpunk.graphics.Image;
	import net.flashpunk.masks.Pixelmask;
	import net.flashpunk.utils.*;
	
	public class Creature extends Entity
	{
		[Embed(source = 'assets/creature-1.png')] private static const CREATURE_1:Class;
		
		private static const spm:Number = 4; // seconds per measure;
		private static const maxv:Number = 300; // max pixels per second;
		private static const maxa:Number = maxv; // max acceleration (i.e. one second to reach maximum velocity)
		
		private var ax:Array;
		private var ay:Array;
		private var vx:Number = 0;
		private var vy:Number = 0;
		
		private var timer:Number = 0;
				
		private static var player:Creature;
		
		
		public function Creature(x:Number=0, y:Number=0, graphic:Graphic=null, mask:Mask=null)
		{
			
			ax = new Array(spm); 
			ay = new Array(spm);
			for (var i:int = 0; i < spm; i++) {
				ax[i] = Math.random() * maxa * 2 - maxa;
				ay[i] = Math.random() * maxa * 2 - maxa;
			}
						
			var img:Image = new Image(CREATURE_1);
			
			graphic = img;
			mask = new Pixelmask(CREATURE_1, -img.width / 2.0, -img.height / 2.0); 
			
			img.centerOO();
			
			player = this;
			type = 'creature';
			
			super(x, y, graphic, mask);			
		}
		
		public override function update():void {
						
			var cx:Number = x;
			var cy:Number = y;
			
			timer += FP.elapsed;			
			if (timer > spm)
				timer -= spm;
			
			
			for (var i:int = 0; i < spm; i++) {
				if (timer > i && timer < (i + 1)) {
					vx += ax[i] * FP.elapsed;
					vy += ay[i] * FP.elapsed;
				}
			}

			if (vx > maxv)
				vx = maxv;
			else if (vx < -maxv)
				vx = -maxv;
			
			if (vy > maxv)
				vy = maxv;
			else if (vy < -maxv)
				vy = -maxv;
			
			cx += vx * FP.elapsed;
			cy += vy * FP.elapsed;
			
			
			// reflect over edges
			
			if (cx < 0) {
				cx *= -1;
				vx *= -1;
			} else if (cx > FP.screen.width) {
				cx = FP.screen.width - (cx - FP.screen.width);
				vx *= -1;
			}
			
			if (cy < 0) {
				cy *= -1;
				vy *= -1;
			} else if (cy > FP.screen.height) {
				cy = FP.screen.height - (cy - FP.screen.height);
				vy *= -1;
			}
			
			x = cx;
			y = cy;
		}
	}
}