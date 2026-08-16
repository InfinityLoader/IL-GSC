/*******************************************************************
 * Decompiled By: Bog
 * Decompiled File: maps\mp\gametypes\_rank.gsc
 * Game: Call of Duty: Modern Warfare 2
 * Platform: Xbox
*******************************************************************/

init()
{
	level.scoreinfo = [];
	level.xpscale = getdvarint("scr_xpscale");
	if(level.xpscale > 4 || level.xpscale < 0)
	{
		exitlevel(0);
	}

	level.xpscale = min(level.xpscale, 4);
	level.xpscale = max(level.xpscale, 0);
	level.ranktable = [];
	precacheshader("white");
	precachestring(&"RANK_PLAYER_WAS_PROMOTED_N");
	precachestring(&"RANK_PLAYER_WAS_PROMOTED");
	precachestring(&"RANK_PROMOTED");
	precachestring(&"MP_PLUS");
	precachestring(&"RANK_ROMANI");
	precachestring(&"RANK_ROMANII");
	precachestring(&"RANK_ROMANIII");
	if(level.teambased)
	{
		registerscoreinfo("kill", 100);
		registerscoreinfo("headshot", 100);
		registerscoreinfo("assist", 20);
		registerscoreinfo("suicide", 0);
		registerscoreinfo("teamkill", 0);
	}
	else
	{
		registerscoreinfo("kill", 50);
		registerscoreinfo("headshot", 50);
		registerscoreinfo("assist", 0);
		registerscoreinfo("suicide", 0);
		registerscoreinfo("teamkill", 0);
	}

	registerscoreinfo("win", 1);
	registerscoreinfo("loss", 0.5);
	registerscoreinfo("tie", 0.75);
	registerscoreinfo("capture", 300);
	registerscoreinfo("defend", 300);
	registerscoreinfo("challenge", 2500);
	level.maxrank = int(tablelookup("mp/rankTable.csv", 0, "maxrank", 1));
	level.maxprestige = int(tablelookup("mp/rankIconTable.csv", 0, "maxprestige", 1));
	pid = 0;
	rid = 0;
	for(pid = 0;pid <= level.maxprestige;pid++)
	{
		for(rid = 0;rid <= level.maxrank;rid++)
		{
			precacheshader(tablelookup("mp/rankIconTable.csv", 0, rid, pid + 1));
		}
	}

	rankid = 0;
	rankname = tablelookup("mp/ranktable.csv", 0, rankid, 1);
	while(isdefined(rankname) && rankname != "")
	{
		level.ranktable[rankid][1] = tablelookup("mp/ranktable.csv", 0, rankid, 1);
		level.ranktable[rankid][2] = tablelookup("mp/ranktable.csv", 0, rankid, 2);
		level.ranktable[rankid][3] = tablelookup("mp/ranktable.csv", 0, rankid, 3);
		level.ranktable[rankid][7] = tablelookup("mp/ranktable.csv", 0, rankid, 7);
		precachestring(tablelookupistring("mp/ranktable.csv", 0, rankid, 16));
		rankid++;
		rankname = tablelookup("mp/ranktable.csv", 0, rankid, 1);
	}

	maps\mp\gametypes\_missions::buildchallegeinfo();
	level thread patientzerowaiter();
	level thread onplayerconnect();
}

patientzerowaiter()
{
	level endon("game_ended");
	while(!isdefined(level.players) || !level.players.size)
	{
		wait 0.05;
	}

	if(!maps\mp\_utility::matchmakinggame())
	{
		if(getdvar("mapname") == "mp_rust" && randomint(1000) == 999)
		{
			level.patientzeroname = level.players[0].name;
			return;
		}

		return;
	}

	if(getdvar("scr_patientZero") != "")
	{
		level.patientzeroname = getdvar("scr_patientZero");
		return;
	}
}

isregisteredevent(type)
{
	if(isdefined(level.scoreinfo[type]))
	{
		return 1;
	}

	return 0;
}

registerscoreinfo(type, value)
{
	level.scoreinfo[type]["value"] = value;
}

getscoreinfovalue(type)
{
	overridedvar = "scr_" + level.gametype + "_score_" + type;
	if(getdvar(overridedvar) != "")
	{
		return getdvarint(overridedvar);
	}

	return level.scoreinfo[type]["value"];
}

getscoreinfolabel(type)
{
	return level.scoreinfo[type]["label"];
}

getrankinfominxp(rankid)
{
	return int(level.ranktable[rankid][2]);
}

