/*******************************************************************
 * Decompiled By: Bog
 * Decompiled File: maps\mp\killstreaks\_killstreaks.gsc
 * Game: Call of Duty: Ghosts
 * Platform: Console
 * Function Count: 77
 * Decompile Time: 1301 ms
 * Timestamp: 10/27/2023 1:32:53 AM
*******************************************************************/

//Function Number: 1
func_4632()
{
	var_00 = 1;
	for(;;)
	{
		var_01 = tablelookup(level.global_tables["killstreakTable"].path,level.global_tables["killstreakTable"].index_col,var_00,level.global_tables["killstreakTable"].ref_col);
		if(!isdefined(var_01) || var_01 == "")
		{
			break;
		}

		var_02 = tablelookup(level.global_tables["killstreakTable"].path,level.global_tables["killstreakTable"].index_col,var_00,level.global_tables["killstreakTable"].ref_col);
		var_03 = tablelookupistring(level.global_tables["killstreakTable"].path,level.global_tables["killstreakTable"].index_col,var_00,level.global_tables["killstreakTable"].earned_hint_col);
		var_04 = tablelookup(level.global_tables["killstreakTable"].path,level.global_tables["killstreakTable"].index_col,var_00,level.global_tables["killstreakTable"].earned_dialog_col);
		game["dialog"][var_02] = var_04;
		var_05 = tablelookup(level.global_tables["killstreakTable"].path,level.global_tables["killstreakTable"].index_col,var_00,level.global_tables["killstreakTable"].allies_dialog_col);
		game["dialog"]["allies_friendly_" + var_02 + "_inbound"] = "friendly_" + var_05;
		game["dialog"]["allies_enemy_" + var_02 + "_inbound"] = "enemy_" + var_05;
		var_06 = tablelookup(level.global_tables["killstreakTable"].path,level.global_tables["killstreakTable"].index_col,var_00,level.global_tables["killstreakTable"].enemy_dialog_col);
		game["dialog"]["axis_friendly_" + var_02 + "_inbound"] = "friendly_" + var_06;
		game["dialog"]["axis_enemy_" + var_02 + "_inbound"] = "enemy_" + var_06;
		var_07 = castint(tablelookup(level.global_tables["killstreakTable"].path,level.global_tables["killstreakTable"].index_col,var_00,level.global_tables["killstreakTable"].score_col));
		maps\mp\gametypes\_rank::registerscoreinfo("killstreak_" + var_02,var_07);
		var_00++;
	}
}

//Function Number: 2
func_595D()
{
	for(;;)
	{
		level waittill("connected",var_00);
		if(!isdefined(var_00.pers["killstreaks"]))
		{
			var_00.pers["killstreaks"] = [];
		}

		if(!isdefined(var_00.pers["kID"]))
		{
			var_00.pers["kID"] = 10;
		}

		var_00.lifeid = 0;
		var_00.curdefvalue = 0;
		if(isdefined(var_00.pers["deaths"]))
		{
			var_00.lifeid = var_00.pers["deaths"];
		}

		var_00 visionsetmissilecamforplayer(game["thermal_vision"]);
		var_00 thread onplayerspawned();
		var_00 thread func_537F();
		var_00.spupdatetotal = 0;
	}
}

//Function Number: 3
onplayerspawned()
{
	self endon("disconnect");
	if(maps\mp\_utility::func_47BB())
	{
	}

	for(;;)
	{
		self waittill("spawned_player");
		thread func_4B4A();
		thread func_8ADB();
		thread func_7C94();
		thread func_7C93();
		if(level.console)
		{
			thread func_7C98();
		}
		else
		{
			thread func_5B74();
			thread func_5B73();
		}

		thread func_7C92();
		if(!isdefined(self.pers["killstreaks"][0]))
		{
			func_4641();
		}

		if(!isdefined(self.earnedstreaklevel))
		{
			self.earnedstreaklevel = 0;
		}

		if(game["roundsPlayed"] > 0 && self.adrenaline == 0)
		{
			self.adrenaline = self getcommonplayerdata("killstreaksState","count");
		}

		setstreakcounttonext();
		updatestreakslots();
		if(self.streaktype == "specialist")
		{
			func_8732();
			continue;
		}

		func_3CFA();
	}
}

//Function Number: 4
func_4641()
{
	if(!isdefined(self.streaktype))
	{
	}

	if(self.streaktype == "specialist")
	{
		self setcommonplayerdata("killstreaksState","isSpecialist",1);
	}
	else
	{
		self setcommonplayerdata("killstreaksState","isSpecialist",0);
	}

	var_00 = addstruct();
	var_00.available = 0;
	var_00.streakname = undefined;
	var_00.earned = 0;
	var_00.awardxp = undefined;
	var_00.owner = undefined;
	var_00.kid = undefined;
	var_00.lifeid = undefined;
	var_00.isgimme = 1;
	var_00.isspecialist = 0;
	var_00.nextslot = undefined;
	self.pers["killstreaks"][0] = var_00;
	for(var_01 = 1;var_01 < 4;var_01++)
	{
		var_02 = addstruct();
		var_02.available = 0;
		var_02.streakname = undefined;
		var_02.earned = 1;
		var_02.awardxp = 1;
		var_02.owner = undefined;
		var_02.kid = undefined;
		var_02.lifeid = -1;
		var_02.isgimme = 0;
		var_02.isspecialist = 0;
		self.pers["killstreaks"][var_01] = var_02;
	}

	var_03 = addstruct();
	var_03.available = 0;
	var_03.streakname = "all_perks_bonus";
	var_03.earned = 1;
	var_03.awardxp = 0;
	var_03.owner = undefined;
	var_03.kid = undefined;
	var_03.lifeid = -1;
	var_03.isgimme = 0;
	var_03.isspecialist = 1;
	self.pers["killstreaks"][4] = var_03;
	for(var_01 = 0;var_01 < 4;var_01++)
	{
		self setcommonplayerdata("killstreaksState","icons",var_01,0);
		self setcommonplayerdata("killstreaksState","hasStreak",var_01,0);
	}

	self setcommonplayerdata("killstreaksState","hasStreak",0,0);
	var_04 = 1;
	foreach(var_06 in self.killstreaks)
	{
		var_07 = self.pers["killstreaks"][var_04];
		var_07.streakname = var_06;
		var_07.isspecialist = self.streaktype == "specialist";
		var_08 = var_07.streakname;
		if(self.streaktype == "specialist")
		{
			var_09 = strtok(var_07.streakname,"_");
			if(var_09[var_09.size - 1] == "ks")
			{
				var_0A = undefined;
				foreach(var_0C in var_09)
				{
					if(var_0C != "ks")
					{
						if(!isdefined(var_0A))
						{
							var_0A = var_0C;
							continue;
						}

						var_0A = var_0A + "_" + var_0C;
					}
				}

				if(maps\mp\_utility::func_4971(var_07.streakname,"_"))
				{
					var_0A = "_" + var_0A;
				}

				if(isdefined(var_0A) && maps\mp\gametypes\_class::getperkupgrade(var_0A) != "specialty_null")
				{
					var_08 = var_07.streakname + "_pro";
				}
			}
		}

		self setcommonplayerdata("killstreaksState","icons",var_04,maps\mp\_utility::func_3AFB(var_08));
		self setcommonplayerdata("killstreaksState","hasStreak",var_04,0);
		var_04++;
	}

	self setcommonplayerdata("killstreaksState","nextIndex",1);
	self setcommonplayerdata("killstreaksState","selectedIndex",-1);
	self setcommonplayerdata("killstreaksState","numAvailable",0);
	self setcommonplayerdata("killstreaksState","hasStreak",4,0);
}

//Function Number: 5
updatestreakcount()
{
	if(!isdefined(self.pers["killstreaks"]))
	{
	}

	if(self.adrenaline == self.previousadrenaline)
	{
	}

	var_00 = self.adrenaline;
	self setcommonplayerdata("killstreaksState","count",self.adrenaline);
	if(self.adrenaline >= self getcommonplayerdata("killstreaksState","countToNext"))
	{
		setstreakcounttonext();
	}
}

//Function Number: 6
func_661D()
{
	self setcommonplayerdata("killstreaksState","count",0);
	setstreakcounttonext();
}

//Function Number: 7
setstreakcounttonext()
{
	if(!isdefined(self.streaktype))
	{
		self setcommonplayerdata("killstreaksState","countToNext",0);
	}

	if(getmaxstreakcost() == 0)
	{
		self setcommonplayerdata("killstreaksState","countToNext",0);
	}

	if(self.streaktype == "specialist")
	{
		if(self.adrenaline >= getmaxstreakcost())
		{
		}
	}

	var_00 = func_3B47();
	if(!isdefined(var_00))
	{
	}

	var_01 = func_3C16(var_00);
	self setcommonplayerdata("killstreaksState","countToNext",var_01);
}

//Function Number: 8
func_3B47()
{
	if(self.adrenaline == getmaxstreakcost() && self.streaktype != "specialist")
	{
		var_00 = 0;
	}
	else
	{
		var_00 = self.adrenaline;
	}

	foreach(var_02 in self.killstreaks)
	{
		var_03 = func_3C16(var_02);
		if(var_03 > var_00)
		{
			return var_02;
		}
	}

	return undefined;
}

