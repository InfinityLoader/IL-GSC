/*******************************************************************
 * Decompiled By: Bog
 * Decompiled File: scripts\mp\killstreaks\_thor.gsc
 * Game: Call of Duty: Infinite Warfare
 * Platform: PC
 * Function Count: 69
 * Decompile Time: 3207 ms
 * Timestamp: 10/27/2023 12:29:51 AM
*******************************************************************/

//Function Number: 1
init()
{
	scripts\mp\killstreaks\_killstreaks::func_DEFB("thor",::func_12909,undefined,undefined,undefined,::func_13C8E,undefined,::func_13099,::func_13CD7);
	level._effect["thor_clouds"] = loadfx("vfx/core/mp/killstreaks/odin/odin_parallax_clouds");
	level._effect["thor_fisheye"] = loadfx("vfx/iw7/_requests/mp/vfx_scrnfx_thor_fisheye.vfx");
	level._effect["thor_targeting"] = loadfx("vfx/core/mp/killstreaks/odin/vfx_marker_odin_cyan");
	level._effect["thor_target_mark"] = loadfx("vfx/iw7/_requests/mp/vfx_marker_map_target");
	level._effect["thor_explode"] = loadfx("vfx/iw7/core/mp/killstreaks/vfx_veh_exp_thor.vfx");
	level.var_117B0 = [];
	level.var_117B0["thor"] = spawnstruct();
	level.var_117B0["thor"].var_11901 = 60;
	level.var_117B0["thor"].maxhealth = 2600;
	level.var_117B0["thor"].var_110EA = "thor";
	level.var_117B0["thor"].var_13260 = "thor_mp";
	level.var_117B0["thor"].var_B91A = "veh_mil_air_thor_wm";
	level.var_117B0["thor"].var_115EB = "used_thor";
	level.var_117B0["thor"].var_13553 = "loki_gone";
	level.var_117B0["thor"].var_1352D = "odin_target_killed";
	level.var_117B0["thor"].var_1352C = "odin_targets_killed";
	level.var_117B0["thor"].var_12B20 = 4;
	level.var_117B0["thor"].var_12B80 = &"KILLSTREAKS_LOKI_UNAVAILABLE";
	level.var_117B0["thor"].var_73BE = "compass_objpoint_airstrike_friendly";
	level.var_117B0["thor"].var_6485 = "compass_objpoint_airstrike_busy";
	level.var_117B0["thor"].var_394["missile"] = spawnstruct();
	level.var_117B0["thor"].var_394["missile"].var_39C = "thorproj_mp";
	level.var_117B0["thor"].var_394["missile"].var_13FCB = "thorproj_zoomed_mp";
	level.var_117B0["thor"].var_394["missile"].var_DA5A = "thorproj_mp";
	level.var_117B0["thor"].var_394["missile"].var_E7BA = "heavygun_fire";
	level.var_117B0["thor"].var_394["missile"].var_DF5C = 0.1;
	level.var_117B0["thor"].var_394["missile"].var_B47C = 5;
	level.var_117B0["thor"].var_394["missile"].var_D5E4 = "null";
	level.var_117B0["thor"].var_394["missile"].var_D5DD = "null";
	level.var_117B0["thor"].var_394["missile"].var_C195 = "null";
	level.var_C20D = 0;
	var_00 = ["passive_increased_armor","passive_decreased_duration","passive_seek_cluster","passive_no_cursor","passive_switch_thruster","passive_armor_duration"];
	scripts\mp\_killstreak_loot::func_DF07("thor",var_00);
}

//Function Number: 2
func_13C8E(param_00)
{
	var_01 = 1;
	if(scripts\mp\_utility::func_4BD7() >= scripts\mp\_utility::func_B4D2() || level.var_6BAA + var_01 >= scripts\mp\_utility::func_B4D2())
	{
		scripts\mp\_hud_message::func_10122("KILLSTREAKS_TOO_MANY_VEHICLES");
		return 0;
	}

	level.var_C20D++;
	if(level.var_C20D > 1)
	{
		scripts\mp\_hud_message::func_10122("KILLSTREAKS_TOO_MANY_THORS");
		level.var_C20D--;
		return 0;
	}

	thread func_13B73();
	self setclientomnvar("ui_remote_control_sequence",1);
	return 1;
}

//Function Number: 3
func_13B73()
{
	self endon("thor_weapon_switch_ended");
	level endon("game_ended");
	scripts\common\utility::waittill_any_3("death","disconnect");
	if(isdefined(level.var_C20D) && level.var_C20D > 0)
	{
		level.var_C20D--;
	}

	if(isdefined(self))
	{
		self setclientomnvar("ui_remote_control_sequence",0);
	}
}

//Function Number: 4
func_13CD7(param_00,param_01)
{
	self notify("thor_weapon_switch_ended");
	if(!scripts\mp\_utility::func_9FB3(param_01))
	{
		if(isdefined(level.var_C20D) && level.var_C20D > 0)
		{
			level.var_C20D--;
		}

		self setclientomnvar("ui_remote_control_sequence",0);
	}
}

//Function Number: 5
func_13099(param_00)
{
	level.var_C20D--;
	self setclientomnvar("ui_remote_control_sequence",0);
}

//Function Number: 6
func_12909(param_00)
{
	var_01 = scripts\mp\killstreaks\_killstreaks::func_D507(param_00);
	if(!var_01)
	{
		level.var_C20D--;
		return 0;
	}

	var_01 = func_10DFC(param_00);
	if(!isdefined(var_01))
	{
		var_01 = 0;
	}

	return var_01;
}

//Function Number: 7
func_10DFC(param_00)
{
	self.var_117AF = spawn("script_model",level.var_12AF6);
	self.var_117AF setmodel("tag_origin");
	self.var_117AF.angles = (0,115,0);
	self.var_117AF.var_222 = self;
	self.var_117AF hide();
	self.var_117AF thread func_E731(-360,60,"thor_fire_thrusters","thor_switch_thrusters");
	self.thorrigangle = -360;
	self.var_E2D7 = vectortoangles(anglestoforward(self.angles));
	scripts\mp\_utility::func_93FA();
	var_01 = func_4A26(param_00.var_110EA,param_00);
	if(!isdefined(var_01))
	{
		level.var_C20D--;
		scripts\mp\_utility::func_4FC1();
		thread scripts\mp\killstreaks\_killstreaks::func_11086();
		return 0;
	}

	return 1;
}

