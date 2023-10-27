/*******************************************************************
 * Decompiled By: Bog
 * Decompiled File: 135.gsc
 * Game: Call of Duty: Modern Warfare 3
 * Platform: PC
 * Function Count: 62
 * Decompile Time: 71 ms
 * Timestamp: 10/27/2023 2:20:03 AM
*******************************************************************/

//Function Number: 1
func_14FC()
{
	if(!isdefined(level._audio))
	{
		level._audio = spawnstruct();
	}

	if(!isdefined(level._audio.indexed))
	{
		level._audio.indexed = spawnstruct();
	}

	func_1558();
	level._audio.indexed.use_string_table_presets = 0;
	level._audio.indexed.use_iw_presets = 0;
	level._audio.indexed.var_14FE = 0;
	level._audio.indexed.var_14FF = 0;
	var_00 = 10;
	thread func_154D(var_00);
	thread func_154C(var_00);
	level._audio.indexed.var_1500 = "";
	level._audio.indexed.var_1501 = "";
	level._audio.indexed.var_1502 = [];
	if(!isdefined(level._audio.var_1503))
	{
		level._audio.var_1503 = [];
	}

	level._audio.indexed.var_1504 = [];
	level._audio.indexed.preset_cache = [];
	level._audio.indexed.var_1505 = [];
	level._audio.indexed.var_1506 = 0.85;
	level._audio.indexed.var_1507 = 0;
	level._audio.indexed.var_1508 = "";
	thread func_153E();
	waittillframeend;
	thread func_1545();
}

//Function Number: 2
func_1509(param_00)
{
	func_1556(param_00);
}

//Function Number: 3
func_150A(param_00,param_01,param_02)
{
	if(!level._audio.indexed.var_14FF)
	{
		var_03 = 1;
		if(isdefined(param_02))
		{
			var_03 = param_02;
		}

		level._audio.indexed.var_1506 = param_01;
		var_04 = func_1556(param_00);
		if(isdefined(var_04))
		{
			level._audio.indexed.var_150B = var_04;
			func_153C(var_03,param_00);
		}
	}
}

//Function Number: 4
func_150C()
{
	level._audio.indexed.var_14FF = 1;
}

//Function Number: 5
func_150D()
{
	level._audio.indexed.var_14FF = 0;
}

//Function Number: 6
func_150E()
{
	level._audio.indexed.use_string_table_presets = 1;
	level._audio.indexed.use_iw_presets = 0;
}

//Function Number: 7
func_150F(param_00,param_01)
{
	if(!level._audio.indexed.var_14FF && !level._audio.indexed.var_14FE)
	{
		if(param_00 != level._audio.indexed.var_1500)
		{
			func_153B(0);
			func_1535(param_00,param_01);
		}
	}
}

//Function Number: 8
func_1510(param_00)
{
	if(!level._audio.indexed.var_14FF && !level._audio.indexed.var_14FE)
	{
		var_01 = func_1556(param_00);
		if(!isdefined(var_01))
		{
			return;
		}

		if(isdefined(level._audio.indexed.var_1503["zone_mix"]))
		{
			foreach(var_04, var_03 in level._audio.indexed.var_1503["zone_mix"])
			{
				if(var_04 != "fade_time" && var_04 != "preset_name")
				{
					level._audio.indexed.var_1503["zone_mix"][var_04].var_1511 = 1;
				}
			}
		}
		else
		{
			level._audio.indexed.var_1503["zone_mix"] = [];
		}

		level._audio.indexed.var_1503["zone_mix"]["preset_name"] = param_00;
		foreach(var_04, var_03 in var_01)
		{
			if(var_04 != "fade_time" && var_04 != "name")
			{
				level._audio.indexed.var_1503["zone_mix"][var_04] = spawnstruct();
				level._audio.indexed.var_1503["zone_mix"][var_04].var_1511 = var_03;
				level._audio.indexed.var_1503["zone_mix"][var_04].var_1512 = var_03;
			}
		}

		var_06 = 1;
		if(isdefined(var_01["fade_time"]))
		{
			var_06 = var_01["fade_time"];
		}

		func_153C(var_06,"zone_mix");
	}
}

//Function Number: 9
func_1513(param_00)
{
	var_01 = 1;
	if(isdefined(param_00))
	{
		var_01 = param_00;
	}

	if(isdefined(level._audio.indexed.var_1503["zone_mix"]))
	{
		level._audio.indexed.var_1503["zone_mix"]["CLEAR"] = 1;
		func_153C(var_01,"zone_mix");
	}
}

