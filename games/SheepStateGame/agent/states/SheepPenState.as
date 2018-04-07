package agent.states 
{
	import agent.Agent;
	
	public class SheepPenState implements IAgentState
	{
		
		/* INTERFACE agent.states.IAgentState */
		
		public function update(a:Agent):void
		{
			/*if (a.y < 550) {
				a.y = Math.max(0, Math.min(a.stage.stageHeight, a.y));
				a.velocity.y *= -1;
				}
			
			if (a.x + a.velocity.x > 425 || a.x + a.velocity.x < 175) {
				a.x = Math.max(0, Math.min(a.stage.stageWidth, a.x));
				a.velocity.x *= -1;
				}
			//if (a.y == 575){
				if (a.y > 575){
				a.velocity.y *= -1;
				}
				//a.x < 400 && a.x > 200;
				if (a.x > 425 || a.x < 175) {
				//a.x = Math.max(0, Math.min(a.stage.stageWidth, a.x));
				a.velocity.x *= -1;
				}*/
			
			if (a.y + a.velocity.y > 650 || a.y + a.velocity.y < 570) {
				a.velocity.y *= -1;
				}
			
			if (a.x + a.velocity.x < 230 || a.x + a.velocity.x > 380) {
				a.velocity.x *= -1;
				}
		}
		
		public function enter(a:Agent):void
		{
		//	a.say("Penned");
			a.speed = 1;
			a.sheep.gotoAndPlay(3);
		}
		public function exit(a:Agent):void
		{
			//a.randomDirectionSheep();
		}
	}
}