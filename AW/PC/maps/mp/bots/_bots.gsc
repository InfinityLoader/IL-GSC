/*******************************************************************
 * Decompiled By: Bog
 * Decompiled File: mp\bots\_bots.gsc
 * Game: Call of Duty: Advanced Warfare
 * Platform: PC
 * Function Count: 111
 * Decompile Time: 1665 ms
 * Timestamp: 4/22/2024 2:08:32 AM
*******************************************************************/

//Function Number: 1
main()
{
	if(isdefined(level.createfx_enabled) && level.createfx_enabled)
	{
		return;
	}

	if(level.script == "mp_character_room")
	{
		return;
	}

	if(getdvarint("virtualLobbyActive") == 1)
	{
		return;
	}

	setup_callbacks();
	maps\mp\bots\_bots_personality::setup_personalities();
	level.badplace_cylinder_func = ::badplace_cylinder;
	level.badplace_delete_func = ::badplace_delete;
	if(isdefined(level.bot_killstreak_setup_func))
	{
		[[ level.bot_killstreak_setup_func ]]();
	}
	else
	{
		maps\mp\bots\_bots_ks::bot_killstreak_setup();
	}

	maps\mp\bots\_bots_loadout::init();
	level thread init();
}

//Function Number: 2
setup_callbacks()
{
	level.bot_funcs = [];
	level.bot_funcs["bots_spawn"] = ::spawn_bots;
	level.bot_funcs["bots_add_scavenger_bag"] = ::bot_add_scavenger_bag;
	level.bot_funcs["bots_add_to_level_targets"] = ::maps\mp\bots\_bots_util::bot_add_to_bot_level_targets;
	level.bot_funcs["bots_remove_from_level_targets"] = ::maps\mp\bots\_bots_util::bot_remove_from_bot_level_targets;
	level.bot_funcs["bots_make_entity_sentient"] = ::bot_make_entity_sentient;
	level.bot_funcs["think"] = ::bot_think;
	level.bot_funcs["on_killed"] = ::on_bot_killed;
	level.bot_funcs["should_do_killcam"] = ::bot_should_do_killcam;
	level.bot_funcs["get_attacker_ent"] = ::maps\mp\bots\_bots_util::bot_get_known_attacker;
	level.bot_funcs["should_pickup_weapons"] = ::bot_should_pickup_weapons;
	level.bot_funcs["on_damaged"] = ::bot_damage_callback;
	level.bot_funcs["gametype_think"] = ::default_gametype_think;
	level.bot_funcs["leader_dialog"] = ::maps\mp\bots\_bots_util::bot_leader_dialog;
	level.bot_funcs["player_spawned"] = ::bot_player_spawned;
	level.bot_funcs["should_start_cautious_approach"] = ::maps\mp\bots\_bots_strategy::should_start_cautious_approach_default;
	level.bot_funcs["know_enemies_on_start"] = ::bot_know_enemies_on_start;
	level.bot_funcs["bot_get_rank_xp_and_prestige"] = ::bot_get_rank_xp_and_prestige;
	level.bot_funcs["ai_3d_sighting_model"] = ::bot_3d_sighting_model;
	level.bot_funcs["dropped_weapon_think"] = ::bot_think_seek_dropped_weapons;
	level.bot_funcs["dropped_weapon_cancel"] = ::should_stop_seeking_weapon;
	level.bot_funcs["crate_can_use"] = ::crate_can_use_always;
	level.bot_funcs["crate_low_ammo_check"] = ::crate_low_ammo_check;
	level.bot_funcs["crate_should_claim"] = ::crate_should_claim;
	level.bot_funcs["crate_wait_use"] = ::crate_wait_use;
	level.bot_funcs["crate_in_range"] = ::crate_in_range;
	level.bot_funcs["post_teleport"] = ::bot_post_teleport;
	level.bot_random_path_function = [];
	level.bot_random_path_function["allies"] = ::maps\mp\bots\_bots_personality::bot_random_path_default;
	level.bot_random_path_function["axis"] = ::maps\mp\bots\_bots_personality::bot_random_path_default;
	level.bot_can_use_box_by_type["deployable_vest"] = ::bot_should_use_ballistic_vest_crate;
	level.bot_can_use_box_by_type["deployable_ammo"] = ::bot_should_use_ammo_crate;
	level.bot_can_use_box_by_type["scavenger_bag"] = ::bot_should_use_scavenger_bag;
	level.bot_can_use_box_by_type["deployable_grenades"] = ::bot_should_use_grenade_crate;
	level.bot_can_use_box_by_type["deployable_juicebox"] = ::bot_should_use_juicebox_crate;
	level.bot_pre_use_box_of_type["deployable_ammo"] = ::bot_pre_use_ammo_crate;
	level.bot_post_use_box_of_type["deployable_ammo"] = ::bot_post_use_ammo_crate;
	level.bot_find_defend_node_func["capture"] = ::maps\mp\bots\_bots_strategy::find_defend_node_capture;
	level.bot_find_defend_node_func["capture_zone"] = ::maps\mp\bots\_bots_strategy::find_defend_node_capture_zone;
	level.bot_find_defend_node_func["protect"] = ::maps\mp\bots\_bots_strategy::find_defend_node_protect;
	level.bot_find_defend_node_func["bodyguard"] = ::maps\mp\bots\_bots_strategy::find_defend_node_bodyguard;
	level.bot_find_defend_node_func["patrol"] = ::maps\mp\bots\_bots_strategy::find_defend_node_patrol;
	maps\mp\bots\_bots_gametype_war::setup_callbacks();
}

//Function Number: 3
codecallback_leaderdialog(param_00,param_01)
{
	if(isdefined(level.bot_funcs) && isdefined(level.bot_funcs["leader_dialog"]))
	{
		self [[ level.bot_funcs["leader_dialog"] ]](param_00,param_01);
	}
}

//Function Number: 4
init()
{
	thread monitor_smoke_grenades();
	thread bot_triggers();
	initbotlevelvariables();
	if(!shouldspawnbots())
	{
		return;
	}

	refresh_existing_bots();
	var_00 = botautoconnectenabled();
	if(var_00 > 0)
	{
		setmatchdata("hasBots",1);
		level thread bot_connect_monitor();
		return;
	}

	level thread bot_monitor_team_limits();
}

//Function Number: 5
initbotlevelvariables()
{
	if(!isdefined(level.crateownerusetime))
	{
		level.crateownerusetime = 500;
	}

	if(!isdefined(level.cratenonownerusetime))
	{
		level.cratenonownerusetime = 3000;
	}

	level.bot_out_of_combat_time = 3000;
	level.bot_respawn_launcher_name["recruit"] = "iw5_maaws";
	level.bot_respawn_launcher_name["regular"] = "iw5_stingerm7";
	level.bot_respawn_launcher_name["hardened"] = "iw5_stingerm7";
	level.bot_respawn_launcher_name["veteran"] = "iw5_stingerm7";
	level.bot_fallback_weapon = "iw5_combatknife";
	level.zonecount = getzonecount();
	initbotmapextents();
}

//Function Number: 6
initbotmapextents()
{
	if(isdefined(level.teleportgetactivenodesfunc))
	{
		var_00 = [[ level.teleportgetactivenodesfunc ]]();
	}
	else
	{
		var_00 = getallnodes();
	}

	level.bot_map_min_x = 0;
	level.bot_map_max_x = 0;
	level.bot_map_min_y = 0;
	level.bot_map_max_y = 0;
	level.bot_map_min_z = 0;
	level.bot_map_max_z = 0;
	if(var_00.size > 1)
	{
		level.bot_map_min_x = var_00[0].origin[0];
		level.bot_map_max_x = var_00[0].origin[0];
		level.bot_map_min_y = var_00[0].origin[1];
		level.bot_map_max_y = var_00[0].origin[1];
		level.bot_map_min_z = var_00[0].origin[2];
		level.bot_map_max_z = var_00[0].origin[2];
		for(var_01 = 1;var_01 < var_00.size;var_01++)
		{
			var_02 = var_00[var_01].origin;
			if(var_02[0] < level.bot_map_min_x)
			{
				level.bot_map_min_x = var_02[0];
			}

			if(var_02[0] > level.bot_map_max_x)
			{
				level.bot_map_max_x = var_02[0];
			}

			if(var_02[1] < level.bot_map_min_y)
			{
				level.bot_map_min_y = var_02[1];
			}

			if(var_02[1] > level.bot_map_max_y)
			{
				level.bot_map_max_y = var_02[1];
			}

			if(var_02[2] < level.bot_map_min_z)
			{
				level.bot_map_min_z = var_02[2];
			}

			if(var_02[2] > level.bot_map_max_z)
			{
				level.bot_map_max_z = var_02[2];
			}
		}
	}

	level.bot_map_center = (level.bot_map_min_x + level.bot_map_max_x / 2,level.bot_map_min_y + level.bot_map_max_y / 2,level.bot_map_min_z + level.bot_map_max_z / 2);
	level.bot_variables_initialized = 1;
}

//Function Number: 7
bot_post_teleport()
{
	level.bot_variables_initialized = undefined;
	level.bot_initialized_remote_vehicles = undefined;
	initbotmapextents();
	maps\mp\bots\_bots_ks_remote_vehicle::remote_vehicle_setup();
}

//Function Number: 8
shouldspawnbots()
{
	return 1;
}

//Function Number: 9
refresh_existing_bots()
{
	wait(1);
	foreach(var_01 in level.players)
	{
		if(isbot(var_01))
		{
			var_01.equipment_enabled = 1;
			var_01.bot_team = var_01.team;
			var_01.bot_spawned_before = 1;
			var_01 thread [[ level.bot_funcs["think"] ]]();
		}
	}
}

//Function Number: 10
bot_player_spawned()
{
	bot_set_loadout_class();
}

//Function Number: 11
bot_set_loadout_class()
{
	if(!isdefined(self.bot_class))
	{
		if(!bot_gametype_chooses_class())
		{
			while(!isdefined(level.bot_loadouts_initialized))
			{
				wait(0.05);
			}

			if(isdefined(self.override_class_function))
			{
				self.bot_class = [[ self.override_class_function ]]();
				return;
			}

			self.bot_class = maps\mp\bots\_bots_personality::bot_setup_callback_class();
			return;
		}

		self.bot_class = self.class;
	}
}

//Function Number: 12
watch_players_connecting()
{
	for(;;)
	{
		level waittill("connected",var_00);
		if(!isai(var_00) && level.players.size > 0)
		{
			level.players_waiting_to_join = common_scripts\utility::array_add(level.players_waiting_to_join,var_00);
			childthread bots_notify_on_spawn(var_00);
			childthread bots_notify_on_disconnect(var_00);
			childthread bots_remove_from_array_on_notify(var_00);
		}
	}
}

