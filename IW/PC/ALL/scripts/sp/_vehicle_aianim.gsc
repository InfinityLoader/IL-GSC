/*******************************************************************
 * Decompiled By: Bog
 * Decompiled File: scripts\sp\_vehicle_aianim.gsc
 * Game: Call of Duty: Infinite Warfare
 * Platform: PC
 * Function Count: 72
 * Decompile Time: 3375 ms
 * Timestamp: 10/27/2023 12:25:53 AM
*******************************************************************/

//Function Number: 1
func_8739(param_00,param_01)
{
	if(!isdefined(self))
	{
		return;
	}

	if(!isdefined(self.var_380))
	{
		return;
	}

	var_02 = self.classname;
	var_03 = level.var_131A0.var_116CE.var_1A03[var_02];
	self.var_247C[self.var_247C.size] = param_00;
	var_04 = func_F554(param_00,var_03);
	if(!isdefined(var_04))
	{
		return;
	}

	if(var_04 == 0)
	{
		param_00.var_5BD6 = 1;
	}

	var_05 = func_1F00(self,var_04);
	self.var_1307E[var_04] = 1;
	param_00.var_1321D = var_04;
	param_00.var_131F5 = 0;
	if(isdefined(var_05.var_50AE))
	{
		param_00.var_50AE = var_05.var_50AE;
		if(isdefined(var_05.var_510B))
		{
			self.var_5107 = param_00.var_50AE;
		}
	}

	if(isdefined(var_05.var_510B))
	{
		self.var_5107 = self.var_5107 + var_05.var_510B;
		param_00.var_50AE = self.var_5107;
	}

	param_00.var_E500 = self;
	param_00.var_C6F8 = param_00.health;
	param_00.var_131F2 = var_05.var_92CC;
	param_00.var_13240 = var_05.var_10B69;
	param_00.var_4E2A = var_05.var_E6;
	param_00.var_4E2E = var_05.var_4E5E;
	param_00.var_10B71 = 0;
	param_00.var_30 = 0;
	if(isdefined(param_00.var_4E2A) && !isdefined(param_00.var_B14F) && func_131A7())
	{
		if(param_00.var_1321D != 0 || func_131A6())
		{
			param_00.var_30 = !isdefined(param_00.var_ECED) || param_00.var_ECED;
			if(isdefined(var_05.var_4E14))
			{
				param_00.var_C089 = var_05.var_4E14;
			}
		}
	}

	if(param_00.classname == "script_model")
	{
		if(isdefined(var_05.var_E6) && param_00.var_30 && !isdefined(param_00.var_ECED) || param_00.var_ECED)
		{
			thread func_8730(param_00,var_05);
		}
	}

	if(!isdefined(param_00.var_131F2))
	{
		param_00.var_30 = 1;
	}

	self.var_E4FB[self.var_E4FB.size] = param_00;
	if(param_00.classname != "script_model" && scripts\sp\_utility::func_106ED(param_00))
	{
		return;
	}

	var_06 = self gettagorigin(var_05.var_10220);
	var_07 = self gettagangles(var_05.var_10220);
	func_AD14(param_00,var_05.var_10220,var_05.var_10221,var_05.var_AD46);
	if(isai(param_00))
	{
		param_00 method_83B9(var_06,var_07);
		param_00.var_1491.var_55FC = 1;
		if(isdefined(var_05.var_2AB6) && !var_05.var_2AB6)
		{
			param_00 scripts\sp\_utility::func_86E4();
		}

		if(func_8755(var_05))
		{
			thread func_874C(param_00,var_04,param_01);
		}
	}
	else
	{
		if(isdefined(var_05.var_2AB6) && !var_05.var_2AB6)
		{
			func_538C(param_00,"weapon_");
		}

		param_00.origin = var_06;
		param_00.angles = var_07;
	}

	if(var_04 == 0 && isdefined(var_03[0].var_E6))
	{
		thread func_5BCE(param_00);
	}

	self notify("guy_entered",param_00,var_04);
	thread func_8743(param_00,var_04);
	if(isdefined(var_05.var_E4FA))
	{
		param_00 [[ var_05.var_E4FA ]]();
		return;
	}

	if(isdefined(var_05.var_7F14))
	{
		thread [[ var_05.var_7F14 ]](param_00,var_04);
		return;
	}

	thread func_8744(param_00,var_04);
}

//Function Number: 2
func_131A6()
{
	if(!isdefined(self.var_ECEB))
	{
		return 0;
	}

	return self.var_ECEB;
}

//Function Number: 3
func_131A7()
{
	if(!isdefined(self.var_ECEC))
	{
		return 1;
	}

	return self.var_ECEC;
}

//Function Number: 4
func_8755(param_00)
{
	if(!isdefined(param_00.var_B6BD))
	{
		return 0;
	}

	if(!isdefined(self.var_EE5E))
	{
		return 1;
	}

	return !self.var_EE5E;
}

//Function Number: 5
func_88AE()
{
	var_00 = self.classname;
	self.var_247C = [];
	if(!isdefined(level.var_131A0.var_116CE.var_1A03) && isdefined(level.var_131A0.var_116CE.var_1A03[var_00]))
	{
		return;
	}

	var_01 = level.var_131A0.var_116CE.var_1A03[var_00].size;
	if(isdefined(self.script_noteworthy) && self.script_noteworthy == "ai_wait_go")
	{
		thread func_19F9();
	}

	self.var_E880 = [];
	self.var_1307E = [];
	self.var_7F1A = [];
	self.var_5107 = 0;
	var_02 = level.var_131A0.var_116CE.var_1A03[var_00];
	for(var_03 = 0;var_03 < var_01;var_03++)
	{
		self.var_1307E[var_03] = 0;
		if(isdefined(self.var_EE5E) && self.var_EE5E && isdefined(var_02[var_03].var_2B10) && var_02[var_03].var_2B10)
		{
			self.var_1307E[1] = 1;
		}
	}
}

//Function Number: 6
func_ADA8(param_00)
{
	func_ADA7(param_00,1);
}

//Function Number: 7
func_8730(param_00,param_01)
{
	waittillframeend;
	param_00 setcandamage(1);
	param_00 endon("death");
	param_00.var_30 = 0;
	param_00.health = 10150;
	if(isdefined(param_00.var_EEC8))
	{
		param_00.health = param_00.health + param_00.var_EEC8;
	}

	param_00 endon("jumping_out");
	if(isdefined(param_00.var_B14F) && param_00.var_B14F)
	{
		while(isdefined(param_00.var_B14F) && param_00.var_B14F)
		{
			wait(0.05);
		}
	}

	while(param_00.health > 10000)
	{
		param_00 waittill("damage");
	}

	thread func_8732(param_00,param_01);
}

//Function Number: 8
func_8732(param_00,param_01)
{
	var_02 = gettime() + getanimlength(param_01.var_E6) * 1000;
	var_03 = param_00.angles;
	var_04 = param_00.origin;
	param_00 = func_45EE(param_00);
	[[ level.var_83D9 ]]("MOD_RIFLE_BULLET","torso_upper",var_04);
	func_538C(param_00,"weapon_");
	param_00 linkto(self);
	param_00 notsolid();
	param_00 method_82A2(param_01.var_E6);
	if(isai(param_00))
	{
		param_00 scripts\anim\shared::func_5D1A();
	}
	else
	{
		func_538C(param_00,"weapon_");
	}

	if(isdefined(param_01.var_4E00))
	{
		param_00 unlink();
		if(isdefined(param_00.var_71C8))
		{
			param_00 [[ param_00.var_71C8 ]]();
		}

		param_00 method_839A();
		wait(param_01.var_4E00);
		param_00 delete();
	}
}

