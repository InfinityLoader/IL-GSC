/*******************************************************************
 * Decompiled By: Bog
 * Decompiled File: maps\mp\agents\humanoid\_humanoid_move.gsc
 * Game: Call of Duty: WWII
 * Platform: PC
 * Function Count: 27
 * Decompile Time: 475 ms
 * Timestamp: 10/27/2023 3:08:41 AM
*******************************************************************/

//Function Number: 1
func_00F9()
{
	self endon("killanimscript");
	self method_839D("gravity");
	self.var_5759 = 1;
	func_92E9();
	func_2603();
}

//Function Number: 2
func_0085()
{
	self.var_5759 = undefined;
	func_1F39(undefined);
	self method_839A(1,1);
}

//Function Number: 3
func_8A30()
{
	thread func_A6C2();
	thread func_A6D6();
	thread func_A6C7();
	thread func_A69C();
	thread func_A6A9();
}

//Function Number: 4
func_2603()
{
	self notify("humanoidmove_endwait_continuemovement");
	self endon("humanoidmove_endwait_continuemovement");
	self endon("killanimscript");
	func_8A30();
	func_86CF(self.var_108);
	if(isdefined(self.var_9D0C) && self.var_9D0C - gettime() <= 50)
	{
		wait(self.var_9D0B + 0.05);
	}

	self method_839C("code_move");
	self scragentsetorientmode("face motion");
	self method_839A(1,1);
}

//Function Number: 5
func_0E19(param_00)
{
	if(isdefined(self.var_6481))
	{
		var_01 = self method_83DB(param_00);
		return int(clamp(self.var_6481 * var_01,0,var_01 - 1));
	}

	return maps/mp/agents/_scripted_agent_anim_util::func_7A35(var_01);
}

//Function Number: 6
func_86CF(param_00)
{
	self notify("humanoidmove_endwait_setmoveanim");
	self endon("humanoidmove_endwait_setmoveanim");
	self endon("killanimscript");
	self.var_5382 = 0;
	self.var_54F4 = 0;
	var_01 = maps/mp/agents/_scripted_agent_anim_util::func_434D(param_00);
	var_02 = func_0E19(var_01);
	maps/mp/agents/_scripted_agent_anim_util::func_8415(var_01,var_02,self.var_64C2);
}

//Function Number: 7
is_passive_exempt()
{
	return (isdefined(level.zmb_exempt_from_passive_list) && common_scripts\utility::func_F79(level.zmb_exempt_from_passive_list,self.var_A4B)) || common_scripts\utility::func_562E(self.ispassiveexempt);
}

//Function Number: 8
func_86D0(param_00,param_01,param_02)
{
	self notify("humanoidmove_endwait_setmoveanim");
	self endon("humanoidmove_endwait_setmoveanim");
	self endon("killanimscript");
	if(maps/mp/agents/humanoid/_humanoid_util::func_56BC())
	{
		return;
	}

	var_03 = "pain_" + self.var_108;
	if(param_02)
	{
		var_03 = var_03 + "_lower";
	}

	var_04 = maps/mp/agents/_scripted_agent_anim_util::func_434D(var_03);
	var_05 = angleclamp180(param_00 - self.var_1D[1]);
	var_06 = self method_83DB(var_04);
	var_07 = maps/mp/agents/humanoid/_humanoid_util::func_45F8(var_05,var_06);
	self.var_5382 = 1;
	self method_839C("code_move");
	self scragentsetorientmode("face motion");
	self method_839A(1,1);
	var_08 = self.var_64C2;
	if(self.var_108 == "walk")
	{
		var_08 = var_08 - 0.2;
	}
	else if(self.var_108 == "run")
	{
		var_08 = var_08 - 0.1;
	}

	var_08 = max(var_08,0.01);
	maps/mp/agents/_scripted_agent_anim_util::func_71FA(var_04,var_07,var_08,"pain_anim");
	thread func_2603();
}

