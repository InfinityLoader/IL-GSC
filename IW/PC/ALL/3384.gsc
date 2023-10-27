/*******************************************************************
 * Decompiled By: Bog
 * Decompiled File: 3384.gsc
 * Game: Call of Duty: Infinite Warfare
 * Platform: PC
 * Function Count: 77
 * Decompile Time: 67 ms
 * Timestamp: 10/27/2023 12:26:52 AM
*******************************************************************/

//Function Number: 1
func_9699()
{
	level.var_4EFB = ::func_4EFA;
	level.var_3C10 = 0;
	level.var_6ACD = [];
	level.var_3C16 = 0;
	level.var_6ACC = 0;
	level.var_BEB2 = "robot_kevin_upper";
	level.var_BEB1 = "robot_kevin_lower";
	level.var_74B8 = "robot_park_kevin";
	level.var_8C89 = "robot_park_kevin_headless";
	level.var_BEC8 = "robot_park_kevin_head";
	level.var_BECF = level._effect["neil_light_on"];
	scripts\common\utility::flag_init("neil_head_attached");
	scripts\common\utility::flag_init("neil_battery_attached");
	scripts\common\utility::flag_init("neil_firmware_attached");
	scripts\common\utility::flag_init("quest_step_1_complete");
	scripts\common\utility::flag_init("quest_step_2_complete");
	scripts\common\utility::flag_init("quest_step_3_complete");
	scripts\common\utility::flag_init("transformation_complete");
	scripts\common\utility::flag_init("transform");
	scripts\common\utility::flag_init("halt_neil");
	scripts\common\utility::flag_init("landing_zone_active");
	getent("neil_usetrig","targetname") enablelinkto();
	var_00 = getvehiclenode("neil_spawn","targetname");
	func_F999(var_00);
	level thread func_BED2();
	level thread func_1077A();
	wait(5);
	var_01 = 0;
	func_9696(var_01);
	func_9697(var_01);
}

//Function Number: 2
func_F447()
{
	level.var_BEB2 = "robot_kevin_black_upper";
	level.var_BEB1 = "robot_kevin_black_lower";
	level.var_74B8 = "robot_park_kevin_02";
	level.var_8C89 = "robot_park_kevin_headless_black";
	level.var_BEC8 = "robot_park_kevin_head_black";
	level.var_BECF = level._effect["neil_light_on_red"];
}

//Function Number: 3
func_BED2()
{
	func_BED3();
	func_BED4();
	func_BED8();
	level thread func_1176E();
}

//Function Number: 4
func_BED3()
{
	scripts\common\utility::flag_wait("neil_head_attached");
	level.var_13BD2 = level.wave_num;
	wait(0.5);
	level.var_BEAB setmodel(level.var_BEB1);
	level.var_BEAB.is_neil = 1;
	function_0277("neil",0,level.var_BEAB,20,1);
	level.var_BEAB.var_12F87 = spawn("script_model",level.var_BEAB.origin);
	level.var_BEAB.var_12F87.angles = level.var_BEAB.angles;
	level.var_BEAB.var_12F87 setmodel(level.var_BEB2);
	level.var_BEAB.var_12F87 func_BEDF("happy");
	level.var_BEAB.var_12F87 linkto(level.var_BEAB);
	level.var_BEAB.var_12F87 playsound("neil_startup");
	level.var_BEAB.var_12F87 scriptmodelplayanim("IW7_cp_zom_n31l_head_on",1);
	level.var_BEAB method_8318(1);
	level.var_BEAB.var_12F87 method_8318(1);
	level.var_BEAB method_8364("allies");
	level.var_BEAB method_8363("N31L");
	wait(0.5);
	scripts\cp\zombies\zombie_analytics::func_AF7D(level.var_13BD1,level.var_13BD2);
	wait(2);
	level.var_BEAB.var_12F87 thread func_BECD("n31l_spawn_assembly");
	level thread func_833E(100);
	level.var_BEAB startpath();
	level.var_BEAB method_83E5(2,1,1);
	level.var_BEAB waittill("reached_end_node");
	var_00 = getvehiclenode("neil_start_node","targetname");
	level.var_BEAB startpath(var_00);
	level.var_BEAB thread func_BED0(var_00);
	scripts\common\utility::func_6E2A("transformation_complete");
	func_BECC(level.var_BEAB);
	func_BEB6(level.var_BEAB);
}

//Function Number: 5
func_BED4()
{
	func_BED6();
	func_10778();
	func_BEBD(level.var_BEAB,&"CP_ZMB_INTERACTIONS_MISSING_BATTERY");
	for(;;)
	{
		level.var_BEAB.var_13084 waittill("trigger",var_00);
		if(!var_00 scripts\cp\_utility::is_valid_player() || !isdefined(level.var_BEB0))
		{
			continue;
		}

		break;
	}

	var_01 = scripts\common\utility::getstruct("neil_repair","script_noteworthy");
	func_1728(var_01,var_00);
	func_BEBC(level.var_BEAB);
	level func_BED7();
	level.var_13BCE = level.wave_num;
	scripts\cp\zombies\zombie_analytics::func_AF7B(level.var_13BCD,level.var_13BCE);
	level thread func_833E(100);
	scripts\common\utility::func_6E2A("halt_neil");
	scripts\common\utility::func_6E2A("transform");
	level.var_BEAB method_83E5(2,1,1);
	wait(1.5);
	scripts\common\utility::func_6E2A("transformation_complete");
	func_BEB6(level.var_BEAB);
}

//Function Number: 6
func_BED6()
{
	scripts\common\utility::flag_wait("transformation_complete");
	level.var_BEAB method_83E6(0);
	level.var_BEAB stoploopsound();
	level.var_BEAB playsound("neil_mvmt_stop");
	scripts\common\utility::flag_set("halt_neil");
	scripts\common\utility::flag_set("transform");
	level.var_BEAB.var_12F87 playsound("n31l_challenge_pause");
}

//Function Number: 7
func_BED7()
{
	func_BEC4();
	wait(1);
	level.var_BEAB.var_12F87 playsound("n31l_challenge_reactivate");
	wait(4);
}

//Function Number: 8
func_BED8()
{
	func_BEDA();
	func_10779();
	func_BEBD(level.var_BEAB,&"CP_ZMB_INTERACTIONS_MISSING_FLOPPY");
	for(;;)
	{
		level.var_BEAB.var_13084 waittill("trigger",var_00);
		if(!var_00 scripts\cp\_utility::is_valid_player() || !isdefined(level.var_BEC3))
		{
			continue;
		}

		break;
	}

	var_01 = scripts\common\utility::getstruct("neil_repair","script_noteworthy");
	func_1728(var_01,var_00);
	level.var_13BD0 = level.wave_num;
	func_BEBC(level.var_BEAB);
	level func_BED9();
	scripts\cp\zombies\zombie_analytics::func_AF7C(level.var_13BCF,level.var_13BD0);
	level thread func_833E(100);
	scripts\common\utility::func_6E2A("halt_neil");
	scripts\common\utility::func_6E2A("transform");
	level.var_BEAB method_83E5(2,1,1);
	wait(1.5);
	scripts\common\utility::func_6E2A("transformation_complete");
	func_BEB6(level.var_BEAB);
}

//Function Number: 9
func_BEDA()
{
	scripts\common\utility::flag_wait("transformation_complete");
	wait(2);
	func_BEDB(level.var_BEAB);
}

//Function Number: 10
func_BEDB(param_00)
{
	wait(1);
	level.var_BEAB method_83E6(0);
	level.var_BEAB stoploopsound();
	level.var_BEAB playsound("neil_mvmt_stop");
	scripts\common\utility::flag_set("halt_neil");
	scripts\common\utility::flag_set("transform");
	level.var_BEAB.var_12F87 playsound("n31l_challenge_pause");
}

