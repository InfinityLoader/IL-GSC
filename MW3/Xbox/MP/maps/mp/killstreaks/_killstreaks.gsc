/*******************************************************************
 * Decompiled By: Bog
 * Decompiled File: maps\mp\killstreaks\_killstreaks.gsc
 * Game: Call of Duty: Modern Warfare 3
 * Platform: Console
 * Function Count: 69
 * Decompile Time: 1271 ms
 * Timestamp: 10/27/2023 2:27:07 AM
*******************************************************************/

//Function Number: 1
init()
{
	precachestring(&"MP_KILLSTREAK_N");
	precachestring(&"MP_NUKE_ALREADY_INBOUND");
	precachestring(&"MP_UNAVILABLE_IN_LASTSTAND");
	precachestring(&"MP_UNAVAILABLE_FOR_N_WHEN_EMP");
	precachestring(&"MP_UNAVAILABLE_FOR_N_WHEN_NUKE");
	precachestring(&"MP_UNAVAILABLE_USING_TURRET");
	precachestring(&"MP_UNAVAILABLE_WHEN_INCAP");
	precachestring(&"MP_HELI_IN_QUEUE");
	precachestring(&"MP_SPECIALIST_STREAKING_XP");
	precachestring(&"MP_AIR_SPACE_TOO_CROWDED");
	precachestring(&"MP_CIVILIAN_AIR_TRAFFIC");
	precachestring(&"MP_TOO_MANY_VEHICLES");
	precachestring(&"SPLASHES_HEADSHOT");
	precachestring(&"SPLASHES_FIRSTBLOOD");
	precachestring(&"MP_ASSIST");
	precachestring(&"MP_ASSIST_TO_KILL");
	precacheshader("hud_killstreak_dpad_arrow_down");
	precacheshader("hud_killstreak_dpad_arrow_right");
	precacheshader("hud_killstreak_dpad_arrow_up");
	precacheshader("hud_killstreak_frame");
	precacheshader("hud_killstreak_frame_fade_top");
	precacheshader("hud_killstreak_highlight");
	precacheshader("hud_killstreak_bar_empty");
	precacheshader("hud_killstreak_bar_full");
	initkillstreakdata();
	level.killstreakfuncs = [];
	level.killstreaksetupfuncs = [];
	level.killstreakweapons = [];
	thread maps\mp\killstreaks\_ac130::init();
	thread maps\mp\killstreaks\_remotemissile::init();
	thread maps\mp\killstreaks\_uav::init();
	thread maps\mp\killstreaks\_airstrike::init();
	thread maps\mp\killstreaks\_airdrop::init();
	thread maps\mp\killstreaks\_helicopter::init();
	thread maps\mp\killstreaks\_helicopter_flock::init();
	thread maps\mp\killstreaks\_helicopter_guard::init();
	thread maps\mp\killstreaks\_autosentry::init();
	thread maps\mp\killstreaks\_emp::init();
	thread maps\mp\killstreaks\_nuke::init();
	thread maps\mp\killstreaks\_escortairdrop::init();
	thread maps\mp\killstreaks\_remotemortar::init();
	thread maps\mp\killstreaks\_deployablebox::init();
	thread maps\mp\killstreaks\_ims::init();
	thread maps\mp\killstreaks\_perkstreaks::init();
	thread maps\mp\killstreaks\_remoteturret::init();
	thread maps\mp\killstreaks\_remoteuav::init();
	thread maps\mp\killstreaks\_remotetank::init();
	thread maps\mp\killstreaks\_juggernaut::init();
	level.killstreakweildweapons = [];
	level.killstreakweildweapons["cobra_player_minigun_mp"] = 1;
	level.killstreakweildweapons["artillery_mp"] = 1;
	level.killstreakweildweapons["stealth_bomb_mp"] = 1;
	level.killstreakweildweapons["pavelow_minigun_mp"] = 1;
	level.killstreakweildweapons["sentry_minigun_mp"] = 1;
	level.killstreakweildweapons["harrier_20mm_mp"] = 1;
	level.killstreakweildweapons["ac130_105mm_mp"] = 1;
	level.killstreakweildweapons["ac130_40mm_mp"] = 1;
	level.killstreakweildweapons["ac130_25mm_mp"] = 1;
	level.killstreakweildweapons["remotemissile_projectile_mp"] = 1;
	level.killstreakweildweapons["cobra_20mm_mp"] = 1;
	level.killstreakweildweapons["nuke_mp"] = 1;
	level.killstreakweildweapons["apache_minigun_mp"] = 1;
	level.killstreakweildweapons["littlebird_guard_minigun_mp"] = 1;
	level.killstreakweildweapons["uav_strike_marker_mp"] = 1;
	level.killstreakweildweapons["osprey_minigun_mp"] = 1;
	level.killstreakweildweapons["strike_marker_mp"] = 1;
	level.killstreakweildweapons["a10_30mm_mp"] = 1;
	level.killstreakweildweapons["manned_minigun_turret_mp"] = 1;
	level.killstreakweildweapons["manned_gl_turret_mp"] = 1;
	level.killstreakweildweapons["airdrop_trap_explosive_mp"] = 1;
	level.killstreakweildweapons["uav_strike_projectile_mp"] = 1;
	level.killstreakweildweapons["remote_mortar_missile_mp"] = 1;
	level.killstreakweildweapons["manned_littlebird_sniper_mp"] = 1;
	level.killstreakweildweapons["iw5_m60jugg_mp"] = 1;
	level.killstreakweildweapons["iw5_mp412jugg_mp"] = 1;
	level.killstreakweildweapons["iw5_riotshieldjugg_mp"] = 1;
	level.killstreakweildweapons["iw5_usp45jugg_mp"] = 1;
	level.killstreakweildweapons["remote_turret_mp"] = 1;
	level.killstreakweildweapons["osprey_player_minigun_mp"] = 1;
	level.killstreakweildweapons["deployable_vest_marker_mp"] = 1;
	level.killstreakweildweapons["ugv_turret_mp"] = 1;
	level.killstreakweildweapons["ugv_gl_turret_mp"] = 1;
	level.killstreakweildweapons["uav_remote_mp"] = 1;
	level.killstreakchainingweapons = [];
	level.killstreakchainingweapons["remotemissile_projectile_mp"] = "predator_missile";
	level.killstreakchainingweapons["ims_projectile_mp"] = "ims";
	level.killstreakchainingweapons["sentry_minigun_mp"] = "airdrop_sentry_minigun";
	level.killstreakchainingweapons["artillery_mp"] = "precision_airstrike";
	level.killstreakchainingweapons["cobra_20mm_mp"] = "helicopter";
	level.killstreakchainingweapons["apache_minigun_mp"] = "littlebird_flock";
	level.killstreakchainingweapons["littlebird_guard_minigun_mp"] = "littlebird_support";
	level.killstreakchainingweapons["remote_mortar_missile_mp"] = "remote_mortar";
	level.killstreakchainingweapons["ugv_turret_mp"] = "airdrop_remote_tank";
	level.killstreakchainingweapons["ugv_gl_turret_mp"] = "airdrop_remote_tank";
	level.killstreakchainingweapons["pavelow_minigun_mp"] = "helicopter_flares";
	level.killstreakchainingweapons["ac130_105mm_mp"] = "ac130";
	level.killstreakchainingweapons["ac130_40mm_mp"] = "ac130";
	level.killstreakchainingweapons["ac130_25mm_mp"] = "ac130";
	level.killstreakchainingweapons["iw5_m60jugg_mp"] = "airdrop_juggernaut";
	level.killstreakchainingweapons["iw5_mp412jugg_mp"] = "airdrop_juggernaut";
	level.killstreakchainingweapons["osprey_player_minigun_mp"] = "osprey_gunner";
	level.killstreakrounddelay = maps\mp\_utility::getintproperty("scr_game_killstreakdelay",8);
	level thread onplayerconnect();
}

