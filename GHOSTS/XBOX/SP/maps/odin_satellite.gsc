/*******************************************************************
 * Decompiled By: Bog
 * Decompiled File: maps\odin_satellite.gsc
 * Game: Call of Duty: Ghosts
 * Platform: Console
 * Function Count: 47
 * Decompile Time: 656 ms
 * Timestamp: 10/27/2023 1:36:55 AM
*******************************************************************/

//Function Number: 1
func_6A62()
{
	maps/odin_util::move_player_to_start_point("start_odin_satellite_new");
	level.player thread maps/odin::func_3CD8();
	wait(0.1);
	maps/odin_util::actor_teleport(level.ally,"sat_finale_ally_tp_node");
	thread maps/odin_spin::func_791D(1);
	thread maps/odin_escape::func_5069("delete");
	common_scripts\utility::flag_set("outline_rcs_lines");
	common_scripts\utility::flag_set("jumpTo_dialogue_skip");
	common_scripts\utility::flag_set("trigger_spacejump");
	common_scripts\utility::flag_set("disable_kyra_leader");
	common_scripts\utility::flag_set("landed_on_satellite");
	wait(5);
	level.ally method_8225(level.ally.origin);
}

//Function Number: 2
func_6D5B()
{
	precachemodel("odin_sat_section_04_a");
	precachemodel("odin_sat_section_04_b");
	precachemodel("odin_sat_section_04_c");
	precachemodel("odin_sat_section_04_d");
	precachemodel("us_space_a_body_cracked");
	precachemodel("odin_thruster_pipes_damaged");
	precachestring(&"ODIN_SATELLITE_TIMEOUT");
	precacherumble("light_1s");
	precacherumble("light_3s");
	level thread maps/odin_sat_section_02_solar_panels_destruction::func_899B();
}

//Function Number: 3
func_6D56()
{
	common_scripts\utility::func_3385("satellite_setup_complete");
	common_scripts\utility::func_3385("jumpTo_dialogue_skip");
	common_scripts\utility::func_3385("stop_wall_pushing");
	common_scripts\utility::func_3385("satellite_clear");
	common_scripts\utility::func_3385("outline_rcs_lines");
	common_scripts\utility::func_3385("satellite_end_anim_started");
	common_scripts\utility::func_3385("first_finale_stage_done");
	common_scripts\utility::func_3385("clear_to_fire_first_rog");
	common_scripts\utility::func_3385("ROG_FIRING");
	common_scripts\utility::func_3385("animated_sequence_complete");
	common_scripts\utility::func_3385("triggered_finale");
	common_scripts\utility::func_3385("player_has_fired");
	common_scripts\utility::func_3385("end_ally_loop_anims");
	common_scripts\utility::func_3385("hide_ally_finale_gun_prop");
	common_scripts\utility::func_3385("show_ally_finale_gun_prop");
	common_scripts\utility::func_3385("ally_at_sat");
	common_scripts\utility::func_3385("reset_ground_to_zip");
	common_scripts\utility::func_3385("ref_ent_for_explosion");
	common_scripts\utility::func_3385("stop_tweaking_player");
	common_scripts\utility::func_3385("damage_line_3");
	common_scripts\utility::func_3385("new_pod_opens");
}

//Function Number: 4
func_6D58()
{
	maps\_utility::add_hint_string("ODIN_RCS_PROMPT",&"ODIN_RCS_PROMPT",::func_582D);
	maps\_utility::add_hint_string("SATELLITE_TIMEOUT",&"ODIN_SATELLITE_TIMEOUT");
}

//Function Number: 5
func_582D()
{
	if(level.player usebuttonpressed())
	{
		return 1;
	}

	return 0;
}

//Function Number: 6
func_6A59()
{
	common_scripts\utility::flag_set("trigger_spacejump");
	common_scripts\utility::flag_set("stop_wall_pushing");
	thread maps\_utility::autosave_by_name("satellite_begin");
	thread func_6A4D();
	thread ending_setup();
	thread func_808C();
	common_scripts\utility::flag_set("animated_sequence_complete");
	func_6A60();
	common_scripts\utility::flag_wait("satellite_end_anim_started");
	level thread maps\odin_fx::func_35DA();
	maps\_utility::func_252F(25,::func_3143);
	wait(31.97);
	common_scripts\utility::flag_set("satellite_clear");
	if(!isdefined(level.var_61E7) || isdefined(level.var_61E7) && level.var_61E7 == 0)
	{
		common_scripts\utility::flag_set("start_transition_to_youngblood");
		maps\_hud_util::fade_out(2,"white");
		maps\_utility::func_55F6();
	}
}

//Function Number: 7
func_3143()
{
	if(!isdefined(level.var_61E7) || isdefined(level.var_61E7) && level.var_61E7 == 0)
	{
	}

	thread maps\_hud_util::fade_out(7,"white");
	function_0195(5,6);
	var_00 = maps\_hud_util::func_3920("white");
	var_00.sort = 1;
	var_00.foreground = 0;
	wait(7.5);
	var_01 = function_016B();
	common_scripts\utility::array_call(var_01,::delete);
	var_02 = getentarray("script_model","classname");
	foreach(var_04 in var_02)
	{
		if(issubstr(var_04.model,"body_fed_space"))
		{
			var_04 delete();
		}
	}

	var_06 = function_016E();
	foreach(var_08 in var_06)
	{
		var_08 delete();
	}

	level.player thread maps\_utility::func_5D23("logo_whoosh_lr");
	wait(0.25);
	function_0195(0,0.05);
	common_scripts\utility::flag_set("start_transition_to_youngblood");
}

//Function Number: 8
func_6A60()
{
	thread maps\_space_player::player_location_check("exterior");
}

