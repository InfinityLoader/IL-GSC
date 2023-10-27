/*******************************************************************
 * Decompiled By: Bog
 * Decompiled File: scripts\cp\maps\cp_frontend\cp_frontend.gsc
 * Game: Call of Duty: Infinite Warfare
 * Platform: PC
 * Function Count: 66
 * Decompile Time: 3371 ms
 * Timestamp: 10/27/2023 12:05:49 AM
*******************************************************************/

//Function Number: 1
func_CDA4(param_00)
{
	wait(param_00);
	frontendscenecameracinematic("zombies_lobby_candy_comp");
}

//Function Number: 2
func_1067E(param_00,param_01,param_02)
{
	var_03 = randomint(100) > 50;
	if(isdefined(param_02) && param_02 == "male")
	{
		var_03 = 1;
	}
	else if(isdefined(param_02) && param_02 == "female")
	{
		var_03 = 0;
	}

	if(var_03)
	{
		var_04 = scripts\common\utility::random(level.var_3FA3);
		var_05 = scripts\common\utility::random(level.var_3FA4);
	}
	else
	{
		var_04 = scripts\common\utility::random(level.var_3F9A);
		var_05 = scripts\common\utility::random(level.var_3F9B);
	}

	var_06 = spawn("script_model",(0,0,0));
	var_06.angles = param_00.angles;
	var_06 setmodel(var_04);
	var_06.var_8C59 = spawn("script_model",var_06 gettagorigin("j_spine4"));
	var_06.var_8C59.angles = var_06 gettagangles("j_spine4");
	var_06.var_8C59 setmodel(var_05);
	var_06.var_8C59 linkto(var_06,"j_spine4");
	if(isdefined(param_01))
	{
		var_06.var_86C1 = spawn("script_model",var_06 gettagorigin("tag_weapon_left"));
		var_06.var_86C1.angles = var_06 gettagangles("tag_weapon_left");
		var_06.var_86C1 setmodel("weapon_revolver_wm");
		var_06.var_86C1 linkto(var_06,"tag_weapon_right",(0,0,0),(0,0,0));
	}

	return var_06;
}

//Function Number: 3
func_10823(param_00,param_01)
{
	var_02 = randomint(100) > 50;
	if(isdefined(param_01) && param_01 == "male")
	{
		var_02 = 1;
	}
	else if(isdefined(param_01) && param_01 == "female")
	{
		var_02 = 0;
	}

	if(var_02)
	{
		var_03 = scripts\common\utility::random(level.var_13F3B);
		var_04 = scripts\common\utility::random(level.var_13F3D);
		if(randomint(100) > 70)
		{
			var_05 = undefined;
		}
		else
		{
			var_05 = scripts\common\utility::random(level.var_13F3C);
		}
	}
	else
	{
		var_03 = scripts\common\utility::random(level.var_13F21);
		var_04 = scripts\common\utility::random(level.var_13F23);
		if(randomint(100) > 70)
		{
			var_05 = undefined;
		}
		else
		{
			var_05 = scripts\common\utility::random(level.var_13F22);
		}
	}

	var_06 = spawn("script_model",(0,0,0));
	var_06.angles = param_00.angles;
	var_06 setmodel(var_03);
	var_06.var_8C59 = spawn("script_model",var_06 gettagorigin("j_spine4"));
	var_06.var_8C59.angles = var_06 gettagangles("j_spine4");
	var_06.var_8C59 setmodel(var_04);
	if(isdefined(var_05))
	{
		if(var_02)
		{
			var_07 = "j_spine4";
		}
		else
		{
			var_07 = "j_neck";
		}

		var_06.var_8861 = spawn("script_model",var_06.var_8C59 gettagorigin(var_07));
		var_06.var_8861.angles = var_06.var_8C59 gettagangles(var_07);
		var_06.var_8861 setmodel(var_05);
		var_06.var_8861 linkto(var_06.var_8C59,var_07);
	}

	var_06.var_8C59 linkto(var_06,"j_spine4");
	wait(1);
	playfxontag(level._effect["yellow_eye_glow"],var_06.var_8C59,"j_eyeball_ri");
	playfxontag(level._effect["yellow_eye_glow"],var_06.var_8C59,"j_eyeball_le");
	return var_06;
}

//Function Number: 4
func_F9AA()
{
	level.var_13F40 = getent("mugging_01","targetname");
	level.var_13F41 = getent("mugging_02","targetname");
	level.var_13F42 = getent("mugging_03","targetname");
	func_F9DC();
	level thread func_107F1();
	wait(0.05);
	level thread func_CDA4(2);
	wait(0.05);
	level thread func_10672();
	wait(0.05);
	level thread func_1067F();
	wait(1);
	var_00 = getent("pap_machine","targetname");
	var_00 setscriptablepartstate("machine","upgraded");
	var_00 setscriptablepartstate("reels","on_frontend");
	wait(1);
	var_00 setscriptablepartstate("door","close");
	wait(1);
	var_00 setscriptablepartstate("door","open_idle");
	playfx(level._effect["vfx_zb_sj_smk"],(-26,-330,225),anglestoforward((0,0,0)),anglestoup((0,0,0)));
}

