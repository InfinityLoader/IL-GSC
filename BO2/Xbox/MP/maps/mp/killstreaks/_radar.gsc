/*******************************************************************
 * Decompiled By: Bog
 * Decompiled File: maps\mp\killstreaks\_radar.gsc
 * Game: Call of Duty: Black Ops 2
 * Platform: Console
 * Function Count: 13
 * Decompile Time: 323 ms
 * Timestamp: 10/27/2023 3:04:47 AM
*******************************************************************/

#include common_scripts/utility;
#include maps/mp/_popups;
#include maps/mp/_utility;
#include maps/mp/gametypes/_tweakables;
#include maps/mp/killstreaks/_killstreakrules;
#include maps/mp/killstreaks/_killstreaks;
#include maps/mp/killstreaks/_spyplane;

//Function Number: 1
init()
{
	setmatchflag("radar_allies",0);
	setmatchflag("radar_axis",0);
	level.spyplane = [];
	level.counterspyplane = [];
	level.satellite = [];
	level.spyplanetype = [];
	level.satellitetype = [];
	level.radartimers = [];
	foreach(team in level.teams)
	{
		level.radartimers[team] = GetTime();
	}

	level.spyplaneviewtime = 25;
	level.counteruavviewtime = 30;
	level.radarlongviewtime = 45;
	if(maps/mp/gametypes/_tweakables::gettweakablevalue("killstreak","allowradar"))
	{
		maps/mp/killstreaks/_killstreaks::registerkillstreak("radar_mp","radar_mp","killstreak_spyplane","uav_used",::usekillstreakradar);
		maps/mp/killstreaks/_killstreaks::registerkillstreakstrings("radar_mp",&"KILLSTREAK_EARNED_RADAR",&"KILLSTREAK_RADAR_NOT_AVAILABLE",&"KILLSTREAK_RADAR_INBOUND");
		maps/mp/killstreaks/_killstreaks::registerkillstreakdialog("radar_mp","mpl_killstreak_radar","kls_u2_used","","kls_u2_enemy","","kls_u2_ready");
		maps/mp/killstreaks/_killstreaks::registerkillstreakdevdvar("radar_mp","scr_giveradar");
		maps/mp/killstreaks/_killstreaks::createkillstreaktimer("radar_mp");
	}

	if(maps/mp/gametypes/_tweakables::gettweakablevalue("killstreak","allowcounteruav"))
	{
		maps/mp/killstreaks/_killstreaks::registerkillstreak("counteruav_mp","counteruav_mp","killstreak_counteruav","counteruav_used",::usekillstreakcounteruav);
		maps/mp/killstreaks/_killstreaks::registerkillstreakstrings("counteruav_mp",&"KILLSTREAK_EARNED_COUNTERUAV",&"KILLSTREAK_COUNTERUAV_NOT_AVAILABLE",&"KILLSTREAK_COUNTERUAV_INBOUND");
		maps/mp/killstreaks/_killstreaks::registerkillstreakdialog("counteruav_mp","mpl_killstreak_radar","kls_cu2_used","","kls_cu2_enemy","","kls_cu2_ready");
		maps/mp/killstreaks/_killstreaks::registerkillstreakdevdvar("counteruav_mp","scr_givecounteruav");
		maps/mp/killstreaks/_killstreaks::createkillstreaktimer("counteruav_mp");
	}

	if(maps/mp/gametypes/_tweakables::gettweakablevalue("killstreak","allowradardirection"))
	{
		maps/mp/killstreaks/_killstreaks::registerkillstreak("radardirection_mp","radardirection_mp","killstreak_spyplane_direction","uav_used",::usekillstreaksatellite);
		maps/mp/killstreaks/_killstreaks::registerkillstreakstrings("radardirection_mp",&"KILLSTREAK_EARNED_SATELLITE",&"KILLSTREAK_SATELLITE_NOT_AVAILABLE",&"KILLSTREAK_SATELLITE_INBOUND");
		maps/mp/killstreaks/_killstreaks::registerkillstreakdialog("radardirection_mp","mpl_killstreak_satellite","kls_sat_used","","kls_sat_enemy","","kls_sat_ready");
		maps/mp/killstreaks/_killstreaks::registerkillstreakdevdvar("radardirection_mp","scr_giveradardirection");
		maps/mp/killstreaks/_killstreaks::createkillstreaktimer("radardirection_mp");
	}
}

//Function Number: 2
usekillstreakradar(hardpointtype)
{
	if(self maps/mp/killstreaks/_killstreakrules::iskillstreakallowed(hardpointtype,self.team) == 0)
	{
		return 0;
	}

	killstreak_id = self maps/mp/killstreaks/_killstreakrules::killstreakstart(hardpointtype,self.team);
	if(killstreak_id == -1)
	{
		return 0;
	}

	return self maps/mp/killstreaks/_spyplane::callspyplane(hardpointtype,0,killstreak_id);
}

//Function Number: 3
usekillstreakcounteruav(hardpointtype)
{
	if(self maps/mp/killstreaks/_killstreakrules::iskillstreakallowed(hardpointtype,self.team) == 0)
	{
		return 0;
	}

	killstreak_id = self maps/mp/killstreaks/_killstreakrules::killstreakstart(hardpointtype,self.team);
	if(killstreak_id == -1)
	{
		return 0;
	}

	return self maps/mp/killstreaks/_spyplane::callcounteruav(hardpointtype,0,killstreak_id);
}

