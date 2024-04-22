/*******************************************************************
 * Decompiled By: Bog
 * Decompiled File: betrayal_code.gsc
 * Game: Call of Duty: Advanced Warfare
 * Platform: PC
 * Function Count: 366
 * Decompile Time: 6739 ms
 * Timestamp: 4/22/2024 2:25:32 AM
*******************************************************************/

//Function Number: 1
office_scene_master_handler()
{
	office_scene_pre_setup();
	office_scene_setup();
	office_scene_cleanup();
	level thread confrontation_scene_master_handler();
}

//Function Number: 2
office_scene_pre_setup()
{
	level thread office_scene_player_actions_manager();
	level.player freezecontrols(1);
	thread office_scene_vignette_setup();
	maps\betrayal_util::prepare_blast_doors("roof_window_blastdoor",-200);
	maps\betrayal_util::prepare_blast_doors("roof_slide_blastdoor",-160);
	maps\betrayal_util::prepare_blast_doors("roof_slide_blastdoor_mrX",-160);
	level.gideon pushplayer(1);
	level.gideon maps\_utility::set_moveplaybackrate(1.025,0.5);
	common_scripts\utility::flag_set("flag_dialogue_start_office");
	common_scripts\utility::flag_wait("flag_office_start_intro_pcap");
	thread maps\betrayal_lighting::lighting_target_dof(level.player,level.gideon,2.5,23);
	office_scene_intro_pcap();
}

//Function Number: 3
office_scene_intro_pcap()
{
	if(isdefined(getent("flag_office_gideon_start_moving","targetname")))
	{
		maps\_utility::activate_trigger_with_targetname("flag_office_gideon_start_moving");
	}

	level.gideon.dynamicturnscaling = 1;
	level.gideon maps\betrayal_util::setup_squad_member_for_scene();
	level.player freezecontrols(0);
	var_00 = maps\_utility::spawn_anim_model("player_rig",level.player.origin,level.player.angles);
	var_00 hide();
	level.player lerpfov(40,0.05);
	var_01 = 0.5;
	level.player playerlinktoblend(var_00,"tag_player",var_01);
	level.player common_scripts\utility::delaycall(var_01,::playerlinktodelta,var_00,"tag_player",0.75,8,22,14,4,1);
	level.player enableslowaim();
	level.player enableweapons();
	var_00 common_scripts\utility::delaycall(var_01,::show);
	var_02 = [var_00,level.gideon];
	var_03 = maps\betrayal_util::get_ent_by_targetname("animorg_intro_moment");
	var_03 thread maps\_anim::anim_single_solo_run(level.gideon,"intro");
	var_03 maps\_anim::anim_single_solo(var_00,"intro");
	var_00 delete();
	level.gideon maps\betrayal_util::setup_squad_member_for_gameplay();
	level.player unlink();
	level.player disableslowaim();
	level.player allowcrouch(1);
	office_scene_player_give_just_hands();
	level thread maps\betrayal_util::start_player_office_scene_walk_sway();
	maps\_utility::autosave_by_name();
}

//Function Number: 4
office_scene_setup()
{
	level thread office_scene_move_to_secret_room();
	common_scripts\utility::flag_set("flag_dialogue_start_office");
}

//Function Number: 5
office_scene_move_to_secret_room()
{
	level thread office_scene_player_movement_manager();
	office_scene_gideon_to_roof();
	office_scene_gideon_to_stairs();
	office_scene_gideon_enter_secret_room();
}

//Function Number: 6
office_scene_gideon_to_roof()
{
	common_scripts\utility::flag_set("flag_objective_office_scene_follow_gideon");
	common_scripts\utility::flag_set("office_scene_heli_go_1");
	common_scripts\utility::flag_wait("flag_office_gideon_at_roof_door");
	var_00 = maps\betrayal_util::get_ents_by_targetname("office_hallway_door_right");
	var_01 = maps\betrayal_util::get_ents_by_targetname("office_hallway_door_left");
	soundscripts\_snd::snd_message("office_hallway_door_open",var_01,var_00);
	maps\betrayal_util::open_double_sliding_doors_toggle("office_hallway_door",1);
	common_scripts\utility::flag_set("flag_office_gideon_clear_to_move_to_roof");
	maps\_utility::activate_trigger_with_targetname("trigger_office_gideon_to_roof");
	maps\betrayal_util::wait_for_trigger_and_ai_single("trigger_office_alone_on_roof",level.gideon);
	soundscripts\_snd::snd_message("office_hallway_door_close",var_01,var_00);
	maps\betrayal_util::open_double_sliding_doors_toggle("office_hallway_door",1);
	common_scripts\utility::flag_set("flag_office_clean_up_awards");
}

//Function Number: 7
office_scene_gideon_to_stairs()
{
	common_scripts\utility::run_thread_on_targetname("trigger_office_start_gideon_double_stairs",::office_scene_gideon_down_double_stairs);
	common_scripts\utility::flag_wait("flag_office_gideon_at_stairs_door");
	var_00 = maps\betrayal_util::get_ents_by_targetname("office_roof_door_right");
	var_01 = maps\betrayal_util::get_ents_by_targetname("office_roof_door_left");
	soundscripts\_snd::snd_message("office_roof_door_open",var_01,var_00);
	maps\betrayal_util::open_double_sliding_doors_toggle("office_roof_door",0.75);
	if(isdefined(getent("trigger_office_gideon_to_stairs","targetname")))
	{
		maps\_utility::activate_trigger_with_targetname("trigger_office_gideon_to_stairs");
	}

	common_scripts\utility::flag_set("flag_office_gideon_ready_to_move_down_stairs");
	maps\betrayal_util::wait_for_trigger_and_ai_single("trigger_office_in_stairwell",level.gideon);
	maps\_utility::autosave_by_name();
	soundscripts\_snd::snd_message("office_roof_door_close",var_01,var_00);
	maps\betrayal_util::open_double_sliding_doors_toggle("office_roof_door",1);
	common_scripts\_exploder::exploder(1999);
}

//Function Number: 8
office_scene_gideon_down_double_stairs()
{
	self waittill("trigger");
	var_00 = maps\betrayal_util::get_ent_by_targetname("animorg_atlas_stairs");
	var_00 maps\_anim::anim_reach_solo(level.gideon,"atlas_bldg_double_stairs");
	var_00 maps\_anim::anim_single_solo_run(level.gideon,"atlas_bldg_double_stairs");
	var_00 delete();
}

//Function Number: 9
office_scene_gideon_enter_secret_room()
{
	maps\_utility::trigger_wait_targetname("trigger_office_gideon_to_swipe_door");
	var_00 = maps\betrayal_util::get_ent_by_targetname("animorg_atlas_keycard");
	level.gideon_walking_down_stairs = 1;
	var_00 maps\_anim::anim_reach_solo(level.gideon,"atlas_bldg_swipe_door");
	common_scripts\utility::flag_set("flag_office_gideon_scanning_door");
	soundscripts\_snd::snd_message("bet_gideon_arm_scanner");
	common_scripts\utility::flag_set("flag_dialogue_office_door");
	var_00 maps\_anim::anim_single_solo_run(level.gideon,"atlas_bldg_swipe_door");
	var_00 delete();
}

//Function Number: 10
office_scene_open_swipe_door(param_00)
{
	var_01 = getent("confrontation_door_security_scanner","targetname");
	var_02 = getent("confrontation_door_security_scanner_glow","targetname");
	var_01 setmodel("security_lock_01_unlocked");
	var_02 setmodel("security_lock_01_unlocked_glow");
	wait(2.75);
	var_03 = maps\betrayal_util::get_ents_by_targetname("confrontation_room_enter_door_left");
	var_03 soundscripts\_snd::snd_message("aud_scanner_door_open");
	thread maps\betrayal_util::open_sliding_door_toggle(var_03,"confrontation_room_enter_door",0.5);
	wait(0.5);
	thread office_scene_scripted_player_blocker_move_with_gideon();
	maps\betrayal_util::wait_for_trigger_and_ai_single("trigger_everyone_in_secret_room",level.gideon);
	level thread maps\betrayal_util::open_sliding_door_toggle(var_03,"confrontation_room_enter_door",1);
	common_scripts\utility::flag_set("flag_objective_office_scene_follow_gideon_complete");
}

//Function Number: 11
office_scene_player_actions_manager()
{
	level.player disableweapons();
	level.player giveweapon("iw5_unarmed_nullattach");
	wait(0.5);
	level.player switchtoweapon("iw5_unarmed_nullattach");
	level.player disableweaponswitch();
	level.player maps\_shg_utility::setup_player_for_scene();
	level.player allowjump(0);
	level.player allowprone(0);
	level.player disableoffhandweapons();
	level.player disableoffhandsecondaryweapons();
	level.player allowsprint(0);
	common_scripts\utility::flag_wait("flag_confrontation_give_player_real_gun");
	level.player takeweapon("iw5_unarmed_nullattach");
	var_00 = level.player getweaponslist("primary");
	level.player enableweaponswitch();
	level.player switchtoweapon(var_00[0]);
	level.player disableweapons();
	level.player allowjump(1);
	level.player allowprone(1);
	level.player enableoffhandweapons();
	level.player enableoffhandsecondaryweapons();
	level.player allowsprint(1);
}

//Function Number: 12
office_scene_player_give_just_hands()
{
	level.player allowmelee(0);
	level.player allowsprint(0);
	level.player setmovespeedscale(0.47);
}

//Function Number: 13
office_scene_player_movement_manager()
{
	level thread office_scene_player_handle_move_speed();
	common_scripts\utility::flag_wait("trigger_office_scene_player_at_confrontation");
	level.player maps\_utility::player_speed_default(1);
}

//Function Number: 14
office_scene_player_handle_move_speed()
{
	var_00 = 0.05;
	var_01 = 0.65;
	var_02 = 0;
	var_03 = 120;
	var_04 = 500;
	var_05 = 200;
	level.player setmovespeedscale(1);
	level.playerspeedscale = 1;
	var_06 = 1;
	while(!common_scripts\utility::flag("flag_office_gideon_scanning_door"))
	{
		var_07 = distance(level.gideon.origin,level.player.origin);
		var_08 = vectornormalize(anglestoforward(level.gideon.angles) + vectornormalize(level.gideon.origin - level.player.origin));
		var_09 = level.gideon maps\_shg_utility::get_differentiated_velocity();
		var_0A = level.player maps\_shg_utility::get_differentiated_velocity();
		if(var_07 > var_04 || abs(level.gideon.origin[2] - level.player.origin[2]) > 110)
		{
			var_0B = vectorlerp((level.playerspeedscale,0,0),(1,0,0),0.1);
			if(isdefined(level.gideon_walking_down_stairs) && level.gideon_walking_down_stairs)
			{
			}

			level.player setmovespeedscale(var_0B[0]);
			level.playerspeedscale = var_0B[0];
			wait 0.05;
			continue;
		}

		var_0C = 0 - office_scene_player_signed_distance_to_plane(level.gideon.origin,var_08,level.player.origin);
		var_0D = var_0C;
		var_06 = maps\_shg_utility::linear_map_clamp(var_0D,var_02,var_03,var_00,var_01);
		var_0E = length(var_09);
		var_0F = length(var_0A);
		if(var_0E > var_0F)
		{
			var_06 = var_06 * 1.1;
		}

		waittillframeend;
		if(isdefined(level.gideon_walking_down_stairs) && level.gideon_walking_down_stairs)
		{
			var_06 = var_06 * 0.9;
		}

		var_0B = vectorlerp((level.playerspeedscale,0,0),(var_06,0,0),0.32);
		level.player setmovespeedscale(var_0B[0]);
		level.playerspeedscale = var_0B[0];
		wait 0.05;
	}

	level.gideon_walking_down_stairs = undefined;
	var_10 = 1 - var_06 / 50;
	while(var_06 < 1)
	{
		var_06 = var_06 + var_10;
		level.player setmovespeedscale(var_06);
		wait(0.1);
	}

	level.player setmovespeedscale(1);
}

//Function Number: 15
office_scene_player_signed_distance_to_plane(param_00,param_01,param_02)
{
	return vectordot(param_02 - param_00,param_01);
}

//Function Number: 16
office_scene_vignette_setup()
{
	thread office_scene_vignette_setup_civilians();
	maps\betrayal_util::add_spawn_function_to_noteworthy("office_scene_silent_heli",::office_scene_silence_heli);
	thread office_scene_vignette_helicopters();
	thread office_scene_vignette_drones();
	thread office_scene_vignette_boats();
	level thread office_scene_vignette_spawn_personal_guard_hallway();
	wait(0.5);
	maps\_utility::activate_trigger_with_targetname("office_scene_vig_civ_trigger");
	maps\_utility::activate_trigger_with_targetname("office_scene_vig_civ_walker_trigger");
}

//Function Number: 17
office_scene_vignette_setup_civilians()
{
	common_scripts\utility::run_thread_on_targetname("office_scene_civilian_spawn_trig",::maps\betrayal_util::civilian_setup,"roof_scene_civilian_react_trig",0,0);
	common_scripts\utility::run_thread_on_targetname("office_scene_civilian_walker_spawn_trig",::maps\betrayal_util::civilian_walker_setup,"roof_scene_civilian_react_trig",0);
	common_scripts\utility::run_thread_on_targetname("office_scene_vig_civ_trigger",::maps\betrayal_util::civilian_setup,10000,1);
	common_scripts\utility::run_thread_on_targetname("office_scene_vig_civ_walker_trigger",::maps\betrayal_util::civilian_walker_setup,"roof_scene_civilian_react_trig",0);
	thread office_scene_scripted_dodge_gideon_civilian();
	thread office_scene_vignette_handle_atlas_ai();
	wait(0.5);
	level.office_civ = getent("spawner_office_atlas_employee","script_noteworthy");
	level.office_civ.animname = "atlas_emp_1";
}

//Function Number: 18
office_scene_vignette_drones()
{
	common_scripts\utility::flag_wait("office_scene_heli_go_3");
	var_00 = getentarray("sewer_scene_drone","targetname");
	foreach(var_02 in var_00)
	{
		var_03 = var_02 maps\_vehicle::spawn_vehicle_and_gopath();
		var_03 thread office_scene_vignette_handle_drones();
	}
}

//Function Number: 19
office_scene_vignette_handle_drones()
{
	common_scripts\utility::flag_wait("trigger_office_scene_player_at_confrontation");
	if(isdefined(self))
	{
		self delete();
	}
}

//Function Number: 20
office_scene_vignette_boats()
{
	level thread office_scene_vignette_boat_loop_handler("vig_civ_boat","trigger_office_scene_player_at_confrontation");
}

//Function Number: 21
office_scene_vignette_boat_loop_handler(param_00,param_01)
{
	var_02 = getentarray(param_00,"targetname");
	level.boats = [];
	level.active_boats = [];
	foreach(var_04 in var_02)
	{
		var_05 = var_04 maps\_utility::spawn_vehicle();
		level.boats = common_scripts\utility::array_add(level.boats,var_05);
		if(issubstr(var_05.model,"watertaxi_01"))
		{
			level thread maps\betrayal_fx::treadfx_ai_boats_taxi_vista(var_05);
			continue;
		}

		level thread maps\betrayal_fx::treadfx_ai_boats_yacht_vista(var_05);
	}

	while(!common_scripts\utility::flag(param_01))
	{
		if(level.active_boats.size < 6)
		{
			var_07 = 0;
			for(;;)
			{
				var_08 = 1;
				var_07 = randomintrange(0,level.boats.size);
				if(!common_scripts\utility::array_contains(level.active_boats,level.boats[var_07]))
				{
					break;
				}

				wait(0.05);
			}

			level.active_boats = common_scripts\utility::array_add(level.active_boats,level.boats[var_07]);
			level.boats[var_07] childthread office_scene_vignette_send_boat_through_path();
			wait(randomintrange(7,12));
		}

		wait(1);
	}

	common_scripts\utility::flag_wait(param_01);
	foreach(var_0A in level.boats)
	{
		if(isdefined(var_0A))
		{
			level.boats = common_scripts\utility::array_remove(level.boats,var_0A);
			var_0A delete();
		}
	}
}

//Function Number: 22
office_scene_vignette_send_boat_through_path(param_00)
{
	var_01 = self.origin;
	var_02 = self.angles;
	var_03 = getvehiclenode(self.target,"targetname");
	thread maps\_vehicle_code::_vehicle_paths(var_03);
	self startpath(var_03);
	self waittill("reached_dynamic_path_end");
	self vehicle_teleport(var_01,var_02,0);
	level.active_boats = common_scripts\utility::array_remove(level.active_boats,self);
}

//Function Number: 23
office_scene_vignette_helicopters()
{
	common_scripts\utility::flag_wait("office_scene_heli_go_1");
	var_00 = maps\_vehicle::spawn_vehicle_from_targetname_and_drive("office_scene_warbird01");
	var_00 soundscripts\_snd::snd_message("aud_ambient_helicopter","office_scene_warbird01");
	if(level.nextgen)
	{
		thread maps\betrayal_util::spawn_and_handle_looping_helicopters("office_scene_looping_heli","trigger_office_scene_player_at_confrontation",2);
	}
	else
	{
		thread maps\betrayal_util::spawn_and_handle_looping_helicopters("office_scene_looping_heli","trigger_office_scene_player_at_confrontation",1);
	}

	common_scripts\utility::flag_wait("office_scene_heli_go_2");
	if(level.nextgen)
	{
		var_01 = maps\_vehicle::spawn_vehicle_from_targetname_and_drive("office_scene_warbird02");
		var_01 soundscripts\_snd::snd_message("aud_ambient_helicopter","office_scene_warbird02");
		var_01 thread office_scene_scripted_handle_landing_heli("trigger_office_gideon_to_swipe_door");
		common_scripts\utility::flag_wait("office_scene_heli_go_3");
		var_02 = maps\_vehicle::spawn_vehicle_from_targetname_and_drive("high_fly_warbird01");
		var_02 soundscripts\_snd::snd_message("aud_ambient_helicopter","high_fly_warbird01");
		if(level.nextgen)
		{
			var_03 = maps\_vehicle::spawn_vehicle_from_targetname_and_drive("high_fly_warbird02");
			var_03 soundscripts\_snd::snd_message("aud_ambient_helicopter","high_fly_warbird02");
			var_04 = maps\_vehicle::spawn_vehicle_from_targetname_and_drive("high_fly_warbird03");
			var_04 soundscripts\_snd::snd_message("aud_ambient_helicopter","high_fly_warbird03");
		}
	}
}

//Function Number: 24
office_scene_silence_heli()
{
	self vehicle_turnengineoff();
}

//Function Number: 25
office_scene_vignette_handle_atlas_ai()
{
	var_00 = getentarray("office_scene_atlas_ai_spawner","targetname");
	foreach(var_02 in var_00)
	{
		var_03 = common_scripts\utility::getstructarray(var_02.target,"targetname");
		foreach(var_05 in var_03)
		{
			var_06 = var_05 maps\betrayal_util::civilian_spawn_single(var_02,"ai",1);
			var_06 office_scene_vignette_set_atlas_walker_urgent_walk_anims();
			var_06 maps\_utility::forceuseweapon("iw5_bal27_sp_variablereddot","primary");
			var_06.disablearrivals = 1;
			var_06.disableexits = 1;
			var_06 setgoalpos(var_06.origin);
			var_06 thread office_scene_vignette_atlas_walker_manager();
			wait 0.05;
			var_06 forceteleport(var_05.origin,var_05.angles);
			var_06 maps\betrayal_util::remove_display_name();
			var_06 maps\betrayal_util::stop_current_animations();
			var_06.animname = "generic";
			var_06 maps\_utility::set_idle_anim("bet_ceremony_security_idle_guy01");
		}
	}
}

//Function Number: 26
office_scene_vignette_spawn_personal_guard_hallway()
{
	var_00 = [];
	var_01 = maps\betrayal_util::get_ents_by_targetname("office_scene_spawn_personal_guard_hallway");
	foreach(var_03 in var_01)
	{
		var_04 = var_03 maps\_utility::spawn_ai(1);
		var_00 = common_scripts\utility::array_add(var_00,var_04);
	}

	foreach(var_04 in var_00)
	{
		var_04 maps\betrayal_util::remove_display_name();
		var_04 thread maps\betrayal_util::delete_ai_on_flag("trigger_office_scene_player_at_confrontation");
		var_04 maps\betrayal_util::stop_current_animations();
		var_04.animname = "generic";
		var_07 = var_04.animation;
		var_04 maps\_utility::set_idle_anim(var_07);
		var_04 thread maps\_anim::anim_generic_loop(var_04,var_07);
		if(!isdefined(level.office_guard))
		{
			level.office_guard = var_04 common_scripts\utility::spawn_tag_origin();
			level.office_guard.animname = "atlas_emp_2";
		}
	}
}

//Function Number: 27
office_scene_vignette_atlas_walker_manager()
{
	if(isdefined(self.script_linkto))
	{
		var_00 = getent(self.script_linkto,"script_linkname");
		var_00 waittill("trigger");
		var_01 = getnode(self.target,"targetname");
		maps\_utility::set_goal_node(var_01);
		self.goalradius = 16;
		self notify("move");
		self waittill("goal");
		self pushplayer(1);
	}

	common_scripts\utility::flag_wait("trigger_office_scene_player_at_confrontation");
	if(isdefined(self))
	{
		self delete();
	}
}

//Function Number: 28
office_scene_vignette_set_atlas_walker_urgent_walk_anims()
{
	if(isdefined(self.isurgentwalk))
	{
		return;
	}

	maps\_utility::gun_remove();
	self.isurgentwalk = 1;
	self.alwaysrunforward = 1;
	self.alertlevel = "noncombat";
	self.alertlevelint = 0;
	var_00 = ["exposed","exposed_crouch"];
	var_01[1] = %npc_urgent_walk_arrive_1;
	var_01[2] = %npc_urgent_walk_arrive_2;
	var_01[3] = %npc_urgent_walk_arrive_3;
	var_01[4] = %npc_urgent_walk_arrive_4;
	var_01[6] = %npc_urgent_walk_arrive_6;
	var_01[7] = %npc_urgent_walk_arrive_7;
	var_01[8] = %npc_urgent_walk_arrive_8;
	var_01[9] = %npc_urgent_walk_arrive_9;
	var_02[1] = %npc_urgent_walk_exit_1;
	var_02[2] = %npc_urgent_walk_exit_2;
	var_02[3] = %npc_urgent_walk_exit_3;
	var_02[4] = %npc_urgent_walk_exit_4;
	var_02[6] = %npc_urgent_walk_exit_6;
	var_02[7] = %npc_urgent_walk_exit_7;
	var_02[8] = %npc_urgent_walk_exit_8;
	var_02[9] = %npc_urgent_walk_exit_9;
	var_03[0] = %npc_urgent_walk_turn_2;
	var_03[1] = %npc_urgent_walk_turn_1;
	var_03[2] = %npc_urgent_walk_turn_4;
	var_03[3] = %npc_urgent_walk_turn_7;
	var_03[5] = %npc_urgent_walk_turn_9;
	var_03[6] = %npc_urgent_walk_turn_6;
	var_03[7] = %npc_urgent_walk_turn_3;
	var_03[8] = %npc_urgent_walk_turn_2;
	var_04 = [%npc_urgent_walk_twitch01_idle,%npc_urgent_walk_twitch02_idle,%npc_urgent_walk_twitch03_idle];
	maps\_utility::set_npc_anims("urgent_walk_betrayal",%det_casual_walk_fast_burke,%det_casual_walk_fast_burke,var_04,var_01,var_02,var_00,var_03,var_03,undefined);
}

//Function Number: 29
office_scene_scripted_dodge_gideon_civilian()
{
	var_00 = maps\betrayal_util::get_ent_by_targetname("office_scene_gideon_interact_civilian");
	var_01 = var_00 maps\_utility::spawn_ai(1);
	var_00.count = 1;
	var_01.target = var_00.target;
	var_01.animname = "generic";
	var_02 = "civilian_walk_hurried";
	var_01.runanim = level.scr_anim[var_01.animname][var_02][0];
	var_01 maps\_utility::set_run_anim_array(var_02,undefined,1);
	var_01.is_walking = 0;
	var_01 thread office_scene_scripted_dodge_gideon_civ_wait_for_gideon_in_range(175);
	var_01 thread maps\betrayal_util::civilian_actor_play_idle();
	common_scripts\utility::flag_wait("office_scene_civilian_dodges_gideon");
	var_03 = getnode(var_01.target,"targetname");
	var_01 maps\_utility::set_goal_node(var_03);
	var_01.goal_node = var_03;
	var_01 maps\betrayal_util::stop_current_animations();
	var_01 maps\betrayal_util::civilian_detach_props();
	var_01.goalradius = 16;
	var_01 notify("move");
	var_01.is_walking = 1;
	var_01 waittill("goal");
	var_01.is_walking = 0;
	var_01 thread maps\betrayal_util::civilian_actor_play_idle();
	common_scripts\utility::flag_wait("trigger_office_scene_player_at_confrontation");
	if(isdefined(var_01))
	{
		var_01 delete();
	}
}

//Function Number: 30
office_scene_scripted_dodge_gideon_civ_wait_for_gideon_in_range(param_00)
{
	self endon("death");
	maps\_utility::waittill_entity_in_range(level.gideon,param_00);
	maps\betrayal_util::stop_current_animations();
	self.animname = "generic";
	var_01 = "bet_lobby_civ_sidestep_R";
	maps\_anim::anim_single_solo(self,var_01);
	thread maps\betrayal_util::civilian_walker_idle_when_blocked();
	self notify("move");
}

//Function Number: 31
office_scene_scripted_handle_landing_heli(param_00)
{
	var_01 = maps\betrayal_util::get_ent_by_targetname("heli_landing_civ");
	var_02 = var_01 maps\_utility::spawn_ai(1);
	var_02 maps\_utility::set_ignoreall(1);
	var_02.animname = "generic";
	var_03 = "civilian_walk_hurried";
	var_02.runanim = level.scr_anim[var_02.animname][var_03][0];
	var_02 maps\_utility::set_run_anim_array(var_03,undefined,1);
	var_02 thread maps\betrayal_util::civilian_actor_play_idle();
	wait(23);
	var_02 maps\betrayal_util::stop_current_animations();
	var_04 = getnode(var_02.target,"targetname");
	var_02 maps\_utility::set_goal_node(var_04);
	var_02 maps\betrayal_util::civilian_detach_props();
	var_02.goalradius = 16;
	var_02 notify("move");
	wait(10);
	var_05 = common_scripts\utility::getstruct("land_heli_path02","targetname");
	thread maps\_vehicle_code::_vehicle_paths(var_05);
	wait 0.05;
	maps\_utility::trigger_wait_targetname("trigger_office_gideon_to_swipe_door");
	var_02 delete();
	if(isdefined(self))
	{
		self delete();
	}
}

//Function Number: 32
office_scene_scripted_player_blocker_move_with_gideon()
{
	var_00 = maps\betrayal_util::get_ent_by_targetname("block_player_from_confrontation_entrance");
	var_00 linkto(level.gideon);
	wait(5);
	var_00 notsolid();
	var_00 delete();
}

//Function Number: 33
office_scene_cleanup()
{
	maps\_utility::clear_all_color_orders("allies");
	common_scripts\utility::flag_wait("flag_objective_office_scene_follow_gideon_complete");
}

//Function Number: 34
confrontation_scene_master_handler(param_00)
{
	confrontation_scene_setup();
	if(!isdefined(param_00))
	{
		confrontation_scene_hologram();
		confrontation_scene_irons_lockdown();
	}

	if(isdefined(param_00) && param_00 == "qte")
	{
		level.ilana maps\betrayal_util::setup_squad_member_for_scene();
		common_scripts\utility::flag_set("flag_confrontation_give_player_real_gun");
		confrontation_scene_cleanup_hologram();
		confrontation_scene_cleanup_confrontation();
		var_01 = maps\betrayal_util::get_ents_by_targetname("confrontation_room_exit_door_right");
		thread maps\betrayal_util::open_sliding_door_toggle(var_01,"confrontation_room_exit_door",0.2);
		level.player maps\_shg_utility::setup_player_for_scene();
		level.confrontation_rig show();
		level.player playerlinktodelta(level.confrontation_rig,"tag_player",0.75,10,10,7,7,1);
		if(level.nextgen)
		{
			setsaveddvar("r_adaptiveSubdivBaseFactor",0.01);
		}
	}

	confrontation_scene_escape();
	if(level.nextgen)
	{
		setsaveddvar("r_adaptiveSubdivBaseFactor",1.5);
	}

	confrontation_scene_cleaup();
	level thread escape_scene_master_handler();
}

//Function Number: 35
hoverscreen_chromo_anim2(param_00,param_01)
{
	var_02 = 0;
	if(param_01)
	{
		var_02 = param_01;
	}

	var_03 = param_00 * 20;
	var_04 = 0;
	var_05 = level.chromo_offset;
	level.chromo_offset = var_02;
	thread confrontation_hudoutline_animate();
	for(var_04 = 0;var_04 < var_03;var_04++)
	{
		var_06 = 1 / var_03 * var_05;
		level.chromo_offset = level.chromo_offset + var_06;
		setsaveddvar("r_chromaticSeparationG",level.chromo_offset * -1);
		setsaveddvar("r_chromaticSeparationR",level.chromo_offset);
		wait(0.05);
	}
}

//Function Number: 36
create_confrontation_static_overlay(param_00,param_01,param_02)
{
	level.chromo_offset = 5;
	setsaveddvar("r_chromaticAberrationTweaks",1);
	setsaveddvar("r_chromaticAberration",2);
	setsaveddvar("r_chromaticSeparationG",0);
	setsaveddvar("r_chromaticSeparationR",0);
	setsaveddvar("r_chromaticSeparationB",0);
	setsaveddvar("r_chromaticAberrationAlpha",1);
	var_03 = 1;
	return var_03;
}

//Function Number: 37
confrontation_static_start()
{
	level.player.conf_static = create_confrontation_static_overlay("overlay_static",10,0.05);
	thread hoverscreen_chromo_anim2(6,0);
	soundscripts\_snd::snd_message("bet_hologram_start");
}

//Function Number: 38
confrontation_hudoutline_setup()
{
	setsaveddvar("r_hudoutlinehaloblurradius",10);
	setsaveddvar("r_hudoutlineenable",1);
	setsaveddvar("r_hudoutlinecurvywidth",1);
	setsaveddvar("r_hudoutlinecurvywhen",1);
	setsaveddvar("r_hudoutlinepostmode",3);
	setsaveddvar("r_hudoutlinecurvylumscale",0.2);
	setsaveddvar("r_hudoutlinecurvydarkenscale",0.25);
	setsaveddvar("r_hudoutlinecurvyblurradius",0.5);
	setsaveddvar("r_hudoutlinecurvydepth",0.8);
	if(!isdefined(level.player.detection_highlight_hud_effect))
	{
		level.player.detection_highlight_hud_effect_old = level.player.detection_highlight_hud_effect;
		level.player.detection_highlight_hud_effect = newclienthudelem(level.player);
		level.player.detection_highlight_hud_effect.color = (0,0.005,0.01);
		level.player.detection_highlight_hud_effect.alpha = 0.01;
	}
}

//Function Number: 39
confrontation_hologram_fadeout()
{
	var_00 = 0;
	level.hologram_rand_level = 0;
	var_01 = 1;
	while(level.confrontation_holo.size < 4)
	{
		wait(0.05);
	}

	foreach(var_03 in level.confrontation_holo)
	{
		var_03.hidden = 0;
	}

	while(var_01)
	{
		foreach(var_03 in level.confrontation_holo)
		{
			if(!isdefined(var_03))
			{
				level.confrontation_holo = undefined;
				var_01 = 0;
			}
		}

		var_07 = 10000;
		if(var_01)
		{
			var_08 = level.player.origin;
			foreach(var_03 in level.confrontation_holo)
			{
				var_0A = var_03 gettagorigin("tag_origin");
				var_0B = distance((var_08[0],var_08[1],0),(var_0A[0],var_0A[1],0));
				if(var_0B < var_07)
				{
					var_07 = var_0B;
				}

				if(var_03.hidden == 0 && var_0B < 50)
				{
					if(var_0B < 36)
					{
						var_03 hide();
						var_03.hidden = 1;
					}
					else if(randomfloat(100) < 50)
					{
						var_03 hide();
					}
					else
					{
						var_03 show();
					}
				}

				if(var_0B >= 50)
				{
					var_03 show();
					var_03.hidden = 0;
				}
			}

			var_0D = randomfloat(1) * 2 - 1;
			var_0E = 1 - clamp(var_07 / 52,0,1);
			level.hologram_rand_level = var_0D * var_0E;
			wait(0.05);
		}
	}
}