//Function Number: 11
func_BED9()
{
	func_BEC4();
	wait(1);
	level.var_BEAB.var_12F87 playsound("n31l_upgrade");
	wait(3);
	level.var_BEAB.var_12F87 playsound("kitt_challenge_restart");
	wait(4);
}

//Function Number: 12
func_BEBD(param_00,param_01,param_02)
{
	if(!isdefined(param_02))
	{
		level notify("neil_enabled_changed");
		level.var_1C3F = undefined;
	}

	param_00.var_13084 makeusable();
	if(!isdefined(param_01))
	{
		param_01 = &"CP_ZMB_CHALLENGES_USE_NEIL";
	}

	param_00.var_13084 sethintstring(param_01);
	param_00.var_13084 method_84A2(90);
	param_00.var_13084 method_84A5(180);
	if(!scripts\common\utility::istrue(level.var_A6E1))
	{
		param_00 setscriptablepartstate("light","on");
	}
	else
	{
		param_00 setscriptablepartstate("light","on_red");
		param_00.var_12F87 setscriptablepartstate("facefx","kitt");
		param_00.var_12F87 func_BEDF("kitt");
	}

	param_00.var_6265 = 1;
	if(!isdefined(param_00.var_13084))
	{
	}
}

//Function Number: 13
func_BEBC(param_00)
{
	param_00 setscriptablepartstate("light","off");
	param_00.var_6265 = 0;
	if(!isdefined(param_00.var_13084))
	{
		return;
	}

	param_00.var_13084 makeunusable();
}

//Function Number: 14
func_BEE2(param_00)
{
	foreach(var_02 in level.players)
	{
		var_02 playlocalsound("mp_intel_received");
	}

	level notify("challenge_started");
	var_04 = level.var_C1E1;
	var_05 = func_7895(var_04,param_00);
	level thread scripts\cp\_challenge::func_15D7(var_05);
	return var_05;
}

//Function Number: 15
func_BEB7(param_00,param_01,param_02,param_03)
{
	if(param_01 == "challenge_force_complete")
	{
		level.var_3C17[param_00].var_111AE = 1;
	}
	else if(param_01 == "challenge_force_fail")
	{
		level.var_3C17[param_00].var_111AE = 0;
	}

	scripts\cp\_challenge::func_4DAE();
	if(param_01 == "challenge_deactivated" || param_01 == "challenge_force_complete" || param_01 == "challenge_force_fail")
	{
		if(param_03 != level.var_C1E1)
		{
			param_03 = level.var_C1E1;
			level thread func_8320();
			level.var_6ACC = 0;
			level.var_BEAB.var_12F87 func_BEDF("happy");
			scripts\cp\_vo::func_E01F("nag_no_challenge");
			return;
		}

		level.var_6ACD[level.var_6ACD.size] = param_00;
		level.var_6ACC++;
		if(level.var_6ACC >= 2)
		{
			foreach(var_05 in level.players)
			{
				var_05 thread scripts\cp\_vo::func_1769("nag_no_challenge","zmb_comment_vo",60,10,6,1);
			}
		}

		if(level.var_6ACC > 3)
		{
			level thread func_BEC0();
		}

		level.var_BEAB.var_12F87 func_BEDF("sad");
		return;
	}

	if(param_03 != level.var_C1E1)
	{
		param_03 = level.var_C1E1;
		level thread func_8320();
		level.var_BEAB.var_12F87 func_BEDF("happy");
	}
}

//Function Number: 16
func_BED1()
{
	wait(5);
	level thread scripts\cp\_challenge::func_15D7("next_challenge");
	var_00 = int(gettime() + 30000);
	foreach(var_02 in level.players)
	{
		var_02 setclientomnvar("ui_intel_timer",var_00);
	}

	wait(1);
	var_04 = 5;
	setomnvar("zm_neil_progress",level.var_C1E1 / var_04);
	level.var_BEAB.var_12F87 func_BEDF("happy");
	if(getdvar("challenge_prep_time") != "")
	{
		wait(3);
	}
	else
	{
		wait(28);
	}

	level notify("next_challenge_starting");
	wait(1);
	if(scripts\common\utility::flag("pause_challenges"))
	{
		foreach(var_02 in level.players)
		{
			var_02 setclientomnvar("zm_show_challenge",10);
		}

		scripts\common\utility::func_6E5A("pause_challenges");
	}

	scripts\cp\_challenge::func_62C6();
	wait(5);
	if(scripts\common\utility::flag("pause_challenges"))
	{
		foreach(var_02 in level.players)
		{
			var_02 setclientomnvar("zm_show_challenge",10);
		}

		scripts\common\utility::func_6E5A("pause_challenges");
	}
}

//Function Number: 17
func_BEB6(param_00)
{
	level endon("game_ended");
	level.var_C1E1 = 0;
	var_01 = 5;
	setomnvar("zm_neil_progress",level.var_C1E1 / var_01);
	level.var_6ACD = [];
	level.var_3C12 = undefined;
	var_02 = [];
	switch(level.var_3C16)
	{
		case 0:
			var_02 = level.var_118A4;
			break;

		case 1:
			var_02 = level.var_118A5;
			break;

		case 2:
			var_02 = level.var_118A6;
			break;
	}

	level.var_BEAB playsound("n31l_challenge_start");
	if(!isdefined(level.var_1C3F))
	{
		level.var_BEAB thread func_1C5F();
	}

	for(;;)
	{
		var_03 = level.var_C1E1;
		var_04 = func_BEE2(var_02);
		var_05 = level scripts\common\utility::func_13734("challenge_deactivated","challenge_timed_out","challenge_force_complete","challenge_force_fail");
		func_BEB7(var_04,var_05,param_00,var_03);
		level.var_3C12 = scripts\common\utility::func_22A9(level.var_3C12,var_04);
		var_01 = 5;
		if(level.var_C1E1 * level.var_3C16 + 1 >= var_01 * level.var_3C16 + 1)
		{
			break;
		}

		if(level.var_3C12.size <= 0)
		{
			if(isdefined(level.var_6ACD) && level.var_6ACD.size > 0)
			{
				level.var_3C12 = level.var_6ACD;
				level.var_6ACD = [];
			}
			else
			{
				break;
			}
		}

		func_BED1();
	}

	level.var_3C16++;
	setomnvar("zm_neil_progress",1);
	func_BEB5(param_00);
}

//Function Number: 18
func_BEB5(param_00)
{
	level endon("game_ended");
	wait(5);
	var_01 = "iw7_erad_zm";
	var_02 = "cp_fullbody_synaptic_";
	foreach(var_04 in level.players)
	{
		var_04 setclientomnvar("zm_show_challenge",5);
		level.var_4BD3 = 5;
	}

	switch(level.var_3C16)
	{
		case 1:
			level thread func_BEB8(param_00,var_01,&"CP_ZMB_CHALLENGES_NEIL_3");
			break;

		case 2:
			level thread func_BEB8(param_00,"iw7_erad_zm+eradpap1",&"CP_ZMB_CHALLENGES_NEIL_3");
			break;

		case 3:
			level thread func_BEB8(param_00,"iw7_erad_zm+eradpap2",&"CP_ZMB_CHALLENGES_NEIL_3");
			break;
	}

	wait(3);
	level.var_BEAB.var_12F87 thread func_BECD("n31l_challenge_special_complete");
	foreach(var_04 in level.players)
	{
		var_04 setclientomnvar("zm_show_challenge",-1);
	}
}

