/*******************************************************************
 * Decompiled By: Bog
 * Decompiled File: 3906.gsc
 * Game: Call of Duty: Infinite Warfare
 * Platform: PC
 * Function Count: 13
 * Decompile Time: 4 ms
 * Timestamp: 10/27/2023 12:31:12 AM
*******************************************************************/

//Function Number: 1
func_D4DA()
{
	if(!isdefined(self.var_1491.var_BF8C))
	{
		self.var_1491.var_BF8C = 0;
	}

	if((isdefined(self.var_10C) && isplayer(self.var_10C)) || randomint(3) == 0)
	{
		if(gettime() > self.var_1491.var_BF8C)
		{
			scripts\anim\face::func_EB83("meleecharge");
			self.var_1491.var_BF8C = gettime() + 8000;
		}
	}
}

//Function Number: 2
func_D4D8()
{
	if(!isdefined(self.var_1491.var_BF8B))
	{
		self.var_1491.var_BF8B = 0;
	}

	if((isdefined(self.var_10C) && isplayer(self.var_10C)) || randomint(3) == 0)
	{
		if(gettime() > self.var_1491.var_BF8B)
		{
			scripts\anim\face::func_EB83("meleeattack");
			self.var_1491.var_BF8B = gettime() + 8000;
		}
	}
}

//Function Number: 3
func_D4D9(param_00,param_01,param_02,param_03)
{
	func_D4DA();
	lib_0A1E::func_235F(param_00,param_01,param_02,self.var_BCD6);
}

//Function Number: 4
func_D4CC(param_00,param_01,param_02,param_03)
{
	self endon(param_01 + "_finished");
	var_04 = lib_0A1E::func_2336(param_00,param_01);
	self method_806F(lib_0A1E::func_2339(),param_02);
	self method_82EA(param_01,var_04,1,param_02,1);
	lib_0A1E::func_2369(param_00,param_01,var_04);
	thread lib_0C64::func_D4CD(param_01);
	lib_0A1E::func_231F(param_00,param_01);
}

//Function Number: 5
func_D4D7(param_00,param_01,param_02,param_03)
{
	func_D4D8();
	var_04 = lib_0A1B::func_2925();
	if(!isdefined(var_04))
	{
		self method_8221("face current");
	}
	else if(var_04 == self.var_10C)
	{
		self method_8221("face enemy");
	}
	else
	{
		self method_8221("face point",var_04.origin);
	}

	var_05 = lib_0A1E::func_2336(param_00,param_01);
	lib_0A1A::func_232F("melee_attack","begin");
	self method_806F(lib_0A1E::func_2339(),param_02);
	if(isdefined(param_03))
	{
		self playsound(param_03);
	}

	self method_82EA(param_01,var_05,1,param_02,1);
	self endon(param_01 + "_finished");
	lib_0C64::func_592C(param_00,param_01);
	lib_0A1A::func_2330(param_01,"end");
}

//Function Number: 6
func_B5CB(param_00,param_01)
{
	self.var_B647 = param_00;
	self.var_B55B.var_9904 = 1;
	self.var_B55B.var_394 = self.var_394;
	self.var_B55B.var_13CCC = scripts\anim\utility::func_7E52();
	self.var_B55B.var_71D3 = ::func_B5D2;
	if(param_01)
	{
		lib_0A0E::func_B5B4(self.var_12BA4);
		self.var_2DC = self.var_B55B.target;
	}
	else
	{
		self.var_2DC = self.var_B55B.var_C92C;
	}

	if(self.var_12BA4 == "c6")
	{
		self.var_87F6 = 0;
		self.ignoreme = 1;
	}
}

//Function Number: 7
func_D4D1(param_00,param_01,param_02,param_03)
{
	self.var_B55B.var_312F = 1;
	var_04 = self.var_B55B.target;
	var_05 = self [[ self.var_7191 ]](param_00,param_01);
	lib_0A1A::func_232F("melee_attack","begin");
	func_B5CB(param_01,1);
	var_06 = getnotetracktimes(var_05,"melee_stop");
	if(var_06.size > 0)
	{
		self.var_B55B.var_11095 = var_06;
	}

	thread lib_0C64::func_B5D7(param_01);
	var_07 = [self];
	var_04 lib_0A1A::func_237C(param_01 + "_victim",var_07);
	self method_8016("zonly_physics");
	self method_8221("face angle",self.var_B55B.var_10D6D[1]);
	self method_806F(lib_0A1E::func_2339(),param_02);
	self method_82EA(param_01,var_05,1,param_02,1);
	lib_0A1E::func_2369(param_00,param_01,var_05);
	thread lib_0C64::func_D4D6(param_01);
	self endon(param_01 + "_finished");
	var_08 = lib_0A1E::func_231F(param_00,param_01,::lib_0C64::func_B590);
	if((var_08 == "melee_death" || !self.var_B55B.var_13D8A) && !isdefined(self.var_B55B.var_112E2))
	{
		self.var_1491.var_C043 = 0;
		if(isdefined(self.var_B55B.target) && isdefined(self.var_B55B.target.var_B55B))
		{
			self.var_B55B.target.var_B55B.var_2BE6 = 1;
		}

		self method_81D0();
	}
}