//Function Number: 9
getmaxstreakcost()
{
	var_00 = 0;
	foreach(var_02 in self.killstreaks)
	{
		var_03 = func_3C16(var_02);
		if(var_03 > var_00)
		{
			var_00 = var_03;
		}
	}

	return var_00;
}

//Function Number: 10
updatestreakslots()
{
	if(!isdefined(self.streaktype))
	{
	}

	if(!maps\mp\_utility::func_4945(self))
	{
	}

	var_00 = self.pers["killstreaks"];
	var_01 = 0;
	for(var_02 = 0;var_02 < 4;var_02++)
	{
		if(isdefined(var_00[var_02]) && isdefined(var_00[var_02].streakname))
		{
			self setcommonplayerdata("killstreaksState","hasStreak",var_02,var_00[var_02].available);
			if(var_00[var_02].available == 1)
			{
				var_01++;
			}

			if(isdefined(level.removekillstreakicons) && level.removekillstreakicons && !var_00[var_02].available)
			{
				self setcommonplayerdata("killstreaksState","icons",var_02,0);
			}
		}
	}

	if(self.streaktype != "specialist")
	{
		self setcommonplayerdata("killstreaksState","numAvailable",var_01);
	}

	var_03 = self.earnedstreaklevel;
	var_04 = getmaxstreakcost();
	if(self.earnedstreaklevel == var_04 && self.streaktype != "specialist")
	{
		var_03 = 0;
	}

	var_05 = 1;
	foreach(var_07 in self.killstreaks)
	{
		var_08 = func_3C16(var_07);
		if(var_08 > var_03)
		{
			var_09 = var_07;
			break;
		}

		if(self.streaktype == "specialist")
		{
			if(self.earnedstreaklevel == var_04)
			{
				break;
			}
		}

		var_05++;
	}

	self setcommonplayerdata("killstreaksState","nextIndex",var_05);
	if(isdefined(self.killstreakindexweapon) && self.streaktype != "specialist")
	{
		self setcommonplayerdata("killstreaksState","selectedIndex",self.killstreakindexweapon);
	}

	if(self.streaktype == "specialist" && var_00[0].available)
	{
		self setcommonplayerdata("killstreaksState","selectedIndex",0);
	}

	self setcommonplayerdata("killstreaksState","selectedIndex",-1);
}

//Function Number: 11
func_8ADB()
{
	self endon("disconnect");
	self endon("faux_spawn");
	self notify("waitForChangeTeam");
	self endon("waitForChangeTeam");
	for(;;)
	{
		self waittill("joined_team");
		clearkillstreaks();
	}
}

//Function Number: 12
killstreakusepressed()
{
	var_00 = self.pers["killstreaks"];
	var_01 = var_00[self.killstreakindexweapon].streakname;
	var_02 = var_00[self.killstreakindexweapon].lifeid;
	var_03 = var_00[self.killstreakindexweapon].earned;
	var_04 = var_00[self.killstreakindexweapon].awardxp;
	var_05 = var_00[self.killstreakindexweapon].kid;
	var_06 = var_00[self.killstreakindexweapon].isgimme;
	if(!maps\mp\_utility::func_8818())
	{
		return 0;
	}

	if(!self [[ level.killstreakfuncs[var_01] ]](var_02,var_01))
	{
		return 0;
	}

	thread func_86F7();
	func_87B3(var_01,var_04);
	return 1;
}

//Function Number: 13
func_87B3(param_00,param_01)
{
	if(param_01)
	{
		self thread [[ level.onxpevent ]]("killstreak_" + param_00);
		thread maps\mp\gametypes\_missions::func_87BA(param_00);
	}

	var_02 = maps\mp\_awards::getkillstreakawardref(param_00);
	if(isdefined(var_02))
	{
		thread maps\mp\_utility::func_447B(var_02,1);
	}

	if(maps\mp\_utility::isassaultkillstreak(param_00))
	{
		thread maps\mp\_utility::func_447B("assaultkillstreaksused",1);
	}
	else if(maps\mp\_utility::issupportkillstreak(param_00))
	{
		thread maps\mp\_utility::func_447B("supportkillstreaksused",1);
	}
	else if(maps\mp\_utility::func_496B(param_00))
	{
		thread maps\mp\_utility::func_447B("specialistkillstreaksearned",1);
	}

	var_03 = self.team;
	if(level.teambased)
	{
		thread maps\mp\_utility::func_4D30(var_03 + "_friendly_" + param_00 + "_inbound",var_03);
		if(maps\mp\_utility::func_3AF8(param_00))
		{
			if(playenemydialog(param_00))
			{
				thread maps\mp\_utility::func_4D30(var_03 + "_enemy_" + param_00 + "_inbound",level.otherteam[var_03]);
			}
		}
	}

	thread maps\mp\_utility::func_4D35(var_03 + "_friendly_" + param_00 + "_inbound");
	if(maps\mp\_utility::func_3AF8(param_00))
	{
		var_04[0] = self;
		if(playenemydialog(param_00))
		{
			thread maps\mp\_utility::func_4D30(var_03 + "_enemy_" + param_00 + "_inbound",undefined,undefined,var_04);
		}
	}
}

//Function Number: 14
playenemydialog(param_00)
{
	if(!maps\mp\_utility::func_47BB())
	{
		if(level.teambased && param_00 == "uplink" && [[ level.comexpfuncs["getRadarStrengthForTeam"] ]](self.team) != 1)
		{
			return 0;
		}
		else if(!level.teambased && param_00 == "uplink" && [[ level.comexpfuncs["getRadarStrengthForPlayer"] ]](self) != 2)
		{
			return 0;
		}
	}

	return 1;
}

//Function Number: 15
func_86F7(param_00)
{
	if(isai(self) && !isdefined(self.killstreakindexweapon))
	{
	}

	if(!isdefined(param_00))
	{
		self.pers["killstreaks"][self.killstreakindexweapon].available = 0;
		if(self.killstreakindexweapon == 0)
		{
			self.pers["killstreaks"][self.pers["killstreaks"][0].nextslot] = undefined;
			var_01 = undefined;
			var_02 = undefined;
			var_03 = self.pers["killstreaks"];
			for(var_04 = 5;var_04 < var_03.size;var_04++)
			{
				if(!isdefined(var_03[var_04]) || !isdefined(var_03[var_04].streakname))
				{
					continue;
				}

				var_01 = var_03[var_04].streakname;
				var_02 = var_03[var_04].kid;
				var_03[0].nextslot = var_04;
			}

			if(isdefined(var_01))
			{
				var_03[0].available = 1;
				var_03[0].streakname = var_01;
				var_03[0].kid = var_02;
				var_05 = maps\mp\_utility::func_3AFB(var_01);
				self setcommonplayerdata("killstreaksState","icons",0,var_05);
				if(!level.console && !common_scripts\utility::func_4828())
				{
					var_06 = maps\mp\_utility::getkillstreakweapon(var_01);
					maps\mp\_utility::_setactionslot(4,"weapon",var_06);
				}
			}
		}
	}

	var_07 = undefined;
	if(self.streaktype == "specialist")
	{
		if(self.pers["killstreaks"][0].available)
		{
			var_07 = 0;
		}
	}
	else
	{
		for(var_04 = 0;var_04 < 4;var_04++)
		{
			var_08 = self.pers["killstreaks"][var_04];
			if(isdefined(var_08) && isdefined(var_08.streakname) && var_08.available)
			{
				var_07 = var_04;
			}
		}
	}

	if(isdefined(var_07))
	{
		if(level.console || common_scripts\utility::func_4828())
		{
			self.killstreakindexweapon = var_07;
			self.pers["lastEarnedStreak"] = self.pers["killstreaks"][var_07].streakname;
			giveselectedkillstreakitem();
		}

		for(var_04 = 0;var_04 < 4;var_04++)
		{
			var_08 = self.pers["killstreaks"][var_04];
			if(isdefined(var_08) && isdefined(var_08.streakname) && var_08.available)
			{
				var_06 = maps\mp\_utility::getkillstreakweapon(var_08.streakname);
				var_09 = self getweaponslistitems();
				var_0A = 0;
				for(var_0B = 0;var_0B < var_09.size;var_0B++)
				{
					if(var_06 == var_09[var_0B])
					{
						var_0A = 1;
						break;
					}
				}

				if(!var_0A)
				{
					maps\mp\_utility::_giveweapon(var_06);
				}
				else if(issubstr(var_06,"airdrop_"))
				{
					self setweaponammoclip(var_06,1);
				}

				maps\mp\_utility::_setactionslot(var_04 + 4,"weapon",var_06);
			}
		}

		self.killstreakindexweapon = undefined;
		self.pers["lastEarnedStreak"] = self.pers["killstreaks"][var_07].streakname;
		updatestreakslots();
	}

	self.killstreakindexweapon = undefined;
	self.pers["lastEarnedStreak"] = undefined;
	updatestreakslots();
}

//Function Number: 16
clearkillstreaks()
{
	var_00 = self.pers["killstreaks"];
	if(!isdefined(var_00))
	{
	}

	for(var_01 = var_00.size - 1;var_01 > -1;var_01--)
	{
		self.pers["killstreaks"][var_01] = undefined;
	}

	func_4641();
	func_6604();
	self.killstreakindexweapon = undefined;
	updatestreakslots();
}