//Function Number: 19
func_BEB8(param_00,param_01,param_02)
{
	func_BEBD(param_00,param_02);
	for(;;)
	{
		param_00.var_13084 waittill("trigger",var_03);
		if(!var_03 scripts\cp\_utility::is_valid_player())
		{
			continue;
		}

		break;
	}

	func_BEBC(param_00);
	level.var_BEAB.var_12F87 thread func_BECD("n31l_challenge_success_generic_dj");
	level thread play_dj_vo_kitt_arrival(var_03);
	wait(5);
	if(isdefined(var_03))
	{
		var_03 thread scripts\cp\_vo::try_to_play_vo("challenge_n31l_complete","zmb_comment_vo","highest",10,1,0,0,100);
	}

	level thread func_12636(param_00,param_01);
	level thread func_833E(100);
}

//Function Number: 20
play_dj_vo_kitt_arrival(param_00)
{
	level endon("game_ended");
	if(!isdefined(param_00))
	{
		return;
	}

	if(isdefined(param_00.var_13516.var_134C6))
	{
		if(isdefined(param_00.var_13516.var_134C6.var_1B46))
		{
			var_01 = strtok(param_00.var_13516.var_134C6.var_1B46,"_");
			if(var_01[0] == "dj")
			{
				level thread scripts\cp\_vo::try_to_play_vo("dj_sign_off_kitt","zmb_dj_vo","highest",10,1,0,0);
				return;
			}

			level thread scripts\cp\_vo::try_to_play_vo("dj_sign_off_kitt","zmb_dj_vo","highest",10,0,0,0);
			return;
		}

		level thread scripts\cp\_vo::try_to_play_vo("dj_sign_off_kitt","zmb_dj_vo","highest",10,0,0,0);
		return;
	}

	level thread scripts\cp\_vo::try_to_play_vo("dj_sign_off_kitt","zmb_dj_vo","highest",10,0,0,0);
}

//Function Number: 21
func_5559(param_00)
{
	func_BEBC(level.var_BEAB);
	scripts\common\utility::func_6E2A("transformation_complete");
	level.var_1C3F = undefined;
	level.var_BEAB method_83E6(0);
	level.var_BEAB stoploopsound();
	level.var_BEAB playsound("neil_mvmt_stop");
	scripts\common\utility::flag_set("transform");
	scripts\common\utility::flag_set("halt_neil");
	level.var_BEAB notify("neil_quiet");
	if(!scripts\common\utility::istrue(param_00))
	{
		return;
	}

	level.var_BEAB.var_12F87 setmodel("robot_kevin_upper_invisi");
	level.var_BEAB setmodel("robot_kevin_lower_invisi");
}

//Function Number: 22
func_106EF(param_00)
{
	if(!isdefined(param_00))
	{
		param_00 = level.var_BEAB;
	}

	var_01 = spawn("script_model",param_00.origin);
	var_01.angles = param_00.angles;
	var_01.var_12F87 = spawn("script_model",param_00.origin);
	var_01.var_12F87.angles = var_01.angles;
	var_01 setmodel(level.var_BEB1);
	var_01.var_12F87 setmodel(level.var_BEB2);
	var_01.var_12F87 linkto(var_01);
	var_01 method_8318(1);
	var_01.var_12F87 method_8318(1);
	var_01 setscriptablepartstate("thrusters","liftoff");
	if(scripts\common\utility::istrue(level.var_A6E1))
	{
		var_01.var_12F87 func_BEDF("kitt");
		var_01.var_12F87 setscriptablepartstate("facefx","kitt");
	}
	else
	{
		var_01.var_12F87 func_BEDF("happy");
	}

	return var_01;
}

//Function Number: 23
func_13631()
{
	while(level.var_572A.var_4BBE != "idle")
	{
		wait(1);
	}

	level.the_hoff = spawnstruct();
	level.the_hoff.origin = (0,0,0);
	for(;;)
	{
		if(level.var_572A.var_4BBE != "close_window")
		{
			scripts\cp\maps\cp_zmb\cp_zmb_dj::func_F35B("close_window");
		}

		wait(1);
		if(level.var_572A.var_4BBE == "close_window")
		{
			break;
		}
	}

	level.var_572A waittill("window_closed");
	level notify("stop_dj_manager");
	scripts\cp\maps\cp_zmb\cp_zmb_dj::func_F93F();
	level.var_572A hide();
}

//Function Number: 24
func_54FB()
{
	var_00 = scripts\common\utility::getstructarray("dj_quest_door","script_noteworthy");
	foreach(var_02 in var_00)
	{
		scripts\cp\_interaction::remove_from_current_interaction_list(var_02);
	}

	level.var_550B = 1;
}

//Function Number: 25
func_61CF()
{
	var_00 = scripts\common\utility::getstructarray("dj_quest_door","script_noteworthy");
	foreach(var_02 in var_00)
	{
		scripts\cp\_interaction::add_to_current_interaction_list(var_02);
	}
}