//Function Number: 10
func_1514(param_00)
{
	func_153B(1,param_00);
}

//Function Number: 11
func_1515(param_00)
{
	level._audio.indexed.var_1502[param_00] = 1;
}

//Function Number: 12
func_1516(param_00)
{
	level._audio.indexed.var_1502[param_00] = undefined;
}

//Function Number: 13
func_1517(param_00,param_01,param_02)
{
	if(!level._audio.indexed.var_14FF && !level._audio.indexed.var_14FE)
	{
		func_1535(param_00,param_01,param_02);
	}
}

//Function Number: 14
func_1518(param_00,param_01,param_02,param_03)
{
	if(!isdefined(level._audio.indexed.var_1504[param_01]))
	{
		var_04 = func_1538(undefined,param_00,param_02);
		if(!isdefined(var_04))
		{
			return;
		}

		level._audio.indexed.var_1504[param_01] = var_04;
		func_153C(param_03,param_00);
	}
}

//Function Number: 15
func_1519(param_00,param_01,param_02,param_03,param_04)
{
	if(!isdefined(level._audio.indexed.var_1504[param_02]))
	{
		var_05 = func_1538(param_00,param_01,param_03);
		if(!isdefined(var_05))
		{
			return;
		}

		level._audio.indexed.var_1504[param_02] = var_05;
		func_153C(param_04,param_02);
	}
}

//Function Number: 16
func_151A(param_00,param_01,param_02)
{
	if(isdefined(level._audio.indexed.var_1504[param_00]))
	{
		level._audio.indexed.var_1504[param_00].var_151B = clamp(param_01,0,1);
		func_153C(param_02,param_00);
	}
}

//Function Number: 17
func_151C(param_00,param_01)
{
	if(isdefined(level._audio.indexed.var_1504[param_00]))
	{
		level._audio.indexed.var_1504[param_00].var_151D = 1;
		func_153C(param_01,param_00);
	}
}

//Function Number: 18
func_151E(param_00,param_01,param_02)
{
	if(!level._audio.indexed.var_14FF && !level._audio.indexed.var_14FE)
	{
		if(isdefined(level._audio.indexed.var_1503[param_00]))
		{
			func_1536(param_00,param_01);
		}
		else
		{
			func_1537(param_00,param_01);
		}

		func_153C(param_02,param_00);
	}
}

//Function Number: 19
func_151F(param_00,param_01)
{
	if(!level._audio.indexed.var_14FF && !level._audio.indexed.var_14FE)
	{
		if(isdefined(level._audio.indexed.var_1503[param_00]))
		{
			level._audio.indexed.var_1503[param_00].var_1511 = level._audio.indexed.var_1503[param_00].var_1512;
			func_153C(param_01,param_00);
		}
	}
}

//Function Number: 20
func_1520(param_00,param_01)
{
	if(!level._audio.indexed.var_14FF && !level._audio.indexed.var_14FE)
	{
		if(param_00 == "default")
		{
			return;
		}

		if(!isdefined(level._audio.indexed.var_1502[param_00]) && isdefined(level._audio.indexed.var_1503[param_00]))
		{
			level._audio.indexed.var_1503[param_00]["CLEAR"] = 1;
			func_153C(param_01,param_00);
		}
	}
}

//Function Number: 21
func_1521()
{
	return level._audio.indexed.var_1500;
}

//Function Number: 22
func_1522(param_00,param_01,param_02)
{
	if(!level._audio.indexed.var_14FF)
	{
		if(isdefined(level._audio.indexed.var_1503[param_00]))
		{
			return;
		}

		level._audio.indexed.var_1503[param_00] = [];
		var_03 = 0;
		var_04 = undefined;
		foreach(var_06 in param_01)
		{
			if(maps\_audio::aud_is_even(var_03))
			{
				var_04 = var_06;
			}
			else
			{
				if(!func_155F(var_04))
				{
					level._audio.indexed.var_1503[param_00] = undefined;
					return;
				}

				level._audio.indexed.var_1503[param_00][var_04] = spawnstruct();
				level._audio.indexed.var_1503[param_00][var_04].var_1511 = var_06;
				level._audio.indexed.var_1503[param_00][var_04].var_1512 = var_06;
				var_04 = undefined;
			}

			var_03++;
		}

		func_153C(param_02,param_00);
	}
}

