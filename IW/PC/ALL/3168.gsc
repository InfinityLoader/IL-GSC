/*******************************************************************
 * Decompiled By: Bog
 * Decompiled File: 3168.gsc
 * Game: Call of Duty: Infinite Warfare
 * Platform: PC
 * Function Count: 54
 * Decompile Time: 24 ms
 * Timestamp: 10/27/2023 12:26:23 AM
*******************************************************************/

//Function Number: 1
func_4E4A()
{
	if(!isdefined(self.var_1198.var_AB58))
	{
		return;
	}

	var_00 = self.var_1198.var_AB58;
	var_00 delete();
	self.var_1198.var_AB58 = undefined;
	scripts\sp\_utility::func_72EC(self.var_D8E1,"primary");
}

//Function Number: 2
func_CF0E(param_00,param_01,param_02,param_03)
{
	func_11043();
	func_E166(self.origin);
	level.var_C222--;
	level.var_C221--;
	func_4E4A();
	if(self.var_1491.var_C043)
	{
		func_4E36();
		return;
	}
	else if(isdefined(self.var_DC1A) || self.var_13F)
	{
		if(isdefined(self.var_57E1) && self.var_57E1)
		{
			self method_8016("noclip");
		}
		else
		{
			self method_8016("gravity");
		}

		func_58CB();
		if(!isdefined(self))
		{
			return;
		}
	}

	var_04 = scripts\anim\pain::func_1390C();
	if(func_10024(var_04))
	{
		func_8E17();
	}

	if(func_10021(var_04))
	{
		func_8C99();
	}

	if(!isdefined(self.var_10265))
	{
		self method_806F(lib_0A1E::func_2342(),0.3);
	}

	func_CF16(var_04);
	if(isdefined(self.var_2303.var_4E40))
	{
		self [[ self.var_2303.var_4E40 ]]();
		if(!isdefined(self.var_4E46))
		{
			func_4E36();
			return;
		}
	}

	if(isdefined(self.var_4E46))
	{
		var_05 = self [[ self.var_4E46 ]]();
		if(!isdefined(var_05))
		{
			var_05 = 1;
		}

		if(var_05)
		{
			func_4E36();
			return;
		}
	}

	self endon("entitydeleted");
	if(lib_0A1E::func_FFBD() && self.var_12BA4 != "c12")
	{
		if(self.var_12BA4 == "c6" || self.var_12BA4 == "c8")
		{
			thread atomizerrobotbodyfx();
			return;
		}

		thread func_2453();
	}

	if(func_1001C() && !self method_81B7())
	{
		if(self.var_12BA4 == "c6")
		{
			anim thread [[ self.var_3135.var_71CC ]](self,150,120,1);
			return;
		}

		scripts\anim\shared::func_5D1A();
		func_58B8();
		self hide();
		wait(0.1);
		if(isdefined(self))
		{
			func_4E36();
			self delete();
		}

		return;
	}

	if(isdefined(self.var_4E30) && !isdefined(self.var_4E2A))
	{
		self.var_4E2A = func_8183();
	}

	var_06 = undefined;
	if(!isdefined(self.var_10265))
	{
		if(isdefined(self.var_4E2A))
		{
			var_06 = self.var_4E2A;
		}
		else
		{
			var_07 = level.var_2303[param_00].var_10E2F[param_01].var_71A5;
			var_06 = self [[ var_07 ]](param_00,param_01,param_03);
		}

		if(!animhasnotetrack(var_06,"dropgun") && !animhasnotetrack(var_06,"fire_spray"))
		{
			scripts\anim\shared::func_5D1A();
		}

		if(animhasnotetrack(var_06,"dropgun"))
		{
			self.var_1198.var_26C6 = 1;
		}

		func_C703();
		self method_82E4(param_01,var_06,lib_0A1E::func_2339(),1,0.1);
		lib_0A1E::func_2369(param_00,param_01,var_06);
	}

	if(isdefined(self.var_10265))
	{
		if(!isdefined(self.var_C089))
		{
			if(isdefined(self.var_71C8))
			{
				self [[ self.var_71C8 ]]();
			}

			if(!isdefined(self))
			{
				return;
			}

			self method_839A();
		}

		wait(0.05);
		self method_8016("gravity");
	}
	else if(isdefined(self.var_DC23))
	{
		thread func_136DF(self.var_DC23);
	}
	else if(!animhasnotetrack(var_06,"start_ragdoll"))
	{
		if(self.var_DE == "MOD_MELEE")
		{
			var_08 = 0.7;
		}
		else
		{
			var_08 = 0.35;
		}

		thread func_136DF(getanimlength(var_06) * var_08);
	}

	if(isdefined(self.var_4E2C))
	{
		self method_8016(self.var_4E2C);
	}

	if(!isdefined(self.var_10265))
	{
		thread func_CF14();
	}

	self endon("terminate_death_thread");
	if(isdefined(self.var_10265))
	{
		wait(0.05);
	}
	else
	{
		lib_0A1E::func_231F(param_00,param_01,::func_4E51);
	}

	if(!isdefined(self))
	{
		return;
	}

	scripts\anim\shared::func_5D1A();
	self notify("endPlayDeathAnim");
	if(isdefined(self.var_DC1A) || self.var_13F)
	{
		wait(0.5);
		if(!isdefined(self))
		{
			return;
		}

		self method_82B1(lib_0A1E::func_2342(),0);
	}

	func_4E36();
}

