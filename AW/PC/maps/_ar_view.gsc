/*******************************************************************
 * Decompiled By: Bog
 * Decompiled File: _ar_view.gsc
 * Game: Call of Duty: Advanced Warfare
 * Platform: PC
 * Function Count: 3
 * Decompile Time: 55 ms
 * Timestamp: 4/22/2024 2:20:02 AM
*******************************************************************/

//Function Number: 1
display_ar_box(param_00,param_01,param_02,param_03,param_04,param_05)
{
	self endon("stop_AR_box");
	var_06 = gettime();
	var_07 = param_03 / 2;
	var_08 = (0,0,param_01);
	var_09 = (0,0,param_01 + param_04);
	var_0A = param_03 - 10 / 2;
	var_0B = (0,0,param_01 + 5);
	var_0C = (0,0,param_01 + 5 + param_04 - 10);
	while(gettime() - var_06 < param_05 * 1000)
	{
		var_0D = param_00.origin;
		var_0E = vectornormalize(var_0D - level.player.origin);
		var_0F = anglestoup(level.player getplayerangles());
		var_10 = vectorcross(var_0E,var_0F);
		var_11 = [];
		var_11[0] = var_0D + var_08 + -1 * var_07 * var_10 + param_02 * var_10;
		var_11[1] = var_0D + var_09 + -1 * var_07 * var_10 + param_02 * var_10;
		var_11[2] = var_0D + var_09 + var_07 * var_10 + param_02 * var_10;
		var_11[3] = var_0D + var_08 + var_07 * var_10 + param_02 * var_10;
		var_12 = [];
		for(var_13 = 0;var_13 < var_11.size;var_13++)
		{
			var_14 = vectornormalize(var_11[var_13 + 1 % var_11.size] - var_11[var_13]);
			var_12[var_12.size] = var_11[var_13];
			var_12[var_12.size] = var_11[var_13] + 20 * var_14;
			var_12[var_12.size] = var_11[var_13 + 1 % var_11.size];
			var_12[var_12.size] = var_11[var_13 + 1 % var_11.size] - 20 * var_14;
		}

		for(var_13 = 0;var_13 < var_12.size;var_13++)
		{
			var_13++;
		}

		var_15 = [];
		var_15[0] = var_0D + var_0B + -1 * var_0A * var_10 + param_02 * var_10;
		var_15[1] = var_0D + var_0C + -1 * var_0A * var_10 + param_02 * var_10;
		var_15[2] = var_0D + var_0C + var_0A * var_10 + param_02 * var_10;
		var_15[3] = var_0D + var_0B + var_0A * var_10 + param_02 * var_10;
		var_16 = [];
		for(var_13 = 0;var_13 < var_15.size;var_13++)
		{
			var_14 = vectornormalize(var_15[var_13 + 1 % var_15.size] - var_15[var_13]);
			var_16[var_16.size] = var_15[var_13];
			var_16[var_16.size] = var_15[var_13] + 20 * var_14;
			var_16[var_16.size] = var_15[var_13 + 1 % var_15.size];
			var_16[var_16.size] = var_15[var_13 + 1 % var_15.size] - 20 * var_14;
		}

		for(var_13 = 0;var_13 < var_16.size;var_13++)
		{
			var_13++;
		}

		wait(0.05);
	}
}

//Function Number: 2
display_ar_line(param_00,param_01,param_02,param_03,param_04,param_05)
{
	self endon("stop_AR_line");
	var_06 = gettime();
	var_07 = param_03 / 2;
	var_08 = (0,0,param_01);
	var_09 = (0,0,param_01 + param_04);
	var_0A = param_03 - 10 / 2;
	var_0B = (0,0,param_01 - 5);
	var_0C = (0,0,param_01 + param_04 - 5);
	while(gettime() - var_06 < param_05 * 1000)
	{
		var_0D = param_00.origin;
		var_0E = vectornormalize(var_0D - level.player.origin);
		var_0F = anglestoup(level.player getplayerangles());
		var_10 = vectorcross(var_0E,var_0F);
		var_11 = [];
		var_11[0] = var_0D + var_08 + -1 * var_07 * var_10 + param_02 * var_10;
		var_11[1] = var_0D + var_09 + var_07 * var_10 + param_02 * var_10;
		for(var_12 = 0;var_12 < var_11.size;var_12++)
		{
		}

		var_13 = [];
		var_13[0] = var_0D + var_0B + -1 * var_0A * var_10 + param_02 * var_10;
		var_13[1] = var_0D + var_0C + var_0A * var_10 + param_02 * var_10;
		for(var_12 = 0;var_12 < var_13.size;var_12++)
		{
		}

		wait(0.05);
	}
}

//Function Number: 3
display_ar_text(param_00,param_01,param_02,param_03,param_04,param_05)
{
	self endon("stop_AR_text");
	var_06 = gettime();
	while(gettime() - var_06 < param_05 * 1000)
	{
		var_07 = param_00.origin;
		var_08 = vectornormalize(var_07 - level.player.origin);
		var_09 = anglestoup(level.player getplayerangles());
		var_0A = vectorcross(var_08,var_09);
		var_0B = var_07 + (0,0,param_01) + param_02 * var_0A;
		wait(0.05);
	}
}