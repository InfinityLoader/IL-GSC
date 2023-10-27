/*******************************************************************
 * Decompiled By: Bog
 * Decompiled File: 2859.gsc
 * Game: Call of Duty: Infinite Warfare
 * Platform: PC
 * Function Count: 122
 * Decompile Time: 47 ms
 * Timestamp: 10/27/2023 12:24:19 AM
*******************************************************************/

//Function Number: 1
func_6B44()
{
	setdvarifuninitialized("debug_fakeactor",0);
	setdvarifuninitialized("debug_fakeactor_accuracy",0);
	level._effect["fakeactor_muzflash"] = loadfx("vfx/core/muzflash/ak47_flash_wv");
	if(!isdefined(level.var_B438))
	{
		level.var_B438 = [];
	}

	if(!isdefined(level.var_B438["allies"]))
	{
		level.var_B438["allies"] = 9999;
	}

	if(!isdefined(level.var_B438["axis"]))
	{
		level.var_B438["axis"] = 9999;
	}

	if(!isdefined(level.var_B438["team3"]))
	{
		level.var_B438["team3"] = 9999;
	}

	if(!isdefined(level.var_B438["neutral"]))
	{
		level.var_B438["neutral"] = 9999;
	}

	if(!isdefined(level.var_6B46))
	{
		level.var_6B46 = [];
	}

	if(!isdefined(level.var_6B46["allies"]))
	{
		level.var_6B46["allies"] = scripts\sp\_utility::func_1115A();
	}

	if(!isdefined(level.var_6B46["axis"]))
	{
		level.var_6B46["axis"] = scripts\sp\_utility::func_1115A();
	}

	if(!isdefined(level.var_6B46["team3"]))
	{
		level.var_6B46["team3"] = scripts\sp\_utility::func_1115A();
	}

	if(!isdefined(level.var_6B46["neutral"]))
	{
		level.var_6B46["neutral"] = scripts\sp\_utility::func_1115A();
	}

	if(!isdefined(level.var_6A65))
	{
		func_174C("default","anim",::func_CC8A,::func_CC86,30);
		func_174C("default","move",::func_BC82,::func_BC1C,10);
		func_174C("default","traverse",::func_126D9,::func_126D0,20);
		func_174C("default","idle",::func_92EE,::func_92D9,40);
	}

	level.var_6B43 = ::func_6B16;
	if(!isdefined(level.var_6A64))
	{
		var_00 = [];
		var_00["Cover Left"] = 0;
		var_00["Cover Right"] = -90;
		var_00["Cover Crouch"] = -90;
		var_00["Cover Stand"] = -90;
		var_00["Cover Stand 3D"] = -90;
		anim.var_6A64 = var_00;
		var_00 = [];
		var_00["Cover Left"] = 180;
		var_00["Cover Left Crouch"] = 0;
		var_00["Cover Right"] = 180;
		var_00["Cover Crouch"] = 180;
		var_00["Cover Stand"] = 180;
		anim.var_6A63 = var_00;
	}
}

//Function Number: 2
func_79AF(param_00)
{
	return level.var_6B46[param_00].var_2274;
}

//Function Number: 3
func_9BDF()
{
	return isdefined(self.var_ED8A) && self.var_ED8A;
}

//Function Number: 4
func_6B16()
{
	if(level.var_6B46[self.team].var_2274.size >= level.var_B438[self.team])
	{
		self delete();
		return;
	}

	thread func_2294(self);
	level notify("new_fakeactor");
	self.var_EDB3 = undefined;
	self.var_134 = 0;
	self.var_368 = -45;
	self.var_100 = 45;
	self.var_268 = -45;
	self.var_1B7 = 45;
	self.var_2894 = 1;
	self.var_AFED = 200;
	self.var_B04E = 0.5;
	func_F2C3(["exposed"]);
	if(isdefined(self.var_ED56))
	{
		if(self.var_ED56 == "frantic")
		{
			func_F3BE(1);
		}

		self.var_ED56 = undefined;
	}

	if(isdefined(self.var_ED61))
	{
		func_F35C(self.var_ED61);
		self.var_ED61 = undefined;
	}

	if(isdefined(self.var_ED62))
	{
		func_F35D(self.var_ED62);
		self.var_ED62 = undefined;
	}

	if(isdefined(self.var_EDE1))
	{
		func_F410(self.var_EDE1);
		self.var_EDE1 = undefined;
	}

	if(isdefined(self.var_ECF9))
	{
		func_F2C6(self.var_ECF9);
		self.var_ECF9 = undefined;
	}

	if(isdefined(self.var_EEFF))
	{
		func_F568(self.var_EEFF);
		self.var_EEFF = undefined;
	}

	if(isdefined(self.var_EEFE))
	{
		func_F5F9(self.var_EEFE);
		self.var_EEFE = undefined;
	}

	func_6B15();
	self hide();
	scripts\common\utility::delaycall(0.05,::show);
	if(self.team == "axis")
	{
		self method_80C7();
	}

	self setcandamage(1);
	self.health = 150;
	thread func_6B45();
}

//Function Number: 5
func_495A(param_00)
{
	if(!isdefined(level.var_6A65))
	{
		level.var_6A65 = [];
	}

	level.var_6A65[param_00] = [];
}

//Function Number: 6
func_7CA8(param_00)
{
	return level.var_6A65[param_00];
}

//Function Number: 7
func_174C(param_00,param_01,param_02,param_03,param_04)
{
	if(!isdefined(level.var_6A65))
	{
		level.var_6A65 = [];
	}

	if(!isdefined(level.var_6A65[param_00]))
	{
		func_495A(param_00);
	}

	var_05 = level.var_6A65[param_00].size;
	level.var_6A65[param_00][var_05] = [];
	level.var_6A65[param_00][var_05]["priority"] = param_04;
	level.var_6A65[param_00][var_05]["stateName"] = param_01;
	level.var_6A65[param_00][var_05]["thinkFunc"] = param_02;
	level.var_6A65[param_00][var_05]["changeFunc"] = param_03;
	level.var_6A65[param_00] = scripts\common\utility::func_22C3(level.var_6A65[param_00],::func_9BFF);
}

//Function Number: 8
func_E092(param_00,param_01)
{
	if(!isdefined(level.var_6A65[param_00]))
	{
		return;
	}

	var_02 = [];
	foreach(var_04 in level.var_6A65[param_00])
	{
		if(var_04["stateName"] != param_01)
		{
			var_02[var_02.size] = var_04;
		}
	}

	level.var_6A65[param_00] = var_02;
}

//Function Number: 9
func_6B15()
{
	func_F8BE();
	if(self.team == "allies" && isdefined(self.name))
	{
		scripts\sp\_names::func_7B05();
		self method_8307(self.name,&"");
	}
	else if(self.team == "axis")
	{
		self method_8307("enemy",&"");
	}

	if(isdefined(self.var_EE2C))
	{
		self.var_BCD6 = self.var_EE2C;
	}
	else
	{
		self.var_BCD6 = 1;
	}

	if(!isdefined(self.var_EDB7) || !self.var_EDB7)
	{
		level thread scripts\sp\_friendlyfire::func_73B1(self);
	}

	self method_839E();
	if(isdefined(self.target))
	{
		var_00 = scripts\common\utility::getstruct(self.target,"targetname");
		if(isdefined(var_00) && var_00 lib_0B2D::func_9BE0())
		{
			if(func_9B69())
			{
				func_1164B(var_00);
				return;
			}

			func_F31D(var_00);
			return;
		}
	}
}

//Function Number: 10
func_6B45()
{
	waittillframeend;
	thread func_12E30();
	thread func_BC42();
	thread func_13924();
	thread func_B282();
	thread func_4E22();
}

//Function Number: 11
func_B282()
{
	self endon("death");
	thread func_DD7E();
	self waittill("make_real_ai");
	scripts\sp\_utility::func_1101B();
	var_00 = self.var_394;
	var_01 = "";
	if(isdefined(self.var_4B94) && isdefined(self.var_4B94.target))
	{
		var_01 = self.var_4B94.target;
	}

	var_02 = lib_0B77::func_10869(self,var_01);
	var_02 scripts\anim\shared::func_CC2C(var_00,"right");
	if(isdefined(self))
	{
		self delete();
	}
}

