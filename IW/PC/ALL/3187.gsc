/*******************************************************************
 * Decompiled By: Bog
 * Decompiled File: 3187.gsc
 * Game: Call of Duty: Infinite Warfare
 * Platform: PC
 * Function Count: 25
 * Decompile Time: 9 ms
 * Timestamp: 10/27/2023 12:26:29 AM
*******************************************************************/

//Function Number: 1
func_138E4(param_00,param_01,param_02,param_03)
{
	if(lib_0A1B::func_2953())
	{
		return 1;
	}

	return 0;
}

//Function Number: 2
func_138E0()
{
	return 0;
}

//Function Number: 3
func_138E1()
{
	if(!lib_0A1B::func_2955())
	{
		return 0;
	}

	if(!isdefined(self.var_B629))
	{
		return 0;
	}

	if(self.var_B629 == "run" || self.var_B629 == "sprint")
	{
		return 1;
	}

	return 0;
}

//Function Number: 4
func_10041()
{
	if(isdefined(self.agent_type) && self.agent_type == "zombie_brute")
	{
		return 0;
	}

	if(isdefined(self.var_10C) && self.var_10C.health < 91)
	{
		return 0;
	}

	if(isdefined(level.wave_num) && level.wave_num < 10)
	{
		return 0;
	}

	var_00 = lib_0C72::func_9EA5();
	var_01 = lib_0C72::func_9EA4();
	var_02 = !var_01 || var_00;
	var_03 = randomint(100) < 2;
	return var_02 && var_03;
}

//Function Number: 5
func_3EB9(param_00,param_01,param_02)
{
	var_03 = lib_0C72::func_9EA5();
	var_04 = lib_0C72::func_9EA4();
	var_05 = var_03 && var_04;
	var_06 = !var_04 || var_03;
	var_07 = self method_8100(param_01);
	if(var_06)
	{
		return randomint(var_07);
	}

	if(var_05)
	{
		return 0;
	}

	var_08 = int(var_07 / 2);
	if(var_03)
	{
		return randomint(var_08);
	}

	return var_08 + randomint(var_08);
}

//Function Number: 6
func_D4C8(param_00,param_01,param_02,param_03)
{
	self endon("death");
	self endon("terminate_ai_threads");
	var_04 = func_81F1(self.var_4B26,1);
	func_57E5(param_00,param_01,self.var_4B26,var_04,1,1,self.var_C081,1);
	lib_0A1A::func_2330(param_01,"end");
}

//Function Number: 7
func_D4DC(param_00,param_01,param_02,param_03)
{
	self endon("death");
	self endon("terminate_ai_threads");
	var_04 = lib_0A1B::func_2925();
	self.var_B629 = undefined;
	var_05 = func_81F1(var_04,1);
	self.var_CA1C = 1;
	self.var_1B03 = "melee";
	func_57E5(param_00,param_01,var_04,var_05,0,1,self.var_C081);
	self.var_1B03 = "move";
	lib_0A1A::func_2330(param_01,"end");
}

//Function Number: 8
func_D539(param_00,param_01,param_02,param_03)
{
	self endon("death");
	self endon("terminate_ai_threads");
	var_04 = lib_0A1B::func_2925();
	var_05 = func_81F1(var_04,1);
	self.var_1B03 = "melee";
	func_57E5(param_00,param_01,var_04,var_05,0,1,self.var_C081);
	self.var_1B03 = "idle";
	lib_0A1A::func_2330(param_01,"end");
}

//Function Number: 9
func_CC64(param_00,param_01,param_02,param_03)
{
	self endon("death");
	self endon("terminate_ai_threads");
	var_04 = lib_0A1B::func_2925();
	var_05 = func_81F1(var_04,1);
	self.var_1B03 = "melee";
	func_57E5(param_00,param_01,var_04,var_05,0,1,self.var_C081,0,1);
	self.var_1B03 = "idle";
	lib_0A1A::func_2330(param_01,"end");
}

