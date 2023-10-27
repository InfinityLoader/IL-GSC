/*******************************************************************
 * Decompiled By: Bog
 * Decompiled File: 1340.gsc
 * Game: Call of Duty: WWII
 * Platform: PC
 * Function Count: 58
 * Decompile Time: 74 ms
 * Timestamp: 10/27/2023 3:25:26 AM
*******************************************************************/

//Function Number: 1
func_4F84()
{
	if(self.var_CA)
	{
		return 0;
	}

	if(common_scripts\utility::func_562E(self.var_1723))
	{
		return 0;
	}

	if(!isdefined(self.var_28D2))
	{
		return 0;
	}

	if(self.var_BA4 == "melee" || maps/mp/agents/_scripted_agent_anim_util::func_57E2())
	{
		return 0;
	}

	if(!lib_0547::func_4B2C())
	{
		return 0;
	}

	if(maps/mp/agents/humanoid/_humanoid::func_A7F8())
	{
		return 0;
	}

	if(maps/mp/agents/humanoid/_humanoid::func_2EE6())
	{
		return 0;
	}

	var_00 = common_scripts\utility::func_562E(self.var_5F4C) && isdefined(self.var_5F48) && gettime() - self.var_5F48 <= self.var_5F46;
	if(maps/mp/agents/humanoid/_humanoid::func_2EE5() || var_00)
	{
		if(!maps/mp/agents/humanoid/_humanoid::func_7AC0("base"))
		{
			return 0;
		}
	}
	else if(!maps/mp/agents/humanoid/_humanoid::func_7AC0("normal"))
	{
		return 0;
	}

	if(isdefined(self.var_60E4) && isdefined(self.var_5BC0))
	{
		var_01 = gettime() - self.var_5BC0;
		if(var_01 < self.var_60E4 * 1000)
		{
			return 0;
		}
	}

	if(!isdefined(self.var_5BC1) || distancesquared(self.var_5BC1,self.var_116) > 256)
	{
		self.var_60ED = self.var_108;
	}

	if(isdefined(self.custom_on_melee_func))
	{
		self thread [[ self.custom_on_melee_func ]]();
	}

	self method_83A1(self.var_28D2);
	return 1;
}

//Function Number: 2
func_0631()
{
	if(isdefined(self.var_6618))
	{
		return self.var_6618;
	}

	return self method_8396();
}

//Function Number: 3
func_06CE(param_00)
{
	self.var_6618 = param_00;
	self notify("new_navigation_goal");
	var_01 = 1500;
	var_02 = gettime();
	var_03 = self.var_AAF3;
	var_04 = isdefined(var_03) && var_02 - var_03 < var_01;
	var_05 = !isdefined(self.var_A08E) || var_04;
	var_06 = undefined;
	if(!var_05)
	{
		var_07 = gettraversalsonpath(self.var_116,self.var_6618,self);
		self.var_AAF3 = var_02;
		if(isdefined(var_07))
		{
			foreach(var_09 in var_07)
			{
				if(lib_0549::func_553A(var_09))
				{
					var_06 = var_09;
					break;
				}
			}
		}
	}

	var_0B = isdefined(var_06) && isdefined(self.var_A08E) && isdefined(var_06.var_15CB) && var_06.var_15CB == self.var_A08E.var_15CB;
	if(!var_04 || var_0B)
	{
		if(isdefined(self.var_A08E))
		{
			self.var_6617 = 1;
		}

		self method_8395(self.var_6618);
	}
}

//Function Number: 4
func_0778()
{
	self endon("death");
	childthread func_0779();
	childthread func_077A();
	func_8A62(0);
	for(;;)
	{
		self waittill("traverse_soon");
		var_00 = self method_8198();
		if(isdefined(var_00))
		{
			thread func_077B(var_00);
		}

		if(isdefined(var_00) && !isdefined(self.var_A08E))
		{
			for(;;)
			{
				if(isdefined(var_00.var_54F5) && var_00.var_54F5)
				{
					if(isdefined(var_00.var_A228) && var_00.var_A228 != self)
					{
						if(!func_584A())
						{
							thread func_21B5(var_00);
							common_scripts\utility::knock_off_battery("traversal_unblocked");
							func_8A62(0);
						}

						break;
					}
					else if(isdefined(var_00.var_A228) && var_00.var_A228 == self)
					{
						break;
					}
				}

				wait 0.05;
			}
		}
	}
}

//Function Number: 5
func_21B5(param_00)
{
	self endon("death");
	for(;;)
	{
		var_01 = gettraversalsonpath(self.var_116,self.var_6618,self);
		if(var_01.size > 0)
		{
			if((param_00 != var_01[0] || !param_00.var_54F5) && !isdefined(var_01[0].var_54F5) || !var_01[0].var_54F5)
			{
				self method_8395(self.var_6618);
				wait 0.05;
				self notify("traversal_unblocked");
				break;
			}
			else
			{
				func_8A62(1);
				wait(0.5);
			}

			continue;
		}

		wait 0.05;
		self notify("traversal_unblocked");
		break;
	}
}

