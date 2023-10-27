/*******************************************************************
 * Decompiled By: Bog
 * Decompiled File: maps\mp\gametypes_zm\_globallogic_score.gsc
 * Game: Call of Duty: Black Ops 2
 * Platform: PC
 * Function Count: 50
 * Decompile Time: 217 ms
 * Timestamp: 10/27/2023 3:02:34 AM
*******************************************************************/

#include common_scripts/utility;
#include maps/mp/_bb;
#include maps/mp/_challenges;
#include maps/mp/_utility;
#include maps/mp/gametypes_zm/_globallogic;
#include maps/mp/gametypes_zm/_globallogic_audio;
#include maps/mp/gametypes_zm/_globallogic_score;
#include maps/mp/gametypes_zm/_globallogic_utils;

//Function Number: 1
updatematchbonusscores(winner)
{
}

//Function Number: 2
givematchbonus(scoretype,score)
{
}

//Function Number: 3
doskillupdate(winner)
{
	skillupdate(winner,level.teambased);
}

//Function Number: 4
gethighestscoringplayer()
{
	players = level.players;
	winner = undefined;
	tie = 0;
	for(i = 0;i < players.size;i++)
	{
		if(!(IsDefined(players[i].score)))
		{
		}
		else if(players[i].score < 1)
		{
		}
		else if(!IsDefined(winner) || players[i].score > winner.score)
		{
			winner = players[i];
			tie = 0;
		}
		else if(players[i].score == winner.score)
		{
			tie = 1;
		}
	}

	if(tie || !IsDefined(winner))
	{
		return undefined;
	}
	else
	{
		return winner;
	}
}

//Function Number: 5
resetscorechain()
{
	self notify("reset_score_chain");
	self.scorechain = 0;
	self.rankupdatetotal = 0;
}

//Function Number: 6
scorechaintimer()
{
	self notify("score_chain_timer");
	self endon("reset_score_chain");
	self endon("score_chain_timer");
	self endon("death");
	self endon("disconnect");
	wait(20);
	self thread resetscorechain();
}

//Function Number: 7
roundtonearestfive(score)
{
	rounding = score % 5;
	if(rounding <= 2)
	{
		return score - rounding;
	}
	else
	{
		return score + 5 - rounding;
	}
}

