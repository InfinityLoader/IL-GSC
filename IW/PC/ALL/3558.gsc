/*******************************************************************
 * Decompiled By: Bog
 * Decompiled File: 3558.gsc
 * Game: Call of Duty: Infinite Warfare
 * Platform: PC
 * Function Count: 35
 * Decompile Time: 9 ms
 * Timestamp: 10/27/2023 12:30:42 AM
*******************************************************************/

//Function Number: 1
func_69D5()
{
	level.var_69D6 = [];
}

//Function Number: 2
func_69D0(param_00)
{
	thread func_69CC();
}

//Function Number: 3
func_69D3()
{
	self notify("exploding_drone_unset");
	self.var_D38B = undefined;
}

//Function Number: 4
func_69D4(param_00,param_01)
{
	param_01 = scripts\mp\_utility::func_9FB3(param_01);
	param_00.issmokeversion = param_01;
	param_00.var_11832 = gettime();
	if(!param_01)
	{
		thread func_69CD();
		thread func_69CC();
		scripts\mp\_utility::func_D915("exploding drone spawn",param_00.var_222);
	}
	else if(lib_0DF8::func_9DDF(self))
	{
		return;
	}

	param_00 thread func_69C5();
	param_00 thread func_69D1();
	param_00 thread func_69C0();
}

//Function Number: 5
func_69C6()
{
	self endon("death");
	self.var_222 endon("disconnect");
	wait(0.1);
	thread func_69C8(self.var_222);
}

//Function Number: 6
func_69C8(param_00)
{
	var_01 = self.var_222;
	if(!isdefined(param_00))
	{
		param_00 = var_01;
	}

	explodingdrone_awardpointsfordeath(param_00,var_01);
	self method_8593();
	self setscriptablepartstate("beacon","neutral",0);
	self setscriptablepartstate("primaryThruster","neutral",0);
	self setscriptablepartstate("secondaryThrusters","neutral",0);
	var_02 = undefined;
	if(!self.issmokeversion)
	{
		scripts\mp\_utility::func_D915("exploding drone exploded",var_01);
		self setscriptablepartstate("explode","active",0);
		var_02 = 0.1;
	}
	else
	{
		self setscriptablepartstate("destroySmoke","active",0);
		var_02 = 0.1;
	}

	thread func_69BF(var_02);
}

//Function Number: 7
func_69C2(param_00)
{
	var_01 = self.var_222;
	if(!isdefined(param_00))
	{
		param_00 = var_01;
	}

	explodingdrone_awardpointsfordeath(param_00,var_01);
	if(!self.issmokeversion)
	{
		scripts\mp\_utility::func_D915("exploding drone destroyed",var_01);
	}

	self method_8593();
	self setscriptablepartstate("beacon","neutral",0);
	self setscriptablepartstate("primaryThruster","neutral",0);
	self setscriptablepartstate("secondaryThrusters","neutral",0);
	if(!self.issmokeversion)
	{
		self setscriptablepartstate("destroy","active",0);
	}
	else
	{
		self setscriptablepartstate("destroySmoke","active",0);
	}

	thread func_69BF(0.1);
}

//Function Number: 8
func_69BF(param_00)
{
	self notify("death");
	self.var_69BA = 1;
	self method_8587(1);
	self setcandamage(0);
	wait(param_00);
	self delete();
}

//Function Number: 9
explodingdrone_transform()
{
	scripts\mp\_utility::func_1302(scripts\common\utility::func_116D7(self.issmokeversion,"power_smoke_drone_transform_mp","power_exploding_drone_transform_mp"),self.origin,(0,0,0),100,1,self);
	thread explodingdrone_transforminternal();
}

//Function Number: 10
explodingdrone_transforminternal()
{
	self endon("death");
	self method_8587(1);
	var_00 = 1 - gettime() - self.var_11832 / 1000;
	if(self.issmokeversion)
	{
		var_00 = var_00 + 0.1;
	}

	wait(var_00);
	self method_8587(0);
}

