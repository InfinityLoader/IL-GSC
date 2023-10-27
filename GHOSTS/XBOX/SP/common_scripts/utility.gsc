/*******************************************************************
 * Decompiled By: Bog
 * Decompiled File: common_scripts\utility.gsc
 * Game: Call of Duty: Ghosts
 * Platform: Console
 * Function Count: 196
 * Decompile Time: 3259 ms
 * Timestamp: 10/27/2023 1:39:05 AM
*******************************************************************/

//Function Number: 1
func_5685(param_00,param_01,param_02,param_03,param_04)
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

//Function Number: 2
self_func(param_00,param_01,param_02,param_03,param_04)
{
	if(!isdefined(level.func[param_00]))
	{
	}

	if(!isdefined(param_01))
	{
		self [[ level.func[param_00] ]]();
	}

	if(!isdefined(param_02))
	{
		self [[ level.func[param_00] ]](param_01);
	}

	if(!isdefined(param_03))
	{
		self [[ level.func[param_00] ]](param_01,param_02);
	}

	if(!isdefined(param_04))
	{
		self [[ level.func[param_00] ]](param_01,param_02,param_03);
	}

	self [[ level.func[param_00] ]](param_01,param_02,param_03,param_04);
}

//Function Number: 3
randomvector(param_00)
{
	return (randomfloat(param_00) - param_00 * 0.5,randomfloat(param_00) - param_00 * 0.5,randomfloat(param_00) - param_00 * 0.5);
}

//Function Number: 4
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

//Function Number: 5
sign(param_00)
{
	if(param_00 >= 0)
	{
		return 1;
	}

	return -1;
}

//Function Number: 6
mod(param_00,param_01)
{
	var_02 = castint(param_00 / param_01);
	if(param_00 * param_01 < 0)
	{
		var_02 = var_02 - 1;
	}

	return param_00 - var_02 * param_01;
}

//Function Number: 7
func_81E6(param_00)
{
	if(isdefined(self.current_target))
	{
		if(param_00 == self.current_target)
		{
		}
	}

	self.current_target = param_00;
}

//Function Number: 8
func_386F(param_00)
{
	var_01 = [];
	var_01["axis"] = "allies";
	var_01["allies"] = "axis";
	return var_01[param_00];
}

//Function Number: 9
clear_exception(param_00)
{
	self.exception[param_00] = level.defaultexception;
}

//Function Number: 10
func_6EB3(param_00,param_01)
{
	self.exception[param_00] = param_01;
}

//Function Number: 11
set_all_exceptions(param_00)
{
	var_01 = getarraykeys(self.exception);
	for(var_02 = 0;var_02 < var_01.size;var_02++)
	{
		self.exception[var_01[var_02]] = param_00;
	}
}

//Function Number: 12
func_1DE9()
{
	return randomint(100) >= 50;
}

//Function Number: 13
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

//Function Number: 14
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

//Function Number: 15
func_8B9E(param_00,param_01)
{
	if(param_00 != "death")
	{
		self endon("death");
	}

	param_01 endon("die");
	self waittill(param_00);
	param_01 notify("returned",param_00);
}

//Function Number: 16
func_8B9F(param_00,param_01)
{
	param_01 endon("die");
	self waittill(param_00);
	param_01 notify("returned",param_00);
}

//Function Number: 17
func_8B73(param_00,param_01,param_02,param_03,param_04)
{
	self endon("death");
	var_05 = addstruct();
	var_05.threads = 0;
	if(isdefined(param_00))
	{
		childthread func_8B9E(param_00,var_05);
		var_05.threads++;
	}

	if(isdefined(param_01))
	{
		childthread func_8B9E(param_01,var_05);
		var_05.threads++;
	}

	if(isdefined(param_02))
	{
		childthread func_8B9E(param_02,var_05);
		var_05.threads++;
	}

	if(isdefined(param_03))
	{
		childthread func_8B9E(param_03,var_05);
		var_05.threads++;
	}

	if(isdefined(param_04))
	{
		childthread func_8B9E(param_04,var_05);
		var_05.threads++;
	}

	while(var_05.threads)
	{
		var_05 waittill("returned");
		var_05.threads--;
	}

	var_05 notify("die");
}

//Function Number: 18
func_8B74(param_00,param_01,param_02,param_03,param_04,param_05,param_06,param_07)
{
	self endon("death");
	var_08 = addstruct();
	var_08.threads = 0;
	if(isdefined(param_00))
	{
		param_00 childthread func_8B9E(param_01,var_08);
		var_08.threads++;
	}

	if(isdefined(param_02))
	{
		param_02 childthread func_8B9E(param_03,var_08);
		var_08.threads++;
	}

	if(isdefined(param_04))
	{
		param_04 childthread func_8B9E(param_05,var_08);
		var_08.threads++;
	}

	if(isdefined(param_06))
	{
		param_06 childthread func_8B9E(param_07,var_08);
		var_08.threads++;
	}

	while(var_08.threads)
	{
		var_08 waittill("returned");
		var_08.threads--;
	}

	var_08 notify("die");
}

//Function Number: 19
func_8B33(param_00,param_01,param_02,param_03,param_04,param_05)
{
	if((!isdefined(param_00) || param_00 != "death") && !isdefined(param_01) || param_01 != "death" && !isdefined(param_02) || param_02 != "death" && !isdefined(param_03) || param_03 != "death" && !isdefined(param_04) || param_04 != "death" && !isdefined(param_05) || param_05 != "death")
	{
		self endon("death");
	}

	var_06 = addstruct();
	if(isdefined(param_00))
	{
		childthread func_8B9E(param_00,var_06);
	}

	if(isdefined(param_01))
	{
		childthread func_8B9E(param_01,var_06);
	}

	if(isdefined(param_02))
	{
		childthread func_8B9E(param_02,var_06);
	}

	if(isdefined(param_03))
	{
		childthread func_8B9E(param_03,var_06);
	}

	if(isdefined(param_04))
	{
		childthread func_8B9E(param_04,var_06);
	}

	if(isdefined(param_05))
	{
		childthread func_8B9E(param_05,var_06);
	}

	var_06 waittill("returned",var_07);
	var_06 notify("die");
	return var_07;
}

//Function Number: 20
waittill_any_return_no_endon_death(param_00,param_01,param_02,param_03,param_04,param_05)
{
	var_06 = addstruct();
	if(isdefined(param_00))
	{
		childthread func_8B9F(param_00,var_06);
	}

	if(isdefined(param_01))
	{
		childthread func_8B9F(param_01,var_06);
	}

	if(isdefined(param_02))
	{
		childthread func_8B9F(param_02,var_06);
	}

	if(isdefined(param_03))
	{
		childthread func_8B9F(param_03,var_06);
	}

	if(isdefined(param_04))
	{
		childthread func_8B9F(param_04,var_06);
	}

	if(isdefined(param_05))
	{
		childthread func_8B9F(param_05,var_06);
	}

	var_06 waittill("returned",var_07);
	var_06 notify("die");
	return var_07;
}

