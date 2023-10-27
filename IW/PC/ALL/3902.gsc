/*******************************************************************
 * Decompiled By: Bog
 * Decompiled File: 3902.gsc
 * Game: Call of Duty: Infinite Warfare
 * Platform: PC
 * Function Count: 14
 * Decompile Time: 4 ms
 * Timestamp: 10/27/2023 12:31:11 AM
*******************************************************************/

//Function Number: 1
func_98CC(param_00,param_01,param_02,param_03)
{
	self.var_1198.var_FED6 = lib_0A1A::func_233A(self.var_238F);
}

//Function Number: 2
func_FE75(param_00,param_01,param_02,param_03)
{
	lib_0A1D::func_2361(param_00,param_01,param_02,param_03);
}

//Function Number: 3
func_FE61(param_00,param_01,param_02,param_03)
{
	self endon(param_01 + "_finished");
	func_FE89();
	var_04 = func_FE64();
	self method_83CE();
	var_05 = lib_0A1D::func_2337(param_00,param_01);
	func_FE97(param_01,0.2,2);
	self.var_2303.var_FECD.var_C21C--;
	func_32BE();
	lib_0A1A::func_2330(param_01,"shoot_finished");
}

//Function Number: 4
func_FE7D(param_00)
{
	var_01 = param_00 + "_shotgun_sound";
	var_02 = param_00 + "kill_shotgun_sound";
	thread func_FE84(var_01,var_02,2);
	self endon(var_01);
	self waittillmatch("rechamber",param_00);
	self playsound("ai_shotgun_pump");
	self notify(var_02);
}

//Function Number: 5
func_FE97(param_00,param_01,param_02)
{
	var_03 = param_00 + "_timeout";
	var_04 = param_00 + "_timeout_end";
	thread func_FE84(var_03,var_04,param_02);
	self endon(var_03);
	self endon(param_00 + "_finished");
	var_05 = 0;
	var_06 = self.var_2303.var_FECD.var_FF0B;
	var_07 = var_06 == 1;
	var_08 = 0;
	var_09 = scripts\anim\utility_common::func_13C40();
	while(var_05 < var_06 && var_06 > 0)
	{
		if(!isdefined(self.var_1198.var_FECD))
		{
			break;
		}

		if(isdefined(self.var_10C))
		{
			if(!lib_0F3C::func_9DED() && !lib_0F3C::func_9FFF())
			{
				break;
			}
		}

		scripts\anim\utility_common::func_FE9A(var_07);
		if(self.var_3250 > 0)
		{
			if(var_08)
			{
				if(randomint(3) == 0)
				{
					self.var_3250--;
				}
			}
			else
			{
				self.var_3250--;
			}
		}

		var_05++;
		if(var_09)
		{
			childthread func_FE7D(param_00);
		}

		if(self.var_2303.var_FECD.var_6B92 && var_05 == var_06)
		{
			break;
		}

		wait(param_01);
	}

	self notify(var_04);
}

//Function Number: 6
func_FE5C(param_00,param_01,param_02,param_03)
{
	var_04 = param_01 + "_timeout";
	var_05 = param_01 + "_timeout_end";
	thread func_FE84(var_04,var_05,param_03);
	self endon(var_04);
	var_06 = self method_80FD(param_01,param_02);
	var_07 = animhasnotetrack(var_06,"fire");
	var_08 = weaponclass(self.var_394) == "rocketlauncher";
	var_09 = 0;
	var_0A = self.var_2303.var_FECD.var_FF0B;
	var_0B = var_0A == 1;
	var_0C = 0;
	var_0D = scripts\anim\utility_common::func_13C40();
	while(var_09 < var_0A && var_0A > 0)
	{
		if(var_07)
		{
			self waittillmatch("fire",param_01);
		}

		if(!self.var_3250)
		{
			break;
		}

		scripts\anim\utility_common::func_FE9A(var_0B);
		if(var_0C)
		{
			if(randomint(3) == 0)
			{
				self.var_3250--;
			}
		}
		else
		{
			self.var_3250--;
		}

		if(var_08)
		{
			if(issubstr(tolower(self.var_394),"rpg") || issubstr(tolower(self.var_394),"panzerfaust"))
			{
				self method_8187("tag_rocket");
			}
		}

		var_09++;
		if(var_0D)
		{
			childthread func_FE7D(param_01);
		}

		if(self.var_2303.var_FECD.var_6B92 && var_09 == var_0A)
		{
			break;
		}

		if(!var_07 || var_0A == 1 && self.var_2303.var_FECD.var_1119D == "single")
		{
			self waittillmatch("end",param_01);
		}
	}

	self notify(var_05);
}