//Function Number: 26
func_12636(param_00,param_01)
{
	func_54FB();
	func_5559(1);
	level.var_BEAB method_83E7(level.var_BEAB.origin,level.var_BEAB.angles);
	if(scripts\common\utility::istrue(level.var_A6E1))
	{
		level.var_BEAB.var_12F87 setscriptablepartstate("facefx","off");
	}

	var_02 = func_106EF(level.var_BEAB);
	scripts\common\utility::flag_set("landing_zone_active");
	var_02 playsound("neil_upgrade_rocket_launch_takeoff");
	level thread func_A82C();
	var_02 movez(2000,3,2,1);
	var_02 waittill("movedone");
	playfx(level._effect["neil_flash"],var_02.origin);
	if(!scripts\common\utility::istrue(level.var_A6E1))
	{
		var_02 setmodel("robot_kevin_black_lower");
		var_02.var_12F87 setmodel("robot_kevin_black_upper");
		var_02.var_12F87 func_BEDF("kitt");
		var_02.var_12F87 setscriptablepartstate("facefx","kitt");
	}

	var_02 notsolid();
	var_02.var_12F87 notsolid();
	var_03 = var_02.origin;
	var_02 hide();
	var_02.var_12F87 hide();
	func_13631();
	if(isdefined(level.force_song_func))
	{
		if(!isdefined(level.var_72AB["knight_rider"]))
		{
			level thread [[ level.force_song_func ]](undefined,"mus_pa_sp_knightrider",undefined,undefined,undefined,"knight_rider");
		}
	}

	scripts\cp\zombies\zombies_spawning::func_93EB(1);
	level.the_hoff = func_107F0(param_01,var_02);
	level.the_hoff setorigin(var_02.origin,0);
	level.the_hoff.angles = var_02.angles;
	level.the_hoff hide(1);
	wait(0.5);
	level.the_hoff linkto(var_02);
	level.the_hoff playerlinkedoffsetenable();
	var_02.var_12F87 thread func_A6E2();
	var_02 playsound("neil_upgrade_rocket_launch_land");
	playfx(level._effect["neil_flash"],var_03);
	wait(0.75);
	var_02 show();
	var_02.var_12F87 show();
	var_02.var_12F87 func_BEDF("kitt");
	var_02.var_12F87 setscriptablepartstate("facefx","kitt");
	var_02 setscriptablepartstate("thrusters","liftoff");
	level.the_hoff show();
	level.the_hoff method_83B7();
	level.the_hoff_revive = 1;
	func_1176C(var_02);
	level.the_hoff.var_180 = 0;
	level.the_hoff.var_EF64 = 0;
	level.the_hoff thread func_1176D();
	var_04 = 120 + 60 * level.var_3C16;
	level.the_hoff scripts\common\utility::waittill_any_timeout_1(var_04,"death");
	level.the_hoff_revive = undefined;
	level notify("hoff_death");
	if(scripts\cp\_utility::isplayingsolo() || scripts\common\utility::istrue(level.only_one_player))
	{
		if(!isalive(level.players[0]) || scripts\common\utility::istrue(level.players[0].inlaststand))
		{
			level thread [[ level.endgame ]]("axis",level.end_game_string_index["kia"]);
		}
	}

	if(isdefined(level.the_hoff) && isalive(level.the_hoff))
	{
		level.the_hoff playsound("dj_kitt_notify_departure");
		func_5559(0);
		level.the_hoff notify("timetogo");
		var_05 = getclosestpointonnavmesh(level.var_BEAB.origin + scripts\cp\_utility::func_13192(anglestoforward(level.var_BEAB.angles),52) + scripts\cp\_utility::func_13192(function_02D3(level.var_BEAB.angles),11));
		level.the_hoff.var_EF64 = 1;
		level.the_hoff scripts\mp\agents\c6\c6_agent::func_F835(var_05,6);
		level.the_hoff.var_55B0 = 1;
		level.the_hoff.var_180 = 1;
		level.the_hoff scripts\common\utility::waittill_any_timeout_1(150,"scriptedGoal_reached");
		level.var_BEAB.var_12F87 scriptmodelplayanim("IW7_cp_zom_n31l_intro_enter",1);
		wait(0.75);
		level.var_BEAB.var_12F87 thread func_A6E2();
		level.the_hoff.var_FFF3 = 1;
		level.the_hoff setorigin(level.var_BEAB.origin + scripts\cp\_utility::func_13192(anglestoforward(level.var_BEAB.angles),52) + scripts\cp\_utility::func_13192(function_02D3(level.var_BEAB.angles),11),0);
		wait(7);
		level.the_hoff method_83B7();
		function_0278("neil");
		level.var_BEAB.var_12F87 setmodel("robot_kevin_upper_invisi");
		level.var_BEAB setmodel("robot_kevin_lower_invisi");
		level.var_BEAB.var_12F87 setscriptablepartstate("facefx","off");
		level.var_BEAB.var_12F87 notify("start_intro");
		level.var_BEAB.var_12F87 method_8292();
		var_02 = func_106EF(level.var_BEAB);
		var_02.var_12F87 thread func_A6E2();
		level.the_hoff linkto(var_02);
		level.the_hoff playerlinkedoffsetenable();
		scripts\common\utility::flag_set("landing_zone_active");
		level thread func_A82C();
		var_02 playsound("neil_upgrade_rocket_launch_takeoff_hoff_exit");
		level.the_hoff playsound("dj_kitt_departure");
		wait(3);
		var_02 notsolid();
		var_02.var_12F87 notsolid();
		var_02 movez(2000,3,2,1);
		var_02 waittill("movedone");
		var_02.var_12F87 setscriptablepartstate("facefx","kitt");
		playfx(level._effect["neil_flash"],var_02.origin);
		level.the_hoff.nocorpse = 1;
		level.the_hoff unlink();
		level.the_hoff suicide();
		var_02 playsound("neil_upgrade_rocket_launch_land");
		var_06 = level.var_BEAB.origin;
		var_02 movez(-2000,6,4,2);
		wait(3);
		function_0277("neil",0,level.var_BEAB,20,1);
		level.var_BEAB setscriptablepartstate("landing","on");
		wait(3);
		scripts\common\utility::func_6E2A("landing_zone_active");
		level.var_BEAB setmodel(level.var_BEB1);
		level.var_BEAB.var_12F87 setmodel(level.var_BEB2);
		level.var_BEAB.var_12F87 func_BEDF("kitt");
		level.var_BEAB.var_12F87 setscriptablepartstate("facefx","kitt");
		var_02.var_12F87 delete();
		var_02 delete();
		scripts\common\utility::func_6E2A("halt_neil");
		scripts\common\utility::func_6E2A("transform");
	}

	scripts\cp\zombies\zombies_spawning::func_4FB8(1);
	level.the_hoff = undefined;
	wait(5);
	scripts\cp\maps\cp_zmb\cp_zmb_dj::func_F93F();
	level.var_572A.var_4BBE = undefined;
	level thread scripts\cp\maps\cp_zmb\cp_zmb_dj::func_573F();
	level.var_572A show();
	level.var_550B = undefined;
	scripts\cp\maps\cp_zmb\cp_zmb_dj::func_F35B("open_window");
	scripts\common\utility::flag_set("transformation_complete");
	func_61CF();
}

//Function Number: 27
func_A6E2()
{
	self endon("start_intro");
	self endon("death");
	for(;;)
	{
		self scriptmodelplayanim("IW7_cp_zom_n31l_intro_loop",1);
		wait(1.3);
	}
}

//Function Number: 28
func_1176C(param_00)
{
	var_01 = param_00.origin + (0,0,-2000);
	param_00 movez(-2000,6,4,2);
	wait(3);
	level.var_BEAB setscriptablepartstate("landing","on");
	wait(2);
	level.the_hoff.var_FFEF = undefined;
	level.the_hoff lib_0A1A::func_2330("introloop","introdone");
	wait(1);
	level.the_hoff scripts\mp\_mp_agent::func_FAFA("iw7_erad_zm");
	stopfxontag(level._effect["neil_trail"],param_00,"tag_origin");
	scripts\common\utility::func_6E2A("landing_zone_active");
	level.the_hoff unlink();
	level.var_BEAB setmodel(level.var_BEB1);
	level.var_BEAB.var_12F87 setmodel(level.var_BEB2);
	level.var_BEAB.var_12F87 func_BEDF("kitt");
	level.var_BEAB.var_12F87 thread func_A6E2();
	param_00.var_12F87 delete();
	param_00 delete();
	level.var_BEAB method_83E7(level.var_BEAB.origin,level.var_BEAB.angles);
	level.var_BEAB.var_12F87 setscriptablepartstate("facefx","kitt");
	level.the_hoff.var_54CB = 1;
	wait(4);
	level.var_BEAB.var_12F87 notify("start_intro");
	level.var_BEAB.var_12F87 scriptmodelplayanim("IW7_cp_zom_n31l_intro_exit",1);
	wait(1);
	level.the_hoff playsound("dj_kitt_arrival");
	wait(4);
	scripts\common\utility::func_6E2A("halt_neil");
	scripts\common\utility::func_6E2A("transform");
}

//Function Number: 29
func_107F0(param_00,param_01)
{
	func_F447();
	level.var_A6E1 = 1;
	var_02 = undefined;
	while(!isdefined(var_02))
	{
		var_02 = scripts\cp\zombies\zombies_spawning::func_33B1("the_hoff",param_01.origin,param_01.angles,"allies",undefined,param_00);
		if(!isdefined(var_02))
		{
			wait(0.2);
			continue;
		}
	}

	var_02.var_1491.var_E5DE = 5;
	var_02.health = 1000 * level.var_3C16;
	var_02.maxhealth = 1000 * level.var_3C16;
	var_02.allowpain = 0;
	var_02.ignoreme = 1;
	var_02.var_180 = 1;
	var_02.var_EF64 = 1;
	var_02.var_3842 = 1;
	var_02.var_FFEF = 1;
	foreach(var_04 in level.players)
	{
		var_04 notify("hoff_spawned");
	}

	return var_02;
}

//Function Number: 30
func_1176D()
{
	self endon("death");
	self endon("timetogo");
	self method_8287(48);
	self.footstepdetectdist = 1500;
	for(;;)
	{
		func_1176B();
		func_1176F();
		wait(1);
	}
}