//Function Number: 6
func_8A62(param_00)
{
	self.var_A6D2 = param_00;
	if(param_00)
	{
		self scragentsetscripted(1);
		maps/mp/agents/_scripted_agent_anim_util::func_8732(1,"Waiting For Traversal");
		var_01 = maps/mp/agents/_scripted_agent_anim_util::func_434D("idle_noncombat");
		var_02 = maps/mp/agents/_scripted_agent_anim_util::func_7A35(var_01);
		var_03 = self method_83D8(var_01,var_02);
		maps/mp/agents/_scripted_agent_anim_util::func_8415(var_01,var_02);
		return;
	}

	maps/mp/agents/_scripted_agent_anim_util::func_8732(0,"Waiting For Traversal");
	self scragentsetscripted(0);
}

//Function Number: 7
func_584A()
{
	return self.var_A6D2;
}

//Function Number: 8
func_077A()
{
	for(;;)
	{
		self waittill("traverse_end");
		self.var_AAF3 = undefined;
	}
}

//Function Number: 9
func_0779()
{
	for(;;)
	{
		self waittill("path_script_blocked",var_00);
		func_0647();
	}
}

//Function Number: 10
func_077B(param_00)
{
	self endon("death");
	self endon("new_navigation_goal");
	self endon("traverse_soon");
	self endon("traverse_complete");
	func_0647();
	for(;;)
	{
		param_00 waittill("barricaded");
		func_0647();
	}
}

//Function Number: 11
func_0647()
{
	var_00 = self method_8198();
	if(!func_5597())
	{
		if(isdefined(var_00) && lib_0547::func_562C(var_00))
		{
			var_01 = 0;
			if(isdefined(self.var_A08E) && var_00.var_15CB != self.var_A08E.var_15CB)
			{
				func_4F85();
				var_01 = 1;
			}
			else if(!isdefined(self.var_A08E))
			{
				var_01 = 1;
			}

			if(var_01)
			{
				self.var_A08E = var_00;
			}
		}
		else if(isdefined(self.var_A08E))
		{
			if(!lib_0547::func_562C(self.var_A08E))
			{
				func_4F85();
				self method_8395(self.var_6618);
				self.var_A08E = undefined;
				self notify("lost_barricaded_traversal");
			}
			else if(common_scripts\utility::func_562E(self.var_6617))
			{
				func_4F85();
				self method_8395(self.var_6618);
				self.var_A08E = undefined;
				self notify("lost_barricaded_traversal");
			}
		}
		else
		{
		}
	}

	if(isdefined(self.var_A08E))
	{
		func_4F8D();
	}
	else if(isdefined(self.var_A08F))
	{
		func_4F8A(self.var_A08F);
	}
	else if(isdefined(self.var_AC08))
	{
		func_4F8B(self.var_AC08);
	}

	self.var_6617 = undefined;
}

//Function Number: 12
func_4F8A(param_00)
{
	self method_8395(param_00);
	while(distance(self.var_116,param_00) > 32)
	{
		wait(0.1);
	}

	self.var_A08F = undefined;
}

//Function Number: 13
func_4F8B(param_00)
{
	param_00 endon("death");
	self endon("death");
	self endon("no_alt_paths");
	var_01 = 0.15;
	var_02 = 1;
	var_03 = 0;
	var_04 = [];
	thread func_298D(param_00);
	while(!isdefined(self.var_AC17) || distance(self.var_116,self.var_AC17) > 8)
	{
		wait(var_01);
		var_03 = var_03 + var_01;
		if(var_03 >= var_02)
		{
			thread func_1436();
			break;
		}
	}

	thread func_1436();
	self notify("out_of_zombie_range");
}

//Function Number: 14
func_298D(param_00)
{
	var_01 = 3;
	self endon("out_of_zombie_range");
	var_02 = 45;
	var_03 = 15;
	var_04 = 96;
	for(var_05 = 0;var_05 < var_01;var_05++)
	{
		if(func_5724(param_00))
		{
			if(func_5769(param_00))
			{
				var_06 = param_00.var_1D + (0,-1 * var_02 + var_03 * var_05,0);
			}
			else
			{
				var_06 = param_00.var_1D + (0,var_02 + var_03 * var_05,0);
			}
		}
		else
		{
			break;
		}

		var_07 = anglestoforward(var_06);
		var_07 = common_scripts\utility::func_3D5D(var_07);
		var_07 = vectornormalize(var_07);
		var_08 = self.var_116 + var_07 * var_04 / var_05 + 1;
		if(var_05 < var_01 - 1)
		{
			var_09 = getclosestpointonnavmesh(var_08,self);
			var_0A = (var_08[0],var_08[1],var_09[2] + 8);
		}
		else
		{
			var_0A = getclosestpointonnavmesh(self.var_116,self);
		}

		self.var_AC17 = var_0A;
		self waittill("bad_path");
	}

	self notify("no_alt_paths");
	if(distance(self.var_116,param_00.var_116) < 32)
	{
		self dodamage(self.var_BC + 666,self.var_116);
	}
}

