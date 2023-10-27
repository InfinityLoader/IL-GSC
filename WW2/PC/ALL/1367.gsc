/*******************************************************************
 * Decompiled By: Bog
 * Decompiled File: 1367.gsc
 * Game: Call of Duty: WWII
 * Platform: PC
 * Function Count: 83
 * Decompile Time: 76 ms
 * Timestamp: 10/27/2023 3:25:49 AM
*******************************************************************/

//Function Number: 1
func_786C()
{
	level.var_ABE8 = [];
	level.var_7874 = [];
	level.var_BD7 = [];
	level.var_8CC = [];
	level.var_ABE7 = spawnstruct();
	level.var_ABE7.var_5870 = [];
	level.var_782E = 0;
	if(1)
	{
		var_00 = lib_0547::getzombiemapsetting("QuestHintTable");
		level.questhinttablepath = var_00;
		var_01 = function_027B(var_00);
		var_02 = function_027A(var_00);
		level.var_ABEF = [];
		var_03 = 0;
		for(var_04 = 0;var_04 < var_02;var_04++)
		{
			var_05 = function_01B0(var_00,var_04,var_03);
			level.var_ABEF[var_04] = var_05;
		}

		level thread func_5F3C();
	}

	level thread quest_analytics_match_summary();
	level thread maps\mp\_utility::func_6F74(::func_782A);
}

//Function Number: 2
zmb_hint_system_disabled()
{
	return lib_0547::func_5565(level.zmb_uses_hint_notebook,0);
}

//Function Number: 3
removed_quest_hint()
{
	return undefined;
}

//Function Number: 4
quest_ensure_proper_hints(param_00)
{
	if(common_scripts\utility::func_562E(level.quest_assert_no_hints) && isdefined(param_00))
	{
		param_00 = undefined;
	}

	return param_00;
}

//Function Number: 5
func_7846(param_00,param_01,param_02,param_03,param_04,param_05,param_06)
{
	if(!isdefined(param_05))
	{
		param_05 = 1;
	}

	if(!isdefined(param_06))
	{
		param_06 = 1;
	}

	param_03 = quest_ensure_proper_hints(param_03);
	var_07 = spawnstruct();
	var_07.var_109 = param_00;
	var_07.var_6F77 = [];
	var_07.var_2917 = [];
	var_07.var_939C = [];
	var_07.var_933D = "not started";
	var_07.var_939A = undefined;
	var_07.var_782C = param_01;
	var_07.var_4DAC = param_03;
	var_07.var_3007 = undefined;
	var_07.var_3008 = undefined;
	var_07.var_8BDE = param_05;
	var_07.var_8BE1 = param_06;
	var_07.var_76A7 = common_scripts\utility::func_98E7(isdefined(param_02),param_02,[]);
	level.var_ABE8[param_00] = var_07;
	if(isdefined(param_04))
	{
		var_08 = common_scripts\utility::func_F79(["mp_zombie_nest_01","mp_zombie_training"],maps\mp\_utility::func_4571());
	}
	else
	{
		param_04 = "ZOMBIES_EMPTY_STRING";
	}

	var_07.var_4DAD = param_04;
	common_scripts\utility::func_3C87(param_00);
}

//Function Number: 6
func_782F(param_00,param_01,param_02)
{
	var_03 = spawnstruct();
	var_03.var_6C17 = param_00;
	var_03.var_7840 = [];
	var_03.var_37C5 = [];
	var_03.var_6925 = [];
	var_03.var_2AF8 = param_02;
	if(isdefined(param_01))
	{
		if(!isarray(param_01))
		{
			param_01 = [param_01];
		}

		foreach(var_05 in param_01)
		{
			if(!func_5642(var_05))
			{
				continue;
			}

			var_03.var_37C5 = common_scripts\utility::func_F6F(var_03.var_37C5,var_05);
		}
	}

	level.var_BD7 = common_scripts\utility::func_F6F(level.var_BD7,var_03);
	if(isdefined(param_00))
	{
		var_03.var_7B06 = param_00;
	}
	else if(var_03.var_37C5.size)
	{
		var_03.var_7B06 = var_03.var_37C5[0].var_116;
	}

	var_03 func_7844(var_03.var_7B06,"objective_create");
	return var_03;
}

//Function Number: 7
func_781D(param_00,param_01,param_02)
{
	if(!isdefined(param_02))
	{
		param_02 = 1;
	}

	var_03 = func_7832(param_00);
	if(var_03.var_933D != "in progress")
	{
		return;
	}

	if(param_02)
	{
		var_03.var_2917 = common_scripts\utility::func_F6F(var_03.var_2917,param_01);
	}
	else
	{
		var_03.var_6F77 = common_scripts\utility::func_F6F(var_03.var_6F77,param_01);
	}

	param_01.var_7840 = common_scripts\utility::func_F6F(param_01.var_7840,param_00);
	if(param_01.var_7840.size != 1)
	{
		return;
	}

	level.var_8CC = common_scripts\utility::func_F6F(level.var_8CC,param_01);
	foreach(var_05 in func_42B9())
	{
		func_783A(var_05,param_01);
	}
}