//Function Number: 17
func_8732()
{
	if(self.adrenaline == 0)
	{
		for(var_00 = 1;var_00 < 4;var_00++)
		{
			if(isdefined(self.pers["killstreaks"][var_00]))
			{
				self.pers["killstreaks"][var_00].available = 0;
				self setcommonplayerdata("killstreaksState","hasStreak",var_00,0);
			}
		}

		self setcommonplayerdata("killstreaksState","nextIndex",1);
		self setcommonplayerdata("killstreaksState","hasStreak",4,0);
	}
	else
	{
		for(var_00 = 1;var_00 < 4;var_00++)
		{
			var_01 = self.pers["killstreaks"][var_00];
			if(isdefined(var_01) && isdefined(var_01.streakname) && var_01.available)
			{
				var_02 = func_3C16(var_01.streakname);
				if(var_02 > self.adrenaline)
				{
					self.pers["killstreaks"][var_00].available = 0;
					self setcommonplayerdata("killstreaksState","hasStreak",var_00,0);
					continue;
				}

				if(self.adrenaline >= var_02)
				{
					if(self getcommonplayerdata("killstreaksState","hasStreak",var_00))
					{
						self [[ level.killstreakfuncs[var_01.streakname] ]](undefined,var_01.streakname);
						continue;
					}

					func_3CF2(var_01.streakname,var_01.earned,0,self);
				}
			}
		}

		var_03 = getmaxstreakcost();
		if(isai(self))
		{
			var_03 = self.pers["specialistStreakKills"][2];
		}

		var_04 = castint(max(8,var_03 + 2));
		if(maps\mp\_utility::_hasperk("specialty_hardline"))
		{
			var_04--;
		}

		if(self.adrenaline >= var_04)
		{
			self setcommonplayerdata("killstreaksState","hasStreak",4,1);
			givebonusperks();
		}
		else
		{
			self setcommonplayerdata("killstreaksState","hasStreak",4,0);
		}
	}

	if(self.pers["killstreaks"][0].available)
	{
		var_05 = self.pers["killstreaks"][0].streakname;
		var_06 = maps\mp\_utility::getkillstreakweapon(var_05);
		if(level.console || common_scripts\utility::func_4828())
		{
			givekillstreakweapon(var_06);
			self.killstreakindexweapon = 0;
		}

		maps\mp\_utility::_giveweapon(var_06);
		maps\mp\_utility::_setactionslot(4,"weapon",var_06);
		self.killstreakindexweapon = undefined;
	}
}

//Function Number: 18
func_3AAA()
{
	var_00 = self getweaponslistprimaries();
	return var_00[0];
}

//Function Number: 19
istryingtousekillstreakingimmeslot()
{
	return isdefined(self.tryingtouseks) && self.tryingtouseks && isdefined(self.killstreakindexweapon) && self.killstreakindexweapon == 0;
}

//Function Number: 20
istryingtousekillstreakslot()
{
	return isdefined(self.tryingtouseks) && self.tryingtouseks && isdefined(self.killstreakindexweapon);
}

//Function Number: 21
waitforkillstreakweaponswitchstarted()
{
	self endon("weapon_switch_invalid");
	self waittill("weapon_switch_started",var_00);
	self notify("killstreak_weapon_change","switch_started",var_00);
}

//Function Number: 22
waitforkillstreakweaponswitchinvalid()
{
	self endon("weapon_switch_started");
	self waittill("weapon_switch_invalid",var_00);
	self notify("killstreak_weapon_change","switch_invalid",var_00);
}

//Function Number: 23
waitforkillstreakweaponchange()
{
	childthread waitforkillstreakweaponswitchstarted();
	childthread waitforkillstreakweaponswitchinvalid();
	self waittill("killstreak_weapon_change",var_00,var_01);
	if(var_00 == "switch_started")
	{
		return var_01;
	}

	var_02 = maps\mp\_utility::getkillstreakweapon(self.pers["killstreaks"][self.killstreakindexweapon].streakname);
	self switchtoweapon(var_02);
	waittillframeend;
	var_03 = undefined;
	if(isdefined(self.changingweapon))
	{
		var_03 = self.changingweapon;
	}
	else
	{
		self waittill("weapon_switch_started",var_03);
	}

	if(var_03 != var_02)
	{
		return undefined;
	}

	return var_02;
}

//Function Number: 24
func_4B4A()
{
	self endon("disconnect");
	self endon("finish_death");
	self endon("joined_team");
	self endon("faux_spawn");
	self endon("spawned");
	level endon("game_ended");
	self notify("killstreakUseWaiter");
	self endon("killstreakUseWaiter");
	self.lastkillstreak = 0;
	if(!isdefined(self.pers["lastEarnedStreak"]))
	{
		self.pers["lastEarnedStreak"] = undefined;
	}

	thread func_3298();
	var_00 = ["streakUsed","streakUsed1","streakUsed2","streakUsed3","streakUsed4"];
	for(;;)
	{
		self.tryingtouseks = undefined;
		var_01 = common_scripts\utility::waittill_any_in_array_return_no_endon_death(var_00);
		self.tryingtouseks = 1;
		waittillframeend;
		if(!isdefined(self.killstreakindexweapon) || !isdefined(self.pers["killstreaks"][self.killstreakindexweapon]) || !isdefined(self.pers["killstreaks"][self.killstreakindexweapon].streakname))
		{
			continue;
		}

		if(!maps\mp\_utility::cancustomjuggusekillstreak(self.pers["killstreaks"][self.killstreakindexweapon].streakname))
		{
			maps\mp\_utility::printcustomjuggkillstreakerrormsg();
			if(var_01 != "streakUsed")
			{
				var_02 = self getcurrentweapon();
				maps\mp\_utility::func_7E17(var_02);
			}

			continue;
		}

		if(self setmissileminimapvisible())
		{
			continue;
		}

		if(isdefined(self.changingweapon))
		{
			var_03 = self.changingweapon;
		}
		else
		{
			self waittill("weapon_switch_started",var_03);
		}

		var_04 = maps\mp\_utility::getkillstreakweapon(self.pers["killstreaks"][self.killstreakindexweapon].streakname);
		if(var_03 != var_04)
		{
			thread removeunitializedkillstreakweapon();
			continue;
		}

		beginkillstreakweaponswitch();
		if(var_03 != self getcurrentweapon())
		{
			thread killstreakwaitforweaponchange();
			var_05 = common_scripts\utility::func_8B36(1.5,"ks_weapon_change","ks_alt_weapon_change");
			if(var_05 == "ks_alt_weapon_change")
			{
				self waittill("weapon_change",var_03,var_06);
			}
			else
			{
				var_03 = self getcurrentweapon();
			}
		}

		if(!isalive(self))
		{
			endkillstreakweaponswitch();
			continue;
		}

		if(var_03 != var_04)
		{
			var_07 = self.lastdroppableweapon;
			if(maps\mp\_utility::func_48F7(var_03))
			{
				if(maps\mp\_utility::isjuggernaut() && maps\mp\_utility::func_48EF(var_03))
				{
					var_07 = var_03;
				}
				else if(var_03 == "iw6_gm6helisnipe_mp_gm6scope")
				{
					var_07 = var_03;
				}
				else
				{
					self takeweapon(var_03);
				}
			}

			self switchtoweapon(var_07);
			endkillstreakweaponswitch();
			continue;
		}

		self.ks_abouttouse = 1;
		waittillframeend;
		self.ks_abouttouse = undefined;
		var_08 = self.pers["killstreaks"][self.killstreakindexweapon].streakname;
		var_09 = self.pers["killstreaks"][self.killstreakindexweapon].isgimme;
		endkillstreakweaponswitch();
		var_05 = killstreakusepressed();
		beginkillstreakweaponswitch();
		var_02 = common_scripts\utility::func_3B0A();
		if(!self hasweapon(var_02))
		{
			if(maps\mp\_utility::func_4945(self))
			{
				var_02 = func_3AAA();
			}
			else
			{
				maps\mp\_utility::_giveweapon(var_02);
			}
		}

		if(var_05)
		{
			thread waittakekillstreakweapon(var_04,var_02);
		}

		if(func_74CE(var_05,var_08))
		{
			maps\mp\_utility::func_7E17(var_02);
		}

		var_0A = self getcurrentweapon();
		while(var_0A != var_02)
		{
			self waittill("weapon_change",var_0A);
		}

		endkillstreakweaponswitch();
	}
}

//Function Number: 25
removeunitializedkillstreakweapon()
{
	self notify("removeUnitializedKillstreakWeapon");
	self endon("removeUnitializedKillstreakWeapon");
	self endon("death");
	self endon("disconnect");
	self waittill("weapon_change",var_00);
	var_01 = isdefined(self.killstreakindexweapon) && isdefined(self.pers["killstreaks"]) && isdefined(self.pers["killstreaks"][self.killstreakindexweapon]) && isdefined(self.pers["killstreaks"][self.killstreakindexweapon].streakname) && var_00 == maps\mp\_utility::getkillstreakweapon(self.pers["killstreaks"][self.killstreakindexweapon].streakname);
	if(var_01 && !isdefined(self.ks_abouttouse))
	{
		self takeweapon(var_00);
		maps\mp\_utility::_giveweapon(var_00,0);
		maps\mp\_utility::_setactionslot(4,"weapon",var_00);
		var_02 = common_scripts\utility::func_3B0A();
		if(!self hasweapon(var_02))
		{
			var_02 = func_3AAA();
		}

		if(isdefined(var_02))
		{
			maps\mp\_utility::func_7E17(var_02);
		}
	}
}

