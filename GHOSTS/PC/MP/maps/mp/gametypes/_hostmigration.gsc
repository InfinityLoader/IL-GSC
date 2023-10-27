/*******************************************************************
 * Decompiled By: Bog
 * Decompiled File: maps\mp\gametypes\_hostmigration.gsc
 * Game: Call of Duty: Ghosts
 * Platform: PC
 * Function Count: 11
 * Decompile Time: 193 ms
 * Timestamp: 10/27/2023 1:18:28 AM
*******************************************************************/

//Function Number: 1
func_1945()
{
	if(maps\mp\_utility::func_47BB())
	{
		setnojiptime(1);
	}

	level.hostmigrationreturnedplayercount = 0;
	if(level.gameended)
	{
		return;
	}

	foreach(var_01 in level.characters)
	{
		var_01.hostmigrationcontrolsfrozen = 0;
	}

	level.hostmigrationtimer = 1;
	setdvar("ui_inhostmigration",1);
	level notify("host_migration_begin");
	maps\mp\gametypes\_gamelogic::updatetimerpausedness();
	foreach(var_01 in level.characters)
	{
		var_01 thread func_42CB();
		if(isplayer(var_01))
		{
			var_01 setclientomnvar("ui_session_state",var_01.sessionstate);
		}
	}

	setdvar("ui_game_state",game["state"]);
	level endon("host_migration_begin");
	func_42CD();
	level.hostmigrationtimer = undefined;
	setdvar("ui_inhostmigration",0);
	level notify("host_migration_end");
	maps\mp\gametypes\_gamelogic::updatetimerpausedness();
	level thread maps\mp\gametypes\_gamelogic::func_86EE();
	if(getdvar("squad_use_hosts_squad") == "1")
	{
		level thread lib_05D5::update_wargame_after_migration();
	}
}

//Function Number: 2
func_42CD()
{
	level endon("game_ended");
	level.ingraceperiod = 25;
	thread maps\mp\gametypes\_gamelogic::func_50C9("waiting_for_players",20);
	func_42CE();
	level.ingraceperiod = 10;
	thread maps\mp\gametypes\_gamelogic::func_50C9("match_resuming_in",5);
	wait(5);
	level.ingraceperiod = 0;
}

//Function Number: 3
func_42CE()
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
		return "player <" + var_02 + ">";
	}

	if(isagent(param_00) && maps\mp\_utility::func_48CE(param_00))
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
	while(!maps\mp\_utility::func_4945(self))
	{
		self waittill("spawned");
	}

	self.hostmigrationcontrolsfrozen = 1;
	maps\mp\_utility::func_350E(1);
	level waittill("host_migration_end");
}

//Function Number: 6
func_42CB()
{
	self endon("disconnect");
	if(isplayer(self))
	{
		self setclientdvar("cg_scoreboardPingGraph","0");
	}

	hostmigrationtimerthink_internal();
	if(self.hostmigrationcontrolsfrozen)
	{
		if(maps\mp\_utility::func_36F1("prematch_done"))
		{
			maps\mp\_utility::func_350E(0);
		}

		self.hostmigrationcontrolsfrozen = undefined;
	}

	if(isplayer(self))
	{
		self setclientdvar("cg_scoreboardPingGraph","1");
	}
}

//Function Number: 7
func_8BBA()
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
func_8BBB(param_00)
{
	if(isdefined(level.hostmigrationtimer))
	{
	}

	level endon("host_migration_begin");
	wait(param_00);
}

//Function Number: 9
func_8B0D(param_00)
{
	if(param_00 == 0)
	{
	}

	var_01 = gettime();
	var_02 = gettime() + param_00 * 1000;
	while(gettime() < var_02)
	{
		func_8BBB(var_02 - gettime() / 1000);
		if(isdefined(level.hostmigrationtimer))
		{
			var_03 = func_8BBA();
			var_02 = var_02 + var_03;
		}
	}

	func_8BBA();
	return gettime() - var_01;
}

//Function Number: 10
func_8B7D(param_00,param_01)
{
	self endon(param_00);
	if(param_01 == 0)
	{
	}

	var_02 = gettime();
	var_03 = gettime() + param_01 * 1000;
	while(gettime() < var_03)
	{
		func_8BBB(var_03 - gettime() / 1000);
		if(isdefined(level.hostmigrationtimer))
		{
			var_04 = func_8BBA();
			var_03 = var_03 + var_04;
		}
	}

	func_8BBA();
	return gettime() - var_02;
}

//Function Number: 11
func_8B0C(param_00)
{
	if(param_00 == 0)
	{
	}

	var_01 = gettime();
	var_02 = gettime() + param_00 * 1000;
	while(gettime() < var_02)
	{
		func_8BBB(var_02 - gettime() / 1000);
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