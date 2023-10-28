/*******************************************************************
 * Decompiled By: Bog
 * Decompiled File: maps\mp\gametypes\dem.gsc
 * Game: Call of Duty: Black Ops 2
 * Platform: PC
 * Function Count: 41
 * Decompile Time: 23 ms
 * Timestamp: 10/28/2023 12:10:38 AM
*******************************************************************/

#include common_scripts/utility;
#include maps/mp/_challenges;
#include maps/mp/_demo;
#include maps/mp/_medals;
#include maps/mp/_popups;
#include maps/mp/_scoreevents;
#include maps/mp/_utility;
#include maps/mp/gametypes/_battlechatter_mp;
#include maps/mp/gametypes/_callbacksetup;
#include maps/mp/gametypes/_gameobjects;
#include maps/mp/gametypes/_globallogic;
#include maps/mp/gametypes/_globallogic_audio;
#include maps/mp/gametypes/_globallogic_defaults;
#include maps/mp/gametypes/_globallogic_score;
#include maps/mp/gametypes/_globallogic_utils;
#include maps/mp/gametypes/_hostmigration;
#include maps/mp/gametypes/_hud_util;
#include maps/mp/gametypes/_rank;
#include maps/mp/gametypes/_spawning;
#include maps/mp/gametypes/_spawnlogic;
#include maps/mp/gametypes/_spectating;