//Function Number: 5
func_F9DC()
{
	level.var_3FA3 = ["c_civ_zur_male_body1_3","c_civ_zur_male_body2_4"];
	level.var_3F9A = ["c_civ_zur_female_body5_3","c_civ_zur_female_body4_1"];
	level.var_3F9B = ["head_female_bc_01","head_female_bc_02"];
	level.var_3FA4 = ["head_bg_var_head_male_bc_02_head_male_bc_05","head_bg_var_head_male_bc_02_head_male_bc_07"];
	level.var_13F3B = ["zmb_male_fullbody_outfit_03_3","zmb_male_fullbody_outfit_01","zmb_male_fullbody_outfit_02_2"];
	level.var_13F21 = ["zmb_female_fullbody_outfit_05","zmb_female_fullbody_outfit_03_3","zmb_female_fullbody_outfit_04"];
	level.var_13F3D = ["zmb_male_head_01"];
	level.var_13F23 = ["zmb_female_head_01","zmb_female_head_02"];
	level.var_13F3C = [];
	level.var_13F22 = ["zmb_female_head_01_hair_boatswaine_blonde","zmb_female_head_01_hair_boatswaine"];
}

//Function Number: 6
func_4EA7()
{
	for(;;)
	{
		if(getdvar("scr_zombie_scene") != "")
		{
			switch(getdvar("scr_zombie_scene"))
			{
				case "mug_1":
					level thread func_BDA9(1);
					setdvar("scr_zombie_scene","");
					break;
	
				case "mug_2":
					level thread func_BDA9(2);
					setdvar("scr_zombie_scene","");
					break;
	
				case "mug_3":
					level thread func_BDA9(3);
					setdvar("scr_zombie_scene","");
					break;
	
				case "shoot_1":
					level thread func_FEC4();
					setdvar("scr_zombie_scene","");
					break;
	
				case "drag_1":
					level thread func_5B17();
					setdvar("scr_zombie_scene","");
					break;
	
				case "drag_2":
					level thread func_5B18();
					setdvar("scr_zombie_scene","");
					break;
			}
		}

		wait(1);
	}
}

//Function Number: 7
func_71A4()
{
	level endon("stop_fnf_machine");
	if(!isdefined(level.var_71A3))
	{
		level.var_71A3 = spawnfx(level._effect["fnfeyes"],(1881,176,-942),anglestoforward((0,-90,0)),anglestoup((0,-90,0)));
	}

	wait(0.1);
	triggerfx(level.var_71A3);
	var_00 = getent("fnf_jaw","targetname");
	var_00.origin = (1881,173.5,-882.2);
	for(;;)
	{
		wait(randomintrange(1,3));
		var_00 movez(-1,0.2);
		var_00 waittill("movedone");
		var_00 movez(1,0.2);
		var_00 waittill("movedone");
	}
}

//Function Number: 8
func_FFB1()
{
	if(getdvarint("loc_language") != 15 && getdvarint("loc_language") != 1)
	{
		return 1;
	}

	return 0;
}

//Function Number: 9
func_F47A(param_00)
{
	if(!isdefined(param_00))
	{
		var_01 = "map_select_0";
	}
	else
	{
		var_01 = "map_select_" + var_01;
	}

	var_02 = getent(var_01,"targetname").origin;
	var_03 = getent(var_01,"targetname").angles;
	var_04 = scripts\common\utility::istrue(level.var_B329);
	if(var_04)
	{
		frontendscenecamerafade(0,0.2);
		wait(0.25);
	}

	level.var_37A6 dontinterpolate();
	level.var_37A6.origin = var_02;
	level.var_37A6.angles = var_03;
	frontendscenecamerafov(65,0.05);
	if(var_04)
	{
		wait(0.1);
		frontendscenecamerafade(1,0.2);
	}
}

//Function Number: 10
func_F2D6()
{
	level endon("camera_position_requested");
	frontendscenecamerafade(0,0.2);
	wait(0.25);
	self setdepthoffield(0.1,0.2,30,5000,4,1.8);
	func_F522("barracks_cam");
	wait(0.1);
	frontendscenecamerafade(1,0.2);
}

//Function Number: 11
func_F46B()
{
	level endon("camera_position_requested");
	if(isdefined(level.var_394))
	{
		level.var_394 delete();
	}

	frontendscenecamerafade(0,0.2);
	self setdepthoffield(0.1,0.2,30,5000,4,1.8);
	wait(0.25);
	func_F522("player_loadout_cam");
	frontendscenecamerafov(85);
	wait(0.1);
	frontendscenecamerafade(1,0.2);
}

//Function Number: 12
func_F46C()
{
	self setdepthoffield(0.1,0.2,30,5000,4,1.8);
	func_F522("player_loadout_cam");
	frontendscenecamerafov(85);
}

//Function Number: 13
func_F61A()
{
	if(!scripts\common\utility::istrue(self.opened_weapon_select))
	{
		level.var_3CAD = spawn("script_character",(0,0,0),0,0,0);
	}

	level.var_394 = spawn("script_weapon",getent("weapon_loc","targetname").origin,0,0,0);
	self.opened_weapon_select = 1;
	level.var_394.angles = getent("weapon_loc","targetname").angles;
	level.var_394 method_831F(level.var_3CAD);
	frontendscenecamerafov(65);
	func_F522("player_weapon_cam");
}

//Function Number: 14
func_F619()
{
	var_00 = getent("gun_light","targetname");
	var_00 setlightintensity(10);
	frontendscenecamerafov(65);
	self setdepthoffield(0,15,50,80,10,8);
}

//Function Number: 15
func_F46A()
{
	self setdepthoffield(0.1,0.2,30,5000,4,1.8);
	frontendscenecamerafov(85);
}

//Function Number: 16
func_BC0F()
{
	level endon("camera_position_requested");
	frontendscenecameracinematic("");
	frontendscenecamerafade(0,0.2);
	wait(0.25);
	thread func_13EFF("back_to_main_view",undefined,::func_F41D);
	self setdepthoffield(0.1,0.2,30,5000,4,1.8);
	wait(0.1);
	frontendscenecamerafade(1,0.2);
}

