/*******************************************************************
 * Decompiled By: Bog
 * Decompiled File: maps\mp\bots\_bots.gsc
 * Game: Call of Duty: Ghosts
 * Platform: PC
 * Function Count: 109
 * Decompile Time: 2169 ms
 * Timestamp: 10/27/2023 1:17:05 AM
*******************************************************************/

//Function Number: 1
func_4FDD()
{
	if(maps\mp\_utility::func_47BB())
	{
		return;
	}

	if(isdefined(level.createfx_enabled) && level.createfx_enabled)
	{
		return;
	}

	if(level.script == "mp_character_room")
	{
		return;
	}

	func_710C();
	maps/mp/bots/_bots_personality::func_719E();
	level.badplace_cylinder_func = ::badplace_cylinder;
	level.badplace_delete_func = ::badplace_delete;
	maps/mp/bots/_bots_ks::bot_killstreak_setup();
	maps/mp/bots/_bots_loadout::func_44DF();
	level thread func_44DF();
}

//Function Number: 2
func_710C()
{
	level.bot_funcs = [];
	level.bot_funcs["bots_spawn"] = ::func_778F;
	level.bot_funcs["bots_add_scavenger_bag"] = ::func_1576;
	level.bot_funcs["bots_add_to_level_targets"] = ::maps/mp/bots/_bots_util::bot_add_to_bot_level_targets;
	level.bot_funcs["bots_remove_from_level_targets"] = ::maps/mp/bots/_bots_util::bot_remove_from_bot_level_targets;
	level.bot_funcs["bots_make_entity_sentient"] = ::func_1630;
	level.bot_funcs["think"] = ::func_16AB;
	level.bot_funcs["on_killed"] = ::func_58DB;
	level.bot_funcs["should_do_killcam"] = ::bot_should_do_killcam;
	level.bot_funcs["get_attacker_ent"] = ::maps/mp/bots/_bots_util::bot_get_known_attacker;
	level.bot_funcs["should_pickup_weapons"] = ::bot_should_pickup_weapons;
	level.bot_funcs["on_damaged"] = ::bot_damage_callback;
	level.bot_funcs["gametype_think"] = ::func_2495;
	level.bot_funcs["leader_dialog"] = ::maps/mp/bots/_bots_util::func_161D;
	level.bot_funcs["player_spawned"] = ::func_1661;
	level.bot_funcs["should_start_cautious_approach"] = ::maps/mp/bots/_bots_strategy::func_7490;
	level.bot_funcs["know_enemies_on_start"] = ::func_161A;
	level.bot_funcs["bot_get_rank_xp"] = ::bot_get_rank_xp;
	level.bot_funcs["ai_3d_sighting_model"] = ::bot_3d_sighting_model;
	level.bot_funcs["dropped_weapon_think"] = ::bot_think_seek_dropped_weapons;
	level.bot_funcs["dropped_weapon_cancel"] = ::func_7491;
	level.bot_funcs["crate_can_use"] = ::crate_can_use_always;
	level.bot_funcs["crate_low_ammo_check"] = ::crate_low_ammo_check;
	level.bot_funcs["crate_should_claim"] = ::func_2036;
	level.bot_funcs["crate_wait_use"] = ::func_2037;
	level.bot_funcs["crate_in_range"] = ::func_2030;
	level.bot_funcs["post_teleport"] = ::bot_post_teleport;
	level.bot_random_path_function = [];
	level.bot_random_path_function["allies"] = ::maps/mp/bots/_bots_personality::bot_random_path_default;
	level.bot_random_path_function["axis"] = ::maps/mp/bots/_bots_personality::bot_random_path_default;
	level.bot_can_use_box_by_type["deployable_vest"] = ::func_1698;
	level.bot_can_use_box_by_type["deployable_ammo"] = ::bot_should_use_ammo_crate;
	level.bot_can_use_box_by_type["scavenger_bag"] = ::bot_should_use_scavenger_bag;
	level.bot_can_use_box_by_type["deployable_grenades"] = ::bot_should_use_grenade_crate;
	level.bot_can_use_box_by_type["deployable_juicebox"] = ::func_169A;
	level.bot_pre_use_box_of_type["deployable_ammo"] = ::func_1666;
	level.bot_post_use_box_of_type["deployable_ammo"] = ::bot_post_use_ammo_crate;
	level.bot_find_defend_node_func["capture"] = ::maps/mp/bots/_bots_strategy::find_defend_node_capture;
	level.bot_find_defend_node_func["capture_zone"] = ::maps/mp/bots/_bots_strategy::func_3267;
	level.bot_find_defend_node_func["protect"] = ::maps/mp/bots/_bots_strategy::find_defend_node_protect;
	level.bot_find_defend_node_func["bodyguard"] = ::maps/mp/bots/_bots_strategy::func_3265;
	level.bot_find_defend_node_func["patrol"] = ::maps/mp/bots/_bots_strategy::func_3268;
	maps/mp/bots/_bots_gametype_war::func_710C();
	if(maps\mp\_utility::bot_is_fireteam_mode())
	{
		maps/mp/bots/_bots_fireteam::bot_fireteam_setup_callbacks();
	}
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
func_44DF()
{
	thread func_535C();
	thread bot_triggers();
	func_45F4();
	if(!func_74C4())
	{
	}

	func_643A();
	var_00 = botautoconnectenabled();
	if(var_00 > 0)
	{
		setmatchdata("hasBots",1);
		if(maps\mp\_utility::bot_is_fireteam_mode())
		{
			level thread maps/mp/bots/_bots_fireteam::func_15D3();
			level thread maps/mp/bots/_bots_fireteam_commander::func_44DF();
		}

		level thread bot_connect_monitor();
	}
}

//Function Number: 5
func_45F4()
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
	level.bot_respawn_launcher_name = "iw6_panzerfaust3";
	level.bot_fallback_weapon = "iw6_knifeonly";
	level.zonecount = getzonecount();
	func_45F5();
}

//Function Number: 6
func_45F5()
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
	level.var_1634 = 0;
	if(var_00.size > 1)
	{
		level.bot_map_min_x = var_00[0].origin[0];
		level.bot_map_max_x = var_00[0].origin[0];
		level.bot_map_min_y = var_00[0].origin[1];
		level.bot_map_max_y = var_00[0].origin[1];
		level.bot_map_min_z = var_00[0].origin[2];
		level.var_1634 = var_00[0].origin[2];
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

			if(var_02[2] > level.var_1634)
			{
				level.var_1634 = var_02[2];
			}
		}
	}

	level.bot_map_center = (level.bot_map_min_x + level.bot_map_max_x / 2,level.bot_map_min_y + level.bot_map_max_y / 2,level.bot_map_min_z + level.var_1634 / 2);
	level.bot_variables_initialized = 1;
}

//Function Number: 7
bot_post_teleport()
{
	level.bot_variables_initialized = undefined;
	level.bot_initialized_remote_vehicles = undefined;
	func_45F5();
	maps/mp/bots/_bots_ks_remote_vehicle::func_64D4();
}

//Function Number: 8
func_74C4()
{
	return 1;
}

//Function Number: 9
func_643A()
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
func_1661()
{
	func_168C();
	if(isdefined(self.prev_personality))
	{
		maps/mp/bots/_bots_util::bot_set_personality(self.prev_personality);
		self.prev_personality = undefined;
	}
}