//Function Number: 2
initkillstreakdata()
{
	var_00 = 1;
	for(;;)
	{
		var_01 = tablelookup("mp/killstreakTable.csv",0,var_00,1);
		if(!isdefined(var_01) || var_01 == "")
		{
			break;
		}

		var_02 = tablelookup("mp/killstreakTable.csv",0,var_00,1);
		var_03 = tablelookupistring("mp/killstreakTable.csv",0,var_00,6);
		precachestring(var_03);
		var_04 = tablelookup("mp/killstreakTable.csv",0,var_00,8);
		game["dialog"][var_02] = var_04;
		var_05 = tablelookup("mp/killstreakTable.csv",0,var_00,9);
		game["dialog"]["allies_friendly_" + var_02 + "_inbound"] = "use_" + var_05;
		game["dialog"]["allies_enemy_" + var_02 + "_inbound"] = "enemy_" + var_05;
		var_06 = tablelookup("mp/killstreakTable.csv",0,var_00,10);
		game["dialog"]["axis_friendly_" + var_02 + "_inbound"] = "use_" + var_06;
		game["dialog"]["axis_enemy_" + var_02 + "_inbound"] = "enemy_" + var_06;
		var_07 = tablelookup("mp/killstreakTable.csv",0,var_00,12);
		precacheitem(var_07);
		var_08 = int(tablelookup("mp/killstreakTable.csv",0,var_00,13));
		maps\mp\gametypes\_rank::registerscoreinfo("killstreak_" + var_02,var_08);
		var_09 = tablelookup("mp/killstreakTable.csv",0,var_00,14);
		precacheshader(var_09);
		var_09 = tablelookup("mp/killstreakTable.csv",0,var_00,15);
		if(var_09 != "")
		{
			precacheshader(var_09);
		}

		var_09 = tablelookup("mp/killstreakTable.csv",0,var_00,16);
		if(var_09 != "")
		{
			precacheshader(var_09);
		}

		var_09 = tablelookup("mp/killstreakTable.csv",0,var_00,17);
		if(var_09 != "")
		{
			precacheshader(var_09);
		}

		var_00++;
	}
}

//Function Number: 3
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

		var_00 visionsetmissilecamforplayer(game["thermal_vision"]);
		var_00 thread onplayerspawned();
		var_00.spupdatetotal = 0;
	}
}

//Function Number: 4
onplayerspawned()
{
	self endon("disconnect");
	for(;;)
	{
		self waittill("spawned_player");
		thread func_31E8();
		thread waitforchangeteam();
		if(level.console)
		{
			thread streakselectuptracker();
			thread func_3209();
			thread streakusetimetracker();
		}
		else
		{
			thread pc_watchstreakuse();
		}

		thread func_320A();
		if(!isdefined(self.pers["killstreaks"][0]))
		{
			initplayerkillstreaks();
		}

		if(!isdefined(self.earnedstreaklevel))
		{
			self.earnedstreaklevel = 0;
		}

		if(!isdefined(self.adrenaline))
		{
			self.adrenaline = self getplayerdata("killstreaksState","count");
		}

		func_28ED();
		func_31DD();
		if(self.streaktype == "specialist")
		{
			updatespecialistkillstreaks();
			continue;
		}

		giveownedkillstreakitem();
	}
}

//Function Number: 5
initplayerkillstreaks()
{
	if(!isdefined(self.streaktype))
	{
		return;
	}

	if(self.streaktype == "specialist")
	{
		self setplayerdata("killstreaksState","isSpecialist",1);
	}
	else
	{
		self setplayerdata("killstreaksState","isSpecialist",0);
	}

	self.pers["killstreaks"][0] = spawnstruct();
	self.pers["killstreaks"][0].available = 0;
	self.pers["killstreaks"][0].streakname = undefined;
	self.pers["killstreaks"][0].earned = 0;
	self.pers["killstreaks"][0].awardxp = undefined;
	self.pers["killstreaks"][0].owner = undefined;
	self.pers["killstreaks"][0].kid = undefined;
	self.pers["killstreaks"][0].lifeid = undefined;
	self.pers["killstreaks"][0].isgimme = 1;
	self.pers["killstreaks"][0].isspecialist = 0;
	self.pers["killstreaks"][0].nextslot = undefined;
	for(var_00 = 1;var_00 < 4;var_00++)
	{
		self.pers["killstreaks"][var_00] = spawnstruct();
		self.pers["killstreaks"][var_00].available = 0;
		self.pers["killstreaks"][var_00].streakname = undefined;
		self.pers["killstreaks"][var_00].earned = 1;
		self.pers["killstreaks"][var_00].awardxp = 1;
		self.pers["killstreaks"][var_00].owner = undefined;
		self.pers["killstreaks"][var_00].kid = undefined;
		self.pers["killstreaks"][var_00].lifeid = -1;
		self.pers["killstreaks"][var_00].isgimme = 0;
		self.pers["killstreaks"][var_00].isspecialist = 0;
	}

	self.pers["killstreaks"][4] = spawnstruct();
	self.pers["killstreaks"][4].available = 0;
	self.pers["killstreaks"][4].streakname = "all_perks_bonus";
	self.pers["killstreaks"][4].earned = 1;
	self.pers["killstreaks"][4].awardxp = 0;
	self.pers["killstreaks"][4].owner = undefined;
	self.pers["killstreaks"][4].kid = undefined;
	self.pers["killstreaks"][4].lifeid = -1;
	self.pers["killstreaks"][4].isgimme = 0;
	self.pers["killstreaks"][4].isspecialist = 1;
	for(var_00 = 0;var_00 < 4;var_00++)
	{
		self setplayerdata("killstreaksState","icons",var_00,0);
		self setplayerdata("killstreaksState","hasStreak",var_00,0);
	}

	self setplayerdata("killstreaksState","hasStreak",0,0);
	var_01 = 1;
	foreach(var_03 in self.killstreaks)
	{
		self.pers["killstreaks"][var_01].streakname = var_03;
		self.pers["killstreaks"][var_01].isspecialist = self.streaktype == "specialist";
		var_04 = self.pers["killstreaks"][var_01].streakname;
		if(self.streaktype == "specialist")
		{
			var_05 = strtok(self.pers["killstreaks"][var_01].streakname,"_");
			if(var_05[var_05.size - 1] == "ks")
			{
				var_06 = undefined;
				foreach(var_08 in var_05)
				{
					if(var_08 != "ks")
					{
						if(!isdefined(var_06))
						{
							var_06 = var_08;
							continue;
						}

						var_06 = var_06 + "_" + var_08;
					}
				}

				if(maps\mp\_utility::func_323E(self.pers["killstreaks"][var_01].streakname,"_"))
				{
					var_06 = "_" + var_06;
				}

				if(isdefined(var_06) && maps\mp\gametypes\_class::func_28F9(var_06) != "specialty_null")
				{
					var_04 = self.pers["killstreaks"][var_01].streakname + "_pro";
				}
			}
		}

		self setplayerdata("killstreaksState","icons",var_01,getkillstreakindex(var_04));
		self setplayerdata("killstreaksState","hasStreak",var_01,0);
		var_01++;
	}

	self setplayerdata("killstreaksState","nextIndex",1);
	self setplayerdata("killstreaksState","selectedIndex",-1);
	self setplayerdata("killstreaksState","numAvailable",0);
	self setplayerdata("killstreaksState","hasStreak",4,0);
}