//Function Number: 15
func_1436()
{
	wait(0.75);
	self.var_AC08 = undefined;
}

//Function Number: 16
func_5724(param_00)
{
	var_01 = anglestoforward(param_00.var_1D + (0,0,0));
	var_01 = common_scripts\utility::func_3D5D(var_01);
	var_01 = vectornormalize(var_01);
	var_02 = param_00.var_116 + 64 * var_01;
	var_01 = anglestoforward(param_00.var_1D + (0,180,0));
	var_01 = common_scripts\utility::func_3D5D(var_01);
	var_01 = vectornormalize(var_01);
	var_03 = param_00.var_116 + 64 * var_01;
	return distance(self.var_116,var_02) < distance(self.var_116,var_03);
}

//Function Number: 17
func_5769(param_00)
{
	var_01 = anglestoforward(param_00.var_1D + (0,-90,0));
	var_01 = common_scripts\utility::func_3D5D(var_01);
	var_01 = vectornormalize(var_01);
	var_02 = param_00.var_116 + 64 * var_01;
	var_01 = anglestoforward(param_00.var_1D + (0,90,0));
	var_01 = common_scripts\utility::func_3D5D(var_01);
	var_01 = vectornormalize(var_01);
	var_03 = param_00.var_116 + 64 * var_01;
	return distance(self.var_116,var_02) < distance(self.var_116,var_03);
}

//Function Number: 18
func_4F9B(param_00)
{
	if(self.var_CA)
	{
		self.var_28D2 = undefined;
		return 0;
	}

	if(common_scripts\utility::func_562E(level.var_3F9D))
	{
		return 0;
	}

	var_01 = undefined;
	if(isdefined(self.var_1928))
	{
		var_01 = self.var_1928;
	}
	else if(isdefined(self.var_1924))
	{
		var_01 = self.var_1924;
	}
	else if(isdefined(level.var_1CC4) && common_scripts\utility::func_562E(self.var_56EB) && func_0C35())
	{
		var_01 = level.var_1CC4;
	}
	else if(func_AB86() && !common_scripts\utility::func_562E(self.has_lost_distractiondrone_interest))
	{
		var_01 = self.var_3043;
	}
	else if(isdefined(self.var_9B61) && !func_5686())
	{
		if(isdefined(self.var_9B61.var_1A2) && !isdefined(self.var_9B61.var_76A3))
		{
			self.var_9B61.var_76A3 = common_scripts\utility::func_46B5(self.var_9B61.var_1A2,"targetname");
		}

		if(isdefined(self.var_9B61.var_76A3) && !common_scripts\utility::func_562E(self.var_4B3B))
		{
			var_01 = self.var_9B61.var_76A3;
			if(distance(self.var_116,self.var_9B61.var_76A3.var_116) < 48)
			{
				self.var_4B3B = 1;
				var_01 = self.var_9B61;
			}
		}
		else
		{
			var_01 = self.var_9B61;
		}
	}
	else if(isdefined(self.var_1927) && !func_5686())
	{
		var_01 = self.var_1927;
	}
	else if(isdefined(self.var_88) && !lib_0547::func_8B95(self.var_88))
	{
		var_01 = self.var_88;
	}

	if(isdefined(var_01))
	{
		var_02 = self.var_11AB + self.var_14F * 2;
		var_03 = var_02 * var_02;
		var_04 = self.var_11AB;
		var_05 = var_04 * var_04;
		self.var_28D2 = var_01;
		var_06 = maps/mp/agents/humanoid/_humanoid::func_457E(var_01);
		var_07 = var_06.var_3771;
		var_08 = distancesquared(var_06.var_116,self.var_116);
		var_09 = distancesquared(var_07,self.var_116);
		var_0A = self.var_173E;
		if(var_09 < squared(self.var_14F) && distancesquared(var_07,var_06.var_116) > squared(self.var_14F))
		{
			var_0A = 1;
			self notify("attack_anim","end");
		}

		if(isdefined(param_00) && param_00)
		{
			if(!var_0A && var_09 > var_03)
			{
				var_0A = 1;
			}
		}
		else if(!var_0A && var_09 > var_03 && var_08 > var_05)
		{
			var_0A = 1;
		}

		if(var_06.var_A266)
		{
			if(!var_0A && var_08 > squared(self.var_2BCA))
			{
				var_0A = 1;
			}

			self method_8399(self.var_2BCA);
		}
		else if(!maps/mp/agents/humanoid/_humanoid_util::func_4BA3(var_01,self.var_60F5))
		{
			self method_8399(self.var_2BCA);
			var_0A = 1;
		}
		else
		{
			self method_8399(var_02);
			if(var_09 <= var_03)
			{
				var_06.var_116 = self.var_116;
				var_0A = 1;
			}
		}

		if(var_0A)
		{
			var_0B = getclosestpointonnavmesh(var_06.var_116,self);
			if(distancesquared(var_0B,var_01.var_116) > distancesquared(var_06.var_116,var_01.var_116))
			{
				var_0B = getclosestpointonnavmesh(var_01.var_116,self);
			}

			if(isdefined(self.override_snapped_point_func) && isplayer(var_01))
			{
				var_0B = [[ self.override_snapped_point_func ]](var_01,var_0B);
			}

			func_06CE(var_0B);
		}

		func_0647();
		return 1;
	}
	else
	{
		if(isdefined(self.var_28D2))
		{
			self.var_173E = 1;
		}

		self.var_28D2 = undefined;
	}

	return 0;
}