//Function Number: 11
func_69D2()
{
	self endon("death");
	if(!self.issmokeversion)
	{
		self setscriptablepartstate("transform","active",0);
	}
	else
	{
		self setscriptablepartstate("transformSmoke","active",0);
	}

	wait(0.4);
	self setscriptablepartstate("primaryThruster","active",0);
	wait(0.25);
	self setscriptablepartstate("secondaryThrusters","active",0);
	wait(0.4);
	if(!self.issmokeversion)
	{
		self setscriptablepartstate("beacon","active",0);
		return;
	}

	self setscriptablepartstate("smoke","active",0);
}

//Function Number: 12
func_69C5()
{
	self endon("death");
	self endon("exploding_drone_transform");
	self.var_222 endon("disconnect");
	self waittill("missile_stuck",var_00,var_01);
	self notify("exploding_drone_stuck");
	var_02 = isdefined(var_01) && var_01 == "tag_flicker";
	var_03 = isdefined(var_01) && var_01 == "tag_weapon";
	if(!self.issmokeversion)
	{
		if(isdefined(var_00) && isplayer(var_00) || isagent(var_00) && !var_03 && !var_02)
		{
			if(lib_0DF8::func_213D(var_00,self))
			{
				var_00 dodamage(35,self.origin,self.var_222,self,"MOD_IMPACT",scripts\common\utility::func_116D7(self.issmokeversion,"power_smoke_drone_mp","power_exploding_drone_mp"));
			}
		}
	}

	explodingdrone_transform();
	thread func_69C2();
	self delete();
}

//Function Number: 13
func_69D1()
{
	self endon("death");
	self endon("exploding_drone_stuck");
	self.var_222 endon("disconnect");
	var_00 = self.var_222;
	self method_82DD(var_00);
	self method_831F(var_00);
	var_01 = anglestoforward(var_00 getgunangles());
	var_02 = var_00 geteye() + var_01 * 2500;
	var_03 = scripts\common\utility::func_116D7(self.issmokeversion,0.1,0.2);
	wait(var_03);
	self notify("exploding_drone_transform");
	var_04 = self.origin;
	var_05 = self.angles;
	explodingdrone_transform();
	self.origin = var_04;
	self.angles = var_05;
	self method_82DD(var_00);
	self method_831F(var_00);
	var_00 func_69BC(self);
	thread func_69D2();
	var_06 = var_00 scripts\mp\_utility::_hasperk("specialty_rugged_eqp");
	if(var_06)
	{
		self.hasruggedeqp = 1;
	}

	var_07 = scripts\common\utility::func_116D7(var_06,57,38);
	var_08 = scripts\common\utility::func_116D7(var_06,"hitequip","");
	thread scripts\mp\_damage::func_B9C6(var_07,var_08,::func_69CA,::explodingdrone_handledamage,0,0);
	self method_859F();
	self method_85A0();
	if(!self.issmokeversion)
	{
		scripts\mp\sentientpoolmanager::registersentient("Lethal_Moving",var_00,1);
	}

	thread func_69C9(var_02);
	thread func_69C3();
	thread func_69C4();
	thread scripts\mp\perks\_perk_equipmentping::func_E84B();
	thread scripts\mp\_weapons::func_C798(self,var_00);
	var_09 = scripts\common\utility::spawn_tag_origin();
	var_09 thread func_69C1(self);
	self linkto(var_09);
	var_0A = 4;
	if(self.issmokeversion)
	{
		if(issubstr(var_00 getcurrentweapon(),"iw7_unsalmg_mpl"))
		{
			var_0A = 10;
		}
		else
		{
			var_0A = 6;
		}
	}

	var_09 moveto(var_02,var_0A,3,0);
	wait(var_0A);
	thread func_69C8();
}

//Function Number: 14
func_69C9(param_00)
{
	self endon("death");
	self.var_222 endon("disconnect");
	var_01 = vectornormalize(param_00 - self.origin);
	var_02 = scripts\common\trace::func_48BC(1,1,1,0,1,1,0);
	for(;;)
	{
		if(function_0288(self.origin,self.origin + var_01 * 12,6,var_02,[self,self.var_222],"physicsquery_any"))
		{
			thread func_69C8();
		}

		scripts\common\utility::func_136F7();
	}
}

