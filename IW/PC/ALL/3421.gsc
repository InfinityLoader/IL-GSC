/*******************************************************************
 * Decompiled By: Bog
 * Decompiled File: 3421.gsc
 * Game: Call of Duty: Infinite Warfare
 * Platform: PC
 * Function Count: 94
 * Decompile Time: 51 ms
 * Timestamp: 10/27/2023 12:27:11 AM
*******************************************************************/

//Function Number: 1
register_interactions()
{
	level.interaction_hintstrings["perk_machine_revive"] = &"COOP_PERK_MACHINES_1500";
	level.interaction_hintstrings["perk_machine_tough"] = &"COOP_PERK_MACHINES_2500";
	level.interaction_hintstrings["perk_machine_flash"] = &"COOP_PERK_MACHINES_3000";
	level.interaction_hintstrings["perk_machine_more"] = &"COOP_PERK_MACHINES_4000";
	level.interaction_hintstrings["perk_machine_rat_a_tat"] = &"COOP_PERK_MACHINES_2000";
	level.interaction_hintstrings["perk_machine_run"] = &"COOP_PERK_MACHINES_RUN";
	level.interaction_hintstrings["perk_machine_fwoosh"] = &"COOP_PERK_MACHINES_FWOOSH";
	level.interaction_hintstrings["perk_machine_smack"] = &"COOP_PERK_MACHINES_SMACK";
	level.interaction_hintstrings["perk_machine_zap"] = &"COOP_PERK_MACHINES_ZAP";
	level.interaction_hintstrings["perk_machine_boom"] = &"COOP_PERK_MACHINES_BOOM";
	level.interaction_hintstrings["perk_machine_deadeye"] = &"COOP_PERK_MACHINES_1000";
	level.interaction_hintstrings["perk_machine_change"] = &"COOP_PERK_MACHINES_DLC3_CHANGE";
	scripts\cp\_interaction::func_DEBB("perk_machine_run","perk",1,::func_9011,::func_15DE,0,1,::func_9719);
	scripts\cp\_interaction::func_DEBB("perk_machine_revive","perk",1,::func_9011,::func_15DE,0,1,::func_970E);
	scripts\cp\_interaction::func_DEBB("perk_machine_rat_a_tat","perk",1,::func_9011,::activate_perk_machine_gesture_second,0,1,::func_9705);
	scripts\cp\_interaction::func_DEBB("perk_machine_tough","perk",1,::func_9011,::func_15DE,0,1,::func_9787);
	scripts\cp\_interaction::func_DEBB("perk_machine_flash","perk",1,::func_9011,::func_15DE,0,1,::func_95E3);
	scripts\cp\_interaction::func_DEBB("perk_machine_more","perk",1,::func_9011,::func_15DE,0,1,::func_968B);
	scripts\cp\_interaction::func_DEBB("perk_machine_fwoosh","perk",1,::func_9011,::func_15DE,0,1,::func_95F4);
	scripts\cp\_interaction::func_DEBB("perk_machine_smack","perk",1,::func_9011,::func_15DE,0,1,::func_974A);
	scripts\cp\_interaction::func_DEBB("perk_machine_zap","perk",1,::func_9011,::func_15DE,0,1,::func_97AC);
	scripts\cp\_interaction::func_DEBB("perk_machine_boom","perk",1,::func_9011,::func_15DE,0,1,::func_9553);
	scripts\cp\_interaction::func_DEBB("perk_machine_deadeye","perk",1,::func_9011,::func_15DE,0,1,::init_deadeye_machines_func);
	scripts\cp\_interaction::func_DEBB("perk_machine_change","perk",1,::func_9011,::func_15DE,0,1,::init_change_machines_func);
}

//Function Number: 2
func_DEE2()
{
	level._effect["fire_cloud_1st"] = loadfx("vfx/iw7/core/zombie/vfx_zmb_fire_trail_1st.vfx");
	level._effect["fire_cloud_3rd"] = loadfx("vfx/iw7/core/zombie/vfx_zmb_fire_trail_3rd.vfx");
	level._effect["fire_trail"] = loadfx("vfx/iw7/core/zombie/vfx_zmb_fire_trail_ground_line.vfx");
	level._effect["repulsor_wave_red"] = loadfx("vfx/iw7/_requests/coop/zmb_repulsor_wave_red");
	level._effect["repulsor_view_red"] = loadfx("vfx/iw7/_requests/coop/zmb_repulsor_wave_view_red");
	level._effect["reload_zap_s"] = loadfx("vfx/iw7/core/zombie/weapon/zap/vfx_zmb_zap_radial_s.vfx");
	level._effect["reload_zap_m"] = loadfx("vfx/iw7/core/zombie/weapon/zap/vfx_zmb_zap_radial_m.vfx");
	level._effect["reload_zap_l"] = loadfx("vfx/iw7/core/zombie/weapon/zap/vfx_zmb_zap_radial_l.vfx");
	level._effect["reload_zap_screen"] = loadfx("vfx/iw7/core/zombie/weapon/zap/vfx_zmb_zap_radial_sreen.vfx");
	lib_0CFE::func_DECD("perk_machine_tough",::func_8341,::func_11458);
	lib_0CFE::func_DECD("perk_machine_revive",::func_8327,::func_1144F);
	lib_0CFE::func_DECD("perk_machine_flash",::func_82CD,::func_11437);
	lib_0CFE::func_DECD("perk_machine_more",::func_82EE,::func_11441);
	lib_0CFE::func_DECD("perk_machine_rat_a_tat",::func_8326,::func_1144D);
	lib_0CFE::func_DECD("perk_machine_run",::func_832B,::func_11451);
	lib_0CFE::func_DECD("perk_machine_fwoosh",::func_82CE,::func_11438);
	lib_0CFE::func_DECD("perk_machine_smack",::func_8331,::func_11453);
	lib_0CFE::func_DECD("perk_machine_zap",::func_834D,::func_1145B);
	lib_0CFE::func_DECD("perk_machine_boom",::func_82A7,::func_1142B);
	lib_0CFE::func_DECD("perk_machine_deadeye",::give_deadeye_perk,::take_deadeye_perk);
	lib_0CFE::func_DECD("perk_machine_change",::give_change_perk,::take_change_perk);
	if(isdefined(level.perk_registration_func))
	{
		[[ level.perk_registration_func ]]();
	}

	level.var_BDFD = ::func_FF6B;
	level thread func_12E02();
}

//Function Number: 3
func_12E02()
{
	for(;;)
	{
		level scripts\common\utility::waittill_any_3("player_count_determined","multiple_players");
		func_12E1D();
	}
}

//Function Number: 4
func_970E()
{
	func_96C7("perk_machine_revive");
}

//Function Number: 5
func_9787()
{
	func_96C7("perk_machine_tough");
}

//Function Number: 6
func_95E3()
{
	func_96C7("perk_machine_flash");
}

//Function Number: 7
func_968B()
{
	func_96C7("perk_machine_more");
}

//Function Number: 8
func_9705()
{
	func_96C7("perk_machine_rat_a_tat");
}

//Function Number: 9
func_9719()
{
	func_96C7("perk_machine_run");
}

//Function Number: 10
func_95F4()
{
	func_96C7("perk_machine_fwoosh");
}

//Function Number: 11
func_974A()
{
	func_96C7("perk_machine_smack");
}

//Function Number: 12
func_97AC()
{
	func_96C7("perk_machine_zap");
}

//Function Number: 13
func_9553()
{
	func_96C7("perk_machine_boom");
}

