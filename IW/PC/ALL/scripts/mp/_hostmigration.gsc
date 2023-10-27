/*******************************************************************
 * Decompiled By: Bog
 * Decompiled File: scripts\mp\_hostmigration.gsc
 * Game: Call of Duty: Infinite Warfare
 * Platform: PC
 * Function Count: 12
 * Decompile Time: 557 ms
 * Timestamp: 10/27/2023 12:20:32 AM
*******************************************************************/

//Function Number: 1
func_3749()
{
	level.var_90A8 = 0;
	if(level.var_7669)
	{
		return;
	}

	level thread func_90A5();
	foreach(var_01 in level.var_3CB5)
	{
		var_01.var_90A6 = 0;
	}

	level.var_90A9 = 1;
	setdvar("ui_inhostmigration",1);
	level.var_90A4 = 1;
	level notify("host_migration_begin");
	scripts\mp\_gamelogic::func_12F45();
	foreach(var_01 in level.var_3CB5)
	{
		if(!isdefined(var_01))
		{
			continue;
		}

		var_01 thread func_90AA();
		if(isplayer(var_01))
		{
			var_01 setclientomnvar("ui_session_state",var_01.sessionstate);
		}
	}

	level endon("host_migration_begin");
	func_90AC();
	level.var_90A9 = undefined;
	setdvar("ui_inhostmigration",0);
	function_023A(game["thermal_vision"]);
	level.var_90A4 = 0;
	level notify("host_migration_end");
	scripts\mp\_gamelogic::func_12F45();
	level thread scripts\mp\_gamelogic::func_12E9D();
	setdvar("match_running",1);
}

//Function Number: 2
func_90A5()
{
	level endon("host_migration_end");
	level endon("host_migration_begin");
	level waittill("connected",var_00);
	var_00 thread func_90AA();
	if(isplayer(var_00))
	{
		var_00 setclientomnvar("ui_session_state",var_00.sessionstate);
	}
}

//Function Number: 3
func_90AC()
{
	level endon("game_ended");
	level.ingraceperiod = 25;
	thread scripts\mp\_gamelogic::func_B412("waiting_for_players",20);
	func_90AD();
	level.ingraceperiod = 10;
	thread scripts\mp\_gamelogic::func_B412("match_resuming_in",5);
	wait(5);
	level.ingraceperiod = 0;
	if(scripts\mp\_utility::func_9FB3(level.var_72F2) && !scripts\mp\_utility::func_9FB3(level.var_72F1))
	{
		setomnvar("ui_match_start_text","opponent_forfeiting_in");
	}
}

//Function Number: 4
func_90AD()
{
	level endon("hostmigration_enoughplayers");
	wait(15);
}

//Function Number: 5
func_90A7(param_00)
{
	if(!isdefined(param_00))
	{
		return "<removed_ent>";
	}

	var_01 = -1;
	var_02 = "?";
	if(isdefined(param_00.var_6640))
	{
		var_01 = param_00.var_6640;
	}

	if(isplayer(param_00) && isdefined(param_00.name))
	{
		var_02 = param_00.name;
	}

	if(isplayer(param_00))
	{
		return "player <" + var_02 + ">";
	}

	if(isagent(param_00) && scripts\mp\_utility::func_9E0E(param_00))
	{
		return "participant agent <" + var_01 + ">";
	}

	if(isagent(param_00))
	{
		return "non-participant agent <" + var_01 + ">";
	}

	return "unknown entity <" + var_01 + ">";
}

//Function Number: 6
func_90AB()
{
	level endon("host_migration_begin");
	level endon("host_migration_end");
	while(!scripts\mp\_utility::func_9F19(self))
	{
		self waittill("spawned");
	}

	self.var_90A6 = 1;
	scripts\mp\_utility::func_7385(1);
	level waittill("host_migration_end");
}

//Function Number: 7
func_90AA()
{
	self endon("disconnect");
	func_90AB();
	if(self.var_90A6)
	{
		scripts\mp\_utility::func_7385(0);
		self.var_90A6 = undefined;
	}
}

//Function Number: 8
func_13834()
{
	if(!isdefined(level.var_90A9))
	{
		return 0;
	}

	var_00 = gettime();
	level waittill("host_migration_end");
	return gettime() - var_00;
}

//Function Number: 9
func_13835(param_00)
{
	if(isdefined(level.var_90A9))
	{
		return;
	}

	level endon("host_migration_begin");
	wait(param_00);
}

//Function Number: 10
func_13708(param_00)
{
	if(param_00 == 0)
	{
		return;
	}

	var_01 = gettime();
	var_02 = gettime() + param_00 * 1000;
	while(gettime() < var_02)
	{
		func_13835(var_02 - gettime() / 1000);
		if(isdefined(level.var_90A9))
		{
			var_03 = func_13834();
			var_02 = var_02 + var_03;
		}
	}

	func_13834();
	return gettime() - var_01;
}

//Function Number: 11
func_137B8(param_00,param_01)
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
		func_13835(var_03 - gettime() / 1000);
		if(isdefined(level.var_90A9))
		{
			var_04 = func_13834();
			var_03 = var_03 + var_04;
		}
	}

	func_13834();
	return gettime() - var_02;
}

//Function Number: 12
func_13707(param_00)
{
	if(param_00 == 0)
	{
		return;
	}

	var_01 = gettime();
	var_02 = gettime() + param_00 * 1000;
	while(gettime() < var_02)
	{
		func_13835(var_02 - gettime() / 1000);
		while(isdefined(level.var_90A9))
		{
			var_02 = var_02 + 1000;
			function_01AF(int(var_02));
			wait(1);
		}
	}

	while(isdefined(level.var_90A9))
	{
		var_02 = var_02 + 1000;
		function_01AF(int(var_02));
		wait(1);
	}

	return gettime() - var_01;
}