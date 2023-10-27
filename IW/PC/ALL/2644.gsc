/*******************************************************************
 * Decompiled By: Bog
 * Decompiled File: 2644.gsc
 * Game: Call of Duty: Infinite Warfare
 * Platform: PC
 * Function Count: 33
 * Decompile Time: 3 ms
 * Timestamp: 10/27/2023 12:23:33 AM
*******************************************************************/

//Function Number: 1
func_95F8()
{
	func_DED6();
}

//Function Number: 2
func_DED6()
{
	if(scripts\cp\_utility::isplayingsolo())
	{
		setomnvar("zm_ui_is_solo",1);
		return;
	}

	setomnvar("zm_ui_is_solo",0);
}

//Function Number: 3
func_DEB4(param_00,param_01)
{
	if(!isdefined(level.var_666B))
	{
		level.var_666B = [];
	}

	var_02 = spawnstruct();
	var_02.var_B0FB = param_01;
	level.var_666B[param_00] = var_02;
}

//Function Number: 4
func_DEB2(param_00,param_01,param_02,param_03,param_04,param_05,param_06,param_07)
{
	var_08 = spawnstruct();
	var_08 = [[ param_01 ]](var_08);
	var_08.var_E231 = param_02;
	var_08.var_E21A = param_03;
	var_08.var_36EF = param_04;
	var_08.var_B0FB = param_05;
	var_08.var_62CF = param_06;
	if(isdefined(param_07))
	{
		var_08.var_D0FA = param_07;
	}

	level.var_6299[param_00] = var_08;
}

//Function Number: 5
func_8B78(param_00)
{
	return func_8BA4(level.var_666B,param_00);
}

//Function Number: 6
func_8BA4(param_00,param_01)
{
	if(func_9CAF())
	{
		return 0;
	}

	if(!isdefined(param_00))
	{
		return 0;
	}

	return isdefined(param_00[param_01]);
}

//Function Number: 7
func_9CAF()
{
	if(isdefined(level.var_9F37))
	{
		return [[ level.var_9F37 ]]();
	}

	return 0;
}

//Function Number: 8
func_96EB()
{
	if(func_9CAF())
	{
		return;
	}

	self.var_6296 = [];
	self.var_62CE = [];
	func_4488(self);
	func_E216(self);
	func_E1E8();
}

//Function Number: 9
func_4488(param_00)
{
	foreach(var_02 in level.var_6299)
	{
		if(isdefined(var_02.var_D0FA))
		{
			[[ var_02.var_D0FA ]](param_00);
		}
	}
}

//Function Number: 10
func_E216(param_00)
{
	foreach(var_02 in level.var_6299)
	{
		if(isdefined(var_02.var_E21A))
		{
			[[ var_02.var_E21A ]](param_00);
		}
	}
}

//Function Number: 11
func_E1E8()
{
	foreach(var_02, var_01 in level.var_666B)
	{
		self.var_62CE[var_02] = 0;
	}
}

//Function Number: 12
func_E1E7()
{
	foreach(var_01 in level.var_6299)
	{
		if(isdefined(var_01.var_E231))
		{
			[[ var_01.var_E231 ]](var_01);
		}
	}

	func_E221();
}

//Function Number: 13
func_E221()
{
	foreach(var_01 in level.players)
	{
		func_E216(var_01);
		func_E215(var_01);
	}
}

//Function Number: 14
func_36FD(param_00)
{
	if(func_9CAF())
	{
		return;
	}

	if(isdefined(level.var_6326))
	{
		[[ level.var_6326 ]](param_00);
	}

	foreach(var_02 in level.players)
	{
		func_3708(var_02);
	}
}

//Function Number: 15
func_3708(param_00)
{
	var_01 = 1;
	var_02 = 0;
	foreach(var_06, var_04 in level.var_666B)
	{
		var_05 = param_00.var_62CE[var_06];
		var_01++;
		var_02 = var_02 + var_05;
	}
}

//Function Number: 16
func_36DD(param_00,param_01)
{
	func_36EC(param_00,param_01);
	func_100D5();
}

//Function Number: 17
func_36EC(param_00,param_01,param_02)
{
	foreach(var_04 in param_00)
	{
		func_36FB(var_04,param_01,param_02);
	}
}

