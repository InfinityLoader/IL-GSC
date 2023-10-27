/*******************************************************************
 * Decompiled By: Bog
 * Decompiled File: maps\mp\zombies\_zombies_traps.gsc
 * Game: Call of Duty: WWII
 * Platform: PC
 * Function Count: 88
 * Decompile Time: 1177 ms
 * Timestamp: 10/27/2023 3:25:33 AM
*******************************************************************/

//Function Number: 1
func_00D5()
{
	level.var_611["trap_ready"] = loadfx("vfx/zombie/zmb_trap_light_orange");
	level.var_611["trap_not_ready"] = loadfx("vfx/zombie/zmb_trap_light_orange_blink");
	level.var_9CD2 = [];
	level.var_9CD2["default"] = [];
	level.var_9CD1 = [];
	level.var_9CD1["ready_to_active"] = "s2_gj_zom_drop_gate_lever_move_down";
	level.var_9CD1["active_to_cooldown"] = "s2_gj_zom_drop_gate_lever_down_idle";
	level.var_9CD1["cooldown_to_active"] = "s2_gj_zom_drop_gate_lever_up_idle";
	level.var_9CCF["no_power"] = ::func_9CD3;
	level.var_9CCF["ready"] = ::func_9CD4;
	level.var_9CCF["active"] = ::func_9CCB;
	level.var_9CCF["cooldown"] = ::func_9CCD;
	level.var_9CCF["deactivate"] = ::func_9CCE;
	level.var_5AFF = 0;
	level.var_8C8 = [];
	level thread func_A8EB();
	level.var_9CFC = common_scripts\utility::func_46B7("zombie_trap","targetname");
	common_scripts\utility::func_FB2(level.var_9CFC,::func_9CAF);
}

//Function Number: 2
func_9C9E(param_00)
{
	var_01 = -1;
	switch(param_00)
	{
		case "trap_rnd":
			var_01 = 1000;
			break;

		case "trap_roof":
			var_01 = 1000;
			break;

		case "trap_med":
			var_01 = 1000;
			break;

		case "trap_aagun":
			var_01 = 500;
			break;

		case "trap_catacombs":
			var_01 = 1000;
			break;

		case "trap_firewell":
			var_01 = 500;
			break;

		default:
			var_01 = -1;
			break;
	}

	return var_01;
}

//Function Number: 3
func_9CA6(param_00)
{
	var_01 = -1;
	switch(param_00)
	{
		case "trap_rnd":
			var_01 = 20;
			break;

		case "trap_roof":
			var_01 = 20;
			break;

		case "trap_med":
			var_01 = 20;
			break;

		case "trap_aagun":
			var_01 = 20;
			break;

		case "trap_catacombs":
			var_01 = 20;
			break;

		case "trap_firewell":
			var_01 = 5;
			break;

		default:
			var_01 = -1;
			break;
	}

	return var_01;
}

//Function Number: 4
func_9C9C(param_00)
{
	var_01 = -1;
	switch(param_00)
	{
		case "trap_rnd":
			var_01 = 30;
			break;

		case "trap_roof":
			var_01 = 30;
			break;

		case "trap_med":
			var_01 = 30;
			break;

		case "trap_aagun":
			var_01 = 30;
			break;

		case "trap_catacombs":
			var_01 = 30;
			break;

		case "trap_firewell":
			var_01 = 20;
			break;

		default:
			var_01 = -1;
			break;
	}

	return var_01;
}

//Function Number: 5
func_438E()
{
	return 25;
}

//Function Number: 6
func_9CAF(param_00,param_01,param_02,param_03)
{
	var_04 = self.var_165;
	var_05 = func_9C9E(var_04);
	if(var_05 > 0)
	{
		self.var_267B = var_05;
	}
	else if(isdefined(self.var_8140))
	{
		self.var_267B = self.var_8140;
	}
	else
	{
		self.var_267B = 500;
	}

	var_06 = func_9C9C(var_04);
	if(var_06 > 0)
	{
		self.var_264F = var_06;
	}
	else if(isdefined(self.var_8260))
	{
		self.var_264F = int(self.var_8260);
	}
	else
	{
		self.var_264F = 40;
	}

	if(!common_scripts\utility::func_562E(param_00))
	{
		func_10BB();
	}
	else
	{
		func_10BC(param_01,param_02,param_03);
	}

	self.var_931A = "none";
	if(func_9CBF())
	{
		func_9CC5("no_power");
		return;
	}

	func_9CC5("ready");
}

//Function Number: 7
func_7BFB(param_00)
{
	lib_0559::func_7BE2(self,param_00.var_9D65,param_00.var_9CBB);
}

//Function Number: 8
func_10BC(param_00,param_01,param_02)
{
	foreach(var_04 in param_00)
	{
		thread func_9C95(var_04);
		thread func_9CD5(var_04);
	}

	foreach(var_07 in param_01)
	{
		thread func_9CAD(var_07);
	}

	foreach(var_0A in param_02)
	{
		thread func_9C94(var_0A);
		self.var_6298 = var_0A;
	}
}

//Function Number: 9
func_10BB()
{
	var_00 = getentarray(self.var_1A2,"targetname");
	var_01 = common_scripts\utility::func_46B7(self.var_1A2,"targetname");
	var_02 = common_scripts\utility::func_F73(var_00,var_01);
	foreach(var_04 in var_02)
	{
		if(!isdefined(var_04.var_165))
		{
			continue;
		}

		switch(var_04.var_165)
		{
			case "activate_model":
				thread func_9C94(var_04);
				self.var_6298 = var_04;
				break;

			case "activate":
				thread func_9C95(var_04);
				thread func_9CD5(var_04);
				break;

			case "laser":
				thread func_9CB1(var_04);
				break;

			case "fx_ready":
				thread func_9CAD(var_04);
				break;

			case "damage":
				thread func_9CA0(var_04,0);
				break;

			case "damage_over_time":
				thread func_9CA0(var_04,1);
				break;

			case "fx_trap":
				thread func_9CD0(var_04);
				break;

			case "fx_trap_move":
				thread func_9CAC(var_04);
				break;

			case "distraction":
				thread func_9CA4(var_04);
				break;

			case "zomboni":
				thread func_9CD7(var_04);
				break;

			default:
				break;
		}
	}
}

//Function Number: 10
func_7BD7(param_00,param_01,param_02,param_03,param_04)
{
	if(!isdefined(param_04))
	{
		param_04 = "default";
	}

	if(!isdefined(level.var_9CD2[param_04]))
	{
		level.var_9CD2[param_04] = [];
	}

	level.var_9CD2[param_04]["no_power"] = param_00;
	level.var_9CD2[param_04]["ready"] = param_01;
	level.var_9CD2[param_04]["active"] = param_02;
	level.var_9CD2[param_04]["cooldown"] = param_03;
	level.var_9CD2[param_04]["deactivate"] = param_00;
}

//Function Number: 11
func_438F()
{
	return 20;
}

//Function Number: 12
func_9CBF()
{
	return isdefined(self.var_81A1);
}

//Function Number: 13
func_9CAE()
{
	if(func_9CBF())
	{
		return common_scripts\utility::func_3C77(self.var_81A1);
	}

	return 1;
}

//Function Number: 14
func_9CC5(param_00)
{
	thread func_0732(param_00);
}

//Function Number: 15
func_0732(param_00)
{
	self notify(param_00);
	if(param_00 != self.var_931A)
	{
		self notify("trap_state_change",param_00);
	}

	self.var_931A = param_00;
	self thread [[ level.var_9CCF[param_00] ]]();
}

//Function Number: 16
func_9CD3()
{
	self endon("trap_state_change");
	if(!func_9CAE())
	{
		common_scripts\utility::func_3C9F(self.var_81A1);
	}

	func_9CC5("ready");
}

