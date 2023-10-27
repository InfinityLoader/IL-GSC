/*******************************************************************
 * Decompiled By: Bog
 * Decompiled File: scripts\mp\_animation_suite.gsc
 * Game: Call of Duty: Infinite Warfare
 * Platform: PC
 * Function Count: 15
 * Decompile Time: 733 ms
 * Timestamp: 10/27/2023 12:14:26 AM
*******************************************************************/

//Function Number: 1
func_1FAA()
{
	while(!scripts\mp\_utility::func_9FB3(game["gamestarted"]))
	{
		wait(0.05);
	}

	var_00 = getentarray("animObj","targetname");
	var_01 = func_76F6(var_00);
	func_FAF4(var_00);
	func_FAEA(var_00);
	foreach(var_03 in var_00)
	{
		if(isdefined(var_03.var_ECF7))
		{
			switch(var_03.var_ECF7)
			{
				case "rotation_continuous":
				case "rotation_pingpong":
					var_03 thread func_1FE5(var_03.var_ECF7);
					break;

				case "translation_once":
				case "translation_pingpong":
					var_03 thread func_1FE8(var_03.var_ECF7);
					break;
			}
		}
	}
}

//Function Number: 2
func_FAF4(param_00)
{
	foreach(var_02 in param_00)
	{
		if(isdefined(var_02.script_noteworthy) && scripts\common\utility::string_starts_with(var_02.script_noteworthy,"vfx_"))
		{
			var_03 = var_02 scripts\common\utility::spawn_tag_origin();
			var_03 show();
			var_03 linkto(var_02);
			scripts\common\utility::func_136F7();
			thread delayfxcall(scripts\common\utility::getfx(var_02.script_noteworthy),var_03,"tag_origin");
		}
	}
}

//Function Number: 3
delayfxcall(param_00,param_01,param_02)
{
	wait(5);
	playfxontag(param_00,param_01,param_02);
}

//Function Number: 4
func_FAEA(param_00)
{
	foreach(var_02 in param_00)
	{
		if(isdefined(var_02.script_noteworthy) && scripts\common\utility::string_starts_with(var_02.script_noteworthy,"sfx_"))
		{
			var_02 setmodel("tag_origin");
			var_02 thread scripts\common\utility::func_CD7F("mp_quarry_lg_crane_loop");
		}
	}
}

//Function Number: 5
func_4F24()
{
	for(;;)
	{
		scripts\mp\_utility::drawsphere(self.origin,32,0.1,(0,0,255));
		wait(0.1);
	}
}

//Function Number: 6
func_76F6(param_00)
{
	var_01 = [];
	var_02 = [];
	foreach(var_04 in param_00)
	{
		if(isdefined(var_04.script_noteworthy) && issubstr(var_04.script_noteworthy,"group"))
		{
			var_01 = scripts\common\utility::array_add(var_01,var_04);
		}
	}

	foreach(var_07 in var_01)
	{
		if(!isdefined(var_02[var_07.script_noteworthy]))
		{
			var_02[var_07.script_noteworthy] = [var_07];
			continue;
		}

		var_02[var_07.script_noteworthy] = scripts\common\utility::array_add(var_02[var_07.script_noteworthy],var_07);
	}

	foreach(var_0A in var_02)
	{
		var_0B = func_1FE2(var_0A);
		func_1FE3(var_0B,var_0A);
	}

	return var_02;
}

//Function Number: 7
func_1FE2(param_00)
{
	foreach(var_02 in param_00)
	{
		if(isdefined(var_02.var_27C))
		{
			return var_02;
		}
	}
}

//Function Number: 8
func_1FE3(param_00,param_01)
{
	if(isdefined(param_00) && isdefined(param_01))
	{
		foreach(var_03 in param_01)
		{
			if(var_03 == param_00)
			{
				continue;
			}

			var_03 linkto(param_00);
		}
	}
}

//Function Number: 9
func_1FE8(param_00)
{
	if(issubstr(param_00,"pingpong"))
	{
		thread func_1FEA();
	}

	if(issubstr(param_00,"once"))
	{
		thread func_1FE9();
	}
}