//Function Number: 18
func_36FB(param_00,param_01,param_02)
{
	var_03 = 1;
	var_04 = 0;
	foreach(var_06 in param_01)
	{
		var_07 = level.var_6299[var_06];
		var_08 = [[ var_07.var_36EF ]](param_00,var_07);
		var_08 = var_08 * level.var_4CC6;
		var_08 = int(var_08);
		param_00.var_62CE[var_07.var_62CF] = param_00.var_62CE[var_07.var_62CF] + var_08;
		func_F476(param_00,var_03,var_07.var_B0FB,var_08);
		var_04 = var_04 + var_08;
		var_03++;
	}

	if(isdefined(level.var_2C84))
	{
		var_0A = [[ level.var_2C84 ]](param_00,var_04);
		var_04 = var_04 + var_0A.var_3C;
		func_F476(param_00,var_03,var_0A.var_12B27,var_0A.var_3C);
		var_03++;
	}

	param_00 scripts\cp\_persistence::func_666A("score",var_04,param_02);
	func_F476(param_00,var_03,6,var_04);
	var_03++;
	if(isdefined(level.var_D6F9))
	{
		[[ level.var_D6F9 ]](param_00,var_04,var_03);
	}
}

//Function Number: 19
func_E759(param_00,param_01)
{
	var_02 = param_00 / param_01;
	var_02 = ceil(var_02);
	return int(var_02 * param_01);
}

//Function Number: 20
func_12E13(param_00,param_01,param_02)
{
	foreach(var_04 in level.players)
	{
		var_04 func_12E04(param_00,param_01,param_02);
	}
}

//Function Number: 21
func_12E04(param_00,param_01,param_02)
{
	if(!func_8B74(param_00))
	{
		return;
	}

	if(!isplayer(self))
	{
		return;
	}

	self.var_6296 = func_12DB7(self.var_6296,param_01,param_02);
}

//Function Number: 22
func_12DB7(param_00,param_01,param_02)
{
	if(!isdefined(param_02))
	{
		param_02 = 1;
	}

	param_00[param_01] = param_00[param_01] + param_02;
	return param_00;
}

//Function Number: 23
func_7CE5(param_00,param_01)
{
	return param_00.var_115B3[param_01];
}

//Function Number: 24
func_8B74(param_00)
{
	return func_8BA4(level.var_6299,param_00);
}

//Function Number: 25
func_7B8F(param_00,param_01)
{
	return param_00.var_6296[param_01];
}

//Function Number: 26
func_370A(param_00,param_01,param_02)
{
	var_03 = clamp(param_01 - param_00,0,param_01);
	return int(var_03 / param_01 * param_02);
}

//Function Number: 27
func_12E38(param_00,param_01,param_02)
{
	if(!func_8B74(param_00))
	{
		return;
	}

	if(!isdefined(param_02))
	{
		param_02 = 1;
	}

	level.var_6299[param_00].var_115B3[param_01] = level.var_6299[param_00].var_115B3[param_01] + param_02;
}

//Function Number: 28
func_2B56(param_00)
{
	return param_00;
}

//Function Number: 29
func_7CE6()
{
	return scripts\common\utility::func_116D7(isdefined(level.var_115B9),level.var_115B9,"team");
}

//Function Number: 30
func_E215(param_00)
{
	var_01 = 8;
	for(var_02 = 1;var_02 <= var_01;var_02++)
	{
		var_03 = "ui_alien_encounter_title_row_" + var_02;
		var_04 = "ui_alien_encounter_score_row_" + var_02;
		param_00 setclientomnvar(var_03,0);
		param_00 setclientomnvar(var_04,0);
	}
}

//Function Number: 31
func_F477(param_00,param_01,param_02,param_03)
{
	var_04 = "zm_ui_eog_title_row_" + param_01;
	var_05 = "zm_ui_eog_title_row_" + param_01;
	param_00 setclientomnvar(var_04,param_02);
	param_00 setclientomnvar(var_05,param_03);
}

//Function Number: 32
func_100D5()
{
	level endon("game_ended ");
	setomnvar("zm_ui_show_encounter_score",1);
	wait(1);
	setomnvar("zm_ui_show_encounter_score",0);
}

//Function Number: 33
func_F476(param_00,param_01,param_02,param_03)
{
	var_04 = "ui_alien_encounter_title_row_" + param_01;
	var_05 = "ui_alien_encounter_score_row_" + param_01;
}