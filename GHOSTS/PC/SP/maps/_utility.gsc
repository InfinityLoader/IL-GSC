/*******************************************************************
 * Decompiled By: Bog
 * Decompiled File: maps\_utility.gsc
 * Game: Call of Duty: Ghosts
 * Platform: PC
 * Function Count: 790
 * Decompile Time: 13072 ms
 * Timestamp: 10/27/2023 1:26:00 AM
*******************************************************************/

//Function Number: 1
set_hudoutline(param_00,param_01)
{
	var_02 = undefined;
	param_00 = tolower(param_00);
	var_03["friendly"] = 3;
	var_03["enemy"] = 4;
	var_03["objective"] = 5;
	var_03["neutral"] = 0;
	var_02 = var_03[param_00];
	self hudoutlineenable(var_02,param_01);
}

//Function Number: 2
func_47D0()
{
	if(issplitscreen() || getdvar("coop") == "1")
	{
		return 1;
	}

	return 0;
}

//Function Number: 3
func_47D1()
{
	if(issplitscreen())
	{
		return 0;
	}

	if(!func_47D0())
	{
		return 0;
	}

	return 1;
}

//Function Number: 4
func_4825(param_00)
{
	if(param_00 ent_flag_exist("laststand_downed"))
	{
		return param_00 ent_flag("laststand_downed");
	}

	if(isdefined(param_00.laststand))
	{
		return param_00.laststand;
	}

	return !isalive(param_00);
}

//Function Number: 5
func_4826(param_00)
{
	if(!isdefined(param_00.down_part2_proc_ran))
	{
		return 0;
	}

	return param_00.down_part2_proc_ran;
}

//Function Number: 6
killing_will_down(param_00)
{
	if(laststand_enabled())
	{
		if(isdefined(level.var_4CA5))
		{
			return param_00 [[ level.var_4CA5 ]]();
		}
	}

	return 0;
}

//Function Number: 7
is_survival()
{
	return func_4840() && getdvarint("so_survival") > 0;
}

//Function Number: 8
laststand_enabled()
{
	return isdefined(level.var_4CA8) && level.var_4CA8 > 0;
}

//Function Number: 9
func_4840()
{
	return getdvarint("specialops") >= 1;
}

//Function Number: 10
convert_to_time_string(param_00,param_01)
{
	var_02 = "";
	if(param_00 < 0)
	{
		var_02 = var_02 + "-";
	}

	param_00 = func_688C(param_00,1,0);
	var_03 = param_00 * 100;
	var_03 = int(var_03);
	var_03 = abs(var_03);
	var_04 = var_03 / 6000;
	var_04 = int(var_04);
	var_02 = var_02 + var_04;
	var_05 = var_03 / 100;
	var_05 = int(var_05);
	var_05 = var_05 - var_04 * 60;
	if(var_05 < 10)
	{
		var_02 = var_02 + ":0" + var_05;
	}
	else
	{
		var_02 = var_02 + ":" + var_05;
	}

	if(isdefined(param_01) && param_01)
	{
		var_06 = var_03;
		var_06 = var_06 - var_04 * 6000;
		var_06 = var_06 - var_05 * 100;
		var_06 = int(var_06 / 10);
		var_02 = var_02 + "." + var_06;
	}

	return var_02;
}

//Function Number: 11
func_688C(param_00,param_01,param_02)
{
	param_01 = int(param_01);
	if(param_01 < 0 || param_01 > 4)
	{
		return param_00;
	}

	var_03 = 1;
	for(var_04 = 1;var_04 <= param_01;var_04++)
	{
		var_03 = var_03 * 10;
	}

	var_05 = param_00 * var_03;
	if(!isdefined(param_02) || param_02)
	{
		var_05 = floor(var_05);
	}
	else
	{
		var_05 = ceil(var_05);
	}

	param_00 = var_05 / var_03;
	return param_00;
}

//Function Number: 12
func_688D(param_00,param_01,param_02)
{
	var_03 = param_00 / 1000;
	var_03 = func_688C(var_03,param_01,param_02);
	param_00 = var_03 * 1000;
	return int(param_00);
}

//Function Number: 13
set_vision_set(param_00,param_01)
{
	if(maps\_utility_code::func_45CA(param_00))
	{
	}

	if(!isdefined(param_01))
	{
		param_01 = 1;
	}

	visionsetnaked(param_00,param_01);
	setdvar("vision_set_current",param_00);
}

//Function Number: 14
func_6FC0(param_00,param_01)
{
	if(maps\_utility_code::func_45CA(param_00))
	{
	}

	if(!isdefined(param_01))
	{
		param_01 = 1;
	}

	self visionsetnakedforplayer(param_00,param_01);
}

//Function Number: 15
func_7D3B(param_00,param_01,param_02)
{
	param_02 = int(param_02 * 20);
	var_03 = [];
	for(var_04 = 0;var_04 < 3;var_04++)
	{
		var_03[var_04] = param_00[var_04] - param_01[var_04] / param_02;
	}

	var_05 = [];
	for(var_04 = 0;var_04 < param_02;var_04++)
	{
		wait(0.05);
		for(var_06 = 0;var_06 < 3;var_06++)
		{
			var_05[var_06] = param_00[var_06] - var_03[var_06] * var_04;
		}

		setsunlight(var_05[0],var_05[1],var_05[2]);
	}

	setsunlight(param_01[0],param_01[1],param_01[2]);
}

//Function Number: 16
ent_flag_wait(param_00)
{
	while(isdefined(self) && !self.ent_flag[param_00])
	{
		self waittill(param_00);
	}
}

//Function Number: 17
ent_flag_wait_vehicle_node(param_00)
{
	while(isdefined(self) && !self.ent_flag[param_00])
	{
		self waittill(param_00);
	}
}

//Function Number: 18
ent_flag_wait_either(param_00,param_01)
{
	while(isdefined(self))
	{
		if(ent_flag(param_00))
		{
		}

		if(ent_flag(param_01))
		{
		}

		common_scripts\utility::func_8B4F(param_00,param_01);
	}
}

//Function Number: 19
ent_flag_wait_or_timeout(param_00,param_01)
{
	var_02 = gettime();
	while(isdefined(self))
	{
		if(self.ent_flag[param_00])
		{
			break;
		}

		if(gettime() >= var_02 + param_01 * 1000)
		{
			break;
		}

		maps\_utility_code::ent_wait_for_flag_or_time_elapses(param_00,param_01);
	}
}

//Function Number: 20
ent_flag_waitopen(param_00)
{
	while(isdefined(self) && self.ent_flag[param_00])
	{
		self waittill(param_00);
	}
}

//Function Number: 21
ent_flag_assert(param_00)
{
}

//Function Number: 22
func_2F4F(param_00,param_01)
{
	while(isdefined(self))
	{
		if(!ent_flag(param_00))
		{
		}

		if(!ent_flag(param_01))
		{
		}

		common_scripts\utility::func_8B4F(param_00,param_01);
	}
}

//Function Number: 23
func_2F47(param_00)
{
	if(!isdefined(self.ent_flag))
	{
		self.ent_flag = [];
		self.ent_flags_lock = [];
	}

	self.ent_flag[param_00] = 0;
}

//Function Number: 24
ent_flag_exist(param_00)
{
	if(isdefined(self.ent_flag) && isdefined(self.ent_flag[param_00]))
	{
		return 1;
	}

	return 0;
}

//Function Number: 25
func_2F49(param_00,param_01)
{
	self endon("death");
	wait(param_01);
	func_2F48(param_00);
}

//Function Number: 26
func_2F48(param_00)
{
	self.ent_flag[param_00] = 1;
	self notify(param_00);
}

//Function Number: 27
func_2F44(param_00,param_01)
{
	if(self.ent_flag[param_00])
	{
		self.ent_flag[param_00] = 0;
		self notify(param_00);
	}

	if(isdefined(param_01) && param_01)
	{
		self.ent_flag[param_00] = undefined;
	}
}

//Function Number: 28
func_2F45(param_00,param_01)
{
	wait(param_01);
	func_2F44(param_00);
}

//Function Number: 29
ent_flag(param_00)
{
	return self.ent_flag[param_00];
}

//Function Number: 30
get_closest_to_player_view(param_00,param_01,param_02,param_03)
{
	if(!param_00.size)
	{
	}

	if(!isdefined(param_01))
	{
		param_01 = level.player;
	}

	if(!isdefined(param_03))
	{
		param_03 = -1;
	}

	var_04 = param_01.origin;
	if(isdefined(param_02) && param_02)
	{
		var_04 = param_01 geteye();
	}

	var_05 = undefined;
	var_06 = param_01 getplayerangles();
	var_07 = anglestoforward(var_06);
	var_08 = -1;
	foreach(var_0A in param_00)
	{
		var_0B = vectortoangles(var_0A.origin - var_04);
		var_0C = anglestoforward(var_0B);
		var_0D = vectordot(var_07,var_0C);
		if(var_0D < var_08)
		{
			continue;
		}

		if(var_0D < param_03)
		{
			continue;
		}

		var_08 = var_0D;
		var_05 = var_0A;
	}

	return var_05;
}

//Function Number: 31
func_380E(param_00,param_01,param_02)
{
	if(!param_00.size)
	{
	}

	if(!isdefined(param_01))
	{
		param_01 = level.player;
	}

	var_03 = param_01.origin;
	if(isdefined(param_02) && param_02)
	{
		var_03 = param_01 geteye();
	}

	var_04 = undefined;
	var_05 = param_01 getplayerangles();
	var_06 = anglestoforward(var_05);
	var_07 = -1;
	for(var_08 = 0;var_08 < param_00.size;var_08++)
	{
		var_09 = vectortoangles(param_00[var_08].origin - var_03);
		var_0A = anglestoforward(var_09);
		var_0B = vectordot(var_06,var_0A);
		if(var_0B < var_07)
		{
			continue;
		}

		var_07 = var_0B;
		var_04 = var_08;
	}

	return var_04;
}

//Function Number: 32
flag_trigger_init(param_00,param_01,param_02)
{
	common_scripts\utility::func_3385(param_00);
	if(!isdefined(param_02))
	{
		param_02 = 0;
	}

	param_01 thread maps\_utility_code::_flag_wait_trigger(param_00,param_02);
	return param_01;
}

//Function Number: 33
func_3391(param_00,param_01,param_02)
{
	common_scripts\utility::func_3385(param_00);
	if(!isdefined(param_02))
	{
		param_02 = 0;
	}

	for(var_03 = 0;var_03 < param_01.size;var_03++)
	{
		param_01[var_03] thread maps\_utility_code::_flag_wait_trigger(param_00,0);
	}

	return param_01;
}

//Function Number: 34
func_337D(param_00,param_01)
{
	wait(param_01);
	common_scripts\utility::func_337C(param_00);
}

//Function Number: 35
func_4DA3()
{
	if(func_0EBE())
	{
	}

	if(level.var_52F1)
	{
	}

	if(common_scripts\utility::flag("game_saving"))
	{
	}

	for(var_00 = 0;var_00 < level.players.size;var_00++)
	{
		var_01 = level.players[var_00];
		if(!isalive(var_01))
		{
		}
	}

	common_scripts\utility::flag_set("game_saving");
	var_02 = "levelshots / autosave / autosave_" + level.script + "end";
	savegame("levelend",&"AUTOSAVE_AUTOSAVE",var_02,1);
	common_scripts\utility::func_337C("game_saving");
}

//Function Number: 36
add_extra_autosave_check(param_00,param_01,param_02)
{
	level._extra_autosave_checks[param_00] = [];
	level._extra_autosave_checks[param_00]["func"] = param_01;
	level._extra_autosave_checks[param_00]["msg"] = param_02;
}

//Function Number: 37
func_6523(param_00)
{
	level._extra_autosave_checks[param_00] = undefined;
}

//Function Number: 38
func_11C5()
{
	thread autosave_by_name_thread("autosave_stealth",8,1);
}

//Function Number: 39
autosave_stealth_silent()
{
	thread autosave_by_name_thread("autosave_stealth",8,1,1);
}

//Function Number: 40
autosave_tactical()
{
	maps\_utility_code::func_11CC();
	thread maps\_utility_code::autosave_tactical_proc();
}

//Function Number: 41
autosave_by_name(param_00)
{
	thread autosave_by_name_thread(param_00);
}

//Function Number: 42
autosave_by_name_silent(param_00)
{
	thread autosave_by_name_thread(param_00,undefined,undefined,1);
}

//Function Number: 43
autosave_by_name_thread(param_00,param_01,param_02,param_03)
{
	if(!isdefined(level.curautosave))
	{
		level.curautosave = 1;
	}

	var_04 = "levelshots/autosave/autosave_" + level.script + level.curautosave;
	var_05 = level maps\_autosave::func_83F8(level.curautosave,"autosave",var_04,param_01,param_02,param_03);
	if(isdefined(var_05) && var_05)
	{
		level.curautosave++;
	}
}

//Function Number: 44
autosave_or_timeout(param_00,param_01)
{
	thread autosave_by_name_thread(param_00,param_01);
}

//Function Number: 45
debug_message(param_00,param_01,param_02,param_03)
{
	if(!isdefined(param_02))
	{
		param_02 = 5;
	}

	if(isdefined(param_03))
	{
		param_03 endon("death");
		param_01 = param_03.origin;
	}

	for(var_04 = 0;var_04 < param_02 * 20;var_04++)
	{
		if(!isdefined(param_03))
		{
		}
		else
		{
		}

		wait(0.05);
	}
}

//Function Number: 46
func_23F8(param_00,param_01)
{
	self notify("debug_message_ai");
	self endon("debug_message_ai");
	self endon("death");
	if(!isdefined(param_01))
	{
		param_01 = 5;
	}

	for(var_02 = 0;var_02 < param_01 * 20;var_02++)
	{
		wait(0.05);
	}
}

//Function Number: 47
func_23F9(param_00,param_01,param_02,param_03)
{
	if(isdefined(param_03))
	{
		level notify(param_00 + param_03);
		level endon(param_00 + param_03);
	}
	else
	{
		level notify(param_00);
		level endon(param_00);
	}

	if(!isdefined(param_02))
	{
		param_02 = 5;
	}

	for(var_04 = 0;var_04 < param_02 * 20;var_04++)
	{
		wait(0.05);
	}
}

//Function Number: 48
func_6101(param_00)
{
	var_01 = spawn("script_model",(0,0,0));
	var_01.origin = level.player getorigin();
	var_01 setmodel(param_00);
	var_01 delete();
}

//Function Number: 49
closerfunc(param_00,param_01)
{
	return param_00 >= param_01;
}

//Function Number: 50
func_31E4(param_00,param_01)
{
	return param_00 <= param_01;
}

//Function Number: 51
getclosestfx(param_00,param_01,param_02)
{
	return maps\_utility_code::comparesizesfx(param_00,param_01,param_02,::closerfunc);
}

//Function Number: 52
func_3813(param_00,param_01,param_02)
{
	var_03 = param_01[0];
	var_04 = distance(param_00,var_03);
	for(var_05 = 0;var_05 < param_01.size;var_05++)
	{
		var_06 = distance(param_00,param_01[var_05]);
		if(var_06 >= var_04)
		{
			continue;
		}

		var_04 = var_06;
		var_03 = param_01[var_05];
	}

	if(!isdefined(param_02) || var_04 <= param_02)
	{
		return var_03;
	}

	return undefined;
}

//Function Number: 53
func_387B(param_00,param_01)
{
	if(param_01.size < 1)
	{
	}

	var_02 = distance(param_01[0] getorigin(),param_00);
	var_03 = param_01[0];
	for(var_04 = 0;var_04 < param_01.size;var_04++)
	{
		var_05 = distance(param_01[var_04] getorigin(),param_00);
		if(var_05 < var_02)
		{
			continue;
		}

		var_02 = var_05;
		var_03 = param_01[var_04];
	}

	return var_03;
}

//Function Number: 54
get_within_range(param_00,param_01,param_02)
{
	var_03 = [];
	for(var_04 = 0;var_04 < param_01.size;var_04++)
	{
		if(distance(param_01[var_04].origin,param_00) <= param_02)
		{
			var_03[var_03.size] = param_01[var_04];
		}
	}

	return var_03;
}

//Function Number: 55
get_outside_range(param_00,param_01,param_02)
{
	var_03 = [];
	for(var_04 = 0;var_04 < param_01.size;var_04++)
	{
		if(distance(param_01[var_04].origin,param_00) > param_02)
		{
			var_03[var_03.size] = param_01[var_04];
		}
	}

	return var_03;
}

//Function Number: 56
func_380F(param_00,param_01,param_02)
{
	if(!isdefined(param_02))
	{
		param_02 = 9999999;
	}

	if(param_01.size < 1)
	{
	}

	var_03 = undefined;
	for(var_04 = 0;var_04 < param_01.size;var_04++)
	{
		if(!isalive(param_01[var_04]))
		{
			continue;
		}

		var_05 = distance(param_01[var_04].origin,param_00);
		if(var_05 >= param_02)
		{
			continue;
		}

		param_02 = var_05;
		var_03 = param_01[var_04];
	}

	return var_03;
}

//Function Number: 57
func_389F(param_00,param_01,param_02)
{
	if(!param_02.size)
	{
	}

	var_03 = undefined;
	var_04 = vectortoangles(param_01 - param_00);
	var_05 = anglestoforward(var_04);
	var_06 = -1;
	foreach(var_08 in param_02)
	{
		var_04 = vectortoangles(var_08.origin - param_00);
		var_09 = anglestoforward(var_04);
		var_0A = vectordot(var_05,var_09);
		if(var_0A < var_06)
		{
			continue;
		}

		var_06 = var_0A;
		var_03 = var_08;
	}

	return var_03;
}

//Function Number: 58
func_380D(param_00,param_01,param_02)
{
	if(!isdefined(param_02))
	{
		param_02 = 9999999;
	}

	if(param_01.size < 1)
	{
	}

	var_03 = undefined;
	foreach(var_07, var_05 in param_01)
	{
		var_06 = distance(var_05.origin,param_00);
		if(var_06 >= param_02)
		{
			continue;
		}

		param_02 = var_06;
		var_03 = var_07;
	}

	return var_03;
}

//Function Number: 59
func_380C(param_00,param_01,param_02)
{
	if(!isdefined(param_01))
	{
		return undefined;
	}

	var_03 = 0;
	if(isdefined(param_02) && param_02.size)
	{
		var_04 = [];
		for(var_05 = 0;var_05 < param_01.size;var_05++)
		{
			var_04[var_05] = 0;
		}

		for(var_05 = 0;var_05 < param_01.size;var_05++)
		{
			for(var_06 = 0;var_06 < param_02.size;var_06++)
			{
				if(param_01[var_05] == param_02[var_06])
				{
					var_04[var_05] = 1;
				}
			}
		}

		var_07 = 0;
		for(var_05 = 0;var_05 < param_01.size;var_05++)
		{
			if(!var_04[var_05] && isdefined(param_01[var_05]))
			{
				var_07 = 1;
				var_03 = distance(param_00,param_01[var_05].origin);
				var_08 = var_05;
				var_05 = param_01.size + 1;
			}
		}

		if(!var_07)
		{
			return undefined;
		}
	}
	else
	{
		for(var_05 = 0;var_05 < param_01.size;var_05++)
		{
			if(isdefined(param_01[var_05]))
			{
				var_03 = distance(param_00,param_01[0].origin);
				var_08 = var_05;
				var_05 = param_01.size + 1;
			}
		}
	}

	var_08 = undefined;
	for(var_05 = 0;var_05 < param_01.size;var_05++)
	{
		if(isdefined(param_01[var_05]))
		{
			var_04 = 0;
			if(isdefined(param_02))
			{
				for(var_06 = 0;var_06 < param_02.size;var_06++)
				{
					if(param_01[var_05] == param_02[var_06])
					{
						var_04 = 1;
					}
				}
			}

			if(!var_04)
			{
				var_09 = distance(param_00,param_01[var_05].origin);
				if(var_09 <= var_03)
				{
					var_03 = var_09;
					var_08 = var_05;
				}
			}
		}
	}

	if(isdefined(var_08))
	{
		return param_01[var_08];
	}

	return undefined;
}

//Function Number: 60
func_3811(param_00)
{
	if(level.players.size == 1)
	{
		return level.player;
	}

	var_01 = common_scripts\utility::func_3A56(param_00,level.players);
	return var_01;
}

//Function Number: 61
get_closest_player_healthy(param_00)
{
	if(level.players.size == 1)
	{
		return level.player;
	}

	var_01 = func_3958();
	var_02 = common_scripts\utility::func_3A56(param_00,var_01);
	return var_02;
}

//Function Number: 62
func_3958()
{
	var_00 = [];
	foreach(var_02 in level.players)
	{
		if(func_4825(var_02))
		{
			continue;
		}

		var_00[var_00.size] = var_02;
	}

	return var_00;
}

//Function Number: 63
func_3807(param_00,param_01,param_02)
{
	if(isdefined(param_01))
	{
		var_03 = getaiarray(param_01);
	}
	else
	{
		var_03 = getaiarray();
	}

	if(var_03.size == 0)
	{
		return undefined;
	}

	if(isdefined(param_02))
	{
		var_03 = common_scripts\utility::array_remove_array(var_03,param_02);
	}

	return common_scripts\utility::func_3A56(param_00,var_03);
}

//Function Number: 64
func_3808(param_00,param_01,param_02)
{
	if(isdefined(param_01))
	{
		var_03 = getaiarray(param_01);
	}
	else
	{
		var_03 = getaiarray();
	}

	if(var_03.size == 0)
	{
		return undefined;
	}

	return func_380C(param_00,var_03,param_02);
}

//Function Number: 65
func_396C(param_00,param_01,param_02,param_03)
{
	if(!isdefined(param_03))
	{
		param_03 = distance(param_00,param_01);
	}

	param_03 = max(0.01,param_03);
	var_04 = vectornormalize(param_01 - param_00);
	var_05 = param_02 - param_00;
	var_06 = vectordot(var_05,var_04);
	var_06 = var_06 / param_03;
	var_06 = clamp(var_06,0,1);
	return var_06;
}

//Function Number: 66
can_see_origin(param_00,param_01)
{
	if(!isdefined(param_01))
	{
		param_01 = 1;
	}

	if(!func_6088(param_00))
	{
		return 0;
	}

	if(!sighttracepassed(self geteye(),param_00,param_01,self))
	{
		return 0;
	}

	return 1;
}

//Function Number: 67
func_6088(param_00)
{
	var_01 = anglestoforward(self.angles);
	var_02 = vectornormalize(param_00 - self.origin);
	var_03 = vectordot(var_01,var_02);
	return var_03 > 0.766;
}

//Function Number: 68
func_7C38()
{
	self notify("stop_magic_bullet_shield");
	if(isai(self))
	{
		self.attackeraccuracy = 1;
	}

	self.magic_bullet_shield = undefined;
	self.damageshield = 0;
	self notify("internal_stop_magic_bullet_shield");
}

//Function Number: 69
func_4FD5()
{
}

//Function Number: 70
magic_bullet_shield(param_00)
{
	if(isai(self))
	{
	}
	else
	{
		self.health = 100000;
	}

	self endon("internal_stop_magic_bullet_shield");
	if(isai(self))
	{
		self.attackeraccuracy = 0.1;
	}

	self notify("magic_bullet_shield");
	self.magic_bullet_shield = 1;
	self.damageshield = 1;
}

//Function Number: 71
func_2771()
{
	self.a.disablelongdeath = 1;
}

//Function Number: 72
func_2CBC()
{
	self.a.disablelongdeath = 0;
}

//Function Number: 73
enable_blood_pool()
{
	self.var_757E = undefined;
}

//Function Number: 74
func_274E()
{
	self.var_757E = 1;
}

//Function Number: 75
deletable_magic_bullet_shield()
{
	magic_bullet_shield(1);
}

//Function Number: 76
func_38B7()
{
	return self.ignoreme;
}

//Function Number: 77
set_ignoreme(param_00)
{
	self.ignoreme = param_00;
}

//Function Number: 78
set_ignoreall(param_00)
{
	self.ignoreall = param_00;
}

//Function Number: 79
func_6EB4(param_00)
{
	self.favoriteenemy = param_00;
}

//Function Number: 80
get_pacifist()
{
	return self.pacifist;
}

//Function Number: 81
func_6F3F(param_00)
{
	self.pacifist = param_00;
}

//Function Number: 82
func_43F9(param_00)
{
	self notify("new_ignore_me_timer");
	self endon("new_ignore_me_timer");
	self endon("death");
	if(!isdefined(self.var_43FA))
	{
		self.var_43FA = self.ignoreme;
	}

	var_01 = getaiarray("bad_guys");
	foreach(var_03 in var_01)
	{
		if(!isalive(var_03.enemy))
		{
			continue;
		}

		if(var_03.enemy != self)
		{
			continue;
		}

		var_03 clearenemy();
	}

	self.ignoreme = 1;
	wait(param_00);
	self.ignoreme = self.var_43FA;
	self.var_43FA = undefined;
}

//Function Number: 83
func_254D(param_00)
{
	common_scripts\_exploder::func_254E(param_00);
}

//Function Number: 84
hide_exploder_models(param_00)
{
	common_scripts\_exploder::func_41DE(param_00);
}

//Function Number: 85
func_74E0(param_00)
{
	common_scripts\_exploder::func_74E1(param_00);
}

//Function Number: 86
func_7C22(param_00)
{
	common_scripts\_exploder::func_7C23(param_00);
}

//Function Number: 87
func_3875(param_00)
{
	return common_scripts\_exploder::func_3876(param_00);
}

//Function Number: 88
flood_spawn(param_00)
{
	maps\_spawner::flood_spawner_scripted(param_00);
}

//Function Number: 89
func_34AA(param_00,param_01,param_02,param_03)
{
	if(!isdefined(param_01))
	{
		param_01 = 4;
	}

	thread force_crawling_death_proc(param_00,param_01,param_02,param_03);
}

//Function Number: 90
override_crawl_death_anims()
{
	if(isdefined(self.a.var_221E))
	{
		self.a.var_ED8["crawl"] = self.a.var_221E["crawl"];
		self.a.var_ED8["death"] = self.a.var_221E["death"];
		self.a.crawl_fx_rate = self.a.var_221E["blood_fx_rate"];
		if(isdefined(self.a.var_221E["blood_fx"]))
		{
			self.a.crawl_fx = self.a.var_221E["blood_fx"];
		}
	}

	self.a.var_ED8["stand_2_crawl"] = [];
	self.a.var_ED8["stand_2_crawl"][0] = %dying_stand_2_crawl_v3;
	if(isdefined(self.var_565E))
	{
		self.a.var_60B1 = "prone";
	}

	self orientmode("face angle",self.a.var_34A9);
	self.a.var_34A9 = undefined;
}

//Function Number: 91
force_crawling_death_proc(param_00,param_01,param_02,param_03)
{
	self.var_34D8 = 1;
	self.a.force_num_crawls = param_01;
	self.var_5674 = 1;
	self.var_565E = param_03;
	self.a.var_221E = param_02;
	self.crawlingpainanimoverridefunc = ::override_crawl_death_anims;
	self.maxhealth = 100000;
	self.health = 100000;
	func_2CBC();
	if(!isdefined(param_03) || param_03 == 0)
	{
		self.a.var_34A9 = param_00 + 181.02;
	}

	self.a.var_34A9 = param_00;
	thread animscripts/notetracks::notetrackposecrawl();
}

//Function Number: 92
func_7414()
{
	precacheshellshock("default");
	self waittill("death");
	if(isdefined(self.var_78EA))
	{
	}

	if(getdvar("r_texturebits") == "16")
	{
	}

	self shellshock("default",3);
}

//Function Number: 93
func_5FFB()
{
	self endon("death");
	self endon("stop_unresolved_collision_script");
	func_6600();
	childthread func_5FFC();
	for(;;)
	{
		if(self.unresolved_collision)
		{
			self.unresolved_collision = 0;
			if(self.unresolved_collision_count >= 20)
			{
				if(isdefined(self.handle_unresolved_collision))
				{
					self [[ self.handle_unresolved_collision ]]();
				}
				else
				{
					default_unresolved_collision_handler();
				}
			}
		}
		else
		{
			func_6600();
		}

		wait(0.05);
	}
}

//Function Number: 94
func_5FFC()
{
	for(;;)
	{
		self waittill("unresolved_collision");
		self.unresolved_collision = 1;
		self.unresolved_collision_count++;
	}
}

//Function Number: 95
func_6600()
{
	self.unresolved_collision = 0;
	self.unresolved_collision_count = 0;
}

//Function Number: 96
default_unresolved_collision_handler()
{
	var_00 = getnodesinradiussorted(self.origin,300,0,200,"Path");
	if(var_00.size)
	{
		self cancelmantle();
		self dontinterpolate();
		self setorigin(var_00[0].origin);
		func_6600();
	}

	self kill();
}

//Function Number: 97
func_7C45()
{
	self notify("stop_unresolved_collision_script");
	func_6600();
}

//Function Number: 98
delete_on_death_wait_sound(param_00,param_01)
{
	param_00 endon("death");
	self waittill("death");
	if(isdefined(param_00))
	{
		if(param_00 iswaitingonsound())
		{
			param_00 waittill(param_01);
		}

		param_00 delete();
	}
}

//Function Number: 99
is_dead_sentient()
{
	return issentient(self) && !isalive(self);
}

//Function Number: 100
func_5D25(param_00,param_01,param_02,param_03,param_04)
{
	if(is_dead_sentient())
	{
	}

	var_05 = spawn("script_origin",(0,0,0));
	var_05 endon("death");
	thread delete_on_death_wait_sound(var_05,"sounddone");
	if(isdefined(param_01))
	{
		var_05 linkto(self,param_01,(0,0,0),(0,0,0));
	}
	else
	{
		var_05.origin = self.origin;
		var_05.angles = self.angles;
		var_05 linkto(self);
	}

	var_05 playsound(param_00,"sounddone");
	if(isdefined(param_02))
	{
		if(!isdefined(maps\_utility_code::func_8A9A(var_05)))
		{
			var_05 stopsounds();
		}

		wait(0.05);
	}
	else
	{
		var_05 waittill("sounddone");
	}

	if(isdefined(param_03))
	{
		self notify(param_03);
	}

	var_05 delete();
}

//Function Number: 101
func_5D26(param_00,param_01)
{
	func_5D25(param_00,param_01,1);
}

//Function Number: 102
func_5D23(param_00,param_01)
{
	func_5D25(param_00,undefined,undefined,param_01);
}

//Function Number: 103
func_5CF5(param_00,param_01,param_02,param_03)
{
	var_04 = spawn("script_origin",(0,0,0));
	var_04 endon("death");
	if(!isdefined(param_02))
	{
		param_02 = 1;
	}

	if(param_02)
	{
		thread common_scripts\utility::delete_on_death(var_04);
	}

	if(!isdefined(param_03))
	{
		param_03 = 0;
	}

	if(param_03)
	{
		thread delete_on_removed(var_04);
	}

	if(isdefined(param_01))
	{
		var_04 linkto(self,param_01,(0,0,0),(0,0,0));
	}
	else
	{
		var_04.origin = self.origin;
		var_04.angles = self.angles;
		var_04 linkto(self);
	}

	var_04 playloopsound(param_00);
	self waittill("stop sound" + param_00);
	var_04 stoploopsound(param_00);
	var_04 delete();
}

//Function Number: 104
delete_on_removed(param_00)
{
	param_00 endon("death");
	while(isdefined(self))
	{
		wait(0.05);
	}

	if(isdefined(param_00))
	{
		param_00 delete();
	}
}

//Function Number: 105
func_6A9E()
{
	var_00 = getaiarray("allies");
	var_01 = 0;
	for(var_02 = 0;var_02 < var_00.size;var_02++)
	{
		if(isdefined(var_00[var_02].var_6BD8))
		{
			continue;
		}

		game["character" + var_01] = var_00[var_02] codescripts\character::func_6A9C();
		var_01++;
	}

	game["total characters"] = var_01;
}

//Function Number: 106
func_77BE(param_00)
{
	if(!isalive(param_00))
	{
		return 1;
	}

	if(!isdefined(param_00.finished_spawning))
	{
		param_00 common_scripts\utility::func_8B4F("finished spawning","death");
	}

	if(isalive(param_00))
	{
		return 0;
	}

	return 1;
}

//Function Number: 107
spawn_setcharacter(param_00)
{
	codescripts\character::func_6101(param_00);
	self waittill("spawned",var_01);
	if(func_77BE(var_01))
	{
	}

	var_01 codescripts\character::func_55AB();
	var_01 codescripts\character::load(param_00);
}

