/*******************************************************************
 * Decompiled By: Bog
 * Decompiled File: crash_crash_site.gsc
 * Game: Call of Duty: Advanced Warfare
 * Platform: PC
 * Function Count: 95
 * Decompile Time: 1422 ms
 * Timestamp: 4/22/2024 2:27:07 AM
*******************************************************************/

//Function Number: 1
precache_crash_site()
{
	common_scripts\utility::flag_init("crash_site_done");
	common_scripts\utility::flag_init("white_vo_done");
	common_scripts\utility::flag_init("begin_crash_site_lighting");
	common_scripts\utility::flag_init("crash_dof_fly_in");
	common_scripts\utility::flag_init("zero_view");
	common_scripts\utility::flag_init("unhide_cargo");
	common_scripts\utility::flag_init("go_drop_pods");
	common_scripts\utility::flag_init("crash_lighting_cinema_end");
	common_scripts\utility::flag_init("crash_site_battle_start");
	common_scripts\utility::flag_init("above_hole");
	common_scripts\utility::flag_init("player_returning_to_map");
	common_scripts\utility::flag_init("choose_drop_pod");
	common_scripts\utility::flag_init("wave1_pods_done");
	common_scripts\utility::flag_init("wave2_pods_starting");
	common_scripts\utility::flag_init("wave2_pods_done");
	common_scripts\utility::flag_init("wave3_pods_starting");
	common_scripts\utility::flag_init("wave3_pods_done");
	common_scripts\utility::flag_init("cormack_help_me");
	common_scripts\utility::flag_init("cormack_reached");
	common_scripts\utility::flag_init("rz_pilot_vo");
	common_scripts\utility::flag_init("razorback_start");
	common_scripts\utility::flag_init("player_loading_cargo");
	common_scripts\utility::flag_init("lighting_loading_cargo");
	common_scripts\utility::flag_init("razorback_loaded");
	common_scripts\utility::flag_init("lighting_razorback_loaded");
	common_scripts\utility::flag_init("start_background_elements");
	precachemodel("vehicle_atlas_assault_drone_large");
	precachemodel("vehicle_drop_pod");
	precachemodel("vehicle_drop_pod_base");
	precachemodel("npc_hbra3_nocamo");
	precachemodel("csh_entry_shelf_ice_floor_01_anim");
	precachemodel("npc_exo_armor_rocket_large");
	precachemodel("csh_drone_parachute_01");
	precacheitem("iw5_microdronelauncher_sp");
	precacherumble("warbird_flyby");
	precachestring(&"CRASH_INTROSCREEN_ANTARCTICA");
	precachestring(&"CRASH_DONT_LEAVE");
	precachestring(&"CRASH_FAIL_ALLIES_KILLED");
	precachestring(&"CRASH_FAIL_FALL");
	var_00 = getentarray("drop_pod_clips","script_noteworthy");
	foreach(var_02 in var_00)
	{
		var_02 notsolid();
	}

	var_04 = getent("crash_site_plane_snow","targetname");
	var_04 hide();
	var_05 = getentarray("crash_site_scorching","targetname");
	foreach(var_07 in var_05)
	{
		var_07 hide();
	}

	var_09 = getent("crash_site_plane_parachutes","targetname");
	var_09 delete();
	var_0A = getentarray("crash_site_plane_snowpiles","targetname");
	foreach(var_0C in var_0A)
	{
		var_0C hide();
	}

	var_0E = getentarray("crash_site_debris_models","targetname");
	foreach(var_0C in var_0E)
	{
		var_0C hide();
	}

	var_11 = getent("player_jetpack","targetname");
	var_11 hide();
	level.drop_pods = getentarray("drop_pod_node","script_noteworthy");
	foreach(var_13 in level.drop_pods)
	{
		var_14 = getent(var_13.target,"targetname");
		var_14 hide();
		var_13 hide();
	}

	var_16 = [];
	var_16[0] = getent("fake_drop_pod_1","targetname");
	var_16[1] = getent("fake_drop_pod_2","targetname");
	var_16[2] = getent("fake_drop_pod_3","targetname");
	var_16[3] = getent("fake_drop_pod_4","targetname");
	var_16[4] = getent("fake_drop_pod_5","targetname");
	foreach(var_13 in var_16)
	{
		var_13 hide();
	}

	var_19 = getentarray("drop_pod_background","targetname");
	foreach(var_13 in var_19)
	{
		var_14 = getent(var_13.target,"targetname");
		var_14 hide();
		var_13 hide();
	}

	var_1C = getentarray("craters","script_noteworthy");
	foreach(var_1E in var_1C)
	{
		var_1E hide();
	}

	var_20 = getent("drop_pod_mech_1","targetname");
	var_21 = getent(var_20.target,"targetname");
	var_20 hide();
	var_21 hide();
	var_22 = getent("drop_pod_mech_2","targetname");
	var_23 = getent(var_22.target,"targetname");
	var_22 hide();
	var_23 hide();
	var_24 = getent("drop_pod_mech_3","targetname");
	var_25 = getent(var_24.target,"targetname");
	var_24 hide();
	var_25 hide();
	var_26 = getentarray("crash_site_triggers","targetname");
	foreach(var_28 in var_26)
	{
		var_28 common_scripts\utility::trigger_off();
	}

	var_2A = getent("cargo_trigger","targetname");
	var_2A common_scripts\utility::trigger_off();
	maps\_utility::add_control_based_hint_strings("boost_jump",&"CRASH_HINT_BOOST_JUMP",::should_break_boost_jump_hint);
	maps\_utility::add_control_based_hint_strings("hint_dont_leave_mission",&"CRASH_DONT_LEAVE",::should_break_dont_leave);
	level.crash_site_drones = [];
}

//Function Number: 2
precache_cave_entry()
{
	common_scripts\utility::flag_init("cave_entry_done");
	common_scripts\utility::flag_init("cave_entry_anim_start");
	common_scripts\utility::flag_init("player_starting_cave_entry");
	common_scripts\utility::flag_init("player_pre_loading_cargo");
	common_scripts\utility::flag_init("shoot_razorback");
	common_scripts\utility::flag_init("razorback_goliath_done");
	common_scripts\utility::flag_init("tank_firing_missiles");
	common_scripts\utility::flag_init("start_bunker_collapse");
	common_scripts\utility::flag_init("tank_incoming");
	common_scripts\utility::flag_init("flag_m_turret_dead");
	common_scripts\utility::flag_init("fall_debris_exploder");
	common_scripts\utility::flag_init("blur_player_vision");
	precachemodel("npc_resonance_device_base");
	precacheshader("overlay_rain_blur");
	precacheshellshock("crash_ice_cave_entry");
	precachestring(&"CRASH_CARGO_PUSH");
	precachestring(&"CRASH_CARGO_PUSH_KEYBOARD");
}

//Function Number: 3
debug_start_crash_site()
{
	maps\crash::set_completed_flags();
	maps\crash_utility::setup_player();
	maps\crash_utility::setup_allies();
	soundscripts\_snd::snd_message("start_crash_site");
	thread maps\crash::objective_init();
	level.player maps\_utility::fog_set_changes("crash_skyjack_heavy_fog",0);
	thread maps\_high_speed_clouds::cloudfastinit("heavy",(0,90,0),5,1);
	level.cormack maps\_utility::gun_remove();
	level.player disableweapons();
	level.player givemaxammo("iw5_hbra3_sp_opticstargetenhancer");
	level.player allowcrouch(0);
	level.player allowjump(0);
	level.player allowsprint(0);
	level.player allowprone(0);
	level.player allowads(0);
	level.player allowmelee(0);
}

//Function Number: 4
debug_start_cave_entry()
{
	maps\crash::set_completed_flags();
	maps\crash_utility::setup_player();
	maps\crash_utility::setup_allies();
	soundscripts\_snd::snd_message("start_cave_entry");
	level.crash_site_animnode = common_scripts\utility::getstruct("crash_site_animnode","targetname");
	thread maps\crash::objective_init();
	if(level.nextgen)
	{
		level.allies_bunker = maps\_utility::array_spawn_targetname("bunker_allies",1);
	}
	else
	{
		var_00 = getentarray("bunker_allies","targetname");
		level.allies_bunker = maps\_utility::array_spawn_cg(var_00,1);
	}

	var_01 = getent("bunker_badplace","targetname");
	badplace_brush("bunker_badplace",-1,var_01,"axis");
	level.pod_enemies = [];
	wait 0.05;
	var_02 = getentarray("runway_shells","targetname");
	foreach(var_04 in var_02)
	{
		var_04 delete();
	}

	level.player thread maps\crash_utility::exo_temp_outdoor();
	if(level.nextgen)
	{
		level.bunker_guy01 = maps\_utility::get_living_ai("bunker_ally_01","script_noteworthy");
		level.bunker_guy01.animname = "bunker_guy01";
		var_06 = getnode("bunker_ally_01_node","targetname");
		level.bunker_guy01 thread maps\_utility::magic_bullet_shield();
		level.bunker_guy01 forceteleport(var_06.origin,var_06.angles);
		level.bunker_guy01 setgoalnode(var_06);
		level.bunker_guy02 = maps\_utility::get_living_ai("bunker_ally_02","script_noteworthy");
		level.bunker_guy02.animname = "bunker_guy02";
		var_07 = getnode("bunker_ally_02_node","targetname");
		level.bunker_guy02 thread maps\_utility::magic_bullet_shield();
		level.bunker_guy02 forceteleport(var_07.origin,var_07.angles);
		level.bunker_guy02 setgoalnode(var_07);
	}

	level.bunker_guy03 = maps\_utility::get_living_ai("bunker_ally_03","script_noteworthy");
	level.bunker_guy03.animname = "bunker_guy03";
	var_08 = getnode("bunker_ally_03_node","targetname");
	level.bunker_guy03 forceteleport(var_08.origin,var_08.angles);
	level.bunker_guy03 setgoalnode(var_08);
	level.bunker_guy03 thread maps\_utility::magic_bullet_shield();
	thread razorback_trigger_handler();
	thread razorback_cargo_player();
	thread razorback_razorback();
	thread razorback_cargo();
	common_scripts\utility::flag_set("razorback_start");
	common_scripts\_exploder::exploder(1474);
	level.player lightsetforplayer("crash_crash_site");
	maps\_utility::vision_set_fog_changes("crash_crash_site",0);
	level.player setclutforplayer("clut_crash_crash_site",0);
	setsunflareposition((-10.08,-87.9,0));
	common_scripts\_exploder::exploder(1999);
	thread background_drop_pods();
	thread crash_site_random_bg_explosion();
}

//Function Number: 5
begin_crash_site()
{
	if(level.currentgen)
	{
		var_00 = ["crash_mech"];
		thread maps\_cg_encounter_perf_monitor::cg_spawn_perf_monitor("end_crash_perf_monitor",var_00,18,0);
	}

	if(level.currentgen)
	{
		if(!istransientloaded("crash_site_tr"))
		{
			level.player setgravityoverride(0);
			level notify("tff_pre_sky_to_site");
			unloadtransient("crash_sky_tr");
			loadtransient("crash_site_tr");
			while(!istransientloaded("crash_site_tr"))
			{
				wait(0.05);
			}

			level notify("tff_post_sky_to_site");
			level.player resetgravityoverride();
		}
	}

	thread maps\_utility::autosave_by_name("crash_site");
	level.crash_site_animnode = common_scripts\utility::getstruct("crash_site_animnode","targetname");
	level.wind_dir = (0,90,0);
	if(level.start_point == "crash_site")
	{
		wait 0.05;
	}

	common_scripts\utility::flag_set("begin_crash_site_lighting");
	common_scripts\_exploder::exploder(1999);
	var_01 = common_scripts\utility::getstruct("crash_site_cormack","targetname");
	level.cormack forceteleport(var_01.origin,var_01.angles);
	level.ilana = maps\crash_utility::spawn_ally("ilana","crash_site_ilana");
	wait 0.05;
	level.ilana maps\_utility::set_force_color("g");
	level.ilana.canjumppath = 1;
	maps\_utility::array_spawn_function_targetname("plane_allies",::crash_site_plane_allies);
	if(level.nextgen)
	{
		level.allies_plane = maps\_utility::array_spawn_targetname("plane_allies",1);
	}
	else
	{
		var_02 = getentarray("plane_allies","targetname");
		level.allies_plane = maps\_utility::array_spawn_cg(var_02,1);
	}

	thread crash_site_cormack();
	thread crash_site_ilana();
	thread crash_site_player_gun();
	thread crash_site_bunker_sentinels();
	thread crash_site_intro_killer();
	thread crash_site_intro_killer2();
	thread crash_site_player();
	thread kill_trigger_array();
	thread check_potential_falling_death();
	thread falling_death();
	thread razorback_trigger_handler();
	thread razorback_cargo_player();
	thread crash_site_combat_manager();
	thread crash_site_drop_pod_manager();
	thread crash_site_kill_counter();
	thread crash_site_plane();
	thread crash_site_chutes();
	thread crash_site_runway();
	thread crash_site_drone();
	thread razorback_razorback();
	thread razorback_cargo();
	thread background_drop_pods();
	thread crash_site_random_bg_explosion();
	thread crash_site_random_playspace_explosion();
	common_scripts\utility::flag_set("white_fade_done");
	wait(1);
	maps\_utility::array_spawn_function_targetname("bunker_allies",::crash_site_bunker_allies);
	wait(2);
	level thread maps\_high_speed_clouds::cloudfastnone(2);
	level.player thread maps\crash_exo_temperature::set_external_temperature_over_time(level.temperature_outdoor,12);
	level.player maps\_utility::delaythread(13,::maps\crash_utility::exo_temp_outdoor);
	if(level.nextgen)
	{
		maps\_utility::array_spawn_function_targetname("razorback_allies",::crash_site_razorback_allies);
		maps\_utility::array_spawn_targetname("razorback_allies",1);
	}

	wait(2);
	if(level.nextgen)
	{
		level.allies_bunker = maps\_utility::array_spawn_targetname("bunker_allies",1);
	}
	else
	{
		var_02 = getentarray("bunker_allies","targetname");
		level.allies_bunker = maps\_utility::array_spawn_cg(var_02,1);
	}

	thread maps\_utility::center_screen_text(&"CRASH_INTROSCREEN_ANTARCTICA");
	level notify("stop_fast_clouds");
	self notify("fast_cloud_level_change");
	self notify("new_ramp");
	level.player pushplayervector((0,0,0),0);
	wait(0.1);
	thread maps\_utility::autosave_by_name("on_ground");
	thread crash_site_dialogue();
	common_scripts\utility::flag_wait_either("go_drop_pods","drop_pod_failsafe");
	setsaveddvar("cg_cinematicfullscreen","0");
	setsaveddvar("cg_cinematicCanPause","0");
	thread crash_site_dead_razorback_guys();
	wait(3);
	maps\_utility::battlechatter_on("allies");
	maps\_utility::battlechatter_on("axis");
	common_scripts\utility::flag_wait("crash_site_done");
}

