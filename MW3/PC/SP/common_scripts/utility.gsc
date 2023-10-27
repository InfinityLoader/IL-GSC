/*******************************************************************
 * Decompiled By: Bog
 * Decompiled File: common_scripts\utility.gsc
 * Game: Call of Duty: Modern Warfare 3
 * Platform: PC
 * Function Count: 173
 * Decompile Time: 3019 ms
 * Timestamp: 10/27/2023 2:22:48 AM
*******************************************************************/

//Function Number: 1
scriptprintln(param_00,param_01)
{
}

//Function Number: 2
debugprintln(param_00,param_01)
{
}

//Function Number: 3
draw_debug_line(param_00,param_01,param_02)
{
	for(var_03 = 0;var_03 < param_02 * 20;var_03++)
	{
		wait 0.05;
	}
}

//Function Number: 4
waittillend(param_00)
{
	self waittillmatch("end",param_00);
}

//Function Number: 5
noself_func(param_00,param_01,param_02,param_03,param_04)
{
	if(!isdefined(level.func))
	{
		return;
	}

	if(!isdefined(level.func[param_00]))
	{
		return;
	}

	if(!isdefined(param_01))
	{
		[[ level.func[param_00] ]]();
		return;
	}

	if(!isdefined(param_02))
	{
		[[ level.func[param_00] ]](param_01);
		return;
	}

	if(!isdefined(param_03))
	{
		[[ level.func[param_00] ]](param_01,param_02);
		return;
	}

	if(!isdefined(param_04))
	{
		[[ level.func[param_00] ]](param_01,param_02,param_03);
		return;
	}

	[[ level.func[param_00] ]](param_01,param_02,param_03,param_04);
}

//Function Number: 6
self_func(param_00,param_01,param_02,param_03,param_04)
{
	if(!isdefined(level.func[param_00]))
	{
		return;
	}

	if(!isdefined(param_01))
	{
		self [[ level.func[param_00] ]]();
		return;
	}

	if(!isdefined(param_02))
	{
		self [[ level.func[param_00] ]](param_01);
		return;
	}

	if(!isdefined(param_03))
	{
		self [[ level.func[param_00] ]](param_01,param_02);
		return;
	}

	if(!isdefined(param_04))
	{
		self [[ level.func[param_00] ]](param_01,param_02,param_03);
		return;
	}

	self [[ level.func[param_00] ]](param_01,param_02,param_03,param_04);
}

//Function Number: 7
randomvector(param_00)
{
	return (randomfloat(param_00) - param_00 * 0.5,randomfloat(param_00) - param_00 * 0.5,randomfloat(param_00) - param_00 * 0.5);
}

//Function Number: 8
randomvectorrange(param_00,param_01)
{
	var_02 = randomfloatrange(param_00,param_01);
	if(randomint(2) == 0)
	{
		var_02 = var_02 * -1;
	}

	var_03 = randomfloatrange(param_00,param_01);
	if(randomint(2) == 0)
	{
		var_03 = var_03 * -1;
	}

	var_04 = randomfloatrange(param_00,param_01);
	if(randomint(2) == 0)
	{
		var_04 = var_04 * -1;
	}

	return (var_02,var_03,var_04);
}

//Function Number: 9
angle_dif(param_00,param_01)
{
	if(param_00 == param_01)
	{
		return 0;
	}

	while(param_01 > 360)
	{
		param_01 = param_01 - 360;
	}

	while(param_01 < 0)
	{
		param_01 = param_01 + 360;
	}

	while(param_00 > 360)
	{
		param_00 = param_00 - 360;
	}

	while(param_00 < 0)
	{
		param_00 = param_00 + 360;
	}

	var_02 = undefined;
	var_03 = undefined;
	if(param_01 > 180)
	{
		var_03 = 360 - param_01;
	}
	else
	{
		var_03 = param_01;
	}

	if(param_00 > 180)
	{
		var_02 = 360 - param_00;
	}
	else
	{
		var_02 = param_00;
	}

	var_04 = var_03 + var_02;
	var_05 = 0;
	if(param_01 > param_00)
	{
		var_05 = param_01 - param_00;
	}
	else
	{
		var_05 = param_00 - param_01;
	}

	if(var_05 < var_04)
	{
		return var_05;
	}

	return var_04;
}

//Function Number: 10
sign(param_00)
{
	if(param_00 >= 0)
	{
		return 1;
	}

	return -1;
}

//Function Number: 11
track(param_00)
{
	if(isdefined(self.var_8BA))
	{
		if(param_00 == self.var_8BA)
		{
			return;
		}
	}

	self.var_8BA = param_00;
}

//Function Number: 12
get_enemy_team(param_00)
{
	var_01 = [];
	return var_7B[var_01];
}

//Function Number: 13
clear_exception(param_00)
{
	self.var_8BE[param_00] = level.var_8BD;
}

//Function Number: 14
set_exception(param_00,param_01)
{
	self.var_8BE[param_00] = param_01;
}

//Function Number: 15
set_all_exceptions(param_00)
{
	var_01 = getarraykeys(self.var_8BE);
	for(var_02 = 0;var_02 < var_01.size;var_02++)
	{
		self.var_8BE[var_01[var_02]] = param_00;
	}
}

//Function Number: 16
cointoss()
{
	return randomint(100) >= 50;
}

//Function Number: 17
choose_from_weighted_array(param_00,param_01)
{
	var_02 = randomint(param_01[param_01.size - 1] + 1);
	for(var_03 = 0;var_03 < param_01.size;var_03++)
	{
		if(var_02 <= param_01[var_03])
		{
			return param_00[var_03];
		}
	}
}

//Function Number: 18
get_cumulative_weights(param_00)
{
	var_01 = [];
	var_02 = 0;
	for(var_03 = 0;var_03 < param_00.size;var_03++)
	{
		var_02 = var_02 + param_00[var_03];
		var_01[var_03] = var_02;
	}

	return var_01;
}

//Function Number: 19
waittill_string(param_00,param_01)
{
	if(param_00 != "death")
	{
		self endon("death");
	}

	param_01 endon("die");
	self waittill(param_00);
	param_01 notify("returned",param_00);
}

//Function Number: 20
waittill_multiple(param_00,param_01,param_02,param_03,param_04)
{
	self endon("death");
	var_05 = spawnstruct();
	var_05.var_8C6 = 0;
	if(isdefined(param_00))
	{
		thread waittill_string(param_00,var_05);
		var_05.var_8C6++;
	}

	if(isdefined(param_01))
	{
		thread waittill_string(param_01,var_05);
		var_05.var_8C6++;
	}

	if(isdefined(param_02))
	{
		thread waittill_string(param_02,var_05);
		var_05.var_8C6++;
	}

	if(isdefined(param_03))
	{
		thread waittill_string(param_03,var_05);
		var_05.var_8C6++;
	}

	if(isdefined(param_04))
	{
		thread waittill_string(param_04,var_05);
		var_05.var_8C6++;
	}

	while(var_05.var_8C6)
	{
		var_05 waittill("returned");
		var_05.var_8C6--;
	}

	var_05 notify("die");
}

//Function Number: 21
waittill_multiple_ents(param_00,param_01,param_02,param_03,param_04,param_05,param_06,param_07)
{
	self endon("death");
	var_08 = spawnstruct();
	var_08.var_8C6 = 0;
	if(isdefined(param_00))
	{
		param_00 thread waittill_string(param_01,var_08);
		var_08.var_8C6++;
	}

	if(isdefined(param_02))
	{
		param_02 thread waittill_string(param_03,var_08);
		var_08.var_8C6++;
	}

	if(isdefined(param_04))
	{
		param_04 thread waittill_string(param_05,var_08);
		var_08.var_8C6++;
	}

	if(isdefined(param_06))
	{
		param_06 thread waittill_string(param_07,var_08);
		var_08.var_8C6++;
	}

	while(var_08.var_8C6)
	{
		var_08 waittill("returned");
		var_08.var_8C6--;
	}

	var_08 notify("die");
}

