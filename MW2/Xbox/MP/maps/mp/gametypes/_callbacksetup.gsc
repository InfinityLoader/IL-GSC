/*******************************************************************
 * Decompiled By: Bog
 * Decompiled File: maps\mp\gametypes\_callbacksetup.gsc
 * Game: Call of Duty: Modern Warfare 2
 * Platform: Xbox
*******************************************************************/

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
		return;
	}
}

codecallback_playerconnect()
{
	if(getdvar("r_reflectionProbeGenerate") == "1")
	{
		level waittill("eternity");
	}

	self endon("disconnect");
	[[ level.callbackplayerconnect ]]();
}

codecallback_playerdisconnect()
{
	self notify("disconnect");
	[[ level.callbackplayerdisconnect ]]();
}

codecallback_playerdamage(einflictor, eattacker, idamage, idflags, smeansofdeath, sweapon, vpoint, vdir, shitloc, timeoffset)
{
	self endon("disconnect");
	[[ level.callbackplayerdamage ]](einflictor, eattacker, idamage, idflags, smeansofdeath, sweapon, vpoint, vdir, shitloc, timeoffset);
}

codecallback_playerkilled(einflictor, eattacker, idamage, smeansofdeath, sweapon, vdir, shitloc, timeoffset, deathanimduration)
{
	self endon("disconnect");
	[[ level.callbackplayerkilled ]](einflictor, eattacker, idamage, smeansofdeath, sweapon, vdir, shitloc, timeoffset, deathanimduration);
}

codecallback_vehicledamage(inflictor, attacker, damage, dflags, meansofdeath, weapon, point, dir, hitloc, timeoffset, modelindex, partname)
{
	if(isdefined(self.damagecallback))
	{
		self [[ self.damagecallback ]](inflictor, attacker, damage, dflags, meansofdeath, weapon, point, dir, hitloc, timeoffset, modelindex, partname);
		return;
	}

	self vehicle_finishdamage(inflictor, attacker, damage, dflags, meansofdeath, weapon, point, dir, hitloc, timeoffset, modelindex, partname);
}

codecallback_codeendgame()
{
	self endon("disconnect");
	[[ level.callbackcodeendgame ]]();
}

codecallback_playerlaststand(einflictor, eattacker, idamage, smeansofdeath, sweapon, vdir, shitloc, timeoffset, deathanimduration)
{
	self endon("disconnect");
	[[ level.callbackplayerlaststand ]](einflictor, eattacker, idamage, smeansofdeath, sweapon, vdir, shitloc, timeoffset, deathanimduration);
}

codecallback_playermigrated()
{
	self endon("disconnect");
	[[ level.callbackplayermigrated ]]();
}

codecallback_hostmigration()
{
	[[ level.callbackhostmigration ]]();
}

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

setupcallbacks()
{
	setdefaultcallbacks();
	setupdamageflags();
}

setdefaultcallbacks()
{
	level.callbackstartgametype = ::maps\mp\gametypes\_gamelogic::callback_startgametype;
	level.callbackplayerconnect = ::maps\mp\gametypes\_playerlogic::callback_playerconnect;
	level.callbackplayerdisconnect = ::maps\mp\gametypes\_playerlogic::callback_playerdisconnect;
	level.callbackplayerdamage = ::maps\mp\gametypes\_damage::callback_playerdamage;
	level.callbackplayerkilled = ::maps\mp\gametypes\_damage::callback_playerkilled;
	level.callbackcodeendgame = ::maps\mp\gametypes\_gamelogic::callback_codeendgame;
	level.callbackplayerlaststand = ::maps\mp\gametypes\_damage::callback_playerlaststand;
	level.callbackplayermigrated = ::maps\mp\gametypes\_playerlogic::callback_playermigrated;
	level.callbackhostmigration = ::maps\mp\gametypes\_hostmigration::callback_hostmigration;
}

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
	setdvar("g_gametype", "dm");
	exitlevel(0);
}

callbackvoid()
{
}