//Function Number: 13
bots_notify_on_spawn(param_00)
{
	param_00 endon("bots_human_disconnected");
	while(!common_scripts\utility::array_contains(level.players,param_00))
	{
		wait(0.05);
	}

	param_00 notify("bots_human_spawned");
}

//Function Number: 14
bots_notify_on_disconnect(param_00)
{
	param_00 endon("bots_human_spawned");
	param_00 waittill("disconnect");
	param_00 notify("bots_human_disconnected");
}

//Function Number: 15
bots_remove_from_array_on_notify(param_00)
{
	param_00 common_scripts\utility::waittill_any("bots_human_spawned","bots_human_disconnected");
	level.players_waiting_to_join = common_scripts\utility::array_remove(level.players_waiting_to_join,param_00);
}

//Function Number: 16
monitor_pause_spawning()
{
	level.players_waiting_to_join = [];
	childthread watch_players_connecting();
	for(;;)
	{
		if(level.players_waiting_to_join.size > 0)
		{
			level.pausing_bot_connect_monitor = 1;
		}
		else
		{
			level.pausing_bot_connect_monitor = 0;
		}

		wait(0.5);
	}
}

//Function Number: 17
bot_can_join_team(param_00)
{
	if(maps\mp\_utility::matchmakinggame())
	{
		return 1;
	}

	if(!level.teambased)
	{
		return 1;
	}

	if(maps\mp\gametypes\_teams::getjointeampermissions(param_00))
	{
		return 1;
	}

	return 0;
}

//Function Number: 18
bot_allowed_to_switch_teams()
{
	if(isdefined(level.bots_disable_team_switching) && level.bots_disable_team_switching)
	{
		return 0;
	}

	if(isdefined(level.matchrules_switchteamdisabled) && level.matchrules_switchteamdisabled)
	{
		return 0;
	}

	return 1;
}

//Function Number: 19
bot_connect_monitor(param_00,param_01)
{
	level endon("game_ended");
	self notify("bot_connect_monitor");
	self endon("bot_connect_monitor");
	level.pausing_bot_connect_monitor = 0;
	childthread monitor_pause_spawning();
	maps\mp\gametypes\_hostmigration::waitlongdurationwithhostmigrationpause(0.5);
	var_02 = 1.5;
	if(!isdefined(level.bot_cm_spawned_bots))
	{
		level.bot_cm_spawned_bots = 0;
	}

	if(!isdefined(level.bot_cm_waited_players_time))
	{
		level.bot_cm_waited_players_time = 0;
	}

	if(!isdefined(level.bot_cm_human_picked))
	{
		level.bot_cm_human_picked = 0;
	}

	for(;;)
	{
		if(level.pausing_bot_connect_monitor)
		{
			maps\mp\gametypes\_hostmigration::waitlongdurationwithhostmigrationpause(var_02);
			continue;
		}

		var_03 = isdefined(level.bots_ignore_team_balance) || !level.teambased;
		var_04 = botgetteamlimit(0);
		var_05 = botgetteamlimit(1);
		var_06 = botgetteamdifficulty(0);
		var_07 = botgetteamdifficulty(1);
		var_0B = "allies";
		var_0C = "axis";
		var_0D = bot_client_counts();
		var_0E = cat_array_get(var_0D,"humans");
		if(var_0E > 1)
		{
			var_0F = bot_get_host_team();
			if(!maps\mp\_utility::matchmakinggame() && isdefined(var_0F) && var_0F != "spectator")
			{
				var_0B = var_0F;
				var_0C = maps\mp\_utility::getotherteam(var_0F);
			}
			else
			{
				var_10 = cat_array_get(var_0D,"humans_allies");
				var_11 = cat_array_get(var_0D,"humans_axis");
				if(var_11 > var_10)
				{
					var_0B = "axis";
					var_0C = "allies";
				}
			}
		}
		else
		{
			var_12 = get_human_player();
			if(isdefined(var_12))
			{
				var_13 = var_12 bot_get_player_team();
				if(isdefined(var_13) && var_13 != "spectator")
				{
					var_0B = var_13;
					var_0C = maps\mp\_utility::getotherteam(var_13);
				}
			}
		}

		var_14 = maps\mp\bots\_bots_util::bot_get_team_limit();
		var_15 = maps\mp\bots\_bots_util::bot_get_team_limit();
		var_16 = maps\mp\bots\_bots_util::bot_get_client_limit();
		if(var_14 + var_15 < var_16)
		{
			if(var_14 < var_04)
			{
				var_14++;
			}
			else if(var_15 < var_05)
			{
				var_15++;
			}
		}

		var_17 = cat_array_get(var_0D,"humans_" + var_0B);
		var_18 = cat_array_get(var_0D,"humans_" + var_0C);
		var_19 = var_17 + var_18;
		var_1A = cat_array_get(var_0D,"spectator");
		var_1B = 0;
		var_1C = 0;
		while(var_1A > 0)
		{
			var_1D = var_17 + var_1B + 1 <= var_14;
			var_1E = var_18 + var_1C + 1 <= var_15;
			if(var_1D && !var_1E)
			{
				var_1B++;
				continue;
			}

			if(!var_1D && var_1E)
			{
				var_1C++;
				continue;
			}

			if(var_1D && var_1E)
			{
				if(var_1A % 2 == 1)
				{
					var_1B++;
					continue;
				}

				var_1C++;
			}

			var_1A--;
		}

		var_1F = cat_array_get(var_0D,"bots_" + var_0B);
		var_20 = cat_array_get(var_0D,"bots_" + var_0C);
		var_21 = var_1F + var_20;
		if(var_21 > 0)
		{
			level.bot_cm_spawned_bots = 1;
		}

		var_22 = 0;
		if(!level.bot_cm_human_picked)
		{
			var_22 = !bot_get_human_picked_team();
			if(!var_22)
			{
				level.bot_cm_human_picked = 1;
			}
		}

		if(var_22)
		{
			var_23 = 0;
			var_24 = !var_03 && var_05 != var_04 && !level.bot_cm_spawned_bots && level.bot_cm_waited_players_time < 10 || !maps\mp\_utility::gameflag("prematch_done");
			var_25 = 0;
			if(var_23 || var_24 || var_25)
			{
				level.bot_cm_waited_players_time = level.bot_cm_waited_players_time + var_02;
				maps\mp\gametypes\_hostmigration::waitlongdurationwithhostmigrationpause(var_02);
				continue;
			}
		}

		var_26 = int(min(var_14 - var_17 - var_1B,var_04));
		var_27 = int(min(var_15 - var_18 - var_1C,var_05));
		var_28 = 1;
		var_29 = var_26 + var_27 + var_0E;
		var_2A = var_04 + var_05 + var_0E;
		var_2B = [-1,-1];
		while(var_29 < var_16 && var_29 < var_2A)
		{
			if(var_28 && var_26 < var_04 && bot_can_join_team(var_0B))
			{
				var_26++;
			}
			else if(!var_28 && var_27 < var_05 && bot_can_join_team(var_0C))
			{
				var_27++;
			}

			var_29 = var_26 + var_27 + var_0E;
			if(var_2B[var_28] == var_29)
			{
				break;
			}

			var_2B[var_28] = var_29;
			var_28 = !var_28;
		}

		level.bot_max_players_on_team[var_0B] = int(var_26 + var_17 + var_1B);
		level.bot_max_players_on_team[var_0C] = int(var_27 + var_18 + var_1C);
		update_max_players_from_team_agents();
		if(var_04 == var_05 && !var_03 && var_1B == 1 && var_1C == 0 && var_27 > 0)
		{
			if(!isdefined(level.bot_prematchdonetime) && maps\mp\_utility::gameflag("prematch_done"))
			{
				level.bot_prematchdonetime = gettime();
			}

			if(var_22 && !isdefined(level.bot_prematchdonetime) || gettime() - level.bot_prematchdonetime < 10000)
			{
				var_27--;
			}
		}

		var_2D = var_26 - var_1F;
		var_2E = var_27 - var_20;
		var_2F = 1;
		if(var_03)
		{
			var_30 = var_14 + var_15;
			var_31 = var_04 + var_05;
			var_32 = var_17 + var_18;
			var_33 = var_1F + var_20;
			var_34 = int(min(var_30 - var_32,var_31));
			var_35 = var_34 - var_33;
			if(var_35 == 0)
			{
				var_2F = 0;
			}
			else if(var_35 > 0)
			{
				var_2D = int(var_35 / 2) + var_35 % 2;
				var_2E = int(var_35 / 2);
			}
			else if(var_35 < 0)
			{
				var_36 = var_35 * -1;
				var_2D = -1 * int(min(var_36,var_1F));
				var_2E = -1 * var_36 + var_2D;
			}
		}
		else if(!maps\mp\_utility::matchmakinggame() && var_2D * var_2E < 0 && maps\mp\_utility::gameflag("prematch_done") && bot_allowed_to_switch_teams())
		{
			var_37 = int(min(abs(var_2D),abs(var_2E)));
			if(var_2D > 0)
			{
				move_bots_from_team_to_team(var_37,var_0C,var_0B,var_06);
			}
			else if(var_2E > 0)
			{
				move_bots_from_team_to_team(var_37,var_0B,var_0C,var_07);
			}

			var_2F = 0;
		}

		if(var_2F)
		{
			if(var_2E < 0)
			{
				drop_bots(var_2E * -1,var_0C);
			}

			if(var_2D < 0)
			{
				drop_bots(var_2D * -1,var_0B);
			}

			if(var_2E > 0)
			{
				level thread spawn_bots(var_2E,var_0C,undefined,undefined,"spawned_enemies",var_07);
			}

			if(var_2D > 0)
			{
				level thread spawn_bots(var_2D,var_0B,undefined,undefined,"spawned_allies",var_06);
			}

			if(var_2E > 0 && var_2D > 0)
			{
				level common_scripts\utility::waittill_multiple("spawned_enemies","spawned_allies");
			}
			else if(var_2E > 0)
			{
				level waittill("spawned_enemies");
			}
			else if(var_2D > 0)
			{
				level waittill("spawned_allies");
			}
		}

		if(var_07 != var_06)
		{
			bots_update_difficulty(var_0C,var_07);
			bots_update_difficulty(var_0B,var_06);
		}

		maps\mp\gametypes\_hostmigration::waitlongdurationwithhostmigrationpause(var_02);
	}
}

