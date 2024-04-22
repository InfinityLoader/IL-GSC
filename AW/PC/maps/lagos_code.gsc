/*******************************************************************
 * Decompiled By: Bog
 * Decompiled File: lagos_code.gsc
 * Game: Call of Duty: Advanced Warfare
 * Platform: PC
 * Function Count: 362
 * Decompile Time: 5282 ms
 * Timestamp: 4/22/2024 2:33:42 AM
*******************************************************************/

//Function Number: 1
lagos_title_screen()
{
	level.player disableweapons();
	level.player freezecontrols(1);
	thread maps\_shg_utility::play_chyron_video("chyron_text_lagos",2,3);
	common_scripts\utility::flag_wait("chyron_video_done");
	soundscripts\_snd::snd_message("intro_fly_drone_idle");
}

//Function Number: 2
setup_gameplay()
{
	setup_alpha_squad();
	thread squad_opening();
	thread exo_door();
	thread government_building();
	thread roundabout_setup();
	thread roundabout_combat();
	thread spawncivilians_roundabout();
	thread roundabout_traffic();
	thread alley1_combat();
	thread alley1_oncoming();
	thread alley2_combat();
	thread flank_combat();
	thread frogger_combat();
	thread traffic_rooftop_traverse();
	thread traffic_takedown();
	thread level_bounds();
	thread level_progress();
	thread flank_alley_door_kick();
	player_upkeep();
}

//Function Number: 3
monitorstartdronecontrol(param_00,param_01)
{
	if(!isdefined(param_00))
	{
		param_00 = 0;
	}

	if(!isdefined(param_01))
	{
		param_01 = 1;
	}

	var_02 = getent("PlayerDroneStartpoint","targetname");
	var_03 = getent("PlayerDroneTargetpoint","targetname");
	var_04 = getent("PlayerDroneLookAt","targetname");
	var_05 = [];
	var_05[var_05.size] = getent("FlyDroneBottomN","targetname");
	var_05[var_05.size] = getent("FlyDroneBottomE","targetname");
	var_05[var_05.size] = getent("FlyDroneBottomS","targetname");
	var_05[var_05.size] = getent("FlyDroneBottomW","targetname");
	level.player thread maps\_controlled_orbiting_drone::startdronecontrol(var_03,var_02,var_04,param_00,param_01,var_05);
	if(param_00 == 1)
	{
		wait(0.25);
		level.player setblurforplayer(0,1);
		wait(0.25);
		maps\_hud_util::fade_in(0.5,"white");
	}

	thread monitorenddronecontrol();
}

//Function Number: 4
monitorenddronecontrol()
{
	common_scripts\utility::flag_wait("FlagPlayerEndDroneControl");
	maps\_controlled_orbiting_drone::enddronecontrol();
	drone_intro_fov_shift_off();
}

//Function Number: 5
hide_radio()
{
}

//Function Number: 6
setup_alpha_squad()
{
	level.burke = getent("burke","targetname") maps\_utility::spawn_ai(1,1);
	level.joker = getent("joker","targetname") maps\_utility::spawn_ai(1,1);
	level.ajani = getent("ajani","targetname") maps\_utility::spawn_ai(1,1);
	level.ajani thread hide_radio();
	level.burke maps\_utility::forceuseweapon("iw5_bal27_sp","primary");
	level.joker maps\_utility::forceuseweapon("iw5_bal27_sp","primary");
	level.burke.animname = "burke";
	level.joker.animname = "joker";
	level.ajani.animname = "ajani";
	level.alpha_squad = [level.burke,level.joker,level.ajani];
	level.alpha_squad_and_player = [level.burke,level.joker,level.ajani,level.player];
}

//Function Number: 7
drone_intro()
{
	thread maps\_player_exo::player_exo_deactivate();
	var_00 = 105;
	level.origfov = getdvarint("cg_fov");
	level.player lerpfov(var_00,0.5);
	common_scripts\utility::flag_set("fly_drone_in_progess");
	thread lagos_title_screen();
	thread drone_intro_kva_front_setup();
	thread drone_intro_nig_mil_setup();
	thread drone_intro_conf_room_scene();
	thread gov_hostage_h_breach_doors();
	common_scripts\utility::flag_wait("chyron_video_done");
	thread maps\lagos_vo::fly_drone_intro_dialogue();
	wait(5);
	thread vig_tram_setup_intro();
	thread drone_start_player_input();
	common_scripts\utility::flag_wait("flag_player_input_for_drone_start");
	wait(1);
	thread maps\lagos_utility::rumble_flydrone_animation();
	thread maps\lagos_utility::fly_drone_ui_on();
	thread monitorstartdronecontrol(1,0);
	level waittill("drone_opening_finished");
	common_scripts\utility::flag_set("fly_drone_done_lighting");
	common_scripts\utility::flag_set("intro_playerstart");
	level.fly_drone_rumbling = 0;
	level notify("fly_drone_not_moving");
	maps\_utility::teleport_player(common_scripts\utility::getstruct("intro_playerstart","targetname"));
	level.player freezecontrols(0);
	maps\_shg_utility::show_player_hud();
	level notify("drone_intro_complete");
	common_scripts\utility::flag_set("obj_rescue_PM");
	wait(1);
	common_scripts\utility::flag_set("FlagPlayerEndDroneControl");
}

//Function Number: 8
drone_intro_fov_shift()
{
	var_00 = 105;
	level.origfov = getdvarint("cg_fov");
	level.player lerpfov(var_00,0.5);
	level waittill("drone_opening_finished");
	level.player lerpfov(level.origfov,2);
}

//Function Number: 9
drone_intro_fov_shift_on(param_00)
{
	var_01 = 50;
	level.player lerpfov(var_01,0.1);
}

//Function Number: 10
drone_intro_fov_shift_off(param_00)
{
	level.player lerpfov(level.origfov,0.5);
}

//Function Number: 11
drone_intro_conf_room_scene()
{
	var_00 = getent("anim_org_drone_opening","targetname");
	level.player maps\_shg_utility::setup_player_for_scene();
	var_01 = maps\_utility::spawn_anim_model("player_arms");
	level.player playerlinktodelta(var_01,"tag_player",1,30,30,0,0,1);
	soundscripts\_snd::snd_message("fly_drone_camera_start_1",var_01,level.player);
	var_01 hide();
	var_02 = getent("kva_hostage_leader","targetname");
	level.kva_hostage_leader = var_02 maps\_utility::spawn_ai(1);
	level.kva_hostage_leader.animname = "kva_hostage_leader";
	level.kva_hostage_leader maps\_utility::gun_remove();
	level.kva_hostage_leader attach("npc_titan45_nocamo","TAG_WEAPON_RIGHT",0);
	var_03 = getent("kva_hostage_minister_intro","targetname");
	level.kva_hostage_minister = var_03 maps\_utility::spawn_ai(1);
	level.kva_hostage_minister.animname = "kva_hostage_minister";
	level.kva_hostage_minister maps\_utility::gun_remove();
	level.kva_hostage_minister.name = "";
	var_04 = getent("kva_hostage_victim","targetname");
	level.kva_hostage_victim = var_04 maps\_utility::spawn_ai(1);
	level.kva_hostage_victim.animname = "kva_hostage_victim";
	level.kva_hostage_victim maps\_utility::gun_remove();
	var_05 = maps\_utility::spawn_anim_model("drone_photo");
	var_05 maps\_utility::assign_animtree();
	var_05 attach("lag_polaroid_hostage_photo","TAG_ORIGIN_animated",0);
	var_06 = maps\_utility::spawn_anim_model("pm_cuffs");
	var_06 maps\_utility::assign_animtree();
	var_07 = maps\_utility::spawn_anim_model("vic_cuffs");
	var_07 maps\_utility::assign_animtree();
	var_00 thread maps\_anim::anim_loop_solo(var_01,"drone_opening_idle","player_input_for_drone_start");
	common_scripts\utility::flag_wait("flag_player_input_for_drone_start");
	var_00 notify("player_input_for_drone_start");
	thread maps\lagos_h_breach::drone_intro_conf_flythrough_actors(var_00);
	var_08 = [];
	var_08[0] = level.kva_hostage_leader;
	var_08[1] = level.kva_hostage_minister;
	var_08[2] = level.kva_hostage_victim;
	var_08[3] = var_05;
	var_08[4] = var_06;
	var_08[5] = var_07;
	var_09 = drone_intro_anim_length();
	thread drone_flyin_vm(var_00,var_01);
	var_00 thread maps\_anim::anim_single(var_08,"drone_opening");
	if(level.currentgen)
	{
		thread set_stream_origin_for_intro();
	}

	wait(var_09);
	thread maps\_introscreen::introscreen_generic_black_fade_in(1,0.89,0.1);
	level notify("drone_opening_finished");
	wait(0.5);
	foreach(var_0B in var_08)
	{
		var_0B delete();
	}

	var_01 delete();
}

//Function Number: 12
set_stream_origin_for_intro()
{
	var_00 = drone_intro_anim_length();
	var_00 = var_00 - 10;
	wait(var_00);
	var_01 = (-49739,15569,314);
	level.player playersetstreamorigin(var_01);
	common_scripts\utility::flag_wait("squad_opening_start");
	wait(2);
	level.player playerclearstreamorigin();
}

//Function Number: 13
drone_start_player_input()
{
	thread maps\lagos_utility::hint_instant(&"LAGOS_START_FLY_DRONE");
	soundscripts\_snd::snd_message("fly_drone_picture_live");
	while(!common_scripts\utility::flag("flag_player_input_for_drone_start"))
	{
		if(level.player usebuttonpressed())
		{
			common_scripts\utility::flag_set("flag_player_input_for_drone_start");
			soundscripts\_snd::snd_message("fly_drone_activate");
			wait(0.25);
			thread maps\lagos_utility::hint_fade_instant();
			return;
		}

		wait 0.05;
	}
}

//Function Number: 14
drone_flyin_vm(param_00,param_01)
{
	param_00 maps\_anim::anim_single_solo(param_01,"drone_opening_player_control");
	common_scripts\utility::flag_set("drone_fly_anim_done");
}

//Function Number: 15
drone_intro_anim_length()
{
	var_00 = getanimlength(%lag_gov_hostage_room_flythrough_vm);
	var_01 = 1.5;
	var_02 = var_00 - var_01;
	return var_02;
}

//Function Number: 16
drone_intro_kva_front_setup()
{
	var_00 = common_scripts\utility::getstruct("anim_org_drone_intro2","targetname");
	var_01 = getent("drone_intro_spawner","targetname");
	var_02 = [];
	var_03 = 6;
	for(var_04 = 0;var_04 < var_03;var_04++)
	{
		var_01.count = 1;
		var_05 = var_01 maps\_utility::spawn_ai(1);
		wait 0.05;
		var_05.animname = "drone_intro";
		var_05 thread maps\lagos_utility::disable_awareness();
		var_02 = common_scripts\utility::array_add(var_02,var_05);
	}

	var_06 = maps\_utility::spawn_anim_model("intro_duffle");
	var_06 maps\_utility::assign_animtree();
	var_02 = common_scripts\utility::array_add(var_02,var_06);
	level.kva_opening_vo = var_02[5];
	wait(2);
	common_scripts\utility::flag_wait("flag_player_input_for_drone_start");
	var_00 thread maps\_anim::anim_single_solo(var_02[0],"drop_bag");
	var_00 thread maps\_anim::anim_single_solo(var_02[1],"run_into_room");
	var_00 thread maps\_anim::anim_single_solo(var_02[2],"aim_turret");
	var_00 thread maps\_anim::anim_single_solo(var_02[3],"aim_forward");
	var_00 thread maps\_anim::anim_single_solo(var_02[4],"guy_5");
	var_00 thread maps\_anim::anim_single_solo(var_02[5],"guy_6");
	var_00 thread maps\_anim::anim_single_solo(var_06,"drop_bag");
	var_02[2] maps\_utility::gun_remove();
	level waittill("drone_intro_complete");
	foreach(var_08 in var_02)
	{
		if(isdefined(var_08) && isalive(var_08))
		{
			var_08 delete();
		}
	}
}

//Function Number: 17
drone_intro_nig_mil_setup()
{
	common_scripts\utility::flag_wait("flag_player_input_for_drone_start");
	var_00 = getentarray("militia_drive_start_front","targetname");
	var_01 = [];
	foreach(var_03 in var_00)
	{
		var_04 = var_03 maps\_utility::spawn_ai(1);
		var_03.count = 1;
		var_04.goalradius = 16;
		var_04 thread maps\_utility::magic_bullet_shield(1);
		var_01 = common_scripts\utility::array_add(var_01,var_04);
		var_04 thread gov_building_firefight_change_pos();
	}

	level waittill("drone_intro_complete");
	foreach(var_04 in var_01)
	{
		var_04 delete();
	}
}

//Function Number: 18
warbird_hide_blury_rotors()
{
	self hidepart("TAG_SPIN_MAIN_ROTOR_L");
	self hidepart("TAG_SPIN_MAIN_ROTOR_R");
	self hidepart("TAG_SPIN_TAIL_ROTOR");
}

//Function Number: 19
squad_opening()
{
	level.squad_opening_warbird = getent("squad_opening_warbird","targetname");
	thread opening_prop_deletes();
	common_scripts\utility::flag_wait("obj_rescue_PM");
	common_scripts\utility::flag_wait("squad_opening_start");
	thread vig_intro_civ_populate();
	if(common_scripts\utility::flag("no_anim_squad_opening"))
	{
		return;
	}

	var_00 = [];
	var_01 = getent("anim_org_opening_squad","targetname");
	var_02 = var_01 common_scripts\utility::spawn_tag_origin();
	var_02.origin = var_02.origin - (0,0,7);
	soundscripts\_snd::snd_message("start_intro_ambience");
	level.squad_opening_warbird.origin = level.squad_opening_warbird.origin + (70000,0,0);
	level.squad_opening_warbird.animname = "squad_opening_warbird";
	level.squad_opening_warbird maps\_utility::assign_animtree();
	level.squad_opening_warbird soundscripts\_snd::snd_message("opening_warbird");
	level.squad_opening_warbird warbird_hide_blury_rotors();
	var_03 = maps\_utility::spawn_anim_model("lag_intro_prop1");
	var_01 maps\_anim::anim_first_frame_solo(var_03,"squad_opening");
	var_04 = maps\_utility::spawn_anim_model("lag_intro_prop2");
	var_01 maps\_anim::anim_first_frame_solo(var_04,"squad_opening");
	level.player maps\_shg_utility::setup_player_for_scene();
	level.player enableslowaim(0.2,0.2);
	var_05 = maps\_utility::spawn_anim_model("player_rig");
	var_01 maps\_anim::anim_first_frame_solo(var_05,"squad_opening");
	level.player playerlinktodelta(var_05,"tag_player",1,7,7,5,5,1);
	var_06 = [var_03,var_04];
	var_02 thread maps\_anim::anim_first_frame([level.squad_opening_warbird],"squad_opening");
	var_01 maps\_anim::anim_first_frame(var_06,"squad_opening");
	thread maps\lagos_vo::pcap_squad_briefing();
	thread squad_intro_walkway_goto();
	var_01 thread maps\_anim::anim_single(var_06,"squad_opening");
	var_02 thread maps\_anim::anim_single([level.squad_opening_warbird],"squad_opening");
	self.animarrayfuncs["exposed"]["stand"] = ::animscripts\corner::set_standing_animarray_aiming;
	self.animarrayfuncs["exposed"]["crouch"] = ::animscripts\corner::set_crouching_animarray_aiming;
	level.burke thread squad_intro_anim_burke(var_01);
	level.joker thread squad_intro_anim_joker(var_01);
	level.ajani thread squad_intro_anim_ajani(var_01);
	thread squad_opening_names();
	var_01 maps\_anim::anim_single_solo(var_05,"squad_opening");
	common_scripts\utility::flag_set("obj_rescue_PM_pos");
	level.player unlink();
	var_05 delete();
	level.player maps\_shg_utility::setup_player_for_gameplay();
	level.player disableslowaim();
	level.player disableinvulnerability();
	level.player enableweapons();
	level.player enableweaponswitch();
	level.player enableoffhandweapons();
	level.player allowads(1);
	maps\_utility::autosave_by_name();
	level notify("intro_walkway_go");
	thread maps\_player_exo::player_exo_activate();
	common_scripts\utility::flag_wait("vo_squad_move_out_dialogue");
	thread maps\lagos_vo::squad_move_out_dialogue();
	level waittill("gov_driveup_started");
	level.squad_opening_warbird delete();
}

//Function Number: 20
opening_prop_deletes()
{
	wait(3);
	if(common_scripts\utility::flag("obj_progress_exo_door_clear"))
	{
		level.squad_opening_warbird delete();
	}
}

//Function Number: 21
squad_opening_names()
{
	level.burke thread maps\lagos_utility::hide_friendname_until_flag_or_notify("show_names");
	level.joker thread maps\lagos_utility::hide_friendname_until_flag_or_notify("show_names");
	level.ajani thread maps\lagos_utility::hide_friendname_until_flag_or_notify("show_names");
	wait(0.5);
	level notify("show_names");
}

//Function Number: 22
squad_intro_anim_burke(param_00)
{
	var_01 = level.burke gettagorigin("J_SpineUpper");
	var_02 = level.burke gettagangles("J_SpineUpper");
	var_03 = maps\_utility::spawn_anim_model("rooftop_breach_device");
	var_03.origin = var_01;
	var_03.angles = var_02;
	wait 0.05;
	var_03 linkto(level.burke,"J_SpineUpper",(5,-6,0),(0,0,90));
	thread maps\lagos_utility::ally_redirect_goto_node("Gideon","intro_walkway_burke",1,::maps\lagos_utility::disable_awareness);
	param_00 maps\_anim::anim_single_solo_run(level.burke,"squad_opening");
	level waittill("roof_breach_start");
	var_03 delete();
}

//Function Number: 23
squad_intro_anim_joker(param_00)
{
	thread maps\lagos_utility::ally_redirect_goto_node("Joker","intro_walkway_joker",1,::maps\lagos_utility::disable_awareness);
	param_00 maps\_anim::anim_single_solo_run(self,"squad_opening");
}

//Function Number: 24
squad_intro_anim_ajani(param_00)
{
	thread maps\lagos_utility::ally_redirect_goto_node("Ajani","intro_walkway_ajani",1,::maps\lagos_utility::disable_awareness);
	param_00 maps\_anim::anim_single_solo_run(self,"squad_opening");
}

//Function Number: 25
squad_intro_fov_shift_on(param_00)
{
	var_01 = 50;
	level.player lerpfov(var_01,0.5);
}

//Function Number: 26
squad_intro_fov_shift_off(param_00)
{
	if(!isdefined(level.origfov))
	{
		level.origfov = 65;
	}

	level.player lerpfov(level.origfov,0.5);
}

//Function Number: 27
vig_intro_civ_populate()
{
	thread vig_vehicle_traffic_init();
	thread vig_vehicle_removal();
	thread vig_civ_traffic_init();
	if(level.nextgen)
	{
		thread vig_bike_rider_maintainer("bike_rider_path",5);
	}

	thread vig_tram_setup();
	thread vig_mil_balc_setup();
	level notify("tram_start");
}

//Function Number: 28
vig_vehicle_traffic_init()
{
	if(!level.currentgen)
	{
		level.intro_reg_vehicles = [];
		thread vig_vehicle_traffic_scripted_left();
		thread vig_vehicle_traffic_scripted_right();
	}
}

//Function Number: 29
vig_vehicle_traffic_straight_mover_movement(param_00)
{
	var_01 = int(self.script_parameters);
	var_02 = randomfloatrange(3,7);
	var_03 = randomfloatrange(0.5,1.5);
	var_04 = randomfloatrange(0.5,1.5);
	if(isdefined(param_00))
	{
		level waittill(param_00);
		self moveto(self.origin + (0,var_01 * -1,0),var_02,var_03,var_04);
		wait(var_02);
		level notify("straight_done_moving");
		return;
	}

	self moveto(self.origin + (0,var_01 * -1,0),var_02,var_03,var_04);
	level notify("straight_done_moving");
}

//Function Number: 30
vig_vehicle_traffic_turn_mover_movement(param_00,param_01)
{
	var_02 = maps\_utility::spawn_vehicle();
	var_02 thread vig_vehicle_fail_on_death();
	wait(randomfloat(0.75));
	var_02 maps\_vehicle::gopath();
	wait(randomfloat(0.55));
	var_02 vehicle_setspeedimmediate(0,50,50);
	if(isdefined(param_00))
	{
		level waittill(param_00);
	}

	if(!iscaralive(var_02))
	{
		return;
	}

	level.intro_reg_vehicles = common_scripts\utility::array_add(level.intro_reg_vehicles,var_02);
	var_02 vehicle_setspeed(5,10,10);
	var_02 maps\_vehicle::gopath();
	var_02 waittill("goal");
	if(isdefined(param_01))
	{
		level notify(param_01);
	}
}

//Function Number: 31
vig_vehicle_traffic_scripted_left()
{
	var_00 = 1;
	var_01 = 8;
	var_02 = getent("turn_mover1_lt","script_noteworthy");
	var_03 = getent("turn_mover3_lt","script_noteworthy");
	var_04 = getent("turn_mover4_lt","script_noteworthy");
	var_05 = getent("turn_mover5_lt","script_noteworthy");
	var_06 = getent("turn_mover6_lt","script_noteworthy");
	var_07 = getent("turn_mover7_lt","script_noteworthy");
	var_02 thread vig_vehicle_traffic_turn_mover_movement("mover1_go","mover1_stop");
	var_03 thread vig_vehicle_traffic_turn_mover_movement("mover3_go","mover1_stop");
	var_04 thread vig_vehicle_traffic_turn_mover_movement("mover4_go","mover1_stop");
	var_05 thread vig_vehicle_traffic_turn_mover_movement("mover5_go","mover1_stop");
	var_06 thread vig_vehicle_traffic_turn_mover_movement("mover6_go","mover1_stop");
	var_07 thread vig_vehicle_traffic_turn_mover_movement("mover7_go","mover1_stop");
	level waittill("intro_walkway_go");
	level notify("mover1_go");
	wait(randomfloatrange(var_00,var_01));
	wait(randomfloatrange(var_00,var_01));
	level notify("mover3_go");
	wait(randomfloatrange(var_00,var_01));
	level notify("mover4_go");
	wait(randomfloatrange(var_00,var_01));
	level notify("mover5_go");
	wait(randomfloatrange(var_00,var_01));
	level notify("mover6_go");
	wait(randomfloatrange(var_00,var_01));
	level notify("mover7_go");
}

//Function Number: 32
vig_vehicle_traffic_scripted_right()
{
	var_00 = 1;
	var_01 = 8;
	var_02 = getent("turn_mover1_rt","script_noteworthy");
	var_03 = getent("turn_mover3_rt","script_noteworthy");
	var_04 = getent("turn_mover4_rt","script_noteworthy");
	var_05 = getent("turn_mover6_rt","script_noteworthy");
	var_06 = getent("turn_mover7_rt","script_noteworthy");
	var_02 thread vig_vehicle_traffic_turn_mover_movement("mover1_go","mover1_stop");
	var_03 thread vig_vehicle_traffic_turn_mover_movement("mover3_go","mover1_stop");
	var_04 thread vig_vehicle_traffic_turn_mover_movement("mover4_go","mover1_stop");
	var_05 thread vig_vehicle_traffic_turn_mover_movement("mover6_go","mover1_stop");
	var_06 thread vig_vehicle_traffic_turn_mover_movement("mover7_go","mover1_stop");
	level waittill("intro_walkway_go");
	level notify("mover1_go");
	wait(randomfloatrange(var_00,var_01));
	wait(randomfloatrange(var_00,var_01));
	level notify("mover3_go");
	wait(randomfloatrange(var_00,var_01));
	level notify("mover4_go");
	wait(randomfloatrange(var_00,var_01));
	wait(randomfloatrange(var_00,var_01));
	level notify("mover6_go");
	wait(randomfloatrange(var_00,var_01));
	level notify("mover7_go");
}

//Function Number: 33
vig_vehicle_traffic_jammer()
{
	level.intro_traffic_lanes = ["traffic_lane1","traffic_lane2","traffic_lane3","traffic_lane4"];
	var_00 = undefined;
	for(;;)
	{
		level.intro_traffic_lanes = common_scripts\utility::array_randomize(level.intro_traffic_lanes);
		var_01 = level.intro_traffic_lanes[0];
		if(isdefined(var_00) && var_01 == var_00)
		{
			wait 0.05;
			continue;
		}

		thread maps\_vehicle_traffic::traffic_path_head_car_traffic_jam(var_01);
		wait(randomfloatrange(5,10));
		thread maps\_vehicle_traffic::traffic_path_head_car_traffic_jam_end_thread(var_01);
		wait(randomfloatrange(10,20));
		var_00 = var_01;
	}
}

//Function Number: 34
vig_vehicle_traffic_removal()
{
	level waittill("remove_civs");
	maps\_vehicle_traffic::delete_traffic_path("traffic_lane1");
	maps\_vehicle_traffic::delete_traffic_path("traffic_lane2");
	maps\_vehicle_traffic::delete_traffic_path("traffic_lane3");
	maps\_vehicle_traffic::delete_traffic_path("traffic_lane4");
}

//Function Number: 35
vig_vehicle_fail_on_death()
{
	level endon("remove_civs");
	while(iscaralive(self))
	{
		wait 0.05;
	}

	setdvar("ui_deadquote",&"SCRIPT_MISSIONFAIL_CIVILIAN_KILLED");
	maps\_utility::missionfailedwrapper();
}

//Function Number: 36
iscaralive(param_00)
{
	if(!isdefined(param_00))
	{
		return 0;
	}

	if(issubstr(param_00.classname,"corpse"))
	{
		return 0;
	}

	return 1;
}

//Function Number: 37
vig_vehicle_removal()
{
	var_00 = getentarray("intro_vehicles_static","targetname");
	level waittill("remove_civs");
	foreach(var_02 in var_00)
	{
		var_02 delete();
	}

	if(isdefined(level.intro_reg_vehicles))
	{
		foreach(var_02 in level.intro_reg_vehicles)
		{
			var_02 delete();
		}
	}
}

//Function Number: 38
vig_civ_traffic_init()
{
	level.vig_civ_streetarray = [];
	level.vig_walker_streetarray = [];
	thread vig_civ_traffic_balcony_setup();
	thread vig_civ_traffic_street_setup();
}

//Function Number: 39
vig_civ_traffic_balcony_setup()
{
	var_00 = getent("balcony_traffic_civ_male","targetname");
	var_01 = getent("balcony_traffic_civ_female","targetname");
	var_02 = common_scripts\utility::getstructarray("civ_vig_loc_male_balcony","targetname");
	var_03 = common_scripts\utility::getstructarray("civ_vig_loc_female_balcony","targetname");
	thread vig_civ_traffic_spawn_idle_drones(var_00,var_02);
	thread vig_civ_traffic_spawn_idle_drones(var_01,var_03);
}

//Function Number: 40
vig_civ_traffic_street_setup()
{
	var_00 = getent("street_traffic_civ_male","targetname");
	var_01 = common_scripts\utility::getstructarray("civ_vig_loc_street_lt","targetname");
	var_02 = common_scripts\utility::getstructarray("civ_vig_loc_street_rt","targetname");
	thread vig_civ_traffic_spawn_idle_drones(var_00,var_01);
	thread vig_civ_traffic_spawn_idle_drones(var_00,var_02);
}

//Function Number: 41
vig_civ_traffic_spawn_idle_drones(param_00,param_01,param_02)
{
	foreach(var_04 in param_01)
	{
		var_05 = param_00 maps\_utility::dronespawn();
		if(isdefined(param_02))
		{
			if(maps\_utility::s1_motionset_avaliable())
			{
				var_05 maps\_drone::drone_set_archetype_idle("s1_soldier");
			}
			else
			{
				var_05 maps\_drone::drone_set_archetype_idle("soldier");
			}
		}

		level.vig_civ_streetarray = common_scripts\utility::array_add(level.vig_civ_streetarray,var_05);
		param_00.count = 1;
		var_05.origin = var_04.origin;
		var_05.angles = var_04.angles;
		wait 0.05;
		if(isdefined(var_04.animation))
		{
			var_05 thread maps\lagos_utility::loopingidleanimation(var_04);
		}

		var_05 thread vig_civ_removal();
	}
}

//Function Number: 42
vig_civ_fail_on_damage()
{
	self setcandamage(1);
	self waittill("damage");
	setdvar("ui_deadquote",&"LAGOS_FAIL_FRIENDLY_FIRE");
	maps\_utility::missionfailedwrapper();
}

//Function Number: 43
vig_civ_traffic_walker_setup()
{
	var_00 = 10;
	var_01 = [];
	var_02 = getent("civ_walker_lt_female","targetname");
	var_03 = getent("civ_walker_lt_male","targetname");
	var_01 = common_scripts\utility::array_add(var_01,var_02);
	var_01 = common_scripts\utility::array_add(var_01,var_03);
	var_04 = common_scripts\utility::getstructarray("vig_walker_lt_start","targetname");
	var_05 = getnodearray("vig_walker_lt_endpoint","targetname");
	thread vig_civ_traffic_spawn_walker_drones(var_01,var_04,var_05,var_00);
	var_06 = [];
	var_07 = getent("civ_walker_rt_female","targetname");
	var_08 = getent("civ_walker_rt_male","targetname");
	var_06 = common_scripts\utility::array_add(var_06,var_07);
	var_06 = common_scripts\utility::array_add(var_06,var_08);
	var_09 = common_scripts\utility::getstructarray("vig_walker_rt_start","targetname");
	var_0A = getnodearray("vig_walker_rt_endpoint","targetname");
	thread vig_civ_traffic_spawn_walker_drones(var_06,var_09,var_0A,var_00);
}

//Function Number: 44
vig_civ_traffic_spawn_walker_drones(param_00,param_01,param_02,param_03)
{
	foreach(var_05 in param_01)
	{
		param_00 = common_scripts\utility::array_randomize(param_00);
		param_02 = common_scripts\utility::array_randomize(param_02);
		param_00[0].count = 1;
		if(level.vig_walker_streetarray.size < param_03)
		{
			var_06 = param_00[0] maps\_utility::spawn_ai(1);
			level.vig_walker_streetarray = common_scripts\utility::array_add(level.vig_walker_streetarray,var_06);
			var_06.goalradius = 32;
			var_06.ignoreall = 1;
			var_06 forceteleport(var_05.origin,var_05.angles);
			wait 0.05;
			var_06 setgoalnode(param_02[0]);
			var_06 thread vig_civ_walker_removal();
		}
	}

	thread vig_civ_walker_maintainer(param_00,param_01,param_02,param_03);
}

//Function Number: 45
vig_civ_walker_maintainer(param_00,param_01,param_02,param_03)
{
	level endon("remove_civs");
	for(;;)
	{
		if(level.vig_walker_streetarray.size < param_03)
		{
			param_01 = common_scripts\utility::array_randomize(param_01);
			param_02 = common_scripts\utility::array_randomize(param_02);
			param_00 = common_scripts\utility::array_randomize(param_00);
			param_00[0].count = 1;
			var_04 = param_00[0] maps\_utility::spawn_ai(1);
			level.vig_walker_streetarray = common_scripts\utility::array_add(level.vig_walker_streetarray,var_04);
			var_04.goalradius = 32;
			var_04 forceteleport(param_01[0].origin,param_01[0].angles);
			wait 0.05;
			var_04 setgoalnode(param_02[0]);
			var_04 thread vig_civ_walker_removal();
		}

		wait 0.05;
	}
}

//Function Number: 46
vig_civ_model_randomizer()
{
	var_00 = [];
	var_00[0] = "body_africa_civ_male_a";
	var_00[1] = "body_africa_civ_male_b";
	var_00[2] = "body_africa_civ_male_c";
	var_00[3] = "body_india_female_a";
	var_00[4] = "body_india_female_b";
	var_00[5] = "body_london_female_bb";
	var_00[6] = "body_city_civ_male_a";
	var_00[7] = "body_city_civ_female_a";
	var_00 = common_scripts\utility::array_randomize(var_00);
	return var_00[0];
}

//Function Number: 47
vig_civ_removal()
{
	level waittill("remove_civs");
	level.vig_civ_streetarray = common_scripts\utility::array_remove(level.vig_civ_streetarray,self);
	self delete();
}

//Function Number: 48
vig_civ_walker_removal()
{
	self waittill("goal");
	level.vig_walker_streetarray = common_scripts\utility::array_remove(level.vig_walker_streetarray,self);
	self delete();
}

//Function Number: 49
vig_mil_balc_setup()
{
	var_00 = getent("militiaSoldier","targetname");
	var_01 = getent("atlasSoldier","targetname");
	var_02 = common_scripts\utility::getstructarray("mil_vig_loc_soldier","targetname");
	var_03 = common_scripts\utility::getstructarray("mil_vig_loc_soldier2","targetname");
	thread vig_civ_traffic_spawn_idle_drones(var_00,var_02,1);
	thread vig_civ_traffic_spawn_idle_drones(var_01,var_03,1);
}

