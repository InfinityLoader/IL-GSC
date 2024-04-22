/*******************************************************************
 * Decompiled By: Bog
 * Decompiled File: irons_estate_meet_cormack_pt2.gsc
 * Game: Call of Duty: Advanced Warfare
 * Platform: PC
 * Function Count: 51
 * Decompile Time: 761 ms
 * Timestamp: 4/22/2024 2:32:03 AM
*******************************************************************/

//Function Number: 1
meet_cormack_pt2_start()
{
	level.start_point_scripted = "infil_hangar";
	maps\irons_estate::irons_estate_objectives();
	maps\irons_estate_code::spawn_player_checkpoint();
	maps\irons_estate_code::spawn_allies();
	soundscripts\_snd::snd_message("start_meet_cormack_pt2");
	if(!isdefined(level.meet_cormack_kill_org))
	{
		level.meet_cormack_kill_org = common_scripts\utility::getstruct("meet_cormack_kill_org","targetname");
	}

	thread elevator_top_enemies_setup();
	level.player takeallweapons();
	level.player giveweapon("iw5_pbwsingleshot_sp_silencerpistol");
	level.player giveweapon("iw5_kf5fullauto_sp_opticsreddot_silencer01");
	level.player switchtoweapon("iw5_kf5fullauto_sp_opticsreddot_silencer01");
}

//Function Number: 2
meet_cormack_pt2_main()
{
	level.start_point_scripted = "infil_hangar";
	thread meet_cormack_pt2_begin();
	common_scripts\utility::flag_wait("meet_cormack_pt2_end");
	level.stealth_fail_fast = undefined;
	thread maps\_utility::autosave_by_name();
}

//Function Number: 3
meet_cormack_pt2_begin()
{
	common_scripts\utility::flag_set("meet_cormack_pt2_start");
	level.player.grapple["dist_max"] = 800;
	level.player maps\_utility::set_player_attacker_accuracy(0.5);
	if(!isdefined(level.allies[0]))
	{
		level.allies[0] = maps\irons_estate_code::spawn_ally("cormack");
		level.allies[0].animname = "cormack";
		level.allies[0] thread maps\irons_estate_code::set_helmet_open();
	}

	if(!isdefined(level.meet_cormack_kill_org))
	{
		level.meet_cormack_kill_org = common_scripts\utility::getstruct("meet_cormack_kill_org","targetname");
	}

	maps\_stealth_utility::disable_stealth_system();
	thread player_rappel();
	thread cormack_rappel();
	thread setup_meet_cormack_pt2_objective();
	thread setup_car_ride_moment();
	thread guard_house_light_exit_light();
	thread meet_cormack_pt2_enemies();
	thread hangar_drones();
	thread convoy_barrier_setup();
}

//Function Number: 4
hangar_drones()
{
	common_scripts\utility::flag_wait_any("start_car_ride_moment","gaz_intro_finished");
	var_00 = vehicle_scripts\_pdrone_security::drone_spawn_and_drive("hangar_drones");
	common_scripts\utility::flag_wait("meet_cormack_pt2_end");
	foreach(var_02 in var_00)
	{
		if(isdefined(var_02))
		{
			var_02 delete();
		}
	}
}

//Function Number: 5
guardhouse_grapple_timer()
{
	level endon("start_convoy");
	wait(10);
	level.allies[0] maps\_utility::smart_dialogue("ie_nox_almosthere");
	wait(10);
	level.allies[0] maps\_utility::smart_dialogue("ie_crmk_runningout1");
	wait(10);
	maps\_player_death::set_deadquote(&"IRONS_ESTATE_FAILED_TO_REACH_CONVOY");
	thread maps\_utility::missionfailedwrapper();
}

//Function Number: 6
setup_meet_cormack_pt2_objective()
{
	common_scripts\utility::flag_wait("meet_cormack_pt2_end");
	maps\_utility::objective_complete(maps\_utility::obj("infiltrate_hangar"));
}

//Function Number: 7
meet_cormack_pt2_enemies()
{
	common_scripts\utility::flag_wait_any("start_car_ride_moment","gaz_intro_finished");
	var_00 = maps\_utility::array_spawn_targetname("ie_east_spawners_02",1);
	common_scripts\utility::flag_wait("player_under_car");
	foreach(var_02 in var_00)
	{
		if(isdefined(var_02) && isalive(var_02))
		{
			var_02.ignoreall = 1;
		}
	}

	common_scripts\utility::flag_wait("meet_cormack_pt2_end");
	var_00 = maps\_utility::remove_dead_from_array(var_00);
	foreach(var_02 in var_00)
	{
		if(isdefined(var_02))
		{
			var_02 delete();
		}
	}
}

//Function Number: 8
meet_cormack_pt2_vo()
{
	level endon("start_convoy");
	level.allies[0] maps\_utility::smart_dialogue("ie_crmk_tickettohangar8");
	guardhouse_grapple_timer();
}