//Function Number: 17
func_9CCE()
{
	self endon("trap_state_change");
	self waittill("trap_reactivated");
	if(!func_9CAE())
	{
		common_scripts\utility::func_3C9F(self.var_81A1);
	}

	func_9CC5("ready");
}

//Function Number: 18
func_9CD4()
{
	self endon("trap_state_change");
	for(;;)
	{
		self waittill("trap_trigger",var_00,var_01);
		if(var_01 == "token")
		{
			var_00 maps/mp/gametypes/zombies::func_90F6(self.var_9A84);
		}
		else
		{
			var_02 = self.var_267B;
			if(isdefined(level.var_6F41))
			{
				for(var_03 = 0;var_03 < level.var_6F41;var_03++)
				{
					var_02 = lib_0547::func_4522(var_02);
				}
			}

			if(!var_00 maps/mp/gametypes/zombies::func_11C2(var_02))
			{
				var_00 thread lib_054E::func_695("needmoney");
				continue;
			}

			lib_0547::func_4AE4(var_00,"trap",var_02,"none","none");
		}

		var_00.var_9CFF++;
		var_00 thread lib_054E::func_62D9();
		func_9C93(var_00,0);
		break;
	}
}

//Function Number: 19
func_9C93(param_00,param_01)
{
	if(!param_01)
	{
		lib_0555::func_83DD("use_trap",param_00);
		if(isdefined(level.var_AAFE))
		{
			level thread [[ level.var_AAFE ]](self,param_00);
		}
	}

	self.var_117 = param_00;
	func_9CC5("active");
}

//Function Number: 20
func_9CA3()
{
	self.var_2A75 = 1;
	func_9CC5("deactivate");
}

//Function Number: 21
func_9CBD()
{
	self.var_2A75 = undefined;
	self notify("trap_reactivated");
}

//Function Number: 22
func_9CCB()
{
	self endon("trap_state_change");
	self endon("active");
	func_9CCC();
	if(func_9CAE())
	{
		func_9CC5("cooldown");
		return;
	}

	func_9CC5("no_power");
}

//Function Number: 23
func_9CCC()
{
	if(isdefined(self.var_9C96))
	{
		self waittill(self.var_9C96);
		return;
	}

	var_00 = func_9CA6(self.var_165);
	if(var_00 > 0)
	{
		var_01 = var_00;
	}
	else if(isdefined(self.var_817A))
	{
		var_01 = self.var_817A;
	}
	else
	{
		var_01 = func_438F();
	}

	wait(var_01);
}

//Function Number: 24
func_9CCD()
{
	self endon("trap_state_change");
	var_00 = self.var_264F;
	if(isdefined(level.var_9CF6))
	{
		var_00 = level.var_9CF6;
	}

	wait(var_00);
	if(func_9CAE())
	{
		func_9CC5("ready");
		return;
	}

	func_9CC5("no_power");
}

//Function Number: 25
func_9C94(param_00)
{
	var_01 = "default";
	for(;;)
	{
		self waittill("trap_state_change",var_02);
		var_03 = level.var_9CD2[var_01][var_02];
		if(isdefined(var_03))
		{
			param_00 setmodel(var_03);
		}

		if(var_02 == "active")
		{
			param_00 thread func_9CB7();
		}
	}
}

//Function Number: 26
func_9CB7()
{
	if(isdefined(level.var_9CD1["ready_to_active"]))
	{
		self scriptmodelplayanim(level.var_9CD1["ready_to_active"]);
		wait(0.7666667);
	}

	if(isdefined(level.var_9CD1["active_to_cooldown"]))
	{
		self scriptmodelplayanim(level.var_9CD1["active_to_cooldown"]);
		wait(1);
	}

	if(isdefined(level.var_9CD1["cooldown_to_active"]))
	{
		self scriptmodelplayanim(level.var_9CD1["cooldown_to_active"]);
	}
}

//Function Number: 27
func_9C95(param_00)
{
	for(;;)
	{
		var_01 = param_00 lib_0547::func_A795();
		var_02 = var_01[0];
		var_03 = var_01[1];
		self notify("trap_trigger",var_02,var_03);
	}
}

//Function Number: 28
func_9CD5(param_00)
{
	var_01 = self.var_165;
	var_02 = undefined;
	if(1)
	{
		var_02 = lib_0552::func_7BFC(param_00);
	}

	var_03 = spawnstruct();
	var_03.var_9CBB = var_01;
	var_03.var_9D65 = param_00;
	level thread maps\mp\_utility::func_6F74(::func_7BFB,var_03);
	for(;;)
	{
		self waittill("trap_state_change",var_04);
		if(1)
		{
			var_02.var_6642 = 1;
		}

		switch(var_04)
		{
			case "no_power":
				if(0)
				{
					param_00 sethintstring(&"ZOMBIES_REQUIRES_POWER");
					param_00 setsecondaryhintstring(&"ZOMBIES_EMPTY_STRING");
					param_00 lib_0547::func_9A85(0);
				}
		
				if(1)
				{
					var_02.var_9CCA = 0;
					var_02.interact_disabled = 1;
				}
				break;
	
			case "active":
				if(0)
				{
					param_00 sethintstring(&"ZOMBIES_EMPTY_STRING");
					param_00 setsecondaryhintstring(&"ZOMBIES_EMPTY_STRING");
					param_00 lib_0547::func_9A85(0);
				}
		
				if(1)
				{
					var_02.var_9CCA = 1;
					var_02.interact_disabled = 1;
				}
				break;
	
			case "cooldown":
				if(0)
				{
					if(isdefined(self.var_4DAF))
					{
						param_00 sethintstring(self.var_4DAF["hint_cooldown"]);
					}
					else
					{
						param_00 sethintstring(&"ZOMBIES_TRAP_COOLDOWN");
					}
		
					param_00 setsecondaryhintstring(&"ZOMBIES_EMPTY_STRING");
					param_00 lib_0547::func_9A85(0);
				}
		
				if(1)
				{
					var_02.var_9C9B = 0;
					if(isdefined(self.var_4DAF))
					{
						var_02.var_9C9B = self.var_4DAF["hint_cooldown_ref"];
					}
		
					var_02.var_9CCA = 2;
					var_02.interact_disabled = 1;
				}
				break;
	
			case "ready":
				var_05 = self.var_267B;
				if(isdefined(level.var_6F41))
				{
					for(var_06 = 0;var_06 < level.var_6F41;var_06++)
					{
						var_05 = lib_0547::func_4522(var_05);
					}
				}
		
				if(0)
				{
					if(isdefined(self.var_4DAF))
					{
						param_00 sethintstring(self.var_4DAF["hint_ready"]);
					}
					else
					{
						param_00 sethintstring(&"ZOMBIES_TRAP_BUY_GENERIC");
					}
		
					param_00 setsecondaryhintstring(lib_0547::func_4474(var_05));
					param_00 lib_0547::func_9A85(1);
				}
		
				if(1)
				{
					var_02.var_9CBE = 0;
					if(isdefined(self.var_4DAF))
					{
						var_02.var_9CBE = self.var_4DAF["hint_ready_ref"];
					}
		
					var_02.var_9CCA = 3;
					var_02.var_9C9D = var_05;
					var_02.interact_disabled = undefined;
				}
				break;
	
			case "deactivate":
				if(0)
				{
					param_00 sethintstring(&"ZOMBIES_REQUIRES_POWER");
					param_00 setsecondaryhintstring(&"ZOMBIES_EMPTY_STRING");
				}
		
				if(1)
				{
					var_02.var_9CCA = 4;
				}
				break;
	
			default:
				break;
		}
	}
}

