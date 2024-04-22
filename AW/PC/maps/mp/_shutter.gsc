/*******************************************************************
 * Decompiled By: Bog
 * Decompiled File: mp\_shutter.gsc
 * Game: Call of Duty: Advanced Warfare
 * Platform: PC
 * Function Count: 5
 * Decompile Time: 86 ms
 * Timestamp: 4/22/2024 2:16:12 AM
*******************************************************************/

//Function Number: 1
main()
{
	level.inc = 0;
	common_scripts\utility::array_levelthread(getentarray("wire","targetname"),::wirewander);
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
		var_00[var_02].startyaw = var_00[var_02].angles[1];
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
		var_04[var_02].startyaw = var_04[var_02].angles[1];
	}

	var_01 = undefined;
	var_05 = "left";
	for(;;)
	{
		common_scripts\utility::array_levelthread(var_00,::shutterwanderleft,var_05);
		common_scripts\utility::array_levelthread(var_04,::shutterwanderright,var_05);
		level waittill("wind blows",var_05);
	}
}

//Function Number: 2
windcontroller()
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
shutterwanderleft(param_00,param_01)
{
	level.inc++;
	level endon("wind blows");
	var_02 = param_00.startyaw;
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
		if(var_02 < param_00.startyaw || var_02 > param_00.startyaw + 179)
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
shutterwanderright(param_00,param_01)
{
	level.inc++;
	level endon("wind blows");
	var_02 = param_00.startyaw;
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
		if(var_02 < param_00.startyaw || var_02 > param_00.startyaw + 179)
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
wirewander(param_00)
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