//Function Number: 9
cormack_rappel()
{
	level endon("start_convoy");
	level.allies[0] maps\_stealth_utility::disable_stealth_for_ai();
	level.allies[0].dontevershoot = undefined;
	level.allies[0].baseaccuracy = 0.7;
	level.allies[0].ignoreall = 0;
	level.allies[0].ignoreme = 0;
	level.allies[0].ignoresuppression = 1;
	level.allies[0].disablebulletwhizbyreaction = 1;
	level.allies[0] maps\_utility::disable_pain();
	var_00 = maps\_utility::spawn_anim_model("generic_prop_raven");
	level.meet_cormack_kill_org maps\_anim::anim_first_frame_solo(var_00,"pent_escape");
	var_01 = getent("upper_elevator_door_left","targetname");
	var_01 linkto(var_00,"j_prop_1",(0,0,0),(0,0,0));
	var_02 = getent("upper_elevator_door_left_clip","targetname");
	var_02 linkto(var_01);
	var_03 = getent("upper_elevator_door_right","targetname");
	var_03 linkto(var_00,"j_prop_2",(0,0,0),(0,0,0));
	var_04 = getent("upper_elevator_door_right_clip","targetname");
	var_04 linkto(var_03);
	objective_add(maps\_utility::obj("infiltrate_hangar"),"current",&"IRONS_ESTATE_OBJ_INFILTRATE_HANGAR");
	objective_onentity(maps\_utility::obj("infiltrate_hangar"),level.allies[0]);
	level.allies[0] maps\_utility::unset_forcegoal();
	level.allies[0] maps\_utility::set_fixednode_false();
	level.allies[0] maps\_utility::set_goalradius(16);
	var_05 = getnode("cormack_pent_escape_node","targetname");
	level.allies[0] setgoalnode(var_05);
	common_scripts\utility::flag_wait("penthouse_reinforcements_01_dead");
	level.allies[0] maps\_utility::disable_cqbwalk();
	thread meet_cormack_pt2_vo();
	level.meet_cormack_kill_org maps\_anim::anim_reach_solo(level.allies[0],"pent_escape");
	level.meet_cormack_kill_org thread maps\_anim::anim_single([level.allies[0],var_00],"pent_escape");
	thread elevator_bottom_enemies_setup();
	wait(1.2);
	soundscripts\_snd_playsound::snd_play_at("irons_cormack_elev_door",(1245,-3955,1113));
	wait(2.1);
	soundscripts\_snd_playsound::snd_play_at("irons_cormack_elev_slide",(1245,-3955,1113));
	wait(0.7);
	var_06 = common_scripts\utility::getstruct("elevator_rappel_org","targetname");
	objective_position(maps\_utility::obj("infiltrate_hangar"),var_06.origin);
	common_scripts\utility::flag_set("elevator_rappel_start_ready");
	var_07 = getent("upper_elevator_door_player_clip","targetname");
	var_07 delete();
	level.allies[0] waittillmatch("end","single anim");
	level.allies[0] unlink();
	var_08 = getnode("cormack_post_rappel_cover_spot","targetname");
	level.allies[0] maps\_utility::set_goal_radius(16);
	level.allies[0] setgoalnode(var_08);
}

//Function Number: 10
player_rappel()
{
	level.elevator_rappel_rig = maps\_utility::spawn_anim_model("player_rig");
	level.elevator_rappel_rig hide();
	level.meet_cormack_kill_org maps\_anim::anim_first_frame_solo(level.elevator_rappel_rig,"pent_escape");
	common_scripts\utility::flag_wait("elevator_rappel_start");
	thread player_rappel_rumbles();
	soundscripts\_snd_playsound::snd_play_2d("irons_player_elev_slide");
	common_scripts\utility::flag_set("post_penthouse_trees");
	level.player freezecontrols(1);
	level.player allowpowerslide(0);
	level.player allowdodge(0);
	level.player setstance("stand");
	if(level.player ispowersliding() || level.player isdodging())
	{
		while(level.player ispowersliding() || level.player isdodging())
		{
			wait(0.05);
		}
	}

	level.player maps\_shg_utility::setup_player_for_scene();
	setsaveddvar("objectiveHide",1);
	level.player thread maps\_shg_utility::disable_features_entering_cinema(1);
	level.player thread maps\_tagging::tagging_set_binocs_enabled(0);
	level.player maps\_tagging::tagging_set_enabled(0);
	level.player thread maps\irons_estate_stealth::irons_estate_whistle(0);
	level.player disableweapons();
	level.player disableweaponswitch();
	level.player disableoffhandweapons();
	level.player disableoffhandsecondaryweapons();
	level.player playerlinktoblend(level.elevator_rappel_rig,"tag_player",0.5);
	level.player allowprone(0);
	level.player allowcrouch(0);
	level.player setstance("stand");
	level.meet_cormack_kill_org thread maps\_anim::anim_single_solo(level.elevator_rappel_rig,"pent_escape");
	wait(0.5);
	level.elevator_rappel_rig show();
	level.elevator_rappel_rig waittillmatch("end","single anim");
	setsaveddvar("objectiveHide",0);
	objective_onentity(maps\_utility::obj("infiltrate_hangar"),level.allies[0]);
	level.player unlink();
	level.elevator_rappel_rig delete();
	level.player freezecontrols(0);
	level.player thread maps\_shg_utility::enable_features_exiting_cinema(1);
	level.player thread maps\_tagging::tagging_set_binocs_enabled(1);
	level.player maps\_tagging::tagging_set_enabled(1);
	level.player thread maps\irons_estate_stealth::irons_estate_whistle(1);
	level.player maps\_shg_utility::setup_player_for_gameplay();
	level.player enableweapons();
	level.player enableweaponswitch();
	level.player enableoffhandweapons();
	level.player enableoffhandsecondaryweapons();
	level.player allowprone(1);
	level.player allowcrouch(1);
	level.player allowpowerslide(1);
	level.player allowdodge(1);
	thread maps\irons_estate_code::irons_estate_stealth_enable();
}

