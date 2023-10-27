/*******************************************************************
 * Decompiled By: Bog
 * Decompiled File: scripts\mp\_supers.gsc
 * Game: Call of Duty: Infinite Warfare
 * Platform: PC
 * Function Count: 109
 * Decompile Time: 4293 ms
 * Timestamp: 10/27/2023 12:21:46 AM
*******************************************************************/

//Function Number: 1
init()
{
	level.var_10E4E = [];
	level.var_112A9 = [];
	level.var_1125E = 1;
	level.var_11264 = [];
	scripts\mp\bots\_bots_supers::func_2EA3();
	if(scripts\mp\_utility::func_9D46())
	{
		var_00 = 24;
		var_01 = 25;
		var_02 = 26;
		if(level.gametype == "sd")
		{
			var_02 = 2;
		}
	}
	else
	{
		var_00 = 4;
		var_01 = 14;
		var_02 = 2;
	}

	var_03 = 1;
	for(;;)
	{
		var_04 = tablelookupbyrow("mp/supertable.csv",var_03,0);
		if(!isdefined(var_04) || var_04 == "")
		{
			break;
		}

		var_05 = spawnstruct();
		level.var_10E4E[var_04] = var_05;
		var_05.var_92B8 = var_03;
		var_05.var_DE3F = var_04;
		var_05.var_394 = func_DD68(var_03,1);
		var_05.var_4613 = func_DD68(var_03,var_02,1);
		var_05.var_EC3E = func_DD68(var_03,3,1);
		var_05.var_5F36 = func_DD68(var_03,var_00,1);
		var_05.var_B473 = func_DD68(var_03,5,1);
		var_05.var_130F8 = func_DD68(var_03,10);
		var_05.var_130F9 = func_DD68(var_03,11,1);
		var_05.var_130FA = func_DD68(var_03,12,1);
		var_05.var_BCEF = func_DD68(var_03,13,1);
		var_05.var_8487 = func_DD68(var_03,var_01,1);
		var_05.var_B474 = func_DD68(var_03,15,1);
		var_05.var_12B28 = func_DD68(var_03,17,1);
		var_05.var_2123 = func_DD68(var_03,16);
		var_05.var_9FF8 = func_DD68(var_03,18,1);
		level.var_11264[var_03] = var_04;
		if(!isdefined(level.var_2EFC))
		{
			level.var_2EFC[var_05.var_2123] = [];
		}

		if(!isdefined(level.var_2EFC[var_05.var_2123]))
		{
			level.var_2EFC[var_05.var_2123] = [];
		}

		if(scripts\mp\bots\_bots_supers::func_9F8B(var_04))
		{
			level.var_2EFC[var_05.var_2123][level.var_2EFC[var_05.var_2123].size] = var_04;
		}

		if(!isdefined(var_05.var_394))
		{
			level.var_10E4E[var_04] = undefined;
		}

		if(!isdefined(var_05.var_4613))
		{
			level.var_10E4E[var_04] = undefined;
		}

		if(isdefined(var_05.var_B473))
		{
			if(var_05.var_B473 > 0)
			{
				var_05.var_1616 = var_05.var_5F36 / var_05.var_B473 * 1000;
			}
			else
			{
				var_05.var_1616 = var_05.var_5F36;
			}
		}

		if(isdefined(var_05.var_B474))
		{
			if(var_05.var_B474 > 0)
			{
				var_05.var_1617 = var_05.var_5F36 / var_05.var_B474 * 1000;
			}
		}

		if(isdefined(var_05.var_130F8))
		{
			func_1831(var_05.var_130F8,var_04,var_05);
		}

		if(var_05.var_394 == "<default>")
		{
			var_05.var_394 = "super_default_mp";
		}

		if(isdefined(var_05.var_8487))
		{
			var_05.var_8487 = var_05.var_8487 * 1000;
		}
		else
		{
			var_05.var_8487 = 0;
		}

		if(isdefined(var_05.var_12B28))
		{
			var_05.var_12B28 = var_05.var_12B28 * 1000;
		}
		else
		{
			var_05.var_12B28 = 0;
		}

		var_03++;
	}

	var_06 = tablelookup("mp/superratetable.csv",0,level.gametype,1);
	if(isdefined(var_06) && var_06 != "")
	{
		level.var_1125E = float(var_06);
	}

	func_DF10();
	lib_0E17::func_DD9E();
	lib_0E0E::func_218F();
	lib_0E1B::init();
	lib_0E19::func_1127D();
	lib_0DF8::init();
	scripts\mp\_teleport::init();
	lib_0DF0::func_B703();
	lib_0DDE::func_3CED();
	lib_0E0F::init();
	lib_0E16::func_98AB();
}

//Function Number: 2
func_1831(param_00,param_01,param_02)
{
	param_00 = scripts\mp\_utility::func_8234(param_00);
	level.var_112A9[param_00] = spawnstruct();
	level.var_112A9[param_00].var_11263 = param_01;
	level.var_112A9[param_00].var_10E47 = param_02;
}