//Function Number: 9
func_ADA7(param_00,param_01,param_02)
{
	if(!isdefined(param_01))
	{
		param_01 = 0;
	}

	scripts\sp\_utility::func_65DD("unloaded");
	scripts\sp\_utility::func_65DD("loaded");
	scripts\common\utility::func_22A1(param_00,::func_7A35,param_01,param_02);
}

//Function Number: 10
func_9CA7(param_00)
{
	for(var_01 = 0;var_01 < self.var_E4FB.size;var_01++)
	{
		if(self.var_E4FB[var_01] == param_00)
		{
			return 1;
		}
	}

	return 0;
}

//Function Number: 11
func_7A35(param_00,param_01,param_02)
{
	if(func_9CA7(param_00))
	{
		return;
	}

	if(!func_88D2())
	{
		return;
	}

	func_8752(param_00,self,param_01,param_02);
}

//Function Number: 12
func_88D2()
{
	if(func_131EE())
	{
		return 1;
	}
}

//Function Number: 13
func_131EE()
{
	if(level.var_131A0.var_116CE.var_1A03[self.classname].size - self.var_E880.size)
	{
		return 1;
	}

	return 0;
}

//Function Number: 14
func_8754(param_00,param_01)
{
	param_01 endon("death");
	param_01 endon("stop_loading");
	var_02 = param_00 scripts\common\utility::func_13734("long_death","death","enteredvehicle");
	if(var_02 != "enteredvehicle" && isdefined(param_00.var_72AE))
	{
		param_01.var_1307E[param_00.var_72AE] = 0;
	}

	param_01.var_E880 = scripts\common\utility::func_22A9(param_01.var_E880,param_00);
	func_13211(param_01);
}

//Function Number: 15
func_13211(param_00)
{
	if(isdefined(param_00.var_380) && isdefined(param_00.var_13212))
	{
		if(param_00.var_E4FB.size == param_00.var_13212)
		{
			param_00 scripts\sp\_utility::func_65E1("loaded");
			return;
		}

		return;
	}

	if(!param_00.var_E880.size && param_00.var_E4FB.size)
	{
		if(param_00.var_1307E[0])
		{
			param_00 scripts\sp\_utility::func_65E1("loaded");
			return;
		}

		param_00 thread func_1321F();
		return;
	}
}

//Function Number: 16
func_1321F()
{
	var_00 = self.var_E4FB;
	scripts\sp\_vehicle::func_13253();
	scripts\sp\_utility::func_65E3("unloaded");
	var_00 = scripts\sp\_utility::func_22B9(var_00);
	thread scripts\sp\_vehicle::func_1320F(var_00);
}

//Function Number: 17
func_E054(param_00)
{
	scripts\common\utility::waittill_any_3("unload","death");
	param_00 scripts\sp\_utility::func_1101B();
}

//Function Number: 18
func_8752(param_00,param_01,param_02,param_03)
{
	param_01 endon("stop_loading");
	var_04 = 1;
	if(!isdefined(param_02))
	{
		param_02 = 0;
	}

	var_05 = level.var_131A0.var_116CE.var_1A03[param_01.classname];
	if(isdefined(param_01.var_E8A8))
	{
		param_01 thread [[ param_01.var_E8A8 ]](param_00);
		return;
	}

	param_01 endon("death");
	param_00 endon("death");
	param_01.var_E880[param_01.var_E880.size] = param_00;
	thread func_8754(param_00,param_01);
	var_06 = [];
	var_07 = undefined;
	var_08 = 0;
	var_09 = 0;
	for(var_0A = 0;var_0A < var_05.size;var_0A++)
	{
		if(isdefined(var_05[var_0A].var_7F12))
		{
			var_09 = 1;
		}
	}

	if(!var_09)
	{
		param_00 notify("enteredvehicle");
		param_01 func_8739(param_00,var_04);
		return;
	}

	if(!isdefined(param_00.var_7A34))
	{
		while(param_01 method_83DD() > 1)
		{
			wait(0.05);
		}
	}

	var_0B = param_01 func_7851(param_03);
	if(isdefined(param_00.var_EEC9))
	{
		var_07 = param_01 func_131E5(param_00.var_EEC9);
	}
	else if(!param_01.var_1307E[0])
	{
		var_07 = param_01 func_131E5(0);
		if(param_02)
		{
			param_00 thread scripts\sp\_utility::func_B14F();
			thread func_E054(param_00);
		}
	}
	else if(var_0B.var_26A3.size)
	{
		var_07 = scripts\common\utility::getclosest(param_00.origin,var_0B.var_26A3);
	}
	else
	{
		var_07 = undefined;
	}

	if(!var_0B.var_26A3.size && var_0B.var_C07E.size)
	{
		param_00 notify("enteredvehicle");
		param_01 func_8739(param_00,var_04);
		return;
	}
	else if(!isdefined(var_07))
	{
		return;
	}

	var_08 = var_07.origin;
	var_0C = var_07.angles;
	param_00.var_72AE = var_07.var_1321D;
	param_01.var_1307E[var_07.var_1321D] = 1;
	param_00.var_EE2B = 1;
	param_00 notify("stop_going_to_node");
	param_00 scripts\sp\_utility::func_F3BC();
	param_00 scripts\sp\_utility::func_5504();
	param_00.var_15C = 16;
	param_00 method_82EF(var_08);
	param_00 waittill("goal");
	param_00 scripts\sp\_utility::func_61DB();
	param_00 scripts\sp\_utility::func_12BFA();
	param_00 notify("boarding_vehicle");
	var_0D = func_1F00(param_01,var_07.var_1321D);
	if(isdefined(var_0D.var_50AE))
	{
		param_00.var_50AE = var_0D.var_50AE;
		if(isdefined(var_0D.var_510B))
		{
			self.var_5107 = param_00.var_50AE;
		}
	}

	if(isdefined(var_0D.var_510B))
	{
		self.var_5107 = self.var_5107 + var_0D.var_510B;
		param_00.var_50AE = self.var_5107;
	}

	param_01 func_AD14(param_00,var_0D.var_10220,var_0D.var_10221,var_0D.var_AD46);
	param_00.var_30 = 0;
	var_0D = var_05[var_07.var_1321D];
	if(isdefined(var_07))
	{
		if(isdefined(var_0D.var_131E1))
		{
			if(isdefined(var_0D.var_131E6))
			{
				var_0E = isdefined(param_00.var_C01A);
				if(!var_0E)
				{
					param_01 method_806F(var_0D.var_131E6,0);
				}
			}

			param_01 = param_01 func_7DC5();
			param_01 thread func_F642(var_0D.var_131E1,var_0D.var_131E2);
			level thread lib_0B06::func_10CBF(param_01,"vehicle_anim_flag",undefined,undefined,var_0D.var_131E1);
		}

		if(isdefined(var_0D.var_131E4))
		{
			var_08 = param_01 gettagorigin(var_0D.var_131E4);
		}
		else
		{
			var_08 = param_01.origin;
		}

		if(isdefined(var_0D.var_131E3))
		{
			function_0178(var_0D.var_131E3,var_08);
		}

		var_0F = undefined;
		var_10 = undefined;
		if(isdefined(var_0D.var_7F13))
		{
			var_0F = [];
			var_0F[0] = var_0D.var_7F13;
			var_10 = [];
			var_10[0] = ::func_6623;
			param_01 func_AD14(param_00,var_0D.var_10220,var_0D.var_10221,var_0D.var_AD46);
		}

		param_01 func_1FC2(param_00,var_0D.var_10220,var_0D.var_7F12,var_0F,var_10);
	}

	param_00 notify("enteredvehicle");
	param_01 func_8739(param_00,var_04);
}

