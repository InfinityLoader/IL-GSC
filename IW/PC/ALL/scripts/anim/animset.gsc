/*******************************************************************
 * Decompiled By: Bog
 * Decompiled File: scripts\anim\animset.gsc
 * Game: Call of Duty: Infinite Warfare
 * Platform: PC
 * Function Count: 44
 * Decompile Time: 2344 ms
 * Timestamp: 10/26/2023 11:59:52 PM
*******************************************************************/

//Function Number: 1
func_94FD()
{
	if(isdefined(level.var_1FD2))
	{
		return;
	}

	anim.var_1FD2 = 1;
	if(!isdefined(level.var_2128))
	{
		anim.var_2128 = [];
	}

	level.var_2128["soldier"] = [];
	scripts\anim\cover_left::func_9507();
	scripts\anim\cover_right::func_950A();
	scripts\anim\cover_prone::func_9509();
	scripts\anim\cover_wall::func_950B();
	scripts\anim\reactions::func_951D();
	scripts\anim\pain::func_951B();
	scripts\anim\death::func_9510();
	scripts\anim\combat::func_9504();
	scripts\anim\move::func_951A();
	scripts\anim\flashed::func_9514();
	scripts\anim\stop::func_9518();
	anim.var_1FD1 = spawnstruct();
	level.var_1FD1.var_BBF7 = [];
	func_9513();
	func_950D();
	func_951C();
	func_951F();
	func_9523();
	func_9517();
	func_9511();
	func_951E();
	func_9522();
	func_9512();
	func_9520();
	func_9524();
	func_950C();
	func_9516();
	func_9692();
	func_95D5();
	func_9515();
	func_960E();
	func_9521();
	func_9503();
}

//Function Number: 2
func_DEE7(param_00,param_01,param_02)
{
	func_94FD();
	level.var_2128[param_00] = param_01;
	if(isdefined(param_01["flashed"]))
	{
		level.var_6EC0[param_00] = 0;
	}

	if(isdefined(param_02) && param_02)
	{
		scripts\anim\init_move_transitions::func_814D(param_00);
	}
}

//Function Number: 3
func_2126(param_00)
{
	return archetypeassetloaded(param_00) || isdefined(level.var_2128[param_00]);
}

//Function Number: 4
func_9520()
{
}

//Function Number: 5
func_9516()
{
}

//Function Number: 6
func_9524()
{
}

//Function Number: 7
func_950C()
{
}

//Function Number: 8
func_951C()
{
}

//Function Number: 9
func_951F()
{
}

//Function Number: 10
func_9523()
{
}

//Function Number: 11
func_950D()
{
}

//Function Number: 12
func_9517()
{
}

//Function Number: 13
func_9515()
{
}

//Function Number: 14
func_9513()
{
}

//Function Number: 15
func_9511()
{
}

//Function Number: 16
func_951E()
{
}

//Function Number: 17
func_9522()
{
}

//Function Number: 18
func_9512()
{
}

//Function Number: 19
func_9506(param_00)
{
}

//Function Number: 20
func_950F(param_00,param_01,param_02,param_03)
{
}

//Function Number: 21
func_9505(param_00)
{
}

//Function Number: 22
func_950E(param_00,param_01,param_02)
{
}

//Function Number: 23
func_413F()
{
	self.var_4C8F = undefined;
	self.var_4C8C = undefined;
	self.var_440C = undefined;
	self.var_4400 = undefined;
}

//Function Number: 24
func_F2C2(param_00)
{
}

//Function Number: 25
func_F2C1()
{
}

//Function Number: 26
func_F2B9()
{
}

//Function Number: 27
func_F2BD()
{
}

//Function Number: 28
func_F2B5()
{
}

//Function Number: 29
func_F2BB(param_00)
{
}

//Function Number: 30
func_F2B4()
{
}

//Function Number: 31
func_F2BA(param_00)
{
}