//Function Number: 3
func_4E51(param_00)
{
	if(self.var_12BA4 == "c8")
	{
		anim thread func_34F8(self,param_00);
		return;
	}

	scripts\sp\_anim::func_C0DB(param_00);
}

//Function Number: 4
func_34F8(param_00,param_01)
{
	var_02 = getsubstr(param_01,0,3);
	if(var_02 == "vo_")
	{
		var_03 = getsubstr(param_01,3);
		param_00 method_824A(var_03);
		return;
	}

	if(var_03 != "ps_")
	{
		return;
	}

	var_03 = getsubstr(var_02,3);
	if(!isdefined(param_00.var_4E67))
	{
		param_00.var_4E67 = spawn("script_origin",param_00.origin);
		param_00.var_4E67 linkto(param_00,"");
	}

	var_04 = param_00.var_4E67;
	var_04 notify("stop_C8DeathSound");
	var_04 endon("stop_C8DeathSound");
	var_04 playsound(var_03);
	var_05 = lookupsoundlength(var_03);
	wait(var_05 * 0.001 + 0.1);
	var_04 delete();
}

//Function Number: 5
func_D46A(param_00,param_01,param_02,param_03)
{
	if((scripts\common\utility::istrue(self.var_E2 == "iw7_knife_upgrade1") || scripts\common\utility::func_1390D() || scripts\sp\_utility::func_9DB4("iw7_sonic")) && isdefined(self.var_4F))
	{
		var_04 = vectortoyaw(self.var_4F.origin - self.origin);
		if(self.var_E3 > 135 || self.var_E3 <= -135)
		{
			self method_8221("face angle",var_04);
		}
		else if(self.var_E3 > 45 && self.var_E3 <= 135)
		{
			self method_8221("face angle",var_04 + 90);
		}
		else if(self.var_E3 > -45 && self.var_E3 <= 45)
		{
			self method_8221("face angle",var_04 - 180);
		}
		else
		{
			self method_8221("face angle",var_04 - 90);
		}
	}

	func_CF0E(param_00,param_01,param_02,param_03);
}

//Function Number: 6
func_CF11(param_00,param_01,param_02,param_03)
{
	if(isdefined(self.var_2029))
	{
		self.var_2029 delete();
	}

	self.var_13F = 1;
	self.var_57E1 = 1;
	self.var_10265 = 1;
	func_CF0E(param_00,param_01,param_02,param_03);
}

//Function Number: 7
func_CF0F(param_00,param_01,param_02,param_03)
{
	if(isdefined(self.var_B647))
	{
		var_04 = param_03;
		if(!isdefined(var_04))
		{
			var_04 = 10;
		}

		lib_0A1E::func_2323(param_00,self.var_B647,var_04);
	}

	scripts\anim\shared::func_5D1A();
	if(isdefined(self.var_71C8))
	{
		self [[ self.var_71C8 ]]();
	}

	if(!isdefined(self))
	{
		return;
	}

	self method_839A();
	wait(0.1);
	func_4E36();
}

//Function Number: 8
func_4E36()
{
	if(isdefined(self))
	{
		if(self.var_12BA4 == "c6")
		{
		}
		else if(self.var_12BA4 == "c8")
		{
			func_34B9();
		}
	}

	self notify("terminate_ai_threads");
	var_00 = 3;
	while(isdefined(self) && self.script != "death" && var_00 > 0)
	{
		var_00--;
		wait(0.05);
	}

	self notify("killanimscript");
}

//Function Number: 9
func_3EF6(param_00,param_01,param_02,param_03)
{
	return lib_0A1A::func_2358(param_01,"standing");
}

//Function Number: 10
func_10052(param_00,param_01,param_02,param_03)
{
	return lib_0A1E::func_9F4C() || isdefined(self.var_FE4A);
}

//Function Number: 11
func_10045(param_00,param_01,param_02,param_03)
{
	if(scripts\anim\pain::func_1390C())
	{
		return 1;
	}

	return 0;
}

