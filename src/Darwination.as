package
{
	import net.flashpunk.*;
	import net.flashpunk.graphics.*;

	[SWF(width=1325,height=760)]	
	
	public class Darwination extends Engine
	{
		
		[Embed(source = 'assets/map-shore.png')] private static const MAP_SHORE:Class;					
		[Embed(source = 'assets/creatures-shore.png')] private static const CREATURES_SHORE:Class;					
				
		[Embed(source = 'assets/map-forest.png')] private static const MAP_FOREST:Class;					
		[Embed(source = 'assets/creatures-forest.png')] private static const CREATURES_FOREST:Class;					

		[Embed(source = 'assets/map-tundra.png')] private static const MAP_TUNDRA:Class;					
		[Embed(source = 'assets/creatures-tundra.png')] private static const CREATURES_TUNDRA:Class;					

		[Embed(source = 'assets/map-flowers.png')] private static const MAP_FLOWERS:Class;					
		[Embed(source = 'assets/creatures-flowers.png')] private static const CREATURES_FLOWERS:Class;					

		public static var current:Darwination;
		
		private var shore:Map;
		private var forest:Map;
		private var tundra:Map;
		private var flowers:Map;
		
		public function Darwination()
		{			
			super(265,152,60,false);
			
			FP.screen.scale = 5;
			FP.screen.color = 0x444644;
			
			shore = new Map(MAP_SHORE,CREATURES_SHORE, 72, 84);
			forest = new Map(MAP_FOREST, CREATURES_FOREST)
			tundra = new Map(MAP_TUNDRA, CREATURES_TUNDRA)
			flowers = new Map(MAP_FLOWERS, CREATURES_FLOWERS)
			
			shore.select();
			current = this;
			
		}
		
		public function select_forest():void {
			forest.select();
		}
		public function select_shore():void {
			shore.select();
		}
		public function select_tundra():void {
			tundra.select();
		}
		public function select_flowers():void {
			flowers.select();
		}
	}
}