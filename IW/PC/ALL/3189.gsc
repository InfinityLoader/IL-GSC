/*******************************************************************
 * Decompiled By: Bog
 * Decompiled File: 3189.gsc
 * Game: Call of Duty: Infinite Warfare
 * Platform: PC
 * Function Count: 112
 * Decompile Time: 52 ms
 * Timestamp: 10/27/2023 12:26:29 AM
*******************************************************************/

//Function Number: 1
func_13F9A(param_00,param_01,param_02,param_03)
{
	self.var_2303.var_7257 = spawnstruct();
	self.var_2303.var_7257.var_7254 = "invalid";
	self.var_2303.var_7257.time = 0;
	self.var_2303.var_4C86 = spawnstruct();
	self.var_2303.var_7360 = 0;
	self.var_71D0 = ::func_1004F;
	self.var_7198 = ::func_38B2;
	self.var_BC09 = [];
	self.var_246 = 64;
}

//Function Number: 2
func_3EFC(param_00,param_01,param_02)
{
	if(isdefined(self.spawner) && isdefined(self.spawner.var_ECF5))
	{
		var_03 = "";
		switch(self.var_1F5)
		{
			case "walk":
			case "slow_walk":
				var_03 = "_walk";
				break;

			case "sprint":
			case "run":
				var_03 = "_run";
				break;

			default:
				break;
		}

		if(lib_0A1D::func_2347(param_01,self.spawner.var_ECF5 + var_03))
		{
			return lib_0A1A::func_2358(param_01,self.spawner.var_ECF5 + var_03);
		}
		else if(lib_0A1D::func_2347(param_01,self.spawner.var_ECF5))
		{
			return lib_0A1A::func_2358(param_01,self.spawner.var_ECF5);
		}
	}

	if(!isdefined(param_02))
	{
		return lib_0F3C::func_3EF4(param_00,param_01,param_02);
	}

	return lib_0A1A::func_2358(param_01,param_02);
}

//Function Number: 3
func_3EFB(param_00,param_01,param_02)
{
	if(isdefined(self.spawner) && isdefined(self.spawner.var_ECF5))
	{
		var_03 = "";
		switch(self.var_1F5)
		{
			case "walk":
			case "slow_walk":
				var_03 = "_walk";
				break;

			case "sprint":
			case "run":
				var_03 = "_run";
				break;

			default:
				break;
		}

		if(lib_0A1D::func_2347(param_01,self.spawner.var_ECF5 + var_03))
		{
			return lib_0A1A::func_2358(param_01,self.spawner.var_ECF5 + var_03);
		}
		else if(lib_0A1D::func_2347(param_01,self.spawner.var_ECF5))
		{
			return lib_0A1A::func_2358(param_01,self.spawner.var_ECF5);
		}
	}

	if(!isdefined(param_02))
	{
		return lib_0F3C::func_3EF4(param_00,param_01,param_02);
	}

	return lib_0A1A::func_2358(param_01,param_02);
}

//Function Number: 4
func_3EE0(param_00,param_01,param_02)
{
	if(!isdefined(param_02))
	{
		return lib_0F3C::func_3EF4(param_00,param_01,param_02);
	}

	return lib_0A1A::func_2358(param_01,param_02);
}

//Function Number: 5
func_3EE1(param_00,param_01,param_02)
{
	var_03 = 0;
	var_04 = 0;
	var_05 = self method_8100(param_01);
	if(var_05 == 1)
	{
		self.var_BC09[param_01] = 0;
	}
	else if(!isdefined(self.var_BC09[param_01]))
	{
		self.var_BC09[param_01] = randomintrange(0,var_05);
	}

	self.var_2303.var_BCD3 = tolower(self.var_BC09[param_01] + 1);
	if(isdefined(param_02))
	{
		self.var_2303.var_BCD3 = param_02 + self.var_2303.var_BCD3;
	}

	return self.var_BC09[param_01];
}

//Function Number: 6
func_3EF1(param_00,param_01,param_02,param_03)
{
	var_04 = self method_8100(param_01);
	var_05 = lib_0F74::func_4D52(self.var_4D62,self.var_DC);
	var_06 = angleclamp180(var_05 - self.angles[1]);
	var_07 = lib_0F74::func_8040(var_06,var_04);
	return var_07;
}

//Function Number: 7
func_D4F5(param_00,param_01,param_02,param_03)
{
	self endon("death");
	self endon("terminate_ai_threads");
	var_04 = lib_0A1D::func_2337(param_00,param_01);
	if(isdefined(self.var_233))
	{
		self method_8281("code_move");
		self method_8289("face motion");
	}

	var_05 = self method_80FD(param_01,var_04);
	var_06 = getanimlength(var_05);
	var_07 = 1;
	if(isdefined(self.var_C081) && self.var_C081 > 0)
	{
		var_07 = self.var_C081;
	}

	var_06 = var_06 * 1 / var_07;
	self.var_BF9E = gettime() + var_06 * 0.75 * 1000;
	scripts\mp\agents\_scriptedagents::func_CED3(param_01,var_04,self.var_C081,"pain_anim");
	func_6CE0(param_00,param_01,param_03);
}

//Function Number: 8
func_D4F3(param_00,param_01,param_02,param_03)
{
	self endon("death");
	self endon(param_01 + "_finished");
	if(lib_0A1D::func_2347(param_01,self.var_2303.var_BCD3))
	{
		var_04 = lib_0A1D::func_235A(param_01,self.var_2303.var_BCD3);
	}
	else
	{
		var_04 = lib_0F3C::func_3EF4(param_01,param_02,var_04);
	}

	var_05 = lib_0A1A::func_2341(param_00,param_01);
	thread scripts\mp\agents\_scriptedagents::func_CED5(param_01,var_04,param_01,"end",var_05);
	self.var_BF9E = gettime() + 10000;
	wait(0.35);
	lib_0A1A::func_2330(param_01,"end");
}

//Function Number: 9
func_9DB2(param_00,param_01,param_02,param_03)
{
	var_04 = func_4D41();
	if(scripts\common\utility::func_4D59("torso_upper","torso_lower") && isdefined(var_04) && var_04 >= 0)
	{
		return 1;
	}

	return scripts\common\utility::func_4D59("left_arm_upper","left_arm_lower","left_hand","left_leg_upper","left_foot","left_leg_lower");
}

//Function Number: 10
func_9DB3(param_00,param_01,param_02,param_03)
{
	var_04 = func_4D41();
	if(scripts\common\utility::func_4D59("torso_upper","torso_lower") && isdefined(var_04) && var_04 < 0)
	{
		return 1;
	}

	return scripts\common\utility::func_4D59("right_arm_upper","right_arm_lower","right_hand","right_leg_upper","right_foot","right_leg_lower");
}

//Function Number: 11
func_9DB1(param_00,param_01,param_02,param_03)
{
	return scripts\common\utility::func_4D59("head","neck","helmet");
}

//Function Number: 12
func_4D41()
{
	var_00 = lib_0F74::func_4D52(self.var_4D62,self.var_DC);
	var_01 = angleclamp180(var_00 - self.angles[1]);
	return var_01;
}

//Function Number: 13
func_6CE0(param_00,param_01,param_02)
{
	self notify("killanimscript");
	var_03 = level.var_2303[param_00].var_10E2F[param_01];
	var_04 = undefined;
	if(isarray(param_02))
	{
		var_04 = param_02[0];
	}
	else
	{
		var_04 = param_02;
	}

	if(!isdefined(var_04))
	{
		if(isdefined(var_03.var_1267B) && var_03.var_1267B.size > 0)
		{
			return;
		}

		var_04 = "choose_idle";
	}

	lib_0A1A::func_2388(param_00,param_01,var_03,var_03.var_116FB);
	lib_0A1A::func_238A(param_00,var_04,0.2,undefined,undefined,undefined);
}

