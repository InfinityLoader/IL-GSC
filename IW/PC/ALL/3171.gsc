/*******************************************************************
 * Decompiled By: Bog
 * Decompiled File: 3171.gsc
 * Game: Call of Duty: Infinite Warfare
 * Platform: PC
 * Function Count: 33
 * Decompile Time: 19 ms
 * Timestamp: 10/27/2023 12:26:24 AM
*******************************************************************/

//Function Number: 1
func_D899()
{
	self endon("kill_long_death");
	self endon("death");
	self.var_6EC4 = 1;
	self.var_AFE7 = 1;
	self.var_1491.var_58DA = 1;
	self notify("long_death");
	self.health = 10000;
	self.var_33F = self.var_33F - 2000;
	anim.var_BF77 = gettime() + 3000;
	anim.var_BF78 = gettime() + 3000;
	wait(0.75);
	if(self.health > 1)
	{
		self.health = 1;
	}

	wait(0.05);
	self.var_AFE7 = undefined;
	self.var_1491.var_B4E7 = 1;
	wait(1);
	if(isdefined(level.player) && distancesquared(self.origin,level.player.origin) < 1048576)
	{
		anim.var_C222 = randomintrange(10,30);
		anim.var_BF77 = gettime() + randomintrange(15000,-5536);
	}
	else
	{
		anim.var_C222 = randomintrange(5,12);
		anim.var_BF77 = gettime() + randomintrange(5000,25000);
	}

	anim.var_BF78 = gettime() + randomintrange(7000,13000);
}

//Function Number: 2
func_5F73(param_00)
{
	self endon("death");
	self notify("end_dying_crawl_back_aim");
	self endon("end_dying_crawl_back_aim");
	var_01 = lib_0A1E::func_2356(param_00,"aim_4");
	var_02 = lib_0A1E::func_2356(param_00,"aim_6");
	var_03 = lib_0A1E::func_2356(param_00,"aim_4_knob");
	var_04 = lib_0A1E::func_2356(param_00,"aim_6_knob");
	wait(0.05);
	self method_82AC(var_01,1,0);
	self method_82AC(var_02,1,0);
	var_05 = 0;
	for(;;)
	{
		var_06 = scripts\anim\utility_common::func_824A();
		var_07 = angleclamp180(var_06 - var_05);
		if(abs(var_07) > 3)
		{
			var_07 = scripts\common\utility::func_101EA(var_07) * 3;
		}

		var_06 = angleclamp180(var_05 + var_07);
		if(var_06 < 0)
		{
			if(var_06 < -45)
			{
				var_06 = -45;
			}

			var_08 = var_06 / -45;
			self method_82A2(var_03,var_08,0.05);
			self method_82A2(var_04,0,0.05);
		}
		else
		{
			if(var_06 > 45)
			{
				var_06 = 45;
			}

			var_08 = var_06 / 45;
			self method_82A2(var_04,var_08,0.05);
			self method_82A2(var_03,0,0.05);
		}

		var_05 = var_06;
		wait(0.05);
	}
}

//Function Number: 3
func_FA8D(param_00,param_01)
{
	var_02 = lib_0A1E::func_2356(param_00,"clear_knob");
	self method_806F(var_02,param_01);
	if(isdefined(self.var_1491.var_29D4))
	{
		return;
	}

	thread func_5F73(param_00);
	self.var_1491.var_29D4 = 1;
}

//Function Number: 4
func_9D2F()
{
	var_00 = self.var_10C method_815B();
	var_01 = self method_8141();
	var_02 = vectortoangles(var_00 - self method_8142());
	var_03 = scripts\common\utility::func_152F(var_01[1] - var_02[1]);
	if(var_03 > level.var_C88B)
	{
		if(distancesquared(self geteye(),var_00) > level.var_C889 || var_03 > level.var_C88A)
		{
			return 0;
		}
	}

	return scripts\common\utility::func_152F(var_01[0] - var_02[0]) <= level.var_C87D;
}

