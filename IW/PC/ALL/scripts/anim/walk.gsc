/*******************************************************************
 * Decompiled By: Bog
 * Decompiled File: scripts\anim\walk.gsc
 * Game: Call of Duty: Infinite Warfare
 * Platform: PC
 * Function Count: 4
 * Decompile Time: 278 ms
 * Timestamp: 10/27/2023 12:01:15 AM
*******************************************************************/

//Function Number: 1
func_BD2B()
{
	var_00 = undefined;
	if(isdefined(self.var_233) && distancesquared(self.origin,self.var_233) > 4096)
	{
		var_00 = "stand";
	}

	var_01 = [[ self.var_3EF3 ]](var_00);
	switch(var_01)
	{
		case "stand":
			if(scripts\anim\setposemovement::func_10B84())
			{
				return;
			}
	
			if(isdefined(self.var_13872))
			{
				scripts\anim\move::func_BCF8(self.var_13872,self.var_13871);
				return;
			}
	
			func_5AEB(func_820B("straight"));
			break;

		case "crouch":
			if(scripts\anim\setposemovement::func_4AB1())
			{
				return;
			}
	
			func_5AEB(func_820B("crouch"));
			break;

		default:
			if(scripts\anim\setposemovement::func_DA91())
			{
				return;
			}
	
			self.var_1491.var_BCC8 = "walk";
			func_5AEB(func_820B("prone"));
			break;
	}
}

//Function Number: 2
func_5AEC(param_00)
{
	self endon("movemode");
	self method_806F(%combatrun,0.6);
	self method_82A5(%combatrun,%body,1,0.5,self.var_BCD6);
	if(isarray(self.var_13872))
	{
		if(isdefined(self.var_13871))
		{
			var_01 = scripts\common\utility::func_3E83(self.var_13872,self.var_13871);
		}
		else
		{
			var_01 = self.var_13872[randomint(self.var_13872.size)];
		}
	}
	else
	{
		var_01 = self.var_13872;
	}

	self method_82E2("moveanim",var_01,1,0.2);
	scripts\anim\shared::func_592B("moveanim");
}

//Function Number: 3
func_820B(param_00)
{
	if(self.var_2C0 == "up")
	{
		return scripts\anim\utility::func_7FCC("stairs_up");
	}
	else if(self.var_2C0 == "down")
	{
		return scripts\anim\utility::func_7FCC("stairs_down");
	}

	var_01 = scripts\anim\utility::func_7FCC(param_00);
	if(isarray(var_01))
	{
		var_01 = var_01[randomint(var_01.size)];
	}

	return var_01;
}

//Function Number: 4
func_5AEB(param_00)
{
	self endon("movemode");
	var_01 = self.var_BCD6;
	if(self.var_2C0 != "none")
	{
		var_01 = var_01 * 0.6;
	}

	if(self.var_1491.var_D6A5 == "stand")
	{
		if(isdefined(self.var_10C))
		{
			scripts\anim\cqb::func_479B();
			self method_82E3("walkanim",scripts\anim\cqb::func_53C3(),%walk_and_run_loops,1,1,var_01,1);
		}
		else
		{
			self method_82E3("walkanim",param_00,%body,1,1,var_01,1);
		}

		scripts\anim\run::func_F7A9(scripts\anim\utility::func_7FCC("move_b"),scripts\anim\utility::func_7FCC("move_l"),scripts\anim\utility::func_7FCC("move_r"));
		thread scripts\anim\run::func_F69A("walk");
	}
	else if(self.var_1491.var_D6A5 == "prone")
	{
		self method_82E2("walkanim",scripts\anim\utility::func_7FCC("prone"),1,0.3,self.var_BCD6);
	}
	else
	{
		self method_82E3("walkanim",param_00,%body,1,1,var_01,1);
		scripts\anim\run::func_F7A9(scripts\anim\utility::func_7FCC("move_b"),scripts\anim\utility::func_7FCC("move_l"),scripts\anim\utility::func_7FCC("move_r"));
		thread scripts\anim\run::func_F69A("walk");
	}

	scripts\anim\notetracks::func_5931(0.2,"walkanim");
	scripts\anim\run::func_F843(0);
}