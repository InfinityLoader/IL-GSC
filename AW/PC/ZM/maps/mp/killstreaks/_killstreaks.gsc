/*******************************************************************
 * Decompiled By: Bog
 * Decompiled File: maps/mp/killstreaks/_killstreaks.gsc
 * Game: Call of Duty: Advanced Warfare
 * Platform: PC
 * Function Count: 79
 * Decompile Time: 1227 ms
 * Timestamp: 10/27/2023 2:09:36 AM
*******************************************************************/

//Function Number: 1
onplayerconnect()
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

		var_00.spupdatetotal = 0;
		if(getdvarint("virtualLobbyActive",0))
		{
			return;
		}

		var_00 thread onplayerspawned();
	}
}

//Function Number: 2
onplayerspawned()
{
	self endon("disconnect");
	for(;;)
	{
		common_scripts\utility::waittill_any("spawned_player","faux_spawn");
		thread killstreakusewaiter();
		thread streaknotifytracker();
		thread waitforchangeteam();
		thread streakselectuptracker();
		thread streakselectdowntracker();
		if(!level.console)
		{
			thread pc_watchstreakuse();
		}

		if(!isdefined(self.pers["killstreaks"][0]))
		{
			initplayerkillstreaks();
		}

		if(!isdefined(self.earnedstreaklevel))
		{
			self.earnedstreaklevel = 0;
		}

		if(!isdefined(self.adrenaline) || self.adrenaline == 0)
		{
			self.adrenaline = self.pers["ks_totalPoints"];
			self.adrenalinesupport = self.pers["ks_totalPointsSupport"];
			updatestreakcount();
			for(var_00 = 0;var_00 < level.killstreak_stacking_start_slot;var_00++)
			{
				var_01 = self.pers["killstreaks"][var_00].streakname;
				var_02 = self.pers["killstreaks"][var_00].available;
				if(isdefined(var_01))
				{
					if(var_00 == level.killstreak_gimme_slot && !isdefined(var_02) || !var_02)
					{
						continue;
					}

					var_03 = maps\mp\_utility::getkillstreakindex(self.pers["killstreaks"][var_00].streakname);
					var_04 = "ks_icon" + common_scripts\utility::tostring(var_00);
					self setclientomnvar(var_04,var_03);
				}
			}

			updatestreakicons(0);
		}

		updatestreakslots();
		giveownedkillstreakitem();
		updatestreakcount();
	}
}

//Function Number: 3
updatestreakicons(param_00)
{
	for(var_01 = 0;var_01 < level.killstreak_stacking_start_slot;var_01++)
	{
		if(!param_00 && var_01 == level.killstreak_gimme_slot)
		{
			continue;
		}

		var_02 = "ks_icon" + common_scripts\utility::tostring(var_01);
		self setclientomnvar(var_02,0);
		var_03 = self getclientomnvar("ks_hasStreak");
		var_04 = var_03 & ~1 << var_01 & ~1 << var_01 + level.killstreak_stacking_start_slot;
		self setclientomnvar("ks_hasStreak",var_04);
	}

	var_05 = 1;
	if(isdefined(self.killstreaks))
	{
		foreach(var_07 in self.killstreaks)
		{
			var_08 = self.pers["killstreaks"][var_05];
			var_08.streakname = var_07;
			var_09 = var_08.streakname;
			var_02 = "ks_icon" + common_scripts\utility::tostring(var_05);
			self setclientomnvar(var_02,maps\mp\_utility::getkillstreakindex(var_09));
			var_03 = self getclientomnvar("ks_hasStreak");
			var_04 = var_03 & ~1 << var_05;
			if(issupportstreak(self,var_07))
			{
				var_04 = var_04 | 1 << var_05 + level.killstreak_stacking_start_slot;
			}
			else
			{
				var_04 = var_04 & ~1 << var_05 + level.killstreak_stacking_start_slot;
			}

			self setclientomnvar("ks_hasStreak",var_04);
			var_05++;
		}
	}
}

//Function Number: 4
initplayerkillstreaks()
{
	var_00 = spawnstruct();
	var_00.available = 0;
	var_00.streakname = undefined;
	var_00.earned = 0;
	var_00.awardxp = undefined;
	var_00.owner = undefined;
	var_00.kid = undefined;
	var_00.lifeid = undefined;
	var_00.isgimme = 1;
	var_00.nextslot = undefined;
	self.pers["killstreaks"][level.killstreak_gimme_slot] = var_00;
	for(var_01 = level.killstreak_slot_1;var_01 < level.killstreak_stacking_start_slot;var_01++)
	{
		var_02 = spawnstruct();
		var_02.available = 0;
		var_02.streakname = undefined;
		var_02.earned = 1;
		var_02.awardxp = 1;
		var_02.owner = undefined;
		var_02.kid = undefined;
		var_02.lifeid = -1;
		var_02.isgimme = 0;
		self.pers["killstreaks"][var_01] = var_02;
	}

	updatestreakicons(1);
	self setclientomnvar("ks_selectedIndex",-1);
	var_03 = self getclientomnvar("ks_hasStreak");
	var_04 = var_03 & ~1 << level.killstreak_stacking_start_slot;
	self setclientomnvar("ks_hasStreak",var_04);
}

//Function Number: 5
issupportstreak(param_00,param_01)
{
	var_02 = getarraykeys(self.killstreakmodules);
	foreach(var_04 in var_02)
	{
		var_05 = getstreakmodulebasekillstreak(var_04);
		if(var_05 == param_01)
		{
			var_06 = tablelookup(level.ks_modules_table,level.ks_module_ref_column,var_04,level.ks_module_support_column);
			if(isdefined(var_06) && var_06 != "" && var_06 != "0")
			{
				return 1;
			}
		}
	}

	return 0;
}

//Function Number: 6
updatestreakcount()
{
	if(!isdefined(self.pers["killstreaks"]))
	{
		for(var_00 = level.killstreak_slot_1;var_00 < level.killstreak_stacking_start_slot;var_00++)
		{
			self setclientomnvar("ks_count" + common_scripts\utility::tostring(var_00),0);
		}

		self setclientomnvar("ks_count_updated",1);
		return;
	}

	for(var_00 = level.killstreak_slot_1;var_00 < level.killstreak_stacking_start_slot;var_00++)
	{
		var_01 = self.pers["killstreaks"][var_00].streakname;
		var_02 = "ks_count" + common_scripts\utility::tostring(var_00);
		var_03 = "ks_points" + common_scripts\utility::tostring(var_00);
		if(!isdefined(var_01))
		{
			self setclientomnvar(var_02,0);
			continue;
		}

		var_04 = getstreakcost(self.pers["killstreaks"][var_00].streakname);
		if(issupportstreak(self,var_01))
		{
			var_05 = self.adrenalinesupport / var_04;
			var_06 = var_04 - self.adrenalinesupport;
		}
		else
		{
			var_05 = self.adrenaline / var_04;
			var_06 = var_04 - self.adrenaline;
		}

		if(var_05 >= 1)
		{
			var_05 = 0;
			var_06 = var_04;
		}

		self setclientomnvar(var_03,var_06);
		self setclientomnvar(var_02,var_05);
	}

	self setclientomnvar("ks_count_updated",1);
}

//Function Number: 7
getmaxstreakcost(param_00)
{
	if(!isdefined(self.killstreaks))
	{
		return 0;
	}

	var_01 = 0;
	foreach(var_03 in self.killstreaks)
	{
		var_04 = issupportstreak(self,var_03);
		if((param_00 && !var_04) || !param_00 && var_04)
		{
			continue;
		}

		var_05 = getstreakcost(var_03);
		if(var_05 > var_01)
		{
			var_01 = var_05;
		}
	}

	return var_01;
}

