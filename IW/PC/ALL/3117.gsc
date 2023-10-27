/*******************************************************************
 * Decompiled By: Bog
 * Decompiled File: 3117.gsc
 * Game: Call of Duty: Infinite Warfare
 * Platform: PC
 * Function Count: 47
 * Decompile Time: 18 ms
 * Timestamp: 10/27/2023 12:26:09 AM
*******************************************************************/

//Function Number: 1
func_98E7(param_00)
{
	self.var_2B0F = 1;
	self.var_1FC6 = 1;
	self.var_4BDC = undefined;
	self.var_4BDB = undefined;
	self method_828A("noclip");
	self method_8287(99999999);
	self method_828B(1);
	func_F722("hover");
	thread lib_0C77::func_13F62();
	return level.var_111AE;
}

//Function Number: 2
func_8281(param_00)
{
	if(func_7ED5() == "launched")
	{
		if(func_8285(self))
		{
			func_827B(self,self.var_D04C,func_7ED2());
		}

		return level.var_E87A;
	}

	return level.var_6AD5;
}

//Function Number: 3
func_827A(param_00)
{
	if(func_7ED5() == "entangled")
	{
		if(isdefined(self.var_D04C) && !scripts\cp\_laststand::player_in_laststand(self.var_D04C) && self.var_D04C attackbuttonpressed())
		{
			var_01 = self.var_D04C;
			var_02 = anglestoforward(self.var_D04C getplayerangles());
			var_03 = var_01.origin + (0,0,5);
			var_04 = var_03 + var_02 * func_79E8();
			var_05 = bullettrace(var_03,var_04,0,var_01)["position"];
			if(distancesquared(self.origin,var_05) < 360000)
			{
				var_06 = var_05;
			}
			else
			{
				var_07 = vectornormalize(var_06 - self.origin);
				var_06 = self.origin + var_07 * 600;
			}

			self setorigin(var_06,0);
			self.var_8272 = var_01.origin;
			scripts\cp\maps\cp_zmb\cp_zmb_ghost_wave::func_12DBA(var_01,self);
			return level.var_111AE;
		}
		else
		{
			func_AAA9(self);
			return level.var_E87A;
		}
	}

	return level.var_6AD5;
}

//Function Number: 4
func_79E8()
{
	return 175;
}

//Function Number: 5
func_827F(param_00)
{
	if(func_7ED5() == "hover")
	{
		func_41B5();
		lib_0A1B::func_2968("fly");
		if(!isdefined(self.var_8268))
		{
			self.var_8268 = scripts\common\utility::getclosest(self.origin,level.var_13F29);
			self.var_8272 = self.var_8268.origin;
			return level.var_111AE;
		}

		if(distancesquared(self.var_8268.origin,self.origin) < 4096)
		{
			self notify("ghost_reached_hover_node");
			var_01 = scripts\common\utility::func_22A9(level.var_13F29,self.var_8268);
			var_02 = func_7DB1();
			if(var_02.size > 0)
			{
				var_03 = scripts\common\utility::random(var_02).origin;
			}
			else
			{
				var_03 = self.origin;
			}

			self.var_8268 = func_80BB(var_03,var_01);
			self.var_8272 = self.var_8268.origin;
		}

		return level.var_111AE;
	}

	return level.var_6AD5;
}

//Function Number: 6
func_827E(param_00)
{
	if(func_7ED5() == "hide")
	{
		func_41B7();
		lib_0A1B::func_2968("fly");
		if(!isdefined(self.var_8267))
		{
			self.var_8267 = scripts\common\utility::getclosest(self.origin,level.var_13F28);
			self.var_8272 = self.var_8267.origin;
			return level.var_111AE;
		}

		if(distancesquared(self.var_8267.origin,self.origin) < 1024)
		{
			self notify("ghost_reached_hide_node");
			self.var_8267 = scripts\common\utility::getstruct(self.var_8267.target,"targetname");
			self.var_8272 = self.var_8267.origin;
		}

		return level.var_111AE;
	}

	return level.var_6AD5;
}