//Function Number: 5
func_5822()
{
	self endon("death");
	var_00 = "J_SpineLower";
	var_01 = "tag_origin";
	var_02 = 6;
	var_03 = level._effect["crawling_death_blood_smear"];
	if(isdefined(self.var_1491.var_486A))
	{
		var_02 = self.var_1491.var_486A;
	}

	if(isdefined(self.var_1491.var_4869))
	{
		var_03 = level._effect[self.var_1491.var_4869];
	}

	while(var_02)
	{
		var_04 = self gettagorigin(var_00);
		var_05 = self gettagangles(var_01);
		var_06 = anglestoright(var_05);
		var_07 = anglestoforward((270,0,0));
		playfx(var_03,var_04,var_07,var_06);
		wait(var_02);
	}
}

//Function Number: 6
func_9D9D(param_00)
{
	if(isdefined(self.var_1491.var_7280))
	{
		return 1;
	}

	var_01 = getmovedelta(param_00,0,1);
	var_02 = self method_81E7(var_01);
	return self method_8200(var_02);
}

//Function Number: 7
func_9DD8(param_00)
{
	if(isdefined(self.var_72CC) && self.var_72CC == 4)
	{
		return 1;
	}

	if(!isdefined(self.var_10C))
	{
		return 0;
	}

	var_01 = vectornormalize(self.var_10C method_815B() - self geteye());
	return vectordot(var_01,param_00) > 0.5;
}

//Function Number: 8
func_AFE5(param_00,param_01,param_02,param_03)
{
	func_A669();
}

//Function Number: 9
func_A669()
{
	if(isdefined(self.var_A8AA))
	{
		self method_81D0(self.origin,self.var_A8AA);
		return;
	}

	self method_81D0();
}

//Function Number: 10
func_10D8E(param_00)
{
	self endon(param_00 + "_finished");
	wait(0.1);
	if(isdefined(self.var_1491.var_29D4))
	{
		return;
	}

	thread func_5F73(param_00);
	self.var_1491.var_29D4 = 1;
}

//Function Number: 11
func_8977(param_00,param_01,param_02)
{
	var_03 = 0;
	if(!isdefined(self.var_29D0) && issubstr(param_01,"bodyfall"))
	{
		thread func_5822();
	}
	else if(param_01 == "fire_spray")
	{
		if(!scripts\anim\utility_common::func_3907())
		{
			return 1;
		}

		if(!func_9D2F())
		{
			return 1;
		}

		scripts\anim\utility_common::func_FE9A();
		return 1;
	}
	else if(param_01 == "pistol_pickup")
	{
		thread func_10D8E(param_00);
		return 0;
	}
	else if(param_01 == "fire")
	{
		scripts\anim\utility_common::func_FE9A();
		return 1;
	}

	return 0;
}

//Function Number: 12
func_3EC8(param_00,param_01,param_02)
{
	if(!isdefined(self.var_1491.var_4876))
	{
		var_03 = self.var_1491.var_D6A5;
		if(!lib_0A1A::func_2346(param_01,var_03))
		{
			self.var_1491.var_4876 = undefined;
			return self.var_1491.var_4876;
		}

		var_04 = lib_0A1E::func_2356(param_01,var_03);
		if(isarray(var_04))
		{
			self.var_1491.var_4876 = var_04[randomint(var_04.size)];
		}
		else
		{
			self.var_1491.var_4876 = var_04;
		}
	}

	return self.var_1491.var_4876;
}

//Function Number: 13
func_3F05(param_00,param_01,param_02)
{
	if(!isdefined(self.var_1491.var_11186))
	{
		var_03 = "leg";
		var_04 = "b";
		if(!self.var_AB5A)
		{
			var_03 = "gut";
			if(45 < self.var_E3 && self.var_E3 < 135)
			{
				var_04 = "l";
			}
			else if(-135 < self.var_E3 && self.var_E3 < -45)
			{
				var_04 = "r";
			}
			else if(-45 < self.var_E3 && self.var_E3 < 45)
			{
			}
		}

		self.var_1491.var_11186 = var_03 + "_" + var_04;
	}

	var_05 = lib_0A1E::func_2356(param_01,self.var_1491.var_11186);
	if(isarray(var_05))
	{
		if(!isdefined(self.var_1491.var_11187))
		{
			self.var_1491.var_11187 = randomint(var_05.size);
		}

		var_05 = var_05[self.var_1491.var_11187];
	}

	return var_05;
}