//Function Number: 12
func_13949()
{
	self endon("death");
	self endon("goal");
	var_00 = squared(128);
	for(;;)
	{
		if(distancesquared(level.player getorigin(),self.origin) < var_00)
		{
			func_C2C9(1);
		}
		else
		{
			func_C2C9(0);
		}

		wait(0.05);
	}
}

//Function Number: 13
func_DD7E()
{
	self endon("death");
	self endon("make_real_ai");
	if(!isdefined(self.var_257) || self.var_257 <= 0)
	{
		return;
	}

	for(;;)
	{
		if(distancesquared(level.player geteye(),self.origin) < squared(self.var_257))
		{
			self notify("make_real_ai");
			return;
		}

		wait(0.05);
	}
}

//Function Number: 14
func_3DBA()
{
	if(func_9C0B())
	{
		return 0;
	}

	return self.var_4B94 lib_0B2D::func_6B2B(self);
}

//Function Number: 15
func_3C4D(param_00)
{
	self.var_D8A6 = self.var_4BBE;
	self notify("change_state");
	func_40C8();
	self.var_4BBE = param_00["stateName"];
	self thread [[ param_00["thinkFunc"] ]]();
}

//Function Number: 16
func_174D(param_00)
{
	if(!isdefined(self.var_4BBF))
	{
		self.var_4BBF = [];
	}

	self.var_4BBF[self.var_4BBF.size] = param_00;
}

//Function Number: 17
func_40C8()
{
	if(isdefined(self.var_4BBF))
	{
		foreach(var_01 in self.var_4BBF)
		{
			if(isdefined(var_01))
			{
				var_01 delete();
			}
		}
	}
}

//Function Number: 18
func_12E30()
{
	self endon("death");
	self endon("make_real_ai");
	self.var_D8A6 = "";
	var_00 = "default";
	if(isdefined(self.var_10E1D))
	{
		var_00 = self.var_10E1D;
	}

	for(;;)
	{
		wait(0.05);
		if(func_9BA1())
		{
			continue;
		}

		foreach(var_02 in func_7CA8(var_00))
		{
			if(isdefined(self.var_4BBE) && self.var_4BBE == var_02["stateName"])
			{
				continue;
			}

			if([[ var_02["changeFunc"] ]]())
			{
				func_3C4D(var_02);
				break;
			}
		}
	}
}

//Function Number: 19
func_92D9()
{
	if(!isdefined(self.var_4BBE))
	{
		return 1;
	}

	if(self.var_4B94 lib_0B2D::func_6B2B(self))
	{
		return 1;
	}

	return 0;
}

//Function Number: 20
func_92EE()
{
	self endon("death");
	self endon("change_state");
	func_6B11();
	self notify("goal");
	while(isdefined(self))
	{
		if(isdefined(self.var_92D2))
		{
			func_CE00(func_7A2A());
			continue;
		}

		childthread func_6BDE();
		self waittill("start_next_fight");
	}
}

//Function Number: 21
func_6BDE()
{
	self endon("death");
	self endon("change_state");
	if(!isdefined(self.var_180))
	{
		if(isdefined(self.var_4B94))
		{
			var_00 = self.var_4B94 scripts\sp\_utility::func_7A8F();
			var_00 = scripts\common\utility::array_combine(var_00,self.var_4B94 scripts\sp\_utility::func_7A97());
			if(var_00.size)
			{
				var_01 = scripts\common\utility::random(var_00);
				var_02 = (0,0,0);
				if(isdefined(var_01.var_257))
				{
					var_03 = randomfloatrange(var_01.var_257 * -1,var_01.var_257);
					var_04 = randomfloatrange(var_01.var_257 * -1,var_01.var_257);
					var_02 = (var_03,var_04,0);
				}

				func_F297(var_01,var_02);
			}
		}

		var_05 = func_7A04();
		var_06 = func_77E9();
		var_07 = self.origin;
		if(isdefined(var_05) && isdefined(var_06))
		{
			func_CE00(var_05);
		}

		self notify("start_aim");
		func_6D53(func_7C63());
		self notify("end_aim");
		if(isdefined(var_05) && isdefined(var_06))
		{
			func_CE00(var_06);
		}

		if(func_FF45())
		{
			var_08 = func_7C03();
			if(isdefined(var_08))
			{
				func_CE00(var_08);
			}
		}

		if(scripts\common\utility::func_4347())
		{
			var_09 = self.var_1FD0;
			func_CB1F();
			if(self.var_1FD0 != var_09)
			{
				func_CE00(func_7C9F());
			}
		}
	}

	func_CE00(func_7A2A());
	func_F613(1);
	self notify("start_next_fight");
}

//Function Number: 22
func_126D0()
{
	if(isdefined(self.var_4B94) && self.var_4B94 lib_0B2D::func_6B2B(self) && self.var_4B94 lib_0B2D::func_6B32())
	{
		return 1;
	}

	return 0;
}

//Function Number: 23
func_126D9()
{
	self endon("death");
	func_F30A(1);
	var_00 = func_57D2(self.var_4B94.var_126CD);
	func_F30A(0);
	func_F613(1);
}

//Function Number: 24
func_12944()
{
	if(self.var_4B94 lib_0B2D::func_6B2B(self) && self.var_4B94 lib_0B2D::func_6B33())
	{
		return 1;
	}

	return 0;
}

//Function Number: 25
func_12999()
{
	self endon("death");
	func_F30A(1);
	var_00 = self.var_4B94 lib_0B2D::func_6B20();
	func_CE00(func_7D21(self.angles,self.origin,var_00.origin));
	func_F30A(0);
	func_F613(1);
}

//Function Number: 26
func_CC86()
{
	if(isdefined(self.var_4B94) && self.var_4B94 lib_0B2D::func_6B2B(self) && self.var_4B94 lib_0B2D::func_6B2A())
	{
		if(!isdefined(self.var_4B94.var_A880) || self.var_4B94.var_A880 != self)
		{
			return 1;
		}
	}

	return 0;
}

//Function Number: 27
func_CC8A()
{
	self endon("death");
	func_F30A(1);
	self.var_4B94.var_1EEF lib_0B06::func_1ED1(self,self.var_4B94.var_1FA2);
	self.var_4B94.var_A880 = self;
	func_F30A(0);
	func_F613(1);
	self notify("played_anim");
}

//Function Number: 28
func_57D2(param_00)
{
	var_01 = func_7D19(param_00);
	func_CE00(var_01,undefined,::scripts\anim\traverse\shared::func_89F8,"traverseAnim",self.var_4B94);
}

//Function Number: 29
func_BC42()
{
	self endon("death");
	self endon("make_real_ai");
	for(;;)
	{
		self waittill("move");
		func_F613(1);
	}
}

//Function Number: 30
func_BC1C()
{
	if(isdefined(self.var_72A9))
	{
		self.var_C039 = self.var_72A9;
		self.var_72A9 = undefined;
		return 1;
	}

	if(!isdefined(self.var_4B94))
	{
		return 0;
	}

	var_00 = func_582B();
	var_01 = undefined;
	if(!isdefined(self.var_4BBE) && isdefined(self.var_4B94))
	{
		var_01 = lib_0B2D::func_6B21(self.var_4B94,self.origin,func_9BE8(),var_00);
	}

	if(self.var_4B94 lib_0B2D::func_6B2B(self) && !self.var_4B94 lib_0B2D::func_6B2D(var_00))
	{
		var_02 = self.var_4B94 lib_0B2D::func_6B20();
		var_01 = lib_0B2D::func_6B21(var_02,self.origin,func_9BE8(),var_00);
	}

	if(isdefined(var_01))
	{
		foreach(var_04 in var_01)
		{
			if(var_04["dist"] > 0)
			{
				self.var_C039 = var_01;
				return 1;
			}
		}
	}

	return 0;
}

//Function Number: 31
func_CDEB()
{
	self endon("death");
	self endon("change_state");
	self notify("stop_running_anim");
	self endon("stop_running_anim");
	var_00 = 1;
	if(isdefined(self.var_E812) && isdefined(self.var_E811))
	{
		var_00 = randomfloatrange(self.var_E812,self.var_E811);
	}

	for(;;)
	{
		var_01 = func_7AFA();
		var_02 = func_7816(var_01);
		var_03 = var_02.var_E81C;
		var_04 = var_02.var_1F1D;
		func_CD83(var_01,var_00);
		wait(getanimlength(var_01));
	}
}

