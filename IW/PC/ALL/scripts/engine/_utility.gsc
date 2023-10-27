/*******************************************************************
 * Decompiled By: Bog
 * Decompiled File: scripts\engine\_utility.gsc
 * Game: Call of Duty: Infinite Warfare
 * Platform: PC
 * Function Count: 259
 * Decompile Time: 12584 ms
 * Timestamp: 10/27/2023 12:11:04 AM
*******************************************************************/

//Function Number: 1
func_C0AC(param_00,param_01,param_02,param_03,param_04)
{
	if(!isdefined(level.var_74C2))
	{
		return;
	}

	if(!isdefined(level.var_74C2[param_00]))
	{
		return;
	}

	if(!isdefined(param_01))
	{
		[[ level.var_74C2[param_00] ]]();
		return;
	}

	if(!isdefined(param_02))
	{
		[[ level.var_74C2[param_00] ]](param_01);
		return;
	}

	if(!isdefined(param_03))
	{
		[[ level.var_74C2[param_00] ]](param_01,param_02);
		return;
	}

	if(!isdefined(param_04))
	{
		[[ level.var_74C2[param_00] ]](param_01,param_02,param_03);
		return;
	}

	[[ level.var_74C2[param_00] ]](param_01,param_02,param_03,param_04);
}

//Function Number: 2
func_F1E4(param_00,param_01,param_02,param_03,param_04)
{
	if(!isdefined(level.var_74C2[param_00]))
	{
		return;
	}

	if(!isdefined(param_01))
	{
		self [[ level.var_74C2[param_00] ]]();
		return;
	}

	if(!isdefined(param_02))
	{
		self [[ level.var_74C2[param_00] ]](param_01);
		return;
	}

	if(!isdefined(param_03))
	{
		self [[ level.var_74C2[param_00] ]](param_01,param_02);
		return;
	}

	if(!isdefined(param_04))
	{
		self [[ level.var_74C2[param_00] ]](param_01,param_02,param_03);
		return;
	}

	self [[ level.var_74C2[param_00] ]](param_01,param_02,param_03,param_04);
}

//Function Number: 3
func_1E7C(param_00,param_01)
{
	return acos(vectordot(param_00,param_01) / length(param_00) * length(param_01));
}

//Function Number: 4
func_1E7E(param_00,param_01)
{
	return acos(vectordot(param_00,param_01));
}

//Function Number: 5
func_1E7D(param_00,param_01,param_02)
{
	var_03 = vectornormalize(param_00);
	var_04 = vectornormalize(param_01);
	var_05 = acos(clamp(vectordot(var_03,var_04),-1,1));
	var_06 = vectorcross(var_03,var_04);
	if(vectordot(var_06,param_02) < 0)
	{
		var_05 = var_05 * -1;
	}

	return var_05;
}

//Function Number: 6
func_F18C(param_00,param_01,param_02,param_03)
{
	if(param_00 == param_01)
	{
		return 0;
	}

	var_04 = param_02 - param_00;
	var_05 = param_01 - param_00;
	var_06 = clamp(vectordot(var_04,var_05) / vectordot(var_05,var_05),0,1);
	var_07 = param_00 + var_05 * var_06;
	return lengthsquared(param_02 - var_07) <= param_03 * param_03;
}

//Function Number: 7
func_DCC8(param_00)
{
	return (randomfloat(param_00) - param_00 * 0.5,randomfloat(param_00) - param_00 * 0.5,randomfloat(param_00) - param_00 * 0.5);
}

//Function Number: 8
func_DCC9(param_00,param_01)
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
func_101EA(param_00)
{
	if(param_00 >= 0)
	{
		return 1;
	}

	return -1;
}

//Function Number: 10
func_B8F8(param_00,param_01)
{
	var_02 = int(param_00 / param_01);
	if(param_00 * param_01 < 0)
	{
		var_02 = var_02 - 1;
	}

	return param_00 - var_02 * param_01;
}

//Function Number: 11
func_7984(param_00)
{
	var_01 = [];
	var_01["axis"] = "allies";
	var_01["allies"] = "axis";
	return var_01[param_00];
}

//Function Number: 12
func_414E(param_00)
{
	self.var_68C6[param_00] = level.var_503A;
}

//Function Number: 13
func_4347()
{
	return randomint(100) >= 50;
}

//Function Number: 14
func_3E83(param_00,param_01)
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

//Function Number: 15
func_13806(param_00,param_01)
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
func_13839(param_00,param_01,param_02)
{
	if(param_01 != "death")
	{
		self endon("death");
	}

	param_02 endon("die");
	self waittillmatch(param_01,param_00);
	param_02 notify("returned",param_01);
}

//Function Number: 17
func_13807(param_00,param_01)
{
	param_01 endon("die");
	self waittill(param_00);
	param_01 notify("returned",param_00);
}

//Function Number: 18
func_137AC(param_00,param_01,param_02,param_03,param_04)
{
	self endon("death");
	var_05 = spawnstruct();
	var_05.var_117B8 = 0;
	if(isdefined(param_00))
	{
		childthread func_13806(param_00,var_05);
		var_05.var_117B8++;
	}

	if(isdefined(param_01))
	{
		childthread func_13806(param_01,var_05);
		var_05.var_117B8++;
	}

	if(isdefined(param_02))
	{
		childthread func_13806(param_02,var_05);
		var_05.var_117B8++;
	}

	if(isdefined(param_03))
	{
		childthread func_13806(param_03,var_05);
		var_05.var_117B8++;
	}

	if(isdefined(param_04))
	{
		childthread func_13806(param_04,var_05);
		var_05.var_117B8++;
	}

	while(var_05.var_117B8)
	{
		var_05 waittill("returned");
		var_05.var_117B8--;
	}

	var_05 notify("die");
}

//Function Number: 19
func_13838(param_00,param_01,param_02)
{
	self endon("death");
	self waittillmatch(param_01,param_00);
	self notify(param_02);
}

//Function Number: 20
func_13734(param_00,param_01,param_02,param_03,param_04,param_05)
{
	if((!isdefined(param_00) || param_00 != "death") && !isdefined(param_01) || param_01 != "death" && !isdefined(param_02) || param_02 != "death" && !isdefined(param_03) || param_03 != "death" && !isdefined(param_04) || param_04 != "death" && !isdefined(param_05) || param_05 != "death")
	{
		self endon("death");
	}

	var_06 = spawnstruct();
	if(isdefined(param_00))
	{
		childthread func_13806(param_00,var_06);
	}

	if(isdefined(param_01))
	{
		childthread func_13806(param_01,var_06);
	}

	if(isdefined(param_02))
	{
		childthread func_13806(param_02,var_06);
	}

	if(isdefined(param_03))
	{
		childthread func_13806(param_03,var_06);
	}

	if(isdefined(param_04))
	{
		childthread func_13806(param_04,var_06);
	}

	if(isdefined(param_05))
	{
		childthread func_13806(param_05,var_06);
	}

	var_06 waittill("returned",var_07);
	var_06 notify("die");
	return var_07;
}

//Function Number: 21
func_13837(param_00,param_01,param_02,param_03,param_04,param_05,param_06)
{
	if((!isdefined(param_01) || param_01 != "death") && !isdefined(param_02) || param_02 != "death" && !isdefined(param_03) || param_03 != "death" && !isdefined(param_04) || param_04 != "death" && !isdefined(param_05) || param_05 != "death" && !isdefined(param_06) || param_06 != "death")
	{
		self endon("death");
	}

	var_07 = spawnstruct();
	if(isdefined(param_01))
	{
		childthread func_13839(param_00,param_01,var_07);
	}

	if(isdefined(param_02))
	{
		childthread func_13839(param_00,param_02,var_07);
	}

	if(isdefined(param_03))
	{
		childthread func_13839(param_00,param_03,var_07);
	}

	if(isdefined(param_04))
	{
		childthread func_13839(param_00,param_04,var_07);
	}

	if(isdefined(param_05))
	{
		childthread func_13839(param_00,param_05,var_07);
	}

	if(isdefined(param_06))
	{
		childthread func_13839(param_00,param_06,var_07);
	}

	var_07 waittill("returned",var_08);
	var_07 notify("die");
	return var_08;
}

//Function Number: 22
waittill_any_return_no_endon_death_3(param_00,param_01,param_02,param_03,param_04,param_05)
{
	var_06 = spawnstruct();
	if(isdefined(param_00))
	{
		childthread func_13807(param_00,var_06);
	}

	if(isdefined(param_01))
	{
		childthread func_13807(param_01,var_06);
	}

	if(isdefined(param_02))
	{
		childthread func_13807(param_02,var_06);
	}

	if(isdefined(param_03))
	{
		childthread func_13807(param_03,var_06);
	}

	if(isdefined(param_04))
	{
		childthread func_13807(param_04,var_06);
	}

	if(isdefined(param_05))
	{
		childthread func_13807(param_05,var_06);
	}

	var_06 waittill("returned",var_07);
	var_06 notify("die");
	return var_07;
}

