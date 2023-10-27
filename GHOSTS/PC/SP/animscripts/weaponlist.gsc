/*******************************************************************
 * Decompiled By: Bog
 * Decompiled File: animscripts\weaponlist.gsc
 * Game: Call of Duty: Ghosts
 * Platform: PC
 * Function Count: 9
 * Decompile Time: 162 ms
 * Timestamp: 10/27/2023 1:24:45 AM
*******************************************************************/

//Function Number: 1
func_87EF()
{
	return weaponisauto(self.weapon) || weaponburstcount(self.weapon) > 0;
}

//Function Number: 2
func_87FC()
{
	return weaponissemiauto(self.weapon);
}

//Function Number: 3
autoshootanimrate()
{
	if(func_87EF())
	{
		return 0.1 / weaponfiretime(self.weapon);
	}

	return 0.5;
}

//Function Number: 4
burstshootanimrate()
{
	if(func_87EF())
	{
		return 0.1 / weaponfiretime(self.weapon);
	}

	return 0.2;
}

//Function Number: 5
func_8ACB()
{
	return 0.25;
}

//Function Number: 6
shootanimtime(param_00)
{
	if(!func_87EF() || isdefined(param_00) && param_00 == 1)
	{
		var_01 = 0.5 + randomfloat(1);
		return weaponfiretime(self.weapon) * var_01;
	}

	return weaponfiretime(self.weapon);
}

//Function Number: 7
refillclip()
{
	if(self.weapon == "none")
	{
		self.bulletsinclip = 0;
		return 0;
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
add_weapon(param_00,param_01,param_02,param_03,param_04)
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
	level.aiweapon[param_00]["type"] = param_01;
	level.aiweapon[param_00]["time"] = param_02;
	level.aiweapon[param_00]["clipsize"] = param_03;
	level.aiweapon[param_00]["anims"] = param_04;
}

//Function Number: 9
func_09A4(param_00)
{
	level.aiweapon[tolower(param_00)]["type"] = "turret";
}