//Function Number: 21
func_8B2E(param_00)
{
	var_01 = addstruct();
	var_02 = 0;
	foreach(var_04 in param_00)
	{
		childthread func_8B9E(var_04,var_01);
		if(var_04 == "death")
		{
			var_02 = 1;
		}
	}

	if(!var_02)
	{
		self endon("death");
	}

	var_01 waittill("returned",var_06);
	var_01 notify("die");
	return var_06;
}

//Function Number: 22
waittill_any_in_array_return_no_endon_death(param_00)
{
	var_01 = addstruct();
	foreach(var_03 in param_00)
	{
		childthread func_8B9F(var_03,var_01);
	}

	var_01 waittill("returned",var_05);
	var_01 notify("die");
	return var_05;
}

//Function Number: 23
func_8B2C(param_00,param_01)
{
	var_02 = addstruct();
	var_03 = 0;
	foreach(var_05 in param_00)
	{
		childthread func_8B9E(var_05,var_02);
		if(var_05 == "death")
		{
			var_03 = 1;
		}
	}

	if(!var_03)
	{
		self endon("death");
	}

	var_02 childthread _timeout(param_01);
	var_02 waittill("returned",var_07);
	var_02 notify("die");
	return var_07;
}

//Function Number: 24
waittill_any_in_array_or_timeout_no_endon_death(param_00,param_01)
{
	var_02 = addstruct();
	foreach(var_04 in param_00)
	{
		childthread func_8B9F(var_04,var_02);
	}

	var_02 thread _timeout(param_01);
	var_02 waittill("returned",var_06);
	var_02 notify("die");
	return var_06;
}

//Function Number: 25
func_8B35(param_00,param_01,param_02,param_03,param_04,param_05,param_06)
{
	if((!isdefined(param_01) || param_01 != "death") && !isdefined(param_02) || param_02 != "death" && !isdefined(param_03) || param_03 != "death" && !isdefined(param_04) || param_04 != "death" && !isdefined(param_05) || param_05 != "death" && !isdefined(param_06) || param_06 != "death")
	{
		self endon("death");
	}

	var_07 = addstruct();
	if(isdefined(param_01))
	{
		childthread func_8B9E(param_01,var_07);
	}

	if(isdefined(param_02))
	{
		childthread func_8B9E(param_02,var_07);
	}

	if(isdefined(param_03))
	{
		childthread func_8B9E(param_03,var_07);
	}

	if(isdefined(param_04))
	{
		childthread func_8B9E(param_04,var_07);
	}

	if(isdefined(param_05))
	{
		childthread func_8B9E(param_05,var_07);
	}

	if(isdefined(param_06))
	{
		childthread func_8B9E(param_06,var_07);
	}

	var_07 childthread _timeout(param_00);
	var_07 waittill("returned",var_08);
	var_07 notify("die");
	return var_08;
}

//Function Number: 26
_timeout(param_00)
{
	self endon("die");
	wait(param_00);
	self notify("returned","timeout");
}

//Function Number: 27
func_8B36(param_00,param_01,param_02,param_03,param_04,param_05)
{
	var_06 = addstruct();
	if(isdefined(param_01))
	{
		childthread func_8B9F(param_01,var_06);
	}

	if(isdefined(param_02))
	{
		childthread func_8B9F(param_02,var_06);
	}

	if(isdefined(param_03))
	{
		childthread func_8B9F(param_03,var_06);
	}

	if(isdefined(param_04))
	{
		childthread func_8B9F(param_04,var_06);
	}

	if(isdefined(param_05))
	{
		childthread func_8B9F(param_05,var_06);
	}

	var_06 childthread _timeout(param_00);
	var_06 waittill("returned",var_07);
	var_06 notify("die");
	return var_07;
}

//Function Number: 28
func_8B2A(param_00,param_01,param_02,param_03,param_04,param_05,param_06,param_07)
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

//Function Number: 29
func_8B2B(param_00,param_01,param_02,param_03,param_04,param_05,param_06,param_07,param_08,param_09,param_0A,param_0B,param_0C,param_0D)
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

//Function Number: 30
isflashed()
{
	if(!isdefined(self.flashendtime))
	{
		return 0;
	}

	return gettime() < self.flashendtime;
}

//Function Number: 31
flag_exist(param_00)
{
	return isdefined(level.flag[param_00]);
}

//Function Number: 32
flag(param_00)
{
	return level.flag[param_00];
}

//Function Number: 33
func_4549()
{
	level.flag = [];
	level.flags_lock = [];
	level.generic_index = 0;
	if(!isdefined(level.sp_stat_tracking_func))
	{
		level.sp_stat_tracking_func = ::empty_init_func;
	}

	level.flag_struct = addstruct();
	level.flag_struct assign_unique_id();
}

