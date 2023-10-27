/*******************************************************************
 * Decompiled By: Bog
 * Decompiled File: maps\mp\gametypes\_damage.gsc
 * Game: Call of Duty: Modern Warfare 3
 * Platform: PC
 * Function Count: 71
 * Decompile Time: 1169 ms
 * Timestamp: 10/27/2023 2:12:19 AM
*******************************************************************/

//Function Number: 1
isswitchingteams()
{
	if(isdefined(self.switching_teams))
	{
		return 1;
	}

	return 0;
}

//Function Number: 2
isteamswitchbalanced()
{
	var_00 = maps\mp\gametypes\_teams::countplayers();
	var_43[self.leaving_team];
	var_42[self.joining_team];
	return var_42[self.joining_team] - var_42[self.leaving_team] < 2;
}

//Function Number: 3
isfriendlyfire(param_00,param_01)
{
	if(!level.teambased)
	{
		return 0;
	}

	if(!isdefined(param_01))
	{
		return 0;
	}

	if(!isplayer(param_01) && !isdefined(param_01.team))
	{
		return 0;
	}

	if(param_00.team != param_01.team)
	{
		return 0;
	}

	if(param_00 == param_01)
	{
		return 0;
	}

	return 1;
}

//Function Number: 4
killedself(param_00)
{
	if(!isplayer(param_00))
	{
		return 0;
	}

	if(param_00 != self)
	{
		return 0;
	}

	return 1;
}

//Function Number: 5
isheadshot(param_00,param_01,param_02,param_03)
{
	if(isdefined(param_03))
	{
		if(param_03.code_classname == "script_vehicle" && isdefined(param_03.owner))
		{
			return 0;
		}

		if(param_03.code_classname == "misc_turret" && isdefined(param_03.owner))
		{
			return 0;
		}

		if(param_03.code_classname == "script_model" && isdefined(param_03.owner))
		{
			return 0;
		}
	}

	return (param_01 == "head" || param_01 == "helmet") && param_02 != "MOD_MELEE" && param_02 != "MOD_IMPACT" && !maps\mp\_utility::isenvironmentweapon(param_00);
}

//Function Number: 6
handleteamchangedeath()
{
	if(!level.teambased)
	{
		return;
	}

	if(self.joining_team == "spectator" || !isteamswitchbalanced())
	{
		self thread [[ level.onxpevent ]]("suicide");
		maps\mp\_utility::incpersstat("suicides",1);
		self.suicides = maps\mp\_utility::getpersstat("suicides");
	}
}

//Function Number: 7
handleworlddeath(param_00,param_01,param_02,param_03)
{
	if(!isdefined(param_00))
	{
		return;
	}

	if(!isdefined(param_00.team))
	{
		handlesuicidedeath(param_02,param_03);
		return;
	}

	if((level.teambased && param_00.team != self.team) || !level.teambased)
	{
		if(isdefined(level.onnormaldeath) && isplayer(param_00) && param_00.team != "spectator")
		{
			[[ level.onnormaldeath ]](self,param_00,param_01);
		}
	}
}

//Function Number: 8
handlesuicidedeath(param_00,param_01)
{
	self setcarddisplayslot(self,7);
	self openmenu("killedby_card_display");
	self thread [[ level.onxpevent ]]("suicide");
	maps\mp\_utility::incpersstat("suicides",1);
	self.suicides = maps\mp\_utility::getpersstat("suicides");
	if(!maps\mp\_utility::matchmakinggame())
	{
		maps\mp\_utility::incplayerstat("suicides",1);
	}

	var_02 = maps\mp\gametypes\_tweakables::gettweakablevalue("game","suicidepointloss");
	lib_036E::func_2B86(self,lib_036E::func_2B87(self) - var_02);
	if(param_00 == "MOD_SUICIDE" && param_01 == "none" && isdefined(self.throwinggrenade))
	{
		self.lastgrenadesuicidetime = gettime();
	}

	if(isdefined(self.friendlydamage))
	{
		self iprintlnbold(&"MP_FRIENDLY_FIRE_WILL_NOT");
	}
}

//Function Number: 9
handlefriendlyfiredeath(param_00)
{
	param_00 setcarddisplayslot(self,8);
	param_00 openmenu("youkilled_card_display");
	self setcarddisplayslot(param_00,7);
	self openmenu("killedby_card_display");
	param_00 thread [[ level.onxpevent ]]("teamkill");
	param_00.pers["teamkills"] = param_00.pers["teamkills"] + 1;
	param_00.teamkillsthisround++;
	if(maps\mp\gametypes\_tweakables::gettweakablevalue("team","teamkillpointloss"))
	{
		var_01 = maps\mp\gametypes\_rank::getscoreinfovalue("kill");
		lib_036E::func_2B86(param_00,lib_036E::func_2B87(param_00) - var_01);
	}

	if(level.maxallowedteamkills < 0)
	{
		return;
	}

	if(level.ingraceperiod)
	{
		var_02 = 1;
		param_00.pers["teamkills"] = param_00.pers["teamkills"] + level.maxallowedteamkills;
	}
	else if(var_02.pers["teamkills"] > 1 && maps\mp\_utility::gettimepassed() < level.graceperiod * 1000 + 8000 + var_02.pers["teamkills"] * 1000)
	{
		var_02 = 1;
		param_00.pers["teamkills"] = param_00.pers["teamkills"] + level.maxallowedteamkills;
	}
	else
	{
		var_02 = var_02 maps\mp\gametypes\_playerlogic::teamkilldelay();
	}

	if(var_02 > 0)
	{
		param_00.pers["teamKillPunish"] = 1;
		param_00 maps\mp\_utility::_suicide();
	}
}

//Function Number: 10
func_3172(param_00,param_01,param_02,param_03,param_04)
{
	param_01 thread maps\mp\_events::killedplayer(param_00,self,param_03,param_04);
	param_01 setcarddisplayslot(self,8);
	param_01 openmenu("youkilled_card_display");
	self setcarddisplayslot(param_01,7);
	self openmenu("killedby_card_display");
	if(param_04 == "MOD_HEAD_SHOT")
	{
		param_01 maps\mp\_utility::incpersstat("headshots",1);
		param_01.headshots = param_01 maps\mp\_utility::getpersstat("headshots");
		param_01 maps\mp\_utility::incplayerstat("headshots",1);
		if(isdefined(param_01.laststand))
		{
			var_05 = maps\mp\gametypes\_rank::getscoreinfovalue("kill") * 2;
		}
		else
		{
			var_05 = undefined;
		}

		param_01 playlocalsound("bullet_impact_headshot_2");
	}
	else if(isdefined(param_02.laststand))
	{
		var_05 = maps\mp\gametypes\_rank::getscoreinfovalue("kill") * 2;
	}
	else
	{
		var_05 = undefined;
	}

	param_01 thread maps\mp\gametypes\_rank::giverankxp("kill",var_05,param_03,param_04);
	param_01 maps\mp\_utility::incpersstat("kills",1);
	param_01.kills = param_01 maps\mp\_utility::getpersstat("kills");
	param_01 maps\mp\_utility::updatepersratio("kdRatio","kills","deaths");
	param_01 maps\mp\gametypes\_persistance::statsetchild("round","kills",param_01.kills);
	param_01 maps\mp\_utility::incplayerstat("kills",1);
	if(isflankkill(self,param_01))
	{
		param_01 maps\mp\_utility::incplayerstat("flankkills",1);
		maps\mp\_utility::incplayerstat("flankdeaths",1);
	}

	var_06 = param_01.pers["cur_kill_streak"];
	self.pers["copyCatLoadout"] = undefined;
	if(maps\mp\_utility::_hasperk("specialty_copycat"))
	{
		self.pers["copyCatLoadout"] = param_01 maps\mp\gametypes\_class::cloneloadout();
	}

	if(isalive(param_01) || param_01.streaktype == "support")
	{
		if(param_01 maps\mp\_utility::killshouldaddtokillstreak(param_03))
		{
			param_01 thread maps\mp\killstreaks\_killstreaks::giveadrenaline("kill");
			param_01.pers["cur_kill_streak"]++;
			if(!maps\mp\_utility::iskillstreakweapon(param_03))
			{
				param_01.pers["cur_kill_streak_for_nuke"]++;
			}

			var_07 = 25;
			if(param_01 maps\mp\_utility::_hasperk("specialty_hardline"))
			{
				var_07--;
			}

			if(!maps\mp\_utility::iskillstreakweapon(param_03) && param_01.pers["cur_kill_streak_for_nuke"] == var_07)
			{
				param_01 thread maps\mp\killstreaks\_killstreaks::givekillstreak("nuke",0,1,param_01,1);
				param_01 thread maps\mp\gametypes\_hud_message::killstreaksplashnotify("nuke",var_07);
			}
		}

		param_01 maps\mp\_utility::setplayerstatifgreater("killstreak",param_01.pers["cur_kill_streak"]);
		if(param_01.pers["cur_kill_streak"] > param_01 maps\mp\_utility::getpersstat("longestStreak"))
		{
			param_01 maps\mp\_utility::setpersstat("longestStreak",param_01.pers["cur_kill_streak"]);
		}
	}

	param_01.pers["cur_death_streak"] = 0;
	if(param_01.pers["cur_kill_streak"] > param_01 maps\mp\gametypes\_persistance::statgetchild("round","killStreak"))
	{
		param_01 maps\mp\gametypes\_persistance::statsetchild("round","killStreak",param_01.pers["cur_kill_streak"]);
	}

	if(param_01.pers["cur_kill_streak"] > param_01.kill_streak)
	{
		param_01 maps\mp\gametypes\_persistance::statset("killStreak",param_01.pers["cur_kill_streak"]);
		param_01.kill_streak = param_01.pers["cur_kill_streak"];
	}

	lib_036E::func_2B7B("kill",param_01,self);
	lib_037A::func_3068(param_01,self);
	var_08 = maps\mp\gametypes\_tweakables::gettweakablevalue("game","deathpointloss");
	lib_036E::func_2B86(self,lib_036E::func_2B87(self) - var_08);
	if(isdefined(level.ac130player) && level.ac130player == param_01)
	{
		level notify("ai_killed",self);
	}

	level notify("player_got_killstreak_" + param_01.pers["cur_kill_streak"],param_01);
	param_01 notify("got_killstreak",param_01.pers["cur_kill_streak"]);
	param_01 notify("killed_enemy");
	if(isdefined(self.uavremotemarkedby))
	{
		if(self.uavremotemarkedby != param_01)
		{
			self.uavremotemarkedby thread maps\mp\killstreaks\_remoteuav::remoteuav_processtaggedassist(self);
		}

		self.uavremotemarkedby = undefined;
	}

	if(isdefined(level.onnormaldeath) && param_01.pers["team"] != "spectator")
	{
		[[ level.onnormaldeath ]](self,param_01,param_00);
	}

	if(!level.teambased)
	{
		self.attackers = [];
		return;
	}

	level thread maps\mp\gametypes\_battlechatter_mp::saylocalsounddelayed(param_01,"kill",0.75);
	if(isdefined(self.lastattackedshieldplayer) && isdefined(self.lastattackedshieldtime) && self.lastattackedshieldplayer != param_01)
	{
		if(gettime() - self.lastattackedshieldtime < 2500)
		{
			self.lastattackedshieldplayer thread lib_036E::func_2BA8(self);
			if(self.lastattackedshieldplayer maps\mp\_utility::_hasperk("specialty_assists"))
			{
				self.lastattackedshieldplayer.pers["assistsToKill"]++;
				if(!self.lastattackedshieldplayer.pers["assistsToKill"] % 2)
				{
					self.lastattackedshieldplayer maps\mp\gametypes\_missions::processchallenge("ch_hardlineassists");
					self.lastattackedshieldplayer maps\mp\killstreaks\_killstreaks::giveadrenaline("kill");
					self.lastattackedshieldplayer.pers["cur_kill_streak"]++;
				}
			}
			else
			{
				self.lastattackedshieldplayer.pers["assistsToKill"] = 0;
			}
		}
		else if(isalive(self.lastattackedshieldplayer) && gettime() - self.lastattackedshieldtime < 5000)
		{
			var_09 = vectornormalize(anglestoforward(self.angles));
			var_0A = vectornormalize(self.lastattackedshieldplayer.origin - self.origin);
			if(vectordot(var_0A,var_09) > 0.925)
			{
				self.lastattackedshieldplayer thread lib_036E::func_2BA8(self);
				if(self.lastattackedshieldplayer maps\mp\_utility::_hasperk("specialty_assists"))
				{
					self.lastattackedshieldplayer.pers["assistsToKill"]++;
					if(!self.lastattackedshieldplayer.pers["assistsToKill"] % 2)
					{
						self.lastattackedshieldplayer maps\mp\gametypes\_missions::processchallenge("ch_hardlineassists");
						self.lastattackedshieldplayer maps\mp\killstreaks\_killstreaks::giveadrenaline("kill");
						self.lastattackedshieldplayer.pers["cur_kill_streak"]++;
					}
				}
				else
				{
					self.lastattackedshieldplayer.pers["assistsToKill"] = 0;
				}
			}
		}
	}

	if(isdefined(self.attackers))
	{
		foreach(var_0C in self.attackers)
		{
			if(!isdefined(var_0C))
			{
				continue;
			}

			if(var_0C == param_01)
			{
				continue;
			}

			var_0C thread lib_036E::func_2BA1(self);
			if(var_0C maps\mp\_utility::_hasperk("specialty_assists"))
			{
				var_0C.pers["assistsToKill"]++;
				if(!var_0C.pers["assistsToKill"] % 2)
				{
					var_0C maps\mp\gametypes\_missions::processchallenge("ch_hardlineassists");
					var_0C maps\mp\killstreaks\_killstreaks::giveadrenaline("kill");
					var_0C.pers["cur_kill_streak"]++;
					var_07 = 25;
					if(var_0C maps\mp\_utility::_hasperk("specialty_hardline"))
					{
						var_07--;
					}

					if(var_0C.pers["cur_kill_streak"] == var_07)
					{
						var_0C thread maps\mp\killstreaks\_killstreaks::givekillstreak("nuke",0,1,var_0C,1);
						var_0C thread maps\mp\gametypes\_hud_message::killstreaksplashnotify("nuke",var_07);
					}
				}

				continue;
			}

			var_0C.pers["assistsToKill"] = 0;
		}

		self.attackers = [];
	}
}