//Function Number: 14
init_deadeye_machines_func()
{
	func_96C7("perk_machine_deadeye");
}

//Function Number: 15
init_change_machines_func()
{
	level.change_chew_explosion_func = ::change_chew_explosion;
	var_00 = getdvar("ui_mapname");
	if(var_00 == "cp_town" || var_00 == "cp_final")
	{
		func_96C7("perk_machine_change");
	}
}

//Function Number: 16
delay_rotate_func(param_00)
{
	wait(param_00);
	var_01 = getent("change_chews_lower","targetname");
	if(isdefined(var_01))
	{
		var_02 = getdvar("ui_mapname");
		if(var_02 == "cp_town")
		{
			var_01.angles = (0,276,0);
			level thread rotate_loop_by_targetname("change_chews_upper",(0,276,0),(348,276,0));
		}

		if(var_02 == "cp_final")
		{
			var_01.angles = (0,156,0);
			level thread rotate_loop_by_targetname("change_chews_upper",(0,156,0),(348,156,0));
		}
	}
}

//Function Number: 17
rotate_loop_by_targetname(param_00,param_01,param_02)
{
	var_03 = getent(param_00,"targetname");
	for(;;)
	{
		var_03 rotateto(param_02,1);
		var_03 waittill("rotatedone");
		var_03 rotateto(param_01,1);
		var_03 waittill("rotatedone");
	}
}

//Function Number: 18
func_96C7(param_00)
{
	var_01 = scripts\common\utility::getstructarray(param_00,"script_noteworthy");
	foreach(var_04, var_03 in var_01)
	{
		var_03 thread func_E4A2(var_04);
	}
}

//Function Number: 19
func_E4A2(param_00)
{
	var_01 = undefined;
	if(isdefined(self.target))
	{
		self.var_1B9 = getent(self.target,"targetname");
		self.var_1B9 setlightintensity(0);
	}

	func_96C6();
	scripts\common\utility::flag_wait("player_count_determined");
	if(self.script_noteworthy == "perk_machine_revive" && scripts\cp\_utility::isplayingsolo() || level.only_one_player)
	{
		if(param_00 > 0)
		{
			wait(0.1 * param_00);
		}

		func_12987();
		return;
	}

	if(scripts\common\utility::istrue(self.var_E1B9) && isdefined(self.var_D71C))
	{
		for(;;)
		{
			var_02 = level scripts\common\utility::waittill_any_return_no_endon_death_3("power_on",self.var_D71C + " power_on","power_off");
			if(var_02 == "power_off")
			{
				func_1295E();
				continue;
			}

			if(param_00 > 0)
			{
				wait(0.1 * param_00);
			}

			func_12987();
		}

		return;
	}

	if(param_00 > 0)
	{
		wait(0.1 * param_00);
	}

	func_12987();
}

//Function Number: 20
func_12987()
{
	self.var_D776 = 1;
	if(scripts\cp\_utility::map_check(0))
	{
		level thread scripts\cp\_vo::func_1769("dj_perkstation_use_nag","zmb_dj_vo",60,15,3,0);
	}

	foreach(var_01 in level.players)
	{
		var_01 thread scripts\cp\_vo::func_1769("nag_try_perk","zmb_comment_vo",60,270,6,1);
	}

	var_03 = "mus_zmb_tuffnuff_purchase";
	switch(self.script_noteworthy)
	{
		case "perk_machine_revive":
			var_03 = "mus_zmb_upnatoms_attract";
			break;

		case "perk_machine_flash":
			var_03 = "mus_zmb_quickies_attract";
			break;

		case "perk_machine_more":
			var_03 = "mus_zmb_mulemunchies_attract";
			break;

		case "perk_machine_rat_a_tat":
			var_03 = "mus_zmb_bangbangs_attract";
			break;

		case "perk_machine_run":
			var_03 = "mus_zmb_racinstripes_attract";
			break;

		case "perk_machine_fwoosh":
			var_03 = "mus_zmb_trailblazer_attract";
			break;

		case "perk_machine_smack":
			var_03 = "mus_zmb_slappytaffy_attract";
			break;

		case "perk_machine_zap":
			var_03 = "mus_zmb_bluebolts_attract";
			break;

		case "perk_machine_boom":
			var_03 = "mus_zmb_bombstoppers_attract";
			break;

		case "perk_machine_deadeye":
			var_03 = "mus_zmb_deadeye_attract";
			break;

		case "perk_machine_change":
			var_03 = "mus_zmb_changechews_attract";
			break;
	}

	level scripts\cp\_music_and_dialog::func_1752(var_03,self.var_CA48.origin + (0,0,50),120,120,250000,100,10);
	if(isdefined(self.var_D71C) && self.var_D71C == "disco_bottom")
	{
		var_04 = spawn("script_origin",(-1647,3091,1236));
		playsoundatpos((-1647,3091,1236),"power_buy_neon_vending_turn_on");
		wait(0.05);
		var_04 playloopsound("power_buy_neon_vending_lp");
	}

	if(isdefined(self.var_1B9))
	{
		var_05 = 1;
		if(isdefined(self.var_1B9.var_EDED))
		{
			var_05 = self.var_1B9.var_EDED;
		}

		for(var_06 = 0;var_06 < 4;var_06++)
		{
			self.var_1B9 setlightintensity(var_05);
			if(isdefined(self.var_CA48))
			{
				self.var_CA48 setscriptablepartstate("perk_sign","powered_on");
			}

			wait(randomfloat(1));
			if(isdefined(self.var_CA48))
			{
				self.var_CA48 setscriptablepartstate("perk_sign","off");
			}

			self.var_1B9 setlightintensity(0);
			wait(randomfloat(1));
		}

		var_05 = 1;
		if(isdefined(self.var_1B9.var_EDED))
		{
			var_05 = self.var_1B9.var_EDED;
		}

		self.var_1B9 setlightintensity(var_05);
	}

	if(isdefined(self.var_CA48))
	{
		self.var_CA48 setscriptablepartstate("perk_sign","powered_on");
	}

	if(self.var_CA4C == "perk_machine_revive")
	{
		wait(1);
		self.var_CA48 setscriptablepartstate("perk_sign","up");
	}

	if(self.var_CA4C == "perk_machine_change")
	{
		delay_rotate_func(10);
	}
}

//Function Number: 21
func_1295E()
{
	if(isdefined(self.var_1B9))
	{
		self.var_1B9 setlightintensity(0);
	}

	self.var_D776 = 0;
}

//Function Number: 22
func_96C6()
{
	self.var_CA4C = self.script_noteworthy;
	self.var_A921 = [];
	var_00 = func_7831(self.var_CA4C);
	self.var_CA48 = scripts\common\utility::getclosest(self.origin,var_00);
	if(isdefined(self.var_CA48))
	{
		self.var_CA48 setscriptablepartstate("perk_sign","off");
		self.var_CA48 method_8318(1);
	}
}