//Function Number: 40
confrontation_hudoutline_animate()
{
	thread confrontation_hologram_fadeout();
	level.hudoutline_conf_intensity = 1;
	var_00 = 0;
	while(isdefined(level.player.detection_highlight_hud_effect))
	{
		var_01 = perlinnoise2d(var_00 * 2,0.5,3,2,0.5) * 5;
		var_02 = clamp(var_01 * 1.2 - 1,0,1) * 2.5;
		if(isdefined(level.hologram_rand_level))
		{
			var_02 = clamp(var_02 + level.hologram_rand_level * 5,-5,5) * 2.5;
		}

		setsaveddvar("r_hudoutlinecurvylumscale",0.15 + 0.1 * var_01 * level.hudoutline_conf_intensity);
		setsaveddvar("r_hudoutlinehalolumscale",0.15 + 0.1 * var_01 * level.hudoutline_conf_intensity);
		setsaveddvar("r_chromaticSeparationG",level.chromo_offset * -1 * var_02);
		setsaveddvar("r_chromaticSeparationR",level.chromo_offset * var_02);
		var_00 = var_00 + 0.05;
		wait(0.05);
	}
}

//Function Number: 41
confrontation_hudoutline_cleanup()
{
	var_00 = 1;
	var_01 = 20;
	var_02 = 0;
	var_03 = level.chromo_offset;
	level.chromo_offset = var_00;
	for(var_02 = 0;var_02 < var_01;var_02++)
	{
		var_04 = 1 / var_01 * var_03;
		var_05 = 1 / var_01;
		level.chromo_offset = level.chromo_offset - var_04;
		level.hudoutline_conf_intensity = level.hudoutline_conf_intensity - var_05;
		level.chromo_offset = clamp(level.chromo_offset,0,20);
		level.hudoutline_conf_intensity = clamp(level.hudoutline_conf_intensity,0,20);
		setsaveddvar("r_chromaticSeparationG",level.chromo_offset * -1);
		setsaveddvar("r_chromaticSeparationR",level.chromo_offset);
		wait(0.05);
	}

	setsaveddvar("r_hudoutlineenable",0);
	setsaveddvar("r_chromaticAberrationTweaks",0);
	setsaveddvar("r_chromaticAberration",0);
	level.player.detection_highlight_hud_effect destroy();
	level.player.detection_highlight_hud_effect = level.player.detection_highlight_hud_effect_old;
}

//Function Number: 42
confrontation_scene_setup()
{
	maps\betrayal_util::spawn_squad("start_confrontation",0,1);
	var_00 = maps\betrayal_util::spawn_ai_from_targetname_single("spawner_confrontation_irons",1,0);
	var_00.animname = "irons";
	var_00 setcontents(0);
	confrontation_hudoutline_setup();
	level thread maps\betrayal_lighting::lighting_confrontation_auto_dof(level.player,var_00);
	var_00 attach("npc_mp443_nocamo","TAG_WEAPON_RIGHT",1);
	var_00 hidepart("TAG_RAIL_MASTER_ON","npc_mp443_nocamo");
	var_00 hide();
	var_00.ignoreall = 1;
	var_00.ignoreme = 1;
	var_01 = maps\betrayal_util::spawn_ai_from_targetname_single("spawner_confrontation_technologist",1,0);
	var_01.animname = "technologist";
	var_01 setcontents(0);
	var_01 hide();
	var_02 = maps\betrayal_util::spawn_ai_from_targetname_single("spawner_confrontation_guard1",1,0);
	var_02 maps\_utility::gun_remove();
	var_02 hide();
	var_02 maps\_utility::place_weapon_on("iw5_sn6_sp_opticsreddot","right");
	var_02.animname = "guard1";
	var_02.ignoreall = 1;
	var_02.ignoreme = 1;
	var_02.allowdeath = 1;
	var_02.a.nodeath = 1;
	var_02.noragdoll = 1;
	var_02 maps\betrayal_util::remove_display_name();
	level.escape_take_down_guard = var_02;
	var_03 = maps\_utility::spawn_anim_model("flash_bang",var_02.origin,var_02.angles);
	var_04 = maps\_utility::spawn_anim_model("irons_chair",var_00.origin,var_00.angles);
	var_04 setmodel("dem_irons_chair_01_cloaktrans");
	var_04 hide();
	var_05 = maps\_utility::spawn_anim_model("guest_chair",var_00.origin,var_00.angles);
	var_05 hide();
	var_05 setmodel("dem_irons_guest_chair_01_rig_cloaktrans");
	var_06 = maps\_utility::spawn_anim_model("jammer",level.ilana.origin,level.ilana.angles);
	var_07 = maps\betrayal_util::get_ent_by_targetname("animorg_confrontation");
	var_07 maps\_anim::anim_first_frame_solo(level.ilana,"confrontation_pt1");
	var_07 maps\_anim::anim_first_frame_solo(var_00,"confrontation_pt1");
	var_07 maps\_anim::anim_first_frame_solo(var_01,"confrontation_pt1");
	var_07 maps\_anim::anim_first_frame_solo(var_02,"confrontation_pt1");
	var_07 maps\_anim::anim_first_frame_solo(var_03,"confrontation_pt1");
	var_07 maps\_anim::anim_first_frame_solo(var_04,"confrontation_pt1");
	var_07 maps\_anim::anim_first_frame_solo(var_05,"confrontation_pt1");
	var_07 maps\_anim::anim_first_frame_solo(var_06,"confrontation_pt1");
	level.hologram_guys = [level.ilana,level.gideon,var_00,var_01,var_02,var_03,var_04,var_05,var_06];
	var_08 = maps\betrayal_util::spawn_ai_from_targetname_single("spawner_confrontation_ironsreal",1,0);
	var_08 hide();
	var_08.animname = "irons";
	var_08.ignoreall = 1;
	var_08.ignoreme = 1;
	var_08 maps\betrayal_util::remove_display_name();
	var_09 = maps\betrayal_util::spawn_ai_from_targetname_single("spawner_confrontation_guard2",1,0);
	var_09 maps\_utility::gun_remove();
	var_09 hide();
	var_09 maps\_utility::place_weapon_on("iw5_sn6_sp_opticsreddot","right");
	var_09.animname = "guard2";
	var_09.ignoreall = 1;
	var_09.ignoreme = 1;
	var_09.allowdeath = 1;
	var_09.a.nodeath = 1;
	var_09.noragdoll = 1;
	var_09 thread maps\_utility::magic_bullet_shield();
	var_09 maps\betrayal_util::remove_display_name();
	level.escape_shoot_guard = var_09;
	var_0A = maps\_utility::spawn_anim_model("player_pistol",level.player.origin + (0,0,-100),level.player.angles);
	level.confrontation_rig = maps\_utility::spawn_anim_model("player_rig",level.player.origin,level.player.angles);
	level.confrontation_rig hide();
	level.confrontation_guys = [level.ilana,level.gideon,var_08,var_02,var_09,var_0A,level.confrontation_rig];
	level.escape_guys1 = [level.ilana,var_02,var_09,level.confrontation_rig];
	level.escape_guys2_a = [var_02,level.confrontation_rig];
	level.escape_guys2_b = [level.ilana,var_09];
	level.escape_guys3 = [var_09,level.ilana];
	level.escape_guys3_a = [var_09];
	level.escape_guys3_b = [level.ilana];
	common_scripts\utility::flag_set("flag_dialogue_start_confrontation");
	common_scripts\utility::flag_set("confrontation_start_lighting");
	wait 0.05;
	var_0B = var_00 getorigin();
	var_0B = var_0B + (0,0,-150);
	var_00 overridelightingorigin(var_0B);
	var_01 overridelightingorigin(var_0B);
	var_00 overridereflectionprobe(var_0B);
	var_01 overridereflectionprobe(var_0B);
	var_04 overridelightingorigin(var_0B);
	var_05 overridelightingorigin(var_0B);
	var_04 overridereflectionprobe(var_0B);
	var_05 overridereflectionprobe(var_0B);
}

//Function Number: 43
confrontation_scene_hologram()
{
	var_00 = maps\betrayal_util::get_ent_by_targetname("animorg_confrontation");
	var_00 maps\_anim::anim_reach_solo(level.gideon,"confrontation_pt1");
	maps\_utility::autosave_by_name();
	level.ilana maps\betrayal_util::setup_squad_member_for_scene();
	level.gideon maps\betrayal_util::setup_squad_member_for_scene();
	if(level.nextgen)
	{
		setsaveddvar("r_adaptiveSubdivBaseFactor",0.01);
	}

	var_00 maps\_anim::anim_single(level.hologram_guys,"confrontation_pt1");
	confrontation_scene_cleanup_hologram();
	maps\_utility::autosave_by_name();
}

//Function Number: 44
confrontation_scene_irons_no_gun(param_00)
{
	param_00 setmodel("irons_casual_nogun");
}

//Function Number: 45
confrontation_scene_cleanup_hologram()
{
	foreach(var_01 in level.hologram_guys)
	{
		if(!common_scripts\utility::array_contains(level.confrontation_guys,var_01))
		{
			var_01 delete();
		}
	}
}

//Function Number: 46
confrontation_scene_open_flashbang_door(param_00)
{
	var_01 = maps\betrayal_util::get_ents_by_targetname("confrontation_room_exit_door_right");
	thread maps\betrayal_util::open_sliding_door_toggle(var_01,"confrontation_room_exit_door",0.2,0.1);
}

//Function Number: 47
confrontation_scene_flashbang_explode(param_00)
{
	soundscripts\_snd::snd_message("bet_conf_flash_bang_exp");
	level.player lightsetforplayer("betrayal_interior_flash");
	maps\_utility::vision_set_changes("betrayal_interior_flash",0.02);
	level.player playrumbleonentity("grenade_rumble");
	wait(1);
	if(level.nextgen)
	{
		level.player lightsetforplayer("betrayal_interior_confrontation_2");
		maps\_utility::vision_set_changes("betrayal_interior",2);
		return;
	}

	level.player lightsetforplayer("betrayal_interior_darker");
	maps\_utility::vision_set_changes("betrayal_interior_darker",2);
}

//Function Number: 48
confrontation_scene_irons_lockdown()
{
	var_00 = maps\betrayal_util::get_ent_by_targetname("animorg_confrontation");
	common_scripts\utility::flag_set("confrontation2_start_lighting");
	soundscripts\_snd::snd_music_message("betrayal_scene_begin");
	var_01 = maps\betrayal_util::get_ents_by_targetname("confrontation_room_exit_door_right");
	thread maps\betrayal_util::open_sliding_door_toggle(var_01,"confrontation_room_exit_door",0.2);
	level.player maps\_shg_utility::setup_player_for_scene();
	level.player playerlinktodelta(level.confrontation_rig,"tag_player",0.75,0,0,0,0,1);
	level.player enableslowaim();
	var_02 = 0.5;
	level.confrontation_rig common_scripts\utility::delaycall(var_02,::show);
	level.player common_scripts\utility::delaycall(var_02 + 0.1,::lerpviewangleclamp,2,0,1,15,15,10,8);
	common_scripts\utility::flag_set("flag_confrontation_give_player_real_gun");
	foreach(var_04 in level.confrontation_guys)
	{
		var_04 show();
	}

	var_06 = getent("betrayal_conf_ilana_origin","targetname");
	level.confrontation_guys[0] overridelightingorigin(var_06.origin);
	var_07 = getent("betrayal_confrontation_guard1_origin","targetname");
	var_08 = getent("betrayal_confrontation_guard2_origin","targetname");
	level.confrontation_guys[3] overridelightingorigin(var_07.origin);
	level.confrontation_guys[4] overridelightingorigin(var_08.origin);
	var_00 maps\_anim::anim_single(level.confrontation_guys,"confrontation_pt2");
	confrontation_scene_cleanup_confrontation();
	common_scripts\utility::flag_set("flag_dialog_confrontation_mrX");
	level.player lerpviewangleclamp(2,0,1,10,10,7,7);
	var_00 maps\_anim::anim_single(level.escape_guys1,"confrontation_pt2_pause");
	maps\_utility::autosave_by_name();
}

//Function Number: 49
confrontation_scene_cleanup_confrontation()
{
	foreach(var_01 in level.confrontation_guys)
	{
		if(!common_scripts\utility::array_contains(level.escape_guys1,var_01))
		{
			if(var_01 == level.gideon)
			{
				var_01 maps\_utility::stop_magic_bullet_shield();
			}

			var_01 delete();
		}
	}
}

//Function Number: 50
confrontation_scene_escape()
{
	var_00 = maps\betrayal_util::get_ent_by_targetname("animorg_confrontation");
	common_scripts\utility::flag_set("escape_lighting");
	level.ilana defaultlightingorigin();
	common_scripts\utility::flag_set("flag_dialog_confrontation_go");
	soundscripts\_snd::snd_message("bet_conf_fire_suppression");
	var_00 maps\_anim::anim_single(level.escape_guys1,"escape_pt1");
	level notify("escape_pt1_done");
	if(!common_scripts\utility::flag("flag_escape_pt1_passed"))
	{
		confrontation_scene_qte_kick_slomo_stop();
		var_00 maps\_anim::anim_single(level.escape_guys1,"escape_pt1_fail");
		wait(100);
	}

	soundscripts\_snd::snd_music_message("post_betrayal_action");
	level thread confrontation_scene_escape_player_rise(var_00);
	var_00 maps\_anim::anim_single(level.escape_guys2_b,"escape_pt2");
	level notify("escape_pt2_done");
	if(!common_scripts\utility::flag("flag_escape_pt2_passed"))
	{
		confrontation_scene_qte_shoot_slomo_stop();
		var_00 maps\_anim::anim_single(level.escape_guys3,"escape_pt3_fail");
		wait(100);
	}

	var_01 = level.escape_shoot_guard setcontents(0);
	level.player disableslowaim();
	level.player unlink();
	level.confrontation_rig delete();
	thread confrontation_handle_player_clip();
	maps\_player_exo::player_exo_activate();
	level thread confrontation_scene_escape_guard_dies(var_00);
	common_scripts\utility::flag_set("flag_dialog_confrontation_leave");
	soundscripts\_snd::snd_message("bet_conf_kill_guard");
	var_00 maps\_anim::anim_single_solo_run(level.escape_guys3_b[0],"escape_pt3");
	foreach(var_03 in level.escape_guys1)
	{
		if(!isremovedentity(var_03) && var_03 != level.ilana)
		{
			if(!isai(var_03))
			{
				var_03 delete();
			}
		}
	}

	maps\_utility::autosave_by_name();
}

//Function Number: 51
confrontation_scene_escape_player_rise(param_00)
{
	param_00 maps\_anim::anim_single(level.escape_guys2_a,"escape_pt2");
	level.escape_take_down_guard.allowdeath = 1;
	level.escape_take_down_guard.a.nodeath = 1;
	level.escape_take_down_guard.noragdoll = 1;
	level.escape_take_down_guard maps\_utility::gun_remove();
	level.escape_take_down_guard kill();
}

//Function Number: 52
confrontation_scene_escape_qte_fail(param_00)
{
	if(!common_scripts\utility::flag("missionfailed"))
	{
		if(param_00.animname == "player_rig")
		{
			setdvar("ui_deadquote",&"BETRAYAL_FAIL_ESCAPE");
		}
		else
		{
			setdvar("ui_deadquote",&"BETRAYAL_FAIL_ESCAPE_SHOOT");
		}

		maps\_utility::missionfailedwrapper();
	}
}

//Function Number: 53
confrontation_scene_escape_qte_kick(param_00)
{
	level endon("escape_pt1_done");
	var_01 = level.escape_take_down_guard maps\_shg_utility::hint_button_tag("melee","j_knee_le");
	var_01 thread confrontation_scene_button_clean_up("escape_pt1_done");
	confrontation_scene_qte_kick_slomo_start();
	while(!common_scripts\utility::flag("flag_escape_pt1_passed"))
	{
		if(level.player meleebuttonpressed())
		{
			confrontation_scene_qte_kick_slomo_stop();
			common_scripts\utility::flag_set("flag_escape_pt1_passed");
			break;
		}

		wait(0.05);
	}

	var_01 maps\_shg_utility::hint_button_clear();
}

//Function Number: 54
confrontation_scene_escape_qte_kick_kill(param_00)
{
	level.player maps\_upgrade_challenge::give_player_challenge_kill(1);
}

//Function Number: 55
confrontation_scene_button_clean_up(param_00)
{
	level waittill(param_00);
	if(isdefined(self))
	{
		maps\_shg_utility::hint_button_clear();
	}
}

//Function Number: 56
confrontation_scene_escape_qte_raise_gun(param_00)
{
	confrontation_scene_qte_shoot_slomo_start();
	level.ilana maps\betrayal_util::setup_squad_member_for_gameplay();
	level.player maps\_shg_utility::setup_player_for_gameplay();
	level.player disableoffhandweapons();
	level.player disableoffhandsecondaryweapons();
	level.player notify("stop_player_walk_sway");
	level.player thread maps\_utility::blend_movespeedscale_default();
	level.player setmovespeedscale(1);
	level.player lerpviewangleclamp(2,0,1,15,15,10,10);
	param_00 hide();
}

//Function Number: 57
confrontation_scene_escape_qte_shoot(param_00)
{
	level endon("escape_pt2_done");
	for(;;)
	{
		level.escape_shoot_guard waittill("damage",var_01,var_02);
		if(var_02 == level.player)
		{
			if(level.escape_shoot_guard.damagelocation == "helmet" || level.escape_shoot_guard.damagelocation == "head")
			{
				level.player maps\_upgrade_challenge::give_player_challenge_headshot(1);
			}
			else
			{
				level.player maps\_upgrade_challenge::give_player_challenge_kill(1);
			}

			confrontation_scene_qte_shoot_slomo_stop();
			common_scripts\utility::flag_set("flag_escape_pt2_passed");
			level.player enableoffhandweapons();
			level.player enableoffhandsecondaryweapons();
			break;
		}

		wait(0.05);
	}
}

//Function Number: 58
confrontation_scene_escape_guard_dies(param_00)
{
	param_00 maps\_anim::anim_single(level.escape_guys3_a,"escape_pt3");
	level.escape_shoot_guard.allowdeath = 1;
	level.escape_shoot_guard.a.nodeath = 1;
	level.escape_shoot_guard.noragdoll = 1;
	level.escape_shoot_guard maps\_utility::stop_magic_bullet_shield();
	level.escape_shoot_guard kill();
}

//Function Number: 59
confrontation_scene_gun_swap(param_00)
{
	level.escape_shoot_guard maps\_utility::gun_remove();
	level.ilana maps\_utility::gun_recall();
}

//Function Number: 60
confrontation_scene_qte_kick_slomo_start()
{
	setslowmotion(1,0.6,0.2);
	soundscripts\_snd::snd_message("bet_conf_slo_mo_kick_start");
}

//Function Number: 61
confrontation_scene_qte_kick_slomo_stop()
{
	setslowmotion(0.6,1,0.2);
	soundscripts\_snd::snd_message("bet_conf_slo_mo_kick_stop");
}

//Function Number: 62
confrontation_scene_qte_shoot_slomo_start()
{
	setslowmotion(1,0.2,1.3);
	soundscripts\_snd::snd_message("bet_conf_slo_mo_shoot_start");
}

//Function Number: 63
confrontation_scene_qte_shoot_slomo_stop()
{
	setslowmotion(0.2,1,0.2);
	soundscripts\_snd::snd_message("bet_conf_slo_mo_shoot_stop");
}

//Function Number: 64
confrontation_scene_player_rumble_heavy(param_00)
{
	level.player playrumbleonentity("grenade_rumble");
}

//Function Number: 65
confrontation_scene_player_rumble_light(param_00)
{
	level.player playrumbleonentity("damage_heavy");
}

//Function Number: 66
confrontation_scene_cleaup()
{
	maps\_utility::clear_all_color_orders("allies");
}

//Function Number: 67
confrontation_handle_player_clip()
{
	var_00 = maps\betrayal_util::get_ent_by_targetname("confrontation_pass_ilona_blocker");
	var_00.org_pos = var_00.origin;
	var_00.close_pos = var_00.origin - (0,0,128);
	var_00 moveto(var_00.close_pos,0.1);
	wait(7.25);
	var_00 moveto(var_00.org_pos,0.1);
	escape_scene_setup_firedoor("escape_scene_fire_safety_drop_door");
	var_01 = maps\betrayal_util::get_ent_by_targetname("escape_scene_fire_safety_drop_door");
	var_01.col notsolid();
	var_01.col connectpaths();
}

//Function Number: 68
escape_scene_master_handler()
{
	common_scripts\utility::flag_set("flag_dialogue_start_escape");
	escape_scene_setup();
	escape_scene_sentinel_makes_contact();
	escape_scene_cleanup();
	level thread roof_scene_master_handler();
}

//Function Number: 69
escape_scene_setup()
{
	escape_scene_setup_firedoor("escape_scene_fire_safety_drop_door");
	escape_scene_setup_firedoor("escape_scene_fire_safety_drop_door_guards");
	escape_scene_setup_firedoor("escape_scene_fire_safety_drop_door_climb");
	level thread escape_scene_start_hallway_drop_door();
	escape_scene_setup_firedoor("escape_scene_elevator_door");
	level.escape_pa = maps\betrayal_util::get_ent_by_targetname("roof_escape_PA");
	level.escape_pa.animname = "PA";
}

//Function Number: 70
escape_scene_cleanup()
{
	common_scripts\utility::flag_set("flag_escape_clean_up_hallway");
	maps\betrayal_util::clean_up_ai_single(level.ilana);
	maps\_utility::clear_all_color_orders("axis");
	maps\_utility::clear_all_color_orders("allies");
}

//Function Number: 71
escape_scene_setup_firedoor(param_00)
{
	var_01 = maps\betrayal_util::get_ents_by_targetname(param_00);
	foreach(var_03 in var_01)
	{
		var_03.org_pos = var_03.origin;
		var_04 = maps\betrayal_util::get_ents_by_targetname(var_03.target);
		foreach(var_06 in var_04)
		{
			if(var_06.classname == "script_origin")
			{
				var_03.open_org = (var_03.origin[0],var_03.origin[1],var_06.origin[2]);
			}

			if(var_06.classname == "script_brushmodel")
			{
				var_03.col = var_06;
			}

			var_07 = var_03 getorigin();
			var_07 = var_07 + (0,0,-5);
			var_03 overridelightingorigin(var_07);
			if(level.currentgen)
			{
				var_08 = getent("door_lighting","targetname");
				var_03 overridelightingorigin(var_08.origin);
			}
		}

		if(isdefined(var_03.col))
		{
			var_03.col linkto(var_03);
		}

		if(!var_03 maps\_utility::ent_flag_exist("fire_door_closed"))
		{
			var_03 maps\_utility::ent_flag_init("fire_door_closed");
		}

		var_03 maps\_utility::ent_flag_set("fire_door_closed");
	}
}

//Function Number: 72
escape_scene_open_firedoor(param_00,param_01,param_02)
{
	maps\_utility::ent_flag_clear("fire_door_closed");
	if(!isdefined(param_01))
	{
		param_01 = 0;
	}

	if(!isdefined(param_02))
	{
		param_02 = 0;
	}

	self moveto(self.open_org,param_00,param_01,param_02);
}

//Function Number: 73
escape_scene_close_firedoor(param_00,param_01,param_02)
{
	maps\_utility::ent_flag_set("fire_door_closed");
	if(!isdefined(param_01))
	{
		param_01 = 0;
	}

	if(!isdefined(param_02))
	{
		param_02 = 0;
	}

	self moveto(self.org_pos,param_00,param_01,param_02);
}

//Function Number: 74
escape_scene_sentinel_makes_contact()
{
	common_scripts\utility::flag_set("flag_objective_escape_scene_start");
	escape_scene_rush_for_door();
	escape_scene_hallway_run();
	escape_scene_hallway_climb();
}

//Function Number: 75
escape_scene_rush_for_door()
{
	thread maps\betrayal_util::handle_ally_keep_up_with_player(level.ilana);
	level thread escape_scene_manage_guards();
	common_scripts\utility::flag_set("flag_escape_scene_rush_door_open");
	maps\_utility::activate_trigger_with_targetname("trigger_escape_ilana_into_hallway");
	level thread maps\betrayal_util::start_fire_suppression_group("escape_scene_fire_supression_point_hallway","flag_escape_clean_up_hallway");
	level thread escape_scene_wait_for_player_past_guard_doors();
	level thread escape_scene_clean_up_secret_room();
}

//Function Number: 76
escape_scene_start_hallway_drop_door()
{
	var_00 = maps\betrayal_util::get_ent_by_targetname("escape_scene_fire_safety_drop_door");
	var_00 show();
	var_00 endon("escape_slam_door");
	if(var_00 maps\_utility::ent_flag("fire_door_closed"))
	{
		var_00 thread escape_scene_open_firedoor(0.5,0.4,0.1);
		soundscripts\_snd::snd_message("fire_door_1_open",var_00);
		wait(0.5);
		var_00.col connectpaths();
		var_00.col solid();
	}

	var_00 thread escape_scene_wait_for_player_past_drop_door();
	var_01 = getentarray("escape_guards_secret_room_spawner","targetname");
	foreach(var_03 in var_01)
	{
		var_04 = var_03 maps\_utility::spawn_ai(1);
		var_05 = getnode(var_03.target,"targetname");
		var_04 maps\_utility::set_goal_node(var_05);
	}
}

//Function Number: 77
escape_scene_wait_for_player_past_guard_doors()
{
	var_00 = maps\betrayal_util::get_ent_by_targetname("escape_scene_fire_safety_drop_door_guards");
	var_00 show();
	var_01 = maps\betrayal_util::get_ent_by_targetname("escape_scene_fire_safety_drop_door");
	var_01 show();
	maps\betrayal_util::wait_for_trigger_and_ai_single("trigger_escape_player_near_climb_door",level.ilana);
	var_00 notify("escape_open_door");
	var_01 notify("escape_open_door");
	if(var_00 maps\_utility::ent_flag("fire_door_closed"))
	{
		var_00 thread escape_scene_open_firedoor(1.5,1);
		var_00 soundscripts\_snd::snd_message("open_firedoor_for_guards");
		var_00.col connectpaths();
	}

	if(var_01 maps\_utility::ent_flag("fire_door_closed"))
	{
		var_01 thread escape_scene_open_firedoor(1.5,1);
		var_01 soundscripts\_snd::snd_message("open_firedoor_for_guards");
		var_01.col connectpaths();
	}
}

//Function Number: 78
escape_scene_wait_for_player_past_drop_door()
{
	maps\betrayal_util::wait_for_trigger_and_ai_single("escape_scene_player_past_drop_door",level.ilana);
	self notify("escape_slam_door");
	if(!maps\_utility::ent_flag("fire_door_closed"))
	{
		thread escape_scene_close_firedoor(0.6,0.5);
		soundscripts\_snd::snd_message("fire_door_1_close",self);
		self.col solid();
		wait(0.5);
	}

	self.col disconnectpaths();
	thread escape_scene_manage_flood_spawn_fire_door();
	common_scripts\utility::flag_wait("flag_escape_ilona_should_cover_player");
	level.ilana maps\_utility::set_ignoreall(0);
}

//Function Number: 79
escape_scene_manage_guards()
{
	level endon("trigger_escape_in_elevator_shaft");
	level.escape_scene_side_door_guards = maps\betrayal_util::spawn_ai_from_targetname("spawner_guard_escape_side_firedoor",1,0);
	common_scripts\utility::array_thread(level.escape_scene_side_door_guards,::maps\_utility::set_ignoreall,0);
	common_scripts\utility::array_thread(level.escape_scene_side_door_guards,::escape_scene_remove_guards_on_complete);
	common_scripts\utility::array_thread(level.escape_scene_side_door_guards,::escape_scene_guard_player_seek,25);
	level.escape_scene_side_door_guards[0] thread escape_scene_guard_call_help();
	maps\betrayal_util::wait_for_trigger_and_ai_single("escape_scene_player_past_drop_door",level.ilana);
	level.escape_scene_confrontation_room_guards = maps\betrayal_util::spawn_ai_from_targetname("spawner_guard_escape_hallway",1,0);
	common_scripts\utility::array_thread(level.escape_scene_confrontation_room_guards,::maps\_utility::set_ignoreall,0);
	common_scripts\utility::array_thread(level.escape_scene_confrontation_room_guards,::escape_scene_remove_guards_on_complete);
	common_scripts\utility::array_thread(level.escape_scene_confrontation_room_guards,::escape_scene_guard_player_seek,25);
	var_00 = maps\betrayal_util::get_ent_by_targetname("escape_scene_enemy_accuracy_increase_trigger");
	var_00 thread escape_scene_manage_guard_accuracy();
	maps\betrayal_util::wait_for_trigger_and_ai_single("escape_turn_on_guard_colors",level.ilana);
	level.escape_scene_side_door_guards = maps\_utility::array_removedead_or_dying(level.escape_scene_side_door_guards);
	level.escape_scene_confrontation_room_guards = maps\_utility::array_removedead_or_dying(level.escape_scene_confrontation_room_guards);
	common_scripts\utility::array_thread(level.escape_scene_side_door_guards,::maps\_utility::set_force_color,"g");
	common_scripts\utility::array_thread(level.escape_scene_confrontation_room_guards,::maps\_utility::set_force_color,"g");
	maps\_utility::activate_trigger_with_targetname("escape_scene_guards_move_up");
}

//Function Number: 80
escape_scene_guard_player_seek(param_00)
{
	maps\_utility::set_goal_radius(param_00);
	maps\_utility::set_goal_ent(level.player);
}

//Function Number: 81
escape_scene_guard_call_help()
{
	maps\betrayal_util::wait_for_trigger_and_ai_single("escape_scene_player_past_drop_door",level.ilana);
	wait(1);
	self.animname = "scripted";
	var_00 = "ny_manhattan_radio_sandman_talk";
	common_scripts\utility::flag_set("flag_dialogue_escape_guarddoor");
	thread maps\_anim::anim_single_solo(self,var_00);
	wait(6);
	maps\betrayal_util::stop_current_animations();
	escape_scene_guard_player_seek(25);
	var_01 = maps\betrayal_util::get_ent_by_targetname("escape_scene_fire_safety_drop_door");
	if(var_01 maps\_utility::ent_flag("fire_door_closed"))
	{
		var_01 thread escape_scene_open_firedoor(2,0,1);
		var_01 soundscripts\_snd::snd_message("open_firedoor_for_guards");
		wait(0.5);
		var_01.col connectpaths();
	}

	var_01 thread escape_scene_close_door_when_player_close();
	var_02 = maps\betrayal_util::get_ent_by_targetname("escape_scene_fire_safety_drop_door_guards");
	if(var_02 maps\_utility::ent_flag("fire_door_closed"))
	{
		var_02 thread escape_scene_open_firedoor(2,0,1);
		var_02 soundscripts\_snd::snd_message("open_firedoor_for_guards");
		wait(0.5);
		var_02.col connectpaths();
	}

	foreach(var_04 in level.escape_scene_side_door_guards)
	{
		if(!isremovedentity(var_04))
		{
			var_04.baseaccuracy = 10;
		}
	}

	level.escape_scene_confrontation_room_guards = common_scripts\utility::array_removeundefined(level.escape_scene_confrontation_room_guards);
	foreach(var_04 in level.escape_scene_confrontation_room_guards)
	{
		if(!isremovedentity(var_04))
		{
			var_04.baseaccuracy = 10;
		}
	}
}

//Function Number: 82
escape_scene_manage_guard_accuracy()
{
	for(;;)
	{
		self waittill("trigger",var_00);
		if(var_00.team == "axis")
		{
			var_00.baseaccuracy = 5;
		}

		wait 0.05;
	}
}