//Function Number: 108
func_4AA7(param_00,param_01)
{
	iprintlnbold(param_00,param_01["key1"]);
}

//Function Number: 109
func_89B4(param_00)
{
	self endon("death");
	for(;;)
	{
		maps\_debug::drawtag(param_00);
		wait(0.05);
	}
}

//Function Number: 110
assign_animtree(param_00)
{
	if(isdefined(param_00))
	{
		self.animname = param_00;
	}

	self useanimtree(level.var_6AED[self.animname]);
}

//Function Number: 111
assign_model()
{
	if(isarray(level.var_6AF3[self.animname]))
	{
		var_00 = randomint(level.var_6AF3[self.animname].size);
		self setmodel(level.var_6AF3[self.animname][var_00]);
	}

	self setmodel(level.var_6AF3[self.animname]);
}

//Function Number: 112
func_777F(param_00,param_01,param_02)
{
	if(!isdefined(param_01))
	{
		param_01 = (0,0,0);
	}

	var_03 = spawn("script_model",param_01);
	var_03.animname = param_00;
	var_03 assign_animtree();
	var_03 assign_model();
	if(isdefined(param_02))
	{
		var_03.angles = param_02;
	}

	return var_03;
}

//Function Number: 113
trigger_wait(param_00,param_01)
{
	var_02 = getent(param_00,param_01);
	if(!isdefined(var_02))
	{
	}

	var_02 waittill("trigger",var_03);
	level notify(param_00,var_03);
	return var_03;
}

//Function Number: 114
func_83B0(param_00)
{
	return trigger_wait(param_00,"targetname");
}

//Function Number: 115
set_flag_on_dead(param_00,param_01)
{
	thread func_6EC2(param_00,param_01,::func_8B46,"set_flag_on_dead");
}

//Function Number: 116
set_flag_on_dead_or_dying(param_00,param_01)
{
	thread func_6EC2(param_00,param_01,::func_8B47,"set_flag_on_dead_or_dying");
}

//Function Number: 117
set_flag_on_spawned(param_00,param_01)
{
	thread func_6EC2(param_00,param_01,::empty_func,"set_flag_on_spawned");
}

//Function Number: 118
empty_func(param_00)
{
}

//Function Number: 119
func_6EC6(param_00,param_01)
{
	self waittill("spawned",var_02);
	if(func_77BE(var_02))
	{
	}

	param_00.var_9D6[param_00.var_9D6.size] = var_02;
	func_2F48(param_01);
}

//Function Number: 120
func_6EC2(param_00,param_01,param_02,param_03)
{
	var_04 = spawnstruct();
	var_04.var_9D6 = [];
	foreach(var_06 in param_00)
	{
		var_06 func_2F47(param_03);
	}

	common_scripts\utility::func_F1B(param_00,::func_6EC6,var_04,param_03);
	foreach(var_06 in param_00)
	{
		var_06 ent_flag_wait(param_03);
	}

	[[ param_02 ]](var_04.var_9D6);
	common_scripts\utility::flag_set(param_01);
}

//Function Number: 121
func_6EC9(param_00,param_01)
{
	if(!common_scripts\utility::flag(param_01))
	{
		param_00 waittill("trigger",var_02);
		common_scripts\utility::flag_set(param_01);
		return var_02;
	}
}

//Function Number: 122
func_6EC7(param_00)
{
	if(common_scripts\utility::flag(param_00))
	{
	}

	var_01 = getent(param_00,"targetname");
	var_01 waittill("trigger");
	common_scripts\utility::flag_set(param_00);
}

//Function Number: 123
func_4803(param_00,param_01)
{
	for(var_02 = 0;var_02 < param_00.size;var_02++)
	{
		if(param_00[var_02] == param_01)
		{
			return 1;
		}
	}

	return 0;
}

//Function Number: 124
func_8B46(param_00,param_01,param_02)
{
	var_0A = spawnstruct();
	if(isdefined(param_02))
	{
		var_0A endon("thread_timed_out");
		var_0A thread func_8B4B(param_02);
	}

	var_0A.count = param_00.size;
	if(isdefined(param_01) && param_01 < var_0A.count)
	{
		var_0A.count = param_01;
	}

	common_scripts\utility::func_F1B(param_00,::func_8B4A,var_0A);
	while(var_0A.count > 0)
	{
		var_0A waittill("waittill_dead guy died");
	}
}

//Function Number: 125
func_8B47(param_00,param_01,param_02)
{
	var_03 = [];
	foreach(var_05 in param_00)
	{
		if(isalive(var_05) && !var_05.ignoreforfixednodesafecheck)
		{
			var_03[var_03.size] = var_05;
		}
	}

	param_00 = var_03;
	var_07 = spawnstruct();
	if(isdefined(param_02))
	{
		var_07 endon("thread_timed_out");
		var_07 thread func_8B4B(param_02);
	}

	var_07.count = param_00.size;
	if(isdefined(param_01) && param_01 < var_07.count)
	{
		var_07.count = param_01;
	}

	common_scripts\utility::func_F1B(param_00,::func_8B48,var_07);
	while(var_07.count > 0)
	{
		var_07 waittill("waittill_dead_guy_dead_or_dying");
	}
}

//Function Number: 126
func_8B4A(param_00)
{
	self waittill("death");
	param_00.count--;
	param_00 notify("waittill_dead guy died");
}

//Function Number: 127
func_8B48(param_00)
{
	common_scripts\utility::func_8B4F("death","pain_death");
	param_00.count--;
	param_00 notify("waittill_dead_guy_dead_or_dying");
}

//Function Number: 128
func_8B4B(param_00)
{
	wait(param_00);
	self notify("thread_timed_out");
}

//Function Number: 129
func_8B23(param_00)
{
	while(level._ai_group[param_00].var_7878 || level._ai_group[param_00].aicount)
	{
		wait(0.25);
	}
}

//Function Number: 130
func_8B24(param_00,param_01)
{
	while(level._ai_group[param_00].var_7878 + level._ai_group[param_00].aicount > param_01)
	{
		wait(0.25);
	}
}

//Function Number: 131
get_ai_group_count(param_00)
{
	return level._ai_group[param_00].var_7878 + level._ai_group[param_00].aicount;
}

//Function Number: 132
func_37B3(param_00)
{
	return level._ai_group[param_00].aicount;
}

//Function Number: 133
func_37B1(param_00)
{
	var_01 = [];
	for(var_02 = 0;var_02 < level._ai_group[param_00].var_9D6.size;var_02++)
	{
		if(!isalive(level._ai_group[param_00].var_9D6[var_02]))
		{
			continue;
		}

		var_01[var_01.size] = level._ai_group[param_00].var_9D6[var_02];
	}

	return var_01;
}

//Function Number: 134
func_8B78(param_00)
{
	self endon("damage");
	self endon("death");
	self waittillmatch(param_00,"single anim");
}

//Function Number: 135
get_living_ai(param_00,param_01)
{
	var_02 = get_living_ai_array(param_00,param_01);
	if(var_02.size > 1)
	{
		return undefined;
	}

	return var_02[0];
}

//Function Number: 136
get_living_ai_array(param_00,param_01)
{
	var_02 = getaispeciesarray("all","all");
	var_03 = [];
	foreach(var_05 in var_02)
	{
		if(!isalive(var_05))
		{
			continue;
		}

		switch(param_01)
		{
			case "targetname":
				if(isdefined(var_05.targetname) && var_05.targetname == param_00)
				{
					var_03[var_03.size] = var_05;
				}
				break;

			case "script_noteworthy":
				if(isdefined(var_05.script_noteworthy) && var_05.script_noteworthy == param_00)
				{
					var_03[var_03.size] = var_05;
				}
				break;
		}
	}

	return var_03;
}

//Function Number: 137
func_39E7(param_00,param_01)
{
	var_02 = get_vehicle_array(param_00,param_01);
	if(!var_02.size)
	{
		return undefined;
	}

	return var_02[0];
}

//Function Number: 138
get_vehicle_array(param_00,param_01)
{
	var_02 = getentarray(param_00,param_01);
	var_03 = [];
	var_04 = [];
	foreach(var_06 in var_02)
	{
		if(var_06.code_classname != "script_vehicle")
		{
			continue;
		}

		var_04[0] = var_06;
		if(isspawner(var_06))
		{
			if(isdefined(var_06.last_spawned_vehicle))
			{
				var_04[0] = var_06.last_spawned_vehicle;
				var_03 = func_0EF4(var_03,var_04);
			}

			continue;
		}

		var_03 = func_0EF4(var_03,var_04);
	}

	return var_03;
}

//Function Number: 139
func_38E3(param_00,param_01,param_02)
{
	var_03 = func_38E4(param_00,param_01,param_02);
	if(var_03.size > 1)
	{
		return undefined;
	}

	return var_03[0];
}

//Function Number: 140
func_38E4(param_00,param_01,param_02)
{
	if(!isdefined(param_02))
	{
		param_02 = "all";
	}

	var_03 = getaispeciesarray("allies",param_02);
	var_03 = common_scripts\utility::array_combine(var_03,getaispeciesarray("axis",param_02));
	var_04 = [];
	for(var_05 = 0;var_05 < var_03.size;var_05++)
	{
		switch(param_01)
		{
			case "targetname":
				if(isdefined(var_03[var_05].targetname) && var_03[var_05].targetname == param_00)
				{
					var_04[var_04.size] = var_03[var_05];
				}
				break;

			case "script_noteworthy":
				if(isdefined(var_03[var_05].script_noteworthy) && var_03[var_05].script_noteworthy == param_00)
				{
					var_04[var_04.size] = var_03[var_05];
				}
				break;
		}
	}

	return var_04;
}

//Function Number: 141
gather_delay_proc(param_00,param_01)
{
	if(isdefined(level.var_376B[param_00]))
	{
		if(level.var_376B[param_00])
		{
			wait(0.05);
			if(isalive(self))
			{
				self notify("gather_delay_finished" + param_00 + param_01);
			}
		}

		level waittill(param_00);
		if(isalive(self))
		{
			self notify("gather_delay_finished" + param_00 + param_01);
		}
	}

	level.var_376B[param_00] = 0;
	wait(param_01);
	level.var_376B[param_00] = 1;
	level notify(param_00);
	if(isalive(self))
	{
		self notify("gat    her_delay_finished" + param_00 + param_01);
	}
}

//Function Number: 142
func_376B(param_00,param_01)
{
	thread gather_delay_proc(param_00,param_01);
	self waittill("gather_delay_finished" + param_00 + param_01);
}

//Function Number: 143
death_waiter(param_00)
{
	self waittill("death");
	level notify(param_00);
}

//Function Number: 144
func_3A51(param_00)
{
	if(param_00 == 0)
	{
		return "0";
	}

	if(param_00 == 1)
	{
		return "1";
	}

	if(param_00 == 2)
	{
		return "2";
	}

	if(param_00 == 3)
	{
		return "3";
	}

	if(param_00 == 4)
	{
		return "4";
	}

	if(param_00 == 5)
	{
		return "5";
	}

	if(param_00 == 6)
	{
		return "6";
	}

	if(param_00 == 7)
	{
		return "7";
	}

	if(param_00 == 8)
	{
		return "8";
	}

	if(param_00 == 9)
	{
		return "9";
	}
}

//Function Number: 145
func_3B15(param_00,param_01)
{
	var_02 = [];
	for(var_03 = 0;var_03 < param_00.size;var_03++)
	{
		var_04 = param_00[var_03];
		var_05 = var_04.script_linkname;
		if(!isdefined(var_05))
		{
			continue;
		}

		if(!isdefined(param_01[var_05]))
		{
			continue;
		}

		var_02[var_02.size] = var_04;
	}

	return var_02;
}

//Function Number: 146
array_merge_links(param_00,param_01)
{
	if(!param_00.size)
	{
		return param_01;
	}

	if(!param_01.size)
	{
		return param_00;
	}

	var_02 = [];
	for(var_03 = 0;var_03 < param_00.size;var_03++)
	{
		var_04 = param_00[var_03];
		var_02[var_04.script_linkname] = 1;
	}

	for(var_03 = 0;var_03 < param_01.size;var_03++)
	{
		var_04 = param_01[var_03];
		if(isdefined(var_02[var_04.script_linkname]))
		{
			continue;
		}

		var_02[var_04.script_linkname] = 1;
		param_00[param_00.size] = var_04;
	}

	return param_00;
}

//Function Number: 147
func_0EF4(param_00,param_01)
{
	if(param_00.size == 0)
	{
		return param_01;
	}

	if(param_01.size == 0)
	{
		return param_00;
	}

	var_02 = param_00;
	foreach(var_04 in param_01)
	{
		var_05 = 0;
		foreach(var_07 in param_00)
		{
			if(var_07 == var_04)
			{
				var_05 = 1;
				break;
			}
		}

		if(var_05)
		{
			continue;
		}
		else
		{
			var_02[var_02.size] = var_04;
		}
	}

	return var_02;
}

//Function Number: 148
array_exclude(param_00,param_01)
{
	var_02 = param_00;
	for(var_03 = 0;var_03 < param_01.size;var_03++)
	{
		if(func_4803(param_00,param_01[var_03]))
		{
			var_02 = common_scripts\utility::array_remove(var_02,param_01[var_03]);
		}
	}

	return var_02;
}

//Function Number: 149
array_compare(param_00,param_01)
{
	if(param_00.size != param_01.size)
	{
		return 0;
	}

	foreach(var_05, var_03 in param_00)
	{
		if(!isdefined(param_01[var_05]))
		{
			return 0;
		}

		var_04 = param_01[var_05];
		if(var_04 != var_03)
		{
			return 0;
		}
	}

	return 1;
}

//Function Number: 150
getlinkedvehiclenodes()
{
	var_00 = [];
	if(isdefined(self.script_linkto))
	{
		var_01 = common_scripts\utility::get_links();
		foreach(var_03 in var_01)
		{
			var_04 = getvehiclenodearray(var_03,"script_linkname");
			var_00 = common_scripts\utility::array_combine(var_00,var_04);
		}
	}

	return var_00;
}

//Function Number: 151
func_2A5B(param_00,param_01,param_02,param_03,param_04)
{
	wait(0.05);
}

//Function Number: 152
draw_line_to_ent_for_time(param_00,param_01,param_02,param_03,param_04,param_05)
{
	param_05 = gettime() + param_05 * 1000;
	while(gettime() < param_05)
	{
		wait(0.05);
		if(!isdefined(param_01) || !isdefined(param_01.origin))
		{
		}
	}
}

//Function Number: 153
draw_line_from_ent_for_time(param_00,param_01,param_02,param_03,param_04,param_05)
{
	draw_line_to_ent_for_time(param_01,param_00,param_02,param_03,param_04,param_05);
}

//Function Number: 154
draw_line_from_ent_to_ent_for_time(param_00,param_01,param_02,param_03,param_04,param_05)
{
	param_00 endon("death");
	param_01 endon("death");
	param_05 = gettime() + param_05 * 1000;
	while(gettime() < param_05)
	{
		wait(0.05);
	}
}

//Function Number: 155
draw_line_from_ent_to_ent_until_notify(param_00,param_01,param_02,param_03,param_04,param_05,param_06)
{
	param_00 endon("death");
	param_01 endon("death");
	param_05 endon(param_06);
	wait(0.05);
}

//Function Number: 156
draw_line_until_notify(param_00,param_01,param_02,param_03,param_04,param_05,param_06)
{
	param_05 endon(param_06);
	common_scripts\utility::func_2A5C(param_00,param_01,param_02,param_03,param_04,0.05);
}

//Function Number: 157
func_2A60(param_00,param_01,param_02,param_03,param_04,param_05,param_06)
{
	param_06 = gettime() + param_06 * 1000;
	param_01 = param_01 * param_02;
	while(gettime() < param_06)
	{
		wait(0.05);
		if(!isdefined(param_00) || !isdefined(param_00.origin))
		{
		}
	}
}

//Function Number: 158
func_2A4E(param_00,param_01,param_02,param_03,param_04,param_05,param_06)
{
	var_07 = 16;
	var_08 = 360 / var_07;
	var_09 = [];
	for(var_0A = 0;var_0A < var_07;var_0A++)
	{
		var_0B = var_08 * var_0A;
		var_0C = cos(var_0B) * param_01;
		var_0D = sin(var_0B) * param_01;
		var_0E = param_00[0] + var_0C;
		var_0F = param_00[1] + var_0D;
		var_10 = param_00[2];
		var_09[var_09.size] = (var_0E,var_0F,var_10);
	}

	thread func_2A4D(var_09,param_02,param_03,param_04,param_05,param_06);
}

//Function Number: 159
func_2A4D(param_00,param_01,param_02,param_03,param_04,param_05)
{
	for(var_06 = 0;var_06 < param_00.size;var_06++)
	{
		var_07 = param_00[var_06];
		if(var_06 + 1 >= param_00.size)
		{
			var_08 = param_00[0];
		}
		else
		{
			var_08 = param_00[var_06 + 1];
		}

		thread draw_line_until_notify(var_07,var_08,param_01,param_02,param_03,param_04,param_05);
	}
}

//Function Number: 160
func_1D0B()
{
	self notify("enemy");
	self clearenemy();
}

//Function Number: 161
battlechatter_off(param_00)
{
	level notify("battlechatter_off_thread");
	animscripts/battlechatter::bcs_setup_chatter_toggle_array();
	if(isdefined(param_00))
	{
		func_6E55(param_00,0);
		var_01 = getaiarray(param_00);
	}
	else
	{
		foreach(param_00 in level.teams)
		{
			func_6E55(param_00,0);
		}

		var_01 = getaiarray();
	}

	if(!isdefined(level.var_1B40) || !level.var_1B40)
	{
	}

	for(var_04 = 0;var_04 < var_01.size;var_04++)
	{
		var_01[var_04].battlechatter = 0;
	}

	for(var_04 = 0;var_04 < var_01.size;var_04++)
	{
		var_05 = var_01[var_04];
		if(!isalive(var_05))
		{
			continue;
		}

		if(!var_05.var_1B40)
		{
			continue;
		}

		if(!var_05.var_4968)
		{
			continue;
		}

		var_05 maps\_utility_code::func_8AC4();
	}

	var_06 = gettime() - level.var_4CC7["allies"];
	if(var_06 < 1500)
	{
		wait(var_06 / 1000);
	}

	if(isdefined(param_00))
	{
		level notify(param_00 + " done speaking");
	}

	level notify("done speaking");
}

//Function Number: 162
battlechatter_on(param_00)
{
	thread battlechatter_on_thread(param_00);
}

//Function Number: 163
battlechatter_on_thread(param_00)
{
	level endon("battlechatter_off_thread");
	animscripts/battlechatter::bcs_setup_chatter_toggle_array();
	while(!isdefined(level.var_1B40))
	{
		wait(0.05);
	}

	common_scripts\utility::flag_set("battlechatter_on_thread_waiting");
	wait(1.5);
	common_scripts\utility::func_337C("battlechatter_on_thread_waiting");
	if(isdefined(param_00))
	{
		func_6E55(param_00,1);
		var_01 = getaiarray(param_00);
	}
	else
	{
		foreach(param_00 in level.teams)
		{
			func_6E55(param_00,1);
		}

		var_01 = getaiarray();
	}

	for(var_04 = 0;var_04 < var_01.size;var_04++)
	{
		var_01[var_04] func_6E54(1);
	}
}

//Function Number: 164
func_6E54(param_00)
{
	if(!level.var_1B40)
	{
	}

	if(self.type == "dog")
	{
	}

	if(param_00)
	{
		if(isdefined(self.var_6B51) && !self.var_6B51)
		{
			self.battlechatter = 0;
		}

		self.battlechatter = 1;
	}

	self.battlechatter = 0;
	if(isdefined(self.var_4968) && self.var_4968)
	{
		self waittill("done speaking");
	}
}

//Function Number: 165
set_team_bcvoice(param_00,param_01)
{
	if(!level.var_1B40)
	{
	}

	var_02 = getarraykeys(level.countryids);
	var_03 = common_scripts\utility::array_contains(var_02,param_01);
	if(!var_03)
	{
	}

	var_04 = getaiarray(param_00);
	foreach(var_06 in var_04)
	{
		var_06 set_ai_bcvoice(param_01);
		common_scripts\utility::func_8AFE();
	}
}

//Function Number: 166
set_ai_bcvoice(param_00)
{
	if(!level.var_1B40)
	{
	}

	var_01 = getarraykeys(level.countryids);
	var_02 = common_scripts\utility::array_contains(var_01,param_00);
	if(!var_02)
	{
	}

	if(self.type == "dog")
	{
	}

	if(isdefined(self.var_4968) && self.var_4968)
	{
		self waittill("done speaking");
		wait(0.1);
	}

	animscripts/battlechatter_ai::func_6594();
	waittillframeend;
	self.voice = param_00;
	animscripts/battlechatter_ai::func_99A();
}

//Function Number: 167
func_341C(param_00)
{
	thread set_flavorbursts_team_state(1,param_00);
}

//Function Number: 168
func_341B(param_00)
{
	thread set_flavorbursts_team_state(0,param_00);
}

//Function Number: 169
set_flavorbursts_team_state(param_00,param_01)
{
	if(!isdefined(param_01))
	{
		param_01 = "allies";
	}

	if(!level.var_1B40)
	{
	}

	wait(1.5);
	level.var_341A[param_01] = param_00;
	var_02 = [];
	var_02 = getaiarray(param_01);
	common_scripts\utility::func_F1B(var_02,::func_6ED9,param_00);
}

//Function Number: 170
func_6ED9(param_00)
{
	self.var_341A = param_00;
}

//Function Number: 171
friendlyfire_warnings_off()
{
	var_00 = getaiarray("allies");
	foreach(var_02 in var_00)
	{
		if(isalive(var_02))
		{
			var_02 func_6EE8(0);
		}
	}

	level.var_357A = 0;
}

//Function Number: 172
func_357D()
{
	var_00 = getaiarray("allies");
	foreach(var_02 in var_00)
	{
		if(isalive(var_02))
		{
			var_02 func_6EE8(1);
		}
	}

	level.var_357A = 1;
}

//Function Number: 173
func_6EE8(param_00)
{
	if(param_00)
	{
		self.friendlyfire_warnings_disable = undefined;
	}

	self.friendlyfire_warnings_disable = 1;
}

//Function Number: 174
get_obj_origin(param_00)
{
	var_01 = getentarray("objective","targetname");
	for(var_02 = 0;var_02 < var_01.size;var_02++)
	{
		if(var_01[var_02].script_noteworthy == param_00)
		{
			return var_01[var_02].origin;
		}
	}
}

//Function Number: 175
get_obj_event(param_00)
{
	var_01 = getentarray("objective_event","targetname");
	for(var_02 = 0;var_02 < var_01.size;var_02++)
	{
		if(var_01[var_02].script_noteworthy == param_00)
		{
			return var_01[var_02];
		}
	}
}

//Function Number: 176
func_8B80()
{
	maps\_utility_code::func_8B82(1);
}

//Function Number: 177
func_8B81()
{
	maps\_utility_code::func_8B82(0);
}

//Function Number: 178
func_2425()
{
	self notify("Debug origin");
	self endon("Debug origin");
	self endon("death");
	for(;;)
	{
		var_00 = anglestoforward(self.angles);
		var_01 = var_00 * 30;
		var_02 = var_00 * 20;
		var_03 = anglestoright(self.angles);
		var_04 = var_03 * -10;
		var_03 = var_03 * 10;
		wait(0.05);
	}
}

//Function Number: 179
get_linked_structs()
{
	var_00 = [];
	if(isdefined(self.script_linkto))
	{
		var_01 = common_scripts\utility::get_links();
		for(var_02 = 0;var_02 < var_01.size;var_02++)
		{
			var_03 = common_scripts\utility::func_3C18(var_01[var_02],"script_linkname");
			if(isdefined(var_03))
			{
				var_00[var_00.size] = var_03;
			}
		}
	}

	return var_00;
}

//Function Number: 180
func_38CC(param_00)
{
	var_01 = self;
	while(isdefined(var_01.target))
	{
		wait(0.05);
		if(isdefined(var_01.target))
		{
			switch(param_00)
			{
				case "vehiclenode":
					var_01 = getvehiclenode(var_01.target,"targetname");
					break;

				case "pathnode":
					var_01 = getnode(var_01.target,"targetname");
					break;

				case "ent":
					var_01 = getent(var_01.target,"targetname");
					break;

				case "struct":
					var_01 = common_scripts\utility::func_3C18(var_01.target,"targetname");
					break;

				default:
					break;
			}

			continue;
		}

		break;
	}

	var_02 = var_01;
	return var_02;
}

//Function Number: 181
func_5EFA(param_00)
{
	var_01 = spawn("script_origin",level.player.origin);
	var_01 linkto(level.player);
	if(isdefined(param_00))
	{
		thread timeout(param_00);
	}

	self setgoalentity(var_01);
	if(!isdefined(self.oldgoalradius))
	{
		self.oldgoalradius = self.goalradius;
	}

	self.goalradius = 300;
	common_scripts\utility::func_8B2A("goal","timeout");
	if(isdefined(self.oldgoalradius))
	{
		self.goalradius = self.oldgoalradius;
		self.oldgoalradius = undefined;
	}

	var_01 delete();
}

//Function Number: 182
timeout(param_00)
{
	self endon("death");
	wait(param_00);
	self notify("timeout");
}

//Function Number: 183
func_6EE3()
{
	if(isdefined(self.var_6EE2))
	{
	}

	self.oldfightdist = self.pathenemyfightdist;
	self.oldmaxdist = self.pathenemylookahead;
	self.var_58C6 = self.maxsightdistsqrd;
	self.pathenemyfightdist = 8;
	self.pathenemylookahead = 8;
	self.maxsightdistsqrd = 1;
	self.var_6EE2 = 1;
}

//Function Number: 184
unset_forcegoal()
{
	if(!isdefined(self.var_6EE2))
	{
	}

	self.pathenemyfightdist = self.oldfightdist;
	self.pathenemylookahead = self.oldmaxdist;
	self.maxsightdistsqrd = self.var_58C6;
	self.var_6EE2 = undefined;
}

//Function Number: 185
array_removedead_keepkeys(param_00)
{
	var_01 = [];
	var_02 = getarraykeys(param_00);
	for(var_03 = 0;var_03 < var_02.size;var_03++)
	{
		var_04 = var_02[var_03];
		if(!isalive(param_00[var_04]))
		{
			continue;
		}

		var_01[var_04] = param_00[var_04];
	}

	return var_01;
}

//Function Number: 186
array_removedead(param_00)
{
	var_01 = [];
	foreach(var_03 in param_00)
	{
		if(!isalive(var_03))
		{
			continue;
		}

		var_01[var_01.size] = var_03;
	}

	return var_01;
}

//Function Number: 187
func_0F06(param_00)
{
	var_01 = [];
	foreach(var_03 in param_00)
	{
		if(!isalive(var_03))
		{
			continue;
		}

		if(var_03 doinglongdeath())
		{
			continue;
		}

		var_01[var_01.size] = var_03;
	}

	return var_01;
}

//Function Number: 188
array_remove_nokeys(param_00,param_01)
{
	var_02 = [];
	for(var_03 = 0;var_03 < param_00.size;var_03++)
	{
		if(param_00[var_03] != param_01)
		{
			var_02[var_02.size] = param_00[var_03];
		}
	}

	return var_02;
}

//Function Number: 189
func_0EFF(param_00,param_01)
{
	for(var_02 = 0;var_02 < param_00.size - 1;var_02++)
	{
		if(var_02 == param_01)
		{
			param_00[var_02] = param_00[var_02 + 1];
			param_01++;
		}
	}

	param_00[param_00.size - 1] = undefined;
	return param_00;
}

//Function Number: 190
array_notify(param_00,param_01,param_02)
{
	foreach(var_04 in param_00)
	{
		var_04 notify(param_01,param_02);
	}
}

//Function Number: 191
struct_arrayspawn()
{
	var_00 = spawnstruct();
	var_00.var_ED8 = [];
	var_00.var_4C6E = 0;
	return var_00;
}

//Function Number: 192
func_7CFB(param_00,param_01)
{
	param_00.var_ED8[param_00.var_4C6E] = param_01;
	param_01.var_7CF5 = param_00.var_4C6E;
	param_00.var_4C6E++;
}

//Function Number: 193
structarray_remove(param_00,param_01)
{
	structarray_swaptolast(param_00,param_01);
	param_00.var_ED8[param_00.var_4C6E - 1] = undefined;
	param_00.var_4C6E--;
}

//Function Number: 194
func_7CFD(param_00,param_01)
{
	if(isdefined(param_00.var_ED8[param_00.var_4C6E - 1]))
	{
		param_00.var_ED8[param_01] = param_00.var_ED8[param_00.var_4C6E - 1];
		param_00.var_ED8[param_01].var_7CF5 = param_01;
		param_00.var_ED8[param_00.var_4C6E - 1] = undefined;
		param_00.var_4C6E = param_00.var_ED8.size;
	}

	param_00.var_ED8[param_01] = undefined;
	structarray_remove_undefined(param_00);
}

//Function Number: 195
structarray_remove_undefined(param_00)
{
	var_01 = [];
	foreach(var_03 in param_00.var_ED8)
	{
		if(!isdefined(var_03))
		{
			continue;
		}

		var_01[var_01.size] = var_03;
	}

	param_00.var_ED8 = var_01;
	foreach(var_06, var_03 in param_00.var_ED8)
	{
		var_03.var_7CF5 = var_06;
	}

	param_00.var_4C6E = param_00.var_ED8.size;
}

//Function Number: 196
structarray_swaptolast(param_00,param_01)
{
	param_00 maps\_utility_code::func_7D00(param_00.var_ED8[param_00.var_4C6E - 1],param_01);
}

//Function Number: 197
func_7CFF(param_00,param_01)
{
	for(var_02 = 0;var_02 < param_01;var_02++)
	{
		param_00 maps\_utility_code::func_7D00(param_00.var_ED8[var_02],param_00.var_ED8[randomint(param_00.var_4C6E)]);
	}
}

//Function Number: 198
func_39E1()
{
	if(level.console)
	{
		return " + usereload";
	}

	return " + activate";
}

//Function Number: 199
func_2218(param_00)
{
	return animscripts/battlechatter_ai::func_221A(param_00);
}

//Function Number: 200
func_39AE(param_00,param_01)
{
	var_02 = newhudelem();
	if(level.console)
	{
		var_02.x = 68;
		var_02.y = 35;
	}
	else
	{
		var_02.x = 58;
		var_02.y = 95;
	}

	var_02.alignx = "center";
	var_02.aligny = "middle";
	var_02.horzalign = "left";
	var_02.vertalign = "middle";
	if(isdefined(param_01))
	{
		var_03 = param_01;
	}
	else
	{
		var_03 = level.explosiveplanttime;
	}

	var_02 setclock(var_03,param_00,"hudStopwatch",64,64);
	return var_02;
}

//Function Number: 201
func_57CE(param_00)
{
	var_01 = 0;
	for(var_02 = 0;var_02 < level.active_objective.size;var_02++)
	{
		if(level.active_objective[var_02] != param_00)
		{
			continue;
		}

		var_01 = 1;
		break;
	}

	return var_01;
}

//Function Number: 202
objective_is_inactive(param_00)
{
	var_01 = 0;
	for(var_02 = 0;var_02 < level.var_4457.size;var_02++)
	{
		if(level.var_4457[var_02] != param_00)
		{
			continue;
		}

		var_01 = 1;
		break;
	}

	return var_01;
}

//Function Number: 203
func_6F36(param_00)
{
	var_01 = [];
	for(var_02 = 0;var_02 < level.active_objective.size;var_02++)
	{
		if(level.active_objective[var_02] == param_00)
		{
			continue;
		}

		var_01[var_01.size] = level.active_objective[var_02];
	}

	level.active_objective = var_01;
	var_03 = 0;
	for(var_02 = 0;var_02 < level.var_4457.size;var_02++)
	{
		if(level.var_4457[var_02] != param_00)
		{
			continue;
		}

		var_03 = 1;
	}

	if(!var_03)
	{
		level.var_4457[level.var_4457.size] = param_00;
	}
}

//Function Number: 204
func_6F35(param_00)
{
	var_01 = [];
	for(var_02 = 0;var_02 < level.var_4457.size;var_02++)
	{
		if(level.var_4457[var_02] == param_00)
		{
			continue;
		}

		var_01[var_01.size] = level.var_4457[var_02];
	}

	level.var_4457 = var_01;
	var_03 = 0;
	for(var_02 = 0;var_02 < level.active_objective.size;var_02++)
	{
		if(level.active_objective[var_02] != param_00)
		{
			continue;
		}

		var_03 = 1;
	}

	if(!var_03)
	{
		level.active_objective[level.active_objective.size] = param_00;
	}
}

