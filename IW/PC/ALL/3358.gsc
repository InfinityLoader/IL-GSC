/*******************************************************************
 * Decompiled By: Bog
 * Decompiled File: 3358.gsc
 * Game: Call of Duty: Infinite Warfare
 * Platform: PC
 * Function Count: 25
 * Decompile Time: 7 ms
 * Timestamp: 10/27/2023 12:26:45 AM
*******************************************************************/

//Function Number: 1
init()
{
	level._effect["transponder_activate"] = loadfx("vfx/iw7/_requests/mp/vfx_transponder_activate.vfx");
	level._effect["direction_indicator_close"] = loadfx("vfx/iw7/_requests/mp/vfx_transponder_direction_indicator_close.vfx");
	level._effect["direction_indicator_mid"] = loadfx("vfx/iw7/_requests/mp/vfx_transponder_direction_indicator_mid.vfx");
	level._effect["direction_indicator_far"] = loadfx("vfx/iw7/_requests/mp/vfx_transponder_direction_indicator_far.vfx");
}

//Function Number: 2
func_E180()
{
	self notify("remove_transponder");
}

//Function Number: 3
func_1268C(param_00)
{
	if(func_3E5A(param_00))
	{
		func_1268E(param_00);
		return;
	}

	thread func_CC21(param_00);
}

//Function Number: 4
func_1268F(param_00)
{
	scripts\cp\powers\coop_powers::func_160E("power_transponder");
	func_1268C(param_00);
}

//Function Number: 5
func_1268E(param_00)
{
	self endon("clear_previous_tombstone");
	self endon("lost_and_found_time_out");
	self endon("disconnect");
	self endon("remove_transponder");
	var_01 = "power_transponder";
	if(!scripts\cp\_utility::func_9F19(self))
	{
		param_00 delete();
		return;
	}

	param_00 thread scripts\cp\_weapon::func_C4F4("powers_transponder_used");
	param_00 thread func_136B7(self);
	thread func_13B90(param_00);
	param_00 method_831F(self);
	param_00.var_1604 = 0;
	param_00.script_noteworthy = "placed_transponder";
	func_C5AC(param_00);
	param_00 thread func_13A5D(self);
	param_00 thread func_12690();
	level thread scripts\cp\_weapon::func_B9CA(self,param_00);
}

//Function Number: 6
func_136B7(param_00)
{
	self endon("alt_detonate");
	self endon("detonated");
	self waittill("detonateExplosive");
	param_00 func_12693();
}

//Function Number: 7
func_13A5D(param_00)
{
	param_00 endon("clear_previous_tombstone");
	param_00 endon("lost_and_found_time_out");
	param_00 endon("disconnect");
	self endon("alt_detonate");
	self endon("detonated");
	param_00 waittill("detonate_transponder");
	self notify("detonate");
	param_00 func_12693();
}

//Function Number: 8
func_C5AC(param_00)
{
	if(self.var_CC4D.size)
	{
		self.var_CC4D = scripts\common\utility::func_22BC(self.var_CC4D);
		if(self.var_CC4D.size >= level.var_B4BA)
		{
			self.var_CC4D[0] notify("detonateExplosive");
		}
	}

	self.var_CC4D[self.var_CC4D.size] = param_00;
	var_01 = param_00 getentitynumber();
	level.var_B779[var_01] = param_00;
	level notify("mine_planted");
}

//Function Number: 9
func_13B90(param_00)
{
	self endon("clear_previous_tombstone");
	self endon("lost_and_found_time_out");
	self endon("disconnect");
	self endon("alt_detonate");
	self endon("detonated");
	param_00 waittill("activated");
	for(;;)
	{
		self waittillmatch("ztransponder_mp","detonate");
		if(scripts\cp\_utility::isteleportenabled())
		{
			if(isdefined(param_00) && param_00.var_1604)
			{
				func_1268D(param_00);
				func_12693();
			}

			continue;
		}

		continue;
	}
}

