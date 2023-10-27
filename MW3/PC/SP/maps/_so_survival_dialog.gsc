/*******************************************************************
 * Decompiled By: Bog
 * Decompiled File: maps\_so_survival_dialog.gsc
 * Game: Call of Duty: Modern Warfare 3
 * Platform: PC
 * Function Count: 14
 * Decompile Time: 235 ms
 * Timestamp: 10/27/2023 2:21:28 AM
*******************************************************************/

//Function Number: 1
survival_dialog_init()
{
	if(getdvarint("survival_chaos") == 1)
	{
		chaos_dialog_radio_setup();
	}
	else
	{
		survival_dialog_radio_setup();
	}

	thread survival_dialog_wave_start();
	thread survival_dialog_boss();
	thread survival_dialog_wave_end();
	thread survival_dialog_airsupport();
	thread survival_dialog_claymore_plant();
	thread survival_dialog_sentry_updates();
}

//Function Number: 2
survival_dialog_wave_start()
{
	level endon("special_op_terminated");
	var_00 = [];
	for(;;)
	{
		level waittill("wave_started",var_01);
		var_02 = level common_scripts\utility::waittill_any_timeout(1.5,"wave_ended");
		if(var_02 == "wave_ended")
		{
			continue;
		}

		if(var_01 == 1)
		{
			if(maps\_utility::is_coop())
			{
				maps\_utility::radio_dialogue("so_hq_mission_intro");
			}
			else
			{
				maps\_utility::radio_dialogue("so_hq_mission_intro_sp");
			}

			continue;
		}

		var_03 = dialog_get_special_ai_type(var_01,var_00);
		if(isdefined(var_03) && var_03 != "")
		{
			if(!isdefined(var_00[var_03]))
			{
				var_00[var_03] = 1;
			}
			else
			{
				var_00[var_03]++;
			}
		}
		else
		{
			var_03 = maps\_so_survival_ai::get_squad_type(var_01);
		}

		if(isdefined(var_03) && var_03 != "")
		{
			if(isdefined(level.scr_radio["so_hq_enemy_intel_" + var_03]))
			{
				maps\_utility::radio_dialogue("so_hq_enemy_intel_" + var_03);
			}
		}
	}
}

//Function Number: 3
dialog_get_special_ai_type(param_00,param_01)
{
	var_02 = maps\_so_survival_ai::get_special_ai(param_00);
	if(!isdefined(var_02) || !var_02.size)
	{
		return undefined;
	}

	foreach(var_04 in var_02)
	{
		if(!isdefined(param_01[var_04]))
		{
			param_01[var_04] = 0;
		}
	}

	var_06 = "";
	var_07 = 0;
	foreach(var_0A, var_09 in param_01)
	{
		if(maps\_utility::array_contains(var_02,var_0A) && var_06 == "" || var_09 < var_07)
		{
			var_06 = var_0A;
			var_07 = var_09;
		}
	}

	return var_06;
}

//Function Number: 4
survival_dialog_boss()
{
	level endon("special_op_terminated");
	for(;;)
	{
		var_00 = 0;
		level waittill("boss_spawning",var_01);
		var_02 = maps\_so_survival_ai::get_bosses_ai(var_01);
		var_03 = maps\_so_survival_ai::get_bosses_nonai(var_01);
		if(isdefined(var_03) && var_03.size)
		{
			if(var_03.size == 1)
			{
				if(isdefined(level.scr_radio["so_hq_boss_intel_" + var_03[0]]))
				{
					maps\_utility::radio_dialogue("so_hq_boss_intel_" + var_03[0]);
					var_00 = 1;
				}
			}
			else if(isdefined(level.scr_radio["so_hq_boss_intel_" + var_03[0] + "_many"]))
			{
				maps\_utility::radio_dialogue("so_hq_boss_intel_" + var_03[0] + "_many");
				var_00 = 1;
			}
		}

		if(isdefined(var_02) && var_02.size)
		{
			if(var_00)
			{
				var_04 = level common_scripts\utility::waittill_any_timeout(1.5,"wave_ended");
				if(var_04 == "wave_ended")
				{
					continue;
				}
			}

			if(var_02.size == 1)
			{
				if(isdefined(level.scr_radio["so_hq_boss_intel_" + var_02[0]]))
				{
					maps\_utility::radio_dialogue("so_hq_boss_intel_" + var_02[0]);
				}

				continue;
			}

			if(isdefined(level.scr_radio["so_hq_enemy_intel_boss_transport_many"]))
			{
				maps\_utility::radio_dialogue("so_hq_enemy_intel_boss_transport_many");
			}
		}
	}
}