//Function Number: 7
func_FE84(param_00,param_01,param_02)
{
	self endon(param_01);
	wait(param_02);
	self notify(param_00);
}

//Function Number: 8
func_FEFE()
{
	if(scripts\anim\utility_common::func_13C40())
	{
		return 1;
	}

	if(scripts\anim\weaponlist::func_1310F())
	{
		return scripts\anim\weaponlist::func_2691() * 0.7;
	}

	return 0.4;
}

//Function Number: 9
func_FE64()
{
	var_00 = self.var_2303.var_FECD.var_1119D;
	var_01 = 1;
	if(isdefined(self.var_FED4))
	{
		var_01 = self.var_FED4;
	}
	else if(var_00 == "full")
	{
		var_01 = scripts\anim\weaponlist::func_2691() * randomfloatrange(0.5,1);
	}
	else if(var_00 == "burst")
	{
		var_01 = scripts\anim\weaponlist::func_32C3();
	}
	else if(scripts\anim\utility_common::func_9FCA())
	{
		var_01 = 3;
	}
	else if(scripts\anim\utility_common::func_9FC9())
	{
		var_01 = func_FEFE();
	}

	return var_01;
}

//Function Number: 10
func_FE89()
{
	var_00 = self.var_1198.var_FECD;
	if(!isdefined(self.var_2303.var_FECD))
	{
		self.var_2303.var_FECD = spawnstruct();
		self.var_2303.var_FECD.var_C21C = var_00.var_32BD;
	}

	self.var_2303.var_FECD.var_1119D = var_00.var_1119D;
	self.var_2303.var_FECD.var_6B92 = var_00.var_6B92;
	self.var_2303.var_FECD.var_FF0B = var_00.var_FF0B;
	self.var_2303.var_FECD.var_D699 = var_00.var_D699;
	self.var_2303.var_FECD.var_65D3 = var_00.var_65D3;
}

//Function Number: 11
func_32BE()
{
	if(self.var_2303.var_FECD.var_1119D == "full" && !self.var_2303.var_FECD.var_6B92)
	{
		if(self.var_A9ED == gettime())
		{
			wait(0.05);
		}

		return;
	}

	var_00 = func_80E7();
	if(var_00)
	{
		wait(var_00);
	}
}

//Function Number: 12
func_80E7()
{
	var_00 = gettime() - self.var_A9ED / 1000;
	var_01 = func_7E12();
	if(var_01 > var_00)
	{
		return var_01 - var_00;
	}

	return 0;
}

//Function Number: 13
func_8130()
{
	if(isplayer(self.var_10C))
	{
		return randomfloatrange(self.var_10C.var_86A9.var_B750,self.var_10C.var_86A9.var_B461);
	}

	return randomfloatrange(level.var_B750,level.var_B461);
}

//Function Number: 14
func_7E12()
{
	if(scripts\anim\utility_common::func_9FCA())
	{
		return randomfloatrange(0.15,0.55);
	}

	if(scripts\anim\utility_common::func_13C40())
	{
		return randomfloatrange(1,1.7);
	}

	if(scripts\anim\utility_common::func_9D4D())
	{
		return func_8130();
	}

	if(self.var_2303.var_FECD.var_6B92)
	{
		return randomfloatrange(0.1,0.35);
	}

	return randomfloatrange(0.4,0.9);
}