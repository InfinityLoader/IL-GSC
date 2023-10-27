/*******************************************************************
 * Decompiled By: Bog
 * Decompiled File: scripts\mp\agents\cop_dlc2\cop_dlc2_agent.gsc
 * Game: Call of Duty: Infinite Warfare
 * Platform: PC
 * Function Count: 7
 * Decompile Time: 418 ms
 * Timestamp: 10/27/2023 12:11:08 AM
*******************************************************************/

//Function Number: 1
registerscriptedagent()
{
	if(!isdefined(level.var_4632))
	{
		level.var_4632 = 5;
	}

	level.agent_funcs["cop_dlc2"]["on_damaged"] = ::lib_0CBC::func_C5CD;
	level.agent_funcs["cop_dlc2"]["gametype_on_damage_finished"] = ::lib_0CBC::func_C5CE;
	level.agent_funcs["cop_dlc2"]["gametype_on_killed"] = ::lib_0CBC::func_C5D2;
	level.var_BCCE["cop_dlc2"] = ::lib_0CBC::func_E7FD;
	lib_0A02::init();
	func_AEB0();
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

	level.agent_definition["cop_dlc2"]["setup_func"] = ::setupagent;
	level.agent_definition["cop_dlc2"]["setup_model_func"] = ::func_FACE;
	level.agent_funcs["cop_dlc2"]["on_damaged_finished"] = ::scripts\mp\agents\zombie\zmb_zombie_agent::func_C5CE;
	level.agent_funcs["cop_dlc2"]["on_killed"] = ::scripts\mp\agents\zombie\zmb_zombie_agent::func_C5D2;
	level.var_1094E["cop_dlc2"] = ::func_FF94;
}

//Function Number: 3
setupagent()
{
	scripts\mp\agents\zombie\zmb_zombie_agent::setupagent();
	thread func_899C();
	self.var_9BA7 = 1;
}

//Function Number: 4
func_899C()
{
	self endon("death");
	level waittill("game_ended");
	self method_841F();
	foreach(var_04, var_01 in self.var_164D)
	{
		var_02 = var_01.var_4BC0;
		var_03 = level.var_2303[var_04].var_10E2F[var_02];
		lib_0A1A::func_2388(var_04,var_02,var_03,var_03.var_116FB);
		lib_0A1A::func_238A(var_04,"idle",0.2,undefined,undefined,undefined);
	}
}

//Function Number: 5
func_FACE(param_00)
{
	self setmodel("police_officer_zombie");
	thread scripts\mp\agents\zombie\zmb_zombie_agent::func_50EF();
}

//Function Number: 6
func_AEB0()
{
}

//Function Number: 7
func_FF94()
{
	return undefined;
}