//Function Number: 34
func_3385(param_00)
{
	if(!isdefined(level.flag))
	{
		func_4549();
	}

	level.flag[param_00] = 0;
	if(!isdefined(level.trigger_flags))
	{
		func_45C2();
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

//Function Number: 35
empty_init_func(param_00)
{
}

//Function Number: 36
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

//Function Number: 37
flag_set(param_00,param_01)
{
	level.flag[param_00] = 1;
	func_6FAF(param_00);
	if(isdefined(param_01))
	{
		level notify(param_00,param_01);
	}

	level notify(param_00);
}

//Function Number: 38
assign_unique_id()
{
	self.unique_id = "generic" + level.generic_index;
	level.generic_index++;
}

//Function Number: 39
flag_wait(param_00)
{
	var_01 = undefined;
	while(!flag(param_00))
	{
		var_01 = undefined;
		level waittill(param_00,var_01);
	}

	if(isdefined(var_01))
	{
		return var_01;
	}
}

//Function Number: 40
func_337C(param_00)
{
	if(!flag(param_00))
	{
	}

	level.flag[param_00] = 0;
	func_6FAF(param_00);
	level notify(param_00);
}

//Function Number: 41
func_33A0(param_00)
{
	while(flag(param_00))
	{
		level waittill(param_00);
	}
}

//Function Number: 42
func_8B4F(param_00,param_01)
{
	self endon(param_00);
	self waittill(param_01);
}

//Function Number: 43
func_0F1B(param_00,param_01,param_02,param_03,param_04,param_05,param_06,param_07,param_08,param_09,param_0A)
{
	if(!isdefined(param_02))
	{
		foreach(var_0C in param_00)
		{
			var_0C thread [[ param_01 ]]();
		}
	}

	if(!isdefined(param_06))
	{
		foreach(var_0E in param_03)
		{
			var_0E thread [[ param_03 ]](param_04);
		}
	}

	if(!isdefined(param_09))
	{
		foreach(var_10 in param_05)
		{
			var_10 thread [[ param_05 ]](param_06,param_07);
		}
	}

	if(!isdefined(var_0C))
	{
		foreach(var_12 in param_07)
		{
			var_12 thread [[ param_07 ]](param_08,param_09,param_0A);
		}
	}

	if(!isdefined(var_0F))
	{
		foreach(var_14 in param_09)
		{
			var_14 thread [[ param_09 ]](param_0A,var_0B,var_0C,var_0D);
		}
	}

	if(!isdefined(var_12))
	{
		foreach(var_16 in var_0B)
		{
			var_16 thread [[ var_0B ]](var_0C,var_0D,var_0E,var_0F,var_10);
		}
	}

	if(!isdefined(var_15))
	{
		foreach(var_18 in var_0D)
		{
			var_18 thread [[ var_0D ]](var_0E,var_0F,var_10,var_11,var_12,var_13);
		}
	}

	if(!isdefined(var_18))
	{
		foreach(var_1A in var_0F)
		{
			var_1A thread [[ var_0F ]](var_10,var_11,var_12,var_13,var_14,var_15,var_16);
		}
	}

	if(!isdefined(var_1B))
	{
		foreach(var_1C in var_11)
		{
			var_1C thread [[ var_11 ]](var_12,var_13,var_14,var_15,var_16,var_17,var_18,var_19);
		}
	}

	foreach(var_1E in var_13)
	{
		var_1E thread [[ var_13 ]](var_14,var_15,var_16,var_17,var_18,var_19,var_1A,var_1B,var_1C);
	}
}

//Function Number: 44
array_call(param_00,param_01,param_02,param_03,param_04)
{
	if(isdefined(param_04))
	{
		foreach(var_06 in param_00)
		{
			var_06 [[ param_01 ]](param_02,param_03,param_04);
		}
	}

	if(isdefined(var_06))
	{
		foreach(var_08 in param_03)
		{
			var_08 [[ param_03 ]](param_04,var_05);
		}
	}

	if(isdefined(var_07))
	{
		foreach(var_0A in var_05)
		{
			var_0A [[ var_05 ]](var_06);
		}
	}

	foreach(var_0C in var_07)
	{
		var_0C [[ var_07 ]]();
	}
}

//Function Number: 45
func_5682(param_00,param_01,param_02,param_03,param_04)
{
	if(isdefined(param_04))
	{
		foreach(var_06 in param_00)
		{
			[[ param_01 ]](var_06,param_02,param_03,param_04);
		}
	}

	if(isdefined(var_06))
	{
		foreach(var_08 in param_03)
		{
			[[ param_03 ]](var_08,param_04,var_05);
		}
	}

	if(isdefined(var_07))
	{
		foreach(var_0A in var_05)
		{
			[[ var_05 ]](var_0A,var_06);
		}
	}

	foreach(var_0C in var_07)
	{
		[[ var_07 ]](var_0C);
	}
}

//Function Number: 46
func_0F1C(param_00,param_01,param_02,param_03,param_04,param_05)
{
	func_0F1B(param_00,param_01,param_02,param_03,param_04,param_05);
}

//Function Number: 47
array_thread5(param_00,param_01,param_02,param_03,param_04,param_05,param_06)
{
	func_0F1B(param_00,param_01,param_02,param_03,param_04,param_05,param_06);
}

//Function Number: 48
func_837B(param_00,param_01)
{
	if(isdefined(param_00) && isdefined(param_01))
	{
		var_02 = getentarray(param_00,param_01);
		func_0F1B(var_02,::func_837D);
	}

	func_837D();
}

//Function Number: 49
func_837D()
{
	if(isdefined(self.realorigin))
	{
		self.origin = self.realorigin;
	}

	self.trigger_off = undefined;
}

//Function Number: 50
trigger_off(param_00,param_01)
{
	if(isdefined(param_00) && isdefined(param_01))
	{
		var_02 = getentarray(param_00,param_01);
		func_0F1B(var_02,::func_837A);
	}

	func_837A();
}

//Function Number: 51
func_837A()
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

//Function Number: 52
func_6FAF(param_00)
{
	if(!isdefined(level.trigger_flags))
	{
	}

	level.trigger_flags[param_00] = array_removeundefined(level.trigger_flags[param_00]);
	func_0F1B(level.trigger_flags[param_00],::func_86B9);
}

//Function Number: 53
func_86B9()
{
	var_00 = 1;
	if(isdefined(self.script_flag_true))
	{
		var_00 = 0;
		var_01 = func_2079(self.script_flag_true);
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
		var_01 = func_2079(self.script_flag_false);
		foreach(var_03 in var_01)
		{
			if(flag(var_03))
			{
				var_05 = 0;
				break;
			}
		}
	}

	[[ level.trigger_func[var_00 && var_05] ]]();
}

//Function Number: 54
func_2079(param_00)
{
	var_01 = strtok(param_00," ");
	for(var_02 = 0;var_02 < var_01.size;var_02++)
	{
		if(!isdefined(level.flag[var_01[var_02]]))
		{
			func_3385(var_01[var_02]);
		}
	}

	return var_01;
}

//Function Number: 55
func_45C2()
{
	level.trigger_flags = [];
	level.trigger_func[1] = ::func_837B;
	level.trigger_func[0] = ::trigger_off;
}

//Function Number: 56
func_3C18(param_00,param_01)
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

//Function Number: 57
func_3C1A(param_00,param_01)
{
	var_02 = level.struct_class_names[param_01][param_00];
	if(!isdefined(var_02))
	{
		return [];
	}

	return var_02;
}

//Function Number: 58
func_7CF9()
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
			if(!isdefined(level.struct_class_names["script_linkname"][var_01.script_linkname]))
			{
				level.struct_class_names["script_linkname"][var_01.script_linkname] = [];
			}

			var_02 = level.struct_class_names["script_linkname"][var_01.script_linkname].size;
			level.struct_class_names["script_linkname"][var_01.script_linkname][0] = var_01;
		}
	}
}

//Function Number: 59
func_322C(param_00)
{
}

//Function Number: 60
func_322A()
{
}

//Function Number: 61
func_3228(param_00)
{
	if(!isdefined(param_00))
	{
		param_00 = 0;
	}
}

//Function Number: 62
func_3229(param_00,param_01)
{
}

//Function Number: 63
fileprint_map_entity_start()
{
}

//Function Number: 64
fileprint_map_entity_end()
{
}

//Function Number: 65
func_322B(param_00)
{
}

//Function Number: 66
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

//Function Number: 67
array_remove_array(param_00,param_01)
{
	foreach(var_03 in param_01)
	{
		param_00 = array_remove(param_00,var_03);
	}

	return param_00;
}

//Function Number: 68
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

//Function Number: 69
array_remove_duplicates(param_00)
{
	var_01 = [];
	foreach(var_03 in param_00)
	{
		if(!isdefined(var_03))
		{
			continue;
		}

		var_04 = 1;
		foreach(var_06 in var_01)
		{
			if(var_03 == var_06)
			{
				var_04 = 0;
				break;
			}
		}

		if(var_04)
		{
			var_01[var_01.size] = var_03;
		}
	}

	return var_01;
}

