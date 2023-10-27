/*******************************************************************
 * Decompiled By: Bog
 * Decompiled File: maps\mp\gametypes\dm.gsc
 * Game: Call of Duty: Black Ops 2
 * Platform: Console
 * Function Count: 7
 * Decompile Time: 36 ms
 * Timestamp: 10/27/2023 3:04:32 AM
*******************************************************************/

#include maps/mp/_utility;
#include maps/mp/gametypes/_callbacksetup;
#include maps/mp/gametypes/_gameobjects;
#include maps/mp/gametypes/_globallogic;
#include maps/mp/gametypes/_globallogic_audio;
#include maps/mp/gametypes/_globallogic_score;
#include maps/mp/gametypes/_hud_util;
#include maps/mp/gametypes/_spawning;
#include maps/mp/gametypes/_spawnlogic;

//Function Number: 1
main()
{
	maps/mp/gametypes/_globallogic::init();
	maps/mp/gametypes/_callbacksetup::setupcallbacks();
	maps/mp/gametypes/_globallogic::setupcallbacks();
	registertimelimit(0,1440);
	registerscorelimit(0,50000);
	registerroundlimit(0,10);
	registerroundwinlimit(0,10);
	registernumlives(0,100);
	maps/mp/gametypes/_globallogic::registerfriendlyfiredelay(level.gametype,0,0,1440);
	level.scoreroundbased = getgametypesetting("roundscorecarry") == 0;
	level.teamscoreperkill = getgametypesetting("teamScorePerKill");
	level.teamscoreperdeath = getgametypesetting("teamScorePerDeath");
	level.teamscoreperheadshot = getgametypesetting("teamScorePerHeadshot");
	level.onstartgametype = ::onstartgametype;
	level.onspawnplayer = ::onspawnplayer;
	level.onspawnplayerunified = ::onspawnplayerunified;
	level.onplayerkilled = ::onplayerkilled;
	game["dialog"]["gametype"] = "ffa_start";
	game["dialog"]["gametype_hardcore"] = "hcffa_start";
	game["dialog"]["offense_obj"] = "generic_boost";
	game["dialog"]["defense_obj"] = "generic_boost";
	setscoreboardcolumns("pointstowin","kills","deaths","headshots","score");
}

//Function Number: 2
onstartgametype()
{
	setclientnamemode("auto_change");
	setobjectivetext("allies",&"OBJECTIVES_DM");
	setobjectivetext("axis",&"OBJECTIVES_DM");
	if(level.splitscreen)
	{
		setobjectivescoretext("allies",&"OBJECTIVES_DM");
		setobjectivescoretext("axis",&"OBJECTIVES_DM");
	}
	else
	{
		setobjectivescoretext("allies",&"OBJECTIVES_DM_SCORE");
		setobjectivescoretext("axis",&"OBJECTIVES_DM_SCORE");
	}

	setobjectivehinttext("allies",&"OBJECTIVES_DM_HINT");
	setobjectivehinttext("axis",&"OBJECTIVES_DM_HINT");
	allowed[0] = "dm";
	maps/mp/gametypes/_gameobjects::main(allowed);
	maps/mp/gametypes/_spawning::create_map_placed_influencers();
	level.spawnmins = (0,0,0);
	level.spawnmaxs = (0,0,0);
	maps/mp/gametypes/_spawnlogic::addspawnpoints("allies","mp_dm_spawn");
	maps/mp/gametypes/_spawnlogic::addspawnpoints("axis","mp_dm_spawn");
	maps/mp/gametypes/_spawning::updateallspawnpoints();
	level.mapcenter = maps/mp/gametypes/_spawnlogic::findboxcenter(level.spawnmins,level.spawnmaxs);
	setmapcenter(level.mapcenter);
	spawnpoint = maps/mp/gametypes/_spawnlogic::getrandomintermissionpoint();
	setdemointermissionpoint(spawnpoint.origin,spawnpoint.angles);
	level.usestartspawns = 0;
	level.displayroundendtext = 0;
	level thread onscoreclosemusic();
	if(!(isoneround()))
	{
		level.displayroundendtext = 1;
	}
}

//Function Number: 3
onspawnplayerunified()
{
	maps/mp/gametypes/_spawning::onspawnplayer_unified();
}

//Function Number: 4
onspawnplayer(predictedspawn)
{
	spawnpoints = maps/mp/gametypes/_spawnlogic::getteamspawnpoints(self.pers["team"]);
	spawnpoint = maps/mp/gametypes/_spawnlogic::getspawnpoint_dm(spawnpoints);
	if(predictedspawn)
	{
		self predictspawnpoint(spawnpoint.origin,spawnpoint.angles);
	}
	else
	{
		self spawn(spawnpoint.origin,spawnpoint.angles,"dm");
	}
}

//Function Number: 5
onendgame(winningplayer)
{
	if(IsDefined(winningplayer) && isplayer(winningplayer))
	{
		[[ level._setplayerscore ]](winningplayer,winningplayer [[ level._getplayerscore ]]() + 1);
	}
}

//Function Number: 6
onscoreclosemusic()
{
	while(!(level.gameended))
	{
		scorelimit = level.scorelimit;
		scorethreshold = scorelimit * 0.9;
		for(i = 0;i < level.players.size;i++)
		{
			scorecheck = [[ level._getplayerscore ]](level.players[i]);
			if(scorecheck >= scorethreshold)
			{
				thread maps/mp/gametypes/_globallogic_audio::set_music_on_team("TIME_OUT","both");
				thread maps/mp/gametypes/_globallogic_audio::actionmusicset();
				return;
			}
		}

		wait(0.5);
	}
}

//Function Number: 7
onplayerkilled(einflictor,attacker,idamage,smeansofdeath,sweapon,vdir,shitloc,psoffsettime,deathanimduration)
{
	if(!isplayer(attacker) || self == attacker)
	{
		return;
	}

	attacker maps/mp/gametypes/_globallogic_score::givepointstowin(level.teamscoreperkill);
	self maps/mp/gametypes/_globallogic_score::givepointstowin(level.teamscoreperdeath * -1);
	if(smeansofdeath == "MOD_HEAD_SHOT")
	{
		attacker maps/mp/gametypes/_globallogic_score::givepointstowin(level.teamscoreperheadshot);
	}
}