//Function Number: 29
func_9CAC(param_00)
{
	var_01 = spawn("script_model",param_00.var_116);
	var_01.var_1D = param_00.var_1D;
	var_01.var_9255 = var_01.var_116;
	var_01.var_9189 = var_01.var_1D;
	var_01 setmodel("tag_origin");
	var_01.var_64AD = [];
	var_02 = [];
	if(isdefined(param_00.var_1A2))
	{
		var_03 = getentarray(param_00.var_1A2,"targetname");
		var_04 = common_scripts\utility::func_46B7(param_00.var_1A2,"targetname");
		var_02 = common_scripts\utility::func_F73(var_03,var_04);
	}

	foreach(var_06 in var_02)
	{
		if(!isdefined(var_06.var_165))
		{
			continue;
		}

		switch(var_06.var_165)
		{
			case "damage_over_time":
			case "damage":
				var_06 enablelinkto();
				var_06 linkto(var_01);
				thread func_9CA0(var_06,var_06.var_165 == "damage_over_time","fx_trap_move");
				break;

			case "moveto":
				var_01 func_9CB6(var_06);
				break;

			default:
				break;
		}
	}

	for(;;)
	{
		self waittill("trap_state_change",var_08);
		thread func_9CBC(var_01,var_08,param_00);
		switch(var_08)
		{
			case "active":
				thread func_9CB5(var_01);
				break;
	
			default:
				break;
		}
	}
}

//Function Number: 30
func_9CBC(param_00,param_01,param_02)
{
	if(isdefined(param_00.var_2935))
	{
		lib_0547::func_9406(param_00.var_2935,param_00,"tag_origin");
		param_00.var_2935 = undefined;
		wait(0.5);
	}

	var_03 = param_02.var_8260 + "_" + param_01;
	if(common_scripts\utility::func_3F6F(var_03))
	{
		param_00.var_2935 = common_scripts\utility::func_44F5(var_03);
	}

	if(isdefined(param_00.var_2935))
	{
		lib_0547::func_74A5(param_00.var_2935,param_00,"tag_origin");
	}
}

//Function Number: 31
func_9CB6(param_00)
{
	while(isdefined(param_00))
	{
		self.var_64AD[self.var_64AD.size] = param_00;
		if(isdefined(param_00.var_1A2))
		{
			param_00 = common_scripts\utility::func_46B5(param_00.var_1A2,"targetname");
			continue;
		}

		param_00 = undefined;
	}
}

//Function Number: 32
func_9CB1(param_00)
{
	var_01 = spawn("script_model",param_00.var_116);
	var_01.var_1D = param_00.var_1D;
	var_01.var_9255 = var_01.var_116;
	var_01.var_9189 = var_01.var_1D;
	var_01 setmodel("tag_laser");
	var_01.var_64AD = [];
	var_02 = [];
	if(isdefined(param_00.var_1A2))
	{
		var_03 = getentarray(param_00.var_1A2,"targetname");
		var_04 = common_scripts\utility::func_46B7(param_00.var_1A2,"targetname");
		var_02 = common_scripts\utility::func_F73(var_03,var_04);
	}

	foreach(var_06 in var_02)
	{
		if(!isdefined(var_06.var_165))
		{
			continue;
		}

		switch(var_06.var_165)
		{
			case "damage_over_time":
			case "damage":
				var_06 enablelinkto();
				var_06 linkto(var_01);
				thread func_9CA0(var_06,var_06.var_165 == "damage_over_time","laser");
				break;

			case "moveto":
				var_01 func_9CB6(var_06);
				break;

			default:
				break;
		}
	}

	for(;;)
	{
		self waittill("trap_state_change",var_08);
		switch(var_08)
		{
			case "deactivate":
			case "cooldown":
			case "no_power":
				var_01 stoploopsound("trap_laser_loop");
				var_01 method_8617("trap_laser_stop");
				var_01 method_80A5();
				break;
	
			case "active":
				thread func_9CB5(var_01);
				thread func_9CB4(var_01);
				break;
	
			default:
				break;
		}
	}
}

//Function Number: 33
func_9CB4(param_00)
{
	self endon("cooldown");
	self endon("no_power");
	self endon("deactivate");
	self endon("ready");
	var_01 = "trap_warning_zm";
	if(isdefined(level.var_AB15))
	{
		var_01 = level.var_AB15;
	}

	var_02 = "trap_zm";
	if(isdefined(level.var_AB14))
	{
		var_02 = level.var_AB14;
	}

	param_00 method_80A4(var_01);
	var_03 = spawn("script_origin",param_00.var_116);
	thread func_9CB2(var_03);
	wait(3);
	thread func_9CB3(var_03);
	param_00 method_80A4(var_02);
	param_00 method_8617("trap_laser_start");
	param_00 method_861D("trap_laser_loop");
}

//Function Number: 34
func_9CB2(param_00)
{
	if(level.var_5AFF == 0)
	{
		level.var_5AFF = 1;
		if(isdefined(param_00))
		{
			param_00 method_861D("trap_laser_alarm");
			return;
		}
	}
}

//Function Number: 35
func_9CB3(param_00)
{
	level.var_5AFF = 0;
	if(isdefined(param_00))
	{
		param_00 stoploopsound("trap_laser_alarm");
		param_00 delete();
	}
}

//Function Number: 36
func_9CB5(param_00)
{
	self endon("trap_state_change");
	if(!param_00.var_64AD.size)
	{
		return;
	}

	var_01 = 60;
	var_02 = 15;
	param_00.var_116 = param_00.var_9255;
	param_00.var_1D = param_00.var_9189;
	var_03 = 0;
	for(;;)
	{
		var_04 = param_00.var_64AD[var_03];
		var_05 = 0;
		var_06 = distance(param_00.var_116,var_04.var_116);
		if(var_06 > 0)
		{
			var_05 = var_06 / var_01;
		}

		var_07 = 0;
		if(isdefined(var_04.var_1D))
		{
			for(var_08 = 0;var_08 < 3;var_08++)
			{
				var_09 = abs(angleclamp360(param_00.var_1D[var_08]) - angleclamp360(var_04.var_1D[var_08])) > 0.01;
				if(var_09)
				{
					var_07 = 0.5 * anglesdelta(param_00.var_1D,var_04.var_1D);
					break;
				}
			}
		}

		if(!var_05 && var_07)
		{
			var_05 = var_07 / var_02;
		}

		if(var_06 > 0)
		{
			param_00 moveto(var_04.var_116,var_05);
		}

		if(var_07 > 0)
		{
			param_00 rotateto(var_04.var_1D,var_05);
		}

		if(var_05 > 0)
		{
			wait(var_05);
		}

		var_03++;
		var_03 = var_03 % param_00.var_64AD.size;
	}
}

//Function Number: 37
func_9CAD(param_00)
{
	var_01 = undefined;
	for(;;)
	{
		self waittill("trap_state_change",var_02);
		switch(var_02)
		{
			case "no_power":
				if(isdefined(var_01))
				{
					var_01 delete();
				}
				break;
	
			case "deactivate":
				if(isdefined(var_01))
				{
					var_01 delete();
				}
				break;
	
			case "ready":
				if(isdefined(var_01))
				{
					var_01 delete();
				}
		
				var_01 = spawnfx(common_scripts\utility::func_44F5("trap_ready"),param_00.var_116);
				triggerfx(var_01);
				break;
	
			case "active":
				if(isdefined(var_01))
				{
					var_01 delete();
				}
		
				var_01 = spawnfx(common_scripts\utility::func_44F5("trap_not_ready"),param_00.var_116);
				triggerfx(var_01);
				break;
	
			default:
				break;
		}
	}
}