//Function Number: 10
func_A65D()
{
	var_00 = cos(75);
	var_01 = 2000;
	var_02 = 300;
	var_03 = var_02 / 2;
	var_04 = vectornormalize(anglestoforward(self.angles));
	var_05 = var_04 * var_03;
	var_06 = self.origin + var_05;
	physicsexplosionsphere(var_06,var_03,1,2.5);
	var_07 = scripts\cp\_agent_utils::func_7DB0("axis");
	var_08 = scripts\common\utility::func_782F(self.origin,var_07,undefined,var_02);
	foreach(var_0A in var_08)
	{
		var_0B = 0;
		var_0C = var_0A.origin;
		var_0D = scripts\common\utility::func_13D90(self geteye(),self.angles,var_0C + (0,0,30),var_00);
		if(var_0D)
		{
			var_0E = distance2d(self.origin,var_0C);
			if(var_0E < var_02)
			{
				var_0B = 1;
			}
		}

		if(var_0B)
		{
			var_04 = anglestoforward(self.angles);
			var_0F = vectornormalize(var_04) * -100;
			var_0A setvelocity(vectornormalize(var_0A.origin - self.origin + var_0F) * 800 + (0,0,300));
			var_01 = var_0A.maxhealth;
			var_0A func_A6C8(self,var_01,var_0C,self.origin);
		}
	}
}

//Function Number: 11
func_A6C8(param_00,param_01,param_02,param_03)
{
	self.do_immediate_ragdoll = 1;
	if(param_01 >= self.health)
	{
		self.var_4C87 = 1;
	}

	self dodamage(param_01,param_02,param_00,param_00,"MOD_IMPACT","ztransponder_mp");
}

//Function Number: 12
func_12692()
{
	var_00 = self.var_222;
	var_00 endon("disconnect");
	var_00 waittill("transponder_update");
}

//Function Number: 13
func_12693()
{
	foreach(var_01 in self.var_CC4D)
	{
		if(isdefined(var_01))
		{
			if(isdefined(var_01.var_13C2E) && var_01.var_13C2E == "ztransponder_mp")
			{
				var_01 scripts\cp\_weapon::func_51B5(0);
				scripts\common\utility::func_22A9(self.var_CC4D,var_01);
			}
		}
	}

	scripts\cp\powers\coop_powers::func_4DE0("power_transponder");
	self notify("transponder_update",0);
	waittillframeend;
	self notify("detonated");
	self notify("alt_detonate");
}

//Function Number: 14
func_13B8F(param_00)
{
	self endon("clear_previous_tombstone");
	self endon("lost_and_found_time_out");
	self endon("disconnect");
	self endon("detonated");
	param_00 waittill("activated");
	for(;;)
	{
		self waittill("alt_detonate");
		var_01 = self getcurrentweapon();
		if(var_01 != "ztransponder_mp")
		{
			if(isdefined(param_00) && param_00.var_1604)
			{
				func_1268D(param_00);
				func_12693();
				continue;
			}

			continue;
		}
	}
}

//Function Number: 15
func_13B8E(param_00)
{
	self endon("clear_previous_tombstone");
	self endon("lost_and_found_time_out");
	self endon("disconnect");
	self endon("detonated");
	level endon("game_ended");
	param_00 waittill("activated");
	var_01 = 0;
	for(;;)
	{
		if(self usebuttonpressed())
		{
			var_01 = 0;
			while(self usebuttonpressed())
			{
				var_01 = var_01 + 0.05;
				wait(0.05);
			}

			if(var_01 >= 0.5)
			{
				continue;
			}

			var_01 = 0;
			while(!self usebuttonpressed() && var_01 < 0.5)
			{
				var_01 = var_01 + 0.05;
				wait(0.05);
			}

			if(var_01 >= 0.5)
			{
				continue;
			}

			if(!self.var_CC4D.size)
			{
				return;
			}

			if(self ismantling())
			{
				self cancelmantle();
			}

			self notify("alt_detonate");
		}

		wait(0.05);
	}
}

//Function Number: 16
func_12690()
{
	self.var_222 thread func_11907(self);
	var_00 = self.var_222;
	var_01 = undefined;
	var_02 = undefined;
	self waittill("missile_stuck",var_03);
	if(isdefined(self.var_13C2E))
	{
		var_01 = self.var_13C2E;
	}

	if(isdefined(self.origin))
	{
		var_02 = self.origin;
	}

	wait(0.05);
	if(!func_3E5B(var_00,var_03))
	{
		var_00 func_CC21(self,var_02,var_01);
		return;
	}

	self.var_222 notify("powers_transponder_used",1);
	self notify("activated");
	self.var_1604 = 1;
	scripts\cp\_weapon::func_69FF(var_03);
}