//Function Number: 11
isplayerweapon(param_00)
{
	if(weaponclass(param_00) == "non-player")
	{
		return 0;
	}

	if(weaponclass(param_00) == "turret")
	{
		return 0;
	}

	if(weaponinventorytype(param_00) == "primary" || weaponinventorytype(param_00) == "altmode")
	{
		return 1;
	}

	return 0;
}

//Function Number: 12
callback_playerkilled(param_00,param_01,param_02,param_03,param_04,param_05,param_06,param_07,param_08)
{
	playerkilled_internal(param_00,param_01,self,param_02,param_03,param_04,param_05,param_06,param_07,param_08,0);
}

//Function Number: 13
queueshieldforremoval(param_00)
{
	var_01 = 5;
	if(!isdefined(level.shieldtrasharray))
	{
		level.shieldtrasharray = [];
	}

	if(level.shieldtrasharray.size >= var_01)
	{
		var_02 = level.shieldtrasharray.size - 1;
		level.shieldtrasharray[0] delete();
		for(var_03 = 0;var_03 < var_02;var_03++)
		{
			level.shieldtrasharray[var_03] = level.shieldtrasharray[var_03 + 1];
		}

		level.shieldtrasharray[var_02] = undefined;
	}

	level.shieldtrasharray[level.shieldtrasharray.size] = param_00;
}

//Function Number: 14
launchshield(param_00,param_01)
{
	var_02 = "weapon_riot_shield_mp";
	if(!isdefined(self.hasriotshieldhidden) || self.hasriotshieldhidden == 0)
	{
		self detachshieldmodel(var_02,"tag_weapon_left");
	}

	self.hasriotshield = 0;
	self.hasriotshieldequipped = 0;
}

//Function Number: 15
playerkilled_internal(param_00,param_01,param_02,param_03,param_04,param_05,param_06,param_07,param_08,param_09,param_0A)
{
	param_02 endon("spawned");
	param_02 notify("killed_player");
	if(isdefined(param_01))
	{
		param_01.assistedsuicide = undefined;
	}

	if(!isdefined(param_02.idflags))
	{
		if(param_04 == "MOD_SUICIDE")
		{
			param_02.idflags = 0;
		}
		else if(param_04 == "MOD_GRENADE" && issubstr(param_05,"frag_grenade") && param_03 == 100000)
		{
			param_02.idflags = 0;
		}
		else if(param_05 == "nuke_mp")
		{
			param_02.idflags = 0;
		}
		else if(level.friendlyfire >= 2)
		{
			param_02.idflags = 0;
		}
		else
		{
		}
	}

	if(param_02.hasriotshieldequipped)
	{
		param_02 launchshield(param_03,param_04);
	}

	if(!param_0A)
	{
		if(isdefined(param_02.endgame))
		{
			if(isdefined(level.nukedetonated))
			{
				self visionsetnakedforplayer(level.nukevisionset,2);
			}
			else
			{
				self visionsetnakedforplayer("",2);
			}
		}
		else
		{
			if(isdefined(level.nukedetonated))
			{
				self visionsetnakedforplayer(level.nukevisionset,0);
			}
			else
			{
				self visionsetnakedforplayer("",0);
			}

			param_02 thermalvisionoff();
		}
	}
	else
	{
		param_02.fauxdead = 1;
		self notify("death");
	}

	if(game["state"] == "postgame")
	{
		return;
	}

	var_0B = 0;
	if(!isplayer(param_00) && isdefined(param_00.primaryweapon))
	{
		var_0C = param_00.primaryweapon;
	}
	else if(isdefined(param_02) && isplayer(param_02) && param_02 getcurrentprimaryweapon() != "none")
	{
		var_0C = param_02 getcurrentprimaryweapon();
	}
	else if(issubstr(param_06,"alt_"))
	{
		var_0C = getsubstr(param_06,4,param_06.size);
	}
	else
	{
		var_0C = undefined;
	}

	if(isdefined(param_02.uselaststandparams) || isdefined(param_02.laststandparams) && param_04 == "MOD_SUICIDE")
	{
		param_02 ensurelaststandparamsvalidity();
		param_02.uselaststandparams = undefined;
		param_00 = param_02.laststandparams.einflictor;
		param_01 = param_02.laststandparams.attacker;
		param_03 = param_02.laststandparams.idamage;
		param_04 = param_02.laststandparams.smeansofdeath;
		param_05 = param_02.laststandparams.sweapon;
		var_0C = param_02.laststandparams.sprimaryweapon;
		param_06 = param_02.laststandparams.vdir;
		param_07 = param_02.laststandparams.shitloc;
		var_0B = gettime() - param_02.laststandparams.laststandstarttime / 1000;
		param_02.laststandparams = undefined;
	}

	if((!isdefined(param_01) || param_01.classname == "trigger_hurt" || param_01.classname == "worldspawn" || param_01 == param_02) && isdefined(self.attackers))
	{
		var_0D = undefined;
		foreach(var_0F in self.attackers)
		{
			if(!isdefined(var_0F))
			{
				continue;
			}

			if(!isdefined(param_02.attackerdata[var_0F.guid].damage))
			{
				continue;
			}

			if(var_0F == param_02 || level.teambased && var_0F.team == param_02.team)
			{
				continue;
			}

			if(param_02.attackerdata[var_0F.guid].lasttimedamaged + 2500 < gettime() && param_01 != param_02 && isdefined(param_02.laststand) && param_02.laststand)
			{
				continue;
			}

			if(param_02.attackerdata[var_0F.guid].damage > 1 && !isdefined(var_0D))
			{
				var_0D = var_0F;
				continue;
			}

			if(isdefined(var_0D) && param_02.attackerdata[var_0F.guid].damage > param_02.attackerdata[var_0D.guid].damage)
			{
				var_0D = var_0F;
			}
		}

		if(isdefined(var_0D))
		{
			param_01 = var_0D;
			param_01.assistedsuicide = 1;
			param_05 = param_02.attackerdata[var_0D.guid].weapon;
			param_06 = param_02.attackerdata[var_0D.guid].vdir;
			param_07 = param_02.attackerdata[var_0D.guid].shitloc;
			param_08 = param_02.attackerdata[var_0D.guid].psoffsettime;
			param_04 = param_02.attackerdata[var_0D.guid].smeansofdeath;
			param_03 = param_02.attackerdata[var_0D.guid].damage;
			var_0C = param_02.attackerdata[var_0D.guid].sprimaryweapon;
			param_00 = param_01;
		}
	}
	else if(isdefined(param_01))
	{
		param_01.assistedsuicide = undefined;
	}

	if(isheadshot(param_05,param_07,param_04,param_01))
	{
		param_04 = "MOD_HEAD_SHOT";
	}
	else if(param_04 != "MOD_MELEE" && !isdefined(param_02.nuked))
	{
		param_02 maps\mp\_utility::playdeathsound();
	}

	var_11 = isfriendlyfire(param_02,param_01);
	if(isdefined(param_01))
	{
		if(param_01.code_classname == "script_vehicle" && isdefined(param_01.owner))
		{
			param_01 = param_01.owner;
		}

		if(param_01.code_classname == "misc_turret" && isdefined(param_01.owner))
		{
			if(isdefined(param_01.vehicle))
			{
				param_01.vehicle notify("killedPlayer",param_02);
			}

			param_01 = param_01.owner;
		}

		if(param_01.code_classname == "script_model" && isdefined(param_01.owner))
		{
			param_01 = param_01.owner;
			if(!isfriendlyfire(param_02,param_01) && param_01 != param_02)
			{
				param_01 notify("crushed_enemy");
			}
		}
	}

	param_02 maps\mp\gametypes\_weapons::dropscavengerfordeath(param_01);
	param_02 maps\mp\gametypes\_weapons::dropweaponfordeath(param_01);
	if(!param_0A)
	{
		param_02.sessionstate = "dead";
		param_02.statusicon = "hud_status_dead";
	}

	param_02 maps\mp\gametypes\_playerlogic::removefromalivecount();
	if(!isdefined(param_02.switching_teams))
	{
		param_02 maps\mp\_utility::incpersstat("deaths",1);
		param_02.deaths = param_02 maps\mp\_utility::getpersstat("deaths");
		param_02 maps\mp\_utility::updatepersratio("kdRatio","kills","deaths");
		param_02 maps\mp\gametypes\_persistance::statsetchild("round","deaths",param_02.deaths);
		param_02 maps\mp\_utility::incplayerstat("deaths",1);
	}

	if(isdefined(param_01) && isplayer(param_01))
	{
		param_01 checkkillsteal(param_02);
	}

	obituary(param_02,param_01,param_05,param_04);
	var_12 = 0;
	var_13 = maps\mp\_utility::getnextlifeid();
	param_02 logprintplayerdeath(var_13,param_01,param_03,param_04,param_05,var_0C,param_07);
	param_02 maps\mp\_matchdata::logplayerlife(var_13);
	param_02 maps\mp\_matchdata::logplayerdeath(var_13,param_01,param_03,param_04,param_05,var_0C,param_07);
	if(param_04 == "MOD_MELEE")
	{
		if(issubstr(param_05,"riotshield"))
		{
			param_01 maps\mp\_utility::incplayerstat("shieldkills",1);
			if(!maps\mp\_utility::matchmakinggame())
			{
				param_02 maps\mp\_utility::incplayerstat("shielddeaths",1);
			}
		}
		else
		{
			param_01 maps\mp\_utility::incplayerstat("knifekills",1);
		}
	}

	if(param_02 isswitchingteams())
	{
		handleteamchangedeath();
	}
	else if(!isplayer(param_01) || isplayer(param_01) && param_04 == "MOD_FALLING")
	{
		handleworlddeath(param_01,var_13,param_04,param_07);
	}
	else if(param_01 == param_02)
	{
		handlesuicidedeath(param_04,param_07);
	}
	else if(var_11)
	{
		if(!isdefined(param_02.nuked))
		{
			handlefriendlyfiredeath(param_01);
		}
	}
	else
	{
		if(param_04 == "MOD_GRENADE" && param_00 == param_01)
		{
			addattacker(param_02,param_01,param_00,param_05,param_03,(0,0,0),param_06,param_07,param_08,param_04);
		}

		var_12 = 1;
		func_3172(var_13,param_01,param_00,param_05,param_04);
		param_02 thread maps\mp\gametypes\_missions::playerkilled(param_00,param_01,param_03,param_04,param_05,var_0C,param_07,param_01.modifiers);
		param_02.pers["cur_death_streak"]++;
		if(!maps\mp\_utility::getgametypenumlives() && !maps\mp\_utility::matchmakinggame())
		{
			param_02 maps\mp\_utility::setplayerstatifgreater("deathstreak",param_02.pers["cur_death_streak"]);
		}

		if(isplayer(param_01) && param_02 maps\mp\_utility::isjuggernaut())
		{
			param_01 thread maps\mp\_utility::teamplayercardsplash("callout_killed_juggernaut",param_01);
		}
	}

	var_14 = 0;
	var_15 = undefined;
	if(isdefined(self.previousprimary))
	{
		var_14 = 1;
		var_15 = self.previousprimary;
		self.previousprimary = undefined;
	}

	if(isplayer(param_01) && param_01 != self && !level.teambased || level.teambased && self.team != param_01.team)
	{
		if(var_14 && isdefined(var_15))
		{
			var_16 = var_15;
		}
		else
		{
			var_16 = self.lastdroppableweapon;
		}

		thread maps\mp\gametypes\_gamelogic::trackleaderboarddeathstats(var_16,param_04);
		param_01 thread maps\mp\gametypes\_gamelogic::trackattackerleaderboarddeathstats(param_05,param_04);
	}

	param_02 resetplayervariables();
	param_02.lastattacker = param_01;
	param_02.lastdeathpos = param_02.origin;
	param_02.deathtime = gettime();
	param_02.wantsafespawn = 0;
	param_02.revived = 0;
	param_02.sameshotdamage = 0;
	if(maps\mp\killstreaks\_killstreaks::streaktyperesetsondeath(param_02.streaktype))
	{
		param_02 maps\mp\killstreaks\_killstreaks::resetadrenaline();
	}

	if(param_0A)
	{
		var_12 = 0;
		param_09 = param_02 playerforcedeathanim(param_00,param_04,param_05,param_07,param_06);
	}

	param_02.body = param_02 cloneplayer(param_09);
	if(param_0A)
	{
		param_02 playerhide();
	}

	if(param_02 isonladder() || param_02 ismantling() || !param_02 isonground() || isdefined(param_02.nuked))
	{
		param_02.body startragdoll();
	}

	if(!isdefined(param_02.switching_teams))
	{
		thread maps\mp\gametypes\_deathicons::adddeathicon(param_02.body,param_02,param_02.team,5);
	}

	thread delaystartragdoll(param_02.body,param_07,param_06,param_05,param_00,param_04);
	param_02 thread [[ level.onplayerkilled ]](param_00,param_01,param_03,param_04,param_05,param_06,param_07,param_08,param_09,var_13);
	if(isplayer(param_01))
	{
		var_17 = param_01 getentitynumber();
	}
	else
	{
		var_17 = -1;
	}

	var_18 = param_02 getkillcamentity(param_01,param_00,param_05);
	var_19 = -1;
	var_1A = 0;
	if(isdefined(var_18))
	{
		var_19 = var_18 getentitynumber();
		var_1A = var_18.birthtime;
		if(!isdefined(var_1A))
		{
			var_1A = 0;
		}
	}

	if(param_04 != "MOD_SUICIDE" && !!isdefined(param_01) || param_01.classname == "trigger_hurt" || param_01.classname == "worldspawn" || param_01 == param_02)
	{
		recordfinalkillcam(5,param_02,param_01,var_17,var_19,var_1A,param_05,var_0B,param_08);
	}

	param_02 setplayerdata("killCamHowKilled",0);
	switch(param_04)
	{
		case "MOD_HEAD_SHOT":
			param_02 setplayerdata("killCamHowKilled",1);
			break;

		default:
			break;
	}

	if(!param_0A)
	{
		if(!level.showingfinalkillcam && !level.killcam && var_12)
		{
			if(param_02 maps\mp\_utility::_hasperk("specialty_copycat") && isdefined(param_02.pers["copyCatLoadout"]))
			{
				param_02 thread maps\mp\gametypes\_killcam::waitdeathcopycatbutton(param_01);
				wait 1;
			}
		}

		wait 0.25;
		param_02 thread maps\mp\gametypes\_killcam::cancelkillcamonuse();
		wait 0.25;
		self.respawntimerstarttime = gettime() + 1000;
		var_1B = maps\mp\gametypes\_playerlogic::timeuntilspawn(1);
		if(var_1B < 1)
		{
			var_1B = 1;
		}

		param_02 thread maps\mp\gametypes\_playerlogic::predictabouttospawnplayerovertime(var_1B);
		wait 1;
		param_02 notify("death_delay_finished");
	}

	var_1C = gettime() - param_02.deathtime / 1000;
	self.respawntimerstarttime = gettime();
	if(!isdefined(param_02.cancelkillcam) && param_02.cancelkillcam && var_12 && level.killcam && game["state"] == "playing" && !param_02 maps\mp\_utility::isusingremote() && !level.showingfinalkillcam)
	{
		var_1D = !maps\mp\_utility::getgametypenumlives() && !param_02.pers["lives"];
		var_1B = maps\mp\gametypes\_playerlogic::timeuntilspawn(1);
		var_1E = var_1D && var_1B <= 0;
		if(!var_1D)
		{
			var_1B = -1;
			level notify("player_eliminated",param_02);
		}

		param_02 maps\mp\gametypes\_killcam::killcam(var_17,var_19,var_1A,param_05,var_1C + var_0B,param_08,var_1B,maps\mp\gametypes\_gamelogic::timeuntilroundend(),param_01,param_02);
	}

	if(game["state"] != "playing")
	{
		if(!level.showingfinalkillcam)
		{
			param_02.sessionstate = "dead";
			param_02 maps\mp\_utility::clearkillcamstate();
		}

		return;
	}

	if(maps\mp\_utility::isvalidclass(param_02.class))
	{
		param_02 thread maps\mp\gametypes\_playerlogic::spawnclient();
	}
}