//Function Number: 8
func_E731(param_00,param_01,param_02,param_03)
{
	self endon("death");
	self.var_222 endon("disconnect");
	if(isdefined(param_02))
	{
		self.var_222 endon(param_02);
	}

	if(isdefined(param_03))
	{
		self.var_222 endon(param_03);
	}

	if(!isdefined(param_00))
	{
		param_00 = -360;
	}

	if(!isdefined(param_01))
	{
		param_01 = 60;
	}

	for(;;)
	{
		self rotateyaw(param_00,param_01);
		wait(param_01);
	}
}

//Function Number: 9
func_4A26(param_00,param_01)
{
	var_02 = level.var_117B0[param_00];
	var_03 = randomint(360);
	var_04 = 7000;
	var_05 = 10000;
	var_06 = cos(var_03) * var_04;
	var_07 = sin(var_03) * var_04;
	var_08 = vectornormalize((var_06,var_07,var_05));
	var_08 = var_08 * var_04;
	var_09 = self.var_117AF.origin + var_08 + (0,0,1000);
	var_0A = self.var_117AF.origin + var_08;
	var_0B = var_02.var_B91A;
	var_0C = scripts\mp\_killstreak_loot::getrarityforlootitem(param_01.var_1318B);
	if(var_0C != "")
	{
		var_0B = var_0B + "_" + var_0C;
	}

	var_0D = spawn("script_model",var_09);
	if(!isdefined(var_0D))
	{
		return undefined;
	}

	var_0D setmodel(var_0B);
	var_0D.team = self.team;
	var_0D.var_222 = self;
	var_0D.health = 99999;
	var_0D.var_C22B = 1;
	var_0D.var_C239 = var_02.var_394["missile"].var_B47C;
	var_0D.var_C238 = 0;
	var_0D.var_B88C = func_989D("ID");
	var_0D.var_B888 = func_989D("Distance");
	var_0D.var_B47C = var_02.var_394["missile"].var_B47C;
	var_0D.var_DF5C = var_02.var_394["missile"].var_DF5C;
	var_0D.var_13F0A = 10000;
	var_0D.var_110EA = param_00;
	var_0D.var_117B2 = 1;
	var_0D.var_110E8 = param_01;
	var_0D.basemodel = var_0B;
	var_0D setcandamage(1);
	var_0D method_831F(self);
	var_0D setscriptablepartstate("body","hide",0);
	var_0D.angles = vectortoangles(self.var_117AF.origin - (var_0D.origin[0],var_0D.origin[1],self.var_117AF.origin[2]));
	var_0D.var_10E4C = func_495B();
	thread func_117AE(var_0D,var_0A);
	return var_0D;
}

//Function Number: 10
func_117AE(param_00,param_01)
{
	param_00 endon("death");
	level endon("game_ended");
	param_00.var_222 playlocalsound("thor_init_plr");
	param_00 moveto(param_01,1);
	param_00 scriptmodelplayanim("iw7_mp_killstreak_thor_idle",1);
	param_00 setscriptablepartstate("thrusters","drop",0);
	scripts\mp\_shellshock::func_1245(0.15,2,param_00.origin,2000);
	var_02 = level.var_117B0[param_00.var_110EA];
	if(getdvarint("camera_thirdPerson"))
	{
		scripts\mp\_utility::setthirdpersondof(0);
	}

	var_03 = var_02.var_394["missile"].var_39C;
	var_04 = var_02.var_394["missile"].var_13FCB;
	param_00.var_D8E1 = var_03;
	param_00.var_F0C4 = var_04;
	param_00.var_222 scripts\mp\_utility::func_12C6(var_03);
	param_00.var_222 scripts\mp\_utility::func_12C6(var_04);
	param_00.var_222 scripts\mp\_utility::_switchtoweaponimmediate(var_03);
	param_00.var_222 playerlinkweaponviewtodelta(param_00,"tag_player",0,180,180,45,180);
	param_00.var_222 method_8236(0);
	param_00.var_222 method_85A2(getthormapvisionset(level.var_B335));
	param_00.var_222 thread func_B011(param_00);
	param_00.var_222 setclientomnvar("ui_thor_show",1);
	param_00.var_222 setclientomnvar("ui_thor_missiles_loaded",var_02.var_394["missile"].var_B47C);
	param_00.var_222 thermalvisionfofoverlayon();
	param_00.var_222 thermalvisionon();
	for(var_05 = 0;var_05 < 5;var_05++)
	{
		param_00.var_222 setclientomnvar(param_00.var_B88C[var_05].var_C4A1,undefined);
		param_00.var_222 setclientomnvar(param_00.var_B888[var_05].var_C4A1,-1);
	}

	param_00.var_222 method_82C0("thor_killstreak",1);
	var_06 = var_02.var_115EB;
	var_07 = scripts\mp\_killstreak_loot::getrarityforlootitem(param_00.var_110E8.var_1318B);
	if(var_07 != "")
	{
		var_06 = var_06 + "_" + var_07;
	}

	level thread scripts\mp\_utility::func_115DE(var_06,self);
	param_00.var_222 scripts\common\utility::func_1C76(0);
	param_00 func_8ED7(param_00.basemodel);
	param_00 thread func_117A7();
	param_00 thread func_117A0();
	param_00 thread func_117A9();
	wait(0.5);
	param_00 scriptmodelplayanim("iw7_mp_killstreak_thor_extend",1);
	wait(0.5);
	param_00 scriptmodelplayanim("iw7_mp_killstreak_thor_extend_idle",1);
	param_00 setscriptablepartstate("thrusters","idle",0);
	scripts\mp\_shellshock::func_1245(0.2,0.76,param_00.origin,1000);
	param_00 linkto(self.var_117AF,"tag_origin");
	param_00 scripts\mp\killstreaks\_utility::func_1843(param_00.var_110EA,undefined,param_00.var_222,1);
	var_08 = "icon_minimap_thor_friendly";
	param_00.minimapid = param_00 scripts\mp\killstreaks\_airdrop::func_49F7(var_08,undefined,1,1,1);
	var_09 = var_02.var_11901;
	if(scripts\mp\killstreaks\_utility::func_A69F(param_00.var_110E8,"passive_armor_duration"))
	{
		var_09 = var_09 - 5;
	}

	param_00 thread func_1179D(param_00.var_222);
	param_00 thread func_117AC(var_09);
	param_00 thread func_117AA();
	param_00 thread func_1179F();
	param_00 thread func_117AD();
	param_00 thread func_117AB();
	param_00 thread func_117A2();
	if(scripts\mp\killstreaks\_utility::func_A69F(param_00.var_110E8,"passive_switch_thruster"))
	{
		param_00 thread thor_watchswitchthrust(param_00.var_222);
	}

	param_00 thread func_117A3();
	param_00 thread func_1179E();
	param_00 thread func_117A5();
	param_00 thread func_117A1();
	param_00 thread func_117A8();
	param_00 thread func_11790();
	param_00 thread func_13AA2(self,var_02);
	param_00.var_222 scripts\mp\_matchdata::func_AFC9(param_00.var_110EA,self.origin);
	param_00.var_222 scripts\common\utility::func_1C6E(0);
	param_00.var_222 setclientomnvar("ui_killstreak_countdown",gettime() + int(var_09 * 1000));
	param_00.var_222 setclientomnvar("ui_killstreak_health",var_02.maxhealth / 2600);
}