//Function Number: 23
func_13730(param_00)
{
	var_01 = spawnstruct();
	var_02 = 0;
	foreach(var_04 in param_00)
	{
		childthread func_13806(var_04,var_01);
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

//Function Number: 24
func_13731(param_00)
{
	var_01 = spawnstruct();
	foreach(var_03 in param_00)
	{
		childthread func_13807(var_03,var_01);
	}

	var_01 waittill("returned",var_05);
	var_01 notify("die");
	return var_05;
}

//Function Number: 25
func_1372E(param_00,param_01)
{
	var_02 = spawnstruct();
	var_03 = 0;
	foreach(var_05 in param_00)
	{
		childthread func_13806(var_05,var_02);
		if(var_05 == "death")
		{
			var_03 = 1;
		}
	}

	if(!var_03)
	{
		self endon("death");
	}

	var_02 childthread func_1428(param_01);
	var_02 waittill("returned",var_07);
	var_02 notify("die");
	return var_07;
}

//Function Number: 26
func_1372F(param_00,param_01)
{
	var_02 = spawnstruct();
	foreach(var_04 in param_00)
	{
		childthread func_13807(var_04,var_02);
	}

	var_02 thread func_1428(param_01);
	var_02 waittill("returned",var_06);
	var_02 notify("die");
	return var_06;
}

//Function Number: 27
waittill_any_timeout_1(param_00,param_01,param_02,param_03,param_04,param_05,param_06)
{
	if((!isdefined(param_01) || param_01 != "death") && !isdefined(param_02) || param_02 != "death" && !isdefined(param_03) || param_03 != "death" && !isdefined(param_04) || param_04 != "death" && !isdefined(param_05) || param_05 != "death" && !isdefined(param_06) || param_06 != "death")
	{
		self endon("death");
	}

	var_07 = spawnstruct();
	if(isdefined(param_01))
	{
		childthread func_13806(param_01,var_07);
	}

	if(isdefined(param_02))
	{
		childthread func_13806(param_02,var_07);
	}

	if(isdefined(param_03))
	{
		childthread func_13806(param_03,var_07);
	}

	if(isdefined(param_04))
	{
		childthread func_13806(param_04,var_07);
	}

	if(isdefined(param_05))
	{
		childthread func_13806(param_05,var_07);
	}

	if(isdefined(param_06))
	{
		childthread func_13806(param_06,var_07);
	}

	var_07 childthread func_1428(param_00);
	var_07 waittill("returned",var_08);
	var_07 notify("die");
	return var_08;
}

//Function Number: 28
func_1428(param_00)
{
	self endon("die");
	wait(param_00);
	self notify("returned","timeout");
}

//Function Number: 29
waittill_any_timeout_no_endon_death_2(param_00,param_01,param_02,param_03,param_04,param_05)
{
	var_06 = spawnstruct();
	if(isdefined(param_01))
	{
		childthread func_13807(param_01,var_06);
	}

	if(isdefined(param_02))
	{
		childthread func_13807(param_02,var_06);
	}

	if(isdefined(param_03))
	{
		childthread func_13807(param_03,var_06);
	}

	if(isdefined(param_04))
	{
		childthread func_13807(param_04,var_06);
	}

	if(isdefined(param_05))
	{
		childthread func_13807(param_05,var_06);
	}

	var_06 childthread func_1428(param_00);
	var_06 waittill("returned",var_07);
	var_06 notify("die");
	return var_07;
}

//Function Number: 30
waittill_any_3(param_00,param_01,param_02,param_03,param_04,param_05,param_06,param_07)
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

//Function Number: 31
func_1372B(param_00,param_01,param_02,param_03,param_04,param_05,param_06,param_07,param_08,param_09,param_0A,param_0B,param_0C,param_0D)
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

//Function Number: 32
func_9DFB()
{
	if(!isdefined(self.var_6ECA))
	{
		return 0;
	}

	return gettime() < self.var_6ECA;
}

//Function Number: 33
func_6E34(param_00)
{
	if(!isdefined(level.flag))
	{
		return 0;
	}

	return isdefined(level.flag[param_00]);
}

//Function Number: 34
flag(param_00)
{
	return level.flag[param_00];
}

//Function Number: 35
flag_init(param_00)
{
	if(!isdefined(level.flag))
	{
		scripts\common\flags::func_95E2();
	}

	level.flag[param_00] = 0;
	func_978C();
	if(!isdefined(level.var_12745[param_00]))
	{
		level.var_12745[param_00] = [];
	}

	if(getsubstr(param_00,0,3) == "aa_")
	{
		thread [[ level.var_74C2["sp_stat_tracking_func"] ]](param_00);
	}
}

//Function Number: 36
func_61B9(param_00)
{
}

//Function Number: 37
flag_set(param_00,param_01)
{
	level.flag[param_00] = 1;
	func_F5D6(param_00);
	if(isdefined(param_01))
	{
		level notify(param_00,param_01);
		return;
	}

	level notify(param_00);
}

//Function Number: 38
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

//Function Number: 39
func_6E2A(param_00)
{
	if(!flag(param_00))
	{
		return;
	}

	level.flag[param_00] = 0;
	func_F5D6(param_00);
	level notify(param_00);
}

//Function Number: 40
func_6E5A(param_00)
{
	while(flag(param_00))
	{
		level waittill(param_00);
	}
}

//Function Number: 41
waittill_either(param_00,param_01)
{
	self endon(param_00);
	self waittill(param_01);
	return param_01;
}

//Function Number: 42
func_22D3(param_00,param_01,param_02,param_03,param_04,param_05,param_06,param_07,param_08,param_09,param_0A,param_0B)
{
	if(!isdefined(param_03))
	{
		foreach(var_0D in param_00)
		{
			var_0D thread [[ param_01 ]]();
			wait(param_02);
		}

		return;
	}

	if(!isdefined(param_07))
	{
		foreach(var_0F in param_03)
		{
			var_0F thread [[ param_03 ]](param_05);
			wait(param_04);
		}

		return;
	}

	if(!isdefined(param_0A))
	{
		foreach(var_11 in param_05)
		{
			var_11 thread [[ param_05 ]](param_07,param_08);
			wait(param_06);
		}

		return;
	}

	if(!isdefined(var_0D))
	{
		foreach(var_13 in param_07)
		{
			var_13 thread [[ param_07 ]](param_09,param_0A,param_0B);
			wait(param_08);
		}

		return;
	}

	if(!isdefined(var_10))
	{
		foreach(var_15 in param_09)
		{
			var_15 thread [[ param_09 ]](param_0B,var_0C,var_0D,var_0E);
			wait(param_0A);
		}

		return;
	}

	if(!isdefined(var_13))
	{
		foreach(var_17 in param_0B)
		{
			var_17 thread [[ param_0B ]](var_0D,var_0E,var_0F,var_10,var_11);
			wait(var_0C);
		}

		return;
	}

	if(!isdefined(var_16))
	{
		foreach(var_19 in var_0D)
		{
			var_19 thread [[ var_0D ]](var_0F,var_10,var_11,var_12,var_13,var_14);
			wait(var_0E);
		}

		return;
	}

	if(!isdefined(var_19))
	{
		foreach(var_1B in var_0F)
		{
			var_1B thread [[ var_0F ]](var_11,var_12,var_13,var_14,var_15,var_16,var_17);
			wait(var_10);
		}

		return;
	}

	if(!isdefined(var_1C))
	{
		foreach(var_1D in var_11)
		{
			var_1D thread [[ var_11 ]](var_13,var_14,var_15,var_16,var_17,var_18,var_19,var_1A);
			wait(var_12);
		}

		return;
	}

	foreach(var_1F in var_13)
	{
		var_1F thread [[ var_13 ]](var_15,var_16,var_17,var_18,var_19,var_1A,var_1B,var_1C,var_1D);
		wait(var_14);
	}
}

//Function Number: 43
array_thread(param_00,param_01,param_02,param_03,param_04,param_05,param_06,param_07,param_08,param_09,param_0A)
{
	if(isdefined(param_0A))
	{
		foreach(var_0C in param_00)
		{
			var_0C thread [[ param_01 ]](param_02,param_03,param_04,param_05,param_06,param_07,param_08,param_09,param_0A);
		}

		return;
	}

	if(isdefined(var_0C))
	{
		foreach(var_0E in param_03)
		{
			var_0E thread [[ param_03 ]](param_04,param_05,param_06,param_07,param_08,param_09,param_0A,var_0B);
		}

		return;
	}

	if(isdefined(var_0D))
	{
		foreach(var_10 in param_05)
		{
			var_10 thread [[ param_05 ]](param_06,param_07,param_08,param_09,param_0A,var_0B,var_0C);
		}

		return;
	}

	if(isdefined(var_0E))
	{
		foreach(var_12 in param_07)
		{
			var_12 thread [[ param_07 ]](param_08,param_09,param_0A,var_0B,var_0C,var_0D);
		}

		return;
	}

	if(isdefined(var_0F))
	{
		foreach(var_14 in param_09)
		{
			var_14 thread [[ param_09 ]](param_0A,var_0B,var_0C,var_0D,var_0E);
		}

		return;
	}

	if(isdefined(var_10))
	{
		foreach(var_16 in var_0B)
		{
			var_16 thread [[ var_0B ]](var_0C,var_0D,var_0E,var_0F);
		}

		return;
	}

	if(isdefined(var_11))
	{
		foreach(var_18 in var_0D)
		{
			var_18 thread [[ var_0D ]](var_0E,var_0F,var_10);
		}

		return;
	}

	if(isdefined(var_12))
	{
		foreach(var_1A in var_0F)
		{
			var_1A thread [[ var_0F ]](var_10,var_11);
		}

		return;
	}

	if(isdefined(var_13))
	{
		foreach(var_1C in var_11)
		{
			var_1C thread [[ var_11 ]](var_12);
		}

		return;
	}

	foreach(var_1E in var_13)
	{
		var_1E thread [[ var_13 ]]();
	}
}

//Function Number: 44
func_227D(param_00,param_01,param_02,param_03,param_04,param_05,param_06,param_07,param_08,param_09)
{
	if(isdefined(param_09))
	{
		foreach(var_0B in param_00)
		{
			var_0B [[ param_01 ]](param_02,param_03,param_04,param_05,param_06,param_07,param_08,param_09);
		}

		return;
	}

	if(isdefined(var_0B))
	{
		foreach(var_0D in param_03)
		{
			var_0D [[ param_03 ]](param_04,param_05,param_06,param_07,param_08,param_09,var_0A);
		}

		return;
	}

	if(isdefined(var_0C))
	{
		foreach(var_0F in param_05)
		{
			var_0F [[ param_05 ]](param_06,param_07,param_08,param_09,var_0A,var_0B);
		}

		return;
	}

	if(isdefined(var_0D))
	{
		foreach(var_11 in param_07)
		{
			var_11 [[ param_07 ]](param_08,param_09,var_0A,var_0B,var_0C);
		}

		return;
	}

	if(isdefined(var_0E))
	{
		foreach(var_13 in param_09)
		{
			var_13 [[ param_09 ]](var_0A,var_0B,var_0C,var_0D);
		}

		return;
	}

	if(isdefined(var_0F))
	{
		foreach(var_15 in var_0B)
		{
			var_15 [[ var_0B ]](var_0C,var_0D,var_0E);
		}

		return;
	}

	if(isdefined(var_10))
	{
		foreach(var_17 in var_0D)
		{
			var_17 [[ var_0D ]](var_0E,var_0F);
		}

		return;
	}

	if(isdefined(var_11))
	{
		foreach(var_19 in var_0F)
		{
			var_19 [[ var_0F ]](var_10);
		}

		return;
	}

	foreach(var_1B in var_11)
	{
		var_1B [[ var_11 ]]();
	}
}

//Function Number: 45
trigger_on(param_00,param_01)
{
	if(isdefined(param_00) && isdefined(param_01))
	{
		var_02 = getentarray(param_00,param_01);
		array_thread(var_02,::func_1277B);
		return;
	}

	func_1277B();
}

//Function Number: 46
func_1277B()
{
	if(isdefined(self.var_DD8D))
	{
		self.origin = self.var_DD8D;
	}

	self.trigger_off = undefined;
}

//Function Number: 47
trigger_off(param_00,param_01)
{
	if(isdefined(param_00) && isdefined(param_01))
	{
		var_02 = getentarray(param_00,param_01);
		array_thread(var_02,::func_12779);
		return;
	}

	func_12779();
}

//Function Number: 48
func_12779()
{
	if(!isdefined(self.var_DD8D))
	{
		self.var_DD8D = self.origin;
	}

	if(self.origin == self.var_DD8D)
	{
		self.origin = self.origin + (0,0,-10000);
	}

	self.trigger_off = 1;
	self notify("trigger_off");
}

//Function Number: 49
func_F5D6(param_00)
{
	if(!isdefined(level.var_12745))
	{
		return;
	}

	level.var_12745[param_00] = func_22BC(level.var_12745[param_00]);
	array_thread(level.var_12745[param_00],::func_12E40);
}

//Function Number: 50
func_12E40()
{
	var_00 = 1;
	if(isdefined(self.var_ED9F))
	{
		var_00 = 0;
		var_01 = func_48ED(self.var_ED9F);
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
	if(isdefined(self.var_ED9D))
	{
		var_01 = func_48ED(self.var_ED9D);
		foreach(var_03 in var_01)
		{
			if(flag(var_03))
			{
				var_05 = 0;
				break;
			}
		}
	}

	[[ level.var_12749[var_00 && var_05] ]]();
}

//Function Number: 51
func_48ED(param_00)
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

//Function Number: 52
func_978C()
{
	if(!func_16F3("trigger_flags",::func_978C))
	{
		return;
	}

	level.var_12745 = [];
	level.var_12749[1] = ::trigger_on;
	level.var_12749[0] = ::trigger_off;
}

//Function Number: 53
getstruct(param_00,param_01)
{
	var_02 = level.var_1115C[param_01][param_00];
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

//Function Number: 54
getstructarray(param_00,param_01)
{
	var_02 = level.var_1115C[param_01][param_00];
	if(!isdefined(var_02))
	{
		return [];
	}

	return var_02;
}

//Function Number: 55
func_1115B()
{
	if(!func_16F3("struct_classes",::func_1115B))
	{
		return;
	}

	level.var_1115C = [];
	level.var_1115C["target"] = [];
	level.var_1115C["targetname"] = [];
	level.var_1115C["script_noteworthy"] = [];
	level.var_1115C["script_linkname"] = [];
	foreach(var_03, var_01 in level.struct)
	{
		if(isdefined(var_01.var_336))
		{
			if(var_01.var_336 == "delete_on_load")
			{
				level.struct[var_03] = undefined;
				continue;
			}

			if(!isdefined(level.var_1115C["targetname"][var_01.var_336]))
			{
				level.var_1115C["targetname"][var_01.var_336] = [];
			}

			var_02 = level.var_1115C["targetname"][var_01.var_336].size;
			level.var_1115C["targetname"][var_01.var_336][var_02] = var_01;
		}

		if(isdefined(var_01.target))
		{
			if(!isdefined(level.var_1115C["target"][var_01.target]))
			{
				level.var_1115C["target"][var_01.target] = [];
			}

			var_02 = level.var_1115C["target"][var_01.target].size;
			level.var_1115C["target"][var_01.target][var_02] = var_01;
		}

		if(isdefined(var_01.script_noteworthy))
		{
			if(!isdefined(level.var_1115C["script_noteworthy"][var_01.script_noteworthy]))
			{
				level.var_1115C["script_noteworthy"][var_01.script_noteworthy] = [];
			}

			var_02 = level.var_1115C["script_noteworthy"][var_01.script_noteworthy].size;
			level.var_1115C["script_noteworthy"][var_01.script_noteworthy][var_02] = var_01;
		}

		if(isdefined(var_01.var_27C))
		{
			if(!isdefined(level.var_1115C["script_linkname"][var_01.var_27C]))
			{
				level.var_1115C["script_linkname"][var_01.var_27C] = [];
			}

			var_02 = level.var_1115C["script_linkname"][var_01.var_27C].size;
			level.var_1115C["script_linkname"][var_01.var_27C][var_02] = var_01;
		}
	}
}

//Function Number: 56
func_6C0C(param_00)
{
}

//Function Number: 57
func_6C0A()
{
}

//Function Number: 58
func_6C08(param_00)
{
	if(!isdefined(param_00))
	{
		param_00 = 0;
	}
}

//Function Number: 59
func_6C09(param_00,param_01)
{
}

//Function Number: 60
func_6C07()
{
}

//Function Number: 61
func_6C06()
{
}

//Function Number: 62
func_6C0B(param_00)
{
}

//Function Number: 63
func_22A9(param_00,param_01)
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

//Function Number: 64
func_22AC(param_00,param_01)
{
	foreach(var_03 in param_01)
	{
		param_00 = func_22A9(param_00,var_03);
	}

	return param_00;
}

//Function Number: 65
func_22BC(param_00)
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

//Function Number: 66
func_22AF(param_00)
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

//Function Number: 67
func_22A1(param_00,param_01,param_02,param_03,param_04)
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

//Function Number: 68
func_22A0(param_00,param_01,param_02,param_03,param_04)
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

//Function Number: 69
array_add_safe(param_00,param_01)
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

//Function Number: 70
func_693B(param_00,param_01)
{
	var_02 = 0;
	if(param_00.size > 0)
	{
		foreach(var_04 in param_00)
		{
			if(var_04 == param_01)
			{
				var_02 = 1;
				break;
			}
		}
	}

	return var_02;
}

//Function Number: 71
delaycall(param_00,param_01,param_02,param_03,param_04,param_05,param_06,param_07,param_08,param_09,param_0A,param_0B,param_0C,param_0D)
{
	thread func_50E2(param_01,param_00,param_02,param_03,param_04,param_05,param_06,param_07,param_08,param_09,param_0A,param_0B,param_0C,param_0D);
}

//Function Number: 72
func_50E2(param_00,param_01,param_02,param_03,param_04,param_05,param_06,param_07,param_08,param_09,param_0A,param_0B,param_0C,param_0D)
{
	if(issp())
	{
		self endon("death");
		self endon("stop_delay_call");
	}

	wait(param_01);
	if(isdefined(param_0D))
	{
		self [[ param_00 ]](param_02,param_03,param_04,param_05,param_06,param_07,param_08,param_09,param_0A,param_0B,param_0C,param_0D);
		return;
	}

	if(isdefined(param_0C))
	{
		self [[ param_00 ]](param_02,param_03,param_04,param_05,param_06,param_07,param_08,param_09,param_0A,param_0B,param_0C);
		return;
	}

	if(isdefined(param_0B))
	{
		self [[ param_00 ]](param_02,param_03,param_04,param_05,param_06,param_07,param_08,param_09,param_0A,param_0B);
		return;
	}

	if(isdefined(param_0A))
	{
		self [[ param_00 ]](param_02,param_03,param_04,param_05,param_06,param_07,param_08,param_09,param_0A);
		return;
	}

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

//Function Number: 73
issp()
{
	if(!isdefined(level.issp))
	{
		var_00 = getdvar("mapname");
		var_01 = "";
		for(var_02 = 0;var_02 < min(var_00.size,3);var_02++)
		{
			var_01 = var_01 + var_00[var_02];
		}

		level.issp = var_01 != "mp_" && var_01 != "cp_";
	}

	return level.issp;
}

//Function Number: 74
func_9D9A()
{
	return string_starts_with(getdvar("mapname"),"cp_");
}

//Function Number: 75
func_9F65()
{
	if(!isdefined(level.var_9F65))
	{
		level.var_9F65 = string_starts_with(getdvar("mapname"),"so_td_");
	}

	return level.var_9F65;
}

//Function Number: 76
string_starts_with(param_00,param_01)
{
	if(param_00.size < param_01.size)
	{
		return 0;
	}

	var_02 = getsubstr(param_00,0,param_01.size);
	if(var_02 == param_01)
	{
		return 1;
	}

	return 0;
}

//Function Number: 77
func_D5DA(param_00,param_01,param_02,param_03,param_04)
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
		thread func_5B4B(var_05,param_00[var_06],param_01,param_02,param_03,param_04);
		var_05 = param_00[var_06];
	}
}

//Function Number: 78
func_5B4B(param_00,param_01,param_02,param_03,param_04,param_05)
{
	param_05 = gettime() + param_05 * 1000;
	while(gettime() < param_05)
	{
		wait(0.05);
	}
}

//Function Number: 79
array_combine(param_00,param_01,param_02,param_03)
{
	var_04 = [];
	if(isdefined(param_00))
	{
		foreach(var_06 in param_00)
		{
			var_04[var_04.size] = var_06;
		}
	}

	if(isdefined(param_01))
	{
		foreach(var_06 in param_01)
		{
			var_04[var_04.size] = var_06;
		}
	}

	if(isdefined(param_02))
	{
		foreach(var_06 in param_02)
		{
			var_04[var_04.size] = var_06;
		}
	}

	if(isdefined(param_03))
	{
		foreach(var_06 in param_03)
		{
			var_04[var_04.size] = var_06;
		}
	}

	return var_04;
}

//Function Number: 80
func_2282(param_00)
{
	var_01 = [];
	foreach(var_03 in param_00)
	{
		foreach(var_05 in var_03)
		{
			var_01[var_01.size] = var_05;
		}
	}

	return var_01;
}

//Function Number: 81
func_2284(param_00,param_01)
{
	var_02 = [];
	foreach(var_04 in param_00)
	{
		var_02[var_02.size] = var_04;
	}

	foreach(var_04 in param_01)
	{
		if(func_2286(var_02,var_04))
		{
			continue;
		}

		var_02[var_02.size] = var_04;
	}

	return var_02;
}

//Function Number: 82
func_2283(param_00,param_01)
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

//Function Number: 83
array_randomize(param_00)
{
	for(var_01 = 0;var_01 <= param_00.size - 2;var_01++)
	{
		var_02 = randomintrange(var_01,param_00.size - 1);
		var_03 = param_00[var_01];
		param_00[var_01] = param_00[var_02];
		param_00[var_02] = var_03;
	}

	return param_00;
}

//Function Number: 84
func_22A8(param_00)
{
	var_01 = [];
	for(var_02 = param_00;var_02.size > 0;var_02 = var_04)
	{
		var_03 = randomintrange(0,var_02.size);
		var_04 = [];
		var_05 = 0;
		foreach(var_08, var_07 in var_02)
		{
			if(var_05 == var_03)
			{
				var_01[func_116D7(isstring(var_08),var_08,var_01.size)] = var_07;
			}
			else
			{
				var_04[func_116D7(isstring(var_08),var_08,var_04.size)] = var_07;
			}

			var_05++;
		}
	}

	return var_01;
}

//Function Number: 85
array_add(param_00,param_01)
{
	param_00[param_00.size] = param_01;
	return param_00;
}

//Function Number: 86
func_229C(param_00,param_01,param_02)
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

//Function Number: 87
func_2286(param_00,param_01)
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

//Function Number: 88
func_2291(param_00,param_01)
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

//Function Number: 89
func_6EE1(param_00)
{
	var_01 = (0,param_00[1],0);
	return var_01;
}

//Function Number: 90
func_6EE3(param_00)
{
	var_01 = (param_00[0],param_00[1],0);
	return var_01;
}

//Function Number: 91
func_6EE6(param_00,param_01)
{
	if(!isdefined(param_01))
	{
		param_01 = (0,0,1);
	}

	var_02 = vectornormalize(param_00 - vectordot(param_01,param_00) * param_01);
	return var_02;
}

//Function Number: 92
func_5B22(param_00,param_01,param_02,param_03)
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
	func_D5DA(var_0A,var_0C,var_0D,var_0E,param_03);
}

//Function Number: 93
func_7A9C()
{
	return strtok(self.var_EE01," ");
}

//Function Number: 94
func_5B21(param_00,param_01,param_02)
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

//Function Number: 95
func_5B27(param_00,param_01,param_02,param_03,param_04,param_05,param_06)
{
	if(!isdefined(param_03))
	{
		param_03 = (0,0,0);
	}

	if(!isdefined(param_05))
	{
		param_05 = 0;
	}

	if(!isdefined(param_06))
	{
		param_06 = 1;
	}

	var_07 = anglestoforward(param_03);
	var_08 = anglestoright(param_03);
	var_09 = anglestoup(param_03);
	var_0A = param_00 + var_09 * param_01;
	var_0B = param_00 + var_09 * param_02;
	var_0B = var_0B - var_09 * param_01;
	var_0C = var_0A + var_07 * param_01;
	var_0D = var_0B + var_07 * param_01;
	var_0E = var_0A - var_07 * param_01;
	var_0F = var_0B - var_07 * param_01;
	var_10 = var_0A + var_08 * param_01;
	var_11 = var_0B + var_08 * param_01;
	var_12 = var_0A - var_08 * param_01;
	var_13 = var_0B - var_08 * param_01;
}

//Function Number: 96
func_5B28(param_00,param_01,param_02)
{
	var_03 = self method_8435();
	func_5B27(self getorigin(),var_03["radius"],var_03["half_height"] * 2,self.angles,param_00,param_01,param_02);
}

//Function Number: 97
func_5B58(param_00,param_01,param_02)
{
	var_03 = self method_8435();
	func_5B27(self getorigin(),var_03["radius"],var_03["half_height"] * 2,self getplayerangles(),param_00,param_01,param_02);
}

//Function Number: 98
func_5B43(param_00,param_01)
{
	self endon("stop_drawing_axis");
	self endon("death");
	for(;;)
	{
		var_02 = self gettagorigin(param_00);
		var_03 = self gettagangles(param_00);
		func_5B20(var_03,var_02,param_01);
		func_136F7();
	}
}

//Function Number: 99
func_5B42(param_00,param_01)
{
	self endon("stop_drawing_axis");
	self endon("death");
	for(;;)
	{
		func_5B41(param_00,undefined,param_01);
		func_136F7();
	}
}

//Function Number: 100
func_5B41(param_00,param_01,param_02)
{
	waittillframeend;
	if(isdefined(self.angles))
	{
		var_03 = self.angles;
	}
	else
	{
		var_03 = (0,0,0);
	}

	func_5B20(var_03,self.origin,param_00,param_01,param_02);
}

//Function Number: 101
func_5B20(param_00,param_01,param_02,param_03,param_04)
{
	waittillframeend;
	var_05 = anglestoforward(param_00);
	var_06 = anglestoright(param_00);
	var_07 = anglestoup(param_00);
	if(!isdefined(param_02))
	{
		param_02 = (1,0,1);
	}

	if(!isdefined(param_03))
	{
		param_03 = 1;
	}

	if(!isdefined(param_04))
	{
		param_04 = 10;
	}
}

//Function Number: 102
func_5B44(param_00,param_01,param_02,param_03,param_04)
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
		var_05 = int(param_04 / 0.05);
	}
	else
	{
		var_05 = int(param_02 / 0.05);
	}

	var_06 = [];
	var_07 = [];
	var_08 = gettime();
	var_09 = var_08 + param_01 * 1000;
	while(var_08 < var_09 && isdefined(param_00))
	{
		var_06[0] = param_00 method_8159(1,1,1);
		var_06[1] = param_00 method_8159(1,1,-1);
		var_06[2] = param_00 method_8159(-1,1,-1);
		var_06[3] = param_00 method_8159(-1,1,1);
		var_07[0] = param_00 method_8159(1,-1,1);
		var_07[1] = param_00 method_8159(1,-1,-1);
		var_07[2] = param_00 method_8159(-1,-1,-1);
		var_07[3] = param_00 method_8159(-1,-1,1);
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
			return;
		}

		wait(param_04);
		var_08 = gettime();
	}
}

