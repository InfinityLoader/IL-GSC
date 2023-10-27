/*******************************************************************
 * Decompiled By: Bog
 * Decompiled File: maps\mp\gametypes\dom.gsc
 * Game: Call of Duty: Black Ops 2
 * Platform: Console
 * Function Count: 47
 * Decompile Time: 276 ms
 * Timestamp: 10/27/2023 3:04:34 AM
*******************************************************************/

#include common_scripts/utility;
#include maps/mp/_challenges;
#include maps/mp/_demo;
#include maps/mp/_popups;
#include maps/mp/_scoreevents;
#include maps/mp/_utility;
#include maps/mp/gametypes/_callbacksetup;
#include maps/mp/gametypes/_gameobjects;
#include maps/mp/gametypes/_globallogic;
#include maps/mp/gametypes/_globallogic_audio;
#include maps/mp/gametypes/_globallogic_score;
#include maps/mp/gametypes/_globallogic_utils;
#include maps/mp/gametypes/_hostmigration;
#include maps/mp/gametypes/_hud_util;
#include maps/mp/gametypes/_spawning;
#include maps/mp/gametypes/_spawnlogic;
#include maps/mp/teams/_teams;

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
	registertimelimit(0,1440);
	registerscorelimit(0,1000);
	registerroundlimit(0,10);
	registerroundwinlimit(0,10);
	registerroundswitch(0,9);
	registernumlives(0,100);
	maps/mp/gametypes/_globallogic::registerfriendlyfiredelay(level.gametype,15,0,1440);
	level.scoreroundbased = getgametypesetting("roundscorecarry") == 0;
	level.teambased = 1;
	level.overrideteamscore = 1;
	level.onstartgametype = ::onstartgametype;
	level.onspawnplayer = ::onspawnplayer;
	level.onspawnplayerunified = ::onspawnplayerunified;
	level.onplayerkilled = ::onplayerkilled;
	level.onroundswitch = ::onroundswitch;
	level.onprecachegametype = ::onprecachegametype;
	level.onendgame = ::onendgame;
	level.gamemodespawndvars = ::dom_gamemodespawndvars;
	level.onroundendgame = ::onroundendgame;
	game["dialog"]["gametype"] = "dom_start";
	game["dialog"]["gametype_hardcore"] = "hcdom_start";
	game["dialog"]["offense_obj"] = "cap_start";
	game["dialog"]["defense_obj"] = "cap_start";
	level.lastdialogtime = 0;
	if(!sessionmodeissystemlink() && !sessionmodeisonlinegame() && issplitscreen())
	{
		setscoreboardcolumns("score","kills","captures","defends","deaths");
	}
	else
	{
		setscoreboardcolumns("score","kills","deaths","captures","defends");
	}

	maps/mp/gametypes/_globallogic_audio::registerdialoggroup("gamemode_objective",0);
	maps/mp/gametypes/_globallogic_audio::registerdialoggroup("gamemode_objective_a",0);
	maps/mp/gametypes/_globallogic_audio::registerdialoggroup("gamemode_objective_b",0);
	maps/mp/gametypes/_globallogic_audio::registerdialoggroup("gamemode_objective_c",0);
	maps/mp/gametypes/_globallogic_audio::registerdialoggroup("gamemode_changing_a",0);
	maps/mp/gametypes/_globallogic_audio::registerdialoggroup("gamemode_changing_b",0);
	maps/mp/gametypes/_globallogic_audio::registerdialoggroup("gamemode_changing_c",0);
}

//Function Number: 2
onprecachegametype()
{
}

//Function Number: 3
onstartgametype()
{
	setobjectivetext("allies",&"OBJECTIVES_DOM");
	setobjectivetext("axis",&"OBJECTIVES_DOM");
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

	if(level.splitscreen)
	{
		setobjectivescoretext("allies",&"OBJECTIVES_DOM");
		setobjectivescoretext("axis",&"OBJECTIVES_DOM");
	}
	else
	{
		setobjectivescoretext("allies",&"OBJECTIVES_DOM_SCORE");
		setobjectivescoretext("axis",&"OBJECTIVES_DOM_SCORE");
	}

	setobjectivehinttext("allies",&"OBJECTIVES_DOM_HINT");
	setobjectivehinttext("axis",&"OBJECTIVES_DOM_HINT");
	level.flagbasefxid = [];
	level.flagbasefxid["allies"] = loadfx("misc/fx_ui_flagbase_" + game["allies"]);
	level.flagbasefxid["axis"] = loadfx("misc/fx_ui_flagbase_" + game["axis"]);
	setclientnamemode("auto_change");
	allowed[0] = "dom";
	maps/mp/gametypes/_gameobjects::main(allowed);
	maps/mp/gametypes/_spawning::create_map_placed_influencers();
	level.spawnmins = (0,0,0);
	level.spawnmaxs = (0,0,0);
	maps/mp/gametypes/_spawnlogic::placespawnpoints("mp_dom_spawn_allies_start");
	maps/mp/gametypes/_spawnlogic::placespawnpoints("mp_dom_spawn_axis_start");
	level.mapcenter = maps/mp/gametypes/_spawnlogic::findboxcenter(level.spawnmins,level.spawnmaxs);
	setmapcenter(level.mapcenter);
	spawnpoint = maps/mp/gametypes/_spawnlogic::getrandomintermissionpoint();
	setdemointermissionpoint(spawnpoint.origin,spawnpoint.angles);
	level.spawn_all = maps/mp/gametypes/_spawnlogic::getspawnpointarray("mp_dom_spawn");
	level.spawn_start = [];
	foreach(team in level.teams)
	{
		level.spawn_start[team] = maps/mp/gametypes/_spawnlogic::getspawnpointarray("mp_dom_spawn_" + team + "_start");
	}

	flagspawns = maps/mp/gametypes/_spawnlogic::getspawnpointarray("mp_dom_spawn_flag_a");
	level.startpos["allies"] = level.spawn_start["allies"][0].origin;
	level.startpos["axis"] = level.spawn_start["axis"][0].origin;
	if(!isoneround() && isscoreroundbased())
	{
		maps/mp/gametypes/_globallogic_score::resetteamscores();
	}

	level.spawnsystem.unifiedsideswitching = 0;
	level thread watchforbflagcap();
	updategametypedvars();
	thread domflags();
	thread updatedomscores();
	level change_dom_spawns();
}

//Function Number: 4
onspawnplayerunified()
{
	maps/mp/gametypes/_spawning::onspawnplayer_unified();
}

