/*******************************************************************
 * Decompiled By: Bog
 * Decompiled File: irons_estate_plant_tracker.gsc
 * Game: Call of Duty: Advanced Warfare
 * Platform: PC
 * Function Count: 42
 * Decompile Time: 640 ms
 * Timestamp: 4/22/2024 2:32:07 AM
*******************************************************************/

//Function Number: 1
plant_tracker_start()
{
	level.start_point_scripted = "plant_tracker";
	maps\irons_estate::irons_estate_objectives();
	maps\irons_estate_code::spawn_player_checkpoint();
	maps\irons_estate_code::spawn_allies();
	thread move_lift();
	thread maps\irons_estate_track_irons::handle_gaz();
	thread maps\irons_estate_track_irons::handle_gaz2();
	soundscripts\_snd::snd_message("start_plant_tracker");
	thread stairwell_doors();
	thread landing_pad_lift_upper_static_setup();
	thread maps\irons_estate_track_irons::ambient_hangar_fan_blades_setup();
	level.player takeallweapons();
	level.player giveweapon("iw5_pbwsingleshot_sp_silencerpistol");
	level.player giveweapon("iw5_kf5fullauto_sp_opticsreddot_silencer01");
	level.player switchtoweapon("iw5_kf5fullauto_sp_opticsreddot_silencer01");
}

//Function Number: 2
plant_tracker_main()
{
	level.start_point_scripted = "plant_tracker";
	thread plant_tracker_begin();
	common_scripts\utility::flag_wait("plant_tracker_end");
	thread maps\_utility::autosave_by_name();
}

//Function Number: 3
plant_tracker_begin()
{
	common_scripts\utility::flag_set("plant_tracker_start");
	level.player.grapple["dist_max"] = 1000;
	level.player maps\_utility::set_player_attacker_accuracy(0.5);
	thread plant_tracker_objective();
	thread exfil_setup();
	thread plant_tracker_vo();
	thread grapple_dist_max_watcher();
	thread landing_pad_lights_on();
	thread pop_cormack_into_exfil_anim_to_match_player();
	thread exfil_guys();
	level.allies[0] thread cormack_grapple_to_vtol();
	soundscripts\_snd::snd_message("aud_exfil_vtol_start");
}

//Function Number: 4
grapple_dist_max_watcher()
{
	common_scripts\utility::flag_wait("increase_grapple_dist_max");
	level.player.grapple["dist_max"] = 1500;
}

//Function Number: 5
plant_tracker_objective()
{
	objective_add(maps\_utility::obj("plant_tracker"),"current",&"IRONS_ESTATE_OBJ_PLANT_TRACKER");
	objective_onentity(maps\_utility::obj("plant_tracker"),level.allies[0]);
	common_scripts\utility::flag_wait("start_exfil_moment_final");
	thread maps\_stealth_display::stealth_display_off();
	var_00 = common_scripts\utility::getstruct("vtol_landing_pad_obj_marker","targetname");
	objective_position(maps\_utility::obj("plant_tracker"),var_00.origin);
	level.player waittill("grappled_to_vtol");
	objective_position(maps\_utility::obj("plant_tracker"),(0,0,0));
	common_scripts\utility::flag_wait("ATTACHED_TRACKER");
	maps\_utility::objective_complete(maps\_utility::obj("plant_tracker"));
}

//Function Number: 6
move_lift()
{
	var_00 = getent("landing_pad_lift","targetname");
	var_01 = var_00 common_scripts\utility::spawn_tag_origin();
	var_00 linkto(var_01,"tag_origin");
	var_02 = common_scripts\utility::getstruct("lift_end_pos","targetname");
	var_01 moveto(var_02.origin,0.1);
}

//Function Number: 7
vtol_exhaust()
{
	common_scripts\utility::flag_wait("start_exfil_moment_final_liftoff_started");
	playfxontag(level._effect["vtol_exhaust_l"],self,"TAG_LT_WING_EXHAUSE_FX");
	playfxontag(level._effect["vtol_exhaust_r"],self,"TAG_RT_WING_EXHAUSE_FX");
}

