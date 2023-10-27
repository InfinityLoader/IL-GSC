/*******************************************************************
 * Decompiled By: Bog
 * Decompiled File: maps\odin_audio.gsc
 * Game: Call of Duty: Ghosts
 * Platform: Console
 * Function Count: 81
 * Decompile Time: 1045 ms
 * Timestamp: 10/27/2023 1:36:48 AM
*******************************************************************/

//Function Number: 1
func_4FDD()
{
	common_scripts\utility::func_3385("invader_music_cue");
	common_scripts\utility::func_3385("fade_intro_music");
	common_scripts\utility::func_3385("stop_music_pod_explo");
	common_scripts\utility::func_3385("rcs_is_damaged");
	common_scripts\utility::func_3385("mus_odin_end");
	common_scripts\utility::func_3385("mus_atmosphere");
	common_scripts\utility::func_3385("stop_sat_thrust_loop");
	common_scripts\utility::func_3385("stop_sat_lat_thrust_loop");
	common_scripts\utility::func_3385("escape_door_opened");
	common_scripts\utility::func_3385("auto_door_closed");
	common_scripts\utility::func_3385("stop_scuttle_loop");
	common_scripts\utility::func_3385("begin_scuttle_ramp");
	common_scripts\utility::func_3385("sat_second_expl");
	common_scripts\utility::func_3385("sfx_odin_ending");
	level.var_5D19 = 0;
	level.var_5CFF = 0;
	if(isdefined(level.var_61E7) && level.var_61E7 == 1)
	{
		level.space_breathing_enabled = 1;
	}
	else
	{
		level.space_breathing_enabled = 1;
	}

	level.player thread maps\_space_player::func_5F16();
	function_0199("music",0);
	function_0199("effects1",0);
	function_0199("effects2d1",0);
	function_0199("effects2d2",0);
	function_0199("ambient",0);
	function_0199("weapon",0);
	function_0199("bulletimpact",0);
	function_0199("bulletwhizbyin",0);
	function_0199("bulletwhizbyout",0);
	function_0199("norestrict2d",0);
	thread audio_odin_pressurized_variable();
	level.var_733B = 0;
	level.shaky_moment = 0;
	level.no_impact = 0;
}

//Function Number: 2
audio_odin_pressurized_variable()
{
	level.pressurized = 0;
}

//Function Number: 3
audio_set_initial_ambience()
{
	wait(0.1);
	if(level.start_point == "odin_intro")
	{
		level.player method_83BF("odin_title",3);
	}
	else
	{
		level.player method_83BF("odin_intro",0);
	}

	thread func_52E5();
	if(level.start_point == "odin_ally" || level.start_point == "odin_escape" || level.start_point == "odin_spin")
	{
		wait(1);
		level.player method_83BF("odin_pressurized",6);
		level.pressurized = 0;
	}

	if(level.start_point == "odin_intro")
	{
		wait(5);
		level.player method_83BE(3);
	}
}

//Function Number: 4
func_52E5()
{
	switch(level.start_point)
	{
		case "default":
		case "odin_intro":
			common_scripts\utility::flag_wait("fade_intro_music");
			maps\_utility::func_5541(10);
			break;

		case "odin_ally":
			common_scripts\utility::flag_wait("invader_music_cue");
			break;

		case "odin_spin":
		case "odin_escape":
			wait(0.5);
			maps\_utility::music_play("mus_odin_invader",0.1);
			thread func_72E8();
			common_scripts\utility::flag_wait("stop_music_pod_explo");
			maps\_utility::func_5541(1);
			common_scripts\utility::flag_wait("mus_odin_end");
			maps\_utility::music_play("mus_odin_end");
			break;

		case "odin_spacejump":
		case "odin_end":
		case "odin_satellite":
			maps\_utility::music_play("mus_odin_end");
			common_scripts\utility::flag_wait("mus_atmosphere");
			maps\_utility::func_5530("mus_odin_end_atmosphere",0.5);
			wait(25);
			level.player method_83BF("odin_end_fadeout",3);
			break;

		default:
			break;
	}
}

//Function Number: 5
sfx_player_intro_movement()
{
	wait(4.8);
	self playsound("scn_odin_player_intro_movement");
}

//Function Number: 6
func_7398()
{
	wait(2.3);
	level.player playsound("scn_odin_traversal_01");
}