//Function Number: 19
func_6623()
{
	self notify("enteredvehicle");
}

//Function Number: 20
func_5BCE(param_00)
{
	if(scripts\sp\_vehicle::func_9E2C())
	{
		return;
	}

	self.var_5BC8 = param_00;
	self endon("death");
	param_00 endon("jumping_out");
	param_00 waittill("death");
	if(isdefined(self.var_131F9))
	{
		return;
	}

	self notify("driver dead");
	self.var_4DEF = 1;
	if(isdefined(self.var_8C2D) && self.var_8C2D)
	{
		self method_836E(0);
		self method_83E5(0,10);
		self waittill("reached_wait_speed");
	}

	scripts\sp\_vehicle::func_13253();
}

//Function Number: 21
func_872C(param_00,param_01)
{
	if(isai(param_00))
	{
		return param_00;
	}

	if(param_00.var_5BF2 == 1)
	{
		param_00 delete();
		return;
	}

	param_00 = lib_0B77::func_10869(param_00);
	var_02 = self.classname;
	var_03 = level.var_131A0.var_116CE.var_1A03[var_02].size;
	var_04 = func_1F00(self,param_01);
	func_AD14(param_00,var_04.var_10220,var_04.var_10221,var_04.var_AD46);
	param_00.var_131F2 = var_04.var_92CC;
	thread func_8744(param_00,param_01);
	return param_00;
}

//Function Number: 22
func_AD14(param_00,param_01,param_02,param_03)
{
	if(!isdefined(param_02))
	{
		param_02 = (0,0,0);
	}

	if(!isdefined(param_03))
	{
		param_03 = 0;
	}

	if(param_03 && !isdefined(param_00.var_ED6E))
	{
		param_00 linktoblendtotag(self,param_01,0);
		return;
	}

	param_00 linkto(self,param_01,param_02,(0,0,0));
}

//Function Number: 23
func_1F00(param_00,param_01)
{
	return level.var_131A0.var_116CE.var_1A03[param_00.classname][param_01];
}

//Function Number: 24
func_8731(param_00,param_01)
{
	param_00 waittill("death");
	if(!isdefined(self))
	{
		return;
	}

	self.var_E4FB = scripts\common\utility::func_22A9(self.var_E4FB,param_00);
	self.var_1307E[param_01] = 0;
}

//Function Number: 25
func_F8AE()
{
	if(!isdefined(level.var_131A0.var_1A04))
	{
		level.var_131A0.var_1A04 = [];
	}

	if(!isdefined(level.var_131A0.var_1A02))
	{
		level.var_131A0.var_1A02 = [];
	}

	level.var_131A0.var_1A04["idle"] = ::func_8744;
	level.var_131A0.var_1A04["unload"] = ::func_8766;
}

//Function Number: 26
func_8743(param_00,param_01)
{
	param_00.var_131F5 = 1;
	thread func_8731(param_00,param_01);
}

//Function Number: 27
func_5BC9(param_00,param_01)
{
	param_00 endon("newanim");
	self endon("death");
	param_00 endon("death");
	var_02 = func_1F00(self,param_01);
	for(;;)
	{
		if(self method_83DD() == 0)
		{
			param_00.var_131F2 = var_02.var_92D5;
		}
		else
		{
			param_00.var_131F2 = var_02.var_92D0;
		}

		wait(0.25);
	}
}

//Function Number: 28
func_8744(param_00,param_01,param_02)
{
	param_00 endon("newanim");
	if(!isdefined(param_02))
	{
		self endon("death");
	}

	param_00 endon("death");
	param_00.var_131F5 = 1;
	param_00 notify("gotime");
	if(!isdefined(param_00.var_131F2))
	{
		return;
	}

	var_03 = func_1F00(self,param_01);
	if(isdefined(var_03.var_B6BD))
	{
		return;
	}

	if(isdefined(var_03.var_92D5) && isdefined(var_03.var_92D0))
	{
		thread func_5BC9(param_00,param_01);
	}

	for(;;)
	{
		param_00 notify("idle");
		func_CDAA(param_00,var_03);
	}
}

//Function Number: 29
func_CDAA(param_00,param_01)
{
	if(isdefined(param_00.var_131F3))
	{
		func_1FC2(param_00,param_01.var_10220,param_00.var_131F3);
		return;
	}

	if(isdefined(param_01.var_92F6))
	{
		var_02 = func_DCBF(param_00,param_01.var_92F6);
		func_1FC2(param_00,param_01.var_10220,param_00.var_131F2[var_02]);
		return;
	}

	if(isdefined(param_01.var_D3E2) && isdefined(var_02.var_D0E8))
	{
		func_1FC2(param_01,var_02.var_10220,var_02.var_D0E8);
		return;
	}

	if(isdefined(var_02.var_131F2))
	{
		thread func_F642(var_02.var_131F2);
	}

	func_1FC2(param_01,var_02.var_10220,param_01.var_131F2);
}

//Function Number: 30
func_DCBF(param_00,param_01)
{
	var_02 = [];
	var_03 = 0;
	for(var_04 = 0;var_04 < param_01.size;var_04++)
	{
		var_03 = var_03 + param_01[var_04];
		var_02[var_04] = var_03;
	}

	var_05 = randomint(var_03);
	for(var_04 = 0;var_04 < param_01.size;var_04++)
	{
		if(var_05 < var_02[var_04])
		{
			return var_04;
		}
	}
}

//Function Number: 31
func_876A(param_00)
{
	self endon("death");
	self.var_12BD0 = scripts\common\utility::array_add(self.var_12BD0,param_00);
	param_00 scripts\common\utility::waittill_any_3("death","jumpedout");
	self.var_12BD0 = scripts\common\utility::func_22A9(self.var_12BD0,param_00);
	if(!self.var_12BD0.size)
	{
		scripts\sp\_utility::func_65E1("unloaded");
		self.var_12BBC = "default";
	}
}

//Function Number: 32
func_E4FC(param_00)
{
	if(!self.var_E4FB.size)
	{
		return 0;
	}

	for(var_01 = 0;var_01 < self.var_E4FB.size;var_01++)
	{
		if(!isalive(self.var_E4FB[var_01]) && !isdefined(self.var_E4FB[var_01].var_9FEF))
		{
			continue;
		}

		if(func_3DD9(self.var_E4FB[var_01].var_1321D,param_00))
		{
			return 1;
		}
	}

	return 0;
}

