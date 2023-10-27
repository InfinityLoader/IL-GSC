/*******************************************************************
 * Decompiled By: Bog
 * Decompiled File: scripts\cp\utility.gsc
 * Game: Call of Duty: Infinite Warfare
 * Platform: PC
 * Function Count: 354
 * Decompile Time: 17063 ms
 * Timestamp: 10/27/2023 12:10:48 AM
*******************************************************************/

//Function Number: 1
func_12C6(param_00,param_01,param_02,param_03)
{
	if(!isdefined(param_01))
	{
		param_01 = -1;
	}

	if(!isdefined(param_03))
	{
		param_03 = 0;
	}

	if(issubstr(param_00,"+akimbo") || issubstr(param_00,"+g18pap2") || isdefined(param_02) && param_02 == 1)
	{
		self giveweapon(param_00,param_01,1,-1,param_03);
	}
	else
	{
		self giveweapon(param_00,param_01,0,-1,param_03);
	}

	thread func_12EBE(param_00);
	return param_00;
}

//Function Number: 2
func_12EBE(param_00)
{
	if(isdefined(param_00))
	{
		if(isdefined(level.last_stand_weapons))
		{
			var_01 = getweaponbasename(param_00);
			if(scripts\common\utility::func_2286(level.last_stand_weapons,var_01))
			{
				self.var_A913 = param_00;
				return;
			}
		}
	}

	var_02 = self getweaponslistall();
	var_03 = getweaponbasename(self.var_A913);
	var_04 = 0;
	foreach(var_06 in var_02)
	{
		var_07 = getweaponbasename(var_06);
		if(var_07 == var_03)
		{
			var_04 = 1;
			return;
		}
	}

	if(!var_04)
	{
		if(isdefined(level.last_stand_weapons))
		{
			foreach(var_06 in var_02)
			{
				var_07 = getweaponbasename(var_06);
				for(var_0A = level.last_stand_weapons.size - 1;var_0A > -1;var_0A--)
				{
					if(var_07 == level.last_stand_weapons[var_0A])
					{
						var_04 = 1;
						self.var_A913 = var_06;
						return;
					}
				}
			}
		}

		var_0C = func_80D8(self.var_501C);
		if(isdefined(self.var_13C00[var_0C]))
		{
			self.var_A913 = self.var_13C00[var_0C];
			return;
		}

		self.var_A913 = self.var_501C;
	}
}

//Function Number: 3
func_8387(param_00)
{
	if(issubstr(param_00,"specialty_weapon_"))
	{
		func_13D1(param_00);
		return;
	}

	func_13D1(param_00);
	func_13CC(param_00);
}

//Function Number: 4
_hasperk(param_00)
{
	var_01 = self.var_CA5B;
	if(!isdefined(var_01))
	{
		return 0;
	}

	if(isdefined(var_01[param_00]))
	{
		return 1;
	}

	return 0;
}

//Function Number: 5
func_13D1(param_00)
{
	self.var_CA5B[param_00] = 1;
	self.var_CA61[param_00] = param_00;
	var_01 = level.var_CA60[param_00];
	if(isdefined(var_01))
	{
		self thread [[ var_01 ]]();
	}

	self method_8320(param_00,!isdefined(level.var_EF86[param_00]));
}

//Function Number: 6
func_1430(param_00)
{
	self.var_CA5B[param_00] = undefined;
	self.var_CA61[param_00] = undefined;
	if(isdefined(level.var_CA66[param_00]))
	{
		self thread [[ level.var_CA66[param_00] ]]();
	}

	self method_83CC(param_00,!isdefined(level.var_EF86[param_00]));
}

//Function Number: 7
func_13CC(param_00)
{
	if(param_00 == "specialty_stun_resistance")
	{
		func_8387("specialty_empimmune");
	}

	if(param_00 == "specialty_hardline")
	{
		func_8387("specialty_assists");
	}

	if(param_00 == "specialty_incog")
	{
		func_8387("specialty_spygame");
		func_8387("specialty_coldblooded");
		func_8387("specialty_noscopeoutline");
		func_8387("specialty_heartbreaker");
	}

	if(param_00 == "specialty_blindeye")
	{
		func_8387("specialty_noplayertarget");
	}

	if(param_00 == "specialty_sharp_focus")
	{
		func_8387("specialty_reducedsway");
	}

	if(param_00 == "specialty_quickswap")
	{
		func_8387("specialty_fastoffhand");
	}
}

//Function Number: 8
func_11AA()
{
	foreach(var_02, var_01 in self.var_CA5B)
	{
		if(isdefined(level.var_CA66[var_02]))
		{
			self [[ level.var_CA66[var_02] ]]();
		}
	}

	self.var_CA5B = [];
	self.var_CA61 = [];
	self method_8077();
}

//Function Number: 9
clearlowermessages()
{
	if(isdefined(self.lowermessages))
	{
		for(var_00 = 0;var_00 < self.lowermessages.size;var_00++)
		{
			self.lowermessages[var_00] = undefined;
		}
	}

	if(!isdefined(self.lowermessage))
	{
		return;
	}

	updatelowermessage();
}

//Function Number: 10
setlowermessage(param_00,param_01,param_02,param_03,param_04,param_05,param_06,param_07,param_08,param_09)
{
	if(!isdefined(param_03))
	{
		param_03 = 1;
	}

	if(!isdefined(param_02))
	{
		param_02 = 0;
	}

	if(!isdefined(param_04))
	{
		param_04 = 0;
	}

	if(!isdefined(param_05))
	{
		param_05 = 0;
	}

	if(!isdefined(param_06))
	{
		param_06 = 0.85;
	}

	if(!isdefined(param_07))
	{
		param_07 = 3;
	}

	if(!isdefined(param_08))
	{
		param_08 = 0;
	}

	if(!isdefined(param_09))
	{
		param_09 = 1;
	}

	addlowermessage(param_00,param_01,param_02,param_03,param_04,param_05,param_06,param_07,param_08,param_09);
	updatelowermessage();
}

//Function Number: 11
play_bink_video(param_00,param_01,param_02)
{
	level thread play_bink_video_internal(param_00,param_01,param_02);
}

//Function Number: 12
play_bink_video_internal(param_00,param_01,param_02)
{
	foreach(var_04 in level.players)
	{
		var_04 func_7385(1);
	}

	setomnvar("bink_video_active",1);
	playcinematicforall(param_00);
	wait(param_01);
	setomnvar("bink_video_active",0);
	foreach(var_04 in level.players)
	{
		var_04 func_7385(0);
		if(!isdefined(param_02) || !param_02)
		{
			var_04 thread func_CF90(0,1,0.5,1);
		}
	}
}

//Function Number: 13
updatelowermessage()
{
	self endon("disconnect");
	if(!isdefined(self))
	{
		return;
	}

	var_00 = getlowermessage();
	if(!isdefined(var_00))
	{
		if(isdefined(self.lowermessage))
		{
			self.lowermessage.alpha = 0;
			self.lowermessage settext("");
			if(isdefined(self.lowertimer))
			{
				self.lowertimer.alpha = 0;
			}
		}

		return;
	}

	self.lowermessage settext(var_00.text);
	self.lowermessage.alpha = 0.85;
	self.lowertimer.alpha = 1;
	self.lowermessage.hidewhenindemo = var_00.hidewhenindemo;
	self.lowermessage.hidewheninmenu = var_00.hidewheninmenu;
	if(var_00.shouldfade)
	{
		self.lowermessage fadeovertime(min(var_00.fadetoalphatime,60));
		self.lowermessage.alpha = var_00.fadetoalphatime;
	}

	if(var_00.time > 0 && var_00.showtimer)
	{
		self.lowertimer settimer(max(var_00.time - gettime() - var_00.addtime / 1000,0.1));
		return;
	}

	if(var_00.time > 0 && !var_00.showtimer)
	{
		self.lowertimer settext("");
		self.lowermessage fadeovertime(min(var_00.time,60));
		self.lowermessage.alpha = 0;
		thread clearondeath(var_00);
		thread clearafterfade(var_00);
		return;
	}

	self.lowertimer settext("");
}

//Function Number: 14
addlowermessage(param_00,param_01,param_02,param_03,param_04,param_05,param_06,param_07,param_08,param_09)
{
	var_0A = undefined;
	foreach(var_0C in self.lowermessages)
	{
		if(var_0C.name == param_00)
		{
			if(var_0C.text == param_01 && var_0C.priority == param_03)
			{
				return;
			}

			var_0A = var_0C;
			break;
		}
	}

	if(!isdefined(var_0A))
	{
		var_0A = spawnstruct();
		self.lowermessages[self.lowermessages.size] = var_0A;
	}

	var_0A.name = param_00;
	var_0A.text = param_01;
	var_0A.time = param_02;
	var_0A.addtime = gettime();
	var_0A.priority = param_03;
	var_0A.showtimer = param_04;
	var_0A.shouldfade = param_05;
	var_0A.fadetoalphatime = param_06;
	var_0A.fadetoalphatime = param_07;
	var_0A.hidewhenindemo = param_08;
	var_0A.hidewheninmenu = param_09;
	sortlowermessages();
}

//Function Number: 15
sortlowermessages()
{
	for(var_00 = 1;var_00 < self.lowermessages.size;var_00++)
	{
		var_01 = self.lowermessages[var_00];
		var_02 = var_01.priority;
		for(var_03 = var_00 - 1;var_03 >= 0 && var_02 > self.lowermessages[var_03].priority;var_03--)
		{
			self.lowermessages[var_03 + 1] = self.lowermessages[var_03];
		}

		self.lowermessages[var_03 + 1] = var_01;
	}
}

//Function Number: 16
getlowermessage()
{
	if(!isdefined(self.lowermessages))
	{
		return undefined;
	}

	return self.lowermessages[0];
}

//Function Number: 17
clearondeath(param_00)
{
	self notify("message_cleared");
	self endon("message_cleared");
	self endon("disconnect");
	level endon("game_ended");
	self waittill("death");
	clearlowermessage(param_00.name);
}

//Function Number: 18
clearafterfade(param_00)
{
	wait(param_00.time);
	clearlowermessage(param_00.name);
	self notify("message_cleared");
}

//Function Number: 19
clearlowermessage(param_00)
{
	removelowermessage(param_00);
	updatelowermessage();
}

//Function Number: 20
removelowermessage(param_00)
{
	if(isdefined(self.lowermessages))
	{
		for(var_01 = self.lowermessages.size;var_01 > 0;var_01--)
		{
			if(self.lowermessages[var_01 - 1].name != param_00)
			{
				continue;
			}

			var_02 = self.lowermessages[var_01 - 1];
			for(var_03 = var_01;var_03 < self.lowermessages.size;var_03++)
			{
				if(isdefined(self.lowermessages[var_03]))
				{
					self.lowermessages[var_03 - 1] = self.lowermessages[var_03];
				}
			}

			self.lowermessages[self.lowermessages.size - 1] = undefined;
		}

		sortlowermessages();
	}
}

//Function Number: 21
func_7385(param_00)
{
	if(isdefined(level.var_90A9))
	{
		self.var_90A6 = 1;
		self freezecontrols(1);
		return;
	}

	self freezecontrols(param_00);
	self.var_45D6 = param_00;
}

//Function Number: 22
setthirdpersondof(param_00)
{
	if(param_00)
	{
		self setdepthoffield(0,110,512,4096,6,1.8);
		return;
	}

	self setdepthoffield(0,0,512,512,4,0);
}

//Function Number: 23
func_FB09(param_00)
{
	if(isdefined(self.var_3AF5))
	{
		self.var_3AF5.alpha = 0;
	}

	self.var_13118 = param_00;
	if(scripts\common\utility::func_9EC1())
	{
		scripts\common\utility::func_1C58(0);
	}

	self notify("using_remote");
}

//Function Number: 24
func_9FC6()
{
	return isdefined(self.var_13118);
}

//Function Number: 25
func_12F19(param_00,param_01)
{
	self.sessionstate = param_00;
	if(!isdefined(param_01))
	{
		param_01 = "";
	}

	self.var_2C7 = param_01;
	self setclientomnvar("ui_session_state",param_00);
}

//Function Number: 26
func_81EC()
{
	if(isdefined(self.pers["guid"]))
	{
		return self.pers["guid"];
	}

	var_00 = self getguid();
	if(var_00 == "0000000000000000")
	{
		if(isdefined(level.var_86BF))
		{
			level.var_86BF++;
		}
		else
		{
			level.var_86BF = 1;
		}

		var_00 = "script" + level.var_86BF;
	}

	self.pers["guid"] = var_00;
	return self.pers["guid"];
}

//Function Number: 27
func_766F(param_00)
{
	game["flags"][param_00] = 1;
	level notify(param_00);
}

//Function Number: 28
func_766E(param_00,param_01)
{
	game["flags"][param_00] = param_01;
}

//Function Number: 29
func_766C(param_00)
{
	return game["flags"][param_00];
}

//Function Number: 30
func_7670(param_00)
{
	while(!func_766C(param_00))
	{
		level waittill(param_00);
	}
}

//Function Number: 31
func_B3EC()
{
	return level.onlinegame && !getdvarint("xblive_privatematch");
}

//Function Number: 32
func_9900()
{
	return isdefined(game["status"]) && game["status"] == "overtime";
}

//Function Number: 33
func_9892()
{
	if(!isdefined(level.var_ABF3))
	{
		level.var_ABF3 = [];
	}
}

//Function Number: 34
func_980B()
{
	if(!isdefined(game["flags"]))
	{
		game["flags"] = [];
	}
}

//Function Number: 35
func_F305()
{
	if(!scripts\common\utility::func_16F3("platform",::func_F305))
	{
		return;
	}

	if(!isdefined(level.console))
	{
		level.console = getdvar("consoleGame") == "true";
	}
	else
	{
	}

	if(!isdefined(level.var_13E0F))
	{
		level.var_13E0F = getdvar("xenonGame") == "true";
	}
	else
	{
	}

	if(!isdefined(level.var_DADB))
	{
		level.var_DADB = getdvar("ps3Game") == "true";
	}
	else
	{
	}

	if(!isdefined(level.var_13E0E))
	{
		level.var_13E0E = getdvar("xb3Game") == "true";
	}
	else
	{
	}

	if(!isdefined(level.var_DADC))
	{
		level.var_DADC = getdvar("ps4Game") == "true";
	}
}

//Function Number: 36
func_9DD6(param_00)
{
	if(level.teambased)
	{
		return func_9EF3(param_00);
	}

	return func_9EEB(param_00);
}

//Function Number: 37
func_9EF3(param_00)
{
	return param_00.team != self.team;
}

//Function Number: 38
func_9EEB(param_00)
{
	if(isdefined(param_00.var_222))
	{
		return param_00.var_222 != self;
	}

	return param_00 != self;
}

//Function Number: 39
notusableforjoiningplayers(param_00)
{
	self notify("notusablejoiningplayers");
	self endon("death");
	level endon("game_ended");
	param_00 endon("disconnect");
	param_00 endon("death");
	self endon("notusablejoiningplayers");
	for(;;)
	{
		level waittill("player_spawned",var_01);
		if(isdefined(var_01) && var_01 != param_00)
		{
			self disableplayeruse(var_01);
		}
	}
}

//Function Number: 40
func_F838(param_00)
{
	self makeusable();
	foreach(var_02 in level.players)
	{
		if(var_02 != param_00)
		{
			self disableplayeruse(var_02);
			continue;
		}

		self enableplayeruse(var_02);
	}
}

//Function Number: 41
func_9DE2(param_00)
{
	if(!isdefined(param_00))
	{
		return 0;
	}

	if(param_00 == "turret_minigun_mp")
	{
		return 1;
	}

	return 0;
}

//Function Number: 42
func_9F8D(param_00)
{
	if(!isdefined(param_00))
	{
		return 0;
	}

	if(isdefined(level.var_112A9) && isdefined(level.var_112A9[param_00]))
	{
		return 1;
	}

	return 0;
}

//Function Number: 43
strip_suffix(param_00,param_01)
{
	if(param_00.size <= param_01.size)
	{
		return param_00;
	}

	if(getsubstr(param_00,param_00.size - param_01.size,param_00.size) == param_01)
	{
		return getsubstr(param_00,0,param_00.size - param_01.size);
	}

	return param_00;
}

//Function Number: 44
func_D548(param_00,param_01,param_02,param_03,param_04,param_05)
{
	var_06 = undefined;
	if(self.team != param_00)
	{
		var_06 = function_01E1(scripts\common\utility::getfx(param_03),param_01,self);
	}
	else
	{
		var_06 = function_01E1(scripts\common\utility::getfx(param_02),param_01,self);
	}

	if(isdefined(var_06))
	{
		triggerfx(var_06);
	}

	var_06 thread func_5106(param_04);
	if(isdefined(param_05) && param_05)
	{
		var_06 thread func_51C7(self);
	}

	return var_06;
}

//Function Number: 45
func_5106(param_00)
{
	self endon("death");
	wait(param_00);
	if(isdefined(self))
	{
		self delete();
	}
}

//Function Number: 46
func_51C7(param_00)
{
	self endon("death");
	param_00 scripts\common\utility::waittill_any_3("death","disconnect");
	self delete();
}

//Function Number: 47
isstrstart(param_00,param_01)
{
	return getsubstr(param_00,0,param_01.size) == param_01;
}

//Function Number: 48
func_9F19(param_00)
{
	if(isalive(param_00) && !isdefined(param_00.var_6BA7))
	{
		return 1;
	}

	return 0;
}

//Function Number: 49
func_7DF7(param_00)
{
	var_01 = strtok(param_00,"_");
	if(var_01[0] == "iw5" || var_01[0] == "iw6" || var_01[0] == "iw7")
	{
		param_00 = var_01[0] + "_" + var_01[1];
	}
	else if(var_01[0] == "alt")
	{
		param_00 = var_01[1] + "_" + var_01[2];
	}

	return param_00;
}

//Function Number: 50
func_824F(param_00,param_01)
{
	var_02 = strtok(param_00,"_");
	if(var_02[0] == "iw5" || var_02[0] == "iw6" || var_02[0] == "iw7")
	{
		if(isdefined(param_01) && param_01 > 1)
		{
			param_00 = var_02[0] + "_z" + var_02[1] + param_01;
		}
		else
		{
			param_00 = var_02[0] + "_z" + var_02[1];
		}
	}
	else if(var_02[0] == "alt")
	{
		if(isdefined(param_01) && param_01 > 1)
		{
			param_00 = var_02[1] + "_z" + var_02[2] + param_01;
		}
		else
		{
			param_00 = var_02[1] + "_z" + var_02[2];
		}
	}

	return param_00;
}

//Function Number: 51
func_78B4(param_00)
{
	var_01 = sortbydistance(level.var_13D59,param_00);
	foreach(var_03 in var_01)
	{
		if(var_03.var_6261)
		{
			return var_03;
		}
	}

	return undefined;
}

//Function Number: 52
func_664F(param_00)
{
	if(!isdefined(param_00.var_284D))
	{
		return 1;
	}

	var_01 = lib_0D4D::func_7B13(param_00);
	if(!isdefined(var_01))
	{
		return 1;
	}

	return 0;
}

//Function Number: 53
func_9D18()
{
	return scripts\common\utility::istrue(level.var_13C41);
}

//Function Number: 54
func_783C(param_00)
{
	var_01 = param_00.var_195.model;
	var_02 = "arkblue";
	var_03 = "stun_ammo";
	switch(var_01)
	{
		case "attachment_zmb_arcane_muzzlebrake_wm":
			var_02 = "arcane_base";
			break;

		default:
			break;
	}

	return var_02;
}

//Function Number: 55
func_212D()
{
	foreach(var_01 in self.var_456B)
	{
		if(var_01.var_C4A4 == 1)
		{
			return 1;
		}
	}

	return 0;
}

//Function Number: 56
func_80D8(param_00)
{
	var_01 = strtok(param_00,"_");
	if(var_01[0] == "iw5" || var_01[0] == "iw6" || var_01[0] == "iw7")
	{
		param_00 = var_01[1];
	}
	else if(var_01[0] == "alt")
	{
		param_00 = var_01[2];
	}

	return param_00;
}

//Function Number: 57
func_7F1D(param_00,param_01)
{
	var_02 = param_01;
	var_02 = getdvarint(param_00,param_01);
	return var_02;
}

//Function Number: 58
func_AAEC(param_00,param_01,param_02,param_03)
{
	if(!isdefined(game["dialog"][param_00]))
	{
		return;
	}

	var_04 = self.pers["team"];
	if(isdefined(var_04) && var_04 == "axis" || var_04 == "allies")
	{
		var_05 = game["voice"][var_04] + game["dialog"][param_00];
		self method_8252(var_05,param_00,2,param_01,param_02,param_03);
	}
}

//Function Number: 59
_setactionslot(param_00,param_01,param_02)
{
	self.var_EB6A[param_00].type = param_01;
	self.var_EB6A[param_00].var_195 = param_02;
	self method_8299(param_00,param_01,param_02);
}

//Function Number: 60
func_7F55(param_00)
{
	return tablelookup(level.var_83DC["killstreakTable"].var_C94F,level.var_83DC["killstreakTable"].var_DE40,param_00,level.var_83DC["killstreakTable"].var_13C09);
}

//Function Number: 61
func_135A(param_00)
{
	function_0154(param_00);
	if(!isdefined(level.var_DDDA))
	{
		level.var_DDDA = [];
		level.var_DDDA[0] = param_00;
		return;
	}

	level.var_DDDA[level.var_DDDA.size] = param_00;
}

//Function Number: 62
touchingbadtrigger(param_00)
{
	var_01 = getentarray("trigger_hurt","classname");
	foreach(var_03 in var_01)
	{
		if(self istouching(var_03) && level.var_B335 != "mp_mine" || var_03.var_F5 > 0)
		{
			return 1;
		}
	}

	var_05 = getentarray("radiation","targetname");
	foreach(var_03 in var_05)
	{
		if(self istouching(var_03))
		{
			return 1;
		}
	}

	if(isdefined(param_00) && param_00 == "gryphon")
	{
		var_08 = getentarray("gryphonDeath","targetname");
		foreach(var_03 in var_08)
		{
			if(self istouching(var_03))
			{
				return 1;
			}
		}
	}

	return 0;
}