//Function Number: 8
updatestreakslots()
{
	if(!maps\mp\_utility::isreallyalive(self))
	{
		return;
	}

	var_00 = self.pers["killstreaks"];
	var_01 = 0;
	for(var_02 = 0;var_02 < level.killstreak_stacking_start_slot;var_02++)
	{
		if(isdefined(var_00[var_02]) && isdefined(var_00[var_02].streakname))
		{
			var_03 = self getclientomnvar("ks_hasStreak");
			if(var_00[var_02].available == 1)
			{
				var_04 = var_03 | 1 << var_02;
			}
			else
			{
				var_04 = var_04 & ~1 << var_03;
			}

			self setclientomnvar("ks_hasStreak",var_04);
			if(var_00[var_02].available == 1)
			{
				var_01++;
			}
		}
	}

	if(isdefined(self.killstreakindexweapon))
	{
		self setclientomnvar("ks_selectedIndex",self.killstreakindexweapon);
		return;
	}

	self setclientomnvar("ks_selectedIndex",-1);
}

//Function Number: 9
waitforchangeteam()
{
	self endon("disconnect");
	self endon("faux_spawn");
	self notify("waitForChangeTeam");
	self endon("waitForChangeTeam");
	for(;;)
	{
		self waittill("joined_team");
		clearkillstreaks(1);
	}
}

//Function Number: 10
killstreakusepressed()
{
	var_00 = self.pers["killstreaks"];
	var_01 = var_00[self.killstreakindexweapon].streakname;
	var_02 = var_00[self.killstreakindexweapon].lifeid;
	var_03 = var_00[self.killstreakindexweapon].earned;
	var_04 = var_00[self.killstreakindexweapon].awardxp;
	var_05 = var_00[self.killstreakindexweapon].kid;
	var_06 = var_00[self.killstreakindexweapon].isgimme;
	var_07 = var_00[self.killstreakindexweapon].modules;
	var_08 = undefined;
	var_09 = undefined;
	var_0A = undefined;
	if(self.killstreakindexweapon == level.killstreak_gimme_slot)
	{
		var_09 = var_00[level.killstreak_gimme_slot].nextslot;
	}

	if(!maps\mp\_utility::validateusestreak(var_01))
	{
		return 0;
	}

	var_0B = 0;
	if(maps\mp\_utility::_hasperk("specialty_explosivebullets") && !issubstr(var_01,"explosive_ammo"))
	{
		var_0B = 1;
	}

	if(issubstr(var_01,"airdrop"))
	{
		if(!self [[ level.killstreakfuncs[var_01] ]](var_02,var_05,var_07))
		{
			return 0;
		}
	}
	else if(!self [[ level.killstreakfuncs[var_01] ]](var_02,var_07))
	{
		return 0;
	}

	if(var_0B)
	{
		maps\mp\_utility::_unsetperk("specialty_explosivebullets");
	}

	if(isdefined(var_09) && var_01 != var_00[self.killstreakindexweapon].streakname)
	{
		var_0A = 1;
		var_08 = var_09;
	}

	thread updatekillstreaks(var_0A,var_08);
	usedkillstreak(var_01,var_07,var_04);
	return 1;
}

//Function Number: 11
usedkillstreak(param_00,param_01,param_02)
{
	maps\mp\_utility::incplayerstat("killStreaksUsed",1);
	if(param_02)
	{
		thread maps\mp\gametypes\_missions::usehardpoint(param_00);
	}

	var_03 = self.team;
	var_04 = var_03 + "_friendly_" + param_00 + "_inbound";
	var_05 = var_03 + "_enemy_" + param_00 + "_inbound";
	if(param_00 == "emp")
	{
		var_06 = maps\mp\killstreaks\_emp::getmodulelineemp(param_01);
		var_04 = var_04 + var_06;
		var_05 = var_05 + var_06;
	}

	if(level.teambased)
	{
		thread maps\mp\_utility::leaderdialog(var_04,var_03);
		if(getkillstreakinformenemy(param_00))
		{
			thread maps\mp\_utility::leaderdialog(var_05,level.otherteam[var_03]);
		}
	}
	else
	{
		thread maps\mp\_utility::leaderdialogonplayer(var_04);
		if(getkillstreakinformenemy(param_00))
		{
			var_07[0] = self;
			thread maps\mp\_utility::leaderdialog(var_05,undefined,undefined,var_07);
		}
	}

	if(isdefined(level.mapkillstreak))
	{
		if(param_00 == level.mapkillstreak)
		{
			var_08 = getmatchdata("players",self.clientid,"numberOfMapstreaksUsed");
			var_08++;
			setmatchdata("players",self.clientid,"numberOfMapstreaksUsed",maps\mp\_utility::clamptobyte(var_08));
		}
	}
}

//Function Number: 12
updatekillstreaks(param_00,param_01)
{
	if(!isdefined(param_00))
	{
		self.pers["killstreaks"][self.killstreakindexweapon].available = 0;
		if(self.killstreakindexweapon == level.killstreak_gimme_slot)
		{
			self.pers["killstreaks"][self.pers["killstreaks"][level.killstreak_gimme_slot].nextslot] = undefined;
			var_02 = undefined;
			var_03 = undefined;
			var_04 = self.pers["killstreaks"];
			for(var_05 = level.killstreak_stacking_start_slot;var_05 < var_04.size;var_05++)
			{
				if(!isdefined(var_04[var_05]) || !isdefined(var_04[var_05].streakname))
				{
					continue;
				}

				var_02 = var_04[var_05].streakname;
				if(isdefined(var_04[var_05].modules))
				{
					var_03 = var_04[var_05].modules;
				}

				var_04[level.killstreak_gimme_slot].nextslot = var_05;
			}

			if(isdefined(var_02))
			{
				var_04[level.killstreak_gimme_slot].available = 1;
				var_04[level.killstreak_gimme_slot].streakname = var_02;
				if(isdefined(var_03))
				{
					var_04[level.killstreak_gimme_slot].modules = var_03;
				}

				var_06 = maps\mp\_utility::getkillstreakindex(var_02);
				var_07 = "ks_icon" + common_scripts\utility::tostring(level.killstreak_gimme_slot);
				self setclientomnvar(var_07,var_06);
				if(!level.console && !common_scripts\utility::is_player_gamepad_enabled())
				{
					var_08 = maps\mp\_utility::getkillstreakweapon(var_02,var_03);
					maps\mp\_utility::_setactionslot(4,"weapon",var_08);
				}
			}
			else
			{
				var_07 = "ks_icon" + common_scripts\utility::tostring(level.killstreak_gimme_slot);
				self setclientomnvar(var_07,0);
			}
		}
	}

	if(isdefined(param_01))
	{
		self.pers["killstreaks"][param_01] = undefined;
	}

	var_09 = undefined;
	for(var_05 = 0;var_05 < level.killstreak_stacking_start_slot;var_05++)
	{
		var_0A = self.pers["killstreaks"][var_05];
		if(isdefined(var_0A) && isdefined(var_0A.streakname) && var_0A.available)
		{
			var_09 = var_05;
		}
	}

	if(isdefined(var_09))
	{
		if(level.console || common_scripts\utility::is_player_gamepad_enabled())
		{
			self.killstreakindexweapon = var_09;
			self.pers["lastEarnedStreak"] = self.pers["killstreaks"][var_09].streakname;
			giveselectedkillstreakitem();
		}
		else
		{
			for(var_05 = 0;var_05 < level.killstreak_stacking_start_slot;var_05++)
			{
				var_0A = self.pers["killstreaks"][var_05];
				if(isdefined(var_0A) && isdefined(var_0A.streakname) && var_0A.available)
				{
					var_08 = maps\mp\_utility::getkillstreakweapon(var_0A.streakname,var_0A.modules);
					var_0B = self getweaponslistitems();
					var_0C = 0;
					for(var_0D = 0;var_0D < var_0B.size;var_0D++)
					{
						if(var_08 == var_0B[var_0D])
						{
							var_0C = 1;
							break;
						}
					}

					if(!var_0C)
					{
						maps\mp\_utility::_giveweapon(var_08);
					}
					else if(issubstr(var_08,"airdrop_"))
					{
						self setweaponammoclip(var_08,1);
					}

					maps\mp\_utility::_setactionslot(var_05 + 4,"weapon",var_08);
				}
			}

			self.killstreakindexweapon = undefined;
			self.pers["lastEarnedStreak"] = self.pers["killstreaks"][var_09].streakname;
			updatestreakslots();
		}
	}
	else
	{
		self.killstreakindexweapon = undefined;
		self.pers["lastEarnedStreak"] = undefined;
		updatestreakslots();
	}

	self setclientomnvar("ks_used",1);
}