//Function Number: 31
func_1176F()
{
	if(!isdefined(self.var_10C))
	{
		func_83FF();
		return;
	}

	if(self method_805F(self.var_10C))
	{
		self.var_EF64 = 0;
		return;
	}

	func_83FF();
}

//Function Number: 32
func_1176B()
{
	var_00 = func_78C4();
	if(isdefined(var_00))
	{
		func_8419(var_00);
		self.var_EF64 = 0;
		if(isalive(self))
		{
			self.var_180 = 0;
			scripts\mp\agents\c6\c6_agent::func_41D9();
			self.var_55B0 = 0;
		}
	}
}

//Function Number: 33
func_8419(param_00)
{
	param_00 endon("death");
	param_00 endon("reviving");
	param_00 endon("revive");
	param_00 endon("disconnect");
	self endon("death");
	self endon("timetogo");
	scripts\mp\agents\c6\c6_agent::func_41D9();
	if(distancesquared(self.origin,param_00.origin) > 16000000)
	{
		return;
	}

	self.var_EF64 = 1;
	scripts\mp\agents\c6\c6_agent::func_F832(param_00,48,0);
	self.var_55B0 = 1;
	self.var_180 = 1;
	self waittill("scriptedGoal_reached");
	self.var_55B0 = 0;
	self.var_180 = 0;
	if(!isdefined(param_00.reviveent))
	{
		return;
	}

	param_00.reviveent notify("trigger",self);
	wait(4);
}

//Function Number: 34
func_83FF()
{
	var_00 = scripts\cp\_utility::func_7833(1,self.origin);
	var_01 = scripts\common\utility::getclosest(self.origin,var_00);
	if(!isdefined(var_01))
	{
		return;
	}

	var_02 = var_01.origin - self.origin;
	var_03 = length2dsquared(var_02);
	if(var_03 < -3036)
	{
		return;
	}

	var_04 = gettime();
	if(isdefined(self.var_A8EF) && var_04 - self.var_A8EF < 500)
	{
		return;
	}

	self.var_A8EF = var_04;
	var_05 = vectornormalize(var_02);
	var_06 = var_01.origin - var_05 * 128;
	var_07 = getclosestpointonnavmesh(var_06,self);
	scripts\mp\agents\c6\c6_agent::func_F834(1,120);
	scripts\mp\agents\c6\c6_agent::func_F835(var_07,2);
	self.var_3320 = 1;
}

//Function Number: 35
func_78C4()
{
	var_00 = sortbydistance(level.players,self.origin);
	foreach(var_02 in var_00)
	{
		if(scripts\cp\_laststand::player_in_laststand(var_02) && !scripts\common\utility::istrue(var_02.var_9B79) && !scripts\common\utility::istrue(var_02.in_afterlife_arcade))
		{
			return var_02;
		}
	}

	return undefined;
}

//Function Number: 36
func_A82C()
{
	wait(0.1);
	level.var_BEAB setscriptablepartstate("lingerfx","on");
	level thread func_A56E(level.var_BEAB.origin);
	while(scripts\common\utility::flag("landing_zone_active"))
	{
		wait(0.1);
	}

	level.var_BEAB setscriptablepartstate("landing","off");
	level.var_BEAB setscriptablepartstate("lingerfx","off");
}

//Function Number: 37
func_A56E(param_00)
{
	var_01 = spawn("trigger_radius",param_00,0,40,72);
	level thread func_51CE(var_01);
	while(scripts\common\utility::flag("landing_zone_active"))
	{
		var_01 waittill("trigger",var_02);
		if(isdefined(level.the_hoff) && var_02 == level.the_hoff)
		{
			continue;
		}

		if(isdefined(var_02.var_C85F))
		{
			continue;
		}

		if(!scripts\common\utility::flag("landing_zone_active"))
		{
			continue;
		}

		if(isplayer(var_02))
		{
			var_02 dodamage(5,param_00);
			var_02.var_C85F = 1;
			var_02 setvelocity(vectornormalize(var_02.origin - param_00) * 100);
			var_02 thread func_E069();
			continue;
		}

		if(scripts\cp\_utility::func_FF18(var_02))
		{
			var_02.nocorpse = 1;
			var_02.full_gib = 1;
			var_02 dodamage(var_02.health + 100,param_00);
		}
	}

	var_01 delete();
}

//Function Number: 38
func_51CE(param_00)
{
	param_00 endon("death");
	while(isdefined(param_00))
	{
		var_01 = getentarray("placed_transponder","script_noteworthy");
		foreach(var_03 in var_01)
		{
			if(!isdefined(param_00))
			{
				break;
			}

			if(var_03 istouching(param_00))
			{
				if(isdefined(var_03.var_222) && var_03.var_222 scripts\cp\_utility::is_valid_player(1))
				{
					var_03.var_222 playlocalsound("ww_magicbox_laughter");
				}

				var_03 notify("detonateExplosive");
			}
		}

		wait(0.25);
	}
}

//Function Number: 39
func_E069()
{
	self endon("disconnect");
	wait(0.25);
	self.var_C85F = undefined;
}

//Function Number: 40
func_7895(param_00,param_01)
{
	if(!isdefined(level.var_3C12))
	{
		level.var_3C12 = param_01;
	}

	var_02 = undefined;
	if(level.players.size > 1)
	{
		var_02 = scripts\common\utility::random(level.var_3C12);
	}
	else
	{
		for(;;)
		{
			if(level.var_3C12.size == 0)
			{
				level.var_3C12 = level.var_6ACD;
			}

			var_02 = scripts\common\utility::random(level.var_3C12);
			if(!level.var_3C17[var_02].var_1C8C)
			{
				level.var_3C12 = scripts\common\utility::func_22A9(level.var_3C12,var_02);
				wait(0.05);
				continue;
			}
			else
			{
				break;
			}
		}
	}

	return var_02;
}

//Function Number: 41
func_8320()
{
	wait(3);
	foreach(var_01 in level.players)
	{
		scripts\common\utility::func_136F7();
	}

	wait(1);
	level thread func_833D(25 + level.wave_num * 5);
	level thread func_833E(100);
}

//Function Number: 42
func_BEE1(param_00,param_01,param_02,param_03)
{
	if(!isdefined(param_01))
	{
		param_01 = (0,0,0);
	}

	var_04 = (0,0,0);
	if(isdefined(param_00.angles))
	{
		var_04 = param_00.angles;
	}

	var_05 = spawnvehicle(param_02,"neil","cp_kevin",param_00.origin + param_01,var_04);
	var_05.var_13084 = getent("neil_usetrig","targetname");
	var_05.var_13084.origin = var_05.origin + (0,0,60);
	var_05.var_13084 linkto(var_05);
	var_05 setcandamage(0);
	if(scripts\common\utility::istrue(param_03))
	{
		var_05.is_neil = 1;
		var_05.var_12F87 = spawn("script_model",var_05.origin);
		var_05.var_12F87.angles = var_05.angles;
		var_05.var_12F87 setmodel(level.var_BEB2);
		var_05.var_12F87 linkto(var_05);
	}

	return var_05;
}

//Function Number: 43
func_F999(param_00)
{
	level.var_BEAB = func_BEE1(param_00,undefined,level.var_8C89);
	level.var_BEAB attachpath(param_00);
	level.var_BEDC = spawnfx(level._effect["neil_repair_sparks"],level.var_BEAB gettagorigin("tag_fx"));
	wait(1);
	triggerfx(level.var_BEDC);
	level.var_BEAB method_8364("allies");
	level.var_BEAB.var_13084 makeunusable();
	level thread func_BEDE(level.var_BEAB);
}