//Function Number: 5
onspawnplayer(predictedspawn)
{
	spawnpoint = undefined;
	spawnteam = self.pers["team"];
	if(game["switchedsides"])
	{
		spawnteam = getotherteam(spawnteam);
	}

	if(!(level.usestartspawns))
	{
		flagsowned = 0;
		enemyflagsowned = 0;
		enemyteam = getotherteam(self.pers["team"]);
		for(i = 0;i < level.flags.size;i++)
		{
			team = level.flags[i] getflagteam();
			if(team == self.pers["team"])
			{
				flagsowned++;
			}
			else if(team == enemyteam)
			{
				enemyflagsowned++;
			}
		}

		enemyteam = getotherteam(spawnteam);
		if(flagsowned == level.flags.size)
		{
			enemybestspawnflag = level.bestspawnflag[enemyteam];
			spawnpoint = maps/mp/gametypes/_spawnlogic::getspawnpoint_nearteam(level.spawn_all,getspawnsboundingflag(enemybestspawnflag));
		}
		else if(flagsowned > 0)
		{
			spawnpoint = maps/mp/gametypes/_spawnlogic::getspawnpoint_nearteam(level.spawn_all,getboundaryflagspawns(spawnteam));
		}
		else
		{
			bestflag = undefined;
			if(enemyflagsowned > 0 && enemyflagsowned < level.flags.size)
			{
				bestflag = getunownedflagneareststart(spawnteam);
			}

			if(!(IsDefined(bestflag)))
			{
				bestflag = level.bestspawnflag[spawnteam];
			}

			level.bestspawnflag[spawnteam] = bestflag;
			spawnpoint = maps/mp/gametypes/_spawnlogic::getspawnpoint_nearteam(level.spawn_all,bestflag.nearbyspawns);
		}
	}

	if(!(IsDefined(spawnpoint)))
	{
		spawnpoint = maps/mp/gametypes/_spawnlogic::getspawnpoint_random(level.spawn_start[spawnteam]);
	}

/#
	assert(IsDefined(spawnpoint));
#/
	if(predictedspawn)
	{
		self predictspawnpoint(spawnpoint.origin,spawnpoint.angles);
	}
	else
	{
		self spawn(spawnpoint.origin,spawnpoint.angles,"dom");
	}
}

//Function Number: 6
onendgame(winningteam)
{
	for(i = 0;i < level.domflags.size;i++)
	{
		domflag = level.domflags[i];
		domflag maps/mp/gametypes/_gameobjects::allowuse("none");
		if(IsDefined(domflag.singleowner) && domflag.singleowner == 1)
		{
			team = domflag maps/mp/gametypes/_gameobjects::getownerteam();
			label = domflag maps/mp/gametypes/_gameobjects::getlabel();
			maps/mp/_challenges::holdflagentirematch(team,label);
		}
	}
}

//Function Number: 7
onroundendgame(roundwinner)
{
	if(level.roundscorecarry == 0)
	{
		foreach(team in level.teams)
		{
			[[ level._setteamscore ]](team,game["roundswon"][team]);
		}

		winner = maps/mp/gametypes/_globallogic::determineteamwinnerbygamestat("roundswon");
	}
	else
	{
		winner = maps/mp/gametypes/_globallogic::determineteamwinnerbyteamscore();
	}

	return winner;
}

//Function Number: 8
updategametypedvars()
{
	level.flagcapturetime = getgametypesetting("captureTime");
	level.playercapturelpm = getgametypesetting("maxPlayerEventsPerMinute");
	level.flagcapturelpm = getgametypesetting("maxObjectiveEventsPerMinute");
	level.playeroffensivemax = getgametypesetting("maxPlayerOffensive");
	level.playerdefensivemax = getgametypesetting("maxPlayerDefensive");
}

//Function Number: 9
domflags()
{
	level.laststatus["allies"] = 0;
	level.laststatus["axis"] = 0;
	level.flagmodel["allies"] = maps/mp/teams/_teams::getteamflagmodel("allies");
	level.flagmodel["axis"] = maps/mp/teams/_teams::getteamflagmodel("axis");
	level.flagmodel["neutral"] = maps/mp/teams/_teams::getteamflagmodel("neutral");
	precachemodel(level.flagmodel["allies"]);
	precachemodel(level.flagmodel["axis"]);
	precachemodel(level.flagmodel["neutral"]);
	precachestring(&"MP_CAPTURING_FLAG");
	precachestring(&"MP_LOSING_FLAG");
	precachestring(&"MP_DOM_YOUR_FLAG_WAS_CAPTURED");
	precachestring(&"MP_DOM_ENEMY_FLAG_CAPTURED");
	precachestring(&"MP_DOM_NEUTRAL_FLAG_CAPTURED");
	precachestring(&"MP_ENEMY_FLAG_CAPTURED_BY");
	precachestring(&"MP_NEUTRAL_FLAG_CAPTURED_BY");
	precachestring(&"MP_FRIENDLY_FLAG_CAPTURED_BY");
	precachestring(&"MP_DOM_FLAG_A_CAPTURED_BY");
	precachestring(&"MP_DOM_FLAG_B_CAPTURED_BY");
	precachestring(&"MP_DOM_FLAG_C_CAPTURED_BY");
	precachestring(&"MP_DOM_FLAG_D_CAPTURED_BY");
	precachestring(&"MP_DOM_FLAG_E_CAPTURED_BY");
	primaryflags = getentarray("flag_primary","targetname");
	secondaryflags = getentarray("flag_secondary","targetname");
	if(primaryflags.size + secondaryflags.size < 2)
	{
/#
		println("^1Not enough domination flags found in level!");
#/
		maps/mp/gametypes/_callbacksetup::abortlevel();
		return;
	}

	level.flags = [];
	for(index = 0;index < primaryflags.size;index++)
	{
		level.flags[level.flags.size] = primaryflags[index];
	}

	for(index = 0;index < secondaryflags.size;index++)
	{
		level.flags[level.flags.size] = secondaryflags[index];
	}

	level.domflags = [];
	for(index = 0;index < level.flags.size;index++)
	{
		trigger = level.flags[index];
		if(IsDefined(trigger.target))
		{
			visuals[0] = getent(trigger.target,"targetname");
		}
		else
		{
			visuals[0] = spawn("script_model",trigger.origin);
			visuals[0].angles = trigger.angles;
		}

		visuals[0] setmodel(level.flagmodel["neutral"]);
		name = istring(trigger.script_label);
		precachestring(name);
		domflag = maps/mp/gametypes/_gameobjects::createuseobject("neutral",trigger,visuals,(0,0,0),name);
		domflag maps/mp/gametypes/_gameobjects::allowuse("enemy");
		domflag maps/mp/gametypes/_gameobjects::setusetime(level.flagcapturetime);
		domflag maps/mp/gametypes/_gameobjects::setusetext(&"MP_CAPTURING_FLAG");
		label = domflag maps/mp/gametypes/_gameobjects::getlabel();
		domflag.label = label;
		domflag.flagindex = trigger.script_index;
		domflag maps/mp/gametypes/_gameobjects::setvisibleteam("any");
		domflag.onuse = ::onuse;
		domflag.onbeginuse = ::onbeginuse;
		domflag.onuseupdate = ::onuseupdate;
		domflag.onenduse = ::onenduse;
		domflag.onupdateuserate = ::onupdateuserate;
		tracestart = 32 + VectorScale((0,0,1));
		traceend = 32 + VectorScale((0,0,-1));
		trace = bullettrace(tracestart,traceend,0,undefined);
		upangles = VectorToAngles(trace["normal"]);
		domflag.baseeffectforward = AnglesToForward(upangles);
		domflag.baseeffectright = AnglesToRight(upangles);
		domflag.baseeffectpos = trace["position"];
		level.flags[index].useobj = domflag;
		level.flags[index].adjflags = [];
		level.flags[index].nearbyspawns = [];
		domflag.levelflag = level.flags[index];
		level.domflags[level.domflags.size] = domflag;
	}

	level.bestspawnflag = [];
	level.bestspawnflag["allies"] = getunownedflagneareststart("allies",undefined);
	level.bestspawnflag["axis"] = getunownedflagneareststart("axis",level.bestspawnflag["allies"]);
	for(index = 0;index < level.domflags.size;index++)
	{
		level.domflags[index] createflagspawninfluencers();
	}

	flagsetup();
/#
	thread domdebug();
#/
}