//Function Number: 63
func_D52A(param_00,param_01,param_02)
{
	if(isdefined(param_00))
	{
		if(isarray(param_00))
		{
			param_00 = scripts\common\utility::random(param_00);
		}

		var_03 = lookupsoundlength(param_00);
		playsoundatpos(param_01,param_00);
		if(isdefined(param_02))
		{
			wait(var_03 / 1000);
		}

		return var_03;
	}
}

//Function Number: 64
func_CDD8(param_00,param_01,param_02)
{
	if(isdefined(param_00))
	{
		if(!isarray(param_00))
		{
			var_03 = [];
			var_03[0] = param_00;
			param_00 = var_03[0];
		}

		var_04 = scripts\common\utility::random(param_00);
		var_05 = lookupsoundlength(var_04);
		playsoundatpos(param_01,var_04);
		if(isdefined(param_02))
		{
			wait(var_05);
		}

		return var_05;
	}
}

//Function Number: 65
func_CD85(param_00)
{
	if(soundexists(param_00))
	{
		self playloopsound(param_00);
	}
}

//Function Number: 66
func_11019(param_00)
{
	if(soundexists(param_00))
	{
		self stoploopsound(param_00);
	}
}

//Function Number: 67
func_CF16()
{
	var_00 = randomintrange(1,8);
	var_01 = "generic";
	if(self method_817F())
	{
		var_01 = "female";
	}

	if(self.team == "axis")
	{
		var_02 = var_01 + "_death_russian_" + var_00;
		if(soundexists(var_02))
		{
			self playsound(var_02);
			return;
		}

		return;
	}

	var_02 = var_02 + "_death_american_" + var_01;
	if(soundexists(var_02))
	{
		self playsound(var_02);
	}
}

//Function Number: 68
func_9DFF(param_00,param_01,param_02)
{
	return isdefined(param_02) && param_02 _hasperk("specialty_bulletpenetration") && isdefined(param_01) && scripts\common\utility::func_9D74(param_01);
}

//Function Number: 69
func_9D85()
{
	return isdefined(self.var_3C64);
}

//Function Number: 70
getattachmenttype(param_00)
{
	if(!isdefined(param_00))
	{
		return "none";
	}

	var_01 = tablelookup("mp/attachmentTable.csv",4,param_00,2);
	if(!isdefined(var_01) || isdefined(var_01) && var_01 == "")
	{
		var_02 = getdvar("g_gametype");
		if(var_02 == "zombie")
		{
			var_01 = tablelookup("cp/zombies/zombie_attachmentTable.csv",4,param_00,2);
		}
	}

	return var_01;
}

//Function Number: 71
func_13C90(param_00,param_01)
{
	if(!isdefined(param_00) || param_00 == "none" || param_00 == "")
	{
		return 0;
	}

	var_02 = func_821A(param_00);
	foreach(var_04 in var_02)
	{
		if(var_04 == param_01)
		{
			return 1;
		}
	}

	return 0;
}

//Function Number: 72
func_821A(param_00)
{
	var_01 = function_00E3(param_00);
	foreach(var_04, var_03 in var_01)
	{
		var_01[var_04] = func_2494(var_03);
	}

	return var_01;
}

//Function Number: 73
func_2494(param_00)
{
	if(isdefined(level.var_2497[param_00]))
	{
		param_00 = level.var_2497[param_00];
	}

	return param_00;
}

//Function Number: 74
func_2DD9()
{
	var_00 = function_001F() == 2;
	if(var_00)
	{
		if(!level.teambased || level.gametype != "war" && level.gametype != "dom")
		{
			return 0;
		}

		return 1;
	}

	return 0;
}

//Function Number: 75
func_9E59()
{
	if(isdefined(self.var_9E59) && self.var_9E59 == 1)
	{
		return 1;
	}

	if(isdefined(self.var_9E5A) && self.var_9E5A == 1)
	{
		return 1;
	}

	if(isdefined(self.var_9E5B) && self.var_9E5B == 1)
	{
		return 1;
	}

	if(isdefined(self.var_9E5E) && self.var_9E5E == 1)
	{
		return 1;
	}

	if(isdefined(self.var_9E5D) && self.var_9E5D == 1)
	{
		return 1;
	}

	if(isdefined(self.var_9E5C) && self.var_9E5C == 1)
	{
		return 1;
	}

	return 0;
}

//Function Number: 76
func_2496(param_00,param_01)
{
	var_02 = func_8234(param_01);
	if(var_02 != param_01)
	{
		var_03 = getweaponbasename(param_01);
		var_04 = strtok(var_03,"_");
		var_05 = "mp" + getsubstr(var_04[2],2,var_04[2].size);
		var_06 = var_04[0];
		for(var_07 = 1;var_07 < var_04.size;var_07++)
		{
			if(var_07 == 2)
			{
				var_06 = var_06 + "_" + var_05;
				continue;
			}

			var_06 = var_06 + "_" + var_04[var_07];
		}

		if(isdefined(level.var_2492[var_03]) && isdefined(level.var_2497[param_00]) && isdefined(level.var_2492[var_03][level.var_2497[param_00]]))
		{
			var_08 = level.var_2497[param_00];
			return level.var_2492[var_03][var_08];
		}
		else if(isdefined(level.var_2492[var_07]) && isdefined(level.var_2497[param_01]) && isdefined(level.var_2492[var_07][level.var_2497[param_01]]))
		{
			var_08 = level.var_2497[param_01];
			return level.var_2492[var_06][var_08];
		}
		else if(isdefined(level.var_2492[var_04]) && isdefined(level.var_2492[var_04][param_01]))
		{
			return level.var_2492[var_04][param_01];
		}
		else if(isdefined(level.var_2492[var_07]) && isdefined(level.var_2492[var_07][param_01]))
		{
			return level.var_2492[var_07][param_01];
		}
		else if(var_05.size > 3)
		{
			var_09 = var_05[0] + "_" + var_05[1] + "_" + var_05[2];
			if(isdefined(level.var_2492[var_09]) && isdefined(level.var_2492[var_09][param_01]))
			{
				return level.var_2492[var_09][param_01];
			}
			else
			{
				var_0A = strtok(var_07,"_");
				var_0B = var_0A[0] + "_" + var_0A[1] + "_" + var_0A[2];
				if(isdefined(level.var_2492[var_0B]) && isdefined(level.var_2492[var_0B][param_01]))
				{
					return level.var_2492[var_0B][param_01];
				}
			}
		}
	}

	if(isdefined(level.var_2492[var_03]) && isdefined(level.var_2492[var_03][param_01]))
	{
		return level.var_2492[var_03][param_01];
	}
	else
	{
		var_0C = func_13C8F(var_03);
		if(isdefined(var_0C) && isdefined(level.var_2492[var_0C]) && isdefined(level.var_2492[var_0C][param_01]))
		{
			return level.var_2492[var_0C][param_01];
		}
	}

	return param_01;
}

//Function Number: 77
func_13C8F(param_00)
{
	if(isdefined(level.var_13CA5[param_00]) && isdefined(level.var_13CA5[param_00].var_8677))
	{
		return level.var_13CA5[param_00].var_8677;
	}

	return undefined;
}

//Function Number: 78
func_9E6C(param_00)
{
	if(!isdefined(param_00))
	{
		return 0;
	}

	if(param_00 == "none")
	{
		return 0;
	}

	if(scripts\common\utility::func_9DC1(param_00))
	{
		return 0;
	}

	if(issubstr(param_00,"killstreak"))
	{
		return 1;
	}

	if(issubstr(param_00,"remote_tank_projectile"))
	{
		return 1;
	}

	if(issubstr(param_00,"minijackal_"))
	{
		return 1;
	}

	if(isdefined(level.var_A6C5) && isdefined(level.var_A6C5[param_00]))
	{
		return 1;
	}

	if(scripts\common\utility::func_9D33(param_00))
	{
		return 1;
	}

	var_01 = function_0244(param_00);
	if(isdefined(var_01) && var_01 == "exclusive")
	{
		return 1;
	}

	return 0;
}

//Function Number: 79
func_41E9()
{
	if(isdefined(self.var_3AF5))
	{
		self.var_3AF5.alpha = 1;
	}

	self.var_13118 = undefined;
	if(!scripts\common\utility::func_9EC1())
	{
		scripts\common\utility::func_1C58(1);
	}

	var_00 = self getcurrentweapon();
	if(var_00 == "none" || func_9E6C(var_00))
	{
		var_01 = scripts\common\utility::getlastweapon();
		if(func_9F19(self))
		{
			if(!self hasweapon(var_01))
			{
				var_01 = func_7EB7();
			}

			self switchtoweapon(var_01);
		}
	}

	func_7385(0);
	self notify("stopped_using_remote");
}

//Function Number: 80
func_7EB7()
{
	var_00 = self getweaponslistprimaries();
	return var_00[0];
}

//Function Number: 81
func_F607(param_00,param_01,param_02,param_03,param_04,param_05)
{
	var_06 = func_7BC3(param_04,param_05);
	foreach(var_08 in var_06)
	{
		var_08 notify("changing_watching_visionset");
		if(isdefined(param_03) && param_03)
		{
			var_08 visionsetmissilecamforplayer(param_00,param_01);
		}
		else
		{
			var_08 visionsetnakedforplayer(param_00,param_01);
		}

		if(param_00 != "" && isdefined(param_02))
		{
			var_08 thread func_E23F(self,param_01 + param_02);
			var_08 thread func_E23D(self);
			if(var_08 func_9E4A())
			{
				var_08 thread func_E23E();
			}
		}
	}
}

//Function Number: 82
func_7BC3(param_00,param_01)
{
	if(!isdefined(param_00))
	{
		param_00 = 0;
	}

	if(!isdefined(param_01))
	{
		param_01 = 0;
	}

	var_02 = self getentitynumber();
	var_03 = [];
	foreach(var_05 in level.players)
	{
		if(var_05 == self)
		{
			continue;
		}

		var_06 = 0;
		if(!param_01)
		{
			if(var_05.team == "spectator" || var_05.sessionstate == "spectator")
			{
				var_07 = var_05 method_815D();
				if(isdefined(var_07) && var_07 == self)
				{
					var_06 = 1;
				}
			}

			if(var_05.var_140 == var_02)
			{
				var_06 = 1;
			}
		}

		if(!param_00)
		{
			if(var_05.var_1A9 == var_02)
			{
				var_06 = 1;
			}
		}

		if(var_06)
		{
			var_03[var_03.size] = var_05;
		}
	}

	return var_03;
}

//Function Number: 83
func_E23F(param_00,param_01)
{
	self endon("changing_watching_visionset");
	var_02 = gettime();
	var_03 = self.team;
	while(gettime() - var_02 < param_01 * 1000)
	{
		if(self.team != var_03 || !scripts\common\utility::func_2286(param_00 func_7BC3(),self))
		{
			self visionsetnakedforplayer("",0);
			self notify("changing_visionset");
			break;
		}

		wait(0.05);
	}
}

//Function Number: 84
func_E23D(param_00)
{
	self endon("changing_watching_visionset");
	param_00 waittill("disconnect");
	if(isdefined(level.var_13445))
	{
		self visionsetnakedforplayer(level.var_13445,0);
		return;
	}

	self visionsetnakedforplayer("",0);
}

//Function Number: 85
func_E23E()
{
	self endon("disconnect");
	self waittill("spawned");
	if(isdefined(level.var_13445))
	{
		self visionsetnakedforplayer(level.var_13445,0);
		return;
	}

	self visionsetnakedforplayer("",0);
}

//Function Number: 86
func_9E4A()
{
	return self.var_2B0;
}

//Function Number: 87
func_F6DB(param_00,param_01,param_02)
{
	if(!isdefined(level.console) || !isdefined(level.var_13E0E) || !isdefined(level.var_DADC))
	{
		func_F305();
	}

	if(func_9BEE())
	{
		setdvar(param_00,param_02);
		return;
	}

	setdvar(param_00,param_01);
}

//Function Number: 88
func_9BEE()
{
	if(level.var_13E0E || level.var_DADC || !level.console)
	{
		return 1;
	}

	return 0;
}

//Function Number: 89
createfontstring(param_00,param_01,param_02)
{
	if(!isdefined(param_02) || !param_02)
	{
		var_03 = newclienthudelem(self);
	}
	else
	{
		var_03 = newhudelem();
	}

	var_03.elemtype = "font";
	var_03.font = param_00;
	var_03.fontscale = param_01;
	var_03.basefontscale = param_01;
	var_03.x = 0;
	var_03.y = 0;
	var_03.width = 0;
	var_03.height = int(level.fontheight * param_01);
	var_03.xoffset = 0;
	var_03.yoffset = 0;
	var_03.children = [];
	var_03 setparent(level.uiparent);
	var_03.hidden = 0;
	return var_03;
}

//Function Number: 90
setparent(param_00)
{
	if(isdefined(self.parent) && self.parent == param_00)
	{
		return;
	}

	if(isdefined(self.parent))
	{
		self.parent removechild(self);
	}

	self.parent = param_00;
	self.parent addchild(self);
	if(isdefined(self.point))
	{
		setpoint(self.point,self.relativepoint,self.xoffset,self.yoffset);
		return;
	}

	setpoint("TOPLEFT");
}

//Function Number: 91
removechild(param_00)
{
	param_00.parent = undefined;
	if(self.children[self.children.size - 1] != param_00)
	{
		self.children[param_00.index] = self.children[self.children.size - 1];
		self.children[param_00.index].index = param_00.index;
	}

	self.children[self.children.size - 1] = undefined;
	param_00.index = undefined;
}

//Function Number: 92
addchild(param_00)
{
	param_00.index = self.children.size;
	self.children[self.children.size] = param_00;
	removedestroyedchildren();
}

//Function Number: 93
removedestroyedchildren()
{
	if(isdefined(self.childchecktime) && self.childchecktime == gettime())
	{
		return;
	}

	self.childchecktime = gettime();
	var_00 = [];
	foreach(var_02 in self.children)
	{
		if(!isdefined(var_02))
		{
			continue;
		}

		var_02.index = var_00.size;
		var_00[var_00.size] = var_02;
	}

	self.children = var_00;
}

//Function Number: 94
setpoint(param_00,param_01,param_02,param_03,param_04)
{
	if(!isdefined(param_04))
	{
		param_04 = 0;
	}

	var_05 = getparent();
	if(param_04)
	{
		self moveovertime(param_04);
	}

	if(!isdefined(param_02))
	{
		param_02 = 0;
	}

	self.xoffset = param_02;
	if(!isdefined(param_03))
	{
		param_03 = 0;
	}

	self.yoffset = param_03;
	self.point = param_00;
	self.alignx = "center";
	self.aligny = "middle";
	if(issubstr(param_00,"TOP"))
	{
		self.aligny = "top";
	}

	if(issubstr(param_00,"BOTTOM"))
	{
		self.aligny = "bottom";
	}

	if(issubstr(param_00,"LEFT"))
	{
		self.alignx = "left";
	}

	if(issubstr(param_00,"RIGHT"))
	{
		self.alignx = "right";
	}

	if(!isdefined(param_01))
	{
		param_01 = param_00;
	}

	self.relativepoint = param_01;
	var_06 = "center_adjustable";
	var_07 = "middle";
	if(issubstr(param_01,"TOP"))
	{
		var_07 = "top_adjustable";
	}

	if(issubstr(param_01,"BOTTOM"))
	{
		var_07 = "bottom_adjustable";
	}

	if(issubstr(param_01,"LEFT"))
	{
		var_06 = "left_adjustable";
	}

	if(issubstr(param_01,"RIGHT"))
	{
		var_06 = "right_adjustable";
	}

	if(var_05 == level.uiparent)
	{
		self.horzalign = var_06;
		self.vertalign = var_07;
	}
	else
	{
		self.horzalign = var_05.horzalign;
		self.vertalign = var_05.vertalign;
	}

	if(strip_suffix(var_06,"_adjustable") == var_05.alignx)
	{
		var_08 = 0;
		var_09 = 0;
	}
	else if(var_08 == "center" || var_07.alignx == "center")
	{
		var_08 = int(var_07.width / 2);
		if(var_07 == "left_adjustable" || var_06.alignx == "right")
		{
			var_09 = -1;
		}
		else
		{
			var_09 = 1;
		}
	}
	else
	{
		var_08 = var_07.width;
		if(var_07 == "left_adjustable")
		{
			var_09 = -1;
		}
		else
		{
			var_09 = 1;
		}
	}

	self.x = var_05.x + var_08 * var_09;
	if(strip_suffix(var_07,"_adjustable") == var_05.aligny)
	{
		var_0A = 0;
		var_0B = 0;
	}
	else if(var_09 == "middle" || var_07.aligny == "middle")
	{
		var_0A = int(var_07.height / 2);
		if(var_08 == "top_adjustable" || var_06.aligny == "bottom")
		{
			var_0B = -1;
		}
		else
		{
			var_0B = 1;
		}
	}
	else
	{
		var_0A = var_07.height;
		if(var_08 == "top_adjustable")
		{
			var_0B = -1;
		}
		else
		{
			var_0B = 1;
		}
	}

	self.y = var_05.y + var_0A * var_0B;
	self.x = self.x + self.xoffset;
	self.y = self.y + self.yoffset;
	switch(self.elemtype)
	{
		case "bar":
			setpointbar(param_00,param_01,param_02,param_03);
			break;
	}

	updatechildren();
}

//Function Number: 95
getparent()
{
	return self.parent;
}

//Function Number: 96
setpointbar(param_00,param_01,param_02,param_03)
{
	self.bar.horzalign = self.horzalign;
	self.bar.vertalign = self.vertalign;
	self.bar.alignx = "left";
	self.bar.aligny = self.aligny;
	self.bar.y = self.y;
	if(self.alignx == "left")
	{
		self.bar.x = self.x;
	}
	else if(self.alignx == "right")
	{
		self.bar.x = self.x - self.width;
	}
	else
	{
		self.bar.x = self.x - int(self.width / 2);
	}

	if(self.aligny == "top")
	{
		self.bar.y = self.y;
	}
	else if(self.aligny == "bottom")
	{
		self.bar.y = self.y;
	}

	updatebar(self.bar.frac);
}

//Function Number: 97
updatebar(param_00,param_01)
{
	if(self.elemtype == "bar")
	{
		updatebarscale(param_00,param_01);
	}
}

//Function Number: 98
updatebarscale(param_00,param_01)
{
	var_02 = int(self.width * param_00 + 0.5);
	if(!var_02)
	{
		var_02 = 1;
	}

	self.bar.frac = param_00;
	self.bar setshader(self.bar.shader,var_02,self.height);
	if(isdefined(param_01) && var_02 < self.width)
	{
		if(param_01 > 0)
		{
			self.bar scaleovertime(1 - param_00 / param_01,self.width,self.height);
		}
		else if(param_01 < 0)
		{
			self.bar scaleovertime(param_00 / -1 * param_01,1,self.height);
		}
	}

	self.bar.rateofchange = param_01;
	self.bar.lastupdatetime = gettime();
}

//Function Number: 99
updatechildren()
{
	for(var_00 = 0;var_00 < self.children.size;var_00++)
	{
		var_01 = self.children[var_00];
		var_01 setpoint(var_01.point,var_01.relativepoint,var_01.xoffset,var_01.yoffset);
	}
}

//Function Number: 100
createicon(param_00,param_01,param_02,param_03)
{
	if(!isdefined(param_03))
	{
		var_04 = newclienthudelem(self);
	}
	else
	{
		var_04 = newhudelem();
	}

	var_04.elemtype = "icon";
	var_04.x = 0;
	var_04.y = 0;
	var_04.width = param_01;
	var_04.height = param_02;
	var_04.basewidth = var_04.width;
	var_04.baseheight = var_04.height;
	var_04.xoffset = 0;
	var_04.yoffset = 0;
	var_04.children = [];
	var_04 setparent(level.uiparent);
	var_04.hidden = 0;
	if(isdefined(param_00))
	{
		var_04 setshader(param_00,param_01,param_02);
		var_04.shader = param_00;
	}

	return var_04;
}

//Function Number: 101
destroyelem()
{
	var_00 = [];
	for(var_01 = 0;var_01 < self.children.size;var_01++)
	{
		if(isdefined(self.children[var_01]))
		{
			var_00[var_00.size] = self.children[var_01];
		}
	}

	for(var_01 = 0;var_01 < var_00.size;var_01++)
	{
		var_00[var_01] setparent(getparent());
	}

	if(self.elemtype == "bar" || self.elemtype == "bar_shader")
	{
		self.bar destroy();
	}

	self destroy();
}

//Function Number: 102
showelem()
{
	if(!self.hidden)
	{
		return;
	}

	self.hidden = 0;
	if(self.elemtype == "bar" || self.elemtype == "bar_shader")
	{
		if(self.alpha != 0.5)
		{
			self.alpha = 0.5;
		}

		self.bar.hidden = 0;
		if(self.bar.alpha != 1)
		{
			self.bar.alpha = 1;
			return;
		}

		return;
	}

	if(self.alpha != 1)
	{
		self.alpha = 1;
	}
}

//Function Number: 103
hideelem()
{
	if(self.hidden)
	{
		return;
	}

	self.hidden = 1;
	if(self.alpha != 0)
	{
		self.alpha = 0;
	}

	if(self.elemtype == "bar" || self.elemtype == "bar_shader")
	{
		self.bar.hidden = 1;
		if(self.bar.alpha != 0)
		{
			self.bar.alpha = 0;
		}
	}
}

//Function Number: 104
createprimaryprogressbartext(param_00,param_01,param_02,param_03)
{
	if(isagent(self))
	{
		return undefined;
	}

	if(!isdefined(param_00))
	{
		param_00 = 0;
	}

	if(!isdefined(param_01))
	{
		param_01 = -25;
	}

	if(self issplitscreenplayer())
	{
		param_01 = param_01 + 20;
	}

	var_04 = level.primaryprogressbarfontsize;
	var_05 = "default";
	if(isdefined(param_02))
	{
		var_04 = param_02;
	}

	if(isdefined(param_03))
	{
		var_05 = param_03;
	}

	var_06 = createfontstring(var_05,var_04);
	var_06 setpoint("CENTER",undefined,level.primaryprogressbartextx + param_00,level.primaryprogressbartexty + param_01);
	var_06.sort = -1;
	return var_06;
}