//Function Number: 38
func_9CA0(param_00,param_01,param_02)
{
	if(!isdefined(param_02))
	{
		param_02 = "default";
	}

	for(;;)
	{
		self waittill("active");
		func_9CA2(param_00,param_01,param_02);
	}
}

//Function Number: 39
func_9CA2(param_00,param_01,param_02)
{
	self endon("cooldown");
	self endon("no_power");
	self endon("ready");
	self endon("deactivate");
	var_03 = 1;
	var_04 = 5;
	if(param_02 == "fx_trap_move")
	{
		var_04 = 3;
	}

	var_05 = var_04 / var_03;
	if(isdefined(param_00.var_8140))
	{
		var_05 = var_05 * param_00.var_8140;
	}

	var_06 = 50;
	if(isdefined(param_00.var_8140))
	{
		var_06 = var_06 / param_00.var_8140;
	}

	var_07 = gettime();
	var_08 = "trap_zm_mp";
	if(isdefined(level.var_AB26))
	{
		var_08 = self [[ level.var_AB26 ]](param_00,param_01,param_02);
	}

	for(;;)
	{
		param_00 waittill("trigger",var_09);
		var_0A = (var_09.var_116[0],var_09.var_116[1],param_00.var_116[2]);
		if(isplayer(var_09))
		{
			if(isdefined(param_00.var_8260) && param_00.var_8260 == "no_player_damage")
			{
				continue;
			}

			if(isdefined(var_09.var_66D3) && var_09.var_66D3 > gettime())
			{
				continue;
			}

			if(var_07 + 3000 > gettime())
			{
				continue;
			}

			var_09.var_66D3 = gettime() + 200;
			if(isdefined(level.var_62B5) && isdefined(param_00.var_8140))
			{
				var_09.var_66D3 = gettime() + 200 * param_00.var_8140;
			}

			var_09 dodamage(var_06,var_09.var_116);
			continue;
		}

		if(isdefined(var_09.var_A) && var_09.var_A == level.var_746E)
		{
			if(isdefined(param_00.var_8260) && param_00.var_8260 == "no_player_damage")
			{
				continue;
			}

			if(isdefined(var_09.var_66D3) && var_09.var_66D3 > gettime())
			{
				continue;
			}

			if(var_07 + 3000 > gettime())
			{
				continue;
			}

			var_09.var_66D3 = gettime() + 200;
			var_09 dodamage(var_06 * 0.5,var_09.var_116);
			continue;
		}

		var_0B = func_9CA1(var_09,var_0A);
		if(param_01)
		{
			if(!isdefined(var_09.var_FB))
			{
				continue;
			}

			if(isdefined(var_09.var_66D4) && var_09.var_66D4 > gettime())
			{
				continue;
			}

			var_09.var_66D4 = gettime() + int(1000 / var_04);
			var_0C = "MOD_TRIGGER_HURT";
			if(isdefined(param_00.var_8140))
			{
				var_0C = "MOD_IMPACT";
			}

			var_0D = int(var_09.var_FB / var_05);
			if(var_09 lib_0547::func_580A())
			{
				var_0D = var_0D * 0.1;
			}

			if(lib_0547::func_5565(self.var_165,"trap_rnd"))
			{
				var_09 mark_electrified();
				var_09 dodamage(var_0D,var_0A,level.var_9CC0,level.var_9CC0,var_0C,var_08,var_0B);
			}
			else
			{
				var_09 dodamage(var_0D,var_0A,self.var_117,self.var_117,var_0C,var_08,var_0B);
			}
		}
		else
		{
			var_0D = var_0A.var_BC;
			if(var_09 lib_0547::func_580A())
			{
				var_0D = var_0D * 0.2;
			}

			var_09 thread mark_electrified();
			if(lib_0547::func_5565(self.var_165,"trap_rnd"))
			{
				var_09 dodamage(var_0D,var_0A,level.var_9CC0,level.var_9CC0,"MOD_TRIGGER_HURT",var_08,var_0B);
			}
			else
			{
				var_09 dodamage(var_0D,var_0A,self.var_117,self.var_117,"MOD_TRIGGER_HURT",var_08,var_0B);
			}
		}
	}
}

//Function Number: 40
mark_electrified()
{
	self notify("new_mark_electrified");
	self endon("new_mark_electrified");
	self endon("death");
	self.iselectrified = 1;
	childthread unset_zombie_electrified();
}

//Function Number: 41
unset_zombie_electrified()
{
	wait(5);
	self.iselectrified = 0;
}

//Function Number: 42
func_9CA1(param_00,param_01)
{
	var_02 = param_01[2] - param_00.var_116[2];
	if(var_02 < 32)
	{
		return common_scripts\utility::func_7A33(["right_leg_upper","left_leg_upper"]);
	}

	if(var_02 < 60)
	{
		return common_scripts\utility::func_7A33(["left_arm_upper","right_arm_upper"]);
	}

	return common_scripts\utility::func_7A33(["head","neck"]);
}

//Function Number: 43
func_56E6(param_00)
{
	return isdefined(param_00) && param_00 == "zombie_trap_barrel";
}

//Function Number: 44
func_9CD0(param_00)
{
	var_01 = undefined;
	for(;;)
	{
		self waittill("trap_state_change",var_02);
		if(isdefined(var_01))
		{
			var_01 delete();
		}

		var_03 = param_00.var_8260 + "_" + var_02;
		if(common_scripts\utility::func_3F6F(var_03))
		{
			var_01 = common_scripts\utility::func_44F5(var_03);
		}

		if(isdefined(var_01))
		{
			var_01 = spawnfx(var_01,param_00.var_116,anglestoforward(param_00.var_1D),anglestoup(param_00.var_1D));
			triggerfx(var_01);
		}

		thread func_1365(var_03,var_01,param_00.var_116);
	}
}

//Function Number: 45
func_9CC7(param_00,param_01,param_02,param_03,param_04)
{
	var_05 = common_scripts\utility::func_46B7(param_00,"script_noteworthy");
	foreach(var_07 in var_05)
	{
		if(!isdefined(var_07.var_4DAF))
		{
			var_07.var_4DAF = [];
		}

		if(0)
		{
			var_07.var_4DAF["hint_ready"] = param_01;
			var_07.var_4DAF["hint_cooldown"] = param_02;
		}

		if(1 && isdefined(param_03) || isdefined(param_04))
		{
			var_08 = isdefined(param_03);
			var_09 = isdefined(param_04);
			var_07.var_4DAF["hint_ready_ref"] = 0;
			var_07.var_4DAF["hint_cooldown_ref"] = 0;
			var_0A = function_027A("mp/zombieCustomTrapInteract.csv");
			for(var_0B = 0;var_0B < var_0A;var_0B++)
			{
				var_0C = tablelookupbyrow("mp/zombieCustomTrapInteract.csv",var_0B,1);
				if(var_08 && var_0C == param_03)
				{
					var_07.var_4DAF["hint_ready_ref"] = int(tablelookupbyrow("mp/zombieCustomTrapInteract.csv",var_0B,0));
					var_08 = 0;
				}
				else if(var_09 && var_0C == param_04)
				{
					var_07.var_4DAF["hint_cooldown_ref"] = int(tablelookupbyrow("mp/zombieCustomTrapInteract.csv",var_0B,0));
					var_09 = 0;
				}

				if(!var_08 && !var_09)
				{
					break;
				}
			}
		}
	}
}

//Function Number: 46
func_9CC6(param_00,param_01,param_02)
{
	var_03 = common_scripts\utility::func_46B7(param_00,"script_noteworthy");
	foreach(var_05 in var_03)
	{
		var_05 thread func_9C9F(param_01,param_02);
	}
}