//Function Number: 10
func_2989(param_00,param_01,param_02,param_03)
{
	return isdefined(self.var_1198.var_3134) && self.var_1198.var_3134;
}

//Function Number: 11
func_138E5()
{
	if(func_2989())
	{
		return 1;
	}

	return 0;
}

//Function Number: 12
func_138E6()
{
	return scripts\common\utility::istrue(self.var_FF78);
}

//Function Number: 13
func_D543(param_00,param_01,param_02,param_03)
{
	self endon("death");
	self endon("terminate_ai_threads");
	self endon(param_01 + "_finished");
	if(isdefined(self.agent_type) && self.agent_type == "skater")
	{
		playsoundatpos(self gettagorigin("tag_eye"),"zmb_skater_pre_explo");
	}
	else
	{
		playsoundatpos(self gettagorigin("tag_eye"),"zmb_clown_pre_explo");
	}

	var_04 = lib_0A1D::func_2337(param_00,param_01);
	scripts\mp\agents\_scriptedagents::func_CED2(param_01,var_04,2,param_01,"explode");
	if(isdefined(self.agent_type) && self.agent_type != "skater")
	{
		playsoundatpos(self gettagorigin("tag_eye"),"zmb_vo_clown_death");
	}

	wait(0.25);
	self method_83AD();
	self.nocorpse = 1;
	self suicide();
}

//Function Number: 14
func_D553(param_00,param_01,param_02,param_03)
{
	self endon("death");
	self endon("terminate_ai_threads");
	self endon(param_01 + "_finished");
	self.var_FF78 = undefined;
	var_04 = lib_0A1D::func_2337(param_00,param_01);
	scripts\mp\agents\_scriptedagents::func_CED5(param_01,var_04,param_01);
}

//Function Number: 15
func_6A6A(param_00,param_01)
{
	self endon(param_00 + "_finished");
	self notify("stop_melee_face_enemy");
	self endon("stop_melee_face_enemy");
	for(;;)
	{
		if(isdefined(param_01) && isalive(param_01))
		{
			self method_8289("face angle abs",(0,vectortoyaw(param_01.origin - self.origin),0));
		}
		else
		{
			break;
		}

		scripts\common\utility::func_136F7();
	}
}

//Function Number: 16
func_1106E()
{
	self notify("stop_melee_face_enemy");
}