//Function Number: 12
func_10059(param_00,param_01,param_02,param_03)
{
	if(!isdefined(self.var_E2) || self.var_E2 == "none")
	{
		return 0;
	}

	if(isdefined(self.var_1491.var_58DA))
	{
		return 0;
	}

	if(self.var_1491.var_D6A5 == "prone" || isdefined(self.var_1491.var_C4C8))
	{
		return 0;
	}

	if(self.var_DE == "MOD_MELEE")
	{
		return 0;
	}

	if(abs(self.var_E3) < 45)
	{
		return 0;
	}

	if(self.var_E1 > 500)
	{
		return 1;
	}

	if(self.var_1491.var_BCC8 == "run" && !func_9D59(self.var_4F,275))
	{
		if(randomint(100) < 65)
		{
			return 0;
		}
	}

	if(scripts\anim\utility_common::func_9F62(self.var_E2) && self.maxhealth < self.var_E1)
	{
		return 1;
	}

	if(scripts\anim\utility_common::func_9F4F(self.var_E2) && func_9D59(self.var_4F,512))
	{
		return 1;
	}

	if(getweaponbasename(self.var_E2) == "iw7_devastator" && scripts\sp\_utility::func_9FFE(self.var_E2))
	{
		return 1;
	}

	return 0;
}

//Function Number: 13
func_11043()
{
	self method_83AC("voice_bchatter_1_3d");
	lib_0B06::func_55C7(0);
	self stoploopsound();
}

//Function Number: 14
func_33AA()
{
	if(!isdefined(self))
	{
		return;
	}

	self.var_3135.var_55CE = 1;
	if(isdefined(self.var_2303.var_2F3B))
	{
		return;
	}

	self.var_2303.var_2F3B = 1;
	self.var_EF39 = 1;
	if(!isdefined(self.var_1198.var_EF3B))
	{
		return;
	}

	foreach(var_03, var_01 in self.var_1198.var_EF3B)
	{
		var_02 = var_01.var_10E19;
		if(var_02 == "normal")
		{
			continue;
		}

		if(issubstr(var_02,"_both"))
		{
			var_02 = "dmg_both";
		}

		self setscriptablepartstate(var_03,var_02 + "_stopfx");
	}

	self setscriptablepartstate("torso_overload_fx","normal");
}

//Function Number: 15
func_34B9()
{
	self.var_3135.var_55CE = 1;
	if(isdefined(self.var_2303.var_2F3B))
	{
		return;
	}

	self.var_2303.var_2F3B = 1;
	self.var_EF39 = 1;
	if(!isdefined(self.var_1198.var_EF3B))
	{
		return;
	}

	foreach(var_02, var_01 in self.var_1198.var_EF3B)
	{
		if(issubstr(var_02,"dmg_fx"))
		{
			self setscriptablepartstate(var_02,"stopfx");
		}
	}

	self setscriptablepartstate("torso_overload_fx","normal");
}

//Function Number: 16
func_3EE2(param_00,param_01,param_02)
{
	if(abs(self.var_E3) < 45)
	{
		return lib_0A1A::func_2358(param_01,"running_forward_8");
	}

	if(abs(self.var_E3) > 135)
	{
		return lib_0A1A::func_2358(param_01,"running_forward_2");
	}

	if(scripts\common\utility::func_4347())
	{
		return lib_0A1A::func_2358(param_01,"running_forward_4");
	}

	return lib_0A1A::func_2358(param_01,"running_forward_6");
}

//Function Number: 17
func_3ECA(param_00,param_01,param_02)
{
	if(scripts\common\utility::func_4D59("head","neck"))
	{
		return lib_0A1A::func_2358(param_01,"head");
	}

	if(scripts\common\utility::func_4D59("torso_upper","torso_lower","left_arm_upper","right_arm_upper","neck"))
	{
		return lib_0A1A::func_2358(param_01,"torso");
	}

	return lib_0A1A::func_2358(param_01,"default");
}

//Function Number: 18
func_3EC6(param_00,param_01,param_02)
{
	switch(param_02)
	{
		case "cover_stand":
			return lib_0A1A::func_2358(param_01,"stand");

		case "cover_exposed":
			return lib_0A1A::func_2358(param_01,"exposed");

		case "cover_crouch":
			if(scripts\common\utility::func_4D59("head","neck") && self.var_E3 > 135 || self.var_E3 <= -45)
			{
				return lib_0A1A::func_2358(param_01,"crouch_head");
			}
	
			if(self.var_E3 > -45 && self.var_E3 <= 45)
			{
				return lib_0A1A::func_2358(param_01,"crouch_back");
			}
			return lib_0A1A::func_2358(param_01,"crouch_default");

		case "cover_right":
			if(self.var_1491.var_D6A5 == "stand")
			{
				return lib_0A1A::func_2358(param_01,"right_stand");
			}
			else
			{
				if(scripts\common\utility::func_4D59("head","neck"))
				{
					return lib_0A1A::func_2358(param_01,"right_crouch_head");
				}
	
				return lib_0A1A::func_2358(param_01,"right_crouch_default");
			}
	
			break;

		case "cover_left":
			if(self.var_1491.var_D6A5 == "stand")
			{
				return lib_0A1A::func_2358(param_01,"left_stand");
			}
			else
			{
				return lib_0A1A::func_2358(param_01,"left_crouch");
			}
	
			break;

		case "cover_3d":
			return lib_0A1A::func_2358(param_01,"3d");
	}
}

