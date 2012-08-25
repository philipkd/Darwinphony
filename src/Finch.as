package
{
	import net.flashpunk.*;
	import net.flashpunk.Entity;
	import net.flashpunk.Graphic;
	import net.flashpunk.utils.*;
	
	public class Finch extends Entity
	{
		[Embed(source = 'assets/tone1.mp3')] private const TONE_1_1:Class;
		[Embed(source = 'assets/tone1.mp3')] private const TONE_1_2:Class;
		[Embed(source = 'assets/tone1.mp3')] private const TONE_1_3:Class;
		[Embed(source = 'assets/tone1.mp3')] private const TONE_1_4:Class;
		[Embed(source = 'assets/tone1.mp3')] private const TONE_1_5:Class;
		[Embed(source = 'assets/tone1.mp3')] private const TONE_1_6:Class;
		[Embed(source = 'assets/tone1.mp3')] private const TONE_1_7:Class;
		[Embed(source = 'assets/tone1.mp3')] private const TONE_1_8:Class;
		[Embed(source = 'assets/tone1.mp3')] private const TONE_1_9:Class;
		[Embed(source = 'assets/tone1.mp3')] private const TONE_1_10:Class;
		[Embed(source = 'assets/tone1.mp3')] private const TONE_1_11:Class;
		[Embed(source = 'assets/tone1.mp3')] private const TONE_1_12:Class;
		[Embed(source = 'assets/tone1.mp3')] private const TONE_1_13:Class;
		[Embed(source = 'assets/tone1.mp3')] private const TONE_1_14:Class;
		[Embed(source = 'assets/tone1.mp3')] private const TONE_1_15:Class;
		[Embed(source = 'assets/tone1.mp3')] private const TONE_1_16:Class;
		[Embed(source = 'assets/tone2.mp3')] private const TONE_2:Class;
		[Embed(source = 'assets/tone3.mp3')] private const TONE_3:Class;
		[Embed(source = 'assets/tone4.mp3')] private const TONE_4:Class;
		[Embed(source = 'assets/tone5.mp3')] private const TONE_5:Class;
		[Embed(source = 'assets/tone6.mp3')] private const TONE_6:Class;
		[Embed(source = 'assets/tone7.mp3')] private const TONE_7:Class;
		[Embed(source = 'assets/tone8.mp3')] private const TONE_8:Class;
		[Embed(source = 'assets/tone9.mp3')] private const TONE_9:Class;
		[Embed(source = 'assets/tone10.mp3')] private const TONE_10:Class;
		[Embed(source = 'assets/tone11.mp3')] private const TONE_11:Class;
		[Embed(source = 'assets/tone12.mp3')] private const TONE_12:Class;
		[Embed(source = 'assets/tone13.mp3')] private const TONE_13:Class;
		[Embed(source = 'assets/tone14.mp3')] private const TONE_14:Class;
		[Embed(source = 'assets/tone15.mp3')] private const TONE_15:Class;
		[Embed(source = 'assets/tone16.mp3')] private const TONE_16:Class;
		
		
		private var timer:Number = 0;
		private var tones:Array = new Array(16);
		
		public function Finch(x:Number=0, y:Number=0, graphic:Graphic=null, mask:Mask=null)
		{
			setHitbox(1,1);
			var i:uint;
			
			for (i = 0; i < 16; i++)
				tones[i] = new Array(16);
			
			tones[0][0] = new Sfx(TONE_1_1); 
			tones[0][1] = new Sfx(TONE_1_2); 
			tones[0][2] = new Sfx(TONE_1_3); 
			tones[0][3] = new Sfx(TONE_1_4); 
			tones[0][4] = new Sfx(TONE_1_5); 
			tones[0][5] = new Sfx(TONE_1_6); 
			tones[0][6] = new Sfx(TONE_1_7); 
			tones[0][7] = new Sfx(TONE_1_8); 
			tones[0][8] = new Sfx(TONE_1_9); 
			tones[0][9] = new Sfx(TONE_1_10); 
			tones[0][10] = new Sfx(TONE_1_11); 
			tones[0][11] = new Sfx(TONE_1_12); 
			tones[0][12] = new Sfx(TONE_1_13); 
			tones[0][13] = new Sfx(TONE_1_14); 
			tones[0][14] = new Sfx(TONE_1_15); 
			tones[0][15] = new Sfx(TONE_1_16); 

			
			super(x, y, graphic, mask);
		}
		
		public override function update():void {
			var c:Creature = collide('creature',x,y) as Creature;
			
			const tps:int = 8;
			const cycle:int = 2;
			
			timer += FP.elapsed;
			if (timer > cycle)
				timer -= cycle;
			
			if (c) {
				var tone:Sfx = tones[0][int(timer * tps)] as Sfx;
				if (!tone.playing) {
					trace(int(timer * tps));
					tone.play();
				}
			}
			
			x = Input.mouseX;
			y = Input.mouseY;
		}
	}
}