//Function Number: 103
getfx(param_00)
{
	return level._effect[param_00];
}

//Function Number: 104
fxexists(param_00)
{
	return isdefined(level._effect[param_00]);
}

//Function Number: 105
getlastweapon()
{
	return self.var_EB6B;
}

//Function Number: 106
func_D454()
{
}

//Function Number: 107
func_9FBE()
{
	return !isdefined(self.var_55E4) || !self.var_55E4;
}

//Function Number: 108
func_1C6E(param_00)
{
	if(param_00)
	{
		if(!isdefined(self.var_55E4))
		{
			self.var_55E4 = 0;
		}

		self.var_55E4--;
		if(!self.var_55E4)
		{
			self method_80DA();
			return;
		}

		return;
	}

	if(!isdefined(self.var_55E4))
	{
		self.var_55E4 = 0;
	}

	self.var_55E4++;
	self method_80A8();
}

//Function Number: 109
allow_weapon(param_00)
{
	if(param_00)
	{
		if(!isdefined(self.var_55E6))
		{
			self.var_55E6 = 0;
		}

		self.var_55E6--;
		if(!self.var_55E6)
		{
			self enableweapons();
			if(isdefined(level.var_1C73))
			{
				self [[ level.var_1C73 ]](1);
				return;
			}

			return;
		}

		return;
	}

	if(!isdefined(self.var_55E6))
	{
		self.var_55E6 = 0;
	}

	if(!self.var_55E6)
	{
		if(isdefined(level.var_1C73))
		{
			self [[ level.var_1C73 ]](0);
		}

		self method_80AA();
	}

	self.var_55E6++;
}