//Function Number: 14
func_1004F()
{
	if(isdefined(self.allowpain) && self.allowpain == 0)
	{
		return 0;
	}

	if(isdefined(self.var_9E0C) && self.var_9E0C)
	{
		return 0;
	}

	if(isdefined(self.var_BF9E) && gettime() < self.var_BF9E)
	{
		return 0;
	}

	if(!isdefined(self.var_233))
	{
		return 0;
	}

	if(isdefined(level.no_pain_volume) && self istouching(level.no_pain_volume))
	{
		return 0;
	}

	if(!scripts\common\utility::istrue(self.var_11196))
	{
		if(lib_0A1B::func_2953())
		{
			return 0;
		}

		if(lib_0A1B::func_2952())
		{
			return 0;
		}
	}

	return 1;
}

//Function Number: 15
func_9E89(param_00)
{
	switch(param_00)
	{
		case "right_foot":
		case "left_foot":
		case "right_leg_lower":
		case "right_leg_upper":
		case "left_leg_lower":
		case "left_leg_upper":
			return 1;

		default:
			return 0;
	}
}

//Function Number: 16
func_9EAB(param_00,param_01,param_02,param_03)
{
	return !lib_0A1B::func_2955();
}

//Function Number: 17
func_BE92()
{
	if(isdefined(self.var_565C))
	{
		return self.var_565C;
	}

	return 0;
}

//Function Number: 18
func_BE99(param_00,param_01,param_02,param_03)
{
	return lib_0A1B::func_2956("run");
}

//Function Number: 19
func_BE9A(param_00,param_01,param_02,param_03)
{
	if(func_9F87())
	{
		return 1;
	}

	return lib_0A1B::func_2956("sprint");
}

//Function Number: 20
func_BE9B()
{
	if(func_9F87() && func_1005C() && !func_8C13())
	{
		return 1;
	}

	return 0;
}

//Function Number: 21
func_BE97()
{
	if(isdefined(self.spawner) && isdefined(self.spawner.var_ECF5))
	{
		return !scripts\common\utility::istrue(self.hasplayedvignetteanim);
	}

	return 0;
}

//Function Number: 22
func_BE95(param_00,param_01,param_02,param_03)
{
	return isdefined(self.var_AD2B);
}

//Function Number: 23
func_BE96()
{
	if(isdefined(self.spawner) && isdefined(self.spawner.script_fxid))
	{
		return !scripts\common\utility::istrue(self.var_8C12);
	}

	return 0;
}

//Function Number: 24
func_1009C()
{
	if(isdefined(self.var_AD2B))
	{
		return 0;
	}

	return 1;
}

//Function Number: 25
func_BCCD()
{
	if(isdefined(self.agent_type) && self.agent_type == "zombie_brute")
	{
		return 0;
	}

	var_00 = isdefined(self.var_2303.var_4B12) && self.var_2303.var_4B12 != self.var_1198.var_BD23;
	if(var_00)
	{
		return 1;
	}

	return 0;
}

//Function Number: 26
func_9E0F()
{
	return scripts\common\utility::istrue(self.var_2B0F);
}

//Function Number: 27
func_9F87()
{
	return scripts\common\utility::istrue(self.var_9CDD);
}

//Function Number: 28
func_1005C()
{
	return scripts\common\utility::istrue(self.var_FF78);
}

//Function Number: 29
func_8C13()
{
	return scripts\common\utility::istrue(self.var_8C13);
}

//Function Number: 30
func_9D8C(param_00,param_01,param_02,param_03)
{
	if(isdefined(self.var_9CDD))
	{
		return 1;
	}

	return 0;
}

//Function Number: 31
func_9D94(param_00,param_01,param_02,param_03)
{
	if(self.agent_type == "zombie_cop")
	{
		if(getdvarint("scr_dont_use_cop_anims") != 0)
		{
			return 0;
		}

		return 1;
	}

	return 0;
}

//Function Number: 32
func_1005E(param_00,param_01,param_02,param_03)
{
	if(!scripts\common\utility::istrue(self.var_9CEC) && !scripts\common\utility::istrue(self.var_4C87))
	{
		return scripts\mp\agents\zombie\zmb_zombie_agent::func_5F70();
	}

	return 0;
}

//Function Number: 33
func_10046(param_00,param_01,param_02,param_03)
{
	return scripts\common\utility::istrue(self.rocket_feet);
}

//Function Number: 34
choosefacemelteranim(param_00,param_01,param_02,param_03)
{
	self notify("facemelter_launch_chosen");
	if(scripts\common\utility::istrue(self.var_565C))
	{
		return "prone_launch";
	}

	return "launch";
}

//Function Number: 35
func_6A79(param_00,param_01,param_02,param_03)
{
	self notify("ready_to_launch");
}

//Function Number: 36
func_10042(param_00,param_01,param_02,param_03)
{
	return scripts\common\utility::istrue(self.dischord_spin);
}

//Function Number: 37
choosedischordanim(param_00,param_01,param_02,param_03)
{
	if(scripts\common\utility::istrue(self.var_565C))
	{
		return "prone_spin";
	}

	return "spin";
}

//Function Number: 38
func_5626(param_00,param_01,param_02,param_03)
{
	self notify("ready_to_spin");
}

//Function Number: 39
func_10049(param_00,param_01,param_02,param_03)
{
	return scripts\common\utility::istrue(self.head_is_exploding);
}

//Function Number: 40
chooseheadcutteranim(param_00,param_01,param_02,param_03)
{
	if(scripts\common\utility::istrue(self.var_565C))
	{
		return "prone_expand_head";
	}

	return "expand_head";
}

//Function Number: 41
func_10053(param_00,param_01,param_02,param_03)
{
	return 0;
}

//Function Number: 42
func_D532(param_00,param_01,param_02,param_03)
{
	self endon(param_01 + "_finished");
	self.var_EF64 = 1;
	self method_828A("noclip");
	var_04 = lib_0A1D::func_2337(param_00,param_01);
	var_05 = 0.01;
	thread lib_0A1D::func_2365(param_00,param_01,param_02,var_04,var_05);
	if(isdefined(level.spawn_fx_func))
	{
		self [[ level.spawn_fx_func ]]();
	}

	wait(0.5);
	self.var_8C12 = 1;
}

//Function Number: 43
func_D4DB(param_00,param_01,param_02,param_03)
{
	self endon(param_01 + "_finished");
	self.var_EF64 = 1;
	self method_828A("noclip");
	thread lib_0F3C::func_CEA8(param_00,param_01,param_02,param_03);
	wait(1);
	level thread [[ level.var_B652 ]](self);
}

//Function Number: 44
func_D571(param_00,param_01,param_02,param_03)
{
	self endon(param_01 + "_finished");
	self.var_EF64 = 1;
	self.var_9CEC = 1;
	self.vignette_nocorpse = 1;
	self.var_180 = 1;
	self method_828A("noclip");
	scripts\mp\agents\_scriptedagents::func_F85E(1,"play_vignette_anim");
	self.hasplayedvignetteanim = 0;
	if(isdefined(self.spawner) && isdefined(self.spawner.var_ABA7))
	{
		thread func_C3C6(param_00,param_01);
	}

	var_04 = lib_0A1D::func_2337(param_00,param_01);
	var_05 = 1;
	var_06 = self.do_immediate_ragdoll;
	self.do_immediate_ragdoll = 1;
	lib_0A1D::func_2365(param_00,param_01,param_02,var_04,var_05);
	self.do_immediate_ragdoll = var_06;
	self method_828A("gravity");
	self.var_EF64 = 0;
	self.var_180 = 0;
	scripts\mp\agents\_scriptedagents::func_F85E(0,"play_vignette_anim");
	self.vignette_nocorpse = undefined;
	self.hasplayedvignetteanim = 1;
	self notify("intro_vignette_done");
}

