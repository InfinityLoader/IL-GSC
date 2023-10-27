/*******************************************************************
 * Decompiled By: Bog
 * Decompiled File: 2590.gsc
 * Game: Call of Duty: Infinite Warfare
 * Platform: PC
 * Function Count: 80
 * Decompile Time: 24 ms
 * Timestamp: 10/27/2023 12:23:25 AM
*******************************************************************/

//Function Number: 1
func_234D(param_00,param_01)
{
	lib_0A1A::func_234E();
	if(param_01 == "hero_salter" || param_01 == "hero_boats")
	{
		lib_0A1B::func_2984(1);
	}

	self.var_2303 = spawnstruct();
	self.var_2303.var_2123 = param_01;
	self.var_2303.var_1FC5 = [];
	self.var_2303.var_7360 = 0;
	self.var_164D = [];
	self.var_238F = param_00;
	self.var_718D = ::func_230D;
	self.var_7195 = ::func_238D;
	self.var_718E = ::func_230E;
	self.var_718F = ::func_230F;
	self.var_7194 = ::func_2382;
	self.var_7193 = ::func_235B;
	self.var_7192 = ::func_2348;
	self.var_7191 = ::func_2336;
	self.var_7190 = ::func_2335;
	lib_0A1A::func_2351(param_00,1);
}

//Function Number: 2
func_2382(param_00,param_01)
{
	if(!isdefined(param_01.var_4E6D))
	{
		return 0;
	}

	return !isalive(self);
}

//Function Number: 3
func_12EE7(param_00)
{
	if(self.var_E0 && !isdefined(self.var_55BF))
	{
		var_01 = 1500;
		if(!isdefined(self.var_1491.var_A9C8))
		{
			self.var_1491.var_A9C8 = 0;
		}

		if(!isdefined(self.var_4D68) || gettime() - self.var_1491.var_A9C8 > var_01)
		{
			self.var_4D68 = randomintrange(2,3);
		}

		if(isdefined(self.var_1B1) && distancesquared(self.origin,self.var_1B1.origin) < squared(512))
		{
			self.var_4D68 = 0;
		}

		if(self.var_4D68 > 0)
		{
			self.var_4D68--;
		}
	}

	if(isdefined(param_00))
	{
		self.var_4D46 = param_00;
		return;
	}

	self.var_4D46 = undefined;
}

//Function Number: 4
func_1004C()
{
	if(isdefined(self.var_71D0))
	{
		return self [[ self.var_71D0 ]]();
	}

	return func_1004D();
}

//Function Number: 5
func_1004D()
{
	var_00 = 4096;
	if(self.var_1491.var_5605)
	{
		return 0;
	}

	if(isdefined(self.var_233) && self method_841E() < var_00)
	{
		return 0;
	}

	return 1;
}

//Function Number: 6
func_51B8()
{
	self endon("terminate_ai_threads");
	self waittill("entitydeleted");
	foreach(var_01 in self.var_164D)
	{
		var_02 = var_01.var_4BC0;
		self notify(var_02 + "_finished");
	}

	self notify("terminate_ai_threads");
}

//Function Number: 7
func_C879()
{
	if(1)
	{
		func_12EE7();
		if(!func_1004C())
		{
			if(isdefined(self.script) && self.script == "pain")
			{
				self notify("killanimscript");
			}

			return;
		}

		var_00 = 0;
		foreach(var_09, var_02 in self.var_164D)
		{
			var_03 = var_02.var_4BC0;
			var_04 = level.var_2303[var_09].var_10E2F[var_03];
			if(!isdefined(var_04.var_C87F))
			{
				continue;
			}

			var_05 = level.var_2303[var_09].var_10E2F[var_04.var_C87F];
			lib_0A1A::func_2388(var_09,var_03,var_04,var_04.var_116FB);
			var_06 = var_04.var_C87F;
			if(isdefined(var_05.var_C94B) && var_05.var_C94B)
			{
				var_07 = lib_0A1A::func_2310(var_09,var_04.var_C87F,1);
				var_06 = var_07[0];
				var_08 = var_07[1];
			}

			lib_0A1A::func_238A(var_09,var_06,0.05,undefined,undefined,var_04.var_C87C);
			if(isdefined(self.var_12BA4) && self.var_12BA4 == "c6")
			{
				self playsound("shield_death_c6_1");
			}

			var_00 = 1;
		}

		if(!var_00 && self.script == "pain")
		{
			self notify("killanimscript");
		}
	}

	self endon("killanimscript");
	self waittill("Hellfreezesover");
}

//Function Number: 8
func_126E5()
{
	self endon("death");
	self endon("terminate_ai_threads");
	for(;;)
	{
		self waittill("traverse_begin",var_00,var_01);
		if(1)
		{
			var_02 = self.var_238F;
			var_03 = level.var_2303[var_02];
			if(!func_234B(self.var_2303.var_2123,var_00))
			{
				var_00 = "traverse_external";
			}

			var_04 = self.var_164D[var_02].var_4BC0;
			var_05 = var_03.var_10E2F[var_04];
			if(var_04 == "traversal_orient")
			{
				continue;
			}

			lib_0A1A::func_2388(var_02,var_04,var_05,var_05.var_116FB);
			lib_0A1A::func_238A(var_02,var_00,0.2,undefined,undefined,undefined);
		}
	}
}

