/*******************************************************************
 * Decompiled By: Bog
 * Decompiled File: maps\mp\gametypes\_damage.gsc
 * Game: Call of Duty: Ghosts
 * Platform: Console
 * Function Count: 83
 * Decompile Time: 1464 ms
 * Timestamp: 10/27/2023 1:30:41 AM
*******************************************************************/

//Function Number: 1
func_497A()
{
	if(isdefined(self.switching_teams))
	{
		return 1;
	}

	return 0;
}

//Function Number: 2
func_4987()
{
	var_00 = maps\mp\gametypes\_teams::func_1F84();
	var_00[self.leaving_team]--;
	var_00[self.joining_team]++;
	return var_00[self.joining_team] - var_00[self.leaving_team] < 2;
}

//Function Number: 3
func_48C9(param_00,param_01)
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
func_4B1E(param_00)
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
func_3F9B()
{
	if(!level.teambased)
	{
	}

	if(self.joining_team == "spectator" || !func_4987())
	{
		self thread [[ level.onxpevent ]]("suicide");
		maps\mp\_utility::func_4479("suicides",1);
		self.suicides = maps\mp\_utility::func_3B8D("suicides");
	}

	if(isdefined(level.onteamchangedeath))
	{
		[[ level.onteamchangedeath ]](self);
	}
}

//Function Number: 6
handleworlddeath(param_00,param_01,param_02,param_03)
{
	if(!isdefined(param_00))
	{
	}

	if(!isdefined(param_00.team))
	{
		func_3F9A(param_02,param_03);
	}

	if((level.teambased && param_00.team != self.team) || !level.teambased)
	{
		if(isdefined(level.onnormaldeath) && isplayer(param_00) || isbot(param_00) && param_00.team != "spectator")
		{
			[[ level.onnormaldeath ]](self,param_00,param_01);
		}
	}
}

//Function Number: 7
func_3F9A(param_00,param_01)
{
	self thread [[ level.onxpevent ]]("suicide");
	maps\mp\_utility::func_4479("suicides",1);
	self.suicides = maps\mp\_utility::func_3B8D("suicides");
	if(!maps\mp\_utility::func_50C1())
	{
		maps\mp\_utility::func_447B("suicides",1);
	}

	var_02 = maps\mp\gametypes\_tweakables::func_3C5B("game","suicidepointloss");
	maps\mp\gametypes\_gamescore::_setplayerscore(self,maps\mp\gametypes\_gamescore::_getplayerscore(self) - var_02);
	if(param_00 == "MOD_SUICIDE" && param_01 == "none" && isdefined(self.throwinggrenade))
	{
		self.lastgrenadesuicidetime = gettime();
	}

	if(isdefined(level.onsuicidedeath))
	{
		[[ level.onsuicidedeath ]](self);
	}

	if(isdefined(self.var_3571))
	{
		self iprintlnbold(&"MP_FRIENDLY_FIRE_WILL_NOT");
	}
}