//Function Number: 44
func_BEDE(param_00)
{
	level endon("stop_repair_sounds");
	wait(1);
}

//Function Number: 45
func_BECC(param_00)
{
	wait(1);
	func_BEC4();
}

//Function Number: 46
func_BECD(param_00)
{
	if(!isdefined(param_00) || isdefined(level.var_BEE3))
	{
		return;
	}

	level.var_BEE3 = 1;
	if(!isdefined(level.var_BEAB.var_101F6))
	{
		level.var_BEAB.var_101F6 = gettime() + 5000;
	}
	else if(level.var_BEAB.var_101F6 >= gettime())
	{
		level.var_BEE3 = undefined;
		return;
	}

	level.var_BEAB.var_101F6 = gettime() + 5000;
	var_01 = lookupsoundlength(param_00);
	if(soundexists(param_00))
	{
		self playsound(param_00);
	}

	thread func_BEBF(var_01);
	wait(var_01 / 1000);
	level.var_BEE3 = undefined;
}

//Function Number: 47
func_11025()
{
	self endon("death");
	wait(3);
	var_00 = 6400;
	for(;;)
	{
		if(!func_203C(self.origin,var_00) || isdefined(self.var_1E8F) || scripts\common\utility::flag("transform"))
		{
			wait(0.25);
			continue;
		}

		self stoploopsound();
		self playsound("neil_mvmt_stop");
		self method_83E6(0);
		scripts\common\utility::flag_set("halt_neil");
		self setscriptablepartstate("smoketrail","off");
		self.var_12F87 method_8292();
		self.var_12F87 scriptmodelplayanim("IW7_cp_zom_n31l_halt",1);
		if(!isdefined(self.var_118E0))
		{
			self.var_118E0 = gettime() + 30000;
			self.var_12F87 thread func_BECD("n31l_spawn_assembly");
		}
		else if(self.var_118E0 <= gettime())
		{
			self.var_118E0 = gettime() + 30000;
			self.var_12F87 thread func_BECD("n31l_spawn_assembly");
		}

		while(func_203C(self.origin,var_00) || scripts\common\utility::flag("transform"))
		{
			wait(0.5);
		}

		self playsound("neil_mvmt_start");
		self playloopsound("neil_mvmt_lp");
		self method_83E5(2,1,1);
		scripts\common\utility::func_6E2A("halt_neil");
		self.var_12F87 func_BEDF("happy_line");
		self setscriptablepartstate("smoketrail","on");
	}
}

//Function Number: 48
func_BEBF(param_00)
{
	self endon("neil_quiet");
	self endon("death");
	var_01 = gettime();
	var_02 = var_01 + param_00;
	var_03 = gettime();
	while(var_03 <= var_02)
	{
		if(isdefined(self.var_1E8F))
		{
			wait(0.5);
			continue;
		}

		var_03 = gettime();
		func_BEDF(scripts\common\utility::random(["oface","happy_line","happy"]));
		wait(0.75);
	}
}

//Function Number: 49
func_BEDF(param_00)
{
	if(isdefined(level.var_A6E1))
	{
		param_00 = "kitt";
	}

	switch(param_00)
	{
		case "happy":
			self setscriptablepartstate("happy","show");
			break;

		case "sad":
			self setscriptablepartstate("sad","show");
			break;

		case "angry":
			self setscriptablepartstate("angry","show");
			break;

		case "oface":
			self setscriptablepartstate("oface","show");
			break;

		case "happy_line":
			self setscriptablepartstate("happy_line","show");
			break;

		case "angry_line":
			self setscriptablepartstate("angry_line","show");
			break;

		case "kitt":
			self setscriptablepartstate("kitt","show");
			break;
	}
}

//Function Number: 50
func_203C(param_00,param_01)
{
	var_02 = 0;
	foreach(var_04 in level.players)
	{
		if(var_04 scripts\cp\_utility::is_valid_player() && distancesquared(var_04.origin,param_00) < param_01)
		{
			return 1;
		}
	}

	return 0;
}

//Function Number: 51
func_CB37(param_00,param_01)
{
	param_01 playlocalsound("neil_part_pickup");
	playfx(level._effect["souvenir_pickup"],param_00.var_BEC5.origin);
	scripts\cp\_interaction::remove_from_current_interaction_list(param_00);
	param_00.var_BEC5 delete();
	level.var_BEC7 = 1;
	level scripts\cp\_utility::set_quest_icon(7);
	level.var_13BD1 = level.wave_num;
	if(randomint(100) > 90)
	{
		param_01 thread scripts\cp\_vo::try_to_play_vo("collect_n31l","zmb_comment_vo","low",10,0,0,0,50);
	}
	else
	{
		param_01 thread scripts\cp\_vo::try_to_play_vo("quest_n31l_find_head","zmb_comment_vo","highest",10,1,0,0,100);
	}

	level thread func_CDA9(param_01);
}

//Function Number: 52
func_CDA9(param_00)
{
	param_00 endon("disconnect");
	level endon("game_ended");
	param_00 thread scripts\cp\_vo::func_1769("nag_return_n31lpart","zmb_comment_vo",60,60,3,1);
	wait(4);
	level thread scripts\cp\_vo::try_to_play_vo("ww_N3il_construction","zmb_ww_vo","highest",60,0,0,1);
	wait(1);
	level thread scripts\cp\_vo::func_1769("dj_n3il_part_recovered_nag","zmb_dj_vo",60,120,3,1);
}

//Function Number: 53
func_CB32(param_00,param_01)
{
	param_01 playlocalsound("neil_part_pickup");
	playfx(level._effect["souvenir_pickup"],param_00.var_C909.origin);
	scripts\cp\_interaction::remove_from_current_interaction_list(param_00);
	param_00.var_C909 delete();
	level.var_13BCD = level.wave_num;
	if(randomint(100) > 90)
	{
		param_01 thread scripts\cp\_vo::try_to_play_vo("collect_n31l","zmb_comment_vo","low",10,0,0,0,50);
	}
	else
	{
		param_01 thread scripts\cp\_vo::try_to_play_vo("quest_n31l_find_battery","zmb_comment_vo","highest",10,1,0,0,100);
	}

	level.var_BEB0 = 1;
	level scripts\cp\_utility::set_quest_icon(8);
	level.var_BEAB.var_13084 sethintstring(&"CP_ZMB_INTERACTIONS_LOAD_BATTERY");
}

//Function Number: 54
func_CB34(param_00,param_01)
{
	param_01 playlocalsound("neil_part_pickup");
	playfx(level._effect["souvenir_pickup"],param_00.var_C909.origin);
	scripts\cp\_interaction::remove_from_current_interaction_list(param_00);
	param_00.var_C909 delete();
	level.var_13BCF = level.wave_num;
	if(randomint(100) > 90)
	{
		param_01 thread scripts\cp\_vo::try_to_play_vo("collect_n31l","zmb_comment_vo","low",10,0,0,0,50);
	}
	else
	{
		param_01 thread scripts\cp\_vo::try_to_play_vo("quest_n31l_find_disc","zmb_comment_vo","highest",10,1,0,0,100);
	}

	level.var_BEC3 = 1;
	level scripts\cp\_utility::set_quest_icon(9);
	level.var_BEAB.var_13084 sethintstring(&"CP_ZMB_INTERACTIONS_LOAD_FLOPPY");
}

//Function Number: 55
func_9696(param_00)
{
	var_01 = scripts\common\utility::getstructarray("neil_battery","script_noteworthy");
	foreach(var_03 in var_01)
	{
		scripts\cp\_interaction::remove_from_current_interaction_list(var_03);
	}
}

