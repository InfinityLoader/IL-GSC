/*******************************************************************
 * Decompiled By: Bog
 * Decompiled File: maps\mp\gametypes\_globallogic.gsc
 * Game: Call of Duty: Black Ops 2
 * Platform: PC
 * Function Count: 83
 * Decompile Time: 437 ms
 * Timestamp: 10/27/2023 3:00:00 AM
*******************************************************************/

#include common_scripts/utility;
#include maps/mp/_bb;
#include maps/mp/_burnplayer;
#include maps/mp/_busing;
#include maps/mp/_challenges;
#include maps/mp/_decoy;
#include maps/mp/_demo;
#include maps/mp/_gameadvertisement;
#include maps/mp/_gamerep;
#include maps/mp/_multi_extracam;
#include maps/mp/_music;
#include maps/mp/_utility;
#include maps/mp/bots/_bot;
#include maps/mp/gametypes/_battlechatter_mp;
#include maps/mp/gametypes/_class;
#include maps/mp/gametypes/_clientids;
#include maps/mp/gametypes/_damagefeedback;
#include maps/mp/gametypes/_deathicons;
#include maps/mp/gametypes/_dev;
#include maps/mp/gametypes/_friendicons;
#include maps/mp/gametypes/_gameobjects;
#include maps/mp/gametypes/_globallogic;
#include maps/mp/gametypes/_globallogic_audio;
#include maps/mp/gametypes/_globallogic_defaults;
#include maps/mp/gametypes/_globallogic_player;
#include maps/mp/gametypes/_globallogic_score;
#include maps/mp/gametypes/_globallogic_spawn;
#include maps/mp/gametypes/_globallogic_ui;
#include maps/mp/gametypes/_globallogic_utils;
#include maps/mp/gametypes/_healthoverlay;
#include maps/mp/gametypes/_hostmigration;
#include maps/mp/gametypes/_hud;
#include maps/mp/gametypes/_hud_message;
#include maps/mp/gametypes/_hud_util;
#include maps/mp/gametypes/_killcam;
#include maps/mp/gametypes/_menus;
#include maps/mp/gametypes/_objpoints;
#include maps/mp/gametypes/_persistence;
#include maps/mp/gametypes/_scoreboard;
#include maps/mp/gametypes/_serversettings;
#include maps/mp/gametypes/_shellshock;
#include maps/mp/gametypes/_spawnlogic;
#include maps/mp/gametypes/_spectating;
#include maps/mp/gametypes/_tweakables;
#include maps/mp/gametypes/_wager;
#include maps/mp/gametypes/_weaponobjects;
#include maps/mp/gametypes/_weapons;
#include maps/mp/killstreaks/_killstreaks;
#include maps/mp/teams/_teams;