//Function Number: 19
func_AB86()
{
	return isdefined(self.var_3043) && maps/mp/agents/humanoid/_humanoid_util::func_8BAE();
}

//Function Number: 20
func_0C35()
{
	var_00 = 0;
	foreach(var_02 in level.var_744A)
	{
		if(common_scripts\utility::func_562E(var_02.var_7414) || var_02.var_5378 || !isalive(var_02))
		{
			var_00++;
		}
	}

	return var_00 == level.var_744A.size;
}

//Function Number: 21
func_5686()
{
	return isdefined(self.var_983C) && self.var_983C.size > 0;
}

//Function Number: 22
humanoid_has_valid_targets(param_00)
{
	if(!common_scripts\utility::func_562E(param_00) && isdefined(self.var_3043) || isdefined(self.var_1928))
	{
		return 1;
	}

	foreach(var_02 in function_02D1())
	{
		if(humanoid_is_valid_target(var_02))
		{
			return 1;
		}
	}

	return 0;
}

//Function Number: 23
humanoid_is_valid_target(param_00)
{
	if(param_00.var_CE || isdefined(param_00.var_117) && param_00.var_117.var_CE)
	{
		return 0;
	}

	if(param_00 method_8541() || isdefined(param_00.var_117) && param_00.var_117 method_8541())
	{
		return 0;
	}

	if(isalliedsentient(self,param_00))
	{
		return 0;
	}

	if(lib_0547::func_8B95(param_00))
	{
		return 0;
	}

	if(!isalive(param_00))
	{
		return 0;
	}

	return 1;
}

//Function Number: 24
func_4F88()
{
	if(isdefined(self.var_3043))
	{
		return [];
	}

	if(isdefined(self.forcedtargets) && isarray(self.forcedtargets) && self.forcedtargets.size > 0)
	{
		var_00 = [];
		self.forcedtargets = common_scripts\utility::func_FA0(self.forcedtargets);
		foreach(var_02 in self.forcedtargets)
		{
			if(function_0279(var_02))
			{
				continue;
			}

			var_00 = common_scripts\utility::func_F6F(var_00,var_02);
		}

		self.forcedtargets = var_00;
		return function_01AC(var_00,self.var_116);
	}

	var_04 = [];
	foreach(var_06 in function_02D1())
	{
		if(humanoid_is_valid_target(var_06))
		{
			var_04[var_04.size] = var_06;
		}
	}

	if(0 == var_04.size)
	{
		return [];
	}

	return function_01AC(var_04,self.var_116);
}

//Function Number: 25
func_4F9A()
{
	if(self.var_CA)
	{
		return 0;
	}

	var_00 = func_4F88();
	if(isdefined(var_00) && var_00.size > 0)
	{
		var_01 = 300;
		var_02 = distancesquared(var_00[0].var_116,self.var_116);
		if(var_02 < var_01 * var_01)
		{
			var_01 = 16;
		}

		if(self.var_173E || distancesquared(self method_8396(),var_00[0].var_116) > var_01 * var_01)
		{
			var_03 = getclosestpointonnavmesh(var_00[0].var_116);
			func_06CE(var_03);
			self.var_173E = 0;
		}

		func_0647();
		return 1;
	}

	return 0;
}

//Function Number: 26
func_4F87(param_00)
{
	if(!isdefined(param_00))
	{
		return 0;
	}

	if(self.var_173E || distancesquared(func_0631(),param_00.var_116) > squared(128))
	{
		func_06CE(param_00.var_116);
		self.var_173E = 0;
	}

	func_0647();
	return 1;
}

