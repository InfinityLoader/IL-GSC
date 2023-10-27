/*******************************************************************
 * Decompiled By: Bog
 * Decompiled File: maps\mp\gametypes\_hostmigration.gsc
 * Game: Call of Duty: Modern Warfare Remastered
 * Platform: PC
 * Function Count: 11
 * Decompile Time: 195 ms
 * Timestamp: 10/27/2023 2:41:36 AM
*******************************************************************/

//Function Number: 1
callback_hostmigration()
{
	level.hostmigrationreturnedplayercount = 0;
	if(level.gameended)
	{
		return;
	}

	var_00 = getmatchdata("hostMigrationCount");
	var_00++;
	setmatchdata("hostMigrationCount",var_00);
	foreach(var_02 in level.characters)
	{
		var_02.hostmigrationcontrolsfrozen = 0;
	}

	level.hostmigrationtimer = 1;
	setdvar("ui_inhostmigration",1);
	level notify("host_migration_begin");
	maps\mp\gametypes\_gamelogic::updatetimerpausedness();
	foreach(var_02 in level.characters)
	{
		var_02 thread hostmigrationtimerthink();
		if(isplayer(var_02))
		{
			var_02 setclientomnvar("ui_session_state",var_02.sessionstate);
		}
	}

	setdvar("ui_game_state",game["state"]);
	level endon("host_migration_begin");
	hostmigrationwait();
	level.hostmigrationtimer = undefined;
	setdvar("ui_inhostmigration",0);
	level notify("host_migration_end");
	maps\mp\gametypes\_gamelogic::updatetimerpausedness();
	level thread maps\mp\gametypes\_gamelogic::updategameevents();
}

//Function Number: 2
hostmigrationwait()
{
	level endon("game_ended");
	level.ingraceperiod = 25;
	thread maps\mp\gametypes\_gamelogic::matchstarttimer(20);
	hostmigrationwaitforplayers();
	level.ingraceperiod = 10;
	thread maps\mp\gametypes\_gamelogic::matchstarttimer(5);
	wait(5);
	level.ingraceperiod = 0;
}

//Function Number: 3
hostmigrationwaitforplayers()
{
	level endon("hostmigration_enoughplayers");
	wait(15);
}

//Function Number: 4
hostmigrationname(param_00)
{
	if(!isdefined(param_00))
	{
		return "<removed_ent>";
	}

	var_01 = -1;
	var_02 = "?";
	if(isdefined(param_00.entity_number))
	{
		var_01 = param_00.entity_number;
	}

	if(isplayer(param_00) && isdefined(param_00.name))
	{
		var_02 = param_00.name;
	}

	if(isplayer(param_00))
	{
		return "player <" + var_02 + "> (entNum " + var_01 + " )";
	}

	if(isagent(param_00) && maps\mp\_utility::isgameparticipant(param_00))
	{
		return "participant agent <" + var_01 + ">";
	}

	if(isagent(param_00))
	{
		return "non-participant agent <" + var_01 + ">";
	}

	return "unknown entity <" + var_01 + ">";
}

//Function Number: 5
hostmigrationtimerthink_internal()
{
	level endon("host_migration_begin");
	level endon("host_migration_end");
	self endon("disconnect");
	self.hostmigrationcontrolsfrozen = 1;
	while(!maps\mp\_utility::isreallyalive(self))
	{
		self waittill("spawned");
	}

	maps\mp\_utility::freezecontrolswrapper(1);
	self disableammogeneration();
	level waittill("host_migration_end");
}

//Function Number: 6
hostmigrationtimerthink()
{
	level endon("host_migration_begin");
	self endon("disconnect");
	if(isagent(self))
	{
		self endon("death");
	}

	hostmigrationtimerthink_internal();
	if(self.hostmigrationcontrolsfrozen)
	{
		if(maps\mp\_utility::gameflag("prematch_done"))
		{
			maps\mp\_utility::freezecontrolswrapper(0);
			self enableammogeneration();
		}

		self.hostmigrationcontrolsfrozen = undefined;
	}
}

//Function Number: 7
waittillhostmigrationdone()
{
	if(!isdefined(level.hostmigrationtimer))
	{
		return 0;
	}

	var_00 = gettime();
	level waittill("host_migration_end");
	return gettime() - var_00;
}

//Function Number: 8
waittillhostmigrationstarts(param_00)
{
	if(isdefined(level.hostmigrationtimer))
	{
		return;
	}

	level endon("host_migration_begin");
	wait(param_00);
}

//Function Number: 9
waitlongdurationwithhostmigrationpause(param_00)
{
	if(param_00 == 0)
	{
		return;
	}

	var_01 = gettime();
	var_02 = gettime() + param_00 * 1000;
	while(gettime() < var_02)
	{
		waittillhostmigrationstarts(var_02 - gettime() / 1000);
		if(isdefined(level.hostmigrationtimer))
		{
			var_03 = waittillhostmigrationdone();
			var_02 = var_02 + var_03;
		}
	}

	waittillhostmigrationdone();
	return gettime() - var_01;
}

//Function Number: 10
waittill_notify_or_timeout_hostmigration_pause(param_00,param_01)
{
	self endon(param_00);
	if(param_01 == 0)
	{
		return;
	}

	var_02 = gettime();
	var_03 = gettime() + param_01 * 1000;
	while(gettime() < var_03)
	{
		waittillhostmigrationstarts(var_03 - gettime() / 1000);
		if(isdefined(level.hostmigrationtimer))
		{
			var_04 = waittillhostmigrationdone();
			var_03 = var_03 + var_04;
		}
	}

	waittillhostmigrationdone();
	return gettime() - var_02;
}

//Function Number: 11
waitlongdurationwithgameendtimeupdate(param_00)
{
	if(param_00 == 0)
	{
		return;
	}

	var_01 = gettime();
	var_02 = gettime() + param_00 * 1000;
	while(gettime() < var_02)
	{
		waittillhostmigrationstarts(var_02 - gettime() / 1000);
		while(isdefined(level.hostmigrationtimer))
		{
			var_02 = var_02 + 1000;
			setgameendtime(int(var_02));
			wait(1);
		}
	}

	while(isdefined(level.hostmigrationtimer))
	{
		var_02 = var_02 + 1000;
		setgameendtime(int(var_02));
		wait(1);
	}

	return gettime() - var_01;
}