//Function Number: 11
func_8ED7(param_00)
{
	self method_8187("j_backend",param_00);
	self method_8187("j_shield_1",param_00);
	self method_8187("j_shield_2",param_00);
	self method_8187("j_shield_3",param_00);
	self method_8187("j_shield_4",param_00);
	self method_8187("j_nose",param_00);
}

//Function Number: 12
func_989D(param_00)
{
	var_01 = [];
	switch(param_00)
	{
		case "ID":
			for(var_02 = 0;var_02 < 5;var_02++)
			{
				var_03 = spawnstruct();
				var_03.var_C4A1 = "ui_thor_missile_" + var_02;
				var_03.var_9B04 = 0;
				var_01[var_01.size] = var_03;
			}
			break;

		case "Distance":
			for(var_02 = 0;var_02 < 5;var_02++)
			{
				var_03 = spawnstruct();
				var_03.var_C4A1 = "ui_thor_missile_" + var_02 + "_dist";
				var_03.var_9B04 = 0;
				var_01[var_01.size] = var_03;
			}
			break;
	}

	return var_01;
}

//Function Number: 13
func_13AA2(param_00,param_01)
{
	param_00 endon("disconnect");
	param_00 endon("joined_team");
	param_00 endon("joined_spectators");
	param_00 endon("killstreak_disowned");
	level endon("game_ended");
	self endon("death");
	self endon("leaving");
	for(;;)
	{
		level waittill("host_migration_end");
		param_00 thermalvisionfofoverlayon();
		if(scripts\mp\_utility::func_9FB3(self.var_117B2))
		{
			param_00 thermalvisionon();
			continue;
		}

		param_00 thermalvisionoff();
	}
}

//Function Number: 14
func_B011(param_00)
{
	self endon("disconnect");
	level endon("game_ended");
	param_00 endon("death");
	wait(0.05);
	var_01 = vectortoangles(level.var_12AF5.origin - param_00 gettagorigin("tag_player"));
	self setplayerangles(var_01);
}

//Function Number: 15
func_1369B(param_00)
{
	self endon("disconnect");
	param_00 endon("death");
	scripts\mp\_hostmigration::func_13708(1);
	var_01 = scripts\mp\_utility::func_C794(self,"cyan",self,0,0,"killstreak");
	param_00 thread func_E146(var_01,self);
}

//Function Number: 16
func_13699(param_00)
{
	self endon("death");
	level endon("game_ended");
	scripts\mp\_hostmigration::func_13708(param_00);
	self delete();
}

//Function Number: 17
func_1179A(param_00)
{
	scripts\mp\_utility::func_FB09(param_00.var_110EA);
}

//Function Number: 18
func_1178F(param_00)
{
	if(isdefined(self))
	{
		scripts\mp\_utility::func_41E9();
	}
}

//Function Number: 19
func_1179C(param_00)
{
	while(isdefined(self.var_9BE2) && param_00 > 0)
	{
		wait(0.05);
		param_00 = param_00 - 0.05;
	}
}

//Function Number: 20
func_1179D(param_00)
{
	param_00 endon("disconnect");
	level endon("game_ended");
	for(;;)
	{
		var_01 = scripts\common\utility::func_13734("start_fire","start_reload","death","leaving");
		if(var_01 == "death" || var_01 == "leaving")
		{
			break;
		}

		param_00 scripts\common\utility::func_1C46(0);
		scripts\common\utility::waittill_any_3("finished_single_fire","finished_reload","death","leaving");
		param_00 scripts\common\utility::func_1C46(1);
	}
}

//Function Number: 21
func_117A0()
{
	level endon("game_ended");
	self endon("leaving");
	self waittill("death");
	if(isdefined(self.var_222))
	{
		self.var_222 func_11791(self);
		self.var_222 setclientomnvar("ui_thor_show",0);
		self.var_222 setclientomnvar("ui_killstreak_countdown",0);
		self.var_222 setclientomnvar("ui_killstreak_health",0);
		self.var_222 setclientomnvar("ui_killstreak_missile_warn",0);
		self.var_222 method_8070(1);
		self.var_222 stoprumble("thor_thrust_rumble");
		foreach(var_01 in self.var_B88C)
		{
			self.var_222 setclientomnvar(var_01.var_C4A1,undefined);
		}

		foreach(var_04 in self.var_B888)
		{
			self.var_222 setclientomnvar(var_04.var_C4A1,-1);
		}
	}

	func_4074();
	scripts\mp\_utility::func_4FC1();
	playfx(scripts\common\utility::getfx("thor_explode"),self.origin);
	self delete();
}

//Function Number: 22
func_117AC(param_00)
{
	level endon("game_ended");
	self endon("death");
	self endon("leaving");
	self endon("host_migration_lifetime_update");
	self.var_222 endon("disconnect");
	self.var_222 endon("joined_team");
	self.var_222 endon("joined_spectators");
	thread scripts\mp\killstreaks\_utility::watchhostmigrationlifetime("leaving",param_00,::func_117AC);
	scripts\mp\_hostmigration::func_13708(param_00);
	func_1179C(3);
	var_01 = ["thor_end","thor_timeout"];
	var_02 = randomint(var_01.size);
	var_03 = var_01[var_02];
	self.var_222 scripts\mp\_utility::func_D4B6(var_03,undefined,undefined,self.var_222.origin);
	thread func_11795();
}

//Function Number: 23
func_117A7()
{
	level endon("game_ended");
	self endon("death");
	self endon("leaving");
	self.var_222 scripts\common\utility::waittill_any_3("disconnect","joined_team","joined_spectators");
	self notify("death");
}

