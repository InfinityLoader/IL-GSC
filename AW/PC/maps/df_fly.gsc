/*******************************************************************
 * Decompiled By: Bog
 * Decompiled File: df_fly.gsc
 * Game: Call of Duty: Advanced Warfare
 * Platform: PC
 * Function Count: 45
 * Decompile Time: 658 ms
 * Timestamp: 4/22/2024 2:28:39 AM
*******************************************************************/

//Function Number: 1
main()
{
	maps\_utility::template_level("df_fly");
	setsaveddvar("vehPlaneSwapSticks","0");
	maps\_utility::add_control_based_hint_strings("climb_hint",&"PLAYERPLANE_MOVEMENT_HINT",::climb_hint,&"PLAYERPLANE_MOVEMENT_HINT_PC",&"PLAYERPLANE_MOVEMENT_HINT_SP");
	maps\_utility::add_hint_string("boost_hint",&"PLAYERPLANE_AFTERBURNERS_HINT",::boost_hint);
	maps\_utility::add_hint_string("missile_hint",&"PLAYERPLANE_MISSILES_HINT",::missile_hint);
	maps\_utility::add_hint_string("airbrake_hint",&"PLAYERPLANE_BRAKE_HINT",::maps\df_canyon_script::airbrake_hint);
	maps\_utility::add_hint_string("airbrake_hint_pc_toggle",&"PLAYERPLANE_BRAKE_HINT_PC_TOGGLE",::maps\df_canyon_script::airbrake_hint);
	maps\_utility::add_hint_string("airbrake_hint_pc_hold",&"PLAYERPLANE_BRAKE_HINT_PC_HOLD",::maps\df_canyon_script::airbrake_hint);
	maps\_utility::add_hint_string("gun_hint",&"PLAYERPLANE_GUNS_HINT",::gun_hint);
	df_fly_precache();
	df_fly_pre_load();
	level.custom_no_game_setupfunc = ::canyon_no_game_start_setupfunc;
	maps\createart\df_fly_art::main();
	maps\df_fly_code::precache_code();
	maps\df_fly_fx::main();
	maps\df_fly_precache::main();
	maps\df_fly_anim::main();
	maps\createfx\df_fly_fx::main();
	df_fly_starts();
	maps\_load::main();
	maps\df_fly_lighting::main();
	maps\df_fly_aud::main();
	level thread maps\_upgrade_system::init();
	maps\df_fly_flight_code::flight_code_main();
}

//Function Number: 2
canyon_no_game_start_setupfunc()
{
	level.player lightsetforplayer("df_fly_canyon",0);
	maps\_utility::vision_set_fog_changes("df_fly_canyon",0);
	thread maps\df_fly_lighting::set_sun_flare();
}

//Function Number: 3
df_fly_starts()
{
	maps\_utility::add_start("canyon_intro",::setup_intro_canyon,"canyon_intro",::maps\df_canyon_script::begin_canyon_intro);
	maps\_utility::add_start("canyon",::maps\df_canyon_script::setup_canyon,"canyon",::maps\df_canyon_script::begin_canyon);
	maps\_utility::add_start("canyon2",::maps\df_canyon_script::setup_canyon2,"canyon2",::maps\df_canyon_script::begin_canyon2);
	maps\_utility::add_start("canyon_dam",::maps\df_canyon_script::setup_canyon_dam,"canyon_dam",::maps\df_canyon_script::begin_canyon_dam);
	maps\_utility::add_start("canyon3",::maps\df_canyon_script::setup_canyon3,"canyon3",::maps\df_canyon_script::begin_canyon3);
	maps\_utility::add_start("canyon_exit",::maps\df_canyon_script::setup_canyon_exit,"canyon_exit",::maps\df_canyon_script::begin_canyon_exit);
}

//Function Number: 4
setup_nothing()
{
}