//Function Number: 5
survival_dialog_wave_end()
{
	level endon("special_op_terminated");
	for(;;)
	{
		level waittill("wave_ended",var_00);
		var_01 = level common_scripts\utility::waittill_any_timeout(1.5,"wave_started");
		if(var_01 == "wave_started")
		{
			continue;
		}

		var_02 = "";
		if(isdefined(level.armory_unlock))
		{
			if(isdefined(level.armory_unlock["weapon"]) && level.armory_unlock["weapon"] == var_00)
			{
				var_02 = "weapon";
			}
			else if(isdefined(level.armory_unlock["equipment"]) && level.armory_unlock["equipment"] == var_00)
			{
				var_02 = "equipment";
			}
			else if(isdefined(level.armory_unlock["airsupport"]) && level.armory_unlock["airsupport"] == var_00)
			{
				var_02 = "airsupport";
			}
		}

		if(var_02 != "" && isdefined(level.scr_radio["so_hq_armory_open_" + var_02]))
		{
			maps\_utility::radio_dialogue("so_hq_armory_open_" + var_02);
			continue;
		}

		maps\_utility::radio_dialogue("so_hq_wave_over_flavor");
	}
}

//Function Number: 6
survival_dialog_airsupport()
{
	level endon("special_op_terminated");
	for(;;)
	{
		level waittill("so_airsupport_incoming",var_00);
		if(isdefined(level.scr_radio["so_hq_as_" + var_00]))
		{
			maps\_utility::radio_dialogue("so_hq_as_" + var_00);
		}
	}
}

//Function Number: 7
survival_dialog_claymore_plant()
{
	level endon("special_op_terminated");
	for(;;)
	{
		var_00 = level common_scripts\utility::waittill_any_return("ai_claymore_planted","ai_chembomb_planted");
		if(var_00 == "ai_claymore_planted")
		{
			if(isdefined(level.scr_radio["so_hq_enemy_update_claymore"]))
			{
				maps\_utility::radio_dialogue("so_hq_enemy_update_claymore");
			}
		}
		else if(var_00 == "ai_chembomb_planted")
		{
		}

		level waittill("wave_ended");
	}
}

//Function Number: 8
survival_dialog_armory_restocked(param_00)
{
	if(param_00 != "" && isdefined(level.scr_radio["so_hq_armory_stocked_" + param_00]))
	{
		maps\_utility::radio_dialogue("so_hq_armory_stocked_" + param_00);
	}
}

//Function Number: 9
survival_dialog_sentry_updates()
{
	level endon("special_op_terminated");
	var_00 = "";
	for(;;)
	{
		var_01 = level common_scripts\utility::waittill_any_return("a_sentry_died","a_sentry_is_underattack","wave_ended");
		if(var_01 == "wave_ended")
		{
			var_00 = "";
		}
		else if(var_01 == "a_sentry_is_underattack" && var_00 != "a_sentry_is_underattack")
		{
			thread survival_dialog_radio_sentry_underattack();
		}
		else if(var_01 == "a_sentry_died")
		{
			thread survival_dialog_radio_sentry_down();
		}

		var_00 = var_01;
	}
}

//Function Number: 10
survival_dialog_radio_sentry_down()
{
	if(isdefined(level.scr_radio["so_hq_sentry_down"]))
	{
		maps\_utility::radio_dialogue("so_hq_sentry_down");
	}
}

//Function Number: 11
survival_dialog_radio_sentry_underattack()
{
	if(isdefined(level.scr_radio["so_hq_sentry_underattack"]))
	{
		maps\_utility::radio_dialogue("so_hq_sentry_underattack");
	}
}

//Function Number: 12
survival_dialog_player_down()
{
	level endon("special_op_terminated");
	for(;;)
	{
		level waittill("so_player_down");
		if(isdefined(level.scr_radio["so_hq_player_down"]))
		{
			maps\_utility::radio_dialogue("so_hq_player_down");
		}
	}
}

