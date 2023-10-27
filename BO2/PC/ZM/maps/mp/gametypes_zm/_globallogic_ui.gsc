/*******************************************************************
 * Decompiled By: Bog
 * Decompiled File: maps\mp\gametypes_zm\_globallogic_ui.gsc
 * Game: Call of Duty: Black Ops 2
 * Platform: PC
 * Function Count: 21
 * Decompile Time: 88 ms
 * Timestamp: 10/27/2023 3:02:35 AM
*******************************************************************/

#include maps/mp/_utility;
#include maps/mp/gametypes_zm/_globallogic;
#include maps/mp/gametypes_zm/_globallogic_player;
#include maps/mp/gametypes_zm/_hud_util;
#include maps/mp/gametypes_zm/_spectating;

//Function Number: 1
init()
{
	precachestring(&"MP_HALFTIME");
	precachestring(&"MP_OVERTIME");
	precachestring(&"MP_ROUNDEND");
	precachestring(&"MP_INTERMISSION");
	precachestring(&"MP_SWITCHING_SIDES_CAPS");
	precachestring(&"MP_FRIENDLY_FIRE_WILL_NOT");
	precachestring(&"MP_RAMPAGE");
	precachestring(&"medal_received");
	precachestring(&"killstreak_received");
	precachestring(&"prox_grenade_notify");
	precachestring(&"player_callout");
	precachestring(&"score_event");
	precachestring(&"rank_up");
	precachestring(&"gun_level_complete");
	precachestring(&"challenge_complete");
	if(sessionmodeiszombiesgame())
	{
		precachestring(&"hud_update_survival_team");
	}

	if(level.splitscreen)
	{
		precachestring(&"MP_ENDED_GAME");
	}
	else
	{
		precachestring(&"MP_HOST_ENDED_GAME");
	}
}

//Function Number: 2
setupcallbacks()
{
	level.autoassign = ::menuautoassign;
	level.spectator = ::menuspectator;
	level.class = ::menuclass;
	level.teammenu = ::menuteam;
}

//Function Number: 3
hideloadoutaftertime(delay)
{
	self endon("disconnect");
	self endon("perks_hidden");
	wait(delay);
	self thread hideallperks(0.4);
	self notify("perks_hidden");
}

//Function Number: 4
hideloadoutondeath()
{
	self endon("disconnect");
	self endon("perks_hidden");
	self waittill("death");
	self hideallperks();
	self notify("perks_hidden");
}

//Function Number: 5
hideloadoutonkill()
{
	self endon("disconnect");
	self endon("death");
	self endon("perks_hidden");
	self waittill("killed_player");
	self hideallperks();
	self notify("perks_hidden");
}

//Function Number: 6
freegameplayhudelems()
{
	if(IsDefined(self.perkicon))
	{
		for(numspecialties = 0;numspecialties < level.maxspecialties;numspecialties++)
		{
			if(IsDefined(self.perkicon[numspecialties]))
			{
				self.perkicon[numspecialties] destroyelem();
				self.perkname[numspecialties] destroyelem();
			}
		}
	}

	if(IsDefined(self.perkhudelem))
	{
		self.perkhudelem destroyelem();
	}

	if(IsDefined(self.killstreakicon))
	{
		if(IsDefined(self.killstreakicon[0]))
		{
			self.killstreakicon[0] destroyelem();
		}

		if(IsDefined(self.killstreakicon[1]))
		{
			self.killstreakicon[1] destroyelem();
		}

		if(IsDefined(self.killstreakicon[2]))
		{
			self.killstreakicon[2] destroyelem();
		}

		if(IsDefined(self.killstreakicon[3]))
		{
			self.killstreakicon[3] destroyelem();
		}

		if(IsDefined(self.killstreakicon[4]))
		{
			self.killstreakicon[4] destroyelem();
		}
	}

	self notify("perks_hidden");
	if(IsDefined(self.lowermessage))
	{
		self.lowermessage destroyelem();
	}

	if(IsDefined(self.lowertimer))
	{
		self.lowertimer destroyelem();
	}

	if(IsDefined(self.proxbar))
	{
		self.proxbar destroyelem();
	}

	if(IsDefined(self.proxbartext))
	{
		self.proxbartext destroyelem();
	}

	if(IsDefined(self.carryicon))
	{
		self.carryicon destroyelem();
	}
}

