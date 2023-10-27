/*******************************************************************
 * Decompiled By: Bog
 * Decompiled File: scripts\anim\face.gsc
 * Game: Call of Duty: Infinite Warfare
 * Platform: PC
 * Function Count: 9
 * Decompile Time: 471 ms
 * Timestamp: 10/27/2023 12:00:35 AM
*******************************************************************/

//Function Number: 1
func_EB83(param_00)
{
	if(self.var_12BA4 != "soldier" && self.var_12BA4 != "c6")
	{
		return;
	}

	var_01 = undefined;
	switch(param_00)
	{
		case "meleeattack":
		case "meleecharge":
			var_02 = 0.5;
			break;

		case "flashbang":
			var_02 = 0.7;
			var_01 = 50;
			break;

		case "pain":
			var_02 = 0.9;
			var_01 = 98;
			break;

		case "seekerattack":
		case "explodeath":
		case "death":
			var_02 = 1;
			break;

		default:
			var_02 = 0.3;
			break;
	}

	if(isdefined(var_01) && randomint(100) > var_01)
	{
		return;
	}

	var_03 = undefined;
	var_04 = "generic_";
	var_05 = undefined;
	var_06 = undefined;
	if(isdefined(self.var_C19D))
	{
		switch(self.var_C19D)
		{
			case "adm":
			case "mac":
			case "omr":
			case "ksh":
			case "brk":
			case "slt":
			case "eth":
				var_05 = self.var_C19D;
				var_04 = "hero_";
				var_06 = 1;
				break;
		}
	}

	if(!isdefined(var_05))
	{
		switch(self.var_13525)
		{
			case "unitednationshelmet":
			case "unitednations":
				var_05 = "friendly";
				var_06 = level.var_C22D;
				break;

			case "unitednationsfemale":
				var_05 = "friendly";
				var_04 = "woman_";
				var_06 = level.var_C22C;
				break;

			case "c6":
				var_05 = "c6";
				var_06 = 1;
				break;

			default:
				var_05 = "enemy";
				var_06 = level.var_C226;
				break;
		}
	}

	var_03 = 1 + self getentitynumber() % var_06;
	var_05 = var_05 + "_" + var_03;
	var_07 = undefined;
	if(!isdefined(var_07))
	{
		if(isdefined(self.var_777B))
		{
			var_07 = self.var_777B + "_" + param_00 + "_" + var_05;
		}
		else
		{
			var_07 = var_04 + param_00 + "_" + var_05;
		}

		if(!soundexists(var_07))
		{
			var_07 = "generic_" + param_00 + "_" + var_05;
		}
	}

	thread func_D474(var_07,undefined);
}

//Function Number: 2
func_EB86(param_00,param_01)
{
	thread func_D474(param_00,param_01);
}

//Function Number: 3
func_D474(param_00,param_01)
{
	if(isai(self))
	{
		self.var_1491.var_6A87 = 1;
		self.var_1491.var_6A8A = 1;
	}

	if(isdefined(param_01))
	{
		if(isdefined(param_00))
		{
			func_D473(param_00,"animscript facesound" + param_01,1);
			thread func_136BD(param_01);
			return;
		}

		return;
	}

	func_D473(param_00);
}

//Function Number: 4
func_D473(param_00,param_01,param_02)
{
	if(isai(self))
	{
		if(isdefined(param_01) && isdefined(param_02))
		{
			self method_824A(param_00,param_01,param_02);
			return;
		}

		if(isdefined(param_01))
		{
			self method_824A(param_00,param_01);
			return;
		}

		self method_824A(param_00);
		return;
	}

	if(isdefined(param_01) && isdefined(param_02))
	{
		self playsound(param_00,param_01,param_02);
		return;
	}

	if(isdefined(param_01))
	{
		self playsound(param_00,param_01);
		return;
	}

	self playsound(param_00);
}

//Function Number: 5
func_136BD(param_00)
{
	self endon("death");
	self waittill("animscript facesound" + param_00);
	self notify(param_00);
}

//Function Number: 6
func_9891()
{
	anim.var_C226 = 7;
	anim.var_C22D = 7;
	anim.var_C22C = 3;
	func_9805();
}

//Function Number: 7
func_9805()
{
	anim.var_6A81 = [];
}

//Function Number: 8
func_1FB7(param_00)
{
	return animhasnotetrack(param_00,"facial_override");
}

//Function Number: 9
func_D475(param_00,param_01,param_02)
{
	if(isdefined(self.var_29CC) && self.var_29CC)
	{
		self method_806F(%head,0.2);
		return;
	}

	if(isdefined(param_00) && func_1FB7(param_00))
	{
		self method_806F(%head,0.2);
		return;
	}

	if(!isdefined(level.var_6A81[param_01]))
	{
		return;
	}

	if(isdefined(param_02) && param_02 >= 0 && param_02 < level.var_6A81[param_01].size)
	{
		var_03 = param_02;
	}
	else
	{
		var_03 = randomint(level.var_6A81[param_02].size);
	}

	var_04 = level.var_6A81[param_01][var_03];
	self method_82A4(var_04);
	return var_03;
}