/*******************************************************************
 * Decompiled By: Bog
 * Decompiled File: scripts\asm\zombie_dlc4\zombie_dlc4.gsc
 * Game: Call of Duty: Infinite Warfare
 * Platform: PC
 * Function Count: 21
 * Decompile Time: 1092 ms
 * Timestamp: 10/27/2023 12:03:03 AM
*******************************************************************/

//Function Number: 1
playtraverseanimz_dlc(param_00,param_01,param_02,param_03)
{
	scripts\mp\agents\_scriptedagents::func_F85E(1,"DoTraverse");
	var_04 = self.do_immediate_ragdoll;
	self.do_immediate_ragdoll = 1;
	dotraverseanim_dlc(param_00,param_01,param_02,param_03);
	self.do_immediate_ragdoll = var_04;
	self method_8282(1,1);
	scripts\mp\agents\_scriptedagents::func_F85E(0,"Traverse end_script");
	self.var_8C35 = 1;
	self.var_126CB = undefined;
}

//Function Number: 2
removezfromvec(param_00)
{
	return (param_00[0],param_00[1],0);
}

//Function Number: 3
dotraverseanim_dlc(param_00,param_01,param_02,param_03)
{
	self endon("death");
	self endon("terminate_ai_threads");
	var_04 = self method_8148();
	var_05 = self method_8146();
	self.var_6367 = var_05;
	if(!isdefined(var_04))
	{
		return;
	}

	if(!isdefined(var_05))
	{
		return;
	}

	self.var_6378 = var_05;
	self.var_126CB = vectornormalize(var_05 - var_04.origin);
	var_06 = undefined;
	var_06 = var_04.var_48;
	if(param_01 == "traverse_external")
	{
		var_06 = param_01;
	}

	if(needscrawlinganimstate_dlc(var_06))
	{
		var_06 = "crawling_" + var_06;
	}

	if(!isdefined(var_06))
	{
		return;
	}

	self.var_9CEC = 1;
	var_07 = lib_0A1D::func_2337(param_00,var_06);
	var_08 = var_05 - var_04.origin;
	var_09 = (var_08[0],var_08[1],0);
	var_0A = vectortoangles(var_09);
	var_0B = issubstr(var_06,"jump_across");
	var_0C = var_06 == "traverse_boost" && self.var_1096F == "humanoid" || self.var_1096F == "zombie";
	self method_8289("face angle abs",var_0A);
	self method_8281("anim deltas");
	var_0D = self method_80FD(var_06,var_07);
	var_0E = "flex_height_up_start_fix";
	var_0F = getnotetracktimes(var_0D,var_0E);
	if(var_0F.size == 0)
	{
		var_0E = "flex_height_up_start";
		var_0F = getnotetracktimes(var_0D,var_0E);
		if(var_0F.size == 0)
		{
			var_0E = "flex_height_start";
			var_0F = getnotetracktimes(var_0D,var_0E);
			if(var_0F.size == 0)
			{
				var_0E = "traverse_jump_start";
				var_0F = getnotetracktimes(var_0D,var_0E);
			}
		}
	}

	var_10 = "flex_height_up_end_fix";
	var_11 = getnotetracktimes(var_0D,var_10);
	if(var_11.size == 0)
	{
		var_10 = "flex_height_up_end";
		var_11 = getnotetracktimes(var_0D,var_10);
		if(var_11.size == 0)
		{
			var_10 = "flex_height_end";
			var_11 = getnotetracktimes(var_0D,var_10);
			if(var_11.size == 0)
			{
				var_10 = "traverse_jump_end";
				var_11 = getnotetracktimes(var_0D,var_10);
			}
		}
	}

	var_12 = "highest_point";
	var_13 = getnotetracktimes(var_0D,var_12);
	var_14 = "flex_height_down_start_fix";
	var_15 = getnotetracktimes(var_0D,var_14);
	if(var_15.size == 0)
	{
		var_14 = "flex_height_down_start";
		var_15 = getnotetracktimes(var_0D,var_14);
	}

	var_16 = "flex_height_down_end_fix";
	var_17 = getnotetracktimes(var_0D,var_16);
	if(var_17.size == 0)
	{
		var_16 = "flex_height_down_end";
		var_17 = getnotetracktimes(var_0D,var_16);
	}

	var_18 = "crawler_early_stop";
	var_19 = getnotetracktimes(var_0D,var_18);
	var_1A = getnotetracktimes(var_0D,"code_move");
	if(var_1A.size > 0)
	{
		var_1B = getmovedelta(var_0D,0,var_1A[0]);
	}
	else
	{
		var_1B = getmovedelta(var_0E,0,1);
	}

	var_1C = scripts\mp\agents\_scriptedagents::func_7DC9(var_08,var_1B);
	var_1D = animhasnotetrack(var_0D,"ignoreanimscaling");
	if(var_1D)
	{
		var_1C.var_13E2B = 1;
	}

	self method_828A("noclip");
	var_1E = self method_8145();
	if(isdefined(var_1E) && isdefined(var_1E.target))
	{
		self.var_6366 = var_1E;
		var_1F = scripts\common\utility::getstruct(self.var_6366.target,"targetname");
		if(var_13.size > 0)
		{
			scripts\mp\agents\_scriptedagents::func_5AC1(var_06,var_07,var_0D,"traverse",var_0E,var_12,0,::zombietraversenotetrackhandler_dlc);
			var_1F = scripts\common\utility::getstruct(self.var_6366.target,"targetname");
			if(isdefined(var_1F.script_noteworthy) && var_1F.script_noteworthy == "continue_flex_height")
			{
				scripts\mp\agents\_scriptedagents::func_5AC1(var_06,var_07,var_0D,"traverse",var_12,var_10,1,::zombietraversenotetrackhandler_dlc);
			}

			self method_8282(1,1);
			scripts\mp\agents\_scriptedagents::func_CED5(var_06,var_07,"traverse","end",::zombietraversenotetrackhandler_dlc);
		}
		else if(var_15.size == 0)
		{
			scripts\mp\agents\_scriptedagents::func_5AC1(var_06,var_07,var_0D,"traverse",var_0E,var_10,0,::zombietraversenotetrackhandler_dlc);
			self method_8282(1,1);
			scripts\mp\agents\_scriptedagents::func_CED5(var_06,var_07,"traverse","end",::zombietraversenotetrackhandler_dlc);
		}
		else if(var_0F.size == 0)
		{
			scripts\mp\agents\_scriptedagents::func_CED5(var_06,var_07,"traverse","flex_height_down_start",::zombietraversenotetrackhandler_dlc);
			scripts\mp\agents\_scriptedagents::func_5AC1(var_06,var_07,var_0D,"traverse",var_14,var_16,0,::zombietraversenotetrackhandler_dlc);
			self method_8282(1,1);
			scripts\mp\agents\_scriptedagents::func_CED5(var_06,var_07,"traverse","end",::zombietraversenotetrackhandler_dlc);
		}
		else
		{
			var_20 = scripts\common\utility::getstruct(self.var_6366.target,"targetname");
			var_1F = var_20.origin;
			var_21 = var_11[0];
			scripts\mp\agents\_scriptedagents::func_5AC2(var_06,var_07,"traverse",var_0D,var_0E,var_10,var_1F,var_21,::zombietraversenotetrackhandler_dlc);
			var_22 = getanimlength(var_0D);
			if(var_15[0] - var_11[0] >= 0.05 / var_22)
			{
				self method_8282(1,1);
				scripts\mp\agents\_scriptedagents::func_CED2(var_06,var_07,1,"traverse",var_14,::zombietraversenotetrackhandler_dlc);
			}

			var_21 = var_17[0];
			var_23 = getmovedelta(var_0D,var_21,1);
			var_1F = (self.var_6366.origin[0],self.var_6366.origin[1],self.var_6366.origin[2] - var_23[2]);
			scripts\mp\agents\_scriptedagents::func_5AC2(var_06,var_07,"traverse",var_0D,var_14,var_16,var_1F,var_21,::zombietraversenotetrackhandler_dlc);
			self method_8282(1,1);
			if(var_19.size == 0 || !scripts\common\utility::istrue(self.var_565C))
			{
				scripts\mp\agents\_scriptedagents::func_CED5(var_06,var_07,"traverse","end",::zombietraversenotetrackhandler_dlc);
			}
		}

		self.var_6366 = undefined;
	}
	else if(var_15.size > 0 && var_17.size > 0 && self.agent_type != "zombie_brute")
	{
		self method_8282(1,1);
		scripts\mp\agents\_scriptedagents::func_CED5(var_06,var_07,"traverse",var_14,::zombietraversenotetrackhandler_dlc);
		var_21 = var_17[0];
		if(!isdefined(var_1E))
		{
			var_1F = var_05;
		}
		else
		{
			var_1F = var_21.origin;
		}

		var_23 = getmovedelta(var_0D,var_21,1);
		var_1F = (var_1F[0],var_1F[1],var_1F[2] - var_23[2]);
		scripts\mp\agents\_scriptedagents::func_5AC2(var_06,var_07,"traverse",var_0D,var_14,var_16,var_1F,var_21,::zombietraversenotetrackhandler_dlc);
		if(var_19.size == 0 || !scripts\common\utility::istrue(self.var_565C))
		{
			scripts\mp\agents\_scriptedagents::func_CED5(var_06,var_07,"traverse","end",::zombietraversenotetrackhandler_dlc);
		}
	}
	else if(var_0B && abs(var_08[2]) < 64)
	{
		if(var_0F.size != 1)
		{
			var_0F = getnotetracktimes(var_0D,"flex_across_start");
		}

		if(var_11.size != 1)
		{
			var_11 = getnotetracktimes(var_0D,"flex_across_end");
		}

		var_22 = getanimlength(var_0D);
		var_24 = var_0F[0] * var_22;
		var_25 = var_11[0] * var_22;
		self method_8282(1,1);
		scripts\mp\agents\_scriptedagents::func_CED3(var_06,var_07,self.var_126E8,"traverse","flex_across_start");
		var_26 = removezfromvec(getmovedelta(var_0D,var_0F[0],var_11[0]));
		var_27 = distance2d(self.origin,var_05);
		var_28 = getmovedelta(var_0D,var_0F[0],1);
		var_29 = length2d(var_28);
		var_2A = var_27 - var_29;
		var_2B = length2d(var_26);
		if(var_2B < 0.01)
		{
			var_2B = 1;
		}

		var_2C = var_2A + var_2B / var_2B;
		self method_8282(var_2C,0);
		childthread traverse_lerp_z_over_time_dlc(var_04.origin[2],var_05[2],var_25 - var_24 / self.var_126E8);
		scripts\mp\agents\_scriptedagents::func_CED3(var_06,var_07,self.var_126E8,"traverse","flex_across_end");
		self method_8282(1,1);
		scripts\mp\agents\_scriptedagents::func_CED3(var_06,var_07,self.var_126E8,"traverse");
	}
	else if(var_08[2] > 16)
	{
		if(var_1B[2] > 0)
		{
			if(var_0C)
			{
				self method_8282(var_1C.var_13E2B,var_1C.var_3A6);
				var_2D = clamp(2 / var_1C.var_3A6,0.5,1);
				if(var_11.size > 0)
				{
					scripts\mp\agents\_scriptedagents::func_CED3(var_06,var_07,var_2D * self.var_126E8,"traverse",var_10);
					scripts\mp\agents\_scriptedagents::func_F85E(0,"DoTraverse");
					scripts\mp\agents\_scriptedagents::func_F2B1(var_06,var_07,self.var_126E8);
					scripts\mp\agents\_scriptedagents::func_1384D("traverse","code_move");
				}
				else
				{
					scripts\mp\agents\_scriptedagents::func_CED3(var_06,var_07,self.var_126E8,"traverse");
				}

				self method_8282(1,1);
			}
			else if(var_0F.size > 0)
			{
				var_1C.var_13E2B = 1;
				var_1C.var_3A6 = 1;
				if(!var_1D && length2dsquared(var_09) < 0.64 * length2dsquared(var_1B))
				{
					var_1C.var_13E2B = 0.4;
				}

				self method_8282(var_1C.var_13E2B,var_1C.var_3A6);
				scripts\mp\agents\_scriptedagents::func_CED3(var_06,var_07,self.var_126E8,"traverse",var_0E);
				var_2E = getmovedelta(var_0D,0,var_0F[0]);
				var_2F = getmovedelta(var_0D,0,var_11[0]);
				var_1C.var_13E2B = 1;
				var_1C.var_3A6 = 1;
				var_30 = var_05 - self.origin;
				var_31 = var_1B - var_2E;
				if(!var_1D && length2dsquared(var_30) < 0.5625 * length2dsquared(var_31))
				{
					var_1C.var_13E2B = 0.75;
				}

				var_32 = var_1B - var_2F;
				var_33 = (var_32[0] * var_1C.var_13E2B,var_32[1] * var_1C.var_13E2B,var_32[2] * var_1C.var_3A6);
				var_34 = rotatevector(var_33,var_0A);
				var_35 = var_05 - var_34;
				var_36 = var_2F - var_2E;
				var_37 = rotatevector(var_36,var_0A);
				var_38 = var_35 - self.origin;
				var_39 = var_1C;
				var_1C = scripts\mp\agents\_scriptedagents::func_7DC9(var_38,var_37,1);
				if(var_1D)
				{
					var_1C.var_13E2B = 1;
				}

				if(var_38[2] <= 0)
				{
					var_1C.var_3A6 = 0;
				}

				self method_8282(var_1C.var_13E2B,var_1C.var_3A6);
				scripts\mp\agents\_scriptedagents::func_1384D("traverse",var_10);
				scripts\mp\agents\_scriptedagents::func_F85E(0,"DoTraverse");
				var_1C = var_39;
				self method_8282(var_1C.var_13E2B,var_1C.var_3A6);
				scripts\mp\agents\_scriptedagents::func_1384D("traverse","code_move");
			}
			else
			{
				self method_8282(var_1C.var_13E2B,var_1C.var_3A6);
				scripts\mp\agents\_scriptedagents::func_CED3(var_06,var_07,self.var_126E8,"traverse");
			}
		}
		else
		{
			scripts\mp\agents\_scriptedagents::func_5AC1(var_06,var_07,var_0D,"traverse","flex_height_start","flex_height_end",1,::zombietraversenotetrackhandler_dlc);
		}
	}
	else if(abs(var_08[2]) < 16 || var_1B[2] == 0)
	{
		self method_8282(var_1C.var_13E2B,var_1C.var_3A6);
		var_2D = clamp(2 / var_1C.var_3A6,0.5,1);
		if(var_11.size > 0)
		{
			scripts\mp\agents\_scriptedagents::func_CED3(var_06,var_07,var_2D * self.var_126E8,"traverse",var_10);
			scripts\mp\agents\_scriptedagents::func_F85E(0,"DoTraverse");
			scripts\mp\agents\_scriptedagents::func_F2B1(var_06,var_07,self.var_126E8);
			scripts\mp\agents\_scriptedagents::func_1384D("traverse","code_move");
		}
		else
		{
			scripts\mp\agents\_scriptedagents::func_CED3(var_06,var_07,self.var_126E8,"traverse");
		}

		self method_8282(1,1);
	}
	else if(var_1B[2] < 0)
	{
		self method_8282(var_1C.var_13E2B,var_1C.var_3A6);
		var_2D = clamp(2 / var_1C.var_3A6,0.5,1);
		if(var_0F.size > 0)
		{
			scripts\mp\agents\_scriptedagents::func_CED3(var_06,var_07,self.var_126E8,"traverse",var_0E);
		}

		if(var_11.size > 0)
		{
			scripts\mp\agents\_scriptedagents::func_CED3(var_06,var_07,var_2D * 1,"traverse",var_10);
			scripts\mp\agents\_scriptedagents::func_F2B1(var_06,var_07,self.var_126E8);
			if(animhasnotetrack(var_0D,"removestatelock"))
			{
				scripts\mp\agents\_scriptedagents::func_1384D("traverse","removestatelock");
			}

			scripts\mp\agents\_scriptedagents::func_F85E(0,"DoTraverse");
			scripts\mp\agents\_scriptedagents::func_1384D("traverse","code_move");
		}
		else
		{
			scripts\mp\agents\_scriptedagents::func_CED3(var_06,var_07,1,"traverse");
		}

		self method_8282(1,1);
	}
	else
	{
	}

	lerptoabovegrounddlc();
	self method_828A("gravity");
	self.var_9CEC = undefined;
	self notify("traverse_end");
	terminatetraverse_dlc(param_00,param_01);
}