//Function Number: 19
func_3F00(param_00,param_01,param_02)
{
	if(scripts\anim\utility_common::func_9FCA())
	{
		return func_3F02(param_00,param_01,param_02);
	}

	if(isdefined(self.var_4F) && self method_8381(self.var_4F))
	{
		return func_3F01(param_00,param_01,param_02);
	}

	var_03 = [];
	if(scripts\common\utility::func_4D59("torso_lower","left_leg_upper","left_leg_lower","right_leg_lower","right_leg_lower"))
	{
		var_03[var_03.size] = lib_0A1A::func_2358(param_01,"lower_body");
	}
	else if(scripts\common\utility::func_4D59("head","helmet"))
	{
		var_03[var_03.size] = lib_0A1A::func_2358(param_01,"head");
	}
	else if(scripts\common\utility::func_4D59("neck"))
	{
		var_03[var_03.size] = lib_0A1A::func_2358(param_01,"neck");
	}
	else if(scripts\common\utility::func_4D59("torso_upper","left_arm_upper"))
	{
		var_03[var_03.size] = lib_0A1A::func_2358(param_01,"left_shoulder");
	}

	if(scripts\common\utility::func_4D59("torso_upper"))
	{
		var_03[var_03.size] = lib_0A1A::func_2358(param_01,"torso_upper");
	}

	if(self.var_E3 > 135 || self.var_E3 <= -135)
	{
		if(scripts\common\utility::func_4D59("neck","head","helmet"))
		{
			var_03[var_03.size] = lib_0A1A::func_2358(param_01,"torso_2");
		}

		if(scripts\common\utility::func_4D59("torso_upper"))
		{
			var_03[var_03.size] = lib_0A1A::func_2358(param_01,"torso_2");
		}
	}
	else if(self.var_E3 > -45 && self.var_E3 <= 45)
	{
		var_03[var_03.size] = lib_0A1A::func_2358(param_01,"back");
	}

	var_04 = var_03.size > 0;
	if(!var_04 || randomint(100) < 15)
	{
		var_03[var_03.size] = lib_0A1A::func_2358(param_01,"default");
	}

	if(randomint(100) < 10 && func_6DB2())
	{
		var_03[var_03.size] = lib_0A1A::func_2358(param_01,"default_firing");
	}

	return var_03[randomint(var_03.size)];
}

//Function Number: 20
func_3ED8(param_00,param_01,param_02)
{
	if(self.var_E3 > 135 || self.var_E3 <= -135)
	{
		var_03 = lib_0A1A::func_2358(param_01,"explosive_b");
	}
	else if(self.var_E3 > 45 && self.var_E3 <= 135)
	{
		var_03 = lib_0A1A::func_2358(param_02,"explosive_l");
	}
	else if(self.var_E3 > -45 && self.var_E3 <= 45)
	{
		var_03 = lib_0A1A::func_2358(param_02,"explosive_f");
	}
	else
	{
		var_03 = lib_0A1A::func_2358(param_02,"explosive_r");
	}

	if(getdvar("scr_expDeathMayMoveCheck","on") == "on")
	{
		var_04 = 1;
		var_05 = getnotetracktimes(var_03,"start_ragdoll");
		if(var_05.size > 0)
		{
			var_04 = var_05[0];
		}

		var_06 = getmovedelta(var_03,0,var_04);
		var_07 = self method_81E7(var_06);
		var_08 = 0;
		if(scripts\common\utility::func_167E())
		{
			var_08 = navtrace3d(self.origin,var_07,0);
		}
		else
		{
			var_08 = self method_81FF(self.origin,var_07,0,1);
		}

		if(!var_08)
		{
			var_03 = lib_0A1A::func_2358(param_01,"default");
		}
	}

	self.var_4E2C = "nogravity";
	return var_03;
}

//Function Number: 21
func_3F02(param_00,param_01,param_02)
{
	if(abs(self.var_E3) < 50)
	{
		return lib_0A1A::func_2358(param_01,"pistol_2");
	}

	var_03 = [];
	if(abs(self.var_E3) < 110)
	{
		var_03[var_03.size] = lib_0A1A::func_2358(param_01,"pistol_2");
	}

	if(scripts\common\utility::func_4D59("torso_upper","torso_lower","left_leg_upper","left_leg_lower","right_leg_upper","right_leg_lower"))
	{
		var_03[var_03.size] = lib_0A1A::func_2358(param_01,"pistol_torso_upper");
	}

	if(!scripts\common\utility::func_4D59("head","neck","helmet","left_foot","right_foot","left_hand","right_hand","gun") && randomint(2) == 0)
	{
		var_03[var_03.size] = lib_0A1A::func_2358(param_01,"pistol_upper_body");
	}

	if(var_03.size == 0 || scripts\common\utility::func_4D59("torso_lower","torso_upper","neck","head","helmet","right_arm_upper","left_arm_upper"))
	{
		var_03[var_03.size] = lib_0A1A::func_2358(param_01,"pistol_default");
	}

	return var_03[randomint(var_03.size)];
}