//Function Number: 17
func_BC8F()
{
	frontendscenecamerafade(0,0.2);
	wait(0.25);
	thread func_13EFF("lobby");
	wait(0.1);
	frontendscenecamerafade(1,0.2);
}

//Function Number: 18
func_C573()
{
	if(isdefined(level.var_D372))
	{
		return;
	}

	level.var_D372 = 1;
}

//Function Number: 19
func_375B()
{
	func_C573();
	level.var_D460 = self;
	func_F41D();
	level.shuffle_songs = [];
	thread lib_0A78::func_744C(::func_37BA);
	thread zm_map_select_watcher();
	thread init_soul_key();
	thread play_lobby_music();
	thread shuffle_watcher();
	thread watch_boss_battle();
	thread watch_reset_boss_battle();
}

//Function Number: 20
play_lobby_music()
{
	level endon("game_ended");
	self endon("disconnect");
	for(;;)
	{
		self waittill("luinotifyserver",var_00,var_01);
		if(var_00 == "music_changed")
		{
			var_02 = get_zombies_music(var_01);
			if(var_02 != "shuffle")
			{
				level notify("shuffle_changed");
				level.shuffle_playing = 0;
				function_01BA(var_02);
			}
			else
			{
				thread run_shuffle_music();
			}
		}
	}
}

//Function Number: 21
shuffle_watcher()
{
	thread watch_shuffle_check_1();
	thread watch_shuffle_check_2();
	thread watch_shuffle_check_3();
	thread watch_shuffle_check_4();
	thread watch_shuffle_check_5();
	thread watch_shuffle_check_6();
	thread watch_shuffle_check_7();
	thread watch_shuffle_check_8();
	thread watch_shuffle_check_9();
	thread watch_shuffle_check_10();
	thread watch_shuffle_check_11();
}

//Function Number: 22
watch_shuffle_check_1()
{
	level endon("game_ended");
	self endon("disconnect");
	for(;;)
	{
		self waittill("luinotifyserver",var_00,var_01);
		if(var_00 == "songcheck_1" && var_01 > 0)
		{
			level.shuffle_songs[1] = 1;
		}
	}
}

//Function Number: 23
watch_shuffle_check_2()
{
	level endon("game_ended");
	self endon("disconnect");
	for(;;)
	{
		self waittill("luinotifyserver",var_00,var_01);
		if(var_00 == "songcheck_2" && var_01 > 0)
		{
			level.shuffle_songs[2] = 1;
		}
	}
}

//Function Number: 24
watch_shuffle_check_3()
{
	level endon("game_ended");
	self endon("disconnect");
	for(;;)
	{
		self waittill("luinotifyserver",var_00,var_01);
		if(var_00 == "songcheck_3" && var_01 > 0)
		{
			level.shuffle_songs[3] = 1;
		}
	}
}

//Function Number: 25
watch_shuffle_check_4()
{
	level endon("game_ended");
	self endon("disconnect");
	for(;;)
	{
		self waittill("luinotifyserver",var_00,var_01);
		if(var_00 == "songcheck_4" && var_01 > 0)
		{
			level.shuffle_songs[4] = 1;
		}
	}
}

//Function Number: 26
watch_shuffle_check_5()
{
	level endon("game_ended");
	self endon("disconnect");
	for(;;)
	{
		self waittill("luinotifyserver",var_00,var_01);
		if(var_00 == "songcheck_5" && var_01 > 0)
		{
			level.shuffle_songs[5] = 1;
		}
	}
}

//Function Number: 27
watch_shuffle_check_6()
{
	level endon("game_ended");
	self endon("disconnect");
	for(;;)
	{
		self waittill("luinotifyserver",var_00,var_01);
		if(var_00 == "songcheck_6" && var_01 > 0)
		{
			level.shuffle_songs[6] = 1;
		}
	}
}

//Function Number: 28
watch_shuffle_check_7()
{
	level endon("game_ended");
	self endon("disconnect");
	for(;;)
	{
		self waittill("luinotifyserver",var_00,var_01);
		if(var_00 == "songcheck_7" && var_01 > 0)
		{
			level.shuffle_songs[7] = 1;
		}
	}
}

//Function Number: 29
watch_shuffle_check_8()
{
	level endon("game_ended");
	self endon("disconnect");
	for(;;)
	{
		self waittill("luinotifyserver",var_00,var_01);
		if(var_00 == "songcheck_8" && var_01 > 0)
		{
			level.shuffle_songs[8] = 1;
		}
	}
}

//Function Number: 30
watch_shuffle_check_9()
{
	level endon("game_ended");
	self endon("disconnect");
	for(;;)
	{
		self waittill("luinotifyserver",var_00,var_01);
		if(var_00 == "songcheck_9" && var_01 > 0)
		{
			level.shuffle_songs[9] = 1;
		}
	}
}

//Function Number: 31
watch_shuffle_check_10()
{
	level endon("game_ended");
	self endon("disconnect");
	for(;;)
	{
		self waittill("luinotifyserver",var_00,var_01);
		if(var_00 == "songcheck_10" && var_01 > 0)
		{
			level.shuffle_songs[10] = 1;
		}
	}
}

//Function Number: 32
watch_shuffle_check_11()
{
	level endon("game_ended");
	self endon("disconnect");
	for(;;)
	{
		self waittill("luinotifyserver",var_00,var_01);
		if(var_00 == "songcheck_11" && var_01 > 0)
		{
			level.shuffle_songs[11] = 1;
		}
	}
}

