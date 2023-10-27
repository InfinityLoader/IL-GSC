/*******************************************************************
 * Decompiled By: Bog
 * Decompiled File: maps\mp\gametypes\_hostmigration.gsc
 * Game: Call of Duty: Black Ops 2
 * Platform: PC
 * Function Count: 19
 * Decompile Time: 31 ms
 * Timestamp: 10/27/2023 3:00:07 AM
*******************************************************************/

#include common_scripts/utility;
#include maps/mp/_utility;
#include maps/mp/gametypes/_hud;
#include maps/mp/gametypes/_hud_util;

//Function Number: 1
debug_script_structs()
{
/#
	println("*** Num structs " + level.struct.size);
	println("");
	i = 0;
	for(;;)
	{
		struct = level.struct[i];
		println("---" + i + " : " + struct.targetname);
		println("---" + i + " : " + "NONE");
		i++;
	}
	println("*** No structs defined.");
Stack-Empty ? Stack-Empty : ((IsDefined(level.struct)) ? i < level.struct.size : IsDefined(struct.targetname))
#/
}

//Function Number: 2
updatetimerpausedness()
{
	shouldbestopped = IsDefined(level.hostmigrationtimer);
	if(!level.timerstopped && shouldbestopped)
	{
		level.timerstopped = 1;
		level.timerpausetime = GetTime();
	}
	else if(level.timerstopped && !shouldbestopped)
	{
		level.timerstopped = 0;
		level.discardtime = level.discardtime + GetTime() - level.timerpausetime;
	}
}

//Function Number: 3
callback_hostmigrationsave()
{
}

//Function Number: 4
pausetimer()
{
	level.migrationtimerpausetime = GetTime();
}

//Function Number: 5
resumetimer()
{
	level.discardtime = level.discardtime + GetTime() - level.migrationtimerpausetime;
}

//Function Number: 6
locktimer()
{
	level endon("host_migration_begin");
	level endon("host_migration_end");
	for(;;)
	{
		currtime = GetTime();
		wait(0.05);
		if(!level.timerstopped && IsDefined(level.discardtime))
		{
			level.discardtime = level.discardtime + GetTime() - currtime;
		}
	}
}

//Function Number: 7
callback_hostmigration()
{
	setslowmotion(1,1,0);
	makedvarserverinfo("ui_guncycle",0);
	level.hostmigrationreturnedplayercount = 0;
	if(level.inprematchperiod)
	{
		level waittill("prematch_over");
	}

	if(level.gameended)
	{
/#
		println("Migration starting at time " + GetTime() + ", but game has ended, so no countdown.");
#/
		return;
	}

/#
	println("Migration starting at time " + GetTime());
#/
	level.hostmigrationtimer = 1;
	sethostmigrationstatus(1);
	level notify("host_migration_begin");
	thread locktimer();
	players = level.players;
	for(i = 0;i < players.size;i++)
	{
		player = players[i];
		player thread hostmigrationtimerthink();
	}

	level endon("host_migration_begin");
	hostmigrationwait();
	level.hostmigrationtimer = undefined;
	sethostmigrationstatus(0);
/#
	println("Migration finished at time " + GetTime());
#/
	recordmatchbegin();
	level notify("host_migration_end");
}

