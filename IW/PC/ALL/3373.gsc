/*******************************************************************
 * Decompiled By: Bog
 * Decompiled File: 3373.gsc
 * Game: Call of Duty: Infinite Warfare
 * Platform: PC
 * Function Count: 9
 * Decompile Time: 1 ms
 * Timestamp: 10/27/2023 12:26:47 AM
*******************************************************************/

//Function Number: 1
func_EC1E(param_00)
{
	level.var_4415 = 1;
	level.var_66D0 = "cp/zombies/cp_zmb_escape_combos.csv";
	param_00 thread func_11AB4(param_00);
	param_00 thread func_135FF(param_00);
	param_00 thread func_135FC(param_00);
	param_00 thread func_13629(param_00);
}

//Function Number: 2
func_11AB4(param_00)
{
	param_00 endon("disconnect");
	setomnvar("zom_escape_combo_multiplier",level.var_4415);
	for(;;)
	{
		param_00 waittill("adjust_combo_multiplier",var_01,var_02);
		if(!isalive(param_00) || scripts\common\utility::istrue(param_00.inlaststand))
		{
			level.var_4415 = 1;
			continue;
		}

		param_00 thread func_1875(param_00,var_01,var_02);
	}
}

//Function Number: 3
func_1875(param_00,param_01,param_02)
{
	level endon("game_ended");
	param_00 endon("death");
	param_00 endon("disconnect");
	level.var_4415 = level.var_4415 + param_01;
	setomnvar("zom_escape_combo_multiplier",level.var_4415);
	wait(param_02);
	level.var_4415 = level.var_4415 - param_01;
	setomnvar("zom_escape_combo_multiplier",level.var_4415);
}

//Function Number: 4
func_10A31(param_00)
{
	var_01 = tablelookup(level.var_66D0,1,param_00,0);
	self setclientomnvar("zom_escape_combo_splash",int(var_01));
	thread func_4183();
}

//Function Number: 5
func_4183()
{
	wait(2);
	self setclientomnvar("zom_escape_combo_splash",0);
}

//Function Number: 6
func_135FF(param_00)
{
	level endon("game_ended");
	param_00 endon("disconnect");
	var_01 = 0;
	var_02 = 0;
	var_03 = 0.25;
	var_04 = 2;
	var_05 = 2;
	var_06 = "escape_multikill";
	for(;;)
	{
		param_00 waittill("zombie_killed");
		var_01++;
		var_07 = gettime();
		if(var_07 < var_02)
		{
			if(var_01 >= var_05)
			{
				param_00 notify("adjust_combo_multiplier",var_03,var_04);
				param_00 func_10A31(var_06);
			}
		}
		else if(var_01 > 1)
		{
			var_01 = 1;
		}

		var_02 = var_07 + 1000;
	}
}

//Function Number: 7
func_135FC(param_00)
{
	level endon("game_ended");
	param_00 endon("disconnect");
	var_01 = 0.25;
	var_02 = 2;
	var_03 = "escape_headshot";
	for(;;)
	{
		param_00 waittill("zombie_killed",var_04,var_05,var_06,var_07,var_08);
		if(scripts\cp\_utility::func_9E27(var_06,var_08,var_07,param_00))
		{
			param_00 notify("adjust_combo_multiplier",var_01,var_02);
			param_00 func_10A31(var_03);
		}
	}
}

//Function Number: 8
func_13629(param_00)
{
	level endon("game_ended");
	param_00 endon("disconnect");
	var_01 = 0.25;
	var_02 = 2;
	var_03 = "escape_sliding";
	for(;;)
	{
		param_00 waittill("zombie_killed",var_04,var_05,var_06,var_07,var_08);
		if(func_D3B6())
		{
			param_00 notify("adjust_combo_multiplier",var_01,var_02);
			param_00 func_10A31(var_03);
		}
	}
}

//Function Number: 9
func_D3B6()
{
	return isdefined(self.var_9F59) || isdefined(self.var_9F5A) && gettime() <= self.var_9F5A;
}