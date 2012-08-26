package
{
	import net.flashpunk.*;
	import net.flashpunk.World;
	import net.flashpunk.graphics.*;
	import net.flashpunk.utils.*;

	
	public class Title extends World
	{
		[Embed(source = 'assets/title-1.png')] private static const TITLE_1:Class;
		[Embed(source = 'assets/title-2.png')] private static const TITLE_2:Class;
		[Embed(source = 'assets/punch.mp3')] private static const PUNCH:Class;

		private var punch:Sfx = new Sfx(PUNCH);
		private var title1:Image = new Image(TITLE_1);
		private var title2:Image = new Image(TITLE_2);
		private var title:Entity;
		private var shoreCD:Number = 0;
		
		public function Title()
		{
			title = new Entity(0,0,title1);
			super();
		}
		
		public override function begin():void {
			add(title)
			super.begin();
		}
		
		public override function update():void {
			if (shoreCD > 0)
				shoreCD -= FP.elapsed;
			
			if (shoreCD < 0)
				Darwination.current.select_shore();
			
			if (Input.mouseDown) {
				title.graphic = title2;
				punch.play();
				shoreCD = 2;
			}
			super.update();
		}
	}
}