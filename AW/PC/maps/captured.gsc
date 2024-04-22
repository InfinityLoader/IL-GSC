/*******************************************************************
 * Decompiled By: Bog
 * Decompiled File: captured.gsc
 * Game: Call of Duty: Advanced Warfare
 * Platform: PC
 * Function Count: 80
 * Decompile Time: 1275 ms
 * Timestamp: 4/22/2024 2:25:55 AM
*******************************************************************/

//Function Number: 1
main()
{
	maps\_utility::template_level("captured");
	maps\_utility::set_default_start("introdrive");
	maps\_utility::default_start(::start_introdrive);
	maps\_utility::add_start("introdrive",::start_introdrive,"Intro Drive",::main_introdrive);
	maps\_utility::add_start("s1elevator",::start_s1elevator,"S1 Elevator",::main_s1elevator);
	maps\_utility::add_start("s2walk",::start_s2walk,"S2 Walk",::main_s2walk);
	maps\_utility::add_start("s2elevator",::start_s2elevator,"S2 Elevator",::main_s2elevator);
	maps\_utility::add_start("s3interrogate",::start_s3interrogate,"Interrogation",::main_s3interrogate);
	maps\_utility::add_start("s3escape",::start_s3escape,"Escape",::main_s3escape);
	maps\_utility::add_start("test_chamber",::start_test_chamber,"Test Chamber",::main_test_chamber);
	maps\_utility::add_start("autopsy_halls",::start_autopsy_halls,"Halls to Autopsy",::main_autopsy_halls);
	maps\_utility::add_start("autopsy",::start_autopsy,"Autopsy",::main_autopsy);
	maps\_utility::add_start("incinerator",::start_incinerator,"Incinerator",::main_incinerator);
	maps\_utility::add_start("battle_to_heli",::start_battle_to_heli,"Battle to Heli",::main_battle_to_heli);
	maps\_utility::add_start("run_to_heli",::start_run_to_heli,"Run to Heli",::main_run_to_heli);
	maps\_utility::add_start("heliride",::start_heliride,"Heli Ride",::main_heliride);
	maps\_utility::add_start("mb1_intro",::start_mb1_intro,"Mech Battle Intro",::main_mb1_intro);
	maps\_utility::add_start("mb1_mech",::start_mb1_mech,"Mech Battle Get In Mech",::main_mb1_mech);
	maps\_utility::add_start("mb1_jump",::start_mb1_jump,"Mech Battle Jump",::main_mb1_jump);
	maps\_utility::add_start("mb1",::start_mb1,"Mech Battle 1: Construction",::main_mb1);
	maps\_utility::add_start("mb2_gatesmash",::start_mb2_gatesmash,"Mech Battle 2: Gate Crash",::main_mb2_gatesmash);
	maps\_utility::add_start("mb2",::start_mb2,"Mech Battle 2: Warehouse",::main_mb2);
	maps\_utility::add_start("gatedoor",::start_gatedoor,"Gate Door",::main_gatedoor);
	maps\_utility::add_start("end_escape",::start_end_escape,"Ending Escape",::main_end_escape);
	if(level.currentgen)
	{
		tff_start_points();
		maps\_utility::tff_sync_setup();
	}

	pre_load();
	maps\_load::main();
	thread maps\_player_exo::main("specialist",0,0);
	maps\_player_exo::player_exo_remove_single("shield");
	post_load();
	thread maps\_drone_civilian::init();
	thread maps\_drone_ai::init();
	if(level.currentgen)
	{
		tff_transitions();
		tff_blockers();
	}

	if(level.currentgen)
	{
		setsaveddvar("r_gunSightColorEntityScale","7");
		setsaveddvar("r_gunSightColorNoneScale","0.8");
	}

	common_scripts\utility::flag_wait("flag_end_escape_end");
	maps\_utility::nextmission();
}

//Function Number: 2
tff_start_points()
{
	var_00 = ["captured_intro_drive_tr"];
	maps\_utility::set_start_transients("introdrive",var_00);
	maps\_utility::set_start_transients("s1elevator",var_00);
	var_00[0] = "captured_s2walk_tr";
	maps\_utility::set_start_transients("s2walk",var_00);
	maps\_utility::set_start_transients("s2elevator",var_00);
	var_00[0] = "captured_interrogate_tr";
	maps\_utility::set_start_transients("s3trolley",var_00);
	maps\_utility::set_start_transients("s3interrogate",var_00);
	var_00[1] = "captured_escape_tr";
	maps\_utility::set_start_transients("s3escape",var_00);
	var_00 = ["captured_escape_tr"];
	maps\_utility::set_start_transients("test_chamber",var_00);
	var_00[0] = "captured_test_chamber_tr";
	var_00[1] = "captured_autopsy_halls_tr";
	maps\_utility::set_start_transients("autopsy_halls",var_00);
	var_00 = ["captured_autopsy_tr"];
	maps\_utility::set_start_transients("autopsy",var_00);
	maps\_utility::set_start_transients("incinerator",var_00);
	var_00[0] = "captured_incinerator_tr";
	maps\_utility::set_start_transients("battle_to_heli",var_00);
	var_00[0] = "captured_helipad_tr";
	maps\_utility::set_start_transients("run_to_heli",var_00);
	maps\_utility::set_start_transients("heliride",var_00);
	var_00[0] = "captured_mechbattle_tr";
	maps\_utility::set_start_transients("mb1_intro",var_00);
	maps\_utility::set_start_transients("mb1_mech",var_00);
	maps\_utility::set_start_transients("mb1_jump",var_00);
	maps\_utility::set_start_transients("mb1",var_00);
	maps\_utility::set_start_transients("mb2_gatesmash",var_00);
	maps\_utility::set_start_transients("mb2",var_00);
	maps\_utility::set_start_transients("gatedoor",var_00);
	maps\_utility::set_start_transients("end_escape",var_00);
}

//Function Number: 3
tff_blockers()
{
	thread tff_blocker_incinerator();
	thread tff_blocker_incinerator_to_helipad();
}

//Function Number: 4
tff_blocker_incinerator()
{
	var_00 = getent("tff_incinerator_door","targetname");
	var_01 = getent("tff_incinerator_door_coll","targetname");
	var_02 = (0,0,100);
	if(!level.currentgen)
	{
		var_00 hide();
		level waittill("tff_post_incinerator_to_helipad");
		var_00 show();
		var_01.origin = var_01.origin + var_02;
		return;
	}

	var_03 = getent("vol_incinerator_exit_door","targetname");
	var_01.origin = var_01.origin + var_02;
	level.ally pushplayer(1);
	common_scripts\utility::flag_wait("flag_incinerator_end");
	while(!level.ally istouching(var_03))
	{
		wait(0.2);
	}

	var_00 moveto(var_00.origin + (0,-64,0),0.5);
	var_01.origin = var_01.origin + (0,-64,0);
	soundscripts\_snd::snd_message("aud_door","post_incin","open");
	level waittill("flag_tff_trans_incinerator_to_helipad");
	soundscripts\_snd::snd_message("aud_door","post_incin","close");
	var_00 moveto(var_00.origin + (0,64,0),0.5);
	var_01.origin = var_01.origin + (0,64,0);
	level.ally pushplayer(0);
}

//Function Number: 5
tff_blocker_incinerator_to_helipad()
{
	var_00 = getent("tff_incinerator_to_helipad_door","targetname");
	var_01 = getent("tff_incinerator_to_helipad_door_coll","targetname");
	var_02 = (0,56,0);
	var_01 disconnectpaths();
	level waittill("tff_post_incinerator_to_helipad");
	soundscripts\_snd::snd_message("aud_door","battle_to_heli","open");
	var_00 moveto(var_00.origin + var_02,0.5);
	var_01 connectpaths();
	var_01 moveto(var_01.origin + var_02,0.5);
}

