/*******************************************************************
 * Decompiled By: Bog
 * Decompiled File: scripts\mp\agents\lumberjack\lumberjack_agent.gsc
 * Game: Call of Duty: Infinite Warfare
 * Platform: PC
 * Function Count: 9
 * Decompile Time: 500 ms
 * Timestamp: 10/27/2023 12:11:18 AM
*******************************************************************/

//Function Number: 1
registerscriptedagent()
{
	lib_0A02::init();
	behaviortree\lumberjack::func_DEE8();
	scripts\asm\lumberjack\mp\states::func_2371();
	thread func_FAB0();
}

//Function Number: 2
func_FAB0()
{
	level endon("game_ended");
	if(!isdefined(level.agent_definition))
	{
		level waittill("scripted_agents_initialized");
	}

	level.agent_definition["lumberjack"]["setup_func"] = ::setupagent;
	level.agent_definition["lumberjack"]["setup_model_func"] = ::func_FACE;
	level.agent_funcs["lumberjack"]["on_damaged"] = ::lib_0CBC::func_C5CD;
	level.agent_funcs["lumberjack"]["gametype_on_damage_finished"] = ::lib_0CBC::func_C5CE;
	level.agent_funcs["lumberjack"]["gametype_on_killed"] = ::lib_0CBC::func_C5D2;
	level.var_1094E["lumberjack"] = ::should_spawn_lumberjack;
}

//Function Number: 3
setupagent()
{
	scripts\mp\agents\zombie\zmb_zombie_agent::setupagent();
}

//Function Number: 4
func_FACE(param_00)
{
	self setmodel("zombie_lumberjack");
	thread delay_eye_glow();
}

//Function Number: 5
delay_eye_glow()
{
	self endon("death");
	wait(0.5);
	self method_80BB(1,0.1);
}

//Function Number: 6
func_C5CE(param_00,param_01,param_02,param_03,param_04,param_05,param_06,param_07,param_08,param_09,param_0A,param_0B,param_0C)
{
	scripts\mp\agents\zombie\zmb_zombie_agent::func_C5CE(param_00,param_01,param_02,param_03,param_04,param_05,param_06,param_07,param_08,param_09,param_0A,param_0B,param_0C);
}

//Function Number: 7
func_C5D2(param_00,param_01,param_02,param_03,param_04,param_05,param_06,param_07,param_08)
{
	scripts\mp\agents\zombie\zmb_zombie_agent::func_C5D2(param_00,param_01,param_02,param_03,param_04,param_05,param_06,param_07,param_08);
}

//Function Number: 8
func_C4BD(param_00,param_01,param_02,param_03,param_04,param_05,param_06,param_07,param_08,param_09)
{
	scripts\mp\agents\zombie\zmb_zombie_agent::func_C4BD(param_00,param_01,param_02,param_03,param_04,param_05,param_06,param_07,param_08,param_09);
}

//Function Number: 9
should_spawn_lumberjack()
{
	var_00 = 0;
	if(level.wave_num >= 20)
	{
		var_00 = min(level.wave_num - 10,20);
	}
	else
	{
		var_00 = level.lumberjack_spawn_percent;
	}

	var_01 = 5;
	if(getdvarint("scr_force_lumberjack_spawn",0) == 1)
	{
		var_01 = 0;
		var_00 = 100;
	}

	if(getdvarint("scr_force_no_lumberjack_spawn",0) == 1)
	{
		var_01 = 500;
		var_00 = 0;
	}

	if(level.wave_num > var_01)
	{
		if(randomint(100) < var_00)
		{
			return "lumberjack";
		}

		return undefined;
	}

	return undefined;
}