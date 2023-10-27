/*******************************************************************
 * Decompiled By: Bog
 * Decompiled File: maps\mp\bots\_bots_ks.gsc
 * Game: Call of Duty: WWII
 * Platform: PC
 * Function Count: 28
 * Decompile Time: 500 ms
 * Timestamp: 10/27/2023 3:09:51 AM
*******************************************************************/

//Function Number: 1
func_1A4E()
{
	if(!maps\mp\_utility::func_F5C())
	{
		return;
	}

	var_00 = gettime();
	if(!isdefined(level.var_5A59))
	{
		func_1AB3("uav",::func_1A50);
		func_1AB3("counter_uav",::func_1A50);
		func_1AB3("flak_gun",::func_1A50);
		func_1AB3("fritzx",::func_1A50);
		func_1AB3("airstrike",::func_1A50);
		func_1AB3("plane_gunner",::func_1A50);
		func_1AB3("paratroopers",::func_1A50);
		func_1AB3("carepackage",::func_1A42);
		func_1AB3("emergency_carepackage",::func_1A42);
		func_1AB3("molotovs",::bot_killstreak_weapon);
		func_1AB3("flamethrower",::bot_killstreak_weapon);
		func_1AB3("firebomb",::func_1A3D,::func_1961);
		func_1AB3("fighter_strike",::func_1A3D,::func_1961);
		func_1AB3("mortar_strike",::func_1A3D,::func_1961);
		func_1AB3("missile_strike",::func_1A3D,::func_1961);
		func_1AB3("v2_rocket",::func_1A3D,::func_1961);
	}

	thread maps/mp/bots/_bots_ks_remote_vehicle::func_7C63();
}

//Function Number: 2
func_1AB3(param_00,param_01,param_02,param_03)
{
	if(!isdefined(level.var_5A59))
	{
		level.var_5A59 = [];
	}

	level.var_5A59[param_00] = param_01;
	if(!isdefined(level.var_5A58))
	{
		level.var_5A58 = [];
	}

	level.var_5A58[param_00] = param_02;
	if(!isdefined(level.var_5A5A))
	{
		level.var_5A5A = [];
	}

	level.var_5A5A[param_00] = param_03;
	if(!isdefined(level.var_1AF3))
	{
		level.var_1AF3 = [];
	}

	level.var_1AF3[level.var_1AF3.size] = param_00;
}

//Function Number: 3
func_1A38(param_00,param_01)
{
	if(func_1A49(param_00,"bots",undefined))
	{
		return 1;
	}
	else if(param_01)
	{
	}

	return 0;
}

//Function Number: 4
func_1A49(param_00,param_01,param_02)
{
	if(!func_1A4A(param_00,param_01))
	{
		return 0;
	}

	return 1;
}

//Function Number: 5
func_1A4A(param_00,param_01)
{
	if(param_01 == "humans")
	{
		return isdefined(level.var_5A61) && isdefined(level.var_5A61[param_00]) && maps\mp\_utility::func_453F(param_00) != -1;
	}
	else if(param_01 == "bots")
	{
		return isdefined(level.var_5A59) && isdefined(level.var_5A59[param_00]);
	}
}

//Function Number: 6
func_1B01()
{
	self notify("bot_think_killstreak");
	self endon("bot_think_killstreak");
	self endon("death");
	self endon("disconnect");
	level endon("game_ended");
	self.var_1B2F = undefined;
	while(!isdefined(level.var_5A59))
	{
		wait 0.05;
	}

	for(;;)
	{
		if(maps/mp/bots/_bots_util::func_1937())
		{
			var_00 = self.var_12C["killstreaks"];
			if(isdefined(var_00))
			{
				foreach(var_02 in var_00)
				{
					if(isdefined(var_02.var_944C) && isdefined(self.var_1A51) && isdefined(self.var_1A51[var_02.var_944C]) && gettime() < self.var_1A51[var_02.var_944C])
					{
						continue;
					}

					if(var_02.var_13AF)
					{
						var_03 = var_02.var_944C;
						var_02.var_1D0 = maps\mp\_utility::func_454A(var_02.var_944C,self.var_1A7,maps\mp\_utility::func_649("specialty_improvedstreaks"));
						var_04 = level.var_5A58[var_03];
						if(isdefined(var_04) && !self [[ var_04 ]](var_02))
						{
							continue;
						}

						if(!maps\mp\_utility::func_A27A(var_02.var_944C,1))
						{
							continue;
						}

						var_05 = level.var_5A59[var_03];
						if(isdefined(var_05))
						{
							var_06 = self [[ var_05 ]](var_02,var_00,var_04,level.var_5A5A[var_02.var_944C]);
							if(!isdefined(var_06) || var_06 == 0)
							{
								if(!isdefined(self.var_1A51))
								{
									self.var_1A51 = [];
								}

								self.var_1A51[var_02.var_944C] = gettime() + 5000;
							}
						}
						else
						{
							var_02.var_13AF = 0;
							maps\mp\killstreaks\_killstreaks::func_A129(0);
						}

						break;
					}
				}
			}
		}

		wait(randomfloatrange(2,4));
	}
}

