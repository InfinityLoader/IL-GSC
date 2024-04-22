/*******************************************************************
 * Decompiled By: Bog
 * Decompiled File: detroit_school.gsc
 * Game: Call of Duty: Advanced Warfare
 * Platform: PC
 * Function Count: 171
 * Decompile Time: 2592 ms
 * Timestamp: 4/22/2024 2:28:19 AM
*******************************************************************/

//Function Number: 1
school_main()
{
	common_scripts\utility::flag_init("hazmat_creeps_reload_ok");
	common_scripts\utility::flag_init("ok_to_wall_pull");
	common_scripts\utility::flag_init("_stealth_enabled");
	common_scripts\utility::flag_init("special_kva_alerted");
	school_animated_fences();
	thread setup_school();
	thread audio_stingers_school_bodies_room();
	thread enable_school_trains();
	if(level.currentgen)
	{
		cg_school_entrance_doors_init();
		thread transient_middle_remove_school_interior_begin();
		thread cg_setup_school_entrance_doors_startpoints();
	}
}

//Function Number: 2
cg_school_entrance_doors_init()
{
	var_00 = getent("det_school_entrance_door_r","targetname");
	var_00.coll = getent("det_school_entrance_door_r_coll","targetname");
	var_00.coll linkto(var_00);
	var_00.closed_angles = var_00.angles;
	var_00.open_angles = var_00.closed_angles + (0,90,0);
	var_01 = getent("det_school_entrance_door_l","targetname");
	var_01.coll = getent("det_school_entrance_door_l_coll","targetname");
	var_01.coll linkto(var_01);
	var_01.closed_angles = var_01.angles;
	var_01.open_angles = var_01.closed_angles - (0,90,0);
}

//Function Number: 3
cg_open_close_school_entrance_doors(param_00)
{
	if(level.currentgen)
	{
		var_01 = getent("det_school_entrance_door_r","targetname");
		var_02 = getent("det_school_entrance_door_l","targetname");
		if(param_00)
		{
			var_01.coll connectpaths();
			var_01 rotateto(var_01.open_angles,1,0.5,0.25);
			var_02.coll connectpaths();
			var_02 rotateto(var_02.open_angles,1,0.5,0.25);
			return;
		}

		var_01 rotateto(var_01.closed_angles,1,0.5,0.25);
		var_01.coll disconnectpaths();
		var_02 rotateto(var_02.closed_angles,1,0.5,0.25);
		var_02.coll disconnectpaths();
	}
}

//Function Number: 4
cg_setup_school_entrance_doors_startpoints()
{
	if(level.currentgen && issubstr(level.transient_zone,"school"))
	{
		cg_open_close_school_entrance_doors(1);
		return;
	}

	if(level.currentgen && issubstr(level.transient_zone,"hospital"))
	{
		cg_open_close_school_entrance_doors(0);
	}
}

//Function Number: 5
transient_middle_add_school_interior_begin()
{
	level notify("tff_pre_middle_remove_gatetrans");
	if(!istransientloaded("detroit_school_interior_tr"))
	{
		unloadtransient("detroit_gatetrans_tr");
		loadtransient("detroit_school_interior_tr");
	}

	for(;;)
	{
		if(istransientloaded("detroit_school_interior_tr"))
		{
			level notify("tff_post_middle_add_school");
			break;
		}

		wait(0.05);
	}

	cg_open_close_school_entrance_doors(1);
}

//Function Number: 6
transient_middle_remove_school_interior_begin()
{
	maps\_utility::trigger_wait_targetname("CG_UnloadSchoolInteriorTrigger");
	level notify("tff_pre_middle_remove_school");
	unloadtransient("detroit_school_interior_tr");
	for(;;)
	{
		if(!istransientloaded("detroit_school_interior_tr"))
		{
			level notify("tff_post_middle_remove_school");
			break;
		}

		wait(0.05);
	}

	thread transient_middle_add_nighclub_interior_begin();
}

//Function Number: 7
transient_middle_add_nighclub_interior_begin()
{
	loadtransient("detroit_nightclub_interior_tr");
	for(;;)
	{
		if(istransientloaded("detroit_nightclub_interior_tr"))
		{
			var_00 = getent("office_interior_model","targetname");
			var_00 setcontents(0);
			var_00 hide();
			level notify("tff_post_middle_add_nightclub");
			break;
		}

		wait(0.05);
	}
}

//Function Number: 8
school_animated_fences()
{
	if(!isdefined(level.bones_fence))
	{
		var_00 = getent("actual_dismount_animation_origin","targetname");
		level.bones_fence = maps\_utility::spawn_anim_model("bones_fence");
		level.joker_fence = maps\_utility::spawn_anim_model("joker_fence");
		level.bones_fence.animname = "bones_fence";
		level.joker_fence.animname = "joker_fence";
		var_00 thread maps\_anim::anim_first_frame_solo(level.bones_fence,"bike_dismount");
		var_00 thread maps\_anim::anim_first_frame_solo(level.joker_fence,"bike_dismount");
		var_01 = common_scripts\utility::getstruct("school_origin_02","targetname");
		level.bones_fence overridelightingorigin(var_01.origin);
		level.joker_fence overridelightingorigin(var_01.origin);
	}
}

//Function Number: 9
player_exiting()
{
	level endon("player_linked");
	maps\_utility::trigger_wait_targetname("player_trying_to_exit_garage");
	maps\_player_death::set_deadquote(&"DETROIT_OBJECTIVE_FAIL_JETBIKE");
	maps\_utility::missionfailedwrapper();
}

//Function Number: 10
debug_stealth_type()
{
	level waittill("event_awareness",var_00);
}

//Function Number: 11
setup_school_stealth()
{
	while(!isdefined(level.burke))
	{
		wait 0.05;
	}

	level.burke.ignoreme = 1;
	stealth_reset_awareness();
}

//Function Number: 12
stealth_reset_awareness()
{
	var_00 = level._stealth.group.groups;
	foreach(var_07, var_02 in var_00)
	{
		var_03 = maps\_stealth_shared_utilities::group_get_ai_in_group(var_07);
		foreach(var_05 in var_03)
		{
			if(var_05 maps\_utility::ent_flag_exist("_stealth_normal") && !var_05 maps\_utility::ent_flag("_stealth_normal"))
			{
				var_05 maps\_utility::ent_flag_set("_stealth_normal");
			}
		}
	}
}

//Function Number: 13
school_funtions_to_load()
{
	thread burke_path_to_school();
	thread setup_school_bodies();
	thread burke_deadroom_door();
	thread teleport_burke_to_alley();
}

//Function Number: 14
busted_light_gag()
{
	var_00 = getent("busted_light_gag_animorg","targetname");
	var_01 = maps\_utility::spawn_anim_model("working_light",var_00.origin);
	var_02 = maps\_utility::spawn_anim_model("busted_light",var_00.origin);
	var_02 hide();
	var_00 maps\_anim::anim_first_frame_solo(var_01,"busted_light_gag");
	var_00 maps\_anim::anim_first_frame_solo(var_02,"busted_light_gag");
	thread maps\detroit_lighting::hallway_light_scare();
	maps\_utility::trigger_wait_targetname("tile_fall");
	var_01 delete();
	var_02 show();
	var_00 thread maps\_anim::anim_single_solo(var_02,"busted_light_gag");
	playfxontag(common_scripts\utility::getfx("fluorecent_bulb_pop"),var_02,"tag_fx");
	var_02 soundscripts\_snd::snd_message("horror_fluorescent_break");
	wait(0.5);
	common_scripts\utility::flag_set("vo_school_light_burst_dialogue");
}

//Function Number: 15
play_garage_bike_dismount(param_00,param_01,param_02,param_03)
{
	var_04 = [param_00,param_01,param_02];
	foreach(var_06 in var_04)
	{
		var_06 vehphys_disablecrashing();
	}

	thread burke_dismount(param_00,param_01,param_02);
	thread bones_dismount(param_01);
	thread joker_dismount(param_02);
	thread player_dismount_newbike(param_03);
}

//Function Number: 16
flag_wait_bones()
{
	common_scripts\utility::flag_wait("begin_bike_dismount_bones");
	iprintlnbold("bones dismount flag called");
}

//Function Number: 17
flag_wait_joker()
{
	common_scripts\utility::flag_wait("begin_bike_dismount_joker");
	iprintlnbold("joker dismount flag called");
}

//Function Number: 18
flag_wait_burke()
{
	common_scripts\utility::flag_wait("begin_bike_dismount_burke");
	iprintlnbold("burke dismount flag called");
}

//Function Number: 19
swap_bike_to_static()
{
	common_scripts\utility::flag_wait("school_player_falling");
	level notify("stop_tracking_backtrack");
	var_00 = spawn("script_model",self.origin);
	var_00.angles = self.angles;
	var_00 setmodel("vehicle_mil_hoverbike_parked_static");
	self delete();
	common_scripts\utility::flag_wait("exit_drive_cinematic_start");
	var_00 delete();
}

//Function Number: 20
burke_dismount(param_00,param_01,param_02)
{
	common_scripts\utility::flag_wait("begin_bike_dismount_burke");
	param_00 maps\detroit_jetbike::vehicle_rubberband_stop();
	var_03 = getent("actual_dismount_animation_origin","targetname");
	thread intro_dialogue();
	thread maps\detroit_lighting::jetbike_dismount_red_light();
	thread burke_move_ahead_wait_function();
	param_00.animname = "burke_bike";
	param_00 maps\detroit_jetbike::vehicle_rubberband_stop();
	vehicle_scripts\_jetbike::smooth_vehicle_animation_wait(param_00,var_03,"bike_dismount",13.1695);
	level.burke unlink();
	level.burke maps\_vehicle_aianim::disassociate_guy_from_vehicle();
	param_00 maps\_utility::delaythread(5,::vehicle_scripts\_jetbike::jetbike_stop_hovering_now);
	maps\_utility::delaythread(7.5,::common_scripts\utility::flag_set,"school_trains");
	param_00 overridematerialreset();
	param_01 overridematerialreset();
	param_02 overridematerialreset();
	thread vehicle_scripts\_jetbike::smooth_vehicle_animation_play(param_00,var_03,"bike_dismount",[level.burke],1,2);
	thread burke_dismount_timing_fix();
	wait(getanimlength(level.scr_anim["burke"]["bike_dismount"]));
	var_03 thread maps\_anim::anim_loop_solo(level.burke,"dismount_idle","burke_stop_idle");
	param_00 thread swap_bike_to_static();
	var_03 notify("burke_stop_idle");
	if(level.nextgen)
	{
	}

	var_03 maps\_anim::anim_single_solo(level.burke,"dismount_rollout");
	level.burke maps\_utility::set_generic_run_anim("stealth_walk",0);
	school_funtions_to_load();
}

//Function Number: 21
burke_dismount_timing_fix()
{
	wait(7.9);
	common_scripts\utility::flag_set("vo_school_exterior");
}

//Function Number: 22
burke_move_ahead_wait_function()
{
	maps\_shg_design_tools::waittill_trigger_with_name("ride_finished");
	common_scripts\utility::flag_set("player_has_dismounted_and_moved_ahead");
}

//Function Number: 23
bones_dismount(param_00)
{
	common_scripts\utility::flag_wait_any("begin_bike_dismount_bones","begin_playing_player_dismount_anim");
	param_00 maps\detroit_jetbike::vehicle_rubberband_stop();
	var_01 = getent("actual_dismount_animation_origin","targetname");
	param_00.animname = "bones_bike";
	param_00 maps\detroit_jetbike::vehicle_rubberband_stop();
	vehicle_scripts\_jetbike::smooth_vehicle_animation_wait(param_00,var_01,"bike_dismount",7.51324);
	level.bones unlink();
	level.bones maps\_vehicle_aianim::disassociate_guy_from_vehicle();
	param_00 maps\_utility::delaythread(5,::vehicle_scripts\_jetbike::jetbike_stop_hovering_now);
	vehicle_scripts\_jetbike::smooth_vehicle_animation_play(param_00,var_01,"bike_dismount",[level.bones,level.bones_fence],1,2);
	param_00 thread swap_bike_to_static();
	var_02 = getnode("bones_hide_spot","targetname");
	level.bones setgoalnode(var_02);
	level.bones.goalradius = 15;
	level.bones waittill("goal");
	level.bones delete();
}