//Function Number: 6
func_31D8()
{
	if(!isdefined(self.pers["killstreaks"]))
	{
		return;
	}

	if(self.adrenaline == self.previousadrenaline)
	{
		return;
	}

	var_00 = self.adrenaline;
	self setplayerdata("killstreaksState","count",self.adrenaline);
	if(self.adrenaline >= self getplayerdata("killstreaksState","countToNext"))
	{
		func_28ED();
	}
}

//Function Number: 7
resetstreakcount()
{
	self setplayerdata("killstreaksState","count",0);
	func_28ED();
}

//Function Number: 8
func_28ED()
{
	if(!isdefined(self.streaktype))
	{
		self setplayerdata("killstreaksState","countToNext",0);
		return;
	}

	if(getmaxstreakcost() == 0)
	{
		self setplayerdata("killstreaksState","countToNext",0);
		return;
	}

	if(self.streaktype == "specialist")
	{
		if(self.adrenaline >= getmaxstreakcost())
		{
			return;
		}
	}

	var_00 = func_31DB();
	if(!isdefined(var_00))
	{
		return;
	}

	var_01 = getstreakcost(var_00);
	self setplayerdata("killstreaksState","countToNext",var_01);
}

//Function Number: 9
func_31DB()
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
		var_03 = getstreakcost(var_02);
		if(var_03 > var_00)
		{
			return var_02;
		}
	}

	return undefined;
}

//Function Number: 10
getmaxstreakcost()
{
	var_00 = 0;
	foreach(var_02 in self.killstreaks)
	{
		var_03 = getstreakcost(var_02);
		if(var_03 > var_00)
		{
			var_00 = var_03;
		}
	}

	return var_00;
}

//Function Number: 11
func_31DD()
{
	if(!isdefined(self.streaktype))
	{
		return;
	}

	if(!maps\mp\_utility::isreallyalive(self))
	{
		return;
	}

	var_00 = 0;
	for(var_01 = 0;var_01 < 4;var_01++)
	{
		if(isdefined(self.pers["killstreaks"][var_01]) && isdefined(self.pers["killstreaks"][var_01].streakname))
		{
			self setplayerdata("killstreaksState","hasStreak",var_01,self.pers["killstreaks"][var_01].available);
			if(self.pers["killstreaks"][var_01].available == 1)
			{
				var_00++;
			}
		}
	}

	if(self.streaktype != "specialist")
	{
		self setplayerdata("killstreaksState","numAvailable",var_00);
	}

	var_02 = self.earnedstreaklevel;
	var_03 = getmaxstreakcost();
	if(self.earnedstreaklevel == var_03 && self.streaktype != "specialist")
	{
		var_02 = 0;
	}

	var_04 = 1;
	foreach(var_06 in self.killstreaks)
	{
		var_07 = getstreakcost(var_06);
		if(var_07 > var_02)
		{
			var_08 = var_06;
			break;
		}

		if(self.streaktype == "specialist")
		{
			if(self.earnedstreaklevel == var_03)
			{
				break;
			}
		}

		var_04++;
	}

	self setplayerdata("killstreaksState","nextIndex",var_04);
	if(isdefined(self.killstreakindexweapon) && self.streaktype != "specialist")
	{
		self setplayerdata("killstreaksState","selectedIndex",self.killstreakindexweapon);
		return;
	}

	if(self.streaktype == "specialist" && self.pers["killstreaks"][0].available)
	{
		self setplayerdata("killstreaksState","selectedIndex",0);
		return;
	}

	self setplayerdata("killstreaksState","selectedIndex",-1);
}

//Function Number: 12
waitforchangeteam()
{
	self endon("disconnect");
	self endon("faux_spawn");
	self notify("waitForChangeTeam");
	self endon("waitForChangeTeam");
	for(;;)
	{
		self waittill("joined_team");
		func_2DD6();
	}
}

//Function Number: 13
isridekillstreak(param_00)
{
	switch(param_00)
	{
		case "helicopter_mk19":
		case "helicopter_minigun":
		case "remote_tank":
		case "remote_uav":
		case "remote_mortar":
		case "osprey_gunner":
		case "predator_missile":
		case "ac130":
			return 1;

		default:
			return 0;
	}
}

//Function Number: 14
func_31E1(param_00)
{
	switch(param_00)
	{
		case "deployable_exp_ammo":
		case "gl_turret":
		case "sentry_gl":
		case "ims":
		case "deployable_vest":
		case "minigun_turret":
		case "sentry":
			return 1;

		default:
			return 0;
	}
}

//Function Number: 15
func_31E2(param_00)
{
	switch(param_00)
	{
		case "harrier_airstrike":
		case "helicopter_minigun":
		case "littlebird_support":
		case "helicopter":
		case "remote_tank":
		case "remote_mortar":
		case "osprey_gunner":
		case "stealth_airstrike":
		case "littlebird_flock":
		case "helicopter_flares":
		case "predator_missile":
		case "precision_airstrike":
		case "ac130":
			return 1;
	}

	return 0;
}

//Function Number: 16
killstreakusepressed()
{
	var_00 = self.pers["killstreaks"][self.killstreakindexweapon].streakname;
	var_01 = self.pers["killstreaks"][self.killstreakindexweapon].lifeid;
	var_02 = self.pers["killstreaks"][self.killstreakindexweapon].earned;
	var_03 = self.pers["killstreaks"][self.killstreakindexweapon].awardxp;
	var_04 = self.pers["killstreaks"][self.killstreakindexweapon].kid;
	var_05 = self.pers["killstreaks"][self.killstreakindexweapon].isgimme;
	if(!self isonground() && isridekillstreak(var_00) || func_31E1(var_00))
	{
		return 0;
	}

	if(maps\mp\_utility::isusingremote())
	{
		return 0;
	}

	if(isdefined(self.selectinglocation))
	{
		return 0;
	}

	if(func_31E2(var_00) && level.killstreakrounddelay && maps\mp\_utility::getgametypenumlives())
	{
		if(level.graceperiod - level.ingraceperiod < level.killstreakrounddelay)
		{
			self iprintlnbold(&"MP_UNAVAILABLE_FOR_N",level.killstreakrounddelay - level.graceperiod - level.ingraceperiod);
			return 0;
		}
	}

	if((level.teambased && level.teamemped[self.team]) || !level.teambased && isdefined(level.empplayer) && level.empplayer != self)
	{
		if(var_00 != "deployable_vest")
		{
			self iprintlnbold(&"MP_UNAVAILABLE_FOR_N_WHEN_EMP",level.emptimeremaining);
			return 0;
		}
	}

	if(isdefined(self.nuked) && self.nuked)
	{
		if(var_00 != "deployable_vest")
		{
			self iprintlnbold(&"MP_UNAVAILABLE_FOR_N_WHEN_NUKE",level.nukeemptimeremaining);
			return 0;
		}
	}

	if(self isusingturret() && isridekillstreak(var_00) || func_31E1(var_00))
	{
		self iprintlnbold(&"MP_UNAVAILABLE_USING_TURRET");
		return 0;
	}

	if(isdefined(self.laststand) && isridekillstreak(var_00))
	{
		self iprintlnbold(&"MP_UNAVILABLE_IN_LASTSTAND");
		return 0;
	}

	if(!common_scripts\utility::isweaponenabled())
	{
		return 0;
	}

	var_06 = 0;
	if(maps\mp\_utility::func_27AF("specialty_explosivebullets") && !issubstr(var_00,"explosive_ammo"))
	{
		var_06 = 1;
	}

	if(issubstr(var_00,"airdrop") || var_00 == "littlebird_flock")
	{
		if(!self [[ level.killstreakfuncs[var_00] ]](var_01,var_04))
		{
			return 0;
		}
	}
	else if(!self [[ level.killstreakfuncs[var_00] ]](var_01))
	{
		return 0;
	}

	if(var_06)
	{
		maps\mp\_utility::func_282E("specialty_explosivebullets");
	}

	thread updatekillstreaks();
	func_2C16(var_00,var_03);
	return 1;
}