//Function Number: 23
func_7831(param_00)
{
	var_01 = "";
	switch(param_00)
	{
		case "perk_machine_revive":
			var_01 = "perk_machine_up_n_atoms_sign";
			break;

		case "perk_machine_tough":
			var_01 = "perk_machine_tuff_nuff_sign";
			break;

		case "perk_machine_run":
			var_01 = "perk_machine_racin_stripes_sign";
			break;

		case "perk_machine_flash":
			var_01 = "perk_machine_quickies_sign";
			break;

		case "perk_machine_more":
			var_01 = "perk_machine_mule_munchies_sign";
			break;

		case "perk_machine_rat_a_tat":
			var_01 = "perk_machine_bang_bangs_sign";
			break;

		case "perk_machine_boom":
			var_01 = "perk_machine_bombstoppers_sign";
			break;

		case "perk_machine_zap":
			var_01 = "perk_machine_blue_bolts_sign";
			break;

		case "perk_machine_fwoosh":
			var_01 = "perk_machine_trail_blazers_sign";
			break;

		case "perk_machine_smack":
			var_01 = "perk_machine_slappy_taffy_sign";
			break;

		case "perk_machine_deadeye":
			var_01 = "perk_machine_deadeye_sign";
			break;

		case "perk_machine_change":
			var_01 = "perk_machine_change_chews_sign";
			break;

		default:
			break;
	}

	return getscriptablearray(var_01,"targetname");
}

//Function Number: 24
func_15DE(param_00,param_01)
{
	param_01 endon("disconnect");
	var_02 = [];
	if(isdefined(param_00.script_noteworthy))
	{
		var_02 = strtok(param_00.script_noteworthy,"_");
	}

	if(isdefined(param_00.var_A921) && isdefined(param_00.var_A921[param_01.name]))
	{
		return;
	}

	var_03 = scripts\common\utility::istrue(var_02[0] == "crafted");
	if(!var_03 && param_01 scripts\cp\_utility::has_zombie_perk(param_00.var_CA4C))
	{
		if(soundexists("perk_machine_remove_perk"))
		{
			param_01 playlocalsound("perk_machine_remove_perk");
		}

		if(param_00.var_CA4C == "perk_machine_revive")
		{
			param_01.var_F1E7--;
		}

		param_01 func_1145C(param_00.var_CA4C);
		param_01 scripts\cp\_interaction::func_DE6E();
		return;
	}

	if(isdefined(param_01.var_13FA4) && param_01.var_13FA4.size > 4 && !scripts\common\utility::istrue(param_01.have_gns_perk))
	{
		return;
	}

	if(param_01 scripts\cp\_utility::has_zombie_perk(param_00.var_CA4C))
	{
		return;
	}

	level thread func_1295C(param_00,param_01,2000);
	level thread func_CDC2(param_00,param_01);
	scripts\cp\_vo::func_E01F("dj_perkstation_use_nag");
	if(param_01 scripts\cp\_utility::func_9BA0("perk_refund") && !var_03)
	{
		param_01 scripts\cp\_persistence::func_82F9(1000,undefined,undefined,1,"bonus");
		param_01 scripts\cp\_utility::func_C151("perk_refund");
	}

	param_01 func_CDC0(param_00.var_CA4C);
	param_01 func_834E(param_00.var_CA4C,1);
}

//Function Number: 25
activate_perk_machine_gesture_second(param_00,param_01)
{
	param_01 endon("disconnect");
	var_02 = [];
	if(isdefined(param_00.script_noteworthy))
	{
		var_02 = strtok(param_00.script_noteworthy,"_");
	}

	if(isdefined(param_00.var_A921) && isdefined(param_00.var_A921[param_01.name]))
	{
		return;
	}

	var_03 = scripts\common\utility::istrue(var_02[0] == "crafted");
	if(!var_03 && param_01 scripts\cp\_utility::has_zombie_perk(param_00.var_CA4C))
	{
		if(soundexists("perk_machine_remove_perk"))
		{
			param_01 playlocalsound("perk_machine_remove_perk");
		}

		if(param_00.var_CA4C == "perk_machine_revive")
		{
			param_01.var_F1E7--;
		}

		param_01 func_1145C(param_00.var_CA4C);
		param_01 scripts\cp\_interaction::func_DE6E();
		return;
	}

	if(isdefined(param_01.var_13FA4) && param_01.var_13FA4.size > 4)
	{
		return;
	}

	if(param_01 scripts\cp\_utility::has_zombie_perk(param_00.var_CA4C))
	{
		return;
	}

	level thread func_1295C(param_00,param_01,2000);
	level thread func_CDC2(param_00,param_01);
	scripts\cp\_vo::func_E01F("dj_perkstation_use_nag");
	if(param_01 scripts\cp\_utility::func_9BA0("perk_refund") && !var_03)
	{
		param_01 scripts\cp\_persistence::func_82F9(1000,undefined,undefined,1,"bonus");
		param_01 scripts\cp\_utility::func_C151("perk_refund");
	}

	param_01 func_834E(param_00.var_CA4C,1);
	wait(1);
	param_01 func_CDC0(param_00.var_CA4C);
}

//Function Number: 26
func_834E(param_00,param_01)
{
	if(!isdefined(self.var_13FA4))
	{
		self.var_13FA4 = [];
	}

	self.var_13FA4[param_00] = 1;
	scripts\cp\zombies\zombie_analytics::func_AF80(level.wave_num,param_00);
	scripts\cp\_persistence::increment_player_career_perks_used(self);
	self [[ level.var_462C[param_00].var_F286 ]]();
	if(isdefined(self.sub_perks) && isdefined(self.sub_perks[param_00]))
	{
		param_00 = self.sub_perks[param_00];
	}

	thread func_F5DC(param_00);
	if(scripts\common\utility::istrue(param_01))
	{
		scripts\cp\_merits::func_D9AD("mt_purchase_perks");
	}

	if(isdefined(level.additional_give_perk))
	{
		self [[ level.additional_give_perk ]](param_00);
	}

	return 1;
}

//Function Number: 27
give_zombies_perk_immediate(param_00,param_01)
{
	if(scripts\cp\_utility::has_zombie_perk(param_00))
	{
		return;
	}

	if(!isdefined(self.var_13FA4))
	{
		self.var_13FA4 = [];
	}

	self.var_13FA4[param_00] = 1;
	self [[ level.var_462C[param_00].var_F286 ]]();
	if(isdefined(self.sub_perks) && isdefined(self.sub_perks[param_00]))
	{
		param_00 = self.sub_perks[param_00];
	}

	if(scripts\common\utility::istrue(param_01))
	{
		thread func_F5DC(param_00);
	}

	return 1;
}

//Function Number: 28
func_CDC2(param_00,param_01)
{
	var_02 = [];
	var_03 = "";
	switch(param_00.name)
	{
		case "perk_machine_revive":
			var_02 = ["mus_zmb_upnatoms_purchase"];
			if(level.players.size < 2)
			{
				var_03 = "purchase_perk_revive_solo";
			}
			else
			{
				var_03 = "purchase_perk_upnatoms";
			}
			break;

		case "perk_machine_more":
			var_02 = ["mus_zmb_mulemunchies_purchase"];
			var_03 = "purchase_perk_nulemunchies";
			break;

		case "perk_machine_run":
			var_02 = ["mus_zmb_racinstripes_purchase"];
			var_03 = "purchase_perk_racinstripes";
			break;

		case "perk_machine_flash":
			var_02 = ["mus_zmb_quickies_purchase"];
			var_03 = "purchase_perk_quickies";
			break;

		case "perk_machine_tough":
			var_02 = ["mus_zmb_tuffnuff_purchase"];
			var_03 = "purchase_perk_tuffnuff";
			break;

		case "perk_machine_rat_a_tat":
			var_02 = ["mus_zmb_bangbangs_purchase"];
			var_03 = "purchase_perk_bangbangs";
			break;

		case "perk_machine_fwoosh":
			var_02 = ["mus_zmb_trailblazer_purchase"];
			var_03 = "purchase_perk_trailblazers";
			break;

		case "perk_machine_smack":
			var_02 = ["mus_zmb_slappytaffy_purchase"];
			var_03 = "purchase_perk_slappytaffy";
			break;

		case "perk_machine_boom":
			var_02 = ["mus_zmb_bombstoppers_purchase"];
			var_03 = "purchase_perk_bombstoppers";
			break;

		case "perk_machine_zap":
			var_02 = ["mus_zmb_bluebolts_purchase"];
			var_03 = "purchase_perk_bluebolts";
			break;

		case "perk_machine_deadeye":
			var_02 = ["mus_zmb_deadeye_purchase"];
			var_03 = "purchase_perk_deadeyedewdrop";
			break;

		case "perk_machine_change":
			var_02 = ["mus_zmb_changechews_purchase"];
			var_03 = "purchase_perk_changechews";
			break;
	}

	param_01 thread scripts\cp\_vo::try_to_play_vo(var_03,"zmb_comment_vo","low",10,0,1,0,50);
	param_01 thread play_perk_vo_additional(var_03);
	if(!var_02.size)
	{
		return undefined;
	}

	var_04 = scripts\common\utility::random(var_02);
	if(isdefined(var_04) && soundexists(var_04))
	{
		playsoundatpos(param_00.origin,var_04);
		var_05 = lookupsoundlength(var_04);
		wait(var_05 / 1000);
	}
}