//Function Number: 22
waittill_any_return(param_00,param_01,param_02,param_03,param_04)
{
	if((!isdefined(param_00) || param_00 != "death") && !isdefined(param_01) || param_01 != "death" && !isdefined(param_02) || param_02 != "death" && !isdefined(param_03) || param_03 != "death" && !isdefined(param_04) || param_04 != "death")
	{
		self endon("death");
	}

	var_05 = spawnstruct();
	if(isdefined(param_00))
	{
		thread waittill_string(param_00,var_05);
	}

	if(isdefined(param_01))
	{
		thread waittill_string(param_01,var_05);
	}

	if(isdefined(param_02))
	{
		thread waittill_string(param_02,var_05);
	}

	if(isdefined(param_03))
	{
		thread waittill_string(param_03,var_05);
	}

	if(isdefined(param_04))
	{
		thread waittill_string(param_04,var_05);
	}

	var_05 waittill("returned",var_06);
	var_05 notify("die");
	return var_06;
}

//Function Number: 23
waittill_any_timeout(param_00,param_01,param_02,param_03,param_04,param_05)
{
	if((!isdefined(param_01) || param_01 != "death") && !isdefined(param_02) || param_02 != "death" && !isdefined(param_03) || param_03 != "death" && !isdefined(param_04) || param_04 != "death" && !isdefined(param_05) || param_05 != "death")
	{
		self endon("death");
	}

	var_06 = spawnstruct();
	if(isdefined(param_01))
	{
		thread waittill_string(param_01,var_06);
	}

	if(isdefined(param_02))
	{
		thread waittill_string(param_02,var_06);
	}

	if(isdefined(param_03))
	{
		thread waittill_string(param_03,var_06);
	}

	if(isdefined(param_04))
	{
		thread waittill_string(param_04,var_06);
	}

	if(isdefined(param_05))
	{
		thread waittill_string(param_05,var_06);
	}

	var_06 thread _timeout(param_00);
	var_06 waittill("returned",var_07);
	var_06 notify("die");
	return var_07;
}

//Function Number: 24
_timeout(param_00)
{
	self endon("die");
	wait param_00;
	self notify("returned","timeout");
}

//Function Number: 25
waittill_any(param_00,param_01,param_02,param_03,param_04,param_05,param_06,param_07)
{
	if(isdefined(param_01))
	{
		self endon(param_01);
	}

	if(isdefined(param_02))
	{
		self endon(param_02);
	}

	if(isdefined(param_03))
	{
		self endon(param_03);
	}

	if(isdefined(param_04))
	{
		self endon(param_04);
	}

	if(isdefined(param_05))
	{
		self endon(param_05);
	}

	if(isdefined(param_06))
	{
		self endon(param_06);
	}

	if(isdefined(param_07))
	{
		self endon(param_07);
	}

	self waittill(param_00);
}

//Function Number: 26
waittill_any_ents(param_00,param_01,param_02,param_03,param_04,param_05,param_06,param_07,param_08,param_09,param_0A,param_0B,param_0C,param_0D)
{
	if(isdefined(param_02) && isdefined(param_03))
	{
		param_02 endon(param_03);
	}

	if(isdefined(param_04) && isdefined(param_05))
	{
		param_04 endon(param_05);
	}

	if(isdefined(param_06) && isdefined(param_07))
	{
		param_06 endon(param_07);
	}

	if(isdefined(param_08) && isdefined(param_09))
	{
		param_08 endon(param_09);
	}

	if(isdefined(param_0A) && isdefined(param_0B))
	{
		param_0A endon(param_0B);
	}

	if(isdefined(param_0C) && isdefined(param_0D))
	{
		param_0C endon(param_0D);
	}

	param_00 waittill(param_01);
}

//Function Number: 27
isflashed()
{
	if(!isdefined(self.flashendtime))
	{
		return 0;
	}

	return gettime() < self.flashendtime;
}

//Function Number: 28
flag_exist(param_00)
{
	return isdefined(level.flag[param_00]);
}

//Function Number: 29
flag(param_00)
{
	return level.flag[param_00];
}

//Function Number: 30
init_flags()
{
	level.flag = [];
	level.flags_lock = [];
	level.generic_index = 0;
	if(!isdefined(level.sp_stat_tracking_func))
	{
		level.sp_stat_tracking_func = ::empty_init_func;
	}

	level.flag_struct = spawnstruct();
	level.flag_struct assign_unique_id();
}

//Function Number: 31
flag_init(param_00)
{
	if(!isdefined(level.flag))
	{
		init_flags();
	}

	level.flag[param_00] = 0;
	if(!isdefined(level.trigger_flags))
	{
		init_trigger_flags();
		level.trigger_flags[param_00] = [];
	}
	else if(!isdefined(level.trigger_flags[param_00]))
	{
		level.trigger_flags[param_00] = [];
	}

	if(issuffix(param_00,"aa_"))
	{
		thread [[ level.sp_stat_tracking_func ]](param_00);
	}
}

//Function Number: 32
empty_init_func(param_00)
{
}

//Function Number: 33
issuffix(param_00,param_01)
{
	if(param_01.size > param_00.size)
	{
		return 0;
	}

	for(var_02 = 0;var_02 < param_01.size;var_02++)
	{
		if(param_00[var_02] != param_01[var_02])
		{
			return 0;
		}
	}

	return 1;
}

//Function Number: 34
flag_set(param_00,param_01)
{
	level.flag[param_00] = 1;
	set_trigger_flag_permissions(param_00);
	if(isdefined(param_01))
	{
		level notify(param_00,param_01);
		return;
	}

	level notify(param_00);
}

//Function Number: 35
assign_unique_id()
{
	self.unique_id = "generic" + level.generic_index;
	level.generic_index++;
}

//Function Number: 36
flag_wait(param_00,param_01)
{
	var_02 = undefined;
	while(!flag(param_00))
	{
		var_02 = undefined;
		level waittill(param_00,var_02);
		if(isdefined(param_01) && flag(param_00,param_01))
		{
			break;
		}
	}

	if(isdefined(var_02))
	{
		return var_02;
	}
}

//Function Number: 37
flag_clear(param_00)
{
	if(!flag(param_00))
	{
		return;
	}

	level.flag[param_00] = 0;
	set_trigger_flag_permissions(param_00);
	level notify(param_00);
}

//Function Number: 38
flag_waitopen(param_00)
{
	while(flag(param_00))
	{
		level waittill(param_00);
	}
}

//Function Number: 39
waittill_either(param_00,param_01)
{
	self endon(param_00);
	self waittill(param_01);
}

//Function Number: 40
array_thread(param_00,param_01,param_02,param_03,param_04,param_05,param_06,param_07,param_08,param_09,param_0A)
{
	if(!isdefined(param_02))
	{
		foreach(var_0C in param_00)
		{
			var_0C thread [[ param_01 ]]();
		}

		return;
	}

	if(!isdefined(param_06))
	{
		foreach(var_0E in param_03)
		{
			var_0E thread [[ param_03 ]](param_04);
		}

		return;
	}

	if(!isdefined(param_09))
	{
		foreach(var_10 in param_05)
		{
			var_10 thread [[ param_05 ]](param_06,param_07);
		}

		return;
	}

	if(!isdefined(var_0C))
	{
		foreach(var_12 in param_07)
		{
			var_12 thread [[ param_07 ]](param_08,param_09,param_0A);
		}

		return;
	}

	if(!isdefined(var_0F))
	{
		foreach(var_14 in param_09)
		{
			var_14 thread [[ param_09 ]](param_0A,var_0B,var_0C,var_0D);
		}

		return;
	}

	if(!isdefined(var_12))
	{
		foreach(var_16 in var_0B)
		{
			var_16 thread [[ var_0B ]](var_0C,var_0D,var_0E,var_0F,var_10);
		}

		return;
	}

	if(!isdefined(var_15))
	{
		foreach(var_18 in var_0D)
		{
			var_18 thread [[ var_0D ]](var_0E,var_0F,var_10,var_11,var_12,var_13);
		}

		return;
	}

	if(!isdefined(var_18))
	{
		foreach(var_1A in var_0F)
		{
			var_1A thread [[ var_0F ]](var_10,var_11,var_12,var_13,var_14,var_15,var_16);
		}

		return;
	}

	if(!isdefined(var_1B))
	{
		foreach(var_1C in var_11)
		{
			var_1C thread [[ var_11 ]](var_12,var_13,var_14,var_15,var_16,var_17,var_18,var_19);
		}

		return;
	}

	foreach(var_1E in var_13)
	{
		var_1E thread [[ var_13 ]](var_14,var_15,var_16,var_17,var_18,var_19,var_1A,var_1B,var_1C);
	}
}