//Function Number: 26
beginkillstreakweaponswitch()
{
	common_scripts\utility::_disableweaponswitch();
	common_scripts\utility::_disableusability();
	thread killstreakweaponswitchwatchhostmigration();
}

//Function Number: 27
endkillstreakweaponswitch()
{
	self notify("endKillstreakWeaponSwitch");
	common_scripts\utility::_enableweaponswitch();
	common_scripts\utility::_enableusability();
}

//Function Number: 28
killstreakwaitforweaponchange()
{
	self waittill("weapon_change",var_00,var_01);
	if(!var_01)
	{
		self notify("ks_weapon_change");
	}

	self notify("ks_alt_weapon_change");
}

//Function Number: 29
killstreakweaponswitchwatchhostmigration()
{
	self endon("death");
	level endon("game_ended");
	self endon("endKillstreakWeaponSwitch");
	level waittill("host_migration_end");
	if(isdefined(self))
	{
		self enableweaponswitch();
	}
}

//Function Number: 30
waittakekillstreakweapon(param_00,param_01)
{
	self endon("disconnect");
	self endon("finish_death");
	self endon("joined_team");
	level endon("game_ended");
	self notify("waitTakeKillstreakWeapon");
	self endon("waitTakeKillstreakWeapon");
	var_02 = self getcurrentweapon() == "none";
	self waittill("weapon_change",var_03);
	if(var_03 == param_01)
	{
		func_7E87(param_00);
		if(!level.console && !common_scripts\utility::func_4828())
		{
			self.killstreakindexweapon = undefined;
		}
	}

	if(var_03 != param_00)
	{
		thread waittakekillstreakweapon(param_00,param_01);
	}

	if(var_02 && self getcurrentweapon() == param_00)
	{
		thread waittakekillstreakweapon(param_00,param_01);
	}
}

//Function Number: 31
func_7E87(param_00)
{
	var_01 = 0;
	var_02 = self.pers["killstreaks"];
	for(var_03 = 0;var_03 < var_02.size;var_03++)
	{
		if(isdefined(var_02[var_03]) && isdefined(var_02[var_03].streakname) && var_02[var_03].available)
		{
			if(!maps\mp\_utility::func_496B(var_02[var_03].streakname) && param_00 == maps\mp\_utility::getkillstreakweapon(var_02[var_03].streakname))
			{
				var_01 = 1;
				break;
			}
		}
	}

	if(var_01)
	{
		if(level.console || common_scripts\utility::func_4828())
		{
			if(isdefined(self.killstreakindexweapon) && param_00 != maps\mp\_utility::getkillstreakweapon(var_02[self.killstreakindexweapon].streakname))
			{
				self takeweapon(param_00);
			}

			if(isdefined(self.killstreakindexweapon) && param_00 == maps\mp\_utility::getkillstreakweapon(var_02[self.killstreakindexweapon].streakname))
			{
				self takeweapon(param_00);
				maps\mp\_utility::_giveweapon(param_00,0);
				maps\mp\_utility::_setactionslot(4,"weapon",param_00);
			}
		}

		self takeweapon(param_00);
		maps\mp\_utility::_giveweapon(param_00,0);
	}

	if(param_00 == "")
	{
	}

	self takeweapon(param_00);
}

//Function Number: 32
func_74CE(param_00,param_01)
{
	if(!param_00)
	{
		return 1;
	}

	if(maps\mp\_utility::func_494D(param_01))
	{
		return 0;
	}

	return 1;
}

//Function Number: 33
func_3298()
{
	self endon("disconnect");
	level endon("game_ended");
	self notify("finishDeathWaiter");
	self endon("finishDeathWaiter");
	self waittill("death");
	wait(0.05);
	self notify("finish_death");
	self.pers["lastEarnedStreak"] = undefined;
}

//Function Number: 34
checkstreakreward()
{
	foreach(var_01 in self.killstreaks)
	{
		var_02 = func_3C16(var_01);
		if(var_02 > self.adrenaline)
		{
			break;
		}

		if(self.previousadrenaline < var_02 && self.adrenaline >= var_02)
		{
			earnkillstreak(var_01,var_02);
			break;
		}
	}
}

//Function Number: 35
func_4B37(param_00)
{
	var_01 = "assault";
	switch(self.streaktype)
	{
		case "assault":
			var_01 = "assaultStreaks";
			break;

		case "support":
			var_01 = "supportStreaks";
			break;

		case "specialist":
			var_01 = "specialistStreaks";
			break;
	}

	if(isdefined(self.class_num))
	{
		if(self getcacplayerdata("loadouts",self.class_num,var_01,0) == param_00)
		{
			self.firstkillstreakearned = gettime();
		}

		if(self getcacplayerdata("loadouts",self.class_num,var_01,2) == param_00 && isdefined(self.firstkillstreakearned))
		{
			if(gettime() - self.firstkillstreakearned < 20000)
			{
				thread maps\mp\gametypes\_missions::func_37A9("wargasm");
			}
		}
	}
}

//Function Number: 36
earnkillstreak(param_00,param_01)
{
	level notify("gave_killstreak",param_00);
	self.earnedstreaklevel = param_01;
	if(!level.gameended)
	{
		var_02 = undefined;
		if(self.streaktype == "specialist")
		{
			var_03 = getsubstr(param_00,0,param_00.size - 3);
			if(maps\mp\gametypes\_class::func_492E(var_03))
			{
				var_02 = "pro";
			}
		}

		thread maps\mp\gametypes\_hud_message::func_4B46(param_00,param_01,var_02);
		if(maps\mp\_utility::bot_is_fireteam_mode())
		{
			if(isdefined(var_02))
			{
				self notify("bot_killstreak_earned",param_00 + "_" + var_02,param_01);
			}
			else
			{
				self notify("bot_killstreak_earned",param_00,param_01);
			}
		}
	}

	thread func_4B37(param_00);
	self.pers["lastEarnedStreak"] = param_00;
	setstreakcounttonext();
	func_3CF2(param_00,1,1);
}