//Function Number: 3
func_DF10()
{
	func_DF0F("super_claw",undefined,undefined,undefined,undefined);
	func_DF0F("super_amplify",undefined,::func_12C70,::func_13041,::func_630A);
	func_DF0F("super_overdrive",::func_F7CE,::func_12CFF,undefined,undefined);
	func_DF0F("super_steeldragon",undefined,undefined,undefined,undefined);
	func_DF0F("super_armorup",undefined,undefined,::func_13044,::func_630C);
	func_DF0F("super_chargemode",::func_F68E,::func_12C8F,::func_13052,::func_6313);
	func_DF0F("super_armmgs",undefined,undefined,undefined,undefined);
	func_DF0F("super_reaper",undefined,undefined,::func_130CA,::func_637A);
	func_DF0F("super_rewind",::func_F81E,::func_12D1B,undefined,undefined);
	func_DF0F("super_atomizer",undefined,undefined,undefined,undefined);
	func_DF0F("super_phaseshift",undefined,undefined,::func_130BC,::func_6376);
	func_DF0F("super_teleport",::func_F87E,::func_12D44,undefined,undefined);
	func_DF0F("super_blackholegun",undefined,undefined,::func_1304E,::func_630F);
	func_DF0F("super_supertrophy",undefined,::func_12D3F,::func_130E2,::func_638F);
	func_DF0F("super_microturret",::func_F797,::func_12CEF,::func_130A4,::func_6364);
	func_DF0F("super_penetrationrailgun",undefined,undefined,undefined,undefined);
	func_DF0F("super_visionpulse",undefined,undefined,::func_130F6,undefined);
	func_DF0F("super_invisible",::func_F75E,::func_12CDA,::func_1309A,::func_635C);
}

//Function Number: 4
func_DF0F(param_00,param_01,param_02,param_03,param_04)
{
	var_05 = level.var_10E4E[param_00];
	if(!isdefined(var_05))
	{
		return;
	}

	var_05.var_F71E = param_01;
	var_05.var_12CC4 = param_02;
	var_05.var_2A7C = param_03;
	var_05.var_6398 = param_04;
	var_05.var_9F1D = 1;
}

//Function Number: 5
func_DD68(param_00,param_01,param_02)
{
	var_03 = tablelookupbyrow("mp/supertable.csv",param_00,param_01);
	if(var_03 == "")
	{
		return undefined;
	}

	if(scripts\mp\_utility::func_9FB3(param_02))
	{
		if(issubstr(var_03,"."))
		{
			var_03 = float(var_03);
		}
		else
		{
			var_03 = int(var_03);
		}
	}

	return var_03;
}

//Function Number: 6
func_83A8(param_00,param_01)
{
	func_41E2(param_01);
	var_02 = level.var_10E4E[param_00];
	if(!isdefined(var_02))
	{
		return;
	}

	var_03 = spawnstruct();
	self.var_11234 = var_03;
	var_03.var_10E47 = var_02;
	var_03.var_9E53 = 0;
	var_03.var_461F = undefined;
	var_03.var_461E = undefined;
	var_03.var_130DE = undefined;
	var_03.var_130EF = undefined;
	var_03.var_1CA3 = 1;
	var_03.var_B143 = -1;
	var_03.var_C234 = 0;
	var_03.var_1391B = 0;
	var_03.var_3916 = 0;
	var_04 = var_03.var_10E47.var_F71E;
	if(isdefined(var_04))
	{
		self thread [[ var_04 ]]();
	}

	self setclientomnvar("ui_super_ref",param_00);
	var_05 = 0;
	var_06 = self.pers["superCooldownTime"];
	if(isdefined(var_06))
	{
		var_05 = var_06 / 1000;
		self.pers["superCooldownTime"] = undefined;
	}

	func_E276(var_05);
	if(func_1125C())
	{
		scripts\mp\_utility::func_12C6(var_02.var_394);
		var_07 = scripts\common\utility::func_116D7(func_9F8A(),1,0);
		self setweaponammoclip(var_02.var_394,var_07);
		self method_84C2(var_02.var_394);
	}
	else
	{
		thread func_13B6D();
	}

	thread func_13A6F();
	thread func_12F32();
	thread func_13A61();
	thread func_110C5();
	thread func_89E8();
	thread func_89F0();
}

//Function Number: 7
func_41E2(param_00)
{
	var_01 = func_7E4E();
	if(isdefined(var_01) && isdefined(var_01.var_10E47))
	{
		var_02 = var_01.var_10E47.var_12CC4;
		if(isdefined(var_02))
		{
			self thread [[ var_02 ]]();
		}
	}

	if(scripts\mp\_utility::func_9FB3(param_00) && isdefined(var_01))
	{
		func_110C4();
	}

	self method_84C3();
	if(isdefined(var_01))
	{
		scripts\mp\_utility::func_141E(var_01.var_10E47.var_394);
	}

	if(getdvarint("com_codcasterEnabled",0) == 1)
	{
		self method_80C5(0);
	}

	self notify("remove_super");
	self.var_11234 = undefined;
	self setclientomnvar("ui_super_state",0);
	self setclientomnvar("ui_super_ref","none");
}