//Function Number: 6
tff_transitions()
{
	if(!istransientloaded("captured_s2walk_tr"))
	{
		thread tff_trans_intro_drive_to_s2walk();
	}

	if(!istransientloaded("captured_interrogate_tr"))
	{
		thread tff_trans_s2walk_to_interrogate();
	}

	if(!istransientloaded("captured_escape_tr"))
	{
		thread tff_trans_load_escape();
	}

	if(!istransientloaded("captured_escape_tr") || istransientloaded("captured_interrogate_tr"))
	{
		thread tff_trans_unload_interrogate();
	}

	if(!istransientloaded("captured_test_chamber_tr"))
	{
		thread tff_trans_escape_to_test_chamber();
	}

	if(!istransientloaded("captured_autopsy_halls_tr"))
	{
		thread tff_trans_load_autopsy_halls();
	}

	if(!istransientloaded("captured_autopsy_halls_tr") || istransientloaded("captured_test_chamber_tr"))
	{
		thread tff_trans_unload_test_chamber();
	}

	if(!istransientloaded("captured_autopsy_tr"))
	{
		thread tff_trans_autopsy_halls_to_autopsy();
	}

	if(!istransientloaded("captured_helipad_tr"))
	{
		thread tff_trans_incinerator_to_helipad();
	}
}

//Function Number: 7
tff_trans_intro_drive_to_s2walk()
{
	common_scripts\utility::flag_wait("flag_start_s1elevator");
	level notify("tff_pre_intro_drive_to_s2walk");
	unloadtransient("captured_intro_drive_tr");
	loadtransient("captured_s2walk_tr");
	while(!istransientloaded("captured_s2walk_tr"))
	{
		wait(0.05);
	}

	level notify("tff_post_intro_drive_to_s2walk");
}

//Function Number: 8
tff_trans_s2walk_to_interrogate()
{
	level waittill("elevator_black");
	level notify("tff_pre_s2walk_to_interrogate");
	unloadtransient("captured_s2walk_tr");
	loadtransient("captured_interrogate_tr");
	while(!istransientloaded("captured_interrogate_tr"))
	{
		wait(0.05);
	}

	level notify("tff_post_s2walk_to_interrogate");
}

//Function Number: 9
tff_trans_load_escape()
{
	common_scripts\utility::flag_wait("flag_s3interrogate_end");
	loadtransient("captured_escape_tr");
	while(!istransientloaded("captured_escape_tr"))
	{
		wait(0.05);
	}

	level notify("tff_post_load_escape");
}

//Function Number: 10
tff_trans_unload_interrogate()
{
	common_scripts\utility::flag_wait("flag_tff_unload_interrogate");
	level notify("tff_pre_unload_interrogate");
	unloadtransient("captured_interrogate_tr");
}

//Function Number: 11
tff_trans_escape_to_test_chamber()
{
	common_scripts\utility::flag_wait("flag_tff_trans_escape_to_test_chamber");
	level notify("tff_pre_escape_to_test_chamber");
	unloadtransient("captured_escape_tr");
	loadtransient("captured_test_chamber_tr");
	while(!istransientloaded("captured_test_chamber_tr"))
	{
		wait(0.05);
	}

	level notify("tff_post_escape_to_test_chamber");
}

//Function Number: 12
tff_trans_load_autopsy_halls()
{
	common_scripts\utility::flag_wait("flag_tff_load_autopsy_halls");
	loadtransient("captured_autopsy_halls_tr");
	while(!istransientloaded("captured_autopsy_halls_tr"))
	{
		wait(0.05);
	}

	level notify("tff_post_load_autopsy_halls");
}

//Function Number: 13
tff_trans_unload_test_chamber()
{
	common_scripts\utility::flag_wait("flag_tff_unload_test_chamber");
	level.tcah_node maps\_anim::anim_first_frame(level.tcah_doors,"tc_enter_test_exit_door");
	level notify("tff_pre_unload_test_chamber");
	unloadtransient("captured_test_chamber_tr");
}

//Function Number: 14
tff_trans_autopsy_halls_to_autopsy()
{
	common_scripts\utility::flag_wait("tff_trans_autopsy_halls_to_autopsy");
	level notify("tff_pre_autopsy_halls_to_autopsy");
	unloadtransient("captured_autopsy_halls_tr");
	loadtransient("captured_autopsy_tr");
	while(!istransientloaded("captured_autopsy_tr"))
	{
		wait(0.05);
	}

	level notify("tff_post_autopsy_halls_to_autopsy");
}

//Function Number: 15
tff_trans_incinerator_to_helipad()
{
	common_scripts\utility::flag_wait("flag_tff_trans_incinerator_to_helipad");
	level notify("tff_pre_incinerator_to_helipad");
	unloadtransient("captured_incinerator_tr");
	loadtransient("captured_helipad_tr");
	while(!istransientloaded("captured_helipad_tr"))
	{
		wait(0.05);
	}

	level notify("tff_post_incinerator_to_helipad");
}

//Function Number: 16
pre_load()
{
	maps\createart\captured_art::main();
	maps\captured_fx::main();
	maps\captured_precache::main();
	maps\captured_anim::main();
	maps\captured_vo::main();
	precacheitem("iw5_titan45_sp");
	precacheitem("iw5_hmr9_sp");
	precacheitem("iw5_sn6_sp");
	precacheitem("iw5_mahem_sp");
	precacheitem("iw5_mahemstraight_sp");
	precacheitem("iw5_mahemcaptured");
	precachemodel("s1_captured_handcuffs");
	precachemodel("s1_vm_handcuffs");
	precachemodel("cap_hanging_bodybag");
	precachemodel("vehicle_xh9_warbird_interior_collision");
	precachemodel("vehicle_xh9_warbird_interior_glass");
	precachemodel("vehicle_xh9_warbird_interior_glass_brkn");
	precachemodel("viewhands_playermech_dmg1");
	precachemodel("cpt_s1_crash_debris");
	precachemodel("npc_exo_armor_minigun_whole");
	precachemodel("cap_hanging_bodybag_clean");
	precachemodel("cap_hanging_bodybag_clean_b");
	precachemodel("cap_hanging_bodybag_clean_c");
	precachemodel("cap_hanging_bodybag_02_clean");
	precachemodel("cap_hanging_bodybag_02_clean_b");
	precachemodel("cap_hanging_bodybag_02_clean_c");
	precachemodel("cap_hanging_bodybag");
	precachemodel("cap_hanging_bodybag_02");
	precachemodel("cap_hanging_bodybag_b");
	precachemodel("cap_hanging_bodybag_c");
	precachemodel("cap_hanging_bodybag_02_b");
	precachemodel("cap_hanging_bodybag_02_c");
	precachemodel("cap_morgue_body_c");
	precacheitem("iw5_kvahazmatknifeonearm_sp");
	precacheitem("iw5_titan45onearmgundown_sp");
	precacheitem("iw5_titan45onearm_sp");
	precacheitem("iw5_titan45pickup_sp");
	precacheitem("iw5_hmr9onearm_sp");
	precacheitem("iw5_hmr9pickup_sp");
	precacheitem("iw5_sn6onearm_sp");
	precacheitem("iw5_sn6pickup_sp");
	precacherumble("light_1s");
	precacherumble("light_2s");
	precacherumble("light_3s");
	precacherumble("heavy_1s");
	precacherumble("heavy_2s");
	precacherumble("heavy_3s");
	precacherumble("steady_rumble");
	precacherumble("ie_vtol_rumble");
	precacherumble("ie_vtol_ride_rumble");
	precacherumble("ie_vtol_ride_rumble_low");
	precacherumble("damage_light");
	precacherumble("damage_heavy");
	precacherumble("warbird_flyby");
	precacherumble("silencer_fire");
	precacherumble("subtle_tank_rumble");
	animscripts\traverse\boost::precache_boost_fx_npc();
	level.pmc_alljuggernauts = 0;
	level.noautosaveammocheck = 1;
	maps\captured_introdrive::pre_load();
	maps\captured_s2walk::pre_load();
	maps\captured_s3::pre_load();
	maps\captured_medical::pre_load();
	maps\captured_facility::pre_load();
	maps\captured_mech::pre_load();
	maps\captured_exit::pre_load();
	maps\captured_end_escape::pre_load();
	setsaveddvar("use_new_sva_system",1);
}

