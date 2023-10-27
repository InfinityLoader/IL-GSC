/*******************************************************************
 * Decompiled By: Bog
 * Decompiled File: 2833.gsc
 * Game: Call of Duty: Infinite Warfare
 * Platform: PC
 * Function Count: 7
 * Decompile Time: 3 ms
 * Timestamp: 10/27/2023 12:23:53 AM
*******************************************************************/

//Function Number: 1
func_37A9()
{
	precachemodel("fx_org_view");
}

//Function Number: 2
func_CCBE()
{
	var_00 = spawn("script_model",(0,0,0));
	var_00 setmodel("tag_origin");
	var_00 linkto(level.player,"tag_origin",(0,0,0),(0,0,0));
	var_00.var_C04F = 1;
	level.player.var_763C = var_00;
	var_01 = scripts\common\utility::getstructarray("fxchain_start","script_noteworthy");
	level.var_AD40 = [];
	level.var_C1E0 = var_01.size;
	for(var_02 = 0;var_02 < var_01.size;var_02++)
	{
		var_01[var_02].var_3C0A = var_02;
		var_01[var_02] func_6C76();
	}

	var_01 = undefined;
	level.var_C1E0 = undefined;
	level.var_AD40 = scripts\common\utility::func_22C3(level.var_AD40,::func_445A);
	level.var_37CF = level.var_AD40[0]["start_struct"];
	level.var_37CE = 0;
	playfxontag(scripts\common\utility::getfx(level.var_37CF.var_EE79),var_00,"tag_origin");
	level.var_AD40 = undefined;
	var_03 = scripts\common\utility::getstructarray("fxchain_transition","targetname");
	thread func_68A8(var_00);
	for(;;)
	{
		wait(0.25);
		if(level.var_37CE)
		{
			continue;
		}

		if(var_03.size > 0)
		{
			var_04 = sortbydistance(var_03,level.player.origin)[0];
			if(distance2dsquared(level.player.origin,var_04.origin) <= squared(var_04.var_257))
			{
				var_05 = scripts\common\utility::getstruct(var_04.script_noteworthy,"targetname");
				var_06 = scripts\common\utility::getstruct(var_04.var_EE79,"targetname");
				var_07 = vectordot(anglestoforward(var_04.angles),level.player.origin - var_04.origin);
				var_08 = undefined;
				if(var_07 > 0 && level.var_37CF.var_3C0A == var_06.var_3C0A)
				{
					var_08 = var_05;
				}

				if(var_07 < 0 && level.var_37CF.var_3C0A == var_05.var_3C0A)
				{
					var_08 = var_06;
				}

				if(isdefined(var_08))
				{
					func_12660(var_08,var_00);
				}
			}
		}

		var_09 = [];
		foreach(var_0B in scripts\common\utility::getstructarray(level.var_37CF.var_336,"target"))
		{
			var_09[var_09.size] = func_7A8D(var_0B,level.var_37CF);
		}

		if(isdefined(level.var_37CF.target))
		{
			var_0D = scripts\common\utility::getstructarray(level.var_37CF.target,"targetname");
			foreach(var_0F in var_0D)
			{
				var_09[var_09.size] = func_7A8D(level.var_37CF,var_0F);
				if(isdefined(var_0F.target))
				{
					var_10 = scripts\common\utility::getstructarray(var_0F.target,"targetname");
					foreach(var_12 in var_10)
					{
						var_09[var_09.size] = func_7A8D(var_0F,var_12);
					}
				}
			}
		}

		var_09 = scripts\common\utility::func_22C3(var_09,::func_445A);
		var_08 = var_09[0]["start_struct"];
		if(var_08.origin != level.var_37CF.origin)
		{
			if(var_08.var_EE79 != level.var_37CF.var_EE79)
			{
				func_12660(var_08,var_00);
				continue;
			}

			level.var_37CF = var_08;
		}
	}
}

//Function Number: 3
func_6C76()
{
	if(isdefined(self.target))
	{
		var_00 = scripts\common\utility::getstructarray(self.target,"targetname");
		foreach(var_02 in var_00)
		{
			if(!isdefined(var_02.var_3C0A))
			{
				var_02.var_3C0A = self.var_3C0A;
				level.var_AD40[level.var_AD40.size] = func_7A8D(self,var_02);
				level.var_C1E0++;
				var_02 func_6C76();
			}
		}
	}
}

//Function Number: 4
func_7A8D(param_00,param_01)
{
	var_02 = [];
	var_02["start_struct"] = param_00;
	var_02["closest_point"] = pointonsegmentnearesttopoint(param_00.origin,param_01.origin,level.player.origin);
	return var_02;
}

//Function Number: 5
func_445A(param_00,param_01)
{
	return distancesquared(param_00["closest_point"],level.player.origin) < distancesquared(param_01["closest_point"],level.player.origin);
}

//Function Number: 6
func_68A8(param_00)
{
}

//Function Number: 7
func_12660(param_00,param_01)
{
	stopfxontag(scripts\common\utility::getfx(level.var_37CF.var_EE79),param_01,"tag_origin");
	playfxontag(scripts\common\utility::getfx(param_00.var_EE79),param_01,"tag_origin");
	level.var_37CF = param_00;
}