//Function Number: 4
lerptoabovegrounddlc()
{
	var_00 = 0.1;
	var_01 = self.var_6378;
	var_02 = var_01[2];
	var_03 = self.origin[2];
	var_04 = getgroundposition(var_01,8);
	var_05 = var_04[2];
	if(var_03 < var_05)
	{
		self setorigin((self.origin[0],self.origin[1],var_05 + var_00),0);
	}
}

//Function Number: 5
terminatetraverse_dlc(param_00,param_01)
{
	var_02 = level.var_2303[param_00].var_10E2F[param_01];
	var_03 = undefined;
	if(isdefined(var_02.var_116FB))
	{
		if(isarray(var_02.var_116FB[0]))
		{
			var_03 = var_02.var_116FB[0];
		}
		else
		{
			var_03 = var_02.var_116FB;
		}
	}

	lib_0A1A::func_2388(param_00,param_01,var_02,var_02.var_116FB);
	lib_0A1A::func_238A(param_00,var_03,0.2,undefined,undefined,undefined);
	self notify("killanimscript");
}

//Function Number: 6
traverse_lerp_z_over_time_dlc(param_00,param_01,param_02)
{
	self endon("death");
	self endon("terminate_ai_threads");
	var_03 = gettime();
	for(;;)
	{
		var_04 = gettime() - var_03 / 1000;
		var_05 = var_04 / param_02;
		if(var_05 > 1)
		{
			break;
		}

		var_06 = lib_0F74::func_AB6F(var_05,param_00,param_01);
		self setorigin((self.origin[0],self.origin[1],var_06),0);
		wait(0.05);
	}
}

