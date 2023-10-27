/*******************************************************************
 * Decompiled By: Bog
 * Decompiled File: scripts\asm\alien_goon\alien_jump.gsc
 * Game: Call of Duty: Infinite Warfare
 * Platform: PC
 * Function Count: 30
 * Decompile Time: 1494 ms
 * Timestamp: 10/27/2023 12:01:19 AM
*******************************************************************/

//Function Number: 1
setjumpattackanimstates(param_00,param_01)
{
	param_01.var_A7C6 = "attack_leap_swipe";
	param_01.var_A7C4 = scripts\mp\agents\_scriptedagents::func_80AE("attack_leap_swipe");
}

//Function Number: 2
choosejumpattackarrival(param_00,param_01)
{
	var_02 = 0.707;
	if(isdefined(self.var_4B26) && isalive(self.var_4B26))
	{
		var_03 = vectornormalize(self.var_4B26.origin - param_00.var_A843);
		var_04 = anglestoforward(param_00.var_630B);
		var_05 = vectordot(var_03,var_04);
		if(var_05 > var_02)
		{
			return;
		}

		var_06 = anglestoright(param_00.var_630B);
		var_07 = vectordot(var_03,var_06);
		if(var_07 > var_02)
		{
			param_01.var_A7C6 = "attack_leap_swipe_right";
			param_01.var_A7C4 = scripts\mp\agents\_scriptedagents::func_80AE("attack_leap_swipe_right");
			return;
		}

		if(var_07 < var_02 * -1)
		{
			param_01.var_A7C6 = "attack_leap_swipe_left";
			param_01.var_A7C4 = scripts\mp\agents\_scriptedagents::func_80AE("attack_leap_swipe_left");
			return;
		}
	}
}

//Function Number: 3
jumpattack(param_00,param_01,param_02)
{
	var_03 = spawnstruct();
	var_03.var_71CD = ::setjumpattackanimstates;
	var_03.var_71BB = ::choosejumpattackarrival;
	self.var_B59D = 1;
	func_A4C3(param_00,param_01,self.origin,self.angles,param_02,self.var_4B26.angles,undefined,var_03);
	self.var_B59D = 0;
}

//Function Number: 4
func_A4C3(param_00,param_01,param_02,param_03,param_04,param_05,param_06,param_07,param_08)
{
	var_09 = self method_827F();
	func_A4E3(param_00,param_01,param_02,param_03,param_04,param_05,param_06,param_07,param_08);
	func_A4DA(var_09,param_05);
}

//Function Number: 5
func_A4DA(param_00,param_01)
{
	if(scripts\common\utility::istrue(self.activated_venomx_sphere))
	{
		self method_8282(0.2,0.2);
	}
	else
	{
		self method_8282(1,1);
	}

	self method_8288(param_00);
	self method_828A("gravity");
	self.var_21D = 0;
	self.ignoreme = 0;
}