//Function Number: 37
func_3CF2(param_00,param_01,param_02,param_03,param_04,param_05)
{
	self endon("joined_team");
	self endon("givingLoadout");
	self endon("disconnect");
	if(!isdefined(param_05))
	{
		param_05 = self.pers["kID"];
		self.pers["kID"]++;
	}

	if(!isdefined(level.killstreakfuncs[param_00]))
	{
	}

	if(self.team == "spectator")
	{
	}

	var_06 = undefined;
	if(!isdefined(param_01) || param_01 == 0)
	{
		if(isdefined(param_04))
		{
			var_07 = param_04;
		}
		else
		{
			var_07 = self.pers["killstreaks"].size;
		}

		if(!isdefined(self.pers["killstreaks"][var_07]))
		{
			self.pers["killstreaks"][var_07] = addstruct();
		}

		var_08 = 1;
		if(var_07 > 5 && istryingtousekillstreakingimmeslot())
		{
			var_08 = 0;
			var_09 = var_07;
			var_0A = var_07 - 1;
			var_0B = self.pers["killstreaks"][var_0A];
			var_0C = self.pers["killstreaks"][var_09];
			var_0C.available = var_0B.available;
			var_0C.streakname = var_0B.streakname;
			var_0C.earned = var_0B.earned;
			var_0C.awardxp = var_0B.awardxp;
			var_0C.owner = var_0B.owner;
			var_0C.kid = var_0B.kid;
			var_0C.lifeid = var_0B.lifeid;
			var_0C.isgimme = var_0B.isgimme;
			var_0C.isspecialist = var_0B.isspecialist;
			var_07 = var_0A;
		}

		var_0D = self.pers["killstreaks"][var_07];
		var_0D.available = 0;
		var_0D.streakname = param_00;
		var_0D.earned = 0;
		var_0D.awardxp = isdefined(param_02) && param_02;
		var_0D.owner = param_03;
		var_0D.kid = param_05;
		var_0D.lifeid = -1;
		var_0D.isgimme = 1;
		var_0D.isspecialist = 0;
		if(!var_08)
		{
			self.pers["killstreaks"][0].nextslot = var_07 + 1;
		}

		if(!isdefined(param_04))
		{
			param_04 = 0;
		}

		self.pers["killstreaks"][param_04].nextslot = var_07;
		self.pers["killstreaks"][param_04].streakname = param_00;
		var_06 = param_04;
		var_0E = maps\mp\_utility::func_3AFB(param_00);
		self setcommonplayerdata("killstreaksState","icons",param_04,var_0E);
	}
	else
	{
		for(var_0F = 1;var_0F < 4;var_0F++)
		{
			var_10 = self.pers["killstreaks"][var_0F];
			if(isdefined(var_10) && isdefined(var_10.streakname) && param_00 == var_10.streakname)
			{
				var_06 = var_0F;
				break;
			}
		}

		if(!isdefined(var_06))
		{
		}
	}

	var_11 = self.pers["killstreaks"][var_06];
	var_11.available = 1;
	var_11.earned = isdefined(param_01) && param_01;
	var_11.awardxp = isdefined(param_02) && param_02;
	var_11.owner = param_03;
	var_11.kid = param_05;
	if(!var_11.earned)
	{
		var_11.lifeid = -1;
	}
	else
	{
		var_11.lifeid = self.pers["deaths"];
	}

	if(self.streaktype == "specialist" && var_06 != 0)
	{
		var_11.isspecialist = 1;
		if(isdefined(level.killstreakfuncs[param_00]))
		{
			self [[ level.killstreakfuncs[param_00] ]](-1,param_00);
		}

		func_87B3(param_00,param_02);
	}
	else if(level.console || common_scripts\utility::func_4828())
	{
		var_12 = maps\mp\_utility::getkillstreakweapon(param_00);
		givekillstreakweapon(var_12);
		if(isdefined(self.killstreakindexweapon))
		{
			param_00 = self.pers["killstreaks"][self.killstreakindexweapon].streakname;
			var_13 = maps\mp\_utility::getkillstreakweapon(param_00);
			if(!isholdingweapon(var_13))
			{
				self.killstreakindexweapon = var_06;
			}
		}
		else
		{
			self.killstreakindexweapon = var_06;
		}
	}
	else
	{
		if(0 == var_06 && self.pers["killstreaks"][0].nextslot > 5)
		{
			var_14 = self.pers["killstreaks"][0].nextslot - 1;
			var_15 = maps\mp\_utility::getkillstreakweapon(self.pers["killstreaks"][var_14].streakname);
			self takeweapon(var_15);
		}

		var_13 = maps\mp\_utility::getkillstreakweapon(param_00);
		maps\mp\_utility::_giveweapon(var_13,0);
		var_16 = 1;
		if(isdefined(self.killstreakindexweapon))
		{
			param_00 = self.pers["killstreaks"][self.killstreakindexweapon].streakname;
			var_13 = maps\mp\_utility::getkillstreakweapon(param_00);
			var_16 = !isholdingweapon(var_13) && self getcurrentweapon() != "none";
		}

		if(var_16)
		{
			maps\mp\_utility::_setactionslot(var_06 + 4,"weapon",var_13);
		}
		else
		{
			maps\mp\_utility::_setactionslot(var_06 + 4,"");
			self.actionslotenabled[var_06] = 0;
		}
	}

	updatestreakslots();
	if(isdefined(level.killstreaksetupfuncs[param_00]))
	{
		self [[ level.killstreaksetupfuncs[param_00] ]]();
	}

	if(isdefined(param_01) && param_01 && isdefined(param_02) && param_02)
	{
		self notify("received_earned_killstreak");
	}
}

//Function Number: 38
givekillstreakweapon(param_00)
{
	self endon("disconnect");
	if(!level.console && !common_scripts\utility::func_4828())
	{
	}

	var_01 = maps\mp\_utility::getkillstreakreferencebyweapon(param_00);
	if(!maps\mp\_utility::cancustomjuggusekillstreak(var_01))
	{
		maps\mp\_utility::_setactionslot(4,"");
	}

	var_02 = self getweaponslistitems();
	foreach(var_04 in var_02)
	{
		if(!maps\mp\_utility::func_4971(var_04,"killstreak_") && !maps\mp\_utility::func_4971(var_04,"airdrop_") && !maps\mp\_utility::func_4971(var_04,"deployable_"))
		{
			continue;
		}

		if(isholdingweapon(var_04))
		{
			continue;
		}

		while(maps\mp\_utility::func_4899())
		{
			wait(0.05);
		}

		self takeweapon(var_04);
	}

	if(isdefined(self.killstreakindexweapon))
	{
		var_01 = self.pers["killstreaks"][self.killstreakindexweapon].streakname;
		var_06 = maps\mp\_utility::getkillstreakweapon(var_01);
		if(!isholdingweapon(var_06))
		{
			if(param_00 != "")
			{
				maps\mp\_utility::_giveweapon(param_00,0);
				maps\mp\_utility::_setactionslot(4,"weapon",param_00);
			}
		}
	}

	maps\mp\_utility::_giveweapon(param_00,0);
	maps\mp\_utility::_setactionslot(4,"weapon",param_00);
}

//Function Number: 39
isholdingweapon(param_00)
{
	return self getcurrentweapon() == param_00 || isdefined(self.changingweapon) && self.changingweapon == param_00;
}

//Function Number: 40
func_3C16(param_00)
{
	var_01 = castint(maps\mp\_utility::func_3AFC(param_00));
	if(isdefined(self) && isplayer(self))
	{
		if(maps\mp\_utility::func_496B(param_00))
		{
			if(isdefined(self.pers["gamemodeLoadout"]))
			{
				if(isdefined(self.pers["gamemodeLoadout"]["loadoutKillstreak1"]) && self.pers["gamemodeLoadout"]["loadoutKillstreak1"] == param_00)
				{
					var_01 = 2;
				}
				else if(isdefined(self.pers["gamemodeLoadout"]["loadoutKillstreak2"]) && self.pers["gamemodeLoadout"]["loadoutKillstreak2"] == param_00)
				{
					var_01 = 4;
				}
				else if(isdefined(self.pers["gamemodeLoadout"]["loadoutKillstreak3"]) && self.pers["gamemodeLoadout"]["loadoutKillstreak3"] == param_00)
				{
					var_01 = 6;
				}
				else
				{
				}
			}
			else if(issubstr(self.curclass,"custom"))
			{
				for(var_02 = 0;var_02 < 3;var_02++)
				{
					var_03 = self getcacplayerdata("loadouts",self.class_num,"specialistStreaks",var_02);
					if(var_03 == param_00)
					{
						break;
					}
				}

				var_01 = self getcacplayerdata("loadouts",self.class_num,"specialistStreakKills",var_02);
			}
			else if(issubstr(self.curclass,"callback"))
			{
				var_02 = 0;
				foreach(var_05 in self.pers["specialistStreaks"])
				{
					if(var_05 == param_00)
					{
						break;
					}
				}

				var_01 = self.pers["specialistStreakKills"][var_02];
			}
			else if(issubstr(self.curclass,"axis") || issubstr(self.curclass,"allies"))
			{
				var_02 = 0;
				var_06 = "none";
				if(issubstr(self.curclass,"axis"))
				{
					var_06 = "axis";
				}
				else if(issubstr(self.curclass,"allies"))
				{
					var_06 = "allies";
				}

				var_07 = maps\mp\_utility::func_3A55(self.curclass);
				while(var_02 < 3)
				{
					var_03 = getmatchrulesdata("defaultClasses",var_06,var_07,"class","specialistStreaks",var_02);
					if(var_03 == param_00)
					{
						break;
					}

					var_02++;
				}

				var_01 = getmatchrulesdata("defaultClasses",var_06,var_07,"class","specialistStreakKills",var_02);
			}
		}

		if(maps\mp\_utility::_hasperk("specialty_hardline") && var_01 > 0)
		{
			var_01--;
		}
	}

	var_01 = castint(clamp(var_01,0,30));
	return var_01;
}

//Function Number: 41
func_7C97(param_00)
{
	switch(param_00)
	{
		case "assault":
		case "specialist":
			return 1;

		case "support":
			return 0;
	}
}

//Function Number: 42
func_3CFA(param_00)
{
	var_01 = self.pers["killstreaks"];
	if(level.console || common_scripts\utility::func_4828())
	{
		var_02 = -1;
		var_03 = -1;
		for(var_04 = 0;var_04 < 4;var_04++)
		{
			if(isdefined(var_01[var_04]) && isdefined(var_01[var_04].streakname) && var_01[var_04].available && func_3C16(var_01[var_04].streakname) > var_03)
			{
				var_03 = 0;
				if(!var_01[var_04].isgimme)
				{
					var_03 = func_3C16(var_01[var_04].streakname);
				}

				var_02 = var_04;
			}
		}

		if(var_02 != -1)
		{
			self.killstreakindexweapon = var_02;
			var_05 = var_01[self.killstreakindexweapon].streakname;
			var_06 = maps\mp\_utility::getkillstreakweapon(var_05);
			givekillstreakweapon(var_06);
		}
		else
		{
			self.killstreakindexweapon = undefined;
		}
	}
	else
	{
		var_02 = -1;
		var_03 = -1;
		for(var_04 = 0;var_04 < 4;var_04++)
		{
			if(isdefined(var_01[var_04]) && isdefined(var_01[var_04].streakname) && var_01[var_04].available)
			{
				var_07 = maps\mp\_utility::getkillstreakweapon(var_01[var_04].streakname);
				var_08 = self getweaponslistitems();
				var_09 = 0;
				for(var_0A = 0;var_0A < var_08.size;var_0A++)
				{
					if(var_07 == var_08[var_0A])
					{
						var_09 = 1;
						break;
					}
				}

				if(!var_09)
				{
					maps\mp\_utility::_giveweapon(var_07);
				}
				else if(issubstr(var_07,"airdrop_"))
				{
					self setweaponammoclip(var_07,1);
				}

				maps\mp\_utility::_setactionslot(var_04 + 4,"weapon",var_07);
				if(func_3C16(var_01[var_04].streakname) > var_03)
				{
					var_03 = 0;
					if(!var_01[var_04].isgimme)
					{
						var_03 = func_3C16(var_01[var_04].streakname);
					}

					var_02 = var_04;
				}
			}
		}

		if(var_02 != -1)
		{
			var_05 = var_01[var_02].streakname;
		}

		self.killstreakindexweapon = undefined;
	}

	updatestreakslots();
}

