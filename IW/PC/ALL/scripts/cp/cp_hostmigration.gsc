/*******************************************************************
 * Decompiled By: Bog
 * Decompiled File: scripts\cp\cp_hostmigration.gsc
 * Game: Call of Duty: Infinite Warfare
 * Platform: PC
 * Function Count: 13
 * Decompile Time: 656 ms
 * Timestamp: 10/27/2023 12:09:21 AM
*******************************************************************/

//Function Number: 1
func_90AC()
{
	level endon("game_ended");
	level.ingraceperiod = 25;
	thread func_B412("waiting_for_players",20);
	func_90AD();
	level.ingraceperiod = 10;
	thread func_B412("match_resuming_in",5);
	wait(5);
	level.ingraceperiod = 0;
}

//Function Number: 2
func_90AD()
{
	level endon("hostmigration_enoughplayers");
	wait(15);
}

//Function Number: 3
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

	if(isagent(param_00) && scripts\cp\_utility::func_9E0E(param_00))
	{
		return "participant agent <" + var_01 + ">";
	}

	if(isagent(param_00))
	{
		return "non-participant agent <" + var_01 + ">";
	}

	return "unknown entity <" + var_01 + ">";
}

//Function Number: 4
func_90AB()
{
	level endon("host_migration_begin");
	level endon("host_migration_end");
	while(!scripts\cp\_utility::func_9F19(self))
	{
		self waittill("spawned");
	}

	self.var_90A6 = 1;
	scripts\cp\_utility::func_7385(1);
	level waittill("host_migration_end");
}

//Function Number: 5
func_90AA()
{
	self endon("disconnect");
	func_90AB();
	if(self.var_90A6)
	{
		if(scripts\cp\_utility::func_766C("prematch_done"))
		{
			scripts\cp\_utility::func_7385(0);
		}

		self.var_90A6 = undefined;
	}
}

//Function Number: 6
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

//Function Number: 7
func_13835(param_00)
{
	if(isdefined(level.var_90A9))
	{
		return;
	}

	level endon("host_migration_begin");
	wait(param_00);
}

//Function Number: 8
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

//Function Number: 9
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

//Function Number: 10
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

//Function Number: 11
func_B412(param_00,param_01)
{
	self notify("matchStartTimer");
	self endon("matchStartTimer");
	level notify("match_start_timer_beginning");
	var_02 = int(param_01);
	if(var_02 >= 2)
	{
		setomnvar("ui_match_start_text",param_00);
		func_B413(var_02);
		function_0237("",3);
		return;
	}

	func_9B01();
	function_0237("",1);
}

//Function Number: 12
func_B413(param_00)
{
	waittillframeend;
	func_9B01();
	level endon("match_start_timer_beginning");
	while(param_00 > 0 && !level.var_7669)
	{
		setomnvar("ui_match_start_countdown",param_00);
		if(param_00 == 0)
		{
			function_0237("",0);
		}

		param_00--;
		wait(1);
	}

	setomnvar("ui_match_start_countdown",0);
}

//Function Number: 13
func_9B01()
{
	if(!isdefined(level.var_9B01))
	{
		level.var_9B01 = "mpIntro";
	}

	function_0237(level.var_9B01,0);
}