//Function Number: 17
func_57E5(param_00,param_01,param_02,param_03,param_04,param_05,param_06,param_07,param_08)
{
	self endon(param_01 + "_finished");
	self endon("death");
	self endon("terminate_ai_threads");
	self.var_A9B6 = undefined;
	self.var_A9B7 = undefined;
	if(!isdefined(param_07))
	{
		param_07 = 0;
	}

	var_09 = lib_0A1D::func_2337(param_00,param_01);
	var_0A = self method_80FD(param_01,var_09);
	var_0B = getanimlength(var_0A);
	var_0C = getnotetracktimes(var_0A,"hit");
	var_0D = var_0B / param_06 * 0.33;
	if(var_0C.size > 0)
	{
		var_0D = var_0B / param_06 * var_0C[0];
	}

	var_0E = getnotetracktimes(var_0A,"finish");
	var_0F = 0.9;
	if(var_0E.size > 0)
	{
		var_0F = var_0E[0];
	}
	else
	{
		var_0F = 0.9;
	}

	var_10 = var_0B / param_06 * var_0F;
	self method_828A("gravity");
	if(param_05 && isdefined(self.var_10C))
	{
		thread func_6A6A(param_01,self.var_10C);
	}
	else if(isdefined(param_02))
	{
		self method_8289("face angle abs",(0,vectortoyaw(param_02.origin - self.origin),0));
	}
	else
	{
		self method_8289("face angle abs",self.angles);
	}

	self method_8281("anim deltas");
	scripts\mp\agents\_scriptedagents::func_F2B1(param_01,var_09,param_06);
	if(param_07)
	{
		var_11 = getnotetracktimes(var_0A,"lunge_start");
		var_12 = 0;
		if(var_11.size > 0)
		{
			var_12 = var_0B / param_06 * var_11[0];
		}

		var_0D = var_0D - var_12;
		if(var_12 > 0)
		{
			wait(var_12);
		}

		if(self.var_B0FC)
		{
			var_13 = param_03 - self.origin;
			var_14 = getmovedelta(var_0A,var_11[0],var_0C[0]);
			var_15 = scripts\mp\agents\_scriptedagents::func_7DC9(var_13,var_14);
			param_06 = param_06 * clamp(1 / var_15.var_13E2B,0.5,1);
			var_0D = var_0B / param_06 * var_0C[0] - var_0B / param_06 * var_11[0];
			scripts\mp\agents\_scriptedagents::func_F2B1(param_01 + "_norestart",var_09,param_06);
		}
	}

	if(param_04)
	{
		self method_8282(0,1);
		self method_827B(self.origin,param_03,var_0D);
		childthread func_12EC0(param_02,var_0D,1,self.var_B101);
		scripts\mp\agents\_scriptedagents::func_F85E(1,"DoAttack");
	}
	else
	{
		self method_8282(1,1);
	}

	wait(var_0D);
	lib_0A1B::func_2914();
	self notify("cancel_updatelerppos");
	if(param_05 && isdefined(self.var_10C))
	{
		thread func_6A6A(param_01,self.var_10C);
	}
	else
	{
		func_1106E();
		if(isdefined(param_02))
		{
			self method_8289("face angle abs",(0,vectortoyaw(param_02.origin - self.origin),0));
		}
		else
		{
			self method_8289("face angle abs",self.angles);
		}
	}

	self method_8281("anim deltas");
	self method_8282(1,1);
	if(param_04)
	{
		scripts\mp\agents\_scriptedagents::func_F85E(0,"DoAttack");
	}

	if(func_252F(param_02))
	{
		self notify("attack_hit",param_02,param_03);
		var_16 = 0;
		if(isdefined(param_02))
		{
			var_16 = func_7AD3();
		}

		if(isdefined(self.var_B601))
		{
			var_16 = self.var_B601;
		}

		if(isdefined(param_08))
		{
			thread func_F08D(param_02,param_03,0.5);
		}

		if(isalive(param_02))
		{
			func_5904(param_02,var_16,"MOD_IMPACT");
		}

		level notify("attack_hit",self,param_02);
	}
	else
	{
		self notify("attack_miss",param_02,param_03);
	}

	self.var_A9B9 = self.origin;
	var_17 = var_10 - var_0D;
	if(var_17 > 0)
	{
		scripts\mp\agents\_scriptedagents::func_1384D(param_01,"end",var_17);
	}

	self.var_A9B8 = gettime();
}

//Function Number: 18
func_F08D(param_00,param_01,param_02)
{
	self endon("death");
	wait(param_02);
	if(func_252F(param_00))
	{
		self notify("attack_hit",param_00,param_01);
		var_03 = 0;
		if(isdefined(param_00))
		{
			var_03 = func_7AD3();
		}

		if(isdefined(self.var_B601))
		{
			var_03 = self.var_B601;
		}

		if(isalive(param_00))
		{
			func_5904(param_00,var_03,"MOD_IMPACT");
		}

		level notify("attack_hit",self,param_00);
		return;
	}

	self notify("attack_miss",param_00,param_01);
}

//Function Number: 19
func_7AD3()
{
	if(self.agent_type == "zombie_brute")
	{
		return 90;
	}

	return 45;
}

//Function Number: 20
func_5904(param_00,param_01,param_02)
{
	if(scripts\common\utility::func_9F11(param_00))
	{
		return;
	}

	if(isplayer(param_00))
	{
		if(param_00 scripts\common\utility::func_9F10(self))
		{
			return;
		}
	}

	param_00 dodamage(param_01,self.origin,self,self,param_02);
}

