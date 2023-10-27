/*******************************************************************
 * Decompiled By: Bog
 * Decompiled File: scripts\cp\maps\cp_town\cp_town_crab_boss_death_wall.gsc
 * Game: Call of Duty: Infinite Warfare
 * Platform: PC
 * Function Count: 47
 * Decompile Time: 2462 ms
 * Timestamp: 10/27/2023 12:07:05 AM
*******************************************************************/

//Function Number: 1
wall_of_death()
{
	wall_of_death_zombie_spawn_initial_settings();
	level thread instant_player_revive_loop();
	level thread try_wait_for_players_activate_teleporter();
	level thread escort_teleporter_manager();
	level thread crab_boss_wall_of_death_logic();
	level waittill("wall_of_death_completed");
}

//Function Number: 2
instant_player_revive_loop()
{
	level endon("game_ended");
	level endon("players_trigger_vehicle_teleporter");
	var_00 = 60;
	for(;;)
	{
		revive_players_from_afterlife();
		wait(var_00);
	}
}

//Function Number: 3
wall_of_death_zombie_spawn_initial_settings()
{
	level.allow_wave_spawn = 0;
	scripts\cp\maps\cp_town\cp_town_crab_boss_fight::set_crab_boss_max_zombie_spawn(15,15,15,15);
	scripts\cp\maps\cp_town\cp_town_crab_boss_fight::set_crab_boss_zombie_spawn_delay(1,1,1,1);
	scripts\common\utility::flag_set("crab_boss_zombie_spawn");
}

//Function Number: 4
wall_of_death_zombie_spawn_post_activation_settings()
{
	scripts\cp\maps\cp_town\cp_town_crab_boss_fight::set_crab_boss_max_zombie_spawn(15,15,15,15);
	scripts\cp\maps\cp_town\cp_town_crab_boss_fight::set_crab_boss_zombie_spawn_delay(0.2,0.2,0.2,0.2);
}

//Function Number: 5
crab_boss_wall_of_death_logic()
{
	level.crab_boss toxic_gas_attack();
}

//Function Number: 6
try_wait_for_players_activate_teleporter()
{
	if(!scripts\common\utility::istrue(level.player_activated_teleporter))
	{
		level thread scripts\cp\_vo::try_to_play_vo("el_evirasbook_1","rave_announcer_vo","highest",70,0,0,1);
		level waittill("players_trigger_vehicle_teleporter");
		activate_final_sequence_blocker();
		level thread teleport_trapped_ai();
		scripts\cp\maps\cp_town\cp_town_crab_boss_death_ray::disable_all_death_ray_cannons();
		level.player_activated_teleporter = 1;
	}
}

//Function Number: 7
teleport_trapped_ai()
{
	level endon("game_ended");
	scripts\common\utility::func_136F7();
	foreach(var_01 in level.spawned_enemies)
	{
		if(!isdefined(var_01) && isalive(var_01))
		{
			continue;
		}

		if(var_01.agent_type == "crab_boss")
		{
			continue;
		}

		if(agent_is_trapped(var_01))
		{
			teleport_to_clear_pos(var_01);
		}
	}

	if(isdefined(level.elvira_ai) && agent_is_trapped(level.elvira_ai))
	{
		teleport_to_clear_pos(level.elvira_ai);
	}
}

//Function Number: 8
agent_is_trapped(param_00)
{
	if(param_00.origin[2] >= -56)
	{
		return 1;
	}

	if(param_00.origin[1] <= 1700)
	{
		return 1;
	}

	if(param_00.origin[0] >= 3600)
	{
		return 1;
	}

	return 0;
}

//Function Number: 9
teleport_to_clear_pos(param_00)
{
	var_01 = (3004,1587,-77);
	var_02 = 100;
	var_03 = randomfloatrange(var_02 * -1,var_02);
	var_04 = randomfloatrange(var_02 * -1,var_02);
	var_05 = var_01 + (var_03,var_04,0);
	var_05 = getclosestpointonnavmesh(var_05) + (0,0,2);
	param_00 dontinterpolate();
	param_00 setorigin(var_05);
}