//Function Number: 11
player_rappel_rumbles()
{
	level.elevator_rappel_rig waittillmatch("cable_slide_start","single anim");
	var_00 = level.player maps\_utility::get_rumble_ent("ie_vtol_ride_rumble_low");
	var_00 thread maps\_utility::rumble_ramp_to(0.5,2);
	level.elevator_rappel_rig waittillmatch("cable_slide_end","single anim");
	var_00 thread maps\_utility::rumble_ramp_to(1,0.05);
	wait(0.25);
	var_00 delete();
}

//Function Number: 12
elevator_top_enemies_setup()
{
	var_00 = getent("penthouse_reinforcement_door_left","targetname");
	var_01 = getent("penthouse_reinforcement_door_right","targetname");
	var_02 = maps\_utility::spawn_anim_model("generic_prop_raven_x3");
	level.meet_cormack_kill_org maps\_anim::anim_first_frame_solo(var_02,"elevator_top_enemies");
	wait(0.05);
	var_00 linkto(var_02,"j_prop_1",(0,0,0),(0,0,0));
	var_01 linkto(var_02,"j_prop_2",(0,0,0),(0,0,0));
	common_scripts\utility::flag_wait("spawn_penthouse_reinforcements_01");
	soundscripts\_snd::snd_message("aud_reinforcements_door1");
	var_03 = maps\_utility::array_spawn_targetname("penthouse_reinforcements_01",1);
	var_03[0].animname = "elevator_top_enemy_1";
	var_03[0].baseaccuracy = 0.5;
	var_03[0] maps\_utility::disable_long_death();
	var_03[1].animname = "elevator_top_enemy_2";
	var_03[1].baseaccuracy = 0.5;
	var_03[1] maps\_utility::disable_long_death();
	level.meet_cormack_kill_org thread maps\_anim::anim_single([var_02,var_03[0],var_03[1]],"elevator_top_enemies");
	var_03[0] thread elevator_top_enemies_waits(0.5);
	var_03[1] thread elevator_top_enemies_waits(1.25);
	var_03[0] thread penthouse_reinforcements_01_guy_01_vo();
	var_03[1] thread penthouse_reinforcements_01_guy_02_vo();
}

//Function Number: 13
elevator_top_enemies_waits(param_00)
{
	self endon("death");
	if(isdefined(param_00))
	{
		wait(param_00);
	}

	maps\_utility::set_allowdeath(1);
	self waittillmatch("end","single anim");
}

//Function Number: 14
elevator_bottom_enemies_setup()
{
	var_00 = getent("penthouse_reinforcement_door_left_lower","targetname");
	var_01 = getent("penthouse_reinforcement_door_right_lower","targetname");
	var_02 = maps\_utility::spawn_anim_model("generic_prop_raven_x3");
	level.meet_cormack_kill_org maps\_anim::anim_first_frame_solo(var_02,"elevator_bottom_enemies");
	wait(0.05);
	var_00 linkto(var_02,"j_prop_1",(0,0,0),(0,0,0));
	var_01 linkto(var_02,"j_prop_2",(0,0,0),(0,0,0));
	level.elevator_rappel_rig waittillmatch("start_enemy_anim","single anim");
	var_03 = maps\_utility::array_spawn_targetname("penthouse_reinforcements_02",1);
	var_03[0].animname = "elevator_bottom_enemy_1";
	var_03[0].baseaccuracy = 0.5;
	var_03[0] maps\_utility::disable_long_death();
	var_03[1].animname = "elevator_bottom_enemy_2";
	var_03[1].baseaccuracy = 0.5;
	var_03[1] maps\_utility::disable_long_death();
	level.meet_cormack_kill_org thread maps\_anim::anim_single([var_02,var_03[0],var_03[1]],"elevator_bottom_enemies");
	soundscripts\_snd::snd_message("aud_reinforcements_door2");
	var_03[0] thread elevator_bottom_enemies_waits(1);
	var_03[1] thread elevator_bottom_enemies_waits(1.25);
	var_03[0] thread penthouse_reinforcements_02_guy_01_vo();
	var_03[1] thread penthouse_reinforcements_02_guy_02_vo();
}

//Function Number: 15
elevator_bottom_enemies_waits(param_00)
{
	self endon("death");
	if(isdefined(param_00))
	{
		wait(param_00);
	}

	maps\_utility::set_allowdeath(1);
	self waittillmatch("end","single anim");
}

//Function Number: 16
penthouse_reinforcements_01_guy_01_vo()
{
	self endon("death");
	wait(randomfloatrange(0.5,1.5));
	maps\_utility::smart_dialogue_generic("ie_as2_requestbackup1");
	wait(randomfloatrange(0.25,1));
	maps\_utility::smart_dialogue_generic("ie_as2_sendreinforce");
	wait(randomfloatrange(0.25,1));
	maps\_utility::smart_dialogue_generic("ie_as2_enemyinsight1");
	wait(randomfloatrange(0.25,1));
	maps\_utility::smart_dialogue_generic("ie_as2_dropweapon1");
}

//Function Number: 17
penthouse_reinforcements_01_guy_02_vo()
{
	self endon("death");
	wait(randomfloatrange(0.5,1.5));
	maps\_utility::smart_dialogue_generic("ie_as2_soundalarm1");
	wait(randomfloatrange(0.25,1));
	maps\_utility::smart_dialogue_generic("ie_as2_needbackup1");
	wait(randomfloatrange(0.25,1));
	maps\_utility::smart_dialogue_generic("ie_as2_hesarmed");
}