//Function Number: 8
vtolfx()
{
	common_scripts\utility::flag_wait("start_exfil_moment_final_liftoff_started");
	playfxontag(level._effect["vtol_engine"],self,"TAG_FX_ENGINE_LE_1");
	wait(0.3);
	playfxontag(level._effect["vtol_engine"],self,"TAG_FX_ENGINE_LE_2");
	wait(0.1);
	playfxontag(level._effect["vtol_engine"],self,"TAG_FX_ENGINE_LE_3");
	wait(0.3);
	playfxontag(level._effect["vtol_engine"],self,"TAG_FX_ENGINE_LE_4");
	wait(0.1);
	playfxontag(level._effect["vtol_engine"],self,"TAG_FX_ENGINE_RI_1");
	wait(0.05);
	playfxontag(level._effect["vtol_engine"],self,"TAG_FX_ENGINE_RI_2");
	wait(0.05);
	playfxontag(level._effect["vtol_engine"],self,"TAG_FX_ENGINE_RI_3");
	wait(0.05);
	playfxontag(level._effect["vtol_engine"],self,"TAG_FX_ENGINE_RI_4");
	common_scripts\_exploder::exploder(1000);
}

//Function Number: 9
exfil_setup()
{
	level.anim_struct_exfil = common_scripts\utility::getstruct("anim_struct_exfil","targetname");
	if(isdefined(level.vtol))
	{
		level.vtol delete();
	}

	var_00 = [];
	level.vtol = maps\_utility::spawn_anim_model("vtol",(0,0,0));
	var_00[var_00.size] = level.vtol;
	level.exfil_arms = maps\_utility::spawn_anim_model("player_rig",(0,0,0));
	level.exfil_arms hide();
	var_00[var_00.size] = level.exfil_arms;
	level.tracking_device = maps\_utility::spawn_anim_model("tracking_device");
	level.tracking_device linkto(level.exfil_arms,"tag_weapon_right",(0,0,0),(0,0,0));
	level.tracking_device hide();
	var_01 = maps\_utility::spawn_anim_model("genericprop_x5");
	var_01 hide();
	var_00[var_00.size] = var_01;
	var_01 thread exfil_spotlights_fx();
	level.anim_struct_exfil maps\_anim::anim_first_frame(var_00,"exfil");
	level.vtol thread exfil_vtol();
	level.vtol thread vtol_lights();
	thread exfil_player();
	thread plant_tracker_waits();
	thread plant_tracker_rumbles();
	level.allies[0] thread exfil_cormack();
	thread exfil_allies();
	thread tracking_device_waits();
	thread breathers();
	common_scripts\utility::flag_wait_or_timeout("start_exfil_moment_final_liftoff",60);
	common_scripts\utility::flag_set("start_exfil_moment_final_liftoff_started");
	wait(2);
	level.anim_struct_exfil thread maps\_anim::anim_single(var_00,"exfil");
}

//Function Number: 10
pop_cormack_into_exfil_anim_to_match_player()
{
	common_scripts\utility::flag_wait("player_started_vtol_grapple");
	level.allies[0].name = " ";
	level waittill("stop_grapplesound");
	level.allies[0] notify("killgrapple");
	level.allies[0] unlink();
	level.anim_struct_exfil thread maps\_anim::anim_single_solo(level.allies[0],"exfil");
	wait(0.05);
	maps\_anim::anim_set_time([level.vtol,level.allies[0],level.exfil_arms],"exfil",0.26867);
}

//Function Number: 11
vtol_lights()
{
	playfxontag(level._effect["ie_atlas_jet_exterior_lights"],self,"body_animate_jnt");
	wait 0.05;
	playfxontag(level._effect["ie_vtol_wtip_light_red_blink"],self,"TAG_LT_WING_LIGHT_FX");
	playfxontag(level._effect["ie_vtol_wtip_light_red_blink"],self,"TAG_RT_WING_LIGHT_FX");
}

//Function Number: 12
exfil_spotlights_fx()
{
	common_scripts\utility::flag_wait("start_exfil_moment_final");
	playfxontag(level._effect["ie_lightbeam_vtol_landing"],self,"j_prop_1");
	wait(0.05);
	playfxontag(level._effect["ie_lightbeam_vtol_landing"],self,"j_prop_2");
	wait(0.05);
	playfxontag(level._effect["ie_lightbeam_vtol_landing"],self,"j_prop_3");
	wait(0.05);
	playfxontag(level._effect["ie_lightbeam_vtol_landing"],self,"j_prop_4");
	common_scripts\utility::flag_wait("player_grappled_to_vtol");
	wait(3);
	stopfxontag(level._effect["ie_lightbeam_vtol_landing"],self,"j_prop_1");
	wait(0.05);
	stopfxontag(level._effect["ie_lightbeam_vtol_landing"],self,"j_prop_2");
	wait(0.05);
	stopfxontag(level._effect["ie_lightbeam_vtol_landing"],self,"j_prop_3");
	wait(0.05);
	stopfxontag(level._effect["ie_lightbeam_vtol_landing"],self,"j_prop_4");
}

