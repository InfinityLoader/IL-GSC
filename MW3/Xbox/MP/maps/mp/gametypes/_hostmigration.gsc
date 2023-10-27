/*******************************************************************
 * Decompiled By: Bog
 * Decompiled File: maps\mp\gametypes\_hostmigration.gsc
 * Game: Call of Duty: Modern Warfare 3
 * Platform: Console
 * Function Count: 9
 * Decompile Time: 124 ms
 * Timestamp: 10/27/2023 2:25:30 AM
*******************************************************************/

//Function Number: 1
callback_hostmigration()
{
	level.hostmigrationreturnedplayercount = 0;
	if(level.gameended)
	{
		return;
	}

	level.hostmigrationtimer = 1;
	setdvar("ui_inhostmigration",1);
	level notify("host_migration_begin");
	maps\mp\gametypes\_gamelogic::updatetimerpausedness();
	foreach(var_01 in level.players)
	{
		var_01 thread func_273D();
	}

	level endon("host_migration_begin");
	func_2735();
	level.hostmigrationtimer = undefined;
	setdvar("ui_inhostmigration",0);
	level notify("host_migration_end");
	maps\mp\gametypes\_gamelogic::updatetimerpausedness();
	level thread maps\mp\gametypes\_gamelogic::func_2734();
}

//Function Number: 2
func_2735()
{
	level endon("game_ended");
	level.ingraceperiod = 25;
	thread maps\mp\gametypes\_gamelogic::matchstarttimer("waiting_for_players",20);
	hostmigrationwaitforplayers();
	level.ingraceperiod = 10;
	thread maps\mp\gametypes\_gamelogic::matchstarttimer("match_resuming_in",5);
	wait 5;
	level.ingraceperiod = 0;
}

//Function Number: 3
hostmigrationwaitforplayers()
{
	level endon("hostmigration_enoughplayers");
	wait 15;
}

//Function Number: 4
func_2739()
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

//Function Number: 5
func_273D()
{
	self endon("disconnect");
	self setclientdvar("cg_scoreboardPingGraph","0");
	func_2739();
	if(self.hostmigrationcontrolsfrozen)
	{
		maps\mp\_utility::freezecontrolswrapper(0);
	}

	self setclientdvar("cg_scoreboardPingGraph","1");
}

//Function Number: 6
func_273E()
{
	if(!isdefined(level.hostmigrationtimer))
	{
		return 0;
	}

	var_00 = gettime();
	level waittill("host_migration_end");
	return gettime() - var_00;
}

//Function Number: 7
func_273F(param_00)
{
	if(isdefined(level.hostmigrationtimer))
	{
		return;
	}

	level endon("host_migration_begin");
	wait param_00;
}

//Function Number: 8
func_2740(param_00)
{
	if(param_00 == 0)
	{
		return;
	}

	var_01 = gettime();
	var_02 = gettime() + param_00 * 1000;
	while(gettime() < var_02)
	{
		func_273F(var_02 - gettime() / 1000);
		if(isdefined(level.hostmigrationtimer))
		{
			var_03 = func_273E();
			var_02 = var_02 + var_03;
		}
	}

	func_273E();
	return gettime() - var_01;
}

//Function Number: 9
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
		func_273F(var_02 - gettime() / 1000);
		while(isdefined(level.hostmigrationtimer))
		{
			var_02 = var_02 + 1000;
			setgameendtime(int(var_02));
			wait 1;
		}
	}

	while(isdefined(level.hostmigrationtimer))
	{
		var_02 = var_02 + 1000;
		setgameendtime(int(var_02));
		wait 1;
	}

	return gettime() - var_01;
}