//Function Number: 24
joker_dismount(param_00)
{
	common_scripts\utility::flag_wait("begin_bike_dismount_joker");
	param_00 maps\detroit_jetbike::vehicle_rubberband_stop();
	var_01 = getent("actual_dismount_animation_origin","targetname");
	param_00.animname = "joker_bike";
	param_00 maps\detroit_jetbike::vehicle_rubberband_stop();
	vehicle_scripts\_jetbike::smooth_vehicle_animation_wait(param_00,var_01,"bike_dismount",12.7558);
	level.joker unlink();
	level.joker maps\_vehicle_aianim::disassociate_guy_from_vehicle();
	param_00 maps\_utility::delaythread(5,::vehicle_scripts\_jetbike::jetbike_stop_hovering_now);
	vehicle_scripts\_jetbike::smooth_vehicle_animation_play(param_00,var_01,"bike_dismount",[level.joker,level.joker_fence],1,2);
	param_00 thread swap_bike_to_static();
	var_02 = getnode("joker_hide_spot","targetname");
	level.joker setgoalnode(var_02);
	level.joker.goalradius = 15;
	level.joker waittill("goal");
	level.joker delete();
}

//Function Number: 25
player_dismount()
{
	common_scripts\utility::flag_wait("begin_bike_dismount_player");
	var_00 = getent("actual_dismount_animation_origin","targetname");
	level.player_bike.animname = "player_bike";
	vehicle_scripts\_jetbike::smooth_vehicle_animation_wait(level.player_bike,var_00,"bike_dismount",11.1633);
	if(isdefined(level.player_bike.world_body))
	{
		var_01 = level.player_bike.world_body;
		var_01 unlink();
	}
	else
	{
		var_01 = maps\_utility::spawn_anim_model("world_body",level.player.origin);
	}

	level.player_bike maps\_utility::delaythread(5,::vehicle_scripts\_jetbike::jetbike_stop_hovering_now);
	thread player_dismount_link_player_end_of_frame(var_01);
	vehicle_scripts\_jetbike::smooth_vehicle_animation_play(level.player_bike,var_00,"bike_dismount",[var_01],1,2);
	maps\detroit_anim::player_bike_to_ai_model();
	common_scripts\utility::flag_set("obj_check_school_give");
	common_scripts\utility::flag_set("ride_over");
	var_01 delete();
	level.player unlink();
	level.player maps\_shg_utility::setup_player_for_gameplay();
	level.player enablehybridsight("iw5_bal27_sp_silencer01_variablereddot",1);
	setsaveddvar("ammoCounterHide","0");
	thread maps\_utility::autosave_by_name("seeker");
	if(level.currentgen)
	{
		thread transient_middle_add_school_interior_begin();
	}

	level.player_bike thread swap_bike_to_static();
}

//Function Number: 26
checking_for_flag()
{
	iprintlnbold("checking for flag is called");
	common_scripts\utility::flag_wait("begin_playing_player_dismount_anim");
	iprintlnbold("the flag has been set");
}

//Function Number: 27
player_dismount_newbike(param_00)
{
	level endon("dont_do_old_dismount");
	common_scripts\utility::flag_wait("begin_playing_player_dismount_anim");
	thread player_school_disable_values();
	var_01 = getent("actual_dismount_animation_origin","targetname");
	param_00.animname = "player_bike";
	vehicle_scripts\_jetbike::smooth_vehicle_animation_wait(param_00,var_01,"bike_dismount",11.1633);
	if(isdefined(param_00.world_body))
	{
		var_02 = param_00.world_body;
		var_02 unlink();
	}
	else
	{
		var_02 = maps\_utility::spawn_anim_model("world_body",level.player.origin);
	}

	param_00 maps\_utility::delaythread(5,::vehicle_scripts\_jetbike::jetbike_stop_hovering_now);
	thread rumble_killer(7.6);
	thread player_dismount_link_player_end_of_frame(var_02);
	vehicle_scripts\_jetbike::smooth_vehicle_animation_play(param_00,var_01,"bike_dismount",[var_02],1,2);
	param_00 setmodel("vehicle_mil_hoverbike_ai");
	level notify("switch_bikes_to_ai");
	common_scripts\utility::flag_set("obj_check_school_give");
	common_scripts\utility::flag_set("vo_school_exterior");
	common_scripts\utility::flag_set("ride_over");
	var_02 delete();
	level.player unlink();
	level.player maps\_shg_utility::setup_player_for_gameplay();
	level.player thread maps\detroit::give_regular_grenades();
	thread block_from_going_back();
	level.player enablehybridsight("iw5_bal27_sp_silencer01_variablereddot",1);
	setsaveddvar("ammoCounterHide","0");
	level.player thread maps\_player_exo::player_exo_activate();
	level.player enableoffhandweapons();
	thread maps\_utility::autosave_by_name("seeker");
	if(level.currentgen)
	{
		thread transient_middle_add_school_interior_begin();
	}

	param_00 thread swap_bike_to_static();
	var_03 = getent("player_trying_to_exit_garage_warning","targetname");
	thread player_exiting();
	thread maps\detroit_hospital::mission_fail_warning(var_03);
}

//Function Number: 28
rumble_killer(param_00)
{
	wait(param_00);
	stopallrumbles();
}

//Function Number: 29
block_from_going_back()
{
	level endon("stop_tracking_backtrack");
	maps\_utility::trigger_wait_targetname("play_garage_animation_sequence");
	maps\_player_death::set_deadquote(&"DETROIT_OBJECTIVE_FAIL_JETBIKE");
	maps\_utility::missionfailedwrapper();
}

//Function Number: 30
player_school_disable_values()
{
	maps\_utility::trigger_wait_targetname("move_burke_ahead");
	level.player allowdodge(0);
	level.player allowsprint(0);
}

//Function Number: 31
player_dismount_link_player_end_of_frame(param_00)
{
	waittillframeend;
	level.player maps\_shg_utility::setup_player_for_scene(0);
	level.player playerlinktodelta(param_00,"tag_player",1,70,70,60,20,1);
	level.player lerpviewangleclamp(2,0,0,0,0,0,0);
}

//Function Number: 32
intro_dialogue()
{
	level endon("player_has_started_outside_combat");
	wait(7.5);
	wait(2.5);
	maps\_utility::stop_exploder("4011");
	maps\_utility::delaythread(5,::common_scripts\utility::flag_set,"bike_lights_off");
	level notify("huddle_dof_off");
}

//Function Number: 33
enable_school_trains()
{
	common_scripts\utility::flag_wait("school_trains");
	var_00 = 15;
	var_01 = 25;
	var_02 = 1400;
	var_03 = 2200;
	wait(5);
	thread spawn_reverse_school_train(var_02 + var_03 - var_03 / 2);
	thread spawn_trains_track1(var_00,var_01,var_02,var_03);
	thread spawn_trains_track2(var_00,var_01,var_02,var_03);
}

//Function Number: 34
spawn_trains_track1(param_00,param_01,param_02,param_03)
{
	while(!common_scripts\utility::flag("school_player_falling"))
	{
		wait(randomintrange(param_00,param_01));
		thread spawn_a_school_train(randomintrange(param_02,param_03));
	}

	common_scripts\utility::flag_wait("flag_reenable_school_trains");
	while(!common_scripts\utility::flag("hospital_escape_trains_only"))
	{
		wait(randomintrange(param_00,param_01));
		thread spawn_a_school_train(randomintrange(param_02,param_03));
	}
}

//Function Number: 35
spawn_trains_track2(param_00,param_01,param_02,param_03)
{
	while(!common_scripts\utility::flag("school_player_falling"))
	{
		wait(randomintrange(param_00,param_01));
		thread spawn_reverse_school_train(randomintrange(param_02,param_03));
	}

	common_scripts\utility::flag_wait("flag_reenable_school_trains");
	while(!common_scripts\utility::flag("hospital_escape_trains_only"))
	{
		wait(randomintrange(param_00,param_01));
		thread spawn_reverse_school_train(randomintrange(param_02,param_03));
	}
}

//Function Number: 36
spawn_a_school_train(param_00)
{
	if(!common_scripts\utility::flag("hospital_escape_trains_only"))
	{
		var_01 = getent("school_train_path_start","targetname");
		var_02 = getentarray("school_train_path","targetname");
		var_03 = maps\detroit_exit_drive::run_train(var_01,var_02,param_00);
		var_03 thread maps\detroit_exit_drive::player_proximity_rumble(1500);
		var_03 waittill("death");
	}
}

//Function Number: 37
spawn_right_hospital_train(param_00)
{
	var_01 = getent("train_path_special_right_start","targetname");
	var_02 = getentarray("train_path_special_right","targetname");
	var_03 = maps\detroit_hospital::run_train_with_shaking(var_01,var_02,param_00);
	var_03 thread maps\detroit_exit_drive::player_proximity_rumble(850);
	var_03 waittill("death");
}

//Function Number: 38
spawn_left_hospital_train(param_00)
{
	var_01 = getent("train_path_special_left_start","targetname");
	var_02 = getentarray("train_path_special_left","targetname");
	var_03 = maps\detroit_hospital::run_train_with_shaking(var_01,var_02,param_00);
	var_03 thread maps\detroit_exit_drive::player_proximity_rumble(850);
	var_03 waittill("death");
}

//Function Number: 39
spawn_reverse_school_train(param_00)
{
	if(!common_scripts\utility::flag("hospital_escape_trains_only"))
	{
		var_01 = getent("school_train2_path_start","targetname");
		var_02 = getentarray("school_train2_path","targetname");
		var_03 = maps\detroit_exit_drive::run_train(var_01,var_02,param_00);
		var_03 thread maps\detroit_exit_drive::player_proximity_rumble(1500);
		var_03 waittill("death");
	}
}

//Function Number: 40
monitor_flashlight_burke()
{
	maps\_shg_design_tools::waittill_trigger_with_name("move_burke_ahead");
	level.burke maps\detroit_lighting::add_burke_flashlight("flashlight",1);
}

//Function Number: 41
burke_path_to_school()
{
	thread monitor_flashlight_burke();
	var_00 = getent("burke_outside_hide","targetname");
	thread school_objective();
	var_00 maps\_anim::anim_single_solo(level.burke,"burke_school_approach");
	thread maps\detroit::battle_chatter_off_both();
	if(maps\_utility::players_within_distance(300,level.burke.origin))
	{
		level.burke burke_school_approach_idle_skip(var_00);
	}
	else
	{
		level.burke burke_school_approach_idle(var_00);
	}

	common_scripts\utility::flag_set("vo_school_cleaning_crew_ahead");
	thread maps\_utility::autosave_by_name();
	if(maps\_utility::players_within_distance(300,level.burke.origin))
	{
		level.burke burke_wall_idle_skip(var_00);
	}
	else
	{
		level.burke burke_wall_idle(var_00);
	}

	common_scripts\utility::flag_set("vo_school_checkpoint_blue");
	thread maps\_utility::autosave_by_name();
	burke_at_school_door();
	burke_busted_light();
	level notify("ok_to_start_school");
	level.burke maps\_utility::set_moveplaybackrate(1);
}

//Function Number: 42
burke_school_approach_idle_skip(param_00)
{
	param_00 maps\_anim::anim_single_solo(self,"burke_goto_trash");
}

//Function Number: 43
burke_school_approach_idle(param_00)
{
	param_00 maps\_anim::anim_single_solo(self,"burke_school_approach_into");
	param_00 thread maps\_anim::anim_loop_solo(self,"burke_school_approach_idle","ender");
	is_player_near_burke_or_flag(450,"to_school_player_02");
	param_00 notify("ender");
	param_00 maps\_anim::anim_single_solo(self,"burke_school_approach_out");
}

//Function Number: 44
burke_wall_idle_skip(param_00)
{
	param_00 maps\_anim::anim_single_solo(self,"burke_goto_school");
	param_00 thread maps\_anim::anim_loop_solo(self,"burke_stairs_idle","ender");
	is_player_near_burke_or_flag(undefined,"to_school_player_02");
	param_00 notify("ender");
}

//Function Number: 45
burke_wall_idle(param_00)
{
	param_00 maps\_anim::anim_single_solo(self,"burke_wall_wait_into");
	param_00 thread maps\_anim::anim_loop_solo(self,"burke_wall_wait_idle","ender");
	is_player_near_burke_or_flag(300,"to_school_player_02");
	param_00 notify("ender");
	param_00 maps\_anim::anim_single_solo(self,"burke_wall_wait_out");
	param_00 thread maps\_anim::anim_loop_solo(self,"burke_stairs_idle","ender_stairs_idle");
	is_player_near_burke_or_flag(undefined,"flag_player_entering_school");
	param_00 notify("ender_stairs_idle");
}