//Function Number: 6
func_A4E3(param_00,param_01,param_02,param_03,param_04,param_05,param_06,param_07,param_08)
{
	self endon("death");
	self endon("killanimscript");
	self endon(param_01 + "_finished");
	self.var_11B2F = 0;
	var_09 = spawnstruct();
	var_0A = func_7F2B(param_02,param_03,param_04,param_05,param_06);
	func_7F28(var_0A,var_09);
	if(isdefined(param_07) && isdefined(param_07.var_71CD))
	{
		self [[ param_07.var_71CD ]](var_0A,var_09);
	}

	var_0B = func_7F2F(param_02,param_03,param_04);
	self method_828A("noclip");
	self method_8289("face angle abs",var_0B);
	var_0C = 0;
	var_0D = self method_80FD(var_09.var_AAA5,var_09.var_AAA4);
	var_0E = self method_80FD(var_09.var_A7C6,var_09.var_A7C4);
	var_0F = getnotetracktimes(var_0E,"finish");
	if(var_0F.size > 0)
	{
		var_10 = var_0F[0] * getanimlength(var_0E);
	}
	else
	{
		var_10 = getanimlength(var_0F);
	}

	var_11 = var_10 / var_09.var_CEE4;
	var_12 = floor(var_11 * 20);
	var_13 = var_12 / 20 / var_11;
	var_14 = getnotetracktimes(var_0E,"stop_teleport");
	if(var_14.size > 0)
	{
		var_15 = var_14[0] * var_11;
		var_16 = ceil(var_15 * 20);
		var_17 = var_16 / 20 / var_11;
		var_18 = getmovedelta(var_0E,var_17,var_13);
	}
	else
	{
		var_15 = 0.8 * var_15;
		var_16 = ceil(var_18 * 20);
		var_17 = var_18 / 20 / var_13;
		var_18 = getmovedelta(var_0F,var_18,var_14);
	}

	param_05 = func_7F29(param_02,param_04,param_05);
	var_19 = rotatevector(var_18,param_05);
	var_1A = param_04 - var_19;
	self method_8281("anim deltas");
	self playsoundonmovingent(func_7A62());
	if(animhasnotetrack(var_0D,"start_teleport"))
	{
		scripts\mp\agents\_scriptedagents::func_CED2(var_09.var_AAA5,var_09.var_AAA4,var_09.var_CEE4,"jump_launch","start_teleport");
	}
	else
	{
		scripts\mp\agents\_scriptedagents::func_CED1(var_09.var_AAA5,var_09.var_AAA4,var_09.var_CE9E,0.5 * getanimlength(var_0D) / var_09.var_CEE4);
	}

	var_1B = gettime();
	var_0C = self method_827D(self.origin,var_1A,var_0A.var_A4EB);
	self.var_11B2F = 1;
	self notify("jump_launching");
	var_1C = self method_827F();
	thread func_A4E9(var_0A,param_05,var_1C,var_0C);
	scripts\mp\agents\_scriptedagents::func_1384C("jump_launch","end");
	var_1D = gettime() - var_1B / 1000;
	if(scripts\common\utility::istrue(self.bteleporting))
	{
		if(level.totalphantomsjumping < level.totalphantomsallowedtojump)
		{
			level.totalphantomsjumping++;
			thread play_teleport_start();
			self.bteleporting = 0;
		}
		else
		{
			self.bteleporting = 0;
		}
	}

	var_1E = var_0C - var_1D - var_15;
	if(var_1E > 0)
	{
		scripts\mp\agents\_scriptedagents::func_CED1(var_09.var_93B3,var_09.var_93B2,var_09.var_CEE4,var_1E);
	}

	if(isdefined(param_07) && isdefined(param_07.var_71BB))
	{
		self [[ param_07.var_71BB ]](var_0A,var_09);
	}

	if(scripts\common\utility::istrue(self.activated_venomx_sphere))
	{
		self method_82AF(var_09.var_A7C6,var_09.var_A7C4,0.2);
	}
	else
	{
		self method_82AF(var_09.var_A7C6,var_09.var_A7C4,var_09.var_CEE4);
	}

	var_1F = lib_0A1A::func_2341(param_00,param_01);
	thread handlejumpnotetracks("jump_land","end",var_09.var_A7C6,var_09.var_A7C4,var_1F);
	self waittill("traverse_complete");
	self.var_11B2F = 0;
	if(scripts\common\utility::istrue(self.activated_venomx_sphere))
	{
		self method_8282(0.2,0.2);
	}
	else
	{
		self method_8282(1,0);
	}

	self method_8288(20.28318);
	self method_8281("anim deltas");
	self method_8289("face angle abs",param_05);
	scripts\mp\agents\_scriptedagents::func_1384C("jump_land","end");
	if(scripts\common\utility::istrue(self.activated_venomx_sphere))
	{
		self method_8282(0.2,0.2);
	}
	else
	{
		self method_8282(1,1);
	}

	self setorigin(param_04,0);
}

//Function Number: 7
play_teleport_start()
{
	self setscriptablepartstate("teleport_fx","teleport_start");
	scripts\common\utility::func_136F7();
	self method_85B7(1);
}

//Function Number: 8
handlejumpnotetracks(param_00,param_01,param_02,param_03,param_04)
{
	self endon(param_02 + "_finished");
	scripts\mp\agents\_scriptedagents::func_1384C(param_00,param_01,param_02,param_03,param_04);
}

