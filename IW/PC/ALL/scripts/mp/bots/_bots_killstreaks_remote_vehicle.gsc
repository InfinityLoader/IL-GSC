/*******************************************************************
 * Decompiled By: Bog
 * Decompiled File: scripts\mp\bots\_bots_killstreaks_remote_vehicle.gsc
 * Game: Call of Duty: Infinite Warfare
 * Platform: PC
 * Function Count: 81
 * Decompile Time: 3666 ms
 * Timestamp: 10/27/2023 12:27:37 AM
*******************************************************************/

//Function Number: 1
func_DF76()
{
	while(!isdefined(level.var_2EC5))
	{
		wait(0.05);
	}

	if(isdefined(level.var_2DD0))
	{
		return;
	}

	level.var_2DFA["heli_pilot"] = (0,0,350);
	level.var_2DFA["heli_sniper"] = (0,0,228);
	level.var_2DF9["isUsing"]["odin_assault"] = ::scripts\mp\_utility::func_9FC6;
	level.var_2DF9["isUsing"]["odin_support"] = ::scripts\mp\_utility::func_9FC6;
	level.var_2DF9["isUsing"]["heli_pilot"] = ::scripts\mp\_utility::func_9FC6;
	level.var_2DF9["isUsing"]["heli_sniper"] = ::func_9FC3;
	level.var_2DF9["isUsing"]["switchblade_cluster"] = ::scripts\mp\_utility::func_9FC6;
	level.var_2DF9["isUsing"]["vanguard"] = ::func_9FCC;
	level.var_2DF9["waittill_initial_goal"]["heli_pilot"] = ::func_8D80;
	level.var_2DF9["waittill_initial_goal"]["heli_sniper"] = ::func_8D89;
	level.var_2DF9["control_aiming"]["heli_pilot"] = ::func_8D7B;
	level.var_2DF9["control_aiming"]["heli_sniper"] = ::scripts\common\utility::func_61B9;
	level.var_2DF9["control_aiming"]["vanguard"] = ::func_1315E;
	level.var_2DF9["control_other"]["heli_pilot"] = ::func_8D7E;
	level.var_2DF9["heli_pick_node"]["heli_pilot"] = ::func_8D7F;
	level.var_2DF9["heli_pick_node"]["heli_sniper"] = ::func_8D88;
	level.var_2DF9["heli_pick_node"]["vanguard"] = ::func_13172;
	level.var_2DF9["heli_node_get_origin"]["heli_pilot"] = ::func_8D58;
	level.var_2DF9["heli_node_get_origin"]["heli_sniper"] = ::func_8D58;
	level.var_2DF9["heli_node_get_origin"]["vanguard"] = ::func_13163;
	level.var_2DF9["odin_perform_action"]["odin_assault"] = ::func_C2D8;
	level.var_2DF9["odin_perform_action"]["odin_support"] = ::func_C316;
	level.var_2DF9["odin_get_target"]["odin_assault"] = ::func_C2D7;
	level.var_2DF9["odin_get_target"]["odin_support"] = ::func_C315;
	var_00 = scripts\common\utility::getstructarray("so_chopper_boss_path_struct","script_noteworthy");
	level.var_2DC8 = [];
	foreach(var_02 in var_00)
	{
		if(isdefined(var_02.var_27C))
		{
			level.var_2DC8 = scripts\common\utility::array_add(level.var_2DC8,var_02);
		}
	}

	level.var_2DC9 = scripts\mp\_utility::func_7EFA();
	foreach(var_05 in level.var_2DC8)
	{
		var_05.var_13171 = var_05.origin;
		var_06 = var_05.origin + (0,0,50);
		var_05.var_13130 = 1;
		if(var_06[2] <= var_05.origin[2] - 1000)
		{
			var_05.var_13130 = 0;
		}

		var_06 = var_06 - (0,0,50);
		var_05.var_13171 = var_06;
	}

	var_08 = -99999999;
	foreach(var_05 in level.var_2DC8)
	{
		var_08 = max(var_08,var_05.origin[2]);
	}

	level.var_2EC4 = var_08 - level.var_2E1D + 100;
	level.var_C2F9 = function_00E7("odin_projectile_large_rod_mp");
	level.var_C30F = function_00E7("odin_projectile_small_rod_mp");
	level.var_13168 = function_00E7("remote_tank_projectile_mp");
	level.var_8D7D = getdvarfloat("bg_bulletExplRadius");
	while(!isdefined(level.var_C2FF) || !isdefined(level.var_C300))
	{
		wait(0.05);
	}

	level.var_C2E9 = level.var_C2FF + level.var_C300 / 2;
	level.var_C7E0 = [];
	if(isdefined(level.var_1165D))
	{
		var_0B = [[ level.var_1165D ]]();
	}
	else
	{
		var_0B = [];
		for(var_0C = 0;var_0C < level.var_13FBD;var_0C++)
		{
			var_0B[var_0B.size] = var_0C;
		}
	}

	foreach(var_0E in var_0B)
	{
		if(function_0029(var_0E) < 0.25)
		{
			level.var_C7E0 = scripts\common\utility::array_add(level.var_C7E0,var_0E);
		}
	}

	level.var_2E35["recruit"] = 1;
	level.var_2E35["regular"] = 0.7;
	level.var_2E35["hardened"] = 0.4;
	level.var_2E35["veteran"] = 0.05;
	level.var_2DD0 = 1;
}

//Function Number: 2
func_2DF1(param_00,param_01,param_02,param_03,param_04)
{
	if(!isdefined(param_03))
	{
		return 0;
	}

	var_05 = 1;
	var_06 = 1;
	var_07 = undefined;
	if(isdefined(self.var_C02A))
	{
		var_08 = self botgetscriptgoalradius();
		var_09 = distancesquared(self.origin,self.var_C02A.origin);
		if(var_09 < squared(var_08))
		{
			var_05 = 0;
			var_06 = 0;
		}
		else if(var_09 < squared(200))
		{
			var_05 = 0;
		}
	}

	var_0A = param_00.var_110EA == "vanguard" && func_9C23();
	if(var_0A || var_05)
	{
		var_0B = getnodesinradius(self.origin,500,0,512);
		if(isdefined(var_0B) && var_0B.size > 0)
		{
			if(isdefined(param_04) && param_04)
			{
				var_0C = var_0B;
				var_0B = [];
				foreach(var_0E in var_0C)
				{
					if(function_014A(var_0E))
					{
						var_0F = getlinkednodes(var_0E);
						var_10 = 0;
						foreach(var_12 in var_0F)
						{
							if(function_014A(var_12))
							{
								var_10++;
							}
						}

						if(var_10 / var_0F.size > 0.5)
						{
							var_0B = scripts\common\utility::array_add(var_0B,var_0E);
						}
					}
				}
			}

			if(var_0A)
			{
				var_15 = self method_8045(var_0B,"node_exposed");
				foreach(var_0E in var_15)
				{
					if(bullettracepassed(var_0E.origin + (0,0,30),var_0E.origin + (0,0,400),0,self))
					{
						var_07 = var_0E;
						break;
					}

					wait(0.05);
				}
			}
			else if(var_0B.size > 0)
			{
				var_07 = self botnodepick(var_0B,min(3,var_0B.size),"node_hide");
			}

			if(!isdefined(var_07))
			{
				return 0;
			}

			self botsetscriptgoalnode(var_07,"tactical");
		}
	}

	if(var_06)
	{
		var_18 = scripts\mp\bots\_bots_util::func_2ECB();
		if(var_18 != "goal")
		{
			func_1284E(var_07);
			return 1;
		}
	}

	if(isdefined(param_02) && !self [[ param_02 ]]())
	{
		func_1284E(var_07);
		return 0;
	}

	if(!scripts\mp\bots\_bots_util::func_2D0A())
	{
		func_1284E(var_07);
		return 1;
	}

	if(!isdefined(var_07))
	{
		if(self getstance() == "prone")
		{
			self botsetstance("prone");
		}
		else if(self getstance() == "crouch")
		{
			self botsetstance("crouch");
		}
	}
	else if(self botgetdifficultysetting("strategyLevel") > 0)
	{
		if(randomint(100) > 50)
		{
			self botsetstance("prone");
		}
		else
		{
			self botsetstance("crouch");
		}
	}

	scripts\mp\bots\_bots_killstreaks::func_2EA5(param_00,param_01,param_00.var_394);
	self.var_131B5 = undefined;
	self thread [[ param_03 ]]();
	thread func_2D6A();
	thread func_2D6C(var_07);
	self waittill("control_func_done");
	return 1;
}

