package
{
	import flash.display.Bitmap;
	
	import net.flashpunk.*;
	import net.flashpunk.graphics.Image;
	
	public class MyWorld extends World
	{
		
		private var _map:*;
		private var _creatures:*;
		
		public static var current:MyWorld;
		public static const LAYER_MAP:int = 5;
		public static const LAYER_TURTLES:int = 4;
		public static const LAYER_KRILL:int = 3;
		
		public function MyWorld(map:*, creatures:*)
		{
			_map = map;
			_creatures = creatures;
			
			super();
			current = this;			
		}
		
		
		public override function begin():void {
			var map:Entity = new Entity(0,0,new Image(_map));
			map.layer = 5;
			add(map);
						
			var darwin:Darwin = new Darwin();
			darwin.x = darwin.halfWidth;
			darwin.y = FP.screen.height - darwin.halfHeight;
			add(darwin); 
			
			add(new Creature(_creatures, true)); 
			
			var finch:Finch = new Finch(Finch.FINCH_TYPE_INERT);
			finch.x = 49;
			finch.y = 133;
			add(finch);
			
			var spawner:Spawner = new Spawner(Spawner.SPAWN_TYPE_INERT);
			spawner.x = 78;
			spawner.y = 145;
			add(spawner);
			
			var turtle:Turtle = new Turtle(Turtle.TURTLE_TYPE_MENU);
			turtle.x = 61;
			turtle.y = 143;
			add(turtle);
			
			add(new Spawner(Spawner.SPAWN_TYPE_CURSOR));
			
			super.begin();
		}
		
		public function reset():void {
			var creatures:Array = new Array();
			FP.world.getType('creature',creatures);
			for each (var creature:Creature in creatures)
				remove(creature);
			
			add(new Creature(_creatures, true)); 			
		}
		
		public function clear_cursor():void {
			var cursors:Array = new Array();
			FP.world.getType('cursor',cursors);
			for each (var cursor:Entity in cursors) {
				remove(cursor);
			}
		}
		
		public static function norm():Number {
			return (Math.random() + Math.random() + Math.random() + Math.random()) / 4.0
		}
		
		
	}
}