//Function Number: 45
func_11702(param_00,param_01,param_02)
{
	self method_828A("gravity");
	self.var_EF64 = 0;
	self.hasplayedvignetteanim = 1;
	self.var_9CEC = undefined;
	self.vignette_nocorpse = undefined;
}

//Function Number: 46
func_ABA5(param_00,param_01)
{
	self endon(param_01 + "_finished");
	var_02 = lib_0A1D::func_2337(param_00,param_01);
	var_03 = self method_80FD(param_01,var_02);
	var_04 = getanimlength(var_03);
	var_05 = getnotetracktimes(var_03,"fall");
	var_06 = getnotetracktimes(var_03,"land");
	var_07 = getmovedelta(var_03,var_05[0],var_06[0]);
	self method_8282(1,1);
	var_08 = 1;
	scripts\mp\agents\_scriptedagents::func_CED3(param_01,var_02,var_08,param_01,"fall",undefined);
	if(var_07 == (0,0,0))
	{
		self method_828A("gravity");
		return;
	}

	var_09 = scripts\common\utility::func_5D14(self.origin,0,-2000);
	var_09 = self.spawner.var_ABA6;
	var_0A = var_09 - self.origin;
	var_0B = var_0A[2] / var_07[2];
	var_0C = var_04 * var_06[0] - var_04 * var_05[0];
	var_0D = var_0C * var_0B;
	if(var_0B >= 1)
	{
		self method_8282(1,var_0B);
		var_08 = 1 / var_0B;
		scripts\mp\agents\_scriptedagents::func_CED3(param_01,var_02,var_08,param_01,"land",undefined);
		var_08 = 1;
		self method_828A("gravity");
		self method_8282(1,1);
		scripts\mp\agents\_scriptedagents::func_CED3(param_01,var_02,var_08,param_01,"end",undefined);
	}
}

//Function Number: 47
func_C3C6(param_00,param_01)
{
	self endon(param_01 + "_finished");
	var_02 = lib_0A1D::func_2337(param_00,param_01);
	var_03 = self method_80FD(param_01,var_02);
	var_04 = getanimlength(var_03);
	var_05 = getnotetracktimes(var_03,"fall");
	var_06 = getnotetracktimes(var_03,"land");
	var_07 = getmovedelta(var_03,var_05[0],var_06[0]);
	scripts\mp\agents\_scriptedagents::func_1384C(param_01,"fall",param_01,var_02,undefined);
	if(var_07 == (0,0,0))
	{
		self method_828A("gravity");
		return;
	}

	var_08 = scripts\common\utility::func_5D14(self.origin,0,-2000);
	var_08 = self.spawner.var_ABA6;
	var_09 = var_08 - self.origin;
	var_0A = var_09[2] / var_07[2];
	var_0B = var_04 * var_06[0] - var_04 * var_05[0];
	var_0C = var_0B * var_0A;
	if(var_0A >= 1)
	{
		self method_8282(1,var_0A);
		scripts\mp\agents\_scriptedagents::func_1384C(param_01,"land",param_01,var_02,undefined);
		self method_828A("gravity");
		self method_8282(1,1);
	}
}

//Function Number: 48
func_D4AC(param_00,param_01,param_02,param_03)
{
	if(isdefined(self.spawner) && isdefined(self.spawner.var_ABA7))
	{
		return 1;
	}

	return 0;
}

//Function Number: 49
func_D544(param_00,param_01,param_02,param_03)
{
	self endon(param_01 + "_finished");
	lib_0F3C::func_CEA8(param_00,param_01,param_02,param_03);
	self.var_8C13 = 1;
}

//Function Number: 50
func_129A3(param_00)
{
	self.entered_playspace = 1;
	self.var_9CDD = 1;
	self.nocorpse = 1;
	self.var_FF78 = param_00;
	self.health = func_3725();
	self.var_180 = 0;
	self setscriptablepartstate("eyes","eye_glow_off");
	self detachall();
	var_01 = ["park_clown_zombie","park_clown_zombie_blue","park_clown_zombie_green","park_clown_zombie_orange","park_clown_zombie_yellow"];
	var_02 = scripts\common\utility::random(var_01);
	self setmodel(var_02);
	lib_0A1B::func_2968("sprint");
	if(isdefined(level.suicider_avoidance_radius))
	{
		self method_84E6(level.suicider_avoidance_radius);
	}
}

//Function Number: 51
func_3725()
{
	var_00 = 200;
	switch(level.var_1096B)
	{
		case 0:
			var_00 = 100;
			break;

		case 1:
			var_00 = 400;
			break;

		case 2:
			var_00 = 900;
			break;

		case 3:
			var_00 = 1300;
			break;

		default:
			var_00 = 1600;
			break;
	}

	return var_00;
}

//Function Number: 52
func_10057(param_00,param_01,param_02,param_03)
{
	if(scripts\mp\agents\_scriptedagents::func_9F77())
	{
		return 0;
	}

	if(self.var_1B03 == "traverse")
	{
		return 0;
	}

	if(isdefined(param_02) && function_0107(param_02) && param_00 >= 350)
	{
		if(isdefined(param_01) && !issubstr(param_01,"g18pap"))
		{
			return 1;
		}
	}

	if(isdefined(param_02) && param_02 == "MOD_MELEE")
	{
		return 1;
	}

	if(isdefined(self.var_11190))
	{
		if(self.var_11190 > gettime())
		{
			return 1;
		}
		else
		{
			self.var_11190 = undefined;
			self.var_11196 = undefined;
		}
	}

	if(scripts\common\utility::istrue(self.var_11196))
	{
		return 1;
	}

	if(isdefined(self.var_10058) && [[ self.var_10058 ]]())
	{
		return 1;
	}

	return 0;
}

//Function Number: 53
func_FFE7()
{
	if(!lib_0F3A::func_FFE6())
	{
		return 0;
	}

	if(isdefined(self.var_4B26))
	{
		return 0;
	}

	if(isdefined(self.var_6658))
	{
		return 0;
	}

	return 1;
}

//Function Number: 54
func_10092(param_00,param_01,param_02,param_03)
{
	if(!func_FFE7())
	{
		return 0;
	}

	if(!isdefined(self.var_233))
	{
		return 0;
	}

	var_04 = lib_0A1A::func_233A(param_00);
	if(!lib_0A1A::func_232B(var_04,"cover_approach"))
	{
		return 0;
	}

	if(!isdefined(self.var_20EE))
	{
		return 0;
	}

	if(isdefined(self.var_9E0C) && self.var_9E0C)
	{
		self.var_20EE = undefined;
		return 0;
	}

	if(!isdefined(param_03) || param_03.size < 1)
	{
		var_05 = "Exposed";
	}
	else
	{
		var_05 = var_04[0];
	}

	if(!lib_0F3A::func_9D4C(param_00,param_01,param_02,var_05))
	{
		return 0;
	}

	self.var_2303.var_11068 = func_3724(param_00,param_02,var_05);
	if(!isdefined(self.var_2303.var_11068))
	{
		return 0;
	}

	return 1;
}