//Function Number: 8
handlefriendlyfiredeath(param_00)
{
	param_00 thread [[ level.onxpevent ]]("teamkill");
	param_00.pers["teamkills"] = param_00.pers["teamkills"] + 1;
	param_00.teamkillsthisround++;
	if(maps\mp\gametypes\_tweakables::func_3C5B("team","teamkillpointloss"))
	{
		var_01 = maps\mp\gametypes\_rank::func_3BE0("kill");
		maps\mp\gametypes\_gamescore::_setplayerscore(param_00,maps\mp\gametypes\_gamescore::_getplayerscore(param_00) - var_01);
	}

	if(level.maxallowedteamkills < 0)
	{
	}

	if(level.ingraceperiod)
	{
		var_02 = 1;
		param_00.pers["teamkills"] = param_00.pers["teamkills"] + level.maxallowedteamkills;
	}
	else if(var_02.pers["teamkills"] > 1 && maps\mp\_utility::func_3C4B() < level.graceperiod * 1000 + 8000 + var_02.pers["teamkills"] * 1000)
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

//Function Number: 9
func_3F8B(param_00,param_01,param_02,param_03,param_04)
{
	param_01 thread maps\mp\_events::func_4B1A(param_00,self,param_03,param_04);
	if(param_04 == "MOD_HEAD_SHOT")
	{
		param_01 maps\mp\_utility::func_4479("headshots",1);
		param_01.headshots = param_01 maps\mp\_utility::func_3B8D("headshots");
		param_01 maps\mp\_utility::func_447B("headshots",1);
		if(isdefined(param_01.laststand))
		{
			var_05 = maps\mp\gametypes\_rank::func_3BE0("kill") * 2;
		}
		else
		{
			var_05 = undefined;
		}

		param_01 playlocalsound("bullet_impact_headshot_plr");
		self playsound("bullet_impact_headshot");
	}
	else if(isdefined(param_02.laststand))
	{
		var_05 = maps\mp\gametypes\_rank::func_3BE0("kill") * 2;
	}
	else
	{
		var_05 = undefined;
	}

	var_06 = param_01;
	if(isdefined(param_01.commanding_bot))
	{
		var_06 = param_01.commanding_bot;
	}

	var_07 = 0;
	if(getactiveclientcount())
	{
		var_07 = 1;
	}

	var_06 maps\mp\_utility::func_4479("kills",1,var_07);
	var_06.kills = var_06 maps\mp\_utility::func_3B8D("kills");
	var_06 maps\mp\_utility::func_870C("kdRatio","kills","deaths");
	var_06 maps\mp\gametypes\_persistence::func_7B28("round","kills",var_06.kills);
	var_06 maps\mp\_utility::func_447B("kills",1);
	if(func_48C2(self,param_01))
	{
		var_06 maps\mp\_utility::func_447B("flankkills",1);
		maps\mp\_utility::func_447B("flankdeaths",1);
	}

	var_08 = param_01.pers["cur_kill_streak"];
	if(isalive(param_01) || param_01.streaktype == "support")
	{
		if((param_04 == "MOD_MELEE" && !param_01 maps\mp\_utility::isjuggernaut()) || param_01 maps\mp\_utility::func_4B2A(param_03))
		{
			param_01 func_646C(param_03,1);
		}

		param_01 maps\mp\_utility::func_70A1("killstreak",param_01.pers["cur_kill_streak"]);
		if(param_01.pers["cur_kill_streak"] > param_01 maps\mp\_utility::func_3B8D("longestStreak"))
		{
			param_01 maps\mp\_utility::func_7093("longestStreak",param_01.pers["cur_kill_streak"]);
		}
	}

	param_01.pers["cur_death_streak"] = 0;
	param_01 thread maps\mp\gametypes\_rank::giverankxp("kill",var_05,param_03,param_04,undefined,self);
	if(param_01.pers["cur_kill_streak"] > param_01 maps\mp\gametypes\_persistence::func_7B18("round","killStreak"))
	{
		param_01 maps\mp\gametypes\_persistence::func_7B28("round","killStreak",param_01.pers["cur_kill_streak"]);
	}

	if(param_01 maps\mp\_utility::func_634C())
	{
		if(param_01.pers["cur_kill_streak"] > param_01.kill_streak)
		{
			if(!getactiveclientcount())
			{
				param_01 maps\mp\gametypes\_persistence::func_7B26("killStreak",param_01.pers["cur_kill_streak"]);
			}

			param_01.kill_streak = param_01.pers["cur_kill_streak"];
		}
	}

	maps\mp\gametypes\_gamescore::func_3D00("kill",param_01,self);
	var_09 = maps\mp\gametypes\_tweakables::func_3C5B("game","deathpointloss");
	maps\mp\gametypes\_gamescore::_setplayerscore(self,maps\mp\gametypes\_gamescore::_getplayerscore(self) - var_09);
	if(isdefined(level.ac130player) && level.ac130player == param_01)
	{
		level notify("ai_killed",self);
	}

	if(isdefined(param_01.odin))
	{
		level notify("odin_killed_player",self);
	}

	level notify("player_got_killstreak_" + param_01.pers["cur_kill_streak"],param_01);
	param_01 notify("got_killstreak",param_01.pers["cur_kill_streak"]);
	param_01 notify("killed_enemy",self,param_03,param_04);
	if(isdefined(self.motionsensormarkedby))
	{
		if(self.motionsensormarkedby != param_01)
		{
			self.motionsensormarkedby thread maps\mp\gametypes\_weapons::func_5408(self);
		}

		self.motionsensormarkedby = undefined;
	}

	if(isdefined(level.onnormaldeath) && param_01.pers["team"] != "spectator")
	{
		[[ level.onnormaldeath ]](self,param_01,param_00);
	}

	if(!level.teambased)
	{
		self.attackers = [];
	}

	level thread maps\mp\gametypes\_battlechatter_mp::saylocalsounddelayed(param_01,"kill",0.75);
	if(isdefined(self.lastattackedshieldplayer) && isdefined(self.lastattackedshieldtime) && self.lastattackedshieldplayer != param_01)
	{
		if(gettime() - self.lastattackedshieldtime < 2500)
		{
			self.lastattackedshieldplayer thread maps\mp\gametypes\_gamescore::func_61D6(self);
			if(self.lastattackedshieldplayer maps\mp\_utility::_hasperk("specialty_assists"))
			{
				self.lastattackedshieldplayer.pers["assistsToKill"]++;
				if(!self.lastattackedshieldplayer.pers["assistsToKill"] % 2)
				{
					self.lastattackedshieldplayer maps\mp\gametypes\_missions::func_61CE("ch_hardlineassists");
					self.lastattackedshieldplayer maps\mp\killstreaks\_killstreaks::func_3CDB("kill");
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
			var_0A = vectornormalize(anglestoforward(self.angles));
			var_0B = vectornormalize(self.lastattackedshieldplayer.origin - self.origin);
			if(vectordot(var_0B,var_0A) > 0.925)
			{
				self.lastattackedshieldplayer thread maps\mp\gametypes\_gamescore::func_61D6(self);
				if(self.lastattackedshieldplayer maps\mp\_utility::_hasperk("specialty_assists"))
				{
					self.lastattackedshieldplayer.pers["assistsToKill"]++;
					if(!self.lastattackedshieldplayer.pers["assistsToKill"] % 2)
					{
						self.lastattackedshieldplayer maps\mp\gametypes\_missions::func_61CE("ch_hardlineassists");
						self.lastattackedshieldplayer maps\mp\killstreaks\_killstreaks::func_3CDB("kill");
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
		foreach(var_0D in self.attackers)
		{
			if(!isdefined(maps\mp\_utility::_validateattacker(var_0D)))
			{
				continue;
			}

			if(var_0D == param_01)
			{
				continue;
			}

			if(self == var_0D)
			{
				continue;
			}

			if(isdefined(level.assists_disabled))
			{
				continue;
			}

			var_0D thread maps\mp\gametypes\_gamescore::processassist(self);
			if(var_0D maps\mp\_utility::_hasperk("specialty_assists"))
			{
				var_0D.pers["assistsToKill"]++;
				if(!var_0D.pers["assistsToKill"] % 2)
				{
					var_0D maps\mp\gametypes\_missions::func_61CE("ch_hardlineassists");
					var_0D func_646C(param_03,0);
				}

				continue;
			}

			var_0D.pers["assistsToKill"] = 0;
		}

		self.attackers = [];
	}
}

//Function Number: 10
func_4938(param_00)
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

//Function Number: 11
waitskipkillcambuttonduringdeathtimer()
{
	self endon("disconnect");
	self endon("killcam_death_done_waiting");
	self notifyonplayercommand("death_respawn","+usereload");
	self notifyonplayercommand("death_respawn","+activate");
	self waittill("death_respawn");
	self notify("killcam_death_button_cancel");
}

//Function Number: 12
func_8B19(param_00)
{
	self endon("disconnect");
	self endon("killcam_death_button_cancel");
	wait(param_00);
	self notify("killcam_death_done_waiting");
}

//Function Number: 13
func_7582(param_00)
{
	self endon("disconnect");
	if(level.showingfinalkillcam)
	{
		return 0;
	}

	if(!isai(self))
	{
		thread waitskipkillcambuttonduringdeathtimer();
		thread func_8B19(param_00);
		var_01 = common_scripts\utility::func_8B33("killcam_death_done_waiting","killcam_death_button_cancel");
		if(var_01 == "killcam_death_done_waiting")
		{
			return 0;
		}
		else
		{
			return 1;
		}
	}

	return 0;
}

//Function Number: 14
func_194B(param_00,param_01,param_02,param_03,param_04,param_05,param_06,param_07,param_08)
{
	playerkilled_internal(param_00,param_01,self,param_02,param_03,param_04,param_05,param_06,param_07,param_08,0);
}

//Function Number: 15
func_629B(param_00)
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

//Function Number: 16
func_4D00(param_00,param_01)
{
	if(isdefined(self.hasriotshieldequipped) && self.hasriotshieldequipped)
	{
		if(isdefined(self.riotshieldmodel))
		{
			maps\mp\_utility::riotshield_detach(1);
		}

		if(isdefined(self.riotshieldmodelstowed))
		{
			maps\mp\_utility::riotshield_detach(0);
		}
	}
}

//Function Number: 17
playerkilled_internal(param_00,param_01,param_02,param_03,param_04,param_05,param_06,param_07,param_08,param_09,param_0A)
{
	param_02 endon("spawned");
	param_02 notify("killed_player");
	param_02 maps\mp\gametypes\_playerlogic::resetuidvarsondeath();
	param_02.abilitychosen = 0;
	param_02.perkoutlined = 0;
	if(maps\mp\_utility::gamehasneutralcrateowner(level.gametype))
	{
		if(param_02 != param_01 && param_04 == "MOD_CRUSH")
		{
			param_00 = param_02;
			param_01 = param_02;
			param_04 = "MOD_SUICIDE";
			param_05 = "none";
			param_07 = "none";
			param_02.attackers = [];
		}
	}

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
			if((issubstr(param_05,"frag_grenade") || issubstr(param_05,"thermobaric_grenade") || issubstr(param_05,"mortar_shell")) && param_03 == 100000)
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

	if(isdefined(param_02.hasriotshieldequipped) && param_02.hasriotshieldequipped)
	{
		param_02 func_4D00(param_03,param_04);
	}

	param_02 maps\mp\_utility::func_66D1();
	maps\mp\gametypes\_weapons::recordtogglescopestates();
	if(!param_0A)
	{
		if(isdefined(param_02.endgame))
		{
			maps\mp\_utility::func_6659(2);
		}
		else
		{
			maps\mp\_utility::func_6659(0);
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
	}

	maps\mp\perks\_perks::func_86C4(param_00,param_01,param_02,param_03,param_04);
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
		param_02 func_2F3E();
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
		param_01 = maps\mp\_utility::_validateattacker(param_01);
	}

	if((!isdefined(param_01) || param_01.classname == "trigger_hurt" || param_01.classname == "worldspawn" || param_01 == param_02) && isdefined(self.attackers))
	{
		var_0D = undefined;
		foreach(var_0F in self.attackers)
		{
			if(!isdefined(maps\mp\_utility::_validateattacker(var_0F)))
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

	if(maps\mp\_utility::func_48D2(param_05,param_07,param_04,param_01))
	{
		param_04 = "MOD_HEAD_SHOT";
	}
	else if(!isdefined(param_02.nuked))
	{
		if(isdefined(level.custom_death_sound))
		{
			[[ level.custom_death_sound ]](param_02,param_04,param_00);
		}
		else if(param_04 != "MOD_MELEE")
		{
			param_02 maps\mp\_utility::func_5D5B();
		}
	}

	if(isdefined(level.custom_death_effect))
	{
		[[ level.custom_death_effect ]](param_02,param_04,param_00);
	}

	var_11 = func_48C9(param_02,param_01);
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

		if(isbot(param_01))
		{
			param_05 = "agent_mp";
			param_04 = "MOD_RIFLE_BULLET";
			if(isdefined(param_01.agent_type))
			{
				if(param_01.agent_type == "dog")
				{
					param_05 = "guard_dog_mp";
				}
				else if(param_01.agent_type == "squadmate")
				{
					param_05 = "agent_support_mp";
				}
				else if(param_01.agent_type == "pirate")
				{
					param_05 = "pirate_agent_mp";
				}
				else if(param_01.agent_type == "wolf")
				{
					param_05 = "killstreak_wolfpack_mp";
				}
				else if(param_01.agent_type == "beastmen")
				{
					param_05 = "beast_agent_mp";
				}
			}

			if(isdefined(param_01.owner))
			{
				param_01 = param_01.owner;
			}
		}

		if(param_01.code_classname == "script_model" && isdefined(param_01.owner))
		{
			param_01 = param_01.owner;
			if(!func_48C9(param_02,param_01) && param_01 != param_02)
			{
				param_01 notify("crushed_enemy");
			}
		}
	}

	if(param_04 != "MOD_SUICIDE" && maps\mp\_utility::isaigameparticipant(param_02) || maps\mp\_utility::isaigameparticipant(param_01) && isdefined(level.bot_funcs) && isdefined(level.bot_funcs["get_attacker_ent"]))
	{
		var_12 = [[ level.bot_funcs["get_attacker_ent"] ]](param_01,param_00);
		if(isdefined(var_12))
		{
			if(maps\mp\_utility::isaigameparticipant(param_02))
			{
				param_02 botmemoryevent("death",param_05,var_12.origin,param_02.origin,var_12);
			}

			if(maps\mp\_utility::isaigameparticipant(param_01))
			{
				var_13 = 1;
				if((var_12.classname == "script_vehicle" && isdefined(var_12.helitype)) || var_12.classname == "rocket" || var_12.classname == "misc_turret")
				{
					var_13 = 0;
				}

				if(var_13)
				{
					param_01 botmemoryevent("kill",param_05,var_12.origin,param_02.origin,param_02);
				}
			}
		}
	}

	param_02 maps\mp\gametypes\_weapons::dropscavengerfordeath(param_01);
	param_02 [[ level.weapondropfunction ]](param_01,param_04);
	if(!param_0A)
	{
		param_02 maps\mp\_utility::func_8730("dead","hud_status_dead");
	}

	var_14 = isdefined(param_02.fauxdead) && param_02.fauxdead && isdefined(param_02.switching_teams) && param_02.switching_teams;
	if(!var_14)
	{
		param_02 maps\mp\gametypes\_playerlogic::func_6589();
	}

	if(!isdefined(param_02.switching_teams))
	{
		var_15 = param_02;
		if(isdefined(param_02.commanding_bot))
		{
			var_15 = param_02.commanding_bot;
		}

		if(isdefined(level.ishorde))
		{
			var_15.deaths++;
		}
		else
		{
			var_16 = 0;
			if(getactiveclientcount())
			{
				var_16 = 1;
			}

			var_15 maps\mp\_utility::func_4479("deaths",1,var_16);
			var_15.deaths = var_15 maps\mp\_utility::func_3B8D("deaths");
			var_15 maps\mp\_utility::func_870C("kdRatio","kills","deaths");
			var_15 maps\mp\gametypes\_persistence::func_7B28("round","deaths",var_15.deaths);
			var_15 maps\mp\_utility::func_447B("deaths",1);
		}
	}

	if(isdefined(param_01) && isplayer(param_01))
	{
		param_01 checkkillsteal(param_02);
	}

	obituary(param_02,param_01,param_05,param_04);
	var_17 = 0;
	var_18 = param_02 maps\mp\_matchdata::func_4F27();
	param_02 maps\mp\_matchdata::func_4F26(var_18,param_01,param_03,param_04,param_05,var_0C,param_07);
	if(isplayer(param_01))
	{
		if(param_04 == "MOD_MELEE")
		{
			if(maps\mp\gametypes\_weapons::func_494E(param_05))
			{
				param_01 maps\mp\_utility::func_447B("shieldkills",1);
				if(!maps\mp\_utility::func_50C1())
				{
					param_02 maps\mp\_utility::func_447B("shielddeaths",1);
				}
			}
			else
			{
				param_01 maps\mp\_utility::func_447B("knifekills",1);
			}

			addattacker(param_02,param_01,param_00,param_05,param_03,(0,0,0),param_06,param_07,param_08,param_04);
		}
	}

	if(param_02 func_497A())
	{
		func_3F9B();
	}
	else if(!isplayer(param_01) || isplayer(param_01) && param_04 == "MOD_FALLING")
	{
		handleworlddeath(param_01,var_18,param_04,param_07);
		if(isbot(param_01))
		{
			var_17 = 1;
		}
	}
	else if(param_01 == param_02)
	{
		func_3F9A(param_04,param_07);
	}
	else if(var_11)
	{
		if(!isdefined(param_02.nuked) || param_05 == "bomb_site_mp")
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

		var_17 = 1;
		if(isai(param_02) && isdefined(level.bot_funcs) && isdefined(level.bot_funcs["should_do_killcam"]))
		{
			var_17 = param_02 [[ level.bot_funcs["should_do_killcam"] ]]();
		}

		if(isdefined(level.disable_killcam) && level.disable_killcam)
		{
			var_17 = 0;
		}

		func_3F8B(var_18,param_01,param_00,param_05,param_04);
		param_02 thread maps\mp\gametypes\_missions::func_5FC1(param_00,param_01,param_03,param_04,param_05,var_0C,param_07,param_01.modifiers);
		param_02.pers["cur_death_streak"]++;
		if(isplayer(param_01) && param_02 maps\mp\_utility::isjuggernaut())
		{
			if(isdefined(param_02.isjuggernautmaniac) && param_02.isjuggernautmaniac)
			{
				param_01 thread maps\mp\_utility::func_7FA0("callout_killed_maniac",param_01);
				if(param_04 == "MOD_MELEE")
				{
					param_01 maps\mp\gametypes\_missions::func_61CE("ch_thisisaknife");
				}
			}
			else if(isdefined(param_02.isjuggernautlevelcustom) && param_02.isjuggernautlevelcustom)
			{
				param_01 thread maps\mp\_utility::func_7FA0(level.mapcustomjuggkilledsplash,param_01);
			}
			else
			{
				param_01 thread maps\mp\_utility::func_7FA0("callout_killed_juggernaut",param_01);
			}
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

		var_1B = maps\mp\_utility::func_8DAC(var_1B);
		thread maps\mp\gametypes\_gamelogic::func_821F(var_1B,param_04);
		param_01 thread maps\mp\gametypes\_gamelogic::func_8210(param_05,param_04);
	}

	if(isdefined(param_01) && isdefined(param_02))
	{
		function_021E("kills","attackername %s attackerteam %s attackerx %f attackery %f attackerz %f attackerweapon %s victimx %f victimy %f victimz %f victimname %s victimteam %s damage %i damagetype %s damagelocation %s attackerisbot %i victimisbot %i timesincespawn %f",param_01.name,param_01.team,param_01.origin[0],param_01.origin[1],param_01.origin[2],param_05,param_02.origin[0],param_02.origin[1],param_02.origin[2],param_02.name,param_02.team,param_03,param_04,param_07,isai(param_01),isai(param_02),gettime() - param_02.lastspawntime / 1000);
	}

	param_02.wasswitchingteamsforonplayerkilled = undefined;
	if(isdefined(param_02.switching_teams))
	{
		param_02.wasswitchingteamsforonplayerkilled = 1;
	}

	param_02 resetplayervariables();
	param_02.lastattacker = param_01;
	param_02.lastdeathpos = param_02.origin;
	param_02.deathtime = gettime();
	param_02.wantsafespawn = 0;
	param_02.revived = 0;
	param_02.sameshotdamage = 0;
	if(maps\mp\killstreaks\_killstreaks::func_7C97(param_02.streaktype))
	{
		param_02 maps\mp\killstreaks\_killstreaks::func_6604();
	}

	var_1C = undefined;
	if(maps\mp\_utility::isrocketcorpse())
	{
		var_17 = 1;
		param_0A = 0;
		var_1C = self.killcament;
		self waittill("final_rocket_corpse_death");
	}
	else
	{
		if(param_0A)
		{
			var_17 = 0;
			param_09 = param_02 playerforcedeathanim(param_00,param_04,param_05,param_07,param_06);
		}

		param_02.body = param_02 cloneplayer(param_09);
		param_02.body.targetname = "player_corpse";
		if(param_0A)
		{
			param_02 playerhide();
		}

		if(param_02 isonladder() || param_02 ismantling() || !param_02 isonground() || isdefined(param_02.nuked) || isdefined(param_02.customdeath))
		{
			var_1D = 0;
			if(param_04 == "MOD_MELEE")
			{
				if((isdefined(param_02.isplanting) && param_02.isplanting) || isdefined(param_02.nuked))
				{
					var_1D = 1;
				}
			}

			if(!var_1D)
			{
				param_02.body startragdoll();
				param_02 notify("start_instant_ragdoll",param_04,param_00);
			}
		}

		if(!isdefined(param_02.switching_teams))
		{
			if(isdefined(param_01) && isplayer(param_01) && !param_01 maps\mp\_utility::_hasperk("specialty_silentkill"))
			{
				thread maps\mp\gametypes\_deathicons::adddeathicon(param_02.body,param_02,param_02.team,5);
			}
		}

		thread func_252D(param_02.body,param_07,param_06,param_05,param_00,param_04);
	}

	param_02 thread [[ level.onplayerkilled ]](param_00,param_01,param_03,param_04,param_05,param_06,param_07,param_08,param_09,var_18);
	if(isai(param_02) && isdefined(level.bot_funcs) && isdefined(level.bot_funcs["on_killed"]))
	{
		param_02 thread [[ level.bot_funcs["on_killed"] ]](param_00,param_01,param_03,param_04,param_05,param_06,param_07,param_08,param_09,var_18);
	}

	if(maps\mp\_utility::func_48CE(param_01))
	{
		var_1E = param_01 getentitynumber();
	}
	else
	{
		var_1E = -1;
	}

	if(!isdefined(var_1C))
	{
		var_1C = param_02 func_3AEE(param_01,param_00,param_05);
	}

	var_1F = -1;
	var_20 = 0;
	if(isdefined(var_1C))
	{
		var_1F = var_1C getentitynumber();
		var_20 = var_1C.birthtime;
		if(!isdefined(var_20))
		{
			var_20 = 0;
		}
	}

	if((!isdefined(level.disable_killcam) || !level.disable_killcam) && param_04 != "MOD_SUICIDE" && !!isdefined(param_01) || param_01.classname == "trigger_hurt" || param_01.classname == "worldspawn" || param_01 == param_02)
	{
		recordfinalkillcam(5,param_02,param_01,var_1E,param_00,var_1F,var_20,param_05,var_0B,param_08,param_04);
	}

	param_02 setcommonplayerdata("killCamHowKilled",0);
	switch(param_04)
	{
		case "MOD_HEAD_SHOT":
			param_02 setcommonplayerdata("killCamHowKilled",1);
			break;

		default:
			break;
	}

	var_21 = undefined;
	if(var_17)
	{
		param_02 maps\mp\gametypes\_killcam::prekillcamnotify(param_00,param_01);
		if(isdefined(param_00) && isbot(param_00))
		{
			var_21 = addstruct();
			var_21.agent_type = param_00.agent_type;
			var_21.lastspawntime = param_00.lastspawntime;
		}
	}

	if(!param_0A)
	{
		self.respawntimerstarttime = gettime() + 1000;
		var_22 = maps\mp\gametypes\_playerlogic::func_813A(1);
		if(var_22 < 1)
		{
			var_22 = 1;
		}

		param_02 thread maps\mp\gametypes\_playerlogic::func_611F(var_22);
		wait(1);
		if(var_17)
		{
			var_17 = !func_7582(0.5);
		}

		param_02 notify("death_delay_finished");
	}

	var_23 = gettime() - param_02.deathtime / 1000;
	self.respawntimerstarttime = gettime();
	var_17 = var_17 && !param_02 maps\mp\gametypes\_battlebuddy::func_199B();
	if(!isdefined(param_02.var_19A0) && param_02.var_19A0 && var_17 && level.killcam && game["state"] == "playing" && !param_02 maps\mp\_utility::func_4995() && !level.showingfinalkillcam)
	{
		var_24 = !maps\mp\_utility::func_3ABB() && !param_02.pers["lives"];
		var_22 = maps\mp\gametypes\_playerlogic::func_813A(1);
		var_25 = var_24 && var_22 <= 0;
		if(!var_24)
		{
			var_22 = -1;
			level notify("player_eliminated",param_02);
		}

		param_02 maps\mp\gametypes\_killcam::killcam(param_00,var_21,var_1E,var_1F,var_20,param_05,var_23 + var_0B,param_08,var_22,maps\mp\gametypes\_gamelogic::func_8139(),param_01,param_02,param_04);
	}

	if(game["state"] != "playing")
	{
		if(!level.showingfinalkillcam)
		{
			param_02 maps\mp\_utility::func_8730("dead");
			param_02 maps\mp\_utility::clearkillcamstate();
		}
	}

	var_26 = maps\mp\_utility::func_3ABB();
	var_27 = self.pers["lives"];
	if(self == param_02 && isdefined(param_02.battlebuddy) && maps\mp\_utility::func_4945(param_02.battlebuddy) && !maps\mp\_utility::func_3ABB() || self.pers["lives"] && !param_02 maps\mp\_utility::func_4995())
	{
		maps\mp\gametypes\_battlebuddy::func_8AED();
	}

	if(maps\mp\_utility::func_499C(param_02.class))
	{
		param_02 thread maps\mp\gametypes\_playerlogic::func_7866();
	}
}

//Function Number: 18
checkforcebleedout()
{
	if(level.diehardmode != 1)
	{
		return 0;
	}

	if(!maps\mp\_utility::func_3ABB())
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

		if(!var_01.var_465B)
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

		if(var_01.var_465B && var_01 != self)
		{
			var_01 func_4CAB(0);
		}
	}

	return 1;
}

//Function Number: 19
checkkillsteal(param_00)
{
	if(maps\mp\_utility::func_50C1())
	{
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
			maps\mp\_utility::func_447B("killsteals",1);
		}
	}
}

//Function Number: 20
func_460E()
{
	level.finalkillcam_delay = [];
	level.finalkillcam_victim = [];
	level.finalkillcam_attacker = [];
	level.finalkillcam_attackernum = [];
	level.finalkillcam_inflictor = [];
	level.finalkillcam_inflictor_agent_type = [];
	level.finalkillcam_inflictor_lastspawntime = [];
	level.finalkillcam_killcamentityindex = [];
	level.finalkillcam_killcamentitystarttime = [];
	level.finalkillcam_sweapon = [];
	level.finalkillcam_deathtimeoffset = [];
	level.finalkillcam_psoffsettime = [];
	level.finalkillcam_timerecorded = [];
	level.finalkillcam_timegameended = [];
	level.finalkillcam_smeansofdeath = [];
	if(level.multiteambased)
	{
		foreach(var_01 in level.teamnamelist)
		{
			level.finalkillcam_delay[var_01] = undefined;
			level.finalkillcam_victim[var_01] = undefined;
			level.finalkillcam_attacker[var_01] = undefined;
			level.finalkillcam_attackernum[var_01] = undefined;
			level.finalkillcam_inflictor[var_01] = undefined;
			level.finalkillcam_inflictor_agent_type[var_01] = undefined;
			level.finalkillcam_inflictor_lastspawntime[var_01] = undefined;
			level.finalkillcam_killcamentityindex[var_01] = undefined;
			level.finalkillcam_killcamentitystarttime[var_01] = undefined;
			level.finalkillcam_sweapon[var_01] = undefined;
			level.finalkillcam_deathtimeoffset[var_01] = undefined;
			level.finalkillcam_psoffsettime[var_01] = undefined;
			level.finalkillcam_timerecorded[var_01] = undefined;
			level.finalkillcam_timegameended[var_01] = undefined;
			level.finalkillcam_smeansofdeath[var_01] = undefined;
		}
	}
	else
	{
		level.finalkillcam_delay["axis"] = undefined;
		level.finalkillcam_victim["axis"] = undefined;
		level.finalkillcam_attacker["axis"] = undefined;
		level.finalkillcam_attackernum["axis"] = undefined;
		level.finalkillcam_inflictor["axis"] = undefined;
		level.finalkillcam_inflictor_agent_type["axis"] = undefined;
		level.finalkillcam_inflictor_lastspawntime["axis"] = undefined;
		level.finalkillcam_killcamentityindex["axis"] = undefined;
		level.finalkillcam_killcamentitystarttime["axis"] = undefined;
		level.finalkillcam_sweapon["axis"] = undefined;
		level.finalkillcam_deathtimeoffset["axis"] = undefined;
		level.finalkillcam_psoffsettime["axis"] = undefined;
		level.finalkillcam_timerecorded["axis"] = undefined;
		level.finalkillcam_timegameended["axis"] = undefined;
		level.finalkillcam_smeansofdeath["axis"] = undefined;
		level.finalkillcam_delay["allies"] = undefined;
		level.finalkillcam_victim["allies"] = undefined;
		level.finalkillcam_attacker["allies"] = undefined;
		level.finalkillcam_attackernum["allies"] = undefined;
		level.finalkillcam_inflictor["allies"] = undefined;
		level.finalkillcam_inflictor_agent_type["allies"] = undefined;
		level.finalkillcam_inflictor_lastspawntime["allies"] = undefined;
		level.finalkillcam_killcamentityindex["allies"] = undefined;
		level.finalkillcam_killcamentitystarttime["allies"] = undefined;
		level.finalkillcam_sweapon["allies"] = undefined;
		level.finalkillcam_deathtimeoffset["allies"] = undefined;
		level.finalkillcam_psoffsettime["allies"] = undefined;
		level.finalkillcam_timerecorded["allies"] = undefined;
		level.finalkillcam_timegameended["allies"] = undefined;
		level.finalkillcam_smeansofdeath["allies"] = undefined;
	}

	level.finalkillcam_delay["none"] = undefined;
	level.finalkillcam_victim["none"] = undefined;
	level.finalkillcam_attacker["none"] = undefined;
	level.finalkillcam_attackernum["none"] = undefined;
	level.finalkillcam_inflictor["none"] = undefined;
	level.finalkillcam_inflictor_agent_type["none"] = undefined;
	level.finalkillcam_inflictor_lastspawntime["none"] = undefined;
	level.finalkillcam_killcamentityindex["none"] = undefined;
	level.finalkillcam_killcamentitystarttime["none"] = undefined;
	level.finalkillcam_sweapon["none"] = undefined;
	level.finalkillcam_deathtimeoffset["none"] = undefined;
	level.finalkillcam_psoffsettime["none"] = undefined;
	level.finalkillcam_timerecorded["none"] = undefined;
	level.finalkillcam_timegameended["none"] = undefined;
	level.finalkillcam_smeansofdeath["none"] = undefined;
	level.finalkillcam_winner = undefined;
}

//Function Number: 21
recordfinalkillcam(param_00,param_01,param_02,param_03,param_04,param_05,param_06,param_07,param_08,param_09,param_0A)
{
	if(level.teambased && isdefined(param_02.team))
	{
		level.finalkillcam_delay[param_02.team] = param_00;
		level.finalkillcam_victim[param_02.team] = param_01;
		level.finalkillcam_attacker[param_02.team] = param_02;
		level.finalkillcam_attackernum[param_02.team] = param_03;
		level.finalkillcam_inflictor[param_02.team] = param_04;
		level.finalkillcam_killcamentityindex[param_02.team] = param_05;
		level.finalkillcam_killcamentitystarttime[param_02.team] = param_06;
		level.finalkillcam_sweapon[param_02.team] = param_07;
		level.finalkillcam_deathtimeoffset[param_02.team] = param_08;
		level.finalkillcam_psoffsettime[param_02.team] = param_09;
		level.finalkillcam_timerecorded[param_02.team] = maps\mp\_utility::func_3BE4();
		level.finalkillcam_timegameended[param_02.team] = maps\mp\_utility::func_3BE4();
		level.finalkillcam_smeansofdeath[param_02.team] = param_0A;
		if(isdefined(param_04) && isbot(param_04))
		{
			level.finalkillcam_inflictor_agent_type[param_02.team] = param_04.agent_type;
			level.finalkillcam_inflictor_lastspawntime[param_02.team] = param_04.lastspawntime;
		}
		else
		{
			level.finalkillcam_inflictor_agent_type[param_02.team] = undefined;
			level.finalkillcam_inflictor_lastspawntime[param_02.team] = undefined;
		}
	}

	level.finalkillcam_delay["none"] = param_00;
	level.finalkillcam_victim["none"] = param_01;
	level.finalkillcam_attacker["none"] = param_02;
	level.finalkillcam_attackernum["none"] = param_03;
	level.finalkillcam_inflictor["none"] = param_04;
	level.finalkillcam_killcamentityindex["none"] = param_05;
	level.finalkillcam_killcamentitystarttime["none"] = param_06;
	level.finalkillcam_sweapon["none"] = param_07;
	level.finalkillcam_deathtimeoffset["none"] = param_08;
	level.finalkillcam_psoffsettime["none"] = param_09;
	level.finalkillcam_timerecorded["none"] = maps\mp\_utility::func_3BE4();
	level.finalkillcam_timegameended["none"] = maps\mp\_utility::func_3BE4();
	level.finalkillcam_timegameended["none"] = maps\mp\_utility::func_3BE4();
	level.finalkillcam_smeansofdeath["none"] = param_0A;
	if(isdefined(param_04) && isbot(param_04))
	{
		level.finalkillcam_inflictor_agent_type["none"] = param_04.agent_type;
		level.finalkillcam_inflictor_lastspawntime["none"] = param_04.lastspawntime;
	}

	level.finalkillcam_inflictor_agent_type["none"] = undefined;
	level.finalkillcam_inflictor_lastspawntime["none"] = undefined;
}

//Function Number: 22
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
			level.finalkillcam_inflictor[level.teamnamelist[var_00]] = undefined;
			level.finalkillcam_inflictor_agent_type[level.teamnamelist[var_00]] = undefined;
			level.finalkillcam_inflictor_lastspawntime[level.teamnamelist[var_00]] = undefined;
			level.finalkillcam_killcamentityindex[level.teamnamelist[var_00]] = undefined;
			level.finalkillcam_killcamentitystarttime[level.teamnamelist[var_00]] = undefined;
			level.finalkillcam_sweapon[level.teamnamelist[var_00]] = undefined;
			level.finalkillcam_deathtimeoffset[level.teamnamelist[var_00]] = undefined;
			level.finalkillcam_psoffsettime[level.teamnamelist[var_00]] = undefined;
			level.finalkillcam_timerecorded[level.teamnamelist[var_00]] = undefined;
			level.finalkillcam_timegameended[level.teamnamelist[var_00]] = undefined;
			level.finalkillcam_smeansofdeath[level.teamnamelist[var_00]] = undefined;
		}
	}
	else
	{
		level.finalkillcam_delay["axis"] = undefined;
		level.finalkillcam_victim["axis"] = undefined;
		level.finalkillcam_attacker["axis"] = undefined;
		level.finalkillcam_attackernum["axis"] = undefined;
		level.finalkillcam_inflictor["axis"] = undefined;
		level.finalkillcam_inflictor_agent_type["axis"] = undefined;
		level.finalkillcam_inflictor_lastspawntime["axis"] = undefined;
		level.finalkillcam_killcamentityindex["axis"] = undefined;
		level.finalkillcam_killcamentitystarttime["axis"] = undefined;
		level.finalkillcam_sweapon["axis"] = undefined;
		level.finalkillcam_deathtimeoffset["axis"] = undefined;
		level.finalkillcam_psoffsettime["axis"] = undefined;
		level.finalkillcam_timerecorded["axis"] = undefined;
		level.finalkillcam_timegameended["axis"] = undefined;
		level.finalkillcam_smeansofdeath["axis"] = undefined;
		level.finalkillcam_delay["allies"] = undefined;
		level.finalkillcam_victim["allies"] = undefined;
		level.finalkillcam_attacker["allies"] = undefined;
		level.finalkillcam_attackernum["allies"] = undefined;
		level.finalkillcam_inflictor["allies"] = undefined;
		level.finalkillcam_inflictor_agent_type["allies"] = undefined;
		level.finalkillcam_inflictor_lastspawntime["allies"] = undefined;
		level.finalkillcam_killcamentityindex["allies"] = undefined;
		level.finalkillcam_killcamentitystarttime["allies"] = undefined;
		level.finalkillcam_sweapon["allies"] = undefined;
		level.finalkillcam_deathtimeoffset["allies"] = undefined;
		level.finalkillcam_psoffsettime["allies"] = undefined;
		level.finalkillcam_timerecorded["allies"] = undefined;
		level.finalkillcam_timegameended["allies"] = undefined;
		level.finalkillcam_smeansofdeath["allies"] = undefined;
	}

	level.finalkillcam_delay["none"] = undefined;
	level.finalkillcam_victim["none"] = undefined;
	level.finalkillcam_attacker["none"] = undefined;
	level.finalkillcam_attackernum["none"] = undefined;
	level.finalkillcam_inflictor["none"] = undefined;
	level.finalkillcam_inflictor_agent_type["none"] = undefined;
	level.finalkillcam_inflictor_lastspawntime["none"] = undefined;
	level.finalkillcam_killcamentityindex["none"] = undefined;
	level.finalkillcam_killcamentitystarttime["none"] = undefined;
	level.finalkillcam_sweapon["none"] = undefined;
	level.finalkillcam_deathtimeoffset["none"] = undefined;
	level.finalkillcam_psoffsettime["none"] = undefined;
	level.finalkillcam_timerecorded["none"] = undefined;
	level.finalkillcam_timegameended["none"] = undefined;
	level.finalkillcam_smeansofdeath["none"] = undefined;
	level.finalkillcam_winner = undefined;
}

//Function Number: 23
func_2893()
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
	var_05 = level.finalkillcam_inflictor[var_00];
	var_06 = level.finalkillcam_inflictor_agent_type[var_00];
	var_07 = level.finalkillcam_inflictor_lastspawntime[var_00];
	var_08 = level.finalkillcam_killcamentityindex[var_00];
	var_09 = level.finalkillcam_killcamentitystarttime[var_00];
	var_0A = level.finalkillcam_sweapon[var_00];
	var_0B = level.finalkillcam_deathtimeoffset[var_00];
	var_0C = level.finalkillcam_psoffsettime[var_00];
	var_0D = level.finalkillcam_timerecorded[var_00];
	var_0E = level.finalkillcam_timegameended[var_00];
	var_0F = level.finalkillcam_smeansofdeath[var_00];
	if(!isdefined(var_02) || !isdefined(var_03))
	{
		level.showingfinalkillcam = 0;
		level notify("final_killcam_done");
	}

	var_10 = 15;
	var_11 = var_0E - var_0D;
	if(var_11 > var_10)
	{
		level.showingfinalkillcam = 0;
		level notify("final_killcam_done");
	}

	if(isdefined(var_03))
	{
		var_03.finalkill = 1;
		var_12 = "none";
		if(level.teambased)
		{
			var_12 = var_03.team;
		}

		if(isdefined(level.finalkillcam_attacker[var_12]) && level.finalkillcam_attacker[var_12] == var_03)
		{
			maps\mp\gametypes\_missions::processfinalkillchallenges(var_03,var_02);
		}
	}

	var_13 = addstruct();
	var_13.agent_type = var_06;
	var_13.lastspawntime = var_07;
	var_14 = gettime() - var_02.deathtime / 1000;
	foreach(var_16 in level.players)
	{
		var_16 maps\mp\_utility::func_6659(0);
		var_16.killcamentitylookat = var_02 getentitynumber();
		var_16 thread maps\mp\gametypes\_killcam::killcam(var_05,var_13,var_04,var_08,var_09,var_0A,var_14 + var_0B,var_0C,0,12,var_03,var_02,var_0F);
	}

	wait(0.1);
	while(anyplayersinkillcam())
	{
		wait(0.05);
	}

	level notify("final_killcam_done");
	level.showingfinalkillcam = 0;
}

//Function Number: 24
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

//Function Number: 25
resetplayervariables()
{
	self.killedplayerscurrent = [];
	self.ch_extremecrueltycomplete = 0;
	self.switching_teams = undefined;
	self.joining_team = undefined;
	self.leaving_team = undefined;
	self.pers["cur_kill_streak"] = 0;
	self.pers["cur_kill_streak_for_nuke"] = 0;
	maps\mp\gametypes\_gameobjects::detachusemodels();
}

//Function Number: 26
func_3AEE(param_00,param_01,param_02)
{
	if(!isdefined(param_00) || !isdefined(param_01) || param_00 == param_01 && !isbot(param_00))
	{
		return undefined;
	}

	switch(param_02)
	{
		case "hashima_missiles_mp":
		case "sentry_minigun_mp":
		case "heli_pilot_turret_mp":
		case "proximity_explosive_mp":
		case "bomb_site_mp":
		case "trophy_mp":
			return param_01.killcament;

		case "aamissile_projectile_mp":
		case "hind_missile_mp":
		case "hind_bomb_mp":
		case "remote_tank_projectile_mp":
			if(isdefined(param_01.vehicle_fired_from) && isdefined(param_01.vehicle_fired_from.killcament))
			{
				return param_01.vehicle_fired_from.killcament;
			}
			else if(isdefined(param_01.vehicle_fired_from))
			{
				return param_01.vehicle_fired_from;
			}
			break;

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

		case "ball_drone_projectile_mp":
		case "ball_drone_gun_mp":
			if(isplayer(param_00) && isdefined(param_00.balldrone) && isdefined(param_00.balldrone.turret) && isdefined(param_00.balldrone.turret.killcament))
			{
				return param_00.balldrone.turret.killcament;
			}
			break;

		case "artillery_mp":
		case "none":
			if((isdefined(param_01.targetname) && param_01.targetname == "care_package") || isdefined(param_01.killcament) && param_01.classname == "script_brushmodel" || param_01.classname == "trigger_multiple" || param_01.classname == "script_model")
			{
				return param_01.killcament;
			}
			break;

		case "remote_turret_mp":
		case "ugv_turret_mp":
		case "osprey_player_minigun_mp":
		case "ac130_25mm_mp":
		case "remotemissile_projectile_mp":
		case "ac130_40mm_mp":
		case "ac130_105mm_mp":
			return undefined;
	}

	if(maps\mp\_utility::isdestructibleweapon(param_02) || maps\mp\_utility::func_4888(param_02))
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

//Function Number: 27
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
	else if(isdefined(self.using_remote_a10))
	{
		return 1;
	}

	return 0;
}

//Function Number: 28
func_4278(param_00,param_01,param_02,param_03,param_04)
{
	var_05 = [];
	var_05[0] = 2;
	var_05[1] = 3;
	var_05[2] = 5;
	var_05[3] = 7;
	if(!getdvarint("scr_hitloc_debug"))
	{
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
	}

	var_07 = 6;
	if(!isdefined(param_00.damageinfo))
	{
		param_00.damageinfo = [];
		for(var_06 = 0;var_06 < var_07;var_06++)
		{
			param_00.damageinfo[var_06] = addstruct();
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

//Function Number: 29
giverecentshieldxp()
{
	self endon("death");
	self endon("disconnect");
	self notify("giveRecentShieldXP");
	self endon("giveRecentShieldXP");
	self.var_63FF++;
	wait(20);
	self.var_63FF = 0;
}

//Function Number: 30
updateinflictorstat(param_00,param_01,param_02)
{
	if(!isdefined(param_00) || !isdefined(param_00.alreadyhit) || !param_00.alreadyhit || !maps\mp\_utility::issinglehitweapon(param_02))
	{
		maps\mp\gametypes\_gamelogic::func_7057(param_00,param_01,param_02);
	}

	if(isdefined(param_00))
	{
		param_00.alreadyhit = 1;
	}
}

//Function Number: 31
callback_playerdamage_internal(param_00,param_01,param_02,param_03,param_04,param_05,param_06,param_07,param_08,param_09,param_0A)
{
	param_01 = maps\mp\_utility::_validateattacker(param_01);
	var_0B = getdvar("g_gametype");
	if(isdefined(param_05) && param_05 == "MOD_CRUSH" && isdefined(param_00) && isdefined(param_00.classname) && param_00.classname == "script_vehicle")
	{
		return "crushed";
	}

	if(!maps\mp\_utility::func_4945(param_02))
	{
		return "!isReallyAlive( victim )";
	}

	if(param_06 == "hind_bomb_mp" || param_06 == "hind_missile_mp")
	{
		if(isdefined(param_01) && param_02 == param_01)
		{
			return 0;
		}
	}

	if(isdefined(param_01) && param_01.classname == "script_origin" && isdefined(param_01.type) && param_01.type == "soft_landing")
	{
		return "soft_landing";
	}

	if(param_06 == "killstreak_emp_mp")
	{
		return "sWeapon == killstreak_emp_mp";
	}

	if(param_06 == "bouncingbetty_mp" && !maps\mp\gametypes\_weapons::func_5244(param_00,param_02))
	{
		return "mineDamageHeightPassed";
	}

	if(param_06 == "bouncingbetty_mp" && param_02 getstance() == "crouch" || param_02 getstance() == "prone")
	{
		param_03 = castint(param_03 / 2);
	}

	if(param_06 == "emp_grenade_mp" && param_05 != "MOD_IMPACT")
	{
		param_02 notify("emp_damage",param_01);
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
		param_03 = castint(param_03);
	}

	if(isdefined(param_01) && param_01.classname == "worldspawn")
	{
		param_01 = undefined;
	}

	if(isdefined(param_01) && isdefined(param_01.gunner))
	{
		param_01 = param_01.gunner;
	}

	if(isdefined(param_00) && isdefined(param_00.damagedby))
	{
		param_01 = param_00.damagedby;
	}

	var_0C = isdefined(param_01) && !isdefined(param_01.gunner) && param_01.classname == "script_vehicle" || param_01.classname == "misc_turret" || param_01.classname == "script_model";
	var_0D = maps\mp\_utility::attackerishittingteam(param_02,param_01);
	var_0E = isdefined(param_01) && isdefined(param_00) && isdefined(param_02) && isplayer(param_01) && param_01 == param_00 && param_01 == param_02 && !isdefined(param_00.poison);
	if(var_0E)
	{
		return "attackerIsInflictorVictim";
	}

	var_0F = 0;
	if(param_04 & level.idflags_stun)
	{
		var_0F = 0;
		param_03 = 0;
	}
	else if(param_09 == "shield")
	{
		if(var_0D && level.friendlyfire == 0)
		{
			return "attackerIsHittingTeammate";
		}

		if(param_05 == "MOD_PISTOL_BULLET" || param_05 == "MOD_RIFLE_BULLET" || param_05 == "MOD_EXPLOSIVE_BULLET" && !var_0D)
		{
			if(isplayer(param_01))
			{
				if(isdefined(param_02.owner))
				{
					param_02 = param_02.owner;
				}

				param_01.lastattackedshieldplayer = param_02;
				param_01.lastattackedshieldtime = gettime();
			}

			param_02 notify("shield_blocked");
			if(maps\mp\_utility::func_48B7(param_06))
			{
				var_10 = 25;
			}
			else
			{
				var_10 = maps\mp\perks\_perks::func_1905(param_03,param_02,param_04,param_06,param_07,param_08,param_09,param_0A);
			}

			param_02.var_7402 = param_02.var_7402 + var_10;
			if(!maps\mp\_utility::func_48B7(param_06) || common_scripts\utility::func_1DE9())
			{
				param_02.var_7401++;
			}

			if(param_02.var_7401 >= level.riotshieldxpbullets)
			{
				if(self.var_63FF > 4)
				{
					var_11 = castint(50 / self.var_63FF);
				}
				else
				{
					var_11 = 50;
				}

				param_02 thread maps\mp\gametypes\_rank::giverankxp("shield_damage",var_11);
				param_02 thread giverecentshieldxp();
				param_02 thread maps\mp\gametypes\_missions::func_37A9("shield_damage",param_02.var_7402);
				param_02 thread maps\mp\gametypes\_missions::func_37A9("shield_bullet_hits",param_02.var_7401);
				param_02.var_7402 = 0;
				param_02.var_7401 = 0;
			}
		}

		if(param_04 & level.idflags_shield_explosive_impact)
		{
			if(!var_0D)
			{
				param_02 thread maps\mp\gametypes\_missions::func_37A9("shield_explosive_hits",1);
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
				param_03 = 151;
			}

			param_02 thread maps\mp\gametypes\_missions::func_37A9("shield_explosive_hits",1);
			param_09 = "none";
		}
		else
		{
			return "hit shield";
		}
	}
	else if(param_05 == "MOD_MELEE" && maps\mp\gametypes\_weapons::func_494E(param_06))
	{
		if(!var_0D && level.friendlyfire == 0)
		{
			var_0F = 0;
			param_02 stunplayer(0);
		}
	}

	if(isdefined(param_00) && isdefined(param_00.stuckenemyentity) && param_00.stuckenemyentity == param_02)
	{
		param_03 = 151;
	}

	if(!var_0D)
	{
		if(maps\mp\_utility::_hasperk("specialty_moredamage"))
		{
			maps\mp\_utility::_unsetperk("specialty_moredamage");
		}

		if(maps\mp\_utility::func_488D(param_05) && param_01 maps\mp\_utility::_hasperk("specialty_deadeye"))
		{
			param_01 maps\mp\perks\_perkfunctions::func_7013();
		}

		param_03 = maps\mp\perks\_perks::func_1905(param_02,param_01,param_03,param_05,param_06,param_07,param_08,param_09,param_00);
		if(isplayer(param_01) && param_06 == "smoke_grenade_mp" || param_06 == "throwingknife_mp")
		{
			param_01 thread maps\mp\gametypes\_gamelogic::func_8091(param_06,1,"hits");
		}
	}

	if(isdefined(level.modifyplayerdamage))
	{
		param_03 = [[ level.modifyplayerdamage ]](param_02,param_01,param_03,param_05,param_06,param_07,param_08,param_09);
	}

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

	if(var_0C && var_0D)
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
		param_02 resetattackerlist_internal();
	}

	if(maps\mp\_utility::func_48D2(param_06,param_09,param_05,param_01))
	{
		param_05 = "MOD_HEAD_SHOT";
	}

	if(maps\mp\gametypes\_tweakables::func_3C5B("game","onlyheadshots"))
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

	if(param_06 == "destructible_toy" && isdefined(param_00))
	{
		param_06 = "destructible_car";
	}

	if(gettime() < param_02.var_78C4 + level.killstreakspawnshield)
	{
		var_13 = castint(max(param_02.health / 4,1));
		if(param_03 >= var_13 && maps\mp\_utility::func_48F7(param_06) && param_05 != "MOD_MELEE")
		{
			param_03 = var_13;
		}
	}

	if(!param_04 & level.idflags_no_protection)
	{
		if(!level.teambased && var_0C && isdefined(param_01.owner) && param_01.owner == param_02)
		{
			if(param_05 == "MOD_CRUSH")
			{
				param_02 maps\mp\_utility::_suicide();
			}

			return "ffa suicide";
		}

		if((issubstr(param_05,"MOD_GRENADE") || issubstr(param_05,"MOD_EXPLOSIVE") || issubstr(param_05,"MOD_PROJECTILE")) && isdefined(param_00) && isdefined(param_01))
		{
			if(param_02 != param_01 && param_00.classname == "grenade" && param_02.lastspawntime + 3500 > gettime() && isdefined(param_02.lastspawnpoint) && distance(param_00.origin,param_02.lastspawnpoint.origin) < 500)
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
				if((issubstr(param_06,"c4_") || issubstr(param_06,"proximity_explosive_") || issubstr(param_06,"claymore_")) && isdefined(param_00.owner))
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
			if(isplayer(param_01) && param_01 != self && var_0B != "aliens")
			{
				updateinflictorstat(param_00,param_01,param_06);
			}
		}

		if(issubstr(param_05,"MOD_IMPACT") && param_06 == "iw6_rgm_mp")
		{
			if(isplayer(param_01) && param_01 != self && var_0B != "aliens")
			{
				updateinflictorstat(param_00,param_01,param_06);
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

		var_15 = param_02.health / param_02.maxhealth;
		if(var_0D)
		{
			if(!maps\mp\_utility::func_50C1() && isplayer(param_01))
			{
				param_01 maps\mp\_utility::func_447B("mostff",1);
			}

			if(level.friendlyfire == 0 || !isplayer(param_01) && level.friendlyfire != 1 || param_06 == "bomb_site_mp")
			{
				if(param_06 == "artillery_mp" || param_06 == "stealth_bomb_mp")
				{
					param_02 func_2315(param_00,param_06,param_05,param_03,param_04,param_01);
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
					param_03 = maps\mp\perks\_perks::func_1905(param_02,param_01,param_03,param_05,param_06,param_07,param_08,param_09);
				}

				param_02.lastdamagewasfromenemy = 0;
				param_02 func_329F(param_00,param_01,param_03,param_04,param_05,param_06,param_07,param_08,param_09,param_0A,var_0F);
			}
			else if(level.friendlyfire == 2 && maps\mp\_utility::func_4945(param_01))
			{
				param_03 = castint(param_03 * 0.5);
				if(param_03 < 1)
				{
					param_03 = 1;
				}

				param_01.lastdamagewasfromenemy = 0;
				param_01.var_3571 = 1;
				param_01 func_329F(param_00,param_01,param_03,param_04,param_05,param_06,param_07,param_08,param_09,param_0A,var_0F);
				param_01.var_3571 = undefined;
			}
			else if(level.friendlyfire == 3 && maps\mp\_utility::func_4945(param_01))
			{
				param_03 = castint(param_03 * 0.5);
				if(param_03 < 1)
				{
					param_03 = 1;
				}

				param_02.lastdamagewasfromenemy = 0;
				param_01.lastdamagewasfromenemy = 0;
				param_02 func_329F(param_00,param_01,param_03,param_04,param_05,param_06,param_07,param_08,param_09,param_0A,var_0F);
				if(maps\mp\_utility::func_4945(param_01))
				{
					param_01.var_3571 = 1;
					param_01 func_329F(param_00,param_01,param_03,param_04,param_05,param_06,param_07,param_08,param_09,param_0A,var_0F);
					param_01.var_3571 = undefined;
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
				var_16 = gettime();
				param_01.var_2305[param_02.guid] = var_16;
				param_02.lastdamagedtime = var_16;
			}

			param_02 func_329F(param_00,param_01,param_03,param_04,param_05,param_06,param_07,param_08,param_09,param_0A,var_0F);
			if(isdefined(level.ac130player) && isdefined(param_01) && level.ac130player == param_01)
			{
				level notify("ai_pain",param_02);
			}

			param_02 thread maps\mp\gametypes\_missions::func_5F9D(param_00,param_01,param_03,param_05,param_06,param_09);
		}

		if(var_0C && isdefined(param_01.gunner))
		{
			var_17 = param_01.gunner;
		}
		else
		{
			var_17 = param_02;
		}

		if(isdefined(var_17) && var_17 != param_02 && param_03 > 0 && !isdefined(param_09) || param_09 != "shield")
		{
			var_18 = !maps\mp\_utility::func_4945(param_02) || isbot(param_02) && param_03 >= param_02.health;
			if(param_04 & level.idflags_stun)
			{
				var_19 = "stun";
			}
			else if(isexplosivedamagemod(param_06) && isdefined(param_03.thermodebuffed) && param_03.thermodebuffed)
			{
				var_19 = common_scripts\utility::func_803F(var_19,"thermodebuff_kill","thermobaric_debuff");
			}
			else if(isexplosivedamagemod(param_06) && param_03 maps\mp\_utility::_hasperk("_specialty_blastshield") && !maps\mp\_utility::weaponignoresblastshield(param_07))
			{
				var_19 = common_scripts\utility::func_803F(var_19,"hitkillblast","hitblastshield");
			}
			else if(param_03 maps\mp\_utility::_hasperk("specialty_combathigh"))
			{
				var_19 = "hitendgame";
			}
			else if(isdefined(param_03.lightarmorhp) && param_06 != "MOD_HEAD_SHOT" && !maps\mp\_utility::isfmjdamage(param_07,param_06,param_02))
			{
				var_19 = "hitlightarmor";
			}
			else if(maps\mp\perks\_perkfunctions::func_400D(param_03))
			{
				var_19 = "hitlightarmor";
			}
			else if(param_03 maps\mp\_utility::isjuggernaut())
			{
				var_19 = common_scripts\utility::func_803F(var_19,"hitkilljugg","hitjuggernaut");
			}
			else if(param_03 maps\mp\_utility::_hasperk("specialty_moreHealth"))
			{
				var_19 = "hitmorehealth";
			}
			else if(var_18 maps\mp\_utility::_hasperk("specialty_moredamage"))
			{
				var_19 = common_scripts\utility::func_803F(var_19,"hitdeadeyekill","hitcritical");
				var_17 maps\mp\_utility::_unsetperk("specialty_moredamage");
			}
			else if(!func_74D2(param_07))
			{
				var_19 = "none";
			}
			else
			{
				var_19 = common_scripts\utility::func_803F(var_19,"hitkill","standard");
			}

			var_17 thread maps\mp\gametypes\_damagefeedback::func_86E0(var_19);
		}

		maps\mp\gametypes\_gamelogic::func_7049(param_02,1);
	}

	if(isdefined(param_01) && param_01 != param_02 && !var_12)
	{
		level.usestartspawns = 0;
	}

	if(param_03 > 10 && isdefined(param_00) && !param_02 maps\mp\_utility::func_4995() && isplayer(param_02))
	{
		param_02 thread maps\mp\gametypes\_shellshock::func_1503(param_00.origin);
		if(isplayer(param_00) && param_05 == "MOD_MELEE")
		{
			param_00 thread maps\mp\gametypes\_shellshock::func_1504();
		}
	}

	func_4278(param_01,param_02,param_03,param_09,param_04);
	if(isdefined(param_01) && param_01 != param_02)
	{
		if(isplayer(param_01))
		{
			param_01 maps\mp\_utility::func_447B("damagedone",param_03);
		}

		param_02 maps\mp\_utility::func_447B("damagetaken",param_03);
	}

	if(isbot(self))
	{
		self [[ maps/mp/agents/_agent_utility::agentfunc("on_damaged_finished") ]](param_00,param_01,param_03,param_04,param_05,param_06,param_07,param_08,param_09,param_0A);
	}

	return "finished";
}

//Function Number: 32
func_74D2(param_00)
{
	switch(param_00)
	{
		case "stealth_bomb_mp":
		case "artillery_mp":
			return 0;
	}

	return 1;
}

//Function Number: 33
func_1BE0(param_00,param_01,param_02,param_03,param_04)
{
	if(param_04 == "MOD_PISTOL_BULLET" || param_04 == "MOD_RIFLE_BULLET" || param_04 == "MOD_HEAD_SHOT")
	{
		if(distance(param_00.origin,param_01.origin) > 256)
		{
		}

		var_05 = param_00 getvelocity();
		if(lengthsquared(var_05) < 10)
		{
		}

		var_06 = maps\mp\_utility::func_3287(param_00,param_01,25);
		if(var_06)
		{
			param_00 thread func_7D1E();
		}
	}
}

//Function Number: 34
func_7D1E(param_00)
{
	self endon("disconnect");
	self endon("death");
	level endon("game_ended");
	self.instutter = 1;
	self.movespeedscaler = 0.05;
	maps\mp\gametypes\_weapons::func_8707();
	wait(0.5);
	self.movespeedscaler = 1;
	if(maps\mp\_utility::_hasperk("specialty_lightweight"))
	{
		self.movespeedscaler = maps\mp\_utility::func_4E12();
	}

	maps\mp\gametypes\_weapons::func_8707();
	self.instutter = 0;
}

//Function Number: 35
addattacker(param_00,param_01,param_02,param_03,param_04,param_05,param_06,param_07,param_08,param_09)
{
	if(!isdefined(param_00.attackerdata))
	{
		param_00.attackerdata = [];
	}

	if(!isdefined(param_00.attackerdata[param_01.guid]))
	{
		param_00.attackers[param_01.guid] = param_01;
		param_00.attackerdata[param_01.guid] = addstruct();
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

	if(isdefined(param_01) && isplayer(param_01) && param_01 getcurrentprimaryweapon() != "none")
	{
		param_00.attackerdata[param_01.guid].sprimaryweapon = param_01 getcurrentprimaryweapon();
	}

	param_00.attackerdata[param_01.guid].sprimaryweapon = undefined;
}

//Function Number: 36
func_6606(param_00)
{
	self endon("disconnect");
	self endon("death");
	level endon("game_ended");
	wait(1.75);
	resetattackerlist_internal();
}

//Function Number: 37
resetattackerlist_internal()
{
	self.attackers = [];
	self.attackerdata = [];
}

//Function Number: 38
callback_playerdamage(param_00,param_01,param_02,param_03,param_04,param_05,param_06,param_07,param_08,param_09)
{
	var_0A = callback_playerdamage_internal(param_00,param_01,self,param_02,param_03,param_04,param_05,param_06,param_07,param_08,param_09);
}

//Function Number: 39
func_329F(param_00,param_01,param_02,param_03,param_04,param_05,param_06,param_07,param_08,param_09,param_0A)
{
	if((maps\mp\_utility::func_4995() && param_02 >= self.health && !param_03 & level.idflags_stun && allowfauxdeath()) || maps\mp\_utility::isrocketcorpse())
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
		if(!func_1946(param_00,param_01,param_02 - param_02 * param_0A,param_03,param_04,param_05,param_06,param_07,param_08,param_09))
		{
		}

		if(!isalive(self))
		{
		}

		if(isplayer(self))
		{
			self finishplayerdamage(param_00,param_01,param_02,param_03,param_04,param_05,param_06,param_07,param_08,param_09,param_0A);
		}
	}

	if(param_04 == "MOD_EXPLOSIVE_BULLET" && !maps\mp\_utility::func_47BB())
	{
		self shellshock("damage_mp",getdvarfloat("scr_csmode"));
	}

	func_2315(param_00,param_05,param_04,param_02,param_03,param_01);
}

//Function Number: 40
allowfauxdeath()
{
	if(!isdefined(level.allowfauxdeath))
	{
		level.allowfauxdeath = 1;
	}

	return level.allowfauxdeath;
}

//Function Number: 41
callback_playerlaststand(param_00,param_01,param_02,param_03,param_04,param_05,param_06,param_07,param_08)
{
	var_09 = addstruct();
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
	}

	self.var_465B = 1;
	var_0B = addstruct();
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
		var_0B.iconname = "specialty_finalstand";
	}

	var_0B.glowcolor = (1,0,0);
	var_0B.sound = "mp_last_stand";
	var_0B.duration = 2;
	self.health = 1;
	thread maps\mp\gametypes\_hud_message::func_5729(var_0B);
	var_0C = "frag_grenade_mp";
	if(isdefined(level.ac130player) && isdefined(param_01) && level.ac130player == param_01)
	{
		level notify("ai_crawling",self);
	}

	if(maps\mp\_utility::_hasperk("specialty_finalstand"))
	{
		self.laststandparams = var_09;
		self.var_44CB = 1;
		var_0D = self getweaponslistexclusives();
		foreach(var_0F in var_0D)
		{
			self takeweapon(var_0F);
		}

		common_scripts\utility::_disableusability();
		thread enablelaststandweapons();
		thread func_4CB4(20,1);
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
		thread func_4CB4(20,0);
		thread detonateonuse();
		thread func_26E0();
	}

	if(level.diehardmode)
	{
		param_01 maps\mp\gametypes\_rank::giverankxp("kill",100,param_04,param_03);
		self.laststandparams = var_09;
		common_scripts\utility::_disableweapon();
		thread func_4CB4(20,0);
		common_scripts\utility::_disableusability();
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
	thread func_4CB4(10,0);
}

//Function Number: 42
func_2726(param_00)
{
	self endon("death");
	self endon("disconnect");
	self endon("joined_team");
	level endon("game_ended");
	wait(param_00);
	self.uselaststandparams = 1;
	maps\mp\_utility::_suicide();
}

//Function Number: 43
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

//Function Number: 44
func_26E0()
{
	self endon("detonate");
	self endon("disconnect");
	self endon("joined_team");
	level endon("game_ended");
	self waittill("death");
	c4deathdetonate();
}

//Function Number: 45
c4deathdetonate()
{
	self playsound("detpack_explo_default");
	radiusdamage(self.origin,312,100,100,self);
	if(isalive(self))
	{
		maps\mp\_utility::_suicide();
	}
}

//Function Number: 46
enablelaststandweapons()
{
	self endon("death");
	self endon("disconnect");
	level endon("game_ended");
	maps\mp\_utility::func_350E(1);
	wait(0.3);
	maps\mp\_utility::func_350E(0);
}

//Function Number: 47
func_4CB4(param_00,param_01)
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
		thread func_4CA9();
		maps\mp\_utility::setlowermessage("last_stand",&"PLATFORM_COWARDS_WAY_OUT",undefined,undefined,undefined,undefined,undefined,undefined,1);
		thread laststandkeepoverlay();
	}

	if(level.diehardmode == 1 && level.diehardmode != 2)
	{
		var_02 = spawn("script_model",self.origin);
		var_02 setmodel("tag_origin");
		var_02 setcursorhint("HINT_NOICON");
		var_02 sethintstring(&"PLATFORM_REVIVE");
		var_02 func_6699(self);
		var_02 endon("death");
		var_03 = newteamhudelem(self.team);
		var_03 setmaterial("waypoint_revive",8,8);
		var_03 setwaypoint(1,1);
		var_03 settargetent(self);
		var_03 thread func_2658(var_02);
		var_03.color = (0.33,0.75,0.24);
		maps\mp\_utility::func_5D5B();
		if(param_01)
		{
			wait(param_00);
			if(self.var_44CB)
			{
				thread func_4CAB(param_01,var_02);
			}
		}
	}
	else if(level.diehardmode == 2)
	{
		thread laststandkeepoverlay();
		var_02 = spawn("script_model",self.origin);
		var_03 setmodel("tag_origin");
		var_03 setcursorhint("HINT_NOICON");
		var_03 sethintstring(&"PLATFORM_REVIVE");
		var_03 func_6699(self);
		var_03 endon("death");
		var_03 = newteamhudelem(self.team);
		var_03 setmaterial("waypoint_revive",8,8);
		var_03 setwaypoint(1,1);
		var_03 settargetent(self);
		var_03 thread func_2658(var_02);
		var_03.color = (0.33,0.75,0.24);
		maps\mp\_utility::func_5D5B();
		if(param_01)
		{
			wait(param_00);
			if(self.var_44CB)
			{
				thread func_4CAB(param_01,var_02);
			}
		}

		wait(param_00 / 3);
		var_03.color = (1,0.64,0);
		while(var_02.inuse)
		{
			wait(0.05);
		}

		maps\mp\_utility::func_5D5B();
		wait(param_00 / 3);
		var_03.color = (1,0,0);
		while(var_02.inuse)
		{
			wait(0.05);
		}

		maps\mp\_utility::func_5D5B();
		wait(param_00 / 3);
		while(var_02.inuse)
		{
			wait(0.05);
		}

		wait(0.05);
		thread func_4CAB(param_01);
	}

	thread laststandkeepoverlay();
	wait(var_02);
	thread func_4CAB(var_03);
}

//Function Number: 48
func_5104(param_00,param_01)
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

//Function Number: 49
func_4CAB(param_00,param_01)
{
	if(param_00)
	{
		self.laststand = undefined;
		self.var_44CB = 0;
		self notify("revive");
		maps\mp\_utility::func_1D47("last_stand");
		maps\mp\gametypes\_playerlogic::laststandrespawnplayer();
		if(isdefined(param_01))
		{
			param_01 delete();
		}
	}

	self.uselaststandparams = 1;
	self.beingrevived = 0;
	maps\mp\_utility::_suicide();
}

//Function Number: 50
func_4CA9()
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

	thread func_4CAB(0);
}

//Function Number: 51
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

//Function Number: 52
laststandwaittilldeath()
{
	self endon("disconnect");
	self endon("revive");
	level endon("game_ended");
	self waittill("death");
	maps\mp\_utility::func_1D47("last_stand");
	self.laststand = undefined;
}

//Function Number: 53
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

	if(param_01 == "MOD_IMPACT" && maps\mp\gametypes\_weapons::isthrowingknife(param_00))
	{
		return 0;
	}

	if(param_01 == "MOD_IMPACT" && param_00 == "m79_mp" || issubstr(param_00,"gl_"))
	{
		return 0;
	}

	if(maps\mp\_utility::func_48D2(param_00,param_02,param_01))
	{
		return 0;
	}

	if(maps\mp\_utility::func_4995())
	{
		return 0;
	}

	return 1;
}

//Function Number: 54
func_2F3E()
{
	if(!isdefined(self.laststandparams.attacker))
	{
		self.laststandparams.attacker = self;
	}
}

//Function Number: 55
func_3ACC(param_00)
{
	switch(param_00)
	{
		case "neck":
		case "helmet":
		case "head":
			return 60;

		case "left_hand":
		case "right_hand":
		case "left_arm_lower":
		case "right_arm_lower":
		case "left_arm_upper":
		case "right_arm_upper":
		case "torso_upper":
		case "gun":
			return 48;

		case "torso_lower":
			return 40;

		case "left_leg_upper":
		case "right_leg_upper":
			return 32;

		case "left_leg_lower":
		case "right_leg_lower":
			return 10;

		case "left_foot":
		case "right_foot":
			return 5;
	}

	return 48;
}

//Function Number: 56
func_252D(param_00,param_01,param_02,param_03,param_04,param_05)
{
	if(isdefined(param_00))
	{
		var_06 = param_00 getcorpseanim();
		if(animhasnotetrack(var_06,"ignore_ragdoll"))
		{
		}
	}

	if(isdefined(level.noragdollents) && level.noragdollents.size)
	{
		foreach(var_08 in level.noragdollents)
		{
			if(distancesquared(param_00.origin,var_08.origin) < 65536)
			{
			}
		}
	}

	wait(0.2);
	if(!isdefined(param_00))
	{
	}

	if(param_00 isragdoll())
	{
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

//Function Number: 57
func_3B32()
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

//Function Number: 58
func_3B31()
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

//Function Number: 59
func_2315(param_00,param_01,param_02,param_03,param_04,param_05)
{
	thread maps\mp\gametypes\_weapons::onweapondamage(param_00,param_01,param_02,param_03,param_05);
	if(!isai(self))
	{
		self playrumbleonentity("damage_heavy");
	}
}

//Function Number: 60
func_6699(param_00)
{
	var_01 = param_00.team;
	self linkto(param_00,"tag_origin");
	self.owner = param_00;
	self.inuse = 0;
	self makeusable();
	func_8751(var_01);
	thread func_822C(var_01);
	thread revivetriggerthink(var_01);
	thread deleteonreviveordeathordisconnect();
}

//Function Number: 61
deleteonreviveordeathordisconnect()
{
	self endon("death");
	self.owner common_scripts\utility::func_8B2A("death","disconnect");
	self delete();
}

//Function Number: 62
func_8751(param_00)
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

//Function Number: 63
func_822C(param_00)
{
	self endon("death");
	for(;;)
	{
		level waittill("joined_team");
		func_8751(param_00);
	}
}

//Function Number: 64
func_821E(param_00)
{
	self endon("death");
	for(;;)
	{
		level waittill("player_last_stand");
		func_8751(param_00);
	}
}

//Function Number: 65
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
		self.owner maps\mp\_utility::func_350E(1);
		var_02 = func_87BF(var_01);
		self.owner.beingrevived = 0;
		if(!isalive(self.owner))
		{
			self delete();
		}

		self.owner maps\mp\_utility::func_350E(0);
		if(var_02)
		{
			var_01 thread maps\mp\gametypes\_hud_message::func_794D("reviver",maps\mp\gametypes\_rank::func_3BE0("reviver"));
			var_01 thread maps\mp\gametypes\_rank::giverankxp("reviver");
			self.owner.laststand = undefined;
			self.owner maps\mp\_utility::func_1D47("last_stand");
			self.owner.movespeedscaler = 1;
			if(self.owner maps\mp\_utility::_hasperk("specialty_lightweight"))
			{
				self.owner.movespeedscaler = maps\mp\_utility::func_4E12();
			}

			self.owner common_scripts\utility::_enableweapon();
			self.owner.maxhealth = 100;
			self.owner maps\mp\gametypes\_weapons::func_8707();
			self.owner maps\mp\gametypes\_playerlogic::laststandrespawnplayer();
			self.owner maps\mp\_utility::func_3CFB("specialty_pistoldeath",0);
			self.owner.beingrevived = 0;
			self delete();
		}

		self makeusable();
		func_8751(param_00);
	}
}

//Function Number: 66
func_87BF(param_00,param_01)
{
	var_02 = 3000;
	var_03 = spawn("script_origin",self.origin);
	var_03 hide();
	param_00 playerlinkto(var_03);
	param_00 playerlinkedoffsetenable();
	param_00 common_scripts\utility::_disableweapon();
	self.curprogress = 0;
	self.inuse = 1;
	self.userate = 0;
	if(isdefined(param_01))
	{
		self.usetime = param_01;
	}
	else
	{
		self.usetime = var_02;
	}

	var_04 = useholdthinkloop(param_00);
	self.inuse = 0;
	var_03 delete();
	if(isdefined(param_00) && maps\mp\_utility::func_4945(param_00))
	{
		param_00 unlink();
		param_00 common_scripts\utility::_enableweapon();
	}

	if(isdefined(var_04) && var_04)
	{
		self.owner thread maps\mp\gametypes\_hud_message::func_5F9A("revived",param_00);
		self.owner.var_465B = 0;
		return 1;
	}

	return 0;
}

//Function Number: 67
useholdthinkloop(param_00)
{
	level endon("game_ended");
	self.owner endon("death");
	self.owner endon("disconnect");
	while(maps\mp\_utility::func_4945(param_00) && param_00 usebuttonpressed() && self.curprogress < self.usetime && !isdefined(param_00.laststand) || !param_00.laststand)
	{
		self.curprogress = self.curprogress + 50 * self.userate;
		self.userate = 1;
		param_00 maps\mp\gametypes\_gameobjects::func_874E(self,1);
		self.owner maps\mp\gametypes\_gameobjects::func_874E(self,1);
		if(self.curprogress >= self.usetime)
		{
			self.inuse = 0;
			param_00 maps\mp\gametypes\_gameobjects::func_874E(self,0);
			self.owner maps\mp\gametypes\_gameobjects::func_874E(self,0);
			return maps\mp\_utility::func_4945(param_00);
		}

		wait(0.05);
	}

	param_00 maps\mp\gametypes\_gameobjects::func_874E(self,0);
	self.owner maps\mp\gametypes\_gameobjects::func_874E(self,0);
	return 0;
}

//Function Number: 68
func_1946(param_00,param_01,param_02,param_03,param_04,param_05,param_06,param_07,param_08,param_09)
{
	if(isdefined(self.lastdamagewasfromenemy) && self.lastdamagewasfromenemy && param_02 >= self.health && isdefined(self.combathigh) && self.combathigh == "specialty_endgame")
	{
		maps\mp\_utility::func_3CFB("specialty_endgame",0);
		return 0;
	}

	return 1;
}

//Function Number: 69
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

//Function Number: 70
func_48C2(param_00,param_01)
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

//Function Number: 71
func_2658(param_00)
{
	param_00 waittill("death");
	self destroy();
}

//Function Number: 72
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
			param_01.health = castint(min(castfloat(param_01.maxhealth),castfloat(param_01.health + 20)));
		}
	}

	return param_02;
}