//Function Number: 9
func_6A4D()
{
	wait(1);
	if(!common_scripts\utility::flag("jumpTo_dialogue_skip"))
	{
		maps\_utility::smart_radio_dialogue("odin_kyr_atlasmainhowmany");
		maps\_utility::smart_radio_dialogue("odin_atl_23degreesportor");
		maps\_utility::smart_radio_dialogue("odin_kyr_23degreeswelldumpthat");
	}

	common_scripts\utility::flag_wait("outline_rcs_lines");
	level.ally maps\_space_ai::func_762D("odin_kyr_hurryandhelpme","odin_kyr_hurryandhelpme");
	common_scripts\utility::flag_wait("triggered_finale");
	common_scripts\utility::func_337C("hold_satellite_back_thrusters");
	wait(4);
	maps\_utility::smart_radio_dialogue("odin_kyr_coversoffhouston");
	maps\_utility::smart_radio_dialogue("odin_shq_ignitethosercsfuel");
	if(!common_scripts\utility::flag("player_has_fired"))
	{
		level.ally maps\_space_ai::func_762D("odin_kyr_youheardhimbud","odin_kyr_youheardhimbud");
	}

	common_scripts\utility::flag_wait("first_finale_stage_done");
	maps\_utility::smart_radio_dialogue("odin_kyr_shit");
	common_scripts\utility::flag_wait("satellite_end_anim_started");
	wait(0.4);
	maps\_utility::smart_radio_dialogue("odin_kyr_ughh");
	maps\_utility::smart_radio_dialogue("odin_shq_1523");
	maps\_utility::smart_radio_dialogue("odin_ho2_23degrees");
	wait(0.3);
	maps\_utility::smart_radio_dialogue("odin_shq_30degreesofaxis");
	wait(0.5);
	wait(0.5);
	maps\_utility::smart_radio_dialogue("odin_shq_specialistmosleykyra");
}

//Function Number: 10
func_0C23()
{
	level.ally maps\_utility::func_6EFD(8);
	var_00 = [];
	for(var_01 = 0;var_01 < 5;var_01++)
	{
		var_00[var_01] = getnode("ally_sat_trail_" + var_01,"targetname");
	}

	level.ally method_8224(var_00[0]);
	level.ally waittill("goal");
	level.ally method_8224(var_00[1]);
	common_scripts\utility::flag_wait("player_trail_0");
	level.ally method_8224(var_00[4]);
	level.ally waittill("goal");
}

//Function Number: 11
func_5EA3()
{
}

//Function Number: 12
func_845F()
{
	common_scripts\utility::flag_wait("animated_sequence_complete");
	level.player unlink();
	level.player enableweapons();
	thread func_6249();
}

//Function Number: 13
func_6249()
{
	var_00 = getent("player_tube_rip_node","targetname");
	var_01 = 0;
	var_02 = getnode("ally_final_node","targetname");
	level.ally maps\_utility::func_6EF9(var_02);
	while(var_01 == 0)
	{
		common_scripts\utility::flag_set("clear_to_tweak_player");
		var_03 = distance(level.player.origin,var_00.origin);
		if(var_03 >= 0 && var_03 <= 256)
		{
			function_0168("player_swimWaterCurrent",(6000,0,6000));
		}

		if(var_03 >= 257 && var_03 <= 320)
		{
			function_0168("player_swimWaterCurrent",(5000,0,5000));
		}

		if(var_03 >= 321 && var_03 <= 384)
		{
			function_0168("player_swimWaterCurrent",(4000,0,4000));
		}

		if(var_03 >= 385 && var_03 <= 512)
		{
			function_0168("player_swimWaterCurrent",(3000,0,3000));
		}

		if(var_03 >= 513 && var_03 <= 640)
		{
			function_0168("player_swimWaterCurrent",(1500,0,2000));
		}

		if(var_03 >= 641)
		{
			function_0168("player_swimWaterCurrent",(0,0,1000));
			wait(1);
			function_0168("player_swimWaterCurrent",(0,0,0));
			common_scripts\utility::func_337C("clear_to_tweak_player");
			var_01 = 1;
		}

		wait(0.1);
	}
}

//Function Number: 14
func_808B(param_00)
{
	var_01 = maps/odin_util::func_6A53();
	var_01 unlink();
	var_02 = getent("sat_barrel_target","script_noteworthy");
	var_02 unlink();
	var_03 = getentarray("spacejump_sat","targetname");
	var_04 = 700 - param_00 / 5;
	if(var_04 < 20)
	{
		var_04 = 20;
	}

	var_01 moveto(var_02.origin,var_04,0,0);
	var_01 rotateto((0,30,0),var_04 * 0.1,0,0);
	var_05 = 0 - param_00 * 2;
	common_scripts\utility::flag_set("clear_to_tweak_player");
	if(var_05 < -5000)
	{
		var_05 = -5000;
	}

	function_0168("player_swimWaterCurrent",(var_05,0,var_05));
}

//Function Number: 15
func_6A43(param_00)
{
	level endon("start_transition_to_youngblood");
	var_01 = getent("sat_barrel_bottom","script_noteworthy");
	var_02 = var_01.origin[2] - 3500;
	var_03 = var_01.origin[2] - 500;
	var_04 = var_01.origin[2] - 2000;
	var_05 = getentarray("spacejump_sat","targetname");
	var_06 = 0;
	var_07 = 0;
	var_08 = 0;
	while(var_06 == 0)
	{
		if(var_03 > var_01.origin[2] && var_07 == 0)
		{
			var_09 = getentarray("first_to_explode","script_noteworthy");
			thread func_6A40(var_09,0.4);
			var_07 = 1;
			earthquake(0.05,200,level.player.origin,2000);
		}

		if(var_04 > var_01.origin[2] && var_08 == 0)
		{
			common_scripts\utility::flag_set("damage_line_3");
			var_08 = 1;
			earthquake(0.15,200,level.player.origin,2000);
			common_scripts\utility::flag_set("satellite_clear");
		}

		if(var_02 > var_01.origin[2])
		{
			thread func_6A40(var_05,0);
			earthquake(0.25,200,level.player.origin,2000);
			var_06 = 1;
		}

		wait(0.25);
	}
}

