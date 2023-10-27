/*******************************************************************
 * Decompiled By: Bog
 * Decompiled File: maps\mp\killstreaks\_firebomb.gsc
 * Game: Call of Duty: WWII
 * Platform: PC
 * Function Count: 11
 * Decompile Time: 139 ms
 * Timestamp: 10/27/2023 3:24:56 AM
*******************************************************************/

//Function Number: 1
func_00D5()
{
	setdvarifuninitialized("firebomb_debug",0);
	level.var_80B7["firebomb"] = 230;
	level.var_80B8["firebomb"] = 65;
	level.var_80B6["firebomb"] = -1;
	level.var_80B9["firebomb"] = 6;
	level.var_80B5["firebomb"] = 24;
	level.var_5A61["firebomb"] = ::func_9E2B;
	level.var_5A7D["firebomb_bomb_mp"] = "firebomb";
	level.var_5A7D["firebomb_bomb_axis_mp"] = "firebomb";
	level.var_5A7D["firebomb_bomb_grenadier_mp"] = "firebomb";
	level.var_5A7D["firebomb_bomb_axis_grenadier_mp"] = "firebomb";
	level.var_5A7D["firebomb_flames_mp"] = "firebomb";
	level.var_8D5 = 0;
}

//Function Number: 2
func_9E2B(param_00)
{
	if(isdefined(level.var_8D5) && level.var_8D5 > 0)
	{
		self iclientprintlnbold(&"KILLSTREAKS_FIREBOMB_ALREADY_ACTIVE");
		return 0;
	}

	if(isdefined(self.var_6E6B) && self.var_6E6B)
	{
		self iclientprintlnbold(&"KILLSTREAKS_DLC4_CANT_USE_STREAK_WHILE_PARATROOPING");
		return 0;
	}

	if(lib_0527::func_9E3A(param_00,"firebomb"))
	{
		self.var_3BD6 = 0;
		return 1;
	}

	return 0;
}

//Function Number: 3
func_27EC(param_00)
{
	self waittill("death");
	if(!isdefined(self) || !isdefined(self.var_116))
	{
		return;
	}

	var_01 = self.var_116;
	var_02 = self.var_1D;
	var_03 = self.var_117;
	var_04 = self.var_1A7;
	level.var_8D5++;
	wait(1);
	level thread func_749A(var_01,param_00);
	level thread func_6393(var_01,var_02,var_03,var_04,param_00);
}

//Function Number: 4
func_749B(param_00,param_01)
{
	var_02 = undefined;
	var_02 = spawnfx(level.var_611["fire_bomb_fire"],param_00);
	triggerfx(var_02);
	wait(12);
	if(isdefined(var_02))
	{
		var_02 delete();
	}
}

//Function Number: 5
func_749A(param_00,param_01)
{
	var_02 = lib_0380::func_6842("ks_firebomb_burn_loop",undefined,param_00,2);
	if(param_01)
	{
		wait(16);
	}
	else
	{
		wait(12);
	}

	lib_0380::func_6850(var_02,1.5);
}

//Function Number: 6
func_6393(param_00,param_01,param_02,param_03,param_04)
{
	level endon("game_ended");
	if(!isdefined(param_00) || !isdefined(param_01))
	{
		return;
	}

	var_05 = gettime();
	var_06 = 0;
	var_07 = anglestoforward(param_01);
	var_07 = (var_07[0],var_07[1],0);
	var_07 = vectornormalize(var_07);
	if(param_04)
	{
		var_08 = 16;
	}
	else
	{
		var_08 = 12;
	}

	while(var_06 < var_08)
	{
		foreach(var_0A in level.var_744A)
		{
			if(function_0279(var_0A))
			{
				continue;
			}

			if(var_0A.var_1A7 != param_03 || (isdefined(param_02) && var_0A == param_02) || isdefined(level.var_4B17) && level.var_4B17)
			{
				if(!isdefined(var_0A.var_A019))
				{
					if(!isdefined(var_0A.var_5B9A) || var_0A.var_5B9A != gettime())
					{
						if(func_73E1(var_0A,param_00,var_07))
						{
							if(func_740F(var_0A,param_00))
							{
								var_0A.var_5B9A = gettime();
								var_0A dodamage(40,var_0A.var_116,param_02,undefined,"MOD_BURNED","firebomb_flames_mp");
							}
						}
					}
				}
			}
		}

		wait(0.4);
		var_06 = gettime() - var_05 / 1000;
	}

	level.var_8D5--;
}

//Function Number: 7
func_73E1(param_00,param_01,param_02)
{
	if(!isdefined(param_01))
	{
		return 0;
	}

	var_03 = param_00 getorigin();
	if(var_03[2] - param_01[2] > 256)
	{
		return 0;
	}

	var_04 = 103;
	var_05 = func_2825(param_01,param_02,var_04);
	return func_7542(var_03,var_05);
}

//Function Number: 8
func_2825(param_00,param_01,param_02)
{
	var_03 = spawnstruct();
	var_04 = param_01 * param_02;
	var_05 = vectorcross(param_01,(0,0,1)) * param_02;
	var_03.var_794 = param_00 + var_04 - var_05;
	var_03.var_14C2 = param_00 + var_04 + var_05;
	var_03.var_1DEC = param_00 - var_04 + var_05;
	var_03.var_298F = param_00 - var_04 - var_05;
	return var_03;
}

//Function Number: 9
func_740F(param_00,param_01)
{
	if(param_00.var_116[2] <= param_01[2])
	{
		return bullettracepassed(param_00.var_116 + (0,0,10),(param_00.var_116[0],param_00.var_116[1],param_01[2] + 10),0,param_00) && bullettracepassed(param_01 + (0,0,10),(param_00.var_116[0],param_00.var_116[1],param_01[2] + 10),0,param_00);
	}

	return bullettracepassed(param_01 + (0,0,10),(param_01[0],param_01[1],param_00.var_116[2] + 10),0,param_00) && bullettracepassed(param_00.var_116 + (0,0,10),(param_01[0],param_01[1],param_00.var_116[2] + 10),0,param_00);
}

//Function Number: 10
func_7542(param_00,param_01)
{
	return func_803F(param_00,param_01.var_794,param_01.var_14C2,param_01.var_298F) && func_803F(param_00,param_01.var_14C2,param_01.var_1DEC,param_01.var_794) && func_803F(param_00,param_01.var_1DEC,param_01.var_298F,param_01.var_14C2) && func_803F(param_00,param_01.var_298F,param_01.var_794,param_01.var_1DEC);
}

//Function Number: 11
func_803F(param_00,param_01,param_02,param_03)
{
	var_04 = vectorcross(param_02 - param_01,param_03 - param_01);
	var_05 = vectorcross(param_02 - param_01,param_00 - param_01);
	return vectordot(var_04,var_05) >= 0;
}