//Function Number: 29
play_perk_vo_additional(param_00)
{
	wait(scripts\cp\_vo::func_7C76(self.var_134FD + param_00) + 5);
	thread scripts\cp\_vo::try_to_play_vo("purchase_perk","zmb_comment_vo");
}

//Function Number: 30
func_CDC1(param_00,param_01)
{
	if(soundexists("perk_machine_deny"))
	{
		param_01 playlocalsound("perk_machine_deny");
	}
}

//Function Number: 31
func_F5DC(param_00)
{
	var_01 = tablelookup("cp/zombies/zombie_perks_bit_mask_table.csv",1,param_00,0);
	var_02 = int(var_01);
	self setclientomnvarbit("zm_active_perks",var_02 - 1,1);
}

//Function Number: 32
func_CDC0(param_00)
{
	if(isdefined(self.disableplunger) || isdefined(self.disablecrank))
	{
		self notify("end_cutie_gesture_loop");
		wait(0.05);
	}

	self playlocalsound("perk_purchase_foley_candy_box");
	self.playingperkgesture = 1;
	var_01 = "iw7_candybang_zm";
	switch(param_00)
	{
		case "perk_machine_boom":
			var_01 = "iw7_candybomb_zm";
			break;

		case "perk_machine_zap":
			var_01 = "iw7_candyblue_zm";
			break;

		case "perk_machine_fwoosh":
			var_01 = "iw7_candytrail_zm";
			break;

		case "perk_machine_revive":
			var_01 = "iw7_candyup_zm";
			break;

		case "perk_machine_flash":
			var_01 = "iw7_candyquickies_zm";
			break;

		case "perk_machine_tough":
			var_01 = "iw7_candytuff_zm";
			break;

		case "perk_machine_smack":
			var_01 = "iw7_candyslappy_zm";
			break;

		case "perk_machine_more":
			var_01 = "iw7_candymule_zm";
			break;

		case "perk_machine_run":
			var_01 = "iw7_candyracin_zm";
			break;

		case "perk_machine_rat_a_tat":
			var_01 = "iw7_candybang_zm";
			break;

		case "perk_machine_deadeye":
			var_01 = "iw7_candydeadeye_zm";
			break;

		case "perk_machine_change":
			var_01 = "iw7_candychange_zm";
			break;
	}

	thread scripts\cp\_utility::firegesturegrenade(self,var_01);
	while(self method_8115() == var_01)
	{
		wait(0.1);
	}

	self.playingperkgesture = undefined;
}

//Function Number: 33
func_1145C(param_00)
{
	if(!scripts\cp\_utility::has_zombie_perk(param_00))
	{
		return 0;
	}

	var_01 = param_00;
	if(isdefined(self.sub_perks) && isdefined(self.sub_perks[param_00]))
	{
		var_01 = self.sub_perks[param_00];
	}

	scripts\cp\zombies\zombie_analytics::func_AF81(level.wave_num,param_00);
	self [[ level.var_462C[param_00].var_12BF4 ]]();
	var_02 = tablelookup("cp/zombies/zombie_perks_bit_mask_table.csv",1,var_01,0);
	var_03 = int(var_02);
	self setclientomnvarbit("zm_active_perks",var_03 - 1,0);
	if(isdefined(level.take_perks_func))
	{
		self [[ level.take_perks_func ]](param_00);
	}

	return 1;
}

//Function Number: 34
sawblade_perk_animation()
{
	self setclientomnvar("zombie_coaster_ticket_earned",1);
	wait(3);
	self setclientomnvar("zombie_coaster_ticket_earned",-1);
}

//Function Number: 35
take_zombies_perk_immediate(param_00)
{
	if(!scripts\cp\_utility::has_zombie_perk(param_00))
	{
		return 0;
	}

	self [[ level.var_462C[param_00].var_12BF4 ]]();
	var_01 = param_00;
	if(isdefined(self.sub_perks) && isdefined(self.sub_perks[param_00]))
	{
		var_01 = self.sub_perks[param_00];
	}

	var_02 = tablelookup("cp/zombies/zombie_perks_bit_mask_table.csv",1,var_01,0);
	var_03 = int(var_02);
	self setclientomnvarbit("zm_active_perks",var_03 - 1,0);
	return 1;
}

//Function Number: 36
func_9011(param_00,param_01)
{
	if(!scripts\common\utility::istrue(param_00.var_D776))
	{
		if(isdefined(level.needspowerstring))
		{
			return level.needspowerstring;
		}
		else
		{
			return &"COOP_INTERACTIONS_REQUIRES_POWER";
		}
	}

	if(isdefined(param_00.var_A921) && isdefined(param_00.var_A921[param_01.name]))
	{
		return "";
	}

	if(param_01 scripts\cp\_utility::has_zombie_perk(param_00.var_CA4C))
	{
		return &"COOP_PERK_MACHINES_REMOVE_PERK";
	}

	if(isdefined(self.var_13FA4) && self.var_13FA4.size > 4 && !scripts\common\utility::istrue(self.have_gns_perk))
	{
		return &"COOP_PERK_MACHINES_PERK_SLOTS_FULL";
	}

	if(param_00.script_noteworthy == "perk_machine_revive" && scripts\cp\_utility::isplayingsolo() || level.only_one_player)
	{
		return &"COOP_PERK_MACHINES_SELF_REVIVE";
	}

	return level.interaction_hintstrings[param_00.script_noteworthy];
}

//Function Number: 37
func_1295C(param_00,param_01,param_02)
{
	var_03 = gettime();
	param_00.var_A921[param_01.name] = var_03;
	while(gettime() - var_03 < param_02)
	{
		wait(0.1);
	}

	param_00.var_A921[param_01.name] = undefined;
}

//Function Number: 38
func_8341()
{
	level notify("tough_purchased",self);
	self.var_CA2F["health"].var_B43C = 200;
	self.maxhealth = self.var_CA2F["health"].var_B43C;
	self.health = self.maxhealth;
	self notify("health_perk_upgrade");
}

//Function Number: 39
func_11458()
{
	self.var_CA2F["health"].var_B43C = 100;
	if(self.health > self.var_CA2F["health"].var_B43C)
	{
		self.health = self.var_CA2F["health"].var_B43C;
	}

	self.maxhealth = self.var_CA2F["health"].var_B43C;
	func_E0B3("perk_machine_tough");
}