//Function Number: 15
func_69C3()
{
	self endon("death");
	self.var_222 endon("disconnect");
	self waittill("emp_damage",var_00,var_01,var_02,var_03,var_04);
	if(isdefined(var_03) && var_03 == "emp_grenade_mp")
	{
		if(scripts\mp\_utility::func_9FB3(scripts\mp\_utility::playersareenemies(self.var_222,var_00)))
		{
			var_00 scripts\mp\_missions::func_D991("ch_tactical_emp_eqp");
		}
	}

	explodingdrone_givedamagefeedback(var_00);
	thread func_69C2(var_00);
}

//Function Number: 16
func_69C4()
{
	self endon("death");
	self.var_222 endon("disconnect");
	level scripts\common\utility::waittill_any_3("game_ended","bro_shot_start");
	thread func_69C2();
}

//Function Number: 17
explodingdrone_validdetonationstate()
{
	if(!scripts\mp\_utility::func_9F19(self))
	{
		return 0;
	}

	if(scripts\mp\_utility::func_9FC6())
	{
		return 0;
	}

	if(lib_0DF8::func_9DDF(self))
	{
		return 0;
	}

	if(isusingreaper())
	{
		return 0;
	}

	if(self method_84CA())
	{
		return 0;
	}

	if(self method_8568())
	{
		return 0;
	}

	return 1;
}

//Function Number: 18
func_69BD()
{
	return gettime() - self.var_11832 / 1000 > 0.3;
}

//Function Number: 19
func_69CD()
{
	self endon("death");
	self endon("disconnect");
	self endon("exploding_drone_unset");
	level endon("game_ended");
	self notify("explodingDrone_listenForDetonate");
	self endon("explodingDrone_listenForDetonate");
	for(;;)
	{
		self waittillmatch("power_exploding_drone_mp","detonate");
		if(explodingdrone_validdetonationstate())
		{
			func_69C7();
		}
	}
}

//Function Number: 20
func_69CC()
{
	self endon("death");
	self endon("disconnect");
	self endon("exploding_drone_unset");
	level endon("game_ended");
	self notify("explodingDrone_listenForAltDetonate");
	self endon("explodingDrone_listenForAltDetonate");
	var_00 = 0;
	for(;;)
	{
		if(self usebuttonpressed())
		{
			var_00 = 0;
			while(self usebuttonpressed())
			{
				var_00 = var_00 + 0.05;
				wait(0.05);
			}

			if(var_00 >= 0.5)
			{
				continue;
			}

			var_00 = 0;
			while(!self usebuttonpressed() && var_00 < 0.5)
			{
				var_00 = var_00 + 0.05;
				wait(0.05);
			}

			if(var_00 >= 0.5)
			{
				continue;
			}

			if(!lib_0DF8::func_9DDF(self) && !scripts\mp\_utility::func_9FC6())
			{
				func_69C7();
			}
		}

		wait(0.05);
	}
}

//Function Number: 21
func_69C7()
{
	if(!isdefined(self.var_D38B))
	{
		return;
	}

	foreach(var_01 in self.var_D38B)
	{
		if(var_01 func_69BD())
		{
			var_01 thread func_69C6();
		}
	}
}

//Function Number: 22
func_69BC(param_00)
{
	if(!isdefined(self.var_D38B))
	{
		self.var_D38B = [];
	}

	if(!isdefined(level.var_69D6))
	{
		level.var_69D6 = [];
	}

	var_01 = param_00 getentitynumber();
	if(!isdefined(self.var_D38B[var_01]))
	{
		self.var_D38B[var_01] = param_00;
	}

	if(!isdefined(level.var_69D6[var_01]))
	{
		level.var_69D6[var_01] = param_00;
	}

	thread func_69CF(param_00);
}

//Function Number: 23
func_69CE(param_00,param_01)
{
	if(!isdefined(param_01))
	{
		param_01 = param_00 getentitynumber();
	}

	if(isdefined(self) && isdefined(self.var_D38B))
	{
		self.var_D38B[param_01] = undefined;
	}

	if(isdefined(level.var_69D6))
	{
		level.var_69D6[param_01] = undefined;
	}
}