//Function Number: 33
run_shuffle_music()
{
	if(scripts\common\utility::istrue(level.shuffle_playing))
	{
		return;
	}

	level.shuffle_playing = 1;
	level endon("game_ended");
	self endon("disconnect");
	level endon("shuffle_changed");
	wait(1);
	var_00 = 22;
	var_01 = -1;
	for(;;)
	{
		var_02 = randomintrange(1,var_00 + 1);
		if(var_02 != var_01)
		{
			var_01 = var_02;
			var_03 = int(tablelookup("cp/zombies/lobby_music_shuffle.csv",0,var_02,2));
			if(var_03 != 0)
			{
				var_04 = scripts\common\utility::istrue(level.shuffle_songs[var_03]);
			}
			else
			{
				var_04 = 1;
			}

			if(var_04)
			{
				var_05 = tablelookup("cp/zombies/lobby_music_shuffle.csv",0,var_02,1);
				var_06 = int(tablelookup("cp/zombies/lobby_music_shuffle.csv",0,var_02,3));
				var_06 = var_06 / 1000;
				function_01BA(var_05);
				wait(var_06);
				function_01BA("");
			}
		}
	}
}

//Function Number: 34
get_zombies_music(param_00)
{
	switch(param_00)
	{
		case 0:
			var_01 = "music_mainmenu_cp_main";
			break;

		case 1:
			var_01 = "music_mainmenu_cp_mw2";
			break;

		case 2:
			var_01 = "music_mainmenu_cp_mw1";
			break;

		case 3:
			var_01 = "music_mainmenu_cp_rave_hidden";
			break;

		case 4:
			var_01 = "music_mainmenu_cp_disco_hidden";
			break;

		case 5:
			var_01 = "music_mainmenu_cp_town_hidden";
			break;

		case 6:
			var_01 = "music_mainmenu_cp_final_hidden";
			break;

		case 7:
			var_01 = "music_mainmenu_cp_perk_01_upnatoms";
			break;

		case 8:
			var_01 = "music_mainmenu_cp_perk_02_racinstripes";
			break;

		case 9:
			var_01 = "music_mainmenu_cp_perk_03_slappytaffy";
			break;

		case 10:
			var_01 = "music_mainmenu_cp_perk_04_bombstoppers";
			break;

		case 11:
			var_01 = "music_mainmenu_cp_perk_05_tuffnuff";
			break;

		case 12:
			var_01 = "music_mainmenu_cp_perk_06_bangbangs";
			break;

		case 13:
			var_01 = "music_mainmenu_cp_perk_11_deadeyedewdrops";
			break;

		case 14:
			var_01 = "music_mainmenu_cp_perk_08_quickies";
			break;

		case 15:
			var_01 = "music_mainmenu_cp_perk_09_mulemunchies";
			break;

		case 16:
			var_01 = "music_mainmenu_cp_perk_10_trailblazers";
			break;

		case 17:
			var_01 = "music_mainmenu_cp_perk_07_bluebolts";
			break;

		case 18:
			var_01 = "music_mainmenu_cp_perk_12_changechews";
			break;

		case 19:
			var_01 = "music_mainmenu_cp_dlc4_boss_battle";
			break;

		case 20:
			var_01 = "music_mainmenu_cp_afterlifearcade";
			break;

		case 21:
			var_01 = "music_mainmenu_cp_ext_lobby";
			break;

		case 22:
			var_01 = "shuffle";
			break;

		default:
			var_01 = "music_mainmenu_cp_main";
			break;
	}

	return var_01;
}

//Function Number: 35
watch_boss_battle()
{
	level endon("game_ended");
	self endon("disconnect");
	for(;;)
	{
		self waittill("luinotifyserver",var_00,var_01);
		if(var_00 == "boss_set")
		{
			reset_all_boss_dvars();
			switch(var_01)
			{
				case 0:
					setdvar("scr_direct_to_grey",1);
					break;
	
				case 1:
					setdvar("scr_direct_to_super_slasher",1);
					break;
	
				case 2:
					setdvar("scr_direct_to_rat_king",1);
					break;
	
				case 3:
					setdvar("scr_direct_to_crab_boss",1);
					break;
	
				case 4:
					setdvar("scr_direct_to_rhino_fight",1);
					break;
	
				case 5:
					setdvar("scr_direct_to_meph_fight",1);
					break;
			}
		}
	}
}

//Function Number: 36
reset_all_boss_dvars()
{
	setdvar("scr_direct_to_grey",0);
	setdvar("scr_direct_to_super_slasher",0);
	setdvar("scr_direct_to_rat_king",0);
	setdvar("scr_direct_to_crab_boss",0);
	setdvar("scr_direct_to_rhino_fight",0);
	setdvar("scr_direct_to_meph_fight",0);
}

//Function Number: 37
watch_reset_boss_battle()
{
	level endon("game_ended");
	self endon("disconnect");
	for(;;)
	{
		self waittill("luinotifyserver",var_00);
		if(var_00 == "boss_reset")
		{
			setdvar("scr_direct_to_grey",0);
			setdvar("scr_direct_to_super_slasher",0);
			setdvar("scr_direct_to_rat_king",0);
			setdvar("scr_direct_to_crab_boss",0);
			setdvar("scr_direct_to_rhino_fight",0);
			setdvar("scr_direct_to_meph_fight",0);
		}
	}
}

//Function Number: 38
func_F41D()
{
	func_F522("main_to_online");
	frontendscenecamerafov(85,0.5);
}