//Function Number: 3
func_2D6A()
{
	self endon("disconnect");
	self endon("control_func_done");
	level endon("game_ended");
	self waittill("spawned_player");
	self notify("control_func_done");
}

//Function Number: 4
func_2D6C(param_00)
{
	self endon("disconnect");
	self waittill("control_func_done");
	func_1284E(param_00);
	self botsetstance("none");
	self botsetscriptmove(0,0);
	self botsetflag("disable_movement",0);
	self botsetflag("disable_rotation",0);
	self.var_131B5 = undefined;
}

//Function Number: 5
func_1284E(param_00)
{
	if(isdefined(param_00) && self bothasscriptgoal() && isdefined(self botgetscriptgoalnode()) && self botgetscriptgoalnode() == param_00)
	{
		self botclearscriptgoal();
	}
}

//Function Number: 6
func_2D6B(param_00)
{
	param_00 waittill("death");
	self notify("control_func_done");
}

//Function Number: 7
func_2ECD(param_00)
{
	var_01 = gettime();
	while(!self [[ level.var_2DF9["isUsing"][param_00] ]]())
	{
		wait(0.05);
		if(gettime() - var_01 > 5000)
		{
			return 0;
		}
	}

	return 1;
}

//Function Number: 8
func_2D42()
{
	self endon("spawned_player");
	self endon("disconnect");
	self endon("control_func_done");
	level endon("game_ended");
	childthread func_88D4();
	var_00 = func_2ECD("switchblade_cluster");
	if(!var_00)
	{
		self notify("control_func_done");
	}

	thread func_11372();
	var_01 = func_6C83(self);
	wait(0.1);
	self.var_C3F6 = self.maxsightdistsqrd;
	self.maxsightdistsqrd = 256000000;
	thread func_13938();
	var_02 = undefined;
	var_03 = 0;
	var_04 = 0;
	var_05 = [];
	var_06 = undefined;
	var_07 = 0;
	var_08 = 0;
	var_09 = undefined;
	var_0A = undefined;
	var_0B = 0;
	var_0C = func_9C23();
	while(self [[ level.var_2DF9["isUsing"]["switchblade_cluster"] ]]() && isdefined(var_01))
	{
		foreach(var_0E in level.var_E5DE)
		{
			if(isdefined(var_0E) && var_0E.var_222 == self && var_0E.var_13C2E == "switch_blade_child_mp")
			{
				var_0F = 1;
				foreach(var_11 in var_05)
				{
					if(var_11.var_26C == var_0E)
					{
						var_0F = 0;
					}
				}

				if(var_0F)
				{
					var_13 = spawnstruct();
					var_13.var_26C = var_0E;
					var_13.target = var_06;
					var_06 = undefined;
					var_05 = scripts\common\utility::array_add(var_05,var_13);
				}
			}
		}

		for(var_15 = 0;var_15 < var_05.size;var_15++)
		{
			var_11 = var_05[var_15];
			if(isdefined(var_11) && isdefined(var_11.var_26C) && !scripts\common\utility::func_2286(level.var_E5DE,var_11.var_26C))
			{
				var_05[var_15] = var_05[var_05.size - 1];
				var_05[var_05.size - 1] = undefined;
				var_15--;
			}
		}

		if(var_0B)
		{
			wait(0.05);
			continue;
		}

		var_16 = undefined;
		if(isdefined(var_0A))
		{
			var_16 = var_0A;
			if(!isalive(var_0A) || !self botcanseeentity(var_16))
			{
				if(!isalive(var_0A))
				{
					var_0B = 1;
				}

				wait(0.05);
				continue;
			}
		}

		var_17 = [];
		if(!isdefined(var_16))
		{
			var_18 = func_2DEA(0);
			var_19 = [];
			foreach(var_11 in var_05)
			{
				if(isdefined(var_11.target))
				{
					var_19 = scripts\common\utility::array_add(var_19,var_11.target);
				}
			}

			var_18 = scripts\common\utility::func_22AC(var_18,var_19);
			foreach(var_1D in var_18)
			{
				if(var_1D scripts\mp\_utility::_hasperk("specialty_noplayertarget"))
				{
					continue;
				}

				if(self botcanseeentity(var_1D) || var_0C && scripts\common\utility::func_13D90(self geteye(),var_01.angles,var_1D.origin,self botgetfovdot()))
				{
					if(!func_2D16() && distancesquared(var_1D.origin,self.origin) < -25536)
					{
						continue;
					}

					var_17 = scripts\common\utility::array_add(var_17,var_1D);
					if(!isdefined(var_16))
					{
						var_16 = var_1D;
						continue;
					}

					var_1E = vectornormalize(var_16.origin - var_01.origin);
					var_1F = vectornormalize(var_1D.origin - var_01.origin);
					var_20 = anglestoforward(var_01.angles);
					var_21 = vectordot(var_1E,var_20);
					var_22 = vectordot(var_1F,var_20);
					if(var_22 > var_21)
					{
						var_16 = var_1D;
					}
				}
			}
		}

		if(isdefined(var_16))
		{
			var_02 = undefined;
			var_24 = var_01.origin[2] - var_16.origin[2];
			var_25 = self botgetdifficulty();
			if(var_25 == "recruit")
			{
				var_09 = var_16.origin;
			}
			else if(var_24 < 5000)
			{
				var_09 = var_16.origin;
			}
			else if(length(var_16 method_8123()) < 25)
			{
				var_09 = var_16.origin;
			}
			else if(gettime() - var_08 > 500)
			{
				var_08 = gettime();
				var_26 = 3;
				if(var_25 == "regular")
				{
					var_26 = 1;
				}

				var_09 = function_00C3(var_16,var_26);
			}

			var_27 = func_B7FA(var_01,var_09);
			var_28 = func_B7FB(var_01,var_09);
			if(var_28 < 30)
			{
				var_29 = 0;
			}
			else if(var_29 < 100)
			{
				var_29 = 0.15;
			}
			else if(var_29 < 200)
			{
				var_29 = 0.3;
			}
			else if(var_29 < 400)
			{
				var_29 = 0.6;
			}
			else
			{
				var_29 = 1;
			}

			if(var_07)
			{
				var_29 = min(var_29 * 3,1);
			}

			if(var_29 > 0)
			{
				self botsetscriptmove(var_27[1],0.05,var_29,1,1);
			}
			else if(gettime() > var_04)
			{
				if(var_03 < 2)
				{
					self botpressbutton("attack");
					var_03++;
					var_04 = gettime() + 200;
					if((var_25 == "regular" && var_03 == 2) || var_25 == "hardened" || var_25 == "veteran")
					{
						var_2A = var_03 == 1 && var_17.size == 1;
						if(!var_2A)
						{
							var_06 = var_16;
							var_04 = var_04 + 800;
						}
					}
				}
				else if(!var_07 && var_24 < 5000 || var_25 == "recruit")
				{
					var_07 = 1;
					self botpressbutton("attack");
					if(var_25 == "recruit")
					{
						var_0A = var_16;
					}
				}
			}

			continue;
		}

		if(!isdefined(var_02))
		{
			var_02 = scripts\common\utility::random(level.var_C7E0);
		}

		var_2B = getzonenodeforindex(var_02).origin;
		if(func_B7FB(var_01,var_2B) < 200)
		{
			var_02 = scripts\common\utility::random(level.var_C7E0);
			var_2B = getzonenodeforindex(var_02).origin;
		}

		var_27 = func_B7FA(var_01,var_2B);
		self botsetscriptmove(var_27[1],0.05,0.75,1,1);
		wait(0.05);
	}

	self notify("control_func_done");
}