//Function Number: 27
func_4F7F(param_00,param_01)
{
	var_02 = 234;
	if(!isdefined(self))
	{
		return;
	}

	self endon("death");
	if(common_scripts\utility::func_562E(self.var_9E1A) || common_scripts\utility::func_562E(level.zmb_fog_passive_lock))
	{
		return;
	}

	if(!common_scripts\utility::func_3794("zombie_passive"))
	{
		return;
	}

	self.var_9E1A = 1;
	if(!isdefined(param_01))
	{
		param_01 = 1;
	}

	if(param_01)
	{
		foreach(var_04 in maps/mp/agents/_agent_utility::func_43FD("all"))
		{
			if(self == var_04)
			{
				continue;
			}

			if(distance(self.var_116,var_04.var_116) < var_02)
			{
				var_04 thread func_4F80();
			}
		}
	}

	if(isdefined(self.var_9024))
	{
		var_06 = level.var_AC80.var_ACB3[self.var_9024];
		var_07 = 10;
		self.passive_activation_time_ms = gettime();
		while(!common_scripts\utility::func_3C77(var_06.var_AC8A))
		{
			if(var_07 <= 0 || !lib_054D::func_F0A(self))
			{
				lib_056D::func_5A86();
			}

			var_08 = randomfloatrange(0.5,1);
			wait(var_08);
			var_07 = var_07 - var_08;
		}

		wait 0.05;
	}

	self.passive_activation_time_ms = gettime();
	common_scripts\utility::func_3796("zombie_passive");
	humanoid_reset_passive_data();
	if(isdefined(self.post_passive_func))
	{
		self thread [[ self.post_passive_func ]]();
	}
}

//Function Number: 28
func_4F80()
{
	self endon("death");
	var_00 = 0.25;
	var_01 = 1;
	wait(randomfloatrange(var_00,var_01));
	func_4F7F("wakeup chain",1);
}

//Function Number: 29
humanoid_passive_register_wakeup_func(param_00)
{
	if(!isdefined(level.passive_check_wakeup_funcs))
	{
		level.passive_check_wakeup_funcs = [];
	}

	level.passive_check_wakeup_funcs[level.passive_check_wakeup_funcs.size] = param_00;
}

//Function Number: 30
humanoid_passive_check_wakeup_threads()
{
	self endon("zombie_no_longer_passive");
	childthread func_4F96();
	childthread func_4F98();
	childthread func_4F97();
	if(isdefined(level.passive_check_wakeup_funcs))
	{
		foreach(var_01 in level.passive_check_wakeup_funcs)
		{
			self childthread [[ var_01 ]]();
		}
	}
}

//Function Number: 31
func_4F95()
{
	self endon("death");
	for(;;)
	{
		common_scripts\utility::func_379C("zombie_passive");
		childthread humanoid_passive_check_wakeup_threads();
		common_scripts\utility::func_37A1("zombie_passive");
		self notify("zombie_no_longer_passive");
	}
}

//Function Number: 32
func_4F96()
{
	for(;;)
	{
		self waittill("damage",var_00,var_01,var_02,var_03,var_04,var_05,var_06,var_07,var_08,var_09);
		if(isplayer(var_01))
		{
			if(lib_0547::func_8B95(var_01) || isdefined(var_09) && issubstr(var_09,"austen_pap_zm"))
			{
				continue;
			}

			self.woken_by_player_aggro = 1;
		}

		break;
	}

	func_4F7F("damaged");
}

//Function Number: 33
func_4F98()
{
	var_00 = 0.5;
	var_01 = int(var_00 * 20);
	for(var_02 = 0;!var_02;var_02 = humanoid_passive_default_should_wakeup_range())
	{
		wait(var_00);
		if(isdefined(level.passive_wakeup_range_func))
		{
			var_02 = self [[ level.passive_wakeup_range_func ]]();
			continue;
		}
	}

	func_4F7F("player close");
}

//Function Number: 34
humanoid_passive_default_should_wakeup_range()
{
	var_00 = 234;
	var_01 = var_00;
	if(isdefined(self.var_6EB0))
	{
		var_01 = self.var_6EB0;
	}

	var_02 = 0.5;
	var_03 = int(var_02 * 20);
	var_04 = func_4F88()[0];
	if(!isdefined(var_04))
	{
		return 0;
	}

	var_05 = distance(self.var_116,var_04.var_116);
	if(var_05 > var_01)
	{
		return 0;
	}

	return 1;
}

//Function Number: 35
func_4F97()
{
	var_00 = self.var_66AC;
	if(isdefined(var_00))
	{
		wait(var_00);
		while(!humanoid_has_valid_targets(1))
		{
			wait(1);
		}

		func_4F7F("passive time max: " + maps\mp\_utility::func_5D7F(var_00));
		self.var_66AC = undefined;
	}
}

//Function Number: 36
func_2208()
{
	var_00 = 390;
	var_01 = 78;
	var_02 = 64;
	var_03 = 0;
	var_04 = self.var_37BB;
	var_05 = maps/mp/agents/_agent_utility::func_43FD("all");
	for(;;)
	{
		var_04 = getrandomnavpoint(var_04,var_00);
		var_06 = 0;
		foreach(var_08 in var_05)
		{
			if(var_08 == self)
			{
				continue;
			}

			if(isdefined(var_08.var_6EAE) && distance(var_08.var_6EAE,var_04) < var_02)
			{
				var_06 = 1;
				break;
			}

			if(isdefined(var_08.var_37BB) && distance(var_08.var_37BB,var_04) < var_01)
			{
				var_06 = 1;
				break;
			}
		}

		if(!var_06)
		{
			break;
		}

		var_03++;
		if(var_03 > 10)
		{
			var_03 = 0;
			wait 0.05;
		}
	}

	return var_04;
}