//Function Number: 10
toxic_gas_attack()
{
	for(;;)
	{
		level.crab_boss do_taunt();
		if(scripts\common\utility::istrue(level.escort_vehicle.teleporter_activated))
		{
			break;
		}
	}

	wall_of_death_zombie_spawn_post_activation_settings();
	scripts\cp\_vo::try_to_play_vo_on_all_players("boss_phase_4_wod_retreat");
	for(var_00 = 1;var_00 <= 3;var_00++)
	{
		adjust_zombie_spawn(var_00);
		level thread wall_goo_geiger_sfx(var_00);
		if(scripts\common\utility::istrue(level.first_wall_of_death_complete))
		{
			level.crab_boss_toxic_attack_index = var_00;
			if(var_00 == 3)
			{
				scripts\common\utility::func_6E2A("crab_boss_zombie_spawn");
			}

			level.crab_boss toxic_attack();
			level.crab_boss do_toxic_spawn();
			continue;
		}

		level.crab_boss_toxic_attack_index = var_00;
		level.crab_boss toxic_attack();
		level.crab_boss do_toxic_spawn();
		if(var_00 == 3)
		{
			scripts\common\utility::func_6E2A("crab_boss_zombie_spawn");
		}

		level.crab_boss do_taunt();
		level.crab_boss do_toxic_spawn();
		level.crab_boss do_taunt();
	}

	level.first_wall_of_death_complete = 1;
	level notify("wall_of_death_completed");
}

//Function Number: 11
wall_goo_geiger_sfx(param_00)
{
	switch(param_00)
	{
		case 1:
			level.boss_goo_geiger_1 = thread scripts\common\utility::play_loopsound_in_space("town_geiger_counter_boss_lvl1",(2757,2698,-20));
			level.boss_goo_geiger_2 = thread scripts\common\utility::play_loopsound_in_space("town_geiger_counter_boss_lvl1",(3136,2574,-20));
			level.boss_goo_geiger_3 = thread scripts\common\utility::play_loopsound_in_space("town_geiger_counter_boss_lvl1",(3742,2512,-20));
			level.boss_goo_bubble_1 = thread scripts\common\utility::play_loopsound_in_space("boss_goo_bubble_large_lp_01",(2763,2999,-126));
			level.boss_goo_bubble_2 = thread scripts\common\utility::play_loopsound_in_space("boss_goo_bubble_large_lp_02",(3325,2627,-106));
			break;

		case 2:
			if(isdefined(level.boss_goo_geiger_1))
			{
				level.boss_goo_geiger_1 moveto((2638,2200,-130),2);
			}
	
			if(isdefined(level.boss_goo_geiger_2))
			{
				level.boss_goo_geiger_2 moveto((3545,2058,-113),2);
			}
	
			if(isdefined(level.boss_goo_geiger_3))
			{
				level.boss_goo_geiger_3 moveto((3461,1862,-50),2);
			}
	
			if(isdefined(level.boss_goo_bubble_1))
			{
				level.boss_goo_bubble_1 moveto((2638,2200,-130),2);
			}
	
			if(isdefined(level.boss_goo_bubble_2))
			{
				level.boss_goo_bubble_2 moveto((3480,2310,-102),2);
			}
			break;

		case 3:
			if(isdefined(level.boss_goo_geiger_1))
			{
				level.boss_goo_geiger_1 moveto((2818,1258,-40),2);
			}
	
			if(isdefined(level.boss_goo_bubble_1))
			{
				level.boss_goo_bubble_1 moveto((2818,1258,-40),2);
			}
	
			if(isdefined(level.boss_goo_geiger_2))
			{
				level.boss_goo_geiger_2 delete();
			}
	
			if(isdefined(level.boss_goo_geiger_3))
			{
				level.boss_goo_geiger_3 delete();
			}
	
			if(isdefined(level.boss_goo_bubble_2))
			{
				level.boss_goo_bubble_2 delete();
			}
			break;

		case 4:
			if(isdefined(level.boss_goo_geiger_1))
			{
				level.boss_goo_geiger_1 delete();
			}
	
			if(isdefined(level.boss_goo_geiger_2))
			{
				level.boss_goo_geiger_2 delete();
			}
	
			if(isdefined(level.boss_goo_geiger_3))
			{
				level.boss_goo_geiger_3 delete();
			}
	
			if(isdefined(level.boss_goo_bubble_1))
			{
				level.boss_goo_bubble_1 delete();
			}
	
			if(isdefined(level.boss_goo_bubble_2))
			{
				level.boss_goo_bubble_2 delete();
			}
			break;
	}
}

