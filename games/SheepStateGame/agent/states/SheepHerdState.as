package agent.states 
{
	import Main;
	import agent.Agent;
	import agent.WolfAgent;
	import flash.media.SoundMixer;
	import flash.net.URLRequest;
	import flash.media.Sound;
 
	public class SheepHerdState implements IAgentState
	{
		
		/* INTERFACE agent.states.IAgentState */
		
		public function update(a:Agent):void
		{
			if (a.numCycles < 20) return;
			
			if (a.y + a.velocity.y > 499 || a.y + a.velocity.y < 281) 
			{
			//	a.say("hey Hey HEY!");
				a.speed = 3;
			}
			
			else 
			{
				a.speed = 2;
				a.faceLassie( -1);
			}
			
			if(a.numCycles > 80){
				if (a.distanceToLassie > a.fleeRadius) {
					a.setState(Agent.SHEEPGRAZE);
				}
			}
			
			if (a.distanceToWolf < a.fleeRadius) {
				a.setState(Agent.SHEEPFLEE);
			}
		}
		
		public function enter(a:Agent):void
		{
			Main.herdbah.play();
		//	a.say("baaahhh");
			a.faceLassie(1);
			a.speed = 0;
			a.sheep.gotoAndPlay(3);
		}
		
		public function exit(a:Agent):void
		{
		
		}
	}
}