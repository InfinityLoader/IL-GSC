/*******************************************************************
 * Decompiled By: Bog
 * Decompiled File: scripts\mp\bots\_bots_killstreaks.gsc
 * Game: Call of Duty: Infinite Warfare
 * Platform: PC
 * Function Count: 34
 * Decompile Time: 1522 ms
 * Timestamp: 10/27/2023 12:27:33 AM
*******************************************************************/

//Function Number: 1
func_2DF3()
{
	if(!isdefined(level.var_A68C))
	{
		if(!isdefined(level.var_A68C))
		{
			level.var_A68C = [];
		}

		if(!isdefined(level.var_A68B))
		{
			level.var_A68B = [];
		}

		if(!isdefined(level.var_A68D))
		{
			level.var_A68D = [];
		}

		if(!isdefined(level.var_2EA4))
		{
			level.var_2EA4 = [];
		}

		func_2E63("nuke",::func_2DF4);
		func_2E63("ball_drone_backup",::func_2DF4);
		func_2E63("jackal",::func_2DF4);
		func_2E63("uav",::func_2DF4);
		func_2E63("counter_uav",::func_2DF4);
		func_2E63("jammer",::func_2DF4,::func_2D28);
		func_2E63("directional_uav",::func_2DF4);
		if(isdefined(level.var_B32F))
		{
			[[ level.var_B32F ]]();
		}
	}

	thread scripts\mp\bots\_bots_killstreaks_remote_vehicle::func_DF76();
}

//Function Number: 2
func_2E63(param_00,param_01,param_02,param_03)
{
	level.var_A68C[param_00] = param_01;
	level.var_A68B[param_00] = param_02;
	level.var_A68D[param_00] = param_03;
	level.var_2EA4[level.var_2EA4.size] = param_00;
}

//Function Number: 3
func_2DF5(param_00,param_01,param_02)
{
	if(scripts\mp\_utility::func_2DD9())
	{
		return 1;
	}

	if(func_2DEE(param_00,"bots",undefined,param_01))
	{
		return 1;
	}
	else if(param_02)
	{
	}

	return 0;
}

//Function Number: 4
func_2DEE(param_00,param_01,param_02,param_03)
{
	var_04 = undefined;
	if(param_00 == "specialist")
	{
		return 1;
	}

	if(!func_2DEF(param_00,param_01))
	{
		return 0;
	}

	if(isdefined(param_03))
	{
		var_04 = getsubstr(param_03,11);
		switch(var_04)
		{
			case "assault":
				if(!scripts\mp\_utility::func_9D4E(param_00))
				{
					return 0;
				}
				break;

			case "support":
				if(!scripts\mp\_utility::func_9F8E(param_00))
				{
					return 0;
				}
				break;

			case "specialist":
				if(!scripts\mp\_utility::func_9F6F(param_00))
				{
					return 0;
				}
				break;
		}
	}

	return 1;
}

//Function Number: 5
func_2DEF(param_00,param_01)
{
	if(param_01 == "humans")
	{
		return isdefined(level.var_A6B2[param_00]) && scripts\mp\_utility::func_7F44(param_00) != -1;
	}
	else if(param_01 == "bots")
	{
		return isdefined(level.var_A68C[param_00]);
	}
}

//Function Number: 6
func_2ED1()
{
	self notify("bot_watch_for_killstreak_use");
	self endon("bot_watch_for_killstreak_use");
	self endon("death");
	self endon("disconnect");
	level endon("game_ended");
	for(;;)
	{
		self waittill("killstreak_use_finished");
		scripts\mp\_utility::_switchtoweapon("none");
	}
}

//Function Number: 7
func_2DDB(param_00)
{
	if(!isdefined(param_00))
	{
		return 0;
	}

	if(!isdefined(level.var_A68C[param_00]))
	{
		return 0;
	}

	return 1;
}

//Function Number: 8
func_2D29(param_00)
{
	var_01 = level.var_A68B[param_00];
	if(!isdefined(var_01))
	{
		return 0;
	}

	if(isdefined(var_01) && !self [[ var_01 ]]())
	{
		return 0;
	}

	return 1;
}