//Function Number: 8
func_E276(param_00)
{
	var_01 = func_7E4E();
	var_01.var_461E = getsupermaxcooldownmsec();
	var_01.var_461F = 0;
	var_01.var_1CA3 = 1;
	if(isdefined(param_00))
	{
		var_01.var_461F = var_01.var_461F + int(param_00 * 1000);
		var_01.var_461F = int(min(var_01.var_461F,var_01.var_461E));
	}

	self setclientomnvar("ui_super_state",1);
	self setweaponammoclip(var_01.var_10E47.var_394,0);
	func_11257();
}

//Function Number: 9
func_DE3A(param_00)
{
	var_01 = func_7E4E();
	param_00 = int(param_00);
	var_01.var_461F = var_01.var_461F + param_00;
	func_11257();
}

//Function Number: 10
func_11257()
{
	self notify("super_cooldown_altered");
	thread func_12F31();
}

//Function Number: 11
func_83AA(param_00)
{
	var_01 = func_7E4E();
	if(!isdefined(var_01) || !isdefined(var_01.var_10E47.var_EC3E) || func_9F8A() || var_01.var_9E53)
	{
		return;
	}

	var_02 = param_00 / 100 * level.superpointsmod * var_01.var_10E47.var_EC3E * 1000;
	func_DE3A(var_02);
	scripts\mp\_analyticslog::func_AFAF(param_00,gettime());
}

//Function Number: 12
func_12F32()
{
	self endon("disconnect");
	self endon("remove_super");
	for(;;)
	{
		var_00 = func_7E4E();
		var_01 = 0;
		if(var_00.var_9E53)
		{
			var_01 = func_818B();
		}
		else
		{
			var_02 = var_00.var_461E - var_00.var_461F;
			var_03 = getsupermaxcooldownmsec();
			var_01 = clamp(1 - var_02 / var_03,0,1);
		}

		if(!scripts\mp\_utility::func_9E4A() && isalive(self))
		{
			self setclientomnvar("ui_super_progress",var_01);
		}

		self method_8400(var_01);
		scripts\common\utility::func_136F7();
	}
}

//Function Number: 13
func_13A61()
{
	var_00 = func_7E4E();
	self endon("disconnect");
	self endon("remove_super");
	for(;;)
	{
		self waittill("spawned_player");
		if(func_9F8A())
		{
			scripts\mp\_lightbar::func_1768(2,1,1,1,0,"super_use_finished");
			self setclientomnvar("ui_super_state",2);
		}

		givesuperweapon(var_00);
	}
}

//Function Number: 14
func_12F31()
{
	self endon("disconnect");
	self endon("super_cooldown_altered");
	self endon("remove_super");
	self endon("game_ended");
	var_00 = func_7E4E();
	self notify("super_finished");
	while(func_9F89())
	{
		scripts\mp\_utility::func_7670("prematch_done");
		if(scripts\mp\_utility::func_9FB3(level.var_90A4))
		{
			scripts\common\utility::func_136F7();
			continue;
		}

		var_01 = int(50 * level.var_11260 * scripts\common\utility::func_116D7(scripts\mp\_utility::_hasperk("specialty_overclock"),1.4,1));
		var_00.var_461F = var_00.var_461F + var_01;
		wait(0.05);
	}

	func_11258();
}

//Function Number: 15
func_110C5()
{
	self endon("disconnect");
	self endon("remove_super");
	scripts\mp\_utility::func_ABF5("game_over");
	func_110C4();
}

//Function Number: 16
func_89E8()
{
	self endon("disconnect");
	self endon("remove_super");
	self waittill("joined_spectators");
	thread func_41E2(1);
}

//Function Number: 17
func_89F0()
{
	self endon("disconnect");
	self endon("remove_super");
	var_00 = self.team;
	self waittill("joined_team");
	if(self.team != var_00)
	{
		thread func_41E2(0);
	}
}

//Function Number: 18
func_11258()
{
	var_00 = func_7E4E();
	self setweaponammoclip(var_00.var_10E47.var_394,1);
	self setclientomnvar("ui_super_state",2);
	self playlocalsound("mp_super_ready");
	self notify("super_ready");
	if(!var_00.var_1391B)
	{
		self.pers["supersEarned"]++;
		self notify("super_earned");
	}

	scripts\mp\_lightbar::func_1768(2,1,1,1,0,"super_use_finished_lb");
	var_00.var_B143 = gettime();
	var_00.var_C234 = 0;
	scripts\mp\_analyticslog::func_AFB3(var_00.var_B143);
	if(isdefined(self.var_B3E3))
	{
		scripts\mp\_matchdata::logsuperavailableevent(self.var_B3E3,self.origin);
	}
}

//Function Number: 19
func_13A6F()
{
	self endon("disconnect");
	self endon("remove_super");
	for(;;)
	{
		self waittill("special_weapon_fired",var_00);
		if(scripts\mp\_utility::func_9F19(self))
		{
			if(var_00 != func_7E4E().var_10E47.var_394)
			{
				continue;
			}

			var_01 = func_2A79();
			if(!isdefined(var_01) || var_01 == 0)
			{
				continue;
			}

			self waittill("super_use_finished");
		}
	}
}