//Function Number: 41
array_call(param_00,param_01,param_02,param_03,param_04)
{
	if(isdefined(param_04))
	{
		foreach(var_06 in param_00)
		{
			var_06 [[ param_01 ]](param_02,param_03,param_04);
		}

		return;
	}

	if(isdefined(var_06))
	{
		foreach(var_08 in param_03)
		{
			var_08 [[ param_03 ]](param_04,var_05);
		}

		return;
	}

	if(isdefined(var_07))
	{
		foreach(var_0A in var_05)
		{
			var_0A [[ var_05 ]](var_06);
		}

		return;
	}

	foreach(var_0C in var_07)
	{
		var_0C [[ var_07 ]]();
	}
}

//Function Number: 42
array_thread4(param_00,param_01,param_02,param_03,param_04,param_05)
{
	array_thread(param_00,param_01,param_02,param_03,param_04,param_05);
}

//Function Number: 43
array_thread5(param_00,param_01,param_02,param_03,param_04,param_05,param_06)
{
	array_thread(param_00,param_01,param_02,param_03,param_04,param_05,param_06);
}

//Function Number: 44
trigger_on(param_00,param_01)
{
	if(isdefined(param_00) && isdefined(param_01))
	{
		var_02 = getentarray(param_00,param_01);
		array_thread(var_02,::trigger_on_proc);
		return;
	}

	trigger_on_proc();
}

//Function Number: 45
trigger_on_proc()
{
	if(isdefined(self.realorigin))
	{
		self.origin = self.realorigin;
	}

	self.trigger_off = undefined;
}

//Function Number: 46
trigger_off(param_00,param_01)
{
	if(isdefined(param_00) && isdefined(param_01))
	{
		var_02 = getentarray(param_00,param_01);
		array_thread(var_02,::trigger_off_proc);
		return;
	}

	trigger_off_proc();
}

//Function Number: 47
trigger_off_proc()
{
	if(!isdefined(self.realorigin))
	{
		self.realorigin = self.origin;
	}

	if(self.origin == self.realorigin)
	{
		self.origin = self.origin + (0,0,-10000);
	}

	self.trigger_off = 1;
}

//Function Number: 48
set_trigger_flag_permissions(param_00)
{
	if(!isdefined(level.trigger_flags))
	{
		return;
	}

	level.trigger_flags[param_00] = array_removeundefined(level.trigger_flags[param_00]);
	array_thread(level.trigger_flags[param_00],::update_trigger_based_on_flags);
}

//Function Number: 49
update_trigger_based_on_flags()
{
	var_00 = 1;
	if(isdefined(self.script_flag_true))
	{
		var_00 = 0;
		var_01 = create_flags_and_return_tokens(self.script_flag_true);
		foreach(var_03 in var_01)
		{
			if(flag(var_03))
			{
				var_00 = 1;
				break;
			}
		}
	}

	var_05 = 1;
	if(isdefined(self.script_flag_false))
	{
		var_01 = create_flags_and_return_tokens(self.script_flag_false);
		foreach(var_03 in var_01)
		{
			if(flag(var_03))
			{
				var_05 = 0;
				break;
			}
		}
	}

	[[ level.var_8EC[var_00 && var_05] ]]();
}

//Function Number: 50
create_flags_and_return_tokens(param_00)
{
	var_01 = strtok(param_00," ");
	for(var_02 = 0;var_02 < var_01.size;var_02++)
	{
		if(!isdefined(level.flag[var_01[var_02]]))
		{
			flag_init(var_01[var_02]);
		}
	}

	return var_01;
}

//Function Number: 51
init_trigger_flags()
{
	level.trigger_flags = [];
	level.var_8EC[1] = ::trigger_on;
	level.var_8EC[0] = ::trigger_off;
}

//Function Number: 52
getstruct(param_00,param_01)
{
	var_02 = level.struct_class_names[param_01][param_00];
	if(!isdefined(var_02))
	{
		return undefined;
	}

	if(var_02.size > 1)
	{
		return undefined;
	}

	return var_02[0];
}

//Function Number: 53
getstructarray(param_00,param_01)
{
	var_02 = level.struct_class_names[param_01][param_00];
	if(!isdefined(var_02))
	{
		return [];
	}

	return var_02;
}

//Function Number: 54
struct_class_init()
{
	level.struct_class_names = [];
	level.struct_class_names["target"] = [];
	level.struct_class_names["targetname"] = [];
	level.struct_class_names["script_noteworthy"] = [];
	level.struct_class_names["script_linkname"] = [];
	foreach(var_01 in level.struct)
	{
		if(isdefined(var_01.targetname))
		{
			if(!isdefined(level.struct_class_names["targetname"][var_01.targetname]))
			{
				level.struct_class_names["targetname"][var_01.targetname] = [];
			}

			var_02 = level.struct_class_names["targetname"][var_01.targetname].size;
			level.struct_class_names["targetname"][var_01.targetname][var_02] = var_01;
		}

		if(isdefined(var_01.target))
		{
			if(!isdefined(level.struct_class_names["target"][var_01.target]))
			{
				level.struct_class_names["target"][var_01.target] = [];
			}

			var_02 = level.struct_class_names["target"][var_01.target].size;
			level.struct_class_names["target"][var_01.target][var_02] = var_01;
		}

		if(isdefined(var_01.script_noteworthy))
		{
			if(!isdefined(level.struct_class_names["script_noteworthy"][var_01.script_noteworthy]))
			{
				level.struct_class_names["script_noteworthy"][var_01.script_noteworthy] = [];
			}

			var_02 = level.struct_class_names["script_noteworthy"][var_01.script_noteworthy].size;
			level.struct_class_names["script_noteworthy"][var_01.script_noteworthy][var_02] = var_01;
		}

		if(isdefined(var_01.script_linkname))
		{
			level.struct_class_names["script_linkname"][var_01.script_linkname][0] = var_01;
		}
	}
}

//Function Number: 55
fileprint_start(param_00)
{
}

//Function Number: 56
fileprint_map_start()
{
}

//Function Number: 57
fileprint_map_header(param_00)
{
	if(!isdefined(param_00))
	{
		param_00 = 0;
	}
}

//Function Number: 58
fileprint_map_keypairprint(param_00,param_01)
{
}

//Function Number: 59
fileprint_map_entity_start()
{
}

//Function Number: 60
fileprint_map_entity_end()
{
}

//Function Number: 61
fileprint_radiant_vec(param_00)
{
}

//Function Number: 62
array_remove(param_00,param_01)
{
	var_02 = [];
	foreach(var_04 in param_00)
	{
		if(var_04 != param_01)
		{
			var_02[var_02.size] = var_04;
		}
	}

	return var_02;
}

//Function Number: 63
array_remove_array(param_00,param_01)
{
	foreach(var_03 in param_01)
	{
		param_00 = array_remove(param_00,var_03);
	}

	return param_00;
}

//Function Number: 64
array_removeundefined(param_00)
{
	var_01 = [];
	foreach(var_03 in param_00)
	{
		if(!isdefined(var_03))
		{
			continue;
		}

		var_01[var_01.size] = var_03;
	}

	return var_01;
}

