package
{
	import net.flashpunk.Entity;
	import net.flashpunk.*;
	import net.flashpunk.Mask;
	import net.flashpunk.graphics.Image;
	import net.flashpunk.masks.Pixelmask;
	
	public class TrapCross extends Entity
	{
		[Embed(source = 'assets/cross.png')] private static const CROSS:Class;
		
		private var cooldown_pulse:Number = -1;
		
		public function TrapCross(x:Number=0, y:Number=0, graphic:Graphic=null, mask:Mask=null)
		{
			mask = new Pixelmask(CROSS);
			graphic = new Image(CROSS);
			graphic.visible = false;
			super(x, y, graphic, mask);
		}
		
		public override function update():void {
			
			var blockCollision:Boolean = false;
			
			if (cooldown_pulse > 0) {
				if (cooldown_pulse > 3) {
					graphic.visible = true;
				} else {
					graphic.visible = false;	
					blockCollision = true;
				}
				
				cooldown_pulse -= FP.elapsed;
			}
			if (cooldown_pulse < 0)
				cooldown_pulse = -1;
			
			if (!blockCollision) {
				var e:Darwin = collide('darwin',x,y) as Darwin;
				if (e) {
					cooldown_pulse = 4;
					if (!e.showing_cane)
						e.kill();
				}
			}
		}
	}
}