//Function Number: 32
func_BC82()
{
	self endon("death");
	self endon("change_state");
	self notify("exit_node");
	var_00 = self.origin;
	var_01 = func_582B();
	if(self.var_C039.size == 0)
	{
	}

	self.var_4B94 lib_0B2D::func_6B36(self);
	var_02 = func_7AFA();
	var_03 = func_7816(var_02);
	var_04 = var_03.var_E81C;
	var_05 = var_03.var_1F1D;
	if(!var_05)
	{
		childthread func_AEE8(var_04);
	}

	var_06 = self.var_C039[self.var_C039.size - 1];
	if(self.var_C039[0]["total_dist"] < 64)
	{
		thread func_CE00(func_7A2A());
		var_07 = scripts\common\utility::func_107CE(self.origin,self.angles);
		func_174D(var_07);
		self linkto(var_07);
		var_08 = 0.2;
		var_07 moveto(var_06["origin"],var_08);
		var_07 rotateto(var_06["angles"],var_08);
		scripts\common\utility::waittill_notify_or_timeout("death",var_08);
		self unlink();
		var_07 delete();
		if(self.var_4B94 != var_06["node"])
		{
			self.var_4B94 = var_06["node"];
		}

		self.var_4B94 lib_0B2D::func_6B37(self);
		func_6B12(self.var_4B94);
		func_F613(0);
		self notify("arrive_node");
		return;
	}

	var_09 = 0;
	var_0A = undefined;
	if(func_FF2F())
	{
		var_0B = 0;
		foreach(var_0D in self.var_C039)
		{
			if(var_0B)
			{
				var_0A = var_0D["origin"];
				break;
			}

			if(var_0D["dist"] > 0)
			{
				var_0B = 1;
			}
		}

		if(isdefined(var_0A))
		{
			var_0F = func_79A4(var_0A);
			func_CE00(var_0F);
		}
	}

	var_10 = undefined;
	var_11 = scripts\common\utility::random(var_08["node"] lib_0B2D::func_6B1F());
	if(func_FF2C() && !var_08["node"] lib_0B2D::func_6B32() && !var_08["node"] lib_0B2D::func_6B33() && var_08["node"] lib_0B2D::func_6B18())
	{
		var_12 = self;
		if(isdefined(self.var_C039[self.var_C039.size - 2]["node"]))
		{
			var_12 = self.var_C039[self.var_C039.size - 2]["node"];
		}

		var_10 = func_7836(var_08["node"],var_12,var_11);
		if(isdefined(var_10))
		{
			var_13 = getmovedelta(var_10,0,1);
			var_14 = getangledelta3d(var_10,0,1);
			var_15 = invertangles(var_14);
			var_16 = combineangles(var_08["angles"],var_15);
			var_17 = var_08["origin"] - rotatevector(var_13,var_16);
			var_08["anim_node"] = scripts\common\utility::func_107CE(var_17,var_16);
			func_174D(var_08["anim_node"]);
			var_08["origin"] = var_17;
			var_08["angles"] = var_16;
		}
	}

	thread func_CDEB();
	thread func_13949();
	self.var_4B94 = self.var_C039[var_09 + 1]["node"];
	var_18 = 1;
	if(isdefined(self.var_BC68))
	{
		var_18 = self.var_BC68;
	}

	for(;;)
	{
		var_19 = self.var_C039[var_09]["to_next_node"];
		var_1A = self.origin - self.var_C039[var_09]["origin"];
		var_1B = vectordot(var_19,var_1A);
		if(var_09 == self.var_C039.size)
		{
			break;
		}

		var_1C = var_1B + self.var_AFED;
		while(var_1C > self.var_C039[var_09]["dist"])
		{
			var_1C = var_1C - self.var_C039[var_09]["dist"];
			var_09++;
			if(var_09 == self.var_C039.size)
			{
				if(self.var_4B94 != var_08["node"])
				{
					self.var_4B94 = var_08["node"];
				}

				var_08 = 0;
				var_1D = (0,0,0);
				var_1E = (0,0,0);
				var_1F = (0,0,0);
				if(func_9B69())
				{
					var_20 = self.var_C039[self.var_C039.size - 1]["origin"] - self.origin;
					var_21 = length(var_20);
					var_1E = anglestoup(self.angles);
					var_1D = vectornormalize(var_20);
					var_1F = vectorcross(var_1D,var_1E);
					var_1D = vectorcross(var_1E,var_1F);
					if(var_21 > 0)
					{
						var_23 = var_21 / var_05 * var_11;
					}
				}
				else
				{
					var_20 = var_09["origin"] - self.origin;
					var_1E = vectortoangles(var_21);
					var_21 = length(var_21);
					var_23 = var_21 / var_05 * var_11;
				}

				if(var_23 > 0)
				{
					if(var_06)
					{
						self moveto(var_07["origin"],var_23);
						if(func_9B69())
						{
							self rotateto(axistoangles(var_1D,var_1F,var_1E),var_23);
						}
						else
						{
							self rotateto(var_1D,var_23 * 0.25);
						}

						wait(var_23);
					}
					else
					{
						var_07 = scripts\common\utility::func_107CE(self.origin,self.angles);
						func_174D(var_21);
						self linkto(var_21);
						var_21 moveto(var_06["origin"],var_22);
						if(func_9B69())
						{
							var_21 rotateto(axistoangles(var_23,var_1E,var_1D),var_22);
						}
						else
						{
							var_21 rotateto(var_23,var_22 * 0.25);
						}

						scripts\common\utility::waittill_notify_or_timeout("death",var_22);
						self unlink();
						var_21 delete();
					}
				}

				if(isdefined(var_09))
				{
					self notify("stop_running_anim");
					func_CE00(var_09,undefined,undefined,undefined,var_06["anim_node"],0);
					var_06["anim_node"] delete();
					func_F2C3([var_0A]);
				}
				else
				{
					self.angles = var_06["angles"];
					func_F2C3(self.var_4B94 lib_0B2D::func_6B1F());
				}

				self.var_4B94 lib_0B2D::func_6B37(self);
				func_6B12(self.var_4B94);
				self notify("stop_running_anim");
				func_F613(0);
				self notify("arrive_node");
				self notify("reached_path_end");
				self notify("goal");
				return;
			}
			else if(self.var_4B94 != self.var_C039[var_18]["node"])
			{
				self.var_4B94 = self.var_C039[var_18]["node"];
				func_F2C3(self.var_4B94 lib_0B2D::func_6B1F());
				func_6B12(self.var_4B94);
			}
		}

		var_1F = self.var_C039[var_18]["to_next_node"] * var_1E;
		var_1F = var_1F + self.var_C039[var_18]["origin"];
		var_20 = var_1F;
		if(!var_10)
		{
			self.var_AFEC = var_20;
		}

		if(func_9B69())
		{
			var_1E = anglestoup(self.angles);
			var_1D = vectornormalize(var_1F - self.origin);
			var_1F = vectorcross(var_20,var_1F);
			var_1F = vectorcross(var_1E,var_20);
			self rotateto(axistoangles(var_1F,var_20,var_1E),self.var_B04E);
		}
		else
		{
			var_16 = vectortoangles(var_1D - self.origin);
			childthread func_6B40(var_16,self.var_B04E);
		}

		if(var_08)
		{
			var_24 = var_07 * self.var_B04E * self.var_BC68;
			var_25 = vectornormalize(var_1D - self.origin);
			var_23 = var_25 * var_24;
			var_23 = var_23 + self.origin;
			self moveto(var_23,self.var_B04E);
		}

		if(getdvar("debug_fakeactor") == "1")
		{
		}

		wait(self.var_B04E);
	}

	self.var_C039 = undefined;
	func_F613(0);
	self notify("arrive_node");
	self notify("reached_path_end");
	self notify("goal");
}

//Function Number: 33
func_6B40(param_00,param_01)
{
	var_02 = anglestoforward(self.angles);
	var_03 = anglestoforward(param_00);
	var_04 = 0;
	var_05 = 1 / param_01;
	for(;;)
	{
		var_06 = var_04 * var_05;
		var_07 = vectorlerp(var_02,var_03,var_06);
		self.angles = vectortoangles(var_07);
		var_04 = var_04 + 0.05;
		wait(0.05);
		if(var_04 >= param_01)
		{
			break;
		}
	}

	self.angles = param_00;
}