//Function Number: 9
func_2EB2()
{
	self notify("bot_think_killstreak");
	self endon("bot_think_killstreak");
	self endon("death");
	self endon("disconnect");
	level endon("game_ended");
	while(!isdefined(level.var_A68C))
	{
		wait(0.05);
	}

	childthread func_2EA0();
	childthread func_2ED1();
	for(;;)
	{
		if(scripts\mp\bots\_bots_util::func_2D0A())
		{
			var_00 = self.pers["killstreaks"];
			if(isdefined(var_00))
			{
				foreach(var_02 in var_00)
				{
					if(!isdefined(var_02))
					{
						continue;
					}

					if(isdefined(var_02.var_110EA) && isdefined(self.var_2DF7) && isdefined(self.var_2DF7[var_02.var_110EA]) && gettime() < self.var_2DF7[var_02.var_110EA])
					{
						continue;
					}

					if(var_02.var_269A)
					{
						var_03 = var_02.var_110EA;
						if(var_02.var_110EA == "all_perks_bonus")
						{
							continue;
						}

						if(scripts\mp\_utility::func_9F6F(var_02.var_110EA))
						{
							if(!var_02.var_9E0B)
							{
								var_03 = "specialist";
							}
							else
							{
								continue;
							}
						}

						var_02.var_394 = scripts\mp\_utility::func_7F55(var_02.var_110EA);
						var_04 = level.var_A68B[var_03];
						if(isdefined(var_04) && !self [[ var_04 ]]())
						{
							continue;
						}

						if(!scripts\mp\_utility::validateusestreak(var_02.var_110EA,1))
						{
							continue;
						}

						var_05 = level.var_A68C[var_03];
						if(isdefined(var_05))
						{
							var_06 = self [[ var_05 ]](var_02,var_00,var_04,level.var_A68D[var_02.var_110EA]);
							if(!isdefined(var_06) || var_06 == 0)
							{
								if(!isdefined(self.var_2DF7))
								{
									self.var_2DF7 = [];
								}

								self.var_2DF7[var_02.var_110EA] = gettime() + 5000;
							}
						}
						else
						{
							if(level.gametype != "grnd")
							{
							}

							var_02.var_269A = 0;
						}

						break;
					}
				}
			}
		}

		wait(randomfloatrange(1,2));
	}
}

//Function Number: 10
func_2D24()
{
	return 0;
}

//Function Number: 11
func_2EA0()
{
	var_00 = scripts\mp\killstreaks\_aalauncher::func_7D8F();
	for(;;)
	{
		self waittill("aa_launcher_fire");
		var_01 = self method_80FB(var_00);
		if(var_01 == 0)
		{
			scripts\mp\_utility::_switchtoweapon(var_00);
			var_02 = scripts\common\utility::func_13734("LGM_player_allMissilesDestroyed","enemy");
			wait(0.5);
			scripts\mp\_utility::_switchtoweapon("none");
		}
	}
}

//Function Number: 12
func_2DF0()
{
}

//Function Number: 13
func_2D25()
{
	if(!func_18DB())
	{
		return 0;
	}

	var_00 = scripts\mp\killstreaks\_air_superiority::func_6CAA(self,self.team);
	var_01 = gettime();
	foreach(var_03 in var_00)
	{
		if(var_01 - var_03.var_64 > 5000)
		{
			return 1;
		}
	}

	return 0;
}

//Function Number: 14
func_18DB()
{
	if(scripts\mp\_utility::func_9D31())
	{
		return 0;
	}

	if(func_1325A())
	{
		return 0;
	}

	return 1;
}

//Function Number: 15
func_1325A()
{
	return scripts\mp\_utility::func_4BD7() >= scripts\mp\_utility::func_B4D2() || level.var_6BAA + 1 >= scripts\mp\_utility::func_B4D2();
}

//Function Number: 16
func_2D28()
{
	if(isdefined(level.var_61AD))
	{
		return 0;
	}

	var_00 = level.var_C74B[self.team];
	if(isdefined(level.var_115C9) && isdefined(level.var_115C9[var_00]) && level.var_115C9[var_00])
	{
		return 0;
	}

	return 1;
}

//Function Number: 17
func_2D26()
{
	if(scripts\mp\_utility::func_9FC6())
	{
		return 0;
	}

	if(scripts\mp\killstreaks\_ball_drone::func_68C0())
	{
		return 0;
	}

	if(func_1325A())
	{
		return 0;
	}

	if(isdefined(self.var_27D3))
	{
		return 0;
	}

	return 1;
}

//Function Number: 18
func_2DF4(param_00,param_01,param_02,param_03)
{
	self endon("commander_took_over");
	self endon("death");
	self endon("disconnect");
	level endon("game_ended");
	wait(randomintrange(3,5));
	if(!scripts\mp\bots\_bots_util::func_2D0A())
	{
		return 1;
	}

	if(isdefined(param_02) && !self [[ param_02 ]]())
	{
		return 0;
	}

	func_2EA5(param_00,param_01,param_00.var_394);
	return 1;
}

//Function Number: 19
func_2DE6(param_00,param_01,param_02,param_03)
{
	func_2DE5(param_00,param_01,param_02,param_03,"anywhere");
}

//Function Number: 20
func_2DE8(param_00,param_01,param_02,param_03)
{
	func_2DE5(param_00,param_01,param_02,param_03,"outside");
}