//Function Number: 18
penthouse_reinforcements_02_guy_01_vo()
{
	self endon("death");
	common_scripts\utility::waittill_either("reached_path_end","damage");
	wait(randomfloatrange(0.5,1.5));
	maps\_utility::smart_dialogue_generic("ie_as2_requestbackup1");
	wait(randomfloatrange(0.25,1));
	maps\_utility::smart_dialogue_generic("ie_as2_sendreinforce");
	wait(randomfloatrange(0.25,1));
	maps\_utility::smart_dialogue_generic("ie_as2_enemyinsight1");
	wait(randomfloatrange(0.25,1));
	maps\_utility::smart_dialogue_generic("ie_as2_dropweapon1");
}

//Function Number: 19
penthouse_reinforcements_02_guy_02_vo()
{
	self endon("death");
	common_scripts\utility::waittill_either("reached_path_end","damage");
	wait(randomfloatrange(0.5,1.5));
	maps\_utility::smart_dialogue_generic("ie_as2_soundalarm1");
	wait(randomfloatrange(0.25,1));
	maps\_utility::smart_dialogue_generic("ie_as2_needbackup1");
	wait(randomfloatrange(0.25,1));
	maps\_utility::smart_dialogue_generic("ie_as2_hesarmed");
}

//Function Number: 20
lower_elevator_door()
{
	var_00 = getent("lower_elevator_door_left","targetname");
	var_01 = getent("lower_elevator_door_right","targetname");
	var_00 moveto(var_00.origin + (44,0,0),1);
	var_01 moveto(var_01.origin - (44,0,0),1);
	wait(1.05);
	wait(0.05);
}

