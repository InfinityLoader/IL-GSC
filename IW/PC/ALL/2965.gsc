/*******************************************************************
 * Decompiled By: Bog
 * Decompiled File: 2965.gsc
 * Game: Call of Duty: Infinite Warfare
 * Platform: PC
 * Function Count: 43
 * Decompile Time: 7 ms
 * Timestamp: 10/27/2023 12:25:53 AM
*******************************************************************/

//Function Number: 1
func_31B3(param_00,param_01,param_02,param_03,param_04,param_05)
{
	if(!isdefined(param_04))
	{
		param_04 = 0;
	}

	if(!isdefined(param_00))
	{
		param_00 = (0,0,0);
	}

	var_06 = spawnstruct();
	var_06.var_C364 = param_00;
	var_06.var_DCCA = param_01;
	var_06.var_B48B = param_02;
	var_06.var_B758 = param_03;
	var_06.var_2B19 = param_04;
	var_06.var_50AE = param_05;
	level.var_131A0.var_116CE.var_4E1C[level.var_13570] = var_06;
}

//Function Number: 2
func_31B8(param_00,param_01,param_02,param_03,param_04,param_05)
{
	if(!isdefined(level.var_131A0.var_116CE.var_E7BA))
	{
		level.var_131A0.var_116CE.var_E7BA = [];
	}

	var_06 = func_31B2(param_01,param_02,param_03,param_04,param_05);
	precacherumble(param_00);
	var_06.var_E7BA = param_00;
	level.var_131A0.var_116CE.var_E7BA[level.var_13570] = var_06;
}

//Function Number: 3
func_3187(param_00,param_01,param_02)
{
	var_03 = level.var_13570;
	if(!isdefined(level.var_131A0.var_116CE.var_4E02))
	{
		level.var_131A0.var_116CE.var_4E02 = [];
	}

	level.var_131A0.var_116CE.var_4E02[var_03] = func_31B2(param_00,param_01,param_02);
}

//Function Number: 4
func_31B2(param_00,param_01,param_02,param_03,param_04)
{
	var_05 = spawnstruct();
	var_05.var_EB9C = param_00;
	var_05.var_5F36 = param_01;
	var_05.var_257 = param_02;
	if(isdefined(param_03))
	{
		var_05.var_28AE = param_03;
	}

	if(isdefined(param_04))
	{
		var_05.var_DCA5 = param_04;
	}

	return var_05;
}

//Function Number: 5
func_3197(param_00,param_01,param_02,param_03,param_04,param_05,param_06,param_07,param_08,param_09,param_0A,param_0B)
{
	if(!isdefined(param_05))
	{
		param_05 = 0;
	}

	if(!isdefined(param_03))
	{
		param_03 = 0;
	}

	if(!isdefined(param_04))
	{
		param_04 = 1;
	}

	var_0C = spawnstruct();
	var_0C.var_5FDF = loadfx(param_00);
	var_0C.var_2DD = param_01;
	var_0C.var_10453 = param_02;
	var_0C.var_312E = param_05;
	var_0C.var_50AE = param_04;
	var_0C.var_136A1 = param_06;
	var_0C.var_10E6A = param_07;
	var_0C.var_C174 = param_08;
	var_0C.var_2A4E = param_03;
	var_0C.var_F1EA = param_09;
	var_0C.var_DFEC = param_0A;
	var_0C.var_24DF = param_0B;
	return var_0C;
}

//Function Number: 6
func_3184(param_00,param_01,param_02,param_03,param_04,param_05,param_06,param_07,param_08,param_09,param_0A,param_0B)
{
	var_0C = level.var_13570;
	if(!isdefined(level.var_131A0.var_116CE.var_131BC[var_0C]))
	{
		level.var_131A0.var_116CE.var_131BC[var_0C] = [];
	}

	level.var_131A0.var_116CE.var_131BC[var_0C][level.var_131A0.var_116CE.var_131BC[var_0C].size] = func_3197(param_00,param_01,param_02,param_03,param_04,param_05,param_06,param_07,param_08,param_09,param_0A,param_0B);
}

//Function Number: 7
func_3183(param_00)
{
	var_01 = level.var_13570;
	if(!isdefined(level.var_131A0.var_116CE.var_4DF9[var_01]))
	{
		level.var_131A0.var_116CE.var_4DF9[var_01] = [];
	}

	level.var_131A0.var_116CE.var_4DF9[var_01] = param_00;
}