//Function Number: 110
func_9FFD()
{
	return !isdefined(self.var_55E6) || !self.var_55E6;
}

//Function Number: 111
func_1C76(param_00)
{
	if(param_00)
	{
		if(!isdefined(self.disabledweaponswitch))
		{
			self.disabledweaponswitch = 0;
		}

		self.disabledweaponswitch--;
		if(!self.disabledweaponswitch)
		{
			self enableweaponswitch();
			return;
		}

		return;
	}

	if(!isdefined(self.disabledweaponswitch))
	{
		self.disabledweaponswitch = 0;
	}

	self.disabledweaponswitch++;
	self method_80AB();
}

//Function Number: 112
func_1C58(param_00)
{
	if(param_00)
	{
		if(!isdefined(self.var_55D9))
		{
			self.var_55D9 = 0;
		}

		self.var_55D9--;
		if(!self.var_55D9)
		{
			self method_80D6();
		}

		if(!isdefined(level.ismp) || level.ismp == 0)
		{
			func_1C57(1);
			return;
		}

		return;
	}

	if(!isdefined(self.var_55D9))
	{
		self.var_55D9 = 0;
	}

	self.var_55D9++;
	self method_80A4();
	if(!isdefined(level.ismp) || level.ismp == 0)
	{
		func_1C57(0);
	}
}

//Function Number: 113
func_1C55(param_00)
{
	if(param_00)
	{
		if(!isdefined(self.var_55D6))
		{
			self.var_55D6 = 0;
		}
		else
		{
			self.var_55D6--;
		}

		if(!self.var_55D6)
		{
			self method_858C();
			return;
		}

		return;
	}

	if(!isdefined(self.var_55D6))
	{
		self.var_55D6 = 0;
	}

	self.var_55D6++;
	self method_858B();
}

//Function Number: 114
func_1C56(param_00)
{
	if(param_00)
	{
		if(!isdefined(self.var_55D7))
		{
			self.var_55D7 = 0;
		}
		else
		{
			self.var_55D7--;
		}

		if(!self.var_55D7)
		{
			self method_8438();
		}

		func_1C57(1);
		return;
	}

	if(!isdefined(self.var_55D7))
	{
		self.var_55D7 = 0;
	}

	self.var_55D7++;
	self method_8437();
	func_1C57(0);
}

//Function Number: 115
func_1C57(param_00)
{
	if(param_00)
	{
		if(!isdefined(self.var_55D8))
		{
			self.var_55D8 = 0;
		}

		self.var_55D8--;
		if(!self.var_55D8)
		{
			self method_84DD(1);
			return;
		}

		return;
	}

	if(!isdefined(self.var_55D8))
	{
		self.var_55D8 = 0;
	}

	self.var_55D8++;
	self method_84DD(0);
}

//Function Number: 116
func_A009()
{
	return !isdefined(self.disabledweaponswitch) || !self.disabledweaponswitch;
}

//Function Number: 117
func_9EC1()
{
	return !isdefined(self.var_55D9) || !self.var_55D9;
}

//Function Number: 118
func_9EBE()
{
	return !isdefined(self.var_55D6) || !self.var_55D6;
}

//Function Number: 119
func_9EBF()
{
	return !isdefined(self.var_55D7) || !self.var_55D7;
}

//Function Number: 120
func_1C60(param_00)
{
	if(param_00)
	{
		if(!isdefined(self.var_55DC))
		{
			self.var_55DC = 0;
		}
		else
		{
			self.var_55DC--;
		}

		if(!self.var_55DC)
		{
			self allowprone(1);
			return;
		}

		return;
	}

	if(!isdefined(self.var_55DC))
	{
		self.var_55DC = 0;
	}

	self.var_55DC++;
	self allowprone(0);
}

//Function Number: 121
func_1C40(param_00)
{
	if(param_00)
	{
		if(!isdefined(self.var_55C3))
		{
			self.var_55C3 = 0;
		}
		else
		{
			self.var_55C3--;
		}

		if(!self.var_55C3)
		{
			self allowcrouch(1);
			return;
		}

		return;
	}

	if(!isdefined(self.var_55C3))
	{
		self.var_55C3 = 0;
	}

	self.var_55C3++;
	self allowcrouch(0);
}

//Function Number: 122
func_1C68(param_00)
{
	if(param_00)
	{
		if(!isdefined(self.var_55E2))
		{
			self.var_55E2 = 0;
		}
		else
		{
			self.var_55E2--;
		}

		if(!self.var_55E2)
		{
			self allowstand(1);
			return;
		}

		return;
	}

	if(!isdefined(self.var_55E2))
	{
		self.var_55E2 = 0;
	}

	self.var_55E2++;
	self allowstand(0);
}

