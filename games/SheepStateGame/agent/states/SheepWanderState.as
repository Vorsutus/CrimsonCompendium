package agent.states 
{
	import agent.Agent;
	
	public class SheepWanderState implements IAgentState
	{
		public function update(a:Agent):void
		{
				
			//if (!a.canSeeLassie || !a.canSeeWolf) return;
			
			if (a.numCycles > 100) {
				a.setState(Agent.SHEEPGRAZE);
				}
				
			if (a.distanceToWolf < a.fleeRadius) {
				a.setState(Agent.SHEEPFLEE);
				}
				
			if (a.distanceToLassie < a.fleeRadius) {
					a.setState(Agent.SHEEPHERD);
					}
					
			if(a.distanceToWolf < 50) {
				Main.wilhelm.play();
				a.setState(Agent.SHEEPDEAD);
				}
				
			a.velocity.x += Math.random() * 0.2 - 0.1;
			a.velocity.y += Math.random() * 0.2 - 0.1;
		}
		
		public function enter(a:Agent):void
		{
			a.speed = 1;
			a.sheep.gotoAndPlay(3);
		}
		
		public function exit(a:Agent):void
		{
			
		}
	}
}