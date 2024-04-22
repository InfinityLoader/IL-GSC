/*******************************************************************
 * Decompiled By: Bog
 * Decompiled File: recovery_code.gsc
 * Game: Call of Duty: Advanced Warfare
 * Platform: PC
 * Function Count: 248
 * Decompile Time: 3663 ms
 * Timestamp: 4/22/2024 2:34:37 AM
*******************************************************************/

//Function Number: 1
setup_gameplay()
{
	maps\_variable_grenade::init_variable_grenade();
	maps\_drone_civilian::init();
	maps\_drone_ai::init();
	precachemodel("machinery_welder_handle");
	level._effect["holo_target_green_spawn_in"] = loadfx("vfx/props/holo_target_green_spawn_in");
	level._effect["holo_target_red_spawn_in"] = loadfx("vfx/props/holo_target_red_spawn_in");
	level._effect["holo_target_green_spawn_out"] = loadfx("vfx/props/holo_target_green_spawn_out");
	level._effect["holo_target_red_spawn_out"] = loadfx("vfx/props/holo_target_red_spawn_out");
	setup_spawn_functions();
	thread skybox_manager();
	thread mountains_manager();
	thread setup_funeral();
	thread setup_training_sequence_1();
	thread setup_tour();
	thread setup_training_sequence_2();
	thread setup_outro();
	thread maps\recovery_utility::mission_warn_out_of_bounds_fail();
	thread maps\recovery_utility::mission_out_of_bounds_fail();
}

//Function Number: 2
setup_spawn_functions()
{
	maps\_utility::add_global_spawn_function("axis",::maps\recovery_utility::recovery_thermal_manager);
	maps\_utility::array_spawn_function_noteworthy("training_s1_enemies_start",::maps\recovery_utility::training_s1_starting_enemies_think,"training_s1_start_alerted","training_s1_clear_initial_spawn","training_s1_enemies_start_charge");
	maps\_utility::array_spawn_function_noteworthy("training_s1_enemies_patrol",::maps\recovery_utility::training_s1_sniper_enemies_think,"training_s1_start_alerted","training_s1_clear_initial_spawn","training_s1_enemies_start_charge");
	maps\_utility::array_spawn_function_noteworthy("training_s1_enemies_flash",::maps\recovery_utility::training_s1_enemies_living_room_think);
	maps\_utility::array_spawn_function_noteworthy("training_s1_enemies_breach",::maps\recovery_utility::training_s1_breach_enemy_think);
	maps\_utility::array_spawn_function_noteworthy("training_s1_bedroom_spawners",::maps\recovery_utility::training_s1_bedroom_spawners_think);
	maps\_utility::array_spawn_function_noteworthy("training_s1_patio_enemies",::maps\recovery_utility::training_s1_patio_enemies_think,"training_s1_patio_alerted","training_s1_clear_patio1");
	maps\_utility::array_spawn_function_noteworthy("training_s1_patio_enemies2",::maps\recovery_utility::training_s1_patio_enemies_think,"training_s1_patio_alerted","training_s1_clear_patio2");
	maps\_utility::array_spawn_function_noteworthy("training_s1_patio_enemies3",::maps\recovery_utility::training_s1_patio_enemies_think,"training_s1_patio_alerted","training_s1_clear_patio3");
	maps\_utility::array_spawn_function_noteworthy("training_s1_terrace_vehicles",::maps\recovery_utility::training_s1_terrace_vehicles_think,"training_s1_end","training_s1_spotted","training_s1_vehicle_in_attack_position");
	maps\_utility::array_spawn_function_noteworthy("training_s1_golf_course_patrollers",::maps\recovery_utility::training_s1_runner_enemy_think,"training_s1_end","training_s1_spotted");
	maps\_utility::array_spawn_function_noteworthy("training_s1_ambush_vehicles",::maps\recovery_utility::training_s1_ambush_vehicles_think,"training_s1_end_cease_fire","flag_cleanup_jeep_ride_first_half");
	maps\_utility::array_spawn_function_noteworthy("training_s1_end_enemies",::maps\recovery_utility::training_s1_kva_ambush1_think,"training_s1_end_cease_fire","training_s1_end");
	maps\_utility::array_spawn_function_noteworthy("training_s1_kva_ambush1",::maps\recovery_utility::training_s1_kva_ambush1_think,"training_s1_end_cease_fire","training_s1_end");
	maps\_utility::array_spawn_function_noteworthy("training_s1_kva_ambush2",::maps\recovery_utility::training_s1_kva_ambush1_think,"training_s1_end_cease_fire","training_s1_end");
	maps\_utility::array_spawn_function_noteworthy("training_s2_enemies_start",::maps\recovery_utility::training_s2_enemies_start_think,"training_s2_start_alerted","training_s2_start_charge","training_s2_clear_start_spawn");
	maps\_utility::array_spawn_function_noteworthy("training_s2_enemies_start2",::maps\recovery_utility::training_s2_enemies_start2_think,"training_s2_start_alerted","training_s2_start_charge","training_s2_clear_start_spawn");
	maps\_utility::array_spawn_function_noteworthy("training_s2_enemies_patrol",::maps\recovery_utility::training_s2_enemies_patrol_think,"training_s2_start_alerted","training_s2_start_charge","training_s2_clear_start_spawn");
	maps\_utility::array_spawn_function_noteworthy("training_s2_enemies_living_room",::maps\recovery_utility::training_s2_enemies_living_room_think,"training_s2_living_room_alert");
	maps\_utility::array_spawn_function_noteworthy("training_s2_enemies_hall",::maps\recovery_utility::training_s2_enemies_hall_think);
	maps\_utility::array_spawn_function_noteworthy("training_s2_enemies_breach",::maps\recovery_utility::training_s2_breach_enemy_think);
	maps\_utility::array_spawn_function_noteworthy("training_s2_enemies_ambush",::maps\recovery_utility::training_s2_enemies_ambush_think,"training_s2_ambush_cleanup");
	maps\_utility::array_spawn_function_noteworthy("training_s2_enemies_patio",::maps\recovery_utility::training_s2_enemies_patio_think,"training_s2_clear_patio_spawn","training_s2_patio_alert","flag_training_s2_patio_enemies_charge");
	maps\_utility::array_spawn_function_noteworthy("training_s2_enemies2_patio",::maps\recovery_utility::training_s2_enemies_patio_think,"training_s2_clear_patio_spawn","training_s2_patio_alert","flag_training_s2_patio_enemies_charge");
	maps\_utility::array_spawn_function_noteworthy("training_s2_ambush_vehicles",::maps\recovery_utility::training_s2_ambush_vehicles_think,"training_s2_warbird_kill_enemies");
	maps\_utility::array_spawn_function_noteworthy("training_s2_kva_ambush1",::maps\recovery_utility::training_s2_kva_ambush1_think,"training_s2_warbird_kill_enemies");
	maps\_utility::array_spawn_function_noteworthy("training_s2_kva_ambush2",::maps\recovery_utility::training_s2_kva_ambush1_think,"training_s2_warbird_kill_enemies");
	maps\_utility::array_spawn_function_noteworthy("civilians_stationary",::maps\recovery_utility::civilian_drone_stationary_think,"flag_cleanup_jeep_ride_first_half");
	maps\_utility::array_spawn_function_noteworthy("civilians_walking",::maps\recovery_utility::civilian_drone_runners_think,"flag_cleanup_jeep_ride_first_half");
	maps\_utility::array_spawn_function_noteworthy("civilians_repair",::maps\recovery_utility::civilian_drone_repair_think,"tour_end");
	maps\_utility::array_spawn_function_noteworthy("military_stationary",::maps\recovery_utility::military_drone_stationary_think,"flag_cleanup_jeep_ride_first_half");
	maps\_utility::array_spawn_function_noteworthy("military_walking",::maps\recovery_utility::military_drone_runners_think,"tour_end");
	maps\_utility::array_spawn_function_noteworthy("military_guards",::maps\recovery_utility::military_drone_guards_stationary_think,"tour_ambient_00");
	maps\_utility::array_spawn_function_noteworthy("military_guards_patrol",::maps\recovery_utility::military_drone_guards_patrol_think,"tour_ambient_00");
	maps\_utility::add_global_spawn_function("allies",::maps\recovery_utility::enable_jump_jet_pathing);
	maps\_utility::array_spawn_function_noteworthy("grenade_range_enemy",::maps\recovery_utility::grenade_range_enemy_think);
	maps\_utility::array_spawn_function_noteworthy("grenade_range_drone",::maps\recovery_utility::grenade_range_drone_think);
}

//Function Number: 3
skybox_manager()
{
	var_00 = getentarray("walls_interior","targetname");
	var_01 = getentarray("hangar_reveal","targetname");
	foreach(var_03 in var_01)
	{
		var_03 hide();
	}

	foreach(var_06 in var_00)
	{
		var_06 hide();
	}

	common_scripts\utility::flag_wait("training_s1_flag_wall_interior_decloak");
	common_scripts\utility::flag_set("flag_mountains_visible");
	setsaveddvar("cg_cinematicFullScreen","0");
	cinematicingameloop("recovery_training_transition");
	foreach(var_03 in var_01)
	{
		var_03 show();
	}

	wait(3);
	foreach(var_03 in var_01)
	{
		var_03 hide();
	}

	stopcinematicingame();
	foreach(var_06 in var_00)
	{
		var_06 show();
	}

	common_scripts\utility::flag_wait("tour_hangar_door_01");
	foreach(var_06 in var_00)
	{
		var_06 hide();
	}
}

//Function Number: 4
mountains_manager()
{
	var_00 = getentarray("mountain_hide","targetname");
	foreach(var_02 in var_00)
	{
		var_02 hide();
	}

	common_scripts\utility::flag_wait("flag_mountains_visible");
	foreach(var_02 in var_00)
	{
		var_02 show();
	}

	common_scripts\utility::flag_wait("training_room_elevator_activated");
	foreach(var_02 in var_00)
	{
		var_02 hide();
	}
}

//Function Number: 5
setup_funeral()
{
	thread funeral();
	thread funeral_cleanup();
}

//Function Number: 6
funeral()
{
	common_scripts\utility::flag_wait("funeral_start");
	thread funeral_ambient_ai_soldiers();
	var_00 = getent("org_anim_funeral","targetname");
	thread funeral_anim_player(var_00);
	thread funeral_anim_cormack(var_00);
	thread funeral_anim_irons(var_00);
	thread funeral_anim_irons_wife(var_00);
	thread funeral_anim_driver(var_00);
	thread funeral_anim_ambient(var_00);
	thread funeral_anim_card(var_00);
	thread funeral_anim_flag(var_00);
	thread funeral_play_animated_card();
	wait(1);
	common_scripts\utility::flag_set("eulogy_complete");
	common_scripts\utility::flag_wait("card_obtained");
	common_scripts\utility::flag_set("funeral_complete");
	level notify("funeral_done");
	if(level.nextgen)
	{
		thread maps\_introscreen::introscreen_generic_fade_in("white",0.05,0.05);
	}

	thread training_s1_opening();
}

//Function Number: 7
funeral_anim_player(param_00)
{
	level.player lerpfov(57.5,0.05);
	common_scripts\utility::flag_set("flag_disable_exo");
	level.player disableweapons();
	level.player allowcrouch(0);
	level.player allowprone(0);
	level.player allowjump(0);
	level.player allowsprint(0);
	level.player setmovespeedscale(0.5);
	param_00 = param_00 common_scripts\utility::spawn_tag_origin();
	param_00 thread maps\recovery_utility::delete_on_notify("funeral_done");
	var_01 = getent("funeral_blocker","targetname");
	var_02 = common_scripts\utility::getstruct("funeral","targetname");
	var_03 = spawn("script_origin",var_02.origin);
	var_03.angles = var_02.angles;
	level.player maps\_shg_utility::setup_player_for_scene(1);
	var_04 = 0.5;
	var_05 = maps\_utility::spawn_anim_model("player_rig_funeral");
	level.player_rig = var_05;
	level.player playerlinktoblend(var_05,"tag_player",var_04);
	level.player common_scripts\utility::delaycall(var_04,::playerlinktodelta,var_05,"tag_player",1,20,70,25,25);
	var_05 common_scripts\utility::delaycall(var_04,::show);
	param_00 thread maps\_anim::anim_loop_solo(var_05,"rec_funeral_eulogy_idle_vm");
	level.player enableslowaim(0.45,0.25);
	common_scripts\utility::flag_wait("eulogy_complete");
	param_00 notify("stop_loop");
	param_00 maps\_anim::anim_single_solo(var_05,"rec_funeral_eulogy_ends_vm");
	level.player maps\_shg_utility::setup_player_for_gameplay();
	level.player disableweapons();
	level.player allowcrouch(0);
	level.player allowprone(0);
	level.player allowjump(0);
	level.player allowsprint(0);
	level.player freezecontrols(0);
	level.player unlink();
	level.player disableslowaim();
	var_05 hide();
	common_scripts\utility::flag_set("flag_obj_funeral_casket_start");
	param_00 maps\_anim::anim_first_frame_solo(var_05,"rec_funeral_walktocar_vm");
	common_scripts\utility::flag_wait("flag_obj_funeral_casket_complete");
	common_scripts\utility::flag_set("interact_casket");
	level.player common_scripts\utility::delaycall(8,::lerpfov,50,2);
	level.player maps\_shg_utility::setup_player_for_scene(1);
	var_04 = 1;
	level.player playerlinktoblend(var_05,"tag_player",var_04);
	var_05 common_scripts\utility::delaycall(var_04,::show);
	param_00 maps\_anim::anim_single_solo(var_05,"rec_funeral_walktocar_vm");
	level.player maps\_shg_utility::setup_player_for_gameplay();
	level.player disableweapons();
	level.player allowcrouch(0);
	level.player allowprone(0);
	level.player allowjump(0);
	level.player allowsprint(0);
	level.player unlink();
	var_05 hide();
	common_scripts\utility::flag_set("flag_obj_funeral_irons_start");
	var_01 delete();
	common_scripts\utility::flag_wait("player_proximity_irons");
	level.player setmovespeedscale(1);
	common_scripts\utility::flag_set("flag_obj_funeral_irons_complete");
	common_scripts\utility::flag_set("flag_vo_funeral_irons");
	level.player freezecontrols(1);
	level.player maps\_shg_utility::setup_player_for_scene();
	var_04 = 0.5;
	param_00 maps\_anim::anim_first_frame_solo(var_05,"rec_funeral_altascard_vm");
	var_05 hide();
	level.player playerlinktoblend(var_05,"tag_player",var_04);
	var_05 common_scripts\utility::delaycall(var_04 + 1,::show);
	level.player common_scripts\utility::delaycall(var_04,::playerlinktodelta,var_05,"tag_player",1,5,5,5,5,1);
	level.player common_scripts\utility::delaycall(var_04 + 0.05,::springcamenabled,0.5,1.5,1);
	level.player thread lerp_linktoblend();
	level notify("rec_funeral_altascard_vm");
	param_00 maps\_anim::anim_single_solo(var_05,"rec_funeral_altascard_vm");
	common_scripts\utility::flag_set("card_obtained");
	var_05 delete();
	level.player lerpfov(65,0.05);
}

//Function Number: 8
lerp_linktoblend()
{
	wait(58);
	var_00 = 3;
	var_01 = var_00 / 0.05;
	for(var_02 = 0;var_02 < var_01;var_02++)
	{
		var_03 = 1 - var_02 / var_01;
		level.player playerlinktodelta(level.player_rig,"tag_player",1,12 * var_03,12 * var_03,12 * var_03,12 * var_03,1);
		level.player springcamenabled(0.5,1.5,1);
		wait 0.05;
	}
}

//Function Number: 9
funeral_anim_cormack(param_00)
{
	level.funeral_cormack = getent("funeral_cormack","targetname") maps\_utility::spawn_ai(1);
	level.funeral_cormack.name = " ";
	level.funeral_cormack.animname = "cormack";
	level.funeral_cormack thread maps\recovery_utility::delete_on_notify("funeral_done");
	level.funeral_cormack endon("death");
	common_scripts\utility::flag_set("flag_vo_funeral_cormack");
	param_00 thread maps\_anim::anim_loop_solo(level.funeral_cormack,"rec_funeral_eulogy_idle_cormack");
	common_scripts\utility::flag_wait("eulogy_complete");
	param_00 notify("stop_loop");
	thread funeral_anim_cormack_branch(param_00);
	var_01 = level common_scripts\utility::waittill_any_return("interact_casket","cormack_finishes_walk");
	if(var_01 == "cormack_finishes_walk")
	{
		param_00 thread maps\_anim::anim_loop_solo(level.funeral_cormack,"rec_funeral_casket_idle_cormack");
		common_scripts\utility::flag_wait("interact_casket");
		wait(1);
		param_00 notify("stop_loop");
	}

	if(var_01 == "interact_casket")
	{
		wait(1);
		level.funeral_cormack stopanimscripted();
	}

	param_00 maps\_anim::anim_single_solo(level.funeral_cormack,"rec_funeral_walktocar_cormack");
	param_00 thread maps\_anim::anim_loop_solo(level.funeral_cormack,"rec_funeral_car_idle_cormack");
	common_scripts\utility::flag_wait("player_proximity_irons");
	param_00 notify("stop_loop");
	param_00 maps\_anim::anim_single_solo(level.funeral_cormack,"rec_funeral_altascard_cormack");
}

//Function Number: 10
funeral_anim_cormack_branch(param_00)
{
	param_00 maps\_anim::anim_single_solo(level.funeral_cormack,"rec_funeral_eulogy_ends_cormack");
	level notify("cormack_finishes_walk");
}

//Function Number: 11
funeral_anim_irons(param_00)
{
	level.funeral_irons = getent("funeral_irons","targetname") maps\_utility::spawn_ai(1);
	level.funeral_irons.name = " ";
	level.funeral_irons.animname = "irons";
	level.funeral_irons.no_ai = 1;
	level.funeral_irons thread maps\recovery_utility::delete_on_notify("funeral_done");
	param_00 = param_00 common_scripts\utility::spawn_tag_origin();
	param_00 thread maps\recovery_utility::delete_on_notify("funeral_done");
	level.funeral_irons endon("death");
	param_00 thread maps\_anim::anim_loop_solo(level.funeral_irons,"rec_funeral_eulogy_idle_irons");
	common_scripts\utility::flag_wait("eulogy_complete");
	param_00 notify("stop_loop");
	soundscripts\_snd::snd_music_message("rec_funeral_eulogy_ends_irons");
	param_00 maps\_anim::anim_single_solo(level.funeral_irons,"rec_funeral_eulogy_ends_irons");
	param_00 thread maps\_anim::anim_loop_solo(level.funeral_irons,"rec_funeral_casket_idle_irons");
	common_scripts\utility::flag_wait("interact_casket");
	param_00 notify("stop_loop");
	param_00 maps\_anim::anim_single_solo(level.funeral_irons,"rec_funeral_walktocar_irons");
	param_00 thread maps\_anim::anim_loop_solo(level.funeral_irons,"rec_funeral_car_idle_irons");
	common_scripts\utility::flag_wait("player_proximity_irons");
	param_00 notify("stop_loop");
	param_00 maps\_anim::anim_single_solo(level.funeral_irons,"rec_funeral_altascard_irons");
}

//Function Number: 12
funeral_anim_irons_wife(param_00)
{
	level.funeral_irons_wife = getent("funeral_irons_wife","targetname") maps\_utility::spawn_ai(1);
	level.funeral_irons_wife.name = " ";
	level.funeral_irons_wife.animname = "irons_wife";
	level.funeral_irons_wife thread maps\recovery_utility::delete_on_notify("funeral_done");
	param_00 = param_00 common_scripts\utility::spawn_tag_origin();
	param_00 thread maps\recovery_utility::delete_on_notify("funeral_done");
	level.funeral_irons_wife endon("death");
	param_00 thread maps\_anim::anim_loop_solo(level.funeral_irons_wife,"rec_funeral_eulogy_idle_wife","custom_wife_ender");
	common_scripts\utility::flag_wait("eulogy_complete");
	param_00 notify("custom_wife_ender");
	param_00 maps\_anim::anim_single_solo(level.funeral_irons_wife,"rec_funeral_eulogy_ends_wife");
	param_00 thread maps\_anim::anim_loop_solo(level.funeral_irons_wife,"rec_funeral_eulogy_idle_wife");
}

//Function Number: 13
funeral_anim_driver(param_00)
{
	var_01 = getent("funeral_driver","targetname") maps\_utility::spawn_ai(1);
	var_01.name = " ";
	var_01.no_ai = 1;
	var_01.animname = "funeral_driver";
	var_01 thread maps\recovery_utility::delete_on_notify("funeral_done");
	param_00 = param_00 common_scripts\utility::spawn_tag_origin();
	param_00 thread maps\recovery_utility::delete_on_notify("funeral_done");
	var_01 endon("death");
	param_00 thread maps\_anim::anim_loop_solo(var_01,"rec_funeral_eulogy_idle_driver");
	common_scripts\utility::flag_wait("eulogy_complete");
	param_00 notify("stop_loop");
	param_00 maps\_anim::anim_single_solo(var_01,"rec_funeral_eulogy_ends_driver");
	param_00 thread maps\_anim::anim_loop_solo(var_01,"rec_funeral_casket_idle_driver");
	common_scripts\utility::flag_wait("interact_casket");
	param_00 notify("stop_loop");
	param_00 maps\_anim::anim_single_solo(var_01,"rec_funeral_walktocar_driver");
	param_00 thread maps\_anim::anim_loop_solo(var_01,"rec_funeral_car_idle_driver");
	common_scripts\utility::flag_wait("player_proximity_irons");
	param_00 notify("stop_loop");
	param_00 maps\_anim::anim_single_solo(var_01,"rec_funeral_altascard_driver");
}

//Function Number: 14
funeral_anim_ambient(param_00)
{
	var_01 = getent("chair_actor_01","targetname") spawndrone();
	var_02 = getent("chair_actor_02","targetname") spawndrone();
	var_03 = getent("chair_actor_04","targetname") spawndrone();
	var_04 = getent("chair_actor_05","targetname") spawndrone();
	var_05 = getent("chair_actor_06","targetname") spawndrone();
	if(level.nextgen)
	{
		level.chair_actor_07 = getent("chair_actor_07","targetname") spawndrone();
		level.chair_actor_08 = getent("chair_actor_08","targetname") spawndrone();
		level.standing_actor_01 = getent("standing_actor_01","targetname") spawndrone();
	}

	var_06 = getent("standing_actor_02","targetname") spawndrone();
	var_07 = getent("standing_actor_03","targetname") spawndrone();
	var_08 = getent("standing_actor_04","targetname") spawndrone();
	var_09 = getent("standing_actor_05","targetname") spawndrone();
	var_0A = getent("standing_actor_06","targetname") spawndrone();
	var_0B = getent("standing_actor_08","targetname") spawndrone();
	var_0C = getent("standing_actor_09","targetname") spawndrone();
	var_01.animname = "chair_actor_01";
	var_02.animname = "chair_actor_02";
	var_03.animname = "chair_actor_04";
	var_04.animname = "chair_actor_05";
	var_05.animname = "chair_actor_06";
	if(level.nextgen)
	{
		level.chair_actor_07.animname = "chair_actor_07";
		level.chair_actor_08.animname = "chair_actor_08";
		level.standing_actor_01.animname = "standing_actor_01";
	}

	var_06.animname = "standing_actor_02";
	var_07.animname = "standing_actor_03";
	var_08.animname = "standing_actor_04";
	var_09.animname = "standing_actor_05";
	var_0A.animname = "standing_actor_06";
	var_0B.animname = "standing_actor_08";
	var_0C.animname = "standing_actor_09";
	if(level.nextgen)
	{
		var_0D = [var_01,var_02,var_03,var_04,var_05,level.chair_actor_07,level.chair_actor_08];
		var_0E = [level.standing_actor_01,var_06,var_07,var_08,var_09,var_0A,var_0B,var_0C];
	}
	else
	{
		var_0D = [var_03,var_04,var_05,var_06,var_07];
		var_0E = [var_07,var_08,var_09,var_0A,var_0B,var_0C,var_0D];
	}

	var_0F = common_scripts\utility::array_combine(var_0D,var_0E);
	foreach(var_11 in var_0F)
	{
		var_11 endon("death");
		var_11 thread maps\recovery_utility::delete_on_notify("funeral_done");
		var_11 maps\_anim::setanimtree();
	}

	param_00 thread maps\_anim::anim_loop(var_0F,"rec_funeral_eulogy_idle","stop_loop_custom");
}

//Function Number: 15
funeral_anim_card(param_00)
{
	common_scripts\utility::flag_wait("player_proximity_irons");
	var_01 = spawn("script_model",param_00.origin);
	var_01 setmodel("rec_irons_card");
	var_02 = maps\_utility::spawn_anim_model("atlas_card",param_00.origin,param_00.angles);
	param_00 maps\_anim::anim_first_frame_solo(var_02,"rec_funeral_altascard_card");
	var_01.origin = var_02 gettagorigin("tag_origin_animated");
	var_01.angles = var_02 gettagangles("tag_origin_animated");
	var_01 linkto(var_02,"tag_origin_animated");
	param_00 maps\_anim::anim_single_solo(var_02,"rec_funeral_altascard_card");
	var_02 delete();
	var_01 delete();
}

//Function Number: 16
funeral_play_animated_card()
{
	level waittill("play_atlas_card");
	setsaveddvar("cg_cinematicFullScreen","0");
	cinematicingameloop("business_card_master");
}

//Function Number: 17
funeral_anim_flag(param_00)
{
	param_00 = param_00 common_scripts\utility::spawn_tag_origin();
	param_00 thread maps\recovery_utility::delete_on_notify("funeral_done");
	var_01 = spawn("script_model",param_00.origin);
	var_01 setmodel("rec_flag_folded_01");
	var_02 = maps\_utility::spawn_anim_model("funeral_flag",param_00.origin,param_00.angles);
	param_00 maps\_anim::anim_first_frame_solo(var_02,"rec_funeral_eulogy_idle_flag_non_loop");
	var_01.origin = var_02 gettagorigin("tag_origin_animated");
	var_01.angles = var_02 gettagangles("tag_origin_animated");
	var_01 linkto(var_02,"tag_origin_animated");
	param_00 thread maps\_anim::anim_loop_solo(var_02,"rec_funeral_eulogy_idle_flag");
	common_scripts\utility::flag_wait("eulogy_complete");
	param_00 notify("stop_loop");
	param_00 maps\_anim::anim_single_solo(var_02,"rec_funeral_eulogy_ends_flag");
	param_00 thread maps\_anim::anim_loop_solo(var_02,"rec_funeral_eulogy_idle_flag");
	common_scripts\utility::flag_wait("funeral_complete");
	param_00 notify("stop_loop");
	var_02 delete();
	var_01 delete();
}

//Function Number: 18
funeral_intro_black_screen(param_00)
{
	var_01 = 1.5;
	if(!isdefined(level.black_overlay))
	{
		level.black_overlay = maps\_hud_util::create_client_overlay("black",0,level.player);
	}

	level.black_overlay.sort = -1;
	level.black_overlay.foreground = 1;
	var_02 = level.black_overlay;
	var_02.alpha = 1;
	wait(param_00);
	var_02 fadeovertime(var_01);
	var_02.alpha = 0;
}

//Function Number: 19
funeral_ambient_ai_soldiers()
{
	var_00 = getent("funeral_ambient_spawner_soldier_dress_ar","targetname");
	var_01 = getent("funeral_ambient_spawner_soldier_dress","targetname");
	var_02 = getentarray("funeral_ambient_spawner","targetname");
	var_03 = [];
	foreach(var_05 in var_02)
	{
		var_06 = maps\_utility::getstructarray_delete(var_05.script_noteworthy,"targetname");
		foreach(var_08 in var_06)
		{
			var_05.origin = var_08.origin;
			if(isdefined(var_08.angles))
			{
				var_05.angles = var_08.angles;
			}

			if(isdefined(var_08.target))
			{
				var_05.target = var_08.target;
			}

			var_09 = var_05 maps\_utility::spawn_ai(1);
			if(isdefined(var_08.script_modelname))
			{
				var_09 setmodel(var_08.script_modelname);
				var_09 detach(var_09.headmodel,"");
				if(issubstr(var_08.script_modelname,"female"))
				{
					var_09 attach("head_urban_civ_female_a","",1);
					var_09.headmodel = "head_urban_civ_female_a";
				}
			}

			var_09 thread maps\recovery_utility::delete_on_notify("funeral_done");
			var_09.script = "drone";
			var_03 = common_scripts\utility::array_add(var_03,var_09);
			if(isdefined(var_08.animation))
			{
				if(isdefined(var_08.script_delay) && var_08.script_delay == 0)
				{
					var_08 thread maps\_anim::anim_generic_loop(var_09,var_08.animation);
				}
				else
				{
					var_08 maps\_utility::delaythread(randomfloatrange(0,1),::maps\_anim::anim_generic_loop,var_09,var_08.animation);
				}
			}

			var_05.target = undefined;
		}
	}

	var_0C = getentarray("dress_marine_casket_spawner","targetname");
	foreach(var_05 in var_0C)
	{
		var_0E = var_05 maps\_utility::spawn_ai(1);
		var_0E.name = " ";
		var_0E maps\_utility::gun_remove();
		var_0E thread maps\_shg_design_tools::anim_simple(var_0E,var_05.animation);
		wait 0.05;
		var_0E thread maps\recovery_utility::delete_on_notify("funeral_done");
	}

	var_10 = common_scripts\utility::getstructarray("funeral_soldier_idle_casket","targetname");
	foreach(var_12 in var_10)
	{
		var_01.count = 1;
		var_0E = var_01 maps\_utility::spawn_ai(1);
		if(isdefined(var_12.model))
		{
			var_0E setmodel(var_12.model);
		}

		var_0E.name = " ";
		var_0E maps\_utility::gun_remove();
		var_12 thread maps\_shg_design_tools::anim_simple(var_0E,var_12.animation);
		wait 0.05;
		var_0E thread maps\recovery_utility::delete_on_notify("funeral_done");
	}

	var_14 = common_scripts\utility::getstruct("funeral_soldier_blocker_left","targetname");
	var_15 = common_scripts\utility::getstruct("funeral_soldier_blocker_right","targetname");
	var_01.count = 1;
	var_16 = var_01 maps\_utility::spawn_ai(1);
	var_16.name = " ";
	var_16 maps\_utility::gun_remove();
	var_14 thread maps\_shg_design_tools::anim_simple(var_16,var_14.animation);
	wait 0.05;
	var_16 thread maps\recovery_utility::delete_on_notify("funeral_done");
	var_01.count = 1;
	var_17 = var_01 maps\_utility::spawn_ai(1);
	var_17.name = " ";
	var_17 maps\_utility::gun_remove();
	var_15 thread maps\_shg_design_tools::anim_simple(var_17,var_15.animation);
	wait 0.05;
	var_17 thread maps\recovery_utility::delete_on_notify("funeral_done");
	common_scripts\utility::flag_wait("flag_obj_funeral_casket_complete");
	wait(1);
	var_16 delete();
	var_17 delete();
	var_18 = common_scripts\utility::getstruct("funeral_soldier_blocker_left_2","targetname");
	var_19 = common_scripts\utility::getstruct("funeral_soldier_blocker_right_2","targetname");
	var_01.count = 1;
	var_1A = var_01 maps\_utility::spawn_ai(1);
	var_1A.name = " ";
	var_1A maps\_utility::gun_remove();
	var_18 thread maps\_shg_design_tools::anim_simple(var_1A,var_18.animation);
	wait 0.05;
	var_1A thread maps\recovery_utility::delete_on_notify("funeral_done");
	var_01.count = 1;
	var_1B = var_01 maps\_utility::spawn_ai(1);
	var_1B.name = " ";
	var_1B maps\_utility::gun_remove();
	var_19 thread maps\_shg_design_tools::anim_simple(var_1B,var_19.animation);
	wait 0.05;
	var_1B thread maps\recovery_utility::delete_on_notify("funeral_done");
}

//Function Number: 20
funeral_cleanup()
{
	common_scripts\utility::flag_wait("funeral_complete");
	var_00 = getentarray("funeral_vehicle","targetname");
	foreach(var_02 in var_00)
	{
		var_02 delete();
	}
}

//Function Number: 21
camp_david_play_videos()
{
	setsaveddvar("cg_cinematicFullScreen","0");
	cinematicingameloop("rec_campdavid_tv",1,1);
}

//Function Number: 22
setup_training_sequence_1()
{
	thread training_s1_starting_enemies();
	thread training_s1_snipers();
	thread training_s1_prepare_to_breach();
	thread training_s1_setup_breach_marker();
	thread training_s1_prep_breach_room();
	thread training_s1_living_room_scene();
	thread training_s1_livingroom_ambush();
	thread training_s1_drone_attack();
	thread training_s1_breach_save();
	thread training_s1_patio_enemies();
	thread training_s1_patio_enemies_clear();
	thread training_s1_hide_from_patrols();
	thread training_s1_terrace_vehicles();
	thread training_s1_golf_course_vehicles();
	thread training_s1_setup_gideon();
	thread training_s1_setup_president();
	thread training_s1_escape_vehicle();
	thread training_s1_remove_player_weapons();
	thread training_s1_door_breach_anim();
	thread training_s1_bathroom_door_breach_anim();
	thread training_s1_player_breach();
	thread training_s1_breach_encounter();
	thread training_s1_patio_doors();
	thread training_s1_drone_search();
	thread training_s1_door_cover();
	thread training_s1_cleanup();
	thread training_s1_ending();
	thread training_s1_popping_smoke();
	thread training_s1_setup_driver();
	thread training_s1_setup_cart();
	thread training_s1_handle_tour_cart();
	thread training_s1_setup_irons();
}

//Function Number: 23
training_s1_opening()
{
	if(level.currentgen)
	{
		if(!istransientloaded("recovery_training_tr"))
		{
			maps\_hud_util::fade_out(0.05,"white");
			level notify("tff_pre_funeral_to_training");
			unloadtransient("recovery_funeral_tr");
			loadtransient("recovery_training_tr");
			while(!istransientloaded("recovery_training_tr"))
			{
				wait(0.05);
			}

			level notify("tff_post_funeral_to_training");
			maps\_hud_util::fade_in(0.05,"white");
		}
	}

	common_scripts\utility::flag_set("training_s1_spawn_starting_enemies");
	thread maps\recovery_utility::training_s1_windy_trees();
	thread maps\recovery_utility::training_set_up_player();
	maps\recovery::setup_allies("training_begin");
	level.joker thread maps\recovery_utility::training_s1_opening_guy_think("training_joker_start_point","training_s1_end");
	level.ally_squad_member_1 thread maps\recovery_utility::training_s1_opening_guy_think("training_squad_1_start_point","training_s1_end");
	level.ally_squad_member_2 thread maps\recovery_utility::training_s1_opening_guy_think("training_squad_2_start_point","training_s1_end");
	level.ally_squad_member_3 thread maps\recovery_utility::training_s1_opening_guy_think("training_squad_3_start_point","training_s1_end");
	level.ally_squad_member_4 thread maps\recovery_utility::training_s1_opening_guy_think("training_squad_4_start_point","training_s1_end");
	thread training_s1_anim_gun_examine();
	thread maps\recovery_utility::training_s1_set_squad_passive_and_ignore();
	level.ally_squad_member_2.animname = "rivers";
	common_scripts\utility::flag_set("training_start_area_lighting");
	wait(2);
	maps\_utility::activate_trigger("training_s1_color_trigger1","targetname");
}

//Function Number: 24
training_s1_anim_gun_examine()
{
	soundscripts\_snd::snd_message("camp_david_thunder_transition");
	var_00 = getent("org_anim_gun_examine","targetname");
	var_01 = maps\_utility::spawn_anim_model("player_rig");
	var_02 = maps\_utility::spawn_anim_model("atlas_gun");
	var_02 attach("npc_silencer_01","tag_range");
	var_02 attach("npc_optics_variable_red_dot","tag_red_dot");
	var_02 hidepart("tag_sight_on");
	var_03 = getent("lighting_centroid_training_start","targetname");
	if(level.nextgen)
	{
		var_02 overridematerial("m/mtl_bal27_base_black","m/mtl_bal27_base_black_logo");
	}
	else
	{
		var_02 overridematerial("mq/mtl_bal27_base_black","mq/mtl_bal27_base_black_logo");
	}

	var_01 overridelightingorigin(var_03.origin);
	var_04 = [var_01,var_02,level.joker];
	var_05 = "rec_campdavid_intro";
	var_00 maps\_anim::anim_first_frame(var_04,var_05);
	level.player maps\_shg_utility::setup_player_for_scene();
	level.player setorigin(var_01 gettagorigin("tag_player"));
	level.player playerlinktoabsolute(var_01,"tag_player");
	level.player common_scripts\utility::delaycall(1,::playerlinktodelta,var_01,"tag_player",1,10,15,15,10,1);
	level.player common_scripts\utility::delaycall(1.05,::springcamenabled,1,3.2,1.6);
	maps\_utility::delaythread(6,::common_scripts\utility::flag_set,"flag_vo_training_s1_joker_everyone_knows");
	level.player common_scripts\utility::delaycall(10,::playerlinktoblend,var_01,"tag_player",1,0.25,0.25);
	var_00 maps\_anim::anim_single(var_04,var_05);
	level.player maps\_shg_utility::setup_player_for_gameplay();
	level.player unlink();
	var_01 defaultlightingorigin();
	var_01 delete();
	var_02 delete();
	common_scripts\utility::flag_set("flag_obj_rescue1_start");
	wait(1);
	var_06 = &"RECOVERY_CAMP_DAVID";
	maps\_utility::center_screen_text(var_06);
	maps\_utility::autosave_by_name();
}

//Function Number: 25
training_s1_starting_enemies()
{
	common_scripts\utility::flag_wait("training_s1_spawn_starting_enemies");
	maps\_utility::array_spawn_noteworthy("training_s1_enemies_start",1);
	thread maps\recovery_utility::training_s1_joker_move();
	thread maps\recovery_utility::training_s1_alert_check();
	var_00 = getent("training_s1_starting_enemy_vehicle_1","script_noteworthy") maps\_utility::spawn_vehicle();
	if(level.nextgen)
	{
		common_scripts\utility::flag_wait("training_s1_end");
	}
	else
	{
		level waittill("tff_pre_training_to_tour_ride");
	}

	var_00 delete();
}

//Function Number: 26
training_s1_snipers()
{
	common_scripts\utility::flag_wait("training_s1_spawn_starting_enemies");
	level.enemies1 = maps\_utility::array_spawn_noteworthy("training_s1_enemies_patrol",1);
	var_00 = getent("training_s1_enemies_patrol_surprise","script_noteworthy");
	level.surprise_enemy = var_00 maps\_utility::spawn_ai(1);
	level.surprise_enemy thread maps\recovery_utility::training_s1_surprise_enemy_think();
	common_scripts\utility::flag_wait("training_s1_snipers_attack");
	common_scripts\utility::flag_set("flag_obj_rescue1_start_clear");
	maps\_utility::autosave_by_name();
	if(common_scripts\utility::flag("training_s1_start_alerted") == 0)
	{
		common_scripts\utility::flag_set("flag_vo_training_s1_joker_on_you");
		while(isalive(level.enemies1[0]) && isalive(level.enemies1[1]) && isalive(level.enemies1[2]))
		{
			wait(0.05);
		}

		level notify("training_s1_joker_take_out_nag_off");
		if(isalive(level.enemies1[2]))
		{
			level.enemies1[2].health = 1;
			magicbullet(level.ally_squad_member_3.weapon,level.ally_squad_member_3 gettagorigin("tag_flash"),level.enemies1[2] geteye());
			level.enemies1[2] maps\recovery_utility::bloody_death();
		}

		wait(0.25);
		if(isalive(level.enemies1[1]))
		{
			level.enemies1[1].health = 1;
			magicbullet(level.ally_squad_member_3.weapon,level.ally_squad_member_3 gettagorigin("tag_flash"),level.enemies1[1] geteye());
			level.enemies1[1] maps\recovery_utility::bloody_death();
		}

		wait(0.5);
		if(isalive(level.enemies1[0]))
		{
			level.enemies1[0].health = 1;
			magicbullet(level.ally_squad_member_3.weapon,level.ally_squad_member_3 gettagorigin("tag_flash"),level.enemies1[0] geteye());
			level.enemies1[0] maps\recovery_utility::bloody_death();
		}

		if(isalive(level.surprise_enemy))
		{
			var_01 = getnode("training_s1_enemy_attack_node5","targetname");
			var_02 = getnode("training_s1_enemy_attack_node2","targetname");
			level.surprise_enemy thread maps\recovery_utility::training_s1_surprise_enemy_go();
			level.surprise_enemy maps\_utility::clear_run_anim();
			level.surprise_enemy thread maps\recovery_utility::training_s1_monitor_surprise_enemy_death();
			maps\_utility::delaythread(3,::common_scripts\utility::flag_set,"flag_vo_training_s1_rivers_got_another");
			maps\_utility::delaythread(8,::maps\recovery_utility::training_s1_kill_surprise_enemy);
			level.surprise_enemy thread maps\recovery_utility::training_surprise_enemy_move_to_patio(var_02);
		}

		while(isalive(level.surprise_enemy))
		{
			wait(0.05);
		}

		maps\_utility::waittill_aigroupcleared("training_s1_start");
		if(common_scripts\utility::flag("training_s1_start_alerted") == 1)
		{
			maps\_utility::waittill_aigroupcleared("training_s1_enemies_start");
		}

		common_scripts\utility::flag_set("training_s1_prepare_breach_room");
		common_scripts\utility::flag_set("flag_obj_rescue1_enter");
		maps\_utility::autosave_by_name();
	}
}

//Function Number: 27
training_s1_prepare_to_breach()
{
	common_scripts\utility::flag_wait("training_s1_prepare_breach_room");
	camp_david_play_videos();
	if(common_scripts\utility::flag("training_s1_start_alerted") == 0)
	{
		wait(2);
		maps\_utility::activate_trigger("training_s1_color_trigger2","targetname");
		maps\_utility::activate_trigger("training_s1_color_entrance_trigger","targetname");
		common_scripts\utility::flag_set("flag_training_s1_joker_close_kitchen");
		common_scripts\utility::flag_set("training_s1_living_room_approach");
		thread maps\recovery_utility::training_s1_squad_allow_run();
		common_scripts\utility::flag_wait("training_s1_flag_entrance");
		if(common_scripts\utility::flag("training_s1_start_alerted"))
		{
			thread maps\recovery_utility::training_s1_set_squad_active_and_target();
			common_scripts\utility::flag_wait("training_s1_start_alerted_enemies_dead");
			thread maps\recovery_utility::training_s1_set_squad_passive_and_ignore();
		}

		maps\_utility::activate_trigger("training_s1_color_trigger2_cover","targetname");
		common_scripts\utility::flag_set("flag_obj_rescue1_enter_clear");
		common_scripts\utility::flag_set("flag_obj_rescue1_flash");
		common_scripts\utility::flag_set("training_ready_flash_bang");
		return;
	}

	while(isalive(level.surprise_enemy))
	{
		wait(0.05);
	}

	maps\_utility::waittill_aigroupcleared("training_s1_start");
	maps\_utility::waittill_aigroupcount("training_s1_enemies_start",4);
	common_scripts\utility::flag_set("training_s1_enemies_start_charge");
	maps\_utility::waittill_aigroupcleared("training_s1_enemies_start");
	wait(2);
	maps\_utility::activate_trigger("training_s1_color_trigger2","targetname");
	maps\_utility::activate_trigger("training_s1_color_entrance_trigger","targetname");
	common_scripts\utility::flag_set("flag_training_s1_joker_close_kitchen");
	common_scripts\utility::flag_set("training_s1_living_room_approach");
	maps\_utility::autosave_by_name();
	common_scripts\utility::flag_wait("training_s1_flag_entrance");
	maps\_utility::activate_trigger("training_s1_color_trigger2_cover","targetname");
	common_scripts\utility::flag_set("flag_obj_rescue1_enter_clear");
	common_scripts\utility::flag_set("flag_obj_rescue1_flash");
	common_scripts\utility::flag_set("training_ready_flash_bang");
}

//Function Number: 28
training_s1_living_room_scene_joker_open_door(param_00)
{
	if(!common_scripts\utility::flag_exist("s1_joker_peek_open_door"))
	{
		common_scripts\utility::flag_init("s1_joker_peek_open_door");
	}

	param_00 notify("stop_in_loop");
	param_00 maps\_anim::anim_single_solo(level.joker,"training_s1_threat_guy_open");
	param_00 thread maps\_anim::anim_loop_solo(level.joker,"training_s1_threat_guy_open_idle","stop_open_loop");
	common_scripts\utility::flag_set("s1_joker_peek_open_door");
}

//Function Number: 29
check_if_enemies_marked(param_00)
{
	foreach(var_02 in param_00)
	{
		if(isdefined(var_02.pdrone_marked_state) && var_02.pdrone_marked_state == "marked")
		{
			common_scripts\utility::flag_set("training_s1_flag_thermal");
			return 1;
		}
	}

	return 0;
}

//Function Number: 30
training_s1_living_room_scene()
{
	common_scripts\utility::flag_wait("training_s1_living_room_approach");
	level.living_room_clear = "nil";
	thread maps\recovery_utility::training_s1_threat_door();
	var_00 = common_scripts\utility::getstruct("training_s1_flashbang_animnode","targetname");
	thread maps\recovery_utility::training_s1_set_squad_passive_and_ignore();
	var_00 maps\_anim::anim_reach_solo(level.joker,"training_s1_threat_guy_in");
	var_00 maps\_anim::anim_single_solo(level.joker,"training_s1_threat_guy_in");
	common_scripts\utility::flag_set("training_s1_enable_living_room");
	var_00 thread maps\_anim::anim_loop_solo(level.joker,"training_s1_threat_guy_in_idle","stop_in_loop");
	common_scripts\utility::flag_wait("training_s1_living_room_scene");
	if(common_scripts\utility::flag("training_s1_start_alerted"))
	{
		thread maps\recovery_utility::training_s1_set_squad_active_and_target();
		common_scripts\utility::flag_wait("training_s1_start_alerted_enemies_dead");
		thread maps\recovery_utility::training_s1_set_squad_passive_and_ignore();
	}

	maps\_utility::autosave_by_name();
	common_scripts\utility::flag_wait("training_s1_enter_vo_complete");
	common_scripts\utility::flag_set("flag_vo_training_s1_joker_threat_grenade");
	thread maps\recovery_utility::training_s1_show_threat_text();
	thread maps\recovery_utility::training_s1_refill_threat_grenades();
	thread maps\recovery_utility::training_s1_flash_monitor();
	thread maps\recovery_utility::training_s1_shoot_monitor();
	thread training_s1_living_room_scene_joker_open_door(var_00);
	common_scripts\utility::flag_set("training_s1_peak_thermal_door");
	common_scripts\utility::flag_set("training_s1_clear_initial_spawn");
	common_scripts\utility::flag_wait("threat_grenade_hint_text_off");
	var_01 = maps\_utility::array_spawn_noteworthy("training_s1_enemies_flash",1);
	var_02 = getent("training_s1_surprise_enemy","targetname");
	var_03 = var_02 maps\_utility::spawn_ai(1);
	var_01 = common_scripts\utility::array_add(var_01,var_03);
	var_03 thread maps\recovery_utility::training_s1_enemies_living_room_think();
	var_04 = 0;
	while(!var_04 && !common_scripts\utility::flag("training_s1_flag_thermal") && !common_scripts\utility::flag("threat_breach_kickoff_gunfire"))
	{
		var_04 = check_if_enemies_marked(var_01);
		wait 0.05;
	}

	if(level.threat_attack == "threat" || var_04)
	{
		common_scripts\utility::array_thread(var_01,::training_s1_threat_enemies_react);
		maps\_utility::delaythread(1.5,::common_scripts\utility::flag_set,"flag_vo_training_s1_joker_hit_em");
		common_scripts\utility::flag_wait("s1_joker_peek_open_door");
		var_00 notify("stop_open_loop");
		var_00 maps\_anim::anim_single_solo(level.joker,"training_s1_threat_guy_open_idle2fire");
		var_00 thread maps\_anim::anim_loop_solo(level.joker,"training_s1_threat_guy_open_fire_idle","stop_open_loop2");
		level.living_room_clear = 0;
		thread maps\recovery_utility::training_s1_living_room_check();
		thread maps\recovery_utility::training_s1_living_room_timer();
		maps\_utility::delaythread(1.5,::maps\recovery_utility::training_s1_set_squad_active_and_target);
		var_01 thread maps\recovery_utility::training_s1_threat_enemies();
		while(level.living_room_clear == 0)
		{
			wait(0.05);
		}

		common_scripts\utility::flag_set("training_s1_open_thermal_door");
		var_00 notify("stop_open_loop2");
		var_00 thread maps\_anim::anim_single_solo(level.joker,"training_s1_threat_guy_out");
		maps\_utility::waittill_aigroupcleared("flash_enemies");
	}
	else
	{
		level notify("training_s1_joker_threat_grenade_nag_off");
		foreach(var_06 in var_01)
		{
			if(!isdefined(var_06) || !isalive(var_06))
			{
				continue;
			}

			var_06 thread maps\_utility::anim_stopanimscripted();
			var_06 notify("alert");
			var_06 thread maps\_stealth_shared_utilities::enemy_reaction_state_alert();
			var_06 thread maps\_stealth_utility::disable_stealth_for_ai();
			var_06.ignoreall = 0;
		}

		common_scripts\utility::flag_wait("s1_joker_peek_open_door");
		common_scripts\utility::flag_set("training_s1_open_thermal_door");
		if(level.threat_attack == "smart")
		{
			maps\_utility::delaythread(1,::common_scripts\utility::flag_set,"flag_vo_training_s1_joker_wrong_grenade");
			wait(3);
		}
		else
		{
			common_scripts\utility::flag_set("flag_vo_training_s1_joker_dammit");
		}

		var_00 notify("stop_open_loop");
		var_00 thread maps\_anim::anim_single_solo(level.joker,"training_s1_threat_guy_out");
		level.ally_squad_member_3 maps\_utility::stop_magic_bullet_shield();
		level.ally_squad_member_3 maps\recovery_utility::bloody_death();
		thread maps\recovery_utility::training_s1_set_squad_active_and_target();
		var_08 = getnode("threat_breach_cover","script_noteworthy");
		level.joker usecovernode(var_08);
		maps\_utility::waittill_aigroupcleared("flash_enemies");
	}

	maps\_utility::delaythread(2,::common_scripts\utility::flag_set,"flag_vo_training_s1_rivers_clear");
	wait(1);
	thread maps\recovery_utility::training_s1_set_sqaud_cqb_enable();
	maps\_utility::activate_trigger("training_s1_color_trigger_breach","targetname");
	common_scripts\utility::flag_set("training_flash_complete");
	common_scripts\utility::flag_set("training_s1_spawn_breach_door");
	common_scripts\utility::flag_set("training_s1_mute_breach_setup");
	common_scripts\utility::flag_set("flag_obj_rescue1_breach");
	wait(1.5);
	common_scripts\utility::flag_set("flag_vo_training_s1_joker_stack_up");
	thread maps\recovery_utility::training_s1_set_squad_passive_and_ignore();
	maps\_utility::autosave_by_name();
}

//Function Number: 31
training_s1_threat_enemies_react()
{
	if(!isalive(self))
	{
		return;
	}

	self endon("death");
	self.team = "axis";
	self.health = 1;
	self setnormalhealth(1);
	if(isdefined(self.animation))
	{
		thread maps\_utility::anim_stopanimscripted();
	}

	var_00 = getent("training_s1_threat_react_origin","targetname");
	var_01 = var_00.origin;
	childthread maps\_stealth_shared_utilities::enemy_reactto_and_lookaround(var_01);
	self notify("alert");
	childthread maps\_stealth_shared_utilities::enemy_reaction_state_alert();
	childthread maps\_stealth_utility::disable_stealth_for_ai();
	childthread maps\_utility::set_battlechatter(1);
	wait(randomfloatrange(0.25,1));
	var_02 = self findbestcovernode();
	if(isdefined(var_02))
	{
		maps\_utility::set_goal_node(var_02);
	}
}

//Function Number: 32
training_s1_setup_breach_marker()
{
	common_scripts\utility::flag_wait("training_s1_mute_breach_setup");
	var_00 = getent("breach_hint_01","targetname");
	var_01 = spawn("script_model",(0,0,0));
	var_01 setmodel("mutecharge_obj");
	var_01.angles = var_00.angles;
	var_01.origin = var_00.origin;
	var_02 = getent("training_s1_breach_door_trigger","targetname");
	var_03 = var_02 maps\_shg_utility::hint_button_trigger("use");
	thread breach_cleanup(var_01,var_03);
}

//Function Number: 33
breach_cleanup(param_00,param_01)
{
	level endon("missionfailed");
	level waittill("breaching");
	if(isdefined(param_00))
	{
		param_00 delete();
		param_01 maps\_shg_utility::hint_button_clear();
	}
}

//Function Number: 34
training_s1_breach_save()
{
	common_scripts\utility::flag_wait("door_breach_s1");
	maps\_utility::autosave_by_name();
}

//Function Number: 35
training_s1_prep_breach_room()
{
	common_scripts\utility::flag_wait("training_s1_mute_breach_setup");
	thread maps\recovery_utility::training_s1_breack_tv_screen();
	var_00 = common_scripts\utility::getstruct("training_s1_exo_breach_marker","targetname");
	level.joker thread training_s1_joker_mute_breach_start(var_00);
	level waittill("force_joker_breach_position");
	var_00 notify("stop_loop1");
	level.joker stopanimscripted();
	level.joker maps\_utility::delaythread(0.05,::maps\_anim::anim_self_set_time,"training_s1_exo_breach_joker_start",0.09);
	var_00 maps\_anim::anim_single_solo(level.joker,"training_s1_exo_breach_joker_start");
	var_00 thread maps\_anim::anim_loop_solo(level.joker,"training_s1_exo_breach_joker_release_idle","stop_loop2");
	common_scripts\utility::flag_wait_or_timeout("training_s1_bathroom_enemy_dead",2);
	if(!common_scripts\utility::flag("training_s1_bathroom_enemy_dead"))
	{
		var_00 notify("stop_loop2");
		var_00 maps\_anim::anim_single_solo(level.joker,"training_s1_exo_breach_joker_shoot_bathroom_guy");
		var_00 thread maps\_anim::anim_loop_solo(level.joker,"training_s1_exo_breach_joker_release_idle","stop_loop2");
	}

	common_scripts\utility::flag_wait("training_s1_release_president");
	var_00 notify("stop_loop2");
	maps\_utility::activate_trigger("training_s1_enter_drone_attack","targetname");
	var_00 maps\_anim::anim_single_solo_run(level.joker,"training_s1_exo_breach_joker_release");
	level.joker animcustom(::animscripts\run::moverun);
	level.joker maps\_utility::disable_cqbwalk();
}

//Function Number: 36
training_s1_joker_mute_breach_start(param_00)
{
	level endon("breaching");
	param_00 maps\_anim::anim_reach_solo(self,"training_s1_exo_breach_joker_approach");
	param_00 maps\_anim::anim_single_solo(self,"training_s1_exo_breach_joker_approach");
	param_00 thread maps\_anim::anim_loop_solo(self,"training_s1_exo_breach_joker_start_idle","stop_loop1");
}

//Function Number: 37
training_s1_player_breach()
{
	common_scripts\utility::flag_wait("training_s1_mute_breach_setup");
	var_00 = getent("training_s1_breach_door_trigger","targetname");
	var_00 thread maps\recovery_utility::disable_trigger_while_player_animating("breaching");
	for(;;)
	{
		var_00 waittill("trigger");
		if(!isdefined(var_00.trigger_off))
		{
			break;
		}
	}

	var_00 delete();
	thread maps\recovery_utility::play_rumble_training_s1_mute_breach();
	level notify("training_s1_joker_mute_charge_nag_off");
	thread maps\recovery_utility::training_s1_clear_bedrooms("training_round_2");
	thread maps\recovery_utility::training_s1_set_squad_passive_and_ignore();
	maps\_utility::battlechatter_off("axis");
	var_01 = common_scripts\utility::getstruct("training_s1_exo_breach_marker","targetname");
	var_02 = maps\_utility::spawn_anim_model("mute_charge",var_01.origin);
	var_02 hide();
	var_01 maps\_anim::anim_first_frame_solo(var_02,"breach_02_mutecharge");
	var_03 = maps\_utility::spawn_anim_model("player_rig",level.player.origin);
	var_03.animname = "player_rig";
	soundscripts\_snd::snd_message("rec_s2_breach_gun_holster");
	var_01 thread maps\_anim::anim_first_frame_solo(var_03,"training_s1_breach");
	var_03 hide();
	level.player maps\_shg_utility::setup_player_for_scene(0);
	var_04 = 1;
	level.player playerlinktoblend(var_03,"tag_player",var_04,var_04 * 0.5,var_04 * 0.5);
	wait(var_04);
	var_03 show();
	var_02 show();
	common_scripts\utility::flag_set("training_s1_breach_begin");
	common_scripts\utility::flag_set("training_s1_spawn_breach_enemies");
	common_scripts\utility::flag_set("flag_obj_rescue1_breach_clear");
	level notify("breaching");
	var_05 = 350;
	var_06 = 20;
	var_02 soundscripts\_snd::snd_message("camp_david_training_mute_device",var_05,var_06);
	var_01 thread maps\_anim::anim_single_solo(var_02,"breach_02_mutecharge");
	var_01 maps\_anim::anim_single_solo(var_03,"training_s1_breach");
	level.player unlink();
	var_03 delete();
	level.player maps\_shg_utility::setup_player_for_gameplay();
	level.player thread maps\recovery_utility::lerp_in_turn_rate(0.5);
	common_scripts\utility::flag_wait("training_s1_breach_enemy_dead");
	level notify("disable_mute_breach_fx");
	wait(2);
	var_02 delete();
}

//Function Number: 38
training_s1_breach_encounter()
{
	common_scripts\utility::flag_wait("training_s1_spawn_breach_enemies");
	maps\_utility::array_spawn_noteworthy("training_s1_enemies_breach",1);
	level.kva_shooter_s1 = getent("breach_kva_spawner1","targetname") maps\_utility::spawn_ai(1);
	level.kva_shooter_s1 thread maps\recovery_utility::training_s1_breach_kva_think();
	level.president = getent("training_s1_president_spawner","targetname") maps\_utility::spawn_ai(1);
	level.president thread maps\_president::set_president_anims();
	level.president thread maps\recovery_utility::training_s1_president_breach_setup("tour_exo_hangar");
	var_00 = maps\_utility::spawn_anim_model("ziptie_prop");
	var_00.animname = "ziptie_prop";
	var_01 = common_scripts\utility::getstruct("training_s1_exo_breach_marker","targetname");
	var_01 thread maps\_anim::anim_first_frame_solo(var_00,"training_s1_exo_ziptie_start");
	var_01 maps\_anim::anim_first_frame_solo(level.president,"training_s1_exo_breach_president_start");
	var_01 thread maps\_anim::anim_single_solo(var_00,"training_s1_exo_ziptie_start");
	var_01 maps\_anim::anim_single_solo(level.president,"training_s1_exo_breach_president_start");
	if(isalive(level.president))
	{
		var_01 thread maps\_anim::anim_loop_solo(var_00,"training_s1_exo_ziptie_react_idle","stop_loop");
		var_01 thread maps\_anim::anim_loop_solo(level.president,"training_s1_exo_breach_president_idle","stop_loop");
	}

	thread training_s1_president_shot(var_01,var_00);
}

//Function Number: 39
training_s1_president_shot(param_00,param_01)
{
	thread training_s1_kva_dead(param_00,param_01);
	thread maps\recovery_utility::training_s1_president_dead();
	level.president endon("kva_death");
	level.president waittill("stop_idle_loop_s1");
	param_00 notify("stop_loop");
	param_00 thread maps\_anim::anim_single_solo(param_01,"training_s1_exo_ziptie_fail");
	param_00 maps\_anim::anim_single_solo(level.president,"training_s1_exo_breach_president_fail");
	level.president.noragdoll = 1;
	level.president.allowdeath = 1;
	level.president.a.nodeath = 1;
	level.president maps\_utility::set_battlechatter(0);
	wait(0.05);
	level.president kill();
}

//Function Number: 40
training_s1_kva_dead(param_00,param_01)
{
	common_scripts\utility::flag_wait("training_s1_breach_enemy_dead");
	if(common_scripts\utility::flag("training_s1_flag_president_shot") == 0)
	{
		level.president notify("kva_death");
		thread training_s1_kva_shot(param_00,param_01);
	}
}

//Function Number: 41
training_s1_kva_shot(param_00,param_01)
{
	common_scripts\utility::flag_wait("training_s1_breach_enemy_dead");
	param_00 notify("stop_loop");
	if(isalive(level.president))
	{
		param_00 thread maps\_anim::anim_single_solo(param_01,"training_s1_exo_ziptie_success");
		param_00 maps\_anim::anim_single_solo(level.president,"training_s1_exo_breach_president_success");
	}

	if(isalive(level.president))
	{
		param_00 thread maps\_anim::anim_loop_solo(param_01,"training_s1_exo_ziptie_release_idle","stop_loop2");
		param_00 thread maps\_anim::anim_loop_solo(level.president,"training_s1_exo_breach_president_release_idle","stop_loop2");
	}

	common_scripts\utility::flag_wait("training_s1_breach_enemy_dead");
	common_scripts\utility::flag_wait("training_s1_bathroom_enemy_dead");
	wait(0.5);
	common_scripts\utility::flag_set("flag_vo_training_s1_rivers_room_clear");
	maps\_utility::delaythread(2,::common_scripts\utility::flag_set,"flag_vo_training_s1_joker_mr_president");
	thread training_s1_end_breach_logic();
	common_scripts\utility::flag_set("training_s1_release_president");
	param_00 notify("stop_loop2");
	if(isalive(level.president))
	{
		level.president notify("breach_s1_end");
		level.president thread maps\_utility::magic_bullet_shield();
		param_00 thread maps\_anim::anim_single_solo(param_01,"training_s1_exo_ziptie_release");
		param_00 maps\_anim::anim_single_solo_run(level.president,"training_s1_exo_breach_president_release");
		level.president animcustom(::animscripts\run::moverun);
		wait(0.15);
		level.president orientmode("face point",level.joker.origin);
		wait(0.25);
		level.president orientmode("face default");
		param_01 delete();
	}

	if(isalive(level.president))
	{
		common_scripts\utility::flag_set("flag_obj_rescue1_drone_attack");
	}
}

//Function Number: 42
training_s1_end_breach_logic()
{
	if(isalive(level.president))
	{
		common_scripts\utility::flag_set("training_s1_living_room_return");
		common_scripts\utility::flag_set("training_s1_close_living_room_door");
		common_scripts\utility::flag_set("training_s1_living_room_return");
		common_scripts\utility::flag_set("training_s1_breach_done");
		maps\_utility::battlechatter_on("axis");
		maps\_utility::autosave_by_name();
	}
}

//Function Number: 43
training_s1_bathroom_door_breach_anim()
{
	common_scripts\utility::flag_wait("training_s1_breach_enemy_dead");
	wait(2);
	thread maps\recovery_utility::training_s1_bathroom_breach_door();
	var_00 = getent("breach_s1_enemy_spawner04","targetname");
	level.kva_bathroom = var_00 maps\_utility::spawn_ai(1);
	level.kva_bathroom thread maps\recovery_utility::training_s1_bathroom_enemy_think();
}

//Function Number: 44
training_s1_door_breach_anim()
{
	common_scripts\utility::flag_wait("training_s1_spawn_breach_door");
	var_00 = common_scripts\utility::getstruct("training_s1_exo_breach_marker","targetname");
	var_01 = getent("training_exo_breach_door","targetname");
	var_01.animname = "door_prop";
	var_01 maps\_utility::assign_animtree();
	var_02 = getent("training_exo_breach_door_clip","targetname");
	var_03 = var_02.angles;
	var_04 = var_02.origin;
	var_00 maps\_anim::anim_first_frame_solo(var_01,"training_s1_exo_door");
	var_02 linkto(var_01,"door");
	level waittill("breaching");
	var_00 maps\_anim::anim_single_solo(var_01,"training_s1_exo_door");
	var_02 connectpaths();
	common_scripts\utility::flag_wait("training_round_2");
	var_00 maps\_anim::anim_first_frame_solo(var_01,"training_s2_exo_door");
	var_02.angles = var_02.angles + var_03;
	var_02.origin = var_02.origin + var_04;
	wait(1);
	var_02 disconnectpaths();
}

//Function Number: 45
training_s1_drone_search()
{
	common_scripts\utility::flag_wait("training_s1_flag_drone_hallway");
	thread maps\_utility::autosave_by_name();
	thread maps\recovery_utility::training_s1_set_squad_passive_and_ignore();
	thread vehicle_scripts\_pdrone_tactical_picker::main();
	var_00 = maps\_vehicle::spawn_vehicles_from_targetname_and_drive("training_s1_search_drones");
	level.search_drones_count = 0;
	foreach(var_02 in var_00)
	{
		var_02 thread maps\recovery_utility::training_s1_set_up_search_drones("training_s1_search_drones_attack","training_s1_search_drones_done");
		var_02 thread training_s1_drone_blinds_destroy_think("training_s1_search_drones_attack");
	}

	soundscripts\_snd::snd_message("rec_s1_drones_fly_by",var_00);
	maps\_utility::delaythread(6,::common_scripts\utility::flag_set,"flag_vo_training_s1_rivers_got_drones");
	thread training_s1_alert_drones("training_s1_search_drones_attack");
	while(common_scripts\utility::flag("training_s1_search_drones_done") == 0)
	{
		if(level.player isfiring() == 1 || level.player isthrowinggrenade() == 1)
		{
			if(!common_scripts\utility::flag("training_s1_search_drones_done"))
			{
				soundscripts\_snd::snd_message("rec_s1_drones_attack",var_00);
			}

			wait(3);
			if(!common_scripts\utility::flag("training_s1_search_drones_done"))
			{
				common_scripts\utility::flag_set("training_s1_search_drones_attack");
			}

			return;
		}

		wait(0.05);
	}
}

//Function Number: 46
training_s1_alert_drones(param_00)
{
	self endon("training_s1_search_drones_done");
	common_scripts\utility::flag_wait(param_00);
	thread maps\recovery_utility::training_s1_set_squad_active_and_target();
	while(level.search_drones_count < 2)
	{
		wait(0.05);
	}

	common_scripts\utility::flag_set("training_s1_spawn_drones_reinforcements");
	while(level.search_drones_count < 3)
	{
		wait(0.05);
	}

	common_scripts\utility::flag_wait("training_s1_ambush_cleanup");
	common_scripts\utility::flag_set("training_s1_search_drones_done");
}

//Function Number: 47
training_s1_livingroom_ambush()
{
	common_scripts\utility::flag_wait("training_s1_living_room_return");
	maps\_utility::activate_trigger("training_s1_livingroom_ambush","targetname");
	thread maps\recovery_utility::training_s1_patio_door_breach();
	common_scripts\utility::flag_wait("training_s1_search_drones_done");
	common_scripts\utility::flag_set("training_s1_joker_search_drones_cover");
	level waittill("advance_to_patio");
	level.joker maps\_utility::enable_ai_color_dontmove();
	maps\_utility::activate_trigger("training_s1_color_trigger_patio","targetname");
	common_scripts\utility::flag_set("flag_obj_rescue1_patio_ambush");
	maps\_utility::autosave_by_name();
}

//Function Number: 48
training_s2_drone_blinds_destroy_think()
{
	training_s1_drone_blinds_destroy_think();
}

//Function Number: 49
training_s1_drone_blinds_destroy_think(param_00)
{
	self endon("death");
	if(isdefined(param_00))
	{
		common_scripts\utility::flag_wait(param_00);
	}

	var_01 = 50;
	for(;;)
	{
		radiusdamage(self.origin,var_01,1000,500,self);
		wait 0.05;
	}
}

//Function Number: 50
training_s1_drone_attack()
{
	common_scripts\utility::flag_wait("training_s1_search_drones_attack");
	maps\_utility::delaythread(2,::common_scripts\utility::flag_set,"flag_vo_training_s1_joker_take_out");
	thread maps\recovery_utility::training_s1_set_squad_active_and_target();
	thread maps\recovery_utility::training_s1_drone_ambush_scene();
	var_00 = common_scripts\utility::getstruct("attacklocation3","targetname");
	var_01 = common_scripts\utility::getstructarray(var_00.target,"targetname");
	magicbullet("iw5_bal27_sp_silencer01_variablereddot",var_00.origin,var_01[0].origin);
	wait(1);
	magicbullet("iw5_bal27_sp_silencer01_variablereddot",var_00.origin,var_01[1].origin);
	wait(0.5);
	magicbullet("iw5_bal27_sp_silencer01_variablereddot",var_00.origin,var_01[2].origin);
	wait(0.5);
	magicbullet("iw5_bal27_sp_silencer01_variablereddot",var_00.origin,var_01[3].origin);
	wait(0.5);
	magicbullet("iw5_bal27_sp_silencer01_variablereddot",var_00.origin,var_01[4].origin);
	wait(0.25);
	magicbullet("iw5_bal27_sp_silencer01_variablereddot",var_00.origin,var_01[5].origin);
	wait(0.5);
	magicbullet("iw5_bal27_sp_silencer01_variablereddot",var_00.origin,var_01[6].origin);
	wait(0.5);
	magicbullet("iw5_bal27_sp_silencer01_variablereddot",var_00.origin,var_01[7].origin);
	common_scripts\utility::flag_wait("training_s1_spawn_drones_reinforcements");
	thread vehicle_scripts\_pdrone_tactical_picker::main();
	var_02 = [];
	var_02 = vehicle_scripts\_pdrone::start_flying_attack_drones("s1_flying_attack_drones1");
	foreach(var_04 in var_02)
	{
		var_04 thread training_s1_drone_blinds_destroy_think();
		var_04 thread maps\recovery_utility::training_s1_drone_attack_think();
	}

	maps\recovery_utility::waittill_drones_dead(var_02);
	common_scripts\utility::flag_set("training_s1_ambush_cleanup");
}

//Function Number: 51
training_s1_patio_doors()
{
	var_00 = common_scripts\utility::getstruct("training_s2_patio_door_animnode","targetname");
	level.patio_doors = getent("training_patio_french_doors","targetname");
	level.patio_doors.animname = "patio_doors";
	level.patio_doors maps\_anim::setanimtree();
	var_01 = getent("french_door_clip_01","targetname");
	var_02 = getent("french_door_clip_02","targetname");
	var_00 maps\_anim::anim_first_frame_solo(level.patio_doors,"training_s1_patio_doors_in");
	var_01 linkto(level.patio_doors,"door_r");
	var_02 linkto(level.patio_doors,"door_l");
	common_scripts\utility::flag_wait("training_s1_patio_doors_joker_in");
	var_00 thread maps\_anim::anim_loop_solo(level.patio_doors,"training_s1_patio_doors_alert_idle","stop_loop2");
	common_scripts\utility::flag_wait("training_s1_joker_search_drones_cover");
	if(common_scripts\utility::flag("training_s1_search_drones_attack") == 1)
	{
		common_scripts\utility::flag_wait("training_s1_breach_patio_doors_open");
		var_00 notify("stop_loop2");
		var_00 maps\_anim::anim_single_solo(level.patio_doors,"training_s1_patio_doors_out");
	}
	else
	{
		common_scripts\utility::flag_wait("training_s1_slow_patio_doors_open");
		var_00 notify("stop_loop2");
		var_00 maps\_anim::anim_single_solo(level.patio_doors,"training_s1_patio_doors_slow_open");
		var_00 maps\_anim::anim_single_solo(level.patio_doors,"training_s1_patio_doors_slow_out");
	}

	var_01 connectpaths();
	var_02 connectpaths();
	wait(1);
	var_01 disconnectpaths();
	var_02 disconnectpaths();
	common_scripts\utility::flag_wait("training_s1_end");
	var_00 maps\_anim::anim_first_frame_solo(level.patio_doors,"training_s1_patio_doors_in");
	wait(1);
	var_01 disconnectpaths();
	var_02 disconnectpaths();
}

//Function Number: 52
training_s1_patio_enemies()
{
	common_scripts\utility::flag_wait("training_s1_spawn_patio_enemies");
	thread maps\recovery_utility::play_reload_malfunction_on_next_reload();
	thread maps\recovery_utility::training_s1_set_squad_passive_and_ignore();
	maps\_utility::array_spawn_noteworthy("training_s1_patio_enemies",1);
	thread maps\recovery_utility::training_s1_allies_advance();
	if(common_scripts\utility::flag("training_s1_search_drones_attack") == 1)
	{
		common_scripts\utility::flag_set("training_s1_patio_alerted");
		var_00 = common_scripts\utility::getstruct("magic_grenade_start","targetname");
		var_01 = common_scripts\utility::getstruct("magic_grenade_target","targetname");
		var_02 = magicgrenade("flash_grenade",var_00.origin,var_01.origin,1.25,1);
		soundscripts\_snd::snd_message("patio_flashbang",1.25,var_01.origin);
		wait(1.5);
		var_03 = getent("patio_flash_ambush","targetname") maps\_utility::spawn_ai(1);
		var_03 thread maps\_utility::player_seek_enable();
		common_scripts\utility::flag_wait("training_s1_flashed");
		thread maps\recovery_utility::training_s1_set_squad_active_and_target();
		maps\_utility::delaythread(4,::common_scripts\utility::flag_set,"flag_vo_training_s1_rivers_contact_below");
		common_scripts\utility::flag_wait("training_s1_spawn_patio_enemies_wave2");
		maps\_utility::array_spawn_noteworthy("training_s1_patio_enemies2",1);
		common_scripts\utility::flag_wait("training_s1_spawn_patio_enemies_wave3");
		thread maps\recovery_utility::training_s1_pool_house_doors();
		maps\_utility::array_spawn_noteworthy("training_s1_patio_enemies3",0,1);
		maps\_utility::waittill_aigroupcount("patio_ambush2",1);
		common_scripts\utility::flag_set("training_s1_clear_patio1");
		common_scripts\utility::flag_set("training_s1_clear_patio2");
		maps\_utility::waittill_aigroupcleared("patio_ambush2");
		maps\_utility::waittill_aigroupcount("patio_ambush3",1);
		common_scripts\utility::flag_set("training_s1_clear_patio3");
		maps\_utility::waittill_aigroupcleared("patio_ambush3");
		common_scripts\utility::flag_set("training_s1_patio_clear");
		return;
	}

	thread training_s1_patio_spawn_reinforcements();
	common_scripts\utility::flag_set("flag_vo_training_s1_rivers_multiple_hostiles");
	common_scripts\utility::flag_wait("training_s1_spawn_patio_enemies_wave2");
	if(common_scripts\utility::flag("training_s1_patio_alerted") == 1)
	{
		maps\_utility::array_spawn_noteworthy("training_s1_patio_enemies2",1);
		thread maps\recovery_utility::training_s1_set_squad_active_and_target();
		common_scripts\utility::flag_set("training_s1_spawn_patio_wave2");
	}

	common_scripts\utility::flag_wait("training_s1_spawn_patio_enemies_wave3");
	if(common_scripts\utility::flag("training_s1_patio_alerted") == 1 && common_scripts\utility::flag("training_s1_spawn_patio_wave3") == 0)
	{
		thread maps\recovery_utility::training_s1_pool_house_doors();
		maps\_utility::array_spawn_noteworthy("training_s1_patio_enemies3",1);
		thread maps\recovery_utility::training_s1_set_squad_active_and_target();
		common_scripts\utility::flag_set("training_s1_spawn_patio_wave3");
	}

	if(common_scripts\utility::flag("training_s1_patio_alerted") == 1)
	{
		if(common_scripts\utility::flag("training_s1_spawn_patio_wave2") == 1)
		{
			maps\_utility::waittill_aigroupcount("patio_ambush2",1);
			common_scripts\utility::flag_set("training_s1_clear_patio1");
			common_scripts\utility::flag_set("training_s1_clear_patio2");
			maps\_utility::waittill_aigroupcleared("patio_ambush2");
		}

		if(common_scripts\utility::flag("training_s1_spawn_patio_wave3") == 1)
		{
			maps\_utility::waittill_aigroupcount("patio_ambush3",1);
			common_scripts\utility::flag_set("training_s1_clear_patio3");
			maps\_utility::waittill_aigroupcleared("patio_ambush3");
			common_scripts\utility::flag_set("training_s1_patio_clear");
		}
	}
	else
	{
		maps\_utility::waittill_aigroupcleared("patio_ambush1");
	}

	if(common_scripts\utility::flag("training_s1_spawn_patio_wave3") == 0)
	{
		common_scripts\utility::flag_set("training_s1_patio_clear");
		return;
	}

	maps\_utility::waittill_aigroupcleared("patio_ambush3");
	common_scripts\utility::flag_set("training_s1_patio_clear");
}

//Function Number: 53
training_s1_patio_enemies_clear()
{
	common_scripts\utility::flag_wait("training_s1_patio_clear");
	var_00 = getaiarray("axis");
	var_00 = maps\_utility::remove_dead_from_array(var_00);
	foreach(var_02 in var_00)
	{
		if(isalive(var_02))
		{
			var_02 thread maps\_utility::player_seek_enable();
		}
	}

	while(var_00.size > 1)
	{
		var_00 = maps\_utility::remove_dead_from_array(var_00);
		wait 0.05;
	}

	var_00 = maps\_utility::remove_dead_from_array(var_00);
	foreach(var_02 in var_00)
	{
		var_02 thread maps\recovery_utility::bloody_death(randomfloatrange(0.5,1.5));
	}

	thread maps\recovery_utility::training_s1_set_sqaud_cqb_disable();
	maps\_utility::autosave_by_name();
	common_scripts\utility::flag_set("flag_obj_rescue1_patio_ambush_clear");
	common_scripts\utility::flag_set("flag_obj_rescue1_patio_mid");
	common_scripts\utility::flag_set("training_s1_hide");
	if(common_scripts\utility::flag("training_s1_patio_alerted") == 1)
	{
		common_scripts\utility::flag_set("flag_vo_training_s1_joker_pools_clear");
		return;
	}

	common_scripts\utility::flag_set("flag_vo_training_s1_joker_pools_clear_stealth");
}

//Function Number: 54
training_s1_patio_spawn_reinforcements()
{
	common_scripts\utility::flag_wait("training_s1_patio_alerted");
	if(common_scripts\utility::flag("training_s1_spawn_patio_enemies_wave3") == 1 && common_scripts\utility::flag("training_s1_spawn_patio_wave3") == 0)
	{
		common_scripts\utility::flag_set("training_s1_spawn_patio_wave3");
		thread maps\recovery_utility::training_s1_pool_house_doors();
		maps\_utility::array_spawn_noteworthy("training_s1_patio_enemies3",1);
		thread maps\recovery_utility::training_s1_set_squad_active_and_target();
	}
}

//Function Number: 55
training_s1_hide_from_patrols()
{
	common_scripts\utility::flag_wait("training_s1_hide");
	wait(2);
	if(!common_scripts\utility::flag("training_s1_hide_from_patrols_done"))
	{
		thread maps\recovery_utility::training_s1_set_squad_passive_and_ignore();
		maps\_utility::delaythread(1,::maps\_utility::activate_trigger,"training_s1_hide_from_patrols","targetname");
		common_scripts\utility::flag_set("flag_obj_rescue1_golf_course");
		common_scripts\utility::flag_wait("training_s1_hide_from_patrols_done");
		wait(2);
		if(common_scripts\utility::flag("training_s1_spotted") == 0)
		{
			common_scripts\utility::flag_set("flag_vo_training_s1_joker_ok_move");
		}
		else
		{
			common_scripts\utility::flag_set("flag_vo_training_s1_joker_were_clear");
		}
	}

	maps\_stealth_visibility_system::system_default_detect_ranges();
	maps\_utility::activate_trigger("training_s1_color_trigger_golf_course2","targetname");
	maps\_utility::delaythread(3,::maps\_utility::autosave_by_name);
	common_scripts\utility::flag_set("training_s1_allow_path_to_level_end");
	common_scripts\utility::flag_set("flag_obj_rescue1_golf_course2");
	common_scripts\utility::flag_wait("training_s1_golf_course_flag2");
	common_scripts\utility::flag_set("flag_obj_rescue1_golf_course");
	common_scripts\utility::flag_set("flag_obj_rescue1_golf_course_clear");
	common_scripts\utility::flag_set("flag_obj_rescue1_golf_course2_clear");
	common_scripts\utility::flag_set("flag_vo_training_s1_joker_prophet_approaching");
	maps\_utility::activate_trigger("training_s1_color_trigger_escape_car","targetname");
	common_scripts\utility::flag_set("flag_obj_rescue1_escape_location");
	common_scripts\utility::flag_set("training_s1_ambush");
}

//Function Number: 56
training_s1_terrace_vehicles()
{
	common_scripts\utility::flag_wait("training_s1_terrace_vehicles");
	var_00 = getent("training_s1_terrace_vehicles","script_noteworthy") maps\_vehicle::spawn_vehicle_and_gopath();
	maps\_utility::array_spawn_noteworthy("training_s1_golf_course_patrollers",1);
	thread maps\recovery_utility::training_s1_golf_course_encounter_track_deaths();
	if(level.currentgen)
	{
		var_00 thread tff_cleanup_vehicle("training");
	}

	soundscripts\_snd::snd_message("rec_train1_stealth_car_spawn",var_00);
	if(common_scripts\utility::flag("training_s1_patio_clear"))
	{
		maps\_utility::autosave_by_name();
		thread maps\recovery_utility::training_s1_set_squad_passive_and_ignore();
		common_scripts\utility::flag_set("flag_vo_training_s1_joker_patrol_approaching");
		common_scripts\utility::flag_set("flag_obj_rescue1_golf_course_clear");
		if(level.player getstance() != "prone" && common_scripts\utility::flag("training_s1_spotted") == 0)
		{
			thread maps\recovery_utility::training_prone_hint_text();
		}

		thread maps\recovery_utility::training_s1_golf_course_custom_stealth();
		wait(8);
		common_scripts\utility::flag_set("flag_vo_training_s1_joker_dont_engage");
		while(common_scripts\utility::flag("training_s1_hide_from_patrols_done") == 0)
		{
			if(common_scripts\utility::flag("training_s1_spotted"))
			{
				maps\_utility::delaythread(1.5,::common_scripts\utility::flag_set,"flag_vo_training_s1_shit_clear");
				thread maps\recovery_utility::training_s1_set_squad_active_and_target();
				return;
			}

			wait(0.05);
		}
	}

	if(!common_scripts\utility::flag("training_s1_spotted"))
	{
		level endon("training_s1_end");
		common_scripts\utility::flag_wait("training_s1_spotted");
		if(!common_scripts\utility::flag("training_s1_golf_course_vehicles"))
		{
			maps\_utility::delaythread(1.5,::common_scripts\utility::flag_set,"flag_vo_training_s1_shit_clear");
		}

		thread maps\recovery_utility::training_s1_set_squad_active_and_target();
	}

	maps\_stealth_visibility_system::system_default_detect_ranges();
}

//Function Number: 57
training_s1_escape_vehicle()
{
	common_scripts\utility::flag_wait("training_s1_start_escape_vehicle");
	common_scripts\utility::flag_set("flag_vo_training_s1_prophet_exfil_approach");
	wait(2);
	level.escape_vehicle = getent("training_s1_escape_vehicle","script_noteworthy") maps\_utility::spawn_vehicle();
	level.escape_vehicle maps\_utility::magic_bullet_shield();
	level.escape_vehicle.animname = "avt";
	level thread maps\recovery_fx::training_escape_vehicle_1_fx(level.escape_vehicle);
	var_00 = common_scripts\utility::getstruct("training_s1_ending_anim_origin","targetname");
	var_00 maps\_anim::anim_first_frame_solo(level.escape_vehicle,"training_s1_vehicle_end");
	var_01 = getent("trig_escape_vehicle_bumper","targetname");
	var_01 enablelinkto();
	var_01 linkto(level.escape_vehicle);
	thread bumper_test(var_01);
	soundscripts\_snd::snd_message("rec_train1_exfil_car_start",level.escape_vehicle);
	var_00 maps\_anim::anim_single_solo(level.escape_vehicle,"training_s1_vehicle_end");
	maps\_utility::autosave_by_name();
	common_scripts\utility::flag_set("training_s1_escape_vehicle_ready");
	common_scripts\utility::flag_wait("tour_exo_hangar");
	if(isdefined(level.escape_vehicle.magic_bullet_shield))
	{
		level.escape_vehicle maps\_utility::stop_magic_bullet_shield();
	}

	if(isdefined(level.escape_vehicle))
	{
		level.escape_vehicle delete();
	}
}

//Function Number: 58
bumper_test(param_00)
{
	param_00 endon("death");
	var_01 = 4;
	param_00 common_scripts\utility::delaycall(var_01,::delete);
	common_scripts\utility::flag_wait("escape_vehicle_bumper");
	level.player kill();
}

//Function Number: 59
training_s1_golf_course_vehicles()
{
	common_scripts\utility::flag_wait("training_s1_golf_course_vehicles");
	maps\_utility::autosave_by_name();
	maps\_utility::array_spawn_noteworthy("training_s1_end_enemies",1);
	thread maps\recovery_utility::play_reload_malfunction_on_next_reload("training_s1_start_escape_vehicle");
	maps\_utility::delaythread(6,::common_scripts\utility::flag_set,"flag_vo_training_s1_rivers_hostiles_road");
	level.player.showhint = 1;
	maps\_utility::delaythread(9.5,::maps\_utility::display_hint_timeout,"stim_prompt",5);
	thread maps\recovery_utility::training_s1_set_squad_active_and_target();
	maps\_utility::waittill_aigroupcount("s1_end_ambush",4);
	maps\_utility::array_spawn_noteworthy("training_s1_kva_ambush1",1);
	maps\_utility::waittill_aigroupcount("s1_end_ambush2",5);
	common_scripts\utility::flag_set("training_s1_allow_escape");
	maps\_utility::array_spawn_noteworthy("training_s1_kva_ambush2",1);
}

//Function Number: 60
training_s1_door_cover()
{
	common_scripts\utility::flag_wait("training_s1_flag_trees_cloak");
	common_scripts\utility::array_thread(getentarray("training_door_cover","script_noteworthy"),::common_scripts\utility::hide_notsolid);
	common_scripts\utility::flag_wait("training_round_2");
	common_scripts\utility::array_thread(getentarray("training_door_cover","script_noteworthy"),::common_scripts\utility::show_solid);
}

//Function Number: 61
training_s1_cleanup()
{
	common_scripts\utility::flag_wait("training_s1_end");
	soundscripts\_snd::snd_message("rec_train1_end");
	wait(3);
	clearallcorpses();
	var_00 = getentarray("weapon_flash_grenade_var","classname");
	var_01 = getentarray("weapon_frag_grenade_var","classname");
	var_02 = common_scripts\utility::array_combine(var_00,var_01);
	foreach(var_04 in var_02)
	{
		var_04 delete();
	}

	common_scripts\utility::flag_set("training_remove_player_weapons");
	thread maps\recovery_utility::training_reset_stealth_settings();
}

//Function Number: 62
training_s1_ending()
{
	common_scripts\utility::flag_wait("training_s1_allow_escape");
	var_00 = getent("bad_place_escape_vehicle_s1","targetname");
	badplace_brush("parking_spot",-1,var_00,"axis");
	common_scripts\utility::flag_set("training_s1_start_escape_vehicle");
	common_scripts\utility::flag_wait("training_s1_escape_vehicle_ready");
	common_scripts\utility::flag_set("flag_obj_rescue1_escape_vehicle");
	common_scripts\utility::flag_set("flag_vo_training_s1_joker_our_ride");
	var_01 = getent("training_s1_ending_trigger","targetname");
	var_02 = var_01 maps\_shg_utility::hint_button_trigger("use");
	for(;;)
	{
		var_01 waittill("trigger");
		if(!isdefined(var_01.trigger_off))
		{
			break;
		}
	}

	var_01 delete();
	var_03 = getentarray("grenade","classname");
	foreach(var_05 in var_03)
	{
		var_05 delete();
	}

	level.player enableinvulnerability();
	thread maps\recovery_utility::play_rumble_training_s1_president_load_fail();
	common_scripts\utility::flag_set("flag_obj_rescue1_escape_vehicle_clear");
	common_scripts\utility::flag_set("knockdown_lighting");
	common_scripts\utility::flag_set("training_s1_end_anim_started");
	common_scripts\utility::flag_set("flag_vo_pa_reset");
	level notify("training_s1_joker_ride_nag_off");
	foreach(var_08 in getaiarray("axis"))
	{
		var_08 delete();
	}

	badplace_delete("parking_spot");
	var_02 thread maps\_shg_utility::hint_button_clear();
	level.player_rig = maps\recovery_utility::spawn_player_rig();
	level.player_rig hide();
	clearallcorpses();
	level.joker maps\_utility::stop_magic_bullet_shield();
	level.joker delete();
	var_0A = common_scripts\utility::getstruct("training_s1_ending_anim_origin","targetname");
	var_0A.origin = var_0A.origin + (0,0,3.25);
	var_0B = 0.4;
	var_0A maps\_anim::anim_first_frame_solo(level.player_rig,"training_s1_player_end");
	level.player playerlinktoblend(level.player_rig,"tag_player",var_0B);
	level.player maps\_shg_utility::setup_player_for_scene(1,var_0B);
	level.player_rig show();
	thread training_unlock_doors();
	common_scripts\utility::flag_set("training_s1_end_setup_gideon");
	common_scripts\utility::flag_set("training_s1_end_setup_president");
	common_scripts\utility::flag_set("training_s1_end_setup_cart");
	common_scripts\utility::flag_set("training_s1_end_setup_driver");
	common_scripts\utility::flag_set("training_s1_end_setup_irons");
	common_scripts\utility::flag_set("training_s1_end_cease_fire");
	level.player common_scripts\utility::delaycall(1,::playerlinktodelta,level.player_rig,"tag_player",1,10,10,10,10,1);
	level.player common_scripts\utility::delaycall(1.05,::springcamenabled,1,3.2,1.6);
	var_0A maps\_anim::anim_single_solo(level.player_rig,"training_s1_player_end");
	level.player unlink();
	level.player_rig hide();
	level.player maps\_shg_utility::setup_player_for_gameplay();
	soundscripts\_snd::snd_message("tour_jeep_startup");
	level.player disableinvulnerability();
	level.player disableweaponpickup();
	thread training_s1_tour_jeep_board_warn();
	thread training_s1_tour_jeep_board_fail();
	var_0C = getent("clip_jeep_door","targetname");
	var_0C.origin = var_0C.origin + (0,0,64);
	thread maps\_utility::autosave_now();
	common_scripts\utility::flag_wait("training_s1_allow_end_enter_jeep");
	common_scripts\utility::flag_set("flag_obj_follow_gideon");
	common_scripts\utility::flag_set("flag_vo_training_gideon_jeep_nag");
	common_scripts\utility::flag_wait("flag_obj_rescue1_allow_end_enter_jeep_clear");
	level.player enableweaponpickup();
	var_0C delete();
	level notify("training_gideon_jeep_nag_off");
	common_scripts\utility::flag_set("training_s1_end_enter_jeep");
	level.player_rig hide();
	level.player_rig dontcastshadows();
	var_0A maps\_anim::anim_first_frame_solo(level.player_rig,"training_s1_player_end_jeep_enter");
	level.player playerlinktoblend(level.player_rig,"tag_player",var_0B);
	level.player maps\_shg_utility::setup_player_for_scene(1,var_0B);
	level.player_rig show();
	var_0A maps\_anim::anim_single_solo(level.player_rig,"training_s1_player_end_jeep_enter");
	level.player unlink();
	level.player maps\_shg_utility::setup_player_for_gameplay();
	common_scripts\utility::flag_set("start_tour_ride");
	common_scripts\utility::flag_set("flag_obj_rescue1_complete");
}

//Function Number: 63
training_s1_popping_smoke()
{
	common_scripts\utility::flag_wait("training_s1_start_escape_vehicle");
	if(isdefined(level.joker))
	{
		maps\_utility::delaythread(3,::common_scripts\utility::flag_set,"flag_vo_training_s1_joker_poppin_smoke");
	}

	wait(5);
	var_00 = common_scripts\utility::getstruct("training_s1_pop_smoke_target","targetname");
	var_01 = magicgrenade("smoke_grenade_cheap",var_00.origin,var_00.origin,0,0);
	soundscripts\_snd::snd_message("s1_popping_smoke",var_00.origin);
}

//Function Number: 64
training_s1_tour_jeep_board_fail()
{
	level endon("training_s1_end_enter_jeep");
	common_scripts\utility::flag_wait("flag_tour_jeep_board_fail");
	setdvar("ui_deadquote",&"RECOVERY_OBJECTIVE_FAIL_JEEP_BOARD");
	maps\_utility::missionfailedwrapper();
}

//Function Number: 65
training_s1_tour_jeep_board_warn()
{
	level endon("training_s1_end_enter_jeep");
	if(common_scripts\utility::flag_exist("flag_tour_jeep_board_warn"))
	{
		for(;;)
		{
			common_scripts\utility::flag_wait("flag_tour_jeep_board_warn");
			level.player.showhint = 1;
			thread maps\_utility::display_hint("jeep_warning_prompt");
			common_scripts\utility::flag_waitopen("flag_tour_jeep_board_warn");
			level.player.showhint = 0;
		}
	}
}

//Function Number: 66
training_s1_setup_gideon()
{
	common_scripts\utility::flag_wait("training_s1_end_setup_gideon");
	if(!isdefined(level.gideon))
	{
		var_00 = getent("gideon_kva","targetname");
		var_00 thread maps\_utility::add_spawn_function(::maps\recovery::setup_gideon);
		var_00 maps\_utility::spawn_ai(1);
	}

	level.gideon.name = " ";
	level.gideon.ignoreall = 1;
	level.gideon.pacifist = 1;
	level.gideon maps\_utility::forceuseweapon("iw5_titan45_sp","primary");
	level.gideon thread maps\_utility::set_battlechatter(0);
	var_01 = common_scripts\utility::getstruct("training_s1_ending_anim_origin","targetname");
	var_01 maps\_anim::anim_first_frame_solo(level.gideon,"training_s1_gideon_end");
	var_01 maps\_anim::anim_single_solo(level.gideon,"training_s1_gideon_end");
	common_scripts\utility::flag_set("training_s1_allow_end_enter_jeep");
	common_scripts\utility::flag_set("flag_obj_rescue1_allow_end_enter_jeep");
	var_01 thread maps\_anim::anim_loop_solo(level.gideon,"training_s1_gideon_end_idle","stop_loop_gideon");
	level.gideon.name = "Gideon";
	common_scripts\utility::flag_wait("training_s1_end_enter_jeep");
	var_01 notify("stop_loop_gideon");
	var_01 maps\_anim::anim_single_solo(level.gideon,"training_s1_gideon_end_enter");
	level.gideon linkto(level.cart,"tag_body");
	level.cart thread maps\_anim::anim_loop_solo(level.gideon,"rec_tour_ride_a_pt1","stop_loop_gideon","tag_body");
	common_scripts\utility::flag_wait("start_tour_ride");
	level.cart notify("stop_loop_gideon");
	level.gideon.ignoreall = 0;
	level.gideon.pacifist = 0;
	level.gideon maps\_utility::forceuseweapon("iw5_bal27_sp_silencer01_variablereddot","primary");
}

//Function Number: 67
training_s1_setup_president()
{
	common_scripts\utility::flag_wait("training_s1_end_setup_president");
	if(!isalive(level.president))
	{
		var_00 = getent("training_s1_president_spawner","targetname");
		if(var_00.count == 0)
		{
			var_00.count++;
		}

		level.president = var_00 maps\_utility::spawn_ai(1);
		level.president maps\_president::set_president_anims();
		level.president thread maps\recovery::set_up_president("training_end_s1_president_start_point","tour_exo_hangar");
	}

	var_01 = common_scripts\utility::getstruct("training_s1_ending_anim_origin","targetname");
	var_01 = var_01 common_scripts\utility::spawn_tag_origin();
	var_01 maps\_anim::anim_first_frame_solo(level.president,"training_s1_president_end");
	var_01 maps\_anim::anim_single_solo(level.president,"training_s1_president_end");
	var_01 thread maps\_anim::anim_loop_solo(level.president,"training_s1_president_end_idle","stop_loop");
	common_scripts\utility::flag_wait("start_tour_ride");
	var_01 notify("stop_loop");
	var_01 delete();
	level.president maps\_utility::stop_magic_bullet_shield();
	level.president delete();
}

//Function Number: 68
training_s1_setup_driver()
{
	common_scripts\utility::flag_wait("training_s1_end_setup_driver");
	if(!isalive(level.driver))
	{
		level.driver = getent("tour_driver","targetname") maps\_utility::spawn_ai(1);
		level.driver maps\_utility::gun_remove();
		level.driver.animname = "driver";
		level.driver.pacifist = 1;
	}

	var_00 = common_scripts\utility::getstruct("training_s1_ending_anim_origin","targetname");
	var_00 maps\_anim::anim_first_frame_solo(level.driver,"training_s1_driver_end");
	var_00 maps\_anim::anim_single_solo(level.driver,"training_s1_driver_end");
	var_00 thread maps\_anim::anim_loop_solo(level.driver,"training_s1_driver_end_idle","stop_loop_driver");
	common_scripts\utility::flag_wait("training_s1_end_enter_jeep");
	var_00 notify("stop_loop_driver");
	var_00 maps\_anim::anim_single_solo(level.driver,"training_s1_driver_end_enter");
	level.driver linkto(level.cart,"tag_body");
	level.cart thread maps\_anim::anim_loop_solo(level.driver,"rec_tour_ride_a_pt1","stop_loop_driver","tag_body");
	common_scripts\utility::flag_wait("start_tour_ride");
	level.cart notify("stop_loop_driver");
}

//Function Number: 69
training_s1_handle_tour_cart()
{
	if(!common_scripts\utility::flag("flag_obj_rescue1_allow_end_enter_jeep_clear"))
	{
		common_scripts\utility::flag_wait("training_s1_end_setup_cart");
	}

	var_00 = getent("tour_cart","targetname") maps\_utility::spawn_vehicle();
	var_00.animname = "jeep";
	var_00 hide();
	var_01 = maps\_utility::spawn_anim_model("jeep");
	level.cart = var_01;
	if(!common_scripts\utility::flag("flag_obj_rescue1_allow_end_enter_jeep_clear"))
	{
		common_scripts\utility::flag_wait("start_tour_ride");
	}

	var_00 show();
	level.cart = var_00;
	var_02 = var_01.origin;
	var_03 = var_01.angles;
	level.cart vehicle_teleport(var_02,var_03);
	var_01 delete();
}

//Function Number: 70
training_s1_setup_cart()
{
	common_scripts\utility::flag_wait("training_s1_end_setup_cart");
	var_00 = common_scripts\utility::getstruct("training_s1_ending_anim_origin","targetname");
	var_00 maps\_anim::anim_first_frame_solo(level.cart,"training_s1_vehicle_tour_end");
	var_00 maps\_anim::anim_single_solo(level.cart,"training_s1_vehicle_tour_end");
	var_00 thread maps\_anim::anim_loop_solo(level.cart,"training_s1_vehicle_tour_end_idle","stop_loop_cart");
	common_scripts\utility::flag_wait("training_s1_end_enter_jeep");
	var_00 notify("stop_loop_cart");
	var_00 maps\_anim::anim_single_solo(level.cart,"training_s1_vehicle_tour_end_enter");
}

//Function Number: 71
training_s1_setup_irons()
{
	common_scripts\utility::flag_wait("training_s1_end_setup_irons");
	if(!isalive(level.irons))
	{
		var_00 = getent("training_irons_spawner","targetname");
		level.irons = var_00 maps\_utility::spawn_ai(1);
		level.irons.animname = "irons";
	}

	var_01 = common_scripts\utility::getstruct("training_s1_ending_anim_origin","targetname");
	var_01 maps\_anim::anim_first_frame_solo(level.irons,"training_s1_irons_end");
	var_01 maps\_anim::anim_single_solo(level.irons,"training_s1_irons_end");
	var_01 thread maps\_anim::anim_loop_solo(level.irons,"training_s1_irons_end_idle","stop_loop_irons");
	common_scripts\utility::flag_wait("start_tour_ride");
	var_01 notify("stop_loop_irons");
}

//Function Number: 72
training_unlock_doors()
{
	wait(14);
	common_scripts\utility::flag_set("training_s1_end");
}

//Function Number: 73
training_s1_remove_player_weapons()
{
	common_scripts\utility::flag_wait("training_remove_player_weapons");
	level.player takeallweapons();
}

//Function Number: 74
setup_tour()
{
	thread tour_ride();
	thread player_speed_manager();
	thread atlas_base_weapon_manager();
	level.ready_room_things = [];
	thread ready_room_player();
	thread ready_room_gideon();
	thread ready_room_elevator_right();
	thread ready_room_assault_rifle();
	thread ready_room_sniper_rifle();
	thread tour_shooting_range();
	thread tour_shooting_range_screen_toggle();
	thread tour_shooting_range_interact_manager();
	thread tour_grenade_range_interact_manager();
	thread tour_grenade_range_screen_toggle();
	thread tour_drone_range_interact_manager();
	thread tour_variable_grenade_refill_manager();
	thread tour_jets();
	thread tour_boost_jumpers_initial();
	thread tour_doors();
	thread tour_fans();
	if(level.nextgen)
	{
		thread tour_windsock();
	}

	thread tour_lander_01();
	thread tour_drones_advanced_warfare();
	thread tour_brave_warrior_01();
	thread tour_brave_warrior_03();
	thread tour_titan_01();
	thread tour_titan_02();
	thread tour_gideon_movement_manager_exo_spar();
	thread tour_exo_observe();
	thread tour_exo_push();
	thread tour_exo_climb();
	thread tour_exo_spar();
	thread tour_exo_boost();
	thread tour_exo_shield();
	thread tour_exo_demo_gideon();
	thread tour_exo_repair_player();
	thread tour_exo_repair_desk();
	thread tour_exo_repair_tech_1();
	thread tour_exo_repair_tech_2();
	thread tour_ready_room_techs();
	thread tour_grenade_range_gideon();
	thread tour_ambient_00();
	thread tour_ambient_01();
	thread tour_ambient_02();
	thread tour_cleanup_01();
}

//Function Number: 75
tour_ride()
{
	common_scripts\utility::flag_wait("start_tour_ride");
	thread tour_ride_player();
	thread tour_ride_gideon();
	thread tour_ride_passengers();
	thread maps\recovery_utility::play_rumble_walker_tank();
	common_scripts\utility::flag_set("tour_ride");
	thread tour_spawn_vtol();
	thread tour_ambient_people();
	thread tour_military_ambient_people();
	thread tour_hangar_ambient_people();
	var_00 = getent("tour_vehicle_1","targetname");
	var_01 = var_00 maps\_vehicle::spawn_vehicle_and_gopath();
	soundscripts\_snd::snd_message("rec_tour_vehicle_1_start",var_01);
	maps\_vehicle::gopath(level.cart);
	if(level.currentgen)
	{
		var_02 = common_scripts\utility::getfx("cg_fx_light_jeep_runner");
		playfxontag(var_02,level.cart,"TAG_ORIGIN");
	}

	thread tour_ride_look_anims();
	thread maps\recovery_utility::play_camera_shake_tour_ride();
	common_scripts\utility::flag_wait("dropoff_initiated");
	level.player takeallweapons();
	common_scripts\utility::flag_set("tour_end");
	if(level.currentgen)
	{
		common_scripts\utility::flag_set("flag_tff_trans_tour_ride_to_tour_exo");
	}

	common_scripts\utility::flag_set("flag_gideon_use_custom_anim_set");
	level.cart maps\_anim::anim_single_solo(level.cart,"rec_tour_ride_c_pt1_jeep");
	common_scripts\utility::flag_set("flag_obj_base_start");
	level.cart waittill("reached_end_node");
	wait(1);
	level.cart delete();
}

//Function Number: 76
tour_ride_look_anims()
{
	var_00 = [level.driver,level.irons];
	common_scripts\utility::flag_wait("jeep_ride_look_left");
	level.driver thread maps\recovery_utility::lerp_anim_weight_on_actor_over_time(%rec_tour_ride_a_look_l_driver,1.5,0,1);
	level.driver thread maps\recovery_utility::lerp_anim_weight_on_actor_over_time(%rec_tour_ride_a_look_idle_driver,1.5,1,0);
	level.irons thread maps\recovery_utility::lerp_anim_weight_on_actor_over_time(%rec_tour_ride_a_look_l_irons,1.5,0,1);
	level.irons thread maps\recovery_utility::lerp_anim_weight_on_actor_over_time(%rec_tour_ride_a_look_idle_irons,1.5,1,0);
	common_scripts\utility::flag_waitopen("jeep_ride_look_left");
	level.driver thread maps\recovery_utility::lerp_anim_weight_on_actor_over_time(%rec_tour_ride_a_look_l_driver,1.5,1,0);
	level.driver thread maps\recovery_utility::lerp_anim_weight_on_actor_over_time(%rec_tour_ride_a_look_idle_driver,1.5,0,1);
	level.irons thread maps\recovery_utility::lerp_anim_weight_on_actor_over_time(%rec_tour_ride_a_look_l_irons,1.5,1,0);
	level.irons thread maps\recovery_utility::lerp_anim_weight_on_actor_over_time(%rec_tour_ride_a_look_idle_irons,1.5,0,1);
	common_scripts\utility::flag_wait("jeep_ride_look_right");
	level.driver thread maps\recovery_utility::lerp_anim_weight_on_actor_over_time(%rec_tour_ride_a_look_r_driver,1.5,0,1);
	level.driver thread maps\recovery_utility::lerp_anim_weight_on_actor_over_time(%rec_tour_ride_a_look_idle_driver,1.5,1,0);
	common_scripts\utility::flag_waitopen("jeep_ride_look_right");
	level.driver thread maps\recovery_utility::lerp_anim_weight_on_actor_over_time(%rec_tour_ride_a_look_r_driver,1.5,1,0);
	level.driver thread maps\recovery_utility::lerp_anim_weight_on_actor_over_time(%rec_tour_ride_a_look_idle_driver,1.5,0,1);
	common_scripts\utility::flag_wait("jeep_ride_look_left");
	level.driver thread maps\recovery_utility::lerp_anim_weight_on_actor_over_time(%rec_tour_ride_a_look_l_driver,1.5,0,1);
	level.driver thread maps\recovery_utility::lerp_anim_weight_on_actor_over_time(%rec_tour_ride_a_look_idle_driver,1.5,1,0);
	common_scripts\utility::flag_waitopen("jeep_ride_look_left");
	level.driver thread maps\recovery_utility::lerp_anim_weight_on_actor_over_time(%rec_tour_ride_a_look_l_driver,1.5,1,0);
	level.driver thread maps\recovery_utility::lerp_anim_weight_on_actor_over_time(%rec_tour_ride_a_look_idle_driver,1.5,0,1);
	common_scripts\utility::flag_wait("jeep_ride_look_left");
	level.driver thread maps\recovery_utility::lerp_anim_weight_on_actor_over_time(%rec_tour_ride_b_look_l_driver,1.5,0,1);
	level.driver thread maps\recovery_utility::lerp_anim_weight_on_actor_over_time(%rec_tour_ride_b_look_idle_driver,1.5,1,0);
	common_scripts\utility::flag_waitopen("jeep_ride_look_left");
	level.driver thread maps\recovery_utility::lerp_anim_weight_on_actor_over_time(%rec_tour_ride_b_look_l_driver,1.5,1,0);
	level.driver thread maps\recovery_utility::lerp_anim_weight_on_actor_over_time(%rec_tour_ride_b_look_idle_driver,1.5,0,1);
	common_scripts\utility::flag_wait("jeep_ride_look_left");
	level.driver thread maps\recovery_utility::lerp_anim_weight_on_actor_over_time(%rec_tour_ride_b_look_l_driver,1.5,0,1);
	level.driver thread maps\recovery_utility::lerp_anim_weight_on_actor_over_time(%rec_tour_ride_b_look_idle_driver,1.5,1,0);
	level.irons thread maps\recovery_utility::lerp_anim_weight_on_actor_over_time(%rec_tour_ride_b_look_l_irons,1.5,0,1);
	level.irons thread maps\recovery_utility::lerp_anim_weight_on_actor_over_time(%rec_tour_ride_b_look_idle_irons,1.5,1,0);
	wait(3);
	level.driver thread maps\recovery_utility::lerp_anim_weight_on_actor_over_time(%rec_tour_ride_b_look_l_driver,1.5,1,0);
	level.driver thread maps\recovery_utility::lerp_anim_weight_on_actor_over_time(%rec_tour_ride_b_look_idle_driver,1.5,0,1);
	level.irons thread maps\recovery_utility::lerp_anim_weight_on_actor_over_time(%rec_tour_ride_b_look_l_irons,1.5,1,0);
	level.irons thread maps\recovery_utility::lerp_anim_weight_on_actor_over_time(%rec_tour_ride_b_look_idle_irons,1.5,0,1);
}

//Function Number: 77
rec_drive_lookat_trigger_think(param_00)
{
	var_01 = getent(self.target,"targetname");
	var_02 = self.radius;
	while(distancesquared(self.origin,param_00.origin) > var_02 * var_02)
	{
		wait(0.1);
	}

	param_00 setlookatentity(var_01);
	wait(1);
	while(distancesquared(self.origin,param_00.origin) < var_02 * var_02)
	{
		wait(0.1);
	}

	param_00 setlookatentity();
}

//Function Number: 78
linerar_lerp(param_00,param_01,param_02)
{
	return param_00 + param_02 * param_01 - param_00;
}

//Function Number: 79
monitor_irons_talk()
{
	level.cart endon("reached_end_node");
	for(;;)
	{
		level waittill("jeep_ride_irons_talk_start");
		level.jeeprideplayerlinktag linkto(level.player_rig,"tag_player",(0,0,0),(0,-20,0));
		make_camera_look_at_talker();
	}
}

//Function Number: 80
monitor_gideon_talk()
{
	level.cart endon("reached_end_node");
	level waittill("jeep_ride_gideon_talk_start");
	level.jeeprideplayerlinktag linkto(level.player_rig,"tag_player",(0,0,0),(0,-60,0));
	make_camera_look_at_talker();
}

//Function Number: 81
make_camera_look_at_talker()
{
	level endon("jeep_ride_irons_talk_stop");
	var_00 = 0.05;
	var_01 = 1;
	while(var_01 > 0)
	{
		level.player unlink();
		level.player playerlinktodelta(level.jeeprideplayerlinktag,"tag_origin",1,level.jeeprideplayerlinktag.r * var_01,level.jeeprideplayerlinktag.l * var_01,level.jeeprideplayerlinktag.t * var_01,level.jeeprideplayerlinktag.b * var_01);
		var_01 = var_01 - var_00;
		wait 0.05;
	}

	var_01 = 1;
	level.jeeprideplayerlinktag linkto(level.player_rig,"tag_player",(0,0,0),(0,0,0));
	level.player unlink();
	level.player playerlinktodelta(level.jeeprideplayerlinktag,"tag_origin",1,level.jeeprideplayerlinktag.r * var_01,level.jeeprideplayerlinktag.l * var_01,level.jeeprideplayerlinktag.t * var_01,level.jeeprideplayerlinktag.b * var_01);
}

//Function Number: 82
tour_ride_passengers()
{
	if(!isalive(level.driver))
	{
		level.driver = getent("tour_driver","targetname") maps\_utility::spawn_ai(1);
		level.driver maps\_utility::gun_remove();
		level.driver.animname = "driver";
		level.driver.pacifist = 1;
	}

	level.driver.name = " ";
	if(!isalive(level.irons))
	{
		var_00 = getent("training_irons_spawner","targetname");
		level.irons = var_00 maps\_utility::spawn_ai(1);
		level.irons.animname = "irons";
	}

	var_01 = [level.driver,level.irons];
	level.driver linkto(level.cart,"tag_body");
	level.irons linkto(level.cart,"tag_body");
	level.irons.no_ai = 1;
	level.cart setanimknob(%rec_tour_ride_a_pt1_jeep,1,0,1);
	level.cart thread maps\_anim::anim_loop(var_01,"rec_tour_ride_a_pt1",undefined,"tag_body");
	common_scripts\utility::flag_wait("jeep_ride_anim_a");
	common_scripts\utility::flag_set("flag_tour_start_dialog2");
	level.cart notify("stop_loop");
	level.cart setanimknob(%rec_tour_ride_a_pt2_jeep,1,0,1);
	level.cart maps\_anim::anim_single(var_01,"rec_tour_ride_a_pt2","tag_body");
	level.cart setanimknob(%rec_tour_ride_b_pt1_jeep,1,0,1);
	level.cart thread maps\_anim::anim_loop(var_01,"rec_tour_ride_b_pt1",undefined,"tag_body");
	common_scripts\utility::flag_wait("jeep_ride_anim_b");
	common_scripts\utility::flag_set("flag_tour_start_dialog3");
	level.cart notify("stop_loop");
	level.cart setanimknob(%rec_tour_ride_b_pt2_jeep,1,0,1);
	level.cart maps\_anim::anim_single(var_01,"rec_tour_ride_b_pt2","tag_body");
	level.cart setanimknob(%rec_tour_ride_b_pt1_jeep,1,0,1);
	level.cart thread maps\_anim::anim_loop(var_01,"rec_tour_ride_b_pt1",undefined,"tag_body");
	common_scripts\utility::flag_wait("dropoff_initiated");
	common_scripts\utility::flag_set("flag_tour_start_dialog4");
	level.cart notify("stop_loop");
	level.cart maps\_anim::anim_single(var_01,"rec_tour_ride_c_pt1","tag_body",undefined,undefined,1);
	level.cart thread maps\_anim::anim_loop(var_01,"rec_tour_ride_c_pt2",undefined,"tag_body");
	level.cart waittill("reached_end_node");
	level.cart notify("stop_loop");
	level.driver unlink();
	level.driver delete();
	level.irons unlink();
	level.irons delete();
}

//Function Number: 83
tour_ride_gideon()
{
	if(!isdefined(level.gideon))
	{
		var_00 = getent("gideon","targetname");
		var_00 thread maps\_utility::add_spawn_function(::maps\recovery::setup_gideon);
		var_00 maps\_utility::spawn_ai(1);
		level.gideon forceteleport(level.player.origin,level.player.angles,99999);
		level.gideon.script_pushable = 0;
	}

	level.gideon maps\_utility::gun_remove();
	level.gideon linkto(level.cart,"tag_body");
	level.cart thread maps\_anim::anim_loop_solo(level.gideon,"rec_tour_ride_a_pt1","stop_loop_gideon","tag_body");
	wait(10);
	level notify("jeep_ride_gideon_talk_start");
	wait(1);
	common_scripts\utility::flag_set("tour_ride_gideon_pcap");
	level.cart notify("stop_loop_gideon");
	level.cart maps\_anim::anim_single_solo(level.gideon,"rec_tour_ride_gideon_dialogue_gideon","tag_body");
	level.cart thread maps\_anim::anim_loop_solo(level.gideon,"rec_tour_ride_a_pt1","stop_loop_gideon","tag_body");
	common_scripts\utility::flag_wait("jeep_ride_anim_a");
	level.cart notify("stop_loop_gideon");
	level.cart maps\_anim::anim_single_solo(level.gideon,"rec_tour_ride_a_pt2","tag_body");
	level.cart thread maps\_anim::anim_loop_solo(level.gideon,"rec_tour_ride_b_pt1","stop_loop_gideon","tag_body");
	common_scripts\utility::flag_wait("jeep_ride_anim_b");
	level.cart notify("stop_loop_gideon");
	level.cart maps\_anim::anim_single_solo(level.gideon,"rec_tour_ride_b_pt2","tag_body");
	level.cart thread maps\_anim::anim_loop_solo(level.gideon,"rec_tour_ride_b_pt1","stop_loop_gideon","tag_body");
	common_scripts\utility::flag_wait("dropoff_initiated");
	level.cart notify("stop_loop_gideon");
	level.gideon unlink();
	level.cart maps\_anim::anim_single_solo(level.gideon,"rec_tour_ride_c_pt1","tag_body",undefined,undefined);
}

//Function Number: 84
tour_ride_player()
{
	if(!isdefined(level.player_rig))
	{
		level.player_rig = maps\_utility::spawn_anim_model("player_rig");
	}

	var_00 = level.player_rig;
	level.jeeprideplayerarms = var_00;
	level.player maps\_shg_utility::setup_player_for_scene();
	var_01 = 0.5;
	level.jeeprideplayerlinktag = var_00 common_scripts\utility::spawn_tag_origin();
	thread monitor_irons_talk();
	thread monitor_gideon_talk();
	level.jeeprideplayerlinktag linkto(var_00,"tag_player",(0,0,0),(0,0,0));
	level.jeeprideplayerlinktag.r = 60;
	level.jeeprideplayerlinktag.l = 60;
	level.jeeprideplayerlinktag.t = 30;
	level.jeeprideplayerlinktag.b = 15;
	level.player playerlinktodelta(level.jeeprideplayerlinktag,"tag_origin",1,level.jeeprideplayerlinktag.r,level.jeeprideplayerlinktag.l,level.jeeprideplayerlinktag.t,level.jeeprideplayerlinktag.b);
	var_00 linkto(level.cart,"tag_body");
	level.player enableslowaim(0.6,0.4);
	level.cart thread maps\_anim::anim_loop_solo(var_00,"rec_tour_ride_a_pt1",undefined,"tag_body");
	thread maps\recovery_utility::play_rumble_jeep_ride();
	level.player lerpfov(57.5,5);
	common_scripts\utility::flag_wait("jeep_ride_anim_a");
	level.cart notify("stop_loop");
	level.cart thread maps\_anim::anim_loop_solo(var_00,"rec_tour_ride_b_pt1",undefined,"tag_body");
	common_scripts\utility::flag_wait("jeep_ride_anim_b");
	level.cart notify("stop_loop");
	level.cart thread maps\_anim::anim_loop_solo(var_00,"rec_tour_ride_b_pt1",undefined,"tag_body");
	common_scripts\utility::flag_wait("dropoff_initiated");
	level.cart notify("stop_loop");
	var_00 unlink();
	level.player lerpviewangleclamp(2,0.5,0.5,20,20,20,20);
	level.player common_scripts\utility::delaycall(11,::lerpfov,65,3);
	maps\_utility::delaythread(16,::common_scripts\utility::flag_set,"dropoff_complete");
	level.player common_scripts\utility::delaycall(2,::springcamenabled,1,4.2,2.6);
	level.cart maps\_anim::anim_single_solo(var_00,"rec_tour_ride_c_pt1","tag_body");
	level.player maps\_shg_utility::setup_player_for_gameplay();
	level.player unlink();
	var_00 hide();
	level.player disableslowaim();
	level.player disableoffhandweapons();
	level.player disableoffhandsecondaryweapons();
	common_scripts\utility::flag_set("flag_vo_exo_room_01");
	common_scripts\utility::flag_set("flag_disable_exo");
	level.player allowfire(0);
	level.player allowads(0);
	level.player allowmelee(0);
	level.player allowsprint(0);
	thread maps\_utility::autosave_now();
}

//Function Number: 85
tour_gideon_movement_manager_exo_spar()
{
	common_scripts\utility::flag_wait("arm_swapped");
	common_scripts\utility::flag_wait("tour_yellow_door_01");
	level.gideon maps\_utility::set_goalradius(32);
	maps\_utility::activate_trigger_with_targetname("gideon_move_to_exo_spar");
	wait 0.05;
	level.gideon maps\_utility::disable_ai_color();
	level.gideon waittill("goal");
	var_00 = getent("tourspawner_exo_spar_01","targetname") common_scripts\utility::spawn_tag_origin();
	level.gideon setlookatentity(var_00);
	common_scripts\utility::flag_set("flag_vo_exo_room_05");
	common_scripts\utility::flag_wait_or_timeout("shooting_range_stairs_down",6);
	level.gideon setlookatentity();
	var_00 delete();
	if(!common_scripts\utility::flag("shooting_range_stairs_down"))
	{
		level.gideon maps\_utility::enable_ai_color();
	}
}

//Function Number: 86
tour_exo_observe()
{
	common_scripts\utility::flag_wait("tour_exo_hangar");
	var_00 = getent("org_anim_exo_observe","targetname");
	var_01 = getent("tourspawner_exo_observe_01","targetname") maps\_utility::spawn_ai(1);
	var_02 = getent("tourspawner_exo_observe_02","targetname") maps\_utility::spawn_ai(1);
	var_03 = getent("tourspawner_exo_observe_03","targetname") maps\_utility::spawn_ai(1);
	var_04 = getent("tourspawner_exo_observe_04","targetname") maps\_utility::spawn_ai(1);
	var_01.animname = "exo_observer_01";
	var_02.animname = "exo_observer_02";
	var_03.animname = "exo_observer_03";
	var_04.animname = "exo_observer_04";
	var_05 = [var_01,var_02,var_03,var_04];
	var_00 thread maps\_anim::anim_loop(var_05,"rec_atlas_exo_observe_idle");
	var_06 = getent("observer_spawner_c","targetname");
	var_07 = getent("observer_spawner_f","targetname");
	var_08 = getentarray("exo_observer","targetname");
	var_09 = [];
	foreach(var_0B in var_08)
	{
		var_06.count = 1;
		var_07.count = 1;
		if(common_scripts\utility::cointoss())
		{
			var_0C = var_06 maps\_utility::spawn_ai(1);
		}
		else
		{
			var_0C = var_07 maps\_utility::spawn_ai(1);
		}

		var_0C setmodel(var_0B.model);
		var_09[var_09.size] = var_0C;
		var_0B maps\_utility::delaythread(randomfloat(2),::maps\_shg_design_tools::anim_simple,var_0C,var_0B.animation);
		if(var_0B.animation == "rec_atlas_push_lab_idle_01" || var_0B.animation == "rec_atlas_push_lab_idle_02" || var_0B.animation == "rec_atlas_push_lab_idle_03")
		{
			var_0C attach("dem_tablet_pc_01","tag_weapon_left");
		}

		wait 0.05;
	}

	var_00 = getent("org_anim_exo_arm_01","targetname");
	level.exo_climb_tech_01 = getent("tourspawner_exo_climb_tech_01","targetname") maps\_utility::spawn_ai(1);
	level.exo_climb_tech_02 = getent("tourspawner_exo_climb_tech_02","targetname") maps\_utility::spawn_ai(1);
	level.exo_climb_tech_03 = getent("tourspawner_exo_climb_tech_03","targetname") maps\_utility::spawn_ai(1);
	level.exo_climb_tech_01.animname = "exo_climb_tech_01";
	level.exo_climb_tech_02.animname = "exo_climb_tech_02";
	level.exo_climb_tech_03.animname = "exo_climb_tech_03";
	var_0E = level.exo_climb_tech_01 common_scripts\utility::spawn_tag_origin();
	var_0E thread maps\_shg_design_tools::anim_simple(level.exo_climb_tech_01,level.exo_climb_tech_01.animation);
	level.exo_climb_tech_02 thread maps\_shg_design_tools::anim_simple(level.exo_climb_tech_02,level.exo_climb_tech_02.animation);
	level.exo_climb_tech_03 maps\_utility::delaythread(2,::maps\_shg_design_tools::anim_simple,level.exo_climb_tech_03,level.exo_climb_tech_03.animation);
	level.exo_climb_tech_02 attach("dem_tablet_pc_01","tag_weapon_left");
	level.exo_climb_tech_03 attach("dem_tablet_pc_01","tag_weapon_left");
	common_scripts\utility::flag_wait("flag_obj_firing_range_pre");
	level.exo_climb_tech_01 delete();
	level.exo_climb_tech_02 delete();
	level.exo_climb_tech_03 delete();
	common_scripts\utility::array_call(var_09,::delete);
	var_0E delete();
	foreach(var_10 in var_05)
	{
		var_10 delete();
	}
}

//Function Number: 87
tour_exo_push()
{
	common_scripts\utility::flag_wait("tour_exo_hangar");
	thread tour_exo_push_motion_tracker("01");
	thread tour_exo_push_motion_tracker("02");
	var_00 = getent("org_anim_exo_push","targetname");
	var_01 = getent("tourspawner_exo_push_01","targetname") maps\_utility::spawn_ai(1);
	var_02 = getent("tourspawner_exo_push_02","targetname") maps\_utility::spawn_ai(1);
	var_03 = getent("exo_push_crane_01","targetname");
	var_04 = getent("exo_push_crane_02","targetname");
	var_05 = getent("exo_push_sled_01","targetname");
	var_06 = getent("exo_push_sled_02","targetname");
	var_01.animname = "pusher_1";
	var_02.animname = "pusher_2";
	var_03.animname = "exo_push_crane_01";
	var_04.animname = "exo_push_crane_02";
	var_05.animname = "exo_push_sled_01";
	var_06.animname = "exo_push_sled_02";
	var_03 maps\_utility::assign_animtree();
	var_04 maps\_utility::assign_animtree();
	var_05 maps\_utility::assign_animtree();
	var_06 maps\_utility::assign_animtree();
	var_07 = [var_01,var_02,var_03,var_04,var_05,var_06];
	var_00 thread maps\_anim::anim_loop(var_07,"rec_atlas_push_idle");
	common_scripts\utility::flag_wait("flag_obj_firing_range_pre");
	common_scripts\utility::array_add(var_07,var_00);
	foreach(var_09 in var_07)
	{
		var_09 delete();
	}
}

//Function Number: 88
tour_exo_push_motion_tracker(param_00)
{
	var_01 = getentarray("push_motion_tracker_" + param_00,"targetname");
	var_02 = 1;
	var_03 = 1;
	var_04 = 400;
	if(param_00 == "01")
	{
		var_02 = 5.7;
		var_03 = 5;
		var_04 = 400;
	}

	if(param_00 == "02")
	{
		var_02 = 8.9;
		var_03 = 5;
		var_04 = 400;
	}

	while(!common_scripts\utility::flag("flag_obj_firing_range_pre"))
	{
		level waittill("initiate_push_" + param_00);
		foreach(var_06 in var_01)
		{
			var_06 moveto(var_06.origin - (var_04,0,0),var_02,0.4,0.4);
		}

		wait(var_02);
		wait(18.5);
		foreach(var_06 in var_01)
		{
			var_06 moveto(var_06.origin + (var_04,0,0),var_03,0.4,0.4);
		}

		wait(var_03);
	}

	common_scripts\utility::flag_wait("flag_obj_firing_range_pre");
	foreach(var_06 in var_01)
	{
		var_06 delete();
	}
}

//Function Number: 89
tour_exo_climb()
{
	var_00 = getent("org_anim_exo_climb","targetname");
	var_01 = getent("tourspawner_exo_climb","targetname") maps\_utility::spawn_ai(1);
	var_01.animname = "climber_1";
	var_00 thread maps\_anim::anim_first_frame_solo(var_01,"rec_atlas_climb_guy02");
	common_scripts\utility::flag_wait("tour_solid_door_01");
	common_scripts\utility::flag_wait("looking_at_exo_climb");
	var_00 maps\_anim::anim_single_solo(var_01,"rec_atlas_climb_guy02");
	var_00 thread maps\_anim::anim_loop_solo(var_01,"rec_atlas_climb_idle_guy02");
	common_scripts\utility::flag_wait("arm_swapped");
	common_scripts\utility::flag_wait("tour_yellow_door_01");
	var_00 notify("stop_loop");
	var_00 maps\_anim::anim_single_solo(var_01,"rec_atlas_climb_guy02");
	var_00 thread maps\_anim::anim_loop_solo(var_01,"rec_atlas_climb_idle_guy02");
	common_scripts\utility::flag_wait("flag_obj_firing_range_pre");
	var_00 notify("stop_loop");
	var_01 delete();
	var_00 delete();
}

//Function Number: 90
tour_exo_spar()
{
	common_scripts\utility::flag_wait("tour_exo_hangar");
	var_00 = getent("org_anim_exo_spar_01","targetname");
	var_01 = getent("tourspawner_exo_spar_01","targetname") maps\_utility::spawn_ai(1);
	var_02 = getent("tourspawner_exo_spar_02","targetname") maps\_utility::spawn_ai(1);
	var_03 = getent("tourspawner_exo_spar_03","targetname") maps\_utility::spawn_ai(1);
	var_04 = getent("tourspawner_exo_spar_04","targetname") maps\_utility::spawn_ai(1);
	var_05 = getent("tourspawner_exo_spar_05","targetname") maps\_utility::spawn_ai(1);
	var_01.animname = "wrestler_1";
	var_02.animname = "wrestler_2";
	var_03.animname = "wrestler_3";
	var_04.animname = "wrestler_4";
	var_05.animname = "wrestler_5";
	var_01 maps\_utility::gun_remove();
	var_06 = [var_01,var_02,var_03,var_04,var_05];
	var_07 = "rec_atlas_warmup_idle";
	var_08 = "rec_atlas_wrestling_idle";
	var_00 thread maps\_anim::anim_loop(var_06,var_07);
	var_00 notify("stop_loop");
	common_scripts\utility::flag_wait("arm_swapped");
	common_scripts\utility::flag_wait("tour_yellow_door_01");
	maps\_utility::delaythread(0.05,::maps\_anim::anim_set_time,var_06,var_08,0.18);
	var_00 maps\_anim::anim_single(var_06,var_08);
	var_00 thread maps\_anim::anim_loop(var_06,var_07);
	common_scripts\utility::flag_wait("flag_obj_firing_range_pre");
	foreach(var_0A in var_06)
	{
		var_0A delete();
	}

	var_00 delete();
}

//Function Number: 91
tour_exo_boost()
{
	common_scripts\utility::flag_wait("tour_exo_hangar");
	var_00 = getent("exo_booster_01","targetname") maps\_utility::spawn_ai(1);
	var_01 = getent("exo_booster_02","targetname") maps\_utility::spawn_ai(1);
	var_00.canjumppath = 1;
	var_01.canjumppath = 1;
	var_00 thread tour_exo_boost_lifetime_ccw();
	var_01 thread tour_exo_boost_lifetime_cw();
	common_scripts\utility::flag_wait("flag_obj_firing_range_pre");
	var_00 delete();
	var_01 delete();
}

//Function Number: 92
tour_exo_shield_model_swap()
{
	common_scripts\utility::flag_wait("flag_shield_turret_shooting");
	self setmodel("npc_exo_riot_shield_B");
}

//Function Number: 93
tour_exo_shield()
{
	level endon("flag_obj_firing_range_pre");
	common_scripts\utility::flag_wait("tour_exo_hangar");
	var_00 = getent("org_exo_shield","targetname");
	var_00 thread maps\recovery_utility::delete_on_notify("flag_obj_firing_range_pre");
	var_01 = getent("exo_shield_guy","targetname") maps\_utility::spawn_ai(1,1);
	var_01.team = "axis";
	var_01 maps\_utility::disable_pain();
	var_01 thread maps\recovery_utility::delete_on_notify("flag_obj_firing_range_pre");
	var_01.animname = "shielder_1";
	var_01.no_ai = 1;
	var_01 maps\_utility::gun_remove();
	var_02 = maps\_utility::spawn_anim_model("exo_shield_01");
	var_02.animname = "exo_shield_01";
	var_02 thread maps\recovery_utility::delete_on_notify("flag_obj_firing_range_pre");
	var_03 = getent("exo_room_turret","targetname");
	var_03 makeentitysentient("axis");
	var_03 setmode("sentry");
	var_03 settargetentity(var_02);
	var_03 turretfireenable();
	var_03 thread maps\recovery_utility::delete_on_notify("flag_obj_firing_range_pre");
	var_03 setdefaultdroppitch(0);
	var_03 setsentryowner(level.player);
	var_03 setturretteam("axis");
	var_04 = [var_01,var_02];
	var_00 maps\_anim::anim_first_frame(var_04,"rec_exo_shield_intro");
	common_scripts\utility::flag_wait("exo_shield_start");
	thread tour_exo_shield_turret(var_03);
	var_02 thread tour_exo_shield_model_swap();
	var_00 maps\_anim::anim_single(var_04,"rec_exo_shield_intro");
	var_00 thread maps\_anim::anim_loop(var_04,"rec_exo_shield_idle");
}

//Function Number: 94
tour_exo_shield_turret(param_00)
{
	level endon("flag_obj_firing_range_pre");
	common_scripts\utility::flag_wait("tour_yellow_door_01");
	for(;;)
	{
		if(common_scripts\utility::flag("tour_exo_arm"))
		{
			common_scripts\utility::flag_wait("arm_swapped");
		}

		common_scripts\utility::flag_wait("flag_shield_turret_shooting");
		param_00 startbarrelspin();
		while(common_scripts\utility::flag("flag_shield_turret_shooting"))
		{
			param_00 shootturret();
			wait(0.1);
		}

		common_scripts\utility::flag_waitopen("flag_shield_turret_shooting");
		param_00 stopbarrelspin();
	}
}

//Function Number: 95
tour_exo_boost_lifetime_ccw()
{
	level endon("flag_obj_firing_range_pre");
	for(;;)
	{
		var_00 = getnode("exo_jump_goal_01a","targetname");
		self setgoalpos(var_00.origin);
		self.goalradius = var_00.radius;
		guy_distance_checker(var_00);
		var_00 = getnode("exo_jump_goal_01b","targetname");
		self setgoalpos(var_00.origin);
		self.goalradius = var_00.radius;
		guy_distance_checker(var_00);
		var_00 = getnode("exo_jump_goal_01c","targetname");
		self setgoalpos(var_00.origin);
		self.goalradius = var_00.radius;
		guy_distance_checker(var_00);
		var_00 = getnode("exo_jump_goal_01d","targetname");
		self setgoalpos(var_00.origin);
		self.goalradius = var_00.radius;
		guy_distance_checker(var_00);
	}
}

//Function Number: 96
tour_exo_boost_lifetime_cw()
{
	level endon("flag_obj_firing_range_pre");
	for(;;)
	{
		var_00 = getnode("exo_jump_goal_01a","targetname");
		self setgoalpos(var_00.origin);
		self.goalradius = var_00.radius;
		guy_distance_checker(var_00);
		var_00 = getnode("exo_jump_goal_01d","targetname");
		self setgoalpos(var_00.origin);
		self.goalradius = var_00.radius;
		guy_distance_checker(var_00);
		var_00 = getnode("exo_jump_goal_01c","targetname");
		self setgoalpos(var_00.origin);
		self.goalradius = var_00.radius;
		guy_distance_checker(var_00);
		var_00 = getnode("exo_jump_goal_01b","targetname");
		self setgoalpos(var_00.origin);
		self.goalradius = var_00.radius;
		guy_distance_checker(var_00);
	}
}

//Function Number: 97
guy_distance_checker(param_00)
{
	while(distance(self.origin,param_00.origin) > param_00.radius)
	{
		wait 0.05;
	}
}

//Function Number: 98
tour_exo_demo_gideon()
{
	var_00 = getent("org_anim_exo_demo","targetname");
	common_scripts\utility::flag_wait("gideon_exo_demo");
	level.gideon maps\_utility::disable_ai_color();
	var_00 maps\_anim::anim_reach_solo(level.gideon,"rec_exo_arm_repair_readyroom_gideon_idle_in");
	common_scripts\utility::flag_set("flag_vo_exo_room_03");
	var_00 maps\_anim::anim_single_solo(level.gideon,"rec_exo_arm_repair_readyroom_gideon_idle_in");
	var_00 thread maps\_anim::anim_loop_solo(level.gideon,"rec_exo_arm_repair_readyroom_gideon_idle","gideon_ender");
	common_scripts\utility::flag_wait("tour_exo_arm");
	var_00 notify("gideon_ender");
	level.gideon maps\_utility::enable_ai_color();
	maps\_utility::activate_trigger_with_targetname("gideon_move_to_post_repair");
}

//Function Number: 99
tour_exo_repair_player()
{
	common_scripts\utility::flag_wait("tour_yellow_door_03");
	var_00 = getent("org_anim_exo_arm_01","targetname");
	var_00 thread maps\recovery_utility::delete_on_notify("flag_obj_firing_range_pre");
	common_scripts\utility::flag_wait("player_enters_arm_repair_room");
	common_scripts\utility::flag_set("flag_vo_arm_room_01");
	thread maps\recovery_utility::play_rumble_arm_repair();
	common_scripts\utility::flag_wait("tour_exo_arm");
	common_scripts\utility::flag_set("flag_vo_arm_room_02");
	common_scripts\utility::flag_set("flag_obj_arm_repair_start");
	level.player maps\_shg_utility::setup_player_for_scene();
	var_01 = 0.5;
	var_02 = maps\_utility::spawn_anim_model("player_rig_repair");
	var_02 hide();
	var_00 thread maps\_anim::anim_first_frame_solo(var_02,"rec_exo_arm_repair_vm");
	level.player playerlinktoblend(var_02,"tag_player",var_01);
	level.player common_scripts\utility::delaycall(var_01,::playerlinktodelta,var_02,"tag_player",1,7,7,5,5,1);
	level.player common_scripts\utility::delaycall(var_01 + 0.05,::springcamenabled,1,3.2,1.6);
	var_02 common_scripts\utility::delaycall(var_01,::show);
	thread tour_exo_arm_repair_test_seq(var_02);
	var_00 maps\_anim::anim_single_solo(var_02,"rec_exo_arm_repair_vm");
	var_00 thread maps\_anim::anim_first_frame_solo(var_02,"rec_exo_arm_repair_attempt_01_vm");
	var_00 maps\_anim::anim_single_solo(var_02,"rec_exo_arm_repair_attempt_01_vm");
	common_scripts\utility::flag_wait("arm_repair_attempt_1");
	level.player.arm_repair_attempt = 1;
	level.player.showhint = 1;
	thread maps\_utility::hintdisplayhandler("repair_prompt");
	common_scripts\utility::flag_set("tour_exo_arm_repair_test_seq");
	soundscripts\_snd::snd_message("exo_repair_movement",1);
	wait_for_considerable_left_stick_interact(2);
	common_scripts\utility::flag_clear("tour_exo_arm_repair_test_seq");
	soundscripts\_snd::snd_message("exo_repair_movement_stop");
	level.player.showhint = 0;
	common_scripts\utility::flag_clear("arm_repair_attempt_1");
	common_scripts\utility::flag_set("flag_vo_arm_room_03");
	var_00 maps\_anim::anim_single_solo(var_02,"rec_exo_arm_repair_attempt_02_vm");
	common_scripts\utility::flag_wait("arm_repair_attempt_2");
	level.player.arm_repair_attempt = 2;
	level.player.showhint = 1;
	thread maps\_utility::hintdisplayhandler("repair_prompt");
	common_scripts\utility::flag_set("tour_exo_arm_repair_test_seq");
	soundscripts\_snd::snd_message("exo_repair_movement",2);
	wait_for_considerable_left_stick_interact(2.5);
	common_scripts\utility::flag_clear("tour_exo_arm_repair_test_seq");
	soundscripts\_snd::snd_message("exo_repair_movement_stop");
	level.player.showhint = 0;
	common_scripts\utility::flag_clear("arm_repair_attempt_2");
	common_scripts\utility::flag_set("flag_vo_arm_room_04");
	var_00 maps\_anim::anim_single_solo(var_02,"rec_exo_arm_repair_attempt_03_vm");
	common_scripts\utility::flag_wait("arm_repair_attempt_3");
	level.player.arm_repair_attempt = 3;
	level.player.showhint = 1;
	thread maps\_utility::hintdisplayhandler("repair_prompt");
	level.player.should_reverse_controls = 0;
	common_scripts\utility::flag_set("tour_exo_arm_repair_test_seq");
	soundscripts\_snd::snd_message("exo_repair_movement",3);
	wait_for_considerable_left_stick_interact(3);
	common_scripts\utility::flag_clear("tour_exo_arm_repair_test_seq");
	soundscripts\_snd::snd_message("exo_repair_movement_stop");
	level.player.showhint = 0;
	common_scripts\utility::flag_clear("arm_repair_attempt_3");
	common_scripts\utility::flag_set("flag_vo_arm_room_05");
	common_scripts\utility::flag_set("desk_exit");
	var_00 maps\_anim::anim_single_solo(var_02,"rec_exo_arm_repair_attempt_exit_vm");
	level.player maps\_shg_utility::setup_player_for_gameplay();
	level notify("tour_exo_arm_repair_test_seq_complete");
	level.player springcamdisabled(0);
	level.player unlink();
	var_02 delete();
	level.player allowsprint(0);
	level.player allowmelee(0);
	level.player disableoffhandweapons();
	level.player disableoffhandsecondaryweapons();
	common_scripts\utility::flag_set("arm_swapped");
	maps\recovery_utility::gideon_change_outfit();
	common_scripts\utility::flag_set("flag_obj_arm_repair_complete");
	thread maps\_utility::autosave_now();
}

//Function Number: 100
lerp_weight(param_00,param_01,param_02)
{
	return param_00 + param_01 - param_00 * param_02;
}

//Function Number: 101
tour_exo_arm_repair_test_seq_internal(param_00,param_01)
{
	param_01 = [];
	param_01["anim_center"] = %rec_exo_arm_repair_attempt_response_idle_vm;
	if(level.player.arm_repair_attempt == 1)
	{
		param_01["anim_left"] = %rec_exo_arm_repair_attempt_response_01_l_vm;
		param_01["anim_right"] = %rec_exo_arm_repair_attempt_response_01_r_vm;
		param_01["anim_up"] = %rec_exo_arm_repair_attempt_response_01_u_vm;
		param_01["anim_down"] = %rec_exo_arm_repair_attempt_response_01_d_vm;
	}
	else if(level.player.arm_repair_attempt == 2)
	{
		param_01["anim_left"] = %rec_exo_arm_repair_attempt_response_02_l_vm;
		param_01["anim_right"] = %rec_exo_arm_repair_attempt_response_02_r_vm;
		param_01["anim_up"] = %rec_exo_arm_repair_attempt_response_02_u_vm;
		param_01["anim_down"] = %rec_exo_arm_repair_attempt_response_02_d_vm;
	}
	else if(level.player.arm_repair_attempt == 3)
	{
		param_01["anim_left"] = %rec_exo_arm_repair_attempt_response_03_l_vm;
		param_01["anim_right"] = %rec_exo_arm_repair_attempt_response_03_r_vm;
		param_01["anim_up"] = %rec_exo_arm_repair_attempt_response_03_u_vm;
		param_01["anim_down"] = %rec_exo_arm_repair_attempt_response_03_d_vm;
	}
	else
	{
	}

	var_02 = [];
	var_02["anim_left"] = 0;
	var_02["anim_right"] = 0;
	var_02["anim_up"] = 0;
	var_02["anim_down"] = 0;
	var_02["anim_center"] = 1;
	var_03 = 0.5;
	for(;;)
	{
		if(common_scripts\utility::flag("tour_exo_arm_repair_test_seq"))
		{
			var_04 = level.player getnormalizedmovement();
		}
		else
		{
			if(var_02["anim_center"] > 0.99)
			{
				break;
			}

			var_04 = (0,0,0);
		}

		if(var_04[1] < 0)
		{
			var_02["anim_left"] = lerp_weight(var_02["anim_left"],var_04[1] * -1,var_03);
			var_02["anim_right"] = lerp_weight(var_02["anim_right"],0,var_03);
		}
		else
		{
			var_02["anim_right"] = lerp_weight(var_02["anim_right"],var_04[1],var_03);
			var_02["anim_left"] = lerp_weight(var_02["anim_left"],0,var_03);
		}

		if(var_04[0] < 0)
		{
			var_02["anim_up"] = lerp_weight(var_02["anim_up"],var_04[0] * -1,var_03);
			var_02["anim_down"] = lerp_weight(var_02["anim_down"],0,var_03);
		}
		else
		{
			var_02["anim_down"] = lerp_weight(var_02["anim_down"],var_04[0],var_03);
			var_02["anim_up"] = lerp_weight(var_02["anim_up"],0,var_03);
		}

		var_02["anim_center"] = max(0,1 - var_02["anim_left"] + var_02["anim_right"] + var_02["anim_up"] + var_02["anim_down"]);
		foreach(var_06 in getarraykeys(var_02))
		{
			param_00 setanim(param_01[var_06],var_02[var_06],0.05,1);
		}

		soundscripts\_snd::snd_message("exo_repair_weight_updates",var_02);
		wait 0.05;
	}
}

//Function Number: 102
tour_exo_arm_repair_test_seq(param_00)
{
	level endon("tour_exo_arm_repair_test_seq_complete");
	common_scripts\utility::flag_init("tour_exo_arm_repair_test_seq");
	for(;;)
	{
		common_scripts\utility::flag_wait("tour_exo_arm_repair_test_seq");
		tour_exo_arm_repair_test_seq_internal(param_00);
	}
}

//Function Number: 103
tour_exo_repair_desk()
{
	common_scripts\utility::flag_wait("tour_exo_hangar");
	var_00 = getent("med_desk_01","targetname");
	var_00.animname = "animated_desk";
	var_00 maps\_utility::assign_animtree();
	var_01 = getent("org_anim_exo_arm_01","targetname");
	var_01 = var_01 common_scripts\utility::spawn_tag_origin();
	var_01 thread maps\recovery_utility::delete_on_notify("flag_obj_firing_range_pre");
	var_01 thread maps\_anim::anim_loop_solo(var_00,"rec_exo_arm_repair_start_idle_desk","stop_loop_desk");
	common_scripts\utility::flag_wait("player_approaches_med_desk");
	wait(1);
	var_01 notify("stop_loop_desk");
	var_01 maps\_anim::anim_single_solo(var_00,"rec_exo_arm_repair_chair_unfold_desk");
	common_scripts\utility::flag_set("flag_obj_arm_repair_desk_enabled");
	var_01 thread maps\_anim::anim_loop_solo(var_00,"rec_exo_arm_repair_chair_unfold_idle_desk","stop_loop_desk");
	level waittill("tour_exo_arm_repair_player_looking_at_desk");
	var_01 notify("stop_loop_desk");
	var_01 maps\_anim::anim_single_solo(var_00,"rec_exo_arm_repair_desk");
	var_01 thread maps\_anim::anim_loop_solo(var_00,"rec_exo_arm_repair_idle_desk","stop_loop_desk");
	common_scripts\utility::flag_wait("desk_exit");
	var_01 notify("stop_loop_desk");
	var_01 maps\_anim::anim_single_solo(var_00,"rec_exo_arm_repair_exit_desk");
	var_01 thread maps\_anim::anim_loop_solo(var_00,"rec_exo_arm_repair_chair_unfold_idle_desk");
}

//Function Number: 104
tour_exo_repair_tech_1()
{
	common_scripts\utility::flag_wait("tour_exo_hangar");
	var_00 = getent("org_anim_exo_arm_01","targetname");
	var_00 = var_00 common_scripts\utility::spawn_tag_origin();
	var_00 thread maps\recovery_utility::delete_on_notify("flag_obj_firing_range_pre");
	level.repair_guy_01 = getent("tourspawner_exo_repair_01","targetname") maps\_utility::spawn_ai(1);
	level.repair_guy_01.animname = "repairer_1";
	level.repair_guy_01 thread maps\recovery_utility::delete_on_notify("flag_obj_firing_range_pre");
	var_00 thread maps\_anim::anim_loop_solo(level.repair_guy_01,"rec_exo_arm_repair_standing_idle_guy","stop_loop_tech1");
	common_scripts\utility::flag_wait("flag_vo_arm_room_01");
	var_00 notify("stop_loop_tech1");
	var_00 thread tour_exo_repair_tech_1_branch();
	level waittill("tour_exo_arm_repair_player_looking_at_desk");
	level.repair_guy_01 maps\_utility::anim_stopanimscripted();
	var_00 notify("stop_loop_tech1");
	var_00 maps\_anim::anim_single_solo(level.repair_guy_01,"rec_exo_arm_repair_npc");
	soundscripts\_snd::snd_message("rec_exo_arm_repair_attempt_01_npc");
	var_00 maps\_anim::anim_single_solo(level.repair_guy_01,"rec_exo_arm_repair_attempt_01_npc");
	var_00 thread maps\_anim::anim_loop_solo(level.repair_guy_01,"rec_exo_arm_repair_attempt_response_idle_01_npc","stop_loop_tech1");
	common_scripts\utility::flag_set("arm_repair_attempt_1");
	common_scripts\utility::flag_waitopen("arm_repair_attempt_1");
	var_00 notify("stop_loop_tech1");
	soundscripts\_snd::snd_message("rec_exo_arm_repair_attempt_02_npc");
	var_00 maps\_anim::anim_single_solo(level.repair_guy_01,"rec_exo_arm_repair_attempt_02_npc");
	var_00 thread maps\_anim::anim_loop_solo(level.repair_guy_01,"rec_exo_arm_repair_attempt_response_idle_02_npc","stop_loop_tech1");
	common_scripts\utility::flag_set("arm_repair_attempt_2");
	common_scripts\utility::flag_waitopen("arm_repair_attempt_2");
	var_00 notify("stop_loop_tech1");
	soundscripts\_snd::snd_message("rec_exo_arm_repair_attempt_03_npc");
	var_00 maps\_anim::anim_single_solo(level.repair_guy_01,"rec_exo_arm_repair_attempt_03_npc");
	var_00 thread maps\_anim::anim_loop_solo(level.repair_guy_01,"rec_exo_arm_repair_attempt_response_idle_03_npc","stop_loop_tech1");
	common_scripts\utility::flag_set("arm_repair_attempt_3");
	common_scripts\utility::flag_waitopen("arm_repair_attempt_3");
	var_00 notify("stop_loop_tech1");
	soundscripts\_snd::snd_message("rec_exo_arm_repair_attempt_exit_npc");
	var_00 maps\_anim::anim_single_solo(level.repair_guy_01,"rec_exo_arm_repair_attempt_exit_npc");
	var_00 thread maps\_anim::anim_loop_solo(level.repair_guy_01,"rec_exo_arm_repair_table_idle_guy");
}

//Function Number: 105
tour_exo_repair_tech_1_branch()
{
	level endon("tour_exo_arm");
	maps\_anim::anim_single_solo(level.repair_guy_01,"rec_exo_arm_repair_walk2table_guy");
	thread maps\_anim::anim_loop_solo(level.repair_guy_01,"rec_exo_arm_repair_table_idle_guy","stop_loop_tech1");
}

//Function Number: 106
tour_exo_repair_tech_2()
{
	common_scripts\utility::flag_wait("tour_exo_hangar");
	var_00 = getent("org_anim_exo_arm_01","targetname");
	var_00 = var_00 common_scripts\utility::spawn_tag_origin();
	var_00 thread maps\recovery_utility::delete_on_notify("flag_obj_firing_range_pre");
	level.repair_guy_02 = getent("tourspawner_exo_repair_02","targetname") maps\_utility::spawn_ai(1);
	level.repair_guy_02.animname = "repairer_2";
	level.repair_guy_02 thread maps\recovery_utility::delete_on_notify("flag_obj_firing_range_pre");
	var_00 thread maps\_anim::anim_loop_solo(level.repair_guy_02,"rec_exo_arm_repair_standing_idle_guy","stop_loop_tech2");
	common_scripts\utility::flag_wait("flag_vo_arm_room_01");
	var_00 notify("stop_loop_tech2");
	level.repair_guy_02 common_scripts\utility::delaycall(0.05,::attach,"dem_tablet_pc_01","tag_weapon_left");
	var_00 maps\_anim::anim_single_solo(level.repair_guy_02,"rec_exo_arm_repair_walk2table_guy");
	var_00 thread maps\_anim::anim_loop_solo(level.repair_guy_02,"rec_exo_arm_repair_table_idle_guy");
}

//Function Number: 107
wait_for_considerable_left_stick_interact(param_00)
{
	var_01 = 0;
	for(;;)
	{
		var_02 = level.player getnormalizedmovement();
		if(length(var_02) > 0.1)
		{
			if(!isdefined(level.player.rumble_entity))
			{
				level.player.rumble_entity = maps\_utility::get_rumble_ent("steady_rumble");
			}

			level.player.rumble_entity.intensity = 0.09;
			var_01 = var_01 + 0.05;
		}
		else if(isdefined(level.player.rumble_entity))
		{
			level.player stoprumble("steady_rumble");
			level.player.rumble_entity delete();
		}

		if(var_01 >= param_00)
		{
			level.player stoprumble("steady_rumble");
			level.player.rumble_entity delete();
			break;
		}

		wait 0.05;
	}
}

//Function Number: 108
tour_ready_room_techs()
{
	common_scripts\utility::flag_wait("tour_glass_door_05");
	var_00 = getent("observer_spawner_c","targetname");
	var_01 = getent("observer_spawner_f","targetname");
	var_02 = getentarray("ready_room_guy","targetname");
	var_03 = [];
	foreach(var_05 in var_02)
	{
		var_00.count = 1;
		var_01.count = 1;
		if(common_scripts\utility::cointoss())
		{
			var_06 = var_00 maps\_utility::spawn_ai(1);
		}
		else
		{
			var_06 = var_01 maps\_utility::spawn_ai(1);
		}

		var_06.team = "allies";
		var_06 setmodel(var_05.model);
		var_03[var_03.size] = var_06;
		var_05 thread maps\_shg_design_tools::anim_simple(var_06,var_05.animation);
		if(var_05.animation == "rec_atlas_push_lab_idle_01" || var_05.animation == "rec_atlas_push_lab_idle_02" || var_05.animation == "rec_atlas_push_lab_idle_03")
		{
			var_06 attach("dem_tablet_pc_01","tag_weapon_left");
		}

		wait 0.05;
	}

	common_scripts\utility::flag_wait("training_room_elevator_activated");
	wait(10);
	common_scripts\utility::array_call(var_03,::delete);
}

//Function Number: 109
tour_drones_advanced_warfare()
{
	common_scripts\utility::flag_wait("flag_lander_01");
	wait(1);
	var_00 = getent("ambient_drone_spawner_aw01","targetname");
	var_01 = getent("ambient_drone_spawner_aw02","targetname");
	var_02 = getent("ambient_drone_spawner_aw03","targetname");
	var_03 = var_00 maps\_vehicle::spawn_vehicle_and_gopath();
	var_03 soundscripts\_snd::snd_message("tour_drones_fly_by");
	var_04 = var_01 maps\_vehicle::spawn_vehicle_and_gopath();
	var_05 = var_02 maps\_vehicle::spawn_vehicle_and_gopath();
	var_03 thread tour_ambient_drone_lifetime();
	var_04 thread tour_ambient_drone_lifetime();
	var_05 thread tour_ambient_drone_lifetime();
}

//Function Number: 110
tour_ambient_00()
{
	level endon("training_room_elevator_activated");
	var_00 = getent("ambient_soldier_vo_01","targetname");
	var_01 = getent("ambient_soldier_vo_02","targetname");
	var_02 = getent("ambient_soldier_vo_03","targetname");
	var_03 = getent("ambient_soldier_vo_04","targetname");
	var_04 = getent("ambient_soldier_vo_05","targetname");
	var_05 = getent("ambient_soldier_vo_06","targetname");
	level.ambient_soldier_vo_01 = var_00 maps\_utility::spawn_ai(1);
	wait 0.05;
	level.ambient_soldier_vo_02 = var_01 maps\_utility::spawn_ai(1);
	wait 0.05;
	level.ambient_soldier_vo_03 = var_02 maps\_utility::spawn_ai(1);
	wait 0.05;
	level.ambient_soldier_vo_04 = var_03 maps\_utility::spawn_ai(1);
	wait 0.05;
	level.ambient_soldier_vo_05 = var_04 maps\_utility::spawn_ai(1);
	wait 0.05;
	level.ambient_soldier_vo_06 = var_05 maps\_utility::spawn_ai(1);
	level.ambient_soldier_vo_01.animname = "ambient_soldier_vo_01";
	level.ambient_soldier_vo_02.animname = "ambient_soldier_vo_02";
	level.ambient_soldier_vo_03.animname = "ambient_soldier_vo_03";
	level.ambient_soldier_vo_04.animname = "ambient_soldier_vo_04";
	level.ambient_soldier_vo_05.animname = "ambient_soldier_vo_05";
	level.ambient_soldier_vo_06.animname = "ambient_soldier_vo_06";
	level.ambient_soldier_vo_01 thread maps\_shg_design_tools::anim_simple(level.ambient_soldier_vo_01,level.ambient_soldier_vo_01.animation);
	level.ambient_soldier_vo_02 thread maps\_shg_design_tools::anim_simple(level.ambient_soldier_vo_02,level.ambient_soldier_vo_02.animation);
	level.ambient_soldier_vo_03 thread maps\_shg_design_tools::anim_simple(level.ambient_soldier_vo_03,level.ambient_soldier_vo_03.animation);
	level.ambient_soldier_vo_04 thread maps\_shg_design_tools::anim_simple(level.ambient_soldier_vo_04,level.ambient_soldier_vo_04.animation);
	level.ambient_soldier_vo_05 thread maps\_shg_design_tools::anim_simple(level.ambient_soldier_vo_05,level.ambient_soldier_vo_05.animation);
	level.ambient_soldier_vo_06 thread maps\_shg_design_tools::anim_simple(level.ambient_soldier_vo_06,level.ambient_soldier_vo_06.animation);
	level.ambient_soldier_vo_01 thread maps\recovery_utility::delete_on_notify("training_room_elevator_activated");
	level.ambient_soldier_vo_02 thread maps\recovery_utility::delete_on_notify("training_room_elevator_activated");
	level.ambient_soldier_vo_03 thread maps\recovery_utility::delete_on_notify("training_room_elevator_activated");
	level.ambient_soldier_vo_04 thread maps\recovery_utility::delete_on_notify("training_room_elevator_activated");
	level.ambient_soldier_vo_05 thread maps\recovery_utility::delete_on_notify("training_room_elevator_activated");
	level.ambient_soldier_vo_06 thread maps\recovery_utility::delete_on_notify("training_room_elevator_activated");
	thread tour_ambient_choppers();
	var_06 = [];
	for(;;)
	{
		common_scripts\utility::flag_wait("tour_ambient_00");
		var_07 = getentarray("military_guards_patrol","script_noteworthy");
		foreach(var_09 in var_07)
		{
			var_0A = var_09 maps\_utility::spawn_ai();
			var_06 = common_scripts\utility::array_add(var_06,var_0A);
			var_09.count++;
			wait 0.05;
		}

		var_07 = getentarray("tourspawner_ambient_00","targetname");
		foreach(var_09 in var_07)
		{
			var_0A = var_09 maps\_utility::spawn_ai();
			var_0A maps\_utility::set_battlechatter(0);
			var_06 = common_scripts\utility::array_add(var_06,var_0A);
			var_09.count++;
			wait 0.05;
		}

		common_scripts\utility::flag_waitopen("tour_ambient_00");
		wait(1);
	}
}

//Function Number: 111
tour_ambient_drone_lifetime()
{
	self.health = 50;
	self.pacifist = 1;
	self.ignoreme = 1;
	self.ignoreall = 1;
	maps\_utility::set_goalradius(4);
	self waittill("reached_dynamic_path_end");
	if(isdefined(self))
	{
		self delete();
	}
}

//Function Number: 112
tour_ambient_01()
{
	common_scripts\utility::flag_wait("tour_ambient_01");
	var_00 = getent("ambient_drone_spawner_01a","targetname");
	var_01 = getent("ambient_drone_spawner_01b","targetname");
	var_02 = getent("ambient_drone_spawner_01c","targetname");
	var_03 = var_00 maps\_vehicle::spawn_vehicle_and_gopath();
	var_03 soundscripts\_snd::snd_message("exo_drone_flby");
	var_04 = var_01 maps\_vehicle::spawn_vehicle_and_gopath();
	var_05 = var_02 maps\_vehicle::spawn_vehicle_and_gopath();
	var_03 thread tour_ambient_drone_lifetime();
	var_04 thread tour_ambient_drone_lifetime();
	var_05 thread tour_ambient_drone_lifetime();
	var_06 = maps\_vehicle::spawn_vehicle_from_targetname("base_ambient_vehicle_01");
	soundscripts\_snd::snd_message("tour_base_ambient_vehicle_01",var_06);
	var_06 maps\_vehicle::gopath();
	var_07 = getent("tour_driver","targetname");
	var_07.count++;
	var_08 = var_07 maps\_utility::spawn_ai(1);
	var_08 maps\_utility::gun_remove();
	var_08.animname = "driver";
	var_08.pacifist = 1;
	var_08.name = " ";
	var_08 linkto(var_06,"tag_origin");
	var_06 thread maps\_anim::anim_loop_solo(var_08,"tour_jeep_idle");
	var_09 = getent("jeep_middle_gate","targetname");
	var_0A = var_09 common_scripts\utility::get_target_ent();
	var_0A linkto(var_09);
	var_09.origin = var_09.origin - (331,0,0);
	wait(5);
	var_09 moveto(var_09.origin + (331,0,0),3,0.2,0.2);
	wait(5);
	var_08 delete();
}

//Function Number: 113
tour_ambient_02()
{
	common_scripts\utility::flag_wait("tour_ambient_02");
	var_00 = getent("jeep_exit_gate","targetname");
	var_01 = var_00 common_scripts\utility::get_target_ent();
	var_01 linkto(var_00);
	var_00 moveto(var_00.origin + (0,274,0),1);
	var_02 = maps\_vehicle::spawn_vehicle_from_targetname("base_ambient_vehicle_02");
	soundscripts\_snd::snd_message("tour_base_ambient_vehicle_02",var_02);
	var_02 maps\_vehicle::gopath();
	var_03 = getent("tour_driver","targetname");
	var_03.count++;
	var_04 = var_03 maps\_utility::spawn_ai(1);
	var_04 maps\_utility::gun_remove();
	var_04.animname = "driver";
	var_04.pacifist = 1;
	var_04.name = " ";
	var_04 linkto(var_02,"tag_origin");
	var_02 thread maps\_anim::anim_loop_solo(var_04,"tour_jeep_idle");
	wait(9.5);
	var_00 moveto(var_00.origin + (0,-274,0),3,0.25,0.25);
	wait(5);
	var_04 delete();
}

//Function Number: 114
tour_cleanup_01()
{
	common_scripts\utility::flag_wait("flag_cleanup_jeep_ride_first_half");
	var_00 = getentarray("jeep_ride_first_half","script_noteworthy");
	foreach(var_02 in var_00)
	{
		if(isdefined(var_02))
		{
			var_02 delete();
		}
	}
}

//Function Number: 115
tour_ambient_choppers()
{
	level endon("training_room_elevator_activated");
	var_00 = getent("base_ambient_chopper_01a","targetname");
	var_01 = undefined;
	var_02 = "tour_ambient_00";
	common_scripts\utility::flag_wait("dropoff_complete");
	for(;;)
	{
		if(common_scripts\utility::flag("tour_ambient_00") && !common_scripts\utility::flag("ambient_choppers_excluded"))
		{
			var_01 = var_00 maps\_vehicle::spawn_vehicle_and_gopath();
			soundscripts\_snd::snd_message("tour_littlebird_ambient",var_01);
			var_00.count++;
		}

		wait(randomintrange(50,60));
	}
}

//Function Number: 116
tour_fans()
{
	level endon("training_room_elevator_activated");
	var_00 = getent("breezer_01","targetname");
	var_01 = getent("breezer_02","targetname");
	var_02 = getent("breezer_03","targetname");
	var_03 = getent("breezer_04","targetname");
	common_scripts\utility::flag_wait("tour_exo_hangar");
	var_04 = 0.2;
	if(level.currentgen)
	{
		var_05 = [var_00,var_01,var_02,var_03];
		foreach(var_07 in var_05)
		{
			if(isdefined(var_07) == 0)
			{
				return;
			}
		}
	}

	for(;;)
	{
		var_00 rotatepitch(360,var_04);
		var_01 rotatepitch(360,var_04);
		var_02 rotatepitch(360,var_04);
		var_03 rotatepitch(360,var_04);
		wait(var_04);
	}
}

//Function Number: 117
tour_windsock()
{
	var_00 = getent("base_windsock_01","targetname");
	var_00 thread maps\recovery_utility::delete_on_notify("training_room_elevator_activated");
	var_00.animname = "windsock";
	var_00 maps\_anim::setanimtree();
	var_00 thread maps\_anim::anim_single_solo(var_00,"lab2_windsock_03_anim");
	var_00 setanimrate(var_00 maps\_utility::getanim("lab2_windsock_03_anim"),0.33);
}

//Function Number: 118
tour_doors()
{
	thread tour_giant_doors();
	thread tour_hangar_door_01();
	thread tour_glass_door_01();
	thread tour_glass_door_02();
	thread tour_glass_door_03();
	thread tour_glass_door_04();
	thread tour_glass_door_05();
	thread tour_range_door_01();
	thread tour_range_door_02();
	thread tour_solid_door_01();
	thread tour_solid_door_02();
	thread tour_yellow_door_01();
	thread tour_yellow_door_02();
	thread tour_yellow_door_03();
	thread tour_end_gate();
}

//Function Number: 119
tour_giant_doors()
{
	var_00 = getent("tour_giant_door_01_l_part1","targetname");
	var_01 = getent("tour_giant_door_01_l_part2","targetname");
	var_02 = getent("tour_giant_door_01_r_part1","targetname");
	var_03 = getent("tour_giant_door_01_r_part2","targetname");
	var_04 = 5;
	var_00 hide();
	var_01 hide();
	var_02 hide();
	var_03 hide();
	common_scripts\utility::flag_wait("training_s1_flag_doors_open");
	if(level.currentgen)
	{
		maps\_utility::tff_sync();
	}

	var_00 show();
	var_01 show();
	var_02 show();
	var_03 show();
	var_00 moveto(var_00.origin + (-757,0,0),var_04 * 2,1,1);
	var_02 moveto(var_02.origin + (757,0,0),var_04 * 2,1,1);
	wait(var_04);
	var_01 moveto(var_01.origin + (-385,0,0),var_04,0,1);
	var_03 moveto(var_03.origin + (385,0,0),var_04,0,1);
	common_scripts\utility::flag_wait("tour_ride");
	wait(var_04 * 2);
	var_00 moveto(var_00.origin + (757,0,0),var_04 * 2,1,1);
	var_02 moveto(var_02.origin + (-757,0,0),var_04 * 2,1,1);
	var_01 moveto(var_01.origin + (385,0,0),var_04,1,0);
	var_03 moveto(var_03.origin + (-385,0,0),var_04,1,0);
	common_scripts\utility::flag_wait("training_s2_ready");
	var_00 hide();
	var_01 hide();
	var_02 hide();
	var_03 hide();
}

//Function Number: 120
tour_hangar_door_01()
{
	var_00 = getent("tour_hangar_door_01_l_part1","targetname");
	var_01 = getent("tour_hangar_door_01_l_part2","targetname");
	var_02 = getent("tour_hangar_door_01_r_part1","targetname");
	var_03 = getent("tour_hangar_door_01_r_part2","targetname");
	common_scripts\utility::flag_wait("tour_hangar_door_01");
	thread tour_hangar_drones();
	common_scripts\utility::flag_set("tour_ride_hangar_lighting");
	var_04 = 4;
	var_00 moveto(var_00.origin + (0,-385,0),var_04,0,0);
	var_02 moveto(var_02.origin + (0,385,0),var_04,0,0);
	wait(var_04);
	var_00 moveto(var_00.origin + (0,-277,0),3.35,0,0);
	var_02 moveto(var_02.origin + (0,277,0),3.35,0,0);
	var_01 moveto(var_01.origin + (0,-277,0),3.35,0,0);
	var_03 moveto(var_03.origin + (0,277,0),3.35,0,0);
}

//Function Number: 121
tour_glass_door_01()
{
	level endon("training_room_elevator_activated");
	if(level.currentgen)
	{
		level endon("tff_pre_tour_exo_to_tour_firing_range");
		if(!istransientloaded("recovery_tour_exo_tr"))
		{
			level waittill("tff_post_tour_ride_to_tour_exo");
		}
	}

	var_00 = getent("tour_glass_door_01_l","targetname");
	var_01 = getent("tour_glass_door_01_r","targetname");
	var_02 = var_00 common_scripts\utility::get_target_ent();
	var_03 = var_01 common_scripts\utility::get_target_ent();
	var_02 connectpaths();
	var_03 connectpaths();
	var_02 linkto(var_00);
	var_03 linkto(var_01);
	var_04 = common_scripts\utility::getstruct("tour_glass_door_01_l_opened","targetname");
	var_05 = common_scripts\utility::getstruct("tour_glass_door_01_r_opened","targetname");
	var_06 = common_scripts\utility::getstruct("tour_glass_door_01_closed","targetname");
	var_07 = 0.6;
	while(!common_scripts\utility::flag("arm_swapped"))
	{
		common_scripts\utility::flag_wait("tour_glass_door_01");
		soundscripts\_snd::snd_message("rec_star_trek_door_open",var_00,var_01);
		var_00 moveto(var_04.origin,var_07,0.2,0.2);
		var_01 moveto(var_05.origin,var_07,0.2,0.2);
		common_scripts\utility::flag_set("tour_exo_hangar");
		common_scripts\utility::flag_waitopen("tour_glass_door_01");
		soundscripts\_snd::snd_message("rec_star_trek_door_close",var_00,var_01);
		var_00 moveto(var_06.origin,var_07,0.2,0.2);
		var_01 moveto(var_06.origin,var_07,0.2,0.2);
	}
}

//Function Number: 122
tour_glass_door_02()
{
	level endon("training_room_elevator_activated");
	common_scripts\utility::flag_wait("arm_swapped");
	if(level.currentgen)
	{
		level endon("tff_pre_tour_exo_to_tour_firing_range");
	}

	var_00 = getent("tour_glass_door_02_l","targetname");
	var_01 = getent("tour_glass_door_02_r","targetname");
	var_02 = var_00 common_scripts\utility::get_target_ent();
	var_03 = var_01 common_scripts\utility::get_target_ent();
	var_02 connectpaths();
	var_03 connectpaths();
	var_02 linkto(var_00);
	var_03 linkto(var_01);
	var_04 = common_scripts\utility::getstruct("tour_glass_door_02_l_opened","targetname");
	var_05 = common_scripts\utility::getstruct("tour_glass_door_02_r_opened","targetname");
	var_06 = common_scripts\utility::getstruct("tour_glass_door_02_closed","targetname");
	var_07 = 0.6;
	while(!common_scripts\utility::flag("flag_obj_firing_range_pre"))
	{
		common_scripts\utility::flag_wait("tour_glass_door_02");
		soundscripts\_snd::snd_message("rec_star_trek_door_open",var_00,var_01);
		var_00 moveto(var_04.origin,var_07,0.2,0.2);
		var_01 moveto(var_05.origin,var_07,0.2,0.2);
		common_scripts\utility::flag_waitopen("tour_glass_door_02");
		soundscripts\_snd::snd_message("rec_star_trek_door_close",var_00,var_01);
		var_00 moveto(var_06.origin,var_07,0.2,0.2);
		var_01 moveto(var_06.origin,var_07,0.2,0.2);
	}
}

//Function Number: 123
tour_glass_door_03()
{
	level endon("training_room_elevator_activated");
	if(level.currentgen)
	{
		level endon("tff_pre_tour_firing_range_to_tour_aug_reality");
	}

	common_scripts\utility::flag_wait("arm_swapped");
	var_00 = getent("tour_glass_door_03_l","targetname");
	var_01 = getent("tour_glass_door_03_r","targetname");
	var_02 = var_00 common_scripts\utility::get_target_ent();
	var_03 = var_01 common_scripts\utility::get_target_ent();
	var_02 connectpaths();
	var_03 connectpaths();
	var_02 linkto(var_00);
	var_03 linkto(var_01);
	var_04 = common_scripts\utility::getstruct("tour_glass_door_03_l_opened","targetname");
	var_05 = common_scripts\utility::getstruct("tour_glass_door_03_r_opened","targetname");
	var_06 = common_scripts\utility::getstruct("tour_glass_door_03_closed","targetname");
	var_07 = 0.6;
	if(level.currentgen)
	{
		if(!istransientloaded("recovery_tour_firing_range_tr"))
		{
			level waittill("tff_post_tour_exo_to_tour_firing_range");
		}
	}

	while(!common_scripts\utility::flag("shooting_range_started_once"))
	{
		common_scripts\utility::flag_wait("tour_glass_door_03");
		soundscripts\_snd::snd_message("rec_star_trek_door_open",var_00,var_01);
		var_00 moveto(var_04.origin,var_07,0.2,0.2);
		var_01 moveto(var_05.origin,var_07,0.2,0.2);
		common_scripts\utility::flag_waitopen("tour_glass_door_03");
		soundscripts\_snd::snd_message("rec_star_trek_door_close",var_00,var_01);
		var_00 moveto(var_06.origin,var_07,0.2,0.2);
		var_01 moveto(var_06.origin,var_07,0.2,0.2);
	}

	common_scripts\utility::flag_wait("shooting_range_completed_once");
	for(;;)
	{
		common_scripts\utility::flag_wait("tour_glass_door_03");
		soundscripts\_snd::snd_message("rec_star_trek_door_open",var_00,var_01);
		var_00 moveto(var_04.origin,var_07,0.2,0.2);
		var_01 moveto(var_05.origin,var_07,0.2,0.2);
		common_scripts\utility::flag_waitopen("tour_glass_door_03");
		soundscripts\_snd::snd_message("rec_star_trek_door_close",var_00,var_01);
		var_00 moveto(var_06.origin,var_07,0.2,0.2);
		var_01 moveto(var_06.origin,var_07,0.2,0.2);
	}
}

//Function Number: 124
tour_glass_door_04()
{
	level endon("training_room_elevator_activated");
	if(level.currentgen)
	{
		level endon("tff_pre_tour_firing_range_to_tour_aug_reality");
	}

	common_scripts\utility::flag_wait("shooting_range_completed_once");
	var_00 = getent("tour_glass_door_04_l","targetname");
	var_01 = getent("tour_glass_door_04_r","targetname");
	var_02 = var_00 common_scripts\utility::get_target_ent();
	var_03 = var_01 common_scripts\utility::get_target_ent();
	var_02 connectpaths();
	var_03 connectpaths();
	var_02 linkto(var_00);
	var_03 linkto(var_01);
	var_04 = common_scripts\utility::getstruct("tour_glass_door_04_l_opened","targetname");
	var_05 = common_scripts\utility::getstruct("tour_glass_door_04_r_opened","targetname");
	var_06 = common_scripts\utility::getstruct("tour_glass_door_04_closed","targetname");
	var_07 = 0.6;
	for(;;)
	{
		common_scripts\utility::flag_wait("tour_glass_door_04");
		soundscripts\_snd::snd_message("rec_star_trek_door_open",var_00,var_01);
		var_00 moveto(var_04.origin,var_07,0.2,0.2);
		var_01 moveto(var_05.origin,var_07,0.2,0.2);
		common_scripts\utility::flag_waitopen("tour_glass_door_04");
		soundscripts\_snd::snd_message("rec_star_trek_door_close",var_00,var_01);
		var_00 moveto(var_06.origin,var_07,0.2,0.2);
		var_01 moveto(var_06.origin,var_07,0.2,0.2);
	}
}

//Function Number: 125
tour_glass_door_05()
{
	level endon("training_room_elevator_activated");
	var_00 = getent("tour_glass_door_05_l","targetname");
	var_01 = getent("tour_glass_door_05_r","targetname");
	var_02 = var_00 common_scripts\utility::get_target_ent();
	var_03 = var_01 common_scripts\utility::get_target_ent();
	var_02 linkto(var_00);
	var_03 linkto(var_01);
	var_02 connectpaths();
	var_03 connectpaths();
	var_04 = common_scripts\utility::getstruct("tour_glass_door_05_l_opened","targetname");
	var_05 = common_scripts\utility::getstruct("tour_glass_door_05_r_opened","targetname");
	var_06 = common_scripts\utility::getstruct("tour_glass_door_05_closed","targetname");
	var_07 = 0.6;
	for(;;)
	{
		common_scripts\utility::flag_wait("tour_glass_door_05");
		if(level.currentgen)
		{
			if(!istransientloaded("recovery_base_tr"))
			{
				break;
			}
		}

		soundscripts\_snd::snd_message("rec_star_trek_door_open",var_00,var_01);
		var_00 moveto(var_04.origin,var_07,0.2,0.2);
		var_01 moveto(var_05.origin,var_07,0.2,0.2);
		common_scripts\utility::flag_waitopen("tour_glass_door_05");
		soundscripts\_snd::snd_message("rec_star_trek_door_close",var_00,var_01);
		var_00 moveto(var_06.origin,var_07,0.2,0.2);
		var_01 moveto(var_06.origin,var_07,0.2,0.2);
	}
}

//Function Number: 126
tour_range_door_01()
{
	level endon("training_room_elevator_activated");
	var_00 = getent("tour_range_door_01_l","targetname");
	var_01 = getent("tour_range_door_01_r","targetname");
	var_02 = var_00 common_scripts\utility::get_target_ent();
	var_03 = var_01 common_scripts\utility::get_target_ent();
	var_02 linkto(var_00);
	var_03 linkto(var_01);
	var_02 connectpaths();
	var_03 connectpaths();
	var_04 = common_scripts\utility::getstruct("tour_range_door_01_l_opened","targetname");
	var_05 = common_scripts\utility::getstruct("tour_range_door_01_r_opened","targetname");
	var_06 = common_scripts\utility::getstruct("tour_range_door_01_closed","targetname");
	var_07 = 0.6;
	common_scripts\utility::flag_wait("tour_range_door_01_gideon");
	if(level.currentgen)
	{
		level notify("player_entering_firing_range");
	}

	soundscripts\_snd::snd_message("rec_star_trek_door_open",var_00,var_01);
	var_00 moveto(var_04.origin,var_07,0.2,0.2);
	var_01 moveto(var_05.origin,var_07,0.2,0.2);
	common_scripts\utility::flag_wait("flag_obj_equip_firing_range");
	soundscripts\_snd::snd_message("rec_star_trek_door_close",var_00,var_01);
	var_00 moveto(var_06.origin,0.4,0.2,0.2);
	var_01 moveto(var_06.origin,0.4,0.2,0.2);
	common_scripts\utility::flag_wait("shooting_range_completed_once");
	for(;;)
	{
		common_scripts\utility::flag_wait("tour_range_door_01");
		soundscripts\_snd::snd_message("rec_star_trek_door_open",var_00,var_01);
		var_00 moveto(var_04.origin,var_07,0.2,0.2);
		var_01 moveto(var_05.origin,var_07,0.2,0.2);
		common_scripts\utility::flag_waitopen("tour_range_door_01");
		soundscripts\_snd::snd_message("rec_star_trek_door_close",var_00,var_01);
		var_00 moveto(var_06.origin,var_07,0.2,0.2);
		var_01 moveto(var_06.origin,var_07,0.2,0.2);
	}
}

//Function Number: 127
tour_range_door_02()
{
	level endon("training_room_elevator_activated");
	common_scripts\utility::flag_wait("shooting_range_completed_once");
	var_00 = getent("tour_range_door_02_l","targetname");
	var_01 = getent("tour_range_door_02_r","targetname");
	var_02 = var_00 common_scripts\utility::get_target_ent();
	var_03 = var_01 common_scripts\utility::get_target_ent();
	var_02 linkto(var_00);
	var_03 linkto(var_01);
	var_02 connectpaths();
	var_03 connectpaths();
	var_04 = common_scripts\utility::getstruct("tour_range_door_02_l_opened","targetname");
	var_05 = common_scripts\utility::getstruct("tour_range_door_02_r_opened","targetname");
	var_06 = common_scripts\utility::getstruct("tour_range_door_02_closed","targetname");
	var_07 = 0.6;
	for(;;)
	{
		common_scripts\utility::flag_wait("tour_range_door_02");
		soundscripts\_snd::snd_message("rec_star_trek_door_open",var_00,var_01);
		var_00 moveto(var_04.origin,var_07,0.2,0.2);
		var_01 moveto(var_05.origin,var_07,0.2,0.2);
		common_scripts\utility::flag_waitopen("tour_range_door_02");
		soundscripts\_snd::snd_message("rec_star_trek_door_close",var_00,var_01);
		var_00 moveto(var_06.origin,var_07,0.2,0.2);
		var_01 moveto(var_06.origin,var_07,0.2,0.2);
	}
}

//Function Number: 128
tour_solid_door_01()
{
	level endon("training_room_elevator_activated");
	var_00 = getent("tour_solid_door_01_clip","targetname");
	var_00 notsolid();
	var_01 = getent("tour_solid_door_01_l","targetname");
	var_02 = getent("tour_solid_door_01_r","targetname");
	var_03 = var_01.origin;
	var_04 = var_02.origin;
	var_05 = var_01.origin + (0,-54,0);
	var_06 = var_02.origin + (0,54,0);
	var_07 = 0.6;
	while(!common_scripts\utility::flag("arm_swapped"))
	{
		common_scripts\utility::flag_wait("tour_solid_door_01");
		if(!common_scripts\utility::flag("arm_swapped"))
		{
			soundscripts\_snd::snd_message("rec_star_trek_door_open",var_01,var_02);
			var_01 moveto(var_05,var_07,0.2,0.2);
			var_02 moveto(var_06,var_07,0.2,0.2);
		}
		else
		{
			continue;
		}

		common_scripts\utility::flag_waitopen("tour_solid_door_01");
		soundscripts\_snd::snd_message("rec_star_trek_door_close",var_01,var_02);
		var_01 moveto(var_03,var_07,0.2,0.2);
		var_02 moveto(var_04,var_07,0.2,0.2);
	}

	var_00 solid();
}

//Function Number: 129
tour_solid_door_02()
{
	level endon("training_room_elevator_activated");
	var_00 = getent("tour_solid_door_02_clip","targetname");
	var_00 solid();
	common_scripts\utility::flag_wait("arm_swapped");
	var_00 notsolid();
	var_01 = getent("tour_solid_door_02_l","targetname");
	var_02 = getent("tour_solid_door_02_r","targetname");
	var_03 = var_01.origin;
	var_04 = var_02.origin;
	var_05 = var_01.origin + (0,-54,0);
	var_06 = var_02.origin + (0,54,0);
	var_07 = 0.6;
	for(;;)
	{
		common_scripts\utility::flag_wait("tour_solid_door_02");
		soundscripts\_snd::snd_message("rec_star_trek_door_open",var_01,var_02);
		var_01 moveto(var_05,var_07,0.2,0.2);
		var_02 moveto(var_06,var_07,0.2,0.2);
		common_scripts\utility::flag_waitopen("tour_solid_door_02");
		soundscripts\_snd::snd_message("rec_star_trek_door_close",var_01,var_02);
		var_01 moveto(var_03,var_07,0.2,0.2);
		var_02 moveto(var_04,var_07,0.2,0.2);
	}
}

//Function Number: 130
tour_yellow_door_01()
{
	level endon("training_room_elevator_activated");
	var_00 = getent("tour_yellow_door_01_l","targetname");
	var_01 = getent("tour_yellow_door_01_r","targetname");
	var_02 = var_00 common_scripts\utility::get_target_ent();
	var_03 = var_01 common_scripts\utility::get_target_ent();
	var_02 linkto(var_00);
	var_03 linkto(var_01);
	var_02 connectpaths();
	var_03 connectpaths();
	var_04 = var_00.origin;
	var_05 = var_01.origin;
	var_06 = var_00.origin + (0,-70,0);
	var_07 = var_01.origin + (0,70,0);
	var_08 = 0.6;
	for(;;)
	{
		common_scripts\utility::flag_wait("tour_yellow_door_01");
		soundscripts\_snd::snd_message("rec_star_trek_door_open",var_00,var_01);
		var_00 moveto(var_06,var_08,0.2,0.2);
		var_01 moveto(var_07,var_08,0.2,0.2);
		if(!common_scripts\utility::flag("arm_swapped"))
		{
			common_scripts\utility::flag_wait("gideon_inside_exo_mode_room");
			common_scripts\utility::flag_wait("player_inside_exo_mode_room");
		}

		common_scripts\utility::flag_waitopen("tour_yellow_door_01");
		soundscripts\_snd::snd_message("rec_star_trek_door_close",var_00,var_01);
		var_00 moveto(var_04,var_08,0.2,0.2);
		var_01 moveto(var_05,var_08,0.2,0.2);
		if(common_scripts\utility::flag("player_inside_exo_mode_room") && common_scripts\utility::flag("gideon_inside_exo_mode_room"))
		{
			common_scripts\utility::flag_wait("arm_swapped");
		}
	}
}

//Function Number: 131
tour_yellow_door_02()
{
	level endon("training_room_elevator_activated");
	var_00 = getent("tour_yellow_door_02_l","targetname");
	var_01 = getent("tour_yellow_door_02_r","targetname");
	var_02 = var_00.origin;
	var_03 = var_01.origin;
	var_04 = var_00.origin + (0,70,0);
	var_05 = var_01.origin + (0,-70,0);
	var_06 = 0.6;
	for(;;)
	{
		common_scripts\utility::flag_wait("tour_yellow_door_02");
		common_scripts\utility::flag_waitopen("tour_yellow_door_02");
	}
}

//Function Number: 132
tour_yellow_door_03()
{
	level endon("training_room_elevator_activated");
	var_00 = getent("tour_yellow_door_03_l","targetname");
	var_01 = getent("tour_yellow_door_03_r","targetname");
	var_02 = var_00 common_scripts\utility::get_target_ent();
	var_03 = var_01 common_scripts\utility::get_target_ent();
	var_02 linkto(var_00);
	var_03 linkto(var_01);
	var_02 connectpaths();
	var_03 connectpaths();
	var_04 = var_00.origin;
	var_05 = var_01.origin;
	var_06 = var_00.origin + (0,-70,0);
	var_07 = var_01.origin + (0,70,0);
	var_08 = 0.6;
	common_scripts\utility::flag_wait("flag_obj_arm_repair_pre");
	soundscripts\_snd::snd_message("rec_star_trek_door_open",var_00,var_01);
	var_00 moveto(var_06,var_08,0.2,0.2);
	var_01 moveto(var_07,var_08,0.2,0.2);
	common_scripts\utility::flag_wait("tour_exo_arm");
	for(;;)
	{
		common_scripts\utility::flag_waitopen("tour_yellow_door_03");
		soundscripts\_snd::snd_message("rec_star_trek_door_close",var_00,var_01);
		var_00 moveto(var_04,var_08,0.2,0.2);
		var_01 moveto(var_05,var_08,0.2,0.2);
		common_scripts\utility::flag_wait("tour_yellow_door_03");
		soundscripts\_snd::snd_message("rec_star_trek_door_open",var_00,var_01);
		var_00 moveto(var_06,var_08,0.2,0.2);
		var_01 moveto(var_07,var_08,0.2,0.2);
	}
}

//Function Number: 133
tour_end_gate()
{
	var_00 = getent("jeep_middle_gate","targetname");
	var_01 = var_00 common_scripts\utility::get_target_ent();
	var_01 linkto(var_00);
	var_02 = 2;
	common_scripts\utility::flag_wait("jeep_end_gate_open");
	var_00 moveto(var_00.origin + (-331,0,0),var_02 * 2,0.2,0.2);
	soundscripts\_snd::snd_message("rec_tour_end_jeep_gate_plr_open",var_00);
	common_scripts\utility::flag_wait("tour_end");
	var_00 moveto(var_00.origin + (331,0,0),var_02 * 2,0.2,0.2);
	soundscripts\_snd::snd_message("rec_tour_end_jeep_gate_plr_close",var_00);
	var_03 = getent("jeep_exit_gate","targetname");
	var_04 = var_03 common_scripts\utility::get_target_ent();
	var_04 linkto(var_03);
	var_03 moveto(var_03.origin + (0,274,0),1);
	soundscripts\_snd::snd_message("rec_tour_npc_jeep_exit_gate_open",var_03);
	common_scripts\utility::flag_wait("jeep_exit_gate");
	var_03 moveto(var_03.origin + (0,-274,0),4,0.25,0.25);
	soundscripts\_snd::snd_message("rec_tour_npc_jeep_exit_gate_close",var_03);
}

//Function Number: 134
tour_hangar_drones()
{
	var_00 = getentarray("hangar_drone","targetname");
	level.aud.hangar_drones = [];
	common_scripts\utility::array_thread(var_00,::tour_hangar_drone_lifetime);
	while(var_00.size > level.aud.hangar_drones.size)
	{
		wait 0.05;
	}

	soundscripts\_snd::snd_message("tour_hangar_drones",level.aud.hangar_drones);
}

//Function Number: 135
tour_hangar_drone_lifetime()
{
	var_00 = maps\_vehicle::spawn_vehicle_and_gopath();
	level.aud.hangar_drones[level.aud.hangar_drones.size] = var_00;
	var_00.pacifist = 1;
	var_00.ignoreme = 1;
	var_00.ignoreall = 1;
	var_00 maps\_utility::set_goalradius(4);
	var_00 waittill("reached_dynamic_path_end");
	var_00 maps\_utility::vehicle_land();
	common_scripts\utility::flag_wait("tour_end");
	var_00 delete();
}

//Function Number: 136
tour_spawn_vtol()
{
	var_00 = getent("vtol_takeoff","targetname");
	var_01 = var_00 maps\_utility::spawn_vehicle();
	soundscripts\_snd::snd_message("rec_tour_vtol_takeoff_spawn",var_01);
	common_scripts\utility::flag_set("tour_ride_drive_lighting");
	wait(2);
	var_02 = common_scripts\utility::getstruct("vtol_start","targetname");
	var_01 thread maps\_vehicle::vehicle_paths(var_02);
	wait(3);
	var_01 vehicle_setspeed(50);
	var_01 waittill("reached_dynamic_path_end");
	var_01 delete();
	common_scripts\utility::flag_set("tour_ride_end_lighting");
}

//Function Number: 137
tour_lander_01()
{
	common_scripts\utility::flag_wait("flag_lander_01");
	var_00 = maps\_vehicle::spawn_vehicle_from_targetname_and_drive("lander_01");
	soundscripts\_snd::snd_message("tour_littlebird_lander",var_00);
	var_00 waittill("reached_dynamic_path_end");
	var_00 maps\_utility::vehicle_land();
	common_scripts\utility::flag_wait("flag_cleanup_jeep_ride_first_half");
	var_00 delete();
}

//Function Number: 138
tour_brave_warrior_01()
{
	common_scripts\utility::flag_wait("flag_tour_brave_warrior_01");
	var_00 = maps\_vehicle::spawn_vehicle_from_targetname_and_drive("tour_brave_warrior_01");
	var_01 = getent("tour_driver","targetname");
	var_01.count++;
	var_02 = var_01 maps\_utility::spawn_ai(1);
	var_02 maps\_utility::gun_remove();
	var_02.animname = "driver";
	var_02.pacifist = 1;
	var_02.name = " ";
	var_02 linkto(var_00,"tag_origin");
	var_00 thread maps\_anim::anim_loop_solo(var_02,"tour_jeep_idle");
	wait(17);
	var_02 delete();
}

//Function Number: 139
tour_brave_warrior_03()
{
	common_scripts\utility::flag_wait("flag_tour_brave_warrior_03");
	var_00 = maps\_vehicle::spawn_vehicle_from_targetname_and_drive("tour_brave_warrior_03");
	var_01 = getent("tour_driver","targetname");
	var_01.count++;
	var_02 = var_01 maps\_utility::spawn_ai(1);
	var_02 maps\_utility::gun_remove();
	var_02.animname = "driver";
	var_02.pacifist = 1;
	var_02.name = " ";
	var_02 linkto(var_00,"tag_origin");
	var_00 thread maps\_anim::anim_loop_solo(var_02,"tour_jeep_idle");
	wait(7);
	var_02 delete();
}

//Function Number: 140
tour_titan_01()
{
	common_scripts\utility::flag_wait("flag_titan_crossing");
	var_00 = getent("jeep_entrance_gate","targetname");
	var_01 = getent("titan_01","targetname");
	var_02 = getent("titan_goal_01","targetname");
	level thread maps\recovery_fx::titan_gate_tread_fx(var_01);
	var_03 = 20;
	var_01 moveto(var_02.origin,var_03,0.5,0.5);
	soundscripts\_snd::snd_message("rec_tour_titan_1_start",var_01);
	wait(1);
	var_00 moveto(var_00.origin + (331,0,0),4,0.25,0.25);
	soundscripts\_snd::snd_message("rec_tour_titan_gate_plr_open",var_00);
	wait(20);
	var_01 delete();
}

//Function Number: 141
tour_titan_02()
{
	common_scripts\utility::flag_wait("flag_titan_crossing");
	var_00 = undefined;
	if(level.nextgen)
	{
		var_00 = getent("giant_crane_01","targetname");
		var_00 rotateyaw(-180,22,1,1);
	}

	wait(7);
	var_01 = maps\_vehicle::spawn_vehicle_from_targetname_and_drive("tour_brave_warrior_02");
	soundscripts\_snd::snd_message("rec_tour_escort_jeep_start",var_01);
	var_02 = getent("tour_driver","targetname");
	var_02.count++;
	var_03 = var_02 maps\_utility::spawn_ai(1);
	var_03 maps\_utility::gun_remove();
	var_03.animname = "driver";
	var_03.pacifist = 1;
	var_03.name = " ";
	var_03 linkto(var_01,"tag_origin");
	var_01 thread maps\_anim::anim_loop_solo(var_03,"tour_jeep_idle");
	var_04 = "walker_step_over";
	var_05 = getent("titan_02","targetname");
	var_05.animname = "titan";
	var_05 setmodel("vehicle_rec_walker_tank");
	var_05.origin = var_05.origin + (0,0,55);
	var_06 = var_05 common_scripts\utility::spawn_tag_origin();
	var_05 maps\_anim::setanimtree();
	soundscripts\_snd::snd_message("rec_tour_titan_2_walk_anim_start",var_05);
	var_07 = getanimlength(level.scr_anim["titan"]["walk_across"]);
	for(var_08 = 0;var_08 < 5;var_08++)
	{
		var_06.origin = var_05.origin;
		var_06 thread maps\_anim::anim_single_solo(var_05,"walk_across","tag_origin");
		wait(var_07);
	}

	var_05 delete();
	var_06 delete();
	if(level.nextgen)
	{
		var_00 delete();
	}

	var_03 delete();
}

//Function Number: 142
tour_ambient_people()
{
	var_00 = maps\_utility::array_spawn_targetname("tourspawner_initial");
	foreach(var_02 in var_00)
	{
		var_02.name = " ";
		var_02 setlookattext(var_02.name,&"");
	}

	common_scripts\utility::flag_wait("spawn_joggers");
	maps\_utility::array_spawn_targetname("tourspawner_joggers");
}

//Function Number: 143
tour_military_ambient_people()
{
	common_scripts\utility::flag_wait("spawn_military_worldfill");
}

//Function Number: 144
tour_hangar_ambient_people()
{
	var_00 = getent("observer_spawner_c","targetname");
	var_01 = getent("observer_spawner_f","targetname");
	var_02 = getentarray("hangar_observer_idle","targetname");
	var_03 = [];
	foreach(var_05 in var_02)
	{
		var_00.count = 1;
		var_01.count = 1;
		if(common_scripts\utility::cointoss())
		{
			var_06 = var_00 maps\_utility::spawn_ai(1);
		}
		else
		{
			var_06 = var_01 maps\_utility::spawn_ai(1);
		}

		var_06 setmodel(var_05.model);
		var_06.ignoresonicaoe = 1;
		var_03[var_03.size] = var_06;
		var_05 thread maps\_shg_design_tools::anim_simple(var_06,var_05.animation);
		wait 0.05;
	}

	common_scripts\utility::flag_wait("flag_hangar_walkers");
	maps\_utility::array_spawn_targetname("tourspawner_hangar");
	common_scripts\utility::flag_wait("tour_end");
	common_scripts\utility::array_call(var_03,::delete);
}

//Function Number: 145
tour_jets()
{
}

//Function Number: 146
tour_boost_jumpers_initial()
{
	common_scripts\utility::flag_wait("flag_boost_jumpers_initial");
	thread tour_boost_jumpers_overhead();
	var_00 = getent("booster_01","targetname") maps\_utility::spawn_ai(1);
	var_01 = getent("booster_02","targetname") maps\_utility::spawn_ai(1);
	var_02 = getent("booster_03","targetname") maps\_utility::spawn_ai(1);
	var_03 = getent("booster_04","targetname") maps\_utility::spawn_ai(1);
	var_00.canjumppath = 1;
	var_01.canjumppath = 1;
	var_02.canjumppath = 1;
	var_03.canjumppath = 1;
	var_00 thread tour_boost_jumper_lifetime(1);
	var_01 thread tour_boost_jumper_lifetime(2);
	var_02 thread tour_boost_jumper_lifetime(3);
	var_03 thread tour_boost_jumper_lifetime(4);
}

//Function Number: 147
tour_boost_jumper_lifetime(param_00)
{
	var_01 = getnode("jump_goal_0" + param_00 + "a","targetname");
	self setgoalpos(var_01.origin);
	self.goalradius = 16;
	booster_distance_checker(var_01);
	var_01 = getnode("jump_goal_0" + param_00 + "b","targetname");
	self setgoalpos(var_01.origin);
	self.goalradius = 16;
	booster_distance_checker(var_01);
	var_01 = getnode("jump_goal_0" + param_00 + "c","targetname");
	self setgoalpos(var_01.origin);
	self.goalradius = 16;
	booster_distance_checker(var_01);
	var_01 = getnode("jump_goal_0" + param_00 + "d","targetname");
	self setgoalpos(var_01.origin);
	self.goalradius = 16;
	self waittill("goal");
	self delete();
}

//Function Number: 148
booster_distance_checker(param_00)
{
	while(distance(self.origin,param_00.origin) > 128)
	{
		wait 0.05;
	}
}

//Function Number: 149
tour_boost_jumpers_overhead()
{
	common_scripts\utility::flag_wait("flag_boost_jumpers_overhead");
	var_00 = getent("booster_05","targetname") maps\_utility::spawn_ai(1);
	var_01 = getent("booster_06","targetname") maps\_utility::spawn_ai(1);
	var_00.canjumppath = 1;
	var_01.canjumppath = 1;
	wait(10);
	var_00 delete();
	var_01 delete();
}

//Function Number: 150
tour_shooting_range()
{
	var_00 = getent("org_anim_shooting_range","targetname");
	thread tour_shooting_range_gideon(var_00);
	common_scripts\utility::flag_wait("flag_start_shooting");
	level.shootingrangeleaderboard = maps\recovery_utility::leaderboard_make(10,"shooting_range");
	if(!common_scripts\utility::flag("shooting_range_started_once"))
	{
		thread tour_shooting_range_ilona(var_00);
	}

	maps\recovery_utility::wait_for_primary_weapon_pickup();
	level.player allowfire(1);
	level.player allowads(1);
	if(level.player getcurrentprimaryweapon() == "iw5_bal27_sp_silencer01_variablereddot")
	{
		level.player enablehybridsight("iw5_bal27_sp_silencer01_variablereddot",1);
	}

	if(level.player getcurrentprimaryweapon() == "iw5_bal27_sp_variablereddot")
	{
		level.player enablehybridsight("iw5_bal27_sp_variablereddot",1);
	}
}

//Function Number: 151
tour_shooting_range_ilona(param_00)
{
	level endon("training_room_elevator_activated");
	param_00 = param_00 common_scripts\utility::spawn_tag_origin();
	param_00 thread maps\recovery_utility::delete_on_notify("training_room_elevator_activated");
	level.ilona = getent("ilona","targetname") maps\_utility::spawn_ai(1);
	level.ilona.animname = "ilona";
	level.ilona endon("death");
	level.ilona thread maps\recovery_utility::delete_on_notify("training_round_2");
	param_00 thread maps\_anim::anim_loop_solo(level.ilona,"rec_atlas_shootingrange_ilona_idle01");
	common_scripts\utility::flag_wait("shooting_range_talk");
	param_00 notify("stop_loop");
	param_00 maps\_anim::anim_single_solo(level.ilona,"rec_atlas_shootingrange_talk_ilona");
	for(;;)
	{
		param_00 thread maps\_anim::anim_loop_solo(level.ilona,"rec_atlas_shootingrange_ilana_screen_idle");
		common_scripts\utility::flag_wait("flag_shooting_range_start");
		common_scripts\utility::flag_wait("ilona_range_turn_ok");
		param_00 notify("stop_loop");
		param_00 maps\_anim::anim_single_solo(level.ilona,"rec_atlas_shootingrange_ilana_screentolook");
		param_00 thread maps\_anim::anim_loop_solo(level.ilona,"rec_atlas_shootingrange_ilana_look_idle");
		common_scripts\utility::flag_waitopen("flag_shooting_range_start");
		common_scripts\utility::flag_wait("ilona_range_turn_ok");
		param_00 notify("stop_loop");
		param_00 maps\_anim::anim_single_solo(level.ilona,"rec_atlas_shootingrange_ilana_looktoscreen");
	}
}

//Function Number: 152
tour_shooting_range_gideon(param_00)
{
	common_scripts\utility::flag_wait("shooting_range_stairs_down");
	level.gideon maps\_utility::disable_ai_color();
	param_00 maps\_anim::anim_reach_solo(level.gideon,"rec_shooting_stairs_down_guy01");
	param_00 maps\_anim::anim_single_solo(level.gideon,"rec_shooting_stairs_down_guy01");
	var_01 = getnode("shooting_range_wait_to_enter","targetname");
	level.gideon.goalradius = 64;
	level.gideon setgoalnode(var_01);
	common_scripts\utility::flag_wait("tour_ilona_sequence");
	param_00 maps\_anim::anim_reach_solo(level.gideon,"rec_atlas_shootingrange_gideon_talk");
	common_scripts\utility::flag_set("shooting_range_talk");
	common_scripts\utility::flag_set("flag_vo_shooting_range_01");
	param_00 maps\_anim::anim_single_solo(level.gideon,"rec_atlas_shootingrange_gideon_talk");
	param_00 thread maps\_anim::anim_loop_solo(level.gideon,"rec_atlas_shootingrange_gideon_idle02");
	common_scripts\utility::flag_wait("gideon_early_exit_holo_range");
	param_00 notify("stop_loop");
	param_00 maps\_anim::anim_single_solo(level.gideon,"rec_atlas_shootingrange_gideon_exit");
	var_01 = getnode("shooting_range_wait_to_exit","targetname");
	level.gideon.goalradius = 64;
	level.gideon setgoalnode(var_01);
	common_scripts\utility::flag_wait("shooting_range_stairs_up");
	if(!common_scripts\utility::flag("flag_grenade_range_gideon"))
	{
		param_00 maps\_anim::anim_reach_solo(level.gideon,"rec_shooting_stairs_up_guy01");
	}

	if(!common_scripts\utility::flag("flag_grenade_range_gideon"))
	{
		param_00 maps\_anim::anim_single_solo(level.gideon,"rec_shooting_stairs_up_guy01");
	}

	if(!common_scripts\utility::flag("flag_grenade_range_gideon"))
	{
		level.gideon maps\_utility::enable_ai_color();
		maps\_utility::activate_trigger_with_targetname("colors_post_holo_range");
	}
}

//Function Number: 153
tour_shooting_range_interact_manager()
{
	common_scripts\utility::flag_wait("flag_start_shooting");
	thread maps\recovery_utility::aim_assist_using_bmodels_init();
	var_00 = getentarray("shooting_range_start","targetname");
	common_scripts\utility::array_thread(var_00,::tour_shooting_range_use_triggers);
	var_01 = getent("round01_environment","targetname");
	var_02 = getent("round02_environment","targetname");
	var_03 = getent("round03_environment","targetname");
	var_04 = getent("round01_environment_trans","targetname");
	var_05 = getent("round02_environment_trans","targetname");
	var_06 = getent("round03_environment_trans","targetname");
	var_07 = [getent("round01_target01","targetname"),getent("round01_target02","targetname"),getent("round01_target03","targetname"),getent("round01_target04","targetname"),getent("round01_target05","targetname"),getent("round01_target06","targetname"),getent("round01_target07","targetname"),getent("round01_target08","targetname"),getent("round01_target09","targetname"),getent("round01_target10","targetname")];
	var_08 = [getent("round02_target01","targetname"),getent("round02_target02","targetname"),getent("round02_target03","targetname"),getent("round02_target04","targetname"),getent("round02_target05","targetname"),getent("round02_target06","targetname"),getent("round02_target07","targetname"),getent("round02_target08","targetname"),getent("round02_target09","targetname"),getent("round02_target10","targetname")];
	var_09 = [getent("round03_target01","targetname"),getent("round03_target02","targetname"),getent("round03_target03","targetname"),getent("round03_target04","targetname"),getent("round03_target05","targetname"),getent("round03_target06","targetname"),getent("round03_target07","targetname"),getent("round03_target08","targetname"),getent("round03_target09","targetname"),getent("round03_target10","targetname")];
	var_0A = [getent("round01_target_friendly_01","targetname"),getent("round01_target_friendly_02","targetname"),getent("round01_target_friendly_03","targetname"),getent("round01_target_friendly_04","targetname"),getent("round01_target_friendly_05","targetname"),getent("round01_target_friendly_06","targetname")];
	var_0B = [getent("round02_target_friendly_01","targetname"),getent("round02_target_friendly_02","targetname"),getent("round02_target_friendly_03","targetname"),getent("round02_target_friendly_04","targetname"),getent("round02_target_friendly_05","targetname"),getent("round02_target_friendly_06","targetname")];
	var_0C = [getent("round03_target_friendly_01","targetname"),getent("round03_target_friendly_02","targetname"),getent("round03_target_friendly_03","targetname"),getent("round03_target_friendly_04","targetname"),getent("round03_target_friendly_05","targetname"),getent("round03_target_friendly_06","targetname"),getent("round03_target_friendly_07","targetname"),getent("round03_target_friendly_08","targetname"),getent("round03_target_friendly_09","targetname"),getent("round03_target_friendly_10","targetname"),getent("round03_target_friendly_11","targetname"),getent("round03_target_friendly_12","targetname"),getent("round03_target_friendly_13","targetname")];
	var_0D = common_scripts\utility::array_combine(var_07,var_08);
	var_0D = common_scripts\utility::array_combine(var_0D,var_09);
	var_0E = common_scripts\utility::array_combine(var_0A,var_0B);
	var_0E = common_scripts\utility::array_combine(var_0E,var_0C);
	var_0F = level.player.exoparams["overdrive"].duration;
	for(;;)
	{
		var_01 hide();
		var_01 notsolid();
		var_02 hide();
		var_02 notsolid();
		var_03 hide();
		var_03 notsolid();
		var_04 hide();
		var_04 notsolid();
		var_05 hide();
		var_05 notsolid();
		var_06 hide();
		var_06 notsolid();
		foreach(var_11 in var_0D)
		{
			var_11 hide();
			var_11 notsolid();
			var_11 thermaldrawenable();
		}

		foreach(var_11 in var_0E)
		{
			var_11.team = level.player.team;
			var_11 hide();
			var_11 notsolid();
			var_11 thermaldrawenable();
		}

		common_scripts\utility::flag_wait("flag_shooting_range_start");
		common_scripts\utility::flag_set("shooting_range_started_once");
		common_scripts\utility::flag_set("flag_obj_gun_range_start");
		common_scripts\utility::flag_clear("shooting_range_exited");
		thread maps\recovery_lighting::shooting_range_ramp_down_lighting();
		level.player.exoparams["overdrive"].duration = 5;
		tour_shooting_range_sequence();
		common_scripts\utility::flag_clear("flag_shooting_range_start");
		thread shooting_range_floor_panels_off();
		foreach(var_11 in var_09)
		{
			var_11 hide();
			var_11 notsolid();
		}

		foreach(var_11 in var_0E)
		{
			var_11 hide();
			var_11 notsolid();
		}

		var_01 hide();
		var_01 notsolid();
		var_02 hide();
		var_02 notsolid();
		var_03 hide();
		var_03 notsolid();
		var_04 show();
		var_04 solid();
		var_05 show();
		var_05 solid();
		var_06 show();
		var_06 solid();
		var_04 maps\_utility::delaythread(0.2,::geo_flicker,2);
		var_04 maps\_utility::delaythread(0.5,::geo_flicker,1);
		var_04 maps\_utility::delaythread(0.7,::geo_flicker,1);
		thread maps\recovery_fx::firing_range_kill_glow();
		soundscripts\_snd::snd_music_message("firing_range_deactivating");
		wait(1);
		thread maps\recovery_lighting::shooting_range_ramp_up_lighting();
		var_04 hide();
		var_04 notsolid();
		var_05 hide();
		var_05 notsolid();
		var_06 hide();
		var_06 notsolid();
		maps\recovery_utility::score_manager_force_stop();
		if(!common_scripts\utility::flag("shooting_range_exited"))
		{
			maps\recovery_utility::score_manager_print_final_score("holo_range");
		}

		give_overdrive_battery(1);
		wait(2.5);
		level.player.exoparams["overdrive"].duration = var_0F;
		if(!common_scripts\utility::flag("shooting_range_exited"))
		{
			level.shootingrangeleaderboard maps\recovery_utility::leaderboard_record("player",level.score_keeper.count);
			level.shootingrangeleaderboard maps\recovery_utility::leaderboard_screen_update();
		}

		common_scripts\utility::flag_set("shooting_range_completed_once");
		common_scripts\utility::flag_set("flag_obj_gun_range_complete");
		thread maps\_utility::autosave_by_name();
	}
}

//Function Number: 154
overdrive_reset()
{
	if(level.player maps\_player_exo::overdrive_is_on())
	{
		var_00 = 0.1;
		level.player maps\_player_exo::overdrive_force_stop(var_00);
		wait(var_00);
		wait(0.5);
	}

	level.player maps\_player_exo::overdrive_force_cooldown(1);
}

//Function Number: 155
shooting_range_floor_panels_on()
{
	var_00 = getentarray("holo_emitter_floor","targetname");
	soundscripts\_snd::snd_message("shooting_range_panels_up",var_00);
	foreach(var_02 in var_00)
	{
		if(common_scripts\utility::flag("flag_shooting_range_start"))
		{
			var_03 = randomfloatrange(0,2.5);
			var_04 = 0.5;
			var_02 common_scripts\utility::delaycall(var_03,::moveto,(var_02.origin[0],var_02.origin[1],-137),var_04,0.1,0.1);
			var_02 common_scripts\utility::delaycall(var_03 + var_04,::setmodel,"rec_holo_emitter_floor_on");
		}
	}
}

//Function Number: 156
shooting_range_floor_panels_off()
{
	var_00 = getentarray("holo_emitter_floor","targetname");
	soundscripts\_snd::snd_message("shooting_range_panels_down",var_00);
	foreach(var_02 in var_00)
	{
		if(!common_scripts\utility::flag("flag_shooting_range_start"))
		{
			var_03 = randomfloatrange(0,2.5);
			var_04 = 0.5;
			var_02 common_scripts\utility::delaycall(var_03,::moveto,(var_02.origin[0],var_02.origin[1],-141),var_04,0.2,0.2);
			var_02 common_scripts\utility::delaycall(var_03 + var_04,::setmodel,"rec_holo_emitter_floor_off");
		}
	}
}

//Function Number: 157
tour_shooting_range_screen_info_update_handler()
{
	if(!isdefined(level.score_keeper.stats))
	{
		level.score_keeper.stats = spawnstruct();
	}

	level.score_keeper endon("score_manager_timed_out");
	var_00 = level.score_keeper.stats;
	var_00.enemy_kills = 0;
	var_00.enemy_headshots = 0;
	var_00.enemy_chestshots = 0;
	var_00.enemy_armshots = 0;
	var_00.enemy_legshots = 0;
	var_00.civ_kills = 0;
	var_00.civ_headshots = 0;
	var_00.civ_chestshots = 0;
	var_00.civ_legshots = 0;
	var_00.civ_armshots = 0;
	for(;;)
	{
		setomnvar("ui_recovery_screen_score",level.score_keeper.count);
		setomnvar("ui_recovery_screen_headshots_e",var_00.enemy_headshots);
		setomnvar("ui_recovery_screen_chestShots_e",var_00.enemy_chestshots);
		setomnvar("ui_recovery_screen_armShots_e",var_00.enemy_armshots);
		setomnvar("ui_recovery_screen_legShots_e",var_00.enemy_legshots);
		setomnvar("ui_recovery_screen_headshots_c",var_00.civ_headshots);
		setomnvar("ui_recovery_screen_chestShots_c",var_00.civ_chestshots);
		setomnvar("ui_recovery_screen_armShots_c",var_00.civ_armshots);
		setomnvar("ui_recovery_screen_legShots_c",var_00.civ_legshots);
		level.score_keeper waittill("score_change");
	}
}

//Function Number: 158
tour_shooting_range_screen_toggle()
{
	for(;;)
	{
		common_scripts\utility::flag_wait("player_inside_shooting_range");
		setomnvar("ui_recovery_screen_grenade_range",0);
		setomnvar("ui_recovery_screen_shooting_range",1);
		common_scripts\utility::flag_waitopen("player_inside_shooting_range");
		setomnvar("ui_recovery_screen_shooting_range",0);
	}
}

//Function Number: 159
tour_shooting_range_sequence()
{
	level endon("shooting_range_exited");
	clear_overdrive_battery();
	var_00 = getent("round01_environment","targetname");
	var_01 = getent("round02_environment","targetname");
	var_02 = getent("round03_environment","targetname");
	var_03 = getent("round01_environment_trans","targetname");
	var_04 = getent("round02_environment_trans","targetname");
	var_05 = getent("round03_environment_trans","targetname");
	var_06 = [getent("round01_target01","targetname"),getent("round01_target02","targetname"),getent("round01_target03","targetname"),getent("round01_target04","targetname"),getent("round01_target05","targetname"),getent("round01_target06","targetname"),getent("round01_target07","targetname"),getent("round01_target08","targetname"),getent("round01_target09","targetname"),getent("round01_target10","targetname")];
	var_07 = [getent("round02_target01","targetname"),getent("round02_target02","targetname"),getent("round02_target03","targetname"),getent("round02_target04","targetname"),getent("round02_target05","targetname"),getent("round02_target06","targetname"),getent("round02_target07","targetname"),getent("round02_target08","targetname"),getent("round02_target09","targetname"),getent("round02_target10","targetname")];
	var_08 = [getent("round03_target01","targetname"),getent("round03_target02","targetname"),getent("round03_target03","targetname"),getent("round03_target04","targetname"),getent("round03_target05","targetname"),getent("round03_target06","targetname"),getent("round03_target07","targetname"),getent("round03_target08","targetname"),getent("round03_target09","targetname"),getent("round03_target10","targetname")];
	var_09 = [getent("round01_target_friendly_01","targetname"),getent("round01_target_friendly_02","targetname"),getent("round01_target_friendly_03","targetname"),getent("round01_target_friendly_04","targetname"),getent("round01_target_friendly_05","targetname"),getent("round01_target_friendly_06","targetname")];
	var_0A = [getent("round02_target_friendly_01","targetname"),getent("round02_target_friendly_02","targetname"),getent("round02_target_friendly_03","targetname"),getent("round02_target_friendly_04","targetname"),getent("round02_target_friendly_05","targetname"),getent("round02_target_friendly_06","targetname")];
	var_0B = [getent("round03_target_friendly_01","targetname"),getent("round03_target_friendly_02","targetname"),getent("round03_target_friendly_03","targetname"),getent("round03_target_friendly_04","targetname"),getent("round03_target_friendly_05","targetname"),getent("round03_target_friendly_06","targetname"),getent("round03_target_friendly_07","targetname"),getent("round03_target_friendly_08","targetname"),getent("round03_target_friendly_09","targetname"),getent("round03_target_friendly_10","targetname"),getent("round03_target_friendly_11","targetname"),getent("round03_target_friendly_12","targetname"),getent("round03_target_friendly_13","targetname")];
	var_0C = common_scripts\utility::array_combine(var_06,var_07);
	var_0C = common_scripts\utility::array_combine(var_0C,var_08);
	var_0D = common_scripts\utility::array_combine(var_09,var_0A);
	var_0D = common_scripts\utility::array_combine(var_0D,var_0B);
	maps\recovery_utility::score_manager_init(var_06.size + var_07.size + var_08.size);
	childthread tour_shooting_range_screen_info_update_handler();
	var_03 show();
	var_03 solid();
	soundscripts\_snd::snd_message("shooting_range_transition1",var_03);
	var_03 maps\_utility::delaythread(0.2,::geo_flicker,2);
	var_03 maps\_utility::delaythread(0.5,::geo_flicker,1);
	var_03 maps\_utility::delaythread(0.7,::geo_flicker,1);
	thread maps\recovery_fx::firing_range_round_1_glow();
	soundscripts\_snd::snd_music_message("firing_range_activating");
	wait(1);
	var_00 show();
	var_00 solid();
	wait 0.05;
	wait 0.05;
	wait 0.05;
	var_03 hide();
	var_03 notsolid();
	thread shooting_range_floor_panels_on();
	common_scripts\utility::flag_set("flag_vo_shooting_range_computer_activate");
	wait(2);
	common_scripts\utility::flag_set("flag_vo_shooting_range_computer_begin");
	wait(3);
	common_scripts\utility::array_thread(var_0C,::maps\recovery_utility::score_manager_detect_damage,1,1);
	common_scripts\utility::array_thread(var_0D,::maps\recovery_utility::score_manager_detect_damage,1,0);
	var_0E = 4;
	var_06[0] thread target_lifetime(4,0,"none",0);
	wait(1.5);
	var_06[1] thread target_lifetime(4,0,"none",0);
	wait(0.5);
	var_09[0] thread target_lifetime(4,0,"none",1);
	wait(1.5);
	var_06[2] thread target_lifetime(4,0,"none",0);
	wait(1.5);
	var_06[3] thread target_lifetime(4,0,"none",0);
	wait(0.5);
	var_09[1] thread target_lifetime(4,0,"none",1);
	wait(1.5);
	var_06[4] thread target_lifetime(4,0,"none",0);
	wait(2);
	if(!common_scripts\utility::flag("flag_enable_overdrive"))
	{
		common_scripts\utility::flag_set("flag_enable_overdrive");
	}

	give_overdrive_battery();
	common_scripts\utility::flag_set("flag_vo_shooting_range_overdrive_ready");
	level.player.showhint = 1;
	thread maps\_utility::display_hint_timeout("overdrive_prompt",3);
	wait(1.5);
	var_06[5] thread target_lifetime(4,0,"none",0);
	wait(0.5);
	var_06[6] thread target_lifetime(4,0,"none",0);
	wait(0.5);
	var_09[2] thread target_lifetime(4,0,"none",1);
	wait(0.5);
	var_09[3] thread target_lifetime(4,0,"none",1);
	wait(0.5);
	var_06[7] thread target_lifetime(4,0,"none",0);
	wait(0.5);
	var_09[4] thread target_lifetime(4,0,"none",1);
	wait(0.5);
	var_09[5] thread target_lifetime(4,0,"none",1);
	wait(0.5);
	var_06[8] thread target_lifetime(4,0,"none",0);
	wait(0.5);
	var_06[9] thread target_lifetime(4,0,"none",0);
	wait(3);
	wait(0.5);
	foreach(var_10 in var_06)
	{
		var_10 hide();
		var_10 notsolid();
	}

	wait(1);
	level.player.showhint = 0;
	var_04 show();
	var_04 solid();
	soundscripts\_snd::snd_message("shooting_range_transition2",var_04);
	var_04 maps\_utility::delaythread(0.2,::geo_flicker,2);
	var_04 maps\_utility::delaythread(0.5,::geo_flicker,1);
	var_04 maps\_utility::delaythread(0.7,::geo_flicker,1);
	thread maps\recovery_fx::firing_range_round_2_glow();
	wait(1);
	var_01 show();
	var_01 solid();
	wait 0.05;
	wait 0.05;
	wait 0.05;
	var_04 hide();
	var_04 notsolid();
	common_scripts\utility::flag_set("flag_vo_shooting_range_computer_round_2");
	wait(2);
	var_12 = 3;
	var_0A[0] thread target_lifetime(3.5,0,"none",1);
	wait(0.25);
	var_07[0] thread target_lifetime(var_12,226,"right",0);
	wait(2);
	var_07[1] thread target_lifetime(var_12,0,"none",0);
	wait(2);
	var_07[2] thread target_lifetime(4,518,"right",0);
	wait(2);
	var_07[3] thread target_lifetime(4,518,"left",0);
	wait(2);
	var_07[4] thread target_lifetime(4,518,"right",0);
	wait(2);
	var_07[5] thread target_lifetime(var_12,0,"none",0);
	var_0A[1] thread target_lifetime(3.5,518,"left",1);
	wait(0.2);
	var_07[6] thread target_lifetime(3.5,518,"left",0);
	wait(0.2);
	var_0A[2] thread target_lifetime(3.5,518,"left",1);
	wait(1);
	var_0A[3] thread target_lifetime(3.5,518,"right",1);
	give_overdrive_battery();
	common_scripts\utility::flag_set("flag_vo_shooting_range_overdrive_ready");
	level.player.showhint = 1;
	thread maps\_utility::display_hint_timeout("overdrive_prompt",3);
	wait(1.5);
	var_07[7] thread target_lifetime(3.5,518,"left",0);
	wait(0.5);
	var_0A[4] thread target_lifetime(3.5,518,"right",1);
	wait(2);
	var_07[8] thread target_lifetime(3,518,"left",0);
	var_07[9] thread target_lifetime(3,518,"right",0);
	wait(0.5);
	var_0A[5] thread target_lifetime(2.5,0,"none",1);
	wait(3);
	wait(0.5);
	foreach(var_10 in var_07)
	{
		var_10 hide();
		var_10 notsolid();
	}

	wait(1);
	level.player.showhint = 0;
	var_05 show();
	var_05 solid();
	soundscripts\_snd::snd_message("shooting_range_transition3",var_05);
	var_05 maps\_utility::delaythread(0.2,::geo_flicker,2);
	var_05 maps\_utility::delaythread(0.5,::geo_flicker,1);
	var_05 maps\_utility::delaythread(0.7,::geo_flicker,1);
	thread maps\recovery_fx::firing_range_round_3_glow();
	wait(1);
	var_02 show();
	var_02 solid();
	wait 0.05;
	wait 0.05;
	wait 0.05;
	var_05 hide();
	var_05 notsolid();
	common_scripts\utility::flag_set("flag_vo_shooting_range_computer_round_3");
	wait(2);
	var_15 = 3;
	var_08[0] thread target_lifetime(var_15,504,"right",0);
	wait(2);
	var_08[1] thread target_lifetime(var_15,0,"none",0);
	wait(2);
	var_0B[0] thread target_lifetime(var_15,500,"forward",1);
	wait(2);
	var_08[2] thread target_lifetime(var_15,472,"left",0);
	wait(2);
	var_08[3] thread target_lifetime(var_15,0,"none",0);
	wait(2);
	var_0B[1] thread target_lifetime(var_15,608,"right",1);
	var_08[4] thread target_lifetime(var_15,512,"right",0);
	wait(2.5);
	var_0B[2] thread target_lifetime(var_15,504,"right",1);
	var_08[9] thread target_lifetime(var_15,504,"left",0);
	wait(2.5);
	var_0B[3] thread target_lifetime(var_15,608,"left",1);
	var_08[5] thread target_lifetime(var_15,512,"left",0);
	give_overdrive_battery();
	common_scripts\utility::flag_set("flag_vo_shooting_range_overdrive_ready");
	level.player.showhint = 1;
	thread maps\_utility::display_hint_timeout("overdrive_prompt",3);
	wait(1.5);
	var_0B[4] thread target_lifetime(3,600,"left",1);
	var_08[6] thread target_lifetime(4,600,"left",0);
	wait(0.5);
	var_0B[5] thread target_lifetime(3,600,"left",1);
	wait(0.5);
	var_0B[6] thread target_lifetime(3,600,"left",1);
	var_08[7] thread target_lifetime(4,600,"left",0);
	wait(0.5);
	var_0B[7] thread target_lifetime(3,600,"left",1);
	wait(0.5);
	var_0B[8] thread target_lifetime(3,600,"left",1);
	var_08[8] thread target_lifetime(4,600,"left",0);
	wait(0.5);
	var_0B[9] thread target_lifetime(3,600,"left",1);
	wait(0.5);
	var_0B[10] thread target_lifetime(3,600,"left",1);
	wait(0.5);
	wait(4);
	common_scripts\utility::flag_set("gideon_early_exit_holo_range");
	wait(0.5);
}

//Function Number: 160
clear_overdrive_battery()
{
	maps\_player_exo::batterysetlevel(0);
}

//Function Number: 161
give_overdrive_battery(param_00)
{
	if(isdefined(param_00))
	{
		maps\_player_exo::batteryfillmax();
		return;
	}

	maps\_player_exo::batterysetlevel(level.player.exoparams["overdrive"].battery_cost);
}

//Function Number: 162
waittill_time_or_msg(param_00,param_01)
{
	self endon(param_01);
	wait(param_00);
}

//Function Number: 163
target_lifetime(param_00,param_01,param_02,param_03)
{
	var_04 = self.origin;
	var_05 = self.angles;
	self show();
	self solid();
	thread target_spawn_in(param_03);
	if(param_03)
	{
		soundscripts\_snd::snd_message("shooting_range_friendly_spawn",self);
	}
	else
	{
		soundscripts\_snd::snd_message("shooting_range_enemy_spawn",self);
	}

	if(isdefined(param_03) && !param_03)
	{
		thread target_blink_out(param_00);
		maps\recovery_utility::enable_aim_assist_on_script_model(self,"tag_chest");
		self.maxhealth = 1;
		self setnormalhealth(self.maxhealth);
	}

	if(param_02 == "up")
	{
		self moveto(self.origin + (0,0,param_01),param_00,0,0);
	}

	if(param_02 == "down")
	{
		self moveto(self.origin - (0,0,param_01),param_00,0,0);
	}

	if(param_02 == "forward")
	{
		self moveto(self.origin - (param_01,0,0),param_00,0,0);
	}

	if(param_02 == "backward")
	{
		self moveto(self.origin + (param_01,0,0),param_00,0,0);
	}

	if(param_02 == "left")
	{
		self moveto(self.origin + (0,param_01,0),param_00,0,0);
	}

	if(param_02 == "right")
	{
		self moveto(self.origin - (0,param_01,0),param_00,0,0);
	}

	waittill_time_or_msg(param_00,"target_hit");
	soundscripts\_snd::snd_message("shooting_range_target_despawn");
	thread target_spawn_out(param_03);
	self hide();
	self notsolid();
	if(isdefined(param_03) && !param_03)
	{
		maps\recovery_utility::disable_aim_assist_on_script_model(self);
	}

	wait(0.3);
	self.origin = var_04;
	self.angles = var_05;
}

//Function Number: 164
target_spawn_in(param_00)
{
	if(param_00 == 1)
	{
		playfxontag(common_scripts\utility::getfx("holo_target_green_spawn_in"),self,"tag_origin");
		return;
	}

	playfxontag(common_scripts\utility::getfx("holo_target_red_spawn_in"),self,"tag_origin");
}

//Function Number: 165
target_spawn_out(param_00)
{
	if(param_00 == 1)
	{
		playfxontag(common_scripts\utility::getfx("holo_target_green_spawn_out"),self,"tag_origin");
		return;
	}

	playfxontag(common_scripts\utility::getfx("holo_target_red_spawn_out"),self,"tag_origin");
}

//Function Number: 166
target_blink_out(param_00)
{
	self endon("damage");
	wait(param_00 - 0.3);
	self hide();
	wait 0.05;
	self show();
	wait 0.05;
	self hide();
	wait 0.05;
	self show();
	wait 0.05;
	self hide();
	wait 0.05;
	self show();
	wait 0.05;
}

//Function Number: 167
geo_flicker(param_00)
{
	for(var_01 = 0;var_01 < param_00;var_01++)
	{
		self hide();
		wait 0.05;
		self show();
		wait 0.05;
	}
}

//Function Number: 168
tour_shooting_range_use_triggers()
{
	level endon("training_room_elevator_activated");
	maps\_utility::addhinttrigger(&"RECOVERY_PROMPT_TRAINING_TARGET",&"RECOVERY_PROMPT_TRAINING_TARGET_PC");
	common_scripts\utility::trigger_off();
	common_scripts\utility::flag_wait("flag_shooting_range_playable");
	common_scripts\utility::trigger_on();
	var_00 = maps\_shg_utility::hint_button_trigger("use");
	for(;;)
	{
		common_scripts\utility::flag_wait("flag_shooting_range_start");
		common_scripts\utility::trigger_off();
		var_00 maps\_shg_utility::hint_button_clear();
		common_scripts\utility::flag_waitopen("flag_shooting_range_start");
		wait(3);
		common_scripts\utility::trigger_on();
		var_00 = maps\_shg_utility::hint_button_trigger("use");
	}
}

//Function Number: 169
tour_grenade_range_drone_spawn_with_spawner(param_00)
{
	var_01 = param_00 maps\_vehicle::spawn_vehicle_and_gopath();
	level.score_keeper.max++;
	var_01 thread maps\recovery_utility::score_manager_detect_enemy_death();
	var_01 thread tour_grenade_range_drone_lifetime();
	return var_01;
}

//Function Number: 170
tour_grenade_range_tutorial_drone_spawn_with_spawner(param_00)
{
	var_01 = param_00 maps\_vehicle::spawn_vehicle_and_gopath();
	var_01 soundscripts\_snd::snd_message("attack_drone_flybys_audio");
	var_01 thread tour_grenade_range_drone_lifetime_tutorial();
	return var_01;
}

//Function Number: 171
tour_grenade_range_minigame_drone_spawn_with_spawner(param_00)
{
	var_01 = param_00 maps\_vehicle::spawn_vehicle_and_gopath();
	var_01 soundscripts\_snd::snd_message("attack_drone_flybys_audio");
	var_01 thread tour_grenade_range_drone_lifetime_minigame();
	return var_01;
}

//Function Number: 172
wait_for_threat_grenade()
{
	for(;;)
	{
		level.player waittill("grenade_fire",var_00,var_01);
		if(var_01 == "paint_grenade_var")
		{
			level.player notify("threat_grenade_thrown");
			break;
		}

		wait(0.5);
	}
}

//Function Number: 173
waittill_grenade_damage()
{
	self.hit_type = "none";
	for(;;)
	{
		self waittill("damage",var_00,var_01,var_02,var_03,var_04,var_05,var_06,var_07,var_08,var_09);
		if((var_04 == "MOD_GRENADE" || var_04 == "MOD_EXPLOSIVE" || var_04 == "MOD_GRENADE_SPLASH") && var_00 > 175)
		{
			if(var_04 == "MOD_GRENADE_SPLASH")
			{
				self.hit_type = "indirect";
			}
			else
			{
				self.hit_type = "direct";
			}

			soundscripts\_snd::snd_message("smart_grenade_target_hit");
			break;
		}
		else if(!var_04 == "MOD_GRENADE" || var_04 == "MOD_EXPLOSIVE" || var_04 == "MOD_GRENADE_SPLASH")
		{
			common_scripts\utility::flag_set("flag_vo_grenade_range_grenades_only");
			soundscripts\_snd::snd_message("smart_grenade_target_shot");
		}
	}
}

//Function Number: 174
tour_grenade_range_gideon()
{
	common_scripts\utility::flag_wait("flag_grenade_range_gideon");
	level.gideon maps\_utility::disable_ai_color();
	var_00 = getent("org_anim_grenade_range","targetname");
	var_00 maps\_anim::anim_reach_solo(level.gideon,"rec_aug_threatgrenade_gideon_in");
	common_scripts\utility::flag_set("flag_vo_grenade_range_gideon_intro");
	thread maps\_utility::autosave_by_name();
	var_00 maps\_anim::anim_single_solo(level.gideon,"rec_aug_threatgrenade_gideon_in");
	var_00 thread maps\_anim::anim_loop_solo(level.gideon,"rec_aug_threatgrenade_gideon_idle");
	common_scripts\utility::flag_wait("gideon_early_exit_grenade_range");
	common_scripts\utility::flag_wait("gideon_range_exit_ok");
	var_00 notify("stop_loop");
	var_00 maps\_anim::anim_single_solo_run(level.gideon,"rec_aug_threatgrenade_gideon_out");
	if(!common_scripts\utility::flag("elevator_room_exterior"))
	{
		level.gideon maps\_utility::enable_ai_color();
		maps\_utility::activate_trigger("gideon_exit_grenade_range","targetname");
	}
}

//Function Number: 175
grenade_target_lifetime(param_00)
{
	level endon("flag_grenade_range_start");
	level endon("training_room_elevator_activated");
	var_01 = 0.5;
	var_02 = spawn("script_origin",self.origin + (-49,0,10));
	var_02.script_noteworthy = "tracking_grenade_target";
	var_02 linkto(self);
	thread grenade_target_reset_manager(var_01,var_02);
	self rotateto((0,270,0),var_01);
	soundscripts\_snd::snd_message("smart_grenade_target_flip");
	wait(var_01);
	self setcandamage(1);
	thread grenade_target_movement_manager(param_00);
	waittill_grenade_damage();
	level.grenade_range_container.grenadetargetkills++;
	level.grenade_range_container notify("score_change");
	self notify("hit");
	self setcandamage(0);
	self moveto(self.origin,0.05);
	if(self.hit_type == "direct")
	{
		playfx(level._effect["expround_asphalt_1"],self.origin);
		level notify("grenade_range_point_scored_100");
	}

	if(self.hit_type == "indirect")
	{
		playfx(level._effect["expround_asphalt_1"],self.origin);
		level notify("grenade_range_point_scored_50");
	}

	self rotateto((0,270,90),var_01);
	soundscripts\_snd::snd_message("smart_grenade_target_flip_down");
	if(isdefined(var_02))
	{
		var_02 unlink();
		var_02 delete();
		wait 0.05;
	}
}

//Function Number: 176
grenade_target_movement_manager(param_00)
{
	self endon("hit");
	level endon("flag_grenade_range_start");
	level endon("training_room_elevator_activated");
	var_01 = 100;
	var_02 = abs(param_00 / var_01);
	while(var_02 > 0)
	{
		soundscripts\_snd::snd_message("smart_grenade_target_move",var_02);
		self moveto(self.origin + (0,param_00,0),var_02);
		wait(var_02);
		wait 0.05;
		soundscripts\_snd::snd_message("smart_grenade_target_move_back",var_02);
		self moveto(self.origin - (0,param_00,0),var_02);
		wait(var_02);
		wait 0.05;
	}
}

//Function Number: 177
grenade_target_reset_manager(param_00,param_01)
{
	level endon("training_room_elevator_activated");
	var_02 = self.origin;
	common_scripts\utility::flag_waitopen("flag_grenade_range_start");
	self setcandamage(0);
	self rotateto((0,270,90),param_00);
	soundscripts\_snd::snd_message("smart_grenade_target_expire");
	wait(param_00);
	wait 0.05;
	if(isdefined(param_01))
	{
		param_01 unlink();
		param_01 delete();
		wait 0.05;
	}

	common_scripts\utility::flag_wait("flag_grenade_range_start");
	self.origin = var_02;
}

//Function Number: 178
tour_grenade_range_screen_toggle()
{
	for(;;)
	{
		common_scripts\utility::flag_wait("player_inside_grenade_range");
		setomnvar("ui_recovery_screen_shooting_range",0);
		setomnvar("ui_recovery_screen_grenade_range",1);
		common_scripts\utility::flag_waitopen("player_inside_grenade_range");
		setomnvar("ui_recovery_screen_grenade_range",0);
	}
}

//Function Number: 179
showthreathintagainifplayerisbeingdumb()
{
	level endon("showThreatHintAgainIfPlayerIsBeingDumb_stop");
	for(;;)
	{
		wait(14);
		level.player.showhint = 1;
		if(level.player common_scripts\utility::is_player_gamepad_enabled())
		{
			maps\_utility::delaythread(1,::maps\_utility::display_hint,"threat_prompt");
		}
		else
		{
			maps\_utility::delaythread(1,::maps\_utility::display_hint,"pc_threat_prompt");
		}

		wait_for_threat_grenade();
		level.player.showhint = 0;
	}
}

//Function Number: 180
tour_grenade_range_refills_highlight()
{
	var_00 = getentarray("grenade_range_refills","script_noteworthy");
	for(;;)
	{
		common_scripts\utility::flag_wait("flag_grenade_range_start");
		var_01 = [];
		var_01["r_hudoutlineenable"] = getdvarint("r_hudoutlineenable",1);
		var_01["r_hudoutlinepostmode"] = getdvarint("r_hudoutlinepostmode",0);
		var_01["r_hudoutlinehaloblurradius"] = getdvarfloat("r_hudoutlinehaloblurradius",1);
		var_01["r_hudoutlinehalolumscale"] = getdvarfloat("r_hudoutlinehalolumscale",1);
		setsaveddvar("r_hudoutlineenable",1);
		setsaveddvar("r_hudoutlinepostmode",2);
		setsaveddvar("r_hudoutlinehaloblurradius",0.7);
		setsaveddvar("r_hudoutlinehalolumscale",2);
		foreach(var_03 in var_00)
		{
			var_03 hudoutlineenable(5);
		}

		common_scripts\utility::flag_waitopen("flag_grenade_range_start");
		foreach(var_03 in var_00)
		{
			var_03 hudoutlinedisable();
		}

		setsaveddvar("r_hudoutlineenable",var_01["r_hudoutlineenable"]);
		setsaveddvar("r_hudoutlinepostmode",var_01["r_hudoutlinepostmode"]);
		setsaveddvar("r_hudoutlinehaloblurradius",var_01["r_hudoutlinehaloblurradius"]);
		setsaveddvar("r_hudoutlinehalolumscale",var_01["r_hudoutlinehalolumscale"]);
	}
}

//Function Number: 181
tour_grenade_range_interact_manager()
{
	level endon("training_room_elevator_activated");
	level.grenade_range_container = spawnstruct();
	level.grenade_range_container.maxscore = 100000;
	level.grenade_range_container.currentscore = 0;
	childthread tour_grenade_range_score_manager();
	childthread tour_grenade_range_refills_highlight();
	level.grenaderangeleaderboard = maps\recovery_utility::leaderboard_make(10,"grenade_range");
	var_00 = [getent("grenade_target_01","targetname"),getent("grenade_target_02","targetname"),getent("grenade_target_03","targetname"),getent("grenade_target_04","targetname"),getent("grenade_target_05","targetname"),getent("grenade_target_06","targetname"),getent("grenade_target_07","targetname"),getent("grenade_target_08","targetname"),getent("grenade_target_09","targetname"),getent("grenade_target_10","targetname")];
	var_01 = [getent("grenade_target_moving_01","targetname"),getent("grenade_target_moving_02","targetname"),getent("grenade_target_moving_03","targetname"),getent("grenade_target_moving_04","targetname"),getent("grenade_target_moving_05","targetname"),getent("grenade_target_moving_06","targetname")];
	var_02 = getent("grenade_range_drone_spawner_tutorial_01","targetname");
	var_03 = getent("grenade_range_drone_spawner_tutorial_02","targetname");
	var_04 = getent("grenade_range_drone_spawner_tutorial_03","targetname");
	var_05 = getent("grenade_range_drone_spawner_01a","targetname");
	var_06 = getent("grenade_range_drone_spawner_01b","targetname");
	var_07 = getent("grenade_range_drone_spawner_01c","targetname");
	var_08 = getent("grenade_range_drone_spawner_02a","targetname");
	var_09 = getent("grenade_range_drone_spawner_02b","targetname");
	var_0A = getent("grenade_range_drone_spawner_02c","targetname");
	var_0B = getent("grenade_range_drone_spawner_03a","targetname");
	var_0C = getent("grenade_range_drone_spawner_03b","targetname");
	var_0D = getent("grenade_range_drone_spawner_03c","targetname");
	var_0E = getent("grenade_range_drone_spawner_03d","targetname");
	var_0F = getentarray("grenade_range_start","targetname");
	level.grenade_range_use_triggers = var_0F;
	common_scripts\utility::array_thread(var_0F,::tour_grenade_range_use_triggers);
	var_10 = getentarray("grenade_range_entrance_gate_left","targetname");
	var_11 = getentarray("grenade_range_entrance_gate_right","targetname");
	var_12 = getent("grenade_range_blocker","targetname");
	var_12 notsolid();
	var_12 connectpaths();
	maps\_utility::battlechatter_off("allies");
	common_scripts\utility::flag_wait("flag_grenade_range_start");
	common_scripts\utility::flag_set("flag_obj_grenade_range_tutorial_start");
	common_scripts\utility::flag_set("grenade_range_started_once");
	thread maps\recovery_lighting::setup_lighting_fx_during_mini_games();
	level.player enableoffhandweapons();
	level.player enableoffhandsecondaryweapons();
	var_12 solid();
	foreach(var_14 in var_10)
	{
		var_14 rotateto((0,-90,0),0.75,0.1,0.1);
	}

	foreach(var_14 in var_11)
	{
		var_14 rotateto((0,90,0),0.75,0.1,0.1);
	}

	soundscripts\_snd::snd_music_message("grenade_range_begin_phase1");
	common_scripts\utility::flag_set("flag_vo_grenade_range_gideon_threat");
	level.player.showhint = 1;
	if(level.player common_scripts\utility::is_player_gamepad_enabled())
	{
		maps\_utility::delaythread(1,::maps\_utility::display_hint,"threat_prompt");
	}
	else
	{
		maps\_utility::delaythread(1,::maps\_utility::display_hint,"pc_threat_prompt");
	}

	wait_for_threat_grenade();
	level.player.showhint = 0;
	thread showthreathintagainifplayerisbeingdumb();
	common_scripts\utility::flag_set("flag_vo_grenade_range_bullet_penetration");
	common_scripts\utility::flag_set("flag_obj_grenade_tutorial_threat_complete");
	var_18 = getentarray("threat_tutorial_guy","targetname");
	level.guys = [];
	foreach(var_1A in var_18)
	{
		var_1B = var_1A maps\_utility::spawn_ai(1);
		var_1A.count++;
		var_1B.goalradius = 8;
		var_1B.ignoreall = 1;
		var_1B maps\_utility::enable_dontevershoot();
		var_1B.health = 10;
		var_1B.grenadeawareness = 0;
		level.guys = common_scripts\utility::array_add(level.guys,var_1B);
		var_1B maps\_utility::disable_long_death();
		var_1B maps\_utility::set_battlechatter(0);
	}

	level common_scripts\utility::waittill_either("grenade_range_point_scored_50","grenade_range_point_scored_100");
	level common_scripts\utility::waittill_either("grenade_range_point_scored_50","grenade_range_point_scored_100");
	level notify("showThreatHintAgainIfPlayerIsBeingDumb_stop");
	level.player.showhint = 0;
	wait(1);
	common_scripts\utility::flag_set("flag_vo_grenade_range_gideon_emp");
	level.player.showhint = 1;
	if(level.player common_scripts\utility::is_player_gamepad_enabled())
	{
		maps\_utility::delaythread(1,::maps\_utility::display_hint,"emp_prompt");
	}
	else
	{
		maps\_utility::delaythread(1,::maps\_utility::display_hint,"pc_emp_prompt");
	}

	var_1D = tour_grenade_range_tutorial_drone_spawn_with_spawner(var_02);
	var_1D sethoverparams(0.5,8,1);
	var_1E = tour_grenade_range_tutorial_drone_spawn_with_spawner(var_03);
	var_1E sethoverparams(0.5,8,1);
	wait(1);
	var_1F = tour_grenade_range_tutorial_drone_spawn_with_spawner(var_04);
	var_1F sethoverparams(0.5,8,1);
	level common_scripts\utility::waittill_either("grenade_range_point_scored_50","grenade_range_point_scored_100");
	level common_scripts\utility::waittill_either("grenade_range_point_scored_50","grenade_range_point_scored_100");
	level common_scripts\utility::waittill_either("grenade_range_point_scored_50","grenade_range_point_scored_100");
	level.player.showhint = 0;
	wait(2);
	common_scripts\utility::flag_set("flag_vo_grenade_range_gideon_smart");
	level.player.showhint = 1;
	if(level.player common_scripts\utility::is_player_gamepad_enabled())
	{
		maps\_utility::delaythread(1,::maps\_utility::display_hint,"smart_prompt");
	}
	else
	{
		maps\_utility::delaythread(1,::maps\_utility::display_hint,"pc_smart_prompt");
	}

	var_01[0] maps\_utility::delaythread(0.5,::grenade_target_lifetime,485);
	level common_scripts\utility::waittill_either("grenade_range_point_scored_50","grenade_range_point_scored_100");
	level.player.showhint = 0;
	wait(1);
	common_scripts\utility::flag_set("flag_vo_grenade_range_gideon_again");
	common_scripts\utility::flag_set("flag_obj_grenade_range_tutorial_complete");
	common_scripts\utility::flag_clear("flag_grenade_range_start");
	thread maps\_utility::autosave_by_name();
	thread maps\recovery_lighting::turn_off_lighting_fx_post_mini_games();
	for(;;)
	{
		common_scripts\utility::flag_wait("flag_grenade_range_start");
		common_scripts\utility::flag_set("flag_obj_grenade_range_minigame_start");
		maps\_utility::battlechatter_off("allies");
		tour_grenade_range_minigame_sequence();
		maps\_utility::battlechatter_on("allies");
		foreach(var_1B in level.guys)
		{
			if(isdefined(var_1B))
			{
				var_1B delete();
			}
		}

		var_12 notsolid();
		foreach(var_14 in var_10)
		{
			var_14 rotateto((0,359,0),0.75,0.1,0.1);
		}

		foreach(var_14 in var_11)
		{
			var_14 rotateto((0,1,0),0.75,0.1,0.1);
		}

		thread maps\recovery_lighting::turn_off_lighting_fx_post_mini_games();
		soundscripts\_snd::snd_music_message("grenade_range_end_phase2");
		common_scripts\utility::flag_clear("flag_grenade_range_start");
		thread maps\_utility::autosave_by_name();
	}
}

//Function Number: 182
tour_grenade_range_minigame_sequence()
{
	level endon("player_inside_grenade_range");
	var_00 = [getent("grenade_target_01","targetname"),getent("grenade_target_02","targetname"),getent("grenade_target_03","targetname"),getent("grenade_target_04","targetname"),getent("grenade_target_05","targetname"),getent("grenade_target_06","targetname"),getent("grenade_target_07","targetname"),getent("grenade_target_08","targetname"),getent("grenade_target_09","targetname"),getent("grenade_target_10","targetname")];
	var_01 = [getent("grenade_target_moving_01","targetname"),getent("grenade_target_moving_02","targetname"),getent("grenade_target_moving_03","targetname"),getent("grenade_target_moving_04","targetname"),getent("grenade_target_moving_05","targetname"),getent("grenade_target_moving_06","targetname")];
	var_02 = getent("grenade_range_drone_spawner_tutorial_01","targetname");
	var_03 = getent("grenade_range_drone_spawner_tutorial_02","targetname");
	var_04 = getent("grenade_range_drone_spawner_tutorial_03","targetname");
	var_05 = getent("grenade_range_drone_spawner_01a","targetname");
	var_06 = getent("grenade_range_drone_spawner_01b","targetname");
	var_07 = getent("grenade_range_drone_spawner_01c","targetname");
	var_08 = getent("grenade_range_drone_spawner_02a","targetname");
	var_09 = getent("grenade_range_drone_spawner_02b","targetname");
	var_0A = getent("grenade_range_drone_spawner_02c","targetname");
	var_0B = getent("grenade_range_drone_spawner_03a","targetname");
	var_0C = getent("grenade_range_drone_spawner_03b","targetname");
	var_0D = getent("grenade_range_drone_spawner_03c","targetname");
	var_0E = getent("grenade_range_drone_spawner_03d","targetname");
	var_0F = getentarray("threat_minigame_guy_wave_1","targetname");
	var_10 = getentarray("threat_minigame_guy_wave_2","targetname");
	level.guys = [];
	thread maps\recovery_lighting::setup_lighting_fx_during_mini_games();
	clearallcorpses();
	tour_grenade_range_score_reset();
	common_scripts\utility::flag_set("flag_vo_grenade_range_computer_activate");
	wait(2);
	common_scripts\utility::flag_set("flag_vo_grenade_range_computer_begin");
	soundscripts\_snd::snd_music_message("grenade_range_begin_phase2");
	foreach(var_12 in var_0F)
	{
		var_13 = var_12 maps\_utility::spawn_ai(1);
		var_12.count++;
		var_13.goalradius = 8;
		var_13.ignoreall = 1;
		var_13 maps\_utility::enable_dontevershoot();
		var_13.health = 10;
		var_13.grenadeawareness = 0;
		level.guys = common_scripts\utility::array_add(level.guys,var_13);
		var_13 maps\_utility::set_battlechatter(0);
	}

	wait(3);
	var_00[4] maps\_utility::delaythread(0,::grenade_target_lifetime,0);
	var_01[5] maps\_utility::delaythread(0.75,::grenade_target_lifetime,-261);
	wait(4);
	var_15 = maps\_utility::delaythread(0,::tour_grenade_range_minigame_drone_spawn_with_spawner,var_05);
	var_16 = maps\_utility::delaythread(0.3,::tour_grenade_range_minigame_drone_spawn_with_spawner,var_06);
	var_17 = maps\_utility::delaythread(0.6,::tour_grenade_range_minigame_drone_spawn_with_spawner,var_07);
	wait(5);
	var_01[2] maps\_utility::delaythread(0.75,::grenade_target_lifetime,261);
	wait(4);
	foreach(var_12 in var_10)
	{
		var_13 = var_12 maps\_utility::spawn_ai(1);
		var_12.count++;
		var_13.goalradius = 8;
		var_13.ignoreall = 1;
		var_13 maps\_utility::enable_dontevershoot();
		var_13.health = 10;
		var_13.grenadeawareness = 0;
		level.guys = common_scripts\utility::array_add(level.guys,var_13);
		var_13 maps\_utility::set_battlechatter(0);
	}

	common_scripts\utility::flag_set("flag_vo_grenade_range_threat_2");
	wait(2);
	var_1A = maps\_utility::delaythread(0,::tour_grenade_range_minigame_drone_spawn_with_spawner,var_08);
	var_1B = maps\_utility::delaythread(0.3,::tour_grenade_range_minigame_drone_spawn_with_spawner,var_09);
	wait(4);
	var_00[9] maps\_utility::delaythread(0,::grenade_target_lifetime,0);
	wait(6);
	var_1C = maps\_utility::delaythread(0,::tour_grenade_range_minigame_drone_spawn_with_spawner,var_0B);
	var_1D = maps\_utility::delaythread(0.3,::tour_grenade_range_minigame_drone_spawn_with_spawner,var_0C);
	var_1E = maps\_utility::delaythread(0.6,::tour_grenade_range_minigame_drone_spawn_with_spawner,var_0D);
	var_1F = maps\_utility::delaythread(0.6,::tour_grenade_range_minigame_drone_spawn_with_spawner,var_0E);
	wait(3);
	var_01[1] maps\_utility::delaythread(0.5,::grenade_target_lifetime,-485);
	wait(5);
	common_scripts\utility::flag_set("gideon_early_exit_grenade_range");
	wait(5);
	common_scripts\utility::flag_clear("flag_grenade_range_start");
	wait(1);
	tour_grenade_range_score_feedback();
	level.grenaderangeleaderboard maps\recovery_utility::leaderboard_record("player",level.grenade_range_container.currentscore);
	level.grenaderangeleaderboard maps\recovery_utility::leaderboard_screen_update();
	common_scripts\utility::flag_set("grenade_range_completed_once");
	common_scripts\utility::flag_set("flag_obj_grenade_range_minigame_complete");
}

//Function Number: 183
tour_grenade_range_screen_info_update()
{
	for(;;)
	{
		setomnvar("ui_recovery_screen_score",level.grenade_range_container.currentscore);
		setomnvar("ui_recovery_screen_kills_drones",level.grenade_range_container.dronekills);
		setomnvar("ui_recovery_screen_kills_ai",level.grenade_range_container.aikills);
		setomnvar("ui_recovery_screen_kills_grenadeTargets",level.grenade_range_container.grenadetargetkills);
		level.grenade_range_container waittill("score_change");
	}
}

//Function Number: 184
tour_grenade_range_score_reset()
{
	level.grenade_range_container.currentscore = 0;
	level.grenade_range_container.dronekills = 0;
	level.grenade_range_container.aikills = 0;
	level.grenade_range_container.grenadetargetkills = 0;
	level.grenade_range_container notify("score_change");
}

//Function Number: 185
tour_grenade_range_score_manager()
{
	tour_grenade_range_score_reset();
	childthread tour_grenade_range_screen_info_update();
	for(;;)
	{
		var_00 = level common_scripts\utility::waittill_any_return("grenade_range_point_scored_50","grenade_range_point_scored_100");
		if(var_00 == "grenade_range_point_scored_50")
		{
			level.grenade_range_container.currentscore = level.grenade_range_container.currentscore + 50;
		}

		if(var_00 == "grenade_range_point_scored_100")
		{
			level.grenade_range_container.currentscore = level.grenade_range_container.currentscore + 100;
		}
	}
}

//Function Number: 186
tour_grenade_range_score_feedback()
{
	if(level.grenade_range_container.currentscore < 500)
	{
		common_scripts\utility::flag_set("flag_vo_grenade_range_result_bad");
	}

	if(level.grenade_range_container.currentscore >= 500 && level.grenade_range_container.currentscore < 1200)
	{
		common_scripts\utility::flag_set("flag_vo_grenade_range_result_average");
	}

	if(level.grenade_range_container.currentscore >= 1200 && level.grenade_range_container.currentscore < 1600)
	{
		common_scripts\utility::flag_set("flag_vo_grenade_range_result_good");
	}

	if(level.grenade_range_container.currentscore >= 1600 && level.grenade_range_container.currentscore < 2000)
	{
		common_scripts\utility::flag_set("flag_vo_grenade_range_result_excellent");
	}

	if(level.grenade_range_container.currentscore >= 2000)
	{
		common_scripts\utility::flag_set("flag_vo_grenade_range_result_perfect");
	}

	if(level.grenade_range_container.currentscore >= 1600)
	{
		maps\_utility::giveachievement_wrapper("LEVEL_2B");
	}
}

//Function Number: 187
tour_grenade_range_use_triggers()
{
	level endon("training_room_elevator_activated");
	maps\_utility::addhinttrigger(&"RECOVERY_PROMPT_ACTIVATE",&"RECOVERY_PROMPT_ACTIVATE_PC");
	common_scripts\utility::trigger_off();
	common_scripts\utility::flag_wait("flag_obj_grenade_range_pre_2");
	common_scripts\utility::trigger_on();
	var_00 = maps\_shg_utility::hint_button_trigger("use");
	self.button = var_00;
	for(;;)
	{
		common_scripts\utility::flag_wait("flag_grenade_range_start");
		common_scripts\utility::trigger_off();
		var_00 maps\_shg_utility::hint_button_clear();
		common_scripts\utility::flag_waitopen("flag_grenade_range_start");
		wait(4);
		common_scripts\utility::flag_waitopen("game_saving");
		common_scripts\utility::trigger_on();
		var_00 = maps\_shg_utility::hint_button_trigger("use");
		maps\_utility::addhinttrigger(&"RECOVERY_PROMPT_TRAINING_GRENADE",&"RECOVERY_PROMPT_TRAINING_GRENADE_PC");
	}
}

//Function Number: 188
tour_grenade_range_drone_lifetime()
{
	self.health = 50;
	self.pacifist = 1;
	self.ignoreme = 1;
	self.ignoreall = 1;
	maps\_utility::set_goalradius(4);
	thread maps\_shg_utility::make_emp_vulnerable();
	self waittill("reached_dynamic_path_end");
	maps\_utility::vehicle_land();
	self notify("score_manager_detect_enemy_death_stop");
	if(isdefined(self))
	{
		self delete();
	}
}

//Function Number: 189
tour_grenade_range_drone_lifetime_tutorial()
{
	self.pacifist = 1;
	self.ignoreme = 1;
	self.ignoreall = 1;
	maps\_utility::set_goalradius(4);
	thread maps\_shg_utility::make_emp_vulnerable();
	self waittill("reached_dynamic_path_end");
}

//Function Number: 190
tour_grenade_range_drone_lifetime_minigame()
{
	self.pacifist = 1;
	self.ignoreme = 1;
	self.ignoreall = 1;
	maps\_utility::set_goalradius(4);
	thread maps\_shg_utility::make_emp_vulnerable();
	self waittill("reached_dynamic_path_end");
	maps\_utility::vehicle_land();
	self notify("no_score");
	self delete();
}

//Function Number: 191
disable_grenade_range_triggers()
{
	foreach(var_01 in level.grenade_range_use_triggers)
	{
		var_01 common_scripts\utility::trigger_off();
		if(isdefined(var_01.button))
		{
			var_01.button maps\_shg_utility::hint_button_clear();
		}
	}
}

//Function Number: 192
enable_grenade_range_triggers()
{
	foreach(var_01 in level.grenade_range_use_triggers)
	{
		var_01 common_scripts\utility::trigger_on();
		if(!isdefined(var_01.button))
		{
			var_01.button = var_01 maps\_shg_utility::hint_button_trigger("use");
		}
	}
}

//Function Number: 193
tour_drone_control()
{
	disable_grenade_range_triggers();
	var_00 = vehicle_scripts\_pdrone_player::pdrone_player_spawn("tour_pdrone","tour_drone_range_space",60,2.5);
	level.player.drone = var_00;
	var_00 vehicle_scripts\_pdrone_player::pdrone_player_add_ent_target("targetname","drone_target");
	var_00 vehicle_scripts\_pdrone_player::pdrone_orient_to_closest_ent_target();
	var_00 vehicle_scripts\_pdrone_player::pdrone_player_enter();
	soundscripts\_snd::snd_message("rec_player_drone_start",var_00);
	var_00 vehicle_scripts\_pdrone_player::pdrone_player_loop();
	level notify("flag_vo_drone_training_exit");
	soundscripts\_snd::snd_message("rec_player_drone_end");
	var_00 vehicle_scripts\_pdrone_player::pdrone_player_exit();
	var_00 delete();
	maps\recovery_utility::score_manager_force_stop();
	enable_grenade_range_triggers();
}

//Function Number: 194
drone_range_target_manage_hit()
{
	self waittill("target_hit");
	self notify("fake_death");
	self hide();
	self notsolid();
	if(isdefined(self.target))
	{
		var_00 = getent(self.target,"targetname");
		var_00 notsolid();
		var_00 connectpaths();
	}
}

//Function Number: 195
tour_drone_range_interact_manager()
{
	level.dronerangeleaderboard = maps\recovery_utility::leaderboard_make(10,"drone_range",1);
	thread tour_drone_range_targets();
	thread tour_drone_range_timer();
	var_00 = getent("drone_range_start_2","targetname");
	var_00 thread tour_drone_range_use_triggers();
	var_01 = [getent("grenade_target_01","targetname"),getent("grenade_target_02","targetname"),getent("grenade_target_03","targetname"),getent("grenade_target_04","targetname"),getent("grenade_target_05","targetname"),getent("grenade_target_06","targetname"),getent("grenade_target_07","targetname"),getent("grenade_target_08","targetname"),getent("grenade_target_09","targetname"),getent("grenade_target_10","targetname")];
	var_02 = [getent("grenade_target_moving_01","targetname"),getent("grenade_target_moving_02","targetname"),getent("grenade_target_moving_03","targetname"),getent("grenade_target_moving_04","targetname"),getent("grenade_target_moving_05","targetname"),getent("grenade_target_moving_06","targetname")];
	var_03 = common_scripts\utility::array_combine(var_01,var_02);
	var_04 = getentarray("drone_barrier","targetname");
	wait(1);
	foreach(var_06 in var_04)
	{
		var_06 hide();
		var_06 notsolid();
		var_06 connectpaths();
	}

	for(;;)
	{
		common_scripts\utility::flag_wait("flag_drone_range_start");
		clearallcorpses();
		foreach(var_09 in var_03)
		{
			var_09 hide();
			var_09 notsolid();
		}

		foreach(var_06 in var_04)
		{
			var_06 show();
			var_06 solid();
		}

		thread maps\_introscreen::introscreen_generic_fade_in("black",0.4,0.4);
		thread maps\recovery_lighting::setup_lighting_fly_drone();
		var_0D = getentarray("drone_target","targetname");
		maps\recovery_utility::score_manager_init(var_0D.size);
		common_scripts\utility::array_thread(var_0D,::maps\recovery_utility::score_manager_detect_damage);
		common_scripts\utility::array_thread(var_0D,::drone_range_target_manage_hit);
		thread tour_drone_control();
		maps\recovery_utility::score_manager_waittill_timeout_or_maxscore(60);
		level.player.drone vehicle_scripts\_pdrone_player::pdrone_player_force_exit();
		thread maps\recovery_lighting::setup_lighting_fly_drone_off();
		foreach(var_09 in var_03)
		{
			var_09 common_scripts\utility::delaycall(0.4,::show);
			var_09 solid();
		}

		foreach(var_06 in var_04)
		{
			var_06 common_scripts\utility::delaycall(0.4,::hide);
			var_06 notsolid();
		}

		if(level.score_keeper.count == 10)
		{
			maps\recovery_utility::score_manager_print_final_score("drone_range");
			level.dronerangeleaderboard maps\recovery_utility::leaderboard_record("player",level.score_keeper.time);
			level.dronerangeleaderboard maps\recovery_utility::leaderboard_screen_update();
			level notify("flag_vo_drone_training_complete");
		}

		common_scripts\utility::flag_clear("flag_drone_range_start");
		level.player allowsprint(0);
		var_00 thread tour_drone_interact_clear();
		thread maps\_utility::autosave_by_name();
	}
}

//Function Number: 196
tour_drone_interact_clear()
{
	common_scripts\utility::flag_clear(self.script_flag);
}

//Function Number: 197
tour_drone_range_use_triggers()
{
	level endon("training_room_elevator_activated");
	common_scripts\utility::trigger_off();
	common_scripts\utility::flag_wait("grenade_range_completed_once");
	common_scripts\utility::trigger_on();
	var_00 = maps\_shg_utility::hint_button_trigger("use");
	maps\_utility::addhinttrigger(&"RECOVERY_PROMPT_TRAINING_DRONE",&"RECOVERY_PROMPT_TRAINING_DRONE_PC");
	for(;;)
	{
		var_01 = common_scripts\utility::flag_wait_either_return(self.script_flag,"flag_grenade_range_start");
		common_scripts\utility::trigger_off();
		var_00 maps\_shg_utility::hint_button_clear();
		if(var_01 == self.script_flag)
		{
			common_scripts\utility::flag_set("flag_drone_range_start");
			common_scripts\utility::flag_waitopen(self.script_flag);
			common_scripts\utility::flag_clear("flag_drone_range_start");
		}

		if(var_01 == "flag_grenade_range_start")
		{
			common_scripts\utility::flag_waitopen("flag_grenade_range_start");
		}

		common_scripts\utility::flag_waitopen("game_saving");
		common_scripts\utility::trigger_on();
		var_00 = maps\_shg_utility::hint_button_trigger("use");
	}
}

//Function Number: 198
tour_drone_range_targets()
{
	level endon("training_room_elevator_activated");
	var_00 = getentarray("drone_target","targetname");
	thread maps\recovery_utility::aim_assist_using_bmodels_init();
	foreach(var_02 in var_00)
	{
		var_02.maxhealth = 1000;
		var_02.health = var_02.maxhealth;
		var_02 setnormalhealth(var_02.maxhealth);
		var_02 thread tour_drone_range_target_lifetime();
	}

	for(;;)
	{
		foreach(var_05 in var_00)
		{
			var_05 hide();
			var_05 notsolid();
			if(isdefined(var_05.target))
			{
				var_06 = getent(var_05.target,"targetname");
				var_06 notsolid();
				var_06 connectpaths();
			}
		}

		common_scripts\utility::flag_wait("flag_drone_range_start");
		foreach(var_05 in var_00)
		{
			var_05 show();
			var_05 solid();
			if(isdefined(var_05.target))
			{
				var_06 = getent(var_05.target,"targetname");
				var_06 solid();
				var_06 disconnectpaths();
			}
		}

		common_scripts\utility::flag_waitopen("flag_drone_range_start");
	}
}

//Function Number: 199
tour_drone_range_target_lifetime()
{
	level endon("training_room_elevator_activated");
}

//Function Number: 200
tour_drone_range_timer()
{
	level endon("training_room_elevator_activated");
	for(;;)
	{
		common_scripts\utility::flag_wait("flag_drone_range_start");
		level.score_keeper.time = 0;
		while(common_scripts\utility::flag("flag_drone_range_start"))
		{
			wait(1);
			level.score_keeper.time = level.score_keeper.time + 1;
			var_00 = 60 - level.score_keeper.time;
		}
	}
}

//Function Number: 201
tour_variable_grenade_refill_manager()
{
	var_00 = getentarray("grenade_box_tour","targetname");
	var_01 = getentarray("grenade_model_tour","targetname");
	var_02 = common_scripts\utility::array_combine(var_00,var_01);
	foreach(var_04 in var_02)
	{
		var_04 hide();
	}

	level endon("training_room_elevator_activated");
	var_06 = getentarray("variable_grenade_refill","targetname");
	common_scripts\utility::flag_wait("shooting_range_completed_once");
	foreach(var_04 in var_02)
	{
		var_04 show();
	}

	thread tour_variable_grenade_auto_fill();
}

//Function Number: 202
tour_variable_grenade_initial_acquisition()
{
	level endon("variable_grenades_acquired_initial");
	self waittill("trigger");
	level notify("variable_grenades_acquired_initial");
}

//Function Number: 203
tour_variable_grenade_auto_fill()
{
	level endon("training_room_elevator_activated");
	level waittill("flag_grenade_range_start");
	var_00 = 0;
	var_00 = var_00 + level.player setweaponammostock("flash_grenade_var");
	var_00 = var_00 + level.player setweaponammostock("emp_grenade_var");
	var_00 = var_00 + level.player setweaponammostock("paint_grenade_var");
	var_00 = var_00 + level.player setweaponammostock("frag_grenade_var");
	var_00 = var_00 + level.player setweaponammostock("contact_grenade_var");
	var_00 = var_00 + level.player setweaponammostock("tracking_grenade_var");
	var_00 = var_00 / 3;
	maps\_variable_grenade::give_player_variable_grenade();
	level.player givemaxammo("frag_grenade_var");
	level.player givemaxammo("contact_grenade_var");
	level.player givemaxammo("tracking_grenade_var");
	level.player givemaxammo("flash_grenade_var");
	level.player givemaxammo("emp_grenade_var");
	level.player givemaxammo("paint_grenade_var");
	level.player playsound("grenade_pickup");
	for(;;)
	{
		common_scripts\utility::flag_wait("variable_grenade_refill");
		var_00 = 0;
		var_00 = var_00 + level.player setweaponammostock("flash_grenade_var");
		var_00 = var_00 + level.player setweaponammostock("emp_grenade_var");
		var_00 = var_00 + level.player setweaponammostock("paint_grenade_var");
		var_00 = var_00 + level.player setweaponammostock("frag_grenade_var");
		var_00 = var_00 + level.player setweaponammostock("contact_grenade_var");
		var_00 = var_00 + level.player setweaponammostock("tracking_grenade_var");
		var_00 = var_00 / 3;
		maps\_variable_grenade::give_player_variable_grenade();
		if(var_00 < 8)
		{
			level.player givemaxammo("frag_grenade_var");
			level.player givemaxammo("contact_grenade_var");
			level.player givemaxammo("tracking_grenade_var");
			level.player givemaxammo("flash_grenade_var");
			level.player givemaxammo("emp_grenade_var");
			level.player givemaxammo("paint_grenade_var");
			level.player playsound("grenade_pickup");
		}

		common_scripts\utility::flag_waitopen("variable_grenade_refill");
	}
}

//Function Number: 204
toggle_grenade_range_settings()
{
	for(;;)
	{
		var_00 = level.player.detection_grenade_duration;
		var_01 = level.gideon.ignoreall;
		common_scripts\utility::flag_wait("tour_grenade_range");
		level.player.detection_grenade_duration = 15.5;
		level.gideon.ignoreall = 1;
		common_scripts\utility::flag_waitopen("tour_grenade_range");
		level.player.detection_grenade_duration = var_00;
		level.gideon.ignoreall = var_01;
	}
}

//Function Number: 205
ready_room_gideon()
{
	var_00 = getent("org_anim_elevators","targetname");
	var_00 = var_00 common_scripts\utility::spawn_tag_origin();
	common_scripts\utility::flag_wait("elevator_room_exterior");
	level.gideon maps\_utility::disable_ai_color();
	var_00 maps\_anim::anim_reach_solo(level.gideon,"rec_readyroom_seq");
	level notify("gideon_ready_room_sequence");
	common_scripts\utility::flag_set("flag_vo_ready_room_01");
	thread maps\_utility::autosave_by_name();
	var_00 maps\_anim::anim_single_solo(level.gideon,"rec_readyroom_seq");
	var_00 thread maps\_anim::anim_loop_solo(level.gideon,"rec_readyroom_idle_guy01");
	common_scripts\utility::flag_wait("training_room_elevator_activated");
	var_00 notify("stop_loop");
	level.ready_room_things["assault_rifle"] delete();
	level.ready_room_things["assault_rifle_controller"] delete();
	var_00 maps\_anim::anim_single_solo(level.gideon,"rec_readyroom_up_guy01");
	common_scripts\utility::flag_clear("flag_gideon_use_custom_anim_set");
	level.gideon maps\_utility::enable_ai_color();
}

//Function Number: 206
ready_room_player()
{
	common_scripts\utility::flag_wait("elevator_room_exterior");
	level.player allowsprint(1);
	var_00 = getent("ready_room_boost_blocker","targetname");
	var_00 notsolid();
	var_01 = getent("ready_room_elevator_left","targetname");
	var_01.animname = "ready_room_elevator_left";
	var_01 maps\_utility::assign_animtree();
	var_02 = getent("ready_room_elevator_left_clip","targetname");
	var_03 = getent("ready_room_elevator_left_clip_kl","targetname");
	var_04 = getent("ready_room_elevator_left_clip_kr","targetname");
	var_05 = getent("ready_room_elevator_left_clip_fl","targetname");
	var_06 = getent("ready_room_elevator_left_clip_fr","targetname");
	var_02 linkto(var_01,"elevatorlift");
	var_03 linkto(var_01,"door_kl");
	var_04 linkto(var_01,"door_kr");
	var_05 linkto(var_01,"door_fl");
	var_06 linkto(var_01,"door_fr");
	var_07 = getent("org_anim_elevators","targetname");
	var_07 = var_07 common_scripts\utility::spawn_tag_origin();
	var_07 maps\_anim::anim_first_frame_solo(var_01,"rec_readyroom_elevator_left_open");
	level waittill("gideon_presses_elevator_button");
	var_08 = getent("clip_elevator_pinch_prevent_left","targetname");
	var_09 = getent("clip_elevator_pinch_prevent_right","targetname");
	var_08 common_scripts\utility::delaycall(1,::delete);
	var_09 common_scripts\utility::delaycall(1,::delete);
	var_07 maps\_anim::anim_single_solo(var_01,"rec_readyroom_elevator_left_open");
	var_07 thread maps\_anim::anim_last_frame_solo(var_01,"rec_readyroom_elevator_left_open");
	common_scripts\utility::flag_wait("training_room_elevator_activated");
	thread maps\recovery_utility::play_rumble_elevator();
	var_00 solid();
	var_07 thread maps\_anim::anim_single_solo(var_01,"rec_readyroom_seq");
	common_scripts\utility::flag_set("flag_vo_ready_room_04");
	common_scripts\utility::flag_set("ready_room_elevator_lighting");
	common_scripts\utility::flag_set("flag_obj_elevators_exit_complete");
	common_scripts\utility::flag_set("training_end");
	common_scripts\utility::flag_set("training_round_2");
	var_0A = getent("left_elevator_hatch_back","targetname");
	var_0B = getent("left_elevator_hatch_front","targetname");
	var_0C = getent("right_elevator_hatch_back","targetname");
	var_0D = getent("right_elevator_hatch_front","targetname");
	wait(7);
	thread training_s2_opening();
	var_0A moveto(var_0A.origin + (0,76,0),3,0.25,0.25);
	soundscripts\_snd::snd_message("rec_readyroom_elevator_left_hatch_back",var_0A);
	var_0B moveto(var_0B.origin - (0,76,0),3,0.25,0.25);
	soundscripts\_snd::snd_message("rec_readyroom_elevator_left_hatch_front",var_0B);
	var_0C moveto(var_0C.origin + (0,76,0),3,0.25,0.25);
	var_0D moveto(var_0D.origin - (0,76,0),3,0.25,0.25);
	wait(8);
	var_02 disconnectpaths();
	maps\_utility::delaythread(1,::common_scripts\utility::flag_set,"training_room_elevator_completed");
	maps\_utility::delaythread(2,::common_scripts\utility::flag_set,"training_s2_ready");
	maps\_utility::delaythread(3,::maps\_utility::autosave_by_name);
}

//Function Number: 207
ready_room_elevator_right()
{
	common_scripts\utility::flag_wait("elevator_room_exterior");
	var_00 = getent("org_anim_elevators","targetname");
	var_00 = var_00 common_scripts\utility::spawn_tag_origin();
	var_01 = getent("ready_room_elevator_right","targetname");
	level.ready_room_things["elevator_right"] = var_01;
	var_01.animname = "ready_room_elevator_right";
	var_01 maps\_utility::assign_animtree();
	var_00 maps\_anim::anim_first_frame_solo(var_01,"rec_readyroom_seq");
	var_02 = getent("ready_room_elevator_right_clip","targetname");
	var_03 = getent("ready_room_elevator_right_clip_kl","targetname");
	var_04 = getent("ready_room_elevator_right_clip_kr","targetname");
	var_05 = getent("ready_room_elevator_right_clip_fl","targetname");
	var_06 = getent("ready_room_elevator_right_clip_fr","targetname");
	var_02 linkto(var_01,"elevatorlift");
	var_03 linkto(var_01,"door_kl");
	var_04 linkto(var_01,"door_kr");
	var_05 linkto(var_01,"door_fl");
	var_06 linkto(var_01,"door_fr");
	level waittill("gideon_ready_room_sequence");
	var_00 maps\_anim::anim_single_solo(var_01,"rec_readyroom_seq");
	var_00 thread maps\_anim::anim_first_frame_solo(var_01,"rec_readyroom_up_elevator_right");
	common_scripts\utility::flag_wait("training_room_elevator_activated");
	var_00 maps\_anim::anim_single_solo(var_01,"rec_readyroom_up_elevator_right");
	var_00 thread maps\_anim::anim_last_frame_solo(var_01,"rec_readyroom_up_elevator_right");
	var_02 = getent("ready_room_elevator_right_clip","targetname");
	var_02 disconnectpaths();
}

//Function Number: 208
ready_room_assault_rifle()
{
	var_00 = getent("org_anim_elevators","targetname");
	var_00 = var_00 common_scripts\utility::spawn_tag_origin();
	var_01 = spawn("script_model",var_00.origin);
	var_01 setmodel("npc_himar_base_loot");
	level.ready_room_things["assault_rifle"] = var_01;
	var_02 = maps\_utility::spawn_anim_model("ready_room_assault_rifle",var_00.origin,var_00.angles);
	level.ready_room_things["assault_rifle_controller"] = var_02;
	var_00 maps\_anim::anim_first_frame_solo(var_02,"rec_readyroom_seq");
	var_01.origin = var_02 gettagorigin("tag_origin_animated");
	var_01.angles = var_02 gettagangles("tag_origin_animated");
	var_01 linkto(var_02,"tag_origin_animated");
	level waittill("gideon_ready_room_sequence");
	var_00 maps\_anim::anim_single_solo(var_02,"rec_readyroom_seq");
	var_00 maps\_anim::anim_loop_solo(var_02,"rec_readyroom_idle_gun_pickedup");
	common_scripts\utility::flag_wait("training_s2_ready");
	wait(10);
	var_00 notify("stop_loop");
	var_00 delete();
}

//Function Number: 209
ready_room_sniper_rifle()
{
	var_00 = getent("gideon_rifle","targetname");
	var_00.origin = var_00.origin - (0,0,500);
	var_01 = getent("org_anim_elevators","targetname");
	var_01 = var_01 common_scripts\utility::spawn_tag_origin();
	var_02 = spawn("script_model",var_01.origin);
	var_02 setmodel("npc_m990_base_loot");
	var_02 attach("npc_m990_base_scope","tag_scope");
	var_02 hidepart("tag_sight_on");
	var_02 showpart("tag_sight_off");
	var_03 = maps\_utility::spawn_anim_model("ready_room_sniper_rifle",var_01.origin,var_01.angles);
	var_01 maps\_anim::anim_first_frame_solo(var_03,"rec_readyroom_gun_ontable");
	var_02.origin = var_03 gettagorigin("tag_origin_animated");
	var_02.angles = var_03 gettagangles("tag_origin_animated");
	var_02 linkto(var_03,"tag_origin_animated");
	level waittill("gideon_ready_room_sequence");
	var_01 thread maps\_anim::anim_single_solo(var_03,"rec_readyroom_gun_ontable");
	level waittill("swap_sniper_rifle");
	var_00.origin = var_00.origin + (0,0,500);
	wait 0.05;
	var_01 delete();
	var_03 delete();
	var_02 delete();
}

//Function Number: 210
player_speed_manager()
{
	common_scripts\utility::flag_wait("tour_end");
	level.player allowsprint(0);
	level.failonfriendlyfire = 1;
	common_scripts\utility::flag_wait("training_room_elevator_activated");
	level.player allowsprint(1);
	level.failonfriendlyfire = 0;
}

//Function Number: 211
atlas_base_weapon_manager()
{
	level endon("training_room_elevator_activated");
	thread atlas_base_weapon_manager_elevator();
	wait(1);
	common_scripts\utility::flag_wait("flag_obj_follow_gideon");
	level.player allowdodge(0);
	level.player allowmelee(0);
	level.player giveweapon("iw5_unarmed_nullattach");
	level.player switchtoweapon("iw5_unarmed_nullattach");
	level.player disableweaponswitch();
	var_00 = getdvar("bg_viewBobAmplitudeStanding");
	var_01 = getdvar("bg_viewBobAmplitudeDucked");
	var_02 = getdvar("bg_viewBobMax");
	setsaveddvar("bg_viewBobAmplitudeStanding","0.005 0.01");
	setsaveddvar("bg_viewBobAmplitudeDucked","0.002 0.005");
	setsaveddvar("bg_viewBobMax",3);
	level.player setbobrate(0.8);
	common_scripts\utility::flag_wait("tour_end");
	level.player allowdodge(0);
	level.player allowmelee(0);
	level.player giveweapon("iw5_unarmed_nullattach");
	level.player switchtoweapon("iw5_unarmed_nullattach");
	level.player disableweaponswitch();
	var_00 = getdvar("bg_viewBobAmplitudeStanding");
	var_01 = getdvar("bg_viewBobAmplitudeDucked");
	var_02 = getdvar("bg_viewBobMax");
	setsaveddvar("bg_viewBobAmplitudeStanding","0.005 0.01");
	setsaveddvar("bg_viewBobAmplitudeDucked","0.002 0.005");
	setsaveddvar("bg_viewBobMax",3);
	level.player setbobrate(0.8);
	common_scripts\utility::flag_wait("flag_obj_equip_firing_range");
	level.player allowdodge(1);
	level.player allowmelee(1);
	level.player takeweapon("iw5_unarmed_nullattach");
	level.player enableweaponswitch();
	setsaveddvar("bg_viewBobAmplitudeStanding",var_00);
	setsaveddvar("bg_viewBobAmplitudeDucked",var_01);
	setsaveddvar("bg_viewBobMax",var_02);
	level.player setbobrate(1);
	while(!common_scripts\utility::flag("training_room_elevator_activated"))
	{
		wait(1);
		common_scripts\utility::flag_waitopen("base_gun_up");
		var_03 = level.player getcurrentweapon();
		level.player allowdodge(0);
		level.player allowmelee(0);
		level.player giveweapon("iw5_unarmed_nullattach");
		level.player switchtoweapon("iw5_unarmed_nullattach");
		level.player disableweaponswitch();
		level.player disableoffhandweapons();
		level.player disableoffhandsecondaryweapons();
		setsaveddvar("bg_viewBobAmplitudeStanding","0.005 0.01");
		setsaveddvar("bg_viewBobAmplitudeDucked","0.002 0.005");
		setsaveddvar("bg_viewBobMax",3);
		level.player setbobrate(0.8);
		common_scripts\utility::flag_wait("base_gun_up");
		level.player allowdodge(1);
		level.player allowmelee(1);
		level.player takeweapon("iw5_unarmed_nullattach");
		level.player enableweaponswitch();
		if(common_scripts\utility::flag("grenade_range_started_once"))
		{
			level.player enableoffhandweapons();
			level.player enableoffhandsecondaryweapons();
		}

		level.player switchtoweapon(var_03);
		setsaveddvar("bg_viewBobAmplitudeStanding",var_00);
		setsaveddvar("bg_viewBobAmplitudeDucked",var_01);
		setsaveddvar("bg_viewBobMax",var_02);
		level.player setbobrate(1);
	}
}

//Function Number: 212
atlas_base_weapon_manager_elevator()
{
	common_scripts\utility::flag_wait("training_room_elevator_activated");
	wait(1);
	var_00 = level.player getcurrentweapon();
	level.player allowdodge(0);
	level.player allowmelee(0);
	level.player giveweapon("iw5_unarmed_nullattach");
	level.player switchtoweapon("iw5_unarmed_nullattach");
	level.player disableweaponswitch();
	level.player disableoffhandweapons();
	level.player disableoffhandsecondaryweapons();
	var_01 = getdvar("bg_viewBobAmplitudeStanding");
	var_02 = getdvar("bg_viewBobAmplitudeDucked");
	var_03 = getdvar("bg_viewBobMax");
	setsaveddvar("bg_viewBobAmplitudeStanding","0.005 0.01");
	setsaveddvar("bg_viewBobAmplitudeDucked","0.002 0.005");
	setsaveddvar("bg_viewBobMax",3);
	level.player setbobrate(0.8);
	common_scripts\utility::flag_wait("training_room_elevator_completed");
	level.player allowdodge(1);
	level.player allowmelee(1);
	level.player takeweapon("iw5_unarmed_nullattach");
	level.player enableweaponswitch();
	level.player enableoffhandweapons();
	level.player enableoffhandsecondaryweapons();
	level.player switchtoweapon(var_00);
	setsaveddvar("bg_viewBobAmplitudeStanding",var_01);
	setsaveddvar("bg_viewBobAmplitudeDucked",var_02);
	setsaveddvar("bg_viewBobMax",var_03);
	level.player setbobrate(1);
}

//Function Number: 213
setup_training_sequence_2()
{
	common_scripts\utility::flag_wait("training_round_2");
	training_s2_scriptables_reset();
	thread training_s2_starting_enemies();
	thread training_s2_player_sniper();
	thread training_s2_living_room_scene();
	thread training_s2_prep_breach_room();
	thread training_s2_bedroom_1_door_scene();
	thread training_s2_bedroom_2_scene();
	thread training_s2_president_breach_ready();
	thread training_s2_player_breach();
	thread training_s2_breach_encounter();
	thread training_s2_door_breach_anim();
	thread training_s2_patio_doors();
	thread training_s2_drone_attack();
	thread training_s2_golf_course_hide();
	thread training_s2_escape_vehicle();
	thread training_s2_golf_course_vehicles();
	thread training_s2_ending();
	thread training_s2_setup_president();
	thread training_s2_helicopter_player();
	thread training_s2_helicopter_irons();
	thread training_s2_helicopter_gideon();
}

//Function Number: 214
training_s2_opening()
{
	common_scripts\utility::flag_set("flag_obj_rescue2_start");
	thread maps\recovery_utility::training_s2_start_set_up_player();
	maps\recovery::setup_allies("training_2_begin");
	level.gideon thread maps\recovery_utility::training_s2_opening_guy_think("training_gideon_start_point");
	level.joker thread maps\recovery_utility::training_s2_opening_guy_think("training_s2_squad_1_start_point");
	level.ally_s2_squad_member_1 thread maps\recovery_utility::training_s2_opening_guy_think("training_s2_squad_2_start_point");
	thread maps\recovery_utility::training_s2_set_squad_passive_and_ignore();
	common_scripts\utility::flag_set("training_2_start_area_lighting");
	common_scripts\utility::flag_set("training_s2_spawn_starting_enemies");
	common_scripts\utility::flag_wait("training_s2_ready");
	wait(1);
	common_scripts\utility::flag_set("training_s2_start_player_sniper_attack");
}

//Function Number: 215
training_s2_player_sniper()
{
	common_scripts\utility::flag_wait("training_s2_start_player_sniper_attack");
	maps\_utility::activate_trigger("training_s2_sniper_start","targetname");
	common_scripts\utility::flag_set("flag_obj_rescue2_entrance");
	common_scripts\utility::flag_set("flag_vo_training_s2_gideon_my_lead");
	wait(2);
	maps\_utility::autosave_by_name();
	thread maps\recovery_utility::training_stealth_spotted();
	thread maps\recovery_utility::training_s2_start_squad_attack("training_s2_start_alerted");
	common_scripts\utility::flag_set("training_s2_living_room_approach");
	thread maps\recovery_utility::training_s2_squad_allow_run();
	maps\_utility::waittill_aigroupcount("training_s2_starting_enemies",5);
	common_scripts\utility::flag_set("flag_vo_training_s2_gideon_push_forward");
	maps\_utility::waittill_aigroupcount("training_s2_starting_enemies",3);
	common_scripts\utility::flag_set("training_s2_start_charge");
	maps\_utility::waittill_aigroupcount("training_s2_starting_enemies",1);
	maps\_utility::delaythread(10,::common_scripts\utility::flag_set,"training_s2_clear_start_spawn");
	maps\_utility::waittill_aigroupcleared("training_s2_starting_enemies");
	wait(1);
	maps\_utility::autosave_by_name();
	common_scripts\utility::flag_set("flag_vo_training_s2_gideon_clear_move");
	camp_david_play_videos();
	wait(2);
	maps\_utility::activate_trigger("training_s2_color_entrance_trigger","targetname");
	common_scripts\utility::flag_set("flag_obj_rescue2_living_room");
}

//Function Number: 216
training_s2_starting_enemies()
{
	common_scripts\utility::flag_wait("training_s2_spawn_starting_enemies");
	maps\_utility::array_spawn_noteworthy("training_s2_enemies_patrol",1);
	maps\_utility::array_spawn_noteworthy("training_s2_enemies_start",1);
	maps\_utility::array_spawn_noteworthy("training_s2_enemies_start2",1);
	var_00 = getent("training_s2_starting_enemy_vehicle_1","script_noteworthy") maps\_utility::spawn_vehicle();
	var_01 = getent("training_s2_starting_enemy_vehicle_2","script_noteworthy") maps\_vehicle::spawn_vehicle_and_gopath();
	common_scripts\utility::flag_wait("training_s2_clear_initial_spawn");
}

//Function Number: 217
training_s2_scriptables_reset()
{
	if(!isdefined(level.cd_living_room_blinds))
	{
		level.cd_living_room_blinds = getscriptablearray("blinds_living_room","targetname");
	}

	foreach(var_01 in level.cd_living_room_blinds)
	{
		var_01 setscriptablepartstate("root","intact_reset");
	}

	maps\recovery_utility::set_tv_screen_unbroken();
}

//Function Number: 218
training_s2_wait_for_living_room_dead()
{
	maps\_utility::waittill_aigroupcleared("training_s2_enemies_living_room");
	common_scripts\utility::flag_set("flag_living_room_dead");
}

//Function Number: 219
training_s2_wait_for_hallway_dead()
{
	maps\_utility::waittill_aigroupcleared("training_s2_enemies_hall");
	common_scripts\utility::flag_set("flag_hallway_dead");
}

//Function Number: 220
training_s2_wait_for_suprise_dead()
{
	self waittill("death");
	common_scripts\utility::flag_set("flag_surprise_dead");
}

//Function Number: 221
training_s2_wait_for_bedrooms_dead()
{
	maps\_utility::waittill_aigroupcleared("bedroom_enemies");
	common_scripts\utility::flag_set("flag_bedrooms_dead");
}

//Function Number: 222
training_s2_living_room_scene()
{
	common_scripts\utility::flag_wait("training_s2_living_room_approach");
	common_scripts\utility::flag_wait("training_s2_living_room_alert");
	maps\_utility::array_spawn_noteworthy("training_s2_enemies_living_room",1);
	maps\_utility::activate_trigger("training_s2_color_trigger2","targetname");
	common_scripts\utility::flag_set("flag_obj_rescue2_living_room_clear");
	thread training_s2_wait_for_living_room_dead();
	common_scripts\utility::flag_wait_either("flag_living_room_dead","bedroom_1_door_scene");
	maps\_utility::array_spawn_noteworthy("training_s2_enemies_hall",1);
	thread training_s2_wait_for_hallway_dead();
	common_scripts\utility::flag_wait("flag_hallway_dead");
	common_scripts\utility::flag_set("flag_vo_training_s2_gideon_mitchell_sweep");
	common_scripts\utility::flag_set("training_s2_spawn_breach_door");
	maps\_utility::autosave_by_name();
}

//Function Number: 223
training_s2_bedroom_1_door_scene()
{
	common_scripts\utility::flag_wait("bedroom_1_door_scene");
	var_00 = getent("bedroom_1_door","targetname");
	getent(var_00.target,"targetname") linkto(var_00);
	var_01 = 1;
	var_00 rotateto(var_00.angles + (0,145,0),var_01,0.05,0.05);
	common_scripts\utility::flag_set("flag_vo_training_s2_joker_contact");
	var_00 common_scripts\utility::delaycall(var_01,::connectpaths);
	var_00 common_scripts\utility::delaycall(2,::disconnectpaths);
	var_02 = getent("bedroom_1_door_enemy","targetname") maps\_utility::spawn_ai(1);
	var_02 thread training_s2_wait_for_suprise_dead();
	var_02 soundscripts\_snd::snd_message("rec_s2_door_guy_ambush");
	var_02.allowdeath = 1;
	var_02.health = 1;
	var_03 = common_scripts\utility::getstruct(var_02.target,"targetname");
	var_03 maps\_anim::anim_generic(var_02,var_03.animation);
	common_scripts\utility::flag_wait_either("training_s2_hallway_surprise_enemy","training_s2_bedrooms_skipped");
	common_scripts\utility::flag_set("training_s2_prep_breach");
	var_04 = getent("bedroom_1_enemy","targetname");
	var_05 = var_04 maps\_utility::spawn_ai(1);
	var_05 maps\_utility::disable_long_death();
	var_05.pacifist = 1;
	wait(2);
	if(isalive(var_05))
	{
		var_05.pacifist = 0;
	}

	if(isalive(var_02))
	{
		var_02.health = 100;
		var_02 setgoalnode(getnode(var_03.target,"targetname"));
	}

	common_scripts\utility::flag_wait("training_s2_bedrooms_skipped");
	if(isalive(var_05))
	{
		var_05 setgoalentity(level.player);
		var_05.goalradius = 8;
	}

	if(isalive(var_02))
	{
		var_02 setgoalentity(level.player);
		var_02.goalradius = 8;
	}
}

//Function Number: 224
training_s2_bedroom_2_scene()
{
	common_scripts\utility::flag_wait_either("bedroom_2_scene","training_s2_bedrooms_skipped");
	thread maps\recovery_utility::training_s2_open_bedroom_door_2();
	var_00 = getent("bedroom_2_enemy","targetname");
	var_01 = var_00 maps\_utility::spawn_ai(1);
	var_01 maps\_utility::disable_long_death();
	var_02 = getnode("escape_node","targetname");
	var_01 setgoalnode(var_02);
	var_03 = getent("bedroom_3_enemy","targetname");
	var_04 = var_03 maps\_utility::spawn_ai(1);
	var_04 maps\_utility::disable_long_death();
	var_05 = getnode("training_s2_cover_node2","script_noteworthy");
	var_04 setgoalnode(var_05);
	thread training_s2_wait_for_bedrooms_dead();
	common_scripts\utility::flag_wait("training_s2_bedrooms_skipped");
	if(isalive(var_01))
	{
		var_01 setgoalentity(level.player);
		var_01.goalradius = 8;
	}

	if(isalive(var_04))
	{
		var_04 setgoalentity(level.player);
		var_04.goalradius = 8;
	}
}

//Function Number: 225
training_s2_president_breach_ready()
{
	common_scripts\utility::flag_wait_all("flag_living_room_dead","flag_hallway_dead","flag_surprise_dead","flag_bedrooms_dead");
	common_scripts\utility::flag_set("flag_vo_training_s2_joker_clear");
	common_scripts\utility::flag_set("flag_obj_rescue2_breach");
	common_scripts\utility::flag_set("training_s2_mute_breach_enabled");
	common_scripts\utility::flag_set("training_s2_spawn_breach_door");
	wait(0.25);
	maps\_utility::autosave_by_name();
}

//Function Number: 226
training_s2_prep_breach_room()
{
	common_scripts\utility::flag_wait("training_s2_prep_breach");
	maps\_utility::activate_trigger("training_s2_color_trigger3","targetname");
	var_00 = common_scripts\utility::getstruct("training_s1_exo_breach_marker","targetname");
	common_scripts\utility::flag_wait("training_s2_release_president");
	maps\_utility::activate_trigger("training_s2_enter_drone_attack","targetname");
	thread maps\recovery_utility::training_s2_exo_breach_knife();
	level.gideon maps\_utility::place_weapon_on(level.gideon.primaryweapon,"chest");
	soundscripts\_snd::snd_message("aud_training_s2_potus_ziptie_release");
	var_00 maps\_anim::anim_single_solo_run(level.gideon,"training_s2_exo_breach_gideon_release");
	level.gideon thread maps\_utility::place_weapon_on(level.gideon.primaryweapon,"right");
}

//Function Number: 227
disable_meele_for_breach(param_00)
{
	level endon("breaching2");
	for(;;)
	{
		if(distance(level.player geteye(),param_00.origin) <= 72)
		{
			level.player allowmelee(0);
		}
		else
		{
			level.player allowmelee(1);
		}

		wait 0.05;
	}
}

//Function Number: 228
training_s2_player_breach()
{
	common_scripts\utility::flag_wait("training_s2_mute_breach_enabled");
	var_00 = getent("training_s2_breach_trigger","targetname");
	var_01 = getent("training_s2_breach_trigger_use","targetname");
	level.player notifyonplayercommand("breach_input","+melee");
	level.player notifyonplayercommand("breach_input","+melee_zoom");
	level.player notifyonplayercommand("breach_input","+melee_breath");
	thread disable_meele_for_breach(var_01);
	for(;;)
	{
		level.player waittill("breach_input");
		if(distance(level.player geteye(),var_01.origin) <= 72)
		{
			break;
		}
	}

	var_00 common_scripts\utility::trigger_off();
	var_01 common_scripts\utility::trigger_off();
	common_scripts\utility::flag_clear("touching_s2_breach_door");
	level.player notifyonplayercommandremove("breach_input","+melee");
	level.player notifyonplayercommandremove("breach_input","+melee_zoom");
	level.player notifyonplayercommandremove("breach_input","+melee_breath");
	common_scripts\utility::flag_set("flag_vo_training_s2_gideon_hit_door_nag_off");
	level notify("breaching2");
	common_scripts\utility::flag_set("flag_obj_rescue2_breach_clear");
	var_02 = common_scripts\utility::getstruct("training_s1_exo_breach_marker","targetname");
	var_03 = maps\_utility::spawn_anim_model("player_rig",level.player.origin);
	var_03.animname = "player_rig";
	soundscripts\_snd::snd_message("rec_s2_breach_gun_holster");
	var_02 thread maps\_anim::anim_first_frame_solo(var_03,"training_s2_breach");
	var_03 hide();
	var_04 = 0.75;
	var_05 = length(level.player getvelocity());
	var_04 = var_04 - 0.5 * clamp(var_05 / 200,0,1);
	var_03 hide();
	level.player playerlinktoblend(var_03,"tag_player",var_04);
	level.player maps\_utility::add_wait(::maps\_shg_utility::setup_player_for_scene,1);
	var_03 maps\_utility::add_call(::show);
	thread maps\_utility::do_wait();
	level.player common_scripts\utility::delaycall(2,::enableweapons);
	common_scripts\utility::flag_set("training_s2_breach_begin");
	common_scripts\utility::flag_set("training_s2_spawn_breach_enemies");
	thread maps\recovery_utility::training_s2_breach_enemies_monitor();
	level.player common_scripts\utility::delaycall(1.8,::playrumbleonentity,"light_1s");
	var_02 maps\_anim::anim_single_solo(var_03,"training_s2_breach");
	level.player unlink();
	var_03 delete();
	level.player maps\_shg_utility::setup_player_for_gameplay();
	level.player thread maps\recovery_utility::lerp_in_turn_rate(0.5);
}

//Function Number: 229
training_s2_breach_encounter()
{
	common_scripts\utility::flag_wait("training_s2_spawn_breach_enemies");
	maps\_utility::array_spawn_noteworthy("training_s2_enemies_breach",1);
	level.kva_shooter_s2 = getent("breach_kva_spawner2","targetname") maps\_utility::spawn_ai(1);
	level.kva_shooter_s2 thread maps\recovery_utility::training_s2_breach_kva_think();
	level.president = getent("training_s2_president_spawner","targetname") maps\_utility::spawn_ai(1);
	level.president thread maps\_president::set_president_anims();
	level.president thread maps\recovery_utility::training_s2_breach_president_setup();
	var_00 = maps\_utility::spawn_anim_model("ziptie_prop");
	var_00.animname = "ziptie_prop";
	var_01 = common_scripts\utility::getstruct("training_s1_exo_breach_marker","targetname");
	var_01 thread maps\_anim::anim_first_frame_solo(var_00,"training_s2_exo_ziptie_start");
	var_01 maps\_anim::anim_first_frame_solo(level.president,"training_s2_exo_breach_president_react");
	var_01 thread maps\_anim::anim_single_solo(var_00,"training_s2_exo_ziptie_start");
	var_01 maps\_anim::anim_single_solo(level.president,"training_s2_exo_breach_president_react");
	if(isalive(level.president))
	{
		var_01 thread maps\_anim::anim_loop_solo(var_00,"training_s2_exo_ziptie_react_idle","stop_loop");
		var_01 thread maps\_anim::anim_loop_solo(level.president,"training_s2_exo_breach_president_react_idle","stop_loop");
	}

	thread training_s2_president_shot(var_01,var_00);
}

//Function Number: 230
training_s2_president_shot(param_00,param_01)
{
	thread training_s2_kva_dead(param_00,param_01);
	thread maps\recovery_utility::training_s2_president_dead();
	level.president endon("kva_death_s2");
	level.president waittill("stop_idle_loop_s2");
	param_00 notify("stop_loop");
	param_00 thread maps\_anim::anim_single_solo(param_01,"training_s2_exo_ziptie_fail");
	param_00 maps\_anim::anim_single_solo(level.president,"training_s2_exo_breach_president_fail");
	level.president.noragdoll = 1;
	level.president.allowdeath = 1;
	level.president.a.nodeath = 1;
	level.president maps\_utility::set_battlechatter(0);
	wait(0.05);
	level.president kill();
}

//Function Number: 231
training_s2_kva_dead(param_00,param_01)
{
	common_scripts\utility::flag_wait("training_s2_breach_enemy_dead");
	if(common_scripts\utility::flag("training_s2_flag_president_shot") == 0)
	{
		level.president notify("kva_death_s2");
		thread training_s2_kva_shot(param_00,param_01);
	}
}

//Function Number: 232
training_s2_kva_shot(param_00,param_01)
{
	common_scripts\utility::flag_wait("training_s2_breach_enemy_dead");
	param_00 notify("stop_loop");
	if(isalive(level.president))
	{
		param_00 thread maps\_anim::anim_single_solo(param_01,"training_s2_exo_ziptie_success");
		param_00 maps\_anim::anim_single_solo(level.president,"training_s2_exo_breach_president_success");
	}

	if(isalive(level.president))
	{
		param_00 thread maps\_anim::anim_loop_solo(param_01,"training_s2_exo_ziptie_release_idle","stop_loop2");
		param_00 thread maps\_anim::anim_loop_solo(level.president,"training_s2_exo_breach_president_release_idle","stop_loop2");
	}

	common_scripts\utility::flag_wait("training_s2_breach_enemies_dead");
	level.player setmovespeedscale(1);
	common_scripts\utility::flag_set("flag_vo_training_s2_gideon_mr_president");
	common_scripts\utility::flag_set("training_s2_drone_attack_setup");
	maps\_utility::autosave_by_name();
	common_scripts\utility::flag_set("training_s2_release_president");
	param_00 notify("stop_loop2");
	if(isalive(level.president))
	{
		level.president thread maps\_utility::magic_bullet_shield();
		level.president notify("breach_s2_end");
		param_00 thread maps\_anim::anim_single_solo(param_01,"training_s2_exo_ziptie_release");
		param_00 maps\_anim::anim_single_solo_run(level.president,"training_s2_exo_breach_president_release");
		level.president animcustom(::animscripts\run::moverun);
		wait(0.4);
		level.president orientmode("face point",level.gideon.origin);
		wait(0.25);
		level.president orientmode("face default");
		param_01 delete();
		common_scripts\utility::flag_set("training_s2_breach_done");
		common_scripts\utility::flag_set("flag_obj_rescue2_drone_living_room");
		maps\_utility::autosave_by_name();
	}
}

//Function Number: 233
training_s2_door_breach_anim()
{
	common_scripts\utility::flag_wait("training_s2_spawn_breach_door");
	var_00 = common_scripts\utility::getstruct("training_s1_exo_breach_marker","targetname");
	var_01 = getent("training_exo_breach_door","targetname");
	var_01.animname = "door_prop";
	var_01 maps\_utility::assign_animtree();
	var_02 = getent("training_exo_breach_door_clip","targetname");
	var_00 maps\_anim::anim_first_frame_solo(var_01,"training_s2_exo_door");
	var_02 linkto(var_01,"door");
	common_scripts\utility::flag_wait("training_s2_mute_breach_enabled");
	var_03 = getent("training_s2_breach_trigger","targetname");
	var_04 = getent("training_s2_breach_trigger_use","targetname");
	var_05 = maps\_shg_utility::hint_button_position("rs",var_03.origin,undefined,300,undefined,var_04);
	level waittill("breaching2");
	var_05 maps\_shg_utility::hint_button_clear();
	common_scripts\utility::flag_wait("training_s2_breach_begin");
	soundscripts\_snd::snd_message("rec_slomo_audio_handler");
	var_00 maps\_anim::anim_single_solo(var_01,"training_s2_exo_door");
	var_02 connectpaths();
}

//Function Number: 234
training_s2_drone_attack()
{
	common_scripts\utility::flag_wait("training_s2_drone_attack_setup");
	common_scripts\utility::flag_set("training_s2_ready_living_room_drone_attack");
	maps\_utility::activate_trigger("training_s2_enter_drone_attack","targetname");
	thread maps\recovery_utility::training_s2_open_patio_door();
	common_scripts\utility::flag_wait("training_s2_living_room_drone_attack");
	maps\_utility::autosave_by_name();
	common_scripts\utility::flag_set("flag_obj_rescue2_drone_living_room_clear");
	thread training_s2_patio_combat();
	maps\_utility::delaythread(0.5,::common_scripts\utility::flag_set,"flag_vo_training_s2_joker_drones");
	thread vehicle_scripts\_pdrone_tactical_picker::main();
	var_00 = [];
	var_00 = vehicle_scripts\_pdrone::start_flying_attack_drones("s2_flying_attack_drones1");
	soundscripts\_snd::snd_message("rec_s2_drones_attack",var_00);
	foreach(var_02 in var_00)
	{
		var_02 thread training_s2_drone_blinds_destroy_think();
		var_02 thread maps\recovery_utility::training_s2_drone_ambush_attack_think();
	}

	thread maps\recovery_utility::training_s2_set_squad_active_and_target();
	thread maps\recovery_utility::training_s2_drone_ambush_attack();
	maps\recovery_utility::waittill_s2_drone_ambush_done(var_00);
	common_scripts\utility::flag_set("training_s2_living_room_drone_attack_done");
	common_scripts\utility::flag_set("flag_obj_rescue2_patio_drone_ambush");
	maps\_utility::autosave_by_name();
	thread training_s2_show_drone_text();
	maps\_utility::waittill_aigroupcount("training_s2_patio_enemies",4);
	common_scripts\utility::flag_set("flag_vo_training_s2_gideon_dont_let_up");
	common_scripts\utility::flag_set("flag_training_s2_patio_enemies_charge");
	if(common_scripts\utility::flag("training_s2_drone_start") == 1)
	{
		maps\_utility::waittill_aigroupcount("training_s2_patio_enemies2",0);
	}

	maps\_utility::waittill_aigroupcount("training_s2_patio_enemies",1);
	common_scripts\utility::flag_set("training_s2_clear_patio_spawn");
	wait(4);
	level notify("training_s2_drone_enemies_killed");
	level.player.showhint = 0;
	maps\_utility::delaythread(0.5,::common_scripts\utility::flag_set,"flag_vo_training_s2_gideon_go_go");
	common_scripts\utility::flag_set("training_s2_drone_attack_done");
	if(isdefined(level.player.is_driving_pdrone) && level.player.is_driving_pdrone)
	{
		level.player.drone vehicle_scripts\_pdrone_player::pdrone_player_force_exit();
		thread maps\recovery_lighting::setup_lighting_fly_drone_off_night();
	}

	level.player setweaponhudiconoverride("actionslot3","dpad_icon_drone_off");
	wait(1);
	level.gideon maps\_utility::cqb_walk("off");
	common_scripts\utility::flag_set("flag_obj_rescue2_patio_drone_ambush_clear");
	thread maps\recovery_utility::training_s2_set_squad_active_and_target();
	maps\_utility::activate_trigger("training_s2_golf_course_cover","targetname");
	common_scripts\utility::flag_set("flag_obj_rescue2_golf_course");
	common_scripts\utility::flag_set("flag_training_s2_squad_advance_golf_course");
	maps\_utility::autosave_by_name();
}

//Function Number: 235
training_s2_show_drone_text()
{
	level endon("training_s2_clear_patio_spawn");
	common_scripts\utility::flag_wait("training_s2_enter_patio");
	wait(1);
	level.player setweaponhudiconoverride("actionslot3","dpad_icon_drone");
	level.player notifyonplayercommand("use_drone","-actionslot 3");
	thread maps\recovery_utility::training_s2_player_drone();
	common_scripts\utility::flag_set("flag_vo_training_s2_gideon_mitchell_assault_drone");
}

//Function Number: 236
training_s2_patio_combat()
{
	common_scripts\utility::flag_wait("training_s2_dining_room");
	thread maps\recovery_utility::training_s2_spawn_search_vehicle();
	maps\_utility::array_spawn_noteworthy("training_s2_enemies_patio",1);
	common_scripts\utility::flag_set("training_s2_start_enter_patio");
}

//Function Number: 237
training_s2_patio_doors()
{
	var_00 = common_scripts\utility::getstruct("training_s2_patio_door_animnode","targetname");
	level.patio_doors = getent("training_patio_french_doors","targetname");
	level.patio_doors.animname = "patio_doors";
	level.patio_doors maps\_anim::setanimtree();
	var_01 = getent("french_door_clip_01","targetname");
	var_02 = getent("french_door_clip_02","targetname");
	var_00 maps\_anim::anim_first_frame_solo(level.patio_doors,"training_s2_patio_doors_in");
	var_01 linkto(level.patio_doors,"door_r");
	var_02 linkto(level.patio_doors,"door_l");
	level.patio_doors waittill("go2");
	var_01 solid();
	var_02 solid();
	var_02 disconnectpaths();
	var_01 disconnectpaths();
	var_00 maps\_anim::anim_single_solo(level.patio_doors,"training_s2_patio_doors_out");
	var_02 connectpaths();
	var_01 connectpaths();
	wait(1);
	var_02 disconnectpaths();
	var_01 disconnectpaths();
}

//Function Number: 238
training_s2_golf_course_hide()
{
	common_scripts\utility::flag_wait("training_s2_golf_course_hide");
	common_scripts\utility::flag_set("flag_obj_rescue2_golf_course_clear");
	maps\_utility::autosave_by_name();
	maps\_utility::activate_trigger("training_s2_color_trigger_golf_course2","targetname");
	common_scripts\utility::flag_set("flag_obj_rescue2_golf_course2");
	common_scripts\utility::flag_wait("training_s2_flag_golf_course2");
	common_scripts\utility::flag_set("flag_obj_rescue2_golf_course2_clear");
	maps\_utility::delaythread(0.5,::common_scripts\utility::flag_set,"flag_vo_training_s2_gideon_prophet_approaching");
	common_scripts\utility::flag_set("flag_obj_rescue2_escape_location");
	maps\_utility::activate_trigger("training_s2_color_trigger_escape","targetname");
}

//Function Number: 239
training_s2_escape_vehicle()
{
	common_scripts\utility::flag_wait("training_s2_start_escape_vehicle");
	maps\_utility::autosave_by_name();
	level.escape_vehicle2 = getent("training_s2_escape_vehicle","script_noteworthy") maps\_utility::spawn_vehicle();
	soundscripts\_snd::snd_message("rec_train2_exfil_car_start",level.escape_vehicle2);
	level.escape_vehicle2 maps\_utility::magic_bullet_shield();
	level.escape_vehicle2.animname = "avt";
	level thread maps\recovery_fx::training_escape_vehicle_2_fx(level.escape_vehicle2);
	level.escape_driver2 = getent("training_s2_end_escape_driver","targetname") maps\_utility::spawn_ai();
	level.escape_driver2 maps\_utility::set_battlechatter(0);
	level.escape_driver2 maps\_utility::magic_bullet_shield();
	level.escape_driver2.animname = "driver";
	var_00 = getent("training_s2_ending_anim_origin","targetname");
	var_00 thread maps\_anim::anim_single_solo(level.escape_driver2,"training_s2_driver_end_drivein");
	var_00 maps\_anim::anim_single_solo(level.escape_vehicle2,"training_s2_vehicle_end_drivein");
	var_00 thread maps\_anim::anim_single_solo(level.escape_driver2,"training_s2_driver_end_driveout");
	maps\_utility::delaythread(0.1,::maps\_anim::anim_set_rate_single,level.escape_driver2,"training_s2_driver_end_driveout",0);
	common_scripts\utility::flag_set("training_s2_vehicle_ready");
	common_scripts\utility::flag_wait("training_s2_end_setup_president");
	soundscripts\_snd::snd_message("rec_train2_exfil_car_end",level.escape_vehicle2);
	maps\_anim::anim_set_rate_single(level.escape_driver2,"training_s2_driver_end_driveout",1);
}

//Function Number: 240
training_s2_ending()
{
	common_scripts\utility::flag_wait("training_s2_vehicle_ready");
	common_scripts\utility::flag_set("flag_obj_rescue2_escape_vehicle");
	var_00 = getent("training_s2_ending_anim_origin","targetname");
	var_01 = getent("training_s2_ending_trigger","targetname");
	var_02 = var_01 maps\_shg_utility::hint_button_trigger("use");
	common_scripts\utility::flag_set("flag_vo_training_s2_gideon_president_inside");
	for(;;)
	{
		var_01 waittill("trigger");
		if(!isdefined(var_01.trigger_off))
		{
			break;
		}
	}

	var_01 delete();
	common_scripts\utility::flag_set("training_2_suv_lighting");
	common_scripts\utility::flag_set("flag_obj_rescue2_escape_vehicle_clear");
	thread maps\recovery_utility::play_rumble_training_s2_president_load();
	level notify("training_s2_gideon_mitchell_secure_nag_off");
	var_02 maps\_shg_utility::hint_button_clear();
	var_03 = getentarray("grenade","classname");
	foreach(var_05 in var_03)
	{
		var_05 delete();
	}

	level.player enableinvulnerability();
	level.player freezecontrols(1);
	level.player maps\_shg_utility::setup_player_for_scene(1);
	level.player_rig = maps\recovery_utility::spawn_player_rig();
	level.player_rig hide();
	var_07 = 0.4;
	var_00 maps\_anim::anim_first_frame_solo(level.player_rig,"training_s2_player_end");
	level.player playerlinktoblend(level.player_rig,"tag_player",var_07);
	level.player_rig common_scripts\utility::delaycall(var_07,::show);
	wait(var_07);
	level.player_rig show();
	common_scripts\utility::flag_set("training_s2_end_setup_president");
	var_00 thread maps\_anim::anim_single_solo(level.escape_vehicle2,"training_s2_vehicle_end");
	var_00 maps\_anim::anim_single_solo(level.player_rig,"training_s2_player_end");
	level.player unlink();
	level.player_rig delete();
	level.player maps\_shg_utility::setup_player_for_gameplay();
	level.player freezecontrols(0);
	level.player disableinvulnerability();
	maps\_utility::delaythread(1,::common_scripts\utility::flag_set,"training_s2_golf_course_vehicles");
	maps\_utility::delaythread(2,::common_scripts\utility::flag_set,"flag_vo_training_s2_gideon_package_secure");
	common_scripts\utility::flag_wait("training_s2_start_exo_shield_tutorial");
	wait(6);
	thread maps\recovery_utility::training_s2_shield_tutorial();
}

//Function Number: 241
training_s2_setup_president()
{
	common_scripts\utility::flag_wait("training_s2_end_setup_president");
	if(!isalive(level.president))
	{
		var_00 = getent("training_s2_president_spawner","targetname");
		level.president = var_00 maps\_utility::spawn_ai(1);
		level.president.ignoresonicaoe = 1;
		level.president maps\_president::set_president_anims();
		var_01 = common_scripts\utility::getstruct("training_end_s2_president_start_point","targetname");
		level.president forceteleport(var_01.origin,var_01.angles);
		level.president thread maps\_utility::magic_bullet_shield();
	}

	var_02 = getent("training_s2_ending_anim_origin","targetname");
	level.president.animname = "president";
	var_02 maps\_anim::anim_first_frame_solo(level.president,"training_s2_president_end");
	var_02 maps\_anim::anim_single_solo(level.president,"training_s2_president_end");
	level.president maps\_utility::stop_magic_bullet_shield();
	level.president delete();
	level.escape_vehicle2 maps\_utility::stop_magic_bullet_shield();
	level.escape_vehicle2 delete();
	level.escape_driver2 maps\_utility::stop_magic_bullet_shield();
	level.escape_driver2 delete();
}

//Function Number: 242
training_s2_golf_course_vehicles()
{
	common_scripts\utility::flag_wait("training_s2_golf_course_vehicles");
	thread maps\recovery_utility::training_s2_set_squad_active_and_target();
	thread maps\_utility::autosave_by_name();
	thread maps\recovery_utility::training_s2_guard_house_doors();
	maps\_utility::array_spawn_noteworthy("training_s2_kva_ambush1",1);
	maps\_utility::waittill_aigroupcount("s2_end_ambush1",3);
	thread vehicle_scripts\_pdrone_tactical_picker::main();
	level.drones_s2_end = 0;
	var_00 = [];
	var_00 = vehicle_scripts\_pdrone::start_flying_attack_drones("s2_flying_attack_drones_end");
	foreach(var_02 in var_00)
	{
		var_02 soundscripts\_snd::snd_message("attack_drone_flybys_audio");
		var_02 thread maps\recovery_utility::training_s2_drone_end_think("training_s2_warbird_kill_enemies");
	}

	common_scripts\utility::flag_set("flag_training_s2_guard_house_doors_stay_open");
	thread maps\recovery_utility::training_s2_guard_house_doors();
	maps\_utility::array_spawn_noteworthy("training_s2_kva_ambush2",1);
	maps\_utility::waittill_aigroupcount("s2_end_ambush2",3);
	common_scripts\utility::flag_set("flag_vo_training_s2_gideon_smart_grenades");
	var_04 = [];
	var_05 = [];
	var_04 = getentarray("training_s2_ambush_vehicles","script_noteworthy");
	foreach(var_07 in var_04)
	{
		var_08 = var_07 maps\_vehicle::spawn_vehicle_and_gopath();
		var_05[var_05.size] = var_08;
	}

	if(var_05[0].origin[0] < var_05[1].origin[0])
	{
		soundscripts\_snd::snd_message("rec_train2_ambush_car_1",var_05[0]);
		soundscripts\_snd::snd_message("rec_train2_ambush_car_2",var_05[1]);
	}
	else
	{
		soundscripts\_snd::snd_message("rec_train2_ambush_car_1",var_05[1]);
		soundscripts\_snd::snd_message("rec_train2_ambush_car_2",var_05[0]);
	}

	maps\_utility::waittill_aigroupcount("training_s2_escape_ambush",6);
	common_scripts\utility::flag_set("training_2_car_fires_lighting");
	common_scripts\utility::flag_set("training_s2_start_warbird");
}

//Function Number: 243
training_s2_helicopter_player()
{
	common_scripts\utility::flag_wait("training_s2_start_warbird");
	common_scripts\utility::flag_set("flag_vo_training_s2_warbird_pilot");
	wait(2);
	var_00 = getent("training_s2_ending_anim_origin","targetname");
	var_01 = getent("training_s2_warbird","targetname");
	level.warbird = var_01 maps\_utility::spawn_vehicle();
	level.warbird.animname = "warbird";
	var_00 maps\_anim::anim_first_frame_solo(level.warbird,"warbird_landing");
	level.warbird thread maps\recovery_utility::warbird_heavy_shooting_think(1);
	common_scripts\utility::flag_set("training_s2_end_helicopter_setup_irons");
	maps\_utility::delaythread(2,::common_scripts\utility::flag_set,"flag_vo_training_s2_gideon_our_exfil");
	var_00 maps\_anim::anim_single_solo(level.warbird,"warbird_landing");
	maps\_utility::activate_trigger("training_s2_gideon_get_to_chopper","targetname");
	var_00 thread maps\_anim::anim_loop_solo(level.warbird,"warbird_land_idle");
	wait(1);
	maps\_utility::autosave_by_name();
	common_scripts\utility::flag_set("training_enable_end");
	common_scripts\utility::flag_set("flag_obj_rescue2_complete");
	common_scripts\utility::flag_set("flag_vo_training_s2_gideon_the_warbird");
	common_scripts\utility::flag_wait("training_s2_enter_helicopter");
	level.player freezecontrols(1);
	common_scripts\utility::flag_set("flag_disable_exo");
	level notify("training_s2_gideon_mitchell_over_nag_off");
	common_scripts\utility::flag_set("flag_obj_rescue2_complete_clear");
	level.player_rig = maps\recovery_utility::spawn_player_rig();
	level.player_rig hide();
	var_00 maps\_anim::anim_first_frame_solo(level.player_rig,"training_s2_player_helicopter");
	var_02 = 0.8;
	var_03 = length(level.player getvelocity());
	var_02 = var_02 - 0.4 * clamp(var_03 / 250,0,1);
	level.player maps\_utility::add_wait(::maps\_shg_utility::setup_player_for_scene,1);
	level.player_rig maps\_utility::add_call(::show);
	thread maps\_utility::do_wait();
	level.player playerlinktoblend(level.player_rig,"tag_player",var_02,0,0.25);
	level.player common_scripts\utility::delaycall(var_02,::playerlinktodelta,level.player_rig,"tag_player",1,7,7,5,5,1);
	level.player common_scripts\utility::delaycall(var_02 + 0.05,::springcamenabled,1,3.2,1.6);
	wait(var_02);
	common_scripts\utility::flag_set("training_s2_end_helicopter_irons_end");
	common_scripts\utility::flag_set("training_s2_end_helicopter_setup_gideon");
	level.warbird showpart("TAG_STATIC_MAIN_ROTOR_L");
	level.warbird showpart("TAG_STATIC_MAIN_ROTOR_R");
	level.warbird showpart("TAG_STATIC_TAIL_ROTOR");
	level.warbird hidepart("TAG_SPIN_MAIN_ROTOR_L");
	level.warbird hidepart("TAG_SPIN_MAIN_ROTOR_R");
	level.warbird hidepart("TAG_SPIN_TAIL_ROTOR");
	var_00 thread maps\_anim::anim_single_solo(level.warbird,"warbird_takeoff");
	soundscripts\_snd::snd_music_message("rec_level_ending");
	var_00 maps\_anim::anim_single_solo(level.player_rig,"training_s2_player_helicopter");
}

//Function Number: 244
training_s2_helicopter_irons()
{
	common_scripts\utility::flag_wait("training_s2_end_helicopter_setup_irons");
	if(!isalive(level.irons))
	{
		var_00 = getent("training_irons_spawner","targetname");
		var_00.count++;
		level.irons = var_00 maps\_utility::spawn_ai(1);
	}

	level.irons thread maps\_utility::magic_bullet_shield();
	level.irons.animname = "irons";
	var_01 = getent("training_s2_ending_anim_origin","targetname");
	var_01 maps\_anim::anim_first_frame_solo(level.irons,"training_s2_irons_helicopter_landing");
	var_01 maps\_anim::anim_single_solo(level.irons,"training_s2_irons_helicopter_landing");
	var_01 thread maps\_anim::anim_loop_solo(level.irons,"training_s2_irons_helicopter_idle");
	common_scripts\utility::flag_wait("training_s2_end_helicopter_irons_end");
	var_01 maps\_anim::anim_single_solo(level.irons,"training_s2_irons_helicopter");
}

//Function Number: 245
training_s2_helicopter_gideon()
{
	common_scripts\utility::flag_wait("training_s2_end_helicopter_setup_gideon");
	var_00 = getent("training_s2_ending_anim_origin","targetname");
	wait(6);
	level.gideon maps\_utility::delaythread(0.05,::maps\_anim::anim_self_set_time,"training_s2_gideon_helicopter",0.303);
	var_00 maps\_anim::anim_single_solo(level.gideon,"training_s2_gideon_helicopter");
}

//Function Number: 246
setup_outro()
{
	thread outro();
}

//Function Number: 247
outro()
{
	common_scripts\utility::flag_wait("outro_start");
	maps\_hud_util::fade_out(2,"black");
	maps\_utility::nextmission();
}

//Function Number: 248
tff_cleanup_vehicle(param_00)
{
	var_01 = "";
	switch(param_00)
	{
		case "training":
			var_01 = "tff_pre_training_to_tour_ride";
			break;

		case "tour_ride":
			var_01 = "tff_pre_tour_ride_to_tour_exo";
			break;
	}

	if(var_01 == "")
	{
		return;
	}

	level waittill(var_01);
	if(!isdefined(self))
	{
		return;
	}

	if(isremovedentity(self))
	{
		return;
	}

	maps\_vehicle_code::_freevehicle();
	self delete();
}