//Function Number: 9
func_111A9()
{
	self endon("death");
	self endon("terminate_ai_threads");
	for(;;)
	{
		self waittill("damage_subpart",var_00);
		foreach(var_02 in var_00)
		{
			func_12EE7(var_02.var_2CD);
			if(!func_1004C())
			{
				if(isdefined(self.script) && self.script == "pain")
				{
					self notify("killanimscript");
				}

				continue;
			}

			var_03 = 0;
			foreach(var_0C, var_05 in self.var_164D)
			{
				var_06 = var_05.var_4BC0;
				var_07 = level.var_2303[var_0C].var_10E2F[var_06];
				if(!isdefined(var_07.var_C87F))
				{
					continue;
				}

				var_08 = level.var_2303[var_0C].var_10E2F[var_07.var_C87F];
				lib_0A1A::func_2388(var_0C,var_06,var_07,var_07.var_116FB);
				var_09 = var_07.var_C87F;
				if(isdefined(var_08.var_C94B) && var_08.var_C94B)
				{
					var_0A = lib_0A1A::func_2310(var_0C,var_07.var_C87F,1);
					var_09 = var_0A[0];
					var_0B = var_0A[1];
				}

				lib_0A1A::func_238A(var_0C,var_09,0.05,undefined,undefined,var_07.var_C87C);
				var_03 = 1;
			}

			if(!var_03 && self.script == "pain")
			{
				self notify("killanimscript");
			}
		}
	}
}

//Function Number: 10
func_237F(param_00)
{
	switch(param_00)
	{
		case "face node":
			var_01 = 1024;
			if(scripts\common\utility::func_167E())
			{
				var_02 = self.angles;
				if(isdefined(self.var_205) && distancesquared(self.origin,self.var_205.origin) < var_01)
				{
					var_02 = scripts\asm\shared_utility::func_7FF6(self.var_205);
				}
	
				self method_8221("face angle 3d",var_02);
			}
			else
			{
				var_03 = self.angles[1];
				if(isdefined(self.var_205) && distancesquared(self.origin,self.var_205.origin) < var_01)
				{
					var_03 = scripts\asm\shared_utility::func_7FF7(self.var_205);
				}
	
				self method_8221("face angle",var_03);
			}
			break;

		case "face current":
			self method_8221("face angle 3d",self.angles);
			break;

		default:
			self method_8221(param_00);
			break;
	}
}

//Function Number: 11
func_237E(param_00)
{
	self method_8016(param_00,0);
}

//Function Number: 12
func_230E(param_00,param_01)
{
	if(lib_0A1A::func_231B(param_00,"gesture"))
	{
		func_2381(param_00,param_01);
	}
}

//Function Number: 13
func_238D(param_00)
{
	if(isdefined(param_00.var_10B53) && param_00.var_10B53 != "")
	{
		if(param_00.var_10B53 != "prone" && self.var_1491.var_D6A5 != param_00.var_10B53)
		{
			scripts\anim\utility::func_697B(1);
		}

		self.var_1491.var_D6A5 = param_00.var_10B53;
		lib_0A1B::func_296A(param_00.var_10B53);
	}
}

//Function Number: 14
func_230D(param_00,param_01,param_02,param_03)
{
	if(lib_0A1A::func_231B(param_00,"aim"))
	{
		func_2380(param_00,param_02,param_03);
	}
}

//Function Number: 15
func_2326(param_00,param_01,param_02,param_03,param_04)
{
	var_05 = param_01;
	if(isdefined(param_04))
	{
		var_05 = param_04;
	}

	self waittill(var_05,var_06);
	if(!isdefined(var_06))
	{
		var_06 = ["undefined"];
	}

	if(!isarray(var_06))
	{
		var_06 = [var_06];
	}

	var_07 = undefined;
	foreach(var_09 in var_06)
	{
		lib_0A1A::func_2330(param_01,var_09);
		var_0A = scripts\anim\notetracks::func_89CB(var_09,var_05,param_02,param_03);
		if(!isdefined(var_0A))
		{
			var_0A = func_2344(param_00,var_09,param_01);
		}

		if(isdefined(var_0A))
		{
			var_07 = var_0A;
		}
	}

	return var_07;
}

//Function Number: 16
func_2344(param_00,param_01,param_02)
{
	if(func_238B(param_01))
	{
		return;
	}

	switch(param_01)
	{
		case "start_aim":
			var_03 = level.var_2303[param_00].var_10E2F[param_02];
			if(isdefined(var_03.var_134) && scripts\common\utility::func_2286(var_03.var_134,"notetrackAim"))
			{
				func_2380(param_00,param_02,0.2);
			}
			break;
	}
}

//Function Number: 17
func_238B(param_00)
{
	if(!scripts\common\utility::string_starts_with(param_00,"ds "))
	{
		return 0;
	}

	var_01 = 3;
	self.var_2303.var_4E6E = spawnstruct();
	var_01 = var_01 + 1;
	var_02 = "";
	while(var_01 < param_00.size && param_00[var_01] != "]")
	{
		var_02 = var_02 + param_00[var_01];
		var_01 = var_01 + 1;
	}

	self.var_2303.var_4E6E.var_10E2C = var_02;
	var_01 = var_01 + 1;
	if(var_01 < param_00.size)
	{
		var_01 = var_01 + 2;
		var_03 = "";
		while(var_01 < param_00.size && param_00[var_01] != "]")
		{
			var_03 = var_03 + param_00[var_01];
			var_01 = var_01 + 1;
		}

		self.var_2303.var_4E6E.var_C8F0 = var_03;
	}

	return 1;
}

//Function Number: 18
func_2324(param_00,param_01,param_02)
{
	self endon(param_00);
	wait(param_02);
	self notify(param_01);
}

//Function Number: 19
func_2323(param_00,param_01,param_02,param_03,param_04)
{
	var_05 = param_01 + "_timeout";
	var_06 = param_01 + "_endHelper";
	self endon(var_05);
	thread func_2324(var_06,var_05,param_02);
	var_07 = func_231F(param_00,param_01,param_03,param_04);
	self notify(var_06);
	return var_07;
}