//Function Number: 6
crash_site_player()
{
	if(level.start_point != "crash_site")
	{
		level.player takeallweapons();
		foreach(var_01 in level.player_weapons)
		{
			level.player giveweapon(var_01);
		}

		level.player enableweaponswitch();
		level.player switchtoweapon("iw5_hbra3_sp_opticstargetenhancer");
		level.player givemaxammo("iw5_hbra3_sp_opticstargetenhancer");
	}

	level.player setstance("stand");
	var_03 = maps\_utility::spawn_anim_model("rig");
	var_03 dontcastshadows();
	thread maps\_shg_utility::disable_features_entering_cinema();
	level.player playerlinktodelta(var_03,"tag_player",1,0,0,0,0);
	soundscripts\_snd::snd_message("ambush_events");
	level.crash_site_animnode thread maps\_anim::anim_single_solo(var_03,"crash_atlas_plane_crash_player");
	wait(3);
	level.player lerpviewangleclamp(0.25,0.15,0,10,10,10,7);
	var_03 waittillmatch("player_land","single anim");
	level.player playrumbleonentity("light_2s");
	common_scripts\utility::flag_wait("zero_view");
	level.player lerpviewangleclamp(0.4,0.15,0,0,0,0,0);
	common_scripts\utility::flag_wait("unhide_cargo");
	level.player lerpviewangleclamp(0.25,0.15,0,10,10,10,7);
	var_04 = getent("player_jetpack","targetname");
	var_04 show();
	var_03 waittillmatch("end","single anim");
	var_05 = getentarray("crash_site_triggers","targetname");
	foreach(var_07 in var_05)
	{
		var_07 common_scripts\utility::trigger_on();
	}

	level.player unlink();
	thread maps\_shg_utility::enable_features_exiting_cinema();
	common_scripts\utility::flag_set("crash_lighting_cinema_end");
	level.player allowcrouch(1);
	level.player allowjump(1);
	level.player allowsprint(1);
	level.player allowprone(1);
	level.player allowads(1);
	level.player allowmelee(1);
	level.player enableweapons();
	thread maps\crash_utility::player_exo_enable();
	var_03 delete();
}

//Function Number: 7
crash_site_player_gun()
{
	var_00 = maps\_utility::spawn_anim_model("cs_gun");
	level.crash_site_animnode maps\_anim::anim_first_frame_solo(var_00,"plane_crash_player_gun");
	var_01 = spawn("script_model",var_00 gettagorigin("j_prop_1"));
	var_01 setmodel("npc_hbra3_nocamo");
	var_01.angles = var_00 gettagangles("j_prop_1");
	var_01 linkto(var_00,"j_prop_1");
	common_scripts\utility::flag_wait("white_fade_done");
	level.crash_site_animnode maps\_anim::anim_single_solo(var_00,"plane_crash_player_gun");
	var_01 delete();
	var_00 delete();
}

//Function Number: 8
crash_site_cormack()
{
	level.cormack endon("death");
	level.cormack.ignoreme = 1;
	level.cormack.lastgroundtype = "snow";
	level.crash_site_animnode thread maps\_anim::anim_single_solo(level.cormack,"atlas_plane_crash");
	playfxontag(common_scripts\utility::getfx("jetpack_skyjack_trail"),level.cormack,"tag_fx_engine_l_exhause");
	wait(0.05);
	playfxontag(common_scripts\utility::getfx("jetpack_skyjack_trail"),level.cormack,"tag_fx_engine_r_exhause");
	wait(0.1);
	playfxontag(common_scripts\utility::getfx("jetpack_exhaust_exhaust_npc"),level.cormack,"tag_fx_engine_l_exhause");
	wait(0.05);
	playfxontag(common_scripts\utility::getfx("jetpack_exhaust_exhaust_npc"),level.cormack,"tag_fx_engine_r_exhause");
	level.cormack waittillmatch("jets_off","single anim");
	stopfxontag(common_scripts\utility::getfx("jetpack_skyjack_trail"),level.cormack,"tag_fx_engine_l_exhause");
	stopfxontag(common_scripts\utility::getfx("jetpack_skyjack_trail"),level.cormack,"tag_fx_engine_r_exhause");
	wait 0.05;
	stopfxontag(common_scripts\utility::getfx("jetpack_exhaust_exhaust_npc"),level.cormack,"tag_fx_engine_l_exhause");
	stopfxontag(common_scripts\utility::getfx("jetpack_exhaust_exhaust_npc"),level.cormack,"tag_fx_engine_r_exhause");
	level.cormack waittillmatch("cormack_land","single anim");
	playfxontag(common_scripts\utility::getfx("boost_dust_impact_ground"),level.cormack,"j_ball_le");
	level.cormack waittillmatch("pods_enter","single anim");
	common_scripts\utility::flag_set("go_drop_pods");
	wait(1);
	maps\_utility::activate_trigger_with_targetname("plane_allies_move");
	level.cormack waittillmatch("end","single anim");
	level.cormack maps\_utility::gun_recall();
	level.cormack maps\_utility::enable_ai_color_dontmove();
	stopfxontag(common_scripts\utility::getfx("boost_dust_impact_ground"),level.cormack,"j_ball_le");
	wait(0.5);
	level.cormack maps\crash_utility::clear_additive_helmet_anim(0);
	maps\_utility::activate_trigger_with_targetname("ambush_start_color");
	common_scripts\utility::flag_set("crash_site_battle_start");
	level.cormack.ignoreme = 0;
	common_scripts\utility::flag_wait_either("razorback_start","player_loading_cargo");
	thread crash_site_bg_warbirds();
	common_scripts\utility::flag_set("crash_site_done");
}

//Function Number: 9
cormack_jetpack_switch(param_00)
{
	var_01 = spawn("script_model",level.cormack gettagorigin("tag_jetpack") + (0,0,-16));
	var_01.angles = level.cormack gettagangles("tag_jetpack");
	var_01 setmodel("jetpack_sentinel_halo");
	wait 0.05;
	level.cormack setmodel("body_hero_cormack_sentinel_halo");
}

//Function Number: 10
crash_site_ilana()
{
	level.ilana endon("death");
	level.ilana.ignoreme = 1;
	level.crash_site_animnode maps\_anim::anim_first_frame_solo(level.ilana,"atlas_plane_crash");
	common_scripts\utility::flag_wait("white_fade_done");
	level.crash_site_animnode thread maps\_anim::anim_single_solo(level.ilana,"atlas_plane_crash");
	level.ilana waittillmatch("end","single anim");
	level.ilana.ignoreme = 0;
}

//Function Number: 11
crash_site_plane()
{
	var_00 = getent("crash_site_plane","targetname");
	var_00.animname = "cargo_plane";
	var_00 maps\_anim::setanimtree();
	level.crashing_plane = var_00;
	var_00 hidepart("J_LT_WING");
	var_00 hidepart("J_RT_WING");
	var_00 hidepart("J_FLAP_L1");
	var_00 hidepart("J_FLAP_L2");
	var_00 hidepart("J_FLAP_R1");
	var_00 hidepart("J_FLAP_R2");
	var_00 hidepart("J_SPOILER_L1");
	var_00 hidepart("J_SPOILER_L2");
	var_00 hidepart("J_SPOILER_L3");
	var_00 hidepart("J_SPOILER_L4");
	var_00 hidepart("J_SPOILER_R1");
	var_00 hidepart("J_SPOILER_R2");
	var_00 hidepart("J_SPOILER_R3");
	var_00 hidepart("J_SPOILER_R4");
	level.crash_site_animnode maps\_anim::anim_first_frame_solo(var_00,"atlas_plane_crash_plane");
	wait 0.05;
	common_scripts\utility::flag_wait("white_fade_done");
	level.crash_site_animnode thread maps\_anim::anim_single_solo(var_00,"atlas_plane_crash_plane");
	wait(0.15);
	playfxontag(level._effect["fire_burning_vtol_left"],var_00,"tag_smoke_lt_body");
	wait(0.1);
	playfxontag(level._effect["fire_burning_vtol"],var_00,"tag_smoke_rt_body");
	common_scripts\_exploder::exploder(8124);
	wait(0.3);
	if(level.start_point != "crash_site")
	{
		playfxontag(level._effect["fx_crash_hud_flare"],var_00,"body_animate_jnt");
	}

	wait(0.7);
	common_scripts\_exploder::exploder(1100);
	wait(4.95);
	common_scripts\utility::flag_set("crash_dof_fly_in");
	wait(1.55);
	playfxontag(level._effect["crash_vtol_landing_exp"],var_00,"tag_smoke_rt_body");
	wait(6);
	common_scripts\_exploder::exploder(1300);
	var_00 waittillmatch("end","single anim");
	common_scripts\_exploder::kill_exploder(8124);
	if(level.nextgen)
	{
		common_scripts\utility::flag_wait("cave_entry_done");
	}
	else
	{
		level waittill("tff_pre_site_to_caves");
	}

	stopfxontag(level._effect["fire_burning_vtol"],var_00,"tag_smoke_rt_body");
	stopfxontag(level._effect["fire_burning_vtol_left"],var_00,"tag_smoke_lt_body");
	wait 0.05;
	var_00 delete();
}

//Function Number: 12
crash_site_chutes()
{
	var_00 = [];
	var_00[0] = maps\_utility::spawn_anim_model("drone_chute1");
	var_00[1] = maps\_utility::spawn_anim_model("drone_chute2");
	var_00[2] = maps\_utility::spawn_anim_model("drone_chute3");
	var_00[3] = maps\_utility::spawn_anim_model("drone_cable");
	level.crash_site_animnode thread maps\_anim::anim_single(var_00,"atlas_plane_crash");
	var_00[0] waittillmatch("switch","single anim");
	common_scripts\utility::array_call(var_00,::hide);
	maps\_utility::array_delete(var_00);
	var_01 = maps\_utility::spawn_anim_model("ground_chute");
	level.crash_site_animnode thread maps\_anim::anim_loop_solo(var_01,"crash_chute_idle","stop_chute");
	common_scripts\utility::flag_wait("crash_site_done");
	level.crash_site_animnode notify("stop_chute");
	wait(0.05);
	var_01 delete();
}

//Function Number: 13
crash_site_runway()
{
	var_00 = getent("runway_shell_geo_01","targetname");
	var_01 = getent("runway_shell_geo_02","targetname");
	var_02 = getent("runway_shell_geo_03","targetname");
	var_03 = getent("runway_shell_geo_04","targetname");
	var_04 = getent("runway_shell_geo_05","targetname");
	var_05 = getent("runway_shell_geo_06","targetname");
	var_06 = getent("runway_shell_geo_07","targetname");
	var_07 = getent("runway_shell_geo_08","targetname");
	var_08 = getent("runway_shell_geo_09","targetname");
	var_09 = getent("runway_shell_geo_10","targetname");
	var_0A = getent("runway_shell_geo_11","targetname");
	wait(5.05);
	var_00 connectpaths();
	var_01 connectpaths();
	var_00 delete();
	var_01 delete();
	wait(0.25);
	var_02 connectpaths();
	var_02 delete();
	wait(0.45);
	var_03 connectpaths();
	var_03 delete();
	wait(0.95);
	var_04 connectpaths();
	var_04 delete();
	wait(0.23);
	var_05 connectpaths();
	var_05 delete();
	wait(0.33);
	var_06 connectpaths();
	var_06 delete();
	wait(0.49);
	var_07 connectpaths();
	var_07 delete();
	wait(0.69);
	var_08 connectpaths();
	var_08 delete();
	wait(0.61);
	var_09 connectpaths();
	var_09 delete();
	wait(1.22);
	var_0A connectpaths();
	var_0A delete();
	var_0B = getent("crash_site_plane_snow","targetname");
	var_0B show();
	var_0C = getentarray("crash_site_plane_snowpiles","targetname");
	foreach(var_0E in var_0C)
	{
		var_0E show();
	}

	wait(3.28);
	var_10 = getentarray("crash_site_scorching","targetname");
	foreach(var_12 in var_10)
	{
		var_12 show();
	}

	var_14 = getentarray("crash_site_debris_models","targetname");
	foreach(var_0E in var_14)
	{
		var_0E show();
	}
}

//Function Number: 14
crash_site_drone()
{
	var_00 = maps\_utility::spawn_anim_model("drone_pod");
	level.crash_site_animnode maps\_anim::anim_first_frame_solo(var_00,"atlas_plane_crash_drone");
	common_scripts\utility::flag_wait("white_fade_done");
	level.crash_site_animnode maps\_anim::anim_single_solo(var_00,"atlas_plane_crash_drone");
}