//Function Number: 37
func_9C74()
{
	self.var_6EAF = "idle";
	self scragentsetscripted(1);
	if(isdefined(self.custom_passive_action))
	{
		[[ self.custom_passive_action ]]();
	}
	else
	{
		maps/mp/agents/_scripted_agent_anim_util::func_8410("idle_noncombat");
	}

	self.var_6EAE = self.var_116;
	self method_855C();
}

//Function Number: 38
func_4F8C()
{
	var_00 = 8;
	if(common_scripts\utility::func_3794("zombie_passive"))
	{
		if(!isdefined(self.var_6EAF))
		{
			self.woken_by_player_aggro = undefined;
			if(common_scripts\utility::func_562E(self.var_47F1))
			{
				self.var_47F1 = 0;
				func_9C74();
			}
			else
			{
				self.var_6EAF = "leaving_spawn_closet";
				if(!lib_0547::func_4B2C() && isdefined(self.var_9024))
				{
					func_06CE(level.var_AC80.var_ACB3[self.var_9024].var_74DC);
				}
			}
		}

		if(self.var_6EAF == "leaving_spawn_closet" && lib_0547::func_4B2C())
		{
			self.var_6EAF = "searching_for_goal";
			self.var_6EAE = func_2208();
			if(!common_scripts\utility::func_3794("zombie_passive"))
			{
				return 1;
			}

			self.var_6EAF = "pathing_to_goal";
			func_06CE(self.var_6EAE);
		}

		if(self.var_6EAF == "pathing_to_goal" && lib_0547::func_2436(self.var_6EAE,self.var_116,var_00,32))
		{
			func_9C74();
		}

		func_0647();
		return 1;
	}

	if(isdefined(self.var_6EAF))
	{
		humanoid_reset_passive_data();
	}

	return 0;
}

//Function Number: 39
humanoid_reset_passive_data()
{
	if(isdefined(self.var_6EAF))
	{
		if(self.var_6EAF == "idle" && !maps/mp/agents/_scripted_agent_anim_util::func_57E2())
		{
			self scragentsetscripted(0);
		}

		self.var_6EAF = undefined;
	}

	self.var_9E1A = undefined;
	self.var_A7A8 = undefined;
}

//Function Number: 40
func_635C()
{
	self endon("death");
	for(;;)
	{
		var_00 = func_4F88();
		var_01 = var_00.size > 0;
		var_02 = isdefined(self.var_3043) || isdefined(self.var_1927) || isdefined(self.var_9B61) || func_5686();
		if(common_scripts\utility::func_3794("zombie_passive"))
		{
			if((common_scripts\utility::func_562E(self.var_A7A8) && var_01) || var_02)
			{
				func_4F7F("target point available");
			}
		}
		else if(!var_01 && !var_02 && !is_passive_exempt())
		{
			common_scripts\utility::func_379A("zombie_passive");
			self.var_A7A8 = 1;
		}

		wait(0.5);
	}
}

//Function Number: 41
is_passive_exempt()
{
	return (isdefined(level.zmb_exempt_from_passive_list) && common_scripts\utility::func_F79(level.zmb_exempt_from_passive_list,self.var_A4B)) || common_scripts\utility::func_562E(self.ispassiveexempt);
}

//Function Number: 42
func_4F8D()
{
	if(!isdefined(self.var_9D04))
	{
		if(self.var_BA4 != "traverse" && lib_0547::func_4B24())
		{
			self.var_9D04 = 0;
		}
		else
		{
			self.var_9D04 = undefined;
			return 0;
		}
	}

	if(common_scripts\utility::func_562E(self.var_6617))
	{
		if(isdefined(self.var_2308))
		{
			self method_8395(self.var_2308.var_116);
		}
		else if(isdefined(self.var_A6E6))
		{
			self method_8395(self.var_A6E6);
		}
	}

	switch(self.var_9D04)
	{
		case 0:
			if(!lib_0547::func_4B24())
			{
				func_4F85();
				return 0;
			}
	
			var_00 = self.var_A08E.var_15CB;
			var_01 = var_00 lib_0549::func_15DB(self);
			if(isdefined(var_01))
			{
				self method_8395(var_01.var_116);
				self.var_9D04 = 1;
				return 1;
			}
			else
			{
				if(isdefined(self.var_A6E6))
				{
					return 1;
				}
	
				self.var_A6E6 = var_00 lib_0549::func_15DE();
				self method_8395(self.var_A6E6);
				return 1;
			}
	
			break;

		case 1:
			if(!lib_0547::func_4B24())
			{
				func_4F85();
				return 0;
			}
	
			var_02 = self method_8396();
			if(distancesquared(var_02,self.var_2308.var_116) > 1024)
			{
				self method_8395(self.var_2308.var_116);
			}
	
			var_03 = self.var_14F * self.var_14F;
			var_04 = distance2dsquared(self.var_116,self.var_2308.var_116);
			if(var_04 > var_03)
			{
				return 1;
			}
			return func_4F81();

		case 3:
			if(isdefined(self.var_15D2))
			{
				return 1;
			}
			return func_4F81();

		case 5:
			if(common_scripts\utility::func_562E(self.var_983D))
			{
				return 1;
			}
			return func_4F81();
	}

	return 0;
}