//Function Number: 23
func_1524(param_00,param_01,param_02)
{
	if(!level._audio.indexed.var_14FF)
	{
		level._audio.indexed.var_1503[param_00] = [];
		var_03 = 0;
		var_04 = undefined;
		foreach(var_06 in param_01)
		{
			if(maps\_audio::aud_is_even(var_03))
			{
				var_04 = var_06;
			}
			else
			{
				level._audio.indexed.var_1503[param_00][var_04] = spawnstruct();
				level._audio.indexed.var_1503[param_00][var_04].var_1511 = var_06;
				level._audio.indexed.var_1503[param_00][var_04].var_1512 = var_06;
				var_04 = undefined;
			}

			var_03++;
		}

		func_153C(param_02,param_00);
	}
}

//Function Number: 24
func_1525(param_00)
{
	return isdefined(level._audio.indexed.var_1503[param_00]);
}

//Function Number: 25
func_1526(param_00,param_01)
{
	if(!level._audio.indexed.var_14FF)
	{
		level._audio.indexed.var_1503["mm_mute"] = [];
		if(isstring(param_00))
		{
			if(!isdefined(level._audio.indexed.var_1503["mm_mute"][param_00]))
			{
				level._audio.indexed.var_1503["mm_mute"][param_00] = spawnstruct();
			}

			level._audio.indexed.var_1503["mm_mute"][param_00].var_1511 = 0;
			level._audio.indexed.var_1503["mm_mute"][param_00].var_1512 = 1;
		}
		else
		{
			foreach(var_03 in param_00)
			{
				if(!isdefined(level._audio.indexed.var_1503["mm_mute"][var_03]))
				{
					level._audio.indexed.var_1503["mm_mute"][var_03] = spawnstruct();
				}

				level._audio.indexed.var_1503["mm_mute"][var_03].var_1511 = 0;
				level._audio.indexed.var_1503["mm_mute"][var_03].var_1512 = 1;
			}
		}

		func_153C(param_01,"mm_mute");
	}
}

//Function Number: 26
func_1527(param_00)
{
	if(isdefined(level._audio.var_1503["mm_mute"]))
	{
		level._audio.var_1503["mm_mute"] = undefined;
		func_153C(param_00,"mm_mute");
	}
}

//Function Number: 27
func_1528(param_00,param_01)
{
	if(!level._audio.indexed.var_14FF)
	{
		level._audio.indexed.var_1503["mm_solo"] = [];
		foreach(var_04, var_03 in level._audio.indexed.var_1529)
		{
			level._audio.indexed.var_1503["mm_solo"][var_04] = spawnstruct();
			level._audio.indexed.var_1503["mm_solo"][var_04].var_1511 = 0;
			level._audio.indexed.var_1503["mm_solo"][var_04].var_1512 = 1;
		}

		if(isstring(param_00))
		{
			level._audio.indexed.var_1503["mm_solo"][param_00].var_1511 = 1;
		}
		else
		{
			foreach(var_06 in param_00)
			{
				level._audio.indexed.var_1503["mm_solo"][var_06].var_1511 = 1;
			}
		}

		func_153C(param_01,"mm_solo");
	}
}

//Function Number: 28
func_152A(param_00)
{
	if(isdefined(level._audio.indexed.var_1503["mm_solo"]))
	{
		level._audio.indexed.var_1503["mm_solo"] = undefined;
		func_153C(param_00,"mm_solo");
	}
}

//Function Number: 29
func_152B()
{
	return level._audio.indexed.var_152C;
}

//Function Number: 30
func_152D()
{
	return level._audio.indexed.var_1503.size;
}

//Function Number: 31
func_152E()
{
	return 0;
}

//Function Number: 32
func_152F(param_00)
{
	var_01 = undefined;
	if(isdefined(level._audio.indexed.var_1503) && param_00 < level._audio.indexed.var_1503.size)
	{
		var_02 = 0;
		foreach(var_06, var_04 in level._audio.indexed.var_1503)
		{
			if(var_04.size > 0)
			{
				if(var_02 == param_00)
				{
					if(var_06 == "zone_mix")
					{
						var_05 = level._audio.indexed.var_1503["zone_mix"]["preset_name"];
						var_06 = "zone_mix : " + var_05;
					}

					var_01 = var_06;
					break;
				}

				var_02++;
			}
		}
	}

	return var_01;
}

