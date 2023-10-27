/*******************************************************************
 * Decompiled By: Bog
 * Decompiled File: scripts\mp\killstreaks\_nuke.gsc
 * Game: Call of Duty: Infinite Warfare
 * Platform: PC
 * Function Count: 31
 * Decompile Time: 1557 ms
 * Timestamp: 10/27/2023 12:29:09 AM
*******************************************************************/

//Function Number: 1
init()
{
	level.var_C1D0 = "aftermath_post";
	level._effect["mons_warp_flash"] = loadfx("vfx/iw7/_requests/mp/vfx_vehicle_nuke_warp_flash.vfx");
	level._effect["mons_warp_in"] = loadfx("vfx/iw7/_requests/mp/vfx_vehicle_nuke_warp_in.vfx");
	level._effect["mons_warp_out"] = loadfx("vfx/iw7/_requests/mp/vfx_vehicle_nuke_warp_out.vfx");
	level._effect["mons_laser_charge"] = loadfx("vfx/iw7/_requests/mp/vfx_nuke_build_lgt_ship_belly.vfx");
	level._effect["mons_laser"] = loadfx("vfx/iw7/_requests/mp/vfx_nuke_laser.vfx");
	level._effect["mons_laser_flash"] = loadfx("vfx/iw7/_requests/mp/vfx_nuke_initial_flash.vfx");
	level._effect["mons_laser_smoke"] = loadfx("vfx/iw7/_requests/mp/vfx_nuke_dust_wave.vfx");
	level._effect["mons_screen_ash"] = loadfx("vfx/iw7/_requests/mp/vfx_nuke_cam_att_ashfall.vfx");
	scripts\mp\killstreaks\_killstreaks::func_DEFB("nuke",::func_128F0);
	setdvarifuninitialized("scr_nukeTimer",10);
	setdvarifuninitialized("scr_nukeCancelMode",0);
	level.var_C1CD = getdvarint("scr_nukeTimer");
	level.var_3883 = getdvarint("scr_nukeCancelMode");
	level.var_C1C5 = spawnstruct();
	level.var_C1BB = undefined;
	level.var_C1C3 = undefined;
	level.var_C1B2 = undefined;
	if(!scripts\mp\_utility::func_9FB3(level.var_C1B2))
	{
		level thread func_C56E();
	}
}

//Function Number: 2
func_128F0(param_00)
{
	if(isdefined(level.var_C1C4))
	{
		scripts\mp\_hud_message::func_10122("KILLSTREAKS_NUKE_ALREADY_INBOUND");
		return 0;
	}

	if(scripts\mp\_utility::func_9FC6() && !isdefined(level.var_86AD) || !level.var_86AD)
	{
		return 0;
	}

	thread func_5973(0);
	self notify("used_nuke");
	scripts\mp\_matchdata::func_AFC9("nuke",self.origin);
	return 1;
}

//Function Number: 3
func_512C(param_00,param_01,param_02)
{
	level endon("nuke_cancelled");
	scripts\mp\_hostmigration::func_13708(param_00);
	level thread [[ param_01 ]](param_02);
}

//Function Number: 4
func_5973(param_00)
{
	level endon("nuke_cancelled");
	level.var_C1C5.player = self;
	level.var_C1C5.team = self.pers["team"];
	level.var_C1C4 = 1;
	level.var_C1B2 = undefined;
	level.var_D8C5 = int(getomnvar("ui_bomb_timer"));
	setomnvar("ui_bomb_timer",4);
	thread scripts\mp\_utility::func_115DE("used_nuke",self);
	var_01 = func_108E6();
	if(!isdefined(var_01))
	{
		return;
	}

	var_01 thread func_1395B(self);
	var_01 thread func_1395A();
	var_01 thread func_13959(param_00);
}

//Function Number: 5
func_108E6()
{
	var_00 = level.var_B32E;
	var_01 = 0;
	var_02 = (0,var_01,0);
	var_03 = 24000;
	var_04 = 10000;
	var_05 = 15000;
	var_06 = 5000;
	var_07 = getmonsflightpath(var_00,var_02,var_03,undefined,var_04,var_05,var_06);
	var_08 = var_00 * (1,1,0);
	var_09 = var_08 + (0,0,var_04);
	var_0A = var_07["startPoint"];
	var_0B = vectortoangles(var_09 - var_0A);
	var_0C = spawn("script_model",var_0A);
	var_0C setmodel("veh_mil_air_ca_olympus_mons_mp");
	var_0C.angles = var_0B;
	var_0C.team = self.team;
	var_0C.var_222 = self;
	var_0C.var_C96C = var_09;
	var_0C setcandamage(0);
	var_0C setscriptablepartstate("body","hide",0);
	return var_0C;
}