//Function Number: 24
func_117A5()
{
	level endon("game_ended");
	self endon("death");
	self endon("leaving");
	self.var_222 endon("disconnect");
	self.var_222 endon("joined_team");
	self.var_222 endon("joined_spectators");
	level waittill("objective_cam");
	thread func_11795();
}

//Function Number: 25
func_117A9()
{
	self endon("death");
	self endon("leaving");
	self.var_222 endon("disconnect");
	self.var_222 endon("joined_team");
	self.var_222 endon("joined_spectators");
	level scripts\common\utility::waittill_any_3("round_end_finished","game_ended");
	var_00 = 1;
	thread func_11795(var_00);
}

//Function Number: 26
func_11795(param_00)
{
	self endon("death");
	self notify("leaving");
	var_01 = level.var_117B0[self.var_110EA];
	scripts\mp\_utility::func_AAE7(var_01.var_13553);
	if(isdefined(self.var_222))
	{
		self.var_222 func_11791(self,param_00);
		self.var_222 setclientomnvar("ui_thor_show",0);
		self.var_222 setclientomnvar("ui_killstreak_countdown",0);
		self.var_222 setclientomnvar("ui_killstreak_health",0);
		self.var_222 setclientomnvar("ui_killstreak_missile_warn",0);
		self.var_222 method_8070(1);
		self.var_222 stoprumble("thor_thrust_rumble");
		foreach(var_03 in self.var_B88C)
		{
			self.var_222 setclientomnvar(var_03.var_C4A1,undefined);
		}

		foreach(var_06 in self.var_B888)
		{
			self.var_222 setclientomnvar(var_06.var_C4A1,-1);
		}
	}

	self notify("gone");
	self scriptmodelplayanim("iw7_mp_killstreak_thor_extend_to_up",1);
	scripts\mp\_hostmigration::func_13708(1);
	self moveto(self.origin + (0,0,15000),5,3.5);
	self scriptmodelplayanim("iw7_mp_killstreak_thor_extend_up",1);
	self setscriptablepartstate("thrusters","leave",0);
	scripts\mp\_hostmigration::func_13708(5);
	func_4074();
	scripts\mp\_utility::func_4FC1();
	self delete();
}

//Function Number: 27
func_11791(param_00,param_01)
{
	var_02 = level.var_117B0[param_00.var_110EA];
	scripts\mp\_utility::func_D915("killstreak ended - thor",self);
	if(isdefined(param_00))
	{
		param_00 notify("end_remote");
		self notify("thor_ride_ended");
		scripts\common\utility::func_1C6E(1);
		if(getdvarint("camera_thirdPerson"))
		{
			scripts\mp\_utility::setthirdpersondof(1);
		}

		self thermalvisionfofoverlayoff();
		self thermalvisionoff();
		self method_85A2("");
		self unlink();
		self setplayerangles(self.var_E2D7);
		if(scripts\mp\_utility::func_9FB3(param_01))
		{
			scripts\mp\_utility::func_1136C(scripts\common\utility::getlastweapon(),1);
		}
		else
		{
			thread func_11794();
		}

		self stoplocalsound("odin_negative_action");
		self stoplocalsound("odin_positive_action");
		foreach(var_04 in level.var_117B0[param_00.var_110EA].var_394)
		{
			if(isdefined(var_04.var_D5E4))
			{
				self stoplocalsound(var_04.var_D5E4);
			}

			if(isdefined(var_04.var_D5DD))
			{
				self stoplocalsound(var_04.var_D5DD);
			}
		}

		thread scripts\mp\killstreaks\_killstreaks::func_11086();
		if(isdefined(self.var_117AF))
		{
			self.var_117AF delete();
		}

		thread scripts\mp\_utility::func_141E(param_00.var_D8E1);
		thread scripts\mp\_utility::func_141E(param_00.var_F0C4);
		scripts\common\utility::func_1C76(1);
	}
}

//Function Number: 28
func_11794()
{
	self endon("disconnect");
	self endon("death");
	level endon("game_ended");
	scripts\mp\_utility::func_7385(1);
	scripts\mp\_hostmigration::func_13708(0.5);
	scripts\mp\_utility::func_7385(0);
}

//Function Number: 29
func_117AA()
{
	self endon("death");
	self endon("leaving");
	level endon("game_ended");
	var_00 = self.var_222;
	var_00 endon("disconnect");
	var_01 = spawn("script_model",(0,0,0));
	var_01.angles = vectortoangles((0,0,1));
	var_01 setmodel("tag_origin");
	var_01 hide();
	self.var_1156A = var_01;
	self method_8549();
	self method_8594();
	for(;;)
	{
		var_02 = var_00 method_816E() - (0,0,50);
		var_03 = var_02 + anglestoforward(var_00 getplayerangles()) * -15536;
		var_04 = ["physicscontents_clipshot","physicscontents_corpseclipshot","physicscontents_missileclip","physicscontents_solid","physicscontents_vehicle"];
		var_05 = physics_createcontents(var_04);
		var_06 = scripts\common\trace::func_DCED(var_02,var_03,level.var_3CB5,var_05);
		var_01.origin = var_06["position"] + (0,0,50);
		scripts\common\utility::func_136F7();
	}
}