//Function Number: 21
func_2DE7(param_00,param_01,param_02,param_03)
{
	func_2DE5(param_00,param_01,param_02,param_03,"hidden");
}

//Function Number: 22
func_2DE5(param_00,param_01,param_02,param_03,param_04)
{
	self endon("commander_took_over");
	wait(randomintrange(2,4));
	if(!isdefined(param_04))
	{
		param_04 = "anywhere";
	}

	if(!scripts\mp\bots\_bots_util::func_2D0A())
	{
		return 1;
	}

	if(isdefined(param_02) && !self [[ param_02 ]]())
	{
		return 0;
	}

	var_05 = self getweaponammoclip(param_00.var_394) + self getweaponammostock(param_00.var_394);
	if(var_05 == 0)
	{
		foreach(var_07 in param_01)
		{
			if(isdefined(var_07.var_110EA) && var_07.var_110EA == param_00.var_110EA)
			{
				var_07.var_269A = 0;
			}
		}

		return 1;
	}

	var_09 = undefined;
	if(var_07 == "outside")
	{
		var_0A = [];
		var_0B = scripts\mp\bots\_bots_util::func_2DB1(750,0.6,1);
		foreach(var_0D in var_0B)
		{
			if(function_014A(var_0D))
			{
				var_0A = scripts\common\utility::array_add(var_0A,var_0D);
			}
		}

		if(var_0B.size > 5 && var_0A.size > var_0B.size * 0.6)
		{
			var_0F = scripts\common\utility::func_782F(self.origin,var_0A,undefined,undefined,undefined,150);
			if(var_0F.size > 0)
			{
				var_09 = scripts\common\utility::random(var_0F);
			}
			else
			{
				var_09 = scripts\common\utility::random(var_0A);
			}
		}
	}
	else if(var_07 == "hidden")
	{
		var_10 = getnodesinradius(self.origin,256,0,40);
		var_11 = self getnearestnode();
		if(isdefined(var_11))
		{
			var_12 = [];
			foreach(var_0D in var_10)
			{
				if(nodesvisible(var_11,var_0D,1))
				{
					var_12 = scripts\common\utility::array_add(var_12,var_0D);
				}
			}

			var_09 = self botnodepick(var_12,1,"node_hide");
		}
	}

	if(isdefined(var_09) || var_07 == "anywhere")
	{
		self botsetflag("disable_movement",1);
		if(isdefined(var_09))
		{
			self botlookatpoint(var_09.origin,2.45,"script_forced");
		}

		func_2EA5(param_03,param_04,param_03.var_394);
		wait(2);
		self botpressbutton("attack");
		wait(1.5);
		scripts\mp\_utility::_switchtoweapon("none");
		self botsetflag("disable_movement",0);
	}

	return 1;
}

//Function Number: 23
func_2EA5(param_00,param_01,param_02)
{
	func_2E29(param_00,param_01);
}

//Function Number: 24
func_2E29(param_00,param_01)
{
	if(isdefined(param_00.var_9E10) && param_00.var_9E10)
	{
		self notify("ks_action_6");
		return;
	}

	var_02 = 1;
	while(var_02 < 4)
	{
		if(isdefined(param_01[var_02]))
		{
			if(isdefined(param_01[var_02].var_110EA))
			{
				if(param_01[var_02].var_110EA == param_00.var_110EA)
				{
					var_03 = var_02 + 2;
					self notify("ks_action_" + var_03);
					return;
				}
			}
		}

		var_03++;
	}
}

//Function Number: 25
func_2DE4(param_00,param_01,param_02,param_03)
{
	self endon("commander_took_over");
	wait(randomintrange(3,5));
	if(!scripts\mp\bots\_bots_util::func_2D0A())
	{
		return;
	}

	var_04 = getzonenearest(self.origin);
	if(!isdefined(var_04))
	{
		return;
	}

	self botsetflag("disable_movement",1);
	func_2EA5(param_00,param_01,param_00.var_394);
	wait(2);
	var_05 = level.var_13FBD;
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

		if(var_0B != var_04 && function_0029(var_0B) < 0.25)
		{
			var_0C = botzonegetcount(var_0B,self.team,"enemy_predict");
			if(var_0C > var_07)
			{
				var_06 = var_0B;
				var_07 = var_0C;
			}

			var_08 = scripts\common\utility::array_add(var_08,var_0B);
		}
	}

	if(var_06 >= 0)
	{
		var_0D = getzoneorigin(var_06);
	}
	else if(var_09.size > 0)
	{
		var_0D = getzoneorigin(scripts\common\utility::random(var_09));
	}
	else
	{
		var_0D = getzoneorigin(randomint(level.var_13FBD));
	}

	var_0E = (randomfloatrange(-500,500),randomfloatrange(-500,500),0);
	self notify("confirm_location",var_0D + var_0E,randomintrange(0,360));
	wait(1);
	self botsetflag("disable_movement",0);
}