//Function Number: 55
func_3724(param_00,param_01,param_02)
{
	var_03 = lib_0F3A::func_7DD6();
	if(isdefined(var_03))
	{
		var_04 = var_03.origin;
	}
	else
	{
		var_04 = self.var_233;
	}

	var_05 = lib_0F3A::func_7E54();
	var_06 = self.var_20EE;
	var_07 = vectortoangles(var_06);
	if(isdefined(var_05))
	{
		var_08 = angleclamp180(var_05[1] - var_07[1]);
	}
	else if(isdefined(var_04) && var_04.type != "Path")
	{
		var_08 = angleclamp180(var_04.angles[1] - var_08[1]);
	}
	else
	{
		var_09 = var_05 - self.origin;
		var_0A = vectortoangles(var_09);
		var_08 = angleclamp180(var_0A[1] - var_07[1]);
	}

	var_0B = param_01;
	var_0C = lib_0F3A::func_8177();
	var_0D = var_04 - self.origin;
	var_0E = lengthsquared(var_0D);
	var_0F = 0;
	var_10 = self method_80FD(var_0B,var_0F);
	var_11 = getmovedelta(var_10);
	var_12 = getangledelta(var_10);
	var_13 = length(self getvelocity());
	var_14 = var_13 * 0.053;
	var_15 = length(var_0D);
	var_16 = length(var_11);
	if(abs(var_15 - var_16) > var_14)
	{
		return undefined;
	}

	if(var_0E < lengthsquared(var_11))
	{
		return undefined;
	}

	var_17 = lib_0F3A::func_36D9(var_0C.var_D699,var_0C.var_130[1],var_11,var_12);
	var_18 = getclosestpointonnavmesh(var_0C.var_D699,self);
	var_19 = lib_0F3A::func_36D9(var_18,var_0C.var_130[1],var_11,var_12);
	var_1A = self method_84AC();
	var_1B = navtrace(var_1A,var_18,self,1);
	var_1C = var_1B["fraction"] >= 0.9 || navisstraightlinereachable(var_1A,var_18,self);
	if(!var_1C)
	{
		var_1D = self method_841E();
		var_1C = var_1D < distance(var_1A,var_18) + 8;
	}

	if(var_1C)
	{
		var_1E = spawnstruct();
		var_1E.var_11060 = var_0F;
		var_1E.var_3F = 0;
		var_1E.var_2C5 = var_17;
		var_1E.var_3E = var_12;
		var_1E.angles = var_0C.angles;
		var_1E.var_130 = var_0C.var_130;
		var_1E.var_11069 = var_11;
		var_1E.var_22ED = var_04;
		return var_1E;
	}

	return undefined;
}

//Function Number: 56
func_D563(param_00,param_01,param_02,param_03)
{
	self endon("death");
	self endon("terminate_ai_threads");
	var_04 = self method_8148();
	var_05 = self method_8146();
	self method_828A("noclip");
	self method_8289("face angle abs",var_04.angles);
	self method_8281("anim deltas");
	self method_8282(1,1);
	var_06 = var_05 - var_04.origin;
	var_07 = self method_80FD(param_01,0);
	var_08 = getanimlength(var_07);
	var_09 = getmovedelta(var_07);
	var_0A = length(var_09);
	var_0B = length(var_05 - self.origin);
	var_0C = var_08 * var_0B / var_0A;
	self method_827B(self.origin,var_05,var_0C);
	self method_82AF(param_01,0);
	wait(var_0C);
	self method_828A("gravity");
	self notify("traverse_end");
	func_11701(param_00,param_01);
}

//Function Number: 57
func_3F08(param_00,param_01,param_02)
{
	if(!isdefined(param_02))
	{
		return lib_0F3C::func_3EF4(param_00,param_01,param_02);
	}

	switch(self.var_1198.var_BD23)
	{
		case "walk":
		case "slow_walk":
			param_02 = param_02 + "_walk";
			break;

		case "sprint":
		case "run":
			param_02 = param_02 + "_run";
			break;

		default:
			param_02 = param_02 + "_walk";
			break;
	}

	return lib_0A1A::func_2358(param_01,param_02);
}

//Function Number: 58
func_D567(param_00,param_01,param_02,param_03)
{
	scripts\mp\agents\_scriptedagents::func_F85E(1,"DoTraverse");
	var_04 = self.do_immediate_ragdoll;
	self.do_immediate_ragdoll = 1;
	func_5AC4(param_00,param_01,param_02,param_03);
	self.do_immediate_ragdoll = var_04;
	self method_8282(1,1);
	scripts\mp\agents\_scriptedagents::func_F85E(0,"Traverse end_script");
	self.var_8C35 = 1;
	self.var_126CB = undefined;
}

