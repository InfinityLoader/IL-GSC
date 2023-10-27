/*******************************************************************
 * Decompiled By: Bog
 * Decompiled File: scripts\sp\maps\europa\europa_intro.gsc
 * Game: Call of Duty: Infinite Warfare
 * Platform: PC
 * Function Count: 145
 * Decompile Time: 5986 ms
 * Timestamp: 10/27/2023 12:22:56 AM
*******************************************************************/

//Function Number: 1
func_9AB6()
{
	scripts\common\utility::flag_init("halo_jump_start");
	scripts\common\utility::flag_init("halo_level_out");
	scripts\common\utility::flag_init("halo_tip_down");
	scripts\common\utility::flag_init("player_boosted");
	scripts\common\utility::flag_init("player_boost_failed");
	scripts\common\utility::flag_init("boost_required_start");
	scripts\common\utility::flag_init("boost_required_end");
	scripts\common\utility::flag_init("clouds_idle_start");
	scripts\common\utility::flag_init("clouds_idle_end");
	scripts\common\utility::flag_init("player_stabbed");
	scripts\common\utility::flag_init("scar_saved_player");
	scripts\common\utility::flag_init("cliffjump_complete");
	scripts\common\utility::flag_init("teleport_scar1");
	scripts\common\utility::flag_init("scars_spawned");
	scripts\common\utility::flag_init("did_scope_hint");
	scripts\common\utility::flag_init("cliffjump_boost_start");
	scripts\common\utility::flag_init("cliffjump_boost_end");
	scripts\common\utility::flag_init("safe_to_swap_models");
	scripts\common\utility::flag_init("lookdown_started");
	scripts\common\utility::flag_init("begin_dropship_bink");
	scripts\common\utility::flag_init("dropship_bink_finished");
	scripts\common\utility::flag_init("dropship_intro_vo_finished");
	level.player scripts\sp\_utility::func_65E0("frost_overlay_active");
	level.player scripts\sp\_utility::func_65E0("switched_weapon_during_tutorial");
	precachestring(&"EUROPA_JUMPIN");
}

//Function Number: 2
func_9ABC()
{
	level.player notifyonplayercommand("melee_pressed","+melee");
	level.player notifyonplayercommand("melee_pressed","+melee_zoom");
	level.player notifyonplayercommand("melee_pressed","+melee_breath");
	precachestring(&"EUROPA_BOOST_DEATH_HINT");
	precachestring(&"EUROPA_FREEZE_DEATH");
	precachestring(&"EUROPA_HALOJUMP_FAIL");
	precachemodel("weapon_bullet_iw5");
	precachemodel("tactical_knife_iw7_wm");
	precacheshader("vfx_ui_player_freeze_overlay");
	precacheshader("vfx_ui_player_freeze_overlay_02");
	precacheshader("arrow_left_white");
	precacheshader("arrow_right_white");
	scripts\sp\_utility::func_16EB("seeker_tutorial_hint",&"EUROPA_SEEKER_HINT",::scripts\sp\maps\europa\europa_labs::func_F164);
	scripts\sp\_utility::func_16EB("halojump_hint",&"EUROPA_HALOJUMP_HINT",::func_8893);
	scripts\sp\_utility::func_16EB("freefall_boost",&"EUROPA_FREEFALL_BOOST",::func_2CB4);
	scripts\sp\_utility::func_16EB("scope_y",&"EUROPA_HINT_SCOPE_Y",::func_9CF7);
	scripts\sp\_utility::func_16EB("scope_dpad",&"EUROPA_HINT_SCOPE_DPAD",::func_9CF7);
	scripts\sp\_utility::func_16EB("scope_both",&"EUROPA_HINT_SCOPE_BOTH",::func_9CF7);
	scripts\sp\_utility::func_16EB("scope_kb",&"EUROPA_HINT_SCOPE_KB",::func_9CF7);
	scripts\sp\_utility::func_16EB("scope_test",&"EUROPA_SCOPE_CONFIRM",::func_9B50);
	scripts\sp\_utility::func_16EB("fly_controller",&"EUROPA_FLY_CONTROLLER",::func_9EAC);
	scripts\sp\_utility::func_16EB("fly_kb",&"EUROPA_FLY_KB",::func_9EAC);
	scripts\sp\_utility::func_16EB("melee_hint",&"EUROPA_MELEE",::func_D42B);
	level.player scripts\sp\_utility::func_65E0("isFlying");
	level.var_CF99 = 0;
	level.var_D36A = 0;
	level.var_1C2A = 0;
}

//Function Number: 3
func_5858()
{
	if(level.player scripts\common\utility::func_9C70())
	{
		scripts\sp\_utility::func_56BA("fly_controller");
		return;
	}

	thread scripts\sp\_utility::func_56BA("fly_kb");
	wait(0.05);
	thread func_9EEC();
}

//Function Number: 4
func_9EAC()
{
	if(level.player scripts\common\utility::func_9C70())
	{
		return level.player getnormalizedmovement() != (0,0,0) || level.player method_814B() != (0,0,0);
	}

	return level.player scripts\sp\_utility::func_65DB("isFlying");
}

//Function Number: 5
func_9EEC()
{
	level.player endon("global_hint_in_use");
	level.player notifyonplayercommand("moving","+forward");
	level.player notifyonplayercommand("moving","+back");
	level.player notifyonplayercommand("moving","+moveleft");
	level.player notifyonplayercommand("moving","+moveright");
	level.player waittill("moving");
	level.player scripts\sp\_utility::func_65E1("isFlying");
}

//Function Number: 6
func_9CF7()
{
	if(level.player scripts\sp\_utility::func_65DB("switched_weapon_during_tutorial"))
	{
		return 1;
	}

	if(issubstr(level.player getcurrentweapon(),"hybrid_snow"))
	{
		return !level.player method_8519(level.player getcurrentprimaryweapon());
	}

	return level.player method_8519(level.player getcurrentprimaryweapon());
}

//Function Number: 7
func_9B50()
{
	return level.player adsbuttonpressed();
}

//Function Number: 8
func_D42B()
{
	return scripts\common\utility::flag("player_stabbed") || scripts\common\utility::flag("scar_saved_player");
}

//Function Number: 9
func_1873()
{
	foreach(var_01 in level.var_49C9)
	{
		if(isdefined(var_01.var_13125["exploder"]) && var_01.var_13125["exploder"] == "clouds")
		{
			var_01.var_13125["origin"] = var_01.var_13125["origin"] + (-193,1501,0);
		}
	}
}

//Function Number: 10
func_5DF1()
{
}

//Function Number: 11
func_5E01()
{
	scripts\sp\maps\europa\europa_util::func_107C5();
	scripts\common\utility::array_thread(level.var_EBCA,::scripts\sp\_utility::func_BE49);
	scripts\common\utility::array_thread(level.var_EBCA,::scripts\sp\_utility::func_DC45,"raise");
	func_5EA4();
	lib_0E4B::func_8E06(1);
	level.var_D267 = scripts\sp\_utility::func_10639("player_rig",level.player.origin,level.player.angles);
	level.var_D267 dontinterpolate();
	level.player scripts\sp\maps\europa\europa_util::func_D85C();
	level.var_5D6C lib_0BBF::func_1101E();
	level.player playerlinktodelta(level.var_D267,"tag_player",1,0,0,0,0,1);
	level.player.var_8632 = spawn("script_origin",level.player.origin);
	level.player.var_8632 linkto(level.var_D267,"tag_player",(0,0,0),(0,0,0));
	level.player method_823F(level.player.var_8632);
	if(scripts\sp\_utility::func_9BB5())
	{
		level.var_EBBC scripts\anim\shared::func_CC2C(level.var_EBBC.var_394,"none");
		level.var_EBBC.var_8719 = scripts\sp\_utility::func_10639("fhr40",level.var_5D6C.origin,level.var_5D6C.angles);
		level.var_EBBC.var_8719 attach("attachment_suppressor_energy_1_wm");
		level.var_5D6C.var_8677 = [level.var_EBBB,level.var_EBBC,level.var_EBBC.var_8719,level.var_D267,level.var_5D6C];
		level.var_EBBC thread func_EBBD();
	}
	else
	{
		level.var_5D6C.var_8677 = [level.var_EBBB,level.var_EBBC,level.var_D267,level.var_5D6C];
	}

	level.var_5D6C.var_EBCA = [level.var_EBBB,level.var_EBBC,level.var_D267];
	thread func_1873();
	thread func_5DFD();
	thread func_5ED8();
	setumbraportalstate("halo_portal",0);
}

//Function Number: 12
func_EBBD()
{
	level waittill("scar2_stow_weapon");
	scripts\anim\shared::func_CC2C(self.var_394,"right");
	self.var_8719 hide();
}

//Function Number: 13
func_5DEF()
{
	level.player method_82C0("europa_dropship_intro_fullscreen_hit",0);
	if(!isdefined(level.var_2B4C))
	{
		level.var_2B4C = scripts\sp\_hud_util::func_48B7("black",1);
		level.var_2B4C.foreground = 0;
	}

	level.player method_81DE(55,0.05);
	func_5E01();
	level.var_5D6C lib_0B06::func_1EC1(level.var_5D6C.var_8677,"europa_dropship_intro","tag_origin");
	thread func_D324();
	thread firstline();
	thread func_A635();
	thread func_5E0F();
	thread func_3F69();
	thread func_59E8();
	thread func_5E75();
	level.var_EBBC.var_C383 = level.var_EBBC.var_8C98;
	level.var_EBBC detach(level.var_EBBC.var_8C98);
	level.var_EBBC attach("head_hero_t_hqss");
	level.var_EBBB.var_C383 = level.var_EBBB.var_8C98;
	level.var_EBBB detach(level.var_EBBB.var_8C98);
	level.var_EBBB attach("head_hero_sipes_cine_hqss");
	level.var_5D6C lib_0B06::func_1F2C(level.var_5D6C.var_8677,"europa_dropship_intro","tag_origin");
}

//Function Number: 14
firstline()
{
	scripts\sp\_utility::func_13705();
	level.player thread scripts\sp\_utility::func_CE2F("europa_plr_understoodwarlordwell");
}

//Function Number: 15
func_9A9F()
{
	scripts\common\utility::flag_set("begin_dropship_bink");
	level.player method_82C0("europa_dropship_intro_fullscreen_hit",0);
	level.var_5D6C scripts\common\utility::func_5127(1.5,::scripts\sp\_utility::func_CE2F,"europa_rpr_warlordactual");
	if(!isdefined(level.var_2B4C))
	{
		level.var_2B4C = scripts\sp\_hud_util::func_48B7("black",1);
		level.var_2B4C.foreground = 0;
	}
}

//Function Number: 16
func_5E25()
{
	func_5E01();
	scripts\common\utility::flag_set("dropship_door_open");
	level.var_5D6C lib_0BBC::func_C5F1("right",0,1,0);
	scripts\common\utility::array_thread(level.var_EBCA,::scripts\sp\_utility::func_DC45,"lower");
	level.var_EBBC.var_C383 = level.var_EBBC.var_8C98;
	level.var_EBBC detach(level.var_EBBC.var_8C98);
	level.var_EBBC attach("head_hero_t_hqss");
	level.var_EBBB.var_C383 = level.var_EBBB.var_8C98;
	level.var_EBBB detach(level.var_EBBB.var_8C98);
	level.var_EBBB attach("head_hero_sipes_cine_hqss");
	func_D324();
	level.player method_81DE(55,0.05);
	function_02A9("atmosphere","helmet",1);
	setomnvar("ui_europa_halo_drop_state",1);
	setomnvar("ui_europa_halo_drop_state",3);
	level.var_E7C2 = scripts\sp\_utility::func_7C23();
	level.var_E7C2 thread scripts\sp\_utility::func_E7C9(1,0.1);
	level.var_E7C2 scripts\common\utility::func_5127(0.1,::scripts\sp\_utility::func_E7C9,0.2,1);
}