//Function Number: 20
bot_monitor_team_limits()
{
	level endon("game_ended");
	self notify("bot_monitor_team_limits");
	self endon("bot_monitor_team_limits");
	maps\mp\gametypes\_hostmigration::waitlongdurationwithhostmigrationpause(0.5);
	var_00 = 1.5;
	for(;;)
	{
		level.bot_max_players_on_team["allies"] = 0;
		level.bot_max_players_on_team["axis"] = 0;
		foreach(var_02 in level.players)
		{
			if(isdefined(var_02.team) && var_02.team == "allies" || var_02.team == "axis")
			{
				level.bot_max_players_on_team[var_02.team]++;
			}
		}

		update_max_players_from_team_agents();
		maps\mp\gametypes\_hostmigration::waitlongdurationwithhostmigrationpause(var_00);
	}
}

//Function Number: 21
update_max_players_from_team_agents()
{
	if(isdefined(level.agentarray))
	{
		foreach(var_01 in level.agentarray)
		{
			if(isdefined(var_01.isactive) && var_01.isactive)
			{
				if(maps\mp\_utility::isteamparticipant(var_01) && isdefined(var_01.team) && var_01.team == "allies" || var_01.team == "axis")
				{
					level.bot_max_players_on_team[var_01.team]++;
				}
			}
		}
	}
}

//Function Number: 22
bot_get_player_team()
{
	if(isdefined(self.team))
	{
		return self.team;
	}

	if(isdefined(self.pers["team"]))
	{
		return self.pers["team"];
	}

	return undefined;
}

//Function Number: 23
bot_get_host_team()
{
	foreach(var_01 in level.players)
	{
		if(!isai(var_01) && var_01 ishost())
		{
			return var_01 bot_get_player_team();
		}
	}

	return "spectator";
}

//Function Number: 24
bot_get_human_picked_team()
{
	var_00 = 0;
	var_01 = 0;
	var_02 = 0;
	foreach(var_04 in level.players)
	{
		if(!isai(var_04))
		{
			if(var_04 ishost())
			{
				var_00 = 1;
			}

			if(player_picked_team(var_04))
			{
				var_01 = 1;
				if(var_04 ishost())
				{
					var_02 = 1;
				}
			}
		}
	}

	return var_02 || var_01 && !var_00;
}

//Function Number: 25
player_picked_team(param_00)
{
	if(isdefined(param_00.team) && param_00.team != "spectator")
	{
		return 1;
	}

	if(isdefined(param_00.spectating_actively) && param_00.spectating_actively)
	{
		return 1;
	}

	if(param_00 ismlgspectator())
	{
		return 1;
	}

	return 0;
}

//Function Number: 26
bot_client_counts()
{
	var_00 = [];
	for(var_01 = 0;var_01 < level.players.size;var_01++)
	{
		var_02 = level.players[var_01];
		if(isdefined(var_02) && isdefined(var_02.team))
		{
			var_00 = cat_array_add(var_00,"all");
			var_00 = cat_array_add(var_00,var_02.team);
			if(isbot(var_02))
			{
				var_00 = cat_array_add(var_00,"bots");
				var_00 = cat_array_add(var_00,"bots_" + var_02.team);
				continue;
			}

			var_00 = cat_array_add(var_00,"humans");
			var_00 = cat_array_add(var_00,"humans_" + var_02.team);
		}
	}

	return var_00;
}

//Function Number: 27
cat_array_add(param_00,param_01)
{
	if(!isdefined(param_00))
	{
		param_00 = [];
	}

	if(!isdefined(param_00[param_01]))
	{
		param_00[param_01] = 0;
	}

	param_00[param_01] = param_00[param_01] + 1;
	return param_00;
}

//Function Number: 28
cat_array_get(param_00,param_01)
{
	if(!isdefined(param_00))
	{
		return 0;
	}

	if(!isdefined(param_00[param_01]))
	{
		return 0;
	}

	return param_00[param_01];
}

//Function Number: 29
move_bots_from_team_to_team(param_00,param_01,param_02,param_03)
{
	foreach(var_05 in level.players)
	{
		if(!isdefined(var_05.team))
		{
			continue;
		}

		if(isdefined(var_05.connected) && var_05.connected && isbot(var_05) && var_05.team == param_01)
		{
			var_05.bot_team = param_02;
			if(isdefined(param_03))
			{
				var_05 maps\mp\bots\_bots_util::bot_set_difficulty(param_03);
			}

			var_05 notify("luinotifyserver","team_select",bot_lui_convert_team_to_int(param_02));
			wait(0.05);
			var_05 notify("luinotifyserver","class_select",var_05.bot_class);
			param_00--;
			if(param_00 <= 0)
			{
				break;
			}
			else
			{
				wait(0.1);
			}
		}
	}
}

//Function Number: 30
bots_update_difficulty(param_00,param_01)
{
	foreach(var_03 in level.players)
	{
		if(!isdefined(var_03.team))
		{
			continue;
		}

		if(isdefined(var_03.connected) && var_03.connected && isbot(var_03) && var_03.team == param_00)
		{
			if(param_01 != var_03 botgetdifficulty())
			{
				var_03 maps\mp\bots\_bots_util::bot_set_difficulty(param_01);
			}
		}
	}
}

//Function Number: 31
bot_drop()
{
	kick(self.entity_number,"EXE_PLAYERKICKED_BOT_BALANCE");
	wait(0.1);
}

//Function Number: 32
drop_bots(param_00,param_01)
{
	var_02 = [];
	foreach(var_04 in level.players)
	{
		if(isdefined(var_04.connected) && var_04.connected && isbot(var_04) && !isdefined(param_01) || isdefined(var_04.team) && var_04.team == param_01)
		{
			var_02[var_02.size] = var_04;
		}
	}

	for(var_06 = var_02.size - 1;var_06 >= 0;var_06--)
	{
		if(param_00 <= 0)
		{
			break;
		}

		if(!maps\mp\_utility::isreallyalive(var_02[var_06]))
		{
			var_02[var_06] bot_drop();
			var_02 = common_scripts\utility::array_remove(var_02,var_02[var_06]);
			param_00--;
		}
	}

	for(var_06 = var_02.size - 1;var_06 >= 0;var_06--)
	{
		if(param_00 <= 0)
		{
			break;
		}

		var_02[var_06] bot_drop();
		param_00--;
	}
}

//Function Number: 33
bot_lui_convert_team_to_int(param_00)
{
	if(param_00 == "axis")
	{
		return 0;
	}

	if(param_00 == "allies")
	{
		return 1;
	}

	if(param_00 == "autoassign" || param_00 == "random")
	{
		return 2;
	}

	return 3;
}

//Function Number: 34
spawn_bot_latent(param_00,param_01,param_02)
{
	var_03 = gettime() + 60000;
	while(!self canspawntestclient())
	{
		if(gettime() >= var_03)
		{
			kick(self.entity_number,"EXE_PLAYERKICKED_BOT_BALANCE");
			param_02.abort = 1;
			return;
		}

		wait(0.05);
		if(!isdefined(self))
		{
			param_02.abort = 1;
			return;
		}
	}

	maps\mp\gametypes\_hostmigration::waitlongdurationwithhostmigrationpause(randomfloatrange(0.25,2));
	if(!isdefined(self))
	{
		param_02.abort = 1;
		return;
	}

	self spawntestclient();
	self.equipment_enabled = 1;
	self.bot_team = param_00;
	if(isdefined(param_02.difficulty))
	{
		maps\mp\bots\_bots_util::bot_set_difficulty(param_02.difficulty);
	}

	if(isdefined(param_01))
	{
		self [[ param_01 ]]();
	}

	self thread [[ level.bot_funcs["think"] ]]();
	param_02.ready = 1;
}

//Function Number: 35
spawn_bots(param_00,param_01,param_02,param_03,param_04,param_05)
{
	var_06 = gettime() + 10000;
	var_07 = [];
	var_08 = var_07.size;
	while(level.players.size < maps\mp\bots\_bots_util::bot_get_client_limit() && var_07.size < param_00 && gettime() < var_06)
	{
		maps\mp\gametypes\_hostmigration::waitlongdurationwithhostmigrationpause(0.05);
		var_09 = addbot("",0,0,0);
		if(!isdefined(var_09))
		{
			if(isdefined(param_03) && param_03)
			{
				if(isdefined(param_04))
				{
					self notify(param_04);
				}

				return;
			}

			maps\mp\gametypes\_hostmigration::waitlongdurationwithhostmigrationpause(1);
			continue;
		}
		else
		{
			var_0A = spawnstruct();
			var_0A.bot = var_09;
			var_0A.ready = 0;
			var_0A.abort = 0;
			var_0A.index = var_08;
			var_0A.difficulty = param_05;
			var_07[var_07.size] = var_0A;
			var_0A.bot thread spawn_bot_latent(param_01,param_02,var_0A);
			var_08++;
		}
	}

	var_0B = 0;
	var_06 = gettime() + 60000;
	while(var_0B < var_07.size && gettime() < var_06)
	{
		var_0B = 0;
		foreach(var_0A in var_07)
		{
			if(var_0A.ready || var_0A.abort)
			{
				var_0B++;
			}
		}

		wait(0.05);
	}

	if(isdefined(param_04))
	{
		self notify(param_04);
	}
}

//Function Number: 36
bot_gametype_chooses_team()
{
	var_00 = 0;
	if(!level.teambased)
	{
		var_00 = 1;
	}

	if(isdefined(level.bots_gametype_handles_team_choice) && level.bots_gametype_handles_team_choice)
	{
		var_00 = 1;
	}

	return var_00;
}

//Function Number: 37
bot_gametype_chooses_class()
{
	return isdefined(level.bots_gametype_handles_class_choice) && level.bots_gametype_handles_class_choice;
}