//Function Number: 65
array_levelthread(param_00,param_01,param_02,param_03,param_04)
{
	if(isdefined(param_04))
	{
		foreach(var_06 in param_00)
		{
			thread [[ param_01 ]](var_06,param_02,param_03,param_04);
		}

		return;
	}

	if(isdefined(var_06))
	{
		foreach(var_08 in param_03)
		{
			thread [[ param_03 ]](var_08,param_04,var_05);
		}

		return;
	}

	if(isdefined(var_07))
	{
		foreach(var_0A in var_05)
		{
			thread [[ var_05 ]](var_0A,var_06);
		}

		return;
	}

	foreach(var_0C in var_07)
	{
		thread [[ var_07 ]](var_0C);
	}
}

//Function Number: 66
array_levelcall(param_00,param_01,param_02,param_03,param_04)
{
	if(isdefined(param_04))
	{
		foreach(var_06 in param_00)
		{
			[[ param_01 ]](var_06,param_02,param_03,param_04);
		}

		return;
	}

	if(isdefined(var_06))
	{
		foreach(var_08 in param_03)
		{
			[[ param_03 ]](var_08,param_04,var_05);
		}

		return;
	}

	if(isdefined(var_07))
	{
		foreach(var_0A in var_05)
		{
			[[ var_05 ]](var_0A,var_06);
		}

		return;
	}

	foreach(var_0C in var_07)
	{
		[[ var_07 ]](var_0C);
	}
}

//Function Number: 67
add_to_array(param_00,param_01)
{
	if(!isdefined(param_01))
	{
		return param_00;
	}

	if(!isdefined(param_00))
	{
		param_00[0] = param_01;
	}
	else
	{
		param_00[param_00.size] = param_01;
	}

	return param_00;
}

//Function Number: 68
flag_assert(param_00)
{
}

//Function Number: 69
flag_wait_either(param_00,param_01)
{
	for(;;)
	{
		if(flag(param_00))
		{
			return;
		}

		if(flag(param_01))
		{
			return;
		}

		level waittill_either(param_00,param_01);
	}
}

//Function Number: 70
flag_wait_either_return(param_00,param_01)
{
	for(;;)
	{
		if(flag(param_00))
		{
			return param_00;
		}

		if(flag(param_01))
		{
			return param_01;
		}

		var_02 = level waittill_any_return(param_00,param_01);
		return var_02;
	}
}

//Function Number: 71
flag_wait_any(param_00,param_01,param_02,param_03,param_04,param_05)
{
	var_06 = [];
	if(isdefined(param_05))
	{
	}
	else if(isdefined(param_05))
	{
	}
	else if(isdefined(param_04))
	{
	}
	else if(isdefined(param_03))
	{
	}
	else if(isdefined(param_02))
	{
		flag_wait_either(param_01,param_02);
		return;
	}
	else
	{
		return;
	}

	for(;;)
	{
		var_07 = 0;
		while(var_07 < var_7B.size)
		{
			if(flag(var_7B[var_07]))
			{
				return;
			}

			var_07++ = var_7B[var_7B.size];
		}

		level waittill_any(param_01,param_02,param_03,param_04,param_05,var_06);
	}
}

//Function Number: 72
flag_wait_any_return(param_00,param_01,param_02,param_03,param_04)
{
	var_05 = [];
	if(isdefined(param_04))
	{
	}
	else if(isdefined(param_04))
	{
	}
	else if(isdefined(param_03))
	{
	}
	else if(isdefined(param_02))
	{
		var_06 = flag_wait_either_return(param_01,param_02);
		return var_06;
	}
	else
	{
		return;
	}

	for(;;)
	{
		var_07 = 0;
		while(var_07 < var_06.size)
		{
			if(flag(var_06[var_07]))
			{
				return var_06[var_07];
			}

			var_07++ = var_7B[var_7B.size];
		}

		var_06 = level waittill_any_return(param_02,param_03,param_04,var_05,var_7B);
		return var_07;
	}
}

//Function Number: 73
flag_wait_all(param_00,param_01,param_02,param_03)
{
	if(isdefined(param_00))
	{
		flag_wait(param_00);
	}

	if(isdefined(param_01))
	{
		flag_wait(param_01);
	}

	if(isdefined(param_02))
	{
		flag_wait(param_02);
	}

	if(isdefined(param_03))
	{
		flag_wait(param_03);
	}
}

//Function Number: 74
flag_wait_or_timeout(param_00,param_01)
{
	var_02 = param_01 * 1000;
	var_03 = gettime();
	for(;;)
	{
		if(flag(param_00))
		{
			break;
		}

		if(gettime() >= var_03 + var_02)
		{
			break;
		}

		var_04 = var_02 - gettime() - var_03;
		var_05 = var_04 / 1000;
		wait_for_flag_or_time_elapses(param_00,var_05);
	}
}

//Function Number: 75
flag_waitopen_or_timeout(param_00,param_01)
{
	var_02 = gettime();
	for(;;)
	{
		if(!flag(param_00))
		{
			break;
		}

		if(gettime() >= var_02 + param_01 * 1000)
		{
			break;
		}

		wait_for_flag_or_time_elapses(param_00,param_01);
	}
}

//Function Number: 76
wait_for_flag_or_time_elapses(param_00,param_01)
{
	level endon(param_00);
	wait param_01;
}

//Function Number: 77
delaycall(param_00,param_01,param_02,param_03,param_04,param_05,param_06,param_07,param_08,param_09)
{
	thread delaycall_proc(param_01,param_00,param_02,param_03,param_04,param_05,param_06,param_07,param_08,param_09);
}

//Function Number: 78
delaycall_proc(param_00,param_01,param_02,param_03,param_04,param_05,param_06,param_07,param_08,param_09)
{
	if(issp())
	{
		self endon("death");
	}

	wait param_01;
	if(isdefined(param_09))
	{
		self [[ param_00 ]](param_02,param_03,param_04,param_05,param_06,param_07,param_08,param_09);
		return;
	}

	if(isdefined(param_08))
	{
		self [[ param_00 ]](param_02,param_03,param_04,param_05,param_06,param_07,param_08);
		return;
	}

	if(isdefined(param_07))
	{
		self [[ param_00 ]](param_02,param_03,param_04,param_05,param_06,param_07);
		return;
	}

	if(isdefined(param_06))
	{
		self [[ param_00 ]](param_02,param_03,param_04,param_05,param_06);
		return;
	}

	if(isdefined(param_05))
	{
		self [[ param_00 ]](param_02,param_03,param_04,param_05);
		return;
	}

	if(isdefined(param_04))
	{
		self [[ param_00 ]](param_02,param_03,param_04);
		return;
	}

	if(isdefined(param_03))
	{
		self [[ param_00 ]](param_02,param_03);
		return;
	}

	if(isdefined(param_02))
	{
		self [[ param_00 ]](param_02);
		return;
	}

	self [[ param_00 ]]();
}

//Function Number: 79
noself_delaycall(param_00,param_01,param_02,param_03,param_04,param_05)
{
	thread noself_delaycall_proc(param_01,param_00,param_02,param_03,param_04,param_05);
}

//Function Number: 80
noself_delaycall_proc(param_00,param_01,param_02,param_03,param_04,param_05)
{
	wait param_01;
	if(isdefined(param_05))
	{
		[[ param_00 ]](param_02,param_03,param_04,param_05);
		return;
	}

	if(isdefined(param_04))
	{
		[[ param_00 ]](param_02,param_03,param_04);
		return;
	}

	if(isdefined(param_03))
	{
		[[ param_00 ]](param_02,param_03);
		return;
	}

	if(isdefined(param_02))
	{
		[[ param_00 ]](param_02);
		return;
	}

	[[ param_00 ]]();
}

//Function Number: 81
issp()
{
	if(!isdefined(level.issp))
	{
		level.issp = !string_starts_with(getdvar("mapname"),"mp_");
	}

	return level.issp;
}

//Function Number: 82
issp_towerdefense()
{
	if(!isdefined(level.issp_towerdefense))
	{
		level.issp_towerdefense = string_starts_with(getdvar("mapname"),"so_td_");
	}

	return level.issp_towerdefense;
}