//Function Number: 20
func_2A79()
{
	self endon("death");
	self endon("disconnect");
	var_00 = func_7E4E();
	self notify("super_started");
	self playlocalsound("weap_super_activate_plr");
	if(isdefined(var_00) && !var_00.var_9E53)
	{
		var_01 = 1;
		if(isdefined(var_00.var_10E47.var_130F8))
		{
			if(scripts\mp\_utility::isinarbitraryup() && superdisabledinarbitraryup(var_00.var_10E47.var_DE3F))
			{
				superdisabledinarbitraryupmessage();
				var_01 = 0;
			}
			else if(scripts\mp\_utility::istryingtousekillstreak() && superdisabledduringkillstreak(var_00.var_10E47.var_DE3F))
			{
				superdisabledduringkillstreakmessage();
				var_01 = 0;
			}
			else
			{
				var_01 = func_1289E(var_00.var_10E47.var_130F8,var_00.var_10E47.var_130F9,var_00.var_10E47.var_130FA);
			}
		}

		if(var_01 && !isdefined(var_00.var_10E47.var_2A7C) || scripts\mp\_utility::func_9FB3(self [[ var_00.var_10E47.var_2A7C ]]()))
		{
			var_02 = [];
			var_02[0] = "super_use_finished_lb";
			var_02[1] = "super_switched";
			scripts\mp\_lightbar::func_1768(2,0,2,1,0,var_02);
			var_00.var_9E53 = 1;
			var_00.var_1CA3 = scripts\common\utility::func_116D7(var_00.var_10E47.var_8487 > 0,1,0);
			func_10DF7();
			if(isdefined(self.var_B3E3))
			{
				scripts\mp\_matchdata::logsuperactivatedevent(self.var_B3E3,self.origin);
			}

			self setclientomnvar("ui_super_state",3);
			if(getdvarint("com_codcasterEnabled",0) == 1)
			{
				self method_80C5(1);
			}

			scripts\mp\_utility::func_D915("super use started - " + var_00.var_10E47.var_DE3F,self);
			return 1;
		}
		else
		{
			if(isdefined(var_01.var_10E47.var_130F8) && var_02)
			{
				thread func_11371();
			}

			self setweaponammoclip(var_01.var_10E47.var_394,1);
		}
	}

	return 0;
}

//Function Number: 21
func_1613(param_00,param_01)
{
	var_02 = func_7E4E();
	if(!isdefined(param_00))
	{
		param_00 = 0;
	}

	if(!isdefined(param_01))
	{
		param_01 = 1;
	}

	var_03 = gettime();
	if(var_02.var_12B2C > var_03)
	{
		var_02.var_12B2C = var_03;
	}

	if(param_00 && isdefined(var_02.var_10E47.var_1617))
	{
		func_DE3B(var_02.var_10E47.var_1617 * param_01);
	}
	else if(isdefined(var_02.var_10E47.var_1616))
	{
		func_DE3B(var_02.var_10E47.var_1616 * param_01);
	}

	return 1;
}

//Function Number: 22
func_10DF7()
{
	var_00 = func_7E4E();
	self notify("super_use_started");
	var_00.var_130DE = gettime();
	var_00.var_130EF = func_8188() * 1000;
	var_00.var_12B2C = gettime() + var_00.var_10E47.var_12B28;
	func_112A5();
}

//Function Number: 23
func_DE3B(param_00)
{
	var_01 = func_7E4E();
	self setclientomnvar("ui_super_flash_progress",func_818B());
	var_01.var_130EF = max(var_01.var_130EF - param_00,0);
	var_01.var_1CA3 = 0;
	func_112A5();
}

//Function Number: 24
func_112A5()
{
	self notify("super_use_duration_updated");
	thread func_13B71();
}

//Function Number: 25
func_13B71()
{
	self endon("disconnect");
	self endon("super_use_duration_updated");
	self endon("super_use_finished");
	self endon("remove_super");
	var_00 = func_7E4E();
	while(var_00.var_130EF > 0)
	{
		if(scripts\mp\_utility::func_9FB3(level.var_90A4))
		{
			scripts\common\utility::func_136F7();
			continue;
		}

		scripts\common\utility::func_136F7();
		var_00.var_130EF = var_00.var_130EF - 50;
		if(isbot(self))
		{
			if(isdefined(var_00.var_10E47.var_130F8) && var_00.var_10E47.var_9FF8 == 1)
			{
				var_01 = self method_80FB(var_00.var_10E47.var_130F8);
				if(!isdefined(var_01) || var_01 <= 0)
				{
					break;
				}
			}
		}
	}

	func_112A6();
}