//Function Number: 38
bot_think()
{
	self notify("bot_think");
	self endon("bot_think");
	self endon("disconnect");
	while(!isdefined(self.pers["team"]))
	{
		wait(0.05);
	}

	level.hasbots = 1;
	if(bot_gametype_chooses_team())
	{
		self.bot_team = self.pers["team"];
	}

	var_00 = self.bot_team;
	if(!isdefined(var_00))
	{
		var_00 = self.pers["team"];
	}

	self.entity_number = self getentitynumber();
	var_01 = 0;
	if(!isdefined(self.bot_spawned_before))
	{
		var_01 = 1;
		self.bot_spawned_before = 1;
		if(!bot_gametype_chooses_team())
		{
			var_02 = self.pers["team"] != "spectator" && !isdefined(self.bot_team);
			if(!var_02)
			{
				self notify("luinotifyserver","team_select",bot_lui_convert_team_to_int(var_00));
				wait(0.5);
				if(self.pers["team"] == "spectator")
				{
					bot_drop();
					return;
				}
			}
		}
	}

	for(;;)
	{
		maps\mp\bots\_bots_util::bot_set_difficulty(self botgetdifficulty());
		var_03 = self botgetdifficultysetting("advancedPersonality");
		if(var_01 && isdefined(var_03) && var_03 != 0)
		{
			maps\mp\bots\_bots_personality::bot_balance_personality();
		}

		maps\mp\bots\_bots_personality::bot_assign_personality_functions();
		if(var_01)
		{
			bot_set_loadout_class();
			if(!bot_gametype_chooses_class())
			{
				self notify("luinotifyserver","class_select",self.bot_class);
			}

			if(self.health == 0)
			{
				self waittill("spawned_player");
			}

			if(isdefined(level.bot_funcs) && isdefined(level.bot_funcs["know_enemies_on_start"]))
			{
				self thread [[ level.bot_funcs["know_enemies_on_start"] ]]();
			}

			var_01 = 0;
		}

		bot_restart_think_threads();
		wait(0.1);
		self waittill("death");
		respawn_watcher();
		self waittill("spawned_player");
	}
}

//Function Number: 39
respawn_watcher()
{
	self endon("started_spawnPlayer");
	while(!self.waitingtospawn)
	{
		wait(0.05);
	}

	if(maps\mp\gametypes\_playerlogic::needsbuttontorespawn())
	{
		while(self.waitingtospawn)
		{
			if(self.sessionstate == "spectator")
			{
				if(getdvarint("numlives") == 0 || self.pers["lives"] > 0)
				{
					self botpressbutton("use",0.5);
				}
			}

			wait(1);
		}
	}
}

//Function Number: 40
bot_israndom()
{
	return self botisrandomized();
}

//Function Number: 41
bot_get_rank_xp_and_prestige()
{
	var_00 = spawnstruct();
	if(!bot_israndom())
	{
		if(!isdefined(self.pers["rankxp"]))
		{
			self.pers["rankxp"] = 0;
		}

		if(!isdefined(self.pers["prestige"]))
		{
			self.pers["prestige"] = 0;
		}

		var_00.rankxp = self.pers["rankxp"];
		var_00.prestige = self.pers["prestige"];
		return var_00;
	}

	var_01 = self botgetdifficulty();
	var_02 = "bot_rank_" + var_01;
	var_03 = "bot_prestige_" + var_01;
	var_04 = self.pers[var_02];
	var_05 = self.pers[var_03];
	var_06 = undefined;
	if(isdefined(var_04))
	{
		var_00.rankxp = var_04;
	}
	else
	{
		if(!isdefined(var_06))
		{
			var_06 = bot_random_ranks_for_difficulty(var_01);
		}

		var_07 = var_06["rank"];
		var_08 = maps\mp\gametypes\_rank::getrankinfominxp(var_07);
		var_09 = maps\mp\gametypes\_rank::getrankinfomaxxp(var_07);
		var_0A = randomintrange(var_08,var_09);
		self.pers[var_02] = var_0A;
		var_00.rankxp = var_0A;
	}

	if(isdefined(var_05))
	{
		var_00.prestige = var_05;
	}
	else
	{
		if(!isdefined(var_06))
		{
			var_06 = bot_random_ranks_for_difficulty(var_01);
		}

		var_0B = var_06["prestige"];
		self.pers[var_03] = var_0B;
		var_00.prestige = var_0B;
	}

	return var_00;
}

//Function Number: 42
bot_3d_sighting_model(param_00)
{
	thread bot_3d_sighting_model_thread(param_00);
}

//Function Number: 43
bot_3d_sighting_model_thread(param_00)
{
	param_00 endon("disconnect");
	self endon("disconnect");
	level endon("game_ended");
	for(;;)
	{
		if(isalive(self) && !self botcanseeentity(param_00) && common_scripts\utility::within_fov(self.origin,self.angles,param_00.origin,self botgetfovdot()))
		{
			self botgetimperfectenemyinfo(param_00,param_00.origin);
		}

		wait(0.1);
	}
}

//Function Number: 44
bot_random_ranks_for_difficulty(param_00)
{
	var_01 = [];
	var_01["rank"] = 0;
	var_01["prestige"] = 0;
	if(param_00 == "default")
	{
		return var_01;
	}

	if(!isdefined(level.bot_rnd_rank))
	{
		level.bot_rnd_rank = [];
		level.bot_rnd_rank["recruit"][0] = 0;
		level.bot_rnd_rank["recruit"][1] = 1;
		level.bot_rnd_rank["regular"][0] = 16;
		level.bot_rnd_rank["regular"][1] = 24;
		level.bot_rnd_rank["hardened"][0] = 36;
		level.bot_rnd_rank["hardened"][1] = 44;
		level.bot_rnd_rank["veteran"][0] = 46;
		level.bot_rnd_rank["veteran"][1] = 49;
	}

	if(!isdefined(level.bot_rnd_prestige))
	{
		level.bot_rnd_prestige = [];
		level.bot_rnd_prestige["recruit"][0] = 0;
		level.bot_rnd_prestige["recruit"][1] = 0;
		level.bot_rnd_prestige["regular"][0] = 0;
		level.bot_rnd_prestige["regular"][1] = 0;
		level.bot_rnd_prestige["hardened"][0] = 0;
		level.bot_rnd_prestige["hardened"][1] = 0;
		level.bot_rnd_prestige["veteran"][0] = 0;
		level.bot_rnd_prestige["veteran"][1] = 9;
	}

	var_01["rank"] = randomintrange(level.bot_rnd_rank[param_00][0],level.bot_rnd_rank[param_00][1] + 1);
	var_01["prestige"] = randomintrange(level.bot_rnd_prestige[param_00][0],level.bot_rnd_prestige[param_00][1] + 1);
	return var_01;
}

//Function Number: 45
crate_can_use_always(param_00)
{
	if(isagent(self) && !isdefined(param_00.boxtype))
	{
		return 0;
	}

	return 1;
}

//Function Number: 46
get_human_player()
{
	var_00 = undefined;
	var_01 = getentarray("player","classname");
	if(isdefined(var_01))
	{
		for(var_02 = 0;var_02 < var_01.size;var_02++)
		{
			if(isdefined(var_01[var_02]) && isdefined(var_01[var_02].connected) && var_01[var_02].connected && !isai(var_01[var_02]) && !isdefined(var_00) || var_00.team == "spectator")
			{
				var_00 = var_01[var_02];
			}
		}
	}

	return var_00;
}

//Function Number: 47
bot_damage_callback(param_00,param_01,param_02,param_03,param_04,param_05)
{
	if(!isdefined(self) || !isalive(self))
	{
		return;
	}

	if(param_02 == "MOD_FALLING" || param_02 == "MOD_SUICIDE")
	{
		return;
	}

	if(param_01 <= 0)
	{
		return;
	}

	if(!isdefined(param_04))
	{
		if(!isdefined(param_00))
		{
			return;
		}

		param_04 = param_00;
	}

	if(isdefined(param_04))
	{
		if(level.teambased)
		{
			if(isdefined(param_04.team) && param_04.team == self.team)
			{
				return;
			}
			else if(isdefined(param_00) && isdefined(param_00.team) && param_00.team == self.team)
			{
				return;
			}
		}

		var_06 = maps\mp\bots\_bots_util::bot_get_known_attacker(param_00,param_04);
		if(isdefined(var_06))
		{
			self botsetattacker(var_06);
		}
	}
}

//Function Number: 48
on_bot_killed(param_00,param_01,param_02,param_03,param_04,param_05,param_06,param_07,param_08,param_09)
{
	self botclearscriptenemy();
	self botclearscriptgoal();
	var_0A = maps\mp\bots\_bots_util::bot_get_known_attacker(param_01,param_00);
	if(isdefined(var_0A) && var_0A.classname == "misc_turret" && isdefined(var_0A.chopper))
	{
		var_0A = var_0A.chopper;
	}

	if(isdefined(var_0A) && var_0A.classname == "script_vehicle" || var_0A.classname == "script_model" && isdefined(var_0A.helitype))
	{
		var_0B = self botgetdifficultysetting("launcherRespawnChance");
		if(randomfloat(1) < var_0B)
		{
			self.respawn_with_launcher = 1;
		}
	}
}

//Function Number: 49
bot_should_do_killcam()
{
	var_00 = 0;
	var_01 = self botgetdifficulty();
	if(var_01 == "recruit")
	{
		var_00 = 0.1;
	}
	else if(var_01 == "regular")
	{
		var_00 = 0.4;
	}
	else if(var_01 == "hardened")
	{
		var_00 = 0.7;
	}
	else if(var_01 == "veteran")
	{
		var_00 = 1;
	}

	return randomfloat(1) < 1 - var_00;
}

//Function Number: 50
bot_should_pickup_weapons()
{
	if(maps\mp\_utility::isjuggernaut())
	{
		return 0;
	}

	return 1;
}

//Function Number: 51
bot_restart_think_threads()
{
	thread bot_think_watch_enemy();
	thread maps\mp\bots\_bots_strategy::bot_think_tactical_goals();
	self thread [[ level.bot_funcs["dropped_weapon_think"] ]]();
	thread bot_think_level_actions();
	thread bot_think_crate();
	thread bot_think_crate_blocking_path();
	thread maps\mp\bots\_bots_ks::bot_think_killstreak();
	thread maps\mp\bots\_bots_ks::bot_think_watch_aerial_killstreak();
	thread bot_think_gametype();
}

//Function Number: 52
bot_think_watch_enemy(param_00)
{
	var_01 = "spawned_player";
	if(isdefined(param_00) && param_00)
	{
		var_01 = "death";
	}

	self notify("bot_think_watch_enemy");
	self endon("bot_think_watch_enemy");
	self endon(var_01);
	self endon("disconnect");
	level endon("game_ended");
	self.last_enemy_sight_time = gettime();
	for(;;)
	{
		if(isdefined(self.enemy))
		{
			if(self botcanseeentity(self.enemy))
			{
				self.last_enemy_sight_time = gettime();
			}
		}

		wait(0.05);
	}
}