//Function Number: 70
array_levelthread(param_00,param_01,param_02,param_03,param_04)
{
	if(isdefined(param_04))
	{
		foreach(var_06 in param_00)
		{
			thread [[ param_01 ]](var_06,param_02,param_03,param_04);
		}
	}

	if(isdefined(var_06))
	{
		foreach(var_08 in param_03)
		{
			thread [[ param_03 ]](var_08,param_04,var_05);
		}
	}

	if(isdefined(var_07))
	{
		foreach(var_0A in var_05)
		{
			thread [[ var_05 ]](var_0A,var_06);
		}
	}

	foreach(var_0C in var_07)
	{
		thread [[ var_07 ]](var_0C);
	}
}

//Function Number: 71
array_levelcall(param_00,param_01,param_02,param_03,param_04)
{
	if(isdefined(param_04))
	{
		foreach(var_06 in param_00)
		{
			[[ param_01 ]](var_06,param_02,param_03,param_04);
		}
	}

	if(isdefined(var_06))
	{
		foreach(var_08 in param_03)
		{
			[[ param_03 ]](var_08,param_04,var_05);
		}
	}

	if(isdefined(var_07))
	{
		foreach(var_0A in var_05)
		{
			[[ var_05 ]](var_0A,var_06);
		}
	}

	foreach(var_0C in var_07)
	{
		[[ var_07 ]](var_0C);
	}
}

//Function Number: 72
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

//Function Number: 73
func_337A(param_00)
{
}

//Function Number: 74
func_339B(param_00,param_01)
{
	for(;;)
	{
		if(flag(param_00))
		{
		}

		if(flag(param_01))
		{
		}

		level func_8B4F(param_00,param_01);
	}
}

//Function Number: 75
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

		var_02 = level func_8B33(param_00,param_01);
		return var_02;
	}
}

//Function Number: 76
flag_wait_any(param_00,param_01,param_02,param_03,param_04,param_05)
{
	var_06 = [];
	if(isdefined(param_05))
	{
		var_06[var_06.size] = param_00;
		var_06[var_06.size] = param_01;
		var_06[var_06.size] = param_02;
		var_06[var_06.size] = param_03;
		var_06[var_06.size] = param_04;
		var_06[var_06.size] = param_05;
	}
	else if(isdefined(param_04))
	{
		var_06[var_06.size] = param_00;
		var_06[var_06.size] = param_01;
		var_06[var_06.size] = param_02;
		var_06[var_06.size] = param_03;
		var_06[var_06.size] = param_04;
	}
	else if(isdefined(param_03))
	{
		var_06[var_06.size] = param_00;
		var_06[var_06.size] = param_01;
		var_06[var_06.size] = param_02;
		var_06[var_06.size] = param_03;
	}
	else if(isdefined(param_02))
	{
		var_06[var_06.size] = param_00;
		var_06[var_06.size] = param_01;
		var_06[var_06.size] = param_02;
	}
	else if(isdefined(param_01))
	{
		func_339B(param_00,param_01);
	}
	else
	{
	}

	for(;;)
	{
		for(var_07 = 0;var_07 < var_06.size;var_07++)
		{
			if(flag(var_06[var_07]))
			{
			}
		}

		level func_8B2A(param_00,param_01,param_02,param_03,param_04,param_05);
	}
}

//Function Number: 77
func_3398(param_00,param_01,param_02,param_03,param_04)
{
	var_05 = [];
	if(isdefined(param_04))
	{
		var_05[var_05.size] = param_00;
		var_05[var_05.size] = param_01;
		var_05[var_05.size] = param_02;
		var_05[var_05.size] = param_03;
		var_05[var_05.size] = param_04;
	}
	else if(isdefined(param_03))
	{
		var_05[var_05.size] = param_00;
		var_05[var_05.size] = param_01;
		var_05[var_05.size] = param_02;
		var_05[var_05.size] = param_03;
	}
	else if(isdefined(param_02))
	{
		var_05[var_05.size] = param_00;
		var_05[var_05.size] = param_01;
		var_05[var_05.size] = param_02;
	}
	else if(isdefined(param_01))
	{
		var_06 = flag_wait_either_return(param_00,param_01);
		return var_06;
	}
	else
	{
	}

	for(;;)
	{
		for(var_07 = 0;var_07 < var_06.size;var_07++)
		{
			if(flag(var_06[var_07]))
			{
				return var_06[var_07];
			}
		}

		var_06 = level func_8B33(param_01,param_02,param_03,param_04,var_05);
		return var_07;
	}
}

//Function Number: 78
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

//Function Number: 79
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
		func_8A81(param_00,var_05);
	}
}

//Function Number: 80
func_33A2(param_00,param_01)
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

		func_8A81(param_00,param_01);
	}
}

//Function Number: 81
func_8A81(param_00,param_01)
{
	level endon(param_00);
	wait(param_01);
}

//Function Number: 82
delaycall(param_00,param_01,param_02,param_03,param_04,param_05,param_06,param_07,param_08,param_09)
{
	thread delaycall_proc(param_01,param_00,param_02,param_03,param_04,param_05,param_06,param_07,param_08,param_09);
}

//Function Number: 83
delaycall_proc(param_00,param_01,param_02,param_03,param_04,param_05,param_06,param_07,param_08,param_09)
{
	if(issp())
	{
		self endon("death");
		self endon("stop_delay_call");
	}

	wait(param_01);
	if(isdefined(param_09))
	{
		self [[ param_00 ]](param_02,param_03,param_04,param_05,param_06,param_07,param_08,param_09);
	}

	if(isdefined(param_08))
	{
		self [[ param_00 ]](param_02,param_03,param_04,param_05,param_06,param_07,param_08);
	}

	if(isdefined(param_07))
	{
		self [[ param_00 ]](param_02,param_03,param_04,param_05,param_06,param_07);
	}

	if(isdefined(param_06))
	{
		self [[ param_00 ]](param_02,param_03,param_04,param_05,param_06);
	}

	if(isdefined(param_05))
	{
		self [[ param_00 ]](param_02,param_03,param_04,param_05);
	}

	if(isdefined(param_04))
	{
		self [[ param_00 ]](param_02,param_03,param_04);
	}

	if(isdefined(param_03))
	{
		self [[ param_00 ]](param_02,param_03);
	}

	if(isdefined(param_02))
	{
		self [[ param_00 ]](param_02);
	}

	self [[ param_00 ]]();
}

//Function Number: 84
func_5683(param_00,param_01,param_02,param_03,param_04,param_05)
{
	thread func_5684(param_01,param_00,param_02,param_03,param_04,param_05);
}

//Function Number: 85
func_5684(param_00,param_01,param_02,param_03,param_04,param_05)
{
	wait(param_01);
	if(isdefined(param_05))
	{
		[[ param_00 ]](param_02,param_03,param_04,param_05);
	}

	if(isdefined(param_04))
	{
		[[ param_00 ]](param_02,param_03,param_04);
	}

	if(isdefined(param_03))
	{
		[[ param_00 ]](param_02,param_03);
	}

	if(isdefined(param_02))
	{
		[[ param_00 ]](param_02);
	}

	[[ param_00 ]]();
}