//Function Number: 14
func_CF2A(param_00,param_01,param_02,param_03)
{
	self endon(param_01 + "_finished");
	if(isdefined(self.var_1491.var_7280))
	{
		var_04 = self.var_1491.var_7280;
	}
	else
	{
		var_04 = randomintrange(1,5);
	}

	var_05 = lib_0A1E::func_2336(param_00,param_01);
	self method_806F(lib_0A1E::func_2339(),param_02);
	self method_82E7(param_01,var_05,1,param_02,1);
	lib_0A1E::func_2369(param_00,param_01,var_05);
	for(var_06 = 0;var_06 < var_04;var_06++)
	{
		if(!func_9D9D(var_05))
		{
			break;
		}

		if(isdefined(self.var_4C41))
		{
			self playsound(self.var_4C41);
		}

		for(;;)
		{
			var_07 = lib_0A1E::func_231F(param_00,param_01,lib_0A1A::func_2341(param_00,param_01));
			if(var_07 == "code_move")
			{
				break;
			}
		}
	}

	lib_0A1A::func_2330(param_01,"dying_crawl_done");
}

//Function Number: 15
func_CF2B(param_00,param_01,param_02,param_03)
{
	self endon(param_01 + "_finished");
	if(isdefined(self.var_10C))
	{
		self method_8306(self.var_10C);
	}

	if(isdefined(self.var_1491.var_7280))
	{
		var_04 = self.var_1491.var_7280;
	}
	else
	{
		var_04 = randomintrange(1,5);
	}

	func_FA8D(param_01,param_02);
	var_05 = lib_0A1E::func_2336(param_00,param_01);
	lib_0A1E::func_2369(param_00,param_01,var_05);
	self method_82E7(param_01,var_05,1,param_02,1);
	for(var_06 = 0;var_06 < var_04;var_06++)
	{
		if(!func_9D9D(var_05))
		{
			break;
		}

		for(;;)
		{
			var_07 = lib_0A1E::func_2322(param_00,param_01,::func_8977);
			if(var_07 == "code_move")
			{
				break;
			}
		}
	}

	self.var_527E = gettime() + randomintrange(4000,20000);
	lib_0A1A::func_2330(param_01,"dying_back_crawl_done");
}

//Function Number: 16
func_CF06(param_00,param_01,param_02,param_03)
{
	self method_8306();
	lib_0A1E::func_2368(param_00,param_01,param_02,::func_8977);
}

//Function Number: 17
func_CF07(param_00,param_01,param_02,param_03)
{
	thread func_D899();
	self method_8306();
	lib_0A1E::func_2368(param_00,param_01,param_02,::func_8977);
}

//Function Number: 18
func_CF29(param_00,param_01,param_02,param_03)
{
	self endon(param_01 + "_finished");
	func_FA8D(param_01,param_02);
	for(;;)
	{
		var_04 = lib_0A1E::func_2336(param_00,param_01);
		lib_0A1E::func_2369(param_00,param_01,var_04);
		self method_82E7(param_01,var_04,1,param_02,1);
		var_05 = var_04;
		var_06 = lib_0A1E::func_2322(param_00,param_01,::func_8977);
		if(var_06 == "end")
		{
			if(!lib_0A1A::func_232B(param_01,"end"))
			{
				lib_0A1A::func_2330(param_01,"end");
			}

			thread lib_0A1A::func_2310(param_00,param_01,0);
		}
	}
}

//Function Number: 19
func_CF28(param_00,param_01,param_02,param_03)
{
	self endon(param_01 + "_finished");
	self.var_1491.var_BF88 = gettime() + randomintrange(500,1000);
	func_FA8D(param_01,param_02);
	var_04 = undefined;
	for(;;)
	{
		var_05 = lib_0A1E::func_2336(param_00,param_01);
		if(!isdefined(var_04) || var_05 != var_04)
		{
			self method_82E7(param_01,var_05,1,param_02,1);
			var_04 = var_05;
		}

		lib_0A1E::func_2369(param_00,param_01,var_05);
		var_04 = var_05;
		lib_0A1E::func_2320(param_00,param_01,var_05,lib_0A1A::func_2341(param_00,param_01));
	}
}

//Function Number: 20
func_D540(param_00,param_01,param_02,param_03)
{
	thread func_D899();
	self method_8306();
	lib_0A1E::func_2364(param_00,param_01,param_02);
}