//Function Number: 17
func_2C16(param_00,param_01)
{
	self playlocalsound("weap_c4detpack_trigger_plr");
	if(param_01)
	{
		self thread [[ level.onxpevent ]]("killstreak_" + param_00);
		thread maps\mp\gametypes\_missions::usehardpoint(param_00);
	}

	var_02 = maps\mp\_awards::getkillstreakawardref(param_00);
	if(isdefined(var_02))
	{
		thread maps\mp\_utility::incplayerstat(var_02,1);
	}

	if(func_31F4(param_00))
	{
		thread maps\mp\_utility::incplayerstat("assaultkillstreaksused",1);
	}
	else if(func_31F5(param_00))
	{
		thread maps\mp\_utility::incplayerstat("supportkillstreaksused",1);
	}
	else if(func_31F6(param_00))
	{
		thread maps\mp\_utility::incplayerstat("specialistkillstreaksearned",1);
		return;
	}

	var_03 = self.team;
	if(level.teambased)
	{
		thread maps\mp\_utility::func_26E5(var_03 + "_friendly_" + param_00 + "_inbound",var_03);
		if(getkillstreakinformenemy(param_00))
		{
			thread maps\mp\_utility::func_26E5(var_03 + "_enemy_" + param_00 + "_inbound",level.otherteam[var_03]);
			return;
		}

		return;
	}

	thread maps\mp\_utility::func_2A60(var_03 + "_friendly_" + param_00 + "_inbound");
	if(getkillstreakinformenemy(param_00))
	{
		var_04[0] = self;
		thread maps\mp\_utility::func_26E5(var_03 + "_enemy_" + param_00 + "_inbound",undefined,undefined,var_04);
	}
}

//Function Number: 18
updatekillstreaks(param_00)
{
	if(!isdefined(param_00))
	{
		self.pers["killstreaks"][self.killstreakindexweapon].available = 0;
		if(self.killstreakindexweapon == 0)
		{
			self.pers["killstreaks"][self.pers["killstreaks"][0].nextslot] = undefined;
			var_01 = undefined;
			for(var_02 = 5;var_02 < self.pers["killstreaks"].size;var_02++)
			{
				if(!isdefined(self.pers["killstreaks"][var_02]) || !isdefined(self.pers["killstreaks"][var_02].streakname))
				{
					continue;
				}

				var_01 = self.pers["killstreaks"][var_02].streakname;
				self.pers["killstreaks"][0].nextslot = var_02;
			}

			if(isdefined(var_01))
			{
				self.pers["killstreaks"][0].available = 1;
				self.pers["killstreaks"][0].streakname = var_01;
				var_03 = getkillstreakindex(var_01);
				self setplayerdata("killstreaksState","icons",0,var_03);
				if(!level.console)
				{
					var_04 = func_2C01(var_01);
					maps\mp\_utility::func_31F3(4,"weapon",var_04);
				}
			}
		}
	}

	var_05 = undefined;
	if(self.streaktype == "specialist")
	{
		if(self.pers["killstreaks"][0].available)
		{
			var_05 = 0;
		}
	}
	else
	{
		for(var_02 = 0;var_02 < 4;var_02++)
		{
			if(isdefined(self.pers["killstreaks"][var_02]) && isdefined(self.pers["killstreaks"][var_02].streakname) && self.pers["killstreaks"][var_02].available)
			{
				var_05 = var_02;
			}
		}
	}

	if(isdefined(var_05))
	{
		if(level.console)
		{
			self.killstreakindexweapon = var_05;
			self.pers["lastEarnedStreak"] = self.pers["killstreaks"][var_05].streakname;
			func_3201();
			return;
		}

		for(var_02 = 0;var_02 < 4;var_02++)
		{
			if(isdefined(self.pers["killstreaks"][var_02]) && isdefined(self.pers["killstreaks"][var_02].streakname) && self.pers["killstreaks"][var_02].available)
			{
				var_04 = func_2C01(self.pers["killstreaks"][var_02].streakname);
				var_06 = self getweaponslistitems();
				var_07 = 0;
				for(var_08 = 0;var_08 < var_06.size;var_08++)
				{
					if(var_04 == var_06[var_08])
					{
						var_07 = 1;
						break;
					}
				}

				if(!var_07)
				{
					maps\mp\_utility::_giveweapon(var_04);
				}
				else if(issubstr(var_04,"airdrop_"))
				{
					self setweaponammoclip(var_04,1);
				}

				maps\mp\_utility::func_31F3(var_02 + 4,"weapon",var_04);
			}
		}

		self.killstreakindexweapon = undefined;
		self.pers["lastEarnedStreak"] = self.pers["killstreaks"][var_05].streakname;
		func_31DD();
		return;
	}

	self.killstreakindexweapon = undefined;
	self.pers["lastEarnedStreak"] = undefined;
	func_31DD();
}

//Function Number: 19
func_2DD6()
{
	for(var_00 = self.pers["killstreaks"].size - 1;var_00 > -1;var_00--)
	{
		if(isdefined(self.pers["killstreaks"][var_00]))
		{
			self.pers["killstreaks"][var_00] = undefined;
		}
	}

	initplayerkillstreaks();
	resetadrenaline();
	self.killstreakindexweapon = undefined;
	func_31DD();
}

//Function Number: 20
updatespecialistkillstreaks()
{
	if(self.adrenaline == 0)
	{
		for(var_00 = 1;var_00 < 4;var_00++)
		{
			if(isdefined(self.pers["killstreaks"][var_00]))
			{
				self.pers["killstreaks"][var_00].available = 0;
				self setplayerdata("killstreaksState","hasStreak",var_00,0);
			}
		}

		self setplayerdata("killstreaksState","nextIndex",1);
		self setplayerdata("killstreaksState","hasStreak",4,0);
	}
	else
	{
		for(var_00 = 1;var_00 < 4;var_00++)
		{
			if(isdefined(self.pers["killstreaks"][var_00]) && isdefined(self.pers["killstreaks"][var_00].streakname) && self.pers["killstreaks"][var_00].available)
			{
				var_01 = getstreakcost(self.pers["killstreaks"][var_00].streakname);
				if(var_01 > self.adrenaline)
				{
					self.pers["killstreaks"][var_00].available = 0;
					self setplayerdata("killstreaksState","hasStreak",var_00,0);
					continue;
				}

				if(self.adrenaline >= var_01)
				{
					if(self getplayerdata("killstreaksState","hasStreak",var_00))
					{
						if(isdefined(level.killstreakfuncs[self.pers["killstreaks"][var_00].streakname]))
						{
							self [[ level.killstreakfuncs[self.pers["killstreaks"][var_00].streakname] ]]();
						}

						continue;
					}

					givekillstreak(self.pers["killstreaks"][var_00].streakname,self.pers["killstreaks"][var_00].earned,0,self,1);
				}
			}
		}

		var_02 = 8;
		if(maps\mp\_utility::func_27AF("specialty_hardline"))
		{
			var_02--;
		}

		if(self.adrenaline >= var_02)
		{
			self setplayerdata("killstreaksState","hasStreak",4,1);
			giveallperks();
		}
		else
		{
			self setplayerdata("killstreaksState","hasStreak",4,0);
		}
	}

	if(self.pers["killstreaks"][0].available)
	{
		var_03 = self.pers["killstreaks"][0].streakname;
		var_04 = func_2C01(var_03);
		if(level.console)
		{
			func_31F2(var_04);
			self.killstreakindexweapon = 0;
			return;
		}

		maps\mp\_utility::_giveweapon(var_04);
		maps\mp\_utility::func_31F3(4,"weapon",var_04);
		self.killstreakindexweapon = undefined;
	}
}