//Function Number: 7
func_7399()
{
	wait(0.4);
	level.player playsound("scn_odin_traversal_02");
}

//Function Number: 8
func_72E8()
{
	wait(3);
	var_00 = spawn("script_origin",(3365,47471,48608));
	var_00 playloopsound("emt_odin_alarm3");
	var_01 = spawn("script_origin",(3281,47035,48593));
	var_01 playloopsound("emt_odin_alarm2");
}

//Function Number: 9
func_723A()
{
	wait(10);
	var_00 = spawn("script_origin",(0,50000,50000));
	var_01 = 0;
	for(;;)
	{
		if(common_scripts\utility::flag("saved_ally"))
		{
			break;
		}

		var_02 = pointonsegmentnearesttopoint((3200,47190,48558),(3280,46530,48558),level.player.origin);
		var_00 moveto(var_02,0.01);
		if(var_01 == 0)
		{
			var_00 playloopsound("emt_odin_bg_fighting_01_lp");
			var_01 = 1;
		}

		wait(0.1);
	}

	var_00 stoploopsound("emt_odin_bg_fighting_01_lp");
	var_00 delete();
	thread func_7239();
}

//Function Number: 10
func_7239()
{
	wait(2);
	level.var_7238 = spawn("script_origin",(3178,46395,-13132));
	level.var_7238 playloopsound("emt_odin_bg_fighting_02_lp");
}

//Function Number: 11
sfx_bg_fighting_stop()
{
	wait(1);
	level.player method_83BF("odin_fighting_fade",3.5);
	wait(3.5);
	level.var_7238 stoploopsound("emt_odin_bg_fighting_02_lp");
	level.var_7238 delete();
	wait(1);
	level.player method_83BF("odin_pressurized",1);
}

//Function Number: 12
func_7221()
{
	level.var_7334 = spawn("script_origin",self.origin);
	level.var_7334 linkto(self);
	wait(0.4);
	level.var_7334 playsound("scn_odin_player_grapple");
	common_scripts\utility::flag_wait("saved_ally");
	wait(0.2);
	level.var_7334 stopsounds();
}

//Function Number: 13
func_7225()
{
	level.var_733B = 1;
	level.grapple = spawn("script_origin",self.origin);
	level.grapple playsound("scn_odin_player_grapple_ss","grappledone");
	level.grapple waittill("grappledone");
	level.var_733B = 0;
}

//Function Number: 14
sfx_ally_ally_grapple()
{
	self playsound("scn_odin_ally_grapple");
}

//Function Number: 15
func_7224()
{
	if(!isdefined(level.var_7339))
	{
		level.var_7339 = spawn("script_origin",self.origin);
		level.var_7339 linkto(self);
	}

	if(!isdefined(level.var_733A))
	{
		level.var_733A = spawn("script_origin",self.origin);
		level.var_733A linkto(self);
		level.var_733A playloopsound("scn_odin_player_grapple_lt_lp");
	}
}

//Function Number: 16
sfx_ally_plr_grapple_loop()
{
	if(level.var_7338 == 0)
	{
		level.var_7338 = 1;
		level.var_7339 playloopsound("scn_odin_player_grapple_lp");
		level.var_733A stoploopsound();
	}
}

//Function Number: 17
func_7226()
{
	if(level.var_7338 == 1)
	{
		level.var_733A playloopsound("scn_odin_player_grapple_lt_lp");
		self playsound("scn_odin_player_grapple_stop");
		level.var_7339 stoploopsound();
		level.var_7338 = 0;
	}
}

//Function Number: 18
func_7222()
{
	level.var_7334 stopsounds();
	level.var_7339 stoploopsound();
	level.var_733A stoploopsound();
	self playsound("scn_odin_ally_grapple");
}

//Function Number: 19
func_7227()
{
	level.player playsound("scn_odin_grapple_shoot_lr");
	level.player method_83BF("odin_grapple_shoot",0.15);
	level.var_7334 stopsounds();
	level.var_7339 stoploopsound();
	level.var_733A stoploopsound();
	wait(1.34);
	level.player method_83BF("odin_pressurized",1);
}

//Function Number: 20
func_7281(param_00)
{
}

//Function Number: 21
func_7330()
{
}

//Function Number: 22
func_737A()
{
	wait(0.6);
	level.player method_83BF("odin_intro",17);
}

