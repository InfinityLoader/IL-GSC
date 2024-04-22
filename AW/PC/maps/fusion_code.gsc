/*******************************************************************
 * Decompiled By: Bog
 * Decompiled File: fusion_code.gsc
 * Game: Call of Duty: Advanced Warfare
 * Platform: PC
 * Function Count: 399
 * Decompile Time: 5965 ms
 * Timestamp: 4/22/2024 2:30:02 AM
*******************************************************************/

//Function Number: 1
fusion_intro_screen()
{
	level.player freezecontrols(1);
	thread fusion_intro_background(8.3 + level.intro_hades_video_length,5);
	thread fusion_intro_title_text();
	common_scripts\utility::flag_set("intro_screen_done");
	common_scripts\utility::flag_set("introscreen_complete");
	wait(11 + level.intro_hades_video_length);
	level.player freezecontrols(0);
}

//Function Number: 2
fusion_intro_title_text()
{
	setsaveddvar("cg_cinematicfullscreen","1");
	maps\_shg_utility::play_chyron_video("chyron_text_fusion");
	var_00 = getdvarint("cg_cinematicCanPause",0);
	setsaveddvar("cg_cinematicCanPause",1);
	cinematicingame("fusion_videolog02");
	wait 0.05;
	while(!iscinematicplaying())
	{
		wait 0.05;
	}

	fusion_intro_hades_videolog_vo();
	setsaveddvar("cg_cinematicCanPause",var_00);
	common_scripts\utility::flag_set("intro_text_cinematic_over");
}

//Function Number: 3
fusion_intro_hades_videolog_vo()
{
	var_00 = spawn("script_origin",level.player.origin);
	var_00 playscheduledcinematicsound(106,"fus_hade_peopleoftheworldyou");
	var_00 playscheduledcinematicsound(269,"fus_hade_technologyisacancerrotting");
	var_00 playscheduledcinematicsound(595,"fus_hade_todaywestrikeatthe");
	wait(1);
	while(iscinematicplaying())
	{
		wait 0.05;
	}

	var_00 delete();
}

//Function Number: 4
fusion_intro_background(param_00,param_01)
{
	var_02 = newclienthudelem(level.player);
	var_02 setshader("black",1280,720);
	var_02.horzalign = "fullscreen";
	var_02.vertalign = "fullscreen";
	var_02.alpha = 1;
	var_02.foreground = 0;
	wait(param_00);
	var_02 fadeovertime(param_01);
	var_02.alpha = 0;
	wait(param_01);
	var_02 destroy();
}

//Function Number: 5
gameplay_setup()
{
	maps\_variable_grenade::main();
	vehicle_scripts\_pdrone_tactical_picker::main();
	maps\_stingerm7::init();
	maps\_player_exo::player_exo_add_single("high_jump");
	if(level.nextgen)
	{
		thread hide_water();
	}

	thread setup_m_turret();
	thread setup_spawn_functions();
	thread finale_enemy_transports();
	thread finale_enemy_gaz();
	thread reactor_entrance_rally();
	thread interior_gameplay();
	thread evacuation_setup();
	thread setup_evacuation_scene();
	thread extraction_chopper();
	thread cooling_tower_collapse();
	if(level.currentgen)
	{
		thread mobile_cover_drones_cg();
	}

	thread setup_dont_leave_failure();
	thread setup_dont_leave_hint();
	maps\_utility::add_hint_string("hint_dont_leave_mission",&"FUSION_DONT_LEAVE",::should_break_dont_leave);
}

//Function Number: 6
setup_spawn_functions()
{
	maps\_utility::array_spawn_function_noteworthy("enemy_street_wave_01",::street_enemy_think);
	maps\_utility::array_spawn_function_noteworthy("enemy_street_wave_02",::street_enemy_think);
	maps\_utility::array_spawn_function_noteworthy("enemy_street_turret_wave_2",::street_enemy_think);
	maps\_utility::array_spawn_function_noteworthy("enemy_street_wave_rear_mi17_01",::street_enemy_think);
	if(level.nextgen)
	{
		maps\_utility::array_spawn_function_noteworthy("enemy_street_wave_03",::street_enemy_building_east_think);
	}

	maps\_utility::array_spawn_function_noteworthy("enemy_street_wave_04",::street_enemy_building_west_think);
	maps\_utility::array_spawn_function_noteworthy("enemy_street_zip_rooftop",::rooftop_enemy_think);
	maps\_utility::array_spawn_function_noteworthy("enemy_street_zip_rooftop_strafe",::rooftop_enemy_think);
	maps\_utility::array_spawn_function_noteworthy("enemy_street_tank_stage_01",::street_enemy_tank_battle_think);
	maps\_utility::array_spawn_function_noteworthy("enemy_street_tank_stage_02",::street_enemy_tank_battle_think);
	maps\_utility::array_spawn_function_noteworthy("enemy_street_tank_stage_03",::street_enemy_tank_battle_think);
	maps\_utility::array_spawn_function_noteworthy("enemy_street_turret_wave_1",::street_enemy_tank_damaged_think);
	maps\_utility::array_spawn_function_noteworthy("enemy_street_turret_wave_2",::street_enemy_tank_damaged_think);
	maps\_utility::array_spawn_function_noteworthy("enemy_street_blown_building",::street_enemy_blown_building_think);
	if(level.currentgen)
	{
		maps\_utility::array_spawn_function_noteworthy("enemy_street_zip_rooftop_left",::rooftop_enemy_think_left);
		maps\_utility::array_spawn_function_noteworthy("enemy_street_zip_rooftop_right",::rooftop_enemy_think_right);
	}

	maps\_utility::array_spawn_function_noteworthy("turbine_room_enemy",::turbine_room_enemy_think);
	common_scripts\utility::array_thread(getentarray("corpse_trigger","targetname"),::corpse_trigger_think);
	maps\_utility::array_spawn_function_noteworthy("enemy_street_wave_rear",::street_enemy_think);
	maps\_utility::array_spawn_function_noteworthy("rpg_vehicle",::postspawn_rpg_vehicle);
	maps\_utility::array_spawn_function_targetname("hangar_enemies_01",::hangar_enemy_think);
	maps\_utility::add_global_spawn_function("allies",::disable_badplace_for_red_guys);
	maps\_utility::add_global_spawn_function("allies",::ally_enable_boost_traversals);
	maps\_utility::array_spawn_function_noteworthy("evacuation_first_drones",::evacuation_first_drones_think);
	thread enemy_combat_equip_microwave_grenades();
	maps\_utility::add_global_spawn_function("axis",::detect_turret_death);
	maps\_utility::add_global_spawn_function("axis",::maps\_chargeable_weapon::ai_detect_charged_damage);
}

//Function Number: 7
tff_cleanup_vehicle(param_00)
{
	switch(param_00)
	{
		case "intro":
			level waittill("tff_pre_transition_intro_to_middle");
			break;

		case "middle":
			level waittill("tff_pre_transition_middle_to_outro");
			break;
	}

	if(isdefined(self))
	{
		if(maps\_vehicle::isvehicle())
		{
			self freevehicle();
		}

		self delete();
	}
}

//Function Number: 8
setup_dont_leave_failure()
{
	common_scripts\utility::flag_wait("player_left_map");
	level notify("mission failed");
	setdvar("ui_deadquote",&"FUSION_DONT_LEAVE_FAILURE");
	maps\_utility::missionfailedwrapper();
}

//Function Number: 9
setup_dont_leave_hint()
{
	level endon("mission failed");
	for(;;)
	{
		common_scripts\utility::flag_wait("player_leaving_map");
		maps\_utility::display_hint("hint_dont_leave_mission");
		common_scripts\utility::flag_wait_either("player_leaving_map","player_returning_to_map");
		wait 0.05;
	}
}

//Function Number: 10
should_break_dont_leave()
{
	if(common_scripts\utility::flag("missionfailed"))
	{
		return 1;
	}

	if(common_scripts\utility::flag("player_returning_to_map"))
	{
		return 1;
	}

	return 0;
}

//Function Number: 11
mobile_cover_drones_cg()
{
	if(level.start_point != "fly_in_animated" && level.start_point != "fly_in_animated_part2" && level.start_point != "courtyard")
	{
		return;
	}

	var_00 = getentarray("mobile_cover_drones","targetname");
	var_01 = [];
	foreach(var_03 in var_00)
	{
		var_01[var_01.size] = var_03 maps\_utility::spawn_vehicle();
	}

	level waittill("tff_pre_transition_intro_to_middle");
	common_scripts\utility::array_call(var_01,::delete);
}

//Function Number: 12
heroes_post_zip()
{
	if(level.nextgen)
	{
		var_00 = getent("hero_alpha_leader","script_noteworthy");
		var_00 maps\_utility::add_spawn_function(::alpha_leader_think);
		level.alpha_leader = var_00 maps\_utility::spawn_ai(1);
		level.alpha_leader.animname = "alpha_leader";
		level.alpha_leader maps\_utility::magic_bullet_shield(1);
	}

	level.carter unlink();
	level.carter maps\_utility::teleport_ent(common_scripts\utility::getstruct("carter_zip_dest","targetname"));
	level.carter maps\_utility::disable_ai_color();
	level.carter maps\_utility::enable_sprint();
	level.carter maps\_utility::gun_recall();
	level.carter show();
	level.joker unlink();
	level.joker maps\_utility::teleport_ent(common_scripts\utility::getstruct("joker_zip_dest","targetname"));
	level.joker maps\_utility::gun_recall();
	level.joker show();
}

//Function Number: 13
alpha_leader_think()
{
	common_scripts\utility::flag_wait("flag_walker_destroyed");
	level.alpha_leader maps\_utility::set_force_color("y");
}

//Function Number: 14
ally_enable_boost_traversals()
{
	self.canjumppath = 1;
}

//Function Number: 15
disable_badplace_for_red_guys()
{
	if(!isdefined(self.script_forcecolor) || self.script_forcecolor != "r")
	{
		return;
	}

	thread maps\fusion_utility::ignore_badplace(undefined,"flag_mt_wall_rpg_impact");
}

//Function Number: 16
objectives()
{
	thread set_obj_markers_current();
	obj_shut_down_reactor();
	obj_escape();
}

//Function Number: 17
obj_shut_down_reactor()
{
	if(!common_scripts\utility::flag("flag_intro_objective_given"))
	{
		maps\_utility::flag_set_delayed("flag_intro_objective_given",33 + level.intro_hades_video_length);
		common_scripts\utility::flag_wait("flag_intro_objective_given");
	}

	objective_add(maps\_utility::obj("shutdown_reactor"),"active",&"FUSION_OBJECTIVE_REACTOR");
	objective_current(maps\_utility::obj("shutdown_reactor"));
	objective_position(maps\_utility::obj("shutdown_reactor"),getent("obj_reactor_01","targetname").origin);
	common_scripts\utility::flag_wait("update_obj_pos_walker");
	if(isdefined(level.walker))
	{
		objective_setpointertextoverride(maps\_utility::obj("shutdown_reactor"),&"FUSION_OBJECTIVE_WALKER");
		var_00 = common_scripts\utility::spawn_tag_origin();
		var_00 linkto(level.walker,"tag_camera",(0,0,-24),(0,0,0));
		objective_onentity(maps\_utility::obj("shutdown_reactor"),var_00,(0,0,0));
		common_scripts\utility::flag_wait("flag_walker_destroyed");
		objective_setpointertextoverride(maps\_utility::obj("shutdown_reactor"),"");
		var_00 delete();
	}

	common_scripts\utility::flag_wait("update_obj_pos_security_entrance_1");
	objective_position(maps\_utility::obj("shutdown_reactor"),common_scripts\utility::getstruct("obj_pos_security_entrance_1","targetname").origin);
	common_scripts\utility::flag_wait("update_obj_pos_security_entrance_2");
	objective_position(maps\_utility::obj("shutdown_reactor"),common_scripts\utility::getstruct("obj_pos_security_entrance_2","targetname").origin);
	common_scripts\utility::flag_wait("update_obj_pos_security_room");
	objective_position(maps\_utility::obj("shutdown_reactor"),common_scripts\utility::getstruct("obj_pos_security_room","targetname").origin);
	common_scripts\utility::flag_wait("update_obj_pos_security_elevator_burke");
	if(isdefined(level.burke))
	{
		objective_onentity(maps\_utility::obj("shutdown_reactor"),level.burke);
	}

	common_scripts\utility::flag_wait("update_obj_pos_security_elevator");
	objective_position(maps\_utility::obj("shutdown_reactor"),common_scripts\utility::getstruct("obj_pos_security_elevator","targetname").origin);
	common_scripts\utility::flag_wait("update_obj_pos_elevator_descent");
	objective_position(maps\_utility::obj("shutdown_reactor"),(0,0,0));
	common_scripts\utility::flag_wait("update_obj_pos_lab_follow_joker");
	if(isdefined(level.joker))
	{
		objective_onentity(maps\_utility::obj("shutdown_reactor"),level.joker);
	}

	common_scripts\utility::flag_wait("update_obj_pos_lab_follow_burke");
	if(isdefined(level.burke))
	{
		objective_onentity(maps\_utility::obj("shutdown_reactor"),level.burke);
	}

	common_scripts\utility::flag_wait("update_obj_pos_lab_follow_carter");
	if(isdefined(level.carter))
	{
		objective_onentity(maps\_utility::obj("shutdown_reactor"),level.carter);
	}

	common_scripts\utility::flag_wait("update_obj_pos_reactor_1");
	objective_position(maps\_utility::obj("shutdown_reactor"),common_scripts\utility::getstruct("obj_pos_reactor_1","targetname").origin);
	common_scripts\utility::flag_wait("update_obj_pos_reactor_2");
	objective_position(maps\_utility::obj("shutdown_reactor"),common_scripts\utility::getstruct("obj_pos_reactor_2","targetname").origin);
	common_scripts\utility::flag_wait("update_obj_pos_reactor_exit");
	objective_position(maps\_utility::obj("shutdown_reactor"),common_scripts\utility::getstruct("obj_pos_reactor_exit","targetname").origin);
	common_scripts\utility::flag_wait("update_obj_pos_reactor_storage_1");
	objective_position(maps\_utility::obj("shutdown_reactor"),common_scripts\utility::getstruct("obj_pos_reactor_storage_1","targetname").origin);
	common_scripts\utility::flag_wait("update_obj_pos_reactor_storage_2");
	objective_position(maps\_utility::obj("shutdown_reactor"),common_scripts\utility::getstruct("obj_pos_reactor_storage_2","targetname").origin);
	common_scripts\utility::flag_wait("update_obj_pos_turbine_elevator");
	objective_position(maps\_utility::obj("shutdown_reactor"),common_scripts\utility::getstruct("obj_pos_turbine_elevator","targetname").origin);
	common_scripts\utility::flag_wait("update_obj_pos_turbine_elevator_button");
	objective_position(maps\_utility::obj("shutdown_reactor"),getent("elevator_button","targetname").origin);
	objective_setpointertextoverride(maps\_utility::obj("shutdown_reactor"),&"FUSION_OBJ_POINTER_USE");
	common_scripts\utility::flag_wait("update_obj_pos_turbine_elevator_ascent");
	objective_position(maps\_utility::obj("shutdown_reactor"),(0,0,0));
	objective_setpointertextoverride(maps\_utility::obj("shutdown_reactor"),"");
	common_scripts\utility::flag_wait("update_obj_pos_turbine_room_1");
	objective_position(maps\_utility::obj("shutdown_reactor"),common_scripts\utility::getstruct("obj_pos_turbine_room_1","targetname").origin);
	common_scripts\utility::flag_wait("update_obj_pos_turbine_room_exit");
	objective_position(maps\_utility::obj("shutdown_reactor"),common_scripts\utility::getstruct("obj_pos_turbine_room_exit","targetname").origin);
	common_scripts\utility::flag_wait("update_obj_pos_control_room_door");
	objective_position(maps\_utility::obj("shutdown_reactor"),common_scripts\utility::getstruct("obj_pos_control_room_door","targetname").origin);
	common_scripts\utility::flag_wait("update_obj_pos_control_room_explosion");
	objective_position(maps\_utility::obj("shutdown_reactor"),(0,0,0));
	common_scripts\utility::flag_wait("update_obj_pos_control_room_console");
	objective_position(maps\_utility::obj("shutdown_reactor"),common_scripts\utility::getstruct("obj_pos_control_room_console","targetname").origin);
	objective_setpointertextoverride(maps\_utility::obj("shutdown_reactor"),&"FUSION_OBJ_POINTER_USE");
	common_scripts\utility::flag_wait("update_obj_pos_control_room_using_console");
	objective_position(maps\_utility::obj("shutdown_reactor"),(0,0,0));
	objective_setpointertextoverride(maps\_utility::obj("shutdown_reactor"),"");
	common_scripts\utility::flag_wait("flag_shut_down_reactor_failed");
	wait(2);
	objective_state(maps\_utility::obj("shutdown_reactor"),"failed");
	wait(2);
}

//Function Number: 18
set_obj_markers_current()
{
	common_scripts\utility::flag_wait_all("flag_obj_markers","flag_burke_rally_street_dialogue_complete");
	objective_add(maps\_utility::obj("use_mobile_cover"),"invisible","");
	objective_add(maps\_utility::obj("enter_mobile_turret"),"invisible","");
	objective_add(maps\_utility::obj("use_smaw"),"invisible","");
	thread obj_use_mobile_cover();
	thread obj_enter_mobile_turret();
	thread obj_use_smaw();
}

//Function Number: 19
obj_use_mobile_cover()
{
	common_scripts\utility::flag_wait("flag_mcd_vo_done");
	objective_state_nomessage(maps\_utility::obj("use_mobile_cover"),"active");
	objective_current_nomessage(maps\_utility::obj("use_mobile_cover"),maps\_utility::obj("shutdown_reactor"),maps\_utility::obj("enter_mobile_turret"));
	objective_setpointertextoverride(maps\_utility::obj("use_mobile_cover"),&"FUSION_OBJ_POINTER_USE");
	objective_position(maps\_utility::obj("use_mobile_cover"),getent("org_obj_use_mobile_cover","targetname").origin);
	objective_additionalposition(maps\_utility::obj("use_mobile_cover"),1,getent("org_obj_use_mobile_cover2","targetname").origin);
	level.player waittill("player_linked_to_cover");
	objective_state_nomessage(maps\_utility::obj("use_mobile_cover"),"done");
}

//Function Number: 20
obj_enter_mobile_turret()
{
	common_scripts\utility::flag_wait("flag_mt_move_up_03");
	objective_state_nomessage(maps\_utility::obj("enter_mobile_turret"),"active");
	objective_current_nomessage(maps\_utility::obj("enter_mobile_turret"),maps\_utility::obj("shutdown_reactor"));
	objective_setpointertextoverride(maps\_utility::obj("enter_mobile_turret"),&"FUSION_OBJ_POINTER_ENTER");
	objective_position(maps\_utility::obj("enter_mobile_turret"),getent("org_obj_enter_mobile_turret","targetname").origin);
	level.player waittill("player_starts_entering_mobile_turret");
	objective_state_nomessage(maps\_utility::obj("enter_mobile_turret"),"done");
}

//Function Number: 21
obj_use_smaw()
{
	common_scripts\utility::flag_wait("flag_enemy_walker");
	thread track_smaw();
	objective_state_nomessage(maps\_utility::obj("use_smaw"),"active");
	objective_current_nomessage(maps\_utility::obj("use_smaw"),maps\_utility::obj("shutdown_reactor"));
	objective_setpointertextoverride(maps\_utility::obj("use_smaw"),&"FUSION_OBJ_POINTER_USE");
	common_scripts\utility::flag_wait("flag_walker_reveal_dialogue_complete");
	var_00 = 0;
	while(!common_scripts\utility::flag("flag_walker_destroyed") || !common_scripts\utility::flag("flag_walker_death_anim_start"))
	{
		if(does_player_have_smaw())
		{
			if(var_00)
			{
				objective_state_nomessage(maps\_utility::obj("use_smaw"),"done");
				var_00 = 0;
			}

			continue;
		}

		if(!var_00)
		{
			objective_state_nomessage(maps\_utility::obj("use_smaw"),"active");
			objective_current_nomessage(maps\_utility::obj("use_smaw"),maps\_utility::obj("shutdown_reactor"));
			objective_setpointertextoverride(maps\_utility::obj("use_smaw"),&"FUSION_OBJ_POINTER_USE");
			objective_onentity(maps\_utility::obj("use_smaw"),level.smaw_location);
			var_00 = 1;
		}

		wait 0.05;
	}

	if(var_00)
	{
		objective_state_nomessage(maps\_utility::obj("use_smaw"),"done");
		var_00 = 0;
	}

	level notify("stop_track_smaw");
	level.smaw_location delete();
	level.smaw_location = undefined;
}

//Function Number: 22
track_smaw()
{
	level endon("stop_track_smaw");
	level.smaw_location = common_scripts\utility::spawn_tag_origin();
	level.smaw_location.origin = getent("org_obj_use_smaw","targetname").origin;
	for(;;)
	{
		level.player waittill("pickup",var_00,var_01);
		if(isdefined(var_01) && issubstr(var_01.classname,"iw5_stingerm7_sp"))
		{
			level.smaw_location linkto(var_01,"",(-10,8,1),(0,0,0));
		}
	}
}

//Function Number: 23
does_player_have_smaw()
{
	var_00 = level.player getweaponslistall();
	foreach(var_02 in var_00)
	{
		if(var_02 == "iw5_stingerm7_sp")
		{
			return 1;
		}
	}

	return 0;
}

//Function Number: 24
obj_escape()
{
	var_00 = maps\_utility::obj("obj_escape_power_plant");
	objective_add(var_00,"active",&"FUSION_OBJECTIVE_ESCAPE");
	objective_current(var_00);
	objective_position(var_00,getent("obj_escape_01","targetname").origin);
	common_scripts\utility::flag_wait("update_obj_pos_control_room_exit_1");
	objective_position(var_00,common_scripts\utility::getstruct("obj_pos_control_room_exit_1","targetname").origin);
	common_scripts\utility::flag_wait("update_obj_pos_control_room_exit_2");
	objective_position(var_00,common_scripts\utility::getstruct("obj_pos_control_room_exit_2","targetname").origin);
	common_scripts\utility::flag_wait("update_obj_pos_hangar_entrance");
	objective_position(var_00,common_scripts\utility::getstruct("obj_pos_hangar_entrance","targetname").origin);
	common_scripts\utility::flag_wait("flag_obj_02_pos_update_02");
	objective_position(var_00,getent("obj_escape_02","targetname").origin);
	common_scripts\utility::flag_wait("flag_obj_02_pos_update_03");
	objective_position(var_00,getent("obj_escape_03","targetname").origin);
	common_scripts\utility::flag_wait("objective_on_extraction_chopper");
	if(isdefined(level.extraction_chopper))
	{
		objective_onentity(var_00,level.extraction_chopper);
	}

	common_scripts\utility::flag_wait("tower_knockback");
	wait(5);
	objective_position(var_00,(0,0,0));
	common_scripts\utility::flag_wait("play_ending");
	objective_state(var_00,"done");
}

//Function Number: 25
squad_heli_zip()
{
	common_scripts\utility::flag_wait("intro_squad_helis_start");
	wait(0.05);
	level.heli_squad_01.animname = "npc_zip_warbird";
	level.heli_squad_01.goalradius = 1;
	var_00 = spawn("script_origin",(-80,-2480,752));
	var_00.angles = (0,265,0);
	common_scripts\utility::flag_wait("flag_squad_heli_2_unload");
	if(level.nextgen)
	{
		level.heli_squad_01 setvehgoalpos(var_00.origin,1);
		level.heli_squad_01 waittill("goal");
		level.heli_squad_01 vehicle_setspeedimmediate(0,0.05,0.05);
		level.heli_squad_01 sethoverparams(0,0,0);
		level.heli_squad_01 notify("stop_handle_rotors");
		var_00 maps\_anim::anim_first_frame_solo(level.heli_squad_01,"npc_zip");
		var_01 = getent("npc_zip_guy_1","targetname");
		var_02 = getent("npc_zip_guy_2","targetname");
		var_03 = getent("npc_zip_guy_3","targetname");
		var_04 = getent("npc_zip_guy_4","targetname");
		level.guy_1 = var_01 maps\_utility::spawn_ai(1);
		level.guy_1.animname = "npc_zip_1";
		level.guy_1.ignoreme = 1;
		level.guy_2 = var_02 maps\_utility::spawn_ai(1);
		level.guy_2.animname = "npc_zip_2";
		level.guy_2.ignoreme = 1;
		var_05 = var_03 maps\_utility::spawn_ai(1);
		var_05.animname = "npc_zip_3";
		var_05.ignoreme = 1;
		var_06 = var_04 maps\_utility::spawn_ai(1);
		var_06.animname = "npc_zip_4";
		var_06.ignoreme = 1;
		var_07 = maps\_utility::spawn_anim_model("zipline_1");
		var_08 = maps\_utility::spawn_anim_model("zipline_2");
		var_09 = maps\_utility::spawn_anim_model("zipline_3");
		var_0A = maps\_utility::spawn_anim_model("zipline_4");
		var_0B = [level.guy_1,level.guy_2,var_05,var_06,var_07,var_08,var_09,var_0A];
		level.heli_squad_01 maps\_anim::anim_first_frame(var_0B,"npc_zip","TAG_GUY0");
		foreach(var_0D in var_0B)
		{
			var_0D linkto(level.heli_squad_01,"TAG_GUY0");
		}

		var_00 thread maps\_anim::anim_single_solo(level.heli_squad_01,"npc_zip");
		level.heli_squad_01 maps\_anim::anim_single(var_0B,"npc_zip","TAG_GUY0");
		foreach(var_0D in var_0B)
		{
			var_0D unlink();
		}

		var_07 delete();
		var_08 delete();
		var_09 delete();
		var_0A delete();
		level.guy_1 maps\fusion_utility::goto_node("node_squad_zip_guard_01",0);
		level.guy_2 maps\fusion_utility::goto_node("node_squad_zip_guard_02",0);
		var_05 delete();
		var_06 delete();
		wait(2);
	}

	if(level.currentgen)
	{
		wait(10);
	}

	common_scripts\utility::flag_set("flag_rpg_at_heli");
	common_scripts\utility::flag_set("flag_squad_heli_01_zip_complete");
	level.heli_squad_01 sethoverparams(50,10,10);
	level.heli_squad_01 setmaxpitchroll(15,40);
	level.heli_squad_01 thread vehicle_scripts\_xh9_warbird::handle_rotors();
	level.heli_squad_01.script_vehicle_selfremove = 1;
	common_scripts\utility::flag_wait("flag_player_zip_started");
	if(level.nextgen)
	{
		level.guy_1 delete();
		level.guy_2 delete();
		var_00 delete();
	}
}

//Function Number: 26
fly_in_scene_part1(param_00,param_01,param_02)
{
	var_03 = getanimlength(%fusion_fly_in_intro_warbird_a);
	level.player shellshock("fusion_slowview",var_03);
	level.joker maps\_utility::gun_remove();
	level.carter maps\_utility::gun_remove();
	var_04 = [];
	var_04[0] = param_01;
	param_00 maps\_anim::anim_first_frame(var_04,"fly_in_intro");
	var_05 = [];
	var_05[0] = param_02;
	var_05[1] = level.burke;
	var_05[2] = level.joker;
	var_05[3] = level.carter;
	var_05[4] = level.copilot_intro;
	var_05[5] = level.pilot_intro;
	var_05[6] = level.guy_facing_player_intro;
	foreach(var_07 in var_05)
	{
		var_07 thread maps\fusion_utility::hide_friendname_until_flag_or_notify("warbird_fly_in_arrived");
	}

	param_01 maps\_anim::anim_first_frame(var_05,"fly_in_intro","tag_guy0");
	foreach(var_07 in var_05)
	{
		var_07 linkto(param_01,"tag_guy0");
	}

	level.player playerlinktodelta(param_02,"tag_player",1,0,0,0,0,1);
	wait(level.intro_hades_video_length);
	soundscripts\_snd::snd_message("start_hologram_audio");
	soundscripts\_snd::snd_message("start_burke_foley",level.burke);
	soundscripts\_snd::snd_message("start_intro_npc_foley",level.guy_facing_player_intro);
	common_scripts\utility::flag_wait("intro_screen_done");
	thread intro_heli_movies();
	thread fly_in_rumble();
	level.player thread widen_player_view(param_02);
	param_00 thread maps\_anim::anim_single(var_04,"fly_in_intro");
	param_01 maps\_anim::anim_single(var_05,"fly_in_intro","tag_guy0");
	var_0B = common_scripts\utility::spawn_tag_origin();
	var_0B linkto(param_01,"TAG_ORIGIN",(0,0,0),(270,0,0));
	playfxontag(common_scripts\utility::getfx("warbird_rotor"),var_0B,"TAG_ORIGIN");
}

//Function Number: 27
fly_in_rumble()
{
	common_scripts\utility::flag_wait("intro_text_cinematic_over");
	var_00 = maps\_utility::get_rumble_ent("steady_rumble");
	var_00.intensity = 0.08;
	level.burke waittillmatch("start_video_3","single anim");
	level.player playrumblelooponentity("tank_rumble");
	wait(3.5);
	level.player stoprumble("tank_rumble");
	level waittill("intro_missile_hit");
	level.player playrumbleonentity("damage_heavy");
	level.player waittill("fastzip_landed");
	stopallrumbles();
}

//Function Number: 28
intro_missile_hit(param_00)
{
	level notify("intro_missile_hit");
}

//Function Number: 29
widen_player_view(param_00)
{
	wait(0.2);
	self playerlinktodelta(param_00,"tag_player",0.75,35,0,15,25,1);
	common_scripts\utility::flag_wait("flag_combat_zip_rooftop_start");
	self lerpviewangleclamp(4,2,2,50,40,15,45);
}

//Function Number: 30
lerp_wind(param_00,param_01,param_02,param_03,param_04)
{
	var_05 = param_02 - param_00 / param_04 / 0.05;
	var_06 = param_03 - param_01 / param_04 / 0.05;
	while(param_04 > 0)
	{
		param_00 = param_00 + var_05;
		param_01 = param_01 + var_06;
		setsaveddvar("r_reactiveMotionWindAmplitudeScale",param_00);
		setsaveddvar("r_reactiveMotionWindFrequencyScale",param_01);
		param_04 = param_04 - 0.05;
		wait(0.05);
	}
}

//Function Number: 31
wind_over_trees()
{
	wait(20);
	lerp_wind(0.3,1,15,1.5,1.5);
	wait(1.75);
	lerp_wind(15,1.5,10,1,1);
	wait(3);
	lerp_wind(10,1,20,2,2);
	wait(5);
	setsaveddvar("r_reactiveMotionWindAmplitudeScale","0.3");
	setsaveddvar("r_reactiveMotionWindFrequencyScale","0.5");
}

//Function Number: 32
fly_in_scene_part2(param_00,param_01,param_02)
{
	thread wind_over_trees();
	level.player shellshock("fusion_slowview",50);
	var_03 = maps\_vehicle::spawn_vehicle_from_targetname("squad_blackhawk");
	var_03.animname = "warbird_b";
	var_03.no_anim_rotors = 1;
	var_03 vehicle_turnengineoff();
	var_04 = maps\_vehicle::spawn_vehicle_from_targetname("warbird_c");
	var_04.animname = "warbird_c";
	var_04.no_anim_rotors = 1;
	var_04 vehicle_turnengineoff();
	var_05 = maps\_vehicle::spawn_vehicle_from_targetname("warbird_d");
	var_05.animname = "warbird_d";
	var_05.no_anim_rotors = 1;
	var_05 vehicle_turnengineoff();
	var_06 = maps\_vehicle::spawn_vehicle_from_targetname("warbird_e");
	var_06.animname = "warbird_e";
	var_06.no_anim_rotors = 1;
	var_06 vehicle_turnengineoff();
	var_07 = getent("npc_b","targetname");
	var_08 = var_07 maps\_utility::spawn_ai(1);
	var_08.animname = "npc_b";
	var_09 = getent("npc_c","targetname");
	var_0A = var_09 maps\_utility::spawn_ai(1);
	var_0A.animname = "npc_c";
	var_0B = getent("npc_d","targetname");
	var_0C = var_0B maps\_utility::spawn_ai(1);
	var_0C.animname = "npc_d";
	var_0D = getent("npc_e","targetname");
	var_0E = var_0D maps\_utility::spawn_ai(1);
	var_0E.animname = "npc_e";
	waittillframeend;
	waittillframeend;
	var_03 vehicle_scripts\_xh9_warbird::cloak_warbird();
	var_08 hide();
	var_0A hide();
	var_0C hide();
	var_0E hide();
	var_03 thread wait_to_decloak_helicopter(4.25,var_08,var_0A,var_0C,var_0E);
	thread fly_in_squad_uncloak();
	var_0F = maps\_utility::spawn_anim_model("tower_debris");
	if(level.currentgen)
	{
		var_0F overridelightingorigin((890,-11485,2280));
	}

	var_10 = common_scripts\utility::getstruct("tower_debris_part","targetname");
	var_11 = [];
	var_11[0] = param_01;
	var_11[1] = var_03;
	var_11[2] = var_04;
	var_11[3] = var_05;
	var_11[4] = var_06;
	var_12 = [];
	var_12[0] = param_02;
	var_12[1] = level.burke;
	var_12[2] = level.joker;
	var_12[3] = level.carter;
	var_12[4] = level.copilot_intro;
	var_12[5] = level.pilot_intro;
	var_12[6] = level.guy_facing_player_intro;
	param_00 maps\_anim::anim_first_frame([var_03,var_04,var_05,var_06],"fly_in_part2");
	var_13 = [];
	var_13[0] = var_08;
	var_13[1] = var_0A;
	var_13[2] = var_0C;
	var_13[3] = var_0E;
	playfxontag(common_scripts\utility::getfx("distortion_warbird"),var_03,"TAG_STATIC_MAIN_ROTOR_R");
	var_03 maps\_anim::anim_first_frame(var_13,"fly_in_part2","tag_guy0");
	foreach(var_15 in var_13)
	{
		var_15 linkto(var_03,"tag_guy0");
	}

	var_04 thread play_warbird_carrying_walker("warbird_pulley_c","warbird_walker_c","fly_in_part2","tag_guy0","TAG_ATTACH");
	var_05 thread play_warbird_carrying_walker("warbird_pulley_d","warbird_walker_d","fly_in_part2","tag_guy0","TAG_ATTACH");
	var_06 thread play_warbird_carrying_walker("warbird_pulley_e","warbird_walker_e","fly_in_part2","tag_guy0","TAG_ATTACH");
	var_04 thread custom_dust_kickup();
	var_05 thread custom_dust_kickup();
	var_06 thread custom_dust_kickup();
	param_01 maps\fusion_anim::clear_vehicle_anim(0);
	var_03 maps\fusion_anim::clear_vehicle_anim(0);
	param_02 maps\fusion_anim::clear_player_anim(0);
	level.burke maps\fusion_anim::clear_npc_anim(0);
	level.joker maps\fusion_anim::clear_npc_anim(0);
	level.carter maps\fusion_anim::clear_npc_anim(0);
	level.copilot_intro maps\fusion_anim::clear_npc_anim(0);
	level.pilot_intro maps\fusion_anim::clear_npc_anim(0);
	param_00 thread maps\_anim::anim_single(var_11,"fly_in_part2");
	var_10 thread maps\_anim::anim_single_solo(var_0F,"tower_debris_collision");
	var_10 thread maps\fusion_fx::play_tower_debris_fx(var_0F);
	var_03 thread maps\_anim::anim_single(var_13,"fly_in_part2","tag_guy0");
	level.guy_facing_player_intro common_scripts\utility::delaycall(3,::delete);
	param_01 maps\_anim::anim_single(var_12,"fly_in_part2","tag_guy0");
	param_00 thread maps\_anim::anim_loop_solo(param_01,"burke_intro_zip_loop","stop_idle");
	if(!isremovedentity(var_08))
	{
		var_08 delete();
	}

	if(!isremovedentity(var_0A))
	{
		var_0A delete();
	}

	if(!isremovedentity(var_0C))
	{
		var_0C delete();
	}

	if(!isremovedentity(var_0E))
	{
		var_0E delete();
	}

	var_04 delete();
	var_05 delete();
	var_06 delete();
	level notify("warbird_fly_in_arrived");
	thread rooftop_strafe();
	thread delete_guys_in_heli_when_vo_complete();
	thread delete_tower_debris(var_0F);
}

//Function Number: 33
delete_tower_debris(param_00)
{
	common_scripts\utility::flag_wait("player_fly_in_done");
	param_00 stopanimscripted();
	param_00 delete();
}

//Function Number: 34
play_warbird_carrying_walker(param_00,param_01,param_02,param_03,param_04)
{
	var_05 = maps\_utility::spawn_anim_model(param_00);
	maps\_anim::anim_first_frame_solo(var_05,param_02,param_03);
	var_05 linkto(self,param_03);
	var_06 = maps\_utility::spawn_anim_model(param_01);
	var_05 maps\_anim::anim_first_frame_solo(var_06,param_02,param_04);
	var_06 linkto(var_05,"TAG_ATTACH");
	var_07 = common_scripts\utility::spawn_tag_origin();
	var_07 linkto(self,"tag_origin",(0,0,0),(-90,0,0));
	playfxontag(common_scripts\utility::getfx("warbird_shadow"),var_07,"tag_origin");
	thread maps\_anim::anim_single_solo(var_05,param_02,param_03);
	var_05 thread maps\_anim::anim_single_solo(var_06,param_02,param_04);
	level waittill("warbird_fly_in_arrived");
	stopfxontag(common_scripts\utility::getfx("warbird_shadow"),var_07,"tag_origin");
	var_07 delete();
	var_05 delete();
	var_06 delete();
}

//Function Number: 35
delete_guys_in_heli_when_vo_complete()
{
	common_scripts\utility::flag_wait("squad_out_dialogue_complete");
}

//Function Number: 36
launch_missile(param_00)
{
	var_01 = maps\_utility::spawn_anim_model(param_00);
	var_01.animname = param_00;
	var_01 thread missile_fly(self,param_00);
	return var_01;
}

//Function Number: 37
missile_fly(param_00,param_01)
{
	if(param_01 == "missile_0")
	{
		var_02 = common_scripts\utility::getfx("smoketrail_groundtoair_large");
	}
	else
	{
		var_02 = common_scripts\utility::getfx("smoketrail_groundtoair");
	}

	playfxontag(var_02,self,"TAG_FX");
	param_00 maps\_anim::anim_single_solo(self,"fly_in_part2");
	if(param_01 == "missile_0")
	{
		var_02 = common_scripts\utility::getfx("smoketrail_groundtoair_large");
	}
	else
	{
		var_02 = common_scripts\utility::getfx("smoketrail_groundtoair");
	}

	stopfxontag(var_02,self,"TAG_FX");
	self delete();
}

//Function Number: 38
spawn_intro_pilots()
{
	var_00 = getent("npc_f","targetname");
	level.copilot_intro = var_00 maps\_utility::spawn_ai(1);
	level.copilot_intro.animname = "npc_f";
	level.copilot_intro maps\_utility::gun_remove();
	var_01 = getent("npc_g","targetname");
	level.pilot_intro = var_01 maps\_utility::spawn_ai(1);
	level.pilot_intro.animname = "npc_g";
	level.pilot_intro maps\_utility::gun_remove();
	thread clean_up_intro_pilots();
}

//Function Number: 39
clean_up_intro_pilots()
{
	level waittill("warbird_fly_in_arrived");
	level.copilot_intro delete();
	level.pilot_intro delete();
}

//Function Number: 40
spawn_intro_heroes()
{
	var_00 = getent("npc_h","targetname");
	level.guy_facing_player_intro = var_00 maps\_utility::spawn_ai(1);
	level.guy_facing_player_intro.animname = "npc_h";
}

//Function Number: 41
fly_in_sequence()
{
	common_scripts\utility::flag_set("sun_shad_fly_in");
	maps\_utility::battlechatter_off("allies");
	thread maps\_utility::flag_set_delayed("intro_squad_helis_start",37 + level.intro_hades_video_length);
	thread maps\_utility::flag_set_delayed("street_combat_start",77 + level.intro_hades_video_length);
	thread move_squad_and_walkers();
	thread squad_heli_zip();
	thread fly_in_ambient_heli_squad();
	maps\_utility::delaythread(27 + level.intro_hades_video_length,::fly_in_ambient_jets);
	thread fly_in_ambient_street_jets();
	thread hide_objective_during_fly_in();
	level.warbird_a = maps\_vehicle::spawn_vehicle_from_targetname("blackhawk");
	level.warbird_a.animname = "warbird_a";
	level.warbird_a.no_anim_rotors = 1;
	level.warbird_a vehicle_turnengineoff();
	level.warbird_a soundscripts\_snd::snd_message("player_warbird_spawn");
	spawn_intro_heroes();
	spawn_intro_pilots();
	var_00 = spawn_player_anim_rig();
	var_00 hide();
	level.player maps\_shg_utility::setup_player_for_scene();
	maps\_player_exo::player_exo_deactivate();
	var_01 = common_scripts\utility::getstruct("org_flyin","targetname");
	fly_in_scene_part1(var_01,level.warbird_a,var_00);
	finish_fly_in_sequence(var_01,level.warbird_a,var_00);
}

//Function Number: 42
play_dust(param_00)
{
	level notify("warbird_door_open");
	common_scripts\utility::noself_delaycall(1,::playfxontag,common_scripts\utility::getfx("fast_blowing_dust"),level.warbird_a,"TAG_outside_door");
}

//Function Number: 43
hide_objective_during_fly_in()
{
	setsaveddvar("objectiveHide",1);
	common_scripts\utility::flag_wait("player_fly_in_done");
	setsaveddvar("objectiveHide",0);
}

//Function Number: 44
finish_fly_in_sequence(param_00,param_01,param_02)
{
	maps\_utility::delaythread(50,::start_rooftop_combat);
	param_01.missile_org = param_00;
	fly_in_scene_part2(param_00,param_01,param_02);
	level.burke maps\_utility::gun_recall();
	thread burke_rooftop_combat(param_00,param_01);
	common_scripts\utility::noself_delaycall(0,::stopfxontag,common_scripts\utility::getfx("fast_blowing_dust"),level.warbird_a,"TAG_outside_door");
	thread burke_fastzip_scene(param_00,level.warbird_a);
	common_scripts\utility::flag_wait("player_can_zip");
	wait(0.5);
	common_scripts\utility::flag_set("ready_zip");
	maps\_utility::activate_trigger_with_targetname("trig_move_squad_from_heli");
	param_02 hide();
	var_03 = maps\_utility::spawn_anim_model("player_arms",param_02.origin);
	var_03.angles = param_02.angles;
	var_03 hide();
	thread rooftop_slide();
	level.player thread maps\_player_fastzip::fastzip_turret_think(level.warbird_a,"tag_turret_zipline_kl",var_03,2.7);
	level.player waittill("fastzip_start");
	thread zip_debris_anim();
	thread street_hanging_pipes_anim();
	common_scripts\utility::flag_set("flag_player_zip_started");
	level.player waittill("fastzip_arrived");
	common_scripts\utility::flag_set("sun_shad_off_zip");
	maps\_player_exo::player_exo_activate();
	param_02 delete();
	var_03 delete();
	wait(0.05);
	common_scripts\utility::flag_set("player_fly_in_done");
	maps\_utility::delaythread(3,::maps\_utility::autosave_by_name);
	thread delete_rooftop_los_blockers();
	thread show_hide_plant_vista();
	maps\_utility::battlechatter_on("allies");
	level.warbird_a vehicle_setspeed(60,15,5);
	var_04 = common_scripts\utility::getstruct("heli_path_leave","targetname");
	level.warbird_a thread maps\_utility::vehicle_dynamicpath(var_04,0);
	level.warbird_a soundscripts\_snd::snd_message("player_warbird_flyout");
	level.warbird_a.script_vehicle_selfremove = 1;
}

//Function Number: 45
show_hide_plant_vista()
{
	var_00 = getentarray("brushmodel_vista_plant","targetname");
	if(isdefined(var_00))
	{
		var_00 thread hide_plant_vista_via_trigger();
		var_00 thread show_plant_vista_via_trigger();
	}
}

//Function Number: 46
show_hide_plant_vista_intro()
{
	var_00 = getentarray("brushmodel_vista_plant","targetname");
	if(isdefined(var_00))
	{
		var_00 thread hide_plant_vista_intro();
		var_00 thread show_plant_vista_intro();
	}
}

//Function Number: 47
hide_plant_vista_intro()
{
	foreach(var_01 in self)
	{
		var_01 hide();
	}
}

//Function Number: 48
show_plant_vista_intro()
{
	level.player endon("death");
	wait(71);
	foreach(var_01 in self)
	{
		var_01 show();
	}
}

//Function Number: 49
hide_plant_vista_via_trigger()
{
	level endon("street_cleanup");
	for(;;)
	{
		maps\_utility::trigger_wait_targetname("trig_hide_plant_vista");
		foreach(var_01 in self)
		{
			var_01 hide();
		}
	}
}

//Function Number: 50
show_plant_vista_via_trigger()
{
	level endon("street_cleanup");
	for(;;)
	{
		maps\_utility::trigger_wait_targetname("trig_show_plant_vista");
		foreach(var_01 in self)
		{
			var_01 show();
		}
	}
}

//Function Number: 51
zip_debris_anim()
{
	wait(1);
	var_00 = common_scripts\utility::getstruct("org_zip_debris","targetname");
	var_01 = maps\_utility::spawn_anim_model("zip_debris_01");
	var_02 = maps\_utility::spawn_anim_model("zip_debris_02");
	var_03 = [var_01,var_02];
	var_00 maps\_anim::anim_single(var_03,"zip_falling_debris");
	maps\_utility::array_delete(var_03);
}

//Function Number: 52
street_hanging_pipes_anim()
{
	var_00 = common_scripts\utility::getstruct("org_hanging_pipes_01","targetname");
	var_01 = maps\_utility::spawn_anim_model("street_pipes_01");
	var_00 maps\_anim::anim_loop_solo(var_01,"street_hanging_pipes");
	if(level.currentgen)
	{
		level waittill("tff_pre_transition_intro_to_middle");
		var_00 maps\_utility::anim_stopanimscripted();
		var_01 delete();
	}
}

//Function Number: 53
fly_in_ambient_heli_squad()
{
	common_scripts\utility::flag_wait("intro_squad_helis_start");
	level.heli_squad_01 = spawn_ambient_warbird("squad_warbird_01",25,45);
	level.heli_squad_02 = spawn_ambient_warbird("squad_warbird_02",25,45,1);
	level.heli_squad_03 = spawn_ambient_warbird("squad_warbird_03",20,50,1);
	level.heli_squad_05 = spawn_ambient_warbird("squad_warbird_05",25,50,1);
	level.heli_squad_06 = spawn_ambient_warbird("squad_warbird_06",25,50,1);
	level.heli_squad_07 = spawn_ambient_warbird("squad_warbird_07",25,50,1);
	level.heli_squad_08 = spawn_ambient_warbird("squad_warbird_08",10,25,1);
	level.heli_squad_09 = spawn_ambient_warbird("squad_warbird_09",10,25,1);
	level.heli_squad_11 = spawn_ambient_warbird("squad_warbird_cargo11",10,25,1);
	level.heli_squad_11 thread add_warbird_cargo("cargo_walker11","cargo_pully11");
	level.heli_squad_08 thread add_warbird_cargo("cargo_walker12","cargo_pully12");
	level.heli_squad_05 thread add_warbird_cargo("cargo_walker13","cargo_pully13");
	level.heli_squad_01 vehicle_turnengineoff();
	level.heli_squad_02 vehicle_turnengineoff();
	level.heli_squad_03 vehicle_turnengineoff();
	level.heli_squad_05 vehicle_turnengineoff();
	level.heli_squad_06 vehicle_turnengineoff();
	level.heli_squad_07 vehicle_turnengineoff();
	level.heli_squad_08 vehicle_turnengineoff();
	level.heli_squad_09 vehicle_turnengineoff();
	level.heli_squad_11 vehicle_turnengineoff();
	if(level.currentgen)
	{
		level.heli_squad_01 thread tff_cleanup_vehicle("intro");
	}
}

//Function Number: 54
spawn_ambient_warbird(param_00,param_01,param_02,param_03)
{
	var_04 = maps\_vehicle::spawn_vehicle_from_targetname_and_drive(param_00);
	var_04 vehicle_scripts\_xh9_warbird::cloak_warbird();
	var_04 setmaxpitchroll(param_01,param_02);
	var_04 vehicle_scripts\_xh9_warbird::set_cloak_parameter(0,0);
	if(isdefined(param_03))
	{
		var_04.script_vehicle_selfremove = param_03;
	}

	var_04.shadow_tag = common_scripts\utility::spawn_tag_origin();
	var_04.shadow_tag linkto(var_04,"tag_origin",(0,0,0),(-90,0,0));
	playfxontag(common_scripts\utility::getfx("warbird_shadow_cloaked"),var_04.shadow_tag,"tag_origin");
	return var_04;
}

//Function Number: 55
add_warbird_cargo(param_00,param_01)
{
	var_02 = getent(param_00,"targetname");
	var_02 linkto(self);
	var_03 = getent(param_01,"targetname");
	var_03 linkto(self);
	self waittill("death");
	var_02 unlink();
	var_02 delete();
	var_03 unlink();
	var_03 delete();
}

//Function Number: 56
fly_in_squad_uncloak()
{
	wait(3.5);
	level.heli_squad_01 thread uncloak_ambient_warbird(level.shadow_tag_01,3.3);
	wait(0.15);
	level.heli_squad_09 thread uncloak_ambient_warbird(level.shadow_tag_09,3.3);
	wait(0.15);
	level.heli_squad_11 thread uncloak_ambient_warbird(level.shadow_tag_11,3.3);
	wait(0.15);
	level.heli_squad_06 thread uncloak_ambient_warbird(level.shadow_tag_06,3.3);
	wait(0.15);
	level.heli_squad_07 thread uncloak_ambient_warbird(level.shadow_tag_07,3.3);
	wait(0.15);
	level.heli_squad_08 thread uncloak_ambient_warbird(level.shadow_tag_08,3.3);
	wait(0.15);
	level.heli_squad_05 thread uncloak_ambient_warbird(level.shadow_tag_05,3.3);
	wait(0.15);
	wait(0.15);
	level.heli_squad_03 thread uncloak_ambient_warbird(level.shadow_tag_03,3.3);
	wait(1.25);
	level.heli_squad_02 thread uncloak_ambient_warbird(level.shadow_tag_02,3.3);
	common_scripts\utility::flag_wait("fx_flak_intro");
	level.heli_squad_01 clean_up_shadow_tag();
	level.heli_squad_02 clean_up_shadow_tag();
	level.heli_squad_03 clean_up_shadow_tag();
	level.heli_squad_05 clean_up_shadow_tag();
	level.heli_squad_06 clean_up_shadow_tag();
	level.heli_squad_07 clean_up_shadow_tag();
	level.heli_squad_08 clean_up_shadow_tag();
	level.heli_squad_09 clean_up_shadow_tag();
	level.heli_squad_11 clean_up_shadow_tag();
}

//Function Number: 57
uncloak_ambient_warbird(param_00,param_01)
{
	var_02 = 3.3;
	if(isdefined(param_01))
	{
		param_01 = var_02;
	}

	vehicle_scripts\_xh9_warbird::uncloak_warbird(param_01);
	if(isdefined(self.shadow_tag))
	{
		stopfxontag(common_scripts\utility::getfx("warbird_shadow_cloaked"),self.shadow_tag,"tag_origin");
		playfxontag(common_scripts\utility::getfx("warbird_shadow"),self.shadow_tag,"tag_origin");
	}
}

//Function Number: 58
clean_up_shadow_tag()
{
	if(isdefined(self.shadow_tag))
	{
		stopfxontag(common_scripts\utility::getfx("warbird_shadow"),self.shadow_tag,"tag_origin");
		self.shadow_tag delete();
	}
}

//Function Number: 59
fly_in_ambient_jets()
{
	level.jets = [];
	thread spawn_looping_jets("f15_01");
	thread spawn_looping_jets("f15_03");
	thread spawn_looping_jets("f15_06");
	wait(1);
	thread spawn_looping_jets("f15_05");
}

//Function Number: 60
spawn_looping_jets(param_00)
{
	while(!common_scripts\utility::flag("flag_combat_zip_rooftop_complete"))
	{
		var_01 = maps\_vehicle::spawn_vehicle_from_targetname_and_drive(param_00);
		level.jets = common_scripts\utility::array_removeundefined(level.jets);
		level.jets[level.jets.size] = var_01;
		var_01 waittill("death");
	}
}

//Function Number: 61
fly_in_ambient_street_jets()
{
	common_scripts\utility::flag_wait("player_fly_in_done");
	if(!isdefined(level.jets))
	{
		level.jets = [];
	}

	while(level.jets.size > 0)
	{
		level.jets = common_scripts\utility::array_removeundefined(level.jets);
		wait 0.05;
	}

	thread spawn_looping_street_jets("f15_street01");
	wait(0.5);
	thread spawn_looping_street_jets("f15_street03");
	wait(0.5);
	thread spawn_looping_street_jets("f15_street05");
	wait(0.5);
	thread spawn_looping_street_jets("f15_street07");
}

//Function Number: 62
spawn_looping_street_jets(param_00)
{
	while(!common_scripts\utility::flag("flag_player_at_reactor_entrance"))
	{
		var_01 = maps\_vehicle::spawn_vehicle_from_targetname_and_drive(param_00);
		level.jets = common_scripts\utility::array_removeundefined(level.jets);
		level.jets[level.jets.size] = var_01;
		var_01 soundscripts\_snd::snd_message("snd_start_ambient_jet");
		var_01 waittill("death");
	}

	level.jets = common_scripts\utility::array_removeundefined(level.jets);
}

//Function Number: 63
wait_to_decloak_helicopter(param_00,param_01,param_02,param_03,param_04)
{
	level.player endon("death");
	wait(param_00);
	soundscripts\_snd::snd_message("decloak_intro_helicopter");
	thread vehicle_scripts\_xh9_warbird::uncloak_warbird(3);
	wait(1.5);
	param_01 show();
	param_02 show();
	param_03 show();
	param_04 show();
	param_01 stopusingheroonlylighting();
	param_02 stopusingheroonlylighting();
	param_03 stopusingheroonlylighting();
	param_04 stopusingheroonlylighting();
}

//Function Number: 64
burke_rooftop_combat(param_00,param_01)
{
	if(common_scripts\utility::flag("flag_burke_zip"))
	{
		return;
	}

	param_00 maps\_anim::anim_single_solo(level.burke,"burke_rooftop_shoot_enter");
	level.burke.face_direction = anglestoforward(level.burke.angles);
	level.burke notify("killanimscript");
	level.burke.custom_animscript["combat"] = ::burke_rooftop_combat_animscript;
	level.burke.custom_animscript["stop"] = ::burke_rooftop_combat_animscript;
	common_scripts\utility::flag_wait("flag_burke_zip");
	level.burke.custom_animscript["combat"] = undefined;
	level.burke.custom_animscript["stop"] = undefined;
	level.burke notify("killanimscript");
	level.burke clearanim(%burke_aiming,0.2);
	level.burke clearanim(%burke_add_fire,0.2);
	level.burke.last_pitch_aim = undefined;
	level.burke.last_yaw_aim = undefined;
	level.burke.face_direction = undefined;
}

//Function Number: 65
burke_rooftop_combat_animscript()
{
	self notify("killanimscript");
	self endon("killanimscript");
	level.burke orientmode("face direction",level.burke.face_direction);
	setup_burke_aim_anims();
	var_00 = undefined;
	for(;;)
	{
		if(!isdefined(var_00) || !isalive(var_00))
		{
			if(isdefined(self.enemy) && self cansee(self.enemy) && isalive(self.enemy))
			{
				var_00 = self.enemy;
			}
		}

		if(isdefined(var_00))
		{
			var_01 = animscripts\shared::getshootfrompos();
			var_02 = var_00 getshootatpos();
			var_03 = var_02 - var_01;
			var_04 = vectortoangles(var_03);
			var_05 = aim_burke_at_angles(var_04,48);
			if(var_05)
			{
				var_06 = randomintrange(2,4);
				for(var_07 = 0;var_07 < var_06;var_07++)
				{
					burke_burst_shoot(var_00);
					wait(randomfloatrange(0.2,0.4));
				}

				wait(randomfloatrange(3,5));
			}
		}

		if(common_scripts\utility::cointoss())
		{
			var_00 = undefined;
		}

		wait(0.05);
	}
}

//Function Number: 66
setup_burke_aim_anims()
{
	self clearanim(%root,0.2);
	self setanim(%fusion_fly_in_burke_aim_5,1,0.2,1);
	self setanimlimited(%fusion_fly_in_burke_aim_4,1,0,1);
	self setanimlimited(%fusion_fly_in_burke_aim_6,1,0,1);
	self setanimlimited(%fusion_fly_in_burke_aim_2,1,0,1);
	self setanimlimited(%fusion_fly_in_burke_aim_8,1,0,1);
	self setanimlimited(%burke_aim_4,0,0,1);
	self setanimlimited(%burke_aim_6,0,0,1);
	self setanimlimited(%burke_aim_2,0,0,1);
	self setanimlimited(%burke_aim_8,0,0,1);
	self setanim(%fusion_fly_in_burke_aim_idle,1,0,1);
}

//Function Number: 67
aim_burke_at_angles(param_00,param_01)
{
	var_02 = 1;
	if(!isdefined(self.last_pitch_aim))
	{
		self.last_pitch_aim = 0;
	}

	if(!isdefined(self.last_yaw_aim))
	{
		self.last_yaw_aim = 0;
	}

	var_03 = angleclamp180(param_00[0] - self.angles[0]);
	if(abs(var_03) > param_01)
	{
		var_03 = 0;
	}

	var_04 = var_03 / param_01;
	var_05 = var_04 - self.last_pitch_aim;
	if(abs(var_05) > 0.2)
	{
		var_02 = 0;
		var_05 = clamp(var_05,-0.2,0.2);
		var_04 = self.last_pitch_aim + var_05;
	}

	if(var_04 < 0)
	{
		self setanimlimited(%burke_aim_8,abs(var_04),0.2,1);
		self setanimlimited(%burke_aim_2,0,0.2,1);
	}
	else
	{
		self setanimlimited(%burke_aim_8,0,0.2,1);
		self setanimlimited(%burke_aim_2,var_04,0.2,1);
	}

	var_06 = angleclamp180(param_00[1] - self.angles[1]);
	if(abs(var_06) > param_01)
	{
		var_06 = 0;
	}

	var_07 = var_06 / param_01;
	var_08 = var_07 - self.last_yaw_aim;
	if(abs(var_08) > 0.2)
	{
		var_02 = 0;
		var_08 = clamp(var_08,-0.2,0.2);
		var_07 = self.last_yaw_aim + var_08;
	}

	if(var_07 < 0)
	{
		self setanimlimited(%burke_aim_6,abs(var_07),0.2,1);
		self setanimlimited(%burke_aim_4,0,0.2,1);
	}
	else
	{
		self setanimlimited(%burke_aim_6,0,0.2,1);
		self setanimlimited(%burke_aim_4,var_07,0.2,1);
	}

	self.last_pitch_aim = var_04;
	self.last_yaw_aim = var_07;
	return var_02;
}

//Function Number: 68
burke_burst_shoot(param_00)
{
	var_01 = randomintrange(2,4);
	for(var_02 = 0;var_02 < var_01;var_02++)
	{
		self shoot();
		self setanimrestart(%fusion_fly_in_burke_fire,1,0,1);
		wait(0.1);
	}
}

//Function Number: 69
start_rooftop_combat()
{
	common_scripts\utility::flag_set("flag_combat_zip_rooftop_start");
	maps\_utility::autosave_by_name();
	wait(2);
	level.player enableweapons();
	level.player enablehybridsight("iw5_bal27_sp_variablereddot",1);
	level.player enableoffhandweapons();
	level maps\_utility::_setsaveddvar("ammoCounterHide",0);
	maps\_player_exo::player_exo_activate();
	thread handle_disabling_sonic_blast();
}

//Function Number: 70
handle_disabling_sonic_blast()
{
	var_00 = maps\_player_exo::player_exo_get_owned_array(["sonic_blast"]);
	if(var_00.size > 0)
	{
		maps\_player_exo::player_exo_remove_array(var_00);
		common_scripts\utility::flag_wait("player_fly_in_done");
		maps\_player_exo::player_exo_add_single("sonic_blast");
	}
}

//Function Number: 71
rooftop_strafe()
{
	var_00 = common_scripts\utility::getstruct("path_rooftop_strafe","targetname");
	level.heli_squad_01 thread maps\_utility::vehicle_dynamicpath(var_00,0);
	level.heli_squad_01 setmaxpitchroll(10,10);
	common_scripts\utility::flag_wait_or_timeout("flag_player_cleared_rooftop",15);
	common_scripts\utility::flag_set("flag_rooftop_strafe");
	level.heli_squad_01 soundscripts\_snd::snd_message("rooftop_strafe_start");
	level.heli_squad_01 thread warbird_shooting_think(1);
	wait(1);
	level.heli_squad_01 notify("warbird_fire");
	common_scripts\utility::flag_wait("flag_combat_zip_rooftop_complete");
	level.heli_squad_01 notify("warbird_stop_firing");
}

//Function Number: 72
delete_rooftop_los_blockers()
{
	var_00 = getentarray("street_rooftop_los_blocker","targetname");
	foreach(var_02 in var_00)
	{
		var_02 delete();
	}
}

//Function Number: 73
allow_player_zip()
{
	wait(8.9);
	common_scripts\utility::flag_wait("flag_combat_zip_rooftop_complete");
	common_scripts\utility::flag_set("player_can_zip");
}

//Function Number: 74
burke_fastzip_scene(param_00,param_01)
{
	common_scripts\utility::flag_wait("flag_burke_zip");
	param_01 notify("stop_idle");
	param_00 notify("stop_idle");
	thread burke_fastzip_aim_turret(param_01,"tag_turret_zipline_fl");
	var_02 = param_01.zipline_gun_model["tag_turret_zipline_fl"];
	var_02 unlink();
	level.burke unlink();
	thread burke_rally_init();
	thread allow_player_zip();
	level.burke maps\_utility::anim_stopanimscripted();
	param_00 thread maps\_anim::anim_single_solo_run(level.burke,"burke_intro_zip");
	var_03 = [param_01,var_02];
	param_00 maps\_anim::anim_single(var_03,"burke_intro_zip");
	common_scripts\utility::flag_set("burke_fastzip_done");
	var_04 = [param_01,var_02];
	param_00 thread maps\_anim::anim_loop(var_04,"burke_intro_zip_loop","stop_loop");
	thread heroes_post_zip();
	thread allies_rally_init();
	common_scripts\utility::flag_wait("player_fly_in_done");
	param_00 notify("stop_loop");
	var_02 linkto(param_01,"tag_turret_zipline_fl",(0,0,0),(0,0,0));
}

//Function Number: 75
burke_fastzip_aim_turret(param_00,param_01)
{
	var_02 = param_00.zipline_gun_model[param_01];
	var_03 = param_00 vehicle_scripts\_xh9_warbird::spawn_zipline_turret("zipline_gun_rope",param_01,var_02.rope_model,"_turret_fastzip");
	var_03 hide();
	var_04 = common_scripts\utility::spawn_tag_origin();
	var_04.origin = var_02 gettagorigin("jnt_harpoon");
	var_03 settargetentity(var_04);
	while(!common_scripts\utility::flag("burke_fastzip_done"))
	{
		var_04.origin = var_02 gettagorigin("jnt_harpoon");
		wait(0.1);
	}

	var_04.origin = var_02 gettagorigin("jnt_harpoon");
	var_05 = var_02 gettagorigin("tag_flash");
	var_06 = distance(var_05,var_04.origin) / 12;
	var_07 = var_06 / 200;
	var_08 = %fastzip_launcher_fire_right;
	var_03 setanimknob(var_08,1,0,0);
	var_03 setanimtime(var_08,var_07);
	if(isdefined(var_02.rope_model))
	{
		var_02 detach(var_02.rope_model);
	}

	var_03 show();
	var_03 maps\_player_fastzip::retract_rope(var_06,"right");
	var_04 delete();
	var_03 delete();
}

//Function Number: 76
burke_rally_init()
{
	level.burke maps\_utility::set_force_color("g");
	level.burke maps\_utility::disable_ai_color();
	var_00 = getnode("node_cover_burke_after_zip","targetname");
	level.burke maps\fusion_utility::goto_node(var_00,0);
	thread courtyard_burke_rally();
}

//Function Number: 77
allies_rally_init()
{
	level.joker maps\_utility::disable_ai_color();
	var_00 = getnode("node_cover_joker_after_zip","targetname");
	level.joker maps\fusion_utility::goto_node(var_00,0);
}

//Function Number: 78
move_squad_and_walkers()
{
	level.player endon("death");
	common_scripts\utility::flag_wait("ready_zip");
	maps\_utility::activate_trigger_with_targetname("trig_move_squad_from_heli");
}

//Function Number: 79
setup_m_turret()
{
	maps\_vehicle_shg::set_player_rig_spawn_function(::spawn_player_anim_rig);
	if(level.currentgen)
	{
		if(level.start_point != "fly_in_animated" && level.start_point != "fly_in_animated_part2" && level.start_point != "courtyard" && level.start_point != "security_room")
		{
			return;
		}
	}

	level.x4walker_wheels_fusion_turret = 1;
	var_00 = getentarray("mobile_turret","targetname");
	var_01 = [];
	foreach(var_03 in var_00)
	{
		var_04 = var_03 maps\_utility::spawn_vehicle();
		var_04 thread monitor_mobile_turret_health();
		var_04 thread disable_cover_drone_on_mobile_turret_mount();
		var_04 thread close_enemy_check_on_mt_exit();
		var_04 thread disable_mobile_turret_if_not_destroyed();
		var_04.godmode = 1;
		var_01[var_01.size] = var_04;
	}

	if(level.currentgen)
	{
		level waittill("tff_pre_transition_intro_to_middle");
		common_scripts\utility::array_call(var_01,::delete);
	}
}

//Function Number: 80
disable_cover_drone_on_mobile_turret_mount()
{
	level.player endon("death");
	for(;;)
	{
		level.player waittill("player_starts_entering_mobile_turret");
		thread maps\fusion_lighting::setup_dof_enter_turret();
		level.player.disable_cover_drone = 1;
		level.player waittill("player_exited_mobile_turret");
		thread maps\fusion_lighting::setup_dof_exit_turret();
		level.player.disable_cover_drone = undefined;
	}
}

//Function Number: 81
wait_for_drone_message_or_death(param_00)
{
	param_00 endon("death");
	level.player waittill("hiding_cover_drone_hint",var_01);
	return var_01;
}

//Function Number: 82
close_enemy_check_on_mt_exit()
{
	for(;;)
	{
		level.player waittill("player_exited_mobile_turret");
		var_00 = getaiarray("axis");
		var_00 = maps\_utility::array_removedead_or_dying(var_00);
		foreach(var_02 in var_00)
		{
			if(isdefined(var_02) && isalive(var_02))
			{
				if(distancesquared(level.player.origin,var_02.origin) < squared(100))
				{
					var_02 maps\fusion_utility::bloody_death(0);
					continue;
				}

				if(distancesquared(level.player.origin,var_02.origin) < squared(250))
				{
					var_02 maps\fusion_utility::bloody_death(randomfloatrange(0.5,1));
				}
			}
		}
	}
}

//Function Number: 83
setup_personal_drone()
{
	var_00 = getent("player_pdrone","targetname");
	level.player thread maps\_weapon_pdrone::give_player_pdrone(var_00);
}

//Function Number: 84
setup_ally_squad()
{
	if(level.currentgen)
	{
		return;
	}

	common_scripts\utility::flag_wait("street_combat_start");
	var_00 = getentarray("allies_street","script_noteworthy");
	foreach(var_02 in var_00)
	{
		if(isdefined(var_02))
		{
			var_02 maps\_utility::spawn_ai(1);
		}
	}

	var_04 = getaiarray("allies");
	foreach(var_06 in var_04)
	{
		if(isdefined(var_06))
		{
			if(!isdefined(var_06.magic_bullet_shield))
			{
				var_06 thread maps\_utility::deletable_magic_bullet_shield();
			}
		}
	}
}

//Function Number: 85
road_battle_setup()
{
	thread setup_triggers_street_battle();
	thread setup_cover_nodes_street();
	thread combat_zip_rooftop();
	common_scripts\utility::flag_wait("street_combat_start");
	thread biasgroup_think();
	if(level.nextgen)
	{
		thread moblie_turrets_intro();
	}

	thread street_volume_manager();
	thread combat_street_wave_01();
	thread combat_street_wave_02();
	thread combat_street_wave_03();
	thread combat_street_mid_checkpoint_1();
	thread combat_street_mid_checkpoint_2();
	thread combat_street_blown_building();
	thread combat_player_in_m_turret();
	thread combat_street_wave_04();
	thread combat_street_initial();
	thread combat_street_wave_rear();
	thread combat_enemy_trans_heli_wave_01();
	thread combat_enemy_tank();
	thread rpg_at_heli();
	thread wall_explosion_01();
	thread building_explosion_01();
	thread courtyard_mobile_cover_guys();
	thread courtyard_ally_mcd_safeguard_init();
	thread boost_jump_hint();
	if(level.nextgen)
	{
		thread street_mobile_cover_guys();
	}

	thread mobile_turret_dropoff();
	thread smaw_laser_think();
}

//Function Number: 86
boost_jump_hint()
{
	level.player endon("player_starts_entering_mobile_turret");
	common_scripts\utility::flag_wait("flag_obj_markers");
	wait(1);
	common_scripts\utility::flag_wait("flag_boost_jump_reminder_dialogue_done");
	maps\_utility::hintdisplaymintimehandler("hint_use_boost",5);
}

//Function Number: 87
boost_use_hint()
{
	if(isdefined(level.player.drivingvehicleandturret) || level.player ishighjumping())
	{
		return 1;
	}

	return 0;
}

//Function Number: 88
biasgroup_think()
{
	level.player setthreatbiasgroup("player");
	createthreatbiasgroup("drones");
	setthreatbias("drones","axis_street",-20000);
	common_scripts\utility::flag_wait("flag_enemy_bullet_shield_off");
	setthreatbias("player","axis_street",8000);
	common_scripts\utility::flag_wait("flag_enemy_walker");
	setthreatbias("player","axis_street",0);
	while(!common_scripts\utility::flag("elevator_descent_player"))
	{
		if(common_scripts\utility::flag("flag_player_at_reactor_door"))
		{
			setthreatbias("player","axis_street",-20000);
			continue;
		}

		setthreatbias("player","axis_street",0);
		wait(1);
	}

	setthreatbias("player","axis_street",0);
}

//Function Number: 89
setup_triggers_street_battle()
{
	var_00 = getent("color_t_street_end","targetname");
	var_00 common_scripts\utility::trigger_off();
	var_01 = getent("color_t_walker_destroyed","targetname");
	var_01 common_scripts\utility::trigger_off();
	var_02 = getent("color_t_mt_destroyed","targetname");
	var_02 common_scripts\utility::trigger_off();
	common_scripts\utility::flag_wait_all("flag_mt_wall_rpg_impact","flag_mt_move_up_02");
	wait(1);
	var_02 common_scripts\utility::trigger_on();
	maps\_utility::activate_trigger_with_targetname("color_t_mt_destroyed");
	var_03 = getentarray("bcs_titan","targetname");
	foreach(var_05 in var_03)
	{
		var_05 common_scripts\utility::trigger_off();
	}

	common_scripts\utility::flag_wait("flag_enemy_walker");
	if(isdefined(var_02))
	{
		var_02 common_scripts\utility::trigger_off();
	}

	wait(3);
	foreach(var_05 in var_03)
	{
		var_05 common_scripts\utility::trigger_on();
	}

	var_09 = getentarray("bcs_hill","targetname");
	foreach(var_05 in var_09)
	{
		var_05 common_scripts\utility::trigger_off();
	}
}

//Function Number: 90
setup_cover_nodes_street()
{
	var_00 = getnodearray("cover_node_walker_hill","targetname");
	foreach(var_02 in var_00)
	{
		var_02 disconnectnode();
	}

	common_scripts\utility::flag_wait("flag_enemy_walker");
	foreach(var_02 in var_00)
	{
		var_02 connectnode();
	}
}

//Function Number: 91
moblie_turrets_intro()
{
	var_00 = maps\_vehicle::spawn_vehicle_from_targetname("ally_walker_02");
	var_00 thread maps\fusion_utility::kill_path_on_death();
	var_00 soundscripts\_snd::snd_message("spawn_ally_walker_02");
	var_00 maps\_vehicle::godon();
	var_01 = getent("clip_mobile_turret_player","targetname");
	var_01 linkto(var_00);
	common_scripts\utility::flag_wait("ready_zip");
	var_02 = [var_00];
	foreach(var_04 in var_02)
	{
		if(isdefined(var_04.riders))
		{
			foreach(var_06 in var_04.riders)
			{
				if(isdefined(var_06.deletable_magic_bullet_shield))
				{
					var_06 maps\_utility::stop_magic_bullet_shield();
				}
			}
		}
	}

	var_00 maps\_utility::delaythread(2,::mobile_turret_gopath);
	common_scripts\utility::flag_wait("flag_mt_move_up_03");
	var_00 maps\_vehicle::godoff();
	if(level.currentgen)
	{
		level waittill("tff_pre_transition_intro_to_middle");
		var_00 delete();
	}
}

//Function Number: 92
mobile_turret_gopath()
{
	self endon("death");
	maps\_vehicle::gopath();
	wait(0.1);
	for(;;)
	{
		level.player waittill_pushed_by(self);
		self vehicle_setspeed(0,60,60);
		var_00 = distancesquared(level.player.origin,self.origin);
		var_01 = var_00 * 2;
		while(var_00 < var_01)
		{
			wait(0.1);
			var_00 = distancesquared(level.player.origin,self.origin);
		}

		self resumespeed(1);
	}
}

//Function Number: 93
waittill_pushed_by(param_00)
{
	thread monitor_player_pushed(param_00);
	thread monitor_player_unresolved(param_00);
	thread monitor_player_pushed_while_linked(param_00);
	for(;;)
	{
		self waittill("notify_push",var_01);
		if(param_00 == var_01)
		{
			break;
		}
	}

	self notify("kill_push_monitor");
}

//Function Number: 94
monitor_player_pushed(param_00)
{
	self endon("kill_push_monitor");
	param_00 endon("death");
	for(;;)
	{
		self waittill("player_pushed",var_01,var_02);
		self notify("notify_push",var_02);
	}
}

//Function Number: 95
monitor_player_unresolved(param_00)
{
	self endon("kill_push_monitor");
	param_00 endon("death");
	for(;;)
	{
		self waittill("unresolved_collision",var_01);
		self notify("notify_push",var_01);
	}
}

//Function Number: 96
monitor_player_pushed_while_linked(param_00)
{
	self endon("kill_push_monitor");
	param_00 endon("death");
	for(;;)
	{
		var_01 = 200;
		var_02 = 80;
		var_03 = cos(var_02);
		while(self islinked())
		{
			var_04 = anglestoforward(param_00.angles);
			var_05 = vectornormalize(level.player.origin - param_00.origin);
			if(vectordot(var_04,var_05) >= var_03 && distance(self.origin,param_00.origin) < var_01)
			{
				self notify("notify_push",param_00);
				return;
			}

			wait(0.1);
		}

		wait(0.05);
	}
}

//Function Number: 97
monitor_turret_2_death()
{
	self waittill("death");
	common_scripts\utility::flag_set("flag_m_turret_dead");
}

//Function Number: 98
rooftop_enemy_think()
{
	thread rooftop_enemy_counter();
	self endon("death");
	maps\_utility::set_baseaccuracy(0.5);
	maps\fusion_utility::disable_grenades();
	maps\_utility::disable_long_death();
	common_scripts\utility::flag_wait("flag_combat_zip_rooftop_complete");
	maps\fusion_utility::bloody_death(2);
}

//Function Number: 99
rooftop_enemy_think_left()
{
	thread rooftop_enemy_counter();
	self endon("death");
	maps\_utility::set_baseaccuracy(0.5);
	maps\fusion_utility::disable_grenades();
	maps\_utility::disable_long_death();
	if(level.currentgen)
	{
		wait(3);
		var_00 = getnode("enemy_street_zip_rooftop_goal_node_left","script_noteworthy");
		maps\_utility::set_goal_node(var_00);
		maps\_utility::set_goal_radius(256);
	}

	common_scripts\utility::flag_wait("flag_combat_zip_rooftop_complete");
	maps\fusion_utility::bloody_death(2);
}

//Function Number: 100
rooftop_enemy_think_right()
{
	thread rooftop_enemy_counter();
	self endon("death");
	maps\_utility::set_baseaccuracy(0.5);
	maps\fusion_utility::disable_grenades();
	maps\_utility::disable_long_death();
	if(level.currentgen)
	{
		wait(3);
		var_00 = getnode("enemy_street_zip_rooftop_goal_node_right","script_noteworthy");
		maps\_utility::set_goal_node(var_00);
		maps\_utility::set_goal_radius(256);
	}

	common_scripts\utility::flag_wait("flag_combat_zip_rooftop_complete");
	maps\fusion_utility::bloody_death(2);
}

//Function Number: 101
rooftop_enemy_counter()
{
	level endon("flag_combat_zip_rooftop_complete");
	level endon("player_participated_in_rooftop_fight");
	self waittill("death",var_00);
	if(var_00 == level.player)
	{
		common_scripts\utility::flag_set("player_participated_in_rooftop_fight");
	}
}

//Function Number: 102
street_enemy_think()
{
	self endon("death");
	self setthreatbiasgroup("axis_street");
	var_00 = getent("vol_street_battle_01_left","targetname");
	var_01 = getent("vol_street_battle_01_right","targetname");
	var_02 = [var_00,var_01];
	street_set_volume_from_pair(var_02);
	common_scripts\utility::flag_wait("flag_mt_move_up_03");
	var_00 = getent("vol_street_battle_02_left","targetname");
	var_01 = getent("vol_street_battle_02_right","targetname");
	var_02 = [var_00,var_01];
	street_set_volume_from_pair(var_02);
	common_scripts\utility::flag_wait("flag_mt_move_up_05");
	var_00 = getent("vol_street_battle_03_left","targetname");
	var_01 = getent("vol_street_battle_03_right","targetname");
	var_02 = [var_00,var_01];
	street_set_volume_from_pair(var_02);
	common_scripts\utility::flag_wait("flag_obj_01_pos_update_02");
	var_00 = getent("vol_street_battle_reactor_entrance_left","targetname");
	var_01 = getent("vol_street_battle_reactor_entrance_right","targetname");
	var_02 = [var_00,var_01];
	street_set_volume_from_pair(var_02);
	common_scripts\utility::flag_wait("flag_enemy_walker");
	self.grenadeammo = 0;
	thread walker_death_courtyard_kva_cleanup();
	common_scripts\utility::flag_wait("flag_walker_destroyed");
	if(!isdefined(self.playerseeker))
	{
		self cleargoalvolume();
		self setgoalvolumeauto(getent("vol_street_battle_reactor_entrance","targetname"));
	}

	common_scripts\utility::flag_wait("flag_player_at_reactor_entrance");
	if(!isdefined(self.playerseeker))
	{
		self cleargoalvolume();
		self setgoalvolumeauto(getent("vol_street_battle_reactor_entrance_end","targetname"));
	}
}

//Function Number: 103
street_enemy_blown_building_think()
{
	self endon("death");
	self setthreatbiasgroup("axis_street");
	if(!isdefined(self.playerseeker))
	{
		self cleargoalvolume();
		self setgoalvolumeauto(getent("vol_street_battle_02_left","targetname"));
	}

	common_scripts\utility::flag_wait("flag_spawn_gaz_01");
	var_00 = getent("vol_street_battle_03_left","targetname");
	var_01 = getent("vol_street_battle_03_right","targetname");
	var_02 = [var_00,var_01];
	street_set_volume_from_pair(var_02);
	common_scripts\utility::flag_wait("flag_obj_01_pos_update_02");
	var_00 = getent("vol_street_battle_reactor_entrance_left","targetname");
	var_01 = getent("vol_street_battle_reactor_entrance_right","targetname");
	var_02 = [var_00,var_01];
	street_set_volume_from_pair(var_02);
	thread walker_death_courtyard_kva_cleanup();
	common_scripts\utility::flag_wait("flag_walker_destroyed");
	if(!isdefined(self.playerseeker))
	{
		self cleargoalvolume();
		self setgoalvolumeauto(getent("vol_street_battle_reactor_entrance","targetname"));
	}

	common_scripts\utility::flag_wait("flag_player_at_reactor_entrance");
	if(!isdefined(self.playerseeker))
	{
		self cleargoalvolume();
		self setgoalvolumeauto(getent("vol_street_battle_reactor_entrance_end","targetname"));
	}
}

//Function Number: 104
street_volume_manager()
{
	var_00 = getent("vol_street_battle_01_left","targetname");
	var_01 = getent("vol_street_battle_01_right","targetname");
	var_02 = [var_00,var_01];
	street_enemy_movement("flag_mt_move_up_03",2,5,var_02);
	var_00 = getent("vol_street_battle_02_left","targetname");
	var_01 = getent("vol_street_battle_02_right","targetname");
	var_02 = [var_00,var_01];
	street_enemy_movement("flag_mt_move_up_05",2,5,var_02);
	var_00 = getent("vol_street_battle_03_left","targetname");
	var_01 = getent("vol_street_battle_03_right","targetname");
	var_02 = [var_00,var_01];
	street_enemy_movement("flag_obj_01_pos_update_02",2,5,var_02);
	var_00 = getent("vol_street_battle_reactor_entrance_left","targetname");
	var_01 = getent("vol_street_battle_reactor_entrance_right","targetname");
	var_02 = [var_00,var_01];
	street_enemy_movement("flag_walker_destroyed",8,20,var_02);
}

//Function Number: 105
walker_death_courtyard_kva_cleanup()
{
	self endon("death");
	common_scripts\utility::flag_wait("flag_walker_destroyed");
	var_00 = getnodearray("walker_retreat_point","targetname");
	if(level.nextgen)
	{
		maps\fusion_utility::bloody_death(10);
		return;
	}

	thread walker_death_courtyard_kva_cleanup_cg(var_00);
}

//Function Number: 106
walker_death_courtyard_kva_cleanup_cg(param_00)
{
	self endon("death");
	var_01 = 200;
	var_02 = distance2d(self.origin,level.player.origin);
	if(var_02 < var_01)
	{
		thread maps\_utility::player_seek_enable();
		return;
	}

	param_00 = common_scripts\utility::array_randomize(param_00);
	self setgoalnode(param_00[0]);
	self waittill("goal");
	self kill();
}

//Function Number: 107
street_set_volume_from_pair(param_00)
{
	if(!isdefined(param_00))
	{
		return;
	}

	var_01 = undefined;
	if(isarray(param_00))
	{
		if(common_scripts\utility::cointoss())
		{
			var_01 = param_00[0];
			if(self istouching(var_01))
			{
				var_01 = param_00[1];
			}
		}
		else
		{
			var_01 = param_00[1];
			if(self istouching(var_01))
			{
				var_01 = param_00[0];
			}
		}
	}

	if(!isdefined(self.playerseeker))
	{
		if(isdefined(var_01))
		{
			self cleargoalvolume();
			self setgoalvolumeauto(var_01);
		}
	}
}

//Function Number: 108
street_enemy_movement(param_00,param_01,param_02,param_03)
{
	level.player endon("death");
	level endon(param_00);
	if(!isdefined(param_01))
	{
		param_01 = 5;
	}

	if(!isdefined(param_02))
	{
		param_02 = 15;
	}

	while(!common_scripts\utility::flag(param_00))
	{
		wait(randomfloatrange(param_01,param_02));
		var_04 = [];
		foreach(var_06 in param_03)
		{
			var_07 = var_06 maps\_utility::get_ai_touching_volume("axis");
			if(var_07.size > 0)
			{
				var_04 = common_scripts\utility::array_combine(var_04,var_07);
			}
		}

		if(var_04.size > 0)
		{
			var_09 = var_04[randomint(var_04.size)];
			var_09 street_set_volume_from_pair(param_03);
		}
	}
}

//Function Number: 109
mover_debug_text()
{
	self endon("death");
	var_00 = 5;
	while(var_00 > 0)
	{
		var_00 = var_00 - 0.05;
		wait(0.05);
	}
}

//Function Number: 110
street_enemy_tank_battle_think()
{
	self endon("death");
	if(!isdefined(self.playerseeker))
	{
		self setgoalvolumeauto(getent("vol_street_tank_stage_01","targetname"));
	}

	common_scripts\utility::flag_wait("flag_enemy_walker");
	self.grenadeammo = 0;
	thread walker_death_courtyard_kva_cleanup();
	common_scripts\utility::flag_wait("flag_walker_destroyed");
	if(!isdefined(self.playerseeker))
	{
		self cleargoalvolume();
		self setgoalvolumeauto(getent("vol_street_battle_reactor_entrance","targetname"));
	}

	common_scripts\utility::flag_wait("flag_player_at_reactor_entrance");
	if(!isdefined(self.playerseeker))
	{
		self cleargoalvolume();
		self setgoalvolumeauto(getent("vol_street_battle_reactor_entrance_end","targetname"));
	}
}

//Function Number: 111
street_enemy_tank_damaged_think()
{
	self endon("death");
	self.grenadeammo = 0;
	common_scripts\utility::flag_wait("walker_damaged");
	if(!isdefined(self.playerseeker))
	{
		self cleargoalvolume();
		self setgoalvolumeauto(getent("vol_street_battle_reactor_entrance","targetname"));
	}

	thread walker_death_courtyard_kva_cleanup();
	common_scripts\utility::flag_wait("flag_player_at_reactor_entrance");
	if(!isdefined(self.playerseeker))
	{
		self cleargoalvolume();
		self setgoalvolumeauto(getent("vol_street_battle_reactor_entrance_end","targetname"));
	}
}

//Function Number: 112
street_enemy_building_east_think()
{
	self endon("death");
	if(!isdefined(self.playerseeker))
	{
		self setgoalvolumeauto(getent("vol_street_battle_rear_building_east","targetname"));
	}

	common_scripts\utility::flag_wait("flag_obj_01_pos_update_02");
	if(!isdefined(self.playerseeker))
	{
		self cleargoalvolume();
		self setgoalvolumeauto(getent("vol_street_battle_reactor_entrance","targetname"));
	}

	common_scripts\utility::flag_wait("flag_enemy_walker");
	self.grenadeammo = 0;
	thread walker_death_courtyard_kva_cleanup();
	common_scripts\utility::flag_wait("flag_player_at_reactor_entrance");
	if(!isdefined(self.playerseeker))
	{
		self cleargoalvolume();
		self setgoalvolumeauto(getent("vol_street_battle_reactor_entrance_end","targetname"));
	}
}

//Function Number: 113
street_enemy_building_west_think()
{
	self endon("death");
	if(!isdefined(self.playerseeker))
	{
		self setgoalvolumeauto(getent("vol_street_battle_rear_building_west","targetname"));
	}

	common_scripts\utility::flag_wait("flag_obj_01_pos_update_02");
	if(!isdefined(self.playerseeker))
	{
		self cleargoalvolume();
		self setgoalvolumeauto(getent("vol_street_battle_reactor_entrance","targetname"));
	}

	thread walker_death_courtyard_kva_cleanup();
	common_scripts\utility::flag_wait("flag_player_at_reactor_entrance");
	if(!isdefined(self.playerseeker))
	{
		self cleargoalvolume();
		self setgoalvolumeauto(getent("vol_street_battle_reactor_entrance_end","targetname"));
	}
}

//Function Number: 114
combat_street_wave_01()
{
	if(level.currentgen)
	{
		common_scripts\utility::flag_wait("ready_zip");
		if(level.currentgen)
		{
			var_00 = ["enemy_street_wave_01","enemy_street_wave_02","enemy_street_wave_mobile_cover_a","enemy_street_wave_mobile_cover_b","enemy_street_blown_building","enemy_street_wave_04","enemy_street_wave_rear","enemy_street_tank_stage_01","enemy_street_tank_stage_02","enemy_street_reactor_entrance","enemy_street_turret_wave_1","enemy_street_turret_wave_2"];
			thread maps\_cg_encounter_perf_monitor::cg_spawn_perf_monitor("elevator_descent_player",var_00,15,0);
		}
	}

	var_01 = getentarray("enemy_street_wave_01","script_noteworthy");
	if(var_01.size > 0)
	{
		maps\_spawner::flood_spawner_scripted(var_01);
	}

	foreach(var_03 in getentarray("enemy_street_wave_01","script_noteworthy"))
	{
		if(isalive(var_03))
		{
			var_03 maps\_utility::deletable_magic_bullet_shield();
		}
	}

	common_scripts\utility::flag_wait("flag_enemy_bullet_shield_off");
	foreach(var_03 in getentarray("enemy_street_wave_01","script_noteworthy"))
	{
		if(isalive(var_03) && isdefined(var_03.magic_bullet_shield))
		{
			var_03 maps\_utility::stop_magic_bullet_shield();
		}
	}

	common_scripts\utility::flag_wait("flag_mt_move_up_03");
	var_01 = ["enemy_street_wave_01"];
	maps\fusion_utility::delete_spawners(var_01);
}

//Function Number: 115
combat_street_wave_02()
{
	common_scripts\utility::flag_wait("flag_mt_move_up_01");
	var_00 = getentarray("enemy_street_wave_02","script_noteworthy");
	if(var_00.size > 0)
	{
		maps\_spawner::flood_spawner_scripted(var_00);
	}

	var_00 = getentarray("enemy_street_wave_mobile_cover_a","script_noteworthy");
	foreach(var_02 in var_00)
	{
		var_02 maps\_utility::spawn_ai(1);
	}

	common_scripts\utility::flag_wait("flag_mt_move_up_02");
	var_00 = getentarray("enemy_street_wave_mobile_cover_b","script_noteworthy");
	foreach(var_02 in var_00)
	{
		var_02 maps\_utility::spawn_ai(1);
	}

	common_scripts\utility::flag_wait("flag_delete_spawners_wave_02");
	var_00 = ["enemy_street_wave_02"];
	maps\fusion_utility::delete_spawners(var_00);
}

//Function Number: 116
combat_street_wave_03()
{
	common_scripts\utility::flag_wait("flag_delete_spawners_wave_02");
	var_00 = getentarray("enemy_street_wave_03","script_noteworthy");
	if(var_00.size > 0)
	{
		maps\_spawner::flood_spawner_scripted(var_00);
	}

	common_scripts\utility::flag_wait("flag_enemy_reinforcements_big_wave");
	var_01 = maps\_vehicle::spawn_vehicle_from_targetname_and_drive("enemy_trans_street_01");
	var_01 thread heli_turret_death_think();
	soundscripts\_snd::snd_message("courtyard_mi17_spawn_01",var_01);
	var_02 = maps\_vehicle::spawn_vehicle_from_targetname_and_drive("enemy_trans_street_02");
	var_02 thread heli_turret_death_think();
	soundscripts\_snd::snd_message("courtyard_mi17_spawn_02",var_02);
	common_scripts\utility::flag_wait("flag_mt_move_up_03");
	var_00 = ["enemy_street_wave_03"];
	maps\fusion_utility::delete_spawners(var_00);
}

//Function Number: 117
combat_street_mid_checkpoint_1()
{
	level endon("flag_enemy_walker");
	common_scripts\utility::flag_wait("flag_road_combat_mid_save_1");
	maps\_utility::autosave_by_name();
}

//Function Number: 118
combat_street_mid_checkpoint_2()
{
	level endon("flag_walker_destroyed");
	common_scripts\utility::flag_wait("flag_road_combat_mid_save_2");
	maps\_utility::autosave_by_name();
}

//Function Number: 119
combat_street_blown_building()
{
	common_scripts\utility::flag_wait("flag_combat_blown_building");
	if(!common_scripts\utility::flag("flag_delete_spawners_wave_02"))
	{
		var_00 = getentarray("enemy_street_blown_building","script_noteworthy");
		if(var_00.size > 0)
		{
			maps\_spawner::flood_spawner_scripted(var_00);
		}
	}

	common_scripts\utility::flag_wait("flag_slow_explosions_2");
	var_00 = ["enemy_street_blown_building"];
	maps\fusion_utility::delete_spawners(var_00);
}

//Function Number: 120
heli_turret_death_think()
{
	level.player endon("death");
	level endon("street_cleanup");
	self waittill("death",var_00);
	wait(0.05);
	self notify("crash_done");
}

//Function Number: 121
combat_player_in_m_turret()
{
	level endon("street_cleanup");
	level.player waittill("player_enters_mobile_turret");
	thread hint_mt_controls();
	maps\_utility::delaythread(2,::maps\_utility::autosave_now);
	var_00 = getentarray("enemy_street_turret_wave_1","script_noteworthy");
	if(var_00.size > 0)
	{
		maps\_spawner::flood_spawner_scripted(var_00);
	}

	var_01 = getentarray("enemy_street_turret_wave_2","script_noteworthy");
	if(var_01.size > 0)
	{
		maps\_spawner::flood_spawner_scripted(var_01);
	}

	common_scripts\utility::flag_wait("walker_damaged");
	var_00 = ["enemy_street_turret_wave_1"];
	maps\fusion_utility::delete_spawners(var_00);
	var_01 = ["enemy_street_turret_wave_2"];
	maps\fusion_utility::delete_spawners(var_01);
}

//Function Number: 122
hint_mt_controls()
{
	level.player endon("player_exited_mobile_turret");
	wait(1);
	maps\_utility::hintdisplayhandler("hint_mt_fire_missiles");
	common_scripts\utility::flag_wait("flag_hint_mt_control_fire_missiles_press");
	maps\_utility::hintdisplaymintimehandler("hint_mt_fire_missiles_release");
}

//Function Number: 123
monitor_mobile_turret_health()
{
	level.player endon("death");
	level endon("street_cleanup");
	level.player waittill("player_starts_entering_mobile_turret");
	common_scripts\utility::flag_set("flag_player_starts_entering_mobile_turret");
	level.player waittill("player_enters_mobile_turret");
	common_scripts\utility::flag_set("flag_player_enters_mobile_turret");
	thread mobile_turret_tutorial_hints();
	var_00 = getentarray("mobile_turret_damage","targetname");
	foreach(var_02 in var_00)
	{
		var_02 linkto(self);
	}

	var_04 = getent("trig_mobile_turret_health_1","targetname");
	var_04 mobile_turret_health_think(self,::mobile_turret_health_1);
	var_04 = getent("trig_mobile_turret_health_2","targetname");
	var_04 mobile_turret_health_think(self,::mobile_turret_health_2);
	var_04 = getent("trig_mobile_turret_health_3","targetname");
	var_04 mobile_turret_health_think(self,::mobile_turret_health_3);
	var_04 = getent("trig_mobile_turret_missile","targetname");
	var_04 mobile_turret_health_think(self,::mobile_turret_missile);
}

//Function Number: 124
mobile_turret_tutorial_hints()
{
}

//Function Number: 125
mobile_turret_health_think(param_00,param_01)
{
	level.player endon("death");
	param_00 endon("death");
	level endon("street_cleanup");
	for(;;)
	{
		self waittill("trigger",var_02);
		if(var_02 == level.player && isdefined(param_00.player_driver) && param_00.player_driver == level.player)
		{
			param_00 thread [[ param_01 ]]();
			break;
		}
	}
}

//Function Number: 126
mobile_turret_health_1()
{
	self endon("death");
	self endon("stop_mobile_turret_health_1");
}

//Function Number: 127
mobile_turret_health_2()
{
	self endon("death");
	self endon("stop_mobile_turret_health_2");
	var_00 = "mobile_turret_sparks";
	var_01 = "TAG_SPARKS_1";
	var_02 = "TAG_SPARKS_2";
	play_and_store_fx_on_tag(var_00,self,var_01);
	wait(0.1);
	play_and_store_fx_on_tag(var_00,self,var_02);
}

//Function Number: 128
mobile_turret_health_3()
{
	self endon("death");
	self endon("stop_mobile_turret_health_3");
}

//Function Number: 129
mobile_turret_missile()
{
	self endon("death");
	var_00 = common_scripts\utility::getstruct("org_missile_disable_mt","targetname");
	var_01 = var_00.origin + anglestoforward(var_00.angles) * 256;
	var_02 = magicbullet("mobile_turret_missile",var_00.origin,var_01);
	var_02 missile_settargetpos(self.mgturret[0] gettagorigin("tag_flash") + anglestoforward(self.mgturret[0].angles) * 64);
	var_02 missile_setflightmodedirect();
	var_02 waittill("death");
	playfx(common_scripts\utility::getfx("rpg_explode"),self.mgturret[0].origin);
	var_03 = self.mgturret[0].origin;
	if(isdefined(self.player_driver))
	{
		soundscripts\_snd::snd_message("player_mobile_turret_warning");
		var_03 = self.player_driver.origin;
		thread maps\_utility::flag_set_delayed("flag_bailout_vo",0.5);
	}

	earthquake(2,1,var_03,256);
	thread mobile_turret_health_4();
}

//Function Number: 130
mobile_turret_health_4()
{
	maps\_utility::ent_flag_waitopen("player_in_transition");
	if(isdefined(level.player.drivingvehicleandturret))
	{
		var_00 = self.mgturret[0];
		level.player drivevehicleandcontrolturretoff(self);
		thread mobile_turret_burning_limit_controls(var_00);
		thread mobile_turret_burning();
		self.burning = 1;
		var_01 = "mobile_turret_fire_large";
		var_02 = "TAG_FIRE_2";
		play_and_store_fx_on_tag(var_01,self,var_02);
		return;
	}

	self.burning = 1;
	destroy_mobile_turret();
}

//Function Number: 131
mobile_turret_burning_limit_controls(param_00)
{
	level.player enableslowaim(0.005,0.005);
	level.player maps\_utility::set_ignoreme(1);
	param_00 turretfiredisable();
	self notify("end_rocket_think");
	self notify("fire_missile_system");
	self notify("disable_missile_input");
	self notify("force_clear_all_turret_locks");
	self.reticle vehicle_scripts\_x4walker_wheels_turret::reticle_hide();
	self waittill("dismount_vehicle_and_turret");
	level.player maps\_utility::set_ignoreme(0);
	level.player disableslowaim();
}

//Function Number: 132
mobile_turret_burning()
{
	thread destroy_turret_when_player_leaves();
	level.player endon("death");
	level endon("street_cleanup");
	self endon("dismount_vehicle_and_turret");
	self notify("play_damage_warning");
	var_00 = 20;
	wait(var_00 - 1);
	var_01 = self.angles + (-90,90,0);
	playfx(common_scripts\utility::getfx("fusion_vehicle_mobile_cover_explosion"),level.player geteye() + (0,-50,20));
	earthquake(1,1.6,level.player.origin,625);
	wait(1);
	level.player disableinvulnerability();
	level notify("mission failed");
	setdvar("ui_deadquote",&"FUSION_MOBILE_TURRET_DETROYED");
	maps\_utility::missionfailedwrapper();
}

//Function Number: 133
destroy_turret_when_player_leaves()
{
	level.player endon("death");
	level endon("street_cleanup");
	self waittill("player_exited_mobile_turret");
	destroy_mobile_turret();
}

//Function Number: 134
destroy_mobile_turret()
{
	level.player endon("death");
	level endon("street_cleanup");
	vehicle_scripts\_x4walker_wheels_turret::make_mobile_turret_unusable();
	var_00 = 256;
	var_01 = 20;
	while(distance(self.origin,level.player.origin) < var_00 && var_01 >= 0)
	{
		var_01 = var_01 - 0.05;
		wait(0.05);
	}

	self.mgturret[0] hide();
	self setmodel("vehicle_x4walker_wheels_dstrypv");
	playfxontag(common_scripts\utility::getfx("mobile_turret_explosion"),self,"tag_death_fx");
	earthquake(1,1.6,self.origin,625);
	soundscripts\_snd::snd_message("player_mobile_turret_explo");
	self notify("stop_mobile_turret_health_1");
	self notify("stop_mobile_turret_health_2");
	self notify("stop_mobile_turret_health_3");
	self notify("stop_mobile_turret_health_4");
	wait(0.5);
	playfxontag(common_scripts\utility::getfx("mobile_turret_ground_smoke"),self,"tag_death_fx");
}

//Function Number: 135
disable_mobile_turret_if_not_destroyed()
{
	level.player endon("death");
	self endon("stop_mobile_turret_health_4");
	var_00 = getent("trig_mobile_turret_missile","targetname");
	var_00 waittill("trigger");
	if(!isdefined(level.player.drivingvehicleandturret))
	{
		vehicle_scripts\_x4walker_wheels_turret::make_mobile_turret_unusable();
	}
}

//Function Number: 136
play_and_store_fx_on_tag(param_00,param_01,param_02)
{
	playfxontag(common_scripts\utility::getfx(param_00),param_01.mgturret[0],param_02);
	var_03 = spawnstruct();
	var_03.name = param_00;
	var_03.tag = param_02;
	if(!isdefined(param_01.damage_fx))
	{
		param_01.damage_fx = [];
	}

	param_01.damage_fx[self.damage_fx.size] = var_03;
}

//Function Number: 137
combat_street_wave_04()
{
	common_scripts\utility::flag_wait("flag_delete_spawners_wave_02");
	var_00 = getentarray("enemy_street_wave_04","script_noteworthy");
	if(var_00.size > 0)
	{
		maps\_spawner::flood_spawner_scripted(var_00);
	}

	common_scripts\utility::flag_wait("flag_enemy_walker");
	var_00 = ["enemy_street_wave_04"];
	maps\fusion_utility::delete_spawners(var_00);
}

//Function Number: 138
combat_street_wave_rear()
{
	common_scripts\utility::flag_wait("flag_mt_move_up_05");
	var_00 = getentarray("enemy_street_wave_rear","script_noteworthy");
	if(var_00.size > 0)
	{
		maps\_spawner::flood_spawner_scripted(var_00);
	}

	foreach(var_02 in getentarray("enemy_street_wave_rear","script_noteworthy"))
	{
		if(isalive(var_02))
		{
			var_02 maps\_utility::deletable_magic_bullet_shield();
		}
	}

	foreach(var_02 in getentarray("enemy_street_wave_rear","script_noteworthy"))
	{
		if(isalive(var_02) && isdefined(var_02.magic_bullet_shield))
		{
			var_02 maps\_utility::stop_magic_bullet_shield();
		}
	}

	if(level.currentgen)
	{
		common_scripts\utility::flag_wait("flag_walker_destroyed");
	}
	else
	{
		common_scripts\utility::flag_wait("flag_mt_move_up_05");
	}

	var_00 = ["enemy_street_wave_rear"];
	maps\fusion_utility::delete_spawners(var_00);
}

//Function Number: 139
combat_enemy_tank()
{
	common_scripts\utility::flag_wait("walker_trophy_1");
	var_00 = getentarray("enemy_street_tank_stage_01","script_noteworthy");
	if(var_00.size > 0)
	{
		maps\_spawner::flood_spawner_scripted(var_00);
	}

	common_scripts\utility::flag_wait("walker_trophy_2");
	thread rpg_at_squad_01();
	var_00 = getentarray("enemy_street_tank_stage_02","script_noteworthy");
	if(var_00.size > 0)
	{
		maps\_spawner::flood_spawner_scripted(var_00);
	}

	common_scripts\utility::flag_wait("walker_damaged");
	var_01 = maps\_vehicle::spawn_vehicle_from_targetname_and_drive("enemy_m_turret_03");
	var_01 thread gaz_turret_guy_think();
	common_scripts\utility::flag_wait("flag_walker_destroyed");
	var_00 = ["enemy_street_tank_stage_01","enemy_street_tank_stage_02"];
	maps\fusion_utility::delete_spawners(var_00);
	if(!level.nextgen)
	{
		level waittill("tff_pre_transition_intro_to_middle");
		var_01 delete();
	}
}

//Function Number: 140
gaz_turret_guy_think()
{
	var_00 = undefined;
	foreach(var_02 in self.riders)
	{
		if(isdefined(var_02.vehicle_position) && var_02.vehicle_position == 3)
		{
			var_00 = var_02;
			var_00 endon("death");
		}

		var_02 thread walker_death_courtyard_kva_cleanup();
	}

	if(!isdefined(var_00))
	{
		return;
	}

	common_scripts\utility::flag_wait("flag_walker_destroyed");
	var_00.health = 1;
	var_00.ignoreme = 0;
}

//Function Number: 141
combat_enemy_trans_heli_wave_01()
{
	common_scripts\utility::flag_wait("flag_mt_move_up_05");
}

//Function Number: 142
combat_zip_rooftop()
{
	common_scripts\utility::flag_wait("flag_combat_zip_rooftop_start");
	var_00 = missile_createrepulsorent(level.warbird_a,5000,1000);
	var_01 = getentarray("enemy_street_zip_rooftop","script_noteworthy");
	foreach(var_03 in var_01)
	{
		var_03 maps\_utility::spawn_ai(1);
	}

	if(level.currentgen)
	{
		var_01 = getentarray("enemy_street_zip_rooftop_left","script_noteworthy");
		var_05 = getentarray("enemy_street_zip_rooftop_right","script_noteworthy");
		var_01 = common_scripts\utility::array_combine(var_01,var_05);
		foreach(var_03 in var_01)
		{
			var_03 maps\_utility::spawn_ai(1);
		}
	}

	if(level.nextgen)
	{
		maps\fusion_utility::spawn_metrics_waittill_deaths_reach(4,["enemy_street_zip_rooftop"],1);
	}
	else
	{
		maps\fusion_utility::spawn_metrics_waittill_deaths_reach(4,["enemy_street_zip_rooftop","enemy_street_zip_rooftop_left","enemy_street_zip_rooftop_right"],1);
	}

	common_scripts\utility::flag_set("flag_burke_zip");
	if(level.nextgen)
	{
		maps\fusion_utility::spawn_metrics_waittill_deaths_reach(6,["enemy_street_zip_rooftop"],1);
	}
	else
	{
		maps\fusion_utility::spawn_metrics_waittill_deaths_reach(6,["enemy_street_zip_rooftop","enemy_street_zip_rooftop_left","enemy_street_zip_rooftop_right"],1);
	}

	var_01 = getentarray("enemy_street_zip_rooftop_strafe","script_noteworthy");
	foreach(var_03 in var_01)
	{
		var_03 maps\_utility::spawn_ai(1);
	}

	waittillframeend;
	if(!common_scripts\utility::flag("flag_rooftop_strafe"))
	{
		common_scripts\utility::flag_set("flag_player_cleared_rooftop");
	}

	if(level.nextgen)
	{
		maps\fusion_utility::spawn_metrics_waittill_deaths_reach(9,["enemy_street_zip_rooftop","enemy_street_zip_rooftop_strafe"],1);
	}
	else
	{
		maps\fusion_utility::spawn_metrics_waittill_deaths_reach(9,["enemy_street_zip_rooftop","enemy_street_zip_rooftop_left","enemy_street_zip_rooftop_right","enemy_street_zip_rooftop_strafe"],1);
	}

	common_scripts\utility::flag_set("flag_combat_zip_rooftop_complete");
	soundscripts\_snd::snd_music_message("mus_combat_zip_rooftop_complete");
}

//Function Number: 143
combat_street_initial()
{
	if(level.currentgen)
	{
		common_scripts\utility::flag_wait("flag_spawn_gaz_01");
	}

	var_00 = getentarray("enemy_street_reactor_entrance","script_noteworthy");
	foreach(var_02 in var_00)
	{
		if(isdefined(var_02))
		{
			var_02 maps\_utility::spawn_ai(1);
		}
	}

	if(level.nextgen)
	{
		common_scripts\utility::flag_wait("flag_spawn_gaz_01");
	}

	var_04 = maps\_vehicle::spawn_vehicle_from_targetname_and_drive("enemy_m_turret_02");
	var_05 = maps\_vehicle::spawn_vehicle_from_targetname_and_drive("enemy_m_turret_01");
	var_04 thread gaz_turret_guy_think();
	var_05 thread gaz_turret_guy_think();
	var_06 = getent("titan_friendly_badplace","targetname");
	badplace_brush("titan_hill_friendly_bad",-1,var_06,"allies");
	common_scripts\utility::flag_wait("flag_obj_01_pos_update_02");
	var_00 = ["enemy_street_reactor_entrance"];
	maps\fusion_utility::delete_spawners(var_00);
	if(level.currentgen)
	{
		level waittill("tff_pre_transition_intro_to_middle");
		var_04 delete();
		var_05 delete();
	}
}

//Function Number: 144
rpg_at_heli()
{
	common_scripts\utility::flag_wait("flag_rpg_at_heli");
	wait(2.5);
	maps\_vehicle::spawn_vehicle_from_targetname_and_drive("rpg_at_heli");
}

//Function Number: 145
rpg_at_squad_01()
{
	maps\_vehicle::spawn_vehicle_from_targetname_and_drive("rpg_at_squad_01");
	wait(1);
	maps\_vehicle::spawn_vehicle_from_targetname_and_drive("rpg_at_squad_02");
}

//Function Number: 146
wall_explosion_01()
{
	var_00 = getentarray("street_wall_1_decal","targetname");
	foreach(var_02 in var_00)
	{
		var_02 hide();
	}

	common_scripts\utility::flag_wait("flag_mt_wall_rpg_fire");
	var_04 = maps\_vehicle::spawn_vehicle_from_targetname_and_drive("rpg_at_wall_01");
	common_scripts\utility::flag_wait("flag_mt_wall_rpg_impact");
	var_05 = getent("blocker_wall_1_explode","targetname");
	var_05 delete();
	foreach(var_02 in var_00)
	{
		var_02 show();
	}

	maps\_utility::activate_trigger_with_targetname("street_wall_1_explode");
	var_08 = common_scripts\utility::getstruct("vfx_street_wall_1_explode","targetname");
	thread maps\fusion_lighting::firelight_volume();
	thread maps\fusion_lighting::firelight_volume2();
	soundscripts\_snd::snd_message("street_wall_1_explode",var_08.origin);
	radiusdamage(var_08.origin,200,200,100,undefined,"MOD_EXPLOSIVE");
	physicsexplosionsphere(var_08.origin,200,10,1);
}

//Function Number: 147
building_explosion_01()
{
	common_scripts\utility::flag_wait("flag_mt_move_up_05");
	maps\_utility::activate_trigger_with_targetname("street_building_top_1_explode");
	var_00 = common_scripts\utility::getstruct("vfx_street_building_1_explode","targetname");
	soundscripts\_snd::snd_message("building_explode",var_00.origin);
	radiusdamage(var_00.origin,200,200,100,undefined,"MOD_EXPLOSIVE");
	physicsexplosionsphere(var_00.origin,200,10,1);
}

//Function Number: 148
spawn_player_anim_rig()
{
	return maps\_utility::spawn_anim_model("player_rig",(0,0,0));
}

//Function Number: 149
courtyard_ambient_explosions()
{
	level.player endon("death");
	level endon("start_itiot");
	level endon("street_cleanup");
	level endon("flag_walker_destroyed");
	common_scripts\utility::flag_wait("flag_ambient_explosions_start");
	childthread courtyard_ambient_bullet_impacts();
}

//Function Number: 150
courtyard_ambient_bullet_impacts()
{
	var_00 = common_scripts\utility::getstructarray("ambient_bullet_origins","targetname");
	var_01 = 0.05;
	if(level.currentgen)
	{
		var_01 = 0.5;
	}

	for(;;)
	{
		var_02 = 0.25;
		var_03 = 0.5;
		if(common_scripts\utility::flag("flag_slow_explosions_1"))
		{
			var_02 = 1.25;
			var_03 = 1.5;
		}

		if(common_scripts\utility::flag("flag_slow_explosions_2"))
		{
			var_02 = 2.25;
			var_03 = 2.5;
		}

		if(level.currentgen)
		{
			var_02 = var_02 * 2;
			var_03 = var_03 * 2;
		}

		wait(randomfloatrange(var_02,var_03));
		var_04 = anglestoforward(level.player.angles);
		var_05 = anglestoright(level.player.angles);
		var_06 = spawn("script_origin",(0,0,0));
		var_04 = var_04 * randomintrange(256,512);
		var_05 = var_05 * randomintrange(-256,256);
		var_07 = randomint(360);
		var_06.angles = (0,var_07,0);
		var_08 = var_00[randomint(var_00.size)];
		var_09 = 0;
		var_0A = level.player.origin + var_04 + var_05;
		var_0B = randomintrange(64,256);
		if(level.currentgen)
		{
			var_0C = randomintrange(2,8);
		}
		else
		{
			var_0C = randomintrange(4,15);
		}

		var_0D = var_0A + anglestoforward(var_06.angles) * var_0B;
		var_0E = var_0D - var_0A;
		var_0F = var_0C * var_01;
		while(var_09 < var_0F)
		{
			var_10 = randomfloat(1);
			if(var_10 < 0.8)
			{
				var_06.origin = var_0A + var_0E * var_09 / var_0F;
				var_11 = randomintrange(-40,40);
				var_12 = randomintrange(-40,40);
				var_13 = randomintrange(-5,5);
				var_06.origin = var_06.origin + (var_11,var_12,var_13);
				if(!maps\_utility::shot_endangers_any_player(var_08.origin,var_06.origin))
				{
					magicbullet("iw5_ak12_sp",var_08.origin,var_06.origin);
					soundscripts\_snd::snd_message("courtyard_ambient_bullet_impact","iw5_ak12_sp",var_08.origin,var_06.origin);
				}
			}

			var_09 = var_09 + var_01;
			wait(var_01);
		}

		var_06 delete();
	}
}

//Function Number: 151
rooftop_slide()
{
	common_scripts\utility::flag_wait("flag_player_zip_started");
	var_00 = getent("rooftop_slide_guy_1","targetname");
	var_00.count++;
	var_01 = var_00 maps\_utility::spawn_ai(1);
	level.get_in_mobile_turret_guy = var_01;
	var_01.animname = "guy1";
	var_01 maps\_utility::deletable_magic_bullet_shield();
	var_02 = [var_01];
	var_03 = undefined;
	if(level.nextgen)
	{
		var_04 = getent("rooftop_slide_guy_2","targetname");
		var_04.count++;
		var_03 = var_04 maps\_utility::spawn_ai(1);
		var_03.animname = "guy2";
		var_03 maps\_utility::deletable_magic_bullet_shield();
		var_02 = common_scripts\utility::array_add(var_02,var_03);
	}

	var_05 = common_scripts\utility::getstruct("struct_rooftop_slide","script_noteworthy");
	var_05 maps\_anim::anim_first_frame(var_02,"fusion_rooftop_slide");
	var_05 maps\_anim::anim_single(var_02,"fusion_rooftop_slide");
	if(isdefined(var_03))
	{
		var_03 maps\_utility::stop_magic_bullet_shield();
	}

	var_06 = getnode("node_mt_guy_after_zip","targetname");
	var_01 thread maps\fusion_utility::goto_node(var_06,0);
	var_01 maps\fusion_utility::disable_awareness();
	var_01 maps\_utility::delaythread(5.5,::guy_approach_mobile_turret);
	if(isdefined(var_03))
	{
		var_07 = getnode("node_cover_joker_after_zip","targetname");
		var_03 maps\fusion_utility::goto_node(var_07,1);
	}

	common_scripts\utility::flag_wait("player_fly_in_done");
	wait(4.5);
	if(isdefined(var_03))
	{
		var_03 maps\_utility::set_force_color("p");
	}
}

//Function Number: 152
hide_water()
{
	if(level.start_point == "fly_in_animated" || level.start_point == "courtyard")
	{
		common_scripts\utility::flag_wait("player_fly_in_done");
	}

	var_00 = getent("water_on","targetname");
	var_00 delete();
}

//Function Number: 153
courtyard_burke_rally()
{
	common_scripts\utility::flag_wait("flag_player_zip_started");
	common_scripts\utility::flag_set("flag_boots_on_ground_dialogue");
	common_scripts\utility::flag_wait("burke_fastzip_done");
	common_scripts\utility::flag_wait("player_fly_in_done");
	waittillframeend;
	level.burke.animname = "burke";
	level.joker.animname = "joker";
	level.carter.animname = "carter";
	level.burke maps\_utility::set_ignoreall(1);
	level.joker maps\_utility::set_ignoreall(1);
	var_00 = common_scripts\utility::getstruct("struct_courtyard_burke_rally","script_noteworthy");
	maps\_utility::delaythread(6,::color_activate_post_burk_rally);
	var_00 maps\_anim::anim_reach_solo(level.burke,"street_burke_rally");
	level.burke maps\_utility::set_ignoreall(0);
	var_00 thread maps\_anim::anim_single_solo_run(level.burke,"street_burke_rally");
	level.burke maps\_utility::enable_ai_color();
	common_scripts\utility::flag_set("flag_burke_rally_street_dialogue");
	level.carter maps\_utility::delaythread(9,::maps\_utility::enable_ai_color);
	level.joker maps\_utility::set_ignoreall(0);
	var_00 maps\_anim::anim_reach_solo(level.joker,"street_burke_rally_in");
	var_00 maps\_anim::anim_single_solo(level.joker,"street_burke_rally_in");
	var_00 thread maps\_anim::anim_loop_solo(level.joker,"street_burke_rally_idle","ender_string");
	wait(2.75);
	var_00 notify("ender_string");
	var_00 maps\_anim::anim_single_solo_run(level.joker,"street_burke_rally_out");
	level.joker maps\_utility::enable_ai_color();
}

//Function Number: 154
color_activate_post_burk_rally()
{
	var_00 = getent("color_t_fastzip_landing","targetname");
	if(isdefined(var_00))
	{
		maps\_utility::activate_trigger_with_targetname("color_t_fastzip_landing");
	}

	level.carter maps\_utility::disable_sprint();
	if(isdefined(var_00))
	{
		var_00 common_scripts\utility::trigger_off();
	}
}

//Function Number: 155
courtyard_mobile_cover_guys()
{
	var_00 = getent("mobile_cover_guy_2","targetname");
	var_00.count++;
	var_01 = var_00 maps\_utility::spawn_ai(1);
	var_01.animname = "guy2";
	var_01 maps\_utility::deletable_magic_bullet_shield();
	var_02 = [var_01];
	var_03 = undefined;
	if(level.nextgen)
	{
		var_04 = getent("mobile_cover_guy_1","targetname");
		var_04.count++;
		var_03 = var_04 maps\_utility::spawn_ai(1);
		var_03.animname = "guy1";
		var_03 maps\_utility::deletable_magic_bullet_shield();
		var_02 = common_scripts\utility::array_add(var_02,var_03);
	}

	var_05 = common_scripts\utility::spawn_tag_origin();
	var_05.origin = (-960.107,-3213.48,-72);
	var_05.angles = (0,11,0);
	var_06 = spawn("script_model",var_05.origin);
	var_06 setmodel("vehicle_mobile_cover");
	var_06 maps\_utility::assign_animtree("mobile_cover");
	var_07 = getent("mobile_cover_courtyard_clip","targetname");
	var_07 connectpaths();
	var_05 thread maps\_anim::anim_first_frame(var_02,"fusion_mobile_cover");
	var_05 thread maps\_anim::anim_first_frame_solo(var_06,"fusion_mobile_cover");
	var_07.origin = var_06.origin;
	var_07 linkto(var_06);
	common_scripts\utility::flag_wait("flag_ambient_explosions_start");
	var_06 thread mobile_cover_badplace();
	var_06 thread mobile_cover_courtyard_start(var_07,var_05);
	var_05 maps\_anim::anim_single_run(var_02,"fusion_mobile_cover");
	var_01 maps\_utility::stop_magic_bullet_shield();
	var_01 kill();
	var_01 startragdoll();
	var_08 = getnode("node_mobile_cover_courtyard","targetname");
	if(isdefined(var_03))
	{
		var_03 maps\fusion_utility::goto_node(var_08,1);
		var_03 maps\_utility::set_force_color("y");
		var_03 maps\_utility::stop_magic_bullet_shield();
	}

	if(level.nextgen)
	{
		level waittill("street_cleanup");
	}
	else
	{
		level waittill("tff_pre_transition_intro_to_middle");
	}

	var_05 delete();
	var_06 delete();
}

//Function Number: 156
mobile_cover_courtyard_start(param_00,param_01)
{
	soundscripts\_snd::snd_message("cvrdrn_paired_anim_start");
	param_01 maps\_anim::anim_single_solo(self,"fusion_mobile_cover");
	soundscripts\_snd::snd_message("cvrdrn_paired_anim_explo");
	mobile_cover_explosion(param_00);
}

//Function Number: 157
mobile_cover_badplace()
{
	self endon("stop_mobile_cover_badplace");
	for(;;)
	{
		badplace_cylinder("mobile_cover_badplace",0.25,self.origin,96,96,"axis","allies");
		wait(0.25);
	}
}

//Function Number: 158
street_mobile_cover_guys()
{
	level.player endon("death");
	common_scripts\utility::flag_wait("flag_mobile_cover_se_2");
	var_00 = common_scripts\utility::getstruct("street_mobile_cover_guys_node","script_noteworthy");
	while(distance(level.player.origin,var_00.origin) < 195 || maps\_utility::player_looking_at(var_00.origin,cos(60),1))
	{
		wait(0.5);
	}

	var_01 = getent("mobile_cover_2_guy_1","targetname");
	var_02 = getent("mobile_cover_2_guy_2","targetname");
	var_01.count++;
	var_02.count++;
	var_03 = var_01 maps\_utility::spawn_ai(1);
	var_04 = var_02 maps\_utility::spawn_ai(1);
	var_03.animname = "guy1";
	var_04.animname = "guy2";
	var_03 maps\_utility::deletable_magic_bullet_shield();
	var_04 maps\_utility::deletable_magic_bullet_shield();
	var_05 = getent("street_mobile_cover_guys_cover","script_noteworthy");
	var_06 = var_05 maps\_utility::spawn_vehicle();
	var_06 maps\_utility::assign_animtree("mobile_cover");
	var_06 vehicle_scripts\_cover_drone::cover_drone_disable();
	var_07 = [var_03,var_04,var_06];
	var_00 thread maps\_anim::anim_first_frame(var_07,"fusion_mobile_cover_2");
	var_00 maps\_anim::anim_single(var_07,"fusion_mobile_cover_2");
	var_06 stopanimscripted();
	var_06 vehicle_scripts\_cover_drone::cover_drone_enable();
	var_03 maps\fusion_utility::disable_awareness();
	var_04 maps\fusion_utility::disable_awareness();
	var_04 maps\fusion_utility::goto_node("node_cover_mb_guy_01",0);
	var_03 maps\fusion_utility::goto_node("node_cover_mb_guy_02",0);
	var_03 maps\fusion_utility::enable_awareness();
	var_04 maps\fusion_utility::enable_awareness();
	var_03 maps\_utility::stop_magic_bullet_shield();
	var_04 maps\_utility::stop_magic_bullet_shield();
	var_07 = [var_03,var_04];
	common_scripts\utility::flag_wait("flag_walker_destroyed");
	foreach(var_09 in var_07)
	{
		if(isalive(var_09))
		{
			var_09 maps\_utility::set_force_color("y");
		}
	}
}

//Function Number: 159
mobile_cover_explosion(param_00)
{
	self notify("stop_mobile_cover_badplace");
	var_01 = spawn("script_origin",(0,0,0));
	var_01.origin = self.origin;
	var_02 = self.angles + (-90,90,0);
	param_00 delete();
	self setmodel("vehicle_mobile_cover_dstrypv");
	playfx(common_scripts\utility::getfx("fusion_vehicle_mobile_cover_explosion"),var_01.origin,anglestoforward(var_02),anglestoup(var_02));
	earthquake(1,1.6,var_01.origin,625);
	radiusdamage(var_01.origin,100,200,100,undefined,"MOD_EXPLOSIVE");
	physicsexplosionsphere(var_01.origin,200,10,1);
	common_scripts\utility::play_sound_in_space("mortar_explosion",var_01.origin);
	var_01 delete();
}

//Function Number: 160
mobile_turret_dropoff()
{
	level.player endon("death");
	common_scripts\utility::flag_wait("flag_player_zip_started");
	wait(3);
	common_scripts\utility::flag_set("cam_shake_start");
	var_00 = common_scripts\utility::getstruct("org_mobile_turret_warbird_deploy","targetname");
	var_01 = maps\_vehicle::spawn_vehicle_from_targetname("warbird_mobile_turret_deploy");
	var_01 soundscripts\_snd::snd_message("warbird_mobile_turret_dropoff");
	var_01.animname = "warbird_deploy";
	var_01 maps\_vehicle::godon();
	var_01 maps\_vehicle::vehicle_lights_on("running");
	var_01 vehicle_turnengineoff();
	var_02 = maps\_utility::spawn_anim_model("walker_deploy");
	var_02.animname = "walker_deploy";
	var_02 soundscripts\_snd::snd_message("walker_mobile_turret_dropoff");
	var_03 = maps\_utility::spawn_anim_model("pulley_deploy");
	var_03.animname = "pulley_deploy";
	var_01 thread custom_dust_kickup();
	var_00 maps\_anim::anim_first_frame([var_01,var_03,var_02],"mobile_turret_deploy");
	var_00 thread play_warbird_mobile_turret_dropoff(var_01,var_03);
	var_00 maps\_anim::anim_single_solo(var_02,"mobile_turret_deploy");
	var_04 = maps\_vehicle::spawn_vehicle_from_targetname("walker_mobile_turret_deploy");
	var_04 soundscripts\_snd::snd_message("spawn_walker_mobile_turret_deploy");
	var_04.animname = "mobile_turret";
	var_04 maps\_vehicle::godon();
	var_04 vehicle_teleport(var_02.origin,var_02.angles);
	var_02 delete();
	common_scripts\utility::flag_set("cam_shake_stop");
	var_05 = getent("clip_mobile_turret_warbird_deploy","targetname");
	var_05 connectpaths();
	var_05 delete();
	var_06 = getent("clip_mobile_turret_warbird_deploy_player","targetname");
	var_06 linkto(var_04);
	thread guy_get_in_mobile_turret(var_04);
	if(level.currentgen)
	{
		level waittill("tff_pre_transition_intro_to_middle");
		var_04 delete();
	}
}

//Function Number: 161
guy_approach_mobile_turret()
{
}

//Function Number: 162
custom_dust_kickup()
{
	wait(0.05);
	self notify("stop_kicking_up_dust");
	var_00 = common_scripts\utility::spawn_tag_origin();
	var_00 linkto(self,"tag_origin",(0,-150,-100),(0,0,0));
	thread maps\_vehicle::aircraft_wash(var_00);
	self waittill("death");
	self notify("stop_kicking_up_dust");
	var_00 delete();
}

//Function Number: 163
courtyard_ally_mcd_safeguard_init()
{
	common_scripts\utility::array_thread(getentarray("courtyard_trig_ally_mcd_safeguard","targetname"),::courtyard_ally_mcd_safeguard);
}

//Function Number: 164
courtyard_ally_mcd_safeguard()
{
	level endon("flag_walker_destroyed");
	var_00 = getent(self.target,"targetname");
	var_01 = common_scripts\utility::getstructarray("courtyard_pos_ally_mcd_safeguard","targetname");
	for(;;)
	{
		self waittill("trigger",var_02);
		var_03 = [level.carter,level.joker,level.burke];
		foreach(var_07, var_05 in var_03)
		{
			var_06 = var_01[var_07];
			if(var_05 istouching(var_00) && !maps\_utility::player_can_see_ai(var_05) && !maps\_utility::player_looking_at(var_06.origin,undefined,1))
			{
				var_05 forceteleport(var_06.origin,var_06.angles);
			}
		}
	}
}

//Function Number: 165
play_warbird_mobile_turret_dropoff(param_00,param_01)
{
	maps\_anim::anim_single([param_00,param_01],"mobile_turret_deploy");
	param_01 linkto(param_00);
	param_00 maps\_utility::vehicle_detachfrompath();
	param_00 vehicle_setspeed(60,15,5);
	var_02 = common_scripts\utility::getstruct("warbird_path_after_turret_deploy","targetname");
	param_00 thread maps\_utility::vehicle_dynamicpath(var_02,0);
	common_scripts\utility::flag_wait("warbird_turret_deploy_delete");
	param_01 delete();
	param_00 delete();
}

//Function Number: 166
guy_get_in_mobile_turret(param_00)
{
	level.player endon("death");
	if(level.nextgen)
	{
		level endon("street_cleanup");
	}
	else
	{
		level endon("tff_pre_transition_intro_to_middle");
	}

	var_01 = level.get_in_mobile_turret_guy;
	var_01 notify("guy_getting_in_mobile_turret");
	var_02 = getdvarint("ai_friendlySuppression");
	setsaveddvar("ai_friendlySuppression",0);
	var_01 maps\fusion_utility::disable_awareness();
	var_01 pushplayer(1);
	var_01 maps\_utility::delaythread(2,::maps\_utility::enable_sprint);
	param_00 maps\_anim::anim_reach_solo(var_01,"guy_enter_mobile_turret","tag_guy");
	param_00 thread maps\_anim::anim_single_solo(var_01,"guy_enter_mobile_turret","tag_guy");
	param_00 maps\_anim::anim_single_solo(param_00,"guy_enter_mobile_turret");
	setsaveddvar("ai_friendlySuppression",var_02);
	param_00 thread maps\_vehicle_aianim::guy_enter(var_01);
	level.get_in_mobile_turret_guy = undefined;
	var_03 = getvehiclenode("deployed_turret_path","targetname");
	param_00.target = "deployed_turret_path";
	param_00 thread maps\_vehicle_code::getonpath();
	param_00 thread mobile_turret_gopath();
	param_00 thread monitor_turret_2_death();
	param_00 thread maps\fusion_utility::kill_path_on_death();
	common_scripts\utility::flag_wait("flag_mt_wall_rpg_fire");
	param_00 notify("stop_vehicle_turret_ai");
	var_04 = common_scripts\utility::spawn_tag_origin();
	var_04 linkto(param_00,"tag_body",(10000,0,0),(0,0,0));
	param_00 setturrettargetent(var_04);
	common_scripts\utility::flag_wait("flag_mt_wall_rpg_impact");
	wait(0.25);
	param_00 maps\_vehicle::godoff();
	param_00 dodamage(param_00.health + 200,(0,0,0));
	param_00 thread walker_guy_death(var_01);
	var_04 delete();
}

//Function Number: 167
walker_guy_death(param_00)
{
	var_01 = %x4walker_wheels_destructed_death_right_npc;
	param_00 = maps\_vehicle_aianim::convert_guy_to_drone(param_00,0,0);
	[[ level.global_kill_func ]]("MOD_RIFLE_BULLET","torso_upper",param_00.origin);
	param_00 linkto(self,"tag_guy",(0,0,0),(0,0,0));
	param_00 notsolid();
	param_00 setflaggedanim("death",var_01);
	param_00 thread maps\fusion_fx::set_guy_on_fire();
	var_02 = getanimlength(var_01);
	var_03 = getnotetracktimes(var_01,"start_ragdoll");
	if(isdefined(var_03) && var_03.size > 0)
	{
		var_02 = var_02 * var_03[0];
	}
	else
	{
		var_02 = var_02 - 0.15;
	}

	wait(var_02);
	param_00 unlink();
}

//Function Number: 168
enemy_walker()
{
	common_scripts\utility::flag_wait("flag_enemy_walker");
	level.walker = maps\_vehicle::spawn_vehicle_from_targetname("enemy_walker");
	level.walker thread enemy_walker_set_launcher_targets();
	level.walker soundscripts\_snd::snd_message("titan_init");
	common_scripts\utility::flag_set("update_obj_pos_walker");
	level.walker.mobile_turret_rocket_target = 0;
	level.walker thread walker_anims();
	level.walker thread manage_walker_health();
	level.walker thread walker_trophy_system();
	level.walker thread walker_badplace();
	level.walker thread enemy_walker_kill_player_if_too_close();
	thread launcher_out_of_ammo_think();
	thread enemy_walker_target_player_if_targeted();
	if(isalive(level.walker))
	{
		level.walker waittill("death");
	}

	level.walker setcontents(0);
	common_scripts\utility::flag_set("flag_walker_destroyed");
	common_scripts\utility::flag_set("update_obj_pos_security_entrance_1");
	if(level.nextgen)
	{
		thread spawn_more_allies();
	}

	maps\_utility::delaythread(2,::maps\_utility::autosave_now);
	var_00 = getent("color_t_street_end","targetname");
	var_00 common_scripts\utility::trigger_on();
	wait(1);
	if(isdefined(var_00))
	{
		maps\_utility::activate_trigger_with_targetname("color_t_street_end");
	}
}

//Function Number: 169
launcher_out_of_ammo_think()
{
	level endon("flag_walker_destroyed");
	level.active_objective = [];
	level.inactive_objective = [];
	var_00 = getent("org_obj_get_launcher_ammo","targetname");
	objective_add(maps\_utility::obj("obj_launcher_ammo"),"invisible","",var_00.origin);
	maps\_utility::set_objective_inactive("obj_launcher_ammo");
	for(;;)
	{
		wait(0.5);
		if(isalive(level.walker))
		{
			var_01 = level.player getweaponslist("primary");
			if(!common_scripts\utility::array_contains(var_01,"iw5_stingerm7_sp"))
			{
				launcher_out_of_ammo_obj_clear(var_00);
				continue;
			}

			foreach(var_03 in var_01)
			{
				if(issubstr(var_03,"iw5_stingerm7_sp"))
				{
					if(level.player getammocount("iw5_stingerm7_sp") > 0)
					{
						launcher_out_of_ammo_obj_clear(var_00);
						common_scripts\utility::flag_clear("flag_launcher_out_of_ammo");
						common_scripts\utility::flag_set("flag_launcher_ammo_gathered");
					}

					if(level.player getammocount("iw5_stingerm7_sp") == 0)
					{
						launcher_out_of_ammo_obj(var_00,var_01);
						common_scripts\utility::flag_set("flag_launcher_out_of_ammo");
						common_scripts\utility::flag_clear("flag_launcher_ammo_gathered");
					}
				}
			}
		}
	}
}

//Function Number: 170
launcher_out_of_ammo_obj(param_00,param_01)
{
	wait(0.5);
	foreach(var_03 in param_01)
	{
		if(issubstr(var_03,"iw5_stingerm7_sp"))
		{
			if(level.player getammocount("iw5_stingerm7_sp") == 0)
			{
				if(maps\_utility::objective_is_inactive("obj_launcher_ammo"))
				{
					objective_state_nomessage(maps\_utility::obj("obj_launcher_ammo"),"active");
					objective_current_nomessage(maps\_utility::obj("obj_launcher_ammo"),maps\_utility::obj("shutdown_reactor"));
					objective_setpointertextoverride(maps\_utility::obj("obj_launcher_ammo"),&"FUSION_OBJ_AMMO_CRATE");
					maps\_utility::set_objective_active("obj_launcher_ammo");
				}
			}
		}
	}
}

//Function Number: 171
launcher_out_of_ammo_obj_clear(param_00)
{
	if(maps\_utility::objective_is_active("obj_launcher_ammo"))
	{
		objective_delete(maps\_utility::obj("obj_launcher_ammo"));
	}
}

//Function Number: 172
enemy_walker_set_launcher_targets()
{
	while(!thread does_player_have_smaw())
	{
		wait 0.05;
	}

	level.scripttargets = [];
	var_00 = ["kneeb_fr","kneeb_fl","kneeb_kr","kneeb_kl","shoulder_fl","shoulder_fr","launcher_left","launcher_right","tag_sparks2","tag_sparks3"];
	foreach(var_04, var_02 in var_00)
	{
		var_03[var_04] = common_scripts\utility::spawn_tag_origin();
		var_03[var_04].origin = self gettagorigin(var_02);
		var_03[var_04].stinger_override_tags = ["tag_origin"];
		var_03[var_04].script_team = "axis";
		var_03[var_04] linkto(level.walker,var_02);
		var_03[var_04].health = 100;
		var_03[var_04].walkernode = 1;
		level.scripttargets[level.scripttargets.size] = var_03[var_04];
	}
}

//Function Number: 173
enemy_walker_kill_player_if_too_close()
{
	self endon("death");
	common_scripts\utility::flag_wait("player_too_close_to_walker");
	maps\_vehicle::godon();
	level.player endon("death");
	level.player enablehealthshield(0);
	foreach(var_01 in self.mgturret)
	{
		var_01 notify("stop_vehicle_turret_ai");
		var_01 thread walker_tank_turret_fire_at_player(level.player);
	}

	for(;;)
	{
		level.player dodamage(15 / level.player.damagemultiplier,self.origin,self);
		var_03 = randomfloatrange(0.1,0.3);
		wait(var_03);
	}
}

//Function Number: 174
enemy_walker_target_player_if_targeted()
{
	self endon("flag_walker_destroyed");
	var_00 = 0;
	var_01 = 0;
	if(isdefined(level.player.stingerm7_info) && isdefined(level.player.stingerm7_info.locked_targets))
	{
		var_01 = level.player.stingerm7_info.locked_targets.size;
	}

	var_00 = var_01;
	for(;;)
	{
		if(isdefined(level.player.stingerm7_info) && isdefined(level.player.stingerm7_info.locked_targets))
		{
			var_01 = level.player.stingerm7_info.locked_targets.size;
		}

		if(var_00 != var_01)
		{
			if(var_01 == 0)
			{
				walker_tank_turret_fire_at_player_clear();
			}

			if(isdefined(level.player.stingerm7_info) && isdefined(level.player.stingerm7_info.locked_targets))
			{
				var_02 = level.player.stingerm7_info.locked_targets;
				foreach(var_04 in var_02)
				{
					if(isdefined(var_04.ent.walkernode) && var_04.ent.walkernode == 1)
					{
						thread walker_tank_turret_fire_at_player_think();
					}
				}
			}
		}

		var_00 = var_01;
		wait 0.05;
	}
}

//Function Number: 175
walker_tank_turret_fire_at_player_think()
{
	self notify("walker_hit");
	self endon("walker_hit");
	level endon("flag_walker_death_anim_start");
	level.walker vehicle_scripts\_vehicle_turret_ai::vehicle_set_forced_target(level.player);
}

//Function Number: 176
walker_tank_turret_fire_at_player_clear()
{
	level.walker.ai_target_force_scripted = undefined;
}

//Function Number: 177
walker_tank_turret_fire_at_player(param_00)
{
	self endon("death");
	self endon("stop_vehicle_turret_ai");
	self setturretteam("axis");
	self setmode("manual");
	self settargetentity(param_00);
	self turretfireenable();
	self startfiring();
}

//Function Number: 178
spawn_more_allies()
{
	var_00 = getentarray("allies_street_end","script_noteworthy");
	foreach(var_02 in var_00)
	{
		if(isdefined(var_02))
		{
			var_02 maps\_utility::spawn_ai(1);
		}
	}
}

//Function Number: 179
combat_street_seeker_ai()
{
	var_00 = 1;
	var_01 = [];
	while(!common_scripts\utility::flag("flag_enemy_walker"))
	{
		var_02 = getaiarray("axis");
		wait 0.05;
		var_01 = [];
		for(var_03 = 0;var_03 < var_00;var_03++)
		{
			if(var_02.size > var_03)
			{
				var_04 = var_02[var_03];
				if(isalive(var_04))
				{
					if(isdefined(var_04.magic_bullet_shield))
					{
						var_04 maps\_utility::stop_magic_bullet_shield();
					}

					var_04.playerseeker = 1;
					var_04 cleargoalvolume();
					var_04 thread maps\_utility::player_seek();
					var_04.favoriteenemy = level.player;
					var_01[var_01.size] = var_04;
				}
			}
		}

		if(var_01.size > 0)
		{
			maps\_utility::array_wait(var_01,"death");
		}

		if(common_scripts\utility::flag("player_in_x4walker"))
		{
			common_scripts\utility::flag_waitopen("player_in_x4walker");
		}

		wait(5);
	}

	foreach(var_06 in var_01)
	{
		if(isalive(var_06))
		{
			var_06 notify("goal");
		}
	}
}

//Function Number: 180
walker_badplace()
{
	while(!common_scripts\utility::flag("flag_walker_tank_on_mount"))
	{
		badplace_cylinder("walker_tank_badplace",0.5,self.origin,280,300,"axis","team3","allies");
		wait(0.55);
	}
}

//Function Number: 181
walker_missile_barrage()
{
	wait(0.25);
	var_00 = maps\_vehicle::spawn_vehicle_from_targetname_and_drive("tank_missile_01");
	playfxontag(common_scripts\utility::getfx("walker_tank_rocket_wv"),var_00,"tag_origin");
	var_00 soundscripts\_snd::snd_message("titan_missile");
	wait(0.15);
	var_01 = maps\_vehicle::spawn_vehicle_from_targetname_and_drive("tank_missile_02");
	playfxontag(common_scripts\utility::getfx("walker_tank_rocket_wv"),var_01,"tag_origin");
	var_01 soundscripts\_snd::snd_message("titan_missile");
	wait(0.15);
	var_02 = maps\_vehicle::spawn_vehicle_from_targetname_and_drive("tank_missile_03");
	playfxontag(common_scripts\utility::getfx("walker_tank_rocket_wv"),var_02,"tag_origin");
	var_02 soundscripts\_snd::snd_message("titan_missile");
	wait(1.15);
	var_03 = maps\_vehicle::spawn_vehicle_from_targetname_and_drive("tank_missile_04");
	playfxontag(common_scripts\utility::getfx("walker_tank_rocket_wv"),var_03,"tag_origin");
	var_03 soundscripts\_snd::snd_message("titan_missile");
	wait(0.15);
	var_04 = maps\_vehicle::spawn_vehicle_from_targetname_and_drive("tank_missile_05");
	playfxontag(common_scripts\utility::getfx("walker_tank_rocket_wv"),var_04,"tag_origin");
	var_04 soundscripts\_snd::snd_message("titan_missile");
	wait(0.15);
	var_05 = maps\_vehicle::spawn_vehicle_from_targetname_and_drive("tank_missile_06");
	playfxontag(common_scripts\utility::getfx("walker_tank_rocket_wv"),var_05,"tag_origin");
	var_05 soundscripts\_snd::snd_message("titan_missile");
	wait(0.15);
	var_06 = maps\_vehicle::spawn_vehicle_from_targetname_and_drive("tank_missile_07");
	playfxontag(common_scripts\utility::getfx("walker_tank_rocket_wv"),var_06,"tag_origin");
	var_06 soundscripts\_snd::snd_message("titan_missile");
}

//Function Number: 182
walker_anims()
{
	self endon("stop_walker_tank_anims");
	level.player endon("death");
	self.animname = "walker_tank";
	var_00 = common_scripts\utility::getstruct("org_enemy_walker","targetname");
	soundscripts\_snd::snd_message("titan_enter");
	var_00 maps\_anim::anim_single_solo(self,"fusion_walker_tank_enter");
	self.state = "forward";
	self.death_state = "forward";
	self.prev_state = "forward";
	common_scripts\utility::flag_set("flag_walker_tank_on_mount");
	var_00 thread maps\_anim::anim_loop_solo(self,"fusion_walker_tank_fwd_idle","walker_stop_idle");
	self disconnectpaths();
	for(;;)
	{
		wait(randomfloatrange(5,10));
		var_01 = [];
		switch(self.state)
		{
			case "forward":
				var_01 = ["left","right"];
				break;
	
			case "left":
				var_01 = ["forward","right"];
				break;
	
			case "right":
				var_01 = ["forward","left"];
				break;
		}

		self.prev_state = self.state;
		if(common_scripts\utility::cointoss())
		{
			self.state = var_01[0];
		}
		else
		{
			self.state = var_01[1];
		}

		var_00 notify("walker_stop_idle");
		if(self.state == "left")
		{
			if(self.prev_state == "right")
			{
				self.death_state = "right";
				var_00 maps\_anim::anim_single_solo(self,"fusion_walker_tank_right_2_fwd");
				self.death_state = "forward";
			}

			var_00 maps\_anim::anim_single_solo(self,"fusion_walker_tank_fwd_2_left");
			self.death_state = "left";
			var_00 thread maps\_anim::anim_loop_solo(self,"fusion_walker_tank_left_idle","walker_stop_idle");
		}

		if(self.state == "right")
		{
			if(self.prev_state == "left")
			{
				self.death_state = "left";
				var_00 maps\_anim::anim_single_solo(self,"fusion_walker_tank_left_2_fwd");
				self.death_state = "forward";
			}

			var_00 maps\_anim::anim_single_solo(self,"fusion_walker_tank_fwd_2_right");
			self.death_state = "right";
			var_00 thread maps\_anim::anim_loop_solo(self,"fusion_walker_tank_right_idle","walker_stop_idle");
		}

		if(self.state == "forward")
		{
			if(self.prev_state == "left")
			{
				self.death_state = "left";
				var_00 maps\_anim::anim_single_solo(self,"fusion_walker_tank_left_2_fwd");
			}

			if(self.prev_state == "right")
			{
				self.death_state = "right";
				var_00 maps\_anim::anim_single_solo(self,"fusion_walker_tank_right_2_fwd");
			}

			self.death_state = "forward";
			var_00 thread maps\_anim::anim_loop_solo(self,"fusion_walker_tank_fwd_idle","walker_stop_idle");
		}
	}
}

//Function Number: 183
walker_trophy_system()
{
	self endon("death");
	level.player endon("death");
	self.trophy_count = 5;
	self.current_projectile = 1;
	while(self.trophy_count >= 0)
	{
		level waittill("stinger_fired",var_00,var_01);
		foreach(var_03 in var_01)
		{
			thread player_projectile_think(var_03,self);
		}
	}
}

//Function Number: 184
player_projectile_think(param_00,param_01)
{
	level.player endon("projectile_impact");
	param_00 endon("death");
	param_01 endon("death");
	level.player endon("death");
	var_02 = 512;
	if(param_01.trophy_count <= 0)
	{
		return;
	}

	while(isdefined(param_00))
	{
		var_03 = distance(param_00.origin,param_01.origin);
		if(var_03 <= var_02)
		{
			playfx(common_scripts\utility::getfx("trophy_ignition_smoke"),param_01.origin + (0,0,96));
			playfx(common_scripts\utility::getfx("trophy_explosion"),param_00.origin);
			soundscripts\_snd::snd_message("trophy_system_explosion",param_00.origin);
			param_01.trophy_count--;
			if(param_01.current_projectile <= 2)
			{
				common_scripts\utility::flag_set("walker_trophy_" + param_01.current_projectile);
			}

			param_01.current_projectile++;
			param_00 delete();
		}

		wait(0.05);
	}
}

//Function Number: 185
manage_walker_health()
{
	self endon("death");
	level.player endon("death");
	maps\_vehicle::godon();
	thread walker_damage_fx();
	wait_for_walker_to_be_hit_by_smaw();
	common_scripts\utility::flag_set("walker_damaged");
	wait(1);
	wait_for_walker_to_be_hit_by_smaw();
	objective_state_nomessage(maps\_utility::obj("use_smaw"),"done");
	objective_state_nomessage(maps\_utility::obj("obj_launcher_ammo"),"done");
	self notify("stop_vehicle_turret_ai");
	self notify("stop_walker_tank_anims");
	foreach(var_01 in level.scripttargets)
	{
		if(isdefined(var_01) && var_01.health > 0)
		{
			var_01 kill();
		}
	}

	level.stinger_targets = common_scripts\utility::array_remove_array(level.stinger_targets,level.scripttargets);
	maps\_utility::array_delete(level.scripttargets);
	level.scripttargets = undefined;
	walker_play_death_anim();
}

//Function Number: 186
wait_for_walker_to_be_hit_by_smaw()
{
	level.player endon("death");
	for(;;)
	{
		self waittill("damage",var_00,var_01,var_02,var_03,var_04,var_05,var_06,var_07,var_08,var_09);
		if(isplayer(var_01) && var_04 == "MOD_PROJECTILE" && var_09 == "iw5_stingerm7_sp")
		{
			soundscripts\_snd::snd_message("titan_take_damage_from_smaw");
			break;
		}
	}
}

//Function Number: 187
walker_damage_fx()
{
	common_scripts\utility::flag_wait("walker_damaged");
	playfxontag(common_scripts\utility::getfx("vehicle_damaged_sparks_l"),self,"TAG_SPARKS1");
	thread maps\_utility::play_sound_on_tag("titan_take_smaw_dmg_sparks","TAG_SPARKS1",1);
	wait 0.05;
	playfxontag(common_scripts\utility::getfx("vehicle_damaged_sparks_l"),self,"TAG_SPARKS2");
	thread maps\_utility::play_sound_on_tag("titan_take_smaw_dmg_sparks","TAG_SPARKS1",1);
	wait 0.05;
	playfxontag(common_scripts\utility::getfx("vehicle_damaged_sparks_l"),self,"TAG_SPARKS3");
	thread maps\_utility::play_sound_on_tag("titan_take_smaw_dmg_sparks","TAG_SPARKS1",1);
	wait 0.05;
	playfxontag(common_scripts\utility::getfx("vehicle_damaged_sparks_l"),self,"TAG_SPARKS4");
	thread maps\_utility::play_sound_on_tag("titan_take_smaw_dmg_sparks","TAG_SPARKS1",1);
	wait 0.05;
}

//Function Number: 188
walker_play_death_anim()
{
	common_scripts\utility::flag_set("flag_walker_death_anim_start");
	var_00 = "";
	switch(self.death_state)
	{
		case "forward":
			var_00 = "fusion_walker_tank_fwd_idle_death";
			break;

		case "left":
			var_00 = "fusion_walker_tank_left_idle_death";
			break;

		case "right":
			var_00 = "fusion_walker_tank_right_idle_death";
			break;
	}

	var_01 = common_scripts\utility::getstruct("org_enemy_walker","targetname");
	thread maps\fusion_fx::walker_dying_fx();
	soundscripts\_snd::snd_message("titan_death");
	var_01 maps\_anim::anim_single_solo(self,var_00);
}

//Function Number: 189
destroy_walker_tank(param_00)
{
	param_00 vehicle_teleport(param_00.origin,param_00.angles - (0,28.225,0));
	param_00 setmodel("vehicle_walker_tank_dstrypv");
	playfxontag(common_scripts\utility::getfx("walker_explosion"),param_00,"TAG_DEATH_FX");
	var_01 = param_00.origin;
	var_02 = param_00 gettagorigin("TAG_FIRE");
	var_03 = param_00 gettagangles("TAG_FIRE");
	var_04 = param_00 gettagorigin("TAG_FIRE2");
	var_05 = param_00 gettagangles("TAG_FIRE2");
	var_06 = param_00 gettagorigin("TAG_SPARKS");
	var_07 = param_00 gettagorigin("TAG_SPARKS");
	param_00 kill(param_00.origin,level.player);
	wait(0.1);
	earthquake(1,1.6,var_01,1350);
	radiusdamage(var_01,400,200,100,undefined,"MOD_EXPLOSIVE");
	physicsexplosionsphere(var_01,400,10,1);
	wait(1);
	playfx(common_scripts\utility::getfx("vehicle_destroyed_fire_m"),var_02,anglestoforward(var_03),anglestoup(var_03));
	playfx(common_scripts\utility::getfx("vehicle_destroyed_fire_m"),var_04,anglestoforward(var_05),anglestoup(var_05));
	playfx(common_scripts\utility::getfx("electrical_sparks_runner"),var_06,anglestoforward(var_07),anglestoup(var_07));
}

//Function Number: 190
add_to_javelin_targeting()
{
	target_set(self,(0,0,56));
	target_setjavelinonly(self,1);
	if(isalive(level.walker))
	{
		self waittill("death");
	}

	target_remove(self);
}

//Function Number: 191
btr_turret_think()
{
	self endon("death");
	self endon("kill_btr_turret_think");
	thread maps\_vehicle::vehicle_turret_scan_on();
	for(;;)
	{
		wait(randomfloatrange(0.3,0.8));
		var_00 = btr_get_target();
		if(isdefined(var_00))
		{
			btr_fire_at_target(var_00);
			wait(0.3);
		}
	}
}

//Function Number: 192
btr_fire_at_target(param_00)
{
	param_00 endon("death");
	level endon("walker_death_anim_started");
	self setturrettargetent(param_00,(0,0,32));
	if(common_scripts\utility::cointoss())
	{
		if(isdefined(self.mgturret))
		{
			foreach(var_02 in self.mgturret)
			{
				if(isdefined(var_02))
				{
					var_02 setturretteam("axis");
					var_02 setmode("manual");
					var_02 settargetentity(param_00);
					var_02 startfiring();
				}
			}
		}

		wait(randomfloatrange(3,5));
		if(isdefined(self.mgturret))
		{
			foreach(var_02 in self.mgturret)
			{
				if(isdefined(var_02))
				{
					var_02 cleartargetentity();
					var_02 stopfiring();
				}
			}

			return;
		}

		return;
	}

	for(var_06 = 0;var_06 < randomintrange(1,3);var_06++)
	{
		burst_fire_weapon();
		wait(0.5);
	}
}

//Function Number: 193
burst_fire_weapon()
{
	for(var_00 = 0;var_00 < randomintrange(2,4);var_00++)
	{
		self fireweapon();
		wait(0.2);
	}
}

//Function Number: 194
btr_get_target()
{
	var_00 = 4;
	var_01 = getaiarray("allies");
	for(var_02 = 0;var_02 < var_00;var_02++)
	{
		var_01[var_01.size] = level.player;
	}

	return common_scripts\utility::random(var_01);
}

//Function Number: 195
reactor_entrance_rally()
{
	var_00 = getentarray("security_door_right","targetname");
	var_01 = getentarray("security_door_left","targetname");
	foreach(var_03 in var_00)
	{
		if(var_03.classname == "script_brushmodel")
		{
			var_03 disconnectpaths();
		}
	}

	foreach(var_03 in var_01)
	{
		if(var_03.classname == "script_brushmodel")
		{
			var_03 disconnectpaths();
		}
	}

	common_scripts\utility::flag_wait("flag_walker_destroyed");
	var_07 = common_scripts\utility::getstruct("security_doors_animnode","targetname");
	var_08 = spawn("script_origin",var_07.origin);
	var_08.angles = var_07.angles;
	var_09 = "fusion_security_doors_approach";
	var_0A = "fusion_security_doors_idle";
	var_0B = "fusion_security_doors_open";
	var_0C = "security_door_ender";
	var_0D = [];
	var_0D[var_0D.size] = level.burke;
	var_0D[var_0D.size] = level.carter;
	var_0E = maps\_utility::spawn_anim_model("security_door_right");
	var_0F = maps\_utility::spawn_anim_model("security_door_left");
	var_10 = [];
	var_10[var_10.size] = var_0E;
	var_10[var_10.size] = var_0F;
	var_08 maps\_anim::anim_first_frame(var_10,var_0B);
	foreach(var_03 in var_00)
	{
		var_03 linkto(var_0E,"tag_origin_animated");
	}

	foreach(var_03 in var_01)
	{
		var_03 linkto(var_0F,"tag_origin_animated");
	}

	level.burke thread security_doors_approach(var_08,var_09,var_0A,var_0C);
	level.carter thread security_doors_approach(var_08,var_09,var_0A,var_0C);
	level waittill("security_door_npc_ready");
	level waittill("security_door_npc_ready");
	common_scripts\utility::flag_wait("flag_player_at_reactor_door");
	var_08 notify(var_0C);
	var_08 thread maps\_anim::anim_single_solo_run(level.burke,var_0B);
	var_08 thread maps\_anim::anim_single_solo(var_0E,var_0B);
	wait(0.5);
	var_08 thread maps\_anim::anim_single_solo_run(level.carter,var_0B);
	var_08 thread maps\_anim::anim_single_solo(var_0F,var_0B);
	foreach(var_03 in var_00)
	{
		if(var_03.classname == "script_brushmodel")
		{
			var_03 connectpaths();
		}
	}

	foreach(var_03 in var_01)
	{
		if(var_03.classname == "script_brushmodel")
		{
			var_03 connectpaths();
		}
	}

	maps\_utility::activate_trigger_with_targetname("security_room_doors_open");
}

//Function Number: 196
security_doors_approach(param_00,param_01,param_02,param_03)
{
	maps\_utility::disable_ai_color();
	self notify("stop_goto_node");
	self notify("goal");
	param_00 maps\_anim::anim_reach_solo(self,param_01);
	param_00 maps\_anim::anim_single_solo(self,param_01);
	maps\_utility::enable_cqbwalk();
	level notify("security_door_npc_ready");
	maps\_utility::enable_ai_color();
	param_00 maps\_anim::anim_loop_solo(self,param_02,param_03);
}

//Function Number: 197
reactor_entrance_rally_anim(param_00)
{
	self endon("death");
	var_01 = self.animname + "_ender";
	maps\_utility::disable_ai_color();
	param_00 maps\_anim::anim_reach_solo(self,"reactor_entrance_st");
	maps\_utility::ent_flag_set("flag_reactor_entrance_ready");
	param_00 maps\_anim::anim_single_solo(self,"reactor_entrance_st");
	param_00 thread maps\_anim::anim_loop_solo(self,"reactor_entrance_idle",var_01);
	common_scripts\utility::flag_wait("interior_allies");
	param_00 notify(var_01);
}

//Function Number: 198
postspawn_rpg_vehicle()
{
	self setmodel("projectile_rpg7");
	var_00 = common_scripts\utility::getfx("rpg_trail");
	playfxontag(var_00,self,"tag_origin");
	var_00 = common_scripts\utility::getfx("rpg_muzzle");
	playfxontag(var_00,self,"tag_origin");
	self playsound("weap_rpg_fire_npc");
	if(isdefined(self.script_sound))
	{
		if(isdefined(self.script_wait))
		{
			common_scripts\utility::delaycall(self.script_wait,::playsound,self.script_sound);
		}
		else
		{
			self playsound(self.script_sound);
		}
	}
	else
	{
		self playloopsound("weap_rpg_loop");
	}

	self waittill("reached_end_node");
	self notify("explode",self.origin);
	var_01 = 0;
	if(isdefined(self.script_exploder))
	{
		common_scripts\_exploder::exploder(self.script_exploder);
		var_01 = 1;
	}
	else if(isdefined(self.currentnode))
	{
		var_02 = undefined;
		var_03 = self.currentnode;
		while(isdefined(var_03))
		{
			var_02 = var_03;
			if(!isdefined(var_03.target))
			{
				break;
			}

			var_03 = getvehiclenode(var_03.target,"targetname");
		}

		if(isdefined(var_02.target))
		{
			var_04 = common_scripts\utility::getstruct(var_02.target,"targetname");
			if(isdefined(var_04))
			{
				level thread rpg_explosion(var_04.origin,var_04.angles);
				var_01 = 1;
			}
		}
	}

	if(!var_01)
	{
		var_04 = spawnstruct();
		var_04.origin = self.origin;
		var_04.angles = (-90,0,0);
		level thread rpg_explosion(var_04.origin,var_04.angles);
	}

	self delete();
}

//Function Number: 199
rpg_explosion(param_00,param_01)
{
	var_02 = common_scripts\utility::getfx("rpg_explode");
	playfx(var_02,param_00,anglestoforward(param_01),anglestoup(param_01));
	radiusdamage(param_00,200,150,50);
	thread common_scripts\utility::play_sound_in_space("null",param_00);
}

//Function Number: 200
interior_gameplay()
{
	thread interior_allies();
	thread security_room();
	thread laboratory();
	thread reactor_room();
	thread turbine_room();
	thread control_room();
	level.pipesdamage = 0;
}

//Function Number: 201
interior_allies()
{
	waittillframeend;
	common_scripts\utility::flag_wait_any("interior_allies","flag_walker_destroyed");
	level.burke maps\_utility::set_force_color("r");
	level.joker maps\_utility::set_force_color("g");
	level.carter maps\_utility::set_force_color("o");
}

//Function Number: 202
security_room()
{
	if(level.start_point != "fly_in_animated" && level.start_point != "fly_in_animated_part2" && level.start_point != "courtyard" && level.start_point != "security_room")
	{
		return;
	}

	common_scripts\utility::flag_wait_any("interior_allies","flag_walker_destroyed");
	var_00 = "security_room_check_corpse";
	var_01 = "security_room_check_corpse_idle";
	var_02 = "security_room_check_corpse_idle_stop";
	var_03 = getent("fusion_security_room_corpse","targetname") maps\_utility::spawn_ai(1);
	var_03 setcontents(0);
	var_03.animname = "generic";
	var_04 = common_scripts\utility::getstruct("fusion_security_room_corpse_fall_npc","targetname");
	var_05 = spawn("script_origin",var_04.origin);
	var_06 = (0,0,0);
	if(isdefined(var_04.angles))
	{
		var_06 = var_04.angles;
		var_05.angles = var_04.angles;
	}

	var_03 clearanim(%body,0.2);
	var_03 stopanimscripted();
	var_05 maps\_anim::anim_first_frame_solo(var_03,var_00);
	wait(0.05);
	var_07 = spawn("script_model",var_03 gettagorigin("TAG_WEAPON_RIGHT"));
	var_07.angles = var_03 gettagangles("TAG_WEAPON_RIGHT");
	var_07 setmodel("npc_m160");
	var_07 linkto(var_03,"TAG_WEAPON_RIGHT");
	var_08 = getent("security_room_elevator_doors","targetname");
	var_08 maps\_utility::assign_animtree("security_room_elevator_doors");
	var_05 maps\_anim::anim_first_frame_solo(var_08,"security_room_open_elevator");
	var_09 = getent("security_elevator_door_left","targetname");
	var_0A = getent("security_elevator_door_right","targetname");
	var_09 linkto(var_08,"elevator_back_left_jnt");
	var_0A linkto(var_08,"elevator_back_right_jnt");
	common_scripts\utility::flag_wait("security_room_check_corpse");
	maps\_utility::battlechatter_off("allies");
	level.burke thread start_cqb_when_near(getstartorigin(var_05.origin,var_06,level.scr_anim["burke"][var_00]));
	var_05 maps\_anim::anim_reach_solo(level.burke,var_00);
	maps\_utility::delaythread(3,::common_scripts\utility::flag_set,"vo_security_room_elevator_access");
	thread security_elevator_open();
	soundscripts\_snd::snd_message("start_dead_guy_foley",var_03);
	var_05 thread maps\_anim::anim_generic(var_03,var_00);
	var_05 maps\_anim::anim_single_solo(level.burke,var_00);
	if(!common_scripts\utility::flag("elevator_door_open"))
	{
		var_05 thread maps\_anim::anim_loop_solo(level.burke,var_01,var_02);
		common_scripts\utility::flag_wait("elevator_door_open");
		var_05 notify(var_02);
	}

	var_0B = "security_room_turn_to_elevator";
	var_0C = "elevator_descent_start_idle";
	var_05 maps\_anim::anim_single_solo(level.burke,var_0B);
	common_scripts\utility::flag_set("burke_facing_elevator");
	var_05 thread maps\_anim::anim_loop_solo(level.burke,var_0C,var_0C);
	wait(2);
	common_scripts\utility::flag_wait("elevator_descent");
	var_05 notify(var_0C);
	var_05 delete();
	if(level.currentgen)
	{
		level waittill("tff_pre_transition_intro_to_middle");
		var_09 delete();
		var_0A delete();
		var_07 delete();
		var_03 delete();
	}
}

//Function Number: 203
start_cqb_when_near(param_00)
{
	var_01 = 40000;
	while(distancesquared(self.origin,param_00) > var_01)
	{
		wait(0.1);
	}

	maps\_utility::enable_cqbwalk();
}

//Function Number: 204
security_elevator_open()
{
	var_00 = common_scripts\utility::getstruct("fusion_security_room_corpse_fall_npc","targetname");
	var_01 = spawn("script_origin",var_00.origin);
	if(isdefined(var_00.angles))
	{
		var_01.angles = var_00.angles;
	}

	var_02 = "security_room_approach_elevator";
	var_03 = "security_room_open_elevator_idle";
	var_04 = "end_approach_idle";
	var_05 = "security_room_open_elevator";
	var_06 = "security_room_elevator_opened_idle";
	soundscripts\_snd::snd_message("start_elevator_zone_audio");
	var_07 = [];
	var_07[var_07.size] = level.joker;
	var_07[var_07.size] = level.carter;
	level.joker maps\_utility::disable_ai_color();
	level.carter maps\_utility::disable_ai_color();
	level.burke maps\_utility::disable_ai_color();
	common_scripts\utility::array_thread(var_07,::security_elevator_approach,var_01,var_02,var_03,var_04);
	level waittill("elevator_open_guy_ready");
	level waittill("elevator_open_guy_ready");
	common_scripts\utility::flag_wait("elevator_door_open");
	var_01 notify(var_04);
	common_scripts\_exploder::exploder("elevator_door_open_fx");
	var_08 = getent("security_room_elevator_doors","targetname");
	var_08 maps\_utility::assign_animtree("security_room_elevator_doors");
	common_scripts\utility::flag_set("vo_security_room_elevator_open");
	level.joker thread security_elevator_open_anim(var_01,1,var_05,var_06);
	level.carter thread security_elevator_open_anim(var_01,0,var_05,var_06);
	var_01 thread maps\_anim::anim_single_solo(var_08,var_05);
	soundscripts\_snd::snd_message("Sec_Room_Elevator_Open");
	security_elevator_descent(var_01);
	var_01 delete();
}

//Function Number: 205
security_elevator_approach(param_00,param_01,param_02,param_03)
{
	if(self == level.joker)
	{
		wait(4);
	}

	param_00 maps\_anim::anim_reach_solo(self,param_01);
	if(self == level.joker)
	{
		soundscripts\_snd::snd_message("Sec_Room_Move_To_Elevator");
	}

	param_00 maps\_anim::anim_single_solo(self,param_01);
	if(self == level.joker)
	{
		soundscripts\_snd::snd_message("Sec_Room_Attach_To_Elevator");
	}

	param_00 thread maps\_anim::anim_loop_solo(self,param_02,param_03);
	level notify("elevator_open_guy_ready");
}

//Function Number: 206
security_elevator_open_anim(param_00,param_01,param_02,param_03)
{
	var_04 = "stop_opened_idle";
	var_05 = spawn("script_origin",param_00.origin);
	var_05 maps\_anim::anim_single_solo(self,param_02);
	if(!common_scripts\utility::flag("elevator_descent_player"))
	{
		var_05 thread maps\_anim::anim_loop_solo(self,param_03,var_04);
		common_scripts\utility::flag_wait("elevator_descent_player");
		var_05 notify(var_04);
	}
}

//Function Number: 207
security_elevator_descent(param_00)
{
	thread security_elevator_descent_player();
	common_scripts\utility::flag_wait("burke_facing_elevator");
	wait(2);
	common_scripts\utility::flag_wait("elevator_descent");
	level.guys_down_elevator = 0;
	level.burke thread security_elevator_descent_ai(param_00);
	thread security_elevator_prompt();
	common_scripts\utility::flag_wait("elevator_descent_player");
	wait(1);
	level.joker thread security_elevator_descent_ai(param_00);
	level.carter security_elevator_descent_ai(param_00);
}

//Function Number: 208
security_elevator_prompt()
{
	wait(4);
	if(common_scripts\utility::flag("elevator_descent_player"))
	{
		return;
	}

	var_00 = maps\_shg_utility::hint_button_position("jump",common_scripts\utility::getstruct("obj_pos_security_elevator","targetname").origin,128,512);
	common_scripts\utility::flag_wait("elevator_descent_player");
	var_00 maps\fusion_utility::hint_button_clear_fus();
}

//Function Number: 209
transient_transition_intro_to_middle()
{
	if(level.currentgen)
	{
		level notify("tff_pre_transition_intro_to_middle");
		unloadtransient("fusion_intro_tr");
		loadtransient("fusion_middle_tr");
		while(!istransientloaded("fusion_middle_tr"))
		{
			wait(0.05);
		}

		level notify("tff_post_transition_intro_to_middle");
	}
}

//Function Number: 210
security_elevator_descent_player()
{
	var_00 = common_scripts\utility::getstruct("elevator_descent_org","targetname");
	var_01 = maps\_utility::spawn_anim_model("player_rig",level.player.origin);
	var_00 thread maps\_anim::anim_first_frame_solo(var_01,"elevator_descent");
	var_01 hide();
	common_scripts\utility::flag_wait("elevator_descent_player");
	thread transient_transition_intro_to_middle();
	level.player maps\_utility::blend_movespeedscale_percent(0);
	soundscripts\_snd::snd_message("start_player_elevator_slide");
	common_scripts\utility::flag_set("update_obj_pos_elevator_descent");
	level.player maps\_utility::add_wait(::maps\_shg_utility::setup_player_for_scene,1);
	var_01 maps\_utility::add_call(::show);
	thread maps\_utility::do_wait();
	var_02 = 0.3;
	level.player playerlinktoblend(var_01,"tag_player",var_02);
	level.player common_scripts\utility::delaycall(var_02,::playerlinktodelta,var_01,"tag_player",0,20,20,20,20);
	var_03 = 3.25;
	if(level.currentgen)
	{
		var_03 = var_03 * 1.35;
	}

	level.player common_scripts\utility::delaycall(var_03,::enableweapons);
	level.player common_scripts\utility::delaycall(1.5,::givemaxammo,"iw5_bal27_sp_variablereddot");
	common_scripts\utility::noself_delaycall(1,::playfxontag,common_scripts\utility::getfx("elevator_player_slide_dust"),var_01,"J_MainRoot");
	level.player thread elevator_rumble();
	soundscripts\_snd::snd_message("start_player_elevator_jump");
	var_00 maps\_anim::anim_single_solo(var_01,"elevator_descent");
	level.player unlink();
	var_01 delete();
	level.player enableweapons();
	level.player maps\_shg_utility::setup_player_for_gameplay();
	common_scripts\utility::flag_set("lab_cqb");
	common_scripts\utility::flag_set("vo_lab_elevator_slide_complete");
	thread street_cleanup();
	maps\_utility::autosave_by_name("elevator_slide_complete");
}

//Function Number: 211
elevator_rumble()
{
	wait(0.5);
	var_00 = maps\_utility::get_rumble_ent("steady_rumble");
	var_00.intensity = 0.2;
	wait(2.3);
	stopallrumbles();
}

//Function Number: 212
play_lab_reactor_pip()
{
	level notify("stop_evacuation_kiosk_movie");
	wait(0.5);
	common_scripts\utility::flag_wait("vo_lab_elevator_slide_complete");
	setsaveddvar("cg_cinematicfullscreen","0");
	maps\_shg_utility::play_videolog("fusion_videolog","screen_add");
	wait(0.5);
	evacuation_kiosk_movie();
}

//Function Number: 213
sync_transients_after_time(param_00)
{
	wait(param_00);
	synctransients();
}

//Function Number: 214
corpse_trigger_think()
{
	self waittill("trigger");
	var_00 = getentarray(self.target,"targetname");
	var_01 = maps\_utility::getstructarray_delete(var_00[0].script_noteworthy,"script_noteworthy");
	foreach(var_03 in var_01)
	{
		var_04 = var_00[randomintrange(0,var_00.size)];
		var_05 = var_04 maps\_utility::spawn_ai();
		var_05.origin = var_03.origin;
		var_05.angles = var_03.angles;
		var_05 setcandamage(0);
		if(isdefined(var_05.weapon) && var_05.weapon != "none")
		{
			var_05 maps\_utility::gun_remove();
		}

		var_06 = level.scr_anim["generic"][var_03.animation];
		if(isarray(var_06))
		{
			var_06 = var_06[0];
		}

		var_05 animscripted("endanim",var_03.origin,var_03.angles,var_06);
		if(isdefined(var_03.script_parameters))
		{
			if(var_03.script_parameters == "notsolid")
			{
				var_05 notsolid();
			}

			if(var_03.script_parameters == "ripples")
			{
				var_05 thread ripples_on_body(var_03);
			}
		}

		if(issubstr(var_03.animation,"death"))
		{
			var_05 common_scripts\utility::delaycall(0.05,::setanimtime,var_06,1);
		}
	}

	if(isdefined(self.script_flag))
	{
		common_scripts\utility::flag_wait(self.script_flag);
		common_scripts\utility::array_call(getentarray(var_00[0].script_noteworthy,"script_noteworthy"),::delete);
	}
}

//Function Number: 215
ripples_on_body(param_00)
{
	self endon("death");
	wait(0.1);
	var_01 = common_scripts\utility::get_target_ent(param_00.target);
	var_02 = (self.origin[0],self.origin[1],var_01.origin[2] - 1);
	for(;;)
	{
		playfx(common_scripts\utility::getfx("water_movement"),var_02);
		wait(randomfloatrange(0.5,1));
	}
}

//Function Number: 216
street_cleanup()
{
	level notify("street_cleanup");
	waittillframeend;
	var_00 = getaiarray();
	var_00 = common_scripts\utility::array_remove(var_00,level.burke);
	var_00 = common_scripts\utility::array_remove(var_00,level.joker);
	var_00 = common_scripts\utility::array_remove(var_00,level.carter);
	common_scripts\utility::array_call(var_00,::delete);
	common_scripts\utility::array_call(getentarray("script_vehicle_x4walker_wheels_turret","classname"),::delete);
	common_scripts\utility::array_call(getentarray("script_vehicle_x4walker_wheels_turret_explosive","classname"),::delete);
	if(isdefined(level.player.linked_to_cover))
	{
		level.player.linked_to_cover vehicle_scripts\_cover_drone::player_unlink_from_cover();
	}

	common_scripts\utility::array_call(getentarray("script_vehicle_cover_drone","classname"),::delete);
	common_scripts\utility::array_call(getentarray("mobile_turret","targetname"),::delete);
	common_scripts\utility::array_call(getentarray("script_vehicle_pdrone","classname"),::delete);
	if(isdefined(level.walker))
	{
		level.walker connectpaths();
	}
}

//Function Number: 217
security_elevator_descent_ai(param_00)
{
	var_01 = "elevator_descent";
	if(self == level.burke)
	{
		soundscripts\_snd::snd_message("start_burke_elevator_slide");
		param_00 thread maps\_anim::anim_single_solo(self,var_01);
		maps\_utility::delaythread(3,::common_scripts\utility::flag_set,"update_obj_pos_security_elevator");
		common_scripts\utility::waittill_any_ents(param_00,var_01,level,"burke_elevator_landing");
		var_01 = "elevator_descent_exit";
		param_00 maps\_anim::anim_single_solo(self,var_01);
	}
	else
	{
		self stopanimscripted();
		param_00 maps\_anim::anim_single_solo(self,var_01);
	}

	laboratory_start_idle();
}

//Function Number: 218
laboratory_start_idle()
{
	var_00 = "elevator_descent_end_idle";
	var_01 = "elevator_descent_end_idle_2_cqb";
	var_02 = "elevator_descent_end_idle_stop";
	var_03 = common_scripts\utility::getstruct("fusion_security_room_corpse_fall_npc","targetname");
	var_04 = spawn("script_origin",var_03.origin);
	if(isdefined(var_03.angles))
	{
		var_04.angles = var_03.angles;
	}

	var_04 thread maps\_anim::anim_loop_solo(self,var_00,var_02);
	if(!isdefined(level.guys_down_elevator))
	{
		level.guys_down_elevator = 0;
	}

	level.guys_down_elevator++;
	level notify("guy_down_elevator");
	while(level.guys_down_elevator < 3)
	{
		level waittill("guy_down_elevator");
	}

	common_scripts\utility::flag_wait("negotiation_elevator_to_hall");
	if(self == level.burke)
	{
		wait(4);
	}
	else if(self == level.carter)
	{
		wait(1);
	}

	var_04 notify(var_02);
	maps\_utility::enable_cqbwalk();
	maps\_utility::enable_ai_color();
	self.moveplaybackrate = 1.1;
	if(self == level.joker)
	{
		common_scripts\utility::flag_set("start_lab_traversals");
	}
	else
	{
		var_04 maps\_anim::anim_single_solo_run(self,var_01);
	}

	var_04 delete();
}

//Function Number: 219
laboratory()
{
	level endon("airlock_scene_prep");
	thread laboratory_cqb();
	thread play_lab_reactor_pip();
	common_scripts\utility::flag_wait("start_lab_traversals");
	thread lab_doorway_dyn_path();
	thread color_group_enter_lab_trigger();
	laboratory_traversal("negotiation_elevator_to_hall",level.joker);
	laboratory_traversal("negotiation_hall_to_lab",level.burke,"negotiation_curved_hall");
	wait 0.05;
	laboratory_traversal("negotiation_curved_hall",level.burke,"negotiation_locker_room_entrance");
	wait 0.05;
	laboratory_traversal("negotiation_locker_room_entrance",level.carter,"airlock_scene_prep");
}

//Function Number: 220
color_group_enter_lab_trigger()
{
	var_00 = getent("color_group_enter_lab","targetname");
	if(isdefined(var_00))
	{
		var_00 waittill("trigger");
	}

	var_01 = getent("negotiation_hall_to_lab_carter","targetname");
	var_01 delete();
	var_02 = getent("negotiation_hall_to_lab_joker","targetname");
	var_02 delete();
}

//Function Number: 221
lab_doorway_dyn_path()
{
	var_00 = getent("lab_doorway_dyn_path","targetname");
	var_00 disconnectpaths();
	level waittill("negotiation_hall_to_lab_dyn_path");
	wait(5);
	var_00 connectpaths();
	var_00 delete();
}

//Function Number: 222
laboratory_traversal(param_00,param_01,param_02)
{
	if(isdefined(param_02))
	{
		level endon(param_02);
	}

	common_scripts\utility::flag_wait(param_00);
	var_03 = param_00;
	switch(param_00)
	{
		case "negotiation_elevator_to_hall":
			thread laboratory_elevator_to_hall(param_00,param_02);
			var_03 = "elevator_descent_end_idle_2_cqb";
			common_scripts\utility::flag_set("update_obj_pos_lab_follow_joker");
			break;

		case "negotiation_hall_to_lab":
			thread negotiation_hall_to_lab(param_00,param_02);
			maps\_utility::delaythread(3,::common_scripts\utility::flag_set,"update_obj_pos_lab_follow_burke");
			break;

		case "negotiation_curved_hall":
			break;

		case "negotiation_locker_room_entrance":
			maps\_utility::delaythread(3,::common_scripts\utility::flag_set,"update_obj_pos_lab_follow_carter");
			break;

		default:
			break;
	}

	var_04 = common_scripts\utility::getstruct(param_00,"targetname");
	param_01 notify("stop_color_move");
	if(param_00 != "negotiation_elevator_to_hall")
	{
		wait 0.05;
		var_04 maps\_anim::anim_reach_solo(param_01,var_03,undefined,1);
		if(param_00 == "negotiation_hall_to_lab")
		{
			level notify("negotiation_hall_to_lab_dyn_path");
		}
	}
	else
	{
		var_04 = common_scripts\utility::getstruct("fusion_security_room_corpse_fall_npc","targetname");
	}

	var_05 = param_00 + "_exit";
	var_06 = getent(var_05,"targetname");
	if(isdefined(var_06))
	{
		maps\_utility::activate_trigger_with_targetname(param_00 + "_exit");
	}

	var_04 maps\_anim::anim_single_solo_run(param_01,var_03);
}

//Function Number: 223
laboratory_elevator_to_hall(param_00,param_01)
{
	wait(1);
	maps\_utility::activate_trigger_with_targetname(param_00 + "_carter");
	if(isdefined(level.carter.node))
	{
		level.carter.node.script_delay = undefined;
	}

	wait(1);
	if(!common_scripts\utility::flag("negotiation_hall_to_lab"))
	{
		maps\_utility::activate_trigger_with_targetname(param_00 + "_burke");
	}

	if(isdefined(level.burke.node))
	{
		level.burke.node.script_delay = undefined;
	}
}

//Function Number: 224
negotiation_hall_to_lab(param_00,param_01)
{
	level endon(param_01);
	wait(1);
	if(isdefined(getent(param_00 + "_carter","targetname")))
	{
		maps\_utility::activate_trigger_with_targetname(param_00 + "_carter");
	}

	if(isdefined(level.carter.node))
	{
		level.carter.node.script_delay = undefined;
	}

	wait(3);
	if(isdefined(getent(param_00 + "_carter","targetname")))
	{
		maps\_utility::activate_trigger_with_targetname(param_00 + "_joker");
	}

	if(isdefined(level.joker.node))
	{
		level.joker.node.script_delay = undefined;
	}
}

//Function Number: 225
laboratory_cqb()
{
	common_scripts\utility::flag_wait("lab_cqb");
	level.player maps\_utility::blend_movespeedscale_percent(75);
	setsaveddvar("ai_friendlyFireBlockDuration",0);
	common_scripts\utility::flag_wait("reactor_room_reveal_scene");
	level.player maps\_utility::blend_movespeedscale_percent(100,5);
	common_scripts\utility::flag_wait("reactor_room_reveal_allies_advance");
	setsaveddvar("ai_friendlyFireBlockDuration",2000);
}

//Function Number: 226
reactor_room()
{
	thread reactor_room_reveal_scene();
	thread reactor_room_drones();
	thread reactor_room_crane();
	thread handle_outline_on_grenade_launcher();
	if(level.nextgen)
	{
		thread reactor_room_robots();
	}
}

//Function Number: 227
handle_outline_on_grenade_launcher()
{
	var_00 = getent("weapon_iw5_microdronelauncher_sp","classname");
	while(isdefined(var_00))
	{
		var_00 hudoutlinedisable(6,1);
		while(isdefined(var_00) && distance(var_00.origin,level.player.origin) > 300)
		{
			wait 0.05;
		}

		if(!isdefined(var_00))
		{
			break;
		}

		var_00 hudoutlineenable(6,1);
		while(isdefined(var_00) && distance(var_00.origin,level.player.origin) <= 300)
		{
			wait 0.05;
		}

		wait 0.05;
	}
}

//Function Number: 228
reactor_room_reveal_scene()
{
	common_scripts\utility::flag_wait("airlock_scene_prep");
	if(level.currentgen)
	{
		var_00 = ["reactor_room_enemies"];
		thread maps\_cg_encounter_perf_monitor::cg_spawn_perf_monitor("reactor_room_cleanup",var_00,15,0);
	}

	soundscripts\_snd::snd_message("start_airlock_anim_notetracks");
	var_01 = "fusion_airlock_opening_approach";
	var_02 = "fusion_airlock_opening_idle";
	var_03 = common_scripts\utility::getstruct("airlock_anim_node","targetname");
	var_04 = "reactor_room_reveal_scene";
	thread reactor_room_reveal_door(var_03,"fusion_airlock_opening");
	thread reactor_room_reveal_ally_vo_close_check();
	var_05 = [];
	var_05[var_05.size] = level.burke;
	var_05[var_05.size] = level.carter;
	level.reactor_room_reveal_scene_guys_ready = 0;
	common_scripts\utility::array_thread(var_05,::reactor_room_reveal_scene_approach,var_03,var_01,var_02,var_04);
	level waittill("reactor_room_reveal_scene_prepped");
	var_01 = "fusion_airlock_opening";
	common_scripts\utility::flag_wait("reactor_room_reveal_scene");
	level notify("reactor_room_reveal_scene_started");
	var_03 notify(var_04);
	maps\_utility::array_notify(var_05,"reactor_room_reveal_scene");
	if(level.nextgen)
	{
		common_scripts\utility::array_thread(getentarray("reactor_redshirts","script_noteworthy"),::reactor_room_redshirts);
		thread reactor_room_redshirt_cleanup();
	}

	var_06 = getent("reactor_room_airlock_enemy","targetname") maps\_utility::spawn_ai(1);
	var_06 notify("handle_detection");
	var_06 setcontents(0);
	var_06.ignoresonicaoe = 1;
	var_06.animname = "generic";
	var_05[var_05.size] = var_06;
	var_06 setcontents(0);
	var_03 thread maps\_anim::anim_single_run(var_05,var_01);
	level.burke maps\_utility::disable_cqbwalk();
	level.joker maps\_utility::disable_cqbwalk();
	level.carter maps\_utility::disable_cqbwalk();
	level.burke.moveplaybackrate = 1;
	level.joker.moveplaybackrate = 1;
	level.carter.moveplaybackrate = 1;
	maps\_utility::battlechatter_off("allies");
	maps\_utility::battlechatter_off("axis");
	maps\_utility::delaythread(15,::maps\_utility::battlechatter_on,"allies");
	maps\_utility::delaythread(15,::maps\_utility::battlechatter_on,"axis");
	level.burke thread reactor_room_reveal_scene_ally_think();
	level.joker thread reactor_room_reveal_scene_ally_think();
	level.carter thread reactor_room_reveal_scene_ally_think();
	common_scripts\utility::flag_set("vo_reactor_entrance");
	maps\_utility::delaythread(12,::maps\_utility::activate_trigger_with_noteworthy,"reactor_room_first_spawn_trigger");
	common_scripts\utility::array_thread(getentarray("reactor_room_robot_grid_safeguard","targetname"),::reactor_room_robot_grid_ally_safeguard);
	maps\_utility::delaythread(12,::maps\_utility::activate_trigger_with_targetname,"reactor_room_door_open_color_trigger");
	common_scripts\utility::flag_wait("reactor_room_reveal_allies_advance");
	level.burke maps\_utility::enable_ai_color();
	level.carter maps\_utility::enable_ai_color();
	if(!common_scripts\utility::flag("reactor_redshirts_enable"))
	{
		maps\_utility::activate_trigger_with_targetname("reactor_room_door_open_color_trigger");
	}

	common_scripts\utility::flag_set("update_obj_pos_reactor_1");
	maps\_utility::autosave_by_name();
	thread reactor_room_combat();
	thread reactor_room_sonic_hint_use_check();
	wait(10);
	common_scripts\utility::flag_set("flag_show_boost_slam_hint");
}

//Function Number: 229
reactor_room_sonic_hint_use_check()
{
	level endon("SonicAoEStarted");
	var_00 = 512;
	wait(35);
	while(!common_scripts\utility::flag("flag_show_sonic_hint"))
	{
		var_01 = getaiarray("axis");
		var_01 = maps\_utility::array_removedead_or_dying(var_01);
		var_02 = maps\_utility::get_within_range(level.player.origin,var_01,var_00);
		if(var_02.size > 0)
		{
			common_scripts\utility::flag_set("flag_show_sonic_hint");
		}

		wait 0.05;
	}
}

//Function Number: 230
reactor_room_reveal_scene_approach(param_00,param_01,param_02,param_03)
{
	if(self == level.carter)
	{
		common_scripts\utility::flag_wait("reactor_room_reveal_burke_ready");
	}

	maps\_utility::disable_ai_color();
	self notify("stop_goto_node");
	self notify("goal");
	param_00 maps\_anim::anim_reach_solo(self,param_01);
	if(self == level.burke)
	{
		common_scripts\utility::flag_set("reactor_room_reveal_burke_ready");
	}

	param_00 maps\_anim::anim_single_solo(self,param_01);
	param_00 thread maps\_anim::anim_loop_solo(self,param_02,param_03);
	level.reactor_room_reveal_scene_guys_ready++;
	if(level.reactor_room_reveal_scene_guys_ready >= 2)
	{
		level notify("reactor_room_reveal_scene_prepped");
	}
}

//Function Number: 231
reactor_room_reveal_ally_vo_close_check()
{
	var_00 = getent("airlock_vo_start_check","targetname");
	while(!level.burke istouching(var_00))
	{
		wait(0.3);
	}

	common_scripts\utility::flag_set("vo_reactor_open_airlock");
}

//Function Number: 232
reactor_room_reveal_scene_ally_think()
{
	var_00 = self.grenadeawareness;
	self.grenadeawareness = 0;
	self.ignoreall = 1;
	common_scripts\utility::flag_wait("reactor_room_reveal_allies_advance");
	self.disablebulletwhizbyreaction = 1;
	self.nogrenadereturnthrow = 1;
	var_01 = self.goalradius;
	self.goalradius = 64;
	waittillframeend;
	common_scripts\utility::waittill_notify_or_timeout("goal",5);
	self.ignoreall = 0;
	self.grenadeawareness = var_00;
	self.disablebulletwhizbyreaction = 0;
	self.nogrenadereturnthrow = 0;
	self.goalradius = var_01;
}

//Function Number: 233
reactor_room_reveal_enemies_think()
{
	self endon("death");
	self.grenadeammo = 0;
	if(isdefined(self.target))
	{
		self.goalradius = 16;
	}

	var_00 = 40000;
	while(distancesquared(self.origin,level.burke.origin) > var_00)
	{
		wait(0.1);
	}
}

//Function Number: 234
reactor_room_reveal_door(param_00,param_01)
{
	var_02 = getent("reactor_airlock_door_1","targetname");
	var_03 = getent(var_02.target,"targetname");
	var_03 disconnectpaths();
	var_02.animname = "fusion_airlock_door";
	var_02 maps\_anim::setanimtree();
	param_00 thread maps\_anim::anim_first_frame_solo(var_02,param_01);
	level waittill("reactor_room_reveal_scene_prepped");
	var_03 linkto(var_02,"door");
	common_scripts\utility::flag_wait("reactor_room_reveal_scene");
	soundscripts\_snd::snd_message("start_reactor_airlock_open",var_02);
	soundscripts\_snd::snd_message("start_reactor_zone_audio");
	soundscripts\_snd::snd_message("start_reactor_burke_attack");
	var_04 = 45;
	var_02 playrumblelooponentity("subtle_tank_rumble");
	earthquake(0.1,var_04,var_02.origin,1000);
	common_scripts\_exploder::exploder(3301);
	common_scripts\_exploder::exploder(3302);
	common_scripts\_exploder::exploder(3303);
	common_scripts\_exploder::exploder(3304);
	common_scripts\_exploder::exploder(3201);
	common_scripts\_exploder::exploder(3202);
	param_00 thread maps\_anim::anim_single_solo(var_02,param_01);
	var_05 = getanimlength(var_02 maps\_utility::getanim(param_01));
	common_scripts\utility::noself_delaycall(var_05,::stopallrumbles);
	wait(15.5);
	common_scripts\utility::flag_set("reactor_room_reveal_allies_advance");
	var_03 connectpaths();
	waittillframeend;
	var_03 disconnectpaths();
	common_scripts\utility::flag_set("vo_reactor_gogogo");
}

//Function Number: 235
reactor_room_reveal_squibs(param_00,param_01)
{
	level endon("intro_truck_left");
	var_02 = common_scripts\utility::getstruct("reactor_reveal_bullet_org","targetname");
	var_03 = common_scripts\utility::getstructarray(var_02.target,"targetname");
	var_03 = common_scripts\utility::array_randomize(var_03);
	var_04 = -5;
	var_05 = 5;
	var_06 = 0;
	for(var_07 = 0;var_07 < param_00;var_07++)
	{
		magicbullet("iw5_ak12_sp",var_02.origin,var_03[var_06].origin + (randomfloatrange(var_04,var_05),randomfloatrange(var_04,var_05),randomfloatrange(var_04,var_05)));
		if(randomint(100) < 10)
		{
			level.player playrumbleonentity("damage_light");
		}

		var_06++;
		if(var_06 >= var_03.size)
		{
			var_03 = common_scripts\utility::array_randomize(var_03);
			var_06 = 0;
		}

		wait(0.1);
	}
}

//Function Number: 236
reactor_room_robot_grid_ally_safeguard()
{
	level endon("elevator_ascend");
	var_00 = getent(self.target,"targetname");
	var_01 = common_scripts\utility::getstruct(var_00.target,"targetname");
	for(;;)
	{
		self waittill("trigger",var_02);
		var_03 = getaiarray("allies");
		foreach(var_05 in var_03)
		{
			if(var_05 istouching(var_00) && !maps\_utility::player_can_see_ai(var_05) && !maps\_utility::player_looking_at(var_01.origin,undefined,1))
			{
				var_05 forceteleport(var_01.origin,var_01.angles);
			}
		}
	}
}

//Function Number: 237
reactor_room_drones()
{
	common_scripts\utility::flag_wait("reactor_drones_1");
	var_00 = [];
	var_00[var_00.size] = thread vehicle_scripts\_pdrone::start_flying_attack_drone("reactor_drone_1");
	foreach(var_02 in var_00)
	{
		var_02 thread maps\_shg_utility::make_emp_vulnerable();
		var_02 laseron();
		var_02 thread reactor_room_drone_cleanup();
	}

	common_scripts\utility::flag_wait("reactor_drones_2");
	var_04 = [];
	var_04[var_04.size] = thread vehicle_scripts\_pdrone::start_flying_attack_drone("reactor_drone_3");
	var_04[var_04.size] = thread vehicle_scripts\_pdrone::start_flying_attack_drone("reactor_drone_4");
	foreach(var_02 in var_04)
	{
		var_02 thread maps\_shg_utility::make_emp_vulnerable();
		var_02 laseron();
		var_02 thread reactor_room_drone_cleanup();
	}
}

//Function Number: 238
reactor_room_drone_cleanup()
{
	self endon("death");
	common_scripts\utility::flag_wait("reactor_room_end_combat");
	wait(randomfloatrange(1,3));
	self kill();
}

//Function Number: 239
reactor_room_crane()
{
	level waittill("reactor_room_reveal_scene_started");
	var_00 = getentarray("reactor_crane_track","targetname");
	var_01 = [];
	var_02 = common_scripts\utility::getstruct("reactor_crane_track_inner","targetname");
	var_03 = common_scripts\utility::getstruct(var_02.target,"targetname");
	var_01["min_dist"] = int(distance(var_00[0].origin,var_02.origin));
	var_01["max_dist"] = int(distance(var_00[0].origin,var_03.origin));
	var_04 = common_scripts\utility::getstruct("reactor_crane_height_top","targetname");
	var_05 = common_scripts\utility::getstruct(var_04.target,"targetname");
	var_01["crane_height_delta"] = distance(var_04.origin,var_05.origin);
	var_01["rot_speed"] = 30;
	var_01["rot_delay"] = 0.1;
	var_01["crane_housing_move_speed"] = 75;
	var_01["crane_housing_move_delay"] = 1;
	var_01["height_time"] = 2.5;
	var_01["height_acc"] = 0.5;
	var_01["height_dec"] = 1.5;
	var_01["lower_delay"] = 1;
	var_01["raise_delay"] = 1;
	var_01["crate_height"] = 72;
	var_01["cable_height"] = 40;
	level.reactor_room_crate_tracking = [];
	level.reactor_room_crate_tracking["scripted_crate"] = 0;
	level.reactor_room_crate_tracking["near_player"] = 0;
	level.reactor_room_crate_tracking["near_enemies"] = 0;
	var_06 = getentarray("reactor_cover_crate","script_noteworthy");
	common_scripts\utility::array_thread(var_06,::reactor_room_crate_think);
	var_00 = getentarray("reactor_crane_track","targetname");
	var_00[0] thread reactor_room_crane_think(var_01,"north",var_06);
	var_00[1] thread reactor_room_crane_think(var_01,"south",var_06);
}

//Function Number: 240
crane_cable(param_00,param_01)
{
	for(var_02 = self;isdefined(var_02.target);var_02 hide())
	{
		var_02 = getent(var_02.target,"targetname");
	}

	var_03 = param_01["cable_height"];
	thread stop_crane_audio(param_00);
	for(;;)
	{
		param_00 reactor_room_link_cables(self,1);
		param_00 waittill("crane_moving");
		param_00 reactor_room_link_cables(self,0);
		soundscripts\_snd::snd_message("crane_claw_drop_start",param_00);
		param_00 crane_animated_down(self,param_00,param_01);
		param_00 waittill("crane_stopped");
		soundscripts\_snd::snd_message("crane_claw_drop_stop",param_00);
		param_00 waittill("crane_moving");
		soundscripts\_snd::snd_message("crane_claw_rise_start",param_00);
		param_00 crane_animated_up(self,param_00,param_01);
		param_00 waittill("crane_stopped");
		soundscripts\_snd::snd_message("crane_claw_rise_stop",param_00);
	}
}

//Function Number: 241
stop_crane_audio(param_00)
{
	if(level.currentgen)
	{
		level waittill("tff_pre_transition_middle_to_outro");
		param_00 notify("stop_claw_beep");
		param_00 stoploopsound("crane_rctr_claw_drop_lp");
		param_00 stoploopsound("crane_rctr_claw_rise_lp");
	}
}

//Function Number: 242
crane_animated_down(param_00,param_01,param_02)
{
	param_00 thread crane_cable_down(param_01,param_02);
}

//Function Number: 243
crane_animated_up(param_00,param_01,param_02)
{
	param_01.last_cable thread crane_cable_up(param_01);
}

//Function Number: 244
crane_cable_down(param_00,param_01)
{
	attach_housing(param_00);
	param_00 endon("crane_stopped");
	while(distancesquared(self.og,self getorigin()) < squared(param_01["cable_height"]))
	{
		wait(0.05);
	}

	if(!isdefined(self.target))
	{
		return;
	}

	var_02 = getent(self.target,"targetname");
	var_02 thread crane_cable_down(param_00,param_01);
}

//Function Number: 245
attach_housing(param_00)
{
	self.og = self getorigin();
	self linkto(param_00);
	param_00.last_cable = self;
	if(!isdefined(self.target))
	{
		return;
	}

	var_01 = getent(self.target,"targetname");
	var_01 show();
}

//Function Number: 246
crane_cable_up(param_00)
{
	param_00 endon("crane_stopped");
	while(distancesquared(self.og,self getorigin()) > squared(10))
	{
		wait(0.05);
	}

	thread detach_housing(param_00);
	if(isdefined(self.script_noteworthy) && self.script_noteworthy == "crane_cable")
	{
		return;
	}

	var_01 = getent(self.targetname,"target");
	var_01 thread crane_cable_up(param_00);
}

//Function Number: 247
detach_housing(param_00)
{
	if(isdefined(self.script_noteworthy) && self.script_noteworthy == "crane_cable")
	{
		return;
	}

	self unlink();
	var_01 = 0.5;
	self moveto(self.og,var_01);
	wait(var_01);
	self hide();
}

//Function Number: 248
reactor_room_crane_think(param_00,param_01,param_02)
{
	level endon("elevator_ascend");
	var_03 = self;
	var_04 = getent(var_03.target,"targetname");
	var_05 = getentarray(var_04.target,"targetname");
	var_06 = undefined;
	var_07 = undefined;
	var_08 = undefined;
	var_09 = undefined;
	foreach(var_0B in var_05)
	{
		if(var_0B.classname == "script_model")
		{
			var_06 = var_0B;
			continue;
		}

		if(var_0B.classname == "script_brushmodel")
		{
			var_08 = var_0B;
			continue;
		}

		if(var_0B.classname == "trigger_multiple")
		{
			var_09 = var_0B;
			continue;
		}

		var_07 = var_0B;
	}

	var_08 linkto(var_06);
	var_09 enablelinkto();
	var_09 linkto(var_06);
	var_06.animname = "reactor_crane";
	var_06 maps\_anim::setanimtree();
	var_06 thread maps\_anim::anim_first_frame_solo(var_06,"crane_opened");
	var_0D = getent(var_06.target,"targetname");
	var_0D thread crane_cable(var_06,param_00);
	var_06 linkto(var_04);
	var_04 linkto(var_03);
	var_03.track_inner = common_scripts\utility::spawn_tag_origin();
	var_03.track_inner.origin = var_03.origin + (742,0,0);
	var_03.track_inner linkto(var_03);
	var_03.track_inner thread maps\fusion_utility::delete_on_notify("reactor_room_cleanup");
	var_03.track_outer = common_scripts\utility::spawn_tag_origin();
	var_03.track_outer.origin = var_03.origin + (1354,0,0);
	var_03.track_outer linkto(var_03);
	var_03.track_outer thread maps\fusion_utility::delete_on_notify("reactor_room_cleanup");
	var_0E = common_scripts\utility::spawn_tag_origin();
	var_0E.origin = var_04.origin;
	var_0E linkto(var_04);
	var_0E thread maps\fusion_utility::delete_on_notify("reactor_room_cleanup");
	var_0F = common_scripts\utility::spawn_tag_origin();
	var_0F.origin = var_06.origin;
	var_0F linkto(var_06);
	var_0F thread maps\fusion_utility::delete_on_notify("reactor_room_cleanup");
	var_07 enablelinkto();
	var_07 linkto(var_06);
	var_06 thread reactor_room_crane_light();
	var_10 = [];
	foreach(var_12 in param_02)
	{
		var_13 = vectortoangles(var_12.origin - var_03.origin)[1];
		if(var_13 < 20)
		{
			var_13 = var_13 + 360;
		}

		if(var_13 < 200 && param_01 == "south")
		{
			continue;
		}

		if(var_13 >= 200 && param_01 == "north")
		{
			continue;
		}

		var_10[var_10.size] = var_12;
	}

	var_15 = 175;
	if(param_01 == "south")
	{
		var_15 = 200;
		reactor_room_crane_rotate_to_angle(var_03,200,param_00["rot_speed"],param_00["rot_delay"]);
		common_scripts\utility::flag_wait("reactor_room_crane_south_start");
	}
	else
	{
		wait(15);
	}

	for(;;)
	{
		if(param_01 == "north" && common_scripts\utility::flag("reactor_room_crane_south_start"))
		{
			break;
		}

		if(var_10.size == 0)
		{
			break;
		}

		var_12 = reactor_room_get_best_crate(var_10,param_01);
		var_10 = common_scripts\utility::array_remove(var_10,var_12);
		var_13 = vectortoangles(var_12.origin - var_03.origin)[1];
		reactor_room_crane_rotate_to_angle(var_03,var_13,param_00["rot_speed"],param_00["rot_delay"]);
		var_16 = distance2d(var_03.origin,var_12.origin);
		var_04 unlink();
		playfxontag(common_scripts\utility::getfx("fus_crane_housing_dust_fall"),var_0E,"tag_origin");
		reactor_room_crane_adjust_housing(var_03,var_04,var_13,var_16,param_00["crane_housing_move_speed"],param_00["crane_housing_move_delay"]);
		var_04 linkto(var_03);
		var_06 unlink();
		var_17 = var_06.origin;
		var_06 notify("crane_moving");
		thread reactor_room_crane_murderplayer_think(var_09,var_06,var_12,param_00);
		playfxontag(common_scripts\utility::getfx("fus_crane_housing_dust"),var_0F,"tag_origin");
		var_06 moveto(var_12.origin + (0,0,param_00["crate_height"]),param_00["height_time"],param_00["height_acc"],param_00["height_dec"]);
		wait(param_00["height_time"]);
		var_06 notify("crane_stopped");
		thread reactor_room_crane_grab_crate(var_06,var_12,param_00);
		var_06 waittill("crate_grabbed");
		var_18 = common_scripts\utility::spawn_tag_origin();
		var_18.origin = var_12.origin;
		var_18 linkto(var_12);
		playfxontag(common_scripts\utility::getfx("fus_crate_dust_lift"),var_18,"tag_origin");
		var_12 notify("crate_raised");
		level notify("crate_raising");
		var_06 notify("crane_moving");
		var_06 moveto(var_17,param_00["height_time"],param_00["height_acc"],param_00["height_dec"]);
		wait(param_00["height_time"]);
		var_06 notify("crane_stopped");
		wait(param_00["raise_delay"]);
		var_06 linkto(var_04);
		var_13 = var_15;
		reactor_room_crane_rotate_to_angle(var_03,var_13,param_00["rot_speed"],param_00["rot_delay"]);
		var_16 = randomintrange(param_00["min_dist"],param_00["max_dist"]);
		var_04 unlink();
		reactor_room_crane_adjust_housing(var_03,var_04,var_13,var_16,param_00["crane_housing_move_speed"],param_00["crane_housing_move_delay"]);
		var_04 linkto(var_03);
		var_06 notify("crane_moving");
		var_06 unlink();
		var_06 moveto(var_06.origin - (0,0,param_00["crane_height_delta"]),param_00["height_time"],param_00["height_acc"],param_00["height_dec"]);
		wait(param_00["height_time"]);
		var_06 notify("crane_stopped");
		wait(param_00["lower_delay"]);
		var_06 notify("crate_release");
		var_18 delete();
		wait(0.05);
		var_06 notify("crane_moving");
		var_06 moveto(var_06.origin + (0,0,param_00["crane_height_delta"]),param_00["height_time"],param_00["height_acc"],param_00["height_dec"]);
		wait(param_00["height_time"]);
		var_06 notify("crane_stopped");
		wait(param_00["raise_delay"]);
		var_06 linkto(var_04);
	}

	for(;;)
	{
		switch(param_01)
		{
			case "north":
				var_13 = randomintrange(25,180);
				break;
	
			case "south":
			default:
				var_13 = randomintrange(180,360);
				break;
		}

		var_16 = randomintrange(param_00["min_dist"],param_00["max_dist"]);
		reactor_room_crane_rotate_to_angle(var_03,var_13,param_00["rot_speed"],param_00["rot_delay"]);
		var_04 unlink();
		playfxontag(common_scripts\utility::getfx("fus_crane_housing_dust_fall"),var_0E,"tag_origin");
		reactor_room_crane_adjust_housing(var_03,var_04,var_13,var_16,param_00["crane_housing_move_speed"],param_00["crane_housing_move_delay"]);
		var_04 linkto(var_03);
		wait(randomfloatrange(3,7));
	}
}

//Function Number: 249
reactor_room_crane_murderplayer_think(param_00,param_01,param_02,param_03)
{
	param_01 endon("crane_stopped");
	self endon("murderbox_activate");
	for(;;)
	{
		if(distance(param_00.origin,param_02.origin) < 85)
		{
			if(level.player istouching(param_00))
			{
				var_04 = level.player.health / level.player.damagemultiplier;
				level.player dodamage(var_04,param_01.origin);
				self notify("murderbox_activate");
			}
		}

		wait 0.05;
	}
}

//Function Number: 250
reactor_room_crane_grab_crate(param_00,param_01,param_02)
{
	param_00 maps\_anim::anim_single_solo(param_00,"crane_grab");
	param_00 thread maps\_anim::anim_first_frame_solo(param_00,"crane_closed");
	soundscripts\_snd::snd_message("crane_claw_crate_grab",param_00);
	param_01 linkto(param_00);
	wait(0.05);
	param_00 notify("crate_grabbed");
	param_00 waittill("crate_release");
	param_00 thread maps\_anim::anim_first_frame_solo(param_00,"crane_opened");
	soundscripts\_snd::snd_message("crane_claw_crate_release",param_00);
	param_01 delete();
}

//Function Number: 251
reactor_room_crane_light()
{
	level endon("elevator_ascend");
	var_00 = common_scripts\utility::spawn_tag_origin();
	var_00.origin = self.origin;
	var_00.angles = self.angles;
	var_00 linkto(self);
	var_00 thread maps\fusion_utility::delete_on_notify("reactor_room_cleanup");
	while(!common_scripts\utility::flag("elevator_ascend"))
	{
		playfxontag(common_scripts\utility::getfx("fus_crane_light_red"),var_00,"tag_origin");
		self waittill("crate_grabbed");
		stopfxontag(common_scripts\utility::getfx("fus_crane_light_red"),var_00,"tag_origin");
		playfxontag(common_scripts\utility::getfx("fus_crane_light_green"),var_00,"tag_origin");
		self waittill("crate_release");
		stopfxontag(common_scripts\utility::getfx("fus_crane_light_green"),var_00,"tag_origin");
	}
}

//Function Number: 252
reactor_room_link_cables(param_00,param_01)
{
	var_02 = param_00;
	if(param_01)
	{
		var_02 linkto(self);
	}
	else
	{
		var_02 unlink();
	}

	while(isdefined(var_02.target))
	{
		var_02 = getent(var_02.target,"targetname");
		if(param_01)
		{
			var_02 linkto(self);
			continue;
		}

		var_02 unlink();
	}
}

//Function Number: 253
reactor_room_get_best_crate(param_00,param_01)
{
	var_02 = 10000;
	var_03 = 10000;
	var_04 = 1000000;
	var_05 = (0,0,32);
	var_06 = 65;
	if(level.reactor_room_crate_tracking["scripted_crate"] < 1)
	{
		level.reactor_room_crate_tracking["scripted_crate"]++;
		thread reactor_room_allies_run_from_crate();
		return common_scripts\utility::getclosest((3290,3676,-601),param_00,200);
	}

	if(level.reactor_room_crate_tracking["near_player"] < 1)
	{
		foreach(var_08 in param_00)
		{
			if(distancesquared(var_08.origin,level.player.origin) < var_02)
			{
				level.reactor_room_crate_tracking["near_player"]++;
				return var_08;
			}
		}
	}

	if(level.reactor_room_crate_tracking["near_enemies"] < 3)
	{
		foreach(var_08 in param_00)
		{
			foreach(var_0C in getaiarray("axis"))
			{
				if(distancesquared(var_08.origin,var_0C.origin) < var_03)
				{
					if(distancesquared(level.player.origin,var_08.origin) < var_04)
					{
						level.reactor_room_crate_tracking["near_enemies"]++;
						return var_08;
					}
				}
			}
		}
	}

	foreach(var_08 in param_00)
	{
		if(level.player worldpointinreticle_circle(var_08.origin + var_05,var_06,500))
		{
			if(distancesquared(level.player.origin,var_08.origin) > var_02)
			{
				if(distancesquared(level.player.origin,var_08.origin) < var_04)
				{
					return var_08;
				}
			}
		}
	}

	return param_00[randomint(param_00.size)];
}

//Function Number: 254
reactor_room_crane_rotate_to_angle(param_00,param_01,param_02,param_03)
{
	if(param_01 >= 360)
	{
		param_01 = param_01 - 360;
	}

	var_04 = abs(param_00.angles[1] - param_01) / param_02;
	var_05 = 2;
	var_06 = 2;
	if(var_04 < 2)
	{
		var_04 = 2;
	}

	if(var_04 < 4)
	{
		var_05 = var_04 / 2;
		var_06 = var_04 / 2;
	}

	if(var_04 > 0)
	{
		playfxontag(common_scripts\utility::getfx("fus_crane_track_sparks"),param_00.track_inner,"tag_origin");
		playfxontag(common_scripts\utility::getfx("fus_crane_track_sparks"),param_00.track_outer,"tag_origin");
		soundscripts\_snd::snd_message("crane_mach_mvmnt_start",param_00.track_inner,param_00.track_outer);
		param_00 rotateto((0,param_01,0),var_04,var_05,var_06);
		wait(var_04);
		stopfxontag(common_scripts\utility::getfx("fus_crane_track_sparks"),param_00.track_inner,"tag_origin");
		stopfxontag(common_scripts\utility::getfx("fus_crane_track_sparks"),param_00.track_outer,"tag_origin");
		soundscripts\_snd::snd_message("crane_mach_mvmnt_stop",param_00.track_inner,param_00.track_outer);
	}

	wait(param_03);
}

//Function Number: 255
reactor_room_crane_adjust_housing(param_00,param_01,param_02,param_03,param_04,param_05)
{
	var_06 = cos(param_02) * param_03;
	var_07 = sin(param_02) * param_03;
	var_08 = (param_00.origin[0] + var_06,param_00.origin[1] + var_07,param_01.origin[2]);
	var_09 = distance(var_08,param_01.origin) / param_04;
	if(var_09 > 0)
	{
		soundscripts\_snd::snd_message("crane_claw_mvmnt_start",param_01);
		param_01 moveto(var_08,var_09,var_09 / 2,var_09 / 2);
		wait(var_09);
		soundscripts\_snd::snd_message("crane_claw_mvmnt_stop",param_01);
	}

	wait(param_05);
}

//Function Number: 256
reactor_room_crate_think()
{
	self disconnectpaths();
	var_00 = common_scripts\utility::get_target_ent();
	var_00 linkto(self);
	self waittill("crate_raised");
	var_01 = self.origin;
	badplace_cylinder("",3,var_01,80,64,"axis","allies");
	var_02 = getnodesinradius(var_01,80,0,128,"Cover");
	foreach(var_04 in var_02)
	{
		var_04 disconnectnode();
	}

	wait(3);
	self connectpaths();
	self waittill("death");
	var_00 delete();
}

//Function Number: 257
get_angle_from_center(param_00,param_01)
{
	return vectortoangles(param_01 - param_00)[1];
}

//Function Number: 258
reactor_room_robots()
{
	common_scripts\utility::flag_wait("reactor_room_reveal_scene");
	var_00 = getentarray("reactor_bot","targetname");
	common_scripts\utility::array_thread(getentarray("reactor_bot","targetname"),::reactor_room_robot_think);
	common_scripts\utility::array_thread(getentarray("reactor_bot_scripted","targetname"),::reactor_room_robot_scripted_think);
}

//Function Number: 259
reactor_room_robot_think()
{
	level endon("elevator_ascend");
	self endon("death");
	self endon("stop_movement");
	self.health = 100;
	self setcandamage(1);
	thread reactor_room_robot_monitor_death();
	thread maps\_shg_utility::make_emp_vulnerable();
	self.emp_death_function = ::reactor_room_robot_emp_death;
	self.facing = 1;
	var_00 = common_scripts\utility::getstruct(self.target,"targetname");
	var_01 = common_scripts\utility::getstruct(var_00.target,"targetname");
	var_02 = common_scripts\utility::getstruct(var_01.target,"targetname");
	self.collision = getent(self.target,"targetname");
	self.collision linkto(self);
	var_03 = 32;
	var_04 = 0.5;
	var_05 = distance(var_00.origin,var_01.origin) / var_03 + 1;
	var_06 = distance(var_01.origin,var_02.origin) / var_03 + 1;
	if(var_05 - int(var_05) > 0.5)
	{
		var_05 = int(var_05);
		var_05++;
	}
	else
	{
		var_05 = int(var_05);
	}

	if(var_06 - int(var_06) > 0.5)
	{
		var_06 = int(var_06);
		var_06++;
	}
	else
	{
		var_06 = int(var_06);
	}

	var_07 = vectortoangles(var_01.origin - var_00.origin);
	var_08 = vectortoangles(var_02.origin - var_01.origin);
	var_09 = getentarray(var_02.target,"targetname");
	self.collision thread reactor_robots_badplace_think();
	common_scripts\utility::array_thread(var_09,::reactor_robots_shelf_think);
	var_0A = [];
	for(var_0B = 0;var_0B < var_05;var_0B++)
	{
		for(var_0C = 0;var_0C < var_06;var_0C++)
		{
			var_0A[var_0B][var_0C] = spawnstruct();
			var_0D = var_03 * var_0B * cos(var_07[1]) + var_03 * var_0C * sin(-1 * var_07[1]);
			var_0E = -1 * var_03 * var_0B * cos(var_08[1]) + var_03 * var_0C * sin(var_08[1]);
			var_0A[var_0B][var_0C].origin = (var_0D,var_0E,0) + var_00.origin;
			var_0F = 0;
			foreach(var_11 in var_09)
			{
				var_12 = var_0A[var_0B][var_0C].origin;
				if(distance(var_0A[var_0B][var_0C].origin,var_11.origin) < 16)
				{
					var_0A[var_0B][var_0C].shelf = 1;
					var_11.x = var_0B;
					var_11.y = var_0C;
				}
			}

			if(distance(var_0A[var_0B][var_0C].origin,self.origin) < 10)
			{
				var_0A[var_0B][var_0C].robot = 1;
				self.x = var_0B;
				self.y = var_0C;
			}
		}
	}

	for(;;)
	{
		foreach(var_11 in var_09)
		{
			var_0A = clear_path_weights(var_0A);
			var_0A = add_path_weights(var_0A,var_11.x,var_11.y,0,0);
			if(!isdefined(var_11.starting_origin))
			{
				var_11.starting_origin = var_11.origin;
			}

			self notify("update_path_weights");
			move_to_dest(var_0A,var_11.x,var_11.y);
			var_0A = clear_path_weights(var_0A);
			var_15 = 0;
			var_16 = 10;
			var_17 = 0;
			var_18 = 0;
			while(var_15 <= var_16 && !isdefined(var_0A[var_17][var_18].path_weight) && isdefined(var_0A[self.x][self.y].path_weight) && var_17 != self.x || var_18 != self.y)
			{
				var_17 = randomint(var_05);
				var_18 = randomint(var_06);
				var_0A = clear_path_weights(var_0A);
				var_0A = add_path_weights(var_0A,var_17,var_18,0,1);
				var_15++;
				wait(0.05);
			}

			if(var_15 > var_16)
			{
				wait(2);
				continue;
			}

			soundscripts\_snd::snd_message("reactor_bot_shelf_pickup",self);
			var_11 moveto((var_11.origin[0],var_11.origin[1],var_11.starting_origin[2] + var_04),0.2,0.1,0.1);
			wait(0.2);
			var_11 linkto(self);
			self.shelf = var_11;
			self notify("update_path_weights");
			move_to_dest(var_0A,var_17,var_18);
			var_11.x = var_17;
			var_11.y = var_18;
			var_11 unlink();
			self.shelf = undefined;
			soundscripts\_snd::snd_message("reactor_bot_shelf_drop",self);
			var_11 moveto((var_11.origin[0],var_11.origin[1],var_11.starting_origin[2] + var_04),0.2,0.1,0.1);
			wait(0.2);
		}
	}
}

//Function Number: 260
reactor_room_robot_emp_death()
{
	self endon("death");
	self notify("stop_movement");
	self notify("emp");
	playfxontag(common_scripts\utility::getfx("emp_reactor_robot_damage"),self,"tag_origin");
	self moveto(self.origin,0.05);
	self rotateto(self.angles,0.05);
	wait(randomfloatrange(0.5,1.5));
	stopfxontag(common_scripts\utility::getfx("emp_reactor_robot_damage"),self,"tag_origin");
	self notify("death");
}

//Function Number: 261
reactor_room_robot_monitor_death()
{
	self endon("emp");
	self endon("robot_lowered");
	self waittill("death");
	self notify("stop_movement");
	playfx(common_scripts\utility::getfx("reactor_robot_death"),self.origin);
}

//Function Number: 262
move_to_dest(param_00,param_01,param_02)
{
	self endon("stop_movement");
	var_03 = 1;
	var_04 = 1;
	var_05 = 0.05;
	var_06 = isdefined(self.shelf);
	while(!self.x == param_01 && self.y == param_02)
	{
		var_07 = get_next_grid_position(param_00,self.x,self.y);
		if(var_06)
		{
			param_00[self.x][self.y].shelf = undefined;
		}

		if(self.facing_goal != self.facing)
		{
			if(var_06)
			{
				self.shelf unlink();
			}

			self.collision unlink();
			self rotateto(self.angles + (0,90 * self.facing_goal - self.facing,0),var_04);
			self.facing = self.facing_goal;
			if(var_06)
			{
				soundscripts\_snd::snd_message("reactor_bot_turn_shelf",self);
			}
			else
			{
				soundscripts\_snd::snd_message("reactor_bot_turn_self",self);
			}

			wait(var_04 + var_05);
			if(var_06)
			{
				self.shelf linkto(self);
			}

			self.collision linkto(self);
		}

		wait_until_path_safe();
		if(var_06)
		{
			soundscripts\_snd::snd_message("reactor_bot_drive_shelf_start",self);
		}
		else
		{
			soundscripts\_snd::snd_message("reactor_bot_drive_self_start",self);
		}

		self moveto(param_00[var_07[0]][var_07[1]].origin,var_03);
		wait(var_03 + var_05);
		if(var_06)
		{
			soundscripts\_snd::snd_message("reactor_bot_drive_shelf_stop",self);
		}
		else
		{
			soundscripts\_snd::snd_message("reactor_bot_drive_self_stop",self);
		}

		if(var_06)
		{
			param_00[var_07[0]][var_07[1]].shelf = 1;
		}

		self.x = var_07[0];
		self.y = var_07[1];
	}
}

//Function Number: 263
wait_until_path_safe()
{
	var_00 = 0;
	while(!var_00)
	{
		var_00 = 1;
		if(distance(self.origin,level.player.origin) < 200)
		{
			var_00 = 0;
			wait(0.5);
			continue;
		}

		foreach(var_02 in getaiarray())
		{
			if(distancesquared(self.origin,var_02.origin) < 9216)
			{
				var_00 = 0;
				wait(0.5);
				break;
			}
		}
	}
}

//Function Number: 264
get_next_grid_position(param_00,param_01,param_02)
{
	var_03 = param_00[param_01][param_02].path_weight;
	var_04 = param_00.size;
	var_05 = param_00[0].size;
	var_06 = 999;
	var_07 = undefined;
	if(param_01 > 0)
	{
		var_08 = param_00[param_01 - 1][param_02].path_weight;
		if(isdefined(var_08))
		{
			if(var_08 < var_06)
			{
				var_06 = var_08;
				var_07 = "left";
			}
		}
	}

	if(param_01 < var_04 - 1)
	{
		var_08 = param_00[param_01 + 1][param_02].path_weight;
		if(isdefined(var_08))
		{
			if(var_08 < var_06)
			{
				var_06 = var_08;
				var_07 = "right";
			}
		}
	}

	if(param_02 > 0)
	{
		var_08 = param_00[param_01][param_02 - 1].path_weight;
		if(isdefined(var_08))
		{
			if(var_08 < var_06)
			{
				var_06 = var_08;
				var_07 = "down";
			}
		}
	}

	if(param_02 < var_05 - 1)
	{
		var_08 = param_00[param_01][param_02 + 1].path_weight;
		if(isdefined(var_08))
		{
			if(var_08 < var_06)
			{
				var_06 = var_08;
				var_07 = "up";
			}
		}
	}

	var_09 = [];
	switch(var_07)
	{
		case "left":
			var_09 = [param_01 - 1,param_02];
			self.facing_goal = 1;
			break;

		case "right":
			var_09 = [param_01 + 1,param_02];
			self.facing_goal = 3;
			break;

		case "down":
			var_09 = [param_01,param_02 - 1];
			self.facing_goal = 2;
			break;

		case "up":
			var_09 = [param_01,param_02 + 1];
			self.facing_goal = 0;
			break;

		default:
			break;
	}

	return var_09;
}

//Function Number: 265
clear_path_weights(param_00)
{
	for(var_01 = 0;var_01 < param_00.size;var_01++)
	{
		for(var_02 = 0;var_02 < param_00[var_01].size;var_02++)
		{
			param_00[var_01][var_02].path_weight = undefined;
		}
	}

	return param_00;
}

//Function Number: 266
add_path_weights(param_00,param_01,param_02,param_03,param_04)
{
	if(param_04 && isdefined(param_00[param_01][param_02].shelf) && param_00[param_01][param_02].shelf && !self.x == param_01 && self.y == param_02)
	{
		param_00[param_01][param_02].path_weight = undefined;
		return param_00;
	}

	var_05 = param_00[param_01][param_02].path_weight;
	var_06 = param_00.size;
	var_07 = param_00[0].size;
	if(param_03 > 25)
	{
		return param_00;
	}

	if(!isdefined(var_05) || var_05 > param_03)
	{
		param_00[param_01][param_02].path_weight = param_03;
		param_03++;
		if(param_01 > 0)
		{
			param_00 = add_path_weights(param_00,param_01 - 1,param_02,param_03,param_04);
		}

		if(param_01 < var_06 - 1)
		{
			param_00 = add_path_weights(param_00,param_01 + 1,param_02,param_03,param_04);
		}

		if(param_02 > 0)
		{
			param_00 = add_path_weights(param_00,param_01,param_02 - 1,param_03,param_04);
		}

		if(param_02 < var_07 - 1)
		{
			param_00 = add_path_weights(param_00,param_01,param_02 + 1,param_03,param_04);
		}
	}

	return param_00;
}

//Function Number: 267
reactor_robots_shelf_think()
{
	var_00 = getentarray(self.target,"targetname");
	foreach(var_02 in var_00)
	{
		var_02 linkto(self);
	}

	reactor_robots_badplace_think();
}

//Function Number: 268
reactor_robots_badplace_think()
{
	var_00 = 0.1;
	if(level.currentgen)
	{
		var_00 = 0.3;
	}

	var_01 = 31;
	var_02 = 128;
	while(!common_scripts\utility::flag("elevator_ascend"))
	{
		self connectpaths();
		self disconnectpaths();
		wait(var_00);
	}

	self connectpaths();
}

//Function Number: 269
reactor_room_robot_scripted_think()
{
	level endon("elevator_ascend");
	var_00 = getentarray(self.target,"targetname");
	var_00 = common_scripts\utility::array_combine(var_00,common_scripts\utility::getstructarray(self.target,"targetname"));
	var_01 = undefined;
	var_02 = undefined;
	var_03 = undefined;
	var_04 = undefined;
	var_05 = undefined;
	var_06 = undefined;
	var_07 = 1;
	var_08 = [];
	var_08[var_08.size] = 18;
	var_08[var_08.size] = 36;
	var_08[var_08.size] = 54;
	foreach(var_0A in var_00)
	{
		switch(var_0A.script_parameters)
		{
			case "start_node":
				var_01 = var_0A;
				break;

			case "initial_lift":
				var_0B = getentarray("reactor_robot_lift","script_noteworthy");
				foreach(var_0D in var_0B)
				{
					if(distance(var_0D.origin,var_0A.origin) < 10)
					{
						var_03 = var_0D;
						break;
					}
				}
				break;

			case "initial_lift_gate":
				var_0F = getentarray("bot_lift_gate","script_noteworthy");
				foreach(var_11 in var_0F)
				{
					if(distance(var_11.origin,var_0A.origin) < 10)
					{
						var_02 = var_11;
						break;
					}
				}
				break;

			case "final_lift":
				var_0B = getentarray("reactor_robot_lift","script_noteworthy");
				foreach(var_0D in var_0B)
				{
					if(distance(var_0D.origin,var_0A.origin) < 10)
					{
						var_04 = var_0D;
						break;
					}
				}
				break;

			case "final_gate":
				var_15 = getentarray("reactor_robot_final_gate","script_noteworthy");
				foreach(var_11 in var_15)
				{
					if(distance(var_11.origin,var_0A.origin) < 10)
					{
						var_05 = var_11;
						break;
					}
				}
				break;

			case "shelf":
				var_06 = var_0A;
				var_06 thread reactor_robots_badplace_think();
				break;

			default:
				break;
		}
	}

	if(!isdefined(var_01))
	{
		return;
	}

	if(!isdefined(var_03))
	{
		return;
	}

	if(!isdefined(var_02))
	{
		return;
	}

	if(!isdefined(var_04))
	{
		return;
	}

	if(!isdefined(var_05))
	{
		return;
	}

	if(!isdefined(var_06))
	{
		return;
	}

	var_19 = var_06.origin;
	var_1A = 1;
	var_1B = 32;
	var_1C = 4;
	var_1D = 64;
	var_1E = 3;
	var_1F = 1;
	var_20 = 1;
	var_21 = 3;
	var_22 = 1;
	var_23 = 1;
	var_24 = 1;
	var_1D = 44;
	var_25 = var_21;
	var_1E = var_21 / 2;
	var_1F = var_1E / 2;
	var_20 = var_1E / 2;
	var_26 = 1;
	var_27 = 0.5;
	var_28 = 0.5;
	var_29 = common_scripts\utility::getstruct(var_05.target,"targetname").origin;
	var_2A = var_05.origin;
	var_2B = 128;
	var_2C = 3;
	var_2D = 1;
	var_2E = 1;
	var_03.bars = [];
	var_04.bars = [];
	var_2F = common_scripts\utility::getstructarray("lift_bars","targetname");
	foreach(var_31 in var_2F)
	{
		if(distance(var_31.origin,var_03.origin) < 64)
		{
			var_03.bars[var_03.bars.size] = var_31;
			var_32 = getentarray(var_31.target,"targetname");
			foreach(var_34 in var_32)
			{
				var_34 linkto(var_03);
			}

			continue;
		}

		if(distance(var_31.origin,var_04.origin) < 64)
		{
			var_04.bars[var_04.bars.size] = var_31;
			var_32 = getentarray(var_31.target,"targetname");
			foreach(var_34 in var_32)
			{
				var_34 linkto(var_04);
			}
		}
	}

	for(;;)
	{
		reactor_room_robots_lift_adjust_bars(var_03,"lower","initial");
		wait(randomfloatrange(1,10));
		var_06.origin = var_19;
		var_06 linkto(self);
		wait(0.05);
		var_39 = var_01.angles;
		var_3A = var_39;
		if(self.angles != var_01.angles)
		{
			self rotateto(var_01.angles,0.05);
			wait(0.1);
		}

		var_3B = spawn("script_model",self.origin);
		var_3B setmodel("fus_shelving_robot_01");
		var_3B.angles = self.angles;
		var_3B linkto(self);
		var_3B endon("stop_movement");
		var_3B.health = 100;
		var_3B setcandamage(1);
		var_3B thread maps\_shg_utility::make_emp_vulnerable();
		var_3B.emp_death_function = ::reactor_room_robot_emp_death;
		var_3B thread reactor_room_robot_monitor_death();
		var_3C = spawn("script_model",self.origin);
		var_3C setmodel("fus_shelving_unit_cage_01");
		var_3C.angles = self.angles;
		var_3C linkto(var_06);
		var_06.models = [];
		var_06.models[var_06.models.size] = var_3B;
		var_06.models[var_06.models.size] = var_3C;
		for(var_3D = 0;var_3D < 3;var_3D++)
		{
			if(common_scripts\utility::cointoss())
			{
				var_3E = spawn("script_model",self.origin + (0,0,var_08[var_3D]));
				var_3E setmodel("fus_shelving_unit_item_01");
				var_3E.angles = self.angles + (0,90,0);
				var_3E linkto(var_06);
				var_06.models[var_06.models.size] = var_3E;
			}
		}

		self linkto(var_03);
		var_3F = common_scripts\utility::getstruct(var_01.target,"targetname");
		var_40 = self.origin[2] - var_3F.origin[2];
		soundscripts\_snd::snd_message("reactor_bot_elevator_start_lp",var_03);
		var_03 moveto(var_03.origin - (0,0,var_40),var_21,var_22,var_23);
		var_02 common_scripts\utility::delaycall(var_25,::moveto,var_02.origin - (0,0,var_1D),var_1E,var_1F,var_20);
		wait(var_21);
		soundscripts\_snd::snd_message("reactor_bot_initial_elevator_stop",var_03);
		soundscripts\_snd::snd_message("reactor_bot_elevator_stop_lp",var_03);
		reactor_room_robots_lift_adjust_bars(var_03,"raise","initial");
		self unlink();
		var_41 = common_scripts\utility::getstruct(var_3F.target,"targetname");
		var_42 = vectortoangles(var_41.origin - self.origin);
		if(abs(var_42[1] - var_39[1]) > 2)
		{
			wait(0.1);
			self rotateto(var_42,var_07);
			soundscripts\_snd::snd_message("reactor_bot_turn_self",self);
			wait(var_07 + 0.1);
			var_39 = var_42;
			wait(0.1);
		}

		var_43 = 0;
		while(isdefined(var_3F.target))
		{
			var_3F = common_scripts\utility::getstruct(var_3F.target,"targetname");
			var_42 = vectortoangles(var_3F.origin - self.origin);
			if(abs(var_42[1] - var_39[1]) > 2)
			{
				var_06 unlink();
				wait(0.1);
				self rotateto(var_42,var_07);
				soundscripts\_snd::snd_message("reactor_bot_turn_shelf",self);
				wait(var_07 + 0.1);
				var_39 = var_42;
				var_06 linkto(self);
				wait(0.1);
			}

			while(distance(self.origin,var_3F.origin) > var_1B + 4)
			{
				wait_until_path_safe();
				soundscripts\_snd::snd_message("reactor_bot_drive_shelf_start",self);
				self moveto(vectornormalize(var_3F.origin - self.origin) * 32 + self.origin,var_1A);
				var_43++;
				wait(var_1A);
				soundscripts\_snd::snd_message("reactor_bot_drive_shelf_stop",self);
				if(var_43 == 2)
				{
					soundscripts\_snd::snd_message("reactor_bot_initial_elevator_start",var_03,var_24);
					var_03 common_scripts\utility::delaycall(var_24,::moveto,var_03.origin + (0,0,var_40),var_21,var_22,var_23);
					var_02 moveto(var_02.origin + (0,0,var_1D),var_1E,var_1F,var_20);
				}
			}

			wait_until_path_safe();
			soundscripts\_snd::snd_message("reactor_bot_drive_shelf_start",self);
			var_44 = var_1A * distance(self.origin,var_3F.origin) / var_1B;
			self moveto(var_3F.origin,var_44);
			wait(var_44);
			soundscripts\_snd::snd_message("reactor_bot_drive_shelf_stop",self);
		}

		reactor_room_robots_lift_adjust_bars(var_04,"lower","final");
		self linkto(var_04);
		soundscripts\_snd::snd_message("reactor_bot_final_elevator_start",var_04);
		var_04 moveto(var_04.origin - (0,0,var_2B),var_2C,var_2D,var_2E);
		var_05 common_scripts\utility::delaycall(2,::moveto,var_29,var_26,var_27,var_28);
		wait(var_2C);
		self unlink();
		var_45 = self setcontents(0);
		var_3B notify("robot_lowered");
		foreach(var_47 in var_06.models)
		{
			var_47 delete();
		}

		self hide();
		wait(0.5);
		self.origin = var_01.origin;
		wait(0.5);
		self setcontents(var_45);
		self show();
		reactor_room_robots_lift_adjust_bars(var_04,"raise","final");
		soundscripts\_snd::snd_message("reactor_bot_elevator_start_lp",var_04);
		var_04 moveto(var_04.origin + (0,0,var_2B),var_2C,var_2D,var_2E);
		soundscripts\_snd::snd_message("reactor_bot_final_elevator_stop",var_04,var_2C);
		soundscripts\_snd::snd_message("reactor_bot_elevator_stop_lp",var_04,var_2C);
		var_05 moveto(var_2A,var_26,var_27,var_28);
		soundscripts\_snd::snd_message("reactor_bot_elevator_open",var_05);
	}
}

//Function Number: 270
reactor_room_robots_lift_adjust_bars(param_00,param_01,param_02)
{
	if(param_02 == "initial")
	{
		var_03 = "start_bars";
	}
	else
	{
		var_03 = "end_bars";
	}

	var_04 = undefined;
	var_05 = undefined;
	foreach(var_07 in param_00.bars)
	{
		if(var_07.script_noteworthy == var_03)
		{
			var_05 = var_07;
		}
	}

	var_09 = 45;
	var_0A = 1;
	var_0B = 0.5;
	var_0C = 0.5;
	if(param_01 == "raise")
	{
		var_09 = var_09 * -1;
	}

	var_05 = getentarray(var_05.target,"targetname");
	var_0D = undefined;
	var_0E = undefined;
	foreach(var_10 in var_05)
	{
		if(var_10.script_noteworthy == "roll_down_bar_left")
		{
			var_0D = var_10;
		}
		else
		{
			var_0E = var_10;
		}

		var_10 unlink();
	}

	var_0E rotateroll(var_09,var_0A,var_0B,var_0C);
	var_0D rotateroll(var_09,var_0A,var_0B,var_0C);
	wait(var_0A);
	foreach(var_10 in var_05)
	{
		var_10 unlink();
		var_10 linkto(param_00);
	}

	wait(0.05);
}

//Function Number: 271
reactor_room_allies_run_from_crate()
{
	level waittill("crate_raising");
	var_00 = getent("reveal_crate_color_trigger","targetname");
	if(isdefined(var_00))
	{
		var_00 maps\_utility::activate_trigger();
	}
}

//Function Number: 272
reactor_room_redshirts()
{
	level endon("turbine_elevator_reached_top");
	for(;;)
	{
		common_scripts\utility::flag_wait("reactor_redshirts_enable");
		self.count++;
		var_00 = maps\_utility::spawn_ai();
		var_00 waittill("death");
		wait(randomfloatrange(1,5));
	}
}

//Function Number: 273
reactor_room_redshirt_cleanup()
{
	level waittill("turbine_elevator_reached_top");
	waittillframeend;
	common_scripts\utility::array_call(getentarray("reactor_redshirts","script_noteworthy"),::delete);
}

//Function Number: 274
reactor_room_combat()
{
	thread reactor_room_catwalk_combat();
	thread reactor_room_combat_seek_player();
	thread reactor_room_combat_mid_checkpoint();
	common_scripts\utility::flag_wait("reactor_room_end_combat");
	level.burke maps\_utility::disable_careful();
	level.joker maps\_utility::disable_careful();
	level.carter maps\_utility::disable_careful();
}

//Function Number: 275
enemy_combat_equip_microwave_grenades()
{
	var_00 = getaiarray("axis");
	foreach(var_02 in var_00)
	{
		if(isdefined(var_02.script_parameters) && var_02.script_parameters == "microwave_equipped")
		{
			var_02 maps\_utility::add_spawn_function(::reactor_room_microwave_grenade_equip);
		}
	}
}

//Function Number: 276
reactor_room_combat_mid_checkpoint()
{
	level endon("elevator_ascend");
	common_scripts\utility::flag_wait("reactor_room_combat_mid_save_1");
	maps\_utility::autosave_by_name();
}

//Function Number: 277
reactor_room_combat_seek_player()
{
	common_scripts\utility::flag_wait("flag_reactor_room_combat_seek_player");
	level.burke maps\_utility::disable_careful();
	level.joker maps\_utility::disable_careful();
	level.carter maps\_utility::disable_careful();
	var_00 = getaiarray("axis");
	foreach(var_02 in var_00)
	{
		var_02 thread maps\_utility::player_seek_enable();
	}
}

//Function Number: 278
reactor_room_microwave_grenade_equip()
{
	maps\fusion_utility::equip_microwave_grenade();
}

//Function Number: 279
reactor_room_catwalk_death()
{
	level endon("elevator_ascend");
	common_scripts\utility::flag_wait("reactor_room_catwalk_death");
	var_00 = common_scripts\utility::getstruct("reactor_room_catwalk_death","targetname");
	var_01 = getdvarint("cg_fov");
	if(!level.player worldpointinreticle_circle(var_00.origin,var_01,250))
	{
		var_02 = var_00 common_scripts\utility::get_target_ent() maps\_utility::spawn_ai();
		var_02.deathfunction = undefined;
		var_02.animname = "generic";
		var_02 maps\_utility::set_deathanim("reactor_room_catwalk_death");
		var_02 kill();
	}
}

//Function Number: 280
reactor_room_catwalk_combat()
{
	level endon("elevator_ascend");
	var_00 = getent("reactor_room_below_catwalk","targetname");
	var_01 = common_scripts\utility::getstruct("reactor_room_catwalk_struct","targetname");
	var_02 = getentarray("reactor_catwalk_spawner_test","script_noteworthy");
	common_scripts\utility::array_thread(var_02,::reactor_catwalk_spawner_trigger_think);
	for(;;)
	{
		level waittill("reactor_catwalk_spawner_trigger_hit");
		if(level.player istouching(var_00))
		{
			wait(0.1);
			var_03 = getaiarray("axis");
			foreach(var_05 in var_03)
			{
				if(isalive(var_05) && var_05.origin[2] >= var_01.origin[2] && distance2dsquared(var_05.origin,var_01.origin) < var_01.radius * var_01.radius)
				{
					var_05 thread maps\fusion_utility::bloody_death();
				}
			}
		}
	}
}

//Function Number: 281
reactor_catwalk_spawner_trigger_think()
{
	self waittill("trigger");
	level notify("reactor_catwalk_spawner_trigger_hit");
}

//Function Number: 282
turbine_room()
{
	thread turbine_room_elevator();
	thread turbine_room_explosion();
	thread turbine_room_entrance_steam();
	thread turbine_room_turbines();
	thread turbine_room_atmosphere();
	thread turbine_room_combat();
	thread turbine_combat_mid_checkpoint_1();
	thread turbine_room_pre_explosion();
	thread pdrone_activate("turbine_room_combat_start");
	thread pdrone_deactivate_think();
	thread pdrone_deploy_hint();
}

//Function Number: 283
turbine_room_elevator()
{
	var_00 = getent("turbine_elevator_badplace","targetname");
	badplace_brush("turbine_elevator_badplace",0,var_00,"axis");
	var_01 = getent("elevator_ascend_use_trigger","targetname");
	if(level.player usinggamepad())
	{
		var_01 sethintstring(&"FUSION_OPERATE_ELEVATOR");
	}
	else
	{
		var_01 sethintstring(&"FUSION_OPERATE_ELEVATOR_PC");
	}

	var_02 = getent("elevator_cover_col","targetname");
	var_03 = getent("elevator_door_col","targetname");
	var_02 notsolid();
	var_03 notsolid();
	var_04 = getent("deployable_cover_final_model","targetname");
	var_04.contents = var_04 setcontents(0);
	var_04 hide();
	common_scripts\utility::flag_wait("turbine_elevator_enter");
	if(level.nextgen)
	{
		common_scripts\utility::array_thread(getaiarray("axis"),::maps\fusion_utility::bloody_death,5);
	}
	else
	{
		thread turbine_enemy_elevator_removal();
	}

	var_05 = getent("elevator_control","targetname");
	var_06 = getent("elevator_button","targetname");
	var_07 = 6;
	var_08 = 4;
	var_09 = getent("turbine_elevator_animnode","targetname");
	var_09 linkto(var_05);
	var_04 linkto(var_05);
	var_0A = "elevator_button_scene";
	level.player_rig = maps\_utility::spawn_anim_model("player_arms");
	level.player_rig hide();
	var_09 maps\_anim::anim_first_frame_solo(level.player_rig,var_0A);
	if(!isdefined(level.turbine_room_elevator_ascent_time))
	{
		common_scripts\utility::flag_set("vo_turbine_elevator_near");
		var_0B = "stop_elevator_idle";
		level.burke thread turbine_room_elevator_think(var_09,var_0B);
		level.carter thread turbine_room_elevator_think(var_09,var_0B);
		var_0C = level.joker.goalradius;
		level.joker.goalradius = 16;
		var_0D = [level.burke,level.carter,level.joker,level.player];
		var_0E = getent("inside_elevator_trigger","targetname");
		while(!var_0E check_if_multiple_ents_inside(var_0D))
		{
			wait(1);
		}

		level.burke maps\_utility::disable_ai_color();
		level.joker maps\_utility::disable_ai_color();
		level.carter maps\_utility::disable_ai_color();
		common_scripts\utility::flag_set("update_obj_pos_turbine_elevator_button");
		common_scripts\utility::flag_set("vo_turbine_elevator_ready");
		var_0F = maps\_shg_utility::hint_button_position("use",var_06.origin,40,512);
		level.joker.goalradius = var_0C;
		common_scripts\utility::flag_set("elevator_ascend_ready");
		common_scripts\utility::flag_wait("elevator_ascend");
		var_0F maps\_shg_utility::hint_button_clear();
		common_scripts\utility::flag_set("update_obj_pos_turbine_elevator_ascent");
		thread turbine_room_elevator_button_pressed_anim(var_0A,var_09);
		common_scripts\utility::array_thread(getaiarray("axis"),::maps\_vehicle::force_kill);
		var_01 delete();
		level waittill("flag_anim_elevator_button_pressed");
		var_06 setmodel("fus_elevator_button_02");
		var_10 = getent("joker_elevator_cover","targetname");
		level.joker forceteleport(var_10.origin,var_10.angles);
		level.joker thread turbine_room_elevator_think(var_09,var_0B,var_04);
		soundscripts\_snd::snd_message("start_turbine_elevator");
		level.turbine_room_elevator_ascent_time = 10;
		if(level.currentgen)
		{
			level.turbine_room_elevator_ascent_time = 15;
		}

		var_11 = getent("elevator_door_bottom_1","script_noteworthy");
		var_12 = getent("elevator_door_bottom_2","script_noteworthy");
		var_13 = getent("elevator_door_bottom_3","script_noteworthy");
		var_14 = getent("elevator_door_bottom_4","script_noteworthy");
		var_11 moveto(var_11.origin + (0,0,-51),var_07 / 2,var_07 / 6,var_07 / 6);
		var_12 moveto(var_12.origin + (0,0,-93),var_07 * 2 / 3,var_07 / 12,var_07 / 12);
		var_13 moveto(var_13.origin + (0,0,-140),var_07,var_07 / 18,var_07 / 18);
		var_14 common_scripts\utility::delaycall(var_07 * 3 / 4,::moveto,var_14.origin + (0,0,8),var_07 / 4,var_07 / 8,var_07 / 8);
		var_15 = getentarray("elevator_inner_door_upper","targetname");
		var_16 = getentarray("elevator_inner_door_lower","targetname");
		foreach(var_18 in var_15)
		{
			var_18 moveto(var_18.origin + (0,0,-80),var_08,var_08 / 6,var_08 / 6);
		}

		foreach(var_18 in var_16)
		{
			var_18 moveto(var_18.origin + (0,0,48),var_08,var_08 / 6,var_08 / 6);
		}

		maps\_utility::delaythread(0.5,::common_scripts\utility::flag_set,"vo_turbine_elevator");
		maps\_utility::delaythread(3,::common_scripts\utility::flag_set,"joker_place_elevator_cover");
		var_02 solid();
		var_02 linkto(var_05);
		var_03 solid();
		wait(var_07);
		if(level.currentgen)
		{
			level notify("tff_pre_transition_middle_to_outro");
			unloadtransient("fusion_middle_tr");
			loadtransient("fusion_outro_tr");
		}
	}
	else
	{
		var_02 solid();
		var_02 linkto(var_05);
		var_03 solid();
		var_04 show();
		var_04 setcontents(var_04.contents);
		common_scripts\utility::flag_set("update_obj_pos_turbine_elevator_button");
	}

	level notify("reactor_room_cleanup");
	soundscripts\_snd::snd_message("disable_turbine_elevator_trigger");
	common_scripts\utility::array_call(getentarray("reactor_room_enemies","script_noteworthy"),::delete);
	var_1C = getentarray("turbine_room_elevator","script_noteworthy");
	foreach(var_18 in var_1C)
	{
		var_18 linkto(var_05);
	}

	var_1F = getent("elevator_destination","targetname");
	var_20 = getent("elevator_door_top_1","script_noteworthy");
	var_21 = getent("elevator_door_top_2","script_noteworthy");
	var_22 = getent("elevator_door_top_3","script_noteworthy");
	var_23 = getent("elevator_door_top_4","script_noteworthy");
	var_21 disconnectpaths();
	var_22 disconnectpaths();
	if(level.turbine_room_elevator_ascent_time)
	{
		common_scripts\utility::flag_wait("joker_placing_turbine_elevator_cover");
		var_24 = maps\_utility::get_rumble_ent();
		var_24.intensity = 0.1;
		common_scripts\utility::noself_delaycall(level.turbine_room_elevator_ascent_time,::stopallrumbles);
		var_05 moveto(var_1F.origin,level.turbine_room_elevator_ascent_time,2,2);
		wait(level.turbine_room_elevator_ascent_time);
		if(level.currentgen)
		{
			while(!istransientloaded("fusion_outro_tr"))
			{
				wait(0.1);
			}

			level notify("tff_post_transition_middle_to_outro");
		}
	}
	else
	{
		var_25 = var_1F.origin - var_05.origin;
		var_05.origin = var_05.origin + var_25;
		var_02.origin = var_02.origin + var_25;
		var_09.origin = var_09.origin + var_25;
		var_0A = "turbine_elevator_exit";
		var_26 = "turbine_elevator_idle";
		var_0B = "stop_elevator_idle";
		var_09 thread maps\_anim::anim_single_solo_run(level.burke,var_0A);
		var_09 thread maps\_anim::anim_single_solo_run(level.carter,var_0A);
		var_09 thread maps\_anim::anim_loop_solo(level.joker,var_26,var_0B);
		var_09 thread maps\_utility::notify_delay(var_0B,5.5);
		var_09 maps\_utility::delaythread(5.5,::maps\_anim::anim_single_solo_run,level.joker,var_0A);
	}

	var_02 disconnectpaths();
	var_27 = getentarray("elevator_inner_exit_door_upper","targetname");
	var_28 = getentarray("elevator_inner_exit_door_lower","targetname");
	if(isdefined(var_20))
	{
		var_20 moveto(var_20.origin + (0,0,51),var_07 / 2,var_07 / 6,var_07 / 6);
		var_21 moveto(var_21.origin + (0,0,93),var_07 * 2 / 3,var_07 / 12,var_07 / 12);
		var_22 moveto(var_22.origin + (0,0,140),var_07,var_07 / 18,var_07 / 18);
		var_23 common_scripts\utility::delaycall(var_07 * 3 / 4,::moveto,var_23.origin + (0,0,-8),var_07 / 4,var_07 / 8,var_07 / 8);
		var_15 = getentarray("elevator_inner_door_upper","targetname");
		var_16 = getentarray("elevator_inner_door_lower","targetname");
		foreach(var_18 in var_15)
		{
			var_18 moveto(var_18.origin + (0,0,-80),var_08,var_08 / 6,var_08 / 6);
		}

		foreach(var_18 in var_16)
		{
			var_18 moveto(var_18.origin + (0,0,48),var_08,var_08 / 6,var_08 / 6);
		}
	}

	foreach(var_18 in var_27)
	{
		var_18 unlink();
		var_18 moveto(var_18.origin + (0,0,80),var_08,var_08 / 6,var_08 / 6);
	}

	foreach(var_18 in var_28)
	{
		var_18 unlink();
		var_18 moveto(var_18.origin + (0,0,-48),var_08,var_08 / 6,var_08 / 6);
	}

	common_scripts\_exploder::exploder(3501);
	common_scripts\_exploder::exploder(3502);
	level notify("turbine_elevator_reached_top");
	if(level.currentgen)
	{
		var_31 = ["turbine_room_enemy"];
		thread maps\_cg_encounter_perf_monitor::cg_spawn_perf_monitor("turbine_room_stop_combat",var_31,15,0);
		common_scripts\utility::flag_set("portal_on_turbine_room_flag");
	}

	soundscripts\_snd::snd_message("stop_turbine_elevator");
	common_scripts\utility::flag_set("control_room_run_prep");
	soundscripts\_snd::snd_message("start_turbine_loop");
	common_scripts\utility::flag_set("update_obj_pos_turbine_room_1");
	common_scripts\utility::flag_set("turbine_room_combat_start");
	maps\_utility::delaythread(10,::common_scripts\utility::flag_set,"vo_turbine_room_entrance");
	maps\_utility::autosave_by_name("turbine_elevator_complete");
	wait(1);
	var_21 connectpaths();
	var_22 connectpaths();
}

//Function Number: 284
turbine_enemy_elevator_removal()
{
	var_00 = getaiarray("axis");
	foreach(var_02 in var_00)
	{
		var_02 thread maps\_utility::player_seek_enable();
	}

	thread maps\_utility::ai_delete_when_out_of_sight(var_00,500);
}

//Function Number: 285
check_if_multiple_ents_inside(param_00)
{
	foreach(var_02 in param_00)
	{
		if(!var_02 istouching(self))
		{
			return 0;
		}
	}

	return 1;
}

//Function Number: 286
turbine_room_elevator_button_pressed_anim(param_00,param_01)
{
	level.player maps\_shg_utility::setup_player_for_scene();
	thread maps\_player_exo::player_exo_deactivate();
	var_02 = 0.4;
	level.player playerlinktoblend(level.player_rig,"tag_player",var_02);
	level.player common_scripts\utility::delaycall(var_02,::playerlinktodelta,level.player_rig,"tag_player",1,7,7,5,5,1);
	level.player take_car_door_shields();
	wait(var_02);
	level.player_rig show();
	level.player soundscripts\_snd::snd_message("turbine_room_elevator_button");
	param_01 maps\_anim::anim_single_solo(level.player_rig,param_00);
	level.player_rig delete();
	level.player unlink();
	level.player maps\_shg_utility::setup_player_for_gameplay();
	thread maps\_player_exo::player_exo_activate();
}

//Function Number: 287
turbine_room_elevator_think(param_00,param_01,param_02)
{
	var_03 = "turbine_elevator_enter";
	var_04 = "turbine_elevator_idle";
	var_05 = "turbine_elevator_exit";
	if(self == level.joker)
	{
		common_scripts\utility::flag_wait("joker_place_elevator_cover");
	}

	if(self == level.burke)
	{
		wait(2);
	}

	param_00 maps\_anim::anim_reach_solo(self,var_03);
	if(self == level.joker)
	{
		common_scripts\utility::flag_set("joker_placing_turbine_elevator_cover");
		var_06 = spawn("script_model",(0,0,0));
		var_06.animname = "deployable_cover";
		var_06 setmodel("deployable_cover");
		var_06 maps\_anim::setanimtree();
		var_06 linkto(param_00);
		param_00 thread maps\_anim::anim_single_solo(var_06,"deployable_cover_deploy");
		maps\_utility::delaythread(2.1,::common_scripts\_exploder::exploder,"fx_cover_deploy_impact");
		maps\_utility::delaythread(5,::common_scripts\_exploder::exploder,"fx_cover_deploy_impact_delay");
		var_07 = 5.4;
		param_02 common_scripts\utility::delaycall(var_07,::setcontents,param_02.contents);
		param_02 common_scripts\utility::delaycall(var_07,::show);
		var_06 common_scripts\utility::delaycall(var_07,::delete);
	}

	self linkto(param_00);
	param_00 maps\_anim::anim_single_solo(self,var_03);
	param_00 thread maps\_anim::anim_loop_solo(self,var_04,param_01);
	if(self == level.joker)
	{
		if(level.currentgen)
		{
			level waittill("tff_post_transition_middle_to_outro");
		}
		else
		{
			wait(5.5);
		}
	}
	else if(level.currentgen)
	{
		level waittill("tff_post_transition_middle_to_outro");
	}
	else
	{
		level waittill("turbine_elevator_reached_top");
	}

	self unlink();
	param_00 notify(param_01);
	param_00 thread maps\_anim::anim_single_solo_run(self,var_05);
	maps\_utility::disable_surprise();
	maps\_utility::disable_bulletwhizbyreaction();
	wait(10);
	maps\_utility::enable_surprise();
	maps\_utility::enable_bulletwhizbyreaction();
}

//Function Number: 288
turbine_room_combat()
{
	common_scripts\utility::flag_wait("player_in_turbine_room");
	level.burke maps\_utility::enable_careful();
	level.joker maps\_utility::enable_careful();
	level.carter maps\_utility::enable_careful();
	level.turbine_room_goal_volume = getent("turbine_room_initial_goal","script_noteworthy");
	common_scripts\utility::array_thread(getentarray("turbine_room_goal_volume_trigger","targetname"),::turbine_room_goal_volume_trigger_think);
	common_scripts\utility::flag_wait("turbine_room_combat_start");
	level.burke maps\_utility::enable_ai_color();
	level.joker maps\_utility::enable_ai_color();
	level.carter maps\_utility::enable_ai_color();
	thread turbine_room_combat_initial();
	thread turbine_room_combat_seek_player();
	common_scripts\utility::flag_wait("turbine_room_stop_combat");
	foreach(var_01 in getaiarray("axis"))
	{
		var_01 thread maps\fusion_utility::bloody_death(randomfloatrange(0,3));
	}
}

//Function Number: 289
turbine_combat_mid_checkpoint_1()
{
	level endon("turbine_room_stop_combat");
	common_scripts\utility::flag_wait("flag_turbine_combat_mid_save_1");
	maps\_utility::autosave_by_name();
}

//Function Number: 290
turbine_room_combat_initial()
{
	thread turbine_room_squibs();
	var_00 = getaiarray("axis");
	foreach(var_02 in var_00)
	{
		if(randomfloat(1) < 0.25)
		{
			var_02.favoriteenemy = level.player;
		}
	}

	wait(5);
	common_scripts\utility::flag_set("turbine_room_initial_combat_retreat");
}

//Function Number: 291
turbine_room_combat_seek_player()
{
	common_scripts\utility::flag_wait("flag_turbine_room_combat_seek_player");
	level.burke maps\_utility::disable_careful();
	level.joker maps\_utility::disable_careful();
	level.carter maps\_utility::disable_careful();
	var_00 = getaiarray("axis");
	foreach(var_02 in var_00)
	{
		var_02 thread maps\_utility::player_seek_enable();
	}
}

//Function Number: 292
turbine_room_squibs()
{
	level endon("turbine_room_initial_combat_retreat");
	var_00 = common_scripts\utility::getstructarray("turbine_room_squib_source","targetname");
	var_01 = common_scripts\utility::getstructarray("turbine_room_squib_dest","targetname");
	wait(1);
	for(;;)
	{
		var_02 = randomintrange(1,var_00.size);
		for(var_03 = 0;var_03 < var_02;var_03++)
		{
			var_04 = var_00[randomint(var_00.size)];
			var_05 = var_01[randomint(var_01.size)];
			magicbullet("iw5_ak12_sp",var_04.origin,var_05.origin);
			wait(randomfloat(0.2));
		}

		wait(randomfloat(0.2));
	}
}

//Function Number: 293
turbine_room_goal_volume_trigger_think()
{
	var_00 = common_scripts\utility::get_target_ent();
	level endon("turbine_room_stop_combat");
	for(;;)
	{
		self waittill("trigger");
		if(var_00 != level.turbine_room_goal_volume)
		{
			level.turbine_room_goal_volume = var_00;
			level notify("turbine_room_update_goal");
		}

		wait(0.5);
	}
}

//Function Number: 294
turbine_room_enemy_think()
{
	self endon("death");
	while(!isdefined(level.turbine_room_goal_volume))
	{
		wait(1);
	}

	for(;;)
	{
		level waittill("turbine_room_update_goal");
		self setgoalvolumeauto(level.turbine_room_goal_volume);
		wait(1);
	}
}

//Function Number: 295
turbine_room_turbines()
{
	common_scripts\utility::flag_wait("elevator_ascend");
	common_scripts\utility::array_thread(getentarray("turbine_fan","targetname"),::turbine_fan_think);
}

//Function Number: 296
turbine_fan_think()
{
	var_00 = 10;
	var_01 = 360;
	if(isdefined(self.script_parameters))
	{
		if(self.script_parameters == "ccw")
		{
			var_01 = -1 * var_01;
		}
	}

	for(;;)
	{
		self rotateroll(var_01 * var_00,var_00,0,0);
		wait(var_00);
	}
}

//Function Number: 297
turbine_room_entrance_steam()
{
	common_scripts\utility::flag_wait("turbine_room_entrance_steam");
	common_scripts\_exploder::exploder("turbine_looping_steam_fx");
}

//Function Number: 298
turbine_room_pre_explosion()
{
	common_scripts\utility::flag_wait("turbine_room_pre_explosion");
	maps\_utility::pauseexploder("turbine_looping_steam_fx");
	wait(2.2);
	common_scripts\_exploder::exploder("turbine_room_spark_steam");
	soundscripts\_snd::snd_message("turbine_pre_explo");
	wait(0.4);
	common_scripts\_exploder::exploder("turbine_room_spark_steam_2");
	common_scripts\_exploder::exploder("turbine_looping_steam_fx_2");
	common_scripts\_exploder::exploder("turbine_looping_steam_fx");
}

//Function Number: 299
turbine_room_explosion()
{
	var_00 = getent("turbine_explosion_volume","targetname");
	badplace_brush("turbine_explosion_volume",0,var_00,"allies");
	var_01 = getentarray("turbine_damaged","targetname");
	common_scripts\utility::array_call(var_01,::hide);
	var_02 = getentarray("turbine_fan_damaged","targetname");
	common_scripts\utility::array_call(var_02,::hide);
	common_scripts\utility::flag_wait("turbine_room_explosion");
	soundscripts\_snd::snd_message("turbine_explo_audio");
	wait(0.2);
	var_03 = common_scripts\utility::getstructarray("turbine_explosion_damage_source","targetname");
	foreach(var_05 in var_03)
	{
		radiusdamage(var_05.origin,var_05.radius,200,100);
	}

	maps\_utility::pauseexploder("turbine_looping_steam_fx");
	maps\_utility::pauseexploder("turbine_looping_steam_fx_2");
	common_scripts\_exploder::exploder("turbine_explosion_fx");
	var_07 = getent("turbine_explosion_catwalk_source","targetname");
	var_07 playsound("detpack_explo_metal");
	earthquake(0.5,0.5,var_07.origin,3000);
	badplace_delete("turbine_explosion_volume");
	badplace_brush("turbine_explosion_volume",0,var_00,"axis","allies");
	var_08 = getentarray("turbine_intact","targetname");
	common_scripts\utility::array_call(var_08,::delete);
	common_scripts\utility::array_call(var_01,::show);
	common_scripts\utility::array_call(var_02,::show);
	common_scripts\utility::array_thread(var_02,::turbine_fan_think);
	wait(1.5);
	common_scripts\_exploder::exploder("turbine_explosion_steam_fx");
	common_scripts\_exploder::exploder("turbine_damage_sparks");
	common_scripts\utility::flag_set("vo_turbine_explosion");
	soundscripts\_snd::snd_message("start_pa_emergency_turbine");
	if(level.currentgen)
	{
		level waittill("notify_out_of_control_room");
		maps\_utility::stop_exploder("turbine_explosion_fx");
	}
}

//Function Number: 300
turbine_room_explosion_flying_blades()
{
	var_00 = common_scripts\utility::getstructarray("turbine_blade_flying_start","targetname");
	foreach(var_02 in var_00)
	{
		thread turbine_room_explosion_launch_blade(var_02);
	}
}

//Function Number: 301
turbine_room_explosion_launch_blade(param_00)
{
	if(isdefined(param_00.script_delay))
	{
		wait(param_00.script_delay);
	}

	var_01 = common_scripts\utility::getstruct(param_00.target,"targetname");
	var_02 = distance(param_00.origin,var_01.origin);
	var_03 = 3000;
	var_04 = var_02 / var_03;
	var_05 = spawn("script_model",param_00.origin);
	var_05 setmodel("vehicle_v22_osprey_damaged_static_bladepiece_left");
	var_05.angles = param_00.angles;
	var_05 moveto(var_01.origin,var_04,0,0);
	var_05 rotatepitch(1080,var_04,0,0);
	wait(var_04);
	var_05.angles = var_01.angles;
	var_05 thread maps\fusion_utility::delete_on_notify("turbine_room_cleanup");
}

//Function Number: 302
turbine_room_atmosphere()
{
	level endon("flag_shut_down_reactor_failed");
	level.player endon("death");
	var_00 = common_scripts\utility::getstructarray("turbine_center","script_noteworthy");
	var_01 = 0.07;
	var_02 = 0.12;
	var_03 = var_02 - var_01;
	var_04 = 0.08;
	var_05 = 0.12;
	var_06 = var_05 - var_04;
	for(;;)
	{
		common_scripts\utility::flag_wait("player_in_turbine_room");
		var_07 = maps\_utility::get_rumble_ent("steady_rumble");
		var_07.intensity = 0.08;
		var_08 = 1;
		while(common_scripts\utility::flag("player_in_turbine_room"))
		{
			var_09 = common_scripts\utility::getclosest(level.player.origin,var_00);
			var_0A = get_turbine_shake_value(var_09);
			var_07.intensity = var_01 + var_0A * var_03;
			earthquake(var_04 + var_0A * var_06,var_08,level.player.origin,1000);
			wait(randomfloatrange(var_08 / 4,var_08 / 2));
		}

		stopallrumbles();
	}
}

//Function Number: 303
get_turbine_shake_value(param_00)
{
	var_01 = 300;
	var_02 = 600;
	var_03 = var_02 - var_01;
	var_04 = distance(level.player.origin,param_00.origin);
	if(var_04 < var_01)
	{
		return 1;
	}

	if(var_04 > var_02)
	{
		return 0;
	}

	return 1 - var_04 - var_01 / var_03;
}

//Function Number: 304
turbine_room_steam_player()
{
	level endon("flag_shut_down_reactor_failed");
	while(common_scripts\utility::flag("player_in_turbine_room"))
	{
		playfx(common_scripts\utility::getfx("steam_player"),level.player.origin + (0,0,0));
		wait(0.3);
	}
}

//Function Number: 305
control_room()
{
	thread control_room_run();
	thread control_room_explosion();
}

//Function Number: 306
control_room_run()
{
	common_scripts\utility::flag_wait("control_room_run_prep");
	var_00 = getent("clip_explosion_door","targetname");
	var_00 hide();
	var_01 = common_scripts\utility::getstruct("control_room_burke_position","targetname");
	var_02 = "fusion_door_explosion";
	var_03 = getent("fusion_door_open_postup_doors","targetname");
	var_03.animname = "fusion_door_open_postup_doors";
	var_03 maps\_anim::setanimtree();
	var_01 maps\_anim::anim_first_frame_solo(var_03,var_02);
	var_04 = getent("fusion_door_open_postup_door_left","targetname");
	var_04 linkto(var_03,"door_R");
	var_05 = getent("fusion_door_open_postup_door_right","targetname");
	var_05 linkto(var_03,"door_L");
	common_scripts\utility::flag_wait("control_room_run_approach");
	var_06 = getaiarray("axis");
	var_06 = maps\_utility::array_removedead_or_dying(var_06);
	while(var_06.size >= 4)
	{
		var_06 = getaiarray("axis");
		var_06 = maps\_utility::array_removedead_or_dying(var_06);
		wait 0.05;
	}

	var_06 = getaiarray("axis");
	var_06 = maps\_utility::array_removedead_or_dying(var_06);
	foreach(var_08 in var_06)
	{
		maps\fusion_utility::bloody_death(randomfloatrange(1,2));
	}

	level.burke maps\_utility::disable_careful();
	level.joker maps\_utility::disable_careful();
	level.carter maps\_utility::disable_careful();
	wait 0.05;
	var_0A = [];
	var_0A[var_0A.size] = level.burke;
	var_0A[var_0A.size] = level.carter;
	var_0B = "fusion_door_explosion_postup";
	var_0C = "fusion_door_explosion_postup_loop";
	var_0D = spawn("script_origin",var_01.origin);
	var_0D.angles = var_01.angles;
	var_0E = "control_room_run";
	level.burke thread start_cqb_when_near(getstartorigin(var_0D.origin,var_0D.angles,level.scr_anim["burke"][var_0B]));
	level.carter thread start_cqb_when_near(getstartorigin(var_0D.origin,var_0D.angles,level.scr_anim["carter"][var_0B]));
	var_0A = [];
	var_0A[var_0A.size] = level.burke;
	var_0A[var_0A.size] = level.carter;
	common_scripts\utility::array_thread(var_0A,::control_room_run_approach,var_0D,var_0B,var_0C,var_0E);
	level waittill("control_room_run_guy_ready");
	level waittill("control_room_run_guy_ready");
	common_scripts\utility::flag_wait("control_room_run");
	thread control_room_run_player();
	thread control_room_screens();
	level.burke maps\_utility::disable_cqbwalk();
	level.carter maps\_utility::disable_cqbwalk();
	var_0D notify("control_room_run");
	thread control_room_run_joker();
	maps\_utility::delaythread(2.5,::common_scripts\utility::flag_set,"update_obj_pos_control_room_door");
	var_0A[var_0A.size] = var_03;
	common_scripts\utility::array_call(getentarray("control_room_doors","targetname"),::delete);
	var_0F = maps\_utility::spawn_anim_model("fusion_door_explosion_door_a",(0,0,0));
	var_10 = [];
	var_10[var_10.size] = var_0F;
	soundscripts\_snd::snd_message("start_turbine_door_breach");
	soundscripts\_snd::snd_message("start_turbine_door_impt",var_04,var_05);
	thread control_room_scene_player(var_01);
	maps\_utility::delaythread(5,::common_scripts\utility::flag_set,"vo_control_hall_door_stack");
	maps\_utility::delaythread(6,::common_scripts\utility::flag_set,"vo_control_hall_door_kicked");
	var_0A[var_0A.size] = var_0F;
	var_11 = getanimlength(level.burke maps\_utility::getanim(var_02));
	var_01 thread maps\_anim::anim_single(var_0A,var_02);
	var_12 = 24;
	maps\_utility::delaythread(var_12,::control_room_scene,var_11 - var_12);
	wait(var_11);
	var_00 show();
	var_0D delete();
}

//Function Number: 307
control_room_run_approach(param_00,param_01,param_02,param_03)
{
	param_00 maps\_anim::anim_reach_solo(self,param_01);
	param_00 maps\_anim::anim_single_solo(self,param_01);
	param_00 thread maps\_anim::anim_loop_solo(self,param_02,param_03);
	level notify("control_room_run_guy_ready");
}

//Function Number: 308
control_room_run_player()
{
	var_00 = common_scripts\utility::getstruct("control_room_door_explosion_dmg_org","targetname");
	var_01 = var_00.radius;
	common_scripts\utility::flag_wait("control_room_explosion");
	playrumbleonposition("grenade_rumble",var_00.origin);
	var_02 = getent("control_room_door_clip","targetname");
	if(isdefined(var_02))
	{
		var_02 delete();
	}

	var_03 = distance2d(var_00.origin,level.player.origin);
	if(var_03 < var_01)
	{
		var_04 = level.player.health * 0.9 / level.player.damagemultiplier;
		var_05 = var_01 - var_03 / var_01 * var_04;
		level.player dodamage(var_05,var_00.origin);
		var_06 = common_scripts\utility::getstructarray("control_room_door_explosion_dmg_dest","targetname");
		var_07 = [];
		foreach(var_09 in var_06)
		{
			var_07[var_07.size] = length(vectorfromlinetopoint(var_00.origin,var_09.origin,level.player.origin));
		}

		var_0B = 0;
		var_0C = 1000;
		for(var_0D = 0;var_0D < var_07.size;var_0D++)
		{
			if(var_07[var_0D] < var_0C)
			{
				var_0B = var_0D;
				var_0C = var_07[var_0D];
			}
		}

		var_0E = var_06[var_0B];
		var_0F = common_scripts\utility::spawn_tag_origin();
		var_0F.origin = level.player.origin;
		var_0F.angles = level.player.angles;
		var_10 = 0.5;
		level.player playerlinktoblend(var_0F,"tag_origin",var_10);
		var_0F moveto(var_0E.origin,var_10,0.05,0.05);
		var_11 = common_scripts\utility::getstruct("control_room_door_explosion_view_org","targetname");
		var_0F rotateto((0,vectortoangles(var_11.origin - var_0E.origin)[1],0),var_10,0.05,0.05);
		level.player playrumbleonentity("damage_heavy");
		wait(var_10);
		level.player unlink();
		var_0F delete();
		return;
	}

	level.player playrumbleonentity("damage_light");
}

//Function Number: 309
control_room_run_joker()
{
	wait(6);
	getent("fusion_door_open_postup_door_left","targetname") connectpaths();
	getent("fusion_door_open_postup_door_right","targetname") connectpaths();
	wait(1);
	var_00 = getnode("pre_control_room_joker_position","targetname");
	var_01 = level.joker.goalradius;
	level.joker.goalradius = 64;
	level.joker maps\_utility::enable_cqbwalk();
	level.joker setgoalnode(var_00);
	level.joker waittill("goal");
	level.joker allowedstances("crouch");
	maps\_utility::trigger_wait_targetname("cover_allies_complete");
	wait(1);
	var_02 = common_scripts\utility::getstruct("control_room_joker_position","targetname");
	var_01 = level.joker.goalradius;
	level.joker.goalradius = 64;
	level.joker maps\_utility::enable_cqbwalk();
	level.joker setgoalpos(var_02.origin);
	level.joker waittill("goal");
	level.joker allowedstances("crouch");
	level waittill("control_room_scene_complete");
	level.joker allowedstances("prone","crouch","stand");
	level.joker maps\_utility::disable_cqbwalk();
	level.joker.goalradius = var_01;
}

//Function Number: 310
control_room_explosion()
{
	var_00 = getentarray("control_room_hall_intact","targetname");
	var_01 = getentarray("control_room_hall_destroyed","targetname");
	foreach(var_03 in var_01)
	{
		var_03 hide();
	}

	level waittill("doors_explode");
	foreach(var_03 in var_01)
	{
		var_03 show();
	}

	foreach(var_03 in var_00)
	{
		var_03 delete();
	}

	common_scripts\utility::flag_set("control_room_explosion");
	common_scripts\utility::flag_set("update_obj_pos_control_room_explosion");
	common_scripts\utility::flag_set("vo_control_room_explosion");
	level thread maps\fusion_fx::vfx_control_room_explo();
	soundscripts\_snd::snd_message("start_control_room_explo");
}

//Function Number: 311
control_room_scene_player(param_00)
{
	common_scripts\utility::flag_wait("control_room_console_enable");
	var_01 = getent("control_room_console_use_trigger","targetname");
	var_02 = common_scripts\utility::getstruct("obj_pos_control_room_console","targetname");
	if(level.player usinggamepad())
	{
		var_01 sethintstring(&"FUSION_USE_CONSOLE");
	}
	else
	{
		var_01 sethintstring(&"FUSION_USE_CONSOLE_PC");
	}

	var_03 = var_01 maps\_shg_utility::hint_button_trigger("use");
	common_scripts\utility::flag_wait("control_room_console_used");
	level.burke thread maps\fusion_utility::hide_friendname_until_flag_or_notify("control_room_scene_complete");
	level.joker thread maps\fusion_utility::hide_friendname_until_flag_or_notify("control_room_scene_complete");
	level.carter thread maps\fusion_utility::hide_friendname_until_flag_or_notify("control_room_scene_complete");
	var_01 delete();
	var_03 maps\fusion_utility::hint_button_clear_fus();
	common_scripts\utility::flag_set("update_obj_pos_control_room_using_console");
	var_04 = getdvarint("cg_fov");
	var_05 = maps\_utility::spawn_anim_model("player_rig",level.player.origin);
	var_05 hide();
	param_00 thread maps\_anim::anim_first_frame_solo(var_05,"control_room_scene");
	level.player disableweapons();
	maps\_player_exo::player_exo_deactivate();
	var_06 = 1;
	level.player playerlinktoblend(var_05,"tag_player",var_06);
	thread maps\fusion_anim::fov_lerp_to_50_blendtime(level.player,var_06);
	var_05 common_scripts\utility::delaycall(var_06,::show);
	level.player common_scripts\utility::delaycall(var_06,::playerlinktodelta,var_05,"tag_player",0,30,30,30,30);
	level.player allowcrouch(0);
	level.player allowprone(0);
	level.player disableweapons();
	level.player maps\_utility::blend_movespeedscale_percent(0);
	wait(var_06);
	common_scripts\utility::flag_wait("control_room_scene_ready");
	common_scripts\utility::flag_set("control_room_scene");
	level.player playerlinktodelta(var_05,"tag_player",0,60,60,70,65);
	param_00 thread maps\_anim::anim_single_solo(var_05,"control_room_scene");
	var_07 = getanimlength(var_05 maps\_utility::getanim("control_room_scene"));
	wait(var_07 - 1);
	level.player allowcrouch(1);
	level.player allowprone(1);
	level.player enableweapons();
	maps\_player_exo::player_exo_activate();
	wait(1);
	var_05 delete();
	level.player unlink();
	level.player maps\_utility::blend_movespeedscale_percent(100,1);
	thread maps\fusion_anim::fov_reset_previous(level.player,var_04);
}

//Function Number: 312
control_room_scene(param_00)
{
	common_scripts\utility::flag_set("control_room_scene_ready");
	thread control_room_scene_actors(param_00);
	level waittill("control_room_event_1");
	thread maps\fusion_aud::do_inside_bombshake();
	level waittill("control_room_event_2");
	thread maps\fusion_aud::do_inside_bombshake();
	level waittill("control_room_event_3");
	thread maps\fusion_aud::do_inside_bombshake();
}

//Function Number: 313
control_room_scene_actors(param_00)
{
	var_01 = common_scripts\utility::getstruct("control_room_burke_position","targetname");
	var_02 = spawn("script_origin",var_01.origin);
	var_02.angles = var_01.angles;
	var_03 = spawn("script_origin",var_01.origin);
	var_03.angles = var_01.angles;
	var_04 = spawn("script_origin",var_01.origin);
	var_04.angles = var_01.angles;
	var_05 = "control_room_idle";
	var_06 = [];
	var_06[var_06.size] = level.burke;
	var_06[var_06.size] = level.carter;
	if(isdefined(param_00))
	{
		common_scripts\utility::flag_wait_or_timeout("control_room_scene",param_00);
	}

	var_02 thread maps\_anim::anim_loop_solo(level.burke,var_05,"control_room_scene");
	var_04 thread maps\_anim::anim_loop_solo(level.carter,var_05,"control_room_scene");
	var_05 = "control_room_scene";
	var_06[var_06.size] = level.joker;
	common_scripts\utility::flag_wait("control_room_scene");
	level notify("turbine_room_cleanup");
	var_02 notify("control_room_scene");
	var_04 notify("control_room_scene");
	var_04 delete();
	maps\_utility::clear_all_color_orders("allies");
	level.burke maps\_utility::enable_ai_color();
	level.joker maps\_utility::enable_ai_color();
	level.carter maps\_utility::enable_ai_color();
	level.joker maps\_utility::set_force_color("o");
	level.carter maps\_utility::set_force_color("o");
	maps\_utility::delaythread(1,::maps\_utility::activate_trigger_with_targetname,"control_room_scene_complete_color_trigger");
	common_scripts\utility::flag_set("vo_control_room_scene");
	var_02 maps\_anim::anim_single_run(var_06,var_05);
	var_02 delete();
	common_scripts\utility::flag_set("flag_shut_down_reactor_failed");
	common_scripts\utility::flag_set("evacuation_started");
	common_scripts\utility::flag_set("update_obj_pos_control_room_exit_1");
	control_room_scene_exit();
}

//Function Number: 314
control_room_screens()
{
	level notify("stop_evacuation_kiosk_movie");
	setsaveddvar("cg_cinematicFullScreen","0");
	cinematicingameloop("fusion_control_room_loop");
	common_scripts\utility::flag_wait("control_room_scene");
	wait(12);
	cinematicingameloop("fusion_control_room_loop_red");
	common_scripts\utility::flag_wait("evacuation_started");
	if(level.nextgen)
	{
		thread evacuation_kiosk_movie();
	}
}

//Function Number: 315
control_room_scene_exit()
{
	wait(0.45);
	var_00 = getent("control_room_exit_door","targetname");
	getent(var_00.target,"targetname") linkto(var_00);
	var_01 = 0.5;
	var_00 rotateto(var_00.angles - (0,120,0),var_01,0,0);
	wait(var_01 + 0.05);
	var_00 rotateto(var_00.angles - (0,-10,0),1,0,1);
	common_scripts\utility::flag_wait("raise_control_room_emergency_exit_door");
	common_scripts\utility::flag_set("update_obj_pos_control_room_exit_2");
}

//Function Number: 316
scene_control_room_ai()
{
	maps\_utility::disable_surprise();
	maps\_utility::disable_bulletwhizbyreaction();
	maps\_utility::disable_pain();
	level waittill("control_room_scene_complete");
	maps\_utility::enable_surprise();
	maps\_utility::enable_bulletwhizbyreaction();
	maps\_utility::enable_pain();
}

//Function Number: 317
scene_control_room_fade_up()
{
	if(!isdefined(level.overlay))
	{
		level.overlay = maps\_hud_util::create_client_overlay("black",1,level.player);
		level.overlay.sort = -1;
		level.overlay.foreground = 1;
		level.overlay.color = (0,0,0);
	}

	wait(1);
	var_00 = 1;
	level.overlay fadeovertime(var_00);
	level.overlay.alpha = 0;
	wait(var_00);
	level.overlay destroy();
}

//Function Number: 318
evacuation_setup()
{
	common_scripts\utility::flag_wait("evacuation_started");
	thread evacuation_corpses();
}

//Function Number: 319
dialog_meltdown()
{
	thread dialog_collapse();
	level endon("collapse_start");
	common_scripts\utility::flag_wait("hangar_enemies");
	level.joker maps\fusion_vo::dialogue_queue_global("fus_jkr_gideontangosarebailinout");
	level.burke maps\fusion_vo::dialogue_queue_global("fus_gdn_soarewekeepmoving");
	common_scripts\utility::flag_wait("hangar_combat_retreat");
	level.carter maps\fusion_vo::dialogue_queue_global("fus_ctr_jokerwhatsyourgeigerreading");
	level.joker maps\fusion_vo::dialogue_queue_global("fus_jkr_weregoodjustkeepshooting");
	common_scripts\utility::flag_wait("hangar_combat_retreat_02");
	level.burke maps\fusion_vo::dialogue_queue_global("fus_gdn_prophetwevegotkvaextraction");
	maps\fusion_vo::radio_dialogue_queue_global("fus_prt_affirmativebravoone");
	common_scripts\utility::flag_wait("hangar_exit_retreat");
	level.burke maps\fusion_vo::dialogue_queue_global("fus_gdn_wraithtwothreeweneedimmediate");
	maps\fusion_vo::radio_dialogue_queue_global("fus_ch1_copybravooneinboundinthirty");
	maps\fusion_vo::radio_dialogue_queue_global("fus_prt_bravopressurereadingsarecritical");
	soundscripts\_snd::snd_music_message("mus_fusion_pressure_readings_critical");
	level.joker maps\fusion_vo::dialogue_queue_global("fus_jkr_youheardtheman");
	common_scripts\utility::flag_wait("reaction_explo01a");
	wait(0.75);
	level.joker maps\fusion_vo::dialogue_queue_global("fus_jkr_goddamn2");
	level.carter maps\fusion_vo::dialogue_queue_global("fus_ctr_whatthehellwasthat");
	level.burke maps\fusion_vo::dialogue_queue_global("fus_gdn_pressureexplosions");
	common_scripts\utility::flag_wait("ct_combat_retreat");
	wait(2);
	common_scripts\utility::flag_wait("reaction_explo01");
	wait(2);
	if(level.nextgen)
	{
		maps\fusion_vo::radio_dialogue_queue_global("fus_ch1_bravothisiswraithtwothree");
		level.burke maps\fusion_vo::dialogue_queue_global("fus_gdn_youreadamnwelcomesight");
	}

	common_scripts\utility::flag_wait("reaction_explo02");
	wait(4);
	common_scripts\utility::flag_set("extraction_chopper_move_from_explosion");
	maps\fusion_vo::radio_dialogue_queue_global("fus_ch1_bravowecantgetnear");
	level.burke maps\fusion_vo::dialogue_queue_global("fus_gdn_copythattwothree");
	level.joker maps\fusion_vo::dialogue_queue_global("fus_jkr_comeon");
	level.carter maps\fusion_vo::dialogue_queue_global("fus_ctr_gogo");
	common_scripts\utility::flag_wait("ct_final_retreat");
	level.joker maps\fusion_vo::dialogue_queue_global("fus_jkr_theresourexfil");
}

//Function Number: 320
dialog_monitor_drones_down()
{
	common_scripts\utility::flag_wait("evacuation_first_drones_down");
	if(!common_scripts\utility::flag("reaction_explo01") && !common_scripts\utility::flag("collapse_start"))
	{
		level.joker maps\fusion_vo::dialogue_queue_global("fus_jkr_dronesaredown");
	}
}

//Function Number: 321
dialog_collapse()
{
	common_scripts\utility::flag_wait("tower_debris");
}

//Function Number: 322
outro_newscast()
{
}

//Function Number: 323
combat_hangar()
{
	var_00 = getentarray("hangar_enemies_01","targetname");
	var_01 = getentarray("ct_enemies_01","targetname");
	var_02 = getentarray("hangar_runaway","targetname");
	var_03 = getentarray("hangar_runaway_02","targetname");
	common_scripts\utility::array_thread(var_00,::maps\_utility::add_spawn_function,::maps\_utility::disable_long_death);
	common_scripts\utility::array_thread(var_01,::maps\_utility::add_spawn_function,::maps\_utility::disable_long_death);
	common_scripts\utility::array_thread(var_02,::maps\_utility::add_spawn_function,::maps\_utility::disable_long_death);
	common_scripts\utility::array_thread(var_03,::maps\_utility::add_spawn_function,::maps\_utility::disable_long_death);
	level.hangar_enemies = [];
	common_scripts\utility::flag_wait("hangar_combat_start");
	if(level.currentgen)
	{
		var_04 = ["hanger_enemies"];
		thread maps\_cg_encounter_perf_monitor::cg_spawn_perf_monitor("collapse_start",var_04,12,0);
	}

	var_05 = maps\_utility::array_spawn(var_02,1,1);
	common_scripts\utility::array_thread(var_05,::runaway_guy_delete);
	common_scripts\utility::flag_wait("hangar_enemies");
	level.carter.dontmelee = 1;
	level.joker.dontmelee = 1;
	maps\_spawner::flood_spawner_scripted(var_00);
	common_scripts\utility::flag_wait("hangar_combat_retreat");
	level.carter.dontmelee = undefined;
	level.joker.dontmelee = undefined;
	common_scripts\utility::flag_set("hangar_retreat_done");
	common_scripts\utility::array_thread(level.hangar_enemies,::enemy_run_away,"vol_final_runaway",1);
	common_scripts\utility::flag_wait("hangar_combat_retreat_02");
	level.ct_enemies = maps\_utility::array_spawn(var_01,1,1);
	var_06 = maps\_utility::array_spawn(var_03,1,1);
	common_scripts\utility::array_thread(level.ct_enemies,::maps\_utility::flagwaitthread,"reaction_explo01a",::enemy_run_away,"vol_ct_02",0);
	common_scripts\utility::flag_wait("ct_combat_retreat");
	common_scripts\utility::flag_wait("reaction_explo01");
	maps\_utility::autosave_by_name();
	if(level.nextgen)
	{
		var_07 = getentarray("ct_runaway_drones","targetname");
		common_scripts\utility::array_thread(var_07,::runaway_drone_think);
	}

	var_08 = getentarray("final_collapse_enemies","targetname");
	maps\_utility::flood_spawn(var_08);
	common_scripts\utility::flag_wait("ct_final_retreat");
	common_scripts\utility::array_thread(var_08,::maps\_spawner::flood_spawner_stop);
}

//Function Number: 324
extraction_chopper()
{
	common_scripts\utility::flag_wait("reaction_explo01");
	if(level.nextgen)
	{
		level.extraction_chopper = maps\_vehicle::spawn_vehicle_from_targetname_and_drive("ct_extraction_chopper");
		level.extraction_chopper soundscripts\_snd::snd_message("extraction_chopper_spawn");
		level.extraction_chopper thread warbird_shooting_think();
		level.extraction_chopper setmaxpitchroll(20,60);
		level.extraction_chopper maps\_vehicle::vehicle_lights_on("running");
		level.extraction_chopper vehicle_turnengineoff();
	}

	wait(2);
	if(level.nextgen)
	{
		level.extraction_chopper notify("warbird_fire");
	}

	wait(8);
	common_scripts\utility::flag_set("objective_on_extraction_chopper");
	if(level.nextgen)
	{
		level.extraction_chopper setgoalyaw(330);
		level.extraction_chopper sethoverparams(50,50,25);
		common_scripts\utility::flag_wait("extraction_chopper_move_from_explosion");
		level.extraction_chopper notify("warbird_stop_firing");
		level.extraction_chopper soundscripts\_snd::snd_message("extraction_chopper_move");
		level.extraction_chopper cleargoalyaw();
		level.extraction_chopper maps\_vehicle::vehicle_paths(common_scripts\utility::getstruct("extraction_chopper_move_from_explosion","targetname"));
	}
}

//Function Number: 325
extraction_chopper_collapse()
{
	common_scripts\utility::flag_wait("tower_debris");
	wait(5);
	var_00 = common_scripts\utility::getstruct("extraction_chopper_final_path","targetname");
	if(!isdefined(level.extraction_chopper))
	{
		level.extraction_chopper = maps\_vehicle::spawn_vehicle_from_targetname("ct_extraction_chopper");
		level.extraction_chopper vehicle_turnengineoff();
	}

	level.extraction_chopper vehicle_setspeedimmediate(0);
	level.extraction_chopper vehicle_teleport(var_00.origin,var_00.angles);
	level.extraction_chopper maps\_vehicle::vehicle_paths(var_00);
}

//Function Number: 326
enemy_run_away(param_00,param_01)
{
	if(!isdefined(self))
	{
		return;
	}

	if(distance(self.origin,level.player.origin) <= 600)
	{
		return;
	}

	self notify("enemy_run_away");
	self endon("enemy_run_away");
	self endon("death");
	self.ignoreall = 1;
	var_02 = getent(param_00,"targetname");
	self cleargoalvolume();
	self setgoalvolumeauto(var_02);
	if(isdefined(param_01) && param_01)
	{
		thread enemy_delete_at_goal();
	}

	var_03 = 10000;
	for(;;)
	{
		common_scripts\utility::waittill_any("damage","bad_path");
		level notify("ct_enemies_runaway_damage");
	}
}

//Function Number: 327
enemy_delete_at_goal()
{
	self notify("enemy_delete_at_goal");
	self endon("enemy_delete_at_goal");
	self endon("death");
	self waittill("goal");
	if(isdefined(self) && isalive(self))
	{
		self delete();
	}
}

//Function Number: 328
hangar_enemy_think()
{
	level.hangar_enemies[level.hangar_enemies.size] = self;
	self cleargoalvolume();
	if(!common_scripts\utility::flag("hangar_retreat_done"))
	{
		self setgoalvolumeauto(getent("vol_enemy_hangar","targetname"));
		return;
	}

	self setgoalvolumeauto(getent("vol_ct_01","targetname"));
}

//Function Number: 329
runaway_guy_delete()
{
	self endon("death");
	self waittill("goal");
	if(isdefined(self) && isalive(self))
	{
		self delete();
	}
}

//Function Number: 330
runaway_drone_think()
{
	var_00 = maps\_utility::spawn_ai(1);
	var_00 thread runaway_guy_delete();
	var_00 endon("death");
	common_scripts\utility::flag_wait("collapse_start");
	var_00 kill();
}

//Function Number: 331
add_drone_to_squad()
{
	if(isdefined(self.script_parameters) && self.script_parameters == "personal_drone")
	{
		var_00 = getent("squad_drone_spawner","targetname");
		maps\_weapon_pdrone::pdrone_launch(var_00);
		if(isdefined(self.pdrone))
		{
			self.pdrone setthreatbiasgroup("drones");
			self.pdrone thread cleanup_squad_drone();
		}
	}
}

//Function Number: 332
cleanup_squad_drone()
{
	if(level.nextgen)
	{
		level waittill("street_cleanup");
	}
	else
	{
		level waittill("tff_pre_transition_intro_to_middle");
	}

	self delete();
}

//Function Number: 333
reaction_explosions()
{
	if(level.currentgen)
	{
		common_scripts\utility::flag_wait("hangar_enemies");
	}

	var_00 = getentarray("pressure_explosion_1_before","targetname");
	var_01 = getentarray("pressure_explosion_1_after","targetname");
	var_02 = getentarray("pressure_explosion_2_before","targetname");
	var_03 = getentarray("pressure_explosion_2_after","targetname");
	common_scripts\utility::array_call(var_01,::hide);
	common_scripts\utility::array_call(var_01,::notsolid);
	common_scripts\utility::array_call(var_03,::hide);
	common_scripts\utility::array_call(var_03,::notsolid);
	var_04 = getent("explosion_cart","targetname");
	var_04.animname = "cart";
	var_04 maps\_anim::setanimtree();
	var_05 = getent("fusion_utility_cart_collision","targetname");
	var_05 linkto(var_04,"TAG_ORIGIN");
	var_06 = getent("org_reaction_pickup_event","targetname");
	var_07 = "fusion_utility_cart_explode_cart";
	thread reaction_pickup_event();
	if(level.nextgen)
	{
		common_scripts\utility::flag_wait("hangar_enemies");
	}

	wait(1.5);
	common_scripts\utility::flag_wait("reaction_explo01a");
	common_scripts\utility::array_call(var_00,::delete);
	common_scripts\utility::array_call(var_01,::show);
	common_scripts\utility::array_call(var_01,::solid);
	thread pressure_explosion_damage(1);
	level thread maps\fusion_fx::big_pipe_explosion_vfx_after_hangar();
	wait(0.5);
	common_scripts\utility::flag_wait("reaction_explo01");
	wait(0.5);
	common_scripts\utility::array_call(var_02,::delete);
	common_scripts\utility::array_call(var_03,::show);
	common_scripts\utility::array_call(var_03,::solid);
	thread pressure_explosion_damage(2);
	var_04 setmodel("vehicle_ind_utility_tractor_01_dstrypv");
	var_06 thread maps\_anim::anim_single_solo(var_04,var_07);
	thread explosion_cart_kill_trigger();
	var_04 thread maps\fusion_fx::underground_pipe_explosion_utility_truck_vfx();
	var_06 waittill(var_07);
	var_05 disconnectpaths();
}

//Function Number: 334
explosion_cart_kill_trigger()
{
	wait(0.75);
	var_00 = common_scripts\utility::getstruct("explosion_cart_kill_struct","targetname");
	radiusdamage(var_00.origin,var_00.radius,300,300,undefined);
}

//Function Number: 335
pressure_explosion_damage(param_00)
{
	var_01 = common_scripts\utility::getstruct("pressure_explosion_" + param_00 + "_damage","targetname");
	playrumbleonposition("grenade_rumble",var_01.origin);
	radiusdamage(var_01.origin,var_01.radius,300,300,undefined,"MOD_EXPLOSIVE");
}

//Function Number: 336
reaction_pickup_event()
{
	var_00 = getentarray("crater_models","targetname");
	var_00 = common_scripts\utility::array_add(var_00,getent("crater_brush","targetname"));
	var_01 = getent("crater_brush_surface","targetname");
	var_02 = getent("crater_connectpaths","targetname");
	var_03 = getent("explosion_pickup_intact","targetname");
	var_04 = getent("explosion_pickup","targetname");
	var_04.animname = "pickup";
	var_04 maps\_anim::setanimtree();
	var_04 hide();
	foreach(var_06 in var_00)
	{
		var_06 hide();
	}

	var_08 = getent("truck_flip_collision","targetname");
	var_08 disconnectpaths();
	var_09 = [];
	var_09[var_09.size] = var_04;
	var_0A = getent("org_reaction_pickup_event","targetname");
	var_0A maps\_anim::anim_first_frame(var_09,"fusion_reaction_pickup_event");
	common_scripts\utility::flag_wait("reaction_explo02");
	var_08 connectpaths();
	var_08 delete();
	var_0A thread maps\_anim::anim_single(var_09,"fusion_reaction_pickup_event");
	var_04 thread reaction_pickup_queue_explosion();
	var_04 thread reaction_pickup_player_proximity();
	level waittill("truck_explosion");
	var_03 hide();
	var_04 show();
	var_01 hide();
	var_01 notsolid();
	var_02 solid();
	var_02 disconnectpaths();
	common_scripts\utility::array_call(var_00,::show);
	var_04 thread maps\fusion_fx::underground_pipe_explosion_pickup_truck_vfx();
	thread pressure_explosion_damage(3);
	wait(0.8);
	radiusdamage(var_04.origin,220,200,100,undefined,"MOD_EXPLOSIVE");
	wait(0.3);
	radiusdamage(var_04.origin,180,200,100,undefined,"MOD_EXPLOSIVE");
}

//Function Number: 337
reaction_pickup_queue_explosion()
{
	level endon("truck_explosion");
	self waittillmatch("truck_explosion","single anim");
	level notify("truck_explosion");
}

//Function Number: 338
reaction_pickup_player_proximity()
{
	level endon("truck_explosion");
	var_00 = 202500;
	for(;;)
	{
		if(distancesquared(self.origin,level.player.origin) < var_00)
		{
			var_01 = [];
			var_01[0] = self;
			maps\_anim::anim_set_time(var_01,"fusion_reaction_pickup_event",0.43);
			level notify("truck_explosion");
		}

		wait(0.05);
	}
}

//Function Number: 339
reaction_ai()
{
	var_00 = getentarray("ct_enemies_runaway","targetname");
	common_scripts\utility::flag_wait("ct_combat_retreat");
	common_scripts\utility::array_thread(var_00,::maps\_utility::add_spawn_function,::maps\_utility::disable_long_death);
	var_01 = maps\_utility::array_spawn(var_00);
	common_scripts\utility::flag_wait("reaction_explo01");
	common_scripts\utility::array_thread(level.ct_enemies,::enemy_run_away,"vol_final_runaway",1);
	common_scripts\utility::array_thread(var_01,::enemy_run_away,"vol_final_runaway",1);
	var_02 = getentarray("ct_runaway_enemies","targetname");
	common_scripts\utility::array_thread(var_02,::maps\_utility::add_spawn_function,::maps\_utility::disable_long_death);
	var_02 = maps\_utility::array_spawn(var_02);
	common_scripts\utility::flag_wait("reaction_explo02");
	thread ct_enemies_final_runaway_faceplayer(var_00);
	var_03 = getentarray("ct_enemies_final_runaway","targetname");
	common_scripts\utility::array_thread(var_03,::maps\_utility::add_spawn_function,::maps\_utility::disable_long_death);
	var_04 = maps\_utility::array_spawn(var_03,1,1);
	common_scripts\utility::flag_wait("ct_final_retreat");
	var_05 = getaiarray("axis");
	common_scripts\utility::array_thread(var_05,::enemy_run_away,"vol_final_runaway",1);
}

//Function Number: 340
ct_enemies_runaway_faceplayer()
{
	common_scripts\utility::flag_wait("kva_retreat_faceplayer");
	var_00 = getentarray("ct_runaway_enemies_backup","script_noteworthy");
	foreach(var_02 in var_00)
	{
		if(isalive(var_02))
		{
			var_02 thread maps\_utility::player_seek_enable();
		}
	}
}

//Function Number: 341
ct_enemies_final_runaway_faceplayer(param_00)
{
	self notify("enemy_aggro");
	self endon("enemy_aggro");
	sortbydistance(param_00,level.player.origin);
	level waittill("ct_enemies_runaway_damage");
}

//Function Number: 342
finale_enemy_transports()
{
	if(isdefined(level.start_point) && level.start_point == "cooling_tower")
	{
		return;
	}

	common_scripts\utility::flag_wait("evacuation_started");
	var_00 = maps\_vehicle::spawn_vehicle_from_targetname("ct_enemy_transport_01");
	var_00 maps\_vehicle::godon();
	var_00 thread tigger_hurt_rotor();
	var_00 setmaxpitchroll(30,30);
	var_00 maps\_vehicle::vehicle_lights_on("running");
	var_00.snd_disable_vehicle_system = 1;
	var_01 = maps\_vehicle::spawn_vehicle_from_targetname("ct_enemy_transport_02");
	var_01 maps\_vehicle::godon();
	var_01 setmaxpitchroll(30,40);
	var_00 maps\_vehicle::vehicle_lights_on("running");
	var_01.snd_disable_vehicle_system = 1;
	common_scripts\utility::flag_wait("hangar_enemies");
	var_00.snd_disable_vehicle_system = 0;
	var_01.snd_disable_vehicle_system = 0;
	common_scripts\utility::flag_wait("hangar_combat_retreat_02");
	if(level.nextgen)
	{
		maps\_utility::delaythread(1,::spawn_transport_flying_01);
	}

	common_scripts\utility::flag_wait("hangar_exit_retreat");
	maps\_utility::autosave_by_name();
	if(level.nextgen)
	{
		maps\_utility::delaythread(1,::spawn_transport_flying_02);
	}

	level.get_pdrone_crash_location_override = ::get_pdrone_crash_location_override;
	var_02 = vehicle_scripts\_pdrone::start_flying_attack_drones("kva_retreat_drones");
	foreach(var_04 in var_02)
	{
		var_04 thread maps\_shg_utility::make_emp_vulnerable();
		var_04 thread drone_delete_at_goal();
	}

	maps\_vehicle::gopath(var_00);
	soundscripts\_snd::snd_message("hangar_transport_01_away",var_00);
	common_scripts\utility::flag_wait("ct_combat_retreat");
	var_06 = vehicle_scripts\_pdrone::start_flying_attack_drones("kva_retreat_drones_02");
	foreach(var_04 in var_06)
	{
		var_04 thread maps\_shg_utility::make_emp_vulnerable();
		var_04 thread drone_delete_at_goal();
	}

	maps\_vehicle::gopath(var_01);
	common_scripts\utility::flag_wait("reaction_explo01");
	var_09 = vehicle_scripts\_pdrone::start_flying_attack_drones("kva_retreat_drones_03");
	foreach(var_04 in var_09)
	{
		var_04 thread maps\_shg_utility::make_emp_vulnerable();
		var_04 thread drone_delete_at_goal();
	}

	common_scripts\utility::flag_wait("reaction_explo02");
	foreach(var_04 in var_02)
	{
		if(isdefined(var_04) && isalive(var_04))
		{
			var_04 common_scripts\utility::delaycall(randomfloatrange(0.05,10),::kill);
		}
	}

	level waittill("truck_explosion");
	foreach(var_04 in var_06)
	{
		if(isdefined(var_04) && isalive(var_04))
		{
			var_04 common_scripts\utility::delaycall(randomfloatrange(0.05,1),::kill);
		}
	}

	foreach(var_04 in var_09)
	{
		if(isdefined(var_04) && isalive(var_04))
		{
			var_04 common_scripts\utility::delaycall(randomfloatrange(0.05,1),::kill);
		}
	}
}

//Function Number: 343
tigger_hurt_rotor()
{
	var_00 = getent("trig_hurt_transport_01","targetname");
	var_00 enablelinkto();
	var_00 linkto(self);
	self waittill("death");
	var_00 unlink();
	var_00 delete();
}

//Function Number: 344
spawn_transport_flying_01()
{
	var_00 = maps\_vehicle::spawn_vehicles_from_targetname_and_drive("ct_enemy_transport_flying_01");
	foreach(var_02 in var_00)
	{
		var_02 maps\_vehicle::godon();
	}

	soundscripts\_snd::snd_message("hangar_transport_flying_01_away",var_00[0]);
}

//Function Number: 345
spawn_transport_flying_02()
{
	var_00 = maps\_vehicle::spawn_vehicles_from_targetname_and_drive("ct_enemy_transport_flying_02");
	foreach(var_02 in var_00)
	{
		var_02 maps\_vehicle::godon();
	}

	soundscripts\_snd::snd_message("hangar_transport_flying_02_away",var_00[0]);
}

//Function Number: 346
evacuation_first_drones_think()
{
	level endon("collapse_start");
	self waittill("death");
	if(!isdefined(level.evacuation_first_drones_dead))
	{
		level.evacuation_first_drones_dead = 0;
	}

	level.evacuation_first_drones_dead++;
	if(level.evacuation_first_drones_dead >= 5)
	{
		common_scripts\utility::flag_set("evacuation_first_drones_down");
	}
}

//Function Number: 347
kva_retreat_drones_animated()
{
	var_00 = getent("drone_deploy_run_npc","targetname");
	var_01 = getent("drone_deploy_crouch_npc","targetname");
	thread kva_retreat_drone_think(var_00,0);
	thread kva_retreat_drone_think(var_01,0,"Cover Crouch");
}

//Function Number: 348
kva_retreat_drone_think(param_00,param_01,param_02)
{
	var_03 = param_00 maps\_utility::spawn_ai(1);
	var_03.animname = "generic";
	var_04 = common_scripts\utility::getstruct(param_00.target,"targetname");
	var_05 = spawn("script_origin",var_04.origin);
	var_05.angles = var_04.angles;
	var_06 = getent(var_04.target,"targetname");
	var_07 = getsubstr(var_04.animation,0,var_04.animation.size - 4);
	var_08 = spawn("script_model",var_03 gettagorigin("TAG_STOWED_BACK"));
	var_08 setmodel(var_06.model);
	var_08.angles = var_03 gettagangles("TAG_STOWED_BACK");
	var_08 linkto(var_03,"TAG_STOWED_BACK");
	var_08.animname = "personal_drone";
	var_08 useanimtree(level.scr_animtree["personal_drone"]);
	var_08 thread maps\_anim::anim_loop_solo(var_08,"personal_drone_folded_idle");
	if(isdefined(param_02))
	{
		var_05 maps\_anim::anim_reach_and_approach_solo(var_03,var_07,undefined,"Cover Crouch");
	}
	else
	{
		var_05 maps\_anim::anim_generic_reach(var_03,var_07);
	}

	var_05 maps\_anim::anim_generic_reach(var_03,var_07);
	if(param_01)
	{
		var_05 thread maps\_anim::anim_generic_run(var_03,var_07);
	}
	else
	{
		var_05 thread maps\_anim::anim_generic(var_03,var_07);
	}

	var_06.origin = var_08.origin;
	var_06.angles = var_08.angles;
	var_09 = var_06 maps\_utility::spawn_vehicle();
	var_08 delete();
	var_09.animname = "personal_drone";
	var_05 maps\_anim::anim_single_solo(var_09,var_07);
	if(isdefined(var_09.target))
	{
		var_09 maps\_vehicle::gopath();
	}

	if(var_09.script_team == "axis")
	{
		var_09 thread maps\_shg_utility::make_emp_vulnerable();
	}
}

//Function Number: 349
get_pdrone_crash_location_override()
{
	level.get_pdrone_crash_location_override = undefined;
	return level.player.origin + 200 * anglestoforward(level.player.angles);
}

//Function Number: 350
finale_enemy_gaz()
{
	common_scripts\utility::flag_wait("evacuation_started");
	if(isdefined(level.start_point) && level.start_point != "cooling_tower")
	{
		if(level.nextgen)
		{
			thread finale_enemy_gaz_1();
		}
	}

	var_00 = maps\_vehicle::spawn_vehicle_from_targetname("retreat_gaz_02");
	var_01 = maps\_vehicle::spawn_vehicle_from_targetname("retreat_gaz_03");
	var_00 maps\_vehicle::godon();
	var_01 maps\_vehicle::godon();
	common_scripts\utility::flag_wait("ct_final_retreat");
	wait(1);
	soundscripts\_snd::snd_message("start_gaz_02_retreat",var_00);
	maps\_vehicle::gopath(var_00);
	wait(1.5);
	soundscripts\_snd::snd_message("start_gaz_03_retreat",var_01);
	maps\_vehicle::gopath(var_01);
}

//Function Number: 351
finale_enemy_gaz_1()
{
	var_00 = maps\_vehicle::spawn_vehicle_from_targetname("retreat_gaz_01");
	var_00 maps\_vehicle::godon();
	var_00.snd_disable_vehicle_system = 1;
	common_scripts\utility::flag_wait("hangar_enemies");
	var_00.snd_disable_vehicle_system = 0;
	common_scripts\utility::flag_wait("stop_ambient_explosions");
	wait(5);
	maps\_vehicle::gopath(var_00);
}

//Function Number: 352
cooling_tower_collapse()
{
	var_00 = getentarray("collapse_geo_before","targetname");
	var_01 = getentarray("collapse_geo_after","targetname");
	common_scripts\utility::array_call(var_01,::hide);
	common_scripts\utility::array_call(var_01,::notsolid);
	var_02 = getentarray("cooling_tower_static","targetname");
	thread cooling_tower_collapse_visibility(var_02);
	common_scripts\utility::flag_wait("collapse_start");
	soundscripts\_snd::snd_message("tower_collapse_prep");
	if(!isdefined(level.player_rig))
	{
		level.player_rig = maps\_utility::spawn_anim_model("player_rig");
	}

	var_03 = maps\_utility::spawn_anim_model("player_rig",(0,0,0));
	var_03 hide();
	var_04 = spawn("script_model",(0,0,0));
	var_04 setmodel("fus_sever_debris");
	var_04 hide();
	var_04.animname = "collapse_debris_arm";
	var_04 maps\_anim::setanimtree();
	var_05 = maps\_utility::spawn_anim_model("fus_sever_debris_02");
	var_05 hide();
	var_06 = spawn("script_model",(0,0,0));
	var_06 setmodel("fus_end_scene_rubble");
	var_06 hide();
	var_06.animname = "fus_end_scene_rubble";
	var_06 maps\_anim::setanimtree();
	var_07 = maps\_utility::spawn_anim_model("vehicle_xh9_warbird");
	var_07 hide();
	var_08 = maps\_utility::spawn_anim_model("fusion_chunk_combo");
	var_09 = maps\_utility::spawn_anim_model("fusion_rock_chunk01");
	var_0A = maps\_utility::spawn_anim_model("fusion_rock_chunk02");
	var_0B = maps\_utility::spawn_anim_model("player_dismembered_arm");
	var_0B hide();
	var_0C = [];
	var_0C[0] = level.burke;
	var_0C[1] = level.player_rig;
	var_0C[2] = var_04;
	var_0C[3] = var_0B;
	var_0C[4] = var_06;
	var_0C[5] = var_05;
	var_0C[6] = var_08;
	var_0C[7] = var_09;
	var_0C[8] = var_0A;
	var_0D = [];
	var_0E = spawn("script_model",(0,0,0));
	var_0E setmodel("fus_cooling_tower_collapse_chunks");
	var_0E.animname = "fus_cooling_tower_collapse_chunks";
	var_0E maps\_anim::setanimtree();
	var_0D["chunks"] = var_0E;
	var_0E = spawn("script_model",(0,0,0));
	var_0E setmodel("fus_cooling_tower_collapse_concrete_shattered");
	var_0E.animname = "fus_cooling_tower_collapse_concrete_shattered";
	var_0E maps\_anim::setanimtree();
	var_0D["concrete_shattered"] = var_0E;
	var_0E = spawn("script_model",(0,0,0));
	var_0E setmodel("fus_cooling_tower_collapse_concrete_shattered2");
	var_0E.animname = "fus_cooling_tower_collapse_concrete_shattered2";
	var_0E maps\_anim::setanimtree();
	var_0D["concrete_shattered2"] = var_0E;
	var_0E = spawn("script_model",(0,0,0));
	var_0E setmodel("fus_cooling_tower_collapse_street_collapse");
	var_0E.animname = "fus_cooling_tower_collapse_street_collapse";
	var_0E maps\_anim::setanimtree();
	var_0D["street"] = var_0E;
	common_scripts\utility::array_call(var_0D,::hide);
	var_0F = maps\_utility::getanim_from_animname("fusion_silo_collapse_vm_pt02",level.player_rig.animname);
	var_10 = getanimlength(var_0F);
	var_11 = getangledelta(level.scr_anim["player_rig"]["fusion_silo_collapse_vm_pt02"],0,1);
	var_12 = getmovedelta(level.scr_anim["player_rig"]["fusion_silo_collapse_vm_pt02"],0,1);
	var_13 = getent("org_collapse_new","targetname");
	level.player thread collapse_player_dynamic_speed(var_13);
	var_13 maps\_anim::anim_first_frame(var_0D,"fusion_collapse_ground_tower");
	thread collapse_player_disable_exo_and_weapons();
	level thread maps\fusion_fx::pressure_explosion_lead_up();
	wait(1.1);
	level notify("collapse_animation_started");
	soundscripts\_snd::snd_message("tower_collapse_start");
	var_13 thread collapse_animate_lamps("fusion_collapse_ground_tower");
	level thread maps\fusion_fx::big_moment_ending_vfx(var_0D);
	common_scripts\utility::array_call(var_02,::hide);
	common_scripts\utility::array_call(var_0D,::show);
	var_14 = getaiarray("axis");
	foreach(var_16 in var_14)
	{
		var_16 kill();
	}

	common_scripts\utility::array_thread(getentarray("collapse_stop_signs","targetname"),::collapse_stop_sign_think,var_13);
	common_scripts\utility::array_thread(getaiarray("allies"),::collapse_friendly_think,var_13);
	var_13 thread maps\_anim::anim_single(var_0D,"fusion_collapse_ground_tower");
	common_scripts\utility::flag_wait("tower_knockback");
	thread tower_collapse_knockback_disable_sonar();
	thread collapse_shellshock();
	soundscripts\_snd::snd_message("tower_collapse_player_stumble");
	var_13 maps\_utility::delaythread(1,::maps\_anim::anim_first_frame_solo,level.burke,"fusion_silo_stumble_npc");
	level.burke common_scripts\utility::delaycall(1,::hide);
	common_scripts\utility::noself_delaycall(1,::setsaveddvar,"g_friendlynamedist",0);
	level.burke common_scripts\utility::delaycall(1,::setcontents,0);
	level.player thread maps\_shg_utility::setup_player_for_scene();
	level.player maps\_anim::anim_first_frame_solo(level.player_rig,"fusion_silo_collapse_vm_pt01");
	var_18 = 0.5;
	level.player playerlinktoblend(level.player_rig,"tag_player",var_18);
	level.player common_scripts\utility::delaycall(var_18,::playerlinktodelta,level.player_rig,"tag_player",1,5,5,5,5,1);
	level.player_rig common_scripts\utility::delaycall(var_18,::show);
	var_19 = "fusion_silo_collapse_vm_pt01";
	maps\_utility::delaythread(1,::common_scripts\utility::array_call,var_00,::delete);
	maps\_utility::delaythread(1,::common_scripts\utility::array_call,var_01,::show);
	maps\_utility::delaythread(1,::common_scripts\utility::array_call,var_01,::solid);
	thread maps\_utility::lerp_fov_overtime(3,75);
	var_1A = getanimlength(level.player_rig maps\_utility::getanim(var_19));
	level.player common_scripts\utility::delaycall(var_1A - 0.5,::enableweapons);
	level.player thread collapse_player_look_at_tower(var_19,var_13.origin);
	level.player maps\_anim::anim_single_solo(level.player_rig,var_19);
	level.player thread maps\_shg_utility::setup_player_for_gameplay();
	level.player_rig hide();
	level.player unlink();
	thread collapse_player_disable_exo_and_weapons();
	common_scripts\utility::flag_wait("tower_debris");
	soundscripts\_snd::snd_message("tower_collapse_player_knockback");
	wait(0.3);
	level.player disableweapons();
	thread maps\_utility::lerp_fov_overtime(3,65);
	level.player thread maps\_shg_utility::setup_player_for_scene();
	level.player maps\_anim::anim_first_frame_solo(level.player_rig,"fusion_silo_collapse_vm_pt02");
	var_13 maps\_anim::anim_first_frame_solo(level.burke,"fusion_silo_collapse_finale");
	var_13 maps\_anim::anim_first_frame_solo(var_07,"fusion_silo_collapse_warbird");
	var_1B = combineangles(level.player_rig.angles,(0,0,var_11));
	var_1C = level.player_rig.origin + var_12[0] * anglestoforward(level.player_rig.angles) + var_12[1] * anglestoright(level.player_rig.angles) + var_12[2] * anglestoup(level.player_rig.angles);
	var_1D = var_03.origin - var_1C;
	var_1E = var_03.angles - var_1B;
	level.player_rig.angles = (0,vectortoangles(var_13.origin - level.player.origin)[1],0);
	level.player_rig.origin = level.player.origin;
	var_18 = 0.5;
	level.player playerlinktoblend(level.player_rig,"tag_player",var_18);
	level.player common_scripts\utility::delaycall(var_18,::playerlinktodelta,level.player_rig,"tag_player",1,20,20,20,0,1);
	level.player_rig common_scripts\utility::delaycall(var_18,::show);
	level.player freezecontrols(1);
	level.player_rig maps\_anim::anim_single_solo(level.player_rig,"fusion_silo_collapse_vm_pt02");
	level notify("stop_player_pos_update");
	soundscripts\_snd::snd_message("silo_collapse_plr_stunned");
	var_06 show();
	soundscripts\_snd::snd_message("fus_outro_burke_foley");
	var_07 show();
	level.burke show();
	var_1F = common_scripts\utility::spawn_tag_origin();
	var_1F linkto(var_07,"TAG_light_body_l",(10,0,-20),(14,110,0));
	playfxontag(common_scripts\utility::getfx("fusion_light_heli_strobe_outro"),var_1F,"TAG_ORIGIN");
	var_07 soundscripts\_snd::snd_message("fusion_silo_collapse_warbird");
	var_13 thread maps\_anim::anim_single_solo(level.burke,"fusion_silo_collapse_finale");
	var_13 thread maps\_anim::anim_single_solo(var_07,"fusion_silo_collapse_warbird");
	var_13 thread maps\_anim::anim_single(var_0C,"fusion_silo_collapse_finale");
	var_20 = maps\_utility::getanim_from_animname("fusion_silo_collapse_finale",level.player_rig.animname);
	level notify("stop_evacuation_kiosk_movie");
	var_21 = getanimlength(var_20);
	wait(var_21 - 2);
	common_scripts\utility::flag_set("play_ending");
	var_22 = 2;
	soundscripts\_snd::snd_message("ending_fade_out",var_22);
	maps\_utility::nextmission();
}

//Function Number: 353
ending_fade_out(param_00)
{
	setblur(10,param_00);
	var_01 = newhudelem();
	var_01.x = 0;
	var_01.y = 0;
	var_01.horzalign = "fullscreen";
	var_01.vertalign = "fullscreen";
	var_01 setshader("black",640,480);
	if(isdefined(param_00) && param_00 > 0)
	{
		var_01.alpha = 0;
		var_01 fadeovertime(param_00);
		var_01.alpha = 1;
		wait(param_00);
	}

	waittillframeend;
	var_01 destroy();
}

//Function Number: 354
collapse_shellshock()
{
	var_00 = 10;
	level.player shellshock("fusion_pre_collapse",var_00);
	common_scripts\utility::flag_wait("tower_debris");
	wait(1);
	var_00 = 7;
	level.player shellshock("fusion_collapse",var_00);
	wait(8);
	var_00 = 60;
	level.player shellshock("fusion_pre_collapse",var_00);
}

//Function Number: 355
collapse_friendly_think(param_00)
{
	var_01 = 0.0005;
	var_02 = distance(self.origin,param_00.origin) * var_01 - 0.97;
	wait(var_02);
	maps\_utility::flashbangstart(4);
	if(self != level.burke)
	{
		common_scripts\utility::flag_wait("tower_knockback");
		wait(3);
		maps\_utility::stop_magic_bullet_shield();
		self delete();
	}
}

//Function Number: 356
collapse_stop_sign_think(param_00)
{
	var_01 = 0.0005;
	var_02 = distance(self.origin,param_00.origin) * var_01 - 0.97;
	wait(var_02);
	var_03 = getent(self.target,"targetname");
	var_03 linkto(self);
	var_04 = vectortoangles(param_00.origin - self.origin);
	if(self.angles[1] - var_04[1] > -180)
	{
		var_05 = var_04 + (0,-90,90);
	}
	else
	{
		var_05 = var_05 + (0,90,-90);
	}

	var_06 = 0.3;
	self rotateto(var_05,var_06,0.1,0);
	wait(var_06);
	var_03 delete();
	self delete();
}

//Function Number: 357
collapse_animate_lamps(param_00)
{
	var_01 = getentarray("collapse_streetlight","targetname");
	foreach(var_03 in var_01)
	{
		if(isdefined(var_03))
		{
			var_03 delete();
		}
	}

	var_05 = [];
	for(var_06 = 1;var_06 < 10;var_06++)
	{
		var_05[var_05.size] = maps\_utility::spawn_anim_model("fusion_silo_lamp0" + var_06);
	}

	for(var_06 = 0;var_06 <= 5;var_06++)
	{
		var_05[var_05.size] = maps\_utility::spawn_anim_model("fusion_silo_lamp1" + var_06);
	}

	maps\_anim::anim_single(var_05,param_00);
}

//Function Number: 358
cooling_tower_collapse_visibility(param_00)
{
	level endon("collapse_start");
	common_scripts\utility::array_call(param_00,::hide);
	for(;;)
	{
		common_scripts\utility::flag_wait("show_collapse_tower");
		common_scripts\utility::array_call(param_00,::show);
		common_scripts\utility::flag_waitopen("show_collapse_tower");
		common_scripts\utility::array_call(param_00,::hide);
	}
}

//Function Number: 359
grey_out_player()
{
	var_00 = maps\_hud_util::create_client_overlay("white",0,level.player);
	var_00.sort = -1;
	var_00.foreground = 1;
	var_00.color = (0.6,0.6,0.6);
	var_01 = 0.1;
	var_02 = 1;
	var_00 fadeovertime(var_01);
	var_00.alpha = var_02;
	wait(var_01);
	var_01 = 0.05;
	wait(var_01);
	var_01 = 0.1;
	var_02 = 0;
	var_00 fadeovertime(var_01);
	var_00.alpha = var_02;
	wait(var_01);
	var_00 destroy();
}

//Function Number: 360
collapse_player_dynamic_speed(param_00)
{
	level endon("stop_player_pos_update");
	var_01 = 2636;
	var_02 = 4000;
	var_03 = var_02 - var_01;
	var_04 = 0.05;
	var_05 = 1;
	for(;;)
	{
		var_06 = distance(level.player.origin,param_00.origin) - var_01 / var_03;
		if(var_06 < var_04)
		{
			var_06 = var_04;
		}
		else if(var_06 > var_05)
		{
			var_06 = var_05;
		}

		level.player setmovespeedscale(var_06);
		wait(0.05);
	}

	level.player maps\_utility::blend_movespeedscale_percent(50,3);
}

//Function Number: 361
collapse_player_disable_exo_and_weapons()
{
	maps\_player_exo::player_exo_deactivate();
	level.player disableweaponswitch();
	level.player disableoffhandweapons();
	level.player enableinvulnerability();
	level.player allowjump(0);
	level.player.ignoreme = 1;
}

//Function Number: 362
collapse_player_look_at_tower(param_00,param_01)
{
	var_02 = maps\_utility::getanim_from_animname(param_00,level.player_rig.animname);
	var_03 = getanimlength(var_02);
	var_04 = vectortoangles(param_01 - level.player.origin);
	level.player setplayerangles((0,var_04[1],0));
}

//Function Number: 363
collapse_cleanup()
{
	wait(1);
	var_00 = getaiarray();
	foreach(var_02 in var_00)
	{
		if(isdefined(var_02.magic_bullet_shield) && var_02.magic_bullet_shield)
		{
			var_02 maps\_utility::stop_magic_bullet_shield();
		}
	}

	common_scripts\utility::array_call(var_00,::delete);
}

//Function Number: 364
play_fullscreen_blood_splatter(param_00,param_01,param_02,param_03,param_04)
{
	var_05 = newclienthudelem(self);
	var_05.x = 0;
	var_05.y = 0;
	var_05 setshader(param_00,640,480);
	var_05.splatter = 1;
	var_05.alignx = "left";
	var_05.aligny = "top";
	var_05.sort = 1;
	var_05.foreground = 0;
	var_05.horzalign = "fullscreen";
	var_05.vertalign = "fullscreen";
	var_05.alpha = 0;
	var_05.enablehudlighting = 1;
	var_06 = 0;
	if(!isdefined(param_02))
	{
		param_02 = 1;
	}

	if(!isdefined(param_03))
	{
		param_03 = 1;
	}

	if(!isdefined(param_04))
	{
		param_04 = 1;
	}

	var_07 = 0.05;
	if(param_02 > 0)
	{
		var_08 = 0;
		var_09 = param_04 / param_02 / var_07;
		while(var_08 < param_04)
		{
			var_05.alpha = var_08;
			var_08 = var_08 + var_09;
			wait(var_07);
		}
	}

	var_05.alpha = param_04;
	wait(param_01 - param_02 + param_03);
	if(param_03 > 0)
	{
		var_08 = param_04;
		var_0A = param_04 / param_03 / var_07;
		while(var_08 > 0)
		{
			var_05.alpha = var_08;
			var_08 = var_08 - var_0A;
			wait(var_07);
		}
	}

	var_05.alpha = 0;
	var_05 destroy();
}

//Function Number: 365
warbird_shooting_think(param_00)
{
	level.player endon("death");
	self endon("death");
	self.mgturret[0] setmode("manual");
	self.mgturret[1] setmode("manual");
	if(!maps\_utility::ent_flag_exist("fire_turrets"))
	{
		maps\_utility::ent_flag_init("fire_turrets");
	}

	maps\_utility::ent_flag_set("fire_turrets");
	thread warbird_fire_monitor();
	for(;;)
	{
		self waittill("warbird_fire");
		thread warbird_fire(param_00);
	}
}

//Function Number: 366
warbird_fire(param_00)
{
	self endon("death");
	var_01 = self.mgturret[0];
	var_02 = self.mgturret[1];
	while(maps\_utility::ent_flag("fire_turrets"))
	{
		var_03 = getaiarray("axis");
		if(isdefined(level.flying_attack_drones))
		{
			var_04 = level.flying_attack_drones;
		}
		else
		{
			var_04 = [];
		}

		if(isdefined(level.drones) && isdefined(level.drones["axis"].array))
		{
			var_03 = common_scripts\utility::array_combine(var_03,level.drones["axis"].array);
		}

		var_03 = common_scripts\utility::array_combine(var_03,var_04);
		var_05 = [];
		foreach(var_07 in var_03)
		{
			if(isdefined(var_07.ignoreme) && var_07.ignoreme)
			{
				continue;
			}
			else
			{
				var_05[var_05.size] = var_07;
			}
		}

		var_05 = sortbydistance(var_05,self.origin);
		var_09 = undefined;
		foreach(var_07 in var_05)
		{
			if(!isdefined(var_07))
			{
				continue;
			}

			if(!isalive(var_07))
			{
				continue;
			}

			if(isdefined(param_00) && param_00)
			{
				var_0B = self.mgturret[0] gettagorigin("tag_flash");
				var_0C = var_07 geteye();
				var_0D = vectornormalize(var_0C - var_0B);
				var_0E = var_0B + var_0D * 20;
				if(!sighttracepassed(var_0E,var_0C,0,var_07,self.mgturret[0]))
				{
					continue;
				}
			}

			var_09 = var_07;
			break;
		}

		if(isdefined(var_09))
		{
			var_01 settargetentity(var_09);
			var_02 settargetentity(var_09);
			var_01 turretfireenable();
			var_02 turretfireenable();
			var_01 startfiring();
			var_02 startfiring();
			wait_for_warbird_fire_target_done(var_09,param_00);
			var_01 cleartargetentity();
			var_02 cleartargetentity();
			var_01 turretfiredisable();
			var_02 turretfiredisable();
		}

		wait(0.05);
	}

	var_01 turretfiredisable();
	var_02 turretfiredisable();
}

//Function Number: 367
wait_for_warbird_fire_target_done(param_00,param_01)
{
	param_00 endon("death");
	if(!maps\_utility::ent_flag("fire_turrets"))
	{
		return;
	}

	self endon("fire_turrets");
	for(;;)
	{
		if(isdefined(param_01) && param_01)
		{
			var_02 = self.mgturret[0] gettagorigin("tag_flash");
			var_03 = param_00 geteye();
			var_04 = vectornormalize(var_03 - var_02);
			var_05 = var_02 + var_04 * 20;
			if(!sighttracepassed(var_05,var_03,0,param_00,self.mgturret[0]))
			{
				return;
			}
		}

		wait(0.3);
	}
}

//Function Number: 368
warbird_fire_monitor()
{
	self endon("death");
	self waittill("warbird_stop_firing");
	maps\_utility::ent_flag_clear("fire_turrets");
}

//Function Number: 369
heli_looking_at_target(param_00)
{
	var_01 = 45;
	var_02 = cos(var_01);
	var_03 = anglestoforward(self.angles);
	var_04 = vectornormalize(param_00.origin - self.origin);
	if(vectordot(var_03,var_04) >= var_02)
	{
		return 1;
	}

	return 0;
}

//Function Number: 370
demo_skip_forward()
{
	common_scripts\utility::flag_wait("start_itiot");
	if(getdvarint("demo_itiot") == 1)
	{
		wait(0.5);
		level.overlay = maps\_hud_util::create_client_overlay("black",0,level.player);
		level.overlay.sort = -1;
		level.overlay.foreground = 1;
		level.overlay.color = (0,0,0);
		level.overlay fadeovertime(1);
		level.overlay.alpha = 1;
		soundscripts\_snd::snd_message("itiot_fade_out");
		var_00 = [];
		var_00[0] = "In the interest of time...";
		thread demo_feed_lines(var_00,1);
		wait(1);
		if(isdefined(level.player.drivingvehicle))
		{
			level.player.drivingvehicle notify("exit_vehicle_dof");
			level.player maps\_utility::player_dismount_vehicle();
		}
		else if(isdefined(level.player.drivingvehicleandturret))
		{
			level.player.drivingvehicleandturret notify("exit_vehicle_dof");
			level.player.drivingvehicleandturret notify("dismount_vehicle_and_turret");
			level.player.drivingvehicleandturret = undefined;
		}

		if(isdefined(level.alpha_leader))
		{
			level.alpha_leader maps\_utility::stop_magic_bullet_shield();
		}

		if(isdefined(level.joker))
		{
			level.joker maps\_utility::stop_magic_bullet_shield();
		}

		if(isdefined(level.carter))
		{
			level.carter maps\_utility::stop_magic_bullet_shield();
		}

		if(isdefined(level.burke))
		{
			level.burke maps\_utility::stop_magic_bullet_shield();
		}

		level.burke maps\_utility::anim_stopanimscripted();
		level.joker maps\_utility::anim_stopanimscripted();
		level notify("itiot_cleanup");
		common_scripts\utility::array_call(getaiarray(),::delete);
		common_scripts\utility::array_call(getentarray("script_vehicle_x4walker_wheels_turret","classname"),::delete);
		if(isdefined(level.player.linked_to_cover))
		{
			level.player.linked_to_cover vehicle_scripts\_cover_drone::player_unlink_from_cover();
		}

		common_scripts\utility::array_call(getentarray("script_vehicle_cover_drone","classname"),::delete);
		common_scripts\utility::array_call(getentarray("mobile_turret","targetname"),::delete);
		common_scripts\utility::array_call(getentarray("script_vehicle_pdrone","classname"),::delete);
		level.player setstance("stand");
		level.player freezecontrols(1);
		level.player maps\_utility::teleport_player(common_scripts\utility::getstruct("itiot_player_start","targetname"));
		level.player setplayerangles(level.player.angles + (7,0,0));
		wait(4);
		soundscripts\_snd::snd_message("itiot_fade_in");
		level.player freezecontrols(0);
		common_scripts\utility::flag_set("flag_shut_down_reactor_failed");
		common_scripts\utility::flag_set("evacuation_started");
	}
}

//Function Number: 371
demo_feed_lines(param_00,param_01)
{
	var_02 = getarraykeys(param_00);
	for(var_03 = 0;var_03 < var_02.size;var_03++)
	{
		var_04 = var_02[var_03];
		var_05 = var_03 * param_01 + 1;
		maps\_utility::delaythread(var_05,::centerlinethread,param_00[var_04],param_00.size - var_03 - 1,param_01,var_04);
	}
}

//Function Number: 372
centerlinethread(param_00,param_01,param_02,param_03)
{
	level notify("new_introscreen_element");
	var_04 = newhudelem();
	var_04.x = 0;
	var_04.y = 0;
	var_04.alignx = "center";
	var_04.aligny = "middle";
	var_04.horzalign = "center";
	var_04.vertalign = "middle_adjustable";
	var_04.sort = 1;
	var_04.foreground = 1;
	var_04 settext(param_00);
	var_04.alpha = 0;
	var_04 fadeovertime(0.2);
	var_04.alpha = 1;
	var_04.hidewheninmenu = 1;
	var_04.fontscale = 2.4;
	var_04.color = (0.8,1,0.8);
	var_04.font = "objective";
	var_04.glowcolor = (0.3,0.6,0.3);
	var_04.glowalpha = 1;
	var_05 = int(param_02 * 1000 + 4000);
	var_04 setpulsefx(30,var_05,700);
	thread maps\_introscreen::hudelem_destroy(var_04);
	if(!isdefined(param_03))
	{
		return;
	}

	if(!isstring(param_03))
	{
		return;
	}

	if(param_03 != "date")
	{
	}
}

//Function Number: 373
introscreen_generic_fade_out(param_00,param_01,param_02,param_03)
{
	if(!isdefined(param_02))
	{
		param_02 = 1.5;
	}

	var_04 = newhudelem();
	var_04.x = 0;
	var_04.y = 0;
	var_04.horzalign = "fullscreen";
	var_04.vertalign = "fullscreen";
	var_04.foreground = 1;
	var_04 setshader(param_00,640,480);
	if(isdefined(param_03) && param_03 > 0)
	{
		var_04.alpha = 0;
		var_04 fadeovertime(param_03);
		var_04.alpha = 1;
		wait(param_03);
	}

	wait(param_01);
	if(isdefined(param_02) && param_02 > 0)
	{
		var_04.alpha = 1;
		var_04 fadeovertime(param_02);
		var_04.alpha = 0;
	}

	var_04 destroy();
}

//Function Number: 374
prep_cinematic(param_00)
{
	setsaveddvar("cg_cinematicFullScreen","0");
	cinematicingame(param_00,1);
	level.current_cinematic = param_00;
}

//Function Number: 375
play_cinematic(param_00,param_01,param_02)
{
	if(!isdefined(param_01))
	{
		soundscripts\_audio::deprecated_aud_send_msg("begin_cinematic",param_00);
	}

	if(isdefined(level.current_cinematic))
	{
		pausecinematicingame(0);
		setsaveddvar("cg_cinematicFullScreen","1");
		level.current_cinematic = undefined;
	}
	else
	{
		cinematicingame(param_00);
	}

	if(!isdefined(param_02) || !param_02)
	{
		setsaveddvar("cg_cinematicCanPause","1");
	}

	wait(1);
	while(iscinematicplaying())
	{
		wait(0.05);
	}

	if(!isdefined(param_02) || !param_02)
	{
		setsaveddvar("cg_cinematicCanPause","0");
	}

	if(!isdefined(param_01))
	{
		soundscripts\_audio::deprecated_aud_send_msg("end_cinematic",param_00);
	}
}

//Function Number: 376
setup_evacuation_scene()
{
	maps\_drone_civilian::init();
	maps\_drone_ai::init();
	level.evacuation_scene_spawners = [];
	level.evacuation_scene_spawners["civilian"] = getentarray("evacuation_scene_spawners_civilians","targetname");
	level.evacuation_scene_spawners["axis"] = getentarray("evacuation_scene_spawners_axis","targetname");
	level.evacuation_scene_index = [];
	level.evacuation_scene_index["civilian"] = 0;
	level.evacuation_scene_index["axis"] = 0;
	level.scr_anim["civilian"]["civilian_run_hunched_A_relative"] = %civilian_run_hunched_a_relative;
	level.scr_anim["civilian"]["civilian_run_upright_relative"] = %civilian_run_upright_relative;
	level.scr_anim["civilian"]["unarmed_scared_run"] = %unarmed_scared_run;
	level.scr_anim["civilian"]["civilian_leaning_death"] = %civilian_leaning_death;
	level.scr_anim["civilian"]["DC_Burning_bunker_stumble"] = %dc_burning_bunker_stumble;
	level.scr_anim["civilian"]["civilian_run_upright_turnL90"] = %civilian_run_upright_turnl90;
	level.scr_anim["civilian"]["civilian_run_hunched_turnL90_slide"] = %civilian_run_hunched_turnl90_slide;
	thread handle_evacuation_scene_triggers();
}

//Function Number: 377
handle_evacuation_scene_triggers()
{
	var_00 = getentarray("evacuation_scene_trigger","script_noteworthy");
	common_scripts\utility::array_thread(var_00,::evacuation_scene_trigger_think);
}

//Function Number: 378
evacuation_scene_trigger_think()
{
	var_00 = common_scripts\utility::getstructarray(self.target,"targetname");
	self waittill("trigger",var_01);
	common_scripts\utility::flag_set("hangar_exit_explosion");
	foreach(var_03 in var_00)
	{
		var_03 thread evacuation_scene_think();
	}
}

//Function Number: 379
evacuation_scene_think()
{
	var_00 = get_evacuation_scene_spawner(self.script_parameters);
	if(isdefined(self.script_delay))
	{
		wait(self.script_delay);
	}

	if(isdefined(self.script_noteworthy) && self.script_noteworthy == "runner")
	{
		var_00.target = self.target;
		var_01 = var_00 maps\_utility::spawn_ai(1);
		var_00.target = undefined;
		var_01.origin = self.origin;
		var_01.no_friendly_fire_penalty = 1;
		var_01 thread evacuation_scene_run_actor(self.animation,self.script_parameters);
		return;
	}

	if(isdefined(self.script_noteworthy) && self.script_noteworthy == "run_and_die")
	{
		var_01.target = self.target;
		var_01 = var_01 maps\_utility::spawn_ai(1);
		var_00.target = undefined;
		var_01.origin = self.origin;
		var_01.no_friendly_fire_penalty = 1;
		var_01 thread evacuation_scene_run_actor_and_die(self.animation,self.script_parameters);
		return;
	}

	if(isdefined(self.script_noteworthy) && self.script_noteworthy == "anim_then_run")
	{
		var_01.target = self.target;
		var_01.script_moveoverride = 1;
		var_01 = var_01 maps\_utility::spawn_ai(1);
		var_01.no_friendly_fire_penalty = 1;
		var_00.script_moveoverride = undefined;
		var_01.animname = self.script_parameters;
		var_02 = var_01 evacuation_scene_determine_run_cycle(self.animation);
		var_01 maps\_utility::set_run_anim_array(var_02,undefined,1);
		evacuation_scene_animate_actor(var_01);
		var_01 notify("move");
		var_01 waittill("goal");
		var_01 kill();
		return;
	}

	var_01 = var_01 maps\_utility::spawn_ai(1);
	var_01.no_friendly_fire_penalty = 1;
	var_01.animname = self.script_parameters;
	thread evacuation_scene_animate_actor(var_01);
}

//Function Number: 380
get_evacuation_scene_spawner(param_00)
{
	var_01 = level.evacuation_scene_spawners[param_00][level.evacuation_scene_index[param_00]];
	level.evacuation_scene_index[param_00]++;
	if(level.evacuation_scene_index[param_00] >= level.evacuation_scene_spawners[param_00].size)
	{
		level.evacuation_scene_index[param_00] = 0;
	}

	return var_01;
}

//Function Number: 381
evacuation_scene_animate_actor(param_00)
{
	param_00 endon("death");
	param_00.allowdeath = 1;
	var_01 = self.animation;
	if(isarray(level.scr_anim[param_00.animname][var_01]))
	{
		var_02 = 1;
		thread maps\_anim::anim_generic_loop(param_00,var_01,"stop_idle");
		return;
	}

	var_03 = issubstr(var_01,"death");
	if(var_03)
	{
		param_00.skipdeathanim = 1;
		param_00.noragdoll = 1;
	}

	if(var_01 == "dubai_restaurant_rolling_soldier")
	{
		param_00 common_scripts\utility::delaycall(1.8,::startragdoll);
	}

	if(issubstr(var_01,"run"))
	{
		maps\_anim::anim_single_solo_run(param_00,var_01);
	}
	else
	{
		maps\_anim::anim_single_solo(param_00,var_01);
	}

	if(var_03)
	{
		param_00 kill();
	}

	var_04 = var_01 + "_idle";
	if(isdefined(level.scr_anim[param_00.animname][var_04]))
	{
		thread maps\_anim::anim_loop_solo(param_00,var_04,"stop_idle");
	}
}

//Function Number: 382
evacuation_scene_run_actor(param_00,param_01)
{
	self.runanim = level.scr_anim[param_01][param_00];
	self waittill("goal");
	self delete();
}

//Function Number: 383
evacuation_scene_run_actor_and_die(param_00,param_01)
{
	self waittill("goal");
	self.animation = param_00;
	self.animname = param_01;
	var_02 = common_scripts\utility::getstruct(self.target,"targetname");
	var_02 evacuation_scene_animate_actor(self);
}

//Function Number: 384
evacuation_scene_determine_run_cycle(param_00)
{
	if(issubstr(param_00,"civilian_run_hunched"))
	{
		param_00 = "civilian_run_hunched_A_relative";
	}
	else if(issubstr(param_00,"civilian_run_upright"))
	{
		param_00 = "civilian_run_upright_relative";
	}
	else
	{
	}

	self.runanim = level.scr_anim[self.animname][param_00];
	return param_00;
}

//Function Number: 385
evacuation_balcony_death()
{
	common_scripts\utility::flag_wait("reaction_explo01");
	var_00 = getent("evacuation_scene_civilian_balcony_death","targetname");
	var_01 = common_scripts\utility::getstruct(var_00.target,"targetname");
	var_02 = var_00 maps\_utility::spawn_ai(1);
	var_02.no_friendly_fire_penalty = 1;
	var_02.origin = var_01.origin;
	var_02.angles = var_01.angles;
	var_01 maps\_anim::anim_generic(var_02,"payback_comp_balcony_kick_enemy");
	var_02 kill(level.player.origin);
	var_02 startragdoll();
}

//Function Number: 386
evacuation_corpses()
{
	var_00 = getent("evacuation_corpse_civilian","targetname");
	var_01 = common_scripts\utility::getstructarray("evacuation_corpse","targetname");
	foreach(var_03 in var_01)
	{
		if(!isdefined(var_03.script_parameters))
		{
			continue;
		}

		var_04 = undefined;
		switch(var_03.script_parameters)
		{
			case "civilian":
				var_04 = var_00 maps\_utility::spawn_ai();
				break;

			case "allies":
			case "axis":
			default:
				break;
		}

		if(!isdefined(var_04))
		{
			continue;
		}

		var_04.origin = var_03.origin;
		var_04.angles = var_03.angles;
		var_04 setcandamage(0);
		var_05 = level.scr_anim["generic"][var_03.animation];
		if(isarray(var_05))
		{
			var_05 = var_05[0];
		}

		var_04 animscripted("endanim",var_03.origin,var_03.angles,var_05);
		var_04 notsolid();
		if(issubstr(var_03.animation,"death"))
		{
			var_04 common_scripts\utility::delaycall(0.05,::setanimtime,var_05,1);
		}
	}
}

//Function Number: 387
detect_turret_death()
{
	self.deathfunction = ::set_turret_death_anim;
}

//Function Number: 388
set_turret_death_anim()
{
	if(self.damageweapon == "none" && self.damagetaken > 100)
	{
		var_00 = animscripts\death::getstrongbulletdamagedeathanim();
		if(isdefined(var_00))
		{
			self.deathanim = var_00;
		}
	}

	return 0;
}

//Function Number: 389
smaw_laser_think()
{
	for(;;)
	{
		level.player waittill("weaponchange");
		if(level.player getcurrentweapon() == "smaw_nolock_fusion")
		{
			level.player laseron();
			continue;
		}

		level.player laseroff();
	}
}

//Function Number: 390
intro_heli_movies()
{
	common_scripts\utility::flag_wait("intro_text_cinematic_over");
	setsaveddvar("cg_cinematicFullScreen","0");
	cinematicingameloop("fusion_heliscreen01");
	level.burke waittillmatch("start_video_2","single anim");
	stopcinematicingame();
	cinematicingameloop("fusion_heliscreen02");
	level.burke waittillmatch("start_video_3","single anim");
	stopcinematicingame();
	cinematicingame("fusion_heliscreen03");
	wait(1.9);
	stopcinematicingame();
	cinematicingameloop("fusion_heliscreen01");
	wait(90);
	stopcinematicingame();
}

//Function Number: 391
evacuation_kiosk_movie()
{
	level endon("stop_evacuation_kiosk_movie");
	setsaveddvar("cg_cinematicFullScreen","0");
	var_00 = 0;
	for(;;)
	{
		var_01 = level.player.origin[0] < 7200;
		var_00 = var_00 && iscinematicplaying();
		if(!var_00 && var_01)
		{
			cinematicingameloop("fusion_evacuation");
			var_00 = 1;
		}
		else if(var_00 && !var_01)
		{
			stopcinematicingame();
			var_00 = 0;
		}

		wait(0.5);
	}
}

//Function Number: 392
take_car_door_shields()
{
	self notify("remove_car_doors");
}

//Function Number: 393
drone_delete_at_goal()
{
	self waittill("reached_path_end");
	self delete();
}

//Function Number: 394
give_night_vision(param_00)
{
	level endon("flag_end_sonar_vision");
	if(isdefined(param_00))
	{
		common_scripts\utility::flag_wait(param_00);
	}

	level.player setweaponhudiconoverride("actionslot1","dpad_icon_nvg");
	level.player notifyonplayercommand("sonar_vision","+actionslot 1");
	level.player thread maps\fusion_utility::thermal_with_nvg();
}

//Function Number: 395
sonar_hint()
{
	level.player endon("death");
	common_scripts\utility::flag_wait("turbine_room_combat_start");
	wait(7);
	if(!maps\_nightvision::nightvision_check(level.player))
	{
		maps\_utility::hintdisplaymintimehandler("hint_use_sonar",8);
	}
}

//Function Number: 396
tower_collapse_knockback_disable_sonar()
{
	wait(1);
	maps\sanfran_b_sonar_vision::sonar_vision_off();
	maps\fusion_utility::sonar_off();
	common_scripts\utility::flag_set("flag_end_sonar_vision");
}

//Function Number: 397
pdrone_deploy_hint()
{
	level.player endon("death");
	common_scripts\utility::flag_wait("turbine_room_combat_start");
	wait(7);
	if(!common_scripts\utility::flag("flag_player_using_drone"))
	{
		maps\_utility::hintdisplaymintimehandler("drone_deploy_prompt",8);
		common_scripts\utility::flag_set("drone_deploy_prompt_displayed");
	}
}

//Function Number: 398
pdrone_activate(param_00)
{
	if(isdefined(param_00))
	{
		common_scripts\utility::flag_wait(param_00);
	}

	level.player setweaponhudiconoverride("actionslot1","dpad_icon_drone");
	level.player notifyonplayercommand("use_drone","-actionslot 1");
	thread maps\fusion_utility::spawn_player_drone_think();
}

//Function Number: 399
pdrone_deactivate_think()
{
	common_scripts\utility::flag_wait("turbine_room_stop_combat");
	if(!common_scripts\utility::flag("player_drone_attack_done"))
	{
		level.player setweaponhudiconoverride("actionslot1","dpad_icon_drone_off");
		common_scripts\utility::flag_clear("flag_player_using_drone");
		common_scripts\utility::flag_set("player_drone_attack_done");
	}
}