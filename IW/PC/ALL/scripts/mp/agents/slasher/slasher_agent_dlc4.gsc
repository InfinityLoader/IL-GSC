/*******************************************************************
 * Decompiled By: Bog
 * Decompiled File: scripts\mp\agents\slasher\slasher_agent_dlc4.gsc
 * Game: Call of Duty: Infinite Warfare
 * Platform: PC
 * Function Count: 6
 * Decompile Time: 325 ms
 * Timestamp: 10/27/2023 12:11:24 AM
*******************************************************************/

//Function Number: 1
registerscriptedagent()
{
	lib_0A02::init();
	behaviortree\slasher::func_DEE8();
	scripts\asm\slasher_dlc4\mp\states::func_2371();
	scripts\mp\agents\slasher\slasher_tunedata::setuptunedata();
	thread func_FAB0();
}

//Function Number: 2
func_FAB0()
{
	scripts\mp\agents\slasher\slasher_agent::func_FAB0();
	level.agent_funcs["slasher"]["on_damaged"] = ::onslasherdamaged;
	level.agent_funcs["slasher"]["on_killed"] = ::onslasherkilled;
	level.agent_definition["slasher"]["setup_func"] = ::setup_slasher_dlc4_agent;
	if(!isdefined(level.damage_feedback_overrride))
	{
		level.damage_feedback_overrride = [];
	}

	level.damage_feedback_overrride["slasher"] = ::scripts\cp\maps\cp_final\cp_final_damage::slasher_processdamagefeedback;
	if(!isdefined(level.var_8CBD))
	{
		level.var_8CBD = [];
	}

	level.var_8CBD["slasher"] = ::calculateslasherhealth;
}

//Function Number: 3
setup_slasher_dlc4_agent()
{
	scripts\mp\agents\slasher\slasher_agent::setupagent();
	self.spawn_round_num = level.wave_num;
	self.not_affected_by_traps = 1;
}

//Function Number: 4
calculateslasherhealth()
{
	return 30000;
}

//Function Number: 5
onslasherdamaged(param_00,param_01,param_02,param_03,param_04,param_05,param_06,param_07,param_08,param_09,param_0A,param_0B)
{
	var_0C = param_02;
	param_02 = min(param_02,300);
	if(isdefined(self.nodamagescale))
	{
		param_02 = var_0C;
	}

	scripts\cp\maps\cp_final\cp_final_damage::cp_final_onzombiedamaged(param_00,param_01,param_02,param_03,param_04,param_05,param_06,param_07,param_08,param_09,param_0A,param_0B);
}

//Function Number: 6
onslasherkilled(param_00,param_01,param_02,param_03,param_04,param_05,param_06,param_07,param_08)
{
	self detach("weapon_zmb_slasher_vm","tag_weapon_right");
	self.nocorpse = 1;
	if(isdefined(level.slasher_loot_func))
	{
		self [[ level.slasher_loot_func ]](param_00,param_01,param_02,param_03,param_04,param_05,param_06,param_07,param_08);
	}

	var_09 = 1000;
	foreach(var_0B in level.players)
	{
		if(var_0B scripts\cp\_utility::is_valid_player())
		{
			var_0B scripts\cp\_persistence::func_82F9(var_09);
		}
	}

	scripts\mp\_mp_agent::func_5006(param_00,param_01,param_02,param_03,param_04,param_05,param_06,param_07,param_08);
}