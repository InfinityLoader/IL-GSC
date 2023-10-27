/*******************************************************************
 * Decompiled By: Bog
 * Decompiled File: maps\mp\_ds_bot.gsc
 * Game: Call of Duty: WWII
 * Platform: PC
 * Function Count: 7
 * Decompile Time: 110 ms
 * Timestamp: 10/27/2023 3:21:09 AM
*******************************************************************/

//Function Number: 1
func_00F9()
{
	var_00 = getdvarint("ds_bot_test");
	if(var_00 != 0)
	{
		thread func_09F4();
		setdvar("scr_testclients",var_00);
		setdvar("scr_testclients_type","0");
		setdvar("scr_devchangetimelimit","-1");
	}
}

//Function Number: 2
func_09F4()
{
	wait(5);
	for(;;)
	{
		if(getdvarint("scr_testclients") > 0)
		{
			break;
		}

		wait(1);
	}

	var_00 = getdvarint("scr_testclients");
	setdvar("scr_testclients",0);
	var_01 = func_9918();
	if(var_00)
	{
		setdvar("bot_DisableAutoConnect","1");
	}

	if(var_01)
	{
		level thread [[ level.var_19D5["bots_spawn"] ]](var_00,"autoassign");
	}
	else
	{
		level func_9007(var_00);
	}

	if(maps\mp\_utility::func_602B())
	{
		setmatchdata("match_common","has_bots",1);
	}

	thread func_8744();
	thread func_871C();
	thread func_09F4();
}

//Function Number: 3
func_8744()
{
	var_00 = getdvarint("ds_time_limit");
	if(var_00 > 0)
	{
		var_01 = getdvarfloat("ds_time_limit") / 60;
		level.var_9309 = gettime();
		var_02 = "scr_" + level.var_3FDC + "_timelimit";
		level.var_A901[var_02].var_A281 = var_01;
		setdvar(var_02,var_01);
	}
}

//Function Number: 4
func_871C()
{
	var_00 = getdvarint("ds_score_limit");
	if(var_00 > 0)
	{
		var_01 = "scr_" + level.var_3FDC + "_scorelimit";
		level.var_A901[var_01].var_A281 = var_00;
		setdvar(var_01,var_00);
	}
}

//Function Number: 5
func_9007(param_00)
{
	var_01 = [];
	while(var_01.size < param_00)
	{
		wait 0.05;
		if(function_0367())
		{
			var_02 = function_0166(1,level.var_746E);
		}
		else
		{
			var_02 = function_0166(1);
		}

		if(!isdefined(var_02))
		{
			wait(1);
			continue;
		}
		else
		{
			var_03 = spawnstruct();
			var_03.var_9843 = var_02;
			var_03.var_7ABD = 0;
			var_03.var_843 = 0;
			var_01[var_01.size] = var_03;
			var_03.var_9843 thread func_535E("autoassign",var_03);
		}
	}

	var_04 = 0;
	while(var_04 < var_01.size)
	{
		var_04 = 0;
		foreach(var_03 in var_01)
		{
			if(var_03.var_7ABD || var_03.var_843)
			{
				var_04++;
			}
		}

		wait 0.05;
	}
}

//Function Number: 6
func_535E(param_00,param_01)
{
	while(!self canspawntestclient())
	{
		wait 0.05;
		if(!isdefined(self))
		{
			if(isdefined(param_01))
			{
				param_01.var_843 = 1;
			}

			return;
		}
	}

	self spawntestclient();
	maps\mp\gametypes\_playerlogic::func_90A5();
	while(!isdefined(self.var_12C["team"]))
	{
		wait 0.05;
		if(!isdefined(self))
		{
			if(isdefined(param_01))
			{
				param_01.var_843 = 1;
			}

			return;
		}
	}

	self [[ level.var_1385 ]]();
	if(maps\mp\_utility::func_C1E())
	{
		var_02 = "class" + randomint(5);
		self notify("luinotifyserver","class_select",var_02);
	}

	common_scripts\utility::func_A74B("spawned_player",0.5);
	wait(0.1);
	if(isdefined(param_01))
	{
		param_01.var_7ABD = 1;
	}
}

//Function Number: 7
func_9918()
{
	var_00 = getdvarint("scr_testclients_type") == 0;
	if(var_00)
	{
		if(!isdefined(level.var_19D5) || !isdefined(level.var_19D5["bots_spawn"]))
		{
			var_00 = 0;
		}
	}

	return var_00;
}