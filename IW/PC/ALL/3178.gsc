/*******************************************************************
 * Decompiled By: Bog
 * Decompiled File: 3178.gsc
 * Game: Call of Duty: Infinite Warfare
 * Platform: PC
 * Function Count: 30
 * Decompile Time: 11 ms
 * Timestamp: 10/27/2023 12:26:28 AM
*******************************************************************/

//Function Number: 1
func_100AD(param_00,param_01,param_02,param_03)
{
	if(!lib_0A1B::func_298A())
	{
		return 0;
	}

	var_04 = lib_0A1B::func_2930();
	if(!isdefined(var_04) || !isdefined(self.var_10C) || var_04 != self.var_10C)
	{
		lib_0A1A::func_232F("throwgrenade","end");
		return 0;
	}

	if(lib_0A18::func_85B5(var_04))
	{
		var_05 = self [[ self.var_7191 ]](param_00,param_02);
		if(isdefined(var_05))
		{
			var_06 = func_7EE8(param_02,var_05);
			var_07 = self.var_DCAF;
			var_08 = distance(var_04.origin,self.origin);
			if(var_08 < 800)
			{
				if(var_08 < 256)
				{
					var_07 = 0;
				}
				else
				{
					var_07 = var_07 * var_08 - 256 / 544;
				}
			}

			var_09 = self method_806B(var_06,var_07,"min energy","min time","max time");
			self.var_1491.var_BF84 = gettime() + randomintrange(1000,2000);
			if(isdefined(var_09))
			{
				var_0A = spawnstruct();
				var_0A.var_13E0D = var_05;
				var_0A.var_1326C = var_09;
				var_0A.target = var_04;
				var_0A.var_8A09 = var_06;
				var_0A.var_6BA0 = 0;
				var_0A.var_13D8F = func_FFCE(self.var_166);
				var_0A.time = gettime();
				self.var_1198.var_1180C = var_0A;
				return 1;
			}
		}
	}

	lib_0A1A::func_232F("throwgrenade","end");
	return 0;
}

//Function Number: 2
func_3EA8(param_00,param_01,param_02)
{
	var_03 = undefined;
	var_04 = lib_0A1E::func_2356(param_01,"exposed_grenade");
	if(isarray(var_04))
	{
		var_05 = [];
		foreach(var_07 in var_04)
		{
			var_08 = getnotetracktimes(var_07,"grenade_throw");
			if(var_08.size > 0)
			{
				var_09 = getmovedelta(var_07,0,var_08[0]);
			}
			else
			{
				var_09 = getmovedelta(var_07);
			}

			var_09 = self method_81E7(var_09);
			if(self method_81FF(self.origin,var_09))
			{
				var_05[var_05.size] = var_07;
			}
		}

		if(var_05.size > 0)
		{
			var_03 = var_05[randomint(var_05.size)];
		}
		else
		{
			return undefined;
		}
	}
	else
	{
		var_03 = var_04;
	}

	return var_03;
}

//Function Number: 3
func_3EA9(param_00,param_01,param_02)
{
	var_03 = undefined;
	var_04 = lib_0A1E::func_2356(param_01,"exposed_seeker_throw");
	if(isarray(var_04))
	{
		var_05 = [];
		foreach(var_07 in var_04)
		{
			var_08 = getnotetracktimes(var_07,"grenade_throw");
			if(var_08.size > 0)
			{
				var_09 = getmovedelta(var_07,0,var_08[0]);
			}
			else
			{
				var_09 = getmovedelta(var_07);
			}

			var_09 = self method_81E7(var_09);
			if(self method_81FF(self.origin,var_09))
			{
				var_05[var_05.size] = var_07;
			}
		}

		if(var_05.size > 0)
		{
			var_03 = var_05[randomint(var_05.size)];
		}
		else
		{
			return undefined;
		}
	}
	else
	{
		var_03 = var_04;
	}

	return var_03;
}