//Function Number: 16
func_6A40(param_00,param_01)
{
	foreach(var_03 in param_00)
	{
		if(isdefined(var_03.script_parameters) && var_03.script_parameters == "do_not_explode")
		{
			continue;
		}

		if(var_03.classname == "script_model" || var_03.classname == "script_brushmodel" && var_03.classname != "script_origin")
		{
			var_03 unlink();
		}
	}

	foreach(var_03 in param_00)
	{
		if(isdefined(var_03.script_parameters) && var_03.script_parameters == "do_not_explode")
		{
			var_03 thread func_6A8E(var_03);
			continue;
		}

		if(var_03.classname == "script_model" || var_03.classname == "script_brushmodel" && var_03.classname != "script_origin")
		{
			wait(randomfloatrange(0.1,0.4));
			thread func_6A8E(var_03);
			var_03 unlink();
			var_06 = randomfloatrange(-1000,3000);
			var_07 = randomfloatrange(-3000,3000);
			var_08 = randomfloatrange(2000,10000);
			var_09 = var_03.origin[0] + var_06;
			var_0A = var_03.origin[1] + var_07;
			var_0B = var_03.origin[2] + var_08;
			var_0C = randomfloatrange(20,40);
			var_0D = randomfloatrange(2,4);
			var_0E = randomfloatrange(-1080,1080);
			var_0F = randomintrange(1,3);
			switch(var_0F)
			{
				case 1:
					var_03 rotateroll(var_0E,var_0C,var_0C * 0.25,var_0C * 0.25);
					break;

				case 2:
					var_03 rotatepitch(var_0E,var_0C,var_0C * 0.25,var_0C * 0.25);
					break;

				case 3:
					var_03 rotateyaw(var_0E,var_0C,var_0C * 0.25,var_0C * 0.25);
					break;

				default:
					var_03 rotateroll(var_0E,var_0C,var_0C * 0.25,var_0C * 0.25);
					break;
			}

			var_03 moveto((var_09,var_0A,var_0B),var_0C,0,var_0C * 0.25);
			wait(param_01);
		}
	}
}

//Function Number: 17
func_6A8E(param_00)
{
	if(param_00.classname != "script_brushmodel" && param_00.model != "iss_sail_center" && param_00.model != "fah_sidewalk_tubes_01" && param_00.model != "clk_fusebox_01")
	{
		thread maps/odin_audio::func_7281(param_00);
		wait(randomfloatrange(1,10));
		switch(randomintrange(0,2))
		{
			case 0:
				playfxontag(level._effect["spc_explosion_240"],param_00,"tag_origin");
				break;

			case 1:
				playfxontag(level._effect["spc_explosion_1200"],param_00,"tag_origin");
				break;
		}
	}
}

//Function Number: 18
func_66FB()
{
	var_00 = getent("origin_satellite_waypoint","targetname");
	thread maps/odin_audio::func_7323(var_00);
	thread maps/odin_audio::func_7281(var_00);
	wait(0.6);
	thread maps/odin_audio::func_7281(var_00);
	wait(0.5);
	thread maps/odin_audio::func_7281(var_00);
	wait(0.4);
	thread maps/odin_audio::func_7281(var_00);
	wait(0.3);
	thread maps/odin_audio::func_7281(var_00);
	wait(0.2);
	thread maps/odin_audio::func_7281(var_00);
	wait(0.1);
	thread maps/odin_audio::func_7281(var_00);
	wait(0.3);
	thread maps/odin_audio::func_7281(var_00);
	wait(0.3);
	thread maps/odin_audio::func_7281(var_00);
	wait(0.3);
	thread maps/odin_audio::func_7281(var_00);
	wait(0.3);
	thread maps/odin_audio::func_7281(var_00);
	wait(0.3);
	thread maps/odin_audio::func_7281(var_00);
}

//Function Number: 19
func_808C()
{
	level endon("start_transition_to_youngblood");
	var_00 = getentarray("pod_that_opens_0","script_noteworthy");
	var_01 = getentarray("pod_that_opens_1","script_noteworthy");
	var_02 = getentarray("pod_that_opens_2","script_noteworthy");
	var_03 = getent("pod_that_opens_origin_0","script_noteworthy");
	var_04 = getent("pod_that_opens_origin_1","script_noteworthy");
	var_05 = getent("pod_that_opens_origin_2","script_noteworthy");
	var_06 = getent("pod_cover_target_0","script_noteworthy");
	var_07 = getent("pod_cover_target_1","script_noteworthy");
	var_08 = getent("pod_cover_target_2","script_noteworthy");
	foreach(var_0A in var_00)
	{
		if(var_0A.classname == "script_brushmodel")
		{
			var_0A linkto(var_03);
		}
	}

	foreach(var_0A in var_01)
	{
		if(var_0A.classname == "script_brushmodel")
		{
			var_0A linkto(var_04);
		}
	}

	foreach(var_0A in var_02)
	{
		if(var_0A.classname == "script_brushmodel")
		{
			var_0A linkto(var_05);
		}
	}

	common_scripts\utility::flag_wait("new_pod_opens");
	thread func_6085();
	thread func_808D();
	wait(3);
	var_03 moveto(var_06.origin,15,0,10);
	var_04 moveto(var_07.origin,15,0,10);
	var_05 moveto(var_08.origin,15,0,10);
	var_05 rotatepitch(-30,44,0,25);
	wait(6);
	var_03 moveto(var_06.origin,40,0,25);
	var_04 moveto(var_07.origin,40,0,25);
	var_05 moveto(var_07.origin,40,0,25);
	var_03 rotateroll(-25,44,0,25);
	var_04 rotateyaw(-30,44,0,25);
}