//Function Number: 46
burke_at_school_door()
{
	thread busted_light_gag();
	var_00 = getent("burke_bodies_anim_origin","targetname");
	var_00 maps\_anim::anim_single_solo(level.burke,"burke_goto_corner");
	var_00 thread maps\_anim::anim_loop_solo(level.burke,"burke_corner_idle","ender_school_door_idle");
	common_scripts\utility::flag_wait("player_near_burke_school_corner");
	thread maps\_utility::autosave_by_name();
	var_00 notify("ender_school_door_idle");
}

//Function Number: 47
burke_busted_light()
{
	var_00 = getent("burke_bodies_anim_origin","targetname");
	var_00 maps\_anim::anim_single_solo(level.burke,"burke_goto_bodies");
}

//Function Number: 48
school_objective()
{
	wait(19.03);
	common_scripts\utility::flag_set("check_school");
}

//Function Number: 49
is_player_near_burke(param_00)
{
	if(!isdefined(param_00))
	{
		param_00 = 150;
	}

	var_01 = 0;
	for(;;)
	{
		if(isdefined(level.burke))
		{
			var_01 = distance2d(level.burke.origin,level.player.origin);
			if(var_01 < param_00)
			{
				return;
			}
		}

		wait(0.05);
	}

	wait(1.5);
}

//Function Number: 50
is_1_near_2(param_00,param_01,param_02)
{
	for(;;)
	{
		if(distance2d(param_00.origin,param_01.origin) < param_02)
		{
			return;
		}

		wait(0.05);
	}
}

//Function Number: 51
is_player_near_burke_or_flag(param_00,param_01)
{
	level endon(param_01);
	if(!isdefined(param_00))
	{
		param_00 = 150;
	}

	if(common_scripts\utility::flag(param_01))
	{
		return;
	}

	var_02 = 0;
	for(;;)
	{
		if(isdefined(level.burke))
		{
			var_02 = distance2d(level.burke.origin,level.player.origin);
			if(var_02 < param_00)
			{
				return;
			}
		}

		wait(0.05);
	}
}

//Function Number: 52
continue_when_player_near_entity(param_00,param_01,param_02)
{
	if(!isdefined(param_01))
	{
		param_01 = 150;
	}

	var_03 = 0;
	for(;;)
	{
		if(isdefined(param_00))
		{
			var_04 = distance2d(param_00.origin,level.player.origin);
			if(var_04 < param_01)
			{
				return;
			}
		}

		if(isdefined(param_02))
		{
			var_04 = distance2d(param_00.origin,param_02.origin);
			if(var_04 < param_01)
			{
				return;
			}
		}

		wait(0.05);
	}

	wait(1.5);
}

//Function Number: 53
teleport_burke_to_alley()
{
	var_00 = getnode("ally_burke_start_onfoot","targetname");
	common_scripts\utility::flag_wait("flag_reenable_school_trains");
	level.burke delete();
	common_scripts\utility::flag_wait("vo_school_burke_external");
	var_01 = getent("burke_spawner","targetname");
	var_01.count = 1;
	level.burke = maps\detroit::setup_burke();
	level.burke maps\_utility::teleport_ai(var_00);
}

//Function Number: 54
player_basement_objective_mover()
{
	var_00 = getent("basement_objective_org1","targetname");
	var_01 = getent("basement_objective_org2","targetname");
	var_02 = getent("basement_objective_org3","targetname");
	var_03 = getent("basement_objective_org4","targetname");
	maps\_utility::trigger_wait_targetname("player_fall_basement_trigger");
	common_scripts\utility::flag_wait("basement_string_objectives");
	objective_position(maps\_utility::obj("Reunite with Burke"),var_00.origin);
	is_1_near_2(level.player,var_00,90);
	objective_position(maps\_utility::obj("Reunite with Burke"),var_01.origin);
	is_1_near_2(level.player,var_01,225);
	objective_position(maps\_utility::obj("Reunite with Burke"),var_02.origin);
	is_1_near_2(level.player,var_02,225);
	objective_position(maps\_utility::obj("Reunite with Burke"),var_03.origin);
}

//Function Number: 55
distance_check_loop(param_00,param_01)
{
	level endon("stop_loop_check");
	wait(2);
	for(;;)
	{
		var_02 = distance2d(param_00.origin,param_01.origin);
		iprintln(var_02);
		wait(0.05);
	}
}

//Function Number: 56
return_boost_dash()
{
	common_scripts\utility::flag_wait("rendezvous_obj_reached");
	maps\_player_exo::player_exo_activate();
}

//Function Number: 57
gideon_keep_up_fail_trigger(param_00)
{
	maps\_utility::trigger_wait_targetname(param_00);
	wait(randomfloatrange(1.1,2.4));
	maps\_player_death::set_deadquote(&"DETROIT_OBJECTIVE_FAIL_JETBIKE");
	maps\_utility::missionfailedwrapper();
}

//Function Number: 58
brick_smash_setup()
{
	thread wall_pull_animation();
}

//Function Number: 59
basement_jump_awareness()
{
	self endon("death");
	for(;;)
	{
		if(level.player isjumping())
		{
			if(distance2d(self.origin,level.player.origin) < 400)
			{
				wait(0.4);
				self notify("make_me_alert_now");
				return;
			}
		}

		wait(0.05);
	}
}

//Function Number: 60
audio_stingers_school_bodies_room()
{
	maps\_utility::trigger_wait_targetname("tile_fall");
	wait(7.73);
	soundscripts\_snd::snd_message("horror_burke_gets_up_after_tile");
	common_scripts\utility::flag_wait("open_school_door");
	soundscripts\_snd::snd_message("horror_burk_opens_bodies_room_door");
	common_scripts\utility::flag_wait("burke_leaving_bodies_room");
	soundscripts\_snd::snd_message("horror_ghost_runs_by_door");
	maps\_utility::trigger_wait_targetname("end_lightning_buildup_trigger");
	soundscripts\_snd::snd_message("end_lightning_buildup");
}

//Function Number: 61
animate_dead_body(param_00,param_01)
{
	wait(38.5);
	param_01 maps\_anim::anim_single_solo(param_00,"touch_dead_npc");
	param_01 maps\_anim::anim_last_frame_solo(param_00,"touch_dead_npc");
}

//Function Number: 62
bodies_gag_door_trigger()
{
	common_scripts\utility::flag_wait("burke_needs_to_idle");
	var_00 = getent("bodies_room_gag_used","targetname");
	var_00 usetriggerrequirelookat();
	maps\_utility::enable_trigger_with_targetname("bodies_room_gag_used");
	objective_setpointertextoverride(maps\_utility::obj("Follow Gideon"),&"DETROIT_OPEN");
	var_01 = getent("bodies_room_gag_used","targetname") maps\_shg_utility::hint_button_trigger("use",200);
	common_scripts\utility::flag_set("obj_check_school_pos_door");
	level notify("show_glowing_door");
	var_00 sethintstring(&"DETROIT_PROMPT_OPEN");
	maps\_utility::trigger_wait_targetname("bodies_room_gag_used");
	objective_setpointertextoverride(maps\_utility::obj("Follow Gideon"),&"DETROIT_FOLLOW");
	objective_position(maps\_utility::obj("Follow Gideon"),(0,0,0));
	var_01 maps\_shg_utility::hint_button_clear();
	var_00 delete();
}

//Function Number: 63
burke_path_through_school()
{
	level waittill("ok_to_start_school");
	common_scripts\utility::flag_wait("flag_player_entering_school");
	level.burke get_burke_to_deadroom();
	maps\_utility::trigger_wait_targetname("start_kva_gag");
	level.player setmovespeedscale(0.6);
	level.burke.ignoreme = 1;
	level.player.ignoreme = 1;
	maps\_utility::trigger_wait_targetname("player_fall_basement_trigger");
	level.player.ignoreme = 0;
	maps\_utility::trigger_wait_targetname("disable_burke_ignoreme");
	level.burke.ignoreme = 0;
}

//Function Number: 64
school_fall_rumble()
{
	wait(1.41);
	var_00 = level.player maps\_utility::get_rumble_ent("steady_rumble");
	var_00 maps\_utility::set_rumble_intensity(0.29);
	var_00 maps\_utility::delaythread(0.14,::maps\_utility::set_rumble_intensity,0.01);
	var_00 maps\_utility::delaythread(1.75,::maps\_utility::set_rumble_intensity,0.81);
	var_00 maps\_utility::delaythread(2.2,::maps\_utility::set_rumble_intensity,0.01);
	var_00 maps\_utility::delaythread(12.36,::maps\_utility::set_rumble_intensity,0.09);
	var_00 maps\_utility::delaythread(12.82,::maps\_utility::set_rumble_intensity,0.41);
	var_00 maps\_utility::delaythread(13.3,::maps\_utility::set_rumble_intensity,0.09);
	var_00 maps\_utility::delaythread(14.49,::maps\_utility::set_rumble_intensity,0.03);
	var_00 maps\_utility::delaythread(14.64,::maps\_utility::set_rumble_intensity,0.54);
	var_00 maps\_utility::delaythread(15.24,::maps\_utility::set_rumble_intensity,0.01);
	wait(17);
	var_00 stoprumble("steady_rumble");
	var_00 delete();
}

//Function Number: 65
stop_all_rumble_on_time(param_00,param_01)
{
	wait(param_00);
	self stoprumble(param_01);
}

//Function Number: 66
lightning_gag()
{
	maps\_utility::trigger_wait_targetname("lightning_gag");
	maps\detroit_lighting::lightning_call_single("detroit_lightning_max",0.3,0.7);
}

//Function Number: 67
spawn_kva_downstairs()
{
	var_00 = getent("soldiers_downstairs_team1","targetname");
	var_01 = getent("soldiers_downstairs_team2","targetname");
	var_02 = getent("soldiers_downstairs_team3","targetname");
	var_03 = getent("soldiers_downstairs_team4","targetname");
	var_04 = [];
	var_04[var_04.size] = var_00 maps\_utility::spawn_ai(1);
	var_04[var_04.size] = var_02 maps\_utility::spawn_ai(1);
	foreach(var_09, var_06 in var_04)
	{
		var_06.ignoreall = 1;
		if(var_06 == var_04[0])
		{
			var_06 thread maps\detroit_lighting::add_enemy_flashlight("flashlight","med");
		}

		if(var_06 == var_04[1])
		{
			var_06 thread maps\detroit_lighting::add_enemy_flashlight("flashlight","med");
		}
		else
		{
			var_06 thread maps\detroit_lighting::add_enemy_flashlight("flashlight");
		}

		var_06.old_fovcosine = var_06.fovcosine;
		var_06.fovcosine = 0.95;
		var_06.combatmode = "no_cover";
		var_06.goalradius = 15;
		var_06 maps\detroit::set_patrol_anim_set("active",1);
		var_07 = var_09 + 1;
		var_08 = getnode("guy" + var_07 + "_goal","targetname");
		var_06 setgoalnode(var_08);
		var_06 thread stealth_delete_at_goal();
		var_06 thread alert_check_function();
		var_06 thread kill_me_on_notify();
		var_06 thread maps\_utility::set_moveplaybackrate(1.05);
	}

	level.school_kva_fall_notice_guy = var_04[1];
	common_scripts\utility::flag_set("vo_school_shimmy");
	maps\_shg_design_tools::waittill_trigger_with_name("trigger_shimmey_ok");
	return_stealth_distances();
}

//Function Number: 68
alert_check_function()
{
	self endon("death");
	maps\_stealth_utility::stealth_enemy_waittill_alert();
}

//Function Number: 69
youre_dead_functon()
{
	wait(3);
	maps\_player_death::set_deadquote("You\'ve blown your cover!");
	maps\_utility::missionfailedwrapper();
}

//Function Number: 70
youre_spoted_functon()
{
	wait(3);
	maps\_player_death::set_deadquote("You\'ve been spotted!");
	maps\_utility::missionfailedwrapper();
}

//Function Number: 71
enable_check_health()
{
	self endon("death");
	self endon("alert");
	var_00 = self.health;
	for(;;)
	{
		if(self.health < var_00)
		{
			level.player.ignoreme = 0;
			level.burke.ignoreme = 0;
			self.ignoreall = 0;
			thread youre_dead_functon();
			return;
		}

		wait(0.05);
	}
}

//Function Number: 72
enable_doorway_blocking()
{
	maps\_utility::trigger_wait_targetname("player_fall_basement_trigger");
	var_00 = getent("door_blocker_1","targetname");
	var_01 = getent("door_blocker_2","targetname");
	var_02 = getent("door_blocker_3","targetname");
	var_03 = getent("door_blocker_4","targetname");
	var_00 connectpaths();
	var_01 connectpaths();
	var_02 connectpaths();
	var_03 connectpaths();
	var_00 delete();
	var_01 delete();
	var_02 delete();
	var_03 delete();
}