//Function Number: 23
sfx_odin_decompress()
{
	common_scripts\utility::flag_set("stop_music_pod_explo");
	level.player method_83BF("odin_scuttle_event_2",1);
	level.pressurized = 0;
	level.var_773E = 1;
	level.var_5CFF = 0;
	wait(2.04);
	level.player method_83BF("odin_after_scuttle",1);
	level.space_breathing_enabled = 1;
}

//Function Number: 24
sfx_odin_decompress_explode()
{
	level.airlockexplode = spawn("script_origin",(-160,46398,-15748));
	level.airlockexplode playsound("scn_odin_decompression_explode_ss");
	level.var_773E = 2;
	level.player method_83BF("odin_scuttle",0.3);
	wait(0.3);
	if(isdefined(level.var_205E))
	{
		level.var_205E stopsounds();
	}

	wait(4.7);
	wait(8);
	level.var_773E = 1;
}

//Function Number: 25
func_7342()
{
	level.player method_83BF("odin_pressurized",6);
	level.pressurized = 0;
}

//Function Number: 26
func_7341()
{
	common_scripts\utility::flag_set("fade_intro_music");
	level.player playsound("scn_odin_pressurize_lr_ss");
	wait(3);
	thread func_7342();
	thread func_728E();
}

//Function Number: 27
func_728E()
{
	level.var_2F15 = spawn("script_origin",(2915,47423,48552));
	level.var_2F15 playloopsound("scn_odin_enemy_entrance_latches");
	level.enemyguys2 = spawn("script_origin",(3004,47428,48635));
	level.enemyguys2 playloopsound("scn_odin_enemy_entrance_beeps");
}

//Function Number: 28
sfx_odin_spin_explosion(param_00)
{
	param_00 playsound("scn_odin_spin_explosion");
}

//Function Number: 29
func_7324(param_00)
{
	var_01 = spawn("script_origin",param_00.origin);
	var_01 playsound("scn_odin_ROD_fire_dist");
}

//Function Number: 30
func_7323(param_00)
{
	param_00 playsound("scn_odin_ROD_fire_close");
}

//Function Number: 31
func_728C(param_00)
{
	switch(param_00)
	{
		case 1:
			break;

		case 2:
			break;

		case 3:
			break;

		case 4:
			break;

		case 5:
			break;

		default:
			break;
	}
}

//Function Number: 32
sfx_shaky_camera_moment()
{
	level.player playsound("scn_odin_dist_fire_shake_lr");
	var_00 = (1543,46455,-15729);
	var_01 = (1779,46378,-15747);
	var_02 = (1282,46308,-15694);
	if(level.shaky_moment == 0)
	{
		wait(0.5);
		var_03 = spawn("script_origin",var_01);
		var_03 playsound("scn_odin_dist_fire_shake_mn_03");
		level.shaky_moment = 1;
	}

	if(level.shaky_moment == 1)
	{
		wait(0.5);
		var_03 = spawn("script_origin",var_02);
		var_03 playsound("scn_odin_dist_fire_shake_mn_02");
		level.shaky_moment = 2;
	}
}

//Function Number: 33
func_727F()
{
	if(!common_scripts\utility::flag("sfx_odin_ending"))
	{
		if(level.var_5D19 == 0)
		{
			thread common_scripts\utility::func_5D1F("scn_odin_dist_fire_moment",(108,44645,-15751));
		}

		if(level.var_5D19 == 3)
		{
			thread common_scripts\utility::func_5D1F("scn_odin_dist_fire_moment",(-11686,46111,-16126));
		}
	}
}

//Function Number: 34
func_7370(param_00)
{
	wait(5.5);
	param_00 playsound("scn_odin_shuttle_pass");
	level.player method_83BF("odin_title",1);
}

//Function Number: 35
func_736E()
{
	if(!common_scripts\utility::flag("begin_scuttle_ramp"))
	{
		common_scripts\utility::flag_set("begin_scuttle_ramp");
		level.var_7713 = 0;
	}

	level.var_7713 = level.var_7713 + 1;
	switch(level.var_7713)
	{
		case 1:
			level.player playsound("scn_odin_scuttle_01_lr");
			break;

		case 3:
			level.player playsound("scn_odin_scuttle_02_lr");
			break;

		case 5:
			level.player playsound("scn_odin_scuttle_03_lr");
			break;

		case 7:
			level.player playsound("scn_odin_scuttle_04_lr");
			break;

		case 9:
			level.player playsound("scn_odin_scuttle_05_lr");
			break;

		case 11:
			level.player playsound("scn_odin_scuttle_06_lr");
			level.var_7713 = 0;
			break;
	}
}