//Function Number: 20
func_231F(param_00,param_01,param_02,param_03,param_04,param_05)
{
	if(!isdefined(param_05))
	{
		param_05 = 1;
	}

	for(;;)
	{
		var_06 = func_2326(param_00,param_01,param_02,param_03,param_04);
		if(isdefined(var_06))
		{
			if(param_05 && !lib_0A1A::func_232B(param_01,"end"))
			{
				lib_0A1A::func_2330(param_01,"end");
			}

			return var_06;
		}
	}
}

//Function Number: 21
func_2322(param_00,param_01,param_02,param_03)
{
	for(;;)
	{
		self waittill(param_01,var_04);
		if(!isdefined(var_04))
		{
			var_04 = ["undefined"];
		}

		if(!isarray(var_04))
		{
			var_04 = [var_04];
		}

		var_05 = undefined;
		foreach(var_07 in var_04)
		{
			var_08 = [[ param_02 ]](param_01,var_07,param_03);
			if(isdefined(var_08) && var_08)
			{
				continue;
			}

			lib_0A1A::func_2330(param_01,var_07);
			var_09 = scripts\anim\notetracks::func_89CB(var_07,param_01,undefined,undefined);
			if(isdefined(var_09))
			{
				var_05 = var_09;
			}
		}

		if(isdefined(var_05))
		{
			return var_05;
		}
	}
}

//Function Number: 22
func_2320(param_00,param_01,param_02,param_03)
{
	var_04 = param_01 + "_note_loop_end";
	self endon(var_04);
	var_05 = getanimlength(param_02);
	thread func_2321(var_04,param_01 + "_finished",var_05);
	func_231F(param_00,param_01,param_03);
	self notify(var_04);
}

//Function Number: 23
func_2321(param_00,param_01,param_02)
{
	self endon("death");
	self endon("terminate_ai_threads");
	self endon(param_00);
	self endon(param_01);
	wait(param_02);
	self notify(param_00);
}

//Function Number: 24
func_2309(param_00)
{
	return animhasnotetrack(param_00,"facial_override");
}

//Function Number: 25
func_2318()
{
	if(self.var_6A8B != "filler")
	{
		var_00 = func_2356("Knobs","head");
		self method_806F(var_00,0.2);
		self.var_6A89 = undefined;
	}
}

//Function Number: 26
func_2376()
{
	var_00 = self.var_238F;
	var_01 = self.var_164D[var_00].var_4BC0;
	if(var_01 == "AnimScripted")
	{
		return;
	}

	func_2369(var_00,var_01,undefined);
}

//Function Number: 27
func_2369(param_00,param_01,param_02)
{
	if(param_00 != self.var_238F)
	{
		return;
	}

	if(isdefined(level.var_2303[param_00].var_10E2F[param_01].var_6A8B))
	{
		func_236B(param_02,level.var_2303[param_00].var_10E2F[param_01].var_6A8B,self.var_6A89);
		return;
	}

	func_2318();
	self.var_2303.var_6A86 = "";
}

//Function Number: 28
func_236B(param_00,param_01,param_02)
{
	if(!lib_0A1A::func_2346("Knobs","head"))
	{
		return;
	}

	var_03 = func_2356("Knobs","head");
	if(!scripts\sp\_utility::func_9DEB("asm"))
	{
		return;
	}

	if(isdefined(param_00) && func_2309(param_00))
	{
		return;
	}

	if(!isdefined(self.var_2303.var_6A86))
	{
		self.var_2303.var_6A86 = "";
	}

	scripts\sp\_utility::func_F6FE("asm");
	if(self.var_2303.var_6A86 != param_01 || self method_8103(var_03) < 1)
	{
		self.var_2303.var_6A86 = param_01;
		var_04 = "facial_" + param_01;
		var_05 = lib_0A1A::func_2358("facial_animation",var_04);
		var_03 = func_2356("Knobs","head");
		if(isdefined(var_05))
		{
			self method_82A4(var_05,1,0.1,1);
			self method_82A2(var_03,5,0.1);
		}
	}
}

//Function Number: 29
func_236A(param_00)
{
	self endon("death");
	var_01 = "";
	if(isdefined(self.var_2303))
	{
		var_01 = self.var_2303.var_2123;
	}

	if(isdefined(self.var_1FA8))
	{
		var_01 = self.var_1FA8;
	}

	if(!scripts\sp\_utility::func_9DEB("asm") && param_00 != "facial_death")
	{
		return;
	}

	if(var_01 != "")
	{
		scripts\sp\_utility::func_F6FE("asm");
		var_02 = function_02EF(var_01,"facial_animation",param_00,0);
		if(param_00 == "facial_death")
		{
			if(isdefined(self.var_6A84))
			{
				if(self.var_6A84 == param_00)
				{
					if(isdefined(self.var_6A83))
					{
						var_02 = self.var_6A83;
					}
				}
			}
		}

		if(isdefined(var_02))
		{
			self method_82A4(var_02,1,0.267,1);
			self.var_6A83 = var_02;
			self.var_6A84 = param_00;
		}
	}
}

//Function Number: 30
func_236C(param_00)
{
	var_01 = "soldier";
	var_02 = function_02EF(var_01,"facial_animation","facial_death",0);
	if(isdefined(var_02))
	{
		param_00 method_82A4(var_02,1,0,0);
	}
}