//Function Number: 86
issp()
{
	if(!isdefined(level.issp))
	{
		level.issp = !string_starts_with(getdvar("mapname"),"mp_");
	}

	return level.issp;
}

//Function Number: 87
issp_towerdefense()
{
	if(!isdefined(level.issp_towerdefense))
	{
		level.issp_towerdefense = string_starts_with(getdvar("mapname"),"so_td_");
	}

	return level.issp_towerdefense;
}

//Function Number: 88
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

//Function Number: 89
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
		thread func_2A5C(var_05,param_00[var_06],param_01,param_02,param_03,param_04);
		var_05 = param_00[var_06];
	}
}

//Function Number: 90
func_2A5C(param_00,param_01,param_02,param_03,param_04,param_05)
{
	param_05 = gettime() + param_05 * 1000;
	while(gettime() < param_05)
	{
		wait(0.05);
	}
}

//Function Number: 91
func_7E48(param_00,param_01)
{
	var_02 = [];
	foreach(var_05, var_04 in param_00)
	{
		var_02[var_05] = var_04;
	}

	foreach(var_05, var_04 in param_01)
	{
		var_02[var_05] = var_04;
	}

	return var_02;
}

//Function Number: 92
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

//Function Number: 93
array_combine_non_integer_indices(param_00,param_01)
{
	var_02 = [];
	foreach(var_05, var_04 in param_00)
	{
		var_02[var_05] = var_04;
	}

	foreach(var_05, var_04 in param_01)
	{
		var_02[var_05] = var_04;
	}

	return var_02;
}

//Function Number: 94
array_randomize(param_00)
{
	for(var_01 = 0;var_01 < param_00.size;var_01++)
	{
		var_02 = randomint(param_00.size);
		var_03 = param_00[var_01];
		param_00[var_01] = param_00[var_02];
		param_00[var_02] = var_03;
	}

	return param_00;
}

//Function Number: 95
array_add(param_00,param_01)
{
	param_00[param_00.size] = param_01;
	return param_00;
}

//Function Number: 96
array_insert(param_00,param_01,param_02)
{
	if(param_02 == param_00.size)
	{
		var_03 = param_00;
		var_03[var_03.size] = param_01;
		return var_03;
	}

	var_03 = [];
	var_04 = 0;
	for(var_05 = 0;var_05 < param_00.size;var_05++)
	{
		if(var_05 == param_02)
		{
			var_03[var_05] = param_01;
			var_04 = 1;
		}

		var_03[var_05 + var_04] = param_00[var_05];
	}

	return var_03;
}

//Function Number: 97
array_contains(param_00,param_01)
{
	if(param_00.size <= 0)
	{
		return 0;
	}

	foreach(var_03 in param_00)
	{
		if(var_03 == param_01)
		{
			return 1;
		}
	}

	return 0;
}

//Function Number: 98
array_find(param_00,param_01)
{
	foreach(var_04, var_03 in param_00)
	{
		if(var_03 == param_01)
		{
			return var_04;
		}
	}

	return undefined;
}

//Function Number: 99
func_3415(param_00)
{
	var_01 = (0,param_00[1],0);
	return var_01;
}

//Function Number: 100
func_3417(param_00)
{
	var_01 = (param_00[0],param_00[1],0);
	return var_01;
}

//Function Number: 101
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

//Function Number: 102
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

//Function Number: 103
get_linked_vehicle_nodes()
{
	var_00 = [];
	if(isdefined(self.script_linkto))
	{
		var_01 = get_links();
		foreach(var_03 in var_01)
		{
			var_04 = getnodearray(var_03,"script_linkname");
			if(var_04.size > 0)
			{
				var_00 = array_combine(var_00,var_04);
			}
		}
	}

	return var_00;
}

//Function Number: 104
func_38D7()
{
	var_00 = get_linked_ents();
	return var_00[0];
}

//Function Number: 105
get_linked_vehicle_node()
{
	var_00 = get_linked_vehicle_nodes();
	return var_00[0];
}

//Function Number: 106
get_links()
{
	return strtok(self.script_linkto," ");
}

//Function Number: 107
func_697A(param_00,param_01,param_02,param_03,param_04)
{
	var_05 = getentarray(param_00,"targetname");
	func_0F1B(var_05,param_01,param_02,param_03,param_04);
	var_05 = func_3C1A(param_00,"targetname");
	func_0F1B(var_05,param_01,param_02,param_03,param_04);
	var_05 = [[ level.getnodearrayfunction ]](param_00,"targetname");
	func_0F1B(var_05,param_01,param_02,param_03,param_04);
	var_05 = getnodearray(param_00,"targetname");
	func_0F1B(var_05,param_01,param_02,param_03,param_04);
}

//Function Number: 108
func_6979(param_00,param_01,param_02,param_03,param_04)
{
	var_05 = getentarray(param_00,"script_noteworthy");
	func_0F1B(var_05,param_01,param_02,param_03,param_04);
	var_05 = func_3C1A(param_00,"script_noteworthy");
	func_0F1B(var_05,param_01,param_02,param_03,param_04);
	var_05 = [[ level.getnodearrayfunction ]](param_00,"script_noteworthy");
	func_0F1B(var_05,param_01,param_02,param_03,param_04);
	var_05 = getnodearray(param_00,"script_noteworthy");
	func_0F1B(var_05,param_01,param_02,param_03,param_04);
}

//Function Number: 109
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

//Function Number: 110
draw_entity_bounds(param_00,param_01,param_02,param_03,param_04)
{
	if(!isdefined(param_02))
	{
		param_02 = (0,1,0);
	}

	if(!isdefined(param_03))
	{
		param_03 = 0;
	}

	if(!isdefined(param_04))
	{
		param_04 = 0.05;
	}

	if(param_03)
	{
		var_05 = castint(param_04 / 0.05);
	}
	else
	{
		var_05 = castint(param_02 / 0.05);
	}

	var_06 = [];
	var_07 = [];
	var_08 = gettime();
	var_09 = var_08 + param_01 * 1000;
	while(var_08 < var_09 && isdefined(param_00))
	{
		var_06[0] = param_00 getpointinbounds(1,1,1);
		var_06[1] = param_00 getpointinbounds(1,1,-1);
		var_06[2] = param_00 getpointinbounds(-1,1,-1);
		var_06[3] = param_00 getpointinbounds(-1,1,1);
		var_07[0] = param_00 getpointinbounds(1,-1,1);
		var_07[1] = param_00 getpointinbounds(1,-1,-1);
		var_07[2] = param_00 getpointinbounds(-1,-1,-1);
		var_07[3] = param_00 getpointinbounds(-1,-1,1);
		for(var_0A = 0;var_0A < 4;var_0A++)
		{
			var_0B = var_0A + 1;
			if(var_0B == 4)
			{
				var_0B = 0;
			}
		}

		if(!param_03)
		{
		}

		wait(param_04);
		var_08 = gettime();
	}
}

//Function Number: 111
draw_volume(param_00,param_01,param_02,param_03,param_04)
{
	draw_entity_bounds(param_00,param_01,param_02,param_03,param_04);
}