//Function Number: 40
func_8327()
{
	if((scripts\cp\_utility::isplayingsolo() || level.only_one_player) && self.var_F1E7 < self.max_self_revive_machine_use)
	{
		scripts\cp\_laststand::func_F44A(self,1);
		thread func_B2E6();
		self.var_F1E7++;
		return;
	}

	self.var_CA2F["medic"].var_E4A5 = 2;
}

//Function Number: 41
func_187B()
{
	self endon("turn_off_self_revive");
	self endon("self_revive_removed");
	for(;;)
	{
		level scripts\common\utility::waittill_any_3("player_spawned","disconnected");
		self notify("remove_self_revive");
	}
}

//Function Number: 42
func_B2E6()
{
	self endon("turn_off_self_revive");
	var_00 = scripts\common\utility::func_13734("last_stand","death","remove_self_revive");
	if(var_00 == "last_stand")
	{
		self waittill("revive");
		func_1145C("perk_machine_revive");
	}
	else
	{
		func_1145C("perk_machine_revive");
	}

	self notify("self_revive_removed");
}

//Function Number: 43
func_1144F()
{
	if(!scripts\cp\_utility::isplayingsolo() && !level.only_one_player)
	{
		self.var_CA2F["medic"].var_E4A5 = 1;
	}
	else if(scripts\cp\_utility::isplayingsolo() || level.only_one_player)
	{
		scripts\cp\_laststand::func_F44A(self,0);
	}

	func_E0B3("perk_machine_revive");
}

//Function Number: 44
func_12E1D()
{
	foreach(var_01 in level.players)
	{
		if(var_01 scripts\cp\_utility::has_zombie_perk("perk_machine_revive"))
		{
			var_01 notify("turn_off_self_revive");
			var_01 scripts\cp\_laststand::func_F44A(var_01,0);
			var_01.var_CA2F["medic"].var_E4A5 = 2;
		}
	}
}

//Function Number: 45
give_deadeye_perk()
{
	self.old_view_kick_scale = self getviewkickscale();
	self setviewkickscale(0);
	self player_recoilscaleon(0);
	self method_829B(0.1);
	self.var_C53B = 1;
	scripts\cp\_utility::func_8387("specialty_quickdraw");
	scripts\cp\_utility::func_8387("specialty_bulletaccuracy");
	scripts\cp\_utility::func_13D1("specialty_autoaimhead");
	thread run_deadeye_charge_watcher();
}

//Function Number: 46
take_deadeye_perk()
{
	self setviewkickscale(self.old_view_kick_scale);
	self player_recoilscaleon(100);
	self method_829B(1);
	self.var_C53B = undefined;
	scripts\cp\_utility::func_1430("specialty_quickdraw");
	scripts\cp\_utility::func_1430("specialty_autoaimhead");
	scripts\cp\_utility::func_1430("specialty_bulletaccuracy");
	self notify("end_deadeye_charge_watcher");
	self.deadeye_charge = undefined;
	func_E0B3("perk_machine_deadeye");
}

//Function Number: 47
run_deadeye_charge_watcher()
{
	self endon("disconnect");
	self endon("end_deadeye_charge_watcher");
	self.deadeye_charge = undefined;
	var_00 = undefined;
	var_01 = undefined;
	for(;;)
	{
		var_02 = scripts\cp\_utility::getweapontoswitchbackto();
		var_03 = func_9B58(var_02);
		if(self adsbuttonpressed() && !scripts\common\utility::istrue(self.no_deadeye) && !var_03)
		{
			var_04 = gettime();
			if(!isdefined(var_00))
			{
				var_00 = var_04;
				var_01 = var_04 + 2000;
			}
			else if(var_04 > var_01)
			{
				if(!scripts\common\utility::istrue(self.deadeye_charge))
				{
					self setclientomnvar("damage_feedback","pink_arcane_cp");
					self setclientomnvar("damage_feedback_notify",gettime());
					self playlocalsound("gauntlet_armory_hack_wrist_second");
				}

				self.deadeye_charge = 1;
			}
		}
		else
		{
			self.deadeye_charge = undefined;
			var_00 = undefined;
			var_01 = undefined;
		}

		scripts\common\utility::func_136F7();
	}
}

//Function Number: 48
give_change_perk()
{
	var_00 = randomintrange(1,5);
	self.sub_perks["perk_machine_change"] = "perk_machine_change" + var_00;
	thread wait_for_change_chews_update();
}

//Function Number: 49
take_change_perk()
{
	self notify("stop_change_chews_update");
	self.sub_perks["perk_machine_change"] = undefined;
	func_E0B3("perk_machine_change");
}

//Function Number: 50
wait_for_change_chews_update()
{
	self endon("stop_change_chews_update");
	self endon("disconnect");
	for(;;)
	{
		self waittill("change_chews_damage",var_00,var_01);
		if(var_01 > 30)
		{
			continue;
		}

		if(scripts\common\utility::istrue(self.playing_ghosts_n_skulls))
		{
			continue;
		}

		if(isdefined(self.sub_perks) && isdefined(self.sub_perks["perk_machine_change"]))
		{
			var_02 = self.sub_perks["perk_machine_change"];
			var_03 = tablelookup("cp/zombies/zombie_perks_bit_mask_table.csv",1,var_02,0);
			var_04 = int(var_03);
			self setclientomnvarbit("zm_active_perks",var_04 - 1,0);
		}

		update_change_chews_sub_perk();
		if(isdefined(self.sub_perks) && isdefined(self.sub_perks["perk_machine_change"]))
		{
			var_02 = self.sub_perks["perk_machine_change"];
			thread func_F5DC(var_02);
		}

		while(self.health < 31)
		{
			wait(0.1);
		}

		wait(0.1);
	}
}

//Function Number: 51
update_change_chews_sub_perk()
{
	var_00 = self.sub_perks["perk_machine_change"];
	var_01 = 1;
	switch(var_00)
	{
		case "perk_machine_change1":
			var_01 = 1;
			break;

		case "perk_machine_change2":
			var_01 = 2;
			break;

		case "perk_machine_change3":
			var_01 = 3;
			break;

		case "perk_machine_change4":
			var_01 = 4;
			break;

		default:
			break;
	}

	var_02 = var_01 + 1;
	if(var_02 > 4)
	{
		var_02 = 1;
	}

	self.sub_perks["perk_machine_change"] = "perk_machine_change" + var_02;
}

//Function Number: 52
change_chew_explosion(param_00,param_01,param_02,param_03,param_04,param_05)
{
	var_06 = scripts\common\utility::func_9D74(param_03) || param_03 == "MOD_EXPLOSIVE_BULLET" && param_05 != "none";
	if(!var_06)
	{
		return;
	}

	if(!scripts\cp\_utility::func_9E27(param_04,param_05,param_03,param_00))
	{
		return;
	}

	if(!isdefined(self.agent_type) || self.agent_type != "generic_zombie")
	{
		return;
	}

	thread func_6996(param_00,param_05,param_02,undefined,undefined);
}

