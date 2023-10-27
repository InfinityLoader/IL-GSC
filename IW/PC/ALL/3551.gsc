/*******************************************************************
 * Decompiled By: Bog
 * Decompiled File: 3551.gsc
 * Game: Call of Duty: Infinite Warfare
 * Platform: PC
 * Function Count: 10
 * Decompile Time: 1 ms
 * Timestamp: 10/27/2023 12:30:40 AM
*******************************************************************/

//Function Number: 1
func_F286()
{
}

//Function Number: 2
func_12BF4(param_00)
{
	if(func_9FC1())
	{
		func_62A3(param_00);
	}
}

//Function Number: 3
func_12F9B()
{
	if(func_9FC1())
	{
		return 0;
	}

	self.var_9D8B = 1;
	self.var_5583 = 1;
	scripts\mp\_utility::func_8387("specialty_noscopeoutline");
	scripts\mp\_utility::func_8387("specialty_spygame");
	scripts\mp\_utility::func_8387("specialty_blindeye");
	scripts\mp\_utility::func_8387("specialty_no_target");
	self.var_423A = 1;
	self setscriptablepartstate("cloak","on",0);
	self setscriptablepartstate("jet_pack","off",0);
	self setscriptablepartstate("teamColorPins","off",0);
	if(!scripts\mp\_utility::func_9D46())
	{
		thread scripts\mp\_supers::watchobjuse(75,1);
	}

	thread func_13A14();
	return 1;
}

//Function Number: 4
func_13A14()
{
	self endon("death");
	self endon("disconnect");
	self endon("cloak_end");
	scripts\common\utility::waittill_any_3("grenade_throw","weapon_fired","melee_fired");
	scripts\mp\_supers::func_DE3B(9999);
}

//Function Number: 5
func_62A3(param_00,param_01)
{
	if(!isdefined(self))
	{
		return;
	}

	self notify("cloak_end");
	self notify("obj_drain_end");
	param_00 = scripts\common\utility::istrue(param_00);
	param_01 = scripts\common\utility::istrue(param_01);
	if(param_00)
	{
		self setscriptablepartstate("cloak","offImmediate",0);
		self.var_9D8B = undefined;
		self.var_5583 = 0;
		self.var_423A = undefined;
		return;
	}

	if(param_01)
	{
		thread endimmediate();
		return;
	}

	thread enddelayed();
}

//Function Number: 6
enddelayed()
{
	self endon("disconnect");
	self endon("cloak_end");
	enddelayedinternal();
	if(scripts\mp\_utility::func_9FB3(self.var_423A))
	{
		scripts\mp\_utility::func_E150("specialty_noscopeoutline");
		scripts\mp\_utility::func_E150("specialty_spygame");
		scripts\mp\_utility::func_E150("specialty_blindeye");
		scripts\mp\_utility::func_E150("specialty_no_target");
	}

	if(!scripts\mp\_utility::func_9FB3(level.broshotrunning))
	{
		self setscriptablepartstate("jet_pack","neutral",0);
		self setscriptablepartstate("teamColorPins","teamColorPins",0);
	}

	self.var_9D8B = undefined;
	self.var_5583 = 0;
	self.var_423A = undefined;
}

//Function Number: 7
enddelayedinternal()
{
	self endon("death");
	wait(0.05000001);
	if(!scripts\mp\_utility::func_9FB3(level.broshotrunning))
	{
		self setscriptablepartstate("cloak","off",0);
	}

	wait(0.45);
}

//Function Number: 8
endimmediate()
{
	if(scripts\mp\_utility::func_9FB3(self.var_423A))
	{
		scripts\mp\_utility::func_E150("specialty_noscopeoutline");
		scripts\mp\_utility::func_E150("specialty_spygame");
		scripts\mp\_utility::func_E150("specialty_blindeye");
		scripts\mp\_utility::func_E150("specialty_no_target");
	}

	if(!scripts\mp\_utility::func_9FB3(level.broshotrunning))
	{
		self setscriptablepartstate("jet_pack","neutral",0);
		self setscriptablepartstate("teamColorPins","teamColorPins",0);
	}

	self.var_9D8B = undefined;
	self.var_5583 = 0;
	self.var_423A = undefined;
}

//Function Number: 9
func_E26A()
{
	self setscriptablepartstate("cloak","offImmediate",0);
}

//Function Number: 10
func_9FC1()
{
	return scripts\mp\_utility::func_9FB3(self.var_9D8B);
}