//Function Number: 30
func_1179F()
{
	self endon("death");
	self endon("leaving");
	var_00 = self.var_222;
	var_00 endon("disconnect");
	var_01 = level.var_117B0[self.var_110EA];
	var_02 = var_01.maxhealth;
	var_03 = 0;
	var_04 = 3;
	var_05 = 4;
	var_06 = 5;
	if(scripts\mp\killstreaks\_utility::func_A69F(self.var_110E8,"passive_armor_duration"))
	{
		var_04++;
		var_05++;
		var_06++;
	}

	for(;;)
	{
		self waittill("damage",var_07,var_08,var_09,var_0A,var_0B,var_0C,var_0D,var_0E,var_0F,var_10,var_11,var_12,var_13,var_14);
		var_10 = scripts\mp\_utility::func_13CA1(var_10,var_14);
		if(isdefined(var_08))
		{
			if(isdefined(var_08.var_222))
			{
				var_08 = var_08.var_222;
			}

			if(isdefined(var_08.team) && var_08.team == self.team && var_08 != self.var_222)
			{
				continue;
			}
		}

		if(lib_0DF8::func_9DDF(var_08))
		{
			continue;
		}

		if(isdefined(var_0B))
		{
			var_00 func_4CF1(self,var_0B);
		}

		if(isdefined(var_10))
		{
			var_07 = scripts\mp\killstreaks\_utility::func_7FBD(var_08,var_10,var_0B,var_07,var_01.maxhealth,var_04,var_05,var_06);
			if(scripts\mp\killstreaks\_utility::func_A69F(self.var_110E8,"passive_armor_duration"))
			{
				if(scripts\mp\killstreaks\_utility::isexplosiveantikillstreakweapon(var_10))
				{
					var_08 scripts\mp\_damagefeedback::func_12E84("hitblastshield");
				}
			}
		}

		var_02 = var_02 - var_07;
		var_00 setclientomnvar("ui_killstreak_health",var_02 / var_01.maxhealth);
		if(isplayer(var_08))
		{
			var_08 scripts\mp\_damagefeedback::func_12E84("");
			scripts\mp\killstreaks\_killstreaks::func_A6A0(var_08,var_10,self,var_0B);
			scripts\mp\_damage::func_AF96(self,var_07,var_08,var_09,var_0A,var_0B,var_0C,var_0D,var_0E,var_0F,var_10);
			if(var_02 <= 0)
			{
				var_08 notify("destroyed_killstreak",var_10);
				var_15 = "callout_destroyed_thor";
				var_16 = scripts\mp\_killstreak_loot::getrarityforlootitem(self.var_110E8.var_1318B);
				if(var_16 != "")
				{
					var_15 = var_15 + "_" + var_16;
				}

				scripts\mp\_damage::func_C548("thor",var_08,var_10,var_0B,var_07,"destroyed_thor","thor_destroyed",var_15);
				return;
			}
		}
	}
}

//Function Number: 31
func_4CF1(param_00,param_01)
{
	switch(param_01)
	{
		case "MOD_GRENADE_SPLASH":
		case "MOD_GRENADE":
		case "MOD_PROJECTILE":
		case "MOD_EXPLOSIVE_BULLET":
		case "MOD_PISTOL_BULLET":
		case "MOD_RIFLE_BULLET":
			func_3239(param_00);
			break;

		case "MOD_PROJECTILE_SPLASH":
		case "MOD_IMPACT":
		case "MOD_EXPLOSIVE":
			func_69E6(param_00);
			break;

		default:
			break;
	}
}

//Function Number: 32
func_3239(param_00)
{
	self earthquakeforplayer(0.15,0.25,param_00 gettagorigin("tag_player"),50);
	self playrumbleonentity("damage_light");
	thread func_1349D(param_00,0.4);
}

//Function Number: 33
func_69E6(param_00)
{
	self earthquakeforplayer(0.4,0.45,param_00 gettagorigin("tag_player"),1000);
	self playrumbleonentity("damage_heavy");
	thread func_1349D(param_00,0.7);
}

//Function Number: 34
func_1349D(param_00,param_01)
{
	self endon("disconnect");
	level endon("game_ended");
	param_00 endon("death");
	param_00.var_10E4C.alpha = param_01;
	while(param_01 > 0)
	{
		scripts\common\utility::func_136F7();
		param_01 = param_01 - 0.1;
		param_00.var_10E4C.alpha = param_01;
	}
}

//Function Number: 35
func_495B()
{
	var_00 = newclienthudelem(self);
	var_00.x = 0;
	var_00.y = 0;
	var_00 setshader("white",640,480);
	var_00.alignx = "left";
	var_00.aligny = "top";
	var_00.sort = 1;
	var_00.horzalign = "fullscreen";
	var_00.vertalign = "fullscreen";
	var_00.alpha = 0;
	var_00.foreground = 1;
	return var_00;
}

//Function Number: 36
func_117AD()
{
	self endon("death");
	self endon("leaving");
	level endon("game_ended");
	var_00 = self.var_222;
	var_00 endon("disconnect");
	var_01 = level.var_117B0[self.var_110EA];
	if(!isai(var_00))
	{
		var_00 notifyonplayercommand("thor_missile_zoom_on","+weapnext");
	}

	for(;;)
	{
		var_00 waittill("thor_missile_zoom_on");
		var_00 scripts\common\utility::func_1C76(1);
		if(!isdefined(self.var_117B3))
		{
			var_00 scripts\mp\_utility::_switchtoweaponimmediate(self.var_F0C4);
			self.var_117B3 = 1;
			var_00 setclientomnvar("ui_thor_show",2);
		}
		else
		{
			var_00 scripts\mp\_utility::_switchtoweaponimmediate(self.var_D8E1);
			self.var_117B3 = undefined;
			var_00 setclientomnvar("ui_thor_show",1);
		}

		var_00 scripts\common\utility::func_1C76(0);
	}
}

//Function Number: 37
func_117AB()
{
	self endon("death");
	self endon("leaving");
	level endon("game_ended");
	var_00 = self.var_222;
	var_00 endon("disconnect");
	var_01 = level.var_117B0[self.var_110EA];
	if(!isai(var_00))
	{
		if(var_00 scripts\common\utility::func_9C70())
		{
			var_00 notifyonplayercommand("thor_thermal_toggle","+usereload");
		}

		var_00 notifyonplayercommand("thor_thermal_toggle","+activate");
	}

	for(;;)
	{
		var_00 waittill("thor_thermal_toggle");
		if(!isdefined(self.var_117B2))
		{
			var_00 thermalvisionon();
			self.var_117B2 = 1;
			continue;
		}

		var_00 thermalvisionoff();
		self.var_117B2 = undefined;
	}
}

//Function Number: 38
func_117A2()
{
	self endon("death");
	self endon("leaving");
	var_00 = self.var_222;
	var_00 endon("disconnect");
	if(!isai(var_00))
	{
		var_00 notifyonplayercommand("thor_fire_thrusters","+smoke");
		var_00 notifyonplayercommand("thor_release_thrusters","-smoke");
	}

	for(;;)
	{
		var_01 = var_00 scripts\common\utility::func_13734("thor_fire_thrusters","thor_release_thrusters");
		if(!isdefined(var_01))
		{
			continue;
		}

		if(var_01 == "thor_fire_thrusters")
		{
			var_00.var_117AF thread func_E731(var_00.thorrigangle,30,"thor_release_thrusters","thor_switch_thrusters");
			thread func_B06B(var_00);
			if(var_00.thorrigangle == -360)
			{
				self scriptmodelplayanim("iw7_mp_killstreak_thor_extend_thrust",1);
			}
			else
			{
				self scriptmodelplayanim("iw7_mp_killstreak_thor_extend_rev_thrust",1);
			}

			self setscriptablepartstate("thrusters","boost",0);
			continue;
		}

		var_00.var_117AF thread func_E731(var_00.thorrigangle,60,"thor_fire_thrusters","thor_switch_thrusters");
		var_00 stoprumble("thor_thrust_rumble");
		if(var_00.thorrigangle == -360)
		{
			self scriptmodelplayanim("iw7_mp_killstreak_thor_extend_idle",1);
		}
		else
		{
			self scriptmodelplayanim("iw7_mp_killstreak_thor_extend_rev_idle",1);
		}

		self setscriptablepartstate("thrusters","idle",0);
	}
}