//Function Number: 17
func_11907(param_00)
{
	param_00 endon("missile_stuck");
	param_00 scripts\common\utility::waittill_any_timeout_1(5,"death");
	self notify("powers_transponder_used",0);
	func_CC21(param_00);
}

//Function Number: 18
func_1268D(param_00)
{
	var_01 = undefined;
	var_02 = getclosestpointonnavmesh(param_00.origin);
	self notify("left_hidden_room_early");
	if(isdefined(var_02))
	{
		thread func_161E(self.origin,param_00.origin);
		self playlocalsound("ghost_use_transponder");
		self setorigin(var_02 + (0,0,20));
		return;
	}

	iprintlnbold("Transponder lost connection");
	self.var_222 func_12693();
}

//Function Number: 19
func_161E(param_00,param_01)
{
	var_02 = spawnfx(scripts\common\utility::getfx("transponder_activate"),param_01);
	wait(0.1);
	triggerfx(var_02);
	var_02 thread scripts\cp\_utility::func_5106(0.75);
	var_03 = "direction_indicator_far";
	var_04 = length2d(param_00 - param_01);
	if(var_04 < 1024)
	{
		var_03 = "direction_indicator_close";
	}
	else if(var_04 < 2048)
	{
		var_03 = "direction_indicator_mid";
	}

	playfx(scripts\common\utility::getfx(var_03),param_00,(0,0,1),anglestoforward(vectortoangles(param_01 - param_00)));
}

//Function Number: 20
func_E8AB()
{
	self shellshock("flashbang_mp",1.2);
	wait(1.2);
}

//Function Number: 21
func_12696(param_00)
{
	param_00 endon("death");
	self endon("disconnect");
	thread func_12698(param_00);
	while(isdefined(param_00))
	{
		var_01 = distance2d(self.origin,param_00.origin);
		wait(0.1);
	}
}

//Function Number: 22
func_12698(param_00)
{
	param_00 waittill("deleted_equipment");
}

//Function Number: 23
func_3E5B(param_00,param_01)
{
	if(!isdefined(self))
	{
		return 0;
	}

	var_02 = param_00 method_8428(param_00.origin,self.origin);
	if(var_02.size < 1)
	{
		return 0;
	}
	else if(distance2d(var_02[var_02.size - 1],self.origin) >= 12)
	{
		return 0;
	}

	var_03 = getclosestpointonnavmesh(self.origin);
	if(!isdefined(var_03))
	{
		return 0;
	}

	if(distance2d(self.origin,var_03) > 18)
	{
		return 0;
	}

	if(isdefined(level.var_164B))
	{
		if(!self [[ level.var_164B ]](var_03))
		{
			return 0;
		}
	}

	if(!scripts\cp\_weapon::func_9E54(self.origin,level.var_9B0B,param_00,undefined,1,param_01))
	{
		return 0;
	}

	if(isdefined(level.invalidtranspondervolumes))
	{
		if(isdefined(level.is_in_box_func))
		{
			foreach(var_05 in level.invalidtranspondervolumes)
			{
				if([[ level.is_in_box_func ]](var_05[0],var_05[1],var_05[2],var_05[3],self.origin))
				{
					return 0;
				}
			}
		}
	}

	if(positionwouldtelefrag(self.origin))
	{
		return 0;
	}

	return 1;
}

//Function Number: 24
func_3E5A(param_00)
{
	return !self method_8446() && !self method_81B5() && self isonground();
}

//Function Number: 25
func_CC21(param_00,param_01,param_02)
{
	self notify("powers_transponder_used",0);
	self.var_1604 = 0;
	func_12693();
	self.var_CC4D = scripts\common\utility::func_22BC(self.var_CC4D);
	var_03 = undefined;
	var_04 = undefined;
	if(isdefined(param_01))
	{
		var_03 = param_01;
	}

	if(isdefined(param_02))
	{
		var_04 = param_02;
	}

	if(isdefined(param_00))
	{
		if(isdefined(param_00.origin))
		{
			var_03 = param_00.origin;
		}

		if(isdefined(param_00.var_13C2E))
		{
			var_04 = param_00.var_13C2E;
		}
	}

	if(isdefined(var_03) && isdefined(var_04))
	{
		scripts\cp\_weapon::func_CC16(var_04,1,var_03);
	}

	if(isdefined(param_00))
	{
		param_00 delete();
	}
}