//Function Number: 5
df_fly_precache()
{
	precachemodel("generic_prop_raven");
	precachemodel("viewbody_sentinel_pilot_mitchell");
	precachemodel("vehicle_sentinel_drop_pod_jet");
	precachemodel("sentinel_drop_pod");
	precachemodel("sentinel_drop_pod_vm");
	precachemodel("atlas_vtol_cargo_plane_ext_ai");
	precachemodel("atlas_vtol_cargo_plane_fuel_rod");
	precacheshader("overlay_static_digital");
	precacheshader("s1_railgun_hud_outer_shadow");
	precachemodel("vehicle_mig29");
	precacherumble("steady_rumble");
	precachestring(&"invert_flight_controls_popmenu");
	precachestring(&"flight_controls_setting_popmenu");
	precachestring(&"plane_hud_fade_out");
	precachestring(&"plane_hud_fade_in");
	precachestring(&"PLAYERPLANE_MOVEMENT_HINT");
	precachestring(&"PLAYERPLANE_AFTERBURNERS_HINT");
	precachestring(&"PLAYERPLANE_BRAKES_HINT");
	precachestring(&"PLAYERPLANE_MISSILES_HINT");
	precachestring(&"PLAYERPLANE_GUNS_HINT");
	precachestring(&"DF_BAGHDAD_YOU_CRASHED");
}

//Function Number: 6
df_fly_pre_load()
{
	common_scripts\utility::flag_init("finale_vo_done");
	common_scripts\utility::flag_init("hint_time");
	common_scripts\utility::flag_init("fuel_contact");
	common_scripts\utility::flag_init("fuel_complete");
	common_scripts\utility::flag_init("intro_scene_done");
	common_scripts\utility::flag_init("player_braking");
	common_scripts\utility::flag_init("intro_screen_done");
	common_scripts\utility::flag_init("intro_vo_done");
	common_scripts\utility::flag_init("controls_set");
	common_scripts\utility::flag_init("player_steered");
	common_scripts\utility::flag_init("boost_hint");
	common_scripts\utility::flag_init("intro_ally_enemies_dead");
	common_scripts\utility::flag_init("intro_enemies_dead");
	common_scripts\utility::flag_init("intro_regrouped");
	common_scripts\utility::flag_init("intro_finished");
	common_scripts\utility::flag_init("canyon_finished");
	common_scripts\utility::flag_init("end_fighter_jet_sequence");
	common_scripts\utility::flag_init("final_hit");
	common_scripts\utility::flag_init("finale");
	common_scripts\utility::flag_init("playerPlaneNoDeath");
	common_scripts\utility::flag_init("ambush_dead");
	common_scripts\utility::flag_init("ally_tailer_dead");
	common_scripts\utility::flag_init("airbrake_hint");
	common_scripts\utility::flag_init("dam_destroyed");
	common_scripts\utility::flag_init("hoodoo1");
	common_scripts\utility::flag_init("bridge_fall");
	common_scripts\utility::flag_init("red_hoodoo1");
	common_scripts\utility::flag_init("red_hoodoo2");
	common_scripts\utility::flag_init("red_hoodoo3");
	common_scripts\utility::flag_init("red_hoodoo3b");
	common_scripts\utility::flag_init("red_hoodoo3c");
	common_scripts\utility::flag_init("arch_r");
	common_scripts\utility::flag_init("arch_l");
	common_scripts\utility::flag_init("hoodoo_w1");
	common_scripts\utility::flag_init("hoodoo_w2");
	common_scripts\utility::flag_init("hoodoo_w3");
	common_scripts\utility::flag_init("hoodoo_w4");
	common_scripts\utility::flag_init("hoodoo_w5");
	common_scripts\utility::flag_init("dam_cracks2");
	common_scripts\utility::flag_init("explode_wall_hoodoo");
	common_scripts\utility::flag_init("trig_amb_enemywave_starters");
	common_scripts\utility::flag_init("trig_amb_enemywave1");
	common_scripts\utility::flag_init("trig_amb_enemywave2");
	common_scripts\utility::flag_init("trig_amb_enemywave3");
	common_scripts\utility::flag_init("trig_amb_enemywave4");
	common_scripts\utility::flag_init("trig_amb_enemywave5");
	common_scripts\utility::flag_init("trig_amb_enemywave6");
	common_scripts\utility::flag_init("trig_amb_enemywave7");
	common_scripts\utility::flag_init("trig_amb_enemywave8");
	common_scripts\utility::flag_init("trig_amb_enemywave9");
	common_scripts\utility::flag_init("trig_amb_enemywave10");
}

