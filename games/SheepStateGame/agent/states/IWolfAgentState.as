package agent.states 
{
	import agent.Agent;
	import agent.WolfAgent;
		
	public interface IWolfAgentState 
	{
		function w_update(w:WolfAgent):void;
		function w_enter(w:WolfAgent):void;
		function w_exit(w:WolfAgent):void;
	}
}