//Function Number: 36
sfx_airlock_door()
{
	wait(10.2);
	var_00 = spawn("script_origin",(3842,47413,48544));
	var_00 playsound("scn_odin_airlock_door_open","door_sound");
	var_00 waittill("door_sound");
	var_00 delete();
}

//Function Number: 37
func_72DB()
{
	common_scripts\utility::flag_set("invader_music_cue");
	wait(0.4);
	var_00 = spawn("script_origin",(2916,47423,48555));
	var_00 playsound("scn_odin_breach_door_open");
	thread func_72DC();
	wait(3);
	var_00 delete();
}

//Function Number: 38
sfx_post_infil_door()
{
	var_00 = spawn("script_origin",(3320,47269,48555));
	var_00 playsound("scn_odin_post_infil_door_open");
	wait(6);
	var_00 delete();
}

//Function Number: 39
func_733C()
{
	wait(0.5);
	level.player playsound("scn_odin_station_door_open_plr");
}

//Function Number: 40
func_72F6()
{
	wait(1.3);
	var_00 = spawn("script_origin",(2149,46401,-15743));
	var_00 playsound("scn_odin_station_door_open_kyra");
	wait(4);
	var_00 delete();
}

//Function Number: 41
func_7290()
{
	if(!common_scripts\utility::flag("escape_door_opened"))
	{
		common_scripts\utility::flag_set("escape_door_opened");
		var_00 = spawn("script_origin",(3172,46403,-15743));
		var_00 playsound("scn_odin_auto_door_open");
		wait(3);
		var_00 delete();
		common_scripts\utility::func_337C("escape_door_opened");
	}
}

//Function Number: 42
func_7277()
{
	if(!common_scripts\utility::flag("escape_door_opened"))
	{
		common_scripts\utility::flag_set("escape_door_opened");
		var_00 = spawn("script_origin",(498,46400,-15743));
		var_00 playsound("scn_odin_scuttle_door_open");
		level.player playsound("scn_odin_decompression_lr_ss");
		thread sfx_odin_decompress();
		wait(3);
		var_00 delete();
		common_scripts\utility::func_337C("escape_door_opened");
	}
}

//Function Number: 43
func_72E1(param_00,param_01)
{
	if(!isdefined(param_01))
	{
		param_01 = 0;
	}

	wait(param_01);
	if(isdefined(param_00) && !common_scripts\utility::flag("escape_door_opened"))
	{
		common_scripts\utility::flag_set("escape_door_opened");
		param_00 playsound("scn_odin_auto_door_open");
		wait(2.3);
		common_scripts\utility::func_337C("escape_door_opened");
	}
}

//Function Number: 44
func_72E0(param_00,param_01)
{
	if(!isdefined(param_01))
	{
		param_01 = 0;
	}

	wait(param_01);
	if(isdefined(param_00) && !common_scripts\utility::flag("auto_door_closed"))
	{
		common_scripts\utility::flag_set("auto_door_closed");
		if(param_00.door_name != "post_infil_auto_door")
		{
			param_00 playsound("scn_odin_auto_door_close");
		}

		wait(2.2);
		common_scripts\utility::func_337C("auto_door_closed");
	}
}

//Function Number: 45
func_72DC()
{
	wait(0.7);
	var_00 = spawn("script_origin",(2931,47420,48560));
	var_00 playsound("scn_odin_enemy_entrance_foley_01");
	thread func_72DD();
	thread func_72DF();
	wait(5);
	var_00 delete();
}

//Function Number: 46
func_72DD()
{
	wait(4.3);
	var_00 = spawn("script_origin",(3193,47481,48565));
	var_00 playsound("scn_odin_enemy_entrance_foley_02");
	thread func_72DE();
	wait(9);
	var_00 delete();
}

//Function Number: 47
func_72DE()
{
	wait(7.9);
	var_00 = spawn("script_origin",(2931,47420,48570));
	var_00 playsound("scn_odin_enemy_entrance_foley_03");
	wait(6);
	var_00 delete();
}

//Function Number: 48
func_72DF()
{
	wait(2);
	level.player method_83BF("odin_infiltrator",0.1);
	wait(1);
	level.player method_83BF("odin_pressurized",0.3);
}