//Function Number: 83
string_starts_with(param_00,param_01)
{
	if(param_00.size < param_01.size)
	{
		return 0;
	}

	for(var_02 = 0;var_02 < param_01.size;var_02++)
	{
		if(tolower(param_00[var_02]) != tolower(param_01[var_02]))
		{
			return 0;
		}
	}

	return 1;
}

//Function Number: 84
plot_points(param_00,param_01,param_02,param_03,param_04)
{
	var_05 = param_00[0];
	if(!isdefined(param_01))
	{
		param_01 = 1;
	}

	if(!isdefined(param_02))
	{
		param_02 = 1;
	}

	if(!isdefined(param_03))
	{
		param_03 = 1;
	}

	if(!isdefined(param_04))
	{
		param_04 = 0.05;
	}

	for(var_06 = 1;var_06 < param_00.size;var_06++)
	{
		thread draw_line_for_time(var_05,param_00[var_06],param_01,param_02,param_03,param_04);
		var_05 = param_00[var_06];
	}
}

//Function Number: 85
draw_line_for_time(param_00,param_01,param_02,param_03,param_04,param_05)
{
	param_05 = gettime() + param_05 * 1000;
	while(gettime() < param_05)
	{
		wait 0.05;
	}
}

//Function Number: 86
array_combine(param_00,param_01)
{
	var_02 = [];
	foreach(var_04 in param_00)
	{
		var_02[var_02.size] = var_04;
	}

	foreach(var_04 in param_01)
	{
		var_02[var_02.size] = var_04;
	}

	return var_02;
}

//Function Number: 87
flat_angle(param_00)
{
	var_01 = (0,param_00[1],0);
	return var_01;
}

//Function Number: 88
flat_origin(param_00)
{
	var_01 = (param_00[0],param_00[1],0);
	return var_01;
}

//Function Number: 89
draw_arrow_time(param_00,param_01,param_02,param_03)
{
	level endon("newpath");
	var_04 = [];
	var_05 = vectortoangles(param_00 - param_01);
	var_06 = anglestoright(var_05);
	var_07 = anglestoforward(var_05);
	var_08 = anglestoup(var_05);
	var_09 = distance(param_00,param_01);
	var_0A = [];
	var_0B = 0.1;
	var_0A[0] = param_00;
	var_0A[1] = param_00 + var_06 * var_09 * var_0B + var_07 * var_09 * -0.1;
	var_0A[2] = param_01;
	var_0A[3] = param_00 + var_06 * var_09 * -1 * var_0B + var_07 * var_09 * -0.1;
	var_0A[4] = param_00;
	var_0A[5] = param_00 + var_08 * var_09 * var_0B + var_07 * var_09 * -0.1;
	var_0A[6] = param_01;
	var_0A[7] = param_00 + var_08 * var_09 * -1 * var_0B + var_07 * var_09 * -0.1;
	var_0A[8] = param_00;
	var_0C = param_02[0];
	var_0D = param_02[1];
	var_0E = param_02[2];
	plot_points(var_0A,var_0C,var_0D,var_0E,param_03);
}

//Function Number: 90
get_linked_ents()
{
	var_00 = [];
	if(isdefined(self.script_linkto))
	{
		var_01 = get_links();
		foreach(var_03 in var_01)
		{
			var_04 = getentarray(var_03,"script_linkname");
			if(var_04.size > 0)
			{
				var_00 = array_combine(var_00,var_04);
			}
		}
	}

	return var_00;
}

//Function Number: 91
get_linked_vehicle_nodes()
{
	var_00 = [];
	if(isdefined(self.script_linkto))
	{
		var_01 = get_links();
		foreach(var_03 in var_01)
		{
			var_04 = getvehiclenodearray(var_03,"script_linkname");
			if(var_04.size > 0)
			{
				var_00 = array_combine(var_00,var_04);
			}
		}
	}

	return var_00;
}

//Function Number: 92
get_linked_ent()
{
	var_00 = get_linked_ents();
	return var_00[0];
}

//Function Number: 93
get_linked_vehicle_node()
{
	var_00 = get_linked_vehicle_nodes();
	return var_00[0];
}

//Function Number: 94
get_links()
{
	return strtok(self.script_linkto," ");
}

//Function Number: 95
run_thread_on_targetname(param_00,param_01,param_02,param_03,param_04)
{
	var_05 = getentarray(param_00,"targetname");
	array_thread(var_05,param_01,param_02,param_03,param_04);
	var_05 = getstructarray(param_00,"targetname");
	array_thread(var_05,param_01,param_02,param_03,param_04);
	var_05 = [[ level.getnodearrayfunction ]](param_00,"targetname");
	array_thread(var_05,param_01,param_02,param_03,param_04);
	var_05 = getvehiclenodearray(param_00,"targetname");
	array_thread(var_05,param_01,param_02,param_03,param_04);
}

//Function Number: 96
run_thread_on_noteworthy(param_00,param_01,param_02,param_03,param_04)
{
	var_05 = getentarray(param_00,"script_noteworthy");
	array_thread(var_05,param_01,param_02,param_03,param_04);
	var_05 = getstructarray(param_00,"script_noteworthy");
	array_thread(var_05,param_01,param_02,param_03,param_04);
	var_05 = [[ level.getnodearrayfunction ]](param_00,"script_noteworthy");
	array_thread(var_05,param_01,param_02,param_03,param_04);
	var_05 = getvehiclenodearray(param_00,"script_noteworthy");
	array_thread(var_05,param_01,param_02,param_03,param_04);
}

//Function Number: 97
draw_arrow(param_00,param_01,param_02)
{
	level endon("newpath");
	var_03 = [];
	var_04 = vectortoangles(param_00 - param_01);
	var_05 = anglestoright(var_04);
	var_06 = anglestoforward(var_04);
	var_07 = distance(param_00,param_01);
	var_08 = [];
	var_09 = 0.05;
	var_08[0] = param_00;
	var_08[1] = param_00 + var_05 * var_07 * var_09 + var_06 * var_07 * -0.2;
	var_08[2] = param_01;
	var_08[3] = param_00 + var_05 * var_07 * -1 * var_09 + var_06 * var_07 * -0.2;
	for(var_0A = 0;var_0A < 4;var_0A++)
	{
		var_0B = var_0A + 1;
		if(var_0B >= 4)
		{
			var_0B = 0;
		}
	}
}

//Function Number: 98
getfx(param_00)
{
	return level._effect[param_00];
}

//Function Number: 99
fxexists(param_00)
{
	return isdefined(level._effect[param_00]);
}

//Function Number: 100
print_csv_asset(param_00,param_01)
{
	var_02 = param_01 + "," + param_00;
	if(isdefined(level.var_924[var_02]))
	{
		return;
	}

	level.var_924[var_02] = 1;
}

//Function Number: 101
fileprint_csv_start(param_00)
{
}

//Function Number: 102
_loadfx(param_00)
{
	return loadfx(param_00);
}

//Function Number: 103
getlastweapon()
{
	return self.saved_lastweapon;
}

//Function Number: 104
playerunlimitedammothread()
{
}

//Function Number: 105
isusabilityenabled()
{
	return !self.disabledusability;
}

//Function Number: 106
_disableusability()
{
	self.disabledusability++;
	self disableusability();
}

//Function Number: 107
_enableusability()
{
	self.disabledusability--;
	if(!self.disabledusability)
	{
		self enableusability();
	}
}

//Function Number: 108
resetusability()
{
	self.disabledusability = 0;
	self enableusability();
}

//Function Number: 109
_disableweapon()
{
	self.disabledweapon++;
	self disableweapons();
}

//Function Number: 110
_enableweapon()
{
	self.disabledweapon--;
	if(!self.disabledweapon)
	{
		self enableweapons();
	}
}

//Function Number: 111
isweaponenabled()
{
	return !self.disabledweapon;
}

//Function Number: 112
_disableweaponswitch()
{
	self.disabledweaponswitch++;
	self disableweaponswitch();
}

//Function Number: 113
_enableweaponswitch()
{
	self.disabledweaponswitch--;
	if(!self.disabledweaponswitch)
	{
		self enableweaponswitch();
	}
}

//Function Number: 114
isweaponswitchenabled()
{
	return !self.disabledweaponswitch;
}