//Function Number: 17
func_D324()
{
	level.player method_81DF(1,0.5,0.5,15,15,5,12);
	level.player method_8367(15,15,5,12);
}

//Function Number: 18
func_134E2()
{
	scripts\sp\maps\europa\europa_util::func_134B7("europa_tee_eyeofthestorm");
	scripts\sp\maps\europa\europa_util::func_134B7("europa_sip_stickwiththegroup");
	scripts\sp\maps\europa\europa_util::func_134B7("europa_tee_learntokeepup");
}

//Function Number: 19
func_5E21()
{
	level endon("player_boost_failed");
	if(scripts\sp\_utility::func_93A6())
	{
		thread lib_0B78::specialist_helmet_on_immediate();
		thread lib_0B78::func_F53C(0);
	}

	thread func_A4E1();
	if(!scripts\sp\_utility::func_9BB5())
	{
		while(!isdefined(level.var_5D6C))
		{
			wait(0.05);
		}
	}

	scripts\common\utility::array_thread(level.var_EBCA,::scripts\sp\_utility::func_BE4A);
	thread func_5E06();
	thread func_5E24();
	level.var_5D6C thread lib_0B06::func_1EE7(level.var_5D6C.var_EBCA,"europa_dropship_idle","stop_loop","tag_origin");
	level.var_EBBC detach("head_hero_t_hqss");
	level.var_EBBC attach(level.var_EBBC.var_C383);
	level.var_EBBB detach("head_hero_sipes_cine_hqss");
	level.var_EBBB attach(level.var_EBBB.var_C383);
	if(isdefined(level.var_EBBC.var_8719))
	{
		level.var_EBBC.var_8719 delete();
	}

	scripts\sp\_utility::func_2669("jump");
	scripts\sp\maps\europa\europa_util::func_134B7("europa_tee_gotimewolfcallit");
	func_D86B();
	level.var_5D6C notify("stop_loop");
	thread func_257A();
	scripts\common\utility::flag_set("halo_jump_start");
	scripts\common\utility::exploder("ex_jump_out");
	thread func_25DF();
	level.player.var_8892 = level.var_5D6C scripts\common\utility::spawn_tag_origin();
	level.var_D267 linkto(level.player.var_8892,"tag_origin");
	level.player.var_8892 thread lib_0B06::func_1F35(level.var_D267,"europa_dropship_halo_jump","tag_origin");
	scripts\common\utility::func_5127(4.5,::func_CFDC);
	thread func_1C0C();
	level.var_EBCB = level.var_5D6C scripts\common\utility::spawn_tag_origin();
	level.var_EBBB linkto(level.var_EBCB,"tag_origin");
	level.var_EBBC linkto(level.var_EBCB,"tag_origin");
	level.var_EBCB thread lib_0B06::func_1F2C([level.var_EBBB,level.var_EBBC],"europa_dropship_halo_jump","tag_origin");
	if(level.console || level.player usinggamepad())
	{
		level.player method_81DF(1,0.5,0.5,10,10,10,10);
	}

	level.player method_8392(0,1.6,0.9);
	level.player method_81DE(65,3);
	scripts\common\utility::func_5127(3.5,::func_EBC8,1);
	scripts\common\utility::func_5127(8.2,::func_EBC8,0);
	scripts\common\utility::array_thread(level.var_EBCA,::func_EBC2);
	func_F8D3();
	thread func_8890();
	scripts\common\utility::flag_wait("player_boosted");
	func_D1B3();
}

//Function Number: 20
func_257A()
{
	level.player scripts\common\utility::delaycall(0.5,::playsound,"europa_dropship_halo_plr_01");
	level.player scripts\common\utility::func_5127(0.62,::scripts\sp\_utility::func_1034D,"europa_plr_gogo");
	level.player scripts\common\utility::delaycall(0.62,::playrumbleonentity,"light_2s");
	level.player scripts\common\utility::delaycall(1.633333,::playsound,"europa_dropship_halo_plr_02");
	level.player scripts\common\utility::func_5127(1.7,::scripts\sp\_utility::func_1034D,"europa_plr_go");
	level.player scripts\common\utility::delaycall(1.7,::playrumbleonentity,"light_2s");
}

//Function Number: 21
func_EBC8(param_00)
{
	var_01 = ["J_Ankle_LE","J_Ankle_RI","J_Wrist_LE","J_Wrist_RI"];
	foreach(var_03 in level.var_EBCA)
	{
		foreach(var_05 in var_01)
		{
			if(param_00)
			{
				playfxontag(scripts\common\utility::getfx("wisp_loop"),var_03,var_05);
				continue;
			}

			stopfxontag(scripts\common\utility::getfx("wisp_loop"),var_03,var_05);
		}
	}
}

//Function Number: 22
func_F39B()
{
	level endon("player_boosted");
	var_00 = scripts\sp\_utility::func_864C(level.player.origin);
	while(level.player.origin[2] - var_00[2] > 100)
	{
		var_00 = scripts\sp\_utility::func_864C(level.player.origin);
		wait(0.05);
	}

	scripts\common\utility::flag_set("player_boost_failed");
	func_D067();
}

//Function Number: 23
func_D067()
{
	var_00 = level.var_D267 scripts\common\utility::spawn_tag_origin();
	level.var_D267 linkto(var_00);
	var_00 thread lib_0B06::func_1F35(level.var_D267,"europa_dropship_halo_death_rel","tag_origin");
	var_01 = [level.player,level.var_D267];
	var_02 = scripts\common\utility::getstruct("sipes_lookaround","targetname").origin[2] + 70;
	var_03 = (level.var_D267.origin[0],level.var_D267.origin[1],var_02);
	var_04 = getanimlength(level.var_D267 scripts\sp\_utility::func_7DC1("europa_dropship_halo_death_rel"));
	var_05 = 3;
	level.var_D267 method_82B1(level.var_D267 scripts\sp\_utility::func_7DC1("europa_dropship_halo_death_rel"),var_05);
	level.var_D267 method_82B0(level.var_D267 scripts\sp\_utility::func_7DC1("europa_dropship_halo_death_rel"),0.6);
	var_04 = var_04 * 1 / var_05;
	var_00 moveto(var_03,var_04);
	wait(var_04);
	level.player playrumbleonentity("heavy_2s");
	level.var_E7C2 delete();
	level.player freezecontrols(1);
	setomnvar("ui_death_hint",0);
	setomnvar("ui_hide_weapon_info",1);
	function_01C5("hud_showstance",0);
	function_01C5("actionSlotsHide",1);
	level.player clearhudtutorialmessage();
	thread func_25DE();
	earthquake(1,1,level.player.origin,200);
	level.player thread lib_0B60::func_8DDF();
	level.player thread lib_0B60::func_2BC7();
	lib_0B60::func_F322("EUROPA_BOOST_DEATH_HINT");
	lib_0B60::func_F32D();
	playfx(level._effect["deathfx_bloodpool_generic"],level.player.origin);
	wait(3);
	level.player scripts\sp\_utility::func_B8D1();
}

//Function Number: 24
func_1C0C()
{
	func_13760(0.58);
	level.var_1C2A = 1;
	thread func_EBC8(1);
	foreach(var_01 in level.var_EBCA)
	{
		playfxontag(scripts\common\utility::getfx("thrust_loop"),var_01,"tag_fx_bottom");
		if(var_01.var_1FBB == "scar1")
		{
			var_01 playsound("scn_europa_scar1_boost");
		}
		else
		{
			var_01 playsound("scn_europa_scar2_boost");
		}

		wait(0.3);
	}

	scripts\common\utility::flag_wait("boost_required_end");
	thread func_EBC8(0);
	level.var_1C2A = 0;
}

//Function Number: 25
func_F8D3()
{
	func_13760(0.79);
	scripts\sp\_utility::func_10FEC("clouds");
	scripts\sp\_utility::func_10FEC("cloudsreveal");
	scripts\common\utility::flag_set("clouds_idle_start");
	func_13760(0.87);
	level.player thread scripts\sp\_utility::func_CE2F("europa_tee_boostboost1");
	wait(0.5);
	scripts\common\utility::flag_set("boost_required_start");
	scripts\common\utility::flag_set("clouds_idle_end");
}

//Function Number: 26
func_AB79(param_00,param_01)
{
	level notify("lerping_dive_anim_rate");
	level endon("lerping_dive_anim_rate");
	var_02 = func_7944();
	var_03 = param_00 - var_02;
	var_04 = param_01 / 0.05;
	var_05 = var_03 / var_04;
	var_06 = gettime() + param_01 * 1000;
	while(gettime() < var_06)
	{
		var_02 = var_02 + var_05;
		func_F359(var_02);
		wait(0.05);
	}

	func_F359(param_00);
}

//Function Number: 27
func_13760(param_00)
{
	while(func_7945() < param_00)
	{
		wait(0.05);
	}
}

//Function Number: 28
func_7945()
{
	return level.var_D267 method_8102(level.var_D267 scripts\sp\_utility::func_7DC1("europa_dropship_halo_jump"));
}

//Function Number: 29
func_7944()
{
	return level.var_D267 method_8104(level.var_D267 scripts\sp\_utility::func_7DC1("europa_dropship_halo_jump"));
}

//Function Number: 30
func_F359(param_00)
{
	level.var_D267 method_82B1(level.var_D267 scripts\sp\_utility::func_7DC1("europa_dropship_halo_jump"),param_00);
	level.var_EBBB method_82B1(level.var_EBBB scripts\sp\_utility::func_7DC1("europa_dropship_halo_jump"),param_00);
	level.var_EBBC method_82B1(level.var_EBBC scripts\sp\_utility::func_7DC1("europa_dropship_halo_jump"),param_00);
}

//Function Number: 31
func_CFE1()
{
	level.var_CFE4 func_CFDB(1,1);
	func_13760(0.75);
	level.var_CFE4 func_CFDB(0,2);
	level waittill("player_landed");
	level notify("stop_player_controlled_updates");
}

//Function Number: 32
func_AB9D()
{
	level endon("player_boosted");
	var_00 = 0;
	var_01 = 0.01;
	for(;;)
	{
		var_02 = level.player.var_8892.origin - level.var_EBCB.origin;
		level.var_EBCB.origin = level.var_EBCB.origin + var_02 * var_00;
		var_00 = var_00 + var_01;
		wait(0.05);
	}
}

//Function Number: 33
func_13E6B()
{
	level.var_CFE4.var_BC49 = (0,0,0);
	level.var_CFE4.var_C3CA = (0,0,0);
	level.var_CFE4.var_11532 = (0,0,0);
	level.var_CFE4.var_11535 = 0;
	level.var_CFE4.var_11533 = 0;
	level.var_CFE4.var_13D31 = (0,0,0);
	level.var_CFE4.var_13D34 = (0,0,0);
	level.var_CFE4.var_13D78 = 0;
	level.var_CFE4.var_B7D6 = (0,0,0);
	level.var_CFE4.var_B7D8 = (0,0,0);
	level.var_CFE4.var_B7D9 = 0;
	level.var_CFE4.var_7440 = 0;
}

//Function Number: 34
func_CF62()
{
	func_9500();
}

//Function Number: 35
func_9500()
{
	level.var_D267 method_82A2(%europa_dropship_intro_plr_halo_jump_lr,1,0,0);
	level.var_D267 method_82B0(%europa_dropship_intro_plr_halo_jump_lr,0.5);
}