//Function Number: 11
func_168C()
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
			}

			self.bot_class = maps/mp/bots/_bots_personality::bot_setup_callback_class();
		}

		self.bot_class = self.class;
	}
}

//Function Number: 12
func_8CAD()
{
	for(;;)
	{
		level waittill("connected",var_00);
		if(!isai(var_00) && level.players.size > 0)
		{
			level.players_waiting_to_join = common_scripts\utility::array_add(level.players_waiting_to_join,var_00);
			childthread func_16DF(var_00);
			childthread bots_notify_on_disconnect(var_00);
			childthread func_16E0(var_00);
		}
	}
}

//Function Number: 13
func_16DF(param_00)
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
func_16E0(param_00)
{
	param_00 common_scripts\utility::func_8B2A("bots_human_spawned","bots_human_disconnected");
	level.players_waiting_to_join = common_scripts\utility::array_remove(level.players_waiting_to_join,param_00);
}

//Function Number: 16
func_5354()
{
	level.players_waiting_to_join = [];
	childthread func_8CAD();
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
func_8FD9(param_00)
{
	if(maps\mp\_utility::func_50C1())
	{
		return 1;
	}

	if(getdvar("squad_vs_squad") == "1")
	{
		return 1;
	}

	if(!level.teambased)
	{
		return 1;
	}

	if(maps\mp\gametypes\_teams::func_3AE0(param_00))
	{
		return 1;
	}

	return 0;
}

//Function Number: 18
bot_connect_monitor(param_00,param_01)
{
	level endon("game_ended");
	self notify("bot_connect_monitor");
	self endon("bot_connect_monitor");
	level.pausing_bot_connect_monitor = 0;
	childthread func_5354();
	maps\mp\gametypes\_hostmigration::func_8B0D(0.5);
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

	if(getdvar("squad_vs_squad") == "1")
	{
		while(!isdefined(level.squad_vs_squad_allies_client) && isdefined(level.squad_vs_squad_axis_client))
		{
			wait(0.05);
		}

		wait(2);
	}

	if(getdvar("squad_match") == "1")
	{
		while(!isdefined(level.squad_match_client))
		{
			wait(0.05);
		}

		wait(2);
	}

	if(getdvar("squad_use_hosts_squad") == "1")
	{
		while(!isdefined(level.wargame_client))
		{
			wait(0.05);
		}

		wait(2);
	}

	for(;;)
	{
		if(level.pausing_bot_connect_monitor)
		{
			maps\mp\gametypes\_hostmigration::func_8B0D(var_02);
			continue;
		}

		var_03 = isdefined(level.bots_ignore_team_balance) || !level.teambased;
		var_04 = botgetteamlimit(0);
		var_05 = botgetteamlimit(1);
		var_06 = botgetteamdifficulty(0);
		var_07 = botgetteamdifficulty(1);
		var_08 = "allies";
		var_09 = "axis";
		var_0A = bot_client_counts();
		var_0B = cat_array_get(var_0A,"humans");
		if(var_0B > 1)
		{
			var_0C = bot_get_host_team();
			if(!maps\mp\_utility::func_50C1() && isdefined(var_0C) && var_0C != "spectator")
			{
				var_08 = var_0C;
				var_09 = maps\mp\_utility::getotherteam(var_0C);
			}
			else
			{
				var_0D = cat_array_get(var_0A,"humans_allies");
				var_0E = cat_array_get(var_0A,"humans_axis");
				if(var_0E > var_0D)
				{
					var_08 = "axis";
					var_09 = "allies";
				}
			}
		}
		else
		{
			var_0F = get_human_player();
			if(isdefined(var_0F))
			{
				var_10 = var_0F bot_get_player_team();
				if(isdefined(var_10) && var_10 != "spectator")
				{
					var_08 = var_10;
					var_09 = maps\mp\_utility::getotherteam(var_10);
				}
			}
		}

		var_11 = maps/mp/bots/_bots_util::bot_get_team_limit();
		var_12 = maps/mp/bots/_bots_util::bot_get_team_limit();
		if(var_11 + var_12 < maps/mp/bots/_bots_util::bot_get_client_limit())
		{
			if(var_11 < var_04)
			{
				var_11++;
			}
			else if(var_12 < var_05)
			{
				var_12++;
			}
		}

		var_13 = cat_array_get(var_0A,"humans_" + var_08);
		var_14 = cat_array_get(var_0A,"humans_" + var_09);
		var_15 = var_13 + var_14;
		var_16 = cat_array_get(var_0A,"spectator");
		var_17 = 0;
		var_18 = 0;
		while(var_16 > 0)
		{
			var_19 = var_13 + var_17 + 1 <= var_11;
			var_1A = var_14 + var_18 + 1 <= var_12;
			if(var_19 && !var_1A)
			{
				var_17++;
				continue;
			}

			if(!var_19 && var_1A)
			{
				var_18++;
				continue;
			}

			if(var_19 && var_1A)
			{
				if(var_16 % 2 == 1)
				{
					var_17++;
					continue;
				}

				var_18++;
			}

			var_16--;
		}

		var_1B = cat_array_get(var_0A,"bots_" + var_08);
		var_1C = cat_array_get(var_0A,"bots_" + var_09);
		var_1D = var_1B + var_1C;
		if(var_1D > 0)
		{
			level.bot_cm_spawned_bots = 1;
		}

		var_1E = 0;
		if(!level.bot_cm_human_picked)
		{
			var_1E = !func_8FEE();
			if(!var_1E)
			{
				level.bot_cm_human_picked = 1;
			}
		}

		if(var_1E)
		{
			var_1F = !getdvarint("systemlink") && !getdvarint("onlinegame");
			var_20 = !var_03 && var_05 != var_04 && !level.bot_cm_spawned_bots && level.bot_cm_waited_players_time < 10 || !maps\mp\_utility::func_36F1("prematch_done");
			if(var_1F || var_20)
			{
				level.bot_cm_waited_players_time = level.bot_cm_waited_players_time + var_02;
				maps\mp\gametypes\_hostmigration::func_8B0D(var_02);
				continue;
			}
		}

		var_21 = int(min(var_11 - var_13 - var_17,var_04));
		var_22 = int(min(var_12 - var_14 - var_18,var_05));
		var_23 = 1;
		var_24 = var_21 + var_22 + var_0B;
		var_25 = var_04 + var_05 + var_0B;
		var_26 = [-1,-1];
		while(var_24 < maps/mp/bots/_bots_util::bot_get_client_limit() && var_24 < var_25)
		{
			if(var_23 && var_21 < var_04 && func_8FD9(var_08))
			{
				var_21++;
			}
			else if(!var_23 && var_22 < var_05 && func_8FD9(var_09))
			{
				var_22++;
			}

			var_24 = var_21 + var_22 + var_0B;
			if(var_26[var_23] == var_24)
			{
				break;
			}

			var_26[var_23] = var_24;
			var_23 = !var_23;
		}

		if(var_04 == var_05 && !var_03 && var_17 == 1 && var_18 == 0 && var_22 > 0)
		{
			if(!isdefined(level.bot_prematchdonetime) && maps\mp\_utility::func_36F1("prematch_done"))
			{
				level.bot_prematchdonetime = gettime();
			}

			if(var_1E && !isdefined(level.bot_prematchdonetime) || gettime() - level.bot_prematchdonetime < 10000)
			{
				var_22--;
			}
		}

		var_27 = var_21 - var_1B;
		var_28 = var_22 - var_1C;
		var_29 = 1;
		if(var_03)
		{
			var_2A = var_11 + var_12;
			var_2B = var_04 + var_05;
			var_2C = var_13 + var_14;
			var_2D = var_1B + var_1C;
			var_2E = int(min(var_2A - var_2C,var_2B));
			var_2F = var_2E - var_2D;
			if(var_2F == 0)
			{
				var_29 = 0;
			}
			else if(var_2F > 0)
			{
				var_27 = int(var_2F / 2) + var_2F % 2;
				var_28 = int(var_2F / 2);
			}
			else if(var_2F < 0)
			{
				var_30 = var_2F * -1;
				var_27 = -1 * int(min(var_30,var_1B));
				var_28 = -1 * var_30 + var_27;
			}
		}
		else if(!maps\mp\_utility::func_50C1() && var_27 * var_28 < 0 && maps\mp\_utility::func_36F1("prematch_done") && !isdefined(level.bots_disable_team_switching))
		{
			var_31 = int(min(abs(var_27),abs(var_28)));
			if(var_27 > 0)
			{
				func_5435(var_31,var_09,var_08,var_06);
			}
			else if(var_28 > 0)
			{
				func_5435(var_31,var_08,var_09,var_07);
			}

			var_29 = 0;
		}

		if(var_29)
		{
			if(var_28 < 0)
			{
				func_2B33(var_28 * -1,var_09);
			}

			if(var_27 < 0)
			{
				func_2B33(var_27 * -1,var_08);
			}

			if(var_28 > 0)
			{
				level thread func_778F(var_28,var_09,undefined,undefined,"spawned_enemies",var_07);
			}

			if(var_27 > 0)
			{
				level thread func_778F(var_27,var_08,undefined,undefined,"spawned_allies",var_06);
			}

			if(var_28 > 0 && var_27 > 0)
			{
				level common_scripts\utility::func_8B73("spawned_enemies","spawned_allies");
			}
			else if(var_28 > 0)
			{
				level waittill("spawned_enemies");
			}
			else if(var_27 > 0)
			{
				level waittill("spawned_allies");
			}
		}

		if(var_07 != var_06)
		{
			bots_update_difficulty(var_09,var_07);
			bots_update_difficulty(var_08,var_06);
		}

		maps\mp\gametypes\_hostmigration::func_8B0D(var_02);
	}
}

//Function Number: 19
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

//Function Number: 20
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

//Function Number: 21
func_8FEE()
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

			if(func_93A7(var_04))
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

//Function Number: 22
func_93A7(param_00)
{
	if(isdefined(param_00.team) && param_00.team != "spectator")
	{
		return 1;
	}

	if(isdefined(param_00.spectating_actively) && param_00.spectating_actively)
	{
		return 1;
	}

	if(param_00 ismlgspectator() && isdefined(param_00.team) && param_00.team == "spectator")
	{
		return 1;
	}

	return 0;
}

//Function Number: 23
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

//Function Number: 24
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

//Function Number: 25
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

//Function Number: 26
func_5435(param_00,param_01,param_02,param_03)
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
				var_05 maps/mp/bots/_bots_util::bot_set_difficulty(param_03);
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

//Function Number: 27
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
				var_03 maps/mp/bots/_bots_util::bot_set_difficulty(param_01);
			}
		}
	}
}