//Function Number: 21
func_31E7()
{
	var_00 = self getweaponslistprimaries();
	return var_00[0];
}

//Function Number: 22
func_31E8()
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

	thread func_31EC();
	for(;;)
	{
		self waittill("weapon_change",var_00);
		if(!isalive(self))
		{
			continue;
		}

		if(!isdefined(self.killstreakindexweapon))
		{
			continue;
		}

		if(!isdefined(self.pers["killstreaks"][self.killstreakindexweapon]) || !isdefined(self.pers["killstreaks"][self.killstreakindexweapon].streakname))
		{
			continue;
		}

		var_01 = func_2C01(self.pers["killstreaks"][self.killstreakindexweapon].streakname);
		if(var_00 != var_01)
		{
			if(maps\mp\_utility::func_323E(var_00,"airdrop_"))
			{
				self takeweapon(var_00);
				self switchtoweapon(self.lastdroppableweapon);
			}

			continue;
		}

		waittillframeend;
		var_02 = self.pers["killstreaks"][self.killstreakindexweapon].streakname;
		var_03 = self.pers["killstreaks"][self.killstreakindexweapon].isgimme;
		var_04 = killstreakusepressed();
		var_05 = undefined;
		if(!var_04 && !isalive(self) && !self hasweapon(common_scripts\utility::getlastweapon()))
		{
			var_05 = common_scripts\utility::getlastweapon();
			maps\mp\_utility::_giveweapon(var_05);
		}
		else if(!self hasweapon(common_scripts\utility::getlastweapon()))
		{
			var_05 = func_31E7();
		}
		else
		{
			var_05 = common_scripts\utility::getlastweapon();
		}

		if(var_04)
		{
			thread waittakekillstreakweapon(var_01,var_05);
		}

		if(func_31EB(var_04,var_02))
		{
			self switchtoweapon(var_05);
		}

		if(self getcurrentweapon() == "none")
		{
			while(self getcurrentweapon() == "none")
			{
				wait 0.05;
			}

			waittillframeend;
		}
	}
}

//Function Number: 23
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
		takekillstreakweaponifnodupe(param_00);
		if(!level.console)
		{
			self.killstreakindexweapon = undefined;
			return;
		}

		return;
	}

	if(var_03 != param_00)
	{
		thread waittakekillstreakweapon(param_00,param_01);
		return;
	}

	if(var_02 && self getcurrentweapon() == param_00)
	{
		thread waittakekillstreakweapon(param_00,param_01);
		return;
	}
}