//Function Number: 33
func_1530(param_00)
{
	var_01 = undefined;
	if(getsubstr(param_00,0,8) == "zone_mix")
	{
		param_00 = "zone_mix";
	}

	if(isdefined(level._audio.indexed.var_1503) && isdefined(level._audio.indexed.var_1503[param_00]))
	{
		if(level._audio.indexed.var_1503[param_00].size > 0)
		{
			var_01 = level._audio.indexed.var_1503[param_00];
		}
	}

	return var_01;
}

//Function Number: 34
func_1531(param_00,param_01,param_02)
{
	param_01 = clamp(param_01,0,1);
	if(isdefined(level._audio.indexed.var_1503["default"]))
	{
		if(isdefined(level._audio.indexed.var_1503["default"][param_00]))
		{
			level._audio.indexed.var_1503["default"][param_00].var_1511 = param_01;
			func_153C(param_02,"default");
			return;
		}

		maps\_audio::aud_print_error("Trying to set a volmod value on the default submix but the volmod doesn\'t exist: " + param_00);
		return;
	}

	maps\_audio::aud_print_error("Trying to set a volmod value on the default submix but \"default\" doesn\'t exist.");
}

//Function Number: 35
func_1533(param_00)
{
	var_01 = undefined;
	if(isdefined(level._audio.indexed.var_1503["default"]))
	{
		if(isdefined(level._audio.indexed.var_1503["default"][param_00]))
		{
			var_01 = level._audio.indexed.var_1503["default"][param_00].var_1512;
		}
		else
		{
			maps\_audio::aud_print_error("Trying to set a volmod value on the default submix but the volmod doesn\'t exist: " + param_00);
		}
	}
	else
	{
		maps\_audio::aud_print_error("Trying to set a volmod value on the default submix but \"default\" doesn\'t exist.");
	}

	return var_01;
}

//Function Number: 36
func_1534(param_00,param_01)
{
	var_02 = func_1533(param_00);
	if(isdefined(var_02))
	{
		func_1531(param_00,var_02,param_01);
	}
}

//Function Number: 37
func_1535(param_00,param_01,param_02)
{
	func_1537(param_00,param_02);
	level._audio.indexed.var_1501 = level._audio.indexed.var_1500;
	level._audio.indexed.var_1500 = param_00;
	func_153C(param_01,param_00);
}

//Function Number: 38
func_1536(param_00,param_01)
{
	if(isdefined(level._audio.indexed.var_1503[param_00]))
	{
		foreach(var_04, var_03 in level._audio.indexed.var_1503[param_00])
		{
			level._audio.indexed.var_1503[param_00][var_04].var_1511 = var_03.var_1512 * param_01;
		}
	}
}

//Function Number: 39
func_1537(param_00,param_01)
{
	if(param_00 == "default")
	{
		return;
	}

	if(!isdefined(level._audio.indexed.var_1503[param_00]))
	{
		var_02 = func_1556(param_00);
		if(!isdefined(var_02))
		{
			return;
		}

		var_03 = 1;
		if(isdefined(param_01))
		{
			var_03 = param_01;
			var_03 = max(var_03,0);
		}

		level._audio.indexed.var_1503[param_00] = [];
		foreach(var_06, var_05 in var_02)
		{
			if(var_06 != "name" && var_06 != "fade_time")
			{
				level._audio.indexed.var_1503[param_00][var_06] = spawnstruct();
				level._audio.indexed.var_1503[param_00][var_06].var_1511 = var_05 * var_03;
				level._audio.indexed.var_1503[param_00][var_06].var_1512 = var_05;
			}
		}
	}
}

//Function Number: 40
func_1538(param_00,param_01,param_02)
{
	var_03 = 0;
	if(isdefined(param_02))
	{
		var_03 = clamp(param_02,0,1);
	}

	var_04 = spawnstruct();
	var_05 = func_1556(param_01);
	if(!isdefined(var_05))
	{
		return;
	}

	var_04.var_1539 = var_05;
	var_04.var_1539["fade_time"] = undefined;
	var_04.var_1539["name"] = undefined;
	if(isdefined(param_00))
	{
		var_06 = func_1556(param_00);
		if(!isdefined(var_06))
		{
			return;
		}

		var_04.var_153A = var_06;
		var_04.var_153A["fade_time"] = undefined;
		var_04.var_153A["name"] = undefined;
	}
	else
	{
		var_04.var_153A = [];
		foreach(var_09, var_08 in var_04.var_1539)
		{
			var_04.var_153A[var_09] = 1;
		}
	}

	var_04.var_151B = var_03;
	return var_04;
}