//Function Number: 26
func_112A6(param_00,param_01,param_02)
{
	var_03 = func_7E4E();
	var_04 = func_818B();
	self notify("super_use_finished_lb");
	var_03.var_9E53 = 0;
	var_03.var_3916 = 0;
	var_05 = undefined;
	if(isdefined(var_03.var_10E47.var_6398))
	{
		if(!isdefined(param_01))
		{
			param_01 = 0;
		}

		var_05 = self [[ var_03.var_10E47.var_6398 ]](param_01);
	}

	if(func_10066(param_02) || scripts\mp\_utility::func_9FB3(param_00) || scripts\mp\_utility::func_9FB3(var_05))
	{
		var_03.var_1391B = 1;
		func_E276(getsupermaxcooldownsec());
	}
	else if(scripts\mp\_utility::func_9FB3(param_02))
	{
		var_06 = getsupermaxcooldownsec() * var_04;
		var_03.var_1391B = 1;
		func_E276(var_06);
	}
	else
	{
		if(var_03.var_10E47.var_DE3F != "super_chargemode")
		{
			var_07 = getsubstr(self.var_AE62,10,self.var_AE62.size);
			scripts\mp\_missions::func_D991("ch_" + var_07 + "_super");
			combatrecordsuperuse(var_03.var_10E47.var_DE3F);
		}

		var_03.var_A986 = gettime();
		var_03.var_1391B = 0;
		func_E276();
	}

	thread func_11371();
	var_08 = var_03.var_130DE - var_03.var_B143;
	scripts\mp\_analyticslog::func_AFB4(var_03.var_10E47.var_DE3F,var_08,0,var_03.var_C234);
	if(getdvarint("com_codcasterEnabled",0) == 1)
	{
		self method_80C5(0);
	}

	scripts\mp\_utility::func_D915("super use ended - " + var_03.var_10E47.var_DE3F,self);
	if(isdefined(self.var_B3E3))
	{
		if(isdefined(param_01))
		{
			scripts\mp\_matchdata::logsuperexpiredevent(self.var_B3E3,self.origin,1);
		}
		else
		{
			scripts\mp\_matchdata::logsuperexpiredevent(self.var_B3E3,self.origin,0);
		}
	}

	self notify("super_use_finished");
}

//Function Number: 27
func_DE7D()
{
	var_00 = func_7E4E();
	if(isdefined(var_00))
	{
		if(var_00.var_9E53)
		{
			func_112A6(1);
			return;
		}

		func_DE3A(getsupermaxcooldownmsec());
	}
}

//Function Number: 28
func_898E()
{
	self endon("disconnect");
	if(!func_9F88())
	{
		return;
	}

	func_112A6(undefined,1);
}

//Function Number: 29
func_BA37(param_00)
{
	self endon("disconnect");
	self endon("death");
	self endon("super_use_finished");
	self endon("remove_super");
	for(;;)
	{
		self waittill("weapon_fired",var_01);
		var_02 = scripts\mp\_weapons::func_9D3E(var_01);
		var_01 = scripts\mp\_utility::func_E0CF(var_01);
		if(var_01 == param_00)
		{
			func_1613(var_02);
		}
	}
}

//Function Number: 30
func_1289E(param_00,param_01,param_02)
{
	self endon("disconnect");
	self endon("death");
	scripts\mp\_utility::func_12C6(param_00);
	self setweaponammoclip(param_00,param_01);
	self setweaponammostock(param_00,param_02);
	var_03 = scripts\mp\_utility::func_11383(param_00,isbot(self));
	if(var_03)
	{
		thread func_B2F7(param_00);
		thread func_BA37(param_00);
		return 1;
	}

	scripts\mp\_utility::func_1529(param_00);
	return 0;
}

//Function Number: 31
func_B2F7(param_00)
{
	self endon("disconnect");
	self endon("death");
	self endon("super_use_finished");
	var_01 = func_7E4E();
	var_01.useweaponswapped = undefined;
	var_02 = 0;
	for(;;)
	{
		var_03 = self getcurrentweapon();
		if(!var_01.var_3916 && var_03 != "iw7_fistslethal_mp" && var_03 != "iw7_fistsperk_mp" && var_03 != param_00)
		{
			if(var_03 == "iw7_uplinkball_mp" || var_03 == "iw7_tdefball_mp")
			{
				var_02 = 1;
			}

			break;
		}

		scripts\common\utility::func_136F7();
	}

	if(func_9F88())
	{
		var_01.useweaponswapped = 1;
		func_112A6(undefined,undefined,var_02);
	}
}

//Function Number: 32
func_11371()
{
	self endon("death");
	var_00 = func_7E4E();
	var_01 = var_00.var_10E47.var_130F8;
	if(!isdefined(var_01))
	{
		return;
	}

	if(scripts\mp\_utility::func_9F20(var_01))
	{
		scripts\mp\_utility::func_1529(var_01);
		return;
	}

	self notify("super_switched");
	scripts\mp\_utility::func_80F2(var_01);
}

//Function Number: 33
func_110C4()
{
	var_00 = func_7E4E();
	if(!isdefined(var_00))
	{
		return;
	}

	if(func_9F89())
	{
		self.pers["superCooldownTime"] = func_7E4E().var_461F;
		return;
	}

	if(func_9F8A())
	{
		self.pers["superCooldownTime"] = func_7E4E().var_461E;
		return;
	}

	if(func_9F88())
	{
		self.pers["superCooldownTime"] = scripts\common\utility::func_116D7(func_10066(),func_7E4E().var_461E,0);
		return;
	}

	self.pers["superCooldownTime"] = 0;
}