//Function Number: 8
func_31B7(param_00,param_01,param_02,param_03,param_04,param_05,param_06,param_07,param_08,param_09,param_0A)
{
	var_0B = level.var_13570;
	level.var_13570 = "rocket_death" + var_0B;
	func_3184(param_00,param_01,param_02,param_03,param_04,param_05,param_06,param_07,param_08,param_09,param_0A);
	level.var_13570 = var_0B;
}

//Function Number: 9
func_31A2(param_00)
{
	var_01 = level.var_13570;
	level.var_131A0.var_116CE.var_A7C5[var_01] = [[ param_00 ]]();
}

//Function Number: 10
func_31C8(param_00,param_01,param_02,param_03,param_04,param_05,param_06,param_07,param_08,param_09)
{
	if(!isdefined(level.var_131A0.var_116CE.var_B6BD))
	{
		level.var_131A0.var_116CE.var_B6BD = [];
	}

	var_0A = level.var_13570;
	if(!isdefined(level.var_131A0.var_116CE.var_B6BD[var_0A]))
	{
		level.var_131A0.var_116CE.var_B6BD[var_0A] = [];
	}

	precachemodel(param_02);
	precacheturret(param_00);
	var_0B = spawnstruct();
	var_0B.var_94B8 = param_00;
	var_0B.var_2DD = param_01;
	var_0B.model = param_02;
	var_0B.var_1D2 = param_03;
	var_0B.var_5041 = param_04;
	var_0B.var_51AD = param_05;
	var_0B.var_5035 = param_06;
	var_0B.var_5036 = param_07;
	if(isdefined(param_08))
	{
		var_0B.var_C367 = param_08;
	}

	if(isdefined(param_09))
	{
		var_0B.var_DE46 = param_09;
	}

	level.var_131A0.var_116CE.var_B6BD[var_0A][level.var_131A0.var_116CE.var_B6BD[var_0A].size] = var_0B;
}

//Function Number: 11
func_31A4(param_00,param_01,param_02,param_03,param_04,param_05)
{
	if(!isdefined(level.var_131A0.var_116CE.var_13208))
	{
		level.var_131A0.var_116CE.var_13208 = [];
	}

	if(!isdefined(level.var_131A0.var_116CE.var_1320A))
	{
		level.var_131A0.var_116CE.var_1320A = [];
	}

	if(isdefined(level.var_131A0.var_116CE.var_1320A[param_04]) && !level.var_13574)
	{
		return;
	}

	var_06 = spawnstruct();
	var_06.name = param_01;
	var_06.var_2DD = param_02;
	var_06.var_50AE = param_05;
	var_06.var_5FDF = loadfx(param_03);
	level.var_131A0.var_116CE.var_13208[param_00][param_01] = var_06;
	lib_0B97::func_8695(param_00,param_01,"all");
	if(isdefined(param_04))
	{
		lib_0B97::func_8695(param_00,param_01,param_04);
	}
}

//Function Number: 12
func_319B(param_00,param_01)
{
	if(!isdefined(level.var_131A0.var_116CE.var_8E9D))
	{
		level.var_131A0.var_116CE.var_8E9D = [];
	}

	level.var_131A0.var_116CE.var_8E9D[param_00] = param_01;
}

//Function Number: 13
func_3186(param_00,param_01,param_02,param_03)
{
	if(param_00 != level.var_13571)
	{
		return;
	}

	if(!isdefined(param_01))
	{
		param_01 = param_00;
	}

	precachemodel(param_00);
	precachemodel(param_01);
	if(!isdefined(param_02))
	{
		param_02 = 0;
	}

	if(!isdefined(param_03))
	{
		level.var_131A0.var_116CE.var_4E4E[param_00] = param_01;
		level.var_131A0.var_131C3[param_00] = param_02;
		return;
	}

	level.var_131A0.var_116CE.var_4E4E[param_03] = param_01;
	level.var_131A0.var_131C3[param_03] = param_02;
}

//Function Number: 14
func_319D(param_00)
{
	if(!isdefined(level.var_131A0.var_116CE.var_92D0))
	{
		level.var_131A0.var_116CE.var_92D0 = [];
	}

	if(!isdefined(level.var_131A0.var_116CE.var_92D0[level.var_13571]))
	{
		level.var_131A0.var_116CE.var_92D0[level.var_13571] = [];
	}

	level.var_131A0.var_116CE.var_92D0[level.var_13571][level.var_131A0.var_116CE.var_92D0[level.var_13571].size] = param_00;
}