//Function Number: 39
func_6F0C(param_00,param_01,param_02,param_03,param_04,param_05,param_06)
{
	var_07 = getent(param_00,"targetname");
	if(var_07 != undefined)
	{
		for(;;)
		{
			var_07 setlightintensity(param_01);
			wait(randomfloatrange(param_05,param_06));
			var_07 setlightintensity(param_02);
			wait(randomfloatrange(param_03,param_04));
		}
	}
}

//Function Number: 40
func_10672()
{
	var_00 = getent("cashier_zombie_spawn","targetname");
	var_01 = func_10823(var_00);
	var_01.angles = var_00.angles;
	var_01.origin = var_00.origin;
	var_01.var_8C59 scriptmodelplayanim("shipcrib_standing_console_idle_17");
	var_01 scriptmodelplayanim("shipcrib_standing_console_idle_17");
}

//Function Number: 41
func_107F1()
{
	var_00 = ["body_un_crew_flight_deck_b_director","body_un_crew_flight_deck_b"];
	var_01 = ["shipcrib_bridge_sitting_officer_idle_01","shipcrib_bridge_sitting_officer_idle_01"];
	var_02 = getentarray("sitting_guys","targetname");
	foreach(var_06, var_04 in var_02)
	{
		var_05 = func_1067E(var_04);
		var_05.angles = var_04.angles;
		var_05.origin = var_04.origin;
		var_05 thread func_11771(var_06,scripts\common\utility::random(var_01));
	}
}

//Function Number: 42
func_11771(param_00,param_01)
{
	self.var_8C59 scriptmodelplayanim(param_01);
	self scriptmodelplayanim(param_01);
}

//Function Number: 43
func_51A3(param_00)
{
	param_00.var_8C59 delete();
	if(isdefined(param_00.var_8861))
	{
		param_00.var_8861 delete();
	}

	param_00 delete();
}

//Function Number: 44
func_5143(param_00)
{
	param_00.var_8C59 delete();
	if(isdefined(param_00.var_86C1))
	{
		param_00.var_86C1 delete();
	}

	param_00 delete();
}

//Function Number: 45
func_BDA9(param_00)
{
	var_01 = undefined;
	switch(param_00)
	{
		case 1:
			var_01 = level.var_13F40;
			break;

		case 2:
			var_01 = level.var_13F41;
			break;

		case 3:
			var_01 = level.var_13F42;
			break;
	}

	var_01.origin = (-550,-2010,-5);
	var_01.angles = (0,0,0);
	var_02 = func_10823(var_01);
	var_02 method_8292();
	var_02.var_8C59 scriptmodelplayanimdeltamotionfrompos("IW7_cp_frontend_" + var_01.var_336,var_01.origin,var_01.angles,1);
	if(isdefined(var_02.var_8861))
	{
		var_02.var_8861 scriptmodelplayanimdeltamotionfrompos("IW7_cp_frontend_" + var_01.var_336,var_01.origin,var_01.angles,1);
	}

	var_02 scriptmodelplayanimdeltamotionfrompos("IW7_cp_frontend_" + var_01.var_336,var_01.origin,var_01.angles,1);
	wait(30);
	func_51A3(var_02);
}

//Function Number: 46
func_FEC4()
{
	var_00 = "zmb_male_fullbody_outfit_01";
	var_01 = "zmb_male_fullbody_outfit_01";
	var_02 = getent("shooting_01","targetname");
	var_02.origin = (-550,-2010,-5);
	var_02.angles = (0,0,0);
	var_03 = func_10823(var_02);
	var_04 = func_1067E(var_02,1,"male");
	var_03 scriptmodelplayanimdeltamotionfrompos("IW7_cp_frontend_shoot_zom_01",var_02.origin,var_02.angles);
	var_04 scriptmodelplayanimdeltamotionfrompos("IW7_cp_frontend_shoot_civ_01",var_02.origin,var_02.angles);
	var_03.var_8C59 scriptmodelplayanimdeltamotionfrompos("IW7_cp_frontend_shoot_zom_01",var_02.origin,var_02.angles);
	if(isdefined(var_03.var_8861))
	{
		var_03.var_8861 scriptmodelplayanimdeltamotionfrompos("IW7_cp_frontend_shoot_zom_01",var_02.origin,var_02.angles);
	}

	var_04.var_8C59 scriptmodelplayanimdeltamotionfrompos("IW7_cp_frontend_shoot_civ_01",var_02.origin,var_02.angles);
	wait(3.5);
	playfxontag(level._effect["muzzleflash"],var_04.var_86C1,"tag_flash");
	playfxontag(level._effect["shot_impact"],var_03,"j_chest");
	wait(2.5);
	playfxontag(level._effect["muzzleflash"],var_04.var_86C1,"tag_flash");
	playfxontag(level._effect["shot_impact"],var_03,"j_chest");
	wait(10);
	level thread func_5133(var_03,var_04,10);
}

//Function Number: 47
func_5133(param_00,param_01,param_02)
{
	wait(param_02);
	func_51A3(param_00);
	func_5143(param_01);
}