//Function Number: 34
func_6B11()
{
	if(!isdefined(self))
	{
		return;
	}

	if(!isdefined(self.script_noteworthy))
	{
		return;
	}

	switch(self.script_noteworthy)
	{
		case "delete_on_goal":
			if(isdefined(self.var_B14F))
			{
				scripts\sp\_utility::func_1101B();
			}
	
			self delete();
			break;

		case "die_on_goal":
			self method_81D0();
			break;
	}
}

//Function Number: 35
func_6B12(param_00)
{
	if(isdefined(param_00.script_noteworthy))
	{
		switch(param_00.script_noteworthy)
		{
			case "delete_on_goal":
				if(isdefined(self.var_B14F))
				{
					scripts\sp\_utility::func_1101B();
				}
	
				self delete();
				break;

			case "die_on_goal":
				self method_81D0();
				break;
		}
	}

	if(isdefined(param_00.var_ED9E))
	{
		scripts\common\utility::flag_set(param_00.var_ED9E);
	}

	if(isdefined(param_00.var_ED9B))
	{
		scripts\common\utility::func_6E2A(param_00.var_ED9B);
	}

	if(isdefined(param_00.var_ED80))
	{
		scripts\sp\_utility::func_65E1(param_00.var_ED80);
	}

	if(isdefined(self.var_ED7F))
	{
		scripts\sp\_utility::func_65E1(param_00.var_ED7F);
	}

	if(isdefined(param_00.var_ED56))
	{
		if(param_00.var_ED56 == "frantic")
		{
			func_F3BE(1);
		}
	}

	if(isdefined(param_00.var_ED60))
	{
		func_F35C(param_00.var_ED60);
	}

	if(isdefined(param_00.var_ED62))
	{
		func_F35D(param_00.var_ED62);
	}

	if(isdefined(param_00.var_ECF9))
	{
		func_F2C6(param_00.var_ECF9);
	}

	if(isdefined(param_00.var_EEFF))
	{
		func_F568(param_00.var_EEFF);
	}

	if(isdefined(param_00.var_EEFE))
	{
		func_F5F9(param_00.var_EEFE);
	}
}

//Function Number: 36
func_AEE8(param_00)
{
	self endon("death");
	self endon("change_state");
	self notify("drone_move_z");
	self endon("drone_move_z");
	var_01 = 0.05;
	for(;;)
	{
		if(isdefined(self.var_AFEC) && param_00 > 0)
		{
			if(func_9B69())
			{
				var_02 = anglestoup(self.angles);
				var_03 = scripts\common\trace::func_DCED(self.origin + var_02 * 40,self.origin + var_02 * -40,self,scripts\common\trace::func_4956(1));
				if(var_03["hittype"] != "hittype_none")
				{
					self.origin = var_03["position"];
				}
			}
			else
			{
				var_04 = self.var_AFEC[2] - self.origin[2];
				var_05 = distance2d(self.var_AFEC,self.origin);
				var_06 = var_05 / param_00;
				if(var_06 > 0 && var_04 != 0)
				{
					var_07 = abs(var_04) / var_06;
					var_08 = var_07 * var_01;
					if(var_04 >= var_07)
					{
						self.origin = (self.origin[0],self.origin[1],self.origin[2] + var_08);
					}
					else if(var_04 <= var_07 * -1)
					{
						self.origin = (self.origin[0],self.origin[1],self.origin[2] - var_08);
					}
				}
			}
		}

		wait(var_01);
	}
}

//Function Number: 37
func_F31D(param_00)
{
	if(isdefined(self.var_4B94))
	{
		self.var_4B94 lib_0B2D::func_6B36(self);
	}

	self.var_72A9 = undefined;
	self.var_4B94 = param_00;
	func_F2C3(self.var_4B94 lib_0B2D::func_6B1F());
}

//Function Number: 38
func_1164B(param_00)
{
	func_F31D(param_00);
	self.var_4B94 lib_0B2D::func_6B37(self);
	func_6B12(self.var_4B94);
	self dontinterpolate();
	self.origin = self.var_4B94.origin;
	self.angles = self.var_4B94 lib_0B2D::func_6B1E(func_9BE8());
}

//Function Number: 39
func_416B()
{
	if(isdefined(self.var_C039))
	{
		foreach(var_01 in self.var_C039)
		{
			if(isdefined(var_01["node"]))
			{
				var_01["node"] lib_0B2D::func_6B36(self);
			}
		}
	}
}

//Function Number: 40
func_FF45()
{
	if(self.var_1FD0 == "exposed")
	{
		return 0;
	}

	if(isdefined(self.var_1A2C))
	{
		return func_9CE3();
	}

	return 1;
}

//Function Number: 41
func_6D53(param_00)
{
	self endon("death");
	childthread func_1A2E();
	wait(0.25);
	var_01 = weaponclipsize(self.var_394);
	var_02 = function_0240(self.var_394);
	var_03 = function_023C(self.var_394);
	var_04 = weaponclass(self.var_394);
	var_05 = var_01;
	if(var_04 == "sniper")
	{
		var_05 = 5;
	}
	else if(var_03 > 0)
	{
		var_05 = var_03;
	}

	while(var_05 > 0)
	{
		if(func_FF45())
		{
			var_06 = self gettagorigin("tag_flash");
			var_07 = self gettagangles("tag_flash");
			var_08 = anglestoforward(var_07);
			var_09 = var_06 + var_08 * 1000;
			if(isdefined(self.var_1A2C))
			{
				var_0A = scripts\common\trace::func_DCED(var_06,var_09,self);
				if(isdefined(var_0A["entity"]) && var_0A["entity"] == self.var_1A2C)
				{
					var_0B = func_77C8();
					if(randomfloat(1) > var_0B)
					{
						var_0C = self.var_1A2C method_8435();
						var_0D = anglestoup(self.var_1A2C.angles);
						var_0E = randomfloatrange(0,var_0C["half_height"] * 2);
						var_0F = anglestoright(self.var_1A2C.angles);
						var_10 = var_0C["radius"] * randomfloatrange(1,2);
						if(scripts\common\utility::func_4347())
						{
							var_10 = var_10 * -1;
						}

						var_11 = self.var_1A2C.origin + var_0D * var_0E + var_0F * var_10;
						var_08 = vectornormalize(var_11 - var_06);
						var_09 = var_06 + var_08 * 1000;
					}
				}
			}

			if(func_FF81())
			{
				magicbullet(self.var_394,var_06,var_09);
			}
			else
			{
				func_6ADC(self.var_394,var_06,var_09,self.var_C01E);
			}

			self method_82AB(param_00,1,0.2,1);
			scripts\common\utility::delaycall(0.15,::method_806F,param_00,0);
		}

		var_05--;
		wait(max(var_02,0.1));
	}
}

//Function Number: 42
func_77C8(param_00)
{
	var_01 = self.var_2894;
	var_02 = 1;
	if(isdefined(self.var_1A2C) && isdefined(self.var_1A2C.var_50))
	{
		var_02 = self.var_1A2C.var_50;
	}

	var_03 = distance(self.origin,self.var_1A2C.origin);
	var_04 = function_02A0(self.var_394,var_03,isplayer(self.var_1A2C));
	var_05 = "stand";
	if(isplayer(self.var_1A2C))
	{
		var_05 = self.var_1A2C getstance();
	}
	else if(isai(self.var_1A2C))
	{
		var_05 = self.var_1A2C.var_1491.var_D6A5;
	}

	var_06 = 1;
	if(var_05 == "crouch")
	{
		var_06 = 0.75;
	}
	else if(var_05 == "prone")
	{
		var_06 = 0.5;
	}

	var_07 = 1;
	if(isplayer(self.var_1A2C))
	{
		var_08 = level.player getnormalizedmovement();
		var_07 = 1 - length(var_08) * 0.3;
	}
	else if(isai(self.var_1A2C))
	{
	}

	var_09 = 0.75;
	var_0A = var_01 * var_02 * var_04 * var_06 * var_07 * var_09;
	return var_0A;
}

//Function Number: 43
func_6ADC(param_00,param_01,param_02,param_03)
{
	function_002F(param_01,param_02,param_00);
	playfxontag(scripts\common\utility::getfx("fakeactor_muzflash"),self,"tag_flash");
	if(!isdefined(param_03) || !param_03)
	{
	}
}

