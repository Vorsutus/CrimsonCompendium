package agent.states 
{
	import Main;
	import agent.Agent;
	
	public class SheepDeadState implements IAgentState {

		/* INTERFACE agent.states.IAgentState */
		
		public function update(a:Agent):void {
			
			if(a.numCycles == 300) {
				a.sheep.gotoAndPlay(31);
				}
				
			if(a.numCycles == 500) {	
				a.sheep.gotoAndPlay(46);
				}
				
			if(a.numCycles > 700) {	
				a.sheep.gotoAndStop(61);
				}
			}
		
		public function enter(a:Agent):void {
			//a.say("RIP");
			a.speed = 0;
			Main.wolfScore++;
			a.sheep.gotoAndPlay(8);
			
			}
		
		public function exit(a:Agent):void{
			
			}
	}
}