//Function Number: 28
bot_drop()
{
	kick(self.entity_number,"EXE_PLAYERKICKED_BOT_BALANCE");
	wait(0.1);
}

//Function Number: 29
func_2B33(param_00,param_01)
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

		if(!maps\mp\_utility::func_4945(var_02[var_06]))
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

//Function Number: 30
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

//Function Number: 31
func_778E(param_00,param_01,param_02)
{
	var_03 = gettime() + -5536;
	while(!self canspawntestclient())
	{
		if(gettime() >= var_03)
		{
			kick(self.entity_number,"EXE_PLAYERKICKED_BOT_BALANCE");
			param_02.abort = 1;
		}

		wait(0.05);
		if(!isdefined(self))
		{
			param_02.abort = 1;
		}
	}

	maps\mp\gametypes\_hostmigration::func_8B0D(randomfloatrange(0.25,2));
	if(!isdefined(self))
	{
		param_02.abort = 1;
	}

	self spawntestclient();
	self.pers["isBot"] = 1;
	self.equipment_enabled = 1;
	self.bot_team = param_00;
	if(isdefined(param_02.difficulty))
	{
		maps/mp/bots/_bots_util::bot_set_difficulty(param_02.difficulty);
	}

	if(isdefined(param_01))
	{
		self [[ param_01 ]]();
	}

	self thread [[ level.bot_funcs["think"] ]]();
	param_02.ready = 1;
}

//Function Number: 32
func_9150(param_00,param_01)
{
	var_02 = param_00 getrankedplayerdata("activeSquadMember");
	var_03 = 0;
	for(var_04 = 0;var_04 < 10;var_04++)
	{
		var_03 = 0;
		var_05 = param_00 getrankedplayerdata("squadHQ","aiSquadMembers",var_04);
		if(var_05 == var_02)
		{
			var_04++;
			continue;
		}

		if(!isdefined(level.human_team_bot_added) || !isdefined(level.human_team_bot_added[var_05]) || level.human_team_bot_added[var_05] == 0)
		{
			return var_05;
		}
	}

	return -1;
}