//Function Number: 53
bot_think_seek_dropped_weapons()
{
	self notify("bot_think_seek_dropped_weapons");
	self endon("bot_think_seek_dropped_weapons");
	self endon("death");
	self endon("disconnect");
	level endon("game_ended");
	for(;;)
	{
		var_00 = 0;
		if(maps\mp\bots\_bots_util::bot_out_of_ammo() && self [[ level.bot_funcs["should_pickup_weapons"] ]]() && !maps\mp\bots\_bots_util::bot_is_remote_or_linked())
		{
			var_01 = getentarray("dropped_weapon","targetname");
			var_02 = common_scripts\utility::get_array_of_closest(self.origin,var_01);
			if(var_02.size > 0)
			{
				var_03 = var_02[0];
				bot_seek_dropped_weapon(var_03);
			}
		}

		wait(randomfloatrange(0.25,0.75));
	}
}

//Function Number: 54
bot_seek_dropped_weapon(param_00)
{
	if(maps\mp\bots\_bots_strategy::bot_has_tactical_goal("seek_dropped_weapon",param_00) == 0)
	{
		var_01 = undefined;
		if(param_00.targetname == "dropped_weapon")
		{
			var_02 = 1;
			var_03 = self getweaponslistprimaries();
			foreach(var_05 in var_03)
			{
				if(param_00.model == getweaponmodel(var_05))
				{
					var_02 = 0;
				}
			}

			if(var_02)
			{
				var_01 = ::bot_pickup_weapon;
			}
		}

		var_07 = spawnstruct();
		var_07.object = param_00;
		var_07.script_goal_radius = 12;
		var_07.should_abort = level.bot_funcs["dropped_weapon_cancel"];
		var_07.action_thread = var_01;
		maps\mp\bots\_bots_strategy::bot_new_tactical_goal("seek_dropped_weapon",param_00.origin,100,var_07);
	}
}

//Function Number: 55
bot_pickup_weapon(param_00)
{
	self botpressbutton("use",2);
	wait(2);
}

//Function Number: 56
should_stop_seeking_weapon(param_00)
{
	if(!isdefined(param_00.object))
	{
		return 1;
	}

	if(param_00.object.targetname == "dropped_weapon")
	{
		if(maps\mp\bots\_bots_util::bot_get_total_gun_ammo() > 0)
		{
			return 1;
		}
	}
	else if(param_00.object.targetname == "dropped_knife")
	{
		if(maps\mp\bots\_bots_util::bot_in_combat())
		{
			self.going_for_knife = undefined;
			return 1;
		}
	}

	return 0;
}

//Function Number: 57
bot_think_level_actions(param_00)
{
	self notify("bot_think_level_actions");
	self endon("bot_think_level_actions");
	self endon("death");
	self endon("disconnect");
	level endon("game_ended");
	for(;;)
	{
		common_scripts\utility::waittill_notify_or_timeout("calculate_new_level_targets",randomfloatrange(2,10));
		if(!isdefined(level.level_specific_bot_targets) || level.level_specific_bot_targets.size == 0)
		{
			continue;
		}

		if(maps\mp\bots\_bots_strategy::bot_has_tactical_goal("map_interactive_object"))
		{
			continue;
		}

		if(maps\mp\bots\_bots_util::bot_in_combat() || maps\mp\bots\_bots_util::bot_is_remote_or_linked())
		{
			continue;
		}

		var_01 = undefined;
		foreach(var_03 in level.level_specific_bot_targets)
		{
			if(common_scripts\utility::array_contains(var_03.high_priority_for,self))
			{
				var_01 = var_03;
				break;
			}
		}

		if(!isdefined(var_01))
		{
			if(randomint(100) > 25)
			{
				continue;
			}

			var_05 = common_scripts\utility::get_array_of_closest(self.origin,level.level_specific_bot_targets);
			var_06 = 256;
			if(isdefined(param_00))
			{
				var_06 = param_00;
			}
			else if(self botgetscriptgoaltype() == "hunt" && self botpursuingscriptgoal())
			{
				var_06 = 512;
			}

			if(distancesquared(self.origin,var_05[0].origin) > var_06 * var_06)
			{
				continue;
			}

			var_01 = var_05[0];
		}

		var_07 = 0;
		if(var_01.bot_interaction_type == "damage")
		{
			var_07 = bot_should_melee_level_damage_target(var_01);
			if(var_07)
			{
				var_08 = var_01.origin[2] - var_01.bot_targets[0].origin[2] + 55;
				var_09 = var_01.origin[2] - var_01.bot_targets[1].origin[2] + 55;
				if(var_08 > 55 && var_09 > 55)
				{
					if(common_scripts\utility::array_contains(var_01.high_priority_for,self))
					{
						var_01.high_priority_for = common_scripts\utility::array_remove(var_01.high_priority_for,self);
					}

					continue;
				}
			}

			var_0A = weaponclass(self getcurrentweapon());
			if(var_0A == "spread")
			{
				var_0B = var_01.bot_targets[0].origin - var_01.origin;
				var_0C = var_01.bot_targets[1].origin - var_01.origin;
				var_0D = lengthsquared(var_0B);
				var_0E = lengthsquared(var_0C);
				if(var_0D > 22500 && var_0E > 22500)
				{
					if(common_scripts\utility::array_contains(var_01.high_priority_for,self))
					{
						var_01.high_priority_for = common_scripts\utility::array_remove(var_01.high_priority_for,self);
					}

					continue;
				}
			}
		}

		var_0F = spawnstruct();
		var_0F.object = var_01;
		if(var_01.bot_interaction_type == "damage")
		{
			if(var_07)
			{
				var_0F.should_abort = ::level_trigger_should_abort_melee;
			}
			else
			{
				var_0F.should_abort = ::level_trigger_should_abort_ranged;
			}
		}

		if(var_01.bot_interaction_type == "use")
		{
			var_0F.action_thread = ::use_use_trigger;
			var_0F.should_abort = ::level_trigger_should_abort;
			var_0F.script_goal_yaw = vectortoangles(var_01.origin - var_01.bot_target.origin)[1];
			maps\mp\bots\_bots_strategy::bot_new_tactical_goal("map_interactive_object",var_01.bot_target.origin,10,var_0F);
			continue;
		}

		if(var_01.bot_interaction_type == "damage")
		{
			if(var_07)
			{
				var_0F.action_thread = ::melee_damage_trigger;
				var_0F.script_goal_radius = 20;
			}
			else
			{
				var_0F.action_thread = ::attack_damage_trigger;
				var_0F.script_goal_radius = 50;
			}

			var_10 = undefined;
			var_11 = maps\mp\bots\_bots_util::bot_queued_process("GetPathDistLevelAction",::maps\mp\bots\_bots_util::func_get_path_dist,self.origin,var_01.bot_targets[0].origin);
			var_12 = maps\mp\bots\_bots_util::bot_queued_process("GetPathDistLevelAction",::maps\mp\bots\_bots_util::func_get_path_dist,self.origin,var_01.bot_targets[1].origin);
			if(!isdefined(var_01))
			{
				continue;
			}

			if(var_11 <= 0 && var_12 <= 0)
			{
				continue;
			}

			if(var_11 > 0)
			{
				if(var_12 < 0 || var_11 <= var_12)
				{
					var_10 = var_01.bot_targets[0];
				}
			}

			if(var_12 > 0)
			{
				if(var_11 < 0 || var_12 <= var_11)
				{
					var_10 = var_01.bot_targets[1];
				}
			}

			if(!var_07)
			{
				childthread monitor_node_visible(var_10);
			}

			maps\mp\bots\_bots_strategy::bot_new_tactical_goal("map_interactive_object",var_10.origin,10,var_0F);
		}
	}
}

//Function Number: 58
bot_should_melee_level_damage_target(param_00)
{
	var_01 = self getcurrentweapon();
	var_02 = maps\mp\bots\_bots_util::bot_out_of_ammo() || maps\mp\_riotshield::hasriotshieldequipped() || isdefined(self.isjuggernautmaniac) && self.isjuggernautmaniac == 1 || weaponclass(var_01) == "grenade" || var_01 == "iw5_combatknife_mp";
	return var_02;
}

//Function Number: 59
monitor_node_visible(param_00)
{
	self endon("goal");
	wait(0.1);
	for(;;)
	{
		if(weaponclass(self getcurrentweapon()) == "spread")
		{
			if(distancesquared(self.origin,param_00.origin) > 90000)
			{
				wait(0.05);
				continue;
			}
		}

		var_01 = self getnearestnode();
		if(isdefined(var_01))
		{
			if(nodesvisible(var_01,param_00,1))
			{
				if(sighttracepassed(self.origin + (0,0,55),param_00.origin + (0,0,55),0,self))
				{
					self notify("goal");
				}
			}
		}

		wait(0.05);
	}
}

//Function Number: 60
attack_damage_trigger(param_00)
{
	if(param_00.object.origin[2] - self geteye()[2] > 55)
	{
		if(distance2dsquared(param_00.object.origin,self.origin) < 225)
		{
			return;
		}
	}

	self botsetflag("disable_movement",1);
	look_at_damage_trigger(param_00.object,0.3);
	self botpressbutton("ads",0.3);
	wait(0.25);
	var_01 = gettime();
	while(isdefined(param_00.object) && !isdefined(param_00.object.already_used) && gettime() - var_01 < 5000)
	{
		look_at_damage_trigger(param_00.object,0.15);
		self botpressbutton("ads",0.15);
		self botpressbutton("attack");
		wait(0.1);
	}

	self botsetflag("disable_movement",0);
}

//Function Number: 61
melee_damage_trigger(param_00)
{
	self botsetflag("disable_movement",1);
	look_at_damage_trigger(param_00.object,0.3);
	wait(0.25);
	var_01 = gettime();
	while(isdefined(param_00.object) && !isdefined(param_00.object.already_used) && gettime() - var_01 < 5000)
	{
		look_at_damage_trigger(param_00.object,0.15);
		self botpressbutton("melee");
		wait(0.1);
	}

	self botsetflag("disable_movement",0);
}

//Function Number: 62
look_at_damage_trigger(param_00,param_01)
{
	var_02 = param_00.origin;
	if(distance2dsquared(self.origin,var_02) < 100)
	{
		var_02 = (var_02[0],var_02[1],self geteye()[2]);
	}

	self botlookatpoint(var_02,param_01,"script_forced");
}

//Function Number: 63
use_use_trigger(param_00)
{
	if(isagent(self))
	{
		common_scripts\utility::_enableusability();
		param_00.object enableplayeruse(self);
		wait(0.05);
	}

	var_01 = param_00.object.use_time;
	self botpressbutton("use",var_01);
	wait(var_01);
	if(isagent(self))
	{
		common_scripts\utility::_disableusability();
		if(isdefined(param_00.object))
		{
			param_00.object disableplayeruse(self);
		}
	}
}