//Function Number: 8
func_7847(param_00,param_01)
{
	var_02 = func_7832(param_00);
	func_783D(param_01,var_02);
}

//Function Number: 9
func_781E(param_00,param_01,param_02,param_03,param_04)
{
	func_781F(param_00);
	var_05 = func_7832(param_00);
	param_04 = quest_ensure_proper_hints(param_04);
	var_06 = spawnstruct();
	var_06.var_109 = param_01;
	var_06.var_A09A = param_02;
	var_06.var_D4 = var_05.var_939C.size;
	var_06.var_4DAC = param_04;
	var_06.var_9399 = common_scripts\utility::func_98E7(isarray(param_03),param_03,[param_03]);
	var_05.var_939C[var_06.var_D4] = var_06;
	common_scripts\utility::func_3C87(func_7838(param_00,param_01));
}

//Function Number: 10
func_7848(param_00)
{
	func_781F(param_00);
	var_01 = func_7832(param_00);
	level thread func_7849(var_01);
}

//Function Number: 11
func_7870(param_00,param_01)
{
	common_scripts\utility::func_3C9F(func_7838(param_00,param_01));
}

//Function Number: 12
func_782D(param_00,param_01)
{
	common_scripts\utility::func_3C8F(func_7838(param_00,param_01));
}

//Function Number: 13
func_783E(param_00,param_01)
{
	return common_scripts\utility::func_3C77(func_7838(param_00,param_01));
}

//Function Number: 14
func_7838(param_00,param_01,param_02)
{
	if(!common_scripts\utility::func_562E(param_02))
	{
		func_7820(param_00,param_01);
	}

	return "flag " + param_00 + " " + param_01;
}

//Function Number: 15
func_30D8(param_00)
{
}

//Function Number: 16
func_1D88(param_00)
{
	var_01 = func_7836(param_00);
	var_02 = common_scripts\utility::func_F7E(level.var_7874,param_00);
	if((param_00.var_8BDE && isdefined(param_00.var_4DAC)) || isdefined(var_01) && param_00.var_8BE1 && isdefined(var_01.var_4DAC))
	{
		func_378C(param_00);
		return;
	}

	if(isdefined(var_02))
	{
		level.var_7874 = common_scripts\utility::func_F93(level.var_7874,param_00);
		if(var_02 < 3)
		{
			func_7CAF(param_00);
			func_7CB6(param_00);
			if(level.var_7874.size >= 3)
			{
				func_378D(level.var_7874[2]);
			}

			func_7ACA();
			return;
		}
	}
}

//Function Number: 17
func_9A78(param_00)
{
	func_8564(param_00,!func_42D6(param_00));
}

//Function Number: 18
func_9A7C(param_00)
{
	func_8596(param_00,!func_434E(param_00));
}

//Function Number: 19
func_42D6(param_00)
{
	return func_7834(param_00).var_8BDE;
}

//Function Number: 20
func_434E(param_00)
{
	return func_7834(param_00).var_8BE1;
}

//Function Number: 21
func_8564(param_00,param_01)
{
	var_02 = func_7834(param_00);
	var_02.var_8BDE = param_01;
	func_1D88(var_02);
}

//Function Number: 22
func_8596(param_00,param_01)
{
	var_02 = func_7834(param_00);
	var_02.var_8BE1 = param_01;
	func_1D88(var_02);
}

//Function Number: 23
func_20BA(param_00,param_01)
{
	var_02 = func_7834(param_00);
	func_7CAF(var_02);
	param_01 = quest_ensure_proper_hints(param_01);
	var_02.var_4DAC = param_01;
	func_1D88(var_02);
}

//Function Number: 24
func_20BC(param_00,param_01,param_02)
{
	var_03 = func_7834(param_00);
	var_04 = func_7835(var_03,param_01);
	param_02 = quest_ensure_proper_hints(param_02);
	if(lib_0547::func_5565(var_04.var_D4,var_03.var_939A))
	{
		func_7822(param_00,param_02);
		return;
	}

	var_04.var_4DAC = param_02;
}

//Function Number: 25
func_7822(param_00,param_01)
{
	var_02 = func_7834(param_00);
	func_7CB6(var_02);
	var_03 = func_7836(var_02);
	param_01 = quest_ensure_proper_hints(param_01);
	if(isdefined(var_03))
	{
		var_03.var_4DAC = param_01;
	}

	func_1D88(var_02);
}

//Function Number: 26
func_782A()
{
	var_00 = self;
	var_00 waittill("spawned_player");
	var_00 quest_omnvar_init();
	var_00 thread quest_omnvar_handle_player_respawn();
	foreach(var_02 in level.var_ABE7.var_5870)
	{
		if(var_02.var_1B9 == 2)
		{
			func_782B(var_00,var_02);
			continue;
		}

		if(var_02.var_1B9 == 1)
		{
			zombie_collectable_internal_global_collect_on_join(var_02);
		}
	}
}