//Function Number: 6
getmonsflightpath(param_00,param_01,param_02,param_03,param_04,param_05,param_06,param_07)
{
	var_08 = param_00 + anglestoforward(param_01) * -1 * param_02;
	if(isdefined(param_03))
	{
		var_08 = var_08 * (1,1,0);
	}

	var_08 = var_08 + (0,0,param_04);
	var_09 = param_00 + anglestoforward(param_01) * param_02;
	if(isdefined(param_03))
	{
		var_09 = var_09 * (1,1,0);
	}

	var_09 = var_09 + (0,0,param_04);
	var_0A = length(var_08 - var_09);
	var_0B = var_0A / param_05;
	var_0A = abs(var_0A / 2 + param_06);
	var_0C = var_0A / param_05;
	var_0D["startPoint"] = var_08;
	var_0D["endPoint"] = var_09;
	var_0D["bombTime"] = var_0C;
	var_0D["flyTime"] = var_0B;
	return var_0D;
}

//Function Number: 7
func_1395B(param_00)
{
	soundsettimescalefactor("music_lr",0);
	soundsettimescalefactor("music_lsrs",0);
	soundsettimescalefactor("weap_plr_fire_1_2d",0.25);
	soundsettimescalefactor("weap_plr_fire_2_2d",0.25);
	soundsettimescalefactor("weap_plr_fire_3_2d",0.25);
	soundsettimescalefactor("weap_plr_fire_4_2d",0.25);
	soundsettimescalefactor("weap_plr_fire_overlap_2d",0.25);
	soundsettimescalefactor("weap_plr_fire_lfe_2d",0);
	soundsettimescalefactor("weap_plr_fire_alt_1_2d",0.25);
	soundsettimescalefactor("weap_plr_fire_alt_2_2d",0.25);
	soundsettimescalefactor("weap_plr_fire_alt_3_2d",0.25);
	soundsettimescalefactor("weap_plr_fire_alt_4_2d",0.25);
	soundsettimescalefactor("scn_fx_unres_3d",0.15);
	soundsettimescalefactor("scn_fx_unres_2d",0.15);
	soundsettimescalefactor("spear_refl_close_unres_3d_lim",0.15);
	soundsettimescalefactor("spear_refl_unres_3d_lim",0.15);
	soundsettimescalefactor("weap_npc_main_3d",0.15);
	soundsettimescalefactor("weap_npc_mech_3d",0.15);
	soundsettimescalefactor("weap_npc_mid_3d",0.15);
	soundsettimescalefactor("weap_npc_lfe_3d",0);
	soundsettimescalefactor("weap_npc_dist_3d",0.15);
	soundsettimescalefactor("weap_npc_lo_3d",0.15);
	soundsettimescalefactor("melee_npc_3d",0.15);
	soundsettimescalefactor("melee_plr_2d",0.15);
	soundsettimescalefactor("special_hi_unres_1_3d",0.15);
	soundsettimescalefactor("special_lo_unres_1_2d",0);
	soundsettimescalefactor("bulletflesh_npc_1_unres_3d_lim",0.15);
	soundsettimescalefactor("bulletflesh_npc_2_unres_3d_lim",0.15);
	soundsettimescalefactor("bulletflesh_1_unres_3d_lim",0.15);
	soundsettimescalefactor("bulletflesh_2_unres_3d_lim",0.15);
	soundsettimescalefactor("foley_plr_mvmt_unres_2d_lim",0.2);
	soundsettimescalefactor("scn_fx_unres_2d_lim",0.2);
	soundsettimescalefactor("scn_fx_special_unres_2d",0);
	soundsettimescalefactor("menu_1_2d_lim",0);
	soundsettimescalefactor("equip_use_unres_3d",0.15);
	soundsettimescalefactor("explo_1_3d",0.15);
	soundsettimescalefactor("explo_2_3d",0.15);
	soundsettimescalefactor("explo_3_3d",0.15);
	soundsettimescalefactor("explo_4_3d",0.15);
	soundsettimescalefactor("explo_5_3d",0.15);
	soundsettimescalefactor("explo_lfe_3d",0.15);
	soundsettimescalefactor("vehicle_air_loops_3d_lim",0.15);
	soundsettimescalefactor("projectile_loop_close",0.15);
	soundsettimescalefactor("projectile_loop_mid",0.15);
	soundsettimescalefactor("projectile_loop_dist",0.15);
	self endon("nuke_ship_exit");
	level endon("game_ended");
	param_00 waittill("disconnect");
	level.var_C1B2 = 1;
	func_C1B5();
	if(level.var_B335 != "mp_dome_dusk")
	{
		function_0234(-3,5);
	}

	setslowmotion(1,1,0);
	level notify("nuke_cancelled");
	self notify("nuke_ship_exit");
}

