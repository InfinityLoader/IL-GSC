/*******************************************************************
 * Decompiled By: Bog
 * Decompiled File: maps\odin.gsc
 * Game: Call of Duty: Ghosts
 * Platform: Console
 * Function Count: 19
 * Decompile Time: 254 ms
 * Timestamp: 10/27/2023 1:36:41 AM
*******************************************************************/

//Function Number: 1
func_4FDD()
{
	maps\_utility::func_8039("odin");
	maps\createart\odin_art::func_4FDD();
	maps\odin_fx::func_4FDD();
	maps\odin_precache::func_4FDD();
	maps\_utility::default_start();
	maps\_utility::add_start("odin_intro",::func_7A6B,"Odin Intro",::func_5819);
	maps\_utility::add_start("odin_ally",::func_7A69,"Odin Ally",::func_57FA);
	maps\_utility::add_start("odin_escape",::func_7A6A,"Odin Escape",::func_5805);
	maps\_utility::add_start("odin_spin",::start_odin_spin,"Odin Spin",::func_5836);
	maps\_utility::add_start("odin_satellite",::start_odin_satellite,"Odin Satellite",::odin_satellite);
	maps\_load::func_4FDD();
	maps/odin_anim::func_4FDD();
	maps/odin_audio::func_4FDD();
	func_582A();
	odin_flag_inits();
	odin_hint_string_init();
	odin_script_setup();
	maps\odin_fx::fx_init();
	level.player setviewmodel("viewhands_us_space");
}

//Function Number: 2
func_582A()
{
	maps\_space::func_6101();
	maps/odin_intro::func_6D5B();
	maps/odin_ally::func_6D5B();
	maps/odin_escape::func_6D5B();
	maps/odin_spin::func_6D5B();
	maps/odin_satellite::func_6D5B();
	precachestring(&"ODIN_OBJ_RETURN");
	precachestring(&"ODIN_OBJ_SHUTDOWN");
	precachestring(&"ODIN_OBJ_DESTROY");
	precachestring(&"ODIN_OBJ_ESCAPE");
	precachestring(&"ODIN_TITLECARD_1");
	precachestring(&"ODIN_SHROUD_PICKUP");
	precacheitem("microtar_space");
	precacheitem("microtar_space_interior");
	precachemodel("viewhands_us_space");
	precachemodel("body_fed_space_assault_a");
	precachematerial("hud_icon_microtar_space");
	if(maps\_utility::func_47F6())
	{
		precachematerial("space_helmet_glass_01");
	}
}

//Function Number: 3
odin_flag_inits()
{
	maps/odin_intro::func_6D56();
	maps/odin_ally::func_6D56();
	maps/odin_escape::func_6D56();
	maps/odin_spin::func_6D56();
	maps/odin_satellite::func_6D56();
	common_scripts\utility::func_3385("objective_return_to_station");
	common_scripts\utility::func_3385("objective_return_to_station_complete");
	common_scripts\utility::func_3385("objective_shutdown_sat");
	common_scripts\utility::func_3385("objective_destroy_sat");
	common_scripts\utility::func_3385("no_steam_on_death");
	common_scripts\utility::func_3385("no_push_zone");
	common_scripts\utility::func_3385("astronaut_needs_help");
	common_scripts\utility::func_3385("player_has_shroud");
	common_scripts\utility::func_3385("show_custom_weap_splash");
}

//Function Number: 4
odin_hint_string_init()
{
	maps/odin_intro::func_6D58();
	maps/odin_ally::func_6D58();
	maps/odin_escape::func_6D58();
	maps/odin_spin::func_6D58();
	maps/odin_satellite::func_6D58();
}