//Function Number: 7
setup_common()
{
	level.mini_version = 0;
	level.current_median_speed = 0.5;
	level.current_objective = 1;
	level.player_fired_missiles = 0;
	level.base_agl = 62000;
	level.ally_ai_active = 0;
	level.allies = [];
	maps\_utility::add_extra_autosave_check("fly_check",::autosave_fly_check,"can\'t autosave when about to crash");
	thread maps\df_canyon_script::handle_dying_player_brake_hint();
}

//Function Number: 8
autosave_fly_check()
{
	var_00 = 3;
	var_01 = 0.1;
	var_02 = 20;
	var_03 = 3;
	var_04 = 2;
	var_05 = level.plane;
	var_06 = var_05 maps\_shg_utility::get_differentiated_acceleration();
	var_07 = var_05 vehicle_getvelocity();
	var_08 = length(var_07);
	if(var_08 > 0)
	{
		var_09 = var_07 + var_06 * var_01 * 0.5;
		var_0A = var_05.origin;
		var_0B = var_05.origin + var_09 * var_00;
		var_0C = bullettrace(var_0A,var_0B,0,var_05);
		if(var_0C["fraction"] < 1 && !isdefined(var_0C["entity"]) || !isdefined(var_0C["entity"].targetname) || var_0C["entity"].targetname != "turnaround_vol")
		{
			var_0D = distance(var_05.origin,var_0C["position"]);
			var_0E = var_0D / var_08;
			if(var_0E > var_01 + 0.01)
			{
				var_0F = vectorlerp(var_05.origin + var_09 * var_01,var_0C["position"],0.5);
				var_10 = var_0E - var_01 * var_02;
				var_11 = var_0E;
				var_12 = randomfloat(90);
				foreach(var_14 in [0,90,180,270])
				{
					var_15 = anglestoforward(combineangles(var_05.angles,combineangles((0,0,var_14 + var_12),(var_10,0,0))));
					var_16 = var_0F + var_15 * var_08 * var_00;
					var_17 = bullettrace(var_0F,var_16,0,var_05);
					var_18 = distance(var_05.origin,var_17["position"]) / var_08 + var_0E;
					var_11 = max(var_11,var_18);
				}
			}
			else
			{
				var_11 = var_0E;
			}
		}
		else
		{
			var_11 = var_00;
		}
	}
	else
	{
		var_11 = var_01;
	}

	return var_11 >= var_00;
}

//Function Number: 9
intro_movie()
{
	level.player disableweapons();
	level.player freezecontrols(1);
	var_00 = newclienthudelem(level.player);
	var_00 setshader("black",1280,720);
	var_00.horzalign = "fullscreen";
	var_00.vertalign = "fullscreen";
	var_00.alpha = 1;
	var_00.foreground = 0;
	maps\_shg_utility::play_chyron_video("chyron_text_df_fly");
	thread maps\df_canyon_script::canyon_intro_vo();
	common_scripts\utility::flag_wait("intro_vo_done");
	wait(1);
	common_scripts\utility::flag_set("intro_screen_done");
	var_00 fadeovertime(2);
	var_00.alpha = 0;
	wait(2);
	var_00 destroy();
}

//Function Number: 10
setup_intro()
{
	setup_common();
	level.player freezecontrols(1);
}

//Function Number: 11
setup_intro_old_controls()
{
	level.old_controls = 1;
	setup_intro();
}

//Function Number: 12
setup_intro_canyon()
{
	setup_common();
	level.player freezecontrols(1);
	soundscripts\_snd::snd_message("snd_start_canyon_intro");
}

//Function Number: 13
setup_intro_canyon_old_controls()
{
	level.old_controls = 1;
	setup_intro_canyon();
}

//Function Number: 14
setup_post_refuel()
{
	setup_common();
	level.player freezecontrols(1);
	common_scripts\utility::flag_set("intro_screen_done");
	common_scripts\utility::flag_set("intro_scene_done");
}

//Function Number: 15
setup_post_refuel_old_controls()
{
	level.old_controls = 1;
	setup_post_refuel();
}