//Function Number: 105
createprimaryprogressbar(param_00,param_01,param_02,param_03)
{
	if(isagent(self))
	{
		return undefined;
	}

	if(!isdefined(param_00))
	{
		param_00 = 0;
	}

	if(!isdefined(param_01))
	{
		param_01 = -25;
	}

	if(self issplitscreenplayer())
	{
		param_01 = param_01 + 20;
	}

	if(!isdefined(param_02))
	{
		param_02 = level.primaryprogressbarwidth;
	}

	if(!isdefined(param_03))
	{
		param_03 = level.primaryprogressbarheight;
	}

	var_04 = createbar((1,1,1),param_02,param_03);
	var_04 setpoint("CENTER",undefined,level.primaryprogressbarx + param_00,level.primaryprogressbary + param_01);
	return var_04;
}

//Function Number: 106
createbar(param_00,param_01,param_02,param_03)
{
	var_04 = newclienthudelem(self);
	var_04.x = 0;
	var_04.y = 0;
	var_04.frac = 0;
	var_04.color = param_00;
	var_04.sort = -2;
	var_04.shader = "progress_bar_fill";
	var_04 setshader("progress_bar_fill",param_01,param_02);
	var_04.hidden = 0;
	if(isdefined(param_03))
	{
		var_04.flashfrac = param_03;
	}

	var_05 = newclienthudelem(self);
	var_05.elemtype = "bar";
	var_05.width = param_01;
	var_05.height = param_02;
	var_05.xoffset = 0;
	var_05.yoffset = 0;
	var_05.bar = var_04;
	var_05.children = [];
	var_05.sort = -3;
	var_05.color = (0,0,0);
	var_05.alpha = 0.5;
	var_05 setparent(level.uiparent);
	var_05 setshader("progress_bar_bg",param_01 + 4,param_02 + 4);
	var_05.hidden = 0;
	return var_05;
}

//Function Number: 107
func_9E0E(param_00)
{
	if(func_9D2D(param_00))
	{
		return 1;
	}

	if(isplayer(param_00))
	{
		return 1;
	}

	return 0;
}

//Function Number: 108
func_9D2D(param_00)
{
	if(isagent(param_00) && isdefined(param_00.var_18F2) && param_00.var_18F2 == 1)
	{
		return 1;
	}

	if(isbot(param_00))
	{
		return 1;
	}

	return 0;
}

//Function Number: 109
func_F877(param_00,param_01)
{
	if(!level.teambased)
	{
		return;
	}

	if(!isdefined(self.var_6648))
	{
		self.var_6648 = "none";
		self.var_6644 = undefined;
	}

	var_02 = game["entity_headicon_" + param_00];
	self.var_6648 = param_00;
	if(isdefined(param_01))
	{
		self.var_6645 = param_01;
	}
	else
	{
		self.var_6645 = (0,0,0);
	}

	self notify("kill_entity_headicon_thread");
	if(param_00 == "none")
	{
		if(isdefined(self.var_6644))
		{
			self.var_6644 destroy();
		}

		return;
	}

	var_03 = newteamhudelem(param_00);
	var_03.archived = 1;
	var_03.x = self.origin[0] + self.var_6645[0];
	var_03.y = self.origin[1] + self.var_6645[1];
	var_03.var_3A6 = self.origin[2] + self.var_6645[2];
	var_03.alpha = 0.8;
	var_03 setshader(var_02,10,10);
	var_03 setwaypoint(0,0,0,1);
	self.var_6644 = var_03;
	thread func_A578();
	thread func_531E();
}

//Function Number: 110
func_F7F2(param_00,param_01)
{
	if(level.teambased)
	{
		return;
	}

	if(!isdefined(self.var_6648))
	{
		self.var_6648 = "none";
		self.var_6644 = undefined;
	}

	self notify("kill_entity_headicon_thread");
	if(!isdefined(param_00))
	{
		if(isdefined(self.var_6644))
		{
			self.var_6644 destroy();
		}

		return;
	}

	var_02 = param_00.team;
	self.var_6648 = var_02;
	if(isdefined(param_01))
	{
		self.var_6645 = param_01;
	}
	else
	{
		self.var_6645 = (0,0,0);
	}

	var_03 = game["entity_headicon_" + var_02];
	var_04 = newclienthudelem(param_00);
	var_04.archived = 1;
	var_04.x = self.origin[0] + self.var_6645[0];
	var_04.y = self.origin[1] + self.var_6645[1];
	var_04.var_3A6 = self.origin[2] + self.var_6645[2];
	var_04.alpha = 0.8;
	var_04 setshader(var_03,10,10);
	var_04 setwaypoint(0,0,0,1);
	self.var_6644 = var_04;
	thread func_A578();
	thread func_531E();
}

//Function Number: 111
func_A578()
{
	self.var_6644 linkwaypointtotargetwithoffset(self,self.var_6645);
}

//Function Number: 112
func_531E()
{
	self endon("kill_entity_headicon_thread");
	self waittill("death");
	if(!isdefined(self.var_6644))
	{
		return;
	}

	self.var_6644 destroy();
}

//Function Number: 113
func_F73D(param_00,param_01,param_02,param_03,param_04,param_05,param_06,param_07,param_08,param_09,param_0A)
{
	if(func_9E0E(param_00) && !isplayer(param_00))
	{
		return;
	}

	if(!isdefined(self.var_6647))
	{
		self.var_6647 = [];
	}

	if(!isdefined(param_05))
	{
		param_05 = 1;
	}

	if(!isdefined(param_06))
	{
		param_06 = 0.05;
	}

	if(!isdefined(param_07))
	{
		param_07 = 1;
	}

	if(!isdefined(param_08))
	{
		param_08 = 1;
	}

	if(!isdefined(param_09))
	{
		param_09 = 0;
	}

	if(!isdefined(param_0A))
	{
		param_0A = 1;
	}

	if(!isplayer(param_00) && param_00 == "none")
	{
		foreach(var_0D, var_0C in self.var_6647)
		{
			if(isdefined(var_0C))
			{
				var_0C destroy();
			}

			self.var_6647[var_0D] = undefined;
		}

		return;
	}

	if(isplayer(param_03))
	{
		if(isdefined(self.var_6647[param_03.var_86BD]))
		{
			self.var_6647[param_03.var_86BD] destroy();
			self.var_6647[param_03.var_86BD] = undefined;
		}

		if(param_04 == "")
		{
			return;
		}

		if(isdefined(param_03.team))
		{
			if(isdefined(self.var_6647[param_03.team]))
			{
				self.var_6647[param_03.team] destroy();
				self.var_6647[param_03.team] = undefined;
			}
		}

		var_0C = newclienthudelem(param_03);
		self.var_6647[param_02.var_86BD] = var_0D;
	}
	else
	{
		if(isdefined(self.var_6647[param_03]))
		{
			self.var_6647[param_03] destroy();
			self.var_6647[param_03] = undefined;
		}

		if(param_04 == "")
		{
			return;
		}

		foreach(var_0E in self.var_6647)
		{
			if(var_10 == "axis" || var_10 == "allies")
			{
				continue;
			}

			var_0F = func_8071(var_10);
			if(var_0F.team == param_01)
			{
				self.var_6647[var_10] destroy();
				self.var_6647[var_10] = undefined;
			}
		}

		var_0C = newteamhudelem(param_01);
		self.var_6647[param_01] = var_0C;
	}

	if(!isdefined(param_04) || !isdefined(param_05))
	{
		param_04 = 10;
		param_05 = 10;
	}

	var_0C.archived = param_06;
	var_0C.x = self.origin[0] + param_03[0];
	var_0C.y = self.origin[1] + param_03[1];
	var_0C.var_3A6 = self.origin[2] + param_03[2];
	var_0C.alpha = 0.85;
	var_0C setshader(param_02,param_04,param_05);
	var_0C setwaypoint(param_08,param_09,param_0A,var_0B);
	var_0C thread func_A57C(self,param_03,param_07);
	thread func_531F();
	if(isplayer(param_01))
	{
		var_0C thread func_5320(param_01);
	}

	if(isplayer(self))
	{
		var_0C thread func_5320(self);
	}

	return var_0C;
}

//Function Number: 114
func_1012C(param_00)
{
	foreach(var_02 in param_00)
	{
		if(isdefined(var_02))
		{
			var_02.alpha = 0.85;
		}
	}
}

//Function Number: 115
func_8EC2(param_00)
{
	foreach(var_02 in param_00)
	{
		if(isdefined(var_02))
		{
			var_02.alpha = 0;
		}
	}
}

//Function Number: 116
func_8071(param_00)
{
	foreach(var_02 in level.players)
	{
		if(var_02.var_86BD == param_00)
		{
			return var_02;
		}
	}

	return undefined;
}

//Function Number: 117
func_A57C(param_00,param_01,param_02)
{
	self endon("death");
	param_00 endon("death");
	param_00 endon("disconnect");
	var_03 = isdefined(param_00.classname) && !func_9ED0(param_00);
	if(var_03)
	{
		self linkwaypointtotargetwithoffset(param_00,param_01);
	}

	for(;;)
	{
		if(!isdefined(param_00))
		{
			return;
		}

		if(!var_03)
		{
			var_04 = param_00.origin;
			self.x = var_04[0] + param_01[0];
			self.y = var_04[1] + param_01[1];
			self.var_3A6 = var_04[2] + param_01[2];
		}

		if(param_02 > 0.05)
		{
			self.alpha = 0.85;
			self fadeovertime(param_02);
			self.alpha = 0;
		}

		wait(param_02);
	}
}

//Function Number: 118
func_9ED0(param_00)
{
	return isdefined(param_00.var_336) && param_00.var_336 == "care_package";
}

//Function Number: 119
func_531F()
{
	self notify("destroyIconsOnDeath");
	self endon("destroyIconsOnDeath");
	self waittill("death");
	if(!isdefined(self.var_6647))
	{
		return;
	}

	foreach(var_01 in self.var_6647)
	{
		if(!isdefined(var_01))
		{
			continue;
		}

		var_01 destroy();
	}
}

//Function Number: 120
func_5320(param_00)
{
	self endon("death");
	param_00 waittill("disconnect");
	self destroy();
}

//Function Number: 121
func_1417()
{
	if(!func_9FC6() && !isdefined(self.var_6BA7))
	{
		self suicide();
	}
}

//Function Number: 122
func_D1EB(param_00,param_01,param_02,param_03,param_04,param_05)
{
	var_06 = func_B0F9(param_00,param_01,param_02,param_03,param_04,param_05);
	return var_06;
}

//Function Number: 123
func_B0F9(param_00,param_01,param_02,param_03,param_04,param_05)
{
	self.var_4B30 = 0;
	self.var_9B04 = 1;
	self.userate = 1;
	self.var_130EE = param_01;
	param_00 thread func_4919(self,param_03);
	param_00.var_8C18 = 1;
	var_06 = func_B0FA(param_00,self,param_02,param_04,param_05);
	if(isalive(param_00))
	{
		param_00.var_8C18 = 0;
	}

	if(!isdefined(self))
	{
		return 0;
	}

	self.var_9B04 = 0;
	self.var_4B30 = 0;
	return var_06;
}

//Function Number: 124
func_4919(param_00,param_01)
{
	self endon("disconnect");
	self setclientomnvar("ui_securing",param_01);
	var_02 = -1;
	while(func_9F19(self) && isdefined(param_00) && param_00.var_9B04 && !level.var_7669)
	{
		if(var_02 != param_00.userate)
		{
			if(param_00.var_4B30 > param_00.var_130EE)
			{
				param_00.var_4B30 = param_00.var_130EE;
			}
		}

		var_02 = param_00.userate;
		self setclientomnvar("ui_securing_progress",param_00.var_4B30 / param_00.var_130EE);
		wait(0.05);
	}

	wait(0.5);
	self setclientomnvar("ui_securing_progress",0);
	self setclientomnvar("ui_securing",0);
}

//Function Number: 125
func_B0FA(param_00,param_01,param_02,param_03,param_04)
{
	while(!level.var_7669 && isdefined(self) && func_9F19(param_00) && param_00 usebuttonpressed() || isdefined(param_03) || param_00 attackbuttonpressed() && isdefined(param_04) && should_continue_progress_bar_think(param_00))
	{
		wait(0.05);
		if(isdefined(param_01) && isdefined(param_02))
		{
			if(distancesquared(param_00.origin,param_01.origin) > param_02)
			{
				return 0;
			}
		}

		self.var_4B30 = self.var_4B30 + 50 * self.userate;
		self.userate = 1;
		if(self.var_4B30 >= self.var_130EE)
		{
			param_00 setclientomnvar("ui_securing_progress",1);
			return func_9F19(param_00);
		}
	}

	return 0;
}

//Function Number: 126
should_continue_progress_bar_think(param_00)
{
	if(isdefined(level.should_continue_progress_bar_think))
	{
		return [[ level.should_continue_progress_bar_think ]](param_00);
	}

	if(scripts\common\utility::istrue(param_00.in_afterlife_arcade))
	{
		return 1;
	}

	return !scripts\cp\_laststand::player_in_laststand(param_00);
}

//Function Number: 127
isplayingsolo()
{
	if(getmaxclients() == 1)
	{
		return 1;
	}

	return 0;
}

//Function Number: 128
func_E113()
{
	var_00 = 0;
	for(var_01 = 0;var_01 < level.var_C928.size;var_01++)
	{
		if(level.var_C928[var_01] == self)
		{
			var_00 = 1;
			while(var_01 < level.var_C928.size - 1)
			{
				level.var_C928[var_01] = level.var_C928[var_01 + 1];
				var_01++;
			}

			level.var_C928[var_01] = undefined;
			break;
		}
	}
}

//Function Number: 129
func_E106()
{
	var_00 = 0;
	for(var_01 = 0;var_01 < level.var_3CB5.size;var_01++)
	{
		if(level.var_3CB5[var_01] == self)
		{
			var_00 = 1;
			while(var_01 < level.var_3CB5.size - 1)
			{
				level.var_3CB5[var_01] = level.var_3CB5[var_01 + 1];
				var_01++;
			}

			level.var_3CB5[var_01] = undefined;
			break;
		}
	}
}

//Function Number: 130
func_E119()
{
	if(isdefined(self.var_8696))
	{
		if(isdefined(level.var_10851) && isdefined(level.var_10851[self.var_8696]))
		{
			level.var_10851[self.var_8696] = scripts\common\utility::func_22A9(level.var_10851[self.var_8696],self);
		}
	}
}

//Function Number: 131
createtimer(param_00,param_01)
{
	var_02 = newclienthudelem(self);
	var_02.elemtype = "timer";
	var_02.font = param_00;
	var_02.fontscale = param_01;
	var_02.basefontscale = param_01;
	var_02.x = 0;
	var_02.y = 0;
	var_02.width = 0;
	var_02.height = int(level.fontheight * param_01);
	var_02.xoffset = 0;
	var_02.yoffset = 0;
	var_02.children = [];
	var_02 setparent(level.uiparent);
	var_02.hidden = 0;
	return var_02;
}

//Function Number: 132
func_11D7()
{
	self detachall();
}

//Function Number: 133
func_9D04(param_00)
{
	var_01 = getarraykeys(level.var_1B8E["perk_0"]);
	if(scripts\common\utility::func_2286(var_01,param_00))
	{
		return 1;
	}

	var_02 = getarraykeys(level.var_1B8E["perk_1"]);
	if(scripts\common\utility::func_2286(var_02,param_00))
	{
		return 1;
	}

	var_03 = getarraykeys(level.var_1B8E["perk_2"]);
	return scripts\common\utility::func_2286(var_03,param_00);
}

//Function Number: 134
func_9BA0(param_00)
{
	if(isdefined(level.consumable_active_override))
	{
		return [[ level.consumable_active_override ]](param_00);
	}

	if(isdefined(self.var_456B) && isdefined(self.var_456B[param_00]) && isdefined(self.var_456B[param_00].var_C4A4) && self.var_456B[param_00].var_C4A4 == 1)
	{
		return 1;
	}

	return 0;
}

//Function Number: 135
func_C151(param_00)
{
	self notify(self.var_456B[param_00].var_1307B);
}

//Function Number: 136
func_C150(param_00)
{
	self notify(level.var_456B[param_00].var_1193C);
}

//Function Number: 137
drawline(param_00,param_01,param_02,param_03)
{
	var_04 = int(param_02 * 20);
	for(var_05 = 0;var_05 < var_04;var_05++)
	{
		wait(0.05);
	}
}

//Function Number: 138
func_9CF3(param_00)
{
	if(!func_9CF9())
	{
		return 0;
	}

	if(self getplayerdata("cp","upgrades_enabled_flags",param_00))
	{
		return 1;
	}

	return 0;
}

//Function Number: 139
allow_player_teleport(param_00,param_01)
{
	if(param_00)
	{
		if(!isdefined(self.var_11658) && isdefined(param_01))
		{
			foreach(var_03 in self.var_11658)
			{
				if(var_03 == param_01)
				{
					self.var_11658 = scripts\common\utility::func_22A9(self.var_11658,param_01);
				}
			}
		}

		self.var_55E3--;
		if(!self.var_55E3)
		{
			self.var_11658 = [];
			self.var_3859 = 1;
			self notify("can_teleport");
			return;
		}

		return;
	}

	if(!isdefined(self.var_11658))
	{
		self.var_11658 = [];
	}

	if(isdefined(param_01))
	{
		self.var_11658[self.var_11658.size] = param_01;
	}

	if(!isdefined(self.var_55E3))
	{
		self.var_55E3 = 0;
	}

	self.var_55E3++;
	self.var_3859 = 0;
}

//Function Number: 140
issprintenabled()
{
	return !isdefined(self.var_55E1) || !self.var_55E1;
}

//Function Number: 141
isweaponfireenabled()
{
	return !isdefined(self.var_55C8) || !self.var_55C8;
}

//Function Number: 142
ismeleeenabled()
{
	return !isdefined(self.var_55D5) || !self.var_55D5;
}

//Function Number: 143
isteleportenabled()
{
	return !isdefined(self.var_55E3) || !self.var_55E3;
}

//Function Number: 144
func_1C5D(param_00)
{
	if(param_00)
	{
		self.var_55CD--;
		if(!self.var_55CD)
		{
			self.var_9A45 = undefined;
			return;
		}

		return;
	}

	self.var_55CD++;
	self.var_9A45 = 1;
}

//Function Number: 145
func_213E()
{
	return self.var_55CD < 1;
}

//Function Number: 146
_linkto(param_00,param_01,param_02,param_03,param_04)
{
	if(!isdefined(param_02))
	{
		param_02 = "tag_origin";
	}

	if(!isdefined(param_03))
	{
		param_03 = (0,0,0);
	}

	if(!isdefined(param_04))
	{
		param_04 = (0,0,0);
	}

	if(!isdefined(self.playerlinkedcounter))
	{
		self.playerlinkedcounter = 0;
	}

	self.playerlinkedcounter++;
	if(self.playerlinkedcounter == 1)
	{
		self linkto(param_01,param_02,param_03,param_04);
	}
}

//Function Number: 147
_unlink()
{
	if(isplayerlinked())
	{
		self.playerlinkedcounter--;
		if(self.playerlinkedcounter <= 0)
		{
			self.playerlinkedcounter = 0;
			self unlink();
		}
	}
}

//Function Number: 148
isplayerlinked()
{
	return isdefined(self.playerlinkedcounter) && self.playerlinkedcounter > 0;
}

//Function Number: 149
enable_infinite_ammo(param_00)
{
	if(param_00)
	{
		self.infiniteammocounter++;
		self setclientomnvar("zm_ui_unlimited_ammo",1);
		return;
	}

	if(self.infiniteammocounter > 0)
	{
		self.infiniteammocounter--;
	}

	if(!self.infiniteammocounter)
	{
		self setclientomnvar("zm_ui_unlimited_ammo",0);
	}
}

//Function Number: 150
isinfiniteammoenabled()
{
	return self.infiniteammocounter >= 1;
}

//Function Number: 151
func_1C5C(param_00)
{
	if(param_00)
	{
		self.ignorme_count++;
		self.ignoreme = 1;
		return;
	}

	self.ignorme_count--;
	if(!self.ignorme_count)
	{
		self.ignoreme = 0;
	}
}

//Function Number: 152
func_9E3A()
{
	return self.ignorme_count >= 1;
}

//Function Number: 153
func_7298()
{
	self.var_55E4 = 0;
	self method_80DA();
}

//Function Number: 154
func_9CF9()
{
	return 0;
	if(getdvarint("extinction_tokens_enabled") > 0)
	{
		return 1;
	}

	return 0;
}

//Function Number: 155
func_4626(param_00)
{
	if(!isdefined(param_00) || isdefined(param_00) && param_00 == "none")
	{
		return "none";
	}

	var_01 = func_7DF7(param_00);
	var_02 = tablelookup(level.var_10E5A,4,var_01,1);
	if(var_02 == "" && isdefined(level.var_7666))
	{
		if(isdefined(param_00))
		{
			var_01 = func_7DF7(param_00);
			var_02 = tablelookup(level.var_7666,4,var_01,2);
		}
	}

	if(func_9DE2(param_00))
	{
		var_02 = "weapon_mg";
	}
	else if(param_00 == "none")
	{
		var_02 = "other";
	}
	else if(var_02 == "")
	{
		var_02 = "other";
	}

	return var_02;
}

//Function Number: 156
func_9C03()
{
	return self.var_9C03;
}

//Function Number: 157
func_8BAE()
{
	return self.var_8BAE;
}