//Function Number: 73
func_646C(param_00,param_01)
{
	thread maps\mp\killstreaks\_killstreaks::func_3CDB("kill");
	self.pers["cur_kill_streak"]++;
	if(param_01)
	{
		self notify("kill_streak_increased");
	}

	var_02 = !maps\mp\_utility::func_48F7(param_00);
	if(var_02)
	{
		self.pers["cur_kill_streak_for_nuke"]++;
	}

	var_03 = 25;
	if(maps\mp\_utility::_hasperk("specialty_hardline"))
	{
		var_03--;
	}

	if(var_02 && self.pers["cur_kill_streak_for_nuke"] == var_03 && !maps\mp\_utility::isanymlgmatch())
	{
		if(!isdefined(level.supportnuke) || level.supportnuke)
		{
			giveultimatekillstreak(var_03);
		}
	}
}

//Function Number: 74
giveultimatekillstreak(param_00)
{
	thread maps\mp\killstreaks\_killstreaks::func_3CF2("nuke",0,1,self);
	thread maps\mp\gametypes\_hud_message::func_4B46("nuke",param_00);
}

//Function Number: 75
func_537B(param_00,param_01,param_02,param_03,param_04,param_05)
{
	self endon("death");
	level endon("game_ended");
	if(!isdefined(param_05))
	{
		param_05 = 0;
	}

	self setcandamage(1);
	self.health = 999999;
	self.maxhealth = param_00;
	self.damagetaken = 0;
	if(!isdefined(param_04))
	{
		param_04 = 0;
	}

	for(var_06 = 1;var_06;var_06 = func_537C(var_07,var_08,var_09,var_0A,var_0B,var_0C,var_0D,var_0E,var_0F,var_10,param_01,param_02,param_03,param_04))
	{
		self waittill("damage",var_07,var_08,var_09,var_0A,var_0B,var_0C,var_0D,var_0E,var_0F,var_10);
		if(param_05)
		{
			self playrumbleonentity("damage_light");
		}

		if(isdefined(self.helitype) && self.helitype == "littlebird")
		{
			if(!isdefined(self.attackers))
			{
				self.attackers = [];
			}

			var_11 = "";
			if(isdefined(var_08) && isplayer(var_08))
			{
				var_11 = var_08 maps\mp\_utility::getuniqueid();
			}

			if(isdefined(self.attackers[var_11]))
			{
				self.attackers[var_11] = self.attackers[var_11] + var_07;
			}
			else
			{
				self.attackers[var_11] = var_07;
			}
		}
	}
}