//Function Number: 21
setup_car_ride_moment()
{
	if(level.currentgen && !istransientloaded("irons_estate_upper_tr"))
	{
		level waittill("tff_post_lower_to_upper");
	}

	level.car_ride_org = common_scripts\utility::getstruct("car_ride","targetname");
	level.car_ride_player_rig = maps\_utility::spawn_anim_model("player_rig");
	level.car_ride_player_rig hide();
	level.car_ride_org maps\_anim::anim_first_frame_solo(level.car_ride_player_rig,"car_ride_enter");
	level.guardhouse_door = maps\_utility::spawn_anim_model("ie_door");
	level.car_ride_org maps\_anim::anim_first_frame_solo(level.guardhouse_door,"car_ride_enter");
	level.guard_house_exit_door_clip = getent("guard_house_exit_door_clip","targetname");
	level.guard_house_exit_door_clip linkto(level.guardhouse_door,"tag_origin",(0,0,0),(0,-90,0));
	var_00 = [];
	level.gaz = maps\_utility::spawn_anim_model("gaz");
	level.gaz.player_clip = getent("gaz_clip","targetname");
	level.gaz.player_clip linkto(level.gaz,"tag_body",(0,0,-24),(0,0,0));
	var_00[var_00.size] = level.gaz;
	level.gaz hide();
	level.gaz thread gaz_damage_watcher();
	if(level.nextgen)
	{
		thread hangar_car_door_light();
	}
	else if(level.currentgen)
	{
		thread hangar_car_door_light_audio();
	}

	thread gaz_splash_waits();
	thread car_ride_driving_workers_wait();
	level.gaz thread gaz_brake_lights_detail();
	level.gaz2 = maps\_utility::spawn_anim_model("gaz2");
	level.gaz2.player_clip = getent("gaz2_clip","targetname");
	level.gaz2.player_clip linkto(level.gaz2,"tag_body",(0,0,-24),(0,0,0));
	var_00[var_00.size] = level.gaz2;
	level.gaz2 hide();
	level.gaz2 thread gaz_damage_watcher();
	level.gaz2 thread gaz_brake_lights();
	level.car_ride_org maps\_anim::anim_first_frame(var_00,"car_ride_intro");
	common_scripts\utility::flag_wait("start_convoy");
	thread theres_the_convoy_vo();
	thread maps\_utility::autosave_by_name();
	level.gaz show();
	level.gaz2 show();
	playfxontag(level._effect["headlight_civhumvee_bright"],level.gaz2,"tag_headlight_left");
	playfxontag(level._effect["headlight_civhumvee_bright"],level.gaz2,"tag_headlight_right");
	level.gaz2.spotlight_tag = level.gaz2 common_scripts\utility::spawn_tag_origin();
	level.gaz2.spotlight_tag linkto(level.gaz2,"tag_origin",(104,0,44),(0,0,0));
	playfxontag(level._effect["headlight_gaz_spotlight"],level.gaz2.spotlight_tag,"tag_origin");
	playfxontag(level._effect["headlight_civhumvee_bright"],level.gaz,"tag_headlight_left");
	playfxontag(level._effect["headlight_civhumvee_bright"],level.gaz,"tag_headlight_right");
	level.gaz.spotlight_tag = level.gaz common_scripts\utility::spawn_tag_origin();
	level.gaz.spotlight_tag linkto(level.gaz,"tag_origin",(104,0,44),(0,0,0));
	playfxontag(level._effect["headlight_gaz_spotlight"],level.gaz.spotlight_tag,"tag_origin");
	level.car_ride_org thread maps\_anim::anim_single(var_00,"car_ride_intro");
	level.gaz thread gaz_intro_waits();
	level.gaz2 thread gaz_intro_waits();
	common_scripts\utility::flag_wait("penthouse_reinforcements_02_dead");
	thread maps\_stealth_utility::enable_stealth_system();
	level.allies[0] thread maps\_stealth_utility::enable_stealth_for_ai();
	level.car_ride_org maps\_anim::anim_reach_solo(level.allies[0],"guardhouse_exit_enter");
	level.car_ride_org maps\_anim::anim_single_solo(level.allies[0],"guardhouse_exit_enter");
	common_scripts\utility::flag_set("enable_start_car_ride_moment");
	thread maps\_utility::autosave_by_name();
	if(common_scripts\utility::flag("start_car_ride_moment"))
	{
		level.gaz maps\_utility::anim_stopanimscripted();
		level.gaz2 maps\_utility::anim_stopanimscripted();
	}
	else
	{
		level.car_ride_org thread maps\_anim::anim_loop_solo(level.allies[0],"guardhouse_exit_idle","stop_guardhouse_exit_idle");
		wait(0.05);
		var_01 = common_scripts\utility::flag_wait_any_return("start_car_ride_moment","gaz_intro_finished");
		if(var_01 == "start_car_ride_moment")
		{
			level.gaz maps\_utility::anim_stopanimscripted();
			level.gaz2 maps\_utility::anim_stopanimscripted();
		}
	}

	thread car_ride_intro_fail();
	thread car_ride_boundary_fail();
	level.stealth_fail_fast = 1;
	level endon("_stealth_spotted");
	var_02 = [];
	var_02[var_02.size] = level.allies[0];
	level.doctor = maps\_utility::spawn_targetname("car_ride_kva_doctor",1);
	level.doctor maps\_utility::set_ignoresonicaoe(1);
	level.doctor.tagged[0] = 1;
	level.doctor.animname = "doctor";
	if(!isdefined(level.doctor.magic_bullet_shield))
	{
		level.doctor maps\_utility::magic_bullet_shield(1);
	}

	level.doctor maps\_utility::set_generic_run_anim("casual_walk");
	level.doctor maps\_utility::gun_remove();
	level.doctor.grapple_magnets = [];
	var_02[var_02.size] = level.doctor;
	var_02[var_02.size] = level.gaz;
	var_02[var_02.size] = level.gaz2;
	soundscripts\_snd::snd_message("aud_trucks_arrive");
	level.car_ride_org notify("stop_guardhouse_exit_idle");
	objective_setpointertextoverride(maps\_utility::obj("infiltrate_hangar"),"");
	objective_onentity(maps\_utility::obj("infiltrate_hangar"),level.allies[0]);
	wait(0.05);
	level notify("start_car_ride_moment_anims");
	var_02[var_02.size] = level.guardhouse_door;
	level.car_ride_org thread maps\_anim::anim_single(var_02,"car_ride_enter");
	level.guardhouse_door thread guardhouse_door_waits();
	wait(0.05);
	level.allies[0] thread car_ride_enter_cormack_waits();
	level.doctor thread car_ride_enter_doctor_waits();
	level.gaz thread car_ride_gaz_waits();
	level.allies[0] waittillmatch("sd_ie_crmk_now1","single anim");
	level.gaz.player_clip delete();
	thread prone_hint_trigger();
	level notify("stop_car_ride_intro_fail");
	var_03 = getent("car_ride_trigger","targetname");
	var_03 enablelinkto();
	var_03 linkto(level.car_ride_player_rig,"tag_player",(0,0,-16),(0,0,0));
	wait(0.05);
	objective_position(maps\_utility::obj("infiltrate_hangar"),level.car_ride_player_rig gettagorigin("tag_player"));
	var_03 waittill("trigger");
	thread in_position_vo();
	level.allies[0] thread maps\irons_estate_code::hide_friendname_until_flag_or_notify("meet_cormack_pt2_end");
	common_scripts\utility::flag_set("player_under_car");
	objective_position(maps\_utility::obj("infiltrate_hangar"),(0,0,0));
	level.player maps\_utility::set_ignoreme(1);
	level.allies[0] maps\_utility::set_ignoreme(1);
	var_03 delete();
	level.player freezecontrols(1);
	level.player thread maps\_shg_utility::disable_features_entering_cinema(1);
	level.player allowsprint(0);
	thread maps\_stealth_display::stealth_display_off();
	level.player thread maps\_tagging::tagging_set_binocs_enabled(0);
	level.player maps\_tagging::tagging_set_enabled(0);
	level.player thread maps\irons_estate_stealth::irons_estate_whistle(0);
	level.player allowprone(1);
	level.player allowcrouch(0);
	level.player allowstand(0);
	level.player maps\_grapple::grapple_take();
	if(level.player getstance() != "prone")
	{
		level.player setstance("prone");
	}

	level.player disableweapons();
	level.player disableoffhandweapons();
	level.player playerlinktoblend(level.car_ride_player_rig,"tag_player",0.6);
	level.car_ride_org thread maps\_anim::anim_single_solo(level.car_ride_player_rig,"car_ride_enter");
	wait(0.6);
	level.player playerlinktodelta(level.car_ride_player_rig,"tag_player",1,0,0,0,0,1);
	level.car_ride_player_rig show();
	level.car_ride_player_rig waittillmatch("end","single anim");
	if(!common_scripts\utility::flag("cormack_under_car"))
	{
		level.car_ride_org thread maps\_anim::anim_loop_solo(level.car_ride_player_rig,"car_ride_idle","stop_car_ride_idle");
		wait(0.05);
		level.player lerpviewangleclamp(0.5,0.5,0.25,70,30,25,5);
		common_scripts\utility::flag_wait("cormack_under_car");
	}

	common_scripts\utility::flag_wait("in_position_vo_done");
	var_02 = common_scripts\utility::array_remove(var_02,level.guardhouse_door);
	var_02[var_02.size] = level.car_ride_player_rig;
	level.car_ride_org notify("stop_car_ride_enter_idle_cormack");
	level.car_ride_org notify("stop_car_ride_enter_idle_doctor");
	level.car_ride_org notify("stop_car_ride_idle");
	wait(0.05);
	thread hangar_door();
	thread maps\irons_estate_fx::hangar_fx();
	level.car_ride_org thread maps\_anim::anim_single(var_02,"car_ride_driving");
	thread car_ride_bink();
	thread car_ride_rumble();
	level notify("stop_gaz_under_heat");
	level.doctor thread car_ride_doctor_waits();
	thread post_car_ride_player();
	thread car_ride_view_clamps();
	level.allies[0] thread post_car_ride_cormack();
}

