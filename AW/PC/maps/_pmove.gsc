/*******************************************************************
 * Decompiled By: Bog
 * Decompiled File: _pmove.gsc
 * Game: Call of Duty: Advanced Warfare
 * Platform: PC
 * Function Count: 6
 * Decompile Time: 107 ms
 * Timestamp: 4/22/2024 2:22:25 AM
*******************************************************************/

//Function Number: 1
pm_projectvelocity(param_00,param_01)
{
	var_02 = lengthsquared((param_00[0],param_00[1],0));
	if(abs(param_01[2]) < 0.001 || var_02 <= 0.0001)
	{
	}
	else
	{
		var_03 = -1 * param_00[0] * param_01[0] + param_00[1] * param_01[1] / param_01[2];
		var_04 = (param_00[0],param_00[1],var_03);
		var_05 = var_02 + param_00[2] * param_00[2];
		var_06 = var_02 + var_03 * var_03;
		var_07 = sqrt(var_05 / var_06);
		if(var_07 < 1 || var_03 < 0 || param_00[2] > 0)
		{
			param_00 = var_07 * param_00;
		}
	}

	return param_00;
}

//Function Number: 2
pm_clipvelocity(param_00,param_01)
{
	var_02 = vectordot(param_00,param_01);
	var_02 = var_02 - 0.001 * abs(var_02);
	param_00 = param_00 - var_02 * param_01;
	return param_00;
}

//Function Number: 3
pm_permuterestrictiveclipplanes(param_00,param_01,param_02)
{
	var_03 = [];
	for(var_04 = 0;var_04 < param_01.size;var_04++)
	{
		var_03[var_04] = vectordot(param_00,param_01[var_04]);
		for(var_05 = var_04;var_05 > 0;var_05--)
		{
			if(var_03[param_02[var_05 - 1]] < var_03[var_04])
			{
				break;
			}

			param_02[var_05] = param_02[var_05 - 1];
		}

		param_02[var_05] = var_04;
	}

	var_06["parallel"] = var_03[param_02[0]];
	var_06["permutation"] = param_02;
	return var_06;
}

//Function Number: 4
pm_slidemove(param_00,param_01,param_02)
{
	var_03 = 4;
	var_04 = param_00.vel;
	var_05 = param_00.vel;
	var_06 = 0.05;
	var_07[0] = param_01;
	var_07[1] = vectornormalize(param_00.vel);
	var_08 = [];
	for(var_09 = 0;var_09 < var_03;var_09++)
	{
		var_0A = param_00.origin + var_06 * param_00.vel;
		var_0B = playerphysicstraceinfo(param_00.origin,var_0A,self);
		var_0C = var_0B["position"];
		if(var_0B["fraction"] < 1)
		{
			param_01 = var_0B["normal"];
		}
		else
		{
			param_01 = (0,0,0);
		}

		var_0D = var_0B["fraction"];
		if(var_0D > 0)
		{
			param_00.origin = var_0C;
		}

		var_06 = var_06 - var_06 * var_0D;
		if(var_07.size >= 8)
		{
			param_00.vel = (0,0,0);
			return 1;
		}

		for(var_0E = 0;var_0E < var_07.size;var_0E++)
		{
			if(vectordot(param_01,var_07[var_0E]) > 0.999)
			{
				param_00.vel = pm_clipvelocity(param_00.vel,param_01);
				param_00.vel = param_00.vel + param_01;
				break;
			}
		}

		if(var_0E < var_07.size)
		{
			continue;
		}

		var_07[var_07.size] = param_01;
		var_0F = pm_permuterestrictiveclipplanes(param_00.vel,var_07,var_08);
		var_10 = var_0F["parallel"];
		var_08 = var_0F["permutation"];
		if(var_10 >= 0.1)
		{
			continue;
		}

		var_11 = pm_clipvelocity(param_00.vel,var_07[var_08[0]]);
		var_12 = pm_clipvelocity(var_05,var_07[var_08[0]]);
		for(var_13 = 1;var_13 < var_07.size;var_13++)
		{
			if(vectordot(var_11,var_07[var_08[var_13]]) >= 0.1)
			{
				continue;
			}

			var_11 = pm_clipvelocity(var_11,var_07[var_08[var_13]]);
			var_12 = pm_clipvelocity(var_12,var_07[var_08[var_13]]);
			if(vectordot(var_11,var_07[var_08[0]]) >= 0)
			{
				continue;
			}

			var_14 = vectorcross(var_07[var_08[0]],var_07[var_08[var_13]]);
			var_14 = vectornormalize(var_14);
			var_15 = vectordot(var_14,param_00.vel);
			var_11 = var_15 * var_14;
			var_15 = vectordot(var_14,var_05);
			var_05 = var_15 * var_14;
			for(var_16 = 1;var_16 < var_07.size;var_16++)
			{
				if(var_16 == var_13)
				{
					continue;
				}

				if(vectordot(var_11,var_07[var_08[var_16]]) >= 0.1)
				{
					continue;
				}

				param_00.vel = (0,0,0);
				return 1;
			}
		}

		param_00.velocity = var_11;
		var_05 = var_12;
	}

	if(param_02)
	{
		param_00.vel = var_05;
	}

	return var_09 != 0;
}