//Function Number: 49
sfx_kyra_hatch(param_00)
{
	wait(3);
	param_00 playsound("scn_odin_hatch_close_kyra");
	var_01 = spawn("script_origin",(3192,47424,48553));
	var_01 playsound("scn_odin_hatch_close");
}

//Function Number: 50
sfx_odin_spinup()
{
	wait(2);
	var_00 = spawn("script_origin",(3951,46358,-12977));
	var_00 playsound("emt_odin_on_alarm");
	var_01 = spawn("script_origin",(3217,46399,-13043));
	var_01 playsound("emt_odin_on_alarm");
	wait(1.5);
	thread func_2C93();
	level.player playsound("scn_odin_enemy_lightsoff");
	wait(1.5);
	thread func_732C();
}

//Function Number: 51
func_732C()
{
	var_00 = spawn("script_origin",(3580,46437,-13022));
	var_00 playloopsound("emt_odin_alarm");
	var_01 = spawn("script_origin",(2974,46495,-15687));
	var_01 playloopsound("emt_odin_alarm");
	var_02 = spawn("script_origin",(2300,46387,-15698));
	var_02 playloopsound("emt_odin_alarm");
	var_03 = spawn("script_origin",(1487,46380,-15710));
	var_03 playloopsound("emt_odin_alarm");
	var_04 = spawn("script_origin",(861,46386,-15744));
	var_04 playloopsound("emt_odin_alarm");
}

//Function Number: 52
func_2C93()
{
	var_00 = spawn("script_origin",(3217,-46399,-13043));
	var_00 playsound("emt_scn_odin_on");
	var_00 moveto((3951,46358,-12977),3);
}

//Function Number: 53
func_7367()
{
	var_00 = spawn("script_origin",(1308,46452,-15666));
	var_00 playloopsound("emt_blackice_flarestack_alarm_03_lp");
}

//Function Number: 54
sfx_spin_emt()
{
	wait(2.7);
	var_00 = spawn("script_origin",(-2275,46574,-16077));
	var_01 = spawn("script_origin",(-2412,46190,-16000));
	var_02 = spawn("script_origin",(-2341,46958,-16000));
	var_03 = spawn("script_origin",(-2456,46570,-15936));
	var_04 = spawn("script_origin",(-1647,46636,-16000));
	var_05 = spawn("script_origin",(-3067,46280,-16028));
	var_06 = spawn("script_origin",(-2792,46730,-16000));
	var_00 playsound("emt_odin_space_spin_01");
	wait(0.2);
	var_04 playsound("emt_odin_space_spin_02");
	wait(4);
	var_02 playsound("emt_odin_space_spin_03","spin_01");
	var_02 waittill("spin_01");
	var_01 playsound("emt_odin_space_spin_04");
	wait(0.6);
	var_04 playsound("emt_odin_space_spin_05");
	wait(2.3);
	var_00 playsound("emt_odin_space_spin_06","spin_02");
	var_00 waittill("spin_02");
	var_05 playsound("emt_odin_space_spin_07");
	wait(0.5);
	var_01 playsound("emt_odin_space_spin_08");
	wait(1);
	var_02 playsound("emt_odin_space_spin_09","spin_03");
	var_02 waittill("spin_03");
	var_06 playsound("emt_odin_space_mtl_creak");
	wait(1);
	var_05 playsound("emt_odin_space_mtl","spin_04");
	var_05 waittill("spin_04");
	var_05 playsound("emt_odin_space_mtl_creak");
	wait(1);
	var_06 playsound("emt_odin_space_mtl","spin_05");
	var_06 waittill("spin_05");
	var_05 playsound("emt_odin_space_mtl_creak");
	wait(1);
	var_06 playsound("emt_odin_space_mtl");
}

//Function Number: 55
func_735C()
{
	level.player playsound("scn_odin_sat_plr_approach_foley");
}

//Function Number: 56
sfx_sat_approach_kyra()
{
	level.ally playsound("scn_odin_sat_kyra_approach_foley");
}

//Function Number: 57
func_7346()
{
	level.player playsound("scn_odin_sat_plr_use");
	level.ally playsound("scn_odin_sat_kyra_use_foley");
}

//Function Number: 58
func_7347(param_00)
{
	common_scripts\utility::func_5D1F("scn_odin_sat_spark",param_00);
}