//Function Number: 76
func_537C(param_00,param_01,param_02,param_03,param_04,param_05,param_06,param_07,param_08,param_09,param_0A,param_0B,param_0C,param_0D)
{
	if(!isdefined(self))
	{
		return 0;
	}

	if(isdefined(param_01) && !maps\mp\_utility::func_48CE(param_01) && !isdefined(param_01.allowmonitoreddamage))
	{
		return 1;
	}

	if(maps\mp\_utility::func_47BB() || isdefined(param_01) && !maps\mp\gametypes\_weapons::func_357F(self.owner,param_01))
	{
		return 1;
	}

	var_0E = param_00;
	if(isdefined(param_09))
	{
		switch(param_09)
		{
			case "concussion_grenade_mp":
			case "smoke_grenadejugg_mp":
			case "smoke_grenade_mp":
			case "flash_grenade_mp":
				return 1;
		}

		if(!isdefined(param_0C))
		{
			param_0C = ::modifydamage;
		}

		var_0E = [[ param_0C ]](param_01,param_09,param_04,param_00);
	}

	if(var_0E < 0)
	{
		return 1;
	}

	self.wasdamaged = 1;
	self.damagetaken = self.damagetaken + var_0E;
	if(isdefined(param_08) && param_08 & level.idflags_penetration)
	{
		self.wasdamagedfrombulletpenetration = 1;
	}

	if(param_0D)
	{
		maps\mp\killstreaks\_killstreaks::func_4B39(param_01,param_09,self);
	}

	if(isdefined(param_01))
	{
		if(isplayer(param_01))
		{
			if(self.damagetaken >= self.maxhealth)
			{
				param_0A = "hitkill";
			}

			param_01 maps\mp\gametypes\_damagefeedback::func_86E0(param_0A);
		}
		else if(isdefined(param_01.owner) && isplayer(param_01.owner))
		{
			param_01.owner maps\mp\gametypes\_damagefeedback::func_86E0(param_0A);
		}
	}

	if(self.damagetaken >= self.maxhealth)
	{
		self thread [[ param_0B ]](param_01,param_09,param_04,param_00);
		return 0;
	}

	return 1;
}