//Function Number: 9
func_A6C2()
{
	self notify("humanoidmove_endwait_modechange");
	self endon("humanoidmove_endwait_modechange");
	self endon("killanimscript");
	var_00 = self.var_108;
	var_01 = self.var_64C2;
	var_02 = common_scripts\utility::func_3794("zombie_passive");
	for(;;)
	{
		var_03 = 0;
		if(isdefined(self.var_108) && !isdefined(var_00) || var_00 != self.var_108)
		{
			var_03 = 1;
		}

		if(isdefined(self.var_64C2) && !isdefined(var_01) || var_01 != self.var_64C2)
		{
			var_03 = 1;
		}

		var_04 = common_scripts\utility::func_3794("zombie_passive");
		if(var_02 != var_04)
		{
			var_03 = 1;
		}

		if(var_03)
		{
			thread func_86CF(self.var_108);
			var_00 = self.var_108;
			var_01 = self.var_64C2;
			var_02 = var_04;
		}

		wait 0.05;
	}
}

//Function Number: 10
func_32B8(param_00)
{
	self notify("humanoidmove_DoTurn");
	self endon("humanoidmove_DoTurn");
	self endon("killanimscript");
	func_1F39("");
	self.var_54F4 = 1;
	self method_839C(param_00.var_EC3);
	if(isdefined(param_00.var_6C39))
	{
		self scragentsetorientmode(param_00.var_6C37,param_00.var_6C38,param_00.var_6C39);
	}
	else if(isdefined(param_00.var_6C38))
	{
		self scragentsetorientmode(param_00.var_6C37,param_00.var_6C38);
	}
	else
	{
		self scragentsetorientmode(param_00.var_6C37);
	}

	maps/mp/agents/_scripted_agent_anim_util::func_71FA(param_00.var_EE8,param_00.var_EC1,self.var_64C2,"turn");
	thread func_2603();
}

//Function Number: 11
func_220E(param_00,param_01,param_02)
{
	var_03 = maps/mp/agents/_scripted_agent_anim_util::func_87C(param_00,param_01);
	if(!isdefined(var_03))
	{
		return;
	}

	var_04 = vectortoangles(param_02);
	var_05 = angleclamp180(var_04[1] - self.var_1D[1]);
	var_06 = self method_83DB(var_03);
	if(var_06 <= 0)
	{
		return;
	}

	var_07 = maps/mp/agents/_scripted_agent_anim_util::func_4416(var_05,var_06);
	if(var_07 == int(var_06 * 0.5))
	{
		return;
	}

	var_08 = self method_83D8(var_03,var_07);
	var_09 = getangledelta(var_08);
	var_0A = (0,angleclamp180(var_04[1] - var_09),0);
	if(func_1F4E(var_08,var_0A,var_07 == 3 || var_07 == 5,1))
	{
		var_0B = spawnstruct();
		var_0B.var_EE8 = var_03;
		var_0B.var_EC1 = var_07;
		var_0B.var_EC3 = "anim deltas";
		var_0B.var_6C37 = "face angle abs";
		var_0B.var_6C38 = var_0A;
		return var_0B;
	}
}

//Function Number: 12
func_220C(param_00)
{
	var_01 = self [[ maps/mp/agents/_agent_utility::func_A59("get_action_params") ]]();
	var_02 = "turn_" + self.var_108;
	var_03 = func_220E(var_02,var_01,param_00);
	if(isdefined(var_03))
	{
		return var_03;
	}

	var_02 = var_02 + "_quick";
	var_03 = func_220E(var_02,var_01,param_00);
	if(isdefined(var_03))
	{
		return var_03;
	}
}