//Function Number: 10
getunownedflagneareststart(team,excludeflag)
{
	best = undefined;
	bestdistsq = undefined;
	for(i = 0;i < level.flags.size;i++)
	{
		flag = level.flags[i];
		if(flag getflagteam() != "neutral")
		{
		}
		else
		{
			distsq = distancesquared(flag.origin,level.startpos[team]);
			if((!IsDefined(excludeflag) || flag != excludeflag) && !IsDefined(best) || distsq < bestdistsq)
			{
				bestdistsq = distsq;
				best = flag;
			}
		}
	}

	return best;
}

//Function Number: 11
domdebug()
{
/#
	for(;;)
	{
		wait(2);
		for(;;)
		{
			break;
			i = 0;
			for(;;)
			{
				j = 0;
				for(;;)
				{
					line(level.flags[i].origin,level.flags[i].adjflags[j].origin,(1,1,1));
					j++;
				}
				j = 0;
				for(;;)
				{
					line(level.flags[i].origin,level.flags[i].nearbyspawns[j].origin,(0.2,0.2,0.6));
					j++;
				}
				print3d(level.flags[i].origin,"allies best spawn flag");
				print3d(level.flags[i].origin,"axis best spawn flag");
				i++;
			}
			wait(0.05);
		}
	}
level.flags[i] == level.bestspawnflag["axis"]
level.flags[i] == level.bestspawnflag["allies"]
j < level.flags[i].nearbyspawns.size
j < level.flags[i].adjflags.size
i < level.flags.size
GetDvar(#"9F76D073") != "1"
1
GetDvar(#"9F76D073") != "1"
1
#/
}

//Function Number: 12
onbeginuse(player)
{
	ownerteam = self maps/mp/gametypes/_gameobjects::getownerteam();
	self.didstatusnotify = 0;
	if(ownerteam == "allies")
	{
		otherteam = "axis";
	}
	else
	{
		otherteam = "allies";
	}

	if(ownerteam == "neutral")
	{
		otherteam = getotherteam(player.pers["team"]);
		statusdialog("securing" + self.label,player.pers["team"],"gamemode_changing" + self.label);
	}
}

//Function Number: 13
onuseupdate(team,progress,change)
{
	if(progress > 0.05 && change && !self.didstatusnotify)
	{
		ownerteam = self maps/mp/gametypes/_gameobjects::getownerteam();
		if(ownerteam == "neutral")
		{
			otherteam = getotherteam(team);
			statusdialog("securing" + self.label,team,"gamemode_changing" + self.label);
		}
		else
		{
			statusdialog("losing" + self.label,ownerteam,"gamemode_changing" + self.label);
			statusdialog("securing" + self.label,team,"gamemode_changing" + self.label);
		}

		self.didstatusnotify = 1;
	}
}

//Function Number: 14
flushalldialog()
{
	maps/mp/gametypes/_globallogic_audio::flushgroupdialog("gamemode_objective_a");
	maps/mp/gametypes/_globallogic_audio::flushgroupdialog("gamemode_objective_b");
	maps/mp/gametypes/_globallogic_audio::flushgroupdialog("gamemode_objective_c");
	maps/mp/gametypes/_globallogic_audio::flushgroupdialog("gamemode_changing_a");
	maps/mp/gametypes/_globallogic_audio::flushgroupdialog("gamemode_changing_b");
	maps/mp/gametypes/_globallogic_audio::flushgroupdialog("gamemode_changing_c");
}

//Function Number: 15
statusdialog(dialog,team,group,flushgroup)
{
	if(IsDefined(flushgroup))
	{
		maps/mp/gametypes/_globallogic_audio::flushgroupdialog(flushgroup);
	}

	maps/mp/gametypes/_globallogic_audio::leaderdialog(dialog,team,group);
}

//Function Number: 16
onenduse(team,player,success)
{
	if(!(success))
	{
		maps/mp/gametypes/_globallogic_audio::flushgroupdialog("gamemode_changing" + self.label);
	}
}

//Function Number: 17
resetflagbaseeffect()
{
	if(IsDefined(self.baseeffect))
	{
		self.baseeffect delete();
	}

	team = self maps/mp/gametypes/_gameobjects::getownerteam();
	if(team != "axis" && team != "allies")
	{
		return;
	}

	fxid = level.flagbasefxid[team];
	self.baseeffect = spawnfx(fxid,self.baseeffectpos,self.baseeffectforward,self.baseeffectright);
	triggerfx(self.baseeffect);
}

//Function Number: 18
onuse(player)
{
	level notify("flag_captured");
	team = player.pers["team"];
	oldteam = self maps/mp/gametypes/_gameobjects::getownerteam();
	label = self maps/mp/gametypes/_gameobjects::getlabel();
	player logstring("flag captured: " + self.label);
	self maps/mp/gametypes/_gameobjects::setownerteam(team);
	self.visuals[0] setmodel(level.flagmodel[team]);
	setdvar("scr_obj" + self maps/mp/gametypes/_gameobjects::getlabel(),team);
	self resetflagbaseeffect();
	level.usestartspawns = 0;
/#
	assert(team != "neutral");
#/
	isbflag = 0;
	string = &"";
	switch(label)
	{
		case "€GSC\r\n":
			string = &"MP_DOM_FLAG_A_CAPTURED_BY";
			break;

		case "€GSC\r\n":
			string = &"MP_DOM_FLAG_B_CAPTURED_BY";
			isbflag = 1;
			break;

		case "€GSC\r\n":
			string = &"MP_DOM_FLAG_C_CAPTURED_BY";
			break;

		case "€GSC\r\n":
			string = &"MP_DOM_FLAG_D_CAPTURED_BY";
			break;

		case "€GSC\r\n":
			string = &"MP_DOM_FLAG_E_CAPTURED_BY";
			break;

		default:
			break;
	}

/#
	assert(string != &"");
#/
	touchlist = [];
	touchkeys = getarraykeys(self.touchlist[team]);
	for(i = 0;i < touchkeys.size;i++)
	{
		touchlist[touchkeys[i]] = self.touchlist[team][touchkeys[i]];
	}

	thread give_capture_credit(touchlist,string,oldteam,isbflag);
	bbprint("mpobjective","gametime %d objtype %s label %s team %s",GetTime(),"dom_capture",label,team);
	if(oldteam == "neutral")
	{
		self.singleowner = 1;
		otherteam = getotherteam(team);
		thread printandsoundoneveryone(team,undefined,&"",undefined,"mp_war_objective_taken");
		thread playsoundonplayers("mus_dom_captured" + "_" + level.teampostfix[team]);
		if(getteamflagcount(team) == level.flags.size)
		{
			statusdialog("secure_all",team,"gamemode_objective");
			statusdialog("lost_all",otherteam,"gamemode_objective");
			flushalldialog();
		}
		else
		{
			statusdialog("secured" + self.label,team,"gamemode_objective" + self.label,"gamemode_changing" + self.label);
			statusdialog("enemy" + self.label,otherteam,"gamemode_objective" + self.label,"gamemode_changing" + self.label);
			maps/mp/gametypes/_globallogic_audio::play_2d_on_team("mpl_flagcapture_sting_enemy",otherteam);
			maps/mp/gametypes/_globallogic_audio::play_2d_on_team("mpl_flagcapture_sting_friend",team);
		}
	}
	else
	{
		self.singleowner = 0;
		thread printandsoundoneveryone(team,oldteam,&"",&"","mp_war_objective_taken","mp_war_objective_lost","");
		if(getteamflagcount(team) == level.flags.size)
		{
			statusdialog("secure_all",team,"gamemode_objective");
			statusdialog("lost_all",oldteam,"gamemode_objective");
			flushalldialog();
		}
		else
		{
			statusdialog("secured" + self.label,team,"gamemode_objective" + self.label,"gamemode_changing" + self.label);
			if(randomint(2))
			{
				statusdialog("lost" + self.label,oldteam,"gamemode_objective" + self.label,"gamemode_changing" + self.label);
			}
			else
			{
				statusdialog("enemy" + self.label,oldteam,"gamemode_objective" + self.label,"gamemode_changing" + self.label);
			}

			maps/mp/gametypes/_globallogic_audio::play_2d_on_team("mpl_flagcapture_sting_enemy",oldteam);
			maps/mp/gametypes/_globallogic_audio::play_2d_on_team("mpl_flagcapture_sting_friend",team);
		}

		level.bestspawnflag[oldteam] = self.levelflag;
	}

	if(dominated_challenge_check())
	{
		level thread totaldomination(team);
	}

	self update_spawn_influencers(team);
	level change_dom_spawns();
}

//Function Number: 19
totaldomination(team)
{
	level endon("flag_captured");
	level endon("game_ended");
	wait(180);
	maps/mp/_challenges::totaldomination(team);
}

//Function Number: 20
watchforbflagcap()
{
	level endon("game_ended");
	level endon("endWatchForBFlagCapAfterTime");
	level thread endwatchforbflagcapaftertime(60);
	for(;;)
	{
		level waittill("b_flag_captured",player);
		player maps/mp/_challenges::capturedbfirstminute();
	}
}

//Function Number: 21
endwatchforbflagcapaftertime(time)
{
	level endon("game_ended");
	wait(60);
	level notify("endWatchForBFlagCapAfterTime");
}

//Function Number: 22
give_capture_credit(touchlist,string,lastownerteam,isbflag)
{
	time = GetTime();
	wait(0.05);
	maps/mp/gametypes/_globallogic_utils::waittillslowprocessallowed();
	self updatecapsperminute(lastownerteam);
	players = getarraykeys(touchlist);
	for(i = 0;i < players.size;i++)
	{
		player_from_touchlist = touchlist[players[i]].player;
		player_from_touchlist updatecapsperminute(lastownerteam);
		if(!(isscoreboosting(player_from_touchlist,self)))
		{
			player_from_touchlist maps/mp/_challenges::capturedobjective(time);
			if(lastownerteam == "neutral")
			{
				if(isbflag)
				{
					maps/mp/_scoreevents::processscoreevent("dom_point_neutral_b_secured",player_from_touchlist);
					continue;
				}

				maps/mp/_scoreevents::processscoreevent("dom_point_neutral_secured",player_from_touchlist);
			}
			else
			{
				maps/mp/_scoreevents::processscoreevent("dom_point_secured",player_from_touchlist);
			}

			player_from_touchlist recordgameevent("capture");
			if(isbflag)
			{
				level notify("b_flag_captured",player_from_touchlist);
			}

			if(IsDefined(player_from_touchlist.pers["captures"]))
			{
				player_from_touchlist.pers["captures"]++;
				player_from_touchlist.captures = player_from_touchlist.pers["captures"];
			}

			maps/mp/_demo::bookmark("event",GetTime(),player_from_touchlist);
			player_from_touchlist addplayerstatwithgametype("CAPTURES",1);
		}
		else
		{
/#
			player_from_touchlist iprintlnbold("GAMETYPE DEBUG: NOT GIVING YOU CAPTURE CREDIT AS BOOSTING PREVENTION");
#/
		}

		level thread maps/mp/_popups::displayteammessagetoall(string,player_from_touchlist);
	}
}

//Function Number: 23
delayedleaderdialog(sound,team,label)
{
	wait(0.1);
	maps/mp/gametypes/_globallogic_utils::waittillslowprocessallowed();
	if(!(IsDefined(label)))
	{
		label = "";
	}

	maps/mp/gametypes/_globallogic_audio::leaderdialog(sound,team,"gamemode_objective" + label);
}

//Function Number: 24
updatedomscores()
{
	while(!(level.gameended))
	{
		numownedflags = 0;
		scoring_teams = [];
		numflags = getteamflagcount("allies");
		numownedflags = numownedflags + numflags;
		if(numflags)
		{
			scoring_teams[scoring_teams.size] = "allies";
			maps/mp/gametypes/_globallogic_score::giveteamscoreforobjective_delaypostprocessing("allies",numflags);
		}

		numflags = getteamflagcount("axis");
		numownedflags = numownedflags + numflags;
		if(numflags)
		{
			scoring_teams[scoring_teams.size] = "axis";
			maps/mp/gametypes/_globallogic_score::giveteamscoreforobjective_delaypostprocessing("axis",numflags);
		}

		if(numownedflags)
		{
			maps/mp/gametypes/_globallogic_score::postprocessteamscores(scoring_teams);
		}

		onscoreclosemusic();
		timepassed = maps/mp/gametypes/_globallogic_utils::gettimepassed();
		if(((timepassed / 1000 > 120 && numownedflags < 2) || timepassed / 1000 > 300 && numownedflags < 3) && gamemodeismode(level.gamemode_public_match))
		{
			thread maps/mp/gametypes/_globallogic::endgame("tie",game["strings"]["time_limit_reached"]);
			return;
		}

		wait(5);
		maps/mp/gametypes/_hostmigration::waittillhostmigrationdone();
	}
}

//Function Number: 25
onscoreclosemusic()
{
	axisscore = [[ level._getteamscore ]]("axis");
	alliedscore = [[ level._getteamscore ]]("allies");
	scorelimit = level.scorelimit;
	scorethreshold = scorelimit * 0.1;
	scoredif = Abs(axisscore - alliedscore);
	scorethresholdstart = Abs(scorelimit - scorethreshold);
	scorelimitcheck = scorelimit - 10;
	if(!(IsDefined(level.playingactionmusic)))
	{
		level.playingactionmusic = 0;
	}

	if(alliedscore > axisscore)
	{
		currentscore = alliedscore;
	}
	else
	{
		currentscore = axisscore;
	}

/#
	println("Music System Domination - scoreDif " + scoredif);
	println("Music System Domination - axisScore " + axisscore);
	println("Music System Domination - alliedScore " + alliedscore);
	println("Music System Domination - scoreLimit " + scorelimit);
	println("Music System Domination - currentScore " + currentscore);
	println("Music System Domination - scoreThreshold " + scorethreshold);
	println("Music System Domination - scoreDif " + scoredif);
	println("Music System Domination - scoreThresholdStart " + scorethresholdstart);
GetDvarInt(#"BC4784C") > 0
#/
	if(scoredif <= scorethreshold && scorethresholdstart <= currentscore && level.playingactionmusic != 1)
	{
		thread maps/mp/gametypes/_globallogic_audio::set_music_on_team("TIME_OUT","both");
		thread maps/mp/gametypes/_globallogic_audio::actionmusicset();
	}
	else
	{
	}
}

//Function Number: 26
onroundswitch()
{
	if(!(IsDefined(game["switchedsides"])))
	{
		game["switchedsides"] = 0;
	}

	game["switchedsides"] = !game["switchedsides"];
	if(level.roundscorecarry == 0)
	{
		[[ level._setteamscore ]]("allies",game["roundswon"]["allies"]);
		[[ level._setteamscore ]]("axis",game["roundswon"]["axis"]);
	}
}

//Function Number: 27
onplayerkilled(einflictor,attacker,idamage,smeansofdeath,sweapon,vdir,shitloc,psoffsettime,deathanimduration)
{
	if(IsDefined(attacker) && isplayer(attacker))
	{
		scoreeventprocessed = 0;
		if(attacker.touchtriggers.size && attacker.pers["team"] != self.pers["team"])
		{
			triggerids = getarraykeys(attacker.touchtriggers);
			ownerteam = attacker.touchtriggers[triggerids[0]].useobj.ownerteam;
			team = attacker.pers["team"];
			if(team != ownerteam)
			{
				maps/mp/_scoreevents::processscoreevent("kill_enemy_while_capping_dom",attacker,undefined,sweapon);
				scoreeventprocessed = 1;
			}
		}

		for(index = 0;index < level.flags.size;index++)
		{
			flagteam = "invalidTeam";
			inflagzone = 0;
			defendedflag = 0;
			offendedflag = 0;
			flagorigin = level.flags[index].origin;
			level.defaultoffenseradius = 300;
			dist = distance2d(self.origin,flagorigin);
			if(dist < level.defaultoffenseradius)
			{
				inflagzone = 1;
				if(level.flags[index] getflagteam() == attacker.pers["team"] || level.flags[index] getflagteam() == "neutral")
				{
					defendedflag = 1;
				}
				else
				{
					offendedflag = 1;
				}
			}

			dist = distance2d(attacker.origin,flagorigin);
			if(dist < level.defaultoffenseradius)
			{
				inflagzone = 1;
				if(level.flags[index] getflagteam() == attacker.pers["team"] || level.flags[index] getflagteam() == "neutral")
				{
					defendedflag = 1;
				}
				else
				{
					offendedflag = 1;
				}
			}

			if(inflagzone && isplayer(attacker) && attacker.pers["team"] != self.pers["team"])
			{
				if(offendedflag)
				{
					if(!(IsDefined(attacker.dom_defends)))
					{
						attacker.dom_defends = 0;
					}

					attacker.dom_defends++;
					if(level.playerdefensivemax >= attacker.dom_defends)
					{
						attacker addplayerstatwithgametype("OFFENDS",1);
						if(!(scoreeventprocessed))
						{
							maps/mp/_scoreevents::processscoreevent("killed_defender",attacker,undefined,sweapon);
						}

						self recordkillmodifier("defending");
						break;
					}
					else
					{
/#
						attacker iprintlnbold("GAMETYPE DEBUG: NOT GIVING YOU DEFENSIVE CREDIT AS BOOSTING PREVENTION");
#/
					}
				}

				if(defendedflag)
				{
					if(!(IsDefined(attacker.dom_offends)))
					{
						attacker.dom_offends = 0;
					}

					attacker thread updateattackermultikills();
					attacker.dom_offends++;
					if(level.playeroffensivemax >= attacker.dom_offends)
					{
						attacker.pers["defends"]++;
						attacker.defends = attacker.pers["defends"];
						attacker addplayerstatwithgametype("DEFENDS",1);
						attacker recordgameevent("return");
						attacker maps/mp/_challenges::killedzoneattacker(sweapon);
						if(!(scoreeventprocessed))
						{
							maps/mp/_scoreevents::processscoreevent("killed_attacker",attacker,undefined,sweapon);
						}

						self recordkillmodifier("assaulting");
						break;
					}
					else
					{
/#
						attacker iprintlnbold("GAMETYPE DEBUG: NOT GIVING YOU OFFENSIVE CREDIT AS BOOSTING PREVENTION");
#/
					}
				}
			}
		}

		if(self.touchtriggers.size && attacker.pers["team"] != self.pers["team"])
		{
			triggerids = getarraykeys(self.touchtriggers);
			ownerteam = self.touchtriggers[triggerids[0]].useobj.ownerteam;
			team = self.pers["team"];
			if(team != ownerteam)
			{
				flag = self.touchtriggers[triggerids[0]].useobj;
				if(IsDefined(flag.contested) && flag.contested == 1)
				{
					attacker killwhilecontesting(flag);
				}
			}
		}
	}
}

//Function Number: 28
killwhilecontesting(flag)
{
	self notify("killWhileContesting");
	self endon("killWhileContesting");
	self endon("disconnect");
	killtime = GetTime();
	playerteam = self.pers["team"];
	if(!(IsDefined(self.clearenemycount)))
	{
		self.clearenemycount = 0;
	}

	self.clearenemycount++;
	flag waittill("contest_over");
	if(playerteam != self.pers["team"] || IsDefined(self.spawntime) && killtime < self.spawntime)
	{
		self.clearenemycount = 0;
		return;
	}

	if(flag.ownerteam != playerteam && flag.ownerteam != "neutral")
	{
		self.clearenemycount = 0;
		return;
	}

	if(self.clearenemycount >= 2 && killtime + 200 > GetTime())
	{
		maps/mp/_scoreevents::processscoreevent("clear_2_attackers",self);
	}

	self.clearenemycount = 0;
}

//Function Number: 29
updateattackermultikills()
{
	self endon("disconnect");
	level endon("game_ended");
	self notify("updateDomRecentKills");
	self endon("updateDomRecentKills");
	if(!(IsDefined(self.recentdomattackerkillcount)))
	{
		self.recentdomattackerkillcount = 0;
	}

	self.recentdomattackerkillcount++;
	wait(4);
	if(self.recentdomattackerkillcount > 1)
	{
		self maps/mp/_challenges::domattackermultikill(self.recentdomattackerkillcount);
	}

	self.recentdomattackerkillcount = 0;
}

//Function Number: 30
getteamflagcount(team)
{
	score = 0;
	for(i = 0;i < level.flags.size;i++)
	{
		if(level.domflags[i] maps/mp/gametypes/_gameobjects::getownerteam() == team)
		{
			score++;
		}
	}

	return score;
}

//Function Number: 31
getflagteam()
{
	return self.useobj maps/mp/gametypes/_gameobjects::getownerteam();
}

//Function Number: 32
getboundaryflags()
{
	bflags = [];
	for(i = 0;i < level.flags.size;i++)
	{
		for(j = 0;j < level.flags[i].adjflags.size;j++)
		{
			if(level.flags[i].useobj maps/mp/gametypes/_gameobjects::getownerteam() != level.flags[i].adjflags[j].useobj maps/mp/gametypes/_gameobjects::getownerteam())
			{
				bflags[bflags.size] = level.flags[i];
				break;
			}
		}
	}

	return bflags;
}

//Function Number: 33
getboundaryflagspawns(team)
{
	spawns = [];
	bflags = getboundaryflags();
	for(i = 0;i < bflags.size;i++)
	{
		if(IsDefined(team) && bflags[i] getflagteam() != team)
		{
		}
		else
		{
			for(j = 0;j < bflags[i].nearbyspawns.size;j++)
			{
				spawns[spawns.size] = bflags[i].nearbyspawns[j];
			}
		}
	}

	return spawns;
}

//Function Number: 34
getspawnsboundingflag(avoidflag)
{
	spawns = [];
	for(i = 0;i < level.flags.size;i++)
	{
		flag = level.flags[i];
		if(flag == avoidflag)
		{
		}
		else
		{
			isbounding = 0;
			for(j = 0;j < flag.adjflags.size;j++)
			{
				if(flag.adjflags[j] == avoidflag)
				{
					isbounding = 1;
					break;
				}
			}

			if(!(isbounding))
			{
			}
			else
			{
				for(j = 0;j < flag.nearbyspawns.size;j++)
				{
					spawns[spawns.size] = flag.nearbyspawns[j];
				}
			}
		}
	}

	return spawns;
}

//Function Number: 35
getownedandboundingflagspawns(team)
{
	spawns = [];
	for(i = 0;i < level.flags.size;i++)
	{
		if(level.flags[i] getflagteam() == team)
		{
			for(s = 0;s < level.flags[i].nearbyspawns.size;s++)
			{
				spawns[spawns.size] = level.flags[i].nearbyspawns[s];
			}
		}
		else
		{
			for(j = 0;j < level.flags[i].adjflags.size;j++)
			{
				if(level.flags[i].adjflags[j] getflagteam() == team)
				{
					for(s = 0;s < level.flags[i].nearbyspawns.size;s++)
					{
						spawns[spawns.size] = level.flags[i].nearbyspawns[s];
					}

					break;
				}
			}
		}
	}

	return spawns;
}

//Function Number: 36
getownedflagspawns(team)
{
	spawns = [];
	for(i = 0;i < level.flags.size;i++)
	{
		if(level.flags[i] getflagteam() == team)
		{
			for(s = 0;s < level.flags[i].nearbyspawns.size;s++)
			{
				spawns[spawns.size] = level.flags[i].nearbyspawns[s];
			}
		}
	}

	return spawns;
}

//Function Number: 37
flagsetup()
{
	maperrors = [];
	descriptorsbylinkname = [];
	descriptors = getentarray("flag_descriptor","targetname");
	flags = level.flags;
	for(i = 0;i < level.domflags.size;i++)
	{
		closestdist = undefined;
		closestdesc = undefined;
		for(j = 0;j < descriptors.size;j++)
		{
			dist = distance(flags[i].origin,descriptors[j].origin);
			if(!IsDefined(closestdist) || dist < closestdist)
			{
				closestdist = dist;
				closestdesc = descriptors[j];
			}
		}

		if(!(IsDefined(closestdesc)))
		{
			maperrors[maperrors.size] = "there is no flag_descriptor in the map! see explanation in dom.gsc";
			break;
		}

		if(IsDefined(closestdesc.flag))
		{
			maperrors[maperrors.size] = "flag_descriptor with script_linkname \" + closestdesc.script_linkname + "\" is nearby more than one flag; is there a unique descriptor near each flag?";
		}
		else
		{
			flags[i].descriptor = closestdesc;
			closestdesc.flag = flags[i];
			descriptorsbylinkname[closestdesc.script_linkname] = closestdesc;
		}
	}

	if(maperrors.size == 0)
	{
		for(i = 0;i < flags.size;i++)
		{
			if(IsDefined(flags[i].descriptor.script_linkto))
			{
				adjdescs = strtok(flags[i].descriptor.script_linkto," ");
			}
			else
			{
				adjdescs = [];
			}

			for(j = 0;j < adjdescs.size;j++)
			{
				otherdesc = descriptorsbylinkname[adjdescs[j]];
				if(!IsDefined(otherdesc) || otherdesc.targetname != "flag_descriptor")
				{
					maperrors[maperrors.size] = "flag_descriptor with script_linkname \" + flags[i].descriptor.script_linkname + "\" linked to \" + adjdescs[j] + "\" which does not exist as a script_linkname of any other entity with a targetname of flag_descriptor (or, if it does, that flag_descriptor has not been assigned to a flag)";
				}
				else
				{
					adjflag = otherdesc.flag;
					if(adjflag == flags[i])
					{
						maperrors[maperrors.size] = "flag_descriptor with script_linkname \" + flags[i].descriptor.script_linkname + "\" linked to itself";
					}
					else
					{
						flags[i].adjflags[flags[i].adjflags.size] = adjflag;
					}
				}
			}
		}
	}

	spawnpoints = maps/mp/gametypes/_spawnlogic::getspawnpointarray("mp_dom_spawn");
	for(i = 0;i < spawnpoints.size;i++)
	{
		if(IsDefined(spawnpoints[i].script_linkto))
		{
			desc = descriptorsbylinkname[spawnpoints[i].script_linkto];
			if(!IsDefined(desc) || desc.targetname != "flag_descriptor")
			{
				maperrors[maperrors.size] = "Spawnpoint at " + spawnpoints[i].origin + "\" linked to \" + spawnpoints[i].script_linkto + "\" which does not exist as a script_linkname of any entity with a targetname of flag_descriptor (or, if it does, that flag_descriptor has not been assigned to a flag)";
			}
			else
			{
				nearestflag = desc.flag;
				nearestflag = undefined;
				nearestdist = undefined;
				for(j = 0;j < flags.size;j++)
				{
					dist = distancesquared(flags[j].origin,spawnpoints[i].origin);
					if(!IsDefined(nearestflag) || dist < nearestdist)
					{
						nearestflag = flags[j];
						nearestdist = dist;
					}
				}

				nearestflag.nearbyspawns[nearestflag.nearbyspawns.size] = spawnpoints[i];
			}
		}
	}

	if(maperrors.size > 0)
	{
/#
		println("^1------------ Map Errors ------------");
		i = 0;
		for(;;)
		{
			println(maperrors[i]);
			i++;
		}
		println("^1------------------------------------");
		maps/mp/_utility::error("Map errors. See above");
i < maperrors.size
#/
		maps/mp/gametypes/_callbacksetup::abortlevel();
	}
}

//Function Number: 38
createflagspawninfluencers()
{
	ss = level.spawnsystem;
	for(flag_index = 0;flag_index < level.flags.size;flag_index++)
	{
		if(level.domflags[flag_index] == self)
		{
			break;
		}
	}

	abc = [];
	abc[0] = "A";
	abc[1] = "B";
	abc[2] = "C";
	self.owned_flag_influencer = addsphereinfluencer(level.spawnsystem.einfluencer_type_game_mode,self.trigger.origin,ss.dom_owned_flag_influencer_radius[flag_index],ss.dom_owned_flag_influencer_score[flag_index],0,"dom_owned_flag_" + abc[flag_index] + ",r,s",maps/mp/gametypes/_spawning::get_score_curve_index(ss.dom_owned_flag_influencer_score_curve));
	self.neutral_flag_influencer = addsphereinfluencer(level.spawnsystem.einfluencer_type_game_mode,self.trigger.origin,ss.dom_unowned_flag_influencer_radius,ss.dom_unowned_flag_influencer_score,0,"dom_unowned_flag,r,s",maps/mp/gametypes/_spawning::get_score_curve_index(ss.dom_owned_flag_influencer_score_curve));
	self.enemy_flag_influencer = addsphereinfluencer(level.spawnsystem.einfluencer_type_game_mode,self.trigger.origin,ss.dom_enemy_flag_influencer_radius[flag_index],ss.dom_enemy_flag_influencer_score[flag_index],0,"dom_enemy_flag_" + abc[flag_index] + ",r,s",maps/mp/gametypes/_spawning::get_score_curve_index(ss.dom_enemy_flag_influencer_score_curve));
	self update_spawn_influencers("neutral");
}

//Function Number: 39
update_spawn_influencers(team)
{
/#
	assert(IsDefined(self.neutral_flag_influencer));
#/
/#
	assert(IsDefined(self.owned_flag_influencer));
#/
/#
	assert(IsDefined(self.enemy_flag_influencer));
#/
	if(team == "neutral")
	{
		enableinfluencer(self.neutral_flag_influencer,1);
		enableinfluencer(self.owned_flag_influencer,0);
		enableinfluencer(self.enemy_flag_influencer,0);
	}
	else
	{
		enableinfluencer(self.neutral_flag_influencer,0);
		enableinfluencer(self.owned_flag_influencer,1);
		enableinfluencer(self.enemy_flag_influencer,1);
		setinfluencerteammask(self.owned_flag_influencer,getteammask(team));
		setinfluencerteammask(self.enemy_flag_influencer,getotherteamsmask(team));
	}
}

//Function Number: 40
dom_gamemodespawndvars(reset_dvars)
{
	ss = level.spawnsystem;
	ss.dom_owned_flag_influencer_score = [];
	ss.dom_owned_flag_influencer_radius = [];
	ss.dom_owned_flag_influencer_score[0] = set_dvar_float_if_unset("scr_spawn_dom_owned_flag_A_influencer_score","10",reset_dvars);
	ss.dom_owned_flag_influencer_radius[0] = set_dvar_float_if_unset("scr_spawn_dom_owned_flag_A_influencer_radius","" + 15 * get_player_height(),reset_dvars);
	ss.dom_owned_flag_influencer_score[1] = set_dvar_float_if_unset("scr_spawn_dom_owned_flag_B_influencer_score","10",reset_dvars);
	ss.dom_owned_flag_influencer_radius[1] = set_dvar_float_if_unset("scr_spawn_dom_owned_flag_B_influencer_radius","" + 15 * get_player_height(),reset_dvars);
	ss.dom_owned_flag_influencer_score[2] = set_dvar_float_if_unset("scr_spawn_dom_owned_flag_C_influencer_score","10",reset_dvars);
	ss.dom_owned_flag_influencer_radius[2] = set_dvar_float_if_unset("scr_spawn_dom_owned_flag_C_influencer_radius","" + 15 * get_player_height(),reset_dvars);
	ss.dom_owned_flag_influencer_score_curve = set_dvar_if_unset("scr_spawn_dom_owned_flag_influencer_score_curve","constant",reset_dvars);
	ss.dom_enemy_flag_influencer_score = [];
	ss.dom_enemy_flag_influencer_radius = [];
	ss.dom_enemy_flag_influencer_score[0] = set_dvar_float_if_unset("scr_spawn_dom_enemy_flag_A_influencer_score","-50",reset_dvars);
	ss.dom_enemy_flag_influencer_radius[0] = set_dvar_float_if_unset("scr_spawn_dom_enemy_flag_A_influencer_radius","" + 15 * get_player_height(),reset_dvars);
	ss.dom_enemy_flag_influencer_score[1] = set_dvar_float_if_unset("scr_spawn_dom_enemy_flag_B_influencer_score","-50",reset_dvars);
	ss.dom_enemy_flag_influencer_radius[1] = set_dvar_float_if_unset("scr_spawn_dom_enemy_flag_B_influencer_radius","" + 15 * get_player_height(),reset_dvars);
	ss.dom_enemy_flag_influencer_score[2] = set_dvar_float_if_unset("scr_spawn_dom_enemy_flag_C_influencer_score","-50",reset_dvars);
	ss.dom_enemy_flag_influencer_radius[2] = set_dvar_float_if_unset("scr_spawn_dom_enemy_flag_C_influencer_radius","" + 15 * get_player_height(),reset_dvars);
	ss.dom_enemy_flag_influencer_score_curve = set_dvar_if_unset("scr_spawn_dom_enemy_flag_influencer_score_curve","constant",reset_dvars);
	ss.dom_unowned_flag_influencer_score = set_dvar_float_if_unset("scr_spawn_dom_unowned_flag_influencer_score","-500",reset_dvars);
	ss.dom_unowned_flag_influencer_score_curve = set_dvar_if_unset("scr_spawn_dom_unowned_flag_influencer_score_curve","constant",reset_dvars);
	ss.dom_unowned_flag_influencer_radius = set_dvar_float_if_unset("scr_spawn_dom_unowned_flag_influencer_radius","" + 15 * get_player_height(),reset_dvars);
}

//Function Number: 41
addspawnpointsforflag(team,flag_team,flagspawnname)
{
	if(game["switchedsides"])
	{
		team = getotherteam(team);
	}

	otherteam = getotherteam(team);
	if(flag_team != otherteam)
	{
		maps/mp/gametypes/_spawnlogic::addspawnpoints(team,flagspawnname);
	}
}

//Function Number: 42
change_dom_spawns()
{
	maps/mp/gametypes/_spawnlogic::clearspawnpoints();
	maps/mp/gametypes/_spawnlogic::addspawnpoints("allies","mp_dom_spawn");
	maps/mp/gametypes/_spawnlogic::addspawnpoints("axis","mp_dom_spawn");
	flag_number = level.flags.size;
	if(dominated_check())
	{
		for(i = 0;i < flag_number;i++)
		{
			label = level.flags[i].useobj maps/mp/gametypes/_gameobjects::getlabel();
			flagspawnname = "mp_dom_spawn_flag" + label;
			maps/mp/gametypes/_spawnlogic::addspawnpoints("allies",flagspawnname);
			maps/mp/gametypes/_spawnlogic::addspawnpoints("axis",flagspawnname);
		}
	}
	else
	{
		for(i = 0;i < flag_number;i++)
		{
			label = level.flags[i].useobj maps/mp/gametypes/_gameobjects::getlabel();
			flagspawnname = "mp_dom_spawn_flag" + label;
			flag_team = level.flags[i] getflagteam();
			addspawnpointsforflag("allies",flag_team,flagspawnname);
			addspawnpointsforflag("axis",flag_team,flagspawnname);
		}
	}

	maps/mp/gametypes/_spawning::updateallspawnpoints();
}

//Function Number: 43
dominated_challenge_check()
{
	num_flags = level.flags.size;
	allied_flags = 0;
	axis_flags = 0;
	for(i = 0;i < num_flags;i++)
	{
		flag_team = level.flags[i] getflagteam();
		if(flag_team == "allies")
		{
			allied_flags++;
		}
		else if(flag_team == "axis")
		{
			axis_flags++;
		}
		else
		{
			return 0;
		}

		if(allied_flags > 0 && axis_flags > 0)
		{
			return 0;
		}
	}

	return 1;
}

//Function Number: 44
dominated_check()
{
	num_flags = level.flags.size;
	allied_flags = 0;
	axis_flags = 0;
	for(i = 0;i < num_flags;i++)
	{
		flag_team = level.flags[i] getflagteam();
		if(flag_team == "allies")
		{
			allied_flags++;
		}
		else if(flag_team == "axis")
		{
			axis_flags++;
		}

		if(allied_flags > 0 && axis_flags > 0)
		{
			return 0;
		}
	}

	return 1;
}

//Function Number: 45
updatecapsperminute(lastownerteam)
{
	if(!(IsDefined(self.capsperminute)))
	{
		self.numcaps = 0;
		self.capsperminute = 0;
	}

	if(lastownerteam == "neutral")
	{
		return;
	}

	self.numcaps++;
	minutespassed = maps/mp/gametypes/_globallogic_utils::gettimepassed() / 60000;
	if(isplayer(self) && IsDefined(self.timeplayed["total"]))
	{
		minutespassed = self.timeplayed["total"] / 60;
	}

	self.capsperminute = self.numcaps / minutespassed;
	if(self.capsperminute > self.numcaps)
	{
		self.capsperminute = self.numcaps;
	}
}

//Function Number: 46
isscoreboosting(player,flag)
{
	if(!(level.rankedmatch))
	{
		return 0;
	}

	if(player.capsperminute > level.playercapturelpm)
	{
		return 1;
	}

	if(flag.capsperminute > level.flagcapturelpm)
	{
		return 1;
	}

	return 0;
}

//Function Number: 47
onupdateuserate()
{
	if(!(IsDefined(self.contested)))
	{
		self.contested = 0;
	}

	numother = getnumtouchingexceptteam(self.ownerteam);
	numowners = self.numtouching[self.claimteam];
	previousstate = self.contested;
	if(numother > 0 && numowners > 0)
	{
		self.contested = 1;
	}
	else
	{
		if(previousstate == 1)
		{
			self notify("contest_over");
		}

		self.contested = 0;
	}
}