//Function Number: 4
usekillstreaksatellite(hardpointtype)
{
	if(self maps/mp/killstreaks/_killstreakrules::iskillstreakallowed(hardpointtype,self.team) == 0)
	{
		return 0;
	}

	killstreak_id = self maps/mp/killstreaks/_killstreakrules::killstreakstart(hardpointtype,self.team);
	if(killstreak_id == -1)
	{
		return 0;
	}

	return self maps/mp/killstreaks/_spyplane::callsatellite(hardpointtype,0,killstreak_id);
}

//Function Number: 5
teamhasspyplane(team)
{
	return getteamspyplane(team) > 0;
}

//Function Number: 6
teamhassatellite(team)
{
	return getteamsatellite(team) > 0;
}

//Function Number: 7
useradaritem(hardpointtype,team,displaymessage)
{
	team = self.team;
/#
	assert(IsDefined(level.players));
#/
	self maps/mp/killstreaks/_killstreaks::playkillstreakstartdialog(hardpointtype,team);
	if(level.teambased)
	{
		if(!(IsDefined(level.spyplane[team])))
		{
			level.spyplanetype[team] = 0;
		}

		currenttypespyplane = level.spyplanetype[team];
		if(!(IsDefined(level.satellitetype[team])))
		{
			level.satellitetype[team] = 0;
		}

		currenttypesatellite = level.satellitetype[team];
	}
	else
	{
		if(!(IsDefined(self.pers["spyplaneType"])))
		{
			self.pers["spyplaneType"] = 0;
		}

		currenttypespyplane = self.pers["spyplaneType"];
		if(!(IsDefined(self.pers["satelliteType"])))
		{
			self.pers["satelliteType"] = 0;
		}

		currenttypesatellite = self.pers["satelliteType"];
	}

	radarviewtype = 0;
	normal = 1;
	fastsweep = 2;
	notifystring = "";
	issatellite = 0;
	isradar = 0;
	iscounteruav = 0;
	viewtime = level.spyplaneviewtime;
	switch(hardpointtype)
	{
		case "€GSC\r\n":
			notifystring = "spyplane";
			isradar = 1;
			viewtime = level.spyplaneviewtime;
			level.globalkillstreakscalled++;
			self addweaponstat(hardpointtype,"used",1);
			break;

		case "€GSC\r\n":
			notifystring = "satellite";
			issatellite = 1;
			viewtime = level.radarlongviewtime;
			level notify("satelliteInbound",team,self);
			level.globalkillstreakscalled++;
			self addweaponstat(hardpointtype,"used",1);
			break;

		case "€GSC\r\n":
			notifystring = "counteruav";
			iscounteruav = 1;
			viewtime = level.counteruavviewtime;
			level.globalkillstreakscalled++;
			self addweaponstat(hardpointtype,"used",1);
			break;
	}

	if(displaymessage)
	{
		if(IsDefined(level.killstreaks[hardpointtype]) && IsDefined(level.killstreaks[hardpointtype].inboundtext))
		{
			level thread maps/mp/_popups::displaykillstreakteammessagetoall(hardpointtype,self);
		}
	}

	return viewtime;
}

//Function Number: 8
resetspyplanetypeonend(type)
{
	self waittill(type + "_timer_kill");
	self.pers["spyplane"] = 0;
}

//Function Number: 9
resetsatellitetypeonend(type)
{
	self waittill(type + "_timer_kill");
	self.pers["satellite"] = 0;
}

//Function Number: 10
setteamspyplanewrapper(team,value)
{
	setteamspyplane(team,value);
	if(team == "allies")
	{
		setmatchflag("radar_allies",value);
	}
	else if(team == "axis")
	{
		setmatchflag("radar_axis",value);
	}

	if(level.multiteam == 1)
	{
		foreach(player in level.players)
		{
			if(player.team == team)
			{
				player setclientuivisibilityflag("radar_client",value);
			}
		}
	}

	level notify("radar_status_change",team,_k205);
}

//Function Number: 11
setteamsatellitewrapper(team,value)
{
	setteamsatellite(team,value);
	if(team == "allies")
	{
		setmatchflag("radar_allies",value);
	}
	else if(team == "axis")
	{
		setmatchflag("radar_axis",value);
	}

	if(level.multiteam == 1)
	{
		foreach(player in level.players)
		{
			if(player.team == team)
			{
				player setclientuivisibilityflag("radar_client",value);
			}
		}
	}

	level notify("radar_status_change",team,_k228);
}

//Function Number: 12
enemyobituarytext(type,numseconds)
{
	switch(type)
	{
		case "€GSC\r\n":
			self iprintln(&"MP_WAR_RADAR_ACQUIRED_UPDATE_ENEMY",numseconds);
			break;

		case "€GSC\r\n":
			self iprintln(&"MP_WAR_RADAR_ACQUIRED_DIRECTION_ENEMY",numseconds);
			break;

		case "€GSC\r\n":
			self iprintln(&"MP_WAR_RADAR_COUNTER_UAV_ACQUIRED_ENEMY",numseconds);
			break;

		default:
			self iprintln(&"MP_WAR_RADAR_ACQUIRED_ENEMY",numseconds);
			break;
	}
}

//Function Number: 13
friendlyobituarytext(type,callingplayer,numseconds)
{
	switch(type)
	{
		case "€GSC\r\n":
			self iprintln(&"MP_WAR_RADAR_UPDATE_ACQUIRED",callingplayer,numseconds);
			break;

		case "€GSC\r\n":
			self iprintln(&"MP_WAR_RADAR_DIRECTION_ACQUIRED",callingplayer,numseconds);
			break;

		case "€GSC\r\n":
			self iprintln(&"MP_WAR_RADAR_COUNTER_UAV_ACQUIRED",numseconds);
			break;

		default:
			self iprintln(&"MP_WAR_RADAR_ACQUIRED",callingplayer,numseconds);
			break;
	}
}