//Function Number: 47
func_9C9F(param_00,param_01)
{
	var_02 = self;
	for(;;)
	{
		var_02 waittill("trap_state_change",var_03);
		if(var_03 == param_00)
		{
			thread [[ param_01 ]](var_02);
		}
	}
}

//Function Number: 48
func_9CA4(param_00)
{
	for(;;)
	{
		self waittill("active");
		var_01 = spawn("script_model",param_00.var_116);
		var_01.var_4883 = var_01.var_116;
		var_01.var_1A7 = level.var_746E;
		if(isdefined(param_00.var_8260))
		{
			if(function_030D(param_00.var_8260))
			{
				var_01.var_6081 = squared(int(param_00.var_8260));
			}
		}

		if(isdefined(param_00.var_8140))
		{
			var_01.var_607A = param_00.var_8140;
		}

		var_01.var_5809 = 1;
		var_01.var_A54 = 0;
		level notify("trap_lure_activated",var_01);
		level.var_8C8[level.var_8C8.size] = var_01;
		common_scripts\utility::knock_off_battery("cooldown","no_power","ready","deactivate");
		if(!isdefined(var_01))
		{
			continue;
		}

		level.var_8C8 = common_scripts\utility::func_F93(level.var_8C8,var_01);
		var_01 delete();
	}
}

//Function Number: 49
func_A8EB()
{
	for(;;)
	{
		level waittill("spawned_agent",var_00);
		if(isdefined(var_00.var_A) && isdefined(level.var_746E) && var_00.var_A == level.var_746E)
		{
			continue;
		}

		var_00 thread func_AC6B();
	}
}

//Function Number: 50
func_AC6B()
{
	self endon("death");
	for(;;)
	{
		while(level.var_8C8.size > 0)
		{
			var_00 = undefined;
			foreach(var_02 in level.var_8C8)
			{
				if(!func_21CB(var_02))
				{
					continue;
				}

				var_03 = distance2dsquared(var_02.var_116,self.var_116);
				if(isdefined(var_02.var_6081))
				{
					var_04 = var_02.var_6081;
				}
				else
				{
					var_04 = 2250000;
				}

				if(var_03 < var_04)
				{
					var_00 = var_02;
					break;
				}
			}

			if(isdefined(var_00))
			{
				self.var_3043 = var_00;
				self.var_3044 = 0;
				if(isdefined(var_00.var_A54))
				{
					var_00.var_A54++;
					thread func_5F51(var_00);
				}

				var_00 common_scripts\utility::knock_off_battery("death","stop");
				self.var_3043 = undefined;
				waittillframeend;
				continue;
			}

			self.var_3043 = undefined;
			wait 0.05;
		}

		level waittill("trap_lure_activated");
	}
}

//Function Number: 51
func_5F51(param_00)
{
	self waittill("death");
	if(isdefined(param_00))
	{
		param_00.var_A54--;
	}
}

//Function Number: 52
func_21CB(param_00)
{
	if(!isdefined(param_00.var_5809) || !param_00.var_5809)
	{
		return 1;
	}

	var_01 = 4;
	if(isdefined(param_00.var_607A))
	{
		var_01 = param_00.var_607A;
	}

	if(param_00.var_A54 > var_01)
	{
		return 0;
	}

	if(lib_0547::func_580A())
	{
		return 0;
	}

	return 1;
}

//Function Number: 53
func_1365(param_00,param_01,param_02)
{
	var_03 = param_00;
	if(isdefined(var_03) && function_0344(var_03))
	{
		if(isdefined(param_01))
		{
			maps\mp\_audio::func_8DA2(var_03,param_01);
		}
		else
		{
			maps\mp\_audio::func_8DA0(var_03,param_02);
		}
	}

	var_04 = param_00 + "_lp";
	if(isdefined(var_04) && function_0344(var_04))
	{
		if(isdefined(param_01))
		{
			maps\mp\_audio::func_8DA4(var_04,param_01,0.25);
		}
	}
}

//Function Number: 54
func_9CEC()
{
	level endon("game_ended");
	for(;;)
	{
		level waittill("connected",var_00);
		var_00 thread func_7382();
	}
}

//Function Number: 55
func_7382()
{
	self endon("disconnect");
	thread func_7383();
	for(;;)
	{
		if(self.var_5B66 < gettime())
		{
			self.var_5B45 = self.var_116;
		}

		wait 0.05;
	}
}

//Function Number: 56
func_7383()
{
	self.var_5B66 = 0;
	for(;;)
	{
		self waittill("unresolved_collision");
		self.var_5B66 = gettime();
	}
}

//Function Number: 57
func_9CD7(param_00)
{
	if(!isdefined(level.var_AC79))
	{
		precachempanim("zombie_ark_zomboni_trap");
		level.var_AC79 = 1;
		createthreatbiasgroup("zomboni");
		level.var_611["chompy_churn"] = loadfx("vfx/gameplay/mp/zombie/dlc_chompy_churn");
		level.var_611["chompy_lights"] = loadfx("vfx/gameplay/mp/zombie/dlc_chompy_lights");
		level thread func_9CEC();
	}

	self.var_9C96 = "zomboni_done";
	var_01 = spawn("script_model",param_00.var_116);
	var_01 setmodel("vehicle_ind_zomboni_ai");
	var_01.var_1D = param_00.var_1D;
	var_01.var_5D96 = 1;
	var_01 makeentitysentient(level.var_746E);
	var_01 setthreatbiasgroup("zomboni");
	var_01.var_116C = [];
	var_02 = 40;
	var_03 = 150;
	var_04 = 45;
	var_05 = [["tag_zom_attach_1","left"],["tag_zom_attach_2","right"],["tag_zom_attach_3","rear"]];
	foreach(var_0C, var_07 in var_05)
	{
		var_08 = var_07[0];
		var_09 = var_07[1];
		var_0A = var_01 gettagorigin(var_08);
		var_0B = spawn("script_model",var_0A);
		var_0B.var_1D = var_01 gettagangles(var_08);
		var_0B setmodel("tag_origin");
		var_0B linkto(var_01,var_08);
		var_0B.var_4836 = var_02;
		var_0B.var_5983 = var_03;
		var_0B.var_1173 = var_04;
		var_0B.var_116E = var_09;
		var_0B.var_E18 = var_0C;
		var_01.var_116C[var_01.var_116C.size] = var_0B;
		thread func_9CDB(var_0B);
	}

	var_01.var_5869 = 1;
	var_0D = getentarray(param_00.var_1A2,"targetname");
	var_0E = common_scripts\utility::func_46B7(param_00.var_1A2,"targetname");
	var_0F = common_scripts\utility::func_F73(var_0D,var_0E);
	var_01.var_3290 = [];
	foreach(var_11 in var_0F)
	{
		if(!isdefined(var_11.var_165))
		{
			continue;
		}

		switch(var_11.var_165)
		{
			case "clip":
				var_11.var_A045 = ::istrue;
				var_11.var_AC77 = var_01;
				var_01.var_241F = var_11;
				var_11 linkto(var_01);
				break;

			case "kill_trigger":
				var_11 enablelinkto();
				var_11 linkto(var_01);
				var_01.var_5A81 = var_11;
				break;

			case "door":
				var_11.var_2438 = var_11.var_116;
				var_11.var_6BED = var_11.var_2438 + (0,0,60);
				var_01.var_3290[var_01.var_3290.size] = var_11;
				break;

			default:
				break;
		}
	}

	while(!threatbiasgroupexists("zombies"))
	{
		wait 0.05;
	}

	for(;;)
	{
		setignoremegroup("zomboni","zombies");
		self waittill("active");
		var_01.var_57E4 = 0;
		playfxontag(common_scripts\utility::func_44F5("chompy_lights"),var_01,"tag_body");
		var_01 method_8495("zombie_ark_zomboni_trap",param_00.var_116,param_00.var_1D,"zomboni_anim");
		thread func_9CE4(var_01);
		thread func_9CF4(var_01);
		setthreatbias("zomboni","zombies",2000);
		thread func_9CE3(var_01);
		var_01 waittill("end");
		self notify("zomboni_done");
		killfxontag(common_scripts\utility::func_44F5("chompy_lights"),var_01,"tag_body");
		var_01 scriptmodelclearanim();
		var_01.var_116 = param_00.var_116;
		var_01.var_1D = param_00.var_1D;
	}
}

