/*******************************************************************
 * Decompiled By: Bog
 * Decompiled File: mp\gametypes\_callbacksetup.gsc
 * Game: Call of Duty: Advanced Warfare
 * Platform: PC
 * Function Count: 22
 * Decompile Time: 340 ms
 * Timestamp: 4/22/2024 2:09:06 AM
*******************************************************************/

//Function Number: 1
codecallback_startgametype()
{
	if(getdvar("r_reflectionProbeGenerate") == "1")
	{
		level waittill("eternity");
	}

	if(!isdefined(level.gametypestarted) || !level.gametypestarted)
	{
		[[ level.callbackstartgametype ]]();
		level.gametypestarted = 1;
	}
}

//Function Number: 2
codecallback_playerconnect()
{
	if(getdvar("r_reflectionProbeGenerate") == "1")
	{
		level waittill("eternity");
	}

	self endon("disconnect");
	[[ level.callbackplayerconnect ]]();
}

//Function Number: 3
codecallback_playerdisconnect(param_00)
{
	self notify("disconnect");
	[[ level.callbackplayerdisconnect ]](param_00);
}

//Function Number: 4
codecallback_playerdamage(param_00,param_01,param_02,param_03,param_04,param_05,param_06,param_07,param_08,param_09)
{
	self endon("disconnect");
	[[ level.callbackplayerdamage ]](param_00,param_01,param_02,param_03,param_04,param_05,param_06,param_07,param_08,param_09);
}

//Function Number: 5
codecallback_playerkilled(param_00,param_01,param_02,param_03,param_04,param_05,param_06,param_07,param_08)
{
	self endon("disconnect");
	[[ level.callbackplayerkilled ]](param_00,param_01,param_02,param_03,param_04,param_05,param_06,param_07,param_08);
}

//Function Number: 6
codecallback_playergrenadesuicide(param_00,param_01,param_02,param_03,param_04,param_05,param_06,param_07)
{
	self endon("disconnect");
	[[ level.callbackplayergrenadesuicide ]](param_00,param_01,param_02,param_03,param_04,param_05,param_06,param_07);
}

//Function Number: 7
codecallback_entityoutofworld()
{
	self endon("disconnect");
	[[ level.callbackentityoutofworld ]]();
}

//Function Number: 8
codecallback_bullethitentity(param_00,param_01,param_02,param_03,param_04,param_05)
{
	self endon("disconnect");
	if(isdefined(self.bullethitcallback))
	{
		[[ self.bullethitcallback ]](param_00,param_01,param_02,param_03,param_04,param_05);
	}
}

//Function Number: 9
codecallback_vehicledamage(param_00,param_01,param_02,param_03,param_04,param_05,param_06,param_07,param_08,param_09,param_0A,param_0B)
{
	if(isdefined(self.damagecallback))
	{
		self [[ self.damagecallback ]](param_00,param_01,param_02,param_03,param_04,param_05,param_06,param_07,param_08,param_09,param_0A,param_0B);
		return;
	}

	self vehicle_finishdamage(param_00,param_01,param_02,param_03,param_04,param_05,param_06,param_07,param_08,param_09,param_0A,param_0B);
}

//Function Number: 10
codecallback_entitydamage(param_00,param_01,param_02,param_03,param_04,param_05,param_06,param_07,param_08,param_09,param_0A,param_0B)
{
	if(isdefined(self.damagecallback))
	{
		self [[ self.damagecallback ]](param_00,param_01,param_02,param_03,param_04,param_05,param_06,param_07,param_08,param_09,param_0A,param_0B);
		return;
	}

	self finishentitydamage(param_00,param_01,param_02,param_03,param_04,param_05,param_06,param_07,param_08,param_09,param_0A,param_0B);
}

//Function Number: 11
codecallback_codeendgame()
{
	self endon("disconnect");
	[[ level.callbackcodeendgame ]]();
}

//Function Number: 12
codecallback_playerlaststand(param_00,param_01,param_02,param_03,param_04,param_05,param_06,param_07,param_08)
{
	self endon("disconnect");
	[[ level.callbackplayerlaststand ]](param_00,param_01,param_02,param_03,param_04,param_05,param_06,param_07,param_08);
}

//Function Number: 13
codecallback_playermigrated()
{
	self endon("disconnect");
	[[ level.callbackplayermigrated ]]();
}

//Function Number: 14
codecallback_hostmigration()
{
	[[ level.callbackhostmigration ]]();
}

