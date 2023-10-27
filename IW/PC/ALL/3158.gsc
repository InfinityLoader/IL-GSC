/*******************************************************************
 * Decompiled By: Bog
 * Decompiled File: 3158.gsc
 * Game: Call of Duty: Infinite Warfare
 * Platform: PC
 * Function Count: 32
 * Decompile Time: 10 ms
 * Timestamp: 10/27/2023 12:26:20 AM
*******************************************************************/

//Function Number: 1
func_98CC(param_00,param_01,param_02,param_03)
{
	self.var_1198.var_FED6 = lib_0A1A::func_233A(self.var_238F);
}

//Function Number: 2
func_FFC9(param_00,param_01,param_02,param_03)
{
	if(!lib_0A1B::func_291C())
	{
		return 0;
	}

	return lib_0A1A::func_232B(param_01,"burst_delay_finished");
}

//Function Number: 3
func_8981(param_00)
{
	self endon(param_00 + "_finished");
	func_32BE();
	lib_0A1A::func_2330(param_00,"burst_delay_finished");
}

//Function Number: 4
func_FE76(param_00,param_01,param_02,param_03)
{
	thread func_8981(param_01);
	if(lib_0A1B::func_2955())
	{
		return;
	}

	lib_0A1E::func_2361(param_00,param_01,param_02,param_03);
}

//Function Number: 5
func_10002(param_00,param_01,param_02,param_03)
{
	if(!func_10081(param_00,param_01,param_02,param_03))
	{
		return 1;
	}

	return 0;
}

//Function Number: 6
func_10081(param_00,param_01,param_02,param_03)
{
	if(!scripts\anim\utility_common::func_9D4D())
	{
		return 0;
	}

	if(lib_0A2B::func_9F60())
	{
		return 0;
	}

	return 1;
}

//Function Number: 7
func_10080(param_00,param_01,param_02,param_03)
{
	if(!scripts\anim\utility_common::func_9D4D())
	{
		return func_FFC9(param_00,param_01,param_02,param_03);
	}

	if(lib_0A2B::func_9F60())
	{
		return 0;
	}

	if(!func_FFC9(param_00,param_01,param_02,param_03))
	{
		return 0;
	}

	return 1;
}

//Function Number: 8
func_FE75(param_00,param_01,param_02,param_03)
{
	thread func_8981(param_01);
	if(scripts\anim\utility_common::func_9D4D())
	{
		return;
	}

	if(lib_0A1B::func_2955())
	{
		return;
	}

	lib_0A1E::func_2361(param_00,param_01,param_02,param_03);
}

//Function Number: 9
func_FE58(param_00,param_01,param_02,param_03)
{
	thread func_8981(param_01);
}

//Function Number: 10
func_FECE(param_00,param_01,param_02,param_03)
{
	var_04 = self.var_2303.var_FECD;
	var_05 = self.var_1198.var_FECD;
	if(!isdefined(var_05))
	{
		return 1;
	}

	if(scripts\anim\utility_common::func_9D4D())
	{
		return 0;
	}

	if(func_3DFB(var_04.var_65D3,var_05.var_65D3) || !isdefined(var_04.var_65D3) && func_3DFB(var_04.var_D699,var_05.var_D699) || func_3DFB(var_04.var_1119D,var_05.var_1119D))
	{
		return 1;
	}

	return 0;
}

//Function Number: 11
func_FEDC(param_00,param_01,param_02,param_03)
{
	if(isdefined(self.var_2303.var_FECD))
	{
		return self.var_2303.var_FECD.var_FF0B == 1;
	}

	return self.var_1198.var_FECD.var_FF0B == 1;
}

//Function Number: 12
func_FED9(param_00,param_01,param_02,param_03)
{
	if(self.var_1198.var_FECD.var_1119D == "full" || self.var_1198.var_FECD.var_1119D == "burst")
	{
		return 1;
	}

	return 0;
}

//Function Number: 13
func_C185(param_00,param_01,param_02,param_03)
{
	return !func_10078(param_00,param_01,param_02,param_03);
}

//Function Number: 14
func_10078(param_00,param_01,param_02,param_03)
{
	return scripts\anim\utility_common::func_13112() || isdefined(self method_8164());
}

//Function Number: 15
func_FEDA(param_00,param_01,param_02,param_03)
{
	return self.var_1198.var_FECD.var_1119D == "mg";
}