//Function Number: 53
func_6995(param_00,param_01,param_02,param_03)
{
	var_04 = scripts\cp\_utility::func_13C90(param_03,"pap1") || scripts\cp\_utility::func_13C90(param_03,"pap2");
	var_05 = param_03;
	var_06 = [];
	var_06 = level.spawned_enemies;
	var_07 = [param_02];
	var_08 = 150;
	if(var_04)
	{
		var_08 = 300;
	}

	var_09 = scripts\common\utility::func_782F(param_01,var_06,var_07,undefined,var_08,0);
	foreach(var_0B in var_09)
	{
		if(isdefined(var_0B.agent_type) && var_0B.agent_type == "crab_mini" || var_0B.agent_type == "crab_brute")
		{
			var_0C = 100;
		}
		else
		{
			var_0C = 100000;
		}

		var_0B dodamage(var_0C,param_01,param_00,param_00,"MOD_EXPLOSIVE",var_05);
	}
}

//Function Number: 54
func_6996(param_00,param_01,param_02,param_03,param_04)
{
	self.head_is_exploding = 1;
	param_04 = self gettagorigin("J_Spine4");
	foreach(var_06 in level.players)
	{
		if(distance(var_06.origin,param_04) <= 350)
		{
			var_06 thread scripts\cp\zombies\zmb_zombies_weapons::func_10142();
		}
	}

	if(isdefined(self.var_8C98))
	{
		self detach(self.var_8C98);
	}

	self setscriptablepartstate("head","hide");
}

//Function Number: 55
func_82CD()
{
	level notify("quickies_purchased",self);
	scripts\cp\_utility::func_8387("specialty_fastreload");
	scripts\cp\_utility::func_8387("specialty_quickswap");
}

//Function Number: 56
func_11437()
{
	scripts\cp\_utility::func_1430("specialty_fastreload");
	scripts\cp\_utility::func_1430("specialty_quickswap");
	func_E0B3("perk_machine_flash");
}

//Function Number: 57
func_82EE()
{
	self.var_CA2F["pistol"].var_CBDB = 1;
	thread func_AD5A();
}

//Function Number: 58
func_AD5A()
{
	self endon("mule_munchies_sold");
	self endon("disconnect");
	for(;;)
	{
		self waittill("weapon_change");
		var_00 = self getcurrentprimaryweapon();
		var_01 = func_78F5();
		if(var_01.size > 3)
		{
			var_00 = self getcurrentprimaryweapon();
			if(var_00 == var_01[var_01.size - 1])
			{
				self setclientomnvar("zm_mule_munchies_weapon_icon",1);
				self.mule_weapon = var_00;
			}
			else
			{
				self setclientomnvar("zm_mule_munchies_weapon_icon",0);
			}

			continue;
		}

		self setclientomnvar("zm_mule_munchies_weapon_icon",0);
	}
}

//Function Number: 59
func_11441()
{
	self.var_CA2F["pistol"].var_CBDB = 0;
	var_00 = func_78F5();
	var_01 = 0;
	var_02 = scripts\cp\_utility::getvalidtakeweapon();
	if(var_00.size > 3)
	{
		var_03 = var_00[var_00.size - 1];
		if(var_03 == var_02)
		{
			var_01 = 1;
		}

		self takeweapon(var_03);
		if(var_01)
		{
			self method_83B6(var_00[var_00.size - 2]);
		}
	}

	self.mule_weapon = undefined;
	scripts\cp\_utility::func_12EBE();
	func_E0B3("perk_machine_more");
	self notify("mule_munchies_sold");
	self setclientomnvar("zm_mule_munchies_weapon_icon",0);
}

//Function Number: 60
func_78F5()
{
	var_00 = [];
	var_01 = self getweaponslistprimaries();
	for(var_02 = 0;var_02 < var_01.size;var_02++)
	{
		if(var_01[var_02] == "iw7_gunless_zm")
		{
			continue;
		}

		if(var_01[var_02] == "iw7_entangler_zm")
		{
			continue;
		}

		if(var_01[var_02] == "iw7_entangler2_zm")
		{
			continue;
		}

		var_03 = strtok(var_01[var_02],"_");
		if(var_03[0] != "alt")
		{
			var_00[var_00.size] = var_01[var_02];
		}
	}

	return var_00;
}

//Function Number: 61
func_8326()
{
	level notify("bangbangs_purchased",self);
	self.var_CA2F["damagemod"].var_3237 = 2;
	var_00 = self getweaponslistprimaries();
	var_01 = scripts\cp\_utility::getweapontoswitchbackto();
	foreach(var_03 in var_00)
	{
		if(issubstr(var_03,"alt") || issubstr(var_03,"knife") || issubstr(var_03,"entangler"))
		{
			continue;
		}

		var_04 = function_00E3(var_03);
		var_05 = scripts\cp\_utility::getcurrentcamoname(var_03);
		var_06 = scripts\cp\_weapon::func_E469(var_03,"doubletap",var_04,1,var_05);
		var_07 = func_9B58(var_06);
		if(isdefined(var_06))
		{
			var_08 = undefined;
			var_09 = undefined;
			var_0A = self getweaponammoclip(var_03);
			var_0B = self getweaponammostock(var_03);
			if(var_07)
			{
				var_08 = self getweaponammoclip(var_03,"left");
				var_09 = self getweaponammoclip(var_03,"right");
			}

			self takeweapon(var_03);
			var_06 = scripts\cp\_utility::func_12C6(var_06,undefined,undefined,1);
			if(var_07)
			{
				if(issubstr(var_06,"akimbofmg"))
				{
					self setweaponammoclip(var_06,var_08 + var_09);
				}
				else
				{
					self setweaponammoclip(var_06,var_08,"left");
					self setweaponammoclip(var_06,var_09,"right");
				}
			}
			else
			{
				self setweaponammoclip(var_06,var_0A);
			}

			self setweaponammostock(var_06,var_0B);
			if(getweaponbasename(var_06) == getweaponbasename(var_01))
			{
				var_01 = var_06;
			}
		}
	}

	if(!scripts\common\utility::istrue(self.kung_fu_mode))
	{
		self method_83B6(var_01);
	}
}

//Function Number: 62
func_9B58(param_00)
{
	if(!isdefined(param_00))
	{
		return 0;
	}

	var_01 = issubstr(param_00,"akimbo");
	if(!var_01)
	{
		var_01 = issubstr(param_00,"g18pap2");
	}

	return var_01;
}

//Function Number: 63
func_1144D()
{
	self.var_CA2F["damagemod"].var_3237 = 1;
	func_E0B3("perk_machine_rat_a_tat");
	if(isdefined(level.mode_weapons_allowed) && scripts\common\utility::func_2286(level.mode_weapons_allowed,getweaponbasename(self getcurrentweapon())))
	{
		var_00 = self getcurrentweapon();
	}
	else
	{
		var_00 = self getcurrentprimaryweapon();
	}

	var_01 = self getweaponslistprimaries();
	self.bang_bangs = 1;
	foreach(var_03 in var_01)
	{
		if(issubstr(var_03,"alt") || issubstr(var_03,"knife"))
		{
			continue;
		}

		if(scripts\common\utility::func_2286(level.additional_laststand_weapon_exclusion,var_03))
		{
			continue;
		}

		var_04 = func_9B58(var_03);
		var_05 = self getweaponammostock(var_03);
		var_06 = self getweaponammoclip(var_03);
		var_07 = undefined;
		var_08 = undefined;
		if(var_04)
		{
			var_07 = self getweaponammoclip(var_03,"left");
			var_08 = self getweaponammoclip(var_03,"right");
		}

		self takeweapon(var_03);
		var_09 = function_00E3(var_03);
		var_0A = scripts\cp\_utility::getcurrentcamoname(var_03);
		if(scripts\common\utility::func_2286(var_09,"doubletap"))
		{
			var_09 = scripts\common\utility::func_22A9(var_09,"doubletap");
		}

		if(scripts\common\utility::func_2286(self.var_E603,getweaponbasename(var_03)))
		{
			var_09[var_09.size] = "rof";
		}

		var_0B = scripts\cp\_weapon::func_E469(var_03,undefined,var_09,undefined,var_0A);
		var_0B = scripts\cp\_utility::func_12C6(var_0B,undefined,undefined,1);
		if(isdefined(var_0B))
		{
			if(var_04)
			{
				if(issubstr(var_0B,"akimbofmg"))
				{
					self setweaponammoclip(var_0B,var_07 + var_08);
				}
				else
				{
					self setweaponammoclip(var_0B,var_07,"left");
					self setweaponammoclip(var_0B,var_08,"right");
				}
			}
			else
			{
				self setweaponammoclip(var_0B,var_06);
			}

			self setweaponammostock(var_0B,var_05);
		}

		if(getweaponbasename(var_0B) == getweaponbasename(var_00))
		{
			var_00 = var_0B;
		}
	}

	self switchtoweapon(var_00);
	self.bang_bangs = undefined;
}