//Function Number: 15
crash_site_plane_allies()
{
	self endon("death");
	self.health = 500;
	self.canjumppath = 2.5;
	self.baseaccuracy = self.baseaccuracy * 0.25;
	self.animname = self.script_noteworthy;
	maps\_utility::enable_ai_color_dontmove();
	var_00 = common_scripts\utility::spawn_tag_origin();
	self setgoalpos(var_00.origin);
	self.ignoreall = 1;
	common_scripts\utility::flag_wait("go_drop_pods");
	self.ignoreall = 0;
	var_00 delete();
	self.health = int(self.health * 0.2);
}

//Function Number: 16
crash_site_razorback_allies()
{
	self.ignoreall = 1;
	self.canjumppath = 10;
	common_scripts\utility::flag_wait("go_drop_pods");
	if(isdefined(self) && isalive(self))
	{
		self delete();
	}
}

//Function Number: 17
crash_site_intro_killer()
{
	var_00 = maps\_utility::get_living_ai("sent1","script_noteworthy");
	var_00.animname = "sent1";
	var_00 maps\_utility::disable_ai_color();
	level.crash_site_animnode maps\_anim::anim_single_solo(var_00,"atlas_plane_crash_craig");
	var_01 = getnode("killer_node","targetname");
	var_00 setgoalnode(var_01);
	var_00 waittill("goal");
	var_00 maps\_utility::enable_ai_color_dontmove();
}

//Function Number: 18
crash_site_intro_killer2()
{
	var_00 = maps\_utility::get_living_ai("sent2","script_noteworthy");
	var_00.animname = "sent2";
	var_00 maps\_utility::disable_ai_color();
	level.crash_site_animnode maps\_anim::anim_single_solo(var_00,"atlas_plane_crash_tony");
	var_01 = getnode("killer_node2","targetname");
	var_00 setgoalnode(var_01);
	var_00 waittill("goal");
	var_00 maps\_utility::enable_ai_color_dontmove();
}

//Function Number: 19
crash_site_bunker_allies()
{
	self.baseaccuracy = self.baseaccuracy * 0.25;
	thread maps\_utility::magic_bullet_shield();
	self.canjumppath = 2.5;
	self.ignoreall = 1;
	self.suppressionthreshold = 0.15;
	self waittill("goal");
	maps\_utility::enable_ai_color_dontmove();
	common_scripts\utility::flag_wait("go_drop_pods");
	self.ignoreall = 0;
}

//Function Number: 20
crash_site_bunker_sentinels()
{
	common_scripts\utility::flag_wait("razorback_start");
	if(level.nextgen)
	{
		level.bunker_guy01 = maps\_utility::get_living_ai("bunker_ally_01","script_noteworthy");
		level.bunker_guy01.animname = "bunker_guy01";
		level.bunker_guy01 maps\_utility::disable_ai_color();
		var_00 = getnode("bunker_ally_01_node","targetname");
		level.bunker_guy01 setgoalnode(var_00);
		level.bunker_guy01 thread bunker_settings();
		level.bunker_guy02 = maps\_utility::get_living_ai("bunker_ally_02","script_noteworthy");
		level.bunker_guy02.animname = "bunker_guy02";
		level.bunker_guy02 maps\_utility::disable_ai_color();
		var_01 = getnode("bunker_ally_02_node","targetname");
		level.bunker_guy02 setgoalnode(var_01);
		level.bunker_guy02 thread bunker_settings();
	}

	level.bunker_guy03 = maps\_utility::get_living_ai("bunker_ally_03","script_noteworthy");
	level.bunker_guy03.animname = "bunker_guy03";
	level.bunker_guy03 maps\_utility::disable_ai_color();
	var_02 = getnode("bunker_ally_03_node","targetname");
	level.bunker_guy03 setgoalnode(var_02);
	level.bunker_guy03 thread bunker_settings();
}

//Function Number: 21
crash_site_dead_razorback_guys()
{
	if(level.nextgen)
	{
		maps\_utility::array_spawn_function_targetname("dead_razor_ally",::dead_razorback_spawn);
		level.crash_site_ally_drones = maps\_utility::array_spawn_targetname("dead_razor_ally",1);
	}
}

//Function Number: 22
dead_razorback_spawn()
{
	var_00 = common_scripts\utility::getstruct(self.script_noteworthy,"targetname");
	self.animname = "generic";
	thread maps\crash_utility::disable_awareness();
	maps\_utility::set_battlechatter(0);
	maps\_utility::gun_remove();
	self.script_friendname = " ";
	self.name = " ";
	thread maps\_utility::magic_bullet_shield();
	self invisiblenotsolid();
	var_00 thread maps\_anim::anim_loop_solo(self,self.script_animation,"stop_loop");
}

//Function Number: 23
crash_site_combat_manager()
{
	level endon("crash_site_failed");
	level.player endon("death");
	var_00 = getent("bunker_badplace","targetname");
	badplace_brush("bunker_badplace",-1,var_00,"axis");
	common_scripts\utility::flag_wait("wave1_pods_done");
	thread fake_drop_pods();
	level.pod_enemies = common_scripts\utility::array_removeundefined(level.pod_enemies);
	var_01 = 16 - level.pod_enemies.size;
	var_02 = 6 - var_01;
	var_02 = clamp(var_02,0,6);
	var_02 = int(var_02);
	thread maps\crash_utility::ai_array_killcount_flag_set(level.pod_enemies,var_02,"drop_pod_failsafe");
	common_scripts\utility::flag_wait("drop_pod_failsafe");
	level.pod_enemies = common_scripts\utility::array_removeundefined(level.pod_enemies);
	var_03 = level.pod_enemies.size;
	var_04 = getent("cs_advance_1","script_noteworthy");
	if(isdefined(var_04))
	{
		maps\_utility::activate_trigger("cs_advance_1","script_noteworthy",level.player);
	}

	wait 0.05;
	if(isdefined(var_04))
	{
		var_04 delete();
	}

	common_scripts\utility::flag_set("wave2_pods_starting");
	thread retreat_from_vol_to_vol("vol_ambush_combat_0_n","vol_ambush_combat_1_n",0.05,0.25);
	thread retreat_from_vol_to_vol("vol_ambush_combat_0_s","vol_ambush_combat_1_s",0.05,0.25);
	common_scripts\utility::flag_wait("wave2_pods_done");
	if(!common_scripts\utility::flag("cs_pre_fail_state") && !common_scripts\utility::flag("above_hole"))
	{
		thread maps\_utility::autosave_by_name("cs_combat_1");
	}

	level.pod_enemies = common_scripts\utility::array_removeundefined(level.pod_enemies);
	var_03 = level.pod_enemies.size;
	var_01 = 12 - level.pod_enemies.size;
	if(var_01 < 0)
	{
		var_01 = 0;
	}

	var_02 = 5 - var_01;
	var_02 = clamp(var_02,0,5);
	var_02 = int(var_02);
	thread maps\crash_utility::ai_array_killcount_flag_set(level.pod_enemies,var_02,"fallback_vol_2");
	common_scripts\utility::flag_wait("fallback_vol_2");
	level.pod_enemies = common_scripts\utility::array_removeundefined(level.pod_enemies);
	var_03 = level.pod_enemies.size;
	var_04 = getent("cs_advance_2","script_noteworthy");
	if(isdefined(var_04))
	{
		maps\_utility::activate_trigger("cs_advance_2","script_noteworthy",level.player);
	}

	wait 0.05;
	if(isdefined(var_04))
	{
		var_04 delete();
	}

	common_scripts\utility::flag_set("wave3_pods_starting");
	thread retreat_from_vol_to_vol("vol_ambush_combat_1_n","vol_ambush_combat_2_n",0.05,0.25);
	thread retreat_from_vol_to_vol("vol_ambush_combat_1_s","vol_ambush_combat_2_s",0.05,0.25);
	wait(12.2);
	level.pod_enemies = common_scripts\utility::array_removeundefined(level.pod_enemies);
	var_03 = level.pod_enemies.size;
	var_01 = 16 - level.pod_enemies.size;
	if(var_01 < 0)
	{
		var_01 = 0;
	}

	var_02 = 8 - var_01;
	var_02 = clamp(var_02,0,8);
	var_02 = int(var_02);
	var_04 = getent("cs_advance_3","script_noteworthy");
	if(isdefined(var_04))
	{
		maps\_utility::activate_trigger("cs_advance_3","script_noteworthy",level.player);
	}

	wait 0.05;
	if(isdefined(var_04))
	{
		var_04 delete();
	}

	thread retreat_from_vol_to_vol("vol_ambush_combat_2_n","vol_ambush_combat_3_n",0.05,0.25);
	thread retreat_from_vol_to_vol("vol_ambush_combat_2_s","vol_ambush_combat_3_s",0.05,0.25);
	common_scripts\utility::flag_wait("wave3_pods_done");
	if(!common_scripts\utility::flag("cs_pre_fail_state") && !common_scripts\utility::flag("above_hole"))
	{
		thread maps\_utility::autosave_by_name("cs_combat_2");
	}

	level.pod_enemies = common_scripts\utility::array_removeundefined(level.pod_enemies);
	var_03 = level.pod_enemies.size;
	var_01 = 16 - level.pod_enemies.size;
	if(var_01 < 0)
	{
		var_01 = 0;
	}

	var_02 = 8 - var_01;
	var_02 = clamp(var_02,0,8);
	var_02 = int(var_02);
	thread maps\crash_utility::ai_array_killcount_flag_set(level.pod_enemies,var_02,"fallback_vol_3");
	common_scripts\utility::flag_wait("fallback_vol_3");
	var_04 = getent("cs_advance_4","script_noteworthy");
	if(isdefined(var_04))
	{
		maps\_utility::activate_trigger("cs_advance_4","script_noteworthy",level.player);
	}

	wait 0.05;
	if(isdefined(var_04))
	{
		var_04 delete();
	}

	thread retreat_from_vol_to_vol("vol_ambush_combat_3_n","vol_ambush_combat_4_n",0.05,0.15);
	thread retreat_from_vol_to_vol("vol_ambush_combat_3_s","bg_ai_volume",0.05,0.15);
	level.pod_enemies = common_scripts\utility::array_removeundefined(level.pod_enemies);
	var_03 = level.pod_enemies.size;
	var_02 = level.pod_enemies.size - 8;
	var_02 = clamp(var_02,0,10);
	var_02 = int(var_02);
	thread maps\crash_utility::ai_array_killcount_flag_set(level.pod_enemies,var_02,"razorback_start");
	common_scripts\utility::flag_wait("razorback_start");
	common_scripts\utility::flag_set("start_background_elements");
	var_04 = getent("cs_advance_5","script_noteworthy");
	if(isdefined(var_04))
	{
		var_04 delete();
	}
}

//Function Number: 24
crash_site_kill_counter()
{
	var_00 = 0;
	while(!isdefined(level.pod_enemies))
	{
		wait(0.05);
	}

	while(level.pod_enemies.size < 1)
	{
		wait(0.05);
	}

	while(var_00 < 10)
	{
		maps\_utility::waittill_dead_or_dying(level.pod_enemies,1);
		var_00 = var_00 + 1;
	}

	common_scripts\utility::flag_set("keep_pushing");
	while(var_00 < 25)
	{
		maps\_utility::waittill_dead_or_dying(level.pod_enemies,1);
		var_00 = var_00 + 1;
	}

	common_scripts\utility::flag_set("rz_pilot_vo");
	common_scripts\utility::flag_set("obj_move_dot_razorback");
}

//Function Number: 25
retreat_from_vol_to_vol(param_00,param_01,param_02,param_03)
{
	var_04 = getent(param_00,"targetname");
	var_05 = var_04 maps\_utility::get_ai_touching_volume("axis");
	var_06 = getent(param_01,"targetname");
	var_07 = getnode(var_06.target,"targetname");
	foreach(var_09 in var_05)
	{
		if(isdefined(var_09) && isalive(var_09))
		{
			if(issubstr(var_09.model,"shotgun"))
			{
				return;
			}

			var_09.ignoresuppression = 1;
			var_09.forcegoal = 0;
			var_09.fixednode = 0;
			var_09.pathrandompercent = randomintrange(75,100);
			var_09 setgoalvolumeauto(var_06);
			wait(5);
			if(isdefined(var_09) && isalive(var_09))
			{
				var_09.ignoresuppression = 0;
			}
		}
	}
}

//Function Number: 26
fake_drop_pods()
{
	level endon("crash_site_done");
	var_00 = [];
	var_00[0] = getent("fake_drop_pod_1","targetname");
	var_00[1] = getent("fake_drop_pod_2","targetname");
	var_00[2] = getent("fake_drop_pod_3","targetname");
	var_00[3] = getent("fake_drop_pod_4","targetname");
	var_00[4] = getent("fake_drop_pod_5","targetname");
	for(var_01 = 0;var_01 < var_00.size;var_01++)
	{
		var_02 = getent(var_00[var_01].target,"targetname");
		wait(randomintrange(5,10));
		while(!level.player worldpointinreticle_circle(var_02.origin,65,400))
		{
			wait(0.05);
		}

		var_00[var_01] thread drop_pod_fall();
	}
}