//Function Number: 36
func_CFDC()
{
	level endon("stop_player_controlled_updates");
	level.player playrumbleonentity("heavy_2s");
	scripts\common\utility::func_5127(1.25,::func_5858);
	scripts\common\utility::func_5127(0.9,::scripts\sp\maps\europa\europa_util::func_134B7,"europa_tee_staytight");
	thread func_CF62();
	level.var_CFE4 = spawnstruct();
	func_13E6B();
	level.var_CFE4.var_B3D1 = 0;
	level.var_CFE4.var_13D33 = 1;
	level.var_CFE4.var_2B8D = 0;
	thread scripts\sp\_utility::func_AB9A("r_mbRadialoverridechromaticAberration",0.015,3);
	thread scripts\sp\_utility::func_AB9A("r_mbradialoverridestrength",0.011,3);
	level.var_CFE4 thread func_CFE1();
	var_00 = level.player.var_8892;
	var_01 = anglestoforward(var_00.angles);
	var_02 = anglestoright(var_00.angles);
	var_03 = anglestoup(var_00.angles);
	var_04 = var_00.origin;
	level.var_CFE4 thread func_B2EC(var_04,var_00);
	level.var_CFE4 thread func_5727();
	thread func_5E23();
	for(;;)
	{
		level.var_CFE4 func_CFDD(var_01,var_02,var_03);
		level.var_CFE4.var_13D34 = level.var_CFE4.var_13D34 + level.var_CFE4.var_13D31 * level.var_CFE4.var_13D78 * level.var_CFE4.var_13D33;
		level.var_CFE4.var_B7D8 = level.var_CFE4.var_B7D8 + level.var_CFE4.var_B7D6 * level.var_CFE4.var_B7D9;
		var_05 = level.var_CFE4.var_BC49 + level.var_CFE4.var_13D34 + level.var_CFE4.var_B7D8;
		var_00.origin = var_04 + var_05 * level.var_CFE4.var_B3D1;
		func_CFE3(level.var_CFE4.var_BBF8[0],level.var_CFE4.var_BBF8[1],level.var_CFE4.var_B3D1);
		if(level.var_CFE4.var_2B8D)
		{
			level.var_CFE4 waittill("quickturn_master_blend_complete");
			continue;
		}

		wait(0.05);
	}
}

//Function Number: 37
func_B2EC(param_00,param_01)
{
	level endon("stop_player_controlled_updates");
	var_02 = 0.09;
	var_03 = 0.45;
	var_04 = var_02;
	var_05 = 0.05;
	var_06 = 9;
	var_07 = 4;
	self.var_13D31 = scripts\common\utility::random([anglestoforward(level.player.var_8892.angles),anglestoforward(level.player.var_8892.angles) * -1]);
	var_08 = 1;
	for(;;)
	{
		wait(0.05);
		if(var_04 + var_05 < var_03)
		{
			var_04 = clamp(var_04 + var_05,var_02,var_03);
		}
		else
		{
			var_04 = var_03;
		}

		if(!var_08)
		{
			self.var_13D31 = func_7D7D();
		}
		else
		{
			var_08 = 0;
		}

		while(!func_9C77())
		{
			self.var_13D78 = clamp(self.var_13D78 + var_04,0,var_06);
			wait(0.05);
		}

		while(func_9C77())
		{
			self.var_13D78 = clamp(self.var_13D78 - var_04,var_07,var_06);
			wait(0.05);
		}
	}
}

//Function Number: 38
func_9C77()
{
	if(level.console || level.player usinggamepad())
	{
		return length(level.player getnormalizedmovement()) >= 0.1 || length(level.player method_814B()) >= 0.1;
	}

	return length(level.player getnormalizedmovement()) >= 0.1;
}

//Function Number: 39
func_7D7D()
{
	var_00 = lib_0B4D::func_7ADE(level.var_EBCA[0].origin,level.var_EBCA[1].origin);
	var_00 = lib_0B4D::func_7ADE(var_00,level.var_EBCA[0].origin);
	if(level.player geteye()[0] > var_00[0])
	{
		return anglestoforward(level.player.var_8892.angles);
	}

	return anglestoforward(level.player.var_8892.angles) * -1;
}

//Function Number: 40
func_CFDD(param_00,param_01,param_02)
{
	level endon("stop_player_controlled_updates");
	var_03 = 0.0625;
	var_04 = 1;
	var_05 = 40;
	var_06 = 18;
	if(level.console || level.player usinggamepad())
	{
		var_07 = [];
		var_07[0] = level.player getnormalizedmovement();
		var_07[1] = level.player method_814B();
		var_07[0] = var_07[0] * self.var_B3D1;
		var_07[1] = var_07[1] * self.var_B3D1;
		var_08 = max(length(var_07[0]),length(var_07[1]));
		var_09 = var_07[0] + var_07[1] * 0.5;
		var_09 = vectornormalize(var_09) * var_08;
	}
	else
	{
		var_09 = level.player getnormalizedmovement();
		var_09 = var_09 * self.var_B3D1;
	}

	self.var_11535 = self.var_11535 + var_09[0] * var_06;
	self.var_11533 = self.var_11533 + var_09[1] * var_06;
	if(self.var_11535 > var_05)
	{
		self.var_11535 = var_05;
	}
	else if(self.var_11535 < var_05 * -1)
	{
		self.var_11535 = var_05 * -1;
	}

	self.var_11535 = self.var_11535 * var_04;
	self.var_11533 = self.var_11533 * var_04;
	self.var_11532 = self.var_11535 * param_01 + self.var_11533 * param_00 * -1;
	self.var_BC49 = lib_0B4D::func_AB6F(self.var_BC49,self.var_11532,var_03);
	self.var_BBF8 = self.var_C3CA - self.var_BC49;
	self.var_C3CA = self.var_BC49;
}

//Function Number: 41
func_CFDB(param_00,param_01)
{
	self notify("new_master_blend");
	self endon("new_master_blend");
	if(param_01 == 0)
	{
		self.var_B3D1 = param_00;
		return;
	}

	self.var_2B8D = 1;
	var_02 = param_00 - self.var_B3D1 / param_01 * 0.05;
	var_03 = self.var_B3D1;
	var_04 = param_01;
	while(var_04 > 0)
	{
		var_03 = var_03 + var_02;
		self.var_B3D1 = clamp(var_03,0,1);
		var_04 = var_04 - 0.05;
		self notify("quickturn_master_blend_complete");
		wait(0.05);
	}

	self.var_B3D1 = param_00;
	self.var_2B8D = 0;
	self notify("quickturn_master_blend_complete");
}

//Function Number: 42
func_CFE3(param_00,param_01,param_02)
{
	level endon("stop_player_controlled_updates");
	param_01 = param_01 * 0.12 * param_02;
	param_00 = param_00 * 0.041 * param_02;
	param_01 = clamp(param_01,-1,1);
	param_00 = clamp(param_00,-1,1);
	param_01 = param_01 * -1;
	param_01 = 0.5 + 0.5 * param_01;
	param_00 = 0.5 + 0.5 * param_00;
	var_03 = 0.7;
	var_04 = 1;
	var_05 = 0.2;
	level.var_D267 childthread func_CFE2(%europa_dropship_intro_plr_halo_jump_fb,param_01,var_03,var_04,var_05,0);
	level.var_D267 childthread func_CFE2(%europa_dropship_intro_plr_halo_jump_lr,param_00,var_03,var_04,var_05,1);
}

//Function Number: 43
func_CFE2(param_00,param_01,param_02,param_03,param_04,param_05)
{
	self notify("stop_current_anim_time_lerp" + param_05);
	self endon("stop_current_anim_time_lerp" + param_05);
	if(!isdefined(param_05))
	{
		param_05 = 1;
	}

	if(param_01 == 1)
	{
		param_01 = 0.999;
	}
	else if(param_01 == 0)
	{
		param_01 = 0.001;
	}

	var_06 = getanimlength(param_00);
	param_02 = param_02 * var_06;
	param_03 = param_03 * var_06;
	if(!isdefined(self.var_1EE3))
	{
		self.var_1EE3 = [];
	}

	if(!isdefined(self.var_1EE3[param_05]))
	{
		self.var_1EE3[param_05] = 0;
	}

	for(var_07 = self method_8102(param_00);abs(var_07 - param_01) > 0;var_07 = self method_8102(param_00))
	{
		var_08 = param_01 - var_07 * var_06 / 0.05;
		var_09 = abs(self.var_1EE3[param_05] - var_08);
		if(var_09 < param_02)
		{
			self.var_1EE3[param_05] = var_08;
		}

		if(self.var_1EE3[param_05] < var_08)
		{
			self.var_1EE3[param_05] = self.var_1EE3[param_05] + param_02;
		}
		else
		{
			self.var_1EE3[param_05] = self.var_1EE3[param_05] - param_02;
		}

		if(abs(self.var_1EE3[param_05]) > param_03)
		{
			self.var_1EE3[param_05] = self.var_1EE3[param_05] * param_03 / abs(self.var_1EE3[param_05]);
		}

		var_0A = 1;
		var_0B = abs(param_01 - var_07);
		if(self.var_1EE3[param_05] > 0 && param_01 > var_07)
		{
			var_0A = lib_0B4D::func_C097(0,param_04,var_0B);
		}
		else if(self.var_1EE3[param_05] < 0 && param_01 < var_07)
		{
			var_0A = lib_0B4D::func_C097(0,param_04,var_0B);
		}

		self.var_1EE3[param_05] = self.var_1EE3[param_05] * var_0A;
		self method_82B1(param_00,self.var_1EE3[param_05]);
		wait(0.05);
	}

	self method_82B0(param_00,param_01);
	self method_82B1(param_00,0);
}

//Function Number: 44
func_5727()
{
	level endon("lightning_death");
	level endon("boost_required_start");
	self.var_2A4C = spawn("script_origin",level.player.origin);
	self.var_2A4C linkto(level.player);
	level.player.var_58DF = 0;
	var_00 = 600;
	var_01 = 0.175;
	var_02 = 0.4;
	var_03 = 0;
	var_04 = 0;
	var_05 = 110;
	var_06 = 0;
	var_07 = undefined;
	var_08 = undefined;
	for(;;)
	{
		var_09 = func_7942();
		var_0A = lib_0B4D::func_7ADE(level.var_EBCA[0].origin,level.var_EBCA[1].origin);
		self.var_7440 = lib_0B4D::func_C097(0,var_00,var_09);
		if(level.player geteye()[0] > var_0A[0])
		{
			var_0B = "right";
		}
		else
		{
			var_0B = "left";
		}

		if(self.var_7440 <= 0.175)
		{
			var_07 = undefined;
			var_04 = 0;
			var_03 = 0;
		}
		else
		{
			var_03++;
		}

		if(self.var_7440 >= var_02 || var_04 > var_05 * 0.5)
		{
			if(var_06)
			{
				var_07 = "scn_europa_halo_altitude_beep_lp_02";
				var_0C = func_E758(scripts\common\utility::func_B8F8(var_03,5));
				if(!var_0C)
				{
					var_06 = 0;
					thread func_B293("red",var_0B,11);
					var_04 = var_04 + 4;
				}
			}
			else
			{
				var_08 = "scn_europa_halo_altitude_beep_lp_03";
				var_0C = func_E758(scripts\common\utility::func_B8F8(var_04,4));
				if(!var_0C)
				{
					thread func_B293("red",var_0B,11);
					var_04 = var_04 + 4;
				}
			}
		}
		else if(self.var_7440 >= var_01)
		{
			var_06 = 1;
			var_04 = var_04 + 1;
			var_0C = func_E758(scripts\common\utility::func_B8F8(var_03,5));
			if(!var_0C)
			{
				thread func_B293("white",var_0B,9);
			}
		}

		if(var_04 > var_05)
		{
			thread func_D1D3();
		}

		if(isdefined(var_07))
		{
			if(!isdefined(var_08) || var_07 != var_08)
			{
				self.var_2A4C playloopsound(var_07);
				level.player.var_58DF = 1;
			}
		}
		else
		{
			self.var_2A4C stoploopsound();
			level.player.var_58DF = 0;
		}

		wait(0.05);
	}
}

//Function Number: 45
func_D1D3()
{
	setomnvar("ui_hide_weapon_info",1);
	var_00 = level.player geteye();
	var_01 = var_00 + anglestoforward(level.player getplayerangles()) * 20;
	var_02 = var_01 - var_00;
	setsunlight(10000,10000,15000);
	function_0178("scn_europa_lightning_death",(0,0,0));
	level.player method_809A(1,1);
	earthquake(2,10,level.player.origin,1000);
	level.player thread lib_0B60::func_8DDF();
	level.player thread lib_0B60::func_2BC7();
	level.player freezecontrols(1);
	level notify("lightning_death");
	level.player method_83A1();
	level.player method_81D0();
	wait(4);
	scripts\sp\_utility::func_B8D1();
	level waittill("forever");
}