//Function Number: 9
func_B7FA(param_00,param_01)
{
	var_02 = func_B7F6(param_00,param_01[2]);
	var_03 = vectornormalize(param_01 - var_02);
	return vectortoangles(var_03);
}

//Function Number: 10
func_B7FB(param_00,param_01)
{
	var_02 = func_B7F6(param_00,param_01[2]);
	return distance(var_02,param_01);
}

//Function Number: 11
func_88D4()
{
	self botsetflag("disable_rotation",1);
	self botsetflag("disable_movement",1);
	func_6C83(self);
	self botsetflag("disable_rotation",0);
	self botsetflag("disable_movement",0);
}

//Function Number: 12
func_11372()
{
	self endon("disconnect");
	self botgetpathdist(2.5);
	self waittill("control_func_done");
	self botgetpathdist(1);
}

//Function Number: 13
func_B7F6(param_00,param_01)
{
	var_02 = anglestoforward(param_00.angles);
	var_03 = param_01 - param_00.origin[2] / var_02[2];
	var_04 = param_00.origin + var_02 * var_03;
	return var_04;
}

//Function Number: 14
func_13938()
{
	self endon("disconnect");
	self waittill("control_func_done");
	self.maxsightdistsqrd = self.var_C3F6;
}

//Function Number: 15
func_6C83(param_00)
{
	for(;;)
	{
		foreach(var_02 in level.var_E5DE)
		{
			if(isdefined(var_02) && var_02.var_222 == param_00)
			{
				return var_02;
			}
		}

		wait(0.05);
	}
}

//Function Number: 16
func_1315D()
{
	if(!scripts\mp\bots\_bots_killstreaks::func_18DB())
	{
		return 0;
	}

	if(scripts\mp\bots\_bots_killstreaks::func_9E66("vanguard"))
	{
		return 0;
	}

	return 1;
}

//Function Number: 17
func_2DF6(param_00,param_01,param_02,param_03)
{
	func_2DF1(param_00,param_01,param_02,param_03,1);
}

//Function Number: 18
func_9FCC()
{
	return scripts\mp\_utility::func_9FC6() && self.var_13118 == "vanguard" && isdefined(self.var_DF8A);
}

//Function Number: 19
func_2D43()
{
	self endon("spawned_player");
	self endon("disconnect");
	self endon("control_func_done");
	level endon("game_ended");
	var_00 = func_2ECD("vanguard");
	if(!var_00)
	{
		self notify("control_func_done");
	}

	self.var_131B5 = self.var_DF8A;
	childthread func_2D6B(self.var_131B5);
	self.var_131B5 endon("death");
	wait(0.5);
	var_01 = 0;
	var_02 = !self.var_131B5 func_13166();
	var_03 = undefined;
	var_04 = 0;
	var_05 = func_9C23();
	while(var_02 && !var_05)
	{
		var_06 = getnodesinradiussorted(self.var_131B5.origin,1024,64,512,"path");
		if(isdefined(var_03))
		{
			var_06 = scripts\common\utility::func_22A9(var_06,var_03);
		}

		foreach(var_08 in var_06)
		{
			if(func_C038(var_08))
			{
				var_03 = var_08;
				break;
			}

			wait(0.05);
			var_01 = var_01 + 0.05;
		}

		if(var_01 < 1)
		{
			wait(1 - var_01);
		}

		if(!isdefined(var_03))
		{
			self botpressbutton("use",4);
			wait(4);
		}

		var_0A = scripts\mp\bots\_bots_util::func_2E58("GetNodesOnPathVanguard",::scripts\mp\bots\_bots_util::func_74C8,self.var_131B5.origin,var_03.origin);
		if(!isdefined(var_0A))
		{
			if(var_04 == 0)
			{
				var_04++;
				wait(0.05);
				continue;
			}
			else
			{
				self botpressbutton("use",4);
				wait(4);
			}
		}

		for(var_0B = 0;var_0B < var_0A.size;var_0B++)
		{
			var_0C = var_0A[var_0B];
			if(var_0B == 0 && distancesquared(self.origin,var_0C.origin) < 1600)
			{
				continue;
			}

			var_0D = 32;
			if(var_0B == var_0A.size - 1)
			{
				var_0D = 16;
			}

			var_0E = self.var_131B5.origin;
			var_0F = gettime() + 2500;
			while(distance2dsquared(var_0C.origin,self.var_131B5.origin) > var_0D * var_0D)
			{
				if(self.var_131B5 func_13166())
				{
					var_0B = var_0A.size;
					break;
				}

				if(gettime() > var_0F)
				{
					var_0F = gettime() + 2500;
					var_10 = distancesquared(self.var_131B5.origin,var_0E);
					if(var_10 < 1)
					{
						var_0B++;
						break;
					}

					var_0E = self.var_131B5.origin;
				}

				var_11 = vectornormalize(var_0C.origin - self.var_131B5.origin);
				self botsetscriptmove(vectortoangles(var_11)[1],0.2);
				self botlookatpoint(var_0C.origin,0.2,"script_forced");
				var_12 = var_0C.origin[2] + 64;
				var_13 = var_12 - self.var_131B5.origin[2];
				if(var_13 > 10)
				{
					self botpressbutton("lethal");
					continue;
				}

				if(var_13 < -10)
				{
					self botpressbutton("tactical");
				}

				wait(0.05);
			}
		}

		var_02 = 0;
		if(!self.var_131B5 func_13166())
		{
			var_02 = 1;
		}
	}

	self botsetscriptmove(0,0);
	self botlookatpoint(undefined);
	self childthread [[ level.var_2DF9["control_aiming"]["vanguard"] ]]();
	var_15 = self.var_131B5.origin[2];
	var_16 = undefined;
	var_17 = gettime() + 2000;
	var_18 = [];
	var_18[0] = (1,0,0);
	var_18[1] = (-1,0,0);
	var_18[2] = (0,1,0);
	var_18[3] = (0,-1,0);
	var_18[4] = (1,1,0);
	var_18[5] = (1,-1,0);
	var_18[6] = (-1,1,0);
	var_18[7] = (-1,-1,0);
	var_19 = func_6C81(self.var_131B5.origin,"vanguard");
	while(var_19.var_13171[2] - self.var_131B5.origin[2] > 20)
	{
		if(gettime() > var_17)
		{
			var_17 = gettime() + 2000;
			if(isdefined(var_16))
			{
				var_16 = undefined;
			}
			else
			{
				var_13 = self.var_131B5.origin[2] - var_15;
				if(var_13 < 20 && !var_05)
				{
					var_1A = scripts\common\utility::array_randomize(var_18);
					foreach(var_1C in var_1A)
					{
						if(func_D6A1(self.var_131B5.origin + var_1C * 64))
						{
							if(!bullettracepassed(self.var_131B5.origin,self.var_131B5.origin + var_1C * 64,0,self.var_131B5))
							{
								wait(0.05);
								continue;
							}

							var_16 = var_1C;
							break;
						}

						wait(0.05);
					}
				}
			}

			var_15 = self.var_131B5.origin[2];
		}

		if(isdefined(var_16))
		{
			self botsetscriptmove(vectortoangles(var_16)[1],0.05);
			if(scripts\common\utility::func_4347())
			{
				self botpressbutton("tactical");
			}

			continue;
		}

		self botpressbutton("lethal");
		wait(0.05);
	}

	wait(1);
	wait(1);
	self botsetflag("disable_movement",0);
	func_2D3C("vanguard",0);
	self notify("control_func_done");
}