//Function Number: 83
escape_scene_manage_flood_spawn_fire_door()
{
	maps\betrayal_util::wait_for_trigger_and_ai_single("trigger_escape_player_near_climb_door",level.ilana);
	thread escape_scene_close_door_when_player_close();
	wait(8);
	if(!maps\_utility::ent_flag("fire_door_closed"))
	{
		thread escape_scene_close_firedoor(0.5,0.5);
		self.col solid();
		wait(0.5);
	}

	self.col disconnectpaths();
	maps\betrayal_util::wait_for_trigger_and_ai_single("trigger_escape_player_at_climb",level.ilana);
	if(maps\_utility::ent_flag("fire_door_closed"))
	{
		thread escape_scene_open_firedoor(0.5,0.5);
		self.col solid();
		wait(0.5);
	}

	self.col connectpaths();
	self notify("closed");
}

//Function Number: 84
escape_scene_close_door_when_player_close()
{
	self endon("closed");
	maps\_utility::waittill_entity_in_range(level.player,300);
	if(!maps\_utility::ent_flag("fire_door_closed"))
	{
		thread escape_scene_close_firedoor(0.5,0.5);
		self.col solid();
		wait(0.5);
	}

	self.col disconnectpaths();
}

//Function Number: 85
escape_scene_clean_up_secret_room()
{
	maps\betrayal_util::wait_for_trigger_and_ai_single("trigger_escape_out_of_secret_room",level.ilana);
	common_scripts\utility::flag_set("flag_dialogue_escape_intros");
	maps\betrayal_util::wait_for_trigger_and_ai_single("trigger_escape_player_at_climb",level.ilana);
	wait(0.5);
	common_scripts\utility::flag_set("flag_escape_clean_up_secret_room");
}

//Function Number: 86
escape_scene_hallway_run()
{
	maps\_utility::trigger_wait_targetname("trigger_escape_player_near_climb_door");
	var_00 = maps\betrayal_util::get_ent_by_targetname("escape_scene_fire_safety_drop_door_climb");
	if(var_00 maps\_utility::ent_flag("fire_door_closed"))
	{
		var_00 thread escape_scene_open_firedoor(2,0,1);
		soundscripts\_snd::snd_message("big_fire_door_open",var_00);
		wait(0.5);
		var_00.col connectpaths();
	}

	maps\_utility::activate_trigger_with_targetname("trigger_escape_move_to_climb");
	maps\betrayal_util::wait_for_trigger_and_ai_single("trigger_escape_player_at_climb",level.ilana);
	level.ilana maps\_utility::set_ignoreall(1);
	if(!var_00 maps\_utility::ent_flag("fire_door_closed"))
	{
		var_00 thread escape_scene_close_firedoor(0.5,0.4,0);
		soundscripts\_snd::snd_message("big_fire_door_close",var_00);
		wait(0.4);
	}

	var_00.col disconnectpaths();
	level thread maps\betrayal_fx::escape_fire_door_slam_shut();
}

//Function Number: 87
escape_scene_hallway_climb()
{
	common_scripts\utility::flag_set("flag_dialogue_escape_deadend");
	common_scripts\utility::flag_wait("flag_escape_open_elevator");
	var_00 = maps\betrayal_util::get_ent_by_targetname("elevator_shaft_blocker");
	var_00 notsolid();
	wait(1);
	common_scripts\utility::flag_set("flag_objective_escape_scene_elevator_open");
	level thread escape_scene_open_elevator_doors();
	var_01 = maps\betrayal_util::get_ent_by_targetname("escape_elevator_block_collision");
	var_01 notsolid();
	wait(2);
	common_scripts\utility::flag_set("flag_dialogue_escape_climb");
	maps\_utility::activate_trigger_with_targetname("trigger_escape_move_into_elevator_shaft");
	maps\betrayal_util::wait_for_trigger_and_ai_single("trigger_escape_in_elevator_shaft",level.ilana);
	var_01 solid();
	maps\_utility::autosave_by_name();
	level thread escape_scene_close_elevator_doors();
	level notify("trigger_escape_in_elevator_shaft");
	var_02 = getentarray("spawner_guard_escape_hallway_flood","targetname");
	foreach(var_04 in var_02)
	{
		var_04.count = 0;
		var_04 delete();
	}

	level thread escape_scene_swarm_warning();
	level thread roof_scene_industrial_drone_swarm_launch_manager(1);
	maps\_utility::trigger_wait_targetname("trigger_escape_climb_top_out");
	var_06 = maps\betrayal_util::get_ent_by_targetname("animorg_elevator_topout");
	maps\_player_exo::player_exo_deactivate();
	maps\_exo_climb::force_animated_dismount(var_06,"player_rig","elevator_climb_dismount");
	level.player waittill("stop_player_climbing");
	level thread roof_scene_scripted_elevator_shaft_close();
	common_scripts\utility::flag_set("flag_objective_escape_scene_on_roof");
	maps\_player_exo::player_exo_activate();
}

//Function Number: 88
escape_scene_swarm_warning()
{
	maps\betrayal_util::waittill_player_exo_climbing();
	wait(1);
	common_scripts\utility::flag_set("flag_dialogue_escape_swarm");
}

//Function Number: 89
escape_scene_open_elevator_doors()
{
	var_00 = maps\betrayal_util::get_ents_by_targetname("escape_scene_elevator_door");
	soundscripts\_snd::snd_message("open_elevator_doors",var_00);
	foreach(var_02 in var_00)
	{
		var_02.org_pos = var_02.origin;
	}

	var_04 = 1;
	for(;;)
	{
		var_05 = 0;
		foreach(var_02 in var_00)
		{
			if(var_02.script_index == var_04)
			{
				var_05 = 1;
				var_02 thread escape_scene_open_elveator_door();
				wait(0.1);
			}
		}

		if(!var_05)
		{
			break;
		}

		wait(0.4);
		var_04++;
	}
}

//Function Number: 90
escape_scene_open_elveator_door()
{
	self.col connectpaths();
	self.col linkto(self);
	self moveto(self.open_org,3,1,1);
	wait(3);
	self.col notsolid();
}

//Function Number: 91
escape_scene_close_elevator_doors()
{
	var_00 = maps\betrayal_util::get_ents_by_targetname("escape_scene_elevator_door");
	soundscripts\_snd::snd_message("close_elevator_doors",var_00);
	var_01 = 1;
	for(;;)
	{
		var_02 = 0;
		foreach(var_04 in var_00)
		{
			if(var_04.script_index == var_01)
			{
				var_02 = 1;
				var_04 thread escape_scene_close_elveator_door();
				wait(0.1);
			}
		}

		if(!var_02)
		{
			break;
		}

		wait(0.4);
		var_01++;
	}
}

//Function Number: 92
escape_scene_close_elveator_door()
{
	self.col solid();
	self.col linkto(self);
	self moveto(self.org_pos,3,1,1);
	self.col disconnectpaths();
}

//Function Number: 93
escape_scene_remove_guards_on_complete()
{
	maps\_utility::trigger_wait_targetname("trigger_escape_climb_top_out");
	wait(2);
	if(isdefined(self))
	{
		self delete();
	}
}

//Function Number: 94
roof_scene_master_handler()
{
	roof_scene_set_up();
	roof_scene_industrial_section();
	roof_scene_grass_section();
	roof_scene_enter_water_cleanup();
	level thread swim_scene_master_handler();
}

//Function Number: 95
roof_scene_set_up()
{
	common_scripts\utility::flag_set("flag_roof_player_on_roof");
	var_00 = maps\betrayal_util::get_ent_by_targetname("roof_slide_blocker");
	var_00 delete();
	var_01 = maps\betrayal_util::get_ent_by_targetname("roof_scene_elevator_hatch");
	if(var_01.model != "btr_elevator_vent_cover_a_closed")
	{
		level thread roof_scene_scripted_elevator_shaft_close();
	}

	maps\betrayal_util::prepare_blast_doors("roof_window_blastdoor",-160);
	maps\betrayal_util::prepare_blast_doors("roof_slide_blastdoor",-160);
	maps\betrayal_util::prepare_blast_doors("roof_slide_blastdoor_mrX",-160);
	level thread roof_scene_grass_close_window_blast_doors();
	if(!isdefined(level.escape_pa))
	{
		level.escape_pa = maps\betrayal_util::get_ent_by_targetname("roof_escape_PA");
		level.escape_pa.animname = "PA";
	}

	thread roof_scene_vignette_civilians();
	thread roof_scene_vignettes();
	common_scripts\utility::run_thread_on_targetname("roof_fan_blade",::maps\betrayal_util::scripted_spin_fan_blades,1,"roof_scene_cleanup");
	thread roof_scene_setup_failstates();
	common_scripts\utility::flag_set("flag_dialogue_start_roof");
	common_scripts\utility::flag_set("flag_enable_battle_chatter");
}

//Function Number: 96
roof_scene_setup_failstates()
{
	thread roof_scene_industrial_section_failstates();
	thread roof_scene_grass_section_failstates();
}

//Function Number: 97
roof_scene_industrial_section()
{
	level.ilana.colornode_setgoal_func = ::roof_scene_scripted_ilona_fire_at_swarm;
	setsaveddvar("glass_damageToWeaken",32000);
	setsaveddvar("glass_damageToDestroy",64000);
}

//Function Number: 98
roof_scene_industrial_drone_swarm_launch_manager(param_00)
{
	level roof_scene_industrial_set_up_swarm();
	if(isdefined(param_00) && param_00 == 1)
	{
		maps\_utility::trigger_wait_targetname("trigger_escape_climb_top_out");
		wait(2.75);
	}

	level thread roof_scene_industrial_launch_drone_swarm();
}

//Function Number: 99
roof_scene_industrial_set_up_swarm()
{
	if(level.currentgen)
	{
		level.snake_cloud = vehicle_scripts\_attack_drone_common::spawn_snake_cloud("drone_swarm_spawner_roof","drone_swarm_roof_path_1",6,5);
	}
	else
	{
		level.snake_cloud = vehicle_scripts\_attack_drone_common::spawn_snake_cloud("drone_swarm_spawner_roof","drone_swarm_roof_path_1");
	}

	common_scripts\utility::flag_set("flag_roof_swarm_spawned");
	common_scripts\utility::flag_set("roof_start_lighting");
	common_scripts\utility::run_thread_on_targetname("trigger_roof_drone_swarm_move",::maps\betrayal_util::drone_swarm_move_change_path_on_trigger,1);
	var_00 = maps\betrayal_util::get_ent_by_targetname("roof_drone_spawner_kamikaze");
	var_01 = maps\betrayal_util::get_ents_by_targetname("roof_drone_attack_point");
	thread maps\betrayal_util::drone_swarm_start_kamikaze_attack(var_00,"flag_roof_player_past_fence","flag_roof_player_jumped_off_atlas_building",var_01,2,4,3,175);
}

//Function Number: 100
roof_scene_industrial_open_hatch()
{
	common_scripts\utility::flag_set("flag_roof_swarm_launched");
	self rotatepitch(95,2.5,0.25,0.5);
}

//Function Number: 101
roof_scene_industrial_launch_drone_swarm()
{
	common_scripts\utility::flag_wait("flag_roof_swarm_spawned");
	var_00 = maps\betrayal_util::get_ents_by_targetname("roof_drone_hatch");
	foreach(var_02 in var_00)
	{
		var_02 maps\_utility::delaythread(randomfloatrange(0,1),::roof_scene_industrial_open_hatch);
	}

	wait(1);
	level.snake_cloud thread vehicle_scripts\_attack_drone_common::snake_cloud_goto_points("drone_swarm_roof_path_2",undefined,3);
	thread maps\betrayal_fx::escape_drone_door_open();
	wait(1);
	common_scripts\utility::flag_set("flag_dialogue_roof_swarm");
}

//Function Number: 102
roof_scene_industrial_section_failstates()
{
	wait(90);
	if(!common_scripts\utility::flag("flag_roof_player_has_mantled"))
	{
		maps\betrayal_util::drone_swarm_kamikaze_set_attack_vars(1,2,4,50);
		thread roof_scene_industrial_death_squad_handler();
		if(maps\betrayal_util::player_mission_failed_handler(20,undefined,"flag_roof_player_has_mantled"))
		{
			maps\betrayal_util::drone_swarm_kamikaze_set_attack_vars(2,4,3,175);
		}
	}
}

//Function Number: 103
roof_scene_industrial_death_squad_handler()
{
	var_00 = [];
	if(!common_scripts\utility::flag("flag_roof_player_has_mantled"))
	{
		var_01 = getentarray("rooftop_death_squad01","targetname");
		foreach(var_03 in var_01)
		{
			var_04 = var_03 maps\_utility::spawn_ai(1,0);
			if(isdefined(var_04))
			{
				var_04.health = 1000;
				var_04.baseaccuracy = 10;
				var_04.canjumppath = 1;
				var_04 maps\_utility::player_seek_enable();
				var_00 = common_scripts\utility::array_add(var_00,var_04);
			}
		}
	}

	common_scripts\utility::flag_wait("flag_roof_player_has_mantled");
	foreach(var_04 in var_00)
	{
		if(isdefined(var_04))
		{
			var_04.health = 150;
			var_04.baseaccuracy = 0.5;
			var_04.canjumppath = 1;
			var_04 maps\_utility::player_seek_disable();
		}
	}

	common_scripts\utility::flag_wait("roof_scene_player_escaped");
	foreach(var_04 in var_00)
	{
		if(isdefined(var_04))
		{
			var_04 maps\betrayal_util::delete_ai();
		}
	}
}

//Function Number: 104
roof_scene_grass_section()
{
	common_scripts\utility::run_thread_on_targetname("trigger_roof_deploy_guards",::roof_scene_grass_deploy_guards);
	common_scripts\utility::run_thread_on_targetname("trigger_roof_start_slide",::roof_scene_slide);
	maps\_utility::trigger_wait_targetname("player_on_grass_section");
	common_scripts\utility::flag_set("flag_roof_player_has_mantled");
	level waittill("player_out_of_atlas");
}

//Function Number: 105
roof_scene_grass_deploy_guards()
{
	self waittill("trigger");
	level.roof_scene_guards = [];
	common_scripts\utility::flag_set("flag_dialogue_roof_gates");
	level thread roof_scene_grass_handle_guard_doors("office_roof_door","spawner_roof_office_hallway","trigger_roof_office_roof_stairs_empty");
	level thread roof_scene_grass_handle_guard_doors("office_hallway_door","spawner_roof_office_roof_stairs","trigger_roof_office_hallway_empty");
	wait(2);
	thread roof_scene_grass_monitor_guard_clear();
}

//Function Number: 106
roof_scene_grass_handle_guard_doors(param_00,param_01,param_02)
{
	level thread maps\betrayal_util::open_double_sliding_doors_toggle(param_00,0.5);
	var_03 = maps\betrayal_util::spawn_ai_from_targetname(param_01,1,0);
	level.roof_scene_guards = common_scripts\utility::array_add(level.roof_scene_guards,var_03[0]);
	maps\betrayal_util::wait_for_no_trigger_just_ai_group(param_02,var_03);
	level thread maps\betrayal_util::open_double_sliding_doors_toggle(param_00,0.5);
	var_03[0] thread roof_scene_grass_guard_cleanup();
}

//Function Number: 107
roof_scene_grass_guard_cleanup()
{
	common_scripts\utility::flag_wait("rooftop_escape_player_sliding_on_roof");
	if(isdefined(self))
	{
		maps\betrayal_util::delete_ai();
	}
}

//Function Number: 108
roof_scene_grass_monitor_guard_clear()
{
	while(level.roof_scene_guards.size > 0)
	{
		wait(0.5);
	}

	var_00 = maps\betrayal_util::get_ent_by_targetname("ilana_move_to_slide");
	if(isdefined(var_00))
	{
		maps\_utility::activate_trigger_with_targetname("ilana_move_to_slide");
	}
}

//Function Number: 109
roof_scene_grass_close_window_blast_doors()
{
	maps\_utility::trigger_wait_targetname("trigger_roof_start_window_blastdoors");
	level thread maps\betrayal_util::raise_blast_doors("roof_window_blastdoor",0.5);
	level thread maps\betrayal_util::raise_blast_doors("roof_slide_blastdoor",0.5);
	thread roof_scene_grass_setup_blast_door_clip();
	level thread maps\betrayal_util::raise_blast_doors("roof_slide_blastdoor_mrX",1,"flag_roof_open_mrX_blast_doors");
}

//Function Number: 110
roof_scene_grass_setup_blast_door_clip()
{
	var_00 = maps\betrayal_util::get_ents_by_targetname("rooftop_blast_door_clip");
	foreach(var_02 in var_00)
	{
		var_02.down_pos = var_02.origin - (0,0,192);
		var_02 moveto(var_02.down_pos,0.1);
	}
}

//Function Number: 111
roof_scene_grass_section_failstates()
{
	common_scripts\utility::flag_wait("roof_scene_ilana_at_escape");
	wait(50);
	if(!common_scripts\utility::flag("roof_scene_player_escaped"))
	{
		maps\betrayal_util::drone_swarm_kamikaze_set_attack_vars(1,2,4,50);
		thread roof_scene_grass_death_squad_handler();
		if(maps\betrayal_util::player_mission_failed_handler(20,undefined,"roof_scene_player_escaped"))
		{
			maps\betrayal_util::drone_swarm_kamikaze_set_attack_vars(2,4,3,175);
		}
	}
}

//Function Number: 112
roof_scene_grass_death_squad_handler()
{
	var_00 = [];
	if(!common_scripts\utility::flag("roof_scene_player_escaped"))
	{
		var_01 = getentarray("roof_scene_death_squad_spawner","targetname");
		foreach(var_03 in var_01)
		{
			for(;;)
			{
				var_04 = var_03 maps\_utility::spawn_ai();
				if(!maps\_utility::spawn_failed(var_04))
				{
					break;
				}

				wait(0.05);
			}

			var_04.health = 1000;
			var_04.baseaccuracy = 10;
			var_04.canjumppath = 1;
			var_00 = common_scripts\utility::array_add(var_00,var_04);
		}
	}

	common_scripts\utility::flag_wait("roof_scene_player_escaped");
	foreach(var_04 in var_00)
	{
		if(isdefined(var_04))
		{
			var_04 maps\betrayal_util::delete_ai();
		}
	}
}

//Function Number: 113
roof_scene_slide()
{
	self usetriggerrequirelookat();
	maps\_utility::addhinttrigger(&"BETRAYAL_HINT_SLIDE_MANTLE",&"BETRAYAL_HINT_SLIDE_MANTLE");
	level.player notifyonplayercommand("fake_mantle_jump","+gostand");
	common_scripts\utility::run_thread_on_targetname("trigger_roof_start_slide_player_present",::roof_scene_slide_wait_for_player_jumped);
	level waittill("flag_roof_player_jumped_off_atlas_building");
	level.player notifyonplayercommandremove("fake_mantle_jump","+gostand");
	self delete();
	level.ilana roof_scene_scripted_ilona_fire_at_swarm_behavior_clear();
	thread swim_scene_pre_setup();
	common_scripts\utility::flag_set("roof_scene_player_escaped");
	maps\_utility::autosave_by_name();
	common_scripts\utility::flag_set("flag_objective_escape_scene_complete");
	level.rig = maps\_utility::spawn_anim_model("player_rig",level.player.origin,level.player.angles);
	level.rig hide();
	level.player maps\_shg_utility::setup_player_for_scene();
	level.player enableslowaim();
	var_00 = 0.5;
	level.player playerlinktoblend(level.rig,"tag_player",var_00);
	level.rig common_scripts\utility::delaycall(var_00,::show);
	level.player common_scripts\utility::delaycall(var_00,::playerlinktodelta,level.rig,"tag_player",1,0,0,0,0,1);
	level.player common_scripts\utility::delaycall(var_00 + 0.05,::lerpviewangleclamp,1,0,0,15,15,12,8);
	var_01 = maps\betrayal_util::get_ent_by_targetname("animorg_roof_slide");
	var_02 = [];
	var_02[0] = level.rig;
	var_03 = maps\betrayal_util::spawn_ai_from_targetname("spawner_roof_slide_guard",1,0);
	for(var_04 = 0;var_04 < var_03.size;var_04++)
	{
		var_03[var_04].animname = "roof_guard_" + var_04 + 1;
		var_03[var_04].baseaccuracy = var_03[var_04].baseaccuracy / 2;
		if(var_04 == 0)
		{
			level.falling_guard = var_03[var_04];
		}

		var_02[var_02.size] = var_03[var_04];
	}

	thread swim_scene_swarm_setup();
	var_05 = maps\_utility::getanim_from_animname("roof_slide","player_rig");
	var_06 = getanimlength(var_05);
	var_07 = 1;
	var_01 thread roof_scene_slide_ilana_anim_to_swim();
	soundscripts\_snd::snd_music_message("roof_slide");
	soundscripts\_snd::snd_message("bet_escape_roof_slide");
	var_01 maps\_anim::anim_single(var_02,"roof_slide");
	level.player unlink();
	level.player disableslowaim();
	level.player maps\_shg_utility::setup_player_for_gameplay();
	level.rig delete();
	maps\_utility::autosave_by_name();
	wait(0.05);
	level notify("player_out_of_atlas");
}

//Function Number: 114
roof_scene_slide_wait_for_player_jumped()
{
	for(;;)
	{
		level.player waittill("fake_mantle_jump");
		if(self istouching(level.player))
		{
			break;
		}

		wait(0.05);
	}

	common_scripts\utility::flag_set("flag_roof_player_jumped_off_atlas_building");
	self delete();
}

//Function Number: 115
roof_scene_hide_rig(param_00)
{
	param_00 hide();
}

//Function Number: 116
roof_scene_slide_ilana_anim_to_swim()
{
	level.ilana.is_swimming = 1;
	maps\_anim::anim_single_solo(level.ilana,"roof_slide");
	level.ilana.swim_path_targetname = "ilana_swim_path";
	level.ilana animcustom(::swim_scene_ilana_swim_on_path_behavior);
}

//Function Number: 117
roof_scene_slide_slomo_start(param_00)
{
	setslowmotion(1,0.15,0.1);
	soundscripts\_snd::snd_message("bet_escape_roof_slomo_start");
}

//Function Number: 118
roof_scene_slide_slomo_stop(param_00)
{
	setslowmotion(0.15,1,0.2);
	soundscripts\_snd::snd_message("bet_escape_roof_slomo_end");
	wait(0.5);
	common_scripts\utility::flag_set("flag_dialogue_roof_fall");
}

//Function Number: 119
roof_scene_slide_remove_glass_blocker(param_00)
{
	var_01 = maps\betrayal_util::get_ents_by_targetname("atlas_roof_glass_blocker");
	foreach(var_03 in var_01)
	{
		var_03 delete();
	}

	setsaveddvar("glass_damageToWeaken",75);
	setsaveddvar("glass_damageToDestroy",275);
}

//Function Number: 120
roof_scene_slide_raise_gates(param_00)
{
	common_scripts\utility::flag_set("flag_roof_close_mrX_blast_doors");
}

//Function Number: 121
roof_scene_vignettes()
{
	if(level.nextgen)
	{
		thread maps\betrayal_util::spawn_and_handle_looping_helicopters("office_scene_looping_heli","flag_roof_player_jumped_off_atlas_building",5);
	}
	else
	{
		thread maps\betrayal_util::spawn_and_handle_looping_helicopters("office_scene_looping_heli","flag_roof_player_jumped_off_atlas_building",2);
	}

	common_scripts\utility::run_thread_on_targetname("roof_scene_vig_civ_spawn_trig",::maps\betrayal_util::civilian_setup,"roof_scene_vig_civ_scatter",0);
}

//Function Number: 122
roof_scene_vignette_civilians()
{
	common_scripts\utility::run_thread_on_targetname("rooftop_scene_civilian_spawn_trig",::maps\betrayal_util::civilian_setup,"roof_scene_civilian_react_trig",0);
	soundscripts\_snd::snd_message("atlas_building_roof_walla","roof_scene_civilian_react_trig");
}

//Function Number: 123
roof_scene_scripted_ilona_fire_at_swarm(param_00)
{
	self clearentitytarget();
	maps\_utility::set_ignoreall(0);
	self notify("stop_firing_at_swarm");
	self endon("stop_firing_at_swarm");
	self setgoalnode(param_00);
	thread maps\_colors::color_node_arrival_notifies(param_00);
	self waittill("goal");
	while(!isdefined(level.snake_cloud) || !isdefined(level.snake_cloud.snakes))
	{
		wait(0.5);
	}

	var_01 = randomintrange(0,level.snake_cloud.snakes.size);
	if(isdefined(level.roof_scene_guards))
	{
		while(level.roof_scene_guards.size > 0)
		{
			level.roof_scene_guards = maps\_utility::remove_dead_from_array(level.roof_scene_guards);
			wait(1);
		}
	}

	self setentitytarget(level.snake_cloud.snakes[0]);
	maps\_utility::set_ignoreall(0);
}

//Function Number: 124
roof_scene_scripted_ilona_fire_at_swarm_behavior_clear()
{
	self notify("stop_firing_at_swarm");
	self clearentitytarget();
	self.colornode_setgoal_func = undefined;
}

//Function Number: 125
roof_scene_scripted_elevator_shaft_close()
{
	wait(0.05);
	var_00 = maps\betrayal_util::get_ent_by_targetname("roof_scene_elevator_hatch");
	var_00 setmodel("btr_elevator_vent_cover_a_closed");
	var_01 = maps\betrayal_util::get_ent_by_targetname("elevator_shaft_open_clip");
	if(isdefined(var_01))
	{
		var_01 connectpaths();
		var_01 delete();
	}

	var_02 = maps\betrayal_util::get_ent_by_targetname("elevator_shaft_blocker");
	var_02 solid();
	maps\betrayal_util::waittill_player_not_exo_climbing();
	var_03 = maps\betrayal_util::get_ent_by_targetname("start_roof_ilana");
	while(!maps\betrayal_util::can_teleport_ai_to_pos(level.ilana,var_03.origin))
	{
		wait(0.05);
	}

	var_04 = maps\betrayal_util::get_ent_by_targetname("roof_scene_ilona_start");
	if(isdefined(var_04))
	{
		maps\_utility::activate_trigger_with_targetname("roof_scene_ilona_start");
	}

	level.ilana forceteleport(var_03.origin,var_03.angles);
}

//Function Number: 126
roof_scene_enter_water_cleanup()
{
	maps\_utility::trigger_wait_targetname("trigger_roof_player_in_water");
	level notify("roof_scene_cleanup");
	maps\_utility::clear_all_color_orders("allies");
	maps\_utility::clear_all_color_orders("axis");
	maps\betrayal_util::clean_up_ai_single(level.ilana);
	level.ilana maps\betrayal_util::move_squad_member_to_ent_by_targetname("start_swim_ilana");
	common_scripts\utility::flag_set("flag_roof_escape_complete");
	if(level.nextgen)
	{
		setsaveddvar("r_mbEnable","0");
		setsaveddvar("r_dof_physical_bokehEnable",0);
	}

	level.ilana.ignoreall = 1;
}

//Function Number: 127
swim_scene_master_handler()
{
	swim_scene_pre_setup();
	swim_scene_setup();
	swim_scene_boats();
	swim_scene_climb_out_water();
	swim_scene_cleanup();
	level thread sewer_scene_master_handler();
}

//Function Number: 128
swim_scene_pre_setup()
{
	maps\_player_exo::player_exo_deactivate();
	if(!isdefined(level.dock_debris) && !isdefined(level.dock_debris_blocker))
	{
		swim_scene_scripted_destroyed_dock_hide();
	}

	if(!isdefined(level.swim_warbird))
	{
		common_scripts\utility::run_thread_on_targetname("trigger_start_swim_littlebird_patrol",::swim_scene_chase_littlebird_patrol,2);
	}
}

//Function Number: 129
swim_scene_setup()
{
	level.player disableweapons();
	level.player.drowning_damage = level.player.maxhealth * 0.1 / level.player.damagemultiplier;
	maps\_underwater::override_breath_values(24,1);
	thread swim_scene_handle_player_containment();
	thread swim_scene_dock_destroy();
	thread swim_scene_dock_guards();
	if(!isdefined(level.snake_cloud))
	{
		if(level.currentgen)
		{
			level.snake_cloud = vehicle_scripts\_attack_drone_common::spawn_snake_cloud("swarm_spawner_swim","swarm_swim_path",6,5);
		}
		else
		{
			level.snake_cloud = vehicle_scripts\_attack_drone_common::spawn_snake_cloud("swarm_spawner_swim","swarm_swim_path");
		}
	}

	if(common_scripts\utility::flag("swim_devstart"))
	{
		thread swim_scene_swarm_setup();
	}

	if(!isdefined(level.ilana.is_swimming))
	{
		level.ilana clearanim(%body,0);
		level.ilana.swim_path_targetname = "ilana_swim_path";
		level.ilana animcustom(::swim_scene_ilana_swim_on_path_behavior);
	}

	common_scripts\_exploder::exploder(3002);
	common_scripts\utility::flag_set("flag_dialogue_start_swim");
	common_scripts\utility::flag_clear("flag_enable_battle_chatter");
}

//Function Number: 130
swim_scene_boats()
{
	common_scripts\utility::run_thread_on_targetname("trigger_swimg_sink_boat1",::swim_scene_boat_sink);
	common_scripts\utility::run_thread_on_targetname("trigger_swimg_sink_boat2",::swim_scene_boat_sink);
}

//Function Number: 131
swim_scene_ilana_swim_on_path_behavior()
{
	self endon("killanimscript");
	if(!isdefined(self.swim_path_targetname))
	{
		return;
	}

	var_00 = common_scripts\utility::getstruct(self.swim_path_targetname,"targetname");
	if(!isdefined(var_00))
	{
		return;
	}

	maps\_utility::disable_pain();
	var_01 = var_00.origin;
	self animmode("nogravity");
	var_02 = vectortoangles(var_01 - self.origin);
	self setanimknobrestart(%bet_swimming_forward_idle_ilona,1,0.2,1.2);
	for(;;)
	{
		if(distancesquared(self.origin,var_01) < 3600)
		{
			if(isdefined(var_00.target))
			{
				var_00 = common_scripts\utility::getstruct(var_00.target,"targetname");
				var_01 = var_00.origin;
			}
			else
			{
				break;
			}
		}

		var_03 = vectortoangles(var_01 - self.origin);
		var_04 = clamp(angleclamp180(var_03[0] - var_02[0]),-1.5,1.5);
		var_05 = clamp(angleclamp180(var_03[1] - var_02[1]),-1.5,1.5);
		var_02 = (var_02[0] + var_04,var_02[1] + var_05,var_03[2]);
		self orientmode("face angle 3d",var_02,1);
		wait(0.05);
	}

	var_06 = maps\betrayal_util::get_ent_by_targetname("sewer_get_out_ilana");
	while(!maps\betrayal_util::can_teleport_ai_to_pos(level.ilana,var_06.origin))
	{
		wait(0.05);
	}

	var_07 = getent("sewer_get_out_ilana","targetname");
	soundscripts\_snd::snd_message("bet_ilona_swim_end",level.ilana);
	self forceteleport(var_07.origin,var_07.angles);
	var_08 = getnode("ilona_exit_swim_cover","targetname");
	maps\_utility::set_goal_node(var_08);
	self animmode("gravity");
	self orientmode("face default");
	maps\_utility::enable_pain();
}

//Function Number: 132
swim_scene_chase_littlebird_patrol(param_00)
{
	self waittill("trigger");
	if(!isdefined(level.swim_warbird))
	{
		level.swim_warbird = maps\_vehicle::spawn_vehicle_from_targetname_and_drive("swim_ambush_helo");
		level.swim_warbird soundscripts\_snd::snd_message("aud_ambient_helicopter","swim_ambush_helo");
		level.swim_warbird thread maps\betrayal_util::warbird_shooting_think(1,1,param_00);
		var_01 = maps\betrayal_util::get_ent_by_targetname("swim_warbird_target01");
		wait(3);
		level.swim_warbird thread swim_scene_warbird_fire_at_target_for_duration(var_01,4);
		wait(4);
		var_01 delete();
		return;
	}

	self.turret_target_override = level.player;
	maps\_utility::ent_flag_clear("fire_turrets");
}

