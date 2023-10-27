/*******************************************************************
 * Decompiled By: Bog
 * Decompiled File: maps/mp/gametypes/_damage.gsc
 * Game: Call of Duty: Advanced Warfare
 * Platform: PC
 * Function Count: 98
 * Decompile Time: 1600 ms
 * Timestamp: 10/27/2023 1:50:09 AM
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
	var_00[self.leaving_team]--;
	var_00[self.joining_team]++;
	return var_00[self.joining_team] - var_00[self.leaving_team] < 2;
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

//Function Number: 6
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
		if(isdefined(level.onnormaldeath) && isplayer(param_00) || isagent(param_00) && param_00.team != "spectator")
		{
			[[ level.onnormaldeath ]](self,param_00,param_01);
		}
	}
}

//Function Number: 7
givescoreloss(param_00)
{
	var_01 = int(max(0,maps\mp\gametypes\_gamescore::_getplayerscore(self) - param_00));
	maps\mp\gametypes\_gamescore::_setplayerscore(self,var_01);
}

//Function Number: 8
handlesuicidedeath(param_00,param_01)
{
	self thread [[ level.onxpevent ]]("suicide");
	maps\mp\_utility::incpersstat("suicides",1);
	self.suicides = maps\mp\_utility::getpersstat("suicides");
	if(!maps\mp\_utility::privatematch() && self.suicides == 15)
	{
		thread delayedsuicidekick();
	}

	var_02 = maps\mp\gametypes\_tweakables::gettweakablevalue("game","suicidepointloss");
	givescoreloss(var_02);
	if(param_00 == "MOD_SUICIDE" && param_01 == "none" && isdefined(self.throwinggrenade))
	{
		self.lastgrenadesuicidetime = gettime();
	}

	if(isdefined(level.onsuicidedeath))
	{
		[[ level.onsuicidedeath ]](self);
	}

	if(isdefined(self.friendlydamage))
	{
		self iprintlnbold(&"MP_FRIENDLY_FIRE_WILL_NOT");
	}

	self.pers["suicideSpawnDelay"] = maps\mp\gametypes\_tweakables::gettweakablevalue("game","suicidespawndelay");
}

//Function Number: 9
delayedsuicidekick()
{
	self endon("disconnect");
	level endon("game_ended");
	wait(randomintrange(1,60));
	kick(self getentitynumber());
}

//Function Number: 10
handlefriendlyfiredeath(param_00)
{
	param_00 thread [[ level.onxpevent ]]("teamkill");
	param_00.pers["teamkills"] = param_00.pers["teamkills"] + 1;
	param_00.pers["totalTeamKills"] = param_00.pers["totalTeamKills"] + 1;
	param_00.teamkillsthisround++;
	if(maps\mp\gametypes\_tweakables::gettweakablevalue("team","teamkillpointloss"))
	{
		var_01 = maps\mp\gametypes\_rank::getscoreinfovalue("kill");
		param_00 givescoreloss(var_01);
	}

	var_02 = param_00 maps\mp\gametypes\_playerlogic::teamkilldelay();
	if(var_02 > 0)
	{
		param_00.pers["teamKillPunish"] = 1;
		param_00 maps\mp\_utility::_suicide();
	}

	var_03 = maps\mp\gametypes\_tweakables::gettweakablevalue("team","teamkillkicklimit");
	if(var_03 > 0)
	{
		var_04 = param_00.pers["totalTeamKills"];
		if(var_04 >= var_03)
		{
			thread friendlyfirekick(param_00);
		}
	}
}

//Function Number: 11
friendlyfirekick(param_00)
{
	waittillframeend;
	kick(param_00 getentitynumber(),"EXE_PLAYERKICKED_TEAMKILL");
	level thread maps\mp\gametypes\_gamelogic::updategameevents();
}

//Function Number: 12
handlenormaldeath(param_00,param_01,param_02,param_03,param_04)
{
	param_01 thread maps\mp\_events::killedplayer(param_00,self,param_03,param_04,param_02);
	param_01 killnotification();
	if(param_04 == "MOD_HEAD_SHOT")
	{
		param_01 playlocalsound("mp_headshot_killer");
		self playsound("mp_headshot_killed");
	}

	param_01 thread maps\mp\_events::killedplayerevent(self,param_03,param_04);
	var_05 = param_01.pers["cur_kill_streak"];
	if(isalive(param_01))
	{
		if((maps\mp\_utility::ismeleemod(param_04) && !param_01 maps\mp\_utility::isjuggernaut()) || param_01 maps\mp\_utility::killshouldaddtokillstreak(param_03))
		{
			param_01.pers["cur_kill_streak"]++;
			param_01.killstreakcount = param_01.pers["cur_kill_streak"];
			param_01 notify("kill_streak_increased");
			if(!maps\mp\_utility::iskillstreakweapon(param_03))
			{
				param_01.pers["cur_kill_streak_for_nuke"]++;
			}

			var_06 = 30;
			if(param_01 maps\mp\_utility::_hasperk("specialty_hardline"))
			{
				var_06--;
			}

			if(!maps\mp\_utility::iskillstreakweapon(param_03) && param_01.pers["cur_kill_streak_for_nuke"] == var_06)
			{
				var_07 = param_01 maps\mp\killstreaks\_killstreaks::getnextkillstreakslotindex("nuke",0);
				param_01 thread maps\mp\killstreaks\_killstreaks::givekillstreak("nuke",0,1,param_01);
				param_01 thread maps\mp\gametypes\_hud_message::killstreaksplashnotify("nuke",var_06,undefined,undefined,var_07);
			}
		}

		param_01 maps\mp\_utility::setplayerstatifgreater("longestkillstreak",param_01.pers["cur_kill_streak"]);
		if(param_01.pers["cur_kill_streak"] > param_01 maps\mp\_utility::getpersstat("longestStreak"))
		{
			param_01 maps\mp\_utility::setpersstat("longestStreak",param_01.pers["cur_kill_streak"]);
		}
	}

	param_01.pers["cur_death_streak"] = 0;
	if(param_01.pers["cur_kill_streak"] > param_01 maps\mp\gametypes\_persistence::statgetchild("round","killStreak"))
	{
		param_01 maps\mp\gametypes\_persistence::statsetchild("round","killStreak",param_01.pers["cur_kill_streak"]);
	}

	if(param_01 maps\mp\_utility::rankingenabled())
	{
		if(param_01.pers["cur_kill_streak"] > param_01.kill_streak)
		{
			param_01 maps\mp\gametypes\_persistence::statset("killStreak",param_01.pers["cur_kill_streak"]);
			param_01.kill_streak = param_01.pers["cur_kill_streak"];
		}
	}

	var_08 = maps\mp\gametypes\_tweakables::gettweakablevalue("game","deathpointloss");
	givescoreloss(var_08);
	level notify("player_got_killstreak_" + param_01.pers["cur_kill_streak"],param_01);
	param_01 notify("got_killstreak",param_01.pers["cur_kill_streak"]);
	param_01 notify("killed_enemy");
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
		if(gettime() - self.lastattackedshieldtime < 5000)
		{
			self.lastattackedshieldplayer thread maps\mp\_events::processassistevent(self,"assist_riot_shield");
		}
	}

	if(!maps\mp\_utility::iskillstreakweapon(param_03))
	{
		if(isdefined(self.is_being_tracked) && self.is_being_tracked && isdefined(self.trackedbyplayer))
		{
			if(self.trackedbyplayer != param_01)
			{
				self.trackedbyplayer thread maps\mp\killstreaks\_marking_util::playerprocesstaggedassist(self);
			}
		}

		var_09 = [];
		foreach(var_0B in level.uavmodels[param_01.team])
		{
			if(!isdefined(var_0B.owner) || var_0B.owner == param_01)
			{
				continue;
			}

			if(common_scripts\utility::array_contains(var_09,var_0B.owner))
			{
				continue;
			}

			var_09[var_09.size] = var_0B.owner;
			if(var_0B.assistpoints)
			{
				var_0B.owner thread maps\mp\_events::processassistevent(self,"assist_uav_plus");
			}
			else
			{
				var_0B.owner thread maps\mp\_events::processassistevent(self,"assist_uav");
			}

			var_0B.owner thread maps\mp\gametypes\_missions::processchallenge("ch_streak_uav");
		}
	}

	if(isdefined(self.tagmarkedby))
	{
		self.tagmarkedby = undefined;
	}

	if((level.teambased && level.teamemped[self.team]) || !level.teambased && isdefined(level.empplayer) && level.empplayer != self)
	{
		if(isdefined(level.empowner) && level.empassistpoints && level.empowner != param_01)
		{
			level.empowner thread maps\mp\_events::processassistevent(self,"assist_emp");
		}
	}

	if(isdefined(self.attackers))
	{
		foreach(var_0E in self.attackers)
		{
			if(!isdefined(maps\mp\_utility::_validateattacker(var_0E)))
			{
				continue;
			}

			if(var_0E == param_01)
			{
				continue;
			}

			if(self == var_0E)
			{
				continue;
			}

			var_0E thread maps\mp\_events::processassistevent(self);
		}

		self.attackers = [];
	}
}

//Function Number: 13
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

//Function Number: 14
callback_playerkilled(param_00,param_01,param_02,param_03,param_04,param_05,param_06,param_07,param_08)
{
	playerkilled_internal(param_00,param_01,self,param_02,param_03,param_04,param_05,param_06,param_07,param_08,0);
}

//Function Number: 15
callback_playergrenadesuicide(param_00,param_01,param_02,param_03,param_04,param_05,param_06,param_07)
{
	if(isdefined(level.ishorde) && level.ishorde)
	{
		var_08 = 0;
		if(level.players.size > 1)
		{
			var_08 = 1;
		}
		else if(self.hasselfrevive)
		{
			var_08 = 1;
		}

		if(var_08)
		{
			param_00 laststanddie();
		}

		[[ level.callbackplayerlaststand ]](param_00,param_01,param_02,param_03,param_04,param_05,param_06,param_07,0);
	}
}

//Function Number: 16
callback_entityoutofworld()
{
	self delete();
}

//Function Number: 17
launchshield(param_00,param_01)
{
	self refreshshieldmodels();
	maps\mp\_riotshield::riotshield_clear();
}

//Function Number: 18
playerkilled_internal(param_00,param_01,param_02,param_03,param_04,param_05,param_06,param_07,param_08,param_09,param_0A)
{
	param_02 endon("spawned");
	param_02 notify("killed_player");
	if(isdefined(param_01) && isplayer(param_01) && isdefined(param_01.exo_ping_on) && param_01.exo_ping_on == 1)
	{
		param_01 maps\mp\gametypes\_missions::processchallenge("ch_exoability_ping");
	}

	if(isdefined(param_02.prekilledfunc))
	{
		param_02 [[ param_02.prekilledfunc ]](param_00,param_01,param_02,param_03,param_04,param_05,param_06,param_07,param_08,param_09,param_0A);
	}

	param_02 maps\mp\gametypes\_playerlogic::resetuidvarsondeath();
	param_02.abilitychosen = 0;
	param_02.perkoutlined = 0;
	param_02.sensoroutlined = 0;
	param_01 = maps\mp\_utility::_validateattacker(param_01);
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
		else if(param_04 == "MOD_GRENADE")
		{
			if((issubstr(param_05,"frag_grenade") || issubstr(param_05,"thermobaric_grenade")) && param_03 == 100000)
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
	}

	if(param_02 maps\mp\_riotshield::hasriotshieldequipped())
	{
		param_02 launchshield(param_03,param_04);
	}

	var_0B = maps\mp\_utility::ismeleemod(param_04) && issubstr(param_05,"knife") || issubstr(param_05,"tactical");
	var_0B = var_0B || param_05 == maps\mp\_grappling_hook::get_grappling_hook_weapon();
	if(var_0B)
	{
		if(isdefined(common_scripts\utility::getfx("exo_knife_blood")))
		{
			if(isdefined(param_07) && isdefined(param_06) && isdefined(gethitloctag(param_07)))
			{
				playimpactheadfatalfx(param_02 gettagorigin(gethitloctag(param_07)),param_06);
			}
			else
			{
				playimpactheadfatalfx(param_02 gettagorigin("j_neck"),anglestoforward(param_02 gettagangles("j_neck")));
			}
		}
	}

	maps\mp\gametypes\_weapons::recordtogglescopestates();
	if(!param_0A)
	{
		if(isdefined(param_02.endgame))
		{
			maps\mp\_utility::revertvisionsetforplayer(2);
		}
		else
		{
			maps\mp\_utility::revertvisionsetforplayer(0);
			param_02 thermalvisionoff();
		}
	}
	else
	{
		param_02.fauxdead = 1;
		self notify("death",param_01,param_04,param_05);
	}

	if(game["state"] == "postgame")
	{
		return;
	}

	var_0C = 0;
	if(!isplayer(param_00) && isdefined(param_00.primaryweapon))
	{
		var_0D = param_00.primaryweapon;
	}
	else if(isdefined(param_02) && isplayer(param_02) && param_02 getcurrentprimaryweapon() != "none")
	{
		var_0D = param_02 getcurrentprimaryweapon();
	}
	else if(issubstr(param_06,"alt_"))
	{
		var_0D = getsubstr(param_06,4,param_06.size);
	}
	else
	{
		var_0D = undefined;
	}

	if(isdefined(param_02.uselaststandparams) || isdefined(param_02.laststandparams) && param_04 == "MOD_SUICIDE")
	{
		param_02 ensurelaststandparamsvalidity();
		param_02.uselaststandparams = undefined;
		param_00 = param_02.laststandparams.einflictor;
		param_01 = maps\mp\_utility::_validateattacker(param_02.laststandparams.attacker);
		param_03 = param_02.laststandparams.idamage;
		param_04 = param_02.laststandparams.smeansofdeath;
		param_05 = param_02.laststandparams.sweapon;
		var_0D = param_02.laststandparams.sprimaryweapon;
		param_06 = param_02.laststandparams.vdir;
		param_07 = param_02.laststandparams.shitloc;
		var_0C = gettime() - param_02.laststandparams.laststandstarttime / 1000;
		param_02.laststandparams = undefined;
	}

	if((!isdefined(param_01) || param_01.classname == "trigger_hurt" || param_01.classname == "worldspawn" || param_01.classname == "script_model" && isdefined(param_01.isenvironmentweapon) && param_01.isenvironmentweapon == 1 || param_01 == param_02) && isdefined(self.attackers))
	{
		var_0E = undefined;
		foreach(var_10 in self.attackers)
		{
			if(!isdefined(maps\mp\_utility::_validateattacker(var_10)))
			{
				continue;
			}

			if(!isdefined(param_02.attackerdata[var_10.guid].damage))
			{
				continue;
			}

			if(var_10 == param_02 || level.teambased && var_10.team == param_02.team)
			{
				continue;
			}

			if(param_02.attackerdata[var_10.guid].lasttimedamaged + 2500 < gettime() && param_01 != param_02 && isdefined(param_02.laststand) && param_02.laststand)
			{
				continue;
			}

			if(param_02.attackerdata[var_10.guid].damage > 1 && !isdefined(var_0E))
			{
				var_0E = var_10;
				continue;
			}

			if(isdefined(var_0E) && param_02.attackerdata[var_10.guid].damage > param_02.attackerdata[var_0E.guid].damage)
			{
				var_0E = var_10;
			}
		}

		if(isdefined(var_0E))
		{
			param_01 = var_0E;
			param_01.assistedsuicide = 1;
			param_05 = param_02.attackerdata[var_0E.guid].weapon;
			param_06 = param_02.attackerdata[var_0E.guid].vdir;
			param_07 = param_02.attackerdata[var_0E.guid].shitloc;
			param_08 = param_02.attackerdata[var_0E.guid].psoffsettime;
			param_04 = param_02.attackerdata[var_0E.guid].smeansofdeath;
			param_03 = param_02.attackerdata[var_0E.guid].damage;
			var_0D = param_02.attackerdata[var_0E.guid].sprimaryweapon;
			param_00 = param_01;
		}
	}
	else if(isdefined(param_01))
	{
		param_01.assistedsuicide = undefined;
	}

	if(maps\mp\_utility::isheadshot(param_05,param_07,param_04,param_01))
	{
		param_04 = "MOD_HEAD_SHOT";
	}
	else if(!maps\mp\_utility::ismeleemod(param_04) && !isdefined(param_02.nuked))
	{
		param_02 maps\mp\_utility::playdeathsound();
	}

	var_12 = isfriendlyfire(param_02,param_01);
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

		if(isagent(param_01) && isdefined(param_01.owner))
		{
			param_01 = param_01.owner;
			param_05 = "agent_mp";
			param_04 = "MOD_RIFLE_BULLET";
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

	if(param_04 != "MOD_SUICIDE" && maps\mp\_utility::isaigameparticipant(param_02) || maps\mp\_utility::isaigameparticipant(param_01) && isdefined(level.bot_funcs) && isdefined(level.bot_funcs["get_attacker_ent"]))
	{
		var_13 = [[ level.bot_funcs["get_attacker_ent"] ]](param_01,param_00);
		if(isdefined(var_13))
		{
			if(maps\mp\_utility::isaigameparticipant(param_02))
			{
				param_02 botmemoryevent("death",param_05,var_13.origin,param_02.origin,var_13);
			}

			if(maps\mp\_utility::isaigameparticipant(param_01))
			{
				var_14 = 1;
				if((var_13.classname == "script_vehicle" && isdefined(var_13.helitype)) || var_13.classname == "rocket" || var_13.classname == "misc_turret")
				{
					var_14 = 0;
				}

				if(var_14)
				{
					param_01 botmemoryevent("kill",param_05,var_13.origin,param_02.origin,param_02);
				}
			}
		}
	}

	var_15 = param_02 getcurrentweapon();
	param_02 thread maps\mp\gametypes\_weapons::dropscavengerfordeath(param_01);
	if(!isdefined(param_02.agentbody))
	{
		param_02 thread [[ level.weapondropfunction ]](param_01,param_04);
	}
	else
	{
		param_02.agentbody thread [[ level.weapondropfunction ]](param_01,param_04);
	}

	if(!param_0A)
	{
		param_02 maps\mp\_utility::updatesessionstate("dead");
	}

	var_16 = isdefined(param_02.fauxdead) && param_02.fauxdead && isdefined(param_02.switching_teams) && param_02.switching_teams;
	if(!var_16)
	{
		param_02 maps\mp\gametypes\_playerlogic::removefromalivecount();
	}

	if(!isdefined(param_02.switching_teams) && !isdefined(level.iszombiegame) && level.iszombiegame)
	{
		var_17 = param_02;
		if(isdefined(param_02.commanding_bot))
		{
			var_17 = param_02.commanding_bot;
		}

		var_17 maps\mp\_utility::incpersstat("deaths",1);
		var_17.deaths = var_17 maps\mp\_utility::getpersstat("deaths");
		var_17 maps\mp\_utility::updatepersratio("kdRatio","kills","deaths");
		var_17 maps\mp\gametypes\_persistence::statsetchild("round","deaths",var_17.deaths);
		var_17 maps\mp\_utility::incplayerstat("deaths",1);
	}

	if(!maps\mp\_utility::practiceroundgame())
	{
		obituary(param_02,param_01,param_05,param_04);
	}

	var_18 = 0;
	param_02 logprintplayerdeath(self.lifeid,param_01,param_03,param_04,param_05,var_0D,param_07);
	param_02 maps\mp\_matchdata::logplayerlife(1);
	param_02 maps\mp\_matchdata::logplayerdeath(self.lifeid,param_01,param_03,param_04,param_05,var_0D,param_07,var_15);
	if(maps\mp\_utility::ismeleemod(param_04) && isplayer(param_01) && !issubstr(param_05,"riotshield"))
	{
		param_01 maps\mp\_utility::incplayerstat("knifekills",1);
	}

	if(param_02 isswitchingteams())
	{
		handleteamchangedeath();
	}
	else if(!isplayer(param_01) || isplayer(param_01) && param_04 == "MOD_FALLING")
	{
		handleworlddeath(param_01,self.lifeid,param_04,param_07);
		if(isagent(param_01))
		{
			var_18 = 1;
		}

		if(maps\mp\gametypes\_killcam::isworldkillcam(param_00,param_01))
		{
			var_18 = 1;
		}
	}
	else if(param_01 == param_02 && isdefined(param_00) && !isdefined(param_00.isorbitalcam) || param_00.isorbitalcam == 0)
	{
		handlesuicidedeath(param_04,param_07);
	}
	else if(var_12)
	{
		if(!isdefined(param_02.nuked) && !isdefined(level.iszombiegame) || !level.iszombiegame)
		{
			handlefriendlyfiredeath(param_01);
		}
	}
	else
	{
		if((param_04 == "MOD_GRENADE" && param_00 == param_01) || param_04 == "MOD_IMPACT" || param_04 == "MOD_GRENADE_SPLASH" || param_04 == "MOD_EXPLOSIVE")
		{
			addattacker(param_02,param_01,param_00,param_05,param_03,(0,0,0),param_06,param_07,param_08,param_04);
		}

		var_18 = 1;
		if(isai(param_02) && isdefined(level.bot_funcs) && isdefined(level.bot_funcs["should_do_killcam"]))
		{
			var_18 = param_02 [[ level.bot_funcs["should_do_killcam"] ]]();
		}

		if(isdefined(param_00) && !isdefined(param_00.isorbitalcam) || param_00.isorbitalcam == 0)
		{
			handlenormaldeath(self.lifeid,param_01,param_00,param_05,param_04);
			param_02 thread maps\mp\gametypes\_missions::playerkilled(param_00,param_01,param_03,param_04,param_05,var_0D,param_07,param_01.modifiers);
		}

		param_02.pers["cur_death_streak"]++;
		if(isplayer(param_01) && param_02 maps\mp\_utility::isjuggernaut())
		{
			param_01 thread maps\mp\_utility::teamplayercardsplash("callout_killed_juggernaut",param_01);
		}
	}

	var_19 = 0;
	var_1A = undefined;
	if(isdefined(self.previousprimary))
	{
		var_19 = 1;
		var_1A = self.previousprimary;
		self.previousprimary = undefined;
	}

	if(isplayer(param_01) && param_01 != self && !level.teambased || level.teambased && self.team != param_01.team)
	{
		if(var_19 && isdefined(var_1A))
		{
			var_1B = var_1A;
		}
		else
		{
			var_1B = self.lastdroppableweapon;
		}

		thread maps\mp\gametypes\_gamelogic::trackleaderboarddeathstats(var_1B,param_04);
		param_01 thread maps\mp\gametypes\_gamelogic::trackattackerleaderboarddeathstats(param_05,param_04,param_00);
	}

	param_02.wasswitchingteamsforonplayerkilled = undefined;
	if(isdefined(param_02.switching_teams))
	{
		param_02.wasswitchingteamsforonplayerkilled = 1;
	}

	param_02 resetplayervariables();
	param_02.lastattacker = param_01;
	param_02.lastinflictor = param_00;
	if(!isdefined(param_02.agentbody))
	{
		param_02.lastdeathpos = param_02.origin;
	}
	else
	{
		param_02.lastdeathpos = param_02.agentbody.origin;
	}

	param_02.deathtime = gettime();
	param_02.wantsafespawn = 0;
	param_02.revived = 0;
	param_02.sameshotdamage = 0;
	param_02 maps\mp\killstreaks\_killstreaks::resetadrenaline(0);
	var_1C = maps\mp\_awards::gettotalscore(param_02) - param_02.scoreatlifestart;
	param_02 maps\mp\_utility::setplayerstatifgreater("mostScorePerLife",var_1C);
	var_1D = undefined;
	if(maps\mp\_utility::isrocketcorpse())
	{
		var_18 = 1;
		param_0A = 0;
		var_1D = self.killcament;
		self waittill("final_rocket_corpse_death");
	}
	else
	{
		if(param_0A)
		{
			var_18 = 0;
			if(!isdefined(param_02.agentbody))
			{
				param_09 = param_02 playerforcedeathanim(param_00,param_04,param_05,param_07,param_06);
			}
		}

		if(isdefined(param_02.hideondeath) && param_02.hideondeath)
		{
			param_02 playerhide();
			thread maps\mp\gametypes\_deathicons::adddeathicon(param_02,param_02,param_02.team,5,param_01);
		}
		else if(!isdefined(param_02.agentbody))
		{
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
				thread maps\mp\gametypes\_deathicons::adddeathicon(param_02.body,param_02,param_02.team,5,param_01);
			}

			thread delaystartragdoll(param_02.body,param_07,param_06,param_05,param_00,param_04);
		}
		else if(!isdefined(param_02.switching_teams))
		{
			thread maps\mp\gametypes\_deathicons::adddeathicon(param_02.agentbody,param_02,param_02.team,5,param_01);
		}
	}

	param_02 thread [[ level.onplayerkilled ]](param_00,param_01,param_03,param_04,param_05,param_06,param_07,param_08,param_09,self.lifeid);
	if(isai(param_02) && isdefined(level.bot_funcs) && isdefined(level.bot_funcs["on_killed"]))
	{
		param_02 thread [[ level.bot_funcs["on_killed"] ]](param_00,param_01,param_03,param_04,param_05,param_06,param_07,param_08,param_09,self.lifeid);
	}

	if(maps\mp\_utility::isgameparticipant(param_01))
	{
		var_1E = param_01 getentitynumber();
	}
	else
	{
		var_1E = -1;
	}

	if(isdefined(level.iszombiegame) && level.iszombiegame)
	{
		var_1E = -1;
	}

	if(!isdefined(var_1D) && isdefined(param_01))
	{
		var_1D = param_02 getkillcamentity(param_01,param_00,param_05);
	}

	var_1F = -1;
	var_20 = 0;
	var_21 = 0;
	if(isdefined(var_1D))
	{
		var_1F = var_1D getentitynumber();
		var_20 = var_1D.birthtime;
		if(isdefined(var_1D.killcamstarttime))
		{
			var_20 = var_1D.killcamstarttime;
			var_21 = 1;
		}

		if(!isdefined(var_20))
		{
			var_20 = 0;
		}
	}
	else if(param_05 == "orbital_laser_fov_mp" && isdefined(param_00) && isdefined(param_00.killcamstarttime))
	{
		var_20 = param_00.killcamstarttime;
		var_21 = 1;
	}

	if(isdefined(param_01) && isdefined(param_01.lastspawntime))
	{
		var_22 = gettime() - param_01.lastspawntime / 1000;
	}
	else
	{
		var_22 = 0;
	}

	if(param_04 != "MOD_SUICIDE" && !!isdefined(param_01) || param_01.classname == "trigger_hurt" || param_01.classname == "worldspawn" || param_01 == param_02)
	{
		recordfinalkillcam(5,param_02,param_01,var_1E,var_1F,var_20,param_05,var_0C,param_08,param_04,"normal",var_21);
	}

	if(maps\mp\gametypes\_killcam::killcamvalid(param_02,var_18))
	{
		var_23 = maps\mp\gametypes\_playerlogic::timeuntilspawn(1);
		var_24 = maps\mp\gametypes\_gamelogic::timeuntilroundend();
		var_25 = maps\mp\gametypes\_killcam::killcamtime(var_20,param_05,0,var_23,var_24,var_21,0);
		var_26 = maps\mp\gametypes\_killcam::killcamarchivetime(var_25,var_22,var_0C,param_08 / 1000);
		param_02 maps\mp\gametypes\_killcam::prekillcamnotify(param_00,param_01,var_26,var_15);
	}
	else if(maps\mp\_utility::isvalidclass(param_02.class))
	{
		param_02 maps\mp\gametypes\_playerlogic::streamclassweapons();
	}

	var_27 = gettime() + 5000;
	if(!param_0A)
	{
		wait(0.25);
		param_02 thread maps\mp\gametypes\_killcam::cancelkillcamonuse();
		wait(0.25);
		self.respawntimerstarttime = gettime() + 1000;
		var_23 = maps\mp\gametypes\_playerlogic::timeuntilspawn(1);
		if(var_23 < 1)
		{
			var_23 = 1;
		}

		wait(1);
		if(isdefined(self.streamweapons) && self.streamweapons.size > 0)
		{
			while(maps\mp\gametypes\_killcam::killcamvalid(param_02,var_18) && isplayer(self) && isplayer(param_01) && !self hasloadedcustomizationplayerview(param_01,self.streamweapons) && gettime() < var_27)
			{
				wait 0.05;
			}
		}

		param_02 notify("death_delay_finished");
	}

	var_28 = gettime() - param_02.deathtime / 1000;
	self.respawntimerstarttime = gettime();
	var_29 = gettime() >= var_27;
	if(maps\mp\gametypes\_killcam::killcamvalid(param_02,var_18) && !var_29)
	{
		var_2A = !maps\mp\_utility::getgametypenumlives() && !param_02.pers["lives"];
		var_23 = maps\mp\gametypes\_playerlogic::timeuntilspawn(1);
		var_2B = var_2A && var_23 <= 0;
		if(!var_2A)
		{
			var_23 = -1;
			level notify("player_eliminated",param_02);
		}

		param_02 maps\mp\gametypes\_killcam::killcam(param_00,var_1E,var_1F,var_20,param_05,var_28 + var_0C,param_08,var_23,maps\mp\gametypes\_gamelogic::timeuntilroundend(),param_01,param_02,param_04,"normal",var_22,var_21);
	}

	if(game["state"] != "playing")
	{
		if(!level.showingfinalkillcam)
		{
			param_02 maps\mp\_utility::updatesessionstate("dead");
			param_02 maps\mp\_utility::clearkillcamstate();
		}

		return;
	}

	var_2C = maps\mp\_utility::getgametypenumlives();
	var_2D = self.pers["lives"];
	if(self == param_02 && isdefined(param_02.battlebuddy) && maps\mp\_utility::isreallyalive(param_02.battlebuddy) && !maps\mp\_utility::getgametypenumlives() || self.pers["lives"] && !param_02 maps\mp\_utility::isusingremote())
	{
		maps\mp\gametypes\_battlebuddy::waitforplayerrespawnchoice();
	}

	if(maps\mp\_utility::isvalidclass(param_02.class))
	{
		param_02 thread maps\mp\gametypes\_playerlogic::spawnclient();
	}
}

//Function Number: 19
waittimerforspawn()
{
	self endon("randomSpawnPressed");
	self.kc_teamspawntext settext(&"PLATFORM_PRESS_TO_TEAMSPAWN");
	self.kc_teamspawntext.alpha = 1;
	self.kc_randomspawntext settext(&"PLATFORM_PRESS_TO_RESPAWN");
	self.kc_randomspawntext.alpha = 1;
	thread waitteamspawnbutton();
	thread waitspawnrandombutton();
	if(isdefined(self.skippedkillcam) && self.skippedkillcam)
	{
		var_00 = 8;
	}
	else
	{
		var_00 = 9;
	}

	if(isdefined(self.timestartedtowait))
	{
		var_01 = int(ceil(var_00 - gettime() - self.timestartedtowait / 1000));
	}
	else
	{
		var_01 = var_01;
	}

	self.partnerspawning = 0;
	wait(0.5);
	for(var_02 = var_01;var_02 > 0;var_02--)
	{
		maps\mp\_utility::setlowermessage("kc_info",&"MP_TIME_TILL_SPAWN",var_01,1,1);
		wait(1);
	}

	self.kc_randomspawntext.alpha = 0;
	self.kc_teamspawntext.alpha = 0;
	maps\mp\_utility::clearlowermessage("kc_info");
	self notify("abort_fireteam_spawn");
}

//Function Number: 20
waitspawnrandombutton()
{
	self endon("disconnect");
	self endon("abort_fireteam_spawn");
	while(self usebuttonpressed())
	{
		wait(0.05);
	}

	while(!self usebuttonpressed())
	{
		wait(0.05);
		if(!maps\mp\_utility::isreallyalive(self.partner))
		{
			break;
		}
	}

	self.partnerspawning = 0;
	self notify("randomSpawnPressed");
	self.kc_randomspawntext.alpha = 0;
	self.kc_teamspawntext.alpha = 0;
	maps\mp\_utility::clearlowermessage("kc_info");
	self notify("abort_fireteam_spawn");
}

//Function Number: 21
waitteamspawnbutton()
{
	self endon("disconnect");
	self endon("abort_fireteam_spawn");
	while(self attackbuttonpressed())
	{
		wait(0.05);
	}

	while(!self attackbuttonpressed())
	{
		wait(0.05);
	}

	self.partnerspawning = 1;
	self playlocalsound("copycat_steal_class");
	self notify("teamSpawnPressed");
	self.kc_randomspawntext.alpha = 0;
	self.kc_teamspawntext.alpha = 0;
}

//Function Number: 22
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

//Function Number: 23
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
	level.finalkillcam_smeansofdeath = [];
	level.finalkillcam_type = [];
	level.finalkillcam_usestarttime = [];
	if(level.multiteambased)
	{
		foreach(var_01 in level.teamnamelist)
		{
			level.finalkillcam_delay[var_01] = undefined;
			level.finalkillcam_victim[var_01] = undefined;
			level.finalkillcam_attacker[var_01] = undefined;
			level.finalkillcam_attackernum[var_01] = undefined;
			level.finalkillcam_killcamentityindex[var_01] = undefined;
			level.finalkillcam_killcamentitystarttime[var_01] = undefined;
			level.finalkillcam_sweapon[var_01] = undefined;
			level.finalkillcam_deathtimeoffset[var_01] = undefined;
			level.finalkillcam_psoffsettime[var_01] = undefined;
			level.finalkillcam_timerecorded[var_01] = undefined;
			level.finalkillcam_timegameended[var_01] = undefined;
			level.finalkillcam_smeansofdeath[var_01] = undefined;
			level.finalkillcam_type[var_01] = undefined;
			level.finalkillcam_usestarttime[var_01] = undefined;
		}
	}
	else
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
		level.finalkillcam_smeansofdeath["axis"] = undefined;
		level.finalkillcam_type["axis"] = undefined;
		level.finalkillcam_usestarttime["axis"] = undefined;
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
		level.finalkillcam_smeansofdeath["allies"] = undefined;
		level.finalkillcam_type["allies"] = undefined;
		level.finalkillcam_usestarttime["allies"] = undefined;
	}

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
	level.finalkillcam_smeansofdeath["none"] = undefined;
	level.finalkillcam_type["none"] = undefined;
	level.finalkillcam_usestarttime["none"] = undefined;
	level.finalkillcam_winner = undefined;
}

//Function Number: 24
recordfinalkillcam(param_00,param_01,param_02,param_03,param_04,param_05,param_06,param_07,param_08,param_09,param_0A,param_0B)
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
		level.finalkillcam_smeansofdeath[param_02.team] = param_09;
		level.finalkillcam_type[param_02.team] = param_0A;
		level.finalkillcam_usestarttime[param_02.team] = isdefined(param_0B) && param_0B;
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
	level.finalkillcam_timegameended["none"] = maps\mp\_utility::getsecondspassed();
	level.finalkillcam_smeansofdeath["none"] = param_09;
	level.finalkillcam_type["none"] = param_0A;
	level.finalkillcam_usestarttime["none"] = isdefined(param_0B) && param_0B;
}

//Function Number: 25
erasefinalkillcam()
{
	if(level.multiteambased)
	{
		for(var_00 = 0;var_00 < level.teamnamelist.size;var_00++)
		{
			level.finalkillcam_delay[level.teamnamelist[var_00]] = undefined;
			level.finalkillcam_victim[level.teamnamelist[var_00]] = undefined;
			level.finalkillcam_attacker[level.teamnamelist[var_00]] = undefined;
			level.finalkillcam_attackernum[level.teamnamelist[var_00]] = undefined;
			level.finalkillcam_killcamentityindex[level.teamnamelist[var_00]] = undefined;
			level.finalkillcam_killcamentitystarttime[level.teamnamelist[var_00]] = undefined;
			level.finalkillcam_sweapon[level.teamnamelist[var_00]] = undefined;
			level.finalkillcam_deathtimeoffset[level.teamnamelist[var_00]] = undefined;
			level.finalkillcam_psoffsettime[level.teamnamelist[var_00]] = undefined;
			level.finalkillcam_timerecorded[level.teamnamelist[var_00]] = undefined;
			level.finalkillcam_timegameended[level.teamnamelist[var_00]] = undefined;
			level.finalkillcam_smeansofdeath[level.teamnamelist[var_00]] = undefined;
			level.finalkillcam_type[level.teamnamelist[var_00]] = undefined;
			level.finalkillcam_usestarttime[level.teamnamelist[var_00]] = undefined;
		}
	}
	else
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
		level.finalkillcam_smeansofdeath["axis"] = undefined;
		level.finalkillcam_type["axis"] = undefined;
		level.finalkillcam_usestarttime["axis"] = undefined;
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
		level.finalkillcam_smeansofdeath["allies"] = undefined;
		level.finalkillcam_type["allies"] = undefined;
		level.finalkillcam_usestarttime["allies"] = undefined;
	}

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
	level.finalkillcam_smeansofdeath["none"] = undefined;
	level.finalkillcam_type["none"] = undefined;
	level.finalkillcam_usestarttime["none"] = undefined;
	level.finalkillcam_winner = undefined;
}

//Function Number: 26
streamfinalkillcam()
{
	if(isai(self))
	{
		return;
	}

	var_00 = "none";
	if(isdefined(level.finalkillcam_winner))
	{
		var_00 = level.finalkillcam_winner;
	}

	var_01 = level.finalkillcam_victim[var_00];
	var_02 = level.finalkillcam_attacker[var_00];
	var_03 = level.finalkillcam_timegameended[var_00];
	var_04 = level.finalkillcam_timerecorded[var_00];
	if(!finalkillcamvalid(var_01,var_02,var_03,var_04))
	{
		return;
	}

	var_05 = level.finalkillcam_killcamentitystarttime[var_00];
	var_06 = level.finalkillcam_sweapon[var_00];
	var_07 = level.finalkillcam_usestarttime[var_00];
	var_08 = level.finalkillcam_psoffsettime[var_00];
	var_09 = level.finalkillcam_deathtimeoffset[var_00];
	var_0A = gettime() - var_01.deathtime / 1000;
	var_0B = var_0A + var_09;
	var_0C = maps\mp\gametypes\_killcam::killcamtime(var_05,var_06,var_0B,0,getkillcambuffertime(),var_07,1);
	var_0D = var_0C + var_0B + var_08 / 1000;
	self onlystreamactiveweapon(1);
	thread maps\mp\gametypes\_killcam::prekillcamnotify(level.finalkillcam_attacker[var_00],level.finalkillcam_attacker[var_00],var_0D,"none");
}

//Function Number: 27
streamcheck(param_00)
{
	level endon("stream_end");
	foreach(var_02 in level.players)
	{
		if(isai(var_02))
		{
			continue;
		}

		if(isdefined(var_02.streamweapons) && var_02.streamweapons.size > 0)
		{
			while(isplayer(var_02) && isplayer(param_00) && !var_02 hasloadedcustomizationplayerview(param_00,var_02.streamweapons[0]))
			{
				wait 0.05;
			}
		}
	}

	level notify("stream_end");
}

//Function Number: 28
resetonlystreamactive()
{
	foreach(var_01 in level.players)
	{
		if(!isai(var_01))
		{
			var_01 onlystreamactiveweapon(0);
		}
	}
}

//Function Number: 29
streamtimeout(param_00)
{
	level endon("stream_end");
	wait(param_00);
	level notify("stream_end");
}

//Function Number: 30
waitforstream(param_00)
{
	thread streamtimeout(5);
	streamcheck(param_00);
}

//Function Number: 31
getkillcambuffertime()
{
	return 15;
}

//Function Number: 32
finalkillcamvalid(param_00,param_01,param_02,param_03)
{
	var_04 = isdefined(param_00) && isdefined(param_01) && !maps\mp\_utility::practiceroundgame();
	if(var_04)
	{
		var_05 = getkillcambuffertime();
		var_06 = param_02 - param_03;
		if(var_06 <= var_05)
		{
			return 1;
		}
	}

	return 0;
}

//Function Number: 33
endfinalkillcam()
{
	resetonlystreamactive();
	level.showingfinalkillcam = 0;
	level notify("final_killcam_done");
}

//Function Number: 34
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
	var_07 = level.finalkillcam_usestarttime[var_00];
	var_08 = level.finalkillcam_sweapon[var_00];
	var_09 = level.finalkillcam_deathtimeoffset[var_00];
	var_0A = level.finalkillcam_psoffsettime[var_00];
	var_0B = level.finalkillcam_timerecorded[var_00];
	var_0C = level.finalkillcam_timegameended[var_00];
	var_0D = level.finalkillcam_smeansofdeath[var_00];
	var_0E = level.finalkillcam_type[var_00];
	if(!finalkillcamvalid(var_02,var_03,var_0C,var_0B))
	{
		endfinalkillcam();
		return;
	}

	if(isdefined(var_03))
	{
		var_03.finalkill = 1;
		if(level.gametype == "conf" && isdefined(level.finalkillcam_attacker[var_03.team]) && level.finalkillcam_attacker[var_03.team] == var_03)
		{
			var_03 maps\mp\gametypes\_missions::processchallenge("ch_theedge");
			if(isdefined(var_03.modifiers["revenge"]))
			{
				var_03 maps\mp\gametypes\_missions::processchallenge("ch_moneyshot");
			}

			if(isdefined(var_03.infinalstand) && var_03.infinalstand)
			{
				var_03 maps\mp\gametypes\_missions::processchallenge("ch_lastresort");
			}

			if(isdefined(var_02) && isdefined(var_02.explosiveinfo) && isdefined(var_02.explosiveinfo["stickKill"]) && var_02.explosiveinfo["stickKill"])
			{
				var_03 maps\mp\gametypes\_missions::processchallenge("ch_stickman");
			}

			if(isdefined(var_02.attackerdata[var_03.guid]) && isdefined(var_02.attackerdata[var_03.guid].smeansofdeath) && isdefined(var_02.attackerdata[var_03.guid].weapon) && issubstr(var_02.attackerdata[var_03.guid].smeansofdeath,"MOD_MELEE") && issubstr(var_02.attackerdata[var_03.guid].weapon,"riotshield_mp"))
			{
				var_03 maps\mp\gametypes\_missions::processchallenge("ch_owned");
			}

			switch(level.finalkillcam_sweapon[var_03.team])
			{
				case "artillery_mp":
					break;

				case "stealth_bomb_mp":
					break;

				case "sentry_minigun_mp":
					break;

				case "ac130_40mm_mp":
				case "ac130_105mm_mp":
				case "ac130_25mm_mp":
					break;

				case "remotemissile_projectile_mp":
					break;

				default:
					break;
			}
		}
	}
}

//Function Number: 35
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

//Function Number: 36
resetplayervariables()
{
	self.killedplayerscurrent = [];
	self.switching_teams = undefined;
	self.joining_team = undefined;
	self.leaving_team = undefined;
	self.pers["cur_kill_streak"] = 0;
	self.pers["cur_kill_streak_for_nuke"] = 0;
	self.killstreakcount = 0;
	maps\mp\gametypes\_gameobjects::detachusemodels();
}

//Function Number: 37
getkillcamentity(param_00,param_01,param_02)
{
	if(isdefined(param_00.didturretexplosion) && param_00.didturretexplosion && isdefined(param_00.turret))
	{
		param_00.didturretexplosion = undefined;
		return param_00.turret.killcament;
	}

	switch(param_02)
	{
		case "boost_slam_mp":
			break;

		case "iw5_dlcgun12loot6_mp":
		case "remotemissile_projectile_cluster_child_mp":
		case "orbital_carepackage_pod_plane_mp":
		case "refraction_turret_mp":
		case "agent_mp":
		case "stealth_bomb_mp":
		case "artillery_mp":
		case "orbital_carepackage_droppod_mp":
		case "orbital_carepackage_pod_mp":
		case "explosive_drone_mp":
		case "bouncingbetty_mp":
		case "bomb_site_mp":
			break;

		case "killstreak_laser2_mp":
			break;

		case "ball_drone_projectile_mp":
		case "ball_drone_gun_mp":
			break;

		case "drone_assault_remote_turret_mp":
		case "ugv_missile_mp":
			break;

		case "assaultdrone_c4_mp":
			break;

		case "warbird_missile_mp":
		case "dam_turret_mp":
		case "killstreak_solar_mp":
			break;

		case "warbird_remote_turret_mp":
			break;

		case "orbital_laser_fov_mp":
			break;

		case "killstreakmahem_mp":
		case "remote_energy_turret_mp":
		case "sentry_minigun_mp":
			break;

		case "none":
			break;

		case "killstreak_terrace_mp":
		case "detroit_tram_turret_mp":
		case "remote_turret_mp":
		case "ugv_turret_mp":
		case "ac130_40mm_mp":
		case "ac130_105mm_mp":
		case "ac130_25mm_mp":
			break;

		case "iw5_dlcgun12loot8_mp":
			break;
	}
}

//Function Number: 38
attackerinremotekillstreak()
{
	if(!isdefined(self))
	{
		return 0;
	}

	if(isdefined(level.chopper) && isdefined(level.chopper.gunner) && self == level.chopper.gunner)
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

//Function Number: 39
hitlocdebug(param_00,param_01,param_02,param_03,param_04)
{
	var_05 = [];
	var_05[0] = 2;
	var_05[1] = 3;
	var_05[2] = 5;
	var_05[3] = 7;
	if(!getdvarint("scr_hitloc_debug"))
	{
		return;
	}

	if(!isdefined(param_00.hitlocinited))
	{
		for(var_06 = 0;var_06 < 6;var_06++)
		{
			param_00 setclientdvar("ui_hitloc_" + var_06,"");
		}

		param_00.hitlocinited = 1;
	}

	if(level.splitscreen || !isplayer(param_00))
	{
		return;
	}

	var_07 = 6;
	if(!isdefined(param_00.damageinfo))
	{
		param_00.damageinfo = [];
		for(var_06 = 0;var_06 < var_07;var_06++)
		{
			param_00.damageinfo[var_06] = spawnstruct();
			param_00.damageinfo[var_06].damage = 0;
			param_00.damageinfo[var_06].hitloc = "";
			param_00.damageinfo[var_06].bp = 0;
			param_00.damageinfo[var_06].jugg = 0;
			param_00.damageinfo[var_06].colorindex = 0;
		}

		param_00.damageinfocolorindex = 0;
		param_00.damageinfovictim = undefined;
	}

	for(var_06 = var_07 - 1;var_06 > 0;var_06--)
	{
		param_00.damageinfo[var_06].damage = param_00.damageinfo[var_06 - 1].damage;
		param_00.damageinfo[var_06].hitloc = param_00.damageinfo[var_06 - 1].hitloc;
		param_00.damageinfo[var_06].bp = param_00.damageinfo[var_06 - 1].bp;
		param_00.damageinfo[var_06].jugg = param_00.damageinfo[var_06 - 1].jugg;
		param_00.damageinfo[var_06].colorindex = param_00.damageinfo[var_06 - 1].colorindex;
	}

	param_00.damageinfo[0].damage = param_02;
	param_00.damageinfo[0].hitloc = param_03;
	param_00.damageinfo[0].bp = param_04 & level.idflags_penetration;
	param_00.damageinfo[0].jugg = param_01 maps\mp\_utility::isjuggernaut();
	if(isdefined(param_00.damageinfovictim) && param_00.damageinfovictim != param_01)
	{
		param_00.damageinfocolorindex++;
		if(param_00.damageinfocolorindex == var_05.size)
		{
			param_00.damageinfocolorindex = 0;
		}
	}

	param_00.damageinfovictim = param_01;
	param_00.damageinfo[0].colorindex = param_00.damageinfocolorindex;
	for(var_06 = 0;var_06 < var_07;var_06++)
	{
		var_08 = "^" + var_05[param_00.damageinfo[var_06].colorindex];
		if(param_00.damageinfo[var_06].hitloc != "")
		{
			var_09 = var_08 + param_00.damageinfo[var_06].hitloc;
			if(param_00.damageinfo[var_06].bp)
			{
				var_09 = var_09 + " (BP)";
			}

			if(param_00.damageinfo[var_06].jugg)
			{
				var_09 = var_09 + " (Jugg)";
			}

			param_00 setclientdvar("ui_hitloc_" + var_06,var_09);
		}

		param_00 setclientdvar("ui_hitloc_damage_" + var_06,var_08 + param_00.damageinfo[var_06].damage);
	}
}

//Function Number: 40
ishardwrireprotected(param_00)
{
	if(!maps\mp\_utility::_hasperk("specialty_stun_resistance"))
	{
		return 0;
	}

	switch(param_00)
	{
		case "mp_lab_gas":
		case "killstreak_strike_missile_gas_mp":
			break;
	}
}

//Function Number: 41
callback_playerdamage_internal(param_00,param_01,param_02,param_03,param_04,param_05,param_06,param_07,param_08,param_09,param_0A)
{
	if(getdvarint("virtuallobbyactive",0))
	{
		return "virtuallobbyactive";
	}

	param_01 = maps\mp\_utility::_validateattacker(param_01);
	var_0B = maps\mp\_utility::strip_suffix(param_06,"_lefthand");
	if(isdefined(param_05) && param_05 == "MOD_CRUSH" && isdefined(param_00) && isdefined(param_00.classname) && param_00.classname == "script_vehicle")
	{
		return "crushed";
	}

	if(!maps\mp\_utility::isreallyalive(param_02) && !isdefined(param_02.inliveplayerkillstreak))
	{
		return "!isReallyAlive( victim )";
	}

	if(isdefined(param_01) && param_01.classname == "script_origin" && isdefined(param_01.type) && param_01.type == "soft_landing")
	{
		return "soft_landing";
	}

	if(param_06 == "killstreak_emp_mp")
	{
		return "sWeapon == killstreak_emp_mp";
	}

	if(param_02 ishardwrireprotected(param_06))
	{
		return "specialty_stun_resistance";
	}

	if((var_0B == "emp_grenade_mp" || var_0B == "emp_grenade_var_mp" || var_0B == "emp_grenade_killstreak_mp") && param_05 != "MOD_IMPACT")
	{
		param_02 notify("emp_grenaded",param_01);
	}

	if(isdefined(level.hostmigrationtimer))
	{
		return "level.hostMigrationTimer";
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

	if(isdefined(param_01) && param_01 == param_02 && param_06 == "killstreak_strike_missile_gas_mp")
	{
		return "gasCloudOwner";
	}

	if(isdefined(param_01) && isplayer(param_01) && isexplosivedamagemod(param_05) && issubstr(param_06,"explosive_drone") && param_02 maps\mp\_utility::_hasperk("_specialty_blastshield") && maps\mp\_utility::isreallyalive(param_02))
	{
		param_02.explosive_drone_owner = param_01;
	}

	var_0C = maps\mp\_utility::attackerishittingteam(param_02,param_01);
	var_0D = isdefined(param_01) && isdefined(param_00) && isdefined(param_02) && isplayer(param_01) && param_01 == param_00 && param_01 == param_02 && !isdefined(param_00.poison);
	if(var_0D)
	{
		return "attackerIsInflictorVictim";
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
			return "attackerIsHittingTeammate";
		}

		if(param_05 == "MOD_PISTOL_BULLET" || param_05 == "MOD_RIFLE_BULLET" || param_05 == "MOD_EXPLOSIVE_BULLET" && !var_0C)
		{
			if(isplayer(param_01))
			{
				param_01.lastattackedshieldplayer = param_02;
				param_01.lastattackedshieldtime = gettime();
			}

			if(maps\mp\_utility::isenvironmentweapon(param_06))
			{
				var_10 = 25;
			}
			else
			{
				var_10 = maps\mp\perks\_perks::cac_modified_damage(param_03,param_02,param_04,param_06,param_07,param_08,param_09,param_0A);
			}

			param_02.shielddamage = param_02.shielddamage + var_10;
			if(!maps\mp\_utility::isenvironmentweapon(param_06) || common_scripts\utility::cointoss())
			{
				param_02.shieldbullethits++;
				if(isdefined(param_02.pers["bulletsBlockedByShield"]))
				{
					param_02.pers["bulletsBlockedByShield"]++;
				}
			}

			if(param_02.shieldbullethits >= level.riotshieldxpbullets)
			{
				param_02.shielddamage = 0;
				param_02.shieldbullethits = 0;
			}
		}

		if(param_04 & level.idflags_shield_explosive_impact)
		{
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
				param_03 = 51;
			}

			param_09 = "none";
		}
		else
		{
			return "hit shield";
		}
	}
	else if(maps\mp\_utility::ismeleemod(param_05) && issubstr(param_06,"riotshield"))
	{
		if(!var_0C && level.friendlyfire == 0)
		{
			var_0E = 0;
			param_02 stunplayer(0);
		}
	}

	if(!var_0C)
	{
		param_03 = maps\mp\perks\_perks::cac_modified_damage(param_02,param_01,param_03,param_05,param_06,param_07,param_08,param_09,param_00);
	}

	if(isdefined(level.modifyplayerdamage))
	{
		param_03 = [[ level.modifyplayerdamage ]](param_02,param_00,param_01,param_03,param_05,param_06,param_07,param_08,param_09);
	}

	if(param_02 maps\mp\_utility::isjuggernaut() && !isagent(param_02))
	{
		if(isdefined(level.customjuggernautdamagefunc))
		{
			param_03 = [[ level.customjuggernautdamagefunc ]](param_02,param_01,param_03,param_05,param_06,param_07,param_08,param_09,param_00);
		}
		else
		{
			param_03 = maps\mp\killstreaks\_juggernaut::juggernautmodifydamage(param_02,param_01,param_03,param_05,param_06,param_07,param_08,param_09,param_00);
		}
	}

	var_11 = isdefined(param_01) && !isdefined(param_01.gunner) && param_01.classname == "script_vehicle" || param_01.classname == "misc_turret" || param_01.classname == "script_model";
	var_0C = maps\mp\_utility::attackerishittingteam(param_02,param_01);
	if(!param_03)
	{
		return "!iDamage";
	}

	param_02.idflags = param_04;
	param_02.idflagstime = gettime();
	if(game["state"] == "postgame")
	{
		return "game[ state ] == postgame";
	}

	if(param_02.sessionteam == "spectator")
	{
		return "victim.sessionteam == spectator";
	}

	if(isdefined(param_02.candocombat) && !param_02.candocombat)
	{
		return "!victim.canDoCombat";
	}

	if(isdefined(param_01) && isplayer(param_01) && isdefined(param_01.candocombat) && !param_01.candocombat)
	{
		return "!eAttacker.canDoCombat";
	}

	if(isdefined(param_01) && isalive(param_01) && !isdefined(param_01.perkoutlined))
	{
		param_01.perkoutlined = 0;
	}

	if(var_11 && var_0C)
	{
		if(param_05 == "MOD_CRUSH")
		{
			param_02 maps\mp\_utility::_suicide();
			return "suicide crush";
		}

		if(!level.friendlyfire)
		{
			return "!level.friendlyfire";
		}
	}

	if(isai(self))
	{
		self [[ level.bot_funcs["on_damaged"] ]](param_01,param_03,param_05,param_06,param_00,param_09);
	}

	if(!isdefined(param_08))
	{
		param_04 = param_04 | level.idflags_no_knockback;
	}

	var_12 = 0;
	if((param_02.health == param_02.maxhealth && !isdefined(param_02.laststand) || !param_02.laststand) || !isdefined(param_02.attackers) && !isdefined(param_02.laststand))
	{
		param_02.attackers = [];
		param_02.attackerdata = [];
	}

	if(maps\mp\_utility::isheadshot(param_06,param_09,param_05,param_01))
	{
		param_05 = "MOD_HEAD_SHOT";
	}

	if(maps\mp\gametypes\_tweakables::gettweakablevalue("game","onlyheadshots"))
	{
		if(param_05 == "MOD_PISTOL_BULLET" || param_05 == "MOD_RIFLE_BULLET" || param_05 == "MOD_EXPLOSIVE_BULLET")
		{
			return "getTweakableValue( game, onlyheadshots )";
		}
		else if(param_05 == "MOD_HEAD_SHOT")
		{
			if(param_02 maps\mp\_utility::isjuggernaut())
			{
				param_03 = 75;
			}
			else
			{
				param_03 = 150;
			}
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
		var_13 = int(max(param_02.health / 4,1));
		if(param_03 >= var_13 && maps\mp\_utility::iskillstreakweapon(param_06) && !maps\mp\_utility::ismeleemod(param_05))
		{
			param_03 = var_13;
		}
	}

	if(!param_04 & level.idflags_no_protection)
	{
		if(!level.teambased && var_11 && isdefined(param_01.owner) && param_01.owner == param_02)
		{
			if(param_05 == "MOD_CRUSH")
			{
				param_02 maps\mp\_utility::_suicide();
			}

			return "ffa suicide";
		}

		if((issubstr(param_05,"MOD_GRENADE") || issubstr(param_05,"MOD_EXPLOSIVE") || issubstr(param_05,"MOD_PROJECTILE")) && isdefined(param_00) && isdefined(param_01))
		{
			if(param_02 != param_01 && param_00.classname == "grenade" && param_02.lastspawntime + 3500 > gettime() && isdefined(param_02.lastspawnpoint) && distance(param_00.origin,param_02.lastspawnpoint.origin) < 250)
			{
				return "spawnkill grenade protection";
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
			var_14 = issubstr(param_06,"frag_");
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

				if(isdefined(param_01.lastgrenadesuicidetime) && param_01.lastgrenadesuicidetime >= gettime() - 50 && var_14)
				{
					param_02.explosiveinfo["suicideGrenadeKill"] = 1;
				}
			}

			if(var_14)
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

		if(issubstr(param_05,"MOD_IMPACT") && param_06 == "m320_mp" || issubstr(param_06,"gl") || issubstr(param_06,"gp25"))
		{
			if(isplayer(param_01) && param_01 != self)
			{
				maps\mp\gametypes\_gamelogic::setinflictorstat(param_00,param_01,param_06);
			}
		}

		if(var_0C)
		{
			if(level.friendlyfire == 0 || !isplayer(param_01) && level.friendlyfire != 1)
			{
				if(param_06 == "artillery_mp" || param_06 == "stealth_bomb_mp")
				{
					param_02 damageshellshockandrumble(param_00,param_06,param_05,param_03,param_04,param_01);
				}

				return "friendly fire";
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

			var_12 = 1;
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

			if(isdefined(param_01) && !isplayer(param_01) && isdefined(param_01.owner) && !isdefined(param_01.scrambled) || !param_01.scrambled)
			{
				addattacker(param_02,param_01.owner,param_00,param_06,param_03,param_07,param_08,param_09,param_0A,param_05);
			}
			else if(isdefined(param_01) && !isplayer(param_01) && isdefined(param_01.secondowner) && isdefined(param_01.scrambled) && param_01.scrambled)
			{
				addattacker(param_02,param_01.secondowner,param_00,param_06,param_03,param_07,param_08,param_09,param_0A,param_05);
			}

			if(param_05 == "MOD_EXPLOSIVE" || param_05 == "MOD_GRENADE_SPLASH" && param_03 < param_02.health)
			{
				param_02 notify("survived_explosion",param_01);
			}

			if(isdefined(param_01) && isplayer(param_01) && isdefined(param_06))
			{
				param_01 thread maps\mp\gametypes\_weapons::checkhit(param_06,param_02);
			}

			param_02.attackerposition = undefined;
			if(isdefined(param_01) && isplayer(param_01) && isdefined(param_06) && param_01 != param_02)
			{
				param_02.attackerposition = param_01.origin;
			}

			if(issubstr(param_05,"MOD_GRENADE") && isdefined(param_00) && isdefined(param_00.iscooked))
			{
				param_02.wascooked = gettime();
			}
			else
			{
				param_02.wascooked = undefined;
			}

			if(issubstr(param_05,"MOD_IMPACT") && isdefined(param_00) && isdefined(param_00.recall) && param_00.recall)
			{
				param_02.wasrecall = 1;
			}
			else
			{
				param_02.wasrecall = 0;
			}

			param_02.lastdamagewasfromenemy = isdefined(param_01) && param_01 != param_02;
			if(param_02.lastdamagewasfromenemy)
			{
				var_15 = gettime();
				param_01.damagedplayers[param_02.guid] = var_15;
				param_02.lastdamagedtime = var_15;
			}

			param_02 finishplayerdamagewrapper(param_00,param_01,param_03,param_04,param_05,param_06,param_07,param_08,param_09,param_0A,var_0E);
			param_02 thread maps\mp\gametypes\_missions::playerdamaged(param_00,param_01,param_03,param_05,param_06,param_09);
		}

		if(param_03 > 0 && param_05 != "MOD_FALLING")
		{
			param_02 setclientomnvar("ui_damage_flash",1);
		}

		if(var_11 && isdefined(param_01.gunner))
		{
			var_16 = param_01.gunner;
		}
		else
		{
			var_16 = param_02;
		}

		if(isdefined(var_16) && var_16 != param_02 || maps\mp\_utility::iskillstreakweapon(param_06) && param_03 > 0 && !isdefined(param_09) || param_09 != "shield")
		{
			if(!maps\mp\_utility::isreallyalive(param_02))
			{
				if(param_09 == "head")
				{
					var_17 = "killshot_headshot";
				}
				else
				{
					var_17 = "killshot";
				}
			}
			else if(param_05 & level.idflags_stun)
			{
				var_17 = "stun";
			}
			else if(param_0A == "head")
			{
				var_17 = "headshot";
			}
			else if(isdefined(param_03.exo_health_on) && param_03.exo_health_on == 1)
			{
				var_17 = "hitmorehealth";
			}
			else if(isexplosivedamagemod(param_06) && param_03 maps\mp\_utility::_hasperk("_specialty_blastshield"))
			{
				var_17 = "hitblastshield";
			}
			else if(isdefined(param_03.lightarmorhp) && param_06 != "MOD_HEAD_SHOT" && !maps\mp\_utility::isfmjdamage(param_07,param_06,param_02))
			{
				var_17 = "hitlightarmor";
			}
			else if(param_03 maps\mp\_utility::isjuggernaut())
			{
				var_17 = "hitjuggernaut";
			}
			else if(!shouldweaponfeedback(param_07))
			{
				var_17 = "none";
			}
			else if(param_07 == "killstreak_solar_mp")
			{
				var_17 = "mp_solar";
			}
			else if(param_07 == "killstreak_laser2_mp")
			{
				var_17 = "laser";
			}
			else if(isdefined(param_03.exo_health_on) && param_03.exo_health_on)
			{
				var_17 = "hitjuggernaut";
			}
			else
			{
				var_17 = "standard";
			}

			var_16 thread maps\mp\gametypes\_damagefeedback::updatedamagefeedback(var_17);
		}

		maps\mp\gametypes\_gamelogic::sethasdonecombat(param_02,1);
	}

	if(isdefined(param_01) && param_01 != param_02 && !var_12)
	{
		level.usestartspawns = 0;
	}

	if(param_02.sessionstate != "dead")
	{
		var_18 = param_02 getentitynumber();
		var_19 = param_02.name;
		var_1A = param_02.pers["team"];
		var_1B = param_02.guid;
		var_1C = "";
		if(isplayer(param_01))
		{
			var_1D = param_01 getentitynumber();
			var_1E = param_01.guid;
			var_1F = param_01.name;
			var_1C = param_01.pers["team"];
		}
		else
		{
			var_1D = -1;
			var_1E = "";
			var_1F = "";
			var_1C = "world";
		}

		if(isplayer(param_01))
		{
			var_20 = param_01.name;
			var_21 = param_01.origin;
			var_22 = param_01.lifeid;
		}
		else
		{
			var_20 = "world";
			var_21 = param_04.origin;
			var_22 = -1;
		}

		var_23 = gettime();
		if(!isagent(param_02) && isdefined(param_02.spawninfo) && isdefined(param_02.spawninfo.spawntime))
		{
			var_24 = var_23 - param_02.spawninfo.spawntime / 1000;
			if(var_24 <= 3 && param_02.spawninfo.damagereceivedtoofast == 0)
			{
				if(!isdefined(level.matchdata))
				{
					level.matchdata = [];
				}

				if(!isdefined(level.matchdata["badSpawnDmgReceivedCount"]))
				{
					level.matchdata["badSpawnDmgReceivedCount"] = 1;
				}
				else
				{
					level.matchdata["badSpawnDmgReceivedCount"]++;
				}

				param_02.spawninfo.damagereceivedtoofast = 1;
				if(param_02.spawninfo.badspawn == 0)
				{
					if(!isdefined(level.matchdata["badSpawnByAnyMeansCount"]))
					{
						level.matchdata["badSpawnByAnyMeansCount"] = 1;
					}
					else
					{
						level.matchdata["badSpawnByAnyMeansCount"]++;
					}

					param_02.spawninfo.badspawn = 1;
				}
			}
		}
		else
		{
			var_24 = -1;
		}

		if(isdefined(param_01) && isdefined(param_01.spawninfo) && isdefined(param_01.spawninfo.spawntime) && isplayer(param_01))
		{
			var_25 = var_23 - param_01.spawninfo.spawntime / 1000;
			if(var_25 <= 3 && param_01.spawninfo.damagedealttoofast == 0)
			{
				if(!isdefined(level.matchdata))
				{
					level.matchdata = [];
				}

				if(!isdefined(level.matchdata["badSpawnDmgDealtCount"]))
				{
					level.matchdata["badSpawnDmgDealtCount"] = 1;
				}
				else
				{
					level.matchdata["badSpawnDmgDealtCount"]++;
				}

				param_01.spawninfo.damagedealttoofast = 1;
				if(param_01.spawninfo.badspawn == 0)
				{
					if(!isdefined(level.matchdata["badSpawnByAnyMeansCount"]))
					{
						level.matchdata["badSpawnByAnyMeansCount"] = 1;
					}
					else
					{
						level.matchdata["badSpawnByAnyMeansCount"]++;
					}

					param_01.spawninfo.badspawn = 1;
				}
			}
		}
		else
		{
			var_25 = -1;
		}

		if(!isagent(param_02))
		{
			reconspatialevent(param_02.origin,"script_mp_damage: player_name %s, player_angles %v, hit_loc %s, attacker_name %s, attacker_pos %v, damage %d, weapon %s, damage_type %s, gameTime %d, life_id %d, attacker_life_id %d, spawnToDamageReceivedTime %f, spawnToDamageDealtTime %f",param_02.name,param_02.angles,param_09,var_20,var_21,param_03,param_06,param_05,var_23,param_02.lifeid,var_22,var_24,var_25);
		}

		logprint("D;" + var_1B + ";" + var_18 + ";" + var_1A + ";" + var_19 + ";" + var_1E + ";" + var_1D + ";" + var_1C + ";" + var_1F + ";" + param_06 + ";" + param_03 + ";" + param_05 + ";" + param_09 + "\n");
	}

	hitlocdebug(param_01,param_02,param_03,param_09,param_04);
	if(isagent(self))
	{
		self [[ maps\mp\agents\_agent_utility::agentfunc("on_damaged_finished") ]](param_00,param_01,param_03,param_04,param_05,param_06,param_07,param_08,param_09,param_0A);
	}

	return "finished";
}

//Function Number: 42
shouldweaponfeedback(param_00)
{
	switch(param_00)
	{
		case "stealth_bomb_mp":
		case "artillery_mp":
			break;
	}
}

//Function Number: 43
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
	}
	else if(isdefined(param_01) && isplayer(param_01) && param_01 getcurrentprimaryweapon() != "none")
	{
		param_00.attackerdata[param_01.guid].sprimaryweapon = param_01 getcurrentprimaryweapon();
	}
	else
	{
		param_00.attackerdata[param_01.guid].sprimaryweapon = undefined;
	}

	if(!isdefined(param_00.enemyhitcounts))
	{
		param_00.enemyhitcounts = [];
	}

	if(isplayer(param_01))
	{
		if(!isdefined(param_00.enemyhitcounts[param_01.guid]))
		{
			param_00.enemyhitcounts[param_01.guid] = 0;
		}

		param_00.enemyhitcounts[param_01.guid]++;
		param_00.lastshotby = param_01.clientid;
	}
}

//Function Number: 44
resetattackerlist()
{
	self endon("disconnect");
	self endon("death");
	level endon("game_ended");
	clearfirefightdata();
	wait(1.75);
	self.attackers = [];
	self.attackerdata = [];
}

//Function Number: 45
clearfirefightdata()
{
	self.enemyhitcounts = [];
	self.currentfirefightshots = 0;
}

//Function Number: 46
clearfirefightshotsoninterval()
{
	self endon("disconnect");
	self endon("death");
	level endon("game_ended");
	for(;;)
	{
		wait(3);
		if(isdefined(self.enemyhitcounts) && self.enemyhitcounts.size > 0)
		{
			continue;
		}
		else
		{
			self.currentfirefightshots = 0;
		}
	}
}

//Function Number: 47
is_countered_by_hardwired(param_00)
{
	switch(param_00)
	{
		case "paint_grenade_var_mp":
		case "emp_grenade_var_mp":
		case "stun_grenade_var_mp":
		case "emp_grenade_mp":
		case "paint_grenade_mp":
		case "stun_grenade_mp":
			break;
	}
}

//Function Number: 48
callback_playerdamage(param_00,param_01,param_02,param_03,param_04,param_05,param_06,param_07,param_08,param_09)
{
	var_0A = callback_playerdamage_internal(param_00,param_01,self,param_02,param_03,param_04,param_05,param_06,param_07,param_08,param_09);
}

//Function Number: 49
finishplayerdamagewrapper(param_00,param_01,param_02,param_03,param_04,param_05,param_06,param_07,param_08,param_09,param_0A)
{
	var_0B = 0;
	if(maps\mp\_utility::isusingremote() && param_02 >= self.health && !param_03 & level.idflags_stun && !isdefined(self.inliveplayerkillstreak) && !self isgod())
	{
		var_0B = 1;
	}

	if(isdefined(level.ishorde) && level.ishorde)
	{
		var_0B = 0;
	}

	if(var_0B || maps\mp\_utility::isrocketcorpse())
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

		if(isplayer(self))
		{
			var_0C = shouldplayblastimpact(param_03,param_04,param_05);
			var_0D = self finishplayerdamage(param_00,param_01,param_02,param_03,param_04,param_05,param_06,param_07,param_08,param_09,param_0A,var_0C);
			if(isdefined(var_0D))
			{
				thread finishplayerdamage_impactfxwrapper(var_0D[0],var_0D[1],var_0D[2],var_0D[3],var_0D[4],var_0D[5],var_0D[6]);
			}
		}
	}

	if(param_04 == "MOD_EXPLOSIVE_BULLET")
	{
		self shellshock("damage_mp",getdvarfloat("scr_csmode"));
	}

	damageshellshockandrumble(param_00,param_05,param_04,param_02,param_03,param_01);
}

//Function Number: 50
shouldplayblastimpact(param_00,param_01,param_02)
{
	if(param_00 & level.idflags_radius && isexplosivedamagemod(param_01))
	{
		if(is_countered_by_hardwired(param_02))
		{
			if(!maps\mp\_utility::_hasperk("specialty_class_hardwired"))
			{
				return 1;
			}
		}
		else if(!maps\mp\_utility::_hasperk("specialty_hard_shell"))
		{
			return 1;
		}
	}

	return 0;
}

//Function Number: 51
finishplayerdamage_impactfxwrapper(param_00,param_01,param_02,param_03,param_04,param_05,param_06)
{
	waittillframeend;
	if(!isdefined(self) || !isdefined(param_00))
	{
		return;
	}

	self finishplayerdamage_impactfx(param_00,param_01,param_02,param_03,param_04,param_05,param_06);
}

//Function Number: 52
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

	if(level.diehardmode)
	{
		if(level.teamcount[self.team] <= 1)
		{
			var_0A = 0;
		}
		else if(maps\mp\_utility::isteaminlaststand())
		{
			var_0A = 0;
			maps\mp\_utility::killteaminlaststand(self.team);
		}
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
		var_0B.iconname = level.specialty_finalstand_icon;
	}
	else
	{
		var_0B.titletext = game["strings"]["last_stand"];
		var_0B.iconname = level.specialty_finalstand_icon;
	}

	var_0B.glowcolor = (1,0,0);
	var_0B.sound = "mp_last_stand";
	var_0B.duration = 2;
	self.health = 1;
	thread maps\mp\gametypes\_hud_message::notifymessage(var_0B);
	var_0C = "frag_grenade_mp";
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

	if(level.diehardmode)
	{
		param_01 thread maps\mp\_events::killedplayerevent(self,param_04,param_03);
		self.laststandparams = var_09;
		common_scripts\utility::_disableweapon();
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
		var_11 = "iw6_p226_mp";
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

//Function Number: 53
dieaftertime(param_00)
{
	self endon("death");
	self endon("disconnect");
	self endon("joined_team");
	level endon("game_ended");
	wait(param_00);
	self.uselaststandparams = 1;
	maps\mp\_utility::_suicide();
}

//Function Number: 54
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

//Function Number: 55
detonateondeath()
{
	self endon("detonate");
	self endon("disconnect");
	self endon("joined_team");
	level endon("game_ended");
	self waittill("death");
	c4deathdetonate();
}

//Function Number: 56
c4deathdetonate()
{
	self playsound("detpack_explo_default");
	self.c4deatheffect = playfx(level.c4death,self.origin);
	radiusdamage(self.origin,312,100,100,self);
	if(isalive(self))
	{
		maps\mp\_utility::_suicide();
	}
}

//Function Number: 57
enablelaststandweapons()
{
	self endon("death");
	self endon("disconnect");
	level endon("game_ended");
	maps\mp\_utility::freezecontrolswrapper(1);
	wait(0.3);
	maps\mp\_utility::freezecontrolswrapper(0);
}

//Function Number: 58
laststandtimer(param_00,param_01)
{
	self endon("death");
	self endon("disconnect");
	self endon("revive");
	level endon("game_ended");
	level notify("player_last_stand");
	thread laststandwaittilldeath();
	self.laststand = 1;
	if(!param_01 && !isdefined(self.inc4death) || !self.inc4death)
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
			wait(param_00);
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
			wait(param_00);
			if(self.infinalstand)
			{
				thread laststandbleedout(param_01,var_02);
			}
		}

		wait(param_00 / 3);
		var_03.color = (1,0.64,0);
		while(var_02.inuse)
		{
			wait(0.05);
		}

		maps\mp\_utility::playdeathsound();
		wait(param_00 / 3);
		var_03.color = (1,0,0);
		while(var_02.inuse)
		{
			wait(0.05);
		}

		maps\mp\_utility::playdeathsound();
		wait(param_00 / 3);
		while(var_02.inuse)
		{
			wait(0.05);
		}

		wait(0.05);
		thread laststandbleedout(param_01);
		return;
	}

	thread laststandkeepoverlay();
	wait(var_02);
	thread laststandbleedout(var_03);
}

//Function Number: 59
maxhealthoverlay(param_00,param_01)
{
	self endon("stop_maxHealthOverlay");
	self endon("revive");
	self endon("death");
	for(;;)
	{
		self.health = self.health - 1;
		self.maxhealth = param_00;
		wait(0.05);
		self.maxhealth = 50;
		self.health = self.health + 1;
		wait(0.5);
	}
}

//Function Number: 60
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

//Function Number: 61
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
				wait(0.05);
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

		wait(0.05);
	}

	thread laststandbleedout(0);
}

//Function Number: 62
laststandkeepoverlay()
{
	level endon("game_ended");
	self endon("death");
	self endon("disconnect");
	self endon("revive");
	while(!level.gameended)
	{
		self.health = 2;
		wait(0.05);
		self.health = 1;
		wait(0.5);
	}

	self.health = self.maxhealth;
}

//Function Number: 63
laststandwaittilldeath()
{
	self endon("disconnect");
	self endon("revive");
	level endon("game_ended");
	self waittill("death");
	maps\mp\_utility::clearlowermessage("last_stand");
	self.laststand = undefined;
}

//Function Number: 64
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

	if(param_01 == "MOD_IMPACT" && param_00 == "throwingknife_mp" || param_00 == "throwingknifejugg_mp")
	{
		return 0;
	}

	if(param_01 == "MOD_IMPACT" && param_00 == "m79_mp" || issubstr(param_00,"gl_"))
	{
		return 0;
	}

	if(maps\mp\_utility::isheadshot(param_00,param_02,param_01))
	{
		return 0;
	}

	if(maps\mp\_utility::isusingremote())
	{
		return 0;
	}

	return 1;
}

//Function Number: 65
ensurelaststandparamsvalidity()
{
	if(!isdefined(self.laststandparams.attacker))
	{
		self.laststandparams.attacker = self;
	}
}

//Function Number: 66
gethitlocheight(param_00)
{
	switch(param_00)
	{
		case "neck":
		case "helmet":
		case "head":
			break;

		case "left_hand":
		case "right_hand":
		case "left_arm_lower":
		case "right_arm_lower":
		case "left_arm_upper":
		case "right_arm_upper":
		case "torso_upper":
		case "gun":
			break;

		case "torso_lower":
			break;

		case "left_leg_upper":
		case "right_leg_upper":
			break;

		case "left_leg_lower":
		case "right_leg_lower":
			break;

		case "left_foot":
		case "right_foot":
			break;
	}
}

//Function Number: 67
gethitloctag(param_00)
{
	switch(param_00)
	{
		case "helmet":
			break;

		case "head":
			break;

		case "neck":
			break;

		case "torso_upper":
			break;

		case "right_arm_upper":
			break;

		case "left_arm_upper":
			break;

		case "right_arm_lower":
			break;

		case "left_arm_lower":
			break;

		case "right_hand":
			break;

		case "left_hand":
			break;

		case "gun":
			break;

		case "torso_lower":
			break;

		case "right_leg_upper":
			break;

		case "left_leg_upper":
			break;

		case "right_leg_lower":
			break;

		case "left_leg_lower":
			break;

		case "right_foot":
			break;

		case "left_foot":
			break;
	}
}

//Function Number: 68
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

	wait(0.2);
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
	wait(var_0C);
	if(isdefined(param_00))
	{
		param_00 startragdoll();
	}
}

//Function Number: 69
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

//Function Number: 70
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

//Function Number: 71
damageshellshockandrumble(param_00,param_01,param_02,param_03,param_04,param_05)
{
	thread maps\mp\gametypes\_weapons::onweapondamage(param_00,param_01,param_02,param_03,param_05);
	self playrumbleonentity("sniper_fire");
}

//Function Number: 72
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

//Function Number: 73
deleteonreviveordeathordisconnect()
{
	self endon("death");
	self.owner common_scripts\utility::waittill_any("death","disconnect");
	self delete();
}

//Function Number: 74
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

//Function Number: 75
trackteamchanges(param_00)
{
	self endon("death");
	for(;;)
	{
		level waittill("joined_team");
		updateusablebyteam(param_00);
	}
}

//Function Number: 76
tracklaststandchanges(param_00)
{
	self endon("death");
	for(;;)
	{
		level waittill("player_last_stand");
		updateusablebyteam(param_00);
	}
}

//Function Number: 77
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
		var_02 = reviveholdthink(var_01);
		self.owner.beingrevived = 0;
		if(!isalive(self.owner))
		{
			self delete();
			return;
		}

		self.owner maps\mp\_utility::freezecontrolswrapper(0);
		if(var_02)
		{
			level thread maps\mp\gametypes\_rank::awardgameevent("reviver",var_01);
			self.owner.laststand = undefined;
			self.owner maps\mp\_utility::clearlowermessage("last_stand");
			self.owner.movespeedscaler = level.baseplayermovescale;
			if(self.owner maps\mp\_utility::_hasperk("specialty_lightweight"))
			{
				self.owner.movespeedscaler = maps\mp\_utility::lightweightscalar();
			}

			self.owner common_scripts\utility::_enableweapon();
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

//Function Number: 78
reviveholdthink(param_00,param_01,param_02)
{
	var_03 = 3000;
	var_04 = spawn("script_origin",self.origin);
	var_04 hide();
	if(isplayer(param_00))
	{
		param_00 playerlinkto(var_04);
	}
	else
	{
		param_00 linkto(var_04);
	}

	param_00 playerlinkedoffsetenable();
	if(!isdefined(param_02))
	{
		param_02 = 1;
	}

	if(param_02)
	{
		param_00 common_scripts\utility::_disableweapon();
	}

	self.curprogress = 0;
	self.inuse = 1;
	self.userate = 0;
	if(isdefined(param_01))
	{
		self.usetime = param_01;
	}
	else
	{
		self.usetime = var_03;
	}

	if(isdefined(level.ishorde) && level.ishorde)
	{
		param_00 thread personalusebaroldstyle(self);
	}
	else
	{
		param_00 thread personalusebar(self);
	}

	thread reviveholdthink_cleanup(param_00,param_02,var_04);
	var_05 = reviveholdthinkloop(param_00);
	self.inuse = 0;
	var_04 delete();
	if(isdefined(var_05) && var_05)
	{
		self.owner thread maps\mp\gametypes\_hud_message::playercardsplashnotify("revived",param_00);
		self.owner.inlaststand = 0;
		return 1;
	}

	return 0;
}

//Function Number: 79
reviveholdthink_cleanup(param_00,param_01,param_02)
{
	common_scripts\utility::waittill_any_ents(self,"death",param_02,"death");
	if(!isremovedentity(param_02))
	{
		param_02 delete();
	}

	if(isdefined(param_00) && maps\mp\_utility::isreallyalive(param_00))
	{
		param_00 unlink();
		if(param_01)
		{
			param_00 common_scripts\utility::_enableweapon();
		}
	}
}

//Function Number: 80
personalusebar(param_00)
{
	self setclientomnvar("ui_use_bar_text",3);
	self setclientomnvar("ui_use_bar_start_time",int(gettime()));
	var_01 = undefined;
	if(isdefined(param_00) && isdefined(param_00.owner))
	{
		var_01 = param_00.owner;
		var_01 setclientomnvar("ui_use_bar_text",4);
		var_01 setclientomnvar("ui_use_bar_start_time",int(gettime()));
	}

	var_02 = -1;
	while(maps\mp\_utility::isreallyalive(self) && isdefined(param_00) && param_00.inuse && !level.gameended && isdefined(self))
	{
		if(var_02 != param_00.userate)
		{
			if(param_00.curprogress > param_00.usetime)
			{
				param_00.curprogress = param_00.usetime;
			}

			if(param_00.userate > 0)
			{
				var_03 = gettime();
				var_04 = param_00.curprogress / param_00.usetime;
				var_05 = var_03 + 1 - var_04 * param_00.usetime / param_00.userate;
				self setclientomnvar("ui_use_bar_end_time",int(var_05));
				if(isdefined(var_01))
				{
					var_01 setclientomnvar("ui_use_bar_end_time",int(var_05));
				}
			}

			var_02 = param_00.userate;
		}

		wait(0.05);
	}

	if(isdefined(self))
	{
		self setclientomnvar("ui_use_bar_end_time",0);
	}

	if(isdefined(var_01))
	{
		var_01 setclientomnvar("ui_use_bar_end_time",0);
	}
}

//Function Number: 81
personalusebaroldstyle(param_00)
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
		wait(0.05);
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

//Function Number: 82
reviveholdthinkloop(param_00)
{
	level endon("game_ended");
	self.owner endon("death");
	self.owner endon("disconnect");
	while(maps\mp\_utility::isreallyalive(param_00) && param_00 usebuttonpressed() && self.curprogress < self.usetime && !isdefined(param_00.inlaststand) && param_00.inlaststand)
	{
		self.curprogress = self.curprogress + 50 * self.userate;
		self.userate = 1;
		if(self.curprogress >= self.usetime)
		{
			self.inuse = 0;
			return maps\mp\_utility::isreallyalive(param_00);
		}

		wait(0.05);
	}

	return 0;
}

//Function Number: 83
callback_killingblow(param_00,param_01,param_02,param_03,param_04,param_05,param_06,param_07,param_08,param_09)
{
	if(isdefined(self.lastdamagewasfromenemy) && self.lastdamagewasfromenemy && param_02 >= self.health && isdefined(self.combathigh) && self.combathigh == "specialty_endgame")
	{
		maps\mp\_utility::giveperk("specialty_endgame",0);
		return 0;
	}

	return 1;
}

//Function Number: 84
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
		wait(0.1);
		var_06 delete();
	}
}

//Function Number: 85
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

//Function Number: 86
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
		var_0F = param_01.xuid + "(" + var_0C + ")";
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

//Function Number: 87
destroyonreviveentdeath(param_00)
{
	param_00 waittill("death");
	self destroy();
}

//Function Number: 88
gamemodemodifyplayerdamage(param_00,param_01,param_02,param_03,param_04,param_05,param_06,param_07,param_08)
{
	if(isdefined(param_02) && isplayer(param_02) && isalive(param_02))
	{
		if(level.matchrules_damagemultiplier)
		{
			param_03 = param_03 * level.matchrules_damagemultiplier;
		}

		if(level.matchrules_vampirism)
		{
			param_02.health = int(min(float(param_02.maxhealth),float(param_02.health + 20)));
		}
	}

	return param_03;
}

//Function Number: 89
setentitydamagecallback(param_00,param_01,param_02,param_03,param_04)
{
	if(!isdefined(param_04))
	{
		param_04 = 0;
	}

	if(!isdefined(param_01))
	{
		param_01 = "normal";
	}

	if(!isdefined(param_03))
	{
		param_03 = ::modifydamage;
	}

	self setcandamage(1);
	if(isdefined(self.classname) && self.classname != "script_vehicle")
	{
		self setdamagecallbackon(1);
	}

	self.health = 999999;
	self.maxhealth = param_00;
	self.damagetaken = 0;
	self.biskillstreak = param_04;
	self.damagefeedback = param_01;
	self.damagecallback = ::processdamagetaken;
	self.modifydamagefunc = param_03;
	self.ondeathfunc = param_02;
	self.attackerlist = [];
}

//Function Number: 90
processdamagetaken(param_00,param_01,param_02,param_03,param_04,param_05,param_06,param_07,param_08,param_09,param_0A,param_0B)
{
	if(!isdefined(self))
	{
		return;
	}

	if(!isdefined(level.ishorde) && level.ishorde && !isdefined(level.iszombiegame) && level.iszombiegame && isdefined(param_01) && !maps\mp\_utility::isgameparticipant(param_01))
	{
		return;
	}

	if(isdefined(param_01) && !maps\mp\gametypes\_weapons::friendlyfirecheck(self.owner,param_01))
	{
		return;
	}

	param_01 playrumbleonentity("damage_light");
	if(isdefined(self.iscrashing) && self.iscrashing)
	{
		return;
	}

	if(isdefined(self.isleaving) && self.isleaving)
	{
		return;
	}

	if(isdefined(self.stopdamagefunc) && self.stopdamagefunc)
	{
		return;
	}

	var_0C = param_02;
	if(isdefined(param_05))
	{
		var_0D = maps\mp\_utility::strip_suffix(param_05,"_lefthand");
		switch(var_0D)
		{
			case "smoke_grenade_var_mp":
			case "paint_grenade_var_mp":
			case "smoke_grenade_mp":
			case "paint_grenade_mp":
				break;
		}
	}
}

//Function Number: 91
isnewattacker(param_00)
{
	foreach(var_02 in self.attackerlist)
	{
		if(param_00 == var_02)
		{
			return 0;
		}
	}

	return 1;
}

//Function Number: 92
modifydamage(param_00,param_01,param_02,param_03)
{
	var_04 = param_03;
	var_04 = handlemeleedamage(param_01,param_02,var_04);
	var_04 = handleempdamage(param_01,param_02,var_04,param_00);
	var_04 = handlemissiledamage(param_01,param_02,var_04);
	var_04 = handlegrenadedamage(param_01,param_02,var_04);
	var_04 = handleapdamage(param_01,param_02,var_04,param_00);
	return var_04;
}

//Function Number: 93
handlemissiledamage(param_00,param_01,param_02)
{
	var_03 = param_02;
	switch(param_00)
	{
		case "orbitalsupport_missile_mp":
		case "orbitalsupport_105mm_mp":
		case "airstrike_missile_mp":
		case "remotemissile_projectile_secondary_mp":
		case "remotemissile_projectile_cluster_child_hellfire_mp":
		case "warbird_missile_mp":
		case "dam_turret_mp":
		case "remotemissile_projectile_cluster_child_mp":
		case "orbital_carepackage_pod_plane_mp":
		case "stealth_bomb_mp":
		case "stinger_mp":
		case "orbital_carepackage_droppod_mp":
		case "orbital_carepackage_pod_mp":
		case "remotemissile_projectile_gas_mp":
		case "remotemissile_projectile_cluster_parent_mp":
		case "remotemissile_projectile_mp":
		case "bomb_site_mp":
			break;

		case "killstreak_laser2_mp":
			break;

		case "killstreak_orbital_laser_mp":
		case "killstreakmahem_mp":
		case "assaultdrone_c4_mp":
		case "ugv_missile_mp":
		case "turretheadrocket_mp":
			break;

		case "orbitalsupport_40mmbuddy_mp":
		case "orbitalsupport_40mm_mp":
			break;
	}
}

//Function Number: 94
handlegrenadedamage(param_00,param_01,param_02)
{
	var_03 = maps\mp\_utility::strip_suffix(param_00,"_lefthand");
	if(var_03 == "stun_grenade_mp" || var_03 == "stun_grenade_var_mp" || var_03 == "stun_grenade_horde_mp")
	{
		self notify("concussed");
		return 0;
	}
	else if(isexplosivedamagemod(param_01))
	{
		switch(var_03)
		{
			case "explosive_drone_mp":
			case "semtex_mp":
			case "frag_grenade_mp":
				break;

			default:
				break;
		}
	}
}

//Function Number: 95
handlemeleedamage(param_00,param_01,param_02)
{
	if(maps\mp\_utility::ismeleemod(param_01))
	{
		var_03 = int(self.maxhealth / 3) + 1;
		if(var_03 > param_02)
		{
			return var_03;
		}
	}

	return param_02;
}

//Function Number: 96
handleempdamage(param_00,param_01,param_02,param_03)
{
	var_04 = maps\mp\_utility::strip_suffix(param_00,"_lefthand");
	if((var_04 == "emp_grenade_mp" || var_04 == "emp_grenade_var_mp" || var_04 == "emp_grenade_killstreak_mp") && param_01 == "MOD_GRENADE_SPLASH" || param_01 == "MOD_GRENADE")
	{
		self notify("emp_damage",param_03,8);
		return 0;
	}

	return param_02;
}

//Function Number: 97
handleapdamage(param_00,param_01,param_02,param_03)
{
	if(param_01 == "MOD_RIFLE_BULLET" || param_01 == "MOD_PISTOL_BULLET")
	{
		if(param_03 maps\mp\_utility::_hasperk("specialty_armorpiercing") || maps\mp\_utility::isfmjdamage(param_00,param_01,param_03))
		{
			return param_02 * level.armorpiercingmod;
		}
	}

	return param_02;
}

//Function Number: 98
onkillstreakkilled(param_00,param_01,param_02,param_03,param_04,param_05,param_06,param_07)
{
	var_08 = undefined;
	if(isdefined(param_00) && isdefined(self.owner))
	{
		if(isdefined(param_00.owner) && isplayer(param_00.owner))
		{
			param_00 = param_00.owner;
		}

		if(param_00 == self.owner)
		{
			return;
		}

		if(!isalliedsentient(self.owner,param_00))
		{
			var_08 = param_00;
		}
	}

	if(isdefined(var_08))
	{
		var_08 notify("destroyed_killstreak",param_01);
		var_08 maps\mp\_utility::incplayerstat(param_04,1);
		level thread maps\mp\gametypes\_rank::awardgameevent(param_04,var_08,param_01,undefined,param_02);
		if(isdefined(param_01) && param_01 == "killstreak_laser2_mp" && isdefined(level.sentrygun) && isdefined(level.sentrygun.ownerlist))
		{
			foreach(var_0A in level.sentrygun.ownerlist)
			{
				if(var_0A != var_08)
				{
					var_0A notify("destroyed_killstreak",param_01);
					var_0A maps\mp\_utility::incplayerstat(param_04,1);
					level thread maps\mp\gametypes\_rank::awardgameevent(param_04,var_0A,param_01,undefined,param_02);
				}
			}
		}

		if(isdefined(param_06))
		{
			level thread maps\mp\_utility::teamplayercardsplash(param_06,var_08);
		}

		if(isdefined(param_07) && param_07)
		{
			level thread maps\mp\gametypes\_missions::vehiclekilled(self.owner,self,undefined,var_08,param_03,param_02,param_01);
		}
	}

	thread maps\mp\_events::checkvandalismmedal(var_08);
	if(isdefined(self.owner) && isdefined(param_05))
	{
		self.owner thread maps\mp\_utility::leaderdialogonplayer(param_05,undefined,undefined,self.origin);
	}
}