//Function Number: 16
func_3DFB(param_00,param_01)
{
	if(isdefined(param_00) != isdefined(param_01))
	{
		return 1;
	}

	if(!isdefined(param_01))
	{
		return 0;
	}

	return param_00 != param_01;
}

//Function Number: 17
func_5AAC(param_00)
{
	var_01 = self method_8164();
	var_01 method_8398();
	var_01 endon("death");
	var_01 endon("turretstatechange");
	var_02 = self.var_2303.var_FECD.var_FF0B;
	while(var_02 > 0)
	{
		var_01 method_837E();
		var_02--;
		self.var_1491.var_A9ED = gettime();
		wait(param_00);
	}

	var_01 method_83A3();
}

//Function Number: 18
func_5AAB(param_00,param_01,param_02,param_03)
{
	var_04 = self.var_2303.var_FECD.var_FF0B;
	var_05 = lib_0A1E::func_2336(param_00,param_01);
	var_06 = getanimlength(var_05);
	var_06 = var_06 / param_03;
	self method_83CE();
	while(var_04 > 0)
	{
		var_04--;
		scripts\anim\utility_common::func_FE9A(0);
		self method_82E7(param_01,var_05,1,param_02,var_06);
		scripts\anim\combat_utility::func_4FBE();
		wait(param_03);
	}

	self method_837D();
}

//Function Number: 19
func_FE70(param_00,param_01,param_02,param_03)
{
	self endon(param_01 + "_finished");
	func_FE89();
	var_04 = func_FE64();
	if(isdefined(self method_8164()))
	{
		func_5AAC(var_04);
	}
	else
	{
		func_5AAB(param_00,param_01,param_02,var_04);
	}

	self.var_2303.var_FECD.var_C21C--;
	lib_0A1A::func_2330("shoot","shoot_finished");
	lib_0A1A::func_2330(param_01,"shoot_finished");
}

//Function Number: 20
func_FE71(param_00,param_01,param_02)
{
	self method_837D();
}

//Function Number: 21
func_FE61(param_00,param_01,param_02,param_03)
{
	self endon(param_01 + "_finished");
	if(!isdefined(self.var_2303.var_FECD))
	{
		func_FE89();
	}

	if(scripts\anim\utility_common::func_9D4D(1))
	{
		lib_0A2B::func_C599();
	}

	var_04 = func_FE64();
	self method_83CE();
	var_05 = lib_0A1E::func_2336(param_00,param_01);
	self method_82E7(param_01,var_05,1,param_02,var_04);
	func_FE5C(param_00,param_01,var_05,2);
	self.var_2303.var_FECD.var_C21C--;
	if(!func_FEDC())
	{
		func_FE82(0.05);
	}

	lib_0A1A::func_2330("shoot","shoot_finished");
	lib_0A1A::func_2330(param_01,"shoot_finished");
	if(scripts\anim\utility_common::func_9D4D(1))
	{
		lib_0A2B::func_C59A();
	}
}

//Function Number: 22
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

//Function Number: 23
func_FE82(param_00)
{
	self endon("terminate_ai_threads");
	wait(param_00);
	self method_837D();
}