//Function Number: 15
func_318B(param_00,param_01,param_02,param_03)
{
	if(!isdefined(param_02))
	{
		param_02 = 10;
	}

	level.var_131A0.var_116CE.var_5BC3[level.var_13571] = param_00;
	if(isdefined(param_01))
	{
		level.var_131A0.var_116CE.var_5BC6[level.var_13571] = param_01;
	}

	level.var_131A0.var_116CE.var_5BC5[level.var_13571] = param_02;
	if(isdefined(param_03))
	{
		level.var_131A0.var_116CE.var_5BC4[level.var_13571] = param_03;
	}
}

//Function Number: 16
func_31C5(param_00,param_01,param_02,param_03)
{
	scripts\sp\_utility::func_965C();
	scripts\sp\_vehicle_code::func_F9C7();
	if(isdefined(param_02))
	{
		param_00 = param_02;
	}

	precachevehicle(param_00);
	level.var_131A0.var_116CE.team[param_03] = "axis";
	level.var_131A0.var_116CE.var_AC4A[param_03] = 999;
	level.var_131A0.var_116CE.var_8B8F[param_01] = 0;
	level.var_131A0.var_116CE.var_B243[param_01] = [];
	level.var_13571 = param_01;
	level.var_13575 = param_00;
	level.var_13570 = param_03;
}

//Function Number: 17
func_3194(param_00)
{
	level.var_131A0.var_116CE.var_693A[level.var_13571] = loadfx(param_00);
}

//Function Number: 18
func_31C6(param_00,param_01,param_02,param_03)
{
	if(isdefined(param_00))
	{
		func_F5FB(param_00,param_01,param_02);
		if(isdefined(param_03) && param_03)
		{
			func_F5FB(param_00,param_01,param_02,"_bank");
			func_F5FB(param_00,param_01,param_02,"_bank_lg");
			return;
		}

		return;
	}

	param_00 = level.var_13570;
	lib_0B8F::main(param_00);
}

//Function Number: 19
func_3176(param_00,param_01)
{
	var_02 = func_7CC6();
	foreach(var_04 in var_02)
	{
		func_F5FB(param_00,var_04);
	}
}

//Function Number: 20
func_F5FB(param_00,param_01,param_02,param_03)
{
	if(!isdefined(level.var_131A0.var_116CE.var_112D9))
	{
		level.var_131A0.var_116CE.var_112D9 = [];
	}

	if(isdefined(param_03))
	{
		param_01 = param_01 + param_03;
		param_02 = param_02 + param_03;
	}

	if(isdefined(param_02))
	{
		level.var_131A0.var_116CE.var_112D9[param_00][param_01] = loadfx(param_02);
		return;
	}

	if(isdefined(level.var_131A0.var_116CE.var_112D9[param_00]) && isdefined(level.var_131A0.var_116CE.var_112D9[param_00][param_01]))
	{
		level.var_131A0.var_116CE.var_112D9[param_00][param_01] = undefined;
	}
}

//Function Number: 21
func_7CC6()
{
	return ["brick","bark","carpet","cloth","concrete","dirt","flesh","foliage","glass","grass","gravel","ice","metal","mud","paper","plaster","rock","sand","snow","water","wood","asphalt","ceramic","plastic","rubber","cushion","fruit","paintedmetal","riotshield","slush","default"];
}

//Function Number: 22
func_31C4(param_00)
{
	level.var_131A0.var_116CE.team[level.var_13570] = param_00;
}

//Function Number: 23
func_31A9(param_00,param_01,param_02,param_03)
{
	level.var_131A0.var_116CE.var_8B8F[level.var_13571] = 1;
	if(isdefined(param_00))
	{
		level.var_131A0.var_116CE.var_B243[level.var_13571][param_00] = 1;
	}

	if(isdefined(param_01))
	{
		level.var_131A0.var_116CE.var_B243[level.var_13571][param_01] = 1;
	}

	if(isdefined(param_02))
	{
		level.var_131A0.var_116CE.var_B243[level.var_13571][param_02] = 1;
	}

	if(isdefined(param_03))
	{
		level.var_131A0.var_116CE.var_B243[level.var_13571][param_03] = 1;
	}
}

//Function Number: 24
func_317A(param_00)
{
	level.var_131A0.var_116CE.var_323D[level.var_13570] = param_00;
}

//Function Number: 25
func_3198(param_00)
{
	level.var_131A0.var_116CE.var_85A0[level.var_13570] = param_00;
}