//Function Number: 22
func_3F01(param_00,param_01,param_02)
{
	return lib_0A1A::func_2358(param_01,"default");
}

//Function Number: 23
func_6DB2()
{
	return 0;
}

//Function Number: 24
func_CF14()
{
	self endon("killanimscript");
	if(self.var_2C0 != "none")
	{
		return;
	}

	wait(2);
	func_CCAA();
}

//Function Number: 25
func_CCAA(param_00,param_01)
{
	if(!isdefined(self))
	{
		return;
	}

	if(isdefined(self.var_10264))
	{
		return;
	}

	var_02 = self gettagorigin("j_SpineUpper");
	var_03 = self gettagangles("j_SpineUpper");
	var_04 = anglestoforward(var_03);
	var_05 = anglestoup(var_03);
	var_06 = anglestoright(var_03);
	var_02 = var_02 + var_04 * -8.5 + var_05 * 5 + var_06 * 0;
	var_07 = bullettrace(var_02 + (0,0,30),var_02 - (0,0,100),0,undefined);
	if(var_07["normal"][2] > 0.9)
	{
		playfx(level._effect["deathfx_bloodpool_generic"],var_02);
	}
}

//Function Number: 26
func_136DF(param_00)
{
	wait(param_00);
	if(isdefined(self))
	{
		scripts\anim\shared::func_5D1A();
	}

	if(isdefined(self.var_71C8))
	{
		self [[ self.var_71C8 ]]();
	}

	if(isdefined(self) && !isdefined(self.var_C089))
	{
		self method_839A();
	}
}

//Function Number: 27
func_58CB()
{
	scripts\anim\shared::func_5D1A();
	self.var_10265 = 1;
	if(isdefined(self.var_71C8))
	{
		self [[ self.var_71C8 ]]();
	}

	if(!isdefined(self))
	{
		return;
	}

	var_00 = 10;
	var_01 = scripts\common\utility::func_7E5E(self.var_DE);
	if(isdefined(self.var_4F) && self.var_4F == level.player && var_01 == "melee")
	{
		var_00 = 5;
	}

	var_02 = self.var_E1;
	if(var_01 == "bullet")
	{
		var_02 = max(var_02,300);
	}

	var_03 = var_00 * var_02;
	var_04 = max(0.3,self.var_DC[2]);
	var_05 = (self.var_DC[0],self.var_DC[1],var_04);
	if(isdefined(self.var_DC15))
	{
		var_05 = var_05 * self.var_DC15;
	}
	else
	{
		var_05 = var_05 * var_03;
	}

	if(self.var_13F)
	{
		var_05 = var_05 + self.var_249 * 20 * 10;
	}

	if(isdefined(self.var_DC1D))
	{
		var_05 = var_05 + self.var_DC1D * 10;
	}

	var_06 = self.var_DD;
	if(isdefined(self.var_DC14) && var_06 == "none")
	{
		var_06 = self.var_DC14;
	}

	if(isdefined(self.var_57E1) && self.var_57E1 == 1)
	{
		var_05 = vectornormalize((self.var_DC[0],self.var_DC[1],self.var_DC[2]));
		var_05 = var_05 * 1500;
	}

	self method_839B(var_06,var_05);
	wait(0.05);
}

//Function Number: 28
func_10025(param_00)
{
	if(isdefined(self.var_C065) && self.var_C065)
	{
		return 0;
	}

	if(isdefined(self.var_1B1) && isdefined(self.var_1B1.team) && isdefined(self.team) && self.var_1B1.team == self.team)
	{
		return 0;
	}

	if(isdefined(self.var_8E1E) && !param_00)
	{
		return 0;
	}

	if(isdefined(self.var_C554) && self.var_C554)
	{
		return 0;
	}

	if(isdefined(self.var_B14F) && self.var_B14F)
	{
		return 0;
	}

	if(isdefined(self.var_DD) && self.var_DD == "helmet")
	{
		return 1;
	}

	if(param_00 && randomint(2) == 0)
	{
		return 1;
	}

	return 0;
}

//Function Number: 29
func_10024(param_00)
{
	if(isdefined(self.var_C065) && self.var_C065)
	{
		return 0;
	}

	if(self.var_12BA4 != "soldier")
	{
		return 0;
	}

	if(self.var_DE == "MOD_MELEE" && randomint(3) < 2)
	{
		return 0;
	}

	if(self.var_DD == "helmet" || self.var_DD == "head")
	{
		return 1;
	}

	if(param_00 && randomint(3) == 0)
	{
		return 1;
	}

	return 0;
}