//Function Number: 8
func_13959(param_00)
{
	self endon("nuke_ship_exit");
	level endon("game_ended");
	thread func_1395C();
	wait(2);
	self moveto(self.var_C96C,5,0.2,2);
	thread func_665A();
	self waittill("near_goal");
	thread func_10DD1();
	level thread func_512C(level.var_C1CD - 7,::func_C1B1,self);
	level thread func_512C(level.var_C1CD - 3.3,::func_C1CC,self);
	level thread func_512C(level.var_C1CD,::func_C1CB,self);
	level thread func_512C(level.var_C1CD,::func_C1CA,self);
	level thread func_512C(level.var_C1CD,::func_C1BE,self);
	level thread func_512C(level.var_C1CD,::func_C1BC,self);
	level thread func_512C(level.var_C1CD + 0.25,::func_C1CE,self);
	level thread func_512C(level.var_C1CD + 1.5,::func_C1B8,self);
	self waittill("at_goal");
	self scriptmodelplayanimdeltamotion("veh_mil_air_ca_mons_mp_doors_open",1);
	if(!isdefined(level.var_C1AE))
	{
		level.var_C1AE = spawn("script_origin",(0,0,1));
		level.var_C1AE hide();
	}

	scripts\mp\_rank::func_1835(2,level.var_C1C5.team,"nuke");
	if(level.var_3883 && param_00)
	{
		level thread func_3884(level.var_C1C5.player);
	}
}

//Function Number: 9
func_10DD1()
{
	level endon("nuke_cancelled");
	setomnvar("ui_nuke_countdown_active",1);
	if(level.var_B335 != "mp_dome_dusk")
	{
		function_0234(-1,10);
	}

	level thread func_12E43();
	if(!isdefined(level.var_C1A7))
	{
		level.var_C1A7 = spawn("script_origin",(0,0,0));
		level.var_C1A7 hide();
	}

	for(var_00 = level.var_C1CD;var_00 > 0;var_00--)
	{
		if(var_00 == 1)
		{
			level.var_C1A7 playsound("mp_killstreak_nuclearstrike_alarm_last");
		}
		else
		{
			level.var_C1A7 playsound("mp_killstreak_nuclearstrike_alarm");
		}

		wait(1);
	}

	wait(5);
	self notify("nuke_ship_exit");
}

//Function Number: 10
func_665A()
{
	self endon("nuke_ship_exit");
	playfx(scripts\common\utility::getfx("mons_warp_in"),self.var_C96C);
	playsoundatpos(self.var_C96C,"ks_nuke_mons_arrive");
	wait(0.545);
	scripts\mp\_shellshock::func_1245(0.8,0.5,level.var_B32E,100000);
	playfx(scripts\common\utility::getfx("mons_warp_flash"),self.var_C96C);
	self setscriptablepartstate("body","show",0);
	wait(0.5);
	self setscriptablepartstate("thrusters_burst","active",0);
	self playsound("ks_nuke_mons_start");
	wait(4);
	self setscriptablepartstate("thrusters","active",0);
	wait(1);
	self setscriptablepartstate("thrusters_burst","neutral",0);
}

//Function Number: 11
func_1395C()
{
	self endon("nuke_ship_exit");
	for(;;)
	{
		var_00 = distance(self.origin,self.var_C96C);
		if(var_00 <= 5000 && !isdefined(self.var_BE83))
		{
			self notify("near_goal");
			self.var_BE83 = 1;
		}

		if(var_00 == 0)
		{
			self notify("at_goal");
			break;
		}

		scripts\common\utility::func_136F7();
	}
}

//Function Number: 12
func_1395A()
{
	self waittill("nuke_ship_exit");
	playfx(scripts\common\utility::getfx("mons_warp_out"),self.origin);
	playsoundatpos(self.origin,"ks_nuke_mons_ftl_buildup");
	wait(3);
	scripts\mp\_shellshock::func_1245(0.8,0.5,level.var_B32E,100000);
	playsoundatpos(self.origin,"ks_nuke_mons_ftl_out");
	playfx(scripts\common\utility::getfx("mons_warp_flash"),self.origin);
	self delete();
	level.var_C1C4 = undefined;
}

