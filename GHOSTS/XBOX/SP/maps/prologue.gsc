/*******************************************************************
 * Decompiled By: Bog
 * Decompiled File: maps\prologue.gsc
 * Game: Call of Duty: Ghosts
 * Platform: Console
 * Function Count: 4
 * Decompile Time: 62 ms
 * Timestamp: 10/27/2023 1:37:00 AM
*******************************************************************/

//Function Number: 1
func_4FDD()
{
	maps\_utility::func_8039("prologue");
	maps\createart\prologue_art::func_4FDD();
	maps\prologue_fx::func_4FDD();
	maps\prologue_precache::func_4FDD();
	level.var_61E7 = 1;
	maps/youngblood::func_8E99();
	maps\youngblood_fx::func_4FDD();
	maps\odin_fx::func_4FDD();
	precachematerial("logo_game_big");
	precachematerial("logo_game_big_blur_blend");
	if(maps\_utility::func_47F6())
	{
		precachematerial("glare_expand");
		function_0168("r_ssaofadedepth",256);
		function_0168("r_ssaorejectdepth",1024);
	}

	maps/youngblood::func_8E8E();
	maps/odin::func_582A();
	level.player method_8275(0);
	maps\_utility::default_start();
	maps\_utility::add_start("start_deer",::maps/youngblood::func_712C,undefined,::maps/youngblood::func_7A22,"prologue_transient_ground_tr");
	maps\_utility::add_start("start_after_hunt",::maps/youngblood::func_70F2,undefined,::maps/youngblood::func_79EA,"prologue_transient_ground_tr");
	maps\_utility::add_start("start_woods",::maps/youngblood::setup_woods,undefined,::maps/youngblood::func_7ABE,"prologue_transient_ground_tr");
	maps\_utility::add_start("start_neighborhood",::maps/youngblood::setup_neighborhood,undefined,::maps/youngblood::func_7A63,"prologue_transient_ground_tr");
	maps\_utility::add_start("start_mansion_ext",::maps/youngblood::func_7188,undefined,::maps/youngblood::func_7A5B,"prologue_transient_ground_tr");
	maps\_utility::add_start("start_mansion",::maps/youngblood::func_7187,undefined,::maps/youngblood::start_mansion,"prologue_transient_ground_tr");
	maps\_utility::add_start("odin_intro",::maps/odin::func_7A6B,"Odin Intro",::maps/odin::func_5819,"prologue_transient_odin_tr");
	maps\_utility::add_start("odin_ally",::maps/odin::func_7A69,"Odin Ally",::maps/odin::func_57FA,"prologue_transient_odin_tr");
	maps\_utility::add_start("odin_escape",::maps/odin::func_7A6A,"Odin Escape",::maps/odin::func_5805,"prologue_transient_odin_tr");
	maps\_utility::add_start("odin_spin",::maps/odin::start_odin_spin,"Odin Spin",::maps/odin::func_5836,"prologue_transient_odin_tr");
	maps\_utility::add_start("odin_satellite",::maps/odin::start_odin_satellite,"Odin Satellite",::maps/odin::odin_satellite,"prologue_transient_odin_tr");
	maps\_utility::add_start("start_chaos_a",::maps/youngblood::func_7111,undefined,::maps/youngblood::start_chaos_a,"prologue_transient_ground_tr");
	maps\_utility::add_start("start_chaos_b",::maps/youngblood::func_7112,undefined,::maps/youngblood::start_chaos_b,"prologue_transient_ground_tr");
	maps\_utility::add_start("start_pickup",::maps/youngblood::func_719F,undefined,::maps/youngblood::start_pickup,"prologue_transient_ground_tr");
	maps\_utility::add_start("start_test",::maps/youngblood::func_7AA9,undefined);
	maps\_utility::add_start("start_test_area_a",::maps/youngblood::start_test_area_a,undefined);
	maps\_utility::add_start("start_test_area_b",::maps/youngblood::func_7AAF,undefined);
	maps\_utility::func_8258("prologue_transient_odin_tr");
	maps\_utility::func_8258("prologue_transient_ground_tr");
	maps\_load::func_4FDD();
	maps/prologue_audio::func_4FDD();
	maps/youngblood_audio::func_4FDD();
	maps/odin_audio::func_4FDD();
	level.space_breathing_enabled = 0;
	maps/youngblood_anim::func_4FDD();
	maps/odin_anim::func_4FDD();
	maps/odin::odin_flag_inits();
	maps/odin::odin_hint_string_init();
	maps\odin_fx::fx_init();
	thread maps\_space_player::init_player_space();
	thread maps\_space_ai::func_44E1();
	maps/youngblood::func_8E88();
	maps/youngblood::func_8E9A();
	maps/youngblood::func_8E90();
	maps\_drone_deer::func_44DF();
	thread func_61E9();
	thread func_61E8();
	common_scripts\utility::trigger_off("player_push_trigger","script_noteworthy");
	common_scripts\utility::func_3385("transition_from_odin_to_yb_done");
}

