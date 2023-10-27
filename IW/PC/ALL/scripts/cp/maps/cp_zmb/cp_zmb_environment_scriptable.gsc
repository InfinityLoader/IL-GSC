/*******************************************************************
 * Decompiled By: Bog
 * Decompiled File: scripts\cp\maps\cp_zmb\cp_zmb_environment_scriptable.gsc
 * Game: Call of Duty: Infinite Warfare
 * Platform: PC
 * Function Count: 33
 * Decompile Time: 1739 ms
 * Timestamp: 10/27/2023 12:08:12 AM
*******************************************************************/

//Function Number: 1
func_7443(param_00)
{
	playsoundatpos((632,2357,334),"entrance_sign_power_on_build");
	wait(3);
	func_12982();
	wait(2);
	func_13F05();
	wait(3);
	playsoundatpos((579,2387,374),"pa_speaker_power_on");
	playsoundatpos((634,664,255),"pa_speaker_power_on");
	wait(1);
	enablepaspeaker("starting_area");
	enablepaspeaker("cosmic_way");
	scripts\cp\_vo::func_1769("dj_powerswitch_restore_nag","zmb_dj_vo",60,15,2,1);
	scripts\cp\_vo::func_1769("dj_quest_ufo_partsrecovery_start","zmb_dj_vo",180,50,1,1);
	level thread scripts\cp\maps\cp_zmb\cp_zmb_dj::func_573B();
	level notify("jukebox_start");
	level thread func_B218(param_00);
	level thread func_101F3();
	func_F4A1();
}

//Function Number: 2
func_F4A1()
{
	var_00 = getentarray("coaster_ice_monster","targetname");
	var_01 = getentarray("octonian","targetname");
	var_02 = scripts\common\utility::array_combine(var_00,var_01);
	foreach(var_04 in var_02)
	{
		var_04 method_8318(1);
		scripts\common\utility::func_136F7();
	}
}

//Function Number: 3
func_12982()
{
	var_00 = getentarray("global_light","targetname");
	foreach(var_02 in var_00)
	{
		var_02 setscriptablepartstate("root","on");
	}
}

//Function Number: 4
func_13F05()
{
	func_12989();
}

//Function Number: 5
func_12989()
{
	var_00 = getentarray("main_gate","targetname");
	foreach(var_02 in var_00)
	{
		var_02 setscriptablepartstate("main_gate","gate_on");
	}

	for(var_04 = 1;var_04 <= 5;var_04++)
	{
		var_05 = getent("gate_light_0" + var_04,"targetname");
		var_05 setscriptablepartstate("main_gate_light","turning_on");
	}
}

//Function Number: 6
func_8E5F()
{
}

//Function Number: 7
func_BB03()
{
}

//Function Number: 8
func_BB29()
{
	func_12990("sign_cosmiccinema");
	func_12990("sign_roverrampage");
	func_12990("sign_starmission");
	func_12990("sign_escapevelocity");
	func_12990("sign_lunarterrace");
	func_1298E("rocket_diorama");
}

//Function Number: 9
func_BB3D()
{
}

//Function Number: 10
func_BB3E()
{
	playsoundatpos((3548,938,275),"journey_power_on_build");
	wait(5.5);
	playsoundatpos((3850,438,328),"pa_speaker_power_on");
	wait(2);
	enablepaspeaker("journey");
}

//Function Number: 11
func_BB06()
{
}

//Function Number: 12
func_210B()
{
	func_12990("astrocade_signs");
	getent("bfp_cabinet","targetname") setmodel("zmb_game_bowling_for_planets_on");
	wait(1);
	getent("demon_group","targetname") setscriptablepartstate("group","all_on");
	level thread func_D747("arcade_demon");
	wait(1);
	getent("barnstorming_group","targetname") setscriptablepartstate("group","all_on");
	level thread func_D747("arcade_barnstorming");
	wait(1);
	getent("starmaster_group","targetname") setscriptablepartstate("group","all_on");
	level thread func_D747("arcade_starmaster");
	wait(1);
	getent("group_cosmicarc","targetname") setscriptablepartstate("group","all_on");
	level thread func_D747("arcade_cosmic");
	wait(1);
	getent("group_pitfall","targetname") setscriptablepartstate("group","all_on");
	level thread func_D747("arcade_pitfall");
	wait(1);
	getent("group_riverraid","targetname") setscriptablepartstate("group","all_on");
	level thread func_D747("arcade_riverraid");
	wait(1);
	getent("spider_arcade_group","targetname") setscriptablepartstate("group","all_on");
	level thread func_D747("arcade_spider");
	wait(1);
	getent("robottank_group","targetname") setscriptablepartstate("group","all_on");
	level thread func_D747("arcade_robottank");
}

