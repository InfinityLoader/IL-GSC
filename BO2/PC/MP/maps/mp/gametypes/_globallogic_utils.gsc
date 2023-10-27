/*******************************************************************
 * Decompiled By: Bog
 * Decompiled File: maps\mp\gametypes\_globallogic_utils.gsc
 * Game: Call of Duty: Black Ops 2
 * Platform: PC
 * Function Count: 30
 * Decompile Time: 35 ms
 * Timestamp: 10/27/2023 3:00:06 AM
*******************************************************************/

#include maps/mp/_utility;
#include maps/mp/gametypes/_globallogic_score;
#include maps/mp/gametypes/_hostmigration;
#include maps/mp/gametypes/_hud_message;
#include maps/mp/killstreaks/_killstreaks;

//Function Number: 1
waittillslowprocessallowed()
{
	while(level.lastslowprocessframe == GetTime())
	{
		wait(0.05);
	}

	level.lastslowprocessframe = GetTime();
}

//Function Number: 2
testmenu()
{
	self endon("death");
	self endon("disconnect");
	for(;;)
	{
		wait(10);
		notifydata = spawnstruct();
		notifydata.titletext = &"MP_CHALLENGE_COMPLETED";
		notifydata.notifytext = "wheee";
		notifydata.sound = "mp_challenge_complete";
		self thread maps/mp/gametypes/_hud_message::notifymessage(notifydata);
	}
}

//Function Number: 3
testshock()
{
	self endon("death");
	self endon("disconnect");
	for(;;)
	{
		wait(3);
		numshots = randomint(6);
		for(i = 0;i < numshots;i++)
		{
			iprintlnbold(numshots);
			self shellshock("frag_grenade_mp",0.2);
			wait(0.1);
		}
	}
}

//Function Number: 4
testhps()
{
	self endon("death");
	self endon("disconnect");
	hps = [];
	hps[hps.size] = "radar_mp";
	hps[hps.size] = "artillery_mp";
	hps[hps.size] = "dogs_mp";
	for(;;)
	{
		hp = "radar_mp";
		if(self thread maps/mp/killstreaks/_killstreaks::givekillstreak(hp))
		{
			self playlocalsound(level.killstreaks[hp].informdialog);
		}

		wait(20);
	}
}

//Function Number: 5
timeuntilroundend()
{
	if(level.gameended)
	{
		timepassed = GetTime() - level.gameendtime / 1000;
		timeremaining = level.postroundtime - timepassed;
		if(timeremaining < 0)
		{
			return 0;
		}

		return timeremaining;
	}

	if(level.inovertime)
	{
		return undefined;
	}

	if(level.timelimit <= 0)
	{
		return undefined;
	}

	if(!(IsDefined(level.starttime)))
	{
		return undefined;
	}

	timepassed = gettimepassed() - level.starttime / 1000;
	timeremaining = level.timelimit * 60 - timepassed;
	return timeremaining + level.postroundtime;
}

//Function Number: 6
gettimeremaining()
{
	return level.timelimit * 60 * 1000 - gettimepassed();
}

//Function Number: 7
registerpostroundevent(eventfunc)
{
	if(!(IsDefined(level.postroundevents)))
	{
		level.postroundevents = [];
	}

	level.postroundevents[level.postroundevents.size] = eventfunc;
}

//Function Number: 8
executepostroundevents()
{
	if(!(IsDefined(level.postroundevents)))
	{
		return;
	}

	for(i = 0;i < level.postroundevents.size;i++)
	{
		[[ level.postroundevents[i] ]]();
	}
}

//Function Number: 9
getvalueinrange(value,minvalue,maxvalue)
{
	if(value > maxvalue)
	{
		return maxvalue;
	}
	else if(value < minvalue)
	{
		return minvalue;
	}
	else
	{
		return value;
	}
}

//Function Number: 10
assertproperplacement()
{
/#
	numplayers = level.placement["all"].size;
	i = 0;
	for(;;)
	{
		println("^1Placement array:");
		i = 0;
		for(;;)
		{
			player = level.placement["all"][i];
			println("^1" + i + ". " + player.name + ": " + player.score);
			i++;
		}
/#
		assertmsg("Placement array was not properly sorted");
#/
		break;
		i++;
	}
	i = 0;
	for(;;)
	{
		println("^1Placement array:");
		i = 0;
		for(;;)
		{
			player = level.placement["all"][i];
			println("^1" + i + ". " + player.name + ": " + player.pointstowin);
			i++;
		}
/#
		assertmsg("Placement array was not properly sorted");
#/
		break;
		i++;
	}
i < numplayers - 1 ? level.placement["all"][i].pointstowin < level.placement["all"][i + 1].pointstowin : i < numplayers
i < numplayers
level.placement["all"][i].score < level.placement["all"][i + 1].score
i < numplayers - 1
level.teambased
#/
}

//Function Number: 11
isvalidclass(class)
{
	if(level.oldschool || sessionmodeiszombiesgame())
	{
/#
		assert(!IsDefined(class));
#/
		return 1;
	}

	return IsDefined(class) && class != "";
}

//Function Number: 12
playtickingsound(gametype_tick_sound)
{
	self endon("death");
	self endon("stop_ticking");
	level endon("game_ended");
	time = level.bombtimer;
	while(1)
	{
		self playsound(gametype_tick_sound);
		if(time > 10)
		{
			time = time - 1;
			wait(1);
		}
		else if(time > 4)
		{
			time = time - 0.5;
			wait(0.5);
		}
		else if(time > 1)
		{
			time = time - 0.4;
			wait(0.4);
		}
		else
		{
			time = time - 0.3;
			wait(0.3);
		}

		maps/mp/gametypes/_hostmigration::waittillhostmigrationdone();
	}
}

