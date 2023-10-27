/*******************************************************************
 * Decompiled By: Bog
 * Decompiled File: maps\mp\_binoculars.gsc
 * Game: Call of Duty: WWII
 * Platform: PC
 * Function Count: 16
 * Decompile Time: 245 ms
 * Timestamp: 10/27/2023 3:21:05 AM
*******************************************************************/

//Function Number: 1
func_175E()
{
	thread func_93AD();
	thread func_93AC();
}

//Function Number: 2
func_93AD()
{
	self endon("death");
	self endon("disconnect");
	self endon("faux_spawn");
	self endon("joined_team");
	self.var_93AB = spawnstruct();
	self.var_93AB.var_5E6C = [];
	self.var_93AB.var_5E74 = 0;
	var_00 = 0;
	for(;;)
	{
		if(issubstr(self getcurrentweapon(),"binoculars") && self playerads() > 0.99)
		{
			var_00 = 1;
			if(self.var_93AB.var_5E6C.size > 0)
			{
				func_7C96();
			}

			self.var_93AB.var_5E6C = func_0F95(common_scripts\utility::func_FA0(self.var_93AB.var_5E6C));
			if(isdefined(self.var_93AB.var_5E72))
			{
				if(!func_5E73(self.var_93AB.var_5E72))
				{
					self.var_93AB.var_5E72 = undefined;
					self notify("stop_javelin_locking_feedback");
				}
			}

			if(isdefined(self.var_93AB.var_5E72))
			{
				self.var_93AB.var_5E74 = self.var_93AB.var_5E74 + 0.05;
			}
			else
			{
				self.var_93AB.var_5E74 = 0;
				if(self.var_93AB.var_5E6C.size < 1)
				{
					self.var_93AB.var_5E72 = func_40CB();
					if(isdefined(self.var_93AB.var_5E72))
					{
						thread func_5E71();
					}
				}
			}

			if(self.var_93AB.var_5E74 >= 1 && isdefined(self.var_93AB.var_5E72) && self.var_93AB.var_5E6C.size < 1)
			{
				self notify("stop_javelin_locking_feedback");
				self.var_93AB.var_5E6C[self.var_93AB.var_5E6C.size] = self.var_93AB.var_5E72;
				thread func_5E6B();
				self.var_93AB.var_5E72 = undefined;
			}

			if(self.var_93AB.var_5E6C.size > 0)
			{
				self method_82EA(self.var_93AB.var_5E6C[0]);
			}
			else
			{
				self method_82EB();
				self notify("stop_javelin_locked_feedback");
			}
		}
		else if(var_00 == 1)
		{
			var_00 = 0;
			self method_82EB();
			self notify("stop_javelin_locking_feedback");
			self notify("stop_javelin_locked_feedback");
			self.var_93AB.var_5E6C = [];
			if(isdefined(self.var_93AB.var_5E72))
			{
				self.var_93AB.var_5E72 = undefined;
			}

			self.var_93AB.var_5E74 = 0;
		}

		wait 0.05;
	}
}

//Function Number: 3
func_93AC()
{
	self endon("death");
	self endon("disconnect");
	self endon("faux_spawn");
	self endon("joined_team");
	for(;;)
	{
		self waittill("missile_fire",var_00,var_01);
		if(issubstr(var_01,"binoculars"))
		{
			thread func_93A6(self,var_00,var_01);
		}
	}
}

//Function Number: 4
func_93A6(param_00,param_01,param_02)
{
	var_03 = (0,0,0);
	var_04 = (0,0,0);
	if(isdefined(param_01))
	{
		var_03 = param_01.var_116;
		var_04 = param_01.var_1D;
		param_01 delete();
	}
	else
	{
		return;
	}

	param_00.var_93AB.var_5E6C = func_0F95(common_scripts\utility::func_FA0(self.var_93AB.var_5E6C));
	var_05 = [];
	for(var_06 = 0;var_06 < 1;var_06++)
	{
		var_07 = var_04 + func_7A43(20,20,20);
		var_08 = anglestoforward(var_07);
		var_09 = magicbullet(param_02,var_03,var_03 + var_08,param_00);
		var_09.var_117 = param_00;
		if(param_00.var_93AB.var_5E6C.size > 0)
		{
			var_0A = undefined;
			if(var_06 < param_00.var_93AB.var_5E6C.size)
			{
				var_0A = param_00.var_93AB.var_5E6C[var_06];
			}
			else
			{
				var_0A = param_00.var_93AB.var_5E6C[randomint(param_00.var_93AB.var_5E6C.size)];
			}

			var_09 method_81D9(var_0A,func_93A9(var_0A));
			var_09.var_5E70 = var_0A;
		}

		var_05[var_05.size] = var_09;
	}

	level notify("stinger_fired",param_00,var_05);
	thread func_49F2(var_05[0].var_5E70,var_05[0]);
	param_00 method_82FA(param_02,0);
}