//Function Number: 31
func_234F()
{
	self endon("death");
	var_00 = 0;
	var_01 = 0;
	var_02 = func_2356("Knobs","body");
	var_03 = 0;
	var_04 = 0;
	for(;;)
	{
		var_05 = self method_853F(var_02);
		var_06 = var_05[0] - var_00;
		var_07 = var_06 > 0.001 - var_06 < -0.001;
		if(var_07 != var_03)
		{
			if(var_07 > 0)
			{
				var_00 = var_05[0];
				var_03 = var_07;
				wait(0.1);
				func_234C("left");
				continue;
			}

			if(var_07 < 0)
			{
				var_00 = var_05[0];
				var_03 = var_07;
				func_2319("left");
				continue;
			}
		}

		var_00 = var_05[0];
		var_03 = var_07;
		var_08 = var_05[1] - var_01;
		var_09 = var_08 > 0.001 - var_08 < -0.001;
		if(var_09 != var_04)
		{
			if(var_09 > 0)
			{
				var_01 = var_05[1];
				var_04 = var_09;
				wait(0.1);
				func_234C("right");
				continue;
			}

			if(var_09 < 0)
			{
				var_01 = var_05[1];
				var_04 = var_09;
				func_2319("right");
				continue;
			}
		}

		var_01 = var_05[1];
		var_04 = var_09;
		wait(0.05);
	}
}

//Function Number: 32
func_234C(param_00)
{
	var_01 = scripts\anim\utility::func_7DA1();
	if(var_01 == "none")
	{
		func_2319(param_00);
	}

	func_236D(param_00);
}

//Function Number: 33
func_236D(param_00)
{
	var_01 = scripts\anim\utility::func_7DA1();
	if(var_01 == "none")
	{
		return;
	}

	var_02 = "ik_finger_pose_r";
	var_03 = "ik_fingers_r";
	var_04 = getweaponbasename(var_01);
	if(param_00 == "left")
	{
		var_02 = "ik_finger_pose_l";
		var_03 = "ik_fingers_l";
		var_05 = function_00E3(var_01);
		if(isdefined(var_05))
		{
			if(scripts\common\utility::func_2286(var_05,"foregrip"))
			{
				var_04 = "foregrip";
			}
		}
	}

	if(!func_234B(self.var_2303.var_2123,var_02))
	{
		return;
	}

	if(!isdefined(var_04) || !lib_0A1A::func_2346(var_02,var_04))
	{
		if(!isdefined(var_04))
		{
			var_04 = "UNDEFINED";
		}

		return;
	}

	var_06 = lib_0A1A::func_2358(var_02,var_04);
	var_07 = func_2356("Knobs",var_03);
	self method_82A2(var_07,10,0.3,1);
	self method_82A2(var_06,1,0.3,1);
}

//Function Number: 34
func_2319(param_00)
{
	var_01 = "ik_fingers_l";
	if(param_00 == "right")
	{
		var_01 = "ik_fingers_r";
	}

	if(!lib_0A1A::func_2346("Knobs",var_01))
	{
		return;
	}

	var_02 = func_2356("Knobs",var_01);
	self method_806F(var_02,0.3,1);
}

//Function Number: 35
func_2355()
{
	var_00 = scripts\anim\utility::func_7DA1();
	var_01 = getweaponbasename(var_00);
	var_02 = ["iw7_cheytac","iw7_kbs","iw7_m1","iw7_m8","iw7_mauler","iw7_sdflmg","iw7_ameli","iw7_steeldragon","iw7_sonic","iw7_sdfshotty","iw7_spas"];
	if(isdefined(var_01) && scripts\common\utility::func_2286(var_02,var_01))
	{
		return 1;
	}

	return 0;
}

//Function Number: 36
func_236E()
{
	func_231A();
	var_00 = lib_0A1A::func_2358("Visor","helmet_visor_up");
	if(self.var_2303.var_DC48 == 1)
	{
		self method_82A2(var_00,1,0,1);
		return;
	}

	var_01 = lib_0A1A::func_2358("Visor","helmet_visor_down");
	self method_82A2(var_01,1,0,1);
	wait(getanimlength(var_01) - 0.1);
	func_231A();
}

//Function Number: 37
func_231A()
{
	var_00 = func_2356("Knobs","visor");
	self method_806F(var_00,0);
}

//Function Number: 38
func_2333(param_00,param_01,param_02)
{
	return archetypegetaliases(param_00,param_01);
}

//Function Number: 39
func_235E(param_00,param_01,param_02,param_03)
{
	var_04 = func_2333(param_00,param_01);
	var_05 = 0;
	var_06 = undefined;
	var_07 = -1;
	if(isdefined(param_02))
	{
		var_07 = param_02.size;
	}

	if(!isdefined(var_04))
	{
		return undefined;
	}

	foreach(var_0A in var_04)
	{
		if(var_07 < 0 || getsubstr(var_0A,0,var_07) == param_02)
		{
			var_05 = var_05 + 1;
			var_0B = 1 / var_05;
			if(randomfloat(1) <= var_0B)
			{
				var_06 = var_0A;
			}
		}
	}

	return var_06;
}

//Function Number: 40
func_235D(param_00,param_01,param_02)
{
	return func_235E(self.var_2303.var_2123,param_00,param_01,param_02);
}

//Function Number: 41
func_2357(param_00,param_01,param_02)
{
	var_03 = undefined;
	if(isdefined(self.var_1FA8))
	{
		var_03 = archetypegetalias(param_00,param_01,param_02,0);
	}
	else
	{
		var_03 = archetypegetalias(param_00,param_01,param_02,lib_0A1A::func_2353());
	}

	if(isdefined(var_03))
	{
		return var_03.var_47;
	}

	return undefined;
}

//Function Number: 42
func_2356(param_00,param_01)
{
	if(isdefined(self.var_1FA8))
	{
		var_02 = func_2357(self.var_1FA8,param_00,param_01);
	}
	else
	{
		var_02 = func_2357(self.var_2303.var_2123,param_01,var_02);
	}

	return var_02;
}

//Function Number: 43
func_2305(param_00,param_01,param_02)
{
	var_03 = archetypegetalias(param_00,param_01,param_02,lib_0A1A::func_2353());
	if(isdefined(var_03))
	{
		return 1;
	}

	return 0;
}

