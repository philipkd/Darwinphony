package
{
	import flash.display.Bitmap;
	
	import net.flashpunk.*;
	import net.flashpunk.graphics.*;
	import net.flashpunk.utils.*;
	
	public class Map extends World
	{
		
		public static var current:Map;
		public static const LAYER_MAP:int = 5;
		public static const LAYER_TURTLES:int = 4;
		public static const LAYER_KRILL:int = 3;
		
		public var ready:Boolean = false;
		
		private var began:Boolean;
		
		private var _map:*;
		private var _creatures:*;
		private var _beginner:Boolean;
		
		public function Map(map:*, creatures:*, beginner:Boolean = false)
		{
			_map = map;
			_creatures = creatures;
			_beginner = beginner;
			
			super();
			current = this;			
		}
		
		
		public override function begin():void {
			if (!began) {
				var map:Entity = new Entity(0,0,new Image(_map));
				map.layer = 5;
				add(map);
							
				var darwin:Darwin = new Darwin();
				darwin.x = 16
				darwin.y = 133;
				add(darwin); 
				
				var adam:Creature = new Creature(_creatures, true);
				add(adam); 
				
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
				
				add(new Turtle(Turtle.TURTLE_TYPE_CURSOR));
				
				if (_beginner) {
					var guide:Turtle = new Turtle(Turtle.TURTLE_TYPE_LAND);
					guide.x = adam.anchor_x - 20;
					guide.y = adam.anchor_y + Math.random() * 20 - 10;
					add(guide);
				}
			
				add(new Trash);
			}
			
			super.begin();
		}
	
		
		public function reset():void {
			var creatures:Array = new Array();
			FP.world.getType('creature',creatures);
			for each (var creature:Creature in creatures)
				remove(creature);

			var turtles:Array = new Array();
			FP.world.getType('turtle',turtles);
			for each (var turtle:Turtle in turtles)
				remove(turtle);
			
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
		
		public function menuHover():Boolean {
			var e:Entity = collidePoint('menu',Input.mouseX, Input.mouseY);
			if (e)
				return true;
			else
				return false;
		}
		
		
		
		public override function update():void {
			if (Input.mouseUp)
				ready = true;
			
			Notes.shared().tick(FP.elapsed);
			
			super.update();
		}
		
		public function select():void {
			current = this;
			FP.world = this;
			ready = false;
		}
		
		public static function norm():Number {
			return (Math.random() + Math.random() + Math.random() + Math.random()) / 4.0
		}
		
		
	}
}