//Function Number: 5
func_49F2(param_00,param_01)
{
	if(!isdefined(param_01))
	{
		return;
	}

	param_01 endon("death");
	var_02 = "orbitalsupport_exp_40mm";
	wait(randomfloatrange(0.5,1));
	while(1 && isdefined(param_00))
	{
		var_03 = randomintrange(-50,50);
		var_04 = randomintrange(-100,100);
		var_05 = randomintrange(-200,200);
		foreach(var_07 in level.var_744A)
		{
			var_07 method_82E6(common_scripts\utility::func_44F5("flak_gun_explosion"),param_00.var_116 + (var_03,var_04,var_05));
			var_07 method_8617(var_02);
		}

		wait(randomfloatrange(0.05,1));
	}
}

//Function Number: 6
func_0F12(param_00,param_01)
{
	foreach(var_03 in param_00)
	{
		if(isdefined(var_03.var_5E70) && var_03.var_5E70 == param_01)
		{
			return 1;
		}
	}

	return 0;
}

//Function Number: 7
func_40CB()
{
	var_00 = maps\mp\_utility::func_45DE(self.var_1A7);
	var_01 = [];
	if(0)
	{
		foreach(var_03 in level.var_744A)
		{
			if(level.var_984D && var_03.var_1A7 == self.var_1A7)
			{
				continue;
			}

			if(!maps\mp\_utility::func_57A0(var_03))
			{
				continue;
			}

			var_01[var_01.size] = var_03;
		}
	}

	var_05 = vehicle_getarray();
	var_06 = [];
	foreach(var_08 in var_05)
	{
		if(!isdefined(var_08.var_117))
		{
			continue;
		}

		if(level.var_984D && var_08.var_117.var_1A7 == self.var_1A7)
		{
			continue;
		}

		var_06[var_06.size] = var_08;
	}

	var_0A = maps\mp\killstreaks\_killstreaks::func_4405(var_00);
	var_0B = common_scripts\utility::func_F73(var_01,var_06);
	var_0B = common_scripts\utility::func_F73(var_0B,var_0A);
	if(isdefined(level.var_93A8))
	{
		var_0B = common_scripts\utility::func_F73(var_0B,[[ level.var_93A8 ]](self));
	}

	var_0C = self geteye();
	var_0D = anglestoforward(self getangles());
	var_0E = undefined;
	var_0F = cos(5);
	foreach(var_11 in var_0B)
	{
		if(!common_scripts\utility::func_F79(self.var_93AB.var_5E6C,var_11))
		{
			var_12 = func_93AA(var_11);
			var_13 = vectordot(vectornormalize(var_12 - var_0C),var_0D);
			if(var_13 > var_0F)
			{
				var_14 = undefined;
				var_15 = !1;
				if(!var_15)
				{
					var_16 = bullettracepassed(var_0C,var_12,0,var_11);
					if(var_16)
					{
						var_15 = 1;
					}
				}

				if(var_15)
				{
					var_0E = var_11;
					var_0F = var_13;
				}
			}
		}
	}

	return var_0E;
}

//Function Number: 8
func_5E73(param_00)
{
	var_01 = self geteye();
	var_02 = anglestoforward(self getangles());
	var_03 = func_93AA(param_00);
	if((isplayer(param_00) || isbot(param_00)) && !maps\mp\_utility::func_57A0(param_00))
	{
		return 0;
	}

	if(vectordot(vectornormalize(var_03 - var_01),var_02) > cos(5))
	{
		if(!1 || bullettracepassed(var_01,var_03,0,param_00))
		{
			return 1;
		}
	}

	return 0;
}