//Function Number: 10
func_1FEA()
{
	level endon("game_ended");
	var_00 = (0,90,0);
	var_01 = 5;
	var_02 = 0.5;
	var_03 = undefined;
	var_04 = undefined;
	var_05 = undefined;
	if(isdefined(self.var_EEEB))
	{
		var_00 = self.var_EEEB;
	}

	if(isdefined(self.var_EEEC))
	{
		var_01 = self.var_EEEC;
	}

	if(isdefined(self.var_ED06))
	{
		if(issubstr(self.var_ED06,"start"))
		{
			var_03 = "mp_quarry_lg_crane_start";
		}

		if(issubstr(self.var_ED06,"stop"))
		{
			var_04 = "mp_quarry_lg_crane_stop";
		}

		if(issubstr(self.var_ED06,"loop"))
		{
			var_05 = "mp_quarry_lg_crane_loop";
		}
	}

	for(;;)
	{
		var_06 = self.origin;
		self moveto(self.origin + var_00,var_01[0],var_01[1],var_01[2]);
		if(isdefined(var_04))
		{
			thread func_1FE4(var_01[0],var_04);
		}

		wait(var_01[0] + var_02);
		if(isdefined(var_03))
		{
			playsoundatpos(self.origin,var_03);
		}

		self moveto(var_06,var_01[0],var_01[1],var_01[2]);
		if(isdefined(var_04))
		{
			thread func_1FE4(var_01[0],var_04);
		}

		wait(var_01[0] + var_02);
		if(isdefined(var_03))
		{
			playsoundatpos(self.origin,var_03);
		}
	}
}

//Function Number: 11
func_1FE4(param_00,param_01)
{
	wait(param_00);
	playsoundatpos(self.origin,param_01);
}

//Function Number: 12
func_1FE9()
{
	level endon("game_ended");
	var_00 = (0,90,0);
	var_01 = 5;
	if(isdefined(self.var_EEEB))
	{
		var_00 = self.var_EEEB;
	}

	if(isdefined(self.var_EEEC))
	{
		var_01 = length(self.var_EEEC);
	}

	for(;;)
	{
		self method_8269(var_00,var_01,0,0);
		wait(var_01);
	}
}

//Function Number: 13
func_1FE5(param_00)
{
	if(issubstr(param_00,"pingpong"))
	{
		thread func_1FE7();
	}

	if(issubstr(param_00,"continuous"))
	{
		thread func_1FE6();
	}
}

//Function Number: 14
func_1FE7()
{
	level endon("game_ended");
	var_00 = (0,90,0);
	var_01 = (5,0,0);
	var_02 = 0.5;
	var_03 = undefined;
	var_04 = undefined;
	var_05 = undefined;
	if(isdefined(self.var_EE9B))
	{
		var_00 = self.var_EE9B;
	}

	if(isdefined(self.var_EE9E))
	{
		var_01 = self.var_EE9E;
	}

	if(self.model == "jackal_arena_aa_turret_01_mp_sml")
	{
		var_03 = "divide_turret_move_start";
		var_04 = "divide_turret_move_end";
		thread scripts\common\utility::func_CD7F("divide_turret_move_lp");
	}

	for(;;)
	{
		self method_8269(var_00,var_01[0],var_01[1],var_01[2]);
		if(isdefined(var_04))
		{
			thread func_1FE4(var_01[0] * 0.9,var_04);
		}

		wait(var_01[0] + var_02);
		if(isdefined(var_03))
		{
			playsoundatpos(self.origin,var_03);
		}

		self method_8269(var_00 * -1,var_01[0],var_01[1],var_01[2]);
		if(isdefined(var_04))
		{
			thread func_1FE4(var_01[0] * 0.9,var_04);
		}

		wait(var_01[0] + var_02);
		if(isdefined(var_03))
		{
			playsoundatpos(self.origin,var_03);
		}
	}
}

//Function Number: 15
func_1FE6()
{
	level endon("game_ended");
	var_00 = (0,90,0);
	var_01 = (5,0,0);
	var_02 = 0.5;
	if(isdefined(self.var_EE9B))
	{
		var_00 = self.var_EE9B;
	}

	if(isdefined(self.var_EE9E))
	{
		var_01 = self.var_EE9E;
	}

	for(;;)
	{
		self method_8269(var_00,var_01[0],var_01[1],var_01[2]);
		wait(var_01[0]);
	}
}