//Function Number: 44
func_7CDD(param_00)
{
	if(isplayer(param_00))
	{
		if(func_9C07())
		{
			var_01 = 50;
		}
		else
		{
			var_01 = 50;
		}

		var_02 = param_00 getplayerangles();
		var_03 = param_00 getorigin() + anglestoup(var_02) * var_01;
		return var_03;
	}

	if(isai(var_03))
	{
		return var_03 gettagorigin("j_SpineUpper");
	}

	var_03 = var_03.origin;
	if(isdefined(self.var_1A2D))
	{
		var_03 = var_03 + self.var_1A2D;
	}

	return var_03;
}

//Function Number: 45
func_1A2E()
{
	self endon("end_aim");
	var_00 = 0.2;
	var_01 = func_77E7("aim_5");
	if(isdefined(var_01))
	{
		self method_82A5(var_01,self.var_1EA4["body"],1,var_00);
	}

	self method_82AC(func_77E7("aim_2"),1,var_00);
	self method_82AC(func_77E7("aim_4"),1,var_00);
	self method_82AC(func_77E7("aim_6"),1,var_00);
	self method_82AC(func_77E7("aim_8"),1,var_00);
	var_02 = 10;
	var_03 = 0;
	var_04 = 0;
	var_05 = 1;
	while(isdefined(self.var_1A2C))
	{
		var_06 = self gettagorigin("tag_flash");
		var_07 = func_7CDD(self.var_1A2C);
		var_08 = scripts\sp\_utility::func_13DCC(var_07) - scripts\sp\_utility::func_13DCC(var_06);
		var_09 = vectortoangles(var_08);
		var_0A = angleclamp180(var_09[0]);
		var_0B = angleclamp180(var_09[1]);
		if(var_0A < self.var_368 || var_0A > self.var_100 || var_0B < self.var_268 || var_0B > self.var_1B7)
		{
			func_F5BF(0);
			var_0A = 0;
			var_0B = 0;
		}
		else
		{
			func_F5BF(1);
		}

		if(getdvar("debug_fakeactor") == "1")
		{
			var_0C = self gettagangles("tag_origin");
			scripts\common\utility::func_5B20(var_0C,self gettagorigin("tag_origin"));
		}

		if(!var_05)
		{
			var_0D = var_0B - var_03;
			if(abs(var_0D) > var_02)
			{
				var_0B = var_03 + clamp(var_0D,-1 * var_02,var_02);
			}

			var_0E = var_0A - var_04;
			if(abs(var_0E) > var_02)
			{
				var_0A = var_04 + clamp(var_0E,-1 * var_02,var_02);
			}
		}

		var_0A = clamp(var_0A,self.var_368,self.var_100);
		var_0B = clamp(var_0B,self.var_268,self.var_1B7);
		var_05 = 0;
		var_03 = var_0B;
		var_04 = var_0A;
		func_1A31(self.var_1EA4["aim_2"],self.var_1EA4["aim_4"],self.var_1EA4["aim_6"],self.var_1EA4["aim_8"],var_0A,var_0B);
		wait(0.05);
	}
}

//Function Number: 46
func_7821(param_00,param_01,param_02,param_03)
{
	var_04 = archetypegetalias(param_00,param_01,param_02,param_03);
	if(isdefined(var_04))
	{
		if(isarray(var_04.var_47))
		{
			if(isdefined(var_04.var_39E))
			{
				var_05 = randomfloat(1);
				var_06 = 0;
				for(var_07 = 0;var_07 < var_04.var_47.size;var_07++)
				{
					var_06 = var_06 + var_04.var_39E[var_07];
					if(var_06 >= var_05)
					{
						return var_04.var_47[var_07];
					}
				}

				return;
			}

			var_05 = randomint(var_07.var_47.size);
			return var_06.var_47[var_07];
		}

		return var_07.var_47;
	}
}

//Function Number: 47
func_7820(param_00,param_01)
{
	var_02 = func_7821(self.var_1FA8,param_00,param_01,func_9BE8());
	if(isarray(var_02))
	{
		var_02 = scripts\common\utility::random(var_02);
	}

	return var_02;
}

//Function Number: 48
func_7A2A()
{
	if(isdefined(self.var_92D2))
	{
		return self.var_92D2;
	}

	if(scripts\common\utility::func_4347())
	{
		if(self.var_1FD0 == "exposed")
		{
			if(self.var_1FA8 == "zero_gravity")
			{
				return func_7820("NonCombat_Stand_Idle","noncombat_stand_idle");
			}

			return func_7820("noncombat_stand_idle","noncombat_stand_idle");
		}

		return func_7820(self.var_1FD0,"hide_loop");
	}

	switch(self.var_1FD0)
	{
		case "cover_right_crouch":
		case "cover_left":
		case "cover_right":
			return func_7820(self.var_1FD0,"hide_loop");

		case "exposed":
			return func_7820("noncombat_stand_idle","noncombat_stand_idle_twitch");

		case "cover_left_crouch":
		case "cover_stand":
		case "cover_crouch":
			return func_7820(self.var_1FD0 + "_peek","peek");
	}
}

//Function Number: 49
func_7AFA()
{
	if(isdefined(self.var_E7DA))
	{
		return self.var_E7DA;
	}

	return func_7820("stand_run_loop","default");
}

//Function Number: 50
func_7D21(param_00,param_01,param_02)
{
	var_03 = vectortoangles(param_02 - param_01);
	var_04 = param_00[1] - var_03[1];
	var_04 = var_04 + 360;
	var_04 = int(var_04) % 360;
	var_05 = "";
	if(var_04 > 315 || var_04 < 45)
	{
		return undefined;
	}
	else if(var_04 >= 150 && var_04 <= 210)
	{
		var_05 = "2";
	}
	else if(var_04 < 90)
	{
		var_05 = "9";
	}
	else if(var_04 > 270)
	{
		var_05 = "7";
	}
	else if(var_04 < 135)
	{
		var_05 = "6";
	}
	else if(var_04 > 225)
	{
		var_05 = "4";
	}
	else if(var_04 < 150)
	{
		var_05 = "3";
	}
	else if(var_04 > 210)
	{
		var_05 = "1";
	}

	return func_7820("run_turn","left" + var_05);
}

//Function Number: 51
func_7C63()
{
	switch(self.var_1FD0)
	{
		case "cover_left_crouch":
		case "cover_right_crouch":
		case "cover_crouch":
			return func_7820("crouch_shoot_full","fire");

		case "cover_stand":
		case "cover_left":
		case "cover_right":
			return func_7820("shoot_full","fire");

		case "exposed":
			return func_7820("shoot_full","fire");
	}
}

//Function Number: 52
func_77E7(param_00)
{
	switch(self.var_1FD0)
	{
		case "cover_crouch":
			return func_7820("cover_crouch_aim","rifle_" + param_00);

		case "cover_left_crouch":
			if(param_00 == "aim_5")
			{
				return undefined;
			}
			return func_7820("cover_crouch_exposed_left","rifle_" + param_00);

		case "cover_right_crouch":
			if(param_00 == "aim_5")
			{
				return undefined;
			}
			return func_7820("cover_crouch_exposed_right","rifle_" + param_00);

		case "cover_stand":
			return func_7820("cover_stand_exposed","rifle_" + param_00);

		case "cover_left":
			if(param_00 == "aim_5")
			{
				return undefined;
			}
			return func_7820("cover_left_exposed_B","rifle_" + param_00);

		case "cover_right":
			if(param_00 == "aim_5")
			{
				return undefined;
			}
			return func_7820("cover_right_exposed_B","rifle_" + param_00);

		case "exposed":
			return func_7820("exposed_idle","rifle_" + param_00);
	}
}

//Function Number: 53
func_7A04()
{
	switch(self.var_1FD0)
	{
		case "cover_crouch":
			return func_7820("cover_crouch_hide_to_aim","hide_to_aim");

		case "cover_stand":
			return func_7820("cover_stand_hide_to_exposed","hide_to_exposed");

		case "cover_left":
			return func_7820("cover_left_hide_to_B","hide_to_exposed");

		case "cover_right":
			return func_7820("cover_right_hide_to_B","hide_to_exposed");

		case "cover_left_crouch":
			return func_7820("cover_left_crouch_hide_to_B","hide_to_B");

		case "cover_right_crouch":
			return func_7820("cover_right_crouch_hide_to_B","hide_to_B");
	}

	return undefined;
}