//Function Number: 205
func_52F2()
{
	if(level.var_52F1)
	{
	}

	if(isdefined(level.var_55F6))
	{
	}

	level.var_52F1 = 1;
	common_scripts\utility::flag_set("missionfailed");
	if(func_0EBE())
	{
	}

	if(getdvar("failure_disabled") == "1")
	{
	}

	if(isdefined(level.mission_fail_func))
	{
		thread [[ level.mission_fail_func ]]();
	}

	maps\_utility_code::mission_recon(0);
	missionfailed();
}

//Function Number: 206
set_mission_failed_override(param_00)
{
	level.mission_fail_func = param_00;
}

//Function Number: 207
script_delay()
{
	if(isdefined(self.script_delay))
	{
		wait(self.script_delay);
		return 1;
	}
	else if(isdefined(self.script_delay_min) && isdefined(self.script_delay_max))
	{
		wait(randomfloatrange(self.script_delay_min,self.script_delay_max));
		return 1;
	}

	return 0;
}

//Function Number: 208
func_6D02()
{
	var_00 = gettime();
	if(isdefined(self.var_6D02))
	{
		wait(self.var_6D02);
		if(isdefined(self.var_6D03))
		{
			self.var_6D02 = self.var_6D02 + self.var_6D03;
		}
	}
	else if(isdefined(self.var_6D05) && isdefined(self.var_6D04))
	{
		wait(randomfloatrange(self.var_6D05,self.var_6D04));
		if(isdefined(self.var_6D03))
		{
			self.var_6D05 = self.var_6D05 + self.var_6D03;
			self.var_6D04 = self.var_6D04 + self.var_6D03;
		}
	}

	return gettime() - var_00;
}

//Function Number: 209
func_3E39(param_00)
{
	maps\_vehicle_aianim::guy_enter(param_00);
}

//Function Number: 210
guy_runtovehicle_load(param_00,param_01)
{
	maps\_vehicle_aianim::func_3E4C(param_00,param_01);
}

//Function Number: 211
get_force_color_guys(param_00,param_01)
{
	var_02 = getaiarray(param_00);
	var_03 = [];
	for(var_04 = 0;var_04 < var_02.size;var_04++)
	{
		var_05 = var_02[var_04];
		if(!isdefined(var_05.var_6BCF))
		{
			continue;
		}

		if(var_05.var_6BCF != param_01)
		{
			continue;
		}

		var_03[var_03.size] = var_05;
	}

	return var_03;
}

//Function Number: 212
func_37BE()
{
	var_00 = getaiarray("allies");
	var_01 = [];
	for(var_02 = 0;var_02 < var_00.size;var_02++)
	{
		var_03 = var_00[var_02];
		if(!isdefined(var_03.var_6BCF))
		{
			continue;
		}

		var_01[var_01.size] = var_03;
	}

	return var_01;
}

//Function Number: 213
func_37C1(param_00)
{
	if(!isdefined(param_00))
	{
		param_00 = self.target;
	}

	var_01 = [];
	var_02 = getentarray(param_00,"targetname");
	var_01 = common_scripts\utility::array_combine(var_01,var_02);
	var_02 = getnodearray(param_00,"targetname");
	var_01 = common_scripts\utility::array_combine(var_01,var_02);
	var_02 = common_scripts\utility::func_3C1A(param_00,"targetname");
	var_01 = common_scripts\utility::array_combine(var_01,var_02);
	var_02 = getvehiclenodearray(param_00,"targetname");
	var_01 = common_scripts\utility::array_combine(var_01,var_02);
	return var_01;
}

//Function Number: 214
func_2C96()
{
	if(isdefined(self.var_6BCF))
	{
	}

	if(!isdefined(self.var_5898))
	{
	}

	func_6EDF(self.var_5898);
	self.var_5898 = undefined;
}

//Function Number: 215
func_2C97()
{
	self.dontcolormove = 1;
	func_2C96();
}

//Function Number: 216
func_2743()
{
	if(isdefined(self.var_55B5))
	{
		self endon("death");
		self waittill("done_setting_new_color");
	}

	self clearfixednodesafevolume();
	if(!isdefined(self.var_6BCF))
	{
	}

	self.var_5898 = self.var_6BCF;
	level.arrays_of_colorforced_ai[maps\_colors::func_39C5()][self.var_6BCF] = common_scripts\utility::array_remove(level.arrays_of_colorforced_ai[maps\_colors::func_39C5()][self.var_6BCF],self);
	maps\_colors::func_4D55();
	self.var_6BCF = undefined;
	self.currentcolorcode = undefined;
}

//Function Number: 217
func_1D0F()
{
	func_2743();
}

//Function Number: 218
check_force_color(param_00)
{
	var_01 = level.var_1E13[tolower(param_00)];
	if(isdefined(self.var_6BCF) && var_01 == self.var_6BCF)
	{
		return 1;
	}

	return 0;
}

//Function Number: 219
get_force_color()
{
	var_00 = self.var_6BCF;
	return var_00;
}

//Function Number: 220
func_7454(param_00)
{
	return level.var_1E13[tolower(param_00)];
}

//Function Number: 221
func_6EDF(param_00)
{
	var_01 = func_7454(param_00);
	if(!isai(self))
	{
		func_6EE0(var_01);
	}

	if(self.team == "allies")
	{
		self.fixednode = 1;
		self.fixednodesaferadius = 64;
		self.pathenemyfightdist = 0;
		self.pathenemylookahead = 0;
	}

	self.script_color_axis = undefined;
	self.var_6B66 = undefined;
	self.var_5898 = undefined;
	var_02 = maps\_colors::func_39C5();
	if(isdefined(self.var_6BCF))
	{
		level.arrays_of_colorforced_ai[var_02][self.var_6BCF] = common_scripts\utility::array_remove(level.arrays_of_colorforced_ai[var_02][self.var_6BCF],self);
	}

	self.var_6BCF = var_01;
	level.arrays_of_colorforced_ai[var_02][var_01] = array_removedead(level.arrays_of_colorforced_ai[var_02][var_01]);
	level.arrays_of_colorforced_ai[var_02][self.var_6BCF] = common_scripts\utility::array_add(level.arrays_of_colorforced_ai[var_02][self.var_6BCF],self);
	thread maps\_utility_code::func_55B1(var_01);
}

//Function Number: 222
func_6EE0(param_00)
{
	self.var_6BCF = param_00;
	self.var_5898 = undefined;
}

//Function Number: 223
issue_color_orders(param_00,param_01)
{
	var_02 = strtok(param_00," ");
	var_03 = [];
	var_04 = [];
	for(var_05 = 0;var_05 < var_02.size;var_05++)
	{
		var_06 = undefined;
		if(issubstr(var_02[var_05],"r"))
		{
			var_06 = "r";
		}
		else if(issubstr(var_02[var_05],"b"))
		{
			var_06 = "b";
		}
		else if(issubstr(var_02[var_05],"y"))
		{
			var_06 = "y";
		}
		else if(issubstr(var_02[var_05],"c"))
		{
			var_06 = "c";
		}
		else if(issubstr(var_02[var_05],"g"))
		{
			var_06 = "g";
		}
		else if(issubstr(var_02[var_05],"p"))
		{
			var_06 = "p";
		}
		else if(issubstr(var_02[var_05],"o"))
		{
			var_06 = "o";
		}
		else
		{
		}

		var_04[var_06] = var_02[var_05];
		var_03[var_03.size] = var_06;
	}

	for(var_05 = 0;var_05 < var_02.size;var_05++)
	{
		level.arrays_of_colorcoded_spawners[param_01][var_02[var_05]] = common_scripts\utility::array_removeundefined(level.arrays_of_colorcoded_spawners[param_01][var_02[var_05]]);
		for(var_07 = 0;var_07 < level.arrays_of_colorcoded_spawners[param_01][var_02[var_05]].size;var_07++)
		{
			level.arrays_of_colorcoded_spawners[param_01][var_02[var_05]][var_07].currentcolorcode = var_02[var_05];
		}
	}

	for(var_05 = 0;var_05 < var_03.size;var_05++)
	{
		level.arrays_of_colorforced_ai[param_01][var_03[var_05]] = array_removedead(level.arrays_of_colorforced_ai[param_01][var_03[var_05]]);
		level.currentcolorforced[param_01][var_03[var_05]] = var_04[var_03[var_05]];
	}

	for(var_05 = 0;var_05 < var_02.size;var_05++)
	{
		thread maps\_colors::func_4974(var_02[var_05],var_03[var_05],param_01);
	}
}

//Function Number: 224
flashrumbleloop(param_00)
{
	var_01 = gettime() + param_00 * 1000;
	while(gettime() < var_01)
	{
		self playrumbleonentity("damage_heavy");
		wait(0.05);
	}
}

//Function Number: 225
flashmonitorenablehealthshield(param_00)
{
	self endon("death");
	self endon("flashed");
	wait(0.2);
	self enablehealthshield(0);
	wait(param_00 + 2);
	self enablehealthshield(1);
}

//Function Number: 226
func_560E(param_00,param_01,param_02,param_03,param_04)
{
	var_05 = [0.8,0.7,0.7,0.6];
	var_06 = [1,0.8,0.6,0.6];
	foreach(var_0C, var_08 in var_06)
	{
		var_09 = param_01 - 0.85 / 0.15;
		if(var_09 > param_02)
		{
			param_02 = var_09;
		}

		if(param_02 < 0.25)
		{
			param_02 = 0.25;
		}

		var_0A = 0.3;
		if(param_01 > 1 - var_0A)
		{
			param_01 = 1;
		}
		else
		{
			param_01 = param_01 / 1 - var_0A;
		}

		if(param_04 != self.team)
		{
			var_0B = param_01 * param_02 * 6;
		}
		else
		{
			var_0B = param_01 * param_02 * 3;
		}

		if(var_0B < 0.25)
		{
			continue;
		}

		var_0B = var_08 * var_0B;
		if(isdefined(self.maxflashedseconds) && var_0B > self.maxflashedseconds)
		{
			var_0B = self.maxflashedseconds;
		}

		self.var_3405 = param_04;
		self notify("flashed");
		self.flashendtime = gettime() + var_0B * 1000;
		self shellshock("flashbang",var_0B);
		common_scripts\utility::flag_set("player_flashed");
		if(param_01 * param_02 > 0.5)
		{
			thread flashmonitorenablehealthshield(var_0B);
		}

		wait(var_05[var_0C]);
	}

	thread maps\_utility_code::func_859F(0.05);
}

//Function Number: 227
flashmonitor()
{
	self endon("death");
	for(;;)
	{
		self waittill("flashbang",var_00,var_01,var_02,var_03,var_04);
		if("1" == getdvar("noflash"))
		{
			continue;
		}

		if(func_4825(self))
		{
			continue;
		}

		if(isdefined(self.var_80A2))
		{
			var_05 = 0.8;
			var_06 = 1 - var_05;
			self.var_80A2 = undefined;
			if(var_01 < var_06)
			{
				continue;
			}

			var_01 = var_01 - var_06 / var_05;
		}

		var_07 = var_01 - 0.85 / 0.15;
		if(var_07 > var_02)
		{
			var_02 = var_07;
		}

		if(var_02 < 0.25)
		{
			var_02 = 0.25;
		}

		var_08 = 0.3;
		if(var_01 > 1 - var_08)
		{
			var_01 = 1;
		}
		else
		{
			var_01 = var_01 / 1 - var_08;
		}

		if(var_04 != self.team)
		{
			var_09 = var_01 * var_02 * 6;
		}
		else
		{
			var_09 = var_01 * var_02 * 3;
		}

		if(var_09 < 0.25)
		{
			continue;
		}

		if(isdefined(self.maxflashedseconds) && var_09 > self.maxflashedseconds)
		{
			var_09 = self.maxflashedseconds;
		}

		self.var_3405 = var_04;
		self notify("flashed");
		self.flashendtime = gettime() + var_09 * 1000;
		self shellshock("flashbang",var_09);
		common_scripts\utility::flag_set("player_flashed");
		thread maps\_utility_code::func_859F(var_09);
		if(var_01 * var_02 > 0.5)
		{
			thread flashmonitorenablehealthshield(var_09);
		}

		if(var_09 > 2)
		{
			thread flashrumbleloop(0.75);
		}
		else
		{
			thread flashrumbleloop(0.25);
		}

		if(var_04 != "allies")
		{
			thread func_340F(var_09,var_04);
		}
	}
}

//Function Number: 228
func_340F(param_00,param_01)
{
	wait(0.05);
	var_02 = getaiarray("allies");
	for(var_03 = 0;var_03 < var_02.size;var_03++)
	{
		if(distancesquared(var_02[var_03].origin,self.origin) < 122500)
		{
			var_04 = param_00 + randomfloatrange(-1000,1500);
			if(var_04 > 4.5)
			{
				var_04 = 4.5;
			}
			else if(var_04 < 0.25)
			{
				continue;
			}

			var_05 = gettime() + var_04 * 1000;
			if(!isdefined(var_02[var_03].flashendtime) || var_02[var_03].flashendtime < var_05)
			{
				var_02[var_03].var_3405 = param_01;
				var_02[var_03] flashbangstart(var_04);
			}
		}
	}
}

//Function Number: 229
func_6643()
{
	common_scripts\_createfx::func_6641();
}

//Function Number: 230
func_5B5A(param_00)
{
	param_00 = param_00 + "";
	if(isdefined(level.createfxexploders))
	{
		var_01 = level.createfxexploders[param_00];
		if(isdefined(var_01))
		{
			foreach(var_03 in var_01)
			{
				var_03 common_scripts\utility::func_5B59();
			}
		}
	}

	foreach(var_06 in level.createfxent)
	{
		if(!isdefined(var_06.var_880E["exploder"]))
		{
			continue;
		}

		if(var_06.var_880E["exploder"] != var_03)
		{
			continue;
		}

		var_06 common_scripts\utility::func_5B59();
	}
}

//Function Number: 231
func_6644(param_00)
{
	param_00 = param_00 + "";
	if(isdefined(level.createfxexploders))
	{
		var_01 = level.createfxexploders[param_00];
		if(isdefined(var_01))
		{
			foreach(var_03 in var_01)
			{
				var_03 func_6643();
			}
		}
	}

	foreach(var_06 in level.createfxent)
	{
		if(!isdefined(var_06.var_880E["exploder"]))
		{
			continue;
		}

		if(var_06.var_880E["exploder"] != var_03)
		{
			continue;
		}

		var_06 func_6643();
	}
}

//Function Number: 232
func_3ABA(param_00)
{
	var_01 = [];
	if(isdefined(level.createfxbyfxid))
	{
		var_02 = level.createfxbyfxid[param_00];
		if(isdefined(var_02))
		{
			var_01 = var_02;
		}
	}
	else
	{
		for(var_03 = 0;var_03 < level.createfxent.size;var_03++)
		{
			if(level.createfxent[var_03].var_880E["fxid"] == param_00)
			{
				var_01[var_01.size] = level.createfxent[var_03];
			}
		}
	}

	return var_01;
}

//Function Number: 233
func_440A(param_00)
{
	self notify("ignoreAllEnemies_threaded");
	self endon("ignoreAllEnemies_threaded");
	if(param_00)
	{
		self.var_58AC = self getthreatbiasgroup();
		var_01 = undefined;
		createthreatbiasgroup("ignore_everybody");
		self setthreatbiasgroup("ignore_everybody");
		var_02 = [];
		var_02["axis"] = "allies";
		var_02["allies"] = "axis";
		var_03 = getaiarray(var_02[self.team]);
		var_04 = [];
		for(var_05 = 0;var_05 < var_03.size;var_05++)
		{
			var_04[var_03[var_05] getthreatbiasgroup()] = 1;
		}

		var_06 = getarraykeys(var_04);
		for(var_05 = 0;var_05 < var_06.size;var_05++)
		{
			setthreatbias(var_06[var_05],"ignore_everybody",0);
		}
	}

	var_01 = undefined;
	if(self.var_58AC != "")
	{
		self setthreatbiasgroup(self.var_58AC);
	}

	self.var_58AC = undefined;
}

//Function Number: 234
func_88AF()
{
	maps\_vehicle_code::func_8901();
}

//Function Number: 235
func_8911()
{
	thread maps\_vehicle_code::func_8912();
}

//Function Number: 236
func_88E6(param_00)
{
	maps\_vehicle_code::func_88E8(param_00);
}

//Function Number: 237
vehicle_liftoff(param_00)
{
	maps\_vehicle_code::func_88EE(param_00);
}

//Function Number: 238
vehicle_dynamicpath(param_00,param_01)
{
	maps\_vehicle::func_8902(param_00,param_01);
}

//Function Number: 239
func_3DCD(param_00)
{
	return bullettrace(param_00,param_00 + (0,0,-100000),0,self)["position"];
}

//Function Number: 240
func_1AD7(param_00)
{
	self.var_5E28 = self.var_5E28 + param_00;
	self notify("update_health_packets");
	if(self.var_5E28 >= 3)
	{
		self.var_5E28 = 3;
	}
}

//Function Number: 241
func_3C68(param_00)
{
	var_01 = func_3C69(param_00);
	return var_01[0];
}

//Function Number: 242
func_3C69(param_00)
{
	return maps\_vehicle_code::func_6A4(param_00);
}

//Function Number: 243
func_260A(param_00,param_01,param_02,param_03,param_04,param_05)
{
	add_start_assert();
	if(!isdefined(level.var_7A25))
	{
		level.var_7A25 = [];
	}

	level.var_7A25[param_00] = add_start_construct(param_00,param_01,param_02,param_03,param_04,param_05);
}

//Function Number: 244
add_start(param_00,param_01,param_02,param_03,param_04,param_05)
{
	add_start_assert();
	param_00 = tolower(param_00);
	if(isdefined(level.var_7A25) && isdefined(level.var_7A25[param_00]))
	{
		var_07 = level.var_7A25[param_00];
	}
	else
	{
		var_07 = add_start_construct(param_01,param_02,param_03,param_04,param_05,var_07);
	}

	if(!isdefined(param_01))
	{
		if(!isdefined(level.var_7A25))
		{
		}
		else if(!issubstr(param_00,"no_game"))
		{
			if(!isdefined(level.var_7A25[param_00]))
			{
			}
		}
	}

	level.var_7A3F[level.var_7A3F.size] = var_07;
	level.var_79F6[param_00] = var_07;
}

//Function Number: 245
func_4813()
{
	return issubstr(level.start_point,"no_game");
}

//Function Number: 246
add_start_construct(param_00,param_01,param_02,param_03,param_04,param_05)
{
	var_06 = [];
	var_06["name"] = param_00;
	var_06["start_func"] = param_01;
	var_06["start_loc_string"] = param_02;
	var_06["logic_func"] = param_03;
	var_06["transient"] = param_04;
	var_06["catchup_function"] = param_05;
	return var_06;
}

//Function Number: 247
add_start_assert()
{
	if(!isdefined(level.var_7A3F))
	{
		level.var_7A3F = [];
	}
}

//Function Number: 248
func_4DA7()
{
	return level.var_7A3F.size > 1;
}

//Function Number: 249
func_6E83(param_00)
{
	level.var_24AA = param_00;
}

//Function Number: 250
default_start(param_00)
{
	level.default_start = param_00;
}

//Function Number: 251
func_4E21(param_00,param_01,param_02,param_03)
{
	thread maps\_utility_code::func_4E22(param_00,param_01,param_02,param_03);
}

//Function Number: 252
func_8E19(param_00,param_01,param_02,param_03)
{
	var_04 = vectornormalize((param_02[0],param_02[1],0) - (param_00[0],param_00[1],0));
	var_05 = anglestoforward((0,param_01[1],0));
	return vectordot(var_05,var_04) >= param_03;
}

//Function Number: 253
get_dot(param_00,param_01,param_02)
{
	var_03 = vectornormalize(param_02 - param_00);
	var_04 = anglestoforward(param_01);
	var_05 = vectordot(var_04,var_03);
	return var_05;
}

//Function Number: 254
func_8E1A(param_00,param_01)
{
	var_02 = undefined;
	for(var_03 = 0;var_03 < level.players.size;var_03++)
	{
		var_04 = level.players[var_03] geteye();
		var_02 = common_scripts\utility::func_8E18(var_04,level.players[var_03] getplayerangles(),param_00,param_01);
		if(!var_02)
		{
			return 0;
		}
	}

	return 1;
}

//Function Number: 255
func_8A74(param_00,param_01)
{
	var_02 = param_01 * 1000 - gettime() - param_00;
	var_02 = var_02 * 0.001;
	if(var_02 > 0)
	{
		wait(var_02);
	}
}

//Function Number: 256
bcs_scripted_dialogue_start()
{
	anim.var_6D15 = gettime();
}

//Function Number: 257
func_270B(param_00)
{
	bcs_scripted_dialogue_start();
	maps\_anim::anim_single_queue(self,param_00);
}

//Function Number: 258
func_3787(param_00,param_01)
{
	bcs_scripted_dialogue_start();
	maps\_anim::anim_generic_queue(self,param_00,undefined,undefined,param_01);
}

//Function Number: 259
func_62C0(param_00,param_01)
{
	if(!isdefined(level.var_5ED1))
	{
		var_02 = spawn("script_origin",(0,0,0));
		var_02 linkto(level.player,"",(0,0,0),(0,0,0));
		level.var_5ED1 = var_02;
	}

	bcs_scripted_dialogue_start();
	var_03 = 0;
	if(!isdefined(param_01))
	{
		var_03 = level.var_5ED1 function_stack(::func_5D25,level.var_6AF5[param_00],undefined,1);
	}
	else
	{
		var_03 = level.var_5ED1 func_35BD(param_01,::func_5D25,level.var_6AF5[param_00],undefined,1);
	}

	return var_03;
}

//Function Number: 260
func_62C3(param_00)
{
	level.var_5ED1 func_5D25(level.var_6AF5[param_00],undefined,1);
}

//Function Number: 261
func_62C7()
{
	if(!isdefined(level.var_5ED1))
	{
	}

	level.var_5ED1 delete();
}

//Function Number: 262
func_62C1()
{
	if(!isdefined(level.var_5ED1))
	{
	}

	level.var_5ED1 function_stack_clear();
}

//Function Number: 263
func_62C2(param_00)
{
	if(!isdefined(level.var_5ED1))
	{
		var_01 = spawn("script_origin",(0,0,0));
		var_01 linkto(level.player,"",(0,0,0),(0,0,0));
		level.var_5ED1 = var_01;
	}

	level.var_5ED1 func_5D25(level.var_6AF5[param_00],undefined,1);
}

//Function Number: 264
func_62C6(param_00)
{
	return func_62C0(param_00,0.05);
}

//Function Number: 265
smart_radio_dialogue(param_00,param_01)
{
	maps\_utility_code::add_to_radio(param_00);
	func_62C0(param_00,param_01);
}

//Function Number: 266
func_762E(param_00)
{
	maps\_utility_code::add_to_radio(param_00);
	func_62C7();
	func_62C2(param_00);
}

//Function Number: 267
func_762F(param_00)
{
	maps\_utility_code::add_to_radio(param_00);
	func_62C3(param_00);
}

//Function Number: 268
func_7628(param_00)
{
	maps\_utility_code::add_to_dialogue(param_00);
	func_270B(param_00);
}

//Function Number: 269
func_7629(param_00)
{
	maps\_utility_code::add_to_dialogue_generic(param_00);
	func_3787(param_00);
}

//Function Number: 270
func_62C4(param_00)
{
	func_62C0(param_00);
}

//Function Number: 271
hint_create(param_00,param_01,param_02)
{
	var_03 = spawnstruct();
	if(isdefined(param_01) && param_01 == 1)
	{
		var_03.bg = newhudelem();
	}

	var_03.var_2C76 = newhudelem();
	var_03 func_4249(param_02);
	var_03.var_2C76 settext(param_00);
	return var_03;
}

//Function Number: 272
hint_delete()
{
	self notify("death");
	if(isdefined(self.var_2C76))
	{
		self.var_2C76 destroy();
	}

	if(isdefined(self.bg))
	{
		self.bg destroy();
	}
}

//Function Number: 273
func_4249(param_00)
{
	if(level.console)
	{
		self.var_2C76.fontscale = 2;
	}
	else
	{
		self.var_2C76.fontscale = 1.6;
	}

	self.var_2C76.x = 0;
	self.var_2C76.y = -40;
	self.var_2C76.alignx = "center";
	self.var_2C76.aligny = "bottom";
	self.var_2C76.horzalign = "center";
	self.var_2C76.vertalign = "middle";
	self.var_2C76.sort = 1;
	self.var_2C76.alpha = 0.8;
	if(!isdefined(self.bg))
	{
	}

	self.bg.x = 0;
	self.bg.y = -40;
	self.bg.alignx = "center";
	self.bg.aligny = "middle";
	self.bg.horzalign = "center";
	self.bg.vertalign = "middle";
	self.bg.sort = -1;
	if(level.console)
	{
		self.bg setshader("popmenu_bg",650,52);
	}
	else
	{
		self.bg setshader("popmenu_bg",650,42);
	}

	if(!isdefined(param_00))
	{
		param_00 = 0.5;
	}

	self.bg.alpha = param_00;
}

//Function Number: 274
func_7CDD(param_00)
{
	return "" + param_00;
}

//Function Number: 275
ignoreeachother(param_00,param_01)
{
	setignoremegroup(param_00,param_01);
	setignoremegroup(param_01,param_00);
}

//Function Number: 276
func_0897(param_00,param_01,param_02,param_03,param_04)
{
	var_05 = [];
	var_05["function"] = param_01;
	var_05["param1"] = param_02;
	var_05["param2"] = param_03;
	var_05["param3"] = param_04;
	level.var_77C6[param_00][level.var_77C6[param_00].size] = var_05;
}

//Function Number: 277
remove_global_spawn_function(param_00,param_01)
{
	var_02 = [];
	for(var_03 = 0;var_03 < level.var_77C6[param_00].size;var_03++)
	{
		if(level.var_77C6[param_00][var_03]["function"] != param_01)
		{
			var_02[var_02.size] = level.var_77C6[param_00][var_03];
		}
	}

	level.var_77C6[param_00] = var_02;
}

//Function Number: 278
func_3085(param_00,param_01)
{
	if(!isdefined(level.var_77C6))
	{
		return 0;
	}

	for(var_02 = 0;var_02 < level.var_77C6[param_00].size;var_02++)
	{
		if(level.var_77C6[param_00][var_02]["function"] == param_01)
		{
			return 1;
		}
	}

	return 0;
}

//Function Number: 279
func_6555(param_00)
{
	var_01 = [];
	foreach(var_03 in self.var_77C7)
	{
		if(var_03["function"] == param_00)
		{
			continue;
		}

		var_01[var_01.size] = var_03;
	}

	self.var_77C7 = var_01;
}

//Function Number: 280
add_spawn_function(param_00,param_01,param_02,param_03,param_04,param_05)
{
	foreach(var_07 in self.var_77C7)
	{
		if(var_07["function"] == param_00)
		{
		}
	}

	var_09 = [];
	var_09["function"] = param_00;
	var_09["param1"] = param_01;
	var_09["param2"] = param_02;
	var_09["param3"] = param_03;
	var_09["param4"] = param_04;
	var_09["param5"] = param_05;
	self.var_77C7[self.var_77C7.size] = var_09;
}

//Function Number: 281
array_delete(param_00)
{
	for(var_01 = 0;var_01 < param_00.size;var_01++)
	{
		param_00[var_01] delete();
	}
}

//Function Number: 282
array_kill(param_00)
{
	for(var_01 = 0;var_01 < param_00.size;var_01++)
	{
		param_00[var_01] kill();
	}
}

//Function Number: 283
func_4405(param_00)
{
	self endon("death");
	self.ignoretriggers = 1;
	if(isdefined(param_00))
	{
		wait(param_00);
	}
	else
	{
		wait(0.5);
	}

	self.ignoretriggers = 0;
}

//Function Number: 284
activate_trigger_with_targetname(param_00)
{
	var_01 = getent(param_00,"targetname");
	var_01 activate_trigger();
}

//Function Number: 285
activate_trigger_with_noteworthy(param_00)
{
	var_01 = getent(param_00,"script_noteworthy");
	var_01 activate_trigger();
}

//Function Number: 286
func_2793(param_00)
{
	var_01 = getent(param_00,"targetname");
	var_01 common_scripts\utility::trigger_off();
}

//Function Number: 287
disable_trigger_with_noteworthy(param_00)
{
	var_01 = getent(param_00,"script_noteworthy");
	var_01 common_scripts\utility::trigger_off();
}

//Function Number: 288
enable_trigger_with_targetname(param_00)
{
	var_01 = getent(param_00,"targetname");
	var_01 common_scripts\utility::func_837B();
}

//Function Number: 289
enable_trigger_with_noteworthy(param_00)
{
	var_01 = getent(param_00,"script_noteworthy");
	var_01 common_scripts\utility::func_837B();
}

//Function Number: 290
func_47FB()
{
	return isdefined(level.var_4190[get_ai_number()]);
}

//Function Number: 291
get_ai_number()
{
	if(!isdefined(self.unique_id))
	{
		func_6E21();
	}

	return self.unique_id;
}

//Function Number: 292
func_6E21()
{
	self.unique_id = "ai" + level.ai_number;
	level.ai_number++;
}

//Function Number: 293
func_500A()
{
	level.var_4190[self.unique_id] = 1;
}

//Function Number: 294
func_85C5()
{
	level.var_4190[self.unique_id] = undefined;
}

//Function Number: 295
get_heroes()
{
	var_00 = [];
	var_01 = getaiarray("allies");
	for(var_02 = 0;var_02 < var_01.size;var_02++)
	{
		if(var_01[var_02] func_47FB())
		{
			var_00[var_00.size] = var_01[var_02];
		}
	}

	return var_00;
}

//Function Number: 296
func_6FA9(param_00,param_01)
{
	var_02 = getaiarray(param_00);
	for(var_03 = 0;var_03 < var_02.size;var_03++)
	{
		var_02[var_03].pacifist = param_01;
	}
}

//Function Number: 297
func_65C2()
{
	maps\_colors::func_1E1A();
}

//Function Number: 298
func_7813(param_00,param_01)
{
	maps\_colors::func_1E1C(param_00,param_01);
}

//Function Number: 299
clear_promotion_order()
{
	level.current_color_order = [];
}

//Function Number: 300
func_6F82(param_00,param_01)
{
	if(!isdefined(level.current_color_order))
	{
		level.current_color_order = [];
	}

	param_00 = func_7454(param_00);
	param_01 = func_7454(param_01);
	level.current_color_order[param_00] = param_01;
	if(!isdefined(level.current_color_order[param_01]))
	{
		func_6EA7(param_01);
	}
}

//Function Number: 301
func_6EA7(param_00)
{
	if(!isdefined(level.current_color_order))
	{
		level.current_color_order = [];
	}

	level.current_color_order[param_00] = "none";
}

//Function Number: 302
func_651A(param_00)
{
	var_01 = [];
	foreach(var_03 in param_00)
	{
		if(!isalive(var_03))
		{
			continue;
		}

		var_01[var_01.size] = var_03;
	}

	return var_01;
}

//Function Number: 303
func_6535(param_00)
{
	var_01 = [];
	for(var_02 = 0;var_02 < param_00.size;var_02++)
	{
		if(param_00[var_02] func_47FB())
		{
			continue;
		}

		var_01[var_01.size] = param_00[var_02];
	}

	return var_01;
}

//Function Number: 304
func_6515(param_00,param_01)
{
	var_02 = [];
	for(var_03 = 0;var_03 < param_00.size;var_03++)
	{
		var_04 = param_00[var_03];
		if(!isdefined(var_04.var_6BCF))
		{
			continue;
		}

		if(var_04.var_6BCF == param_01)
		{
			continue;
		}

		var_02[var_02.size] = var_04;
	}

	return var_02;
}

//Function Number: 305
func_6545(param_00,param_01)
{
	var_02 = [];
	for(var_03 = 0;var_03 < param_00.size;var_03++)
	{
		var_04 = param_00[var_03];
		if(!isdefined(var_04.script_noteworthy))
		{
			continue;
		}

		if(var_04.script_noteworthy == param_01)
		{
			continue;
		}

		var_02[var_02.size] = var_04;
	}

	return var_02;
}