getrankinfoxpamt(rankid)
{
	return int(level.ranktable[rankid][3]);
}

getrankinfomaxxp(rankid)
{
	return int(level.ranktable[rankid][7]);
}

getrankinfofull(rankid)
{
	return tablelookupistring("mp/ranktable.csv", 0, rankid, 16);
}

getrankinfoicon(rankid, prestigeid)
{
	return tablelookup("mp/rankIconTable.csv", 0, rankid, prestigeid + 1);
}

getrankinfolevel(rankid)
{
	return int(tablelookup("mp/ranktable.csv", 0, rankid, 13));
}

onplayerconnect()
{
	for(;;)
	{
		level waittill("connected", player);
		player.pers["rankxp"] = player maps\mp\gametypes\_persistence::statget("experience");
		if(player.pers["rankxp"] < 0)
		{
			player.pers["rankxp"] = 0;
		}

		rankid = player getrankforxp(player getrankxp());
		player.pers["rank"] = rankid;
		player.pers["participation"] = 0;
		player.xpupdatetotal = 0;
		player.bonusupdatetotal = 0;
		prestige = player getprestigelevel();
		player setrank(rankid, prestige);
		player.pers["prestige"] = prestige;
		player.postgamepromotion = 0;
		if(!isdefined(player.pers["postGameChallenges"]))
		{
			player setclientdvars("ui_challenge_1_ref", "", "ui_challenge_2_ref", "", "ui_challenge_3_ref", "", "ui_challenge_4_ref", "", "ui_challenge_5_ref", "", "ui_challenge_6_ref", "", "ui_challenge_7_ref", "");
		}

		player setclientdvar("ui_promotion", 0);
		if(!isdefined(player.pers["summary"]))
		{
			player.pers["summary"] = [];
			player.pers["summary"]["xp"] = 0;
			player.pers["summary"]["score"] = 0;
			player.pers["summary"]["challenge"] = 0;
			player.pers["summary"]["match"] = 0;
			player.pers["summary"]["misc"] = 0;
			player setclientdvar("player_summary_xp", "0");
			player setclientdvar("player_summary_score", "0");
			player setclientdvar("player_summary_challenge", "0");
			player setclientdvar("player_summary_match", "0");
			player setclientdvar("player_summary_misc", "0");
		}

		player setclientdvar("ui_opensummary", 0);
		player maps\mp\gametypes\_missions::updatechallenges();
		player.explosivekills[0] = 0;
		player.xpgains = [];
		player.hud_scorepopup = newclienthudelem(player);
		player.hud_scorepopup.horzalign = "center";
		player.hud_scorepopup.vertalign = "middle";
		player.hud_scorepopup.alignx = "center";
		player.hud_scorepopup.aligny = "middle";
		player.hud_scorepopup.x = 0;
		if(level.splitscreen)
		{
			player.hud_scorepopup.y = -40;
		}
		else
		{
			player.hud_scorepopup.y = -60;
		}

		player.hud_scorepopup.font = "hudbig";
		player.hud_scorepopup.fontscale = 0.75;
		player.hud_scorepopup.archived = 0;
		player.hud_scorepopup.color = (0.5,0.5,0.5);
		player.hud_scorepopup.sort = 10000;
		player.hud_scorepopup maps\mp\gametypes\_hud::fontpulseinit(3);
		player thread onplayerspawned();
		player thread onjoinedteam();
		player thread onjoinedspectators();
	}
}

onjoinedteam()
{
	self endon("disconnect");
	for(;;)
	{
		self waittill("joined_team");
		thread removerankhud();
	}
}

onjoinedspectators()
{
	self endon("disconnect");
	for(;;)
	{
		self waittill("joined_spectators");
		thread removerankhud();
	}
}

onplayerspawned()
{
	self endon("disconnect");
	self waittill("spawned_player");
}

roundup(floatval)
{
	if(int(floatval) != floatval)
	{
		return int(floatval + 1);
	}

	return int(floatval);
}