//Function Number: 24
takekillstreakweaponifnodupe(param_00)
{
	var_01 = 0;
	for(var_02 = 0;var_02 < self.pers["killstreaks"].size;var_02++)
	{
		if(isdefined(self.pers["killstreaks"][var_02]) && isdefined(self.pers["killstreaks"][var_02].streakname) && self.pers["killstreaks"][var_02].available)
		{
			if(!func_31F6(self.pers["killstreaks"][var_02].streakname) && param_00 == func_2C01(self.pers["killstreaks"][var_02].streakname))
			{
				var_01 = 1;
				break;
			}
		}
	}

	if(var_01)
	{
		if(level.console)
		{
			if(isdefined(self.killstreakindexweapon) && param_00 != func_2C01(self.pers["killstreaks"][self.killstreakindexweapon].streakname))
			{
				self takeweapon(param_00);
				return;
			}

			if(isdefined(self.killstreakindexweapon) && param_00 == func_2C01(self.pers["killstreaks"][self.killstreakindexweapon].streakname))
			{
				self takeweapon(param_00);
				maps\mp\_utility::_giveweapon(param_00,0);
				maps\mp\_utility::func_31F3(4,"weapon",param_00);
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

//Function Number: 25
func_31EB(param_00,param_01)
{
	switch(param_01)
	{
		case "uav_strike":
			if(!param_00)
			{
				return 0;
			}
	
			break;
	}

	if(!param_00)
	{
		return 1;
	}

	if(isridekillstreak(param_01))
	{
		return 0;
	}

	return 1;
}

//Function Number: 26
func_31EC()
{
	self endon("disconnect");
	level endon("game_ended");
	self notify("finishDeathWaiter");
	self endon("finishDeathWaiter");
	self waittill("death");
	wait 0.05;
	self notify("finish_death");
	self.pers["lastEarnedStreak"] = undefined;
}

//Function Number: 27
func_31ED()
{
	foreach(var_01 in self.killstreaks)
	{
		var_02 = getstreakcost(var_01);
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

//Function Number: 28
getcustomclassloc()
{
	if(getdvarint("xblive_privatematch"))
	{
		return "privateMatchCustomClasses";
	}

	return "customClasses";
}

//Function Number: 29
killstreakearned(param_00)
{
	var_01 = "assault";
	switch(self.streaktype)
	{
		case "assault":
			var_01 = "assaultStreaks";
			break;

		case "support":
			var_01 = "defenseStreaks";
			break;

		case "specialist":
			var_01 = "specialistStreaks";
			break;
	}

	if(isdefined(self.class_num))
	{
		var_02 = getcustomclassloc();
		if(self getplayerdata(var_02,self.class_num,var_01,0) == param_00)
		{
			self.firstkillstreakearned = gettime();
			return;
		}

		if(self getplayerdata(var_02,self.class_num,var_01,2) == param_00 && isdefined(self.firstkillstreakearned))
		{
			if(gettime() - self.firstkillstreakearned < 20000)
			{
				thread maps\mp\gametypes\_missions::genericchallenge("wargasm");
				return;
			}

			return;
		}
	}
}

//Function Number: 30
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
			if(maps\mp\gametypes\_class::func_31F1(var_03))
			{
				var_02 = "pro";
			}
		}

		thread maps\mp\gametypes\_hud_message::killstreaksplashnotify(param_00,param_01,var_02);
	}

	thread killstreakearned(param_00);
	self.pers["lastEarnedStreak"] = param_00;
	func_28ED();
	givekillstreak(param_00,1,1);
}

//Function Number: 31
givekillstreak(param_00,param_01,param_02,param_03,param_04)
{
	self endon("givingLoadout");
	if(!isdefined(level.killstreakfuncs[param_00]) || tablelookup("mp/killstreakTable.csv",1,param_00,0) == "")
	{
		return;
	}

	if(!isdefined(self.pers["killstreaks"]))
	{
		return;
	}

	self endon("disconnect");
	if(!isdefined(param_04))
	{
		param_04 = 0;
	}

	var_05 = undefined;
	if(!isdefined(param_01) || param_01 == 0)
	{
		var_06 = self.pers["killstreaks"].size;
		if(!isdefined(self.pers["killstreaks"][var_06]))
		{
			self.pers["killstreaks"][var_06] = spawnstruct();
		}

		self.pers["killstreaks"][var_06].available = 0;
		self.pers["killstreaks"][var_06].streakname = param_00;
		self.pers["killstreaks"][var_06].earned = 0;
		self.pers["killstreaks"][var_06].awardxp = isdefined(param_02) && param_02;
		self.pers["killstreaks"][var_06].owner = param_03;
		self.pers["killstreaks"][var_06].kid = self.pers["kID"];
		self.pers["killstreaks"][var_06].lifeid = -1;
		self.pers["killstreaks"][var_06].isgimme = 1;
		self.pers["killstreaks"][var_06].isspecialist = 0;
		self.pers["killstreaks"][0].nextslot = var_06;
		self.pers["killstreaks"][0].streakname = param_00;
		var_05 = 0;
		var_07 = getkillstreakindex(param_00);
		self setplayerdata("killstreaksState","icons",0,var_07);
		if(!param_04)
		{
			func_3202(param_00);
		}
	}
	else
	{
		for(var_08 = 1;var_08 < 4;var_08++)
		{
			if(isdefined(self.pers["killstreaks"][var_08]) && isdefined(self.pers["killstreaks"][var_08].streakname) && param_00 == self.pers["killstreaks"][var_08].streakname)
			{
				var_05 = var_08;
				break;
			}
		}

		if(!isdefined(var_05))
		{
			return;
		}
	}

	self.pers["killstreaks"][var_05].available = 1;
	self.pers["killstreaks"][var_05].earned = isdefined(param_01) && param_01;
	self.pers["killstreaks"][var_05].awardxp = isdefined(param_02) && param_02;
	self.pers["killstreaks"][var_05].owner = param_03;
	self.pers["killstreaks"][var_05].kid = self.pers["kID"];
	self.pers["kID"]++;
	if(!self.pers["killstreaks"][var_05].earned)
	{
		self.pers["killstreaks"][var_05].lifeid = -1;
	}
	else
	{
		self.pers["killstreaks"][var_05].lifeid = self.pers["deaths"];
	}

	if(self.streaktype == "specialist" && var_05 != 0)
	{
		self.pers["killstreaks"][var_05].isspecialist = 1;
		if(isdefined(level.killstreakfuncs[param_00]))
		{
			self [[ level.killstreakfuncs[param_00] ]]();
		}

		func_2C16(param_00,param_02);
	}
	else if(level.console)
	{
		var_09 = func_2C01(param_00);
		func_31F2(var_09);
		if(isdefined(self.killstreakindexweapon))
		{
			param_00 = self.pers["killstreaks"][self.killstreakindexweapon].streakname;
			var_0A = func_2C01(param_00);
			if(!iscurrentlyholdingkillstreakweapon(var_0A))
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
		if(0 == var_05 && self.pers["killstreaks"][0].nextslot > 5)
		{
			var_0B = self.pers["killstreaks"][0].nextslot - 1;
			var_0C = func_2C01(self.pers["killstreaks"][var_0B].streakname);
			self takeweapon(var_0C);
		}

		var_0A = func_2C01(param_00);
		maps\mp\_utility::_giveweapon(var_0A,0);
		maps\mp\_utility::func_31F3(var_05 + 4,"weapon",var_0A);
	}

	func_31DD();
	if(isdefined(level.killstreaksetupfuncs[param_00]))
	{
		self [[ level.killstreaksetupfuncs[param_00] ]]();
	}

	if(isdefined(param_01) && param_01 && isdefined(param_02) && param_02)
	{
		self notify("received_earned_killstreak");
	}
}

//Function Number: 32
iscurrentlyholdingkillstreakweapon(param_00)
{
	var_01 = self getcurrentweapon();
	switch(param_00)
	{
		case "killstreak_uav_mp":
			return var_01 == "killstreak_remote_uav_mp";
	}

	return var_01 == param_00;
}

//Function Number: 33
func_31F2(param_00)
{
	self endon("disconnect");
	if(!level.console)
	{
		return;
	}

	var_01 = self getweaponslistitems();
	foreach(var_03 in var_01)
	{
		if(!maps\mp\_utility::func_323E(var_03,"killstreak_") && !maps\mp\_utility::func_323E(var_03,"airdrop_") && !maps\mp\_utility::func_323E(var_03,"deployable_"))
		{
			continue;
		}

		if(self getcurrentweapon() == var_03 || isdefined(self.changingweapon) && self.changingweapon == var_03)
		{
			continue;
		}

		while(maps\mp\_utility::ischangingweapon())
		{
			wait 0.05;
		}

		self takeweapon(var_03);
	}

	if(isdefined(self.killstreakindexweapon))
	{
		var_05 = self.pers["killstreaks"][self.killstreakindexweapon].streakname;
		var_06 = func_2C01(var_05);
		if(self getcurrentweapon() != var_06)
		{
			maps\mp\_utility::_giveweapon(param_00,0);
			maps\mp\_utility::func_31F3(4,"weapon",param_00);
			return;
		}

		return;
	}

	maps\mp\_utility::_giveweapon(param_00,0);
	maps\mp\_utility::func_31F3(4,"weapon",param_00);
}

//Function Number: 34
getstreakcost(param_00)
{
	var_01 = int(tablelookup("mp/killstreakTable.csv",1,param_00,4));
	if(isdefined(self) && isplayer(self))
	{
		if(func_31F6(param_00))
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
				var_02 = getcustomclassloc();
				for(var_03 = 0;var_03 < 3;var_03++)
				{
					var_04 = self getplayerdata(var_02,self.class_num,"specialistStreaks",var_03);
					if(var_04 == param_00)
					{
						break;
					}
				}

				var_01 = self getplayerdata(var_02,self.class_num,"specialistStreakKills",var_03);
			}
			else if(issubstr(self.curclass,"axis") || issubstr(self.curclass,"allies"))
			{
				var_03 = 0;
				var_05 = "none";
				if(issubstr(self.curclass,"axis"))
				{
					var_05 = "axis";
				}
				else if(issubstr(self.curclass,"allies"))
				{
					var_05 = "allies";
				}

				var_06 = maps\mp\gametypes\_class::func_28BD(self.curclass);
				while(var_03 < 3)
				{
					var_04 = getmatchrulesdata("defaultClasses",var_05,var_06,"class","specialistStreaks",var_03);
					if(var_04 == param_00)
					{
						break;
					}

					var_03++;
				}

				var_01 = getmatchrulesdata("defaultClasses",var_05,var_06,"class","specialistStreakKills",var_03);
			}
		}

		if(maps\mp\_utility::func_27AF("specialty_hardline") && var_01 > 0)
		{
			var_01--;
		}
	}

	return var_01;
}

//Function Number: 35
func_31F4(param_00)
{
	switch(param_00)
	{
		case "littlebird_support":
		case "helicopter":
		case "airdrop_remote_tank":
		case "remote_mortar":
		case "ims":
		case "osprey_gunner":
		case "littlebird_flock":
		case "helicopter_flares":
		case "airdrop_juggernaut":
		case "airdrop_sentry_minigun":
		case "airdrop_assault":
		case "predator_missile":
		case "precision_airstrike":
		case "ac130":
		case "uav":
			return 1;

		default:
			return 0;
	}
}

//Function Number: 36
func_31F5(param_00)
{
	switch(param_00)
	{
		case "sam_turret":
		case "remote_uav":
		case "uav_support":
		case "airdrop_juggernaut_recon":
		case "remote_mg_turret":
		case "deployable_vest":
		case "escort_airdrop":
		case "airdrop_trap":
		case "stealth_airstrike":
		case "counter_uav":
		case "triple_uav":
		case "emp":
			return 1;

		default:
			return 0;
	}
}

//Function Number: 37
func_31F6(param_00)
{
	switch(param_00)
	{
		case "all_perks_bonus":
		case "specialty_stalker_ks":
		case "specialty_quieter_ks":
		case "specialty_bulletaccuracy_ks":
		case "specialty_autospot_ks":
		case "specialty_detectexplosive_ks":
		case "_specialty_blastshield_ks":
		case "specialty_assists_ks":
		case "specialty_quickdraw_ks":
		case "specialty_coldblooded_ks":
		case "specialty_hardline_ks":
		case "specialty_paint_ks":
		case "specialty_blindeye_ks":
		case "specialty_scavenger_ks":
		case "specialty_fastreload_ks":
		case "specialty_longersprint_ks":
			return 1;

		default:
			return 0;
	}
}

//Function Number: 38
func_31F7(param_00)
{
	return tablelookupistring("mp/killstreakTable.csv",1,param_00,6);
}

//Function Number: 39
getkillstreakinformenemy(param_00)
{
	return int(tablelookup("mp/killstreakTable.csv",1,param_00,11));
}

//Function Number: 40
func_31F9(param_00)
{
	return tablelookup("mp/killstreakTable.csv",1,param_00,7);
}

//Function Number: 41
getkillstreakdialog(param_00)
{
	return tablelookup("mp/killstreakTable.csv",1,param_00,8);
}

//Function Number: 42
func_2C01(param_00)
{
	return tablelookup("mp/killstreakTable.csv",1,param_00,12);
}

//Function Number: 43
getkillstreakicon(param_00)
{
	return tablelookup("mp/killstreakTable.csv",1,param_00,14);
}

//Function Number: 44
getkillstreakcrateicon(param_00)
{
	return tablelookup("mp/killstreakTable.csv",1,param_00,15);
}

//Function Number: 45
getkillstreakdpadicon(param_00)
{
	return tablelookup("mp/killstreakTable.csv",1,param_00,16);
}

//Function Number: 46
getkillstreakindex(param_00)
{
	return tablelookuprownum("mp/killstreakTable.csv",1,param_00) - 1;
}

//Function Number: 47
func_2CEC(param_00)
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

//Function Number: 48
giveownedkillstreakitem(param_00)
{
	if(level.console)
	{
		var_01 = -1;
		var_02 = -1;
		for(var_03 = 0;var_03 < 4;var_03++)
		{
			if(isdefined(self.pers["killstreaks"][var_03]) && isdefined(self.pers["killstreaks"][var_03].streakname) && self.pers["killstreaks"][var_03].available && getstreakcost(self.pers["killstreaks"][var_03].streakname) > var_02)
			{
				var_02 = 0;
				if(!self.pers["killstreaks"][var_03].isgimme)
				{
					var_02 = getstreakcost(self.pers["killstreaks"][var_03].streakname);
				}

				var_01 = var_03;
			}
		}

		if(var_01 != -1)
		{
			self.killstreakindexweapon = var_01;
			var_04 = self.pers["killstreaks"][self.killstreakindexweapon].streakname;
			var_05 = func_2C01(var_04);
			func_31F2(var_05);
			if(!isdefined(param_00) && !level.ingraceperiod)
			{
				func_3202(var_04);
			}
		}
		else
		{
			self.killstreakindexweapon = undefined;
		}
	}
	else
	{
		var_01 = -1;
		var_02 = -1;
		for(var_03 = 0;var_03 < 4;var_03++)
		{
			if(isdefined(self.pers["killstreaks"][var_03]) && isdefined(self.pers["killstreaks"][var_03].streakname) && self.pers["killstreaks"][var_03].available)
			{
				var_06 = func_2C01(self.pers["killstreaks"][var_03].streakname);
				var_07 = self getweaponslistitems();
				var_08 = 0;
				for(var_09 = 0;var_09 < var_07.size;var_09++)
				{
					if(var_06 == var_07[var_09])
					{
						var_08 = 1;
						break;
					}
				}

				if(!var_08)
				{
					maps\mp\_utility::_giveweapon(var_06);
				}
				else if(issubstr(var_06,"airdrop_"))
				{
					self setweaponammoclip(var_06,1);
				}

				maps\mp\_utility::func_31F3(var_03 + 4,"weapon",var_06);
				if(getstreakcost(self.pers["killstreaks"][var_03].streakname) > var_02)
				{
					var_02 = 0;
					if(!self.pers["killstreaks"][var_03].isgimme)
					{
						var_02 = getstreakcost(self.pers["killstreaks"][var_03].streakname);
					}

					var_01 = var_03;
				}
			}
		}

		if(var_01 != -1)
		{
			var_04 = self.pers["killstreaks"][var_01].streakname;
			if(!isdefined(param_00) && !level.ingraceperiod)
			{
				func_3202(var_04);
			}
		}

		self.killstreakindexweapon = undefined;
	}

	func_31DD();
}

//Function Number: 49
initridekillstreak(param_00)
{
	common_scripts\utility::_disableusability();
	var_01 = func_31FF(param_00);
	if(isdefined(self))
	{
		common_scripts\utility::_enableusability();
	}

	return var_01;
}

//Function Number: 50
func_31FF(param_00)
{
	if(isdefined(param_00) && param_00 == "osprey_gunner" || param_00 == "remote_uav" || param_00 == "remote_tank")
	{
		var_01 = "timeout";
	}
	else
	{
		var_01 = common_scripts\utility::waittill_any_timeout(1,"disconnect","death","weapon_switch_started");
	}

	maps\mp\gametypes\_hostmigration::func_273E();
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

	if(maps\mp\_utility::func_27E5() || maps\mp\_utility::func_3200() || maps\mp\_utility::func_2BE7())
	{
		return "fail";
	}

	self visionsetnakedforplayer("black_bw",0.75);
	var_02 = common_scripts\utility::waittill_any_timeout(0.8,"disconnect","death");
	maps\mp\gametypes\_hostmigration::func_273E();
	if(var_02 != "disconnect")
	{
		thread func_3195(1);
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

	if(maps\mp\_utility::func_27E5() || maps\mp\_utility::func_3200() || maps\mp\_utility::func_2BE7())
	{
		return "fail";
	}

	if(var_02 == "disconnect")
	{
		return "disconnect";
	}

	return "success";
}

//Function Number: 51
func_3195(param_00)
{
	self endon("disconnect");
	if(isdefined(param_00))
	{
		wait param_00;
	}

	if(isdefined(level.nukedetonated))
	{
		self visionsetnakedforplayer(level.nukevisionset,0);
		return;
	}

	self visionsetnakedforplayer("",0);
}

//Function Number: 52
func_3201()
{
	var_00 = self.pers["killstreaks"][self.killstreakindexweapon].streakname;
	var_01 = func_2C01(var_00);
	func_31F2(var_01);
	func_31DD();
}

//Function Number: 53
func_3202(param_00)
{
	var_01 = spawnstruct();
	var_01.name = "selected_" + param_00;
	var_01.type = "killstreak_minisplash";
	var_01.optionalnumber = getstreakcost(param_00);
	var_01.leadersound = param_00;
	var_01.leadersoundgroup = "killstreak_earned";
	var_01.slot = 0;
	self.notifytext.alpha = 0;
	self.notifytext2.alpha = 0;
	self.notifyicon.alpha = 0;
	thread maps\mp\gametypes\_hud_message::actionnotifymessage(var_01);
}

//Function Number: 54
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

//Function Number: 55
shufflekillstreaksup()
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

		func_3201();
		func_3202(self.pers["killstreaks"][self.killstreakindexweapon].streakname);
	}
}

//Function Number: 56
func_3207()
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

		func_3201();
		func_3202(self.pers["killstreaks"][self.killstreakindexweapon].streakname);
	}
}