//Function Number: 54
func_77E9()
{
	switch(self.var_1FD0)
	{
		case "cover_crouch":
			return func_7820("cover_crouch_aim_to_hide","aim_to_hide");

		case "cover_stand":
			return func_7820("cover_stand_exposed_to_hide","exposed_to_hide");

		case "cover_left":
			return func_7820("cover_left_B_to_hide","exposed_to_hide");

		case "cover_right":
			return func_7820("cover_right_B_to_hide","exposed_to_hide");

		case "cover_left_crouch":
			return func_7820("cover_left_crouch_B_to_hide","B_to_hide");

		case "cover_right_crouch":
			return func_7820("cover_right_crouch_B_to_hide","B_to_hide");
	}

	return undefined;
}

//Function Number: 55
func_7836(param_00,param_01,param_02)
{
	if(!isdefined(param_02))
	{
		param_02 = self.var_1FD0;
	}

	if(!isdefined(param_01))
	{
		param_01 = self;
	}

	var_03 = param_02 + "_arrival";
	var_04 = scripts\sp\_utility::func_793C(param_00.angles,param_00.origin,param_01.origin);
	switch(param_02)
	{
		case "cover_crouch":
			if(var_04 == "9")
			{
				var_04 = "6";
			}
			else if(var_04 == "7" || var_04 == "8")
			{
				var_04 = "4";
			}
			break;

		case "cover_stand":
			if(var_04 == "9")
			{
				var_04 = "6";
			}
			else if(var_04 == "7" || var_04 == "8")
			{
				var_04 = "4";
			}
			break;

		case "cover_left":
			if(var_04 == "9")
			{
				var_04 = "8";
			}
			break;

		case "cover_right":
			if(var_04 == "7")
			{
				var_04 = "8";
			}
			break;

		case "cover_left_crouch":
			if(var_04 == "9")
			{
				var_04 = "8";
			}
			break;

		case "cover_right_crouch":
			if(var_04 == "7")
			{
				var_04 = "8";
			}
			break;

		case "exposed":
			break;

		default:
			return undefined;
	}

	if(func_9C07())
	{
		var_05 = "left" + var_04;
	}
	else
	{
		var_05 = var_05;
	}

	return func_7820(var_03,var_05);
}

//Function Number: 56
func_79A4(param_00,param_01,param_02,param_03)
{
	if(!isdefined(param_01))
	{
		param_01 = self.origin;
	}

	if(!isdefined(param_02))
	{
		param_02 = self.angles;
	}

	if(!isdefined(param_03))
	{
		param_03 = self.var_1FD0;
	}

	var_04 = param_03 + "_exit";
	var_05 = scripts\sp\_utility::func_793C(param_02,param_01,param_00);
	switch(param_03)
	{
		case "cover_crouch":
			if(var_05 == "9")
			{
				var_05 = "6";
			}
			else if(var_05 == "7" || var_05 == "8")
			{
				var_05 = "4";
			}
			return func_7820(var_04,var_05);

		case "cover_stand":
			if(var_05 == "9")
			{
				var_05 = "6";
			}
			else if(var_05 == "7" || var_05 == "8")
			{
				var_05 = "4";
			}
			return func_7820(var_04,var_05);

		case "cover_left":
			if(var_05 == "9")
			{
				var_05 = "8";
			}
			return func_7820(var_04,var_05);

		case "cover_right":
			if(var_05 == "7")
			{
				var_05 = "8";
			}
			return func_7820(var_04,var_05);

		case "cover_left_crouch":
			if(var_05 == "9")
			{
				var_05 = "8";
			}
			return func_7820(var_04,var_05);

		case "cover_right_crouch":
			if(var_05 == "7")
			{
				var_05 = "8";
			}
			return func_7820(var_04,var_05);

		case "exposed":
			return func_7820(var_04,var_05);

		default:
			return undefined;
	}
}

//Function Number: 57
func_7C03()
{
	if(self.var_1FD0 == "exposed")
	{
		return func_7820("Exposed_Reload","rifle");
	}

	var_00 = self.var_1FD0 + "_reload";
	return func_7820(var_00,"reload");
}

//Function Number: 58
func_7C9F()
{
	switch(self.var_1FD0)
	{
		case "cover_crouch":
			return func_7820("exposed_stand_to_crouch","stand_to_crouch");

		case "cover_stand":
			return func_7820("exposed_crouch_to_stand","crouch_to_stand");

		case "cover_left":
			return func_7820("cover_left_crouch_to_stand","crouch_to_stand");

		case "cover_left_crouch":
			return func_7820("cover_left_stand_to_crouch","stand_to_crouch");

		case "cover_right":
			return func_7820("cover_right_crouch_to_stand","crouch_to_stand");

		case "cover_right_crouch":
			return func_7820("cover_right_stand_to_crouch","stand_to_crouch");
	}

	return undefined;
}

//Function Number: 59
func_7B62()
{
	if(func_9C44())
	{
		var_00 = scripts\common\utility::func_116D7(scripts\common\utility::func_4347(),"short","medium");
		return func_7820("pain_run_default",var_00);
	}

	switch(self.var_1FD0)
	{
		case "cover_crouch":
			return func_7820("pain_cover_crouch_default","crouch");

		case "cover_stand":
			return func_7820("pain_cover_stand_default","stand");

		case "cover_left":
			return func_7820("pain_cover_left_default","stand");

		case "cover_right":
			return func_7820("pain_cover_right_default","stand");

		case "cover_left_crouch":
			return func_7820("pain_cover_left_default","crouch");

		case "cover_right_crouch":
			return func_7820("pain_cover_right_default","crouch");

		default:
			return func_7820("pain_stand_torso","default");
	}
}

//Function Number: 60
func_7927()
{
	if(isdefined(self.var_A8A3) && self.var_A8A3 == "MOD_EXPLOSIVE")
	{
		var_00 = scripts\common\utility::random(["explosive_f","explosive_l","explosive_r"]);
		if(func_9C44())
		{
			return func_7820("death_moving_explosive",var_00);
		}

		return func_7820("death_explosive",var_00);
	}

	if(func_9C44())
	{
		if(scripts\common\utility::func_4347())
		{
			var_00 = scripts\common\utility::random(["death_pain_stand_head","death_pain_stand_l_arm","death_pain_stand_r_arm","death_pain_stand_torso"]);
			return func_7820(var_00,"default");
		}

		var_01 = scripts\common\utility::random(["running_forward_2","running_forward_4","running_forward_6","running_forward_8"]);
		return func_7820("death_moving_default",var_01);
	}

	switch(self.var_1FD0)
	{
		case "cover_crouch":
			return func_7820("death_cover_default","crouch_default");

		case "cover_stand":
			return func_7820("death_cover_default","stand");

		case "cover_left":
			return func_7820("death_cover_default","left_stand");

		case "cover_right":
			return func_7820("death_cover_default","right_stand");

		case "cover_left_crouch":
			return func_7820("death_cover_default","left_crouch");

		case "cover_right_crouch":
			return func_7820("death_cover_default","right_crouch_default");

		default:
			var_00 = scripts\common\utility::random(["death_pain_stand_head","death_pain_stand_l_arm","death_pain_stand_r_arm","death_pain_stand_torso"]);
			return func_7820(var_01,"default");
	}
}

//Function Number: 61
func_7D19(param_00)
{
	if(issubstr(param_00,"jumpdown"))
	{
		return func_7820(param_00,"jumpdown");
	}

	if(issubstr(param_00,"jumpover"))
	{
		return func_7820(param_00,"jumpover");
	}

	if(issubstr(param_00,"jumpup"))
	{
		return func_7820(param_00,"jumpup");
	}

	return func_7820(param_00,param_00);
}