//Function Number: 9
func_7C96()
{
	for(var_00 = 0;var_00 <= self.var_93AB.var_5E6C.size;var_00++)
	{
		if(isdefined(self.var_93AB.var_5E6C[var_00]) && isdefined(self.var_93AB.var_5E6C[var_00].var_116))
		{
			if(!isdefined(self.var_93AB.var_5E6C[var_00].var_8C44))
			{
				self.var_93AB.var_5E6C[var_00].var_8C44 = -1;
			}

			var_01 = (0,0,0);
			if(isplayer(self.var_93AB.var_5E6C[var_00]) || isbot(self.var_93AB.var_5E6C[var_00]))
			{
				var_01 = (0,0,64);
			}

			if(self method_8215(self.var_93AB.var_5E6C[var_00].var_116 + var_01,50,400,200))
			{
				if(bullettracepassed(self geteye(),self.var_93AB.var_5E6C[var_00].var_116 + var_01,0,self.var_93AB.var_5E6C[var_00]))
				{
					self.var_93AB.var_5E6C[var_00].var_8C44 = -1;
					continue;
				}
			}

			if(self.var_93AB.var_5E6C[var_00].var_8C44 == -1)
			{
				self.var_93AB.var_5E6C[var_00].var_8C44 = gettime();
				continue;
			}

			if(gettime() - self.var_93AB.var_5E6C[var_00].var_8C44 >= 500)
			{
				self.var_93AB.var_5E6C[var_00].var_8C44 = -1;
				self.var_93AB.var_5E6C[var_00] = undefined;
			}
		}
	}
}

//Function Number: 10
func_93AA(param_00)
{
	if(isdefined(param_00.var_46B0))
	{
		return param_00 [[ param_00.var_46B0 ]]();
	}

	return param_00 method_8216(0,0,0);
}

//Function Number: 11
func_93A9(param_00)
{
	return func_93AA(param_00) - param_00.var_116;
}

//Function Number: 12
func_5E71()
{
	self endon("death");
	self endon("disconnect");
	self endon("faux_spawn");
	self endon("joined_team");
	self endon("stop_javelin_locking_feedback");
	for(;;)
	{
		if(isdefined(level.var_9047))
		{
			foreach(var_01 in level.var_9047)
			{
				if(isdefined(var_01.var_117) && isdefined(var_01.var_721C) && isdefined(self.var_93AB.var_5E72) && self.var_93AB.var_5E72 == var_01)
				{
					var_01.var_117 method_8615("wpn_stingerm7_enemy_locked");
				}
			}
		}

		if(isdefined(level.var_6C24) && isdefined(self.var_93AB.var_5E72) && self.var_93AB.var_5E72 == level.var_6C23)
		{
			level.var_6C24 method_8615("wpn_stingerm7_enemy_locked");
		}

		self method_8615("wpn_stingerm7_locking");
		self playrumbleonentity("heavygun_fire");
		wait(0.6);
	}
}

//Function Number: 13
func_5E6B()
{
	self endon("death");
	self endon("disconnect");
	self endon("faux_spawn");
	self endon("joined_team");
	self endon("stop_javelin_locked_feedback");
	for(;;)
	{
		if(isdefined(level.var_9047))
		{
			foreach(var_01 in level.var_9047)
			{
				if(isdefined(var_01.var_117) && isdefined(var_01.var_721C) && isdefined(self.var_93AB.var_5E6C) && func_5718(self.var_93AB.var_5E6C,var_01))
				{
					var_01.var_117 method_8615("wpn_stingerm7_enemy_locked");
				}
			}
		}

		if(isdefined(level.var_6C24) && isdefined(self.var_93AB.var_5E6C) && func_5718(self.var_93AB.var_5E6C,level.var_6C23))
		{
			level.var_6C24 method_8615("wpn_stingerm7_enemy_locked");
		}

		self method_8615("wpn_stingerm7_locked");
		self playrumbleonentity("heavygun_fire");
		wait(0.25);
	}
}

//Function Number: 14
func_0F95(param_00)
{
	var_01 = [];
	foreach(var_03 in param_00)
	{
		if(!isalive(var_03))
		{
			continue;
		}

		var_01[var_01.size] = var_03;
	}

	return var_01;
}

//Function Number: 15
func_7A43(param_00,param_01,param_02)
{
	return (randomfloat(param_00) - param_00 * 0.5,randomfloat(param_01) - param_01 * 0.5,randomfloat(param_02) - param_02 * 0.5);
}

//Function Number: 16
func_5718(param_00,param_01)
{
	if(isdefined(param_00))
	{
		foreach(var_03 in param_00)
		{
			if(var_03 == param_01)
			{
				return 1;
			}
		}
	}

	return 0;
}