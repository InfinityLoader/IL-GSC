/*******************************************************************
 * Decompiled By: Bog
 * Decompiled File: _compass.gsc
 * Game: Call of Duty: Advanced Warfare
 * Platform: PC
 * Function Count: 2
 * Decompile Time: 43 ms
 * Timestamp: 4/22/2024 2:20:21 AM
*******************************************************************/

//Function Number: 1
setupminimap(param_00,param_01)
{
	level.minimap_image = param_00;
	if(!isdefined(level._loadstarted) && !isdefined(param_01))
	{
	}

	if(!isdefined(param_01))
	{
		param_01 = "minimap_corner";
	}

	var_02 = getdvarfloat("scr_requiredMapAspectRatio",1);
	var_03 = getentarray(param_01,"targetname");
	if(var_03.size != 2)
	{
		return;
	}

	var_04 = (var_03[0].origin[0],var_03[0].origin[1],0);
	var_05 = (var_03[1].origin[0],var_03[1].origin[1],0);
	var_06 = var_05 - var_04;
	var_07 = (cos(getnorthyaw()),sin(getnorthyaw()),0);
	var_08 = (0 - var_07[1],var_07[0],0);
	if(vectordot(var_06,var_08) > 0)
	{
		if(vectordot(var_06,var_07) > 0)
		{
			var_09 = var_05;
			var_0A = var_04;
		}
		else
		{
			var_0B = vecscale(var_09,vectordot(var_08,var_09));
			var_09 = var_05 - var_0B;
			var_0A = var_04 + var_0B;
		}
	}
	else if(vectordot(var_08,var_09) > 0)
	{
		var_0B = vecscale(var_09,vectordot(var_08,var_09));
		var_09 = var_04 + var_0B;
		var_0A = var_05 - var_0B;
	}
	else
	{
		var_09 = var_06;
		var_0A = var_06;
	}

	if(var_02 > 0)
	{
		var_0C = vectordot(var_09 - var_0A,var_07);
		var_0D = vectordot(var_09 - var_0A,var_08);
		var_0E = var_0D / var_0C;
		if(var_0E < var_02)
		{
			var_0F = var_02 / var_0E;
			var_10 = vecscale(var_08,var_0D * var_0F - 1 * 0.5);
		}
		else
		{
			var_0F = var_10 / var_04;
			var_10 = vecscale(var_08,var_0D * var_10 - 1 * 0.5);
		}

		var_09 = var_09 + var_10;
		var_0A = var_0A - var_10;
	}

	level.map_extents = [];
	level.map_extents["top"] = var_09[1];
	level.map_extents["left"] = var_0A[0];
	level.map_extents["bottom"] = var_0A[1];
	level.map_extents["right"] = var_09[0];
	level.map_width = level.map_extents["right"] - level.map_extents["left"];
	level.map_height = level.map_extents["top"] - level.map_extents["bottom"];
	level.mapsize = vectordot(var_09 - var_0A,var_07);
	setminimap(param_00,var_09[0],var_09[1],var_0A[0],var_0A[1]);
}

//Function Number: 2
vecscale(param_00,param_01)
{
	return (param_00[0] * param_01,param_00[1] * param_01,param_00[2] * param_01);
}