//Function Number: 41
func_153B(param_00,param_01)
{
	var_02 = 1;
	if(isdefined(param_00))
	{
		var_02 = param_00;
	}

	foreach(var_05, var_04 in level._audio.indexed.var_1503)
	{
		if(var_05 != "default" && var_05 != "zone_mix" && !isdefined(level._audio.indexed.var_1502[var_05]) && var_05 != "mm_solo" && var_05 != "mm_mute")
		{
			level._audio.indexed.var_1503[var_05]["CLEAR"] = 1;
			level._audio.indexed.var_1505[var_05] = 1;
		}
	}

	if(var_02)
	{
		func_153C(param_01,undefined);
	}
}

//Function Number: 42
func_153C(param_00,param_01)
{
	level._audio.indexed.var_153D = param_00;
	if(isdefined(param_01))
	{
		level._audio.indexed.var_1505[param_01] = 1;
	}

	level notify("mix_update");
}

//Function Number: 43
func_153E()
{
	level waittill("mix_update");
	for(;;)
	{
		waittillframeend;
		var_00 = 0;
		if(isdefined(level._audio.indexed.var_153D))
		{
			var_00 = level._audio.indexed.var_153D;
		}

		func_1541(var_00);
		level waittill("mix_update");
	}
}

//Function Number: 44
func_153F()
{
	var_00 = [];
	foreach(var_03, var_02 in level._audio.indexed.var_1503)
	{
		if(!isdefined(level._audio.indexed.var_1505[var_03]))
		{
			var_00[var_03] = 1;
		}
	}

	foreach(var_08, var_05 in level._audio.indexed.var_1540)
	{
		foreach(var_03, var_07 in var_00)
		{
			if(isdefined(level._audio.indexed.var_1503[var_03][var_08]))
			{
				level._audio.indexed.var_1540[var_08] = level._audio.indexed.var_1540[var_08] * level._audio.indexed.var_1503[var_03][var_08].var_1511;
			}
		}
	}
}

//Function Number: 45
func_1541(param_00)
{
	var_01 = 1;
	if(isdefined(param_00))
	{
		var_01 = param_00;
		var_01 = max(var_01,0);
	}

	level._audio.indexed.var_1540 = undefined;
	func_1544(0);
	func_153F();
	var_02 = 0;
	foreach(var_05, var_04 in level._audio.indexed.var_1540)
	{
		if(var_05 != "voiceover_critical" && var_05 != "fullvolume")
		{
			var_04 = var_04 * level._audio.indexed.var_1506;
		}

		if(var_04 != level._audio.indexed.var_1529[var_05].volume)
		{
			var_02 = 1;
			level._audio.indexed.var_1529[var_05].volume = var_04;
			level._audio.indexed.var_1529[var_05].completedindex = var_01;
			func_1547(var_05,var_04,var_01);
		}
	}

	level._audio.indexed.var_1505 = [];
	if(var_02)
	{
		level notify("aud_new_volmod_set");
	}
}