//Function Number: 115
_disableoffhandweapons()
{
	self.disabledoffhandweapons++;
	self disableoffhandweapons();
}

//Function Number: 116
_enableoffhandweapons()
{
	self.disabledoffhandweapons--;
	if(!self.disabledoffhandweapons)
	{
		self enableoffhandweapons();
	}
}

//Function Number: 117
isoffhandweaponenabled()
{
	return !self.disabledoffhandweapons;
}

//Function Number: 118
random(param_00)
{
	var_01 = [];
	foreach(var_03 in param_00)
	{
		var_01[var_01.size] = var_03;
	}

	if(!var_01.size)
	{
		return undefined;
	}

	return var_01[randomint(var_01.size)];
}

//Function Number: 119
spawn_tag_origin()
{
	var_00 = spawn("script_model",(0,0,0));
	var_00 setmodel("tag_origin");
	var_00 hide();
	if(isdefined(self.origin))
	{
		var_00.origin = self.origin;
	}

	if(isdefined(self.angles))
	{
		var_00.angles = self.angles;
	}

	return var_00;
}

//Function Number: 120
waittill_notify_or_timeout(param_00,param_01)
{
	self endon(param_00);
	wait param_01;
}

//Function Number: 121
fileprint_launcher_start_file()
{
	level.var_93E = 0;
	level.fileprint_launcher = 1;
	fileprint_launcher("GAMEPRINTSTARTFILE:");
}

//Function Number: 122
fileprint_launcher(param_00)
{
	level.var_93E++;
	if(level.var_93E > 200)
	{
		wait 0.05;
		level.var_93E = 0;
	}
}

//Function Number: 123
fileprint_launcher_end_file(param_00,param_01)
{
	if(!isdefined(param_01))
	{
		param_01 = 0;
	}

	if(param_01)
	{
		fileprint_launcher("GAMEPRINTENDFILE:GAMEPRINTP4ENABLED:" + param_00);
	}
	else
	{
		fileprint_launcher("GAMEPRINTENDFILE:" + param_00);
	}

	var_02 = gettime() + 4000;
	while(getdvarint("LAUNCHER_PRINT_SUCCESS") == 0 && getdvar("LAUNCHER_PRINT_FAIL") == "0" && gettime() < var_02)
	{
		wait 0.05;
	}

	if(!gettime() < var_02)
	{
		iprintlnbold("LAUNCHER_PRINT_FAIL:( TIMEOUT ): launcherconflict? restart launcher and try again? ");
		level.fileprint_launcher = undefined;
		return 0;
	}

	var_03 = getdvar("LAUNCHER_PRINT_FAIL");
	if(var_03 != "0")
	{
		iprintlnbold("LAUNCHER_PRINT_FAIL:( " + var_03 + " ): launcherconflict? restart launcher and try again? ");
		level.fileprint_launcher = undefined;
		return 0;
	}

	level.fileprint_launcher = undefined;
	return 1;
}

//Function Number: 124
launcher_write_clipboard(param_00)
{
	level.var_93E = 0;
	fileprint_launcher("LAUNCHER_CLIP:" + param_00);
}

//Function Number: 125
isdestructible()
{
	if(!isdefined(self))
	{
		return 0;
	}

	return isdefined(self.destructible_type);
}

//Function Number: 126
pauseeffect()
{
	common_scripts\_createfx::stop_fx_looper();
}

//Function Number: 127
activate_individual_exploder()
{
	if(isdefined(self.v["firefx"]))
	{
		thread fire_effect();
	}

	if(isdefined(self.v["fxid"]) && self.v["fxid"] != "No FX")
	{
		thread cannon_effect();
	}
	else if(isdefined(self.v["soundalias"]) && self.v["soundalias"] != "nil")
	{
		thread sound_effect();
	}

	if(isdefined(self.v["loopsound"]) && self.v["loopsound"] != "nil")
	{
		thread effect_loopsound();
	}

	if(isdefined(self.v["damage"]))
	{
		thread exploder_damage();
	}

	if(isdefined(self.v["earthquake"]))
	{
		thread exploder_earthquake();
	}

	if(isdefined(self.v["rumble"]))
	{
		thread exploder_rumble();
	}

	if(self.v["exploder_type"] == "exploder")
	{
		thread brush_show();
		return;
	}

	if(self.v["exploder_type"] == "exploderchunk" || self.v["exploder_type"] == "exploderchunk visible")
	{
		thread brush_throw();
		return;
	}

	thread brush_delete();
}

//Function Number: 128
waitframe()
{
	wait 0.05;
}

//Function Number: 129
brush_delete()
{
	var_00 = self.v["exploder"];
	if(isdefined(self.v["delay"]))
	{
		wait self.v["delay"];
	}
	else
	{
		wait 0.05;
	}

	if(!isdefined(self.model))
	{
		return;
	}

	if(isdefined(self.model.classname))
	{
		if(issp() && self.model.spawnflags & 1)
		{
			self.model [[ level.connectpathsfunction ]]();
		}
	}

	if(level.createfx_enabled)
	{
		if(isdefined(self.var_946))
		{
			return;
		}

		self.var_946 = 1;
		self.model hide();
		self.model notsolid();
		wait 3;
		self.var_946 = undefined;
		self.model show();
		self.model solid();
		return;
	}

	if(!isdefined(self.v["fxid"]) || self.v["fxid"] == "No FX")
	{
		self.v["exploder"] = undefined;
	}

	waittillframeend;
	if(isdefined(self.model) && isdefined(self.model.classname))
	{
		self.model delete();
	}
}

//Function Number: 130
brush_throw()
{
	if(isdefined(self.v["delay"]))
	{
		wait self.v["delay"];
	}

	var_00 = undefined;
	if(isdefined(self.v["target"]))
	{
		var_00 = get_target_ent(self.v["target"]);
	}

	if(!isdefined(var_00))
	{
		self.model delete();
		return;
	}

	self.model show();
	if(isdefined(self.v["delay_post"]))
	{
		wait self.v["delay_post"];
	}

	var_01 = self.v["origin"];
	var_02 = self.v["angles"];
	var_03 = var_00.origin;
	var_04 = var_03 - self.v["origin"];
	var_05 = var_04[0];
	var_06 = var_04[1];
	var_07 = var_04[2];
	var_08 = isdefined(self.v["physics"]);
	if(var_08)
	{
		var_09 = undefined;
		if(isdefined(var_00.target))
		{
			var_09 = var_00 get_target_ent();
		}

		if(!isdefined(var_09))
		{
			var_0A = var_01;
			var_0B = var_00.origin;
		}
		else
		{
			var_0A = var_02.origin;
			var_0B = var_0A.origin - var_01.origin * self.v["physics"];
		}

		self.model physicslaunchclient(var_0A,var_0B);
		return;
	}
	else
	{
		self.model rotatevelocity((var_08,var_09,var_0A),12);
		self.model movegravity((var_08,var_09,var_0A),12);
	}

	if(level.createfx_enabled)
	{
		if(isdefined(self.var_946))
		{
			return;
		}

		self.var_946 = 1;
		wait 3;
		self.var_946 = undefined;
		self.v["origin"] = var_04;
		self.v["angles"] = var_05;
		self.model hide();
		return;
	}

	self.v["exploder"] = undefined;
	wait 6;
	self.model delete();
}

//Function Number: 131
get_target_ent(param_00)
{
	if(!isdefined(param_00))
	{
		param_00 = self.target;
	}

	var_01 = getent(param_00,"targetname");
	if(isdefined(var_01))
	{
		return var_01;
	}

	if(issp())
	{
		var_01 = [[ level.getnodefunction ]](param_00,"targetname");
		if(isdefined(var_01))
		{
			return var_01;
		}
	}

	var_01 = getstruct(param_00,"targetname");
	if(isdefined(var_01))
	{
		return var_01;
	}

	var_01 = getvehiclenode(param_00,"targetname");
	if(isdefined(var_01))
	{
		return var_01;
	}
}

