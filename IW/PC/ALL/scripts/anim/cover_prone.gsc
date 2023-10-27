/*******************************************************************
 * Decompiled By: Bog
 * Decompiled File: scripts\anim\cover_prone.gsc
 * Game: Call of Duty: Infinite Warfare
 * Platform: PC
 * Function Count: 15
 * Decompile Time: 778 ms
 * Timestamp: 10/27/2023 12:00:25 AM
*******************************************************************/

//Function Number: 1
func_9509()
{
}

//Function Number: 2
main()
{
	self endon("killanimscript");
	scripts\anim\utility::func_9832("cover_prone");
	if(weaponclass(self.var_394) == "rocketlauncher")
	{
		scripts\anim\combat::main();
		return;
	}

	if(isdefined(self.var_205.var_129B9))
	{
		scripts\anim\cover_wall::func_130DF();
	}

	if(isdefined(self.var_10C) && lengthsquared(self.origin - self.var_10C.origin) < squared(512))
	{
		thread scripts\anim\combat::main();
		return;
	}

	func_F924();
	self.var_473C = self.var_205;
	self method_8221("face angle",self.var_473C.angles[1]);
	self.var_1491.var_8445 = 1;
	self method_832B(-45,45,%prone_legs_down,%exposed_modern,%prone_legs_up);
	if(self.var_1491.var_D6A5 != "prone")
	{
		func_DA7B("prone");
	}
	else
	{
		scripts\anim\utility::func_662A(0);
	}

	thread scripts\anim\combat_utility::func_1A3E();
	func_FADE(0.2);
	self method_82A2(%prone_aim_5,1,0.1);
	self method_8221("face angle",self.var_473C.angles[1]);
	self method_8016("zonly_physics");
	func_DA7E();
	self notify("stop_deciding_how_to_shoot");
}

//Function Number: 3
func_010B()
{
	self.var_1491.var_8445 = undefined;
}

//Function Number: 4
func_92FF()
{
	self endon("killanimscript");
	self endon("kill_idle_thread");
	for(;;)
	{
		var_00 = scripts\anim\utility::func_1F67("prone_idle");
		self method_82E8("idle",var_00);
		self waittillmatch("end","idle");
		self method_806F(var_00,0.2);
	}
}

//Function Number: 5
func_12EF6(param_00)
{
	self method_83CF(scripts\anim\utility::func_B027("cover_prone","legs_up"),scripts\anim\utility::func_B027("cover_prone","legs_down"),1,param_00,1);
	self method_82A2(%exposed_aiming,1,0.2);
}

//Function Number: 6
func_DA7E()
{
	self endon("killanimscript");
	thread scripts\anim\track::func_11B07();
	thread scripts\anim\shoot_behavior::func_4F69("normal");
	var_00 = gettime() > 2500;
	for(;;)
	{
		scripts\anim\utility::func_12EB9();
		func_12EF6(0.05);
		if(!var_00)
		{
			wait(0.05 + randomfloat(1.5));
			var_00 = 1;
			continue;
		}

		if(!isdefined(self.var_FECF))
		{
			if(func_453F())
			{
				continue;
			}

			wait(0.05);
			continue;
		}

		var_01 = lengthsquared(self.origin - self.var_FECF);
		if(self.var_1491.var_D6A5 != "crouch" && self method_81BF("crouch") && var_01 < squared(400))
		{
			if(var_01 < squared(285))
			{
				func_DA7B("crouch");
				thread scripts\anim\combat::main();
				return;
			}
		}

		if(func_453F())
		{
			continue;
		}

		if(func_DA83(0))
		{
			continue;
		}

		if(scripts\anim\combat_utility::func_1A3B())
		{
			scripts\anim\combat_utility::func_FEDF();
			self method_806F(%add_fire,0.2);
			continue;
		}

		wait(0.05);
	}
}

//Function Number: 7
func_DA83(param_00)
{
	return scripts\anim\combat_utility::func_260(param_00,scripts\anim\utility::func_1F64("reload"));
}

//Function Number: 8
func_F924()
{
	self method_82D0(self.var_205);
	self.var_1491.var_2274 = scripts\anim\utility::func_B028("cover_prone");
}

//Function Number: 9
func_128AF(param_00,param_01)
{
	var_02 = undefined;
	if(isdefined(param_01) && param_01)
	{
		var_02 = scripts\anim\utility::func_1F67("grenade_safe");
	}
	else
	{
		var_02 = scripts\anim\utility::func_1F67("grenade_exposed");
	}

	self method_8016("zonly_physics");
	self.var_1A4 = 1;
	var_03 = (32,20,64);
	var_04 = scripts\anim\combat_utility::func_128A0(param_00,var_02);
	self.var_1A4 = 0;
	return var_04;
}

//Function Number: 10
func_453F()
{
	if(isdefined(level.var_11813) && isalive(level.player))
	{
		if(func_128AF(level.player,200))
		{
			return 1;
		}
	}

	if(isdefined(self.var_10C))
	{
		return func_128AF(self.var_10C,850);
	}

	return 0;
}

//Function Number: 11
func_10012()
{
	if(!isdefined(self.var_394) || !function_0245(self.var_394) || !function_02BE(self.var_394))
	{
		return 0;
	}

	if(isdefined(self.var_205) && distancesquared(self.origin,self.var_205.origin) < 256)
	{
		return 0;
	}

	if(isdefined(self.var_10C) && self method_805F(self.var_10C) && !isdefined(self.var_15F) && scripts\anim\shared::func_7DA8() < 20)
	{
		return scripts\anim\move::func_B4EC();
	}

	return 0;
}

//Function Number: 12
func_DA7B(param_00)
{
	if(param_00 == self.var_1491.var_D6A5)
	{
		return;
	}

	self method_806F(%root,0.3);
	scripts\anim\combat_utility::func_631A();
	if(func_10012())
	{
		var_01 = scripts\anim\utility::func_1F64(self.var_1491.var_D6A5 + "_2_" + param_00 + "_firing");
	}
	else
	{
		var_01 = scripts\anim\utility::func_1F64(self.var_1491.var_D6A5 + "_2_" + var_01);
	}

	if(param_00 == "prone")
	{
	}

	self method_82E4("trans",var_01,%body,1,0.2,1);
	scripts\anim\shared::func_592B("trans");
	self method_82A8(scripts\anim\utility::func_1F64("straight_level"),%body,1,0.25);
	func_FADE(0.25);
}

//Function Number: 13
func_6CDE(param_00)
{
	self endon("killanimscript");
	scripts\anim\shared::func_592B(param_00);
}

//Function Number: 14
func_FADE(param_00)
{
	self method_82A5(%prone_aim_5,%body,1,param_00);
	self method_82AC(%prone_aim_2_add,1,param_00);
	self method_82AC(%prone_aim_4_add,1,param_00);
	self method_82AC(%prone_aim_6_add,1,param_00);
	self method_82AC(%prone_aim_8_add,1,param_00);
}

//Function Number: 15
func_DA87(param_00,param_01)
{
	self method_806F(%root,0.3);
	var_02 = undefined;
	if(isdefined(self.var_DA78))
	{
		var_02 = self.var_DA78;
	}

	if(isdefined(self.var_DA7A))
	{
		param_01 = self.var_DA7A;
	}

	if(!isdefined(param_01))
	{
		param_01 = 1;
	}

	scripts\anim\utility::func_697B(getanimlength(var_02) / 2);
	self method_82E4("trans",var_02,%body,1,0.2,param_01);
	scripts\anim\shared::func_592B("trans");
	self method_806F(var_02,0.1);
}