//Function Number: 27
crash_site_drop_pod_manager()
{
	level endon("crash_site_done");
	level endon("stop_drop_pods");
	level.pod_enemies = [];
	common_scripts\utility::flag_wait("go_drop_pods");
	var_00 = getentarray("drop_pod_0_clip","targetname");
	var_01 = getent("drop_pod_0","targetname");
	var_02 = getentarray("drop_pod_0_crater","targetname");
	var_01 thread drop_pod_fall("enemy",var_02);
	var_03 = getent("drop_pod_1","targetname");
	var_04 = getentarray("drop_pod_1_crater","targetname");
	var_05 = getent("drop_pod_2","targetname");
	var_06 = getentarray("drop_pod_2_crater","targetname");
	var_07 = getent("drop_pod_3","targetname");
	var_08 = getentarray("drop_pod_3_crater","targetname");
	wait(0.75);
	var_03 thread drop_pod_fall("enemy",var_04);
	wait(randomfloatrange(1.25,2.25));
	maps\_utility::array_spawn_function_targetname("cs_first_response",::first_response);
	if(level.nextgen)
	{
		maps\_utility::array_spawn_targetname("cs_first_response",1);
	}
	else
	{
		var_09 = getentarray("cs_first_response","targetname");
		maps\_utility::array_spawn_cg(var_09,1);
	}

	var_05 thread drop_pod_fall("enemy",var_06);
	wait(randomfloatrange(4,5.5));
	var_07 thread drop_pod_fall("enemy",var_08);
	wait(3.6);
	common_scripts\utility::flag_set("wave1_pods_done");
	common_scripts\utility::flag_wait("wave2_pods_starting");
	var_0A = getent("drop_pod_4","targetname");
	var_0B = getent("drop_pod_5","targetname");
	var_0C = getent("drop_pod_6","targetname");
	var_0D = getent(var_0A.target,"targetname");
	var_0E = getent(var_0B.target,"targetname");
	var_0F = getent(var_0C.target,"targetname");
	var_10 = getentarray("drop_pod_4_crater","targetname");
	var_11 = getentarray("drop_pod_5_crater","targetname");
	var_12 = getentarray("drop_pod_6_crater","targetname");
	wait(randomfloatrange(0.75,1.75));
	thread drop_pod_chooser(var_0A,var_0D,var_10,var_0B,var_0E,var_11,var_0C,var_0F,var_12);
	wait(randomfloatrange(2.75,5));
	common_scripts\utility::flag_set("choose_drop_pod");
	wait(randomfloatrange(4,5.5));
	common_scripts\utility::flag_set("choose_drop_pod");
	wait(3.6);
	level notify("done_choosing_drop_pods");
	common_scripts\utility::flag_set("wave2_pods_done");
	common_scripts\utility::flag_wait("wave3_pods_starting");
	var_13 = getent("drop_pod_7","targetname");
	var_14 = getent("drop_pod_8","targetname");
	var_15 = getent("drop_pod_9","targetname");
	var_16 = getent(var_13.target,"targetname");
	var_17 = getent(var_14.target,"targetname");
	var_18 = getent(var_15.target,"targetname");
	var_19 = getentarray("drop_pod_7_crater","targetname");
	var_1A = getentarray("drop_pod_8_crater","targetname");
	var_1B = getentarray("drop_pod_9_crater","targetname");
	var_1C = getent("drop_pod_10","targetname");
	var_1D = getentarray("drop_pod_10_crater","targetname");
	thread drop_pod_chooser(var_13,var_16,var_19,var_14,var_17,var_1A,var_15,var_18,var_1B);
	wait(3.6);
	common_scripts\utility::flag_set("choose_drop_pod");
	wait(randomfloatrange(2.75,5));
	common_scripts\utility::flag_set("choose_drop_pod");
	wait(3.6);
	level notify("done_choosing_drop_pods");
	common_scripts\utility::flag_set("wave3_pods_done");
}

//Function Number: 28
drop_pod_chooser(param_00,param_01,param_02,param_03,param_04,param_05,param_06,param_07,param_08)
{
	level endon("done_choosing_drop_pods");
	param_00.valid = 1;
	param_03.valid = 1;
	param_06.valid = 1;
	for(;;)
	{
		if(isdefined(param_00) && level.player worldpointinreticle_circle(param_01.origin,65,200) && param_00.valid == 1)
		{
			param_00 thread drop_pod_fall("enemy",param_02);
			param_00.valid = 0;
		}
		else if(isdefined(param_03) && level.player worldpointinreticle_circle(param_04.origin,65,200) && param_03.valid == 1)
		{
			param_03 thread drop_pod_fall("enemy",param_05);
			param_03.valid = 0;
		}
		else if(isdefined(param_06) && level.player worldpointinreticle_circle(param_07.origin,65,200) && param_06.valid == 1)
		{
			param_06 thread drop_pod_fall("enemy",param_08);
			param_06.valid = 0;
		}
		else if(isdefined(param_00) && param_00.valid == 1)
		{
			param_00 thread drop_pod_fall("enemy",param_02);
			param_00.valid = 0;
		}
		else if(isdefined(param_03) && param_03.valid == 1)
		{
			param_03 thread drop_pod_fall("enemy",param_05);
			param_03.valid = 0;
		}
		else if(isdefined(param_06) && param_06.valid == 1)
		{
			param_06 thread drop_pod_fall("enemy",param_08);
			param_06.valid = 0;
		}
		else
		{
		}

		common_scripts\utility::flag_clear("choose_drop_pod");
		common_scripts\utility::flag_wait("choose_drop_pod");
	}
}

//Function Number: 29
first_response()
{
	self.canjumppath = 1;
	maps\_utility::magic_bullet_shield();
	wait(3);
	maps\_utility::stop_magic_bullet_shield();
}

//Function Number: 30
crash_site_dialogue()
{
	level endon("crash_site_failed");
	level.player endon("death");
	common_scripts\utility::flag_wait("crash_site_battle_start");
	common_scripts\utility::flag_set("obj_start_goto_razorback");
	wait(1);
	thread player_boost_hint();
	thread crash_site_battle_chatter_manager();
	common_scripts\utility::flag_wait("keep_pushing");
	if(!common_scripts\utility::flag("player_loading_cargo"))
	{
		maps\_utility::smart_radio_dialogue("crsh_ss1_heavylosses");
		wait(0.25);
		maps\_utility::smart_radio_dialogue("crsh_iln_makeit");
		maps\_utility::smart_radio_dialogue("crsh_crmk_pushthrough3");
		wait(0.75);
		if(!common_scripts\utility::flag("player_loading_cargo"))
		{
			maps\_utility::smart_radio_dialogue("crsh_ss1_mandown");
		}

		wait(1.5);
		if(!common_scripts\utility::flag("player_loading_cargo"))
		{
			maps\_utility::smart_radio_dialogue("crsh_crmk_gettocargo");
		}
	}

	common_scripts\utility::flag_wait("rz_pilot_vo");
	if(!common_scripts\utility::flag("player_loading_cargo"))
	{
		maps\_utility::smart_radio_dialogue("crsh_grdn5_liftingoff");
		maps\_utility::smart_radio_dialogue("crsh_crmk_yourass");
	}

	var_00 = maps\_utility::make_array("crsh_crmk_cargoahead","crsh_crmk_pushtocargo");
	thread maps\crash_utility::nag_until_flag(var_00,"razorback_start",15,20,5);
}

//Function Number: 31
crash_site_battle_chatter_manager()
{
	level endon("crash_site_failed");
	level.player endon("death");
	thread crash_site_battle_chatter_chooser("crsh_iln_hostileswest","razorback_start",0.75);
	thread crash_site_battle_chatter_chooser("crsh_ss1_southridge","pod4_5_spawned",0.35);
	thread crash_site_battle_chatter_chooser("crsh_ss1_mnorthridge","pod7_spawned",0.35);
	thread crash_site_battle_chatter_north();
	thread crash_site_battle_chatter_south();
	thread crash_site_bg_battle_chatter_north();
	thread crash_site_bg_battle_chatter_south();
}

//Function Number: 32
crash_site_battle_chatter_north()
{
	level endon("crash_site_failed");
	level.player endon("death");
	level endon("right_flank_called");
	level endon("player_pre_loading_cargo");
	var_00 = getent("vol_ambush_combat_north","targetname");
	for(;;)
	{
		var_01 = 0;
		var_02 = maps\_utility::get_living_ai_array("pod_enemies","script_noteworthy");
		foreach(var_04 in var_02)
		{
			if(var_04 istouching(var_00))
			{
				var_01 = var_01 + 1;
			}
		}

		if(var_01 > 12)
		{
			thread crash_site_battle_chatter_chooser("crsh_ss2_supressright");
			level notify("right_flank_called");
		}

		wait(0.05);
	}
}

//Function Number: 33
crash_site_battle_chatter_south()
{
	level endon("crash_site_failed");
	level.player endon("death");
	level endon("left_flank_called");
	level endon("player_pre_loading_cargo");
	level.player endon("death");
	var_00 = getent("vol_ambush_combat_south","targetname");
	for(;;)
	{
		var_01 = 0;
		var_02 = maps\_utility::get_living_ai_array("pod_enemies","script_noteworthy");
		foreach(var_04 in var_02)
		{
			if(var_04 istouching(var_00))
			{
				var_01 = var_01 + 1;
			}
		}

		if(var_01 > 12)
		{
			thread crash_site_battle_chatter_chooser("crsh_crmk_moremen");
			level notify("left_flank_called");
		}

		wait(0.05);
	}
}

//Function Number: 34
crash_site_bg_battle_chatter_north()
{
	level endon("crash_site_failed");
	level.player endon("death");
	level endon("bg_right_flank_called");
	level endon("player_pre_loading_cargo");
	var_00 = getent("vol_bg_combat_north","targetname");
	for(;;)
	{
		var_01 = 0;
		var_02 = maps\_utility::get_living_ai_array("pod_enemies","script_noteworthy");
		var_03 = maps\_utility::get_living_ai_array("background_atlas","script_noteworthy");
		var_02 = common_scripts\utility::array_combine(var_02,var_03);
		foreach(var_05 in var_02)
		{
			if(var_05 istouching(var_00))
			{
				var_01 = var_01 + 1;
			}
		}

		if(var_01 > 6)
		{
			thread crash_site_battle_chatter_chooser("crsh_ss3_hostilesnorth");
			level notify("bg_right_flank_called");
		}

		wait(0.05);
	}
}

//Function Number: 35
crash_site_bg_battle_chatter_south()
{
	level endon("crash_site_failed");
	level.player endon("death");
	level endon("bg_left_flank_called");
	level endon("player_pre_loading_cargo");
	var_00 = getent("vol_bg_combat_south","targetname");
	for(;;)
	{
		var_01 = 0;
		var_02 = maps\_utility::get_living_ai_array("pod_enemies","script_noteworthy");
		var_03 = maps\_utility::get_living_ai_array("background_atlas","script_noteworthy");
		var_02 = common_scripts\utility::array_combine(var_02,var_03);
		foreach(var_05 in var_02)
		{
			if(var_05 istouching(var_00))
			{
				var_01 = var_01 + 1;
			}
		}

		if(var_01 > 6)
		{
			thread crash_site_battle_chatter_chooser("crsh_ss3_hostilesouth");
			level notify("bg_left_flank_called");
		}

		wait(0.05);
	}
}

//Function Number: 36
crash_site_battle_chatter_chooser(param_00,param_01,param_02)
{
	level endon("crash_site_failed");
	level.player endon("death");
	level endon("stop_drone_respawn");
	if(isdefined(param_01))
	{
		common_scripts\utility::flag_wait(param_01);
	}

	if(isdefined(param_02))
	{
		wait(param_02);
	}

	switch(param_00)
	{
		case "crsh_iln_tangoseast":
			maps\_utility::smart_radio_dialogue("crsh_iln_hostileseast");
			break;

		case "crsh_iln_tangoswest":
			maps\_utility::smart_radio_dialogue("crsh_iln_hostileswest");
			break;

		case "crsh_crmk_leftflank":
			maps\_utility::smart_radio_dialogue("crsh_crmk_moremen");
			break;

		case "crsh_ss1_podssouth":
			maps\_utility::smart_radio_dialogue("crsh_ss1_southridge");
			break;

		case "crsh_ss1_podsnorth":
			maps\_utility::smart_radio_dialogue("crsh_ss1_mnorthridge");
			break;

		case "crsh_ss2_rightflank1":
			maps\_utility::smart_radio_dialogue("crsh_ss2_supressright");
			break;

		case "crsh_ss3_hostilesouth1":
			maps\_utility::smart_radio_dialogue("crsh_ss3_hostilesouth");
			break;

		case "crsh_ss3_hostilesnorth1":
			maps\_utility::smart_radio_dialogue("crsh_ss3_hostilesnorth");
			break;
	}
}

//Function Number: 37
player_boost_hint()
{
	level.player maps\_utility::hintdisplayhandler("boost_jump",4);
}

//Function Number: 38
should_break_boost_jump_hint()
{
	return level.player ishighjumping();
}

//Function Number: 39
crash_site_bg_warbirds()
{
	thread crash_site_bg_warbird_2();
	wait(5);
	thread crash_site_bg_warbird_1();
	wait(5);
	thread crash_site_bg_warbird_3();
}

//Function Number: 40
crash_site_bg_warbird_1()
{
	var_00 = maps\_vehicle::spawn_vehicle_from_targetname("bg_warbird_1");
	var_00 maps\_vehicle::godon();
	var_01 = getent("bg_warbird_1_cables","targetname");
	var_02 = getent("bg_warbird_1_walker","targetname");
	var_01 linkto(var_00);
	var_02 linkto(var_00);
	wait 0.05;
	var_00 maps\_utility::vehicle_detachfrompath();
	var_00 vehicle_setspeed(25,15,5);
	var_03 = common_scripts\utility::getstruct("bg_warbird_1_path","targetname");
	var_00 thread maps\_utility::vehicle_dynamicpath(var_03,0);
	common_scripts\utility::flag_wait_any("bg_warbird1_done","player_loading_cargo");
	var_01 delete();
	var_02 delete();
	var_00 delete();
}

//Function Number: 41
crash_site_bg_warbird_2()
{
	var_00 = maps\_vehicle::spawn_vehicle_from_targetname("bg_warbird_2");
	var_00 maps\_vehicle::godon();
	var_01 = getent("bg_warbird_2_cables","targetname");
	var_02 = getent("bg_warbird_2_walker","targetname");
	var_01 linkto(var_00);
	var_02 linkto(var_00);
	wait 0.05;
	var_00 maps\_utility::vehicle_detachfrompath();
	var_00 vehicle_setspeed(25,15,5);
	var_03 = common_scripts\utility::getstruct("bg_warbird_2_path","targetname");
	var_00 thread maps\_utility::vehicle_dynamicpath(var_03,0);
	common_scripts\utility::flag_wait_any("bg_warbird2_done","player_loading_cargo");
	var_01 delete();
	var_02 delete();
	var_00 delete();
}