//Function Number: 27
func_782B(param_00,param_01)
{
	param_00 thread func_AB8A(param_01);
}

//Function Number: 28
func_AB8C(param_00)
{
	var_04 = spawnstruct();
	var_04.var_3C8C = param_00;
	var_04.var_3E41 = 0;
	var_04.var_1B9 = 1;
	var_04.var_D4 = level.var_ABE7.var_5870.size;
	level.var_ABE7.var_5870 = common_scripts\utility::func_F6F(level.var_ABE7.var_5870,var_04);
	level thread func_AB89(var_04);
}

//Function Number: 29
func_AB8D(param_00,param_01)
{
	var_05 = spawnstruct();
	var_05.var_3C8C = param_00;
	var_05.var_3E41 = 0;
	var_05.var_1B9 = 2;
	var_05.var_D4 = level.var_ABE7.var_5870.size;
	level.var_ABE7.var_5870 = common_scripts\utility::func_F6F(level.var_ABE7.var_5870,var_05);
}

//Function Number: 30
func_AB88(param_00)
{
	common_scripts\utility::func_3C8F(param_00);
}

//Function Number: 31
should_write_match_data(param_00,param_01)
{
	if(common_scripts\utility::func_562E(level.var_783F))
	{
		return 0;
	}

	if(!isdefined(param_00))
	{
		return 0;
	}

	if(param_00 >= param_01)
	{
		return 0;
	}

	return 1;
}

//Function Number: 32
quest_should_write_match_data(param_00)
{
	return should_write_match_data(param_00,32);
}

//Function Number: 33
step_should_write_match_data(param_00)
{
	return should_write_match_data(param_00,100);
}

//Function Number: 34
quest_analytics_objective_step(param_00,param_01)
{
	var_02 = getmatchdata("objective_step_count");
	setmatchdata("objective_step_count",maps\mp\_utility::func_2315(var_02 + 1));
	if(step_should_write_match_data(var_02))
	{
		var_03 = maps\mp\_matchdata::getmatchtimepassed();
		setmatchdata("objective_steps",var_02,"step",param_00);
		setmatchdata("objective_steps",var_02,"time_ms",var_03);
		setmatchdata("objective_steps",var_02,"objective",param_01);
		if(isdefined(level.var_721C))
		{
			var_04 = level.var_721C lib_055A::func_462D();
			if(!isdefined(var_04))
			{
				var_04 = "none";
			}

			setmatchdata("objective_steps",var_02,"area",var_04);
		}
	}
}

//Function Number: 35
quest_analytics_match_summary()
{
	level waittill("game_ended");
	var_00 = gettime();
	var_01 = maps\mp\_matchdata::getmatchtimepassed();
	foreach(var_03 in level.var_ABE8)
	{
		var_04 = 1.666667E-05;
		var_05 = undefined;
		if(isdefined(var_03.var_924E))
		{
			var_06 = var_00;
			if(isdefined(var_03.var_3BA1))
			{
				var_06 = var_03.var_3BA1;
			}

			var_05 = var_06 - var_03.var_924E * var_04;
		}

		var_07 = undefined;
		var_08 = undefined;
		var_09 = undefined;
		var_0A = func_7836(var_03);
		if(isdefined(var_0A))
		{
			var_07 = var_0A.var_109;
			var_08 = var_00 - var_0A.var_924E * var_04;
			var_09 = level.var_A980;
		}

		var_0B = lib_0547::func_AC4B(undefined,"questsummary");
		var_0B lib_0547::func_AC48("quest_name",var_03.var_109);
		var_0B lib_0547::func_AC48("quest_status",var_03.var_933D);
		var_0B lib_0547::func_AC44("quest_start_wave",var_03.var_92AF);
		var_0B lib_0547::func_AC44("quest_finish_wave",var_03.var_3BA4);
		var_0B lib_0547::func_AC43("quest_min",var_05);
		var_0B lib_0547::func_AC48("step_name",var_07);
		var_0B lib_0547::func_AC43("step_min",var_08);
		var_0B lib_0547::func_AC44("step_wave",var_09);
		var_0B lib_0547::func_AC4D();
		if(quest_should_write_match_data(var_03.objective_index))
		{
			var_0C = var_01;
			if(isdefined(var_03.finish_game_ms))
			{
				var_0C = var_03.finish_game_ms;
			}

			var_0D = var_01;
			if(isdefined(var_03.start_game_ms))
			{
				var_0D = var_03.start_game_ms;
			}

			if(!isdefined(var_07))
			{
				var_07 = "unknown";
			}

			setmatchdata("objectives",var_03.objective_index,"description",var_03.var_109);
			setmatchdata("objectives",var_03.objective_index,"start_time_ms",var_0D);
			setmatchdata("objectives",var_03.objective_index,"end_time_ms",var_0C);
			setmatchdata("objectives",var_03.objective_index,"step",var_07);
		}
	}
}