//Function Number: 21
func_12EC0(param_00,param_01,param_02,param_03)
{
	self endon("killanimscript");
	self endon("death");
	self endon("cancel_updatelerppos");
	param_00 endon("disconnect");
	param_00 endon("death");
	var_04 = self.origin;
	var_05 = param_01;
	var_06 = 0.05;
	for(;;)
	{
		wait(var_06);
		var_05 = var_05 - var_06;
		if(var_05 <= 0)
		{
			break;
		}

		var_07 = func_81F1(param_00,param_02);
		if(!isdefined(var_07))
		{
			break;
		}

		if(isdefined(param_03))
		{
			var_08 = param_03;
		}
		else
		{
			var_08 = lib_0F74::func_7FAE() - self.var_257;
		}

		var_09 = var_07 - var_04;
		if(lengthsquared(var_09) > var_08 * var_08)
		{
			var_07 = var_04 + vectornormalize(var_09) * var_08;
		}

		self method_8289("face enemy");
		self method_827B(self.origin,var_07,var_05);
	}
}

//Function Number: 22
func_81F1(param_00,param_01)
{
	if(!isdefined(param_00))
	{
		return undefined;
	}

	if(!param_01)
	{
		var_02 = scripts\mp\agents\_scriptedagents::func_5D51(param_00.origin);
		return var_02;
	}

	var_03 = param_01.origin - self.origin;
	var_04 = length(var_03);
	if(var_04 < self.var_252B)
	{
		return self.origin;
	}

	var_03 = var_03 / var_04;
	var_05 = lib_0F74::func_7FAA(param_01);
	if(lib_0F74::func_38C2(self.origin,var_05.origin))
	{
		return var_05.origin;
	}

	return undefined;
}

//Function Number: 23
func_252F(param_00)
{
	if(!isalive(param_00))
	{
		return 0;
	}

	if(!func_13D99())
	{
		return 0;
	}

	if(isplayer(param_00) || isai(param_00))
	{
		if(scripts\common\utility::istrue(self.var_29D2) && !scripts\common\utility::istrue(self.var_565C))
		{
			var_01 = [];
			var_01[0] = self;
			var_02 = self geteye() - (0,0,16);
			var_03 = param_00 geteye() - (0,0,16);
			var_04 = scripts\common\trace::func_109DD(var_02,var_03,4,var_01);
			if(var_04["fraction"] < 1)
			{
				var_05 = var_04["entity"];
				if(isdefined(var_05) && isai(var_05))
				{
					if(isdefined(var_05.team) && var_05.team == self.team)
					{
						if(distance(self.origin,var_05.origin) > 12)
						{
							return 0;
						}
					}
				}
			}
		}
	}

	if(func_9DD7(param_00,self.var_B607))
	{
		return 1;
	}

	if(lib_0F74::func_9DE0(param_00))
	{
		return 1;
	}

	return 0;
}

//Function Number: 24
func_9DD7(param_00,param_01)
{
	var_02 = vectornormalize(param_00.origin - self.origin * (1,1,0));
	var_03 = anglestoforward(self.angles);
	var_04 = vectordot(var_02,var_03);
	return var_04 > param_01;
}

//Function Number: 25
func_13D99()
{
	var_00 = self.entered_playspace;
	if(isdefined(self.var_10C) && !ispointonnavmesh(self.var_10C.origin) && !lib_0A1B::func_2955())
	{
		if(lib_0F74::func_DD7C("offmesh",var_00))
		{
			return 1;
		}
	}

	if(!lib_0F74::func_DD7C("normal",var_00))
	{
		return 0;
	}

	if(lib_0F74::func_7FAE() > self.var_B62E && !lib_0F74::func_13D9B())
	{
		return 0;
	}

	return 1;
}