//Function Number: 73
override_stealth_distances()
{
	level.old_stealth_numbers = [];
	level.old_stealth_numbers["prone"] = level._stealth.logic.detect_range["hidden"]["prone"];
	level.old_stealth_numbers["crouch"] = level._stealth.logic.detect_range["hidden"]["crouch"];
	level.old_stealth_numbers["stand"] = level._stealth.logic.detect_range["hidden"]["stand"];
	level._stealth.logic.detect_range["hidden"]["prone"] = level.old_stealth_numbers["prone"] / 5;
	level._stealth.logic.detect_range["hidden"]["crouch"] = level.old_stealth_numbers["crouch"] / 5;
	level._stealth.logic.detect_range["hidden"]["stand"] = level.old_stealth_numbers["stand"] / 5;
}

//Function Number: 74
return_stealth_distances()
{
	level._stealth.logic.detect_range["hidden"]["prone"] = level.old_stealth_numbers["prone"];
	level._stealth.logic.detect_range["hidden"]["crouch"] = level.old_stealth_numbers["crouch"];
	level._stealth.logic.detect_range["hidden"]["stand"] = level.old_stealth_numbers["stand"];
}

//Function Number: 75
stealth_delete_at_goal()
{
	self endon("alert");
	self waittill("goal");
	wait 0.05;
	self delete();
}

//Function Number: 76
basement_hide_setup()
{
	thread basement_door_school_anim();
	common_scripts\utility::flag_wait("flag_start_kva_basement");
	level thread exo_dodge_stealth_watcher();
	common_scripts\utility::flag_clear("school_trains");
	level.firstguy = maps\_utility::spawn_targetname("kva_basement_troop",1);
	level.firstguy maps\detroit::force_patrol_anim_set("active_right");
	level.firstguy thread make_me_alert("player_basement_spotted");
	level.firstguy thread bump_into_awareness();
	level.firstguy thread seek_player_on_detection();
	level.firstguy thread new_kva_basement_1();
	level.firstguy thread call_in_assistance();
	level.firstguy thread i_have_seen_the_player();
	level.firstguy.fovcosine = cos(45);
	level.firstguy waittill("enemy");
	common_scripts\utility::flag_set("vo_school_basement_sawsomething",level.firstguy);
}

//Function Number: 77
exo_dodge_stealth_watcher()
{
	level.player endon("death");
	while(level.player maps\_utility::ent_flag("_stealth_enabled"))
	{
		level.player waittill("exo_dodge");
		var_00 = maps\_utility::get_within_range(level.player.origin,getaiarray("axis"),500);
		foreach(var_02 in var_00)
		{
			if(isdefined(var_02._stealth))
			{
				var_02 notify("ai_event","gunshot");
				var_02 maps\_utility::set_favoriteenemy(level.player);
			}
		}
	}
}

//Function Number: 78
call_in_assistance()
{
	self endon("death");
	common_scripts\utility::waittill_any_ents(level,"_stealth_spotted",self,"shooting");
	hide1_shelf_delete();
	if(!common_scripts\utility::flag("flag_start_kva_2_basement"))
	{
		var_00 = getent("kva_basement_troop_2","targetname");
		var_01 = var_00 maps\_utility::spawn_ai(1);
		self.goalradius = 10;
		var_01.goalradius = 10;
		var_01 setgoalentity(level.player);
		var_01 notify("alert");
		var_01 notify("player_spotted");
		var_01 thread maps\_utility::player_seek();
		common_scripts\utility::flag_set("dont_spawn_basement_troop_2");
		level.player allowsprint(1);
	}
}

//Function Number: 79
hide1_shelf_delete()
{
	var_00 = getentarray("hide_1_shelf","targetname");
	foreach(var_02 in var_00)
	{
		var_02 delete();
	}
}

//Function Number: 80
hide2_shelf_delete()
{
	var_00 = getentarray("hide_2_shelf","targetname");
	foreach(var_02 in var_00)
	{
		var_02 delete();
	}
}

//Function Number: 81
spawn_third_floor_guy_for_assistance()
{
	var_00 = getent("spawner_school_f2_patroller_1","targetname");
	var_01 = var_00 maps\_utility::spawn_ai(1);
	var_01 thread maps\_utility::player_seek();
	common_scripts\utility::flag_set("dont_spawn_art_room_flashlight_guy");
	var_00.count = 1;
}

//Function Number: 82
walking_awareness()
{
	self endon("death");
	self endon("damage");
	for(;;)
	{
		var_00 = distance(self.origin,level.player.origin);
		if(var_00 < 300)
		{
			var_01 = length(level.player getvelocity());
			if(var_01 > 80)
			{
				if(level.player getstance() == "stand")
				{
					wait(0.4);
					self notify("make_me_alert_now");
					return;
				}
			}
		}

		wait(0.05);
	}
}

//Function Number: 83
bump_into_awareness()
{
	self endon("death");
	self endon("damage");
	for(;;)
	{
		var_00 = distance(self.origin,level.player.origin);
		if(var_00 < 45)
		{
			self notify("ai_event","gunshot");
			maps\_utility::set_favoriteenemy(level.player);
			return;
		}

		wait(0.05);
	}
}

//Function Number: 84
player_velocity_display(param_00)
{
	self endon("death");
	for(;;)
	{
		var_01 = length(param_00 getvelocity());
		iprintln(var_01);
		wait(0.05);
	}
}

//Function Number: 85
notify_spotted_player()
{
	self endon("death");
	self waittill("spotted_player");
	self stopanimscripted();
	maps\_utility::clear_run_anim();
}

//Function Number: 86
monitor_my_health()
{
	while(isalive(self))
	{
		iprintln(self.health);
		wait(1);
	}
}

//Function Number: 87
new_kva_basement_1()
{
	self.animname = "kva";
	self endon("death");
	self endon("_stealth_spotted");
	self endon("alert");
	level endon("player_has_been_spotted");
	self endon("enemy");
	maps\detroit_lighting::add_enemy_flashlight("flashlight","med");
	maps\detroit_lighting::enemy_flashlight_toggle_think("trig_flashlight_basement_on","trig_flashlight_basement_off");
	thread delete_guy_on_trigger_stealth("new_hall_troops_trigger");
	var_00 = getent("basement_door_open_anim_org","targetname");
	thread dont_animate_basement_door_on_death(var_00);
	var_01 = getnode("test_goal_node","targetname");
	var_02 = getent("kva_check_3_org","targetname");
	var_02 thread break_me_out_if_player_found();
	self setgoalnode(var_01);
	self waittill("goal");
	if(!common_scripts\utility::flag("player_basement_spotted"))
	{
		var_00 maps\_anim::anim_reach_solo(self,"door_open_basement",undefined,1);
	}

	if(!common_scripts\utility::flag("player_basement_spotted"))
	{
		common_scripts\utility::flag_set("open_school_basement_door");
		var_00 maps\_anim::anim_single_solo(self,"door_open_basement",undefined,1);
		common_scripts\utility::flag_set("connect_basement_door_clip");
	}

	if(!common_scripts\utility::flag("player_basement_spotted"))
	{
		var_02 maps\_anim::anim_reach_solo(self,"search_flashlight_low_basement_loop",undefined,1);
	}

	if(!common_scripts\utility::flag("player_basement_spotted"))
	{
		var_02 thread maps\_anim::anim_loop_solo(self,"search_flashlight_low_basement_loop");
		thread maps\_shg_design_tools::notify_relay(self,"enemy",var_02,"stop_loop");
	}
}

//Function Number: 88
break_me_out_if_player_found()
{
	level.firstguy endon("death");
	level.firstguy waittill("enemy");
	level.firstguy notify("end_patrol");
	level.firstguy notify("flashlight_off");
	level.firstguy.alwaysrunforward = undefined;
}

//Function Number: 89
dont_animate_basement_door_on_death(param_00)
{
	self waittill("death");
	level notify("stop_animating_the_basement_door");
}

//Function Number: 90
basement_door_school_anim()
{
	level endon("stop_animating_the_basement_door");
	var_00 = maps\_utility::spawn_anim_model("basement_door");
	var_00 thread dont_animate_on_kva_death();
	var_01 = getent("basement_door_open_anim_org","targetname");
	var_01 thread maps\_anim::anim_first_frame_solo(var_00,"door_open_basement");
	var_00 thread basement_door_clip_function();
	common_scripts\utility::flag_wait("open_school_basement_door");
	var_01 thread maps\_anim::anim_single_solo(var_00,"door_open_basement");
	wait(2.84);
	level notify("too_late_to_close_door");
}

//Function Number: 91
dont_animate_on_kva_death()
{
	level endon("too_late_to_close_door");
	level waittill("stop_animating_the_basement_door");
	self stopanimscripted();
}

//Function Number: 92
basement_troop_2()
{
	common_scripts\utility::flag_wait("flag_start_kva_2_basement");
	if(!common_scripts\utility::flag("dont_spawn_basement_troop_2"))
	{
		soundscripts\_snd::snd_message("kva_basement_idle_start");
		var_00 = getent("basement_investigate_origin","targetname");
		level.flashlight_guy = maps\_utility::spawn_targetname("kva_basement_troop_2",1);
		level.flashlight_guy endon("death");
		level.flashlight_guy thread bump_into_awareness();
		level.flashlight_guy maps\detroit::force_patrol_anim_set("active");
		level.flashlight_guy thread delete_guy_on_trigger_stealth("new_hall_troops_trigger");
		level.flashlight_guy maps\detroit_lighting::add_enemy_flashlight("flashlight","med");
		level.flashlight_guy maps\detroit_lighting::enemy_flashlight_toggle_think("trig_flashlight_basement_on","trig_flashlight_basement_off");
		level.flashlight_guy.animname = "kva";
		level.flashlight_guy thread se_kva_basement_2(var_00);
		level.flashlight_guy thread seek_player_on_detection();
		level.flashlight_guy thread i_have_seen_the_player();
		level.flashlight_guy waittill("enemy");
		common_scripts\utility::flag_set("vo_school_basement_sawsomething",level.flashlight_guy);
		level.flashlight_guy notify("end_patrol");
		level.flashlight_guy notify("flashlight_off");
		level.flashlight_guy maps\_utility::anim_stopanimscripted();
		getent("kva_2_flashlight_loop_org","targetname") maps\_utility::anim_stopanimscripted();
		var_00 notify("stop_searching_now");
	}
}

//Function Number: 93
delete_notify()
{
	self waittill("death");
}

//Function Number: 94
se_kva_basement_2(param_00)
{
	self endon("death");
	self endon("_spotted_player");
	self endon("enemy");
	self.fovcosine = cos(30);
	thread notify_valve_on_death();
	var_01 = maps\_utility::spawn_anim_model("valve");
	var_02 = maps\_utility::spawn_anim_model("generic_prop");
	thread steam_burst_function();
	self.animname = "kva";
	thread alert_stop_animating(param_00);
	param_00 thread maps\_anim::anim_first_frame_solo(var_01,"school_investigate");
	param_00 thread maps\_anim::anim_first_frame_solo(var_02,"school_investigate");
	var_03 = getent("kva_basement_gate_open","targetname");
	var_03 linkto(var_02,"tag_origin_animated");
	param_00 thread maps\_anim::anim_loop_solo(self,"basement_flashlight_idle","stop_searching_now");
	common_scripts\utility::flag_wait("steam_startle_flag");
	self.fovcosine = cos(60);
	if(!isalive(self))
	{
		return;
	}

	if(maps\_utility::ent_flag("_stealth_attack"))
	{
		return;
	}

	param_00 notify("stop_searching_now");
	soundscripts\_snd::snd_message("steam_burst_valve_started");
	soundscripts\_snd::snd_message("basement_investigate");
	level thread maps\detroit_fx::steam_spray_custom_function();
	level.kva_basement_guy = self;
	common_scripts\utility::flag_set("vo_school_basement_rats");
	var_04 = [var_01,var_02];
	param_00 thread basement_valve_and_door_stop_early(self,var_04,var_03,"school_investigate");
	param_00 maps\_anim::anim_single_solo(self,"school_investigate");
	var_05 = getent("kva_2_flashlight_loop_org","targetname");
	thread se_kva_basement_2_idle(var_05);
}

//Function Number: 95
basement_valve_and_door_stop_early(param_00,param_01,param_02,param_03)
{
	thread maps\_anim::anim_single(param_01,param_03);
	var_04 = 23.5;
	var_05 = param_00 common_scripts\utility::waittill_any_timeout(var_04,"enemy","death");
	if(var_05 == "timeout")
	{
		param_02 connectpaths();
		return;
	}

	foreach(var_07 in param_01)
	{
		var_07 setanimrate(var_07 maps\_utility::getanim(param_03),0);
	}

	maps\_utility::anim_stopanimscripted();
}

