package
{
	import net.flashpunk.*;
	import net.flashpunk.graphics.*;
	import net.flashpunk.masks.*;
	import net.flashpunk.utils.*;
	
	public class Darwin extends Entity
	{
		
		[Embed(source = 'assets/darwin.png')] private static const DARWIN:Class;
		[Embed(source = 'assets/darwin-cane.png')] private static const DARWIN_CANE:Class;
		
		public static var current:Darwin;
		
		public var hover:Boolean; 
		
		private var darwin:Image = new Image(DARWIN);		
		private var darwin_cane:Image = new Image(DARWIN_CANE);

		private var text:Text;
		
		public function Darwin(x:Number=0, y:Number=0, graphic:Graphic=null, mask:Mask=null)
		{
			
			type = 'darwin';
			layer = -1;
	
			darwin.x = -darwin.width * .5;
			darwin.y = -darwin.height * .5;
			
			mask = new Hitbox(darwin.width, darwin.height, darwin.x, darwin.y);
			
			darwin_cane.x = darwin.x
			darwin_cane.y = darwin.y			

			text = new Text('Key 0');
			text.centerOO();
			text.y = darwin.y - 3;
			text.scale = .5;
				
			graphic = new Graphiclist(darwin, text);
						
			super(x, y, graphic, mask);
			
			current = this;
			
		}
		
		public override function update():void {
			
			var pps:int = 500;
			
			if (Input.mouseDown)
				graphic = new Graphiclist(darwin_cane, text);
			else
				graphic = new Graphiclist(darwin, text);		
			
			hover = collidePoint(x,y,Input.mouseX, Input.mouseY);
			
			text.visible = hover;
			
			if (hover && Input.mousePressed || Input.pressed(Key.DIGIT_0))
				FP.world = new Selector;
			
		}
		
	}
}