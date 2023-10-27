/*******************************************************************
 * Decompiled By: Bog
 * Decompiled File: scripts\sp\_vehicle.gsc
 * Game: Call of Duty: Infinite Warfare
 * Platform: PC
 * Function Count: 39
 * Decompile Time: 1817 ms
 * Timestamp: 10/27/2023 12:25:49 AM
*******************************************************************/

//Function Number: 1
func_979A()
{
	if(isdefined(level.var_5619) && level.var_5619)
	{
		return;
	}

	if(!scripts\common\utility::func_16F3("vehicles",::func_979A))
	{
		return;
	}

	thread func_979B();
	scripts\sp\_utility::func_D6D9(::func_40D9);
}

//Function Number: 2
func_40D9()
{
	level.var_13570 = undefined;
	level.var_13571 = undefined;
	level.var_13575 = undefined;
}

//Function Number: 3
func_979B()
{
	scripts\common\utility::func_4914("aircraft_wash_math");
	scripts\sp\_vehicle_code::func_F9C7();
	level.var_131A0.var_8DAA = scripts\common\utility::array_combine(level.var_131A0.var_8DAA,scripts\sp\_utility::func_8181("helicopter_crash_location","targetname"));
	scripts\sp\_vehicle_code::func_FA79();
	var_00 = scripts\sp\_vehicle_code::func_D808();
	scripts\sp\_vehicle_code::func_FA7A(var_00);
	level.var_131A0.var_8BBA = getentarray("script_vehicle","code_classname").size > 0;
	scripts\sp\_utility::func_16EB("invulerable_frags",&"SCRIPT_INVULERABLE_FRAGS",undefined);
	scripts\sp\_utility::func_16EB("invulerable_bullets",&"SCRIPT_INVULERABLE_BULLETS",undefined);
	scripts\sp\_utility::func_16EB("c12_bullets",&"SCRIPT_C12_BULLETS");
}

//Function Number: 4
func_1321A(param_00,param_01,param_02)
{
	return lib_0B98::func_1442(param_00,param_01,param_02);
}

//Function Number: 5
func_13237(param_00)
{
	return scripts\sp\_vehicle_code::func_1444(param_00);
}

//Function Number: 6
func_A5DF(param_00,param_01)
{
	return scripts\sp\_vehicle_code::func_12FB(param_00,param_01);
}

//Function Number: 7
func_8441()
{
	self.var_843F = 1;
}

//Function Number: 8
func_8440()
{
	self.var_843F = 0;
}

//Function Number: 9
func_B6B9()
{
	return scripts\sp\_vehicle_code::func_134C();
}

//Function Number: 10
func_B6BA()
{
	return scripts\sp\_vehicle_code::func_134D();
}

//Function Number: 11
func_9FEF()
{
	return isdefined(self.var_380);
}

//Function Number: 12
func_131F7()
{
	return scripts\sp\_vehicle_code::func_143E();
}

//Function Number: 13
func_9BF2()
{
	return scripts\sp\_vehicle_code::func_12F0();
}

//Function Number: 14
func_131FC()
{
	self notify("kill_rumble_forever");
}

//Function Number: 15
func_1080E(param_00)
{
	var_01 = [];
	var_01 = scripts\sp\_vehicle_code::func_10810(param_00);
	return var_01;
}

//Function Number: 16
func_1080C(param_00)
{
	var_01 = func_1080E(param_00);
	return var_01[0];
}

//Function Number: 17
func_1080D(param_00)
{
	var_01 = func_1080E(param_00);
	thread lib_0B98::func_845A(var_01[0]);
	return var_01[0];
}

//Function Number: 18
func_1080F(param_00)
{
	var_01 = func_1080E(param_00);
	foreach(var_03 in var_01)
	{
		thread lib_0B98::func_845A(var_03);
	}

	return var_01;
}

//Function Number: 19
func_1A92(param_00)
{
	thread scripts\sp\_vehicle_code::func_1A93(param_00);
}

//Function Number: 20
func_13259()
{
	scripts\sp\_vehicle_code::func_13D03(1);
}

//Function Number: 21
func_13258()
{
	scripts\sp\_vehicle_code::func_13D03(0);
}

//Function Number: 22
func_9BC7()
{
	return self.var_B91F;
}