//Function Number: 8
matchstarttimerconsole_internal(counttime,matchstarttimer)
{
	waittillframeend;
	visionsetnaked("mpIntro",0);
	level endon("match_start_timer_beginning");
	while(counttime > 0 && !level.gameended)
	{
		matchstarttimer thread maps/mp/gametypes/_hud::fontpulse(level);
		wait(matchstarttimer.inframes * 0.05);
		matchstarttimer setvalue(counttime);
		if(counttime == 2)
		{
			visionsetnaked(GetDvar(#"B4B895C4"),3);
		}

		counttime--;
		wait(1 - matchstarttimer.inframes * 0.05);
	}
}

//Function Number: 9
matchstarttimerconsole(type,duration)
{
	level notify("match_start_timer_beginning");
	wait(0.05);
	matchstarttext = createserverfontstring("objective",1.5);
	matchstarttext setpoint("CENTER","CENTER",0,-40);
	matchstarttext.sort = 1001;
	matchstarttext settext(game["strings"]["waiting_for_teams"]);
	matchstarttext.foreground = 0;
	matchstarttext.hidewheninmenu = 1;
	matchstarttext settext(game["strings"][type]);
	matchstarttimer = createserverfontstring("objective",2.2);
	matchstarttimer setpoint("CENTER","CENTER",0,0);
	matchstarttimer.sort = 1001;
	matchstarttimer.color = (1,1,0);
	matchstarttimer.foreground = 0;
	matchstarttimer.hidewheninmenu = 1;
	matchstarttimer maps/mp/gametypes/_hud::fontpulseinit();
	counttime = int(duration);
	if(counttime >= 2)
	{
		matchstarttimerconsole_internal(counttime,matchstarttimer);
		visionsetnaked(GetDvar(#"B4B895C4"),3);
	}
	else
	{
		visionsetnaked("mpIntro",0);
		visionsetnaked(GetDvar(#"B4B895C4"),1);
	}

	matchstarttimer destroyelem();
	matchstarttext destroyelem();
}

//Function Number: 10
hostmigrationwait()
{
	level endon("game_ended");
	if(level.hostmigrationreturnedplayercount < level.players.size * 2 / 3)
	{
		thread matchstarttimerconsole("waiting_for_teams",20);
		hostmigrationwaitforplayers();
	}

	level notify("host_migration_countdown_begin");
	thread matchstarttimerconsole("match_starting_in",5);
	wait(5);
}

//Function Number: 11
waittillhostmigrationcountdown()
{
	level endon("host_migration_end");
	if(!(IsDefined(level.hostmigrationtimer)))
	{
		return;
	}

	level waittill("host_migration_countdown_begin");
}

//Function Number: 12
hostmigrationwaitforplayers()
{
	level endon("hostmigration_enoughplayers");
	wait(15);
}

//Function Number: 13
hostmigrationtimerthink_internal()
{
	level endon("host_migration_begin");
	level endon("host_migration_end");
	self.hostmigrationcontrolsfrozen = 0;
	while(!(isalive(self)))
	{
		self waittill("spawned");
	}

	self.hostmigrationcontrolsfrozen = 1;
	self freezecontrols(1);
	level waittill("host_migration_end");
}

//Function Number: 14
hostmigrationtimerthink()
{
	self endon("disconnect");
	level endon("host_migration_begin");
	hostmigrationtimerthink_internal();
	if(self.hostmigrationcontrolsfrozen)
	{
		self freezecontrols(0);
	}
}

//Function Number: 15
waittillhostmigrationdone()
{
	if(!(IsDefined(level.hostmigrationtimer)))
	{
		return 0;
	}

	starttime = GetTime();
	level waittill("host_migration_end");
	return GetTime() - starttime;
}

//Function Number: 16
waittillhostmigrationstarts(duration)
{
	if(IsDefined(level.hostmigrationtimer))
	{
		return;
	}

	level endon("host_migration_begin");
	wait(duration);
}

//Function Number: 17
waitlongdurationwithhostmigrationpause(duration)
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
		waittillhostmigrationstarts(endtime - GetTime() / 1000);
		if(IsDefined(level.hostmigrationtimer))
		{
			timepassed = waittillhostmigrationdone();
			endtime = endtime + timepassed;
		}
	}

/#
	println("SCRIPT WARNING: gettime() = " + GetTime() + " NOT EQUAL TO endtime = " + endtime);
GetTime() != endtime
#/
	waittillhostmigrationdone();
	return GetTime() - starttime;
}

//Function Number: 18
waitlongdurationwithhostmigrationpauseemp(duration)
{
	if(duration == 0)
	{
		return;
	}

/#
	assert(duration > 0);
#/
	starttime = GetTime();
	empendtime = GetTime() + duration * 1000;
	level.empendtime = empendtime;
	while(GetTime() < empendtime)
	{
		waittillhostmigrationstarts(empendtime - GetTime() / 1000);
		if(IsDefined(level.hostmigrationtimer))
		{
			timepassed = waittillhostmigrationdone();
			if(IsDefined(empendtime))
			{
				empendtime = empendtime + timepassed;
			}
		}
	}

/#
	println("SCRIPT WARNING: gettime() = " + GetTime() + " NOT EQUAL TO empendtime = " + empendtime);
GetTime() != empendtime
#/
	waittillhostmigrationdone();
	level.empendtime = undefined;
	return GetTime() - starttime;
}

//Function Number: 19
waitlongdurationwithgameendtimeupdate(duration)
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
		waittillhostmigrationstarts(endtime - GetTime() / 1000);
		while(IsDefined(level.hostmigrationtimer))
		{
			endtime = endtime + 1000;
			setgameendtime(int(endtime));
			wait(1);
		}
	}

/#
	println("SCRIPT WARNING: gettime() = " + GetTime() + " NOT EQUAL TO endtime = " + endtime);
GetTime() != endtime
#/
	while(IsDefined(level.hostmigrationtimer))
	{
		endtime = endtime + 1000;
		setgameendtime(int(endtime));
		wait(1);
	}

	return GetTime() - starttime;
}