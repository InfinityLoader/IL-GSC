/*******************************************************************
 * Decompiled By: Bog
 * Decompiled File: maps\mp\agents\_agent_common.gsc
 * Game: Call of Duty: Ghosts
 * Platform: PC
 * Function Count: 8
 * Decompile Time: 152 ms
 * Timestamp: 10/27/2023 1:16:43 AM
*******************************************************************/

//Function Number: 1
codecallback_agentadded()
{
	maps/mp/agents/_agent_utility::func_45D6();
	var_00 = "axis";
	if(level.numagents % 2 == 0)
	{
		var_00 = "allies";
	}

	level.numagents++;
	maps/mp/agents/_agent_utility::func_6E1D(var_00);
	level.agentarray[level.agentarray.size] = self;
}

//Function Number: 2
codecallback_agentdamaged(param_00,param_01,param_02,param_03,param_04,param_05,param_06,param_07,param_08,param_09)
{
	param_01 = maps\mp\_utility::_validateattacker(param_01);
	self [[ maps/mp/agents/_agent_utility::agentfunc("on_damaged") ]](param_00,param_01,param_02,param_03,param_04,param_05,param_06,param_07,param_08,param_09);
}

//Function Number: 3
codecallback_agentkilled(param_00,param_01,param_02,param_03,param_04,param_05,param_06,param_07,param_08)
{
	param_01 = maps\mp\_utility::_validateattacker(param_01);
	self thread [[ maps/mp/agents/_agent_utility::agentfunc("on_killed") ]](param_00,param_01,param_02,param_03,param_04,param_05,param_06,param_07,param_08);
}

//Function Number: 4
func_44DF()
{
	func_45D5();
	level thread func_0865();
}

//Function Number: 5
func_1EBE(param_00,param_01,param_02)
{
	var_03 = maps/mp/agents/_agent_utility::getfreeagent(param_00);
	if(isdefined(var_03))
	{
		var_03.connecttime = gettime();
		if(isdefined(param_01))
		{
			var_03 maps/mp/agents/_agent_utility::func_6E1D(param_01);
		}
		else
		{
			var_03 maps/mp/agents/_agent_utility::func_6E1D(var_03.team);
		}

		if(isdefined(param_02))
		{
			var_03.class_override = param_02;
		}

		if(isdefined(level.agent_funcs[param_00]["onAIConnect"]))
		{
			var_03 [[ var_03 maps/mp/agents/_agent_utility::agentfunc("onAIConnect") ]]();
		}

		var_03 maps\mp\gametypes\_spawnlogic::addtocharactersarray();
	}

	return var_03;
}

//Function Number: 6
func_45D5()
{
	level.agentarray = [];
	level.numagents = 0;
}

//Function Number: 7
func_0865()
{
	level endon("game_ended");
	level waittill("connected",var_00);
	var_01 = getmaxagents();
	while(level.agentarray.size < var_01)
	{
		var_02 = addagent();
		if(!isdefined(var_02))
		{
			common_scripts\utility::func_8AFE();
			continue;
		}
	}
}

//Function Number: 8
func_6E1C(param_00)
{
	self.agenthealth = param_00;
	self.health = param_00;
	self.maxhealth = param_00;
}