//Function Number: 5
odin_script_setup()
{
	if(isdefined(level.odin_script_setup))
	{
	}

	level.odin_script_setup = 1;
	level.intro_ent_del = [];
	level.ally_ent_del = [];
	level.var_6A3F = [];
	level.gameskill_breath_func = ::maps/odin_util::odin_breathing_func;
	level.player method_828B(0);
	if(maps\_utility::func_47F6())
	{
		triggerportableradarping("space_helmet_glass_01");
		function_0168("r_mbEnable",2);
		function_0168("r_mbFastEnable",1);
		function_0168("r_mbFastPreset",0);
		function_0168("r_mbCameraRotationInfluence",0.6);
		function_0168("r_mbCameraTranslationInfluence",2);
		function_0168("r_mbViewmodelVelocityScalar",0.04);
		function_0168("r_mbStaticVelocityScalar",0.56);
		function_0168("r_mbViewmodelEnable",1);
		function_0168("r_mbModelVelocityScalar",0.2);
	}

	if(level.start_point == "start_deer" || level.start_point == "start_after_hunt" || level.start_point == "start_woods" || level.start_point == "start_neighborhood" || level.start_point == "start_mansion_ext" || level.start_point == "start_mansion" || level.start_point == "default")
	{
		level.start_point = "odin_intro";
	}

	thread maps\odin_fx::func_4DD9();
	level.player.ignoreme = 0;
	level.player.ignoreall = 0;
	thread func_52E8();
	level.odin_fov = 55;
	level.player.var_3FE7 = 1;
	if(!isdefined(level.var_61E7) || isdefined(level.var_61E7) && level.var_61E7 == 0)
	{
		thread maps\_space_player::init_player_space();
		thread maps\_space_ai::func_44E1();
	}

	maps\_colors::add_cover_node("Path 3D");
	maps\_colors::add_cover_node("Cover Stand 3D");
	maps\_colors::add_cover_node("Cover Right 3D");
	maps\_colors::add_cover_node("Cover Left 3D");
	maps\_colors::add_cover_node("Cover Up 3D");
	maps\_colors::add_cover_node("Exposed 3D");
	function_0168("player_spaceViewHeight",11);
	function_0168("player_spaceCapsuleHeight",30);
	function_0168("phys_gravity_ragdoll",0);
	function_0168("phys_gravity",0);
	function_0168("phys_autoDisableLinear",0.25);
	function_0168("g_gravity",1);
	level.wall_friction_enabled = 1;
	level.wall_friction_trace_dist = 5;
	level.var_8BF3 = 2;
	function_0168("bg_viewBobAmplitudeStanding","0.0 0.0");
	function_0168("bg_viewBobAmplitudeStandingAds","0.0 0.0");
	function_0168("bg_viewBobAmplitudeDucked","0.0 0.0");
	function_0168("bg_viewBobAmplitudeDuckedAds","0.0 0.0");
	function_0168("bg_viewBobAmplitudeSprinting","0.0 0.0");
	function_0168("bg_weaponBobAmplitudeStanding","0.0 0.0");
	function_0168("bg_weaponBobAmplitudeDucked","0.0 0.0");
	function_0168("bg_weaponBobAmplitudeSprinting","0.0 0.0");
	function_0168("bg_weaponBobAmplitudeBase",0);
	function_0168("bg_viewBobMax",0);
	thread maps\_space_player::func_4591();
	level.var_8D43 = level.player.origin[2];
	level.var_2497 = 64;
	level.player thread maps\_space_player::enable_player_space();
	level.player thread maps\_space::func_5F17();
	level.player thread maps\_space::space_hud_enable(1);
	level.player notify("stop_space_breathe");
	level.player.var_8D96 = "microtar_space_interior+acogsmg_sp";
	level.player.var_8D95 = "microtar_space+acogsmg_sp";
	thread maps/odin_spin::func_69D6();
	thread maps/odin_util::odin_control_player_speed();
	if(isdefined(level.var_61E7) && level.var_61E7 == 1)
	{
		level notify("stop_particulates");
		level.player setviewmodel("viewhands_us_space");
		level.var_6AF3["player_rig"] = "viewhands_player_us_space";
	}

	var_00 = getent("ally_0","targetname");
	level.ally = var_00 maps\_utility::func_7766(1);
	level.squad[0] = level.ally;
	level.ally thread maps\_utility::deletable_magic_bullet_shield();
	level.ally thread maps\_utility::func_6EDF("r");
	level.ally thread maps\_space_ai::enable_space();
	level.ally.animname = "odin_ally";
	level.player thread maps/odin_util::func_5EBB();
	level.ally thread maps/odin_util::ally_physics_pulse();
	common_scripts\utility::flag_set("no_steam_on_death");
	level.ally.moveplaybackrate = 1.5;
	thread maps/odin_audio::audio_set_initial_ambience();
	thread maps/odin_util::func_6F25();
	wait(0.1);
}

//Function Number: 6
func_3CD8()
{
	self takeallweapons();
	self giveweapon(level.player.var_8D96);
	self switchtoweapon(level.player.var_8D96);
	self disableweaponpickup();
}

//Function Number: 7
func_7A6B()
{
	func_4A38();
	odin_script_setup();
	maps/odin_intro::func_4760();
}

//Function Number: 8
func_5819()
{
	maps/odin_intro::intro_main();
}

//Function Number: 9
func_7A69()
{
	func_4A38();
	odin_script_setup();
	maps/odin_ally::ally_start();
	thread maps/odin_audio::func_7342();
}

//Function Number: 10
func_57FA()
{
	maps/odin_ally::ally_main();
}

//Function Number: 11
func_7A6A()
{
	func_4A38();
	odin_script_setup();
	maps/odin_escape::func_2FD5();
	thread maps/odin_audio::func_7342();
}

//Function Number: 12
func_5805()
{
	maps/odin_escape::escape_main();
}

//Function Number: 13
start_odin_spin()
{
	func_4A38();
	odin_script_setup();
	maps/odin_spin::func_791F();
	thread maps/odin_audio::func_7342();
}

//Function Number: 14
func_5836()
{
	maps/odin_spin::func_7918();
}