//Function Number: 13
func_1F4E(param_00,param_01,param_02,param_03)
{
	var_04 = 0.5;
	var_05 = getnotetracktimes(param_00,"turn_extent");
	if(var_05.size == 1)
	{
		var_04 = var_05[0];
	}

	var_06 = 1;
	var_07 = getnotetracktimes(param_00,"finish");
	if(var_07.size == 0)
	{
		var_07 = getnotetracktimes(param_00,"end");
	}

	if(var_07.size == 1)
	{
		var_06 = var_07[0];
	}

	var_08 = getmovedelta(param_00,0,var_04);
	var_09 = getmovedelta(param_00,0,var_06);
	var_0A = self.var_116;
	var_0B = rotatevector(var_08,param_01) + var_0A;
	var_0C = rotatevector(var_09,param_01) + var_0A;
	if(!lib_0547::func_1F5B(var_0B,var_0C,0))
	{
		return 0;
	}

	var_0D = self.var_14F;
	if(!param_02)
	{
		var_0D = self.var_14F / 2;
	}

	if(!lib_0547::func_1F5B(var_0A,var_0B,0,var_0D))
	{
		return 0;
	}

	return 1;
}

//Function Number: 14
func_5810()
{
	return common_scripts\utility::func_562E(self.var_50D9) || common_scripts\utility::func_562E(self.var_5382);
}

//Function Number: 15
func_A6D6()
{
	self notify("humanoidmove_endwait_turn");
	self endon("humanoidmove_endwait_turn");
	self endon("killanimscript");
	if(common_scripts\utility::func_562E(self.var_2FA4))
	{
		return;
	}

	var_00 = undefined;
	if(isdefined(self.var_220D))
	{
		var_00 = [[ self.var_220D ]]();
	}
	else
	{
		while(!isdefined(var_00))
		{
			self waittill("path_dir_change",var_01);
			if(func_5810())
			{
				continue;
			}

			var_00 = func_220C(var_01);
		}
	}

	thread func_32B8(var_00);
}

//Function Number: 16
func_A6C7()
{
	self notify("humanoidmove_endwait_stop");
	self endon("humanoidmove_endwait_stop");
	self endon("killanimscript");
	self waittill("stop_soon");
	if(common_scripts\utility::func_562E(self.var_50D9))
	{
		thread func_A6C7();
	}

	if(!common_scripts\utility::func_562E(self.var_15E1))
	{
		thread func_A6C7();
		return;
	}

	var_00 = "stop_" + self.var_108;
	var_01 = maps/mp/agents/_scripted_agent_anim_util::func_434D(var_00);
	if(!isdefined(var_01))
	{
		var_00 = "stop_walk";
		var_01 = maps/mp/agents/_scripted_agent_anim_util::func_434D(var_00);
	}

	var_02 = self method_83DB(var_01);
	if(var_02 <= 0)
	{
		thread func_A6C7();
		return;
	}

	var_03 = 0;
	if(isdefined(self.var_10D))
	{
		var_03 = self.var_10D.var_1D[1] - self.var_1D[1];
	}

	var_04 = maps/mp/agents/_scripted_agent_anim_util::func_4416(var_03,var_02);
	var_05 = self method_83D8(var_01,var_04);
	var_06 = getmovedelta(var_05);
	var_07 = getangledelta(var_05);
	var_08 = self method_83E7();
	var_09 = var_08 - self.var_116;
	if(length(var_09) + 12 < length(var_06))
	{
		thread func_A6C7();
		return;
	}

	var_0A = func_46B2();
	var_0B = func_1E40(var_0A.var_7584,var_0A.var_1D[1],var_06,var_07);
	var_0C = lib_0547::func_34A6(var_0B);
	if(!isdefined(var_0C))
	{
		thread func_A6C7();
		return;
	}

	if(!lib_0547::func_1F5B(var_0A.var_7584,var_0C))
	{
		thread func_A6C7();
		return;
	}

	func_1F39("stop");
	thread func_A6B2();
	thread func_A6D7();
	if(distancesquared(var_0B,self.var_116) > 25)
	{
		self method_8394(var_0B);
		thread func_A693();
		self waittill("waypoint_reached");
		self notify("humanoidmove_endwait_blockedwhilestopping");
	}

	var_0D = var_08 - self.var_116;
	var_0E = vectortoangles(var_0D);
	var_0F = (0,var_0E[1] - var_07,0);
	var_10 = maps/mp/agents/_scripted_agent_anim_util::func_441C(var_08 - self.var_116,var_06);
	self method_839C("anim deltas");
	self scragentsetorientmode("face angle abs",var_0F,(0,var_0E[1],0));
	self method_839A(var_10.var_AAE3,var_10.var_1D9);
	maps/mp/agents/_scripted_agent_anim_util::func_71FA(var_01,var_04,self.var_64C2,"move_stop");
	self method_8395(self.var_116);
}