//Function Number: 158
func_6C12(param_00,param_01)
{
	var_02 = self getweaponslistoffhands();
	var_03 = 0;
	var_04 = undefined;
	var_05 = 0;
	foreach(var_07 in var_02)
	{
		if(var_07 != param_00)
		{
			if(var_07 != "none" && var_07 != "alienthrowingknife_mp" && var_07 != "alientrophy_mp" && var_07 != "iw6_aliendlc21_mp")
			{
				self takeweapon(var_07);
			}

			continue;
		}

		if(isdefined(var_07) && var_07 != "none")
		{
			var_05 = self method_80FB(var_07);
			self setweaponammostock(var_07,var_05 + param_01);
			var_03 = 1;
			break;
		}
	}

	if(var_03 == 0)
	{
		func_12C6(param_00);
		self setweaponammostock(param_00,param_01);
	}
}

//Function Number: 159
func_7E9D(param_00)
{
	switch(param_00)
	{
		case "arc_grenade_mp":
		case "zom_repulsor_mp":
		case "splash_grenade_zm":
		case "splash_grenade_mp":
		case "impalement_spike_mp":
		case "mortar_shelljugg_mp":
		case "proximity_explosive_mp":
		case "bouncingbetty_mp":
		case "throwingknifesmokewall_mp":
		case "throwingknifec4_mp":
		case "throwingknife_mp":
		case "claymore_mp":
		case "cluster_grenade_zm":
		case "semtex_zm":
		case "semtex_mp":
		case "c4_zm":
		case "frag_grenade_mp":
		case "frag_grenade_zm":
			var_01 = "lethal";
			break;

		case "ztransponder_mp":
		case "transponder_mp":
		case "blackout_grenade_mp":
		case "player_trophy_system_mp":
		case "proto_ricochet_device_mp":
		case "emp_grenade_mp":
		case "trophy_mp":
		case "mobile_radar_mp":
		case "gravity_grenade_mp":
		case "alienflare_mp":
		case "concussion_grenade_mp":
		case "smoke_grenadejugg_mp":
		case "smoke_grenade_mp":
		case "thermobaric_grenade_mp":
		case "portal_generator_zm":
		case "portal_generator_mp":
		case "flash_grenade_mp":
			var_01 = "tactical";
			break;

		default:
			var_01 = undefined;
			break;
	}

	return var_01;
}

//Function Number: 160
func_8389(param_00)
{
	if(param_00 == "none" || param_00 == "specialty_null")
	{
		self method_831D("none");
		return;
	}

	self.var_F0BB = param_00;
	if(issubstr(param_00,"_mp"))
	{
		switch(param_00)
		{
			case "splash_grenade_zm":
			case "splash_grenade_mp":
			case "mortar_shelljugg_mp":
			case "cluster_grenade_zm":
			case "semtex_zm":
			case "semtex_mp":
			case "frag_grenade_mp":
			case "frag_grenade_zm":
				self method_831D("frag");
				break;

			case "throwingknifejugg_mp":
			case "throwingknifesmokewall_mp":
			case "throwingknifec4_mp":
			case "throwingknife_mp":
			case "c4_zm":
				self method_831D("throwingknife");
				break;

			case "player_trophy_system_mp":
			case "proto_ricochet_device_mp":
			case "emp_grenade_mp":
			case "trophy_mp":
			case "mobile_radar_mp":
			case "alienflare_mp":
			case "thermobaric_grenade_mp":
			case "flash_grenade_mp":
				self method_831D("flash");
				break;

			case "concussion_grenade_mp":
			case "smoke_grenadejugg_mp":
			case "smoke_grenade_mp":
				self method_831D("smoke");
				break;

			case "ztransponder_mp":
			case "transponder_mp":
			case "zom_repulsor_mp":
			default:
				self method_831D("other");
				break;
		}

		func_12C6(param_00,0);
		switch(param_00)
		{
			case "ztransponder_mp":
			case "transponder_mp":
			case "player_trophy_system_mp":
			case "proto_ricochet_device_mp":
			case "emp_grenade_mp":
			case "trophy_mp":
			case "mobile_radar_mp":
			case "gravity_grenade_mp":
			case "alienflare_mp":
			case "concussion_grenade_mp":
			case "smoke_grenade_mp":
			case "thermobaric_grenade_mp":
			case "flash_grenade_mp":
				self setweaponammoclip(param_00,1);
				break;

			default:
				self method_817C(param_00);
				break;
		}

		func_13D1(param_00);
		return;
	}

	func_13D1(param_00);
}

//Function Number: 161
func_1302(param_00,param_01,param_02,param_03,param_04,param_05)
{
	var_06 = self method_8449(param_00,param_01,param_02,param_03,param_05);
	if(!isdefined(param_04))
	{
		var_06.var_C187 = 1;
	}
	else
	{
		var_06.var_C187 = param_04;
	}

	var_06 method_831F(self);
	return var_06;
}

//Function Number: 162
func_2BBB(param_00)
{
	if(!isdefined(self.var_CA5D[param_00]))
	{
		self.var_CA5D[param_00] = 1;
	}
	else
	{
		self.var_CA5D[param_00]++;
	}

	if(self.var_CA5D[param_00] == 1 && _hasperk(param_00))
	{
		foreach(var_06, var_02 in level.var_6A50)
		{
			if(param_00 == var_06)
			{
				foreach(var_04 in var_02)
				{
					if(!isdefined(self.var_CA5D[var_04]))
					{
						self.var_CA5D[var_04] = 1;
						continue;
					}

					self.var_CA5D[var_04]++;
					if(self.var_CA5D[var_04] == 1)
					{
					}
				}

				break;
			}
		}
	}
}

//Function Number: 163
func_12B83(param_00)
{
	self.var_CA5D[param_00]--;
	if(self.var_CA5D[param_00] == 0)
	{
		self.var_CA5D[param_00] = undefined;
		if(_hasperk(param_00))
		{
			foreach(var_06, var_02 in level.var_6A50)
			{
				if(param_00 == var_06)
				{
					foreach(var_04 in var_02)
					{
						self.var_CA5D[var_04]--;
						if(self.var_CA5D[var_04] == 0)
						{
							self.var_CA5D[var_04] = undefined;
						}
					}

					break;
				}
			}
		}
	}
}

//Function Number: 164
func_821F(param_00)
{
	var_01 = func_7DF7(param_00);
	var_02 = level.var_10E5A;
	var_03 = tablelookup(var_02,4,var_01,1);
	if(var_03 == "")
	{
		var_04 = strip_suffix(param_00,"_zm");
		var_03 = tablelookup(var_02,4,var_04,1);
	}

	if(var_03 == "" && isdefined(level.var_7666))
	{
		var_04 = strip_suffix(param_00,"_zm");
		var_03 = tablelookup(level.var_7666,4,var_04,1);
	}

	if(func_9DE2(param_00))
	{
		var_03 = "weapon_mg";
	}
	else if(func_9E6C(param_00))
	{
		var_03 = "killstreak";
	}
	else if(func_9F8D(param_00))
	{
		var_03 = "super";
	}
	else if(param_00 == "none")
	{
		var_03 = "other";
	}
	else if(var_03 == "")
	{
		var_03 = "other";
	}

	return var_03;
}

//Function Number: 165
func_E0E6(param_00,param_01)
{
	if(!isdefined(param_01))
	{
		param_01 = 1;
	}

	if(param_01)
	{
		if(!isdefined(self.var_17DF))
		{
			return;
		}

		self.var_17DF[param_00] = undefined;
		return;
	}

	if(!isdefined(self.var_BDC8))
	{
		return;
	}

	self.var_BDC8[param_00] = undefined;
}

//Function Number: 166
func_17C0(param_00,param_01,param_02)
{
	if(!isdefined(param_02))
	{
		param_02 = 1;
	}

	if(param_02)
	{
		if(!isdefined(self.var_17DF))
		{
			self.var_17DF = [];
		}

		self.var_17DF[param_00] = param_01;
		return;
	}

	if(!isdefined(self.var_BDC8))
	{
		self.var_BDC8 = [];
	}

	self.var_BDC8[param_00] = param_01;
}

//Function Number: 167
func_7E5C()
{
	var_00 = 1;
	if(isdefined(self.var_17DF))
	{
		foreach(var_02 in self.var_17DF)
		{
			var_00 = var_00 + var_02 - 1;
		}
	}

	var_04 = 1;
	if(isdefined(self.var_BDC8))
	{
		foreach(var_02 in self.var_BDC8)
		{
			var_04 = var_04 * var_02;
		}
	}

	return var_00 * var_04;
}

//Function Number: 168
func_9E55(param_00)
{
	switch(function_0244(param_00))
	{
		case "altmode":
		case "primary":
			return 1;

		default:
			return 0;
	}
}

//Function Number: 169
func_1253(param_00)
{
	if(!isdefined(self.var_6262))
	{
		self.var_6262 = 0;
	}

	if(param_00)
	{
		if(self.var_6262 == 0)
		{
			self method_84CC(1);
		}

		self.var_6262++;
	}
	else
	{
		if(self.var_6262 == 1)
		{
			self method_84CC(0);
		}

		self.var_6262--;
	}
}

//Function Number: 170
func_8BB1(param_00,param_01)
{
	if(!isdefined(param_00))
	{
		return 0;
	}

	var_02 = function_00BC(param_00);
	for(var_03 = 0;var_03 < var_02;var_03++)
	{
		if(tolower(function_00BF(param_00,var_03)) == tolower(param_01))
		{
			return 1;
		}
	}

	return 0;
}

//Function Number: 171
func_9CEB(param_00,param_01,param_02)
{
	if(isdefined(param_01) && param_01 == "iw7_beamtrap_zm" || param_01 == "iw7_escapevelocity_zm" || param_01 == "iw7_rockettrap_zm" || param_01 == "iw7_discotrap_zm" || param_01 == "iw7_chromosphere_zm" || param_01 == "iw7_buffertrap_zm" || param_01 == "iw7_electrictrap_zm" || param_01 == "iw7_fantrap_zm" || param_01 == "iw7_hydranttrap_zm" || param_01 == "iw7_lasertrap_zm" || param_01 == "iw7_raintrap_zm" || param_01 == "iw7_theatertrap_zm" || param_01 == "iw7_fridgetrap_zm" || param_01 == "iw7_electrotrap_zm")
	{
		return 1;
	}

	if(!isdefined(param_00))
	{
		return 0;
	}

	if(isdefined(param_02) && scripts\common\utility::istrue(param_02.fridge_trap_marked))
	{
		return 1;
	}

	if(isdefined(param_00.var_11713))
	{
		return 1;
	}

	if(!isdefined(param_00.script_noteworthy) && !isdefined(param_00.var_336))
	{
		return 0;
	}

	if(isdefined(param_00.var_336) && param_00.var_336 == "fence_generator" || param_00.var_336 == "puddle_generator")
	{
		return 1;
	}

	if(isdefined(param_00.script_noteworthy) && param_00.script_noteworthy == "fire_trap")
	{
		return 1;
	}

	return 0;
}

//Function Number: 172
func_E55C()
{
	var_00 = self getweaponslist("primary");
	if(!self.var_8C1E)
	{
		return;
	}

	foreach(var_02 in var_00)
	{
		if(function_024C(var_02) == "riotshield")
		{
			return var_02;
		}
	}
}

//Function Number: 173
func_D0C6(param_00,param_01)
{
	return isdefined(param_00.var_10932) && param_00.var_10932 == param_01;
}

//Function Number: 174
func_8BB0(param_00)
{
	if(isdefined(self.var_10932))
	{
		return func_D0C6(self,"stun_ammo");
	}

	if(!isdefined(param_00))
	{
		var_01 = self getcurrentweapon();
	}
	else
	{
		var_01 = var_01;
	}

	if(var_01 == "none")
	{
		var_01 = self getweaponslistprimaries()[0];
	}

	var_02 = func_80D8(var_01);
	if(isdefined(self.var_10935) && isdefined(self.var_10935[var_02]) && self.var_10935[var_02] > 0)
	{
		return 1;
	}

	if(isdefined(self.var_10937) && isdefined(self.var_10937[var_02]) && self.var_10937[var_02] > 0)
	{
		return 1;
	}

	return 0;
}

//Function Number: 175
func_9CA6()
{
	return level.var_E4DD;
}

//Function Number: 176
func_9BFB()
{
	return level.var_8B38;
}

//Function Number: 177
func_9B85()
{
	return level.var_3B1D == 1;
}

//Function Number: 178
func_9F2D(param_00)
{
	if(param_00 == "none")
	{
		return 0;
	}

	return function_024C(param_00) == "riotshield";
}

//Function Number: 179
func_9D3E(param_00)
{
	if(!isdefined(param_00) || param_00 == "none")
	{
		return 0;
	}

	return function_0244(param_00) == "altmode";
}

//Function Number: 180
func_8C1E()
{
	var_00 = 0;
	var_01 = self getweaponslistprimaries();
	foreach(var_03 in var_01)
	{
		if(func_9F2D(var_03))
		{
			var_00 = 1;
			break;
		}
	}

	return var_00;
}

//Function Number: 181
func_9BCC(param_00)
{
	return param_00 == "";
}

//Function Number: 182
func_F225(param_00,param_01)
{
	if(isdefined(param_01))
	{
		self notify(param_00,param_01);
		return;
	}

	self notify(param_00);
}

//Function Number: 183
func_C15A(param_00,param_01)
{
	self waittill(param_00);
	waittillframeend;
	self notify(param_01);
}

//Function Number: 184
func_D1BE()
{
	level endon("game_ended");
	self endon("death");
	self endon("disconnect");
	self.var_A8A5 = self.origin;
	for(;;)
	{
		self waittill("damage");
		self.var_A8A5 = self.origin;
	}
}

//Function Number: 185
func_9E27(param_00,param_01,param_02,param_03)
{
	if(isdefined(param_03))
	{
		if(isdefined(param_03.var_222))
		{
			if(param_03.var_9F == "script_vehicle")
			{
				return 0;
			}

			if(param_03.var_9F == "misc_turret")
			{
				return 0;
			}

			if(param_03.var_9F == "script_model")
			{
				return 0;
			}
		}

		if(isdefined(param_03.agent_type))
		{
			if(param_03.agent_type == "dog" || param_03.agent_type == "alien")
			{
				return 0;
			}
		}
	}

	return (param_01 == "head" || param_01 == "helmet" || param_01 == "neck") && param_02 != "MOD_MELEE" && param_02 != "MOD_IMPACT" && param_02 != "MOD_SCARAB" && param_02 != "MOD_CRUSH" && !func_9DE2(param_00);
}

//Function Number: 186
func_81A0(param_00,param_01)
{
	var_02 = [];
	if(!isdefined(param_01) || param_01)
	{
		foreach(var_04 in level.var_3CB5)
		{
			if(var_04.team == param_00)
			{
				var_02[var_02.size] = var_04;
			}
		}
	}
	else
	{
		foreach(var_04 in level.players)
		{
			if(var_04.team == param_00)
			{
				var_02[var_02.size] = var_04;
			}
		}
	}

	return var_02;
}

//Function Number: 187
getotherteam(param_00)
{
	if(level.multiteambased)
	{
	}

	if(param_00 == "allies")
	{
		return "axis";
	}
	else if(param_00 == "axis")
	{
		return "allies";
	}
	else
	{
		return "none";
	}
}

//Function Number: 188
func_1372D(param_00,param_01,param_02,param_03,param_04,param_05,param_06,param_07,param_08,param_09,param_0A,param_0B,param_0C,param_0D)
{
	self endon("death");
	var_0E = spawnstruct();
	param_00 childthread scripts\common\utility::func_13806(param_01,var_0E);
	if(isdefined(param_02) && isdefined(param_03))
	{
		param_02 childthread scripts\common\utility::func_13806(param_03,var_0E);
	}

	if(isdefined(param_04) && isdefined(param_05))
	{
		param_04 childthread scripts\common\utility::func_13806(param_05,var_0E);
	}

	if(isdefined(param_06) && isdefined(param_07))
	{
		param_06 childthread scripts\common\utility::func_13806(param_07,var_0E);
	}

	if(isdefined(param_08) && isdefined(param_09))
	{
		param_08 childthread scripts\common\utility::func_13806(param_09,var_0E);
	}

	if(isdefined(param_0A) && isdefined(param_0B))
	{
		param_0A childthread scripts\common\utility::func_13806(param_0B,var_0E);
	}

	if(isdefined(param_0C) && isdefined(param_0D))
	{
		param_0C childthread scripts\common\utility::func_13806(param_0D,var_0E);
	}

	var_0E waittill("returned",var_0F);
	var_0E notify("die");
	return var_0F;
}

//Function Number: 189
func_1372C(param_00,param_01,param_02,param_03,param_04,param_05,param_06,param_07,param_08,param_09,param_0A,param_0B,param_0C,param_0D,param_0E)
{
	self endon("death");
	var_0F = spawnstruct();
	param_01 childthread scripts\common\utility::func_13806(param_02,var_0F);
	if(isdefined(param_03) && isdefined(param_04))
	{
		param_03 childthread scripts\common\utility::func_13806(param_04,var_0F);
	}

	if(isdefined(param_05) && isdefined(param_06))
	{
		param_05 childthread scripts\common\utility::func_13806(param_06,var_0F);
	}

	if(isdefined(param_07) && isdefined(param_08))
	{
		param_07 childthread scripts\common\utility::func_13806(param_08,var_0F);
	}

	if(isdefined(param_09) && isdefined(param_0A))
	{
		param_09 childthread scripts\common\utility::func_13806(param_0A,var_0F);
	}

	if(isdefined(param_0B) && isdefined(param_0C))
	{
		param_0B childthread scripts\common\utility::func_13806(param_0C,var_0F);
	}

	if(isdefined(param_0D) && isdefined(param_0E))
	{
		param_0D childthread scripts\common\utility::func_13806(param_0E,var_0F);
	}

	var_0F childthread scripts\common\utility::func_1428(param_00);
	var_0F waittill("returned",var_10);
	var_0F notify("die");
	return var_10;
}

//Function Number: 190
func_CF90(param_00,param_01,param_02,param_03,param_04)
{
	self endon("disconnect");
	self endon("intermission");
	self endon("death");
	var_05 = "black";
	if(scripts\common\utility::istrue(param_04))
	{
		var_05 = "white";
	}

	self.var_CF90 = newclienthudelem(self);
	self.var_CF90.x = 0;
	self.var_CF90.y = 0;
	self.var_CF90 setshader(var_05,640,480);
	self.var_CF90.alignx = "left";
	self.var_CF90.aligny = "top";
	self.var_CF90.sort = 1;
	self.var_CF90.horzalign = "fullscreen";
	self.var_CF90.vertalign = "fullscreen";
	self.var_CF90.alpha = 0;
	self.var_CF90.foreground = 1;
	if(!scripts\common\utility::istrue(param_03))
	{
		self.var_CF90 fadeovertime(param_00);
	}

	self.var_CF90.alpha = 1;
	if(!scripts\common\utility::istrue(param_03))
	{
		wait(param_00 + 0.05);
	}

	wait(param_01);
	self.var_CF90 fadeovertime(param_02);
	self.var_CF90.alpha = 0;
	wait(param_02 + 0.05);
	self.var_CF90 destroy();
}

//Function Number: 191
func_E552()
{
	var_00 = 0;
	var_01 = self getweaponslistprimaries();
	foreach(var_03 in var_01)
	{
		if(func_9F2D(var_03))
		{
			var_00 = 1;
			break;
		}
	}

	return var_00;
}

//Function Number: 192
func_E54D(param_00,param_01)
{
	var_02 = undefined;
	if(param_00)
	{
		self.var_E55A = param_01;
		var_02 = "tag_weapon_right";
	}
	else
	{
		self.var_E55B = param_01;
		var_02 = "tag_shield_back";
	}

	self attachshieldmodel(param_01,var_02);
	self.var_8C1E = func_E552();
}

//Function Number: 193
func_AAB5(param_00,param_01)
{
	if(isdefined(self.var_8C1F) && self.var_8C1F)
	{
		if(isdefined(self.var_E55A))
		{
			func_E54F(1);
			return;
		}

		if(isdefined(self.var_E55B))
		{
			func_E54F(0);
			return;
		}
	}
}

//Function Number: 194
func_E54F(param_00)
{
	var_01 = undefined;
	var_02 = undefined;
	if(param_00)
	{
		var_01 = self.var_E55A;
		var_02 = "tag_weapon_right";
	}
	else
	{
		var_01 = self.var_E55B;
		var_02 = "tag_shield_back";
	}

	self detachshieldmodel(var_01,var_02);
	if(param_00)
	{
		self.var_E55A = undefined;
	}
	else
	{
		self.var_E55B = undefined;
	}

	self.var_8C1E = func_E552();
}

//Function Number: 195
func_E554(param_00)
{
	var_01 = undefined;
	var_02 = undefined;
	var_03 = undefined;
	if(param_00)
	{
		var_03 = self.var_E55A;
		var_01 = "tag_weapon_right";
		var_02 = "tag_shield_back";
	}
	else
	{
		var_03 = self.var_E55B;
		var_01 = "tag_shield_back";
		var_02 = "tag_weapon_right";
	}

	self moveshieldmodel(var_03,var_01,var_02);
	if(param_00)
	{
		self.var_E55B = var_03;
		self.var_E55A = undefined;
		return;
	}

	self.var_E55A = var_03;
	self.var_E55B = undefined;
}

//Function Number: 196
func_E54E()
{
	self.var_8C1F = 0;
	self.var_8C1E = 0;
	self.var_E55B = undefined;
	self.var_E55A = undefined;
}

//Function Number: 197
func_DFE1()
{
	self setclientomnvar("zombie_souvenir_piece_index",0);
	if(isdefined(level.crafting_remove_func))
	{
		self [[ level.crafting_remove_func ]]();
	}

	self.var_4B5E = undefined;
}