//Function Number: 46
func_B293(param_00,param_01,param_02)
{
	level endon("lightning_death");
	if(param_00 == "white")
	{
		param_00 = (1,1,1);
	}
	else if(param_00 == "orange")
	{
		param_00 = (1,0.5,0);
	}
	else
	{
		param_00 = (1,0,0);
	}

	if(param_01 == "left")
	{
		param_02 = param_02 * -1;
		var_03 = "arrow_left_white";
		var_04 = 640;
	}
	else
	{
		var_03 = "arrow_right_white";
		var_04 = 0;
	}

	var_05 = newclienthudelem(level.player);
	var_06 = 60;
	var_07 = 140;
	var_05 setshader(var_03,50,var_07);
	var_05.color = param_00;
	var_05.x = var_04;
	var_05.y = 240 - var_07 / 2;
	var_05.alpha = 0.75;
	var_08 = 0.6;
	var_09 = gettime() + var_08 * 1000;
	var_05 thread scripts\sp\_hud_util::func_6AAB(0,var_08);
	var_0A = var_06 - var_07;
	var_0B = var_07;
	var_0C = var_0A / var_08 / 0.05;
	while(gettime() < var_09)
	{
		var_0D = var_0B;
		var_0E = var_05.y;
		var_0B = int(var_0B + var_0C);
		var_0F = var_0D - var_0B;
		var_05.alpha = var_05.alpha - 0.01;
		var_05.x = var_05.x + param_02;
		var_05.y = var_05.y + var_0F / 2;
		var_05 setshader(var_03,50,var_0B);
		wait(0.05);
	}

	var_05 destroy();
}

//Function Number: 47
func_7942()
{
	var_00 = abs(level.var_EBCA[0].origin[0] - level.player geteye()[0]);
	var_01 = abs(level.var_EBCA[1].origin[0] - level.player geteye()[0]);
	return min(var_00,var_01);
}

//Function Number: 48
func_F561(param_00)
{
	if(scripts\common\utility::func_13D90(level.player geteye(),level.player getplayerangles(),param_00,cos(113)))
	{
		function_01A7(0,0.15);
		func_F562(clamp(level.var_CFE4.var_7440,0.1,1),param_00);
		return;
	}

	function_01A7(5,0.15);
}

//Function Number: 49
func_E757(param_00)
{
	return float(int(param_00 * 100 + 0.5)) / 100;
}

//Function Number: 50
func_E758(param_00)
{
	return float(int(param_00 * 10 + 0.5)) / 10;
}

//Function Number: 51
func_5E22()
{
	if(getdvarint("debug_europa"))
	{
		iprintln("opening umbra portal \'halo_portal\' ");
	}

	setumbraportalstate("halo_portal",1);
	if(scripts\sp\_utility::func_93A6())
	{
		thread lib_0B78::specialist_helmet_on_immediate();
		thread lib_0B78::func_F53C(0);
		return;
	}

	lib_0E4B::func_8E06();
}

//Function Number: 52
func_25DE()
{
	function_0178("scn_jump_from_plane_booster_death_lr",level.player.origin);
}

//Function Number: 53
func_25DF()
{
	level.var_1178C = spawn("script_origin",level.player.origin);
	level.var_1178C linkto(level.player);
	level.var_1178D = spawn("script_origin",level.player.origin);
	level.var_1178D linkto(level.player);
	level.var_1178C playsound("scn_jump_from_plane_01_lr");
	wait(3.4);
	level.player method_82C0("europa_halo_jump",0.5);
	function_01BA("");
	thread func_8891();
	func_13760(0.58);
	level.var_1178C playsound("scn_jump_from_plane_02_lr");
	level.player playrumbleonentity("heavy_3s");
	level.player playsound("scn_jump_from_plane_booster_save_lr");
}

//Function Number: 54
func_8891()
{
	level endon("player_landed");
	level.var_6E87 = spawn("script_origin",level.player.origin);
	level.var_6E87 linkto(level.player);
	wait(1);
	level.var_6E87 method_8278(0);
	var_00 = 0;
	var_01 = 0;
	for(;;)
	{
		var_02 = level.player getnormalizedmovement();
		var_03 = var_02[1];
		if(var_03 < 0)
		{
			var_03 = var_03 * -1;
		}

		if(var_03 > 0.15)
		{
			if(var_00 == 0)
			{
				level.var_6E87 playloopsound("scn_europa_halo_flapping_lp");
				var_00 = 1;
				wait(0.05);
			}

			var_03 = lib_0B4D::func_AB6F(var_01,var_03,0.1);
			level.var_6E87 method_8278(var_03,0.1);
			var_01 = var_03;
			wait(0.1);
			continue;
		}

		level.var_6E87 method_8278(0,0.5);
		wait(0.5);
		level.var_6E87 stoploopsound("scn_europa_halo_flapping_lp");
		var_00 = 0;
		var_01 = 0;
		wait(0.05);
	}
}

//Function Number: 55
func_25F8()
{
	function_0178("scn_jump_from_plane_booster_save_lr",level.player.origin);
	level.player method_8070(2);
	thread func_2CC9();
	level.var_1178C method_8278(0,1);
	wait(1.1);
	level.var_1178C method_83AD();
}

//Function Number: 56
func_2CC9()
{
	wait(5);
	function_01BA("mx_168_surveylandscape");
}

//Function Number: 57
func_D1B3()
{
	thread func_8E4A();
	level.player thread scripts\sp\maps\europa\europa_util::func_8E34(1);
	level.player thread scripts\sp\maps\europa\europa_util::func_13013(1);
	level.player method_809A(0,2);
	thread func_DFCD();
	thread func_7451();
	level waittill("player_landed");
	level.player playrumbleonentity("damage_heavy");
	level.var_E7C2 delete();
	lib_0E4B::func_8DEA();
	setomnvar("ui_hud_heist_boost",0);
	level notify("kill_boost_button");
	level.var_5D6C delete();
	scripts\sp\_utility::func_10FEC("ex_jump_out");
	if(isdefined(level.var_6E87))
	{
		level.var_6E87 method_83AD();
		wait(0.05);
		if(isdefined(level.var_6E87))
		{
			level.var_6E87 delete();
		}
	}

	level.player.var_8632 rotateto((0,0,0),0.5);
	level waittill("land_animation_over");
	level.player method_823F(undefined);
	level.player.var_8632 delete();
	thread scripts\sp\maps\europa\europa_util::func_DF3E();
	if(isdefined(level.var_D267))
	{
		level.var_D267 delete();
	}

	level.player.var_8892 delete();
	if(isdefined(level.var_1178C))
	{
		level.var_1178C delete();
	}

	if(isdefined(level.var_1178D))
	{
		level.var_1178D delete();
	}
}

//Function Number: 58
func_F562(param_00,param_01)
{
	if(isdefined(param_00))
	{
		var_02 = param_00;
	}
	else
	{
		var_02 = 1;
	}

	var_03 = 0.85 * var_02;
	var_04 = 0.22 * var_02;
	function_01C5("r_mbRadialoverrideposition",param_01);
	function_01C5("r_mbRadialoverridechromaticAberration",var_03);
	function_01C5("r_mbradialoverridestrength",var_04);
}

//Function Number: 59
func_DC5D(param_00)
{
	level endon("removing_blur_effects");
	var_01 = getdvarfloat("r_mbRadialoverridechromaticAberration");
	var_02 = getdvarfloat("r_mbradialoverridestrength");
	if(isdefined(param_00))
	{
		var_03 = param_00;
	}
	else
	{
		var_03 = 1;
	}

	var_01 = 0;
	var_02 = 0;
	var_04 = 0.075;
	var_05 = 0.01;
	var_06 = 0.85;
	var_07 = 0.95;
	while(getdvarfloat("r_mbRadialoverridechromaticAberration") < var_06 && getdvarfloat("r_mbradialoverridestrength") < var_07)
	{
		var_01 = clamp(var_01 + var_04,0,var_06);
		var_02 = clamp(var_02 + var_05,0,var_07);
		function_01C5("r_mbRadialoverridechromaticAberration",var_01);
		function_01C5("r_mbradialoverridestrength",var_02);
		wait(0.05);
	}
}

//Function Number: 60
func_DFCD()
{
	level notify("removing_blur_effects");
	var_00 = getdvarfloat("r_mbRadialoverridechromaticAberration");
	var_01 = getdvarfloat("r_mbradialoverridestrength");
	while(getdvarfloat("r_mbRadialoverridechromaticAberration") > 0 && getdvarfloat("r_mbradialoverridestrength") > 0)
	{
		var_00 = max(var_00 - 0.002,0);
		var_01 = max(var_01 - 0.001,0);
		function_01C5("r_mbRadialoverridechromaticAberration",var_00);
		function_01C5("r_mbradialoverridestrength",var_01);
		wait(0.05);
	}
}

//Function Number: 61
func_5DFD()
{
	if(getdvarint("debug_europa"))
	{
		iprintln("hiding intro_surface_vista_01");
	}

	var_00 = getent("intro_surface_vista_01","targetname");
	var_00 hide();
	if(getdvarint("debug_europa"))
	{
		iprintln("hiding base_reveal_vista");
	}

	scripts\sp\maps\europa\europa_util::func_119B1(0);
	scripts\common\utility::flag_wait("clouds_idle_start");
	if(getdvarint("debug_europa"))
	{
		iprintln("opening umbra portal named \'halo_portal\' ");
	}

	setumbraportalstate("halo_portal",1);
	wait(6);
	if(getdvarint("debug_europa"))
	{
		iprintln("show intro_surface_vista_01");
	}

	var_00 show();
}

//Function Number: 62
func_5ED8()
{
	scripts\common\utility::exploder("cloudreveal");
	scripts\common\utility::exploder("clouds_static");
	scripts\common\utility::flag_wait("dropship_door_open");
	scripts\common\utility::exploder("clouds");
	thread func_75F7();
}

//Function Number: 63
func_75F7()
{
	wait(0.8);
	scripts\sp\_utility::func_10FEC("clouds_static");
}

//Function Number: 64
func_8890()
{
	level endon("player_boost_failed");
	level endon("player_landed");
	thread scripts\sp\_utility::func_56BA("freefall_boost");
	thread func_F39B();
	var_00 = 1;
	var_01 = 0.01;
	var_02 = 1;
	childthread func_2CAC();
	for(;;)
	{
		if(level.player method_81CE())
		{
			if(isdefined(level.var_CFE4.var_2A4C))
			{
				level.var_CFE4.var_2A4C scripts\sp\_utility::func_10460(0.05,1);
			}

			if(var_00 - var_01 > 0)
			{
				var_00 = var_00 - var_01;
				if(var_02)
				{
					setomnvar("ui_hud_heist_boost",1);
					thread func_D1B4();
					thread func_25F8();
					var_02 = 0;
				}
			}

			if(var_00 <= 0.75)
			{
				scripts\common\utility::flag_set("player_boosted");
				scripts\common\utility::flag_set("boost_required_end");
			}
		}

		setomnvar("ui_hud_heist_boost_amount",var_00);
		wait(0.05);
	}
}

//Function Number: 65
func_2CAC()
{
	for(;;)
	{
		if(level.player method_81CE())
		{
			earthquake(0.43,0.3,level.player.origin,200);
			level.player playrumbleonentity("heavy_3s");
			level.player playrumbleonentity("damage_heavy");
			level.player method_8291(0.5,0.5,0.5,0.3,0,-1,0,30,30,30);
			wait(0.1);
		}

		wait(0.05);
	}
}