//Function Number: 36
func_7844(param_00,param_01,param_02,param_03)
{
	var_04 = "";
	if(isdefined(param_02))
	{
		var_04 = param_02.var_109;
	}

	if(isdefined(param_02) && !isdefined(param_03))
	{
		param_03 = func_7836(param_02);
	}

	var_05 = "";
	if(isdefined(param_03))
	{
		var_05 = param_03.var_109;
	}

	var_06 = "";
	if(isdefined(self.var_2AF8))
	{
		var_06 = self.var_2AF8;
	}

	if(!isdefined(param_01))
	{
		param_01 = "";
	}

	var_07 = lib_0547::func_AC4B(param_00,"questsubevent");
	var_07 lib_0547::func_AC48("category",param_01);
	var_07 lib_0547::func_AC48("quest",var_04);
	var_07 lib_0547::func_AC48("step",var_05);
	var_07 lib_0547::func_AC48("debug_name",var_06);
	var_07 lib_0547::func_AC4A();
	var_07 lib_0547::func_AC4D();
}

//Function Number: 37
func_7837()
{
	var_00 = "";
	if(isdefined(level.var_ABE8))
	{
		foreach(var_03, var_02 in level.var_ABE8)
		{
			if(var_02.var_933D == "in progress")
			{
				if(var_00 != "")
				{
					var_00 = var_00 + ",";
				}

				var_00 = var_00 + var_03;
				if(isdefined(var_02.var_939A))
				{
					var_00 = var_00 + "/" + var_02.var_939C[var_02.var_939A].var_109;
				}
			}
		}
	}

	return var_00;
}

//Function Number: 38
func_7849(param_00)
{
	waittillframeend;
	param_00.objective_index = quest_allocate_match_data_counter();
	if(quest_should_write_match_data(param_00.objective_index))
	{
		setmatchdata("objectives",param_00.objective_index,"description",param_00.var_109);
		setmatchdata("objectives",param_00.objective_index,"description_id",param_00.var_4DAD);
		setmatchdata("objectives",param_00.objective_index,"is_hardcore",0);
		setmatchdata("objectives",param_00.objective_index,"start_time_ms",-1);
	}

	common_scripts\utility::func_3CA1(param_00.var_76A7);
	param_00.var_933D = "in progress";
	param_00.var_924E = gettime();
	param_00.start_game_ms = maps\mp\_matchdata::getmatchtimepassed();
	param_00.var_92AF = level.var_A980;
	func_7844(undefined,"quest_start",param_00,undefined);
	func_20BA(param_00.var_109,param_00.var_4DAC);
	if(quest_should_write_match_data(param_00.objective_index))
	{
		setmatchdata("objectives",param_00.objective_index,"start_time_ms",param_00.start_game_ms);
	}

	param_00.var_939A = 0;
	while(param_00.var_939A < param_00.var_939C.size)
	{
		var_04 = param_00.var_939C[param_00.var_939A];
		if(isdefined(var_04.var_A09A))
		{
			level childthread [[ var_04.var_A09A ]]();
		}

		var_04.var_924E = gettime();
		var_04.var_92AF = level.var_A980;
		func_7844(undefined,"step_start",param_00,var_04);
		func_7822(param_00.var_109,var_04.var_4DAC);
		func_7870(param_00.var_109,var_04.var_109);
		func_7822(param_00.var_109,undefined);
		var_04.var_3BA1 = gettime();
		var_04.var_3BA4 = level.var_A980;
		func_7844(undefined,"step_end",param_00,var_04);
		quest_analytics_objective_step(var_04.var_109,param_00.objective_index);
		while(param_00.var_2917.size > 0)
		{
			var_05 = param_00.var_2917[0];
			func_783D(var_05,param_00);
		}

		foreach(var_07 in var_04.var_9399)
		{
			if(isdefined(var_07))
			{
				level childthread [[ var_07 ]]();
			}
		}

		param_00.var_939A++;
	}

	param_00.var_939A = undefined;
	param_00.var_933D = "completed";
	func_20BA(param_00.var_109,undefined);
	param_00.var_3BA1 = gettime();
	param_00.finish_game_ms = maps\mp\_matchdata::getmatchtimepassed();
	param_00.var_3BA4 = level.var_A980;
	func_7844(undefined,"quest_end",param_00,undefined);
	if(quest_should_write_match_data(param_00.objective_index))
	{
		setmatchdata("objectives",param_00.objective_index,"end_time_ms",param_00.finish_game_ms);
		setmatchdata("objectives",param_00.objective_index,"is_completed",1);
	}

	while(param_00.var_6F77.size > 0)
	{
		var_05 = param_00.var_6F77[0];
		func_783D(var_05,param_00);
	}

	if(isdefined(param_00.var_782C))
	{
		level childthread [[ param_00.var_782C ]]();
	}

	common_scripts\utility::func_3C8F(param_00.var_109);
}