//Function Number: 1
main()
{
	if(GetDvar(#"B4B895C4") == "mp_background")
	{
		return;
	}

	maps/mp/gametypes/_globallogic::init();
	maps/mp/gametypes/_callbacksetup::setupcallbacks();
	maps/mp/gametypes/_globallogic::setupcallbacks();
	registerroundswitch(0,9);
	registertimelimit(0,1440);
	registerscorelimit(0,500);
	registerroundlimit(0,12);
	registerroundwinlimit(0,10);
	registernumlives(0,100);
	maps/mp/gametypes/_globallogic::registerfriendlyfiredelay(level.gametype,15,0,1440);
	level.teambased = 1;
	level.overrideteamscore = 1;
	level.onprecachegametype = ::onprecachegametype;
	level.onstartgametype = ::onstartgametype;
	level.onspawnplayer = ::onspawnplayer;
	level.onspawnplayerunified = ::onspawnplayerunified;
	level.playerspawnedcb = ::dem_playerspawnedcb;
	level.onplayerkilled = ::onplayerkilled;
	level.ondeadevent = ::ondeadevent;
	level.ononeleftevent = ::ononeleftevent;
	level.ontimelimit = ::ontimelimit;
	level.onroundswitch = ::onroundswitch;
	level.getteamkillpenalty = ::dem_getteamkillpenalty;
	level.getteamkillscore = ::dem_getteamkillscore;
	level.gamemodespawndvars = ::gamemodespawndvars;
	level.gettimelimit = ::gettimelimit;
	level.shouldplayovertimeround = ::shouldplayovertimeround;
	level.lastbombexplodetime = undefined;
	level.lastbombexplodebyteam = undefined;
	level.ddbombmodel = [];
	level.endgameonscorelimit = 0;
	game["dialog"]["gametype"] = "demo_start";
	game["dialog"]["gametype_hardcore"] = "hcdemo_start";
	game["dialog"]["offense_obj"] = "destroy_start";
	game["dialog"]["defense_obj"] = "defend_start";
	game["dialog"]["sudden_death"] = "suddendeath";
	if(!sessionmodeissystemlink() && !sessionmodeisonlinegame() && issplitscreen())
	{
		setscoreboardcolumns("score","kills","plants","defuses","deaths");
	}
	else
	{
		setscoreboardcolumns("score","kills","deaths","plants","defuses");
	}
}

//Function Number: 2
onprecachegametype()
{
	game["bombmodelname"] = "t5_weapon_briefcase_bomb_world";
	game["bombmodelnameobj"] = "t5_weapon_briefcase_bomb_world";
	game["bomb_dropped_sound"] = "mpl_flag_drop_plr";
	game["bomb_recovered_sound"] = "mpl_flag_pickup_plr";
	precachemodel(game["bombmodelname"]);
	precachemodel(game["bombmodelnameobj"]);
	precacheshader("waypoint_bomb");
	precacheshader("hud_suitcase_bomb");
	precacheshader("waypoint_target");
	precacheshader("waypoint_target_a");
	precacheshader("waypoint_target_b");
	precacheshader("waypoint_defend");
	precacheshader("waypoint_defend_a");
	precacheshader("waypoint_defend_b");
	precacheshader("waypoint_defuse");
	precacheshader("waypoint_defuse_a");
	precacheshader("waypoint_defuse_b");
	precacheshader("compass_waypoint_target");
	precacheshader("compass_waypoint_target_a");
	precacheshader("compass_waypoint_target_b");
	precacheshader("compass_waypoint_defend");
	precacheshader("compass_waypoint_defend_a");
	precacheshader("compass_waypoint_defend_b");
	precacheshader("compass_waypoint_defuse");
	precacheshader("compass_waypoint_defuse_a");
	precacheshader("compass_waypoint_defuse_b");
	precachestring(&"MP_EXPLOSIVES_RECOVERED_BY");
	precachestring(&"MP_EXPLOSIVES_DROPPED_BY");
	precachestring(&"MP_EXPLOSIVES_PLANTED_BY");
	precachestring(&"MP_EXPLOSIVES_DEFUSED_BY");
	precachestring(&"PLATFORM_HOLD_TO_PLANT_EXPLOSIVES");
	precachestring(&"PLATFORM_HOLD_TO_DEFUSE_EXPLOSIVES");
	precachestring(&"MP_PLANTING_EXPLOSIVE");
	precachestring(&"MP_DEFUSING_EXPLOSIVE");
	precachestring(&"MP_TIME_EXTENDED");
}

//Function Number: 3
dem_getteamkillpenalty(einflictor,attacker,smeansofdeath,sweapon)
{
	teamkill_penalty = maps/mp/gametypes/_globallogic_defaults::default_getteamkillpenalty(einflictor,attacker,smeansofdeath,sweapon);
	if((IsDefined(self.isdefusing) && self.isdefusing) || IsDefined(self.isplanting) && self.isplanting)
	{
		teamkill_penalty = teamkill_penalty * level.teamkillpenaltymultiplier;
	}

	return teamkill_penalty;
}

//Function Number: 4
dem_getteamkillscore(einflictor,attacker,smeansofdeath,sweapon)
{
	teamkill_score = maps/mp/gametypes/_rank::getscoreinfovalue("team_kill");
	if((IsDefined(self.isdefusing) && self.isdefusing) || IsDefined(self.isplanting) && self.isplanting)
	{
		teamkill_score = teamkill_score * level.teamkillscoremultiplier;
	}

	return int(teamkill_score);
}

//Function Number: 5
onroundswitch()
{
	if(!(IsDefined(game["switchedsides"])))
	{
		game["switchedsides"] = 0;
	}

	if(game["teamScores"]["allies"] == level.scorelimit - 1 && game["teamScores"]["axis"] == level.scorelimit - 1)
	{
		aheadteam = getbetterteam();
		if(aheadteam != game["defenders"])
		{
			game["switchedsides"] = !game["switchedsides"];
		}

		level.halftimetype = "overtime";
	}
	else
	{
		level.halftimetype = "halftime";
		game["switchedsides"] = !game["switchedsides"];
	}
}

//Function Number: 6
getbetterteam()
{
	kills["allies"] = 0;
	kills["axis"] = 0;
	deaths["allies"] = 0;
	deaths["axis"] = 0;
	for(i = 0;i < level.players.size;i++)
	{
		player = level.players[i];
		team = player.pers["team"];
		if(IsDefined(team) && team == "allies" || team == "axis")
		{
			kills[team] = kills[team] + player.kills;
			deaths[team] = deaths[team] + player.deaths;
		}
	}

	if(kills["allies"] > kills["axis"])
	{
		return "allies";
	}
	else if(kills["axis"] > kills["allies"])
	{
		return "axis";
	}

	if(deaths["allies"] < deaths["axis"])
	{
		return "allies";
	}
	else if(deaths["axis"] < deaths["allies"])
	{
		return "axis";
	}

	if(randomint(2) == 0)
	{
		return "allies";
	}

	return "axis";
}

//Function Number: 7
gamemodespawndvars(reset_dvars)
{
	ss = level.spawnsystem;
	ss.dem_enemy_base_influencer_score = set_dvar_float_if_unset("scr_spawn_dem_enemy_base_influencer_score","-500",reset_dvars);
	ss.dem_enemy_base_influencer_score_curve = set_dvar_if_unset("scr_spawn_dem_enemy_base_influencer_score_curve","constant",reset_dvars);
	ss.dem_enemy_base_influencer_radius = set_dvar_float_if_unset("scr_spawn_dem_enemy_base_influencer_radius","" + 15 * get_player_height(),reset_dvars);
}

//Function Number: 8
onstartgametype()
{
	setbombtimer("A",0);
	setmatchflag("bomb_timer_a",0);
	setbombtimer("B",0);
	setmatchflag("bomb_timer_b",0);
	level.usingextratime = 0;
	level.spawnsystem.unifiedsideswitching = 0;
	if(!(IsDefined(game["switchedsides"])))
	{
		game["switchedsides"] = 0;
	}

	if(game["switchedsides"])
	{
		oldattackers = game["attackers"];
		olddefenders = game["defenders"];
		game["attackers"] = olddefenders;
		game["defenders"] = oldattackers;
	}

	setclientnamemode("manual_change");
	game["strings"]["target_destroyed"] = &"MP_TARGET_DESTROYED";
	game["strings"]["bomb_defused"] = &"MP_BOMB_DEFUSED";
	precachestring(game["strings"]["target_destroyed"]);
	precachestring(game["strings"]["bomb_defused"]);
	level._effect["bombexplosion"] = loadfx("maps/mp_maps/fx_mp_exp_bomb");
	if(IsDefined(game["overtime_round"]))
	{
		setobjectivetext(game["attackers"],&"OBJECTIVES_DEM_ATTACKER");
		setobjectivetext(game["defenders"],&"OBJECTIVES_DEM_ATTACKER");
		if(level.splitscreen)
		{
			setobjectivescoretext(game["attackers"],&"OBJECTIVES_DEM_ATTACKER");
			setobjectivescoretext(game["defenders"],&"OBJECTIVES_DEM_ATTACKER");
		}
		else
		{
			setobjectivescoretext(game["attackers"],&"OBJECTIVES_DEM_ATTACKER_SCORE");
			setobjectivescoretext(game["defenders"],&"OBJECTIVES_DEM_ATTACKER_SCORE");
		}

		setobjectivehinttext(game["attackers"],&"OBJECTIVES_DEM_ATTACKER_HINT");
		setobjectivehinttext(game["defenders"],&"OBJECTIVES_DEM_ATTACKER_HINT");
	}
	else
	{
		setobjectivetext(game["attackers"],&"OBJECTIVES_DEM_ATTACKER");
		setobjectivetext(game["defenders"],&"OBJECTIVES_SD_DEFENDER");
		if(level.splitscreen)
		{
			setobjectivescoretext(game["attackers"],&"OBJECTIVES_DEM_ATTACKER");
			setobjectivescoretext(game["defenders"],&"OBJECTIVES_SD_DEFENDER");
		}
		else
		{
			setobjectivescoretext(game["attackers"],&"OBJECTIVES_DEM_ATTACKER_SCORE");
			setobjectivescoretext(game["defenders"],&"OBJECTIVES_SD_DEFENDER_SCORE");
		}

		setobjectivehinttext(game["attackers"],&"OBJECTIVES_DEM_ATTACKER_HINT");
		setobjectivehinttext(game["defenders"],&"OBJECTIVES_SD_DEFENDER_HINT");
	}

	level.dembombzonename = "bombzone_dem";
	bombzones = getentarray(level.dembombzonename,"targetname");
	if(bombzones.size == 0)
	{
		level.dembombzonename = "bombzone";
	}

	allowed[0] = "sd";
	allowed[1] = level.dembombzonename;
	allowed[2] = "blocker";
	allowed[3] = "dem";
	maps/mp/gametypes/_gameobjects::main(allowed);
	maps/mp/gametypes/_spawning::create_map_placed_influencers();
	level.spawnmins = (0,0,0);
	level.spawnmaxs = (0,0,0);
	maps/mp/gametypes/_spawnlogic::dropspawnpoints("mp_dem_spawn_attacker_a");
	maps/mp/gametypes/_spawnlogic::dropspawnpoints("mp_dem_spawn_attacker_b");
	maps/mp/gametypes/_spawnlogic::dropspawnpoints("mp_dem_spawn_defender_a");
	maps/mp/gametypes/_spawnlogic::dropspawnpoints("mp_dem_spawn_defender_b");
	if(!(IsDefined(game["overtime_round"])))
	{
		maps/mp/gametypes/_spawnlogic::placespawnpoints("mp_dem_spawn_defender_start");
		maps/mp/gametypes/_spawnlogic::placespawnpoints("mp_dem_spawn_attacker_start");
	}
	else
	{
		maps/mp/gametypes/_spawnlogic::placespawnpoints("mp_dem_spawn_attackerOT_start");
		maps/mp/gametypes/_spawnlogic::placespawnpoints("mp_dem_spawn_defenderOT_start");
	}

	maps/mp/gametypes/_spawnlogic::addspawnpoints(game["attackers"],"mp_dem_spawn_attacker");
	maps/mp/gametypes/_spawnlogic::addspawnpoints(game["defenders"],"mp_dem_spawn_defender");
	if(!(IsDefined(game["overtime_round"])))
	{
		maps/mp/gametypes/_spawnlogic::addspawnpoints(game["defenders"],"mp_dem_spawn_defender_a");
		maps/mp/gametypes/_spawnlogic::addspawnpoints(game["defenders"],"mp_dem_spawn_defender_b");
	}

	maps/mp/gametypes/_spawning::updateallspawnpoints();
	level.mapcenter = maps/mp/gametypes/_spawnlogic::findboxcenter(level.spawnmins,level.spawnmaxs);
	setmapcenter(level.mapcenter);
	spawnpoint = maps/mp/gametypes/_spawnlogic::getrandomintermissionpoint();
	setdemointermissionpoint(spawnpoint.origin,spawnpoint.angles);
	level.spawn_start = [];
	if(IsDefined(game["overtime_round"]))
	{
		level.spawn_start["axis"] = maps/mp/gametypes/_spawnlogic::getspawnpointarray("mp_dem_spawn_attackerOT_start");
		level.spawn_start["allies"] = maps/mp/gametypes/_spawnlogic::getspawnpointarray("mp_dem_spawn_defenderOT_start");
	}
	else
	{
		level.spawn_start["axis"] = maps/mp/gametypes/_spawnlogic::getspawnpointarray("mp_dem_spawn_defender_start");
		level.spawn_start["allies"] = maps/mp/gametypes/_spawnlogic::getspawnpointarray("mp_dem_spawn_attacker_start");
	}

	thread updategametypedvars();
	thread bombs();
}

//Function Number: 9
onspawnplayerunified()
{
	self.isplanting = 0;
	self.isdefusing = 0;
	self.isbombcarrier = 0;
	maps/mp/gametypes/_spawning::onspawnplayer_unified();
}

//Function Number: 10
onspawnplayer(predictedspawn)
{
	if(!(predictedspawn))
	{
		self.isplanting = 0;
		self.isdefusing = 0;
		self.isbombcarrier = 0;
		if(IsDefined(self.carryicon))
		{
			self.carryicon destroyelem();
			self.carryicon = undefined;
		}
	}

	if(!(IsDefined(game["overtime_round"])))
	{
		if(self.pers["team"] == game["attackers"])
		{
			spawnpointname = "mp_dem_spawn_attacker_start";
		}
		else
		{
			spawnpointname = "mp_dem_spawn_defender_start";
		}
	}
	else if(IsDefined(game["overtime_round"]))
	{
		if(self.pers["team"] == game["attackers"])
		{
			spawnpointname = "mp_dem_spawn_attackerOT_start";
		}
		else
		{
			spawnpointname = "mp_dem_spawn_defenderOT_start";
		}
	}

	spawnpoints = maps/mp/gametypes/_spawnlogic::getspawnpointarray(spawnpointname);
/#
	assert(spawnpoints.size);
#/
	spawnpoint = maps/mp/gametypes/_spawnlogic::getspawnpoint_random(spawnpoints);
	if(predictedspawn)
	{
		self predictspawnpoint(spawnpoint.origin,spawnpoint.angles);
	}
	else
	{
		self spawn(spawnpoint.origin,spawnpoint.angles,"dem");
	}
}

//Function Number: 11
dem_playerspawnedcb()
{
	level notify("spawned_player");
}

//Function Number: 12
onplayerkilled(einflictor,attacker,idamage,smeansofdeath,sweapon,vdir,shitloc,psoffsettime,deathanimduration)
{
	thread checkallowspectating();
	bombzone = undefined;
	for(index = 0;index < level.bombzones.size;index++)
	{
		if(!IsDefined(level.bombzones[index].bombexploded) || !level.bombzones[index].bombexploded)
		{
			dist = distance2d(self.origin,level.bombzones[index].curorigin);
			if(dist < level.defaultoffenseradius)
			{
				bombzone = level.bombzones[index];
				break;
			}

			dist = distance2d(attacker.origin,level.bombzones[index].curorigin);
			if(dist < level.defaultoffenseradius)
			{
				inbombzone = 1;
				break;
			}
		}
	}

	if(IsDefined(bombzone) && isplayer(attacker) && attacker.pers["team"] != self.pers["team"])
	{
		if(bombzone maps/mp/gametypes/_gameobjects::getownerteam() != attacker.team)
		{
			if(!(IsDefined(attacker.dem_offends)))
			{
				attacker.dem_offends = 0;
			}

			attacker.dem_offends++;
			if(level.playeroffensivemax >= attacker.dem_offends)
			{
				attacker maps/mp/_medals::offenseglobalcount();
				attacker addplayerstatwithgametype("OFFENDS",1);
				self recordkillmodifier("defending");
				maps/mp/_scoreevents::processscoreevent("killed_defender",attacker,self,sweapon);
			}
			else
			{
/#
				attacker iprintlnbold("GAMETYPE DEBUG: NOT GIVING YOU OFFENSIVE CREDIT AS BOOSTING PREVENTION");
			}
#/
		}
		else
		{
			if(!(IsDefined(attacker.dem_defends)))
			{
				attacker.dem_defends = 0;
			}

			attacker.dem_defends++;
			if(level.playerdefensivemax >= attacker.dem_defends)
			{
				if(IsDefined(attacker.pers["defends"]))
				{
					attacker.pers["defends"]++;
					attacker.defends = attacker.pers["defends"];
				}

				attacker maps/mp/_medals::defenseglobalcount();
				attacker addplayerstatwithgametype("DEFENDS",1);
				self recordkillmodifier("assaulting");
				maps/mp/_scoreevents::processscoreevent("killed_attacker",attacker,self,sweapon);
			}
			else
			{
/#
				attacker iprintlnbold("GAMETYPE DEBUG: NOT GIVING YOU DEFENSIVE CREDIT AS BOOSTING PREVENTION");
			}
		}
	}
#/
	if(self.isplanting == 1)
	{
		self recordkillmodifier("planting");
	}

	if(self.isdefusing == 1)
	{
		self recordkillmodifier("defusing");
	}
}

//Function Number: 13
checkallowspectating()
{
	self endon("disconnect");
	wait(0.05);
	update = 0;
	livesleft = !level.numlives && !self.pers["lives"];
	if(!level.alivecount[game["attackers"]] && !livesleft)
	{
		level.spectateoverride[game["attackers"]].allowenemyspectate = 1;
		update = 1;
	}

	if(!level.alivecount[game["defenders"]] && !livesleft)
	{
		level.spectateoverride[game["defenders"]].allowenemyspectate = 1;
		update = 1;
	}

	if(update)
	{
		maps/mp/gametypes/_spectating::updatespectatesettings();
	}
}

//Function Number: 14
dem_endgame(winningteam,endreasontext)
{
	if(IsDefined(winningteam) && winningteam != "tie")
	{
		maps/mp/gametypes/_globallogic_score::giveteamscoreforobjective(winningteam,1);
	}

	thread maps/mp/gametypes/_globallogic::endgame(winningteam,endreasontext);
}

//Function Number: 15
ondeadevent(team)
{
	if(level.bombexploded || level.bombdefused)
	{
		return;
	}

	if(team == "all")
	{
		if(level.bombplanted)
		{
			dem_endgame(game["attackers"],game["strings"][game["defenders"] + "_eliminated"]);
		}
		else
		{
			dem_endgame(game["defenders"],game["strings"][game["attackers"] + "_eliminated"]);
		}
	}
	else if(team == game["attackers"])
	{
		if(level.bombplanted)
		{
			return;
		}

		dem_endgame(game["defenders"],game["strings"][game["attackers"] + "_eliminated"]);
	}
	else if(team == game["defenders"])
	{
		dem_endgame(game["attackers"],game["strings"][game["defenders"] + "_eliminated"]);
	}
}

//Function Number: 16
ononeleftevent(team)
{
	if(level.bombexploded || level.bombdefused)
	{
		return;
	}

	warnlastplayer(team);
}

//Function Number: 17
ontimelimit()
{
	if(IsDefined(game["overtime_round"]))
	{
		dem_endgame("tie",game["strings"]["time_limit_reached"]);
	}
	else if(level.teambased)
	{
		bombzonesleft = 0;
		for(index = 0;index < level.bombzones.size;index++)
		{
			if(!IsDefined(level.bombzones[index].bombexploded) || !level.bombzones[index].bombexploded)
			{
				bombzonesleft++;
			}
		}

		if(bombzonesleft == 0)
		{
			dem_endgame(game["attackers"],game["strings"]["target_destroyed"]);
		}
		else
		{
			dem_endgame(game["defenders"],game["strings"]["time_limit_reached"]);
		}
	}
	else
	{
		dem_endgame("tie",game["strings"]["time_limit_reached"]);
	}
}

//Function Number: 18
warnlastplayer(team)
{
	if(!(IsDefined(level.warnedlastplayer)))
	{
		level.warnedlastplayer = [];
	}

	if(IsDefined(level.warnedlastplayer[team]))
	{
		return;
	}

	level.warnedlastplayer[team] = 1;
	players = level.players;
	for(i = 0;i < players.size;i++)
	{
		player = players[i];
		if(IsDefined(player.pers["team"]) && player.pers["team"] == team && IsDefined(player.pers["class"]))
		{
			if(player.sessionstate == "playing" && !player.afk)
			{
				break;
			}
		}
	}

	if(i == players.size)
	{
		return;
	}

	players[i] thread givelastattackerwarning();
}

//Function Number: 19
givelastattackerwarning()
{
	self endon("death");
	self endon("disconnect");
	fullhealthtime = 0;
	interval = 0.05;
	while(1)
	{
		if(self.health != self.maxhealth)
		{
			fullhealthtime = 0;
		}
		else
		{
			fullhealthtime = fullhealthtime + interval;
		}

		wait(interval);
		if(self.health == self.maxhealth && fullhealthtime >= 3)
		{
			break;
		}
	}

	self maps/mp/gametypes/_globallogic_audio::leaderdialogonplayer("sudden_death");
}

//Function Number: 20
updategametypedvars()
{
	level.planttime = getgametypesetting("plantTime");
	level.defusetime = getgametypesetting("defuseTime");
	level.bombtimer = getgametypesetting("bombTimer");
	level.extratime = getgametypesetting("extraTime");
	level.overtimetimelimit = getgametypesetting("OvertimetimeLimit");
	level.teamkillpenaltymultiplier = getgametypesetting("teamKillPenalty");
	level.teamkillscoremultiplier = getgametypesetting("teamKillScore");
	level.playereventslpm = getgametypesetting("maxPlayerEventsPerMinute");
	level.bombeventslpm = getgametypesetting("maxObjectiveEventsPerMinute");
	level.playeroffensivemax = getgametypesetting("maxPlayerOffensive");
	level.playerdefensivemax = getgametypesetting("maxPlayerDefensive");
}

//Function Number: 21
resetbombzone()
{
	if(IsDefined(game["overtime_round"]))
	{
		self maps/mp/gametypes/_gameobjects::setownerteam("neutral");
		self maps/mp/gametypes/_gameobjects::allowuse("any");
	}
	else
	{
		self maps/mp/gametypes/_gameobjects::allowuse("enemy");
	}

	self maps/mp/gametypes/_gameobjects::setusetime(level.planttime);
	self maps/mp/gametypes/_gameobjects::setusetext(&"MP_PLANTING_EXPLOSIVE");
	self maps/mp/gametypes/_gameobjects::setusehinttext(&"PLATFORM_HOLD_TO_PLANT_EXPLOSIVES");
	self maps/mp/gametypes/_gameobjects::setkeyobject(level.ddbomb);
	self maps/mp/gametypes/_gameobjects::set2dicon("friendly","waypoint_defend" + self.label);
	self maps/mp/gametypes/_gameobjects::set3dicon("friendly","waypoint_defend" + self.label);
	self maps/mp/gametypes/_gameobjects::set2dicon("enemy","waypoint_target" + self.label);
	self maps/mp/gametypes/_gameobjects::set3dicon("enemy","waypoint_target" + self.label);
	self maps/mp/gametypes/_gameobjects::setvisibleteam("any");
	self.useweapon = "briefcase_bomb_mp";
}

//Function Number: 22
setupfordefusing()
{
	self maps/mp/gametypes/_gameobjects::allowuse("friendly");
	self maps/mp/gametypes/_gameobjects::setusetime(level.defusetime);
	self maps/mp/gametypes/_gameobjects::setusetext(&"MP_DEFUSING_EXPLOSIVE");
	self maps/mp/gametypes/_gameobjects::setusehinttext(&"PLATFORM_HOLD_TO_DEFUSE_EXPLOSIVES");
	self maps/mp/gametypes/_gameobjects::setkeyobject(undefined);
	self maps/mp/gametypes/_gameobjects::set2dicon("friendly","compass_waypoint_defuse" + self.label);
	self maps/mp/gametypes/_gameobjects::set3dicon("friendly","waypoint_defuse" + self.label);
	self maps/mp/gametypes/_gameobjects::set2dicon("enemy","compass_waypoint_defend" + self.label);
	self maps/mp/gametypes/_gameobjects::set3dicon("enemy","waypoint_defend" + self.label);
	self maps/mp/gametypes/_gameobjects::setvisibleteam("any");
}

//Function Number: 23
bombs()
{
	level.bombaplanted = 0;
	level.bombbplanted = 0;
	level.bombplanted = 0;
	level.bombdefused = 0;
	level.bombexploded = 0;
	sdbomb = getent("sd_bomb","targetname");
	if(IsDefined(sdbomb))
	{
		sdbomb delete();
	}

	precachemodel("t5_weapon_briefcase_bomb_world");
	level.bombzones = [];
	bombzones = getentarray(level.dembombzonename,"targetname");
	for(index = 0;index < bombzones.size;index++)
	{
		trigger = bombzones[index];
		scriptlabel = trigger.script_label;
		visuals = getentarray(bombzones[index].target,"targetname");
		clipbrushes = getentarray("bombzone_clip" + scriptlabel,"targetname");
		defusetrig = getent(visuals[0].target,"targetname");
		bombsiteteamowner = game["defenders"];
		bombsiteallowuse = "enemy";
		if(IsDefined(game["overtime_round"]))
		{
			if(scriptlabel != "_overtime")
			{
				trigger delete();
				defusetrig delete();
				visuals[0] delete();
				foreach(clip in clipbrushes)
				{
					clip delete();
				}
			}
			else
			{
				bombsiteteamowner = "neutral";
				bombsiteallowuse = "any";
				scriptlabel = "_a";
				if(scriptlabel == "_overtime")
				{
					trigger delete();
					defusetrig delete();
					visuals[0] delete();
					foreach(clip in clipbrushes)
					{
						clip delete();
					}
				}
				else
				{
					name = istring(scriptlabel);
					precachestring(name);
					bombzone = maps/mp/gametypes/_gameobjects::createuseobject(bombsiteteamowner,trigger,visuals,(0,0,0),name);
					bombzone maps/mp/gametypes/_gameobjects::allowuse(bombsiteallowuse);
					bombzone maps/mp/gametypes/_gameobjects::setusetime(level.planttime);
					bombzone maps/mp/gametypes/_gameobjects::setusetext(&"MP_PLANTING_EXPLOSIVE");
					bombzone maps/mp/gametypes/_gameobjects::setusehinttext(&"PLATFORM_HOLD_TO_PLANT_EXPLOSIVES");
					bombzone maps/mp/gametypes/_gameobjects::setkeyobject(level.ddbomb);
					bombzone.label = scriptlabel;
					bombzone.index = index;
					bombzone maps/mp/gametypes/_gameobjects::set2dicon("friendly","compass_waypoint_defend" + scriptlabel);
					bombzone maps/mp/gametypes/_gameobjects::set3dicon("friendly","waypoint_defend" + scriptlabel);
					bombzone maps/mp/gametypes/_gameobjects::set2dicon("enemy","compass_waypoint_target" + scriptlabel);
					bombzone maps/mp/gametypes/_gameobjects::set3dicon("enemy","waypoint_target" + scriptlabel);
					bombzone maps/mp/gametypes/_gameobjects::setvisibleteam("any");
					bombzone.onbeginuse = ::onbeginuse;
					bombzone.onenduse = ::onenduse;
					bombzone.onuse = ::onuseobject;
					bombzone.oncantuse = ::oncantuse;
					bombzone.useweapon = "briefcase_bomb_mp";
					bombzone.visuals[0].killcament = spawn("script_model",128 + VectorScale((0,0,1)));
					for(i = 0;i < visuals.size;i++)
					{
						if(IsDefined(visuals[i].script_exploder))
						{
							bombzone.exploderindex = visuals[i].script_exploder;
							break;
						}
					}

					level.bombzones[level.bombzones.size] = bombzone;
					bombzone.bombdefusetrig = defusetrig;
/#
					assert(IsDefined(bombzone.bombdefusetrig));
#/
					bombzone.bombdefusetrig.origin = 10000 + VectorScale((0,0,-1));
					bombzone.bombdefusetrig.label = scriptlabel;
					dem_enemy_base_influencer_score = level.spawnsystem.dem_enemy_base_influencer_score;
					dem_enemy_base_influencer_score_curve = level.spawnsystem.dem_enemy_base_influencer_score_curve;
					dem_enemy_base_influencer_radius = level.spawnsystem.dem_enemy_base_influencer_radius;
					team_mask = getteammask(game["attackers"]);
					bombzone.spawninfluencer = addsphereinfluencer(level.spawnsystem.einfluencer_type_game_mode,trigger.origin,dem_enemy_base_influencer_radius,dem_enemy_base_influencer_score,team_mask,"dem_enemy_base,r,s",maps/mp/gametypes/_spawning::get_score_curve_index(dem_enemy_base_influencer_score_curve));
				}
			}
		}
	}

	for(index = 0;index < level.bombzones.size;index++)
	{
		array = [];
		for(otherindex = 0;otherindex < level.bombzones.size;otherindex++)
		{
			if(otherindex != index)
			{
				array[array.size] = level.bombzones[otherindex];
			}
		}

		level.bombzones[index].otherbombzones = array;
	}
}

//Function Number: 24
onbeginuse(player)
{
	timeremaining = maps/mp/gametypes/_globallogic_utils::gettimeremaining();
	if(timeremaining <= level.planttime * 1000)
	{
		maps/mp/gametypes/_globallogic_utils::pausetimer();
		level.haspausedtimer = 1;
	}

	if(self maps/mp/gametypes/_gameobjects::isfriendlyteam(player.pers["team"]))
	{
		player playsound("mpl_sd_bomb_defuse");
		player.isdefusing = 1;
		player thread maps/mp/gametypes/_battlechatter_mp::gametypespecificbattlechatter("sd_enemyplant",player.pers["team"]);
		bestdistance = 9000000;
		closestbomb = undefined;
		if(IsDefined(level.ddbombmodel))
		{
			keys = getarraykeys(level.ddbombmodel);
			for(bomblabel = 0;bomblabel < keys.size;bomblabel++)
			{
				bomb = level.ddbombmodel[keys[bomblabel]];
				if(!(IsDefined(bomb)))
				{
				}
				else
				{
					dist = distancesquared(player.origin,bomb.origin);
					if(dist < bestdistance)
					{
						bestdistance = dist;
						closestbomb = bomb;
					}
				}
			}

/#
			assert(IsDefined(closestbomb));
#/
			player.defusing = closestbomb;
			closestbomb hide();
		}
	}
	else
	{
		player.isplanting = 1;
		player thread maps/mp/gametypes/_battlechatter_mp::gametypespecificbattlechatter("sd_friendlyplant",player.pers["team"]);
	}

	player playsound("fly_bomb_raise_plr");
}

//Function Number: 25
onenduse(team,player,result)
{
	if(!(IsDefined(player)))
	{
		return;
	}

	if(!level.bombaplanted && !level.bombbplanted)
	{
		maps/mp/gametypes/_globallogic_utils::resumetimer();
		level.haspausedtimer = 0;
	}

	player.isdefusing = 0;
	player.isplanting = 0;
	player notify("event_ended");
	if(self maps/mp/gametypes/_gameobjects::isfriendlyteam(player.pers["team"]))
	{
		if(IsDefined(player.defusing) && !result)
		{
			player.defusing show();
		}
	}
}

//Function Number: 26
oncantuse(player)
{
	player iprintlnbold(&"MP_CANT_PLANT_WITHOUT_BOMB");
}

//Function Number: 27
onuseobject(player)
{
	team = player.team;
	enemyteam = getotherteam(team);
	self updateeventsperminute();
	player updateeventsperminute();
	if(!(self maps/mp/gametypes/_gameobjects::isfriendlyteam(team)))
	{
		self maps/mp/gametypes/_gameobjects::setflags(1);
		level thread bombplanted(self,player);
		player logstring("bomb planted: " + self.label);
		bbprint("mpobjective","gametime %d objtype %s label %s team %s",GetTime(),"dem_bombplant",self.label,team);
		player notify("bomb_planted");
		thread maps/mp/gametypes/_globallogic_audio::set_music_on_team("DEM_WE_PLANT",team,0,0,5);
		thread maps/mp/gametypes/_globallogic_audio::set_music_on_team("DEM_THEY_PLANT",enemyteam,0,0,5);
		if(IsDefined(player.pers["plants"]))
		{
			player.pers["plants"]++;
			player.plants = player.pers["plants"];
		}

		if(!(isscoreboosting(player,self)))
		{
			maps/mp/_demo::bookmark("event",GetTime(),player);
			player addplayerstatwithgametype("PLANTS",1);
			maps/mp/_scoreevents::processscoreevent("planted_bomb",player);
			player recordgameevent("plant");
		}
		else
		{
/#
			player iprintlnbold("GAMETYPE DEBUG: NOT GIVING YOU PLANT CREDIT AS BOOSTING PREVENTION");
		}
#/
		level thread maps/mp/_popups::displayteammessagetoall(&"MP_EXPLOSIVES_PLANTED_BY",player);
		maps/mp/gametypes/_globallogic_audio::leaderdialog("bomb_planted");
	}
	else
	{
		self maps/mp/gametypes/_gameobjects::setflags(0);
		player notify("bomb_defused");
		player logstring("bomb defused: " + self.label);
		self thread bombdefused();
		self resetbombzone();
		bbprint("mpobjective","gametime %d objtype %s label %s team %s",GetTime(),"dem_bombdefused",self.label,team);
		if(IsDefined(player.pers["defuses"]))
		{
			player.pers["defuses"]++;
			player.defuses = player.pers["defuses"];
		}

		if(!(isscoreboosting(player,self)))
		{
			maps/mp/_demo::bookmark("event",GetTime(),player);
			player addplayerstatwithgametype("DEFUSES",1);
			maps/mp/_scoreevents::processscoreevent("defused_bomb",player);
			player recordgameevent("defuse");
		}
		else
		{
/#
			player iprintlnbold("GAMETYPE DEBUG: NOT GIVING YOU DEFUSE CREDIT AS BOOSTING PREVENTION");
		}
#/
		level thread maps/mp/_popups::displayteammessagetoall(&"MP_EXPLOSIVES_DEFUSED_BY",player);
		thread maps/mp/gametypes/_globallogic_audio::set_music_on_team("DEM_WE_DEFUSE",team,0,0,5);
		thread maps/mp/gametypes/_globallogic_audio::set_music_on_team("DEM_THEY_DEFUSE",enemyteam,0,0,5);
		maps/mp/gametypes/_globallogic_audio::leaderdialog("bomb_defused");
	}
}

//Function Number: 28
ondrop(player)
{
	if(!(level.bombplanted))
	{
		if(IsDefined(player))
		{
			player logstring("bomb dropped");
		}
		else
		{
			logstring("bomb dropped");
		}
	}

	player notify("event_ended");
	self maps/mp/gametypes/_gameobjects::set3dicon("friendly","waypoint_bomb");
	maps/mp/_utility::playsoundonplayers(game["bomb_dropped_sound"],game["attackers"]);
}

//Function Number: 29
onpickup(player)
{
	player.isbombcarrier = 1;
	self maps/mp/gametypes/_gameobjects::set3dicon("friendly","waypoint_defend");
	if(!(level.bombdefused))
	{
		thread playsoundonplayers("mus_sd_pickup" + "_" + level.teampostfix[player.pers["team"]],player.pers["team"]);
		maps/mp/gametypes/_globallogic_audio::leaderdialog("bomb_taken",player.pers["team"]);
		player logstring("bomb taken");
	}

	maps/mp/_utility::playsoundonplayers(game["bomb_recovered_sound"],game["attackers"]);
}

//Function Number: 30
onreset()
{
}

//Function Number: 31
bombreset(label,reason)
{
	if(label == "_a")
	{
		level.bombaplanted = 0;
		setbombtimer("A",0);
	}
	else
	{
		level.bombbplanted = 0;
		setbombtimer("B",0);
	}

	setmatchflag("bomb_timer" + label,0);
	if(!level.bombaplanted && !level.bombbplanted)
	{
		maps/mp/gametypes/_globallogic_utils::resumetimer();
	}

	self.visuals[0] maps/mp/gametypes/_globallogic_utils::stoptickingsound();
}

//Function Number: 32
dropbombmodel(player,site)
{
	trace = bullettrace(20 + VectorScale((0,0,1)),player.origin,2000 - VectorScale((0,0,1)),player.origin);
	tempangle = randomfloat(360);
	forward = (cos(tempangle),sin(tempangle),0);
	forward = vectornormalize(vectordot(forward,trace["normal"]) - VectorScale(trace["normal"]));
	dropangles = VectorToAngles(forward);
	if(IsDefined(trace["surfacetype"]) && trace["surfacetype"] == "water")
	{
		phystrace = playerphysicstrace(20 + VectorScale((0,0,1)),player.origin);
		if(IsDefined(phystrace))
		{
			trace["position"] = phystrace;
		}
	}

	level.ddbombmodel[site] = spawn("script_model",trace["position"]);
	level.ddbombmodel[site].angles = dropangles;
	level.ddbombmodel[site] setmodel("prop_suitcase_bomb");
}

//Function Number: 33
bombplanted(destroyedobj,player)
{
	level endon("game_ended");
	destroyedobj endon("bomb_defused");
	team = player.team;
	game["challenge"][team]["plantedBomb"] = 1;
	maps/mp/gametypes/_globallogic_utils::pausetimer();
	destroyedobj.bombplanted = 1;
	destroyedobj.visuals[0] thread maps/mp/gametypes/_globallogic_utils::playtickingsound("mpl_sab_ui_suitcasebomb_timer");
	destroyedobj.tickingobject = destroyedobj.visuals[0];
	label = destroyedobj.label;
	detonatetime = int(GetTime() + level.bombtimer * 1000);
	updatebombtimers(label,detonatetime);
	destroyedobj.detonatetime = detonatetime;
	trace = bullettrace(20 + VectorScale((0,0,1)),player.origin,2000 - VectorScale((0,0,1)),player.origin);
	tempangle = randomfloat(360);
	forward = (cos(tempangle),sin(tempangle),0);
	forward = vectornormalize(vectordot(forward,trace["normal"]) - VectorScale(trace["normal"]));
	dropangles = VectorToAngles(forward);
	self dropbombmodel(player,destroyedobj.label);
	destroyedobj maps/mp/gametypes/_gameobjects::allowuse("none");
	destroyedobj maps/mp/gametypes/_gameobjects::setvisibleteam("none");
	if(IsDefined(game["overtime_round"]))
	{
		destroyedobj maps/mp/gametypes/_gameobjects::setownerteam(getotherteam(player.team));
	}

	destroyedobj setupfordefusing();
	player.isbombcarrier = 0;
	game["challenge"][team]["plantedBomb"] = 1;
	destroyedobj waitlongdurationwithbombtimeupdate(label,level.bombtimer);
	destroyedobj bombreset(label,"bomb_exploded");
	if(level.gameended)
	{
		return;
	}

	bbprint("mpobjective","gametime %d objtype %s label %s team %s",GetTime(),"dem_bombexplode",label,team);
	destroyedobj.bombexploded = 1;
	game["challenge"][team]["destroyedBombSite"] = 1;
	explosionorigin = destroyedobj.curorigin;
	level.ddbombmodel[destroyedobj.label] delete();
	if(IsDefined(player))
	{
		destroyedobj.visuals[0] radiusdamage(explosionorigin,512,200,20,player,"MOD_EXPLOSIVE","briefcase_bomb_mp");
		player addplayerstatwithgametype("DESTRUCTIONS",1);
		level thread maps/mp/_popups::displayteammessagetoall(&"MP_EXPLOSIVES_BLOWUP_BY",player);
		maps/mp/_scoreevents::processscoreevent("bomb_detonated",player);
		player recordgameevent("destroy");
	}
	else
	{
		destroyedobj.visuals[0] radiusdamage(explosionorigin,512,200,20,undefined,"MOD_EXPLOSIVE","briefcase_bomb_mp");
	}

	currenttime = GetTime();
	if(IsDefined(level.lastbombexplodetime) && level.lastbombexplodebyteam == player.team)
	{
		if(level.lastbombexplodetime + 10000 > currenttime)
		{
			for(i = 0;i < level.players.size;i++)
			{
				if(level.players[i].team == player.team)
				{
					level.players[i] maps/mp/_challenges::bothbombsdetonatewithintime();
				}
			}
		}
	}

	level.lastbombexplodetime = currenttime;
	level.lastbombexplodebyteam = player.team;
	rot = randomfloat(360);
	explosioneffect = spawnfx(level._effect["bombexplosion"],50 + VectorScale((0,0,1)),explosionorigin,(0,0,1));
	triggerfx(explosioneffect);
	thread playsoundinspace("mpl_sd_exp_suitcase_bomb_main",explosionorigin);
	if(IsDefined(destroyedobj.exploderindex))
	{
		exploder(destroyedobj.exploderindex);
	}

	bombzonesleft = 0;
	for(index = 0;index < level.bombzones.size;index++)
	{
		if(!IsDefined(level.bombzones[index].bombexploded) || !level.bombzones[index].bombexploded)
		{
			bombzonesleft++;
		}
	}

	destroyedobj maps/mp/gametypes/_gameobjects::disableobject();
	if(bombzonesleft == 0)
	{
		maps/mp/gametypes/_globallogic_utils::pausetimer();
		level.haspausedtimer = 1;
		setgameendtime(0);
		wait(3);
		dem_endgame(team,game["strings"]["target_destroyed"]);
	}
	else
	{
		enemyteam = getotherteam(team);
		thread maps/mp/gametypes/_globallogic_audio::set_music_on_team("DEM_WE_SCORE",team,0,0,5);
		thread maps/mp/gametypes/_globallogic_audio::set_music_on_team("DEM_THEY_SCORE",enemyteam,0,0,5);
		if([[ level.gettimelimit ]]() > 0)
		{
			level.usingextratime = 1;
		}

		removeinfluencer(destroyedobj.spawninfluencer);
		destroyedobj.spawninfluencer = undefined;
		maps/mp/gametypes/_spawnlogic::clearspawnpoints();
		maps/mp/gametypes/_spawnlogic::addspawnpoints(game["attackers"],"mp_dem_spawn_attacker");
		maps/mp/gametypes/_spawnlogic::addspawnpoints(game["defenders"],"mp_dem_spawn_defender");
		if(label == "_a")
		{
			maps/mp/gametypes/_spawnlogic::addspawnpoints(game["attackers"],"mp_dem_spawn_attacker_a");
			maps/mp/gametypes/_spawnlogic::addspawnpoints(game["defenders"],"mp_dem_spawn_defender_b");
		}
		else
		{
			maps/mp/gametypes/_spawnlogic::addspawnpoints(game["attackers"],"mp_dem_spawn_attacker_b");
			maps/mp/gametypes/_spawnlogic::addspawnpoints(game["defenders"],"mp_dem_spawn_defender_a");
		}

		maps/mp/gametypes/_spawning::updateallspawnpoints();
	}
}

//Function Number: 34
gettimelimit()
{
	timelimit = maps/mp/gametypes/_globallogic_defaults::default_gettimelimit();
	if(IsDefined(game["overtime_round"]))
	{
		timelimit = level.overtimetimelimit;
	}

	if(level.usingextratime)
	{
		return timelimit + level.extratime;
	}
}

//Function Number: 35
shouldplayovertimeround()
{
	if(IsDefined(game["overtime_round"]))
	{
		return 0;
	}

	if(game["teamScores"]["allies"] == level.scorelimit - 1 && game["teamScores"]["axis"] == level.scorelimit - 1)
	{
		return 1;
	}

	return 0;
}

//Function Number: 36
waitlongdurationwithbombtimeupdate(whichbomb,duration)
{
	if(duration == 0)
	{
		return;
	}

/#
	assert(duration > 0);
#/
	starttime = GetTime();
	endtime = GetTime() + duration * 1000;
	while(GetTime() < endtime)
	{
		maps/mp/gametypes/_hostmigration::waittillhostmigrationstarts(endtime - GetTime() / 1000);
		while(IsDefined(level.hostmigrationtimer))
		{
			endtime = endtime + 250;
			updatebombtimers(whichbomb,endtime);
			wait(0.25);
		}
	}

/#
	if(GetTime() != endtime)
	{
		println("SCRIPT WARNING: gettime() = " + GetTime() + " NOT EQUAL TO endtime = " + endtime);
	}

		for(;;)
		{
#/
		if(IsDefined(level.hostmigrationtimer))
		{
			endtime = endtime + 250;
			updatebombtimers(whichbomb,endtime);
			wait(0.25);
		}
	}

	return GetTime() - starttime;
}

//Function Number: 37
updatebombtimers(whichbomb,detonatetime)
{
	if(whichbomb == "_a")
	{
		level.bombaplanted = 1;
		setbombtimer("A",int(detonatetime));
	}
	else
	{
		level.bombbplanted = 1;
		setbombtimer("B",int(detonatetime));
	}

	setmatchflag("bomb_timer" + whichbomb,int(detonatetime));
}

//Function Number: 38
bombdefused()
{
	self.tickingobject maps/mp/gametypes/_globallogic_utils::stoptickingsound();
	self maps/mp/gametypes/_gameobjects::allowuse("none");
	self maps/mp/gametypes/_gameobjects::setvisibleteam("none");
	self.bombdefused = 1;
	self notify("bomb_defused");
	self.bombplanted = 0;
	self bombreset(self.label,"bomb_defused");
}

//Function Number: 39
play_one_left_underscore(team,enemyteam)
{
	wait(3);
	if(!IsDefined(team) || !IsDefined(enemyteam))
	{
		return;
	}

	thread maps/mp/gametypes/_globallogic_audio::set_music_on_team("DEM_ONE_LEFT_UNDERSCORE",team,0,0);
	thread maps/mp/gametypes/_globallogic_audio::set_music_on_team("DEM_ONE_LEFT_UNDERSCORE",enemyteam,0,0);
}

//Function Number: 40
updateeventsperminute()
{
	if(!(IsDefined(self.eventsperminute)))
	{
		self.numbombevents = 0;
		self.eventsperminute = 0;
	}

	self.numbombevents++;
	minutespassed = maps/mp/gametypes/_globallogic_utils::gettimepassed() / 60000;
	if(isplayer(self) && IsDefined(self.timeplayed["total"]))
	{
		minutespassed = self.timeplayed["total"] / 60;
	}

	self.eventsperminute = self.numbombevents / minutespassed;
	if(self.eventsperminute > self.numbombevents)
	{
		self.eventsperminute = self.numbombevents;
	}
}

//Function Number: 41
isscoreboosting(player,flag)
{
	if(!(level.rankedmatch))
	{
		return 0;
	}

	if(player.eventsperminute > level.playereventslpm)
	{
		return 1;
	}

	if(flag.eventsperminute > level.bombeventslpm)
	{
		return 1;
	}
}