//Function Number: 46
func_1544(param_00)
{
	level._audio.indexed.var_1540 = [];
	var_01 = [];
	foreach(var_10, var_03 in level._audio.indexed.var_1505)
	{
		if(isdefined(level._audio.indexed.var_1503[var_10]))
		{
			var_04 = level._audio.indexed.var_1503[var_10];
			var_04["name"] = undefined;
			var_04["fade_time"] = undefined;
			var_04["preset_name"] = undefined;
			var_05 = 0;
			if(isdefined(var_04["CLEAR"]))
			{
				var_05 = 1;
			}

			var_04["CLEAR"] = undefined;
			foreach(var_08, var_07 in var_04)
			{
				if(isdefined(level._audio.indexed.var_1540[var_08]) && !var_05)
				{
					level._audio.indexed.var_1540[var_08] = level._audio.indexed.var_1540[var_08] * var_07.var_1511;
					continue;
				}

				if(var_05 && !isdefined(level._audio.indexed.var_1540[var_08]))
				{
					level._audio.indexed.var_1540[var_08] = 1;
					continue;
				}

				if(!var_05)
				{
					level._audio.indexed.var_1540[var_08] = var_07.var_1511;
				}
			}

			if(var_05)
			{
				level._audio.indexed.var_1503[var_10] = undefined;
			}

			continue;
		}

		if(isdefined(level._audio.indexed.var_1504[var_10]))
		{
			var_09 = level._audio.indexed.var_1504[var_10];
			var_05 = 0;
			if(isdefined(var_09.var_151D))
			{
				var_05 = 1;
			}

			foreach(var_08, var_0B in var_09.var_153A)
			{
				if(!isdefined(var_01[var_08]))
				{
					var_01[var_08] = 1;
				}

				if(!var_05)
				{
					var_0C = var_09.var_1539[var_08];
					var_0D = var_09.var_153A[var_08];
					var_0E = var_09.var_151B;
					var_0F = var_0E * var_0C - var_0D + var_0D;
					var_01[var_08] = var_01[var_08] * var_0F;
				}
			}

			if(var_05)
			{
				level._audio.indexed.var_1504[var_10] = undefined;
			}
		}
	}

	foreach(var_12, var_0B in var_01)
	{
		if(isdefined(level._audio.indexed.var_1540[var_12]))
		{
			level._audio.indexed.var_1540[var_12] = level._audio.indexed.var_1540[var_12] * var_0B;
			continue;
		}

		level._audio.indexed.var_1540[var_12] = var_0B;
	}
}

//Function Number: 47
func_1545()
{
	var_00 = undefined;
	var_01 = undefined;
}

//Function Number: 48
func_1546(param_00)
{
	if(level._audio.indexed.var_14FF)
	{
		while(!isdefined(level.player))
		{
			wait 0.05;
		}

		func_1535(param_00);
	}
}

//Function Number: 49
func_1547(param_00,param_01,param_02)
{
	if(!isdefined(level._audio.indexed.var_1548))
	{
		level._audio.indexed.var_1548 = [];
		level._audio.indexed.var_1549 = 0;
	}

	var_03 = 0;
	foreach(var_06, var_05 in level._audio.indexed.var_1548)
	{
		if(var_05["volmod"] == param_00)
		{
			var_03 = 1;
			level._audio.indexed.var_1548[var_06]["volume"] = param_01;
			level._audio.indexed.var_1548[var_06]["fade_time"] = param_02;
			break;
		}
	}

	if(!var_03)
	{
		var_07 = [];
		level._audio.indexed.var_1548[level._audio.indexed.var_1549] = var_7B;
		level._audio.indexed.var_1549++ = var_7B["fade_time"];
	}
}

//Function Number: 50
func_154A(param_00,param_01,param_02)
{
	if(!isdefined(level._audio.indexed.var_154B))
	{
		level._audio.indexed.var_154B = [];
		level._audio.indexed.index = 0;
	}

	var_03 = 0;
	foreach(var_06, var_05 in level._audio.indexed.var_154B)
	{
		if(var_05["channel"] == param_00)
		{
			var_03 = 1;
			level._audio.indexed.var_154B[var_06]["volume"] = param_01;
			level._audio.indexed.var_154B[var_06]["fade_time"] = param_02;
			break;
		}
	}

	if(!var_03)
	{
		var_07 = [];
		level._audio.indexed.var_154B[level._audio.indexed.index] = var_7B;
		level._audio.indexed.index++ = var_7B["fade_time"];
	}
}

//Function Number: 51
func_154C(param_00)
{
	if(!isdefined(level._audio.indexed.var_1548))
	{
		level._audio.indexed.var_1548 = [];
		level._audio.indexed.var_1549 = 0;
	}

	var_01 = 5;
	if(isdefined(param_00))
	{
		var_01 = param_00;
		var_01 = max(var_01,1);
	}

	for(;;)
	{
		level waittill("aud_new_volmod_set");
		while(level._audio.indexed.var_1548.size > 0)
		{
			var_02 = 0;
			var_03 = [];
			foreach(var_0A, var_05 in level._audio.indexed.var_1548)
			{
				if(var_02 < var_01)
				{
					var_02++;
					var_03[var_03.size] = var_0A;
					var_06 = level._audio.indexed.var_1548[var_0A];
					var_07 = var_06["volmod"];
					var_08 = var_06["volume"];
					var_09 = var_06["fade_time"];
					var_08 = clamp(var_08,0,1);
					level.player setvolmod(var_07,var_08,var_09);
					continue;
				}

				break;
			}

			for(var_0B = 0;var_0B < var_03.size;var_0B++)
			{
				var_0C = var_03[var_0B];
				level._audio.indexed.var_1548[var_0C] = undefined;
			}

			wait 0.05;
		}
	}
}