//Function Number: 13
survival_dialog_radio_setup()
{
	level.scr_radio["so_hq_mission_intro"] = "so_hq_mission_intro";
	level.scr_radio["so_hq_mission_intro_sp"] = "so_hq_mission_intro_sp";
	level.scr_radio["so_hq_enemy_intel_easy"] = "so_hq_enemy_intel_generic";
	level.scr_radio["so_hq_enemy_intel_regular"] = "so_hq_enemy_intel_generic";
	level.scr_radio["so_hq_enemy_intel_hardened"] = "so_hq_enemy_intel_generic";
	level.scr_radio["so_hq_enemy_intel_veteran"] = "so_hq_enemy_intel_generic";
	level.scr_radio["so_hq_enemy_intel_elite"] = "so_hq_enemy_intel_generic";
	level.scr_radio["so_hq_enemy_intel_claymore"] = "so_hq_enemy_intel_generic";
	level.scr_radio["so_hq_enemy_intel_martyrdom"] = "so_hq_enemy_intel_martyrdom";
	level.scr_radio["so_hq_enemy_intel_chemical"] = "so_hq_enemy_intel_chemical";
	level.scr_radio["so_hq_enemy_intel_dog_splode"] = "so_hq_enemy_intel_dog_splode";
	level.scr_radio["so_hq_enemy_intel_dog_reg"] = "so_hq_enemy_intel_dog_reg";
	level.scr_radio["so_hq_armory_open_weapon"] = "so_hq_armory_open_weapon";
	level.scr_radio["so_hq_armory_open_equipment"] = "so_hq_armory_open_equipment";
	level.scr_radio["so_hq_armory_open_airsupport"] = "so_hq_armory_open_airstrike";
	level.scr_radio["so_hq_armory_stocked_all"] = "so_hq_armory_stocked_all";
	level.scr_radio["so_hq_armory_stocked_equipment"] = "so_hq_armory_stocked_equipment";
	level.scr_radio["so_hq_wave_over_flavor"] = "so_hq_wave_over_flavor";
	level.scr_radio["so_hq_enemy_update_claymore"] = "so_hq_enemy_update_claymore";
	level.scr_radio["so_hq_sentry_down"] = "so_hq_sentry_down";
	level.scr_radio["so_hq_sentry_underattack"] = "so_hq_sentry_underattack";
	level.scr_radio["so_hq_player_down"] = "so_hq_player_down";
	level.scr_radio["so_hq_boss_intel_jug_regular"] = "so_hq_enemy_intel_boss_transport";
	level.scr_radio["so_hq_boss_intel_jug_riotshield"] = "so_hq_enemy_intel_boss_transport";
	level.scr_radio["so_hq_boss_intel_jug_explosive"] = "so_hq_enemy_intel_boss_transport";
	level.scr_radio["so_hq_boss_intel_jug_headshot"] = "so_hq_enemy_intel_boss_transport";
	level.scr_radio["so_hq_boss_intel_jug_minigun"] = "so_hq_enemy_intel_boss_transport";
	level.scr_radio["so_hq_enemy_intel_boss_transport_many"] = "so_hq_enemy_intel_boss_transport_many";
	level.scr_radio["so_hq_boss_intel_chopper"] = "so_hq_boss_intel_chopper";
	level.scr_radio["so_hq_boss_intel_chopper_many"] = "so_hq_boss_intel_chopper_many";
	level.scr_radio["so_hq_as_friendly_support_delta"] = "so_hq_airsupport_ally_delta";
	level.scr_radio["so_hq_as_friendly_support_riotshield"] = "so_hq_airsupport_ally_riotshield";
	level.scr_radio["so_hq_uav_busy"] = "so_hq_uav_busy";
}

