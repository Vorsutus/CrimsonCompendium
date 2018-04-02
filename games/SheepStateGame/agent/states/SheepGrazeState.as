package agent.states 
{
	import agent.Agent;
	public class SheepGrazeState implements IAgentState
	{
		/* INTERFACE agent.states.IAgentState */
		
		public function update(a:Agent):void
		{
			
			if(a.distanceToWolf < 60) {
				Main.wilhelm.play();
				a.setState(Agent.SHEEPDEAD);
			}
				
			if (a.distanceToLassie < a.fleeRadius) {
				a.setState(Agent.SHEEPHERD);
			}
			
			if (a.distanceToWolf < a.fleeRadius) {
				a.setState(Agent.SHEEPFLEE);
			}
			
			if (a.numCycles > 50) {
				a.setState(Agent.SHEEPWANDER);
			}
		}
		
		public function enter(a:Agent):void
		{
			a.speed = 0;
			a.sheep.gotoAndStop(1);
		}
		
		public function exit(a:Agent):void
		{
			
		}
	}
}