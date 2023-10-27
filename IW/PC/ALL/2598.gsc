/*******************************************************************
 * Decompiled By: Bog
 * Decompiled File: 2598.gsc
 * Game: Call of Duty: Infinite Warfare
 * Platform: PC
 * Function Count: 7
 * Decompile Time: 4 ms
 * Timestamp: 10/27/2023 12:23:25 AM
*******************************************************************/

//Function Number: 1
func_3ED1(param_00,param_01,param_02)
{
	if(!lib_0A1A::func_2346(param_01,self.var_1491.var_D6A5))
	{
		return lib_0A1A::func_2358(param_01,"default");
	}

	return lib_0A1A::func_2358(param_01,self.var_1491.var_D6A5);
}

//Function Number: 2
func_10073(param_00,param_01,param_02,param_03)
{
	if(lib_0A1B::func_2988())
	{
		return 1;
	}

	return 0;
}

//Function Number: 3
func_C875(param_00,param_01,param_02,param_03)
{
	return lib_0A1A::func_232B(param_01,"end") && lib_0A1B::func_294B();
}

//Function Number: 4
func_337F(param_00,param_01,param_02,param_03)
{
	return lib_0A0B::func_2040();
}

//Function Number: 5
func_33AC(param_00,param_01,param_02,param_03)
{
	lib_0C60::func_11043();
	self playsound("shield_death_c6_1");
	func_3368();
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

	self method_839B("torso_upper",var_04 * 2400);
	level.player method_8244("damage_heavy");
	earthquake(0.5,1,level.player.origin,100);
	level.player scripts\common\utility::delaycall(0.25,::stoprumble,"damage_heavy");
	wait(1);
	lib_0C60::func_4E36();
}

//Function Number: 6
func_3368()
{
	if(!isdefined(self.var_4D5D))
	{
		return;
	}

	foreach(var_05, var_01 in self.var_4D5D)
	{
		if(var_05 == "head" && self method_850C(var_05) <= 0)
		{
			continue;
		}

		foreach(var_04, var_03 in self.var_4D5D[var_05].var_C92D)
		{
			if(!isdefined(self))
			{
				return;
			}

			self setscriptablepartstate(var_05,"dmg_" + var_04 + "_both",1);
		}
	}
}

//Function Number: 7
func_3361(param_00,param_01,param_02,param_03)
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
	if(self.var_238F == "c6_worker")
	{
		var_04 = "pain_shock";
	}
	else if(self.var_1491.var_D6A5 == "stand")
	{
		var_04 = "shock_loop_stand";
	}
	else if(self.var_1491.var_D6A5 == "crouch")
	{
		var_04 = "shock_loop_crouch";
	}

	thread func_3368();
	playfxontag(level.var_7649["c6_death"],self,"j_spine4");
	if(soundexists("emp_shock_short"))
	{
		function_0178("shock_knife_blast",level.player geteye());
	}

	thread lib_0C66::func_FE4E(self.var_238F,var_04,0.02,1,0,1);
	wait(0.5);
	self notify(var_04 + "_finished");
	self method_83AD();
	level.player stoprumble("damage_heavy");
	thread scripts\sp\_art::func_583D(0.5);
	scripts\anim\shared::func_5D1A();
	if(isdefined(self.var_71C8))
	{
		self [[ self.var_71C8 ]]();
	}

	self method_839B("torso_upper",vectornormalize(self.origin - level.player.origin + (0,0,10)) * 2200);
	wait(0.1);
	var_05 = lib_0A1E::func_2339();
	self method_806F(var_05,0.05);
	lib_0C60::func_4E36();
}