//Function Number: 42
crash_site_bg_warbird_3()
{
	var_00 = maps\_vehicle::spawn_vehicle_from_targetname("bg_warbird_3");
	var_00 maps\_vehicle::godon();
	var_01 = getent("bg_warbird_3_cables","targetname");
	var_02 = getent("bg_warbird_3_walker","targetname");
	var_01 linkto(var_00);
	var_02 linkto(var_00);
	wait 0.05;
	var_00 maps\_utility::vehicle_detachfrompath();
	var_00 vehicle_setspeed(25,15,5);
	var_03 = common_scripts\utility::getstruct("bg_warbird_3_path","targetname");
	var_00 thread maps\_utility::vehicle_dynamicpath(var_03,0);
	common_scripts\utility::flag_wait_any("bg_warbird3_done","player_loading_cargo");
	var_01 delete();
	var_02 delete();
	var_00 delete();
}

//Function Number: 43
drop_pod_fall(param_00,param_01)
{
	self show();
	var_02 = getent(self.target,"targetname");
	var_03 = common_scripts\utility::spawn_tag_origin();
	var_03 linkto(self);
	playfxontag(common_scripts\utility::getfx("orbital_pod_trail_crsh"),var_03,"tag_origin");
	playfxontag(common_scripts\utility::getfx("smoketrail_groundtoair"),var_03,"tag_origin");
	soundscripts\_snd::snd_message("drop_pod",self);
	self moveto(var_02.origin,2.5);
	wait(2.5);
	stopfxontag(common_scripts\utility::getfx("orbital_pod_trail_crsh"),var_03,"tag_origin");
	stopfxontag(common_scripts\utility::getfx("smoketrail_groundtoair"),var_03,"tag_origin");
	var_04 = common_scripts\utility::spawn_tag_origin();
	var_04.origin = var_04.origin + (0,0,24);
	playfxontag(common_scripts\utility::getfx("drop_pod_landing_impact_snow"),var_04,"tag_origin");
	level.player playrumbleonentity("heavy_1s");
	if(isdefined(param_01))
	{
		foreach(var_06 in param_01)
		{
			var_06 show();
		}
	}

	if(isdefined(self.script_noteworthy) && self.script_noteworthy == "drop_pod_node")
	{
		thread drop_pod_clip();
	}

	wait(0.75);
	level endon("stop_drone_respawn");
	if(!isdefined(param_00))
	{
		var_02 delete();
	}
	else
	{
		var_02 show();
	}

	self delete();
	wait(0.25);
	if(isdefined(param_00) && param_00 == "enemy")
	{
		var_08 = undefined;
		if(isdefined(var_02.script_parameters) && var_02.script_parameters == "no_microwave")
		{
			var_08 = 0;
		}
		else
		{
			var_08 = 1;
		}

		var_02 thread crash_site_drop_pod_enemies(var_08);
	}
	else if(isdefined(param_00) && param_00 == "drone")
	{
		var_09 = getentarray(var_02.target,"targetname");
		foreach(var_0B in var_09)
		{
			if(isdefined(var_0B.script_parameters) && var_0B.script_parameters == "first")
			{
				level thread bunker_respawn_handler(var_0B);
			}
		}
	}
	else if(isdefined(param_00) && param_00 == "mech")
	{
		var_02 thread cave_entry_goliath_spawn();
	}

	wait(0.4);
	stopfxontag(common_scripts\utility::getfx("drop_pod_landing_impact_snow"),var_04,"tag_origin");
	var_03 delete();
	var_04 delete();
}

//Function Number: 44
drop_pod_clip()
{
	var_00 = getent(self.targetname + "_clip","targetname");
	var_00 maps\_utility::ent_flag_init("touching_clip");
	while(!var_00 maps\_utility::ent_flag("touching_clip"))
	{
		if(!level.player istouching(var_00))
		{
			var_00 solid();
			var_00 maps\_utility::ent_flag_set("touching_clip");
		}

		wait 0.05;
	}
}

//Function Number: 45
crash_site_drop_pod_enemies(param_00)
{
	level endon("crash_site_done");
	var_01 = getentarray("pod_spawners","targetname");
	var_02 = common_scripts\utility::getstructarray(self.target,"targetname");
	var_03 = [];
	if(isdefined(var_01[0]) && isdefined(var_02[0]))
	{
		for(var_04 = 0;var_04 < var_01.size;var_04++)
		{
			var_01[var_04].origin = var_02[var_04].origin;
			if(isdefined(var_02[var_04].angles))
			{
				var_01[var_04].angles = var_02[var_04].angles;
			}

			var_03[var_04] = var_01[var_04] maps\_utility::spawn_ai(1);
			common_scripts\utility::add_to_array(var_03,var_03[var_04]);
			if(isdefined(param_00) && param_00 == 1)
			{
				if(randomint(100) < 25)
				{
					var_03[var_04] maps\crash_utility::equip_microwave_grenade();
				}
			}
			else
			{
				var_03[var_04].grenadeammo = 1;
			}

			var_03[var_04] thread crash_site_jump_node_usage_scale(10,1,5);
			if(var_02[var_04].script_noteworthy == "node")
			{
				var_05 = getnode(var_02[var_04].target,"targetname");
				var_03[var_04].goalradius = 32;
				var_03[var_04] setgoalnode(var_05);
				continue;
			}

			if(var_02[var_04].script_noteworthy == "volume")
			{
				var_06 = getent(var_02[var_04].target,"targetname");
				var_03[var_04] setgoalvolumeauto(var_06);
				continue;
			}
		}
	}

	level.pod_enemies = maps\_utility::array_merge(level.pod_enemies,var_03);
}

//Function Number: 46
crash_site_jump_node_usage_scale(param_00,param_01,param_02)
{
	self endon("death");
	self.canjumppath = param_00;
	wait(param_02);
	self.canjumppath = param_01;
}

//Function Number: 47
background_drop_pods()
{
	level endon("stop_drone_respawn");
	level.bg_guys = getentarray("background_atlas","script_noteworthy");
	var_00 = getentarray("drop_pod_background","targetname");
	foreach(var_02 in var_00)
	{
		common_scripts\utility::flag_wait("start_background_elements");
		if(level.start_point == "cave_entry")
		{
			wait(randomfloatrange(0,0.5));
		}
		else
		{
			wait(randomfloatrange(0,7));
		}

		var_02 thread drop_pod_fall("drone");
	}
}

//Function Number: 48
bunker_respawn_handler(param_00)
{
	level endon("cave_entry_done");
	wait(randomfloatrange(0.5,3));
	var_01 = param_00 maps\_utility::try_forever_spawn();
	var_01.baseaccuracy = var_01.baseaccuracy * 0.9;
	var_01.grenadeammo = 0;
	var_02 = getent(param_00.script_linkto,"script_linkname");
	for(;;)
	{
		level.crash_site_drones = common_scripts\utility::add_to_array(level.crash_site_drones,var_01);
		var_03[0] = var_01;
		maps\_utility::waittill_dead_or_dying(var_03);
		level endon("stop_drone_respawn");
		wait(randomfloatrange(0.5,3));
		if(common_scripts\utility::cointoss())
		{
			var_01 = param_00 maps\_utility::try_forever_spawn();
			var_01.baseaccuracy = var_01.baseaccuracy * 0.9;
			var_01.grenadeammo = 0;
			continue;
		}

		var_01 = var_02 maps\_utility::try_forever_spawn();
		var_01.baseaccuracy = var_01.baseaccuracy * 0.9;
		var_01.grenadeammo = 0;
	}
}

//Function Number: 49
crash_site_random_bg_explosion()
{
	level endon("cave_entry_done");
	var_00 = common_scripts\utility::getstructarray("ambient_snow_explosion","targetname");
	common_scripts\utility::flag_wait("fallback_vol_3");
	for(;;)
	{
		var_00 = common_scripts\utility::array_randomize(var_00);
		var_01 = var_00[0] common_scripts\utility::spawn_tag_origin();
		var_01.angles = (-90,0,0);
		level.background_org = var_01;
		playfxontag(common_scripts\utility::getfx("ambient_explosion_snow_01"),var_01,"tag_origin");
		soundscripts\_snd::snd_message("background_explosion",var_01.origin);
		wait(2);
		stopfxontag(common_scripts\utility::getfx("ambient_explosion_snow_01"),var_01,"tag_origin");
		wait(randomintrange(1,6));
		var_01 delete();
	}
}

//Function Number: 50
crash_site_random_playspace_explosion()
{
	level endon("cave_entry_done");
	var_00 = common_scripts\utility::getstructarray("ambient_snow_explosion_playspace","targetname");
	common_scripts\utility::flag_wait("crash_site_battle_start");
	wait(10);
	for(;;)
	{
		var_00 = common_scripts\utility::array_randomize(var_00);
		var_01 = var_00[0] common_scripts\utility::spawn_tag_origin();
		var_01.angles = (-90,0,0);
		level.playspace_org = var_01;
		var_02 = distance2d(level.player.origin,var_01.origin);
		if(var_02 > 448)
		{
			playfxontag(common_scripts\utility::getfx("ambient_exp_snow_playspace"),var_01,"tag_origin");
			soundscripts\_snd::snd_message("playspace_explosion",var_01.origin,var_02);
		}

		wait(randomfloatrange(2,5.5));
		var_01 delete();
	}
}

//Function Number: 51
kill_trigger_array()
{
	level endon("cave_entry_done");
	var_00 = getentarray("crash_site_fail","targetname");
	var_01 = 0;
	common_scripts\utility::flag_wait("crash_site_battle_start");
	for(;;)
	{
		common_scripts\utility::flag_wait("cs_pre_fail_state");
		common_scripts\utility::flag_clear("player_returning_to_map");
		thread maps\_utility::smart_radio_dialogue("crsh_crmk_staywithus");
		maps\_utility::hintdisplayhandler("hint_dont_leave_mission");
		wait(2.5);
		foreach(var_03 in var_00)
		{
			if(level.player istouching(var_03))
			{
				var_01 = 1;
			}
		}

		if(var_01)
		{
			thread maps\_utility::smart_radio_dialogue("crsh_crmk_getback");
			wait(2.75);
			foreach(var_03 in var_00)
			{
				if(level.player istouching(var_03))
				{
					var_01 = 1;
				}
			}

			if(var_01)
			{
				level.cormack maps\_utility::stop_magic_bullet_shield();
				level.ilana maps\_utility::stop_magic_bullet_shield();
				level.cormack kill();
				level.ilana kill();
				level notify("crash_site_failed");
				wait(0.15);
				setdvar("ui_deadquote",&"CRASH_FAIL_ALLIES_KILLED");
				maps\_utility::missionfailedwrapper();
			}
		}

		common_scripts\utility::flag_clear("cs_pre_fail_state");
		common_scripts\utility::flag_set("player_returning_to_map");
		var_01 = 0;
		wait(0.05);
	}
}

//Function Number: 52
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

//Function Number: 53
check_potential_falling_death()
{
	level endon("cave_entry_done");
	var_00 = getent("crash_site_above_hole","targetname");
	for(;;)
	{
		if(level.player istouching(var_00))
		{
			common_scripts\utility::flag_set("above_hole");
		}

		if(!level.player istouching(var_00))
		{
			common_scripts\utility::flag_clear("above_hole");
		}

		wait(0.05);
	}
}

//Function Number: 54
falling_death()
{
	level endon("cave_entry_done");
	var_00 = getent("crash_site_fall_death","targetname");
	for(;;)
	{
		if(level.player istouching(var_00))
		{
			wait(0.5);
			setdvar("ui_deadquote",&"CRASH_FAIL_FALL");
			maps\_utility::missionfailedwrapper();
			level.player thread maps\_player_exo::player_exo_deactivate();
		}

		wait(0.05);
	}
}

//Function Number: 55
begin_cave_entry()
{
	level.player endon("death");
	level.cave_entry_animnode = common_scripts\utility::getstruct("cave_entry_animnode","targetname");
	createthreatbiasgroup("player");
	createthreatbiasgroup("mech");
	createthreatbiasgroup("heroes");
	level.player setthreatbiasgroup("player");
	level.cormack setthreatbiasgroup("heroes");
	level.ilana setthreatbiasgroup("heroes");
	thread razorback_cormack();
	thread razorback_ilana();
	thread razorback_dialogue();
	common_scripts\utility::flag_wait("razorback_loaded");
	wait(4);
	thread cave_entry_goliaths();
	wait(0.25);
	thread cave_entry_sentinel();
	wait(1);
	wait(10);
	wait(1.5);
	common_scripts\utility::flag_set("tank_incoming");
	thread cave_entry_dialogue();
	thread cave_entry_walker_tank();
	common_scripts\utility::flag_wait("tank_firing_missiles");
	level.cormack thread tank_missile_react();
	level.ilana thread tank_missile_react();
	common_scripts\utility::flag_wait("start_bunker_collapse");
	soundscripts\_snd::snd_message("cave_entry");
	common_scripts\utility::flag_set("obj_update_goto_razorback");
	common_scripts\utility::flag_set("obj_end_goto_razorback");
	if(level.currentgen)
	{
		level notify("end_crash_perf_monitor");
	}

	thread cave_entry_scene();
	thread cave_entry_slide_exploders();
	common_scripts\utility::flag_wait("cave_entry_done");
	maps\_utility::battlechatter_off("allies");
	maps\_utility::battlechatter_off("axis");
	level.cormack clearenemy();
	level.ilana clearenemy();
	level.cormack maps\_utility::set_ignoresuppression(0);
	level.cormack maps\_utility::set_ignoreall(0);
	level.ilana maps\_utility::set_ignoresuppression(0);
	level.ilana maps\_utility::set_ignoreall(0);
	level.player setthreatbiasgroup();
	level.cormack setthreatbiasgroup();
	level.ilana setthreatbiasgroup();
}