//Function Number: 7
needscrawlinganimstate_dlc(param_00)
{
	if(self.var_565C)
	{
		return 1;
	}

	return 0;
}

//Function Number: 8
zombietraversenotetrackhandler_dlc(param_00,param_01,param_02,param_03)
{
	switch(param_00)
	{
		case "apply_physics":
			self method_828A("gravity");
			break;

		default:
			break;
	}
}

//Function Number: 9
choosestandingdeathanim_dlc(param_00,param_01,param_02,param_03)
{
	if(!scripts\common\utility::istrue(self.kung_fu_punched))
	{
		if(scripts\common\utility::istrue(self.electrocuted))
		{
			return lib_0A1A::func_2358(param_01,"electrocuted");
		}
	}

	return lib_0C71::func_3F00(param_00,param_01,param_02,param_03);
}

//Function Number: 10
choosemovingdeathanim_dlc(param_00,param_01,param_02)
{
	return lib_0C71::func_3EE2(param_00,param_01,param_02);
}

//Function Number: 11
chooseballoongrabanim(param_00,param_01,param_02)
{
	if(lib_0C75::func_BE92())
	{
		return lib_0A1A::func_2358(param_01,"prone");
	}

	return lib_0A1A::func_2358(param_01,"stand");
}

//Function Number: 12
handleballoonfloating()
{
	self endon("death");
	wait(randomfloatrange(5,5.9));
	self notify("reached_end");
	self unlink();
	self setvelocity((randomintrange(-10,10),randomintrange(-10,10),-50));
	self.do_immediate_ragdoll = 1;
	self.var_4C87 = 1;
	playfx(level._effect["balloon_death"],self.balloon_in_hand.origin + (0,0,50));
	playsoundatpos(self.origin,"craftable_balloon_zmb_explo");
	self dodamage(self.health + 100,self.origin,undefined,undefined,"MOD_EXPLOSIVE","zmb_imsprojectile_mp");
}