//Function Number: 123
func_1C67(param_00)
{
	if(param_00)
	{
		if(!isdefined(self.var_55E1))
		{
			self.var_55E1 = 0;
		}
		else
		{
			self.var_55E1--;
		}

		if(!self.var_55E1)
		{
			self method_8012(1);
			return;
		}

		return;
	}

	if(!isdefined(self.var_55E1))
	{
		self.var_55E1 = 0;
	}

	self.var_55E1++;
	self method_8012(0);
}

//Function Number: 124
func_1C52(param_00)
{
	if(param_00)
	{
		if(!isdefined(self.var_55D4))
		{
			self.var_55D4 = 0;
		}
		else
		{
			self.var_55D4--;
		}

		if(!self.var_55D4)
		{
			self method_8472(1);
			return;
		}

		return;
	}

	if(!isdefined(self.var_55D4))
	{
		self.var_55D4 = 0;
	}

	self.var_55D4++;
	self method_8472(0);
}

//Function Number: 125
func_1C46(param_00)
{
	if(param_00)
	{
		if(!isdefined(self.var_55C8))
		{
			self.var_55C8 = 0;
		}
		else
		{
			self.var_55C8--;
		}

		if(!self.var_55C8)
		{
			self method_800C(1);
			return;
		}

		return;
	}

	if(!isdefined(self.var_55C8))
	{
		self.var_55C8 = 0;
	}

	self.var_55C8++;
	self method_800C(0);
}

//Function Number: 126
func_1C35(param_00)
{
	if(param_00)
	{
		if(!isdefined(self.var_55BE))
		{
			self.var_55BE = 0;
		}
		else
		{
			self.var_55BE--;
		}

		if(!self.var_55BE)
		{
			self method_8009(1);
			return;
		}

		return;
	}

	if(!isdefined(self.var_55BE))
	{
		self.var_55BE = 0;
	}

	self.var_55BE++;
	self method_8009(0);
}

//Function Number: 127
allow_jump(param_00)
{
	if(param_00)
	{
		if(!isdefined(self.var_55D0))
		{
			self.var_55D0 = 0;
		}
		else
		{
			self.var_55D0--;
		}

		if(!self.var_55D0)
		{
			self allowjump(1);
			return;
		}

		return;
	}

	if(!isdefined(self.var_55D0))
	{
		self.var_55D0 = 0;
	}

	self.var_55D0++;
	self allowjump(0);
}

//Function Number: 128
func_1C70(param_00)
{
	if(param_00)
	{
		if(!isdefined(self.var_55E5))
		{
			self.var_55E5 = 0;
		}
		else
		{
			self.var_55E5--;
		}

		if(!self.var_55E5)
		{
			self method_8424(1);
			return;
		}

		return;
	}

	if(!isdefined(self.var_55E5))
	{
		self.var_55E5 = 0;
	}

	self.var_55E5++;
	self method_8424(0);
}

//Function Number: 129
func_1C42(param_00)
{
	if(param_00)
	{
		if(!isdefined(self.var_55C6))
		{
			self.var_55C6 = 0;
		}
		else
		{
			self.var_55C6--;
		}

		if(!self.var_55C6)
		{
			self method_842C(0,self.var_5AE0);
			self method_8434(0,self.var_5AE1);
			self.var_5AE0 = undefined;
			self.var_5AE1 = undefined;
			self method_8422(1);
			return;
		}

		return;
	}

	if(!isdefined(self.var_55C6))
	{
		self.var_55C6 = 0;
	}

	if(self.var_55C6 == 0)
	{
		self.var_5AE0 = self method_842B(0);
		self.var_5AE1 = self method_8433(0);
		self method_842C(0,0);
		self method_8434(0,0);
	}

	self.var_55C6++;
	self method_8422(0);
}

//Function Number: 130
func_1C53(param_00)
{
	if(param_00)
	{
		if(!isdefined(self.var_55D5))
		{
			self.var_55D5 = 0;
		}
		else
		{
			self.var_55D5--;
		}

		if(!self.var_55D5)
		{
			self allowmelee(1);
			return;
		}

		return;
	}

	if(!isdefined(self.var_55D5))
	{
		self.var_55D5 = 0;
	}

	self.var_55D5++;
	self allowmelee(0);
}

//Function Number: 131
func_1C64(param_00)
{
	if(param_00)
	{
		if(!isdefined(self.var_55E0))
		{
			self.var_55E0 = 0;
		}
		else
		{
			self.var_55E0--;
		}

		if(!self.var_55E0)
		{
			self allowslide(1);
			return;
		}

		return;
	}

	if(!isdefined(self.var_55E0))
	{
		self.var_55E0 = 0;
	}

	self.var_55E0++;
	self allowslide(0);
}

//Function Number: 132
func_7953()
{
	if(!isdefined(self.var_5AE0))
	{
		return self method_842B(0);
	}

	return self.var_5AE0;
}

//Function Number: 133
func_F367(param_00)
{
	if(!isdefined(self.var_5AE0))
	{
		self method_842C(0,param_00);
		return;
	}

	self.var_5AE0 = param_00;
}

//Function Number: 134
func_7954()
{
	if(!isdefined(self.var_5AE1))
	{
		return self method_8433(0);
	}

	return self.var_5AE1;
}

//Function Number: 135
func_F368(param_00)
{
	if(!isdefined(self.var_5AE1))
	{
		self method_8434(0,param_00);
		return;
	}

	self.var_5AE1 = param_00;
}

//Function Number: 136
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

//Function Number: 137
func_DCA4(param_00)
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
	return var_01[var_01.size - 1 - int(sqrt(var_05))];
}

//Function Number: 138
spawn_tag_origin(param_00,param_01)
{
	if(!isdefined(param_01) && isdefined(self.angles))
	{
		param_01 = self.angles;
	}

	if(!isdefined(param_00) && isdefined(self.origin))
	{
		param_00 = self.origin;
	}
	else if(!isdefined(param_00))
	{
		param_00 = (0,0,0);
	}

	var_02 = spawn("script_model",param_00);
	var_02 setmodel("tag_origin");
	var_02 hide();
	if(isdefined(param_01))
	{
		var_02.angles = param_01;
	}

	return var_02;
}

//Function Number: 139
waittill_notify_or_timeout(param_00,param_01)
{
	self endon(param_00);
	wait(param_01);
}

//Function Number: 140
waittill_notify_or_timeout_return(param_00,param_01)
{
	self endon(param_00);
	wait(param_01);
	return "timeout";
}

//Function Number: 141
func_137B4(param_00,param_01)
{
	var_02 = gettime();
	self waittill(param_00);
	var_03 = var_02 + param_01 * 1000;
	var_04 = var_03 - var_02;
	if(var_04 > 0)
	{
		var_05 = var_04 / 1000;
		wait(var_05);
	}
}

//Function Number: 142
func_6C05()
{
	level.fileprintlauncher_linecount = 0;
	level.fileprint_launcher = 1;
	fileprint_launcher("GAMEPRINTSTARTFILE:");
}

//Function Number: 143
fileprint_launcher(param_00)
{
	level.fileprintlauncher_linecount++;
	if(level.fileprintlauncher_linecount > 200)
	{
		wait(0.05);
		level.fileprintlauncher_linecount = 0;
	}
}

//Function Number: 144
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

	iprintlnbold("Launcher write to file successful!");
	level.fileprint_launcher = undefined;
	return 1;
}

//Function Number: 145
launcher_write_clipboard(param_00)
{
	level.fileprintlauncher_linecount = 0;
	fileprint_launcher("LAUNCHER_CLIP:" + param_00);
}

//Function Number: 146
func_15B8()
{
	scripts\common\exploder::func_15B9();
}

//Function Number: 147
func_136F7()
{
	wait(0.05);
}

//Function Number: 148
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
		var_01 = [[ level.var_7FF9 ]](param_00,"targetname");
		if(isdefined(var_01))
		{
			return var_01;
		}

		var_01 = [[ level.var_74C2["getspawner"] ]](param_00,"targetname");
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

//Function Number: 149
func_577E(param_00,param_01)
{
	var_02 = level.var_5FC6[param_00];
	earthquake(var_02["magnitude"],var_02["duration"],param_01,var_02["radius"]);
}

//Function Number: 150
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

//Function Number: 151
func_CE2C(param_00,param_01,param_02,param_03,param_04)
{
	var_05 = spawn("script_origin",(0,0,1));
	if(!isdefined(param_01))
	{
		param_01 = self.origin;
	}

	var_05.origin = param_01;
	var_05.angles = param_02;
	if(isdefined(param_04))
	{
		var_05 linkto(param_04);
	}

	if(issp())
	{
		if(isdefined(param_03) && param_03)
		{
			var_05 playsoundasmaster(param_00,"sounddone");
		}
		else
		{
			var_05 playsound(param_00,"sounddone");
		}

		var_05 waittill("sounddone");
	}
	else if(isdefined(param_03) && param_03)
	{
		var_05 playsoundasmaster(param_00);
	}
	else
	{
		var_05 playsound(param_00);
	}

	var_05 delete();
}

//Function Number: 152
play_sound_in_space(param_00,param_01,param_02,param_03)
{
	func_CE2C(param_00,param_01,(0,0,0),param_02,param_03);
}

//Function Number: 153
func_B040(param_00,param_01,param_02,param_03,param_04)
{
	func_B043(param_00,param_01,(0,0,0),param_02,param_03,param_04);
}

//Function Number: 154
func_B043(param_00,param_01,param_02,param_03,param_04,param_05,param_06)
{
	if(isdefined(param_03) && param_03)
	{
		if(!isdefined(level.var_6DC7) || level.var_6DC7 == 1)
		{
			function_01E3(param_00,param_01,param_02);
			return;
		}

		return;
	}

	if(level.createfx_enabled && isdefined(param_05.var_B066))
	{
		var_07 = param_05.var_B066;
	}
	else
	{
		var_07 = spawn("script_origin",(0,0,0));
	}

	if(isdefined(param_04))
	{
		thread func_B049(param_04,var_07);
		self endon(param_04);
	}

	var_07.origin = param_01;
	var_07.angles = param_02;
	var_07 playloopsound(param_00);
	if(level.createfx_enabled)
	{
		param_05.var_B066 = var_07;
		return;
	}

	var_07 willneverchange();
}

//Function Number: 155
func_B041(param_00,param_01,param_02,param_03,param_04,param_05)
{
	func_B042(param_00,param_01,(0,0,0),param_02,param_03,param_04,param_05);
}

//Function Number: 156
func_B042(param_00,param_01,param_02,param_03,param_04,param_05,param_06)
{
	self.origin = param_01;
	self.angles = param_02;
	if(isdefined(param_03))
	{
		self endon(param_03);
	}

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
		func_AED4("createfx_looper");
		thread func_CE2C(param_00,self.origin,self.angles,undefined);
		func_12BD1("createfx_looper");
	}
}

//Function Number: 157
func_B049(param_00,param_01)
{
	param_01 endon("death");
	self waittill(param_00);
	param_01 delete();
}