//Function Number: 20
func_808D()
{
	common_scripts\utility::exploder("pod_open_warning");
	wait(3);
	common_scripts\utility::exploder("pod_open");
	maps\_utility::func_7C22("pod_open_warning");
}

//Function Number: 21
func_6085()
{
	var_00 = [];
	var_01 = [];
	var_02 = 0;
	for(var_03 = 0;var_03 < 16;var_03++)
	{
		var_04 = getent("second_firing_rod_array_" + var_03,"script_noteworthy");
		var_00[var_03] = var_04;
	}

	while(!common_scripts\utility::flag("damage_line_3"))
	{
		foreach(var_06 in var_00)
		{
			var_01[var_02] = var_06.origin;
			var_02 = var_02 + 1;
		}

		var_02 = 0;
		foreach(var_06 in var_00)
		{
			if(var_02 != 15)
			{
				var_09 = var_02 + 1;
				var_06 moveto(var_01[var_09],8,0,0);
				var_02 = var_09;
				continue;
			}

			var_09 = 0;
			var_06 moveto(var_01[var_09],8,0,0);
			var_02 = 0;
		}

		wait(8);
	}
}

//Function Number: 22
func_7C41(param_00)
{
	if(level.start_point == "odin_satellite")
	{
		wait(3);
	}

	common_scripts\utility::flag_wait("landed_on_satellite");
	while(!common_scripts\utility::flag("triggered_finale"))
	{
		var_01 = distance2d(level.player.origin,param_00.origin);
		if(var_01 >= 384)
		{
			var_02 = maps/odin_util::func_312A(0,10000,maps/odin_util::func_567D(0,1024,var_01 - 384));
			var_02 = var_02 * -1;
			function_0168("player_swimWaterCurrent",(var_02,0,0));
			continue;
		}

		function_0168("player_swimWaterCurrent",(0,0,0));
		wait(0.1);
	}
}

//Function Number: 23
ending_setup()
{
	common_scripts\utility::flag_set("stop_tweaking_player");
	thread ally_finale_movement_setup();
	common_scripts\utility::flag_wait("lgt_flag_spin_over");
	var_00 = getent("sat_top_collision","script_noteworthy");
	var_01 = level.var_57FB;
	var_02 = maps\_utility::func_777F("player_rig");
	level.var_6A3F[level.var_6A3F.size] = var_02;
	var_03 = level.animated_sat_part["odin_sat_cover_01"];
	thread func_7C41(var_03);
	var_04 = [];
	var_04["player_rig"] = var_02;
	var_04["odin_ally"] = level.ally;
	wait(0.05);
	level.animated_sat_part["odin_sat_cover_01"] linkto(var_01);
	level.animated_sat_part["odin_sat_section_01"] linkto(var_01);
	common_scripts\utility::flag_wait("kickoff_player_finale");
	thread maps/odin_audio::func_735C();
	level.player freezecontrols(1);
	var_05 = 0;
	var_02 hide();
	level.player disableweapons();
	var_01 maps\_anim::anim_first_frame_solo(var_02,"satellite_end_start");
	level.player playerlinktoblend(var_02,"tag_player",1.5,0.5,0);
	wait(1.5);
	level.player takeallweapons();
	level.player enableweapons();
	level.player playerlinktodelta(var_02,"tag_player",1,var_05,var_05,var_05,var_05,1);
	var_02 show();
	level notify("player_is_animating_to_sat");
	thread maps/odin_audio::sfx_sat_approach_kyra();
	var_01 maps\_anim::anim_single_solo(var_02,"satellite_end_start");
	thread give_player_new_ref_ent_look(var_02,25,1);
	var_01 thread maps\_anim::anim_loop_solo(var_02,"satellite_end_start_loop","stop_loops");
	var_04["odin_top_cover"] = level.animated_sat_part["odin_sat_cover_01"];
	common_scripts\utility::flag_set("outline_rcs_lines");
	thread maps/odin_audio::func_738E();
	common_scripts\utility::flag_set("end_ally_loop_anims");
	wait(0.05);
	level.ally linkto(var_01);
	thread player_took_too_long_to_open(var_03);
	common_scripts\utility::flag_wait("ally_at_sat");
	var_03 setcursorhint("HINT_NOICON");
	var_03 sethintstring(&"ODIN_RCS_PROMPT");
	var_03 makeusable();
	var_03 waittill("trigger",var_06);
	level.player method_8020(3);
	thread maps/odin_audio::func_7346();
	var_01 notify("stop_loops");
	var_05 = 0;
	level.player lerpviewangleclamp(3,0,0,var_05,var_05,var_05,var_05);
	common_scripts\utility::flag_set("triggered_finale");
	thread func_323B();
	var_03 makeunusable();
	var_00 delete();
	function_0168("hud_showstance",0);
	function_0168("ammoCounterHide",1);
	common_scripts\utility::flag_set("reset_ground_to_zip");
	var_01 maps\_anim::anim_single(var_04,"satellite_end_cover_lift");
	level.player playersetgroundreferenceent(undefined);
	thread func_5809(var_03,var_02);
}