//Function Number: 39
func_7832(param_00)
{
	var_01 = level.var_ABE8[param_00];
	return var_01;
}

//Function Number: 40
func_7833(param_00,param_01)
{
	foreach(var_03 in param_00.var_939C)
	{
		if(var_03.var_109 == param_01)
		{
			return var_03;
		}
	}
}

//Function Number: 41
func_7835(param_00,param_01)
{
	var_02 = func_7833(param_00,param_01);
	return var_02;
}

//Function Number: 42
func_7831(param_00)
{
	var_01 = func_7832(param_00);
	return isdefined(var_01);
}

//Function Number: 43
func_781F(param_00)
{
}

//Function Number: 44
func_7850(param_00,param_01)
{
	var_02 = func_7832(param_00);
	if(!isdefined(var_02))
	{
		return 0;
	}

	var_03 = func_7833(var_02,param_01);
	return isdefined(var_03);
}

//Function Number: 45
func_7820(param_00,param_01)
{
}

//Function Number: 46
func_7836(param_00)
{
	if(!isdefined(param_00.var_939A))
	{
		return;
	}

	var_01 = param_00.var_939C[param_00.var_939A];
	return var_01;
}

//Function Number: 47
func_7834(param_00)
{
	func_781F(param_00);
	return func_7832(param_00);
}

//Function Number: 48
quest_allocate_match_data_counter()
{
	var_00 = level.var_782E;
	level.var_782E++;
	if(var_00 < 32)
	{
		setmatchdata("objective_count",level.var_782E);
	}
	else
	{
	}

	return var_00;
}

//Function Number: 49
func_419A()
{
	if(level.var_7874.size < 3)
	{
		return level.var_7874.size;
	}

	return 3;
}

//Function Number: 50
func_7ACA()
{
	if(1)
	{
		if(isdefined(level.var_744A))
		{
			foreach(var_01 in level.var_744A)
			{
				func_5F3D(var_01);
			}
		}
	}
}

//Function Number: 51
func_378D(param_00)
{
	if(!isdefined(param_00.var_3007))
	{
		param_00.var_3007 = param_00.var_4DAC;
	}

	var_01 = func_7836(param_00);
	if(isdefined(var_01) && !isdefined(param_00.var_3008) && isdefined(var_01.var_4DAC))
	{
		param_00.var_3008 = var_01.var_4DAC;
	}
}

//Function Number: 52
func_7CB6(param_00)
{
	if(isdefined(param_00.var_3008))
	{
		param_00.var_3008 = undefined;
	}
}

//Function Number: 53
func_7CAF(param_00)
{
	if(isdefined(param_00.var_3007))
	{
		param_00.var_3007 = undefined;
	}
}

//Function Number: 54
func_378C(param_00)
{
	var_01 = common_scripts\utility::func_F7E(level.var_7874,param_00);
	var_02 = 0;
	if(isdefined(var_01))
	{
		if(var_01 >= 3)
		{
			level.var_7874 = common_scripts\utility::func_F93(level.var_7874,param_00);
			level.var_7874 = common_scripts\utility::func_F73([param_00],level.var_7874);
			var_02 = 1;
		}
	}
	else
	{
		level.var_7874 = common_scripts\utility::func_F73([param_00],level.var_7874);
		var_02 = 1;
	}

	if(var_02 && level.var_7874.size > 3)
	{
		func_7CAF(level.var_7874[3]);
	}

	func_378D(param_00);
	func_7ACA();
}

//Function Number: 55
func_5F3B(param_00,param_01)
{
	if(!param_01)
	{
		return 0;
	}

	if(!isdefined(param_00))
	{
		return 0;
	}

	var_02 = common_scripts\utility::func_F7E(level.var_ABEF,param_00);
	return var_02;
}

//Function Number: 56
func_5F3D(param_00)
{
	if(zmb_hint_system_disabled())
	{
		return;
	}

	var_01 = func_419A();
	for(var_02 = 0;var_02 < var_01;var_02++)
	{
		var_03 = level.var_7874[var_02];
		var_04 = func_5F3B(var_03.var_3007,var_03.var_8BDE);
		param_00 setclientomnvar("ui_zm_quest_hint_" + var_02,var_04);
		var_05 = func_5F3B(var_03.var_3008,var_03.var_8BE1);
		param_00 setclientomnvar("ui_zm_step_hint_" + var_02,var_05);
	}

	while(var_02 < 3)
	{
		param_00 setclientomnvar("ui_zm_quest_hint_" + var_02,0);
		param_00 setclientomnvar("ui_zm_step_hint_" + var_02,0);
		var_02++;
	}

	param_00 luinotifyevent(&"update_zm_quest_hints",0);
}