//Function Number: 17
post_load()
{
	common_scripts\utility::flag_init("intro_fade_in_complete");
	common_scripts\utility::flag_init("flag_introdrive_end");
	common_scripts\utility::flag_init("flag_s1elevator_end");
	common_scripts\utility::flag_init("flag_s2walk_end");
	common_scripts\utility::flag_init("flag_s2elevator_end");
	common_scripts\utility::flag_init("flag_s3interrogate_end");
	common_scripts\utility::flag_init("flag_s3escape_end");
	common_scripts\utility::flag_init("flag_test_chamber_end");
	common_scripts\utility::flag_init("flag_autopsy_halls_end");
	common_scripts\utility::flag_init("flag_autopsy_end");
	common_scripts\utility::flag_init("flag_incinerator_end");
	common_scripts\utility::flag_init("flag_battle_to_heli_end");
	common_scripts\utility::flag_init("flag_heliride_end");
	common_scripts\utility::flag_init("flag_end_escape_end");
	common_scripts\utility::flag_init("s3_escape_hurry_up_move_done");
	common_scripts\utility::flag_init("flag_exit_lock_broken");
	common_scripts\utility::flag_init("flag_heliride_warbird_mount");
	common_scripts\utility::flag_init("flag_one_handed_help_try");
	common_scripts\utility::flag_init("flag_currently_nagging");
	if(level.currentgen)
	{
		common_scripts\utility::flag_init("flag_tff_unload_interrogate");
		common_scripts\utility::flag_init("tff_trans_autopsy_halls_to_autopsy");
	}

	createthreatbiasgroup("playerseek");
	createthreatbiasgroup("civkill");
	createthreatbiasgroup("player");
	level.player setthreatbiasgroup("player");
	level.friendlynamedist = getdvarint("g_friendlyNameDist");
	level.player.exclusive["exo_melee"] = 0;
	maps\captured_aud::main();
	maps\captured_introdrive::post_load();
	maps\captured_s2walk::post_load();
	maps\captured_s3::post_load();
	maps\captured_medical::post_load();
	maps\captured_facility::post_load();
	maps\captured_mech::post_load();
	maps\captured_exit::post_load();
	maps\captured_end_escape::post_load();
	maps\captured_util::spawn_allies();
	var_00 = getspawnerteamarray("axis");
	maps\_utility::array_spawn_function(var_00,::maps\_utility::disable_long_death);
	level.nextgrenadedrop = 573000;
	thread objective_string_precache();
	thread objectives();
	thread object_control();
	thread spawn_functions();
	thread dialogue();
	maps\captured_lighting::main();
	common_scripts\utility::array_thread(getentarray("model_large_fan","script_noteworthy"),::maps\captured_util::ambient_fan_rotate);
}

//Function Number: 18
spawn_functions()
{
	if(level.currentgen)
	{
		level.prisoner_randomizer = [1,2,3,4,5,6];
	}
	else
	{
		level.prisoner_randomizer = [1,2,3,4,5,6,7,8,9];
	}

	thread maps\captured_anim::captured_ambient_animation_setup("exterior_ambient_prisoner");
	thread maps\captured_anim::captured_ambient_animation_setup("exterior_ambient_guard");
	thread maps\captured_anim::captured_ambient_animation_setup("exterior_ambient_mech");
	var_00 = getentarray("actor_civilian_worker_hardhat_s1","classname");
	foreach(var_02 in var_00)
	{
		var_02 maps\_utility::add_spawn_function(::maps\captured_util::captured_worker_weapons);
	}
}

//Function Number: 19
objective_string_precache()
{
	precachestring(&"CAPTURED_OBJECTIVE_USE");
	precachestring(&"CAPTURED_OBJECTIVE_TAKE");
	precachestring(&"CAPTURED_OBJECTIVE_PUSH");
	precachestring(&"CAPTURED_OBJECTIVE_OPEN");
	precachestring(&"CAPTURED_OBJECTIVE_BREAK");
	precachestring(&"CAPTURED_OBJECTIVE_LOOK");
	precachestring(&"CAPTURED_OBJECTIVE_ENTER");
	precachestring(&"CAPTURED_OBJ_ESCAPE");
	precachestring(&"CAPTURED_OBJ_FOLLOW_GIDEON");
	precachestring(&"CAPTURED_OBJ_ELEVATOR");
	precachestring(&"CAPTURED_OBJ_GET_TO_WARBIRD");
	precachestring(&"CAPTURED_OBJ_AST");
	precachestring(&"CAPTURED_OBJ_REGROUP");
	precachestring(&"CAPTURED_FAIL_GIDEON_KILLED");
	precachestring(&"CAPTURED_FAIL_AUTOPSY_ESCAPE");
	precachestring(&"CAPTURED_FAIL_INNOCENT");
	precachestring(&"CAPTURED_FAIL_UNARMED");
	precachestring(&"CAPTURED_FAIL_OUT_OF_LINE");
	precachestring(&"CAPTURED_HINT_USE_CONSOLE");
	precachestring(&"CAPTURED_HINT_USE_PC");
	precachestring(&"CAPTURED_HINT_PUSH_CONSOLE");
	precachestring(&"CAPTURED_HINT_PUSH_PC");
	precachestring(&"CAPTURED_HINT_OPEN_CONSOLE");
	precachestring(&"CAPTURED_HINT_OPEN_PC");
	precachestring(&"CAPTURED_HINT_TAKE_CONSOLE");
	precachestring(&"CAPTURED_HINT_TAKE_PC");
	precachestring(&"CAPTURED_HINT_ENTER_CONSOLE");
	precachestring(&"CAPTURED_HINT_ENTER_PC");
	precachestring(&"CAPTURED_HINT_BREAK_CONSOLE");
	precachestring(&"CAPTURED_HINT_BREAK_PC");
	maps\_utility::add_control_based_hint_strings("use_console",&"CAPTURED_HINT_USE_CONSOLE",::maps\captured_actions::captured_use_console,&"CAPTURED_HINT_USE_PC");
	maps\_utility::add_control_based_hint_strings("push_cart",&"CAPTURED_HINT_PUSH_CONSOLE",::maps\captured_actions::captured_push_cart,&"CAPTURED_HINT_PUSH_PC");
	maps\_utility::add_control_based_hint_strings("open_door",&"CAPTURED_HINT_OPEN_CONSOLE",::maps\captured_actions::captured_open_door,&"CAPTURED_HINT_OPEN_PC");
	maps\_utility::add_control_based_hint_strings("take_exo",&"CAPTURED_HINT_TAKE_CONSOLE",::maps\captured_actions::captured_take_exo,&"CAPTURED_HINT_TAKE_PC");
	maps\_utility::add_control_based_hint_strings("enter_exo",&"CAPTURED_HINT_ENTER_CONSOLE",::maps\captured_actions::captured_enter_exo,&"CAPTURED_HINT_ENTER_PC");
	maps\_utility::add_control_based_hint_strings("break_lock",&"CAPTURED_HINT_BREAK_CONSOLE",::maps\captured_actions::captured_break_lock,&"CAPTURED_HINT_BREAK_PC");
}