//Function Number: 44
func_2359(param_00,param_01,param_02)
{
	return function_02EF(param_00,param_01,param_02,lib_0A1A::func_2353());
}

//Function Number: 45
func_235B(param_00,param_01)
{
	var_02 = func_2359(self.var_2303.var_2123,param_00,param_01);
	return var_02;
}

//Function Number: 46
func_234B(param_00,param_01)
{
	if(archetypeassetloaded(param_00))
	{
		return function_02F1(param_00,param_01);
	}

	return 0;
}

//Function Number: 47
func_2348(param_00,param_01)
{
	var_02 = func_2357(self.var_2303.var_2123,param_00,param_01);
	return isdefined(var_02);
}

//Function Number: 48
func_2335(param_00,param_01,param_02)
{
	var_03 = archetypegetalias(param_00,param_01,param_02,1);
	if(!isdefined(var_03))
	{
		return undefined;
	}

	var_04 = var_03.var_47;
	if(!isarray(var_04))
	{
		var_04 = [var_04];
	}

	var_05 = archetypegetalias(param_00,param_01,param_02,0);
	var_06 = var_05.var_47;
	if(!isarray(var_06))
	{
		var_06 = [var_06];
	}

	foreach(var_08 in var_06)
	{
		if(!scripts\common\utility::func_2286(var_04,var_08))
		{
			var_04[var_04.size] = var_08;
		}
	}

	return var_04;
}

//Function Number: 49
func_2336(param_00,param_01)
{
	var_02 = level.var_2303[param_00].var_10E2F[param_01].var_71A5;
	var_03 = level.var_2303[param_00].var_10E2F[param_01].var_7DC8;
	var_04 = self [[ var_02 ]](param_00,param_01,var_03);
	return var_04;
}

//Function Number: 50
func_2342()
{
	return func_2356("Knobs","root");
}

//Function Number: 51
func_2339()
{
	return func_2356("Knobs","body");
}

//Function Number: 52
func_235F(param_00,param_01,param_02,param_03,param_04)
{
	self endon(param_01 + "_finished");
	var_05 = func_2339();
	self method_806F(var_05,param_02);
	if(isdefined(param_04) && param_04)
	{
		if(lib_0A1A::func_2346("Knobs","move"))
		{
			var_06 = func_2356("Knobs","move");
			self method_84F2(var_06);
		}
	}

	var_07 = undefined;
	var_08 = lib_0A1A::func_2341(param_00,param_01);
	var_09 = 0.2;
	var_0A = isdefined(param_04) && param_04;
	for(;;)
	{
		var_0B = func_2336(param_00,param_01);
		if(isdefined(param_04) && param_04)
		{
			param_03 = lib_0A1A::func_2340();
			self method_84F1(param_03);
		}

		if(isdefined(var_07) && var_07 != var_0B)
		{
			self method_806F(var_07,param_02);
		}

		if(self method_8103(var_0B) > 0)
		{
			self method_82E1(param_01,var_0B,1,param_02,param_03);
		}
		else
		{
			self method_82EA(param_01,var_0B,1,param_02,param_03);
		}

		func_2369(param_00,param_01,var_0B);
		var_0C = getanimlength(var_0B);
		if(var_0C <= 0.05)
		{
			return;
		}

		var_0D = undefined;
		var_0E = param_03;
		while(!isdefined(var_0D))
		{
			var_0D = func_2323(param_00,param_01,var_09,var_08);
			if(!isdefined(var_0D) && var_0A)
			{
				param_03 = lib_0A1A::func_2340();
				if(param_03 != var_0E)
				{
					self method_84F1(param_03);
					self method_82B1(var_0B,param_03);
				}
			}
		}

		var_07 = var_0B;
	}
}

//Function Number: 53
func_2368(param_00,param_01,param_02,param_03,param_04)
{
	self endon(param_01 + "_finished");
	var_05 = func_2336(param_00,param_01);
	self method_806F(func_2339(),param_02);
	self method_82E7(param_01,var_05,1,param_02,1);
	func_2369(param_00,param_01,var_05);
	var_06 = func_2322(param_00,param_01,param_03,param_04);
	if(var_06 == "end")
	{
		if(!lib_0A1A::func_232B(param_01,"end"))
		{
			lib_0A1A::func_2330(param_01,"end");
		}

		thread lib_0A1A::func_2310(param_00,param_01,0);
	}
}

//Function Number: 54
func_2366(param_00,param_01,param_02)
{
	self endon(param_01 + "_finished");
	var_03 = func_2336(param_00,param_01);
	self method_806F(func_2339(),param_02);
	self method_82E7(param_01,var_03,1,param_02,1);
	func_2369(param_00,param_01,var_03);
	var_04 = func_231F(param_00,param_01,lib_0A1A::func_2341(param_00,param_01));
}

//Function Number: 55
func_2364(param_00,param_01,param_02)
{
	self endon(param_01 + "_finished");
	var_03 = func_2336(param_00,param_01);
	self method_806F(func_2339(),param_02);
	self method_82E7(param_01,var_03,1,param_02,1);
	func_2369(param_00,param_01,var_03);
	var_04 = func_231F(param_00,param_01,lib_0A1A::func_2341(param_00,param_01));
	if(var_04 == "code_move")
	{
		var_04 = func_231F(param_00,param_01,lib_0A1A::func_2341(param_00,param_01));
	}

	if(var_04 == "end")
	{
		thread lib_0A1A::func_2310(param_00,param_01,0);
	}
}