//Function Number: 66
func_D1B4()
{
	level endon("player_boost_failed");
	scripts\common\utility::array_thread([level.var_EBBB,level.var_EBBC],::func_A837);
	thread func_D1B9();
	scripts\common\utility::exploder("landing");
	scripts\common\utility::exploder("ex_landing_impact");
	var_00 = level.var_D267 scripts\common\utility::spawn_tag_origin();
	level.var_D267 linkto(var_00);
	var_00 thread lib_0B06::func_1F35(level.var_D267,"europa_dropship_halo_land_rel","tag_origin");
	var_01 = 0.462069;
	var_02 = getanimlength(level.var_D267 scripts\sp\_utility::func_7DC1("europa_dropship_halo_land_rel"));
	var_03 = scripts\sp\_utility::func_864C(level.var_D267.origin);
	var_04 = level.var_D267.origin[2] - var_03[2];
	var_05 = lib_0B4D::func_C097(600,3500,var_04);
	var_05 = clamp(1 - var_05,0.5,1);
	func_F537(var_05);
	var_06 = var_02 * 1 - var_01;
	var_02 = var_02 * 1 / var_05;
	var_07 = var_02 * var_01;
	var_00 moveto(var_03,var_07);
	wait(var_02 * var_01);
	func_F537(1);
	level.player playsound("scn_jump_from_plane_booster_land_lr");
	earthquake(1,1,level.player.origin,200);
	level notify("player_landed");
	wait(var_06);
	level.player method_8391(2);
	level.player unlink(1);
	level.var_EBBB unlink();
	level.var_EBBC unlink();
	level notify("land_animation_over");
}

//Function Number: 67
func_D1B9()
{
	var_00 = scripts\sp\_utility::func_864C(level.player.origin);
	while(level.player.origin[2] - var_00[2] > 500)
	{
		wait(0.05);
	}

	playfx(scripts\common\utility::getfx("landing_kickup_dist"),var_00);
	while(level.player.origin[2] - var_00[2] > 325)
	{
		wait(0.05);
	}

	playfx(scripts\common\utility::getfx("landing_kickup"),var_00);
	level waittill("player_landed");
	playfx(level._effect["player_landing"],var_00,anglestoright(level.player.var_8892.angles));
}

//Function Number: 68
func_7BA1()
{
	return level.var_D267 method_8102(level.var_D267 scripts\sp\_utility::func_7DC1("europa_dropship_halo_land"));
}

//Function Number: 69
func_F537(param_00)
{
	level.var_D267 method_82B1(level.var_D267 scripts\sp\_utility::func_7DC1("europa_dropship_halo_land_rel"),param_00);
}

//Function Number: 70
func_A635()
{
	level.var_2B4C fadeovertime(0.25);
	level.var_2B4C.alpha = 0;
	level.player method_82C0("europa_dropship_intro_fullscreen_hit",0.05);
	level.player scripts\common\utility::delaycall(2,::method_8070,5);
	level.player setclientomnvar("ui_hide_hud",0);
	wait(0.25);
	level.var_2B4C destroy();
}

//Function Number: 71
func_59E8()
{
	scripts\common\utility::flag_wait("dropship_door_open");
	scripts\common\utility::func_5127(3,::func_5E1B);
	if(getdvarint("debug_europa"))
	{
		iprintln("dropship_door_open FX");
	}

	wait(0.7);
	level.player playrumbleonentity("heavy_3s");
	level.var_E7C2 = scripts\sp\_utility::func_7C23();
	level.var_E7C2 thread scripts\sp\_utility::func_E7C9(1,0.1);
	level.var_E7C2 scripts\common\utility::func_5127(0.1,::scripts\sp\_utility::func_E7C9,0.2,1);
	playfxontag(scripts\common\utility::getfx("dropship_door_open"),level.var_5D6C,"tag_origin");
	thread func_59B9();
	var_00 = scripts\common\utility::getstruct("dropship_door_sound","targetname");
	var_01 = scripts\common\utility::spawn_tag_origin(var_00.origin,var_00.angles);
	var_01 playsound("scn_europa_dropship_door_open");
	var_02 = scripts\common\utility::getstruct("dropship_door_100units","targetname");
	var_03 = scripts\common\utility::spawn_tag_origin(var_02.origin,var_02.angles);
	var_03 playloopsound("scn_europa_dropship_door_wind_lp");
	if(getdvarint("debug_europa"))
	{
		iprintln("ex_door_open exploder");
	}

	scripts\common\utility::exploder("ex_door_open");
	thread func_5E45();
	scripts\common\utility::flag_wait("boost_required_start");
	stopfxontag(scripts\common\utility::getfx("dropship_door_open"),level.var_5D6C,"tag_origin");
	var_01 delete();
	var_03 delete();
}

//Function Number: 72
func_5E1B()
{
	level.var_5D6C attach("veh_mil_air_un_dropship_hero_interior_snow","tag_connect");
}

//Function Number: 73
func_5E45()
{
}

//Function Number: 74
func_8893()
{
	if(scripts\common\utility::flag("halo_jump_start"))
	{
		return 1;
	}

	return 0;
}

//Function Number: 75
func_6A22()
{
}

//Function Number: 76
func_59B9()
{
	level notify("change_camera_shake");
	level endon("change_camera_shake");
	level endon("halo_jump_start");
	scripts\common\utility::exploder("door_open_visor_frost");
	for(;;)
	{
		var_00 = randomfloatrange(1.6,2.2);
		var_01 = randomfloatrange(0.5,1);
		var_02 = randomfloatrange(0.25,1);
		var_03 = 0.25;
		var_04 = var_03 * 0.5;
		var_05 = var_03 * 0.5;
		var_06 = 0;
		var_07 = 0;
		var_08 = 0;
		var_09 = 0;
		var_0A = 1;
		level.player method_8291(var_00,var_01,var_02,var_03,var_04,var_05,var_06,var_07,var_08,var_09);
		wait(var_03);
	}
}

//Function Number: 77
func_5E23()
{
	level notify("change_camera_shake");
	level endon("change_camera_shake");
	level endon("boost_required_end");
	level.var_E7C2 endon("death");
	var_00 = spawn("script_origin",level.player.origin + (0,0,0));
	var_00 linkto(level.player);
	stopallrumbles();
	for(;;)
	{
		if(level.var_D36A)
		{
			wait(0.05);
			continue;
		}

		var_01 = level.var_CFE4.var_7440;
		var_02 = 0.5;
		var_03 = 0.2;
		var_04 = clamp(var_02 * 1 - var_01,0.3,var_02);
		var_05 = clamp(var_03 * var_01,0.1,var_04);
		var_06 = 15 + var_01 * 30;
		var_06 = clamp(var_06,15,40);
		var_07 = var_01;
		if(var_01 > 0.4)
		{
			level.player method_8291(var_07 + 0.35 * var_07 + 0.35 * 1.5,var_07,var_07 + 0.35 * var_07 + 0.35 * 2,var_04,0,-1,0,var_06,var_06,var_06);
		}
		else if(var_01 > 0.12)
		{
			level.player method_8291(var_07 * 1.5,var_07 * 1.2,var_07 * 2,var_04,0,-1,0,var_06,var_06,var_06);
		}
		else
		{
			var_07 = 0.05;
			level.player method_8291(var_07 * 1.5,var_07,var_07 * 2,var_04,0,-1,0,var_06,var_06,var_06);
		}

		var_00 dontinterpolate();
		var_00 unlink();
		var_08 = 700 * clamp(1 - var_01,0,1);
		var_00.origin = level.player.origin + (0,0,var_08);
		var_00 linkto(level.player);
		var_00 playrumbleonentity("heavy_1s");
		wait(var_05);
	}
}

//Function Number: 78
func_FC50(param_00,param_01)
{
	level notify("new_shake_loop");
	level endon("new_shake_loop");
	var_02 = undefined;
	var_03 = undefined;
	var_04 = undefined;
	var_05 = 0.7;
	switch(param_00)
	{
		case "light":
			var_02 = 0.09;
			var_03 = 0.18;
			var_04 = "damage_light";
			break;

		case "heavy":
			var_02 = 0.13;
			var_03 = 0.16;
			var_04 = "heavy_3s";
			break;
	}
}

//Function Number: 79
func_A837()
{
	wait(1);
	var_00 = scripts\sp\_utility::func_864C(self.origin);
	if(self == level.var_EBBB)
	{
		self playsound("scn_europa_scar1_land");
	}

	if(self == level.var_EBBC)
	{
		self playsound("scn_europa_scar2_land");
	}

	playfx(scripts\common\utility::getfx("landing_kickup"),var_00);
	wait(1.3);
	stopfxontag(scripts\common\utility::getfx("thrust_loop"),self,"tag_fx_bottom");
	scripts\common\utility::flag_set("safe_to_swap_models");
}

//Function Number: 80
func_9280()
{
	var_00 = scripts\sp\_utility::func_864C(self.origin);
	playfx(scripts\common\utility::getfx("icecave_landing_kickup"),var_00);
	if(self == level.player)
	{
		return;
	}

	wait(0.15);
	stopfxontag(scripts\common\utility::getfx("thrust_loop"),self,"tag_fx_bottom");
	scripts\common\utility::flag_set("safe_to_swap_models");
}

//Function Number: 81
func_5E0F()
{
	scripts\common\utility::flag_wait("nt_flag_visor_lower");
	wait(0.5);
	level.var_EBBC thread scripts\sp\_utility::play_sound_on_tag("scn_europa_dropship_jetpack_test_01","tag_fx_bottom");
	wait(0.5);
	setomnvar("ui_europa_halo_drop_state",1);
	thread func_888F(15,0.05);
	wait(3);
	wait(0.25);
	level.var_EBBB thread scripts\sp\_utility::play_sound_on_tag("scn_europa_dropship_jetpack_test_02","tag_fx_bottom");
	wait(0.75);
	wait(3.5);
	setomnvar("ui_europa_halo_drop_state",2);
	scripts\common\utility::flag_wait("dropship_door_open");
	scripts\common\utility::func_5127(2,::func_888F,-354.933,0.9);
	scripts\common\utility::flag_wait("halo_jump_start");
	scripts\common\utility::func_5127(7,::func_888F,-298,15);
}

//Function Number: 82
func_5E24()
{
	level.player.var_8894 = spawn("script_origin",level.player.origin);
	level.player.var_8894 linkto(level.player);
	setomnvar("ui_europa_halo_drop_state",3);
	scripts\common\utility::flag_wait("halo_jump_start");
	wait(4);
	setomnvar("ui_europa_halo_drop_state",4);
	var_00 = 5.15;
	var_01 = 0.6;
	var_02 = 0.4;
	scripts\common\utility::func_5127(var_01,::func_888C,5392,var_02,1);
	scripts\common\utility::func_5127(var_01 + var_02,::func_888C,4482,var_00 - var_01 - var_02,1);
	wait(5.15);
	scripts\common\utility::flag_set("halo_level_out");
	setomnvar("ui_europa_halo_drop_state",5);
	var_03 = 16;
	var_04 = 2962;
	thread func_888C(var_04,var_03,1);
	func_13760(0.58);
	setomnvar("ui_europa_halo_drop_state",6);
	thread func_888C(100,11,1);
	wait(5);
	scripts\common\utility::flag_set("halo_tip_down");
	scripts\common\utility::flag_wait("boost_required_start");
	level.player.var_8894 playloopsound("scn_europa_halo_altitude_beep_lp_03");
	level.player.var_58DF = 1;
	setomnvar("ui_europa_halo_drop_state",7);
	scripts\common\utility::func_6E4E("boost_required_end","player_boost_failed");
	setomnvar("ui_europa_halo_drop_state",8);
	var_05 = 2.45;
	var_01 = 1.4;
	thread func_888C(1,var_01);
	scripts\common\utility::func_5127(2,::func_888C,0,var_05 - var_01);
	thread func_FB48(var_05);
	wait(var_05);
	if(scripts\common\utility::flag("player_boost_failed"))
	{
		return;
	}

	setomnvar("ui_europa_halo_drop_state",9);
	wait(2.3);
	setomnvar("ui_europa_halo_drop_state",0);
	level notify("halo_drop_hud_close");
}