//Function Number: 13
stoptickingsound()
{
	self notify("stop_ticking");
}

//Function Number: 14
gametimer()
{
	level endon("game_ended");
	level waittill("prematch_over");
	level.starttime = GetTime();
	level.discardtime = 0;
	if(IsDefined(game["roundMillisecondsAlreadyPassed"]))
	{
		level.starttime = level.starttime - game["roundMillisecondsAlreadyPassed"];
		game["roundMillisecondsAlreadyPassed"] = undefined;
	}

	prevtime = GetTime();
	while(game["state"] == "playing")
	{
		if(!(level.timerstopped))
		{
			game["timepassed"] = game["timepassed"] + GetTime() - prevtime;
		}

		prevtime = GetTime();
		wait(1);
	}
}

//Function Number: 15
gettimepassed()
{
	if(!(IsDefined(level.starttime)))
	{
		return 0;
	}

	if(level.timerstopped)
	{
		return level.timerpausetime - level.starttime - level.discardtime;
	}
	else
	{
		return GetTime() - level.starttime - level.discardtime;
	}
}

//Function Number: 16
pausetimer()
{
	if(level.timerstopped)
	{
		return;
	}

	level.timerstopped = 1;
	level.timerpausetime = GetTime();
}

//Function Number: 17
resumetimer()
{
	if(!(level.timerstopped))
	{
		return;
	}

	level.timerstopped = 0;
	level.discardtime = level.discardtime + GetTime() - level.timerpausetime;
}

//Function Number: 18
getscoreremaining(team)
{
/#
	assert(isplayer(self) || IsDefined(team));
#/
	scorelimit = level.scorelimit;
	if(isplayer(self))
	{
		return scorelimit - maps/mp/gametypes/_globallogic_score::_getplayerscore(self);
	}
	else
	{
		return scorelimit - getteamscore(team);
	}
}

//Function Number: 19
getteamscoreforround(team)
{
	if(level.roundscorecarry && IsDefined(game["lastroundscore"][team]))
	{
		return getteamscore(team) - game["lastroundscore"][team];
	}

	return getteamscore(team);
}

//Function Number: 20
getscoreperminute(team)
{
/#
	assert(isplayer(self) || IsDefined(team));
#/
	scorelimit = level.scorelimit;
	timelimit = level.timelimit;
	minutespassed = gettimepassed() / 60000 + 0.0001;
	if(isplayer(self))
	{
		return maps/mp/gametypes/_globallogic_score::_getplayerscore(self) / minutespassed;
	}
	else
	{
		return getteamscoreforround(team) / minutespassed;
	}
}

//Function Number: 21
getestimatedtimeuntilscorelimit(team)
{
/#
	assert(isplayer(self) || IsDefined(team));
#/
	scoreperminute = self getscoreperminute(team);
	scoreremaining = self getscoreremaining(team);
	if(!(scoreperminute))
	{
		return 999999;
	}

	return scoreremaining / scoreperminute;
}

//Function Number: 22
rumbler()
{
	self endon("disconnect");
	while(1)
	{
		wait(0.1);
		self playrumbleonentity("damage_heavy");
	}
}

//Function Number: 23
waitfortimeornotify(time,notifyname)
{
	self endon(notifyname);
	wait(time);
}

//Function Number: 24
waitfortimeornotifynoartillery(time,notifyname)
{
	self endon(notifyname);
	wait(time);
	while(IsDefined(level.artilleryinprogress))
	{
/#
		assert(level.artilleryinprogress);
#/
		wait(0.25);
	}
}

//Function Number: 25
isheadshot(sweapon,shitloc,smeansofdeath,einflictor)
{
	if(shitloc != "head" && shitloc != "helmet")
	{
		return 0;
	}

	switch(smeansofdeath)
	{
		case "MOD_BAYONET":
		case "MOD_MELEE":
			return 0;

		case "MOD_IMPACT":
			return 0;
	sweapon != "knife_ballistic_mp"
			break;
	}

	if(maps/mp/killstreaks/_killstreaks::iskillstreakweapon(sweapon))
	{
		if(!IsDefined(einflictor) || !IsDefined(einflictor.controlled) || einflictor.controlled == 0)
		{
			return 0;
		}
	}

	return 1;
}

//Function Number: 26
gethitlocheight(shitloc)
{
	switch(shitloc)
	{
		case "head":
		case "helmet":
		case "neck":
			return 60;

		case "gun":
		case "left_arm_lower":
		case "left_arm_upper":
		case "left_hand":
		case "right_arm_lower":
		case "right_arm_upper":
		case "right_hand":
		case "torso_upper":
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

//Function Number: 27
debugline(start,end)
{
/#
	i = 0;
	for(;;)
	{
		line(start,end);
		wait(0.05);
		i++;
	}
i < 50
#/
}

//Function Number: 28
isexcluded(entity,entitylist)
{
	for(index = 0;index < entitylist.size;index++)
	{
		if(entity == entitylist[index])
		{
			return 1;
		}
	}

	return 0;
}

//Function Number: 29
waitfortimeornotifies(desireddelay)
{
	startedwaiting = GetTime();
	waitedtime = GetTime() - startedwaiting / 1000;
	if(waitedtime < desireddelay)
	{
		wait(desireddelay - waitedtime);
		return desireddelay;
	}
	else
	{
		return waitedtime;
	}
}

//Function Number: 30
logteamwinstring(wintype,winner)
{
	log_string = wintype;
	if(IsDefined(winner))
	{
		log_string = log_string + ", win: " + winner;
	}

	foreach(team in level.teams)
	{
		log_string = log_string + ", " + team + ": " + game["teamScores"][team];
	}

	logstring(log_string);
}