//Function Number: 16
checkforcebleedout()
{
	if(level.diehardmode != 1)
	{
		return 0;
	}

	if(!maps\mp\_utility::getgametypenumlives())
	{
		return 0;
	}

	if(level.livescount[self.team] > 0)
	{
		return 0;
	}

	foreach(var_01 in level.players)
	{
		if(!isalive(var_01))
		{
			continue;
		}

		if(var_01.team != self.team)
		{
			continue;
		}

		if(var_01 == self)
		{
			continue;
		}

		if(!var_01.inlaststand)
		{
			return 0;
		}
	}

	foreach(var_01 in level.players)
	{
		if(!isalive(var_01))
		{
			continue;
		}

		if(var_01.team != self.team)
		{
			continue;
		}

		if(var_01.inlaststand && var_01 != self)
		{
			var_01 laststandbleedout(0);
		}
	}

	return 1;
}

//Function Number: 17
checkkillsteal(param_00)
{
	if(maps\mp\_utility::matchmakinggame())
	{
		return;
	}

	var_01 = 0;
	var_02 = undefined;
	if(isdefined(param_00.attackerdata) && param_00.attackerdata.size > 1)
	{
		foreach(var_04 in param_00.attackerdata)
		{
			if(var_04.damage > var_01)
			{
				var_01 = var_04.damage;
				var_02 = var_04.attackerent;
			}
		}

		if(isdefined(var_02) && var_02 != self)
		{
			maps\mp\_utility::incplayerstat("killsteals",1);
		}
	}
}

//Function Number: 18
initfinalkillcam()
{
	level.finalkillcam_delay = [];
	level.finalkillcam_victim = [];
	level.finalkillcam_attacker = [];
	level.finalkillcam_attackernum = [];
	level.finalkillcam_killcamentityindex = [];
	level.finalkillcam_killcamentitystarttime = [];
	level.finalkillcam_sweapon = [];
	level.finalkillcam_deathtimeoffset = [];
	level.finalkillcam_psoffsettime = [];
	level.finalkillcam_timerecorded = [];
	level.finalkillcam_timegameended = [];
	level.finalkillcam_delay["axis"] = undefined;
	level.finalkillcam_victim["axis"] = undefined;
	level.finalkillcam_attacker["axis"] = undefined;
	level.finalkillcam_attackernum["axis"] = undefined;
	level.finalkillcam_killcamentityindex["axis"] = undefined;
	level.finalkillcam_killcamentitystarttime["axis"] = undefined;
	level.finalkillcam_sweapon["axis"] = undefined;
	level.finalkillcam_deathtimeoffset["axis"] = undefined;
	level.finalkillcam_psoffsettime["axis"] = undefined;
	level.finalkillcam_timerecorded["axis"] = undefined;
	level.finalkillcam_timegameended["axis"] = undefined;
	level.finalkillcam_delay["allies"] = undefined;
	level.finalkillcam_victim["allies"] = undefined;
	level.finalkillcam_attacker["allies"] = undefined;
	level.finalkillcam_attackernum["allies"] = undefined;
	level.finalkillcam_killcamentityindex["allies"] = undefined;
	level.finalkillcam_killcamentitystarttime["allies"] = undefined;
	level.finalkillcam_sweapon["allies"] = undefined;
	level.finalkillcam_deathtimeoffset["allies"] = undefined;
	level.finalkillcam_psoffsettime["allies"] = undefined;
	level.finalkillcam_timerecorded["allies"] = undefined;
	level.finalkillcam_timegameended["allies"] = undefined;
	level.finalkillcam_delay["none"] = undefined;
	level.finalkillcam_victim["none"] = undefined;
	level.finalkillcam_attacker["none"] = undefined;
	level.finalkillcam_attackernum["none"] = undefined;
	level.finalkillcam_killcamentityindex["none"] = undefined;
	level.finalkillcam_killcamentitystarttime["none"] = undefined;
	level.finalkillcam_sweapon["none"] = undefined;
	level.finalkillcam_deathtimeoffset["none"] = undefined;
	level.finalkillcam_psoffsettime["none"] = undefined;
	level.finalkillcam_timerecorded["none"] = undefined;
	level.finalkillcam_timegameended["none"] = undefined;
	level.finalkillcam_winner = undefined;
}

//Function Number: 19
recordfinalkillcam(param_00,param_01,param_02,param_03,param_04,param_05,param_06,param_07,param_08)
{
	if(level.teambased && isdefined(param_02.team))
	{
		level.finalkillcam_delay[param_02.team] = param_00;
		level.finalkillcam_victim[param_02.team] = param_01;
		level.finalkillcam_attacker[param_02.team] = param_02;
		level.finalkillcam_attackernum[param_02.team] = param_03;
		level.finalkillcam_killcamentityindex[param_02.team] = param_04;
		level.finalkillcam_killcamentitystarttime[param_02.team] = param_05;
		level.finalkillcam_sweapon[param_02.team] = param_06;
		level.finalkillcam_deathtimeoffset[param_02.team] = param_07;
		level.finalkillcam_psoffsettime[param_02.team] = param_08;
		level.finalkillcam_timerecorded[param_02.team] = maps\mp\_utility::getsecondspassed();
		level.finalkillcam_timegameended[param_02.team] = maps\mp\_utility::getsecondspassed();
	}

	level.finalkillcam_delay["none"] = param_00;
	level.finalkillcam_victim["none"] = param_01;
	level.finalkillcam_attacker["none"] = param_02;
	level.finalkillcam_attackernum["none"] = param_03;
	level.finalkillcam_killcamentityindex["none"] = param_04;
	level.finalkillcam_killcamentitystarttime["none"] = param_05;
	level.finalkillcam_sweapon["none"] = param_06;
	level.finalkillcam_deathtimeoffset["none"] = param_07;
	level.finalkillcam_psoffsettime["none"] = param_08;
	level.finalkillcam_timerecorded["none"] = maps\mp\_utility::getsecondspassed();
	level.finalkillcam_timegameended["none"] = maps\mp\_utility::getsecondspassed();
}