//Function Number: 22
theres_the_convoy_vo()
{
	wait(1);
	level.allies[0] maps\_utility::smart_dialogue("ie_crmk_theresconvoy1");
	level.allies[0] maps\_utility::smart_dialogue("ie_crmk_hijackintercom");
	maps\_utility::smart_radio_dialogue("ie_nox_roger2");
	level.allies[0] maps\_utility::smart_dialogue("ie_crmk_followme4");
}

//Function Number: 23
in_position_vo()
{
	common_scripts\utility::flag_wait("cormack_under_car");
	level.allies[0] maps\_utility::smart_dialogue("ie_crmk_inposition1");
	level.doctor maps\_utility::play_sound_on_entity("ie_nox_allclear1");
	common_scripts\utility::flag_set("in_position_vo_done");
}

//Function Number: 24
guardhouse_door_waits()
{
	self waittillmatch("end","single anim");
	wait(0.05);
	level.guard_house_exit_door_clip connectpaths();
}

//Function Number: 25
gaz_intro_waits()
{
	level endon("start_car_ride_moment");
	self waittillmatch("end","single anim");
	common_scripts\utility::flag_set("gaz_intro_finished");
}

//Function Number: 26
car_ride_enter_cormack_waits()
{
	self waittillmatch("end","single anim");
	if(common_scripts\utility::flag("_stealth_spotted"))
	{
		return;
	}

	level.car_ride_org thread maps\_anim::anim_loop_solo(self,"car_ride_enter_idle","stop_car_ride_enter_idle_cormack");
	wait(0.05);
	common_scripts\utility::flag_set("cormack_under_car");
}

//Function Number: 27
car_ride_enter_doctor_waits()
{
	level.car_ride_org endon("stop_car_ride_enter_idle_doctor");
	self.old_contents = self setcontents(0);
	self waittillmatch("end","single anim");
	level.car_ride_org thread maps\_anim::anim_loop_solo(self,"car_ride_enter_idle","stop_car_ride_enter_idle_doctor");
}

//Function Number: 28
car_ride_gaz_waits()
{
	self waittillmatch("heat_waves","single anim");
	thread gaz_under_heat();
}

//Function Number: 29
car_ride_doctor_waits()
{
	self waittillmatch("end","single anim");
	self setcontents(self.old_contents);
	stopfxontag(level._effect["headlight_civhumvee_bright"],level.gaz,"tag_headlight_left");
	stopfxontag(level._effect["headlight_civhumvee_bright"],level.gaz,"tag_headlight_right");
	stopfxontag(level._effect["headlight_gaz_spotlight"],level.gaz.spotlight_tag,"tag_origin");
	wait(0.1);
	stopfxontag(level._effect["headlight_civhumvee_bright"],level.gaz2,"tag_headlight_left");
	stopfxontag(level._effect["headlight_civhumvee_bright"],level.gaz2,"tag_headlight_right");
	stopfxontag(level._effect["headlight_gaz_spotlight"],level.gaz2.spotlight_tag,"tag_origin");
	thread maps\irons_estate_track_irons::handle_doctor();
}

//Function Number: 30
fx_leaves()
{
	wait(2);
	common_scripts\_exploder::exploder(700);
	wait(2);
	common_scripts\_exploder::exploder(701);
}

//Function Number: 31
guard_house_light_exit_light()
{
	level waittill("start_car_ride_moment_anims");
	var_00 = getent("guard_house_exit_light_model","targetname");
	var_01 = getent("guard_house_exit_light","targetname");
	if(level.nextgen)
	{
		level.guard_house_exit_light_02 = getent("guard_house_exit_light_02","targetname");
	}

	var_02 = getent("guard_house_exit_light_03","targetname");
	level.allies[0] waittillmatch("light_smash","single anim");
	common_scripts\_exploder::exploder(14);
	soundscripts\_snd::snd_message("aud_conduit_smash");
	var_00 setmodel("bay_light_a");
	var_01 setlightintensity(0);
	if(level.nextgen)
	{
		level.guard_house_exit_light_02 setlightintensity(0);
	}

	var_02 setlightintensity(0);
	thread fx_leaves();
}

//Function Number: 32
post_car_ride_player()
{
	level.car_ride_player_rig waittillmatch("to_stand","single anim");
	level.player allowcrouch(1);
	level.player allowstand(1);
	level.player setstance("stand");
	level.car_ride_player_rig waittillmatch("end","single anim");
	level.player unlink();
	level.player allowsprint(1);
	level.player freezecontrols(0);
	level.player thread maps\_shg_utility::enable_features_exiting_cinema(1);
	thread maps\_stealth_display::stealth_display_on();
	level.player maps\_grapple::grapple_give();
	level.player thread maps\_tagging::tagging_set_binocs_enabled(1);
	level.player maps\_tagging::tagging_set_enabled(1);
	level.player thread maps\irons_estate_stealth::irons_estate_whistle(1);
	level.player enableweapons();
	level.player enableoffhandweapons();
	level.car_ride_player_rig delete();
	common_scripts\utility::flag_set("meet_cormack_pt2_end");
	wait(1);
	level.player.ignoreme = 0;
}