//Function Number: 7
func_1A4B()
{
}

//Function Number: 8
func_1A3E(param_00)
{
	return 0;
}

//Function Number: 9
func_1A3C(param_00)
{
	return param_00.var_1D0 == "killstreak_uav_mp";
}

//Function Number: 10
func_A3EB()
{
	return maps\mp\_utility::func_2924() >= maps\mp\_utility::func_60A6() || level.var_3A62 + 1 >= maps\mp\_utility::func_60A6();
}

//Function Number: 11
func_1963(param_00)
{
	if(isdefined(level.var_35F6))
	{
		return 0;
	}

	var_01 = level.var_6C63[self.var_1A7];
	if(isdefined(level.var_9852) && isdefined(level.var_9852[var_01]) && level.var_9852[var_01])
	{
		return 0;
	}

	return 1;
}

//Function Number: 12
func_1961(param_00)
{
	if(isdefined(level.var_B93))
	{
		return 0;
	}

	return 1;
}

//Function Number: 13
func_1A50(param_00,param_01,param_02,param_03)
{
	wait(randomintrange(3,5));
	if(!maps/mp/bots/_bots_util::func_1937())
	{
		return 1;
	}

	if(isdefined(param_02) && !self [[ param_02 ]](param_00))
	{
		return 0;
	}

	func_1AF4(param_00,param_01,param_00.var_1D0);
	return 1;
}

//Function Number: 14
bot_killstreak_weapon(param_00,param_01,param_02,param_03)
{
	wait(randomintrange(3,5));
	if(!maps/mp/bots/_bots_util::func_1937())
	{
		return 1;
	}

	if(isdefined(param_02) && !self [[ param_02 ]](param_00))
	{
		return 0;
	}

	func_1AF4(param_00,param_01,param_00.var_1D0);
	while(self getcurrentweapon() != param_00.var_1D0)
	{
		wait 0.05;
	}

	while(self method_817F(param_00.var_1D0) > 0 && self getcurrentweapon() == param_00.var_1D0)
	{
		wait 0.05;
	}

	if(self getcurrentweapon() == param_00.var_1D0)
	{
		self switchtoweapon("none");
	}

	return 1;
}

//Function Number: 15
func_1A40(param_00,param_01,param_02,param_03)
{
	func_1A3F(param_00,param_01,param_02,param_03,"anywhere");
}

//Function Number: 16
func_1A42(param_00,param_01,param_02,param_03)
{
	func_1A3F(param_00,param_01,param_02,param_03,"outside");
}

//Function Number: 17
func_1A41(param_00,param_01,param_02,param_03)
{
	func_1A3F(param_00,param_01,param_02,param_03,"hidden");
}