//Function Number: 26
func_3175(param_00,param_01)
{
	var_02 = level.var_13570;
	level.var_131A0.var_116CE.var_1A03[var_02] = [[ param_00 ]]();
	if(isdefined(param_01))
	{
		level.var_131A0.var_116CE.var_1A03[var_02] = [[ param_01 ]](level.var_131A0.var_116CE.var_1A03[var_02]);
	}
}

//Function Number: 27
func_3196(param_00)
{
	level.var_131A0.var_116CE.var_7448[level.var_13570] = param_00;
}

//Function Number: 28
func_3178(param_00)
{
	level.var_131A0.var_116CE.var_247D[level.var_13570] = [[ param_00 ]]();
}

//Function Number: 29
func_31CC(param_00)
{
	level.var_131A0.var_116CE.var_12BCF[level.var_13570] = [[ param_00 ]]();
}

//Function Number: 30
func_31A3(param_00,param_01,param_02)
{
	var_03 = level.var_13570;
	level.var_131A0.var_116CE.var_AC4A[var_03] = param_00;
	level.var_131A0.var_116CE.var_AC4D[var_03] = param_01;
	level.var_131A0.var_116CE.var_AC4C[var_03] = param_02;
}

//Function Number: 31
func_3188(param_00)
{
	level.var_131A0.var_116CE.var_4F6B[level.var_13571] = loadfx(param_00);
}

//Function Number: 32
func_3189(param_00,param_01)
{
}

//Function Number: 33
func_31A6(param_00)
{
	level.var_13261[level.var_13575][level.var_13570] = param_00;
}

//Function Number: 34
func_31AC(param_00)
{
	level.var_131A0.var_116CE.var_1325B[level.var_13570] = param_00;
}

//Function Number: 35
func_3177(param_00,param_01)
{
	level.var_131A0.var_116CE.var_2427[level.var_13570]["atmo"] = param_00;
	level.var_131A0.var_116CE.var_2427[level.var_13570]["space"] = param_01;
}

//Function Number: 36
func_3174(param_00)
{
	level.var_131A0.var_116CE.var_155C[level.var_13570] = param_00;
}

//Function Number: 37
func_31BF(param_00)
{
	level.var_131A0.var_116CE.var_F216[level.var_13570] = param_00;
}

//Function Number: 38
func_31B0(param_00,param_01)
{
	var_02 = spawnstruct();
	var_02.var_D375 = param_00;
	var_02.var_13DCB = param_01;
	precachemodel(param_00);
	level.var_131A0.var_116CE.var_13265[level.var_13570] = var_02;
}

//Function Number: 39
func_3181(param_00,param_01,param_02,param_03,param_04,param_05)
{
	if(!isdefined(level.var_131A0.var_116CE.var_4DFC))
	{
		level.var_131A0.var_116CE.var_4DFC = [];
	}

	var_06 = spawnstruct();
	var_06.var_50AE = param_00;
	var_06.var_5F36 = param_01;
	var_06.height = param_02;
	var_06.var_257 = param_03;
	var_06.var_115A4 = param_04;
	var_06.var_115A5 = param_05;
	level.var_131A0.var_116CE.var_4DFC[level.var_13570] = var_06;
}

//Function Number: 40
func_31A0(param_00)
{
	if(!isdefined(level.var_131A0.var_116CE.var_8DB1))
	{
		level.var_131A0.var_116CE.var_8DB1 = [];
	}

	if(!isdefined(param_00))
	{
		param_00 = level.var_13575;
	}

	level.var_131A0.var_116CE.var_8DB1[param_00] = 1;
}

//Function Number: 41
func_319F(param_00)
{
	if(!isdefined(level.var_131A0.var_116CE.var_1AE5))
	{
		level.var_131A0.var_116CE.var_1AE5 = [];
	}

	if(!isdefined(param_00))
	{
		param_00 = level.var_13575;
	}

	level.var_131A0.var_116CE.var_1AE5[param_00] = 1;
}

//Function Number: 42
func_31C2(param_00)
{
	if(!isdefined(level.var_131A0.var_116CE.var_1020A))
	{
		level.var_131A0.var_116CE.var_1020A = [];
	}

	if(!isdefined(param_00))
	{
		param_00 = level.var_13575;
	}

	level.var_131A0.var_116CE.var_1020A[param_00] = 1;
}

//Function Number: 43
func_31B6(param_00)
{
	if(!isdefined(level.var_131A0.var_116CE.var_E4F9))
	{
		level.var_131A0.var_116CE.var_E4F9 = [];
	}

	level.var_131A0.var_116CE.var_E4F9[level.var_13570] = param_00;
}