//Function Number: 306
get_closest_colored_friendly(param_00,param_01)
{
	var_02 = get_force_color_guys("allies",param_00);
	var_02 = func_6535(var_02);
	if(!isdefined(param_01))
	{
		var_03 = level.player.origin;
	}
	else
	{
		var_03 = var_02;
	}

	return common_scripts\utility::func_3A56(var_03,var_02);
}

//Function Number: 307
remove_without_classname(param_00,param_01)
{
	var_02 = [];
	for(var_03 = 0;var_03 < param_00.size;var_03++)
	{
		if(!issubstr(param_00[var_03].classname,param_01))
		{
			continue;
		}

		var_02[var_02.size] = param_00[var_03];
	}

	return var_02;
}

//Function Number: 308
func_6568(param_00,param_01)
{
	var_02 = [];
	for(var_03 = 0;var_03 < param_00.size;var_03++)
	{
		if(!issubstr(param_00[var_03].model,param_01))
		{
			continue;
		}

		var_02[var_02.size] = param_00[var_03];
	}

	return var_02;
}

//Function Number: 309
get_closest_colored_friendly_with_classname(param_00,param_01,param_02)
{
	var_03 = get_force_color_guys("allies",param_00);
	var_03 = func_6535(var_03);
	if(!isdefined(param_02))
	{
		var_04 = level.player.origin;
	}
	else
	{
		var_04 = var_03;
	}

	var_03 = remove_without_classname(var_03,param_01);
	return common_scripts\utility::func_3A56(var_04,var_03);
}

//Function Number: 310
func_61EB(param_00,param_01)
{
	for(;;)
	{
		var_02 = get_closest_colored_friendly(param_00);
		if(!isalive(var_02))
		{
			wait(1);
			continue;
		}

		var_02 func_6EDF(param_01);
	}
}

//Function Number: 311
func_466E(param_00,param_01)
{
	for(;;)
	{
		var_02 = get_closest_colored_friendly(param_00);
		if(!isalive(var_02))
		{
		}

		var_02 func_6EDF(param_01);
	}
}

//Function Number: 312
func_466F(param_00,param_01,param_02)
{
	for(;;)
	{
		var_03 = get_closest_colored_friendly_with_classname(param_00,param_02);
		if(!isalive(var_03))
		{
		}

		var_03 func_6EDF(param_01);
	}
}

//Function Number: 313
promote_nearest_friendly_with_classname(param_00,param_01,param_02)
{
	for(;;)
	{
		var_03 = get_closest_colored_friendly_with_classname(param_00,param_02);
		if(!isalive(var_03))
		{
			wait(1);
			continue;
		}

		var_03 func_6EDF(param_01);
	}
}

//Function Number: 314
func_66D6(param_00)
{
	self orientmode("face angle",param_00);
	self.lockorientation = 1;
}

//Function Number: 315
func_66D8()
{
	self.lockorientation = 0;
}

//Function Number: 316
func_4671(param_00,param_01,param_02)
{
	var_03 = 0;
	var_04 = [];
	for(var_05 = 0;var_05 < param_00.size;var_05++)
	{
		var_06 = param_00[var_05];
		if(var_03 || !issubstr(var_06.classname,param_02))
		{
			var_04[var_04.size] = var_06;
			continue;
		}

		var_03 = 1;
		var_06 func_6EDF(param_01);
	}

	return var_04;
}

//Function Number: 317
func_4670(param_00,param_01)
{
	var_02 = 0;
	var_03 = [];
	for(var_04 = 0;var_04 < param_00.size;var_04++)
	{
		var_05 = param_00[var_04];
		if(var_02)
		{
			var_03[var_03.size] = var_05;
			continue;
		}

		var_02 = 1;
		var_05 func_6EDF(param_01);
	}

	return var_03;
}

//Function Number: 318
func_8A98(param_00)
{
	maps\_utility_code::func_8AA0(param_00,"script_noteworthy");
}

//Function Number: 319
func_8A9E(param_00)
{
	maps\_utility_code::func_8AA0(param_00,"targetname");
}

//Function Number: 320
func_8A82(param_00,param_01)
{
	if(common_scripts\utility::flag(param_00))
	{
	}

	level endon(param_00);
	wait(param_01);
}

//Function Number: 321
func_8A88(param_00,param_01)
{
	self endon(param_00);
	wait(param_01);
}

//Function Number: 322
func_8AA1(param_00)
{
	self endon("trigger");
	wait(param_00);
}

//Function Number: 323
func_8A7D(param_00,param_01)
{
	var_02 = spawnstruct();
	var_03 = [];
	var_03 = common_scripts\utility::array_combine(var_03,getentarray(param_00,"targetname"));
	var_03 = common_scripts\utility::array_combine(var_03,getentarray(param_01,"targetname"));
	for(var_04 = 0;var_04 < var_03.size;var_04++)
	{
		var_02 thread maps\_utility_code::ent_waits_for_trigger(var_03[var_04]);
	}

	var_02 waittill("done");
}

//Function Number: 324
func_2B2B(param_00)
{
	var_01 = maps\_spawner::func_7870(param_00);
	return var_01;
}

//Function Number: 325
func_2B2A(param_00)
{
	if(!isdefined(param_00))
	{
		param_00 = self;
	}

	var_01 = maps\_spawner::func_7870(param_00);
	var_01 [[ level.var_2B0B ]]();
	var_01.var_77C6 = param_00.var_77C7;
	var_01 thread maps\_spawner::run_spawn_functions();
	return var_01;
}

//Function Number: 326
func_5018(param_00)
{
	return maps\_spawner::func_7873(param_00);
}

//Function Number: 327
func_39D6()
{
	if(isdefined(self.script_flag))
	{
		return self.script_flag;
	}

	if(isdefined(self.script_noteworthy))
	{
		return self.script_noteworthy;
	}
}

//Function Number: 328
func_6E81()
{
	self.pathenemylookahead = 192;
	self.pathenemyfightdist = 192;
}

//Function Number: 329
func_1FF4(param_00)
{
	if(param_00 == "on")
	{
		enable_cqbwalk();
	}

	disable_cqbwalk();
}

//Function Number: 330
enable_cqbwalk(param_00)
{
	if(self.type == "dog")
	{
	}

	if(!isdefined(param_00))
	{
		self.cqbenabled = 1;
	}

	self.var_1FFA = 1;
	self.turnrate = 0.2;
	level thread animscripts/cqb::func_3284();
}

//Function Number: 331
disable_cqbwalk()
{
	if(self.type == "dog")
	{
	}

	self.var_1FFA = undefined;
	self.cqbenabled = undefined;
	self.turnrate = 0.3;
	self.cqb_point_of_interest = undefined;
}

//Function Number: 332
func_2CC4()
{
	self.busereadyidle = 1;
}

//Function Number: 333
disable_readystand()
{
	self.busereadyidle = undefined;
}

//Function Number: 334
cqb_aim(param_00)
{
	if(!isdefined(param_00))
	{
		self.var_1FF2 = undefined;
	}

	self.var_1FF2 = param_00;
	if(!isdefined(param_00.origin))
	{
	}
}

//Function Number: 335
func_6EE1(param_00)
{
	if(isdefined(param_00) && param_00)
	{
		self.var_34E1 = 1;
	}

	self.var_34E1 = undefined;
}

//Function Number: 336
func_2833(param_00,param_01,param_02,param_03)
{
	if(isdefined(param_01))
	{
		[[ param_00 ]](param_01);
	}
	else
	{
		[[ param_00 ]]();
	}

	if(isdefined(param_03))
	{
		[[ param_02 ]](param_03);
	}

	[[ param_02 ]]();
}

//Function Number: 337
func_6D98(param_00,param_01)
{
	if(isdefined(param_01))
	{
		self notify(param_00,param_01);
	}

	self notify(param_00);
}

//Function Number: 338
func_8B6E(param_00,param_01,param_02)
{
	var_03 = spawnstruct();
	var_03 endon("complete");
	var_03 func_252F(param_02,::func_6D98,"complete");
	self waittillmatch(param_01,param_00);
}

//Function Number: 339
func_2588(param_00)
{
	param_00 notify("deleted");
	param_00 delete();
}

//Function Number: 340
func_335F(param_00)
{
	if(!isdefined(self.touched))
	{
		self.touched = [];
	}

	if(isdefined(self.touched[param_00.unique_id]))
	{
		return 0;
	}

	self.touched[param_00.unique_id] = 1;
	return 1;
}

//Function Number: 341
func_3A1F(param_00)
{
	return level.scr_anim[self.animname][param_00];
}

//Function Number: 342
func_3FFC(param_00)
{
	return isdefined(level.scr_anim[self.animname][param_00]);
}

//Function Number: 343
func_3A20(param_00,param_01)
{
	return level.scr_anim[param_01][param_00];
}

//Function Number: 344
func_3A21(param_00)
{
	return level.scr_anim["generic"][param_00];
}

//Function Number: 345
add_hint_string(param_00,param_01,param_02)
{
	if(!isdefined(level.var_8358))
	{
		level.var_8358 = [];
		level.var_8357 = [];
	}

	level.var_8358[param_00] = param_01;
	precachestring(param_01);
	if(isdefined(param_02))
	{
		level.var_8357[param_00] = param_02;
	}
}

//Function Number: 346
func_74E9(param_00)
{
	thread maps\_utility_code::func_7513(param_00);
}

//Function Number: 347
hide_hint(param_00)
{
	param_00.timeout = 1;
}

//Function Number: 348
fire_radius(param_00,param_01)
{
	var_02 = spawn("trigger_radius",param_00,0,param_01,48);
	for(;;)
	{
		var_02 waittill("trigger",var_03);
		level.player dodamage(5,param_00);
	}
}

//Function Number: 349
clearthreatbias(param_00,param_01)
{
	setthreatbias(param_00,param_01,0);
	setthreatbias(param_01,param_00,0);
}

//Function Number: 350
func_80AD()
{
	animscripts/combat_utility::func_80AE();
}

//Function Number: 351
array_combine_keys(param_00,param_01)
{
	if(!param_00.size)
	{
		return param_01;
	}

	var_02 = getarraykeys(param_01);
	for(var_03 = 0;var_03 < var_02.size;var_03++)
	{
		param_00[var_02[var_03]] = param_01[var_02[var_03]];
	}

	return param_00;
}

//Function Number: 352
set_ignoresuppression(param_00)
{
	self.ignoresuppression = param_00;
}

//Function Number: 353
func_6EFF(param_00)
{
	self.goalradius = param_00;
}

//Function Number: 354
func_83E6()
{
	var_00 = self.var_30F7;
	for(;;)
	{
		var_01 = self dospawn();
		if(func_77BE(var_01))
		{
			wait(1);
			continue;
		}

		return var_01;
	}
}

//Function Number: 355
set_allowdeath(param_00)
{
	self.allowdeath = param_00;
}

//Function Number: 356
func_6F89(param_00,param_01)
{
	if(isdefined(param_01))
	{
		self.alwaysrunforward = param_01;
	}
	else
	{
		self.alwaysrunforward = 1;
	}

	disable_turnanims();
	self.run_overrideanim = level.scr_anim[self.animname][param_00];
	self.var_8BD8 = self.run_overrideanim;
}

//Function Number: 357
func_6E98()
{
	self.a.var_5486 = "walk";
	self.var_279A = 1;
	self.disableexits = 1;
	self.var_6C58 = 1;
}

//Function Number: 358
func_6E62(param_00,param_01,param_02,param_03)
{
	animscripts/animset::init_animset_custom_stand(param_00,param_01,param_02,param_03);
}

//Function Number: 359
func_6F2C(param_00,param_01,param_02)
{
	var_03 = animscripts/utility::func_4F5D(param_00);
	if(isarray(param_01))
	{
		var_03["straight"] = param_01[0];
		var_03["move_f"] = param_01[0];
		var_03["move_l"] = param_01[1];
		var_03["move_r"] = param_01[2];
		var_03["move_b"] = param_01[3];
	}
	else
	{
		var_03["straight"] = param_01;
		var_03["move_f"] = param_01;
	}

	if(isdefined(param_02))
	{
		var_03["sprint"] = param_02;
	}

	self.custommoveanimset[param_00] = var_03;
}

//Function Number: 360
func_6EED(param_00)
{
	var_01 = level.scr_anim["generic"][param_00];
	if(isarray(var_01))
	{
		self.var_78ED = var_01;
	}

	self.var_78ED[0] = var_01;
}

//Function Number: 361
func_6F0D(param_00)
{
	var_01 = level.scr_anim[self.animname][param_00];
	if(isarray(var_01))
	{
		self.var_78ED = var_01;
	}

	self.var_78ED[0] = var_01;
}

//Function Number: 362
func_1D11()
{
	self.var_78ED = undefined;
	self notify("stop_specialidle");
}

//Function Number: 363
func_6EF0(param_00,param_01)
{
	func_6EF1(param_00,undefined,param_01);
}

//Function Number: 364
clear_generic_run_anim()
{
	self notify("movemode");
	enable_turnanims();
	self.run_overrideanim = undefined;
	self.var_8BD8 = undefined;
}

//Function Number: 365
func_6EF1(param_00,param_01,param_02)
{
	self notify("movemode");
	if(!isdefined(param_02) || param_02)
	{
		self.alwaysrunforward = 1;
	}
	else
	{
		self.alwaysrunforward = undefined;
	}

	disable_turnanims();
	self.run_overrideanim = level.scr_anim["generic"][param_00];
	self.var_8BD8 = self.run_overrideanim;
	if(isdefined(param_01))
	{
		self.var_6969 = level.scr_anim["generic"][param_01];
		self.var_8BD7 = self.var_6969;
	}

	self.var_6969 = undefined;
	self.var_8BD7 = undefined;
}

//Function Number: 366
func_6F8A(param_00,param_01,param_02)
{
	self notify("movemode");
	if(!isdefined(param_02) || param_02)
	{
		self.alwaysrunforward = 1;
	}
	else
	{
		self.alwaysrunforward = undefined;
	}

	disable_turnanims();
	self.run_overrideanim = level.scr_anim[self.animname][param_00];
	self.var_8BD8 = self.run_overrideanim;
	if(isdefined(param_01))
	{
		self.var_6969 = level.scr_anim[self.animname][param_01];
		self.var_8BD7 = self.var_6969;
	}

	self.var_6969 = undefined;
	self.var_8BD7 = undefined;
}

//Function Number: 367
clear_run_anim()
{
	self notify("clear_run_anim");
	self notify("movemode");
	if(self.type == "dog")
	{
		self.a.var_5486 = "run";
		self.var_279A = 0;
		self.disableexits = 0;
		self.var_6C58 = undefined;
	}

	if(!isdefined(self.var_1A65))
	{
		enable_turnanims();
	}

	self.alwaysrunforward = undefined;
	self.run_overrideanim = undefined;
	self.var_8BD8 = undefined;
	self.var_6969 = undefined;
	self.var_8BD7 = undefined;
}

//Function Number: 368
debugvar(param_00,param_01)
{
	setdvarifuninitialized(param_00,param_01);
	return getdvarfloat(param_00);
}

//Function Number: 369
physicsjolt_proximity(param_00,param_01,param_02)
{
	self endon("death");
	self endon("stop_physicsjolt");
	if(!isdefined(param_00) || !isdefined(param_01) || !isdefined(param_02))
	{
		param_00 = 400;
		param_01 = 256;
		param_02 = (0,0,0.075);
	}

	var_03 = param_00 * param_00;
	var_04 = 3;
	var_05 = param_02;
	for(;;)
	{
		wait(0.1);
		param_02 = var_05;
		if(self.code_classname == "script_vehicle")
		{
			var_06 = self vehicle_getspeed();
			if(var_06 < var_04)
			{
				var_07 = var_06 / var_04;
				param_02 = var_05 * var_07;
			}
		}

		var_08 = distancesquared(self.origin,level.player.origin);
		var_07 = var_03 / var_08;
		if(var_07 > 1)
		{
			var_07 = 1;
		}

		param_02 = param_02 * var_07;
		var_09 = param_02[0] + param_02[1] + param_02[2];
		if(var_09 > 0.025)
		{
			physicsjitter(self.origin,param_00,param_01,param_02[2],param_02[2] * 2);
		}
	}
}

//Function Number: 370
func_6EF6(param_00)
{
	self setgoalentity(param_00);
}

//Function Number: 371
activate_trigger(param_00,param_01,param_02)
{
	if(!isdefined(param_00))
	{
		activate_trigger_process(param_02);
	}

	common_scripts\utility::func_F1B(getentarray(param_00,param_01),::activate_trigger_process,param_02);
}

//Function Number: 372
activate_trigger_process(param_00)
{
	if(isdefined(self.var_6B66))
	{
		self.activated_color_trigger = 1;
		maps\_colors::activate_color_trigger("allies");
	}

	if(isdefined(self.script_color_axis))
	{
		self.activated_color_trigger = 1;
		maps\_colors::activate_color_trigger("axis");
	}

	self notify("trigger",param_00);
}

//Function Number: 373
func_6D86()
{
	self delete();
}

//Function Number: 374
remove_nocolor_from_array(param_00)
{
	var_01 = [];
	for(var_02 = 0;var_02 < param_00.size;var_02++)
	{
		var_03 = param_00[var_02];
		if(var_03 func_3FD6())
		{
			var_01[var_01.size] = var_03;
		}
	}

	return var_01;
}

//Function Number: 375
func_3FD6()
{
	if(maps\_colors::func_39C5() == "axis")
	{
		return isdefined(self.script_color_axis) || isdefined(self.var_6BCF);
	}

	return isdefined(self.var_6B66) || isdefined(self.var_6BCF);
}

//Function Number: 376
clear_colors()
{
	func_1D27("axis");
	func_1D27("allies");
}

//Function Number: 377
func_1D27(param_00)
{
	level.currentcolorforced[param_00]["r"] = undefined;
	level.currentcolorforced[param_00]["b"] = undefined;
	level.currentcolorforced[param_00]["c"] = undefined;
	level.currentcolorforced[param_00]["y"] = undefined;
	level.currentcolorforced[param_00]["p"] = undefined;
	level.currentcolorforced[param_00]["o"] = undefined;
	level.currentcolorforced[param_00]["g"] = undefined;
}

//Function Number: 378
func_3992()
{
	var_00 = [];
	var_00["r"] = (1,0,0);
	var_00["o"] = (1,0.5,0);
	var_00["y"] = (1,1,0);
	var_00["g"] = (0,1,0);
	var_00["c"] = (0,1,1);
	var_00["b"] = (0,0,1);
	var_00["p"] = (1,0,1);
	return var_00;
}

//Function Number: 379
func_5704(param_00,param_01)
{
	self endon("death");
	if(param_01 > 0)
	{
		wait(param_01);
	}

	if(!isdefined(self))
	{
	}

	self notify(param_00);
}

//Function Number: 380
func_3DFD()
{
	if(isai(self))
	{
		animscripts/shared::placeweaponon(self.weapon,"none");
	}

	self detach(getweaponmodel(self.weapon),"tag_weapon_right");
}

//Function Number: 381
gun_recall()
{
	if(isai(self))
	{
		animscripts/shared::placeweaponon(self.weapon,"right");
	}

	self attach(getweaponmodel(self.weapon),"tag_weapon_right");
}

//Function Number: 382
place_weapon_on(param_00,param_01)
{
	if(!animscripts/utility::aihasweapon(param_00))
	{
		animscripts/init::initweapon(param_00);
	}

	animscripts/shared::placeweaponon(param_00,param_01);
}

//Function Number: 383
func_34E3(param_00,param_01)
{
	if(!animscripts/init::func_49B7(param_00))
	{
		animscripts/init::initweapon(param_00);
	}

	var_02 = self.weapon != "none";
	var_03 = animscripts/utility::func_87FE();
	var_04 = param_01 == "sidearm";
	var_05 = param_01 == "secondary";
	if(var_02 && var_03 != var_04)
	{
		if(var_03)
		{
			var_06 = "none";
		}
		else if(var_06)
		{
			var_06 = "back";
		}
		else
		{
			var_06 = "chest";
		}

		animscripts/shared::placeweaponon(self.weapon,var_06);
		self.lastweapon = self.weapon;
	}
	else
	{
		self.lastweapon = param_00;
	}

	animscripts/shared::placeweaponon(param_00,"right");
	if(var_04)
	{
		self.var_7544 = param_00;
	}
	else if(var_05)
	{
		self.secondaryweapon = param_00;
	}
	else
	{
		self.primaryweapon = param_00;
	}

	self.weapon = param_00;
	self.bulletsinclip = weaponclipsize(self.weapon);
	self notify("weapon_switch_done");
}

//Function Number: 384
lerp_player_view_to_tag(param_00,param_01,param_02,param_03,param_04,param_05,param_06,param_07)
{
	maps\_utility_code::func_4D8A(param_00,param_01,param_02,param_03,param_04,param_05,param_06,param_07,0);
}

//Function Number: 385
func_4D89(param_00,param_01,param_02,param_03,param_04,param_05,param_06,param_07)
{
	maps\_utility_code::func_4D8A(param_00,param_01,param_02,param_03,param_04,param_05,param_06,param_07,1);
}

//Function Number: 386
func_4D86(param_00,param_01,param_02,param_03,param_04,param_05,param_06,param_07,param_08,param_09)
{
	param_09 = func_3942();
	var_0A = spawn("script_origin",(0,0,0));
	var_0A.origin = param_09.origin;
	var_0A.angles = param_09 getplayerangles();
	if(isdefined(param_08) && param_08)
	{
		param_09 playerlinkto(var_0A,"",param_03,param_04,param_05,param_06,param_07,param_08);
	}
	else if(isdefined(param_04))
	{
		param_09 playerlinkto(var_0A,"",param_03,param_04,param_05,param_06,param_07);
	}
	else if(isdefined(param_03))
	{
		param_09 playerlinkto(var_0A,"",param_03);
	}
	else
	{
		param_09 playerlinkto(var_0A);
	}

	var_0A moveto(param_00,param_02,param_02 * 0.25);
	var_0A rotateto(param_01,param_02,param_02 * 0.25);
	wait(param_02);
	var_0A delete();
}

//Function Number: 387
func_4D8B(param_00,param_01,param_02,param_03,param_04,param_05,param_06,param_07)
{
	maps\_utility_code::lerp_player_view_to_tag_oldstyle_internal(param_00,param_01,param_02,param_03,param_04,param_05,param_06,param_07,0);
}

//Function Number: 388
func_4D87(param_00,param_01,param_02,param_03,param_04,param_05,param_06,param_07,param_08)
{
	var_09 = func_3942();
	var_0A = spawn("script_origin",(0,0,0));
	var_0A.origin = var_09 get_player_feet_from_view();
	var_0A.angles = var_09 getplayerangles();
	if(isdefined(param_08))
	{
		var_09 playerlinktodelta(var_0A,"",param_03,param_04,param_05,param_06,param_07,param_08);
	}
	else if(isdefined(param_04))
	{
		var_09 playerlinktodelta(var_0A,"",param_03,param_04,param_05,param_06,param_07);
	}
	else if(isdefined(param_03))
	{
		var_09 playerlinktodelta(var_0A,"",param_03);
	}
	else
	{
		var_09 playerlinktodelta(var_0A);
	}

	var_0A moveto(param_00,param_02,param_02 * 0.25);
	var_0A rotateto(param_01,param_02,param_02 * 0.25);
	wait(param_02);
	var_0A delete();
}

//Function Number: 389
func_5EA5(param_00)
{
	var_01 = level.player.origin;
	for(;;)
	{
		if(distance(var_01,level.player.origin) > param_00)
		{
			break;
		}

		wait(0.05);
	}
}

//Function Number: 390
func_8B50(param_00,param_01,param_02,param_03)
{
	var_04 = spawnstruct();
	thread maps\_utility_code::func_8B51(var_04,param_00,param_01);
	thread maps\_utility_code::func_8B51(var_04,param_02,param_03);
	var_04 waittill("done");
}

//Function Number: 391
func_8B71(param_00)
{
	self waittill(param_00);
}

//Function Number: 392
display_hint(param_00,param_01,param_02,param_03)
{
	var_04 = func_3942();
	if(isdefined(level.var_8357[param_00]))
	{
		if(var_04 [[ level.var_8357[param_00] ]]())
		{
		}

		var_04 thread maps\_utility_code::func_4263(level.var_8358[param_00],level.var_8357[param_00],param_01,param_02,param_03,30);
	}

	var_04 thread maps\_utility_code::func_4263(level.var_8358[param_00],undefined,undefined,undefined,undefined,30);
}

//Function Number: 393
display_hint_timeout(param_00,param_01,param_02,param_03,param_04)
{
	var_05 = func_3942();
	if(var_05 [[ level.var_8357[param_00] ]]())
	{
	}

	var_05 thread maps\_utility_code::func_4263(level.var_8358[param_00],level.var_8357[param_00],param_02,param_03,param_04,param_01);
}

//Function Number: 394
display_hint_timeout_mintime(param_00,param_01,param_02,param_03,param_04,param_05)
{
	var_06 = func_3942();
	if(var_06 [[ level.var_8357[param_00] ]]())
	{
	}

	var_06 thread maps\_utility_code::func_4263(level.var_8358[param_00],level.var_8357[param_00],param_03,param_04,param_05,param_01,param_02);
}

//Function Number: 395
display_hint_stick(param_00,param_01,param_02,param_03,param_04,param_05,param_06,param_07,param_08,param_09)
{
	if(!isdefined(param_06))
	{
		param_06 = 0;
	}

	var_0A = maps\_utility_code::func_424D(param_00,param_01,param_02,param_03,param_04,param_05,param_06);
	thread display_hint(var_0A,param_07,param_08,param_09);
	thread maps\_utility_code::func_424E(param_00,param_01,param_02,param_03,param_04,param_05,param_06);
}

//Function Number: 396
display_hint_stick_timeout(param_00,param_01,param_02,param_03,param_04,param_05,param_06,param_07,param_08,param_09,param_0A)
{
	if(!isdefined(param_07))
	{
		param_07 = 0;
	}

	var_0B = maps\_utility_code::func_424D(param_00,param_02,param_03,param_04,param_05,param_06,param_07);
	thread display_hint_timeout(var_0B,param_01,param_08,param_09,param_0A);
	thread maps\_utility_code::func_424E(param_00,param_02,param_03,param_04,param_05,param_06,param_07);
}

//Function Number: 397
display_hint_stick_timeout_mintime(param_00,param_01,param_02,param_03,param_04,param_05,param_06,param_07,param_08,param_09,param_0A,param_0B)
{
	if(!isdefined(param_08))
	{
		param_08 = 0;
	}

	var_0C = maps\_utility_code::func_424D(param_00,param_03,param_04,param_05,param_06,param_07,param_08);
	thread display_hint_timeout_mintime(var_0C,param_01,param_02,param_09,param_0A,param_0B);
	thread maps\_utility_code::func_424E(param_00,param_03,param_04,param_05,param_06,param_07,param_08);
}

//Function Number: 398
func_1B6D(param_00,param_01,param_02,param_03)
{
	if(isdefined(param_03))
	{
		return [[ level.var_8357[param_00] ]](param_01,param_02,param_03);
	}

	if(isdefined(param_02))
	{
		return [[ level.var_8357[param_00] ]](param_01,param_02);
	}

	if(isdefined(param_01))
	{
		return [[ level.var_8357[param_00] ]](param_01);
	}

	return [[ level.var_8357[param_00] ]]();
}

//Function Number: 399
getgenericanim(param_00)
{
	return level.scr_anim["generic"][param_00];
}

//Function Number: 400
enable_careful()
{
	self.var_6B5E = 1;
}

//Function Number: 401
disable_careful()
{
	self.var_6B5E = 0;
	self notify("stop_being_careful");
}

//Function Number: 402
enable_sprint()
{
	self.var_797D = 1;
}

//Function Number: 403
disable_sprint()
{
	self.var_797D = undefined;
}

//Function Number: 404
disable_bulletwhizbyreaction()
{
	self.var_279D = 1;
}

//Function Number: 405
enable_bulletwhizbyreaction()
{
	self.var_279D = undefined;
}

//Function Number: 406
func_1D0A(param_00)
{
	setdvar(param_00,"");
}

//Function Number: 407
func_6EB9()
{
	self.fixednode = 1;
}

//Function Number: 408
func_6EB8()
{
	self.fixednode = 0;
}

//Function Number: 409
func_7766(param_00,param_01)
{
	if(isdefined(self.var_6B81))
	{
		self endon("death");
		wait(self.var_6B81);
	}

	var_02 = undefined;
	var_03 = isdefined(self.var_6CC2) && common_scripts\utility::flag("_stealth_enabled") && !common_scripts\utility::flag("_stealth_spotted");
	if(isdefined(self.var_6BD5) || isdefined(param_00))
	{
		if(!isdefined(self.var_6B97))
		{
			var_02 = self stalingradspawn(var_03);
		}
		else
		{
			var_02 = func_2B2A(self);
		}
	}
	else if(!isdefined(self.var_6B97))
	{
		var_02 = self dospawn(var_03);
	}
	else
	{
		var_02 = func_2B2A(self);
	}

	if(isdefined(param_01) && param_01 && isalive(var_02))
	{
		var_02 magic_bullet_shield();
	}

	if(!isdefined(self.var_6B97))
	{
		func_77BE(var_02);
	}

	if(isdefined(self.var_6CAE))
	{
		self delete();
	}

	return var_02;
}

//Function Number: 410
function_stack(param_00,param_01,param_02,param_03,param_04,param_05)
{
	var_06 = spawnstruct();
	var_06 thread maps\_utility_code::func_35BB(self,param_00,param_01,param_02,param_03,param_04,param_05);
	return maps\_utility_code::function_stack_wait_finish(var_06);
}

//Function Number: 411
func_35BD(param_00,param_01,param_02,param_03,param_04,param_05,param_06)
{
	var_07 = spawnstruct();
	var_07 thread maps\_utility_code::func_35BB(self,param_01,param_02,param_03,param_04,param_05,param_06);
	if(isdefined(var_07.var_35BA) || var_07 common_scripts\utility::func_8B35(param_00,"function_stack_func_begun") != "timeout")
	{
		return maps\_utility_code::function_stack_wait_finish(var_07);
	}

	var_07 notify("death");
	return 0;
}

//Function Number: 412
function_stack_clear()
{
	var_00 = [];
	if(isdefined(self.function_stack[0]) && isdefined(self.function_stack[0].var_35BA))
	{
		var_00[0] = self.function_stack[0];
	}

	self.function_stack = undefined;
	self notify("clear_function_stack");
	waittillframeend;
	if(!var_00.size)
	{
	}

	if(!var_00[0].var_35BA)
	{
	}

	self.function_stack = var_00;
}

//Function Number: 413
geo_off()
{
	if(isdefined(self.geo_off))
	{
	}

	self.realorigin = self getorigin();
	self moveto(self.realorigin + (0,0,-10000),0.2);
	self.geo_off = 1;
}

//Function Number: 414
geo_on()
{
	if(!isdefined(self.geo_off))
	{
	}

	self moveto(self.realorigin,0.2);
	self waittill("movedone");
	self.geo_off = undefined;
}

//Function Number: 415
disable_exits()
{
	self.disableexits = 1;
}

//Function Number: 416
func_2CB1()
{
	self.disableexits = undefined;
}

//Function Number: 417
disable_turnanims()
{
	self.var_5739 = 1;
}

//Function Number: 418
enable_turnanims()
{
	self.var_5739 = undefined;
}

//Function Number: 419
disable_arrivals()
{
	self.var_279A = 1;
}

//Function Number: 420
func_2C9C()
{
	self endon("death");
	waittillframeend;
	self.var_279A = undefined;
}

//Function Number: 421
func_6E5A(param_00,param_01)
{
	setblur(param_00,param_01);
}

//Function Number: 422
func_6EFD(param_00)
{
	self.goalradius = param_00;
}

//Function Number: 423
func_6EF9(param_00)
{
	self.var_4C22 = param_00;
	self.last_set_goalpos = undefined;
	self.last_set_goalent = undefined;
	self setgoalnode(param_00);
}

//Function Number: 424
func_6EFA(param_00)
{
	var_01 = getnode(param_00,"targetname");
	func_6EF9(var_01);
}

//Function Number: 425
func_6EFB(param_00)
{
	self.var_4C22 = undefined;
	self.last_set_goalpos = param_00;
	self.last_set_goalent = undefined;
	self setgoalpos(param_00);
}

//Function Number: 426
func_6EF4(param_00)
{
	func_6EFB(param_00.origin);
	self.last_set_goalent = param_00;
}

//Function Number: 427
func_57CC(param_00)
{
	maps\_utility_code::func_57D6(param_00);
	objective_state(param_00,"done");
	level notify("objective_complete" + param_00);
}