//Function Number: 58
func_9CEA(param_00)
{
	self endon("zomboni_done");
	for(;;)
	{
		var_01 = func_9CE0(param_00);
		foreach(var_03 in var_01)
		{
		}

		wait 0.05;
	}
}

//Function Number: 59
func_9CE0(param_00,param_01)
{
	var_02 = [];
	var_03 = [(-16,16,56),(0,16,56),(18,16,56),(-16,-22,56),(0,-22,56),(18,-22,56),(-16,-60,56),(0,-60,56),(18,-60,56)];
	var_04 = getent("zomboni_room_volume","targetname");
	var_05 = param_00 gettagorigin("body_animate_jnt");
	var_05 = (var_05[0],var_05[1],param_00.var_116[2]);
	foreach(var_07 in var_03)
	{
		var_08 = spawnstruct();
		var_08.var_116 = var_05 + rotatevector(var_07,param_00.var_1D + (0,-90,0));
		if(!isdefined(var_04) || !ispointinvolume(var_08.var_116,var_04))
		{
			var_02[var_02.size] = var_08;
		}
	}

	var_0A = getnodesinradius(var_05,200,0,100);
	var_0B = anglestoforward(param_00.var_1D);
	foreach(var_0D in var_0A)
	{
		var_0E = vectornormalize(var_0D.var_116 - var_05);
		if(vectordot(var_0B,var_0E) < 0)
		{
			var_02[var_02.size] = var_0D;
		}
	}

	if(isdefined(param_01))
	{
		var_08 = spawnstruct();
		var_08.var_116 = param_01.var_5B45;
		var_02[var_02.size] = var_08;
	}

	return var_02;
}

//Function Number: 60
istrue(param_00)
{
	self.var_A048 = func_9CE0(self.var_AC77,param_00);
	maps\mp\_movers::func_A047(param_00,0);
}

//Function Number: 61
func_9CDB(param_00)
{
	level.var_9CDB = 0;
	for(;;)
	{
		wait 0.05;
		if(!common_scripts\utility::func_562E(level.var_9CDB))
		{
			continue;
		}

		var_01 = param_00.var_1180;
		var_02 = (1,1,0);
		var_03 = (1,1,1);
		if(isdefined(var_01))
		{
			var_02 = (1,0,0);
			var_03 = (1,0,0);
		}

		maps/mp/bots/_bots_util::func_19B8(param_00.var_116,param_00.var_4836,var_02,0,16);
		maps/mp/bots/_bots_util::func_19B8(param_00.var_116,param_00.var_5983,var_03,0,16);
	}
}

//Function Number: 62
func_9CEB(param_00)
{
	self endon("zomboni_done");
	if(!isdefined(param_00.var_241F))
	{
		return;
	}

	for(;;)
	{
		var_01 = 0;
		foreach(var_03 in level.var_744A)
		{
			var_04 = var_03 method_8551();
			if(isdefined(var_04) && var_04 == param_00.var_241F)
			{
				var_01 = 1;
				break;
			}
		}

		if(var_01 && !param_00.var_57E4)
		{
			param_00 scriptmodelpauseanim(1);
			param_00.var_57E4 = 1;
		}
		else if(!var_01 && param_00.var_57E4)
		{
			param_00 scriptmodelpauseanim(0);
			param_00.var_57E4 = 0;
		}

		wait 0.05;
	}
}

//Function Number: 63
func_9CE1(param_00)
{
	foreach(var_02 in level.var_744A)
	{
		if(func_9CE2(var_02,param_00))
		{
			return 1;
		}
	}

	return 0;
}

//Function Number: 64
func_9CE2(param_00,param_01)
{
	var_02 = param_00 method_8551();
	if(!isdefined(var_02))
	{
		return 0;
	}

	return var_02 == param_01.var_241F;
}

//Function Number: 65
func_9CF4(param_00)
{
	self endon("zomboni_done");
	param_00.var_5985 = 0;
	foreach(var_02 in param_00.var_116C)
	{
		var_02.var_1180 = undefined;
		var_02.var_66D2 = 0;
	}

	for(;;)
	{
		wait 0.05;
		if(!param_00.var_5985)
		{
			continue;
		}

		foreach(var_05 in function_02D1())
		{
			if(isdefined(var_05.var_66D8) && var_05.var_66D8 > gettime())
			{
				continue;
			}

			var_05.var_66D8 = gettime() + randomintrange(1,5) * 50;
			if(!isalive(var_05))
			{
				continue;
			}

			if(isplayer(var_05))
			{
				continue;
			}

			if(!var_05 lib_0547::func_4B2C())
			{
				continue;
			}

			if(!function_02BF(var_05) || var_05.var_A4B == "zombie_dog")
			{
				continue;
			}

			if(var_05 lib_0547::func_580A())
			{
				continue;
			}

			if(var_05 maps/mp/agents/_scripted_agent_anim_util::func_57E2())
			{
				continue;
			}

			if(!isdefined(var_05.var_88))
			{
				continue;
			}

			if(var_05.var_88 != param_00)
			{
				if(!isplayer(var_05.var_88))
				{
					continue;
				}

				if(!func_9CE2(var_05.var_88,param_00))
				{
					continue;
				}
			}

			var_06 = undefined;
			var_07 = undefined;
			foreach(var_02 in param_00.var_116C)
			{
				if(isdefined(var_02.var_1180))
				{
					continue;
				}

				if(var_02.var_66D2 > gettime())
				{
					continue;
				}

				var_09 = anglestoforward(var_02.var_1D);
				var_0A = var_02.var_5983 * var_02.var_5983;
				var_0B = anglestoforward(var_05.var_1D);
				if(vectordot(var_0B,var_09) < 0.1)
				{
					continue;
				}

				var_0C = vectornormalize(param_00.var_116 - var_05.var_116);
				if(vectordot(var_0C,var_0B) < 0.1)
				{
					continue;
				}

				var_0D = distancesquared(var_02.var_116,var_05.var_116);
				if(var_0D < var_0A)
				{
					if(!isdefined(var_06) || var_0D < var_07)
					{
						var_06 = var_02;
						var_07 = var_0D;
					}
				}
			}

			if(isdefined(var_06))
			{
				thread func_9CEF(param_00,var_05,var_06);
			}
		}
	}
}

//Function Number: 66
func_9CDA(param_00,param_01,param_02)
{
	param_01.var_1180 = param_02;
	common_scripts\utility::func_A70C(self,"zomboni_done",param_02,"death");
	param_01.var_66D2 = gettime() + randomintrange(1000,3000);
	param_01.var_1180 = undefined;
}

//Function Number: 67
func_9CEF(param_00,param_01,param_02)
{
	param_01 endon("death");
	thread func_9CDA(param_00,param_02,param_01);
	param_01 scragentsetscripted(1);
	param_01 maps/mp/agents/_scripted_agent_anim_util::func_8732(1,"AttackZomboni");
	param_01 method_839D("noclip");
	func_9CF0(param_00,param_01,param_02);
	param_01 scragentsetscripted(0);
	param_01 maps/mp/agents/_scripted_agent_anim_util::func_8732(0,"AttackZomboni");
}