//Function Number: 132
brush_show()
{
	if(isdefined(self.v["delay"]))
	{
		wait self.v["delay"];
	}

	if(!isdefined(self.model.script_modelname))
	{
		self.model show();
		self.model solid();
	}
	else
	{
		var_00 = self.model spawn_tag_origin();
		if(isdefined(self.model.script_linkname))
		{
			var_00.script_linkname = self.model.script_linkname;
		}

		var_00 setmodel(self.model.script_modelname);
		var_00 show();
	}

	self.brush_shown = 1;
	if(issp() && !isdefined(self.model.script_modelname) && self.model.spawnflags & 1)
	{
		if(!isdefined(self.model.disconnect_paths))
		{
			self.model [[ level.connectpathsfunction ]]();
		}
		else
		{
			self.model [[ level.disconnectpathsfunction ]]();
		}
	}

	if(level.createfx_enabled)
	{
		if(isdefined(self.var_946))
		{
			return;
		}

		self.var_946 = 1;
		wait 3;
		self.var_946 = undefined;
		if(!isdefined(self.model.script_modelname))
		{
			self.model hide();
			self.model notsolid();
		}
	}
}

//Function Number: 133
exploder_earthquake()
{
	exploder_delay();
	do_earthquake(self.v["earthquake"],self.v["origin"]);
}

//Function Number: 134
do_earthquake(param_00,param_01)
{
	var_02 = level.earthquake[param_00];
	earthquake(var_02["magnitude"],var_02["duration"],param_01,var_02["radius"]);
}

//Function Number: 135
exploder_rumble()
{
	if(!issp())
	{
		return;
	}

	exploder_delay();
	level.player playrumbleonentity(self.v["rumble"]);
}

//Function Number: 136
exploder_delay()
{
	if(!isdefined(self.v["delay"]))
	{
		self.v["delay"] = 0;
	}

	var_00 = self.v["delay"];
	var_01 = self.v["delay"] + 0.001;
	if(isdefined(self.v["delay_min"]))
	{
		var_00 = self.v["delay_min"];
	}

	if(isdefined(self.v["delay_max"]))
	{
		var_01 = self.v["delay_max"];
	}

	if(var_00 > 0)
	{
		wait randomfloatrange(var_00,var_01);
	}
}

//Function Number: 137
exploder_damage()
{
	if(isdefined(self.v["delay"]))
	{
		var_00 = self.v["delay"];
	}
	else
	{
		var_00 = 0;
	}

	if(isdefined(self.v["damage_radius"]))
	{
		var_01 = self.v["damage_radius"];
	}
	else
	{
		var_01 = 128;
	}

	var_02 = self.v["damage"];
	var_03 = self.v["origin"];
	wait var_00;
	radiusdamage(var_03,var_01,var_02,var_02);
}

//Function Number: 138
effect_loopsound()
{
	if(isdefined(self.var_956))
	{
		self.var_956 delete();
	}

	var_00 = self.v["origin"];
	var_01 = self.v["loopsound"];
	exploder_delay();
	self.var_956 = play_loopsound_in_space(var_01,var_00);
}

//Function Number: 139
play_loopsound_in_space(param_00,param_01)
{
	var_02 = spawn("script_origin",(0,0,0));
	if(!isdefined(param_01))
	{
		param_01 = self.origin;
	}

	var_02.origin = param_01;
	var_02 playloopsound(param_00);
	return var_02;
}

//Function Number: 140
sound_effect()
{
	effect_soundalias();
}

//Function Number: 141
effect_soundalias()
{
	var_00 = self.v["origin"];
	var_01 = self.v["soundalias"];
	exploder_delay();
	play_sound_in_space(var_01,var_00);
}

//Function Number: 142
play_sound_in_space(param_00,param_01,param_02)
{
	var_03 = spawn("script_origin",(0,0,1));
	if(!isdefined(param_01))
	{
		param_01 = self.origin;
	}

	var_03.origin = param_01;
	if(issp())
	{
		if(isdefined(param_02) && param_02)
		{
			var_03 playsoundasmaster(param_00,"sounddone");
		}
		else
		{
			var_03 playsound(param_00,"sounddone");
		}
	}
	else if(isdefined(param_02) && param_02)
	{
		var_03 playsoundasmaster(param_00);
	}
	else
	{
		var_03 playsound(param_00);
	}

	var_03 waittill("sounddone");
	var_03 delete();
}

//Function Number: 143
cannon_effect()
{
	if(isdefined(self.v["repeat"]))
	{
		thread exploder_playsound();
		for(var_00 = 0;var_00 < self.v["repeat"];var_00++)
		{
			playfx(level._effect[self.v["fxid"]],self.v["origin"],self.v["forward"],self.v["up"]);
			exploder_delay();
		}

		return;
	}

	exploder_delay();
	if(isdefined(self.looper))
	{
		self.looper delete();
	}

	self.looper = spawnfx(getfx(self.v["fxid"]),self.v["origin"],self.v["forward"],self.v["up"]);
	triggerfx(self.looper);
	exploder_playsound();
}

//Function Number: 144
exploder_playsound()
{
	if(!isdefined(self.v["soundalias"]) || self.v["soundalias"] == "nil")
	{
		return;
	}

	play_sound_in_space(self.v["soundalias"],self.v["origin"]);
}

//Function Number: 145
fire_effect()
{
	var_00 = self.v["forward"];
	var_01 = self.v["up"];
	var_02 = undefined;
	var_03 = self.v["firefxsound"];
	var_04 = self.v["origin"];
	var_05 = self.v["firefx"];
	var_06 = self.v["ender"];
	if(!isdefined(var_06))
	{
		var_06 = "createfx_effectStopper";
	}

	var_07 = self.v["firefxtimeout"];
	var_08 = 0.5;
	if(isdefined(self.v["firefxdelay"]))
	{
		var_08 = self.v["firefxdelay"];
	}

	exploder_delay();
	if(isdefined(var_03))
	{
		level thread loop_fx_sound(var_03,var_04,1,var_06,var_07);
	}

	playfx(level._effect[var_05],self.v["origin"],var_00,var_01);
}

//Function Number: 146
loop_fx_sound(param_00,param_01,param_02,param_03,param_04)
{
	if(isdefined(param_02) && param_02 == 1)
	{
		if(!isdefined(level.first_frame) || level.first_frame == 1)
		{
			spawnloopingsound(param_00,param_01);
			return;
		}

		return;
	}

	var_05 = spawn("script_origin",(0,0,0));
	if(isdefined(param_03))
	{
		thread loop_sound_delete(param_03,var_05);
		self endon(param_03);
	}

	var_05.origin = param_01;
	var_05 playloopsound(param_00);
	var_06 = 0;
	if(isdefined(level.createfx_enabled))
	{
		var_06 = level.createfx_enabled;
	}

	if(!isdefined(param_04) && !var_06)
	{
		var_05 willneverchange();
		return;
	}

	if(isdefined(param_04))
	{
		wait param_04;
	}
}

//Function Number: 147
loop_fx_sound_interval(param_00,param_01,param_02,param_03,param_04,param_05)
{
	var_06 = spawn("script_origin",(0,0,0));
	if(isdefined(param_02))
	{
		thread loop_sound_delete(param_02,var_06);
		self endon(param_02);
	}

	var_06.origin = param_01;
	if(param_04 >= param_05)
	{
		wait 0.05;
	}

	if(!soundexists(param_00))
	{
		wait 0.05;
	}

	for(;;)
	{
		lock("createfx_looper");
		thread play_sound_in_space(param_00,var_06.origin);
		eog_newstar("createfx_looper");
		wait randomfloatrange(param_04,param_05);
	}
}

//Function Number: 148
loop_sound_delete(param_00,param_01)
{
	param_01 endon("death");
	self waittill(param_00);
	param_01 delete();
}

//Function Number: 149
exploder_before_load(param_00)
{
	waittillframeend;
	waittillframeend;
	activate_exploder(param_00);
}

//Function Number: 150
exploder_after_load(param_00)
{
	activate_exploder(param_00);
}