//Function Number: 18
func_1A3F(param_00,param_01,param_02,param_03,param_04)
{
	wait(randomintrange(2,4));
	if(!isdefined(param_04))
	{
		param_04 = "anywhere";
	}

	if(!maps/mp/bots/_bots_util::func_1937())
	{
		return 1;
	}

	if(isdefined(param_02) && !self [[ param_02 ]](param_00))
	{
		return 0;
	}

	var_05 = self getweaponammoclip(param_00.var_1D0) + self getweaponammostock(param_00.var_1D0);
	if(var_05 == 0)
	{
		foreach(var_07 in param_01)
		{
			if(isdefined(var_07.var_944C) && var_07.var_944C == param_00.var_944C)
			{
				var_07.var_13AF = 0;
			}
		}

		maps\mp\killstreaks\_killstreaks::func_A129(0);
		return 1;
	}

	var_09 = undefined;
	if(var_07 == "outside")
	{
		var_0A = [];
		var_0B = maps/mp/bots/_bots_util::func_19FA(0,750,0.6,1);
		foreach(var_0D in var_0B)
		{
			if(nodeexposedtosky(var_0D))
			{
				var_0A = common_scripts\utility::func_F6F(var_0A,var_0D);
			}
		}

		if(var_0B.size > 5 && var_0A.size > var_0B.size * 0.6)
		{
			var_0F = common_scripts\utility::func_40B0(self.var_116,var_0A,undefined,undefined,undefined,150);
			if(var_0F.size > 0)
			{
				var_09 = common_scripts\utility::func_7A33(var_0F);
			}
			else
			{
				var_09 = common_scripts\utility::func_7A33(var_0A);
			}
		}
	}
	else if(var_07 == "hidden")
	{
		var_10 = getnodesinradius(self.var_116,256,0,40);
		var_11 = self getnearestnode();
		if(isdefined(var_11))
		{
			var_12 = [];
			foreach(var_0D in var_10)
			{
				if(function_01F4(var_11,var_0D,1))
				{
					var_12 = common_scripts\utility::func_F6F(var_12,var_0D);
				}
			}

			var_09 = self method_8366(var_12,1,"node_hide");
		}
	}

	if(isdefined(var_09) || var_07 == "anywhere")
	{
		self botsetflag("disable_movement",1);
		if(isdefined(var_09))
		{
			self botlookatpoint(var_09.var_116,2.45,"script_forced");
		}

		func_1AF4(param_03,param_04,param_03.var_1D0);
		wait(2);
		self botpressbutton("attack");
		wait(1.5);
		self switchtoweapon("none");
		self botsetflag("disable_movement",0);
	}

	return 1;
}

//Function Number: 19
func_1AF4(param_00,param_01,param_02)
{
	func_1A87(param_00,param_01);
	wait 0.05;
	self switchtoweapon(param_02);
}

//Function Number: 20
func_1A87(param_00,param_01)
{
	if(isdefined(param_00.var_5703) && param_00.var_5703)
	{
		self notify("streakUsed1");
		return;
	}

	for(var_02 = 0;var_02 < 3;var_02++)
	{
		if(isdefined(param_01[var_02].var_944C))
		{
			if(param_01[var_02].var_944C == param_00.var_944C)
			{
				break;
			}
		}
	}

	self notify("streakUsed" + var_02 + 1);
}

//Function Number: 21
func_1A3D(param_00,param_01,param_02,param_03)
{
	wait(randomintrange(3,5));
	if(!maps/mp/bots/_bots_util::func_1937())
	{
		return;
	}

	var_04 = getzonenearest(self.var_116);
	if(!isdefined(var_04))
	{
		return;
	}

	self botsetflag("disable_movement",1);
	func_1AF4(param_00,param_01,param_00.var_1D0);
	wait(2);
	if(!isdefined(self.var_83AF))
	{
		return;
	}

	var_05 = level.var_AC9C;
	var_06 = -1;
	var_07 = 0;
	var_08 = [];
	var_09 = randomfloat(100) > 50;
	for(var_0A = 0;var_0A < var_05;var_0A++)
	{
		if(var_09)
		{
			var_0B = var_05 - 1 - var_0A;
		}
		else
		{
			var_0B = var_0A;
		}

		if(var_0B != var_04 && botzonegetindoorpercent(var_0B) < 0.25)
		{
			var_0C = botzonegetcount(var_0B,self.var_1A7,"enemy_predict");
			if(var_0C > var_07)
			{
				var_06 = var_0B;
				var_07 = var_0C;
			}

			var_08 = common_scripts\utility::func_F6F(var_08,var_0B);
		}
	}

	if(var_06 >= 0)
	{
		var_0D = getzoneorigin(var_06);
	}
	else if(var_09.size > 0)
	{
		var_0D = getzoneorigin(common_scripts\utility::func_7A33(var_09));
	}
	else
	{
		var_0D = getzoneorigin(randomint(level.var_AC9C));
	}

	var_0E = 1;
	while(var_0E)
	{
		var_0F = (randomfloatrange(-500,500),randomfloatrange(-500,500),0);
		self notify("confirm_location",var_0D + var_0F,randomintrange(0,360),(0.5,0.5,0),0);
		var_10 = common_scripts\utility::func_A715("location_selection_complete","airstrikeShowBlockedHUD","single_location_selection_complete");
		if(var_10 == "location_selection_complete")
		{
			var_0E = 0;
			continue;
		}

		wait(0.5);
	}

	wait(1);
	self botsetflag("disable_movement",0);
}