//Function Number: 20
objectives()
{
	switch(level.start_point)
	{
		case "introdrive":
			common_scripts\utility::flag_wait("flag_introdrive_end");
			break;

		case "s1elevator":
			common_scripts\utility::flag_wait("flag_s1elevator_end");
			break;

		case "s2walk":
			common_scripts\utility::flag_wait("flag_s2walk_end");
			break;

		case "s2elevator":
			common_scripts\utility::flag_wait("flag_s2elevator_end");
			break;

		case "s3trolley":
		case "s3interrogate":
			common_scripts\utility::flag_wait("flag_s3interrogate_end");
			break;

		case "s3escape":
			objective_add(maps\_utility::obj("obj_escape"),"current",&"CAPTURED_OBJ_ESCAPE");
			level waittill("leave_interrogation_room");
			objective_state_nomessage(maps\_utility::obj("obj_escape"),"active");
			objective_add(maps\_utility::obj("obj_follow"),"current",&"CAPTURED_OBJ_FOLLOW_GIDEON");
			level waittill("s3_escape_guard_down");
			objective_add(maps\_utility::obj("obj_weapon"),"invisible");
			objective_state_nomessage(maps\_utility::obj("obj_weapon"),"current");
			objective_state_nomessage(maps\_utility::obj("obj_follow"),"current");
			objective_setpointertextoverride(maps\_utility::obj("obj_weapon"),&"CAPTURED_OBJECTIVE_TAKE");
			objective_position(maps\_utility::obj("obj_weapon"),(0,0,0));
			var_00 = common_scripts\utility::getstruct("s3_escape_get_weapon_marker","targetname");
			objective_position(maps\_utility::obj("obj_weapon"),var_00.origin);
			level waittill("captured_action_complete");
			objective_delete(maps\_utility::obj("obj_weapon"));
			common_scripts\utility::flag_wait("s3_escape_hurry_up_move_done");
			maps\_utility::objective_complete(maps\_utility::obj("obj_follow"));
			objective_add(maps\_utility::obj("obj_hack"),"current",&"CAPTURED_OBJ_ELEVATOR");
			objective_add(maps\_utility::obj("obj_hack_pointer"),"invisible");
			objective_state_nomessage(maps\_utility::obj("obj_hack_pointer"),"current");
			objective_state_nomessage(maps\_utility::obj("obj_hack"),"current");
			objective_setpointertextoverride(maps\_utility::obj("obj_hack_pointer"),&"CAPTURED_OBJECTIVE_USE");
			objective_position(maps\_utility::obj("obj_hack_pointer"),(0,0,0));
			var_00 = common_scripts\utility::getstruct("s3_escape_console_use_marker","targetname");
			objective_position(maps\_utility::obj("obj_hack_pointer"),var_00.origin);
			level waittill("captured_action_complete");
			objective_delete(maps\_utility::obj("obj_hack_pointer"));
			common_scripts\utility::flag_wait("s3_escape_exit_door_open");
			maps\_utility::objective_complete(maps\_utility::obj("obj_hack"));
			level waittill("split_scene_start");
			wait(10);
			objective_state(maps\_utility::obj("obj_escape"),"current");
			break;

		case "test_chamber":
			common_scripts\utility::flag_wait("flag_test_chamber_end");
			break;

		case "autopsy_halls":
			level waittill("obj_exit_morgue");
			var_01 = common_scripts\utility::getstruct("obj_doors_to_autopsy","targetname");
			objective_add(maps\_utility::obj("obj_into_autopsy"),"invisible","",var_01.origin);
			objective_state_nomessage(maps\_utility::obj("obj_into_autopsy"),"current");
			objective_state_nomessage(maps\_utility::obj("obj_escape"),"current");
			common_scripts\utility::flag_wait("flag_autopsy_enter");
			objective_delete(maps\_utility::obj("obj_into_autopsy"));
			break;

		case "autopsy":
			common_scripts\utility::flag_wait("flag_autopsy_safe_to_open_door");
			objective_add(maps\_utility::obj("obj_aut_door"),"invisible");
			objective_state_nomessage(maps\_utility::obj("obj_aut_door"),"current");
			objective_state_nomessage(maps\_utility::obj("obj_escape"),"current");
			objective_setpointertextoverride(maps\_utility::obj("obj_aut_door"),&"CAPTURED_OBJECTIVE_OPEN");
			objective_position(maps\_utility::obj("obj_aut_door"),(0,0,0));
			var_02 = common_scripts\utility::getstruct("struct_vign_autopsy_doctor_door","targetname");
			objective_position(maps\_utility::obj("obj_aut_door"),var_02.origin + (0,-14,51));
			level waittill("captured_action_complete");
			objective_delete(maps\_utility::obj("obj_aut_door"));
			common_scripts\utility::flag_wait("flag_autopsy_chute");
			wait(1);
			objective_add(maps\_utility::obj("obj_aut_escape"),"invisible");
			objective_state_nomessage(maps\_utility::obj("obj_aut_escape"),"current");
			objective_state_nomessage(maps\_utility::obj("obj_escape"),"current");
			objective_position(maps\_utility::obj("obj_aut_escape"),(0,0,0));
			var_03 = common_scripts\utility::getstruct("aut_doctor_hatch_node","targetname");
			objective_position(maps\_utility::obj("obj_aut_escape"),var_03.origin + (0,0,-20));
			level waittill("autopsy_player_jumping_into_hatch");
			objective_delete(maps\_utility::obj("obj_aut_escape"));
			common_scripts\utility::flag_wait("flag_autopsy_end");
			break;

		case "incinerator":
			common_scripts\utility::flag_wait("flag_incinerator_fires_start");
			wait(12);
			objective_add(maps\_utility::obj("obj_escape_incinerator"),"invisible");
			objective_state_nomessage(maps\_utility::obj("obj_escape_incinerator"),"current");
			objective_state_nomessage(maps\_utility::obj("obj_escape"),"current");
			level waittill("incineratory_usable");
			objective_setpointertextoverride(maps\_utility::obj("obj_escape_incinerator"),&"CAPTURED_OBJECTIVE_PUSH");
			objective_position(maps\_utility::obj("obj_escape_incinerator"),(0,0,0));
			var_04 = common_scripts\utility::getstruct("struct_anim_incinerator","targetname");
			objective_position(maps\_utility::obj("obj_escape_incinerator"),var_04.origin + (-40,20,-20));
			level waittill("captured_action_complete");
			maps\_utility::objective_clearadditionalpositions(maps\_utility::obj("obj_escape_incinerator"));
			maps\_utility::trigger_wait("trig_incinerator_leave","targetname");
			objective_delete(maps\_utility::obj("obj_escape_incinerator"));
			common_scripts\utility::flag_wait("flag_incinerator_end");
			break;

		case "battle_to_heli":
			common_scripts\utility::flag_wait("flag_bh_pit");
			break;

		case "run_to_heli":
			maps\_utility::objective_complete(maps\_utility::obj("obj_escape"));
			objective_add(maps\_utility::obj("obj_chopper"),"current",&"CAPTURED_OBJ_GET_TO_WARBIRD");
			common_scripts\utility::flag_wait("flag_bh_run");
			objective_onentity(maps\_utility::obj("obj_chopper"),level._facility.warbird,(0,0,50));
			common_scripts\utility::flag_wait("flag_heliride_warbird_mount");
			if(!level.missionfailed)
			{
				maps\_utility::objective_complete(maps\_utility::obj("obj_chopper"));
			}
	
			break;

		case "heliride":
			common_scripts\utility::flag_wait("flag_heliride_end");
			break;

		case "mb1_intro":
			level waittill("objective_player_can_get_into_mech");
			objective_add(maps\_utility::obj("obj_into_mech"),"current",&"CAPTURED_OBJ_AST");
			objective_setpointertextoverride(maps\_utility::obj("obj_into_mech"),&"CAPTURED_OBJECTIVE_ENTER");
			var_05 = common_scripts\utility::getstruct("struct_prompt_mechenter","targetname");
			objective_position(maps\_utility::obj("obj_into_mech"),var_05.origin);
			level waittill("captured_action_complete");
			maps\_utility::objective_complete(maps\_utility::obj("obj_into_mech"));
			common_scripts\utility::flag_wait("flag_mech_enabled");
			objective_add(maps\_utility::obj("obj_regroup"),"current",&"CAPTURED_OBJ_REGROUP");
			wait(1);
			objective_add(maps\_utility::obj("obj_mech_run_through"),"invisible");
			objective_state_nomessage(maps\_utility::obj("obj_mech_run_through"),"current");
			objective_state_nomessage(maps\_utility::obj("obj_regroup"),"current");
			objective_position(maps\_utility::obj("obj_mech_run_through"),(0,0,0));
			var_06 = common_scripts\utility::getstruct("struct_mb1_introwall_smash","targetname");
			objective_position(maps\_utility::obj("obj_mech_run_through"),var_06.origin + (0,0,60));
			common_scripts\utility::flag_wait("flag_mb1_start");
			objective_delete(maps\_utility::obj("obj_mech_run_through"));
			break;

		case "mb2_gatesmash":
		case "mb1":
		case "mb1_jump":
		case "mb1_mech":
			common_scripts\utility::flag_wait("flag_mb1_end");
			maps\_utility::objective_complete(maps\_utility::obj("obj_mech"));
			wait(3);
			objective_add(maps\_utility::obj("obj_mech_smash_doors"),"invisible");
			objective_state_nomessage(maps\_utility::obj("obj_mech_smash_doors"),"current");
			objective_state_nomessage(maps\_utility::obj("obj_regroup"),"current");
			objective_position(maps\_utility::obj("obj_mech_smash_doors"),(0,0,0));
			var_07 = common_scripts\utility::getstruct("mech_door_objective_marker","targetname") common_scripts\utility::spawn_tag_origin();
			objective_position(maps\_utility::obj("obj_mech_smash_doors"),var_07.origin);
			common_scripts\utility::flag_wait("flag_mb2_mech_smashing_doors");
			objective_delete(maps\_utility::obj("obj_mech_smash_doors"));
			var_07 delete();
			break;

		case "mb2":
			common_scripts\utility::flag_wait("flag_mb2_end");
			break;

		case "gatedoor":
			wait(5);
			objective_add(maps\_utility::obj("obj_open_exitdoor"),"invisible");
			objective_state_nomessage(maps\_utility::obj("obj_open_exitdoor"),"current");
			objective_state_nomessage(maps\_utility::obj("obj_regroup"),"current");
			objective_position(maps\_utility::obj("obj_open_exitdoor"),(0,0,0));
			objective_setpointertextoverride(maps\_utility::obj("obj_open_exitdoor"),&"CAPTURED_OBJECTIVE_BREAK");
			var_08 = common_scripts\utility::getstruct("mech_gate_lock_hint","targetname");
			objective_position(maps\_utility::obj("obj_open_exitdoor"),var_08.origin);
			common_scripts\utility::flag_wait("flag_exit_lock_broken");
			objective_delete(maps\_utility::obj("obj_open_exitdoor"));
			level.player waittill("exit_anim_done");
			break;

		case "end_escape":
			if(level.start_point == "end_escape")
			{
				objective_add(maps\_utility::obj("obj_regroup"),"current",&"CAPTURED_OBJ_REGROUP");
			}
	
			wait(19);
			maps\_utility::objective_complete(maps\_utility::obj("obj_regroup"));
			break;

		default:
			break;
	}
}