//Function Number: 12
escort_teleporter_manager()
{
	level endon("game_ended");
	level endon("boss_fight_finished");
	if(scripts\common\utility::istrue(level.escort_teleporter_manager))
	{
		return;
	}

	level.escort_teleporter_manager = 1;
	var_00 = make_vehicle_teleporter_interaction();
	var_01 = level.escort_vehicle;
	for(;;)
	{
		level.vehicle_teleporter_is_charged = 0;
		scripts\cp\_interaction::add_to_current_interaction_list(var_00);
		refresh_interaction_for_all_players();
		wail_all_player_trigger_teleporter(undefined,"players_trigger_vehicle_teleporter");
		var_01 thread play_charging_up_sfx(var_01);
		scripts\cp\_interaction::remove_from_current_interaction_list(var_00);
		playfxontag(level._effect["vfx_bomb_portal_chargeup_beach"],var_01,"tag_bomb");
		level.escort_vehicle.teleporter_activated = 1;
		level waittill("sonic_ring_start");
		var_01 thread play_charged_up_sfx(var_01);
		level.vehicle_teleporter_is_charged = 1;
		scripts\cp\_interaction::add_to_current_interaction_list(var_00);
		refresh_interaction_for_all_players();
		stopfxontag(level._effect["vfx_bomb_portal_chargeup_beach"],var_01,"tag_bomb");
		playfxontag(level._effect["vfx_bomb_portal_charged_beach"],var_01,"tag_bomb");
		var_02 = level scripts\common\utility::func_13734("sonic_ring_success","sonic_ring_fail");
		stopfxontag(level._effect["vfx_bomb_portal_charged_beach"],var_01,"tag_bomb");
		var_01 thread stop_charged_up_sfx(var_01,var_02);
		level.escort_vehicle.teleporter_activated = 0;
	}
}

//Function Number: 13
play_charging_up_sfx(param_00)
{
	level endon("boss_fight_finished");
	level endon("sonic_ring_start");
	param_00 playsound("cp_town_bomb_charge_start");
	param_00 playloopsound("cp_town_bomb_charge_lp");
}

//Function Number: 14
play_charged_up_sfx(param_00)
{
	param_00 stoploopsound("cp_town_bomb_charge_lp");
	param_00 playloopsound("cp_town_bomb_charged_up_lp");
}

//Function Number: 15
stop_charged_up_sfx(param_00,param_01)
{
	param_00 stoploopsound("cp_town_bomb_charged_up_lp");
	if(param_01 == "sonic_ring_fail")
	{
		param_00 playsound("cp_town_bomb_charge_fail");
	}
}

//Function Number: 16
refresh_interaction_for_all_players()
{
	foreach(var_01 in level.players)
	{
		var_01 scripts\cp\_interaction::func_DE6E();
	}
}

//Function Number: 17
make_vehicle_teleporter_interaction()
{
	var_00 = spawnstruct();
	var_00.name = "vehicle_teleporter";
	var_00.script_noteworthy = "vehicle_teleporter";
	var_00.origin = (3001,2858,-158);
	var_00.cost = 0;
	var_00.var_D776 = 1;
	var_00.var_109DA = undefined;
	var_00.var_EE79 = "";
	var_00.var_E1B9 = 0;
	var_00.var_8FFA = ::vehicle_teleporter_hint_func;
	var_00.var_161A = ::scripts\cp\maps\cp_town\cp_town_interactions::blankusefunc;
	var_00.var_6261 = 1;
	var_00.disable_guided_interactions = 0;
	level.interactions["vehicle_teleporter"] = var_00;
	var_00 thread vehicle_teleporter_interaction_clean_up(var_00);
	return var_00;
}

//Function Number: 18
vehicle_teleporter_interaction_clean_up(param_00)
{
	level waittill("boss_fight_finished");
	scripts\cp\_interaction::remove_from_current_interaction_list(param_00);
}