//Function Number: 52
func_154D(param_00)
{
	if(!isdefined(level._audio.indexed.var_154B))
	{
		level._audio.indexed.var_154B = [];
		level._audio.indexed.index = 0;
	}

	var_01 = 5;
	if(isdefined(param_00))
	{
		var_01 = param_00;
		var_01 = max(var_01,1);
	}

	for(;;)
	{
		level waittill("aud_new_mix_set");
		while(level._audio.indexed.var_154B.size > 0)
		{
			var_02 = 0;
			var_03 = [];
			foreach(var_0A, var_05 in level._audio.indexed.var_154B)
			{
				if(var_02 < var_01)
				{
					var_02++;
					var_03[var_03.size] = var_0A;
					var_06 = level._audio.indexed.var_154B[var_0A];
					var_07 = var_06["channel"];
					var_08 = var_06["volume"];
					var_09 = var_06["fade_time"];
					var_08 = clamp(var_08,0,1);
					level.player setchannelvolume(var_07,var_08,var_09);
					continue;
				}

				break;
			}

			for(var_0B = 0;var_0B < var_03.size;var_0B++)
			{
				var_0C = var_03[var_0B];
				level._audio.indexed.var_154B[var_0C] = undefined;
			}

			wait 0.05;
		}
	}
}

//Function Number: 53
func_154E(param_00,param_01)
{
	var_02 = [];
	var_03 = maps\_audio::get_mix_stringtable();
	var_04 = "soundtables/common_mix.csv";
	if(!isdefined(level._audio.indexed.preset_cache))
	{
		level._audio.indexed.preset_cache = [];
	}

	if(isdefined(level._audio.indexed.preset_cache[param_00]))
	{
		var_02 = level._audio.indexed.preset_cache[param_00];
	}
	else
	{
		if(param_01)
		{
			var_02 = func_1550(var_03,param_00,0);
		}

		if(!isdefined(var_02) || var_02.size == 0)
		{
			var_02 = func_1550(var_04,param_00,1);
		}

		if(!isdefined(var_02) || var_02.size == 0)
		{
			return;
		}

		level._audio.indexed.preset_cache[param_00] = var_02;
	}

	return var_02;
}

//Function Number: 54
func_1550(param_00,param_01,param_02)
{
	var_03 = 4;
	var_04 = "";
	var_05 = 0;
	var_06 = 0;
	var_07 = 0;
	var_08 = undefined;
	var_09 = [];
	if(!isdefined(level._audio.indexed.var_1551))
	{
		level._audio.indexed.var_1551 = [];
	}

	if(!isdefined(level._audio.indexed.var_1551[param_00]))
	{
		level._audio.indexed.var_1551[param_00] = [];
		for(var_0A = 1;var_0A < var_03;var_0A++)
		{
			var_0B = tablelookupbyrow(param_00,0,var_0A);
			level._audio.indexed.var_1551[param_00][var_0B] = var_0A;
		}
	}

	var_0C = maps\_audio::get_indexed_preset("mix",param_01,param_02);
	if(var_0C != -1)
	{
		var_05 = var_0C;
	}
	else if((param_02 && maps\_audio::aud_is_common_indexed()) || !param_02 && maps\_audio::aud_is_local_indexed())
	{
		return var_09;
	}

	var_0D = 0;
	while(var_04 != "EOF" && var_07 < 10)
	{
		var_04 = tablelookupbyrow(param_00,var_05,0);
		if(var_04 != "")
		{
			var_07 = 0;
		}

		while(var_04 == param_01)
		{
			var_06 = 1;
			if(!isdefined(var_08))
			{
				var_0E = level._audio.indexed.var_1551[param_00]["fade_time"];
				var_08 = tablelookupbyrow(param_00,var_05,var_0E);
				if(!isdefined(var_08) || isdefined(var_08) && var_08 == "")
				{
					var_08 = 1;
				}
			}

			var_0F = level._audio.indexed.var_1551[param_00]["channels"];
			var_10 = level._audio.indexed.var_1551[param_00]["value"];
			var_11 = tablelookupbyrow(param_00,var_05,var_0F);
			var_12 = tablelookupbyrow(param_00,var_05,var_10);
			if(var_11 == "set_all" || var_11 == "setall")
			{
				if(float(var_12) < 1)
				{
					var_09 = func_155C(float(var_12));
				}
			}
			else
			{
				if(!isdefined(level._audio.indexed.var_1555[var_11]))
				{
					maps\_audio::aud_print_error("In soundtable " + param_00 + ", " + param_01 + " uses a volmod group name that doesn\'t exist in the volmodgroups.csv file.");
					return;
				}

				var_09[var_11] = float(var_12);
			}

			var_05++;
			var_04 = tablelookupbyrow(param_00,var_05,0);
			var_0D++;
		}

		var_07++;
		if(var_06)
		{
			break;
		}

		var_05++;
	}

	if(var_06 && isdefined(var_08))
	{
		var_09["fade_time"] = float(var_08);
	}

	return var_09;
}

