/*******************************************************************
 * Decompiled By: Bog
 * Decompiled File: maps\mp\bots\_bots_ks_remote_vehicle.gsc
 * Game: Call of Duty: WWII
 * Platform: PC
 * Function Count: 23
 * Decompile Time: 430 ms
 * Timestamp: 10/27/2023 3:09:52 AM
*******************************************************************/

//Function Number: 1
func_7C63()
{
	while(!isdefined(level.var_1B1B))
	{
		wait 0.05;
	}

	if(isdefined(level.var_1A22))
	{
		return;
	}

	level.var_6C9B = [];
	if(isdefined(level.var_98C5))
	{
		var_00 = [[ level.var_98C5 ]]();
	}
	else
	{
		var_00 = [];
		for(var_01 = 0;var_01 < level.var_AC9C;var_01++)
		{
			var_00[var_00.size] = var_01;
		}
	}

	foreach(var_03 in var_00)
	{
		if(botzonegetindoorpercent(var_03) < 0.25)
		{
			level.var_6C9B = common_scripts\utility::func_F6F(level.var_6C9B,var_03);
		}
	}

	level.var_1A22 = 1;
}

//Function Number: 2
func_1A4C(param_00,param_01,param_02,param_03,param_04)
{
	if(!isdefined(param_03))
	{
		return 0;
	}

	var_05 = 1;
	var_06 = 1;
	var_07 = undefined;
	if(isdefined(self.var_6708))
	{
		var_08 = self method_835D();
		var_09 = distancesquared(self.var_116,self.var_6708.var_116);
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

	var_0A = param_00.var_944C == "vanguard" && func_55A7();
	if(var_0A || var_05)
	{
		var_0B = getnodesinradius(self.var_116,500,0,512);
		if(isdefined(var_0B) && var_0B.size > 0)
		{
			if(isdefined(param_04) && param_04)
			{
				var_0C = var_0B;
				var_0B = [];
				foreach(var_0E in var_0C)
				{
					if(nodeexposedtosky(var_0E))
					{
						var_0F = function_0204(var_0E);
						var_10 = 0;
						foreach(var_12 in var_0F)
						{
							if(nodeexposedtosky(var_12))
							{
								var_10++;
							}
						}

						if(var_10 / var_0F.size > 0.5)
						{
							var_0B = common_scripts\utility::func_F6F(var_0B,var_0E);
						}
					}
				}
			}

			if(var_0A)
			{
				var_15 = self method_8382(var_0B,"node_exposed");
				foreach(var_0E in var_15)
				{
					if(bullettracepassed(var_0E.var_116 + (0,0,30),var_0E.var_116 + (0,0,400),0,self))
					{
						var_07 = var_0E;
						break;
					}

					wait 0.05;
				}
			}
			else if(var_0B.size > 0)
			{
				var_07 = self method_8366(var_0B,min(3,var_0B.size),"node_hide");
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
		var_18 = maps/mp/bots/_bots_util::func_1B21();
		if(var_18 != "goal")
		{
			func_9E08(var_07);
			return 1;
		}
	}

	if(isdefined(param_02) && !self [[ param_02 ]]())
	{
		func_9E08(var_07);
		return 0;
	}

	if(!maps/mp/bots/_bots_util::func_1937())
	{
		func_9E08(var_07);
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

	maps/mp/bots/_bots_ks::func_1AF4(param_00,param_01,param_00.var_1D0);
	self.var_A2E5 = undefined;
	self thread [[ param_03 ]]();
	thread func_19BD();
	thread func_19BF(var_07);
	self waittill("control_func_done");
	return 1;
}

//Function Number: 3
func_19BD()
{
	self endon("disconnect");
	self endon("control_func_done");
	level endon("game_ended");
	self waittill("spawned_player");
	self notify("control_func_done");
}

//Function Number: 4
func_19BF(param_00)
{
	self endon("disconnect");
	self waittill("control_func_done");
	func_9E08(param_00);
	self botsetstance("none");
	self botsetscriptmove(0,0);
	self botsetflag("disable_movement",0);
	self botsetflag("disable_rotation",0);
	self.var_A2E5 = undefined;
}

//Function Number: 5
func_9E08(param_00)
{
	if(isdefined(param_00) && self method_8367() && isdefined(self method_8378()) && self method_8378() == param_00)
	{
		self method_8358();
	}
}

//Function Number: 6
func_19BE(param_00)
{
	param_00 waittill("death");
	self notify("control_func_done");
}

//Function Number: 7
func_1B23(param_00)
{
	var_01 = gettime();
	while(!self [[ level.var_1A54["isUsing"][param_00] ]]())
	{
		wait 0.05;
		if(gettime() - var_01 > 5000)
		{
			return 0;
		}
	}

	return 1;
}

//Function Number: 8
func_55A7()
{
	return level.var_15D == "mp_sovereign";
}

//Function Number: 9
func_194A()
{
	return function_02D2(self);
}

//Function Number: 10
func_4C7F(param_00,param_01)
{
	var_02 = undefined;
	var_03 = 0;
	foreach(var_05 in param_00)
	{
		var_06 = distancesquared(level.var_1A71,[[ level.var_1A54["heli_node_get_origin"][param_01] ]](var_05));
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

	return common_scripts\utility::func_7A33(param_00);
}

//Function Number: 11
func_4C76(param_00)
{
	return param_00.var_116;
}

//Function Number: 12
func_3B6A(param_00,param_01)
{
	var_02 = undefined;
	var_03 = 99999999;
	foreach(var_05 in level.var_1A17)
	{
		var_06 = distance2dsquared(param_00,[[ level.var_1A54["heli_node_get_origin"][param_01] ]](var_05));
		if(var_06 < var_03)
		{
			var_02 = var_05;
			var_03 = var_06;
		}
	}

	return var_02;
}

//Function Number: 13
func_1A47(param_00)
{
	var_01 = func_1A44(param_00);
	var_02 = [];
	for(var_03 = 0;var_03 < level.var_AC9C;var_03++)
	{
		var_02[var_03] = [];
	}

	foreach(var_05 in var_01)
	{
		var_06 = var_05 getnearestnode();
		var_07 = getnodezone(var_06);
		if(isdefined(var_07))
		{
			var_02[var_07] = common_scripts\utility::func_F6F(var_02[var_07],var_05);
		}
	}

	return var_02;
}

//Function Number: 14
func_1A48(param_00)
{
	var_01 = func_1A45(param_00);
	var_02 = [];
	for(var_03 = 0;var_03 < level.var_AC9C;var_03++)
	{
		var_02[var_03] = [];
	}

	foreach(var_05 in var_01)
	{
		var_06 = var_05 getnearestnode();
		var_07 = getnodezone(var_06);
		var_02[var_07] = common_scripts\utility::func_F6F(var_02[var_07],var_05);
	}

	return var_02;
}

//Function Number: 15
func_1A45(param_00)
{
	return func_1A46(self.var_1A7,"enemy",param_00);
}

//Function Number: 16
func_1A44(param_00)
{
	return func_1A46(self.var_1A7,"ally",param_00);
}

//Function Number: 17
func_1A46(param_00,param_01,param_02)
{
	var_03 = [];
	var_04 = level.var_6E97;
	if(isdefined(param_02) && param_02)
	{
		var_04 = level.var_744A;
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
			var_07 = level.var_984D && param_00 == var_06.var_1A7;
		}
		else if(param_01 == "enemy")
		{
			var_07 = !level.var_984D || param_00 != var_06.var_1A7;
		}

		if(var_07)
		{
			var_08 = var_06 getnearestnode();
			if(isdefined(var_08) && nodeexposedtosky(var_08))
			{
				var_03 = common_scripts\utility::func_F6F(var_03,var_06);
			}
		}
	}

	var_03 = common_scripts\utility::func_F93(var_03,self);
	return var_03;
}

//Function Number: 18
func_1A16(param_00)
{
	var_01 = 99;
	var_02 = [];
	foreach(var_04 in param_00.var_6653)
	{
		if(isdefined(var_04.var_164))
		{
			var_05 = var_04.var_1B1E[self.var_37CD];
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

//Function Number: 19
func_197F(param_00)
{
	self endon("spawned_player");
	self endon("disconnect");
	self endon("control_func_done");
	level endon("game_ended");
	var_01 = func_1B23(param_00);
	if(!var_01)
	{
		self notify("control_func_done");
	}

	foreach(var_03 in level.var_5DD9)
	{
		if(var_03.var_117 == self)
		{
			self.var_A2E5 = var_03;
		}
	}

	childthread func_19BE(self.var_A2E5);
	self.var_A2E5 endon("death");
	if(isdefined(level.var_1A54["control_other"][param_00]))
	{
		self childthread [[ level.var_1A54["control_other"][param_00] ]]();
	}

	self [[ level.var_1A54["waittill_initial_goal"][param_00] ]]();
	self childthread [[ level.var_1A54["control_aiming"][param_00] ]]();
	func_1980(param_00,1);
	self notify("control_func_done");
}

//Function Number: 20
func_19F3(param_00)
{
	if(param_00)
	{
		return squared(100);
	}

	return squared(30);
}

//Function Number: 21
func_19F4(param_00)
{
	if(param_00)
	{
		return squared(300);
	}

	return squared(90);
}

//Function Number: 22
func_1980(param_00,param_01)
{
	foreach(var_03 in level.var_1A17)
	{
		var_03.var_1B1E[self.var_37CD] = 0;
	}

	var_05 = func_3B6A(self.var_A2E5.var_116,param_00);
	var_06 = undefined;
	self.var_66A8 = 0;
	var_07 = "needs_new_goal";
	var_08 = undefined;
	var_09 = self.var_A2E5.var_116;
	var_0A = 3;
	var_0B = 0.05;
	while(self [[ level.var_1A54["isUsing"][param_00] ]]())
	{
		if(gettime() > self.var_66A8 && var_07 == "needs_new_goal")
		{
			var_0C = var_05;
			var_05 = [[ level.var_1A54["heli_pick_node"][param_00] ]](var_05);
			var_06 = undefined;
			if(isdefined(var_05))
			{
				var_0D = [[ level.var_1A54["heli_node_get_origin"][param_00] ]](var_05);
				if(param_01)
				{
					var_0E = var_05.var_116 + maps\mp\_utility::func_4507() + level.var_1A18;
					var_0F = var_05.var_116 + maps\mp\_utility::func_4507() - level.var_1A18;
					var_10 = bullettrace(var_0E,var_0F,0,undefined,0,0,1);
					var_06 = var_10["position"] - maps\mp\_utility::func_4507() + level.var_1A55[param_00];
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
				var_09 = self.var_A2E5.var_116;
			}
			else
			{
				var_05 = var_0C;
				self.var_66A8 = gettime() + 2000;
			}

			continue;
		}

		if(var_07 == "waiting_till_goal")
		{
			if(!param_01)
			{
				var_11 = var_06[2] - self.var_A2E5.var_116[2];
				if(var_11 > 10)
				{
					self botpressbutton("lethal");
				}
				else if(var_11 < -10)
				{
					self botpressbutton("tactical");
				}
			}

			var_12 = var_06 - self.var_A2E5.var_116;
			if(param_01)
			{
				var_08 = length2dsquared(var_12);
			}
			else
			{
				var_08 = lengthsquared(var_12);
			}

			if(var_08 < func_19F3(param_01))
			{
				self botsetscriptmove(0,0);
				self botsetflag("disable_movement",1);
				if(self botgetdifficulty() == "recruit")
				{
					self.var_66A8 = gettime() + randomintrange(5000,7000);
				}
				else
				{
					self.var_66A8 = gettime() + randomintrange(3000,5000);
				}

				var_07 = "needs_new_goal";
			}
			else
			{
				var_12 = var_06 - self.var_A2E5.var_116;
				var_13 = vectortoangles(var_12);
				var_14 = common_scripts\utility::func_98E7(var_08 < func_19F4(param_01),0.5,1);
				self botsetscriptmove(var_13[1],var_0B,var_14);
				var_0A = var_0A - var_0B;
				if(var_0A <= 0)
				{
					if(distancesquared(self.var_A2E5.var_116,var_09) < 225)
					{
						var_05.var_1B1E[self.var_37CD]++;
						var_07 = "needs_new_goal";
					}

					var_09 = self.var_A2E5.var_116;
					var_0A = 3;
				}
			}
		}

		wait(var_0B);
	}
}

//Function Number: 23
func_42E5()
{
	var_00 = [];
	foreach(var_02 in level.var_6C9B)
	{
		var_03 = botzonegetcount(var_02,self.var_1A7,"enemy_predict");
		if(var_03 > 0)
		{
			var_00 = common_scripts\utility::func_F6F(var_00,var_02);
		}
	}

	var_05 = undefined;
	if(var_00.size > 0)
	{
		var_06 = common_scripts\utility::func_7A33(var_00);
		var_07 = common_scripts\utility::func_7A33(getzonenodes(var_06));
		var_05 = var_07.var_116;
	}
	else
	{
		if(isdefined(level.var_98C4))
		{
			var_08 = [[ level.var_98C4 ]]();
		}
		else
		{
			var_08 = getallnodes();
		}

		var_09 = 0;
		while(var_09 < 10)
		{
			var_09++;
			var_0A = var_08[randomint(var_08.size)];
			var_05 = var_0A.var_116;
			if(nodeexposedtosky(var_0A) && distance2dsquared(var_0A.var_116,self.var_A2E5.var_116) > -3036)
			{
				break;
			}
		}
	}

	return var_05;
}