//Function Number: 33
func_778F(param_00,param_01,param_02,param_03,param_04,param_05)
{
	var_06 = gettime() + 10000;
	var_07 = [];
	var_08 = var_07.size;
	while(level.players.size < maps/mp/bots/_bots_util::bot_get_client_limit() && var_07.size < param_00 && gettime() < var_06)
	{
		maps\mp\gametypes\_hostmigration::func_8B0D(0.05);
		var_09 = undefined;
		if(getdvar("squad_vs_squad") == "1")
		{
			var_0A = level.squad_vs_squad_axis_client;
			if(param_01 == "allies")
			{
				var_0A = level.squad_vs_squad_allies_client;
			}

			if(isdefined(var_0A))
			{
				var_0B = var_08;
				var_0C = var_0A getrankedplayerdata("activeSquadMember");
				var_0D = 0;
				var_0E = 0;
				for(var_0F = 0;var_0F < maps/mp/bots/_bots_util::bot_get_team_limit();var_0F++)
				{
					var_0E = var_0A getrankedplayerdata("squadHQ","aiSquadMembers",var_0F);
					if(var_0E == var_0C)
					{
						continue;
					}

					if(var_0B == var_0D)
					{
						break;
					}

					var_0D++;
				}

				var_10 = var_0A getrankedplayerdata("squadMembers",var_0E,"name");
				var_11 = var_0A getrankedplayerdata("squadMembers",var_0E,"head");
				var_12 = var_0A getrankedplayerdata("squadMembers",var_0E,"body");
				var_13 = var_0A getrankedplayerdata("squadMembers",var_0E,"helmet");
				var_09 = addbot(var_10,var_11,var_12,var_13);
				if(isdefined(var_09))
				{
					var_09.pers["squadSlot"] = var_0E;
				}
			}
			else if(!isdefined(level.squad_vs_squad_has_forfeited))
			{
				if(isdefined(level.squad_vs_squad_axis_client))
				{
					level.finalkillcam_winner = "axis";
					thread maps\mp\gametypes\_gamelogic::endgame("axis",game["end_reason"]["allies_forfeited"]);
				}
				else
				{
					level.finalkillcam_winner = "allies";
					thread maps\mp\gametypes\_gamelogic::endgame("allies",game["end_reason"]["axis_forfeited"]);
				}

				level.squad_vs_squad_has_forfeited = 1;
			}
		}
		else if(getdvar("squad_use_hosts_squad") == "1")
		{
			if(level.wargame_client.team == param_01)
			{
				if(maps\mp\_utility::func_50C1())
				{
					var_0E = func_9150(level.wargame_client,param_01);
					var_10 = level.wargame_client getrankedplayerdata("squadMembers",var_0E,"name");
					var_11 = level.wargame_client getrankedplayerdata("squadMembers",var_0E,"head");
					var_12 = level.wargame_client getrankedplayerdata("squadMembers",var_0E,"body");
					var_13 = level.wargame_client getrankedplayerdata("squadMembers",var_0E,"helmet");
					var_09 = addbot(var_10,var_11,var_12,var_13);
					if(isdefined(var_09))
					{
						level.human_team_bot_added[var_0E] = 1;
						var_09.pers["squadSlot"] = var_0E;
					}
				}
				else
				{
					var_0B = var_11;
					var_0C = level.wargame_client getprivateplayerdata("privateMatchActiveSquadMember");
					var_0D = 0;
					var_0E = 0;
					for(var_0F = 0;var_0F < maps/mp/bots/_bots_util::bot_get_team_limit();var_0F++)
					{
						var_0E = var_0F;
						if(var_0F == var_0C)
						{
							continue;
						}

						if(var_0B == var_0D)
						{
							break;
						}

						var_0D++;
					}

					var_10 = level.wargame_client getprivateplayerdata("privateMatchSquadMembers",var_0E,"name");
					var_11 = level.wargame_client getprivateplayerdata("privateMatchSquadMembers",var_0E,"head");
					var_12 = level.wargame_client getprivateplayerdata("privateMatchSquadMembers",var_0E,"body");
					var_13 = level.wargame_client getprivateplayerdata("privateMatchSquadMembers",var_0E,"helmet");
					var_09 = addbot(var_10,var_11,var_12,var_13);
					if(isdefined(var_09))
					{
						var_09.pers["squadSlot"] = var_0E;
					}
				}
			}
			else
			{
				var_09 = addbot("",0,0,0);
			}
		}
		else if(getdvar("squad_match") == "1")
		{
			if(param_01 == "axis")
			{
				var_0E = getenemysquaddata("squadHQ","aiSquadMembers",var_08);
				var_10 = getenemysquaddata("squadMembers",var_0E,"name");
				var_11 = getenemysquaddata("squadMembers",var_0E,"head");
				var_12 = getenemysquaddata("squadMembers",var_0E,"body");
				var_13 = getenemysquaddata("squadMembers",var_0E,"helmet");
				var_09 = addbot(var_10,var_11,var_12,var_13);
				if(isdefined(var_09))
				{
					var_09.pers["squadSlot"] = var_0E;
				}
			}
			else
			{
				var_0E = func_9150(level.squad_match_client,param_02);
				if(var_0E > -1)
				{
					var_10 = level.squad_match_client getrankedplayerdata("squadMembers",var_0E,"name");
					var_11 = level.squad_match_client getrankedplayerdata("squadMembers",var_0E,"head");
					var_12 = level.squad_match_client getrankedplayerdata("squadMembers",var_0E,"body");
					var_13 = level.squad_match_client getrankedplayerdata("squadMembers",var_0E,"helmet");
					var_09 = addbot(var_10,var_11,var_12,var_13);
					if(isdefined(var_09))
					{
						level.human_team_bot_added[var_0E] = 1;
						var_09.pers["squadSlot"] = var_0E;
					}
				}
			}
		}
		else
		{
			var_09 = addbot("",0,0,0);
		}

		if(!isdefined(var_09))
		{
			if(isdefined(param_03) && param_03)
			{
				if(isdefined(param_04))
				{
					self notify(param_04);
				}
			}

			maps\mp\gametypes\_hostmigration::func_8B0D(1);
			continue;
		}
		else
		{
			var_14 = spawnstruct();
			var_14.bot = var_09;
			var_14.ready = 0;
			var_14.abort = 0;
			var_14.index = var_08;
			var_14.difficulty = param_05;
			var_07[var_07.size] = var_14;
			var_14.bot thread func_778E(param_01,param_02,var_14);
			var_08++;
		}
	}

	var_15 = 0;
	var_06 = gettime() + -5536;
	while(var_15 < var_07.size && gettime() < var_06)
	{
		var_15 = 0;
		foreach(var_14 in var_07)
		{
			if(var_14.ready || var_14.abort)
			{
				var_15++;
			}
		}

		wait(0.05);
	}

	if(isdefined(param_04))
	{
		self notify(param_04);
	}
}

//Function Number: 34
bot_gametype_chooses_team()
{
	if(!level.teambased)
	{
		return 1;
	}

	if(isdefined(level.bots_gametype_handles_team_choice) && level.bots_gametype_handles_team_choice)
	{
		return 1;
	}

	return 0;
}

//Function Number: 35
bot_gametype_chooses_class()
{
	return isdefined(level.bots_gametype_handles_class_choice) && level.bots_gametype_handles_class_choice;
}

//Function Number: 36
func_16AB()
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

	maps/mp/bots/_bots_ks::bot_killstreak_setup();
	self.entity_number = self getentitynumber();
	var_01 = 0;
	if(!isdefined(self.bot_spawned_before))
	{
		var_01 = 1;
		self.bot_spawned_before = 1;
		if(!bot_gametype_chooses_team())
		{
			self notify("luinotifyserver","team_select",bot_lui_convert_team_to_int(var_00));
			wait(0.5);
			if(self.pers["team"] == "spectator")
			{
				bot_drop();
			}
		}
	}

	for(;;)
	{
		maps/mp/bots/_bots_util::bot_set_difficulty(self botgetdifficulty());
		var_02 = self botgetdifficultysetting("advancedPersonality");
		if(var_01 && isdefined(var_02) && var_02 != 0)
		{
			maps/mp/bots/_bots_personality::bot_balance_personality();
		}

		maps/mp/bots/_bots_personality::func_157C();
		if(var_01)
		{
			func_168C();
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
		func_6633();
		self waittill("spawned_player");
	}
}