//Function Number: 34
func_818B()
{
	var_00 = func_7E4E();
	var_01 = gettime();
	var_02 = var_00.var_12B2C - var_00.var_130DE;
	var_03 = func_8188() * 1000 - var_02;
	var_04 = clamp(var_00.var_130EF / var_03,0,1);
	return var_04;
}

//Function Number: 35
getsupermaxcooldownsec()
{
	var_00 = func_7E4E().var_10E47.var_4613 * level.var_1125E;
	return scripts\common\utility::func_116D7(getdvarint("scr_super_short_cooldown") != 0,1,var_00);
}

//Function Number: 36
getsupermaxcooldownmsec()
{
	return int(getsupermaxcooldownsec() * 1000);
}

//Function Number: 37
func_8188()
{
	return func_7E4E().var_10E47.var_5F36;
}

//Function Number: 38
func_9F8A()
{
	var_00 = func_7E4E();
	if(!isdefined(var_00) || var_00.var_9E53)
	{
		return 0;
	}

	return var_00.var_461F >= var_00.var_461E;
}

//Function Number: 39
func_9F88()
{
	return isdefined(func_7E4E()) && func_7E4E().var_9E53;
}

//Function Number: 40
func_9F89()
{
	return !func_9F8A() && !func_9F88();
}

//Function Number: 41
func_7E4E()
{
	return self.var_11234;
}

//Function Number: 42
func_7E4F()
{
	var_00 = func_7E4E();
	if(!isdefined(var_00))
	{
		return undefined;
	}

	return var_00.var_10E47.var_DE3F;
}

//Function Number: 43
func_10066(param_00)
{
	var_01 = func_7E4E();
	var_02 = var_01.var_10E47.var_8487;
	var_03 = gettime() - var_01.var_130DE;
	if(var_03 >= var_02)
	{
		return 0;
	}

	if(var_01.var_C234 > 0)
	{
		return 0;
	}

	if(scripts\mp\_utility::func_9FB3(var_01.useweaponswapped) && !scripts\mp\_utility::func_9FB3(param_00))
	{
		if(var_01.var_10E47.var_130F8 == "iw7_reaperblade_mp")
		{
			return 0;
		}
	}

	return var_01.var_1CA3;
}

//Function Number: 44
func_11759()
{
	iprintlnbold("Super FIRST activate");
	thread func_11758();
	return 1;
}

//Function Number: 45
func_11758()
{
	self endon("disconnect");
	self endon("death");
	self endon("super_use_finished");
	self notifyonplayercommand("testsuper_fired","+frag");
	for(;;)
	{
		self waittill("testsuper_fired");
		iprintlnbold("activate");
		func_1613();
	}
}

//Function Number: 46
func_130EA()
{
	return func_11759();
}

//Function Number: 47
func_130CA()
{
	return lib_0E17::func_DD9D();
}

//Function Number: 48
func_637A(param_00)
{
	lib_0E17::func_DD97();
}

//Function Number: 49
func_1304E()
{
	return lib_0E0F::func_2A7B();
}

//Function Number: 50
func_630F(param_00)
{
	lib_0E0F::func_1109A();
}

//Function Number: 51
func_13044()
{
	return lib_0E0E::func_2197();
}

//Function Number: 52
func_630C(param_00)
{
	lib_0E0E::func_218E(param_00);
}

//Function Number: 53
func_13041()
{
	return lib_0E0D::func_12F9B();
}

//Function Number: 54
func_630A(param_00)
{
	lib_0E0D::func_62A3();
}

//Function Number: 55
func_12C70()
{
	lib_0E0D::func_12BF4();
}

//Function Number: 56
func_F7CE()
{
	lib_0E16::func_F7CE();
}

//Function Number: 57
func_12CFF()
{
	lib_0E16::func_12CFF();
}

//Function Number: 58
func_1308A()
{
	return lib_0E12::func_8541();
}

//Function Number: 59
func_6332()
{
	lib_0E12::func_853F();
}

//Function Number: 60
func_130F6()
{
	return lib_0E1B::func_12F9B();
}

//Function Number: 61
func_1303A()
{
	return lib_0E0C::func_14F9();
}

//Function Number: 62
func_6308()
{
	lib_0E0C::func_14F7();
}

//Function Number: 63
func_130A3()
{
	return lib_0E14::func_B554();
}

//Function Number: 64
func_6361()
{
	lib_0E14::func_B552();
}

//Function Number: 65
func_F75E()
{
}

//Function Number: 66
func_12CDA()
{
	lib_0DDF::func_62A3(undefined,1);
}

//Function Number: 67
func_1309A()
{
	return lib_0DDF::func_12F9B();
}

//Function Number: 68
func_635C(param_00)
{
	lib_0DDF::func_62A3(param_00);
}

//Function Number: 69
func_130E2()
{
	return lib_0E19::func_11297();
}

//Function Number: 70
func_638F(param_00)
{
	return lib_0E19::func_11276(param_00);
}