//Function Number: 59
func_5AC4(param_00,param_01,param_02,param_03)
{
	self endon("death");
	self endon("terminate_ai_threads");
	var_04 = self method_8148();
	var_05 = self method_8146();
	self.var_6367 = var_05;
	if(!isdefined(var_04))
	{
		return;
	}

	if(!isdefined(var_05))
	{
		return;
	}

	self.var_6378 = var_05;
	self.var_126CB = vectornormalize(var_05 - var_04.origin);
	var_06 = undefined;
	var_06 = var_04.var_48;
	if(param_01 == "traverse_external")
	{
		var_06 = param_01;
	}

	if(func_BE90(var_06))
	{
		var_06 = "crawling_" + var_06;
	}

	if(!isdefined(var_06))
	{
		return;
	}

	self.var_9CEC = 1;
	var_07 = lib_0A1D::func_2337(param_00,var_06);
	var_08 = var_05 - var_04.origin;
	var_09 = (var_08[0],var_08[1],0);
	var_0A = vectortoangles(var_09);
	var_0B = issubstr(var_06,"jump_across");
	var_0C = var_06 == "traverse_boost" && self.var_1096F == "humanoid" || self.var_1096F == "zombie";
	self method_8289("face angle abs",var_0A);
	self method_8281("anim deltas");
	var_0D = self method_80FD(var_06,var_07);
	var_0E = "flex_height_up_start";
	var_0F = getnotetracktimes(var_0D,var_0E);
	if(var_0F.size == 0)
	{
		var_0E = "flex_height_start";
		var_0F = getnotetracktimes(var_0D,var_0E);
		if(var_0F.size == 0)
		{
			var_0E = "traverse_jump_start";
			var_0F = getnotetracktimes(var_0D,var_0E);
		}
	}

	var_10 = "flex_height_up_end";
	var_11 = getnotetracktimes(var_0D,var_10);
	if(var_11.size == 0)
	{
		var_10 = "flex_height_end";
		var_11 = getnotetracktimes(var_0D,var_10);
		if(var_11.size == 0)
		{
			var_10 = "traverse_jump_end";
			var_11 = getnotetracktimes(var_0D,var_10);
		}
	}

	var_12 = "highest_point";
	var_13 = getnotetracktimes(var_0D,var_12);
	var_14 = "flex_height_down_start";
	var_15 = getnotetracktimes(var_0D,var_14);
	var_16 = "flex_height_down_end";
	var_17 = getnotetracktimes(var_0D,var_16);
	var_18 = "crawler_early_stop";
	var_19 = getnotetracktimes(var_0D,var_18);
	var_1A = getnotetracktimes(var_0D,"code_move");
	if(var_1A.size > 0)
	{
		var_1B = getmovedelta(var_0D,0,var_1A[0]);
	}
	else
	{
		var_1B = getmovedelta(var_0E,0,1);
	}

	var_1C = scripts\mp\agents\_scriptedagents::func_7DC9(var_08,var_1B);
	var_1D = animhasnotetrack(var_0D,"ignoreanimscaling");
	if(var_1D)
	{
		var_1C.var_13E2B = 1;
	}

	self method_828A("noclip");
	var_1E = self method_8145();
	if(isdefined(var_1E) && isdefined(var_1E.target))
	{
		self.var_6366 = var_1E;
		if(var_13.size > 0)
		{
			scripts\mp\agents\_scriptedagents::func_5AC1(var_06 + "_norestart",var_07,var_0D,"traverse",var_0E,var_12,0,::func_13FAE);
			var_1F = scripts\common\utility::getstruct(self.var_6366.target,"targetname");
			if(isdefined(var_1F.script_noteworthy) && var_1F.script_noteworthy == "continue_flex_height")
			{
				scripts\mp\agents\_scriptedagents::func_5AC1(var_06 + "_norestart",var_07,var_0D,"traverse",var_12,var_10,1,::func_13FAE);
			}

			self method_8282(1,1);
			scripts\mp\agents\_scriptedagents::func_CED5(var_06 + "_norestart",var_07,"traverse","end",::func_13FAE);
		}
		else if(var_15.size == 0)
		{
			scripts\mp\agents\_scriptedagents::func_5AC1(var_06 + "_norestart",var_07,var_0D,"traverse",var_0E,var_10,0,::func_13FAE);
			self method_8282(1,1);
			scripts\mp\agents\_scriptedagents::func_CED5(var_06 + "_norestart",var_07,"traverse","end",::func_13FAE);
		}
		else
		{
			var_1F = scripts\common\utility::getstruct(self.var_6366.target,"targetname");
			var_20 = var_15[0];
			scripts\mp\agents\_scriptedagents::func_5AC2(var_06 + "_norestart",var_07,"traverse",var_0D,var_0E,var_10,var_1F.origin,var_20,::func_13FAE);
			if(var_15[0] - var_11[0] > 0.02)
			{
				self method_8282(1,1);
				scripts\mp\agents\_scriptedagents::func_CED5(var_06 + "_norestart",var_07,"traverse",var_14,::func_13FAE);
			}

			var_1F = self.var_6366;
			var_20 = var_17[0];
			scripts\mp\agents\_scriptedagents::func_5AC2(var_06 + "_norestart",var_07,"traverse",var_0D,var_14,var_16,var_1F.origin,var_20,::func_13FAE);
			self method_8282(1,1);
			if(var_19.size == 0 || !scripts\common\utility::istrue(self.var_565C))
			{
				scripts\mp\agents\_scriptedagents::func_CED5(var_06 + "_norestart",var_07,"traverse","end",::func_13FAE);
			}
		}

		self.var_6366 = undefined;
	}
	else if(var_15.size > 0 && var_17.size > 0 && self.agent_type != "zombie_brute")
	{
		self method_8282(1,1);
		scripts\mp\agents\_scriptedagents::func_CED5(var_06 + "_norestart",var_07,"traverse","end",::func_13FAE);
	}
	else if(var_0B && abs(var_08[2]) < 48)
	{
		var_21 = getanimlength(var_0D);
		var_22 = var_0F[0] * var_21;
		var_23 = var_11[0] * var_21;
		self method_8282(1,1);
		scripts\mp\agents\_scriptedagents::func_CED3(var_06,var_07,self.var_126E8,"traverse",var_0E);
		self method_8282(1,0);
		childthread func_126D8(var_04.origin[2],var_05[2],var_23 - var_22 / self.var_126E8);
		scripts\mp\agents\_scriptedagents::func_CED3(var_06 + "_norestart",var_07,self.var_126E8,"traverse",var_10);
		self method_8282(1,1);
		scripts\mp\agents\_scriptedagents::func_CED3(var_06 + "_norestart",var_07,self.var_126E8,"traverse");
	}
	else if(var_08[2] > 16)
	{
		if(var_1B[2] > 0)
		{
			if(var_0C)
			{
				self method_8282(var_1C.var_13E2B,var_1C.var_3A6);
				var_24 = clamp(2 / var_1C.var_3A6,0.5,1);
				if(var_11.size > 0)
				{
					scripts\mp\agents\_scriptedagents::func_CED3(var_06,var_07,var_24 * self.var_126E8,"traverse",var_10);
					scripts\mp\agents\_scriptedagents::func_F85E(0,"DoTraverse");
					var_25 = var_06 + "_norestart";
					scripts\mp\agents\_scriptedagents::func_F2B1(var_25,var_07,self.var_126E8);
					scripts\mp\agents\_scriptedagents::func_1384D("traverse","code_move");
				}
				else
				{
					scripts\mp\agents\_scriptedagents::func_CED3(var_06,var_07,self.var_126E8,"traverse");
				}

				self method_8282(1,1);
			}
			else if(var_0F.size > 0)
			{
				var_1C.var_13E2B = 1;
				var_1C.var_3A6 = 1;
				if(!var_1D && length2dsquared(var_09) < 0.64 * length2dsquared(var_1B))
				{
					var_1C.var_13E2B = 0.4;
				}

				self method_8282(var_1C.var_13E2B,var_1C.var_3A6);
				scripts\mp\agents\_scriptedagents::func_CED3(var_06,var_07,self.var_126E8,"traverse",var_0E);
				var_26 = getmovedelta(var_0D,0,var_0F[0]);
				var_27 = getmovedelta(var_0D,0,var_11[0]);
				var_1C.var_13E2B = 1;
				var_1C.var_3A6 = 1;
				var_28 = var_05 - self.origin;
				var_29 = var_1B - var_26;
				if(!var_1D && length2dsquared(var_28) < 0.5625 * length2dsquared(var_29))
				{
					var_1C.var_13E2B = 0.75;
				}

				var_2A = var_1B - var_27;
				var_2B = (var_2A[0] * var_1C.var_13E2B,var_2A[1] * var_1C.var_13E2B,var_2A[2] * var_1C.var_3A6);
				var_2C = rotatevector(var_2B,var_0A);
				var_2D = var_05 - var_2C;
				var_2E = var_27 - var_26;
				var_2F = rotatevector(var_2E,var_0A);
				var_30 = var_2D - self.origin;
				var_31 = var_1C;
				var_1C = scripts\mp\agents\_scriptedagents::func_7DC9(var_30,var_2F,1);
				if(var_1D)
				{
					var_1C.var_13E2B = 1;
				}

				if(var_30[2] <= 0)
				{
					var_1C.var_3A6 = 0;
				}

				self method_8282(var_1C.var_13E2B,var_1C.var_3A6);
				scripts\mp\agents\_scriptedagents::func_1384D("traverse",var_10);
				scripts\mp\agents\_scriptedagents::func_F85E(0,"DoTraverse");
				var_1C = var_31;
				self method_8282(var_1C.var_13E2B,var_1C.var_3A6);
				scripts\mp\agents\_scriptedagents::func_1384D("traverse","code_move");
			}
			else
			{
				self method_8282(var_1C.var_13E2B,var_1C.var_3A6);
				scripts\mp\agents\_scriptedagents::func_CED3(var_06,var_07,self.var_126E8,"traverse");
			}
		}
		else
		{
			scripts\mp\agents\_scriptedagents::func_5AC1(var_06 + "_norestart",var_07,var_0D,"traverse","flex_height_start","flex_height_end",1,::func_13FAE);
		}
	}
	else if(abs(var_08[2]) < 16 || var_1B[2] == 0)
	{
		self method_8282(var_1C.var_13E2B,var_1C.var_3A6);
		var_24 = clamp(2 / var_1C.var_3A6,0.5,1);
		if(var_11.size > 0)
		{
			scripts\mp\agents\_scriptedagents::func_CED3(var_06,var_07,var_24 * self.var_126E8,"traverse",var_10);
			scripts\mp\agents\_scriptedagents::func_F85E(0,"DoTraverse");
			var_25 = var_06 + "_norestart";
			scripts\mp\agents\_scriptedagents::func_F2B1(var_25,var_07,self.var_126E8);
			scripts\mp\agents\_scriptedagents::func_1384D("traverse","code_move");
		}
		else
		{
			scripts\mp\agents\_scriptedagents::func_CED3(var_06,var_07,self.var_126E8,"traverse");
		}

		self method_8282(1,1);
	}
	else if(var_1B[2] < 0)
	{
		self method_8282(var_1C.var_13E2B,var_1C.var_3A6);
		var_24 = clamp(2 / var_1C.var_3A6,0.5,1);
		var_33 = var_06 + "_norestart";
		if(var_0F.size > 0)
		{
			scripts\mp\agents\_scriptedagents::func_CED3(var_06,var_07,self.var_126E8,"traverse",var_0E);
			var_06 = var_33;
		}

		if(var_11.size > 0)
		{
			scripts\mp\agents\_scriptedagents::func_CED3(var_06,var_07,var_24 * 1,"traverse",var_10);
			scripts\mp\agents\_scriptedagents::func_F2B1(var_33,var_07,self.var_126E8);
			if(animhasnotetrack(var_0D,"removestatelock"))
			{
				scripts\mp\agents\_scriptedagents::func_1384D("traverse","removestatelock");
			}

			scripts\mp\agents\_scriptedagents::func_F85E(0,"DoTraverse");
			scripts\mp\agents\_scriptedagents::func_1384D("traverse","code_move");
		}
		else
		{
			scripts\mp\agents\_scriptedagents::func_CED3(var_06,var_07,1,"traverse");
		}

		self method_8282(1,1);
	}
	else
	{
	}

	func_ABB8();
	self method_828A("gravity");
	self.var_9CEC = undefined;
	self notify("traverse_end");
	func_11701(param_00,param_01);
}