//Function Number: 37
func_6633()
{
	self endon("started_spawnPlayer");
	while(!self.waitingtospawn)
	{
		wait(0.05);
	}

	if(maps\mp\gametypes\_playerlogic::func_5591())
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

//Function Number: 38
bot_get_rank_xp()
{
	if(maps\mp\_utility::func_8FFB() == 0)
	{
		if(!isdefined(self.pers["rankxp"]))
		{
			self.pers["rankxp"] = 0;
		}

		return self.pers["rankxp"];
	}

	var_00 = self botgetdifficulty();
	var_01 = "bot_rank_" + var_00;
	if(isdefined(self.pers[var_01]) && self.pers[var_01] > 0)
	{
		return self.pers[var_01];
	}

	var_02 = bot_random_ranks_for_difficulty(var_00);
	var_03 = var_02["rank"];
	var_04 = var_02["prestige"];
	var_05 = maps\mp\gametypes\_rank::func_3BC7(var_03);
	var_06 = var_05 + maps\mp\gametypes\_rank::func_3BC8(var_03);
	var_07 = randomintrange(var_05,var_06 + 1);
	self.pers[var_01] = var_07;
	return var_07;
}

//Function Number: 39
bot_3d_sighting_model(param_00)
{
	thread bot_3d_sighting_model_thread(param_00);
}

//Function Number: 40
bot_3d_sighting_model_thread(param_00)
{
	param_00 endon("disconnect");
	self endon("disconnect");
	level endon("game_ended");
	for(;;)
	{
		if(isalive(self) && !self botcanseeentity(param_00) && common_scripts\utility::func_8E18(self.origin,self.angles,param_00.origin,self botgetfovdot()))
		{
			self botgetimperfectenemyinfo(param_00,param_00.origin);
		}

		wait(0.1);
	}
}

//Function Number: 41
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
		level.bot_rnd_rank["recruit"][1] = 7;
		level.bot_rnd_rank["regular"][0] = 9;
		level.bot_rnd_rank["regular"][1] = 37;
		level.bot_rnd_rank["hardened"][0] = 39;
		level.bot_rnd_rank["hardened"][1] = 57;
		level.bot_rnd_rank["veteran"][0] = 59;
		level.bot_rnd_rank["veteran"][1] = 59;
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

	if(isdefined(level.bot_rnd_rank[param_00][0]) && isdefined(level.bot_rnd_rank[param_00][1]))
	{
		var_01["rank"] = randomintrange(level.bot_rnd_rank[param_00][0],level.bot_rnd_rank[param_00][1] + 1);
	}

	if(isdefined(level.bot_rnd_prestige[param_00][0]) && isdefined(level.bot_rnd_prestige[param_00][1]))
	{
		var_01["prestige"] = randomintrange(level.bot_rnd_prestige[param_00][0],level.bot_rnd_prestige[param_00][1] + 1);
	}

	return var_01;
}

//Function Number: 42
crate_can_use_always(param_00)
{
	if(isagent(self) && !isdefined(param_00.boxtype))
	{
		return 0;
	}

	return 1;
}

//Function Number: 43
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

//Function Number: 44
bot_damage_callback(param_00,param_01,param_02,param_03,param_04,param_05)
{
	if(!isdefined(self) || !isalive(self))
	{
	}

	if(param_02 == "MOD_FALLING" || param_02 == "MOD_SUICIDE")
	{
	}

	if(param_01 <= 0)
	{
	}

	if(!isdefined(param_04))
	{
		if(!isdefined(param_00))
		{
		}

		param_04 = param_00;
	}

	if(isdefined(param_04))
	{
		if(level.teambased)
		{
			if(isdefined(param_04.team) && param_04.team == self.team)
			{
			}
			else if(isdefined(param_00) && isdefined(param_00.team) && param_00.team == self.team)
			{
			}
		}

		var_06 = maps/mp/bots/_bots_util::bot_get_known_attacker(param_00,param_04);
		if(isdefined(var_06))
		{
			self botsetattacker(var_06);
		}
	}
}

//Function Number: 45
func_58DB(param_00,param_01,param_02,param_03,param_04,param_05,param_06,param_07,param_08,param_09)
{
	self botclearscriptenemy();
	self botclearscriptgoal();
	var_0A = maps/mp/bots/_bots_util::bot_get_known_attacker(param_01,param_00);
	if(!maps\mp\_utility::bot_is_fireteam_mode() && getdvar("squad_match") != "1" && getdvar("squad_vs_squad") != "1" && isdefined(var_0A) && var_0A.classname == "script_vehicle" && isdefined(var_0A.helitype))
	{
		var_0B = self botgetdifficultysetting("launcherRespawnChance");
		if(randomfloat(1) < var_0B)
		{
			self.respawn_with_launcher = 1;
		}
	}
}

//Function Number: 46
bot_should_do_killcam()
{
	if(maps\mp\_utility::bot_is_fireteam_mode())
	{
		return 0;
	}

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

//Function Number: 47
bot_should_pickup_weapons()
{
	if(maps\mp\_utility::isjuggernaut())
	{
		return 0;
	}

	return 1;
}

//Function Number: 48
bot_restart_think_threads()
{
	thread bot_think_watch_enemy();
	thread maps/mp/bots/_bots_strategy::bot_think_tactical_goals();
	self thread [[ level.bot_funcs["dropped_weapon_think"] ]]();
	thread func_16B0();
	thread bot_think_crate();
	thread bot_think_crate_blocking_path();
	thread maps/mp/bots/_bots_ks::bot_think_killstreak();
	thread maps/mp/bots/_bots_ks::func_16B4();
	thread bot_think_gametype();
}

//Function Number: 49
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

//Function Number: 50
bot_think_seek_dropped_weapons()
{
	self notify("bot_think_seek_dropped_weapons");
	self endon("bot_think_seek_dropped_weapons");
	self endon("death");
	self endon("disconnect");
	level endon("game_ended");
	var_00 = "throwingknife_mp";
	var_01 = "throwingknifejugg_mp";
	for(;;)
	{
		var_02 = 0;
		if(maps/mp/bots/_bots_util::bot_out_of_ammo() && self [[ level.bot_funcs["should_pickup_weapons"] ]]() && !maps/mp/bots/_bots_util::bot_is_remote_or_linked())
		{
			var_03 = getentarray("dropped_weapon","targetname");
			var_04 = common_scripts\utility::func_37D5(self.origin,var_03);
			if(var_04.size > 0)
			{
				var_05 = var_04[0];
				bot_seek_dropped_weapon(var_05);
			}
		}

		if(!maps/mp/bots/_bots_util::bot_in_combat() && !maps/mp/bots/_bots_util::bot_is_remote_or_linked() && self botgetdifficultysetting("strategyLevel") > 0)
		{
			var_06 = self hasweapon(var_00);
			var_07 = self hasweapon(var_01);
			var_08 = (var_06 && self getammocount(var_00) == 0) || var_07 && self getammocount(var_01) == 0;
			if(var_08)
			{
				if(isdefined(self.going_for_knife))
				{
					wait(5);
					continue;
				}

				var_09 = getentarray("dropped_knife","targetname");
				var_0A = common_scripts\utility::func_37D5(self.origin,var_09);
				foreach(var_0C in var_0A)
				{
					if(!isdefined(var_0C))
					{
						continue;
					}

					if(!isdefined(var_0C.calculated_closest_point))
					{
						var_0D = maps/mp/bots/_bots_util::bot_queued_process("BotGetClosestNavigablePoint",::maps/mp/bots/_bots_util::func_35A6,var_0C.origin,32,self);
						if(isdefined(var_0C))
						{
							var_0C.closest_point_on_grid = var_0D;
							var_0C.calculated_closest_point = 1;
						}
						else
						{
							continue;
						}
					}

					if(isdefined(var_0C.closest_point_on_grid))
					{
						self.going_for_knife = 1;
						bot_seek_dropped_weapon(var_0C);
					}
				}
			}
			else if(var_06 || var_07)
			{
				self.going_for_knife = undefined;
			}
		}

		wait(randomfloatrange(0.25,0.75));
	}
}

//Function Number: 51
bot_seek_dropped_weapon(param_00)
{
	if(maps/mp/bots/_bots_strategy::bot_has_tactical_goal("seek_dropped_weapon",param_00) == 0)
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
		maps/mp/bots/_bots_strategy::bot_new_tactical_goal("seek_dropped_weapon",param_00.origin,100,var_07);
	}
}