//Function Number: 4
func_CEC6(param_00,param_01,param_02,param_03)
{
	var_04 = self.var_1198.var_1180C;
	var_05 = func_128A2(param_00,param_01,var_04,param_02);
	if(!var_05)
	{
		self endon(param_01 + "_finished");
		wait(0.2);
		lib_0A1A::func_2330(param_01,"end");
	}
}

//Function Number: 5
func_CEFE(param_00,param_01,param_02,param_03)
{
	if(isdefined(self.var_205))
	{
		self.var_1A4 = 1;
	}

	func_CEC6(param_00,param_01,param_02,param_03);
}

//Function Number: 6
func_CEFF(param_00,param_01,param_02)
{
	lib_0C5E::func_41A2(param_00,param_01,param_02);
	func_CEC7(param_00,param_01,param_02);
}

//Function Number: 7
func_CEC7(param_00,param_01,param_02)
{
	self.var_1198.var_1180C = undefined;
	lib_0A1A::func_232F("throwgrenade","end");
}

//Function Number: 8
func_FFCE(param_00)
{
	return param_00 != "antigrav" && param_00 != "emp" && param_00 != "c8_grenade";
}

//Function Number: 9
func_CEC8(param_00,param_01,param_02,param_03)
{
	var_04 = level.player;
	if(isdefined(self.var_10C))
	{
		var_04 = self.var_10C;
	}

	lib_0A18::func_F62B(var_04);
	var_05 = func_7E6D();
	func_F72C(self.var_1652,min(gettime() + 3000,var_05));
	var_06 = archetypegetaliases("soldier",param_01)[0];
	var_07 = lib_0A1E::func_2336(param_00,param_01);
	self endon("killanimscript");
	self endon(param_01 + "_finished");
	lib_0A1A::func_232F("throwSeeker","start");
	self.var_C3F3 = self.var_163;
	var_08 = lib_0A1E::func_2339();
	scripts\anim\battlechatter_ai::func_67CF(self.var_166);
	lib_0A1E::func_2369(param_00,param_01,var_07);
	self method_806F(var_08,param_02);
	self method_82EA(param_01,var_07,1,param_02,func_6B9A());
	thread lib_0A1E::func_231F(param_00,param_01);
	var_09 = "seeker_grenade_folded";
	var_0A = undefined;
	var_0B = 0;
	var_0C = func_810E(var_06);
	while(!var_0B)
	{
		self waittill(param_01,var_0D);
		if(!isarray(var_0D))
		{
			var_0D = [var_0D];
		}

		foreach(var_16, var_0F in var_0D)
		{
			if(var_0F == "attach_seeker")
			{
				if(isdefined(var_0C))
				{
					thread func_57E0("tag_accessory_left",var_0C);
				}
				else
				{
					func_2481(param_01,var_09,"tag_accessory_left");
				}

				self.var_9E33 = 1;
			}

			if(var_0F == "grenade_throw" || var_0F == "grenade throw")
			{
				var_10 = self gettagorigin("tag_accessory_left");
				var_11 = 400;
				var_12 = anglestoforward(self.angles);
				var_13 = anglestoup(self.angles);
				var_13 = var_13 * 0.6;
				var_14 = vectornormalize(var_12 + var_13);
				var_15 = var_14 * var_11;
				var_0A = function_0136(self.var_166,var_10,var_15,2);
				if(isdefined(var_0A))
				{
					if(self.var_162 > 0)
					{
						self.var_162--;
					}

					self notify("grenade_fire",var_0A,self.var_166);
				}

				if(isdefined(self.var_F174))
				{
					self.var_F174 delete();
				}

				var_0B = 1;
				continue;
			}

			if(var_0F == "end")
			{
				self.var_1652.player.var_C231--;
				self notify("dont_reduce_giptp_on_killanimscript");
				return 0;
			}
		}
	}

	self notify("dont_reduce_giptp_on_killanimscript");
	self notify("stop grenade check");
	if(!isdefined(var_0C))
	{
		self detach(var_09,"tag_accessory_left");
	}

	self.var_9E33 = undefined;
	self.var_163 = self.var_C3F3;
	self.var_C3F3 = undefined;
	if(isdefined(var_0A) && self.team == "axis")
	{
		level notify("enemy_grenade_fire",var_0A);
	}

	func_F72C(self.var_1652,gettime() + 10000);
	self waittillmatch("end",param_01);
	self notify("done_grenade_throw");
	self notify("weapon_switch_done");
	lib_0A1A::func_232F("throwSeeker","end");
}

