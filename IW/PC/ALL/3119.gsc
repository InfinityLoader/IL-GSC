/*******************************************************************
 * Decompiled By: Bog
 * Decompiled File: 3119.gsc
 * Game: Call of Duty: Infinite Warfare
 * Platform: PC
 * Function Count: 13
 * Decompile Time: 13 ms
 * Timestamp: 10/27/2023 12:26:10 AM
*******************************************************************/

//Function Number: 1
func_3359(param_00,param_01,param_02,param_03)
{
	self.var_2303.var_51E8 = 1;
	self.var_2303.var_7257 = spawnstruct();
	self.var_2303.var_7257.var_7254 = "invalid";
	self.var_2303.var_7257.time = 0;
	self.var_2303.var_4C86 = spawnstruct();
	self.var_2303.var_7360 = 0;
	lib_0A1A::func_237B(1);
	func_3377(param_00);
	func_3375();
	func_3374();
	scripts\anim\combat::func_F296();
	thread lib_0A1E::func_234F();
	self.var_71C8 = ::lib_0C60::func_33AA;
	self.meleechargedistreloadmultiplier = 1;
	self.var_C009 = 1;
	self.var_596E = 1;
	self.var_292 = 48;
}

//Function Number: 2
func_3377(param_00)
{
	if(!isdefined(level.var_C05A))
	{
		anim.var_C05A = [];
	}

	if(isdefined(level.var_C05A[param_00]))
	{
		return;
	}

	var_01 = [];
	var_01["Cover Left"] = 0;
	var_01["Cover Right"] = 0;
	var_01["Cover Stand"] = 0;
	level.var_C05A[param_00] = var_01;
	var_01 = [];
	level.var_7365[param_00] = var_01;
	var_02 = [];
	level.var_C046[param_00] = var_02;
	var_01 = [];
	level.var_C04E[param_00] = var_01;
	var_02 = [];
	var_02["Cover Crouch"] = 45;
	level.var_C04D[param_00] = var_02;
	var_01 = [];
	level.var_7364[param_00] = var_01;
	var_01 = [];
	level.var_7363[param_00] = var_01;
}