//Function Number: 77
modifydamage(param_00,param_01,param_02,param_03)
{
	var_04 = param_03;
	var_04 = handleempdamage(param_01,param_02,var_04);
	var_04 = func_3F8A(param_01,param_02,var_04);
	var_04 = handlegrenadedamage(param_01,param_02,var_04);
	var_04 = handleapdamage(param_01,param_02,var_04,param_00);
	return var_04;
}

//Function Number: 78
func_3F8A(param_00,param_01,param_02)
{
	var_03 = param_02;
	switch(param_00)
	{
		case "maverick_projectile_mp":
		case "ac130_40mm_mp":
		case "ac130_105mm_mp":
		case "aamissile_projectile_mp":
		case "odin_projectile_small_rod_mp":
		case "odin_projectile_large_rod_mp":
		case "drone_hive_projectile_mp":
		case "iw6_panzerfaust3_mp":
		case "iw6_maaws_mp":
		case "iw6_maawshoming_mp":
		case "iw6_maawschild_mp":
		case "bomb_site_mp":
			self.largeprojectiledamage = 1;
			var_03 = self.maxhealth + 1;
			break;

		case "hind_missile_mp":
		case "hind_bomb_mp":
		case "switch_blade_child_mp":
		case "remote_tank_projectile_mp":
			self.largeprojectiledamage = 0;
			var_03 = self.maxhealth + 1;
			break;

		case "a10_30mm_turret_mp":
		case "heli_pilot_turret_mp":
			self.largeprojectiledamage = 0;
			var_03 = var_03 * 2;
			break;

		case "sam_projectile_mp":
			self.largeprojectiledamage = 1;
			var_03 = param_02;
			break;
	}

	return var_03;
}

