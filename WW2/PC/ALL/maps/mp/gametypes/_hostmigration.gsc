/*******************************************************************
 * Decompiled By: Bog
 * Decompiled File: maps\mp\gametypes\_hostmigration.gsc
 * Game: Call of Duty: WWII
 * Platform: PC
 * Function Count: 11
 * Decompile Time: 169 ms
 * Timestamp: 10/27/2023 3:23:14 AM
*******************************************************************/

//Function Number: 1
func_1E65()
{
	level.var_4E08 = 0;
	if(level.var_3F9D)
	{
		return;
	}

	var_00 = getmatchdata("match_common","hostMigrationCount");
	var_00++;
	setmatchdata("match_common","hostMigrationCount",var_00);
	foreach(var_02 in function_02D1())
	{
		var_02.var_4E05 = 0;
	}

	level.var_4E09 = 1;
	setdvar("ui_inhostmigration",1);
	level notify("host_migration_begin");
	maps\mp\gametypes\_gamelogic::func_A17B();
	foreach(var_02 in function_02D1())
	{
		if(isdefined(var_02.waterwakevfxdeletefunc))
		{
			var_02 [[ var_02.waterwakevfxdeletefunc ]]();
		}

		if(isdefined(var_02.onhostmigrationbeginfunc))
		{
			var_02 [[ var_02.onhostmigrationbeginfunc ]]();
		}

		var_02 thread func_4E0A();
		if(isplayer(var_02))
		{
			var_02 setclientomnvar("ui_session_state",var_02.var_178);
			var_02 luinotifyevent(&"host_migration_show_hud",0);
		}
	}

	setdvar("2523",game["state"]);
	level endon("host_migration_begin");
	func_4E0C();
	level.var_4E09 = undefined;
	setdvar("ui_inhostmigration",0);
	level notify("host_migration_end");
	maps\mp\gametypes\_gamelogic::func_A17B();
	level thread maps\mp\gametypes\_gamelogic::func_A11E();
}

//Function Number: 2
func_4E0C()
{
	level endon("game_ended");
	level.var_5139 = 25;
	thread maps\mp\gametypes\_gamelogic::func_6037(20);
	func_4E0D();
	level.var_5139 = 10;
	thread maps\mp\gametypes\_gamelogic::func_6037(5);
	wait(5);
	level.var_5139 = 0;
}

//Function Number: 3
func_4E0D()
{
	level endon("hostmigration_enoughplayers");
	wait(15);
}

//Function Number: 4
func_4E07(param_00)
{
	if(!isdefined(param_00))
	{
		return "<removed_ent>";
	}

	var_01 = -1;
	var_02 = "?";
	if(isdefined(param_00.var_37CD))
	{
		var_01 = param_00.var_37CD;
	}

	if(isplayer(param_00) && isdefined(param_00.var_109))
	{
		var_02 = param_00.var_109;
	}

	if(isplayer(param_00))
	{
		return "player <" + var_02 + "> (entNum " + var_01 + " )";
	}

	if(function_01EF(param_00) && maps\mp\_utility::func_56FF(param_00))
	{
		return "participant agent <" + var_01 + ">";
	}

	if(function_01EF(param_00))
	{
		return "non-participant agent <" + var_01 + ">";
	}

	return "unknown entity <" + var_01 + ">";
}

//Function Number: 5
func_4E0B()
{
	level endon("host_migration_begin");
	level endon("host_migration_end");
	self endon("disconnect");
	self.var_4E05 = 1;
	while(!maps\mp\_utility::func_57A0(self))
	{
		self waittill("spawned");
	}

	maps\mp\_utility::func_3E8E(1);
	self method_800F();
	level waittill("host_migration_end");
}

//Function Number: 6
func_4E0A()
{
	level endon("host_migration_begin");
	self endon("disconnect");
	if(function_01EF(self))
	{
		self endon("death");
	}

	func_4E0B();
	if(self.var_4E05)
	{
		if(maps\mp\_utility::func_3FA0("prematch_done"))
		{
			maps\mp\_utility::func_3E8E(0);
			self method_800E();
		}

		self.var_4E05 = undefined;
	}
}

//Function Number: 7
func_A782()
{
	if(!isdefined(level.var_4E09))
	{
		return 0;
	}

	var_00 = gettime();
	level waittill("host_migration_end");
	return gettime() - var_00;
}

//Function Number: 8
func_A783(param_00)
{
	if(isdefined(level.var_4E09))
	{
		return;
	}

	level endon("host_migration_begin");
	wait(param_00);
}

//Function Number: 9
func_A6F5(param_00)
{
	if(param_00 == 0)
	{
		return;
	}

	var_01 = gettime();
	var_02 = gettime() + param_00 * 1000;
	while(gettime() < var_02)
	{
		func_A783(var_02 - gettime() / 1000);
		if(isdefined(level.var_4E09))
		{
			var_03 = func_A782();
			var_02 = var_02 + var_03;
		}
	}

	func_A782();
	return gettime() - var_01;
}

//Function Number: 10
func_A74C(param_00,param_01)
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
		func_A783(var_03 - gettime() / 1000);
		if(isdefined(level.var_4E09))
		{
			var_04 = func_A782();
			var_03 = var_03 + var_04;
		}
	}

	func_A782();
	return gettime() - var_02;
}

//Function Number: 11
func_A6F4(param_00)
{
	if(param_00 == 0)
	{
		return;
	}

	var_01 = gettime();
	var_02 = gettime() + param_00 * 1000;
	while(gettime() < var_02)
	{
		func_A783(var_02 - gettime() / 1000);
		while(isdefined(level.var_4E09))
		{
			var_02 = var_02 + 1000;
			setgameendtime(int(var_02));
			wait(1);
		}
	}

	while(isdefined(level.var_4E09))
	{
		var_02 = var_02 + 1000;
		setgameendtime(int(var_02));
		wait(1);
	}

	return gettime() - var_01;
}