//Function Number: 50
vig_bike_rider_init(param_00,param_01)
{
	if(!isdefined(param_01) || param_01 == 0)
	{
		param_01 = 1;
	}

	for(var_02 = 0;var_02 < param_01;var_02++)
	{
		param_00 = common_scripts\utility::array_randomize(param_00);
		var_03 = param_00[0];
		var_04 = spawn("script_model",var_03.origin);
		var_04.angles = var_03.angles;
		var_05 = spawn("script_model",var_04.origin);
		if(common_scripts\utility::cointoss())
		{
			var_05 character\character_civilian_slum_male_aa::main();
		}
		else
		{
			var_05 character\character_civilian_slum_male_ab::main();
		}

		var_05 useanimtree(#animtree);
		var_05 setanim(level.scr_anim["generic"]["bike_rider"]);
		var_06 = randomint(6);
		switch(var_06)
		{
			case 0:
				var_04 setmodel("vehicle_scooter_vespa_static_blue");
				thread vig_bike_rider_scooter(var_04,var_05,var_03);
				break;

			case 1:
				var_04 setmodel("vehicle_scooter_vespa_static_green");
				thread vig_bike_rider_scooter(var_04,var_05,var_03);
				break;

			case 2:
				var_04 setmodel("vehicle_scooter_vespa_static_cream");
				thread vig_bike_rider_scooter(var_04,var_05,var_03);
				break;

			case 3:
				var_04 setmodel("vehicle_scooter_vespa_static_lightblue");
				thread vig_bike_rider_scooter(var_04,var_05,var_03);
				break;

			case 4:
				vig_bike_rider_cyclist(var_04,var_05,var_03);
				break;

			case 5:
				vig_bike_rider_cyclist(var_04,var_05,var_03);
				break;
		}

		wait(randomfloatrange(2,5));
	}
}

//Function Number: 51
vig_bike_rider_maintainer(param_00,param_01)
{
	level endon("remove_bikers");
	level.bike_riders = [];
	var_02 = common_scripts\utility::getstructarray(param_00,"targetname");
	thread vig_bike_rider_removal();
	for(;;)
	{
		if(level.bike_riders.size < param_01)
		{
			var_03 = param_01 - level.bike_riders.size;
			thread vig_bike_rider_init(var_02,var_03);
		}

		wait(randomfloatrange(2,5));
	}
}

//Function Number: 52
vig_bike_rider_scooter(param_00,param_01,param_02)
{
	param_01.origin = param_00.origin;
	param_01.angles = param_00.angles;
	param_01 linkto(param_00);
	level.bike_riders = common_scripts\utility::array_add(level.bike_riders,param_01);
	level.bike_riders = common_scripts\utility::array_add(level.bike_riders,param_00);
	param_00 thread vig_bike_rider_nav(param_01,param_00,param_02);
}

//Function Number: 53
vig_bike_rider_cyclist(param_00,param_01,param_02)
{
	param_00 setmodel("com_bike_animated");
	param_00 useanimtree(level.scr_animtree["bike"]);
	param_00 setanim(level.scr_anim["bike"]["pedal"]);
	param_01.origin = param_00 gettagorigin("j_frame");
	param_01.origin = param_01.origin + (-12,0,-30);
	param_01.angles = param_00 gettagangles("j_frame");
	param_01.angles = param_01.angles + (0,180,0);
	param_01 linkto(param_00,"j_frame");
	level.bike_riders = common_scripts\utility::array_add(level.bike_riders,param_01);
	level.bike_riders = common_scripts\utility::array_add(level.bike_riders,param_00);
	param_00 thread vig_bike_rider_nav(param_01,param_00,param_02);
}

//Function Number: 54
vig_bike_rider_nav(param_00,param_01,param_02)
{
	level endon("remove_bikers");
	var_03 = 0.0025;
	for(;;)
	{
		var_04 = common_scripts\utility::getstruct(param_02.target,"targetname");
		var_05 = vig_bike_rider_set_speed(param_02,var_04,var_03);
		var_06 = vectortoangles(param_02.origin - var_04.origin);
		if(param_01.model == "com_bike_animated")
		{
			param_01.angles = (0,var_06[1],0);
		}
		else
		{
			param_01.angles = (0,var_06[1] + 180,0);
		}

		param_01 moveto(var_04.origin,var_05,0,0);
		if(!isdefined(var_04.target))
		{
			wait(var_05);
			level.bike_riders = common_scripts\utility::array_remove(level.bike_riders,param_00);
			level.bike_riders = common_scripts\utility::array_remove(level.bike_riders,param_01);
			param_01 delete();
			param_00 delete();
			return;
		}

		wait(var_05);
		param_02 = var_04;
	}
}

//Function Number: 55
vig_bike_rider_set_speed(param_00,param_01,param_02)
{
	var_03 = distance(param_00.origin,param_01.origin);
	var_04 = param_02 * var_03;
	return var_04 + 0.05;
}

//Function Number: 56
vig_bike_rider_removal()
{
	level waittill("remove_bikers");
	foreach(var_01 in level.bike_riders)
	{
		var_01 delete();
	}
}

//Function Number: 57
vig_tram_setup()
{
	var_00 = getent("anim_monorail","targetname");
	var_01 = maps\_utility::spawn_anim_model("intro_tram1");
	var_01 thread vig_tram_setup_car_fx();
	thread vig_tram_setup_movement(var_01,"tram1_movement",var_00,"tram_shutdown");
	var_01 soundscripts\_snd::snd_message("vig_tram_setup_car",1);
	common_scripts\utility::flag_wait("flag_intro_walkway");
	var_02 = maps\_utility::spawn_anim_model("intro_tram1");
	var_02 thread vig_tram_setup_car_fx();
	thread vig_tram_setup_movement(var_02,"tram2_movement",var_00,"tram_shutdown");
	var_02 soundscripts\_snd::snd_message("vig_tram_setup_car",1);
	common_scripts\utility::flag_wait("tram_shutdown");
	var_03 = maps\_utility::spawn_anim_model("intro_tram1");
	var_03 thread vig_tram_setup_car_fx();
	thread vig_tram_setup_movement(var_03,"tram3_movement",var_00,undefined);
	var_03 soundscripts\_snd::snd_message("vig_tram_setup_car",0,0.4);
	common_scripts\utility::flag_wait("exo_door_trigger");
	var_02 delete();
	common_scripts\utility::flag_wait("gov_h_breach_adv2");
	var_01 delete();
	var_03 delete();
}

//Function Number: 58
vig_tram_setup_movement(param_00,param_01,param_02,param_03)
{
	var_04 = [param_00];
	if(isdefined(param_03))
	{
		while(!common_scripts\utility::flag(param_03))
		{
			param_02 maps\_anim::anim_single(var_04,param_01);
			wait(randomintrange(20,30));
		}

		return;
	}

	param_02 maps\_anim::anim_single(var_04,param_01);
	maps\_anim::anim_set_time(var_04,param_01,1);
	param_00 notify("tram_shutdown");
}

//Function Number: 59
vig_tram_setup_car_fx()
{
	self endon("tram_delete");
	self endon("tram_shutdown");
	var_00 = common_scripts\utility::getfx("tram_dust");
	var_01 = common_scripts\utility::getfx("tram_sparks");
	playfxontag(var_00,self,"car01");
	playfxontag(var_00,self,"car02");
	playfxontag(var_00,self,"car03");
	playfxontag(var_01,self,"car01");
	playfxontag(var_01,self,"car02");
	playfxontag(var_01,self,"car03");
}

//Function Number: 60
vig_tram_setup_car_shaker(param_00,param_01)
{
	self endon("tram_delete");
	self endon("tram_shutdown");
	for(;;)
	{
		var_02 = distance(self.origin,level.player.origin);
		if(var_02 < param_00)
		{
			earthquake(0.4,param_01,self.origin,param_00);
			wait(param_01);
		}

		wait 0.05;
	}
}

//Function Number: 61
vig_tram_setup_intro()
{
	var_00 = getent("anim_org_drone_opening","targetname");
	var_01 = maps\_utility::spawn_anim_model("intro_tram1");
	var_00 maps\_anim::anim_single_solo(var_01,"tram1_flythrough");
	var_01 delete();
}

//Function Number: 62
squad_intro_walkway_goto()
{
	level waittill("intro_walkway_go");
	common_scripts\utility::flag_wait("flag_intro_walkway");
	thread squad_exo_door_goto();
}

//Function Number: 63
squad_exo_door_goto()
{
	thread maps\lagos_utility::ally_redirect_goto_node("Gideon","exo_door_burke",1,::maps\lagos_utility::disable_awareness);
	thread maps\lagos_utility::ally_redirect_goto_node("Joker","exo_door_joker",1,::maps\lagos_utility::disable_awareness);
	thread maps\lagos_utility::ally_redirect_goto_node("Ajani","exo_door_ajani",1,::maps\lagos_utility::disable_awareness);
	thread gov_transition_clean_up();
}

//Function Number: 64
gov_transition_clean_up()
{
	common_scripts\utility::flag_wait("flag_level_progress_exoDoor");
	level notify("remove_civs");
	level notify("remove_bikers");
}

//Function Number: 65
exo_door_disable_melee()
{
	level endon("flag_exo_door_started");
	for(;;)
	{
		self waittill("trigger",var_00);
		if(isplayer(var_00))
		{
			level.player allowmelee(0);
			thread maps\lagos_utility::hint_instant(&"LAGOS_EXO_DOOR_BREACH");
			while(common_scripts\utility::flag("flag_exo_door_trigger"))
			{
				if(level.player meleebuttonpressed())
				{
					thread maps\lagos_utility::hint_fade_instant();
					common_scripts\utility::flag_set("flag_exo_door_started");
					return;
				}

				wait 0.05;
			}

			level.player allowmelee(1);
			thread maps\lagos_utility::hint_fade_instant();
		}
	}
}

//Function Number: 66
exo_door()
{
	level.player endon("death");
	var_00 = getent("exo_door_model","targetname");
	var_00 overridematerial("mtl_lag_exo_door_breach_broken","mtl_lag_exo_door_breach");
	if(level.currentgen)
	{
		var_00 overridematerial("mq/mtl_lag_exo_door_breach_broken","mq/mtl_lag_exo_door_breach");
	}

	var_00.animname = "exo_door_model";
	var_00 maps\_utility::assign_animtree();
	var_01 = getent("anim_org_exo_door","targetname");
	var_01 maps\_anim::anim_first_frame_solo(var_00,"exo_door");
	var_02 = [var_00];
	common_scripts\utility::flag_wait("gov_transition_door_close");
	thread gov_building_firefight_setup();
	thread gov_building_firefight_driveup();
	common_scripts\utility::flag_wait("flag_irons_videolog_complete");
	common_scripts\utility::flag_wait("exo_door_trigger");
	common_scripts\utility::run_thread_on_targetname("trigger_player_ready_for_exo_door",::exo_door_disable_melee);
	var_03 = getent("exo_door_trigger","targetname");
	var_04 = common_scripts\utility::getstruct("obj_exo_door","targetname");
	var_05 = var_03 maps\_shg_utility::hint_button_trigger("melee",400);
	common_scripts\utility::flag_wait("flag_exo_door_started");
	var_05 maps\_shg_utility::hint_button_clear();
	var_03 makeunusable();
	level.player maps\_utility::store_players_weapons("player_weapons");
	var_06 = maps\_player_exo::player_exo_is_active_single("shield");
	if(var_06)
	{
		level.player maps\_player_exo::player_exo_remove_single("shield");
	}

	level.player takeallweapons();
	soundscripts\_snd::snd_message("plr_exo_door_kick");
	common_scripts\utility::flag_set("obj_progress_exo_door_clear");
	level notify("tram_stop");
	level notify("gov_driveup_go");
	wait(0.5);
	common_scripts\utility::flag_set("exo_door_lighting");
	common_scripts\utility::flag_set("done_exo_door_kick");
	level.player maps\_shg_utility::setup_player_for_scene();
	var_07 = maps\_utility::spawn_anim_model("player_rig");
	var_08 = getent("exo_door_blocker","targetname");
	var_08 delete();
	var_01 maps\_anim::anim_first_frame_solo(var_07,"exo_door");
	var_07 hide();
	var_09 = 0.5;
	level.player playerlinktoblend(var_07,"tag_player",var_09,var_09 * 0.5,var_09 * 0.5);
	wait(var_09);
	var_07 show();
	level.player playerlinktodelta(var_07,"tag_player",1,7,7,5,5,1);
	var_02 = common_scripts\utility::array_add(var_02,var_07);
	thread exo_door_tilt_camera_during_animation(var_07);
	var_07 common_scripts\utility::delaycall(3.333333,::hide);
	var_01 maps\_anim::anim_single(var_02,"exo_door");
	var_00 overridematerialreset();
	wait 0.05;
	level.player unlink();
	var_07 delete();
	level.player maps\_shg_utility::setup_player_for_gameplay();
	level.player maps\_utility::restore_players_weapons("player_weapons");
	if(var_06)
	{
		level.player maps\_player_exo::player_exo_add_single("shield");
	}

	level notify("gov_driveup_started");
	common_scripts\utility::flag_wait("vo_government_building_reveal_dialogue");
	thread maps\lagos_vo::government_building_reveal_dialogue();
	level notify("nig_mil_start_shoot");
	maps\_utility::autosave_by_name();
}

//Function Number: 67
exo_door_tilt_camera_during_animation(param_00)
{
	level.player endon("death");
	wait(3);
	level.player lerpviewangleclamp(1,0.75,0.25,45,45,0,0);
}

//Function Number: 68
gov_building_firefight_init_shooting()
{
	level waittill("nig_mil_start_shoot");
	foreach(var_01 in level.gov_soldiers_front)
	{
		var_01 thread gov_building_ai_timed_shooting();
	}

	foreach(var_04 in level.gov_kva_soldiers)
	{
		var_04 thread gov_building_ai_timed_shooting();
	}

	foreach(var_07 in level.gov_soldiers_veh)
	{
		var_07 thread gov_building_ai_timed_shooting();
	}
}

//Function Number: 69
gov_building_mil_devstart_setup()
{
	var_00 = getnode("tram_bridge_burke","targetname");
	level.burke maps\_utility::teleport_ai(var_00);
	var_01 = getnode("tram_bridge_joker","targetname");
	level.joker maps\_utility::teleport_ai(var_01);
	var_02 = getnode("tram_bridge_ajani","targetname");
	level.ajani maps\_utility::teleport_ai(var_02);
	level.burke thread maps\lagos_utility::disable_awareness();
	level.joker thread maps\lagos_utility::disable_awareness();
	level.ajani thread maps\lagos_utility::disable_awareness();
	thread gov_building_exo_climb_goto();
}

//Function Number: 70
gov_building_firefight_setup()
{
	level.gov_soldiers_front = [];
	level.gov_soldiers_veh = [];
	level.gov_kva_soldiers = [];
	if(!common_scripts\utility::flag("government_courtyard_playerstart"))
	{
		thread gov_building_ally_goto();
	}

	thread gov_building_firefight_roadblock();
	thread gov_building_firefight_front_soldiers();
	thread gov_building_firefight_kva();
	thread gov_roof_breach_anim_chunks();
	level waittill("firefight_init");
	foreach(var_01 in level.alpha_squad_and_player)
	{
		var_01.ignoreall = 1;
	}

	foreach(var_04 in level.gov_kva_soldiers)
	{
		var_04.ignoreall = 1;
	}

	foreach(var_07 in level.gov_soldiers_front)
	{
		var_07.ignoreall = 1;
	}

	common_scripts\utility::flag_wait("gov_driveup_complete");
	wait(2);
	maps\_utility::activate_trigger("mil_driveup_trigger","targetname",level.player);
}

//Function Number: 71
gov_building_firefight_driveup()
{
	level waittill("gov_driveup_go");
	thread gov_building_firefight_driveup_explode();
	level.gov_veh_spawners = getentarray("gov_veh_spawner","targetname");
	foreach(var_01 in level.gov_veh_spawners)
	{
		var_02 = var_01 maps\_utility::spawn_vehicle();
		var_02 soundscripts\_snd::snd_message("gov_bldg_driveup");
		var_02 thread gov_building_firefight_removal();
		maps\_vehicle::gopath(var_02);
		wait(randomfloatrange(0.75,1));
	}

	if(level.currentgen)
	{
		wait(0.5);
	}

	level.gov_soldiers_veh = maps\_utility::get_living_ai_array("gov_building_soldier","script_noteworthy");
	var_04 = maps\_utility::get_living_ai_array("gov_building_soldier_explode","script_noteworthy");
	level.gov_soldiers_veh = common_scripts\utility::array_combine(var_04,level.gov_soldiers_veh);
	foreach(var_06 in level.gov_soldiers_veh)
	{
		var_06 thread gov_building_firefight_removal();
		var_06 thread maps\_utility::magic_bullet_shield(1);
		var_06 thread maps\lagos_utility::disable_awareness();
		var_06 thread gov_building_firefight_change_pos();
	}
}

//Function Number: 72
gov_building_firefight_driveup_explode()
{
	wait(2);
	var_00 = getent("gov_veh_spawner_explode","targetname");
	var_01 = var_00 maps\_utility::spawn_vehicle();
	var_01 thread gov_building_firefight_removal();
	if(level.currentgen)
	{
		var_01 thread tff_cleanup_vehicle("intro");
	}

	maps\_vehicle::gopath(var_01);
	level waittill("nig_mil_start_shoot");
	wait(7);
	level notify("tram_bridge_redirect");
}

//Function Number: 73
gov_building_firefight_roadblock()
{
	var_00 = getentarray("gov_road_block_soldier","targetname");
	foreach(var_02 in var_00)
	{
		var_03 = var_02 maps\_utility::spawn_ai(1);
		var_03.goalradius = 16;
		var_03 thread maps\_utility::magic_bullet_shield(1);
		var_03 thread gov_building_firefight_removal();
		var_03 thread maps\lagos_utility::disable_awareness();
		if(isdefined(var_03.script_noteworthy) && var_03.script_noteworthy == "gov_road_block_patrol")
		{
			var_03 thread gov_road_block_patrol_route();
		}
	}
}

//Function Number: 74
gov_building_firefight_anim_wounded()
{
	var_00 = getent("drag_wounded_spawner","targetname");
	var_01 = getent("drag_carrier_spawner","targetname");
	var_02 = var_00 maps\_utility::spawn_ai(1);
	wait 0.05;
	var_02 maps\_utility::gun_remove();
	var_02.goalradius = 16;
	var_02 thread maps\_utility::magic_bullet_shield(1);
	var_02 thread gov_building_firefight_removal();
	var_02 thread maps\lagos_utility::disable_awareness();
	var_02 thread gov_building_firefight_change_pos();
	var_03 = var_01 maps\_utility::spawn_ai(1);
	wait 0.05;
	var_03.goalradius = 16;
	var_03 thread maps\_utility::magic_bullet_shield(1);
	var_03 thread gov_building_firefight_removal();
	var_03 thread maps\lagos_utility::disable_awareness();
	var_03 thread gov_building_firefight_change_pos();
}

//Function Number: 75
gov_building_firefight_anim_explode()
{
	level waittill("nig_mil_start_shoot");
	var_00 = common_scripts\utility::getstruct("anim_walk_wounded_org","targetname");
	var_01 = maps\_utility::get_living_ai_array("gov_building_soldier_explode","script_noteworthy");
	var_02 = 0;
	foreach(var_04 in var_01)
	{
		if(var_02 == 0)
		{
			var_04.animname = "prague_walk";
		}
		else
		{
			var_04.animname = "prague_help";
		}

		var_04 maps\jake_tools::invulnerable(1);
		var_02++;
	}

	level waittill("explode_anim_pos");
	var_00 maps\_anim::anim_single(var_01,"prague_woundwalk");
	var_06 = [];
	foreach(var_04 in var_01)
	{
		if(isalive(var_04))
		{
			var_06[var_06.size] = var_04;
		}
	}

	var_00 thread maps\_anim::anim_loop(var_06,"prague_woundwalk_help");
}

//Function Number: 76
gov_fail_on_death()
{
	level endon("exo_climb_success");
	level endon("burke_climb");
	self waittill("damage");
	if(common_scripts\utility::flag("roundabout_playerstart") || common_scripts\utility::flag("gov_player_exiting_area"))
	{
		return;
	}

	setdvar("ui_deadquote",&"LAGOS_FAIL_STAY_ON_MISSION");
	maps\_utility::missionfailedwrapper();
}

//Function Number: 77
gov_building_firefight_kva()
{
	var_00 = getentarray("kva_gov_building_driveup_enemies","targetname");
	var_01 = 1;
	foreach(var_03 in var_00)
	{
		var_04 = getnode(var_03.target,"targetname");
		var_05 = var_03 maps\_utility::spawn_ai(1);
		var_05.ignoreall = 1;
		wait 0.05;
		var_05 maps\_utility::teleport_ai(var_04);
		var_05 maps\_utility::set_goal_node(var_04);
		var_05 thread maps\_utility::enable_surprise();
		var_05 thread gov_firefight_detect_breach();
		var_05 thread gov_building_firefight_removal();
		var_05 thread gov_fail_on_death();
		level.gov_kva_soldiers = common_scripts\utility::array_add(level.gov_kva_soldiers,var_05);
		if(isdefined(var_05.script_parameters) && var_05.script_parameters == "front_kva_3")
		{
		}
		else
		{
			var_05 thread gov_firefight_enemy_reload_anims(var_04);
		}

		wait 0.05;
	}

	level notify("firefight_init");
	common_scripts\utility::flag_wait("player_landed_roof_breach");
}

//Function Number: 78
gov_building_firefight_front_soldiers()
{
	var_00 = getentarray("militia_drive_start_front","targetname");
	foreach(var_02 in var_00)
	{
		var_03 = var_02 maps\_utility::spawn_ai(1);
		var_03.ignoreall = 1;
		var_03.goalradius = 16;
		var_03 thread maps\_utility::magic_bullet_shield(1);
		var_03 thread gov_building_firefight_removal();
		level.gov_soldiers_front = common_scripts\utility::array_add(level.gov_soldiers_front,var_03);
		var_03 thread gov_building_firefight_change_pos();
	}

	level.nigerian_bullhorn = level.gov_soldiers_front[0];
	level.nigerian_bullhorn.animname = "nigerian_army";
}

//Function Number: 79
gov_building_firefight_change_pos()
{
	level.pos_array = getnodearray("gov_dev_tp_point","script_noteworthy");
	level endon("");
	level waittill("start_pos_switching");
	for(;;)
	{
		level.pos_array = common_scripts\utility::array_randomize(level.pos_array);
		if(!isnodeoccupied(level.pos_array[0]))
		{
			if(isdefined(self.last_set_goalnode) && self.last_set_goalnode != level.pos_array[0])
			{
				level.pos_array = common_scripts\utility::array_add(level.pos_array,self.last_set_goalnode);
			}

			maps\_utility::set_goal_node(level.pos_array[0]);
			level.pos_array = common_scripts\utility::array_remove(level.pos_array,level.pos_array[0]);
			self waittill("goal");
			wait(randomintrange(10,20));
		}
		else
		{
			wait(20);
		}

		wait 0.05;
	}
}

//Function Number: 80
gov_building_gren_guy()
{
	var_00 = maps\_utility::get_living_ai("front_mil_gren_guy","script_noteworthy");
	var_01 = common_scripts\utility::getstruct("gren_target","targetname");
	magicgrenade("smoke_grenade_american",var_00.origin,var_01.origin,1);
}

//Function Number: 81
gov_building_explode_advance_guys()
{
	var_00 = maps\_utility::get_living_ai("gov_explode_advance1","script_noteworthy");
	var_01 = maps\_utility::get_living_ai("gov_explode_advance2","script_noteworthy");
	var_02 = getnode("gov_explode_node1","script_noteworthy");
	var_03 = getnode("gov_explode_node2","script_noteworthy");
	level waittill("explode_anim_pos");
	wait(1);
	var_00 maps\_utility::set_goal_node(var_02);
	var_01 maps\_utility::set_goal_node(var_03);
}

//Function Number: 82
gov_building_firefight_turret_settings(param_00)
{
	self allowedstances("stand");
	self.fixednode = 1;
	self.goalradius = 70;
	self.combatmode = "ambush";
	maps\_utility::disable_long_death();
	self setgoalpos(param_00.origin);
	self waittill("goal");
	self useturret(param_00);
	param_00 makeunusable();
	param_00 setturretteam("axis");
	param_00 setturretcanaidetach(0);
	param_00 setconvergencetime(3,"yaw");
	param_00 setconvergencetime(1.5,"pitch");
	param_00 setaispread(5);
}

//Function Number: 83
gov_firefight_enemy_reload_anims(param_00)
{
	level endon("roof_breach_start");
	self endon("death");
	var_01 = getnodearray("kva_breach_reload_point","targetname");
	var_01 = sortbydistance(var_01,self.origin);
	self.animname = "gov_breach";
	self.goalradius = 16;
	maps\_utility::set_allowdeath(1);
	for(;;)
	{
		foreach(var_03 in var_01)
		{
			if(!isnodeoccupied(var_03))
			{
				maps\_utility::set_goal_node(var_03);
				self waittill("goal");
				var_03 maps\_anim::anim_single_solo(self,"gov_kva_reload");
				self.goalradius = 16;
				maps\_utility::set_goal_node(param_00);
				wait(randomfloatrange(20,40));
			}

			if(isnodeoccupied(var_03))
			{
				wait(randomfloatrange(3,5));
				continue;
			}
		}

		wait 0.05;
	}
}

//Function Number: 84
gov_firefight_detect_breach()
{
	level waittill("allies_breached");
	wait(1.5);
	self stopanimscripted();
	self.ignoreall = 0;
	if(isdefined(self.script_noteworthy) && self.script_noteworthy == "gov_building_kva_soldier")
	{
		self setthreatbiasgroup();
		var_00 = randomint(level.alpha_squad_and_player.size);
		maps\_utility::set_favoriteenemy(level.alpha_squad_and_player[var_00]);
	}
}

//Function Number: 85
gov_road_block_patrol_route()
{
	self endon("death");
	self endon("road_block_patrol_stop");
	self.goalradius = 8;
	self.alertlevel = "noncombat";
	maps\_utility::disable_exits();
	maps\_utility::disable_arrivals();
	self.animname = "road_block";
	maps\_utility::set_idle_anim("patrol_idle");
	maps\_utility::set_run_anim("patrol_walk");
	var_00 = getnodearray("road_patrol_goal","targetname");
	common_scripts\utility::flag_wait("road_block_patrol_go");
	for(;;)
	{
		wait(randomfloatrange(1,3));
		var_00 = common_scripts\utility::array_randomize(var_00);
		if(common_scripts\utility::cointoss())
		{
			maps\_utility::set_goal_node(var_00[0]);
			self waittill("goal");
		}
	}
}

//Function Number: 86
gov_building_firefight_removal()
{
	if(self.code_classname == "script_vehicle")
	{
		common_scripts\utility::flag_wait_either("roundabout_playerstart","gov_player_exiting_area");
		self delete();
		return;
	}

	self endon("death");
	common_scripts\utility::flag_wait_either("roundabout_playerstart","gov_player_exiting_area");
	if(isdefined(self.script_noteworthy) && self.script_noteworthy == "gov_road_block_patrol")
	{
		self notify("road_block_patrol_stop");
	}

	self delete();
}

//Function Number: 87
gov_building_rear_removal()
{
	if(self.code_classname == "script_vehicle")
	{
		common_scripts\utility::flag_wait_either("roundabout_playerstart","flag_roundabout_move_2");
		self delete();
		return;
	}

	self endon("death");
	common_scripts\utility::flag_wait_either("roundabout_playerstart","flag_roundabout_move_2");
	if(level.currentgen)
	{
		var_00 = getent("anim_HM_post_breach","targetname");
		var_00 notify("stop_anim_notify");
	}

	self delete();
}

//Function Number: 88
gov_building_ai_timed_shooting()
{
	self endon("death");
	if(isdefined(self.script_noteworthy) && self.script_noteworthy == "gov_building_kva_soldier")
	{
		self endon("allies_breached");
		self endon("cease_fire_init");
	}

	if(common_scripts\utility::array_contains(level.gov_soldiers_front,self) || common_scripts\utility::array_contains(level.gov_soldiers_veh,self))
	{
		self endon("cease_fire_init");
	}

	self.grenadeammo = 0;
	for(;;)
	{
		var_00 = randomfloat(100);
		if(self.team == "allies")
		{
			if(var_00 < 75)
			{
				self.ignoreall = 0;
				wait(randomfloatrange(3,20));
			}
			else
			{
				self.ignoreall = 1;
				wait(randomfloatrange(2,5));
			}
		}

		if(self.team == "axis")
		{
			if(var_00 < 25)
			{
				self.ignoreall = 0;
				wait(randomfloatrange(3,20));
			}
			else
			{
				self.ignoreall = 1;
				wait(randomfloatrange(2,5));
			}
		}

		wait 0.05;
	}
}

//Function Number: 89
gov_building_ally_goto()
{
	level waittill("gov_driveup_started");
	thread maps\lagos_utility::ally_redirect_goto_node("Gideon","gov_overlook_burke");
	thread maps\lagos_utility::ally_redirect_goto_node("Joker","gov_overlook_joker");
	thread maps\lagos_utility::ally_redirect_goto_node("Ajani","gov_overlook_ajani");
	wait(3);
	thread gov_tram_bridge_ally_goto();
}

//Function Number: 90
gov_tram_bridge_ally_goto()
{
	level waittill("tram_bridge_redirect");
	thread gov_building_exo_climb_goto();
	common_scripts\utility::flag_set("obj_progress_tram_track");
	thread maps\lagos_utility::ally_redirect_goto_node("Gideon","tram_bridge_burke");
	wait(1);
	thread maps\lagos_utility::ally_redirect_goto_node("Joker","tram_bridge_joker");
	wait(3);
	thread maps\lagos_utility::ally_redirect_goto_node("Ajani","tram_bridge_ajani");
	level.player.ignoreme = 1;
}

//Function Number: 91
gov_building_exo_climb_goto()
{
	if(!common_scripts\utility::flag("government_courtyard_playerstart"))
	{
		common_scripts\utility::flag_wait("gov_exo_climb_start");
	}

	foreach(var_01 in level.alpha_squad)
	{
		var_01.goalradius = 16;
	}

	level.burke thread gov_building_exo_climb_burke_anims();
	wait(1);
	thread maps\lagos_utility::ally_redirect_goto_node("Joker","exo_climb_joker");
	wait(2);
	thread maps\lagos_utility::ally_redirect_goto_node("Ajani","exo_climb_ajani");
	wait(2);
	level.burke thread gov_building_exo_climb_in_position();
	level.joker thread gov_building_exo_climb_in_position();
	level.ajani thread gov_building_exo_climb_in_position();
}

//Function Number: 92
gov_building_exo_climb_in_position()
{
	thread gov_building_exo_climb_position_counter();
	self waittill("goal");
	wait 0.05;
	level notify("in_exo_climb_pos");
}

//Function Number: 93
gov_building_exo_climb_position_counter()
{
	level endon("exo_climb_pos_set");
	var_00 = 3;
	var_01 = 0;
	while(var_01 < var_00)
	{
		level waittill("in_exo_climb_pos");
		var_01++;
		if(var_01 == var_00)
		{
			level notify("exo_climb_pos_set");
			return;
		}

		wait 0.05;
	}
}

//Function Number: 94
gov_building_exo_climb_burke_anims()
{
	var_00 = getent("anim_org_exo_climb_approach","targetname");
	thread gov_building_exo_climb_burke_climb(var_00);
	if(!common_scripts\utility::flag("flag_start_mag_climb"))
	{
		var_00 maps\_anim::anim_reach_solo(self,"exo_climb_approach",undefined,1);
	}

	if(!common_scripts\utility::flag("flag_start_mag_climb"))
	{
		var_00 maps\_anim::anim_single_solo(self,"exo_climb_approach");
	}

	if(!common_scripts\utility::flag("flag_start_mag_climb"))
	{
		var_00 thread maps\_anim::anim_loop_solo(self,"exo_climb_approach_idle","burke_climb");
	}
}

//Function Number: 95
gov_building_exo_climb_burke_climb(param_00)
{
	common_scripts\utility::flag_wait("flag_start_mag_climb");
	param_00 notify("burke_climb");
	var_01 = getent("anim_org_exo_climb_gideon","targetname");
	level.burke soundscripts\_snd::snd_message("aud_exo_climb_burke");
	level.player soundscripts\_snd::snd_message("exo_climb_pullup_start");
	var_01 maps\_anim::anim_single_solo(level.burke,"exo_climb_burke");
	wait 0.05;
	var_02 = getnode("gov_breach_goto_burke","targetname");
	var_03 = getnode("gov_breach_goto_joker","targetname");
	var_04 = getnode("gov_breach_goto_ajani","targetname");
	level.burke maps\_utility::teleport_ai(var_02);
	level.joker maps\_utility::teleport_ai(var_03);
	level.ajani maps\_utility::teleport_ai(var_04);
}

//Function Number: 96
goverment_building_exoclimb_listen()
{
	level waittill("exoclimb_start_mount_anim");
	common_scripts\utility::flag_set("flag_start_mag_climb");
}

//Function Number: 97
government_building()
{
	thread gov_roof_breach_sequence();
	thread gov_roof_breach_anim_setup();
	thread gov_building_exo_climb_vo();
	thread gov_building_delete_soft_clip();
	thread goverment_building_exoclimb_listen();
	level.player.exo_climb_overrides = spawnstruct();
	level.player.exo_climb_overrides.idle_look_sideways_limit_mag = 50;
	level.player.exo_climb_overrides.idle_look_down_limit_mag = 20;
	var_00 = getent("anim_org_exo_climb","targetname");
	thread wall_climb_force_dismount(var_00);
	level.xraywall_on = getentarray("xraywall_on","targetname");
	common_scripts\utility::array_call(level.xraywall_on,::hide);
	foreach(var_02 in level.xraywall_on)
	{
		if(var_02.classname == "script_model")
		{
			var_02 notsolid();
		}
	}

	var_04 = common_scripts\utility::getstruct("exo_climb_start_1","targetname");
	var_05 = common_scripts\utility::getstruct("exo_climb_start_2","targetname");
	common_scripts\utility::flag_wait("vo_government_building_mag_exo_dialogue");
	common_scripts\utility::flag_wait("flag_start_mag_climb");
	level notify("burke_climb");
	common_scripts\utility::flag_set("climb_begin_lighting");
	common_scripts\utility::flag_set("obj_progress_exo_climb_clear");
	common_scripts\utility::flag_wait("flag_end_mag_climb");
	common_scripts\utility::flag_set("climb_ending_lighting");
	thread gov_anims_joker();
	thread gov_anims_ajani();
	maps\_utility::autosave_by_name();
	wait 0.05;
	level notify("exo_climb_success");
	level notify("wall_pullup_burke_anim_start");
}

//Function Number: 98
gov_anims_joker()
{
	var_00 = getent("anim_org_exo_climb","targetname");
	var_00 maps\_anim::anim_single_solo(level.joker,"exo_climb_joker");
	var_00 = getent("anim_org_govRoof","targetname");
	level.joker thread gov_roof_breach_prep_squad_anims(var_00,"joker_in_breach_pos",1);
}

//Function Number: 99
gov_anims_ajani()
{
	var_00 = getent("anim_org_exo_climb","targetname");
	var_00 maps\_anim::anim_single_solo(level.ajani,"exo_climb_ajani");
	var_00 = getent("anim_org_govRoof","targetname");
	level.ajani thread gov_roof_breach_prep_squad_anims(var_00,"ajani_in_breach_pos",1);
}

//Function Number: 100
gov_building_delete_soft_clip()
{
	common_scripts\utility::flag_wait("delete_soft_clip_gov_building_landing_from_rail");
	wait(0.5);
}

//Function Number: 101
wall_climb_force_dismount(param_00)
{
	common_scripts\utility::flag_wait("flag_end_mag_climb");
	var_01 = "player_rig";
	var_02 = "exo_climb_pullup_exit";
	level.scr_goaltime["player_rig"]["exo_climb_pullup_exit"] = 0.7;
	maps\_exo_climb::force_animated_dismount(param_00,var_01,var_02);
	level notify("mag_climb_complete");
}

//Function Number: 102
wall_pullup_burke_anim_start(param_00)
{
	level notify("wall_pullup_burke_anim_start");
}

//Function Number: 103
gov_building_exo_climb_vo()
{
	common_scripts\utility::flag_wait("vo_government_building_mag_exo_dialogue");
	thread maps\lagos_vo::government_building_mag_exo_dialogue();
}

//Function Number: 104
gov_roof_breach_sequence()
{
	level waittill("exo_climb_success");
	thread gov_hostage_approach();
	level waittill("cease_fire_init");
	foreach(var_01 in level.alpha_squad_and_player)
	{
		var_01.ignoreme = 1;
	}

	foreach(var_04 in level.gov_soldiers_veh)
	{
		var_04 thread maps\lagos_utility::disable_awareness();
	}

	foreach(var_04 in level.gov_soldiers_front)
	{
		var_04 thread maps\lagos_utility::disable_awareness();
	}

	level waittill("gov_breach_init");
	foreach(var_09 in level.gov_kva_soldiers)
	{
	}

	thread gov_roof_breach_success_monitor();
	thread gov_roof_breach_kill_assignment();
	level waittill("allies_breached");
	wait(1.5);
	foreach(var_01 in level.alpha_squad_and_player)
	{
		var_01.ignoreme = 0;
	}
}

//Function Number: 105
gov_roof_breach_anim_chunks()
{
	var_00 = getent("roof_breach_chunks","targetname");
	var_01 = getent("anim_org_govRoof","targetname");
	var_00.animname = "rooftop_chunks";
	var_00 maps\_utility::assign_animtree();
	var_01 maps\_anim::anim_first_frame_solo(var_00,"roof_mute_breach_plant");
	level waittill("roof_breach_start");
	var_01 maps\_anim::anim_single_solo(var_00,"roof_mute_breach_plant");
	var_01 maps\_anim::anim_last_frame_solo(var_00,"roof_mute_breach_plant");
}

//Function Number: 106
gov_roof_breach_anim_setup()
{
	thread gov_roof_breach_marker_setup();
	thread gov_roof_breach_roof_destruction();
	level waittill("exo_climb_success");
	var_00 = getent("anim_org_govRoof","targetname");
	level.burke thread gov_roof_breach_prep_squad_anims(var_00,"burke_in_breach_pos",0);
	common_scripts\utility::flag_set("obj_progress_roof_breach_goto");
	thread maps\lagos_vo::government_building_roof_breach_dialogue();
	thread gov_roof_breach_to_hbreach_vo();
	level notify("in_breach_pos");
	common_scripts\utility::flag_wait("flag_roof_charge_planted");
	level notify("roof_breach_start");
	common_scripts\utility::flag_set("gov_breach_start_lighting");
	common_scripts\utility::flag_set("done_roof_breach_start");
	common_scripts\utility::flag_set("obj_progress_roof_breach_clear");
	level.player maps\_shg_utility::setup_player_for_scene();
	var_01 = maps\_utility::spawn_anim_model("player_rig",level.player.origin);
	var_02 = maps\_utility::spawn_anim_model("mute_breach_device",var_00.origin);
	var_03 = maps\_utility::spawn_anim_model("roof_breach_device",var_00.origin);
	var_04 = [level.burke,var_02,var_03];
	var_05 = [level.joker,level.ajani];
	var_00 maps\_anim::anim_first_frame_solo(var_01,"roof_mute_breach_plant");
	var_02 soundscripts\_snd::snd_message("gov_building_mute_device");
	var_01 hide();
	var_06 = 0.5;
	level.player playerlinktoblend(var_01,"tag_player",var_06,var_06 * 0.5,var_06 * 0.5);
	wait(var_06);
	var_01 show();
	level.player playerlinktodelta(var_01,"tag_player",1,7,7,5,5,1);
	level.burke maps\_utility::place_weapon_on(level.burke.primaryweapon,"chest");
	var_00 maps\_anim::anim_first_frame(var_04,"roof_mute_breach_plant");
	var_00 thread maps\_anim::anim_single_solo(var_01,"roof_mute_breach_plant");
	var_00 thread maps\_anim::anim_single(var_04,"roof_mute_breach_plant");
	wait(0.25);
	var_00 thread maps\_anim::anim_single(var_05,"roof_mute_breach_plant");
	var_07 = 1;
	foreach(var_09 in level.gov_kva_soldiers)
	{
		var_0A = var_09.script_parameters;
		var_09.animname = var_0A;
		if(var_09.animname != "front_kva_5" && var_09.animname != "front_kva_6")
		{
			var_09.health = 1;
			var_09 thread gov_roof_breach_enemy_react_anims(var_00);
			var_00 thread maps\_anim::anim_single_solo(var_09,"roof_breach_enemy_react");
		}
	}

	wait(10.5);
	wait(1);
	level notify("destroy_roof");
	var_03 delete();
	thread gov_roof_breach_enable_player_invul();
	thread gov_roof_breach_end_slomo();
	wait(1.7);
	level.player enableweapons();
	wait(0.3);
	level notify("allies_breached");
	var_0C = rooftop_anim_length();
	var_00 thread maps\_anim::anim_single_solo(level.burke,"roof_mute_breach_jumpdown");
	var_00 thread maps\_anim::anim_single_solo(level.joker,"roof_mute_breach_jumpdown",undefined,2);
	var_00 thread maps\_anim::anim_single_solo(level.ajani,"roof_mute_breach_jumpdown");
	var_00 thread maps\_anim::anim_single_solo(var_01,"roof_mute_breach_jumpdown");
	var_0D = 0.3;
	var_0C = var_0C - var_0D;
	wait(var_0D);
	level.player playersetgroundreferenceent(var_01);
	level.player playersetgroundreferenceent(undefined);
	level.player playerlinktodelta(var_01,"tag_player",0,60,20,30,30,0);
	wait(var_0C);
	common_scripts\utility::flag_set("player_landed_roof_breach");
	var_0E = common_scripts\utility::getstruct("roof_breach_joker_tp","targetname");
	level.joker forceteleport(var_0E.origin,var_0E.angles);
	level.player unlink();
	var_01 delete();
	level.player maps\_shg_utility::setup_player_for_gameplay();
	level notify("player_landed_roof_breach");
	maps\_utility::autosave_by_name();
	common_scripts\utility::flag_set("obj_progress_h_breach_goto");
	level.burke maps\_utility::place_weapon_on(level.burke.primaryweapon,"right");
}

//Function Number: 107
gov_roof_breach_marker_setup()
{
	var_00 = getent("mute_breach_obj_prop","targetname");
	var_01 = spawn("script_model",(0,0,0));
	var_01 setmodel("mutecharge_obj");
	var_01.angles = var_00.angles;
	var_01.origin = var_00.origin;
	level waittill("exo_climb_success");
	var_02 = getent("gov_breach_trigger","targetname");
	var_03 = var_02 maps\_shg_utility::hint_button_trigger("x",400);
	var_02 sethintstring(&"LAGOS_ROOF_MUTE_CHARGE");
	var_02 waittill("trigger",var_04);
	var_03 maps\_shg_utility::hint_button_clear();
	var_02 sethintstring("");
	var_02 makeunusable();
	common_scripts\utility::flag_set("flag_roof_charge_planted");
	level waittill("roof_breach_start");
	wait(0.4);
	if(isdefined(var_01))
	{
		var_01 delete();
	}
}

//Function Number: 108
gov_roof_breach_start_slowmo(param_00)
{
	soundscripts\_snd::snd_message("rooftop_slo_mo_override");
	setslowmotion(1,0.15,0.3);
}

//Function Number: 109
gov_roof_breach_end_slomo()
{
	level waittill("breach_success");
	setslowmotion(0.15,1,0.8);
}

//Function Number: 110
rooftop_anim_length()
{
	var_00 = getanimlength(%lag_roof_breach_jumpdown_vm);
	return var_00;
}

//Function Number: 111
gov_roof_breach_enemy_react_anims(param_00)
{
	self.allowdeath = 1;
	switch(self.script_parameters)
	{
		case "front_kva_1":
			self.deathanim = %lag_roof_breach_react_death_guy1;
			self waittill("damage");
			self.ignoreme = 1;
			break;

		case "front_kva_2":
			self.deathanim = %lag_roof_breach_react_death_guy2;
			self waittill("damage");
			self.ignoreme = 1;
			break;

		case "front_kva_3":
			self.deathanim = %lag_roof_breach_react_death_guy3;
			self waittill("damage");
			self.ignoreme = 1;
			break;

		case "front_kva_4":
			self.deathanim = %lag_roof_breach_react_death_guy4;
			self waittill("damage");
			self.ignoreme = 1;
			break;

		case "front_kva_5":
			var_01 = getnode("front_kva_5_goal","targetname");
			maps\_utility::teleport_ai(var_01);
			maps\_utility::set_goal_node(var_01);
			break;

		case "front_kva_6":
			var_01 = getnode("front_kva_5_goal","targetname");
			maps\_utility::teleport_ai(var_01);
			maps\_utility::set_goal_node(var_01);
			break;
	}
}

//Function Number: 112
gov_roof_breach_enable_player_invul()
{
	level endon("end_shoot_dudes");
	level.player enableinvulnerability();
	level waittill("player_landed_roof_breach");
	level.player disableinvulnerability();
}

//Function Number: 113
gov_roof_breach_multi_kill(param_00)
{
	var_01 = common_scripts\utility::getstructarray("magic_bullet_loc","targetname");
	var_01 = common_scripts\utility::array_randomize(var_01);
	thread multi_sync_kills(level.gov_kva_soldiers,var_01);
}

//Function Number: 114
multi_sync_kills(param_00,param_01)
{
	level.target_array = param_00;
	level.shoot_point_array = param_01;
	while(level.target_array.size > 0)
	{
		level.target_array = maps\_utility::array_removedead_or_dying(level.target_array);
		if(isalive(level.target_array[0]))
		{
			var_02 = level.target_array[0];
			var_03 = level.shoot_point_array[0];
			level.target_array = common_scripts\utility::array_remove(level.target_array,level.target_array[0]);
			level.shoot_point_array = common_scripts\utility::array_remove(level.shoot_point_array,level.shoot_point_array[0]);
			thread multi_sync_kill_shooter(var_02,var_03);
		}

		wait 0.05;
	}
}

//Function Number: 115
multi_sync_kill_shooter(param_00,param_01)
{
	param_00.maxhealth = 1;
	param_00.health = 1;
	var_02 = param_00 gettagorigin("TAG_EYE");
	while(isalive(param_00))
	{
		if(!isdefined(param_01))
		{
			wait 0.05;
			continue;
		}

		magicbullet("iw5_bal27_sp",param_01.origin,var_02);
		wait(randomfloatrange(0.07,0.1));
	}

	level.shoot_point_array = common_scripts\utility::array_add(level.shoot_point_array,param_01);
	level.shoot_point_array = common_scripts\utility::array_randomize(level.shoot_point_array);
}

//Function Number: 116
gov_roof_breach_prep_squad_anims(param_00,param_01,param_02)
{
	if(isdefined(param_02) && param_02)
	{
		maps\_utility::enable_cqbwalk();
		param_00 maps\_anim::anim_reach_solo(self,"roof_mute_breach_goto");
	}

	param_00 maps\_anim::anim_single_solo(self,"roof_mute_breach_goto");
	if(!common_scripts\utility::flag("done_roof_breach_start"))
	{
		param_00 thread maps\_anim::anim_loop_solo(self,"roof_mute_breach_idle","roof_breach_start");
		self.allowdeath = 1;
		level waittill("roof_breach_start");
		wait 0.05;
		param_00 notify("roof_breach_start");
	}
}

//Function Number: 117
gov_roof_breach_roof_destruction()
{
	var_00 = getentarray("mute_breach_brush","targetname");
	var_01 = getentarray("mute_breach_brush_damage","targetname");
	common_scripts\utility::array_call(var_01,::hide);
	common_scripts\utility::array_call(var_01,::notsolid);
	level waittill("destroy_roof");
}

//Function Number: 118
notetrack_swap_roof_brush(param_00)
{
	var_01 = getentarray("mute_breach_brush","targetname");
	var_02 = getentarray("mute_breach_brush_damage","targetname");
	common_scripts\utility::array_call(var_01,::delete);
	common_scripts\utility::array_call(var_02,::show);
	common_scripts\utility::array_call(var_02,::solid);
}

//Function Number: 119
gov_roof_breach_kill_assignment()
{
	while(!common_scripts\utility::flag("player_landed_roof_breach"))
	{
		wait 0.05;
	}

	level notify("end_shoot_dudes");
	foreach(var_01 in level.alpha_squad)
	{
		var_01 thread gov_roof_breach_elim_setting_on();
	}

	level.gov_kva_soldiers = common_scripts\utility::array_randomize(level.gov_kva_soldiers);
	level.burke thread gov_roof_breach_elim_guy(level.gov_kva_soldiers);
	wait 0.05;
	level.joker thread gov_roof_breach_elim_guy(level.gov_kva_soldiers);
	wait 0.05;
	level.ajani thread gov_roof_breach_elim_guy(level.gov_kva_soldiers);
	wait 0.05;
	foreach(var_01 in level.alpha_squad)
	{
		var_01 thread gov_roof_breach_elim_setting_off();
	}
}

//Function Number: 120
gov_roof_breach_elim_guy(param_00)
{
	self endon("breach_success");
	foreach(var_02 in level.gov_kva_soldiers)
	{
		var_02.maxhealth = 1;
		var_02.health = 1;
		var_02.dontattackme = undefined;
		if(isalive(var_02) && !isdefined(var_02.attacker))
		{
			self.favoriteenemy = var_02;
			var_02.attacker = self;
		}
	}
}

//Function Number: 121
gov_roof_breach_elim_setting_on()
{
	self.alertlevel = "combat";
	maps\_utility::disable_dontevershoot();
	self.ignoreall = 0;
	self.baseaccuracy = 5000;
}

//Function Number: 122
gov_roof_breach_elim_setting_off()
{
	self.favoriteenemy = undefined;
	self.alertlevel = "noncombat";
	maps\_utility::enable_dontevershoot();
	self.ignoreall = 1;
	self.baseaccuracy = 1;
}

//Function Number: 123
gov_roof_breach_success_monitor()
{
	level endon("breach_success");
	for(;;)
	{
		level.gov_kva_soldiers = maps\_utility::array_removedead_or_dying(level.gov_kva_soldiers);
		if(level.gov_kva_soldiers.size == 0)
		{
			gov_roof_breach_elim_setting_off();
			level notify("breach_success");
		}

		wait 0.05;
	}
}

//Function Number: 124
gov_hostage_h_breach_doors()
{
	level.h_breach_doors = getent("h_breach_doors","targetname");
	level.h_breach_doors.animname = "h_breach_doors";
	level.h_breach_doors maps\_utility::assign_animtree();
	var_00 = getent("anim_HM_post_breach","targetname");
	var_00 thread maps\_anim::anim_first_frame_solo(level.h_breach_doors,"h_breach_pt1");
	level.h_breach_doors waittill("anim_breach_complete");
	var_00 thread maps\_anim::anim_last_frame_solo(level.h_breach_doors,"h_breach_pt1");
}

//Function Number: 125
gov_hostage_approach()
{
	level waittill("breach_success");
	common_scripts\utility::flag_set("obj_progress_h_breach_goto");
	thread gov_rear_setup();
	thread gov_hostage_breach_setup();
	wait(2);
	level.burke allowedstances("crouch","stand");
	level.joker allowedstances("crouch","stand");
	level.ajani allowedstances("crouch","stand");
	level.burke maps\_utility::enable_cqbwalk();
	level.joker maps\_utility::enable_cqbwalk();
	level.ajani maps\_utility::enable_cqbwalk();
	level.burke thread gov_hostage_approach_redirect();
	level.joker thread gov_hostage_approach_redirect();
	level.ajani thread gov_hostage_approach_redirect();
	common_scripts\utility::flag_clear("gov_h_breach_adv1");
	common_scripts\utility::flag_wait("gov_h_breach_adv1");
	thread maps\lagos_utility::ally_redirect_goto_node("Gideon","gov_h_breach_burke");
	thread maps\lagos_utility::ally_redirect_goto_node("Joker","gov_h_breach_joker");
	thread maps\lagos_utility::ally_redirect_goto_node("Ajani","gov_h_breach_ajani");
	common_scripts\utility::flag_clear("gov_h_breach_init");
	level notify("h_breach_prep");
	common_scripts\utility::flag_wait("flag_h_breach_started");
	common_scripts\utility::flag_set("obj_progress_h_breach_clear");
	common_scripts\utility::flag_set("done_gov_building_h_breach_start");
	common_scripts\utility::flag_set("begin_harmonic_breach_lighting");
	level notify("h_breach_anim_init");
	thread maps\lagos_vo::harmonic_breach_start_dialogue();
	wait(2);
	level.anim_org_ajani_post_breach = getent("anim_HM_post_breach","targetname");
	level.anim_org_ajani_post_breach maps\_anim::anim_loop_solo(level.ajani,"h_breach_pre_idle","end_pre_idle");
}

//Function Number: 126
gov_roof_breach_to_hbreach_vo()
{
	common_scripts\utility::flag_wait("flag_roof_breach_mute_complete");
	thread maps\lagos_vo::government_building_interior_dialogue();
}

//Function Number: 127
gov_hostage_approach_redirect()
{
	switch(self.script_friendname)
	{
		case "Gideon":
			thread maps\lagos_utility::ally_redirect_goto_node("Gideon","gov_hostage_0_burke");
			wait(5);
			thread maps\lagos_utility::ally_redirect_goto_node("Gideon","gov_hostage_1_burke");
			break;

		case "Joker":
			thread maps\lagos_utility::ally_redirect_goto_node("Joker","gov_hostage_1_joker");
			break;

		case "Ajani":
			wait(2);
			thread maps\lagos_utility::ally_redirect_goto_node("Ajani","gov_hostage_0_ajani");
			wait(5);
			thread maps\lagos_utility::ally_redirect_goto_node("Ajani","gov_hostage_1_ajani");
			break;
	}
}

//Function Number: 128
gov_hostage_breach_in_pos(param_00,param_01,param_02)
{
	wait(param_00);
	param_01 maps\_anim::anim_reach_solo(self,param_02);
	param_01 thread maps\_anim::anim_loop_solo(self,param_02,"h_breach_anim_init");
}

//Function Number: 129
gov_hostage_breach_anim_idler()
{
	var_00 = [];
	var_00[0] = "cqb_idle";
	var_00[1] = "cqb_idle1";
	var_00[2] = "cqb_idle2";
	var_00[3] = "cqb_idle3";
	var_00[4] = "cqb_idle4";
	var_01 = common_scripts\utility::random(var_00);
	return var_01;
}

//Function Number: 130
fail_trigger_move_on_notify(param_00)
{
	level waittill(param_00);
	self.origin = self.origin + (0,0,-10000);
}

//Function Number: 131
gov_hostage_breach_fail_trigger()
{
	level endon("h_breach_anim_init");
	var_00 = getent("trig_harmonic_breach_damage_fail_trigger","targetname");
	var_00 thread fail_trigger_move_on_notify("h_breach_anim_init");
	for(;;)
	{
		var_00 waittill("damage",var_01,var_02,var_03,var_04,var_05);
		if(var_02 == level.player && !issubstr(var_05,"MELEE"))
		{
			setdvar("ui_deadquote",&"LAGOS_HBREACH_FAILED");
			maps\_utility::missionfailedwrapper();
		}
	}
}

//Function Number: 132
gov_hostage_breach_fail_miss_trigger()
{
	level endon("BreachComplete");
	level endon("missionfailed");
	var_00 = getent("trig_harmonic_breach_miss_fail_trigger","targetname");
	for(;;)
	{
		var_00 waittill("damage",var_01,var_02,var_03,var_04,var_05);
		if(var_02 == level.player && !issubstr(var_05,"MELEE"))
		{
			wait(3);
			level notify("BreachFailed");
		}
	}
}

//Function Number: 133
gov_hostage_breach_setup()
{
	if(common_scripts\utility::flag("pre_h_breach_playerstart"))
	{
		level.pre_h_breach_burke_start = common_scripts\utility::getstruct("gov_hostage_4_burke","targetname");
		level.pre_h_breach_joker_start = common_scripts\utility::getstruct("gov_hostage_4_joker","targetname");
		level.pre_h_breach_ajani_start = common_scripts\utility::getstruct("gov_hostage_4_ajani","targetname");
		level.burke teleport(level.pre_h_breach_burke_start.origin,level.pre_h_breach_burke_start.angles);
		level.joker teleport(level.pre_h_breach_joker_start.origin,level.pre_h_breach_joker_start.angles);
		level.ajani teleport(level.pre_h_breach_ajani_start.origin,level.pre_h_breach_ajani_start.angles);
		thread maps\lagos_utility::ally_redirect_goto_node("Gideon","gov_h_breach_burke");
		thread maps\lagos_utility::ally_redirect_goto_node("Joker","gov_h_breach_joker");
		thread maps\lagos_utility::ally_redirect_goto_node("Ajani","gov_h_breach_ajani");
	}

	thread gov_hostage_breach_anim_setup();
	thread gov_hostage_breach_post_anim_setup();
	thread gov_hostage_breach_fail_trigger();
	level waittill("h_breach_start");
	soundscripts\_snd::snd_message("hb_sensor_flash_on");
	if(common_scripts\utility::flag("pre_h_breach_playerstart"))
	{
		level.pre_h_breach_burke_start notify("h_breach_start");
		level.pre_h_breach_joker_start notify("h_breach_start");
		level.pre_h_breach_ajani_start notify("h_breach_start");
	}

	thread maps\lagos_h_breach::startharmonicbreach(level.alpha_squad);
	thread maps\lagos_vo::harmonic_breach_timer_warning_dialogue();
}

//Function Number: 134
gov_hostage_breach_anim_setup()
{
	thread gov_hostage_breach_marker_setup();
	level waittill("h_breach_anim_init");
	var_00 = getent("anim_HM_breach","targetname");
	level.player maps\_shg_utility::setup_player_for_scene();
	var_01 = maps\_utility::spawn_anim_model("player_arms",level.player.origin);
	soundscripts\_snd::snd_message("hb_gun_away");
	var_00 maps\_anim::anim_first_frame_solo(var_01,"h_breach");
	var_01 hide();
	var_02 = 0.5;
	level.player playerlinktoblend(var_01,"tag_player",var_02,var_02 * 0.5,var_02 * 0.5);
	wait(var_02);
	var_01 show();
	level.player playerlinktodelta(var_01,"tag_player",1,7,7,5,5,1);
	var_03 = maps\_utility::spawn_anim_model("h_breach_device",var_00.origin);
	var_04 = getent("harmonic_breach_lighting_centroid","targetname");
	var_03 overridelightingorigin(var_04.origin);
	var_05 = [var_01,var_03,level.joker];
	var_00 maps\_anim::anim_single(var_05,"h_breach");
	level.player unlink();
	var_01 delete();
	var_06 = getent("harmonic_breach_player_blocker","targetname");
	var_06 solid();
	level.player maps\_shg_utility::setup_player_for_gameplay();
	level notify("h_breach_start");
	maps\_utility::autosave_by_name();
	level waittill("BreachComplete");
	level thread maps\lagos_fx::harmonic_breach_flash_off();
	var_06 notsolid();
	common_scripts\utility::flag_set("flag_h_breach_complete");
}

//Function Number: 135
gov_hostage_breach_marker_setup()
{
	var_00 = getent("h_breach_obj_prop","targetname");
	var_01 = spawn("script_model",(0,0,0));
	var_01 setmodel("lag_harmonic_breach_device_obj");
	var_01.angles = var_00.angles;
	var_01.origin = var_00.origin;
	level waittill("h_breach_prep");
	var_02 = var_01 common_scripts\utility::spawn_tag_origin();
	var_02.origin = var_02.origin + (0,0,8);
	var_03 = getent("gov_h_breach_trigger","targetname");
	var_04 = var_03 maps\_shg_utility::hint_button_trigger("x",400);
	var_03 sethintstring(&"LAGOS_PLACE_SENSOR");
	var_03 waittill("trigger",var_05);
	common_scripts\utility::flag_set("flag_h_breach_started");
	thread gov_hostage_breach_fail_miss_trigger();
	level waittill("h_breach_anim_init");
	var_04 maps\_shg_utility::hint_button_clear();
	var_03 sethintstring("");
	wait(0.4);
	if(isdefined(var_01))
	{
		var_01 delete();
	}
}

//Function Number: 136
gov_hostage_breach_post_anim_setup()
{
	var_00 = [];
	var_01 = getent("anim_HM_post_breach","targetname");
	if(common_scripts\utility::flag("post_h_breach_playerstart"))
	{
		level.post_h_breach_burke_start = common_scripts\utility::getstruct("gov_hostage_4_burke","targetname");
		level.post_h_breach_joker_start = common_scripts\utility::getstruct("gov_hostage_4_joker","targetname");
		level.post_h_breach_ajani_start = common_scripts\utility::getstruct("gov_hostage_4_ajani","targetname");
		level.burke teleport(level.post_h_breach_burke_start.origin,level.post_h_breach_burke_start.angles);
		level.joker teleport(level.post_h_breach_joker_start.origin,level.post_h_breach_joker_start.angles);
		level.ajani teleport(level.post_h_breach_ajani_start.origin,level.post_h_breach_ajani_start.angles);
		thread maps\lagos_utility::ally_redirect_goto_node("Gideon","gov_h_breach_burke");
		thread maps\lagos_utility::ally_redirect_goto_node("Joker","gov_h_breach_joker");
		thread maps\lagos_utility::ally_redirect_goto_node("Ajani","gov_h_breach_ajani");
	}

	level waittill("BreachComplete");
	wait(1);
	thread h_breach_blockers_delete();
	if(common_scripts\utility::flag("post_h_breach_playerstart"))
	{
		level.post_h_breach_burke_start notify("breach_done");
		level.post_h_breach_joker_start notify("breach_done");
		level.post_h_breach_ajani_start notify("breach_done");
		level.burke maps\_utility::anim_stopanimscripted();
		level.joker maps\_utility::anim_stopanimscripted();
		level.ajani maps\_utility::anim_stopanimscripted();
	}

	var_02 = maps\_utility::array_spawn_targetname("kva_hostage_execution");
	var_03 = 3;
	foreach(var_05 in var_02)
	{
		var_05.animname = "hostage_" + var_03;
		var_03++;
		var_05 thread gov_building_rear_removal();
		var_05.weapon = "none";
		var_05.ignoreall = 1;
		var_05.ignoreme = 1;
	}

	var_07 = getent("kva_hostage_victim","targetname");
	var_08 = var_07 maps\_utility::spawn_ai(1);
	var_08.animname = "hostage_1";
	var_08 thread gov_building_rear_removal();
	var_08 maps\_utility::gun_remove();
	var_08.ignoreall = 1;
	var_08.ignoreme = 1;
	var_08 setcontents(0);
	var_09 = getent("kva_hostage_minister","targetname");
	var_0A = var_09 maps\_utility::spawn_ai(1);
	var_0A.animname = "hostage_2";
	var_0A thread gov_building_rear_removal();
	var_0A maps\_utility::gun_remove();
	var_0A.ignoreall = 1;
	var_0A.ignoreme = 1;
	var_0A.name = "Prime Minister";
	var_0A maps\_utility::set_friendlyfire_warnings(1);
	var_0A.allowdeath = 1;
	var_0A.health = 1;
	var_0B = common_scripts\utility::getstruct("intro_beatup_hostage_org","targetname");
	var_0C = getent("kva_hostage_beatup","targetname");
	var_0D = var_0C maps\_utility::spawn_ai(1);
	var_0D.animname = "hostage_6";
	var_0D thread gov_building_rear_removal();
	var_0D maps\_utility::gun_remove();
	var_0D.ignoreall = 1;
	var_0D.ignoreme = 1;
	var_0E = getent("kva_hostage_leader_post_pcap","targetname");
	var_0F = var_0E maps\_utility::spawn_ai(1);
	var_0F.animname = "kva_1";
	var_0F.ignoreall = 1;
	var_0F.ignoreme = 1;
	var_0F thread maps\_utility::deletable_magic_bullet_shield();
	var_0F setcontents(0);
	var_0F thread gov_building_rear_removal();
	var_0F disableaimassist();
	var_10 = getent("kva_guard_beatup","targetname");
	var_11 = var_10 maps\_utility::spawn_ai(1);
	var_11.animname = "kva_2";
	var_11.ignoreall = 1;
	var_11.ignoreme = 1;
	var_11 thread maps\_utility::deletable_magic_bullet_shield();
	var_11 setcontents(0);
	var_11 thread gov_building_rear_removal();
	var_11 disableaimassist();
	var_12 = getent("kva_guard_corner","targetname");
	var_13 = var_12 maps\_utility::spawn_ai(1);
	var_13.animname = "kva_3";
	var_13.ignoreall = 1;
	var_13.ignoreme = 1;
	var_13 thread maps\_utility::deletable_magic_bullet_shield();
	var_13 setcontents(0);
	var_13 thread gov_building_rear_removal();
	var_13 disableaimassist();
	var_14 = getent("kva_pm_guard","targetname");
	var_15 = var_14 maps\_utility::spawn_ai(1);
	var_15.animname = "kva_4";
	var_15.ignoreall = 1;
	var_15.ignoreme = 1;
	var_15 thread maps\_utility::deletable_magic_bullet_shield();
	var_15 setcontents(0);
	var_15 thread gov_building_rear_removal();
	var_15 disableaimassist();
	var_16 = maps\_utility::spawn_anim_model("pm_cuffs");
	var_16 maps\_utility::assign_animtree();
	var_17 = maps\_utility::spawn_anim_model("vic_cuffs");
	var_17 maps\_utility::assign_animtree();
	if(isdefined(var_15))
	{
		var_15 maps\_utility::pretend_to_be_dead();
	}

	if(isdefined(var_0F))
	{
		var_0F maps\_utility::pretend_to_be_dead();
	}

	if(isdefined(var_11))
	{
		var_11 maps\_utility::pretend_to_be_dead();
	}

	if(isdefined(var_13))
	{
		var_13 maps\_utility::pretend_to_be_dead();
	}

	level.ajani thread gov_hostage_breach_give_radio();
	common_scripts\utility::flag_set("harmonic_complete_lighting");
	thread maps\lagos_vo::harmonic_breach_complete_dialogue();
	thread gov_hostage_player_scan(var_01,var_16);
	thread restrict_movement_while_releasing_the_pm();
	thread maps\lagos_vo::pcap_pm_rescue();
	thread maps\lagos_fx::env_effects_hostage_room();
	if(isdefined(level.anim_org_ajani_post_breach))
	{
		level.anim_org_ajani_post_breach notify("end_pre_idle");
	}

	thread gov_hostage_breach_actor_anims_straight_to_idle(var_01,var_02[0],"h_breach_pt1","h_breach_post","stop_anim_notify","h_breach_pt2");
	thread gov_hostage_breach_actor_anims_straight_to_idle(var_01,var_02[1],"h_breach_pt1","h_breach_post","stop_anim_notify","h_breach_pt2");
	thread gov_hostage_breach_actor_anims_straight_to_idle(var_01,var_02[2],"h_breach_pt1","h_breach_post","stop_anim_notify","h_breach_pt2");
	thread gov_hostage_breach_actor_anims_straight_to_idle(var_01,var_0D,"h_breach_pt1","h_breach_post","stop_anim_notify","h_breach_pt2");
	thread gov_hostage_breach_actor_anims_and_idle(var_01,var_08,"h_breach_pt1","h_breach_idle","h_breach_idle_ender");
	thread gov_hostage_breach_actor_anims_and_idle(var_01,var_0A,"h_breach_pt1","h_breach_idle","h_breach_idle_ender");
	thread gov_hostage_breach_actor_anims_and_idle(var_01,var_0F,"h_breach_pt1","h_breach_idle","h_breach_idle_ender");
	thread gov_hostage_breach_actor_anims_and_idle(var_01,var_11,"h_breach_pt1","h_breach_idle","h_breach_idle_ender");
	thread gov_hostage_breach_actor_anims_and_idle(var_01,var_13,"h_breach_pt1","h_breach_idle","h_breach_idle_ender");
	thread gov_hostage_breach_actor_anims_and_idle(var_01,var_15,"h_breach_pt1","h_breach_idle","h_breach_idle_ender");
	thread gov_hostage_breach_actor_anims_and_idle(var_01,level.burke,"h_breach_pt1","h_breach_idle","h_breach_idle_ender");
	thread gov_hostage_breach_actor_anims_and_idle(var_01,level.ajani,"h_breach_pt1","h_breach_idle","h_breach_idle_ender");
	thread gov_hostage_breach_actor_anims_and_idle(var_01,var_16,"h_breach_pt1","h_breach_idle","h_breach_idle_ender");
	thread gov_hostage_breach_actor_anims_and_idle(var_01,level.h_breach_doors,"h_breach_pt1");
	thread gov_hostage_breach_actor_anims_and_idle(var_01,var_17,"h_breach_pt1");
	thread gov_post_h_breach_joker_actions();
	wait(15);
	common_scripts\utility::flag_set("obj_progress_free_pm");
	level waittill("player_end_scan");
	thread maps\_player_exo::player_exo_deactivate();
	var_01 notify("h_breach_idle_ender");
	wait 0.05;
	soundscripts\_snd::snd_message("pm_rescue_foley");
	thread gov_hostage_breach_actor_anims_and_idle(var_01,var_08,"h_breach_pt2","h_breach_post",undefined);
	thread gov_hostage_breach_actor_anims_and_idle(var_01,var_0A,"h_breach_pt2","h_breach_post",undefined);
	thread gov_hostage_breach_actor_anims_and_idle(var_01,var_0F,"h_breach_pt2","h_breach_post",undefined);
	thread gov_hostage_breach_actor_anims_and_idle(var_01,var_11,"h_breach_pt2","h_breach_post",undefined);
	thread gov_hostage_breach_actor_anims_and_idle(var_01,var_13,"h_breach_pt2","h_breach_post",undefined);
	thread gov_hostage_breach_actor_anims_and_idle(var_01,var_15,"h_breach_pt2","h_breach_post",undefined);
	thread gov_hostage_breach_actor_anims_and_idle(var_01,level.burke,"h_breach_pt2");
	thread gov_hostage_breach_actor_anims_and_idle(var_01,level.ajani,"h_breach_pt2");
	thread gov_hostage_breach_actor_anims_and_idle(var_01,var_16,"h_breach_pt2");
	thread gov_hostage_breach_actor_anims_and_idle(var_01,var_17,"h_breach_pt2");
	level notify("breach_anims_complete");
	wait(25);
	thread maps\_player_exo::player_exo_activate();
	common_scripts\utility::flag_set("gov_hostage_exit_door_open");
}

//Function Number: 137
gov_post_h_breach_joker_actions()
{
	wait(3);
	thread maps\lagos_utility::ally_redirect_goto_node("Joker","gov_h_breach_joker_post");
	var_00 = getent("anim_HM_post_breach_door","targetname");
	var_01 = getent("anim_HM_post_breach_joker","targetname");
	var_02 = getent("gov_hostage_ext_door","targetname");
	var_02.animname = "gov_exit_door";
	var_02 maps\_utility::assign_animtree();
	var_00 thread maps\_anim::anim_first_frame_solo(var_02,"h_breach_exit_door_open");
	common_scripts\utility::flag_wait("flag_hostage_scan_started");
	wait(0.5);
	var_01 thread maps\_anim::anim_single_solo_run(level.joker,"h_breach_exit_door_open");
	var_00 thread maps\_anim::anim_single_solo(var_02,"h_breach_exit_door_open");
	wait(26.8);
	var_03 = getent("gov_hostage_ext_door_collision","targetname");
	if(level.nextgen)
	{
		var_03 delete();
	}

	thread maps\lagos_utility::ally_redirect_goto_node("Joker","gov_exit_joker");
	if(level.currentgen)
	{
		var_03.origin = var_03.origin - (0,0,200);
		common_scripts\utility::flag_wait("gov_player_exiting_area");
		var_03.origin = var_03.origin + (0,0,200);
	}
}

//Function Number: 138
h_breach_blockers_delete()
{
	wait(4.4);
	var_00 = getent("gov_h_breach_blocker","targetname");
	var_00 delete();
	var_01 = getent("hbreach_NoSight","targetname");
	var_01 delete();
}

//Function Number: 139
gov_hostage_breach_actor_anims_and_idle(param_00,param_01,param_02,param_03,param_04)
{
	param_01 endon("death");
	param_01 notify("anim_breach_begin");
	if(isdefined(param_04))
	{
		param_00 endon(param_04);
	}

	if(isdefined(param_03))
	{
		param_00 maps\_anim::anim_single_solo(param_01,param_02);
	}
	else
	{
		param_00 maps\_anim::anim_single_solo_run(param_01,param_02);
	}

	if(!common_scripts\utility::flag("pm_released"))
	{
		if(isdefined(param_03))
		{
			param_00 maps\_anim::anim_loop_solo(param_01,param_03,param_04);
		}
	}

	param_01 notify("anim_breach_complete");
}

//Function Number: 140
debug_anim_time(param_00)
{
	self endon("death");
	wait 0.05;
}

//Function Number: 141
gov_hostage_breach_actor_anims_straight_to_idle(param_00,param_01,param_02,param_03,param_04,param_05)
{
	param_01 endon("death");
	param_00 maps\_anim::anim_single_solo(param_01,param_02);
	if(isdefined(param_05))
	{
		param_00 maps\_anim::anim_single_solo(param_01,param_05);
	}

	if(isdefined(param_03))
	{
		param_00 thread maps\_anim::anim_loop_solo(param_01,param_03,param_04);
		if(isdefined(param_04))
		{
			level waittill(param_04);
			wait 0.05;
			param_00 notify(param_04);
		}
	}
}

//Function Number: 142
gov_hostage_breach_give_radio()
{
	var_00 = self gettagorigin("TAG_INHAND");
	var_01 = self gettagangles("TAG_INHAND");
	var_02 = spawn("script_model",self.origin);
	var_02 setmodel("com_hand_radio");
	var_02.origin = var_00;
	var_02.angles = var_01;
	var_02 linkto(self,"TAG_INHAND");
	self waittill("anim_breach_complete");
	var_02 delete();
}

//Function Number: 143
restrict_movement_while_releasing_the_pm()
{
	var_00 = getent("player_release_pm_volume","targetname");
	for(;;)
	{
		if(level.player istouching(var_00))
		{
			level.player allowcrouch(0);
			level.player allowprone(0);
			while(level.player istouching(var_00))
			{
				wait 0.05;
			}

			level.player allowcrouch(1);
			level.player allowprone(1);
		}

		wait 0.05;
	}
}

//Function Number: 144
gov_hostage_player_scan(param_00,param_01)
{
	level waittill("scan_idle_go");
	maps\_utility::autosave_by_name();
	var_02 = getent("player_release_pm_trigger","targetname");
	var_03 = var_02 maps\_shg_utility::hint_button_trigger("x",400);
	var_02 sethintstring(&"LAGOS_RELEASE_PM");
	var_02 waittill("trigger",var_04);
	var_03 maps\_shg_utility::hint_button_clear();
	var_02 sethintstring("");
	var_02 makeunusable();
	common_scripts\utility::flag_set("hostage_release_lighting");
	common_scripts\utility::flag_set("flag_hostage_scan_started");
	level.player maps\_shg_utility::setup_player_for_scene();
	level.player enableslowaim(0.2,0.2);
	getent("PM_use_clip","targetname") delete();
	var_05 = maps\_utility::spawn_anim_model("player_rig",level.player.origin);
	var_05 hide();
	param_00 maps\_anim::anim_first_frame_solo(var_05,"h_breach_pt2");
	var_06 = 0.5;
	level.player playerlinktoblend(var_05,"tag_player",var_06,var_06 * 0.5,var_06 * 0.5);
	wait(var_06);
	level.player playerlinktodelta(var_05,"tag_player",1,7,7,5,5,1);
	var_05 show();
	level notify("player_end_scan");
	common_scripts\utility::flag_set("pm_released");
	common_scripts\utility::flag_set("obj_progress_free_pm_clear");
	param_00 maps\_anim::anim_single_solo(var_05,"h_breach_pt2");
	common_scripts\utility::flag_clear("pm_released");
	level.player unlink();
	var_05 delete();
	level.player maps\_shg_utility::setup_player_for_gameplay();
	level.player disableslowaim();
	wait(1);
	common_scripts\utility::flag_set("obj_complete_rescue_PM");
	wait(1);
	common_scripts\utility::flag_set("obj_find_hostage_truck");
	common_scripts\utility::flag_wait("flag_leaving_gov_building");
	maps\_utility::autosave_by_name();
}

//Function Number: 145
gov_rear_setup()
{
	thread gov_rear_squad_roundabout_goto();
	level waittill("BreachComplete");
	if(common_scripts\utility::flag("pre_h_breach_playerstart") || common_scripts\utility::flag("post_h_breach_playerstart"))
	{
		level.gov_veh_spawners = [];
		level.gov_soldiers_veh = [];
	}

	var_00 = getentarray("gov_rear_foot_soldier","targetname");
	foreach(var_02 in var_00)
	{
		var_03 = var_02 maps\_utility::spawn_ai(1);
		var_04 = var_03.target;
		var_03 maps\_utility::set_goal_node(getnode(var_03.target,"targetname"));
		var_03 thread gov_building_rear_removal();
	}

	common_scripts\utility::flag_wait("gov_rear_init");
	var_00 = maps\_utility::get_living_ai_array("gov_rear_soldier","script_noteworthy");
	foreach(var_02 in var_00)
	{
		var_02 thread gov_building_rear_removal();
		level.gov_soldiers_veh = common_scripts\utility::array_add(level.gov_soldiers_veh,var_02);
	}
}

//Function Number: 146
gov_rear_squad_roundabout_goto()
{
	level waittill("breach_anims_complete");
	foreach(var_01 in level.alpha_squad)
	{
		var_01.ignoreall = 0;
		var_01 maps\_utility::disable_cqbwalk();
	}

	thread maps\lagos_utility::ally_redirect_goto_node("Gideon","gov_exit_burke");
	thread maps\lagos_utility::ally_redirect_goto_node("Ajani","gov_exit_ajani");
	common_scripts\utility::flag_wait("gov_hostage_exit_door_open");
	common_scripts\utility::flag_wait("gov_player_exiting_area");
	thread maps\lagos_utility::ally_redirect_goto_node("Gideon","roundabout_start_burke");
	wait(1);
	thread maps\lagos_utility::ally_redirect_goto_node("Joker","roundabout_start_joker");
	wait(1);
	thread maps\lagos_utility::ally_redirect_goto_node("Ajani","roundabout_start_ajani");
}

//Function Number: 147
roundabout_setup()
{
	level.lookat_roundabout_rappel_trigger = getent("lookat_roundabout_rappel_trigger","targetname");
	level.lookat_roundabout_tanker_explode_trigger = getent("lookat_roundabout_tanker_explode_trigger","targetname");
	level.lookat_roundabout_rappel_trigger common_scripts\utility::trigger_off();
	level.lookat_roundabout_tanker_explode_trigger common_scripts\utility::trigger_off();
	level.tanker_fire_hurt_trigger = getent("trigger_tanker_fire_hurt","targetname");
	level.tanker_fire_hurt_trigger common_scripts\utility::trigger_off();
	level.rb_blast_marks = getentarray("roundabout_rpg_building_blast_geo","targetname");
	if(isdefined(level.rb_blast_marks))
	{
		foreach(var_01 in level.rb_blast_marks)
		{
			var_01 hide();
		}
	}

	var_03 = getent("badPlace_roundabout_lobby","targetname");
	badplace_cylinder("ally_badPlace_roundabout_lobby",-1,var_03.origin,150,200,"allies");
	var_04 = getentarray("roundabout_badplace_lobby_to_center","targetname");
	foreach(var_06 in var_04)
	{
		badplace_brush("roundabout_badplace_lobby_to_center",-1,var_06,"neutral");
	}

	thread maps\lagos_vo::leaving_gov_building();
	thread maps\lagos_vo::approaching_roundabout_dialogue();
	thread maps\lagos_vo::roundabout_combat_dialogue();
	common_scripts\utility::flag_wait("checkpoint_roundabout_lobby");
	maps\_utility::autosave_by_name("checkpoint_roundabout_lobby");
	level.burke maps\lagos_utility::enable_awareness();
	level.joker maps\lagos_utility::enable_awareness();
	level.ajani maps\lagos_utility::enable_awareness();
	common_scripts\utility::flag_wait("roundabout_combat_begin");
	badplace_delete("ally_badPlace_roundabout_lobby");
	common_scripts\utility::flag_wait("checkpoint_roundabout_center");
	maps\_utility::autosave_by_name_silent("checkpoint_roundabout_center");
}

//Function Number: 148
roundabout_combat()
{
	level.enemies_1_a_south = [];
	var_00 = [];
	var_01 = [];
	var_02 = [];
	var_03 = [];
	var_04 = [];
	var_05 = [];
	var_06 = [];
	var_07 = [];
	var_08 = [];
	var_09 = [];
	roundabout_combat_initial();
	common_scripts\utility::flag_wait("roundabout_combat_begin");
	var_0A = undefined;
	var_0B = getentarray("tanker_explosion_tanker","script_noteworthy");
	foreach(var_0D in var_0B)
	{
		if(var_0D.classname == "script_model")
		{
			var_0A = var_0D;
		}
	}

	var_0F = 2000;
	var_0A.health = var_0F;
	var_0A setcandamage(1);
	var_0A thread roundabout_tanker_damage(var_0F);
	level.roundabout_ropes = [];
	wait(4);
	if(level.currentgen)
	{
		var_00 = [];
		var_00 = maps\_utility::array_spawn_targetname_cg("Roundabout_enemies_1_C_south",1,0.05);
	}
	else
	{
		var_00 = maps\_utility::array_spawn_targetname("Roundabout_enemies_1_C_south",1);
	}

	var_07 = common_scripts\utility::array_combine(var_07,level.enemies_1_a_south);
	var_07 = common_scripts\utility::array_combine(var_07,level.enemies_1_a2_south);
	var_07 = common_scripts\utility::array_combine(var_07,var_00);
	thread maps\lagos_utility::spawn_wave_upkeep_and_flag(var_07,"roundabout_wave_1A_complete",2,0);
	thread roundabout_magic_microwave_grenade();
	thread hint_text_exo_shield();
	thread roundabout_rush_goal(var_07,"enemy_goal_Roundabout_rush_SE",8);
	thread roundabout_rush_goal(var_07,"enemy_goal_Roundabout_rush_SE_inside",10);
	thread roundabout_rush_goal(var_07,"enemy_goal_Roundabout_D",12);
	common_scripts\utility::flag_wait("roundabout_wave_1A_complete");
	var_07 = maps\_utility::array_removedead_or_dying(var_07);
	var_10 = getent("enemy_goal_Roundabout_C","targetname");
	foreach(var_12 in var_07)
	{
		if(isdefined(var_12) && isalive(var_12))
		{
			var_12 cleargoalvolume();
			var_12 maps\_utility::player_seek_disable();
			wait 0.05;
			if(isdefined(var_12) && isalive(var_12))
			{
				var_12 setgoalvolumeauto(var_10);
			}
		}
	}

	if(!common_scripts\utility::flag("obj_progress_find_hostage_truck_roundabout_complete"))
	{
		if(level.currentgen)
		{
			var_01 = [];
			var_01 = maps\_utility::array_spawn_targetname_cg("Roundabout_enemies_2_A_south",1,0.05);
		}
		else
		{
			var_01 = maps\_utility::array_spawn_targetname("Roundabout_enemies_2_A_south",1);
		}

		foreach(var_12 in var_01)
		{
			var_12.health = 100;
		}

		wait(2);
		foreach(var_12 in var_01)
		{
			if(isdefined(var_12.script_noteworthy) && issubstr(var_12.script_noteworthy,"sniper"))
			{
				var_12.custom_laser_function = ::maps\lagos_utility::lagos_custom_laser;
				var_12 maps\lagos_utility::lagos_custom_laser();
				var_12.goalradius = 2;
			}
		}

		var_07 = common_scripts\utility::array_combine(var_07,var_01);
		thread maps\lagos_utility::spawn_wave_upkeep_and_flag(var_07,"roundabout_wave_1B_complete",2,0);
		common_scripts\utility::flag_wait("roundabout_wave_1B_complete");
		var_07 = maps\_utility::array_removedead_or_dying(var_07);
		if(level.currentgen)
		{
			var_02 = [];
			var_02 = maps\_utility::array_spawn_targetname_cg("Roundabout_enemies_2_B_west",1,0.05);
		}
		else
		{
			var_02 = maps\_utility::array_spawn_targetname("Roundabout_enemies_2_B_west",1);
		}

		foreach(var_12 in var_02)
		{
			var_12.ignoreall = 1;
			var_12.ignoreme = 1;
			if(!isdefined(var_12.damage_functions))
			{
				var_12.damage_functions = [];
			}
		}

		thread anim_roundabout_rappel_1(var_02);
		if(level.currentgen)
		{
			var_1A = [];
			var_1A = maps\_utility::array_spawn_targetname_cg("Roundabout_enemies_2_E_west",1,0.05);
		}
		else
		{
			var_1A = maps\_utility::array_spawn_targetname("Roundabout_enemies_2_E_west",1);
		}

		var_08 = common_scripts\utility::array_combine(var_08,var_07);
		var_08 = common_scripts\utility::array_combine(var_08,var_02);
		var_08 = common_scripts\utility::array_combine(var_08,var_1A);
		thread maps\lagos_utility::spawn_wave_upkeep_and_flag(var_08,"roundabout_wave_2A_complete",2,0);
		common_scripts\utility::flag_wait("roundabout_wave_2A_complete");
		maps\_utility::autosave_by_name();
		var_08 = maps\_utility::array_removedead_or_dying(var_08);
		if(level.currentgen)
		{
			var_03 = [];
			var_03 = maps\_utility::array_spawn_targetname_cg("Roundabout_enemies_2_C_west",1,0.05);
		}
		else
		{
			var_03 = maps\_utility::array_spawn_targetname("Roundabout_enemies_2_C_west",1);
		}

		if(level.currentgen)
		{
			var_04 = [];
			var_04 = maps\_utility::array_spawn_targetname_cg("Roundabout_enemies_2_D_west",1,0.05);
		}
		else
		{
			var_04 = maps\_utility::array_spawn_targetname("Roundabout_enemies_2_D_west",1);
		}

		common_scripts\utility::flag_set("roundabout_wave_2_all_spawned");
		foreach(var_12 in var_04)
		{
			var_12.ignoreall = 1;
			var_12.ignoreme = 1;
			if(!isdefined(var_12.damage_functions))
			{
				var_12.damage_functions = [];
			}
		}

		thread anim_roundabout_rappel_2(var_04);
		var_08 = common_scripts\utility::array_combine(var_08,var_03);
		var_08 = common_scripts\utility::array_combine(var_08,var_04);
		thread maps\lagos_utility::spawn_wave_upkeep_and_flag(var_08,"roundabout_wave_2B_complete",2,0);
		thread roundabout_rush_goal(var_08,"enemy_goal_Roundabout_van_SW",1,1);
		thread roundabout_rush_goal(var_08,"enemy_goal_Roundabout_rush_SW",9);
		thread roundabout_rush_goal(var_08,"enemy_goal_Roundabout_rush_SW_inside",10);
		thread roundabout_rush_goal(var_08,"enemy_goal_Roundabout_B",13);
		common_scripts\utility::flag_wait("roundabout_wave_2B_complete");
		var_08 = maps\_utility::array_removedead_or_dying(var_08);
		var_10 = getent("enemy_goal_Roundabout_B","targetname");
		foreach(var_12 in var_08)
		{
			if(isdefined(var_12) && isalive(var_12))
			{
				var_12 cleargoalvolume();
				var_12 maps\_utility::player_seek_disable();
				wait 0.05;
				if(isdefined(var_12) && isalive(var_12))
				{
					var_12 setgoalvolumeauto(var_10);
				}
			}
		}
	}

	if(!common_scripts\utility::flag("obj_progress_find_hostage_truck_roundabout_complete"))
	{
		if(level.currentgen)
		{
			var_05 = [];
			var_05 = maps\_utility::array_spawn_targetname_cg("Roundabout_enemies_3_A_east",1,0.05);
		}
		else
		{
			var_05 = maps\_utility::array_spawn_targetname("Roundabout_enemies_3_A_east",1);
		}

		var_09 = common_scripts\utility::array_combine(var_09,var_08);
		var_09 = common_scripts\utility::array_combine(var_09,var_05);
		thread maps\lagos_utility::spawn_wave_upkeep_and_flag(var_09,"roundabout_wave_3A_complete",2,0);
		thread roundabout_rush_goal(var_09,"enemy_goal_Roundabout_rush_SE_inside",4);
		common_scripts\utility::flag_wait("roundabout_wave_3A_complete");
		var_09 = maps\_utility::array_removedead_or_dying(var_09);
		var_06 = maps\_utility::array_spawn_targetname("Roundabout_enemies_3_B_south",1);
		common_scripts\utility::flag_set("roundabout_wave_3_all_spawned");
		var_09 = common_scripts\utility::array_combine(var_09,var_06);
		thread roundabout_rush_goal(var_09,"enemy_goal_Roundabout_van_SE",1,1);
		thread roundabout_rush_goal(var_09,"enemy_goal_Roundabout_rush_E",8);
		thread roundabout_rush_goal(var_09,"enemy_goal_Roundabout_rush_SE_inside",10);
		wait(3);
		if(!common_scripts\utility::flag("flag_roundabout_tanker_explode"))
		{
			if(level.currentgen)
			{
				var_1F = [];
				var_1F = maps\_utility::array_spawn_targetname_cg("Roundabout_enemies_OnTanker",1,0.05);
			}
			else
			{
				var_1F = maps\_utility::array_spawn_targetname("Roundabout_enemies_OnTanker",1);
			}

			foreach(var_12 in var_1F)
			{
				var_12.ignoreme = 1;
				var_12 thread roundabout_tanker_enemy_settings();
			}

			thread maps\lagos_utility::spawn_wave_upkeep_and_flag(var_1F,"roundabout_wave_3_complete",0);
			common_scripts\utility::flag_wait("roundabout_wave_3_complete");
			if(!common_scripts\utility::flag("flag_roundabout_tanker_explode"))
			{
				thread roundabout_tanker_magic_rpg();
				wait(1.33);
				if(!common_scripts\utility::flag("flag_roundabout_tanker_explode"))
				{
					roundabout_combat_tanker_explode();
					var_09 = maps\_utility::array_removedead_or_dying(var_09);
					common_scripts\utility::array_call(var_09,::kill);
				}
			}
		}
		else
		{
			var_09 = maps\_utility::array_removedead_or_dying(var_09);
			thread maps\lagos_utility::spawn_wave_upkeep_and_flag(var_09,"roundabout_wave_3_complete",0,0);
			common_scripts\utility::flag_wait("roundabout_wave_3_complete");
		}

		wait(0.25);
		common_scripts\utility::flag_set("obj_progress_find_hostage_truck_roundabout");
		common_scripts\utility::flag_set("obj_progress_find_hostage_truck_roundabout_complete");
		var_22 = getnode("node_roundabout_escape_burke","targetname");
		var_23 = getnode("node_roundabout_escape_joker","targetname");
		var_24 = getnode("node_roundabout_escape_ajani","targetname");
		level.burke maps\_utility::set_goal_node(var_22);
		level.joker maps\_utility::set_goal_node(var_23);
		level.ajani maps\_utility::set_goal_node(var_24);
		var_25 = getent("kva_goal_Roundabout_complete","targetname");
		if(var_09.size > 0)
		{
			var_26 = 0;
			foreach(var_12 in var_09)
			{
				if(isdefined(var_12) && isalive(var_12))
				{
					var_12 cleargoalvolume();
					var_12 maps\_utility::player_seek_disable();
					wait 0.05;
					var_12 setgoalvolumeauto(var_25);
					if(var_26 % 2)
					{
						var_12 thread maps\lagos_utility::ignore_all_until_path_end();
					}

					var_26++;
				}
			}
		}

		common_scripts\utility::flag_wait("alley1_spawn");
		foreach(var_2A in level.roundabout_ropes)
		{
			var_2A delete();
		}
	}
}

//Function Number: 149
roundabout_magic_microwave_grenade()
{
	wait(5);
	var_00 = common_scripts\utility::getstruct("microwave_gren_throw","targetname");
	var_01 = common_scripts\utility::getstruct("microwave_gren_target","targetname");
	var_02 = magicgrenade("microwave_grenade",var_00.origin,var_01.origin);
	var_02 thread maps\_microwave_grenade::microwave_grenade_explode_wait();
	var_02 waittill("explode",var_03);
	common_scripts\utility::flag_set("flag_roundabout_magic_MWG");
}

//Function Number: 150
hint_text_exo_shield()
{
	level.player endon("death");
	wait(25);
	if(level.player maps\_player_exo::exo_shield_is_on() == 0)
	{
		if(level.player.exobatterylevel >= 1)
		{
			maps\_utility::hintdisplayhandler("use_exo_shield",5);
			while(!common_scripts\utility::flag("flag_roundabout_exo_shield"))
			{
				if(level.player buttonpressed("DPAD_DOWN"))
				{
					common_scripts\utility::flag_set("flag_roundabout_exo_shield");
				}

				wait 0.05;
			}
		}
	}
}

//Function Number: 151
use_exo_shield_check()
{
	level.player endon("death");
	if(common_scripts\utility::flag("flag_roundabout_exo_shield"))
	{
		return 1;
	}

	return 0;
}

//Function Number: 152
roundabout_tanker_damage(param_00)
{
	while(isdefined(self) && isalive(self))
	{
		self waittill("damage",var_01,var_02,var_03,var_04,var_05,var_06,var_07,var_08,var_09,var_0A);
		if(var_02 != level.player && self.health / param_00 <= 0.25 && self.health > 0)
		{
			self.health = self.health + var_01;
		}

		if(self.health <= 100 && var_02 == level.player)
		{
			common_scripts\utility::flag_set("flag_roundabout_tanker_explode");
			roundabout_combat_tanker_explode();
			return;
		}

		wait 0.05;
	}
}

//Function Number: 153
roundabout_rush_goal(param_00,param_01,param_02,param_03)
{
	wait(param_02);
	param_00 = maps\_utility::array_removedead_or_dying(param_00);
	if(param_00.size <= 0)
	{
		return;
	}

	var_04 = getent(param_01,"targetname");
	foreach(var_06 in param_00)
	{
		var_06.distance_to_goalvol_sq = distancesquared(var_06.origin,var_04.origin);
	}

	if(isdefined(param_03) && param_03)
	{
		param_00 = common_scripts\utility::array_sort_with_func(param_00,::maps\lagos_utility::closer_to_goal_vol);
	}
	else
	{
		param_00 = common_scripts\utility::array_sort_with_func(param_00,::maps\lagos_utility::farther_to_goal_vol);
	}

	foreach(var_06 in param_00)
	{
		if(isdefined(var_06.rushed) || issubstr(var_06.classname,"sniper") || issubstr(var_06.classname,"rpg"))
		{
			param_00 = common_scripts\utility::array_remove(param_00,var_06);
		}
	}

	foreach(var_06 in param_00)
	{
		if(isdefined(var_06) && isalive(var_06))
		{
			if(isdefined(param_03) && param_03)
			{
				var_06.goalradius = 16;
			}

			var_06.ignoreme = 1;
			var_06.grenadeammo = 0;
			var_06 setgoalvolumeauto(var_04);
			var_06.rushed = 1;
			var_06 thread maps\lagos_utility::ignore_until_goal_reached();
			var_06 waittill("goal");
			if(isdefined(var_06) && isalive(var_06))
			{
				if(!isdefined(param_03) || !param_03)
				{
					var_06 thread maps\_utility::player_seek_enable();
				}
				else if(isdefined(param_03) && param_03)
				{
					var_06.script_fixednode = 1;
				}
			}

			wait(2);
			if(isdefined(var_06) && isalive(var_06))
			{
				var_06.ignoreme = 0;
			}

			return;
		}
	}
}

//Function Number: 154
roundabout_tanker_enemy_settings()
{
	self.deathanim = %bog_b_rpg_fall_death;
	self waittill("death");
	if(common_scripts\utility::flag("flag_roundabout_tanker_explode"))
	{
		self hide();
		self delete();
		return;
	}

	wait(1.5);
	if(isdefined(self))
	{
		self.weapon = "none";
		self hide();
		self delete();
	}
}

//Function Number: 155
roundabout_tanker_enemy_settings_other()
{
	common_scripts\utility::flag_wait("flag_delete_other_tanker_enemies");
	wait(1.5);
	if(isdefined(self))
	{
		self.weapon = "none";
		self hide();
		self delete();
	}
}

//Function Number: 156
roundabout_tanker_magic_rpg()
{
	var_00 = getent("magicOrg_roundabout_tanker_source","targetname");
	var_01 = getent("magicOrg_roundabout_tanker_dest","targetname");
	wait(1);
	magicbullet("iw5_mahemstraight_sp",var_00.origin,var_01.origin);
}

//Function Number: 157
roundabout_combat_initial()
{
	common_scripts\utility::flag_wait("roundabout_combat_starting_soon");
	if(level.currentgen)
	{
		level.enemies_1_a2_south = [];
		level.enemies_1_a2_south = maps\_utility::array_spawn_targetname_cg("Roundabout_enemies_1_A2_south",1,0.05);
	}
	else
	{
		level.enemies_1_a2_south = maps\_utility::array_spawn_targetname("Roundabout_enemies_1_A2_south",1);
	}

	foreach(var_01 in level.enemies_1_a2_south)
	{
		var_01.ignoreall = 1;
		var_01.ignoreme = 1;
		var_01 thread maps\_utility::magic_bullet_shield();
		var_01.goalradius = 16;
	}

	common_scripts\utility::flag_wait("roundabout_combat_begin");
	var_03 = getent("magicOrg_roundabout_opening_1","targetname");
	var_04 = getent("magicOrg_roundabout_opening_2","targetname");
	var_05 = getent("magicOrg_roundabout_opening_3","targetname");
	var_06 = getent("magicOrg_roundabout_opening_4","targetname");
	var_07 = getent("magicDest_roundabout_opening_1","targetname");
	var_08 = getent("magicDest_roundabout_opening_1_A","targetname");
	var_09 = getent("magicDest_roundabout_opening_2","targetname");
	var_0A = getent("magicDest_roundabout_opening_3","targetname");
	var_0B = getent("magicDest_roundabout_opening_4","targetname");
	var_0C = getent("magicDest_roundabout_opening_5","targetname");
	var_0D = getent("magicDest_roundabout_opening_6","targetname");
	common_scripts\utility::flag_set("roundabout_RPG_start");
	soundscripts\_snd::snd_message("roundabout_general_mayhem");
	level.player enableinvulnerability();
	var_0E = magicbullet("iw5_mahemstraight_sp",var_05.origin,var_07.origin);
	var_0E soundscripts\_snd::snd_message("roundabout_rpg_fire");
	wait(0.75);
	var_0E = magicbullet("iw5_mahemstraight_sp",var_03.origin,var_08.origin);
	var_0E soundscripts\_snd::snd_message("roundabout_rpg_fire");
	wait(0.25);
	var_0E = magicbullet("iw5_mahemstraight_sp",var_04.origin,var_09.origin);
	var_0E soundscripts\_snd::snd_message("roundabout_rpg_fire");
	wait(0.5);
	level notify("drivers_get_out");
	common_scripts\utility::flag_set("flag_Roundabout_Civilians_Flee");
	soundscripts\_snd::snd_message("roundabout_combat_started");
	if(level.currentgen)
	{
		level.enemies_1_a_south = [];
		level.enemies_1_a_south = maps\_utility::array_spawn_targetname_cg("Roundabout_enemies_1_A_south",1,0.05);
	}
	else
	{
		level.enemies_1_a_south = maps\_utility::array_spawn_targetname("Roundabout_enemies_1_A_south",1);
	}

	var_0F = level.enemies_1_a_south[0].goalradius;
	foreach(var_01 in level.enemies_1_a_south)
	{
		var_01.ignoreall = 1;
		var_01.ignoreme = 1;
		var_01 thread maps\_utility::magic_bullet_shield();
		var_01.goalradius = 16;
	}

	if(level.nextgen)
	{
		var_0E = magicbullet("iw5_mahemstraight_sp",var_05.origin,var_0A.origin);
		var_0E soundscripts\_snd::snd_message("roundabout_rpg_fire");
		wait(0.25);
		var_0E = magicbullet("iw5_mahemstraight_sp",var_06.origin,var_0B.origin);
		var_0E soundscripts\_snd::snd_message("roundabout_rpg_fire");
		wait(0.25);
		var_0E = magicbullet("iw5_mahemstraight_sp",var_05.origin,var_0C.origin);
		var_0E soundscripts\_snd::snd_message("roundabout_rpg_fire");
		wait(0.75);
		var_0E = magicbullet("iw5_mahemstraight_sp",var_05.origin,var_0D.origin);
		var_0E soundscripts\_snd::snd_message("roundabout_rpg_fire");
	}

	thread maps\lagos_utility::stop_vehicle_traffic_roundabout_straightways();
	level.player disableinvulnerability();
	if(level.nextgen)
	{
		radiusdamage(common_scripts\utility::getstruct("roundabout_magic_extra_damage_1","targetname").origin,350,10000,9000);
	}

	foreach(var_01 in level.enemies_1_a_south)
	{
		if(isdefined(var_01) && isalive(var_01))
		{
			var_01.ignoreall = 0;
			var_01.ignoreme = 0;
			var_01 maps\_utility::stop_magic_bullet_shield();
		}
	}

	foreach(var_01 in level.enemies_1_a2_south)
	{
		if(isdefined(var_01) && isalive(var_01))
		{
			var_01.ignoreall = 0;
			var_01.ignoreme = 0;
			var_01 maps\_utility::stop_magic_bullet_shield();
		}
	}

	wait(2);
	var_16 = getent("enemy_goal_Roundabout_Fallback_East","targetname");
	foreach(var_01 in level.enemies_1_a_south)
	{
		var_01 setgoalvolumeauto(var_16);
	}

	maps\_utility::battlechatter_on("allies");
	maps\_utility::battlechatter_on("axis");
}

//Function Number: 158
roundabout_combat_tanker_explode()
{
	soundscripts\_snd::snd_message("roundabout_tanker_explosion");
	level thread maps\lagos_fx::roundabout_tanker_explosion();
	var_00 = common_scripts\utility::getstruct("struct_roundabout_tanker_loc","targetname");
	earthquake(0.6,0.5,var_00.origin,3000);
	thread maps\lagos_utility::rumble_roundabout_tanker();
	var_01 = getentarray("tanker_explosion_tanker","script_noteworthy");
	foreach(var_03 in var_01)
	{
		if(var_03.classname == "script_model")
		{
			var_03 setmodel("ind_semi_truck_fuel_tank_destroy");
		}
	}

	var_05 = getentarray("tanker_explosion_cab","script_noteworthy");
	foreach(var_03 in var_05)
	{
		if(var_03.classname == "script_model")
		{
			var_03 setmodel("ind_semi_truck_03_destroy");
		}
	}

	var_08 = getentarray("roundabout_rpg_building_clean_geo","targetname");
	if(isdefined(var_08))
	{
		foreach(var_0A in var_08)
		{
			var_0A hide();
		}
	}

	if(isdefined(level.rb_blast_marks))
	{
		foreach(var_0A in level.rb_blast_marks)
		{
			var_0A show();
		}
	}

	if(level.nextgen)
	{
		radiusdamage(common_scripts\utility::getstruct("kill_kva_rpgs_0","targetname").origin,300,10000,9000);
		radiusdamage(common_scripts\utility::getstruct("kill_kva_rpgs_1","targetname").origin,300,10000,9000);
		radiusdamage(common_scripts\utility::getstruct("kill_kva_rpgs_2","targetname").origin,300,10000,9000);
		wait(0.5);
		radiusdamage(common_scripts\utility::getstruct("roundabout_tanker_ground_damage_1","targetname").origin,350,10000,9000);
		radiusdamage(common_scripts\utility::getstruct("roundabout_tanker_ground_damage_2","targetname").origin,350,10000,9000);
		wait(0.5);
		radiusdamage(common_scripts\utility::getstruct("roundabout_tanker_ground_damage_3","targetname").origin,350,10000,9000);
		wait(0.5);
		radiusdamage(common_scripts\utility::getstruct("roundabout_tanker_ground_damage_5","targetname").origin,350,10000,9000);
		radiusdamage(common_scripts\utility::getstruct("roundabout_tanker_ground_damage_6","targetname").origin,350,10000,9000);
	}
	else
	{
		roundabout_combat_tanker_explode_veh_cg();
	}

	var_0E = getcorpsearray();
	foreach(var_10 in var_0E)
	{
		if(issubstr(var_10.classname,"rpg"))
		{
			var_10 delete();
		}
	}

	var_12 = getweaponarray();
	foreach(var_10 in var_12)
	{
		if(issubstr(var_10.classname,"mahem"))
		{
			var_10 delete();
		}
	}

	thread roundabout_combat_tanker_fire_damage();
}

//Function Number: 159
roundabout_combat_tanker_fire_damage()
{
	level.tanker_fire_hurt_trigger common_scripts\utility::trigger_on();
	common_scripts\utility::flag_wait("kill_roundabout_flames");
	level.tanker_fire_hurt_trigger common_scripts\utility::trigger_off();
}

//Function Number: 160
roundabout_combat_tanker_explode_veh_cg()
{
	var_00 = getent("magicOrg_roundabout_tanker_dest","targetname");
	var_01 = getent("magicOrg_roundabout_tanker_source","targetname");
	level.roundabout_center_vehicles_tank_explo = common_scripts\utility::array_add(level.roundabout_center_vehicles_tank_explo,var_01);
	level.roundabout_center_vehicles_tank_explo = sortbydistance(level.roundabout_center_vehicles_tank_explo,var_00.origin);
	foreach(var_03 in level.roundabout_center_vehicles_tank_explo)
	{
		wait(randomfloatrange(0.1,0.5));
		if(isdefined(var_03))
		{
			radiusdamage(var_03.origin,150,10000,9000);
		}
	}
}

//Function Number: 161
roundabout_bicycle_riders()
{
	common_scripts\utility::flag_wait("flag_roundabout_bikes_move");
	maps\_utility::delaythread(0.01,::maps\lagos_utility::bike_rider,"roundabout_bike_path_1",8);
	maps\_utility::delaythread(1,::maps\lagos_utility::bike_rider,"roundabout_bike_path_2",7);
}

//Function Number: 162
roundabout_combat_start_slow_motion()
{
	level.player thread maps\_utility::play_sound_on_entity("slomo_whoosh");
	level.player thread maps\lagos_qte::player_heartbeat();
	maps\_utility::slowmo_start();
	level.player allowmelee(0);
	maps\_utility::slowmo_setspeed_slow(0.1);
	maps\_utility::slowmo_setlerptime_in(0.25);
	maps\_utility::slowmo_lerp_in();
	wait(0.5);
	level notify("stop_player_heartbeat");
	level.player thread maps\_utility::play_sound_on_entity("slomo_whoosh");
	maps\_utility::slowmo_setlerptime_out(0.75);
	maps\_utility::slowmo_lerp_out();
	level.player allowmelee(1);
	maps\_utility::slowmo_end();
	earthquake(0.5,1,level.player.origin,1000);
}

//Function Number: 163
anim_roundabout_rappel_1(param_00)
{
	level.lookat_roundabout_rappel_trigger common_scripts\utility::trigger_on();
	thread maps\lagos_utility::timeout_and_flag("lookat_roundabout_rappel_go",2);
	common_scripts\utility::flag_wait("lookat_roundabout_rappel_go");
	var_01 = getent("anim_org_rb_rappel_R1","targetname");
	var_02 = getent("anim_org_rb_rappel_R2","targetname");
	if(param_00.size >= 2)
	{
		if(isalive(param_00[0]))
		{
			param_00[0].animname = "KVA_rappel_right";
			param_00[0] maps\_utility::add_damage_function(::kill_kva_on_rope);
			thread threaded_anim_roundabout_rappel(var_01,param_00[0],"rb_rappel_right");
			wait(0.5);
		}

		if(isalive(param_00[1]))
		{
			param_00[1].animname = "KVA_rappel_right";
			param_00[1] maps\_utility::add_damage_function(::kill_kva_on_rope);
			thread threaded_anim_roundabout_rappel(var_02,param_00[1],"rb_rappel_right");
			wait(0.5);
		}
	}

	level.lookat_roundabout_rappel_trigger common_scripts\utility::trigger_off();
	common_scripts\utility::flag_clear("lookat_roundabout_rappel_go");
}

//Function Number: 164
kill_kva_on_rope(param_00,param_01,param_02,param_03,param_04,param_05,param_06)
{
	self endon("rappel_complete");
	if(param_01 == level.player)
	{
		self notify("killanimscript");
		maps\lagos_utility::challenge_point_award();
		self kill(self.origin);
		self startragdoll();
	}
}

//Function Number: 165
anim_roundabout_rappel_2(param_00)
{
	level.lookat_roundabout_rappel_trigger common_scripts\utility::trigger_on();
	thread maps\lagos_utility::timeout_and_flag("lookat_roundabout_rappel_go",2);
	common_scripts\utility::flag_wait("lookat_roundabout_rappel_go");
	var_01 = getent("anim_org_rb_rappel_L1","targetname");
	var_02 = getent("anim_org_rb_rappel_L2","targetname");
	if(param_00.size >= 2)
	{
		if(isalive(param_00[0]))
		{
			param_00[0].animname = "KVA_rappel_left";
			param_00[0] maps\_utility::add_damage_function(::kill_kva_on_rope);
			thread threaded_anim_roundabout_rappel(var_01,param_00[0],"rb_rappel_left");
			wait(0.5);
		}

		if(isalive(param_00[1]))
		{
			param_00[1].animname = "KVA_rappel_left";
			param_00[1] maps\_utility::add_damage_function(::kill_kva_on_rope);
			thread threaded_anim_roundabout_rappel(var_02,param_00[1],"rb_rappel_left");
			wait(0.5);
		}
	}
}

//Function Number: 166
threaded_anim_roundabout_rappel(param_00,param_01,param_02)
{
	param_01 endon("death");
	var_03 = spawn("script_model",param_00.origin);
	var_03 setmodel("rope50ft");
	var_03 useanimtree(level.scr_animtree["rappel_roundabout"]);
	var_03.animname = "rappel_roundabout";
	level.roundabout_ropes = common_scripts\utility::array_add(level.roundabout_ropes,var_03);
	if(issubstr(param_02,"right"))
	{
		param_00 maps\_anim::anim_single_solo(var_03,"start_rope_right");
	}
	else if(issubstr(param_02,"left"))
	{
		param_00 maps\_anim::anim_single_solo(var_03,"start_rope_left");
	}

	wait(0.1);
	if(issubstr(param_02,"right"))
	{
		param_00 maps\_anim::anim_first_frame_solo(var_03,"rope_right");
		param_00 maps\_anim::anim_first_frame_solo(param_01,param_02);
		wait(0.05);
		param_00 thread maps\_anim::anim_single_solo(var_03,"rope_right");
		param_00 thread maps\_anim::anim_single_solo(param_01,param_02);
	}
	else if(issubstr(param_02,"left"))
	{
		param_00 maps\_anim::anim_first_frame_solo(var_03,"rope_left");
		param_00 maps\_anim::anim_first_frame_solo(param_01,param_02);
		wait(0.05);
		param_00 thread maps\_anim::anim_single_solo(var_03,"rope_left");
		param_00 thread maps\_anim::anim_single_solo(param_01,param_02);
	}

	wait(3.8);
	param_01 notify("rappel_complete");
	param_01.ignoreall = 0;
	param_01.ignoreme = 0;
}

//Function Number: 167
roundabout_tanker_lookat()
{
	wait(15);
	level.lookat_roundabout_tanker_explode_trigger common_scripts\utility::trigger_on();
	thread maps\lagos_utility::timeout_and_flag("lookat_roundabout_rappel_go",10);
	common_scripts\utility::flag_wait("lookat_roundabout_rappel_go");
	common_scripts\utility::flag_set("roundabout_wave_3_complete");
}

//Function Number: 168
spawncivilians_roundabout()
{
	level.rb_flee_goal_pick = 0;
	common_scripts\utility::flag_wait("flag_roundabout_spawn_vehicles");
	thread spawnmalecivilians_roundabout();
	thread spawnfemalecivilians_roundabout();
	thread spawnwalkingcivilians_roundabout();
	thread roundabout_lobby_elevator();
	thread roundabout_lobby_couch();
	thread roundabout_lobby_security_desk();
	thread roundabout_lobby_phone();
	thread roundabout_lobby_phone2();
	thread roundabout_lobby_walkingtalk();
	thread roundabout_street_drop_bikes();
	thread roundabout_street_car_hood_hit();
	thread roundabout_lobby_couch_front();
	thread roundabout_lobby_security_desk_front();
	thread roundabout_lobby_phone_front();
	level.roundabout_flee_goals = getentarray("goal_roundabout_flee","targetname");
}

//Function Number: 169
roundabout_lobby_security_desk_front()
{
	var_00 = getent("rb_lobby_security_desk_1_front","targetname") maps\_utility::spawn_ai(1);
	var_01 = getent("rb_lobby_security_desk_2_front","targetname") maps\_utility::spawn_ai(1);
	var_00 endon("death");
	var_01 endon("death");
	var_00.alertlevelint = 0;
	var_01.alertlevelint = 0;
	var_00 maps\lagos_utility::immune_sonic_blast();
	var_01 maps\lagos_utility::immune_sonic_blast();
	var_00.animname = "lobby_security";
	var_01.animname = "lobby_security";
	level.civilian_roundabout_vo_1 = var_00;
	var_02 = getent("anim_org_rb_lobby_security_desk_front","targetname");
	var_03 = getent("anim_org_rb_lobby_security_desk_front_2","targetname");
	var_02 thread maps\_anim::anim_loop_solo(var_00,"security_loop_1","stop_loop");
	var_03 thread maps\_anim::anim_loop_solo(var_01,"security_loop_2","stop_loop");
	common_scripts\utility::flag_wait("flag_roundabout_player_move_0");
	var_03 notify("stop_loop");
	var_01 setlookatentity(level.player);
	var_03 maps\_anim::anim_single_solo(var_01,"security_react_2");
	var_03 maps\_anim::anim_single_solo(var_01,"security_react_loop_2");
	var_01 thread fleeingcivilian_roundaboutexit_lobby("civilian_goal_Roundabout_delete_front");
	common_scripts\utility::flag_wait("roundabout_wave_1A_complete");
	var_00 maps\_shg_design_tools::delete_auto();
}

//Function Number: 170
roundabout_lobby_phone_front()
{
	var_00 = getent("rb_lobby_phone_1_front","targetname") maps\_utility::spawn_ai(1);
	var_00 endon("death");
	var_00.alertlevelint = 0;
	var_00 maps\lagos_utility::immune_sonic_blast();
	var_00.animname = "lobby_phone";
	var_01 = getent("anim_org_rb_lobby_phone_front","targetname");
	var_00 attach("electronics_pda_big","TAG_WEAPON_RIGHT",1);
	var_00.hasattachedprops = 1;
	var_00.attachedpropmodel = "electronics_pda_big";
	var_00.attachedproptag = "TAG_WEAPON_RIGHT";
	var_01 thread maps\_anim::anim_loop_solo(var_00,"phone_loop_1","stop_loop");
	common_scripts\utility::flag_wait("flag_roundabout_player_move_0");
	var_01 notify("stop_loop");
	var_00 setlookatentity(level.player);
	var_01 maps\_anim::anim_single_solo(var_00,"phone_react_1");
	var_01 thread maps\_anim::anim_loop_solo(var_00,"phone_react_loop_1","stop_loop");
	common_scripts\utility::flag_wait("roundabout_wave_1A_complete");
	var_01 notify("stop_loop");
	var_00 maps\_shg_design_tools::delete_auto();
}

//Function Number: 171
roundabout_lobby_couch_front()
{
	var_00 = getent("rb_lobby_couch_1_front","targetname") maps\_utility::spawn_ai(1);
	var_01 = getent("rb_lobby_couch_2_front","targetname") maps\_utility::spawn_ai(1);
	var_00 endon("death");
	var_01 endon("death");
	var_00.alertlevelint = 0;
	var_01.alertlevelint = 0;
	var_00 maps\lagos_utility::immune_sonic_blast();
	var_01 maps\lagos_utility::immune_sonic_blast();
	var_00.animname = "lobby_couch";
	var_01.animname = "lobby_couch";
	var_02 = getent("anim_org_rb_lobby_couch_front","targetname");
	var_03 = spawn("script_model",var_02.origin);
	var_03 setmodel("npc_exo_launch_pad");
	var_03.animname = "lobby_tablet";
	var_03 useanimtree(level.scr_animtree["lobby_tablet"]);
	var_02 thread maps\_anim::anim_loop_solo(var_00,"couch_loop_1","stop_loop");
	var_02 thread maps\_anim::anim_loop_solo(var_01,"couch_loop_2","stop_loop");
	var_02 thread maps\_anim::anim_loop_solo(var_03,"lobby_tablet_loop","stop_loop");
	common_scripts\utility::flag_wait("flag_roundabout_player_move_0");
	var_02 notify("stop_loop");
	var_01 setlookatentity(level.player);
	var_02 thread roundabout_lobby_reacts_into_walk(var_00,"couch_react_1_short");
	var_02 thread roundabout_lobby_reacts_into_walk(var_01,"couch_react_2_short");
	var_02 maps\_anim::anim_single_solo_run(var_03,"lobby_tablet_react_short");
}

//Function Number: 172
roundabout_lobby_elevator()
{
	var_00 = common_scripts\utility::get_noteworthy_ent("rb_lobby_elevator_door_left");
	var_01 = common_scripts\utility::get_noteworthy_ent("rb_lobby_elevator_door_right");
	var_02 = getent("rb_lobby_elevator_waiting_1","targetname") maps\_utility::spawn_ai(1);
	var_03 = getent("rb_lobby_elevator_waiting_2","targetname") maps\_utility::spawn_ai(1);
	var_04 = getent("rb_lobby_elevator_exiting_1","targetname") maps\_utility::spawn_ai(1);
	var_05 = getent("rb_lobby_elevator_exiting_2","targetname") maps\_utility::spawn_ai(1);
	var_02 endon("death");
	var_03 endon("death");
	var_04 endon("death");
	var_05 endon("death");
	var_02.alertlevelint = 0;
	var_03.alertlevelint = 0;
	var_04.alertlevelint = 0;
	var_05.alertlevelint = 0;
	var_02 maps\lagos_utility::immune_sonic_blast();
	var_03 maps\lagos_utility::immune_sonic_blast();
	var_04 maps\lagos_utility::immune_sonic_blast();
	var_05 maps\lagos_utility::immune_sonic_blast();
	var_02.animname = "lobby_elevator";
	var_03.animname = "lobby_elevator";
	var_04.animname = "lobby_elevator";
	var_05.animname = "lobby_elevator";
	var_06 = getent("anim_org_rb_lobby_elevator_waiting_1","targetname");
	var_07 = getent("anim_org_rb_lobby_elevator_waiting_2","targetname");
	var_08 = getent("anim_org_rb_lobby_elevator_exiting_1","targetname");
	var_09 = getent("anim_org_rb_lobby_elevator_exiting_2","targetname");
	var_02 thread roundabout_lobby_elevator_waiting_react_1(var_06);
	var_03 thread roundabout_lobby_elevator_waiting_react_2(var_07);
	var_04 thread roundabout_lobby_elevator_exiting_react_1(var_08);
	var_05 thread roundabout_lobby_elevator_exiting_react_2(var_09);
	common_scripts\utility::flag_wait("flag_roundabout_player_move_1");
	var_00 moveto((-52453,7644,321.5),1.5,0.25,0.25);
	var_01 moveto((-52273,7644,321.5),1.5,0.25,0.25);
	common_scripts\utility::flag_wait("roundabout_wave_1A_complete");
	var_06 notify("stop_loop");
	var_07 notify("stop_loop");
	var_08 notify("stop_loop");
	var_09 notify("stop_loop");
	var_02 maps\_shg_design_tools::delete_auto();
	var_03 maps\_shg_design_tools::delete_auto();
	var_04 maps\_shg_design_tools::delete_auto();
	var_05 maps\_shg_design_tools::delete_auto();
}

//Function Number: 173
roundabout_lobby_elevator_waiting_react_1(param_00)
{
	self endon("death");
	param_00 thread maps\_anim::anim_loop_solo(self,"waiting_react_1_pre","stop_loop");
	common_scripts\utility::flag_wait("flag_roundabout_player_move_0");
	param_00 notify("stop_loop");
	param_00 maps\_anim::anim_single_solo(self,"waiting_react_1");
	param_00 maps\_anim::anim_loop_solo(self,"waiting_react_loop_1","stop_loop");
}

//Function Number: 174
roundabout_lobby_elevator_waiting_react_2(param_00)
{
	self endon("death");
	param_00 thread maps\_anim::anim_loop_solo(self,"waiting_react_2_pre","stop_loop");
	common_scripts\utility::flag_wait("flag_roundabout_player_move_0");
	param_00 notify("stop_loop");
	self setlookatentity(level.player);
	param_00 maps\_anim::anim_single_solo(self,"waiting_react_2");
	param_00 maps\_anim::anim_loop_solo(self,"waiting_react_loop_2","stop_loop");
}

//Function Number: 175
roundabout_lobby_elevator_exiting_react_1(param_00)
{
	self endon("death");
	param_00 maps\_anim::anim_first_frame_solo(self,"exiting_react_1");
	common_scripts\utility::flag_wait("flag_roundabout_player_move_1");
	wait(1.5);
	self setlookatentity(level.player);
	param_00 maps\_anim::anim_single_solo(self,"exiting_react_1");
	param_00 maps\_anim::anim_loop_solo(self,"exiting_react_loop_1","stop_loop");
}

//Function Number: 176
roundabout_lobby_elevator_exiting_react_2(param_00)
{
	self endon("death");
	param_00 maps\_anim::anim_first_frame_solo(self,"exiting_react_2");
	common_scripts\utility::flag_wait("flag_roundabout_player_move_1");
	wait(1.5);
	param_00 maps\_anim::anim_single_solo(self,"exiting_react_2");
	param_00 maps\_anim::anim_loop_solo(self,"exiting_react_loop_2","stop_loop");
}

//Function Number: 177
roundabout_lobby_reacts_into_walk(param_00,param_01)
{
	maps\_anim::anim_single_solo_run(param_00,param_01);
	param_00 fleeingcivilian_roundaboutexit_lobby("civilian_goal_Roundabout_delete_front");
}

//Function Number: 178
roundabout_lobby_couch()
{
	var_00 = getent("rb_lobby_couch_1","targetname") maps\_utility::spawn_ai(1);
	var_01 = getent("rb_lobby_couch_2","targetname") maps\_utility::spawn_ai(1);
	var_00 endon("death");
	var_01 endon("death");
	var_00.alertlevelint = 0;
	var_01.alertlevelint = 0;
	var_00 maps\lagos_utility::immune_sonic_blast();
	var_01 maps\lagos_utility::immune_sonic_blast();
	var_00.animname = "lobby_couch";
	var_01.animname = "lobby_couch";
	var_02 = getent("anim_org_rb_lobby_couch","targetname");
	var_02 thread maps\_anim::anim_loop_solo(var_00,"couch_loop_1","stop_loop");
	var_02 thread maps\_anim::anim_loop_solo(var_01,"couch_loop_2","stop_loop");
	common_scripts\utility::flag_wait("flag_roundabout_player_move_1");
	var_02 notify("stop_loop");
	var_01 setlookatentity(level.player);
	var_02 thread roundabout_lobby_reacts_into_walk(var_00,"couch_react_1");
	var_02 thread roundabout_lobby_reacts_into_walk(var_01,"couch_react_2");
}

//Function Number: 179
roundabout_lobby_security_desk()
{
	var_00 = getent("rb_lobby_security_desk_1","targetname") maps\_utility::spawn_ai(1);
	var_01 = getent("rb_lobby_security_desk_2","targetname") maps\_utility::spawn_ai(1);
	var_00 endon("death");
	var_01 endon("death");
	var_00.alertlevelint = 0;
	var_01.alertlevelint = 0;
	var_00 maps\lagos_utility::immune_sonic_blast();
	var_01 maps\lagos_utility::immune_sonic_blast();
	var_00.animname = "lobby_security";
	var_01.animname = "lobby_security";
	level.civilian_roundabout_vo_2 = var_00;
	var_02 = getent("anim_org_rb_lobby_security_desk","targetname");
	var_03 = getent("anim_org_rb_lobby_security_desk_2","targetname");
	var_02 thread maps\_anim::anim_loop_solo(var_00,"security_loop_1","stop_loop");
	var_03 thread maps\_anim::anim_loop_solo(var_01,"security_loop_2","stop_loop");
	common_scripts\utility::flag_wait("flag_roundabout_player_move_2");
	var_03 notify("stop_loop");
	var_01 setlookatentity(level.player);
	var_03 maps\_anim::anim_single_solo(var_01,"security_react_2");
	var_03 maps\_anim::anim_single_solo(var_01,"security_react_loop_2");
	var_01 thread fleeingcivilian_roundaboutexit_lobby("civilian_goal_Roundabout_delete_front");
	common_scripts\utility::flag_wait("roundabout_wave_1A_complete");
	var_02 notify("stop_loop");
	var_00 maps\_shg_design_tools::delete_auto();
}

//Function Number: 180
roundabout_lobby_phone()
{
	var_00 = getent("rb_lobby_phone_1","targetname") maps\_utility::spawn_ai(1);
	var_00 endon("death");
	var_00.alertlevelint = 0;
	var_00 maps\lagos_utility::immune_sonic_blast();
	var_00.animname = "lobby_phone";
	var_01 = getent("anim_org_rb_lobby_phone_1","targetname");
	var_00 attach("electronics_pda_big","TAG_WEAPON_RIGHT",1);
	var_00.hasattachedprops = 1;
	var_00.attachedpropmodel = "electronics_pda_big";
	var_00.attachedproptag = "TAG_WEAPON_RIGHT";
	common_scripts\utility::flag_wait("flag_roundabout_move_1");
	var_00 setlookatentity(level.player);
	var_01 thread maps\_anim::anim_single_solo(var_00,"phone_react_1");
	var_01 thread maps\_anim::anim_loop_solo(var_00,"phone_react_loop_1","stop_loop");
	common_scripts\utility::flag_wait("roundabout_wave_1A_complete");
	var_01 notify("stop_loop");
	var_00 maps\_shg_design_tools::delete_auto();
}

//Function Number: 181
roundabout_lobby_phone2()
{
	var_00 = getent("rb_lobby_phone_2","targetname") maps\_utility::spawn_ai(1);
	var_00 endon("death");
	var_00.alertlevelint = 0;
	var_00 maps\lagos_utility::immune_sonic_blast();
	var_00.animname = "lobby_phone";
	var_01 = getent("anim_org_rb_lobby_phone_2","targetname");
	var_00 attach("electronics_pda_big","TAG_WEAPON_RIGHT",1);
	var_00.hasattachedprops = 1;
	var_00.attachedpropmodel = "electronics_pda_big";
	var_00.attachedproptag = "TAG_WEAPON_RIGHT";
	common_scripts\utility::flag_wait("flag_roundabout_move_1");
	var_01 maps\_anim::anim_single_solo(var_00,"phone_react_2");
	var_00 thread fleeingcivilian_roundaboutexit_lobby("civilian_goal_Roundabout_delete_front");
	if(isdefined(var_00.attachedpropmodel))
	{
		var_00 detach("electronics_pda_big","TAG_WEAPON_RIGHT");
		var_00.hasattachedprops = undefined;
	}

	common_scripts\utility::flag_wait("roundabout_wave_1A_complete");
	var_00 maps\_shg_design_tools::delete_auto();
}

//Function Number: 182
roundabout_lobby_walkingtalk()
{
	var_00 = getent("rb_lobby_walktalk_1","targetname") maps\_utility::spawn_ai(1);
	var_01 = getent("rb_lobby_walktalk_2","targetname") maps\_utility::spawn_ai(1);
	var_00 endon("death");
	var_01 endon("death");
	var_00.alertlevelint = 0;
	var_01.alertlevelint = 0;
	var_00 maps\lagos_utility::immune_sonic_blast();
	var_01 maps\lagos_utility::immune_sonic_blast();
	var_00.animname = "lobby_walktalk";
	var_01.animname = "lobby_walktalk";
	var_02 = getent("anim_org_rb_lobby_walkingtalk","targetname");
	common_scripts\utility::flag_wait("flag_roundabout_move_1");
	var_02 thread roundabout_lobby_reacts_into_walk(var_00,"walktalk_react_1");
	var_02 thread roundabout_lobby_reacts_into_walk(var_01,"walktalk_react_2");
}

//Function Number: 183
roundabout_street_drop_bikes()
{
	var_00 = getent("rb_street_bike_drop_1","targetname") maps\_utility::spawn_ai(1,1);
	var_01 = getent("rb_street_bike_drop_2","targetname") maps\_utility::spawn_ai(1,1);
	var_00 endon("death");
	var_01 endon("death");
	level.civilian_roundabout_vo_3 = var_00;
	var_00.alertlevelint = 0;
	var_01.alertlevelint = 0;
	var_00 maps\lagos_utility::immune_sonic_blast();
	var_01 maps\lagos_utility::immune_sonic_blast();
	var_00.animname = "street_drop_bike";
	var_01.animname = "street_drop_bike";
	var_02 = getent("anim_org_rb_street_bike_drop","targetname");
	var_03 = spawn("script_model",var_02.origin);
	var_03 setmodel("s1_bicycle");
	var_03.animname = "bike";
	var_03 useanimtree(level.scr_animtree["bike"]);
	common_scripts\utility::flag_wait("flag_roundabout_traffic_move");
	var_02 thread maps\_anim::anim_loop_solo(var_00,"drop_bike_loop_1","stop_loop");
	var_02 thread maps\_anim::anim_loop_solo(var_01,"drop_bike_loop_2","stop_loop");
	var_02 thread maps\_anim::anim_loop_solo(var_03,"drop_bike_loop","stop_loop");
	common_scripts\utility::flag_wait("roundabout_combat_starting_soon");
	var_02 notify("stop_loop");
	var_02 thread maps\_anim::anim_single_solo(var_03,"drop_bike_react");
	var_02 thread maps\_anim::anim_single_solo(var_00,"drop_bike_react_1",undefined,5.25);
	var_02 maps\_anim::anim_single_solo(var_01,"drop_bike_react_2",undefined,5.25);
	var_00 thread maps\lagos_utility::civilain_flee_to_goal();
	var_01 thread maps\lagos_utility::civilain_flee_to_goal();
}

//Function Number: 184
roundabout_street_car_hood_hit()
{
	var_00 = getent("rb_car_hood_exit","targetname") maps\_utility::spawn_ai(1);
	var_00.alertlevelint = 0;
	var_00 maps\lagos_utility::immune_sonic_blast();
	var_00.animname = "car_hood";
	var_01 = getent("anim_org_rb_burke_hood_stop","targetname");
	var_02 = maps\_vehicle::spawn_vehicle_from_targetname("rb_NW_4");
	var_02.animname = "car_hood";
	var_01 maps\_anim::anim_first_frame_solo(var_02,"car_drive_hood_stop");
	var_02.damage_functions = [];
	var_02 maps\_utility::add_damage_function(::roundabout_rpg_car_damage_function);
	common_scripts\utility::flag_wait("flag_roundabout_move_2");
	level.burke maps\_utility::disable_ai_color();
	common_scripts\utility::flag_set("roundabout_combat_starting_soon");
	var_01 maps\_anim::anim_reach_solo(level.burke,"burke_car_hood");
	common_scripts\utility::flag_set("roundabout_burke_hood_anim_begin");
	var_01 thread maps\_anim::anim_single_solo(var_02,"car_drive_hood_stop");
	if(!common_scripts\utility::flag("roundabout_combat_begin"))
	{
		var_01 thread maps\_anim::anim_single_solo(level.burke,"burke_car_hood");
		if(isdefined(var_00) && isalive(var_00))
		{
			thread roundabout_street_car_hood_hit_driver(var_01,var_00);
		}

		wait(7);
		common_scripts\utility::flag_set("roundabout_combat_begin");
	}

	level.burke maps\_utility::enable_ai_color();
}

//Function Number: 185
roundabout_rpg_car_damage_function(param_00,param_01,param_02,param_03,param_04,param_05,param_06)
{
	if(param_04 == "MOD_PROJECTILE")
	{
		maps\lagos_utility::rumble_roundabout_rpg_car_hit();
	}
}

//Function Number: 186
roundabout_street_car_hood_hit_driver(param_00,param_01)
{
	param_01 endon("death");
	if(isdefined(param_01) && isalive(param_01))
	{
		param_00 thread maps\_anim::anim_single_solo(param_01,"guy_exit_car");
	}

	if(isdefined(param_01) && isalive(param_01))
	{
		param_01 thread maps\lagos_utility::civilain_flee_to_goal();
	}
}

//Function Number: 187
fleeingcivilian_roundaboutexit_lobby(param_00)
{
	if(isdefined(self) && isalive(self))
	{
		self setlookatentity();
		self.ignoreall = 1;
		self.ignoreme = 1;
		self setgoalvolumeauto(getent(param_00,"targetname"));
		thread maps\lagos_utility::cleanup_on_goal();
	}
}

//Function Number: 188
spawnmalecivilians_roundabout()
{
	var_00 = getent("civilian_male_roundabout","targetname");
	var_01 = common_scripts\utility::getstructarray("node_roundabout_male_standing","targetname");
	var_02 = maps\lagos_utility::populate_ai_civilians(var_00,var_01,1,"flag_Roundabout_Civilians_Flee");
	common_scripts\utility::flag_wait("roundabout_wave_1A_complete");
	foreach(var_04 in var_02)
	{
		if(isdefined(var_04))
		{
			var_04 delete();
		}
	}

	common_scripts\utility::flag_wait("roundabout_wave_3_complete");
	var_00 = getent("civilian_male_roundabout_outro","targetname");
	var_01 = common_scripts\utility::getstructarray("node_roundabout_male_standing_outro","targetname");
	var_02 = maps\lagos_utility::populate_drone_civilians(var_00,var_01);
	common_scripts\utility::flag_wait("flag_delete_roundabout_vehicles");
	foreach(var_04 in var_02)
	{
		if(isdefined(var_04))
		{
			var_04 delete();
		}
	}
}

//Function Number: 189
spawnfemalecivilians_roundabout()
{
	var_00 = getent("civilian_female_roundabout","targetname");
	var_01 = common_scripts\utility::getstructarray("node_roundabout_female_standing","targetname");
	var_02 = maps\lagos_utility::populate_ai_civilians(var_00,var_01,1,"flag_Roundabout_Civilians_Flee");
	common_scripts\utility::flag_wait("roundabout_wave_1A_complete");
	foreach(var_04 in var_02)
	{
		if(isdefined(var_04))
		{
			var_04 delete();
		}
	}

	common_scripts\utility::flag_wait("roundabout_wave_3_complete");
	var_00 = getent("civilian_female_roundabout_outro","targetname");
	var_01 = common_scripts\utility::getstructarray("node_roundabout_female_standing_outro","targetname");
	var_02 = maps\lagos_utility::populate_drone_civilians(var_00,var_01);
	common_scripts\utility::flag_wait("flag_delete_roundabout_vehicles");
	foreach(var_04 in var_02)
	{
		if(isdefined(var_04))
		{
			var_04 delete();
		}
	}
}

//Function Number: 190
spawnwalkingcivilians_roundabout()
{
	var_00 = getent("badPlace_roundabout_center","targetname");
	badplace_cylinder("civilian_badPlace_roundabout_center",-1,var_00.origin,505,200,"neutral");
}

//Function Number: 191
roundabout_traffic()
{
	if(level.nextgen)
	{
		common_scripts\utility::flag_wait("flag_roundabout_spawn_vehicles");
	}
	else if(!istransientloaded("lagos_middle_tr"))
	{
		level waittill("tff_post_intro_to_middle");
	}

	if(level.currentgen)
	{
		roundabout_lobby_vehicles_cg();
		thread roundabout_center_vehicles_cg();
	}
	else
	{
		roundabout_lobby_vehicles();
		thread roundabout_center_vehicles();
	}

	if(level.nextgen)
	{
		thread maps\lagos_utility::start_vehicle_traffic_roundabout_straightways();
	}

	common_scripts\utility::flag_wait("flag_delete_roundabout_vehicles");
	var_00 = common_scripts\utility::array_combine(level.roundabout_center_vehicles,level.roundabout_lobby_vehicles);
	foreach(var_02 in var_00)
	{
		if(isdefined(var_02))
		{
			var_02 delete();
		}
	}

	maps\lagos_utility::delete_vehicle_traffic_roundabout_straightways();
}

//Function Number: 192
roundabout_lobby_vehicles()
{
	var_00 = maps\_vehicle::spawn_vehicle_from_targetname("roundabout_lobby_1");
	var_01 = maps\_vehicle::spawn_vehicle_from_targetname("roundabout_lobby_2");
	var_02 = maps\_vehicle::spawn_vehicle_from_targetname("roundabout_lobby_3");
	var_03 = maps\_vehicle::spawn_vehicle_from_targetname("roundabout_lobby_4");
	var_04 = maps\_vehicle::spawn_vehicle_from_targetname("roundabout_lobby_5");
	var_05 = maps\_vehicle::spawn_vehicle_from_targetname("roundabout_lobby_6");
	var_06 = maps\_vehicle::spawn_vehicle_from_targetname("roundabout_lobby_7");
	var_07 = maps\_vehicle::spawn_vehicle_from_targetname("roundabout_lobby_8");
	var_08 = maps\_vehicle::spawn_vehicle_from_targetname("roundabout_lobby_9");
	var_09 = maps\_vehicle::spawn_vehicle_from_targetname("roundabout_lobby_10");
	var_0A = ["roundabout_lobby_1","roundabout_lobby_2","roundabout_lobby_3","roundabout_lobby_4","roundabout_lobby_5","roundabout_lobby_6","roundabout_lobby_7","roundabout_lobby_8","roundabout_lobby_9","roundabout_lobby_10"];
	level.roundabout_lobby_vehicles = [var_00,var_01,var_02,var_03,var_04,var_05,var_06,var_07,var_08,var_09];
}

//Function Number: 193
roundabout_center_vehicles()
{
	roundabout_setup_center_vehicles();
	roundabout_setup_center_vehicle_nodes();
	common_scripts\utility::flag_wait("flag_roundabout_traffic_move");
	for(var_00 = 0;var_00 < level.roundabout_center_vehicles.size;var_00++)
	{
		level.roundabout_center_vehicles[var_00] thread maps\_vehicle::vehicle_paths(level.roundabout_center_vehicle_nodes[var_00]);
		level.roundabout_center_vehicles[var_00] startpath(level.roundabout_center_vehicle_nodes[var_00]);
	}
}

//Function Number: 194
roundabout_setup_center_vehicles()
{
	var_00 = maps\_vehicle::spawn_vehicle_from_targetname("rb_W_1");
	var_01 = maps\_vehicle::spawn_vehicle_from_targetname("rb_W_2");
	var_02 = maps\_vehicle::spawn_vehicle_from_targetname("rb_W_3");
	var_03 = maps\_vehicle::spawn_vehicle_from_targetname("rb_W_4");
	var_04 = maps\_vehicle::spawn_vehicle_from_targetname("rb_W_5");
	var_05 = maps\_vehicle::spawn_vehicle_from_targetname("rb_NW_1");
	var_06 = maps\_vehicle::spawn_vehicle_from_targetname("rb_NW_2");
	var_07 = maps\_vehicle::spawn_vehicle_from_targetname("rb_NW_3");
	var_08 = maps\_vehicle::spawn_vehicle_from_targetname("rb_N_1");
	var_09 = maps\_vehicle::spawn_vehicle_from_targetname("rb_N_2");
	var_0A = maps\_vehicle::spawn_vehicle_from_targetname("rb_N_3");
	var_0B = maps\_vehicle::spawn_vehicle_from_targetname("rb_N_4");
	var_0C = maps\_vehicle::spawn_vehicle_from_targetname("rb_N_5");
	var_0D = maps\_vehicle::spawn_vehicle_from_targetname("rb_NE_1");
	var_0E = maps\_vehicle::spawn_vehicle_from_targetname("rb_NE_2");
	var_0F = maps\_vehicle::spawn_vehicle_from_targetname("rb_NE_3");
	var_10 = maps\_vehicle::spawn_vehicle_from_targetname("rb_NE_4");
	var_11 = maps\_vehicle::spawn_vehicle_from_targetname("rb_E_1");
	var_12 = maps\_vehicle::spawn_vehicle_from_targetname("rb_E_2");
	var_13 = maps\_vehicle::spawn_vehicle_from_targetname("rb_E_3");
	var_14 = maps\_vehicle::spawn_vehicle_from_targetname("rb_E_4");
	var_15 = maps\_vehicle::spawn_vehicle_from_targetname("rb_E_5");
	var_16 = maps\_vehicle::spawn_vehicle_from_targetname("rb_SE_1");
	var_17 = maps\_vehicle::spawn_vehicle_from_targetname("rb_SE_2");
	var_18 = maps\_vehicle::spawn_vehicle_from_targetname("rb_SE_3");
	var_19 = maps\_vehicle::spawn_vehicle_from_targetname("rb_SE_4");
	var_1A = maps\_vehicle::spawn_vehicle_from_targetname("rb_S_1");
	var_1B = maps\_vehicle::spawn_vehicle_from_targetname("rb_S_2");
	var_1C = maps\_vehicle::spawn_vehicle_from_targetname("rb_S_3");
	var_1D = maps\_vehicle::spawn_vehicle_from_targetname("rb_S_4");
	var_1E = maps\_vehicle::spawn_vehicle_from_targetname("rb_S_5");
	var_1F = maps\_vehicle::spawn_vehicle_from_targetname("rb_SW_1");
	var_20 = maps\_vehicle::spawn_vehicle_from_targetname("rb_SW_2");
	var_21 = maps\_vehicle::spawn_vehicle_from_targetname("rb_SW_3");
	var_22 = maps\_vehicle::spawn_vehicle_from_targetname("rb_SW_4");
	level.roundabout_center_vehicles = [var_00,var_01,var_02,var_03,var_04,var_05,var_06,var_07,var_08,var_09,var_0A,var_0B,var_0C,var_0D,var_0E,var_0F,var_10,var_11,var_12,var_13,var_14,var_15,var_16,var_17,var_18,var_19,var_1A,var_1B,var_1C,var_1D,var_1E,var_1F,var_20,var_21,var_22];
	var_23 = ["rb_W_1","rb_W_2","rb_W_3","rb_W_4","rb_W_5","rb_NW_1","rb_NW_2","rb_NW_3","rb_N_1","rb_N_2","rb_N_3","rb_N_4","rb_N_5","rb_NE_1","rb_NE_2","rb_NE_3","rb_NE_4"];
	foreach(var_25 in var_23)
	{
		maps\lagos_utility::civilian_get_out_of_car_setup(var_25,"civ_roundabout_driver_ai","drivers_get_out");
		wait(0.05);
	}

	thread roundabout_swap_vehicle_for_model(var_1B,"rb_S_2_swap");
	thread roundabout_swap_vehicle_for_model(var_0E,"rb_NE_2_swap");
}

//Function Number: 195
roundabout_swap_vehicle_for_model(param_00,param_01)
{
	var_02 = getentarray(param_01,"targetname");
	foreach(var_04 in var_02)
	{
		if(issubstr(var_04.classname,"script_model") || issubstr(var_04.classname,"script_brushmodel"))
		{
			var_04 hide();
			var_04 setcontents(0);
		}
	}

	common_scripts\utility::flag_wait("roundabout_combat_begin");
	foreach(var_04 in var_02)
	{
		if(issubstr(var_04.classname,"script_model") || issubstr(var_04.classname,"script_brushmodel"))
		{
			var_04 show();
			var_04 setcontents(1);
		}
	}

	level.roundabout_center_vehicles = common_scripts\utility::array_remove(level.roundabout_center_vehicles,param_00);
	param_00 delete();
	common_scripts\utility::flag_wait("flag_delete_roundabout_vehicles");
	foreach(var_04 in var_02)
	{
		var_04 delete();
	}
}

//Function Number: 196
roundabout_setup_center_vehicle_nodes()
{
	var_00 = getvehiclenode("node_rb_W_1","targetname");
	var_01 = getvehiclenode("node_rb_W_2","targetname");
	var_02 = getvehiclenode("node_rb_W_3","targetname");
	var_03 = getvehiclenode("node_rb_W_4","targetname");
	var_04 = getvehiclenode("node_rb_W_5","targetname");
	var_05 = getvehiclenode("node_rb_NW_1","targetname");
	var_06 = getvehiclenode("node_rb_NW_2","targetname");
	var_07 = getvehiclenode("node_rb_NW_3","targetname");
	var_08 = getvehiclenode("node_rb_N_1","targetname");
	var_09 = getvehiclenode("node_rb_N_2","targetname");
	var_0A = getvehiclenode("node_rb_N_3","targetname");
	var_0B = getvehiclenode("node_rb_N_4","targetname");
	var_0C = getvehiclenode("node_rb_N_5","targetname");
	var_0D = getvehiclenode("node_rb_NE_1","targetname");
	var_0E = getvehiclenode("node_rb_NE_2","targetname");
	var_0F = getvehiclenode("node_rb_NE_3","targetname");
	var_10 = getvehiclenode("node_rb_NE_4","targetname");
	var_11 = getvehiclenode("node_rb_E_1","targetname");
	var_12 = getvehiclenode("node_rb_E_2","targetname");
	var_13 = getvehiclenode("node_rb_E_3","targetname");
	var_14 = getvehiclenode("node_rb_E_4","targetname");
	var_15 = getvehiclenode("node_rb_E_5","targetname");
	var_16 = getvehiclenode("node_rb_SE_1","targetname");
	var_17 = getvehiclenode("node_rb_SE_2","targetname");
	var_18 = getvehiclenode("node_rb_SE_3","targetname");
	var_19 = getvehiclenode("node_rb_SE_4","targetname");
	var_1A = getvehiclenode("node_rb_S_1","targetname");
	var_1B = getvehiclenode("node_rb_S_2","targetname");
	var_1C = getvehiclenode("node_rb_S_3","targetname");
	var_1D = getvehiclenode("node_rb_S_4","targetname");
	var_1E = getvehiclenode("node_rb_S_5","targetname");
	var_1F = getvehiclenode("node_rb_SW_1","targetname");
	var_20 = getvehiclenode("node_rb_SW_2","targetname");
	var_21 = getvehiclenode("node_rb_SW_3","targetname");
	var_22 = getvehiclenode("node_rb_SW_4","targetname");
	level.roundabout_center_vehicle_nodes = [var_00,var_01,var_02,var_03,var_04,var_05,var_06,var_07,var_08,var_09,var_0A,var_0B,var_0C,var_0D,var_0E,var_0F,var_10,var_11,var_12,var_13,var_14,var_15,var_16,var_17,var_18,var_19,var_1A,var_1B,var_1C,var_1D,var_1E,var_1F,var_20,var_21,var_22];
}

//Function Number: 197
roundabout_lobby_vehicles_cg()
{
	var_00 = maps\_vehicle::spawn_vehicle_from_targetname("roundabout_lobby_5");
	var_01 = maps\_vehicle::spawn_vehicle_from_targetname("roundabout_lobby_6");
	var_02 = maps\_vehicle::spawn_vehicle_from_targetname("roundabout_lobby_9");
	var_03 = ["roundabout_lobby_5","roundabout_lobby_6","roundabout_lobby_9"];
	level.roundabout_lobby_vehicles = [var_00,var_01,var_02];
}

//Function Number: 198
roundabout_center_vehicles_cg()
{
	roundabout_setup_center_vehicles_cg();
	roundabout_setup_center_vehicle_nodes_cg();
	common_scripts\utility::flag_wait("flag_roundabout_traffic_move");
	for(var_00 = 0;var_00 < level.roundabout_center_vehicles_moving.size;var_00++)
	{
		level.roundabout_center_vehicles_moving[var_00] thread maps\_vehicle::vehicle_paths(level.roundabout_center_vehicle_nodes_cg[var_00]);
		level.roundabout_center_vehicles_moving[var_00] startpath(level.roundabout_center_vehicle_nodes_cg[var_00]);
		wait(randomfloatrange(0.1,0.25));
	}
}

//Function Number: 199
roundabout_setup_center_vehicles_cg()
{
	var_00 = maps\_vehicle::spawn_vehicle_from_targetname("rb_W_1");
	var_01 = maps\_vehicle::spawn_vehicle_from_targetname("rb_W_2");
	var_02 = maps\_vehicle::spawn_vehicle_from_targetname("rb_W_3");
	var_03 = maps\_vehicle::spawn_vehicle_from_targetname("rb_W_4");
	var_04 = maps\_vehicle::spawn_vehicle_from_targetname("rb_W_5");
	var_05 = maps\_vehicle::spawn_vehicle_from_targetname("rb_NW_3");
	var_06 = maps\_vehicle::spawn_vehicle_from_targetname("rb_N_4");
	var_07 = maps\_vehicle::spawn_vehicle_from_targetname("rb_NE_1");
	var_08 = maps\_vehicle::spawn_vehicle_from_targetname("rb_E_1");
	var_09 = maps\_vehicle::spawn_vehicle_from_targetname("rb_E_3");
	var_0A = maps\_vehicle::spawn_vehicle_from_targetname("rb_SE_2");
	var_0B = maps\_vehicle::spawn_vehicle_from_targetname("rb_SE_3");
	var_0C = maps\_vehicle::spawn_vehicle_from_targetname("rb_SW_3");
	level.roundabout_center_vehicles = [var_00,var_01,var_02,var_03,var_04,var_05,var_06,var_07,var_08,var_09,var_0A,var_0B,var_0C];
	level.roundabout_center_vehicles_moving = [var_02,var_05,var_01,var_03];
	var_0D = ["rb_W_1","rb_W_2","rb_W_4","rb_W_5","rb_NW_3","rb_N_4","rb_NE_1"];
	level.roundabout_center_vehicles_tank_explo = [var_0A,var_00,var_04];
	foreach(var_0F in var_0D)
	{
		maps\lagos_utility::civilian_get_out_of_car_setup(var_0F,"civ_roundabout_driver_ai","drivers_get_out");
		wait(0.05);
	}
}

//Function Number: 200
roundabout_setup_center_vehicle_nodes_cg()
{
	var_00 = getvehiclenode("node_rb_W_3","targetname");
	var_01 = getvehiclenode("node_rb_NW_3","targetname");
	var_02 = getvehiclenode("node_rb_W_2","targetname");
	var_03 = getvehiclenode("node_rb_W_4","targetname");
	level.roundabout_center_vehicle_nodes_cg = [var_00,var_01,var_02,var_03];
}

//Function Number: 201
alley1_combat()
{
	common_scripts\utility::flag_wait("vo_alley1");
	soundscripts\_snd::snd_message("crossing_into_alley");
	thread maps\lagos_vo::alley_a_dialogue();
	common_scripts\utility::flag_wait("alley1_spawn");
	soundscripts\_snd::snd_message("roundabout_exited");
	level.alley1_kva = [];
	thread alley1_stage1_combat();
	thread alley1_stage2_combat();
	thread alley1_stage3_combat();
	if(common_scripts\utility::flag("alley1_playerstart"))
	{
		var_00 = getnode("alley1_burke_start","targetname");
		var_01 = getnode("alley1_joker_start","targetname");
		var_02 = getnode("alley1_ajani_start","targetname");
		level.burke maps\_utility::teleport_ai(var_00);
		level.joker maps\_utility::teleport_ai(var_01);
		level.ajani maps\_utility::teleport_ai(var_02);
	}

	level notify("alley1_stage1_go");
}

//Function Number: 202
alley1_veh_destro()
{
	var_00 = getent("alley1_veh_destro","targetname");
	var_01 = common_scripts\utility::getstruct("alley1_veh_destro_impulse_org","targetname");
	common_scripts\utility::flag_wait("alley1_veh_destro_hit");
	var_00 maps\_vehicle::vehicle_set_health(1);
	radiusdamage(var_01.origin,350,10000,9000);
	physicsexplosionsphere(var_01.origin,350,300,3);
}

//Function Number: 203
alley1_stage1_combat()
{
	level waittill("alley1_stage1_go");
	var_00 = 3;
	maps\_utility::activate_trigger("alley1_stage1_ally_goto","targetname",level.player);
	var_01 = [];
	var_02 = maps\_utility::array_spawn_targetname("alley1_stage1_enemy");
	foreach(var_04 in var_02)
	{
		var_04 setengagementmaxdist(256,512);
		level.alley1_kva = common_scripts\utility::array_add(level.alley1_kva,var_04);
		var_01 = common_scripts\utility::array_add(var_01,var_04);
		var_04.allowdeath = 1;
		var_04 maps\_utility::disable_long_death();
		var_04 maps\lagos_utility::equip_microwave_grenade();
		if(isdefined(var_04.script_parameters))
		{
			if(var_04.script_parameters == "stage3_ally")
			{
				var_04 maps\lagos_utility::assign_goal_vol("alley1_stage3_ally");
				var_04 thread maps\lagos_utility::ignore_until_goal_reached();
			}
		}
	}

	var_06 = [];
	var_07 = getentarray("alley1_stage1_refill","targetname");
	foreach(var_09 in var_07)
	{
		var_04 = var_09 maps\_utility::spawn_ai(1);
		wait 0.05;
		level.alley1_kva = common_scripts\utility::array_add(level.alley1_kva,var_04);
		var_06 = common_scripts\utility::array_add(var_06,var_04);
		var_04.allowdeath = 1;
		var_04 maps\_utility::disable_long_death();
		var_04 maps\lagos_utility::equip_microwave_grenade();
		var_04 thread maps\lagos_utility::ignore_until_goal_reached();
		var_04 thread alley1_stage1_rooftop_movedown();
	}

	wait 0.05;
	maps\_utility::activate_trigger("alley1_stage1_ally_trigger","targetname",level.player);
	var_0B = 0;
	while(!var_0B)
	{
		level.alley1_kva = maps\_utility::array_removedead_or_dying(level.alley1_kva);
		var_01 = maps\_utility::array_removedead_or_dying(var_01);
		if(level.alley1_kva.size < var_00)
		{
			foreach(var_04 in level.alley1_kva)
			{
				var_04 maps\_utility::player_seek_disable();
				wait 0.05;
				var_04 maps\lagos_utility::assign_goal_vol("alley1_stage2_vol2");
			}

			var_0B = 1;
			level notify("alley1_stage2_go");
		}

		wait 0.05;
	}
}

//Function Number: 204
alley1_stage1_rooftop_movedown()
{
	wait(randomintrange(5,8));
	maps\lagos_utility::assign_goal_vol("alley1_stage1_vol1");
}

//Function Number: 205
alley1_force_deaths()
{
	common_scripts\utility::flag_wait("alley1_oncoming_start");
	foreach(var_01 in self)
	{
		if(isdefined(var_01) && isalive(var_01))
		{
			var_01 kill();
		}
	}
}

//Function Number: 206
alley1_stage2_combat_flag()
{
	common_scripts\utility::flag_wait("flag_alley1_combat_stage_2");
	level notify("alley1_stage2_go");
}

//Function Number: 207
alley1_stage2_combat()
{
	thread alley1_stage2_combat_flag();
	level waittill("alley1_stage2_go");
	level endon("alley1_stage3_go");
	setthreatbias("friendly_squad","player_haters",-10000);
	setthreatbias("player_haters","friendly_squad",-10000);
	setthreatbias("player_haters","player",10000);
	level.player setthreatbiasgroup("player");
	var_00 = 3;
	var_01 = 1;
	var_02 = [];
	var_03 = getent("alley1_stage2_balcony_enemy","targetname");
	var_04 = 1;
	var_05 = [];
	var_06 = getent("alley1_stage2_ground_enemy","targetname");
	for(var_07 = 0;var_07 < var_01;var_07++)
	{
		var_08 = var_03 maps\_utility::spawn_ai(1);
		var_03.count = 1;
		wait 0.05;
		var_02 = common_scripts\utility::array_add(var_02,var_08);
		level.alley1_kva = common_scripts\utility::array_add(level.alley1_kva,var_08);
		var_08.allowdeath = 1;
		var_08 maps\_utility::disable_long_death();
		var_08 maps\lagos_utility::equip_microwave_grenade();
		var_08 setengagementmaxdist(256,512);
		var_08 maps\lagos_utility::assign_goal_vol("alley1_stage2_vol1");
	}

	var_09 = getent("alley1_stage2_balcony_enemy_A","targetname") maps\_utility::spawn_ai(1);
	level.alley1_kva = common_scripts\utility::array_add(level.alley1_kva,var_09);
	var_09 setengagementmaxdist(256,512);
	var_09 maps\lagos_utility::assign_goal_vol("alley1_stage2_vol1_A");
	var_02 thread alley1_force_deaths();
	for(var_07 = 0;var_07 < var_04;var_07++)
	{
		var_08 = var_06 maps\_utility::spawn_ai(1);
		var_06.count = 1;
		wait 0.05;
		var_05 = common_scripts\utility::array_add(var_05,var_08);
		level.alley1_kva = common_scripts\utility::array_add(level.alley1_kva,var_08);
		var_08.allowdeath = 1;
		var_08 maps\_utility::disable_long_death();
		var_08 maps\lagos_utility::equip_microwave_grenade();
		var_08 setengagementmaxdist(256,512);
		var_08 maps\lagos_utility::assign_goal_vol("alley1_stage2_vol2");
	}

	maps\_utility::activate_trigger("alley1_stage2_ally_trigger","targetname",level.player);
	maps\_utility::array_spawn_targetname("alley1_stage3_refill",1);
	var_0A = 0;
	while(!var_0A)
	{
		level.alley1_kva = maps\_utility::array_removedead_or_dying(level.alley1_kva);
		if(level.alley1_kva.size < var_00)
		{
			foreach(var_08 in level.alley1_kva)
			{
				if(isdefined(var_08))
				{
					var_08 thread maps\_utility::player_seek_enable();
				}
			}

			var_0A = 1;
			level notify("alley1_stage3_go");
		}

		wait 0.05;
	}
}

//Function Number: 208
alley1_stage3_combat_flag()
{
	common_scripts\utility::flag_wait("flag_alley1_combat_stage_3");
	level notify("alley1_stage3_go");
}

//Function Number: 209
alley1_stage3_combat()
{
	thread alley1_stage3_combat_flag();
	level waittill("alley1_stage3_go");
	level endon("alley1_stage3_end");
	var_00 = 3;
	thread alley1_oncoming_goto();
	var_01 = maps\_vehicle::spawn_vehicle_from_targetname_and_drive("alley1_stage3_vehicle");
	var_01 thread maps\lagos_utility::vehicle_unload_how_at_end();
	if(level.currentgen)
	{
		var_01 thread alley_veh_god_on();
		var_01 thread tff_cleanup_vehicle("alley");
	}

	wait 0.05;
	var_02 = [];
	var_02 = var_01.riders;
	foreach(var_04 in var_02)
	{
		var_04 maps\lagos_utility::assign_goal_vol("alley1_stage3_vol1");
		level.alley1_kva = common_scripts\utility::array_add(level.alley1_kva,var_04);
		var_04.allowdeath = 1;
		var_04 maps\_utility::disable_long_death();
		var_04 maps\lagos_utility::equip_microwave_grenade();
		var_04 setengagementmaxdist(256,512);
	}

	wait(1);
	maps\_utility::activate_trigger("alley1_stage3_ally_trigger","targetname",level.player);
	for(;;)
	{
		level.alley1_kva = maps\_utility::array_removedead_or_dying(level.alley1_kva);
		if(level.alley1_kva.size < var_00)
		{
			foreach(var_04 in level.alley1_kva)
			{
				if(isdefined(var_04))
				{
					var_04 thread maps\_utility::player_seek_enable();
					var_04 maps\_utility::delaythread(5,::maps\lagos_utility::bloody_death,randomintrange(1,3));
				}
			}
		}

		if(level.alley1_kva.size == 0)
		{
			level notify("alley_oncoming_ally_goto");
			common_scripts\utility::flag_set("flag_alley1_clear");
			common_scripts\utility::flag_set("obj_pos_pursue_hostage_truck_oncoming1_wait");
			wait 0.05;
			level notify("alley1_stage3_end");
		}

		wait 0.05;
	}
}

//Function Number: 210
alley_veh_god_on()
{
	maps\_vehicle::godon();
	self waittill("reached_end_node");
	wait(2);
	maps\_vehicle::godoff();
}

//Function Number: 211
alley1_oncoming_goto()
{
	level waittill("alley_oncoming_ally_goto");
	maps\_utility::activate_trigger("alley_oncoming_trigger","targetname",level.player);
}

//Function Number: 212
alley1_oncoming()
{
	var_00 = getent("alley_oncoming_trigger_start","targetname");
	var_00 makeunusable();
	var_01 = getnode("oncoming_anim_joker_goto","targetname");
	var_02 = getnode("oncoming_anim_ajani_goto","targetname");
	var_03 = getnode("alley2_joker_start","targetname");
	var_04 = getnode("alley2_ajani_start","targetname");
	if(level.currentgen)
	{
		if(level.start_point != "alley_1" && level.start_point != "oncoming_alley" && level.start_point != "alley_2")
		{
			level waittill("tff_post_load_alley");
		}
	}

	var_05 = getent("anim_org_alley_1_gate_open","targetname");
	var_06 = getent("oncoming_gate","targetname");
	var_06.animname = "oncoming_gate";
	var_06 maps\_utility::assign_animtree();
	var_05 thread maps\_anim::anim_first_frame_solo(var_06,"oncoming_gate_open");
	var_07 = getent("oncoming_gate_blocker","targetname");
	var_07 linkto(var_06,"gateSlide");
	var_07 disconnectpaths();
	var_08 = [level.joker,var_06];
	level waittill("alley_oncoming_ally_goto");
	thread maps\lagos_vo::alley_1_complete_dialogue();
	common_scripts\utility::flag_wait("alley1_oncoming_start");
	if(common_scripts\utility::flag("oncoming_downhill_playerstart"))
	{
		var_09 = getnode("alley_oncoming_burke","targetname");
		var_0A = getnode("alley_oncoming_joker","targetname");
		var_0B = getnode("alley_oncoming_ajani","targetname");
		level.burke maps\_utility::teleport_ai(var_09);
		level.joker maps\_utility::teleport_ai(var_0A);
		level.ajani maps\_utility::teleport_ai(var_0B);
	}

	level.burke maps\_utility::disable_pain();
	level.joker maps\_utility::disable_pain();
	level.ajani maps\_utility::disable_pain();
	level.burke thread alley1_oncoming_grenade_awareness();
	level.joker thread alley1_oncoming_grenade_awareness();
	level.ajani thread alley1_oncoming_grenade_awareness();
	thread alley1_oncoming_burke_alley_enter();
	var_05 maps\_anim::anim_reach_solo(level.joker,"oncoming_gate_open");
	soundscripts\_snd::snd_message("alley_1_big_metal_gate");
	var_05 thread maps\_anim::anim_single_solo(var_06,"oncoming_gate_open");
	var_05 thread maps\_anim::anim_single_run_solo(level.joker,"oncoming_gate_open");
	common_scripts\utility::flag_set("alley_oncoming_gate_lighting");
	wait(4);
	level notify("oncoming_gate_open");
	var_07 connectpaths();
	common_scripts\utility::flag_set("obj_pos_pursue_hostage_truck_oncoming1_set");
	thread alley1_oncoming_truck_seq();
	thread maps\lagos_vo::alley_oncoming_dialogue();
	level notify("oncoming_go");
	level.player maps\_utility::blend_movespeedscale_percent(85,1);
	level.joker thread maps\lagos_utility::ally_move_dynamic_speed();
	level.ajani thread maps\lagos_utility::ally_move_dynamic_speed();
	level.joker maps\_utility::delaythread(1,::maps\_hms_ai_utility::gototogoal,var_01,"sprint");
	level.ajani maps\_utility::delaythread(3,::maps\_hms_ai_utility::gototogoal,var_02,"sprint");
	common_scripts\utility::flag_wait("reset_player_speed");
	level.player maps\_utility::blend_movespeedscale_percent(100,1);
	level waittill("player_safe");
	level.joker thread maps\_hms_ai_utility::gototogoal(var_03,"sprint");
	level.ajani thread maps\_hms_ai_utility::gototogoal(var_04,"sprint");
}

//Function Number: 213
alley1_oncoming_grenade_awareness()
{
	self.grenadeawarenessold = self.grenadeawareness;
	self.grenadeawareness = 0;
	common_scripts\utility::flag_wait("alley2_spawn");
	self.grenadeawareness = self.grenadeawarenessold;
	self.grenadeawarenessold = undefined;
}

//Function Number: 214
alley1_oncoming_burke_alley_enter()
{
	var_00 = getnode("oncoming_anim_burke_goto","targetname");
	var_01 = getnode("alley2_burke_start","targetname");
	var_02 = common_scripts\utility::getstruct("oncoming_burke_idle_goto","targetname");
	var_03 = getent("anim_org_oncoming_alley","targetname");
	level.burke maps\lagos_utility::assign_goal_node("alley_oncoming_burke",32);
	level waittill("oncoming_gate_open");
	wait(0.5);
	level.burke thread maps\_hms_ai_utility::gototogoal(var_00,"sprint");
	level waittill("oncoming_truck_enter");
	maps\_utility::battlechatter_off("axis");
	maps\_utility::battlechatter_off("allies");
	var_03 maps\_anim::anim_reach_solo(level.burke,"oncoming_alley_seq_enter");
	level.burke thread maps\_hms_ai_utility::gototogoal(var_01,"sprint");
	level notify("oncoming_truck_go");
	common_scripts\utility::flag_set("obj_pos_pursue_hostage_truck_oncoming2");
	var_03 maps\_anim::anim_single_solo_run(level.burke,"oncoming_alley_seq_enter");
}

//Function Number: 215
alley1_oncoming_truck_seq()
{
	var_00 = getent("anim_org_oncoming_alley","targetname");
	var_01 = maps\_vehicle::spawn_vehicle_from_targetname("vehicle_downhill_stairs");
	var_01.animname = "oncoming_truck";
	var_01 useanimtree(#animtree);
	var_02 = getent("oncoming_truck_sweeper","targetname");
	var_02 maps\lagos_utility::fake_linkto(var_01);
	var_01.vehicle_stays_alive = 1;
	if(level.currentgen)
	{
		var_01 thread tff_cleanup_vehicle("alley");
	}

	thread alley1_oncoming_truck_anims(var_01,var_00);
	common_scripts\utility::flag_wait("oncoming_alley_player_pos");
	level.player thread alley1_oncoming_truck_sweeper_monitor(var_02);
	level notify("oncoming_truck_enter");
	level notify("alley1_oncoming_fx");
	var_01 soundscripts\_snd::snd_message("oncoming_alley_truck");
	common_scripts\utility::flag_set("alley_oncoming_truck_lighting");
}

//Function Number: 216
alley1_oncoming_truck_anims(param_00,param_01)
{
	level waittill("oncoming_truck_go");
	var_02 = maps\_utility::spawn_targetname("vehicle_downhill_stairs_turret_guy",1);
	var_02 maps\_utility::gun_remove();
	var_02.allowdeath = 0;
	var_02 maps\_utility::disable_pain();
	var_03 = maps\_utility::spawn_anim_model("oncoming_truck_prop");
	var_04 = maps\_utility::spawn_anim_model("oncoming_truck_turret");
	var_04 thread alley1_oncoming_turret_think(var_02);
	thread maps\_shg_design_tools::notify_on_death(var_02,"stop_turret_fire");
	var_02.animname = "guy1";
	var_02.ignoreme = 1;
	var_05 = [var_02,var_04];
	param_00 hide();
	var_06 = [param_00,var_03];
	param_01 thread maps\_anim::anim_single(var_05,"oncoming_alley_seq_enter");
	param_01 maps\_anim::anim_single(var_06,"oncoming_alley_seq_enter");
	common_scripts\utility::flag_set("aud_oncoming_truck_check");
	if(level.currentgen)
	{
		var_03 thread tff_cleanup_vehicle("middle");
		var_04 thread tff_cleanup_vehicle("middle");
		var_02 thread tff_cleanup_vehicle("middle");
	}

	if(common_scripts\utility::flag("flag_oncoming_player_junction"))
	{
		var_04 thread delay_oncoming_bypass_kill(1,var_02,"flag_oncoming_player_bypass_straight_kill");
		var_04 thread delay_oncoming_bypass_kill(3,var_02,"flag_oncoming_player_bypass_turn_kill");
		var_04 thread delay_oncoming_bypass_kill(5,var_02,"flag_oncoming_player_standstill_turn_kill");
		var_04 thread delay_oncoming_bypass_kill(6,var_02,"flag_oncoming_player_wait_alley2_kill");
		param_01 thread maps\_anim::anim_single(var_06,"oncoming_alley_seq_turn");
		level notify("player_safe");
		wait(getanimlength(param_00 maps\_utility::getanim("oncoming_alley_seq_turn")) - 0.05);
		if(isalive(var_02))
		{
			maps\_anim::anim_set_rate_single(var_02,"oncoming_alley_seq_enter",0);
			return;
		}

		return;
	}

	foreach(var_08 in var_05)
	{
		var_08 maps\_utility::anim_stopanimscripted();
	}

	param_01 thread maps\_anim::anim_single(var_05,"oncoming_alley_seq_straight");
	param_01 thread maps\_anim::anim_single(var_06,"oncoming_alley_seq_straight");
	var_04 oncoming_bypass_kill(var_02,"flag_oncoming_player_bypass_straight_kill");
}

//Function Number: 217
delay_oncoming_bypass_kill(param_00,param_01,param_02)
{
	wait(param_00);
	oncoming_bypass_kill(param_01,param_02);
}

//Function Number: 218
oncoming_bypass_kill(param_00,param_01)
{
	while(!common_scripts\utility::flag("progress_in_alley2"))
	{
		if(common_scripts\utility::flag(param_01))
		{
			level.player dodamage(level.player.maxhealth / 50,self gettagorigin("tag_flash"),param_00,param_00,"MOD_RIFLE_BULLET");
			wait(0.2);
			level.player dodamage(level.player.maxhealth,self gettagorigin("tag_flash"),param_00,param_00,"MOD_RIFLE_BULLET");
			wait(0.1);
			if(isalive(level.player))
			{
				level.player kill();
			}
		}

		wait 0.05;
	}
}

//Function Number: 219
alley1_oncoming_turret_think(param_00)
{
	param_00 endon("death");
	thread alley1_oncoming_turret_fire();
	maps\lagos_utility::notify_on_flag("stop_turret_fire","progress_in_alley2");
	self waittillmatch("start_turret_fire","single anim");
	thread alley1_oncoming_turret_fire();
	self waittillmatch("stop_turret_fire","single anim");
	self notify("stop_turret_fire");
	self waittillmatch("start_turret_fire","single anim");
	thread alley1_oncoming_turret_fire();
	self waittillmatch("stop_turret_fire","single anim");
	self notify("stop_turret_fire");
}

//Function Number: 220
alley1_oncoming_turret_fire()
{
	self endon("stop_turret_fire");
	level endon("stop_turret_fire");
	var_00 = 0.05;
	var_01 = 1;
	var_02 = 0;
	var_03 = "tag_flash";
	for(;;)
	{
		if(var_02 == 0)
		{
			var_03 = "tag_flash";
		}
		else
		{
			var_03 = "tag_flash2";
		}

		var_04 = self gettagorigin(var_03);
		magicbullet("50cal_turret_technical_lagos",var_04,var_04 + anglestoforward(self gettagangles(var_03)) * 100);
		if(var_03 == "tag_flash")
		{
			soundscripts\_snd::snd_message("lagos_technical_turret_fire");
		}

		playfx(common_scripts\utility::getfx("technical_muzzle_flash"),var_04,anglestoforward(self gettagangles(var_03)));
		var_02 = var_02 + 1 % 2;
		wait(var_00);
	}
}

//Function Number: 221
flank_alley_turret_fire(param_00)
{
	param_00 endon("death");
	var_01 = self.mgturret;
	var_02 = var_01[0];
	var_03 = "tag_flash2";
	for(;;)
	{
		var_02 waittill("turret_fire");
		wait 0.05;
		var_04 = var_02 gettagorigin(var_03);
		magicbullet("50cal_turret_technical_lagos",var_04,var_04 + anglestoforward(var_02 gettagangles(var_03)) * 100);
		playfx(common_scripts\utility::getfx("technical_muzzle_flash"),var_04,anglestoforward(var_02 gettagangles(var_03)));
		soundscripts\_snd::snd_message("lagos_technical_turret_fire");
	}
}

//Function Number: 222
alley1_oncoming_truck_sweeper_monitor(param_00)
{
	while(!common_scripts\utility::flag("flag_oncoming_player_safe"))
	{
		param_00 waittill("trigger",var_01);
		if(isdefined(var_01) && isplayer(var_01))
		{
			self kill();
		}

		wait 0.05;
	}
}

//Function Number: 223
alley2_combat()
{
	common_scripts\utility::flag_wait("alley2_spawn");
	level.burke maps\_utility::enable_pain();
	level.joker maps\_utility::enable_pain();
	level.ajani maps\_utility::enable_pain();
	maps\_utility::battlechatter_on("axis");
	maps\_utility::battlechatter_on("allies");
	level.joker thread maps\lagos_utility::ally_stop_dynamic_speed();
	level.ajani thread maps\lagos_utility::ally_stop_dynamic_speed();
	level.alley2_kva = [];
	thread alley2_stage1_combat();
	if(common_scripts\utility::flag("alley2_playerstart"))
	{
		var_00 = getnode("alley2_burke_start","targetname");
		var_01 = getnode("alley2_joker_start","targetname");
		var_02 = getnode("alley2_ajani_start","targetname");
		level.burke maps\_utility::teleport_ai(var_00);
		level.joker maps\_utility::teleport_ai(var_01);
		level.ajani maps\_utility::teleport_ai(var_02);
	}

	level notify("alley2_stage1_go");
	thread maps\lagos_vo::alley_b_dialogue();
}

//Function Number: 224
alley2_jumpers()
{
	common_scripts\utility::flag_wait("alley2_jumpers");
	var_00 = getent("alley2_jumper1","targetname");
	var_01 = getent("alley2_jumper2","targetname");
	var_02 = getnode("alley2_jumper_goto1","targetname");
	var_03 = getnode("alley2_jumper_goto2","targetname");
	thread alley2_jumpers_setup(var_00,var_02);
	thread alley2_jumpers_setup(var_01,var_03);
}

//Function Number: 225
alley2_jumpers_setup(param_00,param_01)
{
	var_02 = param_00 maps\_utility::spawn_ai(1);
	wait 0.05;
	var_02.goalradius = 16;
	var_02.ignoreall = 1;
	var_02.ignoreme = 1;
	var_02 setgoalnode(param_01);
	var_02 waittill("goal");
	var_02 stopanimscripted();
	var_02 delete();
}

//Function Number: 226
alley2_stage1_combat()
{
	setthreatbias("friendly_squad","player_haters",-10000);
	setthreatbias("player_haters","friendly_squad",-10000);
	setthreatbias("player_haters","player",10000);
	level.player setthreatbiasgroup("player");
	var_00 = 1;
	var_01 = 1;
	var_02 = [];
	level endon("alley2_stage2_go");
	level waittill("alley2_stage1_go");
	maps\_utility::activate_trigger("alley2_stage1_burke_goto","targetname",level.player);
	level.burke maps\_utility::disable_surprise();
	maps\_utility::delaythread(2,::maps\_utility::activate_trigger,"alley2_stage1_joker_goto","targetname",level.player);
	maps\_utility::delaythread(4,::maps\_utility::activate_trigger,"alley2_stage1_ajani_goto","targetname",level.player);
	wait(2);
	var_03 = maps\_utility::array_spawn_targetname("alley2_stage1_enemy",1);
	thread maps\lagos_utility::spawn_wave_upkeep_and_flag(var_03,"alley2_combat_move_1",0);
	foreach(var_05 in var_03)
	{
		if(isdefined(var_05) && isalive(var_05))
		{
			if(!issubstr(var_05.classname,"dog"))
			{
				var_05.goalradius = 16;
				var_05 thread maps\lagos_utility::ignore_until_goal_reached();
			}
		}
	}

	common_scripts\utility::flag_wait("alley2_combat_move_1");
	thread flank_alley_goto();
	common_scripts\utility::flag_wait("alley2_combat_move_2");
	level.burke maps\_utility::disable_pain();
	level.joker maps\_utility::disable_pain();
	level.ajani maps\_utility::disable_pain();
	var_07 = maps\_utility::array_spawn_targetname("alley2_stage2_enemy",1);
	thread maps\lagos_utility::spawn_wave_upkeep_and_flag(var_03,"alley2_complete",0);
	foreach(var_05 in var_07)
	{
		if(isdefined(var_05) && isalive(var_05))
		{
			var_05 thread maps\_utility::player_seek_enable();
		}
	}

	common_scripts\utility::flag_wait("alley2_complete");
}

//Function Number: 227
alley2_stage2_combat()
{
	level endon("alley2_stage3_go");
	level waittill("alley2_stage2_go");
	var_00 = 1;
	var_01 = 1;
	var_02 = [];
	var_03 = getentarray("alley2_stage2_enemy","targetname");
	var_04 = getent("alley2_combat_enemy_loc_3","targetname");
	for(var_05 = 0;var_05 < var_00;var_05++)
	{
		var_03 = common_scripts\utility::array_randomize(var_03);
		var_06 = level.player alley2_spawner_locator(var_03);
		var_07 = var_06 maps\_utility::spawn_ai(1);
		var_06.count = 1;
		var_02 = common_scripts\utility::array_add(var_02,var_07);
		level.alley2_kva = common_scripts\utility::array_add(level.alley2_kva,var_07);
		var_07.allowdeath = 1;
		wait(0.25);
		var_07 maps\lagos_utility::assign_goal_vol("alley2_combat_enemy_loc_3");
	}

	for(;;)
	{
		var_02 = maps\_utility::array_removedead_or_dying(var_02);
		level.alley2_kva = maps\_utility::array_removedead_or_dying(level.alley2_kva);
		if(var_02.size < var_01)
		{
			level notify("alley2_stage3_go");
		}

		wait 0.05;
	}
}

//Function Number: 228
alley2_stage3_combat()
{
	level endon("alley2_stage3_end");
	common_scripts\utility::flag_wait("alley2_combat_move_1");
	thread flank_alley_goto();
	var_00 = 2;
	var_01 = 3;
	var_02 = [];
	var_03 = getentarray("alley2_stage3_enemy","targetname");
	var_04 = getent("alley2_combat_enemy_loc_8","targetname");
	for(var_05 = 0;var_05 < var_00;var_05++)
	{
		var_03 = common_scripts\utility::array_randomize(var_03);
		var_06 = level.player alley2_spawner_locator(var_03);
		var_07 = var_06 maps\_utility::spawn_ai(1);
		var_06.count = 1;
		var_02 = common_scripts\utility::array_add(var_02,var_07);
		level.alley2_kva = common_scripts\utility::array_add(level.alley2_kva,var_07);
		var_07.allowdeath = 1;
		wait 0.05;
		var_07 maps\lagos_utility::assign_goal_vol("alley2_combat_enemy_loc_8");
	}

	for(;;)
	{
		var_02 = maps\_utility::array_removedead_or_dying(var_02);
		level.alley2_kva = maps\_utility::array_removedead_or_dying(level.alley2_kva);
		if(level.alley2_kva.size < var_01)
		{
			level.alley2_kva = maps\_utility::array_removedead_or_dying(level.alley2_kva);
			foreach(var_07 in level.alley2_kva)
			{
				var_07 thread maps\_utility::player_seek_enable();
			}
		}

		if(level.alley2_kva.size == 0)
		{
			level notify("flank_combat_goto");
			wait 0.05;
			level notify("alley2_stage3_end");
			level.burke maps\_utility::enable_surprise();
		}

		wait 0.05;
	}
}

//Function Number: 229
alley2_combat_enemy_vol_assign(param_00)
{
	level endon("flank_combat_goto");
	var_01 = getent("alley2_combat_loc_1","targetname");
	var_02 = getent("alley2_combat_loc_2","targetname");
	var_03 = getent("alley2_combat_loc_3","targetname");
	var_04 = getent("alley2_combat_loc_4","targetname");
	var_05 = getent("alley2_combat_loc_5","targetname");
	for(;;)
	{
		wait 0.05;
		param_00 = maps\_utility::array_removedead_or_dying(param_00);
		alley2_combat_player_monitor(var_01,"alley2_ally_trig_1","alley2_combat_enemy_loc_2","alley2_combat_enemy_loc_3",param_00);
		alley2_combat_player_monitor(var_02,"alley2_ally_trig_2","alley2_combat_enemy_loc_3",undefined,param_00);
		alley2_combat_player_monitor(var_03,"alley2_ally_trig_3","alley2_combat_enemy_loc_3","alley2_combat_enemy_loc_5",param_00);
		alley2_combat_player_monitor(var_04,"alley2_ally_trig_4","alley2_combat_enemy_loc_3","alley2_combat_enemy_loc_6",param_00);
		alley2_combat_player_monitor(var_05,"alley2_ally_trig_5","alley2_combat_enemy_loc_6","alley2_combat_enemy_loc_8",param_00);
		wait(randomintrange(5,10));
	}
}

//Function Number: 230
alley2_combat_player_monitor(param_00,param_01,param_02,param_03,param_04)
{
	if(!level.player istouching(param_00))
	{
		wait 0.05;
		return;
	}

	maps\_utility::activate_trigger(param_01,"targetname",level.player);
	alley2_combat_vol_assign(param_04,param_02,param_03);
}

//Function Number: 231
alley2_combat_vol_assign(param_00,param_01,param_02)
{
	if(!isdefined(param_02))
	{
		param_02 = param_01;
	}

	foreach(var_04 in param_00)
	{
		var_05 = var_04 getgoalvolume();
		if(randomint(100) > 80)
		{
			if(var_05 != param_01 && var_05 != param_02)
			{
				if(common_scripts\utility::cointoss())
				{
					var_04 maps\lagos_utility::assign_goal_vol(param_01);
					continue;
				}

				var_04 maps\lagos_utility::assign_goal_vol(param_02);
			}
		}
	}
}

//Function Number: 232
alley2_spawner_locator(param_00)
{
	var_01 = undefined;
	while(!isdefined(var_01))
	{
		foreach(var_03 in param_00)
		{
			var_04 = self geteye();
			var_05 = var_03.origin;
			var_06 = sighttracepassed(var_04,var_05,0,self);
			if(!var_06)
			{
				var_01 = var_03;
				return var_01;
			}
		}

		wait 0.05;
	}
}

//Function Number: 233
flank_alley_goto()
{
	thread maps\lagos_utility::ally_redirect_goto_node("Gideon","flank_start_burke");
	wait(0.5);
	thread maps\lagos_utility::ally_redirect_goto_node("Joker","flank_start_joker");
	wait(0.5);
	thread maps\lagos_utility::ally_redirect_goto_node("Ajani","flank_start_ajani");
}

//Function Number: 234
flank_magic_gren()
{
	var_00 = common_scripts\utility::getstruct("microwave_gren_throw_flank","targetname");
	var_01 = common_scripts\utility::getstruct("microwave_gren_target_flank","targetname");
	var_02 = magicgrenade("microwave_grenade",var_00.origin,var_01.origin);
	var_02 thread maps\_microwave_grenade::microwave_grenade_explode_wait();
}

//Function Number: 235
flank_combat()
{
	common_scripts\utility::flag_wait("alley_flank_start");
	level.burke maps\_utility::disable_pain();
	level.joker maps\_utility::disable_pain();
	level.ajani maps\_utility::disable_pain();
	if(common_scripts\utility::flag("flank_playerstart"))
	{
		var_00 = getnode("flank_start_burke","targetname");
		var_01 = getnode("flank_start_joker","targetname");
		var_02 = getnode("flank_start_ajani","targetname");
		level.burke maps\_utility::teleport_ai(var_00);
		level.joker maps\_utility::teleport_ai(var_01);
		level.ajani maps\_utility::teleport_ai(var_02);
	}

	spawncivilians_flank_alley();
	common_scripts\utility::flag_wait("flank_spawn");
	thread flank_wall_climb_force_check();
	thread flank_wall_climb_force_dismount();
	var_03 = maps\_vehicle::spawn_vehicle_from_targetname_and_drive("enemy_vehicle_Flank_Hummer");
	var_03.dontunloadonend = 1;
	var_03.vehicle_stays_alive = 1;
	var_03.mgturret[0] maketurretsolid();
	if(level.currentgen)
	{
		var_03 thread tff_cleanup_vehicle("alley");
	}

	var_04 = [];
	var_05 = [];
	foreach(var_07 in var_03.riders)
	{
		if(var_07.vehicle_position == 1)
		{
			var_08 = var_07;
			var_08 thread maps\_utility::magic_bullet_shield();
			var_08 maps\_utility::disable_pain();
			var_08.allowdeath = 0;
			var_08.ignoresonicaoe = 1;
			var_04 = common_scripts\utility::array_add(var_04,var_08);
			var_08 thread flank_make_gunner_vulerable();
			var_03 thread flank_alley_turret_fire(var_08);
			continue;
		}

		var_05 = common_scripts\utility::array_add(var_05,var_07);
	}

	soundscripts\_snd::snd_message("truck_turret_flank_alley",var_03);
	thread civilians_flank_alley_react();
	thread maps\lagos_vo::alley_flank_dialogue();
	thread maps\lagos_utility::timeout_and_flag("flank_technical_move",5);
	common_scripts\utility::flag_wait("flank_technical_move");
	soundscripts\_snd::snd_message("truck_turret_flank_alley_drive_away",var_03);
	var_0A = getvehiclenode("node_flank_hummer_second_path","targetname");
	var_03 thread maps\_vehicle::vehicle_paths(var_0A);
	var_03 startpath(var_0A);
	var_03.dontunloadonend = 0;
	var_0B = maps\_utility::array_spawn_targetname("enemy_spawner_Flank_A",1);
	var_03 thread flank_technical_unload();
	var_0C = [];
	var_0D = [];
	var_0E = [];
	var_0F = [];
	var_0D = flank_alley_spawn_group_b();
	var_0E = flank_alley_spawn_group_c();
	var_0F = flank_alley_spawn_group_d();
	thread maps\lagos_utility::spawn_wave_upkeep_and_flag(var_04,"flank_vehicle_turret_dead",0);
	common_scripts\utility::flag_wait("flank_player_behind_gunner");
	var_0C = common_scripts\utility::array_combine(var_0C,var_05);
	var_0C = common_scripts\utility::array_combine(var_0C,var_0B);
	var_0C = common_scripts\utility::array_combine(var_0C,var_0D);
	var_0C = common_scripts\utility::array_combine(var_0C,var_0E);
	var_0C = common_scripts\utility::array_combine(var_0C,var_0F);
	var_0C = maps\_utility::array_removedead_or_dying(var_0C);
	common_scripts\utility::flag_wait("flank_vehicle_turret_dead");
	foreach(var_07 in var_0C)
	{
		if(isdefined(var_07) && isalive(var_07) && !maps\_utility::player_can_see_ai(var_07))
		{
			var_07 kill();
		}

		var_0C = maps\_utility::array_removedead_or_dying(var_0C);
	}

	foreach(var_07 in var_0C)
	{
		if(isdefined(var_07) && isalive(var_07))
		{
			var_07 thread maps\_utility::player_seek_enable();
		}
	}

	while(var_0C.size > 0)
	{
		var_0C = maps\_utility::array_removedead_or_dying(var_0C);
		wait 0.05;
	}

	wait(2);
	common_scripts\utility::flag_set("flank_alley_complete");
	level.burke maps\_utility::enable_pain();
	level.joker maps\_utility::enable_pain();
	level.ajani maps\_utility::enable_pain();
	var_00 = getnode("flank_wall_start_burke","targetname");
	var_01 = getnode("flank_wall_start_joker","targetname");
	var_02 = getnode("flank_wall_start_ajani","targetname");
	level.burke setgoalnode(var_00);
	level.joker setgoalnode(var_01);
	level.ajani setgoalnode(var_02);
}

//Function Number: 236
flank_technical_unload()
{
	self waittill("reached_end_node");
	maps\_vehicle::vehicle_unload("all_but_gunner");
}

//Function Number: 237
flank_wall_climb_force_check()
{
	common_scripts\utility::flag_wait("flag_start_mag_climb_flank");
	thread maps\lagos_lighting::setup_flank_wall_climb_lighting();
	level.player.hack_fix_lagos_flank_alley_camera_pop = 1;
	if(!common_scripts\utility::flag("flank_vehicle_turret_dead"))
	{
		level.player kill();
	}
}

//Function Number: 238
flank_wall_climb_force_dismount()
{
	common_scripts\utility::flag_wait("flag_end_mag_climb_flank");
	thread maps\lagos_lighting::setup_flank_wall_climb_lighting_complete();
	level.player.hack_fix_lagos_flank_alley_camera_pop = undefined;
	maps\_exo_climb::disable_mount_point("climb_mount_flank_alley");
	var_00 = getent("anim_org_exo_climb_flank","targetname");
	var_01 = "player_rig";
	var_02 = "flank_wall_climb";
	level.scr_goaltime["player_rig"]["flank_wall_climb"] = 0.5;
	maps\_exo_climb::force_animated_dismount(var_00,var_01,var_02);
	if(level.currentgen)
	{
		thread maps\_utility::tff_sync(7);
	}

	level notify("mag_climb_complete");
	level notify("flag_cancel_exo_climb");
	maps\_utility::delaythread(8,::common_scripts\utility::flag_set,"obj_progress_mag_climb_flank_complete");
	level.burke maps\_utility::disable_pain();
	var_00 maps\_anim::anim_single_solo_run(level.burke,"flank_wall_climb");
	var_03 = getnode("flank_wall_teleport_joker","targetname");
	var_04 = getnode("flank_wall_teleport_ajani","targetname");
	level.joker maps\_utility::teleport_ai(var_03);
	level.ajani maps\_utility::teleport_ai(var_04);
	level.burke maps\_utility::enable_pain();
	var_05 = getnode("frogger_start_burke","targetname");
	var_06 = getnode("frogger_start_joker","targetname");
	var_07 = getnode("frogger_start_ajani","targetname");
	level.burke setgoalnode(var_05);
	level.joker setgoalnode(var_06);
	wait(1);
	level.ajani setgoalnode(var_07);
}

//Function Number: 239
flank_handle_player_bypass()
{
	common_scripts\utility::flag_wait("flank_player_behind_gunner_bypass");
	if(!common_scripts\utility::flag("flank_vehicle_turret_dead"))
	{
		var_00 = maps\_utility::array_spawn_targetname("enemy_spawner_Flank_bypass",1);
		foreach(var_02 in var_00)
		{
			if(issubstr(var_02.classname,"dog"))
			{
				var_02 thread maps\lagos_utility::ignore_until_goal_reached();
			}
		}
	}
}

//Function Number: 240
tff_cleanup_vehicle(param_00)
{
	var_01 = "";
	switch(param_00)
	{
		case "intro":
			var_01 = "tff_pre_intro_to_middle";
			break;

		case "middle":
			var_01 = "tff_pre_unload_middle";
			break;

		case "alley":
			var_01 = "tff_pre_alley_to_outro";
			break;

		case "roundabout_lobby":
			var_01 = "tff_pre_unload_lobby";
			break;
	}

	if(var_01 == "")
	{
		return;
	}

	level waittill(var_01);
	if(isdefined(self))
	{
		if(maps\_vehicle::isvehicle())
		{
			maps\_vehicle_code::_freevehicle();
		}

		self delete();
	}
}

//Function Number: 241
flank_alley_door_kick()
{
	var_00 = getent("anim_org_flank_kick","targetname");
	var_01 = getent("flank_alley_door","targetname");
	var_01.animname = "flank_alley_door";
	var_01 maps\_utility::assign_animtree();
	var_00 thread maps\_anim::anim_first_frame_solo(var_01,"flank_alley_door_kick_open");
	var_02 = getent("flank_alley_door_collision_a","targetname");
	var_03 = getent("flank_alley_door_collision_b","targetname");
	var_02 linkto(var_01,"doora");
	var_03 linkto(var_01,"doorb");
	common_scripts\utility::flag_wait("alley_flank_start");
	if(distance2dsquared(level.player.origin,var_00.origin) < distance2dsquared(level.burke.origin,var_00.origin) && !common_scripts\utility::flag("flank_playerstart"))
	{
		var_00 thread maps\_anim::anim_single_solo(var_01,"flank_alley_door_kick_open");
		var_02 common_scripts\utility::delaycall(2,::connectpaths);
		var_03 common_scripts\utility::delaycall(2,::connectpaths);
		common_scripts\utility::flag_wait("flank_spawn");
		if(!common_scripts\utility::flag("flank_vehicle_turret_dead"))
		{
			var_00 maps\_anim::anim_reach_solo(level.burke,"burke_flank_kick_start",undefined,1);
		}

		if(!common_scripts\utility::flag("flank_vehicle_turret_dead"))
		{
			var_00 maps\_anim::anim_reach_solo(level.burke,"burke_flank_kick_loop",undefined,1);
		}

		if(!common_scripts\utility::flag("flank_vehicle_turret_dead"))
		{
			var_00 thread maps\_anim::anim_loop_solo(level.burke,"burke_flank_kick_loop","stop_loop");
		}
	}
	else
	{
		common_scripts\utility::flag_wait("flank_spawn");
		var_04 = getent("civilian_female_flank_burke_cover","targetname") maps\_utility::spawn_ai(1,1);
		var_04.animname = "civ_flank";
		var_00 maps\_anim::anim_reach_solo(level.burke,"burke_flank_kick_start");
		thread flank_alley_door_kick_civilian_react(var_00,var_04);
		var_00 thread maps\_anim::anim_single_solo(var_01,"flank_alley_door_kick_open");
		var_02 common_scripts\utility::delaycall(2,::connectpaths);
		var_03 common_scripts\utility::delaycall(2,::connectpaths);
		var_00 maps\_anim::anim_single_solo(level.burke,"burke_flank_kick_start");
		if(!common_scripts\utility::flag("flank_vehicle_turret_dead"))
		{
			var_00 thread maps\_anim::anim_loop_solo(level.burke,"burke_flank_kick_loop","stop_loop");
		}
	}

	common_scripts\utility::flag_wait("flank_burke_move_from_window");
	var_00 notify("stop_loop");
	if(!common_scripts\utility::flag("flank_vehicle_turret_dead"))
	{
		var_00 maps\_anim::anim_single_solo(level.burke,"burke_flank_kick_exit");
	}
}

//Function Number: 242
flank_alley_door_kick_doors_open(param_00,param_01)
{
	wait(2);
	var_02 = (0,26.3,0);
	var_03 = (0,313.1,0);
	param_00 rotateto(var_02,0.1);
	param_01 rotateto(var_03,0.1);
}

//Function Number: 243
flank_alley_door_kick_civilian_react(param_00,param_01)
{
	param_00 maps\_anim::anim_single_solo(param_01,"burke_flank_kick_civ_react");
	param_00 maps\_anim::anim_loop_solo(param_01,"burke_flank_kick_civ_idle");
}

//Function Number: 244
flank_make_gunner_vulerable()
{
	self endon("death");
	if(!isdefined(self.damage_functions))
	{
		self.damage_functions = [];
	}

	maps\_utility::add_damage_function(::flank_gunner_damage_function);
	common_scripts\utility::flag_wait("flank_player_behind_gunner");
	maps\_utility::stop_magic_bullet_shield();
	maps\_utility::enable_pain();
	self.allowdeath = 1;
	common_scripts\utility::flag_wait("flank_player_behind_gunner_bypass");
	wait(4);
	if(isdefined(self) && isalive(self))
	{
		self kill();
	}
}

//Function Number: 245
flank_gunner_damage_function(param_00,param_01,param_02,param_03,param_04,param_05,param_06)
{
	if(param_01 != level.player && !common_scripts\utility::flag("flank_player_behind_gunner_bypass"))
	{
		if(self.health > 0)
		{
			self.health = self.health + param_00;
		}
	}
}

//Function Number: 246
flank_alley_spawn_group_b(param_00)
{
	common_scripts\utility::flag_wait("flank_spawn_enemies_B");
	param_00 = maps\_utility::array_spawn_targetname("enemy_spawner_Flank_B",1);
	return param_00;
}

//Function Number: 247
flank_alley_spawn_group_c(param_00)
{
	common_scripts\utility::flag_wait("flank_spawn_enemies_C");
	param_00 = maps\_utility::array_spawn_targetname("enemy_spawner_Flank_C",1);
	foreach(var_02 in param_00)
	{
		if(isdefined(var_02) && isalive(var_02))
		{
			var_02 thread maps\lagos_utility::ignore_until_goal_reached();
		}
	}

	return param_00;
}

//Function Number: 248
flank_alley_spawn_group_d(param_00)
{
	common_scripts\utility::flag_wait("flank_spawn_enemies_D");
	param_00 = maps\_utility::array_spawn_targetname("enemy_spawner_Flank_D",1);
	foreach(var_02 in param_00)
	{
		if(isdefined(var_02) && isalive(var_02))
		{
			var_02 thread maps\lagos_utility::ignore_until_goal_reached();
		}
	}

	return param_00;
}

//Function Number: 249
spawncivilians_flank_alley()
{
	var_00 = getent("civilian_female_flank_alley","targetname");
	var_01 = common_scripts\utility::getstructarray("node_Flank_Alley_female_standing","targetname");
	var_02 = maps\lagos_utility::populate_ai_civilians(var_00,var_01,1,"flag_Flank_Alley_civilians_flee");
	var_03 = getent("civilian_male_flank_alley","targetname");
	var_04 = common_scripts\utility::getstructarray("node_Flank_Alley_male_standing","targetname");
	var_05 = maps\lagos_utility::populate_ai_civilians(var_03,var_04,1,"flag_Flank_Alley_civilians_flee");
}

//Function Number: 250
civilians_flank_alley_react()
{
	common_scripts\utility::flag_set("flag_Flank_Alley_react");
	common_scripts\utility::flag_wait("flank_technical_move");
	common_scripts\utility::flag_set("flag_Flank_Alley_civilians_flee");
}

//Function Number: 251
frogger_impact_damage_function(param_00,param_01,param_02,param_03,param_04,param_05,param_06)
{
	if(param_04 == "MOD_CRUSH")
	{
		param_00 = param_00 + level.player.maxhealth;
	}
}

//Function Number: 252
frogger_combat()
{
	level.frogger_vehicles = [];
	if(!isdefined(level.lookbothways))
	{
		level.lookbothways = 1;
	}

	common_scripts\utility::flag_wait("trigger_start_timed_lane_traffic");
	setthreatbias("friendly_squad","player_haters",-10000);
	setthreatbias("player_haters","friendly_squad",-10000);
	setthreatbias("player_haters","player",10000);
	level.player setthreatbiasgroup("player");
	level.player maps\_utility::add_damage_function(::frogger_impact_damage_function);
	level.frogger_spawners = getentarray("frogger_car_spawner","targetname");
	foreach(var_01 in level.frogger_spawners)
	{
		var_01.traffic_locked = 0;
	}

	level.frogger_bus_spawners = getentarray("frogger_bus_spawner","targetname");
	foreach(var_01 in level.frogger_bus_spawners)
	{
		var_01.traffic_locked = 0;
	}

	thread spawn_vehicle_lane(1,3);
	if(level.nextgen)
	{
		thread spawn_vehicle_lane(2,4);
	}

	thread spawn_vehicle_lane(3,5);
	if(level.nextgen)
	{
		thread spawn_vehicle_lane(5,4);
	}

	thread spawn_vehicle_lane(6,5);
	if(level.nextgen)
	{
		thread spawn_vehicle_lane(7,3);
	}

	thread spawn_vehicle_lane(8,4);
	common_scripts\utility::run_thread_on_targetname("trigger_release_southbound",::frogger_release_vehicle_at_trigger);
	common_scripts\utility::run_thread_on_targetname("trigger_release_northbound",::frogger_release_vehicle_at_trigger);
	common_scripts\utility::run_thread_on_targetname("trigger_despawn_southbound",::delete_vehicle_at_trigger);
	common_scripts\utility::run_thread_on_targetname("trigger_despawn_northbound",::delete_vehicle_at_trigger);
	var_05 = getent("frogger_bad_place_street_1","targetname");
	badplace_brush("enemy_badPlace_frogger_street_1",-1,var_05,"axis");
	var_06 = getent("frogger_bad_place_street_2","targetname");
	badplace_brush("enemy_badPlace_frogger_street_2",-1,var_06,"axis");
	thread frogger_squad_crossing();
	common_scripts\utility::flag_wait("trigger_start_frogger_kva");
	level.burke.grenadeammo = 0;
	level.joker.grenadeammo = 0;
	level.ajani.grenadeammo = 0;
	var_07 = maps\_vehicle::spawn_vehicle_from_targetname_and_drive("enemy_vehicle_Frogger_Hummer");
	var_07 maps\_vehicle::vehicle_set_health(1000000);
	var_08 = [];
	var_08 = common_scripts\utility::array_combine(var_08,var_07.riders);
	var_07 thread maps\lagos_utility::vehicle_unload_how_at_end();
	foreach(var_0A in var_08)
	{
		if(!common_scripts\utility::flag("frogger_flag_player_middle"))
		{
			var_0A thread maps\lagos_utility::ignore_until_goal_reached();
		}
	}

	wait(0.5);
	if(level.nextgen)
	{
		thread spawn_vehicle_lane(4,3);
	}

	wait(3.5);
	if(level.nextgen)
	{
		level.non_vehicle_guys_a = maps\_utility::array_spawn_targetname("enemy_spawner_Frogger_A2",1);
		foreach(var_0A in level.non_vehicle_guys_a)
		{
			if(!common_scripts\utility::flag("frogger_flag_player_middle"))
			{
				var_0A thread maps\lagos_utility::ignore_until_goal_reached();
			}
		}
	}

	level.frogger_middle_guys = [];
	level.frogger_middle_guys = common_scripts\utility::array_combine(level.frogger_middle_guys,var_08);
	if(level.nextgen)
	{
		level.frogger_middle_guys = common_scripts\utility::array_combine(level.frogger_middle_guys,level.non_vehicle_guys_a);
	}

	thread frogger_handle_bypass_middle();
	common_scripts\utility::flag_set("flag_frogger_middle_spawned");
	thread maps\lagos_utility::spawn_wave_upkeep_and_flag(level.frogger_middle_guys,"flag_frogger_middle_dead");
	common_scripts\utility::flag_wait("trigger_start_frogger_kva_B");
	var_0E = [];
	if(level.nextgen)
	{
		var_0E = maps\_utility::array_spawn_targetname("enemy_spawner_Frogger_C",1);
	}
	else
	{
		var_0E = maps\_utility::array_spawn_targetname_cg("enemy_spawner_Frogger_C",1,0.05);
	}

	foreach(var_0A in var_0E)
	{
		var_0A thread maps\lagos_utility::ignore_until_goal_reached();
	}

	common_scripts\utility::flag_wait("trigger_start_frogger_kva_D");
	var_11 = [];
	if(level.nextgen)
	{
		var_11 = maps\_utility::array_spawn_targetname("enemy_spawner_Frogger_D",1);
	}
	else
	{
		var_11 = maps\_utility::array_spawn_targetname_cg("enemy_spawner_Frogger_D",1,0.05);
	}

	foreach(var_0A in var_11)
	{
		var_0A thread maps\lagos_utility::ignore_until_goal_reached();
	}

	wait(2);
	var_14 = [];
	if(level.nextgen)
	{
		var_14 = maps\_utility::array_spawn_targetname("enemy_spawner_Frogger_D_dog",1);
	}

	var_15 = [];
	var_15 = common_scripts\utility::array_combine(var_15,var_0E);
	var_15 = common_scripts\utility::array_combine(var_15,var_11);
	if(level.nextgen)
	{
		var_15 = common_scripts\utility::array_combine(var_15,var_14);
	}

	thread maps\lagos_utility::spawn_wave_upkeep_and_flag(var_15,"flag_frogger_complete",0);
	common_scripts\utility::flag_wait("flag_frogger_complete");
	common_scripts\utility::flag_wait("frogger_squad_at_end");
	common_scripts\utility::flag_set("begin_traffic_traverse");
	traffic_traverse_start();
}

//Function Number: 253
frogger_handle_bypass_middle()
{
	var_00 = getthreatbias("frogger_middle","friendly_squad");
	var_01 = getthreatbias("frogger_middle","player");
	common_scripts\utility::flag_wait("frogger_flag_player_middle");
	level.player setthreatbiasgroup("player");
	setthreatbias("frogger_middle","friendly_squad",-10000);
	setthreatbias("frogger_middle","player",10000);
}

//Function Number: 254
frogger_squad_crossing()
{
	var_00 = getent("frogger_bad_place_street_1","targetname");
	badplace_brush("alley_badPlace_frogger_street_1",-1,var_00,"allies");
	var_01 = getent("frogger_bad_place_street_2","targetname");
	badplace_brush("alley_badPlace_frogger_street_2",-1,var_01,"allies");
	level.frogger_teleport_middle = getnodearray("frogger_teleport_middle","targetname");
	level.frogger_teleport_end = getnodearray("frogger_teleport_end","targetname");
	foreach(var_03 in level.frogger_teleport_middle)
	{
		var_03 disconnectnode();
	}

	foreach(var_03 in level.frogger_teleport_end)
	{
		var_03 disconnectnode();
	}

	common_scripts\utility::flag_wait("frogger_flag_player_middle");
	level.burke thread frogger_teleport_middle_check();
	level.joker thread frogger_teleport_middle_check();
	level.ajani thread frogger_teleport_middle_check();
	common_scripts\utility::flag_wait("frogger_flag_player_end");
	level.burke notify("skip_middle");
	level.joker notify("skip_middle");
	level.ajani notify("skip_middle");
	level.burke thread frogger_teleport_end_check();
	level.joker thread frogger_teleport_end_check();
	level.ajani thread frogger_teleport_end_check();
	common_scripts\utility::run_thread_on_targetname("frogger_squad_at_end",::frogger_squad_crossing_complete_check,"frogger_squad_at_end");
}

//Function Number: 255
frogger_teleport_middle_check()
{
	self endon("death");
	self endon("skip_middle");
	var_00 = 0;
	var_01 = 0;
	var_02 = getdvarfloat("cg_fov");
	var_03 = gettime();
	var_04 = 0;
	while(!var_00)
	{
		var_04 = 0;
		while(!maps\_utility::within_fov_2d(level.player.origin,level.player.angles,self.origin,cos(var_02)))
		{
			if(var_04 >= 2000)
			{
				var_00 = 1;
				break;
			}

			var_04 = gettime() - var_03;
			wait 0.05;
		}

		wait 0.05;
	}

	while(!var_01)
	{
		foreach(var_06 in level.frogger_teleport_middle)
		{
			if(!maps\_utility::within_fov_2d(level.player.origin,level.player.angles,var_06.origin,cos(var_02)) && distance2d(level.player.origin,var_06.origin) > 56)
			{
				var_06 connectnode();
				level.frogger_teleport_middle = common_scripts\utility::array_remove(level.frogger_teleport_middle,var_06);
				var_01 = 1;
				maps\_utility::teleport_ai(var_06);
				break;
			}
		}

		wait 0.05;
	}
}

//Function Number: 256
frogger_teleport_end_check()
{
	self endon("death");
	var_00 = 0;
	var_01 = 0;
	var_02 = getdvarfloat("cg_fov");
	var_03 = gettime();
	var_04 = 0;
	while(!var_00)
	{
		var_04 = 0;
		while(!maps\_utility::within_fov_2d(level.player.origin,level.player.angles,self.origin,cos(var_02)))
		{
			if(var_04 >= 3000)
			{
				var_00 = 1;
				break;
			}

			var_04 = gettime() - var_03;
			wait 0.05;
		}

		wait 0.05;
	}

	while(!var_01)
	{
		foreach(var_06 in level.frogger_teleport_end)
		{
			if(!maps\_utility::within_fov_2d(level.player.origin,level.player.angles,var_06.origin,cos(var_02)) && distance2d(level.player.origin,var_06.origin) > 56)
			{
				var_06 connectnode();
				level.frogger_teleport_end = common_scripts\utility::array_remove(level.frogger_teleport_end,var_06);
				var_01 = 1;
				maps\_utility::teleport_ai(var_06);
				break;
			}
		}

		wait 0.05;
	}
}

//Function Number: 257
frogger_middle_kill_check()
{
	common_scripts\utility::flag_wait("frogger_flag_player_end");
	maps\lagos_utility::kill_after_timeout(level.frogger_middle_guys,8,1);
}

//Function Number: 258
frogger_brake_vehicle_at_trigger(param_00)
{
	while(!common_scripts\utility::flag(param_00))
	{
		self waittill("trigger",var_01);
		if(var_01 maps\_vehicle::isvehicle())
		{
			var_01 vehicle_setspeed(0,15,15);
			thread frogger_slow_down_lane(var_01.lane,param_00);
		}
	}
}

//Function Number: 259
frogger_slow_down_lane(param_00,param_01)
{
	var_02 = "destroy_all_frogger_vehicles_lane_" + param_00;
	level endon(var_02);
	while(!common_scripts\utility::flag(param_01))
	{
		if(param_00 == 1 && !common_scripts\utility::flag("frogger_stop_lane_1"))
		{
			common_scripts\utility::flag_set("frogger_stop_lane_1");
		}
		else if(param_00 == 2 && !common_scripts\utility::flag("frogger_stop_lane_2"))
		{
			common_scripts\utility::flag_set("frogger_stop_lane_2");
		}
		else if(param_00 == 3 && !common_scripts\utility::flag("frogger_stop_lane_3"))
		{
			common_scripts\utility::flag_set("frogger_stop_lane_3");
		}
		else if(param_00 == 4 && !common_scripts\utility::flag("frogger_stop_lane_4"))
		{
			common_scripts\utility::flag_set("frogger_stop_lane_4");
		}
		else if(param_00 == 5 && !common_scripts\utility::flag("frogger_stop_lane_5"))
		{
			common_scripts\utility::flag_set("frogger_stop_lane_5");
		}
		else if(param_00 == 6 && !common_scripts\utility::flag("frogger_stop_lane_6"))
		{
			common_scripts\utility::flag_set("frogger_stop_lane_6");
		}
		else if(param_00 == 7 && !common_scripts\utility::flag("frogger_stop_lane_7"))
		{
			common_scripts\utility::flag_set("frogger_stop_lane_7");
		}
		else if(param_00 == 8 && !common_scripts\utility::flag("frogger_stop_lane_8"))
		{
			common_scripts\utility::flag_set("frogger_stop_lane_8");
		}

		foreach(var_04 in level.frogger_vehicles)
		{
			if(isdefined(var_04) && isdefined(var_04.lane) && var_04 maps\_vehicle::isvehicle() && var_04.lane == param_00 && var_04 vehicle_getspeed() != 0)
			{
				if(var_04 maps\_vehicle::isvehicle())
				{
					var_04 vehicle_setspeed(0,15,5);
				}
			}
		}

		wait 0.05;
	}

	foreach(var_04 in level.frogger_vehicles)
	{
		if(isdefined(var_04) && isdefined(var_04.lane) && var_04 maps\_vehicle::isvehicle() && var_04.lane == param_00 && var_04 vehicle_getspeed() != 40)
		{
			if(var_04 maps\_vehicle::isvehicle())
			{
				var_04 vehicle_setspeed(40,15,5);
			}
		}
	}

	if(param_00 == 1)
	{
		common_scripts\utility::flag_set("frogger_restart_lane_1");
		return;
	}

	if(param_00 == 2)
	{
		common_scripts\utility::flag_set("frogger_restart_lane_2");
		return;
	}

	if(param_00 == 3)
	{
		common_scripts\utility::flag_set("frogger_restart_lane_3");
		return;
	}

	if(param_00 == 4)
	{
		common_scripts\utility::flag_set("frogger_restart_lane_4");
		return;
	}

	if(param_00 == 5)
	{
		common_scripts\utility::flag_set("frogger_restart_lane_5");
		return;
	}

	if(param_00 == 6)
	{
		common_scripts\utility::flag_set("frogger_restart_lane_6");
		return;
	}

	if(param_00 == 7)
	{
		common_scripts\utility::flag_set("frogger_restart_lane_7");
		return;
	}

	if(param_00 == 8)
	{
		common_scripts\utility::flag_set("frogger_restart_lane_8");
		return;
	}
}

//Function Number: 260
frogger_squad_crossing_complete_check(param_00)
{
	var_01 = 0;
	var_02 = 0;
	var_03 = 0;
	for(;;)
	{
		self waittill("trigger",var_04);
		if(issubstr(var_04.script_friendname,"Gideon") && var_01 == 0)
		{
			var_01 = 1;
		}

		if(issubstr(var_04.script_friendname,"Joker") && var_02 == 0)
		{
			var_02 = 1;
		}

		if(issubstr(var_04.script_friendname,"Ajani") && var_03 == 0)
		{
			var_03 = 1;
		}

		if(var_01 == 1 && var_02 == 1 && var_03 == 1)
		{
			common_scripts\utility::flag_set(param_00);
		}
	}
}

//Function Number: 261
spawn_vehicle_lane(param_00,param_01)
{
	var_02 = "destroy_all_frogger_vehicles_lane_" + param_00;
	level endon(var_02);
	var_03 = 1;
	var_04 = 0;
	while(!common_scripts\utility::flag("trigger_stop_timed_lane_traffic"))
	{
		if(common_scripts\utility::flag("frogger_stop_lane_1") && param_00 == 1)
		{
			common_scripts\utility::flag_wait("frogger_restart_lane_1");
		}
		else if(common_scripts\utility::flag("frogger_stop_lane_2") && param_00 == 2)
		{
			common_scripts\utility::flag_wait("frogger_restart_lane_2");
		}
		else if(common_scripts\utility::flag("frogger_stop_lane_3") && param_00 == 3)
		{
			common_scripts\utility::flag_wait("frogger_restart_lane_3");
		}
		else if(common_scripts\utility::flag("frogger_stop_lane_4") && param_00 == 4)
		{
			common_scripts\utility::flag_wait("frogger_restart_lane_4");
		}
		else if(common_scripts\utility::flag("frogger_stop_lane_5") && param_00 == 5)
		{
			common_scripts\utility::flag_wait("frogger_restart_lane_5");
		}
		else if(common_scripts\utility::flag("frogger_stop_lane_6") && param_00 == 6)
		{
			common_scripts\utility::flag_wait("frogger_restart_lane_6");
		}
		else if(common_scripts\utility::flag("frogger_stop_lane_7") && param_00 == 7)
		{
			common_scripts\utility::flag_wait("frogger_restart_lane_7");
		}
		else if(common_scripts\utility::flag("frogger_stop_lane_8") && param_00 == 8)
		{
			common_scripts\utility::flag_wait("frogger_restart_lane_8");
		}

		if(var_03 % param_01)
		{
			var_04 = 0;
		}
		else
		{
			var_04 = 1;
		}

		if(level.nextgen)
		{
			while(level.frogger_vehicles.size > 60)
			{
				wait 0.05;
			}
		}
		else
		{
			while(level.frogger_vehicles.size > 10)
			{
				wait 0.05;
			}
		}

		var_05 = frogger_spawn_selection(param_00,var_04);
		level.frogger_vehicles = common_scripts\utility::array_add(level.frogger_vehicles,var_05);
		wait 0.05;
		var_05.vehicle_stays_alive = 1;
		var_03++;
		wait(randomfloatrange(2.5,4));
	}
}

//Function Number: 262
frogger_vehicle_hit_react()
{
	self waittill("damage",var_00,var_01,var_02,var_03,var_04);
	if(isplayer(var_01))
	{
		maps\lagos_utility::vehicle_crazy_steering_frogger();
	}
}

//Function Number: 263
frogger_vehicle_hit_fail()
{
	self waittill("damage",var_00,var_01,var_02,var_03,var_04);
	if(isplayer(var_01))
	{
		if(isdefined(level.lookbothways))
		{
			level.lookbothways = 0;
		}

		if(var_04 == "MOD_GRENADE_SPLASH" || var_04 == "MOD_GRENADE")
		{
			self kill();
			setdvar("ui_deadquote",&"SCRIPT_MISSIONFAIL_CIVILIAN_KILLED");
			maps\_utility::missionfailedwrapper();
		}
	}
}

//Function Number: 264
frogger_spawn_selection(param_00,param_01)
{
	if(!param_01)
	{
		var_02 = randomintrange(0,level.frogger_spawners.size - 1);
		while(level.frogger_spawners[var_02].traffic_locked == 1)
		{
			wait 0.05;
		}

		level.frogger_spawners[var_02].traffic_locked = 1;
		var_03 = level.frogger_spawners[var_02] maps\_utility::spawn_vehicle();
		var_03.lane = param_00;
		thread unlock_frogger_traffic_spawner(level.frogger_spawners[var_02]);
		soundscripts\_snd::snd_message("frogger_vehicle_by",var_03);
		var_03 thread frogger_vehicle_hit_fail();
		if(level.nextgen)
		{
			if(param_00 != 8 && param_00 != 7 && param_00 != 4)
			{
				var_03 vehphys_disablecrashing();
				var_03 thread frogger_vehicle_hit_react();
			}
		}
	}
	else
	{
		var_02 = randomintrange(0,level.frogger_bus_spawners.size - 1);
		while(level.frogger_bus_spawners[var_03].traffic_locked == 1)
		{
			wait 0.05;
		}

		level.frogger_bus_spawners[var_03].traffic_locked = 1;
		var_03 = level.frogger_bus_spawners[var_03] maps\_utility::spawn_vehicle();
		var_03.lane = param_00;
		var_03 thread frogger_vehicle_hit_fail();
		thread unlock_frogger_traffic_spawner(level.frogger_bus_spawners[var_02]);
		soundscripts\_snd::snd_message("frogger_vehicle_by",var_03);
	}

	var_03 thread frogger_vehicle_rumble();
	var_04 = undefined;
	var_05 = getent("civ_vehicle_driver_spawner","targetname");
	if(isdefined(var_05))
	{
		var_04 = var_05 maps\_utility::spawn_ai(1);
		var_03 maps\_utility::guy_enter_vehicle(var_04);
		var_04 setcandamage(0);
	}

	var_06 = getvehiclenode("frogger_lane_" + param_00,"targetname");
	var_03 vehicle_teleport(var_06.origin,var_06.angles,1);
	var_03 thread maps\_vehicle::vehicle_paths(var_06);
	var_03 startpath(var_06);
	return var_03;
}

//Function Number: 265
frogger_vehicle_rumble()
{
	self endon("death");
	while(isdefined(self))
	{
		if(common_scripts\utility::distance_2d_squared(self.origin,level.player.origin) <= 40000)
		{
			maps\lagos_utility::rumble_frogger_vehicles();
			wait(2);
		}

		wait 0.05;
	}
}

//Function Number: 266
unlock_frogger_traffic_spawner(param_00)
{
	wait 0.05;
	param_00.traffic_locked = 0;
}

//Function Number: 267
delete_vehicle_at_trigger()
{
	for(;;)
	{
		self waittill("trigger",var_00);
		if(var_00 maps\_vehicle::isvehicle())
		{
			var_00.free_on_death = 1;
			var_00 maps\_vehicle_code::_freevehicle();
			wait(0.05);
			if(isdefined(var_00.deathfx_ent))
			{
				var_00.deathfx_ent delete();
			}

			level.frogger_vehicles = common_scripts\utility::array_remove(level.frogger_vehicles,var_00);
			var_00 delete();
		}
	}
}

//Function Number: 268
frogger_release_vehicle_at_trigger()
{
	for(;;)
	{
		self waittill("trigger",var_00);
		if(var_00 maps\_vehicle::isvehicle())
		{
			level.frogger_vehicles = common_scripts\utility::array_remove(level.frogger_vehicles,var_00);
			if(level.nextgen)
			{
				var_00 vehicle_setspeed(40,15,5);
			}
		}
	}
}

//Function Number: 269
destroy_all_frogger_vehicles_lane(param_00)
{
	var_01 = "destroy_all_frogger_vehicles_lane_" + param_00;
	level notify(var_01);
	var_02 = [];
	if(isdefined(level.frogger_vehicles) && level.frogger_vehicles.size > 0)
	{
		foreach(var_04 in level.frogger_vehicles)
		{
			if(isalive(var_04) && var_04.lane == param_00)
			{
				var_04 delete();
			}
		}
	}
}

//Function Number: 270
player_exo_jump_release_hint_off()
{
	if(level.player buttonpressed("DPAD_UP"))
	{
		return 1;
	}

	return 0;
}

//Function Number: 271
player_exo_jump_hint_off()
{
	if(level.player jumpbuttonpressed())
	{
		return 1;
	}

	return 0;
}

//Function Number: 272
traffic_traverse_start()
{
	soundscripts\_snd::snd_message("traffic_traverse");
	common_scripts\utility::flag_wait("begin_traffic_traverse");
	while(!isdefined(level.player_bus_start))
	{
		wait 0.05;
	}

	thread maps\lagos_vo::highway_ledge_jump_prep_dialogue();
	maps\_utility::battlechatter_off("axis");
	maps\_utility::battlechatter_off("allies");
	var_00 = getent("anim_org_fence_tear_jump","targetname");
	level.org_player_highway_ledge = getent("anim_org_fence_tear_jump_player","targetname");
	var_01 = getent("highway_pullback_fence","targetname");
	var_01.animname = "highway_fence";
	var_01 maps\_utility::assign_animtree();
	var_00 thread maps\_anim::anim_first_frame_solo(var_01,"highway_fence_pull_back");
	var_02 = maps\_vehicle::spawn_vehicle_from_targetname("KVA_hostage_truck_pass_fence");
	var_02.animname = "hostage_truck_fence";
	level.player_bus_start.animname = "highway_bus_1";
	var_00 maps\_anim::anim_reach_solo(level.burke,"burke_traffic_start_pt1");
	var_00 thread maps\_anim::anim_single_solo(var_01,"highway_fence_pull_back");
	soundscripts\_snd::snd_message("traffic_traverse_fence_rip");
	thread traffic_ledge_burke_loop_wait(var_00);
	thread traffic_traverse_ledge_player_input();
	common_scripts\utility::flag_wait("flag_highway_ledge_climb_started");
	thread check_look_both_ways_achievement();
	common_scripts\utility::flag_set("obj_progress_pursue_hostage_truck_highway");
	common_scripts\utility::flag_set("done_traffic_ledge_jump_start");
	common_scripts\utility::flag_set("traffic_ledge_lighting");
	level.player enableslowaim(0.2,0.2);
	level.player maps\_shg_utility::setup_player_for_scene();
	thread maps\_player_exo::player_exo_deactivate();
	level.player_rig_highway_ledge = maps\_utility::spawn_anim_model("player_rig",level.player.origin);
	level.player_rig_highway_ledge hide();
	var_03 = 0.5;
	level.player playerlinktoblend(level.player_rig_highway_ledge,"tag_player",var_03);
	level.player common_scripts\utility::delaycall(var_03,::playerlinktodelta,level.player_rig_highway_ledge,"tag_player",1,7,7,5,5,1);
	level.player_rig_highway_ledge common_scripts\utility::delaycall(var_03,::show);
	thread maps\lagos_vo::highway_ledge_jump_go_dialogue();
	level.player maps\_utility::remove_damage_function(::frogger_impact_damage_function);
	level.burke maps\lagos_utility::setup_ai_for_bus_sequence();
	level.burke animscripts\utility::setunstableground(1);
	level.burke maps\_utility::disable_pain();
	level.burke maps\_utility::disable_surprise();
	level.burke.grenadeammo = 0;
	level.burke.baseaccuracy = 0.15;
	level.burke thread maps\lagos_utility::keep_filling_clip_ammo(1);
	level.burke pushplayer(1);
	level.burke.pushable = 0;
	var_00 maps\_anim::anim_first_frame_solo(level.player_rig_highway_ledge,"traffic_start_VM");
	var_00 notify("stop_loop");
	var_00 thread maps\_anim::anim_single_solo(level.burke,"burke_traffic_start_pt2");
	var_00 thread maps\_anim::anim_single_solo(level.player_bus_start,"highway_bus_1_pass_fence");
	thread start_bus_moving_before_anim_ends(level.player_bus_start,"start_bus_traverse_1",14);
	thread traffic_anim_bus_1(var_00,var_02);
	if(level.currentgen)
	{
		level.org_player_highway_ledge maps\_anim::anim_single_solo(level.player_rig_highway_ledge,"traffic_start_VM",undefined,0.25);
	}
	else
	{
		level.org_player_highway_ledge maps\_anim::anim_single_solo(level.player_rig_highway_ledge,"traffic_start_VM");
	}

	level.burke maps\_utility::set_goal_radius(16);
	var_04 = getnode("cover_bus_traverse_1","targetname");
	level.burke maps\_utility::set_goal_node(var_04);
	level.player unlink();
	level.player_rig_highway_ledge delete();
	level.player maps\_shg_utility::setup_player_for_gameplay();
	level.player allowjump(1);
	level.player thread maps\lagos_utility::give_player_more_ammo(5);
	level.player disableslowaim();
	if(level.currentgen)
	{
		level.player setorigin(level.player.origin + (0,-36,5));
	}

	common_scripts\utility::flag_set("obj_progress_pursue_hostage_truck_highway_traverse");
	thread maps\lagos_jump::exo_jump_process();
	thread maps\_player_exo::player_exo_activate();
	common_scripts\utility::flag_set("flag_player_traversing_traffic");
	thread traffic_traverse_fail_check();
}

//Function Number: 273
check_look_both_ways_achievement()
{
	if(isdefined(level.lookbothways) && level.lookbothways)
	{
		maps\_utility::giveachievement_wrapper("LEVEL_3A");
	}
}

//Function Number: 274
traffic_ledge_burke_loop_wait(param_00)
{
	param_00 maps\_anim::anim_single_solo(level.burke,"burke_traffic_start_pt1");
	if(!common_scripts\utility::flag("flag_highway_ledge_climb_started"))
	{
		param_00 thread maps\_anim::anim_loop_solo(level.burke,"burke_traffic_start_idle","stop_loop");
	}
}

//Function Number: 275
start_bus_moving_before_anim_ends(param_00,param_01,param_02)
{
	wait(param_02);
	var_03 = getvehiclenode(param_01,"targetname");
	param_00 startpath(var_03);
}

//Function Number: 276
traffic_anim_bus_1(param_00,param_01)
{
	thread traffic_start_camera_shake();
	param_01 thread wheel_for_hostage_car();
	param_00 maps\_anim::anim_single_solo(param_01,"hostage_truck_pass_fence");
	common_scripts\utility::flag_set("flag_start_traffic_traverse");
}

//Function Number: 277
wheel_for_hostage_car()
{
	wait(0.5);
	self setanim(%lag_takedown_van_wheels,1,0,-1);
}

//Function Number: 278
traffic_start_camera_shake()
{
	level endon("flag_highway_ledge_jump_fail");
	wait(13);
	if(common_scripts\utility::flag("flag_highway_ledge_jump_started") && !common_scripts\utility::flag("missionfailed"))
	{
		earthquake(0.4,8,level.player.origin,5000);
		wait(4);
		traffic_camera_shake_before_middle_td();
	}
}

//Function Number: 279
traffic_camera_shake_before_middle_td()
{
	var_00 = common_scripts\utility::getstruct("camera_shake_traffic_1","targetname");
	earthquake(0.2,500,var_00.origin,15000);
}

//Function Number: 280
traffic_camera_shake_after_middle_td()
{
	var_00 = common_scripts\utility::getstruct("camera_shake_traffic_2","targetname");
	earthquake(0.2,500,var_00.origin,24000);
}

//Function Number: 281
trigger_kill_player()
{
	level endon("player_fell_highway");
	level.player endon("qte_fail");
	while(!common_scripts\utility::flag("flag_highway_final_takedown_started"))
	{
		self waittill("trigger",var_00);
		if(isdefined(var_00) && isplayer(var_00) && level.player.jump_state != 2 && !common_scripts\utility::flag("flag_highway_final_takedown_started"))
		{
			earthquake(0.5,2,level.player.origin,512);
			level.player playrumbleonentity("damage_heavy");
			level.player freezecontrols(1);
			level.player kill();
			level notify("player_fell_highway");
		}
	}
}

//Function Number: 282
traffic_traverse_ledge_player_input()
{
	wait(3);
	common_scripts\utility::run_thread_on_targetname("trigger_player_ready_for_ledge_climb",::traffic_traverse_ledge_player_validation);
	var_00 = getent("traffic_traverse_mantle_point","targetname");
	var_01 = maps\_shg_utility::hint_button_position("a",var_00.origin,150,500);
	common_scripts\utility::flag_wait("flag_highway_ledge_climb_started");
	var_01 maps\_shg_utility::hint_button_clear();
}

//Function Number: 283
traffic_traverse_ledge_player_validation()
{
	level endon("flag_highway_ledge_climb_started");
	for(;;)
	{
		self waittill("trigger",var_00);
		if(isplayer(var_00))
		{
			level.player allowjump(0);
			thread maps\lagos_utility::hint_instant(&"LAGOS_BUS_JUMP_1");
			while(common_scripts\utility::flag("flag_traffic_ledge_jump_trigger"))
			{
				if(level.player jumpbuttonpressed())
				{
					thread maps\lagos_utility::hint_fade_instant();
					common_scripts\utility::flag_set("flag_highway_ledge_climb_started");
					return;
				}

				wait 0.05;
			}

			level.player allowjump(1);
			thread maps\lagos_utility::hint_fade_instant();
		}
	}
}

//Function Number: 284
traffic_traverse_start_player_input()
{
	level.traffic_ledge_jump_trigger_use = getent("traffic_ledge_jump_trigger_use","targetname");
	common_scripts\utility::run_thread_on_targetname("trigger_player_ready_for_ledge_jump",::traffic_traverse_start_player_validation);
	var_00 = level.player_bus_start maps\_shg_utility::hint_button_tag("a","tag_roof_a",900,900);
	common_scripts\utility::waittill_any_ents(level.player,"traffic_traverse_start_player",level,"flag_highway_ledge_jump_fail");
	var_00 maps\_shg_utility::hint_button_clear();
}

//Function Number: 285
traffic_traverse_start_player_validation()
{
	level.player notifyonplayercommand("traffic_traverse_start_player","+gostand");
	level.player waittill("traffic_traverse_start_player");
	level.player notifyonplayercommandremove("traffic_traverse_start_player","+gostand");
	common_scripts\utility::flag_set("flag_highway_ledge_jump_started");
}

//Function Number: 286
traffic_rooftop_traverse()
{
	common_scripts\utility::flag_wait("flag_setup_highway_vehicles");
	common_scripts\utility::array_thread(getentarray("trigger_hurt_player","targetname"),::trigger_kill_player);
	level.bus_jump_count = 1;
	level thread maps\lagos_utility::start_vehicle_traffic_highway_traverse();
	var_00 = maps\_vehicle::spawn_vehicle_from_targetname("KVA_hostage_truck_chase");
	var_01 = getvehiclenode("start_KVA_hostage_truck_chase","targetname");
	var_02 = maps\lagos_jump::spawn_vehicle_from_targetname_and_setup_jump_targets("bus_traverse_1",4,"tag_roof_a","tag_roof_b");
	var_03 = maps\lagos_jump::spawn_vehicle_from_targetname_and_setup_jump_targets("bus_traverse_2",4,"tag_roof_a","tag_roof_b");
	var_04 = maps\lagos_jump::spawn_vehicle_from_targetname_and_setup_jump_targets("bus_traverse_3",4,"tag_roof_a","tag_roof_b");
	var_05 = maps\lagos_jump::spawn_vehicle_from_targetname_and_setup_jump_targets("bus_traverse_4",4,"tag_roof_a","tag_roof_b");
	var_06 = maps\lagos_jump::spawn_vehicle_from_targetname_and_setup_jump_targets("bus_traverse_5",4,"tag_roof_a","tag_roof_b","tag_roof_c");
	var_02.vehicle_stays_alive = 1;
	var_03.vehicle_stays_alive = 1;
	var_04.vehicle_stays_alive = 1;
	var_05.vehicle_stays_alive = 1;
	var_06.vehicle_stays_alive = 1;
	thread maps\_vehicle_traffic::add_script_car(var_02,0);
	thread maps\_vehicle_traffic::add_script_car(var_03,0);
	thread maps\_vehicle_traffic::add_script_car(var_04,0);
	thread maps\_vehicle_traffic::add_script_car(var_05,0);
	thread maps\_vehicle_traffic::add_script_car(var_06,0);
	soundscripts\_snd::snd_message("handle_busses",[var_02,var_03,var_04,var_05,var_06]);
	level.player_bus_start = var_02;
	level.player_bus = var_04;
	thread traffic_suv_takedown();
	var_07 = getvehiclenode("start_bus_traverse_1","targetname");
	var_08 = getvehiclenode("start_bus_traverse_2","targetname");
	var_09 = getvehiclenode("start_bus_traverse_3","targetname");
	var_0A = getvehiclenode("start_bus_traverse_4","targetname");
	var_0B = getvehiclenode("start_bus_traverse_5","targetname");
	var_0C = getent("sb_bus_traverse_1","targetname");
	var_0D = getent("sb_bus_traverse_2","targetname");
	var_0E = getent("sb_bus_traverse_3","targetname");
	var_0F = getent("sb_bus_traverse_4","targetname");
	var_10 = getent("sb_bus_traverse_5","targetname");
	var_0C linkto(var_02);
	var_0D linkto(var_03);
	var_0E linkto(var_04);
	var_0F linkto(var_05);
	var_10 linkto(var_06);
	var_11 = getent("trigger_bus_traverse_2","targetname");
	var_12 = getent("trigger_bus_traverse_3","targetname");
	var_13 = getent("trigger_bus_traverse_4","targetname");
	var_14 = getent("trigger_bus_traverse_5","targetname");
	var_11 maps\lagos_utility::fake_linkto(var_03);
	var_12 maps\lagos_utility::fake_linkto(var_04);
	var_13 maps\lagos_utility::fake_linkto(var_05);
	var_14 maps\lagos_utility::fake_linkto(var_06);
	level.trigger_bus_traverse_5_flag_in = getent("traffic_final_takedown_trigger_in","targetname");
	level.trigger_bus_traverse_5_flag_in maps\lagos_utility::fake_linkto(var_06);
	level.trigger_bus_traverse_5_threaded = getent("trigger_player_ready_for_final_takedown","targetname");
	level.trigger_bus_traverse_5_threaded enablelinkto();
	level.trigger_bus_traverse_5_threaded linkto(var_06);
	level.trigger_bus_traverse_5_looking = getent("traffic_final_takedown_trigger_looking","targetname");
	level.trigger_bus_traverse_5_looking maps\lagos_utility::fake_linkto(var_06);
	level.final_bus = var_06;
	level.final_bus.animname = "final_bus";
	level.bus_5_hop_blocker_a = getent("bus_5_hop_blocker_a","targetname");
	level.bus_5_hop_blocker_b = getent("bus_5_hop_blocker_b","targetname");
	level.bus_5_hop_blocker_a linkto(var_06);
	level.bus_5_hop_blocker_b linkto(var_06);
	var_15 = getent("trigger_bus_traverse_2_burke","targetname");
	var_16 = getent("trigger_bus_traverse_3_burke","targetname");
	var_17 = getent("trigger_bus_traverse_4_burke","targetname");
	var_18 = getent("trigger_bus_traverse_5_burke","targetname");
	var_15 maps\lagos_utility::fake_linkto(var_03);
	var_16 maps\lagos_utility::fake_linkto(var_04);
	var_17 maps\lagos_utility::fake_linkto(var_05);
	var_18 maps\lagos_utility::fake_linkto(var_06);
	if(!isdefined(level.debugstart_middle_takedown))
	{
		common_scripts\utility::flag_wait("flag_start_traffic_traverse");
		var_02 startpath(var_07);
		var_02 vehphys_disablecrashing();
		var_03 startpath(var_08);
		var_03 vehphys_disablecrashing();
		common_scripts\utility::flag_wait("flag_highway_VM_looking_forward");
		thread traffic_suv_group_a();
		thread traffic_suv_group_b();
		thread traffic_suv_group_c();
	}

	thread traffic_suv_group_d();
	if(!isdefined(level.debugstart_middle_takedown))
	{
		traffic_vehicle_start_check("trigger_spawn_traverse_2","bus_traverse_1");
		thread traffic_burke_jump_bus_2();
		traffic_vehicle_start_check("trigger_spawn_traverse_3_start","bus_traverse_2");
		var_04 startpath(var_09);
		var_04 vehphys_disablecrashing();
		traffic_vehicle_start_check("trigger_spawn_traverse_3","bus_traverse_2");
		thread traffic_bus_3_flag_check();
		thread traffic_burke_jump_bus_3();
	}

	if(level.nextgen)
	{
		if(isdefined(level.burke_middle_takedown))
		{
			traffic_vehicle_start_check("trigger_spawn_traverse_4_start_debug","bus_traverse_3");
		}
		else
		{
			traffic_vehicle_start_check("trigger_spawn_traverse_4_start","bus_traverse_3");
		}
	}
	else
	{
		traffic_vehicle_start_check("trigger_spawn_traverse_4_start_debug","bus_traverse_3");
	}

	var_05 startpath(var_0A);
	var_05 vehphys_disablecrashing();
	traffic_vehicle_start_check("trigger_spawn_traverse_4","bus_traverse_3");
	thread traffic_burke_jump_bus_4();
	traffic_vehicle_start_check("trigger_spawn_traverse_5_start","bus_traverse_4");
	var_06 startpath(var_0B);
	var_06 vehphys_disablecrashing();
	var_00 startpath(var_01);
	traffic_vehicle_start_check("trigger_spawn_traverse_5","bus_traverse_4");
	thread traffic_burke_jump_bus_5();
	common_scripts\utility::flag_wait("flag_bus_traverse_5_start_takedown");
	var_00 delete();
}

//Function Number: 287
test_look_b()
{
	for(;;)
	{
		var_00 = common_scripts\utility::flag("flag_lookat_highway_enemies_B");
		if(var_00)
		{
			iprintlnbold("B FLAG");
			return;
		}

		wait 0.05;
	}
}

//Function Number: 288
test_look_c()
{
	for(;;)
	{
		var_00 = common_scripts\utility::flag("flag_lookat_highway_enemies_C");
		if(var_00)
		{
			iprintlnbold("C FLAG");
			return;
		}

		wait 0.05;
	}
}

//Function Number: 289
traffic_vehicle_start_check(param_00,param_01)
{
	var_02 = getent(param_00,"targetname");
	for(;;)
	{
		var_02 waittill("trigger",var_03);
		if(isdefined(var_03) && var_03 maps\_vehicle::isvehicle() && var_03.vehicle_spawner.targetname == param_01)
		{
			return;
		}
	}
}

//Function Number: 290
traffic_bus_start_check_old(param_00,param_01)
{
	common_scripts\utility::flag_clear(param_00);
	for(;;)
	{
		var_02 = common_scripts\utility::flag_wait(param_00);
		if(var_02.vehicle_spawner.targetname == param_01)
		{
			return;
		}
		else
		{
			common_scripts\utility::flag_clear(param_00);
		}
	}
}

//Function Number: 291
traffic_burke_jump_settings(param_00)
{
	level.burke_bus_goal = param_00;
	if(isdefined(level.bus_jump_count))
	{
		level.bus_jump_count++;
	}

	level.burke notify("abort_reload");
	level.burke maps\_utility::set_ignoreall(1);
	level.burke.ignoreme = 1;
	level.burke maps\_utility::set_goal_node(param_00);
	level.burke waittill("traverse_finish");
	level.burke maps\_utility::set_ignoreall(0);
	level.burke.ignoreme = 0;
	if(isdefined(level.bus_jump_count))
	{
		thread traffic_burke_miss_failsafe();
	}
}

//Function Number: 292
traffic_burke_miss_failsafe()
{
	wait(8);
	if(!common_scripts\utility::flag("flag_bus_traverse_" + level.bus_jump_count + "_burke"))
	{
		traffic_burke_recover_failed_jump();
	}
}

//Function Number: 293
traffic_burke_recover_failed_jump()
{
	level.burke maps\_utility::teleport_ai(level.burke_bus_goal);
}

//Function Number: 294
traffic_burke_jump_bus_2()
{
	wait(1);
	thread maps\lagos_vo::highway_traffic_jump_2_dialogue();
	wait(1);
	var_00 = getnode("cover_bus_traverse_2","targetname");
	traffic_burke_jump_settings(var_00);
}

//Function Number: 295
traffic_burke_jump_bus_3()
{
	thread maps\lagos_vo::highway_traffic_jump_3_dialogue();
	wait(1);
	var_00 = getnode("cover_bus_traverse_3","targetname");
	traffic_burke_jump_settings(var_00);
}

//Function Number: 296
traffic_burke_jump_bus_4()
{
	wait(1);
	thread maps\lagos_vo::highway_traffic_jump_4_dialogue();
	wait(1);
	var_00 = getnode("cover_bus_traverse_4","targetname");
	traffic_burke_jump_settings(var_00);
}

//Function Number: 297
traffic_burke_jump_bus_5()
{
	wait(1.5);
	thread maps\lagos_vo::highway_traffic_jump_5_dialogue();
	wait(1);
	var_00 = getnode("cover_bus_traverse_5","targetname");
	traffic_burke_jump_settings(var_00);
}

//Function Number: 298
traffic_bus_3_flag_check()
{
	common_scripts\utility::flag_wait("flag_bus_traverse_3");
	wait(1);
	common_scripts\utility::flag_set("flag_begin_suv_takedown");
}

//Function Number: 299
traffic_link_luggage(param_00,param_01,param_02)
{
	foreach(var_04 in param_01)
	{
		if(var_04.classname == "script_origin")
		{
			param_00 = var_04;
		}
	}

	foreach(var_04 in param_01)
	{
		if(var_04.classname != "script_origin")
		{
			var_04 linkto(param_00);
		}
	}

	param_00 linkto(param_02);
}

//Function Number: 300
traffic_suv_group_a()
{
	traffic_vehicle_start_check("trigger_enemy_suv_A","bus_traverse_1");
	if(!common_scripts\utility::flag("flag_lookat_highway_enemies_A"))
	{
		var_00 = maps\_vehicle::spawn_vehicle_from_targetname_and_drive("traffic_enemy_suv_A1");
	}
	else
	{
		var_00 = maps\_vehicle::spawn_vehicle_from_targetname_and_drive("traffic_enemy_suv_A1_ALT");
	}

	var_00 maps\_vehicle::vehicle_set_health(3000);
	var_00 soundscripts\_snd::snd_message("bus_chase_suv_oneshots");
	var_00 thread maps\lagos_utility::handle_vehicle_death();
	thread maps\_vehicle_traffic::add_script_car(var_00);
	thread maps\lagos_vo::highway_traffic_first_suvs();
}

//Function Number: 301
traffic_suv_group_b()
{
	traffic_vehicle_start_check("trigger_enemy_suv_B","bus_traverse_2");
	var_00 = common_scripts\utility::flag("flag_lookat_highway_enemies_B");
	if(!common_scripts\utility::flag("flag_lookat_highway_enemies_B") && !common_scripts\utility::flag("flag_lookat_highway_enemies_B_behind"))
	{
		var_01 = maps\_vehicle::spawn_vehicle_from_targetname_and_drive("traffic_enemy_suv_B1");
	}
	else if(!common_scripts\utility::flag("flag_lookat_highway_enemies_B_behind"))
	{
		var_01 = maps\_vehicle::spawn_vehicle_from_targetname_and_drive("traffic_enemy_suv_B1_ALT");
	}
	else
	{
		var_01 = maps\_vehicle::spawn_vehicle_from_targetname_and_drive("traffic_enemy_suv_B1_ALT_2");
	}

	var_01 maps\_vehicle::vehicle_set_health(3000);
	var_01 soundscripts\_snd::snd_message("bus_chase_suv_oneshots");
	var_01 thread maps\lagos_utility::handle_vehicle_death();
	thread maps\_vehicle_traffic::add_script_car(var_01);
}

//Function Number: 302
traffic_suv_group_c()
{
	traffic_vehicle_start_check("trigger_enemy_suv_C","bus_traverse_2");
	var_00 = common_scripts\utility::flag("flag_lookat_highway_enemies_C");
	if(!common_scripts\utility::flag("flag_lookat_highway_enemies_C"))
	{
		var_01 = maps\_vehicle::spawn_vehicle_from_targetname_and_drive("traffic_enemy_suv_C1");
	}
	else
	{
		var_01 = maps\_vehicle::spawn_vehicle_from_targetname_and_drive("traffic_enemy_suv_C1_ALT");
	}

	var_01 maps\_vehicle::vehicle_set_health(3000);
	var_01 soundscripts\_snd::snd_message("bus_chase_suv_oneshots");
	var_01 thread maps\lagos_utility::handle_vehicle_death();
	thread maps\_vehicle_traffic::add_script_car(var_01);
}

//Function Number: 303
traffic_suv_group_d()
{
	traffic_vehicle_start_check("trigger_enemy_helicopter","bus_traverse_3");
	traffic_helicopter();
}

//Function Number: 304
traffic_suv_group_e()
{
	traffic_vehicle_start_check("trigger_enemy_suv_E","bus_traverse_5");
	var_00 = maps\_vehicle::spawn_vehicle_from_targetname_and_drive("traffic_enemy_suv_E1");
	var_00 maps\_vehicle::vehicle_set_health(3000);
	var_00 soundscripts\_snd::snd_message("bus_chase_suv_oneshots");
	var_00 thread maps\lagos_utility::handle_vehicle_death();
	var_01 = maps\_vehicle::spawn_vehicle_from_targetname_and_drive("traffic_enemy_suv_E2");
	var_01 maps\_vehicle::vehicle_set_health(3000);
	var_01 soundscripts\_snd::snd_message("bus_chase_suv_oneshots");
	var_01 thread maps\lagos_utility::handle_vehicle_death();
	thread maps\_vehicle_traffic::add_script_car(var_01);
}

//Function Number: 305
traffic_suv_takedown()
{
	level.player endon("death");
	common_scripts\utility::flag_wait("flag_begin_suv_takedown");
	maps\lagos_qte_middle::setup_vehicles_for_middle_takedown();
	var_00 = getent("KVA_0_middle_takedown","targetname") maps\_utility::spawn_ai(1);
	var_01 = getent("KVA_1_middle_takedown","targetname") maps\_utility::spawn_ai(1);
	var_02 = getent("KVA_3_middle_takedown","targetname") maps\_utility::spawn_ai(1);
	var_00.ignoreall = 1;
	var_01.ignoreall = 1;
	var_02.ignoreall = 1;
	var_00.animname = "KVA_0";
	var_01.animname = "KVA_1";
	var_02.animname = "KVA_3";
	var_01 thread maps\lagos_utility::challenge_point_award_on_damage();
	var_02 thread maps\lagos_utility::challenge_point_award_on_damage();
	var_03 = maps\_utility::spawn_anim_model("player_rig");
	var_04 = getent("anim_org_middle_takedown","targetname");
	thread maps\lagos_vo::highway_traffic_middle_takedown_dialogue();
	common_scripts\utility::flag_clear("flag_player_traversing_traffic");
	thread maps\lagos_qte_middle::takedown_qte_middle(var_04,var_00,var_01,var_02,var_03,level.player_bus,level.kva_truck);
	wait(2);
	if(isdefined(level.burke_middle_takedown))
	{
		if(level.burke_middle_takedown)
		{
			var_05 = getnode("cover_bus_traverse_3","targetname");
			level.burke maps\_utility::teleport_ai(var_05);
		}
	}
}

//Function Number: 306
traffic_helicopter()
{
	level.helo = maps\_vehicle::spawn_vehicle_from_targetname_and_drive("KVA_helicopter_1");
	level.helo maps\_vehicle::vehicle_set_health(4200);
	level.helo endon("death");
	thread maps\lagos_vo::highway_traffic_helo_callout();
	level.vehicle_aianims["script_vehicle_littlebird_kva_armed"][2].explosion_death = %death_explosion_stand_f_v1;
	level.vehicle_aianims["script_vehicle_littlebird_kva_armed"][3].explosion_death = %death_explosion_stand_f_v2;
	level.vehicle_aianims["script_vehicle_littlebird_kva_armed"][4].explosion_death = %death_explosion_stand_f_v3;
	level.vehicle_aianims["script_vehicle_littlebird_kva_armed"][5].explosion_death = %death_explosion_stand_f_v4;
	level.vehicle_aianims["script_vehicle_littlebird_kva_armed"][6].explosion_death = %death_explosion_stand_f_v1;
	level.vehicle_aianims["script_vehicle_littlebird_kva_armed"][7].explosion_death = %death_explosion_stand_f_v2;
	level.helo soundscripts\_snd::snd_message("spawn_traffic_helicopter");
	var_00 = getent("heli_bullet_source_left","targetname");
	var_00 linkto(level.helo);
	var_01 = getent("heli_bullet_source_right","targetname");
	var_01 linkto(level.helo);
	level.burke.baseaccuracy = 0.05;
	level.player maps\_utility::add_damage_function(::highway_veteran_helo_reduction);
	wait(3);
	level.helo thread traffic_helicopter_magic_bullet_fire(var_01,"flag_traffic_helicopter_stop_right");
	wait(4);
	common_scripts\utility::flag_set("flag_traffic_helicopter_stop_right");
	wait(3);
	level.helo thread traffic_helicopter_magic_bullet_fire(var_00,"flag_traffic_helicopter_stop_left");
	common_scripts\utility::flag_wait("flag_kill_helicopter");
	common_scripts\utility::flag_set("flag_traffic_helicopter_stop_left");
	if(isdefined(level.helo) || isalive(level.helo))
	{
		level.helo notify("death");
	}

	level.player maps\_utility::remove_damage_function(::highway_veteran_helo_reduction);
}

//Function Number: 307
highway_veteran_helo_reduction(param_00,param_01,param_02,param_03,param_04,param_05,param_06)
{
	if(param_04 == "MOD_RIFLE_BULLET" && maps\_utility::getdifficulty() == "fu" || maps\_utility::getdifficulty() == "hard")
	{
		param_00 = level.player.maxhealth * 0.152 / level.player.damagemultiplier;
	}
}

//Function Number: 308
traffic_helicopter_magic_bullet_fire(param_00,param_01)
{
	self endon("death");
	var_02 = 0;
	var_03 = level.burke.origin;
	while(!common_scripts\utility::flag(param_01))
	{
		if(!isdefined(level.helo) || !isalive(level.helo) || isdefined(level.helo.crashing))
		{
			return;
		}

		if(var_02 == 0)
		{
			var_03 = level.burke.origin + 75 * anglestoright(level.burke.origin);
		}
		else if(var_02 == 1)
		{
			var_03 = level.burke.origin - 75 * anglestoright(level.burke.origin);
		}
		else if(var_02 == 2)
		{
			var_03 = level.player.origin + 75 * anglestoforward(level.burke.origin);
		}
		else if(var_02 == 3)
		{
			var_03 = level.burke.origin - 75 * anglestoforward(level.burke.origin);
		}
		else if(var_02 == 4)
		{
			var_03 = level.player.origin + 60 * anglestoup(level.player.angles);
		}
		else if(var_02 == 5)
		{
			var_03 = level.burke.origin + 75 * anglestoforward(level.burke.origin);
		}
		else if(var_02 == 6)
		{
			var_03 = level.burke.origin - 75 * anglestoright(level.burke.origin);
		}
		else if(var_02 == 7)
		{
			var_03 = level.player.origin - 75 * anglestoright(level.burke.origin);
		}
		else if(var_02 == 8)
		{
			var_03 = level.player.origin;
		}

		magicbullet("iw5_bal27_sp",param_00.origin,var_03);
		soundscripts\_snd::snd_message("chase_heli_fire");
		wait(0.15);
		var_02++;
		if(var_02 > 8)
		{
			var_02 = 0;
		}
	}
}

//Function Number: 309
traffic_takedown()
{
	common_scripts\utility::flag_wait("flag_bus_traverse_5_start_takedown");
	thread maps\lagos_lighting::ramp_down_motion_blur();
	if(isdefined("traffic_weapons"))
	{
		level.player maps\_utility::restore_players_weapons("traffic_weapons");
	}

	thread maps\_player_exo::player_exo_deactivate();
	thread maps\lagos_vo::highway_traffic_takedown_dialogue();
	var_00 = getent("anim_org_takedown","targetname");
	var_01 = maps\_utility::spawn_anim_model("player_rig",(-7582.65,53106.6,1405.83),(0,209.996,0));
	var_01 hide();
	if(!common_scripts\utility::flag("takedown_playerstart"))
	{
		level waittill("bus_jump_player_landed");
		level.player notify("exo_jump_process_end");
		level.bus_5_hop_blocker_a delete();
		level.bus_5_hop_blocker_b delete();
		thread maps\lagos_utility::start_end_takedown_highway_path_player_side();
		var_00 maps\lagos_qte::setup_vehicles_for_takedown();
		var_00 maps\_anim::anim_first_frame_solo(level.hostage_truck,"hostage_truck_takedown_pt1");
		level.player unlink();
		var_01.origin = getstartorigin(level.hostage_truck gettagorigin("tag_body"),level.hostage_truck gettagangles("tag_body"),var_01 maps\_utility::getanim("hostage_truck_takedown_pt0"));
		var_01 dontcastshadows();
		level.hostage_truck maps\_anim::anim_first_frame_solo(var_01,"hostage_truck_takedown_pt0","tag_body");
		var_00 maps\_anim::anim_first_frame_solo(level.final_bus,"hostage_truck_takedown_pt1");
		var_01 linkto(level.hostage_truck,"tag_body");
		level.player setorigin(var_01 gettagorigin("tag_player"));
		level.player playerlinktoabsolute(var_01,"tag_player");
		var_01 show();
		level.hostage_truck thread maps\_anim::anim_single_solo(var_01,"hostage_truck_takedown_pt0","tag_body");
		var_02 = getanimlength(var_01 maps\_utility::getanim("hostage_truck_takedown_pt0"));
		level.player common_scripts\utility::delaycall(var_02,::unlink);
		var_01 common_scripts\utility::delaycall(var_02,::hide);
		level.player maps\_utility::delaythread(var_02,::maps\_shg_utility::setup_player_for_gameplay);
		earthquake(1,0.5,level.player.origin,10000);
		if(isdefined(level.jumping_rig))
		{
			level.jumping_rig delete();
		}
	}
	else
	{
		var_00 maps\lagos_qte::setup_vehicles_for_takedown();
	}

	var_01 show();
	level.player notifyonplayercommandremove("exo_jump_button","+gostand");
	if(!common_scripts\utility::flag("takedown_playerstart"))
	{
		thread maps\_utility::autosave_now_silent();
		var_03 = [];
		var_03[var_03.size] = level.final_bus;
		var_03[var_03.size] = level.hostage_truck;
		var_00 thread maps\_anim::anim_single_solo(level.final_bus,"hostage_truck_takedown_pt1");
		var_00 thread traffic_traverse_final_takedown_truck_start(level.hostage_truck);
		level.burke thread traffic_traverse_final_takedown_burke_start();
		thread traffic_traverse_final_takedown_start_player_input();
		common_scripts\utility::flag_wait("flag_highway_final_takedown_started");
	}
	else
	{
		common_scripts\utility::flag_set("flag_highway_final_takedown_started");
	}

	setsaveddvar("g_friendlynamedist",0);
	common_scripts\utility::flag_clear("flag_player_traversing_traffic");
	if(!isdefined(level.burke))
	{
		level.burke = getent("burke_takedown","targetname") maps\_utility::spawn_ai(1,1);
	}

	var_04 = getent("KVA_1_takedown","targetname") maps\_utility::spawn_ai(1);
	var_05 = getent("KVA_2_takedown","targetname") maps\_utility::spawn_ai(1);
	level.hostage_1 = getent("hostage_1_takedown","targetname") maps\_utility::spawn_ai(1,1);
	var_06 = getent("hostage_2_takedown","targetname") maps\_utility::spawn_ai(1,1);
	var_07 = getent("hostage_3_takedown","targetname") maps\_utility::spawn_ai(1,1);
	var_08 = getent("oncoming_driver_takedown","targetname") maps\_utility::spawn_ai(1);
	var_06.ignoreall = 1;
	var_07.ignoreall = 1;
	var_06.ignoreme = 1;
	var_07.ignoreme = 1;
	var_04 maps\_utility::gun_remove();
	var_05 maps\_utility::gun_remove();
	var_04 maps\_utility::place_weapon_on("iw5_kf5_sp","right");
	var_05 maps\_utility::place_weapon_on("iw5_kf5_sp","right");
	var_04.weapon = "iw5_kf5_sp";
	var_05.weapon = "iw5_kf5_sp";
	level.burke.ignoreall = 1;
	level.burke.animname = "burke";
	var_04.animname = "KVA_1";
	var_05.animname = "KVA_2";
	level.hostage_1.animname = "hostage_1";
	var_06.animname = "hostage_2";
	var_07.animname = "hostage_3";
	var_08.animname = "oncoming_driver";
	var_04.ignoreall = 1;
	var_05.ignoreall = 1;
	var_04.health = 1;
	var_05.health = 1;
	var_04 thread maps\lagos_utility::challenge_point_award_on_damage();
	var_05 thread maps\lagos_utility::challenge_point_award_on_damage();
	maps\lagos_utility::disable_exo_for_highway();
	thread maps\lagos_qte::takedown_qte(var_00,level.burke,var_04,var_05,level.hostage_1,var_06,var_07,var_08,var_01,level.hostage_truck,level.hostage_truck_oncoming);
	level waittill("swimming_start");
	common_scripts\utility::flag_set("obj_progress_pursue_hostage_truck_highway_swim");
	thread enable_player_swimming();
	thread lagos_player_swimming_pt1();
	thread lagos_player_swimming_pt2();
	level waittill("swimming_fade");
	level.player enableinvulnerability();
	var_09 = 3;
	thread maps\_hud_util::fade_out(var_09,"black");
	var_01 common_scripts\utility::delaycall(var_09,::delete);
	thread shore_pcap();
	maps\_utility::notify_delay("swimming_end",var_09);
}

//Function Number: 310
traffic_traverse_final_takedown_truck_start(param_00)
{
	level endon("flag_player_hold_on");
	level endon("flag_highway_final_takedown_started");
	thread maps\_anim::anim_single_solo(param_00,"hostage_truck_takedown_pt1");
	param_00 thread wheel_for_hostage_car();
	level waittill("hostage_truck_takedown_pt1_fail");
	level notify("traffic_traverse_final_takedown_jump_failed");
	setdvar("ui_deadquote",&"LAGOS_BUS_JUMP_FAILED");
	thread maps\_utility::missionfailedwrapper();
}

//Function Number: 311
traffic_traverse_final_takedown_burke_start()
{
	level endon("flag_player_hold_on");
	level.burke linkto(level.hostage_truck,"tag_body");
	level.hostage_truck maps\_anim::anim_single_solo(level.burke,"lag_truck_takedown_pt1_into","tag_body");
	level.player.jump_state = 0;
	level.hostage_truck maps\_anim::anim_loop_solo(level.burke,"lag_truck_takedown_pt1_burke_loop",undefined,"tag_body");
}

//Function Number: 312
traffic_traverse_final_takedown_start_player_input()
{
	var_00 = 600;
	common_scripts\utility::run_thread_on_targetname("trigger_player_ready_for_final_takedown",::traffic_traverse_final_takedown_start_player_validation,var_00);
	var_01 = level.hostage_truck maps\_shg_utility::hint_button_tag("a","tag_mirror_right",900,900);
	common_scripts\utility::flag_wait("flag_highway_final_takedown_started");
	soundscripts\_snd::snd_message("final_takedown_abutton_hit");
	thread maps\lagos_lighting::ramp_up_motion_blur();
	var_01 maps\_shg_utility::hint_button_clear();
}

//Function Number: 313
traffic_traverse_final_takedown_start_player_validation(param_00)
{
	level.player notifyonplayercommand("final_takedown_jump","+gostand");
	level endon("flag_highway_final_takedown_started");
	level endon("traffic_traverse_final_takedown_jump_failed");
	for(;;)
	{
		while(!level.player isonground())
		{
			wait(0.05);
		}

		level.player waittill("final_takedown_jump");
		if(traffic_player_hostage_truck_jump_passed(param_00))
		{
			common_scripts\utility::flag_set("flag_highway_final_takedown_started");
		}
	}
}

//Function Number: 314
traffic_player_hostage_truck_jump_passed(param_00)
{
	if(level.player worldpointinreticle_circle(level.hostage_truck.origin + (0,0,72),65,500))
	{
		if(distance(level.player.origin,level.hostage_truck.origin) <= param_00)
		{
			if(level.player getnormalizedmovement()[0] > 0.5)
			{
				if(common_scripts\utility::flag("flag_traffic_final_takedown_trigger_in"))
				{
					return 1;
				}
			}
		}
	}

	return 0;
}

//Function Number: 315
shore_pcap(param_00)
{
	common_scripts\utility::flag_set("obj_complete_pursue_hostage_truck");
	thread maps\_player_exo::player_exo_deactivate();
	level.player enableslowaim(0.2,0.2);
	if(isdefined(param_00))
	{
		wait(param_00);
	}
	else
	{
		wait(6);
	}

	var_01 = 55;
	level.player lerpfov(var_01,0.1);
	if(!isdefined(level.burke))
	{
		level.burke = getent("burke_takedown","targetname") maps\_utility::spawn_ai(1,1);
	}

	if(!isdefined(level.hostage_1))
	{
		level.hostage_1 = getent("hostage_1_takedown","targetname") maps\_utility::spawn_ai(1);
	}

	var_02 = getent("joker_takedown","targetname") maps\_utility::spawn_ai(1,1);
	var_03 = getent("ajani_takedown","targetname") maps\_utility::spawn_ai(1,1);
	var_02.animname = "joker";
	var_03.animname = "ajani";
	level.hostage_1.animname = "hostage_1";
	var_04 = maps\_utility::spawn_anim_model("player_rig");
	level.player maps\_shg_utility::setup_player_for_scene();
	var_05 = getent("anim_org_takedown","targetname");
	thread maps\_hud_util::fade_in(3,"black");
	thread maps\lagos_vo::pcap_shore_outro();
	var_06 = [level.burke,var_02,var_03,var_04,level.hostage_1];
	level.player playerlinktodelta(var_04,"tag_player",1,7,7,5,5,1);
	wait 0.05;
	soundscripts\_snd::snd_message("shore_ending");
	level.hostage_1 attach("npc_bal27_nocamo","TAG_WEAPON_RIGHT",0);
	var_05 thread maps\_anim::anim_single(var_06,"hostage_truck_takedown_pt5");
	thread maps\lagos_fx::vfx_shore_outro_start();
	common_scripts\utility::flag_set("shoreline_lighting");
	maps\lagos_utility::prep_cinematic("fusion_endlogo");
	wait(30);
	var_07 = 2;
	thread maps\lagos_utility::ending_fade_out(var_07);
	thread maps\_utility::battlechatter_off("allies");
	thread maps\_utility::battlechatter_off("axis");
	wait(var_07);
	level.player freezecontrols(1);
	level.player unlink();
	var_04 delete();
	maps\_utility::nextmission();
}

//Function Number: 316
enable_player_swimming()
{
	thread disable_player_swimming();
	level.player disableweapons();
	level.player disableinvulnerability();
}

//Function Number: 317
disable_player_swimming()
{
	level waittill("swimming_end");
}

//Function Number: 318
lagos_player_swimming_pt1()
{
	level waittill("latch_opened");
	level notify("pry_check_success");
	level notify("swimming_saved");
}

//Function Number: 319
lagos_player_swimming_pt2()
{
	level waittill("swimming_saved");
	common_scripts\utility::flag_wait("player_swimming_end");
	level notify("swimming_shore");
}

//Function Number: 320
lagos_player_swimming_truck_anims()
{
	wait 0.05;
}

//Function Number: 321
hostage_truck_swimming_drowning_monitor(param_00)
{
	level endon("swimming_saved");
	level endon("swimming_shore");
	wait(15);
	for(var_01 = 0;!common_scripts\utility::flag(param_00);var_01++)
	{
		level.player dodamage(10,level.player.origin);
		if(var_01 == 1 || var_01 == 4 || var_01 == 8)
		{
		}

		wait(1);
	}
}

//Function Number: 322
traffic_traverse_fail_check()
{
	level.player endon("death");
	var_00 = 1210000;
	while(common_scripts\utility::flag("flag_player_traversing_traffic") && isdefined(level.bus_jump_count))
	{
		if(distance2dsquared(level.player.origin,level.burke.origin) > var_00)
		{
			if(level.bus_jump_count > 1 && !common_scripts\utility::flag("flag_bus_traverse_" + level.bus_jump_count + "_burke"))
			{
				traffic_burke_recover_failed_jump();
			}
		}

		if(distance2dsquared(level.player.origin,level.burke.origin) > var_00)
		{
			common_scripts\utility::flag_clear("flag_player_traversing_traffic");
			setdvar("ui_deadquote",&"LAGOS_BUS_JUMP_FAILED");
			maps\_utility::missionfailedwrapper();
		}

		wait(0.25);
	}
}

//Function Number: 323
player_upkeep()
{
	level.player givemaxammo("iw5_bal27_sp_variablereddot");
}

//Function Number: 324
level_bounds()
{
	thread level_bounds_nag();
	thread level_bounds_fail();
}

//Function Number: 325
level_bounds_nag()
{
	var_00 = 0;
	for(;;)
	{
		if(common_scripts\utility::flag("flag_level_bounds_nag"))
		{
			while(common_scripts\utility::flag("flag_level_bounds_nag"))
			{
				thread maps\lagos_vo::level_bounds_nag_vo(var_00);
				thread maps\lagos_utility::hint_instant(&"LAGOS_BOUNDS_WARNING",8);
				wait(8);
				var_00++;
				if(var_00 > 2)
				{
					var_00 = 0;
				}
			}
		}

		wait 0.05;
	}
}

//Function Number: 326
level_bounds_fail()
{
	for(;;)
	{
		if(common_scripts\utility::flag("flag_level_bounds_fail"))
		{
			level notify("level_bounds_fail");
			setdvar("ui_deadquote",&"LAGOS_BOUNDS_FAIL");
			maps\_utility::missionfailedwrapper();
			return;
		}

		wait(1);
	}
}

//Function Number: 327
level_progress()
{
	thread level_progress_exodoor();
	thread level_progress_monorail();
	thread level_progress_govexit();
	thread level_progress_roundaboutcombat();
	thread level_progress_alley1combat();
	thread level_progress_oncomingcombat();
	thread level_progress_flankcombat();
	thread level_progress_froggercombat();
	thread level_progress_froggercomplete();
}

//Function Number: 328
level_progress_nag(param_00)
{
	var_01 = 0;
	for(;;)
	{
		if(common_scripts\utility::flag(param_00))
		{
			while(common_scripts\utility::flag(param_00))
			{
				thread maps\lagos_vo::level_bounds_nag_vo(var_01);
				thread maps\lagos_utility::hint_instant(&"LAGOS_BOUNDS_WARNING",8);
				wait(8);
				var_01++;
				if(var_01 > 2)
				{
					var_01 = 0;
				}
			}
		}

		wait 0.05;
	}
}

//Function Number: 329
level_progress_fail(param_00)
{
	level endon("level_bounds_fail");
	for(;;)
	{
		if(common_scripts\utility::flag(param_00))
		{
			wait 0.05;
			setdvar("ui_deadquote",&"LAGOS_BOUNDS_FAIL");
			maps\_utility::missionfailedwrapper();
			return;
		}

		wait(1);
	}
}

//Function Number: 330
level_progress_exodoor()
{
	var_00 = getent("level_progress_exoDoor_nag","targetname");
	var_01 = getent("level_progress_exoDoor_fail","targetname");
	var_00 common_scripts\utility::trigger_off();
	var_01 common_scripts\utility::trigger_off();
	common_scripts\utility::flag_wait("flag_level_progress_exoDoor");
	wait(2);
	var_00 common_scripts\utility::trigger_on();
	var_01 common_scripts\utility::trigger_on();
	thread level_progress_nag("flag_level_progress_exoDoor_nag");
	thread level_progress_fail("flag_level_progress_exoDoor_fail");
}

//Function Number: 331
level_progress_monorail()
{
	var_00 = getent("level_progress_monorail_nag","targetname");
	var_01 = getent("level_progress_monorail_fail","targetname");
	var_00 common_scripts\utility::trigger_off();
	var_01 common_scripts\utility::trigger_off();
	common_scripts\utility::flag_wait("flag_level_progress_monorail");
	wait(2);
	var_00 common_scripts\utility::trigger_on();
	var_01 common_scripts\utility::trigger_on();
	thread level_progress_nag("flag_level_progress_monorail_nag");
	thread level_progress_fail("flag_level_progress_monorail_fail");
}

//Function Number: 332
level_progress_govexit()
{
	var_00 = getent("level_progress_govExit_nag","targetname");
	var_01 = getent("level_progress_govExit_fail","targetname");
	var_00 common_scripts\utility::trigger_off();
	var_01 common_scripts\utility::trigger_off();
	common_scripts\utility::flag_wait("flag_level_progress_govExit");
	var_00 common_scripts\utility::trigger_on();
	var_01 common_scripts\utility::trigger_on();
	thread level_progress_nag("flag_level_progress_govExit_nag");
	thread level_progress_fail("flag_level_progress_govExit_fail");
}

//Function Number: 333
level_progress_roundaboutcombat()
{
	var_00 = getent("level_progress_roundaboutCombat_nag","targetname");
	var_01 = getent("level_progress_roundaboutCombat_fail","targetname");
	var_02 = getent("level_progress_roundaboutCombat_bypass_nag","targetname");
	var_03 = getent("level_progress_roundaboutCombat_bypass_fail","targetname");
	var_00 common_scripts\utility::trigger_off();
	var_01 common_scripts\utility::trigger_off();
	var_02 common_scripts\utility::trigger_off();
	var_03 common_scripts\utility::trigger_off();
	common_scripts\utility::flag_wait("flag_level_progress_roundaboutCombat");
	var_00 common_scripts\utility::trigger_on();
	var_01 common_scripts\utility::trigger_on();
	var_02 common_scripts\utility::trigger_on();
	var_03 common_scripts\utility::trigger_on();
	thread level_progress_nag("flag_level_progress_roundaboutCombat_nag");
	thread level_progress_fail("flag_level_progress_roundaboutCombat_fail");
	thread level_progress_nag("flag_level_progress_roundaboutCombat_bypass_nag");
	thread level_progress_fail("flag_level_progress_roundaboutCombat_bypass_fail");
	common_scripts\utility::flag_wait("obj_progress_find_hostage_truck_roundabout_complete");
	var_02 common_scripts\utility::trigger_off();
	var_03 common_scripts\utility::trigger_off();
}

//Function Number: 334
level_progress_alley1combat()
{
	var_00 = getent("level_progress_alley1Combat_nag","targetname");
	var_01 = getent("level_progress_alley1Combat_fail","targetname");
	var_00 common_scripts\utility::trigger_off();
	var_01 common_scripts\utility::trigger_off();
	common_scripts\utility::flag_wait("flag_level_progress_alley1Combat");
	common_scripts\utility::flag_wait("flag_level_progress_alley1Combat_squad");
	var_00 common_scripts\utility::trigger_on();
	var_01 common_scripts\utility::trigger_on();
	thread level_progress_nag("flag_level_progress_alley1Combat_nag");
	thread level_progress_fail("flag_level_progress_alley1Combat_fail");
}

//Function Number: 335
level_progress_oncomingcombat()
{
	var_00 = getent("level_progress_oncomingCombat_nag","targetname");
	var_01 = getent("level_progress_oncomingCombat_fail","targetname");
	var_00 common_scripts\utility::trigger_off();
	var_01 common_scripts\utility::trigger_off();
	common_scripts\utility::flag_wait("oncoming_alley_player_pos");
	var_00 common_scripts\utility::trigger_on();
	var_01 common_scripts\utility::trigger_on();
	thread level_progress_nag("flag_level_progress_oncomingCombat_nag");
	thread level_progress_fail("flag_level_progress_oncomingCombat_fail");
}

//Function Number: 336
level_progress_flankcombat()
{
	var_00 = getent("level_progress_flankCombat_nag","targetname");
	var_01 = getent("level_progress_flankCombat_fail","targetname");
	var_00 common_scripts\utility::trigger_off();
	var_01 common_scripts\utility::trigger_off();
	common_scripts\utility::flag_wait("flag_level_progress_flankCombat");
	var_00 common_scripts\utility::trigger_on();
	var_01 common_scripts\utility::trigger_on();
	thread level_progress_nag("flag_level_progress_flankCombat_nag");
	thread level_progress_fail("flag_level_progress_flankCombat_fail");
}

//Function Number: 337
level_progress_froggercombat()
{
	var_00 = getent("level_progress_froggerCombat_nag","targetname");
	var_01 = getent("level_progress_froggerCombat_fail","targetname");
	var_00 common_scripts\utility::trigger_off();
	var_01 common_scripts\utility::trigger_off();
	common_scripts\utility::flag_wait("flag_level_progress_froggerCombat");
	var_00 common_scripts\utility::trigger_on();
	var_01 common_scripts\utility::trigger_on();
	thread level_progress_nag("flag_level_progress_froggerCombat_nag");
	thread level_progress_fail("flag_level_progress_froggerCombat_fail");
}

//Function Number: 338
level_progress_froggercomplete()
{
	var_00 = getent("level_progress_froggerComplete_nag","targetname");
	var_01 = getent("level_progress_froggerComplete_fail","targetname");
	var_00 common_scripts\utility::trigger_off();
	var_01 common_scripts\utility::trigger_off();
	common_scripts\utility::flag_wait("flag_level_progress_froggerComplete");
	var_00 common_scripts\utility::trigger_on();
	var_01 common_scripts\utility::trigger_on();
	thread level_progress_nag("flag_level_progress_froggerComplete_nag");
	thread level_progress_fail("flag_level_progress_froggerComplete_fail");
}

//Function Number: 339
notetrack_gov_wall_climb_intro_right_start(param_00)
{
	level.player playrumbleonentity("damage_light");
}

//Function Number: 340
notetrack_gov_wall_climb_intro_left_start(param_00)
{
	level.player playrumbleonentity("damage_light");
}

//Function Number: 341
notetrack_gov_wall_climb_intro_right_plant(param_00)
{
	level.player playrumbleonentity("artillery_rumble");
}

//Function Number: 342
notetrack_gov_wall_climb_intro_left_plant(param_00)
{
	level.player playrumbleonentity("artillery_rumble");
}

//Function Number: 343
notetrack_roof_breach_medium(param_00)
{
	level.player playrumbleonentity("damage_heavy");
}

//Function Number: 344
notetrack_roof_breach_small(param_00)
{
	level.player playrumbleonentity("damage_light");
	wait(4);
	level.player playrumbleonentity("damage_heavy");
}

//Function Number: 345
notetrack_roof_breach_large(param_00)
{
	wait(0.5);
	level.player playrumbleonentity("artillery_rumble");
}

//Function Number: 346
notetrack_roof_breach_land(param_00)
{
	level.player playrumbleonentity("artillery_rumble");
}

//Function Number: 347
notetrack_h_breach_small(param_00)
{
	level.player playrumbleonentity("damage_light");
}

//Function Number: 348
notetrack_gov_rescue_handcuffs(param_00)
{
	level.player playrumbleonentity("damage_light");
}

//Function Number: 349
notetrack_highway_bus_land_from_ledge(param_00)
{
	level.player playrumbleonentity("artillery_rumble");
}

//Function Number: 350
notetrack_highway_jump_land(param_00)
{
	level.player playrumbleonentity("artillery_rumble");
}

//Function Number: 351
notetrack_middle_takedown_grab_side(param_00)
{
	wait(0.1);
	level.player playrumbleonentity("damage_heavy");
}

//Function Number: 352
notetrack_middle_takedown_truck_swipe(param_00)
{
	common_scripts\utility::flag_wait("flag_player_dodge");
	wait(0.25);
	level.player playrumbleonentity("artillery_rumble");
}

//Function Number: 353
notetrack_middle_takedown_jump_to_truck(param_00)
{
	common_scripts\utility::flag_wait("flag_player_jump");
	level.player playrumbleonentity("damage_light");
}

//Function Number: 354
notetrack_middle_takedown_land_on_truck(param_00)
{
	common_scripts\utility::flag_wait("flag_player_jump");
	wait(1.25);
	level.player playrumbleonentity("artillery_rumble");
}

//Function Number: 355
notetrack_middle_takedown_punch_window(param_00)
{
	common_scripts\utility::flag_wait("flag_player_pull_windshield");
	wait(0.25);
	level.player playrumbleonentity("artillery_rumble");
	rumble_middle_takedown_throw_guy();
}

//Function Number: 356
rumble_middle_takedown_throw_guy()
{
	wait(1.5);
	level.player playrumbleonentity("damage_heavy");
	wait(2);
	level.player playrumbleonentity("artillery_rumble");
}

//Function Number: 357
notetrack_middle_takedown_jump_to_bus(param_00)
{
	common_scripts\utility::flag_wait("flag_player_jump2");
	level.player playrumbleonentity("damage_light");
}

//Function Number: 358
notetrack_middle_takedown_land_on_bus(param_00)
{
	common_scripts\utility::flag_wait("flag_player_jump2");
	wait(1.5);
	level.player playrumbleonentity("artillery_rumble");
}

//Function Number: 359
notetrack_highway_final_td_mirror_snap_and_drag(param_00)
{
	level.player playrumbleonentity("damage_heavy");
	wait(1);
	level.player playrumbleonentity("artillery_rumble");
}

//Function Number: 360
notetrack_highway_final_td_suv_collision(param_00)
{
	level.player playrumbleonentity("artillery_rumble");
}

//Function Number: 361
notetrack_highway_final_td_truck_rail_impact(param_00)
{
	level.player playrumbleonentity("damage_heavy");
	wait(0.4);
	level.player playrumbleonentity("artillery_rumble");
}

//Function Number: 362
notetrack_highway_final_td_truck_water_impact(param_00)
{
	wait(0.7);
	level.player playrumbleonentity("artillery_rumble");
}