//Function Number: 96
seek_player_on_detection()
{
	self endon("death");
	self waittill("enemy");
	self notify("end_patrol");
	self.combatmode = "no_cover";
	for(;;)
	{
		self setgoalentity(level.player);
		self.goalradius = 4;
		wait(0.5);
	}
}

//Function Number: 97
stop_animating_when_kva2_dead()
{
	level waittill("stop_valve_animation");
	self stopanimscripted();
}

//Function Number: 98
notify_valve_on_death()
{
	self waittill("death");
	level notify("stop_valve_animation");
}

//Function Number: 99
valve_stop_animating()
{
	level waittill("stop_valve_animation");
	self stopanimscripted();
}

//Function Number: 100
steam_burst_function()
{
	common_scripts\utility::flag_wait("steam_startle_flag");
	common_scripts\_exploder::exploder(1759);
}

//Function Number: 101
alert_stop_animating(param_00)
{
	self endon("death");
	maps\_utility::ent_flag_wait("_stealth_attack");
	self stopanimscripted();
	param_00 stopanimscripted();
	common_scripts\utility::flag_set("kill_the_valve_anim");
	self notify("stop_searching_now");
	param_00 notify("stop_searching_now");
	level notify("stop_valve_animation");
}

//Function Number: 102
se_kva_basement_2_idle(param_00)
{
	self endon("death");
	self endon("enemy");
	if(!maps\_utility::ent_flag("_stealth_attack"))
	{
		param_00 maps\_anim::anim_reach_solo(self,"search_flashlight_low_basement_loop",undefined,1);
		param_00 thread maps\_anim::anim_loop_solo(self,"so_hijack_search_flashlight_high_loop");
	}
}

//Function Number: 103
stealth_guy_think()
{
	self endon("death");
	if(isai(self))
	{
		thread maps\detroit::disable_grenades();
		maps\_utility::ent_flag_init("spotted_player");
		self.fovcosine = 0.9;
		self.combatmode = "no_cover";
		common_scripts\utility::waittill_any_ents(self,"damage",self,"_stealth_spotted",self,"stealth_event",self,"enemy");
	}

	maps\_utility::ent_flag_set("spotted_player");
	if(isdefined(level.firstguy) && self == level.firstguy)
	{
		level notify("stop_animating_the_basement_door");
	}

	self notify("end_patrol");
	self stopanimscripted();
	self notify("flashlight_off");
	var_00 = level.player getweaponslist("primary");
	var_01 = 0;
	if(!isdefined(var_00))
	{
		var_01 = 1;
	}

	if(isarray(var_00))
	{
		foreach(var_03 in var_00)
		{
			if(issubstr(var_03,"unarmed"))
			{
				var_01 = 1;
			}
		}
	}

	if(var_01)
	{
		common_scripts\utility::flag_set("vo_school_basement_sawsomething",self);
	}
}

//Function Number: 104
i_have_seen_the_player()
{
	level endon("group_spotted_already");
	var_00 = common_scripts\utility::flag_wait("vo_school_basement_sawsomething");
	if(!isdefined(var_00))
	{
		return;
	}

	if(var_00.targetname == "kva_basement_troop_AI")
	{
		if(common_scripts\utility::flag("no_more_basement_alerts"))
		{
			return;
		}

		var_00 thread maps\_utility::dialogue_queue("det_kva_contact");
		common_scripts\utility::flag_set("no_more_basement_alerts");
		return;
	}

	if(var_00.targetname == "kva_basement_troop_2_AI")
	{
		if(common_scripts\utility::flag("no_more_basement_alerts"))
		{
			return;
		}

		var_00 thread maps\_utility::dialogue_queue("det_kva_huh");
		common_scripts\utility::flag_set("no_more_basement_alerts");
		return;
	}

	if(var_00.targetname == "spawner_school_f2_patroller_1_AI")
	{
		if(common_scripts\utility::flag("third_guy_alerted"))
		{
			return;
		}

		var_00 thread maps\_utility::dialogue_queue("det_kva_ivegotcontact");
		common_scripts\utility::flag_set("no_more_basement_alerts");
		common_scripts\utility::flag_set("third_guy_alerted");
		return;
	}
}

//Function Number: 105
delete_guy_on_trigger_stealth(param_00)
{
	self endon("alert");
	self endon("death");
	maps\_shg_design_tools::waittill_trigger_with_name(param_00);
	maps\_shg_design_tools::delete_auto();
}

//Function Number: 106
hall_troop_scare_moment()
{
	maps\_utility::trigger_wait_targetname("new_hall_troops_trigger");
	var_00 = getent("new_hall_troop_1","targetname");
	var_01 = getent("new_hall_troop_2","targetname");
	var_02 = getent("new_hall_troop_3","targetname");
	var_03 = var_00 maps\_utility::spawn_ai(1);
	var_04 = var_01 maps\_utility::spawn_ai(1);
	var_05 = var_02 maps\_utility::spawn_ai(1);
	var_06 = getnode("new_hall_troop_die_spot1","targetname");
	var_07 = getnode("new_hall_troop_die_spot2","targetname");
	var_08 = getnode("new_hall_troop_die_spot3","targetname");
	var_09 = [var_03,var_04,var_05];
	foreach(var_0B in var_09)
	{
		var_0B.ignoreall = 1;
		var_0B maps\detroit_lighting::add_enemy_flashlight("flashlight",1);
		var_0B thread nearby_shot_alert();
		var_0B thread maps\detroit_lighting::enemy_flashlight_toggle_think("trig_flashlight_patroller_on","trig_flashlight_patroller_off");
		var_0B.goalradius = 15;
		var_0B maps\_utility::enable_cqbwalk();
		var_0B thread break_ignore_all_on_damage();
		var_0B thread alert_when_another_is_hurt();
		var_0B thread kill_me_if_player_escapes();
	}

	var_03 setgoalnode(var_06);
	var_04 setgoalnode(var_07);
	var_05 setgoalnode(var_08);
	wait(1);
}

//Function Number: 107
kill_me_if_player_escapes()
{
	maps\_utility::trigger_wait_targetname("train_scare");
	if(isalive(self))
	{
		self delete();
	}
}

//Function Number: 108
nearby_shot_alert()
{
	self endon("death");
	for(;;)
	{
		if(level.player attackbuttonpressed())
		{
			if(distance(level.player.origin,self.origin) < 1000)
			{
				level notify("alert_stairs_team");
				return;
			}
		}

		wait(0.05);
	}
}

//Function Number: 109
delete_me_on_flag(param_00)
{
	common_scripts\utility::flag_wait(param_00);
	if(isalive(self))
	{
		self delete();
	}
}

//Function Number: 110
delete_me_on_goal()
{
	self waittill("goal");
	self delete();
}

//Function Number: 111
break_ignore_all_on_damage()
{
	self endon("death");
	self waittill("damage");
	level notify("alert_stairs_team");
	self.ignoreall = 0;
}

//Function Number: 112
alert_when_another_is_hurt()
{
	self endon("death");
	var_00 = getent("new_hall_troop_combat_vol","targetname");
	level waittill("alert_stairs_team");
	maps\_utility::battlechatter_on("axis");
	wait(randomfloatrange(0.1,0.3));
	if(isalive(self))
	{
		self.ignoreall = 0;
		self setgoalvolumeauto(var_00);
	}

	maps\_utility::trigger_wait_targetname("lightning_gag");
	maps\_utility::battlechatter_off("axis");
	if(isalive(self))
	{
		self delete();
	}
}

//Function Number: 113
debug_stealth()
{
	thread maps\_stealth_debug::last_known_position_monitor();
}

//Function Number: 114
monitor_stealth_flags()
{
	maps\_utility::ent_flag_wait("_stealth_enemy_alert_level_action");
	maps\_utility::ent_flag_clear("_stealth_enemy_alert_level_action");
	maps\_utility::ent_flag_wait("_stealth_enemy_alert_level_action");
	self endon("death");
	for(;;)
	{
		level waittill("event_awareness",var_00);
		if(var_00 == "warning")
		{
			self notify("new_anim_reach");
			continue;
		}

		if(var_00 == "attack")
		{
			break;
		}
	}

	if(isdefined(self.old_fovcosine))
	{
		self.fovcosine = self.old_fovcosine;
	}

	remove_patrol_anim_set();
}

//Function Number: 115
remove_patrol_anim_set()
{
	self.patrol_walk_twitch = undefined;
	self.patrol_walk_anim = undefined;
	self.script_animation = undefined;
	maps\_utility::clear_generic_run_anim();
	self.goalradius = 512;
	self allowedstances("stand","crouch","prone");
	self.disablearrivals = 0;
	self.disableexits = 0;
	self.allowdeath = 1;
	self.alwaysrunforward = undefined;
	if(isdefined(self.oldcombatmode))
	{
		self.combatmode = self.oldcombatmode;
	}

	if(isdefined(level.patroller) && self == level.patroller)
	{
		return;
	}

	maps\_utility::enable_cqbwalk();
}

//Function Number: 116
kill_me_on_notify()
{
	level waittill("delete_walkthrough_guys");
	if(isdefined(self))
	{
		self delete();
	}
}

//Function Number: 117
setup_school()
{
	thread maps\detroit_lighting::player_school_flashlight();
	thread enable_doorway_blocking();
	thread burke_path_through_school();
	thread burke_shimmey_setup();
	thread take_every_grenade_now();
	thread setup_player_fall();
	thread basement_hide_setup();
	thread basement_troop_2();
	thread setup_hazmant_suit_room();
	thread hall_troop_scare_moment();
	thread brick_smash_setup();
	thread player_basement_objective_mover();
	thread return_boost_dash();
	common_scripts\utility::flag_wait("flag_player_shimmy_start");
	level notify("flickering_light_02_off");
	common_scripts\utility::flag_set("rendezvous");
}

//Function Number: 118
lerp_time_function_wallpull()
{
	thread wait_for_success_press();
	thread maps\detroit_hospital::use_hint_blinks();
	var_00 = 0;
	while(var_00 < 1.6)
	{
		if(level.player usebuttonpressed())
		{
			thread maps\detroit_hospital::fade_out_use_hint(0.1);
			common_scripts\utility::flag_clear("wall_grab_success");
			level notify("player_grabbed_brick");
			maps\_utility::slowmo_lerp_out();
			soundscripts\_snd::snd_message("wall_pull_slowmo","end");
			return;
		}

		wait(0.05);
		var_00 = var_00 + 0.05;
	}

	soundscripts\_snd::snd_message("wall_pull_slowmo","fail");
	thread maps\detroit_hospital::fade_out_use_hint(0.1);
}

//Function Number: 119
wait_for_success_press()
{
	level endon("player_grabbed_brick");
	wait(1);
	level.player stopanimscripted();
	common_scripts\utility::flag_set("player_failed_wall_grab_stop");
	maps\_player_death::set_deadquote(&"DETROIT_QTE_FAIL");
}

//Function Number: 120
helmet_swap_wait_function()
{
	level waittill("helmet_swap_time");
	self detach("kva_hazmat_head_a");
	self attach("kva_hazmat_head_a_damaged");
	wait(2);
	maps\_utility::pretend_to_be_dead();
}

