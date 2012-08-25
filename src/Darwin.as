package
{
	import net.flashpunk.*;
	import net.flashpunk.graphics.*;
	import net.flashpunk.masks.Pixelmask;
	import net.flashpunk.utils.*;
	
	public class Darwin extends Entity
	{
		
		[Embed(source = 'assets/darwin.png')] private static const DARWIN:Class;
		[Embed(source = 'assets/darwin-cane.png')] private static const DARWIN_CANE:Class;
		
		private var darwin:Image = new Image(DARWIN);
		private var darwin_mask:Pixelmask = new Pixelmask(DARWIN);
		
		private var darwin_cane:Image = new Image(DARWIN_CANE);
		private var darwin_cane_mask:Pixelmask = new Pixelmask(DARWIN_CANE);
				
		public function Darwin(x:Number=0, y:Number=0, graphic:Graphic=null, mask:Mask=null)
		{
			
			type = 'darwin';
			layer = -1;
	
			darwin.centerOO();
			
			darwin_mask.x = -darwin.originX
			darwin_mask.y = -darwin.originY;

			darwin_cane.originX = darwin.originX;
			darwin_cane.originY = darwin.originY;			
			
			darwin_cane_mask.x = -darwin.originX;
			darwin_cane_mask.y = -darwin.originY;
			
			graphic = darwin;
			mask = darwin_mask;
			
			super(x, y, graphic, mask);          
		}
		
		public override function update():void {
			
			var pps:int = 500;
			
			if (Input.check(Key.SPACE)) {
				graphic = darwin_cane;
				mask = darwin_cane_mask;
								
			} else {
				graphic = darwin;		
				mask = darwin_mask;
			}
				
			if (Input.pressed(Key.SPACE)) {
				var creatures:Array = new Array();
				FP.world.getType('creature',creatures);
				var i:int = Math.random() * creatures.length;
				if (creatures.length > 0) {
					var creature:Creature = creatures[i];
					creature.divide();
				} else {
					MyWorld.current.reset();
				}
				
				
			}
			
			if (Input.pressed(Key.R)) {
				MyWorld.current.reset();
			}
		}
		
	}
}