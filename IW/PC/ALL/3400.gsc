/*******************************************************************
 * Decompiled By: Bog
 * Decompiled File: 3400.gsc
 * Game: Call of Duty: Infinite Warfare
 * Platform: PC
 * Function Count: 12
 * Decompile Time: 2 ms
 * Timestamp: 10/27/2023 12:27:03 AM
*******************************************************************/

//Function Number: 1
func_97AF()
{
	level.var_13F0F = [];
	func_DEE1("space_helmet",200,"head","ref_space_helmet_02_zombie","tag_eye",(-4,0,-1),(0,90,12));
}

//Function Number: 2
func_DEE1(param_00,param_01,param_02,param_03,param_04,param_05,param_06)
{
	var_07 = spawnstruct();
	var_07.health = param_01;
	var_07.model = param_03;
	var_07.var_9038 = param_02;
	var_07.var_2DD = param_04;
	var_07.var_AEBA = param_05;
	var_07.var_1E79 = param_06;
	level.var_13F0F[param_00] = var_07;
}

//Function Number: 3
func_668D(param_00)
{
	if(!func_381A(param_00))
	{
		return;
	}

	foreach(var_02 in func_782B())
	{
		func_668C(param_00,var_02);
	}
}

//Function Number: 4
func_668C(param_00,param_01)
{
	if(!isdefined(param_00.var_6691))
	{
		param_00.var_6691 = [];
	}

	var_02 = level.var_13F0F[param_01];
	var_03 = param_00 gettagorigin(var_02.var_2DD);
	var_04 = spawn("script_model",var_03);
	var_04 setmodel(var_02.model);
	var_04.angles = param_00.angles;
	var_04.var_6AEF = var_02.health;
	var_04 linkto(param_00,var_02.var_2DD,var_02.var_AEBA,var_02.var_1E79);
	var_04 thread func_217F(var_04,param_00);
	param_00.var_6691[var_02.var_9038] = var_04;
}

//Function Number: 5
func_D96F(param_00,param_01,param_02,param_03,param_04)
{
	if(scripts\common\utility::istrue(param_00.disable_armor))
	{
		return param_02;
	}

	if(!isdefined(param_00.var_6691))
	{
		return param_02;
	}

	var_05 = param_00.var_6691[param_03];
	if(!isdefined(var_05))
	{
		return param_02;
	}

	if(var_05.var_6AEF <= 0)
	{
		return param_02;
	}

	var_05 notify("damage",param_02,param_01,param_04);
	return 0;
}

//Function Number: 6
func_403E(param_00)
{
	if(!isdefined(param_00.var_6691))
	{
		return;
	}

	foreach(var_02 in param_00.var_6691)
	{
		if(isdefined(var_02))
		{
			var_02 notify("damage",var_02.var_6AEF);
		}
	}
}

//Function Number: 7
func_217F(param_00,param_01)
{
	param_00 setcandamage(1);
	param_00.health = 999999;
	var_02 = gettime();
	var_03 = undefined;
	for(;;)
	{
		param_00 waittill("damage",var_04,var_05,var_06);
		if(scripts\common\utility::istrue(level.var_9925))
		{
			var_04 = param_00.var_6AEF;
			if(isdefined(param_01))
			{
				param_01 dodamage(param_01.health,param_00.origin);
			}
		}

		var_07 = gettime();
		if(var_07 != var_02)
		{
			if(isplayer(var_05))
			{
				var_05 scripts\cp\_damage::func_12E84("hitalienarmor");
			}

			var_02 = var_07;
			var_03 = var_06;
			param_00.var_6AEF = param_00.var_6AEF - var_04;
			if(param_00.var_6AEF <= 0)
			{
				break;
			}
		}
	}

	param_00 thread func_5386(param_00,var_03);
}

//Function Number: 8
func_5386(param_00,param_01)
{
	param_01 = func_B931(param_01);
	if(isdefined(param_01))
	{
		var_02 = spawn("script_model",param_00.origin);
		var_02 setmodel(param_00.model);
		var_02.angles = param_00.angles;
		wait(0.1);
		param_00 delete();
		var_02 physicslaunchclient(var_02.origin,param_01);
		var_02 thread func_50AF(var_02);
		return;
	}

	param_00 thread func_50AF(param_00);
}

//Function Number: 9
func_B931(param_00)
{
	if(!isdefined(param_00))
	{
		return undefined;
	}

	param_00 = vectornormalize((param_00[0],param_00[1],0));
	param_00 = param_00 + (0,0,1);
	return vectornormalize(param_00) * 1250;
}

//Function Number: 10
func_50AF(param_00)
{
	wait(5);
	param_00 delete();
}

//Function Number: 11
func_782B()
{
	var_00 = 6000;
	if(level.wave_num >= var_00)
	{
		if(randomint(100) <= level.wave_num)
		{
			return ["space_helmet"];
		}
	}

	return [];
}

//Function Number: 12
func_381A(param_00)
{
	if(param_00 lib_0C75::func_9E0F())
	{
		return 0;
	}

	return 1;
}