//Function Number: 64
level_trigger_should_abort_melee(param_00)
{
	if(level_trigger_should_abort(param_00))
	{
		return 1;
	}

	if(!bot_should_melee_level_damage_target(param_00.object))
	{
		return 1;
	}

	return 0;
}

//Function Number: 65
level_trigger_should_abort_ranged(param_00)
{
	if(level_trigger_should_abort(param_00))
	{
		return 1;
	}

	if(bot_should_melee_level_damage_target(param_00.object))
	{
		return 1;
	}

	return 0;
}

//Function Number: 66
level_trigger_should_abort(param_00)
{
	if(!isdefined(param_00.object))
	{
		return 1;
	}

	if(isdefined(param_00.object.already_used))
	{
		return 1;
	}

	if(maps\mp\bots\_bots_util::bot_in_combat())
	{
		return 1;
	}

	return 0;
}

//Function Number: 67
crate_in_range(param_00)
{
	if(!isdefined(param_00.owner) || param_00.owner != self)
	{
		if(distancesquared(self.origin,param_00.origin) > 4194304)
		{
			return 0;
		}
	}

	return 1;
}

//Function Number: 68
bot_crate_valid(param_00)
{
	if(!isdefined(param_00))
	{
		return 0;
	}

	if(maps\mp\_utility::isjuggernaut() && maps\mp\killstreaks\_juggernaut::is_goliath_drop_pod(param_00))
	{
		return 0;
	}

	if(!self [[ level.bot_funcs["crate_can_use"] ]](param_00))
	{
		return 0;
	}

	if(!crate_landed_and_on_path_grid(param_00))
	{
		return 0;
	}

	if(level.teambased && isdefined(param_00.bomb) && isdefined(param_00.team) && param_00.team == self.team)
	{
		return 0;
	}

	if(!self [[ level.bot_funcs["crate_in_range"] ]](param_00))
	{
		return 0;
	}

	if(isdefined(param_00.boxtype))
	{
		if(isdefined(level.boxsettings) && isdefined(level.boxsettings[param_00.boxtype]) && ![[ level.boxsettings[param_00.boxtype].canusecallback ]]())
		{
			return 0;
		}

		if(isdefined(param_00.disabled_use_for) && isdefined(param_00.disabled_use_for[self getentitynumber()]) && param_00.disabled_use_for[self getentitynumber()])
		{
			return 0;
		}

		if(!self [[ level.bot_can_use_box_by_type[param_00.boxtype] ]](param_00))
		{
			return 0;
		}
	}

	return isdefined(param_00);
}

//Function Number: 69
crate_landed_and_on_path_grid(param_00)
{
	if(!crate_has_landed(param_00))
	{
		return 0;
	}

	if(!crate_is_on_path_grid(param_00))
	{
		return 0;
	}

	return isdefined(param_00);
}

//Function Number: 70
crate_has_landed(param_00)
{
	if(isdefined(param_00.boxtype))
	{
		return gettime() > param_00.birthtime + 1000;
	}

	return isdefined(param_00.droppingtoground) && !param_00.droppingtoground;
}

//Function Number: 71
crate_is_on_path_grid(param_00)
{
	if(!isdefined(param_00.on_path_grid))
	{
		crate_calculate_on_path_grid(param_00);
	}

	return isdefined(param_00) && param_00.on_path_grid;
}

//Function Number: 72
node_within_use_radius_of_crate(param_00,param_01)
{
	if(isdefined(param_01.boxtype) && param_01.boxtype == "scavenger_bag")
	{
		return abs(param_00.origin[0] - param_01.origin[0]) < 36 && abs(param_00.origin[0] - param_01.origin[0]) < 36 && abs(param_00.origin[0] - param_01.origin[0]) < 18;
	}

	var_02 = getdvarfloat("player_useRadius");
	var_03 = distancesquared(param_01.origin,param_00.origin + (0,0,40));
	return var_03 <= var_02 * var_02;
}

//Function Number: 73
crate_calculate_on_path_grid(param_00)
{
	param_00 thread crate_monitor_position();
	param_00.on_path_grid = 0;
	var_01 = undefined;
	var_02 = undefined;
	if(isdefined(param_00.forcedisconnectuntil))
	{
		var_01 = param_00.forcedisconnectuntil;
		var_02 = gettime() + 30000;
		param_00.forcedisconnectuntil = var_02;
		param_00 notify("path_disconnect");
	}

	wait(0.05);
	if(!isdefined(param_00))
	{
		return;
	}

	var_03 = [];
	if(!maps\mp\killstreaks\_juggernaut::is_goliath_drop_pod(param_00))
	{
		var_03 = crate_get_nearest_valid_nodes(param_00);
	}

	if(!isdefined(param_00))
	{
		return;
	}

	if(isdefined(var_03) && var_03.size > 0)
	{
		param_00.nearest_nodes = var_03;
		param_00.on_path_grid = 1;
	}
	else
	{
		var_04 = getdvarfloat("player_useRadius");
		var_05 = getnodesinradiussorted(param_00.origin,var_04 * 2,0)[0];
		var_06 = param_00 getpointinbounds(0,0,-1);
		var_07 = undefined;
		if(isdefined(param_00.boxtype) && param_00.boxtype == "scavenger_bag")
		{
			if(maps\mp\bots\_bots_util::bot_point_is_on_pathgrid(param_00.origin))
			{
				var_07 = param_00.origin;
			}
		}
		else
		{
			var_07 = botgetclosestnavigablepoint(param_00.origin,var_04);
		}

		if(isdefined(var_05) && !var_05 nodeisdisconnected() && isdefined(var_07) && abs(var_05.origin[2] - var_06[2]) < 30)
		{
			param_00.nearest_points = [var_07];
			param_00.nearest_nodes = [var_05];
			param_00.on_path_grid = 1;
		}
	}

	if(isdefined(param_00.forcedisconnectuntil))
	{
		if(param_00.forcedisconnectuntil == var_02)
		{
			param_00.forcedisconnectuntil = var_01;
		}
	}
}

//Function Number: 74
crate_get_nearest_valid_nodes(param_00)
{
	var_01 = getnodesinradiussorted(param_00.origin,256,0);
	for(var_02 = var_01.size;var_02 > 0;var_02--)
	{
		var_01[var_02] = var_01[var_02 - 1];
	}

	var_01[0] = getclosestnodeinsight(param_00.origin);
	var_03 = undefined;
	if(isdefined(param_00.forcedisconnectuntil))
	{
		var_03 = getallnodes();
	}

	var_04 = [];
	var_05 = 1;
	if(!isdefined(param_00.boxtype))
	{
		var_05 = 2;
	}

	for(var_02 = 0;var_02 < var_01.size;var_02++)
	{
		var_06 = var_01[var_02];
		if(!isdefined(var_06) || !isdefined(param_00))
		{
			continue;
		}

		if(var_06 nodeisdisconnected())
		{
			continue;
		}

		if(!node_within_use_radius_of_crate(var_06,param_00))
		{
			if(var_02 == 0)
			{
				continue;
			}
			else
			{
				break;
			}
		}

		wait(0.05);
		if(!isdefined(param_00))
		{
			break;
		}

		if(sighttracepassed(param_00.origin,var_06.origin + (0,0,55),0,param_00))
		{
			wait(0.05);
			if(!isdefined(param_00))
			{
				break;
			}

			if(!isdefined(param_00.forcedisconnectuntil))
			{
				var_04[var_04.size] = var_06;
				if(var_04.size == var_05)
				{
					return var_04;
				}
				else
				{
					continue;
				}
			}

			var_07 = undefined;
			var_08 = 0;
			while(!isdefined(var_07) && var_08 < 100)
			{
				var_08++;
				var_09 = common_scripts\utility::random(var_03);
				if(distancesquared(var_06.origin,var_09.origin) > 250000)
				{
					var_07 = var_09;
				}
			}

			if(isdefined(var_07))
			{
				var_0A = maps\mp\bots\_bots_util::bot_queued_process("GetNodesOnPathCrate",::maps\mp\bots\_bots_util::func_get_nodes_on_path,var_06.origin,var_07.origin);
				if(isdefined(var_0A))
				{
					var_04[var_04.size] = var_06;
					if(var_04.size == var_05)
					{
						return var_04;
					}
					else
					{
						continue;
					}
				}
			}
		}
	}

	return undefined;
}

//Function Number: 75
crate_get_bot_target(param_00)
{
	if(isdefined(param_00.nearest_points))
	{
		return param_00.nearest_points[0];
	}

	if(isdefined(param_00.nearest_nodes) && param_00.nearest_nodes.size > 0)
	{
		var_01 = common_scripts\utility::array_reverse(self botnodescoremultiple(param_00.nearest_nodes,"node_exposed"));
		return common_scripts\utility::random_weight_sorted(var_01).origin;
	}
}