//Function Number: 83
func_FB48(param_00)
{
	wait(param_00 - 1.3);
	level.player.var_8894 scripts\sp\_utility::func_10460(1,1);
}

//Function Number: 84
func_888C(param_00,param_01,param_02)
{
	level notify("halo_drop_altitude_lerp");
	level endon("halo_drop_altitude_lerp");
	var_03 = getomnvar("ui_europa_halo_drop_altitude");
	var_04 = param_00;
	var_05 = var_03;
	var_06 = var_03 - var_04 / param_01 * 20;
	var_07 = 200;
	var_08 = undefined;
	var_08 = floor(var_05 / var_07) * var_07;
	while(var_05 > var_04)
	{
		var_05 = var_05 - var_06;
		if(abs(var_05 - var_04) < 1)
		{
			var_05 = var_04;
			setomnvar("ui_europa_halo_drop_altitude",int(var_04));
		}
		else
		{
			setomnvar("ui_europa_halo_drop_altitude",int(var_05));
		}

		if(isdefined(param_02))
		{
			if(var_05 < var_08)
			{
				if(!isdefined(level.player.var_58DF) || level.player.var_58DF == 0)
				{
					level.player.var_8894 playsound("scn_europa_halo_altitude_beep");
				}

				var_08 = floor(var_05 / var_07) * var_07;
			}
		}

		wait(0.05);
	}
}

//Function Number: 85
func_888F(param_00,param_01)
{
	level notify("halo_drop_temperature_lerp");
	level endon("halo_drop_temperature_lerp");
	var_02 = getomnvar("ui_helmet_meter_temperature");
	var_03 = param_00;
	var_04 = var_02;
	var_05 = var_02 - var_03 / param_01 * 20;
	if(var_03 < var_02)
	{
		while(var_04 > var_03)
		{
			var_04 = var_04 - var_05;
			if(abs(var_04 - var_03) < 1)
			{
				setomnvar("ui_helmet_meter_temperature",int(var_03));
				continue;
			}

			setomnvar("ui_helmet_meter_temperature",int(var_03));
			wait(0.05);
		}
	}
	else
	{
		while(var_04 < var_03)
		{
			var_04 = var_04 - var_05;
			if(abs(var_04 - var_03) < 1)
			{
				setomnvar("ui_helmet_meter_temperature",int(var_03));
				continue;
			}

			setomnvar("ui_helmet_meter_temperature",int(var_04));
			wait(0.05);
		}
	}

	thread func_888E(var_03);
}

//Function Number: 86
func_888E(param_00)
{
	level endon("halo_drop_temperature_lerp");
	level endon("halo_drop_hud_close");
	var_01 = -2;
	var_02 = 1;
	var_03 = param_00;
	for(;;)
	{
		wait(randomfloatrange(0.5,3));
		var_03 = param_00 + randomfloatrange(var_01,var_02);
		setomnvar("ui_helmet_meter_temperature",int(var_03));
	}
}

//Function Number: 87
func_3F69()
{
	wait(9);
	setomnvar("ui_chyron",1);
	thread func_3F6A();
	wait(7);
	wait(2);
	setomnvar("ui_chyron",0);
}

//Function Number: 88
func_3F6A()
{
	level.player thread scripts\sp\_utility::func_CE2F("ui_chyron_box_start");
	level.player thread scripts\common\utility::func_CD7F("ui_chyron_box_lp");
	level.player thread scripts\sp\_utility::func_C12D("stop soundui_chyron_box_lp",0.75);
	level.player thread scripts\sp\_utility::func_CE2F("ui_chyron_box_end");
	thread func_3F6B();
	wait(6);
	level.player thread scripts\sp\_utility::func_CE2F("ui_chyron_off");
}

//Function Number: 89
func_3F6B()
{
	wait(1);
	level.player thread scripts\common\utility::func_CD7F("ui_chyron_text_type_lp");
	wait(1.25);
	level.player notify("stop soundui_chyron_text_type_lp");
}

//Function Number: 90
func_4212()
{
	scripts\sp\maps\europa\europa_util::func_107C5();
	scripts\sp\_utility::func_F5AF("cliff_drop_start",[level.var_EBBB,level.var_EBBC,level.player]);
	function_02A9("storm","storm_ext",1);
	function_02A9("atmosphere","helmet",1);
	scripts\common\utility::exploder("landing");
	thread func_8E4A();
	level.player thread scripts\sp\maps\europa\europa_util::func_8E34(1);
	thread func_7451();
	func_10ACC();
}

//Function Number: 91
func_4209()
{
	thread lib_0B11::func_CCBE();
	if(scripts\common\utility::flag("player_boost_failed"))
	{
		level waittill("forever");
	}

	scripts\sp\_utility::func_2669("cliffjumper");
	thread func_420E();
	thread func_134C2();
	scripts\common\utility::flag_wait("player_at_opening");
	func_41FF();
	scripts\common\utility::flag_wait("cliffjump_complete");
}

//Function Number: 92
func_11A84()
{
	for(;;)
	{
		for(var_00 = 0;var_00 < 30;var_00++)
		{
			var_01 = level.player geteye();
			var_01 = var_01 + (randomintrange(-400,400),randomintrange(-400,400),200);
			playfx(scripts\common\utility::getfx("vfx_ice_fall_caves"),var_01);
		}

		wait(randomfloatrange(0.35,0.85));
	}
}

//Function Number: 93
func_8E4A()
{
	scripts\common\utility::flag_wait("safe_to_swap_models");
	scripts\common\utility::func_5127(0.25,::scripts\sp\maps\europa\europa_util::func_8E46,1);
}

//Function Number: 94
func_4211()
{
	scripts\common\utility::flag_wait("player_at_opening");
	wait(3);
	var_00 = scripts\common\utility::getstruct("jump_obj","targetname");
	function_015F(1,var_00.origin - (0,0,56));
	if(level.var_7683 < 2)
	{
		function_0161(1,&"EUROPA_JUMPIN");
	}

	scripts\common\utility::flag_wait("cliffjump_start");
	function_015F(1,(0,0,0));
}

//Function Number: 95
func_420E()
{
	scripts\common\utility::flag_wait("cliffjump_start");
	wait(3);
	if(getdvarint("debug_europa"))
	{
		iprintln("hiding intro_surface_vista_01");
	}

	var_00 = getent("intro_surface_vista_01","targetname");
	var_00 hide();
	if(getdvarint("debug_europa"))
	{
		iprintln("hiding intro_surface_vista_01");
	}
}

//Function Number: 96
func_7451()
{
	level.var_7452 = newclienthudelem(level.player);
	level.var_7452.foreground = 1;
	level.var_7452.alignx = "left";
	level.var_7452.aligny = "top";
	level.var_7452.horzalign = "fullscreen";
	level.var_7452.vertalign = "fullscreen";
	level.var_7452 setshader("vfx_ui_player_freeze_overlay_02",640,480);
	level.var_7452.alpha = 0;
	thread func_AB7E();
	level waittill("cliffjump_start");
	level.var_7452 scripts\sp\_hud_util::func_6AAB(0,1);
	level.var_7452 destroy();
}

//Function Number: 97
func_6745()
{
	level.player thread scripts\sp\maps\europa\europa_util::func_12992();
	thread scripts\sp\maps\europa\europa_util::func_982F(5);
	level.player scripts\common\utility::func_5127(5,::scripts\sp\maps\europa\europa_util::func_12970);
}

//Function Number: 98
func_AB7E()
{
	level endon("cliffjump_start");
	var_00 = 15000;
	level.player.var_738C = level.player scripts\common\utility::func_107CE();
	level.player.var_738C linkto(level.player);
	level.player.var_47A2 = level.player scripts\common\utility::func_107CE();
	level.player.var_47A2 linkto(level.player);
	var_01 = 1;
	var_02 = scripts\common\utility::getstruct("oval_start","targetname").origin;
	var_03 = scripts\common\utility::getstruct("oval_end","targetname").origin;
	var_04 = distance2d(var_02,var_03) * 0.5;
	var_05 = var_04 * 0.4;
	var_06 = lib_0B4D::func_7ADE(var_02,var_03);
	var_07 = level.player.origin;
	var_08 = gettime() + var_00;
	var_09 = [];
	var_09[1] = "europa_cmp_warningtemperat";
	var_09[2] = "europa_cmp_warningtemperatu";
	var_09[3] = "europa_cmp_warningairsuppl";
	scripts\common\utility::func_5127(3.5,::func_6745);
	var_0A = 1;
	for(;;)
	{
		if(lib_0B4D::func_D638(level.player.origin,var_06,var_05,var_04))
		{
			var_01 = 0;
			if(gettime() > var_08)
			{
				var_0B = 0.002;
			}
			else
			{
				var_0B = 0;
			}
		}
		else
		{
			var_0C = distance2dsquared(level.player.origin,var_06) < distance2dsquared(var_07,var_06);
			if(!var_01)
			{
			}

			if(var_0C)
			{
				var_0B = 0.005;
			}
			else
			{
				var_0B = 0.02;
			}
		}

		level.var_7452.alpha = level.var_7452.alpha + var_0B;
		thread scripts\sp\maps\europa\europa_util::func_D988(level.var_7452.alpha);
		if(level.var_7452.alpha >= 1)
		{
			func_738B();
			break;
		}

		var_07 = level.player.origin;
		var_0D = func_E758(level.var_7452.alpha);
		if(var_0D == func_E758(var_0A / var_09.size))
		{
			level.player thread scripts\sp\_utility::func_CE2F(var_09[var_0A]);
			var_0A++;
			level.player thread scripts\sp\maps\europa\europa_util::func_12992();
			level.player scripts\common\utility::func_5127(5,::scripts\sp\maps\europa\europa_util::func_12970);
			if(var_0A == 2)
			{
				thread start_player_freezing_sfx();
			}
		}

		wait(0.225);
	}
}

//Function Number: 99
start_player_freezing_sfx()
{
	level endon("froze_to_death");
	level.freeze_sfx_org = spawn("script_origin",level.player.origin);
	level.freeze_sfx_org scripts\common\utility::delaycall(19,::playsound,"scn_euro_player_freeze");
}

//Function Number: 100
func_6C2C(param_00)
{
	level thread scripts\sp\_utility::func_C12D("stop_final_wanring",param_00);
	level.player thread scripts\sp\_utility::func_D2CD(50,param_00);
}

//Function Number: 101
func_448E(param_00)
{
	level endon("cliffjump_start");
	var_01 = [];
	var_01[var_01.size] = "europa_cmp_warningtemperat";
	var_01[var_01.size] = "europa_cmp_warningtemperatu";
	var_01[var_01.size] = "europa_cmp_warningairsuppl";
	foreach(var_03 in var_01)
	{
		wait(param_00 / var_01.size);
		level.player scripts\sp\_utility::func_CE2F(var_03);
	}
}

//Function Number: 102
func_738B()
{
	if(scripts\common\utility::flag("cliffjump_start"))
	{
		return;
	}

	level notify("froze_to_death");
	if(isdefined(level.freeze_sfx_org))
	{
		level.freeze_sfx_org scripts\common\utility::delaycall(1,::method_83AD);
	}

	level.player.var_E6.var_1025C = 1;
	lib_0B60::func_F322("EUROPA_FREEZE_DEATH");
	level.player scripts\sp\_utility::func_54C6();
}

//Function Number: 103
func_C800(param_00,param_01)
{
	self notify("new_fade");
	self endon("new_fade");
	self fadeovertime(param_01);
	self.alpha = param_00;
	wait(param_01);
}

//Function Number: 104
func_DAEF(param_00,param_01)
{
	var_02 = self.alpha;
	self fadeovertime(param_01 / 2);
	self.alpha = param_00;
	wait(param_01 / 2);
	self fadeovertime(param_01 / 2);
	self.alpha = var_02;
}

//Function Number: 105
func_10AD0()
{
	scripts\common\utility::array_thread(level.var_EBCA,::scripts\sp\_utility::func_54F7);
	level.var_EBBB.target = "sipes_lookaround";
	level.var_EBBC.target = "t_lookaround";
	scripts\common\utility::array_thread(level.var_EBCA,::lib_0B77::func_8409);
	scripts\common\utility::flag_wait("player_at_landing_zone");
	func_1381C();
}