//Function Number: 43
func_4649(param_00)
{
	common_scripts\utility::_disableusability();
	var_01 = initridekillstreak_internal(param_00);
	if(isdefined(self))
	{
		common_scripts\utility::_enableusability();
	}

	return var_01;
}

//Function Number: 44
initridekillstreak_internal(param_00)
{
	if(isdefined(param_00) && func_48FD(param_00))
	{
		var_01 = "timeout";
	}
	else
	{
		var_01 = common_scripts\utility::func_8B35(1,"disconnect","death","weapon_switch_started");
	}

	maps\mp\gametypes\_hostmigration::func_8BBA();
	if(var_01 == "weapon_switch_started")
	{
		return "fail";
	}

	if(!isalive(self))
	{
		return "fail";
	}

	if(var_01 == "disconnect" || var_01 == "death")
	{
		if(var_01 == "disconnect")
		{
			return "disconnect";
		}

		if(self.team == "spectator")
		{
			return "fail";
		}

		return "success";
	}

	if(maps\mp\_utility::func_48F6())
	{
		return "fail";
	}

	if(!isdefined(param_00) || !issubstr(param_00,"odin"))
	{
		self visionsetnakedforplayer("black_bw",0.75);
		thread maps\mp\_utility::set_visionset_for_watching_players("black_bw",0.75,1,undefined,1);
		var_02 = common_scripts\utility::func_8B35(0.8,"disconnect","death");
	}
	else
	{
		var_02 = common_scripts\utility::func_8B35(1,"disconnect","death");
	}

	self notify("black_out_done");
	maps\mp\gametypes\_hostmigration::func_8BBA();
	if(var_02 != "disconnect")
	{
		if(!isdefined(param_00) || !issubstr(param_00,"odin"))
		{
			thread clearrideintro(1);
		}
		else
		{
			self notify("intro_cleared");
		}

		if(self.team == "spectator")
		{
			return "fail";
		}
	}

	if(self isonladder())
	{
		return "fail";
	}

	if(!isalive(self))
	{
		return "fail";
	}

	if(maps\mp\_utility::func_48F6())
	{
		return "fail";
	}

	if(var_02 == "disconnect")
	{
		return "disconnect";
	}

	return "success";
}

//Function Number: 45
func_48FD(param_00)
{
	switch(param_00)
	{
		case "remote_tank":
		case "remote_uav":
		case "osprey_gunner":
		case "ac130":
		case "ca_a10_strafe":
		case "odin_assault":
		case "odin_support":
		case "drone_hive":
		case "heli_pilot":
		case "vanguard":
			return 1;
	}

	return 0;
}

//Function Number: 46
clearrideintro(param_00,param_01)
{
	self endon("disconnect");
	if(isdefined(param_00))
	{
		wait(param_00);
	}

	if(!isdefined(param_01))
	{
		param_01 = 0;
	}

	self visionsetnakedforplayer("",param_01);
	maps\mp\_utility::set_visionset_for_watching_players("",param_01);
	self notify("intro_cleared");
}

//Function Number: 47
allowridekillstreakplayerexit(param_00)
{
	if(isdefined(param_00))
	{
		self endon(param_00);
	}

	if(!isdefined(self.owner))
	{
	}

	var_01 = self.owner;
	level endon("game_ended");
	var_01 endon("disconnect");
	var_01 endon("end_remote");
	self endon("death");
	for(;;)
	{
		var_02 = 0;
		while(var_01 usebuttonpressed())
		{
			var_02 = var_02 + 0.05;
			if(var_02 > 0.75)
			{
				self notify("killstreakExit");
			}

			wait(0.05);
		}

		wait(0.05);
	}
}

//Function Number: 48
giveselectedkillstreakitem()
{
	var_00 = self.pers["killstreaks"][self.killstreakindexweapon].streakname;
	var_01 = maps\mp\_utility::getkillstreakweapon(var_00);
	givekillstreakweapon(var_01);
	updatestreakslots();
}

//Function Number: 49
getkillstreakcount()
{
	var_00 = 0;
	for(var_01 = 0;var_01 < 4;var_01++)
	{
		if(isdefined(self.pers["killstreaks"][var_01]) && isdefined(self.pers["killstreaks"][var_01].streakname) && self.pers["killstreaks"][var_01].available)
		{
			var_00++;
		}
	}

	return var_00;
}

//Function Number: 50
func_752D()
{
	if(getkillstreakcount() > 1)
	{
		for(;;)
		{
			self.killstreakindexweapon++;
			if(self.killstreakindexweapon > 3)
			{
				self.killstreakindexweapon = 0;
			}

			if(self.pers["killstreaks"][self.killstreakindexweapon].available == 1)
			{
				break;
			}
		}

		giveselectedkillstreakitem();
	}
}

//Function Number: 51
shufflekillstreaksdown()
{
	if(getkillstreakcount() > 1)
	{
		for(;;)
		{
			self.killstreakindexweapon--;
			if(self.killstreakindexweapon < 0)
			{
				self.killstreakindexweapon = 3;
			}

			if(self.pers["killstreaks"][self.killstreakindexweapon].available == 1)
			{
				break;
			}
		}

		giveselectedkillstreakitem();
	}
}

//Function Number: 52
func_7C94()
{
	self endon("death");
	self endon("disconnect");
	self endon("faux_spawn");
	level endon("game_ended");
	for(;;)
	{
		self waittill("toggled_up");
		if(!level.console && !common_scripts\utility::func_4828())
		{
			continue;
		}

		if(isdefined(self.showingtacticalselections) && self.showingtacticalselections)
		{
			continue;
		}

		if(!self ismantling() && !isdefined(self.changingweapon) || isdefined(self.changingweapon) && self.changingweapon == "none" && !maps\mp\_utility::func_48F7(self getcurrentweapon()) || isminigun(self getcurrentweapon()) || self getcurrentweapon() == "venomxgun_mp" || maps\mp\_utility::func_48F7(self getcurrentweapon()) && maps\mp\_utility::isjuggernaut() && self.streaktype != "specialist" && !isdefined(self.iscarrying) || isdefined(self.iscarrying) && self.iscarrying == 0 && !isdefined(self.laststreakused) || isdefined(self.laststreakused) && gettime() - self.laststreakused > 100)
		{
			func_752D();
			self setclientomnvar("ui_killstreak_scroll",1);
		}

		wait(0.12);
	}
}

//Function Number: 53
isminigun(param_00)
{
	return param_00 == "iw6_minigunjugg_mp";
}

//Function Number: 54
func_7C93()
{
	self endon("death");
	self endon("disconnect");
	self endon("faux_spawn");
	level endon("game_ended");
	for(;;)
	{
		self waittill("toggled_down");
		if(!level.console && !common_scripts\utility::func_4828())
		{
			continue;
		}

		if(isdefined(self.showingtacticalselections) && self.showingtacticalselections)
		{
			continue;
		}

		if(!self ismantling() && !isdefined(self.changingweapon) || isdefined(self.changingweapon) && self.changingweapon == "none" && !maps\mp\_utility::func_48F7(self getcurrentweapon()) || isminigun(self getcurrentweapon()) || self getcurrentweapon() == "venomxgun_mp" || maps\mp\_utility::func_48F7(self getcurrentweapon()) && maps\mp\_utility::isjuggernaut() && self.streaktype != "specialist" && !isdefined(self.iscarrying) || isdefined(self.iscarrying) && self.iscarrying == 0 && !isdefined(self.laststreakused) || isdefined(self.laststreakused) && gettime() - self.laststreakused > 100)
		{
			shufflekillstreaksdown();
			self setclientomnvar("ui_killstreak_scroll",1);
		}

		wait(0.12);
	}
}

//Function Number: 55
func_7C98()
{
	self endon("death");
	self endon("disconnect");
	self endon("faux_spawn");
	level endon("game_ended");
	for(;;)
	{
		self waittill("streakUsed");
		self.laststreakused = gettime();
	}
}

//Function Number: 56
func_7C92()
{
	self endon("death");
	self endon("disconnect");
	level endon("game_ended");
	if(botsentientswap(self))
	{
	}

	maps\mp\_utility::gameflagwait("prematch_done");
	if(level.console || common_scripts\utility::func_4828())
	{
		self notifyonplayercommand("toggled_up","+actionslot 1");
		self notifyonplayercommand("toggled_down","+actionslot 2");
		self notifyonplayercommand("streakUsed","+actionslot 4");
		self notifyonplayercommand("streakUsed","+actionslot 5");
		self notifyonplayercommand("streakUsed","+actionslot 6");
		self notifyonplayercommand("streakUsed","+actionslot 7");
	}

	if(!level.console)
	{
		self notifyonplayercommand("streakUsed1","+actionslot 4");
		self notifyonplayercommand("streakUsed2","+actionslot 5");
		self notifyonplayercommand("streakUsed3","+actionslot 6");
		self notifyonplayercommand("streakUsed4","+actionslot 7");
	}
}