//Function Number: 24
give_player_new_ref_ent_look(param_00,param_01,param_02)
{
	var_03 = common_scripts\utility::func_7836();
	level.player playersetgroundreferenceent(var_03);
	var_03 rotateto(param_00 gettagangles("tag_player"),param_02,0,0);
	wait(param_02);
	level.player freezecontrols(0);
	level.player playersetgroundreferenceent(var_03);
	var_03 linkto(param_00);
	level.player playerlinktodelta(param_00,"tag_player",1,param_01,param_01,param_01,param_01,1);
	wait(0.1);
	level.player method_801F(1,3.2,1.6);
	common_scripts\utility::flag_wait("reset_ground_to_zip");
	wait(3);
	var_03 unlink();
	var_03 rotateto((0,0,0),1,0,0);
	common_scripts\utility::flag_wait("ref_ent_for_explosion");
	var_03.angles = level.player getangles();
	level.player playersetgroundreferenceent(var_03);
	var_03 rotateto(param_00 gettagangles("tag_player"),param_02,0,0);
	wait(param_02);
	var_03 linkto(param_00);
	common_scripts\utility::flag_wait("mus_atmosphere");
	var_03 unlink();
	while(!common_scripts\utility::flag("start_transition_to_youngblood"))
	{
		var_03.angles = param_00 gettagangles("tag_player");
		wait(0.05);
	}

	level.player playersetgroundreferenceent(undefined);
}

//Function Number: 25
func_323B()
{
	while(!common_scripts\utility::flag("satellite_end_anim_started"))
	{
		level.player setweaponammostock(level.player.var_8D95,0);
		level.player setweaponammoclip(level.player.var_8D95,32);
		wait(0.5);
	}
}

//Function Number: 26
ally_finale_movement_setup()
{
	thread func_0C0D();
	level.ally maps\_utility::func_6EFD(1);
	common_scripts\utility::flag_wait("disable_kyra_leader");
	level.ally.moveplaybackrate = 1;
	level.ally maps\_utility::func_2743();
	level.ally method_8225((-9912,-3792,65746));
	ally_first_frame_check();
	level.var_57FB maps\_anim::anim_single_solo(level.ally,"satellite_end_start");
	common_scripts\utility::flag_set("ally_at_sat");
	level.var_57FB maps\_anim::anim_loop_solo(level.ally,"satellite_end_start_loop","stop_loops");
}

//Function Number: 27
ally_first_frame_check()
{
	level endon("player_is_animating_to_sat");
	level.ally waittill("goal");
	level.ally.moveplaybackrate = 1;
	level.var_57FB maps\_anim::anim_reach_solo(level.ally,"satellite_end_start");
}

//Function Number: 28
func_0C0D()
{
	common_scripts\utility::flag_wait("show_ally_finale_gun_prop");
	var_00 = level.var_57FB;
	var_01 = maps\_utility::func_777F("finale_gun");
	level.var_6A3F[level.var_6A3F.size] = var_01;
	var_00 maps\_anim::anim_first_frame_solo(var_01,"satellite_end_start");
	var_00 maps\_anim::anim_single_solo(var_01,"satellite_end_start");
	var_00 thread maps\_anim::anim_loop_solo(var_01,"satellite_end_start_gun_loop","stop_gun");
	common_scripts\utility::flag_wait("hide_ally_finale_gun_prop");
	var_01 hide();
	var_00 notify("stop_gun");
	wait(0.05);
	var_01 delete();
}

//Function Number: 29
ally_gun_hide(param_00)
{
	common_scripts\utility::flag_set("hide_ally_finale_gun_prop");
	level.ally maps\_utility::gun_recall();
}

//Function Number: 30
ally_gun_show(param_00)
{
	common_scripts\utility::flag_set("show_ally_finale_gun_prop");
	level.ally maps\_utility::func_3DFD();
}

//Function Number: 31
ally_finale_logic(param_00)
{
	var_01 = getent("ally_shooting_target","script_noteworthy");
	wait(2);
	while(!common_scripts\utility::flag("first_finale_stage_done"))
	{
		var_02 = randomfloatrange(0.1,0.4);
		level.ally method_81D1(1,var_01.origin,1);
		wait(0.05);
		level.ally method_81D1(1,var_01.origin,1);
		wait(0.05);
		level.ally method_81D1(1,var_01.origin,1);
		wait(var_02);
	}
}