//Function Number: 57
func_A8D6(param_00)
{
	var_01 = param_00 getentitynumber();
	param_00 waittill("disconnect");
	foreach(var_03 in level.var_BD7)
	{
		foreach(var_05 in var_03.var_37C5)
		{
			if(!func_5642(var_05))
			{
				continue;
			}

			if(isdefined(var_05.var_6F47))
			{
				var_05.var_6F47[var_01] = undefined;
			}
		}

		var_07 = var_03.var_6925[var_01];
		if(!isdefined(var_07))
		{
			continue;
		}

		var_03.var_6925[var_01] = undefined;
		var_08 = var_07.var_A98D;
		if(!isdefined(var_08))
		{
			continue;
		}

		var_08 notify("gain_ownership");
		var_08 destroy();
	}
}

//Function Number: 58
func_42B9()
{
	if(!isdefined(level.var_744A))
	{
		return [];
	}

	var_00 = [];
	foreach(var_02 in level.var_744A)
	{
		if(!common_scripts\utility::func_562E(var_02.var_5602))
		{
			continue;
		}

		var_00 = common_scripts\utility::func_F6F(var_00,var_02);
	}

	return var_00;
}

//Function Number: 59
func_A8DC(param_00)
{
	param_00 endon("death");
	param_00 endon("disconnect");
	param_00.var_5602 = 0;
	var_01 = "on togglescore";
	param_00 notifyonplayercommand(var_01,"togglescores");
	level thread func_A8D6(param_00);
	for(;;)
	{
		param_00 waittill(var_01);
		param_00.var_5602 = !param_00.var_5602;
		if(param_00.var_5602 && maps\mp\_utility::func_585F())
		{
			param_00.var_4DC4++;
		}

		level notify(var_01);
		if(zmb_hint_system_disabled())
		{
			continue;
		}

		if(param_00.var_5602)
		{
			if(isdefined(level.plr_custom_on_scoreboard_open_func))
			{
				level thread [[ level.plr_custom_on_scoreboard_open_func ]](param_00);
			}

			foreach(var_03 in level.var_8CC)
			{
				func_783A(param_00,var_03);
			}

			continue;
		}

		if(isdefined(level.plr_custom_on_scoreboard_off_func))
		{
			level thread [[ level.plr_custom_on_scoreboard_off_func ]](param_00);
		}

		foreach(var_03 in level.var_8CC)
		{
			func_783C(param_00,var_03,1.5);
		}
	}
}

//Function Number: 60
func_5F3C()
{
	if(isdefined(level.var_744A))
	{
		foreach(var_01 in level.var_744A)
		{
			func_5F3D(var_01);
		}
	}

	for(;;)
	{
		level waittill("connected",var_01);
		func_5F3D(var_01);
		level thread func_A8DC(var_01);
	}
}

//Function Number: 61
func_5642(param_00)
{
	if(function_0279(param_00) || !isdefined(param_00))
	{
		return 0;
	}

	return 1;
}

//Function Number: 62
func_783A(param_00,param_01)
{
	if(zmb_hint_system_disabled())
	{
		return;
	}

	var_02 = param_00 getentitynumber();
	var_03 = 0;
	var_04 = 1;
	foreach(var_06 in param_01.var_37C5)
	{
		if(!func_5642(var_06))
		{
			continue;
		}

		if(!isdefined(var_06.var_6F47))
		{
			var_06.var_6F47 = [];
		}

		if(!isdefined(var_06.var_6F47[var_02]))
		{
			var_06.var_6F47[var_02] = 0;
		}

		var_06.var_6F47[var_02]++;
		if(var_06.var_6F47[var_02] != 1)
		{
			continue;
		}

		var_06 hudoutlineenableforclient(param_00,var_03,!var_04);
	}

	if(!isdefined(param_01.var_6925[var_02]))
	{
		param_01.var_6925[var_02] = spawnstruct();
	}

	var_08 = param_01.var_6925[var_02];
	if(!isdefined(param_01.var_6C17))
	{
		return;
	}

	var_09 = var_08.var_A98D;
	if(isdefined(var_09))
	{
		var_09 notify("gain_ownership");
		var_09.var_5578 = 0;
	}
	else
	{
		var_09 = newclienthudelem(param_00);
		var_09 setshader("objpoint_default",1,1);
		var_09.var_18 = 0;
		var_09.var_56 = (1,1,1);
		var_09.maxsightdistsqrd = param_01.var_6C17[0];
		var_09.var_1D7 = param_01.var_6C17[1];
		var_09.var_1D9 = param_01.var_6C17[2];
		var_09 setwaypoint(0,1,0);
		var_08.var_A98D = var_09;
	}

	var_09 fadeovertime(0.5);
	var_09.var_18 = 0.9;
}

//Function Number: 63
func_A98E(param_00,param_01)
{
	var_02 = self;
	var_02 endon("death");
	param_00 endon("disconnect");
	var_03 = 100;
	var_04 = 350;
	for(;;)
	{
		wait(0.1);
		var_05 = distance2d(param_01.var_6C17,param_00.var_116);
		var_06 = 0.9;
		if(common_scripts\utility::func_562E(var_02.var_5578) || var_05 < var_03 || var_05 > var_04)
		{
			var_06 = 0;
		}

		if(var_06 == var_02.var_18)
		{
			continue;
		}

		var_02 fadeovertime(0.5);
		var_02.var_18 = var_06;
	}
}