//Function Number: 13
balloongrabnotehandler(param_00,param_01,param_02,param_03)
{
	if(param_00 == "balloon_attach")
	{
		var_04 = ["decor_balloon_a_blue","decor_balloon_a_blue_light","decor_balloon_a_cyan","decor_balloon_a_green","decor_balloon_a_green_light","decor_balloon_a_orange","decor_balloon_a_pink","decor_balloon_a_purple","decor_balloon_a_purple_deep","decor_balloon_a_red","decor_balloon_a_yellow"];
		var_05 = self gettagorigin("j_shoulder_ri");
		self.balloon_in_hand = spawn("script_model",var_05);
		self.balloon_model = scripts\common\utility::random(var_04);
		if(self.bholdingballooninleft)
		{
			self attach(self.balloon_model,"tag_accessory_left");
		}
		else
		{
			self attach(self.balloon_model,"tag_accessory_right");
		}

		self.balloon_in_hand.origin = var_05;
		self linkto(self.balloon_in_hand);
		self playerlinkedoffsetenable();
		var_06 = randomintrange(-50,50);
		var_07 = randomintrange(-50,50);
		self.balloon_in_hand moveto(self.origin + (var_06,var_07,self.detonate_height),6,3);
		self.balloon_in_hand rotateyaw(randomint(360),6);
		thread handleballoonfloating();
	}
}