//Function Number: 39
func_B06B(param_00)
{
	self endon("death");
	param_00 endon("thor_release_thrusters");
	param_00 method_8244("thor_thrust_rumble");
	for(;;)
	{
		scripts\mp\_shellshock::func_1245(0.15,0.05,self.origin,1000);
		scripts\common\utility::func_136F7();
	}
}

//Function Number: 40
func_B9F2(param_00)
{
	self endon("death");
	level endon("game_ended");
	param_00 endon("disconnect");
	scripts\mp\_hostmigration::func_13708(1.5);
	var_01 = [];
	for(;;)
	{
		var_02 = param_00 scripts\mp\_utility::func_7BC3();
		foreach(var_04 in var_01)
		{
			if(!scripts\common\utility::func_2286(var_02,var_04))
			{
				var_01 = scripts\common\utility::func_22A9(var_01,var_04);
				self hide();
				self showtoplayer(param_00);
			}
		}

		foreach(var_04 in var_02)
		{
			self showtoplayer(var_04);
			if(!scripts\common\utility::func_2286(var_01,var_04))
			{
				var_01 = scripts\common\utility::array_add(var_01,var_04);
				stopfxontag(level._effect["thor_targeting"],self,"tag_origin");
				wait(0.05);
				playfxontag(level._effect["thor_targeting"],self,"tag_origin");
			}
		}

		wait(0.25);
	}
}

//Function Number: 41
thor_watchswitchthrust(param_00)
{
	self endon("death");
	self endon("leaving");
	level endon("game_ended");
	param_00 = self.var_222;
	param_00 endon("disconnect");
	if(!isai(param_00))
	{
		param_00 notifyonplayercommand("thor_switch_thrusters","+speed_throw");
		param_00 notifyonplayercommand("thor_switch_thrusters","+toggleads_throw");
		param_00 notifyonplayercommand("thor_switch_thrusters","+ads_akimbo_accessible");
	}

	for(;;)
	{
		var_01 = param_00 scripts\common\utility::func_13734("thor_switch_thrusters");
		if(param_00.thorrigangle == -360)
		{
			self scriptmodelplayanim("iw7_mp_killstreak_thor_extend_rev_idle",1);
			param_00.thorrigangle = 360;
		}
		else
		{
			self scriptmodelplayanim("iw7_mp_killstreak_thor_extend_idle",1);
			param_00.thorrigangle = -360;
		}

		param_00.var_117AF thread func_E731(param_00.thorrigangle,60,"thor_fire_thrusters","thor_switch_thrusters");
	}
}

//Function Number: 42
thor_watchdebugtogglemovement(param_00)
{
	self endon("death");
	self endon("leaving");
	level endon("game_ended");
	param_00 endon("disconnect");
	if(!isai(param_00))
	{
		param_00 notifyonplayercommand("thor_toggle_movement","+speed_throw");
		param_00 notifyonplayercommand("thor_toggle_movement","+toggleads_throw");
		param_00 notifyonplayercommand("thor_toggle_movement","+ads_akimbo_accessible");
	}

	var_01 = 1;
	for(;;)
	{
		var_02 = param_00 scripts\common\utility::func_13734("thor_toggle_movement");
		if(scripts\mp\_utility::func_9FB3(var_01))
		{
			self unlink();
			var_01 = 0;
			continue;
		}

		self linkto(param_00.var_117AF,"tag_origin");
		var_01 = 1;
	}
}

//Function Number: 43
func_117A3()
{
	self endon("death");
	self endon("leaving");
	level endon("game_ended");
	var_00 = self.var_222;
	var_00 endon("disconnect");
	var_01 = "missile";
	var_02 = level.var_117B0[self.var_110EA].var_394[var_01];
	for(;;)
	{
		var_00 waittill("missile_fire",var_03,var_04);
		if(scripts\mp\_utility::func_9FB3(self.var_9BE2))
		{
			continue;
		}

		if(scripts\mp\_utility::func_9FB3(self.var_9C9F))
		{
			continue;
		}

		if(isdefined(level.var_90A9))
		{
			continue;
		}

		if(isdefined(self.var_C239) && self.var_C239 < 1)
		{
			continue;
		}

		if(isdefined(var_04) && var_04 != "thorproj_mp" && var_04 != "thorproj_zoomed_mp")
		{
			continue;
		}

		self setscriptablepartstate("muzzle","fire",0);
		thread func_5104(0.1);
		var_03.var_110E8 = self.var_110E8;
		if(isdefined(var_04) && var_04 == "thorproj_mp")
		{
			var_03 thread func_139D1(var_00,var_01,self);
			continue;
		}

		var_03 thread func_13B42(var_00,self);
	}
}

//Function Number: 44
func_5104(param_00)
{
	self endon("death");
	wait(param_00);
	self setscriptablepartstate("muzzle","neutral",0);
}