//Function Number: 198
func_110AA(param_00,param_01)
{
	self.var_4643 = self getweaponslistall();
	self.var_464B = func_7910(self,param_01);
	self.var_464C = [];
	var_02 = [];
	foreach(var_04 in self.var_4643)
	{
		if(!isstrstart(var_04,"alt_"))
		{
			var_02[var_02.size] = var_04;
		}
	}

	self.var_4643 = var_02;
	foreach(var_04 in self.var_4643)
	{
		self.var_4648[var_04] = self getweaponammoclip(var_04);
		self.var_464A[var_04] = self getweaponammostock(var_04);
		if(issubstr(var_04,"akimbo"))
		{
			self.var_4649[var_04] = self getweaponammoclip(var_04,"left");
		}

		if(isdefined(self.var_C8A2[func_80D8(var_04)]))
		{
			self.var_464C[var_04] = self.var_C8A2[func_80D8(var_04)].var_B111;
		}
	}

	if(isdefined(param_00))
	{
		var_08 = [];
		foreach(var_04 in self.var_4643)
		{
			var_0A = 0;
			foreach(var_0C in param_00)
			{
				if(var_04 == var_0C)
				{
					var_0A = 1;
					break;
				}
				else if(getweaponbasename(var_04) == var_0C)
				{
					var_0A = 1;
					break;
				}
			}

			if(var_0A)
			{
				continue;
			}

			var_08[var_08.size] = var_04;
		}

		self.var_4643 = var_08;
		foreach(var_0C in param_00)
		{
			if(self.var_464B == var_0C)
			{
				self.var_464B = "none";
				break;
			}
		}
	}
}

//Function Number: 199
func_7910(param_00,param_01)
{
	var_02 = param_00 getcurrentweapon();
	if(scripts\common\utility::istrue(param_01) && func_9C42(var_02))
	{
		var_02 = param_00 getweaponslistall()[1];
	}

	return var_02;
}

//Function Number: 200
func_9C42(param_00,param_01)
{
	switch(param_00)
	{
		case "iw7_knife_zm_disco":
		case "iw7_knife_zm_cleaver":
		case "iw7_knife_zm_crowbar":
		case "iw7_knife_zm_elvira":
		case "iw7_knife_zm_rebel":
		case "iw7_knife_zm_soldier":
		case "iw7_knife_zm_scientist":
		case "iw7_knife_zm_schoolgirl":
		case "alt_iw7_knife_zm_survivor":
		case "alt_iw7_knife_zm_grunge":
		case "alt_iw7_knife_zm_hiphop":
		case "alt_iw7_knife_zm_raver":
		case "alt_iw7_knife_zm_chola":
		case "iw7_knife_zm_survivor":
		case "iw7_knife_zm_grunge":
		case "iw7_knife_zm_hiphop":
		case "iw7_knife_zm_raver":
		case "iw7_knife_zm_chola":
		case "alt_iw7_knife_zm_vgirl":
		case "alt_iw7_knife_zm_rapper":
		case "alt_iw7_knife_zm_nerd":
		case "alt_iw7_knife_zm_jock":
		case "alt_iw7_knife_zm":
		case "iw7_knife_zm_vgirl":
		case "iw7_knife_zm_rapper":
		case "iw7_knife_zm_nerd":
		case "iw7_knife_zm_jock":
		case "alt_iw7_knife_zm_hoff":
		case "iw7_knife_zm_hoff":
		case "iw7_knife_zm_wyler":
		case "iw7_knife_zm":
			return 1;

		case "iw7_katana_zm_pap2":
		case "iw7_katana_zm_pap1":
		case "iw7_nunchucks_zm_pap2":
		case "iw7_nunchucks_zm_pap1":
		case "iw7_katana_zm":
		case "iw7_nunchucks_zm":
		case "iw7_axe_zm_pap2":
		case "iw7_axe_zm_pap1":
		case "iw7_axe_zm":
		case "iw7_fists_zm_kevinsmith":
		case "iw7_fists_zm_raver":
		case "iw7_fists_zm_hiphop":
		case "iw7_fists_zm_grunge":
		case "iw7_fists_zm_chola":
		case "iw7_fists_zm":
			if(scripts\common\utility::istrue(param_01))
			{
				return 0;
			}
			else
			{
				return 1;
			}
	
			break;

		default:
			return 0;
	}
}

//Function Number: 201
func_9C8F(param_00)
{
	switch(param_00)
	{
		case "iw7_katana_zm_pap2":
		case "iw7_katana_zm_pap1":
		case "iw7_nunchucks_zm_pap2":
		case "iw7_nunchucks_zm_pap1":
		case "iw7_katana_zm":
		case "iw7_nunchucks_zm":
		case "iw7_axe_zm_pap2":
		case "iw7_axe_zm_pap1":
		case "iw7_axe_zm":
			return 1;
	}

	return 0;
}

//Function Number: 202
func_E2D5(param_00)
{
	if(!isdefined(self.var_4643) || !isdefined(self.var_464B) || !isdefined(self.var_4648) || !isdefined(self.var_464A))
	{
	}

	var_01 = self getweaponslistall();
	foreach(var_03 in var_01)
	{
		if(!scripts\common\utility::func_2286(self.var_4643,var_03) && !func_939A(param_00,var_03))
		{
			self takeweapon(var_03);
		}
	}

	foreach(var_03 in self.var_4643)
	{
		if(!self hasweapon(var_03))
		{
			var_06 = function_00E3(var_03);
			var_07 = getcurrentcamoname(var_03);
			self giveweapon(scripts\cp\_weapon::func_E469(var_03,undefined,var_06,undefined,var_07),-1,0,-1,1);
		}

		if(isdefined(self.var_D781) && self.var_D781 == var_03)
		{
			self method_844B(var_03);
		}

		if(isdefined(self.var_D785) && self.var_D785 == var_03)
		{
			self method_844C(var_03);
		}

		if(isdefined(self.var_10967) && self.var_10967 == var_03)
		{
			self method_84C2(var_03);
		}

		if(isdefined(self.var_4648[var_03]))
		{
			self setweaponammoclip(var_03,self.var_4648[var_03]);
		}

		if(isdefined(self.var_4649))
		{
			if(isdefined(self.var_4649[var_03]))
			{
				self setweaponammoclip(var_03,self.var_4649[var_03],"left");
			}
		}

		if(isdefined(self.var_464A[var_03]))
		{
			self setweaponammostock(var_03,self.var_464A[var_03]);
		}

		if(isdefined(self.var_464C[var_03]))
		{
			var_08 = spawnstruct();
			var_08.var_B111 = self.var_464C[var_03];
			self.var_C8A2[func_80D8(var_03)] = var_08;
		}
	}

	var_0A = self.var_464B;
	if(!isdefined(var_0A) || var_0A == "none")
	{
		foreach(var_0C in self.var_4643)
		{
			if(scripts\cp\_weapon::func_9D75(var_0C))
			{
				var_0A = var_0C;
				break;
			}
		}
	}

	if(scripts\common\utility::func_A009())
	{
		self method_83B6(var_0A);
	}

	self.var_4643 = undefined;
	self.var_464B = undefined;
	self.var_4648 = undefined;
	self.var_464A = undefined;
	self.var_4649 = undefined;
	if(isdefined(level.var_2117))
	{
		self [[ level.var_2117 ]]();
	}
}

//Function Number: 203
func_E2D2(param_00)
{
	if(!isdefined(self.var_4643) || !isdefined(self.var_464B) || !isdefined(self.var_4648) || !isdefined(self.var_464A))
	{
	}

	self.var_D8D5 = [];
	var_01 = 0;
	foreach(var_03 in self.var_4643)
	{
		if(func_9E55(var_03))
		{
			self.var_D8D5[var_01] = var_03;
			var_01 = var_01 + 1;
		}
	}

	var_05 = 0;
	foreach(var_03 in self.var_D8D5)
	{
		if(var_05 < 3)
		{
			if(isstrstart(var_03,"alt_"))
			{
				continue;
			}

			if(!self hasweapon(var_03))
			{
				if(issubstr(var_03,"knife_"))
				{
					self giveweapon(var_03,-1,0,-1,1);
				}
				else
				{
					var_07 = getcurrentcamoname(var_03);
					var_08 = function_00E3(var_03);
					self giveweapon(scripts\cp\_weapon::func_E469(var_03,undefined,var_08,undefined,var_07),-1,0,-1,1);
				}
			}

			self setweaponammoclip(var_03,self.var_4648[var_03]);
			self setweaponammostock(var_03,self.var_464A[var_03]);
			if(isdefined(self.var_464C[var_03]))
			{
				var_09 = spawnstruct();
				var_09.var_B111 = self.var_464C[var_03];
				self.var_C8A2[func_80D8(var_03)] = var_09;
			}

			var_05++;
		}
	}

	var_0B = self.var_464B;
	if(!isdefined(var_0B) || !self hasweapon(var_0B) || var_0B == "none")
	{
		var_0B = getweapontoswitchbackto();
	}

	self method_83B6(var_0B);
	self.var_4643 = undefined;
	self.var_464B = undefined;
	self.var_4648 = undefined;
	self.var_464A = undefined;
}

//Function Number: 204
func_4191()
{
	self.var_4643 = [];
	self.var_464B = "none";
	self.var_4648 = [];
	self.var_4649 = [];
	self.var_464A = [];
	self.var_464C = [];
}

//Function Number: 205
func_1785(param_00,param_01,param_02,param_03)
{
	foreach(var_05 in param_00)
	{
		self.var_4643[self.var_4643.size] = var_05;
		self.var_4648[var_05] = param_01[var_05];
		self.var_464A[var_05] = param_02[var_05];
	}

	self.var_464B = param_03;
}

//Function Number: 206
func_939A(param_00,param_01)
{
	if(!isdefined(param_00))
	{
		return 0;
	}

	return scripts\common\utility::func_2286(param_00,param_01);
}

//Function Number: 207
func_13192(param_00,param_01)
{
	return (param_00[0] * param_01,param_00[1] * param_01,param_00[2] * param_01);
}

//Function Number: 208
func_E2D4()
{
	self giveweapon("super_default_zm");
	self method_84C2("super_default_zm");
	self.var_10967 = "super_default_zm";
	if(scripts\common\utility::istrue(self.var_4561))
	{
		self setweaponammoclip("super_default_zm",1);
	}
}

//Function Number: 209
func_9D20()
{
	return isagent(self) && isdefined(self.var_1096F) && self.var_1096F == "humanoid" || self.var_1096F == "zombie";
}

//Function Number: 210
func_9D22()
{
	return level.gametype == "zombie";
}

//Function Number: 211
func_462B(param_00)
{
	if(!isdefined(level.var_462A))
	{
		return 0;
	}

	return isdefined(level.var_462A[param_00]);
}

//Function Number: 212
coop_mode_enable(param_00)
{
	if(!isdefined(level.var_462A))
	{
		level.var_462A = [];
	}

	foreach(var_02 in param_00)
	{
		level.var_462A[var_02] = 1;
	}
}

//Function Number: 213
func_B268(param_00,param_01)
{
	if(!isdefined(param_01))
	{
		param_01 = 1;
	}

	if(param_01)
	{
		return self method_81F1(param_00,1);
	}

	return self method_81F1(param_00);
}

//Function Number: 214
func_7844(param_00)
{
	if(isdefined(param_00))
	{
		if(isplayer(param_00))
		{
			return param_00;
		}

		if(isdefined(param_00.var_222) && isplayer(param_00.var_222))
		{
			return param_00.var_222;
		}
	}

	return undefined;
}

//Function Number: 215
func_E0F6(param_00)
{
	if(isdefined(level.var_68C9))
	{
		foreach(var_02 in level.var_68C9)
		{
			foreach(var_04 in param_00)
			{
				if(func_2494(var_04) == var_02)
				{
					param_00 = scripts\common\utility::func_22A9(param_00,var_04);
				}
			}
		}
	}

	return param_00;
}

//Function Number: 216
func_80C6(param_00,param_01,param_02)
{
	var_03 = [];
	if(func_13C96(param_00,param_01,"passive_random_attachments"))
	{
		if(0)
		{
			var_04 = func_7DE6(param_00,param_02,0);
			var_03[var_03.size] = var_04[randomint(var_04.size)];
		}
		else
		{
			var_05 = int(max(0,5 - param_02.size));
			if(var_05 > 0)
			{
				var_06 = randomintrange(1,var_05 + 1);
				var_03 = func_3217(param_00,var_06,param_02);
			}
		}
	}

	return var_03;
}

//Function Number: 217
func_13C96(param_00,param_01,param_02)
{
	var_03 = func_8229(param_00,param_01);
	if(!isdefined(var_03) || var_03.size <= 0)
	{
		return 0;
	}

	foreach(var_05 in var_03)
	{
		if(param_02 == var_05)
		{
			return 1;
		}
	}

	return 0;
}

//Function Number: 218
func_3217(param_00,param_01,param_02)
{
	var_03 = [];
	var_04 = scripts\cp\_weapon::func_7DE2(param_00,param_02);
	if(var_04.size > 0)
	{
		var_03 = [];
		var_05 = scripts\common\utility::func_22A8(var_04);
		foreach(var_0A, var_07 in var_05)
		{
			if(param_01 <= 0)
			{
				break;
			}

			var_08 = 1;
			switch(var_0A)
			{
				case "undermount":
				case "barrel":
					var_08 = 1;
					break;

				case "rail":
				case "pap":
				case "perk":
					var_08 = 0;
					break;

				default:
					var_08 = randomintrange(1,param_01 + 1);
					break;
			}

			if(var_08 > 0)
			{
				if(var_08 > var_07.size)
				{
					var_08 = var_07.size;
				}

				param_01 = param_01 - var_08;
				var_07 = scripts\common\utility::func_22A8(var_07);
				while(var_08 > 0)
				{
					var_09 = var_07[var_07.size - var_08];
					if(!issubstr(var_09,"ark") && !issubstr(var_09,"arcane"))
					{
						var_03[var_03.size] = var_09;
					}

					var_08--;
				}
			}
		}
	}

	return var_03;
}

//Function Number: 219
func_7DE6(param_00,param_01,param_02)
{
	if(!isdefined(param_02))
	{
		param_02 = 1;
	}

	var_03 = func_8217(param_00);
	var_04 = [];
	foreach(var_06 in var_03)
	{
		var_07 = getattachmenttype(var_06);
		if(!param_02 && var_07 == "rail")
		{
			continue;
		}

		if(isdefined(param_01) && func_AD7F(param_01,var_06))
		{
			continue;
		}

		var_04[var_04.size] = var_06;
	}

	return var_04;
}

//Function Number: 220
func_AD7F(param_00,param_01)
{
	foreach(var_03 in param_00)
	{
		if(var_03 == param_01)
		{
			return 1;
		}
	}

	return 0;
}

//Function Number: 221
func_8217(param_00)
{
	param_00 = func_8234(param_00);
	if(!isdefined(level.var_13C79))
	{
		level.var_13C79 = [];
	}

	if(!isdefined(level.var_13C79[param_00]))
	{
		var_01 = [];
		for(var_02 = 0;var_02 <= 19;var_02++)
		{
			var_03 = tablelookup("mp/statsTable.csv",4,param_00,10 + var_02);
			if(var_03 == "")
			{
				break;
			}

			var_01[var_01.size] = var_03;
		}

		level.var_13C79[param_00] = var_01;
	}

	return level.var_13C79[param_00];
}

//Function Number: 222
getweaponpaintjobid(param_00)
{
	return -1;
}

//Function Number: 223
getweaponcamo(param_00)
{
	var_01 = self getplayerdata("cp","zombiePlayerLoadout","zombiePlayerWeaponModels",param_00,"camo");
	if(isdefined(var_01) && var_01 != "none")
	{
		return var_01;
	}

	return "none";
}

//Function Number: 224
getweaponcosmeticattachment(param_00)
{
	var_01 = self getplayerdata("cp","zombiePlayerLoadout","zombiePlayerWeaponModels",param_00,"cosmeticAttachment");
	if(isdefined(var_01) && var_01 != "none")
	{
		return var_01;
	}

	return "none";
}

//Function Number: 225
getweaponreticle(param_00)
{
	var_01 = self getplayerdata("cp","zombiePlayerLoadout","zombiePlayerWeaponModels",param_00,"reticle");
	if(isdefined(var_01) && var_01 != "none")
	{
		return var_01;
	}

	return "none";
}

//Function Number: 226
excludeweaponfromregularweaponchecks(param_00)
{
	if(param_00 == "iw7_entangler_zm" || param_00 == "iw7_entangler2_zm")
	{
		return 1;
	}

	if(issubstr(param_00,"venomx") || issubstr(param_00,"nunchucks") || issubstr(param_00,"katana"))
	{
		return 1;
	}

	return 0;
}

//Function Number: 227
func_BD68(param_00,param_01,param_02,param_03,param_04,param_05,param_06,param_07,param_08)
{
	var_09 = func_13C76(param_00);
	var_0A = func_3220(param_00,param_04);
	if(isdefined(param_04) && param_04 >= 0 && !excludeweaponfromregularweaponchecks(var_0A))
	{
		var_0B = func_80C6(var_0A,param_04,param_01);
		if(var_0B.size > 0)
		{
			param_01 = scripts\common\utility::func_2284(param_01,var_0B);
		}
	}

	var_0C = func_4626(var_0A);
	if(isdefined(var_09))
	{
		param_01 = scripts\common\utility::func_2284(param_01,var_09);
	}

	param_01 = func_13C7A(param_01);
	param_01 = func_E0F6(param_01);
	for(var_0D = 0;var_0D < param_01.size;var_0D++)
	{
		param_01[var_0D] = func_2496(param_01[var_0D],var_0A);
	}

	if(isdefined(var_09))
	{
		for(var_0D = 0;var_0D < var_09.size;var_0D++)
		{
			var_09[var_0D] = func_2496(var_09[var_0D],var_0A);
		}
	}

	if(isdefined(var_09))
	{
		param_01 = scripts\common\utility::func_2284(param_01,var_09);
	}

	if(isdefined(param_04) && param_04 >= 0 && !excludeweaponfromregularweaponchecks(var_0A))
	{
		var_0E = func_823A(var_0A,param_04);
		if(var_0E.size > 0)
		{
			param_01 = scripts\common\utility::func_2284(param_01,var_0E);
		}
	}

	param_01 = scripts\common\utility::func_22A9(param_01,"none");
	if(isdefined(param_08) && param_08 != "none")
	{
		param_01[param_01.size] = param_08;
	}

	if(param_01.size > 0)
	{
		param_01 = func_6C18(param_01);
	}

	var_0F = [];
	foreach(var_11 in param_01)
	{
		var_12 = func_2495(var_11);
		if(isdefined(var_12))
		{
			var_0F[var_0F.size] = func_2496(var_12,var_0A);
		}
	}

	if(var_0F.size > 0)
	{
		param_01 = scripts\common\utility::func_2284(param_01,var_0F);
	}

	if(param_01.size > 0)
	{
		param_01 = scripts\common\utility::func_1D3A(param_01);
	}

	var_0A = reassign_weapon_name(var_0A,param_01);
	foreach(var_15 in param_01)
	{
		var_0A = var_0A + "+" + var_15;
	}

	if(issubstr(var_0A,"iw7"))
	{
		var_0A = func_3225(var_0A,param_02,param_04);
		var_17 = 0;
		if(isholidayweapon(var_0A,param_04) || issummerholidayweapon(var_0A,param_04))
		{
			var_17 = isholidayweaponusingdefaultscope(var_0A,param_01);
		}

		if(var_17)
		{
			var_0A = var_0A + "+scope1";
		}
		else
		{
			var_0A = func_3227(var_0A,param_03);
		}

		var_0A = func_3228(var_0A,param_04);
	}

	return var_0A;
}

