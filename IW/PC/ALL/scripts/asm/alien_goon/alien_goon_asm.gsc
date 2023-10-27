/*******************************************************************
 * Decompiled By: Bog
 * Decompiled File: scripts\asm\alien_goon\alien_goon_asm.gsc
 * Game: Call of Duty: Infinite Warfare
 * Platform: PC
 * Function Count: 9
 * Decompile Time: 462 ms
 * Timestamp: 10/27/2023 12:01:17 AM
*******************************************************************/

//Function Number: 1
asminit(param_00,param_01,param_02,param_03)
{
	lib_0C75::func_13F9A(param_00,param_01,param_02,param_03);
	self.fnactionvalidator = ::isvalidaction;
	scripts\asm\dlc4\dlc4_asm::analyzeanims();
}

//Function Number: 2
isvalidaction(param_00)
{
	switch(param_00)
	{
		case "stumble":
		case "slide_right":
		case "slide_left":
		case "jump_back":
		case "jump_attack":
		case "stand_melee":
		case "jump":
		case "moving_melee":
		case "taunt":
			return 1;
	}

	return 0;
}

//Function Number: 3
shouldplayentranceanim(param_00,param_01,param_02,param_03)
{
	return 0;
}

//Function Number: 4
playstumble(param_00,param_01,param_02,param_03)
{
	var_04 = lib_0A1D::func_2337(param_00,param_01);
	if(scripts\common\utility::istrue(self.activated_venomx_sphere))
	{
		lib_0A1D::func_2365(param_00,param_01,param_02,var_04,0.2);
		return;
	}

	lib_0A1D::func_2365(param_00,param_01,param_02,var_04,self.var_C081);
}

//Function Number: 5
playpostattackmanuever(param_00,param_01,param_02,param_03)
{
	self endon(param_01 + "_finished");
	var_04 = scripts\asm\dlc4\dlc4_asm::getenemy();
	if(isdefined(var_04))
	{
		thread lib_0C73::func_6A6A(param_01,var_04);
	}

	var_05 = lib_0A1D::func_2337(param_00,param_01);
	if(scripts\common\utility::istrue(self.activated_venomx_sphere))
	{
		lib_0A1D::func_2365(param_00,param_01,param_02,var_05,0.2);
		return;
	}

	lib_0A1D::func_2365(param_00,param_01,param_02,var_05,self.var_C081);
}

//Function Number: 6
wantstododge(param_00,param_01,param_02,param_03)
{
	return isdefined(self.var_1198.requested_dodge_dir);
}

//Function Number: 7
playdodgeanim(param_00,param_01,param_02,param_03)
{
	var_04 = lib_0A1D::func_2337(param_00,param_01);
	if(scripts\common\utility::istrue(self.activated_venomx_sphere))
	{
		self method_8282(0.2,0.2);
	}
	else
	{
		self method_8282(self.var_1198.requested_dodge_scale,1);
	}

	self.var_1198.requested_dodge_dir = undefined;
	self.var_1198.requested_dodge_scale = undefined;
	if(scripts\common\utility::istrue(self.activated_venomx_sphere))
	{
		lib_0A1D::func_2365(param_00,param_01,param_02,var_04,0.2);
		return;
	}

	lib_0A1D::func_2365(param_00,param_01,param_02,var_04,self.var_C081);
}

//Function Number: 8
terminate_rundodge(param_00,param_01,param_02)
{
	if(scripts\common\utility::istrue(self.activated_venomx_sphere))
	{
		self method_8282(0.2,0.2);
		return;
	}

	self method_8282(1,1);
}

//Function Number: 9
choosedodgeanim(param_00,param_01,param_02)
{
	return lib_0A1A::func_2358(param_01,self.var_1198.requested_dodge_dir);
}