//Function Number: 45
func_139D1(param_00,param_01,param_02)
{
	param_00 endon("disconnect");
	param_02 endon("death");
	var_03 = param_02.var_1156A;
	var_04 = param_02.var_B88C;
	var_05 = param_02.var_B888;
	var_06 = self.angles;
	param_02.var_9BE2 = 1;
	param_02 notify("start_fire");
	var_07 = var_03.origin;
	var_08 = scripts\mp\killstreaks\_utility::func_7E92(param_00);
	var_09 = [];
	foreach(var_0B in var_08)
	{
		if(!scripts\mp\killstreaks\_utility::manualmissilecantracktarget(var_0B))
		{
			continue;
		}

		if(param_00 method_8409(var_0B.origin,65,55))
		{
			var_09[var_09.size] = var_0B;
		}
	}

	self waittill("explode",var_0D);
	var_0E = param_02.var_C239;
	var_0F = "thorproj_tracking_mp";
	for(var_10 = 0;var_10 < var_0E;var_10++)
	{
		if(!isdefined(param_02))
		{
			break;
		}

		var_11 = randomint(360);
		var_12 = anglestoright(var_06) * cos(var_11);
		var_13 = anglestoforward(var_06) * 3;
		var_14 = anglestoup(var_06) * sin(var_11);
		var_15 = var_12 + var_13 + var_14;
		var_16 = scripts\mp\_utility::func_1309(var_0F,var_0D,var_0D + var_15,param_00);
		var_16.var_222 = param_00;
		var_16.var_13F0A = var_0D[2];
		var_16.var_92B8 = func_7FBA(var_04);
		var_16.var_5716 = func_7FBA(var_05);
		var_16.var_C79D = scripts\mp\_utility::func_C794(var_16,"white",var_16.var_222,0,0,"killstreak_personal");
		var_16.var_110E8 = param_02.var_110E8;
		var_16.var_222 setclientomnvar(var_16.var_92B8.var_C4A1,var_16);
		var_16.var_222 setclientomnvar(var_16.var_5716.var_C4A1,int(var_16.var_13F0A));
		if(scripts\mp\killstreaks\_utility::func_A69F(param_02.var_110E8,"passive_seek_cluster"))
		{
			var_16 thread delayseekopentargetinview(0.3,var_16.var_222,var_07,var_09);
		}
		else
		{
			var_16 thread func_50E6(0.3,var_03);
		}

		var_16 thread func_139F6(var_16.var_222,param_02);
		var_16 thread func_13A22(var_16.var_222,param_02);
		var_16 thread scripts\mp\killstreaks\_utility::watchsupertrophynotify(var_16.var_222);
		param_02.var_C239--;
		param_00 setclientomnvar("ui_thor_missiles_loaded",param_02.var_C239);
		scripts\mp\_hostmigration::func_13708(0.1);
	}

	param_02 scriptmodelplayanim("iw7_mp_killstreak_thor_extend_reload",1);
	scripts\mp\_hostmigration::func_13708(2);
	param_02 notify("start_reload");
	param_02.var_9BE2 = undefined;
}

//Function Number: 46
delayseekopentargetinview(param_00,param_01,param_02,param_03)
{
	var_04 = undefined;
	wait(param_00);
	foreach(var_06 in param_03)
	{
		if(!scripts\mp\killstreaks\_utility::manualmissilecantracktarget(var_06))
		{
			continue;
		}

		if(scripts\mp\_utility::func_9FB3(var_06.thortargetted))
		{
			continue;
		}

		var_04 = var_06;
		break;
	}

	if(isdefined(var_04))
	{
		self missile_settargetent(var_04);
		self missile_setflightmodedirect();
		var_04.thortargetted = 1;
		var_04 thread watchtarget(self);
		return;
	}

	self missile_settargetpos(param_02);
	self missile_setflightmodedirect();
}

//Function Number: 47
watchtarget(param_00)
{
	self endon("disconnect");
	for(;;)
	{
		if(!scripts\mp\killstreaks\_utility::manualmissilecantracktarget(self))
		{
			break;
		}

		if(!isdefined(param_00))
		{
			break;
		}

		scripts\common\utility::func_136F7();
	}

	self.thortargetted = undefined;
	if(isdefined(param_00))
	{
		param_00 missile_cleartarget();
	}
}

//Function Number: 48
func_390B(param_00)
{
	var_01 = 0;
	var_02 = scripts\common\trace::func_48BC(0,1,1,1,1,1,0);
	var_03 = param_00 gettagorigin("j_head");
	for(var_04 = 0;var_04 < var_03.size;var_04++)
	{
		if(!scripts\common\trace::func_DCF1(self.origin,var_03[var_04],self,var_02))
		{
			continue;
		}

		var_01 = 1;
		break;
	}

	return var_01;
}

//Function Number: 49
func_50E6(param_00,param_01)
{
	self.var_222 endon("disconnect");
	wait(param_00);
	if(isdefined(param_01))
	{
		self missile_settargetent(param_01);
	}

	self missile_setflightmodedirect();
}

//Function Number: 50
func_139F6(param_00,param_01)
{
	self endon("explode");
	self endon("death");
	for(;;)
	{
		if(isdefined(param_01.var_9C9F))
		{
			break;
		}

		self.var_13F0A = self.origin[2];
		var_02 = scripts\common\trace::func_DCED(self.origin,self.origin + (0,0,-1000000));
		var_03 = var_02["position"];
		self.var_13F0A = self.origin - var_02["position"];
		self.var_13F0A = self.var_13F0A[2];
		param_00 setclientomnvar(self.var_5716.var_C4A1,int(max(0,self.var_13F0A)));
		scripts\common\utility::func_136F7();
	}
}

//Function Number: 51
func_13A22(param_00,param_01)
{
	self waittill("explode",var_02);
	if(isdefined(self.var_C79D))
	{
		scripts\mp\_utility::func_C78F(self.var_C79D,self);
	}

	if(isdefined(param_00))
	{
		if(isdefined(self.var_92B8.var_C4A1))
		{
			param_00 setclientomnvar(self.var_92B8.var_C4A1,undefined);
		}
	}
}

//Function Number: 52
func_13B42(param_00,param_01)
{
	param_00 endon("disconnect");
	param_01 endon("death");
	param_01.var_9BE2 = 1;
	param_01 notify("start_fire");
	var_02 = param_01.var_B88C;
	var_03 = param_01.var_B888;
	self.var_13F0A = self.origin[2];
	self.var_92B8 = func_7FBA(var_02);
	self.var_5716 = func_7FBA(var_03);
	self.var_C79D = scripts\mp\_utility::func_C794(self,"white",param_00,0,0,"killstreak_personal");
	param_00 setclientomnvar(self.var_92B8.var_C4A1,self);
	param_00 setclientomnvar(self.var_5716.var_C4A1,int(self.var_13F0A));
	thread func_139F6(param_00,param_01);
	thread func_13A22(param_00,param_01);
	thread scripts\mp\killstreaks\_utility::watchsupertrophynotify(param_00);
	param_01.var_C239--;
	param_00 setclientomnvar("ui_thor_missiles_loaded",param_01.var_C239);
	scripts\mp\_hostmigration::func_13708(0.1);
	if(param_01.var_C239 > 0)
	{
		param_01 notify("finished_single_fire");
	}
	else
	{
		param_01 scriptmodelplayanim("iw7_mp_killstreak_thor_extend_reload",1);
		scripts\mp\_hostmigration::func_13708(2);
		param_01 notify("start_reload");
	}

	param_01.var_9BE2 = undefined;
}