//Function Number: 13
func_8051()
{
	var_00 = 150;
	var_01 = 100000;
	var_02 = self.angles[1];
	var_03 = (0,var_02,0);
	var_04 = self.origin + anglestoforward(var_03) * var_01;
	return var_04;
}

//Function Number: 14
func_3884(param_00)
{
	level waittill("game_ended");
	param_00 scripts\common\utility::waittill_any_3("death","disconnect");
	func_C1B5();
	level.var_C1C4 = undefined;
	level notify("nuke_cancelled");
}

//Function Number: 15
func_C1B1(param_00)
{
	param_00 endon("nuke_ship_exit");
	level endon("nuke_cancelled");
	playfx(scripts\common\utility::getfx("mons_laser_charge"),param_00.origin);
	param_00 playsound("ks_nuke_mons_prepare");
	var_01 = 15;
	scripts\mp\_shellshock::func_1245(0.1,var_01,level.var_B32E,100000);
}

//Function Number: 16
func_C1CC(param_00)
{
	param_00 endon("nuke_ship_exit");
	level endon("nuke_cancelled");
}

//Function Number: 17
func_C1CB(param_00)
{
	param_00 endon("nuke_ship_exit");
	level endon("nuke_cancelled");
	if(isdefined(level.var_C1AE))
	{
	}
}

//Function Number: 18
func_C1B5(param_00)
{
	var_01 = 0;
	if(isdefined(level.var_D8C5))
	{
		var_01 = level.var_D8C5;
	}

	setomnvar("ui_bomb_timer",var_01);
	setomnvar("ui_nuke_countdown_active",0);
}

//Function Number: 19
func_C1BE(param_00)
{
	param_00 endon("nuke_ship_exit");
	level endon("nuke_cancelled");
	func_C1B5();
	level.var_C1BB = 1;
	param_00 playsound("ks_nuke_mons_laser");
	playfx(scripts\common\utility::getfx("mons_laser_flash"),param_00.origin - (0,0,500));
	playfx(scripts\common\utility::getfx("mons_laser_smoke"),level.var_B32E);
}

//Function Number: 20
func_C1CA(param_00)
{
	param_00 endon("nuke_ship_exit");
	level endon("nuke_cancelled");
	setslowmotion(1,0.25,0.5);
	level waittill("nuke_death");
	setslowmotion(0.25,1,3);
}

//Function Number: 21
func_C1CE(param_00)
{
	param_00 endon("nuke_ship_exit");
	level endon("nuke_cancelled");
	level.var_C1CF = 1;
	if(level.var_B335 != "mp_dome_dusk")
	{
		function_0234(-2,1.5);
	}

	setdvar("r_materialBloomHQScriptMasterEnable",0);
	scripts\mp\_hostmigration::func_13708(0.5);
	level notify("nuke_aftermath_post_started");
	level waittill("nuke_death");
	param_00 scriptmodelplayanimdeltamotion("veh_mil_air_ca_mons_mp_doors_close",1);
	level thread func_12EDA();
	foreach(var_02 in level.players)
	{
		if(scripts\mp\_utility::func_9F19(var_02))
		{
			playfxontagforclients(scripts\common\utility::getfx("mons_screen_ash"),var_02,"tag_eye",var_02);
		}
	}

	scripts\mp\_hostmigration::func_13708(3.1);
	if(level.var_B335 != "mp_dome_dusk")
	{
		function_0234(-3,1);
	}
}

//Function Number: 22
func_C1B8(param_00)
{
	param_00 endon("nuke_ship_exit");
	level endon("nuke_cancelled");
	level endon("game_ended");
	level notify("nuke_death");
	scripts\mp\_hostmigration::func_13834();
	var_01 = 0;
	if(level.gametype == "war" || level.gametype == "dm")
	{
		var_01 = 1;
	}

	if(isdefined(level.var_C1C5.player))
	{
		foreach(var_03 in level.var_3CB5)
		{
			if(func_C1B3(var_03,var_01))
			{
				if(isplayer(var_03))
				{
					var_03.var_C1B7 = 1;
					if(scripts\mp\_utility::func_9F19(var_03))
					{
						scripts\mp\_damage::func_17AC(var_03,level.var_C1C5.player,undefined,"nuke_mp",0,undefined,undefined,undefined,undefined,undefined);
						var_03 thread scripts\mp\_damage::func_6CE1(level.var_C1C5.player,level.var_C1C5.player,999999,0,"MOD_EXPLOSIVE","nuke_mp",var_03.origin,(0,0,1),"none",0,0,undefined,undefined);
					}
				}
			}
		}

		if(scripts\mp\_utility::func_9FB3(var_01))
		{
			func_52C5();
		}
		else
		{
			func_52C5(scripts\mp\_utility::getotherteam(param_00.team));
		}

		scripts\mp\_utility::func_D915("killstreak ended - nuke",level.var_C1C5.player);
		if(scripts\mp\_utility::func_9FB3(var_01))
		{
			level.var_C1C3 = 1;
			var_05 = level.var_C1C5.player;
			if(level.teambased)
			{
				var_05 = level.var_C1C5.player.team;
			}

			thread scripts\mp\_gamelogic::endgame(var_05,game["end_reason"]["nuke_end"],1);
		}
	}

	level.var_C1C4 = undefined;
}