//Function Number: 13
func_D747(param_00)
{
	var_01 = scripts\common\utility::getstructarray(param_00,"script_noteworthy");
	foreach(var_03 in var_01)
	{
		scripts\common\utility::func_136F7();
		var_03.var_D776 = 1;
		if(isdefined(var_03.var_EDE8))
		{
			var_04 = getent(var_03.name,"targetname");
			var_05 = var_03.var_EDE8;
			var_04 setscriptablepartstate("cab" + var_05,"idle");
		}
	}
}

//Function Number: 14
func_210C()
{
	playsoundatpos((2873,-1083,357),"astrocade_power_on_build");
	wait(5.5);
	playsoundatpos((2794,-1428,318),"pa_speaker_power_on");
	wait(2);
	enablepaspeaker("astrocade");
}

//Function Number: 15
func_67C3()
{
	func_101F4();
}

//Function Number: 16
func_E6D9()
{
}

//Function Number: 17
func_67A8()
{
}

//Function Number: 18
func_E67F()
{
	playsoundatpos((-830,-3394,604),"triton_power_on_build");
	wait(5.5);
	playsoundatpos((-1103,-3168,601),"pa_speaker_power_on");
	wait(2);
	enablepaspeaker("triton");
}

//Function Number: 19
func_11303()
{
}

//Function Number: 20
func_B385()
{
	func_101F2();
}

//Function Number: 21
func_B384()
{
	playsoundatpos((-2168,206,668),"kepler_power_on_build");
	wait(5.5);
	playsoundatpos((-2034,-340,534),"pa_speaker_power_on");
	playsoundatpos((-950,1510,428),"pa_speaker_power_on");
	wait(2);
	enablepaspeaker("kepler");
}

//Function Number: 22
init()
{
	level thread func_D749();
}

//Function Number: 23
func_9B5F()
{
	foreach(var_01 in level.var_773B)
	{
		if(!scripts\common\utility::istrue(var_01.var_D776))
		{
			return 0;
		}
	}

	return 1;
}

//Function Number: 24
func_1BF3(param_00)
{
	if(isdefined(param_00))
	{
		if(param_00.var_134FD == "p1_")
		{
			level thread scripts\cp\_vo::try_to_play_vo("poweron_final_valleygirl_1","zmb_dialogue_vo","highest",666,0,0,0,100);
			return;
		}

		if(param_00.var_134FD == "p2_")
		{
			level thread scripts\cp\_vo::try_to_play_vo("poweron_final_nerd_1","zmb_dialogue_vo","highest",666,0,0,0,100);
			return;
		}

		if(param_00.var_134FD == "p3_")
		{
			level thread scripts\cp\_vo::try_to_play_vo("poweron_final_rapper_1","zmb_dialogue_vo","highest",666,0,0,0,100);
			return;
		}

		if(param_00.var_134FD == "p4_")
		{
			level thread scripts\cp\_vo::try_to_play_vo("poweron_final_jock_1","zmb_dialogue_vo","highest",666,0,0,0,100);
			return;
		}

		return;
	}
}

//Function Number: 25
func_D749()
{
	level endon("game_ended");
	var_00 = getent("main_portal_sun","targetname");
	var_00 setmodel("zmb_center_portal_sun_off");
	for(;;)
	{
		level waittill("power_on_scriptable_and_light",var_01,var_02);
		var_03 = func_9B5F();
		if(var_03)
		{
			level thread func_1BF3(var_02);
		}

		var_04 = strtok(var_01,",");
		foreach(var_06 in var_04)
		{
			switch(var_06)
			{
				case "front_gate":
					level thread func_7443(var_02);
					break;
	
				case "hidden_room":
					level thread func_8E5F();
					break;
	
				case "moon":
					level thread func_BB03();
					break;
	
				case "moon_outside_begin":
					level thread func_BB29();
					break;
	
				case "moon_rocket_space":
					level thread func_BB3D();
					break;
	
				case "moon_second":
					level thread func_BB3E();
					break;
	
				case "moon_bridge":
					level thread func_BB06();
					break;
	
				case "arcade":
					level thread func_210B();
					break;
	
				case "arcade_back":
					level thread func_210C();
					break;
	
				case "europa_tunnel":
					level thread func_67C3();
					break;
	
				case "room_europa":
					level thread func_E6D9();
					break;
	
				case "europa_2":
					level thread func_67A8();
					break;
	
				case "roller_coast_back":
					level thread func_E67F();
					break;
	
				case "swamp_stage":
					level thread func_11303();
					break;
	
				case "mars_3":
					level thread func_B385();
					break;
	
				case "mars":
					level thread func_B384();
					break;
			}
		}
	}
}