//Function Number: 13
exfil_vtol()
{
	var_00 = common_scripts\utility::spawn_tag_origin();
	var_00 hide();
	var_00 linkto(self,"J_magnet_01",(0,0,0),(0,0,0));
	self waittillmatch("grapple_on","single anim");
	level thread player_started_vtol_grapple_monitor();
	thread cloud_fx();
	playfxontag(level._effect["ie_vtol_fill_grapple"],self,"J_magnet_01");
	level.vtol thread vtol_obj_marker_monitor(var_00);
	self waittillmatch("grapple_off","single anim");
	if(!common_scripts\utility::flag("player_started_vtol_grapple"))
	{
		level notify("player_started_vtol_grapple_monitor_off");
		maps\_grapple::grapple_magnet_unregister(self,"J_magnet_01");
		level.player maps\_grapple::grapple_take();
		objective_state(maps\_utility::obj("plant_tracker"),"failed");
		wait(1);
		maps\_player_death::set_deadquote(&"IRONS_ESTATE_VTOL_GRAPPLE_FAIL");
		maps\_utility::missionfailedwrapper();
	}

	self waittillmatch("tracker_on","single anim");
	self waittillmatch("tracker_off","single anim");
	common_scripts\utility::flag_set("ATTACHED_TRACKER");
	self waittillmatch("detach_on","single anim");
	self waittillmatch("detach_off","single anim");
	thread detach_motion_blur_enable();
	common_scripts\utility::flag_set("DETACHED_FROM_VTOL");
	thread dive_fx();
	self waittillmatch("end","single anim");
	self delete();
}

//Function Number: 14
vtol_obj_marker_monitor(param_00)
{
	level endon("player_started_vtol_grapple_monitor_off");
	var_01 = spawnstruct();
	var_01.landanimbody = %ie_exfil_vtol_player;
	var_01.landanimhands = %ie_exfil_vtol_player_viewmodel;
	var_01.ignorecollision = 1;
	var_01.noenableweapon = 1;
	var_01.landhiderope = 1;
	var_01.noabort = 1;
	if(common_scripts\utility::flag("increase_grapple_dist_max"))
	{
		objective_onentity(maps\_utility::obj("plant_tracker"),param_00);
		maps\_grapple::grapple_magnet_register(self,"J_magnet_01",(0,0,0),"grappled_to_vtol",undefined,var_01,undefined);
		return;
	}

	common_scripts\utility::flag_wait("increase_grapple_dist_max");
	objective_onentity(maps\_utility::obj("plant_tracker"),param_00);
	maps\_grapple::grapple_magnet_register(self,"J_magnet_01",(0,0,0),"grappled_to_vtol",undefined,var_01,undefined);
}

//Function Number: 15
player_started_vtol_grapple_monitor()
{
	level endon("missionfailed");
	level.player endon("death");
	level endon("player_started_vtol_grapple_monitor_off");
	for(;;)
	{
		level.player waittill("grapple_moving",var_00);
		if(isdefined(var_00) && var_00.notifyname == "grappled_to_vtol")
		{
			objective_position(maps\_utility::obj("plant_tracker"),(0,0,0));
			soundscripts\_snd::snd_message("aud_exfil_vtol_grapple");
			common_scripts\utility::flag_set("player_started_vtol_grapple");
			thread started_to_grapple_to_vtol_but_aborted_watcher();
		}
	}
}

//Function Number: 16
started_to_grapple_to_vtol_but_aborted_watcher()
{
	level.player endon("grappled_to_vtol");
	level.player waittill("grapple_abort");
	level notify("player_started_vtol_grapple_monitor_off");
	maps\_grapple::grapple_magnet_unregister(level.vtol,"J_magnet_01");
	level.player maps\_grapple::grapple_take();
	objective_state(maps\_utility::obj("plant_tracker"),"failed");
	wait(1);
	maps\_player_death::set_deadquote(&"IRONS_ESTATE_VTOL_GRAPPLE_FAIL");
	maps\_utility::missionfailedwrapper();
}