//Function Number: 3
func_3375()
{
	if(!isdefined(level.var_85DF))
	{
		anim.var_85DF = [];
	}

	if(isdefined(level.var_85DF["c6"]))
	{
		return;
	}

	level.var_85DF["c6"] = [];
	level.var_85E1["c6"] = [];
	level.var_85DF["c6"]["exposed_throw_grenade"]["exposed_grenade"] = self [[ self.var_7190 ]]("c6","exposed_throw_grenade","exposed_grenade");
	level.var_85E1["c6"]["exposed_throw_grenade"]["exposed_grenade"] = [];
	level.var_85E1["c6"]["exposed_throw_grenade"]["exposed_grenade"][0] = (1.50443,2.92001,63.2739);
	level.var_85DF["c6"]["cover_stand_grenade"]["grenade_exposed"] = self [[ self.var_7190 ]]("c6","cover_stand_grenade","grenade_exposed");
	level.var_85E1["c6"]["cover_stand_grenade"]["grenade_exposed"] = [];
	level.var_85E1["c6"]["cover_stand_grenade"]["grenade_exposed"][0] = (-5.60661,0.535889,63.2995);
	level.var_85DF["c6"]["cover_stand_grenade"]["grenade_safe"] = self [[ self.var_7190 ]]("c6","cover_stand_grenade","grenade_safe");
	level.var_85E1["c6"]["cover_stand_grenade"]["grenade_safe"] = [];
	level.var_85E1["c6"]["cover_stand_grenade"]["grenade_safe"][0] = (-5.60661,0.535889,63.2995);
	level.var_85DF["c6"]["cover_crouch_grenade"]["grenade_exposed"] = self [[ self.var_7190 ]]("c6","cover_crouch_grenade","grenade_exposed");
	level.var_85E1["c6"]["cover_crouch_grenade"]["grenade_exposed"] = [];
	level.var_85E1["c6"]["cover_crouch_grenade"]["grenade_exposed"][0] = (-5.60582,0.535736,63.2997);
	level.var_85DF["c6"]["cover_crouch_grenade"]["grenade_safe"] = self [[ self.var_7190 ]]("c6","cover_crouch_grenade","grenade_safe");
	level.var_85E1["c6"]["cover_crouch_grenade"]["grenade_safe"] = [];
	level.var_85E1["c6"]["cover_crouch_grenade"]["grenade_safe"][0] = (-5.60582,0.535736,63.2997);
	level.var_85DF["c6"]["cover_right_grenade"]["grenade_exposed"] = self [[ self.var_7190 ]]("c6","cover_right_grenade","grenade_exposed");
	level.var_85E1["c6"]["cover_right_grenade"]["grenade_exposed"] = [];
	level.var_85E1["c6"]["cover_right_grenade"]["grenade_exposed"][0] = (-7.74697,-36.7288,63.2998);
	level.var_85DF["c6"]["cover_right_grenade"]["grenade_safe"] = self [[ self.var_7190 ]]("c6","cover_right_grenade","grenade_safe");
	level.var_85E1["c6"]["cover_right_grenade"]["grenade_safe"] = [];
	level.var_85E1["c6"]["cover_right_grenade"]["grenade_safe"][0] = (-7.74697,-36.7288,63.2998);
	level.var_85DF["c6"]["cover_right_crouch_grenade"]["grenade_exposed"] = self [[ self.var_7190 ]]("c6","cover_right_crouch_grenade","grenade_exposed");
	level.var_85E1["c6"]["cover_right_crouch_grenade"]["grenade_exposed"] = [];
	level.var_85E1["c6"]["cover_right_crouch_grenade"]["grenade_exposed"][0] = (-10.7295,-39.4107,63.0914);
	level.var_85DF["c6"]["cover_right_crouch_grenade"]["grenade_safe"] = self [[ self.var_7190 ]]("c6","cover_right_crouch_grenade","grenade_safe");
	level.var_85E1["c6"]["cover_right_crouch_grenade"]["grenade_safe"] = [];
	level.var_85E1["c6"]["cover_right_crouch_grenade"]["grenade_safe"][0] = (-10.7295,-39.4107,63.0914);
	level.var_85DF["c6"]["cover_left_grenade"]["grenade_exposed"] = self [[ self.var_7190 ]]("c6","cover_left_grenade","grenade_exposed");
	level.var_85E1["c6"]["cover_left_grenade"]["grenade_exposed"] = [];
	level.var_85E1["c6"]["cover_left_grenade"]["grenade_exposed"][0] = (-6.18673,44.8321,62.3899);
	level.var_85DF["c6"]["cover_left_grenade"]["grenade_safe"] = self [[ self.var_7190 ]]("c6","cover_left_grenade","grenade_safe");
	level.var_85E1["c6"]["cover_left_grenade"]["grenade_safe"] = [];
	level.var_85E1["c6"]["cover_left_grenade"]["grenade_safe"][0] = (-6.18673,44.8321,62.3899);
	level.var_85DF["c6"]["cover_left_crouch_grenade"]["grenade_exposed"] = self [[ self.var_7190 ]]("c6","cover_left_crouch_grenade","grenade_exposed");
	level.var_85E1["c6"]["cover_left_crouch_grenade"]["grenade_exposed"] = [];
	level.var_85E1["c6"]["cover_left_crouch_grenade"]["grenade_exposed"][0] = (-10.9098,39.5226,63.2997);
	level.var_85DF["c6"]["cover_left_crouch_grenade"]["grenade_safe"] = self [[ self.var_7190 ]]("c6","cover_left_crouch_grenade","grenade_safe");
	level.var_85E1["c6"]["cover_left_crouch_grenade"]["grenade_safe"] = [];
	level.var_85E1["c6"]["cover_left_crouch_grenade"]["grenade_safe"][0] = (-10.9098,39.5226,63.2997);
}