//Function Number: 13
clearkillstreaks(param_00)
{
	if(!isdefined(param_00))
	{
		param_00 = 1;
	}

	var_01 = self.pers["killstreaks"];
	if(!isdefined(var_01))
	{
		return;
	}

	for(var_02 = var_01.size - 1;var_02 > -1;var_02--)
	{
		self.pers["killstreaks"][var_02] = undefined;
	}

	initplayerkillstreaks();
	resetadrenaline(param_00);
	self.killstreakindexweapon = undefined;
	updatestreakslots();
}

//Function Number: 14
getfirstprimaryweapon()
{
	var_00 = self getweaponslistprimaries();
	return var_00[0];
}

//Function Number: 15
istryingtousekillstreakslot()
{
	return isdefined(self.tryingtouseks) && self.tryingtouseks && isdefined(self.killstreakindexweapon);
}

//Function Number: 16
waitforkillstreakweaponswitchstarted()
{
	self endon("weapon_switch_invalid");
	self waittill("weapon_switch_started",var_00);
	self notify("killstreak_weapon_change","switch_started",var_00);
}

//Function Number: 17
waitforkillstreakweaponswitchinvalid()
{
	self endon("weapon_switch_started");
	self waittill("weapon_switch_invalid",var_00);
	self notify("killstreak_weapon_change","switch_invalid",var_00);
}

//Function Number: 18
waitforkillstreakweaponchange()
{
	childthread waitforkillstreakweaponswitchstarted();
	childthread waitforkillstreakweaponswitchinvalid();
	self waittill("killstreak_weapon_change",var_00,var_01);
	if(var_00 == "switch_started")
	{
		return var_01;
	}

	var_02 = maps\mp\_utility::getkillstreakweapon(self.pers["killstreaks"][self.killstreakindexweapon].streakname,self.pers["killstreaks"][self.killstreakindexweapon].modules);
	self switchtoweapon(var_02);
	self waittill("weapon_switch_started",var_03);
	if(var_03 != var_02)
	{
		return undefined;
	}

	return var_02;
}

//Function Number: 19
updateaerialkillstreakmarker()
{
	foreach(var_01 in level.players)
	{
		var_01 notify("updateKillStreakMarker");
	}
}

//Function Number: 20
aerialkillstreakmarker()
{
	self endon("disconnect");
	self endon("finish_death");
	self endon("joined_team");
	self endon("faux_spawn");
	level endon("game_ended");
	var_00 = maps\mp\gametypes\_gameobjects::getenemyteam(self.team);
	for(;;)
	{
		common_scripts\utility::waittill_any("weapon_change","updateKillStreakMarker");
		var_01 = self getcurrentweapon();
		var_02 = weaponclass(var_01);
		if(var_02 != "rocketlauncher")
		{
			continue;
		}

		var_03 = [];
		var_03 = getaerialkillstreakarray(var_00);
		if(var_03.size == 0)
		{
			continue;
		}

		foreach(var_05 in var_03)
		{
			createthreaticon(var_05,self);
		}
	}
}

//Function Number: 21
getaerialkillstreakarray(param_00)
{
	var_01 = [];
	var_02 = [];
	if(maps\mp\_utility::invirtuallobby())
	{
		return var_01;
	}

	if(level.teambased)
	{
		var_02 = level.uavmodels[param_00];
	}
	else
	{
		var_02 = level.uavmodels;
	}

	foreach(var_04 in var_02)
	{
		if(isdefined(var_04.isleaving) && var_04.isleaving)
		{
			continue;
		}

		if(isdefined(var_04.orbit) && var_04.orbit)
		{
			continue;
		}

		var_01[var_01.size] = var_04;
	}

	foreach(var_07 in level.planes)
	{
		if(!level.teambased || var_07.team == param_00)
		{
			var_01[var_01.size] = var_07;
		}
	}

	if(level.orbitalsupportinuse && isdefined(level.orbitalsupport_planemodel) && isdefined(level.orbitalsupport_planemodel.owner) && isdefined(level.orbitalsupport_planemodel.showthreatmarker) && level.orbitalsupport_planemodel.showthreatmarker)
	{
		if(level.teambased && level.orbitalsupport_planemodel.owner.team == param_00)
		{
			var_01[var_01.size] = level.orbitalsupport_planemodel;
		}

		if(!level.teambased)
		{
			var_01[var_01.size] = level.orbitalsupport_planemodel;
		}
	}

	if(isdefined(level.getaerialkillstreakarray))
	{
		var_09 = [[ level.getaerialkillstreakarray ]](param_00);
		foreach(var_0B in var_09)
		{
			var_01[var_01.size] = var_0B;
		}
	}

	return var_01;
}

//Function Number: 22
createthreaticon(param_00,param_01)
{
	if(!isdefined(param_00.waypoint))
	{
		param_00.waypoint = [];
	}

	var_02 = param_01.guid;
	if(isdefined(param_00.waypoint[var_02]))
	{
		return;
	}

	param_00.waypoint[var_02] = newhudelem();
	param_00.waypoint[var_02] setshader("waypoint_threat_hostile",1,1);
	param_00.waypoint[var_02].alpha = 0.75;
	param_00.waypoint[var_02].color = (1,1,1);
	param_00.waypoint[var_02].x = param_00.origin[0];
	param_00.waypoint[var_02].y = param_00.origin[1];
	param_00.waypoint[var_02].z = param_00.origin[2];
	param_00.waypoint[var_02] setwaypoint(1,1,1);
	param_00.waypoint[var_02] settargetent(param_00);
	param_00.waypoint[var_02].showinkillcam = 0;
	param_00.waypoint[var_02].archived = 0;
	level thread removethreaticon(self,param_00,param_00.waypoint[var_02]);
}

//Function Number: 23
removethreaticon(param_00,param_01,param_02)
{
	level endon("game_ended");
	param_00 common_scripts\utility::waittill_any_ents(param_00,"death",param_01,"death",param_00,"weapon_change",param_00,"disconnect",param_01,"leaving");
	param_02 destroy();
}

//Function Number: 24
killstreakusewaiter()
{
	self endon("disconnect");
	self endon("finish_death");
	self endon("joined_team");
	self endon("faux_spawn");
	level endon("game_ended");
	self notify("killstreakUseWaiter");
	self endon("killstreakUseWaiter");
	self.lastkillstreak = 0;
	if(!isdefined(self.pers["lastEarnedStreak"]))
	{
		self.pers["lastEarnedStreak"] = undefined;
	}

	thread finishdeathwaiter();
	if(!isdefined(self.justswitchedtokillstreakweapon))
	{
		self waittill("weapon_change",var_00);
	}
	else
	{
		var_00 = self.justswitchedtokillstreakweapon;
		self.justswitchedtokillstreakweapon = undefined;
	}

	var_01 = maps\mp\_utility::iskillstreakweapon(var_00);
	if(!isalive(self))
	{
		continue;
	}

	if(var_01)
	{
	}

	if(isdefined(self.ball_carried))
	{
		continue;
	}

	if(var_01)
	{
	}

	if(!isdefined(self.killstreakindexweapon))
	{
		if(!level.console)
		{
			if(isdefined(self.lastdroppableweapon) && var_00 == "killstreak_predator_missile_mp")
			{
				self switchtoweapon(self.lastdroppableweapon);
			}
		}

		continue;
	}

	if(var_01)
	{
	}

	if(isdefined(self.manuallyjoiningkillstreak) && self.manuallyjoiningkillstreak)
	{
		continue;
	}

	if(var_01)
	{
	}

	if(isdefined(self.iscarrying) && self.iscarrying)
	{
		continue;
	}

	if(var_01)
	{
	}

	if(!isdefined(self.pers["killstreaks"][self.killstreakindexweapon]) || !isdefined(self.pers["killstreaks"][self.killstreakindexweapon].streakname))
	{
		continue;
	}

	if(var_01)
	{
	}

	var_02 = maps\mp\_utility::getkillstreakweapon(self.pers["killstreaks"][self.killstreakindexweapon].streakname,self.pers["killstreaks"][self.killstreakindexweapon].modules);
	if(var_00 != var_02)
	{
		if(issubstr(var_00,"turrethead"))
		{
			self switchtoweapon(self.lastdroppableweapon);
		}

		if(maps\mp\_utility::isstrstart(var_00,"airdrop_"))
		{
			self takeweapon(var_00);
			self switchtoweapon(self.lastdroppableweapon);
		}

		continue;
	}

	if(var_01)
	{
	}

	waittillframeend;
	var_03 = self.pers["killstreaks"][self.killstreakindexweapon].streakname;
	var_04 = self.pers["killstreaks"][self.killstreakindexweapon].isgimme;
	var_05 = self.pers["killstreaks"][self.killstreakindexweapon].modules;
	var_06 = playergetkillstreaklastweapon();
	var_07 = self.killstreakindexweapon;
	if(shouldswitchweaponafterraiseanimation(var_02))
	{
		childthread switchweaponafterraiseanimation(var_02,var_06);
	}

	var_08 = gettime();
	var_09 = killstreakusepressed();
	var_0A = gettime();
	var_0B = var_0A - var_08 / 1000;
	if(!var_09 && !isalive(self) && !self hasweapon(common_scripts\utility::getlastweapon()))
	{
		var_06 = playergetkillstreaklastweapon(var_09);
		maps\mp\_utility::_giveweapon(var_06);
	}

	if(var_09)
	{
		thread waittakekillstreakweapon(var_02);
	}

	if(shouldswitchweaponpostkillstreak(var_09,var_02,var_03,var_05) && !isdefined(self.justswitchedtokillstreakweapon))
	{
		switch(var_02)
		{
			case "killstreak_predator_missile_mp":
				break;
		}
	}
}

