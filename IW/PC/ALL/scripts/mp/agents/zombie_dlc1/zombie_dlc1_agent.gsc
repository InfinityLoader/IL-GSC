/*******************************************************************
 * Decompiled By: Bog
 * Decompiled File: scripts\mp\agents\zombie_dlc1\zombie_dlc1_agent.gsc
 * Game: Call of Duty: Infinite Warfare
 * Platform: PC
 * Function Count: 9
 * Decompile Time: 482 ms
 * Timestamp: 10/27/2023 12:11:26 AM
*******************************************************************/

//Function Number: 1
registerscriptedagent()
{
	lib_0A02::init();
	behaviortree\zombie_dlc1::func_DEE8();
	scripts\asm\zombie_dlc1\mp\states::func_2371();
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
zombieinit_dlc1()
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
	level.var_BCCE["generic_zombie"] = ::lib_0CBC::func_E7FD;
	level.agent_funcs["generic_zombie"]["on_damaged_finished"] = ::func_C5CE;
	level.agent_funcs["generic_zombie"]["on_killed"] = ::func_C5D2;
}

//Function Number: 4
setupagent()
{
	scripts\mp\agents\zombie\zmb_zombie_agent::setupagent();
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
	if(isdefined(self.balloon_in_hand))
	{
		self.balloon_in_hand delete();
		self.balloon_in_hand = undefined;
	}

	if(isdefined(self.bholdingballooninleft) && isdefined(self.balloon_model))
	{
		if(self.bholdingballooninleft)
		{
			self detach(self.balloon_model,"tag_accessory_left");
		}
		else
		{
			self detach(self.balloon_model,"tag_accessory_right");
		}
	}

	self.bholdingballooninleft = undefined;
	self.balloon_model = undefined;
	scripts\mp\agents\zombie\zmb_zombie_agent::func_C5D2(param_00,param_01,param_02,param_03,param_04,param_05,param_06,param_07,param_08);
}

//Function Number: 9
func_C4BD(param_00,param_01,param_02,param_03,param_04,param_05,param_06,param_07,param_08,param_09)
{
	scripts\mp\agents\zombie\zmb_zombie_agent::func_C4BD(param_00,param_01,param_02,param_03,param_04,param_05,param_06,param_07,param_08,param_09);
}