//Function Number: 26
func_2EB9()
{
	self notify("bot_think_watch_aerial_killstreak");
	self endon("bot_think_watch_aerial_killstreak");
	self endon("death");
	self endon("disconnect");
	level endon("game_ended");
	if(!isdefined(level.var_A8C2))
	{
		level.var_A8C2 = -10000;
	}

	level.var_A68F["allies"] = [];
	level.var_A68F["axis"] = [];
	var_00 = 0;
	var_01 = randomfloatrange(0.05,4);
	for(;;)
	{
		wait(var_01);
		var_01 = randomfloatrange(0.05,4);
		if(scripts\mp\bots\_bots_util::func_2DE0())
		{
			continue;
		}

		if(self botgetdifficultysetting("strategyLevel") == 0)
		{
			continue;
		}

		var_02 = 0;
		if(isdefined(level.var_3F14) && level.var_3F14.team != self.team)
		{
			var_02 = 1;
		}

		if(isdefined(level.var_AAC8) && level.var_AAC8.team != self.team)
		{
			var_02 = 1;
		}

		if(isdefined(level.var_8D79[scripts\common\utility::func_7984(self.team)]))
		{
			var_02 = 1;
		}

		if(func_64E8(self.team))
		{
			var_02 = 1;
			func_1286B("mortar_strike",::func_64E8);
		}

		if(func_6527(self.team))
		{
			var_02 = 1;
			func_1286B("switchblade",::func_6527);
		}

		if(func_64EC(self.team))
		{
			var_02 = 1;
			func_1286B("odin_assault",::func_64EC);
		}

		var_03 = func_7985();
		if(isdefined(var_03))
		{
			var_04 = self geteye();
			if(scripts\common\utility::func_13D90(var_04,self getplayerangles(),var_03.var_24D1.origin,self botgetfovdot()))
			{
				if(sighttracepassed(var_04,var_03.var_24D1.origin,0,self,var_03.var_24D1))
				{
					badplace_cylinder("vanguard_" + var_03 getentitynumber(),var_01 + 0.5,var_03.var_24D1.origin,200,100,self.team);
				}
			}
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
	}
}

//Function Number: 27
func_1286B(param_00,param_01)
{
	if(!isdefined(level.var_A68F[self.team][param_00]))
	{
		level.var_A68F[self.team][param_00] = 0;
	}

	if(!level.var_A68F[self.team][param_00])
	{
		level.var_A68F[self.team][param_00] = 1;
		level thread func_B96A(self.team,param_00,param_01);
	}
}

//Function Number: 28
func_B96A(param_00,param_01,param_02)
{
	var_03 = 0.5;
	while([[ param_02 ]](param_00))
	{
		if(gettime() > level.var_A8C2 + 4000)
		{
			badplace_global("",5,param_00,"only_sky");
			level.var_A8C2 = gettime();
		}

		wait(var_03);
	}

	level.var_A68F[param_00][param_01] = 0;
}

//Function Number: 29
func_64E8(param_00)
{
	if(isdefined(level.var_1A69) && level.var_1A69)
	{
		if(param_00 != level.var_1A6A)
		{
			return 1;
		}
	}

	return 0;
}

//Function Number: 30
func_6527(param_00)
{
	if(isdefined(level.var_DF80))
	{
		foreach(var_02 in level.var_E5DE)
		{
			if(isdefined(var_02.type) && var_02.type == "remote" && var_02.team != param_00)
			{
				return 1;
			}
		}
	}

	return 0;
}

//Function Number: 31
func_64EC(param_00)
{
	foreach(var_02 in level.players)
	{
		if(!level.teambased || isdefined(var_02.team) && param_00 != var_02.team)
		{
			if(isdefined(var_02.var_C2D3) && var_02.var_C2D3.var_C322 == "odin_assault" && gettime() - var_02.var_C2D3.var_64 > 3000)
			{
				return 1;
			}
		}
	}

	return 0;
}

//Function Number: 32
func_7985()
{
	foreach(var_01 in level.players)
	{
		if(!level.teambased || isdefined(var_01.team) && self.team != var_01.team)
		{
			if(isdefined(var_01.var_DF8A) && var_01.var_DF8A.var_8DD9 == "remote_uav")
			{
				return var_01.var_DF8A;
			}
		}
	}

	return undefined;
}

//Function Number: 33
func_9E66(param_00)
{
	return isdefined(level.var_2EDA) && isdefined(level.var_2EDA[param_00]) && level.var_2EDA[param_00];
}

//Function Number: 34
func_2BBA(param_00)
{
	level.var_2EDA[param_00] = 1;
}