//Function Number: 52
bot_pickup_weapon(param_00)
{
	self botpressbutton("use",2);
	wait(2);
}

//Function Number: 53
func_7491(param_00)
{
	if(!isdefined(param_00.object))
	{
		return 1;
	}

	if(param_00.object.targetname == "dropped_weapon")
	{
		if(maps/mp/bots/_bots_util::bot_get_total_gun_ammo() > 0)
		{
			return 1;
		}
	}
	else if(param_00.object.targetname == "dropped_knife")
	{
		if(maps/mp/bots/_bots_util::bot_in_combat())
		{
			self.going_for_knife = undefined;
			return 1;
		}
	}

	return 0;
}

//Function Number: 54
func_16B0(param_00)
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

		if(maps/mp/bots/_bots_strategy::bot_has_tactical_goal("map_interactive_object"))
		{
			continue;
		}

		if(maps/mp/bots/_bots_util::bot_in_combat() || maps/mp/bots/_bots_util::bot_is_remote_or_linked())
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

			var_05 = common_scripts\utility::func_37D5(self.origin,level.level_specific_bot_targets);
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
			var_07 = func_1695(var_01);
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
				var_0F.should_abort = ::func_4DB1;
			}
			else
			{
				var_0F.should_abort = ::func_4DB2;
			}
		}

		if(var_01.bot_interaction_type == "use")
		{
			var_0F.action_thread = ::func_87A2;
			var_0F.should_abort = ::func_4DB0;
			var_0F.script_goal_yaw = vectortoangles(var_01.origin - var_01.bot_target.origin)[1];
			maps/mp/bots/_bots_strategy::bot_new_tactical_goal("map_interactive_object",var_01.bot_target.origin,10,var_0F);
			continue;
		}

		if(var_01.bot_interaction_type == "damage")
		{
			if(var_07)
			{
				var_0F.action_thread = ::func_5153;
				var_0F.script_goal_radius = 20;
			}
			else
			{
				var_0F.action_thread = ::attack_damage_trigger;
				var_0F.script_goal_radius = 50;
			}

			var_10 = undefined;
			var_11 = maps/mp/bots/_bots_util::bot_queued_process("GetPathDistLevelAction",::maps/mp/bots/_bots_util::func_35AC,self.origin,var_01.bot_targets[0].origin);
			var_12 = maps/mp/bots/_bots_util::bot_queued_process("GetPathDistLevelAction",::maps/mp/bots/_bots_util::func_35AC,self.origin,var_01.bot_targets[1].origin);
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
				childthread func_5351(var_10);
			}

			maps/mp/bots/_bots_strategy::bot_new_tactical_goal("map_interactive_object",var_10.origin,10,var_0F);
		}
	}
}

//Function Number: 55
func_1695(param_00)
{
	var_01 = self getcurrentweapon();
	var_02 = maps/mp/bots/_bots_util::bot_out_of_ammo() || self.hasriotshieldequipped || isdefined(self.isjuggernautmaniac) && self.isjuggernautmaniac == 1 || weaponclass(var_01) == "grenade" || var_01 == "iw6_knifeonly_mp" || var_01 == "iw6_knifeonlyfast_mp";
	return var_02;
}

//Function Number: 56
func_5351(param_00)
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
			if(nodesvisible(var_01,param_00))
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

//Function Number: 57
attack_damage_trigger(param_00)
{
	if(param_00.object.origin[2] - self geteye()[2] > 55)
	{
		if(distance2dsquared(param_00.object.origin,self.origin) < 225)
		{
		}
	}

	self botsetflag("disable_movement",1);
	func_4F41(param_00.object,0.3);
	self botpressbutton("ads",0.3);
	wait(0.25);
	var_01 = gettime();
	while(isdefined(param_00.object) && !isdefined(param_00.object.already_used) && gettime() - var_01 < 5000)
	{
		func_4F41(param_00.object,0.15);
		self botpressbutton("ads",0.15);
		self botpressbutton("attack");
		wait(0.1);
	}

	self botsetflag("disable_movement",0);
}

//Function Number: 58
func_5153(param_00)
{
	self botsetflag("disable_movement",1);
	func_4F41(param_00.object,0.3);
	wait(0.25);
	var_01 = gettime();
	while(isdefined(param_00.object) && !isdefined(param_00.object.already_used) && gettime() - var_01 < 5000)
	{
		func_4F41(param_00.object,0.15);
		self botpressbutton("melee");
		wait(0.1);
	}

	self botsetflag("disable_movement",0);
}

//Function Number: 59
func_4F41(param_00,param_01)
{
	var_02 = param_00.origin;
	if(distance2dsquared(self.origin,var_02) < 100)
	{
		var_02 = (var_02[0],var_02[1],self geteye()[2]);
	}

	self botlookatpoint(var_02,param_01,"script_forced");
}

//Function Number: 60
func_87A2(param_00)
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

//Function Number: 61
func_4DB1(param_00)
{
	if(func_4DB0(param_00))
	{
		return 1;
	}

	if(!func_1695(param_00.object))
	{
		return 1;
	}

	return 0;
}

//Function Number: 62
func_4DB2(param_00)
{
	if(func_4DB0(param_00))
	{
		return 1;
	}

	if(func_1695(param_00.object))
	{
		return 1;
	}

	return 0;
}

//Function Number: 63
func_4DB0(param_00)
{
	if(!isdefined(param_00.object))
	{
		return 1;
	}

	if(isdefined(param_00.object.already_used))
	{
		return 1;
	}

	if(maps/mp/bots/_bots_util::bot_in_combat())
	{
		return 1;
	}

	return 0;
}

//Function Number: 64
func_2030(param_00)
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