//Function Number: 30
func_8E17()
{
	if(!isdefined(self))
	{
		return;
	}

	if(!isdefined(self.var_8C43))
	{
		return;
	}

	if(isdefined(self.var_5952) && self.var_5952)
	{
		return;
	}

	var_00 = self gettagorigin("j_head");
	if(isdefined(self.var_8E1A))
	{
		var_01 = anglestoforward(self gettagangles("j_head"));
		playfx(self.var_8E1A,var_00,var_01);
	}

	function_0178("bullet_small_flesh_helmet_npc",var_00);
	if(isdefined(self.var_8E1E))
	{
		self.var_8E1E = undefined;
		var_02 = self method_850C("helmet","helmet");
		if(var_02 > 0)
		{
			self method_850B(var_02,"helmet","helmet");
		}
	}

	self detach(self.var_8C43,"");
	self.var_8C43 = undefined;
	if(isalive(self) && func_1005A())
	{
		playfxontag(level.var_7649["helmet_break_suffocate"],self,"j_head");
		if(self.var_238F != "zero_gravity_space" && self.var_238F != "zero_gravity")
		{
			self.var_4E30 = 1;
		}

		self method_81D0();
	}
}

//Function Number: 31
func_8183()
{
	var_00 = undefined;
	if(randomint(11) >= 1)
	{
		return var_00;
	}

	if(self.var_1491.var_D6A5 == "stand")
	{
		var_01 = [%hm_grnd_red_exposed_death_neck_falls_8_ar,%hm_grnd_red_exposed_death_neck_falls_4_ar];
		var_00 = scripts\common\utility::random(var_01);
	}
	else if(self.var_1491.var_D6A5 == "crouch")
	{
		var_00 = %cornercrr_alert_death_neck;
	}

	return var_00;
}

//Function Number: 32
func_1005A()
{
	if(scripts\common\utility::istrue(self.var_C015))
	{
		return 0;
	}

	if(scripts\common\utility::istrue(self.var_4E52))
	{
		return 1;
	}

	if(scripts\sp\_utility::func_ABD9())
	{
		return 0;
	}

	return 1;
}

//Function Number: 33
func_10021(param_00)
{
	if(self.var_12BA4 != "soldier")
	{
		return 0;
	}

	if(isdefined(self.var_72C9))
	{
		return 1;
	}

	if(self.var_DE == "MOD_MELEE")
	{
		return 0;
	}

	if(self.var_E2 == "none")
	{
		return 0;
	}

	if(randomint(3) == 0)
	{
		if(param_00)
		{
			return 1;
		}

		if(scripts\anim\utility::func_9DDB(self.var_E2) && self.var_DD == "helmet" || self.var_DD == "head")
		{
			return 1;
		}
	}

	return 0;
}

//Function Number: 34
func_8C99()
{
	if(!isdefined(self.var_8C98))
	{
		return;
	}

	var_00 = self gettagorigin("j_head");
	var_01 = anglestoforward(self gettagangles("j_head"));
	playfxontag(level.var_7649["human_gib_head"],self,"j_head");
	self detach(self.var_8C98,"");
	self.var_8C98 = undefined;
}

//Function Number: 35
func_4A7E(param_00,param_01)
{
	return param_00[0] * param_01[1] - param_01[0] * param_00[1];
}

//Function Number: 36
func_B60C(param_00,param_01)
{
	var_02 = vectordot(param_01,param_00);
	var_03 = cos(60);
	if(squared(var_02) < squared(var_03))
	{
		if(func_4A7E(param_00,param_01) > 0)
		{
			return 1;
		}

		return 3;
	}

	if(var_02 < 0)
	{
		return 0;
	}

	return 2;
}

//Function Number: 37
func_C703()
{
	if(scripts\sp\_utility::func_9DB4("iw7_knife_upgrade1") || scripts\sp\_utility::func_9DB4("iw7_sonic"))
	{
		return;
	}

	if(self.var_DE == "MOD_MELEE" && isdefined(self.var_4F) && !scripts\common\utility::func_1390D() && !scripts\sp\_utility::func_9DB4("iw7_sonic"))
	{
		if(scripts\common\utility::func_167E())
		{
			var_00 = self.var_4F.origin - self.origin;
			var_01 = function_02D7(var_00,self.angles);
			self method_8221("face angle 3d",var_01);
			return;
		}

		var_02 = self.origin - self.var_4F.origin;
		var_03 = anglestoforward(self.angles);
		var_04 = vectornormalize((var_02[0],var_02[1],0));
		var_05 = vectornormalize((var_03[0],var_03[1],0));
		var_06 = func_B60C(var_05,var_04);
		var_07 = var_06 * 90;
		var_08 = (-1 * var_04[0],-1 * var_04[1],0);
		var_09 = rotatevector(var_08,(0,var_07,0));
		var_0A = vectortoyaw(var_09);
		self method_8221("face angle",var_0A);
	}
}

