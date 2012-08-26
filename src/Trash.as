package
{
	import net.flashpunk.Entity;
	import net.flashpunk.Graphic;
	import net.flashpunk.Mask;
	import net.flashpunk.utils.*;
	import net.flashpunk.graphics.*;
	import net.flashpunk.graphics.Text;
	import net.flashpunk.masks.Hitbox;
	
	public class Trash extends Entity
	{
		[Embed(source = 'assets/trash.png')] private static const TRASH:Class;
		private var img:Image;
		private var text:Text;
		
		public function Trash()
		{
			img = new Image(TRASH);
			img.x = -img.width * .5;
			img.y = -img.height * .5;

			mask = new Hitbox(img.width, img.height, img.x, img.y);
			
			text = new Text('8');
			text.centerOO();
			text.x = 2;
			text.y = img.y - 5;
			text.scale = .5;
			
			x = 255;
			y = 145;
			
			graphic = new Graphiclist(img,text);
			
			super(x, y, graphic, mask);
		}
		
		public override function update():void {
			var hover:Boolean = collidePoint(x,y,Input.mouseX,Input.mouseY);
			if (hover) {
				img.alpha = 1;
				text.visible = true;
			} else {
				img.alpha = .5;
				text.visible = false;
			}
			
			if (Input.pressed(Key.DIGIT_8)) {
				Map.current.reset();
			}
		}
	}
}