//Function Number: 112
draw_trigger(param_00,param_01,param_02,param_03,param_04)
{
	draw_entity_bounds(param_00,param_01,param_02,param_03,param_04);
}

//Function Number: 113
func_3AB9(param_00)
{
	return level._effect[param_00];
}

//Function Number: 114
func_36C3(param_00)
{
	return isdefined(level._effect[param_00]);
}

//Function Number: 115
func_619A(param_00,param_01)
{
	var_02 = param_01 + "," + param_00;
	if(isdefined(level.csv_lines[var_02]))
	{
	}

	level.csv_lines[var_02] = 1;
}

//Function Number: 116
func_3222(param_00)
{
}

//Function Number: 117
func_3B0A()
{
	return self.saved_lastweapon;
}

//Function Number: 118
func_5FEB()
{
}

//Function Number: 119
func_4992()
{
	return !self.disabledusability;
}

//Function Number: 120
_disableusability()
{
	if(!isdefined(self.disabledusability))
	{
		self.disabledusability = 0;
	}

	self.disabledusability++;
	self disableusability();
}

//Function Number: 121
_enableusability()
{
	if(!isdefined(self.disabledusability))
	{
		self.disabledusability = 0;
	}

	if(self.disabledusability > 0)
	{
		self.disabledusability--;
		if(self.disabledusability == 0)
		{
			self enableusability();
		}
	}
}

//Function Number: 122
func_6623()
{
	self.disabledusability = 0;
	self enableusability();
}

//Function Number: 123
_disableweapon()
{
	if(!isdefined(self.disabledweapon))
	{
		self.disabledweapon = 0;
	}

	self.disabledweapon++;
	self disableweapons();
}

//Function Number: 124
_enableweapon()
{
	if(!isdefined(self.disabledweapon))
	{
		self.disabledweapon = 0;
	}

	self.disabledweapon--;
	if(!self.disabledweapon)
	{
		self enableweapons();
	}
}

//Function Number: 125
func_49B6()
{
	return !self.disabledweapon;
}

//Function Number: 126
_disableweaponswitch()
{
	if(!isdefined(self.var_27AB))
	{
		self.var_27AB = 0;
	}

	self.var_27AB++;
	self disableweaponswitch();
}

//Function Number: 127
_enableweaponswitch()
{
	if(!isdefined(self.var_27AB))
	{
		self.var_27AB = 0;
	}

	self.var_27AB--;
	if(!self.var_27AB)
	{
		self enableweaponswitch();
	}
}

//Function Number: 128
isweaponswitchenabled()
{
	return !self.var_27AB;
}

//Function Number: 129
_disableoffhandweapons()
{
	if(!isdefined(self.disabledoffhandweapons))
	{
		self.disabledoffhandweapons = 0;
	}

	self.disabledoffhandweapons++;
	self disableoffhandweapons();
}

//Function Number: 130
func_066F()
{
	if(!isdefined(self.disabledoffhandweapons))
	{
		self.disabledoffhandweapons = 0;
	}

	self.disabledoffhandweapons--;
	if(!self.disabledoffhandweapons)
	{
		self enableoffhandweapons();
	}
}

//Function Number: 131
isoffhandweaponenabled()
{
	return !self.disabledoffhandweapons;
}

//Function Number: 132
func_6306(param_00)
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

//Function Number: 133
random_weight_sorted(param_00)
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

	var_05 = randomint(var_01.size * var_01.size);
	return var_01[var_01.size - 1 - castint(sqrt(var_05))];
}

//Function Number: 134
func_7836()
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

//Function Number: 135
waittill_notify_or_timeout(param_00,param_01)
{
	self endon(param_00);
	wait(param_01);
}

//Function Number: 136
func_8B7E(param_00,param_01)
{
	self endon(param_00);
	wait(param_01);
	return "timeout";
}

//Function Number: 137
fileprint_launcher_start_file()
{
	level.fileprintlauncher_linecount = 0;
	level.fileprint_launcher = 1;
	fileprint_launcher("GAMEPRINTSTARTFILE:");
}

//Function Number: 138
fileprint_launcher(param_00)
{
	level.fileprintlauncher_linecount++;
	if(level.fileprintlauncher_linecount > 200)
	{
		wait(0.05);
		level.fileprintlauncher_linecount = 0;
	}
}

//Function Number: 139
func_3224(param_00,param_01)
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
		wait(0.05);
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

//Function Number: 140
func_4CFC(param_00)
{
	level.fileprintlauncher_linecount = 0;
	fileprint_launcher("LAUNCHER_CLIP:" + param_00);
}

//Function Number: 141
func_48AC()
{
	if(!isdefined(self))
	{
		return 0;
	}

	return isdefined(self.destructible_type);
}

//Function Number: 142
func_5B59()
{
	common_scripts\_createfx::func_7C2A();
}

//Function Number: 143
activate_individual_exploder()
{
	common_scripts\_exploder::activate_individual_exploder_proc();
}

//Function Number: 144
func_8AFE()
{
	wait(0.05);
}

//Function Number: 145
func_39BD(param_00)
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

	var_01 = func_3C18(param_00,"targetname");
	if(isdefined(var_01))
	{
		return var_01;
	}

	var_01 = getnode(param_00,"targetname");
	if(isdefined(var_01))
	{
		return var_01;
	}
}

//Function Number: 146
get_noteworthy_ent(param_00)
{
	var_01 = getent(param_00,"script_noteworthy");
	if(isdefined(var_01))
	{
		return var_01;
	}

	if(issp())
	{
		var_01 = [[ level.getnodefunction ]](param_00,"script_noteworthy");
		if(isdefined(var_01))
		{
			return var_01;
		}
	}

	var_01 = func_3C18(param_00,"script_noteworthy");
	if(isdefined(var_01))
	{
		return var_01;
	}

	var_01 = getnode(param_00,"script_noteworthy");
	if(isdefined(var_01))
	{
		return var_01;
	}
}

//Function Number: 147
do_earthquake(param_00,param_01)
{
	var_02 = level.earthquake[param_00];
	earthquake(var_02["magnitude"],var_02["duration"],param_01,var_02["radius"]);
}

//Function Number: 148
func_5CF6(param_00,param_01)
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

//Function Number: 149
func_5D20(param_00,param_01,param_02,param_03)
{
	var_04 = spawn("script_origin",(0,0,1));
	if(!isdefined(param_01))
	{
		param_01 = self.origin;
	}

	var_04.origin = param_01;
	var_04.angles = param_02;
	if(issp())
	{
		if(isdefined(param_03) && param_03)
		{
			var_04 playsoundasmaster(param_00,"sounddone");
		}
		else
		{
			var_04 playsound(param_00,"sounddone");
		}

		var_04 waittill("sounddone");
	}
	else if(isdefined(param_03) && param_03)
	{
		var_04 playsoundasmaster(param_00);
	}
	else
	{
		var_04 playsound(param_00);
	}

	var_04 delete();
}

//Function Number: 150
func_5D1F(param_00,param_01,param_02)
{
	func_5D20(param_00,param_01,(0,0,0),param_02);
}