//Function Number: 57
streakselectuptracker()
{
	self endon("death");
	self endon("disconnect");
	self endon("faux_spawn");
	level endon("game_ended");
	for(;;)
	{
		self waittill("toggled_up");
		if(!self ismantling() && !isdefined(self.changingweapon) || isdefined(self.changingweapon) && self.changingweapon == "none" && !maps\mp\_utility::func_2829(self getcurrentweapon()) || maps\mp\_utility::isjuggernautweapon(self getcurrentweapon()) && maps\mp\_utility::isjuggernaut() && self.streaktype != "specialist" && !isdefined(self.iscarrying) || isdefined(self.iscarrying) && self.iscarrying == 0 && !isdefined(self.laststreakused) || isdefined(self.laststreakused) && gettime() - self.laststreakused > 100)
		{
			shufflekillstreaksup();
		}

		wait 0.12;
	}
}

//Function Number: 58
func_3209()
{
	self endon("death");
	self endon("disconnect");
	self endon("faux_spawn");
	level endon("game_ended");
	for(;;)
	{
		self waittill("toggled_down");
		if(!self ismantling() && !isdefined(self.changingweapon) || isdefined(self.changingweapon) && self.changingweapon == "none" && !maps\mp\_utility::func_2829(self getcurrentweapon()) || maps\mp\_utility::isjuggernautweapon(self getcurrentweapon()) && maps\mp\_utility::isjuggernaut() && self.streaktype != "specialist" && !isdefined(self.iscarrying) || isdefined(self.iscarrying) && self.iscarrying == 0 && !isdefined(self.laststreakused) || isdefined(self.laststreakused) && gettime() - self.laststreakused > 100)
		{
			func_3207();
		}

		wait 0.12;
	}
}