//Function Number: 25
switchweaponafterraiseanimation(param_00,param_01)
{
	switch(param_00)
	{
		case "killstreak_uav_mp":
			break;

		default:
			break;
	}
}

//Function Number: 26
playergetkillstreaklastweapon(param_00)
{
	if((!isdefined(param_00) || isdefined(param_00) && !param_00) && !isalive(self) && !self hasweapon(common_scripts\utility::getlastweapon()))
	{
		return common_scripts\utility::getlastweapon();
	}

	if(!self hasweapon(common_scripts\utility::getlastweapon()))
	{
		return getfirstprimaryweapon();
	}

	return common_scripts\utility::getlastweapon();
}

//Function Number: 27
waittakekillstreakweapon(param_00)
{
	self endon("disconnect");
	self endon("finish_death");
	self endon("joined_team");
	level endon("game_ended");
	self endon("faux_spawn");
	self notify("waitTakeKillstreakWeapon");
	self endon("waitTakeKillstreakWeapon");
	var_01 = self getcurrentweapon() == "none";
	self waittill("weapon_change",var_02);
	var_03 = self getweaponslistprimaries();
	if(common_scripts\utility::array_contains(var_03,var_02))
	{
		takekillstreakweaponifnodupe(param_00);
		if(!level.console && !common_scripts\utility::is_player_gamepad_enabled())
		{
			self.killstreakindexweapon = undefined;
			return;
		}

		return;
	}

	if(var_02 != param_00)
	{
		thread waittakekillstreakweapon(param_00);
		return;
	}

	if(var_01 && self getcurrentweapon() == param_00)
	{
		thread waittakekillstreakweapon(param_00);
		return;
	}
}

//Function Number: 28
takekillstreakweaponifnodupe(param_00)
{
	var_01 = 0;
	var_02 = self.pers["killstreaks"];
	for(var_03 = 0;var_03 < var_02.size;var_03++)
	{
		if(isdefined(var_02[var_03]) && isdefined(var_02[var_03].streakname) && var_02[var_03].available)
		{
			if(param_00 == maps\mp\_utility::getkillstreakweapon(var_02[var_03].streakname,var_02[var_03].modules))
			{
				var_01 = 1;
				break;
			}
		}
	}

	if(var_01)
	{
		if(level.console || common_scripts\utility::is_player_gamepad_enabled())
		{
			if(isdefined(self.killstreakindexweapon) && param_00 != maps\mp\_utility::getkillstreakweapon(var_02[self.killstreakindexweapon].streakname,var_02[self.killstreakindexweapon].modules))
			{
				self takeweapon(param_00);
				return;
			}

			if(isdefined(self.killstreakindexweapon) && param_00 == maps\mp\_utility::getkillstreakweapon(var_02[self.killstreakindexweapon].streakname,var_02[self.killstreakindexweapon].modules))
			{
				self takeweapon(param_00);
				maps\mp\_utility::_giveweapon(param_00,0);
				maps\mp\_utility::_setactionslot(4,"weapon",param_00);
				return;
			}

			return;
		}

		self takeweapon(param_00);
		maps\mp\_utility::_giveweapon(param_00,0);
		return;
	}

	self takeweapon(param_00);
}

//Function Number: 29
shouldswitchweaponpostkillstreak(param_00,param_01,param_02,param_03)
{
	if(shouldswitchweaponafterraiseanimation(param_01))
	{
		return 0;
	}

	if(!param_00)
	{
		return 1;
	}

	switch(param_02)
	{
		case "warbird":
			break;

		case "zm_ugv":
		case "assault_ugv":
			break;
	}
}

//Function Number: 30
shouldswitchweaponafterraiseanimation(param_00)
{
	switch(param_00)
	{
		case "killstreak_uav_mp":
			break;

		default:
			break;
	}
}

//Function Number: 31
finishdeathwaiter()
{
	self endon("disconnect");
	level endon("game_ended");
	self endon("faux_spawn");
	self notify("finishDeathWaiter");
	self endon("finishDeathWaiter");
	self waittill("death");
	wait(0.05);
	self notify("finish_death");
	self.pers["lastEarnedStreak"] = undefined;
}

//Function Number: 32
checkstreakreward()
{
	foreach(var_01 in self.killstreaks)
	{
		var_02 = getstreakcost(var_01);
		var_03 = self.adrenaline;
		var_04 = self.previousadrenaline;
		if(issupportstreak(self,var_01))
		{
			var_03 = self.adrenalinesupport;
			var_04 = self.previousadrenalinesupport;
		}

		if(var_02 > var_03 && var_03 > var_04)
		{
			continue;
		}

		if(var_04 < var_02 && var_03 >= var_02 || var_03 <= var_04)
		{
			earnkillstreak(var_01,var_02);
		}
	}
}

//Function Number: 33
killstreakearned(param_00)
{
	if(isdefined(self.class_num))
	{
		var_01 = self.class_num;
		if(var_01 == -1)
		{
			var_02 = self.pers["copyCatLoadout"]["className"];
			var_01 = maps\mp\_utility::getclassindex(var_02);
			if(issubstr(var_02,"practice"))
			{
				var_01 = self.pers["copyCatLoadout"]["practiceClassNum"];
			}
		}

		if(issubstr(self.class,"custom"))
		{
			if(self getcacplayerdata(var_01,"assaultStreaks",0,"streak") == param_00)
			{
				self.firstkillstreakearned = gettime();
				return;
			}

			if(self getcacplayerdata(var_01,"assaultStreaks",2,"streak") == param_00 && isdefined(self.firstkillstreakearned))
			{
				if(gettime() - self.firstkillstreakearned < 20000)
				{
					thread maps\mp\gametypes\_missions::genericchallenge("wargasm");
					return;
				}

				return;
			}

			return;
		}
	}
}

//Function Number: 34
earnkillstreak(param_00,param_01)
{
	self.earnedstreaklevel = param_01;
	var_02 = getkillstreakmodules(self,param_00);
	var_03 = getnextkillstreakslotindex(param_00,1);
	thread maps\mp\_events::earnedkillstreakevent(param_00,param_01,var_02,var_03);
	thread killstreakearned(param_00);
	self.pers["lastEarnedStreak"] = param_00;
	givekillstreak(param_00,1,1,self,var_02);
	if(maps\mp\_utility::_hasperk("specialty_class_hardline"))
	{
		maps\mp\gametypes\_missions::processchallenge("ch_perk_hardline");
	}
}