//Function Number: 68
func_9CF0(param_00,param_01,param_02)
{
	self endon("zomboni_done");
	param_01.var_AC77 = param_00;
	param_01.var_1167 = param_02;
	var_03 = "zomboni_attack_get_on";
	var_04 = 0.67;
	var_05 = distance(param_01.var_116,param_02.var_116);
	if(var_05 > param_02.var_4836)
	{
		var_03 = "zomboni_attack_leap_on";
	}

	var_06 = param_02.var_E18;
	param_01 method_839A(0,1);
	param_01 method_855A(var_04,var_04,param_02,"tag_origin");
	param_01 maps/mp/agents/_scripted_agent_anim_util::func_71FA(var_03,var_06,1,"scripted_anim");
	param_01 method_839A(1,1);
	for(;;)
	{
		var_03 = "zomboni_attack_zomboni";
		if(func_9CE1(param_00))
		{
			var_03 = "zomboni_attack_player";
		}

		var_06 = param_02.var_E18;
		param_01 maps/mp/agents/_scripted_agent_anim_util::func_71FA(var_03,var_06,1,"scripted_anim",undefined,::func_9CF1);
		var_03 = "zomboni_attack_idle";
		var_06 = param_02.var_E18;
		param_01 maps/mp/agents/_scripted_agent_anim_util::func_8415(var_03,var_06,1);
		wait(randomfloatrange(1,2.5));
	}
}

//Function Number: 69
func_9CF1(param_00,param_01,param_02,param_03)
{
	switch(param_00)
	{
		case "hit":
			var_04 = [];
			foreach(var_06 in level.var_744A)
			{
				var_07 = var_06 method_8551();
				if(isdefined(var_07) && var_07 == self.var_AC77.var_241F)
				{
					var_08 = distance2d(self.var_1167.var_116,var_06.var_116);
					if(var_08 < self.var_1167.var_1173)
					{
						var_04[var_04.size] = var_06;
					}
				}
			}
	
			foreach(var_06 in var_04)
			{
				self notify("attack_hit",var_06,var_06.var_116);
				var_0B = 0;
				if(isdefined(self.var_60E2))
				{
					var_0B = self.var_60E2;
				}
	
				if(isalive(var_06))
				{
					maps/mp/agents/humanoid/_humanoid_melee::func_3210(var_06,var_0B,"MOD_IMPACT");
				}
			}
			break;

		default:
			break;
	}
}

//Function Number: 70
func_9CE4(param_00)
{
	self endon("zomboni_done");
	for(;;)
	{
		param_00 waittill("zomboni_anim",var_01);
		switch(var_01)
		{
			case "door_open":
				foreach(var_03 in param_00.var_3290)
				{
					func_9CDF(var_03,1);
				}
				break;
	
			case "door_close":
				foreach(var_03 in param_00.var_3290)
				{
					func_9CDE(var_03,1);
				}
				break;
	
			case "tag_hood_left":
				self notify("tag_hood_left");
				break;
	
			case "end":
				param_00 notify("end");
				break;
	
			case "enable_jumpon":
				param_00.var_5985 = 1;
				foreach(var_08 in param_00.var_116C)
				{
					var_08.var_66D2 = gettime() + randomintrange(0,2000);
				}
				break;
	
			case "disable_jumpon":
				param_00.var_5985 = 0;
				break;
	
			case "damage_rear":
			case "damage_left":
			case "damage_right":
			case "damage_sides":
				thread func_9CDC(param_00,var_01);
				break;
	
			default:
				break;
		}
	}
}

//Function Number: 71
func_9CDC(param_00,param_01)
{
	var_02 = [];
	var_02["damage_left"] = ["left"];
	var_02["damage_right"] = ["right"];
	var_02["damage_rear"] = ["rear"];
	var_02["damage_sides"] = ["left","right"];
	var_03 = var_02[param_01];
	foreach(var_05 in var_03)
	{
		foreach(var_07 in param_00.var_116C)
		{
			if(isdefined(var_07.var_1180) && var_07.var_116E == var_05)
			{
				var_08 = var_07.var_1180;
				var_08 dodamage(var_08.var_BC,var_08.var_116,self.var_117,param_00,"MOD_TRIGGER_HURT","trap_zm_mp");
			}
		}
	}
}

//Function Number: 72
func_9CD9(param_00)
{
	self endon("zomboni_done");
	self endon("tag_hood_left");
	wait(2);
	for(;;)
	{
		var_01 = param_00 gettagorigin("tag_hood");
		thread func_9CD8(var_01,7);
		wait(3);
	}
}

//Function Number: 73
func_9CD8(param_00,param_01)
{
	var_02 = spawnstruct();
	var_02.var_116 = param_00;
	var_02.var_4883 = param_00;
	var_02.var_1A7 = level.var_746E;
	var_02.var_6081 = 640000;
	var_02.var_607A = 6;
	var_02.var_5809 = 1;
	var_02.var_A54 = 0;
	var_02.var_8BE = 1;
	level notify("distraction_drone_activated",var_02);
	level.var_AAF4[level.var_AAF4.size] = var_02;
	wait(param_01);
	level.var_AAF4 = common_scripts\utility::func_F93(level.var_AAF4,var_02);
	var_02.var_8BE = 0;
	var_02 notify("stop");
}

//Function Number: 74
func_9CDF(param_00,param_01)
{
	param_00 moveto(param_00.var_6BED,param_01);
}

//Function Number: 75
func_9CDE(param_00,param_01)
{
	param_00 moveto(param_00.var_2438,param_01);
}

//Function Number: 76
func_9CE3(param_00)
{
	self endon("zomboni_done");
	for(;;)
	{
		param_00.var_5A81 waittill("trigger",var_01);
		if(!isalive(var_01))
		{
			continue;
		}

		if(var_01 lib_0547::func_580A())
		{
			continue;
		}

		if(isdefined(var_01.var_66D3) && var_01.var_66D3 > gettime())
		{
			continue;
		}

		if(param_00.var_57E4)
		{
			continue;
		}

		var_01.var_66D3 = gettime() + 200;
		if(isplayer(var_01))
		{
			var_01 dodamage(10,var_01.var_116,undefined,param_00);
			continue;
		}

		thread func_9CE8(param_00);
		if(!function_02BF(var_01) || var_01.var_A4B == "zombie_dog")
		{
			var_01 dodamage(var_01.var_BC,var_01.var_116,self.var_117,param_00,"MOD_TRIGGER_HURT","trap_zm_mp");
			continue;
		}

		func_9CED(param_00,var_01);
	}
}

//Function Number: 77
func_9CE8(param_00)
{
	param_00 notify("play_churn_fx");
	param_00 endon("play_churn_fx");
	if(!common_scripts\utility::func_562E(param_00.var_22DE))
	{
		playfxontag(common_scripts\utility::func_44F5("chompy_churn"),param_00,"tag_body");
	}

	param_00.var_22DE = 1;
	wait(5);
	param_00.var_22DE = 0;
	stopfxontag(common_scripts\utility::func_44F5("chompy_churn"),param_00,"tag_body");
}

//Function Number: 78
func_9CED(param_00,param_01)
{
	if(common_scripts\utility::func_562E(param_01.var_AC78))
	{
		return 1;
	}

	if(param_01 maps/mp/agents/_scripted_agent_anim_util::func_57E2())
	{
		return 0;
	}

	thread func_9CF2(param_00,param_01);
	return 1;
}