//Function Number: 158
func_49E6(param_00)
{
	var_01 = scripts\common\createfx::func_49AA("loopfx",param_00);
	var_01.var_13125["delay"] = scripts\common\createfx::func_7F81();
	return var_01;
}

//Function Number: 159
func_49FA(param_00)
{
	var_01 = scripts\common\createfx::func_49AA("oneshotfx",param_00);
	var_01.var_13125["delay"] = scripts\common\createfx::func_8022();
	return var_01;
}

//Function Number: 160
func_49AE(param_00)
{
	var_01 = scripts\common\createfx::func_49AA("exploder",param_00);
	var_01.var_13125["delay"] = scripts\common\createfx::func_7EA6();
	var_01.var_13125["exploder_type"] = "normal";
	return var_01;
}

//Function Number: 161
func_1D3A(param_00)
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

//Function Number: 162
func_CD7F(param_00,param_01)
{
	var_02 = spawn("script_origin",(0,0,0));
	var_02 endon("death");
	thread func_5179(var_02);
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

//Function Number: 163
func_11018(param_00)
{
	self notify("stop sound" + param_00);
}

//Function Number: 164
func_5179(param_00)
{
	param_00 endon("death");
	self waittill("death");
	if(isdefined(param_00))
	{
		param_00 delete();
	}
}

//Function Number: 165
func_66BD(param_00)
{
	func_136F7();
}

//Function Number: 166
exploder(param_00,param_01,param_02)
{
	[[ level.var_128D.var_69B4 ]](param_00,param_01,param_02);
}

//Function Number: 167
func_116D7(param_00,param_01,param_02)
{
	if(param_00)
	{
		return param_01;
	}

	return param_02;
}

//Function Number: 168
func_4914(param_00,param_01)
{
	if(!isdefined(param_01))
	{
		param_01 = 1;
	}

	if(!isdefined(level.var_AED4))
	{
		level.var_AED4 = [];
	}

	var_02 = spawnstruct();
	var_02.var_B425 = param_01;
	var_02.var_C1 = 0;
	level.var_AED4[param_00] = var_02;
}

//Function Number: 169
func_AED4(param_00)
{
	for(var_01 = level.var_AED4[param_00];var_01.var_C1 >= var_01.var_B425;var_01 waittill("unlocked"))
	{
	}

	var_01.var_C1++;
}

//Function Number: 170
func_12BD1(param_00)
{
	thread func_12BDC(param_00);
}

//Function Number: 171
func_12BDC(param_00)
{
	wait(0.05);
	var_01 = level.var_AED4[param_00];
	var_01.var_C1--;
	var_01 notify("unlocked");
}

//Function Number: 172
func_7CF1()
{
	var_00 = level.script;
	if(isdefined(level.var_116CC))
	{
		var_00 = level.var_116CC;
	}

	return var_00;
}

//Function Number: 173
func_9C70()
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

//Function Number: 174
func_22BD(param_00)
{
	var_01 = [];
	for(var_02 = param_00.size - 1;var_02 >= 0;var_02--)
	{
		var_01[var_01.size] = param_00[var_02];
	}

	return var_01;
}

//Function Number: 175
func_56F4(param_00,param_01)
{
	return length2dsquared(param_00 - param_01);
}

//Function Number: 176
func_7830(param_00,param_01,param_02,param_03,param_04,param_05)
{
	var_06 = func_782F(param_00,param_01,param_02,param_03,param_04,param_05);
	var_06 = func_22BD(var_06);
	return var_06;
}

//Function Number: 177
func_782F(param_00,param_01,param_02,param_03,param_04,param_05)
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

//Function Number: 178
func_5D14(param_00,param_01,param_02)
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

//Function Number: 179
func_13D90(param_00,param_01,param_02,param_03)
{
	var_04 = vectornormalize(param_02 - param_00);
	var_05 = anglestoforward(param_01);
	var_06 = vectordot(var_05,var_04);
	return var_06 >= param_03;
}

//Function Number: 180
func_B269(param_00,param_01)
{
	if(isdefined(level.var_2D9E) && isdefined(level.var_2D9E["bots_make_entity_sentient"]))
	{
		return self [[ level.var_2D9E["bots_make_entity_sentient"] ]](param_00,param_01);
	}
}

//Function Number: 181
func_1913(param_00)
{
	if(isdefined(level.var_2D9E) && isdefined(level.var_2D9E["ai_3d_sighting_model"]))
	{
		return self [[ level.var_2D9E["ai_3d_sighting_model"] ]](param_00);
	}
}

//Function Number: 182
getclosest(param_00,param_01,param_02)
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

//Function Number: 183
func_B82F(param_00,param_01,param_02)
{
	param_02 = func_116D7(isdefined(param_02),param_02,(0,0,0));
	self missile_settargetent(param_00,param_02);
	switch(param_01)
	{
		case "direct":
			self missile_setflightmodedirect();
			break;

		case "top":
			self missile_setflightmodetop();
			break;
	}
}

//Function Number: 184
add_fx(param_00,param_01)
{
	if(!isdefined(level._effect))
	{
		level._effect = [];
	}

	level._effect[param_00] = loadfx(param_01);
}

//Function Number: 185
func_22C3(param_00,param_01)
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

//Function Number: 186
func_16DC(param_00,param_01)
{
	if(!isdefined(level.var_74C2))
	{
		level.var_74C2 = [];
	}

	level.var_74C2[param_00] = param_01;
}

//Function Number: 187
func_95C6(param_00)
{
	if(!isdefined(level.var_74C2))
	{
		level.var_74C2 = [];
	}

	if(!isdefined(level.var_74C2[param_00]))
	{
		func_16DC(param_00,::func_61B9);
	}
}

//Function Number: 188
func_16F3(param_00,param_01)
{
	if(!isdefined(level.var_9724))
	{
		level.var_9724 = [];
	}

	if(isdefined(level.var_9724[param_00]))
	{
		return 0;
	}

	level.var_9724[param_00] = param_01;
	return 1;
}

//Function Number: 189
func_D959()
{
}

//Function Number: 190
func_C953()
{
	if(getdvar("g_connectpaths") == "2")
	{
		level waittill("eternity");
	}
}

//Function Number: 191
func_7E5E(param_00)
{
	if(!isdefined(param_00))
	{
		return "unknown";
	}

	param_00 = tolower(param_00);
	switch(param_00)
	{
		case "melee":
		case "mod_crush":
		case "mod_melee":
			return "melee";

		case "bullet":
		case "mod_rifle_bullet":
		case "mod_pistol_bullet":
			return "bullet";

		case "splash":
		case "mod_explosive":
		case "mod_projectile_splash":
		case "mod_projectile":
		case "mod_grenade_splash":
		case "mod_grenade":
			return "splash";

		case "mod_impact":
			return "impact";

		case "unknown":
			return "unknown";

		default:
			return "unknown";
	}
}

//Function Number: 192
func_16DA(param_00)
{
	if(!isdefined(self.var_735B))
	{
		self.var_735B = [param_00];
		thread func_D977();
		return;
	}

	self.var_735B[self.var_735B.size] = param_00;
}

//Function Number: 193
func_D977()
{
	for(;;)
	{
		if(isdefined(self))
		{
			foreach(var_01 in self.var_735B)
			{
				self thread [[ var_01 ]]();
			}
		}
		else
		{
			break;
		}

		wait(0.05);
	}
}

//Function Number: 194
func_5127(param_00,param_01,param_02,param_03,param_04,param_05,param_06,param_07)
{
	thread func_512D(param_01,param_00,param_02,param_03,param_04,param_05,param_06,param_07);
}

//Function Number: 195
func_512D(param_00,param_01,param_02,param_03,param_04,param_05,param_06,param_07)
{
	self endon("death");
	self endon("stop_delay_thread");
	wait(param_01);
	if(isdefined(param_07))
	{
		thread [[ param_00 ]](param_02,param_03,param_04,param_05,param_06,param_07);
		return;
	}

	if(isdefined(param_06))
	{
		thread [[ param_00 ]](param_02,param_03,param_04,param_05,param_06);
		return;
	}

	if(isdefined(param_05))
	{
		thread [[ param_00 ]](param_02,param_03,param_04,param_05);
		return;
	}

	if(isdefined(param_04))
	{
		thread [[ param_00 ]](param_02,param_03,param_04);
		return;
	}

	if(isdefined(param_03))
	{
		thread [[ param_00 ]](param_02,param_03);
		return;
	}

	if(isdefined(param_02))
	{
		thread [[ param_00 ]](param_02);
		return;
	}

	thread [[ param_00 ]]();
}

//Function Number: 196
func_9F11(param_00)
{
	if(isdefined(param_00.var_8C1E) && param_00.var_8C1E)
	{
		var_01 = self.origin - param_00.origin;
		var_02 = vectornormalize((var_01[0],var_01[1],0));
		var_03 = anglestoforward(param_00.angles);
		var_04 = vectordot(var_03,var_01);
		if(param_00.var_8C1F)
		{
			if(var_04 > 0.766)
			{
				return 1;
			}
		}
		else if(var_04 < -0.766)
		{
			return 1;
		}
	}

	return 0;
}

//Function Number: 197
func_9F10(param_00)
{
	var_01 = 0;
	var_02 = self getcurrentweapon();
	var_03 = self adsbuttonpressed();
	var_04 = 0;
	var_05 = 0;
	var_06 = 0;
	var_07 = anglestoforward(self.angles);
	var_08 = vectornormalize(param_00.origin - self.origin);
	var_09 = vectordot(var_08,var_07);
	if(var_09 > 0.5)
	{
		var_04 = 1;
	}

	if(var_02 == "iw6_axe_mp" || var_02 == "iw7_axe_zm")
	{
		var_06 = self method_8118();
		var_05 = 1;
	}

	if(var_05 && var_03 && var_04 && var_06 > 0)
	{
		self setweaponammoclip(var_02,var_06 - 1);
		self playsound("crate_impact");
		earthquake(0.75,0.5,self.origin,100);
		var_01 = 1;
	}

	return var_01;
}

//Function Number: 198
func_9D33(param_00)
{
	switch(param_00)
	{
		case "airdrop_escort_marker_mp":
		case "airdrop_tank_marker_mp":
		case "airdrop_juggernaut_maniac_mp":
		case "airdrop_juggernaut_def_mp":
		case "airdrop_juggernaut_mp":
		case "airdrop_sentry_marker_mp":
		case "airdrop_mega_marker_mp":
		case "airdrop_marker_support_mp":
		case "airdrop_marker_assault_mp":
		case "airdrop_marker_mp":
			return 1;

		default:
			return 0;
	}
}

//Function Number: 199
func_9DC1(param_00)
{
	if(!isdefined(param_00))
	{
		return 0;
	}

	switch(param_00)
	{
		case "barrel_mp":
		case "destructible_toy":
		case "destructible_car":
		case "destructible":
			return 1;
	}

	return 0;
}

//Function Number: 200
func_13C07(param_00)
{
	if(isdefined(param_00) && param_00 != "" && param_00 != "none")
	{
		var_01 = getweaponbasename(param_00);
		if(var_01 == "iw7_emc")
		{
			return "pistol";
		}

		if(var_01 == "iw7_devastator")
		{
			return "spread";
		}

		if(var_01 == "iw7_steeldragon")
		{
			return "beam";
		}
	}

	return weaponclass(param_00);
}

//Function Number: 201
func_4D59(param_00,param_01,param_02,param_03,param_04,param_05,param_06,param_07,param_08,param_09,param_0A,param_0B)
{
	if(isdefined(self.var_DD))
	{
		if(!isdefined(param_00))
		{
			return 0;
		}

		if(self.var_DD == param_00)
		{
			return 1;
		}

		if(!isdefined(param_01))
		{
			return 0;
		}

		if(self.var_DD == param_01)
		{
			return 1;
		}

		if(!isdefined(param_02))
		{
			return 0;
		}

		if(self.var_DD == param_02)
		{
			return 1;
		}

		if(!isdefined(param_03))
		{
			return 0;
		}

		if(self.var_DD == param_03)
		{
			return 1;
		}

		if(!isdefined(param_04))
		{
			return 0;
		}

		if(self.var_DD == param_04)
		{
			return 1;
		}

		if(!isdefined(param_05))
		{
			return 0;
		}

		if(self.var_DD == param_05)
		{
			return 1;
		}

		if(!isdefined(param_06))
		{
			return 0;
		}

		if(self.var_DD == param_06)
		{
			return 1;
		}

		if(!isdefined(param_07))
		{
			return 0;
		}

		if(self.var_DD == param_07)
		{
			return 1;
		}

		if(!isdefined(param_08))
		{
			return 0;
		}

		if(self.var_DD == param_08)
		{
			return 1;
		}

		if(!isdefined(param_09))
		{
			return 0;
		}

		if(self.var_DD == param_09)
		{
			return 1;
		}

		if(!isdefined(param_0A))
		{
			return 0;
		}

		if(self.var_DD == param_0A)
		{
			return 1;
		}
	}

	return func_4D6E(param_00,param_01,param_02,param_03,param_04,param_05,param_06,param_07,param_08,param_09,param_0A,param_0B);
}

//Function Number: 202
func_4D6E(param_00,param_01,param_02,param_03,param_04,param_05,param_06,param_07,param_08,param_09,param_0A,param_0B)
{
	if(!isdefined(self.var_4D46))
	{
		return 0;
	}

	if(!isdefined(param_00))
	{
		return 0;
	}

	if(self.var_4D46 == param_00)
	{
		return 1;
	}

	if(!isdefined(param_01))
	{
		return 0;
	}

	if(self.var_4D46 == param_01)
	{
		return 1;
	}

	if(!isdefined(param_02))
	{
		return 0;
	}

	if(self.var_4D46 == param_02)
	{
		return 1;
	}

	if(!isdefined(param_03))
	{
		return 0;
	}

	if(self.var_4D46 == param_03)
	{
		return 1;
	}

	if(!isdefined(param_04))
	{
		return 0;
	}

	if(self.var_4D46 == param_04)
	{
		return 1;
	}

	if(!isdefined(param_05))
	{
		return 0;
	}

	if(self.var_4D46 == param_05)
	{
		return 1;
	}

	if(!isdefined(param_06))
	{
		return 0;
	}

	if(self.var_4D46 == param_06)
	{
		return 1;
	}

	if(!isdefined(param_07))
	{
		return 0;
	}

	if(self.var_4D46 == param_07)
	{
		return 1;
	}

	if(!isdefined(param_08))
	{
		return 0;
	}

	if(self.var_4D46 == param_08)
	{
		return 1;
	}

	if(!isdefined(param_09))
	{
		return 0;
	}

	if(self.var_4D46 == param_09)
	{
		return 1;
	}

	if(!isdefined(param_0A))
	{
		return 0;
	}

	if(self.var_4D46 == param_0A)
	{
		return 1;
	}

	return 0;
}

//Function Number: 203
func_9D74(param_00)
{
	var_01 = "MOD_RIFLE_BULLET MOD_PISTOL_BULLET MOD_HEAD_SHOT";
	if(issubstr(var_01,param_00))
	{
		return 1;
	}

	return 0;
}

//Function Number: 204
func_9EB4(param_00)
{
	return param_00.type == "Cover Left";
}

//Function Number: 205
func_9EB7(param_00)
{
	return param_00.type == "Cover Right";
}

//Function Number: 206
func_9EB1(param_00)
{
	return func_9EB2(param_00) || func_9EB8(param_00);
}

//Function Number: 207
func_9EB2(param_00)
{
	return param_00.type == "Cover Stand 3D" || param_00.type == "Cover 3D";
}

//Function Number: 208
func_9EB8(param_00)
{
	return param_00.type == "Exposed 3D" || param_00.type == "Path 3D";
}

//Function Number: 209
func_9EB3(param_00)
{
	return param_00.type == "Cover Crouch" || param_00.type == "Cover Crouch Window" || param_00.type == "Conceal Crouch";
}

//Function Number: 210
func_152F(param_00)
{
	return abs(angleclamp180(param_00));
}

//Function Number: 211
func_7DA7(param_00)
{
	var_01 = func_824D(param_00);
	var_02 = distance(self.origin,param_00);
	if(var_02 > 3)
	{
		var_03 = asin(-3 / var_02);
		var_01 = var_01 - var_03;
	}

	var_01 = angleclamp180(var_01);
	return var_01;
}

//Function Number: 212
func_824D(param_00)
{
	if(func_167E())
	{
		var_01 = anglestoforward(self.angles);
		var_02 = rotatepointaroundvector(var_01,param_00 - self.origin,self.angles[2] * -1);
		param_00 = var_02 + self.origin;
	}

	var_03 = func_8246(param_00) - self.angles[1];
	var_03 = angleclamp180(var_03);
	return var_03;
}

//Function Number: 213
func_8246(param_00)
{
	return vectortoyaw(param_00 - self.origin);
}

//Function Number: 214
func_7DA6(param_00)
{
	var_01 = func_824C(param_00);
	var_02 = distance(self.origin,param_00);
	if(var_02 > 3)
	{
		var_03 = asin(-3 / var_02);
		var_01 = var_01 - var_03;
	}

	var_01 = angleclamp180(var_01);
	return var_01;
}

//Function Number: 215
func_824C(param_00)
{
	var_01 = param_00 - self.origin;
	var_02 = rotatevectorinverted(var_01,self.angles);
	var_03 = vectortoyaw(var_02);
	var_04 = angleclamp180(var_03);
	return var_04;
}

//Function Number: 216
func_7DA4(param_00)
{
	var_01 = func_8066(param_00);
	var_02 = distance(self.origin,param_00);
	if(var_02 > 3)
	{
		var_03 = asin(-3 / var_02);
		var_01 = var_01 - var_03;
	}

	var_01 = angleclamp180(var_01);
	return var_01;
}

//Function Number: 217
func_8066(param_00)
{
	var_01 = param_00 - self.origin;
	var_02 = rotatevectorinverted(var_01,self.angles);
	var_03 = function_02D1(var_02);
	var_04 = angleclamp180(var_03);
	return var_04;
}

//Function Number: 218
func_167F()
{
	return istrue(self.var_2A6);
}

//Function Number: 219
func_167E()
{
	return func_167F();
}

//Function Number: 220
func_8094(param_00,param_01,param_02)
{
	if(!isdefined(param_01))
	{
		if(!isdefined(param_02))
		{
			return 0;
		}

		return func_7DA7(param_02);
	}

	var_03 = (0,0,0);
	if(isplayer(param_01))
	{
		var_03 = param_01 getvelocity();
	}
	else if(isai(param_01))
	{
		var_03 = param_01.var_381;
	}

	var_04 = param_01.origin + var_03 * param_00;
	return func_7DA7(var_04);
}

//Function Number: 221
func_8093(param_00,param_01,param_02)
{
	if(!isdefined(param_01))
	{
		if(!isdefined(param_02))
		{
			return 0;
		}

		return func_7DA6(param_02);
	}

	var_03 = (0,0,0);
	if(isplayer(param_01))
	{
		var_03 = param_01 getvelocity();
	}
	else if(isai(param_01))
	{
		var_03 = param_01.var_381;
	}

	var_04 = param_01.origin + var_03 * param_00;
	return func_7DA6(var_04);
}

//Function Number: 222
func_8092(param_00,param_01,param_02)
{
	if(!isdefined(param_01))
	{
		if(!isdefined(param_02))
		{
			return 0;
		}

		return func_7DA4(param_02);
	}

	var_03 = (0,0,0);
	if(isplayer(param_01))
	{
		var_03 = param_01 getvelocity();
	}
	else if(isai(param_01))
	{
		var_03 = param_01.var_381;
	}

	var_04 = param_01.origin + var_03 * param_00;
	return func_7DA4(var_04);
}

//Function Number: 223
func_B616()
{
	var_00 = ["mars_killstreak","iw7_jackal_support_designator"];
	if(func_2286(var_00,level.player getcurrentweapon()))
	{
		return 1;
	}

	if(level.player method_81C4())
	{
		return 1;
	}

	if(level.player method_81C3())
	{
		if(func_2286(var_00,level.player getcurrentweapon()))
		{
			return 1;
		}
	}

	return 0;
}

//Function Number: 224
func_1390D()
{
	if(!isdefined(self.var_DE) || self.var_DE != "MOD_MELEE")
	{
		return 0;
	}

	if(!isdefined(self.var_E2) || function_024C(self.var_E2) != "shield")
	{
		return 0;
	}

	return 1;
}

//Function Number: 225
istrue(param_00)
{
	if(isdefined(param_00) && param_00)
	{
		return 1;
	}

	return 0;
}

//Function Number: 226
func_D11B()
{
	if(isdefined(level.player method_8473()))
	{
		return 1;
	}

	return 0;
}

//Function Number: 227
func_F315()
{
	if(!isdefined(level.createfx_enabled))
	{
		level.createfx_enabled = getdvar("createfx") != "";
	}
}

//Function Number: 228
func_6E3F(param_00,param_01,param_02)
{
	wait(param_01);
	flag_set(param_00,param_02);
}

//Function Number: 229
func_C0A5(param_00,param_01,param_02,param_03,param_04)
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

//Function Number: 230
func_6E27(param_00)
{
}

//Function Number: 231
func_6E52(param_00,param_01)
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

//Function Number: 232
func_6E53(param_00,param_01)
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

		var_02 = level func_13734(param_00,param_01);
		return var_02;
	}
}

