package agent.states 
{
	import Main;
	import agent.WolfAgent;
	import agent.Agent;

	public class WolfChaseState implements IWolfAgentState
	{
					
		/* INTERFACE agent.states.IWolfAgentState */
		
		public function w_update(w:WolfAgent):void
		{				
			var wdx:Number = Agent.sheepX - w.x;
			var wdy:Number = Agent.sheepY - w.y;
			var rad:Number = Math.atan2(wdy, wdx);
			w.wolfVelocity.x = Math.cos(rad);
			w.wolfVelocity.y = Math.sin(rad);
			
			
			if (Agent.sheepCurrentState == Agent.SHEEPDEAD) {
					w.setWolfState(WolfAgent.WOLFSNIFF);
					}
					
			if (Agent.sheepCurrentState == Agent.SHEEPPEN) {
					w.setWolfState(WolfAgent.WOLFSNIFF);
					}
					
			if (w.distanceToLassie < w.wolfFleeRadius) {
				w.setWolfState(WolfAgent.WOLFFLEE);
				}	
				
			else if (w.distanceToSheep < 2) {
				if (w.wolfNumCycles < 60) {
					w.wolf.gotoAndPlay(10);
					}
					
				if  (w.wolfNumCycles > 60) {
					w.setWolfState(WolfAgent.WOLFSNIFF);
					}
				}
			}
		
		public function w_enter(w:WolfAgent):void
		{
			//w.wolfSay("Dinner!");
			w.wolf.gotoAndPlay(2);
			w.wolfSpeed = 6;
		}
		
		public function w_exit(w:WolfAgent):void
		{
			
		}
	}
}