//Function Number: 1
init()
{
	if(!(IsDefined(level.tweakablesinitialized)))
	{
		maps/mp/gametypes/_tweakables::init();
	}

	init_session_mode_flags();
	level.splitscreen = issplitscreen();
	level.xenon = GetDvar(#"E0DDE627") == "true";
	level.ps3 = GetDvar(#"C15079F5") == "true";
	level.wiiu = GetDvar(#"DE5D2CDD") == "true";
	level.onlinegame = sessionmodeisonlinegame();
	level.systemlink = sessionmodeissystemlink();
	level.console = level.xenon || level.ps3 || level.wiiu;
	level.rankedmatch = gamemodeisusingxp() && !ispregame();
	level.leaguematch = gamemodeismode(level.gamemode_league_match);
	level.contractsenabled = !getgametypesetting("disableContracts");
	level.contractsenabled = 0;
/#
	level.rankedmatch = 1;
GetDvarInt(#"5A4675BD") == 1
#/
	level.script = tolower(GetDvar(#"B4B895C4"));
	level.gametype = tolower(GetDvar(#"4F118387"));
	level.teambased = 0;
	level.teamcount = getgametypesetting("teamCount");
	level.multiteam = level.teamcount > 2;
	if(sessionmodeiszombiesgame())
	{
		level.zombie_team_index = level.teamcount + 1;
		if(2 == level.zombie_team_index)
		{
			level.zombie_team = "axis";
		}
		else
		{
			level.zombie_team = "team" + level.zombie_team_index;
		}
	}

	level.teams = [];
	level.teamindex = [];
	teamcount = level.teamcount;
	level.teams["allies"] = "allies";
	level.teams["axis"] = "axis";
	level.teamindex["neutral"] = 0;
	level.teamindex["allies"] = 1;
	level.teamindex["axis"] = 2;
	for(teamindex = 3;teamindex <= teamcount;teamindex++)
	{
		level.teams["team" + teamindex] = "team" + teamindex;
		level.teamindex["team" + teamindex] = teamindex;
	}

	level.overrideteamscore = 0;
	level.overrideplayerscore = 0;
	level.displayhalftimetext = 0;
	level.displayroundendtext = 1;
	level.endgameonscorelimit = 1;
	level.endgameontimelimit = 1;
	level.scoreroundbased = 0;
	level.resetplayerscoreeveryround = 0;
	level.gameforfeited = 0;
	level.forceautoassign = 0;
	level.halftimetype = "halftime";
	level.halftimesubcaption = &"MP_SWITCHING_SIDES_CAPS";
	level.laststatustime = 0;
	level.waswinning = [];
	level.lastslowprocessframe = 0;
	level.placement = [];
	foreach(team in level.teams)
	{
		level.placement[team] = [];
	}

	level.placement["all"] = [];
	level.postroundtime = 7;
	level.inovertime = 0;
	level.defaultoffenseradius = 560;
	level.dropteam = GetDvarInt(#"851B42E5");
	level.infinalkillcam = 0;
	maps/mp/gametypes/_globallogic_ui::init();
	registerdvars();
	maps/mp/gametypes/_class::initperkdvars();
	level.oldschool = GetDvarInt(#"38F47B13") == 1;
	if(level.oldschool)
	{
		logstring("game mode: oldschool");
		setdvar("jump_height",64);
		setdvar("jump_slowdownEnable",0);
		setdvar("bg_fallDamageMinHeight",256);
		setdvar("bg_fallDamageMaxHeight",512);
		setdvar("player_clipSizeMultiplier",2);
	}

	precachemodel("tag_origin");
	precacherumble("dtp_rumble");
	precacherumble("slide_rumble");
	precachestatusicon("hud_status_dead");
	precachestatusicon("hud_status_connecting");
	precache_mp_leaderboards();
	maps/mp/_burnplayer::initburnplayer();
	if(!(IsDefined(game["tiebreaker"])))
	{
		game["tiebreaker"] = 0;
	}

	maps/mp/gametypes/_globallogic_audio::registerdialoggroup("introboost",1);
	maps/mp/gametypes/_globallogic_audio::registerdialoggroup("status",1);
	thread maps/mp/_gameadvertisement::init();
	thread maps/mp/_gamerep::init();
	level.disablechallenges = 0;
	if(level.leaguematch || GetDvarInt(#"8D5C0C16") > 0)
	{
		level.disablechallenges = 1;
	}

	level.disablestattracking = GetDvarInt(#"742CBFAF") > 0;
}

//Function Number: 2
registerdvars()
{
	if(GetDvar(#"38F47B13") == "")
	{
		setdvar("scr_oldschool","0");
	}

	makedvarserverinfo("scr_oldschool");
	if(GetDvar(#"6017B9C") == "")
	{
		setdvar("ui_guncycle",0);
	}

	makedvarserverinfo("ui_guncycle");
	if(GetDvar(#"41A6C572") == "")
	{
		setdvar("ui_weapon_tiers",0);
	}

	makedvarserverinfo("ui_weapon_tiers");
	setdvar("ui_text_endreason","");
	makedvarserverinfo("ui_text_endreason","");
	setmatchflag("bomb_timer",0);
	setmatchflag("enable_popups",1);
	setmatchflag("pregame",ispregame());
	if(GetDvar(#"23853F1F") == "")
	{
		setdvar("scr_vehicle_damage_scalar","1");
	}

	level.vehicledamagescalar = GetDvarFloat(#"23853F1F");
	level.fire_audio_repeat_duration = GetDvarInt(#"917E4521");
	level.fire_audio_random_max_duration = GetDvarInt(#"C2DCBC26");
	teamname = getcustomteamname(level.teamindex["allies"]);
	if(IsDefined(teamname))
	{
		setdvar("g_customTeamName_Allies",teamname);
	}
	else
	{
		setdvar("g_customTeamName_Allies","");
	}

	teamname = getcustomteamname(level.teamindex["axis"]);
	if(IsDefined(teamname))
	{
		setdvar("g_customTeamName_Axis",teamname);
	}
	else
	{
		setdvar("g_customTeamName_Axis","");
	}
}

//Function Number: 3
blank(arg1,arg2,arg3,arg4,arg5,arg6,arg7,arg8,arg9,arg10)
{
}

//Function Number: 4
setupcallbacks()
{
	level.spawnplayer = maps/mp/gametypes/_globallogic_spawn::spawnplayer;
	level.spawnplayerprediction = maps/mp/gametypes/_globallogic_spawn::spawnplayerprediction;
	level.spawnclient = maps/mp/gametypes/_globallogic_spawn::spawnclient;
	level.spawnspectator = maps/mp/gametypes/_globallogic_spawn::spawnspectator;
	level.spawnintermission = maps/mp/gametypes/_globallogic_spawn::spawnintermission;
	level.onplayerscore = maps/mp/gametypes/_globallogic_score::default_onplayerscore;
	level.onteamscore = maps/mp/gametypes/_globallogic_score::default_onteamscore;
	level.wavespawntimer = ::wavespawntimer;
	level.spawnmessage = maps/mp/gametypes/_globallogic_spawn::default_spawnmessage;
	level.onspawnplayer = ::blank;
	level.onspawnplayerunified = ::blank;
	level.onspawnspectator = maps/mp/gametypes/_globallogic_defaults::default_onspawnspectator;
	level.onspawnintermission = maps/mp/gametypes/_globallogic_defaults::default_onspawnintermission;
	level.onrespawndelay = ::blank;
	level.onforfeit = maps/mp/gametypes/_globallogic_defaults::default_onforfeit;
	level.ontimelimit = maps/mp/gametypes/_globallogic_defaults::default_ontimelimit;
	level.onscorelimit = maps/mp/gametypes/_globallogic_defaults::default_onscorelimit;
	level.onalivecountchange = maps/mp/gametypes/_globallogic_defaults::default_onalivecountchange;
	level.ondeadevent = undefined;
	level.ononeleftevent = maps/mp/gametypes/_globallogic_defaults::default_ononeleftevent;
	level.giveteamscore = maps/mp/gametypes/_globallogic_score::giveteamscore;
	level.onlastteamaliveevent = maps/mp/gametypes/_globallogic_defaults::default_onlastteamaliveevent;
	level.gettimelimit = maps/mp/gametypes/_globallogic_defaults::default_gettimelimit;
	level.getteamkillpenalty = maps/mp/gametypes/_globallogic_defaults::default_getteamkillpenalty;
	level.getteamkillscore = maps/mp/gametypes/_globallogic_defaults::default_getteamkillscore;
	level.iskillboosting = maps/mp/gametypes/_globallogic_score::default_iskillboosting;
	level._setteamscore = maps/mp/gametypes/_globallogic_score::_setteamscore;
	level._setplayerscore = maps/mp/gametypes/_globallogic_score::_setplayerscore;
	level._getteamscore = maps/mp/gametypes/_globallogic_score::_getteamscore;
	level._getplayerscore = maps/mp/gametypes/_globallogic_score::_getplayerscore;
	level.onprecachegametype = ::blank;
	level.onstartgametype = ::blank;
	level.onplayerconnect = ::blank;
	level.onplayerdisconnect = ::blank;
	level.onplayerdamage = ::blank;
	level.onplayerkilled = ::blank;
	level.onplayerkilledextraunthreadedcbs = [];
	level.onteamoutcomenotify = maps/mp/gametypes/_hud_message::teamoutcomenotify;
	level.onoutcomenotify = maps/mp/gametypes/_hud_message::outcomenotify;
	level.onteamwageroutcomenotify = maps/mp/gametypes/_hud_message::teamwageroutcomenotify;
	level.onwageroutcomenotify = maps/mp/gametypes/_hud_message::wageroutcomenotify;
	level.setmatchscorehudelemforteam = maps/mp/gametypes/_hud_message::setmatchscorehudelemforteam;
	level.onendgame = ::blank;
	level.onroundendgame = maps/mp/gametypes/_globallogic_defaults::default_onroundendgame;
	level.onmedalawarded = ::blank;
	maps/mp/gametypes/_globallogic_ui::setupcallbacks();
}

//Function Number: 5
precache_mp_leaderboards()
{
	if(maps/mp/bots/_bot::is_bot_ranked_match())
	{
		return;
	}

	if(sessionmodeiszombiesgame())
	{
		return;
	}

	if(!(level.rankedmatch))
	{
		return;
	}

	mapname = GetDvar(#"B4B895C4");
	globalleaderboards = "@"LB_MP_GB_XPPRESTIGE LB_MP_GB_SCORE LB_MP_GB_KDRATIO LB_MP_GB_KILLS LB_MP_GB_WINS LB_MP_GB_DEATHS LB_MP_GB_XPMAXPERGAME LB_MP_GB_TACTICALINSERTS LB_MP_GB_TACTICALINSERTSKILLS LB_MP_GB_PRESTIGEXP LB_MP_GB_HEADSHOTS LB_MP_GB_WEAPONS_PRIMARY LB_MP_GB_WEAPONS_SECONDARY";
	careerleaderboard = "";
	switch(level.gametype)
	{
		case "gun":
		case "oic":
		case "sas":
		case "shrp":
			break;

		default:
			careerleaderboard = " LB_MP_GB_SCOREPERMINUTE";
			break;
	}

	gamemodeleaderboard = " LB_MP_GM_" + level.gametype;
	gamemodeleaderboardext = " LB_MP_GM_" + level.gametype + "_EXT";
	gamemodehcleaderboard = "";
	gamemodehcleaderboardext = "";
	hardcoremode = getgametypesetting("hardcoreMode");
	if(IsDefined(hardcoremode) && hardcoremode)
	{
		gamemodehcleaderboard = gamemodeleaderboard + "_HC";
		gamemodehcleaderboardext = gamemodeleaderboardext + "_HC";
	}

	mapleaderboard = " LB_MP_MAP_" + getsubstr(mapname,3,mapname.size);
	precacheleaderboards(globalleaderboards + careerleaderboard + gamemodeleaderboard + gamemodeleaderboardext + gamemodehcleaderboard + gamemodehcleaderboardext + mapleaderboard);
}

//Function Number: 6
compareteambygamestat(gamestat,teama,teamb,previous_winner_score)
{
	winner = undefined;
	if(teama == "tie")
	{
		winner = "tie";
		if(previous_winner_score < game[gamestat][teamb])
		{
			winner = teamb;
		}
	}
	else if(game[gamestat][teama] == game[gamestat][teamb])
	{
		winner = "tie";
	}
	else if(game[gamestat][teamb] > game[gamestat][teama])
	{
		winner = teamb;
	}
	else
	{
		winner = teama;
	}

	return winner;
}

//Function Number: 7
determineteamwinnerbygamestat(gamestat)
{
	teamkeys = getarraykeys(level.teams);
	winner = teamkeys[0];
	previous_winner_score = game[gamestat][winner];
	for(teamindex = 1;teamindex < teamkeys.size;teamindex++)
	{
		winner = compareteambygamestat(gamestat,winner,teamkeys[teamindex],previous_winner_score);
		if(winner != "tie")
		{
			previous_winner_score = game[gamestat][winner];
		}
	}

	return winner;
}

//Function Number: 8
compareteambyteamscore(teama,teamb,previous_winner_score)
{
	winner = undefined;
	teambscore = [[ level._getteamscore ]](teamb);
	if(teama == "tie")
	{
		winner = "tie";
		if(previous_winner_score < teambscore)
		{
			winner = teamb;
		}

		return winner;
	}

	teamascore = [[ level._getteamscore ]](teama);
	if(teambscore == teamascore)
	{
		winner = "tie";
	}
	else if(teambscore > teamascore)
	{
		winner = teamb;
	}
	else
	{
		winner = teama;
	}

	return winner;
}

//Function Number: 9
determineteamwinnerbyteamscore()
{
	teamkeys = getarraykeys(level.teams);
	winner = teamkeys[0];
	previous_winner_score = [[ level._getteamscore ]](winner);
	for(teamindex = 1;teamindex < teamkeys.size;teamindex++)
	{
		winner = compareteambyteamscore(winner,teamkeys[teamindex],previous_winner_score);
		if(winner != "tie")
		{
			previous_winner_score = [[ level._getteamscore ]](winner);
		}
	}

	return winner;
}

//Function Number: 10
forceend(hostsucks)
{
	if(!(IsDefined(hostsucks)))
	{
		hostsucks = 0;
	}

	if(level.hostforcedend || level.forcedend)
	{
		return;
	}

	winner = undefined;
	if(level.teambased)
	{
		winner = determineteamwinnerbygamestat("teamScores");
		maps/mp/gametypes/_globallogic_utils::logteamwinstring("host ended game",winner);
	}
	else
	{
		winner = maps/mp/gametypes/_globallogic_score::gethighestscoringplayer();
		if(IsDefined(winner))
		{
			logstring("host ended game, win: " + winner.name);
		}
		else
		{
			logstring("host ended game, tie");
		}
	}

	level.forcedend = 1;
	level.hostforcedend = 1;
	if(hostsucks)
	{
		endstring = &"MP_HOST_SUCKS";
	}
	else if(level.splitscreen)
	{
		endstring = &"MP_ENDED_GAME";
	}
	else
	{
		endstring = &"MP_HOST_ENDED_GAME";
	}

	setmatchflag("disableIngameMenu",1);
	makedvarserverinfo("ui_text_endreason",endstring);
	setdvar("ui_text_endreason",endstring);
	thread endgame(winner,endstring);
}

//Function Number: 11
killserverpc()
{
	if(level.hostforcedend || level.forcedend)
	{
		return;
	}

	winner = undefined;
	if(level.teambased)
	{
		winner = determineteamwinnerbygamestat("teamScores");
		maps/mp/gametypes/_globallogic_utils::logteamwinstring("host ended game",winner);
	}
	else
	{
		winner = maps/mp/gametypes/_globallogic_score::gethighestscoringplayer();
		if(IsDefined(winner))
		{
			logstring("host ended game, win: " + winner.name);
		}
		else
		{
			logstring("host ended game, tie");
		}
	}

	level.forcedend = 1;
	level.hostforcedend = 1;
	level.killserver = 1;
	endstring = &"MP_HOST_ENDED_GAME";
/#
	println("kill server; ending game\n");
#/
	thread endgame(winner,endstring);
}

//Function Number: 12
atleasttwoteams()
{
	valid_count = 0;
	foreach(team in level.teams)
	{
		if(level.playercount[team] != 0)
		{
			valid_count++;
		}
	}

	if(valid_count < 2)
	{
		return 0;
	}

	return 1;
}

//Function Number: 13
checkifteamforfeits(team)
{
	if(!(game["everExisted"][team]))
	{
		return 0;
	}

	if(level.playercount[team] < 1 && totalplayercount() > 0)
	{
		return 1;
	}
}

//Function Number: 14
checkforforfeit()
{
	forfeit_count = 0;
	valid_team = undefined;
	foreach(team in level.teams)
	{
		if(checkifteamforfeits(team))
		{
			forfeit_count++;
			if(!(level.multiteam))
			{
				thread [[ level.onforfeit ]](team);
				return 1;
			}
		}
		else
		{
			valid_team = team;
		}
	}

	if(level.multiteam && forfeit_count == level.teams.size - 1)
	{
		thread [[ level.onforfeit ]](valid_team);
		return 1;
	}
}

//Function Number: 15
dospawnqueueupdates()
{
	foreach(team in level.teams)
	{
		if(level.spawnqueuemodified[team])
		{
			[[ level.onalivecountchange ]](team);
		}
	}
}

//Function Number: 16
isteamalldead(team)
{
	return level.everexisted[team] && !level.alivecount[team] && !level.playerlives[team];
}

//Function Number: 17
areallteamsdead()
{
	foreach(team in level.teams)
	{
		if(!(isteamalldead(team)))
		{
			return 0;
		}
	}

	return 1;
}

//Function Number: 18
getlastteamalive()
{
	count = 0;
	everexistedcount = 0;
	aliveteam = undefined;
	foreach(team in level.teams)
	{
		if(level.everexisted[team])
		{
			if(!(isteamalldead(team)))
			{
				aliveteam = team;
				count++;
			}

			everexistedcount++;
		}
	}

	if(everexistedcount > 1 && count == 1)
	{
		return aliveteam;
	}
}

//Function Number: 19
dodeadeventupdates()
{
	if(level.teambased)
	{
		if(areallteamsdead())
		{
			[[ level.ondeadevent ]]("all");
			return 1;
		}

		if(!(IsDefined(level.ondeadevent)))
		{
			lastteamalive = getlastteamalive();
			if(IsDefined(lastteamalive))
			{
				[[ level.onlastteamaliveevent ]](lastteamalive);
				return 1;
			}
		}
		else
		{
			foreach(team in level.teams)
			{
				if(isteamalldead(team))
				{
					[[ level.ondeadevent ]](team);
					return 1;
				}
			}
		}
	}
	else if(totalalivecount() == 0 && totalplayerlives() == 0 && level.maxplayercount > 1)
	{
		[[ level.ondeadevent ]]("all");
		return 1;
	}
}

//Function Number: 20
isonlyoneleftaliveonteam(team)
{
	return level.lastalivecount[team] > 1 && level.alivecount[team] == 1 && level.playerlives[team] == 1;
}

//Function Number: 21
doonelefteventupdates()
{
	if(level.teambased)
	{
		foreach(team in level.teams)
		{
			if(isonlyoneleftaliveonteam(team))
			{
				[[ level.ononeleftevent ]](team);
				return 1;
			}
		}
	}
	else if(totalalivecount() == 1 && totalplayerlives() == 1 && level.maxplayercount > 1)
	{
		[[ level.ononeleftevent ]]("all");
		return 1;
	}
}

//Function Number: 22
updategameevents()
{
/#
GetDvarInt(#"1F8C9394") == 1
#/
	if((level.rankedmatch || level.wagermatch || level.leaguematch) && !level.ingraceperiod)
	{
		if(level.teambased)
		{
			if(!(level.gameforfeited))
			{
				if(game["state"] == "playing" && checkforforfeit())
				{
					return;
				}
			}
			else if(atleasttwoteams())
			{
				level.gameforfeited = 0;
				level notify("abort forfeit");
			}
		}
		else if(!(level.gameforfeited))
		{
			if(totalplayercount() == 1 && level.maxplayercount > 1)
			{
				thread [[ level.onforfeit ]]();
				return;
			}
		}
		else if(totalplayercount() > 1)
		{
			level.gameforfeited = 0;
			level notify("abort forfeit");
		}
	}

	if(!level.playerqueuedrespawn && !level.numlives && !level.inovertime)
	{
		return;
	}

	if(level.ingraceperiod)
	{
		return;
	}

	if(level.playerqueuedrespawn)
	{
		dospawnqueueupdates();
	}

	if(dodeadeventupdates())
	{
		return;
	}

	if(doonelefteventupdates())
	{
	}
}

//Function Number: 23
matchstarttimer()
{
	visionsetnaked("mpIntro",0);
	matchstarttext = createserverfontstring("objective",1.5);
	matchstarttext setpoint("CENTER","CENTER",0,-40);
	matchstarttext.sort = 1001;
	matchstarttext settext(game["strings"]["waiting_for_teams"]);
	matchstarttext.foreground = 0;
	matchstarttext.hidewheninmenu = 1;
	waitforplayers();
	matchstarttext settext(game["strings"]["match_starting_in"]);
	matchstarttimer = createserverfontstring("big",2.2);
	matchstarttimer setpoint("CENTER","CENTER",0,0);
	matchstarttimer.sort = 1001;
	matchstarttimer.color = (1,1,0);
	matchstarttimer.foreground = 0;
	matchstarttimer.hidewheninmenu = 1;
	matchstarttimer maps/mp/gametypes/_hud::fontpulseinit();
	counttime = int(level.prematchperiod);
	if(counttime >= 2)
	{
		while(counttime > 0 && !level.gameended)
		{
			matchstarttimer setvalue(counttime);
			matchstarttimer thread maps/mp/gametypes/_hud::fontpulse(level);
			if(counttime == 2)
			{
				visionsetnaked(GetDvar(#"B4B895C4"),3);
			}

			counttime--;
			foreach(player in level.players)
			{
				player playlocalsound("uin_start_count_down");
			}

			wait(1);
		}
	}
	else
	{
		visionsetnaked(GetDvar(#"B4B895C4"),1);
	}

	matchstarttimer destroyelem();
	matchstarttext destroyelem();
}

//Function Number: 24
matchstarttimerskip()
{
	if(!(ispregame()))
	{
		visionsetnaked(GetDvar(#"B4B895C4"),0);
	}
	else
	{
		visionsetnaked("mpIntro",0);
	}
}

//Function Number: 25
notifyteamwavespawn(team,time)
{
	if(time - level.lastwave[team] > level.wavedelay[team] * 1000)
	{
		level notify("wave_respawn_" + team);
		level.lastwave[team] = time;
		level.waveplayerspawnindex[team] = 0;
	}
}

//Function Number: 26
wavespawntimer()
{
	level endon("game_ended");
	while(game["state"] == "playing")
	{
		time = GetTime();
		foreach(team in level.teams)
		{
			notifyteamwavespawn(team,time);
		}

		wait(0.05);
	}
}

//Function Number: 27
hostidledout()
{
	hostplayer = gethostplayer();
/#
	return 0;
GetDvarInt(#"7AEF62D7") == 1 || GetDvarInt(#"1F8C9394") == 1
#/
	if(IsDefined(hostplayer) && !hostplayer.hasspawned && !IsDefined(hostplayer.selectedclass))
	{
		return 1;
	}
}

//Function Number: 28
incrementmatchcompletionstat(gamemode,playedorhosted,stat)
{
	self adddstat("gameHistory",gamemode,"modeHistory",playedorhosted,stat,1);
}

//Function Number: 29
setmatchcompletionstat(gamemode,playedorhosted,stat)
{
	self setdstat("gameHistory",gamemode,"modeHistory",playedorhosted,stat,1);
}

//Function Number: 30
getcurrentgamemode()
{
	if(gamemodeismode(level.gamemode_league_match))
	{
		return "leaguematch";
	}

	return "publicmatch";
}

//Function Number: 31
getteamscoreratio()
{
	playerteam = self.pers["team"];
	score = getteamscore(playerteam);
	otherteamscore = 0;
	foreach(team in level.teams)
	{
		if(team == playerteam)
		{
		}
		else
		{
			otherteamscore = otherteamscore + getteamscore(team);
		}
	}

	if(level.teams.size > 1)
	{
		otherteamscore = otherteamscore / level.teams.size - 1;
	}

	if(otherteamscore != 0)
	{
		return float(score) / float(otherteamscore);
	}

	return score;
}

//Function Number: 32
gethighestscore()
{
	highestscore = -999999999;
	for(index = 0;index < level.players.size;index++)
	{
		player = level.players[index];
		if(player.score > highestscore)
		{
			highestscore = player.score;
		}
	}

	return highestscore;
}

//Function Number: 33
getnexthighestscore(score)
{
	highestscore = -999999999;
	for(index = 0;index < level.players.size;index++)
	{
		player = level.players[index];
		if(player.score >= score)
		{
		}
		else if(player.score > highestscore)
		{
			highestscore = player.score;
		}
	}

	return highestscore;
}

//Function Number: 34
sendafteractionreport()
{
/#
GetDvarInt(#"7AEF62D7") == 1
#/
	if(!(level.onlinegame))
	{
		return;
	}

	if(ispregame())
	{
		return;
	}

	if(sessionmodeiszombiesgame())
	{
		return;
	}

	for(index = 0;index < level.players.size;index++)
	{
		player = level.players[index];
		if(player is_bot())
		{
		}
		else
		{
			nemesis = player.pers["nemesis_name"];
			if(!(IsDefined(player.pers["killed_players"][nemesis])))
			{
				player.pers["killed_players"][nemesis] = 0;
			}

			if(!(IsDefined(player.pers["killed_by"][nemesis])))
			{
				player.pers["killed_by"][nemesis] = 0;
			}

			spread = player.kills - player.deaths;
			if(player.pers["cur_kill_streak"] > player.pers["best_kill_streak"])
			{
				player.pers["best_kill_streak"] = player.pers["cur_kill_streak"];
			}

			if(level.rankedmatch || level.wagermatch || level.leaguematch)
			{
				player maps/mp/gametypes/_persistence::setafteractionreportstat("privateMatch",0);
			}
			else
			{
				player maps/mp/gametypes/_persistence::setafteractionreportstat("privateMatch",1);
			}

			player setnemesisxuid(player.pers["nemesis_xuid"]);
			player maps/mp/gametypes/_persistence::setafteractionreportstat("nemesisName",nemesis);
			player maps/mp/gametypes/_persistence::setafteractionreportstat("nemesisRank",player.pers["nemesis_rank"]);
			player maps/mp/gametypes/_persistence::setafteractionreportstat("nemesisRankIcon",player.pers["nemesis_rankIcon"]);
			player maps/mp/gametypes/_persistence::setafteractionreportstat("nemesisKills",player.pers["killed_players"][nemesis]);
			player maps/mp/gametypes/_persistence::setafteractionreportstat("nemesisKilledBy",player.pers["killed_by"][nemesis]);
			player maps/mp/gametypes/_persistence::setafteractionreportstat("bestKillstreak",player.pers["best_kill_streak"]);
			player maps/mp/gametypes/_persistence::setafteractionreportstat("kills",player.kills);
			player maps/mp/gametypes/_persistence::setafteractionreportstat("deaths",player.deaths);
			player maps/mp/gametypes/_persistence::setafteractionreportstat("headshots",player.headshots);
			player maps/mp/gametypes/_persistence::setafteractionreportstat("score",player.score);
			player maps/mp/gametypes/_persistence::setafteractionreportstat("xpEarned",int(player.pers["summary"]["xp"]));
			player maps/mp/gametypes/_persistence::setafteractionreportstat("cpEarned",int(player.pers["summary"]["codpoints"]));
			player maps/mp/gametypes/_persistence::setafteractionreportstat("miscBonus",int(player.pers["summary"]["challenge"] + player.pers["summary"]["misc"]));
			player maps/mp/gametypes/_persistence::setafteractionreportstat("matchBonus",int(player.pers["summary"]["match"]));
			player maps/mp/gametypes/_persistence::setafteractionreportstat("demoFileID",getdemofileid());
			player maps/mp/gametypes/_persistence::setafteractionreportstat("leagueTeamID",player getleagueteamid());
			teamscoreratio = player getteamscoreratio();
			scoreboardposition = getplacementforplayer(player);
			if(scoreboardposition < 0)
			{
				scoreboardposition = level.players.size;
			}

			player gamehistoryfinishmatch(4,player.kills,player.deaths,player.score,scoreboardposition,teamscoreratio);
			placement = level.placement["all"];
			for(otherplayerindex = 0;otherplayerindex < placement.size;otherplayerindex++)
			{
				if(level.placement["all"][otherplayerindex] == player)
				{
					recordplayerstats(player,"position",otherplayerindex);
				}
			}

			if(level.wagermatch)
			{
				recordplayerstats(player,"wagerPayout",player.wagerwinnings);
				player maps/mp/gametypes/_wager::setwagerafteractionreportstats();
				player maps/mp/gametypes/_persistence::setafteractionreportstat("wagerMatch",1);
			}
			else
			{
				player maps/mp/gametypes/_persistence::setafteractionreportstat("wagerMatch",0);
			}

			player maps/mp/gametypes/_persistence::setafteractionreportstat("wagerMatchFailed",0);
			if(level.rankedmatch || level.wagermatch || level.leaguematch)
			{
				player maps/mp/gametypes/_persistence::setafteractionreportstat("valid",1);
			}

			if(IsDefined(player.pers["matchesPlayedStatsTracked"]))
			{
				gamemode = getcurrentgamemode();
				player incrementmatchcompletionstat(gamemode,"played","completed");
				if(IsDefined(player.pers["matchesHostedStatsTracked"]))
				{
					player incrementmatchcompletionstat(gamemode,"hosted","completed");
					player.pers["matchesHostedStatsTracked"] = undefined;
				}

				player.pers["matchesPlayedStatsTracked"] = undefined;
			}

			recordplayerstats(player,"highestKillStreak",player.pers["best_kill_streak"]);
			recordplayerstats(player,"numUavCalled",player maps/mp/killstreaks/_killstreaks::getkillstreakusage("uav_used"));
			recordplayerstats(player,"numDogsCalleD",player maps/mp/killstreaks/_killstreaks::getkillstreakusage("dogs_used"));
			recordplayerstats(player,"numDogsKills",player.pers["dog_kills"]);
			recordplayermatchend(player);
			recordplayerstats(player,"presentAtEnd",1);
		}
	}
}

//Function Number: 35
gamehistoryplayerkicked()
{
	teamscoreratio = self getteamscoreratio();
	scoreboardposition = getplacementforplayer(self);
	if(scoreboardposition < 0)
	{
		scoreboardposition = level.players.size;
	}

/#
/#
	assert(IsDefined(self.kills));
#/
/#
	assert(IsDefined(self.deaths));
#/
/#
	assert(IsDefined(self.score));
#/
/#
	assert(IsDefined(scoreboardposition));
#/
/#
	assert(IsDefined(teamscoreratio));
#/
#/
	self gamehistoryfinishmatch(2,self.kills,self.deaths,self.score,scoreboardposition,teamscoreratio);
	if(IsDefined(self.pers["matchesPlayedStatsTracked"]))
	{
		gamemode = getcurrentgamemode();
		self incrementmatchcompletionstat(gamemode,"played","kicked");
		self.pers["matchesPlayedStatsTracked"] = undefined;
	}

	uploadstats(self);
	wait(1);
}

//Function Number: 36
gamehistoryplayerquit()
{
	teamscoreratio = self getteamscoreratio();
	scoreboardposition = getplacementforplayer(self);
	if(scoreboardposition < 0)
	{
		scoreboardposition = level.players.size;
	}

	self gamehistoryfinishmatch(3,self.kills,self.deaths,self.score,scoreboardposition,teamscoreratio);
	if(IsDefined(self.pers["matchesPlayedStatsTracked"]))
	{
		gamemode = getcurrentgamemode();
		self incrementmatchcompletionstat(gamemode,"played","quit");
		if(IsDefined(self.pers["matchesHostedStatsTracked"]))
		{
			self incrementmatchcompletionstat(gamemode,"hosted","quit");
			self.pers["matchesHostedStatsTracked"] = undefined;
		}

		self.pers["matchesPlayedStatsTracked"] = undefined;
	}

	uploadstats(self);
	if(!(self ishost()))
	{
		wait(1);
	}
}

//Function Number: 37
displayroundend(winner,endreasontext)
{
	if(level.displayroundendtext)
	{
		if(level.teambased)
		{
			if(winner == "tie")
			{
				maps/mp/_demo::gameresultbookmark("round_result",level.teamindex["neutral"],level.teamindex["neutral"]);
			}
			else
			{
				maps/mp/_demo::gameresultbookmark("round_result",level.teamindex[winner],level.teamindex["neutral"]);
			}
		}

		setmatchflag("cg_drawSpectatorMessages",0);
		players = level.players;
		for(index = 0;index < players.size;index++)
		{
			player = players[index];
			if(!(waslastround()))
			{
				player notify("round_ended");
			}

			if(!(IsDefined(player.pers["team"])))
			{
				player [[ level.spawnintermission ]](1);
				player closemenu();
				player closeingamemenu();
			}
			else
			{
				if(level.wagermatch)
				{
					if(level.teambased)
					{
						player thread [[ level.onteamwageroutcomenotify ]](winner,1,endreasontext);
						continue;
					}

					player thread [[ level.onwageroutcomenotify ]](winner,endreasontext);
				}
				else if(level.teambased)
				{
					player thread [[ level.onteamoutcomenotify ]](winner,1,endreasontext);
					player maps/mp/gametypes/_globallogic_audio::set_music_on_player("ROUND_END");
				}
				else
				{
					player thread [[ level.onoutcomenotify ]](winner,1,endreasontext);
					player maps/mp/gametypes/_globallogic_audio::set_music_on_player("ROUND_END");
				}

				player setclientuivisibilityflag("hud_visible",0);
				player setclientuivisibilityflag("g_compassShowEnemies",0);
			}
		}
	}

	if(waslastround())
	{
		roundendwait(level.roundenddelay,0);
	}
	else
	{
		thread maps/mp/gametypes/_globallogic_audio::announceroundwinner(winner,level.roundenddelay / 4);
		roundendwait(level.roundenddelay,1);
	}
}

//Function Number: 38
displayroundswitch(winner,endreasontext)
{
	switchtype = level.halftimetype;
	if(switchtype == "halftime")
	{
		if(IsDefined(level.nextroundisovertime) && level.nextroundisovertime)
		{
			switchtype = "overtime";
		}
		else if(level.roundlimit)
		{
			if(game["roundsplayed"] * 2 == level.roundlimit)
			{
				switchtype = "halftime";
			}
			else
			{
				switchtype = "intermission";
			}
		}
		else if(level.scorelimit)
		{
			if(game["roundsplayed"] == level.scorelimit - 1)
			{
				switchtype = "halftime";
			}
			else
			{
				switchtype = "intermission";
			}
		}
		else
		{
			switchtype = "intermission";
		}
	}

	leaderdialog = maps/mp/gametypes/_globallogic_audio::getroundswitchdialog(switchtype);
	setmatchtalkflag("EveryoneHearsEveryone",1);
	players = level.players;
	for(index = 0;index < players.size;index++)
	{
		player = players[index];
		if(!(IsDefined(player.pers["team"])))
		{
			player [[ level.spawnintermission ]](1);
			player closemenu();
			player closeingamemenu();
		}
		else
		{
			player maps/mp/gametypes/_globallogic_audio::leaderdialogonplayer(leaderdialog);
			player maps/mp/gametypes/_globallogic_audio::set_music_on_player("ROUND_SWITCH");
			if(level.wagermatch)
			{
				player thread [[ level.onteamwageroutcomenotify ]](switchtype,1,level.halftimesubcaption);
			}
			else
			{
				player thread [[ level.onteamoutcomenotify ]](switchtype,0,level.halftimesubcaption);
			}

			player setclientuivisibilityflag("hud_visible",0);
		}
	}

	roundendwait(level.halftimeroundenddelay,0);
}

//Function Number: 39
displaygameend(winner,endreasontext)
{
	setmatchtalkflag("EveryoneHearsEveryone",1);
	setmatchflag("cg_drawSpectatorMessages",0);
	if(level.teambased)
	{
		if(winner == "tie")
		{
			maps/mp/_demo::gameresultbookmark("game_result",level.teamindex["neutral"],level.teamindex["neutral"]);
		}
		else
		{
			maps/mp/_demo::gameresultbookmark("game_result",level.teamindex[winner],level.teamindex["neutral"]);
		}
	}

	players = level.players;
	for(index = 0;index < players.size;index++)
	{
		player = players[index];
		if(!(IsDefined(player.pers["team"])))
		{
			player [[ level.spawnintermission ]](1);
			player closemenu();
			player closeingamemenu();
		}
		else
		{
			if(level.wagermatch)
			{
				if(level.teambased)
				{
					player thread [[ level.onteamwageroutcomenotify ]](winner,0,endreasontext);
					continue;
				}

				player thread [[ level.onwageroutcomenotify ]](winner,endreasontext);
			}
			else if(level.teambased)
			{
				player thread [[ level.onteamoutcomenotify ]](winner,0,endreasontext);
			}
			else
			{
				player thread [[ level.onoutcomenotify ]](winner,0,endreasontext);
				if(IsDefined(winner) && player == winner)
				{
					music = game["music"]["victory_" + player.team];
					player maps/mp/gametypes/_globallogic_audio::set_music_on_player(music);
				}
				else if(!(level.splitscreen))
				{
					player maps/mp/gametypes/_globallogic_audio::set_music_on_player("LOSE");
				}
			}

			player setclientuivisibilityflag("hud_visible",0);
			player setclientuivisibilityflag("g_compassShowEnemies",0);
		}
	}

	if(level.teambased)
	{
		thread maps/mp/gametypes/_globallogic_audio::announcegamewinner(winner,level.postroundtime / 2);
		players = level.players;
		for(index = 0;index < players.size;index++)
		{
			player = players[index];
			team = player.pers["team"];
			if(level.splitscreen)
			{
				if(winner == "tie")
				{
					player maps/mp/gametypes/_globallogic_audio::set_music_on_player("DRAW");
					continue;
				}

				if(winner == team)
				{
					music = game["music"]["victory_" + player.team];
					player maps/mp/gametypes/_globallogic_audio::set_music_on_player(music);
					continue;
				}

				player maps/mp/gametypes/_globallogic_audio::set_music_on_player("LOSE");
			}
			else if(winner == "tie")
			{
				player maps/mp/gametypes/_globallogic_audio::set_music_on_player("DRAW");
			}
			else if(winner == team)
			{
				music = game["music"]["victory_" + player.team];
				player maps/mp/gametypes/_globallogic_audio::set_music_on_player(music);
			}
			else
			{
				player maps/mp/gametypes/_globallogic_audio::set_music_on_player("LOSE");
			}
		}
	}

	bbprint("session_epilogs","reason %s",endreasontext);
	bbprint("mpmatchfacts","gametime %d winner %s killstreakcount %d",GetTime(),winner,level.killstreak_counter);
	roundendwait(level.postroundtime,1);
}

//Function Number: 40
getendreasontext()
{
	if(IsDefined(level.endreasontext))
	{
		return level.endreasontext;
	}

	if(hitroundlimit() || hitroundwinlimit())
	{
		return game["strings"]["round_limit_reached"];
	}
	else if(hitscorelimit())
	{
		return game["strings"]["score_limit_reached"];
	}

	if(level.forcedend)
	{
		if(level.hostforcedend)
		{
			return &"MP_HOST_ENDED_GAME";
		}
		else
		{
			return &"MP_ENDED_GAME";
		}
	}

	return game["strings"]["time_limit_reached"];
}

//Function Number: 41
resetoutcomeforallplayers()
{
	players = level.players;
	for(index = 0;index < players.size;index++)
	{
		player = players[index];
		player notify("reset_outcome");
	}
}

//Function Number: 42
startnextround(winner,endreasontext)
{
	if(!(isoneround()))
	{
		displayroundend(winner,endreasontext);
		maps/mp/gametypes/_globallogic_utils::executepostroundevents();
		if(!(waslastround()))
		{
			if(checkroundswitch())
			{
				displayroundswitch(winner,endreasontext);
			}

			if(IsDefined(level.nextroundisovertime) && level.nextroundisovertime)
			{
				if(!(IsDefined(game["overtime_round"])))
				{
					game["overtime_round"] = 1;
				}
				else
				{
					game["overtime_round"]++;
				}
			}

			setmatchtalkflag("DeadChatWithDead",level.voip.deadchatwithdead);
			setmatchtalkflag("DeadChatWithTeam",level.voip.deadchatwithteam);
			setmatchtalkflag("DeadHearTeamLiving",level.voip.deadhearteamliving);
			setmatchtalkflag("DeadHearAllLiving",level.voip.deadhearallliving);
			setmatchtalkflag("EveryoneHearsEveryone",level.voip.everyonehearseveryone);
			setmatchtalkflag("DeadHearKiller",level.voip.deadhearkiller);
			setmatchtalkflag("KillersHearVictim",level.voip.killershearvictim);
			game["state"] = "playing";
			level.allowbattlechatter = getgametypesetting("allowBattleChatter");
			map_restart(1);
			return 1;
		}
	}
}

//Function Number: 43
settopplayerstats()
{
	if(level.rankedmatch || level.wagermatch)
	{
		placement = level.placement["all"];
		topthreeplayers = min(3,placement.size);
		for(index = 0;index < topthreeplayers;index++)
		{
			if(level.placement["all"][index].score)
			{
				if(!(index))
				{
					level.placement["all"][index] addplayerstatwithgametype("TOPPLAYER",1);
					level.placement["all"][index] notify("topplayer");
				}
				else
				{
					level.placement["all"][index] notify("nottopplayer");
				}

				level.placement["all"][index] addplayerstatwithgametype("TOP3",1);
				level.placement["all"][index] addplayerstat("TOP3ANY",1);
				if(level.hardcoremode)
				{
					level.placement["all"][index] addplayerstat("TOP3ANY_HC",1);
				}

				if(level.multiteam)
				{
					level.placement["all"][index] addplayerstat("TOP3ANY_MULTITEAM",1);
				}

				level.placement["all"][index] notify("top3");
			}
		}

		for(index = 3;index < placement.size;index++)
		{
			level.placement["all"][index] notify("nottop3");
			level.placement["all"][index] notify("nottopplayer");
		}

		if(level.teambased)
		{
			foreach(team in level.teams)
			{
				settopteamstats(team);
			}
		}
	}
}

//Function Number: 44
settopteamstats(team)
{
	placementteam = level.placement[team];
	topthreeteamplayers = min(3,placementteam.size);
	if(placementteam.size < 5)
	{
		return;
	}

	for(index = 0;index < topthreeteamplayers;index++)
	{
		if(placementteam[index].score)
		{
			placementteam[index] addplayerstat("TOP3TEAM",1);
			placementteam[index] addplayerstat("TOP3ANY",1);
			if(level.hardcoremode)
			{
				placementteam[index] addplayerstat("TOP3ANY_HC",1);
			}

			if(level.multiteam)
			{
				placementteam[index] addplayerstat("TOP3ANY_MULTITEAM",1);
			}

			placementteam[index] addplayerstatwithgametype("TOP3TEAM",1);
		}
	}
}

//Function Number: 45
getgamelength()
{
	if(!level.timelimit || level.forcedend)
	{
		gamelength = maps/mp/gametypes/_globallogic_utils::gettimepassed() / 1000;
		gamelength = min(gamelength,1200);
	}
	else
	{
		gamelength = level.timelimit * 60;
	}

	return gamelength;
}

//Function Number: 46
endgame(winner,endreasontext)
{
	if(game["state"] == "postgame" || level.gameended)
	{
		return;
	}

	if(IsDefined(level.onendgame))
	{
		[[ level.onendgame ]](winner);
	}

	if(!(level.wagermatch))
	{
		setmatchflag("enable_popups",0);
	}

	if(!IsDefined(level.disableoutrovisionset) || level.disableoutrovisionset == 0)
	{
		if(sessionmodeiszombiesgame() && level.forcedend)
		{
			visionsetnaked("zombie_last_stand",2);
		}
		else
		{
			visionsetnaked("mpOutro",2);
		}
	}

	setmatchflag("cg_drawSpectatorMessages",0);
	setmatchflag("game_ended",1);
	game["state"] = "postgame";
	level.gameendtime = GetTime();
	level.gameended = 1;
	setdvar("g_gameEnded",1);
	level.ingraceperiod = 0;
	level notify("game_ended");
	level.allowbattlechatter = 0;
	maps/mp/gametypes/_globallogic_audio::flushdialog();
	foreach(team in level.teams)
	{
		game["lastroundscore"][team] = getteamscore(team);
	}

	if(!IsDefined(game["overtime_round"]) || waslastround())
	{
		game["roundsplayed"]++;
		game["roundwinner"][game["roundsplayed"]] = winner;
		if(level.teambased)
		{
			game["roundswon"][winner]++;
		}
	}

	if(IsDefined(winner) && level.teambased && IsDefined(level.teams[winner]))
	{
		level.finalkillcam_winner = winner;
	}
	else
	{
		level.finalkillcam_winner = "none";
	}

	setgameendtime(0);
	updateplacement();
	updaterankedmatch(winner);
	players = level.players;
	newtime = GetTime();
	gamelength = getgamelength();
	setmatchtalkflag("EveryoneHearsEveryone",1);
	bbgameover = 0;
	if(isoneround() || waslastround())
	{
		bbgameover = 1;
	}

	for(index = 0;index < players.size;index++)
	{
		player = players[index];
		player maps/mp/gametypes/_globallogic_player::freezeplayerforroundend();
		player thread roundenddof(4);
		player maps/mp/gametypes/_globallogic_ui::freegameplayhudelems();
		player maps/mp/gametypes/_weapons::updateweapontimings(newtime);
		player bbplayermatchend(gamelength,endreasontext,bbgameover);
		if(ispregame())
		{
		}
		else if((level.rankedmatch || level.wagermatch || level.leaguematch) && !player issplitscreen())
		{
			if(level.leaguematch)
			{
				player setdstat("AfterActionReportStats","lobbyPopup","leaguesummary");
			}
			else if(IsDefined(player.setpromotion))
			{
				player setdstat("AfterActionReportStats","lobbyPopup","promotion");
			}
			else
			{
				player setdstat("AfterActionReportStats","lobbyPopup","summary");
			}
		}
	}

	maps/mp/_music::setmusicstate("SILENT");
	if(!(level.infinalkillcam))
	{
	}

	maps/mp/_gamerep::gamerepupdateinformationforround();
	maps/mp/gametypes/_wager::finalizewagerround();
	thread maps/mp/_challenges::roundend(winner);
	if(startnextround(winner,endreasontext))
	{
		return;
	}

	if(!isoneround() && !level.gameforfeited)
	{
		if(IsDefined(level.onroundendgame))
		{
			winner = [[ level.onroundendgame ]](winner);
		}

		endreasontext = getendreasontext();
	}

	if(!level.wagermatch && !sessionmodeiszombiesgame())
	{
		maps/mp/gametypes/_globallogic_score::updatewinlossstats(winner);
	}

	if(level.teambased)
	{
		if(winner == "tie")
		{
			recordgameresult("draw");
		}
		else
		{
			recordgameresult(winner);
		}
	}
	else if(!(IsDefined(winner)))
	{
		recordgameresult("draw");
	}
	else
	{
		recordgameresult(winner.team);
	}

	skillupdate(winner,level.teambased);
	recordleaguewinner(winner);
	settopplayerstats();
	thread maps/mp/_challenges::gameend(winner);
	if(!IsDefined(level.skipgameend) || !level.skipgameend)
	{
		if(IsDefined(level.preendgamefunction))
		{
			thread [[ level.preendgamefunction ]](level.postroundtime);
		}

		displaygameend(winner,endreasontext);
	}

	if(isoneround())
	{
		maps/mp/gametypes/_globallogic_utils::executepostroundevents();
	}

	level.intermission = 1;
	maps/mp/_gamerep::gamerepanalyzeandreport();
	if(!(ispregame()))
	{
		thread sendafteractionreport();
	}

	maps/mp/gametypes/_wager::finalizewagergame();
	setmatchtalkflag("EveryoneHearsEveryone",1);
	players = level.players;
	for(index = 0;index < players.size;index++)
	{
		player = players[index];
		recordplayerstats(player,"presentAtEnd",1);
		player closemenu();
		player closeingamemenu();
		player notify("reset_outcome",_k1595);
		player thread [[ level.spawnintermission ]]();
		player setclientuivisibilityflag("hud_visible",1);
	}

	if(IsDefined(level.endgamefunction))
	{
		level thread [[ level.endgamefunction ]]();
	}

	level notify("sfade");
	logstring("game ended");
	if(!IsDefined(level.skipgameend) || !level.skipgameend)
	{
		wait(5);
	}

	exitlevel(0);
}

//Function Number: 47
bbplayermatchend(gamelength,endreasonstring,gameover)
{
	playerrank = getplacementforplayer(self);
	totaltimeplayed = 0;
	if(IsDefined(self.timeplayed) && IsDefined(self.timeplayed["total"]))
	{
		totaltimeplayed = self.timeplayed["total"];
		if(totaltimeplayed > gamelength)
		{
			totaltimeplayed = gamelength;
		}
	}

	xuid = self getxuid();
	bbprint("mpplayermatchfacts","score %d momentum %d endreason %s sessionrank %d playtime %d xuid %s gameover %d team %s",self.pers["score"],self.pers["momentum"],endreasonstring,playerrank,totaltimeplayed,xuid,gameover,self.pers["team"]);
}

//Function Number: 48
roundendwait(defaultdelay,matchbonus)
{
	notifiesdone = 0;
	while(!(notifiesdone))
	{
		players = level.players;
		notifiesdone = 1;
		for(index = 0;index < players.size;index++)
		{
			if(!IsDefined(players[index].doingnotify) || !players[index].doingnotify)
			{
			}
			else
			{
				notifiesdone = 0;
			}
		}

		wait(0.5);
	}

	if(!(matchbonus))
	{
		wait(defaultdelay);
		level notify("round_end_done");
		return;
	}

	wait(defaultdelay / 2);
	level notify("give_match_bonus");
	wait(defaultdelay / 2);
	notifiesdone = 0;
	while(!(notifiesdone))
	{
		players = level.players;
		notifiesdone = 1;
		for(index = 0;index < players.size;index++)
		{
			if(!IsDefined(players[index].doingnotify) || !players[index].doingnotify)
			{
			}
			else
			{
				notifiesdone = 0;
			}
		}

		wait(0.5);
	}

	level notify("round_end_done");
}

//Function Number: 49
roundenddof(time)
{
	self setdepthoffield(0,128,512,4000,6,1.8);
}

//Function Number: 50
checktimelimit()
{
	if(IsDefined(level.timelimitoverride) && level.timelimitoverride)
	{
		return;
	}

	if(game["state"] != "playing")
	{
		setgameendtime(0);
		return;
	}

	if(level.timelimit <= 0)
	{
		setgameendtime(0);
		return;
	}

	if(level.inprematchperiod)
	{
		setgameendtime(0);
		return;
	}

	if(level.timerstopped)
	{
		setgameendtime(0);
		return;
	}

	if(!(IsDefined(level.starttime)))
	{
		return;
	}

	timeleft = maps/mp/gametypes/_globallogic_utils::gettimeremaining();
	setgameendtime(GetTime() + int(timeleft));
	if(timeleft > 0)
	{
		return;
	}

	[[ level.ontimelimit ]]();
}

//Function Number: 51
allteamsunderscorelimit()
{
	foreach(team in level.teams)
	{
		if(game["teamScores"][team] >= level.scorelimit)
		{
			return 0;
		}
	}

	return 1;
}

//Function Number: 52
checkscorelimit()
{
	if(game["state"] != "playing")
	{
		return 0;
	}

	if(level.scorelimit <= 0)
	{
		return 0;
	}

	if(level.teambased)
	{
		if(allteamsunderscorelimit())
		{
			return 0;
		}
	}
	else
	{
		if(!(isplayer(self)))
		{
			return 0;
		}

		if(self.pointstowin < level.scorelimit)
		{
			return 0;
		}
	}

	[[ level.onscorelimit ]]();
}

//Function Number: 53
updategametypedvars()
{
	level endon("game_ended");
	while(game["state"] == "playing")
	{
		roundlimit = clamp(getgametypesetting("roundLimit"),level.roundlimitmin,level.roundlimitmax);
		if(roundlimit != level.roundlimit)
		{
			level.roundlimit = roundlimit;
			level notify("update_roundlimit");
		}

		timelimit = [[ level.gettimelimit ]]();
		if(timelimit != level.timelimit)
		{
			level.timelimit = timelimit;
			setdvar("ui_timelimit",level.timelimit);
			level notify("update_timelimit");
		}

		thread checktimelimit();
		scorelimit = clamp(getgametypesetting("scoreLimit"),level.scorelimitmin,level.scorelimitmax);
		if(scorelimit != level.scorelimit)
		{
			level.scorelimit = scorelimit;
			setdvar("ui_scorelimit",level.scorelimit);
			level notify("update_scorelimit");
		}

		thread checkscorelimit();
		if(IsDefined(level.starttime))
		{
			if(maps/mp/gametypes/_globallogic_utils::gettimeremaining() < 3000)
			{
				wait(0.1);
				continue;
			}
		}

		wait(1);
	}
}

//Function Number: 54
removedisconnectedplayerfromplacement()
{
	offset = 0;
	numplayers = level.placement["all"].size;
	found = 0;
	for(i = 0;i < numplayers;i++)
	{
		if(level.placement["all"][i] == self)
		{
			found = 1;
		}

		if(found)
		{
			level.placement["all"][i] = level.placement["all"][i + 1];
		}
	}

	if(!(found))
	{
		return;
	}

	level.placement["all"][numplayers - 1] = undefined;
/#
	assert(level.placement["all"].size == numplayers - 1);
#/
/#
	maps/mp/gametypes/_globallogic_utils::assertproperplacement();
#/
	updateteamplacement();
	if(level.teambased)
	{
		return;
	}

	numplayers = level.placement["all"].size;
	for(i = 0;i < numplayers;i++)
	{
		player = level.placement["all"][i];
		player notify("update_outcome");
	}
}

//Function Number: 55
updateplacement()
{
	if(!(level.players.size))
	{
		return;
	}

	level.placement["all"] = [];
	for(index = 0;index < level.players.size;index++)
	{
		if(IsDefined(level.teams[level.players[index].team]))
		{
			level.placement["all"][level.placement["all"].size] = level.players[index];
		}
	}

	placementall = level.placement["all"];
	if(level.teambased)
	{
		for(i = 1;i < placementall.size;i++)
		{
			player = placementall[i];
			playerscore = player.score;
			for(j = i - 1;j >= 0 && playerscore > placementall[j].score || playerscore == placementall[j].score && player.deaths < placementall[j].deaths;j--)
			{
				placementall[j + 1] = placementall[j];
			}

			placementall[j + 1] = player;
		}
	}
	else
	{
		for(i = 1;i < placementall.size;i++)
		{
			player = placementall[i];
			playerscore = player.pointstowin;
			for(j = i - 1;j >= 0 && playerscore > placementall[j].pointstowin || playerscore == placementall[j].pointstowin && player.deaths < placementall[j].deaths;j--)
			{
				placementall[j + 1] = placementall[j];
			}

			placementall[j + 1] = player;
		}
	}

	level.placement["all"] = placementall;
/#
	maps/mp/gametypes/_globallogic_utils::assertproperplacement();
#/
	updateteamplacement();
}

//Function Number: 56
updateteamplacement()
{
	foreach(team in level.teams)
	{
		placement[team] = [];
	}

	placement["spectator"] = [];
	if(!(level.teambased))
	{
		return;
	}

	placementall = level.placement["all"];
	placementallsize = placementall.size;
	for(i = 0;i < placementallsize;i++)
	{
		player = placementall[i];
		team = player.pers["team"];
		placement[team][placement[team].size] = player;
	}

	foreach(team in level.teams)
	{
		level.placement[team] = placement[team];
	}
}

//Function Number: 57
getplacementforplayer(player)
{
	updateplacement();
	playerrank = -1;
	placement = level.placement["all"];
	for(placementindex = 0;placementindex < placement.size;placementindex++)
	{
		if(level.placement["all"][placementindex] == player)
		{
			playerrank = placementindex + 1;
			break;
		}
	}

	return playerrank;
}

//Function Number: 58
istopscoringplayer(player)
{
	topplayer = 0;
	updateplacement();
/#
	assert(level.placement["all"].size > 0);
#/
	if(level.placement["all"].size == 0)
	{
		return 0;
	}

	if(level.teambased)
	{
		topscore = level.placement["all"][0].score;
		for(index = 0;index < level.placement["all"].size;index++)
		{
			if(level.placement["all"][index].score == 0)
			{
				break;
			}

			if(topscore > level.placement["all"][index].score)
			{
				break;
			}

			if(self == level.placement["all"][index])
			{
				topscoringplayer = 1;
				break;
			}
		}
	}
	else
	{
		topscore = level.placement["all"][0].pointstowin;
		for(index = 0;index < level.placement["all"].size;index++)
		{
			if(level.placement["all"][index].pointstowin == 0)
			{
				break;
			}

			if(topscore > level.placement["all"][index].pointstowin)
			{
				break;
			}

			if(self == level.placement["all"][index])
			{
				topplayer = 1;
				break;
			}
		}
	}

	return topplayer;
}

//Function Number: 59
sortdeadplayers(team)
{
	if(!(level.playerqueuedrespawn))
	{
		return;
	}

	for(i = 1;i < level.deadplayers[team].size;i++)
	{
		player = level.deadplayers[team][i];
		for(j = i - 1;j >= 0 && player.deathtime < level.deadplayers[team][j].deathtime;j--)
		{
			level.deadplayers[team][j + 1] = level.deadplayers[team][j];
		}

		level.deadplayers[team][j + 1] = player;
	}

	for(i = 0;i < level.deadplayers[team].size;i++)
	{
		if(level.deadplayers[team][i].spawnqueueindex != i)
		{
			level.spawnqueuemodified[team] = 1;
		}

		level.deadplayers[team][i].spawnqueueindex = i;
	}
}

//Function Number: 60
totalalivecount()
{
	count = 0;
	foreach(team in level.teams)
	{
		count = count + level.alivecount[team];
	}

	return count;
}

//Function Number: 61
totalplayerlives()
{
	count = 0;
	foreach(team in level.teams)
	{
		count = count + level.playerlives[team];
	}

	return count;
}

//Function Number: 62
totalplayercount()
{
	count = 0;
	foreach(team in level.teams)
	{
		count = count + level.playercount[team];
	}

	return count;
}

//Function Number: 63
initteamvariables(team)
{
	if(!(IsDefined(level.alivecount)))
	{
		level.alivecount = [];
	}

	level.alivecount[team] = 0;
	level.lastalivecount[team] = 0;
	if(!(IsDefined(game["everExisted"])))
	{
		game["everExisted"] = [];
	}

	if(!(IsDefined(game["everExisted"][team])))
	{
		game["everExisted"][team] = 0;
	}

	level.everexisted[team] = 0;
	level.wavedelay[team] = 0;
	level.lastwave[team] = 0;
	level.waveplayerspawnindex[team] = 0;
	resetteamvariables(team);
}

//Function Number: 64
resetteamvariables(team)
{
	level.playercount[team] = 0;
	level.botscount[team] = 0;
	level.lastalivecount[team] = level.alivecount[team];
	level.alivecount[team] = 0;
	level.playerlives[team] = 0;
	level.aliveplayers[team] = [];
	level.deadplayers[team] = [];
	level.squads[team] = [];
	level.spawnqueuemodified[team] = 0;
}

//Function Number: 65
updateteamstatus()
{
	level notify("updating_team_status");
	level endon("updating_team_status");
	level endon("game_ended");
	waittillframeend;
	wait(0);
	if(game["state"] == "postgame")
	{
		return;
	}

	resettimeout();
	foreach(team in level.teams)
	{
		resetteamvariables(team);
	}

	level.activeplayers = [];
	players = level.players;
	for(i = 0;i < players.size;i++)
	{
		player = players[i];
		if(!IsDefined(player) && level.splitscreen)
		{
		}
		else
		{
			team = player.team;
			class = player.class;
			if(team != "spectator" && IsDefined(class) && class != "")
			{
				level.playercount[team]++;
				if(IsDefined(player.pers["isBot"]))
				{
					level.botscount[team]++;
				}

				if(player.sessionstate == "playing")
				{
					level.alivecount[team]++;
					level.playerlives[team]++;
					player.spawnqueueindex = -1;
					if(isalive(player))
					{
						level.aliveplayers[team][level.aliveplayers[team].size] = player;
						level.activeplayers[level.activeplayers.size] = player;
						continue;
					}

					level.deadplayers[team][level.deadplayers[team].size] = player;
				}
				else
				{
					level.deadplayers[team][level.deadplayers[team].size] = player;
					if(player maps/mp/gametypes/_globallogic_spawn::mayspawn())
					{
						level.playerlives[team]++;
					}
				}
			}
		}
	}

	totalalive = totalalivecount();
	if(totalalive > level.maxplayercount)
	{
		level.maxplayercount = totalalive;
	}

	foreach(team in level.teams)
	{
		if(level.alivecount[team])
		{
			game["everExisted"][team] = 1;
			level.everexisted[team] = 1;
		}

		sortdeadplayers(team);
	}

	level updategameevents();
}

//Function Number: 66
checkteamscorelimitsoon(team)
{
/#
	assert(IsDefined(team));
#/
	if(level.scorelimit <= 0)
	{
		return;
	}

	if(!(level.teambased))
	{
		return;
	}

	if(maps/mp/gametypes/_globallogic_utils::gettimepassed() < 60000)
	{
		return;
	}

	timeleft = maps/mp/gametypes/_globallogic_utils::getestimatedtimeuntilscorelimit(team);
	if(timeleft < 1)
	{
		level notify("match_ending_soon","score");
	}
}

//Function Number: 67
checkplayerscorelimitsoon()
{
/#
	assert(isplayer(self));
#/
	if(level.scorelimit <= 0)
	{
		return;
	}

	if(level.teambased)
	{
		return;
	}

	if(maps/mp/gametypes/_globallogic_utils::gettimepassed() < 60000)
	{
		return;
	}

	timeleft = maps/mp/gametypes/_globallogic_utils::getestimatedtimeuntilscorelimit(undefined);
	if(timeleft < 1)
	{
		level notify("match_ending_soon","score");
	}
}

//Function Number: 68
timelimitclock()
{
	level endon("game_ended");
	wait(0.05);
	clockobject = spawn("script_origin",(0,0,0));
	while(game["state"] == "playing")
	{
		if(!level.timerstopped && level.timelimit)
		{
			timeleft = maps/mp/gametypes/_globallogic_utils::gettimeremaining() / 1000;
			timeleftint = int(timeleft + 0.5);
			if(timeleftint == 601)
			{
				clientnotify("notify_10");
			}

			if(timeleftint == 301)
			{
				clientnotify("notify_5");
			}

			if(timeleftint == 60)
			{
				clientnotify("notify_1");
			}

			if(timeleftint == 12)
			{
				clientnotify("notify_count");
			}

			if(timeleftint >= 40 && timeleftint <= 60)
			{
				level notify("match_ending_soon","time");
			}

			if(timeleftint >= 30 && timeleftint <= 40)
			{
				level notify("match_ending_pretty_soon","time");
			}

			if(timeleftint <= 32)
			{
				level notify("match_ending_vox");
			}

			if(timeleftint <= 10 || timeleftint <= 30 && timeleftint % 2 == 0)
			{
				level notify("match_ending_very_soon","time");
				if(timeleftint == 0)
				{
					break;
				}

				clockobject playsound("mpl_ui_timer_countdown");
			}

			if(timeleft - floor(timeleft) >= 0.05)
			{
				wait(timeleft - floor(timeleft));
			}
		}

		wait(1);
	}
}

//Function Number: 69
timelimitclock_intermission(waittime)
{
	setgameendtime(GetTime() + int(waittime * 1000));
	clockobject = spawn("script_origin",(0,0,0));
	if(waittime >= 10)
	{
		wait(waittime - 10);
	}

	for(;;)
	{
		clockobject playsound("mpl_ui_timer_countdown");
		wait(1);
	}
}

//Function Number: 70
startgame()
{
	thread maps/mp/gametypes/_globallogic_utils::gametimer();
	level.timerstopped = 0;
	setmatchtalkflag("DeadChatWithDead",level.voip.deadchatwithdead);
	setmatchtalkflag("DeadChatWithTeam",level.voip.deadchatwithteam);
	setmatchtalkflag("DeadHearTeamLiving",level.voip.deadhearteamliving);
	setmatchtalkflag("DeadHearAllLiving",level.voip.deadhearallliving);
	setmatchtalkflag("EveryoneHearsEveryone",level.voip.everyonehearseveryone);
	setmatchtalkflag("DeadHearKiller",level.voip.deadhearkiller);
	setmatchtalkflag("KillersHearVictim",level.voip.killershearvictim);
	prematchperiod();
	level notify("prematch_over");
	thread timelimitclock();
	thread graceperiod();
	thread watchmatchendingsoon();
	thread maps/mp/gametypes/_globallogic_audio::musiccontroller();
	recordmatchbegin();
}

//Function Number: 71
waitforplayers()
{
	starttime = GetTime();
	while(getnumconnectedplayers() < 1)
	{
		wait(0.05);
		if(GetTime() - starttime > 120000)
		{
			exitlevel(0);
		}
	}
}

//Function Number: 72
prematchperiod()
{
	setmatchflag("hud_hardcore",level.hardcoremode);
	level endon("game_ended");
	if(level.prematchperiod > 0)
	{
		thread matchstarttimer();
		waitforplayers();
		wait(level.prematchperiod);
	}
	else
	{
		matchstarttimerskip();
		wait(0.05);
	}

	level.inprematchperiod = 0;
	for(index = 0;index < level.players.size;index++)
	{
		level.players[index] freeze_player_controls(0);
		level.players[index] enableweapons();
	}

	maps/mp/gametypes/_wager::prematchperiod();
	if(game["state"] != "playing")
	{
	}

//Function Number: 73
graceperiod()
{
	level endon("game_ended");
	if(IsDefined(level.graceperiodfunc))
	{
		[[ level.graceperiodfunc ]]();
	}
	else
	{
		wait(level.graceperiod);
	}

	level notify("grace_period_ending");
	wait(0.05);
	level.ingraceperiod = 0;
	if(game["state"] != "playing")
	{
		return;
	}

	if(level.numlives)
	{
		players = level.players;
		for(i = 0;i < players.size;i++)
		{
			player = players[i];
			if(!player.hasspawned && player.sessionteam != "spectator" && !isalive(player))
			{
				player.statusicon = "hud_status_dead";
			}
		}
	}

	level thread updateteamstatus();
}

//Function Number: 74
watchmatchendingsoon()
{
	setdvar("xblive_matchEndingSoon",0);
	level waittill("match_ending_soon",reason);
	setdvar("xblive_matchEndingSoon",1);
}

//Function Number: 75
assertteamvariables()
{
	if(!level.createfx_enabled && !sessionmodeiszombiesgame())
	{
		foreach(team in level.teams)
		{
/#
			assert(IsDefined(game["strings"][team + "_win"]));
#/
/#
			assert(IsDefined(game["strings"][team + "_win_round"]));
#/
/#
			assert(IsDefined(game["strings"][team + "_mission_accomplished"]));
#/
/#
			assert(IsDefined(game["strings"][team + "_eliminated"]));
#/
/#
			assert(IsDefined(game["strings"][team + "_forfeited"]));
#/
/#
			assert(IsDefined(game["strings"][team + "_name"]));
#/
/#
			assert(IsDefined(game["music"]["spawn_" + team]));
#/
/#
			assert(IsDefined(game["music"]["victory_" + team]));
#/
/#
			assert(IsDefined(game["icons"][team]));
#/
/#
			assert(IsDefined(game["voice"][team]));
#/
		}
	}
}

//Function Number: 76
anyteamhaswavedelay()
{
	foreach(team in level.teams)
	{
		if(level.wavedelay[team])
		{
			return 1;
		}
	}

	return 0;
}

//Function Number: 77
callback_startgametype()
{
	level.prematchperiod = 0;
	level.intermission = 0;
	setmatchflag("cg_drawSpectatorMessages",1);
	setmatchflag("game_ended",0);
	if(!(IsDefined(game["gamestarted"])))
	{
		if(!(IsDefined(game["allies"])))
		{
			game["allies"] = "seals";
		}

		if(!(IsDefined(game["axis"])))
		{
			game["axis"] = "pmc";
		}

		if(!(IsDefined(game["attackers"])))
		{
			game["attackers"] = "allies";
		}

		if(!(IsDefined(game["defenders"])))
		{
			game["defenders"] = "axis";
		}

/#
		assert(game["attackers"] != game["defenders"]);
#/
		foreach(team in level.teams)
		{
			if(!(IsDefined(game[team])))
			{
				game[team] = "pmc";
			}
		}

		if(!(IsDefined(game["state"])))
		{
			game["state"] = "playing";
		}

		precacherumble("damage_heavy");
		precacherumble("damage_light");
		precacheshader("white");
		precacheshader("black");
		makedvarserverinfo("scr_allies","marines");
		makedvarserverinfo("scr_axis","nva");
		makedvarserverinfo("cg_thirdPersonAngle",354);
		setdvar("cg_thirdPersonAngle",354);
		game["strings"]["press_to_spawn"] = &"PLATFORM_PRESS_TO_SPAWN";
		if(level.teambased)
		{
			game["strings"]["waiting_for_teams"] = &"MP_WAITING_FOR_TEAMS";
			game["strings"]["opponent_forfeiting_in"] = &"MP_OPPONENT_FORFEITING_IN";
		}
		else
		{
			game["strings"]["waiting_for_teams"] = &"MP_WAITING_FOR_PLAYERS";
			game["strings"]["opponent_forfeiting_in"] = &"MP_OPPONENT_FORFEITING_IN";
		}

		game["strings"]["match_starting_in"] = &"MP_MATCH_STARTING_IN";
		game["strings"]["spawn_next_round"] = &"MP_SPAWN_NEXT_ROUND";
		game["strings"]["waiting_to_spawn"] = &"MP_WAITING_TO_SPAWN";
		game["strings"]["waiting_to_spawn_ss"] = &"MP_WAITING_TO_SPAWN_SS";
		game["strings"]["you_will_spawn"] = &"MP_YOU_WILL_RESPAWN";
		game["strings"]["match_starting"] = &"MP_MATCH_STARTING";
		game["strings"]["change_class"] = &"MP_CHANGE_CLASS_NEXT_SPAWN";
		game["strings"]["last_stand"] = &"MPUI_LAST_STAND";
		game["strings"]["cowards_way"] = &"PLATFORM_COWARDS_WAY_OUT";
		game["strings"]["tie"] = &"MP_MATCH_TIE";
		game["strings"]["round_draw"] = &"MP_ROUND_DRAW";
		game["strings"]["enemies_eliminated"] = &"MP_ENEMIES_ELIMINATED";
		game["strings"]["score_limit_reached"] = &"MP_SCORE_LIMIT_REACHED";
		game["strings"]["round_limit_reached"] = &"MP_ROUND_LIMIT_REACHED";
		game["strings"]["time_limit_reached"] = &"MP_TIME_LIMIT_REACHED";
		game["strings"]["players_forfeited"] = &"MP_PLAYERS_FORFEITED";
		game["strings"]["other_teams_forfeited"] = &"MP_OTHER_TEAMS_FORFEITED";
		assertteamvariables();
		[[ level.onprecachegametype ]]();
		game["gamestarted"] = 1;
		game["totalKills"] = 0;
		foreach(team in level.teams)
		{
			game["teamScores"][team] = 0;
			game["totalKillsTeam"][team] = 0;
		}

		if(!(ispregame()))
		{
			level.prematchperiod = getgametypesetting("prematchperiod");
		}

		if(GetDvarInt(#"1E0679B9") != 0)
		{
			foreach(team in level.teams)
			{
				game["icons"][team] = "composite_emblem_team_axis";
			}

			game["icons"]["allies"] = "composite_emblem_team_allies";
			game["icons"]["axis"] = "composite_emblem_team_axis";
		}
	}
	else if(!(level.splitscreen))
	{
		level.prematchperiod = getgametypesetting("preroundperiod");
	}

	if(!(IsDefined(game["timepassed"])))
	{
		game["timepassed"] = 0;
	}

	if(!(IsDefined(game["roundsplayed"])))
	{
		game["roundsplayed"] = 0;
	}

	setroundsplayed(game["roundsplayed"]);
	if(IsDefined(game["overtime_round"]))
	{
		setmatchflag("overtime",1);
	}
	else
	{
		setmatchflag("overtime",0);
	}

	if(!(IsDefined(game["roundwinner"])))
	{
		game["roundwinner"] = [];
	}

	if(!(IsDefined(game["lastroundscore"])))
	{
		game["lastroundscore"] = [];
	}

	if(!(IsDefined(game["roundswon"])))
	{
		game["roundswon"] = [];
	}

	if(!(IsDefined(game["roundswon"]["tie"])))
	{
		game["roundswon"]["tie"] = 0;
	}

	foreach(team in level.teams)
	{
		if(!(IsDefined(game["roundswon"][team])))
		{
			game["roundswon"][team] = 0;
		}

		level.teamspawnpoints[team] = [];
		level.spawn_point_team_class_names[team] = [];
	}

	level.skipvote = 0;
	level.gameended = 0;
	setdvar("g_gameEnded",0);
	level.objidstart = 0;
	level.forcedend = 0;
	level.hostforcedend = 0;
	level.hardcoremode = getgametypesetting("hardcoreMode");
	if(level.hardcoremode)
	{
		logstring("game mode: hardcore");
		if(!(IsDefined(level.friendlyfiredelaytime)))
		{
			level.friendlyfiredelaytime = 0;
		}
	}

	if(GetDvar(#"D16D59FD") == "")
	{
		setdvar("scr_max_rank","0");
	}

	level.rankcap = GetDvarInt(#"D16D59FD");
	if(GetDvar(#"4EBE2CF2") == "")
	{
		setdvar("scr_min_prestige","0");
	}

	level.minprestige = GetDvarInt(#"4EBE2CF2");
	level.usestartspawns = 1;
	level.roundscorecarry = getgametypesetting("roundscorecarry");
	level.allowhitmarkers = getgametypesetting("allowhitmarkers");
	level.playerqueuedrespawn = getgametypesetting("playerQueuedRespawn");
	level.playerforcerespawn = getgametypesetting("playerForceRespawn");
	level.roundstartexplosivedelay = getgametypesetting("roundStartExplosiveDelay");
	level.roundstartkillstreakdelay = getgametypesetting("roundStartKillstreakDelay");
	level.perksenabled = getgametypesetting("perksEnabled");
	level.disableattachments = getgametypesetting("disableAttachments");
	level.disabletacinsert = getgametypesetting("disableTacInsert");
	level.disablecac = getgametypesetting("disableCAC");
	level.disableclassselection = getgametypesetting("disableClassSelection");
	level.disableweapondrop = getgametypesetting("disableweapondrop");
	level.onlyheadshots = getgametypesetting("onlyHeadshots");
	level.minimumallowedteamkills = getgametypesetting("teamKillPunishCount") - 1;
	level.teamkillreducedpenalty = getgametypesetting("teamKillReducedPenalty");
	level.teamkillpointloss = getgametypesetting("teamKillPointLoss");
	level.teamkillspawndelay = getgametypesetting("teamKillSpawnDelay");
	level.deathpointloss = getgametypesetting("deathPointLoss");
	level.leaderbonus = getgametypesetting("leaderBonus");
	level.forceradar = getgametypesetting("forceRadar");
	level.playersprinttime = getgametypesetting("playerSprintTime");
	level.bulletdamagescalar = getgametypesetting("bulletDamageScalar");
	level.playermaxhealth = getgametypesetting("playerMaxHealth");
	level.playerhealthregentime = getgametypesetting("playerHealthRegenTime");
	level.playerrespawndelay = getgametypesetting("playerRespawnDelay");
	level.playerobjectiveheldrespawndelay = getgametypesetting("playerObjectiveHeldRespawnDelay");
	level.waverespawndelay = getgametypesetting("waveRespawnDelay");
	level.suicidespawndelay = getgametypesetting("spawnsuicidepenalty");
	level.teamkilledspawndelay = getgametypesetting("spawnteamkilledpenalty");
	level.maxsuicidesbeforekick = getgametypesetting("maxsuicidesbeforekick");
	level.spectatetype = getgametypesetting("spectateType");
	level.voip = spawnstruct();
	level.voip.deadchatwithdead = getgametypesetting("voipDeadChatWithDead");
	level.voip.deadchatwithteam = getgametypesetting("voipDeadChatWithTeam");
	level.voip.deadhearallliving = getgametypesetting("voipDeadHearAllLiving");
	level.voip.deadhearteamliving = getgametypesetting("voipDeadHearTeamLiving");
	level.voip.everyonehearseveryone = getgametypesetting("voipEveryoneHearsEveryone");
	level.voip.deadhearkiller = getgametypesetting("voipDeadHearKiller");
	level.voip.killershearvictim = getgametypesetting("voipKillersHearVictim");
	if(GetDvar(#"F7B30924") == "1")
	{
		level waittill(_k2655,_k2718,_k2730,_k2773,"eternity");
	}

	if(sessionmodeiszombiesgame())
	{
		level.prematchperiod = 0;
		level.persistentdatainfo = [];
		level.maxrecentstats = 10;
		level.maxhitlocations = 19;
		level.globalshotsfired = 0;
		thread maps/mp/gametypes/_hud::init();
		thread maps/mp/gametypes/_serversettings::init();
		thread maps/mp/gametypes/_clientids::init();
		thread maps/mp/gametypes/_weaponobjects::init();
		thread maps/mp/gametypes/_scoreboard::init();
		thread maps/mp/gametypes/_killcam::init();
		thread maps/mp/gametypes/_shellshock::init();
		thread maps/mp/gametypes/_deathicons::init();
		thread maps/mp/gametypes/_spectating::init();
		thread maps/mp/gametypes/_objpoints::init();
		thread maps/mp/gametypes/_gameobjects::init();
		thread maps/mp/gametypes/_spawnlogic::init();
		thread maps/mp/gametypes/_globallogic_audio::init();
		thread maps/mp/gametypes/_wager::init();
		thread maps/mp/bots/_bot::init();
		thread maps/mp/_decoy::init();
	}
	else
	{
		thread maps/mp/gametypes/_persistence::init();
		thread maps/mp/gametypes/_menus::init();
		thread maps/mp/gametypes/_hud::init();
		thread maps/mp/gametypes/_serversettings::init();
		thread maps/mp/gametypes/_clientids::init();
		thread maps/mp/teams/_teams::init();
		thread maps/mp/gametypes/_weapons::init();
		thread maps/mp/gametypes/_scoreboard::init();
		thread maps/mp/gametypes/_killcam::init();
		thread maps/mp/gametypes/_shellshock::init();
		thread maps/mp/gametypes/_deathicons::init();
		thread maps/mp/gametypes/_damagefeedback::init();
		thread maps/mp/gametypes/_healthoverlay::init();
		thread maps/mp/gametypes/_spectating::init();
		thread maps/mp/gametypes/_objpoints::init();
		thread maps/mp/gametypes/_gameobjects::init();
		thread maps/mp/gametypes/_spawnlogic::init();
		thread maps/mp/gametypes/_battlechatter_mp::init();
		thread maps/mp/killstreaks/_killstreaks::init();
		thread maps/mp/gametypes/_globallogic_audio::init();
		thread maps/mp/gametypes/_wager::init();
		thread maps/mp/bots/_bot::init();
		thread maps/mp/_decoy::init();
		thread maps/mp/_bb::init();
	}

	if(level.teambased)
	{
		thread maps/mp/gametypes/_friendicons::init();
	}

	thread maps/mp/gametypes/_hud_message::init();
	thread maps/mp/_multi_extracam::init();
	stringnames = getarraykeys(game["strings"]);
	for(index = 0;index < stringnames.size;index++)
	{
		precachestring(game["strings"][stringnames[index]]);
	}

	foreach(team in level.teams)
	{
		initteamvariables(team);
	}

	level.maxplayercount = 0;
	level.activeplayers = [];
	level.allowannouncer = getgametypesetting("allowAnnouncer");
	if(!(IsDefined(level.timelimit)))
	{
		registertimelimit(1,1440);
	}

	if(!(IsDefined(level.scorelimit)))
	{
		registerscorelimit(1,500);
	}

	if(!(IsDefined(level.roundlimit)))
	{
		registerroundlimit(0,10);
	}

	if(!(IsDefined(level.roundwinlimit)))
	{
		registerroundwinlimit(0,10);
	}

	maps/mp/gametypes/_globallogic_utils::registerpostroundevent(maps/mp/gametypes/_killcam::postroundfinalkillcam);
	maps/mp/gametypes/_globallogic_utils::registerpostroundevent(maps/mp/gametypes/_wager::postroundsidebet);
	makedvarserverinfo("ui_scorelimit");
	makedvarserverinfo("ui_timelimit");
	makedvarserverinfo("ui_allow_classchange",GetDvar(#"53E50C7C"));
	wavedelay = level.waverespawndelay;
	if(wavedelay && !ispregame())
	{
		foreach(team in level.teams)
		{
			level.wavedelay[team] = wavedelay;
			level.lastwave[team] = 0;
		}

		level thread [[ level.wavespawntimer ]]();
	}

	level.inprematchperiod = 1;
	if(level.prematchperiod > 2)
	{
		level.prematchperiod = level.prematchperiod + randomfloat(4) - 2;
	}

	if(level.numlives || anyteamhaswavedelay() || level.playerqueuedrespawn)
	{
		level.graceperiod = 15;
	}
	else
	{
		level.graceperiod = 5;
	}

	level.ingraceperiod = 1;
	level.roundenddelay = 5;
	level.halftimeroundenddelay = 3;
	maps/mp/gametypes/_globallogic_score::updateallteamscores();
	level.killstreaksenabled = 1;
	if(GetDvar(#"DFD7387C") == "")
	{
		setdvar("scr_game_rankenabled",1);
	}

	level.rankenabled = GetDvarInt(#"DFD7387C");
	if(GetDvar(#"273F6466") == "")
	{
		setdvar("scr_game_medalsenabled",1);
	}

	level.medalsenabled = GetDvarInt(#"273F6466");
	if(level.hardcoremode && level.rankedmatch && GetDvar(#"9C756AF7") == "")
	{
		setdvar("scr_game_friendlyFireDelay",1);
	}

	level.friendlyfiredelay = GetDvarInt(#"9C756AF7");
	if(GetDvar(#"134D5297") == "")
	{
		[[ level.onstartgametype ]]();
	}

	if(GetDvarInt(#"826EB3B9") == 1)
	{
		level.killstreaksenabled = 0;
	}

/#
	thread maps/mp/gametypes/_dev::init();
#/
/#
	println("Globallogic Callback_StartGametype() isPregame() = " + ispregame() + "\n");
#/
	level thread maps/mp/gametypes/_killcam::dofinalkillcam();
	thread startgame();
	level thread updategametypedvars();
/#
	level.skipgameend = 1;
	level.roundlimit = 1;
	wait(1);
	thread forceend(0);
	thread forcedebughostmigration();
GetDvarInt(#"1F8C9394") == 1
GetDvarInt(#"7AEF62D7") == 1
#/
}

//Function Number: 78
forcedebughostmigration()
{
/#
	for(;;)
	{
		maps/mp/gametypes/_hostmigration::waittillhostmigrationdone();
		wait(60);
		starthostmigration();
		maps/mp/gametypes/_hostmigration::waittillhostmigrationdone();
	}
1
#/
}

//Function Number: 79
registerfriendlyfiredelay(dvarstring,defaultvalue,minvalue,maxvalue)
{
	dvarstring = "scr_" + dvarstring + "_friendlyFireDelayTime";
	if(GetDvar(dvarstring) == "")
	{
		setdvar(dvarstring,defaultvalue);
	}

	if(GetDvarInt(dvarstring) > maxvalue)
	{
		setdvar(dvarstring,maxvalue);
	}
	else if(GetDvarInt(dvarstring) < minvalue)
	{
		setdvar(dvarstring,minvalue);
	}

	level.friendlyfiredelaytime = GetDvarInt(dvarstring);
}

//Function Number: 80
checkroundswitch()
{
	if(!IsDefined(level.roundswitch) || !level.roundswitch)
	{
		return 0;
	}

	if(!(IsDefined(level.onroundswitch)))
	{
		return 0;
	}

/#
	assert(game["roundsplayed"] > 0);
#/
	if(game["roundsplayed"] % level.roundswitch == 0)
	{
		[[ level.onroundswitch ]]();
		return 1;
	}
}

//Function Number: 81
listenforgameend()
{
	self waittill("host_sucks_end_game");
	level.skipvote = 1;
	if(!(level.gameended))
	{
		level thread maps/mp/gametypes/_globallogic::forceend(1);
	}
}

//Function Number: 82
getkillstreaks(player)
{
	for(killstreaknum = 0;killstreaknum < level.maxkillstreaks;killstreaknum++)
	{
		killstreak[killstreaknum] = "killstreak_null";
	}

	if(isplayer(player) && !level.oldschool && level.disableclassselection != 1 && !IsDefined(player.pers["isBot"]) && IsDefined(player.killstreak))
	{
		currentkillstreak = 0;
		for(killstreaknum = 0;killstreaknum < level.maxkillstreaks;killstreaknum++)
		{
			if(IsDefined(player.killstreak[killstreaknum]))
			{
				killstreak[currentkillstreak] = player.killstreak[killstreaknum];
				currentkillstreak++;
			}
		}
	}

	return killstreak;
}

//Function Number: 83
updaterankedmatch(winner)
{
	if(level.rankedmatch)
	{
		if(hostidledout())
		{
			level.hostforcedend = 1;
			logstring("host idled out");
			endlobby();
		}
	}

	if(!level.wagermatch && !sessionmodeiszombiesgame())
	{
		maps/mp/gametypes/_globallogic_score::updatematchbonusscores(winner);
	}
}