//Function Number: 71
func_12D3F(param_00)
{
	lib_0E19::func_11296(param_00);
}

//Function Number: 72
func_130BC()
{
	return lib_0DF8::func_E88D();
}

//Function Number: 73
func_6376(param_00)
{
	lib_0DF8::func_E154(param_00);
}

//Function Number: 74
func_F797()
{
	lib_0DF0::func_B70A();
}

//Function Number: 75
func_12CEF()
{
	lib_0DF0::func_B718();
}

//Function Number: 76
func_130A4()
{
	lib_0DF0::func_B719();
	return 1;
}

//Function Number: 77
func_6364(param_00)
{
	return lib_0DF0::func_B6F9(param_00);
}

//Function Number: 78
func_F68E()
{
	lib_0DDE::func_3D0E();
}

//Function Number: 79
func_12C8F()
{
	lib_0DDE::func_3D19();
}

//Function Number: 80
func_13052()
{
	return lib_0DDE::func_3D1A();
}

//Function Number: 81
func_6313(param_00)
{
	lib_0DDE::func_3CDD(param_00);
}

//Function Number: 82
func_F81E()
{
	lib_0DFE::func_F81E();
}

//Function Number: 83
func_12D1B()
{
	lib_0DFE::func_12D1B();
}

//Function Number: 84
func_F87E()
{
	thread scripts\mp\_teleport::func_F87E();
}

//Function Number: 85
func_12D44()
{
	thread scripts\mp\_teleport::func_12D44();
}

//Function Number: 86
func_1309C()
{
	thread lib_0DED::kineticpulse_use();
	return 1;
}

//Function Number: 87
func_8189(param_00)
{
	param_00 = scripts\mp\_utility::func_8234(param_00);
	if(!isdefined(level.var_112A9[param_00]))
	{
		return undefined;
	}

	return level.var_112A9[param_00].var_11263;
}

//Function Number: 88
func_7F0D(param_00)
{
	param_00 = scripts\mp\_utility::func_8234(param_00);
	if(isdefined(level.var_112A9[param_00]))
	{
		return level.var_112A9[param_00].var_10E47.var_92B8;
	}

	var_01 = undefined;
	switch(param_00)
	{
		case "micro_turret_gun_mp":
			var_01 = "super_microturret";
			break;

		case "chargemode_mp":
			var_01 = "super_chargemode";
			break;
	}

	if(isdefined(var_01))
	{
		var_02 = level.var_10E4E[var_01];
		if(isdefined(var_02))
		{
			return var_02.var_92B8;
		}
	}

	return undefined;
}

//Function Number: 89
func_8186(param_00)
{
	if(!isdefined(param_00) || !isdefined(level.var_10E4E[param_00]) || param_00 == "none")
	{
		return 0;
	}

	return level.var_10E4E[param_00].var_92B8;
}

//Function Number: 90
func_7FD0(param_00)
{
	param_00 = scripts\mp\_utility::func_8234(param_00);
	if(!isdefined(level.var_112A9[param_00]))
	{
		return undefined;
	}

	return level.var_112A9[param_00].var_10E47.var_BCEF;
}

//Function Number: 91
func_80F6(param_00)
{
	return getsubstr(param_00,6);
}

//Function Number: 92
func_1CAB()
{
	var_00 = func_7E4E();
	if(!isdefined(var_00) || !var_00.var_9E53)
	{
		return;
	}

	var_00.var_3916 = 1;
}

//Function Number: 93
func_12D6C()
{
	var_00 = func_7E4E();
	if(!isdefined(var_00) || !var_00.var_3916)
	{
		return;
	}

	if(!var_00.var_9E53 || !isdefined(var_00.var_10E47.var_130F8))
	{
		var_00.var_3916 = 0;
		return;
	}

	scripts\mp\_utility::func_11383(var_00.var_10E47.var_130F8);
	var_00.var_3916 = 0;
}

//Function Number: 94
modifysuperequipmentdamage(param_00,param_01,param_02,param_03,param_04)
{
	var_05 = param_03;
	if(isdefined(self.var_222) && isdefined(param_00) && param_00 == self.var_222)
	{
		var_05 = int(ceil(param_03 * 0.5));
	}

	return var_05;
}

//Function Number: 95
func_13B6B()
{
	level endon("super_delay_end");
	level endon("round_end");
	level endon("game_ended");
	level waittill("prematch_over");
	if(scripts\mp\_utility::func_9D46())
	{
		level.var_1125A = 0;
	}
	else
	{
		level.var_1125A = getdvarfloat("scr_superDelay",0);
	}

	if(level.var_1125A == 0)
	{
		level.var_1125D = scripts\mp\_utility::func_81CB();
		level.var_1125B = level.var_1125D;
		level notify("super_delay_end");
	}

	level.var_1125D = scripts\mp\_utility::func_81CB();
	level.var_1125B = level.var_1125D + level.var_1125A * 1000;
	level notify("super_delay_start");
	while(scripts\mp\_utility::func_81CB() < level.var_1125B)
	{
		scripts\common\utility::func_136F7();
	}

	level notify("super_delay_end");
}