//Function Number: 121
wall_pull_animation()
{
	var_00 = getent("choke_gag_spawner","targetname");
	var_01 = getent("test_anim_origin","targetname");
	var_02 = maps\_utility::spawn_anim_model("brick");
	var_03 = maps\_utility::spawn_anim_model("world_body");
	var_03 hide();
	var_04 = [var_03,var_02];
	var_01 maps\_anim::anim_first_frame(var_04,"wall_pull");
	level.brick = var_02;
	maps\_utility::trigger_wait_targetname("wall_pull_animation");
	common_scripts\utility::flag_set("kill_scare_team");
	level notify("weapon_take_no_longer_needed");
	thread maps\detroit::battle_chatter_off_both();
	level.player maps\_shg_utility::setup_player_for_scene();
	var_00.count = 1;
	var_05 = var_00 maps\_utility::spawn_ai(1);
	var_05.ignoresonicaoe = 1;
	var_05.dropweapon = 0;
	var_05.ignoreall = 1;
	var_05.ignoreme = 1;
	var_05.allowdeath = 1;
	var_05.a.nodeath = 1;
	maps\_utility::spawn_failed(var_05);
	var_05.animname = "generic";
	var_06 = 0.05;
	var_07 = 0.2;
	level.player setstance("stand");
	level.player allowcrouch(0);
	var_03 common_scripts\utility::delaycall(var_07,::show);
	level.player playerlinktoblend(var_03,"tag_player",var_06);
	level.player common_scripts\utility::delaycall(var_06,::playerlinktodelta,var_03,"tag_player",0,0,0,0,0,1);
	var_04 = [var_05,var_03,var_02];
	var_05 maps\_utility::gun_remove();
	var_05 showallparts();
	var_05 thread helmet_swap_wait_function();
	thread wall_pull_animation_dialogue();
	thread maps\detroit_lighting::grab_lighting();
	soundscripts\_snd::snd_message("wall_pull_animation_begin");
	thread slowmo_in_wait_function();
	var_03 thread stop_animating_player_rig_on_flag();
	thread school_wall_grab_rumble();
	var_01 maps\_anim::anim_single(var_04,"wall_pull");
	level notify("takedown_over");
	var_08 = var_05 maps\_utility::getanim("wall_pull");
	var_05 setanimrate(var_08,0);
	var_05 setanimtime(var_08,0.99);
	level.player allowcrouch(1);
	var_03 delete();
	common_scripts\utility::flag_set("wall_grab_guy_dead");
	level.player unlink();
	level.player givemaxammo("frag_grenade_var");
	level.player givemaxammo("contact_grenade_var");
	level.player givemaxammo("tracking_grenade_var");
	level.player givemaxammo("flash_grenade_var");
	level.player givemaxammo("emp_grenade_var");
	level.player givemaxammo("paint_grenade_var");
	level.player maps\_shg_utility::setup_player_for_gameplay();
	thread kva_knife_takedown();
	thread window_hint();
}

//Function Number: 122
window_hint()
{
	var_00 = getent("window_origin","targetname");
	objective_position(maps\_utility::obj("Reunite with Burke"),var_00.origin);
}

//Function Number: 123
xprompt_on_brick()
{
	var_00 = getent("brick_xprompt_org","targetname");
	var_01 = var_00 common_scripts\utility::spawn_tag_origin();
	var_02 = var_01 maps\_shg_utility::hint_button_tag("x","tag_origin",128);
	level waittill("player_grabbed_brick");
	var_02 maps\_shg_utility::hint_button_clear();
}

//Function Number: 124
stop_animating_player_rig_on_flag()
{
	level endon("takedown_over");
	var_00 = getent("test_anim_death_origin","targetname");
	common_scripts\utility::flag_wait("player_failed_wall_grab_stop");
	level.player playerlinktodelta(self,"tag_player",0,0,0,0,0,1);
	var_00 thread maps\_anim::anim_single_solo(self,"det_hos_breach_fail_vm");
	maps\_utility::missionfailedwrapper();
	thread maps\detroit_hospital::fade_out_use_hint(0.1);
}

//Function Number: 125
kva_knife_takedown()
{
	soundscripts\_snd::snd_message("kva_knife_takedown_scene_begin");
	var_00 = getent("test_anim_origin","targetname");
	var_01 = getent("last_kva_guy_inside_school_spawner","targetname");
	var_02 = var_01 maps\_shg_design_tools::actual_spawn();
	var_02 thread maps\detroit_lighting::add_enemy_flashlight("flashlight","med");
	var_02 thread maps\detroit::force_patrol_anim_set("active_right");
	var_02 thread stealth_guy_think();
	var_02 setgoalpos(var_00.origin);
	var_02 thread last_burke_external_dialogue();
	var_02 thread remove_flashlight_on_goal();
	var_02 thread set_this_flag_when_im_dead("last_school_guy_dead");
	var_02 endon("death");
	var_02 maps\_utility::ent_flag_wait("spotted_player");
	var_02 maps\_utility::enable_cqbwalk();
	var_02 notify("goal");
}

//Function Number: 126
set_this_flag_when_im_dead(param_00)
{
	self waittill("death");
	common_scripts\utility::flag_set(param_00);
}

//Function Number: 127
school_wall_grab_rumble()
{
	wait(0.1);
	var_00 = level.player maps\_utility::get_rumble_ent("steady_rumble");
	var_00 maps\_utility::set_rumble_intensity(0.3);
	var_00 maps\_utility::delaythread(0.35,::maps\_utility::set_rumble_intensity,0.01);
	var_00 maps\_utility::delaythread(0.65,::maps\_utility::set_rumble_intensity,0.19);
	var_00 maps\_utility::delaythread(0.95,::maps\_utility::set_rumble_intensity,0.01);
	var_00 maps\_utility::delaythread(1.4,::maps\_utility::set_rumble_intensity,0.12);
	var_00 maps\_utility::delaythread(1.55,::maps\_utility::set_rumble_intensity,0.01);
	var_00 maps\_utility::delaythread(2.7,::maps\_utility::set_rumble_intensity,0.12);
	var_00 maps\_utility::delaythread(2.9,::maps\_utility::set_rumble_intensity,0.01);
	var_00 maps\_utility::delaythread(4.7,::maps\_utility::set_rumble_intensity,0.6);
	var_00 maps\_utility::delaythread(4.9,::maps\_utility::set_rumble_intensity,0.01);
	var_00 maps\_utility::delaythread(6.8,::maps\_utility::set_rumble_intensity,0.25);
	var_00 maps\_utility::delaythread(7,::maps\_utility::set_rumble_intensity,0.01);
	var_00 maps\_utility::delaythread(7.8,::maps\_utility::set_rumble_intensity,0.7);
	var_00 maps\_utility::delaythread(8,::maps\_utility::set_rumble_intensity,0.01);
	var_00 maps\_utility::delaythread(9.8,::maps\_utility::set_rumble_intensity,0.2);
	var_00 maps\_utility::delaythread(10.06,::maps\_utility::set_rumble_intensity,0.01);
	var_00 maps\_utility::delaythread(11.28,::maps\_utility::set_rumble_intensity,0.55);
	var_00 maps\_utility::delaythread(11.46,::maps\_utility::set_rumble_intensity,0.01);
	var_00 maps\_utility::delaythread(12.58,::maps\_utility::set_rumble_intensity,0.55);
	var_00 maps\_utility::delaythread(12.76,::maps\_utility::set_rumble_intensity,0.13);
	var_00 maps\_utility::delaythread(12.96,::maps\_utility::set_rumble_intensity,0.29);
	var_00 maps\_utility::delaythread(13.7,::maps\_utility::set_rumble_intensity,0.11);
	var_00 maps\_utility::delaythread(16.7,::maps\_utility::set_rumble_intensity,0.01);
	var_00 maps\_utility::delaythread(18.2,::maps\_utility::set_rumble_intensity,0.11);
	var_00 maps\_utility::delaythread(18.65,::maps\_utility::set_rumble_intensity,0.01);
	wait(20);
	var_00 stoprumble("steady_rumble");
	var_00 delete();
}

//Function Number: 128
remove_flashlight_on_goal()
{
	self waittill("goal");
	self notify("flashlight_off");
	self setgoalpos(level.player.origin);
	thread maps\_utility::player_seek();
}

//Function Number: 129
last_burke_external_dialogue()
{
	common_scripts\utility::waittill_any_ents(self,"death",level,"spawn_ally_burke_backup");
	common_scripts\utility::flag_set("vo_school_burke_external");
	var_00 = getglass("burke_street_glass");
	destroyglass(var_00);
}

//Function Number: 130
take_knife_when_done()
{
	self endon("death");
	self waittill("weapon_switch_started");
	level.player giveweapon("iw5_hbra3_sp_opticstargetenhancer");
	level.player switchtoweapon("iw5_hbra3_sp_opticstargetenhancer");
}

//Function Number: 131
save_game_when_dead(param_00)
{
	for(;;)
	{
		if(!isalive(param_00))
		{
			wait(4);
			thread maps\_utility::autosave_by_name("seeker");
			return;
		}

		wait(0.05);
	}
}

//Function Number: 132
check_to_activate(param_00,param_01)
{
	for(;;)
	{
		if(distance2d(level.window_guy.origin,level.player.origin) < 250)
		{
			param_00.ignoreall = 0;
			level.window_guy notify("flashlight_off");
			level.player.ignoreme = 0;
			return;
		}

		wait(0.05);
	}
}

//Function Number: 133
wall_pull_animation_dialogue()
{
	wait(6);
	wait(3);
	wait(4.5);
	common_scripts\utility::flag_set("begin_final_slice_moment");
	wait(3);
	soundscripts\_snd::snd_message("detroit_kva_bauerdoyoureadme");
	wait(7);
}

//Function Number: 134
burke_shimmey_setup()
{
	if(level.currentgen)
	{
		for(;;)
		{
			if(istransientloaded("detroit_school_interior_tr"))
			{
				break;
			}

			wait(0.2);
		}
	}

	var_00 = maps\_utility::spawn_anim_model("school_blockage");
	thread maps\detroit_lighting::blockage_lighting(var_00);
	var_01 = getent("school_player_fall_first_floor","targetname");
	var_01 thread maps\_anim::anim_first_frame_solo(var_00,"burke_wall_walk");
	var_02 = getent("placed_beam_clip","targetname");
	var_03 = getent("placed_beam_clip_final","targetname");
	maps\_utility::disable_trigger_with_targetname("trigger_shimmey_ok");
	maps\_utility::trigger_wait_targetname("start_burke_shimmey");
	thread maps\detroit::battle_chatter_off_both();
	maps\_utility::enable_trigger_with_targetname("trigger_shimmey_ok");
	common_scripts\utility::flag_set("resume_100_speed");
	thread det_debris_falling();
	var_04 = [var_00,level.burke];
	thread beam_clip_disable_function();
	var_01 maps\_anim::anim_single(var_04,"burke_wall_walk");
	common_scripts\utility::flag_set("burke_is_shimmey_halfway_can_continue");
	if(!common_scripts\utility::flag("flag_burke_stop_idle_at_shimmy"))
	{
		var_01 thread maps\_anim::anim_loop_solo(level.burke,"burke_shimmey_wait_idle","ender");
	}

	common_scripts\utility::flag_wait("flag_burke_stop_idle_at_shimmy");
	var_01 notify("ender");
	level.burke maps\_utility::anim_stopanimscripted();
	var_01 maps\_anim::anim_single_solo(level.burke,"burke_shimmey_wait_idle_out");
	var_01 thread maps\_anim::anim_loop_solo(level.burke,"burke_wall_walk_idle","ender");
	common_scripts\utility::flag_wait("school_player_falling");
	thread maps\detroit_lighting::player_fall_lighting();
	var_01 notify("ender");
	var_01 thread maps\_anim::anim_single_solo(level.burke,"school_fall");
	maps\_utility::activate_trigger_with_targetname("burke_finished_walk");
}

//Function Number: 135
take_every_grenade_now()
{
	common_scripts\utility::flag_wait("flag_player_shimmy_start");
}

//Function Number: 136
beam_clip_disable_function()
{
	var_00 = getent("placed_beam_clip","targetname");
	var_01 = getent("placed_beam_clip_final","targetname");
	wait(2.45);
	var_00 delete();
	var_01 solid();
}

//Function Number: 137
det_debris_falling()
{
	common_scripts\utility::flag_wait("burke_is_shimmey_halfway_can_continue");
	common_scripts\utility::flag_wait("flag_burke_stop_idle_at_shimmy");
	var_00 = getent("burke_fx_footdrop","targetname");
	var_01 = anglestoforward(var_00.origin);
	playfx(common_scripts\utility::getfx("det_debris_falling"),var_00.origin,var_01);
	wait(0.6);
	wait(1);
	thread spawn_kva_downstairs();
}