//Function Number: 16
post_refuel()
{
	level.old_gravity = getdvarfloat("vehPlaneGravityVelocity");
	setsaveddvar("vehPlaneGravityVelocity",0);
	thread intro_vo();
	thread handle_intro_clip();
	maps\df_fly_flight_code::flight_code_start("intro_player_jet",1);
	thread handle_gun_hint();
	for(var_00 = 1;var_00 <= 3;var_00++)
	{
		var_01 = "ally" + var_00;
		var_02 = getent(var_01,"script_noteworthy");
		var_02 maps\df_fly_flight_code::make_ally_jet(level.plane,1,1);
	}

	thread handle_clouds(level.plane,"intro_finished");
	var_03 = maps\_utility::obj("intro_follow");
	objective_add(var_03,"current","Stay in formation");
	objective_onentity(var_03,level.allies[0],(0,0,0));
	objective_setpointertextoverride(var_03,"Follow");
	for(var_00 = 1;var_00 < level.allies.size;var_00++)
	{
		objective_additionalentity(var_03,var_00,level.allies[var_00],(0,0,0));
	}

	wait(1);
	maps\_utility::delaythread(2,::handle_formation_nags);
	level.player freezecontrols(0);
	level.player thread maps\_utility::display_hint_timeout("climb_hint",5);
	var_04 = 0;
	common_scripts\utility::flag_set("controls_set");
	common_scripts\utility::flag_wait("set_waypoint");
	level.player luiopenmenu(&"invert_flight_controls_popmenu");
	var_05 = getent("waypoint1","targetname");
	var_06 = maps\_utility::obj("intro_waypoint");
	objective_add(var_06,"current","Proceed to waypoint");
	objective_onentity(var_06,var_05,(0,0,0));
	objective_setpointertextoverride(var_06,"Reach");
	common_scripts\utility::flag_wait("waypoint1_reached");
	maps\_utility::objective_complete(var_06);
	common_scripts\utility::flag_wait("intro_bogeys");
	level notify("ignore_formation");
	soundscripts\_snd::snd_music_message("df_fly_jet_combat");
	common_scripts\utility::array_thread(level.allies,::maps\df_fly_flight_code::set_optimal_flight_dist,10000,1);
	maps\_utility::objective_complete(var_03);
	level.enemy_units = [];
	level.next_obj_pos = 0;
	var_07 = maps\_vehicle::spawn_vehicles_from_targetname_and_drive("intro_enemy");
	thread maps\df_fly_code::ai_array_killcount_flag_set(var_07,var_07.size,"intro_enemies_dead");
	thread maps\df_fly_code::ai_array_killcount_flag_set(var_07,var_07.size - 1,"intro_ally_enemies_dead");
	common_scripts\utility::array_thread(var_07,::maps\df_fly_flight_code::make_enemy_jet,"dogfight_enemies");
	var_08 = maps\_utility::obj("dogfight_enemies");
	level.enemy_objectives = var_07;
	initmultiobjectives("dogfight_enemies",var_07);
	thread multiple_objectives("dogfight_enemies");
	common_scripts\utility::flag_wait("boost_hint");
	level.player thread maps\_utility::display_hint_timeout("boost_hint",5);
	common_scripts\utility::flag_wait("shoot_missiles");
	level.player thread maps\_utility::display_hint_timeout("missile_hint",5);
	var_07 = maps\_utility::remove_dead_from_array(var_07);
	thread dogfight_vo(var_07);
	var_09 = maps\df_fly_flight_code::get_jet_array("player_enemy");
	common_scripts\utility::array_thread(var_09,::maps\df_fly_flight_code::set_optimal_flight_dist,1000,1);
	thread enemies_move_away();
	var_0A = maps\df_fly_flight_code::get_jet_array("ally_enemy");
	maps\df_fly_flight_code::engage_enemies(level.allies,var_0A,5,10);
	common_scripts\utility::array_thread(level.allies,::maps\df_fly_flight_code::set_optimal_flight_dist,1500,1);
	thread nag_player_to_shoot_target(var_09);
	common_scripts\utility::flag_wait("intro_ally_enemies_dead");
	common_scripts\utility::array_thread(level.allies,::maps\df_fly_flight_code::set_optimal_flight_dist,1000,1);
	common_scripts\utility::flag_wait("intro_enemies_dead");
	common_scripts\utility::array_thread(level.allies,::maps\df_fly_flight_code::set_optimal_flight_dist,4000,1);
	level.allies[2] maps\df_fly_flight_code::set_optimal_flight_dist(6000,1);
	maps\_utility::objective_complete(maps\_utility::obj("dogfight_enemies"));
	thread setup_regroup_obj();
	wait(0.5);
	level.plane maps\df_fly_code::wait_for_formation(level.allies,7000,2);
	common_scripts\utility::array_thread(level.allies,::maps\df_fly_flight_code::set_optimal_flight_dist,8000,1);
	common_scripts\utility::flag_set("intro_regrouped");
	common_scripts\utility::flag_wait("drop_down");
	maps\_utility::objective_complete(maps\_utility::obj("intro_regroup"));
	common_scripts\utility::flag_set("intro_finished");
	common_scripts\utility::flag_wait("intro_finished");
	level.player maps\_hud_util::fade_out(1,"white");
	wait(1);
	setsaveddvar("vehPlaneGravityVelocity",level.old_gravity);
	foreach(var_0C in level.allies)
	{
		var_0C delete();
	}

	level.allies = [];
}