//Function Number: 7
func_3DF0(param_00)
{
	lib_0A1B::func_2914();
	if(!func_7ED5() == "attack")
	{
		return level.var_6AD5;
	}

	if(self.var_180)
	{
		return level.var_6AD5;
	}

	if(!isdefined(self.var_13F2C))
	{
		return level.var_6AD5;
	}

	if(!scripts\cp\_utility::func_9F19(self.var_13F2C))
	{
		return level.var_6AD5;
	}

	if(isdefined(self.var_13F2C.ignoreme) && self.var_13F2C.ignoreme == 1)
	{
		return level.var_6AD5;
	}

	if(self.var_1B03 == "melee" || scripts\mp\agents\_scriptedagents::func_9F77())
	{
		return level.var_6AD5;
	}

	if(distancesquared(self.var_13F2C.origin,self.origin) > 9216)
	{
		return level.var_6AD5;
	}

	lib_0A1B::func_2965(self.var_13F2C);
	return level.var_6AD5;
}

//Function Number: 8
func_3D46(param_00)
{
	if(!func_7ED5() == "attack")
	{
		return level.var_6AD5;
	}

	if(self.var_180)
	{
		self.var_4B26 = undefined;
		return level.var_6AD5;
	}

	if(!isdefined(self.var_13F2C))
	{
		return level.var_6AD5;
	}

	if(distancesquared(self.var_13F2C.origin,self.origin) > 147456)
	{
		return level.var_6AD5;
	}

	self.var_8272 = self.var_13F2C.origin;
	func_12871();
	return level.var_111AE;
}

//Function Number: 9
func_F108(param_00)
{
	if(!func_7ED5() == "attack")
	{
		return level.var_6AD5;
	}

	if(isdefined(self.var_5969))
	{
		return level.var_6AD5;
	}

	if(!isdefined(self.var_13F2C))
	{
		return level.var_6AD5;
	}

	self.var_8272 = self.var_13F2C.origin;
	func_12871(1024);
	return level.var_6AD5;
}

//Function Number: 10
func_8278(param_00)
{
	var_01 = self;
	var_01 endon("death");
	var_01 endon("ghost_stop_attack");
	level endon("game_ended");
	var_01 func_8279(param_00);
	var_02 = func_7AE1();
	var_03 = func_7AC9();
	var_04 = randomintrange(func_7AE1(),func_7AC9() + 1);
	for(var_05 = 0;var_05 < var_04;var_05++)
	{
		var_01 waittill("ghost_played_melee_anim");
	}

	if(isdefined(param_00))
	{
		param_00.var_C1F5--;
	}

	var_01 lib_0A1B::func_2914();
	var_01 func_41B7();
	var_01 func_F722("hover");
	var_01 waittill("ghost_reached_hover_node");
	var_01 func_12EA1(1);
}

//Function Number: 11
func_7AE1()
{
	return 1;
}

//Function Number: 12
func_7AC9()
{
	return 1;
}

//Function Number: 13
func_8279(param_00)
{
	func_F723(param_00);
	func_F722("attack");
	func_12EA1(2.5);
}

//Function Number: 14
func_F723(param_00)
{
	self.var_13F2C = param_00;
	self.var_8272 = param_00.origin;
}

//Function Number: 15
func_7DB1()
{
	var_00 = [];
	foreach(var_02 in level.players)
	{
		if(var_02.ignoreme || isdefined(var_02.var_222) && var_02.var_222.ignoreme)
		{
			continue;
		}

		if(lib_0F74::func_1002C(var_02))
		{
			continue;
		}

		if(!isalive(var_02))
		{
			continue;
		}

		var_00[var_00.size] = var_02;
	}

	return var_00;
}

//Function Number: 16
func_12871(param_00)
{
	if(!isdefined(param_00))
	{
		param_00 = 1;
	}

	if(isdefined(self.var_8272) && distancesquared(self.var_8272,self.origin) > param_00)
	{
		lib_0A1B::func_2968("fly");
		return;
	}

	lib_0A1B::func_2968("");
}

//Function Number: 17
func_65FE(param_00,param_01)
{
	param_00 notify("ghost_stop_attack");
	param_01.ghost_in_entanglement = param_00;
	param_00.var_D04C = param_01;
	param_00 func_F75F(param_00,1);
	param_00 func_F722("entangled");
	param_00 func_41B5();
	param_00 func_41B7();
	param_00 func_12EA1(1);
	param_00 lib_0A1B::func_2968("entangled");
	param_00 lib_0A1B::func_2914();
	param_00 func_F79D("off",param_00);
	if(isdefined(level.fbd) && isdefined(level.fbd.fightstarted) && level.fbd.fightstarted)
	{
		param_00 setscriptablepartstate("soul","captured");
	}
}