//Function Number: 62
func_4E22()
{
	self endon("entitydeleted");
	func_4D23();
	if(!isdefined(self))
	{
		return;
	}

	func_416B();
	if(isdefined(self.var_4E46))
	{
		var_00 = self [[ self.var_4E46 ]]();
		if(!isdefined(var_00) || var_00)
		{
			return;
		}
	}

	var_01 = self.var_4E2A;
	if(!isdefined(var_01))
	{
		var_01 = func_7927();
	}

	self notify("death");
	func_40C8();
	func_5D16();
	scripts\anim\face::func_EB83("death");
	if(isdefined(self.var_C089) && self.var_C089)
	{
		if(!isdefined(self.var_10265) || !self.var_10265)
		{
			func_CE00(var_01,"deathplant");
		}
	}
	else if(isdefined(self.var_10265) && self.var_10265)
	{
		self method_839A();
	}
	else
	{
		func_CE00(var_01,"deathplant");
		self method_839A();
	}

	self notsolid();
	if(isdefined(self) && isdefined(self.var_C027))
	{
		return;
	}

	wait(10);
	while(isdefined(self))
	{
		self delete();
		wait(5);
	}
}

//Function Number: 63
func_5D16()
{
	var_00 = function_00EA(self.var_394);
	if(isdefined(var_00) && var_00 != "")
	{
		self detach(var_00,"tag_weapon_right");
		if(!isdefined(self.var_C05C))
		{
			var_01 = spawn("weapon_" + self.var_394,self gettagorigin("tag_weapon_right"));
			var_01.angles = self gettagangles("tag_weapon_right");
			func_ACDC(var_01);
		}
	}
}

//Function Number: 64
func_ACDC(param_00)
{
	if(!isdefined(level.var_6B13))
	{
		level.var_6B13 = [];
	}

	var_01 = scripts\common\utility::func_22BC(level.var_6B13);
	var_02 = var_01.size;
	if(var_01.size >= 4)
	{
		var_01 = sortbydistance(var_01,level.player.origin);
		var_02 = var_02 - 1;
		var_01[var_02] delete();
	}

	var_01[var_02] = param_00;
	level.var_6B13 = var_01;
}

//Function Number: 65
func_4D23()
{
	self endon("entitydeleted");
	for(;;)
	{
		self waittill("damage",var_00,var_01,var_02,var_03,var_04);
		self.var_A8A3 = var_04;
		if(isdefined(var_01) && isplayer(var_01))
		{
			var_01 setclientomnvar("damage_feedback_notify",gettime());
		}

		if(isdefined(self.var_E0) && self.var_E0)
		{
			self.health = 100000;
			continue;
		}

		if(self.health <= 0)
		{
			break;
		}

		scripts\anim\face::func_EB83("pain");
		if(!func_13903() && func_FF35())
		{
			thread func_57AD();
		}
	}
}

//Function Number: 66
func_57AD()
{
	self notify("change_state");
	self notify("stop_damage_pain_anim");
	self endon("stop_damage_pain_anim");
	self endon("death");
	func_F56C(1);
	scripts\common\utility::func_5127(1.5,::func_F56C,0);
	func_416B();
	func_CE00(func_7B62());
	self.var_4BBE = "";
	self.var_72A9 = lib_0B2D::func_6B21(self.var_4B94,self.origin,func_9BE8(),1);
}

//Function Number: 67
func_4EC6()
{
}

//Function Number: 68
func_2294(param_00)
{
	var_01 = param_00.team;
	scripts\sp\_utility::func_11161(level.var_6B46[var_01],param_00);
	param_00 waittill("death");
	param_00 func_40C8();
	if(isdefined(param_00) && isdefined(param_00.var_11159))
	{
		scripts\sp\_utility::func_11163(level.var_6B46[var_01],param_00.var_11159);
		return;
	}

	scripts\sp\_utility::func_11164(level.var_6B46[var_01]);
}

//Function Number: 69
func_CD83(param_00,param_01)
{
	if(!isdefined(param_01))
	{
		param_01 = 1;
	}

	if(isdefined(self.var_6B17))
	{
		self [[ self.var_6B17 ]](param_00,param_01);
		return;
	}

	self method_806F(self.var_1EA4["body"],0.2);
	self method_83A1();
	self method_82E4("fakeactor_anim",param_00,self.var_1EA4["body"],1,0.2,param_01);
}

//Function Number: 70
func_CE00(param_00,param_01,param_02,param_03,param_04,param_05)
{
	if(isdefined(self.var_6B41))
	{
		self [[ self.var_6B41 ]](param_00,param_01);
		return;
	}

	self method_806F(self.var_1EA4["body"],0.2);
	self method_83A1();
	var_06 = "normal";
	if(isdefined(param_01))
	{
		var_06 = "deathplant";
	}

	var_07 = self.origin;
	var_08 = self.angles;
	if(isdefined(param_04))
	{
		var_07 = param_04.origin;
		var_08 = param_04.angles;
	}

	if(!isdefined(param_05))
	{
		param_05 = 0.2;
	}

	self method_8018("fakeactor_anim",var_07,var_08,param_00,var_06);
	if(isdefined(param_02))
	{
		thread scripts\anim\shared::func_592B(param_03,param_02);
	}

	var_09 = "end";
	if(animhasnotetrack(param_00,"finish"))
	{
		var_09 = "finish";
	}
	else if(animhasnotetrack(param_00,"stop anim"))
	{
		var_09 = "stop anim";
	}

	var_0A = getanimlength(param_00) - param_05;
	if(param_05 > 0 && var_0A > 0)
	{
		scripts\sp\_utility::func_137A3("fakeactor_anim",var_09,var_0A);
		return;
	}

	self waittillmatch(var_09,"fakeactor_anim");
}

//Function Number: 71
func_7816(param_00)
{
	var_01 = spawnstruct();
	var_01.var_1F5A = getanimlength(param_00);
	var_02 = getmovedelta(param_00,0,1);
	var_03 = length(var_02);
	if(var_01.var_1F5A > 0 && var_03 > 0)
	{
		var_01.var_E81C = var_03 / var_01.var_1F5A;
		var_01.var_1F1D = 0;
	}
	else
	{
		var_01.var_E81C = 170;
		var_01.var_1F1D = 1;
	}

	return var_01;
}

//Function Number: 72
func_F297(param_00,param_01)
{
	self.var_1A2C = param_00;
	self.var_1A2D = param_01;
}

//Function Number: 73
func_77E8()
{
	return self.var_1A2C;
}

//Function Number: 74
func_13924()
{
	self endon("death");
	for(;;)
	{
		if(isai(self.var_1A2C) && !isalive(self.var_1A2C))
		{
			func_F297(undefined);
		}

		wait(0.05);
	}
}

//Function Number: 75
func_9C07()
{
	return self.var_12BA4 == "C6i" || self.var_12BA4 == "soldier" || self.var_12BA4 == "civilian";
}

//Function Number: 76
func_F8BE()
{
	scripts\sp\_utility::func_23B9();
	switch(self.var_12BA4)
	{
		case "C6":
			func_F8EE();
			break;

		case "C8":
			func_F8F1();
			break;

		case "C6i":
		case "soldier":
		case "civilian":
			func_F98E();
			break;

		case "C12":
			break;

		default:
			break;
	}
}

//Function Number: 77
func_F98E()
{
	self.var_1EA4["root"] = %root;
	self.var_1EA4["body"] = %body;
	self.var_1EA4["aim_2"] = %aim_2;
	self.var_1EA4["aim_4"] = %aim_4;
	self.var_1EA4["aim_6"] = %aim_6;
	self.var_1EA4["aim_8"] = %aim_8;
}

//Function Number: 78
func_F8EE()
{
	self.var_1EA4["root"] = %root;
	self.var_1EA4["body"] = %body;
	self.var_1EA4["aim_2"] = %aim_2;
	self.var_1EA4["aim_4"] = %aim_4;
	self.var_1EA4["aim_6"] = %aim_6;
	self.var_1EA4["aim_8"] = %aim_8;
}

//Function Number: 79
func_F8F1()
{
	self.var_1EA4["root"] = %root;
	self.var_1EA4["body"] = %body;
	self.var_1EA4["aim_2"] = %aim_2;
	self.var_1EA4["aim_4"] = %aim_4;
	self.var_1EA4["aim_6"] = %aim_6;
	self.var_1EA4["aim_8"] = %aim_8;
}