//Function Number: 9
func_A4E9(param_00,param_01,param_02,param_03)
{
	self endon("death");
	var_04 = (0,0,1);
	var_05 = 0.85;
	var_06 = scripts\cp\_utility::func_9C52(param_00.var_10E05);
	var_07 = scripts\cp\_utility::func_9C52(param_00.var_6397);
	if(var_06 && !var_07)
	{
		var_08 = 0.5;
		var_09 = 1;
	}
	else if(!var_08 && var_09)
	{
		var_08 = 0;
		var_09 = 0.5;
	}
	else
	{
		var_08 = 0;
		var_09 = 1;
	}

	var_0A = var_09 - var_08;
	if(var_08 > 0)
	{
		wait(param_03 * var_08);
	}

	var_0B = 1;
	if(distancesquared(self.angles,param_01) > var_0B)
	{
		var_0C = anglesdelta(self.angles,param_01);
		var_0D = var_0C / param_03 * var_0A;
		var_0D = var_0D * 3.141593 / 180;
		var_0D = var_0D / 20;
		self method_8288(var_0D);
	}

	self method_8289("face angle abs",param_01);
}

//Function Number: 10
func_7F2B(param_00,param_01,param_02,param_03,param_04)
{
	var_05 = spawnstruct();
	var_06 = param_02 - param_00;
	var_07 = var_06 * (1,1,0);
	var_07 = vectornormalize(var_07);
	var_05.var_AAB4 = param_00 + var_07 * level.var_1BBA.var_A4E6;
	var_05.var_A843 = param_02;
	var_05.var_A4F8 = var_05.var_A843 - var_05.var_AAB4;
	var_05.var_A4F7 = var_05.var_A4F8 * (1,1,0);
	var_05.var_A4DC = length(var_05.var_A4F7);
	var_05.var_A4DB = var_05.var_A4F7 / var_05.var_A4DC;
	if(isdefined(param_04))
	{
		var_05.var_A844 = param_04 - param_02;
	}
	else if(isdefined(self.var_4B26))
	{
		var_05.var_A844 = self.var_4B26.origin - param_02;
	}
	else
	{
		var_05.var_A844 = anglestoforward(self.angles);
	}

	var_05.var_10D6D = func_7F27(var_05.var_A4F8,anglestoup(param_01));
	var_05.var_630B = func_7F27(var_05.var_A4F8,anglestoup(param_03));
	var_05.var_10E05 = anglestoup(var_05.var_10D6D);
	var_05.var_6397 = anglestoup(var_05.var_630B);
	func_7F30(var_05);
	return var_05;
}

//Function Number: 11
func_DA68(param_00,param_01)
{
	var_02 = vectordot(param_00,param_01);
	var_03 = param_00 - param_01 * var_02;
	return var_03;
}

//Function Number: 12
func_7F27(param_00,param_01)
{
	var_02 = func_DA68(param_00,param_01);
	var_03 = vectorcross(var_02,param_01);
	var_04 = axistoangles(var_02,var_03,param_01);
	return var_04;
}

//Function Number: 13
func_7F30(param_00)
{
	var_01 = param_00.var_A4DC;
	var_02 = param_00.var_A4F8[2];
	var_03 = !scripts\cp\_utility::func_9C52(param_00.var_6397);
	var_04 = func_7F2A(var_03);
	var_05 = 1.01;
	var_06 = trajectorycalculateminimumvelocity(param_00.var_AAB4,param_00.var_A843,var_04);
	var_07 = func_7F2E(var_03);
	var_08 = var_06 * var_05 * var_07;
	var_09 = trajectorycalculateexitangle(var_08,var_04,var_01,var_02);
	var_0A = cos(var_09);
	param_00.var_A4ED = param_00.var_A4DC / var_08 * var_0A;
	var_0B = var_04 * (0,0,-1);
	param_00.var_AABA = trajectorycalculateinitialvelocity(param_00.var_AAB4,param_00.var_A843,var_0B,param_00.var_A4ED);
	param_00.var_AAB9 = param_00.var_AABA * (1,1,0);
	param_00.var_A4EB = length(param_00.var_AAB9);
}

//Function Number: 14
func_7F2E(param_00)
{
	if(isdefined(self.var_B59D) && self.var_B59D)
	{
		return level.var_1B74;
	}

	if(param_00)
	{
		return getdvarfloat("agent_jumpWallSpeed");
	}

	return getdvarfloat("agent_jumpSpeed");
}