//Function Number: 17
multiple_objectives(param_00)
{
	foreach(var_02 in level.enemy_objectives)
	{
		var_02 thread objectivedeathdetection(param_00);
	}
}

//Function Number: 18
objectivedeathdetection(param_00)
{
	self endon("removed");
	self waittill("death");
	level.enemy_objectives = common_scripts\utility::array_remove(level.enemy_objectives,self);
	objective_delete(maps\_utility::obj(param_00));
	initmultiobjectives(param_00,level.enemy_objectives);
}

//Function Number: 19
initmultiobjectives(param_00,param_01)
{
	objective_add(maps\_utility::obj(param_00),"current","Dogfight enemy aircraft");
	objective_setpointertextoverride(maps\_utility::obj(param_00),"Destroy");
	var_02 = 0;
	foreach(var_04 in param_01)
	{
		objective_additionalentity(maps\_utility::obj(param_00),var_02,param_01[var_02]);
		var_02++;
	}
}

//Function Number: 20
handle_gun_hint()
{
	level.player_shot_guns = 0;
	while(!level.player_shot_guns && !isdefined(level.plane.lock_target))
	{
		wait(0.2);
		if(isdefined(level.plane.lock_target))
		{
			level.player thread maps\_utility::display_hint_timeout("gun_hint",5);
			wait(10);
		}
	}
}

//Function Number: 21
enemies_move_away()
{
	wait(3);
	var_00 = maps\_utility::remove_dead_from_array(level.enemy_units);
	common_scripts\utility::array_thread(var_00,::maps\df_fly_flight_code::set_optimal_flight_dist,15000,1);
}

//Function Number: 22
handle_clouds(param_00,param_01)
{
	playfxontag(common_scripts\utility::getfx("bagh_flight_cloud_volume"),param_00,"tag_origin");
	var_02 = common_scripts\utility::getstructarray("large_cloud","targetname");
	foreach(var_04 in var_02)
	{
		playfx(common_scripts\utility::getfx("large_cloud"),var_04.origin,anglestoforward(var_04.angles));
	}

	common_scripts\utility::flag_wait(param_01);
	stopfxontag(common_scripts\utility::getfx("bagh_flight_cloud_volume"),param_00,"tag_origin");
}

//Function Number: 23
handle_intro_clip()
{
	var_00 = getent("intro_clip","script_noteworthy");
	var_00 notsolid();
	common_scripts\utility::flag_wait("in_the_sky");
	var_00 solid();
}

//Function Number: 24
nag_player_to_shoot_target(param_00)
{
	level endon("intro_enemies_dead");
	wait(10);
	var_01 = param_00[0];
	if(isalive(var_01))
	{
		level.player maps\df_fly_code::radio_dialog_add_and_go("df_gid_getonthat");
		var_02 = undefined;
		var_03 = 0;
		foreach(var_05 in level.allies)
		{
			var_06 = distance2dsquared(var_05.origin,var_01.origin);
			if(var_03 == 0 || var_06 < var_03)
			{
				var_02 = var_05;
			}
		}

		var_02 thread maps\df_fly_flight_code::shoot_target_till_dead(var_01,3,10);
	}
}

//Function Number: 25
setup_regroup_obj()
{
	var_00 = maps\_utility::obj("intro_regroup");
	objective_add(var_00,"current","Regroup with flight wing.");
	objective_onentity(var_00,level.allies[0],(0,0,0));
	objective_setpointertextoverride(var_00,"Follow");
	for(var_01 = 1;var_01 < level.allies.size;var_01++)
	{
		objective_additionalentity(var_00,var_01,level.allies[var_01],(0,0,0));
	}
}