//Function Number: 64
func_E7E8()
{
	self endon("remove_perk_icon_perk_machine_rat_a_tat");
	for(;;)
	{
		self waittill("weapon_fired");
		var_00 = self getcurrentweapon();
		var_01 = self method_8118();
		var_01 = var_01 - 1;
		self setweaponammoclip(var_00,var_01);
	}
}

//Function Number: 65
func_832B()
{
	level notify("racingstripes_purchased",self);
	scripts\cp\_utility::func_8387("specialty_longersprint");
	scripts\cp\_utility::func_8387("specialty_sprintfire");
	if(isdefined(level.player_run_suit))
	{
		self method_845A(level.player_run_suit);
		return;
	}

	self method_845A("zom_suit_sprint");
}

//Function Number: 66
func_11451()
{
	scripts\cp\_utility::func_1430("specialty_longersprint");
	scripts\cp\_utility::func_1430("specialty_sprintfire");
	if(isdefined(level.player_suit))
	{
		self method_845A(level.player_suit);
	}
	else
	{
		self method_845A("zom_suit");
	}

	func_E0B3("perk_machine_run");
}

//Function Number: 67
func_82CE()
{
	thread func_E7FA();
}

//Function Number: 68
func_11438()
{
	func_E0B3("perk_machine_fwoosh");
}

//Function Number: 69
func_E7FA()
{
	self endon("disconnect");
	self endon("remove_perk_icon_perk_machine_fwoosh");
	for(;;)
	{
		self waittill("sprint_slide_begin");
		func_48E9(300);
		var_00 = scripts\common\utility::waittill_notify_or_timeout_return("energy_replenished",5);
	}
}

//Function Number: 70
func_8331()
{
	level notify("slappytaffy_purchased",self);
}

//Function Number: 71
func_11453()
{
	func_E0B3("perk_machine_smack");
}

//Function Number: 72
func_834D()
{
	thread func_E82F();
}

//Function Number: 73
func_1145B()
{
	func_E0B3("perk_machine_zap");
}

//Function Number: 74
func_82A7()
{
}

//Function Number: 75
func_1142B()
{
	func_E0B3("perk_machine_boom");
}

//Function Number: 76
func_E82F()
{
	self endon("disconnect");
	self endon("remove_perk_icon_perk_machine_zap");
	self.wait_on_reload = [];
	self.consecutive_zap_attacks = 0;
	for(;;)
	{
		self waittill("reload_start");
		var_00 = self getcurrentweapon();
		var_01 = weaponclipsize(var_00);
		var_02 = self getweaponammoclip(var_00);
		var_03 = var_01 - var_02 / var_01;
		var_04 = max(1045 * var_03,10);
		var_05 = max(128 * var_03,48);
		if(scripts\common\utility::func_2286(self.wait_on_reload,var_00))
		{
			continue;
		}

		self.wait_on_reload[self.wait_on_reload.size] = var_00;
		self.consecutive_zap_attacks++;
		thread check_for_reload_complete(var_00);
		if(isdefined(self))
		{
			switch(self.consecutive_zap_attacks)
			{
				case 1:
				case 0:
					var_06 = undefined;
					break;
	
				case 2:
					var_06 = 8;
					break;
	
				case 3:
					var_06 = 4;
					break;
	
				case 4:
					var_06 = 2;
					break;
	
				default:
					var_06 = 0;
					break;
			}

			thread zap_cooldown_timer(var_00);
			if(isdefined(var_06) && var_06 == 0)
			{
				continue;
			}

			func_497F(var_05,var_04);
		}
	}
}

//Function Number: 77
zap_cooldown_timer(param_00)
{
	self notify("zap_cooldown_started");
	self endon("zap_cooldown_started");
	self endon("death");
	self endon("disconnect");
	var_01 = 0.25;
	if(scripts\cp\_utility::has_zombie_perk("perk_machine_flash"))
	{
		var_01 = var_01 * getdvarfloat("perk_weapReloadMultiplier");
	}

	var_02 = var_01 + 3;
	wait(var_02);
	self.consecutive_zap_attacks = 0;
}

//Function Number: 78
check_for_reload_complete(param_00)
{
	self endon("death");
	self endon("disconnect");
	self endon("player_lost_weapon_" + param_00);
	thread weapon_replaced_monitor(param_00);
	for(;;)
	{
		self waittill("reload");
		var_01 = self getcurrentweapon();
		if(var_01 == param_00)
		{
			self.wait_on_reload = scripts\common\utility::func_22A9(self.wait_on_reload,param_00);
			self notify("weapon_reload_complete_" + param_00);
			break;
		}
	}
}

//Function Number: 79
weapon_replaced_monitor(param_00)
{
	self endon("death");
	self endon("disconnect");
	self endon("weapon_reload_complete_" + param_00);
	for(;;)
	{
		self waittill("weapon_purchased");
		var_01 = self getweaponslistprimaries();
		if(!scripts\common\utility::func_693B(var_01,param_00))
		{
			self notify("player_lost_weapon_" + param_00);
			self.wait_on_reload = scripts\common\utility::func_22A9(self.wait_on_reload,param_00);
			break;
		}
	}
}

//Function Number: 80
func_497F(param_00,param_01)
{
	var_02 = anglestoforward(self.angles);
	var_02 = vectornormalize(var_02);
	var_02 = var_02 * 100;
	var_03 = "reload_zap_m";
	if(param_00 < 72)
	{
		var_03 = "reload_zap_s";
	}
	else if(param_00 < 96)
	{
		var_03 = "reload_zap_m";
	}

	playsoundatpos(self.origin,"perk_blue_bolts_sparks");
	playfx(level._effect[var_03],self.origin + var_02);
	var_03 = "reload_zap_screen";
	self notify("blue_bolts_activated");
	foreach(var_05 in level.players)
	{
		if(var_05 == self)
		{
			playfxontagforclients(level._effect[var_03],self,"tag_eye",self);
		}
	}

	wait(0.25);
	self radiusdamage(self.origin,param_00,param_01,param_01,self,"MOD_GRENADE_SPLASH","iw7_bluebolts_zm");
	var_07 = scripts\cp\_agent_utils::func_7DB0("axis");
	var_08 = param_00 * param_00;
	foreach(var_0A in level.spawned_enemies)
	{
		if(!scripts\cp\_utility::func_FF18(var_0A))
		{
			continue;
		}

		if(distancesquared(var_0A.origin,self.origin) < var_08)
		{
			var_0A thread func_13E63(2,self);
		}
	}
}