//Function Number: 23
func_C1B3(param_00,param_01)
{
	if(!isdefined(level.var_C1C5))
	{
		return 0;
	}

	if(scripts\mp\_utility::func_9FB3(param_01))
	{
		return 1;
	}

	if(level.teambased)
	{
		if(isdefined(level.var_C1C5.team) && param_00.team == level.var_C1C5.team)
		{
			return 0;
		}
	}
	else
	{
		var_02 = isdefined(level.var_C1C5.player) && param_00 == level.var_C1C5.player;
		var_03 = isdefined(level.var_C1C5.player) && isdefined(param_00.var_222) && param_00.var_222 == level.var_C1C5.player;
		if(var_02 || var_03)
		{
			return 0;
		}
	}

	return 1;
}

//Function Number: 24
func_C1BC(param_00)
{
	level endon("nuke_cancelled");
	scripts\mp\_shellshock::func_1245(0.2,1.5,level.var_B32E,100000);
	level waittill("nuke_death");
	scripts\mp\_shellshock::func_1245(0.4,0.1,level.var_B32E,100000);
	foreach(var_02 in level.players)
	{
		var_02 playrumbleonentity("damage_heavy");
	}
}

//Function Number: 25
func_C56E()
{
	for(;;)
	{
		level waittill("connected",var_00);
		var_00 thread func_C57B();
	}
}

//Function Number: 26
func_C57B()
{
	self endon("disconnect");
	level endon("nuke_cancelled");
	for(;;)
	{
		self waittill("spawned_player");
		if(isdefined(level.var_C1BB))
		{
			thread func_FB0F(0.1);
		}
	}
}

//Function Number: 27
func_FB0F(param_00)
{
	wait(param_00);
	if(level.var_B335 != "mp_dome_dusk")
	{
		self method_83FD(-3,0);
	}

	playfxontagforclients(scripts\common\utility::getfx("mons_screen_ash"),self,"tag_eye",self);
}

//Function Number: 28
func_12E43()
{
	level endon("game_ended");
	level endon("disconnect");
	level endon("nuke_cancelled");
	level endon("nuke_death");
	var_00 = level.var_C1CD * 1000 + gettime();
	setomnvar("ui_nuke_end_milliseconds",var_00);
	level waittill("host_migration_begin");
	var_01 = scripts\mp\_hostmigration::func_13834();
	if(var_01 > 0)
	{
		setomnvar("ui_nuke_end_milliseconds",var_00 + var_01);
	}
}

//Function Number: 29
func_12EDA()
{
	level endon("game_ended");
	for(;;)
	{
		level waittill("host_migration_end");
		level func_F7BC(0);
	}
}

//Function Number: 30
func_F7BC(param_00)
{
	if(isdefined(level.var_C1BA))
	{
		level thread [[ level.var_C1BA ]]();
		return;
	}

	if(level.var_B335 != "mp_dome_dusk")
	{
		function_0234(-3,param_00);
	}
}

//Function Number: 31
func_52C5(param_00)
{
	var_01 = "nuke_mp";
	var_02 = level.var_1655;
	var_03 = scripts\mp\perks\_perkfunctions::func_7D96();
	var_04 = undefined;
	if(isdefined(var_02) && isdefined(var_03))
	{
		var_04 = scripts\common\utility::func_2284(var_02,var_03);
	}
	else if(isdefined(var_02))
	{
		var_04 = var_02;
	}
	else if(isdefined(var_03))
	{
		var_04 = var_03;
	}

	if(isdefined(var_04))
	{
		foreach(var_06 in var_04)
		{
			if(isdefined(var_06))
			{
				var_06 scripts\mp\killstreaks\_utility::dodamagetokillstreak(10000,level.var_C1C5.player,level.var_C1C5.player,param_00,var_06.origin,"MOD_EXPLOSIVE",var_01);
			}
		}
	}
}