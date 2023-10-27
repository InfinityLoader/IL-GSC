/*******************************************************************
 * Decompiled By: Bog
 * Decompiled File: scripts\mp\_shutter.gsc
 * Game: Call of Duty: Infinite Warfare
 * Platform: PC
 * Function Count: 5
 * Decompile Time: 218 ms
 * Timestamp: 10/27/2023 12:21:31 AM
*******************************************************************/

//Function Number: 1
main()
{
	level.var_93BC = 0;
	scripts\common\utility::func_22A1(getentarray("wire","targetname"),::func_13D8E);
	var_00 = getentarray("shutter_left","targetname");
	var_01 = getentarray("shutter_right_open","targetname");
	for(var_02 = 0;var_02 < var_01.size;var_02++)
	{
		var_00[var_00.size] = var_01[var_02];
	}

	var_01 = getentarray("shutter_left_closed","targetname");
	for(var_02 = 0;var_02 < var_01.size;var_02++)
	{
		var_00[var_00.size] = var_01[var_02];
	}

	for(var_02 = 0;var_02 < var_00.size;var_02++)
	{
		var_03 = var_00[var_02];
		var_03 rotateto((var_03.angles[0],var_03.angles[1] + 180,var_03.angles[2]),0.1);
	}

	wait(0.2);
	for(var_02 = 0;var_02 < var_00.size;var_02++)
	{
		var_00[var_02].var_10E0E = var_00[var_02].angles[1];
	}

	var_04 = getentarray("shutter_right","targetname");
	var_01 = getentarray("shutter_left_open","targetname");
	for(var_02 = 0;var_02 < var_01.size;var_02++)
	{
		var_04[var_04.size] = var_01[var_02];
	}

	var_01 = getentarray("shutter_right_closed","targetname");
	for(var_02 = 0;var_02 < var_01.size;var_02++)
	{
		var_04[var_04.size] = var_01[var_02];
	}

	for(var_02 = 0;var_02 < var_04.size;var_02++)
	{
		var_04[var_02].var_10E0E = var_04[var_02].angles[1];
	}

	var_01 = undefined;
	var_05 = "left";
	for(;;)
	{
		scripts\common\utility::func_22A1(var_00,::func_101A1,var_05);
		scripts\common\utility::func_22A1(var_04,::func_101A2,var_05);
		level waittill("wind blows",var_05);
	}
}

//Function Number: 2
func_13D32()
{
	for(;;)
	{
		var_00 = "left";
		if(randomint(100) > 50)
		{
			var_00 = "right";
		}

		level notify("wind blows",var_00);
		wait(2 + randomfloat(10));
	}
}

//Function Number: 3
func_101A1(param_00,param_01)
{
	level.var_93BC++;
	level endon("wind blows");
	var_02 = param_00.var_10E0E;
	if(param_01 == "left")
	{
		var_02 = var_02 + 179.9;
	}

	var_03 = 0.2;
	param_00 rotateto((param_00.angles[0],var_02,param_00.angles[2]),var_03);
	wait(var_03 + 0.1);
	for(;;)
	{
		var_04 = randomint(80);
		if(randomint(100) > 50)
		{
			var_04 = var_04 * -1;
		}

		var_02 = param_00.angles[1] + var_04;
		var_05 = param_00.angles[1] + var_04 * -1;
		if(var_02 < param_00.var_10E0E || var_02 > param_00.var_10E0E + 179)
		{
			var_02 = var_05;
		}

		var_06 = abs(param_00.angles[1] - var_02);
		var_03 = var_06 * 0.02 + randomfloat(2);
		if(var_03 < 0.3)
		{
			var_03 = 0.3;
		}

		param_00 rotateto((param_00.angles[0],var_02,param_00.angles[2]),var_03,var_03 * 0.5,var_03 * 0.5);
		wait(var_03);
	}
}

//Function Number: 4
func_101A2(param_00,param_01)
{
	level.var_93BC++;
	level endon("wind blows");
	var_02 = param_00.var_10E0E;
	if(param_01 == "left")
	{
		var_02 = var_02 + 179.9;
	}

	var_03 = 0.2;
	param_00 rotateto((param_00.angles[0],var_02,param_00.angles[2]),var_03);
	wait(var_03 + 0.1);
	for(;;)
	{
		var_04 = randomint(80);
		if(randomint(100) > 50)
		{
			var_04 = var_04 * -1;
		}

		var_02 = param_00.angles[1] + var_04;
		var_05 = param_00.angles[1] + var_04 * -1;
		if(var_02 < param_00.var_10E0E || var_02 > param_00.var_10E0E + 179)
		{
			var_02 = var_05;
		}

		var_06 = abs(param_00.angles[1] - var_02);
		var_03 = var_06 * 0.02 + randomfloat(2);
		if(var_03 < 0.3)
		{
			var_03 = 0.3;
		}

		param_00 rotateto((param_00.angles[0],var_02,param_00.angles[2]),var_03,var_03 * 0.5,var_03 * 0.5);
		wait(var_03);
	}
}

//Function Number: 5
func_13D8E(param_00)
{
	var_01 = getentarray(param_00.target,"targetname");
	var_02 = var_01[0].origin;
	var_03 = var_01[1].origin;
	var_04 = vectortoangles(var_02 - var_03);
	var_05 = spawn("script_model",(0,0,0));
	var_05.origin = var_02 * 0.5 + var_03 * 0.5;
	var_05.angles = var_04;
	param_00 linkto(var_05);
	var_06 = 2;
	var_07 = 0.9;
	var_08 = 4 + randomfloat(2);
	var_05 rotateroll(var_08 * 0.5,0.2);
	wait(0.2);
	for(;;)
	{
		var_09 = var_06 + randomfloat(var_07) - var_07 * 0.5;
		var_05 rotateroll(var_08,var_09,var_09 * 0.5,var_09 * 0.5);
		wait(var_09);
		var_05 rotateroll(var_08 * -1,var_09,var_09 * 0.5,var_09 * 0.5);
		wait(var_09);
	}
}