//Function Number: 228
reassign_weapon_name(param_00,param_01)
{
	if(isdefined(level.weapon_upgrade_path) && isdefined(level.weapon_upgrade_path[getweaponbasename(param_00)]))
	{
		return param_00;
	}
	else
	{
		switch(param_00)
		{
			case "iw7_machete_mp":
				if(scripts\common\utility::istrue(self.base_weapon))
				{
					param_00 = "iw7_machete_mp";
				}
				else if((isdefined(self.var_C8A2[func_80D8(param_00)]) && self.var_C8A2[func_80D8(param_00)].var_B111 == 1) || scripts\common\utility::istrue(self.ephemeral_downgrade))
				{
					if(scripts\common\utility::istrue(self.bang_bangs))
					{
						param_00 = "iw7_machete_mp";
					}
					else
					{
						param_00 = "iw7_machete_mp_pap1";
					}
				}
				else if(isdefined(self.var_C8A2[func_80D8(param_00)]) && self.var_C8A2[func_80D8(param_00)].var_B111 == 2)
				{
					if(scripts\common\utility::istrue(self.bang_bangs))
					{
						param_00 = "iw7_machete_mp_pap1";
					}
					else
					{
						param_00 = "iw7_machete_mp_pap2";
					}
				}
				else if(isdefined(self.var_C8A2[func_80D8(param_00)]) && self.var_C8A2[func_80D8(param_00)].var_B111 == 3)
				{
					param_00 = "iw7_machete_mp_pap2";
				}
				break;

			case "iw7_two_headed_axe_mp":
				if(scripts\common\utility::istrue(self.base_weapon))
				{
					param_00 = "iw7_two_headed_axe_mp";
				}
				else if((isdefined(self.var_C8A2[func_80D8(param_00)]) && self.var_C8A2[func_80D8(param_00)].var_B111 == 1) || scripts\common\utility::istrue(self.ephemeral_downgrade))
				{
					if(scripts\common\utility::istrue(self.bang_bangs))
					{
						param_00 = "iw7_two_headed_axe_mp";
					}
					else
					{
						param_00 = "iw7_two_headed_axe_mp_pap1";
					}
				}
				else if(isdefined(self.var_C8A2[func_80D8(param_00)]) && self.var_C8A2[func_80D8(param_00)].var_B111 == 2)
				{
					if(scripts\common\utility::istrue(self.bang_bangs))
					{
						param_00 = "iw7_two_headed_axe_mp_pap1";
					}
					else
					{
						param_00 = "iw7_two_headed_axe_mp_pap2";
					}
				}
				else if(isdefined(self.var_C8A2[func_80D8(param_00)]) && self.var_C8A2[func_80D8(param_00)].var_B111 == 3)
				{
					param_00 = "iw7_two_headed_axe_mp_pap2";
				}
				break;

			case "iw7_spiked_bat_mp":
				if(scripts\common\utility::istrue(self.base_weapon))
				{
					param_00 = "iw7_spiked_bat_mp";
				}
				else if((isdefined(self.var_C8A2[func_80D8(param_00)]) && self.var_C8A2[func_80D8(param_00)].var_B111 == 1) || scripts\common\utility::istrue(self.ephemeral_downgrade))
				{
					if(scripts\common\utility::istrue(self.bang_bangs))
					{
						param_00 = "iw7_spiked_bat_mp";
					}
					else
					{
						param_00 = "iw7_spiked_bat_mp_pap1";
					}
				}
				else if(isdefined(self.var_C8A2[func_80D8(param_00)]) && self.var_C8A2[func_80D8(param_00)].var_B111 == 2)
				{
					if(scripts\common\utility::istrue(self.bang_bangs))
					{
						param_00 = "iw7_spiked_bat_mp_pap1";
					}
					else
					{
						param_00 = "iw7_spiked_bat_mp_pap2";
					}
				}
				else if(isdefined(self.var_C8A2[func_80D8(param_00)]) && self.var_C8A2[func_80D8(param_00)].var_B111 == 3)
				{
					param_00 = "iw7_spiked_bat_mp_pap2";
				}
				break;

			case "iw7_golf_club_mp":
				if(scripts\common\utility::istrue(self.base_weapon))
				{
					param_00 = "iw7_golf_club_mp";
				}
				else if((isdefined(self.var_C8A2[func_80D8(param_00)]) && self.var_C8A2[func_80D8(param_00)].var_B111 == 1) || scripts\common\utility::istrue(self.ephemeral_downgrade))
				{
					if(scripts\common\utility::istrue(self.bang_bangs))
					{
						param_00 = "iw7_golf_club_mp";
					}
					else
					{
						param_00 = "iw7_golf_club_mp_pap1";
					}
				}
				else if(isdefined(self.var_C8A2[func_80D8(param_00)]) && self.var_C8A2[func_80D8(param_00)].var_B111 == 2)
				{
					if(scripts\common\utility::istrue(self.bang_bangs))
					{
						param_00 = "iw7_golf_club_mp_pap1";
					}
					else
					{
						param_00 = "iw7_golf_club_mp_pap2";
					}
				}
				else if(isdefined(self.var_C8A2[func_80D8(param_00)]) && self.var_C8A2[func_80D8(param_00)].var_B111 == 3)
				{
					param_00 = "iw7_golf_club_mp_pap2";
				}
				break;

			case "iw7_axe_zm":
				if(scripts\common\utility::func_2286(param_01,"axepap1"))
				{
					param_00 = "iw7_axe_zm_pap1";
				}
				else if(scripts\common\utility::func_2286(param_01,"axepap2"))
				{
					param_00 = "iw7_axe_zm_pap2";
				}
				break;

			case "iw7_katana_zm":
				if(scripts\common\utility::func_2286(param_01,"katanapap1"))
				{
					param_00 = "iw7_katana_zm_pap1";
				}
				else if(scripts\common\utility::func_2286(param_01,"katanapap2"))
				{
					param_00 = "iw7_katana_zm_pap2";
				}
				break;

			case "iw7_nunchucks_zm":
				if(scripts\common\utility::func_2286(param_01,"nunchuckspap1"))
				{
					param_00 = "iw7_nunchucks_zm_pap1";
				}
				else if(scripts\common\utility::func_2286(param_01,"nunchuckspap2"))
				{
					param_00 = "iw7_nunchucks_zm_pap2";
				}
				break;

			case "iw7_forgefreeze_zm":
				if(scripts\common\utility::func_2286(param_01,"freezepap1"))
				{
					param_00 = "iw7_forgefreeze_zm_pap1";
				}
				else if(scripts\common\utility::func_2286(param_01,"freezepap2"))
				{
					param_00 = "iw7_forgefreeze_zm_pap2";
				}
				break;

			case "iw7_shredder_zm":
				if(scripts\common\utility::func_2286(param_01,"shredderpap1"))
				{
					param_00 = "iw7_shredder_zm_pap1";
				}
				break;

			case "iw7_dischord_zm":
				if(scripts\common\utility::func_2286(param_01,"dischordpap1"))
				{
					param_00 = "iw7_dischord_zm_pap1";
				}
				break;

			case "iw7_facemelter_zm":
				if(scripts\common\utility::func_2286(param_01,"fmpap1"))
				{
					param_00 = "iw7_facemelter_zm_pap1";
				}
				break;

			case "iw7_headcutter_zm":
				if(scripts\common\utility::func_2286(param_01,"hcpap1"))
				{
					param_00 = "iw7_headcutter_zm_pap1";
				}
				break;
		}
	}

	return param_00;
}

//Function Number: 229
func_7D72(param_00,param_01)
{
	var_02 = func_7DF7(param_01);
	if(function_02D9("mp","LoadoutWeapon",var_02) && func_13C99(var_02))
	{
		return param_00 getplayerdata("cp","zombiePlayerLoadout","zombiePlayerWeaponModels",var_02,"variantID");
	}

	return -1;
}

//Function Number: 230
func_13C99(param_00)
{
	if(!isdefined(param_00))
	{
		return 0;
	}

	switch(param_00)
	{
		case "iw7_glprox":
		case "iw7_lockon":
		case "iw7_chargeshot":
		case "iw7_axe":
		case "iw7_g18c":
		case "iw7_arclassic":
		case "iw7_spasc":
		case "iw7_cheytacc":
		case "iw7_ump45c":
		case "iw7_m1c":
			return 0;

		default:
			return 1;
	}
}

//Function Number: 231
func_13C7A(param_00)
{
	var_01 = [];
	foreach(var_03 in param_00)
	{
		if(isdefined(level.var_248B[var_03]))
		{
			continue;
		}

		var_01[var_01.size] = var_03;
	}

	return var_01;
}

//Function Number: 232
func_13C76(param_00)
{
	if(isdefined(level.var_13CA5[param_00]) && isdefined(level.var_13CA5[param_00].var_2476))
	{
		return level.var_13CA5[param_00].var_2476;
	}

	return undefined;
}

//Function Number: 233
func_3220(param_00,param_01)
{
	if(excludeweaponfromregularweaponchecks(param_00) || !isdefined(param_01) || param_01 < 0)
	{
		switch(param_00)
		{
			case "iw7_two_headed_axe":
			case "iw7_spiked_bat":
			case "iw7_machete":
			case "iw7_golf_club":
				return param_00 + "_mp";

			case "iw7_golf_club_mp":
			case "iw7_spiked_bat_mp":
			case "iw7_two_headed_axe_mp":
			case "iw7_machete_mp":
			case "super_default_zm":
				return param_00;

			case "iw7_ake":
				return param_00 + "_zml";

			case "iw7_crb":
				return param_00 + "_zml";

			case "iw7_sonic":
				return param_00 + "_zmr";

			case "iw7_ump45":
				return param_00 + "_zml";

			case "iw7_ripper":
				return param_00 + "_zmr";

			case "iw7_g18":
				return param_00 + "_zmr";

			case "iw7_spas":
				return param_00 + "_zmr";

			case "iw7_cheytac":
				return param_00 + "_zmr";

			case "iw7_venomx_zm_pap2":
			case "iw7_venomx_zm_pap1":
			case "iw7_venomx_zm":
			case "iw7_katana_zm_pap2":
			case "iw7_katana_zm_pap1":
			case "iw7_nunchucks_zm_pap2":
			case "iw7_nunchucks_zm_pap1":
			case "iw7_katana_zm":
			case "iw7_nunchucks_zm":
				return param_00;
		}

		return param_00 + "_zm";
	}

	switch(param_00)
	{
		case "iw7_venomx_zm_pap2":
		case "iw7_venomx_zm_pap1":
		case "iw7_venomx_zm":
		case "iw7_katana_zm_pap2":
		case "iw7_katana_zm_pap1":
		case "iw7_nunchucks_zm_pap2":
		case "iw7_nunchucks_zm_pap1":
		case "iw7_katana_zm":
		case "iw7_nunchucks_zm":
			return param_00;

		default:
			var_02 = func_8215(param_00,param_01);
			return var_02;
	}
}

//Function Number: 234
func_8215(param_00,param_01)
{
	var_02 = "mp/loot/weapon/" + param_00 + ".csv";
	var_03 = tablelookup(var_02,0,param_01,20);
	return var_03;
}

//Function Number: 235
func_823A(param_00,param_01)
{
	var_02 = [];
	var_03 = func_8229(param_00,param_01);
	if(isdefined(var_03))
	{
		foreach(var_05 in var_03)
		{
			var_06 = func_8048(var_05);
			if(!isdefined(var_06))
			{
				continue;
			}

			var_02[var_02.size] = var_06;
		}
	}

	return var_02;
}

//Function Number: 236
func_8048(param_00)
{
	var_01 = func_804D(param_00);
	if(!isdefined(var_01) || !isdefined(var_01.var_249B))
	{
		return undefined;
	}

	return var_01.var_249B;
}

//Function Number: 237
func_8229(param_00,param_01)
{
	return func_804C(param_00,param_01);
}

//Function Number: 238
func_804C(param_00,param_01)
{
	var_02 = func_7F82(param_00,param_01);
	if(isdefined(var_02))
	{
		return var_02.var_C946;
	}

	return undefined;
}

//Function Number: 239
func_7F82(param_00,param_01)
{
	var_02 = func_8234(param_00);
	if(!isdefined(level.var_B09C))
	{
		level.var_B09C = [];
	}

	if(isdefined(level.var_B09C[var_02]) && isdefined(level.var_B09C[var_02][param_01]))
	{
		var_03 = level.var_B09C[var_02][param_01];
		return var_03;
	}

	var_03 = func_36A4(param_01,var_03,var_02);
	if(isdefined(var_03))
	{
		return var_03;
	}

	return undefined;
}

//Function Number: 240
func_8234(param_00)
{
	var_01 = strtok(param_00,"_");
	if(weapon_is_dlc_melee(param_00))
	{
		param_00 = var_01[0];
		for(var_02 = 1;var_02 < var_01.size - 1;var_02++)
		{
			param_00 = param_00 + "_" + var_01[var_02];
		}
	}
	else if(weapon_is_dlc2_melee(param_00))
	{
		return param_00;
	}
	else if(weapon_is_venomx(param_00))
	{
		return param_00;
	}
	else if(var_01[0] == "iw6" || var_01[0] == "iw7")
	{
		param_00 = var_01[0] + "_" + var_01[1];
	}
	else if(var_01[0] == "alt")
	{
		param_00 = var_01[1] + "_" + var_01[2];
	}

	return param_00;
}

//Function Number: 241
weapon_is_venomx(param_00)
{
	return issubstr(param_00,"venomx");
}

//Function Number: 242
weapon_is_dlc2_melee(param_00)
{
	return issubstr(param_00,"katana") || issubstr(param_00,"nunchucks");
}

//Function Number: 243
weapon_is_dlc_melee(param_00)
{
	return issubstr(param_00,"two_headed") || issubstr(param_00,"spiked_bat") || issubstr(param_00,"machete") || issubstr(param_00,"golf_club");
}

//Function Number: 244
func_36A4(param_00,param_01,param_02)
{
	if(!isdefined(level.var_B09C[param_01]))
	{
		level.var_B09C[param_01] = [];
	}

	var_03 = function_02C3(param_00);
	var_04 = func_DD6A(var_03,param_02);
	level.var_B09C[param_01][param_02] = var_04;
	return var_04;
}

//Function Number: 245
func_DD6A(param_00,param_01)
{
	var_02 = tablelookuprownum(param_00,0,param_01);
	var_03 = spawnstruct();
	var_03.var_DE3F = tablelookupbyrow(param_00,var_02,1);
	var_03.var_13C74 = tablelookupbyrow(param_00,var_02,20);
	var_03.var_C946 = [];
	for(var_04 = 0;var_04 < 3;var_04++)
	{
		var_05 = tablelookupbyrow(param_00,var_02,21 + var_04);
		if(isdefined(var_05) && var_05 != "")
		{
			var_03.var_C946[var_03.var_C946.size] = var_05;
		}
	}

	return var_03;
}

//Function Number: 246
func_6C18(param_00)
{
	var_01 = [];
	if(isdefined(param_00))
	{
		foreach(var_03 in param_00)
		{
			var_04 = 1;
			foreach(var_06 in var_01)
			{
				if(var_03 == var_06)
				{
					var_04 = 0;
					break;
				}

				if(!func_249D(var_03,var_06))
				{
					var_04 = 0;
					break;
				}
			}

			if(var_04)
			{
				var_01[var_01.size] = var_03;
			}
		}
	}

	return var_01;
}

//Function Number: 247
func_249D(param_00,param_01)
{
	param_00 = func_2494(param_00);
	param_01 = func_2494(param_01);
	var_02 = 1;
	if(param_00 == param_01)
	{
		var_02 = 0;
	}
	else if(isdefined(level.var_2493))
	{
		var_03 = scripts\common\utility::func_1D3A([param_00,param_01]);
		var_02 = !isdefined(level.var_2493[var_03[0] + "_" + var_03[1]]);
	}
	else if(param_00 != "none" && param_01 != "none")
	{
		var_04 = tablelookuprownum("mp/attachmentcombos.csv",0,param_01);
		if(tablelookup("mp/attachmentcombos.csv",0,param_00,var_04) == "no")
		{
			var_02 = 0;
		}
	}

	return var_02;
}

//Function Number: 248
func_2495(param_00)
{
	var_01 = undefined;
	if(isdefined(level.var_2498[param_00]))
	{
		var_01 = level.var_2498[param_00];
	}

	return var_01;
}

//Function Number: 249
func_804D(param_00)
{
	if(!isdefined(level.var_C943[param_00]))
	{
		return undefined;
	}

	var_01 = level.var_C943[param_00];
	return var_01;
}

//Function Number: 250
map_check(param_00)
{
	if(!isdefined(param_00))
	{
		return 1;
	}

	switch(param_00)
	{
		case 0:
			if(level.script == "cp_zmb")
			{
				return 1;
			}
			else
			{
				return 0;
			}
	
			break;

		case 1:
			if(level.script == "cp_rave")
			{
				return 1;
			}
			else
			{
				return 0;
			}
	
			break;

		case 2:
			if(level.script == "cp_disco")
			{
				return 1;
			}
			else
			{
				return 0;
			}
	
			break;

		case 3:
			if(level.script == "cp_town")
			{
				return 1;
			}
			else
			{
				return 0;
			}
	
			break;

		case 4:
			if(level.script == "cp_final")
			{
				return 1;
			}
			else
			{
				return 0;
			}
	
			break;

		default:
			return 1;
	}
}

//Function Number: 251
func_3224(param_00,param_01,param_02,param_03,param_04)
{
	if(isstrstart(param_00,"iw7_"))
	{
		param_02 = 0;
	}

	var_05 = [];
	foreach(var_07 in param_01)
	{
		var_05[var_05.size] = func_2496(var_07,param_00);
	}

	var_09 = func_80D8(param_00);
	var_0A = param_00;
	var_0B = var_09 == "kbs" || var_09 == "cheytac" || var_09 == "m8" || var_09 == "ripper" || var_09 == "erad" || var_09 == "ar57";
	if(var_0B)
	{
		var_0C = 0;
		foreach(var_07 in var_05)
		{
			if(getattachmenttype(var_07) == "rail")
			{
				var_0C = 1;
				break;
			}
		}

		if(!var_0C)
		{
			var_05[var_05.size] = var_09 + "scope";
		}
	}

	if(var_05.size > 0)
	{
		var_0F = scripts\common\utility::func_22AF(var_05);
		var_05 = scripts\common\utility::func_1D3A(var_0F);
	}

	foreach(var_07 in var_05)
	{
		var_0A = var_0A + "+" + var_07;
	}

	if(issubstr(var_0A,"iw6") || issubstr(var_0A,"iw7"))
	{
		var_0A = func_3225(var_0A,param_02);
		if(param_04 != "weapon_sniper" && isdefined(param_03))
		{
			var_0A = func_3227(var_0A,param_03);
		}
	}
	else if(!scripts\cp\_weapon::func_9FED(var_0A + "_zm"))
	{
		var_0A = param_00 + "_zm";
	}
	else
	{
		var_0A = func_3225(var_0A,param_02);
		var_0A = func_3227(var_0A,param_03);
		var_0A = var_0A + "_zm";
	}

	return var_0A;
}

//Function Number: 252
func_3228(param_00,param_01)
{
	if(!isdefined(param_01) || param_01 < 0)
	{
		return param_00;
	}

	if(excludeweaponfromregularweaponchecks(param_00))
	{
		return param_00;
	}

	param_00 = param_00 + "+loot" + param_01;
	return param_00;
}

//Function Number: 253
isholidayweapon(param_00,param_01)
{
	if(!isdefined(param_01) || param_01 < 0)
	{
		return 0;
	}

	if(param_01 == 6)
	{
		var_02 = func_8234(param_00);
		return var_02 == "iw7_ripper" || var_02 == "iw7_lmg03" || var_02 == "iw7_ar57";
	}

	return 0;
}

//Function Number: 254
issummerholidayweapon(param_00,param_01)
{
	if(!isdefined(param_01) || param_01 < 0)
	{
		return 0;
	}

	var_02 = func_8234(param_00);
	if(param_01 == 8)
	{
		return var_02 == "iw7_erad" || var_02 == "iw7_ake" || var_02 == "iw7_sdflmg";
	}

	if(param_01 == 5)
	{
		return var_02 == "iw7_mod2187" || var_02 == "iw7_longshot";
	}

	return 0;
}

//Function Number: 255
ishalloweenholidayweapon(param_00,param_01)
{
	if(!isdefined(param_01) || param_01 < 0)
	{
		return 0;
	}

	var_02 = func_8234(param_00);
	if(param_01 == 9)
	{
		return var_02 == "iw7_kbs" || var_02 == "iw7_ripper" || var_02 == "iw7_m4";
	}

	if(param_01 == 8)
	{
		return var_02 == "iw7_mod2187";
	}

	if(param_01 == 7)
	{
		return var_02 == "iw7_mag";
	}

	if(param_01 == 6)
	{
		return var_02 == "iw7_minilmg";
	}

	return 0;
}

//Function Number: 256
ismark2weapon(param_00)
{
	if(!isdefined(param_00))
	{
		return 0;
	}

	return param_00 >= 32;
}

//Function Number: 257
isholidayweaponusingdefaultscope(param_00,param_01)
{
	var_02 = func_2496("scope",getweaponbasename(param_00));
	return isdefined(var_02) && scripts\common\utility::func_2286(param_01,var_02);
}

//Function Number: 258
is_pap_camo(param_00)
{
	if(isdefined(level.pap_1_camo) && param_00 == level.pap_1_camo)
	{
		return 1;
	}
	else if(isdefined(level.pap_2_camo) && param_00 == level.pap_2_camo)
	{
		return 1;
	}

	return 0;
}

//Function Number: 259
func_3225(param_00,param_01,param_02)
{
	var_03 = -1;
	var_04 = isdefined(param_01) && is_pap_camo(param_01);
	if(param_00 == "iw7_nunchucks_zm_pap1" || param_00 == "iw7_nunchucks_zm_pap2")
	{
		return param_00 + "+camo" + 222;
	}

	if(excludeweaponfromregularweaponchecks(param_00))
	{
		if(param_00 == "iw7_nunchucks_zm" || param_00 == "iw7_katana_zm")
		{
			return param_00;
		}
	}

	if(!var_04)
	{
		if(isholidayweapon(param_00,param_02))
		{
			var_03 = int(tablelookup("mp/camoTable.csv",1,"camo89",scripts\common\utility::getcamotablecolumnindex("weapon_index")));
			return param_00 + "+camo" + var_03;
		}
		else if(issummerholidayweapon(param_00,param_02))
		{
			var_03 = int(tablelookup("mp/camoTable.csv",1,"camo230",scripts\common\utility::getcamotablecolumnindex("weapon_index")));
			return param_00 + "+camo" + var_03;
		}
		else if(ishalloweenholidayweapon(param_00,param_02))
		{
			var_03 = int(tablelookup("mp/camoTable.csv",1,"camo242",scripts\common\utility::getcamotablecolumnindex("weapon_index")));
			return param_00 + "+camo" + var_03;
		}
		else if((!isdefined(param_01) || param_01 == "none") && ismark2weapon(param_02))
		{
			var_05 = getweaponqualitybyid(param_00,param_02);
			var_06 = undefined;
			switch(var_05)
			{
				case 1:
							var_06 = "camo99";
							break;

				case 2:
							var_06 = "camo101";
							break;

				case 3:
							var_06 = "camo102";
							break;

				case 4:
							var_06 = "camo103";
							break;

				default:
							break;
			}

			var_03 = int(tablelookup("mp/camoTable.csv",1,var_06,scripts\common\utility::getcamotablecolumnindex("weapon_index")));
			return param_00 + "+camo" + var_03;
		}
	}

	if(!isdefined(var_03))
	{
		var_05 = 0;
	}
	else
	{
		var_05 = int(tablelookup("mp/camoTable.csv",1,var_03,scripts\common\utility::getcamotablecolumnindex("weapon_index")));
	}

	if(var_05 <= 0)
	{
		var_05 = getweaponqualitybyid(param_02,var_04);
		var_06 = undefined;
		switch(var_05)
		{
			case 1:
				var_06 = "camo24";
				break;

			case 2:
				var_06 = "camo19";
				break;

			case 3:
				var_06 = "camo18";
				break;

			default:
				break;
		}

		if(isdefined(var_06))
		{
			var_03 = int(tablelookup("mp/camoTable.csv",1,var_06,scripts\common\utility::getcamotablecolumnindex("weapon_index")));
		}
		else
		{
			return param_00;
		}
	}

	return param_00 + "+camo" + var_03;
}

//Function Number: 260
getweaponqualitybyid(param_00,param_01)
{
	if(!isdefined(param_01) || param_01 < 0 || excludeweaponfromregularweaponchecks(param_00))
	{
		return 0;
	}

	var_02 = function_02C3(param_00);
	var_03 = int(tablelookup(var_02,0,param_01,4));
	return var_03;
}