//Function Number: 133
swim_scene_warbird_fire_at_target_for_duration(param_00,param_01)
{
	if(isdefined(param_00))
	{
		param_00 makeentitysentient("allies");
		if(isdefined(param_00))
		{
			self.turret_target_override = param_00;
		}

		self.sight_check = 0;
		wait(param_01);
	}

	self.turret_target_override = level.player;
	self.sight_check = 1;
}

//Function Number: 134
swim_scene_swarm_setup()
{
	if(!common_scripts\utility::flag("swim_devstart"))
	{
		wait(4.25);
	}

	thread swim_scene_swarm_kamikaze_attack();
	thread swim_scene_swarm_movement();
	wait(0.2);
	level notify("start_swim_kamikaze");
	common_scripts\utility::flag_wait("flag_swim_tunnel");
	level notify("stop_swim_dist_monitor");
	level.snake_cloud vehicle_scripts\_attack_drone_common::snake_cloud_goto_points("swarm_swim_path4",undefined,4);
}

//Function Number: 135
swim_scene_swarm_movement()
{
	level endon("stop_swim_dist_monitor");
	var_00 = maps\betrayal_util::get_ent_by_targetname("swim_tunnel_hole_opening");
	var_01 = 950;
	var_02 = 400;
	var_03 = 0;
	for(;;)
	{
		var_04 = distance2d(level.player.origin,var_00.origin);
		if(var_04 < var_02 && var_04 > var_03)
		{
			level.snake_cloud vehicle_scripts\_attack_drone_common::snake_cloud_goto_points("swarm_swim_path3",undefined,4);
		}

		if(var_04 < var_01 && var_04 > var_02)
		{
			level.snake_cloud vehicle_scripts\_attack_drone_common::snake_cloud_goto_points("swarm_swim_path2",undefined,4);
		}

		if(var_04 >= var_01)
		{
			level.snake_cloud vehicle_scripts\_attack_drone_common::snake_cloud_goto_points("swarm_swim_path1",undefined,4);
		}

		wait 0.05;
	}
}

//Function Number: 136
swim_scene_swarm_kamikaze_attack()
{
}

//Function Number: 137
swim_scene_boat_sink()
{
	var_00 = maps\betrayal_util::get_ents_by_targetname(self.target);
	var_01 = undefined;
	var_02 = undefined;
	foreach(var_04 in var_00)
	{
		if(var_04.classname == "script_model")
		{
			var_01 = var_04;
		}

		if(var_04.classname == "script_brushmodel")
		{
			var_02 = var_04;
		}
	}

	var_02 linkto(var_01);
	var_06 = var_01 common_scripts\utility::spawn_tag_origin();
	var_06.angles = vectortoangles(anglestoup(var_01.angles));
	var_06 linkto(var_01);
	self waittill("trigger");
	level.swim_warbird thread swim_scene_warbird_fire_at_target_for_duration(var_01,3);
	wait(4);
	level.player thread maps\betrayal_fx::canal_boat_explosion(var_06);
	soundscripts\_snd::snd_message("bet_swim_boat_explo",var_06);
	var_01 playrumbleonentity("grenade_rumble");
	var_07 = undefined;
	var_08 = 0;
	var_09 = 0;
	for(;;)
	{
		var_0A = physicstrace(var_01.origin,var_01.origin + (0,0,-1000));
		if(!isdefined(var_07))
		{
			var_07 = var_0A;
		}

		if(distance(var_0A,var_01.origin) < 150)
		{
			break;
		}

		if(var_01.origin[2] < var_07[2])
		{
			break;
		}

		var_0B = randomfloatrange(3,4);
		var_0C = randomfloatrange(-50,50);
		var_0D = randomfloatrange(-50,50);
		var_0E = randomfloatrange(-30,-20);
		var_08 = clamp(randomfloatrange(-5,5) + var_08,-20,20);
		var_09 = clamp(randomfloatrange(-5,5) + var_09,-20,20);
		var_01 moveto(var_01.origin + (var_0C,var_0D,var_0E),var_0B);
		var_01 rotateto((var_09,var_01.angles[1],var_08),var_0B);
		wait(var_0B);
	}

	var_01 thread swim_scene_boat_sink_bob();
	stopfxontag(level._effect["boat_explosion"],var_06,"tag_origin");
	stopfxontag(level._effect["boat_explosion_underwater"],var_06,"tag_origin");
	wait(4);
	var_06 unlink();
	var_06 delete();
}

//Function Number: 138
swim_scene_boat_sink_bob()
{
	var_00 = self.origin[0] - 15;
	var_01 = self.origin[0] + 15;
	var_02 = self.origin[1] - 15;
	var_03 = self.origin[1] + 15;
	var_04 = self.origin[2] - 15;
	var_05 = self.origin[2] + 15;
	var_06 = 0;
	var_07 = 0;
	while(!common_scripts\utility::flag("flag_swim_tunnel"))
	{
		var_08 = randomfloatrange(3,4);
		var_09 = clamp(self.origin[0] + randomfloatrange(-15,15),var_00,var_01);
		var_0A = clamp(self.origin[1] + randomfloatrange(-15,15),var_02,var_03);
		var_0B = clamp(self.origin[2] + randomfloatrange(-15,15),var_04,var_05);
		var_06 = clamp(randomfloatrange(-5,5) + var_06,-20,20);
		var_07 = clamp(randomfloatrange(-5,5) + var_07,-20,20);
		self moveto((var_09,var_0A,var_0B),var_08);
		self rotateto((var_07,self.angles[1],var_06),var_08);
		wait(var_08);
	}
}

//Function Number: 139
swim_scene_dock_destroy()
{
	common_scripts\utility::flag_wait("flag_swim_tunnel");
	level thread maps\betrayal_fx::canal_dock_destroy();
	wait(0.5);
	level.dock_debris show();
	level.dock_debris_blocker solid();
	soundscripts\_snd::snd_message("bet_swim_dock_debris_blocker");
	maps\_utility::autosave_by_name();
	if(isdefined(level.swim_warbird))
	{
		level.swim_warbird delete();
	}
}

//Function Number: 140
swim_scene_scripted_destroyed_dock_hide()
{
	level.dock_debris = maps\betrayal_util::get_ent_by_targetname("swim_scene_sunk_dock_debris");
	level.dock_debris_blocker = maps\betrayal_util::get_ent_by_targetname("swim_scene_debris_blocker");
	level.dock_debris_blocker notsolid();
	level.dock_debris hide();
}

//Function Number: 141
swim_scene_dock_guards()
{
	var_00 = getentarray("swim_dock_guards","targetname");
	foreach(var_02 in var_00)
	{
		var_03 = var_02 maps\_utility::spawn_ai(1);
		var_04 = getnode(var_02.target,"targetname");
		var_03 thread swim_scene_dock_guard_removal();
		var_03.canjumppath = 1;
		if(isdefined(var_03.script_noteworthy))
		{
			if(var_03.script_noteworthy == "dock_guard1")
			{
				var_03.animname = "atlas_guard_1";
				var_03 thread maps\betrayal_util::simple_anim_at_struct("dock_guard1_animorg");
				var_03 thread swim_scene_dock_guard_goal(var_04);
				var_03.baseaccuracy = 0.25;
				var_03.grenadeammo = 0;
				var_03 maps\_utility::set_favoriteenemy(level.player);
			}

			if(var_03.script_noteworthy == "dock_guard2")
			{
				var_03.animname = "atlas_guard_2";
				var_03 thread maps\betrayal_util::simple_anim_at_struct("dock_guard2_animorg");
				var_03 thread swim_scene_dock_guard_goal(var_04);
				var_03.baseaccuracy = 0.25;
				var_03.grenadeammo = 0;
				var_03 maps\_utility::set_favoriteenemy(level.player);
			}
		}
	}
}

//Function Number: 142
swim_scene_dock_guard_goal(param_00)
{
	if(isdefined(self))
	{
		self waittill("anim_finished");
		if(isdefined(self))
		{
			maps\_utility::set_goal_node(param_00);
		}
	}
}

//Function Number: 143
swim_scene_dock_guard_removal()
{
	common_scripts\utility::flag_wait("flag_sewer_exit_civ_setup");
	if(isdefined(self))
	{
		self delete();
	}
}

//Function Number: 144
swim_scene_climb_out_water()
{
	var_00 = getentarray("sewer_containment","targetname");
	foreach(var_02 in var_00)
	{
		var_02 notsolid();
	}

	common_scripts\utility::flag_wait("flag_swim_water_player_out_of_water");
	soundscripts\_snd::snd_music_message("sewer_out_of_water");
	foreach(var_02 in var_00)
	{
		var_02 solid();
	}

	wait(1);
	level.player enableweapons();
}

//Function Number: 145
swim_scene_handle_current()
{
	level endon("swim_scene_cleanup");
	common_scripts\utility::flag_set("flag_swim_water_motion_on");
	for(;;)
	{
		maps\_utility::trigger_wait_targetname("trigger_swim_no_current");
		common_scripts\utility::flag_clear("flag_swim_water_motion_on");
		maps\_utility::trigger_wait_targetname("trigger_swim_river_current");
		common_scripts\utility::flag_set("flag_swim_water_motion_on");
	}
}

//Function Number: 146
swim_scene_handle_player_containment()
{
	var_00 = getentarray("swim_barrier","targetname");
	var_01 = 0;
	var_02 = 6;
	var_03 = 0;
	for(;;)
	{
		wait(0.05);
		var_04 = 0;
		foreach(var_06 in var_00)
		{
			if(level.player istouching(var_06))
			{
				var_04 = 1;
				break;
			}
		}

		if(!var_04)
		{
			var_01 = 0;
			var_03 = 0;
			maps\_utility::hint_fade();
			continue;
		}

		var_01 = var_01 + 0.05;
		if(var_01 >= var_02)
		{
			setdvar("ui_deadquote",&"BETRAYAL_FAIL_ESCAPE");
			maps\_utility::missionfailedwrapper();
		}

		if(var_03 == 0)
		{
			maps\_utility::display_hint("leaving_mission_area");
			var_03 = 1;
		}
	}
}

//Function Number: 147
swim_scene_cleanup()
{
	level notify("swim_scene_cleanup");
	maps\_utility::clear_all_color_orders("axis");
	maps\_utility::clear_all_color_orders("allies");
}

//Function Number: 148
sewer_scene_master_handler()
{
	sewer_scene_setup();
	sewer_scene_manhole_interaction();
	sewer_scene_market_section();
	level thread oldtown_scene_master_handler();
	common_scripts\utility::flag_wait("flag_sewer_oldtown_intro_complete");
	sewer_scene_cleanup();
	common_scripts\utility::flag_set("flag_sewer_scene_transfer_to_free_run");
	wait(2);
	common_scripts\utility::flag_set("flag_sewer_checkpoint_guards_wakeup");
}

//Function Number: 149
sewer_scene_setup()
{
	level thread sewer_scene_dialogue_manager();
	level thread sewer_scene_ilona_movement_manager();
	level thread sewer_scene_swim_cleanup();
	level thread sewer_scene_setup_manholde_vignette_civs();
	level thread sewer_scene_scripted_objects();
	common_scripts\utility::flag_set("flag_dialogue_start_sewer");
	common_scripts\utility::flag_clear("flag_enable_battle_chatter");
	soundscripts\_snd::snd_message("market_walla_init");
}

//Function Number: 150
sewer_scene_swim_cleanup()
{
	level endon("sewer_scene_start_backtrack_fail");
	level waittill("flag_sewer_swap_to_oldtown_swarm");
	if(isdefined(level.snake_cloud))
	{
		level.snake_cloud vehicle_scripts\_attack_drone_common::cleanup_snake_cloud();
		level.snake_cloud = undefined;
	}

	if(isdefined(level.swim_warbird))
	{
		level.swim_warbird delete();
	}
}

//Function Number: 151
sewer_scene_cleanup()
{
	level notify("sewer_scene_cleanup");
}

//Function Number: 152
sewer_scene_dialogue_manager()
{
	level.player endon("death");
	level endon("flag_sewer_scene_transfer_to_free_run");
	level endon("flag_sewer_checkpoint_guards_wakeup");
	level endon("sewer_scene_cleanup");
	level.civilian1 = maps\betrayal_util::get_ent_by_targetname("civilian01_VO_PA");
	level.civilian1.animname = "civilian_1";
	level.civilian2 = maps\betrayal_util::get_ent_by_targetname("civilian02_VO_PA");
	level.civilian2.animname = "civilian_2";
	level.oldtown_pa = maps\betrayal_util::get_ent_by_targetname("oldtown_pa");
	level.oldtown_pa.animname = "PA_2";
	level.atlas_guard = maps\betrayal_util::get_ent_by_targetname("guard_market_VO_PA");
	level.atlas_guard.animname = "atlas_guard_1";
	common_scripts\utility::flag_wait("flag_sewer_oppression_event_start");
	wait(0.2);
	level.civilian1 = maps\betrayal_util::get_ent_by_targetname("civilian01_market_VO_PA");
	level.civilian1.animname = "civilian_1";
	level.civilian2 = maps\betrayal_util::get_ent_by_targetname("civilian02_market_VO_PA");
	level.civilian2.animname = "civilian_2";
	common_scripts\utility::flag_set("flag_dialogue_sewer_checkpoint");
}

//Function Number: 153
sewer_scene_ilona_movement_manager()
{
	level.ilana pushplayer(1);
	common_scripts\utility::flag_wait("flag_sewer_oppression_event_ilona_start_secret");
	level.ilana allowedstances("crouch","prone");
	common_scripts\utility::flag_wait("flag_sewer_oppression_event_ilona_building_start");
	level.ilana allowedstances("stand","crouch","prone");
}

//Function Number: 154
sewer_scene_manhole_interaction()
{
	if(!isdefined(level.snake_cloud))
	{
		level thread sewer_scene_manhole_spawn_swim_swarm();
	}

	var_00 = maps\betrayal_util::get_ent_by_targetname("animorg_sewer_ladder_climb");
	var_01 = maps\betrayal_util::get_ent_by_targetname("oldtown_sewer_lid");
	var_02 = maps\betrayal_util::get_ent_by_targetname("oldtown_sewer_lid_outside");
	var_02 hide();
	var_01.animname = "sewer_lid";
	var_01 maps\_utility::assign_animtree();
	var_00 maps\_anim::anim_first_frame_solo(var_01,"sewer_grate_open");
	var_03 = maps\betrayal_util::get_ent_by_targetname("trigger_swim_get_out_sewer");
	var_04 = var_03 maps\_shg_utility::hint_button_trigger("use",200);
	var_03 maps\_utility::addhinttrigger(&"BETRAYAL_OPEN_MANHOLE",&"BETRAYAL_OPEN_MANHOLE_PC");
	var_03 waittill("trigger");
	maps\_player_exo::player_exo_deactivate();
	var_04 maps\_shg_utility::hint_button_clear();
	var_03 delete();
	common_scripts\utility::flag_set("flag_objective_swim_scene_complete");
	common_scripts\utility::flag_set("oldtown_start_lighting");
	level.swim_warbird = maps\_vehicle::spawn_vehicle_from_targetname_and_drive("sewer_exit_warbird_outro");
	level.swim_warbird soundscripts\_snd::snd_message("aud_ambient_helicopter","sewer_exit_warbird_outro");
	if(level.currentgen)
	{
		maps\_utility::tff_sync();
	}

	level maps\betrayal_util::animate_player_on_rig_simple("player_hands","sewer_grate_open","animorg_sewer_ladder_climb",0.5,[var_01]);
	var_01 hide();
	var_02 show();
	common_scripts\utility::flag_set("flag_dialogue_sewer_guards");
	common_scripts\utility::flag_set("flag_objective_freerun_scene_start");
	maps\_player_exo::player_exo_activate();
	level thread sewer_scene_manhole_backtrack_failure();
	common_scripts\utility::flag_wait("flag_sewer_backtrack_ender");
}

//Function Number: 155
sewer_scene_teleport_ilona_to_sewer_exit(param_00)
{
	level.ilana pushplayer(0);
	level.ilana maps\betrayal_util::start_squad_member_at_start("exit_sewer_ilana");
}

//Function Number: 156
sewer_scene_manhole_spawn_swim_swarm()
{
	if(level.currentgen)
	{
		level.snake_cloud = vehicle_scripts\_attack_drone_common::spawn_snake_cloud("swarm_spawner_swim","swarm_swim_path4",6,5);
		return;
	}

	level.snake_cloud = vehicle_scripts\_attack_drone_common::spawn_snake_cloud("swarm_spawner_swim","swarm_swim_path4");
}

//Function Number: 157
sewer_scene_setup_manholde_vignette_civs()
{
	common_scripts\utility::flag_set("flag_sewer_exit_civ_setup");
	common_scripts\utility::run_thread_on_targetname("sewer_exit_scene_civilian_setup_initial",::maps\betrayal_util::civilian_setup,"flag_sewer_exit_player_fired_weapon",0);
	thread sewer_exit_monitor_player_weapon_fire();
}

//Function Number: 158
sewer_exit_monitor_player_weapon_fire()
{
	level endon("flag_sewer_oppression_event_start");
	level.player common_scripts\utility::waittill_any("begin_firing","grenade_fire");
	common_scripts\utility::flag_set("flag_sewer_exit_player_fired_weapon");
}

//Function Number: 159
sewer_scene_manhole_backtrack_failure()
{
	level thread sewer_scene_backtrack_failure();
	common_scripts\utility::flag_wait("flag_sewer_backtrack_ender");
	level.snake_cloud vehicle_scripts\_attack_drone_common::snake_cloud_goto_points("swarm_swim_path5",undefined,4);
}

//Function Number: 160
sewer_scene_backtrack_failure()
{
	wait(40);
	if(!common_scripts\utility::flag("flag_sewer_backtrack_ender"))
	{
		level notify("sewer_scene_start_backtrack_fail");
		level thread sewer_scene_backtrack_fail_send_in_flyers();
		var_00 = maps\betrayal_util::get_ents_by_targetname("sewer_backtrack_guards");
		foreach(var_02 in var_00)
		{
			var_03 = var_02 maps\_utility::spawn_ai(1);
			wait 0.05;
			var_03 maps\_vehicle::godon();
			var_03.baseaccuracy = 5;
			var_03.goalradius = 32;
			if(isdefined(var_03.script_noteworthy))
			{
				switch(var_03.script_noteworthy)
				{
					case "sewer_guard1":
						var_03.animname = "atlas_guard_1";
						var_03 thread maps\_mech::mech_start_hunting();
						break;

					case "sewer_guard2":
						var_03.animname = "atlas_guard_2";
						level.atlas_guard2 = var_03;
						var_03 thread maps\_mech::mech_start_hunting();
						break;

					case "sewer_guard3":
						var_03.animname = "atlas_guard_3";
						level.atlas_guard3 = var_03;
						var_03.health = 300;
						break;

					case "sewer_guard4":
						var_03.animname = "atlas_guard_4";
						level.atlas_guard4 = var_03;
						var_03.health = 300;
						break;

					case "sewer_guard5":
						var_03.canjumppath = 1;
						level.atlas_guard5 = var_03;
						var_03.health = 300;
						break;
				}
			}
		}

		level.atlas_guard3 thread maps\betrayal_util::simple_anim_at_struct("sewer_guard3_animorg");
		level.atlas_guard4 thread maps\betrayal_util::simple_anim_at_struct("sewer_guard4_animorg");
		level.ilana.ignoreall = 0;
		level thread maps\betrayal_vo::play_dialogue_oldtown_player_spotted(level.atlas_guard5,level.atlas_guard2);
		level.player common_scripts\utility::waittill_any_timeout(10,"death");
		wait(0.5);
		setdvar("ui_deadquote",&"BETRAYAL_FAIL_ESCAPE");
		maps\_utility::missionfailedwrapper();
	}
}

//Function Number: 161
sewer_scene_backtrack_fail_send_in_flyers()
{
	level.snake_cloud vehicle_scripts\_attack_drone_common::snake_cloud_goto_points("swarm_playerfail1",undefined,4);
	var_00 = maps\_vehicle::spawn_vehicle_from_targetname_and_drive("sewer_exit_fail_warbird");
	var_00 soundscripts\_snd::snd_message("aud_ambient_helicopter","sewer_exit_fail_warbird");
	var_00 thread maps\_vehicle::godon();
	var_00 thread maps\betrayal_util::warbird_shooting_think(0,1);
	var_00.turret_target_override = level.player;
}

//Function Number: 162
sewer_scene_market_section()
{
	level waittill("oldtown_intro_civ_setup");
	thread sewer_scene_market_vig_civ_init();
	thread sewer_scene_drone_vehicle_setup();
	thread sewer_scene_market_bystander_oppression_setup();
	thread sewer_scene_spawn_guards_at_market_checkpoint(1);
	thread sewer_scene_market_atlas_oppression_setup();
	level thread sewer_scene_market_section_handle_ilona_move();
	level thread sewer_scene_guards_alerted_wake_up_scene();
	level thread sewer_scene_checkpoint_handle_guard_wakeup();
}

//Function Number: 163
sewer_scene_market_section_handle_ilona_move()
{
}

//Function Number: 164
sewer_scene_guards_alerted_wake_up_scene()
{
	common_scripts\utility::flag_wait("flag_sewer_checkpoint_guards_wakeup");
	var_00 = getaiarray("axis");
	var_00 = sortbydistance(var_00,level.player.origin);
	level thread maps\betrayal_vo::play_dialogue_oldtown_player_spotted(var_00[0],var_00[1]);
	level notify("market_walla_guards_wakeup");
	level.ilana.ignoreall = 0;
	if(isdefined(level.snake_cloud))
	{
		level.snake_cloud thread vehicle_scripts\_attack_drone_common::snake_cloud_goto_points("freerun_drone_path0",undefined,4);
	}

	thread maps\betrayal_util::clear_ignore_all_on_group(level.bystander_oppression_event_ents);
	common_scripts\utility::flag_set("flag_enable_battle_chatter");
}

//Function Number: 165
sewer_scene_market_vig_civ_init()
{
	common_scripts\utility::run_thread_on_targetname("sewer_exit_scene_civilian_setup",::maps\betrayal_util::civilian_setup,"flag_sewer_checkpoint_guards_wakeup",0);
}

//Function Number: 166
sewer_scene_drone_vehicle_setup()
{
	level thread sewer_scene_drone_oppresion_fly();
	level thread sewer_scene_drone_surprise_ilona();
}

//Function Number: 167
sewer_scene_drone_oppresion_fly()
{
	common_scripts\utility::flag_wait("flag_sewer_oppression_event_start");
	var_00 = maps\_vehicle::spawn_vehicle_from_targetname_and_drive("atlas_guard_oppression_event_drone_00");
	var_01 = maps\_vehicle::spawn_vehicle_from_targetname_and_drive("atlas_guard_oppression_event_drone_01");
}

//Function Number: 168
sewer_scene_drone_surprise_ilona()
{
	level endon("sewer_scene_cleanup");
	var_00 = maps\betrayal_util::get_ent_by_targetname("trigger_sewer_ilona_drone_scare");
	for(;;)
	{
		var_00 waittill("trigger",var_01);
		if(var_01 == level.player)
		{
			return;
		}

		if(var_01 == level.ilana)
		{
			var_02 = distance(level.ilana.origin,level.player.origin);
			if(var_02 > 150)
			{
				var_03 = maps\_vehicle::spawn_vehicle_from_targetname_and_drive("atlas_guard_oppression_event_drone_02");
				var_03.pacifist = 1;
				wait(0.75);
				level.ilana.animname = "ilana";
				var_04 = "ilona_react_to_drone";
				level.ilana maps\_anim::anim_single_solo_run(level.ilana,var_04);
			}

			return;
		}
	}
}

//Function Number: 169
sewer_scene_spawn_guards_at_market_checkpoint(param_00)
{
	level.guards_at_market_checkpoint_array = [];
	var_01 = getentarray("guard_at_market_checkpoint","script_noteworthy");
	foreach(var_03 in var_01)
	{
		var_04 = var_03 maps\_utility::spawn_ai(1,0);
		level.guards_at_market_checkpoint_array = common_scripts\utility::array_add(level.guards_at_market_checkpoint_array,var_04);
		if(isdefined(param_00))
		{
			var_04 maps\_utility::set_ignoreall(param_00);
		}
		else
		{
			var_04 maps\_utility::set_ignoreall(1);
		}

		var_04 thread maps\betrayal_util::delete_ai_on_flag("flag_sewer_finish_sewer_scene_cleanup");
		var_04 thread sewer_scene_checkpoint_guard_wakeup();
		var_04.animname = "generic";
		if(isdefined(var_04.animation))
		{
			var_05 = var_04.animation;
		}
		else
		{
			var_05 = "bet_ceremony_security_idle_guy01";
		}

		var_04 thread maps\_anim::anim_loop([var_04],var_05);
	}
}

//Function Number: 170
sewer_scene_market_bystander_oppression_setup()
{
	level endon("flag_sewer_checkpoint_guards_wakeup");
	level.bystander_oppression_event_ents = maps\betrayal_util::spawn_ai_from_targetname("bystander_oppression_event",1,0);
	foreach(var_01 in level.bystander_oppression_event_ents)
	{
		if(isdefined(var_01))
		{
			var_01.animname = "generic";
			var_02 = var_01 maps\betrayal_util::civilian_get_random_idle();
			var_01 thread maps\_anim::anim_loop_solo(var_01,var_02);
		}
	}

	common_scripts\utility::array_thread(level.bystander_oppression_event_ents,::sewer_scene_vignette_actor_flee);
	common_scripts\utility::flag_wait("oppression_ent_completed_beat_02");
	common_scripts\utility::array_thread(level.bystander_oppression_event_ents,::sewer_scene_vignette_bystander_react);
}

//Function Number: 171
sewer_scene_vignette_bystander_react()
{
	self endon("death");
	if(isdefined(self) && isdefined(self.script_noteworthy))
	{
		maps\betrayal_util::stop_current_animations();
		self.animname = "civilian_react";
		var_00 = self.script_noteworthy;
		maps\_anim::anim_single_solo(self,var_00);
		if(isdefined(self.script_parameters))
		{
			maps\betrayal_util::stop_current_animations();
			var_00 = self.script_parameters;
			thread maps\_anim::anim_loop([self],var_00);
			return;
		}

		maps\betrayal_util::stop_current_animations();
		var_00 = maps\betrayal_util::civilian_get_random_reaction();
		thread maps\_anim::anim_loop([self],var_00);
	}
}

//Function Number: 172
sewer_scene_vignette_actor_flee()
{
	common_scripts\utility::flag_wait("flag_sewer_checkpoint_guards_wakeup");
	if(isdefined(self) && isdefined(self.target))
	{
		maps\betrayal_util::stop_current_animations();
		var_00 = getnode(self.target,"targetname");
		self.goalradius = 16;
		maps\_utility::set_goal_node(var_00);
		self notify("move");
		thread maps\betrayal_util::delete_ai_on_goal();
	}
}

//Function Number: 173
sewer_scene_market_atlas_oppression_setup()
{
	level.guard_oppression_event_ents = [];
	maps\betrayal_util::add_spawn_function_to_noteworthy("atlas_guard_oppression_event_roof_guy",::sewer_scene_store_oppresion_guy);
	var_00 = maps\betrayal_util::get_ents_by_targetname("atlas_guard_oppression_event");
	foreach(var_02 in var_00)
	{
		var_03 = var_02 maps\_utility::spawn_ai(1,0);
		level.guard_oppression_event_ents = common_scripts\utility::array_add(level.guard_oppression_event_ents,var_03);
	}

	var_05 = maps\betrayal_util::get_ent_by_targetname("atlas_guard_oppression_event_starter");
	level.oppression_starter = var_05 maps\_utility::spawn_ai(1,0);
	level.guard_oppression_event_ents = common_scripts\utility::array_add(level.guard_oppression_event_ents,level.oppression_starter);
	foreach(var_07 in level.guard_oppression_event_ents)
	{
		var_07 thread maps\betrayal_util::delete_ai_on_flag("boat_scene_start");
		var_07.canjumppath = 1;
		var_07 maps\_utility::set_ignoreall(1);
		var_07 thread sewer_scene_checkpoint_guard_wakeup();
		var_07 maps\betrayal_util::stop_current_animations();
		var_07.animname = "generic";
		if(isdefined(var_07.animation))
		{
			var_08 = var_07.animation;
		}
		else
		{
			var_08 = "bet_ceremony_security_idle_guy01";
		}

		var_07 thread maps\_anim::anim_loop([var_07],var_08);
	}

	level thread sewer_scene_handle_opression_event();
	common_scripts\utility::flag_wait("oppression_ent_completed_beat_01");
	foreach(var_07 in level.guard_oppression_event_ents)
	{
		if(isdefined(var_07.target))
		{
			var_07 maps\betrayal_util::stop_current_animations();
			var_0B = getnode(var_07.target,"targetname");
			var_07 maps\_utility::set_goal_node(var_0B);
			var_07.goalradius = 16;
			var_07 notify("move");
		}
	}
}

//Function Number: 174
sewer_scene_store_oppresion_guy()
{
	if(!isdefined(level.sewer_scene_oppresion_guys))
	{
		level.sewer_scene_oppresion_guys = [];
	}

	level.sewer_scene_oppresion_guys[level.sewer_scene_oppresion_guys.size] = self;
}

//Function Number: 175
sewer_scene_handle_opression_event()
{
	var_00 = maps\betrayal_util::get_ent_by_targetname("oppressed_civ01_spanwer");
	var_01 = maps\betrayal_util::get_ent_by_targetname("oppressed_civ02_spanwer");
	level.oppressed_civ01 = var_00 maps\_utility::spawn_ai(1,0);
	level.oppressed_civ02 = var_01 maps\_utility::spawn_ai(1,0);
	level.oppressed_civs = [];
	level.oppressed_civs = common_scripts\utility::array_add(level.oppressed_civs,level.oppressed_civ01);
	level.oppressed_civs = common_scripts\utility::array_add(level.oppressed_civs,level.oppressed_civ02);
	foreach(var_03 in level.oppressed_civs)
	{
		var_03 thread maps\betrayal_util::delete_ai_on_flag("flag_sewer_finish_sewer_scene_cleanup");
		var_03 maps\_utility::set_ignoreall(1);
		var_03 maps\betrayal_util::stop_current_animations();
		var_03.animname = "scripted";
		if(isdefined(var_03.animation))
		{
			var_04 = var_03.animation;
		}
		else
		{
			var_04 = "civilian_stand_idle";
		}

		var_03 thread maps\_anim::anim_loop([var_03],var_04);
	}

	level.oppressed_civ01 thread sewer_scene_oppression_civ01();
	level.oppressed_civ02 thread sewer_scene_oppression_civ02();
	level.oppression_starter thread sewer_scene_oppression_guard();
	level.oppression_starter thread sewer_scene_checkpoint_guard_wakeup();
	soundscripts\_snd::snd_message("market_walla_cleanup","flag_sewer_finish_sewer_scene_cleanup");
	common_scripts\utility::flag_wait("flag_sewer_oppression_event_start");
	common_scripts\utility::flag_set("start_oppression_event");
}

//Function Number: 176
sewer_scene_oppression_civ01()
{
	level endon("flag_sewer_checkpoint_guards_wakeup");
	thread sewer_scene_vignette_actor_flee();
	common_scripts\utility::flag_wait("start_oppression_event");
	maps\betrayal_util::stop_current_animations();
	self.animname = "scripted";
	thread maps\_anim::anim_loop([self],"civilian_directions_stand_idle");
	common_scripts\utility::flag_wait("oppression_ent_completed_beat_02");
	wait(0.2);
	maps\betrayal_util::stop_current_animations();
	self.animname = "scripted";
	maps\_anim::anim_single_solo(self,"civ_react_handsup");
	maps\betrayal_util::stop_current_animations();
	self.animname = "scripted";
	thread maps\_anim::anim_loop([self],"civ_react_handsup_idle");
}

//Function Number: 177
sewer_scene_oppression_civ02()
{
	level endon("flag_sewer_checkpoint_guards_wakeup");
	thread sewer_scene_vignette_actor_flee();
	common_scripts\utility::flag_wait("start_oppression_event");
	maps\betrayal_util::stop_current_animations();
	self.animname = "scripted";
	thread maps\_anim::anim_loop([self],"civilian_directions_stand_idle_2");
	common_scripts\utility::flag_wait("oppression_ent_completed_beat_02");
	wait(0.5);
	maps\betrayal_util::stop_current_animations();
	self.animname = "scripted";
	maps\_anim::anim_single_solo(self,"civ_react_handsup");
	maps\betrayal_util::stop_current_animations();
	self.animname = "scripted";
	thread maps\_anim::anim_loop([self],"civ_react_handsup_idle");
}