//Function Number: 56
func_2363(param_00,param_01,param_02,param_03)
{
	var_04 = func_2336(param_00,param_01);
	var_05 = isdefined(param_03) && param_03 == "limited";
	if(var_05)
	{
		self method_82E6(param_01,var_04,1,param_02,1);
	}
	else
	{
		self method_82E7(param_01,var_04,1,param_02,1);
	}

	func_2369(param_00,param_01,var_04);
	func_231F(param_00,param_01,lib_0A1A::func_2341(param_00,param_01));
}

//Function Number: 57
func_2361(param_00,param_01,param_02,param_03)
{
	self endon(param_01 + "_finished");
	var_04 = func_2339();
	var_05 = isdefined(param_03) && param_03 == "limited";
	for(;;)
	{
		var_06 = func_2336(param_00,param_01);
		if(var_04 != var_06)
		{
			if(var_05)
			{
				self method_82E6(param_01,var_06,1,param_02,1);
			}
			else
			{
				self method_82E7(param_01,var_06,1,param_02,1);
			}

			var_04 = var_06;
		}

		thread func_2362(param_01,var_06,var_05);
		func_2369(param_00,param_01,var_06);
		func_231F(param_00,param_01,lib_0A1A::func_2341(param_00,param_01));
		self notify(param_01 + "additive_cancel");
	}
}

//Function Number: 58
func_2362(param_00,param_01,param_02)
{
	self endon(param_00 + "_finished");
	self endon(param_00 + "additive_cancel");
	while(isdefined(param_01))
	{
		wait(0.2);
		if(param_02)
		{
			self method_82E8(param_00,param_01,1,0,1);
			continue;
		}

		self method_82E1(param_00,param_01,1,0,1);
	}
}

//Function Number: 59
func_2377(param_00)
{
	if(isdefined(param_00["left"]))
	{
		self.var_1B7 = param_00["left"];
	}
	else if(scripts\common\utility::func_167E())
	{
		self.var_1B7 = 56;
	}
	else
	{
		self.var_1B7 = 45;
	}

	if(isdefined(param_00["right"]))
	{
		self.var_268 = param_00["right"];
	}
	else if(scripts\common\utility::func_167E())
	{
		self.var_268 = -56;
	}
	else
	{
		self.var_268 = -45;
	}

	if(isdefined(param_00["up"]))
	{
		self.var_368 = param_00["up"];
	}
	else if(scripts\common\utility::func_167E())
	{
		self.var_368 = -65;
	}
	else
	{
		self.var_368 = -45;
	}

	if(isdefined(param_00["down"]))
	{
		self.var_100 = param_00["down"];
		return;
	}

	if(scripts\common\utility::func_167E())
	{
		self.var_100 = 65;
		return;
	}

	self.var_100 = 45;
}

//Function Number: 60
func_2332(param_00,param_01)
{
	if(!isdefined(level.var_1A43[param_00]))
	{
		return "default";
	}

	if(!isdefined(level.var_1A43[param_00][param_01]))
	{
		return "default";
	}

	return level.var_1A43[param_00][param_01];
}

//Function Number: 61
func_237D(param_00,param_01)
{
	if(isdefined(self.var_9322) && self.var_9322)
	{
		return;
	}

	var_02 = func_2332(param_00,param_01);
	if(!isdefined(level.var_43FE[param_00]))
	{
		func_2377([]);
		return;
	}

	var_03 = lib_0A1A::func_2353();
	if(var_03 && isdefined(level.var_7361[param_00][var_02]))
	{
		func_2377(level.var_7361[param_00][var_02]);
		return;
	}
	else if(isdefined(level.var_43FE[param_00][var_02]))
	{
		func_2377(level.var_43FE[param_00][var_02]);
		return;
	}

	func_2377([]);
}

//Function Number: 62
func_2380(param_00,param_01,param_02,param_03,param_04)
{
	var_05 = scripts\common\utility::func_13C07(self.var_394);
	if(var_05 == "none")
	{
		return;
	}

	if(lib_0A1A::func_2346(param_01,"aim_1"))
	{
		return;
	}

	if(!lib_0A1A::func_2346(param_01,var_05 + "_aim_8"))
	{
		var_05 = "rifle";
	}

	func_237D(param_00,param_01);
	var_06 = var_05 + "_aim_5";
	var_07 = undefined;
	if((!isdefined(param_03) || param_03) && lib_0A1A::func_2346(param_01,var_06))
	{
		var_07 = func_235B(param_01,var_05 + "_aim_5");
	}

	self method_82A9(func_235B(param_01,var_05 + "_aim_8"),1,param_02);
	self method_82A9(func_235B(param_01,var_05 + "_aim_2"),1,param_02);
	self method_82A9(func_235B(param_01,var_05 + "_aim_4"),1,param_02);
	self method_82A9(func_235B(param_01,var_05 + "_aim_6"),1,param_02);
	if(isdefined(var_07))
	{
		self method_82AC(var_07,1,param_02);
	}

	if(lib_0A1A::func_2346(param_01,"aim_root"))
	{
		self method_82A2(func_235B(param_01,"aim_root"),1,param_02);
	}
	else if(lib_0A1A::func_2346("Knobs","aim_root"))
	{
		self method_82A2(func_235B("Knobs","aim_root"),1,param_02);
	}

	var_08 = func_2348(param_01,"aim_knob_2");
	if(var_08)
	{
		self notify("StopCleanupAimKnobs");
		self.var_2303.var_11A90.var_1A1D = func_235B(param_01,"aim_knob_2");
		self.var_2303.var_11A90.var_1A1F = func_235B(param_01,"aim_knob_4");
		self.var_2303.var_11A90.var_1A22 = func_235B(param_01,"aim_knob_6");
		self.var_2303.var_11A90.var_1A24 = func_235B(param_01,"aim_knob_8");
		if(isdefined(var_07))
		{
			self.var_2303.var_11A90.var_1A21 = func_235B(param_01,"aim_knob_5");
		}

		thread func_2312(param_01);
	}

	lib_0A2B::func_11AFD();
}

