package lib.silvertower {
	
	import flash.display.MovieClip;
	import lib.silvertower.Particle;
	import flash.events.Event;
	import com.greensock.*;
	import com.greensock.easing.*;
	import lib.silvertower.SilverTowerShootoutGame;
	
	public class EnemyFood extends Particle {
		public var sinMeter:Number;
		public var bobValue:Number;
		public var status:String;
				
		public function EnemyFood() {
			status = "OK";
			bobValue = 0.7;
			xVel = 0;
			yVel = 0;
			airResistance = 1;
			gravity = 0;
			gotoAndStop(Math.ceil(Math.random()*7));
			}
		
		public function destroy() : void {
			gravity = 0.45;
			status = "Dead";
			}
			
		public override function update():void {
			if (status != "Dead") {
				xVel = Math.sin(sinMeter) * bobValue;
				}
						
			//TweenLite.to(enemyFoods, 0.5, {_yscale:20, ease:Bounce.easeOut});
					
			if (y > 352 && status != "Dead") {
				status = "Attacking";
				trace ("Attacking");
				//if(! collisionHasOccured) {
					//score ++;
					//gameScore.text = String(score);
				}
				
			if (x < 0 || x > 550) {
				dispatchEvent(new Event(Particle.PURGE_EVENT, true, false));
				}
				
			if (y < 0 || y > 400) {
				dispatchEvent(new Event(Particle.PURGE_EVENT, true, false));
				}
				
			sinMeter += 5;
			super.update();
			}
		
		}
}