//Function Number: 261
func_3227(param_00,param_01)
{
	if(!isdefined(param_01))
	{
		return param_00;
	}

	if(excludeweaponfromregularweaponchecks(param_00))
	{
		return param_00;
	}

	var_02 = int(tablelookup("mp/reticleTable.csv",1,param_01,5));
	if(!isdefined(var_02) || var_02 == 0)
	{
		return param_00;
	}

	param_00 = param_00 + "+scope" + var_02;
	return param_00;
}

//Function Number: 262
has_zombie_perk(param_00)
{
	if(!isdefined(self.var_13FA4))
	{
		return 0;
	}

	return scripts\common\utility::istrue(self.var_13FA4[param_00]);
}

//Function Number: 263
drawsphere(param_00,param_01,param_02,param_03)
{
	var_04 = int(param_02 * 20);
	for(var_05 = 0;var_05 < var_04;var_05++)
	{
		wait(0.05);
	}
}

//Function Number: 264
func_F29D(param_00,param_01)
{
	var_02 = self.var_B495 - self.var_5037;
	var_03 = param_01 * var_02 + self.var_5037;
	self method_80BB(param_00,var_03);
}

//Function Number: 265
func_77D4(param_00,param_01)
{
	if(param_00 + level.var_5221[param_01] > level.var_5220)
	{
		return level.var_5220;
	}

	return param_00 + level.var_5221[param_01];
}

//Function Number: 266
func_1B88(param_00)
{
	param_00 = tolower(param_00);
	if(!isdefined(level.var_1B86))
	{
		return 0;
	}

	if(!isdefined(level.var_1B86[param_00]))
	{
		return 0;
	}

	return level.var_1B86[param_00];
}

//Function Number: 267
func_61CD()
{
	self.var_1B97 = 1;
	self notify("alien_main_loop_restart");
}

//Function Number: 268
func_22B0(param_00,param_01,param_02)
{
	var_03 = [];
	foreach(var_07, var_05 in param_00)
	{
		if(var_07 == param_01)
		{
			continue;
		}

		if(scripts\common\utility::istrue(param_02))
		{
			var_06 = var_07;
		}
		else
		{
			var_06 = var_03.size;
		}

		var_03[var_06] = var_05;
	}

	return var_03;
}

//Function Number: 269
func_9C52(param_00)
{
	var_01 = (0,0,1);
	var_02 = 0.85;
	return vectordot(param_00,var_01) > var_02;
}

//Function Number: 270
func_7CC7(param_00)
{
	if(!isdefined(self.var_1138B))
	{
		return [];
	}

	if(!isdefined(self.var_1138B.var_1138C))
	{
		return [];
	}

	if(!self.var_1138B.var_12AE4)
	{
		return self.var_1138B.var_1138C;
	}

	var_01 = scripts\cp\_agent_utils::func_77D7(param_00);
	if(!isdefined(self.var_1138B.var_1138C[var_01]))
	{
		var_02 = "Synch attack on " + self.var_1138B.var_92BB + " doesn\'t handle type: " + var_01;
	}

	return self.var_1138B.var_1138C[var_01];
}

//Function Number: 271
func_80BC(param_00)
{
	var_01 = 0;
	foreach(var_03 in param_00)
	{
		var_01 = var_01 + var_03;
	}

	var_05 = randomintrange(0,var_01);
	var_01 = 0;
	foreach(var_07, var_03 in param_00)
	{
		var_01 = var_01 + var_03;
		if(var_05 <= var_01)
		{
			return var_07;
		}
	}

	return 0;
}

//Function Number: 272
func_78BC()
{
	var_00 = 1073741824;
	var_01 = undefined;
	foreach(var_03 in level.players)
	{
		var_04 = distancesquared(self.origin,var_03.origin);
		if(func_9F19(var_03) && var_04 < var_00)
		{
			var_01 = var_03;
			var_00 = var_04;
		}
	}

	return var_01;
}

//Function Number: 273
func_7833(param_00,param_01)
{
	var_02 = [];
	foreach(var_04 in level.players)
	{
		if(var_04 is_valid_player())
		{
			var_02[var_02.size] = var_04;
		}
	}

	if(!isdefined(param_00) || !param_00)
	{
		return var_02;
	}

	return scripts\common\utility::func_782F(param_01,var_02);
}

//Function Number: 274
is_valid_player(param_00)
{
	if(!isplayer(self))
	{
		return 0;
	}

	if(!isdefined(self))
	{
		return 0;
	}

	if(!isdefined(param_00) && scripts\cp\_laststand::player_in_laststand(self))
	{
		return 0;
	}

	if(!isalive(self))
	{
		return 0;
	}

	if(self.sessionstate == "spectator")
	{
		return 0;
	}

	return 1;
}

//Function Number: 275
func_203D(param_00,param_01)
{
	foreach(var_03 in level.players)
	{
		if(distancesquared(var_03.origin,param_00) < param_01)
		{
			return 1;
		}
	}

	return 0;
}

//Function Number: 276
timeoutvofunction_pain(param_00,param_01)
{
	wait(param_01);
	level notify(param_00 + "_timed_out");
}

//Function Number: 277
func_D222(param_00)
{
	self endon("disconnect");
	level endon("pain_vo_timed_out");
	level thread timeoutvofunction_pain("pain_vo",3.5);
	var_01 = 5500;
	var_02 = gettime();
	if(!isdefined(self.var_BF4F))
	{
		self.var_BF4F = var_02 + randomintrange(var_01,var_01 + 2000);
	}
	else if(var_02 < self.var_BF4F)
	{
		return;
	}

	while(scripts\cp\_music_and_dialog::func_134DF())
	{
		wait(0.1);
	}

	if(isdefined(self.var_134FD))
	{
		if(soundexists(self.var_134FD + "plr_pain"))
		{
			self playlocalsound(self.var_134FD + "plr_pain");
		}
		else if(soundexists(self.var_134FD + "pain"))
		{
			self playlocalsound(self.var_134FD + "pain");
		}
	}

	var_03 = "injured_pain_vocal";
	if(isdefined(param_00))
	{
		if(isdefined(param_00.agent_type))
		{
			switch(param_00.agent_type)
			{
				case "crab_mini":
					var_03 = "injured_pain_crabgoon";
					break;

				case "crab_brute":
					var_03 = "injured_pain_radactivecrab";
					break;

				case "crab_boss":
					var_03 = "injured_pain_radboss";
					break;

				case "skater":
					var_03 = "injured_pain_skater";
					break;

				case "ratking":
					var_03 = scripts\common\utility::random(["injured_pain_ratking1","injured_pain_ratking2","injured_pain_ratking3"]);
					break;

				case "zombie_clown":
					var_03 = "injured_pain_clown";
					break;

				case "alien_rhino":
					var_03 = scripts\common\utility::random(["injured_pain_rhino1","injured_pain_rhino2","injured_pain_rhino3"]);
					break;

				case "alien_phantom":
				case "alien_goon":
					var_03 = "injured_pain_crytpid";
					break;

				default:
					var_03 = "injured_pain_vocal";
					break;
			}
		}
	}

	if(self.var_134FD == "p6_" && var_03 == "injured_pain_clown")
	{
		scripts\cp\_vo::try_to_play_vo(var_03,"zmb_comment_vo");
	}
	else
	{
		scripts\cp\_vo::try_to_play_vo(var_03,"zmb_comment_vo");
	}

	self.var_BF4F = var_02 + randomintrange(var_01,var_01 + 1500);
}

//Function Number: 278
func_D220()
{
	level endon("game_ended");
	self endon("disconnect");
	if(func_9C82(self))
	{
		return;
	}

	if(func_152E(self))
	{
		return;
	}

	func_F427(self,1);
	var_00 = func_7B64(self);
	if(isdefined(var_00))
	{
		if(soundexists(var_00))
		{
			while(!func_152E(self) && !level.var_7669)
			{
				if(!scripts\common\utility::istrue(self.var_13518))
				{
					self playlocalsound(var_00);
				}

				wait(1.5);
			}
		}

		func_F427(self,0);
	}
}

//Function Number: 279
func_9C82(param_00)
{
	return scripts\common\utility::istrue(param_00.var_9C82);
}

//Function Number: 280
func_152E(param_00)
{
	var_01 = 0.3;
	return param_00.health / param_00.maxhealth > var_01;
}

//Function Number: 281
func_F427(param_00,param_01)
{
	param_00.var_9C82 = param_01;
}

//Function Number: 282
func_7B64(param_00)
{
	if(!level.var_7669)
	{
		if(param_00.var_134FD == "p1_")
		{
			return "p1_plr_pain";
		}

		if(param_00.var_134FD == "p2_")
		{
			return "p2_plr_pain";
		}

		if(param_00.var_134FD == "p3_")
		{
			return "p3_plr_pain";
		}

		if(param_00.var_134FD == "p4_")
		{
			return "p4_plr_pain";
		}

		if(param_00.var_134FD == "p5_")
		{
			return "p5_plr_pain";
		}

		if(param_00.var_134FD == "p6_")
		{
			return "p5_plr_pain";
		}

		return "p3_plr_pain";
	}
}

//Function Number: 283
func_D64B(param_00,param_01,param_02,param_03,param_04,param_05,param_06,param_07)
{
	var_08 = param_00 - param_01;
	var_09 = vectordot(var_08,param_02);
	var_0A = vectordot(var_08,param_03);
	if(var_09 > param_04)
	{
		return 0;
	}

	if(var_09 < param_05)
	{
		return 0;
	}

	if(isdefined(param_07))
	{
		if(abs(var_0A) > param_07)
		{
			return 0;
		}
	}

	if(scripts\common\utility::func_1E7C(param_02,var_08) > param_06)
	{
		return 0;
	}

	return 1;
}

//Function Number: 284
func_D5B4(param_00)
{
	var_01 = param_00.var_134FD + "good_loot";
	if(scripts\cp\_vo::func_1B47(param_00,var_01))
	{
		param_00 playlocalsound(scripts\cp\_vo::func_77ED(param_00,var_01));
		return;
	}

	if(soundexists(var_01))
	{
		param_00 playlocalsound(var_01);
	}
}

//Function Number: 285
func_5213(param_00)
{
	var_01 = "";
	if(isdefined(param_00) && isdefined(param_00.var_2F33) && isdefined(level.var_2F30[param_00.var_2F33].var_68B9))
	{
		var_01 = level.var_2F30[param_00.var_2F33].var_68B9;
	}

	thread setlowermessage("deployable_use",var_01,3);
}

//Function Number: 286
func_9BF3(param_00)
{
	switch(param_00)
	{
		case "goon4":
		case "goon3":
		case "goon2":
		case "goon":
			return 1;

		default:
			return 0;
	}
}

//Function Number: 287
func_B35E(param_00,param_01,param_02)
{
	function_0139(param_00,param_01,1);
	wait(param_02);
	function_0139(param_00,param_01,0);
}

//Function Number: 288
func_8CC6(param_00)
{
	level.var_8CC1 = param_00;
}

//Function Number: 289
func_1B70()
{
	level.var_1B71 = [];
	level.var_1B71[1] = 0.9;
	level.var_1B71[2] = 1;
	level.var_1B71[3] = 1.3;
	level.var_1B71[4] = 1.8;
}

//Function Number: 290
func_D3A5()
{
	self endon("death");
	self endon("disconnect");
	self endon("joined_team");
	self endon("joined_spectators");
	self endon("faux_spawn");
	level endon("game_ended");
	for(;;)
	{
		scripts\common\utility::waittill_any_3("damage","health_perk_upgrade");
		if(!func_38FF())
		{
			continue;
		}

		var_00 = scripts\cp\_laststand::func_7EF4();
		var_01 = self.health / var_00;
		if(var_01 >= 1)
		{
			self.health = var_00;
			continue;
		}

		thread func_8CBF(gettime(),var_01);
		thread func_2FC6(gettime(),var_01);
	}
}

//Function Number: 291
func_8CBF(param_00,param_01)
{
	self notify("healthRegeneration");
	self endon("healthRegeneration");
	self endon("death");
	self endon("disconnect");
	self endon("joined_team");
	self endon("joined_spectators");
	level endon("game_ended");
	while(isdefined(self.var_F1E8) && self.var_F1E8)
	{
		wait(0.2);
	}

	if(func_9E2A())
	{
		return;
	}

	var_02 = spawnstruct();
	func_80E3(var_02);
	scripts\common\utility::waittill_any_timeout_1(var_02.var_1615,"force_regeneration");
	for(;;)
	{
		var_03 = scripts\cp\_laststand::func_7EF4();
		var_02 = spawnstruct();
		func_80E3(var_02);
		if(!lib_0CFD::func_8B7E())
		{
			param_01 = self.health / self.maxhealth;
			if(self.health < int(var_03))
			{
				if(param_01 + var_02.var_DE87 > int(1))
				{
					self.health = int(var_03);
				}
				else
				{
					self.health = int(self.maxhealth * param_01 + var_02.var_DE87);
				}
			}
			else
			{
				break;
			}
		}

		scripts\common\utility::waittill_any_timeout_1(var_02.var_13846,"force_regeneration");
	}

	self notify("healed");
	scripts\cp\_globallogic::func_D0FC();
	func_E247();
}

//Function Number: 292
func_2FC6(param_00,param_01)
{
	self notify("breathingManager");
	self endon("breathingManager");
	self endon("death");
	self endon("disconnect");
	self endon("joined_team");
	self endon("joined_spectators");
	level endon("game_ended");
	if(func_9FC6())
	{
		return;
	}

	if(!isplayer(self))
	{
		return;
	}

	self.var_2FC7 = param_00 + 6000 * self.var_DE8E;
	wait(6 * self.var_DE8E);
	if(!level.var_7669)
	{
		if(self.var_134FD == "p1_")
		{
			if(!scripts\common\utility::istrue(self.var_13518))
			{
				self playlocalsound("p1_breathing_better");
				return;
			}

			return;
		}

		if(self.var_134FD == "p2_")
		{
			if(!scripts\common\utility::istrue(self.var_13518))
			{
				self playlocalsound("p2_breathing_better");
				return;
			}

			return;
		}

		if(self.var_134FD == "p3_")
		{
			if(!scripts\common\utility::istrue(self.var_13518))
			{
				self playlocalsound("p3_breathing_better");
				return;
			}

			return;
		}

		if(self.var_134FD == "p4_")
		{
			if(!scripts\common\utility::istrue(self.var_13518))
			{
				self playlocalsound("p4_breathing_better");
				return;
			}

			return;
		}

		if(self.var_134FD == "p5_")
		{
			if(!scripts\common\utility::istrue(self.var_13518))
			{
				self playlocalsound("p5_breathing_better");
				return;
			}

			return;
		}

		if(self.var_134FD == "p6_")
		{
			if(!scripts\common\utility::istrue(self.var_13518))
			{
				self playlocalsound("p5_breathing_better");
				return;
			}

			return;
		}

		if(!scripts\common\utility::istrue(self.var_13518))
		{
			self playlocalsound("p3_breathing_better");
			return;
		}

		return;
	}
}

//Function Number: 293
func_80E3(param_00)
{
	level.var_AFE9 = 5000;
	level.var_8CBC = 0.2;
	level.var_9B33 = 0.35;
	level.var_9B31 = 0.5;
	level.var_9B32 = 0.3;
	level.var_D3A4 = 2400;
	level.var_13DCE = 0.1;
	self.var_D884 = lib_0CFF::func_D87D();
	if(self.var_D884 == 1)
	{
		if(func_9BA0("faster_health_regen_upgrade") || isdefined(level.purify_active) && level.purify_active >= 1)
		{
			param_00.var_1615 = 0.45;
			param_00.var_13846 = 0.045;
			param_00.var_DE87 = 0.1;
			return;
		}

		if(self.health <= 45)
		{
			param_00.var_1615 = 5;
			param_00.var_13846 = 0.05;
			param_00.var_DE87 = 0.1;
			return;
		}

		param_00.var_1615 = 2.4;
		param_00.var_13846 = 0.1;
		param_00.var_DE87 = 0.1;
		return;
	}

	param_00.var_1615 = 2.4 * self.var_D884;
	param_00.var_13846 = 0.1 * self.var_D884;
	param_00.var_DE87 = 0.1;
}

//Function Number: 294
func_E247(param_00)
{
	self endon("disconnect");
	self endon("death");
	level endon("game_ended");
	wait(1.75);
	func_E248();
}

//Function Number: 295
func_E248()
{
	self.var_2507 = [];
	self.var_24E5 = [];
}

//Function Number: 296
func_38FF()
{
	if(scripts\cp\_laststand::player_in_laststand(self))
	{
		return 0;
	}

	return 1;
}

//Function Number: 297
func_D3E1()
{
	level endon("game_ended");
	self endon("death");
	self endon("disconnect");
	self endon("joined_team");
	self endon("joined_spectators");
	wait(2);
	for(;;)
	{
		wait(0.2);
		if(func_10050())
		{
			if(self.var_134FD == "p1_")
			{
				if(soundexists("Fem_breathing_hurt"))
				{
					self playlocalsound("Fem_breathing_hurt");
				}
			}
			else
			{
				self playlocalsound("breathing_hurt");
			}

			wait(0.784);
			wait(0.1 + randomfloat(0.8));
		}
	}
}

//Function Number: 298
func_10050()
{
	if(func_9E2A() || func_9FC6() || isdefined(self.var_2FC7) && gettime() < self.var_2FC7 || self.health > self.maxhealth * 0.55 || level.var_7669)
	{
		return 0;
	}

	return 1;
}

//Function Number: 299
func_9E2A()
{
	return (isdefined(level.var_8CC1) && level.var_8CC1) || isdefined(self.var_8CC1) && self.var_8CC1;
}

//Function Number: 300
func_D364()
{
	self endon("death");
	self endon("disconnect");
	self endon("joined_team");
	self endon("joined_spectators");
	self endon("faux_spawn");
	self endon("game_ended");
	if(!isdefined(self.var_2C11))
	{
		self.var_2C11 = 0;
	}

	self setplayerdata("cp","alienSession","armor",0);
	var_00 = 0;
	for(;;)
	{
		scripts\common\utility::waittill_any_3("player_damaged","enable_armor");
		if(!isdefined(self.var_2C11))
		{
			if(var_00 > 0)
			{
				self setplayerdata("cp","alienSession","armor",0);
				var_00 = 0;
			}

			continue;
		}

		if(var_00 != self.var_2C11)
		{
			var_01 = int(self.var_2C11);
			self setplayerdata("cp","alienSession","armor",var_01);
			var_00 = self.var_2C11;
		}
	}
}

//Function Number: 301
func_1C63(param_00)
{
	if(param_00)
	{
		if(!isdefined(self.var_55DF))
		{
			self.var_55DF = 0;
		}

		self.var_55DF--;
		if(!self.var_55DF)
		{
			self method_8438();
			return;
		}

		return;
	}

	if(!isdefined(self.var_55DF))
	{
		self.var_55DF = 0;
	}

	self.var_55DF++;
	self method_8437();
}

//Function Number: 302
func_DED0()
{
	self endon("death");
	self endon("stop_phys_sounds");
	for(;;)
	{
		self waittill("collision",var_00,var_01,var_02,var_03,var_04,var_05,var_06,var_07);
		level notify("physSnd",self,var_00,var_01,var_02,var_03,var_04,var_05,var_06,var_07);
	}
}

//Function Number: 303
func_83DA()
{
	level notify("physics_monitor");
	level endon("physics_monitor");
	for(;;)
	{
		level waittill("physSnd",var_00,var_01,var_02,var_03,var_04,var_05,var_06,var_07,var_08);
		if(isdefined(var_00) && isdefined(var_00.var_CAF8))
		{
			level thread [[ var_00.var_CAF8 ]](var_00,var_01,var_02,var_03,var_04,var_05,var_06,var_07,var_08);
		}
	}
}

//Function Number: 304
func_DECF(param_00,param_01)
{
	param_00.var_CAF8 = param_01;
}

//Function Number: 305
func_1861()
{
	if(!scripts\common\utility::func_2286(level.var_CC0C,self))
	{
		level.var_CC0C = scripts\common\utility::array_add_safe(level.var_CC0C,self);
	}

	level.var_CC0C = scripts\common\utility::func_22BC(level.var_CC0C);
}

//Function Number: 306
func_E11E()
{
	if(scripts\common\utility::func_2286(level.var_CC0C,self))
	{
		level.var_CC0C = scripts\common\utility::func_22A9(level.var_CC0C,self);
	}

	level.var_CC0C = scripts\common\utility::func_22BC(level.var_CC0C);
}

//Function Number: 307
func_65F0(param_00)
{
	var_01 = 16384;
	if(level.var_12A83.size)
	{
		var_02 = sortbydistance(level.var_12A83,param_00.origin);
		if(distance2dsquared(var_02[0].origin,param_00.origin) < var_01)
		{
			return 1;
		}
	}

	if(isdefined(level.var_CC0C) && level.var_CC0C.size)
	{
		foreach(var_04 in level.var_CC0C)
		{
			if(!isdefined(var_04))
			{
				continue;
			}

			if(distance2dsquared(var_04.origin,param_00.origin) < var_01)
			{
				return 1;
			}
		}
	}

	if(isdefined(level.near_equipment_func))
	{
		return [[ level.near_equipment_func ]](param_00);
	}

	return 0;
}

//Function Number: 308
func_F313(param_00,param_01,param_02)
{
	if(isdefined(param_02.var_4B5C))
	{
		param_02.var_4B5C = undefined;
	}

	param_02.var_4B5C = spawnstruct();
	param_02.var_4B5C.var_195 = param_00;
	param_02.var_4B5C.var_E2C3 = param_01;
}

//Function Number: 309
func_DFE0(param_00)
{
	param_00 setclientomnvar("zom_crafted_weapon",0);
	param_00.var_4B5C = undefined;
}

//Function Number: 310
is_escape_gametype()
{
	return level.gametype == "escape";
}

//Function Number: 311
func_A021(param_00)
{
	self endon("death");
	level endon("game_ended");
	self notify(param_00);
	self endon(param_00);
	self.var_222 waittill("disconnect");
	foreach(var_02 in level.players)
	{
		if(var_02 is_valid_player(1))
		{
			self.var_222 = var_02;
			if(self.classname != "script_model")
			{
				self method_8336(self.var_222);
			}

			break;
		}
	}

	thread func_A021(param_00);
}