//Function Number: 26
dogfight_vo(param_00)
{
	var_01 = [];
	var_01[0] = "df_gid_onedown";
	var_01[1] = "df_nox_scratchone";
	var_01[2] = "df_nox_spanked";
	var_02[3] = "df_nox_trgtdestroyed";
	var_03 = [];
	var_03[0] = "df_gid_niceshot";
	var_03[1] = "df_gid_goodshot";
	var_03[2] = "df_gid_sierrahotel";
	var_03[3] = "df_nox_niceshootin";
	var_04 = "";
	var_05 = 0;
	var_06 = 0;
	for(var_07 = 0;var_07 < param_00.size - 1;var_07++)
	{
		var_08 = level common_scripts\utility::waittill_any_return("enemy_dead","enemy_dead_by_player");
		if(var_08 == "enemy_dead_by_player")
		{
			var_04 = var_03[var_06];
			var_06++;
		}
		else
		{
			var_04 = var_01[var_05];
			var_05++;
		}

		maps\df_fly_code::radio_dialog_add_and_go(var_04);
	}
}

//Function Number: 27
intro_vo()
{
	common_scripts\utility::flag_wait("intro_scene_done");
	level.player maps\df_fly_code::radio_dialog_add_and_go("df_gid_refuelcomp");
	wait(0.5);
	level.player maps\df_fly_code::radio_dialog_add_and_go("df_so_unwantedattention");
	common_scripts\utility::flag_wait_or_timeout("set_waypoint",11);
	common_scripts\utility::flag_set("set_waypoint");
	level.player maps\df_fly_code::radio_dialog_add_and_go("df_so_alphnovember");
	level.player maps\df_fly_code::radio_dialog_add_and_go("df_gid_eyespeeled");
	common_scripts\utility::flag_wait("waypoint1_reached");
	level.player maps\df_fly_code::radio_dialog_add_and_go("df_so_runposition");
	level.player maps\df_fly_code::radio_dialog_add_and_go("df_gid_fencein");
	level.player maps\df_fly_code::radio_dialog_add_and_go("df_nox_active");
	level.player maps\df_fly_code::radio_dialog_add_and_go("df_mag_online");
	common_scripts\utility::flag_wait("intro_bogeys");
	level.player maps\df_fly_code::radio_dialog_add_and_go("df_nox_4bogies");
	common_scripts\utility::flag_set("boost_hint");
	level.player maps\df_fly_code::radio_dialog_add_and_go("df_gid_burnerson");
	common_scripts\utility::flag_set("shoot_missiles");
	level.player maps\df_fly_code::radio_dialog_add_and_go("df_gid_bumpingheads");
	level.ally_ai_active = 1;
	common_scripts\utility::flag_wait("intro_enemies_dead");
	level.player maps\df_fly_code::radio_dialog_add_and_go("df_gid_thatsall");
	level.player maps\df_fly_code::radio_dialog_add_and_go("df_gid_regroup");
	common_scripts\utility::flag_wait("intro_regrouped");
	level.player thread maps\df_fly_code::radio_dialog_add_and_go("df_gid_chereubsnine");
	thread drop_down();
}

//Function Number: 28
handle_formation_nags()
{
	level endon("ignore_formation");
	var_00 = 8000;
	var_01 = [];
	var_01[0] = "df_gid_stayinformation";
	var_01[1] = "df_gid_return";
	var_01[2] = "df_gid_return";
	var_02 = 0;
	for(;;)
	{
		level.plane maps\df_fly_code::wait_for_formation_break(level.allies,var_00,1);
		level.player maps\df_fly_code::radio_dialog_add_and_go(var_01[var_02]);
		var_02++;
		if(var_02 > var_01.size)
		{
			var_02 = 0;
		}

		wait(5);
		if(!maps\df_fly_code::plane_in_formation(level.plane,level.allies,var_00))
		{
			level.player thread maps\df_fly_code::radio_dialog_add_and_go("df_gid_jeopardizing");
		}
	}
}