//Function Number: 8
giveplayermomentumnotification(score,label,descvalue,countstowardrampage)
{
	rampagebonus = 0;
	if(IsDefined(level.usingrampage) && level.usingrampage)
	{
		if(countstowardrampage)
		{
			if(!(IsDefined(self.scorechain)))
			{
				self.scorechain = 0;
			}

			self.scorechain++;
			self thread scorechaintimer();
		}

		if(IsDefined(self.scorechain) && self.scorechain >= 999)
		{
			rampagebonus = roundtonearestfive(int(score * level.rampagebonusscale + 0.5));
		}
	}

	if(score != 0)
	{
		self luinotifyevent(&"score_event",3,label,score,rampagebonus);
	}

	score = score + rampagebonus;
	if(score > 0 && self hasperk("specialty_earnmoremomentum"))
	{
		score = roundtonearestfive(int(score * GetDvarFloat(#"37067E05") + 0.5));
	}

	_setplayermomentum(self,self.pers["momentum"] + score);
}

//Function Number: 9
resetplayermomentumondeath()
{
	if(IsDefined(level.usingscorestreaks) && level.usingscorestreaks)
	{
		_setplayermomentum(self,0);
		self thread resetscorechain();
	}
}

//Function Number: 10
giveplayermomentum(event,player,victim,weapon,descvalue)
{
}

//Function Number: 11
giveplayerscore(event,player,victim,weapon,descvalue)
{
	scorediff = 0;
	momentum = player.pers["momentum"];
	giveplayermomentum(event,player,victim,weapon,descvalue);
	newmomentum = player.pers["momentum"];
	if(level.overrideplayerscore)
	{
		return 0;
	}

	pixbeginevent("level.onPlayerScore");
	score = player.pers["score"];
	[[ level.onplayerscore ]](event,player,victim);
	newscore = player.pers["score"];
	pixendevent();
	bbprint("mpplayerscore","spawnid %d gametime %d type %s player %s delta %d deltamomentum %d team %s",getplayerspawnid(player),GetTime(),event,player.name,newscore - score,newmomentum - momentum,player.team);
	player maps/mp/_bb::bbaddtostat("score",newscore - score);
	if(score == newscore)
	{
		return 0;
	}

	pixbeginevent("givePlayerScore");
	recordplayerstats(player,"score",newscore);
	scorediff = newscore - score;
	player addplayerstatwithgametype("score",scorediff);
	if(IsDefined(player.pers["lastHighestScore"]) && newscore > player.pers["lastHighestScore"])
	{
		player setdstat("HighestStats","highest_score",newscore);
	}

	pixendevent();
	return scorediff;
}

//Function Number: 12
default_onplayerscore(event,player,victim)
{
}

//Function Number: 13
_setplayerscore(player,score)
{
}

//Function Number: 14
_getplayerscore(player)
{
	return player.pers["score"];
}

//Function Number: 15
_setplayermomentum(player,momentum)
{
	momentum = clamp(momentum,0,2000);
	oldmomentum = player.pers["momentum"];
	if(momentum == oldmomentum)
	{
		return;
	}

	player maps/mp/_bb::bbaddtostat("momentum",momentum - oldmomentum);
	if(momentum > oldmomentum)
	{
		highestmomentumcost = 0;
		numkillstreaks = player.killstreak.size;
		killstreaktypearray = [];
	}

	player.pers["momentum"] = momentum;
	player.momentum = player.pers["momentum"];
}

//Function Number: 16
_giveplayerkillstreakinternal(player,momentum,oldmomentum,killstreaktypearray)
{
}

//Function Number: 17
setplayermomentumdebug()
{
/#
	setdvar("sv_momentumPercent",0);
	for(;;)
	{
		wait(1);
		momentumpercent = getdvarfloatdefault("sv_momentumPercent",0);
		player = gethostplayer();
		return;
		_setplayermomentum(player,int(2000 * momentumpercent / 100));
	}
IsDefined(player.killstreak)
IsDefined(player)
momentumpercent != 0
1
#/
}

//Function Number: 18
giveteamscore(event,team,player,victim)
{
	if(level.overrideteamscore)
	{
		return;
	}

	pixbeginevent("level.onTeamScore");
	teamscore = game["teamScores"][team];
	[[ level.onteamscore ]](event,team);
	pixendevent();
	newscore = game["teamScores"][team];
	bbprint("mpteamscores","gametime %d event %s team %d diff %d score %d",GetTime(),event,team,newscore - teamscore,newscore);
	if(teamscore == newscore)
	{
		return;
	}

	updateteamscores(team);
	thread maps/mp/gametypes_zm/_globallogic::checkscorelimit();
}

//Function Number: 19
giveteamscoreforobjective(team,score)
{
	teamscore = game["teamScores"][team];
	onteamscore(score,team);
	newscore = game["teamScores"][team];
	bbprint("mpteamobjscores","gametime %d  team %d diff %d score %d",GetTime(),team,newscore - teamscore,newscore);
	if(teamscore == newscore)
	{
		return;
	}

	updateteamscores(team);
	thread maps/mp/gametypes_zm/_globallogic::checkscorelimit();
}

//Function Number: 20
_setteamscore(team,teamscore)
{
	if(teamscore == game["teamScores"][team])
	{
		return;
	}

	game["teamScores"][team] = teamscore;
	updateteamscores(team);
	thread maps/mp/gametypes_zm/_globallogic::checkscorelimit();
}

//Function Number: 21
resetteamscores()
{
	if(!IsDefined(level.roundscorecarry) || level.roundscorecarry == 0 || maps/mp/_utility::isfirstround())
	{
		foreach(team in level.teams)
		{
			game["teamScores"][team] = 0;
		}
	}

	maps/mp/gametypes_zm/_globallogic_score::updateallteamscores();
}

//Function Number: 22
resetallscores()
{
	resetteamscores();
	resetplayerscores();
}

//Function Number: 23
resetplayerscores()
{
	players = level.players;
	winner = undefined;
	tie = 0;
	for(i = 0;i < players.size;i++)
	{
		if(IsDefined(players[i].pers["score"]))
		{
			_setplayerscore(players[i],0);
		}
	}
}

//Function Number: 24
updateteamscores(team)
{
	setteamscore(team,game["teamScores"][team]);
	level thread maps/mp/gametypes_zm/_globallogic::checkteamscorelimitsoon(team);
}

//Function Number: 25
updateallteamscores()
{
	foreach(team in level.teams)
	{
		updateteamscores(team);
	}
}

//Function Number: 26
_getteamscore(team)
{
	return game["teamScores"][team];
}

//Function Number: 27
gethighestteamscoreteam()
{
	score = 0;
	winning_teams = [];
	foreach(team in level.teams)
	{
		team_score = game["teamScores"][team];
		if(team_score > score)
		{
			score = team_score;
			winning_teams = [];
		}

		if(team_score == score)
		{
			winning_teams[team] = team;
		}
	}

	return winning_teams;
}

//Function Number: 28
areteamarraysequal(teamsa,teamsb)
{
	if(teamsa.size != teamsb.size)
	{
		return 0;
	}

	foreach(team in teamsa)
	{
		if(!(IsDefined(teamsb[team])))
		{
			return 0;
		}
	}

	return 1;
}

//Function Number: 29
onteamscore(score,team)
{
	game["teamScores"][team] = game["teamScores"][team] + score;
	if(level.scorelimit && game["teamScores"][team] > level.scorelimit)
	{
		game["teamScores"][team] = level.scorelimit;
	}

	if(level.splitscreen)
	{
		return;
	}

	if(level.scorelimit == 1)
	{
		return;
	}

	iswinning = gethighestteamscoreteam();
	if(iswinning.size == 0)
	{
		return;
	}

	if(GetTime() - level.laststatustime < 5000)
	{
		return;
	}

	if(areteamarraysequal(iswinning,level.waswinning))
	{
		return;
	}

	level.laststatustime = GetTime();
	if(iswinning.size == 1)
	{
		foreach(team in iswinning)
		{
			if(IsDefined(level.waswinning[team]))
			{
				if(level.waswinning.size == 1)
				{
				}
				else
				{
					maps/mp/gametypes_zm/_globallogic_audio::leaderdialog("lead_taken",team,"status");
				}
			}
		}
	}

	if(level.waswinning.size == 1)
	{
		foreach(team in level.waswinning)
		{
			if(IsDefined(iswinning[team]))
			{
				if(iswinning.size == 1)
				{
				}
				else if(level.waswinning.size > 1)
				{
				}
				else
				{
					maps/mp/gametypes_zm/_globallogic_audio::leaderdialog("lead_lost",team,"status");
				}
			}
		}
	}

	level.waswinning = iswinning;
}

//Function Number: 30
default_onteamscore(event,team)
{
}

//Function Number: 31
initpersstat(dataname,record_stats,init_to_stat_value)
{
	if(!(IsDefined(self.pers[dataname])))
	{
		self.pers[dataname] = 0;
	}

	if(!IsDefined(record_stats) || record_stats == 1)
	{
		recordplayerstats(self,dataname,int(self.pers[dataname]));
	}

	if(IsDefined(init_to_stat_value) && init_to_stat_value == 1)
	{
		self.pers[dataname] = self getdstat("PlayerStatsList",dataname,"StatValue");
	}
}

//Function Number: 32
getpersstat(dataname)
{
	return self.pers[dataname];
}

//Function Number: 33
incpersstat(dataname,increment,record_stats,includegametype)
{
	pixbeginevent("incPersStat");
	self.pers[dataname] = self.pers[dataname] + increment;
	if(IsDefined(includegametype) && includegametype)
	{
		self addplayerstatwithgametype(dataname,increment);
	}
	else
	{
		self addplayerstat(dataname,increment);
	}

	if(!IsDefined(record_stats) || record_stats == 1)
	{
		self thread threadedrecordplayerstats(dataname);
	}

	pixendevent();
}

//Function Number: 34
threadedrecordplayerstats(dataname)
{
	self endon("disconnect");
	waittillframeend;
	recordplayerstats(self,dataname,self.pers[dataname]);
}

//Function Number: 35
updatewinstats(winner)
{
}

//Function Number: 36
updatelossstats(loser)
{
	loser addplayerstatwithgametype("losses",1);
	loser updatestatratio("wlratio","wins","losses");
	loser notify("loss");
}

//Function Number: 37
updatetiestats(loser)
{
	loser addplayerstatwithgametype("losses",-1);
	loser addplayerstatwithgametype("ties",1);
	loser updatestatratio("wlratio","wins","losses");
	loser setdstat("playerstatslist","cur_win_streak","StatValue",0);
	loser notify("tie");
}

//Function Number: 38
updatewinlossstats(winner)
{
	if(!waslastround() && !level.hostforcedend)
	{
		return;
	}

	players = level.players;
	if(!IsDefined(winner) || IsDefined(winner) && !isplayer(winner) && winner == "tie")
	{
		for(i = 0;i < players.size;i++)
		{
			if(!(IsDefined(players[i].pers["team"])))
			{
			}
			else if(level.hostforcedend && players[i] ishost())
			{
			}
			else
			{
				updatetiestats(players[i]);
			}
		}
	}
	else if(isplayer(winner))
	{
		if(level.hostforcedend && winner ishost())
		{
			return;
		}

		updatewinstats(winner);
	}
	else
	{
		for(i = 0;i < players.size;i++)
		{
			if(!(IsDefined(players[i].pers["team"])))
			{
			}
			else if(level.hostforcedend && players[i] ishost())
			{
			}
			else if(winner == "tie")
			{
				updatetiestats(players[i]);
			}
			else if(players[i].pers["team"] == winner)
			{
				updatewinstats(players[i]);
			}
			else
			{
				players[i] setdstat("playerstatslist","cur_win_streak","StatValue",0);
			}
		}
	}
}

//Function Number: 39
backupandclearwinstreaks()
{
}

//Function Number: 40
restorewinstreaks(winner)
{
}

//Function Number: 41
inckillstreaktracker(sweapon)
{
	self endon("disconnect");
	waittillframeend;
	if(sweapon == "artillery_mp")
	{
		self.pers["artillery_kills"]++;
	}

	if(sweapon == "dog_bite_mp")
	{
		self.pers["dog_kills"]++;
	}
}

//Function Number: 42
trackattackerkill(name,rank,xp,prestige,xuid)
{
	self endon("disconnect");
	attacker = self;
	waittillframeend;
	pixbeginevent("trackAttackerKill");
	if(!(IsDefined(attacker.pers["killed_players"][name])))
	{
		attacker.pers["killed_players"][name] = 0;
	}

	if(!(IsDefined(attacker.killedplayerscurrent[name])))
	{
		attacker.killedplayerscurrent[name] = 0;
	}

	if(!(IsDefined(attacker.pers["nemesis_tracking"][name])))
	{
		attacker.pers["nemesis_tracking"][name] = 0;
	}

	attacker.pers["killed_players"][name]++;
	attacker.killedplayerscurrent[name]++;
	attacker.pers["nemesis_tracking"][name] = attacker.pers["nemesis_tracking"][name] + 1;
	if(attacker.pers["nemesis_name"] == name)
	{
		attacker maps/mp/_challenges::killednemesis();
	}

	if(attacker.pers["nemesis_name"] == "" || attacker.pers["nemesis_tracking"][name] > attacker.pers["nemesis_tracking"][attacker.pers["nemesis_name"]])
	{
		attacker.pers["nemesis_name"] = name;
		attacker.pers["nemesis_rank"] = rank;
		attacker.pers["nemesis_rankIcon"] = prestige;
		attacker.pers["nemesis_xp"] = xp;
		attacker.pers["nemesis_xuid"] = xuid;
	}
	else if(IsDefined(attacker.pers["nemesis_name"]) && attacker.pers["nemesis_name"] == name)
	{
		attacker.pers["nemesis_rank"] = rank;
		attacker.pers["nemesis_xp"] = xp;
	}

	pixendevent();
}

//Function Number: 43
trackattackeedeath(attackername,rank,xp,prestige,xuid)
{
	self endon("disconnect");
	waittillframeend;
	pixbeginevent("trackAttackeeDeath");
	if(!(IsDefined(self.pers["killed_by"][attackername])))
	{
		self.pers["killed_by"][attackername] = 0;
	}

	self.pers["killed_by"][attackername]++;
	if(!(IsDefined(self.pers["nemesis_tracking"][attackername])))
	{
		self.pers["nemesis_tracking"][attackername] = 0;
	}

	self.pers["nemesis_tracking"][attackername] = self.pers["nemesis_tracking"][attackername] + 1.5;
	if(self.pers["nemesis_name"] == "" || self.pers["nemesis_tracking"][attackername] > self.pers["nemesis_tracking"][self.pers["nemesis_name"]])
	{
		self.pers["nemesis_name"] = attackername;
		self.pers["nemesis_rank"] = rank;
		self.pers["nemesis_rankIcon"] = prestige;
		self.pers["nemesis_xp"] = xp;
		self.pers["nemesis_xuid"] = xuid;
	}
	else if(IsDefined(self.pers["nemesis_name"]) && self.pers["nemesis_name"] == attackername)
	{
		self.pers["nemesis_rank"] = rank;
		self.pers["nemesis_xp"] = xp;
	}

	if(self.pers["nemesis_name"] == attackername && self.pers["nemesis_tracking"][attackername] >= 2)
	{
		self setclientuivisibilityflag("killcam_nemesis",1);
	}
	else
	{
		self setclientuivisibilityflag("killcam_nemesis",0);
	}

	pixendevent();
}

//Function Number: 44
default_iskillboosting()
{
	return 0;
}

//Function Number: 45
givekillstats(smeansofdeath,sweapon,evictim)
{
	self endon("disconnect");
	waittillframeend;
	if(level.rankedmatch && self [[ level.iskillboosting ]]())
	{
/#
		self iprintlnbold("GAMETYPE DEBUG: NOT GIVING YOU OFFENSIVE CREDIT AS BOOSTING PREVENTION");
#/
		return;
	}

	pixbeginevent("giveKillStats");
	self maps/mp/gametypes_zm/_globallogic_score::incpersstat("kills",1,1,1);
	self.kills = self maps/mp/gametypes_zm/_globallogic_score::getpersstat("kills");
	self updatestatratio("kdratio","kills","deaths");
	attacker = self;
	if(smeansofdeath == "MOD_HEAD_SHOT")
	{
		attacker thread incpersstat("headshots",1,1,0);
		attacker.headshots = attacker.pers["headshots"];
		evictim recordkillmodifier("headshot");
	}

	pixendevent();
}

//Function Number: 46
inctotalkills(team)
{
	if(level.teambased && IsDefined(level.teams[team]))
	{
		game["totalKillsTeam"][team]++;
	}

	game["totalKills"]++;
}

//Function Number: 47
setinflictorstat(einflictor,eattacker,sweapon)
{
	if(!(IsDefined(eattacker)))
	{
		return;
	}

	if(!(IsDefined(einflictor)))
	{
		eattacker addweaponstat(sweapon,"hits",1);
		return;
	}

	if(!(IsDefined(einflictor.playeraffectedarray)))
	{
		einflictor.playeraffectedarray = [];
	}

	foundnewplayer = 1;
	for(i = 0;i < einflictor.playeraffectedarray.size;i++)
	{
		if(einflictor.playeraffectedarray[i] == self)
		{
			foundnewplayer = 0;
			break;
		}
	}

	if(foundnewplayer)
	{
		einflictor.playeraffectedarray[einflictor.playeraffectedarray.size] = self;
		if(sweapon == "concussion_grenade_mp" || sweapon == "tabun_gas_mp")
		{
			eattacker addweaponstat(sweapon,"used",1);
		}

		eattacker addweaponstat(sweapon,"hits",1);
	}
}

//Function Number: 48
processshieldassist(killedplayer)
{
	self endon("disconnect");
	killedplayer endon("disconnect");
	wait(0.05);
	maps/mp/gametypes_zm/_globallogic_utils::waittillslowprocessallowed();
	if(!(IsDefined(level.teams[self.pers["team"]])))
	{
		return;
	}

	if(self.pers["team"] == killedplayer.pers["team"])
	{
		return;
	}

	if(!(level.teambased))
	{
		return;
	}

	self maps/mp/gametypes_zm/_globallogic_score::incpersstat("assists",1,1,1);
	self.assists = self maps/mp/gametypes_zm/_globallogic_score::getpersstat("assists");
}

//Function Number: 49
processassist(killedplayer,damagedone,weapon)
{
	self endon("disconnect");
	killedplayer endon("disconnect");
	wait(0.05);
	maps/mp/gametypes_zm/_globallogic_utils::waittillslowprocessallowed();
	if(!(IsDefined(level.teams[self.pers["team"]])))
	{
		return;
	}

	if(self.pers["team"] == killedplayer.pers["team"])
	{
		return;
	}

	if(!(level.teambased))
	{
		return;
	}

	assist_level = "assist";
	assist_level_value = int(ceil(damagedone / 25));
	if(assist_level_value < 1)
	{
		assist_level_value = 1;
	}
	else if(assist_level_value > 3)
	{
		assist_level_value = 3;
	}

	assist_level = assist_level + "_" + assist_level_value * 25;
	self maps/mp/gametypes_zm/_globallogic_score::incpersstat("assists",1,1,1);
	self.assists = self maps/mp/gametypes_zm/_globallogic_score::getpersstat("assists");
	switch(weapon)
	{
		case "concussion_grenade_mp":
			assist_level = "assist_concussion";
			break;

		case "flash_grenade_mp":
			assist_level = "assist_flash";
			break;

		case "emp_grenade_mp":
			assist_level = "assist_emp";
			break;

		case "proximity_grenade_aoe_mp":
		case "proximity_grenade_mp":
			assist_level = "assist_proximity";
			break;
	}

	self maps/mp/_challenges::assisted();
}

//Function Number: 50
xpratethread()
{
/#
#/
}