//Function Number: 21
func_D541(param_00,param_01,param_02,param_03)
{
	self endon(param_01 + "_finished");
	var_04 = lib_0A1E::func_2336(param_00,param_01);
	var_05 = "stumbling_pain_collapse_death";
	var_06 = lib_0A1E::func_2336(param_00,var_05);
	if(!isdefined(var_04))
	{
		var_04 = lib_0A1E::func_2336(param_00,param_01);
	}

	var_07 = getmovedelta(var_06);
	var_08 = randomintrange(1,3);
	self method_806F(lib_0A1E::func_2339(),param_02);
	self method_82E7(param_01,var_04,1,param_02,1);
	lib_0A1E::func_2369(param_00,param_01,var_04);
	while(var_08 > 0)
	{
		var_09 = self method_81E7(var_07);
		if(!self method_8200(var_09))
		{
			break;
		}

		for(;;)
		{
			var_0A = lib_0A1E::func_231F(param_00,param_01,lib_0A1A::func_2341(param_00,param_01));
			if(var_0A == "code_move")
			{
				break;
			}
		}

		var_08--;
	}

	lib_0A1A::func_2330(param_01,"pain_wander_done");
}

//Function Number: 22
func_8BD5(param_00,param_01,param_02,param_03)
{
	if(isdefined(self.var_9DD2) && self.var_9DD2)
	{
		return 1;
	}

	return 0;
}

//Function Number: 23
func_10013(param_00,param_01,param_02,param_03)
{
	if(isdefined(self.var_9DD2) && self.var_9DD2)
	{
		return 0;
	}

	if(func_9DD8(anglestoforward(self.angles) * -1))
	{
		return 1;
	}

	return 0;
}

//Function Number: 24
func_10001(param_00,param_01,param_02,param_03)
{
	if(!func_9DD8(anglestoforward(self.angles)))
	{
		return 1;
	}

	if(isdefined(self.var_9DD2) && self.var_9DD2)
	{
		return 1;
	}

	if(isdefined(self.var_527E))
	{
		return gettime() > self.var_527E;
	}

	return 0;
}

//Function Number: 25
func_FFC1(param_00,param_01,param_02,param_03)
{
	lib_0A1E::func_2336(param_00,param_02);
	if(!isdefined(self.var_1491.var_4876))
	{
		return 0;
	}

	if(!func_9D9D(self.var_1491.var_4876))
	{
		self.var_1491.var_4876 = undefined;
		return 0;
	}

	return 1;
}

//Function Number: 26
func_FFE5(param_00,param_01,param_02,param_03)
{
	if(self.var_1491.var_55FC || self.var_EF || self.var_E0)
	{
		return 0;
	}

	if(self.var_2C0 != "none")
	{
		return 0;
	}

	if(isdefined(self.var_1491.var_C4C8))
	{
		return 0;
	}

	if(isdefined(self.var_4E46))
	{
		return 0;
	}

	if(scripts\anim\utility_common::func_9FCA())
	{
		return 0;
	}

	if(scripts\common\utility::func_4D59("head","helmet","gun","right_hand","left_hand"))
	{
		return 0;
	}

	self.var_AB5A = scripts\common\utility::func_4D59("left_leg_upper","left_leg_lower","right_leg_upper","right_leg_lower","left_foot","right_foot");
	var_04 = getdvarint("scr_forceLongDeath",0);
	if(var_04 != 0)
	{
		self.var_72CC = var_04;
	}

	if(isdefined(self.var_72CC) && self.var_72CC > 1)
	{
		return 1;
	}

	if(self.var_AB5A && self.health < self.maxhealth * 0.4)
	{
		if(gettime() < level.var_BF78)
		{
			return 0;
		}
	}
	else
	{
		if(level.var_C222 > 0)
		{
			return 0;
		}

		if(gettime() < level.var_BF77)
		{
			return 0;
		}
	}

	foreach(var_06 in level.players)
	{
		if(distancesquared(self.origin,var_06.origin) < 30625)
		{
			return 0;
		}
	}

	return 1;
}