//Function Number: 38
func_CF16(param_00)
{
	if(scripts\common\utility::func_4D59("head","helmet") && !scripts\common\utility::func_1390D() && !scripts\sp\_utility::func_9DB4("iw7_sonic"))
	{
		return;
	}

	if(isdefined(self.var_EF) && self.var_EF)
	{
		return;
	}

	if(param_00)
	{
		scripts\anim\face::func_EB83("explodeath");
		return;
	}

	scripts\anim\face::func_EB83("death");
}

//Function Number: 39
func_E166(param_00)
{
	for(var_01 = 0;var_01 < level.var_10AE5.size;var_01++)
	{
		level.var_10AE5[var_01] func_41DC(param_00);
	}
}

//Function Number: 40
func_41DC(param_00)
{
	if(!isdefined(self.var_101E5))
	{
		return;
	}

	if(distance(param_00,self.var_101E5) < 80)
	{
		self.var_101E5 = undefined;
		self.var_101E8 = gettime();
	}
}

//Function Number: 41
func_9D59(param_00,param_01)
{
	if(!isdefined(param_00))
	{
		return 0;
	}

	if(distance(self.origin,param_00.origin) > param_01)
	{
		return 0;
	}

	return 1;
}

//Function Number: 42
func_9F6D(param_00,param_01,param_02,param_03)
{
	if(lib_0A1E::func_9F4C())
	{
		return 1;
	}

	return 0;
}

//Function Number: 43
func_3EFD(param_00,param_01,param_02)
{
	if(lib_0A1E::func_9F4C())
	{
		return lib_0A1A::func_2358(param_01,"shock_death");
	}

	return lib_0A1A::func_2358("death_generic","default");
}

//Function Number: 44
func_1001C()
{
	if(isdefined(self.var_C061))
	{
		return 0;
	}

	if(self.var_12BA4 != "soldier" && self.var_12BA4 != "c6" && self.var_12BA4 != "civilian")
	{
		return 0;
	}

	if(isdefined(self.var_FE4A))
	{
		return 0;
	}

	if(isdefined(self.var_DE) && self.var_DE == "MOD_MELEE")
	{
		return 0;
	}

	if(isdefined(self.var_DE) && function_0107(self.var_DE))
	{
		if(self.var_E1 > 120)
		{
			return 1;
		}
	}

	if(scripts\sp\_utility::func_9DB4("iw7_penetrationrail"))
	{
		return 1;
	}

	if(scripts\sp\_utility::func_9DB4("iw7_ake_gold") && self.var_DD == "head" || self.var_DD == "helmet")
	{
		return 1;
	}

	if(scripts\sp\_utility::func_9DB4("iw7_devastator") && scripts\sp\_utility::func_9FFE(self.var_E2) && self.var_E1 > 120)
	{
		return 1;
	}

	return function_02BE(self.var_E2);
}

//Function Number: 45
func_58B9(param_00)
{
	var_01 = param_00 gettagorigin("j_spine4");
	playfx(level.var_7649["human_gib_fullbody"],var_01,(1,0,0));
	var_02 = spawn("script_origin",var_01);
	var_02 playsound("gib_fullbody","sounddone");
	var_02 waittill("sounddone");
	wait(0.1);
	var_02 delete();
}

//Function Number: 46
func_58B8()
{
	if(isdefined(self.var_828B))
	{
		level thread [[ self.var_828B ]](self);
		return;
	}

	level thread func_58B9(self);
}

//Function Number: 47
func_10051(param_00,param_01,param_02,param_03)
{
	if(isdefined(self.var_E2) && function_024C(self.var_E2) == "shield" || self.var_E2 == "iw7_mauler_c8hack" || self.var_E2 == "iw7_c6hack_melee" || self.var_E2 == "iw7_c6worker_fists")
	{
		return 1;
	}

	if(isdefined(self.var_1B1) && isdefined(self.var_1B1.var_12BA4) && self.var_1B1.var_12BA4 == "c8" && isdefined(self.var_DE) && self.var_DE == "MOD_MELEE")
	{
		return 1;
	}

	return 0;
}

//Function Number: 48
func_5AA8(param_00,param_01,param_02,param_03)
{
	func_11043();
	scripts\anim\shared::func_5D1A();
	var_04 = vectornormalize(self.origin - level.player.origin + (0,0,30));
	if(self.var_E2 == "iw7_c6hack_melee" || self.var_E2 == "iw7_c6worker_fists")
	{
		var_04 = vectornormalize(self.origin - level.player.origin + (0,0,30) + anglestoright(level.player.angles) * 50);
	}

	self method_82B1(lib_0A1E::func_2342(),0);
	if(isdefined(self.var_71C8))
	{
		self [[ self.var_71C8 ]]();
	}

	if(!isdefined(self))
	{
		return;
	}

	self method_839B("torso_upper",var_04 * 2400);
	if(isdefined(self.var_12BA4) && self.var_12BA4 == "c6")
	{
		self playsound("shield_death_c6_1");
	}

	level.player method_8244("damage_heavy");
	earthquake(0.5,1,level.player.origin,100);
	level.player scripts\common\utility::delaycall(0.25,::stoprumble,"damage_heavy");
	wait(1);
	func_4E36();
}