//Function Number: 57
registeradrenalineinfo(param_00,param_01)
{
	if(!isdefined(level.adrenalineinfo))
	{
		level.adrenalineinfo = [];
	}

	level.adrenalineinfo[param_00] = param_01;
}

//Function Number: 58
func_3CDB(param_00)
{
	if(level.adrenalineinfo[param_00] == 0)
	{
	}

	if(maps\mp\_utility::isjuggernaut() && self.streaktype == "specialist")
	{
	}

	var_01 = self.adrenaline + level.adrenalineinfo[param_00];
	var_02 = var_01;
	var_03 = getmaxstreakcost();
	if(var_02 > var_03 && self.streaktype != "specialist")
	{
		var_02 = var_02 - var_03;
	}
	else if(level.killstreakrewards && var_02 > var_03 && self.streaktype == "specialist")
	{
		var_04 = var_03;
		if(isai(self))
		{
			var_04 = self.pers["specialistStreakKills"][2];
		}

		var_05 = castint(max(8,var_04 + 2));
		if(maps\mp\_utility::_hasperk("specialty_hardline"))
		{
			var_05--;
		}

		var_06 = var_02 >= var_05 && self getcommonplayerdata("killstreaksState","hasStreak",4) == 0;
		if(var_06)
		{
			givebonusperks();
			func_87B3("all_perks_bonus",1);
			thread maps\mp\gametypes\_hud_message::func_4B46("all_perks_bonus",var_05);
			self setcommonplayerdata("killstreaksState","hasStreak",4,1);
			self.pers["killstreaks"][4].available = 1;
		}

		if(var_03 > 0 && !var_02 - var_03 % 2)
		{
			thread maps\mp\gametypes\_rank::func_8E6E("specialist_streaking_xp");
			thread maps\mp\gametypes\_rank::giverankxp("kill");
		}
	}

	func_6FD6(var_02);
	checkstreakreward();
	if(var_01 == var_03 && self.streaktype != "specialist")
	{
		func_6FD6(0);
	}
}

//Function Number: 59
givebonusperks()
{
	if(isai(self))
	{
		if(isdefined(self.pers) && isdefined(self.pers["specialistBonusStreaks"]))
		{
			foreach(var_01 in self.pers["specialistBonusStreaks"])
			{
				if(!maps\mp\_utility::_hasperk(var_01))
				{
					maps\mp\_utility::func_3CFB(var_01,0);
				}
			}
		}
	}

	for(var_03 = 0;var_03 < 7;var_03++)
	{
		for(var_04 = 0;var_04 < 5;var_04++)
		{
			var_05 = 0;
			if(isdefined(self.teamname))
			{
				var_05 = getmatchrulesdata("defaultClasses",self.teamname,self.class_num,"class","specialistBonusStreaks",var_03,var_04);
			}
			else
			{
				var_05 = self getcacplayerdata("loadouts",self.class_num,"specialistBonusStreaks",var_03,var_04);
			}

			if(isdefined(var_05) && var_05)
			{
				var_01 = tablelookup("mp/cacAbilityTable.csv",0,var_03 + 1,4 + var_04);
				if(!maps\mp\_utility::_hasperk(var_05))
				{
					maps\mp\_utility::func_3CFB(var_05,0);
				}
			}
		}
	}
}

//Function Number: 60
func_6604()
{
	self.earnedstreaklevel = 0;
	func_6FD6(0);
	func_661D();
	self.pers["lastEarnedStreak"] = undefined;
	self.pers["objectivePointStreak"] = 0;
	self setclientomnvar("ui_half_tick",0);
}

//Function Number: 61
func_6FD6(param_00)
{
	if(param_00 < 0)
	{
		param_00 = 0;
	}

	if(isdefined(self.adrenaline))
	{
		self.previousadrenaline = self.adrenaline;
	}
	else
	{
		self.previousadrenaline = 0;
	}

	self.adrenaline = param_00;
	self setclientdvar("ui_adrenaline",self.adrenaline);
	updatestreakcount();
}

//Function Number: 62
func_5B73()
{
	self endon("death");
	self endon("disconnect");
	level endon("game_ended");
	var_00 = common_scripts\utility::func_4828();
	for(;;)
	{
		if(var_00 != common_scripts\utility::func_4828())
		{
			var_00 = common_scripts\utility::func_4828();
			if(!var_00)
			{
				if(isdefined(self.actionslotenabled))
				{
					for(var_01 = 0;var_01 < 4;var_01++)
					{
						self.actionslotenabled[var_01] = 1;
					}

					self notifyonplayercommand("streakUsed1","+actionslot 4");
					self notifyonplayercommand("streakUsed2","+actionslot 5");
					self notifyonplayercommand("streakUsed3","+actionslot 6");
					self notifyonplayercommand("streakUsed4","+actionslot 7");
					func_3CFA();
				}
			}
			else
			{
				var_02 = self getweaponslistitems();
				foreach(var_04 in var_02)
				{
					if(maps\mp\_utility::func_48F7(var_04) && var_04 == self getcurrentweapon())
					{
						self switchtoweapon(common_scripts\utility::func_3B0A());
						while(maps\mp\_utility::func_4899())
						{
							wait(0.05);
						}
					}

					if(maps\mp\_utility::func_48F7(var_04))
					{
						self takeweapon(var_04);
					}
				}

				for(var_01 = 0;var_01 < 4;var_01++)
				{
					maps\mp\_utility::_setactionslot(var_01 + 4,"");
					self.actionslotenabled[var_01] = 0;
				}

				self notifyonplayercommand("toggled_up","+actionslot 1");
				self notifyonplayercommand("toggled_down","+actionslot 2");
				self notifyonplayercommand("streakUsed","+actionslot 4");
				self notifyonplayercommand("streakUsed","+actionslot 5");
				self notifyonplayercommand("streakUsed","+actionslot 6");
				self notifyonplayercommand("streakUsed","+actionslot 7");
				func_3CFA();
			}
		}

		wait(0.05);
	}
}

//Function Number: 63
func_5B74()
{
	self endon("death");
	self endon("disconnect");
	level endon("game_ended");
	self.actionslotenabled = [];
	self.actionslotenabled[0] = 1;
	self.actionslotenabled[1] = 1;
	self.actionslotenabled[2] = 1;
	self.actionslotenabled[3] = 1;
	for(;;)
	{
		var_00 = common_scripts\utility::func_8B33("streakUsed1","streakUsed2","streakUsed3","streakUsed4");
		if(common_scripts\utility::func_4828())
		{
			continue;
		}

		if(!isdefined(var_00))
		{
			continue;
		}

		if(self.streaktype == "specialist" && var_00 != "streakUsed1")
		{
			continue;
		}

		if(isdefined(self.changingweapon) && self.changingweapon == "none")
		{
			continue;
		}

		if(self setmissileminimapvisible())
		{
			continue;
		}

		switch(var_00)
		{
			case "streakUsed1":
				if(self.pers["killstreaks"][0].available && self.actionslotenabled[0])
				{
					self.killstreakindexweapon = 0;
				}
				break;
	
			case "streakUsed2":
				if(self.pers["killstreaks"][1].available && self.actionslotenabled[1])
				{
					self.killstreakindexweapon = 1;
				}
				break;
	
			case "streakUsed3":
				if(self.pers["killstreaks"][2].available && self.actionslotenabled[2])
				{
					self.killstreakindexweapon = 2;
				}
				break;
	
			case "streakUsed4":
				if(self.pers["killstreaks"][3].available && self.actionslotenabled[3])
				{
					self.killstreakindexweapon = 3;
				}
				break;
		}

		if(isdefined(self.killstreakindexweapon) && !self.pers["killstreaks"][self.killstreakindexweapon].available)
		{
			self.killstreakindexweapon = undefined;
		}

		if(isdefined(self.killstreakindexweapon))
		{
			func_27B2();
			for(;;)
			{
				self waittill("weapon_change",var_01,var_02);
				if(isdefined(self.killstreakindexweapon))
				{
					var_03 = maps\mp\_utility::getkillstreakweapon(self.pers["killstreaks"][self.killstreakindexweapon].streakname);
					if(var_01 == var_03 || var_01 == "none" || var_03 == "killstreak_uav_mp" && var_01 == "killstreak_remote_uav_mp" || var_03 == "killstreak_uav_mp" && var_01 == "uav_remote_mp" || var_02)
					{
						continue;
					}

					break;
				}

				break;
			}

			func_2CE8();
			self.killstreakindexweapon = undefined;
		}
	}
}

//Function Number: 64
func_27B2()
{
	for(var_00 = 0;var_00 < 4;var_00++)
	{
		if(!isdefined(self.killstreakindexweapon))
		{
			break;
		}

		if(self.killstreakindexweapon == var_00)
		{
			continue;
		}

		maps\mp\_utility::_setactionslot(var_00 + 4,"");
		self.actionslotenabled[var_00] = 0;
	}
}