//Function Number: 63
func_2381(param_00,param_01)
{
	var_02 = lib_0A1A::func_233C();
	self.var_2303.var_77C1.var_77A6 = func_235B("gesture","gesture_move_up");
	self.var_2303.var_77C1.var_778C = func_235B("gesture","gesture_armup");
	self.var_2303.var_77C1.var_77A8 = func_235B("gesture","gesture_on_me");
	self.var_2303.var_77C1.var_77A0 = func_235B("gesture","gesture_hold");
	self.var_2303.var_77C1.var_7795 = func_235B("gesture","gesture_fallback_up");
	self.var_2303.var_77C1.var_7794 = func_235B("gesture","gesture_fallback_down");
	if(var_02 == "casual")
	{
		self.var_2303.var_77C1.var_77AA = func_235B("gesture_point","gesture_point_center");
		self.var_2303.var_77C1.var_77AC = func_235B("gesture_point","gesture_point_left");
		self.var_2303.var_77C1.var_77AE = func_235B("gesture_point","gesture_point_right");
		self.var_2303.var_77C1.var_77AF = func_235B("gesture_point","gesture_point_up");
		self.var_2303.var_77C1.var_77AB = func_235B("gesture_point","gesture_point_down");
		self.var_2303.var_77C1.var_77B6 = func_235B("gesture","gesture_shrug_anim");
		self.var_2303.var_77C1.var_778F = func_235B("gesture","gesture_cross_anim");
		self.var_2303.var_77C1.var_77A7 = func_235B("gesture","gesture_nod_anim");
		self.var_2303.var_77C1.var_77B5 = func_235B("gesture","gesture_shake_head_anim");
		self.var_2303.var_77C1.var_77B4 = func_235B("gesture","gesture_salute_anim");
		self.var_2303.var_77C1.var_77BF = func_235B("gesture","gesture_wave_anim");
		self.var_2303.var_77C1.var_77BE = func_235B("gesture","gesture_wait_anim");
		return;
	}

	if(var_02 == "casual_gun")
	{
		self.var_2303.var_77C1.var_77AA = func_235B("gesture_point","gesture_casual_gun_point_center");
		self.var_2303.var_77C1.var_77AC = func_235B("gesture_point","gesture_casual_gun_point_left");
		self.var_2303.var_77C1.var_77AE = func_235B("gesture_point","gesture_casual_gun_point_right");
		self.var_2303.var_77C1.var_77AF = func_235B("gesture_point","gesture_casual_gun_point_up");
		self.var_2303.var_77C1.var_77AB = func_235B("gesture_point","gesture_casual_gun_point_down");
		self.var_2303.var_77C1.var_77B6 = func_235B("gesture","gesture_gun_shrug_anim");
		self.var_2303.var_77C1.var_778F = func_235B("gesture","gesture_gun_cross_anim");
		self.var_2303.var_77C1.var_77A7 = func_235B("gesture","gesture_gun_nod_anim");
		self.var_2303.var_77C1.var_77B5 = func_235B("gesture","gesture_gun_shake_head_anim");
		self.var_2303.var_77C1.var_77B4 = func_235B("gesture","gesture_gun_salute_anim");
		self.var_2303.var_77C1.var_77BF = func_235B("gesture","gesture_gun_wave_anim");
		self.var_2303.var_77C1.var_77BE = func_235B("gesture","gesture_gun_wait_anim");
		return;
	}

	self.var_2303.var_77C1.var_77AA = func_235B("gesture_point","gesture_gun_point_center");
	self.var_2303.var_77C1.var_77AC = func_235B("gesture_point","gesture_gun_point_left");
	self.var_2303.var_77C1.var_77AE = func_235B("gesture_point","gesture_gun_point_right");
	self.var_2303.var_77C1.var_77AF = func_235B("gesture_point","gesture_gun_point_up");
	self.var_2303.var_77C1.var_77AB = func_235B("gesture_point","gesture_gun_point_down");
	self.var_2303.var_77C1.var_77B6 = func_235B("gesture","gesture_gun_shrug_anim");
	self.var_2303.var_77C1.var_778F = func_235B("gesture","gesture_gun_cross_anim");
	self.var_2303.var_77C1.var_77A7 = func_235B("gesture","gesture_gun_nod_anim");
	self.var_2303.var_77C1.var_77B5 = func_235B("gesture","gesture_gun_shake_head_anim");
	self.var_2303.var_77C1.var_77B4 = func_235B("gesture","gesture_gun_salute_anim");
	self.var_2303.var_77C1.var_77BF = func_235B("gesture","gesture_gun_wave_anim");
	self.var_2303.var_77C1.var_77BE = func_235B("gesture","gesture_gun_wait_anim");
}

//Function Number: 64
func_2313(param_00,param_01)
{
	self endon("death");
	self endon("StopCleanupAimKnobs");
	scripts\common\utility::waittill_any_timeout_1(param_01,param_00 + "_finished");
	func_2311();
}

//Function Number: 65
func_2312(param_00)
{
	self endon("death");
	self endon("StopCleanupAimKnobs");
	self waittill(param_00 + "_finished");
	func_2311();
}

//Function Number: 66
func_2311()
{
	if(!isdefined(self.var_2303.var_11A90))
	{
		return;
	}

	self.var_2303.var_11A90.var_1A1D = undefined;
	self.var_2303.var_11A90.var_1A1F = undefined;
	self.var_2303.var_11A90.var_1A22 = undefined;
	self.var_2303.var_11A90.var_1A24 = undefined;
	self.var_2303.var_11A90.var_1A21 = undefined;
}