//Function Number: 64
func_783B(param_00,param_01,param_02)
{
	var_03 = param_01.var_6925[param_00 getentitynumber()];
	var_04 = var_03.var_A98D;
	if(!isdefined(var_04))
	{
		return;
	}

	var_04 endon("gain_ownership");
	param_00 endon("disconnect");
	wait(param_02);
	var_04.var_5578 = 1;
	var_04 fadeovertime(0.5);
	var_04.var_18 = 0;
	wait(0.5);
	var_04 destroy();
	var_03.var_A98D = undefined;
}

//Function Number: 65
func_783C(param_00,param_01,param_02)
{
	var_03 = param_00 getentitynumber();
	if(zmb_hint_system_disabled())
	{
		return;
	}

	foreach(var_05 in param_01.var_37C5)
	{
		if(!func_5642(var_05))
		{
			continue;
		}

		var_05.var_6F47[var_03]--;
		if(var_05.var_6F47[var_03])
		{
			continue;
		}

		var_05 hudoutlinedisableforclient(param_00);
	}

	level thread func_783B(param_00,param_01,param_02);
}

//Function Number: 66
func_783D(param_00,param_01)
{
	var_02 = 0;
	if(common_scripts\utility::func_F79(param_01.var_2917,param_00))
	{
		param_01.var_2917 = common_scripts\utility::func_F93(param_01.var_2917,param_00);
		var_02++;
	}

	if(common_scripts\utility::func_F79(param_01.var_6F77,param_00))
	{
		param_01.var_6F77 = common_scripts\utility::func_F93(param_01.var_6F77,param_00);
		var_02++;
	}

	param_00.var_7840 = common_scripts\utility::func_F93(param_00.var_7840,param_01.var_109);
	if(param_00.var_7840.size != 0)
	{
		return;
	}

	level.var_8CC = common_scripts\utility::func_F93(level.var_8CC,param_00);
	foreach(var_04 in func_42B9())
	{
		func_783C(var_04,param_00,0);
	}

	func_7844(param_00.var_7B06,"objective_remove",param_01);
}

//Function Number: 67
func_AB89(param_00)
{
	wait 0.05;
	common_scripts\utility::func_3C9F(param_00.var_3C8C);
	param_00.var_3E41 = 1;
	level thread maps/mp/gametypes/zombies::orders_and_contracts_report_event("any_objective_completed");
	foreach(var_03 in level.var_744A)
	{
		var_03 quest_omnvar_mark_completed(param_00.var_D4,1);
		var_03 thread maps\mp\gametypes\_hud_message::func_9102(param_00.var_3C8C);
	}
}

//Function Number: 68
zombie_collectable_internal_global_collect_on_join(param_00)
{
	var_01 = self;
	if(param_00.var_3E41)
	{
		var_01 quest_omnvar_mark_completed(param_00.var_D4,1);
	}
}

//Function Number: 69
func_AB8A(param_00)
{
	var_01 = self;
	var_01 endon("disconnect");
	wait 0.05;
	common_scripts\utility::func_379C(param_00.var_3C8C);
	param_00.var_3E41 = 1;
	quest_omnvar_mark_completed(param_00.var_D4,1);
	thread maps\mp\gametypes\_hud_message::func_9102(param_00.var_3C8C);
}

//Function Number: 70
func_4BCA(param_00,param_01)
{
	var_02 = level.zombiehcanalyticcounters[param_00];
	if(quest_should_write_match_data(var_02))
	{
		var_03 = maps\mp\_matchdata::getmatchtimepassed();
		setmatchdata("objectives",var_02,"is_completed",param_01);
		setmatchdata("objectives",var_02,"end_time_ms",var_03);
		setmatchdata("objectives",var_02,"step",param_00);
		quest_analytics_objective_step(param_00,var_02);
	}

	if(lib_0547::func_AC4C())
	{
		var_04 = lib_0547::func_AC4B(undefined,"hc_objective");
		var_04 lib_0547::func_AC48("Desc",param_00);
		var_04 lib_0547::func_AC42("Succeeded",param_01);
		var_04 lib_0547::func_AC4D();
	}

	level notify(get_hc_analytics_reported_notify(param_00));
}

//Function Number: 71
func_4BCB(param_00)
{
	level endon(get_hc_analytics_reported_notify(param_00));
	level waittill("game_ended");
	func_4BCA(param_00,0);
}

//Function Number: 72
func_4BC8(param_00)
{
	var_01 = common_scripts\utility::func_98E7(isarray(param_00),param_00,[param_00]);
	foreach(var_03 in var_01)
	{
		if(common_scripts\utility::func_3C77(var_03))
		{
			continue;
		}

		common_scripts\utility::func_3C8F(var_03);
		func_4BCA(var_03,1);
	}
}