//Function Number: 19
adjust_zombie_spawn(param_00)
{
	switch(param_00)
	{
		case 1:
			scripts\cp\maps\cp_town\cp_town_crab_boss_fight::set_crab_boss_max_zombie_spawn(15,14,12,10);
			scripts\cp\maps\cp_town\cp_town_crab_boss_fight::set_crab_boss_zombie_spawn_delay(1.5,1.8,2.1,2.5);
			level.max_wave_spawn_num = 20;
			level.wait_time_between_wave = 15;
			break;

		case 2:
			scripts\cp\maps\cp_town\cp_town_crab_boss_fight::set_crab_boss_max_zombie_spawn(15,14,13,12);
			scripts\cp\maps\cp_town\cp_town_crab_boss_fight::set_crab_boss_zombie_spawn_delay(1.3,1.5,1.7,2);
			level.max_wave_spawn_num = 20;
			level.wait_time_between_wave = 15;
			break;

		case 3:
			scripts\cp\maps\cp_town\cp_town_crab_boss_fight::set_crab_boss_max_zombie_spawn(10,9,8,7);
			scripts\cp\maps\cp_town\cp_town_crab_boss_fight::set_crab_boss_zombie_spawn_delay(1.5,1.8,2.1,2.5);
			level.max_wave_spawn_num = 20;
			level.wait_time_between_wave = 15;
			break;
	}
}

//Function Number: 20
do_taunt()
{
	level.crab_boss scripts\aitypes\crab_boss\behaviors::func_5ABE(0);
	level.crab_boss waittill("taunt_done");
}

//Function Number: 21
do_toxic_spawn()
{
	level.crab_boss scripts\aitypes\crab_boss\behaviors::dotoxicspawn();
	level.crab_boss waittill("toxic_spawn_done");
}

//Function Number: 22
toxic_attack()
{
	level.crab_boss scripts\aitypes\crab_boss\behaviors::dogasattack(0);
	level.crab_boss waittill("toxic_done");
}

//Function Number: 23
activate_toxic_patch_and_trigger(param_00)
{
	play_toxic_ground_vfx(param_00);
	var_01 = getent("toxic_waste_patch_" + param_00,"targetname");
	var_01 dontinterpolate();
	var_02 = get_toxic_patch_offset(param_00);
	var_01.origin = var_01.origin + (0,0,1026 - var_02);
	var_03 = get_toxic_patch_move_time(param_00);
	var_01 moveto(var_01.origin + (0,0,var_02),var_03,0,var_03);
	var_01 waittill("movedone");
	var_01.var_1604 = 1;
	var_04 = getent("toxic_waste_trigger_" + param_00,"targetname");
	var_04 dontinterpolate();
	var_04.origin = var_04.origin + (0,0,1024);
	var_04 thread func_D051(var_04);
	if(param_00 > 1)
	{
		deactivate_toxic_patch_and_trigger(param_00 - 1);
	}
}

//Function Number: 24
get_toxic_patch_offset(param_00)
{
	switch(param_00)
	{
		case 1:
			return 6;

		case 2:
			return 6;

		case 3:
			return 6;
	}
}

//Function Number: 25
get_toxic_patch_move_time(param_00)
{
	switch(param_00)
	{
		case 1:
			return 7;

		case 2:
			return 7;

		case 3:
			return 7;
	}
}

//Function Number: 26
func_D051(param_00)
{
	param_00 endon("stop_toxic_trigger_monitor");
	for(;;)
	{
		param_00 waittill("trigger",var_01);
		if(isplayer(var_01))
		{
			if(scripts\common\utility::istrue(var_01.inlaststand))
			{
				continue;
			}

			try_sonic_beam_damage_player(var_01);
		}
	}
}

//Function Number: 27
try_sonic_beam_damage_player(param_00)
{
	if(!isdefined(param_00.next_toxic_trigger_damage_time))
	{
		param_00.next_toxic_trigger_damage_time = 0;
	}

	var_01 = gettime();
	if(!isdefined(param_00.geiger_counter))
	{
		param_00.geiger_counter = 1;
		param_00 playlocalsound("town_geiger_counter_lvl4_plr");
		param_00 thread delay_stop_geiger_counter(param_00);
	}

	if(param_00.next_toxic_trigger_damage_time > var_01)
	{
		return;
	}

	param_00.next_toxic_trigger_damage_time = var_01 + 750;
	param_00 dodamage(int(param_00.maxhealth * 0.2),param_00.origin);
	param_00 setscriptablepartstate("screen_effects","screen_goo");
}

//Function Number: 28
delay_stop_geiger_counter(param_00)
{
	param_00 notify("delay_stop_geiger_counter");
	param_00 endon("disconnect");
	param_00 endon("delay_stop_geiger_counter");
	wait(0.75);
	if(isdefined(param_00.geiger_counter))
	{
		param_00.geiger_counter = undefined;
		param_00 scripts\cp\_utility::stoplocalsound_safe("town_geiger_counter_lvl4_plr");
	}
}