//Function Number: 15
start_odin_satellite()
{
	func_4A38();
	odin_script_setup();
	maps/odin_satellite::func_6A62();
}

//Function Number: 16
odin_satellite()
{
	maps/odin_satellite::func_6A59();
}

//Function Number: 17
func_52E8()
{
	maps\_utility::obj("OBJ_RETURN");
	maps\_utility::obj("OBJ_SHUTDOWN");
	maps\_utility::obj("OBJ_DESTROY");
	waittillframeend;
	var_00 = 0;
	if(level.start_point != "default")
	{
		var_00 = 1;
	}

	if(isdefined(level.var_61E7) && level.var_61E7 == 1)
	{
	}

	level.space_breathing_enabled = 1;
	switch(level.start_point)
	{
		case "default":
		case "odin_intro":
			common_scripts\utility::flag_wait("objective_return_to_station");
			thread add_marker_helper(maps\_utility::obj("OBJ_RETURN"));
			function_0168("compass","1");
			objective_add(maps\_utility::obj("OBJ_RETURN"),"active",&"ODIN_OBJ_RETURN");
			objective_state(maps\_utility::obj("OBJ_RETURN"),"current");
			common_scripts\utility::flag_wait("clear_helper_mark");
			level notify("safe_marker_thread_deletion");
			objective_state(maps\_utility::obj("OBJ_RETURN"),"done");
			var_00 = 0;
			break;

		case "odin_ally":
			if(var_00)
			{
				objective_add(maps\_utility::obj("OBJ_RETURN"),"done",&"ODIN_OBJ_RETURN");
				var_00 = 0;
			}
	
			common_scripts\utility::flag_wait("objective_shutdown_sat");
			objective_add(maps\_utility::obj("OBJ_SHUTDOWN"),"active",&"ODIN_OBJ_SHUTDOWN");
			break;

		case "odin_escape":
			if(var_00)
			{
				objective_add(maps\_utility::obj("OBJ_RETURN"),"done",&"ODIN_OBJ_RETURN");
				objective_add(maps\_utility::obj("OBJ_SHUTDOWN"),"active",&"ODIN_OBJ_SHUTDOWN");
				var_00 = 0;
			}
	
			common_scripts\utility::flag_wait("objective_escape_sat");
			objective_add(maps\_utility::obj("OBJ_SHUTDOWN"),"done",&"ODIN_OBJ_SHUTDOWN");
			wait(1);
			objective_add(maps\_utility::obj("OBJ_SHUTDOWN"),"active",&"ODIN_OBJ_ESCAPE");
			break;

		case "odin_spin":
			if(var_00)
			{
				objective_add(maps\_utility::obj("OBJ_RETURN"),"done",&"ODIN_OBJ_RETURN");
				objective_add(maps\_utility::obj("OBJ_SHUTDOWN"),"active",&"ODIN_OBJ_ESCAPE");
				var_00 = 0;
			}
	
			common_scripts\utility::flag_wait("objective_destroy_sat");
			objective_add(maps\_utility::obj("OBJ_SHUTDOWN"),"done",&"ODIN_OBJ_ESCAPE");
			objective_add(maps\_utility::obj("OBJ_DESTROY"),"active",&"ODIN_OBJ_DESTROY");
			break;

		case "odin_satellite":
			if(var_00)
			{
				objective_add(maps\_utility::obj("OBJ_RETURN"),"done",&"ODIN_OBJ_RETURN");
				objective_add(maps\_utility::obj("OBJ_SHUTDOWN"),"done",&"ODIN_OBJ_ESCAPE");
				objective_add(maps\_utility::obj("OBJ_DESTROY"),"active",&"ODIN_OBJ_DESTROY");
				var_00 = 0;
			}
	
			common_scripts\utility::flag_wait("satellite_end_anim_started");
			wait(2);
			objective_add(maps\_utility::obj("OBJ_DESTROY"),"done",&"ODIN_OBJ_DESTROY");
			break;

		default:
			break;
	}
}

//Function Number: 18
add_marker_helper(param_00)
{
	level endon("safe_marker_thread_deletion");
	common_scripts\utility::flag_wait("astronaut_needs_help");
	var_01 = getent("intro_hatch_door_blocker_org","targetname");
	objective_position(param_00,var_01.origin);
}

//Function Number: 19
func_4A38()
{
	switch(level.start_point)
	{
		case "odin_satellite":
			common_scripts\utility::flag_set("spin_clear");
			thread maps/odin_spin::func_790F(1);
			break;

		case "odin_spin":
			common_scripts\utility::flag_set("escape_clear");
			thread maps/odin_escape::func_2FA5(1);
			break;

		case "odin_escape":
			common_scripts\utility::flag_set("ally_clear");
			thread maps/odin_ally::ally_cleanup(0);
			break;

		case "odin_ally":
			common_scripts\utility::flag_set("invasion_clear");
			thread maps/odin_intro::intro_cleanup(0);
			break;

		case "default":
		case "odin_intro":
		default:
			break;
	}
}