//Function Number: 20
erasefinalkillcam()
{
	level.finalkillcam_delay["axis"] = undefined;
	level.finalkillcam_victim["axis"] = undefined;
	level.finalkillcam_attacker["axis"] = undefined;
	level.finalkillcam_attackernum["axis"] = undefined;
	level.finalkillcam_killcamentityindex["axis"] = undefined;
	level.finalkillcam_killcamentitystarttime["axis"] = undefined;
	level.finalkillcam_sweapon["axis"] = undefined;
	level.finalkillcam_deathtimeoffset["axis"] = undefined;
	level.finalkillcam_psoffsettime["axis"] = undefined;
	level.finalkillcam_timerecorded["axis"] = undefined;
	level.finalkillcam_timegameended["axis"] = undefined;
	level.finalkillcam_delay["allies"] = undefined;
	level.finalkillcam_victim["allies"] = undefined;
	level.finalkillcam_attacker["allies"] = undefined;
	level.finalkillcam_attackernum["allies"] = undefined;
	level.finalkillcam_killcamentityindex["allies"] = undefined;
	level.finalkillcam_killcamentitystarttime["allies"] = undefined;
	level.finalkillcam_sweapon["allies"] = undefined;
	level.finalkillcam_deathtimeoffset["allies"] = undefined;
	level.finalkillcam_psoffsettime["allies"] = undefined;
	level.finalkillcam_timerecorded["allies"] = undefined;
	level.finalkillcam_timegameended["allies"] = undefined;
	level.finalkillcam_delay["none"] = undefined;
	level.finalkillcam_victim["none"] = undefined;
	level.finalkillcam_attacker["none"] = undefined;
	level.finalkillcam_attackernum["none"] = undefined;
	level.finalkillcam_killcamentityindex["none"] = undefined;
	level.finalkillcam_killcamentitystarttime["none"] = undefined;
	level.finalkillcam_sweapon["none"] = undefined;
	level.finalkillcam_deathtimeoffset["none"] = undefined;
	level.finalkillcam_psoffsettime["none"] = undefined;
	level.finalkillcam_timerecorded["none"] = undefined;
	level.finalkillcam_timegameended["none"] = undefined;
	level.finalkillcam_winner = undefined;
}

//Function Number: 21
dofinalkillcam()
{
	level waittill("round_end_finished");
	level.showingfinalkillcam = 1;
	var_00 = "none";
	if(isdefined(level.finalkillcam_winner))
	{
		var_00 = level.finalkillcam_winner;
	}

	var_01 = level.finalkillcam_delay[var_00];
	var_02 = level.finalkillcam_victim[var_00];
	var_03 = level.finalkillcam_attacker[var_00];
	var_04 = level.finalkillcam_attackernum[var_00];
	var_05 = level.finalkillcam_killcamentityindex[var_00];
	var_06 = level.finalkillcam_killcamentitystarttime[var_00];
	var_07 = level.finalkillcam_sweapon[var_00];
	var_08 = level.finalkillcam_deathtimeoffset[var_00];
	var_09 = level.finalkillcam_psoffsettime[var_00];
	var_0A = level.finalkillcam_timerecorded[var_00];
	var_0B = level.finalkillcam_timegameended[var_00];
	if(!isdefined(var_02) || !isdefined(var_03))
	{
		level.showingfinalkillcam = 0;
		level notify("final_killcam_done");
		return;
	}

	var_0C = 15;
	var_0D = var_0B - var_0A;
	if(var_0D > var_0C)
	{
		level.showingfinalkillcam = 0;
		level notify("final_killcam_done");
		return;
	}

	if(isdefined(var_03))
	{
		var_03.finalkill = 1;
	}

	var_0E = gettime() - var_02.deathtime / 1000;
	foreach(var_10 in level.players)
	{
		var_10 closepopupmenu();
		var_10 closeingamemenu();
		if(isdefined(level.nukedetonated))
		{
			var_10 visionsetnakedforplayer(level.nukevisionset,0);
		}
		else
		{
			var_10 visionsetnakedforplayer("",0);
		}

		var_10.killcamentitylookat = var_02 getentitynumber();
		if((var_10 != var_02 || !maps\mp\_utility::isroundbased() || maps\mp\_utility::islastround()) && var_10 maps\mp\_utility::_hasperk("specialty_copycat"))
		{
			var_10 maps\mp\_utility::_unsetperk("specialty_copycat");
		}

		var_10 thread maps\mp\gametypes\_killcam::killcam(var_04,var_05,var_06,var_07,var_0E + var_08,var_09,0,10000,var_03,var_02);
	}

	wait 0.1;
	while(anyplayersinkillcam())
	{
		wait 0.05;
	}

	level notify("final_killcam_done");
	level.showingfinalkillcam = 0;
}

//Function Number: 22
anyplayersinkillcam()
{
	foreach(var_01 in level.players)
	{
		if(isdefined(var_01.killcam))
		{
			return 1;
		}
	}

	return 0;
}

//Function Number: 23
resetplayervariables()
{
	self.killedplayerscurrent = [];
	self.switching_teams = undefined;
	self.joining_team = undefined;
	self.leaving_team = undefined;
	self.pers["cur_kill_streak"] = 0;
	self.pers["cur_kill_streak_for_nuke"] = 0;
	maps\mp\gametypes\_gameobjects::detachusemodels();
}

//Function Number: 24
getkillcamentity(param_00,param_01,param_02)
{
	if(!isdefined(param_01) || param_01 == param_00)
	{
		return undefined;
	}

	switch(param_02)
	{
		case "bomb_site_mp":
		case "airdrop_trap_explosive_mp":
		case "osprey_minigun_mp":
		case "littlebird_guard_minigun_mp":
		case "apache_minigun_mp":
		case "pavelow_minigun_mp":
		case "stealth_bomb_mp":
		case "bouncingbetty_mp":
		case "artillery_mp":
			return param_01.killcament;

		case "sam_projectile_mp":
			if(isdefined(param_01.samturret) && isdefined(param_01.samturret.killcament))
			{
				return param_01.samturret.killcament;
			}
			break;

		case "ims_projectile_mp":
			if(isdefined(param_00) && isdefined(param_00.imskillcament))
			{
				return param_00.imskillcament;
			}
			break;

		case "none":
			if(isdefined(param_01.targetname) && param_01.targetname == "care_package")
			{
				return param_01.killcament;
			}
			break;

		case "ugv_turret_mp":
		case "osprey_player_minigun_mp":
		case "remote_turret_mp":
		case "remotemissile_projectile_mp":
		case "ac130_25mm_mp":
		case "ac130_40mm_mp":
		case "ac130_105mm_mp":
			return undefined;
	}

	if(param_01.classname == "script_origin" || param_01.classname == "script_model" || param_01.classname == "script_brushmodel")
	{
		if(isdefined(param_01.killcament) && !param_00 attackerinremotekillstreak())
		{
			return param_01.killcament;
		}
		else
		{
			return undefined;
		}
	}

	return param_01;
}

//Function Number: 25
attackerinremotekillstreak()
{
	if(!isdefined(self))
	{
		return 0;
	}

	if(isdefined(level.ac130player) && self == level.ac130player)
	{
		return 1;
	}

	if(isdefined(level.chopper) && isdefined(level.chopper.gunner) && self == level.chopper.gunner)
	{
		return 1;
	}

	if(isdefined(level.remote_mortar) && isdefined(level.remote_mortar.owner) && self == level.remote_mortar.owner)
	{
		return 1;
	}

	if(isdefined(self.using_remote_turret) && self.using_remote_turret)
	{
		return 1;
	}

	if(isdefined(self.using_remote_tank) && self.using_remote_tank)
	{
		return 1;
	}

	return 0;
}

//Function Number: 26
hitlocdebug(param_00,param_01,param_02,param_03,param_04)
{
	var_05 = [];
	if(!getdvarint("scr_hitloc_debug"))
	{
		return;
	}

	if(!isdefined(param_01.hitlocinited))
	{
		for(var_06 = 0;var_06 < 6;var_06++ = var_7B[3])
		{
			param_01 setclientdvar("ui_hitloc_" + var_06,"");
		}

		param_01.hitlocinited = 1;
	}

	if(level.splitscreen || !isplayer(param_01))
	{
		return;
	}

	var_07 = 6;
	if(!isdefined(param_01.damageinfo))
	{
		param_01.damageinfo = [];
		for(var_06 = 0;var_06 < var_07;var_06++ = 7)
		{
			param_01.damageinfo[var_06] = spawnstruct();
			param_01.damageinfo[var_06].damage = 0;
			param_01.damageinfo[var_06].hitloc = "";
			param_01.damageinfo[var_06].bp = 0;
			param_01.damageinfo[var_06].jugg = 0;
			param_01.damageinfo[var_06].colorindex = 0;
		}

		param_01.damageinfocolorindex = 0;
		param_01.damageinfovictim = undefined;
	}

	for(var_06 = var_07 - 1;var_06 > 0;var_06-- = var_7B[2])
	{
		param_01.damageinfo[var_06].damage = param_01.damageinfo[var_06 - 1].damage;
		param_01.damageinfo[var_06].hitloc = param_01.damageinfo[var_06 - 1].hitloc;
		param_01.damageinfo[var_06].bp = param_01.damageinfo[var_06 - 1].bp;
		param_01.damageinfo[var_06].jugg = param_01.damageinfo[var_06 - 1].jugg;
		param_01.damageinfo[var_06].colorindex = param_01.damageinfo[var_06 - 1].colorindex;
	}

	param_01.damageinfo[0].damage = param_03;
	param_01.damageinfo[0].hitloc = param_04;
	param_01.damageinfo[0].bp = var_05 & level.idflags_penetration;
	param_01.damageinfo[0].jugg = param_02 maps\mp\_utility::isjuggernaut();
	if(isdefined(param_01.damageinfovictim) && param_01.damageinfovictim != param_02)
	{
		param_01.damageinfocolorindex++ = 5;
		if(param_01.damageinfocolorindex == var_7B.size)
		{
			param_01.damageinfocolorindex = 0;
		}
	}

	param_01.damageinfovictim = param_02;
	param_01.damageinfo[0].colorindex = param_01.damageinfocolorindex;
	for(var_06 = 0;var_06 < var_07;var_06++ = var_7B[1])
	{
		var_08 = "^" + var_7B[param_01.damageinfo[var_06].colorindex];
		if(param_01.damageinfo[var_06].hitloc != "")
		{
			var_09 = var_08 + param_01.damageinfo[var_06].hitloc;
			if(param_01.damageinfo[var_06].bp)
			{
				var_09 = var_09 + " (BP)";
			}

			if(param_01.damageinfo[var_06].jugg)
			{
				var_09 = var_09 + " (Jugg)";
			}

			param_01 setclientdvar("ui_hitloc_" + var_06,var_09);
		}

		param_01 setclientdvar("ui_hitloc_damage_" + var_06,var_08 + param_01.damageinfo[var_06].damage);
	}
}

//Function Number: 27
giverecentshieldxp()
{
	self endon("death");
	self endon("disconnect");
	self notify("giveRecentShieldXP");
	self endon("giveRecentShieldXP");
	self.recentshieldxp++;
	wait 20;
	self.recentshieldxp = 0;
}