//Function Number: 55
func_1556(param_00)
{
	if(!isdefined(level._audio.indexed.preset_cache))
	{
		level._audio.indexed.preset_cache = [];
	}

	var_01 = [];
	if(isdefined(level._audio.indexed.preset_cache[param_00]))
	{
		var_01 = level._audio.indexed.preset_cache[param_00];
	}
	else
	{
		var_01 = undefined;
		if(level._audio.indexed.use_string_table_presets)
		{
			var_01 = func_154E(param_00,1);
		}
		else
		{
			var_01 = func_154E(param_00,0);
			if(!isdefined(var_01) || var_01.size == 0)
			{
				var_01 = maps\_audio::audio_presets_mix(param_00,var_01);
			}
		}

		if(!isdefined(var_01) || var_01.size == 0)
		{
			return;
		}

		if(!isdefined(var_7B["fade_time"]))
		{
		}

		level._audio.indexed.preset_cache[var_01] = var_7B;
	}

	return var_7B;
}

//Function Number: 56
func_1558()
{
	if(!isdefined(level._audio.indexed.var_1555))
	{
		func_155D();
	}

	level._audio.indexed.var_1529 = [];
	foreach(var_02, var_01 in level._audio.indexed.var_1555)
	{
		level._audio.indexed.var_1529[var_02] = spawnstruct();
		level._audio.indexed.var_1529[var_02].volume = var_01;
		level._audio.indexed.var_1529[var_02].completedindex = 0;
	}

	func_1559();
}

//Function Number: 57
func_1559()
{
	if(!isdefined(level._audio.indexed.var_152C))
	{
		var_00 = [];
		level._audio.indexed.var_152C = var_7B;
	}
}

//Function Number: 58
func_155A()
{
	return level._audio.indexed.var_155B;
}

//Function Number: 59
func_155C(param_00)
{
	var_01 = [];
	foreach(var_04, var_03 in level._audio.indexed.var_1555)
	{
		if(var_04 != "hud" && var_04 != "interface" && var_04 != "interface_music")
		{
			var_01[var_04] = param_00;
		}
	}

	return var_01;
}

//Function Number: 60
func_155D()
{
	var_00 = "soundaliases/volumemodgroups.svmod";
	level._audio.indexed.var_1555 = [];
	var_01 = 10;
	var_02 = 0;
	for(var_03 = 0;var_02 < var_01;var_03++)
	{
		var_04 = tablelookupbyrow(var_00,var_03,0);
		if(var_04 == "")
		{
			var_02++;
			continue;
		}

		var_05 = getsubstr(var_04,0,0);
		if(var_05 == "#")
		{
			continue;
		}

		var_06 = tablelookupbyrow(var_00,var_03,1);
		level._audio.indexed.var_1555[var_04] = float(var_06);
	}

	if(!isdefined(level._audio.var_1503))
	{
		level._audio.var_1503 = [];
	}

	level._audio.indexed.var_1503["default"] = [];
	foreach(var_04, var_08 in level._audio.indexed.var_1555)
	{
		level._audio.indexed.var_1503["default"][var_04] = spawnstruct();
		level._audio.indexed.var_1503["default"][var_04].var_1511 = var_08;
		level._audio.indexed.var_1503["default"][var_04].var_1512 = var_08;
	}
}

//Function Number: 61
func_155E(param_00)
{
	return isdefined(level._audio.indexed.var_152C[param_00]);
}

//Function Number: 62
func_155F(param_00)
{
	return isdefined(level._audio.indexed.var_1555[param_00]);
}