//Function Number: 17
func_A69C()
{
	self notify("humanoidmove_endwait_dodge");
	self endon("humanoidmove_endwait_dodge");
	self endon("killanimscript");
	lib_0547::func_A737();
	while(isalive(self))
	{
		self waittill("damage",var_00,var_01);
		wait 0.05;
		if(!isalive(self))
		{
			return;
		}

		if(!common_scripts\utility::func_562E(self.var_313E))
		{
			return;
		}

		if(maps/mp/agents/_scripted_agent_anim_util::func_57E2())
		{
			continue;
		}

		if(!isdefined(var_01) || !isalive(var_01) || !isplayer(var_01))
		{
			continue;
		}

		var_02 = var_01.var_116 - self.var_116;
		var_03 = anglestoforward(self.var_1D);
		if(vectordot(vectornormalize(var_02),var_03) < 0.7)
		{
			continue;
		}

		var_04 = lengthsquared(var_02);
		if(var_04 > 1000000 || var_04 < -25536)
		{
			continue;
		}

		if(isdefined(self.var_313F) && gettime() - self.var_313F < self.var_313B)
		{
			continue;
		}

		self.var_313F = gettime();
		if(randomfloat(1) < self.var_313A)
		{
			wait(randomfloatrange(0.1,0.3));
			if(!isalive(self))
			{
				return;
			}

			if(maps/mp/agents/_scripted_agent_anim_util::func_57E2())
			{
				continue;
			}

			func_1F39("dodge");
			self.var_5F48 = gettime();
			var_05 = vectornormalize((var_02[0],var_02[1],0));
			var_06 = vectortoangles(var_05);
			var_07 = self.var_3139;
			var_08 = maps/mp/agents/_scripted_agent_anim_util::func_7A35(var_07);
			maps/mp/agents/humanoid/_humanoid_util::func_70C9(self.var_3138[var_08]);
			self method_839C("anim deltas");
			self scragentsetorientmode("face angle abs",var_06,var_06);
			self method_839A(1,1);
			maps/mp/agents/_scripted_agent_anim_util::func_71FA(var_07,var_08,self.var_672D,"dodge");
			self.var_173E = 1;
			thread func_2603();
		}
	}
}