//Function Number: 60
func_126D8(param_00,param_01,param_02)
{
	self endon("death");
	self endon("terminate_ai_threads");
	var_03 = gettime();
	for(;;)
	{
		var_04 = gettime() - var_03 / 1000;
		var_05 = var_04 / param_02;
		if(var_05 > 1)
		{
			break;
		}

		var_06 = lib_0F74::func_AB6F(var_05,param_00,param_01);
		self setorigin((self.origin[0],self.origin[1],var_06),0);
		wait(0.05);
	}
}

//Function Number: 61
func_BE90(param_00)
{
	if(self.var_565C)
	{
		return 1;
	}

	return 0;
}

//Function Number: 62
func_ABB8()
{
	var_00 = 0.1;
	var_01 = self.var_6378;
	var_02 = var_01[2];
	var_03 = self.origin[2];
	if(var_03 < var_02)
	{
		self setorigin((self.origin[0],self.origin[1],var_02 + var_00),0);
	}
}

//Function Number: 63
func_11706(param_00,param_01,param_02)
{
	self.var_9CEC = undefined;
}

//Function Number: 64
func_11701(param_00,param_01)
{
	var_02 = level.var_2303[param_00].var_10E2F[param_01];
	var_03 = undefined;
	if(isdefined(var_02.var_116FB))
	{
		if(isarray(var_02.var_116FB[0]))
		{
			var_03 = var_02.var_116FB[0];
		}
		else
		{
			var_03 = var_02.var_116FB;
		}
	}

	lib_0A1A::func_2388(param_00,param_01,var_02,var_02.var_116FB);
	lib_0A1A::func_238A(param_00,var_03,0.2,undefined,undefined,undefined);
	self notify("killanimscript");
}

//Function Number: 65
func_D4E3(param_00,param_01,param_02,param_03)
{
	self endon(param_01 + "_finished");
	lib_0A1A::func_237B(self.var_BCE4);
	self.var_2303.var_4B12 = param_03;
	lib_0F3C::func_D4DD(param_00,param_01,param_02,param_03);
	lib_0A1A::func_237B(1);
}

//Function Number: 66
func_CEAE(param_00,param_01,param_02,param_03)
{
	self endon(param_01 + "_finished");
	lib_0F3A::func_CEAA(param_00,param_01,param_02,param_03);
}

//Function Number: 67
func_CEB7(param_00,param_01,param_02,param_03)
{
	self endon(param_01 + "_finished");
	lib_0A1A::func_237B(self.var_BCE4);
	lib_0F3B::func_CEB5(param_00,param_01,param_02,param_03);
	lib_0A1A::func_237B(1);
}

//Function Number: 68
func_D515(param_00,param_01,param_02,param_03)
{
	self endon(param_01 + "_finished");
	lib_0A1A::func_237B(self.var_BCE4);
	lib_0F3B::func_D514(param_00,param_01,param_02,param_03);
	lib_0A1A::func_237B(self.var_BCE4);
}

//Function Number: 69
func_D538(param_00,param_01,param_02,param_03)
{
	self endon(param_01 + "_finished");
	lib_0A1A::func_237B(self.var_BCE4);
	if(lib_0F74::func_8252() < 2)
	{
		var_04 = level.var_BCE6["run"][1];
		var_04 = var_04 + self.var_BCE4 - level.var_BCE6["sprint"][0];
		lib_0A1A::func_237B(var_04);
	}

	lib_0F3B::func_D514(param_00,param_01,param_02,param_03);
	lib_0A1A::func_237B(self.var_BCE4);
}

//Function Number: 70
func_13FAE(param_00,param_01,param_02,param_03)
{
	switch(param_00)
	{
		case "apply_physics":
			self method_828A("gravity");
			break;

		default:
			break;
	}
}

//Function Number: 71
func_7389(param_00,param_01,param_02,param_03)
{
	param_01 = self.var_7387;
	level thread [[ level.var_7456 ]](self);
	var_04 = lib_0A1D::func_2337(param_00,param_01);
	if(scripts\common\utility::istrue(self.activated_slomo_sphere))
	{
		lib_0A1D::func_2365(param_00,param_01,0.1,var_04,0.2);
		return;
	}

	if(scripts\common\utility::istrue(self.activated_venomx_sphere))
	{
		lib_0A1D::func_2365(param_00,param_01,0.1,var_04,0.2);
		return;
	}

	lib_0A1D::func_2365(param_00,param_01,0.1,var_04,0.001);
}

//Function Number: 72
func_3E12(param_00,param_01,param_02,param_03)
{
	if(scripts\common\utility::istrue(self.var_9E0C))
	{
		if(isdefined(param_03))
		{
			self.var_7387 = param_03;
		}
		else
		{
			self.var_7387 = lib_0A1A::func_233A(param_00);
		}

		return 1;
	}

	return 0;
}

//Function Number: 73
func_3E18(param_00,param_01,param_02,param_03)
{
	if(!scripts\common\utility::istrue(self.var_9E0C))
	{
		self.var_7387 = undefined;
		return 1;
	}

	return 0;
}

//Function Number: 74
func_631D(param_00,param_01,param_02,param_03)
{
	self.var_7387 = undefined;
	level thread [[ level.var_11768 ]](self);
}

//Function Number: 75
func_A013()
{
	if(self method_84B9(200))
	{
		return 1;
	}

	return 0;
}

//Function Number: 76
func_38B2(param_00,param_01,param_02)
{
	var_03 = 0.5;
	var_04 = getnotetracktimes(param_00,"turn_extent");
	if(var_04.size == 1)
	{
		var_03 = var_04[0];
	}
	else
	{
		var_05 = getnotetracktimes(param_00,"code_move");
		if(var_05.size == 1)
		{
			var_03 = var_05[0] * 0.5;
		}
	}

	var_06 = 1;
	var_07 = getnotetracktimes(param_00,"finish");
	if(var_07.size == 0)
	{
		var_07 = getnotetracktimes(param_00,"end");
	}

	if(var_07.size == 1)
	{
		var_06 = var_07[0];
	}

	var_08 = getmovedelta(param_00,0,var_03);
	var_09 = getmovedelta(param_00,0,var_06);
	var_0A = self.origin;
	var_0B = rotatevector(var_08,param_01) + var_0A;
	var_0C = rotatevector(var_09,param_01) + var_0A;
	if(!scripts\mp\agents\_scriptedagents::func_38D0(var_0B,var_0C,0))
	{
		return 0;
	}

	var_0D = self.var_257;
	if(!param_02)
	{
		var_0D = self.var_257 / 2;
	}

	if(!scripts\mp\agents\_scriptedagents::func_38D0(var_0A,var_0B,0,var_0D))
	{
		return 0;
	}

	return 1;
}

//Function Number: 77
func_6BC6(param_00,param_01,param_02,param_03)
{
	if(scripts\common\utility::istrue(self.var_9BB0))
	{
		return 1;
	}

	return 0;
}

//Function Number: 78
func_9DC8(param_00,param_01,param_02,param_03)
{
	if(func_6BC6(param_00,param_01,param_02,param_03))
	{
		return 0;
	}

	self.var_2CA7 = undefined;
	return 1;
}