//Function Number: 10
func_810E(param_00)
{
	if(param_00 == "exposed_seeker_throw")
	{
		return %equip_seeker_throw01;
	}

	return undefined;
}

//Function Number: 11
func_57E0(param_00,param_01)
{
	self.var_F174 = spawn("script_model",self gettagorigin(param_00));
	thread scripts\common\utility::func_5179(self.var_F174);
	self.var_F174 endon("death");
	self.var_F174.angles = self gettagangles(param_00);
	self.var_F174 linkto(self,param_00,(0,0,0),(0,0,0));
	self.var_F174 setmodel("seeker_grenade_wm");
	self.var_F174 method_83D0(#animtree);
	self.var_F174 method_82EA("thrown",param_01,1,0.2);
}

//Function Number: 12
func_128A2(param_00,param_01,param_02,param_03,param_04)
{
	var_05 = param_02.var_5293;
	var_06 = param_02.target;
	var_07 = param_02.var_13D8F;
	if(!isdefined(var_07))
	{
		var_07 = 1;
	}

	if(isdefined(var_05))
	{
		var_08 = func_7EE8(param_01,param_02.var_13E0D);
		if(!isdefined(param_02.var_6BA0))
		{
			var_09 = self method_806C(var_08,var_05,var_07,"min energy","min time","max time");
		}
		else
		{
			var_09 = self method_806C(var_08,var_05,var_07,"min time","min energy");
		}
	}
	else
	{
		var_09 = param_03.var_1326C;
	}

	var_06 = param_02.target;
	if(isdefined(var_09))
	{
		if(!isdefined(self.var_C3F3))
		{
			self.var_C3F3 = self.var_163;
		}

		self.var_163 = 0;
		var_0A = func_7E6D();
		func_F72C(self.var_1652,min(gettime() + 3000,var_0A));
		var_0B = 0;
		if(func_13116())
		{
			var_06.var_C231++;
			thread func_DE37(param_01,var_06);
			if(var_06.var_C231 > 1)
			{
				var_0B = 1;
			}

			if(self.var_1652.var_1191A == "fraggrenade")
			{
				if(var_06.var_C231 <= 1)
				{
					var_06.var_A98C = gettime();
				}
			}
		}

		if(isdefined(param_04))
		{
			thread func_58BA(param_00,param_01,param_02.var_13E0D,var_09,param_03,var_0A,var_0B);
		}
		else
		{
			func_58BA(param_00,param_01,param_02.var_13E0D,var_09,param_03,var_0A,var_0B);
		}

		return 1;
	}
	else
	{
	}

	return 0;
}

//Function Number: 13
func_7EE8(param_00,param_01)
{
	var_02 = (0,0,64);
	var_03 = self.var_2303.var_2123;
	var_04 = 0;
	if(isdefined(level.var_85DF))
	{
		if(!isdefined(level.var_85DF[var_03]))
		{
			var_03 = "soldier";
		}

		if(isdefined(level.var_85DF[var_03]))
		{
			if(isdefined(level.var_85DF[var_03][param_00]))
			{
				foreach(var_08, var_06 in level.var_85DF[var_03][param_00])
				{
					for(var_07 = 0;var_07 < var_06.size;var_07++)
					{
						if(var_06[var_07] == param_01)
						{
							var_02 = level.var_85E1[var_03][param_00][var_08][var_07];
							var_04 = 1;
							break;
						}
					}

					if(var_04)
					{
						break;
					}
				}
			}
		}
	}

	return var_02;
}

//Function Number: 14
func_7E6D()
{
	var_00 = undefined;
	if(func_13116())
	{
		var_01 = self.var_1652.player;
		var_00 = gettime() + var_01.var_86A9.var_D396 + randomint(var_01.var_86A9.var_D397);
	}
	else
	{
		var_00 = gettime() + 30000 + randomint(30000);
	}

	return var_00;
}

//Function Number: 15
func_13116()
{
	return self.var_1652.var_9EFB;
}

//Function Number: 16
func_DE37(param_00,param_01)
{
	self endon("dont_reduce_giptp_on_killanimscript");
	self waittill(param_00 + "_finished");
	param_01.var_C231--;
}

//Function Number: 17
func_58BA(param_00,param_01,param_02,param_03,param_04,param_05,param_06)
{
	self endon("killanimscript");
	self endon(param_01 + "_finished");
	lib_0A1A::func_232F("throwgrenade","start");
	var_07 = lib_0A1B::func_2920();
	if(!isdefined(var_07) || var_07.type == "Exposed" || var_07.type == "Path")
	{
		self method_8221("face direction",param_03);
	}

	var_08 = lib_0A1E::func_2339();
	scripts\anim\battlechatter_ai::func_67CF(self.var_166);
	lib_0A1E::func_2369(param_00,param_01,param_02);
	self method_806F(var_08,param_04);
	self method_82EA(param_01,param_02,1,param_04,func_6B9A());
	thread lib_0A1E::func_231F(param_00,param_01);
	var_09 = scripts\anim\utility_common::func_7EE7();
	var_0A = "none";
	var_0B = 0;
	while(!var_0B)
	{
		self waittill(param_01,var_0C);
		if(!isarray(var_0C))
		{
			var_0C = [var_0C];
		}

		foreach(var_0E in var_0C)
		{
			if(var_0E == "grenade_left" || var_0E == "grenade_right")
			{
				var_0A = func_2481(param_01,var_09,"tag_accessory_right");
				self.var_9E33 = 1;
			}

			if(var_0E == "grenade_throw" || var_0E == "grenade throw")
			{
				if(isdefined(self.var_1FEC) && self.var_1FEC == "c6")
				{
					self playsound("c6_grenade_launch");
				}

				var_0B = 1;
				continue;
			}

			if(var_0E == "end")
			{
				self.var_1652.player.var_C231--;
				self notify("dont_reduce_giptp_on_killanimscript");
				return 0;
			}
		}
	}

	self notify("dont_reduce_giptp_on_killanimscript");
	if(func_13116())
	{
		thread func_13A98(param_01,self.var_1652.player,param_05);
	}

	var_16 = self method_83C2();
	if(!func_13116())
	{
		func_F72C(self.var_1652,param_05);
	}

	if(param_06)
	{
		var_17 = self.var_1652.player;
		if(var_17.var_C231 > 1 || gettime() - var_17.var_A990 < 2000)
		{
			var_17.var_85E4["double_grenade"] = gettime() + min(5000,var_17.var_86A9.var_D382);
		}
	}

	self notify("stop grenade check");
	if(var_0A != "none")
	{
		self detach(var_09,var_0A);
	}

	self.var_9E33 = undefined;
	self.var_163 = self.var_C3F3;
	self.var_C3F3 = undefined;
	if(isdefined(var_16) && self.team == "axis")
	{
		level notify("enemy_grenade_fire",var_16);
	}

	self waittillmatch("end",param_01);
	self notify("done_grenade_throw");
	self notify("weapon_switch_done");
}

//Function Number: 18
func_11810(param_00,param_01,param_02,param_03)
{
	if(!lib_0A1B::func_298A())
	{
		if(lib_0A1A::func_232B(param_01,"grenade_throw") || lib_0A1A::func_232B(param_01,"grenade throw"))
		{
			return 0;
		}

		if(lib_0A1A::func_232B(param_01,"grenade_right") || lib_0A1A::func_232B(param_01,"grenade_left"))
		{
			return 0;
		}

		return 1;
	}

	return 0;
}

//Function Number: 19
func_6B9A()
{
	return 1.5;
}

//Function Number: 20
func_2481(param_00,param_01,param_02)
{
	self attach(param_01,param_02);
	thread func_5392(param_00,param_01,param_02);
	return param_02;
}

//Function Number: 21
func_13841(param_00)
{
	self endon(param_00 + "_finished");
	self waittill("killanimscript");
}

//Function Number: 22
func_5392(param_00,param_01,param_02)
{
	self endon("stop grenade check");
	func_13841(param_00);
	if(!isdefined(self))
	{
		return;
	}

	if(isdefined(self.var_C3F3))
	{
		self.var_163 = self.var_C3F3;
		self.var_C3F3 = undefined;
	}

	self detach(param_01,param_02);
}

//Function Number: 23
func_13A98(param_00,param_01,param_02)
{
	param_01 endon("death");
	func_13A99(param_00,param_02);
	param_01.var_C231--;
}

//Function Number: 24
func_13A99(param_00,param_01)
{
	var_02 = self.var_1652;
	var_03 = spawnstruct();
	var_03 thread func_13A9A(5);
	var_03 endon("watchGrenadeTowardsPlayerTimeout");
	var_04 = self.var_166;
	var_05 = func_7EE6(param_00);
	if(!isdefined(var_05))
	{
		return;
	}

	func_F72C(var_02,min(gettime() + 5000,param_01));
	var_06 = -3036;
	var_07 = 160000;
	if(var_04 == "flash_grenade")
	{
		var_06 = 810000;
		var_07 = 1690000;
	}

	var_08 = level.players;
	var_09 = var_05.origin;
	for(;;)
	{
		wait(0.1);
		if(!isdefined(var_05))
		{
			break;
		}

		if(distancesquared(var_05.origin,var_09) < 400)
		{
			var_0A = [];
			for(var_0B = 0;var_0B < var_08.size;var_0B++)
			{
				var_0C = var_08[var_0B];
				var_0D = distancesquared(var_05.origin,var_0C.origin);
				if(var_0D < var_06)
				{
					var_0C func_85C8(var_02,param_01);
					continue;
				}

				if(var_0D < var_07)
				{
					var_0A[var_0A.size] = var_0C;
				}
			}

			var_08 = var_0A;
			if(var_08.size == 0)
			{
				break;
			}
		}

		var_09 = var_05.origin;
	}
}

//Function Number: 25
func_85C8(param_00,param_01)
{
	var_02 = self;
	anim.var_11813 = undefined;
	if(gettime() - var_02.var_A990 < 3000)
	{
		var_02.var_85E4["double_grenade"] = gettime() + var_02.var_86A9.var_D382;
	}

	var_02.var_A990 = gettime();
	var_03 = var_02.var_85E4[param_00.var_1191A];
	var_02.var_85E4[param_00.var_1191A] = max(param_01,var_03);
}

//Function Number: 26
func_F72C(param_00,param_01)
{
	if(param_00.var_9EFB)
	{
		var_02 = param_00.player;
		var_03 = var_02.var_85E4[param_00.var_1191A];
		var_02.var_85E4[param_00.var_1191A] = max(param_01,var_03);
		return;
	}

	var_03 = level.var_85E4[param_01.var_1191A];
	level.var_85E4[param_00.var_1191A] = max(param_01,var_03);
}

//Function Number: 27
func_7EE6(param_00)
{
	self endon("killanimscript");
	self endon(param_00 + "_finished");
	self waittill("grenade_fire",var_01);
	return var_01;
}

//Function Number: 28
func_13A9A(param_00)
{
	wait(param_00);
	self notify("watchGrenadeTowardsPlayerTimeout");
}

//Function Number: 29
func_7EE9(param_00)
{
	if(param_00.var_9EFB)
	{
		return param_00.player.var_85E4[param_00.var_1191A];
	}

	return level.var_85E4[param_00.var_1191A];
}

//Function Number: 30
func_C371(param_00)
{
	var_01 = anglestoforward(self.angles);
	var_02 = anglestoright(self.angles);
	var_03 = anglestoup(self.angles);
	var_01 = var_01 * param_00[0];
	var_02 = var_02 * param_00[1];
	var_03 = var_03 * param_00[2];
	return var_01 + var_02 + var_03;
}