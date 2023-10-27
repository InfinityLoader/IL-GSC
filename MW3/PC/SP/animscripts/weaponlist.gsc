/*******************************************************************
 * Decompiled By: Bog
 * Decompiled File: animscripts\weaponlist.gsc
 * Game: Call of Duty: Modern Warfare 3
 * Platform: PC
 * Function Count: 9
 * Decompile Time: 147 ms
 * Timestamp: 10/27/2023 2:18:59 AM
*******************************************************************/

//Function Number: 1
func_0CCA()
{
	return weaponisauto(self.weapon) || weaponburstcount(self.weapon) > 0;
}

//Function Number: 2
func_0CCB()
{
	return weaponissemiauto(self.weapon);
}

//Function Number: 3
func_0CCC()
{
	if(func_0CCA())
	{
		return 0.1 / weaponfiretime(self.weapon);
	}

	return 0.5;
}

//Function Number: 4
func_0CCD()
{
	if(func_0CCA())
	{
		return 0.1 / weaponfiretime(self.weapon);
	}

	return 0.2;
}

//Function Number: 5
func_0CCE()
{
	return 0.25;
}

//Function Number: 6
func_0CCF(param_00)
{
	if(!func_0CCA() || isdefined(param_00) && param_00 == 1)
	{
		var_01 = 0.5 + randomfloat(1);
		return weaponfiretime(self.weapon) * var_01;
	}

	return weaponfiretime(self.weapon);
}

//Function Number: 7
func_0CD0()
{
	if(self.weapon == "none")
	{
		self.bulletsinclip = 0;
		return 0;
	}

	if(weaponclass(self.weapon) == "rocketlauncher")
	{
		if(!self.a.var_CD2)
		{
			thread animscripts/combat_utility::func_CD3();
		}
	}

	if(!isdefined(self.bulletsinclip))
	{
		self.bulletsinclip = weaponclipsize(self.weapon);
	}
	else
	{
		self.bulletsinclip = weaponclipsize(self.weapon);
	}

	if(self.bulletsinclip <= 0)
	{
		return 0;
	}

	return 1;
}

//Function Number: 8
func_0CD4(param_00,param_01,param_02,param_03,param_04)
{
	if(!isdefined(param_02))
	{
		param_02 = 3;
	}

	if(!isdefined(param_03))
	{
		param_02 = 1;
	}

	if(!isdefined(param_04))
	{
		param_04 = "rifle";
	}

	param_00 = tolower(param_00);
	level.var_CD5[param_00]["type"] = param_01;
	level.var_CD5[param_00]["time"] = param_02;
	level.var_CD5[param_00]["clipsize"] = param_03;
	level.var_CD5[param_00]["anims"] = param_04;
}

//Function Number: 9
func_0CD6(param_00)
{
	level.var_CD5[tolower(param_00)]["type"] = "turret";
}