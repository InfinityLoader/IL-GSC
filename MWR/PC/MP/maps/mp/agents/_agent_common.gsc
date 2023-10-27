/*******************************************************************
 * Decompiled By: Bog
 * Decompiled File: maps\mp\agents\_agent_common.gsc
 * Game: Call of Duty: Modern Warfare Remastered
 * Platform: PC
 * Function Count: 8
 * Decompile Time: 112 ms
 * Timestamp: 10/27/2023 2:36:51 AM
*******************************************************************/

//Function Number: 1
codecallback_agentadded()
{
	maps\mp\agents\_agent_utility::initagentscriptvariables();
	var_00 = "axis";
	if(level.numagents % 2 == 0)
	{
		var_00 = "allies";
	}

	level.numagents++;
	maps\mp\agents\_agent_utility::set_agent_team(var_00);
	level.agentarray[level.agentarray.size] = self;
}

//Function Number: 2
codecallback_agentdamaged(param_00,param_01,param_02,param_03,param_04,param_05,param_06,param_07,param_08,param_09)
{
	param_01 = maps\mp\_utility::_validateattacker(param_01);
	self [[ maps\mp\agents\_agent_utility::agentfunc("on_damaged") ]](param_00,param_01,param_02,param_03,param_04,param_05,param_06,param_07,param_08,param_09);
}

//Function Number: 3
codecallback_agentkilled(param_00,param_01,param_02,param_03,param_04,param_05,param_06,param_07,param_08)
{
	param_01 = maps\mp\_utility::_validateattacker(param_01);
	self thread [[ maps\mp\agents\_agent_utility::agentfunc("on_killed") ]](param_00,param_01,param_02,param_03,param_04,param_05,param_06,param_07,param_08);
}

//Function Number: 4
init()
{
	initagentlevelvariables();
	level thread add_agents_to_game();
}

//Function Number: 5
connectnewagent(param_00,param_01,param_02)
{
	var_03 = maps\mp\agents\_agent_utility::getfreeagent(param_00);
	if(isdefined(var_03))
	{
		var_03.connecttime = gettime();
		if(isdefined(param_01))
		{
			var_03 maps\mp\agents\_agent_utility::set_agent_team(param_01);
		}
		else
		{
			var_03 maps\mp\agents\_agent_utility::set_agent_team(var_03.team);
		}

		if(isdefined(param_02))
		{
			var_03.class_override = param_02;
		}

		if(isdefined(level.agent_funcs[param_00]["onAIConnect"]))
		{
			var_03 [[ var_03 maps\mp\agents\_agent_utility::agentfunc("onAIConnect") ]]();
		}

		var_03 maps\mp\gametypes\_spawnlogic::addtocharactersarray();
	}

	return var_03;
}

//Function Number: 6
initagentlevelvariables()
{
	level.agentarray = [];
	level.numagents = 0;
}

//Function Number: 7
add_agents_to_game()
{
	level endon("game_ended");
	level waittill("connected",var_00);
	var_01 = getmaxagents();
	while(level.agentarray.size < var_01)
	{
		var_02 = addagent();
		if(!isdefined(var_02))
		{
			wait 0.05;
			continue;
		}
	}
}

//Function Number: 8
set_agent_health(param_00)
{
	self.agenthealth = param_00;
	self.health = param_00;
	self.maxhealth = param_00;
}