//Function Number: 56
func_10778(param_00)
{
	var_01 = func_1077B("neil_battery","space_interior_power_adapter");
	level.var_BEAE = var_01.var_9A3E;
}

//Function Number: 57
func_9697(param_00)
{
	var_01 = scripts\common\utility::getstructarray("neil_firmware","script_noteworthy");
	foreach(var_03 in var_01)
	{
		scripts\cp\_interaction::remove_from_current_interaction_list(var_03);
	}
}

//Function Number: 58
func_10779()
{
	var_00 = func_1077B("neil_firmware","zmb_n31l_robot_minifloppy");
	level.var_BEC1 = var_00.var_9A3E;
}

//Function Number: 59
func_1077B(param_00,param_01)
{
	var_02 = scripts\common\utility::getstructarray(param_00,"script_noteworthy");
	var_03 = scripts\common\utility::random(var_02);
	foreach(var_05 in var_02)
	{
		if(var_05 == var_03)
		{
			scripts\cp\_interaction::add_to_current_interaction_list(var_05);
			break;
		}
	}

	var_07 = scripts\common\utility::getstruct(var_03.target,"targetname");
	var_08 = spawn("script_model",var_07.origin);
	if(isdefined(var_07.angles))
	{
		var_08.angles = var_07.angles;
	}

	var_03.var_C909 = var_08;
	var_08.var_9A3E = var_03;
	var_08 setmodel(param_01);
	var_08 notsolid();
	return var_08;
}

//Function Number: 60
func_1077A()
{
	var_00 = scripts\common\utility::getstruct("neil_head","script_noteworthy");
	var_01 = scripts\common\utility::getstruct(var_00.target,"targetname");
	var_02 = spawn("script_model",var_01.origin);
	var_02.angles = var_01.angles;
	var_02 setmodel(level.var_BEC8);
	var_02 notsolid();
	scripts\common\utility::func_136F7();
	var_00.var_BEC5 = var_02;
	wait(1);
	level.var_BEC5 = var_00;
}

//Function Number: 61
func_BE86()
{
	self endon("disconnect");
	self method_80F4(&"COOP_INTERACTIONS_NEED_MONEY");
	wait(1);
	self method_80F3();
}

//Function Number: 62
func_1176E()
{
	for(;;)
	{
		scripts\common\utility::flag_wait("transformation_complete");
		func_BEAC();
		level.var_BEAB method_83E7(level.var_BEAB.origin,level.var_BEAB.angles);
		level.var_BEAB method_83E5(2,1,1);
		for(;;)
		{
			level.var_BEAB.var_13084 waittill("trigger",var_00);
			if(!var_00 scripts\cp\_utility::is_valid_player() || isdefined(level.var_BEAB.var_4613))
			{
				continue;
			}

			if(!var_00 scripts\cp\_persistence::func_D0BB(5000))
			{
				if(soundexists("purchase_deny"))
				{
					var_00 playlocalsound("purchase_deny");
				}

				var_00 thread scripts\cp\_vo::try_to_play_vo("no_cash","zmb_comment_vo","high",3,0,0,1);
				var_00 thread func_BE86();
				continue;
			}
			else
			{
				var_00 scripts\cp\_persistence::func_11445(5000,1,"trap");
			}

			break;
		}

		level.var_BEAB.var_13084 makeunusable();
		level.var_BEAB.var_12F87 thread func_BECD("n31l_challenge_success_generic_dj");
		wait(3);
		level.var_BEAB notify("neil_quiet");
		func_12636(level.var_BEAB,"iw7_erad_zm+eradpap2");
	}
}

//Function Number: 63
func_BEAC()
{
	stopfxontag(level.var_BECF,level.var_BEAB,"tag_fx");
	level.var_BEAB.var_6265 = 0;
	level.var_BEAB.var_4613 = 1;
	level.var_BEAB.var_13084 makeusable();
	level.var_BEAB.var_13084 sethintstring(&"CP_ZMB_CHALLENGES_REBOOTING");
	var_00 = 120;
	wait(var_00);
	level.var_BEAB.var_13084 method_84A2(90);
	level.var_BEAB.var_13084 method_84A5(180);
	func_BEBD(level.var_BEAB,&"CP_ZMB_CHALLENGES_BUY_NEIL");
	level.var_BEAB.var_4613 = undefined;
}

//Function Number: 64
func_DB29(param_00)
{
	self startpath();
	self method_83E5(2,1,1);
	thread func_BED0(param_00);
}

//Function Number: 65
func_BED0(param_00)
{
	self endon("death");
	thread func_BEE4();
	thread func_BEBA();
	thread func_BECE();
	thread func_11025();
	self setscriptablepartstate("smoketrail","on");
	for(;;)
	{
		self waittill("reached_end_node");
		self startpath(param_00);
		while(scripts\common\utility::flag("transform"))
		{
			wait(1);
		}
	}
}

//Function Number: 66
func_BEE4()
{
	self endon("death");
	self stoploopsound();
	self playsound("neil_mvmt_start");
	self playloopsound("neil_mvmt_lp");
	for(;;)
	{
		for(var_00 = 0;scripts\common\utility::flag("transform") || scripts\common\utility::flag("halt_neil");var_00 = 0)
		{
			wait(0.1);
		}

		while(isdefined(self.var_225))
		{
			wait(0.1);
			var_00 = 0;
		}

		if(var_00 == 0)
		{
			self.var_12F87 method_8292();
			self.var_12F87 scriptmodelplayanim("IW7_cp_zom_n31l_walk",1);
		}

		wait(0.1);
		var_00 = var_00 + 1;
		if(var_00 >= 70)
		{
			var_00 = 0;
		}
	}
}

//Function Number: 67
func_BEBA()
{
	self endon("death");
	self.var_12F87 setcandamage(1);
	self.var_12F87.health = 1000000;
	for(;;)
	{
		while(scripts\common\utility::flag("transform"))
		{
			wait(1);
		}

		self.var_12F87 waittill("damage",var_00,var_01,var_02,var_03,var_04,var_05,var_06,var_07,var_08,var_09);
		self.var_12F87 playsound("neil_impact");
		self.var_12F87 method_8292();
		self.var_12F87 scriptmodelplayanim("IW7_cp_zom_n31l_hit",1);
		self.var_12F87.health = 1000000;
		scripts\common\utility::func_136F7();
		self.var_12F87 playsound("neil_emote_angry_face");
		self.var_12F87 func_BEDF(scripts\common\utility::random(["angry","angry_line"]));
		self.var_12F87 thread func_E493();
		self.var_225 = 1;
		wait(0.5);
		self.var_225 = undefined;
	}
}

//Function Number: 68
func_E493()
{
	self endon("death");
	self endon("transform");
	self endon("damage");
	self.var_1E8F = 1;
	wait(2);
	self.var_1E8F = undefined;
	func_BEDF("happy_line");
}

//Function Number: 69
func_4EFA()
{
	var_00 = scripts\common\utility::getstruct("neil_repair","script_noteworthy");
	if(isdefined(level.var_BEC5.var_BEC5))
	{
		func_CB37(level.var_BEC5,level.players[0]);
		wait(1);
		func_1728(var_00,level.players[0]);
		return;
	}
	else if(isdefined(level.var_BEAE) && isdefined(level.var_BEAE.var_C909))
	{
		func_CB32(level.var_BEAE,level.players[0]);
	}
	else if(isdefined(level.var_BEC1) && isdefined(level.var_BEC1.var_C909))
	{
		func_CB34(level.var_BEC1,level.players[0]);
	}

	wait(0.5);
	level.var_BEAB.var_13084 notify("trigger",level.players[0]);
	wait(1);
	func_1728(var_00,level.players[0]);
}