//Function Number: 178
sewer_scene_oppression_guard()
{
	level endon("flag_sewer_checkpoint_guards_wakeup");
	common_scripts\utility::flag_wait("start_oppression_event");
	maps\betrayal_util::stop_current_animations();
	self.animname = "scripted";
	thread maps\_anim::anim_single_solo(self,"soldier_drone_walk_to_and_point");
	wait(3);
	common_scripts\utility::flag_set("oppression_ent_completed_beat_01");
	wait(1);
	self.animname = "scripted";
	thread maps\_anim::anim_loop([self],"soldier_drone_standing_gun_raised_idle");
	common_scripts\utility::flag_set("oppression_ent_completed_beat_02");
	wait(1);
	var_00 = "ny_manhattan_radio_sandman_talk";
	maps\_anim::anim_single_solo(self,var_00);
	self.animname = "scripted";
	thread maps\_anim::anim_loop([self],"soldier_drone_standing_gun_raised_idle");
	common_scripts\utility::flag_wait("oppression_ent_completed_beat_03");
}

//Function Number: 179
sewer_scene_checkpoint_guard_wakeup()
{
	self endon("death");
	common_scripts\utility::flag_wait("flag_sewer_checkpoint_guards_wakeup");
	maps\betrayal_util::stop_current_animations();
	maps\_utility::set_goal_radius(128);
	self setgoalpos(self.origin);
	for(;;)
	{
		maps\_utility::set_ignoreall(0);
		maps\_utility::set_baseaccuracy(0.05);
		while(!common_scripts\utility::flag("flag_sewer_player_failed_checkpoint"))
		{
			wait(0.5);
		}

		self.original_position = self.origin;
		maps\_utility::set_ignoreall(0);
		maps\_utility::set_baseaccuracy(5);
		thread maps\_utility::player_seek_enable();
		while(common_scripts\utility::flag("flag_sewer_player_failed_checkpoint"))
		{
			wait(0.5);
		}

		maps\_utility::player_seek_disable();
		maps\_utility::set_goal_pos(self.original_position);
	}
}

//Function Number: 180
sewer_scene_checkpoint_handle_guard_wakeup()
{
	level thread sewer_scene_checkpoint_fail_conditions();
	common_scripts\utility::flag_wait("oppression_ent_completed_beat_02");
	wait(15);
	common_scripts\utility::flag_set("flag_sewer_checkpoint_guards_wakeup");
}

//Function Number: 181
sewer_scene_checkpoint_fail_conditions(param_00)
{
	common_scripts\utility::flag_wait("start_market_fail_conditions");
	level thread sewer_scene_checkpoint_failed_player_jumped_down();
	if(!isdefined(param_00) || param_00)
	{
		level thread sewer_scene_checkpoint_failed_player_stayed_behind();
		level thread sewer_scene_checkpoint_failed_player_shot();
		level thread sewer_scene_checkpoint_failed_player_too_close();
		level thread sewer_scene_checkpoint_failed_player_went_back();
	}

	common_scripts\utility::flag_wait("flag_sewer_player_failed_checkpoint");
	level thread sewer_scene_chkpt_fail_warbird();
	if(!isdefined(param_00) || param_00)
	{
		level thread sewer_scene_chkpt_fail_extra_hunters();
	}

	thread sewer_scene_checkpoint_player_killvol_handling();
	if(maps\betrayal_util::player_mission_failed_handler(20,"flag_sewer_player_failed_checkpoint") && !common_scripts\utility::flag("flag_sewer_player_jumped_in_market"))
	{
		thread sewer_scene_checkpoint_fail_conditions(0);
	}
}

//Function Number: 182
sewer_scene_checkpoint_failed_player_jumped_down()
{
	level endon("flag_sewer_player_failed_checkpoint");
	common_scripts\utility::flag_wait("flag_sewer_player_jumped_in_market");
	common_scripts\utility::flag_set("flag_sewer_checkpoint_guards_wakeup");
	common_scripts\utility::flag_set("flag_sewer_player_failed_checkpoint");
}

//Function Number: 183
sewer_scene_checkpoint_player_killvol_handling()
{
	level.player endon("death");
	level.market_kill_volume = maps\betrayal_util::get_ent_by_targetname("sewer_scene_security_magicbullet_player");
	var_00 = getent("sewer_scene_magic_bullet_start","targetname");
	var_01 = level.player geteye();
	for(;;)
	{
		if(level.player istouching(level.market_kill_volume))
		{
			var_01 = level.player geteye();
			magicbullet("iw5_thor_sp",var_00.origin,var_01);
			level.player kill();
			wait(0.5);
			setdvar("ui_deadquote",&"BETRAYAL_FAIL_ESCAPE");
			maps\_utility::missionfailedwrapper();
		}

		wait 0.05;
	}
}

//Function Number: 184
sewer_scene_checkpoint_failed_player_went_back()
{
	level endon("flag_sewer_player_failed_checkpoint");
	common_scripts\utility::flag_wait("flag_sewer_player_went_back");
	common_scripts\utility::flag_set("flag_sewer_checkpoint_guards_wakeup");
	wait(20);
	if(common_scripts\utility::flag("flag_sewer_oldtown_intro_complete"))
	{
		return;
	}

	common_scripts\utility::flag_set("flag_sewer_player_failed_checkpoint");
}

//Function Number: 185
sewer_scene_checkpoint_failed_player_stayed_behind()
{
	level endon("flag_sewer_player_failed_checkpoint");
	common_scripts\utility::flag_wait("oppression_ent_completed_beat_02");
	wait(15);
	common_scripts\utility::flag_set("flag_sewer_checkpoint_guards_wakeup");
	wait(40);
	if(common_scripts\utility::flag("flag_sewer_oldtown_intro_complete"))
	{
		return;
	}

	common_scripts\utility::flag_set("flag_sewer_player_failed_checkpoint");
}

//Function Number: 186
sewer_scene_checkpoint_failed_player_shot()
{
	level endon("flag_sewer_player_failed_checkpoint");
	level.player common_scripts\utility::waittill_any("begin_firing","grenade_fire");
	common_scripts\utility::flag_set("flag_sewer_checkpoint_guards_wakeup");
	wait(10);
	if(common_scripts\utility::flag("flag_sewer_oldtown_intro_complete"))
	{
		return;
	}

	common_scripts\utility::flag_set("flag_sewer_player_failed_checkpoint");
}

//Function Number: 187
sewer_scene_checkpoint_failed_player_too_close()
{
	level endon("flag_sewer_player_failed_checkpoint");
	var_00 = 0;
	while(!var_00)
	{
		wait(0.05);
		level.sewer_scene_oppresion_guys = common_scripts\utility::array_removeundefined(level.sewer_scene_oppresion_guys);
		foreach(var_02 in level.sewer_scene_oppresion_guys)
		{
			if(isdefined(var_02) && distance(var_02.origin,level.player.origin) < 250)
			{
				var_00 = 1;
			}
		}
	}

	common_scripts\utility::flag_set("flag_sewer_checkpoint_guards_wakeup");
	wait(20);
	if(common_scripts\utility::flag("flag_sewer_oldtown_intro_complete"))
	{
		return;
	}

	common_scripts\utility::flag_set("flag_sewer_player_failed_checkpoint");
}

//Function Number: 188
sewer_scene_chkpt_fail_warbird()
{
	var_00 = maps\_vehicle::spawn_vehicle_from_targetname_and_drive("chkpt_fail_warbird");
	var_00 soundscripts\_snd::snd_message("aud_ambient_helicopter","chkpt_fail_warbird");
	var_00 thread maps\_vehicle::godon();
	var_00 thread maps\betrayal_util::warbird_shooting_think(0,1);
	var_00 setlookatent(level.player);
	common_scripts\utility::flag_waitopen("flag_sewer_player_failed_checkpoint");
	var_01 = common_scripts\utility::getstruct("final_path_fail_warbird","targetname");
	var_00 thread maps\_vehicle_code::_vehicle_paths(var_01);
}

//Function Number: 189
sewer_scene_chkpt_fail_extra_hunters()
{
	level notify("stop_fail_extra_hunters");
	level endon("stop_fail_extra_hunters");
	var_00 = maps\betrayal_util::get_ents_by_targetname("sewer_guard_failed_hunter");
	var_01 = [];
	common_scripts\utility::array_thread(var_00,::maps\_utility::add_spawn_function,::sewer_scene_chkpt_fail_extra_hunters_setup);
	var_02 = 6;
	while(var_00.size > 0)
	{
		var_00 = sortbydistance(var_00,level.player.origin);
		while(common_scripts\utility::flag("flag_sewer_player_failed_checkpoint"))
		{
			var_01 = maps\_utility::array_removedead_or_dying(var_01);
			foreach(var_04 in var_01)
			{
				var_04 thread sewer_scene_chkpt_fail_extra_hunters_setup();
			}

			if(var_01.size < var_02)
			{
				for(var_06 = 0;var_06 < var_00.size;var_06++)
				{
					if(!maps\_utility::either_player_looking_at(var_00[var_06].origin,undefined,undefined,undefined))
					{
						var_07 = var_00[var_06] maps\_utility::spawn_ai();
						if(maps\_utility::spawn_failed(var_07))
						{
							continue;
						}

						var_01 = common_scripts\utility::array_add(var_01,var_07);
						var_00[var_06] delete();
						var_00[var_06] = undefined;
					}

					if(!common_scripts\utility::flag("flag_sewer_player_failed_checkpoint"))
					{
						break;
					}

					if(var_01.size >= var_02)
					{
						break;
					}

					wait(0.5);
				}

				var_00 = common_scripts\utility::array_removeundefined(var_00);
				if(var_00.size <= 0)
				{
					break;
				}
			}

			wait(2);
		}

		foreach(var_04 in var_01)
		{
			if(isdefined(var_04))
			{
				var_04 maps\_utility::set_baseaccuracy(0.5);
				var_04 thread maps\_utility::player_seek_disable();
			}
		}

		wait(2);
		if(common_scripts\utility::flag("oldtown_section4"))
		{
			break;
		}
	}

	foreach(var_04 in var_01)
	{
		var_04 maps\betrayal_util::delete_ai();
	}
}

//Function Number: 190
sewer_scene_chkpt_fail_extra_hunters_setup()
{
	maps\_utility::set_ignoreall(0);
	maps\_utility::set_baseaccuracy(5);
	thread maps\_utility::player_seek_enable();
}

//Function Number: 191
sewer_scene_scripted_objects()
{
	level.oldtown_ceiling_fans = maps\betrayal_util::get_ents_by_targetname("ceiling_fan_turning");
	common_scripts\utility::run_thread_on_targetname("ceiling_fan_turning",::maps\betrayal_util::scripted_spin_fan_blades,7,"oldtown_dock_scene_cleanup");
}

//Function Number: 192
oldtown_scene_master_handler()
{
	common_scripts\utility::flag_set("flag_dialogue_start_oldtown");
	level thread oldtown_freerun();
	common_scripts\utility::flag_wait("oldtown_dock_flyby");
	level thread oldtown_dock_master_handler();
}

//Function Number: 193
oldtown_freerun()
{
	level.oldtown_enemy_array = [];
	level.oldtown_chasers = [];
	level thread oldtown_freerun_civ_init();
	level thread oldtown_freerun_enemy_spawner_init();
	level thread oldtown_freerun_ilona_ignore_pain_handler();
	level thread oldtown_freerun_scripted_object_setup();
	common_scripts\utility::flag_wait("flag_sewer_scene_transfer_to_free_run");
	level.ilana.runngun = 1;
	thread oldtown_freerun_ilana_awareness();
	common_scripts\utility::flag_set("flag_enable_battle_chatter");
	level.player setclutforplayer("clut_betrayal_c3_01",5);
	thread oldtown_freerun_enemy_removal();
	thread oldtown_freerun_enemy_cleanup_maintain();
	if(!isdefined(level.guards_at_market_checkpoint_array))
	{
		sewer_scene_spawn_guards_at_market_checkpoint(0);
		thread maps\betrayal_util::clear_ignore_all_on_group(level.guards_at_market_checkpoint_array);
	}

	thread oldtown_freerun_security_checkpoint_guards_hold_fire();
	if(!isdefined(level.market_kill_volume))
	{
		thread sewer_scene_checkpoint_player_killvol_handling();
	}

	thread oldtown_freerun_enemy_dresser_kick();
	thread oldtown_freerun_warbird_pass();
	thread oldtown_freerun_failstate_monitor();
	if(level.currentgen)
	{
		thread oldtown_freerun_cg_perf_maintain();
	}
}

//Function Number: 194
oldtown_freerun_cg_perf_maintain()
{
	var_00 = ["basic_set_1"];
	thread maps\_cg_encounter_perf_monitor::cg_spawn_perf_monitor("oldtown_dock_flyby",var_00,12,0);
}

//Function Number: 195
oldtown_freerun_ilana_awareness()
{
	common_scripts\utility::flag_wait("rear_pressure_go");
	level.ilana.ignoreall = 0;
	level.ilana.ignoresuppression = 1;
}

//Function Number: 196
oldtown_freerun_ilona_ignore_pain_handler()
{
	common_scripts\utility::flag_wait("freerun_ilona_ignore_pain");
	level.ilana maps\_utility::disable_pain();
	common_scripts\utility::flag_wait("freerun_ilona_feel_pain");
	level.ilana maps\_utility::enable_pain();
}

//Function Number: 197
oldtown_freerun_civ_init()
{
	thread oldtown_freerun_civ_setup();
	thread oldtown_freerun_civ_walker_setup();
	thread oldtown_freerun_civ_badplace_pathing();
	thread oldtown_freerun_civ_ender();
}

//Function Number: 198
oldtown_freerun_civ_setup()
{
	common_scripts\utility::run_thread_on_targetname("freerun_civilian_spawn_trig",::maps\betrayal_util::civilian_setup,1200,0);
}

//Function Number: 199
oldtown_freerun_civ_badplace_pathing()
{
	var_00 = getentarray("oldtown_freerun_dronezone","targetname");
	foreach(var_02 in var_00)
	{
		badplace_brush("droneZone_volume",-1,var_02,"neutral","axis","allies");
	}
}

//Function Number: 200
oldtown_freerun_civ_walker_setup()
{
	level.freerun_walker_array = [];
	var_00 = 10;
	var_01 = getent("freerun_civ_male_walker_spawner","targetname");
	var_02 = getent("freerun_civ_female_walker_spawner","targetname");
	var_03 = [var_01,var_02];
	var_04 = common_scripts\utility::getstructarray("freerun_walker_start","targetname");
	var_05 = getnodearray("freerun_walker_exit_node","targetname");
	thread oldtown_freerun_civ_walker_maintainer(var_03,var_04,var_05,var_00);
}

//Function Number: 201
oldtown_freerun_civ_walker_maintainer(param_00,param_01,param_02,param_03)
{
	level endon("freerun_go");
	for(;;)
	{
		if(level.freerun_walker_array.size < param_03)
		{
			param_01 = common_scripts\utility::array_randomize(param_01);
			param_02 = common_scripts\utility::array_randomize(param_02);
			param_00 = common_scripts\utility::array_randomize(param_00);
			param_00[0].count = 1;
			var_04 = param_00[0] maps\_utility::spawn_ai(1);
			level.freerun_walker_array = common_scripts\utility::array_add(level.freerun_walker_array,var_04);
			var_04.goalradius = 32;
			var_04.alertlevel = "noncombat";
			var_04 maps\betrayal_util::set_custom_patrol_anim_set("panic");
			var_04 forceteleport(param_01[0].origin,param_01[0].angles);
			wait 0.05;
			var_04 setgoalnode(param_02[0]);
			var_04 thread oldtown_freerun_civ_walker_panic();
			var_04 thread oldtown_freerun_civ_walker_removal();
		}

		wait 0.05;
	}
}

//Function Number: 202
oldtown_freerun_civ_walker_panic()
{
	self endon("death");
	level waittill("freerun_go");
	wait(randomfloatrange(0.5,1.25));
	if(isdefined(self))
	{
		self.alertlevel = "combat";
		maps\betrayal_util::set_custom_patrol_anim_set("panic");
	}

	self.animname = "civilian_react";
	level.esc_node_locations = sortbydistance(level.esc_node_locations,self.origin);
	var_00 = level.esc_node_locations[0];
	level.esc_node_locations = common_scripts\utility::array_remove(level.esc_node_locations,level.esc_node_locations[0]);
	wait 0.05;
	self setgoalnode(var_00);
	self waittill("goal");
	var_00 thread maps\_anim::anim_loop_solo(self,"civ_react_cower_crouch_to_crouch_2","stop_loop");
	if(isdefined(var_00.target))
	{
		thread maps\betrayal_util::civilian_actor_ai_player_reaction(var_00);
	}
}

//Function Number: 203
oldtown_freerun_civ_walker_panic_retreat(param_00)
{
	var_01 = getnode(param_00.target,"targetname");
	var_02 = var_01.script_noteworthy;
	common_scripts\utility::flag_wait(var_02);
	self notify("stop_loop");
	self stopanimscripted();
	wait 0.05;
	self setgoalnode(var_01);
	self waittill("goal");
	var_01 thread maps\_anim::anim_loop_solo(self,"civ_react_cower_crouch_to_crouch_2","stop_loop");
}

//Function Number: 204
oldtown_freerun_civ_walker_removal()
{
	level waittill("freerun_go");
	self endon("death");
	self waittill("goal");
	level.freerun_walker_array = common_scripts\utility::array_remove(level.freerun_walker_array,self);
	maps\betrayal_util::delete_ai();
}

//Function Number: 205
oldtown_freerun_civ_ender()
{
	common_scripts\utility::flag_wait("flag_sewer_oldtown_intro_complete");
	common_scripts\utility::flag_set("rear_pressure_go");
	level notify("freerun_go");
}

//Function Number: 206
oldtown_freerun_enemy_spawner_init()
{
	maps\betrayal_util::add_spawn_function_to_noteworthy("basic_set_1",::oldtown_freerun_enemy_spawner_func);
	maps\betrayal_util::add_spawn_function_to_noteworthy("basic_set_1",::oldtown_freerun_enemy_spawner_alert);
	maps\betrayal_util::add_spawn_function_to_noteworthy("vo_group_1",::oldtown_freerun_enemy_spawner_func);
	maps\betrayal_util::add_spawn_function_to_noteworthy("vo_group_1",::oldtown_freerun_enemy_vo_setup);
	maps\betrayal_util::add_spawn_function_to_noteworthy("vo_group_1",::oldtown_freerun_enemy_secondgoal,"flr1_set1_spawner5_goal_second");
	maps\betrayal_util::add_spawn_function_to_noteworthy("vig_jump_group_1",::oldtown_freerun_enemy_spawner_func);
	maps\betrayal_util::add_spawn_function_to_noteworthy("vig_jump_group_1",::oldtown_freerun_vis_jumper);
	maps\betrayal_util::add_spawn_function_to_noteworthy("vig_jump_group_1",::oldtown_freerun_enemy_spawner_alert);
	maps\betrayal_util::add_spawn_function_to_noteworthy("vig_jump_group_2",::oldtown_freerun_enemy_spawner_func);
	maps\betrayal_util::add_spawn_function_to_noteworthy("vig_jump_group_2",::oldtown_freerun_vis_jumper2);
	maps\betrayal_util::add_spawn_function_to_noteworthy("vig_jump_group_2",::oldtown_freerun_enemy_spawner_alert);
	maps\betrayal_util::add_spawn_function_to_noteworthy("mech_group_1",::oldtown_freerun_mech_hunting);
	maps\betrayal_util::add_spawn_function_to_noteworthy("mech_group_1",::oldtown_freerun_mech_persist);
	maps\betrayal_util::add_spawn_function_to_noteworthy("doorkick_group_1",::oldtown_freerun_enemy_spawner_func);
	maps\betrayal_util::add_spawn_function_to_noteworthy("doorkick_group_1",::oldtown_freerun_doorkick_enemy_setup);
	maps\betrayal_util::add_spawn_function_to_noteworthy("frag_group_1",::oldtown_freerun_enemy_spawner_func);
	maps\betrayal_util::add_spawn_function_to_noteworthy("dresser_group_1",::oldtown_freerun_enemy_spawner_func);
	maps\betrayal_util::add_spawn_function_to_noteworthy("dresser_group_1",::oldtown_freerun_enemy_dresser_kick_setup);
}

//Function Number: 207
oldtown_freerun_enemy_spawner_alert()
{
	if(!isdefined(level.freerun_enemy_alert_notified))
	{
		if(randomint(100) < 15)
		{
			level.freerun_enemy_alert_notified = 1;
			level thread maps\betrayal_vo::play_dialogue_oldtown_player_spotted(self,undefined,1);
			wait(1);
			level.freerun_enemy_alert_notified = undefined;
		}
	}
}

//Function Number: 208
oldtown_freerun_enemy_spawner_func(param_00)
{
	var_01 = self.target;
	wait 0.05;
	if(isdefined(param_00))
	{
		thread oldtown_freerun_enemy_removal_offscreen(param_00);
	}

	self.baseaccuracy = 0.5;
	self.canjumppath = 1;
	thread oldtown_freerun_enemy_goal_assign(var_01);
	thread oldtown_freerun_enemy_monitor_player_pos();
	level.oldtown_enemy_array = common_scripts\utility::array_add(level.oldtown_enemy_array,self);
}

//Function Number: 209
oldtown_freerun_enemy_monitor_player_pos()
{
	self endon("death");
	var_00 = self.target;
	for(;;)
	{
		var_01 = oldtown_freerun_enemy_chk_player_pos(var_00);
		if(var_01 < 0)
		{
			break;
		}

		wait 0.05;
	}

	thread oldtown_freerun_enemy_chase_player();
}

//Function Number: 210
oldtown_freerun_enemy_chk_player_pos(param_00)
{
	var_01 = getnode(param_00,"targetname");
	var_02 = anglestoforward(var_01.angles);
	var_03 = level.player.origin - var_01.origin;
	var_04 = vectordot(var_02,var_03);
	return var_04;
}

//Function Number: 211
oldtown_freerun_security_checkpoint_guards_hold_fire()
{
	var_00 = maps\betrayal_util::get_ent_by_targetname("security_checkpoint_guards_hold_fire");
	var_00 waittill("trigger");
	if(isdefined(level.guard_oppression_event_ents))
	{
		level.guard_oppression_event_ents = common_scripts\utility::array_removeundefined(level.guard_oppression_event_ents);
		level.guards_at_market_checkpoint_array = common_scripts\utility::array_removeundefined(level.guards_at_market_checkpoint_array);
		var_01 = maps\_utility::array_merge(level.guard_oppression_event_ents,level.guards_at_market_checkpoint_array);
	}
	else
	{
		var_01 = common_scripts\utility::array_removeundefined(level.guards_at_market_checkpoint_array);
	}

	var_01 = common_scripts\utility::array_removeundefined(var_01);
	foreach(var_03 in var_01)
	{
		var_03 maps\_utility::set_ignoreall(1);
	}

	while(level.player istouching(var_00))
	{
		var_01 = common_scripts\utility::array_removeundefined(var_01);
		foreach(var_03 in var_01)
		{
			if(level.player maps\_utility::player_can_see_ai(var_03))
			{
				var_03 maps\_utility::set_ignoreall(0);
				var_01 = common_scripts\utility::array_remove(var_01,var_03);
				continue;
			}

			if(!var_03.ignoreall)
			{
				var_03 maps\_utility::set_ignoreall(1);
			}
		}

		wait 0.05;
	}

	var_01 = common_scripts\utility::array_removeundefined(var_01);
	foreach(var_03 in var_01)
	{
		var_03 maps\_utility::set_ignoreall(0);
	}
}

//Function Number: 212
oldtown_freerun_enemy_chase_player()
{
	if(level.oldtown_chasers.size < 4)
	{
		level.oldtown_chasers = common_scripts\utility::array_add(level.oldtown_chasers,self);
		thread maps\_utility::player_seek_enable();
	}
}

//Function Number: 213
oldtown_freerun_enemy_chaser_cleaner()
{
	level endon("kill_oldtown_monitor");
	for(;;)
	{
		level.oldtown_chasers = maps\_utility::array_removedead_or_dying(level.oldtown_chasers);
		wait(1);
	}
}

//Function Number: 214
oldtown_freerun_enemy_goal_assign(param_00,param_01)
{
	self endon("death");
	maps\betrayal_util::assign_goal_node(param_00);
	if(isdefined(param_01))
	{
		if(param_01 == 1)
		{
			var_02 = self.goalradius;
			self.goalradius = 32;
			self.ignoreall = 1;
			self waittill("goal");
			self.ignoreall = 0;
			self.goalradius = var_02;
		}
	}
}

//Function Number: 215
oldtown_freerun_enemy_vo_setup()
{
	if(isdefined(self.script_parameters))
	{
		self.animname = "atlas_guard_2";
		level.atlas_guard2 = self;
		return;
	}

	if(!isdefined(self.script_parameters))
	{
		self.animname = "atlas_guard_3";
		level.atlas_guard3 = self;
	}
}

//Function Number: 216
oldtown_freerun_enemy_cleanup_maintain()
{
	level endon("kill_oldtown_monitor");
	for(;;)
	{
		wait(0.1);
		level.oldtown_enemy_array = maps\_utility::array_removedead_or_dying(level.oldtown_enemy_array);
		level.oldtown_chasers = maps\_utility::array_removedead_or_dying(level.oldtown_chasers);
	}
}

//Function Number: 217
oldtown_freerun_enemy_removal()
{
	var_00 = getnodearray("oldtown_freerun_enemy_exit","targetname");
	level.origfov = getdvarint("cg_fov");
	var_01 = 1500;
	common_scripts\utility::flag_wait("oldtown_boat_spawn");
	foreach(var_03 in level.oldtown_enemy_array)
	{
		var_04 = common_scripts\utility::within_fov(level.player.origin,level.player.angles,var_03.origin,level.origfov);
		var_05 = distance2d(level.player.origin,var_03.origin);
		if(var_05 > var_01 && var_04 != 0)
		{
			var_00 = sortbydistance(var_00);
			var_03 maps\betrayal_util::assign_goal_node(var_00[0],32);
			var_03.ignoreall = 1;
			var_03 waittill("goal");
			var_03 maps\betrayal_util::delete_ai();
			continue;
		}

		var_03 maps\betrayal_util::delete_ai();
	}
}

//Function Number: 218
oldtown_freerun_enemy_removal_offscreen(param_00)
{
	self endon("death");
	common_scripts\utility::flag_wait(param_00);
	level.origfov = getdvarint("cg_fov");
	var_01 = getnodearray("oldtown_freerun_enemy_exit","targetname");
	var_02 = common_scripts\utility::within_fov(level.player.origin,level.player.angles,self.origin,level.origfov);
	if(var_02 != 0)
	{
		var_01 = sortbydistance(var_01);
		maps\betrayal_util::assign_goal_node(var_01[0],32);
		self.ignoreall = 1;
		self waittill("goal");
		maps\betrayal_util::delete_ai();
		return;
	}

	maps\betrayal_util::delete_ai();
}

//Function Number: 219
oldtown_freerun_mech_hunting()
{
	self endon("death");
	common_scripts\utility::flag_wait("mech_start_hunt");
	thread maps\_utility::player_seek_enable();
	common_scripts\utility::flag_wait("oldtown_dock_flyby");
	oldtown_freerun_enemy_removal_offscreen("oldtown_boat_spawn");
}

//Function Number: 220
oldtown_freerun_mech_persist()
{
	self endon("death");
	var_00 = 600;
	level.mech_is_hunting = 0;
	for(;;)
	{
		wait(2);
		if(level.mech_is_hunting != 1)
		{
			var_01 = distance2d(self.origin,level.player.origin);
			if(var_01 < var_00)
			{
				maps\_mech::mech_stop_hunting();
				level.mech_is_hunting = 0;
			}
			else
			{
				maps\_mech::mech_start_hunting();
				level.mech_is_hunting = 1;
			}

			continue;
		}

		continue;
	}
}

//Function Number: 221
oldtown_freerun_enemy_dresser_kick_setup()
{
	thread maps\_utility::magic_bullet_shield();
	wait 0.05;
	self.animname = "generic";
	level notify("event_cabinet_go");
}

//Function Number: 222
oldtown_freerun_enemy_dresser_kick()
{
	var_00 = common_scripts\utility::getstruct("event_cabinet_animorg","targetname");
	var_01 = maps\_utility::spawn_anim_model("cabinet_org",var_00.origin,var_00.angles);
	var_02 = getent("dresser_org1","targetname");
	var_03 = getent("event_cabinet","targetname");
	var_00 thread maps\_anim::anim_first_frame_solo(var_01,"cabinet_pull");
	var_02 linkto(var_01,"tag_origin_animated");
	var_03 linkto(var_01,"tag_origin_animated");
	level waittill("event_cabinet_go");
	var_04 = maps\_utility::get_living_ai("dresser_group_1","script_noteworthy");
	var_04.allowdeath = 0;
	var_05 = var_04 maps\_utility::getanim_from_animname("cabinet_pull","generic");
	var_06 = getanimlength(var_05);
	var_07 = [var_04,var_01];
	var_00 thread maps\_anim::anim_single(var_07,"cabinet_pull");
	wait(1.1);
	var_04 maps\_utility::stop_magic_bullet_shield();
	var_04.allowdeath = 1;
	wait(var_06 - 1.1);
	var_02 disconnectpaths();
}

//Function Number: 223
oldtown_freerun_enemy_fragging()
{
	common_scripts\utility::flag_wait("freerun_frag_go");
	var_00 = common_scripts\utility::getstruct("frag_gren_end","targetname");
	var_01 = common_scripts\utility::getstruct("frag_gren_start","targetname");
	magicgrenade("fraggrenade",var_01.origin,var_00.origin,2);
}

//Function Number: 224
oldtown_freerun_doorkick_enemy_setup()
{
	level endon("freerun_doorkick_player_go");
	common_scripts\utility::flag_wait("freerun_doorkick_enemy_go");
	if(common_scripts\utility::flag("freerun_doorkick_player_go"))
	{
		return;
	}

	level notify("freerun_doorkick_enemy_go");
	var_00 = common_scripts\utility::getstruct("enemy_doorkick","targetname");
	if(!isdefined(self.script_parameters))
	{
		return;
	}

	self.animname = "generic";
	self.allowdeath = 1;
	var_00 thread maps\_anim::anim_single_solo(self,"exo_doorkick");
}

//Function Number: 225
oldtown_freerun_doorkick_enemy()
{
	level endon("freerun_doorkick_player_go");
	var_00 = getent("clip_enemy_doorkick","targetname");
	var_01 = getent("model_enemy_doorkick","targetname");
	var_02 = getent("model_enemy_doorkick_broken","targetname");
	var_03 = common_scripts\utility::getstruct("struct_enemy_doorkick","targetname");
	level.enemy_doorkick = [var_00,var_01,var_02];
	var_00 disconnectpaths();
	var_02 hide();
	level waittill("door_smash_open");
	var_00 connectpaths();
	var_02 show();
	var_01 delete();
	var_00 delete();
	var_04 = var_02.origin - var_03.origin;
	var_01 = var_02;
	var_05 = (randomintrange(-5,5),randomintrange(-5,5),randomintrange(-10,10));
	var_01 physicslaunchserver(var_01.origin + var_05,var_04 * randomintrange(5,15));
}

//Function Number: 226
oldtown_freerun_doorkick_player()
{
	level endon("freerun_doorkick_enemy_go");
	level.player_doorkick = getentarray("oldtown_exo_door_punch2","script_noteworthy");
	foreach(var_01 in level.player_doorkick)
	{
		var_01 hide();
		var_01 thread oldtown_freerun_doorkick_player_removal();
	}

	common_scripts\utility::flag_wait("freerun_doorkick_player_go");
	level notify("freerun_doorkick_player_go");
	foreach(var_01 in level.player_doorkick)
	{
		var_01 show();
	}

	level.enemy_doorkick[0] delete();
	level.enemy_doorkick[1] delete();
	level.enemy_doorkick[2] delete();
}