//Function Number: 49
func_FFF0(param_00,param_01,param_02,param_03)
{
	if(isdefined(self.var_E2) && self.var_E2 == "iw7_knife_upgrade1")
	{
		return 1;
	}

	return 0;
}

//Function Number: 50
func_58E4(param_00,param_01,param_02,param_03)
{
	if(isdefined(self.var_A709))
	{
		return;
	}

	self.var_A709 = 1;
	var_04 = undefined;
	level.player method_8244("damage_heavy");
	earthquake(0.5,1,level.player.origin,100);
	thread scripts\sp\_art::func_583F(0,1,0.02,203,211,3,0.05);
	if(self.var_1491.var_D6A5 == "stand")
	{
		var_04 = "shock_loop_stand";
	}
	else if(self.var_1491.var_D6A5 == "crouch")
	{
		var_04 = "shock_loop_crouch";
	}

	playfxontag(level.var_7649["c6_death"],self,"j_spine4");
	if(soundexists("shock_knife_blast"))
	{
		function_0178("shock_knife_blast",level.player geteye());
	}

	thread lib_0C66::func_FE4E(param_00,var_04,0.02,1,0,1);
	wait(0.5);
	self notify(var_04 + "_finished");
	self method_83AD();
	level.player stoprumble("damage_heavy");
	thread scripts\sp\_art::func_583D(0.5);
	func_CF0E(param_00,"death_shocked");
}

//Function Number: 51
playatomizerfx(param_00)
{
	playfx(level.var_7649["atomize_body"],self gettagorigin(param_00),anglestoforward(self gettagangles(param_00)));
}

//Function Number: 52
func_2453()
{
	self.var_10264 = 1;
	self playsound("bullet_atomizer_impact_npc");
	var_00[0][0] = "j_spineupper";
	var_00[0][1] = "j_spinelower";
	var_00[0][2] = "j_head";
	var_00[0][3] = "j_shoulder_ri";
	var_00[0][4] = "j_shoulder_le";
	var_00[1][0] = "j_knee_ri";
	var_00[1][1] = "j_knee_le";
	var_00[1][2] = "j_elbow_ri";
	var_00[1][3] = "j_elbow_le";
	var_00[1][4] = "j_hip_ri";
	var_00[1][5] = "j_hip_le";
	var_00[2][0] = "j_ankle_le";
	var_00[2][1] = "j_ankle_ri";
	var_00[2][2] = "j_wrist_le";
	var_00[2][3] = "j_wrist_ri";
	foreach(var_02 in var_00)
	{
		if(!isdefined(self))
		{
			return;
		}

		foreach(var_04 in var_02)
		{
			playatomizerfx(var_04);
		}

		wait(0.05);
	}

	self hide();
	self.var_C089 = 1;
	scripts\anim\shared::func_5D1A();
}

//Function Number: 53
atomizercheckpartdismembered(param_00)
{
	if(!isdefined(self.var_1198))
	{
		return 0;
	}

	if(!isdefined(self.var_1198.var_EF3B))
	{
		return 0;
	}

	if(!isdefined(self.var_1198.var_EF3B[param_00]))
	{
		return 0;
	}

	return self.var_1198.var_EF3B[param_00].var_10E19 == "dismember";
}

//Function Number: 54
atomizerrobotbodyfx()
{
	self playsound("bullet_atomizer_impact_npc");
	playatomizerfx("j_spinelower");
	playatomizerfx("j_shoulder_ri");
	playatomizerfx("j_shoulder_le");
	if(!lib_0A1B::func_9ED3("head"))
	{
		playatomizerfx("j_head");
	}

	if(!lib_0A1B::func_9ED3("right_leg"))
	{
		playatomizerfx("j_knee_ri");
	}

	if(!lib_0A1B::func_9ED3("left_leg"))
	{
		playatomizerfx("j_knee_le");
	}

	if(!lib_0A1B::func_9ED3("right_arm"))
	{
		if(scripts\common\utility::func_4347())
		{
			playatomizerfx("j_elbow_ri");
		}
		else
		{
			playatomizerfx("j_wrist_ri");
		}
	}

	if(!lib_0A1B::func_9ED3("left_arm") && self.var_12BA4 != "c8")
	{
		if(scripts\common\utility::func_4347())
		{
			playatomizerfx("j_elbow_le");
		}
		else
		{
			playatomizerfx("j_wrist_le");
		}
	}

	anim thread [[ self.var_3135.var_71CC ]](self);
}