//Function Number: 14
chaos_dialog_radio_setup()
{
	level.scr_radio["so_tf_1_success_generic"] = "cm_tf_1_success_generic";
	level.scr_radio["so_tf_1_success_jerk"] = "cm_tf_1_success_jerk";
	level.scr_radio["so_tf_1_success_best"] = "cm_tf_1_success_best";
	level.scr_radio["so_tf_1_fail_bleedout"] = "cm_tf_1_fail_bleedout";
	level.scr_radio["so_tf_1_fail_generic"] = "cm_tf_1_fail_generic";
	level.scr_radio["so_tf_1_fail_generic_jerk"] = "cm_tf_1_fail_generic_jerk";
	level.scr_radio["so_tf_1_fail_time"] = "cm_tf_1_fail_time";
	level.scr_radio["so_hq_mission_intro"] = "cm_bp_mission_intro_coop";
	level.scr_radio["so_hq_mission_intro_sp"] = "cm_bp_mission_intro";
	level.scr_radio["so_hq_enemy_intel_easy"] = "so_hq_enemy_intel_generic";
	level.scr_radio["so_hq_enemy_intel_regular"] = "so_hq_enemy_intel_generic";
	level.scr_radio["so_hq_enemy_intel_hardened"] = "so_hq_enemy_intel_generic";
	level.scr_radio["so_hq_enemy_intel_veteran"] = "so_hq_enemy_intel_generic";
	level.scr_radio["so_hq_enemy_intel_elite"] = "so_hq_enemy_intel_generic";
	level.scr_radio["so_hq_enemy_intel_claymore"] = "so_hq_enemy_intel_generic";
	level.scr_radio["so_hq_enemy_intel_martyrdom"] = "so_hq_enemy_intel_martyrdom";
	level.scr_radio["so_hq_enemy_intel_chemical"] = "so_hq_enemy_intel_chemical";
	level.scr_radio["so_hq_enemy_intel_chemical"] = "";
	level.scr_radio["so_hq_enemy_intel_dog"] = "cm_bp_enemy_dog";
	level.scr_radio["so_hq_enemy_intel_dogs"] = "cm_bp_enemy_dogs";
	level.scr_radio["so_hq_wave_over_flavor"] = "so_hq_wave_over_flavor";
	level.scr_radio["so_hq_player_down"] = "so_hq_player_down";
	level.scr_radio["so_hq_boss_intel_jug_regular"] = "cm_bp_enemy_juggernaut";
	level.scr_radio["so_hq_boss_intel_jug_riotshield"] = "cm_bp_enemy_juggernaut";
	level.scr_radio["so_hq_boss_intel_jug_explosive"] = "cm_bp_enemy_juggernaut";
	level.scr_radio["so_hq_boss_intel_jug_headshot"] = "cm_bp_enemy_juggernaut";
	level.scr_radio["so_hq_boss_intel_jug_minigun"] = "cm_bp_enemy_juggernaut";
	level.scr_radio["so_hq_enemy_intel_boss_transport_many"] = "cm_bp_enemy_juggernauts";
	level.scr_radio["so_hq_boss_intel_chopper"] = "cm_bp_boss_intel_chopper";
	level.scr_radio["so_hq_boss_intel_chopper_many"] = "cm_bp_boss_intel_chopper_many";
	level.scr_radio["so_hq_uav_busy"] = "so_hq_uav_busy";
	level.scr_radio["chaos_perk_stalker"] = "cm_bp_perk_stalker";
	level.scr_radio["chaos_perk_excond"] = "cm_bp_perk_excond";
	level.scr_radio["chaos_perk_sleight"] = "cm_bp_perk_sleight";
	level.scr_radio["chaos_perk_quickdraw"] = "cm_bp_perk_quickdraw";
	level.scr_radio["chaos_perk_steadyaim"] = "cm_bp_perk_steadyaim";
	level.scr_radio["chaos_perk_regeneration"] = "cm_bp_perk_regeneration";
	level.scr_radio["chaos_perk_juiced"] = "cm_bp_perk_juiced";
	level.scr_radio["chaos_deliverd_socre"] = "cm_bp_2cp_bonus";
	level.scr_radio["chaos_deliverd_sentry"] = "cm_bp_2cp_sentrygun";
	level.scr_radio["chaos_deliverd_laststand"] = "cm_bp_2cp_laststand";
	level.scr_radio["chaos_deliverd_combomult"] = "cm_bp_2cp_combomult";
	level.scr_radio["chaos_deliverd_extratime"] = "cm_bp_2cp_extratime";
	level.scr_radio["chaos_deliverd_freeze"] = "cm_bp_2cp_freeze";
	level.scr_radio["chaos_time_almostup"] = "cm_bp_time_almostup";
	level.scr_radio["chaos_10sec_left"] = "cm_bp_time_10seconds";
	level.scr_radio["chaos_30sec_left"] = "cm_bp_time_30seconds";
	level.scr_radio["chaos_overtime"] = "cm_bp_gen_overtime";
	level.scr_radio["chaos_keep_combo"] = "cm_bp_gen_maintaincombo";
	level.scr_radio["chaos_cp_inbound"] = "cm_bp_cp_inbound";
	level.scr_radio["chaos_cps_inbound"] = "cm_bp_cps_inbound";
	level.scr_radio["chaos_new_weapon"] = "cm_bp_gen_weapon";
	level.scr_radio["chaos_get_onekill"] = "cm_bp_laststand_onekill";
	level.scr_radio["chaos_2_last_stand"] = "cm_bp_laststand_2remaining";
	level.scr_radio["chaos_1_last_stand"] = "cm_bp_laststand_finalstand";
	level.scr_radio["chaos_pickup_sentry"] = "cm_bp_cp_sentrygun";
	level.scr_radio["chaos_pickup_armor"] = "cm_bp_jugkill_armor";
	level.scr_radio["chaos_pickup_multiplier"] = "cm_bp_cp_combomult";
	level.scr_radio["chaos_pickup_laststand"] = "cm_bp_cp_laststand";
	level.scr_radio["chaos_pickup_time"] = "cm_bp_cp_extratime";
	level.scr_radio["chaos_pickup_points"] = "cm_bp_cp_bonus";
	level.scr_radio["chaos_pickup_freeze"] = "cm_bp_cp_freeze";
	level.scr_radio["chaos_action_explosion"] = "cm_bp_kills_explosion";
	level.scr_radio["chaos_action_3longshot"] = "cm_bp_kills_3longshot";
	level.scr_radio["chaos_action_3headshot"] = "cm_bp_kills_3headshot";
	level.scr_radio["chaos_action_3knife"] = "cm_bp_kills_3knife";
	level.scr_radio["chaos_action_triple"] = "cm_bp_kills_triple";
	level.scr_radio["chaos_action_quad"] = "cm_bp_kills_quad";
	level.scr_radio["chaos_action_multiple"] = "cm_bp_kills_multiple";
}