//Function Number: 14
chooseballoonfloatanim(param_00,param_01,param_02)
{
	if(scripts\common\utility::istrue(self.bholdingballooninleft))
	{
		return lib_0A1A::func_2358(param_01,"left");
	}

	return lib_0A1A::func_2358(param_01,"right");
}

//Function Number: 15
shouldballoongrableft(param_00,param_01,param_02,param_03)
{
	self.bholdingballooninleft = undefined;
	if(lib_0C72::func_9EA5())
	{
		self.bholdingballooninleft = 1;
	}
	else if(randomintrange(0,100) < 50)
	{
		self.bholdingballooninleft = 1;
	}
	else
	{
		self.bholdingballooninleft = 0;
	}

	return self.bholdingballooninleft;
}

//Function Number: 16
isdismembermentdisabled(param_00,param_01,param_02,param_03)
{
	if(scripts\common\utility::istrue(self.var_55CF))
	{
		return 1;
	}

	return 0;
}

//Function Number: 17
shoulddosharpturn_dlc(param_00,param_01,param_02,param_03)
{
	return lib_0F3B::func_FFF8(param_00,param_01,param_02,param_03);
}

//Function Number: 18
isdiscofeverdone(param_00,param_01,param_02,param_03)
{
	return !hasdiscofever(param_00,param_01,param_02,param_03);
}