//Function Number: 59
sfx_set_ending_flag()
{
	if(!common_scripts\utility::flag("sfx_odin_ending"))
	{
		common_scripts\utility::flag_set("sfx_odin_ending");
	}
}

//Function Number: 60
func_7345(param_00,param_01,param_02)
{
	wait(param_02);
	switch(param_01)
	{
		case 1:
			param_00 playsound("scn_odin_rcs_burst");
			break;

		case 2:
			param_00 playsound("scn_odin_rcs_burst");
			wait(0.1);
			param_00 playsound("scn_odin_rcs_fireball");
			break;

		case 3:
			param_00 playsound("scn_odin_rcs_ignite");
			wait(0.4);
			param_00 playloopsound("scn_odin_rcs_fire_lp_01");
			break;

		case 4:
			param_00 playsound("scn_odin_rcs_ignite");
			wait(0.3);
			param_00 playsound("scn_odin_rcs_fireball");
			break;

		case 5:
			param_00 playsound("scn_odin_rcs_fireball");
			break;

		default:
			break;
	}
}

//Function Number: 61
func_7344(param_00)
{
}

//Function Number: 62
func_7360()
{
	level.player playsound("scn_odin_sat_expl_01_lr");
	var_00 = getent("fx_sat_rcs_damage_1","script_noteworthy");
	var_00 stoploopsound("scn_odin_rcs_fire_lp_01");
	level.player playsound("scn_odin_sat_plr_expl_foley_01");
	thread sfx_sat_big_fire_lp(var_00);
}

//Function Number: 63
sfx_sat_big_fire_lp(param_00)
{
	wait(1.5);
	param_00 playsound("scn_odin_rcs_fireball_dist");
	wait(0.3);
	param_00 playloopsound("scn_odin_rcs_fire_lp_02");
	while(!common_scripts\utility::flag("sat_second_expl"))
	{
		wait(randomfloatrange(1.5,2.7));
		param_00 playsound("scn_odin_rcs_fireball_dist");
	}
}

//Function Number: 64
func_7361()
{
	common_scripts\utility::flag_set("sat_second_expl");
	level.player playsound("scn_odin_sat_expl_02_lr");
	var_00 = getent("fx_sat_rcs_damage_1","script_noteworthy");
	var_00 stoploopsound("scn_odin_rcs_fire_lp_02");
	level.player playsound("scn_odin_sat_plr_expl_foley_02");
	wait(3);
	thread func_735F();
}

//Function Number: 65
func_735F()
{
	level.player playsound("scn_odin_sat_falling_lr");
	thread func_735E();
	wait(2);
	wait(6.85);
	level.player playsound("scn_odin_sat_panel_lsrs");
}

//Function Number: 66
func_735E()
{
	wait(13.3);
	level.player playsound("scn_odin_sat_disintegration_lr");
}

//Function Number: 67
func_738E()
{
	level.player method_83BF("odin_end",1);
}

//Function Number: 68
func_7263(param_00)
{
	param_00 playsound("scn_odin_first_door_close");
}

//Function Number: 69
func_7364(param_00)
{
	if(common_scripts\utility::flag("decomp_done"))
	{
		var_01 = param_00 getorigin();
		common_scripts\utility::func_337C("stop_sat_thrust_loop");
		var_02 = spawn("script_origin",var_01);
		var_02 playloopsound("scn_odin_sat_thruster_lp",var_02);
		common_scripts\utility::flag_wait("stop_sat_thrust_loop");
		common_scripts\utility::func_5D1F("scn_odin_sat_thruster_flareout",var_01);
		wait(0.4);
		var_02 stoploopsound();
		wait(0.2);
		var_02 delete();
	}
}

//Function Number: 70
sfx_satellite_lat_thruster_loop(param_00)
{
	if(common_scripts\utility::flag("decomp_done"))
	{
		var_01 = param_00 getorigin();
		common_scripts\utility::func_337C("stop_sat_lat_thrust_loop");
		var_02 = spawn("script_origin",var_01);
		var_02 playloopsound("scn_odin_sat_thruster_lp",var_02);
		common_scripts\utility::flag_wait("stop_sat_lat_thrust_loop");
		common_scripts\utility::func_5D1F("scn_odin_sat_thruster_flareout",var_01);
		wait(0.4);
		var_02 stoploopsound();
		wait(0.2);
		var_02 delete();
	}
}