//Function Number: 18
func_A6A9()
{
	self notify("humanoidmove_endwait_leap");
	self endon("humanoidmove_endwait_leap");
	self endon("killanimscript");
	lib_0547::func_A737();
	for(;;)
	{
		wait 0.05;
		if(!isalive(self))
		{
			return;
		}

		if(!common_scripts\utility::func_562E(self.var_5C53))
		{
			return;
		}

		if(maps/mp/agents/_scripted_agent_anim_util::func_57E2())
		{
			continue;
		}

		if(!isdefined(self.var_28D2))
		{
			continue;
		}

		if((issentient(self.var_28D2) && !self agentcanseesentient(self.var_28D2)) || !maps\mp\_utility::func_3B8E(self,self.var_28D2,25))
		{
			continue;
		}

		var_00 = maps/mp/agents/humanoid/_humanoid::func_457E(self.var_28D2);
		if(!var_00.var_A266)
		{
			continue;
		}

		var_01 = distancesquared(self.var_28D2.var_116,self.var_116);
		if(var_01 > self.var_5C58 || var_01 < self.var_5C5A)
		{
			continue;
		}

		var_02 = gettime();
		var_03 = var_02 - self.var_5C56;
		if(var_03 < self.var_5C50)
		{
			continue;
		}

		var_04 = var_02 - self.var_5C55;
		if(var_04 < self.var_5C4F)
		{
			continue;
		}

		self.var_5C55 = var_02;
		var_05 = self.var_5C4E;
		if(randomfloat(1) >= var_05)
		{
			continue;
		}

		var_07 = maps/mp/agents/_scripted_agent_anim_util::func_7A35(self.var_5C4D);
		var_08 = self method_83D8(self.var_5C4D,var_07);
		var_09 = getnotetracktimes(var_08,"h_point")[0];
		var_0A = getmovedelta(var_08,0,var_09);
		var_0B = self localtoworldcoords(var_0A);
		var_0C = playerphysicstrace(self.var_116,var_0B,self);
		if(distancesquared(var_0C,var_0B) > 1)
		{
			self.var_5C55 = self.var_5C55 + 1000;
			continue;
		}

		var_0C = playerphysicstrace(var_0B,var_00.var_116,self);
		if(distancesquared(var_0C,var_00.var_116) > 1)
		{
			self.var_5C55 = self.var_5C55 + 1000;
			continue;
		}

		func_1F39("leap");
		self.var_5C56 = gettime();
		maps/mp/agents/humanoid/_humanoid_util::func_70C9(self.var_5C54);
		var_0D = getanimlength(var_08);
		var_0E = getnotetracktimes(var_08,"land");
		var_0E[0] = var_0E[0] - 0.1;
		var_0F = var_0D / self.var_672D * var_0E[0];
		self method_839D("noclip");
		self scragentsetorientmode("face angle abs",(0,vectortoyaw(var_00.var_116 - self.var_116),0));
		self method_839C("anim deltas");
		self method_839A(0,1);
		self method_83A4(self.var_116,var_00.var_116,var_0F);
		maps/mp/agents/_scripted_agent_anim_util::func_8732(1,"WaitForLeap");
		self.var_50D9 = 1;
		maps/mp/agents/_scripted_agent_anim_util::func_8415(self.var_5C4D,var_07,self.var_672D);
		wait(var_0F);
		self notify("cancel_updatelerppos");
		self method_839C("anim deltas");
		self method_839A(1,1);
		self method_839D("gravity");
		maps/mp/agents/_scripted_agent_anim_util::func_8732(0,"WaitForLeap");
		self.var_50D9 = 0;
		if(var_0D - var_0F > 0)
		{
			maps/mp/agents/_scripted_agent_anim_util::func_A79F("leap","end",var_0D - var_0F);
		}

		thread func_2603();
	}
}

//Function Number: 19
func_A6B2()
{
	self notify("humanoidmove_endwait_pathsetwhilestopping");
	self endon("humanoidmove_endwait_pathsetwhilestopping");
	self endon("killanimscript");
	var_00 = self method_8396();
	self waittill("path_set");
	var_01 = self method_8396();
	if(distancesquared(var_00,var_01) < 1)
	{
		thread func_A6B2();
		return;
	}

	self notify("humanoidmove_endwait_stop");
	self notify("humanoidmove_endwait_turnwhilestopping");
	thread func_2603();
}

//Function Number: 20
func_A6D7()
{
	self notify("humanoidmove_endwait_turnwhilestopping");
	self endon("humanoidmove_endwait_turnwhilestopping");
	self endon("killanimscript");
	var_00 = undefined;
	if(isdefined(self.var_220D))
	{
		var_00 = [[ self.var_220D ]]();
	}
	else
	{
		while(!isdefined(var_00))
		{
			self waittill("path_dir_change",var_01);
			var_00 = func_220C(var_01);
		}
	}

	self notify("humanoidmove_endwait_pathsetwhilestopping");
	self notify("humanoidmove_endwait_stop");
	childthread func_32B8(var_00);
}

//Function Number: 21
func_A693()
{
	self notify("humanoidmove_endwait_blockedwhilestopping");
	self endon("humanoidmove_endwait_blockedwhilestopping");
	self endon("killanimscript");
	self waittill("path_blocked");
	self notify("humanoidmove_endwait_stop");
	self method_8394(undefined);
}

//Function Number: 22
func_1F39(param_00)
{
	var_01 = ["turn","stop","pathsetwhilestopping","blockedwhilestopping","turnwhilestopping","dodge","setmoveanim","modechange","continuemovement"];
	var_02 = isdefined(param_00);
	foreach(var_04 in var_01)
	{
		if(var_02 && var_04 == param_00)
		{
			continue;
		}

		self notify("humanoidmove_endwait_" + var_04);
	}
}