//Function Number: 428
func_3FAA(param_00,param_01,param_02,param_03)
{
	var_04 = 1;
	if(isdefined(param_01))
	{
		var_04 = !param_01;
	}

	if(isdefined(param_02))
	{
		level endon(param_02);
	}

	if(isdefined(param_03))
	{
		level waittill(param_03);
	}

	var_05 = "signal_" + param_00;
	if(self.a.var_60B1 == "crouch")
	{
		var_05 = var_05 + "_crouch";
	}
	else if(self.script == "cover_right" || self.script == "cover_multi" && self.cover.state == "right")
	{
		var_05 = var_05 + "_coverR";
	}
	else if(animscripts/utility::func_48A0())
	{
		var_05 = var_05 + "_cqb";
	}

	if(var_04)
	{
		self setanimrestart(getgenericanim(var_05),1,0,1.1);
	}

	maps\_anim::func_D64(self,var_05);
}

//Function Number: 429
array_spawn(param_00,param_01,param_02)
{
	if(!isdefined(param_02))
	{
		param_02 = 0;
	}

	var_03 = [];
	foreach(var_05 in param_00)
	{
		var_05.count = 1;
		if(getsubstr(var_05.classname,7,10) == "veh")
		{
			var_06 = var_05 func_784B();
			if(isdefined(var_06.target) && !isdefined(var_06.var_6C36))
			{
				var_06 thread maps\_vehicle::gopath();
			}

			var_03[var_03.size] = var_06;
			continue;
		}

		var_06 = var_05 func_7766(param_01);
		if(!param_02)
		{
		}

		var_03[var_03.size] = var_06;
	}

	if(!param_02)
	{
	}

	return var_03;
}

//Function Number: 430
array_spawn_targetname(param_00,param_01,param_02,param_03)
{
	var_04 = getentarray(param_00,"targetname");
	if(isdefined(level.var_780E))
	{
		var_05 = common_scripts\utility::func_3C1A(param_00,"targetname");
		if(isdefined(param_03) && param_03)
		{
			deletestructarray_ref(var_05);
		}

		var_06 = maps\_spawner::func_395B(var_05);
		var_04 = common_scripts\utility::array_combine(var_04,var_06);
	}

	return array_spawn(var_04,param_01,param_02);
}

//Function Number: 431
func_0F17(param_00,param_01,param_02,param_03)
{
	var_04 = getentarray(param_00,"script_noteworthy");
	if(isdefined(level.var_780E))
	{
		var_05 = common_scripts\utility::func_3C1A(param_00,"script_noteworthy");
		if(isdefined(param_03) && param_03)
		{
			deletestructarray_ref(var_05);
		}

		var_06 = maps\_spawner::func_395B(var_05);
		var_04 = common_scripts\utility::array_combine(var_04,var_06);
	}

	return array_spawn(var_04,param_01,param_02);
}

//Function Number: 432
func_781F(param_00,param_01)
{
	var_02 = getent(param_00,"script_noteworthy");
	var_03 = var_02 func_7766(param_01);
	return var_03;
}

//Function Number: 433
func_7839(param_00,param_01)
{
	var_02 = getent(param_00,"targetname");
	var_03 = var_02 func_7766(param_01);
	return var_03;
}

//Function Number: 434
add_dialogue_line(param_00,param_01,param_02)
{
	if(getdvarint("loc_warnings",0))
	{
	}

	if(!isdefined(level.var_2703))
	{
		level.var_2703 = [];
	}

	var_03 = 0;
	for(;;)
	{
		if(!isdefined(level.var_2703[var_03]))
		{
			break;
		}

		var_03++;
	}

	var_04 = "^3";
	if(isdefined(param_02))
	{
		switch(param_02)
		{
			case "red":
			case "r":
				var_04 = "^1";
				break;

			case "green":
			case "g":
				var_04 = "^2";
				break;

			case "yellow":
			case "y":
				var_04 = "^3";
				break;

			case "blue":
			case "b":
				var_04 = "^4";
				break;

			case "cyan":
			case "c":
				var_04 = "^5";
				break;

			case "purple":
			case "p":
				var_04 = "^6";
				break;

			case "white":
			case "w":
				var_04 = "^7";
				break;

			case "black":
			case "bl":
				var_04 = "^8";
				break;
		}
	}

	level.var_2703[var_03] = 1;
	var_05 = maps\_hud_util::createfontstring("default",1.5);
	var_05.location = 0;
	var_05.alignx = "left";
	var_05.aligny = "top";
	var_05.foreground = 1;
	var_05.sort = 20;
	var_05.alpha = 0;
	var_05 fadeovertime(0.5);
	var_05.alpha = 1;
	var_05.x = 40;
	var_05.y = 260 + var_03 * 18;
	var_05.label = " " + var_04 + "< " + param_00 + " > ^7" + param_01;
	var_05.color = (1,1,1);
	wait(2);
	var_06 = 40;
	var_05 fadeovertime(6);
	var_05.alpha = 0;
	for(var_07 = 0;var_07 < var_06;var_07++)
	{
		var_05.color = (1,1,0 / var_06 - var_07);
		wait(0.05);
	}

	wait(4);
	var_05 destroy();
	level.var_2703[var_03] = undefined;
}

//Function Number: 435
func_2671()
{
	common_scripts\_destructible::func_2766();
}

//Function Number: 436
func_2678()
{
	common_scripts\_destructible::func_34AF();
}

//Function Number: 437
set_grenadeammo(param_00)
{
	self.grenadeammo = param_00;
}

//Function Number: 438
get_player_feet_from_view()
{
	var_00 = self.origin;
	var_01 = anglestoup(self getplayerangles());
	var_02 = self getplayerviewheight();
	var_03 = var_00 + (0,0,var_02);
	var_04 = var_00 + var_01 * var_02;
	var_05 = var_03 - var_04;
	var_06 = var_00 + var_05;
	return var_06;
}

//Function Number: 439
func_6E52(param_00)
{
	self.baseaccuracy = param_00;
}

//Function Number: 440
set_console_status()
{
	if(!isdefined(level.console))
	{
		level.console = getdvar("consoleGame") == "true";
	}
	else
	{
	}

	if(!isdefined(level.xenon))
	{
		level.xenon = getdvar("xenonGame") == "true";
	}
	else
	{
	}

	if(!isdefined(level.ps3))
	{
		level.ps3 = getdvar("ps3Game") == "true";
	}
	else
	{
	}

	if(!isdefined(level.xb3))
	{
		level.xb3 = getdvar("xb3Game") == "true";
	}
	else
	{
	}

	if(!isdefined(level.ps4))
	{
		level.ps4 = getdvar("ps4Game") == "true";
	}
}

//Function Number: 441
func_47F6()
{
	if(level.xb3 || level.ps4 || !level.console)
	{
		return 1;
	}

	return 0;
}

//Function Number: 442
autosave_now(param_00)
{
	return maps\_autosave::_autosave_game_now(param_00);
}

//Function Number: 443
func_11BF()
{
	return maps\_autosave::_autosave_game_now(1);
}

//Function Number: 444
func_6EEC(param_00)
{
	self.deathanim = getgenericanim(param_00);
}

//Function Number: 445
func_6E7A(param_00)
{
	self.deathanim = func_3A1F(param_00);
}

//Function Number: 446
clear_deathanim()
{
	self.deathanim = undefined;
}

//Function Number: 447
hunted_style_door_open(param_00)
{
	wait(1.75);
	if(isdefined(param_00))
	{
		self playsound(param_00);
	}
	else
	{
		self playsound("door_wood_slow_open");
	}

	self rotateto(self.angles + (0,70,0),2,0.5,0);
	self connectpaths();
	self waittill("rotatedone");
	self rotateto(self.angles + (0,40,0),2,0,2);
}

//Function Number: 448
func_5AC4(param_00)
{
	wait(1.35);
	if(isdefined(param_00))
	{
		self playsound(param_00);
	}
	else
	{
		self playsound("door_wood_slow_open");
	}

	self rotateto(self.angles + (0,70,0),2,0.5,0);
	self connectpaths();
	self waittill("rotatedone");
	self rotateto(self.angles + (0,40,0),2,0,2);
}

//Function Number: 449
func_4D7C(param_00,param_01)
{
	foreach(var_03 in level.players)
	{
		var_03 lerpfov(param_01,param_00);
	}

	wait(param_00);
}

//Function Number: 450
lerp_fovscale_overtime(param_00,param_01)
{
	var_02 = getdvarfloat("cg_fovscale");
	var_03 = int(param_00 / 0.05);
	var_04 = param_01 - var_02 / var_03;
	var_05 = var_02;
	for(var_06 = 0;var_06 < var_03;var_06++)
	{
		var_05 = var_05 + var_04;
		setsaveddvar("cg_fovscale",var_05);
		wait(0.05);
	}

	setsaveddvar("cg_fovscale",param_01);
}

//Function Number: 451
func_6254()
{
	animscripts/shared::placeweaponon(self.weapon,"none");
	self.weapon = "none";
}

//Function Number: 452
apply_fog()
{
	maps\_art::func_6EDC(0);
}

//Function Number: 453
apply_end_fog()
{
	maps\_art::func_6EDC(1);
}

//Function Number: 454
anim_stopanimscripted()
{
	self stopanimscripted();
	self notify("stop_loop");
	self notify("single anim","end");
	self notify("looping anim","end");
}

//Function Number: 455
disable_pain()
{
	self.a.disablepain = 1;
	self.allowpain = 0;
}

//Function Number: 456
func_2CBF()
{
	self.a.disablepain = 0;
	self.allowpain = 1;
}

//Function Number: 457
func_4B09()
{
	if(isplayer(self))
	{
		if(common_scripts\utility::flag_exist("special_op_terminated") && common_scripts\utility::flag("special_op_terminated"))
		{
			return 0;
		}

		if(func_4825(self))
		{
			self disableinvulnerability();
		}
	}

	self enabledeathshield(0);
	self kill();
	return 1;
}

//Function Number: 458
disable_oneshotfx_with_noteworthy(param_00)
{
	var_01 = getarraykeys(level._global_fx_ents[param_00]);
	for(var_02 = 0;var_02 < var_01.size;var_02++)
	{
		level._global_fx_ents[param_00][var_01[var_02]].looper delete();
		level._global_fx_ents[param_00][var_01[var_02]] = undefined;
	}
}

//Function Number: 459
array_wait(param_00,param_01,param_02)
{
	var_03 = getarraykeys(param_00);
	var_04 = [];
	for(var_05 = 0;var_05 < var_03.size;var_05++)
	{
		var_06 = var_03[var_05];
	}

	for(var_05 = 0;var_05 < var_03.size;var_05++)
	{
		var_06 = var_03[var_05];
		var_04[var_06] = spawnstruct();
		var_04[var_06]._array_wait = 1;
		var_04[var_06] thread maps\_utility_code::func_F22(param_00[var_06],param_01,param_02);
	}

	for(var_05 = 0;var_05 < var_03.size;var_05++)
	{
		var_06 = var_03[var_05];
		if(isdefined(param_00[var_06]) && var_04[var_06]._array_wait)
		{
			var_04[var_06] waittill("_array_wait");
		}
	}
}

//Function Number: 460
func_2721()
{
	self kill((0,0,0));
}

//Function Number: 461
func_3B30(param_00)
{
	return level.var_6AF3[param_00];
}

//Function Number: 462
func_4864()
{
	return self playerads() > 0.5;
}

//Function Number: 463
func_277B()
{
	self.var_65C2 = undefined;
	self notify("_disable_reinforcement");
}

//Function Number: 464
func_8B87(param_00,param_01,param_02,param_03,param_04,param_05)
{
	if(!isdefined(param_05))
	{
		param_05 = level.player;
	}

	var_06 = spawnstruct();
	if(isdefined(param_03))
	{
		var_06 thread func_5704("timeout",param_03);
	}

	var_06 endon("timeout");
	if(!isdefined(param_00))
	{
		param_00 = 0.92;
	}

	if(!isdefined(param_01))
	{
		param_01 = 0;
	}

	var_07 = int(param_01 * 20);
	var_08 = var_07;
	self endon("death");
	var_09 = isai(self);
	var_0A = undefined;
	for(;;)
	{
		if(var_09)
		{
			var_0A = self geteye();
		}
		else
		{
			var_0A = self.origin;
		}

		if(param_05 func_5E89(var_0A,param_00,param_02,param_04))
		{
			var_08--;
			if(var_08 <= 0)
			{
				return 1;
			}
		}
		else
		{
			var_08 = var_07;
		}

		wait(0.05);
	}
}

//Function Number: 465
func_8B89(param_00,param_01,param_02,param_03)
{
	func_8B87(param_01,param_00,param_02,undefined,param_03);
}

//Function Number: 466
func_5E89(param_00,param_01,param_02,param_03)
{
	if(!isdefined(param_01))
	{
		param_01 = 0.8;
	}

	var_04 = func_3942();
	var_05 = var_04 geteye();
	var_06 = vectortoangles(param_00 - var_05);
	var_07 = anglestoforward(var_06);
	var_08 = var_04 getplayerangles();
	var_09 = anglestoforward(var_08);
	var_0A = vectordot(var_07,var_09);
	if(var_0A < param_01)
	{
		return 0;
	}

	if(isdefined(param_02))
	{
		return 1;
	}

	var_0B = bullettrace(param_00,var_05,0,param_03);
	return var_0B["fraction"] == 1;
}

//Function Number: 467
either_player_looking_at(param_00,param_01,param_02,param_03)
{
	for(var_04 = 0;var_04 < level.players.size;var_04++)
	{
		if(level.players[var_04] func_5E89(param_00,param_01,param_02,param_03))
		{
			return 1;
		}
	}

	return 0;
}

//Function Number: 468
func_5D97(param_00,param_01)
{
	var_02 = gettime();
	if(!isdefined(param_01))
	{
		param_01 = 0;
	}

	if(isdefined(param_00.var_5FD6) && param_00.var_5FD6 + param_01 >= var_02)
	{
		return param_00.playerseesme;
	}

	param_00.var_5FD6 = var_02;
	if(!common_scripts\utility::func_8E18(level.player.origin,level.player.angles,param_00.origin,0.766))
	{
		param_00.playerseesme = 0;
		return 0;
	}

	var_03 = level.player geteye();
	var_04 = param_00.origin;
	if(sighttracepassed(var_03,var_04,1,level.player,param_00))
	{
		param_00.playerseesme = 1;
		return 1;
	}

	var_05 = param_00 geteye();
	if(sighttracepassed(var_03,var_05,1,level.player,param_00))
	{
		param_00.playerseesme = 1;
		return 1;
	}

	var_06 = var_05 + var_04 * 0.5;
	if(sighttracepassed(var_03,var_06,1,level.player,param_00))
	{
		param_00.playerseesme = 1;
		return 1;
	}

	param_00.playerseesme = 0;
	return 0;
}

//Function Number: 469
func_5FD3(param_00,param_01)
{
	var_02 = param_00 * param_00;
	for(var_03 = 0;var_03 < level.players.size;var_03++)
	{
		if(distancesquared(param_01,level.players[var_03].origin) < var_02)
		{
			return 1;
		}
	}

	return 0;
}

//Function Number: 470
ai_delete_when_out_of_sight(param_00,param_01)
{
	if(!isdefined(param_00))
	{
	}

	var_02 = 0.75;
	if(issplitscreen())
	{
		var_02 = 0.65;
	}

	while(param_00.size > 0)
	{
		wait(1);
		for(var_03 = 0;var_03 < param_00.size;var_03++)
		{
			if(!isdefined(param_00[var_03]) || !isalive(param_00[var_03]))
			{
				param_00 = common_scripts\utility::array_remove(param_00,param_00[var_03]);
				continue;
			}

			if(func_5FD3(param_01,param_00[var_03].origin))
			{
				continue;
			}

			if(either_player_looking_at(param_00[var_03].origin + (0,0,48),var_02,1))
			{
				continue;
			}

			if(isdefined(param_00[var_03].magic_bullet_shield))
			{
				param_00[var_03] func_7C38();
			}

			param_00[var_03] delete();
			param_00 = common_scripts\utility::array_remove(param_00,param_00[var_03]);
		}
	}
}

//Function Number: 471
add_wait(param_00,param_01,param_02,param_03)
{
	var_04 = spawnstruct();
	var_04.caller = self;
	var_04.func = param_00;
	var_04.var_5AED = [];
	if(isdefined(param_01))
	{
		var_04.var_5AED[var_04.var_5AED.size] = param_01;
	}

	if(isdefined(param_02))
	{
		var_04.var_5AED[var_04.var_5AED.size] = param_02;
	}

	if(isdefined(param_03))
	{
		var_04.var_5AED[var_04.var_5AED.size] = param_03;
	}

	level.var_8A69[level.var_8A69.size] = var_04;
}

//Function Number: 472
add_abort(param_00,param_01,param_02,param_03)
{
	var_04 = spawnstruct();
	var_04.caller = self;
	var_04.func = param_00;
	var_04.var_5AED = [];
	if(isdefined(param_01))
	{
		var_04.var_5AED[var_04.var_5AED.size] = param_01;
	}

	if(isdefined(param_02))
	{
		var_04.var_5AED[var_04.var_5AED.size] = param_02;
	}

	if(isdefined(param_03))
	{
		var_04.var_5AED[var_04.var_5AED.size] = param_03;
	}

	level.var_7BD[level.var_7BD.size] = var_04;
}

//Function Number: 473
func_0895(param_00,param_01,param_02,param_03,param_04,param_05)
{
	var_06 = spawnstruct();
	var_06.caller = self;
	var_06.func = param_00;
	var_06.var_5AED = [];
	if(isdefined(param_01))
	{
		var_06.var_5AED[var_06.var_5AED.size] = param_01;
	}

	if(isdefined(param_02))
	{
		var_06.var_5AED[var_06.var_5AED.size] = param_02;
	}

	if(isdefined(param_03))
	{
		var_06.var_5AED[var_06.var_5AED.size] = param_03;
	}

	if(isdefined(param_04))
	{
		var_06.var_5AED[var_06.var_5AED.size] = param_04;
	}

	if(isdefined(param_05))
	{
		var_06.var_5AED[var_06.var_5AED.size] = param_05;
	}

	level.var_6952[level.var_6952.size] = var_06;
}

//Function Number: 474
add_call(param_00,param_01,param_02,param_03,param_04,param_05)
{
	var_06 = spawnstruct();
	var_06.caller = self;
	var_06.func = param_00;
	var_06.var_5AED = [];
	if(isdefined(param_01))
	{
		var_06.var_5AED[var_06.var_5AED.size] = param_01;
	}

	if(isdefined(param_02))
	{
		var_06.var_5AED[var_06.var_5AED.size] = param_02;
	}

	if(isdefined(param_03))
	{
		var_06.var_5AED[var_06.var_5AED.size] = param_03;
	}

	if(isdefined(param_04))
	{
		var_06.var_5AED[var_06.var_5AED.size] = param_04;
	}

	if(isdefined(param_05))
	{
		var_06.var_5AED[var_06.var_5AED.size] = param_05;
	}

	level.run_call_after_wait_array[level.run_call_after_wait_array.size] = var_06;
}

//Function Number: 475
add_noself_call(param_00,param_01,param_02,param_03,param_04,param_05)
{
	var_06 = spawnstruct();
	var_06.func = param_00;
	var_06.var_5AED = [];
	if(isdefined(param_01))
	{
		var_06.var_5AED[var_06.var_5AED.size] = param_01;
	}

	if(isdefined(param_02))
	{
		var_06.var_5AED[var_06.var_5AED.size] = param_02;
	}

	if(isdefined(param_03))
	{
		var_06.var_5AED[var_06.var_5AED.size] = param_03;
	}

	if(isdefined(param_04))
	{
		var_06.var_5AED[var_06.var_5AED.size] = param_04;
	}

	if(isdefined(param_05))
	{
		var_06.var_5AED[var_06.var_5AED.size] = param_05;
	}

	level.run_noself_call_after_wait_array[level.run_noself_call_after_wait_array.size] = var_06;
}

//Function Number: 476
add_endon(param_00)
{
	var_01 = spawnstruct();
	var_01.caller = self;
	var_01.var_2D50 = param_00;
	level.do_wait_endons_array[level.do_wait_endons_array.size] = var_01;
}

//Function Number: 477
func_2852()
{
	func_2851(level.var_8A69.size - 1);
}

//Function Number: 478
func_2851(param_00)
{
	if(!isdefined(param_00))
	{
		param_00 = 0;
	}

	var_01 = spawnstruct();
	var_02 = level.var_8A69;
	var_03 = level.do_wait_endons_array;
	var_04 = level.var_6952;
	var_05 = level.run_call_after_wait_array;
	var_06 = level.run_noself_call_after_wait_array;
	var_07 = level.var_7BD;
	level.var_8A69 = [];
	level.var_6952 = [];
	level.do_wait_endons_array = [];
	level.var_7BD = [];
	level.run_call_after_wait_array = [];
	level.run_noself_call_after_wait_array = [];
	var_01.count = var_02.size;
	var_01 common_scripts\utility::array_levelthread(var_02,::maps\_utility_code::func_8B63,var_03);
	var_01 thread maps\_utility_code::func_2818(var_07);
	var_01 endon("any_funcs_aborted");
	for(;;)
	{
		if(var_01.count <= param_00)
		{
			break;
		}

		var_01 waittill("func_ended");
	}

	var_01 notify("all_funcs_ended");
	common_scripts\utility::array_levelthread(var_04,::maps\_utility_code::func_3049,[]);
	common_scripts\utility::array_levelthread(var_05,::maps\_utility_code::func_3047);
	common_scripts\utility::array_levelthread(var_06,::maps\_utility_code::func_3048);
}

//Function Number: 479
do_funcs()
{
	var_00 = spawnstruct();
	var_01 = level.var_6952;
	level.var_6952 = [];
	foreach(var_03 in var_01)
	{
		level maps\_utility_code::func_3049(var_03,[]);
	}

	var_00 notify("all_funcs_ended");
}

//Function Number: 480
func_47DB()
{
	if(isdefined(level.forced_start_catchup) && level.forced_start_catchup == 1)
	{
		return 0;
	}

	if(isdefined(level.var_24AA) && level.var_24AA == level.start_point)
	{
		return 1;
	}

	if(isdefined(level.default_start))
	{
		return level.start_point == "default";
	}

	if(func_4DA7())
	{
		return level.start_point == level.var_7A3F[0]["name"];
	}

	return level.start_point == "default";
}

//Function Number: 481
func_34BE()
{
	level.forced_start_catchup = 1;
}

//Function Number: 482
func_47F2()
{
	if(!func_4DA7())
	{
		return 1;
	}

	return level.start_point == level.var_7A3F[0]["name"];
}

//Function Number: 483
func_47B6(param_00)
{
	var_01 = 0;
	if(level.start_point == param_00)
	{
		return 0;
	}

	for(var_02 = 0;var_02 < level.var_7A3F.size;var_02++)
	{
		if(level.var_7A3F[var_02]["name"] == param_00)
		{
			var_01 = 1;
			continue;
		}

		if(level.var_7A3F[var_02]["name"] == level.start_point)
		{
			return var_01;
		}
	}
}

//Function Number: 484
func_8D6E(param_00,param_01)
{
	self endon("death");
	var_02 = 0;
	if(isdefined(param_01))
	{
		var_02 = 1;
	}

	if(isdefined(param_00))
	{
		common_scripts\utility::func_337A(param_00);
		level endon(param_00);
	}

	for(;;)
	{
		wait(randomfloatrange(0.15,0.3));
		var_03 = self.origin + (0,0,150);
		var_04 = self.origin - (0,0,150);
		var_05 = bullettrace(var_03,var_04,0,undefined);
		if(var_05["surfacetype"] != "water")
		{
			continue;
		}

		var_06 = "water_movement";
		if(isplayer(self))
		{
			if(distance(self getvelocity(),(0,0,0)) < 5)
			{
				var_06 = "water_stop";
			}
		}
		else if(isdefined(level._effect["water_" + self.a.var_5486]))
		{
			var_06 = "water_" + self.a.var_5486;
		}

		var_07 = common_scripts\utility::func_3AB9(var_06);
		var_03 = var_05["position"];
		var_08 = (0,self.angles[1],0);
		var_09 = anglestoforward(var_08);
		var_0A = anglestoup(var_08);
		playfx(var_07,var_03,var_0A,var_09);
		if(var_06 != "water_stop" && var_02)
		{
			thread common_scripts\utility::func_5D1F(param_01,var_03);
		}
	}
}

//Function Number: 485
func_5FD8(param_00)
{
	if(isdefined(param_00))
	{
		common_scripts\utility::func_337A(param_00);
		level endon(param_00);
	}

	for(;;)
	{
		wait(randomfloatrange(0.25,0.5));
		var_01 = self.origin + (0,0,0);
		var_02 = self.origin - (0,0,5);
		var_03 = bullettrace(var_01,var_02,0,undefined);
		var_04 = anglestoforward(self.angles);
		var_05 = distance(self getvelocity(),(0,0,0));
		if(isdefined(self.vehicle))
		{
			continue;
		}

		if(var_03["surfacetype"] != "snow")
		{
			continue;
		}

		if(var_05 <= 10)
		{
			continue;
		}

		var_06 = "snow_movement";
		if(distance(self getvelocity(),(0,0,0)) <= 154)
		{
			playfx(common_scripts\utility::func_3AB9("footstep_snow_small"),var_03["position"],var_03["normal"],var_04);
		}

		if(distance(self getvelocity(),(0,0,0)) > 154)
		{
			playfx(common_scripts\utility::func_3AB9("footstep_snow"),var_03["position"],var_03["normal"],var_04);
		}
	}
}

//Function Number: 486
func_52FD(param_00)
{
	var_01 = 60;
	for(var_02 = 0;var_02 < var_01;var_02++)
	{
		self setsoundblend(param_00,param_00 + "_off",var_01 - var_02 / var_01);
		wait(0.05);
	}
}

//Function Number: 487
func_52FC(param_00)
{
	var_01 = 60;
	for(var_02 = 0;var_02 < var_01;var_02++)
	{
		self setsoundblend(param_00,param_00 + "_off",var_02 / var_01);
		wait(0.05);
	}
}

//Function Number: 488
func_508D(param_00,param_01)
{
	param_00 endon("death");
	self endon("death");
	if(!isdefined(param_01))
	{
		param_01 = (0,0,0);
	}

	for(;;)
	{
		self.origin = param_00.origin + param_01;
		self.angles = param_00.angles;
		wait(0.05);
	}
}

//Function Number: 489
func_55F6()
{
	maps\_utility_code::mission_recon();
	maps\_endmission::_nextmission();
}

//Function Number: 490
make_array(param_00,param_01,param_02,param_03,param_04)
{
	var_05 = [];
	var_05[var_05.size] = param_00;
	if(isdefined(param_01))
	{
		var_05[var_05.size] = param_01;
	}

	if(isdefined(param_02))
	{
		var_05[var_05.size] = param_02;
	}

	if(isdefined(param_03))
	{
		var_05[var_05.size] = param_03;
	}

	if(isdefined(param_04))
	{
		var_05[var_05.size] = param_04;
	}

	return var_05;
}

//Function Number: 491
func_315D()
{
	level.failonfriendlyfire = 1;
}

//Function Number: 492
func_5677()
{
	level.failonfriendlyfire = 0;
}

//Function Number: 493
getplayerclaymores()
{
	var_00 = self getweaponslistall();
	var_01 = [];
	for(var_02 = 0;var_02 < var_00.size;var_02++)
	{
		var_03 = var_00[var_02];
		var_01[var_03] = self getweaponammoclip(var_03);
	}

	var_04 = 0;
	if(isdefined(var_01["claymore"]) && var_01["claymore"] > 0)
	{
		var_04 = var_01["claymore"];
	}

	return var_04;
}

//Function Number: 494
func_0737(param_00)
{
	wait(param_00);
}

//Function Number: 495
func_4D8F(param_00,param_01,param_02)
{
	var_03 = getdvarfloat(param_00);
	level notify(param_00 + "_lerp_savedDvar");
	level endon(param_00 + "_lerp_savedDvar");
	var_04 = param_01 - var_03;
	var_05 = 0.05;
	var_06 = int(param_02 / var_05);
	var_07 = var_04 / var_06;
	while(var_06)
	{
		var_03 = var_03 + var_07;
		setsaveddvar(param_00,var_03);
		wait(var_05);
		var_06--;
	}

	setsaveddvar(param_00,param_01);
}

//Function Number: 496
lerp_saveddvar_cg_ng(param_00,param_01,param_02,param_03)
{
	if(func_47F6())
	{
		func_4D8F(param_00,param_02,param_03);
	}

	func_4D8F(param_00,param_01,param_03);
}

//Function Number: 497
func_3CDA(param_00)
{
	if(func_47DC())
	{
	}

	foreach(var_02 in level.players)
	{
		var_02 giveachievement(param_00);
	}
}

//Function Number: 498
func_5E13(param_00)
{
	if(func_47DC())
	{
	}

	self giveachievement(param_00);
}

//Function Number: 499
add_jav_glow(param_00)
{
	var_01 = spawn("script_model",(0,0,0));
	var_01 setcontents(0);
	var_01 setmodel("weapon_javelin_obj");
	var_01.origin = self.origin;
	var_01.angles = self.angles;
	add_wait(::func_256C);
	if(isdefined(param_00))
	{
		common_scripts\utility::func_337A(param_00);
		add_wait(::common_scripts\utility::flag_wait,param_00);
	}

	func_2852();
	var_01 delete();
}

//Function Number: 500
add_c4_glow(param_00)
{
	var_01 = spawn("script_model",(0,0,0));
	var_01 setcontents(0);
	var_01 setmodel("weapon_c4_obj");
	var_01.origin = self.origin;
	var_01.angles = self.angles;
	add_wait(::func_256C);
	if(isdefined(param_00))
	{
		common_scripts\utility::func_337A(param_00);
		add_wait(::common_scripts\utility::flag_wait,param_00);
	}

	func_2852();
	var_01 delete();
}

//Function Number: 501
func_256C()
{
	for(;;)
	{
		if(!isdefined(self))
		{
		}

		wait(0.05);
	}
}

//Function Number: 502
func_761B()
{
}

//Function Number: 503
func_7613()
{
}

//Function Number: 504
func_761A(param_00)
{
	level.var_7609.var_7901 = param_00;
}

//Function Number: 505
func_7619(param_00)
{
	level.var_7609.var_7900 = param_00;
}

//Function Number: 506
func_7617(param_00)
{
	level.var_7609.var_4D93 = param_00;
}

//Function Number: 507
func_7618(param_00)
{
	level.var_7609.var_4D94 = param_00;
}

//Function Number: 508
slowmo_lerp_in()
{
	if(isdefined(level.var_5630) && level.var_5630)
	{
	}

	setslowmotion(level.var_7609.var_7900,level.var_7609.var_7901,level.var_7609.var_4D93);
}

//Function Number: 509
func_7615()
{
	if(isdefined(level.var_5630) && level.var_5630)
	{
	}

	setslowmotion(level.var_7609.var_7901,level.var_7609.var_7900,level.var_7609.var_4D94);
}

//Function Number: 510
add_earthquake(param_00,param_01,param_02,param_03)
{
	level.earthquake[param_00]["magnitude"] = param_01;
	level.earthquake[param_00]["duration"] = param_02;
	level.earthquake[param_00]["radius"] = param_03;
}

//Function Number: 511
func_0EBE()
{
	return getdvar("arcademode") == "1";
}

//Function Number: 512
arcademode_stop_timer()
{
	if(!isdefined(level.arcademode_hud_timer))
	{
	}

	level notify("arcadeMode_remove_timer");
	level.arcademode_stoptime = gettime();
	level.arcademode_hud_timer destroy();
	level.arcademode_hud_timer = undefined;
}

//Function Number: 513
func_5545(param_00,param_01,param_02)
{
	level._audio.var_4C24 = param_00;
	if(!isdefined(param_01))
	{
		param_01 = 1;
	}

	if(!isdefined(param_02))
	{
		param_02 = 0;
	}

	musicstop(0);
	musicplay(param_00,0,1,1,param_02);
}

//Function Number: 514
func_5534(param_00,param_01,param_02,param_03,param_04)
{
	thread maps\_utility_code::func_5535(param_00,param_01,param_02,param_03,param_04);
}

//Function Number: 515
music_loop_stealth(param_00,param_01,param_02,param_03,param_04)
{
	thread maps\_utility_code::func_5535(param_00,param_01,param_02,param_03,param_04,1);
}