//Function Number: 29
deactivate_toxic_patch_and_trigger(param_00)
{
	var_01 = getent("toxic_waste_patch_" + param_00,"targetname");
	var_02 = getent("toxic_waste_trigger_" + param_00,"targetname");
	if(scripts\common\utility::istrue(var_01.var_1604))
	{
		var_01 dontinterpolate();
		var_02 dontinterpolate();
		var_03 = get_toxic_patch_offset(param_00);
		var_01 thread toxic_patch_submerge(var_01,var_03,param_00);
		var_02.origin = var_02.origin + (0,0,-1024);
		var_02 notify("stop_toxic_trigger_monitor");
	}
}

//Function Number: 30
get_patch_submerge_time()
{
	return 1;
}

//Function Number: 31
toxic_patch_submerge(param_00,param_01,param_02)
{
	var_03 = get_patch_submerge_time();
	param_00 moveto(param_00.origin - (0,0,param_01),var_03);
	param_00 waittill("movedone");
	param_00.origin = param_00.origin + (0,0,-1024 + param_01);
	param_00.var_1604 = 0;
}

//Function Number: 32
activate_final_sequence_blocker()
{
	if(scripts\common\utility::istrue(level.final_sequence_blocker_activated))
	{
		return;
	}

	level.wall_of_death_blocker_models = [];
	var_00 = scripts\common\utility::getstructarray("death_wall_door_model","targetname");
	foreach(var_02 in var_00)
	{
		var_03 = spawn("script_model",var_02.origin);
		var_03 setmodel("cp_disco_street_barricade");
		var_03.angles = var_02.angles;
		level.wall_of_death_blocker_models[level.wall_of_death_blocker_models.size] = var_03;
	}

	var_05 = getent("death_wall_door_clip","targetname");
	var_05 dontinterpolate();
	var_05.origin = var_05.origin + (0,0,1024);
	level.final_sequence_blocker_activated = 1;
}

//Function Number: 33
deactivate_final_sequence_blocker()
{
	if(isdefined(level.wall_of_death_blocker_models))
	{
		foreach(var_01 in level.wall_of_death_blocker_models)
		{
			if(isdefined(var_01))
			{
				var_01 delete();
			}
		}
	}

	var_03 = getent("death_wall_door_clip","targetname");
	if(isdefined(var_03))
	{
		var_03 delete();
	}
}

//Function Number: 34
end_wall_of_death()
{
	level thread wall_goo_geiger_sfx(4);
	play_outro_vfx();
	deactivate_toxic_patch_and_trigger(3);
}

//Function Number: 35
debug_beat_wall_of_death()
{
}

//Function Number: 36
wail_all_player_trigger_teleporter(param_00,param_01)
{
	if(isdefined(param_00))
	{
		level endon(param_00);
	}

	var_02 = 22500;
	for(;;)
	{
		var_03 = 1;
		foreach(var_05 in level.players)
		{
			if(scripts\common\utility::istrue(var_05.inlaststand))
			{
				var_03 = 0;
				break;
			}

			if(scripts\common\utility::istrue(var_05.var_9D81))
			{
				var_03 = 0;
				break;
			}

			if(distancesquared(var_05.origin,(3001,2858,-158)) > var_02)
			{
				var_03 = 0;
				break;
			}

			if(!var_05 usebuttonpressed())
			{
				var_03 = 0;
				break;
			}
		}

		wait(0.25);
		if(var_03)
		{
			var_03 = 1;
			foreach(var_05 in level.players)
			{
				if(scripts\common\utility::istrue(var_05.inlaststand))
				{
					var_03 = 0;
					break;
				}

				if(scripts\common\utility::istrue(var_05.var_9D81))
				{
					var_03 = 0;
					break;
				}

				if(distancesquared(var_05.origin,(3001,2858,-158)) > var_02)
				{
					var_03 = 0;
					break;
				}

				if(!var_05 usebuttonpressed())
				{
					var_03 = 0;
					break;
				}
			}
		}

		if(var_03)
		{
			if(isdefined(param_01))
			{
				level notify(param_01);
			}

			return;
		}

		scripts\common\utility::func_136F7();
	}
}

