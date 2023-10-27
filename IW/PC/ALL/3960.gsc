/*******************************************************************
 * Decompiled By: Bog
 * Decompiled File: 3960.gsc
 * Game: Call of Duty: Infinite Warfare
 * Platform: PC
 * Function Count: 8
 * Decompile Time: 1 ms
 * Timestamp: 10/27/2023 12:31:50 AM
*******************************************************************/

//Function Number: 1
func_13F19()
{
	registerscriptedagent();
	if(!isdefined(level.var_4632))
	{
		level.var_4632 = 5;
	}

	level.agent_funcs["zombie_cop"]["on_damaged"] = ::lib_0CBC::func_C5CD;
	level.agent_funcs["zombie_cop"]["gametype_on_damage_finished"] = ::lib_0CBC::func_C5CE;
	level.agent_funcs["zombie_cop"]["gametype_on_killed"] = ::lib_0CBC::func_C5D2;
	level.var_BCCE["zombie_cop"] = ::lib_0CBC::func_E7FD;
}

//Function Number: 2
registerscriptedagent()
{
	lib_0A02::init();
	lib_03B4::func_DEE8();
	lib_0F46::func_2371();
	func_AEB0();
	thread func_FAB0();
}

//Function Number: 3
func_FAB0()
{
	level endon("game_ended");
	if(!isdefined(level.agent_definition))
	{
		level waittill("scripted_agents_initialized");
	}

	level.agent_definition["zombie_cop"]["setup_func"] = ::setupagent;
	level.agent_definition["zombie_cop"]["setup_model_func"] = ::func_FACE;
	level.agent_funcs["zombie_cop"]["on_damaged_finished"] = ::scripts\mp\agents\zombie\zmb_zombie_agent::func_C5CE;
	level.agent_funcs["zombie_cop"]["on_killed"] = ::scripts\mp\agents\zombie\zmb_zombie_agent::func_C5D2;
	level.var_1094E["zombie_cop"] = ::func_FF94;
}

//Function Number: 4
setupagent()
{
	scripts\mp\agents\zombie\zmb_zombie_agent::setupagent();
	self.var_9BA7 = 1;
}

//Function Number: 5
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

//Function Number: 6
func_FACE(param_00)
{
	self setmodel("police_officer_zombie");
	thread scripts\mp\agents\zombie\zmb_zombie_agent::func_50EF();
}

//Function Number: 7
func_AEB0()
{
}

//Function Number: 8
func_FF94()
{
	if(level.wave_num >= 20)
	{
		var_00 = min(level.wave_num - 10,20);
	}
	else
	{
		var_00 = level.var_4632;
	}

	var_01 = 5;
	var_02 = "zombie_cop";
	if(getdvarint("scr_force_cop_spawn",0) == 1)
	{
		var_01 = 0;
		var_00 = 100;
	}

	if(getdvarint("scr_force_no_cop_spawn",0) == 1)
	{
		var_01 = 500;
		var_00 = 0;
	}

	if(level.wave_num > var_01)
	{
		if(randomint(100) < var_00)
		{
			return var_02;
		}

		return undefined;
	}

	return undefined;
}