//Function Number: 7
teamplayercountsequal(playercounts)
{
	count = undefined;
	foreach(team in level.teams)
	{
		if(!(IsDefined(count)))
		{
			count = playercounts[team];
		}
		else if(count != playercounts[team])
		{
			return 0;
		}
	}

	return 1;
}

//Function Number: 8
teamwithlowestplayercount(playercounts,ignore_team)
{
	count = 9999;
	lowest_team = undefined;
	foreach(team in level.teams)
	{
		if(count > playercounts[team])
		{
			count = playercounts[team];
			lowest_team = team;
		}
	}

	return lowest_team;
}

//Function Number: 9
menuautoassign(comingfrommenu)
{
	teamkeys = getarraykeys(level.teams);
	assignment = teamkeys[randomint(teamkeys.size)];
	self closemenus();
	if(IsDefined(level.forceallallies) && level.forceallallies)
	{
		assignment = "allies";
	}
	else if(level.teambased)
	{
		if(GetDvarInt(#"950A8887") == 1)
		{
			if(level.allow_teamchange == "1" && self.hasspawned || comingfrommenu)
			{
				assignment = "";
			}
			else
			{
				team = getassignedteam(self);
				switch(team)
				{
					case "1":
						assignment = teamkeys[1];
						break;

					case "2":
						assignment = teamkeys[0];
						break;

					case "3":
						assignment = teamkeys[2];
						break;

					case "4":
						self setclientscriptmainmenu(game["menu_class"]);
!IsDefined(level.forceautoassign) || !level.forceautoassign
						break;

					default:
						assignment = "";
						assignment = team;
						self setclientscriptmainmenu(game["menu_class"]);
Stack-Empty ? IsDefined(level.teams[team]) : team == "spectator" && !level.forceautoassign
						break;
				}
			}
		}

		if(assignment == "" || GetDvarInt(#"950A8887") == 0)
		{
			if(sessionmodeiszombiesgame())
			{
				assignment = "allies";
			}
		}

		if(assignment == self.pers["team"] && self.sessionstate == "playing" || self.sessionstate == "dead")
		{
			self beginclasschoice();
			return;
		}
	}
	else if(GetDvarInt(#"950A8887") == 1)
	{
		if(level.allow_teamchange != "1" || !self.hasspawned && !comingfrommenu)
		{
			team = getassignedteam(self);
			if(IsDefined(level.teams[team]))
			{
				assignment = team;
			}
			else if(team == "spectator" && !level.forceautoassign)
			{
				self setclientscriptmainmenu(game["menu_class"]);
				return;
			}
		}
	}

	if(assignment != self.pers["team"] && self.sessionstate == "playing" || self.sessionstate == "dead")
	{
		self.switching_teams = 1;
		self.joining_team = assignment;
		self.leaving_team = self.pers["team"];
		self suicide();
	}

	self.pers["team"] = assignment;
	self.team = assignment;
	self.pers["class"] = undefined;
	self.class = undefined;
	self.pers["weapon"] = undefined;
	self.pers["savedmodel"] = undefined;
	self updateobjectivetext();
	if(level.teambased)
	{
		self.sessionteam = assignment;
	}
	else
	{
		self.sessionteam = "none";
		self.ffateam = assignment;
	}

	if(!(isalive(self)))
	{
		self.statusicon = "hud_status_dead";
	}

	self notify("joined_team");
	level notify("joined_team");
	self notify("end_respawn");
	self beginclasschoice();
	self setclientscriptmainmenu(game["menu_class"]);
}

//Function Number: 10
teamscoresequal()
{
	score = undefined;
	foreach(team in level.teams)
	{
		if(!(IsDefined(score)))
		{
			score = getteamscore(team);
		}
		else if(score != getteamscore(team))
		{
			return 0;
		}
	}

	return 1;
}

//Function Number: 11
teamwithlowestscore()
{
	score = 99999999;
	lowest_team = undefined;
	foreach(team in level.teams)
	{
		if(score > getteamscore(team))
		{
			lowest_team = team;
		}
	}

	return lowest_team;
}

//Function Number: 12
pickteamfromscores(teams)
{
	assignment = "allies";
	if(teamscoresequal())
	{
		assignment = teams[randomint(teams.size)];
	}
	else
	{
		assignment = teamwithlowestscore();
	}

	return assignment;
}

//Function Number: 13
getsplitscreenteam()
{
	for(index = 0;index < level.players.size;index++)
	{
		if(!(IsDefined(level.players[index])))
		{
		}
		else if(level.players[index] == self)
		{
		}
		else if(!(self isplayeronsamemachine(level.players[index])))
		{
		}
		else
		{
			team = level.players[index].sessionteam;
			if(team != "spectator")
			{
				return team;
			}
		}
	}

	return "";
}

//Function Number: 14
updateobjectivetext()
{
	if(sessionmodeiszombiesgame() || self.pers["team"] == "spectator")
	{
		self setclientcgobjectivetext("");
		return;
	}

	if(level.scorelimit > 0)
	{
		self setclientcgobjectivetext(getobjectivescoretext(self.pers["team"]));
	}
	else
	{
		self setclientcgobjectivetext(getobjectivetext(self.pers["team"]));
	}
}

//Function Number: 15
closemenus()
{
	self closemenu();
	self closeingamemenu();
}

//Function Number: 16
beginclasschoice(forcenewchoice)
{
/#
	assert(IsDefined(level.teams[self.pers["team"]]));
#/
	team = self.pers["team"];
	if(level.disablecac == 1)
	{
		self.pers["class"] = level.defaultclass;
		self.class = level.defaultclass;
		if(self.sessionstate != "playing" && game["state"] == "playing")
		{
			self thread [[ level.spawnclient ]]();
		}

		level thread maps/mp/gametypes_zm/_globallogic::updateteamstatus();
		self thread maps/mp/gametypes_zm/_spectating::setspectatepermissionsformachine();
		return;
	}

	if(level.wagermatch)
	{
		self openmenu(game["menu_changeclass_wager"]);
	}
	else if(GetDvarInt(#"5FA8E90F"))
	{
		self openmenu(game["menu_changeclass_barebones"]);
	}
	else
	{
		self openmenu(game["menu_changeclass_" + team]);
	}
}

//Function Number: 17
showmainmenuforteam()
{
/#
	assert(IsDefined(level.teams[self.pers["team"]]));
#/
	team = self.pers["team"];
	if(level.wagermatch)
	{
		self openmenu(game["menu_changeclass_wager"]);
	}
	else
	{
		self openmenu(game["menu_changeclass_" + team]);
	}
}

//Function Number: 18
menuteam(team)
{
	self closemenus();
	if(!level.console && level.allow_teamchange == "0" && IsDefined(self.hasdonecombat) && self.hasdonecombat)
	{
		return;
	}

	if(self.pers["team"] != team)
	{
		if(level.ingraceperiod && !IsDefined(self.hasdonecombat) || !self.hasdonecombat)
		{
			self.hasspawned = 0;
		}

		if(self.sessionstate == "playing")
		{
			self.switching_teams = 1;
			self.joining_team = team;
			self.leaving_team = self.pers["team"];
			self suicide();
		}

		self.pers["team"] = team;
		self.team = team;
		self.pers["class"] = undefined;
		self.class = undefined;
		self.pers["weapon"] = undefined;
		self.pers["savedmodel"] = undefined;
		self updateobjectivetext();
		if(level.teambased)
		{
			self.sessionteam = team;
		}
		else
		{
			self.sessionteam = "none";
			self.ffateam = team;
		}

		self setclientscriptmainmenu(game["menu_class"]);
		self notify("joined_team");
		level notify("joined_team");
		self notify("end_respawn");
	}

	self beginclasschoice();
}

//Function Number: 19
menuspectator()
{
	self closemenus();
	if(self.pers["team"] != "spectator")
	{
		if(isalive(self))
		{
			self.switching_teams = 1;
			self.joining_team = "spectator";
			self.leaving_team = self.pers["team"];
			self suicide();
		}

		self.pers["team"] = "spectator";
		self.team = "spectator";
		self.pers["class"] = undefined;
		self.class = undefined;
		self.pers["weapon"] = undefined;
		self.pers["savedmodel"] = undefined;
		self updateobjectivetext();
		self.sessionteam = "spectator";
		if(!(level.teambased))
		{
			self.ffateam = "spectator";
		}

		[[ level.spawnspectator ]]();
		self thread maps/mp/gametypes_zm/_globallogic_player::spectate_player_watcher();
		self setclientscriptmainmenu(game["menu_class"]);
		self notify("joined_spectators");
	}
}

//Function Number: 20
menuclass(response)
{
	self closemenus();
}

//Function Number: 21
removespawnmessageshortly(delay)
{
	self endon("disconnect");
	waittillframeend;
	self endon("end_respawn");
	wait(delay);
	self clearlowermessage(2);
}