//Function Number: 43
func_4F85()
{
	if(isdefined(self.var_9D04))
	{
		var_00 = self.var_A08E.var_15CB;
		switch(self.var_9D04)
		{
			case 0:
				self.var_A6E6 = undefined;
				break;

			case 3:
				if(isdefined(var_00.var_15D9))
				{
					var_01 = level.var_AAEF[var_00.var_15D9];
					if(isdefined(var_01))
					{
						self [[ var_01 ]](var_00);
					}
				}
	
				var_00 lib_0549::func_15DF(self);
				break;

			case 1:
				var_00 lib_0549::func_15DF(self);
				break;

			case 5:
				var_00 lib_0549::func_15DF(self);
				break;
		}

		self.var_9D04 = undefined;
	}
}

//Function Number: 44
func_4F81()
{
	var_00 = self.var_A08E.var_15CB;
	if(!lib_0547::func_4B24())
	{
		func_4F85();
		return 0;
	}

	if(isdefined(var_00.var_15D9))
	{
		var_01 = level.var_AAF0[var_00.var_15D9];
		if(isdefined(var_01))
		{
			var_02 = self [[ var_01 ]](var_00);
			if(common_scripts\utility::func_562E(var_02))
			{
				return 1;
			}
		}
	}

	thread func_4F9C();
	return 1;
}

//Function Number: 45
func_4F99(param_00,param_01)
{
	self endon("board_pull_interrupted");
	self.var_9D04 = 3;
	self.var_15D2 = "pulling_board";
	self scragentsetscripted(1);
	self method_839D("noclip");
	func_1888("grab");
	func_1888("hold");
	param_00 thread lib_0549::func_15D3(param_01.var_1887);
	func_1888("pull");
	self.var_15D2 = undefined;
	self scragentsetscripted(0);
	self method_839D("gravity");
	param_00 lib_0549::func_15E0(self);
}

//Function Number: 46
func_1888(param_00)
{
	var_01 = "board_" + self.var_2308.var_EA5 + "_" + param_00;
	var_02 = maps/mp/agents/_scripted_agent_anim_util::func_434D(var_01);
	var_03 = self.var_2309.var_1887;
	self method_839C("anim deltas");
	self scragentsetorientmode("face angle abs",self.var_2308.var_1D);
	maps/mp/agents/_scripted_agent_anim_util::func_71FA(var_02,var_03,1,"board_pull");
}

//Function Number: 47
func_4F89()
{
	var_00 = self.var_A08E.var_15CB;
	var_01 = var_00 lib_0549::func_15DD(self);
	return var_01;
}

//Function Number: 48
func_4F83(param_00)
{
	self endon("death");
	self.var_9D04 = 3;
	self.var_15D2 = "attacking_through_boards";
	var_01 = self.var_A08E.var_15CB;
	var_02 = var_01.var_38EB.var_1D;
	self scragentsetorientmode("face angle abs",var_02);
	var_03 = "attack_stand";
	var_04 = maps/mp/agents/_scripted_agent_anim_util::func_434D(var_03);
	var_05 = maps/mp/agents/_scripted_agent_anim_util::func_7A35(var_04);
	self.var_117A = param_00;
	self scragentsetscripted(1);
	maps/mp/agents/_scripted_agent_anim_util::func_71FA(var_04,var_05,1,"attack_anim",undefined,::func_1179);
	self scragentsetscripted(0);
	self.var_15D2 = undefined;
}

//Function Number: 49
func_1179(param_00,param_01,param_02,param_03)
{
	if(isdefined(self.var_117A) && isalive(self.var_117A))
	{
		switch(param_00)
		{
			case "zombie_melee":
				var_04 = self.var_117A.var_BC;
				if(isdefined(self.var_60E2))
				{
					var_04 = self.var_60E2;
				}
	
				maps/mp/agents/humanoid/_humanoid_melee::func_3210(self.var_117A,var_04,"MOD_IMPACT");
				self.var_117A = undefined;
				break;
		}
	}
}