//Function Number: 48
func_5B17()
{
	var_00 = getent("dragging_02","targetname");
	var_00.origin = (-550,-2010,-5);
	var_00.angles = (0,0,0);
	var_01 = func_10823(var_00,"male");
	var_02 = func_1067E(var_00,undefined,"male");
	var_01 scriptmodelplayanimdeltamotionfrompos("IW7_cp_frontend_dragging_zom_01",var_00.origin,var_00.angles,1);
	var_02 scriptmodelplayanimdeltamotionfrompos("IW7_cp_frontend_dragging_civ_01",var_00.origin,var_00.angles,1);
	var_01.var_8C59 scriptmodelplayanimdeltamotionfrompos("IW7_cp_frontend_dragging_zom_01",var_00.origin,var_00.angles,1);
	if(isdefined(var_01.var_8861))
	{
		var_01.var_8861 scriptmodelplayanimdeltamotionfrompos("IW7_cp_frontend_dragging_zom_01",var_00.origin,var_00.angles);
	}

	var_02.var_8C59 scriptmodelplayanimdeltamotionfrompos("IW7_cp_frontend_dragging_civ_01",var_00.origin,var_00.angles,1);
	wait(10);
	level thread func_5133(var_01,var_02,10);
}

//Function Number: 49
func_5B18()
{
	var_00 = getent("dragging_01","targetname");
	var_00.origin = (-550,-2010,-5);
	var_00.angles = (0,0,0);
	var_01 = func_10823(var_00,"male");
	var_02 = func_1067E(var_00,undefined,"male");
	var_01 scriptmodelplayanimdeltamotionfrompos("IW7_cp_frontend_dragging_zom_02",var_00.origin,var_00.angles,1);
	if(isdefined(var_01.var_8861))
	{
		var_01.var_8861 scriptmodelplayanimdeltamotionfrompos("IW7_cp_frontend_dragging_zom_02",var_00.origin,var_00.angles);
	}

	var_02 scriptmodelplayanimdeltamotionfrompos("IW7_cp_frontend_dragging_civ_02",var_00.origin,var_00.angles,1);
	wait(10.5);
	playfx(level._effect["zombie_attack"],var_02 gettagorigin("j_chest"));
	wait(2);
	playfx(level._effect["zombie_attack"],var_02 gettagorigin("j_chest"));
	wait(5);
	level thread func_5133(var_01,var_02,12);
}

//Function Number: 50
func_1067F()
{
	level endon("nuke_runners");
	var_00 = ["shooting","mugging1","mugging2","mugging3","dragging1","dragging2"];
	var_01 = ["IW7_cp_frontend_feeding_walk_off_civ","IW7_cp_frontend_feeding_walk_off_zom","IW7_cp_frontend_mugging_high_cam_z1_01","IW7_cp_frontend_mugging_high_cam_z1_02","IW7_cp_frontend_mugging_high_cam_z2_01"];
	var_02 = randomint(4);
	var_03 = getentarray("zombie_street_spawners","targetname");
	for(;;)
	{
		var_03 = scripts\common\utility::array_randomize(var_03);
		foreach(var_05 in var_03)
		{
			var_06 = func_10823(var_05);
			var_06.angles = var_05.angles;
			var_06.origin = var_05.origin;
			var_07 = scripts\common\utility::random(var_01);
			var_06 thread func_13F52(var_07);
			var_06.var_336 = "zombie";
			wait(randomfloatrange(0.2,2));
		}

		var_09 = scripts\common\utility::random(var_00);
		var_00 = scripts\common\utility::func_22A9(var_00,var_09);
		if(var_00.size < 1)
		{
			var_00 = ["shooting","mugging1","mugging2","mugging3","dragging1","dragging2"];
		}

		switch(var_09)
		{
			case "shooting":
				wait(30);
				func_FEC4();
				break;
	
			case "mugging1":
				wait(15);
				func_BDA9(1);
				break;
	
			case "mugging2":
				wait(15);
				func_BDA9(2);
				break;
	
			case "mugging3":
				wait(15);
				func_BDA9(3);
				break;
	
			case "dragging1":
				wait(15);
				func_5B17();
				break;
	
			case "dragging2":
				wait(20);
				func_5B18();
				break;
		}
	}
}

//Function Number: 51
func_13F52(param_00)
{
	wait(randomfloatrange(1,2));
	self.var_8C59 scriptmodelplayanimdeltamotion(param_00,1);
	if(isdefined(self.var_8861))
	{
		self.var_8861 scriptmodelplayanimdeltamotion(param_00,1);
	}

	self scriptmodelplayanimdeltamotion(param_00,1);
	wait(45);
	func_51A3(self);
}