//Function Number: 71
func_7363(param_00)
{
	if(common_scripts\utility::flag("decomp_done"))
	{
		var_01 = param_00 getorigin();
		common_scripts\utility::func_5D1F("scn_odin_sat_thruster_fire",var_01);
	}
}

//Function Number: 72
func_7322()
{
	var_00 = spawn("script_origin",(2915,47423,48552));
	var_00 playsound("scn_odin_enemy_entrance_door");
	thread func_728D();
}

//Function Number: 73
func_728D()
{
	level.player method_83BF("odin_pressurized_turn_down_enemies",0.5);
	wait(0.6);
	level.var_2F15 stoploopsound();
	level.enemyguys2 stoploopsound();
	wait(0.1);
	level.player method_83BF("odin_pressurized",1);
}

//Function Number: 74
func_734F()
{
	if(level.no_impact == 0)
	{
		thread common_scripts\utility::func_5D1F("scn_odin_ROG_impact_temp",(-10592,29280,-12464));
	}
}

//Function Number: 75
func_7368()
{
	wait(5.1);
	level.player method_83BF("odin_scuttle_event",3);
	level.player playsound("scn_odin_scuttle_ramp");
	wait(1.5);
	level.no_impact = 1;
	level.var_205E = spawn("script_origin",self.origin);
	level.var_205E playsound("scn_odin_scuttle_creak_lr");
	common_scripts\utility::flag_wait("odin_start_spin_decomp_real");
	common_scripts\utility::flag_wait("stop_music_pod_explo");
}

//Function Number: 76
func_7379()
{
	var_00 = spawn("script_origin",(-2404,46646,-15904));
	wait(5.3);
	wait(2.16);
	wait(4.51);
	var_00 playsound("scn_odin_spin_debris_03");
	var_00 moveto((-2610,46210,-15895),3.5);
	wait(10);
	var_00 delete();
}

//Function Number: 77
func_726E()
{
	while(!common_scripts\utility::flag("stop_music_pod_explo"))
	{
		thread func_736E();
		wait(randomfloatrange(0.8,2.4));
	}
}

//Function Number: 78
func_7332()
{
}

//Function Number: 79
sfx_escape_destruction_fire_puffs()
{
	var_00 = spawn("script_origin",(1274.91,46312.08,-15672.1));
	var_00 playloopsound("emt_fire_puff_lp");
	var_01 = spawn("script_origin",(2633.08,46486.98,-15671.2));
	var_01 playloopsound("emt_fire_puff_lp");
	var_02 = spawn("script_origin",(1866.58,46464.8,-15642.9));
	var_02 playloopsound("emt_fire_puff_lp");
	var_03 = spawn("script_origin",(2390.09,46473.18,-15826.6));
	var_03 playloopsound("emt_fire_puff_lp");
	var_04 = spawn("script_origin",(2607.26,46333.87,-15746.2));
	var_04 playloopsound("emt_fire_puff_lp");
	var_05 = spawn("script_origin",(1808.79,46317.07,-15820.9));
	var_05 playloopsound("emt_fire_puff_lp");
	var_06 = spawn("script_origin",(1369.75,46487.46,-15816.4));
	var_06 playloopsound("emt_fire_puff_lp");
	if(maps\_utility::func_47F6())
	{
		thread sfx_gen4_fire_puff();
	}

	common_scripts\utility::flag_wait("stop_music_pod_explo");
	var_00 stoploopsound();
	var_01 stoploopsound();
	var_02 stoploopsound();
	var_03 stoploopsound();
	var_04 stoploopsound();
	var_05 stoploopsound();
	var_06 stoploopsound();
	wait(1);
	var_00 delete();
	var_01 delete();
	var_02 delete();
	var_03 delete();
	var_04 delete();
	var_05 delete();
	var_06 delete();
}

//Function Number: 80
sfx_gen4_fire_puff()
{
	var_00 = spawn("script_origin",(788.89,46515.89,-15763.8));
	var_00 playloopsound("emt_fire_puff_lp");
	common_scripts\utility::flag_wait("stop_music_pod_explo");
	var_00 stoploopsound();
	var_00 delete();
}

//Function Number: 81
sfx_phantom_door_close()
{
	wait(1);
	var_00 = spawn("script_origin",(2605,46351,-15747));
	var_00 playsound("scn_odin_auto_door_close");
	wait(2);
	var_00 delete();
}