//Function Number: 33
post_car_ride_cormack()
{
	level endon("track_irons_start");
	self waittillmatch("end","single anim");
	maps\_stealth_utility::enable_stealth_for_ai();
	self setgoalpos(self.origin);
	wait(1);
	var_00 = getnode("cormack_girder_node_01","targetname");
	maps\_utility::set_goalradius(16);
	self setgoalnode(var_00);
}

//Function Number: 34
hangar_door()
{
	wait(9);
	var_00 = getent("hangar_door_left","targetname");
	var_01 = getent("hangar_door_right","targetname");
	var_00 movey(96,3);
	var_01 movey(-96,3);
	wait(9);
	var_00 movey(-96,3);
	var_01 movey(96,3);
}

//Function Number: 35
car_ride_view_clamps()
{
	level.player lerpviewangleclamp(0.5,0.5,0.25,80,50,25,5);
	level.car_ride_player_rig waittillmatch("clamp_change","single anim");
	level.player lerpviewangleclamp(0.5,0.5,0.25,80,50,25,5);
	level.car_ride_player_rig waittillmatch("clamp_change","single anim");
	level.player lerpviewangleclamp(1,0.5,0.25,10,10,10,5);
	level.car_ride_player_rig waittillmatch("clamp_change","single anim");
	level.player lerpviewangleclamp(1,0.5,0.25,80,80,10,5);
	level.car_ride_player_rig waittillmatch("clamp_change","single anim");
	level.player lerpviewangleclamp(1,0.5,0.25,0,0,0,0);
}

//Function Number: 36
car_ride_intro_fail()
{
	level endon("stop_car_ride_intro_fail");
	common_scripts\utility::flag_wait("car_ride_intro_fail");
	maps\irons_estate_code::player_alerted_mission_fail_convoy();
}

//Function Number: 37
car_ride_boundary_fail()
{
	level endon("player_under_car");
	common_scripts\utility::flag_wait("car_ride_boundary_fail");
	maps\irons_estate_code::player_alerted_mission_fail();
}

//Function Number: 38
hangar_car_door_light()
{
	var_00 = getent("hangar_car_door_light","targetname");
	var_00 setlightintensity(0);
	level.gaz waittillmatch("light_on","single anim");
	var_00 setlightintensity(25000);
	soundscripts\_snd::snd_message("aud_hangar_car_door_exit");
	level.gaz waittillmatch("light_off","single anim");
	var_00 setlightintensity(0);
}

//Function Number: 39
hangar_car_door_light_audio()
{
	level.gaz waittillmatch("light_on","single anim");
	soundscripts\_snd::snd_message("aud_hangar_car_door_exit");
}

//Function Number: 40
gaz_splash_waits()
{
	level.gaz waittillmatch("splash_sound","single anim");
	soundscripts\_snd::snd_message("aud_tire_splash");
	level.gaz waittillmatch("splash_sound","single anim");
	soundscripts\_snd::snd_message("aud_tire_splash");
	level.gaz waittillmatch("splash_sound","single anim");
	soundscripts\_snd::snd_message("aud_tire_splash");
}

//Function Number: 41
car_ride_driving_workers_wait()
{
	if(!isdefined(level.car_ride_org))
	{
		level.car_ride_org = common_scripts\utility::getstruct("car_ride","targetname");
	}

	var_00 = maps\_utility::array_spawn_targetname("car_ride_driving_workers",1);
	var_00[0].animname = "car_ride_driving_worker_1";
	var_00[1].animname = "car_ride_driving_worker_2";
	foreach(var_02 in var_00)
	{
		var_02 maps\_utility::gun_remove();
		var_02.grapple_magnets = [];
		var_02 maps\_utility::set_allowdeath(1);
	}

	level.car_ride_org maps\_anim::anim_first_frame(var_00,"car_ride_driving_workers");
	level.gaz waittillmatch("worker_anim_start","single anim");
	level.car_ride_org thread maps\_anim::anim_single(var_00,"car_ride_driving_workers");
	var_00[0] thread car_ride_driving_workers_waits();
	var_00[1] thread car_ride_driving_workers_waits();
}

//Function Number: 42
car_ride_driving_workers_waits()
{
	self endon("death");
	self waittillmatch("end","single anim");
	self delete();
}

//Function Number: 43
gaz_damage_watcher()
{
	level endon("player_under_car");
	self setcandamage(1);
	for(;;)
	{
		self waittill("damage",var_00,var_01);
		if(isdefined(var_01) && var_01 == level.player)
		{
			maps\irons_estate_code::player_alerted_mission_fail();
		}

		wait(0.05);
	}
}