//Function Number: 17
exfil_player()
{
	level.player waittill("grappled_to_vtol");
	common_scripts\utility::flag_set("player_grappled_to_vtol");
	level.player playrumbleonentity("damage_light");
	maps\_grapple::grapple_magnet_unregister(level.vtol,"J_magnet_01");
	level.player maps\_grapple::grapple_take();
	level.player disableweapons();
	level.player allowcrouch(0);
	level.player allowprone(0);
	level.player disableoffhandweapons();
	level.player disableweaponswitch();
	level.player thread maps\_shg_utility::disable_features_entering_cinema(1);
	level.player thread maps\_tagging::tagging_set_binocs_enabled(0);
	level.player maps\_tagging::tagging_set_enabled(0);
	level.player thread maps\irons_estate_stealth::irons_estate_whistle(0);
	level.player playerlinktoabsolute(level.exfil_arms,"tag_player");
	wait(0.05);
	level.player playerlinktodelta(level.exfil_arms,"tag_player",1,0,0,0,0,1);
	level.exfil_arms show();
}

//Function Number: 18
exfil_cormack()
{
	level.allies[0] allowedstances("stand");
	level.allies[0].badplaceawareness = 0;
	level.anim_struct_exfil maps\_anim::anim_reach_solo(level.allies[0],"exfil_enter");
	level.anim_struct_exfil thread maps\_anim::anim_single_solo(level.allies[0],"exfil_enter");
	soundscripts\_snd::snd_message("aud_exfil_door_1");
	level.allies[0] waittillmatch("end","single anim");
	thread running_up_the_stairs_fail();
	if(common_scripts\utility::flag("start_exfil_moment"))
	{
		var_00 = "exfil_enter_end_1";
		soundscripts\_snd::snd_message("aud_exfil_door_2a");
	}
	else
	{
		var_00 = "exfil_enter_end_2";
		level.anim_struct_exfil thread maps\_anim::anim_first_frame_solo(level.allies[0],var_00);
		common_scripts\utility::flag_wait("start_exfil_moment");
		soundscripts\_snd::snd_message("aud_exfil_door_2b");
	}

	thread maps\_utility::autosave_stealth();
	level.anim_struct_exfil thread maps\_anim::anim_single_solo(level.allies[0],var_00);
	level.allies[0] waittillmatch("door_open","single anim");
	soundscripts\_snd::snd_message("aud_exfil_vtol_ascend");
	common_scripts\utility::flag_set("start_exfil_moment_final");
	maps\irons_estate_code::irons_estate_stealth_disable();
	level.allies[0] waittillmatch("end","single anim");
	level.allies[0] thread cormack_landing_pad_combat();
}

//Function Number: 19
cormack_landing_pad_combat()
{
	thread maps\_stealth_utility::disable_stealth_system();
	maps\_stealth_utility::disable_stealth_for_ai();
	self.baseaccuracy = 0.9;
	maps\_utility::enable_heat_behavior(1);
	self.disablereactionanims = 1;
	self.dontevershoot = undefined;
	maps\_utility::set_fixednode_false();
	maps\_utility::set_goalradius(1024);
	maps\_utility::disable_cqbwalk();
	maps\_utility::enable_careful();
	maps\_utility::set_force_color("b");
	maps\_utility::enable_ai_color();
	maps\_utility::disable_surprise();
	maps\_utility::disable_pain();
	maps\_utility::disable_bulletwhizbyreaction();
	self allowedstances("stand","crouch");
	self.ignoreme = 0;
	self.ignoreall = 0;
	level notify("wake_up_guys");
}

//Function Number: 20
exfil_guys()
{
	common_scripts\utility::flag_wait("start_exfil_moment_final");
	thread exfil_enemies();
}

//Function Number: 21
exfil_enemies()
{
	maps\_utility::array_spawn_function_targetname("landing_pad_enemies",::exfil_enemies_setup);
	var_00 = maps\_utility::array_spawn_targetname("landing_pad_enemies",1);
	level.jumper_clip_1 = getent("jumper_clip_1","targetname");
	level.jumper_clip_2 = getent("jumper_clip_2","targetname");
	var_01 = vehicle_scripts\_pdrone_security::drone_spawn_and_drive("landing_pad_drones");
	common_scripts\utility::array_thread(var_01,::landing_pad_drones);
}