//Function Number: 20
func_D69E(param_00)
{
	var_01 = getclosestnodeinsight(param_00);
	if(isdefined(var_01))
	{
		return func_C038(var_01);
	}

	return 0;
}

//Function Number: 21
func_C038(param_00)
{
	if(function_014A(param_00))
	{
		return func_D6A1(param_00.origin);
	}

	return 0;
}

//Function Number: 22
func_D6A1(param_00)
{
	var_01 = param_00;
	var_02 = param_00 + (0,0,level.var_2EC4);
	if(var_02[2] <= var_01[2])
	{
		return 0;
	}

	var_03 = bullettracepassed(var_01,var_02,0,undefined);
	return var_03;
}

//Function Number: 23
func_13166()
{
	var_00 = getclosestnodeinsight(self.origin);
	if(isdefined(var_00) && !function_014A(var_00))
	{
		return 0;
	}

	wait(0.05);
	if(!func_D6A1(self.origin + (18,0,25)))
	{
		return 0;
	}

	wait(0.05);
	if(!func_D6A1(self.origin + (-18,0,25)))
	{
		return 0;
	}

	wait(0.05);
	if(!func_D6A1(self.origin + (0,18,25)))
	{
		return 0;
	}

	wait(0.05);
	if(!func_D6A1(self.origin + (0,-18,25)))
	{
		return 0;
	}

	return 1;
}

//Function Number: 24
func_1315E()
{
	self notify("vanguard_control_aiming");
	self endon("vanguard_control_aiming");
	var_00 = undefined;
	var_01 = 0;
	var_02 = gettime();
	var_03 = 0;
	var_04 = undefined;
	var_05 = 0;
	while(self [[ level.var_2DF9["isUsing"]["vanguard"] ]]())
	{
		var_06 = undefined;
		var_07 = self geteye();
		var_08 = self getplayerangles();
		var_09 = self botgetfovdot();
		if(isalive(self.var_10C) && self botcanseeentity(self.var_10C))
		{
			var_0A = 1;
			var_06 = self.var_10C;
			var_05 = 0;
		}
		else if(var_05 < 10)
		{
			foreach(var_0C in level.var_3CB5)
			{
				if(var_0C == self || !isalive(var_0C))
				{
					continue;
				}

				if(var_0C scripts\mp\_utility::_hasperk("specialty_noplayertarget"))
				{
					continue;
				}

				if(!isdefined(var_0C.team))
				{
					continue;
				}

				if(!level.teambased || self.team != var_0C.team)
				{
					if(scripts\common\utility::func_13D90(var_07,var_08,var_0C.origin,var_09))
					{
						var_05 = var_05 + 0.05;
						if(isdefined(var_06))
						{
							var_0D = distancesquared(self.var_131B5.origin,var_06.origin);
							var_0E = distancesquared(self.var_131B5.origin,var_0C.origin);
							if(var_0E < var_0D)
							{
								var_06 = var_0C;
							}

							continue;
						}

						var_06 = var_0C;
					}
				}
			}
		}

		if(isdefined(var_06))
		{
			if((isai(var_06) || isplayer(var_06)) && length(var_06 method_8123()) < 25)
			{
				var_00 = var_06.origin;
			}
			else if(gettime() - var_03 < 500)
			{
				if(var_04 != var_06)
				{
					var_00 = var_06.origin;
				}
			}
			else if(gettime() - var_03 > 500)
			{
				var_03 = gettime();
				var_00 = function_00C3(var_06,3);
				var_04 = var_06;
			}

			var_10 = 165;
			if(gettime() - var_02 > 10000)
			{
				var_10 = 200;
			}

			if(distancesquared(self.var_131B5.var_24D1.origin,var_00) < level.var_13168 * level.var_13168)
			{
				if(func_2D16() || distancesquared(self.var_131B5.var_24D1.origin,self.origin) > level.var_13168 * level.var_13168)
				{
					var_02 = gettime();
					self botpressbutton("attack");
				}
			}
		}
		else if(gettime() > var_01)
		{
			var_01 = gettime() + randomintrange(1000,2000);
			var_00 = func_7BEE();
			self.var_BF40 = gettime();
		}

		if(length(var_00) == 0)
		{
			var_00 = (0,0,10);
		}

		self botlookatpoint(var_00,0.2,"script_forced");
		wait(0.05);
	}
}

//Function Number: 25
func_13172(param_00)
{
	param_00.var_2EC7[self.var_6640]++;
	var_01 = [[ level.var_2DF9["heli_node_get_origin"]["vanguard"] ]](param_00);
	var_02 = func_2EC3(param_00);
	var_03 = var_02;
	var_02 = [];
	foreach(var_05 in var_03)
	{
		if(var_05.var_13130)
		{
			if(param_00.origin[2] != param_00.var_13171[2] || var_05.origin[2] != var_05.var_13171[2])
			{
				var_06 = [[ level.var_2DF9["heli_node_get_origin"]["vanguard"] ]](var_05);
				var_07 = playerphysicstrace(var_01,var_06);
				if(distancesquared(var_07,var_06) < 1)
				{
					var_02 = scripts\common\utility::array_add(var_02,var_05);
				}

				wait(0.05);
				continue;
			}

			var_02 = scripts\common\utility::array_add(var_02,var_05);
		}
	}

	if(var_02.size == 0 && var_03.size > 0)
	{
		foreach(var_05 in var_03)
		{
			var_05.var_2EC7[self.var_6640]++;
		}
	}

	return func_8D78(var_02,"vanguard");
}

//Function Number: 26
func_2EC3(param_00)
{
	var_01 = 99;
	var_02 = [];
	foreach(var_04 in param_00.var_BEAA)
	{
		if(isdefined(var_04.var_27C) && var_04.var_13130)
		{
			var_05 = var_04.var_2EC7[self.var_6640];
			if(var_05 < var_01)
			{
				var_02 = [];
				var_02[0] = var_04;
				var_01 = var_05;
			}
			else if(var_05 == var_01)
			{
				var_02[var_02.size] = var_04;
			}
		}
	}

	return var_02;
}

//Function Number: 27
func_13163(param_00)
{
	return param_00.var_13171;
}

