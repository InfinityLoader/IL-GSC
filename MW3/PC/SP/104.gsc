/*******************************************************************
 * Decompiled By: Bog
 * Decompiled File: 104.gsc
 * Game: Call of Duty: Modern Warfare 3
 * Platform: PC
 * Function Count: 13
 * Decompile Time: 1 ms
 * Timestamp: 10/27/2023 2:19:39 AM
*******************************************************************/

//Function Number: 1
func_1477()
{
	level._audio.var_1478 = spawnstruct();
	level._audio.var_1478.music = spawnstruct();
	level._audio.var_1478.music.var_147A = func_148A();
	level._audio.var_1478.music.var_147B = func_148A();
	level._audio.var_1478.var_147C = spawnstruct();
	level._audio.var_1478.var_147C.var_147A = func_148A();
	level._audio.var_1478.var_147C.var_147B = func_148A();
}

//Function Number: 2
func_147D(param_00,param_01,param_02,param_03,param_04)
{
	var_05 = 1;
	if(isdefined(param_01))
	{
		var_05 = max(param_01,0);
	}

	var_06 = 1;
	if(isdefined(param_04))
	{
		var_06 = max(param_04,0);
	}

	func_1489(level._audio.var_1478.var_147C.var_147B,level._audio.var_1478.var_147C.var_147A.name,level._audio.var_1478.var_147C.var_147A.vol,level._audio.var_1478.var_147C.var_147A.fade);
	func_1489(level._audio.var_1478.var_147C.var_147A,param_00,var_06,var_05);
	ambientplay(param_00,var_05,var_06);
}

//Function Number: 3
func_1480(param_00,param_01,param_02,param_03,param_04)
{
	var_05 = 1;
	if(isdefined(param_01))
	{
		var_05 = max(param_01,0);
	}

	var_06 = 1;
	if(isdefined(param_02))
	{
		var_06 = param_02;
	}

	var_07 = 1;
	if(isdefined(param_03))
	{
		var_07 = max(param_03,0);
	}

	func_1489(level._audio.var_1478.music.var_147B,level._audio.var_1478.music.var_147A.name,level._audio.var_1478.music.var_147A.vol,level._audio.var_1478.music.var_147A.fade);
	func_1489(level._audio.var_1478.music.var_147A,param_00,var_07,var_05);
	if(isdefined(param_04))
	{
		musicstop(var_06,param_04);
		musicplay(param_00,var_05,var_07,0);
		return;
	}

	musicplay(param_00,var_05,var_07);
}

//Function Number: 4
func_1481(param_00,param_01)
{
	if(param_00 != "none")
	{
		var_02 = 1;
		if(isdefined(param_01))
		{
			var_02 = max(param_01,0);
		}

		if(level._audio.var_1478.var_147C.var_147A.name == param_00)
		{
			level._audio.var_1478.var_147C.var_147A = level._audio.var_1478.var_147C.var_147B;
			func_148B(level._audio.var_1478.var_147C.var_147B);
		}
		else if(level._audio.var_1478.var_147C.var_147B.name == param_00)
		{
			func_148B(level._audio.var_1478.var_147C.var_147B);
		}

		ambientstop(var_02,param_00);
	}
}

//Function Number: 5
func_1482(param_00,param_01)
{
	var_02 = 1;
	if(isdefined(param_01))
	{
		var_02 = max(param_01,0);
	}

	if(level._audio.var_1478.music.var_147A.name == param_00)
	{
		level._audio.var_1478.music.var_147A = level._audio.var_1478.music.var_147B;
		func_148B(level._audio.var_1478.music.var_147B);
	}
	else if(level._audio.var_1478.var_147C.var_147B.name == param_00)
	{
		func_148B(level._audio.var_1478.music.var_147B);
	}

	musicstop(var_02,param_00);
}

//Function Number: 6
func_1483(param_00)
{
	var_01 = 1;
	if(isdefined(param_00))
	{
		var_01 = param_00;
	}

	ambientstop(var_01);
}

//Function Number: 7
func_1484(param_00)
{
	var_01 = 1;
	if(isdefined(param_00))
	{
		var_01 = param_00;
	}

	func_148B(level._audio.var_1478.music.var_147A);
	func_148B(level._audio.var_1478.music.var_147B);
	musicstop(var_01);
}

//Function Number: 8
func_1485(param_00)
{
	var_01 = 0.009;
	if(param_00.size == 1)
	{
		func_1489(level._audio.var_1478.var_147C.var_147A,param_00[0].alias,param_00[0].vol,param_00[0].fade);
	}
	else if(param_00.size == 2)
	{
		func_1489(level._audio.var_1478.var_147C.var_147B,param_00[0].alias,param_00[0].vol,param_00[0].fade);
		func_1489(level._audio.var_1478.var_147C.var_147A,param_00[1].alias,param_00[1].vol,param_00[1].fade);
	}

	for(var_06 = 0;var_06 < param_00.size;var_06++)
	{
		var_07 = param_00[var_06].alias;
		var_08 = max(param_00[var_06].vol,0);
		var_09 = clamp(param_00[var_06].fade,0,1);
		if(var_07 != "none")
		{
			if(var_08 < var_01)
			{
				ambientstop(var_09,var_07);
				continue;
			}

			ambientplay(var_07,var_09,var_08,0);
		}
	}
}

//Function Number: 9
func_1487()
{
	return level._audio.var_1478.var_147C.var_147A.name;
}

//Function Number: 10
func_1488()
{
	return level._audio.var_1478.music.var_147A.name;
}

//Function Number: 11
func_1489(param_00,param_01,param_02,param_03)
{
	param_00.name = param_01;
	param_00.vol = param_02;
	param_00.fade = param_03;
}

//Function Number: 12
func_148A()
{
	var_00 = spawnstruct();
	var_00.name = "";
	var_00.vol = 0;
	var_00.fade = 0;
	return var_00;
}

//Function Number: 13
func_148B(param_00)
{
	param_00.name = "";
	param_00.vol = 0;
	param_00.fade = 0;
}