//Function Number: 22
exfil_enemies_setup()
{
	self endon("death");
	self.baseaccuracy = 0.5;
	level waittill("wake_up_guys");
	maps\_stealth_utility::disable_stealth_for_ai();
	self notify("end_patrol");
	if(isdefined(self.script_noteworthy) && self.script_noteworthy == "jumpers")
	{
		if(isdefined(level.jumper_clip_1))
		{
			level.jumper_clip_1 notsolid();
			level.jumper_clip_1 connectpaths();
			level.jumper_clip_1 delete();
		}

		self.canjumppath = 100;
		maps\_utility::set_ignoreme(1);
		maps\_utility::set_ignoreall(1);
		var_00 = getent("jumper_volume","targetname");
		self setgoalvolumeauto(var_00);
		common_scripts\utility::waittill_notify_or_timeout("goal",8);
		if(isdefined(level.jumper_clip_2))
		{
			level.jumper_clip_2 notsolid();
			level.jumper_clip_2 connectpaths();
			level.jumper_clip_2 delete();
		}

		self cleargoalvolume();
		self.dontattackme = undefined;
		self.ignoreme = 0;
		self.ignoreall = 0;
		maps\_utility::set_force_color("o");
		maps\_utility::enable_ai_color();
	}
	else
	{
		self.dontattackme = undefined;
		self.ignoreme = 0;
		self.ignoreall = 0;
		maps\_utility::set_force_color("o");
		maps\_utility::enable_ai_color();
	}

	common_scripts\utility::flag_wait("player_started_vtol_grapple");
	if(isdefined(self) && isalive(self))
	{
		self kill();
	}
}

//Function Number: 23
landing_pad_drones()
{
	self endon("death");
	self.attack_accuracy = 0.5;
	level waittill("wake_up_guys");
	wait(randomfloatrange(1,2));
	thread vehicle_scripts\_pdrone_security::drone_set_mode("attack");
	common_scripts\utility::flag_wait("player_started_vtol_grapple");
	if(isdefined(self) && isalive(self))
	{
		self kill();
	}
}

//Function Number: 24
cormack_grapple_to_vtol()
{
	self endon("killgrapple");
	level endon("missionfailed");
	level.player endon("death");
	level endon("player_started_vtol_grapple_monitor_off");
	common_scripts\utility::flag_wait_either("start_exfil_moment_final_liftoff_started","landing_pad_enemies_dead");
	common_scripts\utility::flag_set("increase_grapple_dist_max");
	var_00 = getnode("cormack_landing_pad_grapple_spot","targetname");
	maps\_utility::ai_ignore_everything();
	maps\_utility::disable_ai_color();
	maps\_utility::set_ignoreall(1);
	maps\_utility::set_ignoreme(1);
	maps\_utility::set_fixednode_true();
	maps\_utility::set_goalradius(64);
	maps\_utility::enable_sprint();
	self setgoalnode(var_00);
	self waittill("goal");
	maps\_grapple_traverse::grapple_traverse(undefined,level.vtol,"J_magnet_02",%ie_exfil_impact_cormack);
	self waittill("traverse_finish");
	self unlink();
	level.anim_struct_exfil thread maps\_anim::anim_single_solo(self,"exfil");
	wait(0.05);
	var_01 = level.exfil_arms getanimtime(level.exfil_arms maps\_utility::getanim("exfil"));
	self setanimtime(maps\_utility::getanim("exfil"),var_01);
}

//Function Number: 25
exfil_workers()
{
	maps\_utility::array_spawn_function_targetname("landing_pad_workers_01",::worker_spawn_func);
	var_00 = maps\_utility::array_spawn_targetname("landing_pad_workers_01",1);
	maps\_utility::array_spawn_function_targetname("landing_pad_workers_02",::worker_spawn_func);
	var_01 = maps\_utility::array_spawn_targetname("landing_pad_workers_02",1);
}

//Function Number: 26
worker_spawn_func()
{
	self endon("death");
	maps\_utility::ai_ignore_everything();
	self.animname = "generic";
	maps\_utility::set_generic_idle_anim("patrol_idle_cool");
	common_scripts\utility::flag_wait("_stealth_spotted");
	maps\_utility::set_generic_run_anim("patrol_walk_alert",1);
	var_00 = common_scripts\utility::getstruct(self.script_noteworthy + "_struct","script_noteworthy");
	maps\_utility::set_ignoreall(1);
	maps\_utility::set_ignoreme(1);
	maps\_utility::set_goal_radius(32);
	maps\_utility::set_fixednode_true();
	maps\_utility::set_forcegoal();
	self setgoalpos(var_00.origin);
	self waittill("goal");
	maps\_anim::anim_loop_solo(self,"landing_pad_worker_cower_idle");
}