//Function Number: 76
bot_think_crate()
{
	self notify("bot_think_crate");
	self endon("bot_think_crate");
	self endon("death");
	self endon("disconnect");
	level endon("game_ended");
	var_00 = getdvarfloat("player_useRadius");
	for(;;)
	{
		var_01 = randomfloatrange(2,4);
		common_scripts\utility::waittill_notify_or_timeout("new_crate_to_take",var_01);
		if(isdefined(self.boxes) && self.boxes.size == 0)
		{
			self.boxes = undefined;
		}

		var_02 = [];
		foreach(var_04 in level.carepackages)
		{
			if(maps\mp\killstreaks\_juggernaut::is_goliath_drop_pod(var_04))
			{
				var_02[var_02.size] = var_04;
			}
		}

		if(!maps\mp\bots\_bots_util::bot_in_combat() && isdefined(self.boxes))
		{
			var_02 = common_scripts\utility::array_combine(var_02,self.boxes);
		}

		if(isdefined(level.bot_scavenger_bags) && maps\mp\_utility::_hasperk("specialty_scavenger"))
		{
			var_02 = common_scripts\utility::array_combine(var_02,level.bot_scavenger_bags);
		}

		var_02 = common_scripts\utility::array_removeundefined(var_02);
		if(var_02.size == 0)
		{
			continue;
		}

		if(maps\mp\bots\_bots_strategy::bot_has_tactical_goal("airdrop_crate") || self botgetscriptgoaltype() == "tactical" || maps\mp\bots\_bots_util::bot_is_remote_or_linked())
		{
			continue;
		}

		var_06 = [];
		foreach(var_08 in var_02)
		{
			if(bot_crate_valid(var_08))
			{
				var_06[var_06.size] = var_08;
			}
		}

		var_06 = common_scripts\utility::array_remove_duplicates(var_06);
		if(var_06.size == 0)
		{
			continue;
		}

		var_06 = common_scripts\utility::get_array_of_closest(self.origin,var_06);
		var_0A = self getnearestnode();
		if(!isdefined(var_0A))
		{
			continue;
		}

		var_0B = self [[ level.bot_funcs["crate_low_ammo_check"] ]]();
		var_0C = (var_0B || randomint(100) < 50) && !maps\mp\_utility::isemped();
		var_0D = undefined;
		foreach(var_08 in var_06)
		{
			var_0F = 0;
			if((!isdefined(var_08.owner) || var_08.owner != self) && !isdefined(var_08.boxtype))
			{
				var_10 = [];
				foreach(var_12 in level.players)
				{
					if(!isdefined(var_12.team))
					{
						continue;
					}

					if(!isai(var_12) && level.teambased && var_12.team == self.team)
					{
						if(distancesquared(var_12.origin,var_08.origin) < 490000)
						{
							var_10[var_10.size] = var_12;
						}
					}
				}

				if(var_10.size > 0)
				{
					var_14 = var_10[0] getnearestnode();
					if(isdefined(var_14))
					{
						var_0F = 0;
						foreach(var_16 in var_08.nearest_nodes)
						{
							var_0F = var_0F | nodesvisible(var_14,var_16,1);
						}
					}
				}
			}

			if(!var_0F)
			{
				var_18 = isdefined(var_08.bots) && isdefined(var_08.bots[self.team]) && var_08.bots[self.team] > 0;
				var_19 = 0;
				foreach(var_16 in var_08.nearest_nodes)
				{
					var_19 = var_19 | nodesvisible(var_0A,var_16,1);
				}

				if(var_19 || var_0C && !var_18)
				{
					var_0D = var_08;
					break;
				}
			}
		}

		if(isdefined(var_0D))
		{
			if(self [[ level.bot_funcs["crate_should_claim"] ]]())
			{
				if(!isdefined(var_0D.boxtype))
				{
					if(!isdefined(var_0D.bots))
					{
						var_0D.bots = [];
					}

					var_0D.bots[self.team] = 1;
				}
			}

			var_1D = spawnstruct();
			var_1D.object = var_0D;
			var_1D.start_thread = ::watch_bot_died_during_crate;
			var_1D.should_abort = ::crate_picked_up;
			var_1E = undefined;
			if(isdefined(var_0D.boxtype))
			{
				if(isdefined(var_0D.boxtouchonly) && var_0D.boxtouchonly)
				{
					var_1D.script_goal_radius = 16;
					var_1D.action_thread = undefined;
					var_1E = var_0D.origin;
				}
				else
				{
					var_1D.script_goal_radius = 50;
					var_1D.action_thread = ::use_box;
					var_1F = crate_get_bot_target(var_0D) - var_0D.origin;
					var_20 = length(var_1F) * randomfloat(1);
					var_1E = var_0D.origin + vectornormalize(var_1F) * var_20 + (0,0,12);
				}
			}
			else
			{
				var_1D.action_thread = ::use_crate;
				var_1D.end_thread = ::stop_using_crate;
				var_1E = crate_get_bot_target(var_0D);
				if(!maps\mp\killstreaks\_juggernaut::is_goliath_drop_pod(var_0D))
				{
					var_1D.script_goal_radius = var_00 - distance(var_0D.origin,var_1E + (0,0,40));
				}

				var_1E = var_1E + (0,0,24);
			}

			if(isdefined(var_1D.script_goal_radius))
			{
			}

			var_0D notify("path_disconnect");
			wait(0.05);
			if(!isdefined(var_0D))
			{
				continue;
			}

			maps\mp\bots\_bots_strategy::bot_new_tactical_goal("airdrop_crate",var_1E,30,var_1D);
		}
	}
}

//Function Number: 77
bot_should_use_ballistic_vest_crate(param_00)
{
	return 1;
}

//Function Number: 78
crate_should_claim()
{
	return 1;
}

//Function Number: 79
crate_low_ammo_check()
{
	return 0;
}

//Function Number: 80
bot_should_use_ammo_crate(param_00)
{
	if(self getcurrentweapon() == level.boxsettings[param_00.boxtype].minigunweapon)
	{
		return 0;
	}

	return 1;
}

//Function Number: 81
bot_pre_use_ammo_crate(param_00)
{
	self switchtoweapon(self.secondaryweapon);
	wait(1);
}

//Function Number: 82
bot_post_use_ammo_crate(param_00)
{
	self switchtoweapon("none");
	self.secondaryweapon = self getcurrentweapon();
}

//Function Number: 83
bot_should_use_scavenger_bag(param_00)
{
	if(maps\mp\bots\_bots_util::bot_get_low_on_ammo(0.66))
	{
		var_01 = self getnearestnode();
		if(isdefined(param_00.nearest_nodes) && isdefined(param_00.nearest_nodes[0]) && isdefined(var_01))
		{
			if(nodesvisible(var_01,param_00.nearest_nodes[0],1))
			{
				if(common_scripts\utility::within_fov(self.origin,self.angles,param_00.origin,self botgetfovdot()))
				{
					return 1;
				}
			}
		}
	}

	return 0;
}

//Function Number: 84
bot_should_use_grenade_crate(param_00)
{
	var_01 = self getweaponslistoffhands();
	foreach(var_03 in var_01)
	{
		if(self setweaponammostock(var_03) == 0)
		{
			return 1;
		}
	}

	return 0;
}

//Function Number: 85
bot_should_use_juicebox_crate(param_00)
{
	return 1;
}

//Function Number: 86
crate_monitor_position()
{
	self notify("crate_monitor_position");
	self endon("crate_monitor_position");
	self endon("death");
	level endon("game_ended");
	for(;;)
	{
		var_00 = self.origin;
		wait(0.5);
		if(!isdefined(self))
		{
			return;
		}

		if(!maps\mp\bots\_bots_util::bot_vectors_are_equal(self.origin,var_00))
		{
			self.on_path_grid = undefined;
			self.nearest_nodes = undefined;
			self.nearest_points = undefined;
		}
	}
}

//Function Number: 87
crate_wait_use()
{
}

//Function Number: 88
crate_picked_up(param_00)
{
	if(!isdefined(param_00.object))
	{
		return 1;
	}

	return 0;
}

//Function Number: 89
use_crate(param_00)
{
	if(maps\mp\killstreaks\_juggernaut::is_goliath_drop_pod(param_00.object))
	{
		param_00.was_goliath_pod_goal = 1;
		self botsetstance("stand");
		self botlookatpoint(param_00.object.origin + (0,0,self getplayerviewheight()),level.cratenonownerusetime / 1000 + 1,"script_forced");
	}

	if(isagent(self))
	{
		common_scripts\utility::_enableusability();
		param_00.object enableplayeruse(self);
		wait(0.05);
	}

	self [[ level.bot_funcs["crate_wait_use"] ]]();
	if(isdefined(param_00.object.owner) && param_00.object.owner == self)
	{
		var_01 = level.crateownerusetime / 1000 + 0.5;
	}
	else
	{
		var_01 = level.cratenonownerusetime / 1000 + 1;
	}

	self botpressbutton("use",var_01);
	wait(var_01);
	if(isagent(self))
	{
		common_scripts\utility::_disableusability();
		if(isdefined(param_00.object))
		{
			param_00.object disableplayeruse(self);
		}
	}

	if(isdefined(param_00.object))
	{
		if(!isdefined(param_00.object.bots_used))
		{
			param_00.object.bots_used = [];
		}

		param_00.object.bots_used[param_00.object.bots_used.size] = self;
	}
}

//Function Number: 90
use_box(param_00)
{
	if(isagent(self))
	{
		common_scripts\utility::_enableusability();
		param_00.object enableplayeruse(self);
		wait(0.05);
	}

	if(isdefined(param_00.object) && isdefined(param_00.object.boxtype))
	{
		var_01 = param_00.object.boxtype;
		if(isdefined(level.bot_pre_use_box_of_type[var_01]))
		{
			self [[ level.bot_pre_use_box_of_type[var_01] ]](param_00.object);
		}

		if(isdefined(param_00.object))
		{
			var_02 = level.boxsettings[param_00.object.boxtype].usetime / 1000 + 0.5;
			self botpressbutton("use",var_02);
			wait(var_02);
			if(isdefined(level.bot_post_use_box_of_type[var_01]))
			{
				self [[ level.bot_post_use_box_of_type[var_01] ]](param_00.object);
			}
		}
	}

	if(isagent(self))
	{
		common_scripts\utility::_disableusability();
		if(isdefined(param_00.object))
		{
			param_00.object disableplayeruse(self);
		}
	}
}

//Function Number: 91
watch_bot_died_during_crate(param_00)
{
	thread bot_watch_for_death(param_00.object);
}

//Function Number: 92
stop_using_crate(param_00)
{
	if(isdefined(param_00.was_goliath_pod_goal) && param_00.was_goliath_pod_goal)
	{
		self botsetstance("none");
		self botlookatpoint(undefined);
	}

	if(isdefined(param_00.object))
	{
		param_00.object.bots[self.team] = 0;
	}
}

//Function Number: 93
bot_watch_for_death(param_00)
{
	param_00 endon("death");
	param_00 endon("revived");
	param_00 endon("disconnect");
	level endon("game_ended");
	var_01 = self.team;
	common_scripts\utility::waittill_any("death","disconnect");
	if(isdefined(param_00))
	{
		param_00.bots[var_01] = 0;
	}
}

//Function Number: 94
bot_think_crate_blocking_path()
{
	self notify("bot_think_crate_blocking_path");
	self endon("bot_think_crate_blocking_path");
	self endon("death");
	self endon("disconnect");
	level endon("game_ended");
	var_00 = getdvarfloat("player_useRadius");
	for(;;)
	{
		wait(3);
		if(self usebuttonpressed())
		{
			continue;
		}

		if(maps\mp\_utility::isusingremote())
		{
			continue;
		}

		var_01 = level.carepackages;
		for(var_02 = 0;var_02 < var_01.size;var_02++)
		{
			var_03 = var_01[var_02];
			if(!isdefined(var_03))
			{
				continue;
			}

			if(maps\mp\killstreaks\_juggernaut::is_goliath_drop_pod(var_03))
			{
				if(!maps\mp\_utility::isjuggernaut() && distancesquared(self.origin,var_03.origin) < 3600)
				{
					var_04 = spawnstruct();
					var_04.object = var_03;
					self botsetflag("disable_movement",1);
					use_crate(var_04);
					stop_using_crate(var_04);
					self botsetflag("disable_movement",0);
				}

				continue;
			}

			var_05 = self playergetuseent();
			if(!isdefined(var_05) || var_05 != var_03)
			{
				continue;
			}

			if(distancesquared(self.origin,var_03.origin) < var_00 * var_00)
			{
				if(isdefined(var_03.owner) && var_03.owner == self)
				{
					self botpressbutton("use",level.crateownerusetime / 1000 + 0.5);
					continue;
				}

				self botpressbutton("use",level.cratenonownerusetime / 1000 + 0.5);
			}
		}
	}
}

