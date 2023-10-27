/*******************************************************************
 * Decompiled By: Bog
 * Decompiled File: maps\mp\gametypes\_callbacksetup.gsc
 * Game: Call of Duty: Ghosts
 * Platform: PC
 * Function Count: 15
 * Decompile Time: 251 ms
 * Timestamp: 10/27/2023 1:17:53 AM
*******************************************************************/

//Function Number: 1
func_1DE6()
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
func_1DE2(param_00)
{
	self notify("disconnect");
	[[ level.callbackplayerdisconnect ]](param_00);
}

//Function Number: 4
codecallback_playerdamage(param_00,param_01,param_02,param_03,param_04,param_05,param_06,param_07,param_08,param_09)
{
	self endon("disconnect");
	param_05 = maps\mp\_utility::func_8DAC(param_05);
	[[ level.callbackplayerdamage ]](param_00,param_01,param_02,param_03,param_04,param_05,param_06,param_07,param_08,param_09);
}

//Function Number: 5
codecallback_playerkilled(param_00,param_01,param_02,param_03,param_04,param_05,param_06,param_07,param_08)
{
	self endon("disconnect");
	param_04 = maps\mp\_utility::func_8DAC(param_04);
	[[ level.callbackplayerkilled ]](param_00,param_01,param_02,param_03,param_04,param_05,param_06,param_07,param_08);
}

//Function Number: 6
codecallback_vehicledamage(param_00,param_01,param_02,param_03,param_04,param_05,param_06,param_07,param_08,param_09,param_0A,param_0B)
{
	param_05 = maps\mp\_utility::func_8DAC(param_05);
	if(isdefined(self.damagecallback))
	{
		self [[ self.damagecallback ]](param_00,param_01,param_02,param_03,param_04,param_05,param_06,param_07,param_08,param_09,param_0A,param_0B);
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
	param_04 = maps\mp\_utility::func_8DAC(param_04);
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
func_71F0()
{
	func_7015();
	setupdamageflags();
}

//Function Number: 13
func_7015()
{
	level.callbackstartgametype = ::maps\mp\gametypes\_gamelogic::callback_startgametype;
	level.callbackplayerconnect = ::maps\mp\gametypes\_playerlogic::callback_playerconnect;
	level.callbackplayerdisconnect = ::maps\mp\gametypes\_playerlogic::func_194A;
	level.callbackplayerdamage = ::maps\mp\gametypes\_damage::callback_playerdamage;
	level.callbackplayerkilled = ::maps\mp\gametypes\_damage::func_194B;
	level.callbackcodeendgame = ::maps\mp\gametypes\_gamelogic::func_1944;
	level.callbackplayerlaststand = ::maps\mp\gametypes\_damage::callback_playerlaststand;
	level.callbackplayermigrated = ::maps\mp\gametypes\_playerlogic::callback_playermigrated;
	level.callbackhostmigration = ::maps\mp\gametypes\_hostmigration::func_1945;
}

//Function Number: 14
abortlevel()
{
	level.callbackstartgametype = ::func_195C;
	level.callbackplayerconnect = ::func_195C;
	level.callbackplayerdisconnect = ::func_195C;
	level.callbackplayerdamage = ::func_195C;
	level.callbackplayerkilled = ::func_195C;
	level.callbackcodeendgame = ::func_195C;
	level.callbackplayerlaststand = ::func_195C;
	level.callbackplayermigrated = ::func_195C;
	level.callbackhostmigration = ::func_195C;
	setdvar("g_gametype","dm");
	exitlevel(0);
}

//Function Number: 15
func_195C()
{
}