//Function Number: 21
object_control()
{
	switch(level.start_point)
	{
		case "introdrive":
			common_scripts\utility::flag_wait("flag_introdrive_end");
			break;

		case "s1elevator":
			common_scripts\utility::flag_wait("flag_s1elevator_end");
			break;

		case "s2walk":
			common_scripts\utility::flag_wait("flag_s2walk_end");
			break;

		case "s2elevator":
			common_scripts\utility::flag_wait("flag_s2elevator_end");
			break;

		case "s3trolley":
		case "s3interrogate":
			common_scripts\utility::flag_wait("flag_s3interrogate_end");
			break;

		case "s3escape":
			common_scripts\utility::flag_wait("flag_s3escape_end");
			break;

		case "test_chamber":
			common_scripts\utility::flag_wait("flag_test_chamber_end");
			break;

		case "autopsy_halls":
			common_scripts\utility::flag_wait("flag_autopsy_halls_end");
			break;

		case "autopsy":
			common_scripts\utility::flag_wait("flag_autopsy_end");
			break;

		case "incinerator":
			common_scripts\utility::flag_wait("flag_incinerator_end");
			thread maps\captured_medical::autopsy_cleanup();
			break;

		case "run_to_heli":
		case "battle_to_heli":
			common_scripts\utility::flag_wait("flag_battle_to_heli_end");
			break;

		case "heliride":
			common_scripts\utility::flag_wait("flag_heliride_end");
			break;

		case "end_escape":
		case "gatedoor":
		case "mb2":
		case "mb2_gatesmash":
		case "mb1":
		case "mb1_jump":
		case "mb1_mech":
		case "mb1_intro":
			common_scripts\utility::flag_wait("flag_end_escape_end");
			break;

		default:
			break;
	}
}

//Function Number: 22
start_introdrive()
{
	maps\captured_introdrive::start();
}

//Function Number: 23
main_introdrive()
{
	thread introscreen();
	maps\captured_introdrive::main_introdrive();
}

//Function Number: 24
start_s1elevator()
{
	maps\captured_introdrive::start();
}

//Function Number: 25
main_s1elevator()
{
	maps\_utility::autosave_now();
	maps\captured_introdrive::main_s1elevator();
}

//Function Number: 26
start_s2walk()
{
	maps\captured_s2walk::start();
}

//Function Number: 27
main_s2walk()
{
	maps\_utility::autosave_by_name("s2walk");
	maps\captured_s2walk::main_s2walk();
}

//Function Number: 28
start_s2elevator()
{
	maps\captured_s2walk::start();
}

//Function Number: 29
main_s2elevator()
{
	maps\_utility::autosave_by_name("s2elevator");
	maps\captured_s2walk::main_s2elevator();
}

//Function Number: 30
start_s3trolley()
{
	maps\captured_s3::start("struct_playerstart_s3trolley");
}

//Function Number: 31
main_s3trolley()
{
	maps\_utility::autosave_by_name("s3trolley");
	maps\captured_s3::main_s3trolley();
}

//Function Number: 32
start_s3interrogate()
{
	maps\captured_s3::start("struct_playerstart_s3interrogate");
}

//Function Number: 33
main_s3interrogate()
{
	maps\_utility::autosave_by_name("s3interrogate");
	maps\captured_s3::main_s3interrogate();
}

//Function Number: 34
start_s3escape()
{
	soundscripts\_snd::snd_message("start_escape");
	maps\captured_s3::start("struct_playerstart_s3escape");
}

//Function Number: 35
main_s3escape()
{
	maps\captured_s3::main_s3escape();
}

//Function Number: 36
start_test_chamber()
{
	maps\captured_medical::start_test_chamber();
}

//Function Number: 37
main_test_chamber()
{
	maps\_utility::autosave_by_name("test_chamber");
	maps\captured_medical::main_test_chamber();
}

