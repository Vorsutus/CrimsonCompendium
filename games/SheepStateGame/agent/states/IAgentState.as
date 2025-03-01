﻿package agent.states 
{
	import agent.Agent;
	import agent.WolfAgent;

	public interface IAgentState 
	{
		function update(a:Agent):void;
		function enter(a:Agent):void;
		function exit(a:Agent):void;
	}
}