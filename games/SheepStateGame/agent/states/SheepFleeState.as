package agent.states 
{
	import agent.Agent;
	import agent.WolfAgent;
	import flash.media.SoundMixer;
	import flash.net.URLRequest;
	import flash.media.Sound;
	
	public class SheepFleeState implements IAgentState
	{
		/* INTERFACE agent.states.IAgentState */
		
		public function update(a:Agent):void
		{
			if (a.numCycles < 20) return;
			//	a.say("Run For Your Life");
				a.speed = 2;
				a.faceWolf( -1);
			
			if (a.y + a.velocity.y > 495 || a.y + a.velocity.y < 275) 
			{
			//	a.say("NoooooOOOO!");
				a.speed = 0;
				a.faceWolf(1);
			}
			
			if(a.distanceToWolf < 60) {
				Main.wilhelm.play();
				a.setState(Agent.SHEEPDEAD);
				}
			
			if(a.numCycles > 50){
				if (a.distanceToWolf > a.fleeRadius) {
					a.setState(Agent.SHEEPGRAZE);
				}
			}
		}
		
		public function enter(a:Agent):void
		{
			Main.fleebah.play();
		//	a.say("BAAAAAAHH");
			a.faceWolf(1);
			a.speed = 0;
			a.sheep.gotoAndPlay(3);
		}
		
		public function exit(a:Agent):void
		{
			
		}
	}
}