//Function Number: 227
oldtown_freerun_doorkick_player_removal()
{
	level endon("freerun_doorkick_player_go");
	level waittill("freerun_doorkick_enemy_go");
	self notify("exo_door_punched");
	wait 0.05;
	self delete();
}

//Function Number: 228
oldtown_freerun_vis_jumper()
{
	common_scripts\utility::flag_wait("freerun_vis_jump_go");
	if(self.script_parameters != "freerun_vis_jump_guy")
	{
		return;
	}

	self.goalradius = 8;
	self waittill("goal");
}

//Function Number: 229
oldtown_freerun_vis_jumper2()
{
	common_scripts\utility::flag_wait("freerun_vis_jump2_go");
	if(self.script_parameters != "freerun_vis_jump2_guy")
	{
		return;
	}

	self.goalradius = 8;
	self waittill("goal");
}

//Function Number: 230
oldtown_freerun_enemy_secondgoal(param_00)
{
	if(!isdefined(self.script_parameters))
	{
		return;
	}

	var_01 = 8;
	self.goalradius = var_01;
	self waittill("goal");
	wait(0.1);
	maps\betrayal_util::assign_goal_node(param_00,var_01);
}

//Function Number: 231
oldtown_freerun_warbird_pass()
{
	common_scripts\utility::flag_wait("oldtown_section2");
	if(level.nextgen)
	{
		var_00 = maps\_vehicle::spawn_vehicle_from_targetname_and_drive("oldtown_freerun_flyby");
		var_00 soundscripts\_snd::snd_message("aud_ambient_helicopter","oldtown_freerun_flyby");
		var_00 thread maps\_vehicle::godon();
	}
}

//Function Number: 232
oldtown_freerun_scripted_object_setup()
{
	if(!isdefined(level.oldtown_ceiling_fans))
	{
		level.oldtown_ceiling_fans = maps\betrayal_util::get_ents_by_targetname("ceiling_fan_turning");
		common_scripts\utility::run_thread_on_targetname("ceiling_fan_turning",::maps\betrayal_util::scripted_spin_fan_blades,7,"oldtown_dock_scene_cleanup");
	}
}

//Function Number: 233
oldtown_freerun_failstate_monitor()
{
	thread oldtown_freerun_failstate_backtrack();
	thread oldtown_dock_failstate_backtrack();
}

//Function Number: 234
oldtown_freerun_failstate_backtrack()
{
	level endon("player_near_freerun_end");
	level.player endon("death");
	level.freerun_backtrack_death_squad_spawners = maps\betrayal_util::get_ents_by_targetname("freerun_backtrack_deathsquad_spawner");
	var_00 = maps\betrayal_util::get_ent_by_targetname("player_halfway_done_freerun");
	var_00 waittill("trigger");
	var_01 = maps\betrayal_util::get_ent_by_targetname("trigger_freerun_backtrack_deathsquad");
	var_01 waittill("trigger");
	common_scripts\utility::flag_set("disable_autosaves");
	thread oldtown_freerun_failstate_backtrack_deathsquad();
	wait(1);
	level thread maps\betrayal_vo::play_dialogue_oldtown_player_spotted(level.freerun_fail_hunter[0],level.freerun_fail_hunter[1]);
	wait(9);
	level.player kill();
	wait(0.5);
	setdvar("ui_deadquote",&"BETRAYAL_FAIL_ESCAPE");
	maps\_utility::missionfailedwrapper();
	common_scripts\utility::flag_clear("disable_autosaves");
}

//Function Number: 235
oldtown_freerun_failstate_backtrack_deathsquad()
{
	level endon("player_near_freerun_end");
	level.player endon("death");
	level.freerun_fail_hunter = [];
	foreach(var_01 in level.freerun_backtrack_death_squad_spawners)
	{
		var_02 = var_01 maps\_utility::spawn_ai(1,0);
		var_02.health = 1000;
		var_02.baseaccuracy = 10;
		if(isdefined(var_02.target))
		{
			var_03 = getnode(var_02.target,"targetname");
			if(isdefined(var_03))
			{
				var_02 maps\_utility::set_goal_node(var_03);
			}

			var_02 notify("move");
		}

		var_02 thread maps\_utility::player_seek_enable();
		level.freerun_fail_hunter[level.freerun_fail_hunter.size] = var_02;
		wait 0.05;
	}
}

//Function Number: 236
oldtown_dock_master_handler()
{
	common_scripts\utility::flag_set("flag_dialogue_start_docks");
	common_scripts\utility::flag_set("flag_enable_battle_chatter");
	level thread oldtown_dock();
	common_scripts\utility::flag_wait("boat_scene_start");
	level thread oldtown_dock_cleanup();
	level thread boat_scene_master_handler();
}

//Function Number: 237
oldtown_dock_cleanup()
{
	level thread oldtown_dock_post_boat_cleanup();
	level thread oldtown_dock_combat_cleanup();
	level notify("oldtown_dock_scene_cleanup");
	common_scripts\utility::flag_wait("flag_boat_player_in_boat");
	maps\_utility::activate_trigger("dock_civ_remover","targetname");
	maps\_utility::activate_trigger("freerun_civilian_cleanup_trig","targetname");
}

//Function Number: 238
oldtown_dock_post_boat_cleanup()
{
	common_scripts\utility::flag_wait("flag_boat_player_in_boat");
}

//Function Number: 239
oldtown_dock()
{
	thread oldtown_dock_civ_setup();
	boat_scene_early_setup();
	level notify("oldtown_freerun_end");
	level.oldtown_dock_enemies = [];
	level.ilana_dock_advance_count = 0;
	oldtown_dock_enemy_setup();
	thread oldtown_dock_anim_jumper_setup();
	thread oldtown_dock_littlebird_rooftop_vig();
	thread oldtown_dock_mech_entrance();
	common_scripts\utility::flag_set("flag_dialogue_docks_intro");
	common_scripts\utility::flag_set("mech_docks_entrance");
	thread oldtown_dock_ilana_advance();
	thread oldtown_dock_fail_init();
}

//Function Number: 240
oldtown_dock_civ_setup()
{
	var_00 = maps\betrayal_util::get_ents_by_targetname("oldtown_freerun_dock_civ1");
	foreach(var_02 in var_00)
	{
		var_03 = maps\betrayal_util::get_ents_by_targetname(var_02.target);
		foreach(var_05 in var_03)
		{
			if(isspawner(var_05))
			{
				var_05 maps\_utility::add_spawn_function(::add_doc_civ_walla);
			}
		}
	}

	common_scripts\utility::run_thread_on_targetname("oldtown_freerun_dock_civ1",::maps\betrayal_util::civilian_setup,10000,0);
}

//Function Number: 241
add_doc_civ_walla()
{
	soundscripts\_snd::snd_message("add_doc_civ_walla",self);
}

//Function Number: 242
oldtown_dock_ilana_advance()
{
	oldtown_dock_ilana_advance_think("oldtown_dock_ally_redirect_1");
	level.ilana.ignoresuppression = 0;
	level waittill("ilana_dock_advance2");
	thread oldtown_dock_ilana_advance_think("oldtown_dock_ally_redirect");
	level waittill("ilana_dock_advance3");
	thread oldtown_dock_ilana_advance_think("oldtown_dock_ally_redirect_3");
	common_scripts\utility::flag_set("flag_dialogue_docks_boat");
}

//Function Number: 243
oldtown_dock_ilana_advance_think(param_00)
{
	maps\_utility::activate_trigger(param_00,"targetname");
	level.ilana.ignoreall = 1;
	wait(1.5);
	level.ilana.ignoreall = 0;
}

//Function Number: 244
oldtown_dock_enemy_setup()
{
	maps\betrayal_util::add_spawn_function_to_noteworthy("docks_deploy_guy1",::oldtown_dock_enemy_moveup,"docks_deploy_guy1_goal1","docks_deploy_guy1_goal2");
	maps\betrayal_util::add_spawn_function_to_noteworthy("docks_deploy_guy2",::oldtown_dock_enemy_moveup,"docks_deploy_guy2_goal1","docks_deploy_guy2_goal2");
	maps\betrayal_util::add_spawn_function_to_noteworthy("docks_deploy_guy3",::oldtown_dock_enemy_moveup,"docks_deploy_guy3_goal1","docks_deploy_guy3_goal2");
	maps\betrayal_util::add_spawn_function_to_noteworthy("docks_deploy_guy4",::oldtown_dock_enemy_moveup,"docks_deploy_guy4_goal1","docks_deploy_guy4_goal2");
	maps\betrayal_util::add_spawn_function_to_noteworthy("docks_deploy_guy5",::oldtown_dock_enemy_moveup,"docks_deploy_guy5_goal1","docks_deploy_guy5_goal2");
	maps\betrayal_util::add_spawn_function_to_noteworthy("docks_deploy_guy6",::oldtown_dock_enemy_moveup,"docks_deploy_guy6_goal1","docks_deploy_guy6_goal2");
	var_00 = getentarray("oldtown_boat_spawners","targetname");
	foreach(var_02 in var_00)
	{
		var_03 = var_02 maps\_utility::spawn_ai(1);
		var_03 thread maps\betrayal_util::delete_ai_on_flag("dock_scene_cleanup_failstate_ai");
		wait 0.05;
		level.oldtown_dock_enemies = common_scripts\utility::array_add(level.oldtown_dock_enemies,var_03);
		var_03.health = 150;
		var_03 thread oldtown_dock_enemy_mech_death_alert();
	}

	thread oldtown_dock_enemy_retreat();
}

//Function Number: 245
oldtown_dock_enemy_moveup(param_00,param_01)
{
	self endon("death");
	wait 0.05;
	self.goalradius = 64;
	var_02 = getnode(param_00,"targetname");
	var_03 = getnode(param_01,"targetname");
	if(isdefined(self) && isalive(self))
	{
		maps\_utility::set_goal_node(var_02);
	}

	level waittill("mech_goal_go");
	if(isdefined(self) && isalive(self))
	{
		maps\_utility::set_goal_node(var_03);
	}

	self.baseaccuracy = self.baseaccuracy / 3;
}

//Function Number: 246
oldtown_dock_enemy_retreat()
{
	level endon("stop_dock_refill");
	wait(1);
	for(;;)
	{
		level.oldtown_dock_enemies = maps\_utility::array_removedead_or_dying(level.oldtown_dock_enemies);
		if(isdefined(level.dock_mech))
		{
			if(level.oldtown_dock_enemies.size <= 3)
			{
				level notify("dock_enemy_retreat");
				level notify("ilana_dock_advance2");
				foreach(var_01 in level.oldtown_dock_enemies)
				{
					var_01 maps\betrayal_util::assign_goal_vol("oldtown_boat_goalvol2");
				}

				level.dock_mech maps\_mech::mech_start_hunting();
				return;
			}
		}

		wait(1);
	}
}

//Function Number: 247
oldtown_dock_enemy_mech_death_alert()
{
	self endon("death");
	level waittill("mech_dead");
	thread maps\_utility::player_seek_enable();
}

//Function Number: 248
oldtown_dock_combat_cleanup()
{
	common_scripts\utility::flag_wait("player_on_boat");
	level notify("stop_dock_refill");
	common_scripts\utility::flag_wait("dock_cleanup");
	wait(1);
	foreach(var_01 in level.oldtown_dock_enemies)
	{
		var_01 maps\betrayal_util::delete_ai();
	}
}

//Function Number: 249
oldtown_dock_mech_entrance()
{
	level waittill("little_bird_vignette_complete");
	var_00 = getentarray("dock_mech_spawner","targetname");
	var_01 = 0;
	while(!var_01)
	{
		foreach(var_03 in var_00)
		{
			if(!maps\betrayal_util::player_can_see_point(var_03.origin) && !maps\betrayal_util::player_can_see_point(var_03.origin + (0,0,60)) && !maps\betrayal_util::player_can_see_point(var_03.origin + (0,0,120)))
			{
				level.dock_mech = var_03 maps\_utility::spawn_ai(1);
				common_scripts\utility::flag_set("flag_dialogue_docks_ast");
				var_01 = 1;
				level.dock_mech maps\_utility::add_damage_function(::oldtown_dock_mech_damage_function);
				break;
			}
		}

		wait(0.5);
	}

	wait 0.05;
	level.dock_mech.goalradius = 256;
	level.dock_mech maps\_mech::mech_start_target_attacker();
	level.dock_mech maps\_mech::mech_start_rockets();
	var_05 = getnode("dock_mech_goal1","targetname");
	var_06 = getnode("dock_mech_goal2","targetname");
	var_07 = getnode("dock_mech_goal3","targetname");
	var_08 = [var_05,var_06,var_07];
	level.dock_mech thread oldtown_dock_mech_goal(var_08);
	thread oldtown_dock_mech_death_event();
	wait(0.75);
	common_scripts\utility::flag_set("flag_objective_dock_scene_start");
}

//Function Number: 250
oldtown_dock_mech_damage_function(param_00,param_01,param_02,param_03,param_04,param_05,param_06)
{
	if(param_01 == level.ilana)
	{
		if(self.health > 0 && param_00 > self.bullet_resistance)
		{
			self.health = self.health + int(param_00 - self.bullet_resistance * 0.5);
		}
	}
}

//Function Number: 251
oldtown_dock_mech_rockets()
{
	level endon("mech_dead");
	var_00 = getent("start_boat_player","targetname");
	var_01 = 450;
	for(;;)
	{
		if(distance2d(level.player.origin,var_00.origin) < var_01)
		{
			level.dock_mech maps\_utility::set_favoriteenemy(level.player);
			level.dock_mech maps\_mech::mech_fire_rockets();
			wait(1);
		}

		wait 0.05;
	}
}

//Function Number: 252
oldtown_dock_mech_goal(param_00)
{
	self endon("death");
	param_00 = sortbydistance(param_00,level.player.origin);
	maps\_utility::set_goal_node(param_00[0]);
}

//Function Number: 253
oldtown_dock_mech_death_event()
{
	level endon("stop_mech_event_monitor");
	for(;;)
	{
		wait 0.05;
		if(!isdefined(level.dock_mech) || level.dock_mech.health <= 0)
		{
			level notify("mech_dead");
			level notify("ilana_dock_advance2");
			wait 0.05;
			level notify("ilana_dock_advance3");
			common_scripts\utility::flag_set("flag_objective_dock_scene_complete");
			common_scripts\utility::flag_set("boat_scene_start");
			common_scripts\utility::flag_set("swarm_docks_entrance");
			level notify("stop_mech_event_monitor");
		}
	}
}

//Function Number: 254
oldtown_dock_anim_jumper_setup()
{
	maps\betrayal_util::add_spawn_function_to_targetname("dock_jumper1_spawner",::oldtown_dock_anim_jumper,"dock_anim_jumper1");
	maps\betrayal_util::add_spawn_function_to_targetname("dock_jumper2_spawner",::oldtown_dock_anim_jumper,"dock_anim_jumper2");
	maps\betrayal_util::add_spawn_function_to_targetname("dock_jumper3_spawner",::oldtown_dock_anim_jumper,"dock_anim_jumper3");
	var_00 = maps\betrayal_util::spawn_ai_from_targetname_single("dock_jumper1_spawner",1);
	var_01 = maps\betrayal_util::spawn_ai_from_targetname_single("dock_jumper2_spawner",1);
	var_02 = maps\betrayal_util::spawn_ai_from_targetname_single("dock_jumper3_spawner",1);
	var_00 thread maps\_utility::deletable_magic_bullet_shield();
	var_01 thread maps\_utility::deletable_magic_bullet_shield();
	var_02 thread maps\_utility::deletable_magic_bullet_shield();
}

//Function Number: 255
oldtown_dock_anim_jumper(param_00)
{
	self endon("death");
	self.allowdeath = 1;
	var_01 = common_scripts\utility::getstruct(param_00,"targetname");
	var_02 = var_01.animation;
	self.animname = param_00;
	var_01 thread maps\_anim::anim_single_solo(self,var_02);
	var_03 = maps\_utility::getanim(var_02);
	var_04 = getanimlength(var_03);
	thread maps\_anim::anim_set_rate_single(self,var_02,0.3);
	wait(var_04);
	self delete();
}

//Function Number: 256
oldtown_dock_littlebird_rooftop_vig()
{
	var_00 = maps\betrayal_util::get_ent_by_targetname("oldtown_docks_littlebird_go");
	var_00 waittill("trigger");
	common_scripts\utility::flag_set("flag_objective_freerun_scene_complete");
	var_01 = maps\_vehicle::spawn_vehicle_from_targetname_and_drive("oldtown_docks_littlebird2");
	var_01 soundscripts\_snd::snd_message("aud_ambient_helicopter","oldtown_docks_littlebird2");
	var_02 = getnode("docks_rooftop_littlebird_goal1","targetname");
	var_03 = maps\_utility::get_living_ai("docks_rooftop_littlebird_vig1","script_noteworthy");
	if(isdefined(var_03))
	{
		var_03.allowdeath = 1;
		var_03.canjumppath = 1;
		var_03 thread oldtown_dock_littlebird_rooftop_goal(var_02);
		var_03 thread maps\betrayal_util::balcony_death_anims();
	}

	var_04 = getnode("docks_rooftop_littlebird_goal2","targetname");
	var_05 = maps\_utility::get_living_ai("docks_rooftop_littlebird_vig2","script_noteworthy");
	if(isdefined(var_05))
	{
		var_05.allowdeath = 1;
		var_05.canjumppath = 1;
		var_05 thread oldtown_dock_littlebird_rooftop_goal(var_04);
		var_05 thread maps\betrayal_util::balcony_death_anims();
	}

	var_01 waittill("unloading");
	level notify("little_bird_vignette_complete");
}

//Function Number: 257
oldtown_dock_littlebird_rooftop_goal(param_00)
{
	self endon("death");
	maps\_utility::disable_pain();
	self waittill("jumpedout");
	self.goalradius = 16;
	self setgoalnode(param_00);
	self.ignoreall = 1;
	self waittill("goal");
	maps\_utility::enable_pain();
	self.ignoreall = 0;
	self.baseaccuracy = 0.05;
	thread maps\betrayal_util::delete_ai_on_flag("dock_scene_cleanup_failstate_ai");
}

//Function Number: 258
oldtown_dock_fail_init()
{
	level thread oldtown_dock_fail_start();
	if(!isdefined(level.oldtown_dock_backtrack_death_squad_spawners))
	{
		thread oldtown_dock_failstate_backtrack();
	}

	common_scripts\utility::flag_wait("docks_end_fail_state_monitor");
	level notify("oldtown_docks_end_failure");
}

//Function Number: 259
oldtown_dock_fail_start()
{
	level endon("oldtown_docks_end_failure");
	common_scripts\utility::flag_wait("boat_scene_start");
	wait(40);
	if(!common_scripts\utility::flag("docks_end_fail_state_monitor"))
	{
		level thread oldtown_dock_backtrack_fail_send_in_flyers();
		level.oldtown_dock_fail_enemies = [];
		var_00 = maps\betrayal_util::get_ents_by_targetname("docks_fail_guards");
		foreach(var_02 in var_00)
		{
			var_03 = var_02 maps\_utility::spawn_ai(1);
			wait 0.05;
			var_03 maps\_vehicle::godon();
			var_03.baseaccuracy = 5;
			var_03.goalradius = 32;
			var_03 thread maps\betrayal_util::delete_ai_on_flag("dock_scene_cleanup_failstate_ai");
			level.oldtown_dock_fail_enemies = common_scripts\utility::array_add(level.oldtown_dock_fail_enemies,var_03);
			if(isdefined(var_03.script_noteworthy))
			{
				switch(var_03.script_noteworthy)
				{
					case "docks_guard1":
						var_03.animname = "atlas_guard_1";
						level.atlas_guard1 = var_03;
						var_03 thread oldtown_dock_fail_enemy_hunt();
						break;

					case "docks_guard2":
						var_03.animname = "atlas_guard_2";
						level.atlas_guard2 = var_03;
						var_03 thread oldtown_dock_fail_enemy_hunt();
						break;

					case "docks_guard3":
						var_03.animname = "atlas_guard_3";
						level.atlas_guard3 = var_03;
						var_03 maps\_utility::player_seek_enable();
						var_03 maps\_utility::set_goal_radius(16);
						var_03.canjumppath = 1;
						break;

					case "docks_guard4":
						var_03.animname = "atlas_guard_4";
						level.atlas_guard4 = var_03;
						var_03 maps\_utility::player_seek_enable();
						var_03 maps\_utility::set_goal_radius(16);
						var_03.canjumppath = 1;
						break;

					case "docks_guard5":
						var_03.canjumppath = 1;
						level.atlas_guard5 = var_03;
						var_03 thread oldtown_dock_fail_enemy_hunt();
						break;

					case "docks_guard6":
						var_03.canjumppath = 1;
						level.atlas_guard6 = var_03;
						var_03 thread oldtown_dock_fail_enemy_hunt();
						break;

					case "docks_mech1":
						var_03 thread maps\_mech::mech_start_hunting();
						var_03 thread maps\_mech::mech_start_rockets();
						level.atlas_guard7 = var_03;
						break;
				}
			}
		}

		level.atlas_guard1 thread maps\betrayal_util::simple_anim_at_struct("docks_guard1_animorg");
		level.atlas_guard2 thread maps\betrayal_util::simple_anim_at_struct("docks_guard2_animorg");
		var_05 = getaiarray("axis");
		var_05 = sortbydistance(var_05,level.player.origin);
		level thread maps\betrayal_vo::play_dialogue_oldtown_player_spotted(var_05[0],var_05[1]);
		thread oldtown_dock_fail_avoid_player_got_in_boat();
		maps\betrayal_util::player_mission_failed_handler(20,undefined,"docks_end_fail_state_monitor");
	}
}

//Function Number: 260
oldtown_dock_fail_avoid_player_got_in_boat()
{
	level.player endon("death");
	common_scripts\utility::flag_wait("docks_end_fail_state_monitor");
	foreach(var_01 in level.oldtown_dock_fail_enemies)
	{
		if(isai(var_01))
		{
			var_01 maps\_utility::set_ignoreall(1);
		}
	}

	common_scripts\utility::flag_wait("flag_boat_player_in_boat");
	foreach(var_01 in level.oldtown_dock_fail_enemies)
	{
		if(isai(var_01))
		{
			var_01 maps\_utility::set_ignoreall(0);
		}
	}
}

//Function Number: 261
oldtown_dock_backtrack_fail_send_in_flyers()
{
	var_00 = maps\_vehicle::spawn_vehicle_from_targetname_and_drive("docks_fail_warbird");
	var_00 soundscripts\_snd::snd_message("aud_ambient_helicopter","docks_fail_warbird");
	var_00 thread maps\_vehicle::godon();
	var_00 thread maps\betrayal_util::warbird_shooting_think(0,1);
	var_00.turret_target_override = level.player;
	common_scripts\utility::flag_wait_either("dock_scene_cleanup_failstate_ai","docks_end_fail_state_monitor");
	if(common_scripts\utility::flag("dock_scene_cleanup_failstate_ai"))
	{
		var_00 delete();
		return;
	}

	var_00 maps\_utility::ent_flag_clear("fire_turrets");
	common_scripts\utility::flag_wait("flag_boat_player_in_boat");
	var_00 maps\_utility::ent_flag_set("fire_turrets");
	common_scripts\utility::flag_wait("dock_scene_cleanup_failstate_ai");
	var_00 delete();
}

//Function Number: 262
oldtown_dock_fail_enemy_hunt()
{
	self waittill("anim_finished");
	wait(0.5);
	maps\_utility::player_seek_enable();
}

//Function Number: 263
oldtown_dock_failstate_backtrack()
{
	level endon("dock_scene_cleanup_failstate_ai");
	level.player endon("death");
	level.oldtown_dock_backtrack_death_squad_spawners = maps\betrayal_util::get_ents_by_targetname("dock_backtrack_deathsquad_spawner");
	var_00 = maps\betrayal_util::get_ent_by_targetname("player_near_freerun_end");
	var_00 waittill("trigger");
	level notify("player_near_freerun_end");
	var_01 = maps\betrayal_util::get_ent_by_targetname("dock_backtrack_leaving_mission_area_trig");
	var_02 = maps\betrayal_util::get_ent_by_targetname("trigger_dock_backtrack_deathsquad");
	var_03 = 0;
	while(!level.player istouching(var_02))
	{
		if(level.player istouching(var_01) && var_03 == 0)
		{
			thread maps\_utility::hintdisplayhandler("leaving_mission_area_trigger",undefined,var_01);
			var_03 = 1;
			continue;
		}

		if(!level.player istouching(var_02))
		{
			var_03 = 0;
		}

		wait 0.05;
	}

	common_scripts\utility::flag_set("disable_autosaves");
	thread oldtown_dock_failstate_backtrack_deathsquad();
	wait(1);
	level thread maps\betrayal_vo::play_dialogue_oldtown_player_spotted(level.freerun_fail_hunter[0],level.freerun_fail_hunter[1]);
	if(!maps\betrayal_util::player_mission_failed_handler(8,undefined,"docks_end_fail_state_monitor"))
	{
		level.player kill();
		wait(0.5);
		setdvar("ui_deadquote",&"BETRAYAL_FAIL_ESCAPE");
		maps\_utility::missionfailedwrapper();
		common_scripts\utility::flag_clear("disable_autosaves");
		return;
	}

	common_scripts\utility::flag_clear("disable_autosaves");
}

//Function Number: 264
oldtown_dock_failstate_backtrack_deathsquad()
{
	level endon("docks_end_fail_state_monitor");
	level.player endon("death");
	level.freerun_fail_hunter = [];
	foreach(var_01 in level.oldtown_dock_backtrack_death_squad_spawners)
	{
		var_02 = var_01 maps\_utility::spawn_ai(1,0);
		var_02.health = 1000;
		var_02.baseaccuracy = 10;
		if(isdefined(var_02.target))
		{
			var_03 = getnode(var_02.target,"targetname");
			if(isdefined(var_03))
			{
				var_02 maps\_utility::set_goal_node(var_03);
			}

			var_02 notify("move");
		}

		var_02 thread maps\_utility::player_seek_enable();
		level.freerun_fail_hunter[level.freerun_fail_hunter.size] = var_02;
		wait 0.05;
	}
}

//Function Number: 265
play_grapple_anim(param_00)
{
	waittillframeend;
	param_00 setanim(level.scr_anim["grapple_launcher"]["boat_getin"]);
}

//Function Number: 266
boat_scene_master_handler(param_00)
{
	boat_scene_early_setup();
	common_scripts\utility::flag_set("flag_dialogue_start_boat");
	if(!isdefined(param_00))
	{
		maps\_utility::autosave_by_name();
		var_01 = maps\betrayal_util::get_ent_by_targetname("trigger_use_get_in_boat");
		var_01 maps\_utility::addhinttrigger(&"BETRAYAL_BOAT_ENTER_HINT_TEXT",&"BETRAYAL_BOAT_ENTER_HINT_TEXT_PC");
		var_02 = var_01 maps\_shg_utility::hint_button_position("use",var_01.origin + (0,0,25),undefined,200,undefined,var_01);
		level.obj_get_in_org = var_02.object.origin;
		var_01 waittill("trigger");
		soundscripts\_snd::snd_music_message("boat_chase_begin");
		common_scripts\utility::flag_set("docks_end_fail_state_monitor");
		maps\_player_exo::player_exo_deactivate();
		var_02 maps\_shg_utility::hint_button_clear();
		var_01 delete();
		level thread boat_scene_setup_spawn_swarm();
		var_03 = maps\betrayal_util::get_ent_by_targetname("animorg_boat_mount");
		var_04 = maps\_utility::spawn_anim_model("player_rig",var_03.origin,var_03.angles);
		var_04 attach("vm_grapple_launcher_base_lodvm","tag_weapon_right");
		var_04 hide();
		level.player maps\_shg_utility::setup_player_for_scene(1);
		var_05 = 0.5;
		level.player playerlinktoblend(var_04,"tag_player",var_05);
		level.player common_scripts\utility::delaycall(var_05,::playerlinktodelta,var_04,"tag_player",1,0,0,0,0,1);
		level.player enableslowaim();
		var_04 common_scripts\utility::delaycall(var_05,::show);
		var_06 = [var_04,level.player_boat];
		common_scripts\utility::delay_script_call(3,::common_scripts\utility::flag_set,"flag_dialogue_boat_grapple");
		thread play_grapple_anim(var_04);
		var_03 maps\_anim::anim_single(var_06,"boat_getin",undefined,undefined,undefined,1);
		wait(0.2);
		level.player unlink();
		var_04 delete();
		if(level.currentgen)
		{
			maps\_utility::tff_sync();
		}

		level.player maps\_shg_utility::setup_player_for_gameplay();
		level.player_boat makeusable();
		maps\betrayal_util::start_player_diveboat_ride();
		level.player_boat makeunusable();
		level.player disableslowaim();
		level.player allowcrouch(0);
		level.player allowprone(0);
		level.player_boat thread boat_scene_drive_tutorial();
		maps\_utility::autosave_by_name();
	}

	if(level.nextgen)
	{
		setsaveddvar("r_umbraAccurateOcclusionThreshold","1024");
	}

	level.player_boat vehphys_enablecrashing();
	common_scripts\utility::flag_set("flag_objective_boat_chase_start");
	common_scripts\utility::flag_set("flag_boat_start_bobbing_boats");
	level.player setclutforplayer("clut_betrayal_c3_01",5);
	level.ilana.ignoreall = 1;
	level.ilana forceteleport(level.player_boat gettagorigin("tag_passenger"),level.player_boat gettagangles("tag_passenger"));
	level.ilana linkto(level.player_boat,"tag_passenger",(0,0,-100),(0,0,0));
	level.ilana hide();
	boat_scene_setup();
	common_scripts\utility::flag_set("flag_boat_player_in_boat");
	wait(0.05);
	boat_scene_crash_moment();
	common_scripts\utility::flag_set("boat_crash_lighting");
	maps\_utility::trigger_wait_targetname("trigger_boat_crashed_in_building");
	level.player allowcrouch(1);
	level.player allowprone(1);
	level.player boat_scene_hide_warning_elem();
	if(level.nextgen)
	{
		setsaveddvar("r_umbraAccurateOcclusionThreshold","256");
	}

	wait(0.05);
	maps\betrayal_util::move_player_to_ent_by_targetname("start_climb_player");
	level.ilana show();
	level.ilana unlink();
	level.ilana maps\betrayal_util::move_squad_member_to_ent_by_targetname("start_climb_ilana");
	level.ilana maps\_utility::set_goal_pos(level.ilana.origin);
	wait(0.05);
	boat_scene_cleanup();
	level thread climb_scene_master_handler();
}