//Function Number: 50
func_4F92(param_00)
{
	self endon("drop_gate_interact_interrupt");
	var_01 = param_00.var_15CC;
	self.var_9D04 = 3;
	self.var_15D2 = "lifting_gj_gate";
	self scragentsetscripted(1);
	self method_839D("noclip");
	func_4F93(param_00);
	while(var_01.var_17E9)
	{
		if(common_scripts\utility::func_562E(var_01.var_5CCB))
		{
			func_346C("lift",param_00,"gate_state_changed",var_01);
			continue;
		}

		thread lib_0549::func_346E(var_01);
		func_346C("idle",param_00,"pull_state_change",var_01);
		lib_0549::func_346D(var_01);
		waittillframeend;
	}

	self scragentsetscripted(0);
	self method_839D("gravity");
	self.var_15D2 = undefined;
}

//Function Number: 51
func_4F86(param_00)
{
	self endon("drop_gate_interact_interrupt");
	var_01 = param_00.var_15CC;
	self.var_9D04 = 3;
	self.var_15D2 = "crawling_under_gj_gate";
	self scragentsetscripted(1);
	self method_839D("noclip");
	var_02 = maps/mp/agents/_scripted_agent_anim_util::func_434D("gj_lift_gate_crawl_under");
	var_03 = maps/mp/agents/_scripted_agent_anim_util::func_7A35(var_02);
	var_04 = self method_83D8(var_02,var_03);
	self method_839C("anim deltas");
	self scragentsetorientmode("face angle abs",self.var_2308.var_1D);
	self method_8395(self.var_6618);
	maps/mp/agents/_scripted_agent_anim_util::func_71FA(var_02,var_03,1,"gj_gate_drop");
	thread func_4F85();
}

//Function Number: 52
func_4F93(param_00)
{
	var_01 = param_00.var_15CC;
	if(var_01 lib_0549::func_3463())
	{
		func_346C("mount",param_00,"pull_state_change",var_01);
	}
}

//Function Number: 53
func_346C(param_00,param_01,param_02,param_03)
{
	if(isdefined(param_02))
	{
		param_03 endon(param_02);
	}

	var_04 = param_01.var_15CC;
	param_00 = var_04 lib_0549::func_345B(self,param_00);
	var_05 = maps/mp/agents/_scripted_agent_anim_util::func_434D(param_00);
	var_06 = maps/mp/agents/_scripted_agent_anim_util::func_7A35(var_05);
	var_07 = self method_83D8(var_05,var_06);
	var_08 = undefined;
	if(animhasnotetrack(var_07,"end_start"))
	{
		var_09 = maps/mp/agents/_scripted_agent_anim_util::func_45B9(var_07,"end_start");
		var_08 = 1 - var_09 * getanimlength(var_07);
		var_08 = randomfloatrange(0,var_08);
	}

	var_0A = getstartorigin(param_01.var_8310,param_01.var_830F,var_07);
	var_0B = getstartangles(param_01.var_8310,param_01.var_830F,var_07);
	self setorigin(var_0A,0);
	self method_839C("anim deltas");
	self scragentsetorientmode("face angle abs",var_0B);
	maps/mp/agents/_scripted_agent_anim_util::func_71FA(var_05,var_06,1,"gj_gate_drop","end_start");
	if(isdefined(var_08))
	{
		wait(var_08);
	}
}

//Function Number: 54
func_4F9C()
{
	self endon("death");
	var_00 = "board_taunt";
	var_01 = maps/mp/agents/_scripted_agent_anim_util::func_434D(var_00);
	var_02 = maps/mp/agents/_scripted_agent_anim_util::func_7A35(var_01);
	self.var_9D04 = 5;
	self.var_983D = 1;
	self method_839C("anim deltas");
	self scragentsetorientmode("face angle abs",self.var_2308.var_1D);
	self scragentsetscripted(1);
	maps/mp/agents/_scripted_agent_anim_util::func_71FA(var_01,var_02,1,"taunt_anim");
	self scragentsetscripted(0);
	self.var_983D = undefined;
}

//Function Number: 55
func_4F82()
{
	self endon("death");
	var_00 = "attack_stand";
	var_01 = maps/mp/agents/_scripted_agent_anim_util::func_434D(var_00);
	var_02 = maps/mp/agents/_scripted_agent_anim_util::func_7A35(var_01);
	self method_839C("anim deltas");
	self scragentsetorientmode("face angle abs",self.var_2308.var_1D);
	self scragentsetscripted(1);
	self.var_567F = 1;
	maps/mp/agents/_scripted_agent_anim_util::func_71FA(var_01,var_02,1,"attack_anim");
	self.var_567F = 0;
	self scragentsetscripted(0);
}

//Function Number: 56
func_5597()
{
	if(isdefined(self.var_9D04))
	{
		switch(self.var_9D04)
		{
			case 1:
			case 0:
				return 0;

			case 5:
			case 3:
				return 1;
		}
	}

	return 0;
}

//Function Number: 57
func_4F94(param_00)
{
	func_4F85();
}

//Function Number: 58
func_6AA4(param_00,param_01,param_02,param_03,param_04,param_05,param_06,param_07,param_08)
{
	func_4F85();
}