//Function Number: 32
func_5809(param_00,param_01)
{
	thread solar_panel_handling();
	level.ally maps\_utility::func_7C38();
	var_02 = level.var_57FB;
	var_02 notify("stop_loop");
	var_03 = level.var_57FB;
	var_04 = maps\_utility::func_777F("finale_gun");
	level.var_6A3F[level.var_6A3F.size] = var_04;
	var_05 = 25;
	var_06 = getent("sat_thruster_pipe_target","script_noteworthy");
	level.ally maps\_utility::func_2743();
	level.ally unlink();
	var_07 = [];
	var_07["player_rig"] = param_01;
	var_07["odin_ally"] = level.ally;
	var_07["odin_top_cover"] = level.animated_sat_part["odin_sat_cover_01"];
	var_07["odin_top"] = level.animated_sat_part["odin_sat_section_01"];
	var_08 = [];
	var_08["finale_gun"] = var_04;
	thread func_22D3();
	thread ally_finale_logic(param_00);
	level.player giveweapon(level.player.var_8D95);
	level.player switchtoweaponimmediate(level.player.var_8D95);
	level.player playerlinktodelta(param_01,"tag_player",1,var_05,var_05,16,8,1);
	var_02 thread maps\_anim::anim_loop(var_07,"satellite_end_shoot_01","stop_loop");
	func_8B42(1800,15);
	var_02 notify("stop_loop");
	var_07["wires"] = maps\_utility::func_777F("wires");
	level.var_6A3F[level.var_6A3F.size] = var_07["wires"];
	var_07["wires2"] = maps\_utility::func_777F("wires2");
	level.var_6A3F[level.var_6A3F.size] = var_07["wire2"];
	var_07["wires3"] = maps\_utility::func_777F("wires3");
	level.var_6A3F[level.var_6A3F.size] = var_07["wires3"];
	var_07["wires4"] = maps\_utility::func_777F("wires4");
	level.var_6A3F[level.var_6A3F.size] = var_07["wires4"];
	var_07["wires5"] = maps\_utility::func_777F("wires5");
	level.var_6A3F[level.var_6A3F.size] = var_07["wires5"];
	level.ally notify("styptic");
	var_06 setmodel("odin_thruster_pipes_damaged");
	thread func_30D3();
	var_04 hide();
	level.player takeallweapons();
	level.ally maps\_utility::func_3DFD();
	wait(0.05);
	common_scripts\utility::flag_set("first_finale_stage_done");
	thread first_explosion_fx();
	thread maps/odin_audio::func_7360();
	common_scripts\utility::flag_set("ref_ent_for_explosion");
	var_02 maps\_anim::anim_single(var_07,"satellite_end_explosion_01");
	level.player giveweapon(level.player.var_8D95);
	level.player switchtoweaponimmediate(level.player.var_8D95);
	level.player playerlinktodelta(param_01,"tag_player",1,20,-15,40,40,1);
	var_02 thread maps\_anim::anim_loop(var_07,"satellite_end_shoot_02","stop_loop");
	func_8B42(900,5);
	thread maps/odin_audio::func_7361();
	var_02 notify("stop_loop");
	level.ally setmodel("us_space_a_body_cracked");
	thread fx_for_kyra_helmet_cracking();
	thread func_30D3();
	common_scripts\utility::flag_set("mus_atmosphere");
	maps\_utility::autosave_by_name_silent("Odin_completed");
	var_09 = getentarray("sat_ROGS","script_noteworthy");
	var_09[0] hide();
	var_0A = getentarray("spacejump_sat","targetname");
	foreach(var_0C in var_09)
	{
		var_0C linkto(level.animated_sat_part["odin_sat_section_04_base"]);
	}

	foreach(var_0F in var_0A)
	{
		var_0F linkto(level.animated_sat_part["odin_sat_section_04_base"]);
	}

	thread func_3EEC(param_01);
	var_04 show();
	param_00 hide();
	level.player takeallweapons();
	var_02 thread maps\_anim::anim_single(var_08,"satellite_end_explosion_01_gun");
	var_02 thread maps\_anim::anim_single(var_07,"satellite_end_explosion_02");
	var_11 = maps\_utility::func_777F("sat_body");
	level.var_6A3F[level.var_6A3F.size] = var_11;
	var_11 hide();
	var_05 = 30;
	level.player playerlinktodelta(param_01,"tag_player",1,var_05,0,var_05,20,1);
	level.player method_801F(1,3.2,1.6);
	var_02 maps\_anim::anim_first_frame_solo(var_11,"satellite_end_explosion_02_Sat");
	wait(0.05);
	level.var_57FB notify("stop_sat_loops");
	level.animated_sat_part["odin_sat_section_03_rot"] = getent("odin_sat_section_03_rot","script_noteworthy");
	var_02 maps\_anim::anim_first_frame(level.animated_sat_part,"satellite_end_explosion_02");
	wait(0.05);
	var_02 thread maps\_anim::anim_single(level.animated_sat_part,"satellite_end_explosion_02");
	var_02 thread maps\_anim::anim_single_solo(var_11,"satellite_end_explosion_02_Sat");
	thread finale_fx_handling(var_11);
	common_scripts\utility::flag_set("satellite_end_anim_started");
	level notify("finale_completed");
	var_12 = maps/odin_util::func_2BCF();
	var_13 = getent("space_mover","targetname");
	var_13 linkto(var_12);
	var_12 unlink();
	var_12 movex(1200,15,5,0);
	wait(10);
	var_12 movex(3500,15,5,0);
}

//Function Number: 33
fx_for_kyra_helmet_cracking()
{
	playfxontag(level._effect["vfx_kyra_impact_head_space_blood"],level.ally,"tag_eye");
	wait(0.2);
	playfxontag(level._effect["vfx_kyra_impact_head_space_blood"],level.ally,"tag_eye");
	wait(0.2);
	playfxontag(level._effect["vfx_kyra_impact_head_space_blood"],level.ally,"tag_eye");
	wait(0.2);
	playfxontag(level._effect["vfx_kyra_impact_head_space_blood"],level.ally,"tag_eye");
	wait(0.2);
	playfxontag(level._effect["vfx_kyra_impact_head_space_blood"],level.ally,"tag_eye");
	wait(0.8);
	playfxontag(level._effect["vfx_kyra_impact_head_space_blood"],level.ally,"tag_eye");
	wait(0.5);
	for(var_00 = 0;var_00 < 30;var_00++)
	{
		playfxontag(level._effect["vfx_kyra_impact_head_space"],level.ally,"tag_eye");
		wait(randomfloatrange(0.05,0.13));
	}
}

//Function Number: 34
solar_panel_handling()
{
	level thread maps/odin_sat_section_02_solar_panels_destruction::spawnsolarpanelsinit(1);
	common_scripts\utility::flag_wait("mus_atmosphere");
	var_00 = getentarray("dummy_starter_solar","script_noteworthy");
	foreach(var_02 in var_00)
	{
		var_02 hide();
	}

	foreach(var_05 in level.var_3503)
	{
		foreach(var_02 in var_05.panel_array)
		{
			var_02 show();
		}
	}

	wait(2);
	level thread maps/odin_sat_section_02_solar_panels_destruction::destructisolarpanelsinit("odin_sat_section_02_solar_wing_04",4,0);
	wait(1);
	level thread maps/odin_sat_section_02_solar_panels_destruction::destructisolarpanelsinit("odin_sat_section_02_solar_wing_02",4,0);
	wait(0.5);
	level thread maps/odin_sat_section_02_solar_panels_destruction::destructisolarpanelsinit("odin_sat_section_02_solar_wing_01",4,0);
	wait(1.5);
	level thread maps/odin_sat_section_02_solar_panels_destruction::destructisolarpanelsinit("odin_sat_section_02_solar_wing_03",26,1);
}