//Function Number: 516
music_play(param_00,param_01,param_02,param_03)
{
	if(isdefined(param_01) && param_01 > 0)
	{
		thread maps\_utility_code::func_553B(param_00,param_01,param_02,param_03);
	}

	func_5541();
	func_5545(param_00,param_02,param_03);
}

//Function Number: 517
func_5530(param_00,param_01,param_02,param_03)
{
	if(!isdefined(param_02))
	{
		param_02 = 1;
	}

	if(!isdefined(param_03))
	{
		param_03 = 0;
	}

	if(isdefined(level._audio.var_4C24))
	{
		musicstop(param_01,level._audio.var_4C24,param_03);
	}
	else
	{
		iprintln("^3WARNING!  script music_crossfade(): No previous song was played - no previous song to crossfade from - not fading out anything");
	}

	level._audio.var_4C24 = param_00;
	musicplay(param_00,param_01,param_02,0,param_03);
	level endon("stop_music");
	wait(param_01);
	level notify("done_crossfading");
}

//Function Number: 518
func_5541(param_00)
{
	if(!isdefined(param_00) || param_00 <= 0)
	{
		musicstop();
	}
	else
	{
		musicstop(param_00);
	}

	level notify("stop_music");
}

//Function Number: 519
func_5E65()
{
	var_00 = getentarray("grenade","classname");
	for(var_01 = 0;var_01 < var_00.size;var_01++)
	{
		var_02 = var_00[var_01];
		if(var_02.model == "weapon_claymore")
		{
			continue;
		}

		for(var_03 = 0;var_03 < level.players.size;var_03++)
		{
			var_04 = level.players[var_03];
			if(distancesquared(var_02.origin,var_04.origin) < 75625)
			{
				return 1;
			}
		}
	}

	return 0;
}

//Function Number: 520
player_died_recently()
{
	return getdvarint("player_died_recently","0") > 0;
}

//Function Number: 521
all_players_istouching(param_00)
{
	foreach(var_02 in level.players)
	{
		if(!var_02 istouching(param_00))
		{
			return 0;
		}
	}

	return 1;
}

//Function Number: 522
any_players_istouching(param_00)
{
	foreach(var_02 in level.players)
	{
		if(var_02 istouching(param_00))
		{
			return 1;
		}
	}

	return 0;
}

//Function Number: 523
func_3A7F()
{
	if(level.gameskill < 1)
	{
		return "easy";
	}

	if(level.gameskill < 2)
	{
		return "medium";
	}

	if(level.gameskill < 3)
	{
		return "hard";
	}

	return "fu";
}

//Function Number: 524
getaverageplayerorigin()
{
	var_00 = 0;
	var_01 = 0;
	var_02 = 0;
	foreach(var_04 in level.players)
	{
		var_00 = var_00 + var_04.origin[0];
		var_01 = var_01 + var_04.origin[1];
		var_02 = var_02 + var_04.origin[2];
	}

	var_00 = var_00 / level.players.size;
	var_01 = var_01 / level.players.size;
	var_02 = var_02 / level.players.size;
	return (var_00,var_01,var_02);
}

//Function Number: 525
func_37E1(param_00)
{
	var_01 = (0,0,0);
	foreach(var_03 in param_00)
	{
		var_01 = var_01 + var_03.origin;
	}

	return var_01 * 1 / param_00.size;
}

//Function Number: 526
func_3786()
{
	self.damage_functions = [];
	self endon("entitydeleted");
	self endon("stop_generic_damage_think");
	for(;;)
	{
		self waittill("damage",var_00,var_01,var_02,var_03,var_04,var_05,var_06);
		foreach(var_08 in self.damage_functions)
		{
			thread [[ var_08 ]](var_00,var_01,var_02,var_03,var_04,var_05,var_06);
		}
	}
}

//Function Number: 527
add_damage_function(param_00)
{
	self.damage_functions[self.damage_functions.size] = param_00;
}

//Function Number: 528
func_6518(param_00)
{
	var_01 = [];
	foreach(var_03 in self.damage_functions)
	{
		if(var_03 == param_00)
		{
			continue;
		}

		var_01[var_01.size] = var_03;
	}

	self.damage_functions = var_01;
}

//Function Number: 529
func_3D19(param_00,param_01)
{
	if(isdefined(level.var_8E6B) && level.var_8E6B && isdefined(level.var_8E6C))
	{
		self [[ level.var_8E6C ]](param_00,param_01);
	}
}

//Function Number: 530
func_6023(param_00)
{
	self playlocalsound(param_00);
}

//Function Number: 531
enableplayerweapons(param_00)
{
	if(level.players.size < 1)
	{
	}

	foreach(var_02 in level.players)
	{
		if(param_00 == 1)
		{
			var_02 enableweapons();
			continue;
		}

		var_02 disableweapons();
	}
}

//Function Number: 532
func_7FFF(param_00)
{
	var_01 = undefined;
	var_02 = undefined;
	var_03 = undefined;
	foreach(var_05 in param_00)
	{
		if(isdefined(var_05.script_noteworthy) && var_05.script_noteworthy == "player1")
		{
			var_01 = var_05;
			continue;
		}

		if(isdefined(var_05.script_noteworthy) && var_05.script_noteworthy == "player2")
		{
			var_02 = var_05;
			continue;
		}

		if(!isdefined(var_01))
		{
			var_01 = var_05;
		}

		if(!isdefined(var_02))
		{
			var_02 = var_05;
		}
	}

	foreach(var_08 in level.players)
	{
		if(var_08 == level.player)
		{
			var_03 = var_01;
		}
		else if(var_08 == level.var_5D60)
		{
			var_03 = var_02;
		}

		var_08 setorigin(var_03.origin);
		var_08 setplayerangles(var_03.angles);
	}
}

//Function Number: 533
func_7FFD(param_00)
{
	level.player setorigin(param_00.origin);
	if(isdefined(param_00.angles))
	{
		level.player setplayerangles(param_00.angles);
	}
}

//Function Number: 534
func_8275()
{
	var_00 = [];
	if(isdefined(self.var_2F69))
	{
		var_00 = self.var_2F69;
	}

	if(isdefined(self.entity))
	{
		var_00[var_00.size] = self.entity;
	}

	common_scripts\utility::array_levelthread(var_00,::maps\_utility_code::func_8276);
}

//Function Number: 535
func_59A3(param_00,param_01,param_02,param_03,param_04,param_05,param_06)
{
	level.player endon("stop_opening_fov");
	wait(param_00);
	level.player playerlinktodelta(param_01,param_02,1,param_03,param_04,param_05,param_06,1);
}

//Function Number: 536
get_ai_touching_volume(param_00,param_01,param_02)
{
	if(!isdefined(param_00))
	{
		param_00 = "all";
	}

	if(!isdefined(param_01))
	{
		param_01 = "all";
	}

	var_03 = getaispeciesarray(param_00,param_01);
	var_04 = [];
	foreach(var_06 in var_03)
	{
		if(var_06 istouching(self))
		{
			var_04[var_04.size] = var_06;
		}
	}

	return var_04;
}

//Function Number: 537
get_drones_touching_volume(param_00)
{
	if(!isdefined(param_00))
	{
		param_00 = "all";
	}

	var_01 = [];
	if(param_00 == "all")
	{
		var_01 = func_0EF4(level.var_2B22["allies"].var_ED8,level.var_2B22["axis"].var_ED8);
		var_01 = func_0EF4(var_01,level.var_2B22["neutral"].var_ED8);
	}
	else
	{
		var_01 = level.var_2B22[param_00].var_ED8;
	}

	var_02 = [];
	foreach(var_04 in var_01)
	{
		if(!isdefined(var_04))
		{
			continue;
		}

		if(var_04 istouching(self))
		{
			var_02[var_02.size] = var_04;
		}
	}

	return var_02;
}

//Function Number: 538
get_drones_with_targetname(param_00)
{
	var_01 = func_0EF4(level.var_2B22["allies"].var_ED8,level.var_2B22["axis"].var_ED8);
	var_01 = func_0EF4(var_01,level.var_2B22["neutral"].var_ED8);
	var_02 = [];
	foreach(var_04 in var_01)
	{
		if(!isdefined(var_04))
		{
			continue;
		}

		if(isdefined(var_04.targetname) && var_04.targetname == param_00)
		{
			var_02[var_02.size] = var_04;
		}
	}

	return var_02;
}

//Function Number: 539
func_3922(param_00)
{
	foreach(var_02 in level.players)
	{
		if(param_00 == var_02)
		{
			continue;
		}

		return var_02;
	}
}

//Function Number: 540
func_6E67(param_00)
{
	self.count = param_00;
}

//Function Number: 541
follow_path(param_00,param_01,param_02,param_03)
{
	self notify("_utility::follow_path");
	self endon("_utility::follow_path");
	self endon("death");
	var_04 = undefined;
	if(!isdefined(param_00.classname))
	{
		if(!isdefined(param_00.type))
		{
			var_04 = "struct";
		}
		else
		{
			var_04 = "node";
		}
	}
	else
	{
		var_04 = "entity";
	}

	if(!isdefined(param_01))
	{
		param_01 = 300;
	}

	var_05 = self.var_6BD2;
	self.var_6BD2 = 1;
	maps\_spawner::go_to_node(param_00,var_04,param_02,param_01,param_03);
	self.var_6BD2 = var_05;
}

//Function Number: 542
func_2CAE(param_00,param_01,param_02,param_03,param_04,param_05)
{
	if(!isdefined(param_00))
	{
		param_00 = 250;
	}

	if(!isdefined(param_01))
	{
		param_01 = 100;
	}

	if(!isdefined(param_02))
	{
		param_02 = param_00 * 2;
	}

	if(!isdefined(param_03))
	{
		param_03 = param_00 * 1.25;
	}

	if(!isdefined(param_05))
	{
		param_05 = 0;
	}

	self.dontchangemoveplaybackrate = param_05;
	thread maps\_utility_code::func_2BB1(param_00,param_01,param_02,param_03,param_04);
}

//Function Number: 543
disable_dynamic_run_speed()
{
	self notify("stop_dynamic_run_speed");
}

//Function Number: 544
func_5EFD()
{
	self endon("death");
	self endon("stop_player_seek");
	var_00 = 1200;
	if(func_3FEE())
	{
		var_00 = 250;
	}

	var_01 = distance(self.origin,level.player.origin);
	for(;;)
	{
		wait(2);
		self.goalradius = var_01;
		var_02 = func_3811(self.origin);
		self setgoalentity(var_02);
		var_01 = var_01 - 175;
		if(var_01 < var_00)
		{
			var_01 = var_00;
		}
	}
}

//Function Number: 545
player_seek_disable()
{
	self notify("stop_player_seek");
}

//Function Number: 546
func_8B5B(param_00,param_01,param_02)
{
	self endon("death");
	param_00 endon("death");
	if(!isdefined(param_02))
	{
		param_02 = 5;
	}

	var_03 = gettime() + param_02 * 1000;
	while(isdefined(param_00))
	{
		if(distance(param_00.origin,self.origin) <= param_01)
		{
			break;
		}

		if(gettime() > var_03)
		{
			break;
		}

		wait(0.1);
	}
}

//Function Number: 547
waittill_entity_in_range(param_00,param_01)
{
	self endon("death");
	param_00 endon("death");
	while(isdefined(param_00))
	{
		if(distance(param_00.origin,self.origin) <= param_01)
		{
			break;
		}

		wait(0.1);
	}
}

//Function Number: 548
func_8B5C(param_00,param_01)
{
	self endon("death");
	param_00 endon("death");
	while(isdefined(param_00))
	{
		if(distance(param_00.origin,self.origin) > param_01)
		{
			break;
		}

		wait(0.1);
	}
}

//Function Number: 549
func_3FEE()
{
	self endon("death");
	if(!isdefined(self.weapon))
	{
		return 0;
	}

	if(weaponclass(self.weapon) == "spread")
	{
		return 1;
	}

	return 0;
}

//Function Number: 550
isprimaryweapon(param_00)
{
	if(param_00 == "none")
	{
		return 0;
	}

	if(weaponinventorytype(param_00) != "primary")
	{
		return 0;
	}

	switch(weaponclass(param_00))
	{
		case "rifle":
		case "sniper":
		case "smg":
		case "spread":
		case "rocketlauncher":
		case "pistol":
		case "mg":
			return 1;

		default:
			return 0;
	}
}

//Function Number: 551
func_5E26()
{
	var_00 = self getweaponslistall();
	if(!isdefined(var_00))
	{
		return 0;
	}

	foreach(var_02 in var_00)
	{
		if(issubstr(var_02,"thermal"))
		{
			return 1;
		}
	}

	return 0;
}

//Function Number: 552
func_8BA9(param_00,param_01)
{
	self endon("death");
	if(!isdefined(param_01))
	{
		param_01 = self.goalradius;
	}

	for(;;)
	{
		self waittill("goal");
		if(distance(self.origin,param_00) < param_01 + 10)
		{
			break;
		}
	}
}

//Function Number: 553
func_5F1D(param_00,param_01)
{
	var_02 = int(getdvar("g_speed"));
	if(!isdefined(level.player.g_speed))
	{
		level.player.g_speed = var_02;
	}

	var_03 = int(level.player.g_speed * param_00 * 0.01);
	level.player func_5F20(var_03,param_01);
}

//Function Number: 554
blend_movespeedscale_percent(param_00,param_01)
{
	var_02 = self;
	if(!isplayer(var_02))
	{
		var_02 = level.player;
	}

	if(!isdefined(var_02.movespeedscale))
	{
		var_02.movespeedscale = 1;
	}

	var_03 = param_00 * 0.01;
	var_02 blend_movespeedscale(var_03,param_01);
}

//Function Number: 555
func_5F20(param_00,param_01)
{
	var_02 = int(getdvar("g_speed"));
	if(!isdefined(level.player.g_speed))
	{
		level.player.g_speed = var_02;
	}

	var_03 = ::maps\_utility_code::g_speed_get_func;
	var_04 = ::maps\_utility_code::g_speed_set_func;
	level.player thread func_5F1E(param_00,param_01,var_03,var_04,"player_speed_set");
}

//Function Number: 556
func_5D87(param_00,param_01)
{
	var_02 = ::maps\_utility_code::g_bob_scale_get_func;
	var_03 = ::maps\_utility_code::g_bob_scale_set_func;
	level.player thread func_5F1E(param_00,param_01,var_02,var_03,"player_bob_scale_set");
}

//Function Number: 557
blend_movespeedscale(param_00,param_01)
{
	var_02 = self;
	if(!isplayer(var_02))
	{
		var_02 = level.player;
	}

	if(!isdefined(var_02.movespeedscale))
	{
		var_02.movespeedscale = 1;
	}

	var_03 = ::maps\_utility_code::func_549E;
	var_04 = ::maps\_utility_code::func_54A1;
	var_02 thread func_5F1E(param_00,param_01,var_03,var_04,"blend_movespeedscale");
}

//Function Number: 558
func_5F1E(param_00,param_01,param_02,param_03,param_04)
{
	self notify(param_04);
	self endon(param_04);
	var_05 = [[ param_02 ]]();
	var_06 = param_00;
	if(isdefined(param_01))
	{
		var_07 = var_06 - var_05;
		var_08 = 0.05;
		var_09 = param_01 / var_08;
		var_0A = var_07 / var_09;
		while(abs(var_06 - var_05) > abs(var_0A * 1.1))
		{
			var_05 = var_05 + var_0A;
			[[ param_03 ]](var_05);
			wait(var_08);
		}
	}

	[[ param_03 ]](var_06);
}

//Function Number: 559
func_5F1B(param_00)
{
	if(!isdefined(level.player.g_speed))
	{
	}

	level.player func_5F20(level.player.g_speed,param_00);
	waittillframeend;
	level.player.g_speed = undefined;
}

//Function Number: 560
blend_movespeedscale_default(param_00)
{
	var_01 = self;
	if(!isplayer(var_01))
	{
		var_01 = level.player;
	}

	if(!isdefined(var_01.movespeedscale))
	{
	}

	var_01 blend_movespeedscale(1,param_00);
	waittillframeend;
	var_01.movespeedscale = undefined;
}

//Function Number: 561
func_7FD6(param_00)
{
	if(isplayer(self))
	{
		self setorigin(param_00.origin);
		self setplayerangles(param_00.angles);
	}

	self forceteleport(param_00.origin,param_00.angles);
}

//Function Number: 562
func_8011(param_00,param_01)
{
	var_02 = param_00 gettagorigin(param_01);
	var_03 = param_00 gettagangles(param_01);
	self dontinterpolate();
	if(isplayer(self))
	{
		self setorigin(var_02);
		self setplayerangles(var_03);
	}

	if(isai(self))
	{
		self forceteleport(var_02,var_03);
	}

	self.origin = var_02;
	self.angles = var_03;
}

//Function Number: 563
func_7FC7(param_00)
{
	self forceteleport(param_00.origin,param_00.angles);
	self setgoalpos(self.origin);
	self setgoalnode(param_00);
}

//Function Number: 564
move_all_fx(param_00)
{
	foreach(var_02 in level.createfxent)
	{
		var_02.var_880E["origin"] = var_02.var_880E["origin"] + param_00;
	}
}

//Function Number: 565
issliding()
{
	return isdefined(self.var_75E8);
}

//Function Number: 566
func_13F9(param_00,param_01,param_02)
{
	var_03 = self;
	var_03 thread func_5D23("foot_slide_plr_start");
	var_03 thread func_5CF5("foot_slide_plr_loop");
	var_04 = isdefined(level.var_2231);
	if(!isdefined(param_00))
	{
		param_00 = var_03 getvelocity() + (0,0,-10);
	}

	if(!isdefined(param_01))
	{
		param_01 = 10;
	}

	if(!isdefined(param_02))
	{
		param_02 = 0.035;
	}

	var_05 = spawn("script_origin",var_03.origin);
	var_05.angles = var_03.angles;
	var_03.var_75E8 = var_05;
	var_05 moveslide((0,0,15),15,param_00);
	if(var_04)
	{
		var_03 playerlinktoblend(var_05,undefined,1);
	}
	else
	{
		var_03 playerlinkto(var_05);
	}

	var_03 disableweapons();
	var_03 allowprone(0);
	var_03 allowcrouch(1);
	var_03 allowstand(0);
	var_03 thread maps\_utility_code::func_2A0D(var_05,param_01,param_02);
}

//Function Number: 567
endsliding()
{
	var_00 = self;
	var_00 notify("stop soundfoot_slide_plr_loop");
	var_00 thread func_5D23("foot_slide_plr_end");
	var_00 unlink();
	var_00 setvelocity(var_00.var_75E8.slidevelocity);
	var_00.var_75E8 delete();
	var_00 enableweapons();
	var_00 allowprone(1);
	var_00 allowcrouch(1);
	var_00 allowstand(1);
	var_00 notify("stop_sliding");
}

//Function Number: 568
func_784B()
{
	return maps\_vehicle::func_8927(self);
}

//Function Number: 569
getentwithflag(param_00)
{
	var_01 = maps\_trigger::get_load_trigger_classes();
	var_02 = [];
	foreach(var_06, var_04 in var_01)
	{
		if(!issubstr(var_06,"flag"))
		{
			continue;
		}

		var_05 = getentarray(var_06,"classname");
		var_02 = common_scripts\utility::array_combine(var_02,var_05);
	}

	var_07 = maps\_trigger::get_load_trigger_funcs();
	foreach(var_09, var_04 in var_07)
	{
		if(!issubstr(var_09,"flag"))
		{
			continue;
		}

		var_05 = getentarray(var_09,"targetname");
		var_02 = common_scripts\utility::array_combine(var_02,var_05);
	}

	var_0A = undefined;
	foreach(var_0C in var_02)
	{
		if(var_0C.script_flag == param_00)
		{
			return var_0C;
		}
	}
}

//Function Number: 570
getentarraywithflag(param_00)
{
	var_01 = maps\_trigger::get_load_trigger_classes();
	var_02 = [];
	foreach(var_06, var_04 in var_01)
	{
		if(!issubstr(var_06,"flag"))
		{
			continue;
		}

		var_05 = getentarray(var_06,"classname");
		var_02 = common_scripts\utility::array_combine(var_02,var_05);
	}

	var_07 = maps\_trigger::get_load_trigger_funcs();
	foreach(var_09, var_04 in var_07)
	{
		if(!issubstr(var_09,"flag"))
		{
			continue;
		}

		var_05 = getentarray(var_09,"targetname");
		var_02 = common_scripts\utility::array_combine(var_02,var_05);
	}

	var_0A = [];
	foreach(var_0C in var_02)
	{
		if(var_0C.script_flag == param_00)
		{
			var_0A[var_0A.size] = var_0C;
		}
	}

	return var_0A;
}

//Function Number: 571
set_z(param_00,param_01)
{
	return (param_00[0],param_00[1],param_01);
}

//Function Number: 572
add_z(param_00,param_01)
{
	return (param_00[0],param_00[1],param_00[2] + param_01);
}

//Function Number: 573
func_6FCE(param_00,param_01)
{
	return (param_00[0],param_01,param_00[2]);
}

//Function Number: 574
func_6FCD(param_00,param_01)
{
	return (param_01,param_00[1],param_00[2]);
}

//Function Number: 575
player_using_missile()
{
	var_00 = self getcurrentweapon();
	if(!isdefined(var_00))
	{
		return 0;
	}

	if(issubstr(tolower(var_00),"rpg"))
	{
		return 1;
	}

	if(issubstr(tolower(var_00),"stinger"))
	{
		return 1;
	}

	if(issubstr(tolower(var_00),"at4"))
	{
		return 1;
	}

	if(issubstr(tolower(var_00),"javelin"))
	{
		return 1;
	}

	return 0;
}

//Function Number: 576
doinglongdeath()
{
	return isdefined(self.a.doinglongdeath);
}

//Function Number: 577
get_rumble_ent(param_00)
{
	if(func_47D0())
	{
	}

	var_01 = func_3942();
	if(!isdefined(param_00))
	{
		param_00 = "steady_rumble";
	}

	var_02 = spawn("script_origin",var_01 geteye());
	var_02.intensity = 1;
	var_02 thread maps\_utility_code::func_86A5(var_01,param_00);
	return var_02;
}

//Function Number: 578
func_6F88(param_00)
{
	self.intensity = param_00;
}

//Function Number: 579
rumble_ramp_on(param_00)
{
	thread func_692B(1,param_00);
}

//Function Number: 580
func_6929(param_00)
{
	thread func_692B(0,param_00);
}

//Function Number: 581
func_692B(param_00,param_01)
{
	self notify("new_ramp");
	self endon("new_ramp");
	self endon("death");
	var_02 = param_01 * 20;
	var_03 = param_00 - self.intensity;
	var_04 = var_03 / var_02;
	for(var_05 = 0;var_05 < var_02;var_05++)
	{
		self.intensity = self.intensity + var_04;
		wait(0.05);
	}

	self.intensity = param_00;
}

//Function Number: 582
func_3942()
{
	if(isdefined(self))
	{
		if(!func_4803(level.players,self))
		{
			return level.player;
		}

		return self;
	}

	return level.player;
}

//Function Number: 583
get_player_gameskill()
{
	return int(self getplayersetting("gameskill"));
}

//Function Number: 584
glow(param_00)
{
	if(isdefined(self.var_566B))
	{
	}

	self.var_566B = self.model;
	if(!isdefined(param_00))
	{
		param_00 = self.model + "_obj";
	}

	self setmodel(param_00);
}

//Function Number: 585
func_7C60(param_00)
{
	if(!isdefined(self.var_566B))
	{
	}

	self setmodel(self.var_566B);
	self.var_566B = undefined;
}

//Function Number: 586
array_delete_evenly(param_00,param_01,param_02)
{
	var_03 = [];
	param_01 = param_02 - param_01;
	foreach(var_05 in param_00)
	{
		var_03[var_03.size] = var_05;
		if(var_03.size == param_02)
		{
			var_03 = common_scripts\utility::array_randomize(var_03);
			for(var_06 = param_01;var_06 < var_03.size;var_06++)
			{
				var_03[var_06] delete();
			}

			var_03 = [];
		}
	}

	var_08 = [];
	foreach(var_05 in param_00)
	{
		if(!isdefined(var_05))
		{
			continue;
		}

		var_08[var_08.size] = var_05;
	}

	return var_08;
}

//Function Number: 587
func_8B69(param_00,param_01,param_02)
{
	if(!isdefined(param_02))
	{
		param_02 = 0.5;
	}

	self endon("death");
	while(isdefined(self))
	{
		if(distance(param_00,self.origin) <= param_01)
		{
			break;
		}

		wait(param_02);
	}
}

//Function Number: 588
add_trace_fx(param_00)
{
	var_01 = spawnstruct();
	var_01 thread maps\_utility_code::add_trace_fx_proc(param_00);
	return var_01;
}

//Function Number: 589
func_81E0(param_00,param_01,param_02)
{
	var_03 = self gettagorigin(param_01);
	var_04 = self gettagangles(param_01);
	func_81DF(param_00,var_03,var_04,param_02);
}

//Function Number: 590
func_81DF(param_00,param_01,param_02,param_03)
{
	var_04 = anglestoforward(param_02);
	var_05 = bullettrace(param_01,param_01 + var_04 * param_03,0,undefined);
	if(var_05["fraction"] >= 1)
	{
	}

	var_06 = var_05["surfacetype"];
	if(!isdefined(level.var_81DA[param_00][var_06]))
	{
		var_06 = "default";
	}

	var_07 = level.var_81DA[param_00][var_06];
	if(isdefined(var_07["fx"]))
	{
		playfx(var_07["fx"],var_05["position"],var_05["normal"]);
	}

	if(isdefined(var_07["fx_array"]))
	{
		foreach(var_09 in var_07["fx_array"])
		{
			playfx(var_09,var_05["position"],var_05["normal"]);
		}
	}

	if(isdefined(var_07["sound"]))
	{
		level thread common_scripts\utility::func_5D1F(var_07["sound"],var_05["position"]);
	}

	if(isdefined(var_07["rumble"]))
	{
		var_0B = func_3942();
		var_0B playrumbleonentity(var_07["rumble"]);
	}
}

//Function Number: 591
func_2788()
{
	self.newenemyreactiondistsq = 0;
}

//Function Number: 592
enable_surprise()
{
	self.newenemyreactiondistsq = squared(512);
}

//Function Number: 593
func_2CB6(param_00)
{
	self.heat = 1;
	self.var_562A = 1;
	self.usecombatscriptatcover = 1;
	if(!isdefined(param_00) || !param_00)
	{
		self.dontshootwhilemoving = 1;
		self.maxfaceenemydist = 64;
		self.pathenemylookahead = 2048;
		func_2788();
	}

	self.specialreloadanimfunc = ::animscripts/animset::func_4067;
	self.custommoveanimset["run"] = animscripts/utility::func_4F5D("heat_run");
}

//Function Number: 594
disable_heat_behavior()
{
	self.heat = undefined;
	self.var_562A = undefined;
	self.dontshootwhilemoving = undefined;
	self.usecombatscriptatcover = 0;
	self.maxfaceenemydist = 512;
	self.specialreloadanimfunc = undefined;
	self.custommoveanimset = undefined;
}

//Function Number: 595
func_3C67()
{
	return vehicle_getarray();
}

//Function Number: 596
func_422F(param_00,param_01,param_02)
{
	if(!isdefined(param_02))
	{
		param_02 = 0;
	}

	var_03 = 0.5;
	level endon("clearing_hints");
	if(isdefined(level.var_425C))
	{
		level.var_425C maps\_hud_util::destroyelem();
	}

	level.var_425C = maps\_hud_util::createfontstring("default",1.5);
	level.var_425C maps\_hud_util::func_70A4("MIDDLE",undefined,0,30 + param_02);
	level.var_425C.color = (1,1,1);
	level.var_425C settext(param_00);
	level.var_425C.alpha = 0;
	level.var_425C fadeovertime(0.5);
	level.var_425C.alpha = 1;
	wait(0.5);
	level.var_425C endon("death");
	if(isdefined(param_01))
	{
		wait(param_01);
	}
	else
	{
	}

	level.var_425C fadeovertime(var_03);
	level.var_425C.alpha = 0;
	wait(var_03);
	level.var_425C maps\_hud_util::destroyelem();
}

//Function Number: 597
func_423F()
{
	var_00 = 1;
	if(isdefined(level.var_425C))
	{
		level notify("clearing_hints");
		level.var_425C fadeovertime(var_00);
		level.var_425C.alpha = 0;
		wait(var_00);
	}
}

//Function Number: 598
kill_deathflag(param_00,param_01)
{
	if(!isdefined(level.flag[param_00]))
	{
	}

	if(!isdefined(param_01))
	{
		param_01 = 0;
	}

	foreach(var_03 in level.deathflags[param_00])
	{
		foreach(var_05 in var_03)
		{
			if(isalive(var_05))
			{
				var_05 thread maps\_utility_code::func_4ACA(param_01);
				continue;
			}

			var_05 delete();
		}
	}
}

//Function Number: 599
func_3953(param_00,param_01,param_02,param_03)
{
	if(!isdefined(param_03))
	{
		param_03 = "player_view_controller";
	}

	if(!isdefined(param_02))
	{
		param_02 = (0,0,0);
	}

	var_04 = param_00 gettagorigin(param_01);
	var_05 = spawnturret("misc_turret",var_04,param_03);
	var_05.angles = param_00 gettagangles(param_01);
	var_05 setmodel("tag_turret");
	var_05 linkto(param_00,param_01,param_02,(0,0,0));
	var_05 makeunusable();
	var_05 hide();
	var_05 setmode("manual");
	return var_05;
}

//Function Number: 600
func_2068(param_00,param_01,param_02,param_03)
{
	var_04 = spawnstruct();
	var_04 childthread maps\_utility_code::process_blend(param_00,self,param_01,param_02,param_03);
	return var_04;
}

//Function Number: 601
func_7C7D(param_00)
{
	if(!isdefined(self.var_7C83))
	{
		self.var_7C83 = [];
	}

	var_01 = [];
	var_02 = self getweaponslistall();
	foreach(var_04 in var_02)
	{
		var_01[var_04] = [];
		var_01[var_04]["clip_left"] = self getweaponammoclip(var_04,"left");
		var_01[var_04]["clip_right"] = self getweaponammoclip(var_04,"right");
		var_01[var_04]["stock"] = self getweaponammostock(var_04);
	}

	if(!isdefined(param_00))
	{
		param_00 = "default";
	}

	self.var_7C83[param_00] = [];
	self.var_7C83[param_00]["current_weapon"] = self getcurrentweapon();
	self.var_7C83[param_00]["inventory"] = var_01;
}

//Function Number: 602
func_6653(param_00)
{
	if(!isdefined(param_00))
	{
		param_00 = "default";
	}

	if(!isdefined(self.var_7C83) || !isdefined(self.var_7C83[param_00]))
	{
	}

	self takeallweapons();
	foreach(var_03, var_02 in self.var_7C83[param_00]["inventory"])
	{
		if(weaponinventorytype(var_03) != "altmode")
		{
			self giveweapon(var_03);
		}

		self setweaponammoclip(var_03,var_02["clip_left"],"left");
		self setweaponammoclip(var_03,var_02["clip_right"],"right");
		self setweaponammostock(var_03,var_02["stock"]);
	}

	var_04 = self.var_7C83[param_00]["current_weapon"];
	if(var_04 != "none")
	{
		self switchtoweapon(var_04);
	}
}

//Function Number: 603
func_41DC()
{
	switch(self.code_classname)
	{
		case "light_spot":
		case "script_vehicle":
		case "script_model":
			self hide();
			break;

		case "script_brushmodel":
			self hide();
			self notsolid();
			if(self.spawnflags & 1)
			{
				self connectpaths();
			}
			break;

		case "trigger_multiple_flag_looking":
		case "trigger_multiple_flag_lookat":
		case "trigger_multiple_breachIcon":
		case "trigger_multiple_flag_set":
		case "trigger_use_touch":
		case "trigger_use":
		case "trigger_multiple":
		case "trigger_radius":
			common_scripts\utility::trigger_off();
			break;

		default:
			break;
	}
}

//Function Number: 604
show_entity()
{
	switch(self.code_classname)
	{
		case "light_spot":
		case "script_vehicle":
		case "script_model":
			self show();
			break;

		case "script_brushmodel":
			self show();
			self solid();
			if(self.spawnflags & 1)
			{
				self disconnectpaths();
			}
			break;

		case "trigger_multiple_flag_looking":
		case "trigger_multiple_flag_lookat":
		case "trigger_multiple_breachIcon":
		case "trigger_multiple_flag_set":
		case "trigger_use_touch":
		case "trigger_use":
		case "trigger_multiple":
		case "trigger_radius":
			common_scripts\utility::func_837B();
			break;

		default:
			break;
	}
}