//Function Number: 33
func_7D2F()
{
	var_00 = [];
	var_01 = [];
	var_02 = "default";
	if(isdefined(self.var_12BBC))
	{
		var_02 = self.var_12BBC;
	}

	var_01 = level.var_131A0.var_116CE.var_12BCF[self.classname][var_02];
	if(!isdefined(var_01))
	{
		var_01 = level.var_131A0.var_116CE.var_12BCF[self.classname]["default"];
	}

	foreach(var_04 in var_01)
	{
		var_00[var_04] = var_04;
	}

	return var_00;
}

//Function Number: 34
func_3DD9(param_00,param_01)
{
	if(!isdefined(param_01))
	{
		param_01 = self.var_12BBC;
	}

	var_02 = self.classname;
	if(!isdefined(level.var_131A0.var_116CE.var_12BCF[var_02]))
	{
		return 1;
	}

	if(!isdefined(level.var_131A0.var_116CE.var_12BCF[var_02][param_01]))
	{
		return 1;
	}

	var_03 = level.var_131A0.var_116CE.var_12BCF[var_02][param_01];
	for(var_04 = 0;var_04 < var_03.size;var_04++)
	{
		if(param_00 == var_03[var_04])
		{
			return 1;
		}
	}

	return 0;
}

//Function Number: 35
func_8038(param_00,param_01,param_02)
{
	self endon("unloading");
	func_1FC2(param_00,param_01,param_02);
}

//Function Number: 36
func_8037(param_00,param_01,param_02,param_03,param_04)
{
	var_05 = self.classname;
	if(param_04)
	{
		thread func_8038(param_01,param_02,level.var_131A0.var_116CE.var_247D[var_05][param_00.var_6B9D].var_92F3);
		self waittill("unloading");
	}

	self.var_12BD0 = scripts\common\utility::array_add(self.var_12BD0,param_01);
	thread func_8034(param_01,param_02,param_03);
	if(!isdefined(self.var_4828))
	{
		func_1FC2(param_01,param_02,param_03);
	}

	param_01 unlink();
	if(!isdefined(self))
	{
		param_01 delete();
		return;
	}

	self.var_12BD0 = scripts\common\utility::func_22A9(self.var_12BD0,param_01);
	if(!self.var_12BD0.size)
	{
		self notify("unloaded");
	}

	self.var_6B9D[param_00.var_6B9D] = undefined;
	wait(10);
	param_01 delete();
}

//Function Number: 37
func_8036()
{
	wait(0.05);
	while(isalive(self) && self.var_12BD0.size > 2)
	{
		wait(0.05);
	}

	if(!isalive(self) || isdefined(self.var_4828) && self.var_4828)
	{
		return;
	}

	self notify("getoutrig_disable_abort");
}

//Function Number: 38
func_8035()
{
	self endon("end_getoutrig_abort_while_deploying");
	while(!isdefined(self.var_4828))
	{
		wait(0.05);
	}

	var_00 = [];
	foreach(var_02 in self.var_E4FB)
	{
		if(isalive(var_02))
		{
			scripts\common\utility::array_add_safe(var_00,var_02);
		}
	}

	scripts\sp\_utility::func_228A(var_00);
	self notify("crashed_while_deploying");
	var_00 = undefined;
}

//Function Number: 39
func_8034(param_00,param_01,param_02)
{
	var_03 = getanimlength(param_02);
	var_04 = var_03 - 1;
	if(self.var_380 == "mi17")
	{
		var_04 = var_03 - 0.5;
	}

	var_05 = 2.5;
	self endon("getoutrig_disable_abort");
	thread func_8036();
	thread func_8035();
	scripts\common\utility::waittill_notify_or_timeout("crashed_while_deploying",var_05);
	self notify("end_getoutrig_abort_while_deploying");
	while(!isdefined(self.var_4828))
	{
		wait(0.05);
	}

	thread func_1FC2(param_00,param_01,param_02);
	waittillframeend;
	param_00 method_82B0(param_02,var_04 / var_03);
	var_06 = self;
	if(isdefined(self.var_C720))
	{
		var_06 = self.var_C720;
	}

	for(var_07 = 0;var_07 < self.var_E4FB.size;var_07++)
	{
		if(!isdefined(self.var_E4FB[var_07]))
		{
			continue;
		}

		if(!isdefined(self.var_E4FB[var_07].var_DC19))
		{
			continue;
		}

		if(self.var_E4FB[var_07].var_DC19 != 1)
		{
			continue;
		}

		if(!isdefined(self.var_E4FB[var_07].var_E500))
		{
			continue;
		}

		self.var_E4FB[var_07].var_72C4 = 1;
		if(isalive(self.var_E4FB[var_07]))
		{
			thread func_1FC4(self.var_E4FB[var_07],self,var_06);
		}
	}
}

//Function Number: 40
func_F642(param_00,param_01)
{
	self endon("death");
	self endon("dont_clear_anim");
	if(!isdefined(param_01))
	{
		param_01 = 1;
	}

	var_02 = getanimlength(param_00);
	self endon("death");
	self method_82EA("vehicle_anim_flag",param_00);
	wait(var_02);
	if(param_01)
	{
		self method_806F(param_00,0);
	}
}

