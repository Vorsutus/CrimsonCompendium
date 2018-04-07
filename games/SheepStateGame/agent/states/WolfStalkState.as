package agent.states 
{
	import agent.Agent;
	import agent.WolfAgent;
	
	public class WolfStalkState implements IWolfAgentState
	{
		/* INTERFACE agent.states.IWolfAgentState */

		public function w_update(w:WolfAgent):void
		{			
			
			if(w.distanceToSheep < w.chaseRadius) {
				if(Agent.sheepCurrentState == Agent.SHEEPDEAD) {
					return;
					}
					
					w.setWolfState(WolfAgent.WOLFCHASE);
				}
				
			if(w.distanceToSheep < w.chaseRadius) {
				if(Agent.sheepCurrentState == Agent.SHEEPPEN) {
					return;
					}
					
					w.setWolfState(WolfAgent.WOLFCHASE);
				}
				
			if (w.wolfNumCycles > 120) {
				w.setWolfState(WolfAgent.WOLFSNIFF);
				}	
				
			if (w.distanceToLassie < w.wolfFleeRadius) {
				w.setWolfState(WolfAgent.WOLFFLEE);
				}
				
			/*if(Agent.sheepSpeed < 1) return;*/
		}
		
		public function w_enter(w:WolfAgent):void
		{
		//	w.wolfSay("Stalking...");
			w.wolfSpeed = 4;
			w.wolf.gotoAndPlay(2);
			//w.wolfVelocity.x = .5;//Math.random() * 0.2 - 0.1;
			//w.wolfVelocity.y = .5;//Math.random() * 0.2 - 0.1;
			w.randomDirectionWolf();
		}
		
		public function w_exit(w:WolfAgent):void
		{
		}
	}
}