//Function Number: 28
func_C716(param_00)
{
	var_01 = 1;
	var_02 = scripts\common\utility::spawn_tag_origin();
	var_02.origin = param_00;
	var_02 delete();
	return var_01;
}

//Function Number: 29
func_8D86()
{
	if(!scripts\mp\bots\_bots_killstreaks::func_18DB())
	{
		return 0;
	}

	return 1;
}

//Function Number: 30
func_8D89()
{
	self.var_131B5 waittill("near_goal");
}

//Function Number: 31
func_2D3E()
{
	thread func_8D87();
	func_2D3B("heli_sniper");
}

//Function Number: 32
func_8D87()
{
	self endon("spawned_player");
	self endon("disconnect");
	self endon("control_func_done");
	level endon("game_ended");
	self botclearscriptgoal();
}

//Function Number: 33
func_8D88(param_00)
{
	param_00.var_2EC7[self.var_6640]++;
	var_01 = func_2DC7(param_00);
	return func_8D78(var_01,"heli_sniper");
}

//Function Number: 34
func_8D7A()
{
	if(!scripts\mp\bots\_bots_killstreaks::func_18DB())
	{
		return 0;
	}

	return 1;
}

//Function Number: 35
func_8D80()
{
	self.var_131B5 waittill("goal_reached");
}

//Function Number: 36
func_2D3D()
{
	func_2D3B("heli_pilot");
}

//Function Number: 37
func_8D7F(param_00)
{
	param_00.var_2EC7[self.var_6640]++;
	var_01 = func_2DC7(param_00);
	var_02 = scripts\common\utility::random(var_01);
	return var_02;
}

//Function Number: 38
func_8D7E()
{
	self notify("heli_pilot_monitor_flares");
	self endon("heli_pilot_monitor_flares");
	var_00 = [];
	while(self [[ level.var_2DF9["isUsing"]["heli_pilot"] ]]())
	{
		self.var_131B5 waittill("targeted_by_incoming_missile",var_01);
		var_02 = 1;
		foreach(var_04 in var_01)
		{
			if(isdefined(var_04) && !scripts\common\utility::func_2286(var_00,var_04))
			{
				var_02 = 0;
			}
		}

		if(!var_02)
		{
			var_06 = clamp(0.34 * self botgetdifficultysetting("strategyLevel"),0,1);
			if(randomfloat(1) < var_06)
			{
				self notify("manual_flare_popped");
			}

			var_00 = scripts\common\utility::array_combine(var_00,var_01);
			var_00 = scripts\common\utility::func_22BC(var_00);
			wait(3);
		}
	}
}

//Function Number: 39
func_8D7B()
{
	self notify("heli_pilot_control_heli_aiming");
	self endon("heli_pilot_control_heli_aiming");
	var_00 = undefined;
	var_01 = undefined;
	var_02 = undefined;
	var_03 = 0;
	var_04 = 0;
	var_05 = undefined;
	var_06 = self botgetdifficultysetting("minInaccuracy") + self botgetdifficultysetting("maxInaccuracy") / 2;
	var_07 = 0;
	while(self [[ level.var_2DF9["isUsing"]["heli_pilot"] ]]())
	{
		var_08 = 0;
		var_09 = 0;
		if(isdefined(var_01) && var_01.health <= 0 && gettime() - var_01.var_4E72 < 2000)
		{
			var_08 = 1;
			var_09 = 1;
		}
		else if(isalive(self.var_10C) && self botcanseeentity(self.var_10C) || gettime() - self lastknowntime(self.var_10C) <= 300)
		{
			var_08 = 1;
			var_01 = self.var_10C;
			var_00 = self.var_10C.origin;
			if(self botcanseeentity(self.var_10C))
			{
				var_07 = 0;
				var_09 = 1;
				var_0A = gettime();
			}
			else
			{
				var_07 = var_07 + 0.05;
				if(var_07 > 5)
				{
					var_08 = 0;
				}
			}
		}

		if(var_08)
		{
			var_02 = var_00 - (0,0,50);
			if(var_09 && func_2D16() || distancesquared(var_02,self.origin) > level.var_8D7D * level.var_8D7D)
			{
				self botpressbutton("attack");
			}

			if(gettime() > var_04 + 500)
			{
				var_0B = randomfloatrange(-1 * var_06 / 2,var_06 / 2);
				var_0C = randomfloatrange(-1 * var_06 / 2,var_06 / 2);
				var_0D = randomfloatrange(-1 * var_06 / 2,var_06 / 2);
				var_05 = (150 * var_0B,150 * var_0C,150 * var_0D);
				var_04 = gettime();
			}

			var_02 = var_02 + var_05;
			var_0E = self.var_131B5 gettagorigin("tag_player");
			var_0F = vectornormalize(var_02 - var_0E);
			var_10 = anglestoforward(self getplayerangles());
			var_11 = vectordot(var_0F,var_10);
			if(var_11 > 0.5)
			{
				self botpressbutton("ads",0.1);
			}
		}
		else if(gettime() > var_03)
		{
			var_03 = gettime() + randomintrange(1000,2000);
			var_02 = func_7BEE();
			self.var_BF40 = gettime();
		}

		var_12 = var_02 - self.var_131B5.origin;
		var_13 = length(var_12);
		var_14 = vectortoangles(var_12);
		var_15 = angleclamp(self.var_131B5.angles[0]);
		var_16 = angleclamp(var_14[0]);
		var_17 = int(var_15 - var_16) % 360;
		if(var_17 > 180)
		{
			var_17 = 360 - var_17;
		}
		else if(var_17 < -180)
		{
			var_17 = -360 + var_17;
		}

		if(var_17 > 15)
		{
			var_16 = var_15 - 15;
		}
		else if(var_17 < -15)
		{
			var_16 = var_15 + 15;
		}

		var_14 = (var_16,var_14[1],var_14[2]);
		var_12 = anglestoforward(var_14);
		var_02 = self.var_131B5.origin + var_12 * var_13;
		if(length(var_02) == 0)
		{
			var_02 = (0,0,10);
		}

		self botlookatpoint(var_02,0.2,"script_forced");
		wait(0.05);
	}
}

//Function Number: 40
func_2D40()
{
	func_2D3F("odin_assault");
}

//Function Number: 41
func_C2D8()
{
	if(func_2E3A())
	{
		return 1;
	}

	if(func_2E38())
	{
		return 1;
	}

	if(func_2E36())
	{
		return 1;
	}

	return 0;
}

//Function Number: 42
func_C2D7()
{
	return func_2E2B();
}

//Function Number: 43
func_2E2B()
{
	var_00 = undefined;
	if(isdefined(self.var_A8DB) && gettime() - self.var_A8DC < 5000)
	{
		var_00 = self.var_A8DB;
	}

	return func_2E2C("enemy",1,var_00);
}

//Function Number: 44
func_2E38()
{
	var_00 = func_2E34();
	if(var_00 == "large")
	{
		self notify("large_rod_action");
		return 1;
	}

	if(var_00 == "small")
	{
		self notify("small_rod_action");
		return 1;
	}

	return 0;
}