//Function Number: 65
bot_crate_valid(param_00)
{
	if(!isdefined(param_00))
	{
		return 0;
	}

	if(!self [[ level.bot_funcs["crate_can_use"] ]](param_00))
	{
		return 0;
	}

	if(!func_2032(param_00))
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
		if(isdefined(level.boxsettings[param_00.boxtype]) && ![[ level.boxsettings[param_00.boxtype].canusecallback ]]())
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

//Function Number: 66
func_2032(param_00)
{
	if(!func_202F(param_00))
	{
		return 0;
	}

	if(!func_2031(param_00))
	{
		return 0;
	}

	return isdefined(param_00);
}

//Function Number: 67
func_202F(param_00)
{
	if(isdefined(param_00.boxtype))
	{
		return gettime() > param_00.birthtime + 1000;
	}

	return isdefined(param_00.droppingtoground) && !param_00.droppingtoground;
}

//Function Number: 68
func_2031(param_00)
{
	if(!isdefined(param_00.on_path_grid))
	{
		crate_calculate_on_path_grid(param_00);
	}

	return isdefined(param_00) && param_00.on_path_grid;
}

//Function Number: 69
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

//Function Number: 70
crate_calculate_on_path_grid(param_00)
{
	param_00 thread func_2034();
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
	}

	var_03 = func_202E(param_00);
	if(!isdefined(param_00))
	{
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
			if(maps/mp/bots/_bots_util::bot_point_is_on_pathgrid(param_00.origin))
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

//Function Number: 71
func_202E(param_00)
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
				var_09 = common_scripts\utility::func_6306(var_03);
				if(distancesquared(var_06.origin,var_09.origin) > 250000)
				{
					var_07 = var_09;
				}
			}

			if(isdefined(var_07))
			{
				var_0A = maps/mp/bots/_bots_util::bot_queued_process("GetNodesOnPathCrate",::maps/mp/bots/_bots_util::func_get_nodes_on_path,var_06.origin,var_07.origin);
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

//Function Number: 72
crate_get_bot_target(param_00)
{
	if(isdefined(param_00.nearest_points))
	{
		return param_00.nearest_points[0];
	}

	if(isdefined(param_00.nearest_nodes))
	{
		if(param_00.nearest_nodes.size > 1)
		{
			var_01 = common_scripts\utility::array_reverse(self botnodescoremultiple(param_00.nearest_nodes,"node_exposed"));
			return common_scripts\utility::random_weight_sorted(var_01).origin;
		}
		else
		{
			return var_01.nearest_nodes[0].origin;
		}
	}
}

//Function Number: 73
crate_get_bot_target_check_distance(param_00,param_01)
{
	var_02 = crate_get_bot_target(param_00);
	var_03 = param_01 * 0.9;
	var_03 = var_03 * var_03;
	if(distancesquared(param_00.origin,var_02) <= var_03)
	{
		return var_02;
	}

	return undefined;
}

//Function Number: 74
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

		var_02 = level.carepackages;
		if(!maps/mp/bots/_bots_util::bot_in_combat() && isdefined(self.boxes))
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

		if(maps/mp/bots/_bots_strategy::bot_has_tactical_goal("airdrop_crate") || self botgetscriptgoaltype() == "tactical" || maps/mp/bots/_bots_util::bot_is_remote_or_linked())
		{
			continue;
		}

		var_03 = [];
		foreach(var_05 in var_02)
		{
			if(bot_crate_valid(var_05))
			{
				var_03[var_03.size] = var_05;
			}
		}

		var_03 = common_scripts\utility::array_remove_duplicates(var_03);
		if(var_03.size == 0)
		{
			continue;
		}

		var_03 = common_scripts\utility::func_37D5(self.origin,var_03);
		var_07 = self getnearestnode();
		if(!isdefined(var_07))
		{
			continue;
		}

		var_08 = self [[ level.bot_funcs["crate_low_ammo_check"] ]]();
		var_09 = (var_08 || randomint(100) < 50) && !maps\mp\_utility::func_48B2();
		var_0A = undefined;
		foreach(var_05 in var_03)
		{
			var_0C = 0;
			if((!isdefined(var_05.owner) || var_05.owner != self) && !isdefined(var_05.boxtype))
			{
				var_0D = [];
				foreach(var_0F in level.players)
				{
					if(!isdefined(var_0F.team))
					{
						continue;
					}

					if(!isai(var_0F) && level.teambased && var_0F.team == self.team)
					{
						if(distancesquared(var_0F.origin,var_05.origin) < 490000)
						{
							var_0D[var_0D.size] = var_0F;
						}
					}
				}

				if(var_0D.size > 0)
				{
					var_11 = var_0D[0] getnearestnode();
					if(isdefined(var_11))
					{
						var_0C = 0;
						foreach(var_13 in var_05.nearest_nodes)
						{
							var_0C = var_0C | nodesvisible(var_11,var_13,1);
						}
					}
				}
			}

			if(!var_0C)
			{
				var_15 = isdefined(var_05.bots) && isdefined(var_05.bots[self.team]) && var_05.bots[self.team] > 0;
				var_16 = 0;
				foreach(var_13 in var_05.nearest_nodes)
				{
					var_16 = var_16 | nodesvisible(var_07,var_13,1);
				}

				if(var_16 || var_09 && !var_15)
				{
					var_0A = var_05;
					break;
				}
			}
		}

		if(isdefined(var_0A))
		{
			if(self [[ level.bot_funcs["crate_should_claim"] ]]())
			{
				if(!isdefined(var_0A.boxtype))
				{
					if(!isdefined(var_0A.bots))
					{
						var_0A.bots = [];
					}

					var_0A.bots[self.team] = 1;
				}
			}

			var_1A = spawnstruct();
			var_1A.object = var_0A;
			var_1A.start_thread = ::func_8C5B;
			var_1A.should_abort = ::crate_picked_up;
			var_1B = undefined;
			if(isdefined(var_0A.boxtype))
			{
				if(isdefined(var_0A.boxtouchonly) && var_0A.boxtouchonly)
				{
					var_1A.script_goal_radius = 16;
					var_1A.action_thread = undefined;
					var_1B = var_0A.origin;
				}
				else
				{
					var_1A.script_goal_radius = 50;
					var_1A.action_thread = ::func_877A;
					var_1C = crate_get_bot_target_check_distance(var_0A,var_00);
					if(!isdefined(var_1C))
					{
						continue;
					}

					var_1C = var_1C - var_0A.origin;
					var_1D = length(var_1C) * randomfloat(1);
					var_1B = var_0A.origin + vectornormalize(var_1C) * var_1D + (0,0,12);
				}
			}
			else
			{
				var_1A.action_thread = ::func_877C;
				var_1A.end_thread = ::func_7C54;
				var_1B = crate_get_bot_target_check_distance(var_0A,var_00);
				if(!isdefined(var_1B))
				{
					continue;
				}

				var_1A.script_goal_radius = var_00 - distance(var_0A.origin,var_1B + (0,0,40));
				var_1B = var_1B + (0,0,24);
			}

			if(isdefined(var_1A.script_goal_radius))
			{
			}

			var_0A notify("path_disconnect");
			wait(0.05);
			if(!isdefined(var_0A))
			{
				continue;
			}

			maps/mp/bots/_bots_strategy::bot_new_tactical_goal("airdrop_crate",var_1B,30,var_1A);
		}
	}
}

//Function Number: 75
func_1698(param_00)
{
	return 1;
}

//Function Number: 76
func_2036()
{
	return 1;
}

//Function Number: 77
crate_low_ammo_check()
{
	return 0;
}

//Function Number: 78
bot_should_use_ammo_crate(param_00)
{
	if(self getcurrentweapon() == level.boxsettings[param_00.boxtype].minigunweapon)
	{
		return 0;
	}

	return 1;
}

//Function Number: 79
func_1666(param_00)
{
	self switchtoweapon(self.secondaryweapon);
	wait(1);
}

//Function Number: 80
bot_post_use_ammo_crate(param_00)
{
	self switchtoweapon("none");
	self.secondaryweapon = self getcurrentweapon();
}