//Function Number: 2
func_61E9()
{
	common_scripts\utility::flag_wait("start_transition_to_odin");
	level.pre_odin_pos = level.player.origin;
	level.pre_odin_ang = level.player.angles;
	maps\_utility::func_825B("prologue_transient_ground_tr","prologue_transient_odin_tr");
	level.player freezecontrols(1);
	level.player unlink();
	level.player playersetgroundreferenceent(undefined);
	maps/odin::odin_script_setup();
	common_scripts\utility::flag_set("do_transition_to_odin");
	level.player allowsprint(1);
	wait(1.5);
	function_0168("g_speed",190);
	maps\_utility::func_70BD("r_specularColorScale",2.5,9.01);
	level.player freezecontrols(0);
}

//Function Number: 3
func_61E8()
{
	common_scripts\utility::flag_wait("start_transition_to_youngblood");
	level notify("stop_weapon_drop_scripts");
	maps\_utility::func_70BD("r_specularColorScale",2.5,2.5);
	if(maps\_utility::func_47F6())
	{
		function_0168("r_mbEnable",0);
		triggerportableradarping("glare_expand");
	}

	level.gameskill_breath_func = undefined;
	level.player method_8020(0);
	level.space_breathing_enabled = 0;
	level notify("stop_particulates");
	var_00 = [];
	var_00 = maps\_utility::func_3ABA("space_particulate_player_oneshot");
	var_00 = common_scripts\utility::array_combine(var_00,maps\_utility::func_3ABA("space_particulate_player_view"));
	var_00 = common_scripts\utility::array_combine(var_00,maps\_utility::func_3ABA("space_particulate_player_mov"));
	foreach(var_02 in var_00)
	{
		if(common_scripts\utility::func_36C3(var_02))
		{
			var_02 common_scripts\utility::func_5B59();
		}
	}

	if(isdefined(level.ally))
	{
		level.ally delete();
	}

	level.player takeallweapons();
	level.player unlink();
	level.player freezecontrols(1);
	level.player maps\_space_player::func_2778();
	function_0168("hud_showStance",0);
	maps/odin_satellite::satellite_cleanup(0);
	common_scripts\utility::func_337C("enable_player_thruster_audio");
	level notify("kill_thrusters");
	if(isdefined(level.sunflare))
	{
		stopfxontag(level._effect["sun_lens_flare"],level.sunflare,"tag_origin");
	}

	thread maps\_utility::func_825B("prologue_transient_odin_tr","prologue_transient_ground_tr");
	maps\_utility::func_252F(2.95,::maps\_utility::smart_radio_dialogue,"youngblood_hsh_readypush2");
	if(isdefined(level.pre_odin_pos))
	{
		level.player method_83BF("youngblood_slomo_impact",0.2);
		level.player common_scripts\utility::delaycall(0.2,::setorigin,level.pre_odin_pos);
		if(isdefined(level.pre_odin_ang))
		{
			level.player common_scripts\utility::delaycall(0.2,::setangles,level.pre_odin_ang);
		}
	}

	wait(6.4);
	level.pre_odin_pos = undefined;
	level.pre_odin_ang = undefined;
	if(isdefined(level.sunflare))
	{
		level.sunflare delete();
	}

	common_scripts\utility::flag_wait("prologue_transient_ground_tr_loaded");
	level.player method_829D();
	maps/odin_util::move_player_to_start_point("player_back_to_earth_tp");
	function_0168("player_spaceViewHeight",60);
	function_0168("player_spaceCapsuleHeight",70);
	function_0168("phys_gravity_ragdoll",-800);
	function_0168("phys_gravity",-800);
	function_0168("phys_autoDisableLinear",20);
	function_0168("g_gravity",800);
	function_0168("g_speed",190);
	level.player setmovespeedscale(1);
	function_0168("bg_viewBobAmplitudeStanding","0.007 0.007");
	function_0168("bg_viewBobAmplitudeStandingAds","0.007 0.007");
	function_0168("bg_viewBobAmplitudeDucked","0.0075 0.0075");
	function_0168("bg_viewBobAmplitudeDuckedAds","0.0075 0.0075");
	function_0168("bg_viewBobAmplitudeSprinting","0.02 0.014");
	function_0168("bg_weaponBobAmplitudeStanding","0.055 0.025");
	function_0168("bg_weaponBobAmplitudeDucked","0.045 0.025");
	function_0168("bg_weaponBobAmplitudeSprinting","0.02 0.014");
	function_0168("bg_weaponBobAmplitudeBase",0.16);
	function_0168("bg_viewBobMax",8);
	earthquake(0.1,0.1,(0,0,0),1);
	common_scripts\utility::flag_set("transition_from_odin_to_yb_done");
}

//Function Number: 4
delete_beginning_ents()
{
	maps\_utility::battlechatter_off();
	animscripts/battlechatter::func_7533();
	var_00 = getentarray();
	iprintlnbold(var_00.size);
	var_01 = common_scripts\utility::func_39BD("yb_ground_volume");
	common_scripts\utility::func_F1B(var_01.fx,::common_scripts\utility::func_5B59);
	wait(1);
	foreach(var_03 in var_00)
	{
		if(var_03 != var_01 && !isplayer(var_03) && var_03 != level.var_5494 && isdefined(var_03.classname) && var_03.classname != "script_origin")
		{
			if(isdefined(var_03.origin))
			{
				level.var_5494.origin = var_03.origin;
				if(level.var_5494 istouching(var_01))
				{
					var_03 delete();
				}
			}
		}
	}
}