//Function Number: 106
func_1381C()
{
	level endon("landing_vo_finished");
	scripts\common\utility::func_6E5A("player_at_landing_zone");
}

//Function Number: 107
func_B01E()
{
	self endon("stop_going_to_node");
	var_00 = scripts\common\utility::func_107CE();
	var_00 scripts\common\utility::delaycall(11,::delete);
	scripts\common\utility::func_5127(1,::lib_0C4C::func_1955,var_00);
	for(;;)
	{
		var_01 = anglestoforward(self.angles);
		var_00.origin = self.origin + (0,0,200) + var_01 * 100;
		wait(0.05);
	}
}

//Function Number: 108
func_10ACC()
{
	scripts\sp\maps\europa\europa_util::func_EBC7();
	scripts\common\utility::array_thread(level.var_EBCA,::func_EBC2);
}

//Function Number: 109
func_EBC2()
{
	while(self method_81A6())
	{
		wait(0.05);
	}

	scripts\sp\_utility::func_61E7();
	if(self == level.var_EBBC)
	{
		wait(0.6);
		level.var_EBBC scripts\sp\_utility::func_F3B5("b");
	}

	scripts\common\utility::func_5127(6,::scripts\sp\_utility::func_5514);
	thread func_B013();
}

//Function Number: 110
func_420C()
{
	var_00 = getent("intro_surface_vista_01","targetname");
	var_00 hide();
	if(getdvarint("debug_europa"))
	{
		iprintln("Hiding \'intro_surface_vista_01\' ");
	}

	thread lib_0B11::func_CCBE();
}

//Function Number: 111
func_134C2()
{
	if(level.var_10CDA == "cliffjumper")
	{
		wait(1.5);
	}

	function_02A9("storm","storm_ext",1);
	scripts\sp\maps\europa\europa_util::func_134B7("europa_plr_surfacetemps300");
	wait(0.5);
	var_00 = ["europa_plr_reaperscarsareo","europa_rpr_copy11beadvised","europa_plr_copyunthemove"];
	scripts\sp\maps\europa\europa_util::func_D24C(var_00);
	thread scripts\sp\maps\europa\europa_util::func_67B6(1,"current",&"EUROPA_OBJECTIVE_ACCESS","entering_seeker_room");
	thread func_4211();
	level notify("landing_vo_finished");
	func_4A5D();
}

//Function Number: 112
func_4A5D()
{
	if(scripts\common\utility::flag("cliffjump_start"))
	{
		return;
	}

	level endon("cliffjump_start");
	scripts\common\utility::flag_wait("lookdown_started");
	wait(1);
	scripts\sp\maps\europa\europa_util::func_134B7("europa_tee_trackintwotargest");
	wait(0.15);
	scripts\sp\maps\europa\europa_util::func_134B7("europa_tee_boostdowntakeem");
	var_00 = ["europa_tee_gearsicingupletspl","europa_sip_wolfjumpdownwe","europa_tee_onyouboss"];
	for(;;)
	{
		foreach(var_02 in var_00)
		{
			wait(randomintrange(9,15));
			if(scripts\common\utility::flag("cliffjump_start"))
			{
				return;
			}

			scripts\sp\maps\europa\europa_util::func_134B7(var_02);
		}

		wait(0.05);
	}
}

//Function Number: 113
func_B013()
{
	level endon("cliffjump_start");
	self.var_B015 = scripts\common\utility::getstruct("lookdown_" + self.var_1FBB,"targetname");
	scripts\sp\_utility::func_54F7();
	wait(randomfloatrange(0.2,1.5));
	self.var_B015 lib_0B06::func_1F17(self,"lookdown");
	scripts\common\utility::flag_set("lookdown_started");
	self.var_B015 lib_0B06::func_1F35(self,"lookdown");
	lib_0B06::func_1EEA(self,"lookdown_idle");
}

//Function Number: 114
func_41FF()
{
	scripts\common\utility::func_6E2A("boost_required_start");
	scripts\common\utility::func_6E2A("boost_required_end");
	scripts\common\utility::func_6E2A("player_boosted");
	level.var_421D = scripts\common\utility::getstruct("cliffjumper_takedown","targetname");
	level.var_421D.var_D267 = scripts\sp\_utility::func_10639("player_rig",level.var_421D.origin + (0,0,4000),(0,0,0));
	level.var_421D.var_D267 hide();
	scripts\common\utility::flag_wait("cliffjump_start");
	level.var_421D.var_D04B = scripts\sp\_utility::func_107EA("cliffjump_enemy_player",1);
	level.var_421D.var_1CE2 = scripts\sp\_utility::func_107EA("cliffjump_enemy_ally",1);
	level.var_421D.var_D04B scripts\sp\maps\europa\europa_labs::func_19D9();
	level.var_421D.var_1CE2 scripts\sp\maps\europa\europa_labs::func_19D9();
	level.var_421D.var_D04B.var_1FBB = "player_enemy";
	level.var_421D.var_D04B thread func_1081C();
	level.var_421D.var_1CE2.var_1FBB = "ally_enemy";
	level.var_421D.var_1CE2 thread func_1081C();
	level.var_421D.var_1CBF = level.var_EBBC;
	level.var_421D.var_1684 = [level.var_421D.var_D267,level.var_421D.var_D04B,level.var_421D.var_1CE2,level.var_421D.var_1CBF];
	level.var_421D.var_CF5C = getanimlength(level.var_421D.var_D267 scripts\sp\_utility::func_7DC1("cliffjumper"));
	level.player.var_D267 = level.var_421D.var_D267;
	level.var_4205 = spawn("script_origin",level.player.origin);
	level.var_421D.var_1CE2 scripts\sp\_utility::func_B14F();
	thread scripts\common\utility::func_6E3F("boost_required_start",1.5);
	level.var_4205 playsound("scn_cave_jump_plr");
	level.var_421D.var_1CE2 scripts\sp\_utility::func_1101B();
	function_02A9("storm","",1);
	if(isdefined(level.player.var_738C))
	{
		level.player.var_738C method_8278(0,1);
		level.player.var_738C scripts\common\utility::delaycall(1.25,::delete);
	}

	scripts\common\utility::func_5127(1,::func_4201);
	if(isdefined(level.player.var_737C))
	{
		level.player.var_737C thread func_C800(0,0.5);
	}

	foreach(var_01 in level.var_EBCA)
	{
		var_01.var_B015 notify("stop_loop");
		var_01 scripts\sp\maps\europa\europa_util::func_10FC2();
	}

	level.var_421D thread lib_0B06::func_1F2C(level.var_421D.var_1684,"cliffjumper");
	thread func_AD0C(level.var_421D);
	level.var_EBBC hide();
	thread func_4207();
	thread func_420A(level.var_421D);
	thread func_4213(level.var_421D);
	thread func_F915();
	scripts\common\utility::flag_wait("cliffjump_boost_start");
	level.var_EBBC show();
}

//Function Number: 115
func_F915()
{
	level endon("scar_saved_player");
	var_00 = [level.player.var_D267,level.var_421D.var_D04B];
	scripts\common\utility::flag_wait("cliffjump_kick_done");
	scripts\common\utility::func_5127(0.25,::scripts\sp\_hud::func_8DFF,-250,0.05);
	if(!scripts\common\utility::flag("player_stabbed"))
	{
		level.var_421D thread lib_0B06::func_1F2C(var_00,"cliffjumper_loop");
		setslowmotion(1,0.25,0.5);
		var_01 = getanimlength(level.player.var_D267 scripts\sp\_utility::func_7DC1("cliffjumper_loop"));
		thread func_3DB5(var_01);
		level.player waittill("melee_pressed");
		scripts\common\utility::flag_set("player_stabbed");
		level.var_421D.var_1CBF method_82B0(level.var_421D.var_1CBF scripts\sp\_utility::func_7DC1("cliffjumper"),0.5);
		level.var_421D.var_1CE2 method_82B0(level.var_421D.var_1CE2 scripts\sp\_utility::func_7DC1("cliffjumper"),0.5);
	}

	level.player playsound("scn_cave_jump_boostkill_stab");
	setslowmotion(0.25,1,0.1);
	level.player method_81DE(65,0.75);
	level.var_421D lib_0B06::func_1F2C(var_00,"cliffjumper_kill");
	level.var_421D.var_D04B scripts\sp\_utility::func_19D3();
	scripts\common\utility::flag_set("cliffjump_complete");
}

//Function Number: 116
func_1081C()
{
	self waittill("death");
	var_00 = self gettagorigin("tag_weapon_right") + (0,0,15);
	var_00 = scripts\sp\_utility::func_864C(var_00) + (0,0,1);
	var_01 = self gettagangles("tag_weapon_right");
	var_02 = spawn("weapon_" + self.var_394,var_00);
	var_02.angles = var_01;
}

//Function Number: 117
func_5FB3()
{
	level endon("player_stabbed");
	level endon("scar_saved_player");
	scripts\common\utility::func_5127(1.95,::scripts\sp\_utility::func_56BA,"melee_hint");
	level.player waittill("melee_pressed");
	scripts\common\utility::flag_set("player_stabbed");
}

//Function Number: 118
func_3DB5(param_00)
{
	level endon("player_stabbed");
	wait(param_00);
	scripts\common\utility::flag_set("scar_saved_player");
	var_01 = scripts\common\utility::getstruct("blood_pool_struct","targetname").origin;
	playfx(level._effect["deathfx_bloodpool_generic"],var_01);
	function_01D3(1);
	level.var_4214 delete();
	level.player playerlinktodelta(level.var_421D.var_D267,"tag_player",0,1,1,1,1,1);
	level.player method_81DE(65,0.75);
	scripts\common\utility::func_5127(1.25,::scripts\sp\maps\europa\europa_util::func_134B7,"europa_tee_focusupmate");
	level.var_421D.var_1CBF method_82B0(level.var_421D.var_1CBF scripts\sp\_utility::func_7DC1("cliffjumper"),0.6);
	level.var_421D.var_1CE2 method_82B0(level.var_421D.var_1CE2 scripts\sp\_utility::func_7DC1("cliffjumper"),0.6);
	thread func_6ADE();
	var_02 = [level.player.var_D267,level.var_421D.var_D04B];
	level.var_421D lib_0B06::func_1F2C(var_02,"cliffjumper_exit");
	level.var_421D.var_D04B scripts\sp\_utility::func_19D3();
	scripts\common\utility::flag_set("cliffjump_complete");
}

//Function Number: 119
func_6ADE()
{
	var_00 = scripts\common\utility::getstruct("cliff_bullet_start","targetname").origin;
	var_01 = scripts\common\utility::getstruct("blood_pool_struct","targetname").origin;
	var_02 = 6;
	var_03 = [];
	for(var_04 = 0;var_04 < var_02;var_04++)
	{
		function_0178("weap_kbs_sup_plr",level.player geteye());
		var_05 = var_00 + scripts\common\utility::func_DCC8(3);
		var_06 = var_01 + (randomfloatrange(-10,10),-5,0);
		var_07 = var_06 - var_05;
		var_08 = vectortoangles(var_07);
		playfx(level._effect["bullet_tracer"],var_05,anglestoforward(var_08),anglestoup(var_08));
		wait(0.05);
		if(isdefined(level.var_421D.var_D04B))
		{
			playfx(level.var_7649["human_gib_head"],scripts\common\utility::getstruct("blood_pool_struct","targetname").origin);
		}

		wait(randomfloatrange(0.15,0.25));
		var_09 = scripts\sp\_utility::func_864C(var_06 + (0,0,10));
		playfx(scripts\common\utility::getfx("bullet_cracks"),var_09);
	}
}