//Function Number: 35
getkillstreakmodules(param_00,param_01)
{
	var_02 = [];
	var_03 = getarraykeys(self.killstreakmodules);
	foreach(var_05 in var_03)
	{
		var_06 = getstreakmodulebasekillstreak(var_05);
		if(var_06 == param_01)
		{
			var_02[var_02.size] = var_05;
		}
	}

	return var_02;
}

//Function Number: 36
getnexthordekillstreakslotindex(param_00)
{
	if(!isdefined(param_00))
	{
		param_00 = level.killstreak_gimme_slot;
	}

	return param_00;
}

//Function Number: 37
givehordekillstreak(param_00,param_01,param_02,param_03,param_04)
{
	self endon("givingLoadout");
	if(!isdefined(level.killstreakfuncs[param_00]) || tablelookup(level.killstreak_string_table,1,param_00,0) == "")
	{
		return;
	}

	if(!isdefined(self.pers["killstreaks"]))
	{
		return;
	}

	self endon("disconnect");
	var_05 = undefined;
	var_06 = self.pers["killstreaks"].size;
	if(isdefined(param_03))
	{
		var_06 = param_03;
	}

	if(!isdefined(self.pers["killstreaks"][var_06]))
	{
		self.pers["killstreaks"][var_06] = spawnstruct();
	}

	var_07 = self.pers["killstreaks"][var_06];
	var_07.available = 0;
	var_07.streakname = param_00;
	var_07.earned = 0;
	var_07.awardxp = 0;
	var_07.owner = param_01;
	var_07.kid = self.pers["kID"];
	var_07.lifeid = -1;
	var_07.isgimme = 1;
	var_05 = getnexthordekillstreakslotindex(param_03);
	if(!isdefined(param_02) || !isarray(param_02))
	{
		param_02 = getkillstreakmodules(self,param_00);
	}

	var_07.modules = param_02;
	self.pers["killstreaks"][var_05].nextslot = var_06;
	self.pers["killstreaks"][var_05].streakname = param_00;
	var_08 = maps\mp\_utility::getkillstreakindex(param_00);
	var_09 = "ks_icon" + common_scripts\utility::tostring(var_05);
	self setclientomnvar(var_09,var_08);
	if(!param_04)
	{
		updatestreakslots();
		if(isdefined(level.killstreaksetupfuncs[param_00]))
		{
			self [[ level.killstreaksetupfuncs[param_00] ]]();
		}

		self setclientomnvar("ks_acquired",1);
		return;
	}

	var_0A = self.pers["killstreaks"][var_05];
	var_0A.available = 1;
	var_0A.earned = 0;
	var_0A.awardxp = 0;
	var_0A.owner = param_01;
	var_0A.kid = self.pers["kID"];
	if(isdefined(param_02) && isarray(param_02))
	{
		var_0A.modules = param_02;
	}
	else
	{
		var_0A.modules = getkillstreakmodules(self,param_00);
	}

	self.pers["kID"]++;
	var_0A.lifeid = -1;
	if(level.console || common_scripts\utility::is_player_gamepad_enabled())
	{
		var_0B = maps\mp\_utility::getkillstreakweapon(param_00,param_02);
		givekillstreakweapon(var_0B);
		if(isdefined(self.killstreakindexweapon))
		{
			param_00 = self.pers["killstreaks"][self.killstreakindexweapon].streakname;
			var_0C = maps\mp\_utility::getkillstreakweapon(param_00,param_02);
			var_0D = self getcurrentweapon();
			if(var_0D != var_0C && !issubstr(var_0D,"turrethead"))
			{
				self.killstreakindexweapon = var_05;
			}
		}
		else
		{
			self.killstreakindexweapon = var_05;
		}
	}
	else
	{
		if(level.killstreak_gimme_slot == var_05 && self.pers["killstreaks"][level.killstreak_gimme_slot].nextslot > level.killstreak_stacking_start_slot)
		{
			var_0E = self.pers["killstreaks"][level.killstreak_gimme_slot].nextslot - 1;
			var_0F = maps\mp\_utility::getkillstreakweapon(self.pers["killstreaks"][var_0E].streakname,self.pers["killstreaks"][var_0E].modules);
			self takeweapon(var_0F);
		}

		var_0C = maps\mp\_utility::getkillstreakweapon(param_00,param_02);
		maps\mp\_utility::_giveweapon(var_0C,0);
		maps\mp\_utility::_setactionslot(var_05 + 4,"weapon",var_0C);
	}

	updatestreakslots();
	if(isdefined(level.killstreaksetupfuncs[param_00]))
	{
		self [[ level.killstreaksetupfuncs[param_00] ]]();
	}

	self setclientomnvar("ks_acquired",1);
}

//Function Number: 38
getnextkillstreakslotindex(param_00,param_01,param_02)
{
	var_03 = undefined;
	if(!isdefined(param_01) || param_01 == 0)
	{
		if(!isdefined(param_02))
		{
			var_03 = level.killstreak_gimme_slot;
		}
		else
		{
			var_03 = param_02;
		}
	}
	else
	{
		for(var_04 = level.killstreak_slot_1;var_04 < level.killstreak_stacking_start_slot;var_04++)
		{
			var_05 = self.pers["killstreaks"][var_04];
			if(isdefined(var_05) && isdefined(var_05.streakname) && param_00 == var_05.streakname)
			{
				var_03 = var_04;
				break;
			}
		}
	}

	return var_03;
}