//Function Number: 233
func_6E4E(param_00,param_01,param_02,param_03,param_04,param_05)
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
		func_6E52(param_00,param_01);
		return;
	}
	else
	{
		return;
	}

	for(;;)
	{
		for(var_07 = 0;var_07 < var_06.size;var_07++)
		{
			if(flag(var_06[var_07]))
			{
				return;
			}
		}

		level waittill_any_3(param_00,param_01,param_02,param_03,param_04,param_05);
	}
}

//Function Number: 234
func_6E4F(param_00,param_01,param_02,param_03,param_04)
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
		var_06 = func_6E53(param_00,param_01);
		return var_06;
	}
	else
	{
		return;
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

		var_06 = level func_13734(param_01,param_02,param_03,param_04,var_05);
		return var_07;
	}
}

//Function Number: 235
func_6E4D(param_00,param_01,param_02,param_03)
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

//Function Number: 236
func_6E59(param_00,param_01)
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
		func_135D4(param_00,var_05);
	}
}

//Function Number: 237
func_6E5C(param_00,param_01)
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

		func_135D4(param_00,param_01);
	}
}

//Function Number: 238
func_135D4(param_00,param_01)
{
	level endon(param_00);
	wait(param_01);
}

//Function Number: 239
func_C0A6(param_00,param_01,param_02,param_03,param_04,param_05)
{
	thread func_C0AB(param_01,param_00,param_02,param_03,param_04,param_05);
}

