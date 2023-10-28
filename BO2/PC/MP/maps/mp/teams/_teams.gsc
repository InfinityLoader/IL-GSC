/*******************************************************************
 * Decompiled By: Bog
 * Decompiled File: maps\mp\teams\_teams.gsc
 * Game: Call of Duty: Black Ops 2
 * Platform: PC
 * Function Count: 17
 * Decompile Time: 4 ms
 * Timestamp: 10/28/2023 12:10:48 AM
*******************************************************************/

#include maps/mp/_utility;
#include maps/mp/gametypes/_globallogic_ui;
#include maps/mp/gametypes/_persistence;
#include maps/mp/gametypes/_spectating;

//Function Number: 1
init()
{
	precacheshader("mpflag_spectator");
	game["strings"]["autobalance"] = &"MP_AUTOBALANCE_NOW";
	precachestring(&"MP_AUTOBALANCE_NOW");
	if(GetDvar(#"81F89399") == "")
	{
		setdvar("scr_teambalance","0");
	}

	level.teambalance = GetDvarInt(#"81F89399");
	level.teambalancetimer = 0;
	if(GetDvar(#"3478842E") == "")
	{
		setdvar("scr_timeplayedcap","1800");
	}

	level.timeplayedcap = int(GetDvarInt(#"3478842E"));
	level.freeplayers = [];
	if(level.teambased)
	{
		level.alliesplayers = [];
		level.axisplayers = [];
		level thread onplayerconnect();
		level thread updateteambalancedvar();
		wait(0.15);
		if(level.rankedmatch || level.leaguematch)
		{
			level thread updateplayertimes();
		}
	}
	else
	{
		level thread onfreeplayerconnect();
		wait(0.15);
		if(level.rankedmatch || level.leaguematch)
		{
			level thread updateplayertimes();
		}
	}
}

//Function Number: 2
onplayerconnect()
{
	for(;;)
	{
		level waittill("connecting",player);
		player thread onjoinedteam();
		player thread onjoinedspectators();
		player thread trackplayedtime();
	}
}

//Function Number: 3
onfreeplayerconnect()
{
	for(;;)
	{
		level waittill("connecting",player);
		player thread trackfreeplayedtime();
	}
}

//Function Number: 4
onjoinedteam()
{
	self endon("disconnect");
	for(;;)
	{
		self waittill("joined_team");
		self logstring("joined team: " + self.pers["team"]);
		self updateteamtime();
	}
}

//Function Number: 5
onjoinedspectators()
{
	self endon("disconnect");
	for(;;)
	{
		self waittill("joined_spectators");
		self.pers["teamTime"] = undefined;
	}
}

//Function Number: 6
trackplayedtime()
{
	self endon("disconnect");
	foreach(team in level.teams)
	{
		self.timeplayed[team] = 0;
	}

	self.timeplayed["free"] = 0;
	self.timeplayed["other"] = 0;
	self.timeplayed["alive"] = 0;
	if(!IsDefined(self.timeplayed["total"]) || !level.gametype == "twar" && 0 < game["roundsplayed"] && 0 < self.timeplayed["total"])
	{
		self.timeplayed["total"] = 0;
	}

	while(level.inprematchperiod)
	{
		wait(0.05);
	}

	for(;;)
	{
		if(game["state"] == "playing")
		{
			if(IsDefined(level.teams[self.sessionteam]))
			{
				self.timeplayed[self.sessionteam]++;
				self.timeplayed["total"]++;
				if(isalive(self))
				{
					self.timeplayed["alive"]++;
				}
			}
			else if(self.sessionteam == "spectator")
			{
				self.timeplayed["other"]++;
			}
		}

		wait(1);
	}
}

//Function Number: 7
updateplayertimes()
{
	nexttoupdate = 0;
	for(;;)
	{
		nexttoupdate++;
		if(nexttoupdate >= level.players.size)
		{
			nexttoupdate = 0;
		}

		if(IsDefined(level.players[nexttoupdate]))
		{
			level.players[nexttoupdate] updateplayedtime();
			level.players[nexttoupdate] maps/mp/gametypes/_persistence::checkcontractexpirations();
		}

		wait(1);
	}
}

//Function Number: 8
updateplayedtime()
{
	pixbeginevent("updatePlayedTime");
	foreach(team in level.teams)
	{
		if(self.timeplayed[team])
		{
			self addplayerstat("time_played_" + team,int(min(self.timeplayed[team],level.timeplayedcap)));
			self addplayerstatwithgametype("time_played_total",int(min(self.timeplayed[team],level.timeplayedcap)));
		}
	}

	if(self.timeplayed["other"])
	{
		self addplayerstat("time_played_other",int(min(self.timeplayed["other"],level.timeplayedcap)));
		self addplayerstatwithgametype("time_played_total",int(min(self.timeplayed["other"],level.timeplayedcap)));
	}

	if(self.timeplayed["alive"])
	{
		timealive = int(min(self.timeplayed["alive"],level.timeplayedcap));
		self maps/mp/gametypes/_persistence::incrementcontracttimes(timealive);
		self addplayerstat("time_played_alive",timealive);
	}

	pixendevent();
	if(game["state"] == "postgame")
	{
		return;
	}

	foreach(team in level.teams)
	{
		self.timeplayed[team] = 0;
	}

	self.timeplayed["other"] = 0;
	self.timeplayed["alive"] = 0;
}

//Function Number: 9
updateteamtime()
{
	if(game["state"] != "playing")
	{
		return;
	}

	self.pers["teamTime"] = GetTime();
}

//Function Number: 10
updateteambalancedvar()
{
	for(;;)
	{
		teambalance = GetDvarInt(#"81F89399");
		if(level.teambalance != teambalance)
		{
			level.teambalance = GetDvarInt(#"81F89399");
		}

		timeplayedcap = GetDvarInt(#"3478842E");
		if(level.timeplayedcap != timeplayedcap)
		{
			level.timeplayedcap = int(GetDvarInt(#"3478842E"));
		}

		wait(1);
	}
}

//Function Number: 11
changeteam(team)
{
	if(self.sessionstate != "dead")
	{
		self.switching_teams = 1;
		self.joining_team = team;
		self.leaving_team = self.pers["team"];
		self suicide();
	}

	self.pers["team"] = team;
	self.team = team;
	self.pers["weapon"] = undefined;
	self.pers["spawnweapon"] = undefined;
	self.pers["savedmodel"] = undefined;
	self.pers["teamTime"] = undefined;
	self.sessionteam = self.pers["team"];
	if(!(level.teambased))
	{
		self.ffateam = team;
	}

	self maps/mp/gametypes/_globallogic_ui::updateobjectivetext();
	self maps/mp/gametypes/_spectating::setspectatepermissions();
	self setclientscriptmainmenu(game["menu_class"]);
	self openmenu(game["menu_class"]);
	self notify("end_respawn");
}

//Function Number: 12
countplayers()
{
	players = level.players;
	playercounts = [];
	foreach(team in level.teams)
	{
		playercounts[team] = 0;
	}

	foreach(player in level.players)
	{
		if(player == self)
		{
		}
		else
		{
			team = player.pers["team"];
			if(IsDefined(team) && IsDefined(level.teams[team]))
			{
				playercounts[team]++;
			}
		}
	}

	return playercounts;
}

//Function Number: 13
trackfreeplayedtime()
{
	self endon("disconnect");
	foreach(team in level.teams)
	{
		self.timeplayed[team] = 0;
	}

	self.timeplayed["other"] = 0;
	self.timeplayed["total"] = 0;
	self.timeplayed["alive"] = 0;
	for(;;)
	{
		if(game["state"] == "playing")
		{
			team = self.pers["team"];
			if(IsDefined(team) && IsDefined(level.teams[team]) && self.sessionteam != "spectator")
			{
				self.timeplayed[team]++;
				self.timeplayed["total"]++;
				if(isalive(self))
				{
					self.timeplayed["alive"]++;
				}
			}
			else
			{
				self.timeplayed["other"]++;
			}
		}

		wait(1);
	}
}

//Function Number: 14
set_player_model(team,weapon)
{
	weaponclass = getweaponclass(weapon);
	bodytype = "default";
	switch(weaponclass)
	{
		case "weapon_sniper":
			bodytype = "rifle";
			break;

		case "weapon_cqb":
			bodytype = "spread";
			break;

		case "weapon_lmg":
			bodytype = "mg";
			break;

		case "weapon_smg":
			bodytype = "smg";
			break;
	}

	self detachall();
	self setmovespeedscale(1);
	self setsprintduration(4);
	self setsprintcooldown(0);
	if(level.multiteam)
	{
		bodytype = "default";
		switch(team)
		{
			case "team7":
			case "team8":
				team = "allies";
				break;
		}
	}

	self [[ game["set_player_model"][team][bodytype] ]]();
}

//Function Number: 15
getteamflagmodel(teamref)
{
/#
	assert(IsDefined(game["flagmodels"]));
#/
/#
	assert(IsDefined(game["flagmodels"][teamref]));
#/
	return game["flagmodels"][teamref];
}

//Function Number: 16
getteamflagcarrymodel(teamref)
{
/#
	assert(IsDefined(game["carry_flagmodels"]));
#/
/#
	assert(IsDefined(game["carry_flagmodels"][teamref]));
#/
	return game["carry_flagmodels"][teamref];
}

//Function Number: 17
getteamflagicon(teamref)
{
/#
	assert(IsDefined(game["carry_icon"]));
#/
/#
	assert(IsDefined(game["carry_icon"][teamref]));
#/
	return game["carry_icon"][teamref];
}