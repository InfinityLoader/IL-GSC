/*******************************************************************
 * Decompiled By: Bog
 * Decompiled File: scripts\anim\grenade_return_throw.gsc
 * Game: Call of Duty: Infinite Warfare
 * Platform: PC
 * Function Count: 4
 * Decompile Time: 250 ms
 * Timestamp: 10/27/2023 12:00:37 AM
*******************************************************************/

//Function Number: 1
main()
{
	if(getdvarint("ai_iw7",0) == 1)
	{
		lib_0A1A::func_232F("grenade response","return throw");
		self endon("killanimscript");
		self endon("death");
		self waittill("killanimscript");
	}

	self method_8221("face enemy");
	self endon("killanimscript");
	scripts\anim\utility::func_9832("grenade_return_throw");
	self method_8016("zonly_physics");
	var_00 = undefined;
	var_01 = 1000;
	if(isdefined(self.var_10C))
	{
		var_01 = distance(self.origin,self.var_10C.origin);
	}

	var_02 = [];
	if(var_01 < 600 && func_9E8C())
	{
		if(var_01 < 300)
		{
			var_02 = scripts\anim\utility::func_B027("grenade","return_throw_short");
		}
		else
		{
			var_02 = scripts\anim\utility::func_B027("grenade","return_throw_long");
		}
	}

	if(var_02.size == 0)
	{
		var_02 = scripts\anim\utility::func_B027("grenade","return_throw_default");
	}

	var_00 = var_02[randomint(var_02.size)];
	self method_82E4("throwanim",var_00,%body,1,0.3);
	var_04 = animhasnotetrack(var_00,"grenade_left") || animhasnotetrack(var_00,"grenade_right");
	if(var_04)
	{
		scripts\anim\shared::func_CC2C(self.var_394,"left");
		thread func_DB3A();
		thread func_C162("throwanim","grenade_left");
		thread func_C162("throwanim","grenade_right");
		self waittill("grenade_pickup");
		self method_8228();
		scripts\anim\battlechatter_ai::func_67CF("frag");
		self waittillmatch("grenade_throw","throwanim");
	}
	else
	{
		self waittillmatch("grenade_throw","throwanim");
		self method_8228();
		scripts\anim\battlechatter_ai::func_67CF("frag");
	}

	if(isdefined(self.var_15F))
	{
		self method_83C2();
	}

	wait(1);
	if(var_04)
	{
		self notify("put_weapon_back_in_right_hand");
		scripts\anim\shared::func_CC2C(self.var_394,"right");
	}
}

//Function Number: 2
func_9E8C()
{
	var_00 = (self.origin[0],self.origin[1],self.origin[2] + 20);
	var_01 = var_00 + anglestoforward(self.angles) * 50;
	return sighttracepassed(var_00,var_01,0,undefined);
}

//Function Number: 3
func_DB3A()
{
	self endon("death");
	self endon("put_weapon_back_in_right_hand");
	self waittill("killanimscript");
	scripts\anim\shared::func_CC2C(self.var_394,"right");
}

//Function Number: 4
func_C162(param_00,param_01)
{
	self endon("killanimscript");
	self endon("grenade_pickup");
	self waittillmatch(param_01,param_00);
	self notify("grenade_pickup");
}