//Function Number: 24
func_FE5C(param_00,param_01,param_02,param_03)
{
	var_04 = param_01 + "_timeout";
	var_05 = param_01 + "_timeout_end";
	childthread func_FE84(var_04,var_05,param_03);
	self endon(var_04);
	var_06 = animhasnotetrack(param_02,"fire");
	var_07 = weaponclass(self.var_394) == "rocketlauncher";
	if(var_06)
	{
		var_08 = getnotetracktimes(param_02,"fire");
		if(var_08.size == 1 && var_08[0] == 0)
		{
			var_06 = 0;
		}
	}

	var_09 = 0;
	var_0A = self.var_2303.var_FECD.var_FF0B;
	var_0B = var_0A == 1 || self.var_2303.var_FECD.var_1119D == "semi";
	var_0C = isplayer(self.var_10C) && self.var_10C scripts\sp\_utility::func_65DB("player_is_invulnerable");
	var_0D = scripts\anim\utility_common::func_13C40();
	while(var_09 < var_0A && var_0A > 0)
	{
		if(var_06)
		{
			self waittillmatch("fire",param_01);
		}

		if(!self.var_3250)
		{
			break;
		}

		func_FE96(var_0B);
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

		if(var_07)
		{
			self.var_1491.var_E5DE--;
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

		if(!var_06 || var_0A == 1 && self.var_2303.var_FECD.var_1119D == "single")
		{
			self waittillmatch("end",param_01);
		}
	}

	self notify(var_05);
}

//Function Number: 25
func_FE96(param_00)
{
	if(isdefined(self.var_2303.var_FECD.var_65D3))
	{
		if(isdefined(self.var_10C) && self.var_2303.var_FECD.var_65D3 == self.var_10C)
		{
			self [[ level.var_FE9B ]](param_00);
			return;
		}

		return;
	}

	self [[ level.var_FED3 ]](self.var_2303.var_FECD.var_D699,param_00);
}

//Function Number: 26
func_FE84(param_00,param_01,param_02)
{
	self endon(param_01);
	wait(param_02);
	self notify(param_00);
}

//Function Number: 27
func_FE64()
{
	var_00 = self.var_2303.var_FECD.var_1119D;
	var_01 = 1;
	if(isdefined(self.var_FED4))
	{
		var_01 = self.var_FED4;
	}
	else if(var_00 == "mg")
	{
		var_01 = 0.1;
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
		var_01 = scripts\anim\combat_utility::func_FEFE();
	}

	return var_01;
}

//Function Number: 28
func_FE89(param_00,param_01,param_02,param_03)
{
	var_04 = self.var_1198.var_FECD;
	if(!isdefined(self.var_2303.var_FECD))
	{
		self.var_2303.var_FECD = spawnstruct();
		self.var_2303.var_FECD.var_C21C = var_04.var_32BD;
	}

	self.var_2303.var_FECD.var_1119D = var_04.var_1119D;
	self.var_2303.var_FECD.var_6B92 = var_04.var_6B92;
	self.var_2303.var_FECD.var_FF0B = var_04.var_FF0B;
	self.var_2303.var_FECD.var_D699 = var_04.var_D699;
	self.var_2303.var_FECD.var_65D3 = var_04.var_65D3;
	switch(var_04.var_1119D)
	{
		case "semi":
		case "burst":
			self.var_2303.var_FECD.var_FF0B = lib_0A06::func_4F65(var_04);
			break;

		case "full":
			self.var_2303.var_FECD.var_FF0B = lib_0A06::func_4F66();
			break;

		case "mg":
			self.var_2303.var_FECD.var_FF0B = lib_0A06::func_4F68();
			break;
	}

	return 1;
}

//Function Number: 29
func_32BE()
{
	if(isdefined(self.var_2303.var_FECD) && self.var_2303.var_FECD.var_1119D == "full" && !self.var_2303.var_FECD.var_6B92)
	{
		if(self.var_1491.var_A9ED == gettime())
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

//Function Number: 30
func_80E7()
{
	var_00 = gettime() - self.var_1491.var_A9ED / 1000;
	var_01 = func_7E12();
	if(var_01 > var_00)
	{
		return var_01 - var_00;
	}

	return 0;
}

//Function Number: 31
func_7E13()
{
	var_00 = isdefined(self.var_129B9);
	if(var_00 && isdefined(self.var_129B9.var_ED50))
	{
		var_01 = self.var_129B9.var_ED50;
	}
	else
	{
		var_01 = 0.2;
	}

	if(var_00 && isdefined(self.var_129B9.var_ED4F))
	{
		var_02 = self.var_129B9.var_ED4F - var_01;
	}
	else
	{
		var_02 = 0.5;
	}

	return var_01 + randomfloat(var_02);
}

//Function Number: 32
func_7E12()
{
	if(scripts\sp\_mgturret::func_130FD() || weaponclass(self.var_394) == "mg")
	{
		return func_7E13();
	}

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
		return scripts\anim\combat_utility::func_8130();
	}

	if(isdefined(self.var_2303.var_FECD))
	{
		if(self.var_2303.var_FECD.var_6B92)
		{
			if(isdefined(self.var_2303.var_FECD.var_65D3))
			{
				return randomfloatrange(0.2,0.4);
			}
			else
			{
				return randomfloatrange(0.6,1);
			}
		}

		if(isdefined(self.var_2303.var_FECD.var_65D3))
		{
			return randomfloatrange(0.4,0.9);
		}
		else
		{
			return randomfloatrange(0.8,1.2);
		}
	}

	return randomfloatrange(0.8,1.2);
}