//Function Number: 23
func_1320F(param_00,param_01,param_02)
{
	if(!isarray(param_00))
	{
		param_00 = [param_00];
	}

	scripts\sp\_vehicle_aianim::func_ADA7(param_00,undefined,param_02);
}

//Function Number: 24
func_1080B()
{
	var_00 = scripts\sp\_utility::func_10808();
	if(isdefined(self.var_EEBE))
	{
		if(!func_9E2C())
		{
			var_00 method_83F4(self.var_EEBE);
		}
	}

	thread lib_0B98::func_845A(var_00);
	return var_00;
}

//Function Number: 25
func_2470(param_00)
{
	self method_83E7(param_00.origin,param_00.angles);
	if(!func_9E2C())
	{
		scripts\common\utility::func_136F7();
		self attachpath(param_00);
	}

	thread func_1321A(param_00,1);
}

//Function Number: 26
func_2471(param_00)
{
	self method_83E7(param_00.origin,param_00.angles);
	scripts\common\utility::func_136F7();
	if(!func_9E2C())
	{
		self attachpath(param_00);
	}

	thread func_1321A(param_00);
	lib_0B98::func_845A(self);
}

//Function Number: 27
func_131DF(param_00)
{
	var_01 = [];
	var_02 = self.classname;
	if(!isdefined(level.var_131A0.var_116CE.var_12BCF[var_02]))
	{
		return var_01;
	}

	var_03 = level.var_131A0.var_116CE.var_12BCF[var_02];
	if(!isdefined(param_00))
	{
		return var_01;
	}

	foreach(var_05 in self.var_E4FB)
	{
		foreach(var_07 in var_03[param_00])
		{
			if(var_05.var_1321D == var_07)
			{
				var_01[var_01.size] = var_05;
			}
		}
	}

	return var_01;
}

//Function Number: 28
func_13253(param_00)
{
	return scripts\sp\_vehicle_code::func_1446(param_00);
}

//Function Number: 29
func_13250()
{
	self notify("stop_scanning_turret");
}

//Function Number: 30
func_131DD()
{
	self endon("death");
	var_00 = [];
	var_01 = self.var_247E;
	if(!isdefined(self.var_247E))
	{
		return var_00;
	}

	var_02 = var_01;
	var_02.var_46B3 = 0;
	while(isdefined(var_02))
	{
		if(isdefined(var_02.var_46B3) && var_02.var_46B3 == 1)
		{
			break;
		}

		var_00 = scripts\common\utility::array_add(var_00,var_02);
		var_02.var_46B3 = 1;
		if(!isdefined(var_02.target))
		{
			break;
		}

		if(!func_9E2C())
		{
			var_02 = getvehiclenode(var_02.target,"targetname");
			continue;
		}

		var_02 = scripts\sp\_utility::func_7E96(var_02.target,"targetname");
	}

	return var_00;
}

//Function Number: 31
func_1320C(param_00,param_01)
{
	if(!isdefined(param_00))
	{
		param_00 = "all";
	}

	lib_0B97::func_ACCE(param_00,param_01);
}

//Function Number: 32
func_1320B(param_00,param_01)
{
	lib_0B97::func_ACCC(param_00,param_01);
}

//Function Number: 33
func_13245(param_00,param_01)
{
	self method_8344(param_00,param_01);
	self.var_247E = param_01;
	thread func_1321A();
}

//Function Number: 34
func_13244(param_00,param_01,param_02)
{
	return lib_0B98::func_1445(param_00,param_01,param_02);
}

//Function Number: 35
func_13220(param_00)
{
	return lib_0B98::func_1443(param_00);
}

//Function Number: 36
func_9E2C()
{
	return scripts\sp\_vehicle_code::func_12F8();
}

//Function Number: 37
func_9D34()
{
	return scripts\sp\_vehicle_code::func_12F6();
}

//Function Number: 38
func_3182(param_00)
{
	if(!isdefined(level.var_131A0.var_116CE.var_4E12))
	{
		level.var_131A0.var_116CE.var_4E12 = [];
	}

	var_01 = spawnstruct();
	var_01.var_50AE = param_00;
	level.var_131A0.var_116CE.var_4E12[level.var_13570] = var_01;
}

//Function Number: 39
func_61FB()
{
	scripts\sp\_vehicle_code::func_F9C7();
	level.var_131A0.var_10709 = 1;
}