//Function Number: 27
stairwell_doors()
{
	if(!isdefined(level.anim_struct_exfil))
	{
		level.anim_struct_exfil = common_scripts\utility::getstruct("anim_struct_exfil","targetname");
	}

	level.lower_stairwell_door = maps\_utility::spawn_anim_model("lower_stairwell_door");
	level.anim_struct_exfil maps\_anim::anim_first_frame_solo(level.lower_stairwell_door,"lower_stairwell_door");
	var_00 = maps\_utility::spawn_anim_model("upper_stairwell_door_left");
	var_01 = maps\_utility::spawn_anim_model("upper_stairwell_door_right");
	level.anim_struct_exfil maps\_anim::anim_first_frame([var_00,var_01],"upper_stairwell_doors");
	wait(0.05);
	var_02 = getent("lower_stairwell_door_clip","targetname");
	var_02 linkto(level.lower_stairwell_door,"tag_origin");
	var_03 = getent("upper_stairwell_door_left_clip","targetname");
	var_03 linkto(var_00,"tag_origin");
	var_04 = getent("upper_stairwell_door_right_clip","targetname");
	var_04 linkto(var_01,"tag_origin");
	level.allies[0] waittillmatch("door_open","single anim");
	level.anim_struct_exfil maps\_anim::anim_single_solo(level.lower_stairwell_door,"lower_stairwell_door");
	level.allies[0] waittillmatch("door_open","single anim");
	level.vtol thread vtolfx();
	level.vtol thread vtol_exhaust();
	level.anim_struct_exfil maps\_anim::anim_single([var_00,var_01],"upper_stairwell_doors");
}

//Function Number: 28
exfil_allies()
{
	var_00 = maps\_utility::array_spawn_targetname("exfil_diver",1);
	var_00[0].animname = "exfil_ally1";
	var_00[1].animname = "exfil_ally2";
	foreach(var_02 in var_00)
	{
		var_02.grapple_magnets = [];
		var_02 maps\_utility::gun_remove();
		var_02.name = " ";
	}

	level.anim_struct_exfil maps\_anim::anim_first_frame(var_00,"exfil");
	level.vtol waittillmatch("ally_anim_start","single anim");
	thread detach_motion_blur_disable();
	maps\_utility::stop_exploder(10);
	common_scripts\_exploder::exploder(16);
	level.anim_struct_exfil maps\_anim::anim_single(var_00,"exfil");
}

//Function Number: 29
plant_tracker_vo()
{
	level.allies[0] maps\_utility::smart_dialogue("ie_crmk_onme3");
	wait(1);
	level.allies[0] maps\_utility::smart_dialogue("ie_crmk_goingaftercargo");
	wait(1);
	maps\_utility::smart_radio_dialogue("ie_nox_jetloaded");
	wait(1);
	level.allies[0] maps\_utility::smart_dialogue("ie_crmk_pointdelta");
	common_scripts\utility::flag_wait("start_exfil_moment_final");
	wait(0.5);
	level.allies[0] maps\_utility::smart_dialogue("crsh_crmk_dropemquick");
	level.allies[0] maps\_utility::smart_dialogue("crsh_crmk_clearemout");
	wait(1);
	level.allies[0] maps\_utility::smart_dialogue("ie_crmk_run1");
	wait(1);
	level.allies[0] maps\_utility::smart_dialogue("ie_crmk_grappleready1");
	level.allies[0] maps\_utility::smart_dialogue("crsh_crmk_gogogo");
}

//Function Number: 30
plant_tracker_waits()
{
	level.exfil_arms waittillmatch("enable_movement","single anim");
	level.player lerpviewangleclamp(0.5,0.25,0.25,10,10,10,10);
	level.exfil_arms waittillmatch("disable_movement","single anim");
	level.player lerpviewangleclamp(1,0.25,0.25,0,0,0,0);
	level.exfil_arms waittillmatch("fade_start","single anim");
	maps\_utility::nextmission();
}