//Function Number: 15
func_7F2A(param_00)
{
	if(isdefined(self.var_B59D) && self.var_B59D)
	{
		return level.var_1B73;
	}

	if(param_00)
	{
		return getdvarfloat("agent_jumpWallGravity");
	}

	return getdvarfloat("agent_jumpGravity");
}

//Function Number: 16
func_7F2D(param_00,param_01)
{
	var_02 = self method_80FD(param_01.var_AAA5,param_01.var_AAA4);
	var_03 = self method_80FD(param_01.var_93B3,param_01.var_93B2);
	var_04 = self method_80FD(param_01.var_A7C6,param_01.var_A7C4);
	var_05 = getanimlength(var_02);
	var_06 = var_05 * 0.5;
	var_07 = getnotetracktimes(var_02,"start_teleport");
	if(isdefined(var_07) && var_07.size > 0)
	{
		var_06 = var_05 - var_07[0] * var_05;
	}

	var_08 = getanimlength(var_04);
	var_09 = var_08 * 0.5;
	var_0A = getnotetracktimes(var_04,"stop_teleport");
	if(isdefined(var_0A) && var_0A.size > 0)
	{
		var_09 = var_0A[0] * var_08;
	}

	var_0B = getanimlength(var_03);
	var_0C = ceil(param_00.var_A4ED * 20);
	var_0D = var_0C / 20;
	var_0E = var_0B + var_06 + var_09;
	var_0F = var_0E / var_0D;
	var_10 = var_0B / var_0F + 0.1;
	var_11 = var_0B / var_10;
	return var_11;
}

//Function Number: 17
func_7F28(param_00,param_01)
{
	param_01.var_AAA5 = func_7F64(param_00);
	param_01.var_AAA4 = func_7F63(param_00,param_01.var_AAA5);
	param_01.var_A7C6 = func_7F5C(param_00);
	param_01.var_A7C4 = func_7F5B(param_00,param_01.var_A7C6);
	param_01.var_93B3 = func_7F17(param_00,param_01.var_AAA5,param_01.var_A7C6);
	param_01.var_93B2 = func_7F16(param_00,param_01.var_AAA5,param_01.var_A7C6);
	param_01.var_CEE4 = func_7F2D(param_00,param_01);
}

//Function Number: 18
func_7F2F(param_00,param_01,param_02)
{
	var_03 = anglestoup(param_01);
	var_04 = vectornormalize(param_02 - param_00);
	if(vectordot(var_03,var_04) > 0.98)
	{
		var_04 = (0,0,1);
	}

	var_05 = vectorcross(var_03,var_04);
	var_04 = vectorcross(var_05,var_03);
	return axistoangles(var_04,-1 * var_05,var_03);
}

//Function Number: 19
func_7F64(param_00)
{
	var_01 = 20;
	var_02 = cos(90 - var_01);
	var_03 = vectornormalize(param_00.var_A4F8);
	var_04 = vectordot(var_03,param_00.var_10E05);
	if(abs(var_04) <= var_02)
	{
		return "jump_launch_level";
	}

	if(var_04 > 0)
	{
		return "jump_launch_up";
	}

	if(var_04 < 0)
	{
		return "jump_launch_down";
	}
}

//Function Number: 20
func_7F63(param_00,param_01)
{
	var_02 = vectornormalize(param_00.var_AABA);
	var_02 = rotatevector(var_02,param_00.var_10D6D);
	var_03 = self method_8100(param_01);
	var_04 = 0;
	var_05 = vectordot(level.var_1BBA.var_A4E5[param_01][var_04],var_02);
	for(var_06 = 1;var_06 < var_03;var_06++)
	{
		var_07 = vectordot(level.var_1BBA.var_A4E5[param_01][var_06],var_02);
		if(var_07 > var_05)
		{
			var_04 = var_06;
			var_05 = var_07;
		}
	}

	return var_04;
}

//Function Number: 21
func_7F17(param_00,param_01,param_02)
{
	return "jump_in_air";
}

//Function Number: 22
func_7F16(param_00,param_01,param_02)
{
	return level.var_1BBA.var_93B2[param_01][param_02];
}

//Function Number: 23
func_7F29(param_00,param_01,param_02)
{
	var_03 = anglestoup(param_02);
	var_04 = vectornormalize(param_01 - param_00);
	if(vectordot(var_03,var_04) > 0.98)
	{
		var_04 = (0,0,1);
	}

	var_05 = vectorcross(var_03,var_04);
	var_04 = vectorcross(var_05,var_03);
	return axistoangles(var_04,-1 * var_05,var_03);
}

