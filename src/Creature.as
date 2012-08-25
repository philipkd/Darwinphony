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
				
		private static const cycle_length:Number = 8;

		public var amp_x:Number;
		public var amp_y:Number;

		private var cos_x:Boolean;
		private var cos_y:Boolean;
		private var subs_x:Number;
		private var subs_y:Number;
		
		private var timer:Number = 0;
			
		private var initial_x:Number;
		private var initial_y:Number;		
		
		private static var player:Creature;
				
		public function Creature(x:Number=0, y:Number=0, graphic:Graphic=null, mask:Mask=null)
		{
			var img:Image = new Image(CREATURE_1);
						
			initial_x = x;
			initial_y = y;
			
			amp_x = FP.screen.width * Math.random() / 2.0;
			amp_y = FP.screen.height * Math.random() / 2.0;
			
			subs_x = int(Math.random() * 5 + 1);
			subs_y = int(Math.random() * 5 + 1);
			
			
			cos_x = Math.random() < .5;
			cos_y = Math.random() < .5;
			
			graphic = img;
			mask = new Pixelmask(CREATURE_1, -img.width / 2.0, -img.height / 2.0); 
			
			img.centerOO();
			
			player = this;
			type = 'creature';
						
			graphic.visible = false;
			
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
				trace(subs_x);
			}
					
			graphic.visible = true;

			
		}
	}
}