//Function Number: 28
callback_playerdamage_internal(param_00,param_01,param_02,param_03,param_04,param_05,param_06,param_07,param_08,param_09,param_0A)
{
	if(!maps\mp\_utility::isreallyalive(param_02))
	{
		return;
	}

	if(isdefined(param_01) && param_01.classname == "script_origin" && isdefined(param_01.type) && param_01.type == "soft_landing")
	{
		return;
	}

	if(param_06 == "killstreak_emp_mp")
	{
		return;
	}

	if(param_06 == "bouncingbetty_mp" && !maps\mp\gametypes\_weapons::minedamageheightpassed(param_00,param_02))
	{
		return;
	}

	if(param_06 == "bouncingbetty_mp" && param_02 getstance() == "crouch" || param_02 getstance() == "prone")
	{
		param_03 = int(param_03 / 2);
	}

	if(param_06 == "xm25_mp" && param_05 == "MOD_IMPACT")
	{
		param_03 = 95;
	}

	if(param_06 == "emp_grenade_mp" && param_05 != "MOD_IMPACT")
	{
		param_02 notify("emp_grenaded",param_01);
	}

	if(isdefined(level.hostmigrationtimer))
	{
		return;
	}

	if(param_05 == "MOD_FALLING")
	{
		param_02 thread emitfalldamage(param_03);
	}

	if(param_05 == "MOD_EXPLOSIVE_BULLET" && param_03 != 1)
	{
		param_03 = param_03 * getdvarfloat("scr_explBulletMod");
		param_03 = int(param_03);
	}

	if(isdefined(param_01) && param_01.classname == "worldspawn")
	{
		param_01 = undefined;
	}

	if(isdefined(param_01) && isdefined(param_01.gunner))
	{
		param_01 = param_01.gunner;
	}

	var_0B = isdefined(param_01) && !isdefined(param_01.gunner) && param_01.classname == "script_vehicle" || param_01.classname == "misc_turret" || param_01.classname == "script_model";
	var_0C = level.teambased && isdefined(param_01) && param_02 != param_01 && isdefined(param_01.team) && param_02.pers["team"] == param_01.team;
	var_0D = isdefined(param_01) && isdefined(param_00) && isdefined(param_02) && isplayer(param_01) && param_01 == param_00 && param_01 == param_02;
	if(var_0D)
	{
		return;
	}

	var_0E = 0;
	if(param_04 & level.idflags_stun)
	{
		var_0E = 0;
		param_03 = 0;
	}
	else if(param_09 == "shield")
	{
		if(var_0C && level.friendlyfire == 0)
		{
			return;
		}

		if(param_05 == "MOD_PISTOL_BULLET" || param_05 == "MOD_RIFLE_BULLET" || param_05 == "MOD_EXPLOSIVE_BULLET" && !var_0C)
		{
			if(isplayer(param_01))
			{
				param_01.lastattackedshieldplayer = param_02;
				param_01.lastattackedshieldtime = gettime();
			}

			param_02 notify("shield_blocked");
			if(maps\mp\_utility::isenvironmentweapon(param_06))
			{
				var_0F = 25;
			}
			else
			{
				var_0F = maps\mp\perks\_perks::cac_modified_damage(param_03,param_02,param_04,param_06,param_07,param_08,param_09,param_0A);
			}

			param_02.shielddamage = param_02.shielddamage + var_0F;
			if(!maps\mp\_utility::isenvironmentweapon(param_06) || common_scripts\utility::cointoss())
			{
				param_02.shieldbullethits++;
			}

			if(param_02.shieldbullethits >= level.riotshieldxpbullets)
			{
				if(self.recentshieldxp > 4)
				{
					var_10 = int(50 / self.recentshieldxp);
				}
				else
				{
					var_10 = 50;
				}

				param_02 thread maps\mp\gametypes\_rank::giverankxp("shield_damage",var_10);
				param_02 thread giverecentshieldxp();
				param_02 thread maps\mp\gametypes\_missions::genericchallenge("shield_damage",param_02.shielddamage);
				param_02 thread maps\mp\gametypes\_missions::genericchallenge("shield_bullet_hits",param_02.shieldbullethits);
				param_02.shielddamage = 0;
				param_02.shieldbullethits = 0;
			}
		}

		if(param_04 & level.idflags_shield_explosive_impact)
		{
			if(!var_0C)
			{
				param_02 thread maps\mp\gametypes\_missions::genericchallenge("shield_explosive_hits",1);
			}

			param_09 = "none";
			if(!param_04 & level.idflags_shield_explosive_impact_huge)
			{
				param_03 = param_03 * 0;
			}
		}
		else if(param_04 & level.idflags_shield_explosive_splash)
		{
			if(isdefined(param_00) && isdefined(param_00.stuckenemyentity) && param_00.stuckenemyentity == param_02)
			{
				param_03 = 101;
			}

			param_02 thread maps\mp\gametypes\_missions::genericchallenge("shield_explosive_hits",1);
			param_09 = "none";
		}
		else
		{
			return;
		}
	}
	else if(param_05 == "MOD_MELEE" && issubstr(param_06,"riotshield"))
	{
		if(!var_0C && level.friendlyfire == 0)
		{
			var_0E = 0;
			param_02 stunplayer(0);
		}
	}

	if(!var_0C)
	{
		param_03 = maps\mp\perks\_perks::cac_modified_damage(param_02,param_01,param_03,param_05,param_06,param_07,param_08,param_09);
	}

	if(isdefined(level.modifyplayerdamage))
	{
		param_03 = [[ level.modifyplayerdamage ]](param_02,param_01,param_03,param_05,param_06,param_07,param_08,param_09);
	}

	if(!param_03)
	{
		return 0;
	}

	param_02.idflags = param_04;
	param_02.idflagstime = gettime();
	if(game["state"] == "postgame")
	{
		return;
	}

	if(param_02.sessionteam == "spectator")
	{
		return;
	}

	if(isdefined(param_02.candocombat) && !param_02.candocombat)
	{
		return;
	}

	if(isdefined(param_01) && isplayer(param_01) && isdefined(param_01.candocombat) && !param_01.candocombat)
	{
		return;
	}

	if(var_0B && var_0C)
	{
		if(param_05 == "MOD_CRUSH")
		{
			param_02 maps\mp\_utility::_suicide();
			return;
		}

		if(!level.friendlyfire)
		{
			return;
		}
	}

	if(!isdefined(param_08))
	{
		param_04 = param_04 | level.idflags_no_knockback;
	}

	var_11 = 0;
	if((param_02.health == param_02.maxhealth && !isdefined(param_02.laststand) || !param_02.laststand) || !isdefined(param_02.attackers) && !isdefined(param_02.laststand))
	{
		param_02.attackers = [];
		param_02.attackerdata = [];
	}

	if(isheadshot(param_06,param_09,param_05,param_01))
	{
		param_05 = "MOD_HEAD_SHOT";
	}

	if(maps\mp\gametypes\_tweakables::gettweakablevalue("game","onlyheadshots"))
	{
		if(param_05 == "MOD_PISTOL_BULLET" || param_05 == "MOD_RIFLE_BULLET" || param_05 == "MOD_EXPLOSIVE_BULLET")
		{
			return;
		}
		else if(param_05 == "MOD_HEAD_SHOT")
		{
			param_03 = 150;
		}
	}

	if(param_06 == "none" && isdefined(param_00))
	{
		if(isdefined(param_00.destructible_type) && issubstr(param_00.destructible_type,"vehicle_"))
		{
			param_06 = "destructible_car";
		}
	}

	if(gettime() < param_02.spawntime + level.killstreakspawnshield)
	{
		var_12 = int(max(param_02.health / 4,1));
		if(param_03 >= var_12 && maps\mp\_utility::iskillstreakweapon(param_06))
		{
			param_03 = var_12;
		}
	}

	if(!param_04 & level.idflags_no_protection)
	{
		if(!level.teambased && var_0B && isdefined(param_01.owner) && param_01.owner == param_02)
		{
			if(param_05 == "MOD_CRUSH")
			{
				param_02 maps\mp\_utility::_suicide();
			}

			return;
		}

		if((issubstr(param_05,"MOD_GRENADE") || issubstr(param_05,"MOD_EXPLOSIVE") || issubstr(param_05,"MOD_PROJECTILE")) && isdefined(param_00) && isdefined(param_01))
		{
			if(param_02 != param_01 && param_00.classname == "grenade" && param_02.lastspawntime + 3500 > gettime() && isdefined(param_02.lastspawnpoint) && distance(param_00.origin,param_02.lastspawnpoint.origin) < 250)
			{
				return;
			}

			param_02.explosiveinfo = [];
			param_02.explosiveinfo["damageTime"] = gettime();
			param_02.explosiveinfo["damageId"] = param_00 getentitynumber();
			param_02.explosiveinfo["returnToSender"] = 0;
			param_02.explosiveinfo["counterKill"] = 0;
			param_02.explosiveinfo["chainKill"] = 0;
			param_02.explosiveinfo["cookedKill"] = 0;
			param_02.explosiveinfo["throwbackKill"] = 0;
			param_02.explosiveinfo["suicideGrenadeKill"] = 0;
			param_02.explosiveinfo["weapon"] = param_06;
			var_13 = issubstr(param_06,"frag_");
			if(param_01 != param_02)
			{
				if((issubstr(param_06,"c4_") || issubstr(param_06,"claymore_")) && isdefined(param_01) && isdefined(param_00.owner))
				{
					param_02.explosiveinfo["returnToSender"] = param_00.owner == param_02;
					param_02.explosiveinfo["counterKill"] = isdefined(param_00.wasdamaged);
					param_02.explosiveinfo["chainKill"] = isdefined(param_00.waschained);
					param_02.explosiveinfo["bulletPenetrationKill"] = isdefined(param_00.wasdamagedfrombulletpenetration);
					param_02.explosiveinfo["cookedKill"] = 0;
				}

				if(isdefined(param_01.lastgrenadesuicidetime) && param_01.lastgrenadesuicidetime >= gettime() - 50 && var_13)
				{
					param_02.explosiveinfo["suicideGrenadeKill"] = 1;
				}
			}

			if(var_13)
			{
				param_02.explosiveinfo["cookedKill"] = isdefined(param_00.iscooked);
				param_02.explosiveinfo["throwbackKill"] = isdefined(param_00.threwback);
			}

			param_02.explosiveinfo["stickKill"] = isdefined(param_00.isstuck) && param_00.isstuck == "enemy";
			param_02.explosiveinfo["stickFriendlyKill"] = isdefined(param_00.isstuck) && param_00.isstuck == "friendly";
			if(isplayer(param_01) && param_01 != self)
			{
				maps\mp\gametypes\_gamelogic::setinflictorstat(param_00,param_01,param_06);
			}
		}

		if(isplayer(param_01) && isdefined(param_01.pers["participation"]))
		{
			param_01.pers["participation"]++;
		}
		else if(isplayer(param_01))
		{
			param_01.pers["participation"] = 1;
		}

		var_14 = param_02.health / param_02.maxhealth;
		if(var_0C)
		{
			if(!maps\mp\_utility::matchmakinggame() && isplayer(param_01))
			{
				param_01 maps\mp\_utility::incplayerstat("mostff",1);
			}

			if(level.friendlyfire == 0 || !isplayer(param_01) && level.friendlyfire != 1)
			{
				if(param_06 == "artillery_mp" || param_06 == "stealth_bomb_mp")
				{
					param_02 damageshellshockandrumble(param_00,param_06,param_05,param_03,param_04,param_01);
				}

				return;
			}
			else if(level.friendlyfire == 1)
			{
				if(param_03 < 1)
				{
					param_03 = 1;
				}

				if(param_02 maps\mp\_utility::isjuggernaut())
				{
					param_03 = maps\mp\perks\_perks::cac_modified_damage(param_02,param_01,param_03,param_05,param_06,param_07,param_08,param_09);
				}

				param_02.lastdamagewasfromenemy = 0;
				param_02 finishplayerdamagewrapper(param_00,param_01,param_03,param_04,param_05,param_06,param_07,param_08,param_09,param_0A,var_0E);
			}
			else if(level.friendlyfire == 2 && maps\mp\_utility::isreallyalive(param_01))
			{
				param_03 = int(param_03 * 0.5);
				if(param_03 < 1)
				{
					param_03 = 1;
				}

				param_01.lastdamagewasfromenemy = 0;
				param_01.friendlydamage = 1;
				param_01 finishplayerdamagewrapper(param_00,param_01,param_03,param_04,param_05,param_06,param_07,param_08,param_09,param_0A,var_0E);
				param_01.friendlydamage = undefined;
			}
			else if(level.friendlyfire == 3 && maps\mp\_utility::isreallyalive(param_01))
			{
				param_03 = int(param_03 * 0.5);
				if(param_03 < 1)
				{
					param_03 = 1;
				}

				param_02.lastdamagewasfromenemy = 0;
				param_01.lastdamagewasfromenemy = 0;
				param_02 finishplayerdamagewrapper(param_00,param_01,param_03,param_04,param_05,param_06,param_07,param_08,param_09,param_0A,var_0E);
				if(maps\mp\_utility::isreallyalive(param_01))
				{
					param_01.friendlydamage = 1;
					param_01 finishplayerdamagewrapper(param_00,param_01,param_03,param_04,param_05,param_06,param_07,param_08,param_09,param_0A,var_0E);
					param_01.friendlydamage = undefined;
				}
			}

			var_11 = 1;
		}
		else
		{
			if(param_03 < 1)
			{
				param_03 = 1;
			}

			if(isdefined(param_01) && isplayer(param_01))
			{
				addattacker(param_02,param_01,param_00,param_06,param_03,param_07,param_08,param_09,param_0A,param_05);
			}

			if(param_05 == "MOD_EXPLOSIVE" || param_05 == "MOD_GRENADE_SPLASH" && param_03 < param_02.health)
			{
				param_02 notify("survived_explosion",param_01);
			}

			if(isdefined(param_01))
			{
				level.lastlegitimateattacker = param_01;
			}

			if(isdefined(param_01) && isplayer(param_01) && isdefined(param_06))
			{
				param_01 thread maps\mp\gametypes\_weapons::checkhit(param_06,param_02);
			}

			if(isdefined(param_01) && isplayer(param_01) && isdefined(param_06) && param_01 != param_02)
			{
				param_01 thread maps\mp\_events::damagedplayer(self,param_03,param_06);
				param_02.attackerposition = param_01.origin;
			}
			else
			{
				param_02.attackerposition = undefined;
			}

			if(issubstr(param_05,"MOD_GRENADE") && isdefined(param_00.iscooked))
			{
				param_02.wascooked = gettime();
			}
			else
			{
				param_02.wascooked = undefined;
			}

			param_02.lastdamagewasfromenemy = isdefined(param_01) && param_01 != param_02;
			if(param_02.lastdamagewasfromenemy)
			{
				param_01.damagedplayers[param_02.guid] = gettime();
			}

			param_02 finishplayerdamagewrapper(param_00,param_01,param_03,param_04,param_05,param_06,param_07,param_08,param_09,param_0A,var_0E);
			if(isdefined(level.ac130player) && isdefined(param_01) && level.ac130player == param_01)
			{
				level notify("ai_pain",param_02);
			}

			param_02 thread maps\mp\gametypes\_missions::playerdamaged(param_00,param_01,param_03,param_05,param_06,param_09);
		}

		if(var_0B && isdefined(param_01.gunner))
		{
			var_15 = param_01.gunner;
		}
		else
		{
			var_15 = param_02;
		}

		if(isdefined(var_15) && var_15 != param_02 && param_03 > 0 && !isdefined(param_09) || param_09 != "shield")
		{
			if(param_04 & level.idflags_stun)
			{
				var_16 = "stun";
			}
			else if(isexplosivedamagemod(param_06) && param_03 maps\mp\_utility::_hasperk("_specialty_blastshield"))
			{
				var_16 = "hitBodyArmor";
			}
			else if(param_03 maps\mp\_utility::_hasperk("specialty_combathigh"))
			{
				var_16 = "hitEndGame";
			}
			else if(isdefined(param_03.haslightarmor))
			{
				var_16 = "hitLightArmor";
			}
			else if(param_03 maps\mp\_utility::isjuggernaut())
			{
				var_16 = "hitJuggernaut";
			}
			else if(!shouldweaponfeedback(param_07))
			{
				var_16 = "none";
			}
			else
			{
				var_16 = "standard";
			}

			var_15 thread maps\mp\gametypes\_damagefeedback::updatedamagefeedback(var_16);
		}

		param_02.hasdonecombat = 1;
	}

	if(isdefined(param_01) && param_01 != param_02 && !var_11)
	{
		level.usestartspawns = 0;
	}

	if(param_03 > 0 && isdefined(param_01) && !param_02 maps\mp\_utility::isusingremote())
	{
		param_02 thread maps\mp\gametypes\_shellshock::bloodeffect(param_01.origin);
	}

	if(param_02.sessionstate != "dead")
	{
		var_17 = param_02 getentitynumber();
		var_18 = param_02.name;
		var_19 = param_02.pers["team"];
		var_1A = param_02.guid;
		var_1B = "";
		if(isplayer(param_01))
		{
			var_1C = param_01 getentitynumber();
			var_1D = param_01.guid;
			var_1E = param_01.name;
			var_1B = param_01.pers["team"];
		}
		else
		{
			var_1C = -1;
			var_1D = "";
			var_1E = "";
			var_1B = "world";
		}

		logprint("D;" + var_1A + ";" + var_17 + ";" + var_19 + ";" + var_18 + ";" + var_1D + ";" + var_1C + ";" + var_1B + ";" + var_1E + ";" + param_06 + ";" + param_03 + ";" + param_05 + ";" + param_09 + "\n");
	}

	hitlocdebug(param_01,param_02,param_03,param_09,param_04);
	if(isdefined(param_01) && param_01 != param_02)
	{
		if(isplayer(param_01))
		{
			param_01 maps\mp\_utility::incplayerstat("damagedone",param_03);
		}

		param_02 maps\mp\_utility::incplayerstat("damagetaken",param_03);
	}
}