//Function Number: 138
setup_player_fall()
{
	if(level.currentgen)
	{
		for(;;)
		{
			if(istransientloaded("detroit_school_interior_tr"))
			{
				break;
			}

			wait(0.2);
		}
	}

	var_00 = getent("school_player_fall_first_floor","targetname");
	var_01 = maps\_utility::spawn_anim_model("floorboards");
	var_02 = maps\_utility::spawn_anim_model("school_floor");
	wait 0.05;
	var_00 thread maps\_anim::anim_loop_solo(var_01,"det_school_fall_shuffle_pt0_idle_beams","stop_player_shuffle_loop");
	var_00 thread maps\_anim::anim_first_frame_solo(var_02,"school_fall");
	var_03 = getent("basement_clip_block","targetname");
	var_03 notsolid();
	var_03 connectpaths();
	common_scripts\utility::flag_wait("flag_player_shimmy_start");
	var_00 notify("stop_player_shuffle_loop");
	var_04 = maps\_utility::spawn_anim_model("world_body");
	var_04 hide();
	var_00 maps\_anim::anim_first_frame_solo(var_04,"school_fall_stand_2_shuffle");
	level.player maps\_shg_utility::setup_player_for_scene(1);
	var_05 = 0.5;
	level.player stopanimscripted();
	level.player allowmelee(0);
	level.player playerlinktoblend(var_04,"tag_player",var_05,var_05 / 3,var_05 / 3);
	var_04 common_scripts\utility::delaycall(var_05,::show);
	wait(var_05);
	level.player playerlinktodelta(var_04,"tag_player",1,80,20,20,20,1);
	var_06 = distance2d(level.burke.origin,level.player.origin);
	if(var_06 > 70)
	{
		soundscripts\_snd::snd_message("player_shimmy_intro","short_version");
		var_00 thread maps\_anim::anim_single_solo(var_01,"det_school_fall_stand_2_shuffle_beams");
		var_00 maps\_anim::anim_single_solo(var_04,"school_fall_stand_2_shuffle");
	}
	else
	{
		soundscripts\_snd::snd_message("player_shimmy_intro","long_version");
		var_00 thread maps\_anim::anim_single_solo(var_01,"det_school_fall_stand_2_shuffle_beams");
		var_00 maps\_anim::anim_single_solo(var_04,"det_school_fall_stand_2_shuffle_slow_vm");
	}

	var_00 thread maps\_anim::anim_loop_solo(var_04,"school_fall_shuffle_pt0_idle","stop_player_shuffle_loop");
	var_00 thread maps\_anim::anim_loop_solo(var_01,"det_school_fall_shuffle_pt0_idle_beams","stop_player_shuffle_loop");
	waittill_player_tries_to_advance();
	var_00 notify("stop_player_shuffle_loop");
	level notify("player_linked");
	thread maps\detroit_lighting::burke_walk_lighting();
	var_00 thread maps\_anim::anim_single_solo(var_01,"det_school_fall_shuffle_pt1_beams");
	var_00 maps\_anim::anim_single_solo(var_04,"school_fall_shuffle_pt1");
	var_00 thread maps\_anim::anim_loop_solo(var_01,"det_school_fall_shuffle_pt1_idle_beams","stop_player_shuffle_loop");
	var_00 thread maps\_anim::anim_loop_solo(var_04,"school_fall_shuffle_pt1_idle","stop_player_shuffle_loop");
	waittill_player_tries_to_advance();
	var_00 notify("stop_player_shuffle_loop");
	var_00 thread maps\_anim::anim_single_solo(var_01,"det_school_fall_shuffle_pt2_beams");
	var_00 maps\_anim::anim_single_solo(var_04,"school_fall_shuffle_pt2");
	var_00 thread maps\_anim::anim_loop_solo(var_01,"det_school_fall_shuffle_pt2_idle_beams","stop_player_shuffle_loop");
	var_00 thread maps\_anim::anim_loop_solo(var_04,"school_fall_shuffle_pt2_idle","stop_player_shuffle_loop");
	waittill_player_tries_to_advance();
	var_00 notify("stop_player_shuffle_loop");
	var_00 thread maps\_anim::anim_single_solo(var_01,"det_school_fall_shuffle_pt3_beams");
	var_00 maps\_anim::anim_single_solo(var_04,"school_fall_shuffle_pt3");
	var_00 thread maps\_anim::anim_loop_solo(var_01,"det_school_fall_shuffle_pt3_idle_beams","stop_player_shuffle_loop");
	var_00 thread maps\_anim::anim_loop_solo(var_04,"school_fall_shuffle_pt3_idle","stop_player_shuffle_loop");
	waittill_player_tries_to_advance();
	var_00 notify("stop_player_shuffle_loop");
	level.player springcamenabled(0,level.detroit_spring_cam_lerp_speed,level.detroit_spring_cam_release_speed);
	var_00 thread maps\_anim::anim_single_solo(var_01,"det_school_fall_shuffle_pt4_beams");
	var_00 maps\_anim::anim_single_solo(var_04,"school_fall_shuffle_pt4");
	var_00 thread maps\_anim::anim_loop_solo(var_01,"det_school_fall_shuffle_pt4_idle_beams","stop_player_shuffle_loop");
	var_00 thread maps\_anim::anim_loop_solo(var_04,"school_fall_shuffle_pt4_idle","stop_player_shuffle_loop");
	waittill_player_tries_to_advance();
	var_00 notify("stop_player_shuffle_loop");
	common_scripts\utility::flag_set("school_player_falling");
	common_scripts\utility::flag_set("school_jeep_delete");
	soundscripts\_snd::snd_message("school_fall");
	common_scripts\utility::flag_set("obj_check_school_complete");
	common_scripts\utility::flag_set("vo_school_holdtight");
	level.player lerpviewangleclamp(1,0.25,0.25,0,0,0,0);
	var_07 = maps\_utility::spawn_anim_model("gun");
	var_00 thread maps\_anim::anim_single_solo(var_07,"school_fall");
	thread cracked_floor_function();
	thread kva_spot_player_durring_fall();
	var_00 thread maps\_anim::anim_single_solo(var_01,"det_school_fall_beams");
	thread school_fall_frame_hide();
	var_00 thread maps\_anim::anim_single_solo(var_02,"school_fall");
	level.player playerlinktodelta(var_04,"tag_player",1,80,20,20,20,1);
	thread school_fall_rumble();
	var_00 maps\_anim::anim_single_solo(var_04,"school_fall");
	level.player maps\_shg_utility::setup_player_for_gameplay();
	var_01 hide();
	level.player unlink();
	var_04 delete();
	var_07 delete();
	common_scripts\utility::flag_set("obj_reunite_with_burke_give");
	level.player setmovespeedscale(0.7);
	level.player enableweapons();
	setsaveddvar("ammoCounterHide",0);
	foreach(var_09 in level.player getweaponslistprimaries())
	{
		level.player takeweapon(var_09);
	}

	foreach(var_0C in level.player getweaponslistoffhands())
	{
		level.player setweaponammostock(var_0C,0);
	}

	level.player allowsprint(0);
	level.player allowcrouch(1);
	level.player allowmelee(1);
	level.player allowprone(1);
	level.player thread maps\detroit::handle_unarmed_viewbob();
	level.player giveweapon("iw5_unarmeddetroit_nullattach");
	level.player switchtoweapon("iw5_unarmeddetroit_nullattach");
	level.player thread remove_unarmed_when_pickup_new_wep();
	thread maps\_utility::autosave_by_name("seeker");
	common_scripts\utility::flag_wait("basement_clear");
	var_02 delete();
}

//Function Number: 139
remove_unarmed_when_pickup_new_wep()
{
	level endon("weapon_take_no_longer_needed");
	for(;;)
	{
		var_00 = level.player maps\_utility::get_storable_weapons_list_primaries();
		if(var_00.size == 2)
		{
			level.player takeweapon("iw5_unarmeddetroit_nullattach");
			level.player allowsprint(1);
			maps\_player_exo::player_exo_activate();
			level notify("player_no_longer_unarmed");
			return;
		}

		wait(0.05);
	}
}

//Function Number: 140
school_fall_slowmo_lerp()
{
	wait(2.05);
	maps\_utility::slowmo_lerp_in();
	wait(0.5);
	maps\_utility::slowmo_lerp_out();
}

//Function Number: 141
school_fall_frame_hide()
{
	var_00 = getentarray("school_fall_frame","targetname");
	foreach(var_02 in var_00)
	{
		var_02 delete();
	}
}

//Function Number: 142
slowmo_in_wait_function()
{
	level waittill("begin_slowmo_lerp_in");
	wait(1.5);
	soundscripts\_snd::snd_message("wall_pull_slowmo","begin");
	setslowmotion(level.slowmo.speed_norm,level.slowmo.speed_slow,level.slowmo.lerp_time_in);
	wait(level.slowmo.lerp_time_in);
	thread lerp_time_function_wallpull();
}

//Function Number: 143
kva_spot_player_durring_fall()
{
	var_00 = getnode("player_fall_kva_animated_moment_org","targetname");
	var_01 = getent("player_fall_kva_animated_moment_spawner","targetname");
	var_02 = getent("kva_animated_moment_org_new","targetname");
	var_03 = getent("kva_animated_moment_org","targetname");
	wait(2.66);
	level notify("delete_walkthrough_guys");
	wait(8.95);
	var_04 = var_01 maps\_utility::spawn_ai(1);
	var_04 maps\detroit_lighting::add_enemy_flashlight("flashlight","med");
	var_04 maps\detroit::set_patrol_anim_set("active",1);
	var_04.ignoreall = 1;
	var_04.ignoreme = 1;
	var_04.goalradius = 15;
	var_04.animname = "kva";
	var_03 maps\_anim::anim_reach_solo(var_04,"so_hijack_search_flashlight_high_loop");
	level.school_kva_spot_guy = var_04;
	maps\_utility::delaythread(2,::common_scripts\utility::flag_set,"vo_school_kva_checkcomms");
	var_02 thread maps\_anim::anim_loop_solo(var_04,"so_hijack_search_flashlight_high_loop");
	common_scripts\utility::flag_set("vo_school_burke_post_fall");
	common_scripts\utility::flag_wait("flag_start_kva_basement");
	var_04 delete();
}

//Function Number: 144
cracked_floor_function()
{
	wait(2.2);
	common_scripts\utility::flag_set("show_cracked_floor");
	wait(11.6);
	common_scripts\utility::flag_set("delete_cracked_floor");
	soundscripts\_snd::snd_message("school_fall_into_basement");
}

//Function Number: 145
basement_door_clip_function()
{
	var_00 = getent("basement_door_ai_clip_extra","targetname");
	var_01 = getent("basement_door_clip","targetname");
	var_00 linkto(self,"jo_door_l");
	var_01 linkto(self,"jo_door_l");
	common_scripts\utility::flag_wait("connect_basement_door_clip");
	var_01 connectpaths();
	var_00 connectpaths();
}

//Function Number: 146
waittill_player_tries_to_advance()
{
	while(level.player getnormalizedmovement()[1] > -0.25 || distance2d(level.player.origin,level.burke.origin) < 64)
	{
		wait 0.05;
	}
}

//Function Number: 147
spawn_patroller_guide_floor2()
{
	var_00 = getent("spawner_school_f2_patroller_1","targetname");
	var_01 = getent("guy2_hide_spot_origin","targetname");
	maps\_shg_design_tools::waittill_trigger_with_name("trigger_floor2_patroller_1");
	common_scripts\utility::flag_set("basement_clear");
	var_02 = getent("basement_clip_block","targetname");
	var_02 solid();
	var_02 disconnectpaths();
	level.patroller = var_00 maps\_shg_design_tools::actual_spawn();
	level.patroller maps\_utility::disable_surprise();
	level.patroller maps\_utility::disable_pain();
	level.patroller.goalradius = 15;
	level.patroller setgoalentity(var_01);
	level.patroller.animname = "kva";
	level.patroller thread make_me_alert();
	level.patroller thread bump_into_awareness();
	level.patroller thread change_to_run_after_time(18);
	level.patroller thread maps\detroit::set_patrol_anim_set("active_forward",1);
	level.patroller thread maps\detroit_lighting::add_enemy_flashlight("flashlight","med");
	level.patroller thread maps\detroit_lighting::enemy_flashlight_toggle_think("trig_flashlight_patroller_on","trig_flashlight_patroller_off");
	level.patroller thread delete_me_on_goal_special(var_01);
	level.patroller thread stealth_guy_think();
	level.patroller thread ambush_wait();
	level.patroller thread call_for_backup();
	level.patroller thread i_have_seen_the_player();
	level.patroller endon("death");
	level.patroller waittill("_stealth_spotted");
	level.patroller maps\_utility::player_seek();
}

//Function Number: 148
call_for_backup()
{
	self endon("death");
	self waittill("damage");
	var_00 = common_scripts\_destructible::getdamagetype(self.damagemod);
	if(isdefined(self.attacker) && self.attacker == level.player && var_00 == "bullet")
	{
	}

	common_scripts\utility::flag_set("kill_scare_team");
	maps\_utility::activate_trigger_with_targetname("new_hall_troops_trigger");
}

//Function Number: 149
pursue_player()
{
	self endon("death");
	common_scripts\utility::waittill_any("make_me_alert_now");
	for(;;)
	{
		wait(randomfloatrange(1.1,3.3));
		var_00 = distance(self.origin,level.player.origin);
		if(var_00 > 70)
		{
			self setgoalpos(level.player.origin);
		}
	}
}