//Function Number: 24
func_7F5C(param_00)
{
	var_01 = length(param_00.var_A4F8);
	var_02 = 0.342;
	if(!scripts\cp\_utility::func_9C52(param_00.var_6397))
	{
		var_03 = (0,0,1);
		var_04 = vectordot(param_00.var_A4F8,var_03) / var_01;
		if(var_04 > var_02)
		{
			return "jump_land_sidewall_low";
		}
		else
		{
			return "jump_land_sidewall_high";
		}
	}

	var_04 = vectordot(param_00.var_A4F8,param_00.var_6397) / var_01;
	if(var_04 > var_02)
	{
		return "jump_land_down";
	}

	if(var_04 < var_02 * -1)
	{
		return "jump_land_up";
	}

	return "jump_land_level";
}

//Function Number: 25
func_7F5B(param_00,param_01)
{
	var_02 = func_DA68(param_00.var_A4F8,param_00.var_6397);
	var_03 = func_DA68(param_00.var_A844,param_00.var_6397);
	var_04 = var_02 - var_03;
	var_05 = vectorcross(var_03,param_00.var_6397);
	var_06 = vectornormalize(func_DA68(var_05,param_00.var_6397)) * 100;
	var_07 = vectordot(var_02 * -1,var_06);
	var_08 = length(var_02);
	var_09 = length(var_03);
	var_0A = length(var_04);
	var_0B = 0.001;
	if(var_08 < var_0B || var_09 < var_0B)
	{
		return 1;
	}

	var_0C = var_08 * var_08 + var_09 * var_09 - var_0A * var_0A / 2 * var_08 * var_09;
	if(var_0C <= -1)
	{
		return 6;
	}

	if(var_0C >= 1)
	{
		return 1;
	}

	var_0D = acos(var_0C);
	if(var_07 > 0)
	{
		if(0 <= var_0D && var_0D < 22.5)
		{
			return 1;
		}

		if(22.5 <= var_0D && var_0D < 67.5)
		{
			return 2;
		}

		if(67.5 <= var_0D && var_0D < 112.5)
		{
			return 4;
		}

		if(112.5 <= var_0D && var_0D < 157.5)
		{
			return 7;
		}

		return 6;
	}

	if(0 <= var_0D && var_0D < 22.5)
	{
		return 1;
	}

	if(22.5 <= var_0D && var_0D < 67.5)
	{
		return 0;
	}

	if(67.5 <= var_0D && var_0D < 112.5)
	{
		return 3;
	}

	if(112.5 <= var_0D && var_0D < 157.5)
	{
		return 5;
	}

	return 6;
}

//Function Number: 26
func_A4EA(param_00,param_01)
{
}

//Function Number: 27
func_D4A2(param_00,param_01,param_02,param_03)
{
	self endon("death");
	self endon("killanimscript");
	self endon("jump_finished");
	if(scripts\common\utility::istrue(self.activated_venomx_sphere))
	{
		self method_82AF(param_00,param_01,0.2);
	}
	else
	{
		self method_82AF(param_00,param_01,1);
	}

	var_04 = scripts\common\utility::func_13734("jump_pain","traverse_complete");
	if(var_04 == "traverse_complete")
	{
		return;
	}

	var_05 = param_02 - gettime() * 0.001;
	if(var_05 > 0)
	{
		var_06 = 2;
		var_07 = func_7F2C(param_03);
		var_08 = self method_80FD(var_07,param_01);
		var_09 = getanimlength(var_08);
		var_0A = min(var_06,var_09 / var_05);
		if(scripts\common\utility::istrue(self.activated_venomx_sphere))
		{
			self method_82AF(var_07,param_01,0.2);
		}
		else
		{
			self method_82AF(var_07,param_01,var_0A);
		}
	}

	self waittill("traverse_complete");
}

//Function Number: 28
func_7F2C(param_00)
{
	return "jump_pain_idle_" + param_00;
}

//Function Number: 29
func_7F11(param_00)
{
	return "jump_impact_pain_" + param_00;
}

//Function Number: 30
func_7A62()
{
	return "alien_jump";
}