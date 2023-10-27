/*******************************************************************
 * Decompiled By: Bog
 * Decompiled File: scripts\mp\agents\alien_phantom\alien_phantom_agent.gsc
 * Game: Call of Duty: Infinite Warfare
 * Platform: PC
 * Function Count: 6
 * Decompile Time: 347 ms
 * Timestamp: 10/27/2023 12:11:05 AM
*******************************************************************/

//Function Number: 1
registerscriptedagent()
{
	scripts\mp\agents\alien_phantom\alien_phantom_tunedata::setuptunedata();
	lib_0A02::init();
	behaviortree\alien_goon::func_DEE8();
	scripts\asm\alien_goon\mp\states::func_2371();
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

	level.agent_definition["alien_phantom"]["setup_func"] = ::setupagent;
	level.agent_definition["alien_phantom"]["setup_model_func"] = ::func_FACE;
	level.agent_funcs["alien_phantom"]["on_damaged"] = ::scripts\mp\agents\alien_goon\alien_goon_agent::func_C4E0;
	level.agent_funcs["alien_phantom"]["gametype_on_damage_finished"] = ::lib_0CBC::func_C5CE;
	level.agent_funcs["alien_phantom"]["gametype_on_killed"] = ::scripts\cp\maps\cp_final\cp_final_damage::cp_final_onzombiekilled;
	level.agent_funcs["alien_phantom"]["on_damaged_finished"] = ::scripts\mp\agents\zombie\zmb_zombie_agent::func_C5CE;
	level.agent_funcs["alien_phantom"]["on_killed"] = ::onkilled;
	level.brute_loot_check = [];
	if(!isdefined(level.var_8CBD))
	{
		level.var_8CBD = [];
	}

	level.var_8CBD["alien_phantom"] = ::calculatealienphantomhealth;
	if(!isdefined(level.damage_feedback_overrride))
	{
		level.damage_feedback_overrride = [];
	}
}

//Function Number: 3
func_FACE(param_00)
{
	self setmodel("alien_brute");
}

//Function Number: 4
setupagent()
{
	scripts\mp\agents\alien_goon\alien_goon_agent::setupagent();
	self.var_B601 = 67;
	self.preventplayerpushdist = 12;
	self.spawn_round_num = level.wave_num;
	self.var_9341 = 1;
}

//Function Number: 5
calculatealienphantomhealth()
{
	var_00 = scripts\mp\agents\alien_goon\alien_goon_agent::calculatealiengoonhealth();
	var_01 = scripts\asm\dlc4\dlc4_asm::gettunedata();
	if(level.players.size < 2)
	{
		var_00 = var_00 / 2;
	}

	return var_00 * var_01.goon_health_multiplier;
}

//Function Number: 6
onkilled(param_00,param_01,param_02,param_03,param_04,param_05,param_06,param_07,param_08)
{
	if(!isdefined(level.no_loot_drop) || !level.no_loot_drop)
	{
		var_09 = scripts\common\utility::random(["ammo_max","instakill_30","cash_2","instakill_30","cash_2","instakill_30","cash_2"]);
		if(isdefined(var_09) && !isdefined(self.var_72AC))
		{
			if(!isdefined(level.brute_loot_check[self.spawn_round_num]))
			{
				level.brute_loot_check[self.spawn_round_num] = 1;
				level thread scripts\cp\zombies\_powerups::drop_loot(self.origin,param_01,var_09,undefined,undefined,1);
			}
		}

		var_0A = 400;
		foreach(var_0C in level.players)
		{
			if(var_0C scripts\cp\_utility::is_valid_player())
			{
				var_0C scripts\cp\_persistence::func_82F9(var_0A);
			}
		}
	}

	if(self method_85B8())
	{
		level.totalphantomsjumping--;
		if(level.totalphantomsjumping <= 0)
		{
			level.totalphantomsjumping = 0;
		}
	}

	scripts\mp\agents\zombie\zmb_zombie_agent::func_C5D2(param_00,param_01,param_02,param_03,param_04,param_05,param_06,param_07,param_08);
}