//Function Number: 39
givekillstreak(param_00,param_01,param_02,param_03,param_04,param_05)
{
	self endon("givingLoadout");
	if(!isdefined(level.killstreakfuncs[param_00]) || tablelookup(level.killstreak_string_table,1,param_00,0) == "")
	{
		return;
	}

	if(!isdefined(self.pers["killstreaks"]))
	{
		return;
	}

	self endon("disconnect");
	var_06 = undefined;
	if(!isdefined(param_01) || param_01 == 0)
	{
		var_07 = self.pers["killstreaks"].size;
		if(isdefined(param_05))
		{
			var_07 = param_05;
		}

		if(!isdefined(self.pers["killstreaks"][var_07]))
		{
			self.pers["killstreaks"][var_07] = spawnstruct();
		}

		var_08 = self.pers["killstreaks"][var_07];
		var_08.available = 0;
		var_08.streakname = param_00;
		var_08.earned = 0;
		var_08.awardxp = isdefined(param_02) && param_02;
		var_08.owner = param_03;
		var_08.kid = self.pers["kID"];
		var_08.lifeid = -1;
		var_08.isgimme = 1;
		var_06 = getnextkillstreakslotindex(param_00,param_01,param_05);
		if(!isdefined(param_04) || !isarray(param_04))
		{
			param_04 = getkillstreakmodules(self,param_00);
		}

		var_08.modules = param_04;
		self.pers["killstreaks"][var_06].nextslot = var_07;
		self.pers["killstreaks"][var_06].streakname = param_00;
		var_09 = maps\mp\_utility::getkillstreakindex(param_00);
		var_0A = "ks_icon" + common_scripts\utility::tostring(var_06);
		self setclientomnvar(var_0A,var_09);
	}
	else
	{
		var_06 = getnextkillstreakslotindex(param_00,param_01,param_05);
		if(!isdefined(var_06))
		{
			return;
		}
	}

	var_0E = self.pers["killstreaks"][var_06];
	var_0E.available = 1;
	var_0E.earned = isdefined(param_01) && param_01;
	var_0E.awardxp = isdefined(param_02) && param_02;
	var_0E.owner = param_03;
	var_0E.kid = self.pers["kID"];
	if(isdefined(param_04) && isarray(param_04))
	{
		var_0E.modules = param_04;
	}
	else
	{
		var_0E.modules = getkillstreakmodules(self,param_00);
	}

	self.pers["kID"]++;
	if(!var_0E.earned)
	{
		var_0E.lifeid = -1;
	}
	else
	{
		var_0E.lifeid = self.pers["deaths"];
	}

	if(level.console || common_scripts\utility::is_player_gamepad_enabled())
	{
		var_0F = maps\mp\_utility::getkillstreakweapon(param_00,param_04);
		givekillstreakweapon(var_0F);
		if(isdefined(self.killstreakindexweapon))
		{
			param_00 = self.pers["killstreaks"][self.killstreakindexweapon].streakname;
			var_10 = maps\mp\_utility::getkillstreakweapon(param_00,param_04);
			var_11 = self getcurrentweapon();
			if(var_11 != var_10 && !issubstr(var_11,"turrethead"))
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
		if(level.killstreak_gimme_slot == var_06 && self.pers["killstreaks"][level.killstreak_gimme_slot].nextslot > level.killstreak_stacking_start_slot)
		{
			var_12 = self.pers["killstreaks"][level.killstreak_gimme_slot].nextslot - 1;
			var_13 = maps\mp\_utility::getkillstreakweapon(self.pers["killstreaks"][var_12].streakname,self.pers["killstreaks"][var_12].modules);
			self takeweapon(var_13);
		}

		var_10 = maps\mp\_utility::getkillstreakweapon(param_00,param_04);
		maps\mp\_utility::_giveweapon(var_10,0);
		maps\mp\_utility::_setactionslot(var_06 + 4,"weapon",var_10);
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

	self setclientomnvar("ks_acquired",1);
}

//Function Number: 40
givekillstreakweapon(param_00)
{
	self endon("disconnect");
	if(!level.console && !common_scripts\utility::is_player_gamepad_enabled())
	{
		return;
	}

	var_01 = self getweaponslistitems();
	foreach(var_03 in var_01)
	{
		if(!maps\mp\_utility::isstrstart(var_03,"killstreak_") && !maps\mp\_utility::isstrstart(var_03,"airdrop_") && !maps\mp\_utility::isstrstart(var_03,"deployable_"))
		{
			continue;
		}

		if(self getcurrentweapon() == var_03)
		{
			continue;
		}

		while(maps\mp\_utility::ischangingweapon())
		{
			wait(0.05);
		}

		self takeweapon(var_03);
	}

	if(isdefined(self.killstreakindexweapon))
	{
		var_05 = self.pers["killstreaks"][self.killstreakindexweapon].streakname;
		var_06 = self.pers["killstreaks"][self.killstreakindexweapon].modules;
		var_07 = maps\mp\_utility::getkillstreakweapon(var_05,var_06);
		if(self getcurrentweapon() != var_07)
		{
			maps\mp\_utility::_giveweapon(param_00,0);
			maps\mp\_utility::_setactionslot(4,"weapon",param_00);
			return;
		}

		return;
	}

	maps\mp\_utility::_giveweapon(param_00,0);
	maps\mp\_utility::_setactionslot(4,"weapon",param_00);
}

//Function Number: 41
getstreakmodulecost(param_00)
{
	return int(tablelookup(level.ks_modules_table,level.ks_module_ref_column,param_00,level.ks_module_added_points_column));
}

//Function Number: 42
getstreakmodulebasekillstreak(param_00)
{
	return tablelookup(level.ks_modules_table,level.ks_module_ref_column,param_00,level.ks_module_killstreak_ref_column);
}

//Function Number: 43
getallstreakmodulescost(param_00)
{
	var_01 = 0;
	var_02 = getarraykeys(self.killstreakmodules);
	foreach(var_04 in var_02)
	{
		var_05 = getstreakmodulebasekillstreak(var_04);
		if(var_05 == param_00)
		{
			var_01 = var_01 + self.killstreakmodules[var_04];
		}
	}

	return var_01;
}

//Function Number: 44
getstreakcost(param_00)
{
	var_01 = int(maps\mp\_utility::getkillstreakkills(param_00));
	if(isplayer(self))
	{
		var_01 = var_01 + getallstreakmodulescost(param_00);
	}

	if(isdefined(self) && isplayer(self))
	{
		if(var_01 > 100 && maps\mp\_utility::_hasperk("specialty_hardline"))
		{
			var_01 = var_01 - 100;
		}
	}

	return var_01;
}

//Function Number: 45
getkillstreakhint(param_00)
{
	return tablelookupistring(level.killstreak_string_table,1,param_00,5);
}

//Function Number: 46
getkillstreakinformenemy(param_00)
{
	return int(tablelookup(level.killstreak_string_table,1,param_00,10));
}

//Function Number: 47
getkillstreakdialog(param_00)
{
	return tablelookup(level.killstreak_string_table,1,param_00,7);
}

//Function Number: 48
getkillstreakcrateicon(param_00,param_01)
{
	var_02 = 14;
	if(isdefined(param_01) && param_01.size > 0)
	{
		switch(param_01.size)
		{
			case 1:
				break;

			case 2:
				break;

			case 3:
				break;

			default:
				break;
		}
	}
}

//Function Number: 49
giveownedkillstreakitem(param_00)
{
	var_01 = self.pers["killstreaks"];
	if(level.console || common_scripts\utility::is_player_gamepad_enabled())
	{
		var_02 = -1;
		var_03 = -1;
		for(var_04 = 0;var_04 < level.killstreak_stacking_start_slot;var_04++)
		{
			if(isdefined(var_01[var_04]) && isdefined(var_01[var_04].streakname) && var_01[var_04].available && getstreakcost(var_01[var_04].streakname) > var_03)
			{
				var_03 = 0;
				if(!var_01[var_04].isgimme)
				{
					var_03 = getstreakcost(var_01[var_04].streakname);
				}

				var_02 = var_04;
			}
		}

		if(var_02 != -1)
		{
			self.killstreakindexweapon = var_02;
			var_05 = var_01[self.killstreakindexweapon].streakname;
			var_06 = self.pers["killstreaks"][self.killstreakindexweapon].modules;
			var_07 = maps\mp\_utility::getkillstreakweapon(var_05,var_06);
			givekillstreakweapon(var_07);
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
		for(var_04 = 0;var_04 < level.killstreak_stacking_start_slot;var_04++)
		{
			if(isdefined(var_01[var_04]) && isdefined(var_01[var_04].streakname) && var_01[var_04].available)
			{
				var_08 = maps\mp\_utility::getkillstreakweapon(var_01[var_04].streakname,var_01[var_04].modules);
				var_09 = self getweaponslistitems();
				var_0A = 0;
				for(var_0B = 0;var_0B < var_09.size;var_0B++)
				{
					if(var_08 == var_09[var_0B])
					{
						var_0A = 1;
						break;
					}
				}

				if(!var_0A)
				{
					maps\mp\_utility::_giveweapon(var_08);
				}
				else if(issubstr(var_08,"airdrop_"))
				{
					self setweaponammoclip(var_08,1);
				}

				maps\mp\_utility::_setactionslot(var_04 + 4,"weapon",var_08);
				if(getstreakcost(var_01[var_04].streakname) > var_03)
				{
					var_03 = 0;
					if(!var_01[var_04].isgimme)
					{
						var_03 = getstreakcost(var_01[var_04].streakname);
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

//Function Number: 50
playerwaittillridekillstreakcomplete()
{
	if(!isdefined(self.remoteridetransition))
	{
		return;
	}

	self endon("rideKillstreakComplete");
	self waittill("rideKillstreakFailed");
}

//Function Number: 51
playerwaittillridekillstreakblack()
{
	if(!isdefined(self.remoteridetransition))
	{
		return;
	}

	self endon("rideKillstreakBlack");
	self waittill("rideKillstreakFailed");
}

//Function Number: 52
initridekillstreak(param_00,param_01,param_02,param_03)
{
	if(!isdefined(param_01))
	{
		param_01 = 0;
	}

	playerdestroyglassbelow();
	common_scripts\utility::_disableusability();
	maps\mp\_utility::freezecontrolswrapper(1);
	self.remoteridetransition = 1;
	var_04 = initridekillstreak_internal(param_00,param_01,param_02,param_03);
	if(isdefined(self))
	{
		maps\mp\_utility::freezecontrolswrapper(0);
		common_scripts\utility::_enableusability();
		self.remoteridetransition = undefined;
		if(var_04 == "success")
		{
			self notify("rideKillstreakBlack");
		}
		else
		{
			maps\mp\_utility::playerremotekillstreakshowhud();
			self notify("rideKillstreakFailed");
		}
	}

	return var_04;
}

//Function Number: 53
initridekillstreak_internal(param_00,param_01,param_02,param_03)
{
	thread resetplayeronteamchange();
	var_04 = "none";
	var_05 = 0.75;
	if(isdefined(param_00) && param_00 == "coop")
	{
		var_05 = 0.05;
	}

	var_04 = common_scripts\utility::waittill_any_timeout(var_05,"disconnect","death","weapon_switch_started");
	maps\mp\gametypes\_hostmigration::waittillhostmigrationdone();
	if(var_04 == "disconnect")
	{
		return "disconnect";
	}

	if(var_04 == "death")
	{
		return "fail";
	}

	if(var_04 == "weapon_switch_started")
	{
		return "fail";
	}

	if(!isdefined(self) || !isalive(self))
	{
		return "fail";
	}

	if(!self isonground() && !self islinked())
	{
		return "fail";
	}

	if(isdefined(self.underwater) && self.underwater)
	{
		return "fail";
	}

	if(level.gameended)
	{
		return "fail";
	}

	if(maps\mp\_utility::isemped() || maps\mp\_utility::isairdenied())
	{
		return "fail";
	}

	maps\mp\_utility::playerremotekillstreakhidehud();
	playerdestroyglassbelow();
	if(param_01)
	{
		if(!isdefined(param_02))
		{
			param_02 = 1;
		}
	}
	else
	{
		if(!isdefined(param_02))
		{
			param_02 = 0.8;
		}

		self setclientomnvar("ui_killstreak_blackout",1);
		self setclientomnvar("ui_killstreak_blackout_fade_end",gettime() + int(param_02 * 1000));
		thread clearrideintroonteamchange();
		thread clearrideintroonroundtransition();
	}

	var_04 = common_scripts\utility::waittill_any_timeout(param_02,"disconnect","death");
	if(var_04 == "disconnect" || !isdefined(self))
	{
		return "disconnect";
	}

	if(!isdefined(param_03))
	{
		param_03 = 0.6;
	}

	if(param_01)
	{
		self notify("intro_cleared");
	}
	else
	{
		thread clearrideintro(param_03);
	}

	if(var_04 == "death")
	{
		return "fail";
	}

	if(!isdefined(self) || !isalive(self))
	{
		return "fail";
	}

	if(!self isonground() && !self islinked())
	{
		return "fail";
	}

	if(isdefined(self.underwater) && self.underwater)
	{
		return "fail";
	}

	if(level.gameended)
	{
		return "fail";
	}

	if(maps\mp\_utility::isemped() || maps\mp\_utility::isairdenied())
	{
		return "fail";
	}

	maps\mp\gametypes\_hostmigration::waittillhostmigrationdone();
	return "success";
}

//Function Number: 54
clearrideintro(param_00)
{
	self endon("disconnect");
	self endon("joined_team");
	if(isdefined(param_00))
	{
		maps\mp\gametypes\_hostmigration::waitlongdurationwithhostmigrationpause(param_00);
	}

	var_01 = 0.5;
	self setclientomnvar("ui_killstreak_blackout",0);
	self setclientomnvar("ui_killstreak_blackout_fade_end",gettime() + int(var_01 * 1000));
	wait(var_01);
	if(!isdefined(self))
	{
		return;
	}

	self notify("rideKillstreakComplete");
}

//Function Number: 55
resetplayeronteamchange()
{
	self endon("rideKillstreakComplete");
	self endon("rideKillstreakFailed");
	self waittill("joined_team");
	maps\mp\_utility::freezecontrolswrapper(0);
	self.remoteridetransition = undefined;
	if(self.disabledusability)
	{
		common_scripts\utility::_enableusability();
	}

	if(maps\mp\_utility::isusingremote())
	{
		maps\mp\_utility::clearusingremote();
	}
}

//Function Number: 56
clearrideintroonteamchange()
{
	self endon("rideKillstreakComplete");
	self endon("rideKillstreakFailed");
	self waittill("joined_team");
	self setclientomnvar("ui_killstreak_blackout",0);
	self setclientomnvar("ui_killstreak_blackout_fade_end",0);
	maps\mp\_utility::playerremotekillstreakshowhud();
	self notify("rideKillstreakComplete");
}

//Function Number: 57
clearrideintroonroundtransition()
{
	self endon("rideKillstreakComplete");
	self endon("rideKillstreakFailed");
	level waittill("game_ended");
	self setclientomnvar("ui_killstreak_blackout",0);
	self setclientomnvar("ui_killstreak_blackout_fade_end",0);
	maps\mp\_utility::playerremotekillstreakshowhud();
	self notify("rideKillstreakComplete");
}

//Function Number: 58
playerdestroyglassbelow()
{
	if(self isonground())
	{
		var_00 = bullettrace(self.origin + (0,0,5),self.origin + (0,0,-5),0);
		if(isdefined(var_00["glass"]))
		{
			destroyglass(var_00["glass"]);
		}
	}
}

//Function Number: 59
giveselectedkillstreakitem()
{
	var_00 = self.pers["killstreaks"][self.killstreakindexweapon].streakname;
	var_01 = self.pers["killstreaks"][self.killstreakindexweapon].modules;
	var_02 = maps\mp\_utility::getkillstreakweapon(var_00,var_01);
	givekillstreakweapon(var_02);
	updatestreakslots();
}

//Function Number: 60
getkillstreakcount()
{
	var_00 = 0;
	for(var_01 = 0;var_01 < level.killstreak_stacking_start_slot;var_01++)
	{
		if(isdefined(self.pers["killstreaks"][var_01]) && isdefined(self.pers["killstreaks"][var_01].streakname) && self.pers["killstreaks"][var_01].available)
		{
			var_00++;
		}
	}

	return var_00;
}

//Function Number: 61
shufflekillstreaksup()
{
	if(getkillstreakcount() > 1)
	{
		for(;;)
		{
			self.killstreakindexweapon++;
			if(self.killstreakindexweapon >= level.killstreak_stacking_start_slot)
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

//Function Number: 62
shufflekillstreaksdown()
{
	if(getkillstreakcount() > 1)
	{
		for(;;)
		{
			self.killstreakindexweapon--;
			if(self.killstreakindexweapon < 0)
			{
				self.killstreakindexweapon = level.killstreak_stacking_start_slot - 1;
			}

			if(self.pers["killstreaks"][self.killstreakindexweapon].available == 1)
			{
				break;
			}
		}

		giveselectedkillstreakitem();
	}
}

//Function Number: 63
streakselectuptracker()
{
	self endon("death");
	self endon("disconnect");
	self endon("faux_spawn");
	level endon("game_ended");
	if(isdefined(level.ishorde) && level.ishorde)
	{
		self endon("horde_end_spectate");
	}

	for(;;)
	{
		self waittill("toggled_up");
		if(!level.console && !common_scripts\utility::is_player_gamepad_enabled())
		{
			continue;
		}

		if(canshufflekillstreaks())
		{
			shufflekillstreaksup();
		}

		wait(0.12);
	}
}

//Function Number: 64
streakselectdowntracker()
{
	self endon("death");
	self endon("disconnect");
	self endon("faux_spawn");
	level endon("game_ended");
	if(isdefined(level.ishorde) && level.ishorde)
	{
		self endon("horde_end_spectate");
	}

	for(;;)
	{
		self waittill("toggled_down");
		if(!level.console && !common_scripts\utility::is_player_gamepad_enabled())
		{
			continue;
		}

		if(canshufflekillstreaks())
		{
			shufflekillstreaksdown();
		}

		wait(0.12);
	}
}

//Function Number: 65
canshufflekillstreaks()
{
	return !self ismantling() && !isdefined(self.changingweapon) || isdefined(self.changingweapon) && self.changingweapon == "none" && canshufflewithkillstreakweapon() && !isdefined(self.iscarrying) || isdefined(self.iscarrying) && self.iscarrying == 0;
}

//Function Number: 66
canshufflewithkillstreakweapon()
{
	var_00 = self getcurrentweapon();
	return !maps\mp\_utility::iskillstreakweapon(var_00) || maps\mp\_utility::iskillstreakweapon(var_00) && maps\mp\_utility::isjuggernaut();
}

//Function Number: 67
streaknotifytracker()
{
	self endon("death");
	self endon("disconnect");
	level endon("game_ended");
	self endon("faux_spawn");
	if(isbot(self))
	{
		return;
	}

	maps\mp\_utility::gameflagwait("prematch_done");
	self notifyonplayercommand("toggled_up","+actionslot 1");
	self notifyonplayercommand("toggled_down","+actionslot 2");
	if(!level.console)
	{
		self notifyonplayercommand("streakUsed1","+actionslot 4");
		self notifyonplayercommand("streakUsed2","+actionslot 5");
		self notifyonplayercommand("streakUsed3","+actionslot 6");
		self notifyonplayercommand("streakUsed4","+actionslot 7");
		self notifyonplayercommand("streakUsed5","+actionslot 8");
	}
}

//Function Number: 68
giveadrenalinedirect(param_00)
{
	if(!param_00)
	{
		return;
	}

	var_01 = self.adrenaline + param_00;
	var_02 = getmaxstreakcost(0);
	if(var_01 >= var_02)
	{
		var_01 = var_01 - var_02;
	}

	setadrenaline(var_01);
	var_01 = self.adrenalinesupport + param_00;
	var_02 = getmaxstreakcost(1);
	if(var_01 >= var_02)
	{
		var_01 = var_01 - var_02;
	}

	setadrenalinesupport(var_01);
	updatestreakcount();
	checkstreakreward();
}

//Function Number: 69
roundup(param_00)
{
	if(int(param_00) != param_00)
	{
		return int(param_00 + 1);
	}

	return int(param_00);
}

//Function Number: 70
giveadrenaline(param_00)
{
	var_01 = maps\mp\gametypes\_rank::getscoreinfovalue(param_00);
	if(maps\mp\_utility::isreallyalive(self))
	{
		giveadrenalinedirect(var_01);
	}

	displaykillstreakpoints(param_00,var_01);
}

//Function Number: 71
displaykillstreakpoints(param_00,param_01)
{
	if(!level.hardcoremode)
	{
		thread maps\mp\gametypes\_rank::xppointspopup(param_00,param_01);
	}
}

//Function Number: 72
resetadrenaline(param_00)
{
	self.earnedstreaklevel = 0;
	setadrenaline(0);
	if(param_00)
	{
		setadrenalinesupport(0);
		self.pers["ks_totalPointsSupport"] = 0;
	}

	updatestreakcount();
	self.pers["ks_totalPoints"] = 0;
	self.pers["lastEarnedStreak"] = undefined;
}

//Function Number: 73
setadrenaline(param_00)
{
	if(param_00 < 0)
	{
		param_00 = 0;
	}

	if(isdefined(self.adrenaline) && self.adrenaline != 0)
	{
		self.previousadrenaline = self.adrenaline;
	}
	else
	{
		self.previousadrenaline = 0;
	}

	self.adrenaline = param_00;
	self.pers["ks_totalPoints"] = self.adrenaline;
}

//Function Number: 74
setadrenalinesupport(param_00)
{
	if(param_00 < 0)
	{
		param_00 = 0;
	}

	if(isdefined(self.adrenalinesupport) && self.adrenalinesupport != 0)
	{
		self.previousadrenalinesupport = self.adrenalinesupport;
	}
	else
	{
		self.previousadrenalinesupport = 0;
	}

	self.adrenalinesupport = param_00;
	self.pers["ks_totalPointsSupport"] = self.adrenalinesupport;
}

//Function Number: 75
pc_watchcontrolschanged()
{
	self endon("death");
	self endon("disconnect");
	level endon("game_ended");
	var_00 = common_scripts\utility::is_player_gamepad_enabled();
	for(;;)
	{
		if(maps\mp\_utility::isinremotetransition() || maps\mp\_utility::isusingremote() || maps\mp\_utility::ischangingweapon())
		{
			while(maps\mp\_utility::isinremotetransition() || maps\mp\_utility::isusingremote() || maps\mp\_utility::ischangingweapon())
			{
				wait 0.05;
			}

			wait 0.05;
		}

		if(var_00 != common_scripts\utility::is_player_gamepad_enabled())
		{
			thread updatekillstreaks(1);
			var_00 = common_scripts\utility::is_player_gamepad_enabled();
		}

		wait 0.05;
	}
}

//Function Number: 76
pc_watchstreakuse()
{
	self endon("death");
	self endon("disconnect");
	level endon("game_ended");
	self endon("faux_spawn");
	self.actionslotenabled = [];
	self.actionslotenabled[level.killstreak_gimme_slot] = 1;
	self.actionslotenabled[level.killstreak_slot_1] = 1;
	self.actionslotenabled[level.killstreak_slot_2] = 1;
	self.actionslotenabled[level.killstreak_slot_3] = 1;
	self.actionslotenabled[level.killstreak_slot_4] = 1;
	if(!isbot(self))
	{
		thread pc_watchcontrolschanged();
	}

	var_00 = common_scripts\utility::waittill_any_return("streakUsed1","streakUsed2","streakUsed3","streakUsed4","streakUsed5");
	if(common_scripts\utility::is_player_gamepad_enabled())
	{
		continue;
	}

	if(!isdefined(var_00))
	{
		continue;
	}

	if(isdefined(self.changingweapon) && self.changingweapon == "none")
	{
		continue;
	}

	switch(var_00)
	{
		case "streakUsed1":
			break;

		case "streakUsed2":
			break;

		case "streakUsed3":
			break;

		case "streakUsed4":
			break;

		case "streakUsed5":
			break;
	}
}

//Function Number: 77
disablekillstreakactionslots()
{
	for(var_00 = 0;var_00 < level.killstreak_stacking_start_slot;var_00++)
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

//Function Number: 78
enablekillstreakactionslots()
{
	for(var_00 = 0;var_00 < level.killstreak_stacking_start_slot;var_00++)
	{
		if(self.pers["killstreaks"][var_00].available)
		{
			var_01 = maps\mp\_utility::getkillstreakweapon(self.pers["killstreaks"][var_00].streakname,self.pers["killstreaks"][var_00].modules);
			maps\mp\_utility::_setactionslot(var_00 + 4,"weapon",var_01);
		}
		else
		{
			maps\mp\_utility::_setactionslot(var_00 + 4,"");
		}

		self.actionslotenabled[var_00] = 1;
	}
}

//Function Number: 79
killstreakhit(param_00,param_01,param_02)
{
	if(isdefined(param_01) && isplayer(param_00) && isdefined(param_02.owner) && isdefined(param_02.owner.team))
	{
		if(((level.teambased && param_02.owner.team != param_00.team) || !level.teambased) && param_00 != param_02.owner)
		{
			if(maps\mp\_utility::iskillstreakweapon(param_01))
			{
				return;
			}

			if(!isdefined(param_00.lasthittime[param_01]))
			{
				param_00.lasthittime[param_01] = 0;
			}

			if(param_00.lasthittime[param_01] == gettime())
			{
				return;
			}

			param_00.lasthittime[param_01] = gettime();
			param_00 thread maps\mp\gametypes\_gamelogic::threadedsetweaponstatbyname(param_01,1,"hits");
			var_03 = param_00 maps\mp\gametypes\_persistence::statgetbuffered("totalShots");
			var_04 = param_00 maps\mp\gametypes\_persistence::statgetbuffered("hits") + 1;
			if(var_04 <= var_03)
			{
				param_00 maps\mp\gametypes\_persistence::statsetbuffered("hits",var_04);
				param_00 maps\mp\gametypes\_persistence::statsetbuffered("misses",int(var_03 - var_04));
				var_05 = clamp(float(var_04) / float(var_03),0,1) * 10000;
				param_00 maps\mp\gametypes\_persistence::statsetbuffered("accuracy",int(var_05));
				return;
			}
		}
	}
}