//Function Number: 52
func_37BA(param_00)
{
	level notify("camera_position_requested");
	if(param_00.name != "zm_consumable_selection")
	{
		level notify("stop_fnf_machine");
		if(isdefined(level.var_71A3))
		{
			level.var_71A3 delete();
		}
	}

	switch(param_00.name)
	{
		case "zm_buildkit_selection":
			if(func_A8E7("weapon_select"))
			{
				thread func_13EFF("weapon_to_buildkit",250,::func_F46C);
			}
			else
			{
				thread func_13EFF("loadout_to_buildkit",250,::func_F46C);
			}
			break;

		case "zm_main":
			if(!isdefined(self.var_A8E6) || func_A8E7("zm_main"))
			{
				func_F41D();
			}
			else
			{
				thread func_BC0F();
			}
			break;

		case "zm_play_online":
			if(func_A8E7("zm_main") || func_A8E7("barracks_menu") || func_A8E7("loadout_menu"))
			{
				thread func_13EFF("main_to_online",undefined,::func_BC8F);
			}
			break;

		case "zm_map_selection":
			if(func_A8E7("zm_main"))
			{
				level.var_B329 = 1;
				frontendscenecamerafov(65,0.05);
				thread func_13EFF("main_to_online",undefined,::func_F47A);
			}
			else
			{
				level.var_B329 = 1;
				func_F47A();
			}
			break;

		case "map_select_0":
			if(func_A8E7("zm_main"))
			{
				level.var_B329 = 1;
				frontendscenecamerafov(65,0.3);
				thread func_13EFF("main_to_online",undefined,::func_F47A);
			}
			else
			{
				frontendscenecamerafov(65,0.3);
				level.var_B329 = 1;
				func_F47A(0);
			}
			break;

		case "map_select_1":
			level.var_B329 = 0;
			func_F47A(1);
			break;

		case "map_select_2":
			level.var_B329 = 0;
			func_F47A(2);
			break;

		case "map_select_3":
			level.var_B329 = 0;
			func_F47A(3);
			break;

		case "map_select_4":
			level.var_B329 = 0;
			func_F47A(4);
			break;

		case "zm_consumable_selection":
			level thread func_71A4();
			if(func_A8E7("loadout_menu") && !isdefined(self.var_AE3A))
			{
				self.var_AE3A = 1;
				thread func_13EFF("player_card_cam",250);
			}
			else if(func_A8E7("zm_consumable_selection"))
			{
				func_F522("player_card_cam_static");
			}
			else
			{
				thread func_13EFF("player_card_cam",250);
				thread fadeinfrontendcamera();
			}
			break;

		case "zm_lobby":
			level thread func_CDA4(0.1);
			if(func_A8E7("zm_main"))
			{
				frontendscenecamerafov(85,1);
				thread func_13EFF("main_to_online",undefined,::func_BC8F);
			}
			else if(func_A8E7("zm_map_selection"))
			{
				frontendscenecamerafade(0,0.2);
				wait(0.25);
				frontendscenecamerafov(85,0.05);
				func_F522("zm_lobby_cam");
			}
			else
			{
				frontendscenecamerafade(0,0.2);
				wait(0.25);
				frontendscenecamerafov(85,1);
				func_F522("zm_lobby_cam");
			}
	
			fadeinfrontendcameraendontransition();
			break;

		case "weapon_select":
			if(isdefined(self.var_A8E6) && self.var_A8E6 == "zm_buildkit_selection")
			{
				thread func_13EFF("buildkit_to_weaponselect",250,::func_F619);
			}
			else
			{
				thread func_F61A();
				thread fadeinfrontendcamera();
			}
			break;

		case "loadout_menu":
			if(func_A8E7("zm_main"))
			{
				thread func_13EFF("main_to_online",undefined,::func_F46B);
			}
			else if(func_A8E7("loadout_menu"))
			{
				func_F522("player_loadout_cam");
			}
			else if(func_A8E7("zm_consumable_selection"))
			{
				thread func_13EFF("consumable_to_loadout",250);
			}
			else if(func_A8E7("zm_buildkit_selection"))
			{
				func_F46C();
			}
			else
			{
				thread func_F46B();
			}
			break;

		case "weapon_painter_select":
			break;

		case "zm_survival_depot":
		case "barracks_menu":
			if(func_A8E7("zm_main"))
			{
				frontendscenecamerafov(65,2);
				thread func_13EFF("main_to_online",undefined,::func_F2D6);
			}
			else
			{
				func_F2D6();
			}
	
			thread fadeinfrontendcamera();
			break;

		default:
			func_F41D();
			break;
	}

	self.var_A8E6 = param_00.name;
}

//Function Number: 53
fadeinfrontendcameraendontransition()
{
	level endon("camera_position_requested");
	wait(0.2);
	frontendscenecamerafade(1,0.25);
}

//Function Number: 54
fadeinfrontendcamera()
{
	level endon("camera_position_requested");
	wait(0.2);
	frontendscenecamerafade(1,0.25);
}

//Function Number: 55
fadeoutfrontendcamera()
{
	frontendscenecamerafade(0,0.2);
	wait(0.25);
}

//Function Number: 56
zm_map_select_watcher()
{
	level endon("game_ended");
	self endon("disconnect");
	var_00 = getent("map_select_poster","targetname");
	for(;;)
	{
		self waittill("luinotifyserver",var_01,var_02);
		if(var_01 == "soulKey" && var_02 > 0)
		{
			level thread show_soul_key(var_02);
			continue;
		}

		if(var_01 == "cp_zmb" || var_01 == "cp_rave" || var_01 == "cp_disco" || var_01 == "cp_town" || var_01 == "cp_final")
		{
			switch(var_01)
			{
				case "cp_zmb":
					var_00 setmodel("zmb_poster_spaceland");
					break;
	
				case "cp_rave":
					var_00 setmodel("zmb_poster_dlc1");
					break;
	
				case "cp_disco":
					var_00 setmodel("zmb_poster_dlc2");
					break;
	
				case "cp_town":
					var_00 setmodel("zmb_poster_dlc3");
					break;
	
				case "cp_final":
					var_00 setmodel("zmb_poster_dlc4");
					break;
			}
		}

		if(var_01 == "map_select")
		{
			switch(var_02)
			{
				case 0:
					var_00 setmodel("zmb_poster_spaceland");
					break;
	
				case 1:
					var_00 setmodel("zmb_poster_dlc1");
					break;
	
				case 2:
					var_00 setmodel("zmb_poster_dlc2");
					break;
	
				case 3:
					var_00 setmodel("zmb_poster_dlc3");
					break;
	
				case 4:
					var_00 setmodel("zmb_poster_dlc4");
					break;
	
				case 5:
					var_00 setmodel("zmb_poster_spaceland");
					break;
	
				case 6:
					var_00 setmodel("zmb_poster_dlc1");
					break;
	
				case 7:
					var_00 setmodel("zmb_poster_dlc2");
					break;
	
				case 8:
					var_00 setmodel("zmb_poster_dlc3");
					break;
	
				case 10:
				case 9:
					var_00 setmodel("zmb_poster_dlc4");
					break;
			}
		}
	}
}