//Function Number: 70
func_BEDD(param_00,param_01)
{
	if(isdefined(level.var_BEC7))
	{
		return &"CP_ZMB_INTERACTIONS_ATTACH_HEAD";
	}

	if(isdefined(level.var_BEB0))
	{
		return &"CP_ZMB_INTERACTIONS_LOAD_BATTERY";
	}

	if(isdefined(level.var_BEC3))
	{
		return &"CP_ZMB_INTERACTIONS_LOAD_FLOPPY";
	}

	if(!isdefined(level.var_BEC7))
	{
		return &"CP_ZMB_INTERACTIONS_MISSING_HEAD";
	}

	return &"CP_ZMB_INTERACTIONS_REPAR_NEIL";
}

//Function Number: 71
func_1728(param_00,param_01)
{
	if(isdefined(level.var_BEC7))
	{
		param_01 playlocalsound("neil_part_place");
		param_01 thread scripts\cp\_vo::try_to_play_vo("challenge_n31l_head","zmb_comment_vo","highest",10,1,0,0,100);
		param_01 thread scripts\cp\_vo::try_to_play_vo("part_assemble_n31l","zmb_comment_vo","low",10,0,0,0,50);
		level thread scripts\cp\_vo::func_E01F("dj_n3il_part_recovered_nag");
		level thread scripts\cp\_vo::func_E01F("nag_return_n31lpart");
		level.var_BEDC delete();
		level notify("stop_repair_sounds");
		level.var_BEAB setmodel(level.var_74B8);
		level.neil_head_added = 1;
		level.var_BEC7 = undefined;
		param_01 thread scripts\cp\_hud_message::func_12AAE("quest_neil");
		scripts\common\utility::flag_set("neil_head_attached");
		var_02 = getent("neil_repair_clip","targetname");
		var_02 connectpaths();
		var_02 delete();
		scripts\cp\_interaction::remove_from_current_interaction_list(param_00);
	}
	else if(isdefined(level.var_BEB0))
	{
		param_01 playlocalsound("neil_part_place");
		level.var_BEAF = 1;
		param_01 thread scripts\cp\_vo::try_to_play_vo("challenge_n31l_battery","zmb_comment_vo","highest",10,1,0,0,100);
		scripts\common\utility::flag_set("neil_battery_attached");
		level thread scripts\cp\_vo::func_E01F("nag_return_n31lpart");
		level.var_BEB0 = undefined;
	}
	else if(isdefined(level.var_BEC3))
	{
		param_01 playlocalsound("neil_part_place");
		level.var_BEC2 = 1;
		param_01 thread scripts\cp\_vo::try_to_play_vo("challenge_n31l_disk","zmb_comment_vo","highest",10,1,0,0,100);
		level thread scripts\cp\_vo::func_E01F("nag_return_n31lpart");
		scripts\common\utility::flag_set("neil_firmware_attached");
		level.var_BEC3 = undefined;
	}

	if(isdefined(param_01))
	{
		param_01 scripts\cp\_interaction::func_DE6E();
	}
}

//Function Number: 72
func_833E(param_00)
{
	foreach(var_02 in level.players)
	{
		var_02 scripts\cp\_persistence::give_player_xp(param_00,1);
		wait(0.05);
	}
}

//Function Number: 73
func_BEC4()
{
	wait(0.5);
	level thread func_833D(25);
}

//Function Number: 74
func_833D(param_00)
{
	foreach(var_02 in level.players)
	{
		var_02 scripts\cp\zombies\arcade_game_utility::func_8317(var_02,param_00);
		wait(0.05);
	}
}

//Function Number: 75
func_1C5F()
{
	level.var_BEAB endon("death");
	level.var_BEAB endon("transform");
	level endon("failed_too_many_times");
	level endon("neil_enabled_changed");
	level.var_1C3F = 1;
	for(;;)
	{
		func_BEBD(level.var_BEAB,&"CP_ZMB_INTERACTIONS_PAUSE_CHALLENGES",1);
		for(;;)
		{
			level.var_BEAB.var_13084 waittill("trigger",var_00);
			if(!var_00 scripts\cp\_utility::is_valid_player())
			{
				continue;
			}

			break;
		}

		func_BEBC(level.var_BEAB);
		scripts\common\utility::flag_set("pause_challenges");
		level thread scripts\cp\_challenge::func_C9B9();
		level.var_BEAB.var_12F87 thread func_BECD("n31l_spawn_assembly");
		wait(5);
		func_BEBD(level.var_BEAB,&"CP_ZMB_CHALLENGES_RESUME_CHALLENGE",1);
		for(;;)
		{
			level.var_BEAB.var_13084 waittill("trigger",var_00);
			if(!var_00 scripts\cp\_utility::is_valid_player())
			{
				continue;
			}

			break;
		}

		func_BEBC(level.var_BEAB);
		level.var_BEAB.var_12F87 thread func_BECD("n31l_challenge_reactivate");
		scripts\common\utility::func_6E2A("pause_challenges");
		foreach(var_00 in level.players)
		{
			var_00 setclientomnvar("zm_show_challenge",11);
		}

		wait(5);
	}
}

//Function Number: 76
func_BEC0()
{
	level notify("failed_too_many_times");
	scripts\common\utility::flag_set("pause_challenges");
	level waittill("next_challenge_starting");
	level.var_1C3F = undefined;
	func_BEBD(level.var_BEAB,&"CP_ZMB_CHALLENGES_RESUME_CHALLENGE");
	for(;;)
	{
		level.var_BEAB.var_13084 waittill("trigger",var_00);
		if(!var_00 scripts\cp\_utility::is_valid_player())
		{
			continue;
		}

		break;
	}

	func_BEBC(level.var_BEAB);
	scripts\common\utility::func_6E2A("pause_challenges");
	level.var_6ACC = 0;
	level.var_BEAB.var_12F87 thread func_BECD("n31l_spawn_assembly");
	wait(6);
	func_BEBD(level.var_BEAB,&"CP_ZMB_INTERACTIONS_PAUSE_CHALLENGES");
	if(!isdefined(level.var_1C3F))
	{
		level.var_BEAB thread func_1C5F();
	}
}

//Function Number: 77
func_BECE()
{
	self endon("death");
	var_00 = 1225;
	var_01 = 4096;
	for(;;)
	{
		while(scripts\common\utility::flag("transform"))
		{
			wait(1);
		}

		var_02 = scripts\cp\_agent_utils::func_7DB0("axis");
		var_02 = sortbydistance(var_02,self.origin);
		var_03 = var_02[0];
		var_04 = getentarray("placed_transponder","script_noteworthy");
		if(!isdefined(var_03) && var_04.size == 0)
		{
			wait(0.1);
			continue;
		}

		if(isdefined(var_03))
		{
			if(distance2dsquared(self.origin,var_03.origin) < var_00 && scripts\common\utility::istrue(var_03.var_9BB0) || scripts\common\utility::istrue(var_03.var_9E0C))
			{
				var_03 dodamage(var_03.health + 100,self.origin);
			}
		}

		foreach(var_06 in var_04)
		{
			if(distance2dsquared(self.origin,var_06.origin) < var_01)
			{
				if(isdefined(var_06.var_222) && var_06.var_222 scripts\cp\_utility::is_valid_player(1))
				{
					var_06.var_222 playlocalsound("ww_magicbox_laughter");
				}

				var_06 notify("detonateExplosive");
			}
		}

		wait(1);
	}
}