giverankxp(type, value)
{
	self endon("disconnect");
	loottype = "none";
	if(!maps\mp\_utility::rankingenabled())
	{
		return;
	}

	if(level.teambased && !level.teamcount["allies"] || !level.teamcount["axis"])
	{
		return;
	}

	if(!level.teambased && level.teamcount["allies"] + level.teamcount["axis"] < 2)
	{
		return;
	}

	if(!isdefined(value))
	{
		value = getscoreinfovalue(type);
	}

	if(!isdefined(self.xpgains[type]))
	{
		self.xpgains[type] = 0;
	}

	momentumbonus = 0;
	gotrestxp = 0;
	switch(type)
	{
		case "shield_damage":
		case "headshot":
		case "kill":
			value = value * self.xpscaler;
			break;

		case "defuse":
		case "plant":
		case "assault":
		case "pickup":
		case "return":
		case "defend":
		case "capture":
		case "save":
		case "destroy":
		case "teamkill":
		case "suicide":
		case "assist":
			if(maps\mp\_utility::getgametypenumlives() > 0)
			{
				multiplier = max(1, int(10 / maps\mp\_utility::getgametypenumlives()));
				value = int(value * multiplier);
			}
	
			value = int(value * level.xpscale);
			restxpawarded = getrestxpaward(value);
			value = value + restxpawarded;
			if(restxpawarded > 0)
			{
				if(islastrestxpaward(value))
				{
					thread maps\mp\gametypes\_hud_message::splashnotify("rested_done");
				}
	
				gotrestxp = 1;
			}
			break;
	}

	if(!gotrestxp)
	{
		if(self getplayerdata("restXPGoal") > getrankxp())
		{
			self setplayerdata("restXPGoal", self getplayerdata("restXPGoal") + value);
		}
	}

	oldxp = getrankxp();
	self.xpgains[type] = self.xpgains[type] + value;
	incrankxp(value);
	if(maps\mp\_utility::rankingenabled() && updaterank(oldxp))
	{
		thread updaterankannouncehud();
	}

	syncxpstat();
	if(!level.hardcoremode)
	{
		if(type == "teamkill")
		{
			thread scorepopup(0 - getscoreinfovalue("kill"), 0, (1,0,0), 0);
		}
		else
		{
			color = (1,1,0.5);
			if(gotrestxp)
			{
				color = (1,0.65,0);
			}

			thread scorepopup(value, momentumbonus, color, 0);
		}
	}

	switch(type)
	{
		case "defuse":
		case "plant":
		case "assault":
		case "pickup":
		case "return":
		case "defend":
		case "capture":
		case "teamkill":
		case "suicide":
		case "assist":
		case "headshot":
		case "kill":
			self.pers["summary"]["score"] = self.pers["summary"]["score"] + value;
			self.pers["summary"]["xp"] = self.pers["summary"]["xp"] + value;
			break;

		case "loss":
		case "win":
		case "tie":
			self.pers["summary"]["match"] = self.pers["summary"]["match"] + value;
			self.pers["summary"]["xp"] = self.pers["summary"]["xp"] + value;
			break;

		case "challenge":
			self.pers["summary"]["challenge"] = self.pers["summary"]["challenge"] + value;
			self.pers["summary"]["xp"] = self.pers["summary"]["xp"] + value;
			break;

		default:
			self.pers["summary"]["misc"] = self.pers["summary"]["misc"] + value;
			self.pers["summary"]["match"] = self.pers["summary"]["match"] + value;
			self.pers["summary"]["xp"] = self.pers["summary"]["xp"] + value;
			break;
	}
}

updaterank(oldxp)
{
	newrankid = getrank();
	if(newrankid == self.pers["rank"])
	{
		return 0;
	}

	oldrank = self.pers["rank"];
	rankid = self.pers["rank"];
	self.pers["rank"] = newrankid;
	self setrank(newrankid);
	return 1;
}

updaterankannouncehud()
{
	self endon("disconnect");
	self notify("update_rank");
	self endon("update_rank");
	team = self.pers["team"];
	if(!isdefined(team))
	{
		return;
	}

	if(!maps\mp\_utility::levelflag("game_over"))
	{
		level common_scripts\utility::waittill_notify_or_timeout("game_over", 0.25);
	}

	newrankname = getrankinfofull(self.pers["rank"]);
	rank_char = level.ranktable[self.pers["rank"]][1];
	subrank = int(rank_char[rank_char.size - 1]);
	thread maps\mp\gametypes\_hud_message::promotionsplashnotify();
	if(subrank > 1)
	{
		return;
	}

	for(i = 0;i < level.players.size;i++)
	{
		player = level.players[i];
		playerteam = player.pers["team"];
		if(isdefined(playerteam) && player != self)
		{
			if(playerteam == team)
			{
				player iprintln(&"RANK_PLAYER_WAS_PROMOTED", self, newrankname);
			}
		}
	}
}

endgameupdate()
{
	player = self;
}