//Function Number: 4
func_3374()
{
	var_00 = [];
	var_01 = [];
	var_00["exposed_crouch"] = var_01;
	var_01 = [];
	var_01["down"] = 15;
	var_00["cover_crouch_lean"] = var_01;
	var_01 = [];
	var_02["cover_crouch_aim"] = var_01;
	var_01 = [];
	var_00["cover_left_crouch_lean"] = var_01;
	var_01 = [];
	var_01["right"] = -15;
	var_00["cover_left_lean"] = var_01;
	var_01 = [];
	var_01["right"] = -15;
	var_00["cover_left_crouch_lean"] = var_01;
	var_01 = [];
	var_01["left"] = 15;
	var_00["cover_right_lean"] = var_01;
	var_01 = [];
	var_01["left"] = 15;
	var_00["cover_right_crouch_lean"] = var_01;
	if(!isdefined(level.var_43FE))
	{
		level.var_43FE = [];
		level.var_7361 = [];
		level.var_1A43 = [];
	}

	level.var_43FE["c6"] = var_00;
	level.var_7361["c6"] = var_02;
	var_03 = [];
	var_03["cover_stand_exposed"] = "exposed_crouch";
	var_03["cover_crouch_hide_to_aim"] = "cover_crouch_aim";
	var_03["cover_crouch_hide_to_right"] = "cover_crouch_aim";
	var_03["cover_crouch_hide_to_left"] = "cover_crouch_aim";
	var_03["cover_crouch_hide_to_lean"] = "cover_crouch_lean";
	var_03["cover_crouch_aim"] = "cover_crouch_aim";
	var_03["cover_crouch_lean"] = "cover_crouch_lean";
	var_03["cover_crouch_exposed_left"] = "cover_crouch_aim";
	var_03["cover_crouch_exposed_right"] = "cover_crouch_aim";
	var_03["cover_crouch_to_exposed_crouch"] = "exposed_crouch";
	var_03["cover_right_lean"] = "cover_right_lean";
	var_03["cover_right_hide_to_lean"] = "cover_right_lean";
	var_03["cover_right_crouch_hide_to_lean"] = "cover_right_crouch_lean";
	var_03["cover_right_crouch_lean"] = "cover_right_crouch_lean";
	var_03["cover_left_hide_to_lean"] = "cover_left_lean";
	var_03["cover_left_lean"] = "cover_left_lean";
	var_03["cover_left_crouch_hide_to_lean"] = "cover_left_crouch_lean";
	var_03["cover_left_crouch_lean"] = "cover_left_crouch_lean";
	var_03["cover_left_crouch_to_exposed_crouch"] = "exposed_crouch";
	level.var_1A43["c6"] = var_03;
}

//Function Number: 5
func_335E(param_00,param_01,param_02,param_03)
{
	self.var_2303.var_4879 = 1;
	lib_0A1E::func_235F(param_00,param_01,param_02,1);
}

//Function Number: 6
func_33AD(param_00,param_01)
{
	var_02 = undefined;
	switch(param_00)
	{
		case "shock_01":
			var_02 = "c6_emp_shock_reaction_01";
			break;

		case "shock_02":
			var_02 = "c6_emp_shock_reaction_02";
			break;

		case "shock_03":
			var_02 = "c6_emp_shock_reaction_03";
			break;
	}

	if(isdefined(var_02) && soundexists(var_02))
	{
		self playsound(var_02);
	}
}

//Function Number: 7
func_335C(param_00,param_01,param_02)
{
	if(lib_0A1B::func_293E())
	{
		return lib_0A1A::func_2358(param_01,"haywire");
	}
	else
	{
		var_03 = lib_0A1A::func_233C();
		if(lib_0A1A::func_234A(var_03,"idle"))
		{
			var_04 = lib_0A1A::func_233D(var_03,"idle");
			if(isarray(var_04))
			{
				return var_04[randomint(var_04.size)];
			}

			return var_04;
		}
	}

	return lib_0F3D::func_3EAB(param_01,param_02,var_03);
}