//Function Number: 240
func_C0AB(param_00,param_01,param_02,param_03,param_04,param_05)
{
	wait(param_01);
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

//Function Number: 241
func_7CCF(param_00)
{
	if(!isdefined(param_00))
	{
		param_00 = self.target;
	}

	var_01 = getentarray(param_00,"targetname");
	if(var_01.size > 0)
	{
		return var_01;
	}

	if(issp())
	{
		var_01 = [[ level.var_7FF3 ]](param_00,"targetname");
		if(var_01.size > 0)
		{
			return var_01;
		}
	}

	var_01 = getstructarray(param_00,"targetname");
	if(var_01.size > 0)
	{
		return var_01;
	}

	var_01 = getvehiclenodearray(param_00,"targetname");
	if(var_01.size > 0)
	{
		return var_01;
	}
}

//Function Number: 242
func_C9CF()
{
	scripts\common\createfx::func_10FF7();
}

//Function Number: 243
func_107CE(param_00,param_01)
{
	if(!isdefined(param_01) && isdefined(self.angles))
	{
		param_01 = self.angles;
	}

	if(!isdefined(param_00) && isdefined(self.origin))
	{
		param_00 = self.origin;
	}
	else if(!isdefined(param_00))
	{
		param_00 = (0,0,0);
	}

	var_02 = spawn("script_origin",param_00);
	if(isdefined(param_01))
	{
		var_02.angles = param_01;
	}

	return var_02;
}

//Function Number: 244
func_1C4F(param_00)
{
	if(param_00)
	{
		if(!isdefined(self.var_55D1))
		{
			self.var_55D1 = 0;
		}
		else
		{
			self.var_55D1--;
		}

		if(!self.var_55D1)
		{
			self method_800E(1);
			return;
		}

		return;
	}

	if(!isdefined(self.var_55D1))
	{
		self.var_55D1 = 0;
	}

	self.var_55D1++;
	self method_800E(0);
}

//Function Number: 245
func_1C62(param_00,param_01)
{
	if(param_00)
	{
		if(!isdefined(self.var_55DE))
		{
			self.var_55DE = 0;
		}
		else
		{
			self.var_55DE--;
		}

		if(!self.var_55DE)
		{
			self method_8471(1);
			return;
		}

		return;
	}

	if(!isdefined(self.var_55DE))
	{
		self.var_55DE = 0;
	}

	self.var_55DE++;
	self method_8471(0);
	if(!isdefined(param_01) || !param_01)
	{
		self method_8545();
	}
}

//Function Number: 246
func_1C3A(param_00)
{
	if(param_00)
	{
		if(!isdefined(self.var_55C1))
		{
			self.var_55C1 = 0;
		}
		else
		{
			self.var_55C1--;
		}

		if(!self.var_55C1)
		{
			self enableautoreload();
			return;
		}

		return;
	}

	if(!isdefined(self.var_55C1))
	{
		self.var_55C1 = 0;
	}

	self.var_55C1++;
	self disableautoreload();
}

//Function Number: 247
func_725F()
{
	self.var_55E6 = 0;
	self enableweapons();
}

//Function Number: 248
func_725D()
{
	self.var_55C8 = 0;
	self method_800C(1);
}

//Function Number: 249
func_725E()
{
	self.var_55D5 = 0;
	self allowmelee(1);
}

//Function Number: 250
func_7B26(param_00)
{
	var_01 = getentarray(param_00,"script_noteworthy");
	if(var_01.size > 0)
	{
		return var_01;
	}

	if(issp())
	{
		var_01 = [[ level.var_7FF3 ]](param_00,"script_noteworthy");
		if(var_01.size > 0)
		{
			return var_01;
		}
	}

	var_01 = getstructarray(param_00,"script_noteworthy");
	if(var_01.size > 0)
	{
		return var_01;
	}

	var_01 = getvehiclenodearray(param_00,"script_noteworthy");
	if(var_01.size > 0)
	{
		return var_01;
	}
}

//Function Number: 251
func_78F6(param_00)
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

//Function Number: 252
func_1352A()
{
}

//Function Number: 253
func_9DA3()
{
	if(!isdefined(self.var_10C))
	{
		return 0;
	}

	if(!issentient(self.var_10C))
	{
		return 1;
	}

	if(self method_805F(self.var_10C))
	{
		return 1;
	}

	var_00 = self lastknowntime(self.var_10C);
	if(var_00 == 0)
	{
		return 0;
	}

	var_01 = gettime() - var_00;
	if(var_01 > 10000)
	{
		return 0;
	}

	if(distancesquared(self.var_10C.origin,self.origin) > 4194304)
	{
		return 0;
	}

	return 1;
}

//Function Number: 254
func_7B25(param_00,param_01)
{
	var_02 = getnotetracktimes(param_00,param_01);
	var_03 = getanimlength(param_00);
	return var_02[0] * var_03;
}

//Function Number: 255
func_BD6A(param_00)
{
	return param_00 * 17.6;
}

//Function Number: 256
func_9B3C(param_00)
{
	return param_00 * 0.056818;
}

//Function Number: 257
func_42A1(param_00,param_01,param_02,param_03)
{
	var_04 = param_00 - param_02;
	var_05 = param_03 - param_02;
	if(abs(var_05[0]) < 1E-06 && abs(var_05[1]) < 1E-06 && abs(var_05[2]) < 1E-06)
	{
		return undefined;
	}

	var_06 = param_01 - param_00;
	if(abs(var_06[0]) < 1E-06 && abs(var_06[1]) < 1E-06 && abs(var_06[2]) < 1E-06)
	{
		return undefined;
	}

	var_07 = var_04[0] * var_05[0] + var_04[1] * var_05[1] + var_04[2] * var_05[2];
	var_08 = var_05[0] * var_06[0] + var_05[1] * var_06[1] + var_05[2] * var_06[2];
	var_09 = var_04[0] * var_06[0] + var_04[1] * var_06[1] + var_04[2] * var_06[2];
	var_0A = var_05[0] * var_05[0] + var_05[1] * var_05[1] + var_05[2] * var_05[2];
	var_0B = var_06[0] * var_06[0] + var_06[1] * var_06[1] + var_06[2] * var_06[2];
	var_0C = var_0B * var_0A - var_08 * var_08;
	if(abs(var_0C) < 1E-06)
	{
		return undefined;
	}

	var_0D = var_07 * var_08 - var_09 * var_0A;
	var_0E = var_0D / var_0C;
	var_0F = var_07 + var_08 * var_0E / var_0A;
	var_10 = param_00 + var_0E * var_06;
	var_11 = param_02 + var_0F * var_05;
	var_12 = [var_10,var_11,distance(var_10,var_11)];
	return var_12;
}

//Function Number: 258
func_42A2(param_00,param_01,param_02,param_03)
{
	var_04 = param_01 - param_00;
	var_05 = param_03 - param_02;
	var_06 = param_00 - param_02;
	var_07 = vectordot(var_04,var_04);
	var_08 = vectordot(var_04,var_05);
	var_09 = vectordot(var_05,var_05);
	var_0A = vectordot(var_04,var_06);
	var_0B = vectordot(var_05,var_06);
	var_0C = var_07 * var_09 - var_08 * var_08;
	var_0D = var_0C;
	var_0E = var_0C;
	var_0F = 0;
	var_10 = 0;
	var_11 = 0;
	var_12 = 0;
	if(var_0C < 1E-08)
	{
		var_10 = 0;
		var_0D = 1;
		var_12 = var_0B;
		var_0E = var_09;
	}
	else
	{
		var_10 = var_08 * var_0B - var_09 * var_0A;
		var_12 = var_07 * var_0B - var_08 * var_0A;
		if(var_10 < 0)
		{
			var_10 = 0;
			var_12 = var_0B;
			var_0E = var_09;
		}
		else if(var_10 > var_0D)
		{
			var_10 = var_0D;
			var_12 = var_0B + var_08;
			var_0E = var_09;
		}
	}

	if(var_12 < 0)
	{
		var_12 = 0;
		if(var_0A * -1 < 0)
		{
			var_10 = 0;
		}
		else if(var_0A * -1 > var_07)
		{
			var_10 = var_0D;
		}
		else
		{
			var_10 = var_0A * -1;
			var_0D = var_07;
		}
	}
	else if(var_12 > var_0E)
	{
		var_12 = var_0E;
		if(var_08 - var_0A < 0)
		{
			var_10 = 0;
		}
		else if(var_08 - var_0A > var_07)
		{
			var_10 = var_0D;
		}
		else
		{
			var_10 = var_08 - var_0A;
			var_0D = var_07;
		}
	}

	if(abs(var_10) > 1E-08)
	{
		var_0F = var_10 / var_0D;
	}

	if(abs(var_12) > 1E-08)
	{
		var_11 = var_12 / var_0E;
	}

	var_13 = param_00 + var_0F * var_04;
	var_14 = param_02 + var_11 * var_05;
	var_15 = [var_13,var_14,distance(var_13,var_14)];
	return var_15;
}

//Function Number: 259
getcamotablecolumnindex(param_00)
{
	switch(param_00)
	{
		case "index":
			return 0;

		case "ref":
			return 1;

		case "type":
			return 2;

		case "target_material":
			return 3;

		case "tint":
			return 4;

		case "atlas_dims":
			return 5;

		case "name":
			return 6;

		case "image":
			return 7;

		case "weapon_index":
			return 8;

		case "bot_valid":
			return 9;

		case "description":
			return 10;

		case "category":
			return 11;

		default:
			return undefined;
	}
}