//Function Number: 5
vec2dot(param_00,param_01)
{
	return param_00[0] * param_01[0] + param_00[1] * param_01[1];
}

//Function Number: 6
pm_stepslidemove(param_00,param_01,param_02)
{
	var_03 = param_00.origin;
	var_04 = param_00.vel;
	var_05 = pm_slidemove(param_00,param_01,param_02);
	var_06 = 18;
	var_07 = 18;
	var_08 = 1;
	var_09 = param_00.origin;
	var_0A = param_00.vel;
	var_0B = var_09 - var_03;
	var_0C = 0;
	if(var_05 || param_01[2] < 0.9)
	{
		var_0D = var_03 + (0,0,var_06 + 1);
		var_0E = playerphysicstraceinfo(var_03,var_0D,self);
		var_0C = var_0E["fraction"] * var_06 + 1 - 1;
		if(var_0C < 1)
		{
			var_0C = 0;
		}
		else
		{
			param_00.origin = (var_0D[0],var_0D[1],var_03[2] + var_0C);
			param_00.vel = var_04;
			pm_slidemove(param_00,param_01,param_02);
		}
	}

	if(var_08 || var_0C)
	{
		var_0F = param_00.origin - (0,0,var_0C);
		if(var_08)
		{
			var_0F = var_0F - (0,0,var_07 * 0.5);
		}

		var_0E = playerphysicstraceinfo(param_00.origin,var_0F,self);
		if(var_0E["fraction"] < 1)
		{
			param_00.origin = var_0E["position"];
			if(var_0C && param_00.origin[2] - max(var_09[2],var_03[2]) > 2 * var_06 * var_0E["normal"][2])
			{
				param_00.origin = var_09;
				param_00.vel = var_0A;
				return;
			}

			param_00.vel = pm_projectvelocity(param_00.vel,var_0E["normal"]);
		}
		else if(var_0C)
		{
			param_00.origin = param_00.origin - (0,0,var_0C);
		}
	}

	var_10 = param_00.origin - var_03;
	var_10 = (var_10[0],var_10[1],0);
	var_11 = vec2dot(var_10,var_04) <= vec2dot(var_0B,var_04) + 0.001;
	if(var_11)
	{
		var_09 = param_00.origin;
		var_0A = param_00.vel;
		var_0C = 0;
		if(var_08)
		{
			var_0F = param_00.origin - (0,0,var_07 * 0.5);
			var_0E = playerphysicstraceinfo(param_00.origin,var_0F,self);
			if(var_0E["fraction"] < 1)
			{
				var_0C = var_0E["position"][2] - param_00.origin[2];
				param_00.origin = var_0E["position"];
				param_00.vel = pm_clipvelocity(param_00.vel,var_0E["normal"]);
				return;
			}
		}
	}
}