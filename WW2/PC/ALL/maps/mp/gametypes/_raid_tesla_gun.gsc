/*******************************************************************
 * Decompiled By: Bog
 * Decompiled File: maps\mp\gametypes\_raid_tesla_gun.gsc
 * Game: Call of Duty: WWII
 * Platform: PC
 * Function Count: 11
 * Decompile Time: 210 ms
 * Timestamp: 10/27/2023 3:10:34 AM
*******************************************************************/

//Function Number: 1
func_00D5()
{
	maps/mp/gametypes/_raid_tesla_gun_moon::func_6402();
}

//Function Number: 2
gettesladevguipath(param_00)
{
	var_01 = "Game Raids/Weapons/Special Items/Tesla Gun";
	if(isdefined(param_00))
	{
		var_01 = var_01 + "/" + param_00;
	}

	return var_01;
}

//Function Number: 3
func_408C()
{
	return ["teslagun_war_moon_mp"];
}

//Function Number: 4
devguigiveweapon(param_00)
{
	foreach(var_02 in level.var_744A)
	{
		var_02 giveweapon(param_00);
		var_02 switchtoweapon(param_00);
	}
}

//Function Number: 5
devguitakeweapon(param_00)
{
	foreach(var_02 in level.var_744A)
	{
		var_02 takeweapon(param_00);
	}
}

//Function Number: 6
func_98FA(param_00,param_01,param_02,param_03,param_04)
{
	var_05 = spawnstruct();
	var_05.var_8FAD = param_01;
	var_05.var_9014 = param_02;
	var_05.var_606B = param_03;
	var_05.var_A0A7 = param_04;
	var_05.var_953E = param_00;
	level thread maps\mp\_utility::func_6F74(::func_98F9,var_05);
}

//Function Number: 7
func_98F9(param_00)
{
	var_01 = self;
	for(;;)
	{
		var_01 waittill("weapon_fired",var_02);
		if(!func_5565(var_02,param_00.var_953E))
		{
			continue;
		}

		var_03 = [[ param_00.var_8FAD ]]();
		var_04 = [[ param_00.var_9014 ]]();
		var_05 = [[ param_00.var_606B ]]();
		var_06 = var_01 geteyeangles();
		var_07 = anglestoforward(var_06);
		var_08 = anglestoup(var_06);
		var_09 = var_01 geteye() + var_07 * var_03 + var_08 * var_04;
		var_0A = bullettrace(var_09,var_09 + var_05 * var_07,0,undefined,0,0,0,0,0,0,0);
		var_0B = spawn("script_model",var_09);
		var_0B.var_1D = var_01.var_1D;
		var_0B setmodel("tag_origin");
		var_0B.var_2DA7 = var_0A["position"];
		var_0B.var_2F0C = vectornormalize(var_0B.var_2DA7 - var_0B.var_116);
		var_0B.var_9B7F = var_0A["fraction"];
		var_0B.var_721C = var_01;
		var_0B.var_953E = param_00.var_953E;
		var_0B thread func_98FC();
		var_0B thread [[ param_00.var_A0A7 ]]();
	}
}

//Function Number: 8
func_98E9(param_00,param_01,param_02,param_03,param_04,param_05,param_06)
{
	radiusdamage(param_00,param_01,100,200,param_02,"MOD_ENERGY",param_04);
	physicsexplosioncylinder(param_00,param_01,0,1.7);
}

//Function Number: 9
func_98FC()
{
	var_00 = self;
	var_00 endon("death");
	var_01 = 30;
	var_02 = [];
	var_03 = 0;
	for(;;)
	{
		wait 0.05;
		foreach(var_05 in get_all_enemies(var_00.var_721C))
		{
			if(!isalive(var_05))
			{
				continue;
			}

			var_06 = 30;
			if(isdefined(var_05.var_8303))
			{
				var_06 = var_05.var_8303;
			}

			if(distance2d(var_05.var_116,var_00.var_116) > var_06 + var_01)
			{
				continue;
			}

			var_07 = 70;
			if(isdefined(var_05.var_8302))
			{
				var_07 = var_05.var_8302;
			}

			if(var_00.var_116[2] < var_05.var_116[2] - var_01 || var_00.var_116[2] > var_05.var_116[2] + var_07 + var_01)
			{
				continue;
			}

			var_08 = var_05 getentitynumber();
			if(isdefined(var_02[var_08]))
			{
				continue;
			}

			var_02[var_08] = 1;
			if(issubstr(var_00.var_953E,"moon"))
			{
				var_00 maps/mp/gametypes/_raid_tesla_gun_moon::func_63FC(var_05);
			}
			else
			{
			}

			var_03++;
			if(var_03 == 4)
			{
				var_03 = 0;
				wait 0.05;
			}
		}
	}
}

//Function Number: 10
func_5565(param_00,param_01)
{
	return isdefined(param_00) && isdefined(param_01) && param_00 == param_01;
}

//Function Number: 11
get_all_enemies(param_00)
{
	var_01 = [];
	foreach(var_03 in level.var_744A)
	{
		if(param_00 != var_03 && isdefined(var_03.var_1A7) && param_00.var_1A7 != var_03.var_1A7)
		{
			var_01[var_01.size] = var_03;
		}
	}

	return var_01;
}