//Function Number: 35
func_30D3()
{
	level.player playrumbleonentity("heavy_1s");
}

//Function Number: 36
func_3EEC(param_00)
{
	level endon("start_transition_to_youngblood");
	var_01 = 0;
	for(;;)
	{
		var_02 = %odin_satellite_end_explosion_02_player;
		if(var_02 >= 0 && var_02 < 0.25)
		{
			var_03 = randomfloatrange(1,5);
			if(var_03 <= 2)
			{
				level.player playrumbleonentity("light_1s");
				wait(randomfloatrange(0.5,0.9));
			}

			earthquake(0.025,1,level.player.origin,2000);
		}

		if(var_02 >= 0.25 && var_02 < 0.5)
		{
			var_03 = randomfloatrange(1,5);
			if(var_03 <= 2)
			{
				level.player playrumbleonentity("light_1s");
				wait(randomfloatrange(0.5,0.9));
			}

			earthquake(0.05,1,level.player.origin,2000);
		}

		if(var_02 >= 0.5 && var_02 < 0.75)
		{
			var_03 = randomfloatrange(1,5);
			if(var_01 <= 10)
			{
				var_03 = 4;
			}

			if(var_03 == 3)
			{
				level.player playrumbleonentity("heavy_1s");
				wait(0.75);
			}
			else if(var_03 == 1)
			{
				wait(0.55);
			}
			else
			{
				level.player playrumbleonentity("light_1s");
			}

			earthquake(0.1,1,level.player.origin,2000);
			var_01 = var_01 + 1;
		}

		if(var_02 >= 0.75 && var_02 < 1)
		{
			var_03 = randomfloatrange(1,5);
			if(var_03 == 3 || var_03 == 4)
			{
				level.player playrumbleonentity("heavy_1s");
				wait(0.75);
			}
			else if(var_03 == 1)
			{
				wait(0.55);
			}
			else
			{
				level.player playrumbleonentity("light_1s");
			}

			earthquake(0.15,1,level.player.origin,2000);
		}

		if(var_02 == 1)
		{
			break;
		}

		wait(0.25);
	}
}

//Function Number: 37
first_explosion_fx()
{
	maps\odin_fx::fx_sat_rcs_damage_kill();
	var_00 = getent("ally_shooting_target","script_noteworthy");
	var_01 = var_00.origin;
	var_02 = anglestoforward(var_00.angles);
	var_03 = anglestoup(var_00.angles);
	playfx(level._effect["spc_explosion_240"],var_01);
	wait(1);
	var_04 = spawnfx(level._effect["odin_sat_rcs_fuel_fire"],var_01,var_02,var_03);
	triggerfx(var_04);
	common_scripts\utility::flag_wait("satellite_end_anim_started");
	var_04 delete();
	for(var_05 = 1;var_05 < 4;var_05++)
	{
		playfx(level._effect["spc_explosion_1200"],var_01 + common_scripts\utility::randomvector(150));
		wait(randomfloatrange(0.5,1.2));
	}
}

//Function Number: 38
finale_nags()
{
	var_00 = gettime();
	var_01 = var_00 - 900;
	var_02 = 0;
	var_03 = randomfloatrange(5000,10000);
	var_04 = [];
	var_04[0] = "Just shoot the RCS Module, Bud!";
	var_04[1] = "Ensign!  Shoot that module or there wont be anything left!";
	var_04[2] = "Shoot the RCS!  Hurry!";
	var_04[3] = "It\'s going to fire that second payload if we don\'t destabilize it first!!";
	var_04[4] = "Keep shooting, it\'s almost destabilized!";
	var_04[5] = "We\'re too late... The second Payload is firing.";
	while(!common_scripts\utility::flag("first_finale_stage_done"))
	{
		var_01 = gettime() - var_03;
		if(var_01 >= var_00)
		{
			var_05 = randomintrange(0,3);
			if(var_02 == var_05)
			{
				var_05 = randomintrange(0,3);
			}
			else
			{
				var_02 = var_05;
				iprintlnbold("Kyra: " + var_04[var_05]);
				var_00 = gettime();
				var_03 = randomfloatrange(5000,10000);
				var_01 = var_00 - var_03;
			}
		}

		wait(0.01);
	}

	wait(3);
	iprintlnbold("Kyra: " + var_04[4]);
	wait(3);
	var_03 = randomfloatrange(5000,10000);
	while(!common_scripts\utility::flag("satellite_end_anim_started"))
	{
		var_01 = gettime() - var_03;
		if(var_01 >= var_00)
		{
			var_05 = randomintrange(0,3);
			if(var_02 == var_05)
			{
				var_05 = randomintrange(0,3);
			}
			else
			{
				var_02 = var_05;
				iprintlnbold("Kyra: " + var_04[var_05]);
				var_00 = gettime();
				var_03 = randomfloatrange(5000,10000);
				var_01 = var_00 - var_03;
			}
		}

		wait(0.01);
	}
}

//Function Number: 39
func_8B42(param_00,param_01)
{
	level endon("next_finale_stage");
	level endon("thrusters_fully_damaged");
	level endon("start_transition_to_youngblood");
	thread finale_timer(param_01);
	var_02 = 0;
	var_03 = getent("sat_thruster_pipe_target","script_noteworthy");
	var_04 = getent("ally_shooting_target","script_noteworthy");
	var_03 setcandamage(1);
	while(!common_scripts\utility::flag("satellite_end_anim_started"))
	{
		var_03 waittill("damage",var_05,var_06,var_07,var_08,var_09);
		if(var_06 == level.player)
		{
			common_scripts\utility::flag_set("player_has_fired");
			var_02 = var_02 + var_05;
			if(var_02 >= param_00)
			{
				level notify("next_finale_stage");
				common_scripts\utility::func_337C("player_has_fired");
			}
		}
	}
}