//Function Number: 45
func_2E34()
{
	var_00 = gettime() >= self.var_C2D3.var_C2FA;
	var_01 = gettime() >= self.var_C2D3.var_C310;
	if(var_00 || var_01)
	{
		var_02 = func_2E30("enemy",0);
		var_03 = [];
		var_04 = distancesquared(self.origin,self.var_C2D3.var_1156A.origin);
		for(var_05 = 0;var_05 < var_02.size;var_05++)
		{
			var_06 = func_2E2F(var_02[var_05]);
			var_03[var_05] = distancesquared(self.var_C2D3.var_1156A.origin,var_06);
		}

		if(var_00)
		{
			if(!func_2D16() && var_04 < level.var_C2F9 * level.var_C2F9)
			{
				return "none";
			}

			for(var_05 = 0;var_05 < var_02.size;var_05++)
			{
				if(var_03[var_05] < squared(level.var_C2F9))
				{
					self.var_A8DB = var_02[var_05];
					self.var_A8DC = gettime();
					return "large";
				}
			}
		}

		if(var_01)
		{
			if(!func_2D16() && var_04 < level.var_C30F * level.var_C30F)
			{
				return "none";
			}

			for(var_05 = 0;var_05 < var_02.size;var_05++)
			{
				if(var_03[var_05] < squared(level.var_C30F))
				{
					if(isdefined(self.var_A8DB) && self.var_A8DB == var_02[var_05] && gettime() - self.var_A8DC < 5000)
					{
						continue;
					}

					return "small";
				}
			}
		}
	}

	return "none";
}

//Function Number: 46
func_2D41()
{
	func_2D3F("odin_support");
}

//Function Number: 47
func_C316()
{
	if(func_2E3A())
	{
		return 1;
	}

	if(func_2E36())
	{
		return 1;
	}

	if(func_2E39())
	{
		return 1;
	}

	if(func_2E37())
	{
		return 1;
	}

	return 0;
}

//Function Number: 48
func_2E37()
{
	if(func_2E33())
	{
		self notify("marking_action");
		return 1;
	}

	return 0;
}

//Function Number: 49
func_2E33()
{
	if(gettime() < self.var_C2D3.var_C301)
	{
		return 0;
	}

	var_00 = func_2E30("enemy",0);
	var_01 = [];
	for(var_02 = 0;var_02 < var_00.size;var_02++)
	{
		var_03 = func_2E2F(var_00[var_02]);
		var_01[var_02] = distancesquared(self.var_C2D3.var_1156A.origin,var_03);
		if(var_01[var_02] < squared(level.var_C2E9 / 2))
		{
			return 1;
		}
	}

	return 0;
}

//Function Number: 50
func_2E39()
{
	if(func_2E32())
	{
		self notify("smoke_action");
		return 1;
	}

	return 0;
}

//Function Number: 51
func_2E32()
{
	if(gettime() < self.var_C2D3.var_C311)
	{
		return 0;
	}

	var_00 = func_2E2D();
	foreach(var_02 in var_00)
	{
		if(distancesquared(var_02,self.var_C2D3.var_1156A.origin) < 2500)
		{
			return 1;
		}
	}

	var_04 = undefined;
	if(isdefined(self.var_C2D3.var_1156A.nearest_node))
	{
		var_04 = getnodezone(self.var_C2D3.var_1156A.nearest_node);
	}

	if(!isdefined(var_04))
	{
		return 0;
	}

	var_05 = func_2DED(1);
	var_06 = var_05[var_04].size;
	if(var_06 >= 2)
	{
		return 1;
	}

	return 0;
}

//Function Number: 52
func_2E2D()
{
	var_00 = [];
	if(gettime() < self.var_C2D3.var_C311)
	{
		return var_00;
	}

	foreach(var_05, var_02 in level.var_3A59)
	{
		if(scripts\mp\bots\_bots::func_483D(var_02))
		{
			var_00[0] = self;
			var_04 = scripts\common\utility::func_782F(var_01.origin,level.players,var_05);
			if(var_04.size > 0 && var_04[0].team == self.team)
			{
				var_00 = scripts\common\utility::array_add(var_00,var_01.origin);
			}
		}
	}

	var_06 = func_2E30("ally",0);
	foreach(var_08 in var_06)
	{
		if(isai(var_08) && var_08 scripts\mp\bots\_bots_util::func_2DD5())
		{
			var_00 = scripts\common\utility::array_add(var_00,var_08.origin);
		}
	}

	return var_00;
}

//Function Number: 53
func_C315()
{
	var_00 = func_2E2D();
	if(var_00.size > 0)
	{
		return var_00[0];
	}

	return func_2E2C("enemy",1);
}

//Function Number: 54
func_B983()
{
	for(;;)
	{
		self.var_C2D3.var_1156A.nearest_node = getclosestnodeinsight(self.var_C2D3.var_1156A.origin);
		if(scripts\mp\bots\_bots_util::func_2E4E(self.var_C2D3.var_1156A.origin,200))
		{
			self.var_C2D3.var_1156A.var_BE7F = self.var_C2D3.var_1156A.origin;
		}
		else
		{
			self.var_C2D3.var_1156A.var_BE7F = undefined;
		}

		wait(0.25);
	}
}

//Function Number: 55
func_2D3F(param_00)
{
	self endon("spawned_player");
	self endon("disconnect");
	self endon("control_func_done");
	level endon("game_ended");
	var_01 = func_2ECD(param_00);
	if(!var_01)
	{
		self notify("control_func_done");
	}

	self.var_131B5 = self.var_C2D3;
	childthread func_2D6B(self.var_C2D3);
	self.var_C2D3 endon("death");
	wait(1.4);
	self botgetpathdist(0.7);
	thread func_2D6D();
	self.var_C307 = [];
	self.var_C308 = [];
	self.var_C2FB = 0;
	var_02 = undefined;
	var_03 = 0;
	var_04 = undefined;
	childthread func_B983();
	var_05 = self.var_C2D3.var_1156A.origin;
	var_06 = gettime();
	while(self [[ level.var_2DF9["isUsing"][param_00] ]]())
	{
		var_07 = self [[ level.var_2DF9["odin_perform_action"][param_00] ]]();
		if(gettime() > var_06 + 2000)
		{
			var_06 = gettime();
			var_08 = distance(var_05,self.var_C2D3.var_1156A.origin);
			var_05 = self.var_C2D3.var_1156A.origin;
			if(var_08 < 100)
			{
				var_04 = undefined;
				var_02 = undefined;
			}
		}

		if(gettime() > var_03 || !isdefined(var_04))
		{
			var_09 = level.var_2E35[self botgetdifficulty()];
			var_03 = gettime() + var_09 * 1000;
			var_0A = self [[ level.var_2DF9["odin_get_target"][param_00] ]]();
			if(isdefined(var_0A))
			{
				var_02 = undefined;
				if(isplayer(var_0A))
				{
					var_04 = func_2E2F(var_0A);
				}
				else
				{
					var_04 = var_0A;
				}
			}
			else
			{
				if(!isdefined(var_02))
				{
					var_02 = scripts\common\utility::random(level.var_C7E0);
				}

				var_0B = getzonenodeforindex(var_02).origin;
				if(distance2dsquared(self.var_C2D3.var_1156A.origin,var_0B) < 10000)
				{
					var_02 = scripts\common\utility::random(level.var_C7E0);
					var_0B = getzonenodeforindex(var_02).origin;
					var_06 = gettime();
				}

				var_04 = var_0B;
			}
		}

		var_0C = var_04 - self.var_C2D3.var_1156A.origin;
		if(lengthsquared(var_0C) > 100)
		{
			var_0D = vectortoangles(var_0C);
			self botsetscriptmove(var_0D[1],0.05);
			self botlookatpoint(var_04,0.1,"script_forced");
			continue;
		}

		var_06 = gettime();
		wait(0.05);
	}

	self notify("control_func_done");
}