//Function Number: 53
func_1179E()
{
	self endon("death");
	self endon("leaving");
	var_00 = 0;
	for(;;)
	{
		self waittill("start_reload");
		if(var_00 == 20)
		{
			func_1179C(3);
			self notify("death");
		}

		thread func_1179B();
		var_00++;
	}
}

//Function Number: 54
func_1179B()
{
	self endon("death");
	var_00 = self.var_222;
	var_00 endon("disconnect");
	var_00 endon("thor_missile_fire_success");
	level endon("game_ended");
	func_1179C(3);
	if(self.var_C239 < self.var_B47C)
	{
		self.var_9C9F = 1;
		var_00 playlocalsound("thor_missile_reload");
		thread func_510A(1);
		while(self.var_C239 < self.var_B47C)
		{
			self.var_C239++;
			var_00 setclientomnvar("ui_thor_missiles_loaded",self.var_C239);
			self.var_B88C[self.var_C239 - 1].var_9B04 = 0;
			self.var_B888[self.var_C239 - 1].var_9B04 = 0;
			var_00 setclientomnvar(self.var_B888[self.var_C239 - 1].var_C4A1,-1);
		}

		return;
	}

	self notify("finished_reload");
}

//Function Number: 55
func_510A(param_00)
{
	self endon("death");
	scripts\mp\_hostmigration::func_13708(param_00);
	self.var_9C9F = undefined;
	self notify("finished_reload");
}

//Function Number: 56
func_12F01(param_00)
{
	self endon("death");
	param_00 endon("disconnect");
	param_00 endon("thor_missile_fire_success");
	level endon("game_ended");
	var_01 = gettime();
	var_02 = var_01 + self.var_DF5C * 1000;
	var_03 = var_01;
	while(var_03 < var_02)
	{
		var_03 = gettime();
		var_04 = var_03 - var_01 / var_02 - var_01;
		var_04 = clamp(var_04,0,1);
		scripts\common\utility::func_136F7();
	}
}

//Function Number: 57
func_13AD4()
{
	self endon("death");
	scripts\mp\_hostmigration::func_13708(1);
	self delete();
}

//Function Number: 58
func_117A6()
{
	self endon("death");
	level endon("game_ended");
	foreach(var_01 in level.var_C928)
	{
		func_20D2(var_01);
	}
}

//Function Number: 59
func_20D2(param_00)
{
	if(level.teambased && param_00.team != self.team)
	{
		return;
	}
	else if(!level.teambased)
	{
		return;
	}

	var_01 = scripts\mp\_utility::func_C794(param_00,"cyan",self.var_222,1,1,"killstreak");
	thread func_E146(var_01,param_00);
}

//Function Number: 60
func_6567(param_00)
{
	return param_00 scripts\mp\_utility::_hasperk("specialty_noplayertarget");
}

//Function Number: 61
func_E146(param_00,param_01,param_02)
{
	if(isdefined(param_01))
	{
		param_01 endon("disconnect");
	}

	level endon("game_ended");
	var_03 = ["leave","death"];
	if(isdefined(param_02))
	{
		scripts\common\utility::func_1372F(var_03,param_02);
	}
	else
	{
		scripts\common\utility::func_13731(var_03);
	}

	scripts\mp\_utility::func_C78F(param_00,param_01);
}

//Function Number: 62
func_117A8()
{
	self endon("death");
	self endon("leaving");
	level endon("game_ended");
	self.var_63AB = 0;
	for(;;)
	{
		level waittill("thor_killed_player",var_00);
		self.var_63AB++;
		self notify("thor_enemy_killed");
	}
}

//Function Number: 63
func_11790(param_00)
{
	self endon("death");
	self endon("leaving");
	level endon("game_ended");
	var_01 = level.var_117B0[self.var_110EA];
	var_02 = 1;
	for(;;)
	{
		self waittill("thor_enemy_killed");
		scripts\mp\_hostmigration::func_13708(var_02);
		if(self.var_63AB > 1)
		{
			self.var_222 scripts\mp\_utility::func_AAEC(var_01.var_1352C);
		}
		else
		{
			self.var_222 scripts\mp\_utility::func_AAEC(var_01.var_1352D);
		}

		self.var_63AB = 0;
	}
}

//Function Number: 64
func_11796()
{
	self endon("death");
	level endon("game_ended");
	for(;;)
	{
		level waittill("connected",var_00);
		var_00 thread func_11797(self);
	}
}

//Function Number: 65
func_11797(param_00)
{
	self endon("disconnect");
	self waittill("spawned_player");
	param_00 func_20D2(self);
}

//Function Number: 66
func_4074()
{
	if(isdefined(self.var_1156A))
	{
		self.var_1156A delete();
	}

	if(isdefined(self.var_C7FF))
	{
		self.var_C7FF delete();
	}

	if(isdefined(self.var_10E4C))
	{
		self.var_10E4C destroy();
	}

	if(isdefined(self.minimapid))
	{
		scripts\mp\objidpoolmanager::returnminimapid(self.minimapid);
	}

	level.var_C20D--;
}

//Function Number: 67
func_117A1()
{
	level endon("game_ended");
	self endon("death");
	self endon("leaving");
	thread scripts\mp\killstreaks\_killstreaks::func_1CA5();
	self waittill("killstreakExit");
	var_00 = level.var_117B0[self.var_110EA];
	scripts\mp\_utility::func_AAE7(var_00.var_13553);
	thread func_11795();
}

//Function Number: 68
func_7FBA(param_00)
{
	var_01 = undefined;
	for(var_02 = 4;var_02 + 1 > 0;var_02--)
	{
		if(!param_00[var_02].var_9B04)
		{
			var_01 = param_00[var_02];
			param_00[var_02].var_9B04 = 1;
			break;
		}
	}

	return var_01;
}

//Function Number: 69
getthormapvisionset(param_00)
{
	var_01 = "";
	switch(param_00)
	{
		case "mp_depot":
		case "mp_hawkwar":
		case "mp_paris":
		case "mp_overflow":
		case "mp_flip":
		case "mp_geneva":
		case "mp_dome_dusk":
		case "mp_rivet":
		case "mp_skyway":
		case "mp_quarry":
		case "mp_breakneck":
		case "mp_junk":
			var_01 = "thorbright_mp";
			break;

		default:
			var_01 = "thor_mp";
			break;
	}

	return var_01;
}