//Function Number: 18
func_673C(param_00)
{
	param_00 func_12EA1(1);
	param_00 func_F75F(param_00,0);
	param_00 func_F722("hover");
	param_00 lib_0A1B::func_2968("fly");
	param_00 func_F65F("off",param_00);
	param_00 func_F79D("active",param_00);
}

//Function Number: 19
func_AAA9(param_00)
{
	level thread func_AAAD(param_00.origin,param_00.angles,param_00.color,param_00.var_D04C);
	param_00.nocorpse = 1;
	param_00 suicide();
}

//Function Number: 20
func_AAAD(param_00,param_01,param_02,param_03)
{
	level endon("game_ended");
	param_03 endon("disconnect");
	param_03.ghost_in_entanglement = undefined;
	var_04 = spawn("script_model",param_00);
	var_04.angles = vectortoangles(param_01);
	var_04.color = get_fake_ghost_color(param_02);
	var_04 setmodel(get_fake_ghost_model(var_04.color));
	var_04 setscriptablepartstate("animation","on");
	if(isdefined(param_03))
	{
		var_05 = anglestoforward(param_03 getplayerangles());
	}
	else
	{
		var_05 = (0,0,1);
	}

	var_05 = var_05 * 9000;
	var_04 physicslaunchserver(var_04.origin,var_05);
	var_04 method_84D1();
	if(isdefined(level.fbd) && isdefined(level.fbd.fightstarted) && level.fbd.fightstarted)
	{
		thread [[ level.fbd.soulprojectilemonitorfunc ]](var_04,param_03);
		thread [[ level.fbd.soulprojectiledeathfunc ]](var_04);
	}

	var_04 thread func_CAFB(var_04,param_03);
}

//Function Number: 21
get_fake_ghost_color(param_00)
{
	return param_00;
}

//Function Number: 22
get_fake_ghost_model(param_00)
{
	if(isdefined(level.get_fake_ghost_model_func))
	{
		return [[ level.get_fake_ghost_model_func ]](param_00);
	}

	return "fake_zombie_ghost_" + param_00;
}

//Function Number: 23
func_CAFB(param_00,param_01)
{
	param_00 endon("death");
	param_00 waittill("collision",var_02,var_03,var_04,var_05,var_06,var_07,var_08,var_09);
	if(isdefined(level.fbd) && isdefined(level.fbd.fightstarted) && level.fbd.fightstarted)
	{
		var_0A = param_00 gettagorigin("j_spine4");
		playfx(level._effect["flying_soul_hit_fail"],var_0A,anglestoforward(param_00.angles),anglestoup(param_00.angles));
	}

	func_6AEC(param_00,param_01,func_7ED4());
}

//Function Number: 24
func_6AEC(param_00,param_01,param_02)
{
	if(isdefined(level.fbd) && isdefined(level.fbd.fightstarted) && level.fbd.fightstarted)
	{
		param_00 delete();
		return;
	}

	func_827D(param_00,param_01,param_02);
	playfx(level._effect["ghost_explosion_death_" + get_exp_vfx_color(param_00.color)],param_00.origin,anglestoforward(param_00.angles),anglestoup(param_00.angles));
	param_00 setscriptablepartstate("animation","off");
	param_00 delete();
}

//Function Number: 25
get_exp_vfx_color(param_00)
{
	if(issubstr(param_00,"bomb"))
	{
		return strtok(param_00,"_")[0];
	}

	return param_00;
}

//Function Number: 26
func_8285(param_00)
{
	if(isdefined(param_00.var_D04C) && param_00.var_D04C secondaryoffhandbuttonpressed())
	{
		return 1;
	}

	if(gettime() - param_00.var_10BBB > 5000)
	{
		return 1;
	}

	return 0;
}

//Function Number: 27
func_827B(param_00,param_01,param_02)
{
	func_D48C(param_00);
	func_827D(param_00,param_01,param_02);
	param_00.nocorpse = 1;
	param_00 suicide();
}

//Function Number: 28
func_827D(param_00,param_01,param_02)
{
	var_03 = getclosestactivemovingtargetwithinrange(param_00,param_02);
	if(isplayer(param_01))
	{
		if(isdefined(var_03))
		{
			param_01 thread scripts\cp\_damage::func_12E84("hitcritical");
			if([[ level.should_moving_target_explode ]](param_00,var_03))
			{
				if(isdefined(level.process_player_gns_combo_func))
				{
					[[ level.process_player_gns_combo_func ]](param_01,var_03);
				}

				process_moving_target_hit(var_03,param_01,param_00);
				return;
			}

			if(isdefined(level.hit_wrong_moving_target_func))
			{
				[[ level.hit_wrong_moving_target_func ]](param_01,var_03,param_00);
				return;
			}

			return;
		}

		if(isdefined(level.process_player_gns_combo_func))
		{
			[[ level.process_player_gns_combo_func ]](param_01,var_03);
			return;
		}
	}
}