//Function Number: 56
tank_missile_react()
{
	level endon("start_bunker_collapse");
	maps\_utility::anim_stopanimscripted();
	self allowedstances("stand","crouch");
	var_00 = common_scripts\utility::getstruct("cave_entry_animnode","targetname");
	maps\_utility::set_ignoresuppression(1);
	maps\_utility::set_ignoreall(1);
	var_00 maps\_anim::anim_reach_solo(self,"bunker_spot_missiles");
	var_00 thread maps\_anim::anim_single_solo(self,"bunker_spot_missiles");
}

//Function Number: 57
cave_entry_dialogue()
{
	wait(5);
	maps\_utility::smart_radio_dialogue("crsh_crmk_onhorizon");
	common_scripts\utility::flag_wait("tank_firing_missiles");
	wait(0.2);
	maps\_utility::smart_radio_dialogue("crsh_ss1_incoming");
}

//Function Number: 58
razorback_razorback()
{
	var_00 = maps\_vehicle::spawn_vehicle_from_targetname("crash_site_razorback");
	var_00.animname = "razorback";
	var_00 maps\_anim::setanimtree();
	var_00 maps\_vehicle::godon();
	var_00 vehicle_removebrushmodelcollision();
	level.razorback = var_00;
	wait 0.05;
	var_00 thread vehicle_scripts\_razorback_fx::vfx_red_lights_on();
	var_01 = common_scripts\utility::getstruct("cave_entry_animnode","targetname");
	var_01 maps\_anim::anim_first_frame_solo(var_00,"prebunker_intro_razorback");
	common_scripts\utility::flag_wait("razorback_start");
	var_01 maps\_anim::anim_single_solo(var_00,"prebunker_intro_razorback");
	if(!common_scripts\utility::flag("player_loading_cargo"))
	{
		var_01 thread maps\_anim::anim_loop_solo(var_00,"prebunker_loop_razorback","stop_loop");
	}

	common_scripts\utility::flag_wait("player_loading_cargo");
	var_01 notify("stop_loop");
	var_01 thread maps\_anim::anim_single_solo(var_00,"prebunker_end_razorback");
	var_02 = getent("cs_razorback_clip","targetname");
	var_02 delete();
	wait(6.65);
	wait(7.1);
	var_00 thread vehicle_scripts\_razorback_fx::vfx_rb_thruster_front_light_on(var_00);
	var_00 thread vehicle_scripts\_razorback_fx::vfx_rb_thruster_front_on(var_00);
	playfxontag(common_scripts\utility::getfx("razorback_exhaust_strong"),var_00,"thrusterCenter_BL_FX");
	playfxontag(common_scripts\utility::getfx("razorback_exhaust_strong"),var_00,"thrusterCenter_BR_FX");
	maps\_utility::delaythread(0.1,::vehicle_scripts\_razorback_fx::play_regular_tread_back_rz,var_00);
	maps\_utility::delaythread(0.3,::vehicle_scripts\_razorback_fx::stop_idle_back_thruster_rz,var_00);
	maps\_utility::delaythread(0.05,::vehicle_scripts\_razorback_fx::vfx_razorback_jets_on,var_00);
	var_00 waittillmatch("cargo_hit","single anim");
	common_scripts\utility::flag_set("shoot_razorback");
	wait(2);
	playfxontag(common_scripts\utility::getfx("helicopter_explosion_secondary_small"),var_00,"landinggearcover_kl");
	wait(0.75);
	playfxontag(common_scripts\utility::getfx("smoke_trail_black_heli_emitter"),var_00,"thrustercenter_tl_fx");
	maps\_utility::smart_radio_dialogue_overlap("crsh_grdn5_werehit2");
	wait(1.5);
	maps\_utility::smart_radio_dialogue_overlap("crsh_grdn5_lostread");
	var_00 waittillmatch("end","single anim");
	stopfxontag(common_scripts\utility::getfx("smoke_trail_black_heli_emitter"),var_00,"thrustercenter_tl_fx");
	var_00 notify("death");
	var_00 delete();
}

//Function Number: 59
razorback_cargo()
{
	var_00 = maps\_utility::spawn_anim_model("razor_cargo");
	if(level.start_point != "cave_entry")
	{
		var_00 hide();
	}

	var_01 = common_scripts\utility::getstruct("cave_entry_animnode","targetname");
	var_01 maps\_anim::anim_first_frame_solo(var_00,"prebunker_intro_crate");
	var_02 = getent("cargo_objective","targetname");
	level.razorback_org = var_02;
	common_scripts\utility::flag_wait("unhide_cargo");
	var_00 show();
	common_scripts\utility::flag_wait("player_loading_cargo");
	var_03 = getent("razorback_crate_clip","targetname");
	var_03 delete();
	var_01 maps\_anim::anim_single_solo(var_00,"prebunker_end_crate");
	wait(1.5);
}

//Function Number: 60
razorback_cargo_player()
{
	var_00 = common_scripts\utility::getstruct("cave_entry_animnode","targetname");
	var_01 = maps\_utility::spawn_anim_model("rig");
	var_00 maps\_anim::anim_first_frame_solo(var_01,"prebunker_end_player");
	var_01 hide();
	common_scripts\utility::flag_wait("player_pre_loading_cargo");
	level.player maps\_utility::set_ignoreme(1);
	level.player playerlinktoblend(var_01,"tag_player",0.6);
	level.player enableinvulnerability();
	level.player maps\_shg_utility::setup_player_for_scene(1);
	thread maps\_shg_utility::disable_features_entering_cinema(1);
	var_00 thread maps\_anim::anim_single_solo(var_01,"prebunker_end_player");
	common_scripts\utility::flag_set("player_loading_cargo");
	common_scripts\utility::flag_set("lighting_loading_cargo");
	var_02 = getent("blocking_cargo","targetname");
	var_02 delete();
	level.walkers = [];
	thread mobile_turret_dropoff("warbird_deploy_2_animnode","bunker_warbird_2","bunker_walker_2","deploy_warbird_2_done","warbird2_path_after_turret_deploy");
	wait(0.6);
	var_01 show();
	level.player playerlinktodelta(var_01,"tag_player",1,17,20,20,20);
	var_03 = maps\_utility::get_living_ai_array("pod_enemies","script_noteworthy");
	foreach(var_05 in var_03)
	{
		if(isdefined(var_05) && isalive(var_05) && !level.player islookingat(var_05))
		{
			var_05 kill();
			continue;
		}

		if(isdefined(var_05) && isalive(var_05))
		{
			var_05.grenadeammo = 0;
		}
	}

	var_07 = getent("bunker_badplace_extra","targetname");
	badplace_brush("bunker_badplace2",-1,var_07,"axis");
	wait(2.5);
	thread cave_entry_bunker_battle();
	wait(4.2);
	thread mobile_turret_dropoff("warbird_deploy_1_animnode","bunker_warbird_1","bunker_walker_1","deploy_warbird_1_done","warbird_path_after_turret_deploy");
	var_01 waittillmatch("end","single anim");
	thread maps\_utility::autosave_by_name("razorback2");
	level.player disableinvulnerability();
	level.player unlink();
	var_01 delete();
	level.player allowsprint(1);
	level.player allowprone(1);
	level.player allowcrouch(1);
	level.player allowstand(1);
	thread maps\_shg_utility::enable_features_exiting_cinema(1);
	thread check_player_bunker_position();
}

//Function Number: 61
razorback_rumble(param_00)
{
	var_01 = level.player maps\_utility::get_rumble_ent();
	var_01 maps\_utility::rumble_ramp_to(1,0.75);
	param_00 waittillmatch("releasing_crate","single anim");
	var_01 maps\_utility::set_rumble_intensity(0);
	wait 0.05;
	var_01 delete();
}

//Function Number: 62
razorback_trigger_handler()
{
	var_00 = getent("cargo_trigger","targetname");
	common_scripts\utility::flag_wait_either("cormack_reached","obj_move_dot_razorback");
	var_00 common_scripts\utility::trigger_on();
	var_00 maps\_utility::addhinttrigger(&"CRASH_CARGO_PUSH",&"CRASH_CARGO_PUSH_KEYBOARD");
	var_01 = getent("cargo_objective","targetname");
	maps\player_scripted_anim_util::waittill_trigger_activate_looking_at(var_00,var_01,cos(40),0,1);
	common_scripts\utility::flag_set("player_pre_loading_cargo");
}

//Function Number: 63
check_player_bunker_position()
{
	level endon("cave_entry_done");
	wait(5);
	level.player maps\_utility::set_ignoreme(0);
	setignoremegroup("player","mech");
	var_00 = getent("bunker_badplace","targetname");
	while(!common_scripts\utility::flag("obj_update_goto_razorback"))
	{
		if(!level.player istouching(var_00))
		{
			common_scripts\utility::flag_set("obj_update_goto_razorback");
			maps\_utility::smart_radio_dialogue("crsh_crmk_getoverhere2");
		}

		wait(0.05);
	}

	for(;;)
	{
		while(!level.player istouching(var_00))
		{
			wait(0.05);
			foreach(var_02 in level.walkers)
			{
				self.ai_target_force = level.player;
			}
		}

		wait(0.05);
		while(level.player istouching(var_00))
		{
			wait(0.05);
			foreach(var_02 in level.walkers)
			{
				self.ai_target_force = undefined;
			}
		}
	}
}

//Function Number: 64
razorback_gun_enable(param_00)
{
	setsaveddvar("ammoCounterHide",0);
	level.player enableoffhandweapons();
	level.player enableweapons();
	level.player allowmelee(1);
}

//Function Number: 65
cormack_reached()
{
	level.cormack endon("death");
	wait 0.05;
	var_00 = getnode("cormack_razor_node","targetname");
	level.cormack.goalradius = 64;
	level.cormack setgoalnode(var_00);
	level.cormack waittill("goal");
	if(!common_scripts\utility::flag("player_loading_cargo"))
	{
		var_01 = common_scripts\utility::getstruct("cave_entry_animnode","targetname");
		var_01 maps\_anim::anim_reach_solo(level.cormack,"prebunker_intro_cormack",undefined,1);
	}

	common_scripts\utility::flag_set("cormack_reached");
}

//Function Number: 66
razorback_cormack()
{
	level.cormack endon("death");
	var_00 = common_scripts\utility::getstruct("cave_entry_animnode","targetname");
	level.cormack.animname = "cormack";
	level.cormack maps\_utility::disable_ai_color();
	level.cormack maps\_utility::set_ignoresuppression(1);
	level.cormack maps\_utility::set_ignoreme(1);
	level.cormack maps\_utility::set_ignoreall(1);
	level.cormack maps\_utility::disable_pain();
	level.cormack thread cormack_reached();
	var_01 = getent("razorback_crate_clip","targetname");
	common_scripts\utility::flag_wait_either("cormack_reached","player_loading_cargo");
	if(common_scripts\utility::flag("player_loading_cargo"))
	{
		var_00 maps\_anim::anim_single_solo(level.cormack,"prebunker_start_push_fast_cormack");
	}
	else
	{
		level.cormack bunker_intro_anim(var_00);
		if(!common_scripts\utility::flag("player_loading_cargo"))
		{
			var_00 thread maps\_anim::anim_loop_solo(level.cormack,"prebunker_loop_cormack","stop_loop");
			thread maps\_utility::smart_radio_dialogue("crsh_crmk_givehand");
			var_02 = maps\_utility::make_array("crsh_crmk_helpme","crsh_crmk_overhere2");
			thread maps\crash_utility::nag_until_flag(var_02,"player_pre_loading_cargo",15,20,5);
		}

		common_scripts\utility::flag_wait("player_loading_cargo");
		var_00 notify("stop_loop");
		var_00 maps\_anim::anim_single_solo(level.cormack,"prebunker_start_push_slow_cormack");
	}

	var_03 = getnode("cormack_jump_start","targetname");
	level.cormack.goalradius = 64;
	level.cormack setgoalnode(var_03);
	var_00 maps\_anim::anim_single_solo(level.cormack,"prebunker_end_cormack");
	common_scripts\utility::flag_set("razorback_loaded");
	common_scripts\utility::flag_set("lighting_razorback_loaded");
	wait(1);
	level.cormack waittill("goal");
	level.cormack maps\_utility::set_ignoresuppression(0);
	level.cormack maps\_utility::set_ignoreme(0);
	level.cormack maps\_utility::set_ignoreall(0);
	level.cormack maps\_utility::enable_pain();
	common_scripts\utility::flag_wait("tank_firing_missiles");
	level.cormack maps\_utility::disable_pain();
}

//Function Number: 67
bunker_intro_anim(param_00)
{
	level endon("player_loading_cargo");
	param_00 thread maps\_anim::anim_single_solo(level.cormack,"prebunker_intro_cormack");
	level.cormack waittillmatch("end","single anim");
}

//Function Number: 68
razorback_ilana()
{
	level.ilana endon("death");
	level.ilana maps\_utility::disable_ai_color();
	var_00 = getnode("ilana_jump_start","targetname");
	level.ilana.goalradius = 16;
	level.ilana setgoalnode(var_00);
	level.ilana maps\_utility::set_fixednode_true();
	common_scripts\utility::flag_wait("tank_firing_missiles");
	level.ilana maps\_utility::disable_pain();
}

//Function Number: 69
razorback_dialogue()
{
	level.cormack maps\_utility::set_battlechatter(0);
	maps\_utility::smart_radio_dialogue("crsh_crmk_holdtight");
	common_scripts\utility::flag_wait("razorback_loaded");
	maps\_utility::smart_radio_dialogue("crsh_crmk_cargosecured3");
	maps\_utility::smart_radio_dialogue("crsh_grdn5_liftoff2");
	wait(0.75);
	maps\_utility::smart_radio_dialogue("crsh_crmk_drawfire");
	wait(4);
	level.cormack maps\_utility::smart_dialogue("crsh_crmk_astsincoming");
	level.cormack maps\_utility::set_battlechatter(1);
}