//Function Number: 151
activate_exploder(param_00)
{
	param_00 = param_00 + "";
	level notify("exploding_" + param_00);
	if(isdefined(level.createfxexploders) && !level.createfx_enabled)
	{
		var_01 = level.createfxexploders[param_00];
		if(isdefined(var_01))
		{
			foreach(var_03 in var_01)
			{
				var_03 activate_individual_exploder();
			}

			return;
		}

		return;
	}

	var_05 = 0;
	while(var_03 < level.createfxent.size)
	{
		var_05 = level.createfxent[var_03];
		if(!isdefined(var_05))
		{
			continue;
		}

		if(var_05.v["type"] != "exploder")
		{
			continue;
		}

		if(!isdefined(var_05.v["exploder"]))
		{
			continue;
		}

		if(var_05.v["exploder"] + "" != var_02)
		{
			continue;
		}

		var_05 activate_individual_exploder();
		var_03++;
	}
}

//Function Number: 152
createloopeffect(param_00)
{
	var_01 = common_scripts\_createfx::createeffect("loopfx",param_00);
	var_01.v["delay"] = common_scripts\_createfx::getloopeffectdelaydefault();
	return var_01;
}

//Function Number: 153
createoneshoteffect(param_00)
{
	var_01 = common_scripts\_createfx::createeffect("oneshotfx",param_00);
	var_01.v["delay"] = common_scripts\_createfx::getoneshoteffectdelaydefault();
	return var_01;
}

//Function Number: 154
createexploder(param_00)
{
	var_01 = common_scripts\_createfx::createeffect("exploder",param_00);
	var_01.v["delay"] = common_scripts\_createfx::getexploderdelaydefault();
	var_01.v["exploder_type"] = "normal";
	return var_01;
}

//Function Number: 155
alphabetize(param_00)
{
	if(param_00.size <= 1)
	{
		return param_00;
	}

	var_01 = 0;
	for(var_02 = param_00.size - 1;var_02 >= 1;var_02--)
	{
		var_03 = param_00[var_02];
		var_04 = var_02;
		for(var_05 = 0;var_05 < var_02;var_05++)
		{
			var_06 = param_00[var_05];
			if(stricmp(var_06,var_03) > 0)
			{
				var_03 = var_06;
				var_04 = var_05;
			}
		}

		if(var_04 != var_02)
		{
			param_00[var_04] = param_00[var_02];
			param_00[var_02] = var_03;
		}
	}

	return param_00;
}

//Function Number: 156
is_later_in_alphabet(param_00,param_01)
{
	return stricmp(param_00,param_01) > 0;
}

//Function Number: 157
alphabet_compare(param_00,param_01)
{
	var_02 = [];
	var_03 = 1;
	var_02["0"] = var_03;
	var_03++;
	var_02["1"] = var_03;
	var_03++;
	var_02["2"] = var_03;
	var_03++;
	var_02["3"] = var_03;
	var_03++;
	var_02["4"] = var_03;
	var_03++;
	var_02["5"] = var_03;
	var_03++;
	var_02["6"] = var_03;
	var_03++;
	var_02["7"] = var_03;
	var_03++;
	var_02["8"] = var_03;
	var_03++;
	var_02["9"] = var_03;
	var_03++;
	var_02["_"] = var_03;
	var_03++;
	var_02["a"] = var_03;
	var_03++;
	var_02["b"] = var_03;
	var_03++;
	var_02["c"] = var_03;
	var_03++;
	var_02["d"] = var_03;
	var_03++;
	var_02["e"] = var_03;
	var_03++;
	var_02["f"] = var_03;
	var_03++;
	var_02["g"] = var_03;
	var_03++;
	var_02["h"] = var_03;
	var_03++;
	var_02["i"] = var_03;
	var_03++;
	var_02["j"] = var_03;
	var_03++;
	var_02["k"] = var_03;
	var_03++;
	var_02["l"] = var_03;
	var_03++;
	var_02["m"] = var_03;
	var_03++;
	var_02["n"] = var_03;
	var_03++;
	var_02["o"] = var_03;
	var_03++;
	var_02["p"] = var_03;
	var_03++;
	var_02["q"] = var_03;
	var_03++;
	var_02["r"] = var_03;
	var_03++;
	var_02["s"] = var_03;
	var_03++;
	var_02["t"] = var_03;
	var_03++;
	var_02["u"] = var_03;
	var_03++;
	var_02["v"] = var_03;
	var_03++;
	var_02["w"] = var_03;
	var_03++;
	var_02["x"] = var_03;
	var_03++;
	var_02["y"] = var_03;
	var_03++;
	var_02["z"] = var_03;
	var_03++;
	param_00 = tolower(param_00);
	param_01 = tolower(param_01);
	var_04 = 0;
	if(isdefined(var_02[param_00]))
	{
		var_04 = var_02[param_00];
	}

	var_05 = 0;
	if(isdefined(var_02[param_01]))
	{
		var_05 = var_02[param_01];
	}

	if(var_04 > var_05)
	{
		return "1st";
	}

	if(var_04 < var_05)
	{
		return "2nd";
	}

	return "same";
}

//Function Number: 158
play_loop_sound_on_entity(param_00,param_01)
{
	var_02 = spawn("script_origin",(0,0,0));
	var_02 endon("death");
	thread delete_on_death(var_02);
	if(isdefined(param_01))
	{
		var_02.origin = self.origin + param_01;
		var_02.angles = self.angles;
		var_02 linkto(self);
	}
	else
	{
		var_02.origin = self.origin;
		var_02.angles = self.angles;
		var_02 linkto(self);
	}

	var_02 playloopsound(param_00);
	self waittill("stop sound" + param_00);
	var_02 stoploopsound(param_00);
	var_02 delete();
}

//Function Number: 159
stop_loop_sound_on_entity(param_00)
{
	self notify("stop sound" + param_00);
}

//Function Number: 160
delete_on_death(param_00)
{
	param_00 endon("death");
	self waittill("death");
	if(isdefined(param_00))
	{
		param_00 delete();
	}
}

//Function Number: 161
error(param_00)
{
	waitframe();
}

//Function Number: 162
exploder(param_00)
{
	[[ level.var_7CD ]](param_00);
}

//Function Number: 163
create_dvar(param_00,param_01)
{
	setdvarifuninitialized(param_00,param_01);
}

//Function Number: 164
void()
{
}

//Function Number: 165
tag_project(param_00,param_01)
{
	var_02 = self gettagorigin(param_00);
	var_03 = self gettagangles(param_00);
	var_04 = anglestoforward(var_03);
	var_04 = vectornormalize(var_04) * param_01;
	return var_02 + var_04;
}

//Function Number: 166
ter_op(param_00,param_01,param_02)
{
	if(param_00)
	{
		return param_01;
	}

	return param_02;
}

//Function Number: 167
create_lock(param_00,param_01)
{
	if(!isdefined(param_01))
	{
		param_01 = 1;
	}

	if(!isdefined(level.lock))
	{
		level.lock = [];
	}

	var_02 = spawnstruct();
	var_02.var_96C = param_01;
	var_02.count = 0;
	level.lock[param_00] = var_02;
}

//Function Number: 168
lock(param_00)
{
	for(var_01 = level.lock[param_00];var_01.count >= var_01.var_96C;var_01 waittill("unlocked"))
	{
	}

	var_01.count++;
}

//Function Number: 169
is_locked(param_00)
{
	var_01 = level.lock[param_00];
	return var_01.count > var_01.var_96C;
}

//Function Number: 170
unlock_wait(param_00)
{
	thread unlock_thread(param_00);
	wait 0.05;
}

//Function Number: 171
eog_newstar(param_00)
{
	thread unlock_thread(param_00);
}

//Function Number: 172
unlock_thread(param_00)
{
	wait 0.05;
	var_01 = level.lock[param_00];
	var_01.count--;
	var_01 notify("unlocked");
}

//Function Number: 173
get_template_level()
{
	var_00 = level.script;
	if(isdefined(level.template_script))
	{
		var_00 = level.template_script;
	}

	return var_00;
}