//Function Number: 79
func_CEF3(param_00,param_01,param_02,param_03)
{
	self method_8289("face angle abs",self.var_5273);
	lib_0A1D::func_235F(param_00,param_01,param_02,1,0);
}

//Function Number: 80
func_3EBE(param_00,param_01,param_02)
{
	if(isdefined(self.var_2CA7))
	{
		return self.var_2CA7;
	}

	if(self.var_565C)
	{
		func_F2E5();
		self.var_2CA7 = lib_0A1A::func_2358(param_01,"boombox_dance_crawl_" + level.var_2C9A);
		return self.var_2CA7;
	}

	if(scripts\common\utility::istrue(self.var_9B6E))
	{
		self.var_2CA7 = lib_0A1A::func_2358(param_01,"disco_dance_center_" + randomintrange(0,4));
		return self.var_2CA7;
	}

	if(scripts\common\utility::istrue(self.fridge_trap_marked))
	{
		self.var_2CA7 = lib_0A1A::func_2358(param_01,"fridge_lured_anim_" + randomintrange(0,4));
		return self.var_2CA7;
	}

	func_F2E6();
	self.var_2CA7 = lib_0A1A::func_2358(param_01,"boombox_dance_" + level.var_2C9B);
	return self.var_2CA7;
}

//Function Number: 81
func_F2E6()
{
	if(!isdefined(level.var_2C9B))
	{
		level.var_2C9B = 0;
	}

	level.var_2C9B++;
	if(level.var_2C9B > 5)
	{
		level.var_2C9B = 0;
	}
}

//Function Number: 82
func_F2E5()
{
	if(!isdefined(level.var_2C9A))
	{
		level.var_2C9A = 0;
	}

	level.var_2C9A++;
	if(level.var_2C9A > 1)
	{
		level.var_2C9A = 0;
	}
}

//Function Number: 83
func_BE8D(param_00,param_01,param_02,param_03)
{
	return 0;
}

//Function Number: 84
func_3EFE(param_00,param_01,param_02)
{
	if(scripts\common\utility::istrue(self.var_12F77))
	{
		return lib_0A1A::func_2358(param_01,"upgraded");
	}

	return lib_0A1A::func_2358(param_01,"normal");
}

//Function Number: 85
func_98DC(param_00,param_01,param_02,param_03)
{
	return 0;
}

//Function Number: 86
func_BE94(param_00,param_01,param_02,param_03)
{
	if(isdefined(self.var_6658))
	{
		return 0;
	}

	if(!scripts\common\utility::istrue(self.var_2BE7) || scripts\common\utility::istrue(self.entered_playspace))
	{
		return 0;
	}

	if(!isdefined(level.var_7088))
	{
		return 0;
	}

	if(!isdefined(self.var_429D))
	{
		self.var_429D = [[ level.var_7088 ]](self.origin);
		if(!isdefined(self.var_429D))
		{
			iprintlnbold("NO ENTRANCE FOUND FOR ZOMBIE AT POS: " + self.origin);
			return 0;
		}
	}
	else if(!lib_0A1B::func_2955())
	{
		self.var_429D = lib_0D4D::func_7B14(self.origin,self.var_429D);
		if(!isdefined(self.var_429D))
		{
			self.var_54CB = 1;
			self dodamage(self.health + 950,self.origin,self,self,"MOD_SUICIDE");
			return 0;
		}
	}

	self method_8287(4);
	self method_8286(self.var_429D.origin);
	if(!lib_0A1B::func_2955())
	{
		return 0;
	}

	self.var_6658 = self.var_429D;
	self.var_429D = undefined;
	return 1;
}

//Function Number: 87
func_3ED7(param_00,param_01,param_02)
{
	if(isdefined(self.var_662F))
	{
		return self.var_662F;
	}

	var_03 = self.var_24CA;
	var_04 = undefined;
	if(!isdefined(var_03.script_label))
	{
		var_04 = "mid";
	}
	else
	{
		var_04 = var_03.script_label;
	}

	if(scripts\common\utility::istrue(var_03.var_2A9F))
	{
		var_04 = var_04 + "_extended";
	}

	self.var_662F = lib_0A1A::func_2358(param_01,var_04);
	return self.var_662F;
}

//Function Number: 88
func_3EBA(param_00,param_01,param_02)
{
	var_03 = self.var_24CA;
	var_04 = "standing_";
	if(func_BE92())
	{
		var_04 = "crawling_";
	}

	if(!isdefined(var_03.script_label))
	{
		var_04 = var_04 + "mid";
	}
	else
	{
		var_04 = var_04 + var_03.script_label;
	}

	return lib_0A1A::func_2358(param_01,var_04);
}

//Function Number: 89
func_116E8(param_00,param_01,param_02)
{
	if(isdefined(self.var_BF2F))
	{
		var_03 = lib_0D4D::func_7872(self.var_6658,self.var_BF2F - 1);
		if(var_03 == "destroying")
		{
			lib_0D4D::func_F2E3(self.var_6658,self.var_BF2F - 1,"boarded");
		}

		self.var_BF2F = undefined;
	}
}

//Function Number: 90
func_3ECF(param_00,param_01,param_02)
{
	var_03 = self.var_24CA;
	if(scripts\common\utility::istrue(self.var_9E0C))
	{
		if(isdefined(self.var_BF2F))
		{
			lib_0D4D::func_F2E3(self.var_6658,self.var_BF2F - 1,"boarded");
			self.var_BF2F = undefined;
		}

		return self.var_A93A;
	}

	if(self.var_565C)
	{
		if(!isdefined(var_03.script_label))
		{
			self.var_A93A = lib_0A1A::func_2358(param_01,"crawling");
			return self.var_A93A;
		}

		var_04 = func_F496();
		var_05 = "crawling_" + var_03.script_label + "_" + var_04;
		self.var_A93A = lib_0A1A::func_2358(param_01,var_05);
		return self.var_A93A;
	}

	if(!isdefined(var_05.script_label))
	{
		self.var_A93A = lib_0A1A::func_2358(var_03,"standing");
		return self.var_A93A;
	}

	while(isdefined(self.var_BF2F))
	{
		wait(0.05);
	}

	var_04 = func_F496();
	var_05 = "standing_" + var_04.script_label + "_" + var_05;
	self.var_A93A = lib_0A1A::func_2358(param_01,var_05);
	return self.var_A93A;
}

//Function Number: 91
func_F496()
{
	var_00 = lib_0D4D::func_7B12(self.var_6658);
	self.var_BF2F = var_00;
	lib_0D4D::func_F2E3(self.var_6658,self.var_BF2F - 1,"destroying");
	return var_00;
}

//Function Number: 92
func_3F13(param_00,param_01,param_02)
{
	if(self.var_565C)
	{
		return lib_0A1A::func_2358(param_01,"crawling");
	}

	return lib_0A1A::func_2358(param_01,"standing");
}

//Function Number: 93
func_532D(param_00,param_01,param_02,param_03)
{
	if(param_00 == "board_break" || param_00 == "hit")
	{
		if(!isdefined(self.var_BF2F))
		{
			return;
		}

		var_04 = self.var_BF2F;
		self.var_BF2F = undefined;
		lib_0D4D::func_F2E3(self.var_6658,var_04 - 1,"destroyed");
		lib_0D4D::func_DFCB(self.var_6658,var_04);
	}
}

//Function Number: 94
func_9C78(param_00,param_01)
{
	var_02 = 2304;
	return distancesquared(param_00.origin,param_01.origin) < var_02;
}

//Function Number: 95
func_252C(param_00,param_01,param_02,param_03)
{
	if(param_00 == "hit")
	{
		var_04 = scripts\common\utility::getclosest(self.origin,level.current_interaction_structs);
		if(func_9C78(self.var_4299,var_04))
		{
			lib_0C73::func_5904(self.var_4299,45,"MOD_IMPACT");
		}
	}
}