//Function Number: 81
bot_should_use_scavenger_bag(param_00)
{
	if(maps/mp/bots/_bots_util::func_15E6(0.66))
	{
		var_01 = self getnearestnode();
		if(isdefined(param_00.nearest_nodes) && isdefined(param_00.nearest_nodes[0]) && isdefined(var_01))
		{
			if(nodesvisible(var_01,param_00.nearest_nodes[0],1))
			{
				if(common_scripts\utility::func_8E18(self.origin,self.angles,param_00.origin,self botgetfovdot()))
				{
					return 1;
				}
			}
		}
	}

	return 0;
}

//Function Number: 82
bot_should_use_grenade_crate(param_00)
{
	var_01 = self getweaponslistoffhands();
	foreach(var_03 in var_01)
	{
		if(self getweaponammostock(var_03) == 0)
		{
			return 1;
		}
	}

	return 0;
}

//Function Number: 83
func_169A(param_00)
{
	return 1;
}

//Function Number: 84
func_2034()
{
	self notify("crate_monitor_position");
	self endon("crate_monitor_position");
	self endon("death");
	level endon("game_ended");
	for(;;)
	{
		var_00 = self.origin;
		wait(0.5);
		if(!isalive(self))
		{
		}

		if(!maps/mp/bots/_bots_util::func_16C0(self.origin,var_00))
		{
			self.on_path_grid = undefined;
			self.nearest_nodes = undefined;
			self.nearest_points = undefined;
		}
	}
}

//Function Number: 85
func_2037()
{
}

//Function Number: 86
crate_picked_up(param_00)
{
	if(!isdefined(param_00.object))
	{
		return 1;
	}

	return 0;
}

//Function Number: 87
func_877C(param_00)
{
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

//Function Number: 88
func_877A(param_00)
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

//Function Number: 89
func_8C5B(param_00)
{
	thread func_16CA(param_00.object);
}

//Function Number: 90
func_7C54(param_00)
{
	if(isdefined(param_00.object))
	{
		param_00.object.bots[self.team] = 0;
	}
}

//Function Number: 91
func_16CA(param_00)
{
	param_00 endon("death");
	param_00 endon("revived");
	param_00 endon("disconnect");
	level endon("game_ended");
	var_01 = self.team;
	common_scripts\utility::func_8B2A("death","disconnect");
	if(isdefined(param_00))
	{
		param_00.bots[var_01] = 0;
	}
}

//Function Number: 92
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

		if(maps\mp\_utility::func_4995())
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

			if(distancesquared(self.origin,var_03.origin) < var_00 * var_00)
			{
				if(var_03.owner == self)
				{
					self botpressbutton("use",level.crateownerusetime / 1000 + 0.5);
					continue;
				}

				self botpressbutton("use",level.cratenonownerusetime / 1000 + 0.5);
			}
		}
	}
}

//Function Number: 93
bot_think_revive()
{
	self notify("bot_think_revive");
	self endon("bot_think_revive");
	self endon("death");
	self endon("disconnect");
	level endon("game_ended");
	if(!level.teambased)
	{
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

			if(!isdefined(var_05.var_465B) || !var_05.var_465B)
			{
				continue;
			}

			if(isdefined(var_05.bots) && isdefined(var_05.bots[self.team]) && var_05.bots[self.team] > 0)
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

				var_06.start_thread = ::func_8C5C;
				var_06.end_thread = ::func_7C47;
				var_06.should_abort = ::func_5EDD;
				var_06.action_thread = ::revive_player;
				maps/mp/bots/_bots_strategy::bot_new_tactical_goal("revive",var_05.origin,60,var_06);
				break;
			}
		}
	}
}

//Function Number: 94
func_8C5C(param_00)
{
	thread func_16CA(param_00.object.owner);
}

//Function Number: 95
func_7C47(param_00)
{
	if(isdefined(param_00.object.owner))
	{
		param_00.object.owner.bots[self.team] = 0;
	}
}

//Function Number: 96
func_5EDD(param_00)
{
	if(!isdefined(param_00.object.owner) || param_00.object.owner.health <= 0)
	{
		return 1;
	}

	if(!isdefined(param_00.object.owner.var_465B) || !param_00.object.owner.var_465B)
	{
		return 1;
	}

	return 0;
}

//Function Number: 97
revive_player(param_00)
{
	if(distancesquared(self.origin,param_00.object.owner.origin) > 4096)
	{
		self.last_revive_fail_time = gettime();
	}

	if(isagent(self))
	{
		common_scripts\utility::_enableusability();
		param_00.object enableplayeruse(self);
		wait(0.05);
	}

	var_01 = self.team;
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

//Function Number: 98
bot_can_revive()
{
	if(isdefined(self.laststand) && self.laststand == 1)
	{
		return 0;
	}

	if(maps/mp/bots/_bots_strategy::bot_has_tactical_goal("revive"))
	{
		return 0;
	}

	if(maps/mp/bots/_bots_util::bot_is_remote_or_linked())
	{
		return 0;
	}

	if(maps/mp/bots/_bots_util::bot_is_bodyguarding())
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

//Function Number: 99
func_6697(param_00)
{
	self endon("death");
	self endon("disconnect");
	self endon("bad_path");
	self endon("goal");
	param_00 common_scripts\utility::func_8B2A("death","revived");
	self notify("bad_path");
}

//Function Number: 100
func_161A()
{
	self endon("death");
	self endon("disconnect");
	level endon("game_ended");
	if(gettime() > 15000)
	{
	}

	while(!maps\mp\_utility::gamehasstarted() || !maps\mp\_utility::func_36F1("prematch_done"))
	{
		wait(0.05);
	}

	var_00 = undefined;
	var_01 = undefined;
	for(var_02 = 0;var_02 < level.players.size;var_02++)
	{
		var_03 = level.players[var_02];
		if(isdefined(var_03) && isdefined(self.team) && isdefined(var_03.team) && isenemyteam(self.team,var_03.team))
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

//Function Number: 101
func_1630(param_00,param_01)
{
	if(isdefined(param_01))
	{
		return self makeentitysentient(param_00,param_01);
	}

	return self makeentitysentient(param_00);
}

//Function Number: 102
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

//Function Number: 103
func_2495()
{
}

//Function Number: 104
func_535C()
{
	for(;;)
	{
		level waittill("smoke",var_00,var_01);
		if(var_01 == "smoke_grenade_mp" || var_01 == "smoke_grenadejugg_mp" || var_01 == "odin_projectile_smoke_mp")
		{
			var_00 thread func_3F4A(9);
			continue;
		}

		if(var_01 == "odin_projectile_large_rod_mp")
		{
			var_00 thread func_3F4A(2.5);
		}
	}
}

//Function Number: 105
func_3F4A(param_00)
{
	self waittill("explode",var_01);
	var_02 = common_scripts\utility::func_7836();
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

//Function Number: 106
func_1576(param_00)
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

//Function Number: 107
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

//Function Number: 108
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

//Function Number: 109
bot_flag_trigger_clear(param_00)
{
	self endon("flag_trigger_set_" + param_00);
	self endon("death");
	self endon("disconnect");
	level endon("game_ended");
	common_scripts\utility::func_8AFE();
	waittillframeend;
	self botsetflag(param_00,0);
}