//Function Number: 40
finale_timer(param_00)
{
	level endon("next_finale_stage");
	level endon("start_transition_to_youngblood");
	var_01 = gettime();
	var_02 = gettime() - param_00 * 1000;
	for(;;)
	{
		var_02 = gettime() - param_00 * 1000;
		if(var_02 >= var_01)
		{
			break;
		}

		wait(0.05);
	}

	level notify("next_finale_stage");
}

//Function Number: 41
func_22D3()
{
	level endon("start_transition_to_youngblood");
	level thread maps\odin_fx::fx_sat_thrusters_damage();
	var_00 = getent("sat_thruster_pipe_target","script_noteworthy");
	var_01 = getent("ally_shooting_target","script_noteworthy");
	var_02 = common_scripts\utility::func_7836();
	level.var_6A3F[level.var_6A3F.size] = var_02;
	var_02.origin = var_01.origin;
	var_00 setcandamage(1);
	level.fx_sat_rcs_damage = [];
	var_03 = 1;
	var_04 = 1;
	while(!common_scripts\utility::flag("satellite_end_anim_started"))
	{
		var_00 waittill("damage",var_05,var_06,var_07,var_08,var_09);
		if(!common_scripts\utility::flag("rcs_is_damaged"))
		{
			common_scripts\utility::flag_set("rcs_is_damaged");
		}

		if(var_04 == 7)
		{
			maps\odin_fx::fx_sat_rcs_damage(var_03);
			var_03 = var_03 + 1;
			var_04 = 1;
		}
		else
		{
			var_04 = var_04 + 1;
		}

		if(var_06 == level.player)
		{
			if(common_scripts\utility::flag("first_finale_stage_done"))
			{
				maps\odin_fx::fx_sat_rcs_damage_kill();
				thread func_7C25(var_02);
				break;
			}
		}
	}
}

//Function Number: 42
func_7C25(param_00)
{
	common_scripts\utility::flag_wait("satellite_end_anim_started");
	wait(3);
	stopfxontag(common_scripts\utility::func_3AB9("spc_fire_puff_bigger_light"),param_00,"tag_origin");
}

//Function Number: 43
finale_fx_handling(param_00)
{
	level thread maps\odin_fx::func_3664(param_00);
	var_01 = getentarray("finale_fx_point","script_noteworthy");
	var_02 = [];
	for(var_03 = 0;var_03 < var_01.size;var_03++)
	{
		var_04 = common_scripts\utility::func_7836();
		level.var_6A3F[level.var_6A3F.size] = var_04;
		var_02[var_03] = var_04;
		var_04.origin = var_01[var_03].origin;
		var_04.angles = var_01[var_03].angles;
		var_04 unlink();
		var_04 linkto(param_00);
	}

	foreach(var_04 in var_01)
	{
		var_04 delete();
	}

	var_07 = 3;
	var_08 = [];
	var_08[0] = "spc_explosion_1200";
	var_08[1] = "spc_explosion_240";
	while(!common_scripts\utility::flag("satellite_clear"))
	{
		var_09 = randomintrange(0,var_02.size);
		var_0A = randomintrange(0,var_08.size);
		var_0B = randomfloatrange(0.1,var_07);
		playfxontag(common_scripts\utility::func_3AB9(var_08[var_0A]),var_02[var_09],"tag_origin");
		if(var_0A == 0)
		{
		}

		wait(var_0B);
		if(var_07 >= 0.75)
		{
			var_07 = var_07 - 0.5;
		}
	}

	foreach(var_04 in var_02)
	{
		foreach(var_0E in var_08)
		{
			stopfxontag(common_scripts\utility::func_3AB9(var_0E),var_04,"tag_origin");
		}
	}
}

//Function Number: 44
player_took_too_long_to_open(param_00)
{
	var_01 = gettime();
	var_02 = gettime() - 9000;
	var_03 = 0;
	var_04 = 4000;
	var_05 = [];
	var_05[0] = "odin_kyr_comeonbud";
	var_05[1] = "odin_kyr_whatthehellare";
	var_05[2] = "odin_kyr_budineedyour";
	while(!common_scripts\utility::flag("triggered_finale"))
	{
		var_02 = gettime() - var_04;
		if(var_02 >= var_01)
		{
			if(var_03 > 2)
			{
				param_00 hudoutlinedisable();
				param_00 makeunusable();
				thread maps\_utility::smart_radio_dialogue("odin_shq_youretoolatebegin");
				wait(2.5);
				level notify("new_quote_string");
				setdvar("ui_deadquote","@ODIN_SATELLITE_TIMEOUT");
				maps\_utility::func_52F2();
			}

			level.ally maps\_space_ai::func_762D(var_05[var_03],var_05[var_03]);
			var_01 = gettime();
			var_04 = var_04 + 2200;
			var_02 = gettime() - var_04;
			var_03 = var_03 + 1;
		}

		wait(0.01);
	}
}

//Function Number: 45
cover_lift_rumble_1(param_00)
{
	level.player playrumbleonentity("light_1s");
}

//Function Number: 46
cover_lift_rumble_2(param_00)
{
	level.player playrumbleonentity("light_3s");
}

//Function Number: 47
satellite_cleanup(param_00)
{
	if(param_00 == 0)
	{
		common_scripts\utility::flag_wait("clear_for_sat_clean");
		if(isdefined(level.var_6A3F))
		{
			foreach(var_02 in level.var_6A3F)
			{
				if(isdefined(var_02))
				{
					var_02 delete();
				}
			}
		}
	}
}