scorepopup(amount, param_70D, param_70E, glowalpha)
{
	self endon("disconnect");
	self endon("joined_team");
	self endon("joined_spectators");
	if(amount == 0)
	{
		return;
	}

	self notify("scorePopup");
	self endon("scorePopup");
	self.xpupdatetotal = self.xpupdatetotal + amount;
	self.bonusupdatetotal = self.bonusupdatetotal + param_70D;
	wait 0.05;
	if(self.xpupdatetotal < 0)
	{
		self.hud_scorepopup.label = &"";
	}
	else
	{
		self.hud_scorepopup.label = &"MP_PLUS";
	}

	self.hud_scorepopup.color = param_70E;
	self.hud_scorepopup.glowcolor = param_70E;
	self.hud_scorepopup.glowalpha = glowalpha;
	self.hud_scorepopup setvalue(self.xpupdatetotal);
	self.hud_scorepopup.alpha = 0.85;
	self.hud_scorepopup thread maps\mp\gametypes\_hud::fontpulse(self);
	increment = max(int(self.bonusupdatetotal / 20), 1);
	if(self.bonusupdatetotal)
	{
		while(self.bonusupdatetotal > 0)
		{
			self.xpupdatetotal = self.xpupdatetotal + min(self.bonusupdatetotal, increment);
			self.bonusupdatetotal = self.bonusupdatetotal - min(self.bonusupdatetotal, increment);
			self.hud_scorepopup setvalue(self.xpupdatetotal);
			wait 0.05;
		}
	}
	else
	{
		wait 1;
	}

	self.hud_scorepopup fadeovertime(0.75);
	self.hud_scorepopup.alpha = 0;
	self.xpupdatetotal = 0;
}

removerankhud()
{
	self.hud_scorepopup.alpha = 0;
}

getrank()
{
	rankxp = self.pers["rankxp"];
	rankid = self.pers["rank"];
	if(rankxp < getrankinfominxp(rankid) + getrankinfoxpamt(rankid))
	{
		return rankid;
	}

	return getrankforxp(rankxp);
}

levelforexperience(experience)
{
	return getrankforxp(experience);
}

getrankforxp(xpval)
{
	rankid = 0;
	rankname = level.ranktable[rankid][1];
	while(isdefined(rankname) && rankname != "")
	{
		if(xpval < getrankinfominxp(rankid) + getrankinfoxpamt(rankid))
		{
			return rankid;
		}

		rankid++;
		if(isdefined(level.ranktable[rankid]))
		{
			rankname = level.ranktable[rankid][1];
			continue;
		}

		rankname = undefined;
	}

	rankid--;
	return rankid;
}

getspm()
{
	ranklevel = getrank() + 1;
	return 3 + ranklevel * 0.5 * 10;
}

getprestigelevel()
{
	return maps\mp\gametypes\_persistence::statget("prestige");
}

getrankxp()
{
	return self.pers["rankxp"];
}

incrankxp(amount)
{
	if(!maps\mp\_utility::rankingenabled())
	{
		return;
	}

	if(isdefined(self.ischeater))
	{
		return;
	}

	xp = getrankxp();
	newxp = int(min(xp, getrankinfomaxxp(level.maxrank))) + amount;
	if(self.pers["rank"] == level.maxrank && newxp >= getrankinfomaxxp(level.maxrank))
	{
		newxp = getrankinfomaxxp(level.maxrank);
	}

	self.pers["rankxp"] = newxp;
}

getrestxpaward(basexp)
{
	if(!getdvarint("scr_restxp_enable"))
	{
		return 0;
	}

	restxpawardrate = getdvarfloat("scr_restxp_restedAwardScale");
	wantgiverestxp = int(basexp * restxpawardrate);
	maygiverestxp = self getplayerdata("restXPGoal") - getrankxp();
	if(maygiverestxp <= 0)
	{
		return 0;
	}

	return wantgiverestxp;
}

islastrestxpaward(basexp)
{
	if(!getdvarint("scr_restxp_enable"))
	{
		return 0;
	}

	restxpawardrate = getdvarfloat("scr_restxp_restedAwardScale");
	wantgiverestxp = int(basexp * restxpawardrate);
	maygiverestxp = self getplayerdata("restXPGoal") - getrankxp();
	if(maygiverestxp <= 0)
	{
		return 0;
	}

	if(wantgiverestxp >= maygiverestxp)
	{
		return 1;
	}

	return 0;
}

syncxpstat()
{
	if(level.xpscale > 4 || level.xpscale <= 0)
	{
		exitlevel(0);
	}

	xp = getrankxp();
	maps\mp\gametypes\_persistence::statset("experience", xp);
}