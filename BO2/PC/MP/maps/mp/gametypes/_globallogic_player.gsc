/*******************************************************************
 * Decompiled By: Bog
 * Decompiled File: maps\mp\gametypes\_globallogic_player.gsc
 * Game: Call of Duty: Black Ops 2
 * Platform: PC
 * Function Count: 53
 * Decompile Time: 593 ms
 * Timestamp: 10/27/2023 3:00:04 AM
*******************************************************************/

#include common_scripts/utility;
#include maps/mp/_burnplayer;
#include maps/mp/_challenges;
#include maps/mp/_demo;
#include maps/mp/_flashgrenades;
#include maps/mp/_gamerep;
#include maps/mp/_medals;
#include maps/mp/_scoreevents;
#include maps/mp/_utility;
#include maps/mp/_vehicles;
#include maps/mp/gametypes/_battlechatter_mp;
#include maps/mp/gametypes/_class;
#include maps/mp/gametypes/_damagefeedback;
#include maps/mp/gametypes/_deathicons;
#include maps/mp/gametypes/_globallogic;
#include maps/mp/gametypes/_globallogic_audio;
#include maps/mp/gametypes/_globallogic_score;
#include maps/mp/gametypes/_globallogic_spawn;
#include maps/mp/gametypes/_globallogic_ui;
#include maps/mp/gametypes/_globallogic_utils;
#include maps/mp/gametypes/_globallogic_vehicle;
#include maps/mp/gametypes/_hostmigration;
#include maps/mp/gametypes/_hud_message;
#include maps/mp/gametypes/_hud_util;
#include maps/mp/gametypes/_killcam;
#include maps/mp/gametypes/_persistence;
#include maps/mp/gametypes/_rank;
#include maps/mp/gametypes/_spawning;
#include maps/mp/gametypes/_spawnlogic;
#include maps/mp/gametypes/_spectating;
#include maps/mp/gametypes/_tweakables;
#include maps/mp/gametypes/_weapon_utils;
#include maps/mp/gametypes/_weapons;
#include maps/mp/killstreaks/_killstreak_weapons;
#include maps/mp/killstreaks/_killstreaks;
#include maps/mp/killstreaks/_straferun;
#include maps/mp/teams/_teams;

//Function Number: 1
freezeplayerforroundend()
{
	self clearlowermessage();
	self closemenu();
	self closeingamemenu();
	self freeze_player_controls(1);
	if(!(sessionmodeiszombiesgame()))
	{
		currentweapon = self getcurrentweapon();
		if(maps/mp/killstreaks/_killstreaks::iskillstreakweapon(currentweapon) && !maps/mp/killstreaks/_killstreak_weapons::isheldkillstreakweapon(currentweapon))
		{
			self takeweapon(currentweapon);
		}
	}
}

