/*******************************************************************
 * Decompiled By: Bog
 * Decompiled File: scripts\mp\_callbacksetup.gsc
 * Game: Call of Duty: Infinite Warfare
 * Platform: PC
 * Function Count: 16
 * Decompile Time: 561 ms
 * Timestamp: 10/27/2023 12:32:08 AM
*******************************************************************/

//Function Number: 1
func_00B7()
{
	if(getdvar("r_reflectionProbeGenerate") == "1")
	{
		level waittill("eternity");
	}

	if(!isdefined(level.var_768E) || !level.var_768E)
	{
		[[ level.var_3768 ]]();
		level.var_768E = 1;
	}
}

//Function Number: 2
func_00AD()
{
	if(getdvar("r_reflectionProbeGenerate") == "1")
	{
		level waittill("eternity");
	}

	self endon("disconnect");
	[[ level.var_375F ]]();
}

//Function Number: 3
func_00AF(param_00)
{
	self notify("disconnect");
	[[ level.var_3761 ]](param_00);
}

//Function Number: 4
func_00AE(param_00,param_01,param_02,param_03,param_04,param_05,param_06,param_07,param_08,param_09,param_0A,param_0B)
{
	self endon("disconnect");
	if(isdefined(level.var_13CA6))
	{
		param_05 = [[ level.var_13CA6 ]](param_05,param_00);
	}

	[[ level.callbackplayerdamage ]](param_00,param_01,param_02,param_03,param_04,param_05,param_06,param_07,param_08,param_09,param_0A,param_0B);
}

//Function Number: 5
func_00B4(param_00,param_01,param_02,param_03)
{
	self endon("disconnect");
	if(isdefined(level.var_13CA6))
	{
		param_00 = [[ level.var_13CA6 ]](param_00);
	}

	if(isdefined(level.var_13CA6))
	{
		param_02 = [[ level.var_13CA6 ]](param_02);
	}
}

//Function Number: 6
func_00B5(param_00,param_01)
{
	self endon("disconnect");
	if(isdefined(level.var_13CA6))
	{
		param_00 = [[ level.var_13CA6 ]](param_00);
	}
}

//Function Number: 7
func_00B6(param_00,param_01,param_02,param_03)
{
	self endon("disconnect");
	if(isdefined(level.var_13CA6))
	{
		param_00 = [[ level.var_13CA6 ]](param_00);
	}

	if(isdefined(level.var_13CA6))
	{
		param_02 = [[ level.var_13CA6 ]](param_02);
	}

	if(isdefined(level.callbackfinishweaponchange))
	{
		[[ level.callbackfinishweaponchange ]](param_02,param_00,param_03,param_01);
	}
}

//Function Number: 8
func_00B0(param_00,param_01,param_02,param_03,param_04,param_05,param_06,param_07)
{
	self endon("disconnect");
	if(isdefined(level.var_13CA6))
	{
		param_01 = [[ level.var_13CA6 ]](param_01);
	}

	[[ level.var_3762 ]](param_00,param_01,param_02,param_03,param_04,param_05,param_06,param_07);
}

//Function Number: 9
func_00B1(param_00,param_01,param_02,param_03,param_04,param_05,param_06,param_07,param_08,param_09)
{
	self endon("disconnect");
	if(isdefined(level.var_13CA6))
	{
		param_05 = [[ level.var_13CA6 ]](param_05,param_00);
	}

	[[ level.var_3763 ]](param_00,param_01,param_02,param_03,param_04,param_05,param_06,param_07,param_08,param_09);
}

//Function Number: 10
func_00B8(param_00,param_01,param_02,param_03,param_04,param_05,param_06,param_07,param_08,param_09,param_0A,param_0B)
{
	if(isdefined(level.var_13CA6))
	{
		param_05 = [[ level.var_13CA6 ]](param_05,param_00);
	}

	if(isdefined(self.var_C1D4))
	{
		var_0C = [[ self.var_C1D4 ]](param_01);
		if(isdefined(var_0C) && var_0C)
		{
			return;
		}
	}

	if(isdefined(self.var_4D2E))
	{
		self [[ self.var_4D2E ]](param_00,param_01,param_02,param_03,param_04,param_05,param_06,param_07,param_08,param_09,param_0A,param_0B);
		return;
	}

	self method_83DB(param_00,param_01,param_02,param_03,param_04,param_05,param_06,param_07,param_08,param_09,param_0A,param_0B);
}

//Function Number: 11
func_00B2(param_00,param_01,param_02,param_03,param_04,param_05,param_06,param_07,param_08)
{
	self endon("disconnect");
	if(isdefined(level.var_13CA6))
	{
		param_04 = [[ level.var_13CA6 ]](param_04,param_00);
	}

	[[ level.var_3764 ]](param_00,param_01,param_02,param_03,param_04,param_05,param_06,param_07,param_08);
}

//Function Number: 12
func_00B3()
{
	self endon("disconnect");
	[[ level.var_3766 ]]();
}

//Function Number: 13
func_00AB()
{
	[[ level.var_375E ]]();
}

//Function Number: 14
func_FAA2()
{
	level.var_92C5 = 1;
	level.var_92BF = 2;
	level.var_92C0 = 4;
	level.var_92C4 = 8;
	level.var_92CA = 16;
	level.var_92C7 = 32;
	level.var_92C8 = 64;
	level.var_92C9 = 128;
	level.var_92C6 = 256;
	level.var_92C2 = 512;
	level.var_92C1 = 1024;
	level.var_92C3 = 2048;
}

//Function Number: 15
func_1528()
{
	level.var_3768 = ::func_3769;
	level.var_375F = ::func_3769;
	level.var_3761 = ::func_3769;
	level.callbackplayerdamage = ::func_3769;
	level.var_3762 = ::func_3769;
	level.var_3763 = ::func_3769;
	level.var_3764 = ::func_3769;
	level.var_3766 = ::func_3769;
	level.var_375E = ::func_3769;
	setdvar("g_gametype","dm");
	exitlevel(0);
}

//Function Number: 16
func_3769()
{
}