//Function Number: 57
show_soul_key(param_00)
{
	var_01 = int(param_00 / 16);
	var_02 = param_00 - var_01 * 16;
	var_03 = int(var_02 / 8);
	var_02 = var_02 - var_03 * 8;
	var_04 = int(var_02 / 4);
	var_02 = var_02 - var_04 * 4;
	var_05 = int(var_02 / 2);
	var_02 = var_02 - var_05 * 2;
	var_06 = int(var_02 / 1);
	var_02 = var_02 - var_06 * 1;
	if(var_06 == 1 && !level.has_soul_key_1)
	{
		level.has_soul_key_1 = 1;
		triggerfx(level.soul_key_1_fx);
	}

	if(var_05 == 1 && !level.has_soul_key_2)
	{
		level.has_soul_key_2 = 1;
		triggerfx(level.soul_key_2_fx);
	}

	if(var_04 == 1 && !level.has_soul_key_3)
	{
		level.has_soul_key_3 = 1;
		triggerfx(level.soul_key_3_fx);
	}

	if(var_03 == 1 && !level.has_soul_key_4)
	{
		level.has_soul_key_4 = 1;
		triggerfx(level.soul_key_4_fx);
	}

	if(var_01 == 1 && !level.has_soul_key_5)
	{
		level.has_soul_key_5 = 1;
		triggerfx(level.soul_key_5_fx);
	}
}

//Function Number: 58
func_13EFE()
{
	level endon("game_ended");
	self endon("disconnect");
	self cameralinkto(level.var_37A6,"tag_origin");
	func_F41D();
	level.var_1642 = frontendscenegetactivesection();
	func_37BA(level.var_1642);
	scripts\common\utility::func_136F7();
	for(;;)
	{
		var_00 = frontendscenegetactivesection();
		if(var_00.name == level.var_1642.name && var_00.index == level.var_1642.index)
		{
			scripts\common\utility::func_136F7();
			continue;
		}

		level.var_1642 = var_00;
		func_37BA(var_00);
	}
}

//Function Number: 59
func_13EFF(param_00,param_01,param_02,param_03)
{
	level endon("camera_position_requested");
	var_04 = getent(param_00,"targetname");
	lib_0A78::func_7449(var_04,param_01,1,0,param_02);
}

//Function Number: 60
main()
{
	setdvar("r_umbraMinObjectContribution",10);
	lib_0FAB::main();
	lib_0F4B::main();
	scripts\cp\maps\cp_frontend\gen\cp_frontend_art::main();
	lib_0F4A::main();
	setdvar("r_lightGridEnableTweaks",1);
	setdvar("r_lightGridIntensity",1.33);
	level.var_375F = ::func_375B;
	update_theater_signs();
	lib_0A78::func_744A((0,0,0),(0,0,0));
	level func_F9AA();
	level.var_D751 = ::func_2B53;
	setup_fnf_machine();
	function_026C("MatchStarted: Completed");
}

//Function Number: 61
update_theater_signs()
{
	var_00 = getent("front_marquee_sign","targetname");
	var_00 setmodel("cp_final_fe_theater_beast_from_beyond");
	var_01 = getentarray("frontend_poster","targetname");
	foreach(var_03 in var_01)
	{
		var_03 setmodel("zmb_poster_dlc4");
	}
}

//Function Number: 62
setup_fnf_machine()
{
	var_00 = getent("fnf_jaw","targetname");
	var_01 = getent("fnf_machine","targetname");
	if(func_FFB1())
	{
		var_01 setscriptablepartstate("teller","default_on");
		var_00 setmodel("zmb_fortune_teller_machine_jaw_02");
		return;
	}

	var_00 setmodel("zmb_fortune_teller_machine_jaw_01");
	var_01 setscriptablepartstate("teller","safe_on");
}

//Function Number: 63
func_F522(param_00)
{
	level.var_37A6 dontinterpolate();
	level.var_37A6.origin = getent(param_00,"targetname").origin;
	level.var_37A6.angles = getent(param_00,"targetname").angles;
}

//Function Number: 64
func_A8E7(param_00)
{
	return !isdefined(self.var_A8E6) || self.var_A8E6 == "" || self.var_A8E6 == param_00;
}

//Function Number: 65
func_2B53()
{
}

//Function Number: 66
init_soul_key()
{
	self endon("disconnect");
	level.soul_key_1_fx = spawnfx(level._effect["vfx_zb_pack_grd_a"],(-43,-313,218),anglestoforward((180,180,-90)),anglestoup((180,180,-90)));
	level.soul_key_2_fx = spawnfx(level._effect["vfx_zb_pack_grd_e"],(-40,-313,232),anglestoforward((180,180,-90)),anglestoup((180,180,-90)));
	level.soul_key_3_fx = spawnfx(level._effect["vfx_zb_pack_grd_d"],(-25,-313,238),anglestoforward((180,180,-90)),anglestoup((180,180,-90)));
	level.soul_key_4_fx = spawnfx(level._effect["vfx_zb_pack_grd_b"],(-11,-313,232),anglestoforward((180,180,-90)),anglestoup((180,180,-90)));
	level.soul_key_5_fx = spawnfx(level._effect["vfx_zb_pack_grd_c"],(-8,-313,218),anglestoforward((180,180,-90)),anglestoup((180,180,-90)));
	level.has_soul_key_1 = 0;
	level.has_soul_key_2 = 0;
	level.has_soul_key_3 = 0;
	level.has_soul_key_4 = 0;
	level.has_soul_key_5 = 0;
}