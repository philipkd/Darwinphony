package
{
	import net.flashpunk.*;
	import net.flashpunk.Entity;
	import net.flashpunk.graphics.*;
	import net.flashpunk.masks.Hitbox;
	import net.flashpunk.utils.*;
	
	public class Spawner extends Entity
	{
		[Embed(source = 'assets/cursor-spawn.png')] private static const SPAWN:Class;
		public static const SPAWN_TYPE_INERT:int = 0;
		public static const SPAWN_TYPE_CURSOR:int = 1;
		
		public var spawn_type:int; 
		
		private var img:Image;
		private var text:Text;
		private var spawn_cd:Number = 0;
		
		public function Spawner(spawn_type_value:int) {
			spawn_type = spawn_type_value;
			
			img = new Image(SPAWN);
			img.x = -img.width * .5;
			img.y = -img.height * .5;
			mask = new Hitbox(img.width, img.height, img.x, img.y);
		
			if (spawn_type == SPAWN_TYPE_CURSOR) {
				type = 'cursor';
				img.alpha = .5;
				x = Input.mouseX;
				y = Input.mouseY;
				graphic = img;
			} else {
				type = 'menu';
				text = new Text('3');
				text.centerOO();
				text.y = -10;
				text.scale = .5;
				graphic = new Graphiclist(text, img);				
			}
			super(x, y, graphic, mask);
		}
		
		public override function update():void {
			if (spawn_type == SPAWN_TYPE_CURSOR) {				
				x = Input.mouseX;
				y = Input.mouseY;
				
				if (spawn_cd < 0)
					spawn_cd = 0;
				if (spawn_cd > 0)
					spawn_cd -= FP.elapsed;
				
				var baby:Creature;
				
				if (Input.mouseDown && !Map.current.menuHover() && Map.current.ready && spawn_cd <= 0 ) {

					var creatures:Array = new Array();
					FP.world.getType('creature',creatures);
					if (creatures.length > 1) {
						var nearestDist:Number = 1000;
						var secondNearestDist:Number = 10000;
						var nearest:Creature;
						var secondNearest:Creature;
						
						for each (var creature:Creature in creatures) {
							var dist:Number = FP.distance(Input.mouseX, Input.mouseY, creature.x, creature.y);
							if (dist < nearestDist) {
								
								secondNearestDist = nearestDist;
								secondNearest = nearest
								
								nearestDist = dist;
								nearest = creature;
								
							} else if (dist < secondNearestDist) {
								secondNearestDist = dist;
								secondNearest = creature;
							}
						}
						baby = secondNearest.mate(nearest);
						
					} else if (creatures.length > 0) {
						baby = creatures[0].mate(creatures[0]);
					} else {
						Map.current.reset();
					}
					
					spawn_cd = .0625;
					
					img.alpha = 1;
				} else {
					img.alpha = .5;
				}
				
				
			} else if (spawn_type == SPAWN_TYPE_INERT) {
				var hover:Boolean = collidePoint(x,y,Input.mouseX,Input.mouseY);
				
				text.visible = hover;
				
				if (Input.pressed(Key.DIGIT_3) || (hover && Map.current.cursor() != this)) {
					Map.current.clear_cursor();
					FP.world.add(new Spawner(SPAWN_TYPE_CURSOR));
				}
			}
			
			
		}
	}
}