//Function Number: 29
intro_screen()
{
	var_00 = 20;
	thread maps\_introscreen::introscreen(1,var_00);
	wait(var_00);
	common_scripts\utility::flag_set("intro_screen_done");
}

//Function Number: 30
gun_hint()
{
	if(level.player_shot_guns)
	{
		return 1;
	}

	return 0;
}

//Function Number: 31
missile_hint()
{
	if(level.player_fired_missiles)
	{
		return 1;
	}

	return 0;
}

//Function Number: 32
boost_hint()
{
	if(level.player_boosting)
	{
		return 1;
	}

	return 0;
}

//Function Number: 33
climb_hint()
{
	if(common_scripts\utility::flag("player_steered"))
	{
		return 1;
	}

	return 0;
}

//Function Number: 34
wait_for_stick_press()
{
	var_00 = 0.1;
	var_01 = maps\_utility::make_array(0,0);
	var_02 = 0;
	var_03 = 7;
	while(var_02 < var_03)
	{
		if(level.player common_scripts\utility::is_player_gamepad_enabled())
		{
			var_01 = self getnormalizedmovement();
			if(abs(var_01[0]) > var_00)
			{
				var_02 = var_02 + 0.05;
			}

			if(var_02 > 1)
			{
				common_scripts\utility::flag_set("player_steered");
			}

			continue;
		}

		var_02 = var_02 + 0.05;
		if(var_02 > 3)
		{
			common_scripts\utility::flag_set("player_steered");
		}

		wait(0.05);
	}

	common_scripts\utility::flag_set("controls_set");
}

//Function Number: 35
drop_down()
{
	var_00 = 1;
	var_01 = "a";
	foreach(var_03 in level.allies)
	{
		var_03 maps\df_fly_flight_code::set_optimal_flight_dist(5000);
		if(var_00 == 1)
		{
			var_01 = var_03 find_drop_path();
		}

		var_04 = "ally_drop_path" + var_00 + var_01;
		var_05 = getvehiclenode(var_04,"targetname");
		var_03 thread maps\_vehicle::vehicle_paths(var_05);
		var_03 startpath(var_05);
		var_00++;
	}
}

//Function Number: 36
find_drop_path()
{
	var_00 = getvehiclenodearray("drop_down_start","script_noteworthy");
	var_01 = -1;
	var_02 = "z";
	foreach(var_04 in var_00)
	{
		var_05 = var_04.targetname[var_04.targetname.size - 1];
		if(var_05 != var_02)
		{
			if(maps\_utility::get_dot(self.origin,self.angles,var_04.origin) > 0.93)
			{
				var_06 = distance2dsquared(self.origin,var_04.origin);
				if(var_01 == -1 || var_06 < var_01)
				{
					var_01 = var_06;
					var_02 = var_05;
				}
			}
		}
	}

	return var_02;
}

//Function Number: 37
intro_scene(param_00)
{
	var_01 = [];
	foreach(var_03 in param_00)
	{
		var_04 = var_03 maps\_utility::spawn_vehicle();
		var_01[var_01.size] = var_04;
		var_04.animname = "ally" + var_04.script_noteworthy[var_04.script_noteworthy.size - 1];
		var_04 useanimtree(level.scr_animtree[var_04.animname]);
	}

	common_scripts\utility::array_thread(var_01,::playfakecontrail);
	var_06 = maps\_utility::spawn_anim_model("refueler");
	var_07 = maps\_utility::spawn_anim_model("fuel_rod");
	var_08 = maps\_utility::spawn_anim_model("cockpit");
	level.intro_arms = maps\_utility::spawn_anim_model("player_rig");
	playfxontag(level._effect["cloud_vtol_wing_wispy"],var_06,"TAG_BODY");
	var_09 = maps\_utility::make_array(level.intro_arms,var_06,var_08);
	var_09 = common_scripts\utility::array_combine(var_09,var_01);
	var_0A = common_scripts\utility::getstruct("intro_struct","targetname");
	var_07 linkto(var_06,"TAG_FUEL_ROD");
	level.player playerlinktoabsolute(level.intro_arms,"tag_player");
	level.player disableweapons();
	level.player allowcrouch(0);
	level.player disableoffhandweapons();
	level.player disableweaponswitch();
	thread setup_generic_allies();
	thread refuel_vo();
	thread refuel_timings();
	var_06 thread maps\_anim::anim_single_solo(var_07,"intro","TAG_FUEL_ROD");
	var_0A maps\_anim::anim_single(var_09,"intro");
	level.player unlink();
	common_scripts\utility::array_call(var_09,::delete);
	common_scripts\utility::flag_set("intro_scene_done");
}

