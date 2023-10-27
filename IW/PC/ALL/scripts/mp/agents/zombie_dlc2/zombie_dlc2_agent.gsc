/*******************************************************************
 * Decompiled By: Bog
 * Decompiled File: scripts\mp\agents\zombie_dlc2\zombie_dlc2_agent.gsc
 * Game: Call of Duty: Infinite Warfare
 * Platform: PC
 * Function Count: 9
 * Decompile Time: 495 ms
 * Timestamp: 10/27/2023 12:11:27 AM
*******************************************************************/

//Function Number: 1
registerscriptedagent()
{
	lib_0A02::init();
	behaviortree\zombie_dlc2::func_DEE8();
	scripts\asm\zombie_dlc2\mp\states::func_2371();
	level.agent_definition["generic_zombie"]["asm"] = "zombie_dlc2";
	level.agent_definition["generic_zombie"]["behaviorTree"] = "zombie_dlc2";
	level.agent_definition["generic_zombie"]["animclass"] = "zombie_dlc2_animclass";
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
zombieinit_dlc2()
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
	level.agent_funcs["generic_zombie"]["gametype_on_killed"] = ::scripts\cp\maps\cp_disco\cp_disco_damage::cp_disco_onzombiekilled;
	level.var_BCCE["generic_zombie"] = ::lib_0CBC::func_E7FD;
	level.agent_funcs["generic_zombie"]["on_damaged"] = ::scripts\cp\maps\cp_disco\cp_disco_damage::cp_disco_onzombiedamaged;
	level.agent_funcs["generic_zombie"]["on_damaged_finished"] = ::scripts\mp\agents\zombie\zmb_zombie_agent::func_C5CE;
	level.agent_funcs["generic_zombie"]["on_killed"] = ::func_C5D2;
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
	scripts\mp\agents\zombie\zmb_zombie_agent::func_FACE();
}

//Function Number: 6
dopiranhatrapdeath()
{
	lib_0A1A::func_237C("piranha_trap");
}

//Function Number: 7
func_C5CE(param_00,param_01,param_02,param_03,param_04,param_05,param_06,param_07,param_08,param_09,param_0A,param_0B,param_0C)
{
	scripts\mp\agents\zombie\zmb_zombie_agent::func_C5CE(param_00,param_01,param_02,param_03,param_04,param_05,param_06,param_07,param_08,param_09,param_0A,param_0B,param_0C);
}

//Function Number: 8
func_C5D2(param_00,param_01,param_02,param_03,param_04,param_05,param_06,param_07,param_08)
{
	scripts\mp\agents\zombie\zmb_zombie_agent::func_C5D2(param_00,param_01,param_02,param_03,param_04,param_05,param_06,param_07,param_08);
}

//Function Number: 9
func_C4BD(param_00,param_01,param_02,param_03,param_04,param_05,param_06,param_07,param_08,param_09)
{
	scripts\mp\agents\zombie\zmb_zombie_agent::func_C4BD(param_00,param_01,param_02,param_03,param_04,param_05,param_06,param_07,param_08,param_09);
}