//Function Number: 8
func_D4D5(param_00,param_01,param_02,param_03)
{
	self endon(param_01 + "_finished");
	self.var_B55B.var_312F = 1;
	self method_8016("zonly_physics");
	if(isdefined(self.var_B55B.var_10E0E))
	{
		self method_8221("face angle",self.var_B55B.var_10E0E);
	}
	else if(isdefined(self.var_B55B.var_10D6D))
	{
		self method_8221("face angle",self.var_B55B.var_10D6D[1]);
	}
	else
	{
		self method_8221("face current");
	}

	func_B5CB(param_01,0);
	thread lib_0C64::func_B5D7(param_01);
	var_04 = self [[ self.var_7191 ]](param_00,param_01);
	self method_806F(lib_0A1E::func_2339(),param_02);
	self method_82EA(param_01,var_04,1,param_02,1);
	lib_0A1E::func_2369(param_00,param_01,var_04);
	var_05 = getnotetracktimes(var_04,"melee_stop");
	if(var_05.size > 0)
	{
		self.var_B55B.var_11095 = var_05;
	}

	var_06 = getnotetracktimes(var_04,"melee_interact");
	if(var_06.size > 0)
	{
		self.var_B55B.var_9A53 = var_06;
	}

	var_07 = getnotetracktimes(var_04,"drop");
	if(var_07.size > 0)
	{
		self.var_B55B.var_9A08 = var_07;
	}

	thread lib_0C64::func_D4D6(param_01);
	var_08 = lib_0A1E::func_231F(param_00,param_01,::lib_0C64::func_B590);
	if((var_08 == "melee_death" || !self.var_B55B.var_13D8A) && !isdefined(self.var_B55B.var_112E2))
	{
		self.var_1491.var_C043 = 0;
		if(isdefined(self.var_B55B.var_C92C) && isdefined(self.var_B55B.var_C92C.var_B55B))
		{
			self.var_B55B.var_C92C.var_B55B.var_2BE6 = 1;
		}

		self method_81D0();
	}
}

//Function Number: 9
func_D4D4(param_00,param_01,param_02,param_03)
{
	lib_0F3D::func_444B(param_01);
	var_04 = self [[ self.var_7191 ]](param_00,param_01);
	self method_806F(lib_0A1E::func_2339(),param_02);
	self method_82EA(param_01,var_04,1,param_02,1);
	lib_0A1E::func_2369(param_00,param_01,var_04);
	lib_0A1E::func_231F(param_00,param_01,::lib_0C64::func_B590);
}

//Function Number: 10
func_D4D3(param_00,param_01,param_02)
{
	if(isdefined(self.var_B55B) && isdefined(self.var_B55B.var_C92C))
	{
		self.var_B55B.var_C92C notify("melee_exit");
	}

	if(isalive(self) && isdefined(self.var_B55B))
	{
		func_B585();
	}

	self unlink();
	if(self.var_12BA4 == "c6")
	{
		self.var_87F6 = 1;
		self.ignoreme = 0;
	}

	lib_0C64::func_B58E();
}

//Function Number: 11
func_B585()
{
	if(self.var_394 != "none" && self.var_AA45 != "none")
	{
		return;
	}

	if(!isdefined(self.var_B55B.var_394) || self.var_B55B.var_394 == "none")
	{
		return;
	}

	scripts\sp\_utility::func_72EC(self.var_B55B.var_394,self.var_B55B.var_13CCC);
	if(isdefined(self.var_B55B.var_5D3E))
	{
		self.var_B55B.var_5D3E delete();
		self.var_B55B.var_5D3E = undefined;
	}
}

//Function Number: 12
func_B5D2()
{
	self unlink();
	if(isdefined(self.var_B55B.var_C92C))
	{
		self.var_B55B.var_C92C method_8016("zonly_physics");
		self.var_B55B.var_C92C method_8221("face angle",self.var_B55B.var_C92C.angles[1]);
	}

	self method_8016("zonly_physics");
	self method_8221("face angle",self.angles[1]);
}

//Function Number: 13
func_D4CA(param_00,param_01,param_02,param_03)
{
	self unlink();
	lib_0A1E::func_2364(param_00,param_01,param_02);
}