//Function Number: 59
streakusetimetracker()
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

//Function Number: 60
func_320A()
{
	self endon("death");
	self endon("disconnect");
	level endon("game_ended");
	maps\mp\_utility::func_274B("prematch_done");
	if(level.console)
	{
		self notifyonplayercommand("toggled_up","+actionslot 1");
		self notifyonplayercommand("toggled_down","+actionslot 2");
		self notifyonplayercommand("streakUsed","+actionslot 4");
		self notifyonplayercommand("streakUsed","+actionslot 5");
		self notifyonplayercommand("streakUsed","+actionslot 6");
		self notifyonplayercommand("streakUsed","+actionslot 7");
		return;
	}

	self notifyonplayercommand("streakUsed1","+actionslot 4");
	self notifyonplayercommand("streakUsed2","+actionslot 5");
	self notifyonplayercommand("streakUsed3","+actionslot 6");
	self notifyonplayercommand("streakUsed4","+actionslot 7");
}

//Function Number: 61
registeradrenalineinfo(param_00,param_01)
{
	if(!isdefined(level.adrenalineinfo))
	{
		level.adrenalineinfo = [];
	}

	level.adrenalineinfo[param_00] = param_01;
}

//Function Number: 62
giveadrenaline(param_00)
{
	if(level.adrenalineinfo[param_00] == 0)
	{
		return;
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
		var_04 = 8;
		if(maps\mp\_utility::func_27AF("specialty_hardline"))
		{
			var_04--;
		}

		if(var_02 == var_04)
		{
			giveallperks();
			func_2C16("all_perks_bonus",1);
			thread maps\mp\gametypes\_hud_message::killstreaksplashnotify("all_perks_bonus",var_04);
			self setplayerdata("killstreaksState","hasStreak",4,1);
			self.pers["killstreaks"][4].available = 1;
		}

		if(var_03 > 0 && !var_02 - var_03 % 2)
		{
			thread maps\mp\gametypes\_rank::xpeventpopup(&"MP_SPECIALIST_STREAKING_XP");
			thread maps\mp\gametypes\_rank::func_2AB3("kill");
		}
	}

	func_320D(var_02);
	func_31ED();
	if(var_01 == var_03 && self.streaktype != "specialist")
	{
		func_320D(0);
	}
}

//Function Number: 63
giveallperks()
{
	var_00 = [];
	foreach(var_02 in var_41)
	{
		if(!maps\mp\_utility::func_27AF(var_02))
		{
			maps\mp\_utility::giveperk(var_02,0);
			if(maps\mp\gametypes\_class::func_31F1(var_02))
			{
				var_03 = tablelookup("mp/perktable.csv",1,var_02,8);
				maps\mp\_utility::giveperk(var_03,0);
			}
		}
	}
}

//Function Number: 64
resetadrenaline()
{
	self.earnedstreaklevel = 0;
	func_320D(0);
	resetstreakcount();
	if(isdefined(self.pers["lastEarnedStreak"]))
	{
		self.pers["lastEarnedStreak"] = undefined;
	}
}

//Function Number: 65
func_320D(param_00)
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
	func_31D8();
}

//Function Number: 66
pc_watchstreakuse()
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
		var_00 = common_scripts\utility::waittill_any_return("streakUsed1","streakUsed2","streakUsed3","streakUsed4");
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
			disablekillstreakactionslots();
			for(;;)
			{
				self waittill("weapon_change",var_01);
				if(isdefined(self.killstreakindexweapon))
				{
					var_02 = func_2C01(self.pers["killstreaks"][self.killstreakindexweapon].streakname);
					if(var_01 == var_02 || var_01 == "none" || var_02 == "killstreak_uav_mp" && var_01 == "killstreak_remote_uav_mp" || var_02 == "killstreak_uav_mp" && var_01 == "uav_remote_mp")
					{
						continue;
					}

					break;
				}

				break;
			}

			enablekillstreakactionslots();
			self.killstreakindexweapon = undefined;
		}
	}
}

//Function Number: 67
disablekillstreakactionslots()
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

		maps\mp\_utility::func_31F3(var_00 + 4,"");
		self.actionslotenabled[var_00] = 0;
	}
}

//Function Number: 68
enablekillstreakactionslots()
{
	for(var_00 = 0;var_00 < 4;var_00++)
	{
		if(self.pers["killstreaks"][var_00].available)
		{
			var_01 = func_2C01(self.pers["killstreaks"][var_00].streakname);
			maps\mp\_utility::func_31F3(var_00 + 4,"weapon",var_01);
		}
		else
		{
			maps\mp\_utility::func_31F3(var_00 + 4,"");
		}

		self.actionslotenabled[var_00] = 1;
	}
}

//Function Number: 69
killstreakhit(param_00,param_01,param_02)
{
	if(isdefined(param_01) && isplayer(param_00) && isdefined(param_02.owner) && isdefined(param_02.owner.team))
	{
		if(((level.teambased && param_02.owner.team != param_00.team) || !level.teambased) && param_00 != param_02.owner)
		{
			if(maps\mp\_utility::func_2829(param_01))
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
			param_00 thread maps\mp\gametypes\_gamelogic::func_2F59(param_01,1,"hits");
			var_03 = param_00 maps\mp\gametypes\_persistence::func_2845("totalShots");
			var_04 = param_00 maps\mp\gametypes\_persistence::func_2845("hits") + 1;
			if(var_04 <= var_03)
			{
				param_00 maps\mp\gametypes\_persistence::func_2846("hits",var_04);
				param_00 maps\mp\gametypes\_persistence::func_2846("misses",int(var_03 - var_04));
				param_00 maps\mp\gametypes\_persistence::func_2846("accuracy",int(var_04 * 10000 / var_03));
				return;
			}
		}
	}
}