//Function Number: 23
func_92E9()
{
	if(isdefined(self.var_9D0C) && self.var_9D0C - gettime() <= 50)
	{
		return;
	}

	var_00 = self method_8198();
	if(isdefined(var_00))
	{
		var_01 = var_00.var_116;
	}
	else
	{
		var_01 = self method_83E7();
	}

	if(distancesquared(var_01,self.var_116) < 10000)
	{
		return;
	}

	var_02 = self method_83E6();
	var_03 = vectortoangles(var_02);
	var_04 = self getvelocity();
	var_05 = length2d(var_04);
	var_06 = self.maxstartmovespeed;
	if(isdefined(var_06) && var_05 > var_06)
	{
		return;
	}

	if(var_05 > 4)
	{
		var_04 = vectornormalize(var_04);
		if(vectordot(var_04,var_02) > 0.707)
		{
			return;
		}
	}

	var_07 = maps/mp/agents/_scripted_agent_anim_util::func_434D("start_" + self.var_108);
	var_08 = angleclamp180(var_03[1] - self.var_1D[1]);
	var_09 = self method_83DB(var_07);
	if(var_09 == 0)
	{
		return;
	}

	var_0A = maps/mp/agents/_scripted_agent_anim_util::func_4416(var_08,var_09);
	var_0B = self method_83D8(var_07,var_0A);
	var_0C = getmovedelta(var_0B);
	var_0D = rotatevector(var_0C,self.var_1D) + self.var_116;
	if(!lib_0547::func_1F5B(self.var_116,var_0D))
	{
		return;
	}

	var_0E = getangledelta3d(var_0B);
	self method_839C("anim deltas");
	if(abs(var_0A - int(var_09 * 0.5)) <= 1)
	{
		self scragentsetorientmode("face angle abs",(0,angleclamp180(var_03[1] - var_0E[1]),0));
	}
	else
	{
		self scragentsetorientmode("face angle abs",self.var_1D);
	}

	self.var_92EA = gettime() * 0.001 + getanimlength(var_0B);
	maps/mp/agents/_scripted_agent_anim_util::func_71FA(var_07,var_0A,self.var_64C2,"move_start","code_move");
}

//Function Number: 24
func_46B2()
{
	var_00 = spawnstruct();
	if(isdefined(self.var_10D))
	{
		var_00.var_7584 = self.var_10D.var_116;
		var_00.var_1D = self.var_10D.var_1D;
	}
	else
	{
		var_01 = self method_83E7();
		var_00.var_7584 = var_01;
		var_00.var_1D = vectortoangles(self method_83E6());
	}

	return var_00;
}

//Function Number: 25
func_1E40(param_00,param_01,param_02,param_03)
{
	var_04 = param_01 - param_03;
	var_05 = (0,var_04,0);
	var_06 = anglestoforward(var_05);
	var_07 = anglestoright(var_05);
	var_08 = var_06 * param_02[0];
	var_09 = var_07 * param_02[1];
	return param_00 - var_08 + var_09;
}

//Function Number: 26
func_574F(param_00)
{
	switch(param_00)
	{
		case "left_foot":
		case "left_leg_lower":
		case "left_leg_upper":
		case "right_foot":
		case "right_leg_lower":
		case "right_leg_upper":
			return 1;

		default:
			return 0;
	}
}

//Function Number: 27
func_6ADB(param_00,param_01,param_02,param_03,param_04,param_05,param_06,param_07,param_08,param_09)
{
	if(!lib_0547::func_4B2C() || !lib_054D::func_8B9C())
	{
		return;
	}

	if(!maps/mp/agents/_scripted_agent_anim_util::func_57E2() && !common_scripts\utility::func_562E(self.var_5382))
	{
		thread func_86D0(maps/mp/agents/humanoid/_humanoid_util::func_29CB(param_06,param_07),self.var_108,func_574F(param_08));
	}
}