//Function Number: 31
plant_tracker_rumbles()
{
	level.player waittill("grappled_to_vtol");
	var_00 = level.player maps\_utility::get_rumble_ent("ie_vtol_ride_rumble_low");
	var_00 maps\_utility::set_rumble_intensity(0.5);
	level.vtol waittillmatch("rumble_heavy1","single anim");
	var_00 delete();
	var_00 = level.player maps\_utility::get_rumble_ent("ie_vtol_ride_rumble");
	var_00 thread maps\_utility::rumble_ramp_to(0.3,2);
	common_scripts\utility::flag_wait("DETACHED_FROM_VTOL");
	var_00 maps\_utility::rumble_ramp_off(3);
	level.exfil_arms waittillmatch("player_impact_water_rumble","single anim");
	var_00 = level.player maps\_utility::get_rumble_ent("ie_vtol_ride_rumble");
	var_00 maps\_utility::set_rumble_intensity(0.5);
	wait(0.1);
	var_00 maps\_utility::rumble_ramp_off(2);
}

//Function Number: 32
tracking_device_waits()
{
	level.vtol waittillmatch("tracker_anim_start","single anim");
	level.tracking_device show();
	level.tracking_device maps\_anim::anim_single_solo(level.tracking_device,"tracking_device_plant");
}

//Function Number: 33
breathers()
{
	var_00 = maps\_utility::spawn_anim_model("generic_prop_raven");
	var_00 hide();
	level.anim_struct_exfil maps\_anim::anim_first_frame_solo(var_00,"exfil_breathers");
	var_01 = spawn("script_model",(0,0,0));
	var_01 setmodel("udt_respirator_small");
	var_01 linkto(var_00,"j_prop_1",(0,0,0),(0,0,0));
	var_02 = spawn("script_model",(0,0,0));
	var_02 setmodel("udt_respirator_small");
	var_02 linkto(var_00,"j_prop_2",(0,0,0),(0,0,0));
	level.vtol waittillmatch("ally_anim_start","single anim");
	thread sentinel_team_vo();
	level.anim_struct_exfil maps\_anim::anim_single_solo(var_00,"exfil_breathers");
}

//Function Number: 34
detach_motion_blur_enable()
{
	setsaveddvar("r_mbEnable",2);
	setsaveddvar("r_mbVelocityScalar",4);
}

//Function Number: 35
detach_motion_blur_disable()
{
	setsaveddvar("r_mbEnable",0);
	setsaveddvar("r_mbVelocityScalar",1);
}

//Function Number: 36
running_up_the_stairs_fail()
{
	level endon("start_exfil_moment");
	wait(5);
	level.allies[0] maps\_utility::smart_dialogue("ie_crmk_moveit3");
	wait(5);
	level.allies[0] maps\_utility::smart_dialogue("ie_crmk_takeoff");
	wait(5);
	maps\_player_death::set_deadquote(&"IRONS_ESTATE_VTOL_GRAPPLE_FAIL");
	maps\_utility::missionfailedwrapper();
}

//Function Number: 37
landing_pad_lights_off()
{
	var_00 = getent("landing_pad_lights","targetname");
	var_00 hide();
}

//Function Number: 38
landing_pad_lights_on()
{
	var_00 = getent("landing_pad_lights","targetname");
	var_00 show();
}

//Function Number: 39
sentinel_team_vo()
{
	wait(7);
	maps\_utility::smart_radio_dialogue("ie_ss1_getem");
	wait(1);
	maps\_utility::smart_radio_dialogue("ie_kp_bringemhome");
}

//Function Number: 40
cloud_fx()
{
	common_scripts\utility::flag_wait("player_started_vtol_grapple");
	common_scripts\_exploder::exploder(11);
	common_scripts\_exploder::exploder(12);
}

//Function Number: 41
dive_fx()
{
	common_scripts\utility::flag_wait("DETACHED_FROM_VTOL");
	maps\_utility::stop_exploder(11);
	maps\_utility::stop_exploder(12);
	wait(1.4);
	common_scripts\_exploder::exploder(10);
}

//Function Number: 42
landing_pad_lift_upper_static_setup()
{
	var_00 = getent("landing_pad_lift_upper_static","targetname");
	var_00 hide();
	var_00 notsolid();
	common_scripts\utility::flag_wait("start_exfil_moment_final");
	level.anim_struct_exfil maps\_anim::anim_first_frame_solo(level.lower_stairwell_door,"lower_stairwell_door");
	var_00 show();
	var_00 solid();
	var_01 = getent("landing_pad_lift","targetname");
	var_01 delete();
}