//Function Number: 38
refuel_timings()
{
	wait(8.55);
	common_scripts\utility::flag_set("fuel_contact");
	wait(14);
	common_scripts\utility::flag_set("fuel_complete");
}

//Function Number: 39
refuel_vo()
{
	level.player maps\df_fly_code::radio_dialog_add_and_go("df_atc_clearedastern");
	wait(0.5);
	level.player maps\df_fly_code::radio_dialog_add_and_go("df_rp_clearedcontact");
	common_scripts\utility::flag_wait("fuel_contact");
	level.player maps\df_fly_code::radio_dialog_add_and_go("df_rp_takinggas");
	common_scripts\utility::flag_wait("fuel_complete");
	level.player maps\df_fly_code::radio_dialog_add_and_go("df_atc_offloadcomp");
	wait(0.5);
	level.player maps\df_fly_code::radio_dialog_add_and_go("df_gid_thanksforgas");
}

//Function Number: 40
unlimit_player_view(param_00)
{
	level.player playerlinktodelta(level.intro_arms,"tag_player",0.9,70,70,20,20,1);
}

//Function Number: 41
limit_player_view(param_00)
{
	level.player playerlinktoblend(level.intro_arms,"tag_player",0.5);
}

//Function Number: 42
setup_generic_allies()
{
	var_00 = common_scripts\utility::getstructarray("generic_allies_struct","targetname");
	var_01 = common_scripts\utility::getstructarray("generic_allies_no_tanker_struct","targetname");
	var_02 = common_scripts\utility::getstructarray("generic_allies_squad2","targetname");
	var_03 = common_scripts\utility::getstructarray("generic_allies_squad3","targetname");
	var_00 = maps\df_fly_flight_code::array_combine_all(var_00,var_01,var_02,var_03);
	var_04 = [];
	foreach(var_06 in var_00)
	{
		var_07 = "";
		switch(var_06.targetname)
		{
			case "generic_allies_squad2":
				var_07 = "_s2";
				break;

			case "generic_allies_squad3":
				var_07 = "_s3";
				break;
		}

		var_08 = maps\_utility::spawn_anim_model("ally1" + var_07 + "_generic");
		var_09 = maps\_utility::spawn_anim_model("ally2" + var_07 + "_generic");
		var_0A = maps\_utility::spawn_anim_model("ally3" + var_07 + "_generic");
		var_0B = maps\_utility::spawn_anim_model("ally4" + var_07 + "_generic");
		var_0C = maps\_utility::make_array(var_08,var_09,var_0A,var_0B);
		if(var_06.targetname == "generic_allies_struct")
		{
			var_0D = maps\_utility::spawn_anim_model("refueler_generic");
			var_0C = common_scripts\utility::array_add(var_0C,var_0D);
		}

		var_04[var_04.size] = var_0C;
		var_06 thread maps\_anim::anim_loop(var_0C,"intro_idle","exit");
		var_0E = randomfloat(1);
		wait 0.05;
		foreach(var_10 in var_0C)
		{
			var_10 setanimtime(level.scr_anim[var_10.animname]["intro_idle"][0],var_0E);
		}
	}

	wait(10);
	for(var_13 = 0;var_13 < var_04.size;var_13++)
	{
		var_14 = var_04[var_13];
		var_06 = var_00[var_13];
		var_06 thread generic_squadron_deploy(var_14);
		wait(randomfloatrange(0.8,1.5));
	}
}

//Function Number: 43
generic_squadron_deploy(param_00)
{
	foreach(var_02 in param_00)
	{
		var_02 notify("exit");
	}

	common_scripts\utility::array_thread(param_00,::fly_away_be_free,self);
}

//Function Number: 44
fly_away_be_free(param_00)
{
	param_00 maps\_anim::anim_single_solo(self,"intro_exit");
	self delete();
}

//Function Number: 45
playfakecontrail()
{
	playfxontag(level._effect["cloud_wing_wispy"],self,"tag_origin");
}