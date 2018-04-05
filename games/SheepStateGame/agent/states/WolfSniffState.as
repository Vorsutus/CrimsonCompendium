package agent.states 
{
	import agent.Agent;
	import agent.WolfAgent;
	
	public class WolfSniffState implements IWolfAgentState
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
				
			if (w.wolfNumCycles > 20) {
				w.setWolfState(WolfAgent.WOLFSTALK);
			}
			
			if (w.distanceToLassie < w.wolfFleeRadius) {
				w.setWolfState(WolfAgent.WOLFFLEE);
			}
			
		//	if(Agent.sheepSpeed < 1) return;
		}	
		
		public function w_enter(w:WolfAgent):void
		{
		//	w.wolfSay("Sniff Sniff");
			w.wolfSpeed = 3;
			w.wolf.gotoAndPlay(2);
		}
		
		public function w_exit(w:WolfAgent):void
		{
		//	w.randomDirectionWolf();
		}
	}
}