//Function Number: 70
razorback_mech(param_00)
{
	var_01 = getent("razorback_goliath","targetname");
	var_02 = common_scripts\utility::getstruct(var_01.target,"targetname");
	var_01 maps\_utility::add_spawn_function(::razorback_mech_behavior,var_02);
	var_03 = var_01 maps\_utility::spawn_ai(1);
	var_03 maps\_utility::magic_bullet_shield(1);
	var_03.ignoreme = 1;
	var_03.ignoreall = 1;
	thread razorback_mech_missiles(var_03);
	var_03.animname = "goliath";
	level.crash_mechs = common_scripts\utility::add_to_array(level.crash_mechs,var_03);
	var_04 = common_scripts\utility::getstruct("cave_entry_animnode","targetname");
	var_04 maps\_anim::anim_single_solo(var_03,"prebunker_end_mech");
	common_scripts\utility::flag_set("razorback_goliath_done");
}

//Function Number: 71
razorback_mech_missiles(param_00)
{
	var_01 = common_scripts\utility::getstruct("cave_entry_animnode","targetname");
	var_02 = maps\_utility::spawn_anim_model("razor_missiles");
	var_01 maps\_anim::anim_first_frame_solo(var_02,"prebunker_end_missiles");
	var_03 = spawn("script_model",var_02 gettagorigin("j_prop_1"));
	var_03.angles = var_02 gettagangles("j_prop_1");
	var_03 setmodel("npc_exo_armor_rocket_large");
	var_03 linkto(var_02,"j_prop_1");
	var_03 hide();
	var_04 = spawn("script_model",var_02 gettagorigin("j_prop_2"));
	var_04.angles = var_02 gettagangles("j_prop_2");
	var_04 setmodel("npc_exo_armor_rocket_large");
	var_04 linkto(var_02,"j_prop_2");
	var_04 hide();
	var_05 = spawn("script_model",var_02 gettagorigin("j_prop_3"));
	var_05.angles = var_02 gettagangles("j_prop_3");
	var_05 setmodel("npc_exo_armor_rocket_large");
	var_05 linkto(var_02,"j_prop_3");
	var_05 hide();
	var_06 = spawn("script_model",var_02 gettagorigin("j_prop_4"));
	var_06.angles = var_02 gettagangles("j_prop_4");
	var_06 setmodel("npc_exo_armor_rocket_large");
	var_06 linkto(var_02,"j_prop_4");
	var_06 hide();
	var_07 = spawn("script_model",var_02 gettagorigin("j_prop_5"));
	var_07.angles = var_02 gettagangles("j_prop_5");
	var_07 setmodel("npc_exo_armor_rocket_large");
	var_07 linkto(var_02,"j_prop_5");
	var_07 hide();
	var_01 thread maps\_anim::anim_single_solo(var_02,"prebunker_end_missiles");
	var_02 waittillmatch("missile_1_launched","single anim");
	playfx(common_scripts\utility::getfx("javelin_ignition"),var_03.origin);
	playfxontag(common_scripts\utility::getfx("smoketrail_rpg_sp"),var_03,"tag_origin");
	var_03 show();
	soundscripts\_snd::snd_message("mech_fire_missile_first",var_03,param_00);
	var_02 waittillmatch("missile_2_launched","single anim");
	playfx(common_scripts\utility::getfx("javelin_ignition"),var_04.origin);
	playfxontag(common_scripts\utility::getfx("smoketrail_rpg_sp"),var_04,"tag_origin");
	var_04 show();
	soundscripts\_snd::snd_message("mech_fire_missile",var_04,param_00);
	var_02 waittillmatch("missile_3_launched","single anim");
	playfx(common_scripts\utility::getfx("javelin_ignition"),var_05.origin);
	playfxontag(common_scripts\utility::getfx("smoketrail_rpg_sp"),var_05,"tag_origin");
	var_05 show();
	soundscripts\_snd::snd_message("mech_fire_missile",var_05,param_00);
	var_02 waittillmatch("missile_4_launched","single anim");
	playfx(common_scripts\utility::getfx("javelin_ignition"),var_06.origin);
	playfxontag(common_scripts\utility::getfx("smoketrail_rpg_sp"),var_06,"tag_origin");
	var_06 show();
	soundscripts\_snd::snd_message("mech_fire_missile",var_06,param_00);
	var_02 waittillmatch("missile_5_launched","single anim");
	playfx(common_scripts\utility::getfx("javelin_ignition"),var_07.origin);
	playfxontag(common_scripts\utility::getfx("smoketrail_rpg_sp"),var_07,"tag_origin");
	var_07 show();
	soundscripts\_snd::snd_message("mech_fire_missile",var_07,param_00);
	var_02 waittillmatch("missile_1_impact","single anim");
	stopfxontag(common_scripts\utility::getfx("smoketrail_rpg_sp"),var_03,"tag_origin");
	playfxontag(common_scripts\utility::getfx("crash_rocket_explosion_default"),level.razorback,"TAG_MISSILE_1");
	var_03 delete();
	var_02 waittillmatch("missile_2_impact","single anim");
	stopfxontag(common_scripts\utility::getfx("smoketrail_rpg_sp"),var_04,"tag_origin");
	playfxontag(common_scripts\utility::getfx("helicopter_explosion_secondary_small"),level.razorback,"TAG_MISSILE_2");
	var_04 delete();
	var_02 waittillmatch("missile_3_impact","single anim");
	stopfxontag(common_scripts\utility::getfx("smoketrail_rpg_sp"),var_05,"tag_origin");
	playfxontag(common_scripts\utility::getfx("helicopter_explosion_secondary_small"),level.razorback,"TAG_MISSILE_3");
	var_05 delete();
	var_02 waittillmatch("missile_4_impact","single anim");
	stopfxontag(common_scripts\utility::getfx("smoketrail_rpg_sp"),var_06,"tag_origin");
	playfxontag(common_scripts\utility::getfx("helicopter_explosion_secondary_small"),level.razorback,"TAG_MISSILE_4");
	var_06 delete();
	var_02 waittillmatch("missile_5_impact","single anim");
	stopfxontag(common_scripts\utility::getfx("smoketrail_rpg_sp"),var_07,"tag_origin");
	playfxontag(common_scripts\utility::getfx("helicopter_explosion_secondary_small"),level.razorback,"TAG_MISSILE_5");
	var_07 delete();
}

//Function Number: 72
razorback_mech_behavior(param_00)
{
	common_scripts\utility::flag_wait("razorback_goliath_done");
	self setthreatbiasgroup("mech");
	thread maps\_utility::stop_magic_bullet_shield();
	self.ignoreme = 0;
	self.ignoreall = 0;
	self.usechokepoints = 0;
	self.goalradius = 24;
	self setgoalpos(param_00.origin);
	self waittill("goal");
	var_01 = common_scripts\utility::getstruct(param_00.target,"targetname");
	self setgoalpos(var_01.origin);
	self waittill("goal");
	var_02 = common_scripts\utility::getstruct(var_01.target,"targetname");
	self setgoalpos(var_02.origin);
	self waittill("goal");
}

//Function Number: 73
razorback_mech_shoot()
{
	common_scripts\utility::flag_wait("shoot_razorback");
	maps\crash_utility::mech_fire_rockets_special(level.razorback);
}

//Function Number: 74
cave_entry_bunker_battle()
{
	maps\_utility::array_spawn_function_targetname("bunker_enemies",::no_grenades);
	maps\_utility::array_spawn_function_targetname("extra_bunker_allies",::no_grenades);
	maps\_utility::array_spawn_function_targetname("extra_bunker_allies",::bunker_settings);
	if(level.nextgen)
	{
		var_00 = maps\_utility::array_spawn_targetname("bunker_enemies",1);
	}
	else
	{
		var_01 = getentarray("bunker_enemies","targetname");
		var_00 = maps\_utility::array_spawn_cg(var_01,1);
	}

	wait(0.5);
	if(level.nextgen)
	{
		var_02 = maps\_utility::array_spawn_targetname("extra_bunker_allies",1);
		return;
	}

	var_01 = getentarray("extra_bunker_allies","targetname");
	var_02 = maps\_utility::array_spawn_cg(var_01,1);
}

//Function Number: 75
no_grenades()
{
	self.grenadeammo = 0;
}

//Function Number: 76
bunker_settings()
{
	self.goalradius = 16;
	self.script_forcegoal = 1;
	self.script_fixednode = 1;
}

//Function Number: 77
cave_entry_scene()
{
	level.player endon("death");
	level.cormack endon("death");
	level.ilana endon("death");
	var_00 = getent("bunker_badplace","targetname");
	var_01 = getent("left_mech_rocket","targetname");
	var_02 = getent("right_mech_rocket","targetname");
	var_03 = getent("cheat_mech_rocket","targetname");
	var_04 = undefined;
	level.player playrumbleonentity("heavy_2s");
	level.player thread play_fullscreen_mist(4,0,2.5,0.75,0,0);
	level.player thread play_fullscreen_mist(4,0,2.5,0.75,50,70);
	common_scripts\utility::flag_set("cave_entry_anim_start");
	level notify("stop_drone_respawn");
	thread cave_entry_player();
	var_05 = [];
	var_05[0] = level.cormack;
	var_05[1] = level.ilana;
	var_05[3] = maps\_utility::spawn_targetname("shock_goliath",1);
	var_05[3].animname = "goliath";
	var_05[3].ignoreall = 1;
	var_05[3].ignoreme = 1;
	var_05[3] hide();
	var_05[5] = maps\_utility::spawn_anim_model("ice_floor");
	var_06 = getent("cave_entry_floor","targetname");
	var_06 delete();
	level.cormack maps\_utility::anim_stopanimscripted();
	level.ilana maps\_utility::anim_stopanimscripted();
	level.cave_entry_animnode thread maps\_anim::anim_single(var_05,"icecave_enter");
	level.cormack maps\_utility::set_battlechatter(0);
	level.ilana maps\_utility::set_battlechatter(0);
	level.cormack waittillmatch("end","single anim");
	if(level.currentgen)
	{
		maps\_utility::tff_sync();
	}

	level.ilana maps\_utility::set_fixednode_false();
	level.ilana maps\_utility::enable_pain();
	level.cormack maps\_utility::set_fixednode_false();
	level.cormack maps\_utility::enable_pain();
	common_scripts\utility::flag_set("cave_entry_done");
	level notify("moved_indoors");
	thread cave_entry_surface_cleanup();
}

//Function Number: 78
cave_entry_player()
{
	level.player endon("death");
	var_00 = common_scripts\utility::getstruct("cave_entry_teleport_animnode","targetname");
	level.player allowjump(0);
	level.player maps\_shg_utility::setup_player_for_scene();
	var_01 = maps\_utility::spawn_anim_model("rig");
	var_02 = maps\_utility::spawn_anim_model("rig");
	var_01 hide();
	level.cave_entry_animnode thread maps\_anim::anim_single_solo(var_01,"icecave_enter");
	var_00 thread maps\_anim::anim_single_solo(var_02,"icecave_enter");
	thread maps\_shg_utility::disable_features_entering_cinema(1);
	var_03 = level.player getplayerweaponviewmodel();
	var_04 = spawn("script_model",var_02 gettagorigin("tag_sync"));
	var_04.angles = var_02 gettagangles("tag_sync");
	var_04 linkto(var_02,"tag_sync");
	var_04 setmodel(var_03);
	level.player enableinvulnerability();
	level.player playerlinktoblend(var_01,"tag_player",0.5);
	level.player setstance("stand");
	wait(0.5);
	var_01 show();
	var_01 waittillmatch("ice_break","single anim");
	common_scripts\_exploder::exploder(5347);
	common_scripts\_exploder::exploder(2238);
	var_01 waittillmatch("no_control","single anim");
	level.player disableinvulnerability();
	level.player enabledeathshield(1);
	var_01 waittillmatch("player_land","single anim");
	var_05 = newclienthudelem(level.player);
	var_05 setshader("black",1280,720);
	var_05.horzalign = "fullscreen";
	var_05.vertalign = "fullscreen";
	var_05.alpha = 1;
	var_05.foreground = 0;
	level.player playerlinktoabsolute(var_02,"tag_player");
	common_scripts\utility::flag_set("blur_player_vision");
	level.player dodamage(150,level.player.origin);
	wait 0.05;
	level.player playerlinktodelta(var_02,"tag_player",1,20,20,20,15,1);
	wait(0.1);
	var_05.alpha = 0;
	var_05 destroy();
	var_01 waittillmatch("gun_up","single anim");
	var_04 delete();
	level.player_weapons = level.player getweaponslistall();
	foreach(var_07 in level.player_weapons)
	{
		level.player givemaxammo(var_07);
	}

	setsaveddvar("r_gunSightColorEntityScale",0);
	setsaveddvar("r_gunSightColorNoneScale",0);
	setsaveddvar("ammoCounterHide",0);
	level.player enableoffhandweapons();
	level.player enableweapons();
	level.player allowmelee(1);
	var_01 waittillmatch("end","single anim");
	level.player unlink();
	var_01 delete();
	var_02 delete();
	level.player enabledeathshield(0);
	level.player allowjump(1);
	level.player allowsprint(1);
	level.player allowprone(1);
	level.player allowcrouch(1);
	level.player allowstand(1);
	thread maps\_shg_utility::enable_features_exiting_cinema(1);
}

//Function Number: 79
cave_entry_goliath_show(param_00)
{
	param_00 show();
}

