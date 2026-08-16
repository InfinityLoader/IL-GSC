/*******************************************************************
 * Decompiled By: Bog
 * Decompiled File: maps\mp\gametypes\_hostmigration.gsc
 * Game: Call of Duty: Modern Warfare 2
 * Platform: PC
*******************************************************************/

callback_hostmigration()
{
	level.hostmigrationreturnedplayercount = 0;
	if(level.gameended)
	{
		return;
	}

	level.hostmigrationtimer = 1;
	level notify("host_migration_begin");
	maps\mp\gametypes\_gamelogic::updatetimerpausedness();
	foreach(player in level.players)
	{
		player thread hostmigrationtimerthink();
	}

	level endon("host_migration_begin");
	hostmigrationwait();
	level.hostmigrationtimer = undefined;
	level notify("host_migration_end");
	maps\mp\gametypes\_gamelogic::updatetimerpausedness();
}

hostmigrationwait()
{
	level endon("game_ended");
	level endon("nuke_death");
	thread maps\mp\gametypes\_gamelogic::matchstarttimer("waiting_for_players", 20);
	hostmigrationwaitforplayers();
	thread maps\mp\gametypes\_gamelogic::matchstarttimer("match_resuming_in", 5);
	wait 5;
}

hostmigrationwaitforplayers()
{
	level endon("hostmigration_enoughplayers");
	wait 15;
}

hostmigrationtimerthink_internal()
{
	level endon("host_migration_begin");
	level endon("host_migration_end");
	self.hostmigrationcontrolsfrozen = 0;
	while(!maps\mp\_utility::isreallyalive(self))
	{
		self waittill("spawned");
	}

	self.hostmigrationcontrolsfrozen = 1;
	maps\mp\_utility::freezecontrolswrapper(1);
	level waittill("host_migration_end");
}

hostmigrationtimerthink()
{
	self endon("disconnect");
	self setclientdvar("cg_scoreboardPingGraph", "0");
	hostmigrationtimerthink_internal();
	if(self.hostmigrationcontrolsfrozen)
	{
		maps\mp\_utility::freezecontrolswrapper(0);
	}

	self setclientdvar("cg_scoreboardPingGraph", "1");
}

waittillhostmigrationdone()
{
	if(!isdefined(level.hostmigrationtimer))
	{
		return 0;
	}

	starttime = gettime();
	level waittill("host_migration_end");
	return gettime() - starttime;
}

waittillhostmigrationstarts(duration)
{
	if(isdefined(level.hostmigrationtimer))
	{
		return;
	}

	level endon("host_migration_begin");
	wait duration;
}

waitlongdurationwithhostmigrationpause(duration)
{
	if(duration == 0)
	{
		return;
	}

	starttime = gettime();
	endtime = gettime() + duration * 1000;
	while(gettime() < endtime)
	{
		waittillhostmigrationstarts(endtime - gettime() / 1000);
		if(isdefined(level.hostmigrationtimer))
		{
			timepassed = waittillhostmigrationdone();
			endtime = endtime + timepassed;
		}
	}

	waittillhostmigrationdone();
	return gettime() - starttime;
}

waitlongdurationwithgameendtimeupdate(duration)
{
	if(duration == 0)
	{
		return;
	}

	starttime = gettime();
	endtime = gettime() + duration * 1000;
	while(gettime() < endtime)
	{
		waittillhostmigrationstarts(endtime - gettime() / 1000);
		while(isdefined(level.hostmigrationtimer))
		{
			endtime = endtime + 1000;
			setgameendtime(int(endtime));
			wait 1;
		}
	}

	while(isdefined(level.hostmigrationtimer))
	{
		endtime = endtime + 1000;
		setgameendtime(int(endtime));
		wait 1;
	}

	return gettime() - starttime;
}