//Function Number: 29
shouldweaponfeedback(param_00)
{
	switch(param_00)
	{
		case "stealth_bomb_mp":
		case "artillery_mp":
			return 0;
	}

	return 1;
}

//Function Number: 30
checkvictimstutter(param_00,param_01,param_02,param_03,param_04)
{
	if(param_04 == "MOD_PISTOL_BULLET" || param_04 == "MOD_RIFLE_BULLET" || param_04 == "MOD_HEAD_SHOT")
	{
		if(distance(param_00.origin,param_01.origin) > 256)
		{
			return;
		}

		var_05 = param_00 getvelocity();
		if(lengthsquared(var_05) < 10)
		{
			return;
		}

		var_06 = maps\mp\_utility::findisfacing(param_00,param_01,25);
		if(var_06)
		{
			param_00 thread stutterstep();
		}
	}
}

//Function Number: 31
stutterstep(param_00)
{
	self endon("disconnect");
	self endon("death");
	level endon("game_ended");
	self.instutter = 1;
	self.movespeedscaler = 0.05;
	maps\mp\gametypes\_weapons::updatemovespeedscale();
	wait 0.5;
	self.movespeedscaler = 1;
	if(maps\mp\_utility::_hasperk("specialty_lightweight"))
	{
		self.movespeedscaler = maps\mp\_utility::lightweightscalar();
	}

	maps\mp\gametypes\_weapons::updatemovespeedscale();
	self.instutter = 0;
}

//Function Number: 32
addattacker(param_00,param_01,param_02,param_03,param_04,param_05,param_06,param_07,param_08,param_09)
{
	if(!isdefined(param_00.attackerdata))
	{
		param_00.attackerdata = [];
	}

	if(!isdefined(param_00.attackerdata[param_01.guid]))
	{
		param_00.attackers[param_01.guid] = param_01;
		param_00.attackerdata[param_01.guid] = spawnstruct();
		param_00.attackerdata[param_01.guid].damage = 0;
		param_00.attackerdata[param_01.guid].attackerent = param_01;
		param_00.attackerdata[param_01.guid].firsttimedamaged = gettime();
	}

	if(maps\mp\gametypes\_weapons::isprimaryweapon(param_03) && !maps\mp\gametypes\_weapons::issidearm(param_03))
	{
		param_00.attackerdata[param_01.guid].isprimary = 1;
	}

	param_00.attackerdata[param_01.guid].damage = param_00.attackerdata[param_01.guid].damage + param_04;
	param_00.attackerdata[param_01.guid].weapon = param_03;
	param_00.attackerdata[param_01.guid].vpoint = param_05;
	param_00.attackerdata[param_01.guid].vdir = param_06;
	param_00.attackerdata[param_01.guid].shitloc = param_07;
	param_00.attackerdata[param_01.guid].psoffsettime = param_08;
	param_00.attackerdata[param_01.guid].smeansofdeath = param_09;
	param_00.attackerdata[param_01.guid].attackerent = param_01;
	param_00.attackerdata[param_01.guid].lasttimedamaged = gettime();
	if(isdefined(param_02) && !isplayer(param_02) && isdefined(param_02.primaryweapon))
	{
		param_00.attackerdata[param_01.guid].sprimaryweapon = param_02.primaryweapon;
		return;
	}

	if(isdefined(param_01) && isplayer(param_01) && param_01 getcurrentprimaryweapon() != "none")
	{
		param_00.attackerdata[param_01.guid].sprimaryweapon = param_01 getcurrentprimaryweapon();
		return;
	}

	param_00.attackerdata[param_01.guid].sprimaryweapon = undefined;
}

//Function Number: 33
resetattackerlist()
{
	self endon("disconnect");
	self endon("death");
	level endon("game_ended");
	wait 1.75;
	self.attackers = [];
	self.attackerdata = [];
}

//Function Number: 34
callback_playerdamage(param_00,param_01,param_02,param_03,param_04,param_05,param_06,param_07,param_08,param_09)
{
	callback_playerdamage_internal(param_00,param_01,self,param_02,param_03,param_04,param_05,param_06,param_07,param_08,param_09);
}

//Function Number: 35
finishplayerdamagewrapper(param_00,param_01,param_02,param_03,param_04,param_05,param_06,param_07,param_08,param_09,param_0A)
{
	if(maps\mp\_utility::isusingremote() && param_02 >= self.health && !param_03 & level.idflags_stun)
	{
		if(!isdefined(param_07))
		{
			param_07 = (0,0,0);
		}

		if(!isdefined(param_01) && !isdefined(param_00))
		{
			param_01 = self;
			param_00 = param_01;
		}

		playerkilled_internal(param_00,param_01,self,param_02,param_04,param_05,param_07,param_08,param_09,0,1);
	}
	else
	{
		if(!callback_killingblow(param_00,param_01,param_02 - param_02 * param_0A,param_03,param_04,param_05,param_06,param_07,param_08,param_09))
		{
			return;
		}

		if(!isalive(self))
		{
			return;
		}

		self finishplayerdamage(param_00,param_01,param_02,param_03,param_04,param_05,param_06,param_07,param_08,param_09,param_0A);
	}

	if(param_04 == "MOD_EXPLOSIVE_BULLET")
	{
		self shellshock("damage_mp",getdvarfloat("scr_csmode"));
	}

	damageshellshockandrumble(param_00,param_05,param_04,param_02,param_03,param_01);
}