//Function Number: 80
play_fullscreen_mist(param_00,param_01,param_02,param_03,param_04,param_05)
{
	level.player endon("death");
	var_06 = newclienthudelem(self);
	var_06.x = param_04;
	var_06.y = param_05;
	var_06 setshader("overlay_rain_blur",640,480);
	var_06.splatter = 1;
	var_06.alignx = "left";
	var_06.aligny = "top";
	var_06.sort = 1;
	var_06.foreground = 0;
	var_06.horzalign = "fullscreen";
	var_06.vertalign = "fullscreen";
	var_06.alpha = 0;
	var_07 = 0;
	if(!isdefined(param_01))
	{
		param_01 = 1;
	}

	if(!isdefined(param_02))
	{
		param_02 = 1;
	}

	if(!isdefined(param_03))
	{
		param_03 = 1;
	}

	var_08 = 0.05;
	if(param_01 > 0)
	{
		var_09 = 0;
		var_0A = param_03 / param_01 / var_08;
		while(var_09 < param_03)
		{
			var_06.alpha = var_09;
			var_09 = var_09 + var_0A;
			wait(var_08);
		}
	}

	var_06.alpha = param_03;
	wait(param_00 - param_01 + param_02);
	if(param_02 > 0)
	{
		var_09 = param_03;
		var_0B = param_03 / param_02 / var_08;
		while(var_09 > 0)
		{
			var_06.alpha = var_09;
			var_09 = var_09 - var_0B;
			wait(var_08);
		}
	}

	var_06.alpha = 0;
	var_06 destroy();
}

//Function Number: 81
cave_entry_sentinel()
{
	level.bunker_guy03.animname = "bunker_guy03";
	if(level.nextgen)
	{
		level.bunker_guy01.ignoreme = 0;
		level.bunker_guy01.grenadeammo = 0;
		level.bunker_guy02.ignoreme = 0;
		level.bunker_guy02.grenadeammo = 0;
	}

	level.bunker_guy03.ignoreme = 0;
	level.bunker_guy03.grenadeammo = 0;
	createthreatbiasgroup("bunker_guys");
	if(level.nextgen)
	{
		level.bunker_guy01 setthreatbiasgroup("bunker_guys");
		level.bunker_guy02 setthreatbiasgroup("bunker_guys");
	}

	level.bunker_guy03 setthreatbiasgroup("bunker_guys");
	if(level.nextgen)
	{
		if(isdefined(level.bunker_guy01.magic_bullet_shield))
		{
			level.bunker_guy01 maps\_utility::stop_magic_bullet_shield();
		}

		if(isdefined(level.bunker_guy02.magic_bullet_shield))
		{
			level.bunker_guy02 maps\_utility::stop_magic_bullet_shield();
		}
	}

	if(isdefined(level.bunker_guy03.magic_bullet_shield))
	{
		level.bunker_guy03 maps\_utility::stop_magic_bullet_shield();
	}
}

//Function Number: 82
cave_entry_goliaths()
{
	level.player endon("death");
	level.crash_mechs = [];
	level.player setthreatbiasgroup("player");
	var_00 = getent("drop_pod_mech_1","targetname");
	var_00 thread drop_pod_fall("mech");
	wait(3.25);
	var_01 = getent("drop_pod_mech_2","targetname");
	var_01 thread drop_pod_fall("mech");
	wait(randomfloatrange(4.5,6.5));
	var_02 = getent("drop_pod_mech_3","targetname");
	var_02 thread drop_pod_fall("mech");
}

//Function Number: 83
cave_entry_goliath_spawn()
{
	var_00 = getent(self.target,"targetname");
	var_01 = common_scripts\utility::getstruct(var_00.target,"targetname");
	var_00 maps\_utility::add_spawn_function(::cave_entry_goliath_behavior,var_01);
	var_02 = var_00 maps\_utility::spawn_ai(1);
	level.crash_mechs = common_scripts\utility::add_to_array(level.crash_mechs,var_02);
}

//Function Number: 84
cave_entry_goliath_behavior(param_00)
{
	self setthreatbiasgroup("mech");
	self.baseaccuracy = self.baseaccuracy * 0.5;
	thread cave_entry_goliath_movement(param_00);
}

//Function Number: 85
cave_entry_goliath_movement(param_00)
{
	self endon("death");
	wait(2);
	setthreatbias("bunker_guys","mech",900000);
	setthreatbias("player","mech",0);
	self.usechokepoints = 0;
	self.goalradius = 72;
	self setgoalpos(param_00.origin);
	self waittill("goal");
	thread cave_entry_goliath_attack();
	common_scripts\utility::flag_wait("tank_incoming");
	self notify("stop_hunting");
	var_01 = common_scripts\utility::getstruct(param_00.target,"targetname");
	self setgoalpos(var_01.origin);
	self waittill("goal");
	setthreatbias("bunker_guys","mech",0);
	setthreatbias("player","mech",0);
	setthreatbias("heroes","mech",90000);
}

//Function Number: 86
cave_entry_goliath_attack()
{
	self endon("death");
	self endon("stop_hunting");
	var_00 = maps\_utility::get_living_ai_array("bunker_allies","targetname");
	var_01 = maps\_utility::get_living_ai_array("extra_bunker_allies","script_noteworthy");
	for(var_02 = common_scripts\utility::array_combine(var_00,var_01);var_02.size > 0;var_02 = common_scripts\utility::array_removeundefined(var_02))
	{
		if(!isdefined(self.enemy))
		{
			var_02 = maps\_utility::array_removedead_or_dying(var_02);
			var_02 = common_scripts\utility::array_removeundefined(var_02);
			var_02 = sortbydistance(var_02,self.origin);
			self.favoriteenemy = var_02[0];
		}

		if(isdefined(self.enemy))
		{
			self setgoalpos(self.enemy.origin);
			self.goalradius = 1250;
			self.goalheight = 81;
		}

		wait(2);
		var_02 = maps\_utility::array_removedead_or_dying(var_02);
	}
}

//Function Number: 87
cave_entry_surface_cleanup()
{
	foreach(var_01 in level.crash_mechs)
	{
		if(isdefined(var_01) && isalive(var_01))
		{
			var_01 delete();
		}
	}

	var_03 = maps\_utility::get_living_ai_array("extra_bunker_allies","script_noteworthy");
	foreach(var_01 in var_03)
	{
		if(isdefined(var_01) && isalive(var_01))
		{
			var_01 delete();
		}
	}

	common_scripts\utility::flag_wait("cave_entry_done");
	wait(0.25);
	foreach(var_01 in level.crash_site_drones)
	{
		if(isdefined(var_01))
		{
			var_01 delete();
		}
	}

	wait 0.05;
	foreach(var_01 in level.bg_guys)
	{
		if(isdefined(var_01))
		{
			var_01 delete();
		}
	}

	var_0A = getaiarray("axis");
	foreach(var_01 in var_0A)
	{
		if(isdefined(var_01) && isalive(var_01))
		{
			var_01 delete();
		}
	}

	if(level.nextgen)
	{
		if(isdefined(level.bunker_guy01) && isalive(level.bunker_guy01))
		{
			if(isdefined(level.bunker_guy01.magic_bullet_shield))
			{
				level.bunker_guy01 thread maps\_utility::stop_magic_bullet_shield();
			}

			wait 0.05;
			level.bunker_guy01 delete();
		}

		if(isdefined(level.bunker_guy02) && isalive(level.bunker_guy02))
		{
			if(isdefined(level.bunker_guy02.magic_bullet_shield))
			{
				level.bunker_guy02 thread maps\_utility::stop_magic_bullet_shield();
			}

			wait 0.05;
			level.bunker_guy02 delete();
		}
	}

	if(isdefined(level.bunker_guy03) && isalive(level.bunker_guy03))
	{
		if(isdefined(level.bunker_guy03.magic_bullet_shield))
		{
			level.bunker_guy03 thread maps\_utility::stop_magic_bullet_shield();
		}

		wait 0.05;
		level.bunker_guy03 delete();
	}

	var_0D = getentarray("drop_pod_bases","script_noteworthy");
	maps\_utility::array_delete(var_0D);
	var_0E = getentarray("crash_site_volumes","script_noteworthy");
	maps\_utility::array_delete(var_0E);
	maps\_utility::stop_exploder(1474);
	maps\_utility::stop_exploder(1066);
	var_0F = getent("player_jetpack","targetname");
	var_0F delete();
	clearallcorpses();
}

//Function Number: 88
cave_entry_slide_exploders()
{
	common_scripts\utility::flag_wait("fall_debris_exploder");
	common_scripts\_exploder::exploder(1190);
}

//Function Number: 89
cave_entry_walker_tank()
{
	level.player endon("death");
	var_00 = maps\_vehicle::spawn_vehicle_from_targetname("cave_walker_tank");
	var_00.animname = "walker_tank";
	var_01 = common_scripts\utility::getstruct("walker_tank_animnode_new","targetname");
	var_02 = var_01 common_scripts\utility::spawn_tag_origin();
	var_00 thread walker_tank_fx();
	var_02 maps\_anim::anim_single_solo(var_00,"fusion_walker_tank_enter");
	var_02 thread maps\_anim::anim_loop_solo(var_00,"fusion_walker_tank_fwd_idle","walker_stop_idle");
	var_00 vehicle_scripts\_walker_tank::enable_firing(0);
	var_00 vehicle_scripts\_walker_tank::disable_firing(-1);
	var_00 vehicle_scripts\_walker_tank::enable_firing(1);
	var_00 vehicle_scripts\_walker_tank::enable_firing(2);
	var_03 = getentarray("walker_cave_target","targetname");
	foreach(var_05 in var_03)
	{
		var_05 setcandamage(1);
		var_05 setcanradiusdamage(1);
	}

	var_07 = 0;
	var_08 = getent("bunker_badplace","targetname");
	while(!level.player istouching(var_08))
	{
		wait(0.05);
	}

	while(!level.player worldpointinreticle_circle(var_00.origin,65,250) && var_07 < 5)
	{
		wait(0.05);
		var_07 = var_07 + 0.05;
	}

	var_00 vehicle_scripts\_walker_tank::disable_firing(0);
	var_00 vehicle_scripts\_walker_tank::disable_firing(-1);
	var_00 vehicle_scripts\_walker_tank::disable_firing(1);
	var_00 vehicle_scripts\_walker_tank::disable_firing(2);
	var_00.missile_auto_reload = 1;
	level.vehicle_missile_launcher[var_00.classname][0].post_fire_function = undefined;
	common_scripts\utility::flag_set("tank_firing_missiles");
	soundscripts\_snd::snd_message("cave_entry_tank_missile",var_03);
	var_00 vehicle_scripts\_walker_tank::fire_missles_at_target_array(var_03,1);
	wait(1);
	common_scripts\utility::flag_set("start_bunker_collapse");
	var_09 = getentarray("walker_cave_target2","targetname");
	wait(0.15);
	var_00 vehicle_scripts\_walker_tank::fire_missles_at_target_array(var_09,1);
	common_scripts\utility::flag_wait("cave_entry_done");
	var_00 notify("stop_vehicle_turret_ai");
	wait(5);
	var_00 delete();
}

//Function Number: 90
walker_tank_fx()
{
	wait(6.47);
	playfxontag(common_scripts\utility::getfx("walker_footstep_snow"),self,"tag_wheel_front_left");
	wait(0.46);
	playfxontag(common_scripts\utility::getfx("walker_footstep_snow"),self,"tag_wheel_front_right");
}

//Function Number: 91
mobile_turret_dropoff(param_00,param_01,param_02,param_03,param_04)
{
	level.player endon("death");
	var_05 = common_scripts\utility::getstruct(param_00,"targetname");
	var_06 = maps\_vehicle::spawn_vehicle_from_targetname(param_01);
	var_06.animname = "warbird_deploy";
	var_06 maps\_vehicle::godon();
	var_06 maps\_vehicle::vehicle_lights_on("running");
	var_06 vehicle_turnengineoff();
	soundscripts\_snd::snd_message("warbird_crash_site",param_01,var_06);
	var_07 = maps\_utility::spawn_anim_model("walker_deploy");
	var_07.animname = "walker_deploy";
	var_08 = maps\_utility::spawn_anim_model("pulley_deploy");
	var_08.animname = "pulley_deploy";
	var_05 maps\_anim::anim_first_frame([var_06,var_08,var_07],"mobile_turret_deploy");
	var_05 thread play_warbird_mobile_turret_dropoff(var_06,var_08,param_03,param_04);
	var_05 maps\_anim::anim_single_solo(var_07,"mobile_turret_deploy");
	var_09 = getent(param_02,"targetname");
	var_09.origin = var_07.origin;
	var_09.angles = var_07.angles;
	var_0A = maps\_vehicle::spawn_vehicle_from_targetname_and_drive(param_02);
	var_0A setvehicleteam("axis");
	var_0A.makemobileturretunusable = 1;
	var_0A maps\_vehicle::godon();
	level.walkers = common_scripts\utility::array_add(level.walkers,var_0A);
	var_07 delete();
	var_0A thread monitor_turret_2_death();
	var_0A thread kill_path_on_death();
	common_scripts\utility::flag_wait("start_bunker_collapse");
	var_0A notify("stop_vehicle_turret_ai");
	common_scripts\utility::flag_wait("cave_entry_done");
	var_0A maps\_vehicle::godoff();
	wait(1.75);
	var_0A dodamage(var_0A.health + 500,var_0A.origin,var_0A);
}

//Function Number: 92
play_warbird_mobile_turret_dropoff(param_00,param_01,param_02,param_03)
{
	maps\_anim::anim_single([param_00,param_01],"mobile_turret_deploy");
	param_01 linkto(param_00);
	param_00 maps\_utility::vehicle_detachfrompath();
	param_00 vehicle_setspeed(60,15,5);
	var_04 = common_scripts\utility::getstruct(param_03,"targetname");
	param_00 thread maps\_utility::vehicle_dynamicpath(var_04,0);
	common_scripts\utility::flag_wait(param_02);
	param_01 delete();
	param_00 delete();
}

//Function Number: 93
monitor_turret_2_death()
{
	self waittill("death");
	common_scripts\utility::flag_set("flag_m_turret_dead");
}

//Function Number: 94
kill_path_on_death()
{
	wait_to_kill_path();
	self notify("newpath");
}

//Function Number: 95
wait_to_kill_path()
{
	self endon("death");
	self endon("driver dead");
	level waittill("eternity");
}