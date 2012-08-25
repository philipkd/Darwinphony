package
{
	import net.flashpunk.*;

	[SWF(width=1325,height=760)]	
	
	public class Darwination extends Engine
	{
		public function Darwination()
		{			
			super(265,152,60,false);
			
			FP.screen.scale = 5;
			FP.screen.color = 0x444644;
			FP.world = new MyWorld;
			
		}
	}
}