//Function Number: 38
start_autopsy_halls()
{
	maps\captured_medical::start_autopsy_halls();
}

//Function Number: 39
main_autopsy_halls()
{
	maps\_utility::autosave_by_name("autopsy_halls");
	maps\captured_medical::main_autopsy_halls();
}

//Function Number: 40
start_autopsy()
{
	maps\captured_medical::start_autopsy();
}

//Function Number: 41
main_autopsy()
{
	maps\_utility::autosave_by_name("autopsy");
	maps\captured_medical::main_autopsy();
}

//Function Number: 42
start_incinerator()
{
	maps\captured_facility::start_incinerator();
}

//Function Number: 43
main_incinerator()
{
	maps\captured_facility::main_incinerator();
}

//Function Number: 44
start_battle_to_heli()
{
	maps\captured_facility::start_battle_to_heli();
}

//Function Number: 45
main_battle_to_heli()
{
	maps\_utility::autosave_by_name("battle_to_heli");
	maps\captured_facility::main_battle_to_heli();
}

//Function Number: 46
start_run_to_heli()
{
	maps\captured_facility::start_run_to_heli();
}

//Function Number: 47
main_run_to_heli()
{
	maps\captured_facility::main_run_to_heli();
}

//Function Number: 48
start_heliride()
{
	maps\captured_facility::start("struct_playerstart_heliride");
}

//Function Number: 49
main_heliride()
{
	maps\captured_facility::main_heliride();
}

//Function Number: 50
start_mb1_intro()
{
	maps\captured_mech::start("struct_playerstart_mb1_intro","struct_allystart_mb1");
}

//Function Number: 51
start_mb1_mech()
{
	maps\captured_mech::start("struct_playerstart_mb1_intro","struct_allystart_mb1");
}

//Function Number: 52
start_mb1_jump()
{
	maps\captured_mech::start("struct_playerstart_mb1_jump","struct_allystart_mb1");
}

//Function Number: 53
start_mb1()
{
	maps\captured_mech::start("struct_playerstart_mb1","struct_allystart_mb1");
}

//Function Number: 54
start_mb2()
{
	maps\captured_mech::start("struct_playerstart_mb2","struct_allystart_mb2");
}

//Function Number: 55
start_mb2_gatesmash()
{
	maps\captured_mech::start("struct_playerstart_mb2_gate","struct_allystart_mb2_gate");
}

//Function Number: 56
main_mb1_intro()
{
	maps\_utility::autosave_by_name("mb1_intro");
	maps\captured_mech::main_mb1_intro();
}

//Function Number: 57
main_mb1_mech()
{
	maps\_utility::autosave_by_name("mb1_mech");
	maps\captured_mech::main_mb1_mech();
}

//Function Number: 58
main_mb1_jump()
{
	maps\captured_mech::main_mb1_jump();
}

//Function Number: 59
main_mb1()
{
	maps\_utility::autosave_by_name("mb1");
	maps\captured_mech::main_mb1();
}

//Function Number: 60
main_mb2_gatesmash()
{
	maps\_utility::autosave_by_name("mb2_gate");
	maps\captured_mech::main_mb2_gatesmash();
}

//Function Number: 61
main_mb2()
{
	maps\_utility::autosave_by_name("mb2");
	maps\captured_mech::main_mb2();
}

//Function Number: 62
start_gatedoor()
{
	maps\captured_exit::start("struct_playerstart_gd","struct_allystart_gd");
}

//Function Number: 63
main_gatedoor()
{
	maps\_utility::autosave_by_name("gatedoor");
	maps\captured_exit::main_gd();
}

//Function Number: 64
start_end_escape()
{
	maps\captured_end_escape::start("struct_playerstart_end_escape","struct_allystart_end_escape");
}

//Function Number: 65
main_end_escape()
{
	maps\captured_end_escape::main_end_escape();
}

//Function Number: 66
introscreen()
{
	maps\_shg_utility::play_chyron_video("chyron_text_captured",3.6,3);
}

