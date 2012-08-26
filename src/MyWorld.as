package
{
	import flash.display.Bitmap;
	
	import net.flashpunk.*;
	import net.flashpunk.graphics.Image;
	
	public class MyWorld extends World
	{
		
		public static var current:MyWorld;
		public static const LAYER_MAP:int = 5;
		public static const LAYER_TURTLES:int = 4;
		public static const LAYER_KRILL:int = 3;

		private var _map:*;
		private var _creatures:*;
		private var _initial_turtle_x:Number;
		private var _initial_turtle_y:Number;
		
		public function MyWorld(map:*, creatures:*, initial_turtle_x:Number, initial_turtle_y:Number)
		{
			_map = map;
			_creatures = creatures;
			_initial_turtle_x = initial_turtle_x;
			_initial_turtle_y = initial_turtle_y;
			
			super();
			current = this;			
		}
		
		
		public override function begin():void {
			var map:Entity = new Entity(0,0,new Image(_map));
			map.layer = 5;
			add(map);
						
			var darwin:Darwin = new Darwin();
			darwin.x = 16
			darwin.y = 133;
			add(darwin); 
			
			add(new Creature(_creatures, true)); 
			
			var finch:Finch = new Finch(Finch.FINCH_TYPE_INERT);
			finch.x = 49;
			finch.y = 134;
			add(finch);
			
			var spawner:Spawner = new Spawner(Spawner.SPAWN_TYPE_INERT);
			spawner.x = 78;
			spawner.y = 145;
			add(spawner);
			
			var turtle:Turtle = new Turtle(Turtle.TURTLE_TYPE_MENU);
			turtle.x = 61;
			turtle.y = 144;
			add(turtle);
			
			add(new Spawner(Spawner.SPAWN_TYPE_CURSOR));
			
			var beginner:Turtle = new Turtle(Turtle.TURTLE_TYPE_LAND);
			beginner.x = _initial_turtle_x;
			beginner.y = _initial_turtle_y;
			add(beginner);
		
			add(new Trash);
			
			super.begin();
		}
		
		public function reset():void {
			var creatures:Array = new Array();
			FP.world.getType('creature',creatures);
			for each (var creature:Creature in creatures)
				remove(creature);
			
			add(new Creature(_creatures, true)); 			
		}
		
		public function cursor():Entity {
			var cursors:Array = new Array();
			FP.world.getType('cursor',cursors);
			if (cursors.length > 0)
				return cursors[0];
			return null;
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