//Function Number: 29
process_moving_target_hit(param_00,param_01,param_02)
{
	if(isdefined(level.process_moving_target_hit_func))
	{
		[[ level.process_moving_target_hit_func ]](param_00,param_01,param_02);
		return;
	}

	remove_moving_target_default(param_00,param_01);
}

//Function Number: 30
remove_moving_target_default(param_00,param_01)
{
	func_E05A(param_00,param_01);
	scripts\cp\maps\cp_zmb\cp_zmb_ghost_wave::func_93F2(param_01);
}

//Function Number: 31
func_E05A(param_00,param_01)
{
	param_00 setscriptablepartstate("skull_vfx","off");
	param_00 delete();
	param_01 thread scripts\cp\_vo::try_to_play_vo("killfirm_ghost","zmb_comment_vo","highest",10,0,0,1,10);
	scripts\cp\maps\cp_zmb\cp_zmb_ghost_wave::func_DB04();
}

//Function Number: 32
getclosestactivemovingtargetwithinrange(param_00,param_01)
{
	if(!isdefined(level.var_BD43))
	{
		return undefined;
	}

	var_02 = [];
	foreach(var_04 in level.var_BD43)
	{
		foreach(var_06 in var_04)
		{
			if(!isdefined(var_06))
			{
				continue;
			}

			if(distancesquared(param_00.origin,var_06.origin) < param_01)
			{
				var_02[var_02.size] = var_06;
			}
		}
	}

	var_09 = sortbydistance(var_02,param_00.origin);
	return var_09[0];
}

//Function Number: 33
func_7D97(param_00,param_01)
{
	var_02 = [];
	foreach(var_04 in level.var_13F2D)
	{
		if(var_04 == param_00)
		{
			continue;
		}

		if(func_9DDD(var_04))
		{
			continue;
		}

		if(distancesquared(param_00.origin,var_04.origin) < param_01)
		{
			var_02[var_02.size] = var_04;
		}
	}

	return var_02;
}

//Function Number: 34
func_7ED2()
{
	return -25536;
}

//Function Number: 35
func_7ED4()
{
	return 7225;
}

//Function Number: 36
func_F75F(param_00,param_01)
{
	param_00.var_9BD4 = param_01;
}

//Function Number: 37
func_9DDD(param_00)
{
	return scripts\common\utility::istrue(param_00.var_9BD4);
}

//Function Number: 38
func_C0B6(param_00)
{
	return level.var_6AD5;
}

//Function Number: 39
func_F722(param_00)
{
	self.var_826C = param_00;
}

//Function Number: 40
func_7ED5()
{
	return self.var_826C;
}

//Function Number: 41
func_41B5()
{
	self.var_8267 = undefined;
}

//Function Number: 42
func_41B7()
{
	self.var_8268 = undefined;
}

//Function Number: 43
func_12EA1(param_00)
{
	if(!isdefined(self.var_4BDC))
	{
		return;
	}

	if(!isdefined(self.var_4BDB))
	{
		return;
	}

	self.var_1FC6 = param_00;
	self method_82AF(self.var_4BDC,self.var_4BDB,self.var_1FC6);
}

//Function Number: 44
func_F65F(param_00,param_01)
{
	param_01 setscriptablepartstate("being_entangled",param_00);
}

//Function Number: 45
func_F79D(param_00,param_01)
{
	param_01 setscriptablepartstate("mist_trail",param_00);
}

//Function Number: 46
func_80BB(param_00,param_01)
{
	var_02 = 4;
	var_03 = sortbydistance(param_01,param_00);
	var_04 = scripts\common\utility::func_116D7(var_03.size > var_02,var_02,var_03.size);
	var_05 = randomint(var_04);
	return var_03[var_05];
}

//Function Number: 47
func_D48C(param_00)
{
	var_01 = vectornormalize(param_00.var_381);
	if(var_01 == (0,0,0))
	{
		var_01 = (0,0,1);
	}

	var_02 = vectortoangles(var_01);
	playfx(level._effect["ghost_explosion_death"],param_00.origin,var_01,anglestoup(var_02));
}