//Function Number: 151
func_4F68(param_00,param_01,param_02,param_03,param_04)
{
	func_4F6B(param_00,param_01,(0,0,0),param_02,param_03,param_04);
}

//Function Number: 152
func_4F6B(param_00,param_01,param_02,param_03,param_04,param_05,param_06)
{
	if(isdefined(param_03) && param_03)
	{
		if(!isdefined(level.first_frame) || level.first_frame == 1)
		{
			spawnloopingsound(param_00,param_01,param_02);
		}
	}

	if(level.createfx_enabled && isdefined(param_05.loopsound_ent))
	{
		var_07 = param_05.loopsound_ent;
	}
	else
	{
		var_07 = spawn("script_origin",(0,0,0));
	}

	if(isdefined(param_04))
	{
		thread func_4F6F(param_04,var_07);
		self endon(param_04);
	}

	var_07.origin = param_01;
	var_07.angles = param_02;
	var_07 playloopsound(param_00);
	if(level.createfx_enabled)
	{
		param_05.loopsound_ent = var_07;
	}

	var_07 entitywillneverchange();
}

//Function Number: 153
func_4F69(param_00,param_01,param_02,param_03,param_04,param_05)
{
	func_4F6A(param_00,param_01,(0,0,0),param_02,param_03,param_04,param_05);
}

//Function Number: 154
func_4F6A(param_00,param_01,param_02,param_03,param_04,param_05,param_06)
{
	var_07 = spawn("script_origin",(0,0,0));
	if(isdefined(param_03))
	{
		thread func_4F6F(param_03,var_07);
		self endon(param_03);
	}

	var_07.origin = param_01;
	var_07.angles = param_02;
	if(param_05 >= param_06)
	{
		wait(0.05);
	}

	if(!soundexists(param_00))
	{
		wait(0.05);
	}

	for(;;)
	{
		wait(randomfloatrange(param_05,param_06));
		lock("createfx_looper");
		thread func_5D20(param_00,var_07.origin,var_07.angles,undefined);
		unlock("createfx_looper");
	}
}

//Function Number: 155
func_4F6F(param_00,param_01)
{
	param_01 endon("death");
	self waittill(param_00);
	param_01 delete();
}

//Function Number: 156
createloopeffect(param_00)
{
	var_01 = common_scripts\_createfx::createeffect("loopfx",param_00);
	var_01.var_880E["delay"] = common_scripts\_createfx::func_3B1B();
	return var_01;
}

//Function Number: 157
createoneshoteffect(param_00)
{
	var_01 = common_scripts\_createfx::createeffect("oneshotfx",param_00);
	var_01.var_880E["delay"] = common_scripts\_createfx::func_3B64();
	return var_01;
}

//Function Number: 158
createexploder(param_00)
{
	var_01 = common_scripts\_createfx::createeffect("exploder",param_00);
	var_01.var_880E["delay"] = common_scripts\_createfx::func_3AA4();
	var_01.var_880E["exploder_type"] = "normal";
	return var_01;
}

//Function Number: 159
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

//Function Number: 160
is_later_in_alphabet(param_00,param_01)
{
	return stricmp(param_00,param_01) > 0;
}

//Function Number: 161
func_5CF4(param_00,param_01)
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

//Function Number: 162
func_7C33(param_00)
{
	self notify("stop sound" + param_00);
}

//Function Number: 163
delete_on_death(param_00)
{
	param_00 endon("death");
	self waittill("death");
	if(isdefined(param_00))
	{
		param_00 delete();
	}
}

//Function Number: 164
error(param_00)
{
	func_8AFE();
}

//Function Number: 165
exploder(param_00,param_01,param_02)
{
	[[ level._fx.exploderfunction ]](param_00,param_01,param_02);
}

//Function Number: 166
create_dvar(param_00,param_01)
{
	setdvarifuninitialized(param_00,param_01);
}

//Function Number: 167
func_8A42()
{
}

//Function Number: 168
func_7E60(param_00,param_01)
{
	var_02 = self gettagorigin(param_00);
	var_03 = self gettagangles(param_00);
	var_04 = anglestoforward(var_03);
	var_04 = vectornormalize(var_04) * param_01;
	return var_02 + var_04;
}

//Function Number: 169
func_803F(param_00,param_01,param_02)
{
	if(param_00)
	{
		return param_01;
	}

	return param_02;
}

//Function Number: 170
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

	var_02 = addstruct();
	var_02.max_count = param_01;
	var_02.count = 0;
	level.lock[param_00] = var_02;
}

//Function Number: 171
func_4ECD(param_00)
{
	if(!isdefined(level.lock))
	{
		return 0;
	}

	return isdefined(level.lock[param_00]);
}

//Function Number: 172
lock(param_00)
{
	for(var_01 = level.lock[param_00];var_01.count >= var_01.max_count;var_01 waittill("unlocked"))
	{
	}

	var_01.count++;
}

//Function Number: 173
is_locked(param_00)
{
	var_01 = level.lock[param_00];
	return var_01.count > var_01.max_count;
}

//Function Number: 174
func_85C4(param_00)
{
	thread func_85C3(param_00);
	wait(0.05);
}

//Function Number: 175
unlock(param_00)
{
	thread func_85C3(param_00);
}

//Function Number: 176
func_85C3(param_00)
{
	wait(0.05);
	var_01 = level.lock[param_00];
	var_01.count--;
	var_01 notify("unlocked");
}

//Function Number: 177
func_39CA()
{
	var_00 = level.script;
	if(isdefined(level.template_script))
	{
		var_00 = level.template_script;
	}

	return var_00;
}

//Function Number: 178
func_4828()
{
	if(!level.console)
	{
		var_00 = self usinggamepad();
		if(isdefined(var_00))
		{
			return var_00;
		}
		else
		{
			return 0;
		}
	}

	return 1;
}

//Function Number: 179
array_reverse(param_00)
{
	var_01 = [];
	for(var_02 = param_00.size - 1;var_02 >= 0;var_02--)
	{
		var_01[var_01.size] = param_00[var_02];
	}

	return var_01;
}

//Function Number: 180
func_27FE(param_00,param_01)
{
	return length2dsquared(param_00 - param_01);
}

//Function Number: 181
get_array_of_farthest(param_00,param_01,param_02,param_03,param_04,param_05)
{
	var_06 = func_37D5(param_00,param_01,param_02,param_03,param_04,param_05);
	var_06 = array_reverse(var_06);
	return var_06;
}