//Function Number: 36
callback_playerlaststand(param_00,param_01,param_02,param_03,param_04,param_05,param_06,param_07,param_08)
{
	var_09 = spawnstruct();
	var_09.einflictor = param_00;
	var_09.attacker = param_01;
	var_09.idamage = param_02;
	var_09.attackerposition = param_01.origin;
	if(param_01 == self)
	{
		var_09.smeansofdeath = "MOD_SUICIDE";
	}
	else
	{
		var_09.smeansofdeath = param_03;
	}

	var_09.sweapon = param_04;
	if(isdefined(param_01) && isplayer(param_01) && param_01 getcurrentprimaryweapon() != "none")
	{
		var_09.sprimaryweapon = param_01 getcurrentprimaryweapon();
	}
	else
	{
		var_09.sprimaryweapon = undefined;
	}

	var_09.vdir = param_05;
	var_09.shitloc = param_06;
	var_09.laststandstarttime = gettime();
	var_0A = maydolaststand(param_04,param_03,param_06);
	if(isdefined(self.endgame))
	{
		var_0A = 0;
	}

	if(level.teambased && isdefined(param_01.team) && param_01.team == self.team)
	{
		var_0A = 0;
	}

	if(!var_0A)
	{
		self.laststandparams = var_09;
		self.uselaststandparams = 1;
		maps\mp\_utility::_suicide();
		return;
	}

	self.inlaststand = 1;
	var_0B = spawnstruct();
	if(maps\mp\_utility::_hasperk("specialty_finalstand"))
	{
		var_0B.titletext = game["strings"]["final_stand"];
		var_0B.iconname = "specialty_finalstand";
	}
	else if(maps\mp\_utility::_hasperk("specialty_c4death"))
	{
		var_0B.titletext = game["strings"]["c4_death"];
		var_0B.iconname = "specialty_c4death";
	}
	else
	{
		var_0B.titletext = game["strings"]["last_stand"];
		var_0B.iconname = "specialty_pistoldeath";
	}

	var_0B.glowcolor = (1,0,0);
	var_0B.sound = "mp_last_stand";
	var_0B.duration = 2;
	self.health = 1;
	thread maps\mp\gametypes\_hud_message::notifymessage(var_0B);
	var_0C = "frag_grenade_mp";
	if(isdefined(level.ac130player) && isdefined(param_01) && level.ac130player == param_01)
	{
		level notify("ai_crawling",self);
	}

	if(maps\mp\_utility::_hasperk("specialty_finalstand"))
	{
		self.laststandparams = var_09;
		self.infinalstand = 1;
		var_0D = self getweaponslistexclusives();
		foreach(var_0F in var_0D)
		{
			self takeweapon(var_0F);
		}

		common_scripts\utility::_disableusability();
		thread enablelaststandweapons();
		thread laststandtimer(20,1);
		return;
	}

	if(maps\mp\_utility::_hasperk("specialty_c4death"))
	{
		self.previousprimary = self.lastdroppableweapon;
		self.laststandparams = var_09;
		self takeallweapons();
		self giveweapon("c4death_mp",0,0);
		self switchtoweapon("c4death_mp");
		common_scripts\utility::_disableusability();
		self.inc4death = 1;
		thread laststandtimer(20,0);
		thread detonateonuse();
		thread detonateondeath();
		return;
	}

	if(level.diehardmode)
	{
		self.laststandparams = var_09;
		thread enablelaststandweapons();
		thread laststandtimer(20,0);
		common_scripts\utility::_disableusability();
		return;
	}

	self.laststandparams = var_09;
	var_11 = undefined;
	var_12 = self getweaponslistprimaries();
	foreach(var_0F in var_12)
	{
		if(maps\mp\gametypes\_weapons::issidearm(var_0F))
		{
			var_11 = var_0F;
		}
	}

	if(!isdefined(var_11))
	{
		var_11 = "iw5_usp45_mp";
		maps\mp\_utility::_giveweapon(var_11);
	}

	self givemaxammo(var_11);
	self disableweaponswitch();
	common_scripts\utility::_disableusability();
	if(!maps\mp\_utility::_hasperk("specialty_laststandoffhand"))
	{
		self disableoffhandweapons();
	}

	self switchtoweapon(var_11);
	thread laststandtimer(10,0);
}

//Function Number: 37
dieaftertime(param_00)
{
	self endon("death");
	self endon("disconnect");
	self endon("joined_team");
	level endon("game_ended");
	wait param_00;
	self.uselaststandparams = 1;
	maps\mp\_utility::_suicide();
}

//Function Number: 38
detonateonuse()
{
	self endon("death");
	self endon("disconnect");
	self endon("joined_team");
	level endon("game_ended");
	self waittill("detonate");
	self.uselaststandparams = 1;
	c4deathdetonate();
}

//Function Number: 39
detonateondeath()
{
	self endon("detonate");
	self endon("disconnect");
	self endon("joined_team");
	level endon("game_ended");
	self waittill("death");
	c4deathdetonate();
}

//Function Number: 40
c4deathdetonate()
{
	self playsound("detpack_explo_default");
	self.c4deatheffect = playfx(level.c4death,self.origin);
	radiusdamage(self.origin,400,100,100,self);
	if(isalive(self))
	{
		maps\mp\_utility::_suicide();
	}
}

//Function Number: 41
enablelaststandweapons()
{
	self endon("death");
	self endon("disconnect");
	level endon("game_ended");
	maps\mp\_utility::freezecontrolswrapper(1);
	wait 0.3;
	maps\mp\_utility::freezecontrolswrapper(0);
}

//Function Number: 42
laststandtimer(param_00,param_01)
{
	self endon("death");
	self endon("disconnect");
	self endon("revive");
	level endon("game_ended");
	level notify("player_last_stand");
	thread laststandwaittilldeath();
	self.laststand = 1;
	if(!param_01 && !level.diehardmode && !isdefined(self.inc4death) || !self.inc4death)
	{
		thread laststandallowsuicide();
		maps\mp\_utility::setlowermessage("last_stand",&"PLATFORM_COWARDS_WAY_OUT",undefined,undefined,undefined,undefined,undefined,undefined,1);
		thread laststandkeepoverlay();
	}

	if(level.diehardmode == 1 && level.diehardmode != 2)
	{
		var_02 = spawn("script_model",self.origin);
		var_02 setmodel("tag_origin");
		var_02 setcursorhint("HINT_NOICON");
		var_02 sethintstring(&"PLATFORM_REVIVE");
		var_02 revivesetup(self);
		var_02 endon("death");
		var_03 = newteamhudelem(self.team);
		var_03 setshader("waypoint_revive",8,8);
		var_03 setwaypoint(1,1);
		var_03 settargetent(self);
		var_03 thread destroyonreviveentdeath(var_02);
		var_03.color = (0.33,0.75,0.24);
		maps\mp\_utility::playdeathsound();
		if(param_01)
		{
			wait param_00;
			if(self.infinalstand)
			{
				thread laststandbleedout(param_01,var_02);
			}
		}

		return;
	}
	else if(level.diehardmode == 2)
	{
		thread laststandkeepoverlay();
		var_02 = spawn("script_model",self.origin);
		var_03 setmodel("tag_origin");
		var_03 setcursorhint("HINT_NOICON");
		var_03 sethintstring(&"PLATFORM_REVIVE");
		var_03 revivesetup(self);
		var_03 endon("death");
		var_03 = newteamhudelem(self.team);
		var_03 setshader("waypoint_revive",8,8);
		var_03 setwaypoint(1,1);
		var_03 settargetent(self);
		var_03 thread destroyonreviveentdeath(var_02);
		var_03.color = (0.33,0.75,0.24);
		maps\mp\_utility::playdeathsound();
		if(param_01)
		{
			wait param_00;
			if(self.infinalstand)
			{
				thread laststandbleedout(param_01,var_02);
			}
		}

		wait param_00 / 3;
		var_03.color = (1,0.64,0);
		while(var_02.inuse)
		{
			wait 0.05;
		}

		maps\mp\_utility::playdeathsound();
		wait param_00 / 3;
		var_03.color = (1,0,0);
		while(var_02.inuse)
		{
			wait 0.05;
		}

		maps\mp\_utility::playdeathsound();
		wait param_00 / 3;
		while(var_02.inuse)
		{
			wait 0.05;
		}

		wait 0.05;
		thread laststandbleedout(param_01);
		return;
	}

	thread laststandkeepoverlay();
	wait var_02;
	thread laststandbleedout(var_03);
}

//Function Number: 43
maxhealthoverlay(param_00,param_01)
{
	self endon("stop_maxHealthOverlay");
	self endon("revive");
	self endon("death");
	for(;;)
	{
		self.health = self.health - 1;
		self.maxhealth = param_00;
		wait 0.05;
		self.maxhealth = 50;
		self.health = self.health + 1;
		wait 0.5;
	}
}

//Function Number: 44
laststandbleedout(param_00,param_01)
{
	if(param_00)
	{
		self.laststand = undefined;
		self.infinalstand = 0;
		self notify("revive");
		maps\mp\_utility::clearlowermessage("last_stand");
		maps\mp\gametypes\_playerlogic::laststandrespawnplayer();
		if(isdefined(param_01))
		{
			param_01 delete();
			return;
		}

		return;
	}

	self.uselaststandparams = 1;
	self.beingrevived = 0;
	maps\mp\_utility::_suicide();
}

//Function Number: 45
laststandallowsuicide()
{
	self endon("death");
	self endon("disconnect");
	self endon("game_ended");
	self endon("revive");
	for(;;)
	{
		if(self usebuttonpressed())
		{
			var_00 = gettime();
			while(self usebuttonpressed())
			{
				wait 0.05;
				if(gettime() - var_00 > 700)
				{
					break;
				}
			}

			if(gettime() - var_00 > 700)
			{
				break;
			}
		}

		wait 0.05;
	}

	thread laststandbleedout(0);
}

//Function Number: 46
laststandkeepoverlay()
{
	level endon("game_ended");
	self endon("death");
	self endon("disconnect");
	self endon("revive");
	while(!level.gameended)
	{
		self.health = 2;
		wait 0.05;
		self.health = 1;
		wait 0.5;
	}

	self.health = self.maxhealth;
}

//Function Number: 47
laststandwaittilldeath()
{
	self endon("disconnect");
	self endon("revive");
	level endon("game_ended");
	self waittill("death");
	maps\mp\_utility::clearlowermessage("last_stand");
	self.laststand = undefined;
}

//Function Number: 48
maydolaststand(param_00,param_01,param_02)
{
	if(param_01 == "MOD_TRIGGER_HURT")
	{
		return 0;
	}

	if(param_01 != "MOD_PISTOL_BULLET" && param_01 != "MOD_RIFLE_BULLET" && param_01 != "MOD_FALLING" && param_01 != "MOD_EXPLOSIVE_BULLET")
	{
		return 0;
	}

	if(param_01 == "MOD_IMPACT" && param_00 == "throwingknife_mp")
	{
		return 0;
	}

	if(param_01 == "MOD_IMPACT" && param_00 == "m79_mp" || issubstr(param_00,"gl_"))
	{
		return 0;
	}

	if(isheadshot(param_00,param_02,param_01))
	{
		return 0;
	}

	if(maps\mp\_utility::isusingremote())
	{
		return 0;
	}

	return 1;
}

//Function Number: 49
ensurelaststandparamsvalidity()
{
	if(!isdefined(self.laststandparams.attacker))
	{
		self.laststandparams.attacker = self;
	}
}

//Function Number: 50
gethitlocheight(param_00)
{
	switch(param_00)
	{
		case "neck":
		case "head":
		case "helmet":
			return 60;

		case "gun":
		case "right_hand":
		case "left_hand":
		case "right_arm_lower":
		case "left_arm_lower":
		case "right_arm_upper":
		case "left_arm_upper":
		case "torso_upper":
			return 48;

		case "torso_lower":
			return 40;

		case "right_leg_upper":
		case "left_leg_upper":
			return 32;

		case "right_leg_lower":
		case "left_leg_lower":
			return 10;

		case "right_foot":
		case "left_foot":
			return 5;
	}

	return 48;
}

//Function Number: 51
delaystartragdoll(param_00,param_01,param_02,param_03,param_04,param_05)
{
	if(isdefined(param_00))
	{
		var_06 = param_00 getcorpseanim();
		if(animhasnotetrack(var_06,"ignore_ragdoll"))
		{
			return;
		}
	}

	if(isdefined(level.noragdollents) && level.noragdollents.size)
	{
		foreach(var_08 in level.noragdollents)
		{
			if(distancesquared(param_00.origin,var_08.origin) < 65536)
			{
				return;
			}
		}
	}

	wait 0.2;
	if(!isdefined(param_00))
	{
		return;
	}

	if(param_00 isragdoll())
	{
		return;
	}

	var_06 = param_00 getcorpseanim();
	var_0A = 0.35;
	if(animhasnotetrack(var_06,"start_ragdoll"))
	{
		var_0B = getnotetracktimes(var_06,"start_ragdoll");
		if(isdefined(var_0B))
		{
			var_0A = var_0B[0];
		}
	}

	var_0C = var_0A * getanimlength(var_06);
	wait var_0C;
	if(isdefined(param_00))
	{
		param_00 startragdoll(1);
	}
}