//Function Number: 150
make_me_alert(param_00)
{
	self endon("death");
	common_scripts\utility::waittill_any("make_me_alert_now","damage","alert");
	if(isdefined(param_00))
	{
		common_scripts\utility::flag_set(param_00);
	}

	self setgoalpos(level.player.origin);
	level notify("stop_animating_the_basement_door");
	self notify("_stealth_spotted");
	self notify("end_patrol");
	remove_patrol_anim_set();
	self notify("flashlight_off");
	maps\_utility::enable_pain();
	maps\_utility::disable_careful();
	thread maps\_utility::player_seek();
	maps\_utility::anim_stopanimscripted();
}

//Function Number: 151
delete_me_on_goal_special(param_00)
{
	self endon("death");
	self endon("alert");
	self endon("damage");
	self endon("_stealth_spotted");
	is_1_near_2(self,param_00,40);
	self delete();
}

//Function Number: 152
damage_change_goal()
{
	self endon("death");
	self waittill("damage");
	self setgoalpos(level.player.origin);
	thread maps\_utility::player_seek();
	maps\_utility::enable_pain();
}

//Function Number: 153
ambush_wait()
{
	self endon("death");
	level waittill("alert_stairs_team");
	self notify("make_me_alert_now");
}

//Function Number: 154
goal_and_interupt()
{
	self endon("death");
	self endon("alert");
	self endon("damage");
	self endon("_stealth_spotted");
	var_00 = getnode("node_searcher_goto1","targetname");
	level.patroller setgoalnode(var_00);
	level.patroller waittill("goal");
	wait(1);
	level.patroller delete();
}

//Function Number: 155
break_out_and_fight()
{
	common_scripts\utility::waittill_any("alert","damage","_stealth_spotted");
	remove_patrol_anim_set();
	self notify("end_patrol");
	self notify("flashlight_off");
	maps\_utility::player_seek();
}

//Function Number: 156
change_to_run_after_time(param_00)
{
	self endon("death");
	self endon("alert");
	self endon("damage");
	self endon("_stealth_spotted");
	self endon("make_me_alert_now");
	wait(param_00);
	remove_patrol_anim_set();
	self notify("end_patrol");
	self notify("flashlight_off");
}

//Function Number: 157
change_to_run_now()
{
	common_scripts\utility::waittill_any("alert","damage","_stealth_spotted");
	remove_patrol_anim_set();
	self notify("end_patrol");
	self notify("flashlight_off");
}

//Function Number: 158
player_kill_function()
{
	self endon("death");
	level.player endon("death");
	var_00 = level.player.health;
	for(;;)
	{
		if(level.player.health < var_00)
		{
			var_01 = level.player.health;
			for(;;)
			{
				if(level.player.health < var_01)
				{
					level.player kill();
				}

				wait(0.05);
			}
		}

		wait(0.1);
	}
}

//Function Number: 159
setup_hazmant_suit_room()
{
	thread spawn_patroller_guide_floor2();
}

//Function Number: 160
school_bodies_room_no_crouching()
{
	level endon("stop_tracking_backtrack");
	var_00 = getent("no_player_crouch_here","targetname");
	var_01 = getent("no_player_crouch_here_2","targetname");
	var_02 = getent("no_player_crouch_here_3","targetname");
	for(;;)
	{
		if(level.player istouching(var_00))
		{
			level.player allowprone(0);
		}
		else if(level.player istouching(var_01))
		{
			level.player allowprone(0);
		}
		else if(level.player istouching(var_02))
		{
			level.player allowprone(0);
		}
		else
		{
			level.player allowprone(1);
		}

		wait(0.05);
	}
}

//Function Number: 161
player_leaving_bodyroom_gag()
{
	var_00 = getent("bodies_room_gag_used","targetname");
	var_00 makeusable();
	var_01 = getent("player_viewmodel_door_animorg","targetname");
	var_02 = maps\_utility::spawn_anim_model("body_room_exit_door");
	var_03 = spawn("script_model",(0,0,0));
	var_03.animname = var_02.animname;
	var_03 maps\_utility::assign_animtree();
	var_03 setmodel("det_school_door_01_anim_obj");
	if(level.currentgen)
	{
		if(!istransientloaded("detroit_school_interior_tr"))
		{
			for(;;)
			{
				wait(0.25);
				if(istransientloaded("detroit_school_interior_tr"))
				{
					break;
				}
			}
		}
	}

	var_01 maps\_anim::anim_first_frame_solo(var_02,"body_room_exit");
	var_01 maps\_anim::anim_first_frame_solo(var_03,"body_room_exit");
	var_04 = getent("bodies_room_door2_clip","targetname");
	var_04 linkto(var_02,"jo_door_l");
	var_02 showallparts();
	var_03 hideallparts();
	var_05 = maps\_utility::spawn_anim_model("world_hands");
	var_05 hide();
	level waittill("show_glowing_door");
	thread nag_player_get_door();
	var_00 waittill("trigger",var_06);
	common_scripts\_exploder::exploder(5622);
	common_scripts\utility::flag_set("player_used_bodies_room_door");
	var_00 makeunusable();
	var_02 setmodel("det_school_door_01_anim");
	var_02 showallparts();
	var_03 delete();
	level.player maps\_shg_utility::setup_player_for_scene(1);
	var_07 = 0.5;
	soundscripts\_snd::snd_message("body_room_exit");
	var_01 maps\_anim::anim_first_frame_solo(var_05,"body_room_exit");
	level.player playerlinktoblend(var_05,"tag_player",var_07);
	level.player common_scripts\utility::delaycall(var_07,::playerlinktodelta,var_05,"tag_player",0,0,0,0,0,1);
	wait(var_07);
	level notify("player_door_open");
	level.burke notify("stop_idling_in_deadroom");
	thread bodyroom_gag_ghost_function();
	common_scripts\_exploder::exploder(5612);
	var_05 show();
	var_08 = [var_05,var_02];
	thread finish_bodies_room_burke();
	thread bodyroom_gag_support_function();
	var_01 maps\_anim::anim_single(var_08,"body_room_exit");
	var_09 = level.player common_scripts\utility::spawn_tag_origin();
	var_09.origin = var_09.origin + (0,0,0.167);
	level.player maps\_utility::teleport_player(var_09);
	level.player unlink();
	var_05 delete();
	level.player maps\_shg_utility::setup_player_for_gameplay();
	level.player allowsprint(0);
	maps\_player_exo::player_exo_deactivate();
}

//Function Number: 162
nag_player_get_door()
{
	for(;;)
	{
		wait(randomintrange(4,7));
		if(common_scripts\utility::flag("player_used_bodies_room_door"))
		{
			return;
		}

		var_00 = randomint(2);
		if(var_00 == 0)
		{
			level.burke maps\_utility::dialogue_queue("det_gdn_thedoormitchell");
			continue;
		}

		level.burke maps\_utility::dialogue_queue("det_gdn_getthedoor");
	}
}

//Function Number: 163
bodyroom_gag_support_function()
{
	common_scripts\utility::flag_set("burke_leaving_bodies_room");
	level notify("disable_burke_bodiesroom_idle");
}

//Function Number: 164
bodyroom_gag_ghost_function()
{
	var_00 = getent("bodies_room_gag_spawner","targetname");
	var_01 = getent("bodies_room_gag_anim_org_new","targetname");
	wait(2.7);
	soundscripts\_snd::snd_message("new_ghost_gag_stinger");
}

//Function Number: 165
burke_deadroom_door()
{
	var_00 = getent("burke_bodies_anim_origin","targetname");
	var_01 = maps\_utility::spawn_anim_model("school_door",var_00.origin);
	var_00 maps\_anim::anim_first_frame_solo(var_01,"burke_school_door");
	var_02 = getent("bodies_room_door1_clip","targetname");
	var_02 linkto(var_01,"jo_door_l");
	common_scripts\utility::flag_wait("open_school_door");
	wait(2.95);
	var_00 maps\_anim::anim_single_solo(var_01,"burke_school_door");
	thread player_leaving_bodyroom_gag();
}

//Function Number: 166
get_burke_to_deadroom()
{
	level endon("disable_burke_bodiesroom_idle");
	level.burke.animname = "burke";
	var_00 = getent("burke_bodies_anim_origin","targetname");
	if(distance(level.player.origin,level.burke.origin) > 200)
	{
		var_00 thread maps\_anim::anim_loop_solo(level.burke,"wait_by_door");
	}

	while(distance(level.player.origin,level.burke.origin) > 200)
	{
		wait 0.05;
	}

	level.burke maps\_shg_design_tools::anim_stop(var_00);
	level.burke maps\_shg_design_tools::anim_stop(level.burke);
	common_scripts\_exploder::exploder(5568);
	var_01 = undefined;
	if(level.nextgen)
	{
		var_02 = getent("school_deadbody_burke_look","targetname");
		var_03 = var_02 spawndrone();
		var_03 setcontents(0);
	}
	else
	{
		var_03 = spawn("script_model",var_01.origin);
		var_03 setmodel("civ_urban_male_dead_body_a");
		var_01 = "head_male_sp_siejak";
		var_03 attach(var_01,"",1);
	}

	var_03 useanimtree(#animtree);
	var_03.animname = "generic";
	var_00 thread maps\_anim::anim_first_frame_solo(var_03,"touch_dead_npc");
	thread animate_dead_body(var_03,var_00);
	maps\_utility::disable_trigger_with_targetname("bodies_room_gag_used");
	thread bodies_gag_door_trigger();
	maps\_utility::delaythread(20,::common_scripts\utility::flag_set,"vo_school_deadroom");
	common_scripts\utility::flag_set("open_school_door");
	thread school_bodies_room_no_crouching();
	var_00 maps\_anim::anim_single_solo(level.burke,"go_into_deadroom");
	if(common_scripts\utility::flag_exist("burke_needs_to_idle"))
	{
		var_00 thread maps\_anim::anim_loop_solo(level.burke,"deadroom_idle","stop_idling_in_deadroom");
	}

	common_scripts\utility::flag_wait("player_used_bodies_room_door");
	var_00 notify("stop_idling_in_deadroom");
}

//Function Number: 167
finish_bodies_room_burke()
{
	common_scripts\utility::flag_clear("burke_needs_to_idle");
	level.burke maps\_utility::set_generic_run_anim("stealth_walk",0);
	soundscripts\_snd::snd_message("finish_bodies_room_burke");
	common_scripts\utility::flag_wait("burke_leaving_bodies_room");
	thread maps\_utility::autosave_by_name();
	var_00 = getent("burke_bodies_anim_origin_updated","targetname");
	var_00 notify("stop_idling_in_deadroom");
	level.burke notify("stop_idling_in_deadroom");
	common_scripts\utility::flag_set("obj_check_school_on_burke");
	var_00 maps\_anim::anim_single_solo(level.burke,"exit_burke");
	level.burke notify("facelight_off");
	level.burke.animname = "burke";
	var_01 = getent("new_burke_stairs_check_animorg","targetname");
	var_01 thread maps\_anim::anim_loop_solo(level.burke,"burke_stairs_idle_inside","stop_stairs_inside_idle");
	common_scripts\utility::flag_set("vo_school_stairs");
	common_scripts\utility::flag_wait("player_near_burke_school_bottom_stairs");
	wait 0.05;
	thread gideon_keep_up_fail_trigger("player_escaping_the_school");
	thread maps\_utility::autosave_by_name();
	var_01 notify("stop_stairs_inside_idle");
	level.burke notify("stop_stairs_inside_idle");
	thread shit_blocked_upstairs();
	level.burke stopanimscripted();
	var_01 stopanimscripted();
	var_01 maps\_anim::anim_single_solo(level.burke,"school_stair_walk");
	begin_the_shimmey_for_burke();
}

//Function Number: 168
begin_the_shimmey_for_burke()
{
	var_00 = getent("burke_third_floor_corner_check_wait","targetname");
	var_00 thread maps\_anim::anim_loop_solo(level.burke,"burke_corner_left_idle","burke_stop_left_idle");
	is_player_near_burke(400);
	thread maps\_utility::autosave_by_name();
	var_00 notify("burke_stop_left_idle");
	level.burke notify("flashlight_off");
	maps\_utility::activate_trigger_with_targetname("start_burke_shimmey");
	common_scripts\utility::flag_wait("flag_player_shimmy_start");
	level.player maps\_utility::notify_delay("flashlight_off",2);
}

//Function Number: 169
shit_blocked_upstairs()
{
	wait(12.88);
	wait(6.4);
	soundscripts\_snd::snd_message("burke_startle_stairs");
	wait(1.6);
	common_scripts\utility::flag_set("vo_school_thisway");
}

//Function Number: 170
setup_school_bodies()
{
}

//Function Number: 171
school_drone_spawn(param_00)
{
	var_01 = maps\_spawner::spawner_dronespawn(param_00);
	var_01.animname = "generic";
	return var_01;
}