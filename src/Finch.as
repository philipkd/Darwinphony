package
{
	import net.flashpunk.*;
	import net.flashpunk.Entity;
	import net.flashpunk.Graphic;
	import net.flashpunk.utils.*;
	
	public class Finch extends Entity
	{
		[Embed(source = 'assets/tone1.mp3')] private const TONE_1:Class;
		private const tone1:Sfx = new Sfx(TONE_1);
		
		public function Finch(x:Number=0, y:Number=0, graphic:Graphic=null, mask:Mask=null)
		{
			setHitbox(1,1);
			super(x, y, graphic, mask);
		}
		
		public override function update():void {
			var c:Creature = collide('creature',x,y) as Creature;
			if (c)
				tone1.play();
			
			x = Input.mouseX;
			y = Input.mouseY;
		}
	}
}