//Function Number: 605
func_6F2E(param_00,param_01)
{
	self notify("set_moveplaybackrate");
	self endon("set_moveplaybackrate");
	if(isdefined(param_01))
	{
		var_02 = param_00 - self.moveplaybackrate;
		var_03 = 0.05;
		var_04 = param_01 / var_03;
		var_05 = var_02 / var_04;
		while(abs(param_00 - self.moveplaybackrate) > abs(var_05 * 1.1))
		{
			self.moveplaybackrate = self.moveplaybackrate + var_05;
			wait(var_03);
		}
	}

	self.moveplaybackrate = param_00;
}

//Function Number: 606
array_spawn_function(param_00,param_01,param_02,param_03,param_04,param_05)
{
	foreach(var_07 in param_00)
	{
		var_07 thread add_spawn_function(param_01,param_02,param_03,param_04,param_05);
	}
}

//Function Number: 607
array_spawn_function_targetname(param_00,param_01,param_02,param_03,param_04,param_05)
{
	var_06 = getentarray(param_00,"targetname");
	array_spawn_function(var_06,param_01,param_02,param_03,param_04,param_05);
}

//Function Number: 608
array_spawn_function_noteworthy(param_00,param_01,param_02,param_03,param_04,param_05)
{
	var_06 = getentarray(param_00,"script_noteworthy");
	array_spawn_function(var_06,param_01,param_02,param_03,param_04,param_05);
}

//Function Number: 609
func_2CAD()
{
	self.var_29AA = 1;
}

//Function Number: 610
disable_dontevershoot()
{
	self.var_29AA = undefined;
}

//Function Number: 611
create_sunflare_setting(param_00)
{
	if(!isdefined(level.var_7D4B))
	{
		level.var_7D4B = [];
	}

	var_01 = spawnstruct();
	var_01.name = param_00;
	level.var_7D4B[param_00] = var_01;
	return var_01;
}

//Function Number: 612
create_vision_set_fog(param_00)
{
	if(!isdefined(level.var_8A01))
	{
		level.var_8A01 = [];
	}

	var_01 = spawnstruct();
	var_01.name = param_00;
	var_01.hdrcolorintensity = 1;
	var_01.hdrsuncolorintensity = 1;
	var_01.skyfogintensity = 0;
	var_01.skyfogminangle = 0;
	var_01.skyfogmaxangle = 0;
	level.var_8A01[tolower(param_00)] = var_01;
	return var_01;
}

//Function Number: 613
func_39F2(param_00)
{
	if(!isdefined(level.var_8A01))
	{
		level.var_8A01 = [];
	}

	var_01 = level.var_8A01[tolower(param_00)];
	if(using_hdr_fog() && isdefined(var_01) && isdefined(var_01.hdroverride))
	{
		var_01 = level.var_8A01[tolower(var_01.hdroverride)];
	}

	return var_01;
}

//Function Number: 614
func_207B(param_00)
{
	if(!isdefined(level.var_3481))
	{
		level.var_3481 = [];
	}

	var_01 = spawnstruct();
	var_01.name = param_00;
	level.var_3481[tolower(param_00)] = var_01;
	return var_01;
}

//Function Number: 615
func_3882(param_00)
{
	if(!isdefined(level.var_3481))
	{
		level.var_3481 = [];
	}

	var_01 = level.var_3481[tolower(param_00)];
	return var_01;
}

//Function Number: 616
func_45A1()
{
	if(!isdefined(self.var_3483))
	{
		self.var_3483 = spawnstruct();
		self.var_3483.var_3486 = "";
		self.var_3483.time = 0;
	}
}

//Function Number: 617
using_hdr_fog()
{
	if(!isdefined(level.console))
	{
		set_console_status();
	}

	return func_47F6();
}

//Function Number: 618
func_3482(param_00,param_01)
{
	if(!isplayer(self))
	{
		maps\_art::init_fog_transition();
	}
	else
	{
		func_45A1();
	}

	if(!isdefined(level.var_3481))
	{
		level.var_3481 = [];
	}

	var_02 = level.var_3481[tolower(param_00)];
	if(!isdefined(var_02))
	{
		var_02 = level.var_8A01[tolower(param_00)];
	}

	if(isdefined(var_02) && isdefined(var_02.hdroverride) && using_hdr_fog())
	{
		if(isdefined(level.var_3481[tolower(var_02.hdroverride)]))
		{
			var_02 = level.var_3481[tolower(var_02.hdroverride)];
		}
		else if(isdefined(level.var_8A01))
		{
			var_02 = level.var_8A01[tolower(var_02.hdroverride)];
		}
	}

	if(!isdefined(param_01))
	{
		param_01 = var_02.transitiontime;
	}

	if(!isplayer(self))
	{
		func_6EDD(var_02,param_01);
		level.var_3483.var_3486 = param_00;
		level.var_3483.time = param_01;
	}

	if(param_00 != "" && self.var_3483.var_3486 == param_00 && self.var_3483.time == param_01)
	{
	}

	func_6EDD(var_02,param_01);
	self.var_3483.var_3486 = param_00;
	self.var_3483.time = param_01;
}

//Function Number: 619
func_6EDD(param_00,param_01)
{
	if(isdefined(param_00.sunfogenabled) && param_00.sunfogenabled)
	{
		if(!isplayer(self))
		{
			setexpfog(param_00.startdist,param_00.halfwaydist,param_00.red,param_00.green,param_00.blue,param_00.hdrcolorintensity,param_00.maxopacity,param_01,param_00.sunred,param_00.sungreen,param_00.sunblue,param_00.hdrsuncolorintensity,param_00.sundir,param_00.sunbeginfadeangle,param_00.sunendfadeangle,param_00.normalfogscale,param_00.skyfogintensity,param_00.skyfogminangle,param_00.skyfogmaxangle);
		}

		self playersetexpfog(param_00.startdist,param_00.halfwaydist,param_00.red,param_00.green,param_00.blue,param_00.hdrcolorintensity,param_00.maxopacity,param_01,param_00.sunred,param_00.sungreen,param_00.sunblue,param_00.hdrsuncolorintensity,param_00.sundir,param_00.sunbeginfadeangle,param_00.sunendfadeangle,param_00.normalfogscale,param_00.skyfogintensity,param_00.skyfogminangle,param_00.skyfogmaxangle);
	}

	if(!isplayer(self))
	{
		setexpfog(param_00.startdist,param_00.halfwaydist,param_00.red,param_00.green,param_00.blue,param_00.hdrcolorintensity,param_00.maxopacity,param_01,param_00.skyfogintensity,param_00.skyfogminangle,param_00.skyfogmaxangle);
	}

	self playersetexpfog(param_00.startdist,param_00.halfwaydist,param_00.red,param_00.green,param_00.blue,param_00.hdrcolorintensity,param_00.maxopacity,param_01,param_00.skyfogintensity,param_00.skyfogminangle,param_00.skyfogmaxangle);
}

//Function Number: 620
func_8A02(param_00,param_01)
{
	var_02 = func_8A00(param_00,param_01);
	if(var_02)
	{
		if(isdefined(func_39F2(param_00)))
		{
			func_3482(param_00,param_01);
		}

		clearfog(param_01);
	}
}

//Function Number: 621
func_45A2()
{
	if(!isdefined(self.var_8A06))
	{
		self.var_8A06 = spawnstruct();
		self.var_8A06.var_89FF = "";
		self.var_8A06.time = 0;
	}
}

//Function Number: 622
func_8A00(param_00,param_01)
{
	if(!isplayer(self))
	{
		var_02 = 1;
		if(!isdefined(level.var_8A06))
		{
			level.var_8A06 = spawnstruct();
			level.var_8A06.var_89FF = "";
			level.var_8A06.time = 0;
			var_02 = 0;
		}

		if(param_00 != "" && level.var_8A06.var_89FF == param_00 && level.var_8A06.time == param_01)
		{
			return 0;
		}

		level.var_8A06.var_89FF = param_00;
		level.var_8A06.time = param_01;
		if(var_02 && getdvarint("scr_art_tweak") != 0)
		{
		}
		else
		{
			visionsetnaked(param_00,param_01);
		}

		level.lvl_visionset = param_00;
		setdvar("vision_set_current",param_00);
	}
	else
	{
		func_45A2();
		if(param_00 != "" && self.var_8A06.var_89FF == param_00 && self.var_8A06.time == param_01)
		{
			return 0;
		}

		self.var_8A06.var_89FF = param_00;
		self.var_8A06.time = param_01;
		self visionsetnakedforplayer(param_00,param_01);
	}

	return 1;
}

//Function Number: 623
enable_teamflashbangimmunity()
{
	thread enable_teamflashbangimmunity_proc();
}

//Function Number: 624
enable_teamflashbangimmunity_proc()
{
	self endon("death");
	for(;;)
	{
		self.teamflashbangimmunity = 1;
		wait(0.05);
	}
}

//Function Number: 625
disable_teamflashbangimmunity()
{
	self.teamflashbangimmunity = undefined;
}

//Function Number: 626
func_50AD(param_00)
{
	var_01 = getentarray("destructible_toy","targetname");
	var_02 = getentarray("destructible_vehicle","targetname");
	var_03 = common_scripts\utility::array_combine(var_01,var_02);
	foreach(var_05 in param_00)
	{
		var_05.destructibles = [];
	}

	foreach(var_08 in var_03)
	{
		foreach(var_05 in param_00)
		{
			if(!var_05 istouching(var_08))
			{
				continue;
			}

			var_05 maps\_utility_code::func_6253(var_08);
			break;
		}
	}
}

//Function Number: 627
func_46A3()
{
	var_00 = [];
	var_00[0] = ["interactive_birds","targetname"];
	var_00[1] = ["interactive_vulture","targetname"];
	var_00[2] = ["interactive_fish","script_noteworthy"];
	return var_00;
}

//Function Number: 628
mask_interactives_in_volumes(param_00)
{
	var_01 = func_46A3();
	var_02 = [];
	foreach(var_04 in var_01)
	{
		var_05 = getentarray(var_04[0],var_04[1]);
		var_02 = common_scripts\utility::array_combine(var_02,var_05);
	}

	foreach(var_08 in var_02)
	{
		if(!isdefined(level._interactive[var_08.var_46A1].var_6AAC))
		{
			continue;
		}

		foreach(var_0B in param_00)
		{
			if(!var_0B istouching(var_08))
			{
				continue;
			}

			if(!isdefined(var_0B.var_46A4))
			{
				var_0B.var_46A4 = [];
			}

			var_0B.var_46A4[var_0B.var_46A4.size] = var_08 [[ level._interactive[var_08.var_46A1].var_6AAC ]]();
		}
	}
}

//Function Number: 629
activate_interactives_in_volume()
{
	if(!isdefined(self.var_46A4))
	{
	}

	foreach(var_01 in self.var_46A4)
	{
		var_01 [[ level._interactive[var_01.var_46A1].var_4E97 ]]();
	}

	self.var_46A4 = undefined;
}

//Function Number: 630
delete_interactives_in_volumes(param_00)
{
	mask_interactives_in_volumes(param_00);
	foreach(var_02 in param_00)
	{
		var_02.var_46A4 = undefined;
	}
}

//Function Number: 631
func_50AE(param_00)
{
	if(getdvar("createfx") != "")
	{
	}

	var_01 = getentarray("script_brushmodel","classname");
	var_02 = getentarray("script_model","classname");
	for(var_03 = 0;var_03 < var_02.size;var_03++)
	{
		var_01[var_01.size] = var_02[var_03];
	}

	foreach(var_05 in param_00)
	{
		foreach(var_07 in var_01)
		{
			if(isdefined(var_07.script_prefab_exploder))
			{
				var_07.script_exploder = var_07.script_prefab_exploder;
			}

			if(!isdefined(var_07.script_exploder))
			{
				continue;
			}

			if(!isdefined(var_07.model))
			{
				continue;
			}

			if(var_07.code_classname != "script_model")
			{
				continue;
			}

			if(!var_07 istouching(var_05))
			{
				continue;
			}

			var_07.masked_exploder = 1;
		}
	}
}

//Function Number: 632
activate_exploders_in_volume()
{
	var_00 = spawn("script_origin",(0,0,0));
	foreach(var_02 in level.createfxent)
	{
		if(!isdefined(var_02.var_880E["masked_exploder"]))
		{
			continue;
		}

		var_00.origin = var_02.var_880E["origin"];
		var_00.angles = var_02.var_880E["angles"];
		if(!var_00 istouching(self))
		{
			continue;
		}

		var_03 = var_02.var_880E["masked_exploder"];
		var_04 = var_02.var_880E["masked_exploder_spawnflags"];
		var_05 = var_02.var_880E["masked_exploder_script_disconnectpaths"];
		var_06 = spawn("script_model",(0,0,0),var_04);
		var_06 setmodel(var_03);
		var_06.origin = var_02.var_880E["origin"];
		var_06.angles = var_02.var_880E["angles"];
		var_02.var_880E["masked_exploder"] = undefined;
		var_02.var_880E["masked_exploder_spawnflags"] = undefined;
		var_02.var_880E["masked_exploder_script_disconnectpaths"] = undefined;
		var_06.disconnect_paths = var_05;
		var_06.script_exploder = var_02.var_880E["exploder"];
		common_scripts\_exploder::setup_individual_exploder(var_06);
		var_02.model = var_06;
	}

	var_00 delete();
}

//Function Number: 633
func_6104(param_00)
{
	var_01 = common_scripts\_destructible::func_267E(param_00);
	if(var_01 != -1)
	{
	}

	if(!isdefined(level.destructible_functions))
	{
		level.destructible_functions = [];
	}

	var_02 = spawnstruct();
	var_02.destructibleinfo = common_scripts\_destructible::func_267F(param_00);
	var_02 thread common_scripts\_destructible::func_6105();
	var_02 thread common_scripts\_destructible::add_destructible_fx();
}

//Function Number: 634
delete_destructibles_in_volumes(param_00,param_01)
{
	foreach(var_03 in param_00)
	{
		var_03.destructibles = [];
	}

	var_05 = ["destructible_toy","destructible_vehicle"];
	var_06 = 0;
	if(!isdefined(param_01))
	{
		param_01 = 0;
	}

	foreach(var_08 in var_05)
	{
		var_09 = getentarray(var_08,"targetname");
		foreach(var_0B in var_09)
		{
			foreach(var_03 in param_00)
			{
				if(param_01)
				{
					var_06++;
					var_06 = var_06 % 5;
					if(var_06 == 1)
					{
						wait(0.05);
					}
				}

				if(!var_03 istouching(var_0B))
				{
					continue;
				}

				var_0B delete();
				break;
			}
		}
	}
}

//Function Number: 635
func_254F(param_00,param_01)
{
	var_02 = getentarray("script_brushmodel","classname");
	var_03 = getentarray("script_model","classname");
	for(var_04 = 0;var_04 < var_03.size;var_04++)
	{
		var_02[var_02.size] = var_03[var_04];
	}

	var_05 = [];
	var_06 = spawn("script_origin",(0,0,0));
	var_07 = 0;
	if(!isdefined(param_01))
	{
		param_01 = 0;
	}

	foreach(var_09 in param_00)
	{
		foreach(var_0B in var_02)
		{
			if(!isdefined(var_0B.script_exploder))
			{
				continue;
			}

			var_06.origin = var_0B getorigin();
			if(!var_09 istouching(var_06))
			{
				continue;
			}

			var_05[var_05.size] = var_0B;
		}
	}

	array_delete(var_05);
	var_06 delete();
}

//Function Number: 636
activate_destructibles_in_volume()
{
	if(!isdefined(self.destructibles))
	{
	}

	foreach(var_01 in self.destructibles)
	{
		var_02 = spawn("script_model",(0,0,0));
		var_02 setmodel(var_01.var_81D5);
		var_02.origin = var_01.origin;
		var_02.angles = var_01.angles;
		var_02.script_noteworthy = var_01.script_noteworthy;
		var_02.targetname = var_01.targetname;
		var_02.target = var_01.target;
		var_02.script_linkto = var_01.script_linkto;
		var_02.destructible_type = var_01.destructible_type;
		var_02.script_noflip = var_01.script_noflip;
		var_02 common_scripts\_destructible::func_7137(1);
	}

	self.destructibles = [];
}

//Function Number: 637
setflashbangimmunity(param_00)
{
	self.flashbangimmunity = param_00;
}

//Function Number: 638
func_33FB()
{
	var_00 = self.flashendtime - gettime();
	if(var_00 < 0)
	{
		return 0;
	}

	return var_00 * 0.001;
}

//Function Number: 639
flashbangisactive()
{
	return func_33FB() > 0;
}

//Function Number: 640
flashbangstart(param_00)
{
	if(isdefined(self.flashbangimmunity) && self.flashbangimmunity)
	{
	}

	var_01 = gettime() + param_00 * 1000;
	if(isdefined(self.flashendtime))
	{
		self.flashendtime = max(self.flashendtime,var_01);
	}
	else
	{
		self.flashendtime = var_01;
	}

	self notify("flashed");
	self setflashbanged(1);
}

//Function Number: 641
func_8BAB()
{
	for(;;)
	{
		var_00 = getaispeciesarray("axis","all");
		var_01 = 0;
		foreach(var_03 in var_00)
		{
			if(!isalive(var_03))
			{
				continue;
			}

			if(var_03 istouching(self))
			{
				var_01 = 1;
				break;
			}

			wait(0.0125);
		}

		if(!var_01)
		{
			var_05 = get_ai_touching_volume("axis");
			if(!var_05.size)
			{
				break;
			}
		}

		wait(0.05);
	}
}

//Function Number: 642
func_8BAC()
{
	var_00 = 0;
	for(;;)
	{
		var_01 = getaispeciesarray("axis","all");
		var_02 = 0;
		foreach(var_04 in var_01)
		{
			if(!isalive(var_04))
			{
				continue;
			}

			if(var_04 istouching(self))
			{
				if(var_04 doinglongdeath())
				{
					continue;
				}

				var_02 = 1;
				var_00 = 1;
				break;
			}

			wait(0.0125);
		}

		if(!var_02)
		{
			var_06 = get_ai_touching_volume("axis");
			if(!var_06.size)
			{
				break;
			}
			else
			{
				var_00 = 1;
			}
		}

		wait(0.05);
	}

	return var_00;
}

//Function Number: 643
waittill_volume_dead_then_set_flag(param_00)
{
	func_8BAB();
	common_scripts\utility::flag_set(param_00);
}

//Function Number: 644
func_8BA0(param_00,param_01)
{
	var_02 = getent(param_00,"targetname");
	var_02 waittill_volume_dead_then_set_flag(param_01);
}

//Function Number: 645
func_5D95()
{
	level.player func_2F44("player_zero_attacker_accuracy");
	level.player.ignorerandombulletdamage = 0;
	level.player maps\_gameskill::func_869B();
}

//Function Number: 646
func_5D9B()
{
	level.player func_2F48("player_zero_attacker_accuracy");
	level.player.attackeraccuracy = 0;
	level.player.ignorerandombulletdamage = 1;
}

//Function Number: 647
func_6F6E(param_00)
{
	var_01 = func_3942();
	var_01.var_3DE2.var_5D81 = param_00;
	var_01 maps\_gameskill::func_869B();
}

//Function Number: 648
array_index_by_parameters(param_00)
{
	var_01 = [];
	foreach(var_03 in param_00)
	{
		var_01[var_03.script_parameters] = var_03;
	}

	return var_01;
}

//Function Number: 649
array_index_by_classname(param_00)
{
	var_01 = [];
	foreach(var_03 in param_00)
	{
		var_01[var_03.classname] = var_03;
	}

	return var_01;
}

//Function Number: 650
func_0EEA(param_00)
{
	var_01 = [];
	foreach(var_03 in param_00)
	{
		var_04 = var_03.script_index;
		if(isdefined(var_04))
		{
			var_01[var_04] = var_03;
		}
	}

	return var_01;
}

//Function Number: 651
add_target_pivot(param_00)
{
	if(isdefined(param_00))
	{
		self.var_5C63 = param_00;
	}
	else
	{
		self.var_5C63 = getent(self.target,"targetname");
	}

	self linkto(self.var_5C63);
}

//Function Number: 652
get_color_volume_from_trigger()
{
	var_00 = maps\_utility_code::func_381B();
	var_01 = var_00["team"];
	foreach(var_03 in var_00["codes"])
	{
		var_04 = level.arrays_of_colorcoded_volumes[var_01][var_03];
		if(isdefined(var_04))
		{
			return var_04;
		}
	}

	return undefined;
}

//Function Number: 653
func_381D()
{
	var_00 = maps\_utility_code::func_381B();
	var_01 = var_00["team"];
	foreach(var_03 in var_00["codes"])
	{
		var_04 = level.arrays_of_colorcoded_nodes[var_01][var_03];
		if(isdefined(var_04))
		{
			return var_04;
		}
	}

	return undefined;
}

//Function Number: 654
flashbangstop()
{
	self.flashendtime = undefined;
	self setflashbanged(0);
}

//Function Number: 655
getent_or_struct(param_00,param_01)
{
	var_02 = getent(param_00,param_01);
	if(isdefined(var_02))
	{
		return var_02;
	}

	return common_scripts\utility::func_3C18(param_00,param_01);
}

//Function Number: 656
func_3DA7()
{
	thread func_2DE0();
	self endon("end_explode");
	self waittill("explode",var_00);
	dirt_on_screen_from_position(var_00);
}

//Function Number: 657
func_2DE0()
{
	self waittill("death");
	waittillframeend;
	self notify("end_explode");
}

//Function Number: 658
dirt_on_screen_from_position(param_00)
{
	playrumbleonposition("grenade_rumble",param_00);
	earthquake(0.3,0.5,param_00,400);
	foreach(var_02 in level.players)
	{
		if(distance(param_00,var_02.origin) > 600)
		{
			continue;
		}

		if(var_02 damageconetrace(param_00))
		{
			var_02 thread func_273F(param_00);
		}
	}
}

//Function Number: 659
player_rides_shotgun_in_humvee(param_00,param_01,param_02,param_03)
{
	return func_5EE1("shotgun",level.player,param_00,param_01,param_02,param_03);
}

//Function Number: 660
func_5EE1(param_00,param_01,param_02,param_03,param_04,param_05)
{
	if(!isdefined(param_01))
	{
		param_01 = level.player;
	}

	param_01 allowcrouch(0);
	param_01 allowprone(0);
	param_01 disableweapons();
	var_06 = common_scripts\utility::func_7836();
	var_06 linkto(self,"tag_passenger",func_5EE2(param_00),(0,0,0));
	var_06.player_dismount = common_scripts\utility::func_7836();
	var_06.player_dismount linkto(self,"tag_body",func_5EE0(param_00),(0,0,0));
	if(!isdefined(param_02))
	{
		param_02 = 90;
	}

	if(!isdefined(param_03))
	{
		param_03 = 90;
	}

	if(!isdefined(param_04))
	{
		param_04 = 40;
	}

	if(!isdefined(param_05))
	{
		param_05 = 40;
	}

	param_01 disableweapons();
	param_01 playerlinkto(var_06,"tag_origin",0.8,param_02,param_03,param_04,param_05);
	param_01.var_4376 = var_06;
	return var_06;
}

//Function Number: 661
func_5EE2(param_00)
{
	switch(param_00)
	{
		case "shotgun":
			return (-5,10,-34);

		case "backleft":
			return (-45,45,-34);

		case "backright":
			return (-45,5,-34);
	}
}

//Function Number: 662
func_5EE0(param_00)
{
	switch(param_00)
	{
		case "shotgun":
			return (-8,-90,-12.6);

		case "backleft":
			return (-58,85,-12.6);

		case "backright":
			return (-58,-95,-12.6);
	}
}

//Function Number: 663
func_5E78(param_00)
{
	if(!isdefined(param_00))
	{
		param_00 = 0;
	}

	var_01 = self;
	var_02 = level.player;
	if(isplayer(self))
	{
		var_02 = self;
		var_01 = var_02.var_4376;
	}

	var_01 unlink();
	if(!param_00)
	{
		var_03 = 0.6;
		var_01 moveto(var_01.player_dismount.origin,var_03,var_03 * 0.5,var_03 * 0.5);
		wait(var_03);
	}

	var_02 unlink();
	var_02 enableweapons();
	var_02 allowcrouch(1);
	var_02 allowprone(1);
	var_02.var_4376 = undefined;
	var_01.player_dismount delete();
	var_01 delete();
}

//Function Number: 664
func_273F(param_00,param_01)
{
	var_02 = func_6B0B(param_00);
	foreach(var_05, var_04 in var_02)
	{
		thread maps\_gameskill::func_3DA6(var_05);
	}
}

//Function Number: 665
bloodsplateffect(param_00)
{
	if(!isdefined(self.damageattacker))
	{
	}

	var_01 = func_6B0B(self.damageattacker.origin);
	foreach(var_04, var_03 in var_01)
	{
		thread maps\_gameskill::blood_splat_on_screen(var_04);
	}
}

//Function Number: 666
func_6B0B(param_00)
{
	var_01 = vectornormalize(anglestoforward(self.angles));
	var_02 = vectornormalize(anglestoright(self.angles));
	var_03 = vectornormalize(param_00 - self.origin);
	var_04 = vectordot(var_03,var_01);
	var_05 = vectordot(var_03,var_02);
	var_06 = [];
	var_07 = self getcurrentweapon();
	if(var_04 > 0 && var_04 > 0.5 && weapontype(var_07) != "riotshield")
	{
		var_06["bottom"] = 1;
	}

	if(abs(var_04) < 0.866)
	{
		if(var_05 > 0)
		{
			var_06["right"] = 1;
		}
		else
		{
			var_06["left"] = 1;
		}
	}

	return var_06;
}

//Function Number: 667
pathrandompercent_set(param_00)
{
	if(!isdefined(self.var_58A7))
	{
		self.var_58A7 = self.pathrandompercent;
	}

	self.pathrandompercent = param_00;
}

//Function Number: 668
func_5B36()
{
	if(isdefined(self.var_58A7))
	{
	}

	self.var_58A7 = self.pathrandompercent;
	self.pathrandompercent = 0;
}

//Function Number: 669
func_5B34()
{
	self.pathrandompercent = self.var_58A7;
	self.var_58A7 = undefined;
}

//Function Number: 670
func_8BDC()
{
	if(isdefined(self.var_58AE))
	{
	}

	self.var_58AD = self.walkdist;
	self.var_58AE = self.walkdistfacingmotion;
	self.walkdist = 0;
	self.walkdistfacingmotion = 0;
}

//Function Number: 671
func_8BDB()
{
	self.walkdist = self.var_58AD;
	self.walkdistfacingmotion = self.var_58AE;
	self.var_58AD = undefined;
	self.var_58AE = undefined;
}

//Function Number: 672
enable_ignorerandombulletdamage_drone()
{
	thread func_4411();
}

//Function Number: 673
func_4411()
{
	self endon("disable_ignorerandombulletdamage_drone");
	self endon("death");
	self.ignorerandombulletdamage = 1;
	self.var_3187 = self.health;
	self.health = 1000000;
	for(;;)
	{
		self waittill("damage",var_00,var_01);
		if(!isplayer(var_01) && issentient(var_01))
		{
			if(isdefined(var_01.enemy) && var_01.enemy != self)
			{
				continue;
			}
		}

		self.var_3187 = self.var_3187 - var_00;
		if(self.var_3187 <= 0)
		{
			break;
		}
	}

	self kill();
}

//Function Number: 674
hide_notsolid()
{
	if(!isdefined(self.var_58B7))
	{
		self.var_58B7 = self setcontents(0);
	}

	self hide();
}

//Function Number: 675
func_74FB()
{
	if(!isai(self))
	{
		self solid();
	}

	if(isdefined(self.var_58B7))
	{
		self setcontents(self.var_58B7);
	}

	self show();
}

//Function Number: 676
func_6E5D(param_00)
{
	self.veh_brake = param_00;
}

//Function Number: 677
disable_ignorerandombulletdamage_drone()
{
	if(!isalive(self))
	{
	}

	if(!isdefined(self.ignorerandombulletdamage))
	{
	}

	self notify("disable_ignorerandombulletdamage_drone");
	self.ignorerandombulletdamage = undefined;
	self.health = self.var_3187;
}

//Function Number: 678
func_8127(param_00)
{
	var_01 = spawnstruct();
	var_01 func_252F(param_00,::func_6D98,"timeout");
	return var_01;
}

//Function Number: 679
func_252F(param_00,param_01,param_02,param_03,param_04,param_05,param_06,param_07)
{
	thread maps\_utility_code::delaythread_proc(param_01,param_00,param_02,param_03,param_04,param_05,param_06,param_07);
}

//Function Number: 680
delaychildthread(param_00,param_01,param_02,param_03,param_04,param_05,param_06,param_07)
{
	childthread maps\_utility_code::delaychildthread_proc(param_01,param_00,param_02,param_03,param_04,param_05,param_06,param_07);
}

//Function Number: 681
flagwaitthread(param_00,param_01,param_02,param_03,param_04,param_05,param_06,param_07)
{
	if(!isarray(param_00))
	{
		param_00 = [param_00,0];
	}

	thread maps\_utility_code::flagwaitthread_proc(param_01,param_00,param_02,param_03,param_04,param_05,param_06,param_07);
}

//Function Number: 682
func_8BC3(param_00,param_01,param_02,param_03,param_04,param_05,param_06,param_07)
{
	self endon("death");
	if(!isarray(param_00))
	{
		param_00 = [param_00,0];
	}

	thread maps\_utility_code::func_8BC4(param_01,param_00,param_02,param_03,param_04,param_05,param_06,param_07);
}

//Function Number: 683
enable_danger_react(param_00)
{
	param_00 = param_00 * 1000;
	self.dodangerreact = 1;
	self.dangerreactduration = param_00;
	self.var_55A9 = undefined;
}

//Function Number: 684
disable_danger_react()
{
	self.dodangerreact = 0;
	self.var_55A9 = 1;
}

//Function Number: 685
func_6F02(param_00,param_01)
{
	level.advancetoenemyinterval = param_00;
	level.advancetoenemygroupmax = param_01;
}

//Function Number: 686
func_65E6(param_00)
{
	level.var_4C39[param_00] = gettime();
}

//Function Number: 687
set_custom_gameskill_func(param_00)
{
	level.var_222A = param_00;
	thread maps\_gameskill::resetskill();
}

//Function Number: 688
clear_custom_gameskill_func()
{
	level.var_222A = undefined;
	thread maps\_gameskill::resetskill();
}

//Function Number: 689
func_6FCC(param_00,param_01,param_02)
{
	maps\_animatedmodels::init_wind_if_uninitialized();
	if(isdefined(param_02))
	{
		level.var_8DEB.var_8858 = param_02;
	}

	level.var_8DEB.rate = param_01;
	level.var_8DEB.weight = param_00;
	level notify("windchange","strong");
}

//Function Number: 690
string_is_single_digit_integer(param_00)
{
	if(param_00.size > 1)
	{
		return 0;
	}

	var_01 = [];
	var_01["0"] = 1;
	var_01["1"] = 1;
	var_01["2"] = 1;
	var_01["3"] = 1;
	var_01["4"] = 1;
	var_01["5"] = 1;
	var_01["6"] = 1;
	var_01["7"] = 1;
	var_01["8"] = 1;
	var_01["9"] = 1;
	if(isdefined(var_01[param_00]))
	{
		return 1;
	}

	return 0;
}

//Function Number: 691
func_6E55(param_00,param_01)
{
	level.battlechatter[param_00] = param_01;
	maps\_utility_code::func_8661();
}

//Function Number: 692
func_57CB(param_00)
{
	for(var_01 = 0;var_01 < 8;var_01++)
	{
		objective_additionalposition(param_00,var_01,(0,0,0));
	}
}

//Function Number: 693
get_minutes_and_seconds(param_00)
{
	var_01 = [];
	var_01["minutes"] = 0;
	for(var_01["seconds"] = int(param_00 / 1000);var_01["seconds"] >= 60;var_01["seconds"] = var_01["seconds"] - 60)
	{
		var_01["minutes"]++;
	}

	if(var_01["seconds"] < 10)
	{
		var_01["seconds"] = "0" + var_01["seconds"];
	}

	return var_01;
}

//Function Number: 694
func_5E27(param_00)
{
	var_01 = level.player getweaponslistprimaries();
	foreach(var_03 in var_01)
	{
		if(var_03 == param_00)
		{
			return 1;
		}
	}

	return 0;
}