//Function Number: 182
func_37D5(param_00,param_01,param_02,param_03,param_04,param_05)
{
	if(!isdefined(param_03))
	{
		param_03 = param_01.size;
	}

	if(!isdefined(param_02))
	{
		param_02 = [];
	}

	var_06 = undefined;
	if(isdefined(param_04))
	{
		var_06 = param_04 * param_04;
	}

	var_07 = 0;
	if(isdefined(param_05))
	{
		var_07 = param_05 * param_05;
	}

	if(param_02.size == 0 && param_03 >= param_01.size && var_07 == 0 && !isdefined(var_06))
	{
		return sortbydistance(param_01,param_00);
	}

	var_08 = [];
	foreach(var_0A in param_01)
	{
		var_0B = 0;
		foreach(var_0D in param_02)
		{
			if(var_0A == var_0D)
			{
				var_0B = 1;
				break;
			}
		}

		if(var_0B)
		{
			continue;
		}

		var_0F = distancesquared(param_00,var_0A.origin);
		if(isdefined(var_06) && var_0F > var_06)
		{
			continue;
		}

		if(var_0F < var_07)
		{
			continue;
		}

		var_08[var_08.size] = var_0A;
	}

	var_08 = sortbydistance(var_08,param_00);
	if(param_03 >= var_08.size)
	{
		return var_08;
	}

	var_11 = [];
	for(var_12 = 0;var_12 < param_03;var_12++)
	{
		var_11[var_12] = var_08[var_12];
	}

	return var_11;
}

//Function Number: 183
drop_to_ground(param_00,param_01,param_02)
{
	if(!isdefined(param_01))
	{
		param_01 = 1500;
	}

	if(!isdefined(param_02))
	{
		param_02 = -12000;
	}

	return physicstrace(param_00 + (0,0,param_01),param_00 + (0,0,param_02));
}

//Function Number: 184
add_destructible_type_function(param_00,param_01)
{
	if(!isdefined(level.destructible_functions))
	{
		level.destructible_functions = [];
	}

	level.destructible_functions[param_00] = param_01;
}

//Function Number: 185
func_088B(param_00,param_01)
{
	if(!isdefined(level.destructible_transient))
	{
		level.destructible_transient = [];
	}

	level.destructible_transient[param_00] = param_01;
}

//Function Number: 186
func_8E18(param_00,param_01,param_02,param_03)
{
	var_04 = vectornormalize(param_02 - param_00);
	var_05 = anglestoforward(param_01);
	var_06 = vectordot(var_05,var_04);
	return var_06 >= param_03;
}

//Function Number: 187
entity_path_disconnect_thread(param_00)
{
	self notify("entity_path_disconnect_thread");
	self endon("entity_path_disconnect_thread");
	self endon("death");
	level endon("game_ended");
	var_01 = 0;
	self.forcedisconnectuntil = 0;
	for(;;)
	{
		var_02 = self.origin;
		var_03 = func_8B35(param_00,"path_disconnect");
		var_04 = 0;
		var_05 = distancesquared(self.origin,var_02) > 0;
		if(var_05)
		{
			var_04 = 1;
		}

		if(isdefined(var_03) && var_03 == "path_disconnect")
		{
			var_04 = 1;
		}

		if(gettime() < self.forcedisconnectuntil)
		{
			var_04 = 1;
		}

		foreach(var_07 in level.characters)
		{
			if(isai(var_07) && distancesquared(self.origin,var_07.origin) < 250000)
			{
				var_04 = 1;
				self.forcedisconnectuntil = max(gettime() + 30000,self.forcedisconnectuntil);
			}
		}

		if(var_04 != var_01 || var_05)
		{
			if(var_04)
			{
				self disconnectpaths();
			}
			else
			{
				self connectpaths();
			}

			var_01 = var_04;
		}
	}
}

//Function Number: 188
func_5009(param_00,param_01)
{
	if(level.gametype == "aliens" && isdefined(level.aliens_make_entity_sentient_func))
	{
		return self [[ level.aliens_make_entity_sentient_func ]](param_00,param_01);
	}

	if(isdefined(level.bot_funcs) && isdefined(level.bot_funcs["bots_make_entity_sentient"]))
	{
		return self [[ level.bot_funcs["bots_make_entity_sentient"] ]](param_00,param_01);
	}
}

//Function Number: 189
ai_3d_sighting_model(param_00)
{
	if(isdefined(level.bot_funcs) && isdefined(level.bot_funcs["ai_3d_sighting_model"]))
	{
		return self [[ level.bot_funcs["ai_3d_sighting_model"] ]](param_00);
	}
}

//Function Number: 190
func_6E53(param_00,param_01,param_02)
{
	if(!isdefined(level.anim_prop_models))
	{
		level.anim_prop_models = [];
	}

	var_03 = tolower(getdvar("mapname"));
	var_04 = 1;
	if(string_starts_with(var_03,"mp_"))
	{
		var_04 = 0;
	}

	if(var_04)
	{
		level.anim_prop_models[param_00]["basic"] = param_01;
	}

	level.anim_prop_models[param_00]["basic"] = param_02;
}

//Function Number: 191
func_3A56(param_00,param_01,param_02)
{
	if(!isdefined(param_02))
	{
		param_02 = 500000;
	}

	var_03 = undefined;
	foreach(var_05 in param_01)
	{
		var_06 = distance(var_05.origin,param_00);
		if(var_06 >= param_02)
		{
			continue;
		}

		param_02 = var_06;
		var_03 = var_05;
	}

	return var_03;
}

//Function Number: 192
func_3AA8(param_00,param_01,param_02)
{
	if(!isdefined(param_02))
	{
		param_02 = 500000;
	}

	var_03 = 0;
	var_04 = undefined;
	foreach(var_06 in param_01)
	{
		var_07 = distance(var_06.origin,param_00);
		if(var_07 <= var_03 || var_07 >= param_02)
		{
			continue;
		}

		var_03 = var_07;
		var_04 = var_06;
	}

	return var_04;
}

//Function Number: 193
func_52B2(param_00,param_01,param_02)
{
	param_02 = func_803F(isdefined(param_02),param_02,(0,0,0));
	self missilesettargetent(param_00,param_02);
	switch(param_01)
	{
		case "direct":
			self missilesetflightmodedirect();
			break;

		case "top":
			self missilesetflightmodetop();
			break;
	}
}

//Function Number: 194
add_fx(param_00,param_01)
{
	if(!isdefined(level._effect))
	{
		level._effect = [];
	}

	level._effect[param_00] = loadfx(param_01);
}

//Function Number: 195
array_sort_by_handler(param_00,param_01)
{
	for(var_02 = 0;var_02 < param_00.size - 1;var_02++)
	{
		for(var_03 = var_02 + 1;var_03 < param_00.size;var_03++)
		{
			if(param_00[var_03] [[ param_01 ]]() < param_00[var_02] [[ param_01 ]]())
			{
				var_04 = param_00[var_03];
				param_00[var_03] = param_00[var_02];
				param_00[var_02] = var_04;
			}
		}
	}

	return param_00;
}

//Function Number: 196
func_0F0F(param_00,param_01)
{
	for(var_02 = 1;var_02 < param_00.size;var_02++)
	{
		var_03 = param_00[var_02];
		for(var_04 = var_02 - 1;var_04 >= 0 && ![[ param_01 ]](param_00[var_04],var_03);var_04--)
		{
			param_00[var_04 + 1] = param_00[var_04];
		}

		param_00[var_04 + 1] = var_03;
	}

	return param_00;
}