//Function Number: 312
func_E2CC()
{
	if(isdefined(self.var_E2DF))
	{
		func_8387(self.var_E2DF);
		self.var_E2DF = undefined;
	}
}

//Function Number: 313
func_1365D()
{
	self endon("death");
	self endon("disconnect");
	level endon("game_ended");
	wait(0.05);
	func_E2CC();
}

//Function Number: 314
func_E077()
{
	if(_hasperk("specialty_explosivebullets"))
	{
		self.var_E2DF = "specialty_explosivebullets";
		func_1430("specialty_explosivebullets");
	}
}

//Function Number: 315
func_A030(param_00,param_01,param_02)
{
	self endon("death");
	level endon("game_ended");
	if(!isdefined(self.var_AC71))
	{
		self.var_AC71 = param_01;
	}

	if(isdefined(param_00))
	{
		self.var_AC71 = param_00;
	}

	while(self.var_AC71)
	{
		wait(1);
		scripts\cp\_hostmigration::func_13834();
		if(!isdefined(self.var_3A9D))
		{
			self.var_AC71 = max(0,self.var_AC71 - 1);
		}
	}

	while(isdefined(self) && isdefined(self.var_9B05))
	{
		wait(0.05);
	}

	if(isdefined(self.var_13E61))
	{
		self.var_13E61 delete();
	}

	if(isdefined(param_02))
	{
		self notify(param_02);
		return;
	}

	self notify("death");
}

//Function Number: 316
func_A025(param_00)
{
	self endon("placed");
	self endon("death");
	param_00 endon("disconnect");
	var_01 = param_00 scripts\common\utility::func_13734("death","last_stand");
	param_00 notify("force_cancel_placement");
}

//Function Number: 317
func_A026(param_00)
{
	self endon("placed");
	self endon("death");
	param_00 endon("last_stand");
	param_00 waittill("disconnect");
	if(isdefined(self.var_3A9E))
	{
		self.var_3A9E delete();
	}
	else if(isdefined(self.var_3AA1))
	{
		self.var_3AA1 delete();
	}
	else if(isdefined(self.var_3A9B))
	{
		self.var_3A9B delete();
	}
	else if(isdefined(self.var_3A9C))
	{
		self.var_3A9C delete();
	}
	else if(isdefined(self.var_3A9A))
	{
		self.var_3A9A delete();
	}
	else if(isdefined(self.var_3AA4))
	{
		self.var_3AA4 delete();
	}

	self delete();
}

//Function Number: 318
func_A027(param_00)
{
	self endon("placed");
	self endon("death");
	param_00 endon("last_stand");
	level waittill("game_ended");
	self delete();
}

//Function Number: 319
func_FF18(param_00,param_01,param_02)
{
	if(!isdefined(param_00))
	{
		return 0;
	}

	if(!isalive(param_00))
	{
		return 0;
	}

	if(!isagent(param_00))
	{
		return 0;
	}

	if(!isdefined(param_00.agent_type))
	{
		return 0;
	}

	if(!isdefined(param_00.var_9D25) || !param_00.var_9D25)
	{
		return 0;
	}

	if(!isdefined(param_01) && isdefined(param_00.entered_playspace) && !param_00.entered_playspace)
	{
		return 0;
	}

	if(scripts\common\utility::istrue(param_00.var_B36E))
	{
		return 0;
	}

	if(!isdefined(param_00.team))
	{
		return 0;
	}

	if(param_00.agent_type == "zombie_brute" || param_00.agent_type == "zombie_ghost" || param_00.agent_type == "zombie_grey")
	{
		return 0;
	}

	if(param_00.agent_type == "alien_phantom" || param_00.agent_type == "alien_rhino")
	{
		return 0;
	}

	if(!scripts\common\utility::istrue(param_02) && scripts\common\utility::istrue(param_00.var_9CDD))
	{
		return 0;
	}

	if(scripts\common\utility::istrue(param_00.is_coaster_zombie))
	{
		return 0;
	}

	return 1;
}

//Function Number: 320
set_quest_icon(param_00)
{
	func_93F5();
	func_F560(param_00);
}

//Function Number: 321
func_F560(param_00)
{
	setomnvarbit("zombie_quest_piece",param_00,1);
	setclientmatchdata("questPieces","quest_piece_" + param_00,1);
}

//Function Number: 322
unset_zm_quest_icon(param_00)
{
	unset_quest_icon_internal(param_00);
}

//Function Number: 323
unset_quest_icon_internal(param_00)
{
	setomnvarbit("zombie_quest_piece",param_00,0);
}

//Function Number: 324
set_completed_quest_mark(param_00)
{
	setomnvarbit("zm_completed_quest_marks",param_00,1);
}

//Function Number: 325
func_93F5()
{
	if(!isdefined(level.num_of_quest_pieces_completed))
	{
		level.num_of_quest_pieces_completed = 0;
	}

	level.num_of_quest_pieces_completed++;
	if(level.script == "cp_zmb")
	{
		if(level.num_of_quest_pieces_completed == level.var_477B)
		{
			foreach(var_01 in level.players)
			{
				var_01 lib_0D2A::func_12D7C("STICKER_COLLECTOR",24);
			}
		}
	}
}

//Function Number: 326
func_D4FB(param_00,param_01,param_02)
{
	param_00 playlocalsound(param_01);
	param_00 playsoundtoteam(param_02,"allies",param_00);
	param_00 playsoundtoteam(param_02,"axis",param_00);
}

//Function Number: 327
func_E76A(param_00)
{
	if(param_00 - int(param_00) >= 0.5)
	{
		return int(param_00 + 1);
	}

	return int(param_00);
}

//Function Number: 328
func_4D0D(param_00,param_01,param_02,param_03,param_04,param_05,param_06,param_07,param_08)
{
	if(!func_FF13(param_00))
	{
		return;
	}

	param_00 endon("death");
	if(!isdefined(param_03))
	{
		param_03 = 600;
	}

	if(!isdefined(param_02))
	{
		param_02 = 5;
	}

	if(!isdefined(param_04))
	{
		param_04 = "MOD_UNKNOWN";
	}

	if(!isdefined(param_05))
	{
		param_05 = "iw7_dot_zm";
	}

	if(isdefined(param_07))
	{
		param_00 func_F831(param_00,param_07,1);
		if(isdefined(level.scriptablestatefunc))
		{
			param_00 thread [[ level.scriptablestatefunc ]](param_00);
		}
	}

	var_09 = 0;
	var_0A = 6;
	var_0B = param_02 / var_0A;
	var_0C = param_03 / var_0A;
	for(var_0D = 0;var_0D < var_0A;var_0D++)
	{
		wait(var_0B);
		if(isalive(param_00))
		{
			param_00.var_6E82 = gettime() + 500;
			if(param_00.health - var_0C <= 0)
			{
				if(isdefined(param_08))
				{
					level notify(param_08);
				}
			}

			if(isdefined(param_01))
			{
				param_00 dodamage(var_0C,param_00.origin,param_01,param_01,param_04,param_05);
				continue;
			}

			param_00 dodamage(var_0C,param_00.origin,undefined,undefined,param_04,param_05);
		}
	}

	if(isdefined(param_07))
	{
		param_00 func_F831(param_00,param_07);
	}

	if(scripts\common\utility::istrue(param_00.var_B36E))
	{
		param_00.var_B36E = undefined;
	}

	if(scripts\common\utility::istrue(param_00.var_6E82))
	{
		param_00.var_6E82 = undefined;
	}
}

//Function Number: 329
func_F831(param_00,param_01,param_02)
{
	switch(param_01)
	{
		case "combinedArcane":
		case "combinedarcane":
			if(scripts\common\utility::istrue(param_02))
			{
				param_00.var_9B51 = 1;
			}
			else
			{
				param_00.var_9B51 = undefined;
			}
			break;

		case "burning":
			if(scripts\common\utility::istrue(param_02))
			{
				param_00.var_9B81 = param_02;
			}
			else
			{
				param_00.var_9B81 = undefined;
			}
			break;

		case "electrified":
			if(scripts\common\utility::istrue(param_02))
			{
				param_00.var_9BC9 = param_02;
				param_00.allowpain = 1;
				param_00.var_11190 = gettime() + 3000;
			}
			else
			{
				param_00.var_9BC9 = undefined;
				param_00.allowpain = 0;
			}
			break;

		case "shocked":
			if(scripts\common\utility::istrue(param_02))
			{
				param_00.var_11196 = param_02;
			}
			else
			{
				param_00.var_11196 = undefined;
			}
			break;

		case "chemBurn":
		case "chemburn":
			if(scripts\common\utility::istrue(param_02))
			{
				param_00.var_9B8A = 1;
			}
			else
			{
				param_00.var_9B8A = undefined;
			}
			break;

		default:
			break;
	}
}

//Function Number: 330
func_FF13(param_00)
{
	if(isdefined(param_00.agent_type) && param_00.agent_type == "c6" || param_00.agent_type == "zombie_brute" || param_00.agent_type == "zombie_grey" || param_00.agent_type == "zombie_ghost")
	{
		return 0;
	}

	return 1;
}

//Function Number: 331
func_12E3F(param_00,param_01,param_02,param_03,param_04)
{
	self endon("death");
	self endon("force_cancel_placement");
	self endon("disconnect");
	level endon("game_ended");
	var_05 = param_02.var_3AA7;
	var_06 = param_02.var_3AA6;
	var_07 = param_02.var_CC25;
	var_08 = param_02.var_CC22;
	var_09 = param_02.var_B924;
	var_0A = param_02.var_B925;
	var_0B = param_02.var_CC0A;
	var_0C = param_02.var_CC28;
	var_0D = param_02.var_38E3;
	param_00 endon("placed");
	param_00 endon("death");
	param_00.var_3872 = 1;
	var_0E = -1;
	for(;;)
	{
		var_0F = self canplayerplacesentry(1,var_07);
		param_00.origin = var_0F["origin"];
		param_00.angles = var_0F["angles"];
		param_01.origin = param_00.origin + var_05;
		param_01.angles = param_00.angles + var_06;
		if(isdefined(self.onslide))
		{
			param_00.var_3872 = 0;
		}
		else
		{
			param_00.var_3872 = self isonground() && var_0F["result"] && abs(param_00.origin[2] - self.origin[2]) < var_08;
		}

		if(func_65F0(param_00))
		{
			param_00.var_3872 = 0;
		}

		if(isdefined(param_03) && isdefined(level.var_563D) && isdefined(level.var_4D7C))
		{
			if(param_00 istouching(level.var_4D7C))
			{
				param_00.var_3872 = 0;
			}
		}

		if(isdefined(var_0F["entity"]))
		{
			param_00.var_BD3B = var_0F["entity"];
		}
		else
		{
			param_00.var_BD3B = undefined;
		}

		if(param_00.var_3872 != var_0E)
		{
			if(param_00.var_3872)
			{
				if(!isdefined(param_04))
				{
					param_01 setmodel(var_09);
				}

				if(isdefined(param_00.var_6DEC))
				{
					self method_80F4(var_0B);
				}
				else
				{
					self method_80F4(var_0C);
				}
			}
			else
			{
				if(!isdefined(param_04))
				{
					param_01 setmodel(var_0A);
				}

				self method_80F4(var_0D);
			}
		}

		var_0E = param_00.var_3872;
		wait(0.05);
	}
}

//Function Number: 332
func_1308C(param_00,param_01)
{
	if(param_00 cangiveandfireoffhand(param_00 getvalidtakeweapon()) && !param_00 isgestureplaying())
	{
		param_00 setweaponammostock(param_01,1);
		param_00 giveandfireoffhand(param_01);
	}
}

//Function Number: 333
is_codxp()
{
	return getdvar("scr_codxp","") != "";
}

//Function Number: 334
too_close_to_other_interactions(param_00)
{
	var_01 = sortbydistance(level.current_interaction_structs,param_00);
	if(distancesquared(var_01[0].origin,param_00) < 9216)
	{
		return 1;
	}

	return 0;
}

//Function Number: 335
getweapontoswitchbackto()
{
	if(isdefined(self.var_A92C))
	{
		var_00 = self.var_A92C;
	}
	else
	{
		var_00 = self getcurrentweapon();
	}

	var_01 = 0;
	var_02 = level.additional_laststand_weapon_exclusion;
	if(var_00 == "none")
	{
		var_01 = 1;
	}
	else if(scripts\common\utility::func_2286(var_02,var_00))
	{
		var_01 = 1;
	}
	else if(scripts\common\utility::func_2286(var_02,getweaponbasename(var_00)))
	{
		var_01 = 1;
	}
	else if(func_9C42(var_00,1) || isdefined(level.primary_melee_weapons) && scripts\common\utility::func_2286(level.primary_melee_weapons,var_00))
	{
		var_01 = 1;
	}

	if(var_01)
	{
		var_03 = self getweaponslistall();
		for(var_04 = 0;var_04 < var_03.size;var_04++)
		{
			if(var_03[var_04] == "none")
			{
				continue;
			}
			else if(scripts\common\utility::func_2286(var_02,var_03[var_04]))
			{
				continue;
			}
			else if(scripts\common\utility::func_2286(var_02,getweaponbasename(var_03[var_04])))
			{
				continue;
			}
			else if(func_9C42(var_03[var_04],1) || isdefined(level.primary_melee_weapons) && scripts\common\utility::func_2286(level.primary_melee_weapons,var_03[var_04]))
			{
				continue;
			}
			else if(!scripts\cp\_weapon::func_9F0E(var_03[var_04]))
			{
				continue;
			}
			else
			{
				var_01 = 0;
				var_00 = var_03[var_04];
				break;
			}
		}
	}

	if(var_01)
	{
		var_00 = "iw7_fists_zm";
		if(!self hasweapon(var_00))
		{
			func_12C6(var_00,undefined,undefined,1);
		}
	}

	return var_00;
}

//Function Number: 336
getvalidtakeweapon(param_00)
{
	var_01 = self getcurrentweapon();
	var_02 = 0;
	var_03 = level.additional_laststand_weapon_exclusion;
	if(isdefined(param_00))
	{
		var_03 = scripts\common\utility::array_combine(param_00,var_03);
	}

	if(var_01 == "none")
	{
		var_02 = 1;
	}
	else if(scripts\common\utility::func_2286(var_03,var_01))
	{
		var_02 = 1;
	}
	else if(scripts\common\utility::func_2286(var_03,getweaponbasename(var_01)))
	{
		var_02 = 1;
	}
	else if(func_9C42(var_01,1))
	{
		var_02 = 1;
	}

	if(isdefined(self.last_valid_weapon) && self hasweapon(self.last_valid_weapon) && var_02)
	{
		var_01 = self.last_valid_weapon;
		if(var_01 == "none")
		{
			var_02 = 1;
		}
		else if(scripts\common\utility::func_2286(var_03,var_01))
		{
			var_02 = 1;
		}
		else if(scripts\common\utility::func_2286(var_03,getweaponbasename(var_01)))
		{
			var_02 = 1;
		}
		else if(func_9C42(var_01,1))
		{
			var_02 = 1;
		}
		else
		{
			var_02 = 0;
		}
	}

	if(var_02)
	{
		var_04 = self getweaponslistall();
		for(var_05 = 0;var_05 < var_04.size;var_05++)
		{
			if(var_04[var_05] == "none")
			{
				continue;
			}
			else if(scripts\common\utility::func_2286(var_03,var_04[var_05]))
			{
				continue;
			}
			else if(scripts\common\utility::func_2286(var_03,getweaponbasename(var_04[var_05])))
			{
				continue;
			}
			else if(func_9C42(var_04[var_05],1))
			{
				continue;
			}
			else
			{
				var_02 = 0;
				var_01 = var_04[var_05];
				break;
			}
		}
	}

	return var_01;
}

//Function Number: 337
getcurrentcamoname(param_00)
{
	var_01 = function_00E5(param_00);
	if(!isdefined(var_01))
	{
		return undefined;
	}

	switch(var_01)
	{
		case "camo0":
			return "camo00";

		case "camo1":
			return "camo01";

		case "camo2":
			return "camo02";

		case "camo3":
			return "camo03";

		case "camo4":
			return "camo04";

		case "camo5":
			return "camo05";

		case "camo6":
			return "camo06";

		case "camo7":
			return "camo07";

		case "camo8":
			return "camo08";

		case "camo9":
			return "camo09";

		default:
			return var_01;
	}

	return undefined;
}

//Function Number: 338
add_to_notify_queue(param_00,param_01,param_02,param_03,param_04,param_05,param_06,param_07,param_08)
{
	if(!isdefined(self.notify_queue))
	{
		self.notify_queue = [];
	}

	if(!isdefined(self.notify_queue[param_00]))
	{
		self.notify_queue[param_00] = 0;
	}
	else
	{
		if(param_00 == "weapon_hit_enemy")
		{
			var_09 = gettime();
			if(isdefined(self.last_notify_time) && self.last_notify_time == var_09)
			{
				return;
			}
			else
			{
				self.last_notify_time = var_09;
			}
		}

		self.notify_queue[param_00]++;
	}

	if(self.notify_queue[param_00] > 0)
	{
		wait(0.05 * self.notify_queue[param_00]);
	}

	self notify(param_00,param_01,param_02,param_03,param_04,param_05,param_06,param_07,param_08);
	waittillframeend;
	if(isdefined(self.notify_queue[param_00]))
	{
		self.notify_queue[param_00]--;
		if(self.notify_queue[param_00] < 1)
		{
			self.notify_queue[param_00] = undefined;
		}
	}
}

//Function Number: 339
take_fists_weapon(param_00)
{
	foreach(var_02 in param_00 getweaponslistall())
	{
		if(issubstr(var_02,"iw7_fists"))
		{
			param_00 takeweapon(var_02);
		}
	}
}

//Function Number: 340
playlocalsound_safe(param_00)
{
	if(soundexists(param_00))
	{
		self playlocalsound(param_00);
	}
}

//Function Number: 341
stoplocalsound_safe(param_00)
{
	if(soundexists(param_00))
	{
		self stoplocalsound(param_00);
	}
}

//Function Number: 342
playsoundatpos_safe(param_00,param_01)
{
	if(soundexists(param_01))
	{
		playsoundatpos(param_00,param_01);
	}
}

//Function Number: 343
agentcantbeignored()
{
	return isdefined(self.agent_type) && isdefined(level.ignoreimmune) && scripts\common\utility::func_2286(level.ignoreimmune,self.agent_type);
}

//Function Number: 344
agentisfnfimmune()
{
	return isdefined(self.agent_type) && isdefined(level.fnfimmune) && scripts\common\utility::func_2286(level.fnfimmune,self.agent_type);
}

//Function Number: 345
agentisinstakillimmune()
{
	return isdefined(self.agent_type) && isdefined(level.instakillimmune) && scripts\common\utility::func_2286(level.instakillimmune,self.agent_type);
}

//Function Number: 346
agentisspecialzombie()
{
	return isdefined(self.agent_type) && isdefined(level.specialzombie) && scripts\common\utility::func_2286(level.specialzombie,self.agent_type);
}

//Function Number: 347
firegesturegrenade(param_00,param_01)
{
	var_02 = param_00 getcurrentweapon();
	if(cangiveandfireoffhand(var_02))
	{
		param_00 setweaponammostock(param_01,1);
		param_00 giveandfireoffhand(param_01);
	}
}

//Function Number: 348
cangiveandfireoffhand(param_00)
{
	if(!isdefined(param_00))
	{
		return 1;
	}

	if(isdefined(level.invalid_gesture_weapon))
	{
		if(isdefined(level.invalid_gesture_weapon[getweaponbasename(param_00)]))
		{
			return 0;
		}

		return 1;
	}

	return 1;
}

//Function Number: 349
play_interaction_gesture(param_00)
{
	if(!isdefined(param_00))
	{
		param_00 = "iw7_powerlever_zm";
	}

	if(getweaponbasename(self getcurrentweapon()) != "iw7_penetrationrail_mp")
	{
		thread firegesturegrenade(self,param_00);
	}
}

//Function Number: 350
deactivatebrushmodel(param_00,param_01)
{
	param_00 notsolid();
	if(scripts\common\utility::istrue(param_01))
	{
		param_00 hide();
	}
}

//Function Number: 351
func_DCD5()
{
	if(!isplayer(self))
	{
		return 0;
	}

	return level.onlinegame && !self.var_13114;
}

//Function Number: 352
func_316C(param_00,param_01,param_02,param_03,param_04,param_05,param_06,param_07,param_08,param_09)
{
	thread func_316D(param_00,param_01,param_02,param_03,param_04,param_05,param_06,param_07,param_08,param_09);
}

//Function Number: 353
func_316D(param_00,param_01,param_02,param_03,param_04,param_05,param_06,param_07,param_08,param_09)
{
	self endon("disconnect");
	level endon("game_ended");
	var_0A = "bufferedNotify_" + param_00;
	self notify(var_0A);
	self endon(var_0A);
	if(!isdefined(self.var_316B))
	{
		self.var_316B = [];
	}

	if(!isdefined(self.var_316B[param_00]))
	{
		self.var_316B[param_00] = [];
	}

	var_0B = spawnstruct();
	var_0B.var_C8E5 = param_01;
	var_0B.var_C8E6 = param_02;
	var_0B.var_C8E7 = param_03;
	var_0B.var_C8E8 = param_04;
	var_0B.var_C8E9 = param_05;
	var_0B.var_C8EA = param_06;
	var_0B.var_C8EB = param_07;
	var_0B.var_C8EC = param_08;
	var_0B.param9 = param_09;
	self.var_316B[param_00][self.var_316B[param_00].size] = var_0B;
	waittillframeend;
	while(self.var_316B[param_00].size > 0)
	{
		var_0B = self.var_316B[param_00][0];
		self notify(param_00,var_0B.var_C8E5,var_0B.var_C8E6,var_0B.var_C8E7,var_0B.var_C8E8,var_0B.var_C8E9,var_0B.var_C8EA,var_0B.var_C8EB,var_0B.var_C8EC,var_0B.param9);
		self.var_316B[param_00] = func_22B0(self.var_316B[param_00],0);
		wait(0.05);
	}
}

//Function Number: 354
debugprintline(param_00)
{
}