//Function Number: 73
hc_analytics_register_match_data(param_00,param_01,param_02)
{
	wait 0.05;
	var_03 = quest_allocate_match_data_counter();
	var_04 = maps\mp\_matchdata::getmatchtimepassed();
	if(quest_should_write_match_data(var_03))
	{
		setmatchdata("objectives",var_03,"description",param_01);
		setmatchdata("objectives",var_03,"description_id",param_02);
		setmatchdata("objectives",var_03,"is_hardcore",1);
		setmatchdata("objectives",var_03,"start_time_ms",var_04);
		setmatchdata("objectives",var_03,"step",param_00);
	}

	level.zombiehcanalyticcounters[param_00] = var_03;
}

//Function Number: 74
func_4BC9(param_00,param_01,param_02,param_03)
{
	if(common_scripts\utility::func_562E(param_03))
	{
		if(!isdefined(param_01))
		{
			param_01 = param_00;
		}

		if(!isdefined(param_02))
		{
			param_02 = "ZOMBIES_EMPTY_STRING";
		}
	}
	else
	{
		common_scripts\utility::func_3C87(param_00);
	}

	if(isdefined(param_01))
	{
		level thread hc_analytics_register_match_data(param_00,param_01,param_02);
	}

	thread hc_analytics_watch_autocompletion(param_00);
	thread func_4BCB(param_00);
}

//Function Number: 75
hc_analytics_watch_autocompletion(param_00)
{
	level endon(get_hc_analytics_reported_notify(param_00));
	common_scripts\utility::func_3C9F(param_00);
	func_4BCA(param_00,1);
}

//Function Number: 76
get_hc_analytics_reported_notify(param_00)
{
	return "analytics reported for " + param_00;
}

//Function Number: 77
quest_omnvar_init()
{
	var_00 = self;
	var_01 = int(1.956522) + 1;
	var_00.questprogressbitfield = [];
	for(var_02 = 0;var_02 < var_01;var_02++)
	{
		var_00.questprogressbitfield[var_02] = 0;
	}

	var_00 func_23DB("ui_zm_has_quest_item_bits_",46);
}

//Function Number: 78
quest_omnvar_mark_completed(param_00,param_01)
{
	var_02 = self;
	var_03 = int(param_00 / 23);
	var_04 = param_00 - var_03 * 23;
	if(param_01)
	{
		var_02.questprogressbitfield[var_03] = var_02.questprogressbitfield[var_03] | 1 << var_04;
	}
	else
	{
		var_02.questprogressbitfield[var_03] = var_02.questprogressbitfield[var_03] & ~1 << var_04;
	}

	var_05 = "ui_zm_has_quest_item_bits_" + var_03;
	self setclientomnvar(var_05,var_02.questprogressbitfield[var_03]);
}

//Function Number: 79
quest_omnvar_handle_player_respawn()
{
	var_00 = self;
	var_00 endon("disconnect");
	for(;;)
	{
		var_00 waittill("spawned_player");
		for(var_01 = 0;var_01 < var_00.questprogressbitfield.size;var_01++)
		{
			var_02 = "ui_zm_has_quest_item_bits_" + var_01;
			var_00 setclientomnvar(var_02,var_00.questprogressbitfield[var_01]);
		}
	}
}

//Function Number: 80
func_23DB(param_00,param_01)
{
	var_02 = int(param_01 - 1 / 23) + 1;
	for(var_03 = 0;var_03 < var_02;var_03++)
	{
		var_04 = param_00 + var_03;
		self setclientomnvar(var_04,0);
	}
}

//Function Number: 81
func_8650(param_00,param_01,param_02)
{
	var_03 = int(param_01 / 23);
	var_04 = param_01 - var_03 * 23;
	var_05 = param_00 + var_03;
	var_06 = self getclientomnvar(var_05);
	if(param_02)
	{
		var_06 = var_06 | 1 << var_04;
	}
	else
	{
		var_06 = var_06 & ~1 << var_04;
	}

	self setclientomnvar(var_05,var_06);
}

//Function Number: 82
manage_mtx5_event()
{
	level endon("game_ended");
	if(!getdvarint("spv_zmb_event_mtx5_active",0))
	{
		return;
	}

	level thread maps\mp\_utility::func_6F74(::giveplayereventbuff);
}

//Function Number: 83
giveplayereventbuff()
{
	var_00 = self;
	var_00 waittill("zombie_player_spawn_finished");
	var_00 endon("disconnect");
	var_01 = ["blunderbuss_zm"];
	var_02 = maps\mp\zombies\_zombies_magicbox::func_454B(var_00,lib_0547::func_AAF9(common_scripts\utility::func_7A33(var_01)));
	maps\mp\zombies\_zombies_magicbox::func_A7D6(var_00,var_02);
	lib_0533::func_F37(2,1,0);
}