//Function Number: 52
getmostkilledby()
{
	var_00 = "";
	var_01 = 0;
	var_02 = getarraykeys(self.killedby);
	for(var_03 = 0;var_03 < var_02.size;var_03++)
	{
		var_04 = var_02[var_03];
		if(self.killedby[var_04] <= var_01)
		{
			continue;
		}

		var_01 = self.killedby[var_04];
		var_05 = var_04;
	}

	return var_00;
}

//Function Number: 53
getmostkilled()
{
	var_00 = "";
	var_01 = 0;
	var_02 = getarraykeys(self.killedplayers);
	for(var_03 = 0;var_03 < var_02.size;var_03++)
	{
		var_04 = var_02[var_03];
		if(self.killedplayers[var_04] <= var_01)
		{
			continue;
		}

		var_01 = self.killedplayers[var_04];
		var_00 = var_04;
	}

	return var_00;
}

//Function Number: 54
damageshellshockandrumble(param_00,param_01,param_02,param_03,param_04,param_05)
{
	thread maps\mp\gametypes\_weapons::onweapondamage(param_00,param_01,param_02,param_03,param_05);
	self playrumbleonentity("damage_heavy");
}

//Function Number: 55
revivesetup(param_00)
{
	var_01 = param_00.team;
	self linkto(param_00,"tag_origin");
	self.owner = param_00;
	self.inuse = 0;
	self makeusable();
	updateusablebyteam(var_01);
	thread trackteamchanges(var_01);
	thread revivetriggerthink(var_01);
	thread deleteonreviveordeathordisconnect();
}

//Function Number: 56
deleteonreviveordeathordisconnect()
{
	self endon("death");
	self.owner common_scripts\utility::waittill_any("death","disconnect");
	self delete();
}

//Function Number: 57
updateusablebyteam(param_00)
{
	foreach(var_02 in level.players)
	{
		if(param_00 == var_02.team && var_02 != self.owner)
		{
			self enableplayeruse(var_02);
			continue;
		}

		self disableplayeruse(var_02);
	}
}

//Function Number: 58
trackteamchanges(param_00)
{
	self endon("death");
	for(;;)
	{
		level waittill("joined_team");
		updateusablebyteam(param_00);
	}
}

//Function Number: 59
tracklaststandchanges(param_00)
{
	self endon("death");
	for(;;)
	{
		level waittill("player_last_stand");
		updateusablebyteam(param_00);
	}
}

//Function Number: 60
revivetriggerthink(param_00)
{
	self endon("death");
	level endon("game_ended");
	for(;;)
	{
		self waittill("trigger",var_01);
		self.owner.beingrevived = 1;
		if(isdefined(var_01.beingrevived) && var_01.beingrevived)
		{
			self.owner.beingrevived = 0;
			continue;
		}

		self makeunusable();
		self.owner maps\mp\_utility::freezecontrolswrapper(1);
		var_02 = useholdthink(var_01);
		self.owner.beingrevived = 0;
		if(!isalive(self.owner))
		{
			self delete();
			return;
		}

		self.owner maps\mp\_utility::freezecontrolswrapper(0);
		if(var_02)
		{
			var_01 thread maps\mp\gametypes\_hud_message::splashnotifydelayed("reviver",200);
			var_01 thread maps\mp\gametypes\_rank::giverankxp("reviver",200);
			self.owner.laststand = undefined;
			self.owner maps\mp\_utility::clearlowermessage("last_stand");
			self.owner.movespeedscaler = 1;
			if(self.owner maps\mp\_utility::_hasperk("specialty_lightweight"))
			{
				self.owner.movespeedscaler = maps\mp\_utility::lightweightscalar();
			}

			self.owner.maxhealth = 100;
			self.owner maps\mp\gametypes\_weapons::updatemovespeedscale();
			self.owner maps\mp\gametypes\_playerlogic::laststandrespawnplayer();
			self.owner maps\mp\_utility::giveperk("specialty_pistoldeath",0);
			self.owner.beingrevived = 0;
			self delete();
			return;
		}

		self makeusable();
		updateusablebyteam(param_00);
	}
}

//Function Number: 61
useholdthink(param_00)
{
	var_01 = spawn("script_origin",self.origin);
	var_01 hide();
	param_00 playerlinkto(var_01);
	param_00 playerlinkedoffsetenable();
	param_00 common_scripts\utility::_disableweapon();
	self.curprogress = 0;
	self.inuse = 1;
	self.userate = 0;
	self.usetime = 3000;
	param_00 thread personalusebar(self);
	var_02 = useholdthinkloop(param_00);
	if(isdefined(param_00) && maps\mp\_utility::isreallyalive(param_00))
	{
		param_00 unlink();
		param_00 common_scripts\utility::_enableweapon();
	}

	if(isdefined(var_02) && var_02)
	{
		self.owner thread maps\mp\gametypes\_hud_message::playercardsplashnotify("revived",param_00);
		self.owner.inlaststand = 0;
		return 1;
	}

	self.inuse = 0;
	var_01 delete();
	return 0;
}

//Function Number: 62
personalusebar(param_00)
{
	var_01 = maps\mp\gametypes\_hud_util::createprimaryprogressbar();
	var_02 = maps\mp\gametypes\_hud_util::createprimaryprogressbartext();
	var_02 settext(&"MPUI_REVIVING");
	var_03 = param_00.owner maps\mp\gametypes\_hud_util::createprimaryprogressbar();
	var_04 = param_00.owner maps\mp\gametypes\_hud_util::createprimaryprogressbartext();
	var_04 settext(&"MPUI_BEING_REVIVED");
	var_05 = -1;
	while(maps\mp\_utility::isreallyalive(self) && isdefined(param_00) && param_00.inuse && !level.gameended && isdefined(self))
	{
		if(var_05 != param_00.userate)
		{
			if(param_00.curprogress > param_00.usetime)
			{
				param_00.curprogress = param_00.usetime;
			}

			var_01 maps\mp\gametypes\_hud_util::updatebar(param_00.curprogress / param_00.usetime,1000 / param_00.usetime * param_00.userate);
			var_03 maps\mp\gametypes\_hud_util::updatebar(param_00.curprogress / param_00.usetime,1000 / param_00.usetime * param_00.userate);
			if(!param_00.userate)
			{
				var_01 maps\mp\gametypes\_hud_util::hideelem();
				var_02 maps\mp\gametypes\_hud_util::hideelem();
				var_03 maps\mp\gametypes\_hud_util::hideelem();
				var_04 maps\mp\gametypes\_hud_util::hideelem();
			}
			else
			{
				var_01 maps\mp\gametypes\_hud_util::showelem();
				var_02 maps\mp\gametypes\_hud_util::showelem();
				var_03 maps\mp\gametypes\_hud_util::showelem();
				var_04 maps\mp\gametypes\_hud_util::showelem();
			}
		}

		var_05 = param_00.userate;
		wait 0.05;
	}

	if(isdefined(var_01))
	{
		var_01 maps\mp\gametypes\_hud_util::destroyelem();
	}

	if(isdefined(var_02))
	{
		var_02 maps\mp\gametypes\_hud_util::destroyelem();
	}

	if(isdefined(var_03))
	{
		var_03 maps\mp\gametypes\_hud_util::destroyelem();
	}

	if(isdefined(var_04))
	{
		var_04 maps\mp\gametypes\_hud_util::destroyelem();
	}
}

//Function Number: 63
useholdthinkloop(param_00)
{
	level endon("game_ended");
	self.owner endon("death");
	self.owner endon("disconnect");
	while(maps\mp\_utility::isreallyalive(param_00) && param_00 usebuttonpressed() && self.curprogress < self.usetime)
	{
		self.curprogress = self.curprogress + 50 * self.userate;
		self.userate = 1;
		if(self.curprogress >= self.usetime)
		{
			self.inuse = 0;
			return maps\mp\_utility::isreallyalive(param_00);
		}

		wait 0.05;
	}

	return 0;
}

//Function Number: 64
callback_killingblow(param_00,param_01,param_02,param_03,param_04,param_05,param_06,param_07,param_08,param_09)
{
	if(isdefined(self.lastdamagewasfromenemy) && self.lastdamagewasfromenemy && param_02 >= self.health && isdefined(self.combathigh) && self.combathigh == "specialty_endgame")
	{
		maps\mp\_utility::giveperk("specialty_endgame",0);
		return 0;
	}

	return 1;
}

//Function Number: 65
emitfalldamage(param_00)
{
	physicsexplosionsphere(self.origin,64,64,1);
	var_01 = [];
	for(var_02 = 0;var_02 < 360;var_02 = var_02 + 30)
	{
		var_03 = cos(var_02) * 16;
		var_04 = sin(var_02) * 16;
		var_05 = bullettrace(self.origin + (var_03,var_04,4),self.origin + (var_03,var_04,-6),1,self);
		if(isdefined(var_05["entity"]) && isdefined(var_05["entity"].targetname) && var_05["entity"].targetname == "destructible_vehicle" || var_05["entity"].targetname == "destructible_toy")
		{
			var_01[var_01.size] = var_05["entity"];
		}
	}

	if(var_01.size)
	{
		var_06 = spawn("script_origin",self.origin);
		var_06 hide();
		var_06.type = "soft_landing";
		var_06.destructibles = var_01;
		radiusdamage(self.origin,64,100,100,var_06);
		wait 0.1;
		var_06 delete();
	}
}

//Function Number: 66
drawline(param_00,param_01,param_02)
{
	var_03 = int(param_02 * 20);
	for(var_04 = 0;var_04 < var_03;var_04++)
	{
		wait 0.05;
	}
}

//Function Number: 67
isflankkill(param_00,param_01)
{
	var_02 = anglestoforward(param_00.angles);
	var_02 = (var_02[0],var_02[1],0);
	var_02 = vectornormalize(var_02);
	var_03 = param_00.origin - param_01.origin;
	var_03 = (var_03[0],var_03[1],0);
	var_03 = vectornormalize(var_03);
	var_04 = vectordot(var_02,var_03);
	if(var_04 > 0)
	{
		return 1;
	}

	return 0;
}

//Function Number: 68
_obituary(param_00,param_01,param_02,param_03)
{
	var_04 = param_00.team;
	foreach(var_06 in level.players)
	{
		var_07 = var_06.team;
		if(var_07 == "spectator")
		{
			var_06 iprintln(&"MP_OBITUARY_NEUTRAL",param_01.name,param_00.name);
			continue;
		}

		if(var_07 == var_04)
		{
			var_06 iprintln(&"MP_OBITUARY_ENEMY",param_01.name,param_00.name);
			continue;
		}

		var_06 iprintln(&"MP_OBITUARY_FRIENDLY",param_01.name,param_00.name);
	}
}

//Function Number: 69
logprintplayerdeath(param_00,param_01,param_02,param_03,param_04,param_05,param_06)
{
	var_07 = self getentitynumber();
	var_08 = self.name;
	var_09 = self.team;
	var_0A = self.guid;
	if(isplayer(param_01))
	{
		var_0B = param_01.guid;
		var_0C = param_01.name;
		var_0D = param_01.team;
		var_0E = param_01 getentitynumber();
		var_0F = param_01 getxuid() + "(" + var_0C + ")";
	}
	else
	{
		var_0B = "";
		var_0C = "";
		var_0D = "world";
		var_0E = -1;
		var_0F = "none";
	}

	logprint("K;" + var_0A + ";" + var_07 + ";" + var_09 + ";" + var_08 + ";" + var_0B + ";" + var_0E + ";" + var_0D + ";" + var_0C + ";" + param_04 + ";" + param_02 + ";" + param_03 + ";" + param_06 + "\n");
}

//Function Number: 70
destroyonreviveentdeath(param_00)
{
	param_00 waittill("death");
	self destroy();
}

//Function Number: 71
gamemodemodifyplayerdamage(param_00,param_01,param_02,param_03,param_04,param_05,param_06,param_07)
{
	if(isdefined(param_01) && isplayer(param_01) && isalive(param_01))
	{
		if(level.matchrules_damagemultiplier)
		{
			param_02 = param_02 * level.matchrules_damagemultiplier;
		}

		if(level.matchrules_vampirism)
		{
			param_01.health = int(min(float(param_01.maxhealth),float(param_01.health + 20)));
		}
	}

	return param_02;
}