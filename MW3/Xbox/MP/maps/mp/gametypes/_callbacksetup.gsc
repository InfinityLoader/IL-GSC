/*******************************************************************
 * Decompiled By: Bog
 * Decompiled File: maps\mp\gametypes\_callbacksetup.gsc
 * Game: Call of Duty: Modern Warfare 3
 * Platform: Console
 * Function Count: 15
 * Decompile Time: 205 ms
 * Timestamp: 10/27/2023 2:25:12 AM
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
codecallback_playerdisconnect()
{
	self notify("disconnect");
	[[ level.callbackplayerdisconnect ]]();
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
codecallback_vehicledamage(param_00,param_01,param_02,param_03,param_04,param_05,param_06,param_07,param_08,param_09,param_0A,param_0B)
{
	if(isdefined(self.damagecallback))
	{
		self [[ self.damagecallback ]](param_00,param_01,param_02,param_03,param_04,param_05,param_06,param_07,param_08,param_09,param_0A,param_0B);
		return;
	}

	self vehicle_finishdamage(param_00,param_01,param_02,param_03,param_04,param_05,param_06,param_07,param_08,param_09,param_0A,param_0B);
}

//Function Number: 7
codecallback_codeendgame()
{
	self endon("disconnect");
	[[ level.callbackcodeendgame ]]();
}

//Function Number: 8
codecallback_playerlaststand(param_00,param_01,param_02,param_03,param_04,param_05,param_06,param_07,param_08)
{
	self endon("disconnect");
	[[ level.callbackplayerlaststand ]](param_00,param_01,param_02,param_03,param_04,param_05,param_06,param_07,param_08);
}

//Function Number: 9
codecallback_playermigrated()
{
	self endon("disconnect");
	[[ level.callbackplayermigrated ]]();
}

//Function Number: 10
codecallback_hostmigration()
{
	[[ level.callbackhostmigration ]]();
}

//Function Number: 11
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

//Function Number: 12
setupcallbacks()
{
	setdefaultcallbacks();
	setupdamageflags();
}

//Function Number: 13
setdefaultcallbacks()
{
	level.callbackstartgametype = ::maps\mp\gametypes\_gamelogic::func_2F22;
	level.callbackplayerconnect = ::maps\mp\gametypes\_playerlogic::callback_playerconnect;
	level.callbackplayerdisconnect = ::maps\mp\gametypes\_playerlogic::func_2B4B;
	level.callbackplayerdamage = ::maps\mp\gametypes\_damage::func_2D32;
	level.callbackplayerkilled = ::maps\mp\gametypes\_damage::callback_playerkilled;
	level.callbackcodeendgame = ::maps\mp\gametypes\_gamelogic::func_2F2D;
	level.callbackplayerlaststand = ::maps\mp\gametypes\_damage::func_2D34;
	level.callbackplayermigrated = ::maps\mp\gametypes\_playerlogic::callback_playermigrated;
	level.callbackhostmigration = ::maps\mp\gametypes\_hostmigration::callback_hostmigration;
}

//Function Number: 14
abortlevel()
{
	level.callbackstartgametype = ::callbackvoid;
	level.callbackplayerconnect = ::callbackvoid;
	level.callbackplayerdisconnect = ::callbackvoid;
	level.callbackplayerdamage = ::callbackvoid;
	level.callbackplayerkilled = ::callbackvoid;
	level.callbackcodeendgame = ::callbackvoid;
	level.callbackplayerlaststand = ::callbackvoid;
	level.callbackplayermigrated = ::callbackvoid;
	level.callbackhostmigration = ::callbackvoid;
	setdvar("g_gametype","dm");
	exitlevel(0);
}

//Function Number: 15
callbackvoid()
{
}