//Function Number: 37
death_wall_zombie_spawning_logic()
{
	level endon("stop_death_wall_zombie_spawning");
	wait(1.5);
	var_00 = [(2744,3725,-197),(3498,2990,-197)];
	foreach(var_03, var_02 in var_00)
	{
		var_00[var_03] = scripts\common\utility::func_5D14(var_00[var_03],0,-500);
	}

	var_04 = randomint(2);
	for(;;)
	{
		spawn_group_of_zombies_at(var_00[var_04 % var_00.size]);
		var_04++;
		wait(3);
	}
}

//Function Number: 38
spawn_group_of_zombies_at(param_00)
{
	var_01 = min(18,22 - level.spawned_enemies.size);
	var_02 = level.players.size;
	var_03 = min(var_01,var_02);
	for(var_04 = 0;var_04 < var_03;var_04++)
	{
		spawn_one_zombie(param_00);
		scripts\common\utility::func_136F7();
	}
}

//Function Number: 39
spawn_one_zombie(param_00)
{
	var_01 = 70;
	var_02 = randomfloatrange(var_01 * -1,var_01);
	var_03 = randomfloatrange(var_01 * -1,var_01);
	param_00 = (param_00[0] + var_02,param_00[1] + var_03,param_00[2]);
	param_00 = getclosestpointonnavmesh(param_00);
	var_04 = make_zombie_spawner(param_00);
	var_05 = var_04 scripts\cp\zombies\zombies_spawning::func_1081B("generic_zombie",1,var_04);
}

//Function Number: 40
make_zombie_spawner(param_00,param_01)
{
	var_02 = spawnstruct();
	var_02.origin = param_00;
	var_02.angles = vectortoangles((-26,-110,18));
	return var_02;
}

//Function Number: 41
play_outro_vfx()
{
	foreach(var_01 in level.toxic_loop_vfx)
	{
		playfx(level._effect["toxic_ground_outro"],var_01.origin);
		var_01 delete();
	}

	level.toxic_loop_vfx = [];
}

//Function Number: 42
load_death_wall_vfx()
{
	level.toxic_loop_vfx = [];
	level._effect["toxic_ground_intro"] = loadfx("vfx/iw7/levels/cp_town/crog/vfx_toxic_ground_intro.vfx");
	level._effect["toxic_ground_loop"] = loadfx("vfx/iw7/levels/cp_town/crog/vfx_toxic_ground_loop.vfx");
	level._effect["toxic_ground_outro"] = loadfx("vfx/iw7/levels/cp_town/crog/vfx_toxic_ground_outro.vfx");
}

//Function Number: 43
play_toxic_ground_vfx(param_00)
{
	var_01 = get_toxic_ground_vfx_locs(param_00);
	foreach(var_03 in var_01)
	{
		level thread play_toxic_ground_vfx_at_pos(var_03);
	}
}

//Function Number: 44
get_toxic_ground_vfx_locs(param_00)
{
	switch(param_00)
	{
		case 1:
			return [(2574,2950,-168),(2668,2518,-169),(3037,2661,-175),(3341,2505,-156),(3547,2580,-163)];

		case 2:
			return [(2679,2262,-147),(2693,2023,-133),(2555,2098,-128),(3028,2045,-75),(3132,1926,-93),(3418,1883,-112),(3569,2089,-129)];

		case 3:
			return [(2741,1705,-116),(3037,1613,-89),(2839,1407,-83),(2630,1172,-72),(2849,1067,-65)];
	}
}

//Function Number: 45
play_toxic_ground_vfx_at_pos(param_00)
{
	var_01 = scripts\common\utility::func_5D14(param_00,10,-50);
	playfx(level._effect["toxic_ground_intro"],var_01);
	wait(1.5);
	var_02 = spawnfx(level._effect["toxic_ground_loop"],var_01);
	triggerfx(var_02);
	level.toxic_loop_vfx[level.toxic_loop_vfx.size] = var_02;
}

//Function Number: 46
revive_players_from_afterlife()
{
	foreach(var_01 in level.players)
	{
		if(scripts\cp\zombies\zombie_afterlife_arcade::func_9C10(var_01))
		{
			var_01 scripts\cp\_laststand::func_992F(var_01);
		}
	}
}

//Function Number: 47
vehicle_teleporter_hint_func(param_00,param_01)
{
	if(scripts\common\utility::istrue(level.vehicle_teleporter_is_charged))
	{
		return &"CP_TOWN_INTERACTIONS_VEHICLE_TELEPORT_READY";
	}

	return &"CP_TOWN_INTERACTIONS_ACTIVATE_TELEPORT";
}