//Function Number: 22
func_1B05()
{
	self notify("bot_think_watch_aerial_killstreak");
	self endon("bot_think_watch_aerial_killstreak");
	self endon("death");
	self endon("disconnect");
	level endon("game_ended");
	if(!isdefined(level.var_5B27))
	{
		level.var_5B27 = -10000;
	}

	if(!isdefined(level.var_5A5B))
	{
		level.var_5A5B["allies"] = [];
		level.var_5A5B["axis"] = [];
	}

	if(!isdefined(level.var_A2C))
	{
		level.var_A2C["allies"] = 0;
		level.var_A2C["axis"] = 0;
	}

	var_00 = 0;
	var_01 = randomfloatrange(0.05,4);
	for(;;)
	{
		wait(var_01);
		var_01 = randomfloatrange(0.05,4);
		if(maps/mp/bots/_bots_util::func_1A36())
		{
			continue;
		}

		if(self botgetdifficultysetting("strategyLevel") == 0)
		{
			continue;
		}

		var_02 = 0;
		if(func_3741(self.var_1A7))
		{
			func_9E0D("missile_strike",::func_3741);
			var_02 = 1;
		}

		if(func_36FB(self.var_1A7))
		{
			func_9E0D("missile_strike",::func_36FB);
			var_02 = 1;
		}

		if(!var_00 && var_02)
		{
			var_00 = 1;
			self botsetflag("hide_indoors",1);
		}

		if(var_00 && !var_02)
		{
			var_00 = 0;
			self botsetflag("hide_indoors",0);
		}

		level.var_A2C[self.var_1A7] = var_02;
	}
}

//Function Number: 23
func_1A31(param_00)
{
	if(!isdefined(self.var_A2D))
	{
		return 0;
	}

	return common_scripts\utility::func_F79(self.var_A2D,param_00);
}

//Function Number: 24
func_62DF(param_00)
{
	if(!isdefined(self.var_A2D))
	{
		self.var_A2D = [];
	}

	self.var_A2D[self.var_A2D.size] = param_00;
	var_01 = vectornormalize(param_00.var_116 - self.var_116 * (1,1,0));
	while(isalive(param_00))
	{
		var_02 = vectornormalize(param_00.var_116 - self.var_116 * (1,1,0));
		var_03 = vectordot(var_01,var_02);
		if(var_03 <= 0)
		{
			var_01 = var_02;
			self notify("defend_force_node_recalculation");
		}

		wait 0.05;
	}

	self.var_A2D = common_scripts\utility::func_F93(self.var_A2D,param_00);
}

//Function Number: 25
func_9E0D(param_00,param_01)
{
	if(!isdefined(level.var_5A5B[self.var_1A7][param_00]))
	{
		level.var_5A5B[self.var_1A7][param_00] = 0;
	}

	if(!level.var_5A5B[self.var_1A7][param_00])
	{
		level.var_5A5B[self.var_1A7][param_00] = 1;
		level thread func_6308(self.var_1A7,param_00,param_01);
	}
}

//Function Number: 26
func_6308(param_00,param_01,param_02)
{
	var_03 = 0.5;
	while([[ param_02 ]](param_00))
	{
		if(gettime() > level.var_5B27 + 4000)
		{
			badplace_global("",5,param_00,"only_sky");
			level.var_5B27 = gettime();
		}

		wait(var_03);
	}

	level.var_5A5B[param_00][param_01] = 0;
}

//Function Number: 27
func_3741(param_00)
{
	if(maps\mp\_utility::func_579B())
	{
		return 0;
	}

	if(isdefined(level.var_7C66) && isdefined(level.var_7EBB))
	{
		foreach(var_02 in level.var_7EBB)
		{
			if(var_02.var_1B9 == "remote" && var_02.var_1A7 != param_00)
			{
				return 1;
			}
		}
	}

	return 0;
}

//Function Number: 28
func_36FB(param_00)
{
	if(maps\mp\_utility::func_579B())
	{
		return 0;
	}

	if(isdefined(level.var_80B4))
	{
		foreach(var_02 in level.var_80B4)
		{
			if(maps\mp\_utility::func_57E5(var_02.var_944C,"airstrike") && var_02.var_1A7 != param_00)
			{
				return 1;
			}
		}
	}

	return 0;
}