//Function Number: 267
boat_scene_early_setup()
{
	if(common_scripts\utility::flag("flag_boat_early_setup_complete"))
	{
		return;
	}

	common_scripts\utility::flag_set("flag_boat_early_setup_complete");
	if(!isdefined(level.player_boat))
	{
		level.player_boat = maps\_vehicle::spawn_vehicle_from_targetname("vehicle_player_boat");
	}

	level.player_boat vehphys_disablecrashing();
	level.player_boat.animname = "player_boat";
	level.player_boat useanimtree(#animtree);
	level thread boat_scene_early_setup_start_bobbing_boats();
	level.player setclientomnvar("ui_diveboat",1);
}

//Function Number: 268
boat_scene_swap_to_grapple_body(param_00)
{
	param_00 setmodel("viewbody_atlas_military_smp_grapple");
}

//Function Number: 269
boat_scene_early_setup_start_bobbing_boats()
{
	common_scripts\utility::flag_wait("flag_boat_start_bobbing_boats");
	common_scripts\utility::array_thread(maps\betrayal_util::get_ents_by_targetname("civilian_yacht_01"),::boat_scene_bobbing_obstacle);
	common_scripts\utility::array_thread(maps\betrayal_util::get_ents_by_targetname("civilian_yacht_01"),::maps\betrayal_fx::boat_small_static_foam);
	common_scripts\utility::array_thread(maps\betrayal_util::get_ents_by_targetname("civilian_yacht_02"),::boat_scene_bobbing_obstacle);
	common_scripts\utility::array_thread(maps\betrayal_util::get_ents_by_targetname("civilian_yacht_02"),::maps\betrayal_fx::boat_small_static_foam);
	common_scripts\utility::array_thread(maps\betrayal_util::get_ents_by_targetname("civilian_yacht_03"),::boat_scene_bobbing_obstacle);
	common_scripts\utility::array_thread(maps\betrayal_util::get_ents_by_targetname("civilian_yacht_03"),::maps\betrayal_fx::boat_small_static_foam);
	common_scripts\utility::array_thread(maps\betrayal_util::get_ents_by_targetname("civilian_boat_02"),::boat_scene_bobbing_obstacle);
	common_scripts\utility::array_thread(maps\betrayal_util::get_ents_by_targetname("civilian_boat_02"),::maps\betrayal_fx::boat_small_static_foam);
	common_scripts\utility::array_thread(maps\betrayal_util::get_ents_by_targetname("civilian_barge_01"),::boat_scene_bobbing_obstacle);
	common_scripts\utility::array_thread(maps\betrayal_util::get_ents_by_targetname("civilian_barge_01"),::maps\betrayal_fx::boat_large_static_foam);
	common_scripts\utility::array_thread(maps\betrayal_util::get_ents_by_targetname("civilian_taxi_01"),::boat_scene_bobbing_obstacle);
	common_scripts\utility::array_thread(maps\betrayal_util::get_ents_by_targetname("civilian_taxi_01"),::maps\betrayal_fx::boat_small_static_foam);
}

//Function Number: 270
boat_scene_setup()
{
	level.player_boat thread boat_scene_boat_warning_system();
	level.player_boat thread maps\betrayal_fx::vm_boat_wake();
	level thread maps\betrayal_lighting::underwater_boat_visionset_change();
	maps\betrayal_util::add_spawn_function_to_noteworthy("spawner_boat_chase_ai",::maps\betrayal_util::remove_on_spawner_delete);
	maps\betrayal_util::add_spawn_function_to_noteworthy("spawner_boat_chase_ai",::maps\betrayal_util::allow_boost_jump);
	common_scripts\utility::run_thread_on_targetname("trigger_boat_start_moving_obstacle",::boat_scene_moving_obstacle);
	common_scripts\utility::array_call(maps\betrayal_util::get_ents_by_targetname("hidden_water_ramp"),::hide);
	common_scripts\utility::run_thread_on_targetname("trigger_boat_raise_canal_blocker",::boat_scene_raise_canal_blocker);
	maps\betrayal_util::add_spawn_function_to_noteworthy("spawner_boat_chase_warbird",::maps\betrayal_util::warbird_shooting_think,0,0);
	maps\betrayal_util::add_spawn_function_to_noteworthy("spawner_boat_chase_warbird",::boat_scene_heli_change_paths);
	maps\betrayal_util::add_spawn_function_to_noteworthy("spawner_boat_chase_warbird",::maps\betrayal_util::remove_on_spawner_delete);
	maps\betrayal_util::add_spawn_function_to_noteworthy("spawner_boat_chase_warbird",::soundscripts\_snd::snd_message,"aud_ambient_helicopter","spawner_boat_chase_warbird");
	level thread boat_scene_setup_spawn_swarm();
	common_scripts\utility::run_thread_on_targetname("trigger_boat_bridge_collapse",::maps\betrayal_fx::boat_scene_bridge_collapse);
	boat_scene_vig_civ_setup();
	common_scripts\utility::flag_clear("flag_enable_battle_chatter");
}

//Function Number: 271
boat_scene_setup_spawn_swarm()
{
	if(!isdefined(level.snake_cloud))
	{
		if(level.currentgen)
		{
			level.snake_cloud = vehicle_scripts\_attack_drone_common::spawn_snake_cloud("drone_swarm_spawner_boat",undefined,6,5);
			return;
		}

		level.snake_cloud = vehicle_scripts\_attack_drone_common::spawn_snake_cloud("drone_swarm_spawner_boat",undefined,16,12);
	}
}

//Function Number: 272
boat_scene_heli_change_paths()
{
	common_scripts\utility::run_thread_on_targetname(self.target,::boat_scene_heli_change_paths_on_trigger,self);
}

//Function Number: 273
boat_scene_heli_change_paths_on_trigger(param_00)
{
	self waittill("trigger");
	var_01 = common_scripts\utility::getstruct(self.target,"targetname");
	param_00 thread maps\_vehicle::vehicle_paths(var_01,0);
	param_00 thread maps\_utility::ent_flag_clear_delayed("fire_turrets",2);
}

//Function Number: 274
boat_scene_raise_canal_blocker()
{
	maps\betrayal_util::prepare_blast_doors(self.target,-160);
	self waittill("trigger");
	maps\betrayal_util::raise_blast_doors(self.target,1);
}

//Function Number: 275
boat_scene_vig_civ_setup()
{
	if(level.nextgen)
	{
		common_scripts\utility::run_thread_on_targetname("trigger_vig_civ_setup",::maps\betrayal_util::civilian_setup,1200,1);
	}
}

//Function Number: 276
boat_scene_crash_moment()
{
	common_scripts\utility::run_thread_on_targetname("trigger_boat_disable_dive",::boat_scene_disable_dive);
	maps\_utility::trigger_wait_targetname("trigger_boat_start_crash");
	soundscripts\_snd::snd_message("bet_boat_crash_audio_handler");
	var_00 = maps\betrayal_util::get_ent_by_targetname("animorg_boat_crash");
	var_01 = maps\_utility::spawn_anim_model("player_rig_grapple",level.player.origin,level.player.angles);
	var_02 = level.player_boat;
	var_03 = [var_01,var_02];
	thread maps\betrayal_fx::vm_boat_crash_se_fx_start(var_02);
	level.player_boat makeusable();
	level.player_boat vehicle_scripts\_diveboat::remove_diveboat_weapons();
	level.player_boat vehicle_scripts\_diveboat::stop_diveboat_threads();
	level.player.drivingvehicle = undefined;
	level.player_boat useby(level.player);
	level.player_boat makeunusable();
	level.player_boat setviewmodeldepth(0);
	level.player maps\_shg_utility::setup_player_for_scene();
	level.player playerlinktodelta(var_01,"tag_player",1,7,7,5,5,1);
	common_scripts\utility::flag_set("flag_objective_boat_chase_complete");
	var_00 maps\_anim::anim_single(var_03,"boat_crash");
	level notify("boat_crash_end");
	level.player unlink();
	var_01 delete();
}

//Function Number: 277
boat_scene_disable_dive()
{
	level.player_boat endon("death");
	level endon("boat_scene_cleanup");
	while(!isdefined(level.player_boat))
	{
		wait(0.05);
	}

	for(;;)
	{
		if(self istouching(level.player))
		{
			level.player_boat vehicle_diveboatenabledive(0);
		}
		else
		{
			level.player_boat vehicle_diveboatenabledive(1);
		}

		wait(0.05);
	}
}

//Function Number: 278
boat_scene_crash_moment_whiteout(param_00)
{
	maps\betrayal_util::player_knockout_white();
	if(level.currentgen)
	{
		common_scripts\utility::flag_set("flag_tff_trans_canals_to_finale");
	}
}

//Function Number: 279
boat_scene_boat_warning_system()
{
	level endon("boat_scene_cleanup");
	self endon("death");
	boat_scene_prep_water_impacts();
	childthread boat_scene_monitor_boat_params();
	childthread boat_scene_missile_dive_warning();
	childthread boat_scene_prep_drones();
	childthread boat_scene_handle_boat_collisions();
	childthread boat_scene_handle_boat_damage();
	childthread boat_scene_handle_fail_state();
	var_00 = 0;
	for(;;)
	{
		if(isdefined(self.dive_boat_params.dive_warning) && !var_00)
		{
			level.player boat_scene_show_warning_elem(self.dive_boat_params.dive_warning);
			var_00 = 1;
			common_scripts\utility::flag_set("flag_incoming_missile_warning");
		}
		else if(!isdefined(self.dive_boat_params.dive_warning) && var_00)
		{
			level.player boat_scene_hide_warning_elem();
			self.dive_boat_params.dive_warning = undefined;
			var_00 = 0;
		}

		wait(0.05);
	}
}

//Function Number: 280
boat_scene_monitor_boat_params()
{
	maps\_utility::ent_flag_init("dive_boat_params_underwater");
	var_00 = self.angles;
	self.dive_boat_params = spawnstruct();
	for(;;)
	{
		wait(0.05);
		var_01 = anglestoforward(self.angles);
		self.dive_boat_params.fwd_dir = (var_01[0],var_01[1],0);
		var_02 = self.angles - var_00;
		var_03 = self vehicle_getspeed() / self vehicle_gettopspeed() * 7;
		self.dive_boat_params.yawdiff = var_03 * var_02[1];
		var_04 = rotatevector(var_01,(0,var_03 * var_02[1],0));
		self.dive_boat_params.fwd_aug = (var_04[0],var_04[1],0);
		self.dive_boat_params.upsspeed = max(maps\betrayal_util::mph_to_ups(self vehicle_getspeed()),maps\betrayal_util::mph_to_ups(5));
		var_05 = anglestoright(self.angles);
		self.dive_boat_params.right = (var_05[0],var_05[1],0);
		if(self vehicle_diveboatissubmerged())
		{
			maps\_utility::ent_flag_set("dive_boat_params_underwater");
		}
		else
		{
			maps\_utility::ent_flag_clear("dive_boat_params_underwater");
		}

		self notify("dive_boat_params_updated");
		if(getdvarint("debug_diveboat_params") == 1)
		{
		}

		var_00 = self.angles;
	}
}

//Function Number: 281
boat_scene_show_warning_elem(param_00)
{
	if(isdefined(param_00) && param_00 == "collision")
	{
		level.player setclientomnvar("ui_diveboat_msg",1);
	}
	else if(isdefined(param_00) && param_00 == "missile")
	{
		level.player setclientomnvar("ui_diveboat_msg",2);
	}

	level.player thread boat_scene_cleanup_warning_elem_on_crash();
}

//Function Number: 282
boat_scene_cleanup_warning_elem_on_crash()
{
	self endon("death");
	level waittill("boat_scene_cleanup");
	boat_scene_hide_warning_elem();
}

//Function Number: 283
boat_scene_hide_warning_elem()
{
	level.player setclientomnvar("ui_diveboat_msg",0);
}

//Function Number: 284
boat_scene_missile_dive_warning()
{
	var_00 = maps\betrayal_util::get_ents_by_targetname("trigger_boat_fire_missile");
	foreach(var_02 in var_00)
	{
		childthread boat_scene_fire_missile_at_boat(var_02);
	}

	childthread boat_scene_target_lock_sound();
}

//Function Number: 285
boat_scene_play_target_lock_sound_loop(param_00)
{
	level.player endon("damage");
	var_01 = 0;
	while(var_01 < param_00 && !self vehicle_diveboatissubmerged())
	{
		soundscripts\_snd::snd_message("lock_on_target");
		wait(0.35);
		var_01 = var_01 + 0.35;
	}
}

//Function Number: 286
boat_scene_target_lock_sound()
{
	level endon("boat_scene_cleanup");
	for(;;)
	{
		common_scripts\utility::flag_wait("flag_incoming_missile_warning");
		thread boat_scene_play_target_lock_sound_loop(10);
		if(!self vehicle_diveboatissubmerged())
		{
			common_scripts\utility::flag_set("flag_dialogue_boat_missiles");
		}

		common_scripts\utility::flag_clear("flag_incoming_missile_warning");
	}
}

//Function Number: 287
boat_scene_fire_missile_at_boat(param_00)
{
	param_00 waittill("trigger");
	if(maps\_utility::ent_flag("dive_boat_params_underwater"))
	{
		boat_scene_missile_wait_for_player_to_surface();
	}

	if(maps\_utility::ent_flag("dive_boat_params_underwater"))
	{
		return;
	}

	if(isdefined(self.dive_boat_params.dive_warning))
	{
		return;
	}

	self.dive_boat_params.dive_warning = "missile";
	var_01 = 1.25;
	var_02 = randomintrange(5,9);
	thread boat_scene_missile_launch_volley(var_02,var_01);
	maps\_utility::ent_flag_wait_or_timeout("dive_boat_params_underwater",1.5);
	self.dive_boat_params.dive_warning = undefined;
}

//Function Number: 288
boat_scene_missile_wait_for_player_to_surface()
{
	var_00 = gettime();
	while(isdefined(self))
	{
		if(!maps\_utility::ent_flag("dive_boat_params_underwater"))
		{
			break;
		}

		if(gettime() >= var_00 + 2000)
		{
			break;
		}

		wait(0.05);
	}
}

//Function Number: 289
boat_scene_missile_launch_volley(param_00,param_01,param_02)
{
	maps\_utility::ent_flag_wait_or_timeout("dive_boat_params_underwater",1.5);
	if(isdefined(param_02))
	{
		wait(param_02);
	}

	var_03 = 150 * param_00 - 1;
	for(var_04 = param_00;var_04 > 0;var_04--)
	{
		if(var_04 == 1)
		{
			childthread boat_scene_missile_flight(var_03,1);
		}
		else
		{
			childthread boat_scene_missile_flight(var_03);
		}

		var_03 = var_03 - 150;
		wait(randomfloatrange(0.05,0.1));
	}
}

//Function Number: 290
boat_scene_missile_flight(param_00,param_01)
{
	var_02 = 0.25 * self.dive_boat_params.upsspeed * self.dive_boat_params.fwd_aug;
	var_03 = param_00 * self.dive_boat_params.fwd_aug;
	var_04 = (0,randomfloatrange(-12.5,12.5),0);
	var_05 = rotatevector(var_02 + var_03,var_04);
	var_06 = self.origin + var_05;
	var_07 = undefined;
	for(var_08 = 0;var_08 < 5;var_08++)
	{
		var_09 = (randomfloatrange(0,20),0,0);
		var_0A = (0,randomfloatrange(0,360),0);
		var_09 = rotatevector(var_09,var_0A);
		var_0B = var_06 + var_09;
		var_0C = bullettrace(var_0B + (0,0,500),var_0B + (0,0,-100),0,undefined,0,0,0,0,0);
		if(isdefined(var_0C["surfacetype"]) && issubstr(var_0C["surfacetype"],"water"))
		{
			var_07 = var_0C["position"];
			break;
		}
	}

	if(!isdefined(var_07))
	{
		return;
	}

	var_0D = common_scripts\utility::spawn_tag_origin();
	var_0D.origin = var_07;
	var_0D.angles = (270,0,0);
	var_0E = 600;
	var_0F = magicbullet("iw5_mahemcustombetrayalboatdive_sp",var_0D.origin + (0,0,var_0E),var_0D.origin);
	wait(0.25);
	playfxontag(level._effect["bet_water_explosion_single"],var_0D,"tag_origin");
	boat_scene_spawn_water_impact(var_0D.origin);
	var_0D playrumbleonentity("grenade_rumble");
	if(isdefined(param_01))
	{
		boat_scene_missile_impact_damage_boat(var_0D.origin);
	}

	wait(2);
	var_0D delete();
}

//Function Number: 291
boat_scene_missile_impact_damage_boat(param_00)
{
	if(maps\_utility::ent_flag("dive_boat_params_underwater"))
	{
		return;
	}

	physicsexplosionsphere(param_00,256,0,3);
	level.player dodamage(200,param_00);
	wait(0.5);
	if(level.player.health <= 0)
	{
		setdvar("ui_deadquote",&"BETRAYAL_BOAT_MISSILE_FAIL");
	}
}

//Function Number: 292
boat_scene_prep_drones()
{
	common_scripts\utility::run_thread_on_targetname("trigger_boat_drone_swarm_start",::maps\betrayal_util::drone_swarm_move_change_path_on_trigger);
}

//Function Number: 293
boat_scene_prep_water_impacts()
{
	level.water_impacts = maps\betrayal_util::get_ents_by_targetname("boat_water_impact");
}

//Function Number: 294
boat_scene_spawn_water_impact(param_00)
{
	foreach(var_02 in level.water_impacts)
	{
		if(!isdefined(var_02.in_use))
		{
			if(!isdefined(var_02.org_pos))
			{
				var_02 hide();
				var_02.org_pos = var_02.origin;
			}

			var_03 = bullettrace(param_00 + (0,0,-64),param_00 + (0,0,512),0,undefined);
			if(var_03["surfacetype"] == "water_waist")
			{
				param_00 = var_03["position"];
			}

			var_02.in_use = 1;
			var_02.origin = param_00;
			var_02 thread boat_scene_remove_water_impact();
			return;
		}
	}
}

//Function Number: 295
boat_scene_remove_water_impact()
{
	wait(0.5);
	self.origin = self.org_pos;
	self.in_use = undefined;
	self hide();
}

//Function Number: 296
boat_scene_moving_obstacle()
{
	level endon("boat_scene_cleanup");
	var_00 = maps\betrayal_util::get_ents_by_targetname(self.target);
	self.spawned_boats = [];
	foreach(var_02 in var_00)
	{
		thread boat_scene_moving_obstacle_spawn_boat_in_radius(var_02);
	}

	self waittill("trigger");
	foreach(var_05 in self.spawned_boats)
	{
		var_05 thread maps\_vehicle::gopath(var_05);
		if(issubstr(var_05.model,"watertaxi_01"))
		{
			level thread maps\betrayal_fx::treadfx_ai_boats_taxi(var_05);
			continue;
		}

		level thread maps\betrayal_fx::treadfx_ai_boats_yacht(var_05);
	}
}

//Function Number: 297
boat_scene_moving_obstacle_spawn_boat_in_radius(param_00)
{
	level endon("boat_scene_cleanup");
	self endon("death");
	self endon("trigger");
	if(!isdefined(param_00.radius))
	{
		param_00.radius = 5000;
	}

	for(;;)
	{
		if(!isdefined(param_00) || isremovedentity(param_00))
		{
			return;
		}

		var_01 = distance2d(param_00.origin,level.player.origin);
		if(var_01 < param_00.radius)
		{
			var_02 = maps\_vehicle_code::_vehicle_spawn(param_00);
			if(!isdefined(var_02))
			{
				return;
			}

			param_00 thread boat_scene_moving_obstacle_delete_boat_on_spawner_death(var_02);
			self.spawned_boats[self.spawned_boats.size] = var_02;
			return;
		}

		wait(0.05);
	}
}

//Function Number: 298
boat_scene_moving_obstacle_delete_boat_on_spawner_death(param_00)
{
	level endon("boat_scene_cleanup");
	param_00.script_linkname = undefined;
	self waittill("death");
	if(isdefined(param_00) && !isremovedentity(param_00))
	{
		param_00 delete();
	}
}

//Function Number: 299
boat_scene_bobbing_obstacle(param_00)
{
	level endon("boat_scene_cleanup");
	self endon("death");
	if(!isdefined(param_00))
	{
		param_00 = maps\betrayal_util::get_ent_by_targetname(self.target);
		param_00 linkto(self);
	}

	maps\_utility::ent_flag_init("flag_big_bobbing");
	for(;;)
	{
		var_01 = boat_scene_small_bob_settings();
		maps\_bobbing_boats::prep_bobbing([self],::maps\_bobbing_boats::bobbingobject,var_01,0);
		thread maps\_bobbing_boats::start_bobbing_single(randomfloatrange(0,1));
		maps\_utility::ent_flag_wait("flag_big_bobbing");
		var_01 = boat_scene_big_bob_settings();
		maps\_bobbing_boats::prep_bobbing([self],::maps\_bobbing_boats::bobbingobject,var_01,0);
		thread maps\_bobbing_boats::start_bobbing_single(randomfloatrange(0,1));
		maps\_utility::ent_flag_waitopen("flag_big_bobbing");
	}
}

//Function Number: 300
boat_scene_small_bob_settings()
{
	var_00 = spawnstruct();
	var_00.max_pitch = 1;
	var_00.min_pitch_period = 3;
	var_00.max_pitch_period = 6;
	var_00.max_yaw = 2;
	var_00.min_yaw_period = 3;
	var_00.max_yaw_period = 6;
	var_00.max_roll = 2;
	var_00.min_roll_period = 3;
	var_00.max_roll_period = 6;
	var_00.max_sink = 6;
	var_00.max_float = 6;
	var_00.min_bob_period = 3;
	var_00.max_bob_period = 6;
	return var_00;
}

//Function Number: 301
boat_scene_big_bob_settings()
{
	var_00 = spawnstruct();
	var_00.max_pitch = 3;
	var_00.min_pitch_period = 3;
	var_00.max_pitch_period = 6;
	var_00.max_yaw = 0;
	var_00.min_yaw_period = 3;
	var_00.max_yaw_period = 6;
	var_00.max_roll = 6;
	var_00.min_roll_period = 3;
	var_00.max_roll_period = 6;
	var_00.max_sink = 36;
	var_00.max_float = 24;
	var_00.min_bob_period = 3;
	var_00.max_bob_period = 6;
	return var_00;
}

//Function Number: 302
boat_scene_drive_tutorial()
{
	thread boat_scene_drive_gas_tutorial();
	thread boat_scene_dive_tutorial();
}

//Function Number: 303
boat_scene_drive_gas_tutorial()
{
	level endon("boat_scene_cleanup");
	self waittill("dive_boat_params_updated");
	maps\_utility::hintdisplayhandler("boat_gas");
	if(isdefined(level.current_hint))
	{
		level.current_hint waittill("destroying");
	}
}

//Function Number: 304
boat_scene_dive_tutorial(param_00)
{
	level endon("boat_scene_cleanup");
	common_scripts\utility::run_thread_on_targetname("trigger_boat_hint_dive",::boat_scene_dive_tutorial_trigger_hit);
	for(;;)
	{
		level waittill("display_boat_dive_hint",var_01);
		if(!maps\_utility::ent_flag("dive_boat_params_underwater"))
		{
			maps\_utility::hintdisplayhandler("boat_dive",undefined,var_01);
			if(isdefined(level.current_hint))
			{
				level.current_hint waittill("destroying");
			}
		}

		var_01 delete();
	}
}

//Function Number: 305
boat_scene_dive_tutorial_trigger_hit()
{
	level endon("boat_scene_cleanup");
	self waittill("trigger");
	common_scripts\utility::flag_set("flag_dialogue_boat_dive");
	level notify("display_boat_dive_hint",self);
}

//Function Number: 306
boat_scene_handle_boat_collisions()
{
	for(;;)
	{
		self waittill("veh_contact",var_00,var_01);
		if(self vehicle_getspeed() > 15)
		{
			level.player dodamage(20,var_01);
			level.player playrumbleonentity("damage_heavy");
		}

		wait(0.05);
	}
}

//Function Number: 307
boat_scene_handle_boat_damage()
{
	for(;;)
	{
		self waittill("damage",var_00,var_01,var_02,var_03);
		if(randomint(100) < 5)
		{
			level.player dodamage(var_00 * 0.02,var_03,var_01);
			level.player playrumbleonentity("damage_light");
		}

		maps\_vehicle::vehicle_set_health(2000);
		wait(0.05);
	}
}

//Function Number: 308
boat_scene_handle_fail_state()
{
	var_00 = maps\betrayal_util::get_ents_by_targetname("trigger_boat_path_fail");
	common_scripts\utility::array_thread(var_00,::boat_scene_trigger_fail_path);
	var_01 = maps\betrayal_util::progress_path_create("boat_chase_fail_path");
	var_02 = var_01 maps\betrayal_util::progress_path_get_my_node_from_org(level.player.origin);
	var_03 = gettime();
	var_04 = var_02;
	var_05 = 0;
	for(;;)
	{
		if(gettime() > var_03 + 7000)
		{
			boat_scene_fail_path();
			break;
		}

		var_06 = maps\betrayal_util::get_progression_between_points(level.player.origin,var_02.origin,var_02.next_node.origin);
		var_07 = maps\betrayal_util::progress_path_move_to_correct_node(var_02,var_06["progress"],var_06["offset"]);
		var_08 = var_07.progress;
		var_09 = var_07.offset;
		var_02 = var_07.node;
		if(var_02 == var_04.next_node)
		{
			var_03 = gettime();
			var_04 = var_02;
			var_05 = var_08;
		}

		if(var_02 == var_04 && var_08 >= var_05 + 5)
		{
			var_03 = gettime();
			var_04 = var_02;
			var_05 = var_08;
		}

		wait(0.05);
	}
}

//Function Number: 309
boat_scene_trigger_fail_path()
{
	self waittill("trigger");
	boat_scene_fail_path();
}

//Function Number: 310
boat_scene_fail_path()
{
	setdvar("ui_deadquote",&"BETRAYAL_FAIL_ESCAPE");
	maps\_utility::missionfailedwrapper();
}

//Function Number: 311
boat_scene_cleanup()
{
	level.player setclientomnvar("ui_diveboat",0);
	level notify("boat_scene_cleanup");
}

//Function Number: 312
climb_scene_master_handler(param_00)
{
	climb_scene_setup();
	if(level.nextgen)
	{
		thread maps\betrayal_util::spawn_and_handle_looping_helicopters("climb_scene_vignette_heli","flag_climb_player_at_finale",5);
	}
	else
	{
		thread maps\betrayal_util::spawn_and_handle_looping_helicopters("climb_scene_vignette_heli","flag_climb_player_at_finale",2);
	}

	if(!isdefined(param_00))
	{
		wait(0.05);
		level.ilana.ignoreall = 0;
		level.ilana.pacifist = 1;
		level thread climb_scene_setup_droneswarm();
		climb_scene_first_climb();
		climb_scene_on_foot();
		climb_scene_second_climb();
		climb_scene_skybridge();
	}
	else if(isdefined(param_00) && param_00 == "roof")
	{
		common_scripts\utility::flag_clear("flag_enable_battle_chatter");
		common_scripts\utility::flag_set("flag_climb_player_begin_fall_fails");
		common_scripts\utility::flag_set("flag_climb_player_at_first_onfoot");
		climb_scene_on_foot();
		climb_scene_second_climb();
		climb_scene_skybridge();
	}
	else if(isdefined(param_00) && param_00 == "crates")
	{
		common_scripts\utility::flag_set("flag_climb_player_begin_fall_fails");
		common_scripts\utility::flag_set("flag_climb_player_at_first_onfoot");
		climb_scene_second_climb();
		climb_scene_skybridge();
	}
	else if(isdefined(param_00) && param_00 == "skybridge")
	{
		common_scripts\utility::flag_set("flag_climb_player_begin_fall_fails");
		common_scripts\utility::flag_set("flag_climb_player_at_first_onfoot");
		common_scripts\utility::flag_set("flag_climb_player_at_skybridge");
		climb_scene_skybridge();
	}
	else if(isdefined(param_00) && param_00 == "finale_outro")
	{
		level thread climb_scene_finale();
	}

	common_scripts\utility::flag_wait("flag_climb_player_at_finale");
	climb_scene_cleanup();
}

//Function Number: 313
climb_scene_setup()
{
	maps\_utility::clear_all_color_orders("axis");
	maps\_utility::clear_all_color_orders("allies");
	common_scripts\utility::flag_set("flag_dialogue_start_climb");
	level.ilana setmodel("ilana_atlas_pmc_launcher");
	common_scripts\utility::run_thread_on_targetname("finale_climb_civ_setup",::maps\betrayal_util::civilian_setup,"flag_climb_player_discovered",0);
	maps\_utility::activate_trigger_with_targetname("finale_climb_civ_setup");
	common_scripts\utility::run_thread_on_targetname("climbimg_moving_crate_on_foot_start_node",::climb_scene_moving_crates);
	common_scripts\utility::run_thread_on_targetname("climbimg_moving_crate_construction_ambience_start_node",::climb_scene_moving_crates);
	common_scripts\utility::run_thread_on_targetname("climbimg_moving_crate_climb_ambience_start_node",::climb_scene_moving_crates);
	common_scripts\utility::run_thread_on_targetname("trigger_climb_force_dismount",::climb_scene_force_dismount);
	maps\betrayal_util::add_spawn_function_to_noteworthy("climb_warbird",::maps\betrayal_util::warbird_shooting_think,0,0);
	maps\betrayal_util::add_spawn_function_to_noteworthy("spawner_skybridge_guard",::climb_scene_set_colors_careful_on_arrival_setting);
	common_scripts\utility::run_thread_on_targetname("trigger_climb_start_crane",::climb_scene_start_crane);
	common_scripts\utility::run_thread_on_targetname("trigger_skybridge_break_glass",::climb_scene_skybridge_break_glass);
	level thread climb_scene_ilona_simple_climbing();
	level.ilana.script_careful = 1;
	level.ilana pathabilityadd("grapple");
	level.ilana maps\_utility::set_moveplaybackrate(1);
	common_scripts\utility::run_thread_on_targetname("trigger_climb_fail_trigger",::climb_scene_fail_fall);
	maps\_exo_climb::setup_climb_model("atlas_army",1);
	foreach(var_01 in level.player getweaponslistoffhands())
	{
		if(common_scripts\utility::array_contains(level.player.variable_grenade["special"],var_01))
		{
			level.player takeweapon(var_01);
		}
	}

	common_scripts\utility::flag_clear("flag_hint_player_exoclimb_jumped");
	common_scripts\utility::flag_clear("flag_hint_player_exoclimb_magmoved");
	common_scripts\utility::flag_clear("flag_hint_player_exoclimb_combat");
	common_scripts\utility::flag_clear("flag_hint_player_exoclimb_cover");
}

//Function Number: 314
climb_scene_setup_droneswarm()
{
	if(!isdefined(level.snake_cloud))
	{
		if(level.currentgen)
		{
			level.snake_cloud = vehicle_scripts\_attack_drone_common::spawn_snake_cloud("drone_swarm_spawner_climb",undefined,6,5);
		}
		else
		{
			level.snake_cloud = vehicle_scripts\_attack_drone_common::spawn_snake_cloud("drone_swarm_spawner_climb");
		}
	}

	common_scripts\utility::run_thread_on_targetname("trigger_climb_drone_swarm_start",::maps\betrayal_util::drone_swarm_move_change_path_on_trigger);
	maps\_utility::trigger_wait_targetname("trigger_climb_drone_swarm_cleanup");
	level.snake_cloud vehicle_scripts\_attack_drone_common::cleanup_snake_cloud();
}

//Function Number: 315
climb_scene_cleanup()
{
	level notify("climb_scene_cleanup");
}

//Function Number: 316
climb_scene_start_action(param_00)
{
	wait(4);
	level notify("climb_scene_start_action");
}

//Function Number: 317
climb_scene_fail_fall()
{
	var_00 = level.player.grapple["dist_max"];
	for(;;)
	{
		wait(0.05);
		for(;;)
		{
			self waittill("trigger",var_01);
			if(var_01 == level.player)
			{
				break;
			}

			wait(0.05);
		}

		if(isdefined(level.player.grapple) && level.player.grapple["grappling"])
		{
			continue;
		}

		if(common_scripts\utility::flag("flag_climb_falling_fail"))
		{
			continue;
		}

		common_scripts\utility::flag_set("flag_climb_falling_fail");
		level.player.grapple["dist_max"] = 1;
		setblur(5,0.5);
		wait(0.25);
		if(isdefined(level.player.grapple) && level.player.grapple["grappling"])
		{
			common_scripts\utility::flag_clear("flag_climb_falling_fail");
			level.player.grapple["dist_max"] = var_00;
			setblur(0,0.25);
			continue;
		}

		break;
	}

	setdvar("ui_deadquote",&"BETRAYAL_CLIMB_FALL_FAIL");
	maps\_utility::missionfailedwrapper();
	level.player thread climb_scene_fail_on_ground_notify();
	level.player common_scripts\utility::waittill_any_timeout(1,"death","player_on_ground");
	if(isalive(level.player))
	{
		level.player kill();
	}

	wait(0.05);
	setdvar("ui_deadquote",&"BETRAYAL_CLIMB_FALL_FAIL");
}

//Function Number: 318
climb_scene_fail_on_ground_notify()
{
	level.player endon("death");
	for(;;)
	{
		if(level.player isonground())
		{
			level.player notify("player_on_ground");
		}

		wait(0.05);
	}
}

//Function Number: 319
climb_scene_first_climb()
{
	if(level.currentgen)
	{
		if(!istransientloaded("betrayal_finale_tr"))
		{
			level waittill("tff_post_canals_to_finale");
		}
	}

	maps\betrayal_util::player_knockout_wakeup();
	level thread climb_scene_anim_boat_getout();
	common_scripts\utility::flag_set("flag_dialogue_climb_boatexit");
	common_scripts\utility::delay_script_call(14,::common_scripts\utility::flag_set,"flag_dialogue_climb_intro");
	maps\_exo_climb::enable_exoclimb_combat(1);
	level waittill("climb_scene_start_action");
	level.ilana.ignoreall = 0;
}

//Function Number: 320
climb_scene_handle_finale_walker_civilian_vingette()
{
	var_00 = maps\betrayal_util::get_ents_by_targetname("climb_scene_walker_spawner");
	foreach(var_02 in var_00)
	{
		var_03 = var_02 maps\_utility::spawn_ai(1,0);
		var_03 thread climb_scene_handle_walker();
		var_03 thread climb_scene_handle_walker_reaction();
		var_03 thread maps\betrayal_util::delete_ai_on_flag("climb_delete_walkers");
	}
}

//Function Number: 321
climb_scene_handle_walker()
{
	self endon("reacting");
	self endon("death");
	self.original_position = self.origin;
	self.animname = "generic";
	var_00 = maps\betrayal_util::civilian_get_random_walk();
	self.civilian_walk_animation = var_00;
	self.runanim = level.scr_anim[self.animname][var_00][0];
	maps\_utility::set_run_anim_array(var_00,undefined,1);
	self.is_reacting = 0;
	self.goalradius = 16;
	for(;;)
	{
		if(isdefined(self.target))
		{
			var_01 = getnode(self.target,"targetname");
			maps\_utility::set_goal_node(var_01);
		}

		maps\betrayal_util::stop_current_animations();
		self.goalradius = 16;
		self notify("move");
		self waittill("goal");
		maps\betrayal_util::stop_current_animations();
		self.animname = "generic";
		var_00 = maps\betrayal_util::civilian_get_random_idle();
		thread maps\_anim::anim_generic_loop(self,var_00);
		wait(3);
		maps\_utility::set_goal_pos(self.original_position);
		maps\betrayal_util::stop_current_animations();
		self.goalradius = 16;
		self notify("move");
		self waittill("goal");
		maps\betrayal_util::stop_current_animations();
		self.animname = "generic";
		var_00 = maps\betrayal_util::civilian_get_random_idle();
		thread maps\_anim::anim_generic_loop(self,var_00);
		wait(3);
	}
}

//Function Number: 322
climb_scene_handle_walker_reaction()
{
	self endon("death");
	maps\betrayal_util::stop_current_animations();
	var_00 = getnodearray("climb_scene_walker_escape_node","targetname");
	common_scripts\utility::flag_wait("flag_climb_player_at_skybridge");
	if(isdefined(self))
	{
		self delete();
	}
}

//Function Number: 323
climb_scene_anim_boat_getout()
{
	level.player maps\_shg_utility::setup_player_for_scene();
	var_00 = maps\_utility::spawn_anim_model("player_rig_grapple",level.player.origin,level.player.angles);
	level.player playerlinktodelta(var_00,"tag_player",1,20,23,12,0,1);
	level.player enableslowaim();
	var_01 = maps\_utility::spawn_anim_model("player_boat",var_00.origin,var_00.angles);
	var_02 = [var_00,var_01,level.ilana];
	var_03 = maps\betrayal_util::get_ent_by_targetname("animorg_boat_getout");
	var_03 maps\_anim::anim_single(var_02,"boat_getout");
	level.player unlink();
	level.player disableslowaim();
	level.player maps\_shg_utility::setup_player_for_gameplay();
	maps\_player_exo::player_exo_activate();
	var_00 delete();
	maps\_utility::autosave_by_name();
	common_scripts\utility::flag_set("flag_objective_climb_start");
	level.player maps\_grapple::grapple_give();
	thread climb_scene_grapple_hint_handler();
	common_scripts\utility::flag_set("flag_enable_battle_chatter");
}

//Function Number: 324
climb_scene_grapple_hint_handler()
{
	var_00 = getentarray("grapple_hint_trig","targetname");
	var_01 = undefined;
	while(!isdefined(var_01))
	{
		foreach(var_03 in var_00)
		{
			if(level.player istouching(var_03))
			{
				maps\_utility::hintdisplayhandler("grapple");
				var_01 = var_03;
				break;
			}
		}

		wait 0.05;
	}

	while(level.player istouching(var_01))
	{
		wait(0.5);
	}

	wait(0.5);
	if(!common_scripts\utility::flag("flag_climb_player_finished_first_grapple"))
	{
		thread climb_scene_grapple_hint_handler();
	}
}

//Function Number: 325
climb_scene_on_foot()
{
	climb_scene_on_foot_setup();
	common_scripts\utility::flag_wait("flag_climb_player_at_first_onfoot");
	common_scripts\utility::flag_set("flag_enable_battle_chatter");
	level thread climb_scene_on_foot_warbird_arrival();
	level thread climb_scene_on_foot_crate_death_area();
}

//Function Number: 326
climb_scene_on_foot_setup()
{
	maps\betrayal_util::add_spawn_function_to_targetname("spawner_climb_onfoot_zipline",::climb_scene_setup_zipliners);
	maps\betrayal_util::add_spawn_function_to_noteworthy("climb_roof_enemies",::climb_scene_set_colors_careful_on_arrival_setting);
	maps\betrayal_util::add_spawn_function_to_noteworthy("climb_roof_snipers",::maps\betrayal_util::delete_ai_on_path_end);
	common_scripts\utility::run_thread_on_targetname("trigger_climb_ilana_past_crate",::climb_scene_on_foot_ilana_past_crate);
}

//Function Number: 327
climb_scene_on_foot_ilana_past_crate()
{
	level endon("flag_climb_ilana_past_crate");
	self waittill("trigger");
	for(;;)
	{
		if(maps\_utility::get_ai_group_sentient_count("climb_roof_guard") == 0)
		{
			break;
		}

		wait(0.05);
	}

	common_scripts\utility::flag_set("flag_climb_ilana_past_crate");
}

//Function Number: 328
climb_scene_on_foot_warbird_arrival()
{
	while(isdefined(level.climb_warbird))
	{
		wait(0.05);
	}

	level.climb_warbird = maps\_vehicle::spawn_vehicle_from_targetname_and_drive("spawner_climb_onfoot_heli");
	level.climb_warbird thread climb_scene_warbird_setup_rotar_death_trigger();
	level.climb_warbird soundscripts\_snd::snd_message("aud_ambient_helicopter","spawner_climb_onfoot_heli");
	level.climb_warbird thread climb_scene_first_on_foot_warbird_turret();
}

//Function Number: 329
climb_scene_warbird_setup_rotar_death_trigger()
{
	var_00 = getent("climb_scene_warbird_kill_trigger","script_noteworthy");
	var_00 enablelinkto();
	var_00 linkto(self);
	self waittill("death");
	var_00 unlink();
	var_00 delete();
}

//Function Number: 330
climb_scene_first_on_foot_warbird_turret()
{
	maps\_utility::ent_flag_init("start_roof_turrets");
	maps\_utility::ent_flag_wait("start_roof_turrets");
	while(maps\_utility::ent_flag("start_roof_turrets"))
	{
		wait(randomfloatrange(4,5.5));
		maps\_utility::ent_flag_set("fire_turrets");
		wait(randomfloatrange(2,3.5));
		maps\_utility::ent_flag_clear("fire_turrets");
	}
}

//Function Number: 331
climb_scene_on_foot_crate_death_area()
{
	var_00 = maps\betrayal_util::get_ent_by_targetname("climb_roof_path_blocker_for_crate_test");
	var_01 = getnodearray("climb_roof_crate_node","targetname");
	level thread climbing_scene_on_foot_no_friendly_damage_in_death_area();
	var_02 = 0;
	var_03 = 0;
	while(!common_scripts\utility::flag("flag_climb_player_at_skybridge"))
	{
		var_03 = 0;
		foreach(var_05 in level.climbing_crates)
		{
			if(var_05 istouching(var_00))
			{
				var_03 = 1;
				break;
			}
		}

		if(var_03 && !var_02)
		{
			var_02 = 1;
			foreach(var_08 in var_01)
			{
				var_08 disconnectnode();
			}

			continue;
		}

		if(!var_03 && var_02)
		{
			var_02 = 0;
			foreach(var_08 in var_01)
			{
				var_08 connectnode();
			}
		}

		wait(0.05);
	}
}

//Function Number: 332
climbing_scene_on_foot_no_friendly_damage_in_death_area()
{
	level endon("flag_climb_player_at_skybridge");
	var_00 = maps\betrayal_util::get_ent_by_targetname("trigger_climb_roof_no_pain");
	for(;;)
	{
		if(var_00 istouching(level.ilana))
		{
			level.ilana maps\_utility::disable_pain();
		}
		else
		{
			level.ilana maps\_utility::enable_pain();
		}

		wait(0.1);
	}
}

//Function Number: 333
climb_scene_second_climb()
{
	common_scripts\utility::flag_wait("flag_climb_player_at_second_climb");
	common_scripts\utility::flag_set("flag_enable_battle_chatter");
	level thread climb_scene_second_climb_ilona_no_push();
}

//Function Number: 334
climb_scene_second_climb_ilona_no_push()
{
	var_00 = maps\betrayal_util::get_ents_by_targetname("trigger_climb_no_push_ilana");
	while(!common_scripts\utility::flag("flag_climb_player_at_skybridge"))
	{
		var_01 = 0;
		foreach(var_03 in var_00)
		{
			if(level.ilana istouching(var_03))
			{
				var_01 = 1;
			}
		}

		if(var_01)
		{
			level.ilana.pushable = 0;
			level.ilana.script_pushable = 0;
			continue;
		}

		level.ilana.pushable = 1;
		level.ilana.script_pushable = 1;
		wait(0.05);
	}

	level.ilana.pushable = 1;
	level.ilana.script_pushable = 1;
}

//Function Number: 335
climb_scene_skybridge()
{
	common_scripts\utility::flag_wait("flag_climb_player_at_skybridge");
	common_scripts\utility::flag_set("flag_enable_battle_chatter");
	level.default_goalradius = 512;
	level thread climb_scene_skybridge_teleport_ilona();
	level.player_dof_aperture = 2;
	level.player_dof_max_distance = 250;
}

//Function Number: 336
climb_scene_skybridge_teleport_ilona()
{
	var_00 = maps\betrayal_util::get_ent_by_targetname("start_climbskybridge_ilana");
	while(!maps\betrayal_util::can_teleport_ai_to_pos(level.ilana,var_00.origin) || level.ilana check_is_climbing())
	{
		wait(0.05);
	}

	maps\_utility::activate_trigger_with_noteworthy("trigger_skybridge_break_glass_ilana");
	level.ilana maps\betrayal_util::move_squad_member_to_ent_by_targetname("start_climbskybridge_ilana");
}

//Function Number: 337
check_is_climbing()
{
	if(isdefined(self.istraversing))
	{
		return self.istraversing;
	}

	return 0;
}

//Function Number: 338
climb_scene_skybridge_break_glass()
{
	self waittill("trigger");
	var_00 = maps\betrayal_util::get_ent_by_targetname(self.target);
	glassradiusdamage(var_00.origin,200,100,50);
	level.player playrumbleonentity("damage_heavy");
}

//Function Number: 339
climb_scene_set_colors_careful_on_arrival_setting(param_00)
{
	self.colornode_setgoal_func = ::climb_scene_colors_careful_on_arrival;
	if(isdefined(param_00))
	{
		self.custom_careful_radius = param_00;
	}
}

//Function Number: 340
climb_scene_colors_careful_on_arrival(param_00)
{
	self endon("death");
	self setgoalnode(param_00);
	thread maps\_colors::color_node_arrival_notifies(param_00);
	self waittill("goal");
	self.fixednode = 0;
	if(isdefined(param_00.radius))
	{
		self.goalradius = param_00.radius;
		return;
	}

	if(isdefined(self.custom_careful_radius))
	{
		self.goalradius = self.custom_careful_radius;
		return;
	}

	self.goalradius = 1028;
}

//Function Number: 341
climb_scene_setup_zipliners()
{
	self endon("death");
	self.org_spawner = self.spawner;
	self.ignoreme = 1;
	self waittill("jumpedout");
	self.ignoreme = 0;
}

//Function Number: 342
climb_scene_force_dismount()
{
	level.climbing_ilona_teleported = 0;
	var_00 = maps\betrayal_util::get_ents_by_targetname("climb_mag_ilona_teleport");
	for(;;)
	{
		maps\betrayal_util::waittill_player_exo_climbing();
		self waittill("trigger");
		if(!maps\_exo_climb::is_exo_climbing())
		{
			continue;
		}

		if(isdefined(level.climbing_player_dismounting))
		{
			maps\betrayal_util::waittill_player_not_exo_climbing();
			continue;
		}

		level.climbing_player_dismounting = 1;
		var_01 = maps\betrayal_util::get_ent_by_targetname(self.target);
		maps\_exo_climb::force_animated_dismount(var_01,"player_rig","elevator_climb_dismount");
		maps\betrayal_util::waittill_player_not_exo_climbing();
		level.climbing_player_dismounting = undefined;
		while(!level.climbing_ilona_teleported)
		{
			var_02 = maps\_utility::get_farthest_ent(level.player.origin,var_00);
			if(maps\betrayal_util::can_teleport_ai_to_pos(level.ilana,var_02.origin))
			{
				level.ilana maps\betrayal_util::move_squad_member_to_ent(var_02);
				level.climbing_ilona_teleported = 1;
				break;
			}

			wait(0.05);
		}
	}
}

//Function Number: 343
climb_scene_ilona_simple_climbing()
{
	level endon("climb_scene_cleanup");
	for(;;)
	{
		while(!maps\_exo_climb::is_exo_climbing())
		{
			wait(1);
		}

		while(maps\_exo_climb::is_exo_climbing())
		{
			wait(0.05);
		}

		wait(0.05);
	}
}

//Function Number: 344
climb_scene_moving_crates()
{
	var_00 = maps\betrayal_util::get_ents_by_targetname(self.target);
	if(var_00.size <= 0)
	{
		return;
	}

	var_01 = 0;
	if(isdefined(self.script_delay))
	{
		var_01 = self.script_delay;
	}

	if(!isdefined(level.climbing_crates))
	{
		level.climbing_crates = [];
	}

	level.climbing_crates = common_scripts\utility::array_combine(level.climbing_crates,var_00);
	foreach(var_03 in var_00)
	{
		var_04 = maps\betrayal_util::get_ent_by_targetname(var_03.target);
		var_04 linkto(var_03);
		var_03.origin = self.origin;
		if(isdefined(self.angles))
		{
			var_03.angles = self.angles;
		}

		var_03.animname = "construction_crate";
		var_03 useanimtree(#animtree);
		var_03 hide();
	}

	climb_scene_preprocess_crate_path();
	for(;;)
	{
		var_06 = undefined;
		foreach(var_03 in var_00)
		{
			if(!isdefined(var_03.is_moving))
			{
				var_06 = var_03;
				break;
			}
		}

		if(isdefined(var_06))
		{
			var_06 thread climb_scene_move_crate_on_path(self);
			wait(randomfloatrange(var_01,var_01 + 2));
			continue;
		}

		wait(0.05);
	}
}

//Function Number: 345
climb_scene_preprocess_crate_path()
{
	if(isdefined(self.script_linkto))
	{
		var_00 = getent(self.script_linkto,"script_linkname");
		if(isdefined(var_00) && var_00.classname == "trigger_multiple")
		{
			self.climb_trigger = var_00;
			var_00 thread maps\_exo_climb::toggle_mount_mag_trigger_off();
		}
	}

	if(isdefined(self.target))
	{
		var_01 = common_scripts\utility::getstructarray(self.target,"targetname");
		foreach(var_03 in var_01)
		{
			var_03 climb_scene_preprocess_crate_path();
		}

		return;
	}
}

//Function Number: 346
climb_scene_move_crate_on_path(param_00)
{
	self show();
	self.is_moving = 1;
	soundscripts\_snd::snd_message("crate_path_start",self);
	var_01 = param_00.origin;
	var_02 = (0,0,0);
	if(isdefined(param_00.angles))
	{
		var_02 = param_00.angles;
	}

	var_03 = param_00;
	var_04 = undefined;
	var_05 = 1;
	for(;;)
	{
		if(isdefined(var_03.target))
		{
			var_06 = common_scripts\utility::getstructarray(var_03.target,"targetname");
			var_07 = [];
			if(isdefined(self.player_linked))
			{
				foreach(param_00 in var_06)
				{
					if(isdefined(param_00.script_parameters) && param_00.script_parameters == "player_path")
					{
						var_07 = common_scripts\utility::array_add(var_07,param_00);
					}

					if(isdefined(param_00.script_parameters) && param_00.script_parameters == "player_path_only")
					{
						var_07 = common_scripts\utility::array_add(var_07,param_00);
					}
				}
			}

			foreach(param_00 in var_06)
			{
				if(isdefined(param_00.script_parameters) && param_00.script_parameters == "player_path_only")
				{
					var_06 = common_scripts\utility::array_remove(var_06,param_00);
				}
			}

			if(var_07.size != 0)
			{
				var_04 = var_07[randomint(var_07.size)];
			}
			else
			{
				var_04 = var_06[randomint(var_06.size)];
			}
		}
		else
		{
			self hide();
			self.origin = var_01;
			self.angles = var_02;
			self.is_moving = undefined;
			return;
		}

		var_0C = 0;
		var_0D = 0;
		var_0E = 0;
		var_0F = undefined;
		if(isdefined(var_03.script_noteworthy))
		{
			if(var_03.script_noteworthy == "crate_transfer_point")
			{
				var_0C = 0.2;
				var_0E = 1;
			}

			if(var_03.script_noteworthy == "crate_mount_point")
			{
				var_0C = 0.2;
				var_0E = 4;
				var_0F = var_03.climb_trigger;
				var_0F thread maps\_exo_climb::toggle_mount_mag_trigger_on(self);
			}

			if(var_03.script_noteworthy == "crate_mount_point_stop")
			{
				wait(0.1);
				var_0F = var_03.climb_trigger;
				var_0F thread maps\_exo_climb::toggle_mount_mag_trigger_on(self);
				return;
			}

			if(var_03.script_noteworthy == "crate_turn_right")
			{
				maps\_anim::anim_single_solo(self,"crate_corner_right");
				wait(0.1);
			}

			if(var_03.script_noteworthy == "crate_turn_left")
			{
				maps\_anim::anim_single_solo(self,"crate_corner_left");
				wait(0.1);
			}
		}

		if(isdefined(var_03.script_delay))
		{
			var_0E = var_03.script_delay;
		}

		if(!var_05)
		{
			if(isdefined(var_0F))
			{
				wait(var_0E - 1.5);
				var_0F thread maps\_exo_climb::toggle_mount_mag_trigger_off(self,1.5);
				wait(1.5);
				wait(0.05);
			}
			else
			{
				wait(var_0E);
			}
		}

		if(var_05)
		{
			var_05 = 0;
		}

		if(isdefined(var_04.script_noteworthy))
		{
			if(var_04.script_noteworthy == "crate_transfer_point")
			{
				var_0D = 0.2;
			}

			if(var_04.script_noteworthy == "crate_mount_point")
			{
				var_0D = 0.2;
			}
		}

		var_10 = maps\betrayal_util::mph_to_ups(12);
		if(isdefined(var_03.speed))
		{
			var_10 = var_03.speed;
		}

		var_11 = distance(var_04.origin,self.origin);
		var_12 = var_11 / var_10;
		self moveto(var_04.origin,var_12,var_12 * var_0C,var_12 * var_0D);
		if(isdefined(var_04.angles) && var_04.angles != self.angles)
		{
			thread climb_scene_rotate_crate_on_path(var_04.angles,var_12);
		}

		wait(var_12);
		var_03 = var_04;
	}
}

//Function Number: 347
climb_scene_rotate_crate_on_path(param_00,param_01)
{
	var_02 = param_01 / 2;
	var_03 = param_01 / 4;
	wait(var_03);
	self rotateto(param_00,var_02,var_02 / 5,var_02 / 5);
}

//Function Number: 348
climb_scene_start_crane()
{
	var_00 = maps\betrayal_util::get_ent_by_targetname("climb_crane_mover");
	var_01 = maps\betrayal_util::get_ent_by_targetname(var_00.target);
	var_02 = maps\betrayal_util::get_ent_by_targetname(var_01.target);
	var_00.pickup_goal_ang = var_01.angles;
	var_01 delete();
	var_00.dropoff_goal_ang = var_02.angles;
	var_02 delete();
	var_03 = maps\betrayal_util::get_ent_by_targetname("script_glass_shatter_node");
	var_03 linkto(var_00);
	self waittill("trigger");
	var_03 thread climb_scene_crane_glass_break();
	var_00 rotateto(var_00.pickup_goal_ang,6,1,1);
	var_04 = maps\betrayal_util::get_ent_by_targetname("trigger_crane_player_mount");
	var_05 = maps\betrayal_util::get_ent_by_targetname(var_04.target);
	var_06 = maps\_shg_utility::hint_button_position("use",var_05.origin,undefined,200);
	var_04 maps\_utility::addhinttrigger(&"EXOCLIMB_CLIMB_HINT",&"EXOCLIMB_CLIMB_HINT_PC");
	var_04 waittill("trigger");
	var_04 delete();
	common_scripts\utility::flag_set("flag_objective_climb_start_crane");
	var_06 maps\_shg_utility::hint_button_clear();
	level.player thread climb_scene_handle_crane_climb(var_00);
	level waittill("climb_scene_start_crane_move");
	var_00 soundscripts\_snd::snd_message("reverse_mag_glove_crane_move");
	var_00 rotateto(var_00.dropoff_goal_ang,7,1,1);
}

//Function Number: 349
climb_scene_handle_crane_climb(param_00)
{
	var_01 = climb_scene_crane_mount();
	var_01 linkto(param_00);
	level.climbing_crane_allow_input = 1;
	var_01.start_moving = 0;
	var_01 thread climb_scene_handle_crane_climb_movement_input();
	var_02 = "right";
	var_03 = 0;
	var_01 thread maps\_anim::anim_loop_solo(var_01,var_02 + "_idle","stop_crane_idle");
	maps\_utility::hintdisplayhandler("player_moved_forward");
	for(;;)
	{
		if(var_03 > 11)
		{
			break;
		}

		while(!var_01.start_moving)
		{
			wait(0.05);
		}

		common_scripts\utility::flag_set("flag_climb_player_started_moving");
		if(var_02 == "left")
		{
			var_02 = "right";
		}
		else
		{
			var_02 = "left";
		}

		var_01 thread climb_scene_crane_move(var_02);
		var_03++;
		if(var_03 == 1)
		{
			level notify("climb_scene_start_crane_move");
		}

		if(var_03 == 3)
		{
			common_scripts\utility::flag_set("flag_dialogue_crane_go");
		}
	}

	level notify("crane_climb_dismount");
	climb_scene_crane_dismount_to_wall(var_01);
}

//Function Number: 350
climb_scene_crane_move(param_00)
{
	self notify("stop_crane_move");
	self endon("stop_crane_move");
	self notify("stop_crane_idle");
	level.climbing_crane_allow_input = undefined;
	self.start_moving = 0;
	maps\_anim::anim_single_solo(self,param_00 + "_move");
	thread maps\_anim::anim_loop_solo(self,param_00 + "_idle","stop_crane_idle");
}

//Function Number: 351
climb_scene_crane_allow_input(param_00)
{
	level.climbing_crane_allow_input = 1;
}

//Function Number: 352
climb_scene_crane_move_rumble(param_00)
{
	level.player playrumbleonentity("damage_light");
}

//Function Number: 353
climb_scene_crane_grab_rumble(param_00)
{
	level.player playrumbleonentity("damage_heavy");
}

//Function Number: 354
climb_scene_crane_move_shake(param_00)
{
	level.player screenshakeonentity(4,2,0.5,0.5,0,0.25,128,10,5,5,2);
}

//Function Number: 355
climb_scene_crane_grab_shake(param_00)
{
	level.player screenshakeonentity(12,6,2,0.5,0,0.25,128,10,5,5,2);
}

//Function Number: 356
climb_scene_handle_crane_climb_movement_input()
{
	level endon("crane_climb_dismount");
	for(;;)
	{
		var_00 = level.player getnormalizedmovement();
		if(length2d(var_00) <= 0.15)
		{
			self.start_moving = 0;
		}
		else
		{
			var_01 = angleclamp360(var_00[0],var_00[1]);
			if(var_01 < 135 && var_01 > 45 && isdefined(level.climbing_crane_allow_input))
			{
				self.start_moving = 1;
			}
			else
			{
				self.start_moving = 0;
			}
		}

		wait(0.05);
	}
}

//Function Number: 357
climb_scene_crane_mount()
{
	maps\_player_exo::player_exo_deactivate();
	var_00 = maps\_utility::spawn_anim_model("player_rig_grapple",level.player.origin,level.player.angles);
	var_00 hide();
	common_scripts\utility::array_thread(getaiarray("axis"),::maps\betrayal_util::delete_ai);
	var_01 = maps\betrayal_util::get_ent_by_targetname("animorg_construction_outro");
	level.player maps\_shg_utility::setup_player_for_scene();
	var_02 = 0.5;
	level.player enableslowaim(0.5,0.3);
	level.player playerlinktoblend(var_00,"tag_player",var_02);
	level.player common_scripts\utility::delaycall(var_02,::playerlinktodelta,var_00,"tag_player",0.75,0,0,0,0,1);
	level.player common_scripts\utility::delaycall(var_02 + 0.1,::lerpviewangleclamp,0.5,0,0,15,15,10,36);
	var_00 common_scripts\utility::delaycall(var_02,::show);
	level notify("flag_dialogue_climb_crane_nag_stop");
	common_scripts\utility::delay_script_call(2,::common_scripts\utility::flag_set,"flag_dialogue_crane_start");
	var_01 maps\_anim::anim_single_solo(var_00,"crane_mount");
	return var_00;
}

//Function Number: 358
climb_scene_crane_dismount_to_wall(param_00)
{
	var_01 = maps\betrayal_util::get_ent_by_targetname("origin_button_crane_dismount");
	var_02 = maps\_shg_utility::hint_button_position("jump",var_01.origin,500,600);
	common_scripts\utility::flag_set("flag_dialogue_crane_jump");
	while(!level.player jumpbuttonpressed())
	{
		wait(0.05);
	}

	var_02 maps\_shg_utility::hint_button_clear();
	var_03 = maps\betrayal_util::get_ent_by_targetname("animorg_construction_outro");
	param_00 notify("stop_crane_idle");
	param_00 notify("stop_crane_move");
	param_00 maps\_utility::anim_stopanimscripted();
	level.player lerpviewangleclamp(1,0,0,15,15,10,6);
	common_scripts\utility::delay_script_call(3,::common_scripts\utility::flag_set,"flag_dialogue_crane_slide");
	var_03 maps\_anim::anim_single_solo(param_00,"crane_to_final");
	climb_scene_finale(param_00);
}

//Function Number: 359
climb_scene_crane_glass_break()
{
	wait(3);
	for(var_00 = 0;var_00 < 8;var_00++)
	{
		glassradiusdamage(self.origin,200,50,50);
		wait(0.5);
	}

	level waittill("climb_scene_start_crane_move");
	for(var_00 = 0;var_00 < 8;var_00++)
	{
		glassradiusdamage(self.origin,200,50,50);
		wait(0.5);
	}

	self delete();
}

//Function Number: 360
climb_scene_finale(param_00)
{
	soundscripts\_snd::snd_music_message("climb_scene_finale");
	maps\_player_exo::player_exo_deactivate();
	climb_scene_cleanup();
	common_scripts\utility::flag_set("flag_climb_player_at_finale");
	common_scripts\utility::flag_set("flag_objective_climb_complete");
	if(!isdefined(param_00))
	{
		param_00 = maps\_utility::spawn_anim_model("player_rig_grapple",level.player.origin,level.player.angles);
		level.player playerlinktodelta(param_00,"tag_player",0.75,15,15,10,15);
		level.player maps\_shg_utility::setup_player_for_scene();
	}

	var_01 = climb_scene_finale_setup_anim_ents();
	var_01 = common_scripts\utility::array_add(var_01,param_00);
	var_02 = maps\betrayal_util::get_ent_by_targetname("animorg_construction_outro");
	thread maps\betrayal_lighting::setup_lighting_finale_start(var_01);
	level.player enableslowaim();
	level.player lerpfov(50,2);
	var_02 maps\_anim::anim_single(var_01,"finale_scene");
}

//Function Number: 361
climb_scne_finale_hide_body(param_00)
{
	param_00 hide();
}

//Function Number: 362
climb_scne_finale_fade_out(param_00)
{
	maps\_utility::nextmission();
}

//Function Number: 363
climb_scene_finale_setup_anim_ents()
{
	var_00 = [];
	var_01 = climb_scene_finale_setup_people_ents();
	var_00 = common_scripts\utility::array_combine(var_00,var_01);
	var_01 = climb_scene_finale_setup_vehicle_ents();
	var_00 = common_scripts\utility::array_combine(var_00,var_01);
	var_02 = maps\_utility::spawn_anim_model("finale_crate_ext",var_00[1].origin,var_00[1].angles);
	var_03 = maps\_utility::spawn_anim_model("finale_crate_int",var_00[1].origin,var_00[1].angles);
	var_00[var_00.size] = var_02;
	var_00[var_00.size] = var_03;
	return var_00;
}

//Function Number: 364
climb_scene_finale_setup_people_ents()
{
	var_00 = [];
	var_00[0] = level.ilana;
	var_00[0] maps\betrayal_util::remove_display_name();
	var_00[1] = maps\betrayal_util::spawn_ai_from_targetname_single("spawner_climb_finale_cormack",1,0);
	var_00[1].animname = "cormack";
	var_00[1] maps\betrayal_anim::assign_cloak_model("body_hero_cormack_sentinel_covert_cloak");
	var_00[1] thread maps\betrayal_anim::cloak_on();
	var_00[1] maps\betrayal_util::remove_display_name();
	var_00[2] = maps\betrayal_util::spawn_ai_from_targetname_single("spawner_climb_finale_gideon",1,0);
	var_00[2].animname = "gideon";
	var_00[2] maps\betrayal_util::remove_display_name();
	var_00[3] = maps\betrayal_util::spawn_ai_from_targetname_single("spawner_climb_finale_joker",1,0);
	var_00[3].animname = "joker";
	var_00[3] maps\betrayal_util::remove_display_name();
	var_00[4] = maps\betrayal_util::spawn_ai_from_targetname_single("spawner_climb_finale_sentinel1",1,0);
	var_00[4].animname = "sentinel1";
	var_00[4] maps\betrayal_anim::assign_cloak_model("sentinel_covert_body_a");
	var_00[4] maps\_utility::place_weapon_on("iw5_bal27_sp_opticsacog2_silencer01","right");
	var_00[4] thread maps\betrayal_anim::cloak_on();
	var_00[4] maps\betrayal_util::remove_display_name();
	var_00[5] = maps\betrayal_util::spawn_ai_from_targetname_single("spawner_climb_finale_sentinel2",1,0);
	var_00[5].animname = "sentinel2";
	var_00[5] maps\betrayal_anim::assign_cloak_model("sentinel_covert_body_a");
	var_00[5] maps\_utility::place_weapon_on("iw5_hbra3_sp_silencer01","right");
	var_00[5] thread maps\betrayal_anim::cloak_on();
	var_00[5] maps\betrayal_util::remove_display_name();
	return var_00;
}

//Function Number: 365
climb_scene_finale_setup_vehicle_ents()
{
	var_00 = [];
	var_00[0] = maps\_vehicle::spawn_vehicle_from_targetname("spawner_climb_finale_warbird");
	var_00[0] soundscripts\_snd::snd_message("spawn_ending_pcap_warbird");
	var_00[0].ignoreall = 1;
	var_00[0].animname = "warbird";
	var_00[0] useanimtree(#animtree);
	return var_00;
}

//Function Number: 366
climb_scene_finale_setup_player_ents()
{
	var_00 = [];
	level.player_rig = maps\_utility::spawn_anim_model("player_rig");
	level.player_rig hide();
	var_00[0] = level.player_rig;
	return var_00;
}