//Function Number: 79
func_9CF2(param_00,param_01)
{
	param_01 notify("killanimscript");
	param_01.var_AC78 = 1;
	param_01 method_839C("anim deltas");
	param_01 method_839A(1,1);
	param_01 method_839D("noclip");
	var_02 = angleclamp180(param_00.var_1D[1] - param_01.var_1D[1]);
	var_03 = "zomboni_trap_victim";
	var_04 = param_01 method_83DB(var_03);
	var_05 = 0;
	if(abs(var_02) < 45)
	{
		var_05 = 3;
		if(var_04 > 3 && common_scripts\utility::func_24A6())
		{
			var_05 = 4;
		}
	}
	else if(var_02 < 135)
	{
		var_05 = 2;
	}
	else if(var_02 > -135)
	{
		var_05 = 1;
	}

	var_06 = undefined;
	var_07 = undefined;
	var_08 = ["tag_zom_align_center","tag_zom_align_right","tag_zom_align_left"];
	foreach(var_0A in var_08)
	{
		var_0B = param_00 gettagorigin(var_0A);
		var_0C = distance2d(var_0B,param_01.var_116);
		if(!isdefined(var_06) || var_0C < var_07)
		{
			var_06 = var_0A;
			var_07 = var_0C;
		}
	}

	param_01.var_480F = 1;
	param_01 scragentsetscripted(1);
	param_01 maps/mp/agents/_scripted_agent_anim_util::func_8732(1,"SynchronizedAnim");
	param_01 method_839D("noclip");
	param_01 method_855A(0.5,0.5,param_00,var_06);
	param_01 maps/mp/agents/_scripted_agent_anim_util::func_71FA(var_03,var_05,1,"scripted_anim",undefined,::func_9CF3);
	param_01.var_480F = 0;
	param_01.var_1DEB = 1;
	param_01 dodamage(param_01.var_BC,param_01.var_116,self.var_117,param_00,"MOD_TRIGGER_HURT","trap_zm_mp");
}

//Function Number: 80
func_9CF3(param_00,param_01,param_02,param_03)
{
	switch(param_00)
	{
		case "remove_head":
			var_04 = lib_0541::func_5E60("head");
			lib_0541::func_65D0(self.var_6250 | var_04,1,1,(0,0,1),0);
			break;

		case "remove_arms":
			var_05 = lib_0541::func_5E60("right_arm_lower");
			var_06 = lib_0541::func_5E60("left_arm_lower");
			var_07 = common_scripts\utility::func_7A33([var_05,var_06,var_05 | var_06]);
			lib_0541::func_65D0(self.var_6250 | var_07,1,1,(0,0,1),0);
			break;

		case "remove_legs":
			var_08 = lib_0541::func_5E60("right_leg_lower");
			var_09 = lib_0541::func_5E60("left_leg_lower");
			var_0A = common_scripts\utility::func_7A33([var_08,var_09,var_08 | var_09]);
			lib_0541::func_65D0(self.var_6250 | var_0A,1,1,(0,0,1),0);
			break;

		default:
			break;
	}
}

//Function Number: 81
func_9CE9(param_00,param_01)
{
	param_00.var_6ECB = [];
	param_00.var_6801 = [];
	var_02 = param_01.var_116;
	var_03 = 0;
	var_04 = undefined;
	var_05 = 0;
	var_06 = undefined;
	while(isdefined(param_01))
	{
		var_07 = func_9CE5(param_01);
		foreach(var_09 in var_07)
		{
			if(!isdefined(var_09.var_165))
			{
				continue;
			}

			switch(var_09.var_165)
			{
				case "door":
					var_09.var_2438 = var_09.var_116;
					var_09.var_6BED = var_09.var_2438 + (0,0,60);
					break;

				case "distraction":
					var_09.var_8BE = 0;
					break;

				default:
					break;
			}
		}

		var_0B = param_00 getattachpos(param_01)[0];
		if((!isdefined(var_04) || distance(var_04.var_116,var_0B) > 400) && distance(var_02,var_0B) > 300)
		{
			param_01.var_3042 = spawnstruct();
			param_01.var_3042.var_116 = var_0B;
			var_04 = param_01.var_3042;
		}

		if(isdefined(var_06))
		{
			var_05 = var_05 + distance(param_01.var_116,var_06.var_116);
		}

		param_01.var_6ED9 = var_05;
		param_00.var_6ECB[param_00.var_6ECB.size] = param_01;
		if(isdefined(param_01.var_165))
		{
			param_01.var_6764 = strtok(param_01.var_165,",");
			param_00.var_6801[param_00.var_6801.size] = param_01;
			foreach(var_0D in param_01.var_6764)
			{
				switch(var_0D)
				{
					case "door_close":
						var_03 = !var_03;
						break;

					default:
						break;
				}
			}
		}

		if(isdefined(param_01.var_1A2))
		{
			var_06 = param_01;
			param_01 = getvehiclenode(param_01.var_1A2,"targetname");
			continue;
		}

		break;
	}

	param_00.var_6ED9 = var_05;
}

//Function Number: 82
func_9CE6(param_00,param_01)
{
	self endon("zomboni_done");
	param_01 waittill("trigger");
	param_01 notify("passed",param_00);
	param_00 notify("passed_node",param_01);
	param_01.var_6EAA = 1;
}

//Function Number: 83
func_9CE7(param_00,param_01)
{
	self endon("zomboni_done");
	for(;;)
	{
		param_01 waittill("trigger");
		foreach(var_03 in param_01.var_6764)
		{
			switch(var_03)
			{
				case "door_open":
					var_04 = 1;
					param_00 func_AC7B();
					var_05 = func_9CE5(param_01,"door");
					foreach(var_07 in var_05)
					{
						thread func_9CDF(var_07,var_04);
					}
		
					wait(var_04);
					param_00 func_AC7A();
					break;
	
				case "door_close":
					var_09 = 1;
					var_05 = func_9CE5(param_01,"door");
					foreach(var_07 in var_05)
					{
						thread func_9CDE(var_07,var_09);
					}
					break;
	
				case "end":
					param_00 notify("end");
					break;
	
				default:
					break;
			}
		}
	}
}

//Function Number: 84
func_9CDD(param_00,param_01)
{
	var_02 = 2000;
	if(param_00.var_6ED9 > var_02)
	{
		for(;;)
		{
			param_01 waittill("passed_node",var_03);
			if(param_00.var_6ED9 - var_03.var_6ED9 < var_02)
			{
				break;
			}
		}
	}

	self.var_4883 = self.var_116;
	self.var_1A7 = level.var_746E;
	self.var_6081 = 640000;
	self.var_607A = 6;
	self.var_5809 = 1;
	self.var_A54 = 0;
	self.var_8BE = 1;
	level notify("distraction_drone_activated",self);
	level.var_AAF4[level.var_AAF4.size] = self;
	param_00 waittill("passed");
	level.var_AAF4 = common_scripts\utility::func_F93(level.var_AAF4,self);
	self.var_8BE = 0;
	self notify("stop");
}

//Function Number: 85
func_9CE5(param_00,param_01)
{
	var_02 = [];
	if(isdefined(param_00.var_81EF))
	{
		var_03 = strtok(param_00.var_81EF," ");
		for(var_04 = 0;var_04 < var_03.size;var_04++)
		{
			var_05 = getent(var_03[var_04],"script_linkname");
			if(isdefined(var_05))
			{
				if(!isdefined(param_01) || isdefined(var_05.var_165) && var_05.var_165 == param_01)
				{
					var_02[var_02.size] = var_05;
				}
			}
		}
	}

	return var_02;
}

//Function Number: 86
func_AC7B()
{
	self method_8280(0,100,100);
}

//Function Number: 87
func_AC7A()
{
	self method_8293(100);
}

//Function Number: 88
func_0904(param_00)
{
	if(!isdefined(level.var_6667))
	{
		level.var_6667 = [];
	}

	level.var_6667 common_scripts\utility::func_972(level.var_6667,param_00);
}