//Function Number: 15
codecallback_givekillstreak(param_00,param_01)
{
	if(isbot(param_00) || istestclient(param_00) || param_00.team == "spectator" || param_00.sessionstate == "spectator")
	{
		return;
	}

	if((isdefined(level.killstreakfuncs[param_01]) && tablelookup("mp/killstreakTable.csv",1,param_01,0) != "") || issubstr(param_01,"turrethead"))
	{
		if(issubstr(param_01,"turrethead"))
		{
			param_00 thread maps\mp\killstreaks\_rippedturret::playergiveturrethead(param_01);
			return;
		}

		var_02 = param_00 maps\mp\killstreaks\_killstreaks::getstreakcost(param_01);
		var_03 = param_00 maps\mp\killstreaks\_killstreaks::getkillstreakmodules(param_00,param_01);
		var_04 = param_00 maps\mp\killstreaks\_killstreaks::getnextkillstreakslotindex(param_01);
		param_00 thread maps\mp\gametypes\_hud_message::killstreaksplashnotify(param_01,var_02,undefined,var_03,var_04);
		param_00 maps\mp\killstreaks\_killstreaks::givekillstreak(param_01);
	}
}

//Function Number: 16
codecallback_givekillstreakmodule(param_00,param_01)
{
	if(isbot(param_00) || istestclient(param_00) || param_00.team == "spectator" || param_00.sessionstate == "spectator")
	{
		return;
	}

	var_02 = maps\mp\killstreaks\_killstreaks::getstreakmodulebasekillstreak(param_01);
	if(isdefined(var_02) && var_02 != "")
	{
		if(!isdefined(param_00.killstreakmodules[param_01]))
		{
			var_03 = maps\mp\killstreaks\_killstreaks::getstreakmodulecost(param_01);
			param_00.killstreakmodules[param_01] = var_03;
			return;
		}

		param_00.killstreakmodules[param_01] = undefined;
	}
}

//Function Number: 17
codecallback_partymembers(param_00)
{
	if(isdefined(level.partymembers_cb))
	{
		[[ level.partymembers_cb ]](param_00);
	}
}

//Function Number: 18
setupdamageflags()
{
	level.idflags_radius = 1;
	level.idflags_no_armor = 2;
	level.idflags_no_knockback = 4;
	level.idflags_penetration = 8;
	level.idflags_stun = 16;
	level.idflags_shield_explosive_impact = 32;
	level.idflags_shield_explosive_impact_huge = 64;
	level.idflags_shield_explosive_splash = 128;
	level.idflags_no_team_protection = 256;
	level.idflags_no_protection = 512;
	level.idflags_passthru = 1024;
}

//Function Number: 19
setupcallbacks()
{
	setdefaultcallbacks();
	setupdamageflags();
}

//Function Number: 20
setdefaultcallbacks()
{
	level.callbackstartgametype = ::maps\mp\gametypes\_gamelogic::callback_startgametype;
	level.callbackplayerconnect = ::maps\mp\gametypes\_playerlogic::callback_playerconnect;
	level.callbackplayerdisconnect = ::maps\mp\gametypes\_playerlogic::callback_playerdisconnect;
	level.callbackplayerdamage = ::maps\mp\gametypes\_damage::callback_playerdamage;
	level.callbackplayerkilled = ::maps\mp\gametypes\_damage::callback_playerkilled;
	level.callbackentityoutofworld = ::maps\mp\gametypes\_damage::callback_entityoutofworld;
	level.callbackplayergrenadesuicide = ::maps\mp\gametypes\_damage::callback_playergrenadesuicide;
	level.callbackcodeendgame = ::maps\mp\gametypes\_gamelogic::callback_codeendgame;
	level.callbackplayerlaststand = ::maps\mp\gametypes\_damage::callback_playerlaststand;
	level.callbackplayermigrated = ::maps\mp\gametypes\_playerlogic::callback_playermigrated;
	level.callbackhostmigration = ::maps\mp\gametypes\_hostmigration::callback_hostmigration;
}

//Function Number: 21
abortlevel()
{
	level.callbackstartgametype = ::callbackvoid;
	level.callbackplayerconnect = ::callbackvoid;
	level.callbackplayerdisconnect = ::callbackvoid;
	level.callbackplayerdamage = ::callbackvoid;
	level.callbackplayerkilled = ::callbackvoid;
	level.callbackentityoutofworld = ::callbackvoid;
	level.callbackplayergrenadesuicide = ::callbackvoid;
	level.callbackcodeendgame = ::callbackvoid;
	level.callbackplayerlaststand = ::callbackvoid;
	level.callbackplayermigrated = ::callbackvoid;
	level.callbackhostmigration = ::callbackvoid;
	setdvar("g_gametype","dm");
	exitlevel(0);
}

//Function Number: 22
callbackvoid()
{
}