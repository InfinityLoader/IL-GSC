/*******************************************************************
 * Decompiled By: Bog
 * Decompiled File: scripts\mp\agents\zombie_dlc3\zombie_dlc3_agent.gsc
 * Game: Call of Duty: Infinite Warfare
 * Platform: PC
 * Function Count: 11
 * Decompile Time: 576 ms
 * Timestamp: 10/27/2023 12:11:28 AM
*******************************************************************/

//Function Number: 1
registerscriptedagent()
{
	lib_0A02::init();
	behaviortree\zombie_dlc3::func_DEE8();
	scripts\asm\zombie_dlc3\mp\states::func_2371();
	level.agent_definition["generic_zombie"]["asm"] = "zombie_dlc3";
	level.agent_definition["generic_zombie"]["behaviorTree"] = "zombie_dlc3";
	level.agent_definition["generic_zombie"]["animclass"] = "zombie_dlc3_animclass";
	level.var_13BDC = 1;
	level.var_4878 = 0;
	level.var_BF7C = 0;
	level.var_BCCE = [];
	level.var_BCE5 = [];
	level.var_C082 = [];
	level.var_126E9 = [];
	level.var_8EE6 = [];
	level.var_5662 = [];
	level.var_D437 = "allies";
	scripts\mp\agents\zombie\zmb_zombie_agent::func_9890();
	scripts\mp\agents\zombie\zmb_zombie_agent::func_98A5();
	scripts\mp\agents\zombie\zmb_zombie_agent::func_97FB();
	scripts\mp\agents\zombie\zmb_zombie_agent::func_AEB0();
	thread func_FAB0();
	thread scripts\mp\agents\zombie\zmb_zombie_agent::func_BC5C();
}

//Function Number: 2
zombieinit_dlc()
{
	lib_0C75::func_13F9A();
}

//Function Number: 3
func_FAB0()
{
	level endon("game_ended");
	if(!isdefined(level.agent_definition))
	{
		level waittill("scripted_agents_initialized");
	}

	level.agent_definition["generic_zombie"]["setup_func"] = ::setupagent;
	level.agent_definition["generic_zombie"]["setup_model_func"] = ::func_FACE;
	level.agent_funcs["generic_zombie"]["gametype_on_killed"] = ::scripts\cp\maps\cp_town\cp_town_damage::cp_town_onzombiekilled;
	level.agent_funcs["generic_zombie"]["gametype_on_damage_finished"] = ::lib_0CBC::func_C5CE;
	level.agent_funcs["generic_zombie"]["on_damaged"] = ::scripts\cp\maps\cp_town\cp_town_damage::cp_town_onzombiedamaged;
	level.agent_funcs["generic_zombie"]["on_damaged_finished"] = ::func_C5CE;
	level.agent_funcs["generic_zombie"]["on_killed"] = ::func_C5D2;
	level.var_BCCE["generic_zombie"] = ::lib_0CBC::func_E7FD;
	level.soldier_models = ["zombie_dlc3_male_soldier_02","zombie_dlc3_male_soldier_03","zombie_dlc3_male_soldier_04"];
}

//Function Number: 4
setupagent()
{
	scripts\mp\agents\zombie\zmb_zombie_agent::setupagent();
	self.kung_fu_punched = 0;
	self.pinched = undefined;
}

//Function Number: 5
func_FACE(param_00)
{
	if(should_be_soldier())
	{
		self.is_soldier = 1;
		self.dontmutilate = 1;
		setup_solider_model();
		return;
	}

	self.is_soldier = undefined;
	scripts\mp\agents\zombie\zmb_zombie_agent::func_FACE();
}

//Function Number: 6
should_be_soldier()
{
	if(level.wave_num < 5)
	{
		return 0;
	}

	var_00 = randomint(100);
	if(var_00 < 15)
	{
		return 1;
	}

	return 0;
}

//Function Number: 7
setup_solider_model()
{
	var_00 = randomint(level.soldier_models.size);
	var_01 = level.soldier_models[var_00];
	self setmodel(var_01);
	thread scripts\mp\agents\zombie\zmb_zombie_agent::func_50EF();
}

//Function Number: 8
dopiranhatrapdeath()
{
	lib_0A1A::func_237C("piranha_trap");
}

//Function Number: 9
func_C5CE(param_00,param_01,param_02,param_03,param_04,param_05,param_06,param_07,param_08,param_09,param_0A,param_0B,param_0C)
{
	scripts\mp\agents\zombie\zmb_zombie_agent::func_C5CE(param_00,param_01,param_02,param_03,param_04,param_05,param_06,param_07,param_08,param_09,param_0A,param_0B,param_0C);
}

//Function Number: 10
func_C5D2(param_00,param_01,param_02,param_03,param_04,param_05,param_06,param_07,param_08)
{
	scripts\mp\agents\zombie\zmb_zombie_agent::func_C5D2(param_00,param_01,param_02,param_03,param_04,param_05,param_06,param_07,param_08);
}

//Function Number: 11
func_C4BD(param_00,param_01,param_02,param_03,param_04,param_05,param_06,param_07,param_08,param_09)
{
	scripts\mp\agents\zombie\zmb_zombie_agent::func_C4BD(param_00,param_01,param_02,param_03,param_04,param_05,param_06,param_07,param_08,param_09);
}