//Function Number: 41
func_802F(param_00,param_01,param_02)
{
	if(!isdefined(param_02))
	{
		param_02 = 1;
	}

	var_03 = self.classname;
	var_04 = func_1F00(self,param_01);
	if(isdefined(self.var_2465) && isdefined(self.var_2465[var_04.var_6B9D]))
	{
		var_05 = 1;
	}
	else
	{
		var_05 = 0;
	}

	if(!isdefined(var_04.var_6B9D) || isdefined(self.var_6B9D[var_04.var_6B9D]) || var_05)
	{
		return;
	}

	var_06 = param_00 gettagorigin(level.var_131A0.var_116CE.var_247D[var_03][var_04.var_6B9D].var_2DD);
	var_07 = param_00 gettagangles(level.var_131A0.var_116CE.var_247D[var_03][var_04.var_6B9D].var_2DD);
	self.var_6B9E[var_04.var_6B9D] = 1;
	var_08 = spawn("script_model",var_06);
	var_08.angles = var_07;
	var_08.origin = var_06;
	var_08 setmodel(level.var_131A0.var_116CE.var_247D[var_03][var_04.var_6B9D].model);
	self.var_6B9D[var_04.var_6B9D] = var_08;
	var_08 method_83D0(#animtree);
	var_08 linkto(param_00,level.var_131A0.var_116CE.var_247D[var_03][var_04.var_6B9D].var_2DD,(0,0,0),(0,0,0));
	thread func_8037(var_04,var_08,level.var_131A0.var_116CE.var_247D[var_03][var_04.var_6B9D].var_2DD,level.var_131A0.var_116CE.var_247D[var_03][var_04.var_6B9D].var_5D1B,param_02);
	return var_08;
}

//Function Number: 42
func_3DCC(param_00)
{
	if(!isdefined(self.var_10471))
	{
		self.var_10471 = [];
	}

	var_01 = 0;
	if(!isdefined(self.var_10471[param_00]))
	{
		self.var_10471[param_00] = 1;
	}
	else
	{
		var_01 = 1;
	}

	thread func_3DCD(param_00);
	return var_01;
}

//Function Number: 43
func_3DCD(param_00)
{
	wait(0.05);
	if(!isdefined(self))
	{
		return;
	}

	self.var_10471[param_00] = 0;
	var_01 = getarraykeys(self.var_10471);
	for(var_02 = 0;var_02 < var_01.size;var_02++)
	{
		if(self.var_10471[var_01[var_02]])
		{
			return;
		}
	}

	self.var_10471 = undefined;
}

//Function Number: 44
func_8766(param_00,param_01)
{
	var_02 = 0;
	if(isdefined(param_00.var_9FEF))
	{
		var_02 = 1;
	}

	var_03 = func_1F00(self,param_01);
	var_04 = self.var_380;
	if(!func_3DD9(param_01))
	{
		thread func_8744(param_00,param_01);
		return;
	}

	if(!isdefined(var_03.var_8028))
	{
		thread func_8744(param_00,param_01);
		return;
	}

	thread func_876A(param_00);
	self endon("death");
	if(isai(param_00) && isalive(param_00))
	{
		param_00 endon("death");
	}

	var_05 = 0;
	if(isdefined(param_00.var_8020))
	{
		var_06 = param_00 [[ param_00.var_8020 ]]();
		if(isdefined(var_06) && var_06)
		{
			var_05 = 1;
		}
	}

	if(isdefined(param_00.var_C584))
	{
		param_00.var_C584 = undefined;
		if(isdefined(param_00.var_8020))
		{
			param_00 [[ param_00.var_8020 ]]();
		}
	}

	var_07 = func_7DC5();
	if(isdefined(var_03.var_131E6))
	{
		var_07 thread func_F642(var_03.var_131E6,var_03.var_131E7);
		var_08 = 0;
		if(isdefined(var_03.var_131E9))
		{
			var_08 = func_3DCC(var_03.var_131E9);
			var_09 = var_07 gettagorigin(var_03.var_131E9);
		}
		else
		{
			var_09 = var_08.origin;
		}

		if(isdefined(var_03.var_131E8) && !var_08)
		{
			function_0178(var_03.var_131E8,var_09);
		}

		var_08 = undefined;
	}

	var_0A = 0;
	if(isdefined(var_03.var_8032))
	{
		var_0A = var_0A + getanimlength(var_03.var_8032);
	}

	if(isdefined(var_03.var_50AE))
	{
		var_0A = var_0A + var_03.var_50AE;
	}

	if(isdefined(param_00.var_50AE))
	{
		var_0A = var_0A + param_00.var_50AE;
	}

	if(var_0A > 0)
	{
		thread func_8744(param_00,param_01);
		wait(var_0A);
	}

	param_00.var_4E2A = undefined;
	param_00.var_4E2E = undefined;
	param_00 notify("newanim");
	if(isdefined(var_03.var_2AB6) && !var_03.var_2AB6)
	{
		if(!isdefined(param_00.var_5531))
		{
			param_00 scripts\sp\_utility::func_86E2();
		}
	}

	if(isai(param_00))
	{
		param_00 method_8250(1);
	}

	if(isdefined(var_03.var_2BE8))
	{
		var_05 = 1;
	}
	else if(!isdefined(var_03.var_8028) || !isdefined(self.var_EEFD) && isdefined(var_03.var_2B10) && var_03.var_2B10 || isdefined(self.var_EDF4) && param_01 == 0)
	{
		thread func_8744(param_00,param_01);
		return;
	}

	if(param_00 func_FF4D())
	{
		param_00.health = param_00.var_C6F8;
	}

	param_00.var_C6F8 = undefined;
	if(isai(param_00) && isalive(param_00))
	{
		param_00 endon("death");
	}

	param_00.var_30 = 0;
	if(isdefined(var_03.var_6981))
	{
		var_0B = var_03.var_6981;
	}
	else
	{
		var_0B = var_04.var_10220;
	}

	if(isdefined(param_00.var_7B54))
	{
		var_0C = param_00.var_7B54;
	}
	else if(scripts\sp\_utility::func_65DB("landed") && isdefined(var_04.var_802E))
	{
		var_0C = var_04.var_802E;
	}
	else if(isdefined(param_01.var_D3E2) && isdefined(var_04.var_D098))
	{
		var_0C = var_04.var_D098;
	}
	else
	{
		var_0C = var_04.var_8028;
	}

	if(!var_05)
	{
		thread func_8765(param_00);
		if(isdefined(var_03.var_6B9D))
		{
			if(!isdefined(self.var_6B9D[var_03.var_6B9D]))
			{
				thread func_8744(param_00,param_01);
				var_0D = func_802F(var_07,param_00.var_1321D,0);
			}
		}

		if(isdefined(var_03.var_8039))
		{
			param_00 thread scripts\sp\_utility::play_sound_on_tag(var_03.var_8039,"J_Wrist_RI",1);
		}

		if(isdefined(param_00.var_D3E2) && isdefined(var_03.var_D099))
		{
			param_00 thread scripts\sp\_utility::func_CE2F(var_03.var_D099);
		}

		if(isdefined(var_03.var_8033))
		{
			param_00 thread scripts\sp\_utility::func_CD81(var_03.var_8033);
		}

		if(isdefined(param_00.var_D3E2) && isdefined(var_03.var_D09B))
		{
			level.player thread scripts\common\utility::func_CD7F(var_03.var_D09B);
		}

		param_00 notify("newanim");
		param_00 notify("jumping_out");
		var_0E = 0;
		if(!isai(param_00) && !var_02)
		{
			var_0E = 1;
		}

		if(!isdefined(param_00.var_EECD) && !var_02)
		{
			param_00 = func_872C(param_00,param_01);
		}

		if(!isalive(param_00) && !var_02)
		{
			return;
		}

		if(!var_02)
		{
			param_00.var_DC19 = 1;
		}

		if(isdefined(var_03.var_DC19))
		{
			param_00.var_DC19 = 1;
			if(isdefined(var_03.var_DC17))
			{
				param_00.var_DC17 = var_03.var_DC17;
			}
		}

		if(var_0E)
		{
			self.var_E4FB = scripts\common\utility::array_add(self.var_E4FB,param_00);
			thread func_8731(param_00,param_01);
			thread func_876A(param_00);
			param_00.var_E500 = self;
		}

		if(isai(param_00))
		{
			param_00 endon("death");
		}

		param_00 notify("newanim");
		param_00 notify("jumping_out");
		if(isdefined(var_03.var_AD88) && var_03.var_AD88)
		{
			thread func_10B38(param_00);
		}

		if(isdefined(var_03.var_8030))
		{
			func_1FC2(param_00,var_0B,var_0C);
			var_0F = var_0B;
			if(isdefined(var_03.var_8031))
			{
				var_0F = var_03.var_8031;
			}

			func_1FC2(param_00,var_0F,var_03.var_8030);
		}
		else
		{
			var_10 = 0;
			if(isdefined(var_03.var_802D) && isdefined(var_03.var_802C))
			{
				thread func_8767(param_00,var_0B,var_03.var_8028,var_03.var_802D,var_03.var_802C);
				var_10 = 1;
			}
			else if(!var_02)
			{
				param_00.var_1EB4 = 1;
			}

			func_1FC2(param_00,var_0B,var_0C);
			if(var_10)
			{
				param_00 waittill("hoverunload_done");
			}
		}

		if(isdefined(param_00.var_D3E2) && isdefined(var_03.var_D09B))
		{
			level.player thread scripts\common\utility::func_11018(var_03.var_D09B);
		}

		if(isdefined(var_03.var_8033))
		{
			param_00 thread scripts\common\utility::func_11018(var_03.var_8033);
		}

		if(isdefined(param_00.var_D3E2) && isdefined(var_03.var_D09A))
		{
			level.player thread scripts\sp\_utility::func_CE2F(var_03.var_D09A);
		}
	}
	else if(!isai(param_00))
	{
		if(param_00.var_5BF2 == 1)
		{
			param_00 delete();
			return;
		}

		param_00 = lib_0B77::func_10869(param_00);
	}

	self.var_E4FB = scripts\common\utility::func_22A9(self.var_E4FB,param_00);
	self.var_1307E[param_01] = 0;
	param_00.var_E500 = undefined;
	param_00.var_5BD6 = undefined;
	if(!isalive(self) && !isdefined(var_03.var_12BC8))
	{
		param_00 delete();
		return;
	}

	param_00 unlink();
	if(!isdefined(param_00.var_B14F))
	{
		param_00.var_30 = 1;
	}

	if(isalive(param_00) || var_02)
	{
		if(isai(param_00))
		{
			param_00.var_1491.var_55FC = !param_00 method_8198();
		}

		param_00.var_72AE = undefined;
		param_00 notify("jumpedout");
		if(isai(param_00))
		{
			if(isdefined(var_03.var_803A))
			{
				param_00.var_5270 = var_03.var_803A;
				param_00 method_800B("crouch");
				param_00 thread scripts\anim\utility::func_12E5F();
				param_00 method_800B("stand","crouch","prone");
			}

			param_00 method_8250(0);
			if(func_8750(param_00))
			{
				param_00.var_15C = 600;
				param_00 method_82EF(param_00.origin);
			}
		}
		else if(var_02)
		{
			param_00.var_1356F.origin = param_00.origin;
			param_00.var_1356F.angles = param_00.angles;
			if(isdefined(param_00.var_1356F.target))
			{
				param_00.var_1356F scripts\sp\_vehicle::func_1080B();
			}
			else
			{
				var_11 = param_00.var_1356F scripts\sp\_utility::func_10808();
			}

			param_00 delete();
		}
	}

	if(isdefined(param_00.script_noteworthy) && param_00.script_noteworthy == "delete_after_unload")
	{
		param_00 delete();
		return;
	}

	if(isdefined(var_03.var_802A) && var_03.var_802A)
	{
		param_00 delete();
		return;
	}

	param_00 func_872E();
}

//Function Number: 45
func_8767(param_00,param_01,param_02,param_03,param_04)
{
	var_05 = self gettagorigin(param_01);
	var_06 = self gettagangles(param_01);
	var_07 = function_00CE(var_05,var_06,param_02);
	var_08 = function_00CD(var_05,var_06,param_02);
	var_09 = getmovedelta(param_02,0,1);
	var_0A = scripts\common\utility::spawn_tag_origin();
	var_0A.origin = var_07;
	var_0A.angles = var_08;
	var_0B = var_0A method_81E7(var_09);
	var_0A thread scripts\sp\_utility::func_5184("movedone");
	var_0C = var_0B;
	var_0D = scripts\sp\_utility::func_864C(var_0C);
	var_0E = function_00CE(var_05,var_06,param_04);
	var_09 = getmovedelta(param_04,0,1);
	var_0F = var_0E + var_09;
	var_10 = var_0E[2] - var_0F[2];
	var_11 = var_0D + (0,0,var_10);
	param_00 scripts\sp\_utility::func_F2A8(0);
	param_00 setcandamage(0);
	param_00 endon("death");
	wait(getanimlength(param_02) - 0.1);
	param_00 unlink();
	param_00 notify("animontag_thread");
	param_00 method_83A1();
	var_0A.origin = param_00.origin;
	var_0A.angles = param_00.angles;
	var_0A dontinterpolate();
	param_00 dontinterpolate();
	param_00 linkto(var_0A,"tag_origin",(0,0,0),(0,0,0));
	param_00 scripts\sp\_utility::func_F2A8(1);
	param_00 setcandamage(1);
	param_00.var_12BC4 = param_03;
	if(isai(param_00))
	{
		param_00 lib_0A1E::func_2307(::func_873D,::func_873E);
	}
	else
	{
		param_00 thread func_873D();
	}

	var_12 = length((0,0,var_11[2]) - (0,0,var_0C[2]));
	var_13 = 350;
	var_14 = var_12 / var_13;
	var_0A moveto(var_11,var_14);
	var_0A waittill("movedone");
	param_00 unlink();
	param_00 method_8018("dropship_land",param_00.origin,param_00.angles,param_04);
	wait(getanimlength(param_04));
	param_00 notify("hoverunload_done");
	param_00 notify("anim_on_tag_done");
}

//Function Number: 46
func_873D()
{
	if(isai(self))
	{
		if(scripts\common\utility::func_167E())
		{
			self method_8221("face angle 3d",self.angles);
		}
		else
		{
			self method_8221("face angle",self.angles[1]);
		}

		self method_806F(lib_0A1E::func_2339(),0.2);
	}

	self method_82A2(self.var_12BC4,1);
	self waittill("dropship_land");
}

//Function Number: 47
func_873E()
{
}

//Function Number: 48
func_8750(param_00)
{
	if(isdefined(param_00.var_ED53))
	{
		return 0;
	}

	if(param_00 scripts\sp\_utility::func_8B6C())
	{
		return 0;
	}

	if(isdefined(param_00.var_DB41))
	{
		return 0;
	}

	if(!isdefined(param_00.target))
	{
		return 1;
	}

	var_01 = function_00B4(param_00.target,"targetname");
	var_02 = scripts\common\utility::getstructarray(param_00.target,"targetname");
	if(var_01.size > 0 || var_02.size > 0)
	{
		return 0;
	}

	var_03 = getent(param_00.target,"targetname");
	if(isdefined(var_03) && var_03.classname == "info_volume")
	{
		return 0;
	}

	return 1;
}

//Function Number: 49
func_1FC2(param_00,param_01,param_02,param_03,param_04,param_05)
{
	param_00 notify("animontag_thread");
	param_00 endon("animontag_thread");
	if(!isdefined(param_05))
	{
		param_05 = "animontagdone";
	}

	if(isdefined(self.var_B91E))
	{
		var_06 = self.var_B91E;
	}
	else
	{
		var_06 = self;
	}

	if(!isdefined(param_01))
	{
		var_07 = param_00.origin;
		var_08 = param_00.angles;
	}
	else
	{
		var_07 = var_08 gettagorigin(param_03);
		var_08 = var_07 gettagangles(param_02);
	}

	if(isdefined(param_00.var_DC19) && !isdefined(param_00.var_C01B))
	{
		level thread func_1FC3(param_00,self);
	}

	param_00 method_8018(param_05,var_07,var_08,param_02);
	if(isai(param_00))
	{
		thread func_592B(param_00,var_06,param_05);
	}

	if(isdefined(param_00.var_1EB4))
	{
		param_00.var_1EB4 = undefined;
		var_09 = getanimlength(param_02) - 0.25;
		if(var_09 > 0)
		{
			wait(var_09);
		}

		if(getdvarint("ai_iw7",0) == 1)
		{
			param_00 lib_0A1E::func_2386();
		}

		param_00.var_190 = 0;
		param_00 thread func_DDFA();
	}
	else
	{
		if(isdefined(param_03))
		{
			for(var_0A = 0;var_0A < param_03.size;var_0A++)
			{
				param_00 waittillmatch(param_03[var_0A],param_05);
				param_00 thread [[ param_04[var_0A] ]]();
			}
		}

		param_00 waittillmatch("end",param_05);
	}

	param_00 notify("anim_on_tag_done");
	param_00.var_DC19 = undefined;
}

//Function Number: 50
func_DDFA()
{
	self endon("death");
	wait(2);
	if(self.var_190 == 0)
	{
		self.var_190 = 80;
	}
}

//Function Number: 51
func_1FC3(param_00,param_01)
{
	if(isdefined(param_00.var_B14F) && param_00.var_B14F)
	{
		return;
	}

	if(!isai(param_00))
	{
		param_00 setcandamage(1);
	}

	param_00 endon("anim_on_tag_done");
	var_02 = undefined;
	var_03 = undefined;
	var_04 = param_01.health <= 0;
	for(;;)
	{
		if(!var_04 && !isdefined(param_01) && param_01.health > 0)
		{
			break;
		}

		param_00 waittill("damage",var_02,var_03);
		if(isdefined(param_00.var_72C4))
		{
			break;
		}

		if(!isdefined(var_02))
		{
			continue;
		}

		if(var_02 < 1)
		{
			continue;
		}

		if(!isdefined(var_03))
		{
			continue;
		}

		if(isplayer(var_03))
		{
			break;
		}
	}

	if(!isalive(param_00))
	{
		return;
	}

	thread func_1FC4(param_00,param_01,var_03);
}

//Function Number: 52
func_1FC4(param_00,param_01,param_02)
{
	param_00.var_4E2A = undefined;
	param_00.var_4E46 = undefined;
	param_00.var_1EB2 = 1;
	if(isdefined(param_00.var_DC17))
	{
		var_03 = getmovedelta(param_00.var_DC17,0,1);
		var_04 = physicstrace(param_00.origin + (0,0,16),param_00.origin - (0,0,10000));
		var_05 = distance(param_00.origin + (0,0,16),var_04);
		if(abs(var_03[2] + 16) <= abs(var_05))
		{
			param_00 thread scripts\sp\_utility::func_CE2F("generic_death_falling");
			param_00 method_8018("fastrope_fall",param_00.origin,param_00.angles,param_00.var_DC17);
			param_00 waittillmatch("start_ragdoll","fastrope_fall");
		}
	}

	if(!isdefined(param_00))
	{
		return;
	}

	param_00.var_4E2A = undefined;
	param_00.var_4E46 = undefined;
	param_00.var_1EB2 = 1;
	param_00 notify("rope_death",param_02);
	param_00 method_81D0(param_02.origin,param_02);
	if(isdefined(param_00.var_EECD))
	{
		param_00 notsolid();
		var_06 = function_00EA(param_00.var_394);
		var_07 = param_00.var_394;
		if(isdefined(var_06))
		{
			param_00 detach(var_06,"tag_weapon_right");
			var_08 = param_00 gettagorigin("tag_weapon_right");
			var_09 = param_00 gettagangles("tag_weapon_right");
			level.var_86C1 = spawn("weapon_" + var_07,(0,0,0));
			level.var_86C1.angles = var_09;
			level.var_86C1.origin = var_08;
		}
	}
	else
	{
		param_00 scripts\anim\shared::func_5D1A();
	}

	if(isdefined(param_00.var_71C8))
	{
		param_00 [[ param_00.var_71C8 ]]();
	}

	param_00 method_839A();
}

//Function Number: 53
func_592B(param_00,param_01,param_02)
{
	param_00 endon("newanim");
	param_01 endon("death");
	param_00 endon("death");
	param_00 scripts\anim\shared::func_592B(param_02);
}

//Function Number: 54
func_1F9D(param_00,param_01,param_02,param_03)
{
	param_00 method_8018("movetospot",param_01,param_02,param_03);
	param_00 waittillmatch("end","movetospot");
}

//Function Number: 55
func_876B(param_00,param_01,param_02)
{
	if(!isalive(param_00))
	{
		return;
	}

	if(isdefined(self.var_C011))
	{
		return;
	}

	var_03 = func_1F00(self,param_00.var_1321D);
	param_00.var_131AE = param_01;
	if(isdefined(var_03.var_69DF))
	{
		return func_872D(param_00);
	}

	if(isdefined(level.var_131A0.var_116CE.var_E4F9) && isdefined(level.var_131A0.var_116CE.var_E4F9[self.classname]))
	{
		self [[ level.var_131A0.var_116CE.var_E4F9[self.classname] ]]();
		return;
	}

	if(isdefined(var_03.var_12BC8) && isdefined(self))
	{
		if(isdefined(self.var_5970) && self.var_5970)
		{
			return;
		}

		thread func_8744(param_00,param_00.var_1321D,1);
		wait(var_03.var_12BC8);
		if(isdefined(param_00) && isdefined(self))
		{
			self.var_86A1 = param_00.var_1321D;
			func_1F74("unload");
		}

		return;
	}

	if(isdefined(param_00))
	{
		if(isdefined(param_00.var_DC19) && param_02 != "bm21_troops")
		{
			return;
		}

		[[ level.var_83D9 ]]("MOD_RIFLE_BULLET","torso_upper",param_00.origin);
		if(param_02 == "bm21_troops")
		{
			param_00.var_30 = 1;
			param_00 method_81D0();
			return;
		}

		param_00 delete();
	}
}

//Function Number: 56
func_19F9()
{
	self endon("death");
	self waittill("loaded");
	lib_0B98::func_845A(self);
}

//Function Number: 57
func_F554(param_00,param_01)
{
	var_02 = param_00.var_EEC9;
	if(isdefined(param_00.var_72AE))
	{
		var_02 = param_00.var_72AE;
	}

	if(isdefined(var_02))
	{
		return var_02;
	}

	for(var_03 = 0;var_03 < self.var_1307E.size;var_03++)
	{
		if(self.var_1307E[var_03])
		{
			continue;
		}

		if(isdefined(param_00.var_9FEF) && !isdefined(param_01[var_03].var_9FEF))
		{
			continue;
		}

		if(!isdefined(param_00.var_9FEF) && isdefined(param_01[var_03].var_9FEF))
		{
			continue;
		}

		return var_03;
	}

	if(param_00.var_9FEF)
	{
	}
}

//Function Number: 58
func_874C(param_00,param_01,param_02)
{
	var_03 = func_1F00(self,param_01);
	var_04 = self.var_B6BD[var_03.var_B6BD];
	if(!isalive(param_00))
	{
		return;
	}

	var_04 endon("death");
	param_00 endon("death");
	if(isdefined(param_02) && param_02 && isdefined(var_03.var_C939))
	{
		[[ var_03.var_C939 ]](self,param_00,param_01,var_04);
	}

	scripts\sp\_vehicle_code::func_F5D8(var_04);
	var_04 method_82D1(0);
	wait(0.1);
	param_00 endon("guy_man_turret_stop");
	level thread scripts\sp\_mgturret::func_B6A7(var_04,scripts\sp\_utility::func_7E72());
	var_04 method_8359(1);
	var_05 = "stand";
	if(isdefined(var_03.var_12A80))
	{
		var_05 = var_03.var_12A80;
	}

	param_00 scripts\sp\_utility::func_13035(var_04,var_05);
}

//Function Number: 59
func_8765(param_00)
{
	param_00 endon("jumpedout");
	param_00 waittill("death");
	if(isdefined(param_00))
	{
		param_00 unlink();
	}
}

//Function Number: 60
func_872D(param_00)
{
	if(!isdefined(param_00.var_1321D))
	{
		return;
	}

	var_01 = param_00.var_1321D;
	var_02 = func_1F00(self,var_01);
	if(!isdefined(var_02.var_69DF))
	{
		return;
	}

	[[ level.var_83D9 ]]("MOD_RIFLE_BULLET","torso_upper",param_00.origin);
	param_00.var_4E2A = var_02.var_69DF;
	var_03 = self.angles;
	var_04 = param_00.origin;
	if(isdefined(var_02.var_69E0))
	{
		var_04 = var_04 + anglestoforward(var_03) * var_02.var_69E0[0];
		var_04 = var_04 + anglestoright(var_03) * var_02.var_69E0[1];
		var_04 = var_04 + anglestoup(var_03) * var_02.var_69E0[2];
	}

	param_00 = func_45EE(param_00);
	func_538C(param_00,"weapon_");
	param_00 notsolid();
	param_00.origin = var_04;
	param_00.angles = var_03;
	param_00 method_8018("deathanim",var_04,var_03,var_02.var_69DF);
	var_05 = 0.3;
	if(isdefined(var_02.var_69E1))
	{
		var_05 = var_02.var_69E1;
	}

	var_06 = getanimlength(var_02.var_69DF);
	var_07 = gettime() + var_06 * 1000;
	wait(var_06 * var_05);
	var_08 = (0,0,1);
	var_09 = param_00.origin;
	if(getdvar("ragdoll_enable") == "0")
	{
		param_00 delete();
		return;
	}

	if(isai(param_00))
	{
		param_00 scripts\anim\shared::func_5D1A();
	}
	else
	{
		func_538C(param_00,"weapon_");
	}

	while(!param_00 method_81B7() && gettime() < var_07)
	{
		var_09 = param_00.origin;
		wait(0.05);
		var_08 = param_00.origin - var_09;
		if(isdefined(param_00.var_71C8))
		{
			param_00 [[ param_00.var_71C8 ]]();
		}

		param_00 method_839A();
	}

	wait(0.05);
	var_08 = var_08 * 20000;
	for(var_0A = 0;var_0A < 3;var_0A++)
	{
		if(isdefined(param_00))
		{
			var_09 = param_00.origin;
		}

		wait(0.05);
	}

	if(!param_00 method_81B7())
	{
		param_00 delete();
	}
}

//Function Number: 61
func_45EE(param_00,param_01)
{
	if(!isdefined(param_01))
	{
		param_01 = 0;
	}

	var_02 = spawn("script_model",param_00.origin);
	var_02.angles = param_00.angles;
	var_02 setmodel(param_00.model);
	var_03 = param_00 method_8108();
	for(var_04 = 0;var_04 < var_03;var_04++)
	{
		var_02 attach(param_00 method_8106(var_04),param_00 method_8109(var_04));
	}

	var_02 method_83D0(#animtree);
	if(isdefined(param_00.team))
	{
		var_02.team = param_00.team;
	}

	if(!param_01)
	{
		param_00 delete();
	}

	var_02 method_81F2();
	return var_02;
}

//Function Number: 62
func_131A9(param_00,param_01)
{
	self method_83D0(param_01);
	self method_82A2(param_00);
}

//Function Number: 63
func_131E5(param_00)
{
	var_01 = func_1F00(self,param_00);
	return func_131E0(var_01.var_7F12,var_01.var_10220,param_00);
}

//Function Number: 64
func_131E0(param_00,param_01,param_02)
{
	var_03 = spawnstruct();
	var_04 = undefined;
	var_05 = undefined;
	var_06 = self gettagorigin(param_01);
	var_07 = self gettagangles(param_01);
	var_04 = function_00CE(var_06,var_07,param_00);
	var_05 = function_00CD(var_06,var_07,param_00);
	var_03.origin = var_04;
	var_03.angles = var_05;
	var_03.var_1321D = param_02;
	return var_03;
}

//Function Number: 65
func_9C8A(param_00,param_01,param_02)
{
	if(!isdefined(param_02))
	{
		return 1;
	}

	var_03 = param_00.classname;
	var_04 = level.var_131A0.var_116CE.var_12BCF[var_03][param_02];
	foreach(var_06 in var_04)
	{
		if(var_06 == param_01)
		{
			return 1;
		}
	}

	return 0;
}

//Function Number: 66
func_7851(param_00)
{
	var_01 = level.var_131A0.var_116CE.var_1A03[self.classname];
	var_02 = [];
	var_03 = [];
	for(var_04 = 0;var_04 < self.var_1307E.size;var_04++)
	{
		if(self.var_1307E[var_04])
		{
			continue;
		}

		if(isdefined(var_01[var_04].var_7F12) && func_9C8A(self,var_04,param_00))
		{
			var_02[var_02.size] = func_131E5(var_04);
			continue;
		}

		var_03[var_03.size] = var_04;
	}

	var_05 = spawnstruct();
	var_05.var_26A3 = var_02;
	var_05.var_C07E = var_03;
	return var_05;
}

//Function Number: 67
func_7DC5()
{
	if(isdefined(self.var_B91E))
	{
		return self.var_B91E;
	}

	return self;
}

//Function Number: 68
func_538C(param_00,param_01)
{
	var_02 = param_00 method_8108();
	var_03 = [];
	var_04 = [];
	var_05 = 0;
	for(var_06 = 0;var_06 < var_02;var_06++)
	{
		var_07 = param_00 method_8106(var_06);
		var_08 = param_00 method_8109(var_06);
		if(issubstr(var_07,param_01))
		{
			var_03[var_05] = var_07;
			var_04[var_05] = var_08;
		}
	}

	for(var_06 = 0;var_06 < var_03.size;var_06++)
	{
		param_00 detach(var_03[var_06],var_04[var_06]);
	}
}

//Function Number: 69
func_FF4D()
{
	if(!isai(self))
	{
		return 0;
	}

	if(!isdefined(self.var_C6F8))
	{
		return 0;
	}

	return !isdefined(self.var_B14F);
}

//Function Number: 70
func_10B38(param_00)
{
	self waittill("stable_for_unlink");
	if(isalive(param_00))
	{
		param_00 unlink();
	}
}

//Function Number: 71
func_1F74(param_00)
{
	var_01 = [];
	foreach(var_03 in self.var_E4FB)
	{
		if(isai(var_03) && !isalive(var_03))
		{
			continue;
		}

		if(isdefined(level.var_131A0.var_1A02[param_00]) && ![[ level.var_131A0.var_1A02[param_00] ]](var_03,var_03.var_1321D))
		{
			continue;
		}

		if(isdefined(level.var_131A0.var_1A04[param_00]))
		{
			var_03 notify("newanim");
			var_03.var_DB8E = [];
			thread [[ level.var_131A0.var_1A04[param_00] ]](var_03,var_03.var_1321D);
			var_01[var_01.size] = var_03;
			continue;
		}
	}

	return var_01;
}

//Function Number: 72
func_872E()
{
	self.var_131F5 = undefined;
	self.var_10B71 = undefined;
	self.var_1321D = undefined;
	self.var_50AE = undefined;
}