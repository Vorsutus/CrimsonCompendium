package agent.states 
{
	import Main;
	import agent.WolfAgent;
	import flash.media.SoundMixer;
	import flash.net.URLRequest;
	import flash.media.Sound;
	
	public class WolfFleeState implements IWolfAgentState
	{
		
		/* INTERFACE agent.states.IWolfAgentState */
		
		public function w_update(w:WolfAgent):void
		{
				
			if (w.y + w.wolfVelocity.y > 495 || w.y + w.wolfVelocity.y < 275) 
			{
		//	w.wolfSay("OK OK DAMN!");
			w.wolfSpeed = 6;
			}
			
			else 
			{
		//	w.wolfSay("Fuuuck Thaaat!");
			w.wolfSpeed = 6;
			w.faceLassie( -1);
			}
			
			if (w.wolfNumCycles > 50){
				if (w.distanceToLassie > w.wolfFleeRadius) {
					w.setWolfState(WolfAgent.WOLFSTALK);
				}
			}
		}
		
		public function w_enter(w:WolfAgent):void
		{
			Main.cryWolf.play();
	//		w.wolfSay("Ohh shit...");
			w.faceLassie(1);
			w.wolf.gotoAndPlay(2);
		}
		
		public function w_exit(w:WolfAgent):void
		{
			
		}
	}
}