//Function Number: 96
func_CEE3(param_00,param_01,param_02,param_03)
{
	self endon(param_01 + "_finished");
	self method_8289("face angle abs",self.var_24CA.angles);
	lib_0A1D::func_2364(param_00,param_01,param_02,param_03);
}

//Function Number: 97
func_CF19(param_00,param_01,param_02,param_03)
{
	self endon(param_01 + "_finished");
	self method_8289("face angle abs",self.var_24CA.angles);
	lib_0A1D::func_2364(param_00,param_01,param_02,param_03);
}

//Function Number: 98
func_662E(param_00,param_01,param_02,param_03)
{
	self endon(param_01 + "_finished");
	self method_8281("anim deltas");
	self method_8289("face angle abs",self.var_24CA.angles);
	self method_828A("noclip");
	self method_841F();
	self method_828B(1);
	self.do_immediate_ragdoll = 1;
	self.var_9CEC = 1;
	if(isdefined(self.var_24CA.var_EE79) && self.var_24CA.var_EE79 == "script_adjust")
	{
		var_04 = anglestoforward(self.var_24CA.angles);
		var_04 = vectornormalize(var_04);
		var_04 = var_04 * -3.5;
		var_04 = (var_04[0],var_04[1],-1);
		self setorigin(self.origin + var_04,0);
	}

	lib_0A1D::func_2365(param_00,param_01,param_02,lib_0A1D::func_2337(param_00,param_01),self.var_126E8);
	self.do_immediate_ragdoll = 0;
	self.full_gib = 0;
	self.nocorpse = undefined;
	self method_828B(0);
	self method_828A("gravity");
	self.entered_playspace = 1;
	self.var_2BE7 = undefined;
	self.var_6659 = undefined;
	self.var_6658 = undefined;
	self.var_BF2F = undefined;
	self.var_9CEC = undefined;
	self method_8287(4);
	self method_8286(self.origin);
	lib_0D4D::func_DF34(self.var_24CA);
	self.var_24CA = undefined;
}

//Function Number: 99
func_BA3E()
{
	self endon("death");
	self.var_C189 = 1;
	self.entered_playspace = 1;
	self.full_gib = 1;
	self.nocorpse = 1;
	self.deathmethod = "window";
	self waittill("goal_reached");
	self.full_gib = 0;
	self.nocorpse = undefined;
	self.deathmethod = undefined;
	self.entered_playspace = 1;
	self.var_2BE7 = undefined;
	self.var_6659 = undefined;
	self.var_6658 = undefined;
	self.var_BF2F = undefined;
	lib_0D4D::func_DF34(self.var_24CA);
	self.var_24CA = undefined;
}

//Function Number: 100
func_1305A(param_00,param_01,param_02,param_03)
{
	if(!isdefined(self.var_24CA.target))
	{
		return 0;
	}

	var_04 = function_00B4(self.var_24CA.target,"targetname");
	if(!isdefined(var_04) || var_04.size == 0)
	{
		return 0;
	}

	var_05 = var_04[0];
	if(!isdefined(var_05) || !isdefined(var_05.var_48))
	{
		return 0;
	}

	var_04 = function_00B4(var_05.target,"targetname");
	if(!isdefined(var_04) || var_04.size == 0)
	{
		return 0;
	}

	var_06 = var_04[0];
	self method_8286(var_06.origin);
	self.var_6659 = 0;
	thread func_BA3E();
	return 1;
}

//Function Number: 101
func_BA3D()
{
	self endon("death");
	self.var_C189 = 1;
	self.var_2CC = 200;
	self method_84BD();
	self waittill("stop_soon");
	self.var_24CA = lib_0D4D::func_7B4C(self.var_6658);
	if(!lib_0D4D::func_9CD3(self.var_24CA))
	{
		lib_0D4D::func_3FF0(self.var_24CA);
	}
	else
	{
		self method_8286(self.origin);
		while(func_BE93())
		{
			var_00 = lib_0D4D::func_7B4C(self.var_6658);
			if(isdefined(var_00) && !lib_0D4D::func_9CD3(var_00))
			{
				self.var_24CA = var_00;
				lib_0D4D::func_3FF0(self.var_24CA);
				break;
			}

			self.var_331F = 1;
			wait(0.05);
		}

		self.var_331F = undefined;
	}

	var_01 = getclosestpointonnavmesh(self.var_24CA.origin,self);
	var_02 = (self.var_24CA.origin[0],self.var_24CA.origin[1],var_01[2]);
	self method_8286(var_02);
	self waittill("goal_reached");
	var_03 = (self.var_24CA.origin[0],self.var_24CA.origin[1],self.origin[2]);
	self setorigin(var_03,0);
	self.var_C189 = 0;
	lib_0D4D::func_E005(self.var_6658);
	self.var_6659 = 1;
}

//Function Number: 102
func_5AEE(param_00,param_01,param_02,param_03)
{
	self.var_6659 = 0;
	lib_0D4D::func_16D1(self.var_6658);
	self method_8287(4);
	self method_8286(self.var_6658.origin);
	thread func_BA3D();
	return 1;
}

//Function Number: 103
func_DD1E(param_00,param_01,param_02,param_03)
{
	if(scripts\common\utility::istrue(self.var_6659))
	{
		return 1;
	}

	return 0;
}

//Function Number: 104
func_BE93(param_00,param_01,param_02,param_03)
{
	var_04 = lib_0D4D::func_7B12(self.var_6658);
	if(!isdefined(var_04))
	{
		return 0;
	}

	return 1;
}

//Function Number: 105
func_13F9B(param_00,param_01,param_02,param_03)
{
	lib_0A1B::func_2915();
	return 1;
}

//Function Number: 106
func_10007(param_00,param_01,param_02,param_03)
{
	if(!isdefined(self.var_2303.var_4B12))
	{
		return 0;
	}

	switch(self.var_2303.var_4B12)
	{
		case "walk":
		case "slow_walk":
			return 0;
	}

	return 1;
}

//Function Number: 107
func_FFC0(param_00,param_01,param_02,param_03)
{
	if(!isdefined(level.var_7089))
	{
		return 0;
	}

	if(func_BE92())
	{
		return 0;
	}

	var_04 = "mid";
	if(isdefined(self.var_24CA.script_label))
	{
		var_04 = self.var_24CA.script_label;
	}

	self.var_4299 = [[ level.var_7089 ]](self);
	if(!isdefined(self.var_4299))
	{
		return 0;
	}

	if(randomint(100) > 50)
	{
		return 0;
	}

	return 1;
}

//Function Number: 108
func_9FF5(param_00,param_01,param_02,param_03)
{
	if(scripts\common\utility::istrue(level.var_2AAD))
	{
		return 1;
	}

	if(scripts\common\utility::istrue(self.var_331F))
	{
		return 1;
	}

	return 0;
}

//Function Number: 109
func_9DC9(param_00,param_01,param_02,param_03)
{
	return !func_9FF5(param_00,param_01,param_02,param_03);
}

//Function Number: 110
func_3F0B(param_00,param_01,param_02)
{
	var_03 = "standing";
	if(func_BE92())
	{
		var_03 = "crawling";
	}

	return lib_0A1A::func_2358(param_01,var_03);
}

//Function Number: 111
func_1002F(param_00,param_01,param_02,param_03)
{
	return lib_0C73::func_138E4() && !scripts\common\utility::istrue(self.var_11196);
}

//Function Number: 112
func_1003A(param_00,param_01,param_02,param_03)
{
	if(self.hasplayedvignetteanim)
	{
		if(lib_0A1B::func_2955())
		{
			return 1;
		}

		if(isdefined(self.spawner) && isdefined(self.spawner.var_ECF5) && self.spawner.var_ECF5 == "spawn_wall_low")
		{
			return 1;
		}
	}

	return 0;
}