//Function Number: 67
dialogue()
{
	switch(level.start_point)
	{
		case "introdrive":
			thread dialogue_introdrive();
			wait(2);
			soundscripts\_snd::snd_message("entrance_vo_01");
			wait(5);
			wait(5);
			soundscripts\_snd::snd_message("entrance_vo_03");
			common_scripts\utility::flag_wait("flag_introdrive_end");
			break;

		case "s1elevator":
			common_scripts\utility::flag_wait("flag_start_s1elevator");
			wait(1);
			wait(2);
			common_scripts\utility::flag_wait("flag_s1elevator_end");
			break;

		case "s2walk":
			wait(9.5);
			thread dialogue_s2elevator_outside();
			common_scripts\utility::flag_wait("flag_s2walk_group_split");
			common_scripts\utility::flag_wait("flag_s2walk_end");
			break;

		case "s2elevator":
			common_scripts\utility::flag_wait("flag_player_in_s2s3_room");
			wait(2);
			common_scripts\utility::flag_wait("flag_s2elevator_end");
			break;

		case "s3trolley":
		case "s3interrogate":
			common_scripts\utility::flag_wait("flag_s3interrogate_end");
			break;

		case "s3escape":
			common_scripts\utility::flag_wait("flag_s3escape_end");
			break;

		case "test_chamber":
			level waittill("tc_stair_door_1");
			wait(3.5);
			level.allies[0] maps\_utility::dialogue_queue("cap_gdn_ifiknowilonashell");
			wait(1);
			level.allies[0] maps\_utility::dialogue_queue("cap_gdn_letsnotkeepherwaiting");
			level waittill("manticore_hall_vo");
			wait(1.25);
			soundscripts\_snd::snd_message("aud_observation_guard_radio");
			maps\_utility::wait_for_targetname_trigger("tc_ally_enters_observation");
			soundscripts\_snd_playsound::snd_play_at("cap_sc9_who",(4249,-11685,-1576));
			level.allies[0] maps\_utility::dialogue_queue("cap_gdn_staycalmshutup");
			common_scripts\utility::flag_wait("flag_tc_move_down");
			wait(4.65);
			level.allies[0] maps\_utility::smart_radio_dialogue("cap_iln_gideonareyouthere");
			level.allies[0] maps\_utility::dialogue_queue("cap_gdn_illonailonadoyou");
			thread dialogue_uv_bake_awcmon();
			level waittill("start_anim_tc_enter_test");
			level.tcah_node waittill("tc_enter_test_loop_ender");
			break;

		case "autopsy_halls":
			wait(1.75);
			level.allies[0] maps\_utility::dialogue_queue("cap_gdn_outofthewaymove");
			common_scripts\utility::flag_wait("flag_ah_combat_done");
			level waittill("vo_morgue_transition");
			wait(3);
			level.allies[0] maps\_utility::dialogue_queue("cap_gdn_wevegottakeepmoving");
			common_scripts\utility::flag_wait("flag_autopsy_halls_end");
			break;

		case "autopsy":
			common_scripts\utility::flag_wait("flag_autopsy_enter");
			wait(2.25);
			level.allies[0] maps\_utility::dialogue_queue("cap_gdn_ontheground");
			wait(1.4);
			level.allies[0] maps\_utility::dialogue_queue("cap_gdn_downnow");
			wait(4.5);
			level.allies[0] maps\_utility::dialogue_queue("cap_gdn_heyyou");
			wait(2);
			if(!common_scripts\utility::flag("flag_autopsy_doctor_door"))
			{
				var_00 = ["cap_gdn_comeongetthedoor","cap_gdn_overheremitchell","cap_gdn_cmonhelp"];
				level.ally thread maps\captured_util::dialogue_nag_loop(var_00,"doctor_door_weapon_hidden",3,5,4,6);
			}
			common_scripts\utility::flag_wait("flag_autopsy_end");
			break;

		case "incinerator":
			common_scripts\utility::flag_wait("flag_incinerator_saved");
			common_scripts\utility::flag_wait("flag_incinerator_fires_start");
			soundscripts\_snd::snd_message("incinerator_dialogue_2");
			wait(8);
			wait(3.25);
			wait(1.75);
			level.allies[0] maps\_utility::dialogue_queue("cap_gdn_weneedawayout");
			wait(1.25);
			level.allies[0] maps\_utility::dialogue_queue("cap_gdn_look");
			wait(2);
			level.allies[0] maps\_utility::dialogue_queue("cap_gdn_aventunderthis");
			common_scripts\utility::flag_wait("flag_incinerator_push_start");
			thread maps\captured_fx::fx_stop_pilot_lights();
			common_scripts\utility::flag_wait("flag_incinerator_push_done");
			wait(7.75);
			level.allies[0] maps\_utility::dialogue_queue("cap_gdn_moveit");
			common_scripts\utility::flag_wait("flag_incinerator_crawl_pull");
			wait(1);
			wait(2);
			maps\_utility::trigger_wait("trig_incinerator_leave","targetname");
			wait(2);
			wait(3);
			wait(8);
			level.allies[0] maps\_utility::dialogue_queue("cap_gdn_sunlightwerealmost");
			wait(1);
			level.allies[0] maps\_utility::dialogue_queue("cap_gdn_letshopetherestime");
			wait(1);
			level.allies[0] maps\_utility::smart_radio_dialogue("cap_iln_gideonitsilona");
			level.allies[0] maps\_utility::dialogue_queue("cap_gdn_goodworkwere");
			level.allies[0] maps\_utility::smart_radio_dialogue("cap_iln_hurrycormackisnt");
			break;

		case "battle_to_heli":
			common_scripts\utility::flag_wait("flag_bh_intro_start");
			if(!common_scripts\utility::flag("flag_bh_outside"))
			{
				level.allies[0] maps\_utility::dialogue_queue("cap_gdn_throughhere");
			}
	
			common_scripts\utility::flag_wait("flag_bh_intro_caught");
			if(!common_scripts\utility::flag("flag_bh_outside") && !common_scripts\utility::flag("flag_bh_intro_caught_late"))
			{
				level.allies[0] maps\_utility::dialogue_queue("cap_gdn_damn");
			}
	
			if(!common_scripts\utility::flag("flag_bh_outside"))
			{
				level.allies[0] maps\_utility::dialogue_queue("cap_gdn_othersideofthisdoor");
			}
	
			common_scripts\utility::flag_wait("flag_bh_pit");
			wait(0.5);
			level.allies[0] maps\_utility::dialogue_queue("cap_gdn_thathelothatsour");
			level waittill("bh_doors_manual");
			break;

		case "run_to_heli":
			level waittill("bh_ally_start_manticore_anims");
			wait(3);
			common_scripts\utility::flag_set("flag_currently_nagging");
			level.allies[0] maps\_utility::dialogue_queue("cap_gdn_thatsourridewhatthehell");
			common_scripts\utility::flag_clear("flag_currently_nagging");
			if(!common_scripts\utility::flag("flag_player_and_ally_at_window"))
			{
				wait(3);
				if(!common_scripts\utility::flag("flag_player_and_ally_at_window"))
				{
					var_00 = ["cap_gdn_damnmitchellover","cap_gdn_lookatthis"];
					level.ally thread maps\captured_util::dialogue_nag_loop(var_00,"end_manticore_nags",3,4,3,9);
					common_scripts\utility::flag_wait("flag_player_and_ally_at_window");
					level notify("end_manticore_nags");
				}
			}
	
			common_scripts\utility::flag_wait("flag_bh_run_ally_ready");
			level.allies[0] maps\_utility::dialogue_queue("cap_gdn_ready");
			wait(1);
			common_scripts\utility::flag_wait("flag_bh_run");
			level.allies[0] maps\_utility::dialogue_queue("cap_gdn_letsgorunforit");
			wait(2);
			if(!common_scripts\utility::flag("flag_battle_to_heli_end"))
			{
				level.allies[0] maps\_utility::dialogue_queue("cap_gdn_pushtothehelicopter");
			}
	
			break;

		case "heliride":
			common_scripts\utility::flag_wait("flag_heliride_warbird_mount");
			wait(4);
			common_scripts\utility::flag_wait("flag_heliride_end");
			break;

		case "mb1_intro":
			level waittill("anim_mech_wakeup");
			wait(9.5);
			level.allies[0] maps\_utility::dialogue_queue("cap_gdn_coughing");
			wait(4);
			wait(1.75);
			level.allies[0] maps\_utility::dialogue_queue("cap_gdn_watchit");
			wait(6.5);
			level.allies[0] maps\_utility::dialogue_queue("cap_gdn_stilllooksfunctional");
			wait(1.25);
			if(common_scripts\utility::flag_exist("flag_getting_into_mech"))
			{
				if(!common_scripts\utility::flag("flag_getting_into_mech"))
				{
					var_00 = ["cap_gdn_overheremitchell","cap_gdn_onyoumitchell"];
					level.ally thread maps\captured_util::dialogue_nag_loop(var_00,"captured_action_complete",8,12,3,6);
				}
			}
	
			break;

		case "end_escape":
		case "gatedoor":
		case "mb2":
		case "mb2_gatesmash":
		case "mb1":
		case "mb1_jump":
		case "mb1_mech":
			common_scripts\utility::flag_wait("flag_end_escape_end");
			break;

		default:
			break;
	}
}

//Function Number: 68
dialogue_introdrive()
{
}

//Function Number: 69
dialogue_s1elevator_outside(param_00,param_01)
{
	var_02 = param_00[0];
	var_03 = param_00[1];
	var_04 = param_00[2];
	var_05 = param_01;
	level waittill("s1_drive_guards_start");
	var_03 maps\_utility::delaythread(1,::maps\_utility::dialogue_queue,"cap_gr1_everyoneoffthetruck");
	wait(8);
	soundscripts\_snd_playsound::snd_play_at("cap_gr1_cmonguysgetem",(5472,-5008,32));
	wait(5.5);
	var_05 maps\_utility::dialogue_queue("cap_gr2_thatsallofem");
	var_05 thread maps\_utility::dialogue_queue("cap_gr3_mover12youreall");
	wait(2);
	var_03 maps\_utility::dialogue_queue("cap_gr8_pencomingopen");
	wait(0.5);
	soundscripts\_snd_playsound::snd_play_at("cap_gr2_thesetwocpen",(5472,-5280,32));
	wait(1);
	level.allies[0] maps\_utility::dialogue_queue("cap_gdn_cormack");
	level.allies[2] thread maps\_utility::dialogue_queue("cap_crk_gideon");
	wait(1.5);
	var_02 maps\_utility::dialogue_queue("cap_gr2_intothecage");
	var_04 maps\_utility::dialogue_queue("cap_gr1_therestofyoubehind_alt01");
	wait(1);
	var_04 maps\_utility::dialogue_queue("cap_gr2_penfillingup");
	wait(0.75);
	var_03 thread maps\_utility::dialogue_queue("cap_gr1_pasttheline");
	wait(0.75);
	var_04 thread maps\_utility::dialogue_queue("cap_gr2_4goingdowntozero");
	wait(2);
	var_04 thread maps\_utility::dialogue_queue("cap_gr3_4takingtheride");
	var_06 = ["cap_gr2_getinthecage","cap_gr2_getinside","cap_gr2_getmoving2"];
	var_05 thread maps\captured_util::dialogue_nag_loop(var_06,"truck_to_s1elevator_trigger",3,4,3,6);
	maps\_utility::trigger_wait_targetname("truck_to_s1elevator_trigger");
	wait(0.4);
	var_03 maps\_utility::dialogue_queue("cap_gr2_move");
	wait(0.5);
	var_03 maps\_utility::dialogue_queue("cap_gr2_penclosingupsecure");
	var_03 maps\_utility::dialogue_queue("cap_gr2_youreclearfordelivery");
	var_03 maps\_utility::dialogue_queue("cap_gr3_bringemin");
}