//Function Number: 95
bot_think_revive()
{
	self notify("bot_think_revive");
	self endon("bot_think_revive");
	self endon("death");
	self endon("disconnect");
	level endon("game_ended");
	if(!level.teambased)
	{
		return;
	}

	for(;;)
	{
		var_00 = 2;
		var_01 = getentarray("revive_trigger","targetname");
		if(var_01.size > 0)
		{
			var_00 = 0.05;
		}

		level common_scripts\utility::waittill_notify_or_timeout("player_last_stand",var_00);
		if(!bot_can_revive())
		{
			continue;
		}

		var_01 = getentarray("revive_trigger","targetname");
		if(var_01.size > 1)
		{
			var_01 = sortbydistance(var_01,self.origin);
			if(isdefined(self.owner))
			{
				for(var_02 = 0;var_02 < var_01.size;var_02++)
				{
					if(var_01[var_02].owner != self.owner)
					{
						continue;
					}

					if(var_02 == 0)
					{
						break;
					}

					var_03 = var_01[var_02];
					var_01[var_02] = var_01[0];
					var_01[0] = var_03;
					break;
				}
			}
		}

		for(var_02 = 0;var_02 < var_01.size;var_02++)
		{
			var_04 = var_01[var_02];
			var_05 = var_04.owner;
			if(!isdefined(var_05))
			{
				continue;
			}

			if(var_05 == self)
			{
				continue;
			}

			if(!isalive(var_05))
			{
				continue;
			}

			if(var_05.team != self.team)
			{
				continue;
			}

			if(!isdefined(var_05.inlaststand) || !var_05.inlaststand)
			{
				continue;
			}

			if(isdefined(var_05.bots) && isdefined(var_05.bots[self.team]) && var_05.bots[self.team] > 0)
			{
				continue;
			}

			if(isdefined(level.shouldignoreplayerrevive) && [[ level.shouldignoreplayerrevive ]](var_05))
			{
				continue;
			}

			if(distancesquared(self.origin,var_05.origin) < 4194304)
			{
				var_06 = spawnstruct();
				var_06.object = var_04;
				var_06.script_goal_radius = 64;
				if(isdefined(self.last_revive_fail_time) && gettime() - self.last_revive_fail_time < 1000)
				{
					var_06.script_goal_radius = 32;
				}

				var_06.start_thread = ::watch_bot_died_during_revive;
				var_06.end_thread = ::stop_reviving;
				var_06.should_abort = ::player_revived_or_dead;
				var_06.action_thread = ::revive_player;
				maps\mp\bots\_bots_strategy::bot_new_tactical_goal("revive",var_05.origin,60,var_06);
				break;
			}
		}
	}
}

//Function Number: 96
watch_bot_died_during_revive(param_00)
{
	if(isdefined(param_00.object))
	{
		thread bot_watch_for_death(param_00.object.owner);
	}
}

//Function Number: 97
stop_reviving(param_00)
{
	if(isdefined(param_00.object.owner))
	{
		param_00.object.owner.bots[self.team] = 0;
	}
}

//Function Number: 98
player_revived_or_dead(param_00)
{
	if(!isdefined(param_00.object.owner) || param_00.object.owner.health <= 0)
	{
		return 1;
	}

	if(!isdefined(param_00.object.owner.inlaststand) || !param_00.object.owner.inlaststand)
	{
		return 1;
	}

	return 0;
}

//Function Number: 99
revive_player(param_00)
{
	if(distancesquared(self.origin,param_00.object.owner.origin) > 4096)
	{
		self.last_revive_fail_time = gettime();
		return;
	}

	if(isagent(self))
	{
		common_scripts\utility::_enableusability();
		param_00.object enableplayeruse(self);
		wait(0.05);
	}

	var_01 = self.team;
	self notify("bot_reviving");
	self botpressbutton("use",level.laststandusetime / 1000 + 0.5);
	wait(level.laststandusetime / 1000 + 1.5);
	if(isdefined(param_00.object.owner))
	{
		param_00.object.bots[var_01] = 0;
	}

	if(isagent(self))
	{
		common_scripts\utility::_disableusability();
		if(isdefined(param_00.object))
		{
			param_00.object disableplayeruse(self);
		}
	}
}

//Function Number: 100
bot_can_revive()
{
	if(isdefined(self.laststand) && self.laststand == 1)
	{
		return 0;
	}

	if(maps\mp\bots\_bots_strategy::bot_has_tactical_goal("revive"))
	{
		return 0;
	}

	if(maps\mp\bots\_bots_util::bot_is_remote_or_linked())
	{
		return 0;
	}

	if(maps\mp\bots\_bots_util::bot_is_bodyguarding())
	{
		return 1;
	}

	var_00 = self botgetscriptgoaltype();
	if(var_00 == "none" || var_00 == "hunt" || var_00 == "guard")
	{
		return 1;
	}

	return 0;
}

//Function Number: 101
revive_watch_for_finished(param_00)
{
	self endon("death");
	self endon("disconnect");
	self endon("bad_path");
	self endon("goal");
	param_00 common_scripts\utility::waittill_any("death","revived");
	self notify("bad_path");
}

//Function Number: 102
bot_know_enemies_on_start()
{
	self endon("death");
	self endon("disconnect");
	level endon("game_ended");
	if(gettime() > 15000)
	{
		return;
	}

	while(!maps\mp\_utility::gamehasstarted() || !maps\mp\_utility::gameflag("prematch_done"))
	{
		wait(0.05);
	}

	var_00 = undefined;
	var_01 = undefined;
	for(var_02 = 0;var_02 < level.players.size;var_02++)
	{
		var_03 = level.players[var_02];
		if(isdefined(var_03) && isdefined(self.team) && isdefined(var_03.team) && !isalliedsentient(self,var_03))
		{
			if(!isdefined(var_03.bot_start_known_by_enemy))
			{
				var_00 = var_03;
			}

			if(isai(var_03) && !isdefined(var_03.bot_start_know_enemy))
			{
				var_01 = var_03;
			}
		}
	}

	if(isdefined(var_00))
	{
		self.bot_start_know_enemy = 1;
		var_00.bot_start_known_by_enemy = 1;
		self getenemyinfo(var_00);
	}

	if(isdefined(var_01))
	{
		var_01.bot_start_know_enemy = 1;
		self.bot_start_known_by_enemy = 1;
		var_01 getenemyinfo(self);
	}
}

//Function Number: 103
bot_make_entity_sentient(param_00,param_01)
{
	if(isdefined(param_01))
	{
		return self makeentitysentient(param_00,param_01);
	}

	return self makeentitysentient(param_00);
}

//Function Number: 104
bot_think_gametype()
{
	self notify("bot_think_gametype");
	self endon("bot_think_gametype");
	self endon("death");
	self endon("disconnect");
	level endon("game_ended");
	maps\mp\_utility::gameflagwait("prematch_done");
	self thread [[ level.bot_funcs["gametype_think"] ]]();
}

//Function Number: 105
default_gametype_think()
{
}

//Function Number: 106
monitor_smoke_grenades()
{
	for(;;)
	{
		level waittill("smoke",var_00,var_01);
		var_02 = maps\mp\_utility::strip_suffix(var_01,"_lefthand");
		if(var_02 == "smoke_grenade_mp")
		{
			var_00 thread handle_smoke(9.5);
		}
	}
}

//Function Number: 107
handle_smoke(param_00)
{
	self waittill("explode",var_01);
	var_02 = common_scripts\utility::spawn_tag_origin();
	var_02 show();
	var_02.origin = var_01;
	var_03 = 0.8;
	wait(var_03);
	var_03 = 0.5;
	var_04 = getent("smoke_grenade_sight_clip_64_short","targetname");
	if(isdefined(var_04))
	{
		var_02 clonebrushmodeltoscriptmodel(var_04);
	}

	wait(var_03);
	var_03 = 0.6;
	var_05 = getent("smoke_grenade_sight_clip_64_tall","targetname");
	if(isdefined(var_05))
	{
		var_02 clonebrushmodeltoscriptmodel(var_05);
	}

	wait(var_03);
	var_03 = param_00;
	var_06 = getent("smoke_grenade_sight_clip_256","targetname");
	if(isdefined(var_06))
	{
		var_02 clonebrushmodeltoscriptmodel(var_06);
	}

	wait(var_03);
	var_02 delete();
}

//Function Number: 108
bot_add_scavenger_bag(param_00)
{
	var_01 = 0;
	param_00.boxtype = "scavenger_bag";
	param_00.boxtouchonly = 1;
	if(!isdefined(level.bot_scavenger_bags))
	{
		level.bot_scavenger_bags = [];
	}

	foreach(var_04, var_03 in level.bot_scavenger_bags)
	{
		if(!isdefined(var_03))
		{
			var_01 = 1;
			level.bot_scavenger_bags[var_04] = param_00;
			break;
		}
	}

	if(!var_01)
	{
		level.bot_scavenger_bags[level.bot_scavenger_bags.size] = param_00;
	}

	foreach(var_06 in level.participants)
	{
		if(isai(var_06) && var_06 maps\mp\_utility::_hasperk("specialty_scavenger"))
		{
			var_06 notify("new_crate_to_take");
		}
	}
}

//Function Number: 109
bot_triggers()
{
	var_00 = getentarray("bot_flag_set","targetname");
	foreach(var_02 in var_00)
	{
		if(!isdefined(var_02.script_noteworthy))
		{
			continue;
		}

		var_02 thread bot_flag_trigger(var_02.script_noteworthy);
	}
}

//Function Number: 110
bot_flag_trigger(param_00)
{
	self endon("death");
	for(;;)
	{
		self waittill("trigger",var_01);
		if(maps\mp\_utility::isaigameparticipant(var_01))
		{
			var_01 notify("flag_trigger_set_" + param_00);
			var_01 botsetflag(param_00,1);
			var_01 thread bot_flag_trigger_clear(param_00);
		}
	}
}

//Function Number: 111
bot_flag_trigger_clear(param_00)
{
	self endon("flag_trigger_set_" + param_00);
	self endon("death");
	self endon("disconnect");
	level endon("game_ended");
	wait 0.05;
	waittillframeend;
	self botsetflag(param_00,0);
}