//Function Number: 8
func_335D(param_00,param_01,param_02)
{
	var_03 = lib_0A1A::func_233C();
	if(lib_0A1B::func_293E())
	{
		return lib_0A1A::func_2358(param_01,lib_0A1B::func_2922());
	}
	else if(lib_0A1A::func_234A(var_03,param_02))
	{
		var_04 = lib_0A1A::func_233D(var_03,param_02);
		if(isarray(var_04))
		{
			return var_04[randomint(var_04.size)];
		}

		return var_04;
	}

	if(!lib_0A1A::func_2346(param_02,var_04))
	{
		return lib_0A1A::func_2358(param_02,"default");
	}

	return lib_0A1A::func_2358(param_02,var_04);
}

//Function Number: 9
func_CEB9(param_00,param_01,param_02,param_03)
{
	self endon(param_01 + "_finished");
	var_04 = self.angles[1];
	if(isdefined(self.var_15F) && distancesquared(self.origin,self.var_15F.origin) > 144)
	{
		var_04 = vectortoyaw(self.var_15F.origin - self.origin);
	}

	self method_8221("face angle",var_04);
	var_05 = self [[ self.var_7191 ]](param_00,param_01);
	self method_806F(lib_0A1E::func_2339(),param_02);
	self method_82EA(param_01,var_05,1,param_02,1);
	thread lib_0A1E::func_231F(param_00,param_01);
	if(animhasnotetrack(var_05,"grenade_left"))
	{
		self waittillmatch("grenade_left",param_01);
	}
	else if(animhasnotetrack(var_05,"grenade_right"))
	{
		self waittillmatch("grenade_right",param_01);
	}
	else
	{
		wait(1);
	}

	if(isdefined(self.var_15F))
	{
		self.var_15F delete();
		var_06 = randomfloatrange(1,1.5);
		var_07 = function_0136("frag_c6hug",self gettagorigin("tag_accessory_left"),(0,0,0),var_06);
		self.var_85C0 = var_07;
		var_07.angles = self gettagangles("tag_accessory_left");
		var_07 linkto(self,"tag_accessory_left");
	}

	scripts\anim\battlechatter_ai::func_67CF("frag");
}

//Function Number: 10
func_CEB8(param_00,param_01,param_02,param_03)
{
	var_04 = self [[ self.var_7191 ]](param_00,param_01);
	self method_806F(lib_0A1E::func_2339(),param_02);
	self method_82EA(param_01,var_04,1,param_02,1);
}

//Function Number: 11
func_85C4(param_00,param_01,param_02,param_03)
{
	return !isdefined(self.var_85C0);
}

//Function Number: 12
func_CEBA(param_00,param_01,param_02,param_03)
{
	self endon(param_01 + "_finished");
	var_04 = self [[ self.var_7191 ]](param_00,param_01);
	self method_82EA(param_01,var_04,1,param_02,1);
	self.var_3135.var_5615 = 1;
	var_05 = ["right_arm","left_arm","torso","right_leg","left_leg"];
	foreach(var_07 in var_05)
	{
		var_08 = self method_850C(var_07,"upper");
		var_09 = self method_850C(var_07,"lower");
		var_0A = max(var_08,var_09);
		if(var_08 > 0 && var_09 > 0)
		{
			self method_850B(int(var_0A),var_07,"upper");
			self method_850B(int(var_0A),var_07,"lower");
		}
	}

	lib_0A1E::func_231F(param_00,param_01);
	self.var_3135.var_5615 = undefined;
}

//Function Number: 13
func_40FB(param_00,param_01,param_02)
{
	lib_0A1A::func_232F("grenade response","return throw complete");
}