//Function Number: 695
obj(param_00)
{
	if(!isdefined(level.var_57AD))
	{
		level.var_57AD = [];
	}

	if(!isdefined(level.var_57AD[param_00]))
	{
		level.var_57AD[param_00] = level.var_57AD.size + 1;
	}

	return level.var_57AD[param_00];
}

//Function Number: 696
obj_exists(param_00)
{
	return isdefined(level.var_57AD) && isdefined(level.var_57AD[param_00]);
}

//Function Number: 697
func_5E9F(param_00)
{
	self mountvehicle(param_00);
	self.drivingvehicle = param_00;
}

//Function Number: 698
func_5DC7()
{
	self dismountvehicle();
	self.drivingvehicle = undefined;
}

//Function Number: 699
graph_position(param_00,param_01,param_02,param_03,param_04)
{
	var_05 = param_04 - param_02;
	var_06 = param_03 - param_01;
	var_07 = var_05 / var_06;
	param_00 = param_00 - param_03;
	param_00 = var_07 * param_00;
	param_00 = param_00 + param_04;
	return param_00;
}

//Function Number: 700
enable_achievement_harder_they_fall()
{
	self.var_6392 = 1;
}

//Function Number: 701
func_2741()
{
	self.var_6392 = undefined;
}

//Function Number: 702
func_2C95(param_00)
{
	param_00 enable_achievement_harder_they_fall();
}

//Function Number: 703
disable_achievement_harder_they_fall_guy(param_00)
{
	param_00 func_2741();
}

//Function Number: 704
musiclength(param_00)
{
	var_01 = lookupsoundlength(param_00);
	var_01 = var_01 * 0.001;
	return var_01;
}

//Function Number: 705
func_47CD(param_00)
{
	var_01 = getkeybinding(param_00);
	return var_01["count"];
}

//Function Number: 706
func_4E1B(param_00,param_01,param_02)
{
	var_03 = param_02 - param_01;
	var_04 = param_00 * var_03;
	var_05 = param_01 + var_04;
	return var_05;
}

//Function Number: 707
define_loadout(param_00)
{
	level.var_4E9D = param_00;
}

//Function Number: 708
func_8039(param_00)
{
	define_loadout(param_00);
	level.template_script = param_00;
}

//Function Number: 709
func_803B(param_00)
{
	level.audio_stringtable_mapname = param_00;
}

//Function Number: 710
func_36A8(param_00,param_01)
{
	thread func_36A9(param_00,param_01);
}

//Function Number: 711
func_36A9(param_00,param_01)
{
	var_02 = getent(param_00,"script_noteworthy");
	var_02 notify("new_volume_command");
	var_02 endon("new_volume_command");
	wait(0.05);
	func_36A7(var_02,param_01);
}

//Function Number: 712
func_36A7(param_00,param_01)
{
	param_00.var_3648 = 1;
	if(!isdefined(param_01))
	{
		param_01 = 0;
	}

	if(param_01)
	{
		func_0F1E(param_00.fx,::common_scripts\utility::func_5B59);
	}

	common_scripts\utility::func_F1B(param_00.fx,::common_scripts\utility::func_5B59);
}

//Function Number: 713
func_0F1E(param_00,param_01,param_02)
{
	var_03 = 0;
	if(!isdefined(param_02))
	{
		param_02 = 5;
	}

	var_04 = [];
	foreach(var_06 in param_00)
	{
		var_04[var_04.size] = var_06;
		var_03++;
		var_03 = var_03 % param_02;
		if(param_02 == 0)
		{
			common_scripts\utility::func_F1B(var_04,param_01);
			wait(0.05);
			var_04 = [];
		}
	}
}

//Function Number: 714
func_36AB(param_00)
{
	thread func_36AC(param_00);
}

//Function Number: 715
func_36AC(param_00)
{
	var_01 = getent(param_00,"script_noteworthy");
	var_01 notify("new_volume_command");
	var_01 endon("new_volume_command");
	wait(0.05);
	if(!isdefined(var_01.var_3648))
	{
	}

	var_01.var_3648 = undefined;
	func_36AA(var_01);
}

//Function Number: 716
func_36AA(param_00)
{
	common_scripts\utility::func_F1B(param_00.fx,::func_6643);
}

//Function Number: 717
func_3380(param_00)
{
	if(!isdefined(level.flag_count))
	{
		level.flag_count = [];
	}

	if(!isdefined(level.flag_count[param_00]))
	{
		level.flag_count[param_00] = 1;
	}

	level.flag_count[param_00]++;
}

//Function Number: 718
func_337F(param_00)
{
	level.flag_count[param_00]--;
	level.flag_count[param_00] = int(max(0,level.flag_count[param_00]));
	if(level.flag_count[param_00])
	{
	}

	common_scripts\utility::flag_set(param_00);
}

//Function Number: 719
func_3381(param_00,param_01)
{
	level.flag_count[param_00] = param_01;
}

//Function Number: 720
add_cleanup_ent(param_00,param_01)
{
	if(!isdefined(level.cleanup_ents))
	{
		level.cleanup_ents = [];
	}

	if(!isdefined(level.cleanup_ents[param_01]))
	{
		level.cleanup_ents[param_01] = [];
	}

	level.cleanup_ents[param_01][level.cleanup_ents[param_01].size] = param_00;
}

//Function Number: 721
cleanup_ents(param_00)
{
	var_01 = level.cleanup_ents[param_00];
	var_01 = common_scripts\utility::array_removeundefined(var_01);
	array_delete(var_01);
	level.cleanup_ents[param_00] = undefined;
}

//Function Number: 722
cleanup_ents_removing_bullet_shield(param_00)
{
	if(!isdefined(level.cleanup_ents))
	{
	}

	if(!isdefined(level.cleanup_ents[param_00]))
	{
	}

	var_01 = level.cleanup_ents[param_00];
	var_01 = common_scripts\utility::array_removeundefined(var_01);
	foreach(var_03 in var_01)
	{
		if(!isai(var_03))
		{
			continue;
		}

		if(!isalive(var_03))
		{
			continue;
		}

		if(!isdefined(var_03.magic_bullet_shield))
		{
			continue;
		}

		if(!var_03.magic_bullet_shield)
		{
			continue;
		}

		var_03 func_7C38();
	}

	array_delete(var_01);
	level.cleanup_ents[param_00] = undefined;
}

//Function Number: 723
add_trigger_function(param_00)
{
	if(!isdefined(self.trigger_functions))
	{
		thread maps\_utility_code::add_trigger_func_thread();
	}

	self.trigger_functions[self.trigger_functions.size] = param_00;
}

//Function Number: 724
getallweapons()
{
	var_00 = [];
	var_01 = getentarray();
	foreach(var_03 in var_01)
	{
		if(!isdefined(var_03.classname))
		{
			continue;
		}

		if(issubstr(var_03.classname,"weapon_"))
		{
			var_00[var_00.size] = var_03;
		}
	}

	return var_00;
}

//Function Number: 725
func_62BC(param_00)
{
	level.var_6AF5[param_00] = param_00;
}

//Function Number: 726
move_with_rate(param_00,param_01,param_02)
{
	self notify("newmove");
	self endon("newmove");
	if(!isdefined(param_02))
	{
		param_02 = 200;
	}

	var_03 = distance(self.origin,param_00);
	var_04 = var_03 / param_02;
	var_05 = vectornormalize(param_00 - self.origin);
	self moveto(param_00,var_04,0,0);
	self rotateto(param_01,var_04,0,0);
	wait(var_04);
	if(!isdefined(self))
	{
	}

	self.velocity = var_05 * var_03 / var_04;
}

//Function Number: 727
flag_on_death(param_00)
{
	level endon(param_00);
	self waittill("death");
	common_scripts\utility::flag_set(param_00);
}

//Function Number: 728
func_2CA5()
{
	level.damagefeedback = 1;
}

//Function Number: 729
disable_damagefeedback()
{
	level.damagefeedback = 0;
}

//Function Number: 730
func_47D7()
{
	return isdefined(level.damagefeedback) && level.damagefeedback;
}

//Function Number: 731
add_damagefeedback()
{
	maps\_damagefeedback::func_537B();
}

//Function Number: 732
remove_damagefeedback()
{
	maps\_damagefeedback::func_7C69();
}

//Function Number: 733
func_47DC()
{
	if(getdvar("e3demo") == "1")
	{
		return 1;
	}

	return 0;
}

//Function Number: 734
deletestructarray(param_00,param_01,param_02)
{
	var_03 = common_scripts\utility::func_3C1A(param_00,param_01);
	deletestructarray_ref(var_03,param_02);
}

//Function Number: 735
deletestruct_ref(param_00)
{
	if(!isdefined(param_00))
	{
	}

	var_01 = param_00.script_linkname;
	if(isdefined(var_01) && isdefined(level.struct_class_names["script_linkname"]) && isdefined(level.struct_class_names["script_linkname"][var_01]))
	{
		foreach(var_04, var_03 in level.struct_class_names["script_linkname"][var_01])
		{
			if(isdefined(var_03) && param_00 == var_03)
			{
				level.struct_class_names["script_linkname"][var_01][var_04] = undefined;
			}
		}

		if(level.struct_class_names["script_linkname"][var_01].size == 0)
		{
			level.struct_class_names["script_linkname"][var_01] = undefined;
		}
	}

	var_01 = param_00.script_noteworthy;
	if(isdefined(var_01) && isdefined(level.struct_class_names["script_noteworthy"]) && isdefined(level.struct_class_names["script_noteworthy"][var_01]))
	{
		foreach(var_04, var_03 in level.struct_class_names["script_noteworthy"][var_01])
		{
			if(isdefined(var_03) && param_00 == var_03)
			{
				level.struct_class_names["script_noteworthy"][var_01][var_04] = undefined;
			}
		}

		if(level.struct_class_names["script_noteworthy"][var_01].size == 0)
		{
			level.struct_class_names["script_noteworthy"][var_01] = undefined;
		}
	}

	var_01 = param_00.target;
	if(isdefined(var_01) && isdefined(level.struct_class_names["target"]) && isdefined(level.struct_class_names["target"][var_01]))
	{
		foreach(var_04, var_03 in level.struct_class_names["target"][var_01])
		{
			if(isdefined(var_03) && param_00 == var_03)
			{
				level.struct_class_names["target"][var_01][var_04] = undefined;
			}
		}

		if(level.struct_class_names["target"][var_01].size == 0)
		{
			level.struct_class_names["target"][var_01] = undefined;
		}
	}

	var_01 = param_00.targetname;
	if(isdefined(var_01) && isdefined(level.struct_class_names["targetname"]) && isdefined(level.struct_class_names["targetname"][var_01]))
	{
		foreach(var_04, var_03 in level.struct_class_names["targetname"][var_01])
		{
			if(isdefined(var_03) && param_00 == var_03)
			{
				level.struct_class_names["targetname"][var_01][var_04] = undefined;
			}
		}

		if(level.struct_class_names["targetname"][var_01].size == 0)
		{
			level.struct_class_names["targetname"][var_01] = undefined;
		}
	}

	if(isdefined(level.struct))
	{
		foreach(var_04, var_03 in level.struct)
		{
			if(param_00 == var_03)
			{
				level.struct[var_04] = undefined;
			}
		}
	}
}

//Function Number: 736
deletestructarray_ref(param_00,param_01)
{
	if(!isdefined(param_00) || !isarray(param_00) || param_00.size == 0)
	{
	}

	param_01 = common_scripts\utility::func_803F(isdefined(param_01),param_01,0);
	param_01 = common_scripts\utility::func_803F(param_01 > 0,param_01,0);
	if(param_01 > 0)
	{
		foreach(var_03 in param_00)
		{
			deletestruct_ref(var_03);
			wait(param_01);
		}
	}

	foreach(var_03 in param_01)
	{
		deletestruct_ref(var_03);
	}
}

//Function Number: 737
func_3C19(param_00,param_01)
{
	var_02 = common_scripts\utility::func_3C18(param_00,param_01);
	deletestruct_ref(var_02);
	return var_02;
}

//Function Number: 738
func_3C1B(param_00,param_01,param_02)
{
	var_03 = common_scripts\utility::func_3C1A(param_00,param_01);
	deletestructarray_ref(var_03,param_02);
	return var_03;
}

//Function Number: 739
func_3A9C(param_00,param_01)
{
	var_02 = getent_or_struct(param_00,param_01);
	if(!isdefined(var_02))
	{
		var_02 = getnode(param_00,param_01);
	}

	if(!isdefined(var_02))
	{
		var_02 = getvehiclenode(param_00,param_01);
	}

	return var_02;
}

//Function Number: 740
func_702E(param_00,param_01,param_02,param_03,param_04)
{
	if(isdefined(param_03))
	{
		self.entityheadiconoffset = param_03;
	}
	else
	{
		self.entityheadiconoffset = (0,0,0);
	}

	if(isdefined(param_04))
	{
		self.var_2F74 = param_04;
	}

	self notify("new_head_icon");
	var_05 = newhudelem();
	var_05.archived = 1;
	var_05.alpha = 0.8;
	var_05 setshader(param_00,param_01,param_02);
	var_05 setwaypoint(0,0,0,1);
	self.entityheadicon = var_05;
	func_86E8();
	thread func_86E7();
	thread func_264C();
}

//Function Number: 741
func_6588()
{
	if(!isdefined(self.entityheadicon))
	{
	}

	self.entityheadicon destroy();
}

//Function Number: 742
func_86E7()
{
	self endon("new_head_icon");
	self endon("death");
	var_00 = self.origin;
	for(;;)
	{
		if(var_00 != self.origin)
		{
			func_86E8();
			var_00 = self.origin;
		}

		wait(0.05);
	}
}

//Function Number: 743
func_86E8()
{
	if(isdefined(self.var_2F74))
	{
		var_00 = self [[ self.var_2F74 ]]();
		if(isdefined(var_00))
		{
			self.entityheadicon.x = self.entityheadiconoffset[0] + var_00[0];
			self.entityheadicon.y = self.entityheadiconoffset[1] + var_00[1];
			self.entityheadicon.z = self.entityheadiconoffset[2] + var_00[2];
		}
	}

	self.entityheadicon.x = self.origin[0] + self.entityheadiconoffset[0];
	self.entityheadicon.y = self.origin[1] + self.entityheadiconoffset[1];
	self.entityheadicon.z = self.origin[2] + self.entityheadiconoffset[2];
}

//Function Number: 744
func_264C()
{
	self endon("new_head_icon");
	self waittill("death");
	if(!isdefined(self.entityheadicon))
	{
	}

	self.entityheadicon destroy();
}

//Function Number: 745
func_8E47(param_00)
{
	var_01 = param_00 - self.origin;
	return (vectordot(var_01,anglestoforward(self.angles)),-1 * vectordot(var_01,anglestoright(self.angles)),vectordot(var_01,anglestoup(self.angles)));
}

//Function Number: 746
func_6E4D(param_00,param_01)
{
	maps\_audio::func_6FD2(param_00,param_01);
}

//Function Number: 747
func_7C13(param_00)
{
	maps\_audio::func_7C59(param_00);
}

//Function Number: 748
func_37DC()
{
	return level._audio.zone.var_21E6;
}

//Function Number: 749
func_6E4A(param_00,param_01)
{
	maps\_audio::func_6EB5(param_00,param_01);
}

//Function Number: 750
clear_audio_filter(param_00)
{
	maps\_audio::clear_filter(param_00);
}

//Function Number: 751
func_6E4C(param_00)
{
	maps\_audio::func_6F37(param_00);
}

//Function Number: 752
clear_audio_occlusion()
{
	maps\_audio::deactivate_occlusion();
}

//Function Number: 753
func_7709(param_00)
{
	self scalevolume(0,param_00);
	common_scripts\utility::delaycall(param_00 + 0.05,::stopsounds);
	common_scripts\utility::delaycall(param_00 + 0.1,::delete);
}

//Function Number: 754
sound_fade_in(param_00,param_01,param_02,param_03)
{
	param_01 = clamp(param_01,0,1);
	param_02 = max(0.05,param_02);
	if(isdefined(param_03))
	{
		self playloopsound(param_00);
	}
	else
	{
		self playsound(param_00);
	}

	self scalevolume(0);
	common_scripts\utility::delaycall(0.05,::scalevolume,param_01,param_02);
}

//Function Number: 755
delete_on_sounddone()
{
	self waittill("sounddone");
	self delete();
}

//Function Number: 756
func_6F1A(param_00)
{
	level._audio.var_4DA4 = param_00;
}

//Function Number: 757
set_audio_mix(param_00)
{
	maps\_audio::func_6F26(param_00);
}

//Function Number: 758
clear_audio_mix(param_00)
{
	maps\_audio::clear_mix(param_00);
}

//Function Number: 759
func_6166()
{
}

//Function Number: 760
func_474E(param_00,param_01,param_02,param_03,param_04)
{
	level.introscreen = spawnstruct();
	level.introscreen.var_1EA0 = 3;
	level.introscreen.fade_out_time = 1.5;
	level.introscreen.var_3137 = undefined;
	if(isdefined(param_03))
	{
		level.introscreen.lines = [param_00,param_01,param_02,param_03];
	}
	else
	{
		level.introscreen.lines = [param_00,param_01,param_02];
	}

	common_scripts\utility::func_5682(level.introscreen.lines,::precachestring);
}

//Function Number: 761
func_474F(param_00)
{
	level.introscreen.var_2243 = param_00;
}

//Function Number: 762
intro_screen_custom_timing(param_00,param_01,param_02)
{
	level.introscreen.var_1EA0 = param_00;
	level.introscreen.fade_out_time = param_01;
	level.introscreen.var_3137 = param_02;
}

//Function Number: 763
func_644B(param_00,param_01,param_02)
{
	animscripts/animset::func_6466(param_00,param_01,param_02);
}

//Function Number: 764
archetype_exists(param_00)
{
	return animscripts/animset::archetypeexists(param_00);
}

//Function Number: 765
func_6E46(param_00)
{
	self.var_DC4 = param_00;
	self notify("move_loop_restart");
	if(param_00 == "creepwalk")
	{
		self.var_73F5 = 72;
	}
}

//Function Number: 766
func_1CF8()
{
	if(isdefined(self.var_DC4) && self.var_DC4 == "creepwalk")
	{
		self.var_73F5 = 30;
	}

	self.var_DC4 = undefined;
	self notify("move_loop_restart");
}

//Function Number: 767
in_alien_mode()
{
	if(isdefined(level.alien_mode) && level.alien_mode == 1)
	{
		return 1;
	}

	return 0;
}

//Function Number: 768
func_8259(param_00)
{
	loadtransient(param_00);
	while(!istransientloaded(param_00))
	{
		wait(0.1);
	}

	common_scripts\utility::flag_set(param_00 + "_loaded");
}

//Function Number: 769
func_825D(param_00)
{
	unloadtransient(param_00);
	while(istransientloaded(param_00))
	{
		wait(0.1);
	}

	common_scripts\utility::func_337C(param_00 + "_loaded");
}

//Function Number: 770
func_8258(param_00)
{
	common_scripts\utility::func_3385(param_00 + "_loaded");
}

//Function Number: 771
func_825B(param_00,param_01)
{
	if(common_scripts\utility::flag(param_00 + "_loaded"))
	{
		func_825D(param_00);
	}

	if(!common_scripts\utility::flag(param_01 + "_loaded"))
	{
		func_8259(param_01);
	}
}

//Function Number: 772
func_825E(param_00)
{
	unloadalltransients();
	func_8259(param_00);
}

//Function Number: 773
deep_array_call(param_00,param_01,param_02)
{
	if(!isdefined(param_02))
	{
		foreach(var_04 in param_00)
		{
			if(isdefined(var_04))
			{
				if(isarray(var_04))
				{
					deep_array_call(var_04,param_01);
					continue;
				}

				var_04 [[ param_01 ]]();
			}
		}
	}

	switch(var_05.size)
	{
		case 0:
			foreach(var_06 in var_03)
			{
				if(isdefined(var_06))
				{
					if(isarray(var_06))
					{
						deep_array_call(var_06,var_03,var_04);
						continue;
					}
	
					var_06 [[ var_03 ]]();
				}
			}
			break;

		case 1:
			foreach(var_08 in param_02)
			{
				if(isdefined(var_08))
				{
					if(isarray(var_08))
					{
						deep_array_call(var_08,param_02,var_03);
						continue;
					}
	
					var_08 [[ param_02 ]](var_03[0]);
				}
			}
			break;

		case 2:
			foreach(var_04 in param_01)
			{
				if(isdefined(var_04))
				{
					if(isarray(var_04))
					{
						deep_array_call(var_04,param_02,var_03);
						continue;
					}
	
					var_04 [[ param_02 ]](var_03[0],var_03[1]);
				}
			}
			break;

		case 3:
			foreach(var_04 in param_01)
			{
				if(isdefined(var_04))
				{
					if(isarray(var_04))
					{
						deep_array_call(var_04,param_02,var_03);
						continue;
					}
	
					var_04 [[ param_02 ]](var_03[0],var_03[1],var_03[2]);
				}
			}
			break;

		case 4:
			foreach(var_04 in param_01)
			{
				if(isdefined(var_04))
				{
					if(isarray(var_04))
					{
						deep_array_call(var_04,param_02,var_03);
						continue;
					}
	
					var_04 [[ param_02 ]](var_03[0],var_03[1],var_03[2],var_03[3]);
				}
			}
			break;

		case 5:
			foreach(var_04 in param_01)
			{
				if(isdefined(var_04))
				{
					if(isarray(var_04))
					{
						deep_array_call(var_04,param_02,var_03);
						continue;
					}
	
					var_04 [[ param_02 ]](var_03[0],var_03[1],var_03[2],var_03[3],var_03[4]);
				}
			}
			break;
	}
}

//Function Number: 774
deep_array_thread(param_00,param_01,param_02)
{
	if(!isdefined(param_02))
	{
		foreach(var_04 in param_00)
		{
			if(isdefined(var_04))
			{
				if(isarray(var_04))
				{
					deep_array_thread(var_04,param_01,param_02);
					continue;
				}

				var_04 thread [[ param_01 ]]();
			}
		}
	}

	switch(var_05.size)
	{
		case 0:
			foreach(var_06 in var_03)
			{
				if(isdefined(var_06))
				{
					if(isarray(var_06))
					{
						deep_array_thread(var_06,var_03,var_04);
						continue;
					}
	
					var_06 thread [[ var_03 ]]();
				}
			}
			break;

		case 1:
			foreach(var_08 in param_02)
			{
				if(isdefined(var_08))
				{
					if(isarray(var_08))
					{
						deep_array_thread(var_08,param_02,var_03);
						continue;
					}
	
					var_08 thread [[ param_02 ]](var_03[0]);
				}
			}
			break;

		case 2:
			foreach(var_04 in param_01)
			{
				if(isdefined(var_04))
				{
					if(isarray(var_04))
					{
						deep_array_thread(var_04,param_02,var_03);
						continue;
					}
	
					var_04 thread [[ param_02 ]](var_03[0],var_03[1]);
				}
			}
			break;

		case 3:
			foreach(var_04 in param_01)
			{
				if(isdefined(var_04))
				{
					if(isarray(var_04))
					{
						deep_array_thread(var_04,param_02,var_03);
						continue;
					}
	
					var_04 thread [[ param_02 ]](var_03[0],var_03[1],var_03[2]);
				}
			}
			break;

		case 4:
			foreach(var_04 in param_01)
			{
				if(isdefined(var_04))
				{
					if(isarray(var_04))
					{
						deep_array_thread(var_04,param_02,var_03);
						continue;
					}
	
					var_04 thread [[ param_02 ]](var_03[0],var_03[1],var_03[2],var_03[3]);
				}
			}
			break;

		case 5:
			foreach(var_04 in param_01)
			{
				if(isdefined(var_04))
				{
					if(isarray(var_04))
					{
						deep_array_thread(var_04,param_02,var_03);
						continue;
					}
	
					var_04 thread [[ param_02 ]](var_03[0],var_03[1],var_03[2],var_03[3],var_03[4]);
				}
			}
			break;
	}
}

//Function Number: 775
func_7026(param_00,param_01,param_02)
{
	if(!isdefined(level.console))
	{
		set_console_status();
	}

	if(func_47F6())
	{
		setdvar(param_00,param_02);
	}

	setdvar(param_00,param_01);
}

//Function Number: 776
func_70BD(param_00,param_01,param_02)
{
	if(!isdefined(level.console))
	{
		set_console_status();
	}

	if(func_47F6())
	{
		setsaveddvar(param_00,param_02);
	}

	setsaveddvar(param_00,param_01);
}

//Function Number: 777
func_3490(param_00,param_01)
{
	self endon("death");
	self endon("stop_path");
	self notify("stop_going_to_node");
	self notify("follow_path");
	self endon("follow_path");
	wait(0.1);
	var_02 = param_00;
	var_03 = undefined;
	var_04 = undefined;
	if(!isdefined(param_01))
	{
		param_01 = 300;
	}

	self.current_follow_path = var_02;
	var_02 script_delay();
	while(isdefined(var_02))
	{
		self.current_follow_path = var_02;
		if(isdefined(var_02.lookahead))
		{
			break;
		}

		if(isdefined(level.struct_class_names["targetname"][var_02.targetname]))
		{
			var_04 = ::follow_path_animate_set_struct;
		}
		else if(isdefined(var_02.classname))
		{
			var_04 = ::follow_path_animate_set_ent;
		}
		else
		{
			var_04 = ::follow_path_animate_set_node;
		}

		if(isdefined(var_02.radius) && var_02.radius != 0)
		{
			self.goalradius = var_02.radius;
		}

		if(self.goalradius < 16)
		{
			self.goalradius = 16;
		}

		if(isdefined(var_02.height) && var_02.height != 0)
		{
			self.goalheight = var_02.height;
		}

		var_05 = self.goalradius;
		self childthread [[ var_04 ]](var_02);
		if(isdefined(var_02.animation))
		{
			var_02 waittill(var_02.animation);
		}
		else
		{
			for(;;)
			{
				self waittill("goal");
				if(distance(var_02.origin,self.origin) < var_05 + 10 || self.team != "allies")
				{
					break;
				}
			}
		}

		var_02 notify("trigger",self);
		if(isdefined(var_02.script_flag_set))
		{
			common_scripts\utility::flag_set(var_02.script_flag_set);
		}

		if(isdefined(var_02.script_parameters))
		{
			var_06 = strtok(var_02.script_parameters," ");
			for(var_07 = 0;var_07 < var_06.size;var_07++)
			{
				if(isdefined(level.custom_followpath_parameter_func))
				{
					self [[ level.custom_followpath_parameter_func ]](var_06[var_07],var_02);
				}

				if(self.type == "dog")
				{
					continue;
				}

				switch(var_06[var_07])
				{
					case "enable_cqb":
						enable_cqbwalk();
						break;

					case "disable_cqb":
						disable_cqbwalk();
						break;

					case "deleteme":
						self delete();
						break;
				}
			}
		}

		if(!isdefined(var_02.var_6C8C) && param_01 > 0 && self.team == "allies")
		{
			while(isalive(level.player))
			{
				if(func_3494(var_02,param_01))
				{
					break;
				}

				if(isdefined(var_02.animation))
				{
					self.goalradius = var_05;
					self setgoalpos(self.origin);
				}

				wait(0.05);
			}
		}

		if(!isdefined(var_02.target))
		{
			break;
		}

		if(isdefined(var_02.var_6BC4))
		{
			common_scripts\utility::flag_wait(var_02.var_6BC4);
		}

		var_02 script_delay();
		var_02 = var_02 common_scripts\utility::func_39BD();
	}

	self notify("path_end_reached");
}

//Function Number: 778
func_3494(param_00,param_01)
{
	if(distance(level.player.origin,param_00.origin) < distance(self.origin,param_00.origin))
	{
		return 1;
	}

	var_02 = undefined;
	var_02 = anglestoforward(self.angles);
	var_03 = vectornormalize(level.player.origin - self.origin);
	if(isdefined(param_00.target))
	{
		var_04 = common_scripts\utility::func_39BD(param_00.target);
		var_02 = vectornormalize(var_04.origin - param_00.origin);
	}
	else if(isdefined(param_00.angles))
	{
		var_02 = anglestoforward(param_00.angles);
	}
	else
	{
		var_02 = anglestoforward(self.angles);
	}

	if(vectordot(var_02,var_03) > 0)
	{
		return 1;
	}

	if(distance(level.player.origin,self.origin) < param_01)
	{
		return 1;
	}

	return 0;
}

//Function Number: 779
follow_path_animate_set_node(param_00)
{
	self notify("follow_path_new_goal");
	if(isdefined(param_00.animation))
	{
		param_00 maps\_anim::anim_generic_reach(self,param_00.animation);
		self notify("starting_anim",param_00.animation);
		if(isdefined(param_00.script_parameters) && issubstr(param_00.script_parameters,"gravity"))
		{
			param_00 maps\_anim::func_D68(self,param_00.animation);
		}
		else
		{
			param_00 maps\_anim::anim_generic_run(self,param_00.animation);
		}

		self setgoalpos(self.origin);
	}

	func_6EF9(param_00);
}

//Function Number: 780
follow_path_animate_set_ent(param_00)
{
	self notify("follow_path_new_goal");
	if(isdefined(param_00.animation))
	{
		param_00 maps\_anim::anim_generic_reach(self,param_00.animation);
		self notify("starting_anim",param_00.animation);
		if(isdefined(param_00.script_parameters) && issubstr(param_00.script_parameters,"gravity"))
		{
			param_00 maps\_anim::func_D68(self,param_00.animation);
		}
		else
		{
			param_00 maps\_anim::anim_generic_run(self,param_00.animation);
		}

		self setgoalpos(self.origin);
	}

	func_6EF4(param_00);
}

//Function Number: 781
follow_path_animate_set_struct(param_00)
{
	self notify("follow_path_new_goal");
	if(isdefined(param_00.animation))
	{
		param_00 maps\_anim::anim_generic_reach(self,param_00.animation);
		self notify("starting_anim",param_00.animation);
		disable_exits();
		if(isdefined(param_00.script_parameters) && issubstr(param_00.script_parameters,"gravity"))
		{
			param_00 maps\_anim::func_D68(self,param_00.animation);
		}
		else
		{
			param_00 maps\_anim::anim_generic_run(self,param_00.animation);
		}

		func_252F(0.05,::func_2CB1);
		self setgoalpos(self.origin);
	}

	func_6EFB(param_00.origin);
}

//Function Number: 782
func_60C8(param_00)
{
	if(!isdefined(level.var_60C7))
	{
		level.var_60C7 = [];
	}

	level.var_60C7 = common_scripts\utility::array_add(level.var_60C7,param_00);
}

//Function Number: 783
game_is_current_gen()
{
	if(level.xenon)
	{
		return 1;
	}

	if(level.ps3)
	{
		return 1;
	}

	return 0;
}

//Function Number: 784
func_4D97(param_00,param_01)
{
	thread lerpfov_saved_thread(param_00,param_01);
}

//Function Number: 785
lerpfov_saved_thread(param_00,param_01)
{
	self notify("new_lerp_Fov_Saved");
	self endon("new_lerp_Fov_Saved");
	self lerpfov(param_00,param_01);
	wait(param_01);
	setsaveddvar("cg_fov",param_00);
}

//Function Number: 786
func_857D(param_00)
{
	var_01 = "ui_actionslot_" + param_00 + "_forceActive";
	setdvar(var_01,"on");
}

//Function Number: 787
ui_action_slot_force_active_off(param_00)
{
	var_01 = "ui_actionslot_" + param_00 + "_forceActive";
	setdvar(var_01,"turn_off");
}

//Function Number: 788
func_857E(param_00)
{
	var_01 = "ui_actionslot_" + param_00 + "_forceActive";
	setdvar(var_01,"onetime");
}

//Function Number: 789
func_4027(param_00,param_01)
{
	var_02 = getnumparts(param_00);
	for(var_03 = 0;var_03 < var_02;var_03++)
	{
		if(tolower(getpartname(param_00,var_03)) == tolower(param_01))
		{
			return 1;
		}
	}

	return 0;
}

//Function Number: 790
func_7D1F(param_00,param_01,param_02,param_03)
{
	if(!isarray(param_00))
	{
		param_00 = [param_00];
	}

	var_04 = 320;
	var_05 = 200;
	var_06 = [];
	foreach(var_0A, var_08 in param_00)
	{
		var_09 = maps\_introscreen::stylized_line(var_08,param_01,var_04,var_05 + var_0A * 20,"center",param_02,param_03);
		var_06 = common_scripts\utility::array_combine(var_09,var_06);
	}

	wait(param_01);
	maps\_introscreen::func_7D20(var_06,var_04,var_05,param_00.size);
}