//Function Number: 80
func_1A31(param_00,param_01,param_02,param_03,param_04,param_05)
{
	var_06 = 0.1;
	var_07 = 1;
	if(param_05 < 0)
	{
		var_08 = param_05 / self.var_268 * var_07;
		self method_82AC(param_01,0,var_06,1,1);
		self method_82AC(param_02,var_08,var_06,1,1);
	}
	else if(param_05 > 0)
	{
		var_08 = param_05 / self.var_1B7 * var_07;
		self method_82AC(param_01,var_08,var_06,1,1);
		self method_82AC(param_02,0,var_06,1,1);
	}

	if(param_04 < 0)
	{
		var_08 = param_04 / self.var_368 * var_07;
		self method_82AC(param_00,0,var_06,1,1);
		self method_82AC(param_03,var_08,var_06,1,1);
		return;
	}

	if(param_04 > 0)
	{
		var_08 = param_04 / self.var_100 * var_07;
		self method_82AC(param_00,var_08,var_06,1,1);
		self method_82AC(param_03,0,var_06,1,1);
	}
}

//Function Number: 81
func_F2C3(param_00)
{
	self.var_1FD1 = param_00;
	func_CB1F();
}

//Function Number: 82
func_CB1F()
{
	var_00 = randomint(self.var_1FD1.size);
	self.var_1FD0 = self.var_1FD1[var_00];
}

//Function Number: 83
func_F584(param_00)
{
	self.var_E7DA = param_00;
}

//Function Number: 84
func_417B()
{
	self.var_E7DA = undefined;
}

//Function Number: 85
func_F40F(param_00)
{
	self.var_92D2 = param_00;
}

//Function Number: 86
func_415E()
{
	self.var_92D2 = undefined;
}

//Function Number: 87
func_9C08()
{
	return self.var_4BBE == "idle";
}

//Function Number: 88
func_9C44()
{
	return self.var_4BBE == "move";
}

//Function Number: 89
func_9BA1()
{
	return self.var_134 & 256;
}

//Function Number: 90
func_F30A(param_00)
{
	if(param_00)
	{
		self.var_134 = self.var_134 | 256;
		return;
	}

	self.var_134 = self.var_134 & ~256;
}

//Function Number: 91
func_1142F()
{
	self notify("change_state");
	self.var_D88C = self.var_4B94;
	func_416B();
	self.var_C039 = undefined;
	func_F30A(1);
}

//Function Number: 92
func_DF38(param_00)
{
	func_F30A(0);
	if(isdefined(param_00))
	{
		func_F31D(param_00);
		func_F613(1);
	}
	else if(isdefined(self.var_D88C))
	{
		func_F31D(self.var_D88C);
		func_F613(1);
		self.var_D88C = undefined;
	}

	self.var_4BBE = undefined;
}

//Function Number: 93
func_F35C(param_00)
{
	if(param_00)
	{
		self.var_134 = self.var_134 | 8;
		return;
	}

	self.var_134 = self.var_134 & ~8;
}

//Function Number: 94
func_FF2C()
{
	return self.var_134 & 8;
}

//Function Number: 95
func_F35D(param_00)
{
	if(param_00)
	{
		self.var_134 = self.var_134 | 16;
		return;
	}

	self.var_134 = self.var_134 & ~16;
}

//Function Number: 96
func_FF2F()
{
	if(isdefined(self.var_D8A6))
	{
		if(self.var_D8A6 == "traverse" || self.var_D8A6 == "turn")
		{
			return 0;
		}
	}

	return self.var_134 & 16;
}

//Function Number: 97
func_F2C6(param_00)
{
	if(param_00)
	{
		self.var_134 = self.var_134 | 4;
		return;
	}

	self.var_134 = self.var_134 & ~4;
}

//Function Number: 98
func_9B69()
{
	return self.var_134 & 4;
}

//Function Number: 99
func_F613(param_00)
{
	if(param_00)
	{
		self.var_134 = self.var_134 | 2;
		return;
	}

	self.var_134 = self.var_134 & ~2;
}

//Function Number: 100
func_582B()
{
	return self.var_134 & 2;
}

//Function Number: 101
func_F5BF(param_00)
{
	if(param_00)
	{
		self.var_134 = self.var_134 | 1;
		return;
	}

	self.var_134 = self.var_134 & ~1;
}

//Function Number: 102
func_9CE3()
{
	return self.var_134 & 1;
}

//Function Number: 103
func_F568(param_00)
{
	if(param_00)
	{
		self.var_134 = self.var_134 | 32;
		return;
	}

	self.var_134 = self.var_134 & ~32;
}

//Function Number: 104
func_FF81()
{
	return self.var_134 & 32;
}

//Function Number: 105
func_F410(param_00)
{
	if(param_00)
	{
		self.var_134 = self.var_134 | 64;
		return;
	}

	self.var_134 = self.var_134 & ~64;
}

//Function Number: 106
func_9C0B()
{
	return self.var_134 & 64;
}

//Function Number: 107
func_C2C9(param_00)
{
	if(param_00)
	{
		self.var_134 = self.var_134 | 128;
		return;
	}

	self.var_134 = self.var_134 & ~128;
}

//Function Number: 108
func_9C53()
{
	return self.var_134 & 128;
}

//Function Number: 109
func_FF35()
{
	return self.var_134 & 512;
}

//Function Number: 110
func_F5F9(param_00)
{
	if(param_00)
	{
		self.var_134 = self.var_134 | 512;
		return;
	}

	self.var_134 = self.var_134 & ~512;
}

//Function Number: 111
func_13903()
{
	return self.var_134 & 2048;
}

//Function Number: 112
func_F56C(param_00)
{
	if(param_00)
	{
		self.var_134 = self.var_134 | 2048;
		return;
	}

	self.var_134 = self.var_134 & ~2048;
}

//Function Number: 113
func_9BE8()
{
	return self.var_134 & 1024;
}

//Function Number: 114
func_F3BE(param_00)
{
	if(param_00)
	{
		self.var_134 = self.var_134 | 1024;
		return;
	}

	self.var_134 = self.var_134 & ~1024;
}

//Function Number: 115
func_12735(param_00)
{
	if(!isdefined(self.var_336))
	{
		return;
	}

	var_01 = getent("target",self.var_336);
	for(;;)
	{
		param_00 waittill("trigger",var_02);
		var_01 func_F613(1);
	}
}

//Function Number: 116
func_12736(param_00)
{
	if(!isdefined(param_00.var_336))
	{
		return;
	}

	var_01 = scripts\common\utility::getstructarray(param_00.var_336,"target");
	if(var_01.size == 0)
	{
		return;
	}

	for(;;)
	{
		param_00 waittill("trigger",var_02);
		foreach(var_04 in var_01)
		{
			var_04 lib_0B2D::func_6B38(1);
		}
	}
}

//Function Number: 117
func_12738(param_00)
{
	if(!isdefined(param_00.var_336))
	{
		return;
	}

	var_01 = scripts\common\utility::getstructarray(param_00.var_336,"target");
	if(var_01.size == 0)
	{
		return;
	}

	for(;;)
	{
		param_00 waittill("trigger",var_02);
		foreach(var_04 in var_01)
		{
			var_04 lib_0B2D::func_6B38(0);
		}
	}
}

//Function Number: 118
func_12739(param_00)
{
	if(!isdefined(param_00.var_EE79))
	{
		return;
	}

	for(;;)
	{
		param_00 waittill("trigger",var_01);
		lib_0B2D::func_6B24(param_00.var_EE79,0);
	}
}

//Function Number: 119
func_12737(param_00)
{
	if(!isdefined(param_00.var_EE79))
	{
		return;
	}

	for(;;)
	{
		param_00 waittill("trigger",var_01);
		lib_0B2D::func_6B24(param_00.var_EE79,1);
	}
}

//Function Number: 120
func_1273B(param_00)
{
	if(!isdefined(param_00.var_336))
	{
		return;
	}

	var_01 = scripts\common\utility::getstructarray(param_00.var_336,"target");
	if(var_01.size == 0)
	{
		return;
	}

	for(;;)
	{
		param_00 waittill("trigger",var_02);
		foreach(var_04 in var_01)
		{
			var_04 lib_0B2D::func_6B3A();
		}
	}
}

//Function Number: 121
func_1273A(param_00)
{
	if(!isdefined(param_00.var_336))
	{
		return;
	}

	var_01 = scripts\common\utility::getstructarray(param_00.var_336,"target");
	if(var_01.size == 0)
	{
		return;
	}

	for(;;)
	{
		param_00 waittill("trigger",var_02);
		foreach(var_04 in var_01)
		{
			var_04 lib_0B2D::func_6B39();
		}
	}
}

//Function Number: 122
func_9BFF(param_00,param_01)
{
	return param_00["priority"] < param_01["priority"];
}