//Function Number: 44
gaz_brake_lights_detail()
{
	playfxontag(level._effect["ie_humvee_tail_l_v2"],self,"tag_brakelight_left");
	playfxontag(level._effect["ie_humvee_tail_r_v2"],self,"tag_brakelight_right");
	self waittillmatch("brakelights_on","single anim");
	playfxontag(level._effect["ie_humvee_tail_l_v2"],self,"tag_brakelight_left");
	playfxontag(level._effect["ie_humvee_tail_l_v2"],self,"tag_brakelight_right");
	self waittillmatch("brakelights_off","single anim");
	stopfxontag(level._effect["ie_humvee_tail_l_v2"],self,"tag_brakelight_left");
	stopfxontag(level._effect["ie_humvee_tail_l_v2"],self,"tag_brakelight_right");
	self waittillmatch("brakelights_on","single anim");
	playfxontag(level._effect["ie_humvee_tail_l_v2"],self,"tag_brakelight_left");
	playfxontag(level._effect["ie_humvee_tail_l_v2"],self,"tag_brakelight_right");
	self waittillmatch("brakelights_off","single anim");
	stopfxontag(level._effect["ie_humvee_tail_l_v2"],self,"tag_brakelight_left");
	stopfxontag(level._effect["ie_humvee_tail_l_v2"],self,"tag_brakelight_right");
	self waittillmatch("end","single anim");
	stopfxontag(level._effect["ie_humvee_tail_l_v2"],self,"tag_brakelight_left");
	stopfxontag(level._effect["ie_humvee_tail_r_v2"],self,"tag_brakelight_right");
}

//Function Number: 45
gaz_brake_lights()
{
	playfxontag(level._effect["ie_humvee_tail_l"],self,"tag_brakelight_left");
	playfxontag(level._effect["ie_humvee_tail_r"],self,"tag_brakelight_right");
	self waittillmatch("brakelights_on","single anim");
	playfxontag(level._effect["ie_humvee_brake_l"],self,"tag_brakelight_left");
	playfxontag(level._effect["ie_humvee_brake_r"],self,"tag_brakelight_right");
	self waittillmatch("brakelights_off","single anim");
	stopfxontag(level._effect["ie_humvee_brake_l"],self,"tag_brakelight_left");
	stopfxontag(level._effect["ie_humvee_brake_r"],self,"tag_brakelight_right");
	self waittillmatch("brakelights_on","single anim");
	playfxontag(level._effect["ie_humvee_brake_l"],self,"tag_brakelight_left");
	playfxontag(level._effect["ie_humvee_brake_r"],self,"tag_brakelight_right");
	self waittillmatch("brakelights_off","single anim");
	stopfxontag(level._effect["ie_humvee_brake_l"],self,"tag_brakelight_left");
	stopfxontag(level._effect["ie_humvee_brake_r"],self,"tag_brakelight_right");
	self waittillmatch("end","single anim");
	stopfxontag(level._effect["ie_humvee_tail_l"],self,"tag_brakelight_left");
	stopfxontag(level._effect["ie_humvee_tail_r"],self,"tag_brakelight_right");
}

//Function Number: 46
gaz_under_heat()
{
	playfxontag(level._effect["civ_humvee_under_heat"],self,"tag_origin");
	level waittill("stop_gaz_under_heat");
	stopfxontag(level._effect["civ_humvee_under_heat"],self,"tag_origin");
}

//Function Number: 47
car_ride_rumble()
{
	wait(1);
	var_00 = level.player maps\_utility::get_rumble_ent("steady_rumble");
	var_00 maps\_utility::set_rumble_intensity(0.1);
	var_00 maps\_utility::rumble_ramp_to(0.1,1);
	level.gaz waittillmatch("end","single anim");
	var_00 maps\_utility::rumble_ramp_off(1);
	wait(0.6);
	var_00 delete();
}

//Function Number: 48
car_ride_bink()
{
	setsaveddvar("cg_cinematicCanPause","1");
	setsaveddvar("cg_cinematicFullScreen","0");
	cinematicingame("base_videolog",1);
	wait(8.12);
	var_00 = newhudelem();
	var_00.x = 0;
	var_00.y = 5;
	var_00.alignx = "left";
	var_00.aligny = "top";
	var_00.horzalign = "left";
	var_00.vertalign = "top";
	var_00.sort = -1;
	var_00 setshader("cinematic_add",int(340),int(231.2));
	var_00.alpha = 1;
	pausecinematicingame(0);
	soundscripts\_snd::snd_message("aud_vehicle_ride_data");
	while(iscinematicplaying())
	{
		wait(0.05);
	}

	setsaveddvar("cg_cinematicCanPause","0");
	var_00 destroy();
	setsaveddvar("cg_cinematicFullScreen","1");
}

//Function Number: 49
prone_hint_trigger()
{
	var_00 = getent("prone_hint_trigger","targetname");
	var_00 waittill("trigger");
	if(level.player common_scripts\utility::is_player_gamepad_enabled())
	{
		level.player thread maps\_utility::display_hint("HINT_PRONE");
		return;
	}

	if(maps\_utility::is_command_bound("toggleprone"))
	{
		level.player thread maps\_utility::display_hint("HINT_PRONE_TOGGLE");
		return;
	}

	if(maps\_utility::is_command_bound("+prone"))
	{
		level.player thread maps\_utility::display_hint("HINT_PRONE_HOLD");
		return;
	}

	if(maps\_utility::is_command_bound("+stance"))
	{
		level.player thread maps\_utility::display_hint("HINT_PRONE");
		return;
	}
}

//Function Number: 50
convoy_barrier_setup()
{
	var_00 = getentarray("convoy_barrier","targetname");
	if(isdefined(var_00) && var_00.size > 0)
	{
		common_scripts\utility::array_thread(var_00,::convoy_barrier);
	}
}

//Function Number: 51
convoy_barrier()
{
	var_00 = 1.5;
	var_01 = getent(self.target,"targetname");
	var_01 linkto(self);
	if(level.currentgen)
	{
		common_scripts\utility::flag_wait("start_convoy");
	}

	level.gaz waittillmatch("barrier_down","single anim");
	self movez(-34,var_00);
	level.gaz waittillmatch("barrier_up","single anim");
	self movez(34,var_00);
}