//Function Number: 56
func_2D6D(param_00)
{
	self endon("disconnect");
	self waittill("control_func_done");
	self.var_C307 = undefined;
	self.var_C308 = undefined;
	self.var_C2FB = undefined;
	self botgetpathdist(1);
}

//Function Number: 57
func_2E2F(param_00)
{
	if(level.teambased && self.team == param_00.team)
	{
		return param_00.origin;
	}

	if(length(param_00 method_8123()) < 25)
	{
		return param_00.origin;
	}

	var_01 = param_00 getentitynumber();
	if(!isdefined(self.var_C308[var_01]))
	{
		self.var_C308[var_01] = 0;
	}

	var_02 = gettime();
	var_03 = var_02 - self.var_C308[var_01];
	if(var_03 <= 400)
	{
		var_04 = vectornormalize(param_00 method_8123());
		var_05 = vectornormalize(self.var_C307[var_01] - param_00.origin);
		if(vectordot(var_04,var_05) < -0.5)
		{
			return param_00.origin;
		}
	}

	if(var_03 > 400)
	{
		if(var_02 == self.var_C2FB)
		{
			if(var_03 > 1000)
			{
				return param_00.origin;
			}
		}
		else
		{
			self.var_C307[var_01] = function_00C3(param_00,1.5);
			self.var_C308[var_01] = var_02;
			self.var_C2FB = var_02;
		}
	}

	return self.var_C307[var_01];
}

//Function Number: 58
func_2E2C(param_00,param_01,param_02)
{
	var_03 = func_2E30(param_00,param_01);
	if(isdefined(param_02))
	{
		var_03 = scripts\common\utility::func_22A9(var_03,param_02);
	}

	if(var_03.size > 0)
	{
		var_04 = scripts\common\utility::func_782F(self.var_C2D3.var_1156A.origin,var_03);
		return var_04[0];
	}

	return undefined;
}

//Function Number: 59
func_2E3A()
{
	if(gettime() >= self.var_C2D3.var_C2F8)
	{
		if(!isdefined(self.var_C2D3.var_1156A.nearest_node))
		{
			return 0;
		}
	}

	return 0;
}

//Function Number: 60
func_2E2A()
{
	return func_2E2C("ally",0);
}

//Function Number: 61
func_2E36()
{
	if(func_2E31())
	{
		self notify("airdrop_action");
		self notify("juggernaut_action");
		return 1;
	}

	return 0;
}

//Function Number: 62
func_2E31()
{
	if(gettime() < self.var_C2D3.var_C2D4)
	{
		return 0;
	}

	if(!isdefined(self.var_C2D3.var_1156A.nearest_node))
	{
		return 0;
	}

	if(func_2E2E() > 2)
	{
		return 0;
	}

	if(!isdefined(self.var_C2D3.var_1156A.var_BE7F))
	{
		return 0;
	}

	var_00 = getnodezone(self.var_C2D3.var_1156A.nearest_node);
	if(!isdefined(var_00))
	{
		return 0;
	}

	var_01 = func_2DEC(1);
	var_02 = var_01[var_00].size;
	var_03 = func_2DED(1);
	var_04 = var_03[var_00].size;
	if(var_02 == 0)
	{
		return 0;
	}

	if(var_04 == 0)
	{
		var_05 = 0;
		var_06 = func_2E30("enemy",1);
		foreach(var_08 in var_06)
		{
			if(distancesquared(var_08.origin,self.var_C2D3.var_1156A.origin) < 14400)
			{
				var_05 = 1;
			}
		}

		if(!var_05)
		{
			return 1;
		}
	}

	if(var_02 - var_04 >= 2)
	{
		var_0A = scripts\common\utility::func_782F(self.var_C2D3.var_1156A.origin,var_01[var_00]);
		var_0B = scripts\common\utility::func_782F(self.var_C2D3.var_1156A.origin,var_03[var_00]);
		var_0C = distance(self.var_C2D3.var_1156A.origin,var_0A[0].origin);
		var_0D = distance(self.var_C2D3.var_1156A.origin,var_0B[0].origin);
		if(var_0C + 120 < var_0D)
		{
			return 1;
		}
	}

	return 0;
}

//Function Number: 63
func_2E2E()
{
	var_00 = 0;
	foreach(var_02 in level.var_3A59)
	{
		if(isdefined(var_02) && scripts\mp\bots\_bots::func_483D(var_02))
		{
			var_00++;
		}
	}

	return var_00;
}

//Function Number: 64
func_2E30(param_00,param_01,param_02)
{
	var_03 = func_2DEB(self.team,param_00,param_01);
	var_04 = self botgetfovdot();
	var_05 = [];
	foreach(var_07 in var_03)
	{
		var_08 = 0;
		var_09 = var_04;
		if(param_00 == "enemy")
		{
			var_09 = var_09 * 0.9;
		}

		if(scripts\common\utility::func_13D90(self.var_131B5.origin,self getplayerangles(),var_07.origin,var_09))
		{
			if(!var_08 || self botcanseeentity(var_07))
			{
				var_05 = scripts\common\utility::array_add(var_05,var_07);
			}
		}
	}

	return var_05;
}

//Function Number: 65
func_9C23()
{
	return level.script == "mp_sovereign";
}

//Function Number: 66
func_2D16()
{
	return isdefined(self.var_6BA7) && self.var_6BA7;
}

//Function Number: 67
func_8D78(param_00,param_01)
{
	var_02 = undefined;
	var_03 = 0;
	foreach(var_05 in param_00)
	{
		var_06 = distancesquared(level.var_2E17,[[ level.var_2DF9["heli_node_get_origin"][param_01] ]](var_05));
		if(var_06 > var_03)
		{
			var_03 = var_06;
			var_02 = var_05;
		}
	}

	if(isdefined(var_02))
	{
		return var_02;
	}

	return scripts\common\utility::random(param_00);
}

//Function Number: 68
func_8D58(param_00)
{
	return param_00.origin;
}

//Function Number: 69
func_6C81(param_00,param_01)
{
	var_02 = undefined;
	var_03 = 99999999;
	foreach(var_05 in level.var_2DC8)
	{
		var_06 = distance2dsquared(param_00,[[ level.var_2DF9["heli_node_get_origin"][param_01] ]](var_05));
		if(var_06 < var_03)
		{
			var_02 = var_05;
			var_03 = var_06;
		}
	}

	return var_02;
}

//Function Number: 70
func_2DEC(param_00)
{
	var_01 = func_2DE9(param_00);
	var_02 = [];
	for(var_03 = 0;var_03 < level.var_13FBD;var_03++)
	{
		var_02[var_03] = [];
	}

	foreach(var_05 in var_01)
	{
		var_06 = var_05 getnearestnode();
		var_07 = getnodezone(var_06);
		if(isdefined(var_07))
		{
			var_02[var_07] = scripts\common\utility::array_add(var_02[var_07],var_05);
		}
	}

	return var_02;
}

//Function Number: 71
func_2DED(param_00)
{
	var_01 = func_2DEA(param_00);
	var_02 = [];
	for(var_03 = 0;var_03 < level.var_13FBD;var_03++)
	{
		var_02[var_03] = [];
	}

	foreach(var_05 in var_01)
	{
		var_06 = var_05 getnearestnode();
		var_07 = getnodezone(var_06);
		var_02[var_07] = scripts\common\utility::array_add(var_02[var_07],var_05);
	}

	return var_02;
}

