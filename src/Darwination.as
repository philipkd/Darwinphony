package
{
	import net.flashpunk.*;
	import net.flashpunk.graphics.*;

	[SWF(width=1325,height=760)]	
	
	public class Darwination extends Engine
	{
		
		[Embed(source = 'assets/map-shore.png')] private static const MAP_SHORE:Class;					
		[Embed(source = 'assets/creatures-shore.png')] private static const CREATURES_SHORE:Class;					
		
		public function Darwination()
		{			
			super(265,152,60,false);
			
			FP.screen.scale = 5;
			FP.screen.color = 0x444644;
			
			FP.world = new MyWorld(MAP_SHORE,CREATURES_SHORE, 72, 84);
			
		}
	}
}