//Function Number: 67
func_238E(param_00,param_01,param_02)
{
	self endon(param_01 + "_finished");
	var_03 = 0;
	while(!var_03)
	{
		self waittill(param_01,var_04);
		if(!isarray(var_04))
		{
			var_04 = [var_04];
		}

		foreach(var_06 in var_04)
		{
			if(var_06 == "start_aim")
			{
				func_2380(param_00,param_01,param_02);
				var_03 = 1;
				break;
			}
		}
	}
}

//Function Number: 68
func_230A(param_00,param_01,param_02,param_03,param_04,param_05,param_06)
{
	var_07 = self.var_238F;
	var_08 = self.var_164D[var_07].var_4BC0;
	var_09 = level.var_2303[var_07].var_10E2F[var_08];
	lib_0A1A::func_2388(var_07,var_08,var_09,var_09.var_116FB);
	lib_0A1A::func_238A(var_07,"AnimScripted",0.2);
}

//Function Number: 69
func_2386()
{
	self method_83A1();
}

//Function Number: 70
func_2307(param_00,param_01)
{
	if(getdvarint("ai_iw7",0) == 0)
	{
		if(!isdefined(param_01))
		{
			self method_8015(param_00);
		}
		else
		{
			self method_8015(param_00,param_01);
		}

		return;
	}

	lib_0A1B::func_2973();
	self.var_2303.var_1FAC = param_01;
	self method_8015(param_00,::func_2308);
	var_02 = self.var_238F;
	var_03 = self.var_164D[var_02].var_4BC0;
	var_04 = level.var_2303[var_02].var_10E2F[var_03];
	lib_0A1A::func_2388(var_02,var_03,var_04,var_04.var_116FB);
	lib_0A1A::func_238A(var_02,"AnimScripted",0.2);
}

//Function Number: 71
func_2308()
{
	lib_0A1B::func_2911();
	if(!isdefined(self.var_2303.var_1FAC))
	{
		return;
	}

	self [[ self.var_2303.var_1FAC ]]();
	self.var_2303.var_1FAC = undefined;
}

//Function Number: 72
func_2385()
{
	self notify("killanimscript");
}

//Function Number: 73
func_230F(param_00)
{
	if(isdefined(param_00.var_C704))
	{
		func_237F(param_00.var_C704);
	}

	if(isdefined(param_00.var_1FBA))
	{
		func_237E(param_00.var_1FBA);
	}
}

//Function Number: 74
func_9F70(param_00,param_01,param_02,param_03)
{
	if(isdefined(self.var_E2))
	{
		if(self.var_E2 == "none")
		{
			return 0;
		}

		if(scripts\sp\_utility::func_9DB4("emp"))
		{
			return 1;
		}

		if(scripts\sp\_utility::func_9DB4("iw7_sonic"))
		{
			return 1;
		}

		if(func_FFBD())
		{
			return 1;
		}
	}

	return 0;
}

//Function Number: 75
func_9F4C(param_00,param_01,param_02,param_03)
{
	if(isdefined(self.var_DE) && self.var_DE == "MOD_IMPACT")
	{
		return 0;
	}

	if(scripts\sp\_utility::func_9DB4("emp"))
	{
		return 1;
	}

	if(self.var_12BA4 == "c6" || self.var_12BA4 == "c8")
	{
		if(scripts\sp\_utility::func_9DB4("iw7_sonic") && scripts\sp\_utility::func_9FFE(self.var_E2))
		{
			return 1;
		}
	}

	if(scripts\sp\_utility::func_9DB4("iw7_atomizer") && self.var_DE != "MOD_MELEE" && self.health <= 0)
	{
		return 1;
	}

	return 0;
}

//Function Number: 76
func_D521()
{
	if(scripts\sp\_utility::func_9DB4("iw7_sonic") && scripts\sp\_utility::func_9FFE(self.var_E2))
	{
		playfxontag(level.var_7649["soldier_shock"],self,"j_knee_ri");
		playfxontag(level.var_7649["soldier_shock"],self,"j_shoulder_ri");
	}
}

//Function Number: 77
func_9DB5(param_00,param_01,param_02,param_03)
{
	var_04 = self.var_E1;
	if(isdefined(self.var_C873))
	{
		var_04 = self.var_C873;
	}

	if(scripts\sp\_utility::func_9DB4("iw7_sonic") && self.var_DE != "MOD_MELEE" && var_04 >= 75)
	{
		return 1;
	}

	return 0;
}

//Function Number: 78
func_FFBD()
{
	if(self.var_DE == "MOD_MELEE")
	{
		return 0;
	}

	if(!isdefined(self.var_E2))
	{
		return 0;
	}

	if(self.var_E2 == "none")
	{
		return 0;
	}

	var_00 = getweaponbasename(self.var_E2);
	if(!isdefined(var_00))
	{
		return 0;
	}

	if(isdefined(self.var_1B1) && isdefined(self.var_1B1.team) && isdefined(self.team) && self.var_1B1.team == self.team)
	{
		return 0;
	}

	return var_00 == "iw7_atomizer";
}

//Function Number: 79
func_7E5A()
{
	var_00 = -1 * self.var_DC;
	var_01 = anglestoforward(self.angles);
	var_02 = vectordot(var_01,var_00);
	if(var_02 > 0.707)
	{
		return "front";
	}

	if(var_02 < -0.707)
	{
		return "back";
	}

	var_03 = vectorcross(var_01,var_00);
	if(var_03[2] > 0)
	{
		return "left";
	}

	return "right";
}

//Function Number: 80
func_7F08()
{
	var_00 = -1 * self.var_DC;
	var_01 = anglestoforward(self.angles);
	var_02 = vectordot(var_01,var_00);
	if(var_02 < -0.5)
	{
		return 1;
	}

	return 0;
}