//Function Number: 2
callback_playerconnect()
{
	thread notifyconnecting();
	self.statusicon = "hud_status_connecting";
	self waittill("begin");
	if(IsDefined(level.reset_clientdvars))
	{
		self [[ level.reset_clientdvars ]]();
	}

	waittillframeend;
	self.statusicon = "";
	self.guid = self getguid();
	matchrecorderincrementheaderstat("playerCountJoined",1);
	profilelog_begintiming(4,"ship");
	level notify("connected",self);
	if(self ishost())
	{
		self thread maps/mp/gametypes/_globallogic::listenforgameend();
	}

	if(!level.splitscreen && !IsDefined(self.pers["score"]))
	{
		iprintln(&"MP_CONNECTED",self);
	}

	if(!(IsDefined(self.pers["score"])))
	{
		self thread maps/mp/gametypes/_persistence::adjustrecentstats();
		self maps/mp/gametypes/_persistence::setafteractionreportstat("valid",0);
		if(gamemodeismode(level.gamemode_wager_match) && !self ishost())
		{
			self maps/mp/gametypes/_persistence::setafteractionreportstat("wagerMatchFailed",1);
		}
		else
		{
			self maps/mp/gametypes/_persistence::setafteractionreportstat("wagerMatchFailed",0);
		}
	}

	if((level.rankedmatch || level.wagermatch || level.leaguematch) && !IsDefined(self.pers["matchesPlayedStatsTracked"]))
	{
		gamemode = maps/mp/gametypes/_globallogic::getcurrentgamemode();
		self maps/mp/gametypes/_globallogic::incrementmatchcompletionstat(gamemode,"played","started");
		if(!IsDefined(self.pers["matchesHostedStatsTracked"]) && self islocaltohost())
		{
			self maps/mp/gametypes/_globallogic::incrementmatchcompletionstat(gamemode,"hosted","started");
			self.pers["matchesHostedStatsTracked"] = 1;
		}

		self.pers["matchesPlayedStatsTracked"] = 1;
		self thread maps/mp/gametypes/_persistence::uploadstatssoon();
	}

	self maps/mp/_gamerep::gamerepplayerconnected();
	lpselfnum = self getentitynumber();
	lpguid = self getguid();
	logprint("J;" + lpguid + ";" + lpselfnum + ";" + self.name + "\n");
	bbprint("mpjoins","name %s client %s",self.name,lpselfnum);
	if(!(sessionmodeiszombiesgame()))
	{
		self setclientuivisibilityflag("hud_visible",1);
	}

	if(level.forceradar == 1)
	{
		self.pers["hasRadar"] = 1;
		self.hasspyplane = 1;
		level.activeuavs[self getentitynumber()] = 1;
	}

	if(level.forceradar == 2)
	{
		self setclientuivisibilityflag("g_compassShowEnemies",level.forceradar);
	}
	else
	{
		self setclientuivisibilityflag("g_compassShowEnemies",0);
	}

	self setclientplayersprinttime(level.playersprinttime);
	self setclientnumlives(level.numlives);
	makedvarserverinfo("cg_drawTalk",1);
	if(level.hardcoremode)
	{
		self setclientdrawtalk(3);
	}

	if(sessionmodeiszombiesgame())
	{
		self [[ level.player_stats_init ]]();
	}
	else
	{
		self maps/mp/gametypes/_globallogic_score::initpersstat("score");
		if(level.resetplayerscoreeveryround)
		{
			self.pers["score"] = 0;
		}

		self.score = self.pers["score"];
		self maps/mp/gametypes/_globallogic_score::initpersstat("pointstowin");
		if(level.scoreroundbased)
		{
			self.pers["pointstowin"] = 0;
		}

		self.pointstowin = self.pers["pointstowin"];
		self maps/mp/gametypes/_globallogic_score::initpersstat("momentum",0);
		self.momentum = self maps/mp/gametypes/_globallogic_score::getpersstat("momentum");
		self maps/mp/gametypes/_globallogic_score::initpersstat("suicides");
		self.suicides = self maps/mp/gametypes/_globallogic_score::getpersstat("suicides");
		self maps/mp/gametypes/_globallogic_score::initpersstat("headshots");
		self.headshots = self maps/mp/gametypes/_globallogic_score::getpersstat("headshots");
		self maps/mp/gametypes/_globallogic_score::initpersstat("challenges");
		self.challenges = self maps/mp/gametypes/_globallogic_score::getpersstat("challenges");
		self maps/mp/gametypes/_globallogic_score::initpersstat("kills");
		self.kills = self maps/mp/gametypes/_globallogic_score::getpersstat("kills");
		self maps/mp/gametypes/_globallogic_score::initpersstat("deaths");
		self.deaths = self maps/mp/gametypes/_globallogic_score::getpersstat("deaths");
		self maps/mp/gametypes/_globallogic_score::initpersstat("assists");
		self.assists = self maps/mp/gametypes/_globallogic_score::getpersstat("assists");
		self maps/mp/gametypes/_globallogic_score::initpersstat("defends",0);
		self.defends = self maps/mp/gametypes/_globallogic_score::getpersstat("defends");
		self maps/mp/gametypes/_globallogic_score::initpersstat("offends",0);
		self.offends = self maps/mp/gametypes/_globallogic_score::getpersstat("offends");
		self maps/mp/gametypes/_globallogic_score::initpersstat("plants",0);
		self.plants = self maps/mp/gametypes/_globallogic_score::getpersstat("plants");
		self maps/mp/gametypes/_globallogic_score::initpersstat("defuses",0);
		self.defuses = self maps/mp/gametypes/_globallogic_score::getpersstat("defuses");
		self maps/mp/gametypes/_globallogic_score::initpersstat("returns",0);
		self.returns = self maps/mp/gametypes/_globallogic_score::getpersstat("returns");
		self maps/mp/gametypes/_globallogic_score::initpersstat("captures",0);
		self.captures = self maps/mp/gametypes/_globallogic_score::getpersstat("captures");
		self maps/mp/gametypes/_globallogic_score::initpersstat("destructions",0);
		self.destructions = self maps/mp/gametypes/_globallogic_score::getpersstat("destructions");
		self maps/mp/gametypes/_globallogic_score::initpersstat("backstabs",0);
		self.backstabs = self maps/mp/gametypes/_globallogic_score::getpersstat("backstabs");
		self maps/mp/gametypes/_globallogic_score::initpersstat("longshots",0);
		self.longshots = self maps/mp/gametypes/_globallogic_score::getpersstat("longshots");
		self maps/mp/gametypes/_globallogic_score::initpersstat("survived",0);
		self.survived = self maps/mp/gametypes/_globallogic_score::getpersstat("survived");
		self maps/mp/gametypes/_globallogic_score::initpersstat("stabs",0);
		self.stabs = self maps/mp/gametypes/_globallogic_score::getpersstat("stabs");
		self maps/mp/gametypes/_globallogic_score::initpersstat("tomahawks",0);
		self.tomahawks = self maps/mp/gametypes/_globallogic_score::getpersstat("tomahawks");
		self maps/mp/gametypes/_globallogic_score::initpersstat("humiliated",0);
		self.humiliated = self maps/mp/gametypes/_globallogic_score::getpersstat("humiliated");
		self maps/mp/gametypes/_globallogic_score::initpersstat("x2score",0);
		self.x2score = self maps/mp/gametypes/_globallogic_score::getpersstat("x2score");
		self maps/mp/gametypes/_globallogic_score::initpersstat("agrkills",0);
		self.x2score = self maps/mp/gametypes/_globallogic_score::getpersstat("agrkills");
		self maps/mp/gametypes/_globallogic_score::initpersstat("hacks",0);
		self.x2score = self maps/mp/gametypes/_globallogic_score::getpersstat("hacks");
		self maps/mp/gametypes/_globallogic_score::initpersstat("killsconfirmed",0);
		self.killsconfirmed = self maps/mp/gametypes/_globallogic_score::getpersstat("killsconfirmed");
		self maps/mp/gametypes/_globallogic_score::initpersstat("killsdenied",0);
		self.killsdenied = self maps/mp/gametypes/_globallogic_score::getpersstat("killsdenied");
		self maps/mp/gametypes/_globallogic_score::initpersstat("sessionbans",0);
		self.sessionbans = self maps/mp/gametypes/_globallogic_score::getpersstat("sessionbans");
		self maps/mp/gametypes/_globallogic_score::initpersstat("gametypeban",0);
		self maps/mp/gametypes/_globallogic_score::initpersstat("time_played_total",0);
		self maps/mp/gametypes/_globallogic_score::initpersstat("time_played_alive",0);
		self maps/mp/gametypes/_globallogic_score::initpersstat("teamkills",0);
		self maps/mp/gametypes/_globallogic_score::initpersstat("teamkills_nostats",0);
		self.teamkillpunish = 0;
		if(level.minimumallowedteamkills >= 0 && self.pers["teamkills_nostats"] > level.minimumallowedteamkills)
		{
			self thread reduceteamkillsovertime();
		}
	}

	if(GetDvar(#"F7B30924") == "1")
	{
		level waittill("eternity");
	}

	self.killedplayerscurrent = [];
	if(!(IsDefined(self.pers["best_kill_streak"])))
	{
		self.pers["killed_players"] = [];
		self.pers["killed_by"] = [];
		self.pers["nemesis_tracking"] = [];
		self.pers["artillery_kills"] = 0;
		self.pers["dog_kills"] = 0;
		self.pers["nemesis_name"] = "";
		self.pers["nemesis_rank"] = 0;
		self.pers["nemesis_rankIcon"] = 0;
		self.pers["nemesis_xp"] = 0;
		self.pers["nemesis_xuid"] = "";
		self.pers["best_kill_streak"] = 0;
	}

	if(!(IsDefined(self.pers["music"])))
	{
		self.pers["music"] = spawnstruct();
		self.pers["music"].spawn = 0;
		self.pers["music"].inque = 0;
		self.pers["music"].currentstate = "SILENT";
		self.pers["music"].previousstate = "SILENT";
		self.pers["music"].nextstate = "UNDERSCORE";
		self.pers["music"].returnstate = "UNDERSCORE";
	}

	self.leaderdialogqueue = [];
	self.leaderdialogactive = 0;
	self.leaderdialoggroups = [];
	self.currentleaderdialoggroup = "";
	self.currentleaderdialog = "";
	self.currentleaderdialogtime = 0;
	if(!(IsDefined(self.pers["cur_kill_streak"])))
	{
		self.pers["cur_kill_streak"] = 0;
	}

	if(!(IsDefined(self.pers["cur_total_kill_streak"])))
	{
		self.pers["cur_total_kill_streak"] = 0;
		self setplayercurrentstreak(0);
	}

	if(!(IsDefined(self.pers["totalKillstreakCount"])))
	{
		self.pers["totalKillstreakCount"] = 0;
	}

	if(!(IsDefined(self.pers["killstreaksEarnedThisKillstreak"])))
	{
		self.pers["killstreaksEarnedThisKillstreak"] = 0;
	}

	if(IsDefined(level.usingscorestreaks) && level.usingscorestreaks && !IsDefined(self.pers["killstreak_quantity"]))
	{
		self.pers["killstreak_quantity"] = [];
	}

	if(IsDefined(level.usingscorestreaks) && level.usingscorestreaks && !IsDefined(self.pers["held_killstreak_ammo_count"]))
	{
		self.pers["held_killstreak_ammo_count"] = [];
	}

	if(IsDefined(level.usingscorestreaks) && level.usingscorestreaks && !IsDefined(self.pers["held_killstreak_clip_count"]))
	{
		self.pers["held_killstreak_clip_count"] = [];
	}

	if(!(IsDefined(self.pers["changed_class"])))
	{
		self.pers["changed_class"] = 0;
	}

	self.lastkilltime = 0;
	self.cur_death_streak = 0;
	self disabledeathstreak();
	self.death_streak = 0;
	self.kill_streak = 0;
	self.gametype_kill_streak = 0;
	self.spawnqueueindex = -1;
	self.deathtime = 0;
	if(level.onlinegame)
	{
		self.death_streak = self getdstat("HighestStats","death_streak");
		self.kill_streak = self getdstat("HighestStats","kill_streak");
		self.gametype_kill_streak = self maps/mp/gametypes/_persistence::statgetwithgametype("kill_streak");
	}

	self.lastgrenadesuicidetime = -1;
	self.teamkillsthisround = 0;
	if(!IsDefined(level.livesdonotreset) || !level.livesdonotreset || !IsDefined(self.pers["lives"]))
	{
		self.pers["lives"] = level.numlives;
	}

	if(!(level.teambased))
	{
		self.pers["team"] = undefined;
	}

	self.hasspawned = 0;
	self.waitingtospawn = 0;
	self.wantsafespawn = 0;
	self.deathcount = 0;
	self.wasaliveatmatchstart = 0;
	self thread maps/mp/_flashgrenades::monitorflash();
	level.players[level.players.size] = self;
	if(level.splitscreen)
	{
		setdvar("splitscreen_playerNum",level.players.size);
	}

	if(game["state"] == "postgame")
	{
		self.pers["needteam"] = 1;
		self.pers["team"] = "spectator";
		self.team = "spectator";
		self setclientuivisibilityflag("hud_visible",0);
		self [[ level.spawnintermission ]]();
		self closemenu();
		self closeingamemenu();
		profilelog_endtiming(4,"gs=" + game["state"] + " zom=" + sessionmodeiszombiesgame());
		return;
	}

	if((level.rankedmatch || level.wagermatch || level.leaguematch) && !IsDefined(self.pers["lossAlreadyReported"]))
	{
		if(level.leaguematch)
		{
			self recordleaguepreloser();
		}

		maps/mp/gametypes/_globallogic_score::updatelossstats(self);
		self.pers["lossAlreadyReported"] = 1;
	}

	if(!(IsDefined(self.pers["winstreakAlreadyCleared"])))
	{
		self maps/mp/gametypes/_globallogic_score::backupandclearwinstreaks();
		self.pers["winstreakAlreadyCleared"] = 1;
	}

	if(self istestclient())
	{
		self.pers["isBot"] = 1;
	}

	if(level.rankedmatch || level.leaguematch)
	{
		self maps/mp/gametypes/_persistence::setafteractionreportstat("demoFileID","0");
	}

	level endon("game_ended");
	if(IsDefined(level.hostmigrationtimer))
	{
		self thread maps/mp/gametypes/_hostmigration::hostmigrationtimerthink();
	}

	if(level.oldschool)
	{
		self.pers["class"] = undefined;
		self.class = self.pers["class"];
	}

	if(IsDefined(self.pers["team"]))
	{
		self.team = self.pers["team"];
	}

	if(IsDefined(self.pers["class"]))
	{
		self.class = self.pers["class"];
	}

	if(!IsDefined(self.pers["team"]) || IsDefined(self.pers["needteam"]))
	{
		self.pers["needteam"] = undefined;
		self.pers["team"] = "spectator";
		self.team = "spectator";
		self.sessionstate = "dead";
		self maps/mp/gametypes/_globallogic_ui::updateobjectivetext();
		[[ level.spawnspectator ]]();
		[[ level.autoassign ]](0);
		if(level.rankedmatch || level.leaguematch)
		{
			self thread maps/mp/gametypes/_globallogic_spawn::kickifdontspawn();
		}

		if(self.pers["team"] == "spectator")
		{
			self.sessionteam = "spectator";
			if(!(level.teambased))
			{
				self.ffateam = "spectator";
			}

			self thread spectate_player_watcher();
		}

		if(level.teambased)
		{
			self.sessionteam = self.pers["team"];
			if(!(isalive(self)))
			{
				self.statusicon = "hud_status_dead";
			}

			self thread maps/mp/gametypes/_spectating::setspectatepermissions();
		}
	}
	else if(self.pers["team"] == "spectator")
	{
		self setclientscriptmainmenu(game["menu_class"]);
		[[ level.spawnspectator ]]();
		self.sessionteam = "spectator";
		self.sessionstate = "spectator";
		if(!(level.teambased))
		{
			self.ffateam = "spectator";
		}

		self thread spectate_player_watcher();
	}
	else
	{
		self.sessionteam = self.pers["team"];
		self.sessionstate = "dead";
		if(!(level.teambased))
		{
			self.ffateam = self.pers["team"];
		}

		self maps/mp/gametypes/_globallogic_ui::updateobjectivetext();
		[[ level.spawnspectator ]]();
		if(maps/mp/gametypes/_globallogic_utils::isvalidclass(self.pers["class"]))
		{
			self thread [[ level.spawnclient ]]();
		}
		else
		{
			self maps/mp/gametypes/_globallogic_ui::showmainmenuforteam();
		}

		self thread maps/mp/gametypes/_spectating::setspectatepermissions();
	}

	if(self.sessionteam != "spectator")
	{
		self thread maps/mp/gametypes/_spawning::onspawnplayer_unified(1);
	}

	profilelog_endtiming(4,"gs=" + game["state"] + " zom=" + sessionmodeiszombiesgame());
	if(IsDefined(self.pers["isBot"]))
	{
	}

//Function Number: 3
spectate_player_watcher()
{
	self endon("disconnect");
	if(!level.splitscreen && !level.hardcoremode && GetDvarInt(#"BB4CAD78") == 1 && game["state"] != "postgame" && !IsDefined(self.perkhudelem))
	{
		if(level.perksenabled == 1)
		{
			self maps/mp/gametypes/_hud_util::showperks();
		}

		self thread maps/mp/gametypes/_globallogic_ui::hideloadoutaftertime(0);
	}

	self.watchingactiveclient = 1;
	self.waitingforplayerstext = undefined;
	while(1)
	{
		if(self.pers["team"] != "spectator" || level.gameended)
		{
			self maps/mp/gametypes/_hud_message::clearshoutcasterwaitingmessage();
			self freezecontrols(0);
			self.watchingactiveclient = 0;
			break;
		}
		else
		{
			count = 0;
			for(i = 0;i < level.players.size;i++)
			{
				if(level.players[i].team != "spectator")
				{
					count++;
					break;
				}
			}

			if(count > 0)
			{
				if(!(self.watchingactiveclient))
				{
					self maps/mp/gametypes/_hud_message::clearshoutcasterwaitingmessage();
					self freezecontrols(0);
				}

				self.watchingactiveclient = 1;
			}
			else
			{
				if(self.watchingactiveclient)
				{
					[[ level.onspawnspectator ]]();
					self freezecontrols(1);
					self maps/mp/gametypes/_hud_message::setshoutcasterwaitingmessage();
				}

				self.watchingactiveclient = 0;
			}

			wait(0.5);
		}
	}
}

//Function Number: 4
callback_playermigrated()
{
/#
	println("Player " + self.name + " finished migrating at time " + GetTime());
#/
	if(IsDefined(self.connected) && self.connected)
	{
		self maps/mp/gametypes/_globallogic_ui::updateobjectivetext();
	}

	level.hostmigrationreturnedplayercount++;
	if(level.hostmigrationreturnedplayercount >= level.players.size * 2 / 3)
	{
/#
		println("2/3 of players have finished migrating");
#/
		level notify("hostmigration_enoughplayers");
	}
}

//Function Number: 5
callback_playerdisconnect()
{
	profilelog_begintiming(5,"ship");
	if(game["state"] != "postgame" && !level.gameended)
	{
		gamelength = maps/mp/gametypes/_globallogic::getgamelength();
		self maps/mp/gametypes/_globallogic::bbplayermatchend(gamelength,"MP_PLAYER_DISCONNECT",0);
	}

	self removeplayerondisconnect();
	if(level.splitscreen)
	{
		players = level.players;
		if(players.size <= 1)
		{
			level thread maps/mp/gametypes/_globallogic::forceend();
		}

		setdvar("splitscreen_playerNum",players.size);
	}

	if(IsDefined(self.score) && IsDefined(self.pers["team"]))
	{
		self logstring("team: score " + self.pers["team"] + ":" + self.score);
		level.dropteam = level.dropteam + 1;
	}

	[[ level.onplayerdisconnect ]]();
	lpselfnum = self getentitynumber();
	lpguid = self getguid();
	logprint("Q;" + lpguid + ";" + lpselfnum + ";" + self.name + "\n");
	self maps/mp/_gamerep::gamerepplayerdisconnected();
	for(entry = 0;entry < level.players.size;entry++)
	{
		if(level.players[entry] == self)
		{
			while(entry < level.players.size - 1)
			{
				level.players[entry] = level.players[entry + 1];
				entry++;
			}

			level.players[entry] = undefined;
			break;
		}
	}

	for(entry = 0;entry < level.players.size;entry++)
	{
		if(IsDefined(level.players[entry].pers["killed_players"][self.name]))
		{
			level.players[entry].pers["killed_players"][self.name] = undefined;
		}

		if(IsDefined(level.players[entry].killedplayerscurrent[self.name]))
		{
			level.players[entry].killedplayerscurrent[self.name] = undefined;
		}

		if(IsDefined(level.players[entry].pers["killed_by"][self.name]))
		{
			level.players[entry].pers["killed_by"][self.name] = undefined;
		}

		if(IsDefined(level.players[entry].pers["nemesis_tracking"][self.name]))
		{
			level.players[entry].pers["nemesis_tracking"][self.name] = undefined;
		}

		if(level.players[entry].pers["nemesis_name"] == self.name)
		{
			level.players[entry] choosenextbestnemesis();
		}
	}

	if(level.gameended)
	{
		self maps/mp/gametypes/_globallogic::removedisconnectedplayerfromplacement();
	}

	level thread maps/mp/gametypes/_globallogic::updateteamstatus();
	profilelog_endtiming(5,"gs=" + game["state"] + " zom=" + sessionmodeiszombiesgame());
}

//Function Number: 6
callback_playermelee(eattacker,idamage,sweapon,vorigin,vdir,boneindex,shieldhit)
{
	hit = 1;
	if(level.teambased && self.team == eattacker.team)
	{
		if(level.friendlyfire == 0)
		{
			hit = 0;
		}
	}

	self finishmeleehit(eattacker,sweapon,vorigin,vdir,boneindex,shieldhit,hit);
}

//Function Number: 7
choosenextbestnemesis()
{
	nemesisarray = self.pers["nemesis_tracking"];
	nemesisarraykeys = getarraykeys(nemesisarray);
	nemesisamount = 0;
	nemesisname = "";
	if(nemesisarraykeys.size > 0)
	{
		for(i = 0;i < nemesisarraykeys.size;i++)
		{
			nemesisarraykey = nemesisarraykeys[i];
			if(nemesisarray[nemesisarraykey] > nemesisamount)
			{
				nemesisname = nemesisarraykey;
				nemesisamount = nemesisarray[nemesisarraykey];
			}
		}
	}

	self.pers["nemesis_name"] = nemesisname;
	if(nemesisname != "")
	{
		for(playerindex = 0;playerindex < level.players.size;playerindex++)
		{
			if(level.players[playerindex].name == nemesisname)
			{
				nemesisplayer = level.players[playerindex];
				self.pers["nemesis_rank"] = nemesisplayer.pers["rank"];
				self.pers["nemesis_rankIcon"] = nemesisplayer.pers["rankxp"];
				self.pers["nemesis_xp"] = nemesisplayer.pers["prestige"];
				self.pers["nemesis_xuid"] = nemesisplayer getxuid(1);
				break;
			}
		}
	}
	else
	{
		self.pers["nemesis_xuid"] = "";
	}
}

//Function Number: 8
removeplayerondisconnect()
{
	for(entry = 0;entry < level.players.size;entry++)
	{
		if(level.players[entry] == self)
		{
			while(entry < level.players.size - 1)
			{
				level.players[entry] = level.players[entry + 1];
				entry++;
			}

			level.players[entry] = undefined;
			break;
		}
	}
}

//Function Number: 9
custom_gamemodes_modified_damage(victim,eattacker,idamage,smeansofdeath,sweapon,einflictor,shitloc)
{
	if(level.onlinegame && !sessionmodeisprivate())
	{
		return idamage;
	}

	if(IsDefined(eattacker) && IsDefined(eattacker.damagemodifier))
	{
		idamage = idamage * eattacker.damagemodifier;
	}

	if(smeansofdeath == "MOD_PISTOL_BULLET" || smeansofdeath == "MOD_RIFLE_BULLET")
	{
		idamage = int(idamage * level.bulletdamagescalar);
	}

	return idamage;
}

//Function Number: 10
figureoutattacker(eattacker)
{
	if(IsDefined(eattacker))
	{
		if(isai(eattacker) && IsDefined(eattacker.script_owner))
		{
			team = self.team;
			if(isai(self) && IsDefined(self.aiteam))
			{
				team = self.aiteam;
			}

			if(eattacker.script_owner.team != team)
			{
				eattacker = eattacker.script_owner;
			}
		}

		if(eattacker.classname == "script_vehicle" && IsDefined(eattacker.owner))
		{
			eattacker = eattacker.owner;
		}
		else if(eattacker.classname == "auto_turret" && IsDefined(eattacker.owner))
		{
			eattacker = eattacker.owner;
		}
	}

	return eattacker;
}

//Function Number: 11
figureoutweapon(sweapon,einflictor)
{
	if(sweapon == "none" && IsDefined(einflictor))
	{
		if(IsDefined(einflictor.targetname) && einflictor.targetname == "explodable_barrel")
		{
			sweapon = "explodable_barrel_mp";
		}
		else if(IsDefined(einflictor.destructible_type) && issubstr(einflictor.destructible_type,"vehicle_"))
		{
			sweapon = "destructible_car_mp";
		}
	}

	return sweapon;
}

//Function Number: 12
isplayerimmunetokillstreak(eattacker,sweapon)
{
	if(level.hardcoremode)
	{
		return 0;
	}

	if(!(IsDefined(eattacker)))
	{
		return 0;
	}

	if(self != eattacker)
	{
		return 0;
	}

	if(sweapon != "straferun_gun_mp" && sweapon != "straferun_rockets_mp")
	{
		return 0;
	}
}

//Function Number: 13
callback_playerdamage(einflictor,eattacker,idamage,idflags,smeansofdeath,sweapon,vpoint,vdir,shitloc,psoffsettime,boneindex)
{
	profilelog_begintiming(6,"ship");
	if(game["state"] == "postgame")
	{
		return;
	}

	if(self.sessionteam == "spectator")
	{
		return;
	}

	if(IsDefined(self.candocombat) && !self.candocombat)
	{
		return;
	}

	if(IsDefined(eattacker) && isplayer(eattacker) && IsDefined(eattacker.candocombat) && !eattacker.candocombat)
	{
		return;
	}

	if(IsDefined(level.hostmigrationtimer))
	{
		return;
	}

	if((sweapon == "ai_tank_drone_gun_mp" || sweapon == "ai_tank_drone_rocket_mp") && !level.hardcoremode)
	{
		if(IsDefined(eattacker) && eattacker == self)
		{
			if(IsDefined(einflictor) && IsDefined(einflictor.from_ai))
			{
				return;
			}
		}

		if(IsDefined(eattacker) && IsDefined(eattacker.owner) && eattacker.owner == self)
		{
			return;
		}
	}

	if(sweapon == "emp_grenade_mp")
	{
		if(self hasperk("specialty_immuneemp"))
		{
			return;
		}

		self notify("emp_grenaded",eattacker);
	}

	if(IsDefined(eattacker))
	{
		idamage = maps/mp/gametypes/_class::cac_modified_damage(self,eattacker,idamage,smeansofdeath,sweapon,einflictor,shitloc);
	}

	idamage = custom_gamemodes_modified_damage(self,eattacker,idamage,smeansofdeath,sweapon,einflictor,shitloc);
	idamage = int(idamage);
	self.idflags = idflags;
	self.idflagstime = GetTime();
	eattacker = figureoutattacker(eattacker);
	pixbeginevent("PlayerDamage flags/tweaks");
	if(!(IsDefined(vdir)))
	{
		idflags = idflags | level.idflags_no_knockback;
	}

	friendly = 0;
	if(self.health != self.maxhealth)
	{
		self notify("snd_pain_player");
	}

	if(IsDefined(einflictor) && IsDefined(einflictor.script_noteworthy))
	{
		if(einflictor.script_noteworthy == "ragdoll_now")
		{
			smeansofdeath = "MOD_FALLING";
		}

		if(IsDefined(level.overrideweaponfunc))
		{
			sweapon = [[ level.overrideweaponfunc ]](sweapon,einflictor.script_noteworthy);
		}
	}

	if(maps/mp/gametypes/_globallogic_utils::isheadshot(sweapon,shitloc,smeansofdeath,einflictor) && isplayer(eattacker))
	{
		smeansofdeath = "MOD_HEAD_SHOT";
	}

	if(level.onplayerdamage != maps/mp/gametypes/_globallogic::blank)
	{
		modifieddamage = [[ level.onplayerdamage ]](einflictor,eattacker,idamage,idflags,smeansofdeath,sweapon,vpoint,vdir,shitloc,psoffsettime);
		if(IsDefined(modifieddamage))
		{
			if(modifieddamage <= 0)
			{
				return;
			}

			idamage = modifieddamage;
		}
	}

	if(level.onlyheadshots)
	{
		if(smeansofdeath == "MOD_PISTOL_BULLET" || smeansofdeath == "MOD_RIFLE_BULLET")
		{
			return;
		}
		else if(smeansofdeath == "MOD_HEAD_SHOT")
		{
			idamage = 150;
		}
	}

	if(self maps/mp/_vehicles::player_is_occupant_invulnerable(smeansofdeath))
	{
		return;
	}

	if(IsDefined(eattacker) && isplayer(eattacker) && self.team != eattacker.team)
	{
		self.lastattackweapon = sweapon;
	}

	sweapon = figureoutweapon(sweapon,einflictor);
	pixendevent();
	if(idflags & level.idflags_penetration && isplayer(eattacker) && eattacker hasperk("specialty_bulletpenetration"))
	{
		self thread maps/mp/gametypes/_battlechatter_mp::perkspecificbattlechatter("deepimpact",1);
	}

	attackerishittingteammate = isplayer(eattacker) && self isenemyplayer(eattacker) == 0;
	if(shitloc == "riotshield")
	{
		if(attackerishittingteammate && level.friendlyfire == 0)
		{
			return;
		}

		if((smeansofdeath == "MOD_PISTOL_BULLET" || smeansofdeath == "MOD_RIFLE_BULLET") && !maps/mp/killstreaks/_killstreaks::iskillstreakweapon(sweapon) && !attackerishittingteammate)
		{
			if(self.hasriotshieldequipped)
			{
				if(isplayer(eattacker))
				{
					eattacker.lastattackedshieldplayer = self;
					eattacker.lastattackedshieldtime = GetTime();
				}

				previous_shield_damage = self.shielddamageblocked;
				self.shielddamageblocked = self.shielddamageblocked + idamage;
				if(self.shielddamageblocked % 400 < previous_shield_damage % 400)
				{
					score_event = "shield_blocked_damage";
					if(self.shielddamageblocked > 2000)
					{
						score_event = "shield_blocked_damage_reduced";
					}

					if(IsDefined(level.scoreinfo[score_event]["value"]))
					{
						self addweaponstat("riotshield_mp","score_from_blocked_damage",level.scoreinfo[score_event]["value"]);
					}

					thread maps/mp/_scoreevents::processscoreevent(score_event,self);
				}
			}
		}

		if(idflags & level.idflags_shield_explosive_impact)
		{
			shitloc = "none";
			if(!(idflags & level.idflags_shield_explosive_impact_huge))
			{
				idamage = idamage * 0;
			}
		}
		else if(idflags & level.idflags_shield_explosive_splash)
		{
			if(IsDefined(einflictor) && IsDefined(einflictor.stucktoplayer) && einflictor.stucktoplayer == self)
			{
				idamage = 101;
			}

			shitloc = "none";
		}
		else
		{
			return;
		}
	}

	if(!(idflags & level.idflags_no_protection))
	{
		if(IsDefined(einflictor) && smeansofdeath == "MOD_GAS" || maps/mp/gametypes/_class::isexplosivedamage(undefined,smeansofdeath))
		{
			if((einflictor.classname == "grenade" || sweapon == "tabun_gas_mp") && self.lastspawntime + 3500 > GetTime() && distancesquared(einflictor.origin,self.lastspawnpoint.origin) < 62500)
			{
				return;
			}

			if(self isplayerimmunetokillstreak(eattacker,sweapon))
			{
				return;
			}

			self.explosiveinfo = [];
			self.explosiveinfo["damageTime"] = GetTime();
			self.explosiveinfo["damageId"] = einflictor getentitynumber();
			self.explosiveinfo["originalOwnerKill"] = 0;
			self.explosiveinfo["bulletPenetrationKill"] = 0;
			self.explosiveinfo["chainKill"] = 0;
			self.explosiveinfo["damageExplosiveKill"] = 0;
			self.explosiveinfo["chainKill"] = 0;
			self.explosiveinfo["cookedKill"] = 0;
			self.explosiveinfo["weapon"] = sweapon;
			self.explosiveinfo["originalowner"] = einflictor.originalowner;
			isfrag = sweapon == "frag_grenade_mp";
			if(IsDefined(eattacker) && eattacker != self)
			{
				if(IsDefined(eattacker) && IsDefined(einflictor.owner) && sweapon == "satchel_charge_mp" || sweapon == "claymore_mp" || sweapon == "bouncingbetty_mp")
				{
					self.explosiveinfo["originalOwnerKill"] = einflictor.owner == self;
					self.explosiveinfo["damageExplosiveKill"] = IsDefined(einflictor.wasdamaged);
					self.explosiveinfo["chainKill"] = IsDefined(einflictor.waschained);
					self.explosiveinfo["wasJustPlanted"] = IsDefined(einflictor.wasjustplanted);
					self.explosiveinfo["bulletPenetrationKill"] = IsDefined(einflictor.wasdamagedfrombulletpenetration);
					self.explosiveinfo["cookedKill"] = 0;
				}

				if((sweapon == "sticky_grenade_mp" || sweapon == "explosive_bolt_mp") && IsDefined(einflictor) && IsDefined(einflictor.stucktoplayer))
				{
					self.explosiveinfo["stuckToPlayer"] = einflictor.stucktoplayer;
				}

				if(sweapon == "proximity_grenade_mp" || sweapon == "proximity_grenade_aoe_mp")
				{
					self.laststunnedby = eattacker;
					self.laststunnedtime = self.idflagstime;
				}

				if(IsDefined(eattacker.lastgrenadesuicidetime) && eattacker.lastgrenadesuicidetime >= GetTime() - 50 && isfrag)
				{
					self.explosiveinfo["suicideGrenadeKill"] = 1;
				}
				else
				{
					self.explosiveinfo["suicideGrenadeKill"] = 0;
				}
			}

			if(isfrag)
			{
				self.explosiveinfo["cookedKill"] = IsDefined(einflictor.iscooked);
				self.explosiveinfo["throwbackKill"] = IsDefined(einflictor.threwback);
			}

			if(IsDefined(eattacker) && isplayer(eattacker) && eattacker != self)
			{
				self maps/mp/gametypes/_globallogic_score::setinflictorstat(einflictor,eattacker,sweapon);
			}
		}

		if(smeansofdeath == "MOD_IMPACT" && IsDefined(eattacker) && isplayer(eattacker) && eattacker != self)
		{
			if(sweapon != "knife_ballistic_mp")
			{
				self maps/mp/gametypes/_globallogic_score::setinflictorstat(einflictor,eattacker,sweapon);
			}

			if(sweapon == "hatchet_mp" && IsDefined(einflictor))
			{
				self.explosiveinfo["projectile_bounced"] = IsDefined(einflictor.bounced);
			}
		}

		if(isplayer(eattacker))
		{
			eattacker.pers["participation"]++;
		}

		prevhealthratio = self.health / self.maxhealth;
		if(level.teambased && isplayer(eattacker) && self != eattacker && self.team == eattacker.team)
		{
			pixmarker("BEGIN: PlayerDamage player");
			if(level.friendlyfire == 0)
			{
				if(sweapon == "artillery_mp" || sweapon == "airstrike_mp" || sweapon == "napalm_mp" || sweapon == "mortar_mp")
				{
					self damageshellshockandrumble(eattacker,einflictor,sweapon,smeansofdeath,idamage);
				}

				return;
			}
			else if(level.friendlyfire == 1)
			{
				if(idamage < 1)
				{
					idamage = 1;
				}

				if(level.friendlyfiredelay && level.friendlyfiredelaytime >= GetTime() - level.starttime - level.discardtime / 1000)
				{
					eattacker.lastdamagewasfromenemy = 0;
					eattacker.friendlydamage = 1;
					eattacker finishplayerdamagewrapper(einflictor,eattacker,idamage,idflags,smeansofdeath,sweapon,vpoint,vdir,shitloc,psoffsettime,boneindex);
					eattacker.friendlydamage = undefined;
				}
				else
				{
					self.lastdamagewasfromenemy = 0;
					self finishplayerdamagewrapper(einflictor,eattacker,idamage,idflags,smeansofdeath,sweapon,vpoint,vdir,shitloc,psoffsettime,boneindex);
				}
			}
			else if(level.friendlyfire == 2 && isalive(eattacker))
			{
				idamage = int(idamage * 0.5);
				if(idamage < 1)
				{
					idamage = 1;
				}

				eattacker.lastdamagewasfromenemy = 0;
				eattacker.friendlydamage = 1;
				eattacker finishplayerdamagewrapper(einflictor,eattacker,idamage,idflags,smeansofdeath,sweapon,vpoint,vdir,shitloc,psoffsettime,boneindex);
				eattacker.friendlydamage = undefined;
			}
			else if(level.friendlyfire == 3 && isalive(eattacker))
			{
				idamage = int(idamage * 0.5);
				if(idamage < 1)
				{
					idamage = 1;
				}

				self.lastdamagewasfromenemy = 0;
				eattacker.lastdamagewasfromenemy = 0;
				self finishplayerdamagewrapper(einflictor,eattacker,idamage,idflags,smeansofdeath,sweapon,vpoint,vdir,shitloc,psoffsettime,boneindex);
				eattacker.friendlydamage = 1;
				eattacker finishplayerdamagewrapper(einflictor,eattacker,idamage,idflags,smeansofdeath,sweapon,vpoint,vdir,shitloc,psoffsettime,boneindex);
				eattacker.friendlydamage = undefined;
			}

			friendly = 1;
			pixmarker("END: PlayerDamage player");
		}
		else
		{
			if(idamage < 1)
			{
				idamage = 1;
			}

			if(IsDefined(eattacker) && isplayer(eattacker) && allowedassistweapon(sweapon))
			{
				self trackattackerdamage(eattacker,idamage,smeansofdeath,sweapon);
			}

			giveinflictorownerassist(eattacker,einflictor,idamage,smeansofdeath,sweapon);
			if(IsDefined(eattacker))
			{
				level.lastlegitimateattacker = eattacker;
			}

			if(IsDefined(eattacker) && isplayer(eattacker) && IsDefined(sweapon) && !issubstr(smeansofdeath,"MOD_MELEE"))
			{
				eattacker thread maps/mp/gametypes/_weapons::checkhit(sweapon);
			}

			if((smeansofdeath == "MOD_GRENADE" || smeansofdeath == "MOD_GRENADE_SPLASH") && IsDefined(einflictor.iscooked))
			{
				self.wascooked = GetTime();
			}
			else
			{
				self.wascooked = undefined;
			}

			self.lastdamagewasfromenemy = IsDefined(eattacker) && eattacker != self;
			if(self.lastdamagewasfromenemy)
			{
				if(isplayer(eattacker))
				{
					if(IsDefined(eattacker.damagedplayers[self.clientid]) == 0)
					{
						eattacker.damagedplayers[self.clientid] = spawnstruct();
					}

					eattacker.damagedplayers[self.clientid].time = GetTime();
					eattacker.damagedplayers[self.clientid].entity = self;
				}
			}

			self finishplayerdamagewrapper(einflictor,eattacker,idamage,idflags,smeansofdeath,sweapon,vpoint,vdir,shitloc,psoffsettime,boneindex);
		}

		if(IsDefined(eattacker) && isplayer(eattacker) && eattacker != self)
		{
			if(dodamagefeedback(sweapon,einflictor,idamage,smeansofdeath))
			{
				if(idamage > 0)
				{
					if(self.health > 0)
					{
						perkfeedback = doperkfeedback(self,sweapon,smeansofdeath,einflictor);
					}

					eattacker thread maps/mp/gametypes/_damagefeedback::updatedamagefeedback(smeansofdeath,einflictor,perkfeedback);
				}
			}
		}

		self.hasdonecombat = 1;
	}

	if(IsDefined(eattacker) && eattacker != self && !friendly)
	{
		level.usestartspawns = 0;
	}

	pixbeginevent("PlayerDamage log");
/#
	println("client:" + self getentitynumber() + " health:" + self.health + " attacker:" + eattacker.clientid + " inflictor is player:" + isplayer(einflictor) + " damage:" + idamage + " hitLoc:" + shitloc);
GetDvarInt(#"B1AE74B1")
#/
	if(self.sessionstate != "dead")
	{
		lpselfnum = self getentitynumber();
		lpselfname = self.name;
		lpselfteam = self.team;
		lpselfguid = self getguid();
		lpattackerteam = "";
		lpattackerorigin = (0,0,0);
		if(isplayer(eattacker))
		{
			lpattacknum = eattacker getentitynumber();
			lpattackguid = eattacker getguid();
			lpattackname = eattacker.name;
			lpattackerteam = eattacker.team;
			lpattackerorigin = eattacker.origin;
			bbprint("mpattacks","gametime %d attackerspawnid %d attackerweapon %s attackerx %d attackery %d attackerz %d victimspawnid %d victimx %d victimy %d victimz %d damage %d damagetype %s damagelocation %s death %d",GetTime(),getplayerspawnid(eattacker),sweapon,lpattackerorigin,getplayerspawnid(self),self.origin,idamage,smeansofdeath,shitloc,0);
		}
		else
		{
			lpattacknum = -1;
			lpattackguid = "";
			lpattackname = "";
			lpattackerteam = "world";
			bbprint("mpattacks","gametime %d attackerweapon %s victimspawnid %d victimx %d victimy %d victimz %d damage %d damagetype %s damagelocation %s death %d",GetTime(),sweapon,getplayerspawnid(self),self.origin,idamage,smeansofdeath,shitloc,0);
		}

		logprint("D;" + lpselfguid + ";" + lpselfnum + ";" + lpselfteam + ";" + lpselfname + ";" + lpattackguid + ";" + lpattacknum + ";" + lpattackerteam + ";" + lpattackname + ";" + sweapon + ";" + idamage + ";" + smeansofdeath + ";" + shitloc + "\n");
	}

	pixendevent();
	profilelog_endtiming(6,"gs=" + game["state"] + " zom=" + sessionmodeiszombiesgame());
}

//Function Number: 14
resetattackerlist()
{
	self.attackers = [];
	self.attackerdata = [];
	self.attackerdamage = [];
	self.firsttimedamaged = 0;
}

//Function Number: 15
dodamagefeedback(sweapon,einflictor,idamage,smeansofdeath)
{
	if(!(IsDefined(sweapon)))
	{
		return 0;
	}

	if(level.allowhitmarkers == 0)
	{
		return 0;
	}

	if(level.allowhitmarkers == 1)
	{
		if(IsDefined(smeansofdeath) && IsDefined(idamage))
		{
			if(istacticalhitmarker(sweapon,smeansofdeath,idamage))
			{
				return 0;
			}
		}
	}

	return 1;
}

//Function Number: 16
istacticalhitmarker(sweapon,smeansofdeath,idamage)
{
	if(isgrenade(sweapon))
	{
		if(sweapon == "willy_pete_mp")
		{
			if(smeansofdeath == "MOD_GRENADE_SPLASH")
			{
				return 1;
			}
		}
		else if(idamage == 1)
		{
			return 1;
		}
	}
}

//Function Number: 17
doperkfeedback(player,sweapon,smeansofdeath,einflictor)
{
	perkfeedback = undefined;
	hastacticalmask = maps/mp/gametypes/_class::hastacticalmask(player);
	hasflakjacket = player hasperk("specialty_flakjacket");
	isexplosivedamage = maps/mp/gametypes/_class::isexplosivedamage(sweapon,smeansofdeath);
	isflashorstundamage = maps/mp/gametypes/_weapon_utils::isflashorstundamage(sweapon,smeansofdeath);
	if(isflashorstundamage && hastacticalmask)
	{
		perkfeedback = "tacticalMask";
	}
	else if(isexplosivedamage && hasflakjacket && !isaikillstreakdamage(sweapon,einflictor))
	{
		perkfeedback = "flakjacket";
	}

	return perkfeedback;
}

//Function Number: 18
isaikillstreakdamage(sweapon,einflictor)
{
	switch(sweapon)
	{
		case "ai_tank_drone_rocket_mp":
			return IsDefined(einflictor.firedbyai);

		case "missile_swarm_projectile_mp":
			return 1;

		case "planemortar_mp":
			return 1;

		case "chopper_minigun_mp":
			return 1;

		case "straferun_rockets_mp":
			return 1;

		case "littlebird_guard_minigun_mp":
			return 1;

		case "cobra_20mm_comlink_mp":
			return 1;
	}

	return 0;
}

//Function Number: 19
finishplayerdamagewrapper(einflictor,eattacker,idamage,idflags,smeansofdeath,sweapon,vpoint,vdir,shitloc,psoffsettime,boneindex)
{
	pixbeginevent("finishPlayerDamageWrapper");
	if(!level.console && idflags & level.idflags_penetration && isplayer(eattacker))
	{
/#
		println("penetrated:" + self getentitynumber() + " health:" + self.health + " attacker:" + eattacker.clientid + " inflictor is player:" + isplayer(einflictor) + " damage:" + idamage + " hitLoc:" + shitloc);
#/
		eattacker addplayerstat("penetration_shots",1);
	}

	self finishplayerdamage(einflictor,eattacker,idamage,idflags,smeansofdeath,sweapon,vpoint,vdir,shitloc,psoffsettime,boneindex);
	if(GetDvar(#"C8077F47") != "")
	{
		self shellshock("damage_mp",0.2);
	}

	self damageshellshockandrumble(eattacker,einflictor,sweapon,smeansofdeath,idamage);
	pixendevent();
}

//Function Number: 20
allowedassistweapon(weapon)
{
	if(!(maps/mp/killstreaks/_killstreaks::iskillstreakweapon(weapon)))
	{
		return 1;
	}

	if(maps/mp/killstreaks/_killstreaks::iskillstreakweaponassistallowed(weapon))
	{
		return 1;
	}

	return 0;
}

//Function Number: 21
playerkilled_killstreaks(attacker,sweapon)
{
	if(!(IsDefined(self.switching_teams)))
	{
		if(isplayer(attacker) && level.teambased && attacker != self && self.team == attacker.team)
		{
			self.pers["cur_kill_streak"] = 0;
			self.pers["cur_total_kill_streak"] = 0;
			self.pers["totalKillstreakCount"] = 0;
			self.pers["killstreaksEarnedThisKillstreak"] = 0;
			self setplayercurrentstreak(0);
		}
		else
		{
			self maps/mp/gametypes/_globallogic_score::incpersstat("deaths",1,1,1);
			self.deaths = self maps/mp/gametypes/_globallogic_score::getpersstat("deaths");
			self updatestatratio("kdratio","kills","deaths");
			if(self.pers["cur_kill_streak"] > self.pers["best_kill_streak"])
			{
				self.pers["best_kill_streak"] = self.pers["cur_kill_streak"];
			}

			self.pers["kill_streak_before_death"] = self.pers["cur_kill_streak"];
			self.pers["cur_kill_streak"] = 0;
			self.pers["cur_total_kill_streak"] = 0;
			self.pers["totalKillstreakCount"] = 0;
			self.pers["killstreaksEarnedThisKillstreak"] = 0;
			self setplayercurrentstreak(0);
			self.cur_death_streak++;
			if(self.cur_death_streak > self.death_streak)
			{
				if(level.rankedmatch && !level.disablestattracking)
				{
					self setdstat("HighestStats","death_streak",self.cur_death_streak);
				}

				self.death_streak = self.cur_death_streak;
			}

			if(self.cur_death_streak >= GetDvarInt(#"25E82970"))
			{
				self enabledeathstreak();
			}
		}
	}
	else
	{
		self.pers["totalKillstreakCount"] = 0;
		self.pers["killstreaksEarnedThisKillstreak"] = 0;
	}

	if(!sessionmodeiszombiesgame() && maps/mp/killstreaks/_killstreaks::iskillstreakweapon(sweapon))
	{
		level.globalkillstreaksdeathsfrom++;
	}
}

//Function Number: 22
playerkilled_weaponstats(attacker,sweapon,smeansofdeath,wasinlaststand,lastweaponbeforedroppingintolaststand,inflictor)
{
	if(isplayer(attacker) && attacker != self && !level.teambased || level.teambased && self.team != attacker.team)
	{
		self addweaponstat(sweapon,"deaths",1);
		if(wasinlaststand && IsDefined(lastweaponbeforedroppingintolaststand))
		{
			weaponname = lastweaponbeforedroppingintolaststand;
		}
		else
		{
			weaponname = self.lastdroppableweapon;
		}

		if(IsDefined(weaponname))
		{
			self addweaponstat(weaponname,"deathsDuringUse",1);
		}

		if(smeansofdeath != "MOD_FALLING")
		{
			if(sweapon == "explosive_bolt_mp" && IsDefined(inflictor) && IsDefined(inflictor.ownerweaponatlaunch) && inflictor.owneradsatlaunch)
			{
				attacker addweaponstat(inflictor.ownerweaponatlaunch,"kills",1,attacker.class_num,1);
			}
			else
			{
				attacker addweaponstat(sweapon,"kills",1,attacker.class_num);
			}
		}

		if(smeansofdeath == "MOD_HEAD_SHOT")
		{
			attacker addweaponstat(sweapon,"headshots",1);
		}

		if(smeansofdeath == "MOD_PROJECTILE")
		{
			attacker addweaponstat(sweapon,"direct_hit_kills",1);
		}
	}
}

//Function Number: 23
playerkilled_obituary(attacker,einflictor,sweapon,smeansofdeath)
{
	if(!isplayer(attacker) || self isenemyplayer(attacker) == 0 || IsDefined(sweapon) && maps/mp/killstreaks/_killstreaks::iskillstreakweapon(sweapon))
	{
		level notify("reset_obituary_count");
		level.lastobituaryplayercount = 0;
		level.lastobituaryplayer = undefined;
	}
	else
	{
		if(IsDefined(level.lastobituaryplayer) && level.lastobituaryplayer == attacker)
		{
			level.lastobituaryplayercount++;
		}
		else
		{
			level notify("reset_obituary_count");
			level.lastobituaryplayer = attacker;
			level.lastobituaryplayercount = 1;
		}

		level thread maps/mp/_scoreevents::decrementlastobituaryplayercountafterfade();
		if(level.lastobituaryplayercount >= 4)
		{
			level notify("reset_obituary_count");
			level.lastobituaryplayercount = 0;
			level.lastobituaryplayer = undefined;
			self thread uninterruptedobitfeedkills(attacker,sweapon);
		}
	}

	overrideentitycamera = maps/mp/killstreaks/_killstreaks::shouldoverrideentitycameraindemo(attacker,sweapon);
	if(level.teambased && IsDefined(attacker.pers) && self.team == attacker.team && smeansofdeath == "MOD_GRENADE" && level.friendlyfire == 0)
	{
		obituary(self,self,sweapon,smeansofdeath);
		maps/mp/_demo::bookmark("kill",GetTime(),self,self,0,einflictor,overrideentitycamera);
	}
	else
	{
		obituary(self,attacker,sweapon,smeansofdeath);
		maps/mp/_demo::bookmark("kill",GetTime(),self,attacker,0,einflictor,overrideentitycamera);
	}
}

//Function Number: 24
playerkilled_suicide(einflictor,attacker,smeansofdeath,sweapon,shitloc)
{
	awardassists = 0;
	if(IsDefined(self.switching_teams))
	{
		if(!level.teambased && IsDefined(level.teams[self.leaving_team]) && IsDefined(level.teams[self.joining_team]) && level.teams[self.leaving_team] != level.teams[self.joining_team])
		{
			playercounts = self maps/mp/teams/_teams::countplayers();
			playercounts[self.leaving_team]--;
			playercounts[self.joining_team]++;
			if(playercounts[self.joining_team] - playercounts[self.leaving_team] > 1)
			{
				thread maps/mp/_scoreevents::processscoreevent("suicide",self);
				self thread maps/mp/gametypes/_rank::giverankxp("suicide");
				self maps/mp/gametypes/_globallogic_score::incpersstat("suicides",1);
				self.suicides = self maps/mp/gametypes/_globallogic_score::getpersstat("suicides");
			}
		}
	}
	else
	{
		thread maps/mp/_scoreevents::processscoreevent("suicide",self);
		self maps/mp/gametypes/_globallogic_score::incpersstat("suicides",1);
		self.suicides = self maps/mp/gametypes/_globallogic_score::getpersstat("suicides");
		if(smeansofdeath == "MOD_SUICIDE" && shitloc == "none" && self.throwinggrenade)
		{
			self.lastgrenadesuicidetime = GetTime();
		}

		if(level.maxsuicidesbeforekick > 0 && level.maxsuicidesbeforekick <= self.suicides)
		{
			self notify("teamKillKicked");
			self suicidekick();
		}

		thread maps/mp/gametypes/_battlechatter_mp::onplayersuicideorteamkill(self,"suicide");
		awardassists = 1;
		self.suicide = 1;
	}

	if(IsDefined(self.friendlydamage))
	{
		self iprintln(&"MP_FRIENDLY_FIRE_WILL_NOT");
		if(level.teamkillpointloss)
		{
			scoresub = self [[ level.getteamkillscore ]](einflictor,attacker,smeansofdeath,sweapon);
			score = maps/mp/gametypes/_globallogic_score::_getplayerscore(attacker) - scoresub;
			if(score < 0)
			{
				score = 0;
			}

			maps/mp/gametypes/_globallogic_score::_setplayerscore(attacker,score);
		}
	}

	return awardassists;
}

//Function Number: 25
playerkilled_teamkill(einflictor,attacker,smeansofdeath,sweapon,shitloc)
{
	thread maps/mp/_scoreevents::processscoreevent("team_kill",attacker);
	self.teamkilled = 1;
	if(!(ignoreteamkills(sweapon,smeansofdeath)))
	{
		teamkill_penalty = self [[ level.getteamkillpenalty ]](einflictor,attacker,smeansofdeath,sweapon);
		attacker maps/mp/gametypes/_globallogic_score::incpersstat("teamkills_nostats",teamkill_penalty,0);
		attacker maps/mp/gametypes/_globallogic_score::incpersstat("teamkills",1);
		attacker.teamkillsthisround++;
		if(level.teamkillpointloss)
		{
			scoresub = self [[ level.getteamkillscore ]](einflictor,attacker,smeansofdeath,sweapon);
			score = maps/mp/gametypes/_globallogic_score::_getplayerscore(attacker) - scoresub;
			if(score < 0)
			{
				score = 0;
			}

			maps/mp/gametypes/_globallogic_score::_setplayerscore(attacker,score);
		}

		if(maps/mp/gametypes/_globallogic_utils::gettimepassed() < 5000)
		{
			teamkilldelay = 1;
		}
		else if(attacker.pers["teamkills_nostats"] > 1 && maps/mp/gametypes/_globallogic_utils::gettimepassed() < 8000 + attacker.pers["teamkills_nostats"] * 1000)
		{
			teamkilldelay = 1;
		}
		else
		{
			teamkilldelay = attacker teamkilldelay();
		}

		if(teamkilldelay > 0)
		{
			attacker.teamkillpunish = 1;
			attacker thread wait_and_suicide();
			if(attacker shouldteamkillkick(teamkilldelay))
			{
				attacker notify("teamKillKicked");
				attacker teamkillkick();
			}

			attacker thread reduceteamkillsovertime();
		}

		if(isplayer(attacker))
		{
			thread maps/mp/gametypes/_battlechatter_mp::onplayersuicideorteamkill(attacker,"teamkill");
		}
	}
}

//Function Number: 26
wait_and_suicide()
{
	self endon("disconnect");
	self freezecontrolswrapper(1);
	wait(0.25);
	self suicide();
}

//Function Number: 27
playerkilled_awardassists(einflictor,attacker,sweapon,lpattackteam)
{
	pixbeginevent("PlayerKilled assists");
	if(IsDefined(self.attackers))
	{
		for(j = 0;j < self.attackers.size;j++)
		{
			player = self.attackers[j];
			if(!(IsDefined(player)))
			{
			}
			else if(player == attacker)
			{
			}
			else if(player.team != lpattackteam)
			{
			}
			else
			{
				damage_done = self.attackerdamage[player.clientid].damage;
				player thread maps/mp/gametypes/_globallogic_score::processassist(self,damage_done,self.attackerdamage[player.clientid].weapon);
			}
		}
	}

	if(level.teambased)
	{
		self maps/mp/gametypes/_globallogic_score::processkillstreakassists(attacker,einflictor,sweapon);
	}

	if(IsDefined(self.lastattackedshieldplayer) && IsDefined(self.lastattackedshieldtime) && self.lastattackedshieldplayer != attacker)
	{
		if(GetTime() - self.lastattackedshieldtime < 4000)
		{
			self.lastattackedshieldplayer thread maps/mp/gametypes/_globallogic_score::processshieldassist(self);
		}
	}

	pixendevent();
}

//Function Number: 28
playerkilled_kill(einflictor,attacker,smeansofdeath,sweapon,shitloc)
{
	maps/mp/gametypes/_globallogic_score::inctotalkills(attacker.team);
	attacker thread maps/mp/gametypes/_globallogic_score::givekillstats(smeansofdeath,sweapon,self);
	if(isalive(attacker))
	{
		pixbeginevent("killstreak");
		if(!IsDefined(einflictor) || !IsDefined(einflictor.requireddeathcount) || attacker.deathcount == einflictor.requireddeathcount)
		{
			shouldgivekillstreak = maps/mp/killstreaks/_killstreaks::shouldgivekillstreak(sweapon);
			if(shouldgivekillstreak)
			{
				attacker maps/mp/killstreaks/_killstreaks::addtokillstreakcount(sweapon);
			}

			attacker.pers["cur_total_kill_streak"]++;
			attacker setplayercurrentstreak(attacker.pers["cur_total_kill_streak"]);
			if(IsDefined(level.killstreaks) && shouldgivekillstreak)
			{
				attacker.pers["cur_kill_streak"]++;
				if(attacker.pers["cur_kill_streak"] >= 2)
				{
					if(attacker.pers["cur_kill_streak"] == 10)
					{
						attacker maps/mp/_challenges::killstreakten();
					}

					if(attacker.pers["cur_kill_streak"] <= 30)
					{
						maps/mp/_scoreevents::processscoreevent("killstreak_" + attacker.pers["cur_kill_streak"],attacker,self,sweapon);
					}
					else
					{
						maps/mp/_scoreevents::processscoreevent("killstreak_more_than_30",attacker,self,sweapon);
					}
				}

				if(!IsDefined(level.usingmomentum) || !level.usingmomentum)
				{
					attacker thread maps/mp/killstreaks/_killstreaks::givekillstreakforstreak();
				}
			}
		}

		if(isplayer(attacker))
		{
			self thread maps/mp/gametypes/_battlechatter_mp::onplayerkillstreak(attacker);
		}

		pixendevent();
	}

	if(attacker.pers["cur_kill_streak"] > attacker.kill_streak)
	{
		if(level.rankedmatch && !level.disablestattracking)
		{
			attacker setdstat("HighestStats","kill_streak",attacker.pers["totalKillstreakCount"]);
		}

		attacker.kill_streak = attacker.pers["cur_kill_streak"];
	}

	if(attacker.pers["cur_kill_streak"] > attacker.gametype_kill_streak)
	{
		attacker maps/mp/gametypes/_persistence::statsetwithgametype("kill_streak",attacker.pers["cur_kill_streak"]);
		attacker.gametype_kill_streak = attacker.pers["cur_kill_streak"];
	}

	killstreak = maps/mp/killstreaks/_killstreaks::getkillstreakforweapon(sweapon);
	if(IsDefined(killstreak))
	{
		if(maps/mp/_scoreevents::isregisteredevent(killstreak))
		{
			maps/mp/_scoreevents::processscoreevent(killstreak,attacker,self,sweapon);
		}

		if(sweapon == "straferun_gun_mp" || sweapon == "straferun_rockets_mp")
		{
			attacker maps/mp/killstreaks/_straferun::addstraferunkill();
		}
	}
	else
	{
		if(smeansofdeath == "MOD_MELEE" && level.gametype == "gun")
		{
		}
		else
		{
			maps/mp/_scoreevents::processscoreevent("kill",attacker,self,sweapon);
		}

		if(smeansofdeath == "MOD_HEAD_SHOT")
		{
			maps/mp/_scoreevents::processscoreevent("headshot",attacker,self,sweapon);
		}
		else if(smeansofdeath == "MOD_MELEE")
		{
			if(sweapon == "riotshield_mp")
			{
				maps/mp/_scoreevents::processscoreevent("melee_kill_with_riot_shield",attacker,self,sweapon);
				if(IsDefined(attacker.class_num))
				{
					primaryweaponnum = attacker getloadoutitem(attacker.class_num,"primary");
					secondaryweaponnum = attacker getloadoutitem(attacker.class_num,"secondary");
					if((primaryweaponnum && level.tbl_weaponids[primaryweaponnum]["reference"] == "riotshield" && !secondaryweaponnum) || secondaryweaponnum && level.tbl_weaponids[secondaryweaponnum]["reference"] == "riotshield" && !primaryweaponnum)
					{
						attacker addweaponstat(sweapon,"NoLethalKills",1);
					}
				}
			}
			else
			{
				maps/mp/_scoreevents::processscoreevent("melee_kill",attacker,self,sweapon);
			}
		}
	}

	attacker thread maps/mp/gametypes/_globallogic_score::trackattackerkill(self.name,self.pers["rank"],self.pers["rankxp"],self.pers["prestige"],self getxuid(1));
	attackername = attacker.name;
	self thread maps/mp/gametypes/_globallogic_score::trackattackeedeath(attackername,attacker.pers["rank"],attacker.pers["rankxp"],attacker.pers["prestige"],attacker getxuid(1));
	self thread maps/mp/_medals::setlastkilledby(attacker);
	attacker thread maps/mp/gametypes/_globallogic_score::inckillstreaktracker(sweapon);
	if(level.teambased && attacker.team != "spectator")
	{
		if(isai(attacker))
		{
			maps/mp/gametypes/_globallogic_score::giveteamscore("kill",attacker.aiteam,attacker,self);
		}
		else
		{
			maps/mp/gametypes/_globallogic_score::giveteamscore("kill",attacker.team,attacker,self);
		}
	}

	scoresub = level.deathpointloss;
	if(scoresub != 0)
	{
		maps/mp/gametypes/_globallogic_score::_setplayerscore(self,maps/mp/gametypes/_globallogic_score::_getplayerscore(self) - scoresub);
	}

	level thread playkillbattlechatter(attacker,sweapon,self);
}

//Function Number: 29
callback_playerkilled(einflictor,attacker,idamage,smeansofdeath,sweapon,vdir,shitloc,psoffsettime,deathanimduration)
{
	profilelog_begintiming(7,"ship");
	self endon("spawned");
	self notify("killed_player");
	if(self.sessionteam == "spectator")
	{
		return;
	}

	if(game["state"] == "postgame")
	{
		return;
	}

	self needsrevive(0);
	if(IsDefined(self.burning) && self.burning == 1)
	{
		self setburn(0);
	}

	self.suicide = 0;
	self.teamkilled = 0;
	if(IsDefined(level.takelivesondeath) && level.takelivesondeath == 1)
	{
		if(self.pers["lives"])
		{
			self.pers["lives"]--;
			if(self.pers["lives"] == 0)
			{
				level notify("player_eliminated");
				self notify("player_eliminated");
			}
		}
	}

	self thread flushgroupdialogonplayer("item_destroyed");
	sweapon = updateweapon(einflictor,sweapon);
	pixbeginevent("PlayerKilled pre constants");
	wasinlaststand = 0;
	deathtimeoffset = 0;
	lastweaponbeforedroppingintolaststand = undefined;
	attackerstance = undefined;
	self.laststandthislife = undefined;
	self.vattackerorigin = undefined;
	if(IsDefined(self.uselaststandparams))
	{
		self.uselaststandparams = undefined;
/#
		assert(IsDefined(self.laststandparams));
#/
		if(!level.teambased || !IsDefined(attacker) || !isplayer(attacker) || attacker.team != self.team || attacker == self)
		{
			einflictor = self.laststandparams.einflictor;
			attacker = self.laststandparams.attacker;
			attackerstance = self.laststandparams.attackerstance;
			idamage = self.laststandparams.idamage;
			smeansofdeath = self.laststandparams.smeansofdeath;
			sweapon = self.laststandparams.sweapon;
			vdir = self.laststandparams.vdir;
			shitloc = self.laststandparams.shitloc;
			self.vattackerorigin = self.laststandparams.vattackerorigin;
			deathtimeoffset = GetTime() - self.laststandparams.laststandstarttime / 1000;
			self thread maps/mp/gametypes/_battlechatter_mp::perkspecificbattlechatter("secondchance");
			if(IsDefined(self.previousprimary))
			{
				wasinlaststand = 1;
				lastweaponbeforedroppingintolaststand = self.previousprimary;
			}
		}

		self.laststandparams = undefined;
	}

	bestplayer = undefined;
	bestplayermeansofdeath = undefined;
	obituarymeansofdeath = undefined;
	bestplayerweapon = undefined;
	obituaryweapon = sweapon;
	assistedsuicide = 0;
	if((!IsDefined(attacker) || attacker.classname == "trigger_hurt" || attacker.classname == "worldspawn" || (IsDefined(attacker.ismagicbullet) && attacker.ismagicbullet == 1) || attacker == self) && IsDefined(self.attackers))
	{
		if(!(IsDefined(bestplayer)))
		{
			for(i = 0;i < self.attackers.size;i++)
			{
				player = self.attackers[i];
				if(!(IsDefined(player)))
				{
				}
				else if(!IsDefined(self.attackerdamage[player.clientid]) || !IsDefined(self.attackerdamage[player.clientid].damage))
				{
				}
				else if(player == self || level.teambased && player.team == self.team)
				{
				}
				else if(self.attackerdamage[player.clientid].lasttimedamaged + 2500 < GetTime())
				{
				}
				else if(!(allowedassistweapon(self.attackerdamage[player.clientid].weapon)))
				{
				}
				else if(self.attackerdamage[player.clientid].damage > 1 && !IsDefined(bestplayer))
				{
					bestplayer = player;
					bestplayermeansofdeath = self.attackerdamage[player.clientid].meansofdeath;
					bestplayerweapon = self.attackerdamage[player.clientid].weapon;
				}
				else if(IsDefined(bestplayer) && self.attackerdamage[player.clientid].damage > self.attackerdamage[bestplayer.clientid].damage)
				{
					bestplayer = player;
					bestplayermeansofdeath = self.attackerdamage[player.clientid].meansofdeath;
					bestplayerweapon = self.attackerdamage[player.clientid].weapon;
				}
			}
		}

		if(IsDefined(bestplayer))
		{
			maps/mp/_scoreevents::processscoreevent("assisted_suicide",bestplayer,self,sweapon);
			self recordkillmodifier("assistedsuicide");
			assistedsuicide = 1;
		}
	}

	if(IsDefined(bestplayer))
	{
		attacker = bestplayer;
		obituarymeansofdeath = bestplayermeansofdeath;
		obituaryweapon = bestplayerweapon;
		if(IsDefined(bestplayerweapon))
		{
			sweapon = bestplayerweapon;
		}
	}

	if(isplayer(attacker))
	{
		attacker.damagedplayers[self.clientid] = undefined;
	}

	self.deathtime = GetTime();
	attacker = updateattacker(attacker,sweapon);
	einflictor = updateinflictor(einflictor);
	smeansofdeath = self playerkilled_updatemeansofdeath(attacker,einflictor,sweapon,smeansofdeath,shitloc);
	if(!(IsDefined(obituarymeansofdeath)))
	{
		obituarymeansofdeath = smeansofdeath;
	}

	if(IsDefined(self.hasriotshieldequipped) && self.hasriotshieldequipped == 1)
	{
		self detachshieldmodel(level.carriedshieldmodel,"tag_weapon_left");
		self.hasriotshield = 0;
		self.hasriotshieldequipped = 0;
	}

	self thread updateglobalbotkilledcounter();
	self playerkilled_weaponstats(attacker,sweapon,smeansofdeath,wasinlaststand,lastweaponbeforedroppingintolaststand,einflictor);
	self playerkilled_obituary(attacker,einflictor,obituaryweapon,obituarymeansofdeath);
	maps/mp/gametypes/_spawnlogic::deathoccured(self,attacker);
	self.sessionstate = "dead";
	self.statusicon = "hud_status_dead";
	self.pers["weapon"] = undefined;
	self.killedplayerscurrent = [];
	self.deathcount++;
/#
	println("players(" + self.clientid + ") death count ++: " + self.deathcount);
#/
	self playerkilled_killstreaks(attacker,sweapon);
	lpselfnum = self getentitynumber();
	lpselfname = self.name;
	lpattackguid = "";
	lpattackname = "";
	lpselfteam = self.team;
	lpselfguid = self getguid();
	lpattackteam = "";
	lpattackorigin = (0,0,0);
	lpattacknum = -1;
	awardassists = 0;
	wasteamkill = 0;
	wassuicide = 0;
	pixendevent();
	maps/mp/_scoreevents::processscoreevent("death",self,self,sweapon);
	self.pers["resetMomentumOnSpawn"] = 1;
	if(isplayer(attacker))
	{
		lpattackguid = attacker getguid();
		lpattackname = attacker.name;
		lpattackteam = attacker.team;
		lpattackorigin = attacker.origin;
		if(attacker == self || assistedsuicide == 1)
		{
			dokillcam = 0;
			wassuicide = 1;
			awardassists = self playerkilled_suicide(einflictor,attacker,smeansofdeath,sweapon,shitloc);
		}
		else
		{
			pixbeginevent("PlayerKilled attacker");
			lpattacknum = attacker getentitynumber();
			dokillcam = 1;
			if(level.teambased && self.team == attacker.team && smeansofdeath == "MOD_GRENADE" && level.friendlyfire == 0)
			{
			}
			else if(level.teambased && self.team == attacker.team)
			{
				wasteamkill = 1;
				self playerkilled_teamkill(einflictor,attacker,smeansofdeath,sweapon,shitloc);
			}
			else
			{
				self playerkilled_kill(einflictor,attacker,smeansofdeath,sweapon,shitloc);
				if(level.teambased)
				{
					awardassists = 1;
				}
			}

			pixendevent();
		}
	}
	else if(IsDefined(attacker) && attacker.classname == "trigger_hurt" || attacker.classname == "worldspawn")
	{
		dokillcam = 0;
		lpattacknum = -1;
		lpattackguid = "";
		lpattackname = "";
		lpattackteam = "world";
		thread maps/mp/_scoreevents::processscoreevent("suicide",self);
		self maps/mp/gametypes/_globallogic_score::incpersstat("suicides",1);
		self.suicides = self maps/mp/gametypes/_globallogic_score::getpersstat("suicides");
		self.suicide = 1;
		thread maps/mp/gametypes/_battlechatter_mp::onplayersuicideorteamkill(self,"suicide");
		awardassists = 1;
		if(level.maxsuicidesbeforekick > 0 && level.maxsuicidesbeforekick <= self.suicides)
		{
			self notify("teamKillKicked");
			self suicidekick();
		}
	}
	else
	{
		dokillcam = 0;
		lpattacknum = -1;
		lpattackguid = "";
		lpattackname = "";
		lpattackteam = "world";
		wassuicide = 1;
		if(IsDefined(einflictor) && IsDefined(einflictor.killcament))
		{
			dokillcam = 1;
			lpattacknum = self getentitynumber();
			wassuicide = 0;
		}

		if(IsDefined(attacker) && IsDefined(attacker.team) && IsDefined(level.teams[attacker.team]))
		{
			if(attacker.team != self.team)
			{
				if(level.teambased)
				{
					maps/mp/gametypes/_globallogic_score::giveteamscore("kill",attacker.team,attacker,self);
				}

				wassuicide = 0;
			}
		}

		awardassists = 1;
	}

	if(!(level.ingraceperiod))
	{
		if(smeansofdeath != "MOD_GRENADE" && smeansofdeath != "MOD_GRENADE_SPLASH" && smeansofdeath != "MOD_EXPLOSIVE" && smeansofdeath != "MOD_EXPLOSIVE_SPLASH" && smeansofdeath != "MOD_PROJECTILE_SPLASH")
		{
			self maps/mp/gametypes/_weapons::dropscavengerfordeath(attacker);
		}

		if(!wasteamkill && !wassuicide)
		{
			self maps/mp/gametypes/_weapons::dropweaponfordeath(attacker,sweapon,smeansofdeath);
			self maps/mp/gametypes/_weapons::dropoffhand();
		}
	}

	if(sessionmodeiszombiesgame())
	{
		awardassists = 0;
	}

	if(awardassists)
	{
		self playerkilled_awardassists(einflictor,attacker,sweapon,lpattackteam);
	}

	pixbeginevent("PlayerKilled post constants");
	self.lastattacker = attacker;
	self.lastdeathpos = self.origin;
	if(IsDefined(attacker) && isplayer(attacker) && attacker != self && !level.teambased || attacker.team != self.team)
	{
		self thread maps/mp/_challenges::playerkilled(einflictor,attacker,idamage,smeansofdeath,sweapon,shitloc,attackerstance);
	}
	else
	{
		self notify("playerKilledChallengesProcessed");
	}

	if(IsDefined(self.attackers))
	{
		self.attackers = [];
	}

	if(isplayer(attacker))
	{
		if(maps/mp/killstreaks/_killstreaks::iskillstreakweapon(sweapon))
		{
			killstreak = maps/mp/killstreaks/_killstreaks::getkillstreakforweapon(sweapon);
			bbprint("mpattacks","gametime %d attackerspawnid %d attackerweapon %s attackerx %d attackery %d attackerz %d victimspawnid %d victimx %d victimy %d victimz %d damage %d damagetype %s damagelocation %s death %d killstreak %s",GetTime(),getplayerspawnid(attacker),sweapon,lpattackorigin,getplayerspawnid(self),self.origin,idamage,smeansofdeath,shitloc,1,killstreak);
		}
		else
		{
			bbprint("mpattacks","gametime %d attackerspawnid %d attackerweapon %s attackerx %d attackery %d attackerz %d victimspawnid %d victimx %d victimy %d victimz %d damage %d damagetype %s damagelocation %s death %d",GetTime(),getplayerspawnid(attacker),sweapon,lpattackorigin,getplayerspawnid(self),self.origin,idamage,smeansofdeath,shitloc,1);
		}
	}
	else
	{
		bbprint("mpattacks","gametime %d attackerweapon %s victimspawnid %d victimx %d victimy %d victimz %d damage %d damagetype %s damagelocation %s death %d",GetTime(),sweapon,getplayerspawnid(self),self.origin,idamage,smeansofdeath,shitloc,1);
	}

	logprint("K;" + lpselfguid + ";" + lpselfnum + ";" + lpselfteam + ";" + lpselfname + ";" + lpattackguid + ";" + lpattacknum + ";" + lpattackteam + ";" + lpattackname + ";" + sweapon + ";" + idamage + ";" + smeansofdeath + ";" + shitloc + "\n");
	attackerstring = "none";
	if(isplayer(attacker))
	{
		attackerstring = attacker getxuid() + "(" + lpattackname + ")";
	}

	self logstring("d " + smeansofdeath + "(" + sweapon + ") a:" + attackerstring + " d:" + idamage + " l:" + shitloc + " @ " + int(self.origin[0]) + " " + int(self.origin[1]) + " " + int(self.origin[2]));
	level thread maps/mp/gametypes/_globallogic::updateteamstatus();
	killcamentity = self getkillcamentity(attacker,einflictor,sweapon);
	killcamentityindex = -1;
	killcamentitystarttime = 0;
	if(IsDefined(killcamentity))
	{
		killcamentityindex = killcamentity getentitynumber();
		if(IsDefined(killcamentity.starttime))
		{
			killcamentitystarttime = killcamentity.starttime;
		}
		else
		{
			killcamentitystarttime = killcamentity.birthtime;
		}

		if(!(IsDefined(killcamentitystarttime)))
		{
			killcamentitystarttime = 0;
		}
	}

	if(IsDefined(self.killstreak_waitamount) && self.killstreak_waitamount > 0)
	{
		dokillcam = 0;
	}

	self maps/mp/gametypes/_weapons::detachcarryobjectmodel();
	died_in_vehicle = 0;
	if(IsDefined(self.diedonvehicle))
	{
		died_in_vehicle = self.diedonvehicle;
	}

	hit_by_train = 0;
	if(IsDefined(attacker) && IsDefined(attacker.targetname) && attacker.targetname == "train")
	{
		hit_by_train = 1;
	}

	pixendevent();
	pixbeginevent("PlayerKilled body and gibbing");
	if(!died_in_vehicle && !hit_by_train)
	{
		vattackerorigin = undefined;
		if(IsDefined(attacker))
		{
			vattackerorigin = attacker.origin;
		}

		ragdoll_now = 0;
		if(IsDefined(self.usingvehicle) && self.usingvehicle && IsDefined(self.vehicleposition) && self.vehicleposition == 1)
		{
			ragdoll_now = 1;
		}

		body = self cloneplayer(deathanimduration);
		if(IsDefined(body))
		{
			self createdeadbody(idamage,smeansofdeath,sweapon,shitloc,vdir,vattackerorigin,deathanimduration,einflictor,ragdoll_now,body);
		}
	}

	pixendevent();
	thread maps/mp/gametypes/_globallogic_spawn::spawnqueuedclient(self.team,attacker);
	self.switching_teams = undefined;
	self.joining_team = undefined;
	self.leaving_team = undefined;
	self thread [[ level.onplayerkilled ]](einflictor,attacker,idamage,smeansofdeath,sweapon,vdir,shitloc,psoffsettime,deathanimduration);
	for(icb = 0;icb < level.onplayerkilledextraunthreadedcbs.size;icb++)
	{
		self [[ level.onplayerkilledextraunthreadedcbs[icb] ]](einflictor,attacker,idamage,smeansofdeath,sweapon,vdir,shitloc,psoffsettime,deathanimduration);
	}

	self.wantsafespawn = 0;
	perks = [];
	killstreaks = maps/mp/gametypes/_globallogic::getkillstreaks(attacker);
	if(!(IsDefined(self.killstreak_waitamount)))
	{
		self thread [[ level.spawnplayerprediction ]]();
	}

	profilelog_endtiming(7,"gs=" + game["state"] + " zom=" + sessionmodeiszombiesgame());
	if(wasteamkill == 0 && assistedsuicide == 0 && hit_by_train == 0 && smeansofdeath != "MOD_SUICIDE" && !!IsDefined(attacker) || attacker.classname == "trigger_hurt" || attacker.classname == "worldspawn" || attacker == self || IsDefined(attacker.disablefinalkillcam))
	{
		level thread maps/mp/gametypes/_killcam::recordkillcamsettings(lpattacknum,self getentitynumber(),sweapon,self.deathtime,deathtimeoffset,psoffsettime,killcamentityindex,killcamentitystarttime,perks,killstreaks,attacker);
	}

	wait(0.25);
	weaponclass = getweaponclass(sweapon);
	if(weaponclass == "weapon_sniper")
	{
		self thread maps/mp/gametypes/_battlechatter_mp::killedbysniper(attacker);
	}
	else
	{
		self thread maps/mp/gametypes/_battlechatter_mp::playerkilled(attacker);
	}

	self.cancelkillcam = 0;
	self thread maps/mp/gametypes/_killcam::cancelkillcamonuse();
	defaultplayerdeathwatchtime = 1.75;
	if(IsDefined(level.overrideplayerdeathwatchtimer))
	{
		defaultplayerdeathwatchtime = [[ level.overrideplayerdeathwatchtimer ]](defaultplayerdeathwatchtime);
	}

	maps/mp/gametypes/_globallogic_utils::waitfortimeornotifies(defaultplayerdeathwatchtime);
	self notify("death_delay_finished");
/#
	dokillcam = 1;
	lpattacknum = self getentitynumber();
lpattacknum < 0
GetDvarInt(#"C1849218") != 0
#/
	if(hit_by_train)
	{
		if(killcamentitystarttime > self.deathtime - 2500)
		{
			dokillcam = 0;
		}
	}

	if(game["state"] != "playing")
	{
		return;
	}

	self.respawntimerstarttime = GetTime();
	if(!self.cancelkillcam && dokillcam && level.killcam)
	{
		livesleft = !level.numlives && !self.pers["lives"];
		timeuntilspawn = maps/mp/gametypes/_globallogic_spawn::timeuntilspawn(1);
		willrespawnimmediately = livesleft && timeuntilspawn <= 0 && !level.playerqueuedrespawn;
		self maps/mp/gametypes/_killcam::killcam(lpattacknum,self getentitynumber(),killcamentity,killcamentityindex,killcamentitystarttime,sweapon,self.deathtime,deathtimeoffset,psoffsettime,willrespawnimmediately,maps/mp/gametypes/_globallogic_utils::timeuntilroundend(),perks,killstreaks,attacker);
	}

	if(game["state"] != "playing")
	{
		self.sessionstate = "dead";
		self.spectatorclient = -1;
		self.killcamtargetentity = -1;
		self.killcamentity = -1;
		self.archivetime = 0;
		self.psoffsettime = 0;
		return;
	}

	waittillkillstreakdone();
	userespawntime = 1;
	if(IsDefined(level.hostmigrationtimer))
	{
		userespawntime = 0;
	}

	maps/mp/gametypes/_hostmigration::waittillhostmigrationcountdown();
	if(maps/mp/gametypes/_globallogic_utils::isvalidclass(self.class))
	{
		timepassed = undefined;
		if(IsDefined(self.respawntimerstarttime) && userespawntime)
		{
			timepassed = GetTime() - self.respawntimerstarttime / 1000;
		}

		self thread [[ level.spawnclient ]](timepassed);
		self.respawntimerstarttime = undefined;
	}
}

//Function Number: 30
updateglobalbotkilledcounter()
{
	if(IsDefined(self.pers["isBot"]))
	{
		level.globallarryskilled++;
	}
}

//Function Number: 31
waittillkillstreakdone()
{
	if(IsDefined(self.killstreak_waitamount))
	{
		starttime = GetTime();
		waittime = self.killstreak_waitamount * 1000;
		while(GetTime() < starttime + waittime && IsDefined(self.killstreak_waitamount))
		{
			wait(0.1);
		}

		wait(2);
		self.killstreak_waitamount = undefined;
	}
}

//Function Number: 32
suicidekick()
{
	self maps/mp/gametypes/_globallogic_score::incpersstat("sessionbans",1);
	self endon("disconnect");
	waittillframeend;
	maps/mp/gametypes/_globallogic::gamehistoryplayerkicked();
	ban(self getentitynumber());
	maps/mp/gametypes/_globallogic_audio::leaderdialog("kicked");
}

//Function Number: 33
teamkillkick()
{
	self maps/mp/gametypes/_globallogic_score::incpersstat("sessionbans",1);
	self endon("disconnect");
	waittillframeend;
	playlistbanquantum = maps/mp/gametypes/_tweakables::gettweakablevalue("team","teamkillerplaylistbanquantum");
	playlistbanpenalty = maps/mp/gametypes/_tweakables::gettweakablevalue("team","teamkillerplaylistbanpenalty");
	if(playlistbanquantum > 0 && playlistbanpenalty > 0)
	{
		timeplayedtotal = self getdstat("playerstatslist","time_played_total","StatValue");
		minutesplayed = timeplayedtotal / 60;
		freebees = 2;
		banallowance = int(floor(minutesplayed / playlistbanquantum)) + freebees;
		if(self.sessionbans > banallowance)
		{
			self setdstat("playerstatslist","gametypeban","StatValue",timeplayedtotal + playlistbanpenalty * 60);
		}
	}

	maps/mp/gametypes/_globallogic::gamehistoryplayerkicked();
	ban(self getentitynumber());
	maps/mp/gametypes/_globallogic_audio::leaderdialog("kicked");
}

//Function Number: 34
teamkilldelay()
{
	teamkills = self.pers["teamkills_nostats"];
	if(level.minimumallowedteamkills < 0 || teamkills <= level.minimumallowedteamkills)
	{
		return 0;
	}

	exceeded = teamkills - level.minimumallowedteamkills;
	return level.teamkillspawndelay * exceeded;
}

//Function Number: 35
shouldteamkillkick(teamkilldelay)
{
	if(teamkilldelay && level.minimumallowedteamkills >= 0)
	{
		if(maps/mp/gametypes/_globallogic_utils::gettimepassed() >= 5000)
		{
			return 1;
		}

		if(self.pers["teamkills_nostats"] > 1)
		{
			return 1;
		}
	}
}

//Function Number: 36
reduceteamkillsovertime()
{
	timeperoneteamkillreduction = 20;
	reductionpersecond = 1 / timeperoneteamkillreduction;
	while(1)
	{
		if(isalive(self))
		{
			self.pers["teamkills_nostats"] = self.pers["teamkills_nostats"] - reductionpersecond;
			if(self.pers["teamkills_nostats"] < level.minimumallowedteamkills)
			{
				self.pers["teamkills_nostats"] = level.minimumallowedteamkills;
				break;
			}
		}

		wait(1);
	}
}

//Function Number: 37
ignoreteamkills(sweapon,smeansofdeath)
{
	if(sessionmodeiszombiesgame())
	{
		return 1;
	}

	if(smeansofdeath == "MOD_MELEE")
	{
		return 0;
	}

	if(sweapon == "briefcase_bomb_mp")
	{
		return 1;
	}

	if(sweapon == "supplydrop_mp")
	{
		return 1;
	}

	return 0;
}

//Function Number: 38
callback_playerlaststand(einflictor,attacker,idamage,smeansofdeath,sweapon,vdir,shitloc,psoffsettime,deathanimduration)
{
}

//Function Number: 39
damageshellshockandrumble(eattacker,einflictor,sweapon,smeansofdeath,idamage)
{
	self thread maps/mp/gametypes/_weapons::onweapondamage(eattacker,einflictor,sweapon,smeansofdeath,idamage);
	self playrumbleonentity("damage_heavy");
}

//Function Number: 40
createdeadbody(idamage,smeansofdeath,sweapon,shitloc,vdir,vattackerorigin,deathanimduration,einflictor,ragdoll_jib,body)
{
	if(smeansofdeath == "MOD_HIT_BY_OBJECT" && self getstance() == "prone")
	{
		self.body = body;
		if(!(IsDefined(self.switching_teams)))
		{
			thread maps/mp/gametypes/_deathicons::adddeathicon(body,self,self.team,5);
		}

		return;
	}

	if(IsDefined(level.ragdoll_override) && self [[ level.ragdoll_override ]](idamage,smeansofdeath,sweapon,shitloc,vdir,vattackerorigin,deathanimduration,einflictor,ragdoll_jib,body))
	{
		return;
	}

	if(ragdoll_jib || self isonladder() || self ismantling() || smeansofdeath == "MOD_CRUSH" || smeansofdeath == "MOD_HIT_BY_OBJECT")
	{
		body startragdoll();
	}

	if(!(self isonground()))
	{
		if(GetDvarInt(#"68ECFF24") == 0)
		{
			body startragdoll();
		}
	}

	if(self is_explosive_ragdoll(sweapon,einflictor))
	{
		body start_explosive_ragdoll(vdir,sweapon);
	}

	thread delaystartragdoll(body,shitloc,vdir,sweapon,einflictor,smeansofdeath);
	if(smeansofdeath == "MOD_BURNED" || IsDefined(self.burning))
	{
		body maps/mp/_burnplayer::burnedtodeath();
	}

	if(smeansofdeath == "MOD_CRUSH")
	{
		body maps/mp/gametypes/_globallogic_vehicle::vehiclecrush();
	}

	self.body = body;
	if(!(IsDefined(self.switching_teams)))
	{
		thread maps/mp/gametypes/_deathicons::adddeathicon(body,self,self.team,5);
	}
}

//Function Number: 41
is_explosive_ragdoll(weapon,inflictor)
{
	if(!(IsDefined(weapon)))
	{
		return 0;
	}

	if(weapon == "destructible_car_mp" || weapon == "explodable_barrel_mp")
	{
		return 1;
	}

	if(weapon == "sticky_grenade_mp" || weapon == "explosive_bolt_mp")
	{
		if(IsDefined(inflictor) && IsDefined(inflictor.stucktoplayer))
		{
			if(inflictor.stucktoplayer == self)
			{
				return 1;
			}
		}
	}

	return 0;
}

//Function Number: 42
start_explosive_ragdoll(dir,weapon)
{
	if(!(IsDefined(self)))
	{
		return;
	}

	x = randomintrange(50,100);
	y = randomintrange(50,100);
	z = randomintrange(10,20);
	if(IsDefined(weapon) && weapon == "sticky_grenade_mp" || weapon == "explosive_bolt_mp")
	{
		if(IsDefined(dir) && lengthsquared(dir) > 0)
		{
			x = dir[0] * x;
			y = dir[1] * y;
		}
	}
	else
	{
		if(cointoss())
		{
			x = x * -1;
		}

		if(cointoss())
		{
			y = y * -1;
		}
	}

	self startragdoll();
	self launchragdoll((x,y,z));
}

//Function Number: 43
notifyconnecting()
{
	waittillframeend;
	if(IsDefined(self))
	{
		level notify("connecting",self);
	}
}

//Function Number: 44
delaystartragdoll(ent,shitloc,vdir,sweapon,einflictor,smeansofdeath)
{
	if(IsDefined(ent))
	{
		deathanim = ent getcorpseanim();
		if(animhasnotetrack(deathanim,"ignore_ragdoll"))
		{
			return;
		}
	}

	if(level.oldschool)
	{
		if(!(IsDefined(vdir)))
		{
			vdir = (0,0,0);
		}

		explosionpos = ent.origin + (0,0,maps/mp/gametypes/_globallogic_utils::gethitlocheight(shitloc));
		explosionpos = explosionpos - vdir * 20;
		explosionradius = 40;
		explosionforce = 0.75;
		if(smeansofdeath == "MOD_IMPACT" || smeansofdeath == "MOD_EXPLOSIVE" || issubstr(smeansofdeath,"MOD_GRENADE") || issubstr(smeansofdeath,"MOD_PROJECTILE") || shitloc == "head" || shitloc == "helmet")
		{
			explosionforce = 2.5;
		}

		ent startragdoll(1);
		wait(0.05);
		if(!(IsDefined(ent)))
		{
			return;
		}

		physicsexplosionsphere(explosionpos,explosionradius,explosionradius / 2,explosionforce);
		return;
	}

	wait(0.2);
	if(!(IsDefined(ent)))
	{
		return;
	}

	if(ent isragdoll())
	{
		return;
	}

	deathanim = ent getcorpseanim();
	startfrac = 0.35;
	if(animhasnotetrack(deathanim,"start_ragdoll"))
	{
		times = getnotetracktimes(deathanim,"start_ragdoll");
		if(IsDefined(times))
		{
			startfrac = times[0];
		}
	}

	waittime = startfrac * getanimlength(deathanim);
	wait(waittime);
	if(IsDefined(ent))
	{
		ent startragdoll(1);
	}
}

//Function Number: 45
trackattackerdamage(eattacker,idamage,smeansofdeath,sweapon)
{
/#
	assert(isplayer(eattacker));
#/
	if(self.attackerdata.size == 0)
	{
		self.firsttimedamaged = GetTime();
	}

	if(!(IsDefined(self.attackerdata[eattacker.clientid])))
	{
		self.attackerdamage[eattacker.clientid] = spawnstruct();
		self.attackerdamage[eattacker.clientid].damage = idamage;
		self.attackerdamage[eattacker.clientid].meansofdeath = smeansofdeath;
		self.attackerdamage[eattacker.clientid].weapon = sweapon;
		self.attackerdamage[eattacker.clientid].time = GetTime();
		self.attackers[self.attackers.size] = eattacker;
		self.attackerdata[eattacker.clientid] = 0;
	}
	else
	{
		self.attackerdamage[eattacker.clientid].damage = self.attackerdamage[eattacker.clientid].damage + idamage;
		self.attackerdamage[eattacker.clientid].meansofdeath = smeansofdeath;
		self.attackerdamage[eattacker.clientid].weapon = sweapon;
		if(!(IsDefined(self.attackerdamage[eattacker.clientid].time)))
		{
			self.attackerdamage[eattacker.clientid].time = GetTime();
		}
	}

	self.attackerdamage[eattacker.clientid].lasttimedamaged = GetTime();
	if(maps/mp/gametypes/_weapons::isprimaryweapon(sweapon))
	{
		self.attackerdata[eattacker.clientid] = 1;
	}
}

//Function Number: 46
giveinflictorownerassist(eattacker,einflictor,idamage,smeansofdeath,sweapon)
{
	if(!(IsDefined(einflictor)))
	{
		return;
	}

	if(!(IsDefined(einflictor.owner)))
	{
		return;
	}

	if(!(IsDefined(einflictor.ownergetsassist)))
	{
		return;
	}

	if(!(einflictor.ownergetsassist))
	{
		return;
	}

/#
	assert(isplayer(einflictor.owner));
#/
	self trackattackerdamage(einflictor.owner,idamage,smeansofdeath,sweapon);
}

//Function Number: 47
playerkilled_updatemeansofdeath(attacker,einflictor,sweapon,smeansofdeath,shitloc)
{
	if(maps/mp/gametypes/_globallogic_utils::isheadshot(sweapon,shitloc,smeansofdeath,einflictor) && isplayer(attacker))
	{
		return "MOD_HEAD_SHOT";
	}

	switch(sweapon)
	{
		case "crossbow_mp":
		case "knife_ballistic_mp":
			smeansofdeath = "MOD_PISTOL_BULLET";
			break;
	smeansofdeath != "MOD_HEAD_SHOT" && smeansofdeath != "MOD_MELEE"
			break;

		case "dog_bite_mp":
			smeansofdeath = "MOD_PISTOL_BULLET";
			break;

		case "destructible_car_mp":
			smeansofdeath = "MOD_EXPLOSIVE";
			break;

		case "explodable_barrel_mp":
			smeansofdeath = "MOD_EXPLOSIVE";
			break;
	}

	return smeansofdeath;
}

//Function Number: 48
updateattacker(attacker,weapon)
{
	if(isai(attacker) && IsDefined(attacker.script_owner))
	{
		if(!level.teambased || attacker.script_owner.team != self.team)
		{
			attacker = attacker.script_owner;
		}
	}

	if(attacker.classname == "script_vehicle" && IsDefined(attacker.owner))
	{
		attacker notify("killed",self);
		attacker = attacker.owner;
	}

	if(isai(attacker))
	{
		attacker notify("killed",self);
	}

	if(IsDefined(self.capturinglastflag) && self.capturinglastflag == 1)
	{
		attacker.lastcapkiller = 1;
	}

	if(IsDefined(attacker) && IsDefined(weapon) && weapon == "planemortar_mp")
	{
		if(!(IsDefined(attacker.planemortarbda)))
		{
			attacker.planemortarbda = 0;
		}

		attacker.planemortarbda++;
	}

	if(IsDefined(attacker) && IsDefined(weapon) && weapon == "straferun_rockets_mp" || weapon == "straferun_gun_mp")
	{
		if(IsDefined(attacker.straferunbda))
		{
			attacker.straferunbda++;
		}
	}

	return attacker;
}

//Function Number: 49
updateinflictor(einflictor)
{
	if(IsDefined(einflictor) && einflictor.classname == "script_vehicle")
	{
		einflictor notify("killed",self);
		if(IsDefined(einflictor.bda))
		{
			einflictor.bda++;
		}
	}

	return einflictor;
}

//Function Number: 50
updateweapon(einflictor,sweapon)
{
	if(sweapon == "none" && IsDefined(einflictor))
	{
		if(IsDefined(einflictor.targetname) && einflictor.targetname == "explodable_barrel")
		{
			sweapon = "explodable_barrel_mp";
		}
		else if(IsDefined(einflictor.destructible_type) && issubstr(einflictor.destructible_type,"vehicle_"))
		{
			sweapon = "destructible_car_mp";
		}
	}

	return sweapon;
}

//Function Number: 51
getclosestkillcamentity(attacker,killcamentities,depth)
{
	if(!(IsDefined(depth)))
	{
		depth = 0;
	}

	closestkillcament = undefined;
	closestkillcamentindex = undefined;
	closestkillcamentdist = undefined;
	origin = undefined;
	foreach(killcamentindex, killcament in killcamentities)
	{
		if(killcament == attacker)
		{
		}
		else
		{
			origin = killcament.origin;
			if(IsDefined(killcament.offsetpoint))
			{
				origin = origin + killcament.offsetpoint;
			}

			dist = distancesquared(self.origin,origin);
			if(!IsDefined(closestkillcament) || dist < closestkillcamentdist)
			{
				closestkillcament = killcament;
				closestkillcamentdist = dist;
				closestkillcamentindex = killcamentindex;
			}
		}
	}

	if(depth < 3 && IsDefined(closestkillcament))
	{
		if(!(bullettracepassed(closestkillcament.origin,self.origin,0,self)))
		{
			killcamentities[closestkillcamentindex] = undefined;
			betterkillcament = getclosestkillcamentity(attacker,killcamentities,depth + 1);
			if(IsDefined(betterkillcament))
			{
				closestkillcament = betterkillcament;
			}
		}
	}

	return closestkillcament;
}

//Function Number: 52
getkillcamentity(attacker,einflictor,sweapon)
{
	if(!(IsDefined(einflictor)))
	{
		return undefined;
	}

	if(einflictor == attacker)
	{
		if(!(IsDefined(einflictor.ismagicbullet)))
		{
			return undefined;
		}

		if(IsDefined(einflictor.ismagicbullet) && !einflictor.ismagicbullet)
		{
			return undefined;
		}
	}
	else if(IsDefined(level.levelspecifickillcam))
	{
		levelspecifickillcament = self [[ level.levelspecifickillcam ]]();
		if(IsDefined(levelspecifickillcament))
		{
			return levelspecifickillcament;
		}
	}

	if(sweapon == "m220_tow_mp")
	{
		return undefined;
	}

	if(IsDefined(einflictor.killcament))
	{
		if(einflictor.killcament == attacker)
		{
			return undefined;
		}

		return einflictor.killcament;
	}
	else if(IsDefined(einflictor.killcamentities))
	{
		return getclosestkillcamentity(attacker,einflictor.killcamentities);
	}

	if(IsDefined(einflictor.script_gameobjectname) && einflictor.script_gameobjectname == "bombzone")
	{
		return einflictor.killcament;
	}
}

//Function Number: 53
playkillbattlechatter(attacker,sweapon,victim)
{
	if(isplayer(attacker))
	{
		if(!(maps/mp/killstreaks/_killstreaks::iskillstreakweapon(sweapon)))
		{
			level thread maps/mp/gametypes/_battlechatter_mp::saykillbattlechatter(attacker,sweapon,victim);
		}
	}
}