//Function Number: 96
func_13B6D()
{
	self endon("remove_super");
	self endon("disconnect");
	level endon("round_end");
	level endon("game_ended");
	func_83A9();
	thread func_411B();
	func_13B6E();
	var_00 = func_7E4E().var_10E47.var_394;
	var_01 = scripts\common\utility::func_116D7(func_9F8A(),1,0);
	scripts\mp\_utility::func_12C6(var_00);
	self setweaponammoclip(var_00,var_01);
	self method_84C2(var_00);
	scripts\mp\_utility::func_141E("super_delay_mp");
}

//Function Number: 97
func_13B6E()
{
	level endon("super_delay_end");
	if(!scripts\mp\_utility::func_9FB3(scripts\mp\_utility::func_766C("prematch_done")))
	{
		level waittill("super_delay_start");
	}

	for(;;)
	{
		self waittill("special_weapon_fired",var_00);
		if(var_00 != "super_delay_mp")
		{
			continue;
		}

		self setweaponammoclip("super_delay_mp",1);
		if(func_9F8A())
		{
			var_01 = level.var_1125B - scripts\mp\_utility::func_81CB() / 1000;
			var_01 = int(max(0,ceil(var_01)));
			scripts\mp\_hud_message::func_10122("MP_SUPERS_UNAVAILABLE_FOR_N",var_01);
		}
	}
}

//Function Number: 98
func_411B()
{
	self endon("disconnect");
	level endon("round_end");
	level endon("game_ended");
	level endon("super_delay_end");
	self notify("watchSuperDelayWeaponCleanup");
	self endon("watchSuperDelayWeaponCleanup");
	self waittill("remove_super");
	scripts\mp\_utility::func_141E("super_delay_mp");
}

//Function Number: 99
func_83A9()
{
	scripts\mp\_utility::func_12C6("super_delay_mp");
	self setweaponammoclip("super_delay_mp",1);
	self method_84C2("super_delay_mp");
}

//Function Number: 100
func_3887()
{
	level.var_1125A = 0;
	level.var_1125D = scripts\mp\_utility::func_81CB();
	level.var_1125B = level.var_1125D;
	level notify("super_delay_end");
}

//Function Number: 101
func_1125C()
{
	if(isdefined(level.var_1125A) && level.var_1125A == 0)
	{
		return 1;
	}

	return isdefined(level.var_1125B) && scripts\mp\_utility::func_81CB() > level.var_1125B;
}

//Function Number: 102
givesuperweapon(param_00)
{
	if(func_1125C())
	{
		if(!self hasweapon(param_00.var_10E47.var_394))
		{
			var_01 = scripts\common\utility::func_116D7(func_9F8A(),1,0);
			scripts\mp\_utility::func_12C6(param_00.var_10E47.var_394);
			self setweaponammoclip(param_00.var_10E47.var_394,var_01);
			self method_84C2(param_00.var_10E47.var_394);
			return;
		}

		return;
	}

	func_83A9();
}

//Function Number: 103
watchobjuse(param_00,param_01)
{
	self endon("death");
	self endon("disconnect");
	self endon("obj_drain_end");
	self endon("ball_dropped");
	if(level.gametype == "sd" || level.gametype == "sr" || level.gametype == "dd")
	{
		if(scripts\mp\_utility::func_9FB3(param_01))
		{
			self waittill("super_obj_drain");
		}
	}
	else if(!isdefined(self.var_3AF7))
	{
		self waittill("obj_picked_up");
	}
	else
	{
		wait(0.05);
	}

	while(func_9F88())
	{
		func_DE3B(param_00);
		wait(0.05);
	}
}

//Function Number: 104
combatrecordsuperuse(param_00)
{
	if(!scripts\mp\_utility::canrecordcombatrecordstats())
	{
		return;
	}

	var_01 = self getplayerdata("mp","superStats",param_00,"uses");
	self setplayerdata("mp","superStats",param_00,"uses",var_01 + 1);
}

//Function Number: 105
combatrecordsuperkill(param_00)
{
	if(!scripts\mp\_utility::canrecordcombatrecordstats())
	{
		return;
	}

	var_01 = self getplayerdata("mp","superStats",param_00,"kills");
	self setplayerdata("mp","superStats",param_00,"kills",var_01 + 1);
}

//Function Number: 106
superdisabledinarbitraryup(param_00)
{
	if(param_00 == "super_microturret" || param_00 == "super_supertrophy")
	{
		return 1;
	}

	return 0;
}

//Function Number: 107
superdisabledinarbitraryupmessage()
{
	scripts\mp\_hud_message::func_10122("MP_SUPERS_UNAVAILABLE_ARB_UP");
}

//Function Number: 108
superdisabledduringkillstreak(param_00)
{
	switch(param_00)
	{
		case "super_visionpulse":
		case "super_invisible":
		case "super_armorup":
		case "super_amplify":
			return 0;

		default:
			return 1;
	}
}

//Function Number: 109
superdisabledduringkillstreakmessage()
{
	scripts\mp\_hud_message::func_10122("MP_SUPERS_UNAVAILABLE_ARB_UP");
}