//Function Number: 79
handlegrenadedamage(param_00,param_01,param_02)
{
	if(isexplosivedamagemod(param_01))
	{
		switch(param_00)
		{
			case "iw6_rgm_mp":
			case "proximity_explosive_mp":
			case "c4_mp":
			case "mortar_shell_mp":
				param_02 = param_02 * 3;
				break;

			case "iw6_mk32_mp":
			case "semtexproj_mp":
			case "semtex_mp":
			case "frag_grenade_mp":
				param_02 = param_02 * 4;
				break;

			default:
				if(maps\mp\_utility::func_4971(param_00,"alt_"))
				{
					param_02 = param_02 * 3;
				}
				break;
		}
	}

	return param_02;
}

//Function Number: 80
handlemeleedamage(param_00,param_01,param_02)
{
	if(param_01 == "MOD_MELEE")
	{
		return self.maxhealth + 1;
	}

	return param_02;
}

//Function Number: 81
handleempdamage(param_00,param_01,param_02)
{
	if(param_00 == "emp_grenade_mp" && param_01 == "MOD_GRENADE_SPLASH")
	{
		self notify("emp_damage",param_00.owner,8);
		return 0;
	}

	return param_02;
}

//Function Number: 82
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

//Function Number: 83
onkillstreakkilled(param_00,param_01,param_02,param_03,param_04,param_05,param_06)
{
	var_07 = 0;
	var_08 = undefined;
	if(isdefined(param_00) && isdefined(self.owner))
	{
		if(isdefined(param_00.owner) && isplayer(param_00.owner))
		{
			param_00 = param_00.owner;
		}

		if(self.owner maps\mp\_utility::isenemy(param_00))
		{
			var_08 = param_00;
		}
	}

	if(isdefined(var_08))
	{
		var_08 notify("destroyed_killstreak",param_01);
		var_09 = 100;
		if(isdefined(param_04))
		{
			var_09 = maps\mp\gametypes\_rank::func_3BE0(param_04);
			var_08 thread maps\mp\gametypes\_rank::func_8E6E(param_04);
		}

		var_08 thread maps\mp\gametypes\_rank::giverankxp("kill",var_09,param_01,param_02);
		if(isdefined(param_06))
		{
			thread maps\mp\_utility::func_7FA0(param_06,var_08);
		}

		thread maps\mp\gametypes\_missions::func_4B3C(self.owner,self,undefined,var_08,param_03,param_02,param_01);
		var_07 = 1;
	}

	if(isdefined(self.owner) && isdefined(param_05))
	{
		self.owner thread maps\mp\_utility::func_4D35(param_05,undefined,undefined,self.origin);
	}

	self notify("death");
	return var_07;
}