//Function Number: 32
func_F2B3()
{
}

//Function Number: 33
func_F2B2()
{
}

//Function Number: 34
func_F2BE()
{
	if(scripts\anim\utility_common::func_9FCA())
	{
		self.var_1491.var_2274 = scripts\anim\utility::func_B028("pistol_stand");
		return;
	}

	if(isdefined(self.var_440C))
	{
		self.var_1491.var_2274 = self.var_440C;
		return;
	}

	if(isdefined(self.var_8CD0))
	{
		self.var_1491.var_2274 = scripts\anim\utility::func_B028("heat_stand");
		return;
	}

	if(scripts\anim\utility_common::func_1311B())
	{
		self.var_1491.var_2274 = scripts\anim\utility::func_B028("rpg_stand");
		return;
	}

	if(isdefined(self.var_394) && scripts\anim\utility_common::func_13C40())
	{
		self.var_1491.var_2274 = scripts\anim\utility::func_B028("shotgun_stand");
		return;
	}

	if(scripts\anim\utility::func_9D9B())
	{
		self.var_1491.var_2274 = scripts\anim\utility::func_B028("cqb_stand");
		return;
	}

	self.var_1491.var_2274 = scripts\anim\utility::func_B028("default_stand");
}

//Function Number: 35
func_F2B6()
{
	if(scripts\anim\utility_common::func_9FCA())
	{
		scripts\anim\shared::func_CC2C(self.var_D8E1,"right");
	}

	if(isdefined(self.var_4400))
	{
		self.var_1491.var_2274 = self.var_4400;
		return;
	}

	if(scripts\anim\utility_common::func_1311B())
	{
		self.var_1491.var_2274 = scripts\anim\utility::func_B028("rpg_crouch");
		return;
	}

	if(isdefined(self.var_394) && scripts\anim\utility_common::func_13C40())
	{
		self.var_1491.var_2274 = scripts\anim\utility::func_B028("shotgun_crouch");
		return;
	}

	self.var_1491.var_2274 = scripts\anim\utility::func_B028("default_crouch");
}

//Function Number: 36
func_F2BC()
{
	if(scripts\anim\utility_common::func_9FCA())
	{
		scripts\anim\shared::func_CC2C(self.var_D8E1,"right");
	}

	self.var_1491.var_2274 = scripts\anim\utility::func_B028("default_prone");
}

//Function Number: 37
func_9692()
{
}

//Function Number: 38
func_95D5()
{
}

//Function Number: 39
func_960E()
{
}

//Function Number: 40
func_9521()
{
}

//Function Number: 41
func_FA33()
{
	self.var_B4C3 = 130;
	self.var_E878 = 0.4615385;
	self.var_E876 = 0.3;
}

//Function Number: 42
func_9503()
{
}

//Function Number: 43
func_F2AC()
{
	self.var_1491.var_BCA5["move_l"] = scripts\anim\utility::func_B027("ambush","move_l");
	self.var_1491.var_BCA5["move_r"] = scripts\anim\utility::func_B027("ambush","move_r");
	self.var_1491.var_BCA5["move_b"] = scripts\anim\utility::func_B027("ambush","move_b");
}

//Function Number: 44
func_8CD8()
{
	if(self.var_394 != self.var_D8E1)
	{
		return scripts\anim\utility::func_1F67("reload");
	}

	if(isdefined(self.var_205))
	{
		if(self method_8214())
		{
			var_00 = undefined;
			if(self.var_205.type == "Cover Left")
			{
				var_00 = scripts\anim\utility::func_B027("heat_reload","reload_cover_left");
			}
			else if(self.var_205.type == "Cover Right")
			{
				var_00 = scripts\anim\utility::func_B027("heat_reload","reload_cover_right");
			}

			if(isdefined(var_00))
			{
				return var_00;
			}
		}
	}

	return scripts\anim\utility::func_B027("heat_reload","reload_default");
}