//Function Number: 120
func_AB70(param_00,param_01)
{
	level notify("lerping_cliff_anim_rates");
	level endon("lerping_cliff_anim_rates");
	var_02 = func_78A5();
	var_03 = param_00 - var_02;
	var_04 = param_01 / 0.05;
	var_05 = var_03 / var_04;
	var_06 = gettime() + param_01 * 1000;
	while(gettime() < var_06)
	{
		var_02 = var_02 + var_05;
		func_F300(var_02);
		wait(0.05);
	}

	func_F300(param_00);
}

//Function Number: 121
func_78A6()
{
	return level.player.var_D267 method_8102(level.player.var_D267 scripts\sp\_utility::func_7DC1("cliffjumper"));
}

//Function Number: 122
func_78A5()
{
	return level.player.var_D267 method_8104(level.player.var_D267 scripts\sp\_utility::func_7DC1("cliffjumper"));
}

//Function Number: 123
func_F300(param_00)
{
	foreach(var_02 in level.var_421D.var_1684)
	{
		if(isdefined(var_02))
		{
			var_02 method_82B1(var_02 scripts\sp\_utility::func_7DC1("cliffjumper"),param_00);
		}
	}
}

//Function Number: 124
func_13745(param_00)
{
	while(func_78A6() < param_00)
	{
		wait(0.05);
	}
}

//Function Number: 125
func_4201()
{
}

//Function Number: 126
func_4213(param_00)
{
	scripts\sp\_utility::func_10FEC("landing");
	scripts\common\utility::exploder("le_clouds");
	var_01 = level.var_421D.var_D04B.origin;
	while(level.player.origin[2] - var_01[2] > 500)
	{
		wait(0.05);
	}

	while(!level.var_CF99)
	{
		wait(0.05);
	}

	playfx(scripts\common\utility::getfx("landing_kickup_dist"),var_01);
	while(level.player.origin[2] - var_01[2] > 325)
	{
		wait(0.05);
	}

	playfx(scripts\common\utility::getfx("landing_kickup"),var_01);
}

//Function Number: 127
func_AD0C(param_00)
{
	var_01 = function_00CD(param_00.origin,param_00.angles,param_00.var_D267 scripts\sp\_utility::func_7DC1("cliffjumper"))[1];
	var_02 = level.player.angles[1];
	var_02 = scripts\common\utility::func_116D7(var_02 < 0,var_02 + 360,var_02);
	var_03 = 0.75;
	var_04 = 2;
	var_05 = 0;
	var_06 = 180;
	var_07 = var_01 - var_02;
	var_08 = lib_0B4D::func_C097(var_06,var_05,var_07);
	var_09 = lib_0B4D::func_6A8E(var_03,var_04,var_08);
	if(level.player istouching(getent("freaking_lerp_quicker","targetname")))
	{
		var_09 = 0.5;
	}

	level.player thread scripts\sp\maps\europa\europa_util::func_D85C();
	level.player playerlinktoblend(param_00.var_D267,"tag_player",var_09);
	wait(var_09);
	level.player playerlinktodelta(param_00.var_D267,"tag_player",1,0,0,0,0,1);
	param_00.var_D267 scripts\common\utility::delaycall(0.05,::show);
	thread func_10135();
	scripts\common\utility::flag_wait("cliffjump_complete");
	if(isdefined(level.var_4214))
	{
		level.var_4214 delete();
	}

	level.player scripts\sp\maps\europa\europa_util::func_DF3E();
	param_00.var_D267 delete();
}

//Function Number: 128
func_10135()
{
	level endon("cliffjump_complete");
	while(!isdefined(level.var_4214))
	{
		wait(0.05);
	}

	level.var_4214 show();
}

//Function Number: 129
func_420A(param_00)
{
	scripts\common\utility::flag_wait("boost_required_start");
	thread func_D86A();
	thread func_420B();
	thread func_4202(param_00);
	thread func_4206(param_00);
	while(!level.var_CF99)
	{
		wait(0.05);
	}

	thread func_5FB3();
	if(scripts\common\utility::flag("boost_required_end"))
	{
	}
}

//Function Number: 130
func_420B()
{
	level.player waittill("playerboost");
	level.player playsound("scn_cave_jump_boost");
}

//Function Number: 131
func_4206(param_00)
{
	while(distancesquared(level.player.origin,param_00.var_D04B.origin) > squared(1400))
	{
		wait(0.05);
	}

	if(level.var_CF99)
	{
		return;
	}

	scripts\common\utility::func_5127(0.85,::scripts\sp\_utility::func_56BE,"freefall_boost",3);
	level.player thread scripts\sp\_utility::func_CE2F("scn_cave_jump_slomo");
	function_01BA("");
	wait(0.2);
	level.var_4205 method_83AD();
	level.var_1031B.var_ABA1 = 0.4;
	level.var_1031B.var_1098F = 0.1;
	level.player method_81DE(50,2);
	setslowmotion(1,0.5,1.5);
	thread func_AB70(0.05,2);
	wait(0.2);
	scripts\sp\_utility::func_56BA("freefall_boost");
	function_014C("playerboost","+gostand");
	function_014C("playerboost","+moveup");
	level.player waittill("playerboost");
	thread func_6AE2();
	setslowmotion(0.2,1,0.1);
	func_AB70(1,0.1);
	level.player thread scripts\sp\_utility::func_CE2F("europa_slowmo_out");
}

//Function Number: 132
func_6AE2()
{
	setomnvar("ui_hud_heist_boost",1);
	var_00 = 1;
	var_01 = 0.03;
	while(var_00 > 0.73)
	{
		setomnvar("ui_hud_heist_boost_amount",var_00);
		var_00 = var_00 - var_01;
		wait(0.05);
	}

	wait(0.5);
	setomnvar("ui_hud_heist_boost",0);
}

//Function Number: 133
func_ABB3(param_00,param_01)
{
	var_02 = getdvarint("cg_fov");
	var_03 = gettime() + param_01 * 1000;
	var_04 = param_01 / 0.05;
	var_05 = param_00 - var_02 / var_04;
	while(gettime() < var_03)
	{
		var_02 = var_02 + var_05;
		level.player method_81DE(var_02,0.05);
		wait(0.05);
	}
}

//Function Number: 134
func_4202(param_00)
{
	scripts\common\utility::flag_wait("boost_required_end");
	level notify("kill_boost_button");
	if(!level.var_CF99)
	{
		thread scripts\sp\_utility::func_10322();
		var_01 = 0.15;
		param_00.var_D361 = level.player scripts\common\utility::func_107CE();
		param_00.var_D361.angles = (85,level.player.angles[1],level.player.angles[2]);
		level.player playerlinktoabsolute(param_00.var_D361);
		param_00.var_D267 hide();
		param_00.var_D361 moveto(param_00.origin,var_01);
		level.player clearhudtutorialmessage();
		wait(0.15);
		function_0178("player_falling_death_impact",level.player.origin);
		earthquake(1,1,level.player.origin,200);
		level.player method_8244("damage_heavy");
		lib_0B60::func_F322("EUROPA_BOOST_DEATH_HINT");
		setdvar("player_death_animated",0);
		level.player method_81D0();
		level.player stoprumble("damage_heavy");
	}
}

//Function Number: 135
func_4207()
{
	scripts\common\utility::flag_wait("teleport_scar1");
	wait(1.7);
	var_00 = scripts\common\utility::getstructarray("drop_landing_start","targetname");
	foreach(var_02 in var_00)
	{
		if(var_02.script_noteworthy != "scar2")
		{
			level.var_EBBB method_80F1(var_02.origin,var_02.angles,-15536);
		}
	}

	level.var_EBBB scripts\sp\_utility::func_4145();
	level.var_EBBC scripts\sp\_utility::func_4145();
	scripts\sp\_utility::func_15F5("squad_lands");
	level.var_EBBB scripts\sp\_utility::func_F3B5("r");
	level.var_EBBB scripts\sp\_utility::func_61C7();
}

//Function Number: 136
func_4200()
{
	scripts\sp\_utility::func_5550();
	self.var_180 = 1;
	self.var_595D = 1;
	self.var_2894 = 0.25;
	scripts\common\utility::flag_wait("cliffjump_boost_end");
	scripts\sp\_utility::func_F39C(level.player);
	self.var_180 = 0;
	self.health = 20;
	scripts\common\utility::flag_wait("cliffjump_landed");
	wait(0.7);
	self.var_595D = undefined;
}

//Function Number: 137
func_A4E1()
{
	if(level.var_7683 == 0)
	{
		return;
	}

	level endon("halo_jump_start");
	wait(20);
	if(!scripts\common\utility::flag("halo_jump_start"))
	{
		level.player clearhudtutorialmessage(1);
		setomnvar("ui_death_hint",41);
		scripts\sp\_utility::func_B8D1();
	}
}

//Function Number: 138
func_D86B()
{
	var_00 = 0;
	scripts\sp\_utility::func_56BE("halojump_hint",20);
	function_014C("playerjump","+gostand");
	function_014C("playerjump","+moveup");
	while(var_00 == 0)
	{
		if(!level.var_7683)
		{
			level.player scripts\common\utility::waittill_notify_or_timeout("playerjump",20);
		}
		else
		{
			level.player waittill("playerjump");
		}

		level notify("change_camera_shake");
		var_00 = 1;
	}
}

//Function Number: 139
func_D86A()
{
	level endon("kill_boost_button");
	level.var_CF99 = 0;
	scripts\common\utility::flag_wait("boost_required_start");
	for(;;)
	{
		level.player waittill("playerboost");
		level.var_CF99 = 1;
		level.player thread scripts\sp\_utility::func_CE2F("double_jump_boost_plr");
		level.player playrumbleonentity("heavy_1s");
	}
}

//Function Number: 140
func_2CB4()
{
	if(level.var_CF99 == 1 || scripts\common\utility::flag("player_boosted"))
	{
		return 1;
	}

	return 0;
}

//Function Number: 141
func_5DF0()
{
}

//Function Number: 142
func_5E75()
{
	var_00 = getentarray("europa_dropshiplight_green","targetname");
	scripts\common\utility::array_thread(var_00,::scripts\sp\maps\europa\europa_util::func_AC86);
	var_00 = getentarray("europa_dropshiplight_red","targetname");
	scripts\common\utility::array_thread(var_00,::scripts\sp\maps\europa\europa_util::func_AC87,100);
}

//Function Number: 143
func_5E06()
{
	var_00 = getentarray("europa_dropshiplight_red","targetname");
	scripts\common\utility::array_thread(var_00,::scripts\sp\maps\europa\europa_util::func_AC86);
	var_00 = getentarray("europa_dropshiplight_green","targetname");
	scripts\common\utility::array_thread(var_00,::scripts\sp\maps\europa\europa_util::func_AC87,1000);
}

//Function Number: 144
func_5EA4()
{
	level.var_5D6C = lib_0BBF::func_106B8("scar_dropship",undefined,"jump_seat_1");
	level.var_5D6C lib_0BBF::func_106BA(1,undefined,1);
	level.var_5D6C lib_0BBF::func_F456();
	level.var_5D6C lib_0BBF::func_F4B4("straps","heavy");
	level.var_5D6C.var_1FBB = "dropship";
	level.var_5D6C lib_0B06::func_F64A();
	if(scripts\sp\_utility::func_8C32(level.var_5D6C.model,"tag_origin"))
	{
		level.var_5D6C.var_E6E8 = "tag_origin";
	}
	else
	{
		level.var_5D6C.var_E6E8 = level.var_5D6C.model;
	}

	level.var_5D6C thread func_5D91();
}

//Function Number: 145
func_5D91()
{
	foreach(var_01 in self.var_4D94.var_9A62)
	{
		if(issubstr(var_01.model,"bays_ri"))
		{
			continue;
		}

		if(!issubstr(var_01.model,"interior_"))
		{
			continue;
		}

		var_01 delete();
	}

	foreach(var_04, var_01 in self.var_4D94.var_F08B)
	{
		if(issubstr(var_04,"right"))
		{
			continue;
		}

		var_01 delete();
	}

	if(isdefined(self.var_E4FB))
	{
		foreach(var_06 in self.var_E4FB)
		{
			var_06 delete();
		}
	}
}