//Function Number: 70
dialogue_s2elevator_outside()
{
}

//Function Number: 71
dialogue_s2_elevator_open(param_00)
{
	var_01 = param_00[0];
	var_02 = param_00[1];
	var_03 = param_00[2];
	wait(5.75);
	var_02 maps\_utility::dialogue_queue("cap_gr8_pencomingopen");
	wait(2.75);
	var_01 maps\_utility::dialogue_queue("cap_gr4_alrightletsgoguys");
	wait(0.9);
	var_02 maps\_utility::dialogue_queue("cap_gr5_moveit");
	wait(1.9);
	var_03 maps\_utility::dialogue_queue("cap_gr20_herenow");
	var_04 = ["cap_gr20_getoverhere","cap_gr20_prisonercomehere","cap_gr20_prisonerhere"];
	var_03 thread maps\captured_util::dialogue_nag_loop(var_04,"flag_s2walk_start",5,7,3,6);
	common_scripts\utility::flag_wait("flag_s2walk_start");
	wait(0.85);
	var_03 maps\_utility::dialogue_queue("cap_gr20_letsgo");
	wait(1.75);
	var_03 maps\_utility::dialogue_queue("cap_gr20_startwalking");
	var_02 maps\_utility::dialogue_queue("cap_gr4_sendingthepenbackup");
}

//Function Number: 72
dialogue_s2_walk(param_00,param_01,param_02)
{
	var_03 = param_00[1];
	var_04 = param_00[0];
	wait(4.5);
	param_01 maps\_utility::dialogue_queue("cap_gr17_comeonthisway");
	wait(6.5);
	param_01 maps\_utility::dialogue_queue("cap_gr4_whatareyoulooking");
	wait(2);
	thread soundscripts\_snd_playsound::snd_play_at("cap_gr10_shutupgetonyour",(6192,-6656,-576));
	wait(1.25);
	param_01 maps\_utility::dialogue_queue("cap_gr7_fourcomingin2");
	wait(1.5);
	param_01 maps\_utility::dialogue_queue("cap_gr4_rogerthatcblock");
	wait(2.75);
	param_01 maps\_utility::dialogue_queue("cap_gr5_alrightpeoplethrough");
	wait(2);
	param_01 maps\_utility::dialogue_queue("cap_gr4_clearedcblocklocking");
	wait(8.9);
	var_03 maps\_utility::dialogue_queue("cap_gr7_getmoving");
	wait(3.5);
	var_03 maps\_utility::dialogue_queue("cap_gr11_wegotincomingtoc6");
	wait(1);
	var_03 maps\_utility::dialogue_queue("cap_gr9_copythatprisoners");
	wait(5.75);
	var_04 thread maps\_utility::dialogue_queue("cap_gr8_thatsfarenough");
	wait(1.75);
	var_03 maps\_utility::dialogue_queue("cap_gr7_onthefloor");
	wait(1.75);
	var_04 maps\_utility::dialogue_queue("cap_gr8_openthechute");
	wait(2);
	param_02 thread maps\_utility::dialogue_queue("cap_gr7_open");
	wait(1);
	var_04 maps\_utility::dialogue_queue("cap_gr8_wiresout");
	wait(0.75);
	param_02 thread maps\_utility::dialogue_queue("cap_gr7_clear");
	wait(0.35);
	var_04 maps\_utility::dialogue_queue("cap_gr8_hookemup");
	var_04 maps\_utility::dialogue_queue("cap_gr8_go");
	wait(1);
	param_02 maps\_utility::dialogue_queue("cap_gr8_isaiddown");
	wait(1);
	var_03 maps\_utility::dialogue_queue("cap_gr7_haveanicedayasshole_alt01");
	wait(3);
	var_04 maps\_utility::dialogue_queue("cap_gr8_wegotfourinthe");
	wait(1);
	var_04 maps\_utility::dialogue_queue("cap_gr9_fourrogerbringem");
	wait(1);
	var_04 maps\_utility::dialogue_queue("cap_gr8_preppingguests");
	wait(1);
}

//Function Number: 73
dialogue_doctor_trolley(param_00)
{
}

//Function Number: 74
dialogue_s3escape_hall()
{
	level endon("lgt_flag_interrogation_esc");
}

//Function Number: 75
dialogue_s3escape_guard()
{
}

//Function Number: 76
dialogue_control_room_attack(param_00,param_01)
{
	wait(1);
	level.allies[0] thread maps\_utility::dialogue_queue("cap_gdn_dropit");
	wait(0.366);
	if(isalive(param_00))
	{
		param_00 thread maps\_utility::dialogue_queue("cap_gr11_freezegetdown");
	}

	level.allies[0] thread maps\_utility::dialogue_queue("cap_gdn_iwillopenfire");
	wait(1.233);
	if(isalive(param_01))
	{
		param_01 thread maps\_utility::dialogue_queue("cap_gr12_youontheconsole");
	}

	wait(1);
	level.allies[0] thread maps\_utility::dialogue_queue("cap_gdn_mitchellstaythere");
	wait(1);
	if(isalive(param_00))
	{
		param_00 thread maps\_utility::dialogue_queue("cap_gr11_getdownnow_alt01");
	}

	wait(1.2);
	level.allies[0] thread maps\_utility::dialogue_queue("cap_gdn_getdown");
}

//Function Number: 77
dialogue_guardroom_door(param_00)
{
	wait(3);
	param_00 thread maps\_utility::dialogue_queue("cap_gr16_imcoming");
	wait(6.75);
	param_00 thread maps\_utility::dialogue_queue("cap_gr16_struckbygideongrunting");
	wait(5.5);
	param_00 maps\_utility::dialogue_queue("cap_gr16_noi");
	wait(0.5);
	level.allies[0] maps\_utility::dialogue_queue("cap_gdn_youlooklikehissize");
}

//Function Number: 78
dialogue_s3_observation(param_00)
{
	wait(1.8);
	param_00 maps\_utility::dialogue_queue("cap_tc1_yes");
	param_00 maps\_utility::dialogue_queue("cap_tc1_oof");
	wait(2);
	level.allies[0] maps\_utility::dialogue_queue("cap_gdn_theexitwhereis");
	wait(1.5);
	level.allies[0] maps\_utility::dialogue_queue("cap_gdn_thanks");
	wait(1);
	level.allies[0] maps\_utility::dialogue_queue("cap_gdn_youheardhimthis");
}

//Function Number: 79
dialogue_uv_bake_awcmon()
{
	wait(7.2);
	level.allies[0] maps\_utility::dialogue_queue("cap_gdn_huh");
}

//Function Number: 80
dialogue_s3_head_doctor(param_00)
{
	wait(3);
	param_00 maps\_utility::dialogue_queue("cap_dcr_stayback");
	wait(2.8);
	param_00 thread maps\_utility::dialogue_queue("cap_dcr_ugh");
	wait(0.75);
	level.allies[0] thread maps\_utility::dialogue_queue("cap_gdn_whereismanticore");
	wait(2);
	param_00 maps\_utility::dialogue_queue("cap_dcr_theatlascommand");
	wait(1.2);
	param_00 thread maps\_utility::dialogue_queue("cap_dcr_oof");
	wait(3.4);
	level.allies[0] maps\_utility::dialogue_queue("cap_gdn_thehatchletsgo");
}