//Function Number: 72
func_2DEA(param_00)
{
	return func_2DEB(self.team,"enemy",param_00);
}

//Function Number: 73
func_2DE9(param_00)
{
	return func_2DEB(self.team,"ally",param_00);
}

//Function Number: 74
func_2DEB(param_00,param_01,param_02)
{
	var_03 = [];
	var_04 = level.var_C928;
	if(isdefined(param_02) && param_02)
	{
		var_04 = level.players;
	}

	foreach(var_06 in var_04)
	{
		if(var_06 == self || !isalive(var_06))
		{
			continue;
		}

		var_07 = 0;
		if(param_01 == "ally")
		{
			var_07 = level.teambased && param_00 == var_06.team;
		}
		else if(param_01 == "enemy")
		{
			var_07 = !level.teambased || param_00 != var_06.team;
		}

		if(var_07)
		{
			var_08 = var_06 getnearestnode();
			if(isdefined(var_08) && function_014A(var_08))
			{
				var_03 = scripts\common\utility::array_add(var_03,var_06);
			}
		}
	}

	var_03 = scripts\common\utility::func_22A9(var_03,self);
	return var_03;
}

//Function Number: 75
func_2DC7(param_00)
{
	var_01 = 99;
	var_02 = [];
	foreach(var_04 in param_00.var_BEAA)
	{
		if(isdefined(var_04.var_27C))
		{
			var_05 = var_04.var_2EC7[self.var_6640];
			if(var_05 < var_01)
			{
				var_02 = [];
				var_02[0] = var_04;
				var_01 = var_05;
			}
			else if(var_05 == var_01)
			{
				var_02[var_02.size] = var_04;
			}
		}
	}

	return var_02;
}

//Function Number: 76
func_2D3B(param_00)
{
	self endon("spawned_player");
	self endon("disconnect");
	self endon("control_func_done");
	level endon("game_ended");
	var_01 = func_2ECD(param_00);
	if(!var_01)
	{
		self notify("control_func_done");
	}

	foreach(var_03 in level.var_AD8B)
	{
		if(var_03.var_222 == self)
		{
			self.var_131B5 = var_03;
		}
	}

	childthread func_2D6B(self.var_131B5);
	self.var_131B5 endon("death");
	if(isdefined(level.var_2DF9["control_other"][param_00]))
	{
		self childthread [[ level.var_2DF9["control_other"][param_00] ]]();
	}

	self [[ level.var_2DF9["waittill_initial_goal"][param_00] ]]();
	self childthread [[ level.var_2DF9["control_aiming"][param_00] ]]();
	func_2D3C(param_00,1);
	self notify("control_func_done");
}

//Function Number: 77
func_2DAB(param_00)
{
	if(param_00)
	{
		return squared(100);
	}

	return squared(30);
}

//Function Number: 78
func_2DAC(param_00)
{
	if(param_00)
	{
		return squared(300);
	}

	return squared(90);
}

//Function Number: 79
func_2D3C(param_00,param_01)
{
	foreach(var_03 in level.var_2DC8)
	{
		var_03.var_2EC7[self.var_6640] = 0;
	}

	var_05 = func_6C81(self.var_131B5.origin,param_00);
	var_06 = undefined;
	self.var_BF40 = 0;
	var_07 = "needs_new_goal";
	var_08 = undefined;
	var_09 = self.var_131B5.origin;
	var_0A = 3;
	var_0B = 0.05;
	while(self [[ level.var_2DF9["isUsing"][param_00] ]]())
	{
		if(gettime() > self.var_BF40 && var_07 == "needs_new_goal")
		{
			var_0C = var_05;
			var_05 = [[ level.var_2DF9["heli_pick_node"][param_00] ]](var_05);
			var_06 = undefined;
			if(isdefined(var_05))
			{
				var_0D = [[ level.var_2DF9["heli_node_get_origin"][param_00] ]](var_05);
				if(param_01)
				{
					var_0E = var_05.origin + scripts\mp\_utility::func_7EF9() + level.var_2DC9;
					var_0F = var_05.origin + scripts\mp\_utility::func_7EF9() - level.var_2DC9;
					var_10 = bullettrace(var_0E,var_0F,0,undefined,0,0,1);
					var_06 = var_10["position"] - scripts\mp\_utility::func_7EF9() + level.var_2DFA[param_00];
				}
				else
				{
					var_06 = var_0D;
				}
			}

			if(isdefined(var_06))
			{
				self botsetflag("disable_movement",0);
				var_07 = "waiting_till_goal";
				var_0A = 3;
				var_09 = self.var_131B5.origin;
			}
			else
			{
				var_05 = var_0C;
				self.var_BF40 = gettime() + 2000;
			}

			continue;
		}

		if(var_07 == "waiting_till_goal")
		{
			if(!param_01)
			{
				var_11 = var_06[2] - self.var_131B5.origin[2];
				if(var_11 > 10)
				{
					self botpressbutton("lethal");
				}
				else if(var_11 < -10)
				{
					self botpressbutton("tactical");
				}
			}

			var_12 = var_06 - self.var_131B5.origin;
			if(param_01)
			{
				var_08 = length2dsquared(var_12);
			}
			else
			{
				var_08 = lengthsquared(var_12);
			}

			if(var_08 < func_2DAB(param_01))
			{
				self botsetscriptmove(0,0);
				self botsetflag("disable_movement",1);
				if(self botgetdifficulty() == "recruit")
				{
					self.var_BF40 = gettime() + randomintrange(5000,7000);
				}
				else
				{
					self.var_BF40 = gettime() + randomintrange(3000,5000);
				}

				var_07 = "needs_new_goal";
			}
			else
			{
				var_12 = var_06 - self.var_131B5.origin;
				var_13 = vectortoangles(var_12);
				var_14 = scripts\common\utility::func_116D7(var_08 < func_2DAC(param_01),0.5,1);
				self botsetscriptmove(var_13[1],var_0B,var_14);
				var_0A = var_0A - var_0B;
				if(var_0A <= 0)
				{
					if(distancesquared(self.var_131B5.origin,var_09) < 225)
					{
						var_05.var_2EC7[self.var_6640]++;
						var_07 = "needs_new_goal";
					}

					var_09 = self.var_131B5.origin;
					var_0A = 3;
				}
			}
		}

		wait(var_0B);
	}
}

//Function Number: 80
func_7BEE()
{
	var_00 = [];
	foreach(var_02 in level.var_C7E0)
	{
		var_03 = botzonegetcount(var_02,self.team,"enemy_predict");
		if(var_03 > 0)
		{
			var_00 = scripts\common\utility::array_add(var_00,var_02);
		}
	}

	var_05 = undefined;
	if(var_00.size > 0)
	{
		var_06 = scripts\common\utility::random(var_00);
		var_07 = scripts\common\utility::random(function_00EF(var_06));
		var_05 = var_07.origin;
	}
	else
	{
		if(isdefined(level.var_1165C))
		{
			var_08 = [[ level.var_1165C ]]();
		}
		else
		{
			var_08 = function_0076();
		}

		var_09 = 0;
		while(var_09 < 10)
		{
			var_09++;
			var_0A = var_08[randomint(var_08.size)];
			var_05 = var_0A.origin;
			if(function_014A(var_0A) && distance2dsquared(var_0A.origin,self.var_131B5.origin) > -3036)
			{
				break;
			}
		}
	}

	return var_05;
}

//Function Number: 81
func_9FC3()
{
	return isdefined(self.var_C53B) && self.var_C53B;
}