//Function Number: 24
func_69CF(param_00)
{
	var_01 = param_00 getentitynumber();
	param_00 waittill("death");
	func_69CE(param_00,var_01);
}

//Function Number: 25
isexplodingdrone()
{
	var_00 = self getentitynumber();
	var_01 = level.var_69D6[var_00];
	return isdefined(var_01) && var_01 == self;
}

//Function Number: 26
explodingdrone_givedamagefeedback(param_00)
{
	var_01 = "";
	if(scripts\mp\_utility::func_9FB3(self.hasruggedeqp))
	{
		var_01 = "hitequip";
	}

	if(isplayer(param_00))
	{
		param_00 scripts\mp\_damagefeedback::func_12E84(var_01);
	}
}

//Function Number: 27
explodingdrone_awardpointsfordeath(param_00,param_01)
{
	if(scripts\mp\_utility::func_9FB3(scripts\mp\_utility::playersareenemies(param_01,param_00)))
	{
		self method_82DD(param_00);
		param_00 notify("destroyed_equipment");
		if(!self.issmokeversion)
		{
			param_00 notify("killed_exploding_drone",param_01);
		}

		param_00 thread scripts\mp\_utility::func_83B4("destroyed_equipment");
	}
}

//Function Number: 28
explodingdrone_makedamageimmune(param_00)
{
	if(!isdefined(self.entsimmune))
	{
		self.entsimmune = [];
	}

	self.entsimmune[param_00 getentitynumber()] = param_00;
}

//Function Number: 29
explodingdrone_isdamageimmune(param_00)
{
	if(!isexplodingdrone())
	{
		return 0;
	}

	if(!isdefined(self.entsimmune))
	{
		return 0;
	}

	return isdefined(self.entsimmune[param_00 getentitynumber()]);
}

//Function Number: 30
explodingdrone_modifieddamage(param_00,param_01,param_02,param_03,param_04)
{
	if(isdefined(param_00) && isdefined(param_03))
	{
		if(param_03 explodingdrone_isdamageimmune(param_01))
		{
			param_04 = 0;
		}
	}

	return param_04;
}

//Function Number: 31
explodingdrone_handledamage(param_00,param_01,param_02,param_03,param_04)
{
	if(!lib_0DF8::func_213D(param_00,self))
	{
		return 0;
	}

	if(scripts\common\utility::func_9D74(param_02))
	{
		if(isdefined(param_01))
		{
			var_05 = getweaponbasename(param_01);
			switch(var_05)
			{
				case "iw7_steeldragon_mp":
					param_03 = param_03 * 3;
					break;

				case "micro_turret_gun_mp":
					param_03 = param_03 * 2;
					break;

				default:
					var_06 = 1;
					if(param_03 >= scripts\mp\_weapons::minegettwohitthreshold())
					{
						var_06 = var_06 + 1;
					}
	
					if(scripts\mp\_utility::func_9DFF(param_01,param_02))
					{
						var_06 = var_06 * 2;
					}
					param_03 = var_06 * 19;
					break;
			}
		}
	}

	scripts\mp\_powers::equipmenthit(self.var_222,param_00,param_01,param_02);
	return param_03;
}

//Function Number: 32
func_69CA(param_00,param_01,param_02,param_03)
{
	self.var_4D3F = param_00;
	thread func_69C8(param_00);
}

//Function Number: 33
func_69C0()
{
	self endon("death");
	self.var_222 waittill("disconnect");
	self delete();
}

//Function Number: 34
func_69C1(param_00)
{
	self endon("death");
	param_00 waittill("death");
	self delete();
}

//Function Number: 35
isusingreaper()
{
	if(!isplayer(self))
	{
		return 0;
	}

	if(!scripts\mp\_utility::func_9F19(self))
	{
		return 0;
	}

	if(isdefined(self.var_11234))
	{
		var_00 = self.var_11234.var_10E47.var_DE3F;
		if(!isdefined(var_00) || var_00 != "super_reaper")
		{
			return 0;
		}

		return scripts\mp\_utility::func_9FB3(self.var_11234.var_9E53);
	}

	return 0;
}