//Function Number: 26
func_B218(param_00)
{
	if(param_00.var_134FD == "p1_")
	{
		level thread scripts\cp\_vo::try_to_play_vo("poweron_first_valleygirl_1","zmb_dialogue_vo","highest",666,0,0,0,100);
	}
	else if(param_00.var_134FD == "p2_")
	{
		level thread scripts\cp\_vo::try_to_play_vo("poweron_first_nerd_1","zmb_dialogue_vo","highest",666,0,0,0,100);
	}
	else if(param_00.var_134FD == "p3_")
	{
		level thread scripts\cp\_vo::try_to_play_vo("poweron_first_rapper_1","zmb_dialogue_vo","highest",666,0,0,0,100);
	}
	else if(param_00.var_134FD == "p4_")
	{
		level thread scripts\cp\_vo::try_to_play_vo("poweron_first_jock_1","zmb_dialogue_vo","highest",666,0,0,0,100);
	}

	level.var_D745 = 1;
	level scripts\cp\_vo::func_1769("dj_fateandfort_replenish_nag","zmb_dj_vo",180,30,20,1);
	level scripts\cp\_vo::func_1769("dj_ticketbooths_use_nag","zmb_dj_vo",180,60,20,1);
	level scripts\cp\_vo::func_1769("dj_pap_cosmicway_nag","zmb_dj_vo",180,25,20,1);
	level scripts\cp\_vo::func_1769("dj_polarpeaks_use_nag","zmb_dj_vo",180,90,20,1);
}

//Function Number: 27
func_12986(param_00)
{
	var_01 = getentarray(param_00,"targetname");
	foreach(var_03 in var_01)
	{
		if(isdefined(var_03.var_EDED))
		{
			var_04 = var_03.var_EDED;
			var_03 setlightintensity(var_04);
		}
	}
}

//Function Number: 28
func_101F3()
{
	var_00 = getent("main_portal_sun","targetname");
	var_00.angles = (0,0,0);
	var_01 = getent("triton_skull_light","targetname");
	var_02 = getent("triton_sign_light","targetname");
	level thread func_E6F9();
	wait(3);
	var_01 setscriptablepartstate("light","on");
	var_02 setscriptablepartstate("light","on");
	func_1298E("main_street_ball_lights");
	func_1298E("space_depot_main_sign");
	func_1298E("spacedepot_neon_upper");
	func_1298E("spacedepot_neon_lower");
	func_1298E("pitstop_main_sign");
	func_1298E("pitstop_neon_upper");
	func_1298E("pitstop_neon_lower");
	func_1298E("saturn_sundaes_main_sign");
	func_1298E("saturn_sundaes_neon_upper");
	func_1298E("crater_cakes_main_sign");
	func_1298E("crater_cakes_neon_upper");
	level thread scripts\cp\maps\cp_zmb\cp_zmb_coaster::func_1297B();
	var_03 = getent("main_street_monster","targetname");
	var_03 setscriptablepartstate("main","idle2");
}

//Function Number: 29
func_E6F9()
{
	var_00 = getent("main_portal_sun","targetname");
	var_00 setmodel("zmb_center_portal_sun");
	for(;;)
	{
		var_00 rotateyaw(360,10);
		wait(9.95);
	}
}

//Function Number: 30
func_12990(param_00)
{
	var_01 = getentarray(param_00,"targetname");
	foreach(var_03 in var_01)
	{
		wait(randomfloatrange(0.15,0.25));
		var_03 setscriptablepartstate("sign","powered_on");
	}
}

//Function Number: 31
func_1298E(param_00)
{
	var_01 = getentarray(param_00,"targetname");
	foreach(var_03 in var_01)
	{
		wait(randomfloatrange(0.25,0.5));
		var_03 setscriptablepartstate("neon_tube","on");
	}
}

//Function Number: 32
func_101F4()
{
	func_1298E("triton_ceiling_neon");
}

//Function Number: 33
func_101F2()
{
	func_12990("moonlight_cafe_signs");
	func_12990("sign_hyperslopes");
	func_12990("sign_conelord");
	func_12990("chromosphere_sign");
	func_12990("shooting_gallery_sign");
	func_12990("sign_spaceshipsplash");
	getent("chromosphere_mike","targetname") setscriptablepartstate("main","on");
	var_00 = getentarray("octonian","targetname");
	foreach(var_02 in var_00)
	{
		var_02 setscriptablepartstate("body","on");
	}
}