//Function Number: 19
hasdiscofever(param_00,param_01,param_02,param_03)
{
	return scripts\common\utility::istrue(self.bhasdiscofever);
}

//Function Number: 20
shoot_generic_dlc(param_00,param_01,param_02,param_03)
{
	self endon(param_01 + "_finished");
	lib_0F3E::func_FE89();
	var_04 = lib_0F3E::func_FE64();
	self method_83CE();
	var_05 = lib_0A1D::func_2337(param_00,param_01);
	shootburst_dlc(param_01,0.2,2);
	self.var_2303.var_FECD.var_C21C--;
	lib_0F3E::func_32BE();
	lib_0A1A::func_2330(param_01,"shoot_finished");
}

//Function Number: 21
shootburst_dlc(param_00,param_01,param_02)
{
	var_03 = param_00 + "_timeout";
	var_04 = param_00 + "_timeout_end";
	thread lib_0F3E::func_FE84(var_03,var_04,param_02);
	self endon(var_03);
	self endon(param_00 + "_finished");
	var_05 = 0;
	var_06 = self.var_2303.var_FECD.var_FF0B;
	var_07 = var_06 == 1;
	var_08 = 0;
	var_09 = scripts\anim\utility_common::func_13C40();
	while(var_05 < var_06 && var_06 > 0)
	{
		if(!isdefined(self.var_1198.var_FECD))
		{
			break;
		}

		if(isdefined(self.var_10C))
		{
			if(!lib_0F3C::func_9DED() && !lib_0F3C::func_9FFF())
			{
				break;
			}
		}

		self.var_A9ED = gettime();
		var_0A = lib_0F3C::func_811C();
		var_0B = lib_0F3C::func_811E(var_0A);
		self method_837B(1,var_0B,1,0,1);
		if(self.var_3250 > 0)
		{
			if(var_08)
			{
				if(randomint(3) == 0)
				{
					self.var_3250--;
				}
			}
			else
			{
				self.var_3250--;
			}
		}

		var_05++;
		if(var_09)
		{
			childthread lib_0F3E::func_FE7D(param_00);
		}

		if(self.var_2303.var_FECD.var_6B92 && var_05 == var_06)
		{
			break;
		}

		wait(param_01);
	}

	self notify(var_04);
}