//Function Number: 27
func_FFC3(param_00)
{
	if(self.var_1491.var_D6A5 != "stand")
	{
		return 0;
	}

	var_01 = 20;
	if(isdefined(self.var_72CC))
	{
		switch(self.var_72CC)
		{
			case 2:
				var_01 = 100;
				break;

			case 4:
			case 3:
				return 0;
		}
	}

	if(randomint(100) > var_01)
	{
		return 0;
	}

	var_02 = 0;
	if(!param_00)
	{
		var_02 = scripts\common\utility::func_4D59("torso_upper","torso_lower");
		if(!var_02)
		{
			return 0;
		}
	}

	var_03 = 0;
	var_04 = "leg";
	var_05 = "b";
	if(param_00)
	{
		var_03 = 200;
	}
	else
	{
		var_04 = "gut";
		var_03 = 128;
		if(45 < self.var_E3 && self.var_E3 < 135)
		{
			var_05 = "l";
		}
		else if(-135 < self.var_E3 && self.var_E3 < -45)
		{
			var_05 = "r";
		}
		else if(-45 < self.var_E3 && self.var_E3 < 45)
		{
			return 0;
		}
	}

	switch(var_05)
	{
		case "b":
			var_06 = anglestoforward(self.angles);
			var_07 = self.origin - var_06 * var_03;
			break;

		case "l":
			var_08 = anglestoright(self.angles);
			var_07 = self.origin - var_08 * var_03;
			break;

		case "r":
			var_08 = anglestoright(self.angles);
			var_07 = self.origin + var_08 * var_03;
			break;

		default:
			return 0;
	}

	if(!isdefined(self.var_72CC) || self.var_72CC != 2)
	{
		if(!self method_8200(var_07))
		{
			return 0;
		}
	}

	return 1;
}

//Function Number: 28
func_FFFB(param_00,param_01,param_02,param_03)
{
	if(func_FFC3(self.var_AB5A))
	{
		return 1;
	}

	return 0;
}

//Function Number: 29
func_FFE9(param_00,param_01,param_02,param_03)
{
	if(!func_9DD8(anglestoforward(self.angles)))
	{
		return 0;
	}

	if(func_FFC1(param_00,param_01,param_02,param_03))
	{
		return 1;
	}

	return 0;
}

//Function Number: 30
func_FFEA(param_00,param_01,param_02,param_03)
{
	if(self.var_1491.var_D6A5 == "prone")
	{
		return 0;
	}

	if(isdefined(self.var_72CC))
	{
		if(self.var_72CC == 2 || self.var_72CC == 3)
		{
			return 1;
		}

		if(self.var_72CC > 3)
		{
			return 0;
		}
	}

	if(self.var_1491.var_BCC8 == "stop")
	{
		if(randomint(100) > 20)
		{
			return 0;
		}
		else if(abs(self.var_E3) > 90)
		{
			return 0;
		}
	}
	else if(abs(self method_813E()) > 90)
	{
		return 0;
	}

	return func_FFC1(param_00,param_01,param_02,param_03);
}

//Function Number: 31
func_FFEC(param_00,param_01,param_02,param_03)
{
	if(isdefined(self.var_72CC) && self.var_72CC == 4)
	{
		return 1;
	}

	if(self.var_1491.var_D6A5 == "prone")
	{
		return 1;
	}

	if(self.var_1491.var_BCC8 == "stop")
	{
		if(randomint(100) <= 20)
		{
			return 1;
		}
		else if(abs(self.var_E3) > 90)
		{
			return 1;
		}
	}
	else if(abs(self method_813E()) > 90)
	{
		return 1;
	}

	if(self.var_1491.var_D6A5 != "prone")
	{
		var_04 = lib_0A1E::func_2336(param_00,param_02);
		if(!func_9D9D(var_04))
		{
			return 0;
		}
	}

	return 1;
}

//Function Number: 32
func_AFE6(param_00,param_01,param_02,param_03)
{
	if(isdefined(self.var_1491.var_BF88))
	{
		if(gettime() < self.var_1491.var_BF88)
		{
			return 0;
		}
	}

	if(!isdefined(self.var_10C))
	{
		return 0;
	}

	if(!scripts\anim\utility_common::func_3907())
	{
		return 0;
	}

	if(!func_9D2F())
	{
		return 0;
	}

	return 1;
}

//Function Number: 33
func_582C(param_00,param_01,param_02,param_03)
{
	if(!lib_0A1A::func_2346(param_02,self.var_1491.var_11186))
	{
		return 0;
	}

	var_04 = lib_0A1E::func_2356(param_02,self.var_1491.var_11186);
	if(!isdefined(var_04) || !isarray(var_04))
	{
		return 0;
	}

	if(var_04.size <= self.var_1491.var_11187)
	{
		return 0;
	}

	return 1;
}