//Function Number: 65
func_2CE8()
{
	for(var_00 = 0;var_00 < 4;var_00++)
	{
		if(self.pers["killstreaks"][var_00].available)
		{
			var_01 = maps\mp\_utility::getkillstreakweapon(self.pers["killstreaks"][var_00].streakname);
			maps\mp\_utility::_setactionslot(var_00 + 4,"weapon",var_01);
		}
		else
		{
			maps\mp\_utility::_setactionslot(var_00 + 4,"");
		}

		self.actionslotenabled[var_00] = 1;
	}
}

//Function Number: 66
func_4B39(param_00,param_01,param_02)
{
	if(isdefined(param_01) && isplayer(param_00) && isdefined(param_02.owner) && isdefined(param_02.owner.team))
	{
		if(((level.teambased && param_02.owner.team != param_00.team) || !level.teambased) && param_00 != param_02.owner)
		{
			if(maps\mp\_utility::func_48F7(param_01))
			{
			}

			if(!isdefined(param_00.lasthittime[param_01]))
			{
				param_00.lasthittime[param_01] = 0;
			}

			if(param_00.lasthittime[param_01] == gettime())
			{
			}

			param_00.lasthittime[param_01] = gettime();
			param_00 thread maps\mp\gametypes\_gamelogic::func_8091(param_01,1,"hits");
			if(!getactiveclientcount())
			{
				var_03 = param_00 maps\mp\gametypes\_persistence::statgetbuffered("totalShots");
				var_04 = param_00 maps\mp\gametypes\_persistence::statgetbuffered("hits") + 1;
				if(var_04 <= var_03)
				{
					param_00 maps\mp\gametypes\_persistence::func_7B27("hits",var_04);
					param_00 maps\mp\gametypes\_persistence::func_7B27("misses",castint(var_03 - var_04));
					param_00 maps\mp\gametypes\_persistence::func_7B27("accuracy",castint(var_04 * 10000 / var_03));
				}
			}
		}
	}
}

//Function Number: 67
copy_killstreak_status(param_00,param_01)
{
	self.streaktype = param_00.streaktype;
	self.pers["cur_kill_streak"] = param_00.pers["cur_kill_streak"];
	maps\mp\gametypes\_persistence::func_7B28("round","killStreak",self.pers["cur_kill_streak"]);
	self.pers["killstreaks"] = param_00.pers["killstreaks"];
	self.killstreaks = param_00.killstreaks;
	if(!isdefined(param_01) || param_01 == 0)
	{
		var_02 = getentarray();
		foreach(var_04 in var_02)
		{
			if(!isdefined(var_04) || isplayer(var_04))
			{
				continue;
			}

			if(isdefined(var_04.owner) && var_04.owner == param_00)
			{
				if(var_04.classname == "misc_turret")
				{
					var_04 maps\mp\killstreaks\_autosentry::func_6DEF(self);
					continue;
				}

				var_04.owner = self;
			}
		}
	}

	self.adrenaline = undefined;
	func_6FD6(param_00.adrenaline);
	func_661D();
	updatestreakcount();
	if(isdefined(param_01) && param_01 == 1 && isdefined(self.killstreaks))
	{
		var_06 = 1;
		foreach(var_08 in self.killstreaks)
		{
			var_09 = self.pers["killstreaks"][var_06].streakname;
			if(self.streaktype == "specialist")
			{
				var_0A = strtok(self.pers["killstreaks"][var_06].streakname,"_");
				if(var_0A[var_0A.size - 1] == "ks")
				{
					var_0B = undefined;
					foreach(var_0D in var_0A)
					{
						if(var_0D != "ks")
						{
							if(!isdefined(var_0B))
							{
								var_0B = var_0D;
								continue;
							}

							var_0B = var_0B + "_" + var_0D;
						}
					}

					if(maps\mp\_utility::func_4971(self.pers["killstreaks"][var_06].streakname,"_"))
					{
						var_0B = "_" + var_0B;
					}

					if(isdefined(var_0B) && maps\mp\gametypes\_class::getperkupgrade(var_0B) != "specialty_null")
					{
						var_09 = self.pers["killstreaks"][var_06].streakname + "_pro";
					}
				}
			}

			self setcommonplayerdata("killstreaksState","icons",var_06,maps\mp\_utility::func_3AFB(var_09));
			var_06++;
		}
	}

	updatestreakslots();
	foreach(var_0B in param_00.perksperkname)
	{
		if(!maps\mp\_utility::_hasperk(var_0B))
		{
			var_11 = 0;
			if(isdefined(self.perksuseslot[var_0B]))
			{
				var_11 = self.perksuseslot[var_0B];
			}

			maps\mp\_utility::func_3CFB(var_0B,var_11);
		}

		if(!isdefined(param_01) || param_01 == 0)
		{
			param_00 maps\mp\_utility::_unsetperk(var_0B);
		}
	}
}

//Function Number: 68
copy_adrenaline(param_00)
{
	self.adrenaline = undefined;
	func_6FD6(param_00.adrenaline);
	func_661D();
	updatestreakcount();
	updatestreakslots();
}

//Function Number: 69
func_484F()
{
	var_00 = self getcurrentweapon();
	var_01 = issubstr(var_00,"killstreak") || isdefined(self.selectinglocation) && self.selectinglocation == 1 || !common_scripts\utility::func_49B6() && !maps\mp\gametypes\_damage::attackerinremotekillstreak();
	return var_01;
}

//Function Number: 70
func_537F()
{
	while(isdefined(self))
	{
		if(maps\mp\_utility::bot_is_fireteam_mode())
		{
			self waittill("disconnect");
			continue;
		}

		common_scripts\utility::func_8B2A("disconnect","joined_team","joined_spectators");
		self notify("killstreak_disowned");
	}
}

//Function Number: 71
func_3292(param_00,param_01,param_02,param_03)
{
	var_04 = rotatevector((0,0,1),(-1 * param_03,0,0));
	var_05 = vectortoangles(param_01 - param_00.origin);
	for(var_06 = 0;var_06 < 360;var_06 = var_06 + 30)
	{
		var_07 = param_02 * rotatevector(var_04,(0,var_06 + var_05[1],0));
		var_08 = param_01 + var_07;
		if(_findunobstructedfiringpointhelper(param_00,var_08,param_01))
		{
			return var_08;
		}
	}

	return undefined;
}

//Function Number: 72
func_3291(param_00,param_01,param_02,param_03,param_04,param_05)
{
	var_06 = vectortoangles(param_00.origin - param_01);
	for(var_07 = param_03;var_07 <= param_04;var_07 = var_07 + param_05)
	{
		var_08 = rotatevector((1,0,0),(var_07 - 90,0,0));
		var_09 = param_02 * rotatevector(var_08,(0,var_06[1],0));
		var_0A = param_01 + var_09;
		if(_findunobstructedfiringpointhelper(param_00,var_0A,param_01))
		{
			return var_0A;
		}
	}

	return undefined;
}

//Function Number: 73
_findunobstructedfiringpointhelper(param_00,param_01,param_02)
{
	var_03 = bullettrace(param_01,param_02,0);
	if(var_03["fraction"] > 0.99)
	{
		return 1;
	}

	return 0;
}

//Function Number: 74
findunobstructedfiringpoint(param_00,param_01,param_02)
{
	var_03 = func_3292(param_00,param_01,param_02,30);
	if(!isdefined(var_03))
	{
		var_03 = func_3291(param_00,param_01,param_02,15,75,15);
	}

	return var_03;
}

//Function Number: 75
isairdropmarker(param_00)
{
	switch(param_00)
	{
		case "airdrop_escort_marker_mp":
		case "airdrop_tank_marker_mp":
		case "airdrop_juggernaut_maniac_mp":
		case "airdrop_juggernaut_def_mp":
		case "airdrop_sentry_marker_mp":
		case "airdrop_mega_marker_mp":
		case "airdrop_marker_support_mp":
		case "airdrop_marker_assault_mp":
		case "airdrop_juggernaut_mp":
		case "airdrop_marker_mp":
			return 1;

		default:
			return 0;
	}
}

//Function Number: 76
func_4994()
{
	return isdefined(self.onhelisniper) && self.onhelisniper;
}

//Function Number: 77
destroytargetarray(param_00,param_01,param_02,param_03)
{
	var_04 = "MOD_EXPLOSIVE";
	var_05 = 5000;
	var_06 = (0,0,0);
	var_07 = (0,0,0);
	var_08 = "";
	var_09 = "";
	var_0A = "";
	var_0B = undefined;
	if(level.teambased)
	{
		foreach(var_0D in param_03)
		{
			if(maps\mp\_utility::func_49AB(param_00,param_01,var_0D))
			{
				var_0D notify("damage",var_05,param_00,var_06,var_07,var_04,var_08,var_09,var_0A,var_0B,param_02);
				wait(0.05);
			}
		}
	}

	foreach(var_0D in var_04)
	{
		if(maps\mp\_utility::isvalidffatarget(param_00,param_01,var_0D))
		{
			var_0D notify("damage",var_05,param_00,var_06,var_07,var_04,var_08,var_09,var_0A,var_0B,param_02);
			wait(0.05);
		}
	}
}