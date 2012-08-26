package
{
	import net.flashpunk.*;
	import net.flashpunk.Entity;
	import net.flashpunk.Graphic;
	import net.flashpunk.utils.*;
	
	public class Finch extends Entity
	{
		
		private var timer:Number = 0;
		private var tones:Array = new Array(16);
		
		public function Finch(x:Number=0, y:Number=0, graphic:Graphic=null, mask:Mask=null)
		{
			setHitbox(1,1);
			var i:uint;

			x = -100;
			y = -100;

			super(x, y, graphic, mask);
		}
		
		public override function update():void {
			
			const tps:int = 8;
			const cycle:int = 2;
			
			timer += FP.elapsed;
			if (timer > cycle)
				timer -= cycle;
			
			if (!Input.mouseDown) {
			
				var creatures:Array = new Array();
				collideInto('creature',x,y,creatures);

				if (creatures.length > 0) {
					for each (var c:Creature in creatures) {
						if (!c.muted()) {
							Tones.shared().play(c.frames.frame,int(timer * tps));
							c.mute();
						}
					}
				}
			}
			
			x = Input.mouseX;
			y = Input.mouseY;
		}
	}
}