//Function Number: 81
func_13E63(param_00,param_01)
{
	self endon("death");
	if(!isdefined(self.agent_type))
	{
		return;
	}

	self.var_11196 = 1;
	if(isdefined(level.special_zap_start_func))
	{
		[[ level.special_zap_start_func ]](param_01);
	}

	if(self.agent_type != "alien_phantom" && self.agent_type != "alien_goon" && self.agent_type != "alien_rhino" && self.agent_type != "skeleton")
	{
		thread scripts\cp\zombies\zombie_scriptable_states::applyzombiescriptablestate(self);
	}

	while(param_00 > 0)
	{
		self.var_11190 = gettime() + 1000;
		wait(0.1);
		self dodamage(1,self.origin,param_01,param_01,"MOD_GRENADE_SPLASH","iw7_bluebolts_zm");
		param_00 = param_00 - 1;
		wait(1);
	}

	self.var_11196 = undefined;
	if(isdefined(level.special_zap_end_func))
	{
		[[ level.special_zap_end_func ]](param_01);
	}
}

//Function Number: 82
func_FF6B(param_00,param_01,param_02,param_03,param_04,param_05,param_06,param_07,param_08,param_09,param_0A,param_0B,param_0C,param_0D)
{
	if(param_06 == "iw7_bluebolts_zm")
	{
		if(isdefined(param_02) && isplayer(param_02) && param_02 scripts\cp\_utility::has_zombie_perk("perk_machine_zap"))
		{
			return 0;
		}
	}

	return param_00;
}

//Function Number: 83
func_48E6(param_00)
{
	var_01 = spawn("trigger_radius",param_00,1,72,20);
	var_01.var_127BA = 0;
	var_02 = 1;
	var_03 = self getvelocity();
	var_01.var_7542 = function_01E1(level._effect["fire_cloud_1st"],param_00,self,var_03);
	triggerfx(var_01.var_7542);
	playsoundatpos(var_01.origin,"perk_fwoosh_fire_trail");
	var_01 thread func_3289(self);
	wait(var_02);
	var_01 notify("stop_burn_loop");
	var_01.var_7542 delete();
	var_01 delete();
}

//Function Number: 84
func_48E7(param_00,param_01)
{
	var_02 = spawn("trigger_radius",param_00,1,72,20);
	var_02.var_127BA = 0;
	var_03 = 1;
	var_04 = param_01 getvelocity();
	var_02.var_7542 = function_01E1(level._effect["fire_cloud_3rd"],param_00,self,var_04);
	triggerfx(var_02.var_7542);
	wait(var_03);
	var_02.var_7542 delete();
	var_02 delete();
}

//Function Number: 85
func_48E8(param_00)
{
	self endon("death");
	self endon("sprint_slide_end");
	var_01 = param_00 * param_00;
	var_02 = self.origin;
	var_03 = self.origin;
	var_04 = 36;
	var_05 = var_04 * var_04;
	var_06 = self getvelocity();
	self.var_6E84 = var_06;
	while(distancesquared(self.origin,var_03) < var_01)
	{
		if(distancesquared(self.origin,var_02) > var_05)
		{
			thread func_106F6(self.origin,self.var_6E84);
			var_02 = self.origin;
		}

		scripts\common\utility::func_136F7();
	}
}

//Function Number: 86
func_106F6(param_00,param_01)
{
	var_02 = spawn("trigger_radius",param_00,1,72,20);
	var_02.var_127BA = 0;
	var_03 = 2;
	var_04 = self getvelocity();
	var_05 = length(param_01);
	var_06 = length(var_04);
	if(var_05 != 0 && var_06 != 0)
	{
		var_07 = anglesdelta(param_01,var_04);
		if(var_07 > 10)
		{
			param_01 = param_01 + var_04 / 2;
		}
	}

	self.var_6E84 = param_01;
	var_02.var_7542 = spawnfx(level._effect["fire_trail"],param_00,self.var_6E84);
	triggerfx(var_02.var_7542);
	var_02 thread func_3289(self);
	wait(var_03);
	var_02 notify("stop_burn_loop");
	wait(1);
	var_02.var_7542 delete();
	var_02 delete();
}

//Function Number: 87
func_3289(param_00)
{
	self endon("stop_burn_loop");
	for(;;)
	{
		self waittill("trigger",var_01);
		if(isplayer(var_01))
		{
			continue;
		}

		if(isdefined(var_01.agent_type) && var_01.agent_type == "zombie_brute" || var_01.agent_type == "zombie_grey")
		{
			continue;
		}

		if(isalive(var_01) && !scripts\common\utility::istrue(var_01.var_B36E))
		{
			var_01.var_B36E = 1;
			var_01 thread scripts\cp\_utility::func_4D0D(var_01,param_00,5,1900,undefined,"iw7_fwoosh_zm",0,"burning","fwoosh_kill");
		}
	}
}

//Function Number: 88
func_48E9(param_00)
{
	var_01 = param_00 / 2;
	var_02 = vectornormalize(anglestoforward(self.angles));
	var_03 = var_02 * var_01;
	foreach(var_05 in level.players)
	{
		if(var_05 == self)
		{
			var_05 thread func_48E6(var_05.origin + var_03);
			continue;
		}

		var_05 thread func_48E7(self.origin + var_03,self);
	}

	thread func_48E8(param_00);
}

//Function Number: 89
func_E0B3(param_00)
{
	if(isdefined(self.var_13FA4) && isdefined(self.var_13FA4[param_00]))
	{
		self notify("remove_perk_icon_" + param_00);
		self.var_13FA4[param_00] = undefined;
	}
}

//Function Number: 90
func_E072()
{
	if(!isdefined(self.var_13FA4))
	{
		return;
	}

	if(scripts\common\utility::istrue(self.dontremoveperks))
	{
		return;
	}

	self.var_110B8 = self.var_13FA4;
	var_00 = scripts\cp\_utility::func_9BA0("just_a_flesh_wound");
	if(var_00)
	{
		thread func_5968();
	}

	foreach(var_03, var_02 in self.var_13FA4)
	{
		if(var_00)
		{
			if(scripts\cp\_utility::isplayingsolo() || scripts\common\utility::istrue(level.only_one_player))
			{
				if(var_03 != "perk_machine_revive")
				{
					continue;
				}
			}
			else
			{
				break;
			}
		}

		func_1145C(var_03);
	}
}

//Function Number: 91
func_5968()
{
	self endon("disconnect");
	level endon("game_ended");
	var_00 = scripts\common\utility::func_13734("death","revive");
	scripts\cp\_utility::func_C151("just_a_flesh_wound");
	if(scripts\cp\_utility::isplayingsolo() || level.only_one_player)
	{
		self.keep_perks = 1;
		return;
	}

	if(var_00 == "death")
	{
		self.var_110B8 = self.var_13FA4;
		foreach(var_03, var_02 in self.var_13FA4)
		{
			func_1145C(var_03);
		}
	}
}

//Function Number: 92
func_7924()
{
	return self.var_13FA4;
}

//Function Number: 93
func_12872(param_00)
{
	if(isdefined(param_00.var_110B8) && param_00.var_110B8.size > 0)
	{
		func_E2D6(param_00,param_00.var_110B8);
	}
}

//Function Number: 94
func_E2D6(param_00,param_01)
{
	if(!isdefined(param_01))
	{
		return;
	}

	foreach(var_04, var_03 in param_01)
	{
		param_00 func_834E(var_04,0);
	}
}