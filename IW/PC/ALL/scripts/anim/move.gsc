/*******************************************************************
 * Decompiled By: Bog
 * Decompiled File: scripts\anim\move.gsc
 * Game: Call of Duty: Infinite Warfare
 * Platform: PC
 * Function Count: 41
 * Decompile Time: 2071 ms
 * Timestamp: 10/27/2023 12:00:42 AM
*******************************************************************/

//Function Number: 1
func_951A()
{
}

//Function Number: 2
main()
{
	if(getdvarint("ai_iw7",0) == 1)
	{
		func_89C7();
		return;
	}

	if(isdefined(self.var_4C37))
	{
		if(isdefined(self.var_4C37["move"]))
		{
			[[ self.var_4C37["move"] ]]();
			return;
		}
	}

	self endon("killanimscript");
	[[ self.var_68C6["move"] ]]();
	func_BCBE();
	func_81F3();
	scripts\anim\utility::func_9832("move");
	var_00 = func_1391A();
	if(var_00 && isdefined(self.var_1016F))
	{
		func_BCAD();
		func_BCB0();
	}
	else if(isdefined(self.var_28CF) && self.var_28CF)
	{
		func_BCF9(var_00);
		scripts\anim\battlechatter::func_CEE8();
	}

	thread func_12F27();
	var_01 = ::func_C968;
	if(isdefined(self.var_C967))
	{
		var_01 = self.var_C967;
	}

	self thread [[ var_01 ]]();
	thread func_1FAE();
	scripts\anim\exit_node::func_10DCA();
	self.var_58DC = undefined;
	self.var_932E = undefined;
	thread func_10DFD();
	func_AD66();
	self.var_FE92 = undefined;
	self.var_1A32 = undefined;
	self.var_E873 = undefined;
	func_BCC4(1);
}

//Function Number: 3
func_010B()
{
	if(getdvarint("ai_iw7",0) == 1)
	{
		return;
	}

	if(isdefined(self.var_C3F2))
	{
		self.var_166 = self.var_C3F2;
		self.var_C3F2 = undefined;
	}

	self.var_115CE = undefined;
	self.var_B7B5 = undefined;
	self.var_932E = undefined;
	self.var_1016F = undefined;
	self.var_10171 = undefined;
	self.var_E873 = undefined;
	self.var_DD39 = undefined;
	self.var_E1B0 = undefined;
	self.var_4BE6 = undefined;
	self.var_BCC3 = undefined;
	scripts\anim\run::func_F843(0);
	self method_806F(%head,0.2);
	self.var_6A89 = undefined;
}

//Function Number: 4
func_89C7()
{
	lib_0A1B::func_2967();
	self waittill("killanimscript");
	lib_0A1B::func_2917();
}

//Function Number: 5
func_BCBE()
{
	self.var_DD39 = undefined;
	self.var_E1B0 = undefined;
	self.var_12DEF = undefined;
	self.var_12DF0 = undefined;
	self.var_E879 = 0;
	self.var_22F0 = undefined;
}

//Function Number: 6
func_81F3()
{
	if(self.var_1491.var_D6A5 == "prone")
	{
		var_00 = scripts\anim\utility::func_3EF2("stand");
		if(var_00 != "prone")
		{
			self method_8221("face current");
			self method_8016("zonly_physics",0);
			var_01 = 1;
			if(isdefined(self.var_15F))
			{
				var_01 = 2;
			}

			scripts\anim\cover_prone::func_DA87(var_00,var_01);
			self method_8016("none",0);
			self method_8221("face default");
		}
	}
}

//Function Number: 7
func_1391A()
{
	switch(self.var_24B)
	{
		case "turret":
		case "cover_wide_right":
		case "cover_wide_left":
		case "concealment_stand":
		case "concealment_prone":
		case "concealment_crouch":
		case "cover_prone":
		case "cover_stand":
		case "cover_left":
		case "cover_right":
		case "cover_crouch":
		case "hide":
			return 1;
	}

	return 0;
}

//Function Number: 8
func_BCF9(param_00)
{
	if(self.var_1F5 == "run")
	{
		scripts\anim\battlechatter_ai::func_67D2(param_00);
	}
}

//Function Number: 9
func_BCC4(param_00)
{
	func_BCC5(param_00);
	self notify("abort_reload");
}

//Function Number: 10
func_2125()
{
	if(isdefined(self.var_1F62) && self.var_1F62 != self.var_D8B6)
	{
		return 1;
	}
	else if(!isdefined(self.var_1F62) && self.var_D8B6 != "none")
	{
		return 1;
	}

	return 0;
}

//Function Number: 11
func_12ED4(param_00)
{
	if(param_00 != self.var_D8B7 || func_2125())
	{
		if(isdefined(self.var_4C8F) && isdefined(self.var_4C8F[param_00]))
		{
			self.var_1491.var_BCA5 = self.var_4C8F[param_00];
		}
		else
		{
			self.var_1491.var_BCA5 = scripts\anim\utility::func_B028(param_00);
			if((self.var_BC == "ambush" || self.var_BC == "ambush_nodes_only") && isdefined(self.var_233) && distancesquared(self.origin,self.var_233) > squared(100))
			{
				self.var_101BB = 1;
				scripts\anim\animset::func_F2AC();
			}
			else
			{
				self.var_101BB = 1.35;
			}
		}

		self.var_D8B7 = param_00;
		if(isdefined(self.var_1F62))
		{
			self.var_D8B6 = self.var_1F62;
		}
	}
}

//Function Number: 12
func_BCC5(param_00)
{
	self endon("killanimscript");
	self endon("move_interrupt");
	var_01 = self method_8102(%walk_and_run_loops);
	self.var_1491.var_E860 = randomint(10000);
	self.var_D8B7 = "none";
	self.var_D8B6 = "none";
	self.var_BCC2 = undefined;
	for(;;)
	{
		var_02 = self method_8102(%walk_and_run_loops);
		if(var_02 < var_01)
		{
			self.var_1491.var_E860++;
		}

		var_01 = var_02;
		func_12ED4(self.var_1F5);
		if(isdefined(self.var_BCC7))
		{
			self [[ self.var_BCC7 ]](self.var_1F5);
		}
		else
		{
			func_BCC6(self.var_1F5);
		}

		if(isdefined(self.var_BCC2))
		{
			self [[ self.var_BCC2 ]]();
			self.var_BCC2 = undefined;
		}

		self notify("abort_reload");
	}
}

//Function Number: 13
func_BCC6(param_00)
{
	self endon("move_loop_restart");
	if(isdefined(self.var_BCC3))
	{
		self [[ self.var_BCC3 ]]();
	}
	else if(scripts\anim\utility::func_FFDB())
	{
		scripts\anim\cqb::func_BCB1();
	}
	else if(param_00 == "run")
	{
		scripts\anim\run::func_BCEB();
	}
	else
	{
		scripts\anim\walk::func_BD2B();
	}

	self.var_E1B0 = undefined;
}

//Function Number: 14
func_B4EC()
{
	if(self.var_394 == "none")
	{
		return 0;
	}

	var_00 = weaponclass(self.var_394);
	if(!scripts\anim\utility_common::func_1311A())
	{
		return 0;
	}

	if(scripts\anim\utility_common::func_9D4D())
	{
		if(!scripts\anim\utility::func_9D9B() && self.var_12A)
		{
			return 0;
		}
	}

	if(isdefined(self.var_596C))
	{
		return 0;
	}

	return 1;
}

//Function Number: 15
func_FEEB()
{
	self endon("killanimscript");
	self notify("doing_shootWhileMoving");
	self endon("doing_shootWhileMoving");
	var_00 = scripts\anim\utility::func_B028("shoot_while_moving");
	foreach(var_03, var_02 in var_00)
	{
		self.var_1491.var_2274[var_03] = var_02;
	}

	if(isdefined(self.var_440C) && isdefined(self.var_440C["fire"]))
	{
		self.var_1491.var_2274["fire"] = self.var_440C["fire"];
	}

	if(isdefined(self.var_394) && scripts\anim\utility_common::func_13C40())
	{
		self.var_1491.var_2274["single"] = scripts\anim\utility::func_B027("shotgun_stand","single");
	}

	for(;;)
	{
		if(!self.var_3250)
		{
			if(scripts\anim\utility::func_9D9C())
			{
				self.var_1E3F = 0;
				scripts\anim\utility_common::func_3D55();
			}

			if(!self.var_3250)
			{
				wait(0.5);
				continue;
			}
		}

		scripts\anim\combat_utility::func_FEDF();
		self method_806F(%exposed_aiming,0.2);
	}
}

//Function Number: 16
func_10DFD()
{
	self endon("killanimscript");
	wait(0.05);
	thread func_325C();
	thread func_B5DF();
	thread scripts\anim\door::func_940A();
	thread scripts\anim\door::func_5A09();
}

//Function Number: 17
func_12F27()
{
	self endon("killanimscript");
	self.var_D8C1 = self.var_2C0;
	for(;;)
	{
		wait(0.05);
		if(self.var_D8C1 != self.var_2C0)
		{
			if(!isdefined(self.var_932E) || self.var_2C0 != "none")
			{
				self notify("move_loop_restart");
			}
		}

		self.var_D8C1 = self.var_2C0;
	}
}

//Function Number: 18
func_E2B4(param_00)
{
	self endon("killanimscript");
	if(!param_00)
	{
		scripts\anim\exit_node::func_10DCA();
	}

	self.var_932E = undefined;
	self method_806F(%root,0.1);
	self method_8221("face default");
	self method_8016("none",0);
	self.var_263 = 1;
	func_BCC4(!param_00);
}

//Function Number: 19
func_C968()
{
	self endon("killanimscript");
	self endon("move_interrupt");
	self.var_932E = 1;
	for(;;)
	{
		self waittill("path_changed",var_00,var_01);
		if(isdefined(self.var_932E) || isdefined(self.var_C189))
		{
			continue;
		}

		if(!isdefined(self.var_36F) || !self.var_36F)
		{
			if(!self.var_12A || abs(self method_813E()) > 15)
			{
				continue;
			}
		}

		if(self.var_1491.var_D6A5 != "stand")
		{
			continue;
		}

		self notify("stop_move_anim_update");
		self.var_12DEF = undefined;
		var_02 = vectortoangles(var_01);
		var_03 = angleclamp180(self.angles[1] - var_02[1]);
		var_04 = angleclamp180(self.angles[0] - var_02[0]);
		var_05 = func_C966(var_03,var_04);
		if(isdefined(var_05))
		{
			self.var_1299D = var_05;
			self.var_129B0 = gettime();
			self.var_BCC3 = ::func_C965;
			self notify("move_loop_restart");
			scripts\anim\run::func_6318();
		}
	}
}

//Function Number: 20
func_C966(param_00,param_01)
{
	if(isdefined(self.var_C976))
	{
		return [[ self.var_C976 ]](param_00,param_01);
	}

	var_02 = undefined;
	var_03 = undefined;
	if(self.var_1F5 == "walk")
	{
		var_04 = scripts\anim\utility::func_B028("cqb_turn");
	}
	else if(scripts\anim\utility::func_FFDB())
	{
		var_04 = scripts\anim\utility::func_B028("cqb_run_turn");
	}
	else
	{
		var_04 = scripts\anim\utility::func_B028("run_turn");
	}

	if(param_00 < 0)
	{
		if(param_00 > -45)
		{
			var_05 = 3;
		}
		else
		{
			var_05 = int(ceil(param_01 + 180 - 10 / 45));
		}
	}
	else if(param_01 < 45)
	{
		var_05 = 5;
	}
	else
	{
		var_05 = int(floor(param_01 + 180 + 10 / 45));
	}

	var_02 = var_04[var_05];
	if(isdefined(var_02))
	{
		if(isarray(var_02))
		{
			while(var_02.size > 0)
			{
				var_06 = randomint(var_02.size);
				if(func_C963(var_02[var_06]))
				{
					return var_02[var_06];
				}

				var_02[var_06] = var_02[var_02.size - 1];
				var_02[var_02.size - 1] = undefined;
			}
		}
		else if(func_C963(var_02))
		{
			return var_02;
		}
	}

	var_07 = -1;
	if(param_00 < -60)
	{
		var_07 = int(ceil(param_00 + 180 / 45));
		if(var_07 == var_05)
		{
			var_07 = var_05 - 1;
		}
	}
	else if(param_00 > 60)
	{
		var_07 = int(floor(param_00 + 180 / 45));
		if(var_07 == var_05)
		{
			var_07 = var_05 + 1;
		}
	}

	if(var_07 >= 0 && var_07 < 9)
	{
		var_03 = var_04[var_07];
	}

	if(isdefined(var_03))
	{
		if(isarray(var_03))
		{
			var_03 = var_03[0];
		}

		if(func_C963(var_03))
		{
			return var_03;
		}
	}

	return undefined;
}

//Function Number: 21
func_C963(param_00)
{
	if(!isdefined(self.var_233))
	{
		return 0;
	}

	var_01 = getnotetracktimes(param_00,"code_move");
	var_02 = var_01[0];
	var_03 = getmovedelta(param_00,0,var_02);
	var_04 = self method_81E7(var_03);
	if(isdefined(self.var_22F0) && squared(self.var_22F0) > distancesquared(self.var_233,var_04))
	{
		return 0;
	}

	var_03 = getmovedelta(param_00,0,1);
	var_05 = self method_81E7(var_03);
	var_05 = var_04 + vectornormalize(var_05 - var_04) * 20;
	var_06 = !scripts\common\utility::func_167E();
	return self method_81FF(var_04,var_05,var_06,1);
}

//Function Number: 22
func_C965()
{
	self endon("killanimscript");
	self.var_BCC3 = undefined;
	var_00 = self.var_1299D;
	if(gettime() > self.var_129B0 + 50)
	{
		return;
	}

	if(scripts\common\utility::func_167E())
	{
		self method_8016("nogravity",0);
	}
	else
	{
		self method_8016("zonly_physics",0);
	}

	var_01 = 0.1;
	if(isdefined(self.var_C975))
	{
		var_01 = self.var_C975;
	}

	self method_806F(%body,var_01);
	self.var_BCC2 = ::func_C964;
	self.var_932E = 1;
	var_01 = 0.05;
	if(isdefined(self.var_C975))
	{
		var_01 = self.var_C975;
	}

	self method_82EA("turnAnim",var_00,1,var_01,self.var_BCD6);
	if(scripts\common\utility::func_167E())
	{
		self method_8221("face angle 3d",self.angles);
	}
	else
	{
		self method_8221("face angle",self.angles[1]);
	}

	scripts\anim\shared::func_592B("turnAnim");
	self.var_932E = undefined;
	self method_8221("face motion");
	self method_8016("none",0);
	scripts\anim\shared::func_592B("turnAnim");
}

//Function Number: 23
func_C964()
{
	self.var_932E = undefined;
	self method_8221("face default");
	self method_806F(%root,0.1);
	self method_8016("none",0);
}

//Function Number: 24
func_580E()
{
	self method_8250(1);
	self method_8016("zonly_physics",0);
	self method_806F(%body,0.2);
	self method_82EA("dodgeAnim",self.var_4BE6,1,0.2,1);
	scripts\anim\shared::func_592B("dodgeAnim");
	self method_8016("none",0);
	self method_8221("face default");
	if(animhasnotetrack(self.var_4BE6,"code_move"))
	{
		scripts\anim\shared::func_592B("dodgeAnim");
	}

	self method_806F(%civilian_dodge,0.2);
	self method_8250(0);
	self.var_4BE6 = undefined;
	self.var_BCC3 = undefined;
	return 1;
}

//Function Number: 25
func_12898(param_00,param_01)
{
	var_02 = (self.var_1BE[1],-1 * self.var_1BE[0],0);
	var_03 = self.var_1BE * param_01[0];
	var_04 = var_02 * param_01[1];
	var_05 = self.origin + var_03 - var_04;
	self method_8250(1);
	if(self method_8200(var_05))
	{
		self.var_4BE6 = param_00;
		self.var_BCC3 = ::func_580E;
		self notify("move_loop_restart");
		return 1;
	}

	self method_8250(0);
	return 0;
}

//Function Number: 26
func_1FAE()
{
	if(!isdefined(self.var_580B) || !isdefined(self.var_580F))
	{
		return;
	}

	self endon("killanimscript");
	self endon("move_interrupt");
	for(;;)
	{
		self waittill("path_need_dodge",var_00,var_01);
		scripts\anim\utility::func_12EB9();
		if(scripts\anim\utility::func_9E40())
		{
			self.var_20B = 0;
			return;
		}

		if(!issentient(var_00))
		{
			continue;
		}

		var_02 = vectornormalize(var_01 - self.origin);
		if(self.var_1BE[0] * var_02[1] - var_02[0] * self.var_1BE[1] > 0)
		{
			if(!func_12898(self.var_580F,self.var_5810))
			{
				func_12898(self.var_580B,self.var_580C);
			}
		}
		else if(!func_12898(self.var_580B,self.var_580C))
		{
			func_12898(self.var_580F,self.var_5810);
		}

		if(isdefined(self.var_4BE6))
		{
			wait(getanimlength(self.var_4BE6));
			continue;
		}

		wait(0.1);
	}
}

//Function Number: 27
func_F6CD(param_00,param_01)
{
	self.var_20B = 1;
	self.var_580B = param_00;
	self.var_580F = param_01;
	var_02 = 1;
	if(animhasnotetrack(param_00,"code_move"))
	{
		var_02 = getnotetracktimes(param_00,"code_move")[0];
	}

	self.var_580C = getmovedelta(param_00,0,var_02);
	var_02 = 1;
	if(animhasnotetrack(param_01,"code_move"))
	{
		var_02 = getnotetracktimes(param_01,"code_move")[0];
	}

	self.var_5810 = getmovedelta(param_01,0,var_02);
	self.var_190 = 80;
}

//Function Number: 28
func_41A8()
{
	self.var_20B = 0;
	self.var_580B = undefined;
	self.var_580F = undefined;
	self.var_580C = undefined;
	self.var_5810 = undefined;
}

//Function Number: 29
func_B5DF()
{
}

//Function Number: 30
func_325C()
{
	self endon("killanimscript");
	if(isdefined(self.var_55B5))
	{
		return;
	}

	for(;;)
	{
		self waittill("bulletwhizby",var_00);
		if(self.var_1F5 != "run" || !self.var_12A || self.var_1491.var_D6A5 != "stand" || isdefined(self.var_DD39))
		{
			continue;
		}

		if(self.var_2C0 != "none")
		{
			continue;
		}

		if(!isdefined(self.var_10C) && !self.var_180 && isdefined(var_00.team) && function_0106(self.team,var_00.team))
		{
			self.var_13D13 = var_00;
			self method_8015(::scripts\anim\reactions::func_325E);
			continue;
		}

		if(self.var_1C0 || self.var_1BF < 100)
		{
			continue;
		}

		if(isdefined(self.var_233) && distancesquared(self.origin,self.var_233) < 10000)
		{
			wait(0.2);
			continue;
		}

		self.var_E1B0 = gettime();
		self notify("move_loop_restart");
		scripts\anim\run::func_6318();
	}
}

//Function Number: 31
func_7C69(param_00,param_01)
{
	var_02 = param_01.type;
	if(var_02 == "Cover Left")
	{
		return scripts\anim\utility::func_B027("shuffle","shuffle_start_from_cover_left");
	}

	if(var_02 == "Cover Right")
	{
		return scripts\anim\utility::func_B027("shuffle","shuffle_start_from_cover_right");
	}

	if(param_00)
	{
		return scripts\anim\utility::func_B027("shuffle","shuffle_start_left");
	}

	return scripts\anim\utility::func_B027("shuffle","shuffle_start_right");
}

//Function Number: 32
func_FA42(param_00,param_01,param_02)
{
	var_03 = [];
	var_04 = param_02.type;
	if(var_04 == "Cover Left")
	{
		var_03["shuffle_start"] = func_7C69(param_00,param_01);
		var_03["shuffle"] = scripts\anim\utility::func_B027("shuffle","shuffle_to_cover_left");
		var_03["shuffle_end"] = scripts\anim\utility::func_B027("shuffle","shuffle_end_to_cover_left");
	}
	else if(var_04 == "Cover Right")
	{
		var_03["shuffle_start"] = func_7C69(param_00,param_01);
		var_03["shuffle"] = scripts\anim\utility::func_B027("shuffle","shuffle_to_cover_right");
		var_03["shuffle_end"] = scripts\anim\utility::func_B027("shuffle","shuffle_end_to_cover_right");
	}
	else if(var_04 == "Cover Stand" && param_01.type == var_04)
	{
		if(param_00)
		{
			var_03["shuffle_start"] = scripts\anim\utility::func_B027("shuffle","shuffle_start_left_stand_to_stand");
			var_03["shuffle"] = scripts\anim\utility::func_B027("shuffle","shuffle_left_stand_to_stand");
			var_03["shuffle_end"] = scripts\anim\utility::func_B027("shuffle","shuffle_end_left_stand_to_stand");
		}
		else
		{
			var_03["shuffle_start"] = scripts\anim\utility::func_B027("shuffle","shuffle_start_right_stand_to_stand");
			var_03["shuffle"] = scripts\anim\utility::func_B027("shuffle","shuffle_right_stand_to_stand");
			var_03["shuffle_end"] = scripts\anim\utility::func_B027("shuffle","shuffle_end_right_stand_to_stand");
		}
	}
	else if(param_00)
	{
		var_03["shuffle_start"] = func_7C69(param_00,param_01);
		var_03["shuffle"] = scripts\anim\utility::func_B027("shuffle","shuffle_to_left_crouch");
		if(var_04 == "Cover Stand")
		{
			var_03["shuffle_end"] = scripts\anim\utility::func_B027("shuffle","shuffle_end_to_left_stand");
		}
		else
		{
			var_03["shuffle_end"] = scripts\anim\utility::func_B027("shuffle","shuffle_end_to_left_crouch");
		}
	}
	else
	{
		var_03["shuffle_start"] = func_7C69(param_00,param_01);
		var_03["shuffle"] = scripts\anim\utility::func_B027("shuffle","shuffle_to_right_crouch");
		if(var_04 == "Cover Stand")
		{
			var_03["shuffle_end"] = scripts\anim\utility::func_B027("shuffle","shuffle_end_to_right_stand");
		}
		else
		{
			var_03["shuffle_end"] = scripts\anim\utility::func_B027("shuffle","shuffle_end_to_right_crouch");
		}
	}

	self.var_1491.var_2274 = var_03;
}

//Function Number: 33
func_BCAF(param_00,param_01)
{
	if(self.var_1491.var_D6A5 == "stand" && param_01.type != "Cover Stand" || param_00.type != "Cover Stand")
	{
		self.var_1491.var_D6A5 = "crouch";
		return 0;
	}

	return 1;
}

//Function Number: 34
func_BCAE(param_00)
{
	if(self.var_1491.var_D6A5 == "crouch" && param_00.type == "Cover Stand")
	{
		self.var_1491.var_D6A5 = "stand";
		return 0;
	}

	return 1;
}

//Function Number: 35
func_BCAD()
{
	self endon("killanimscript");
	self endon("goal_changed");
	var_00 = self.var_10171;
	self.var_1016F = undefined;
	self.var_10171 = undefined;
	self.var_10170 = 1;
	if(!isdefined(self.var_24A))
	{
		return;
	}

	if(!isdefined(self.var_205) || !isdefined(var_00) || self.var_205 != var_00)
	{
		return;
	}

	var_01 = self.var_24A;
	var_02 = self.var_205;
	var_03 = var_02.origin - self.origin;
	if(lengthsquared(var_03) < 1)
	{
		return;
	}

	var_03 = vectornormalize(var_03);
	var_04 = anglestoforward(var_02.angles);
	var_05 = var_04[0] * var_03[1] - var_04[1] * var_03[0] > 0;
	if(func_BCB5(var_05,var_01,var_02))
	{
		return;
	}

	if(func_BCAF(var_01,var_02))
	{
		var_06 = 0.1;
	}
	else
	{
		var_06 = 0.4;
	}

	func_FA42(var_05,var_01,var_02);
	self method_8016("zonly_physics",0);
	self method_806F(%body,var_06);
	var_07 = scripts\anim\utility::func_1F64("shuffle_start");
	var_08 = scripts\anim\utility::func_1F64("shuffle");
	var_09 = scripts\anim\utility::func_1F64("shuffle_end");
	if(animhasnotetrack(var_07,"finish"))
	{
		var_0A = getnotetracktimes(var_07,"finish")[0];
	}
	else
	{
		var_0A = 1;
	}

	var_0B = length(getmovedelta(var_07,0,var_0A));
	var_0C = length(getmovedelta(var_08,0,1));
	var_0D = length(getmovedelta(var_09,0,1));
	var_0E = distance(self.origin,var_02.origin);
	if(var_0E > var_0B)
	{
		self method_8221("face angle",scripts\asm\shared_utility::func_7FF7(var_01));
		self method_82EA("shuffle_start",var_07,1,var_06);
		scripts\anim\shared::func_592B("shuffle_start");
		self method_806F(var_07,0.2);
		var_0E = var_0E - var_0B;
		var_06 = 0.2;
	}
	else
	{
		self method_8221("face angle",var_02.angles[1]);
	}

	var_0F = 0;
	if(var_0E > var_0D)
	{
		var_0F = 1;
		var_0E = var_0E - var_0D;
	}

	var_10 = getanimlength(var_08);
	var_11 = var_10 * var_0E / var_0C * 0.9;
	var_11 = floor(var_11 * 20) * 0.05;
	self method_82E1("shuffle",var_08,1,var_06);
	scripts\anim\notetracks::func_5931(var_11,"shuffle");
	for(var_12 = 0;var_12 < 2;var_12++)
	{
		var_0E = distance(self.origin,var_02.origin);
		if(var_0F)
		{
			var_0E = var_0E - var_0D;
		}

		if(var_0E < 4)
		{
			break;
		}

		var_11 = var_10 * var_0E / var_0C * 0.9;
		var_11 = floor(var_11 * 20) * 0.05;
		if(var_11 < 0.05)
		{
			break;
		}

		scripts\anim\notetracks::func_5931(var_11,"shuffle");
	}

	if(var_0F)
	{
		if(func_BCAE(var_02))
		{
			var_06 = 0.2;
		}
		else
		{
			var_06 = 0.4;
		}

		self method_806F(var_08,var_06);
		self method_82E1("shuffle_end",var_09,1,var_06);
		scripts\anim\shared::func_592B("shuffle_end");
	}

	self method_8272(var_02.origin);
	self method_8016("normal");
	self.var_10170 = undefined;
}

//Function Number: 36
func_BCB0()
{
	if(isdefined(self.var_10170))
	{
		self method_806F(%cover_shuffle,0.2);
		self.var_10170 = undefined;
		self method_8016("none",0);
		self method_8221("face default");
		return;
	}

	wait(0.2);
	self method_806F(%cover_shuffle,0.2);
}

//Function Number: 37
func_BCB5(param_00,param_01,param_02)
{
	var_03 = undefined;
	if(!isdefined(var_03))
	{
		return 0;
	}

	self method_8016("zonly_physics",0);
	self method_8221("face current");
	self method_82EA("sideToSide",var_03,1,0.2);
	scripts\anim\shared::func_592B("sideToSide",::func_89E3);
	var_04 = self method_8102(var_03);
	var_05 = param_02.origin - param_01.origin;
	var_05 = vectornormalize((var_05[0],var_05[1],0));
	var_06 = getmovedelta(var_03,var_04,1);
	var_07 = param_02.origin - self.origin;
	var_07 = (var_07[0],var_07[1],0);
	var_08 = vectordot(var_07,var_05) - abs(var_06[1]);
	if(var_08 > 2)
	{
		var_09 = getnotetracktimes(var_03,"slide_end")[0];
		var_0A = var_09 - var_04 * getanimlength(var_03);
		var_0B = int(ceil(var_0A / 0.05));
		var_0C = var_05 * var_08 / var_0B;
		thread func_102E9(var_0C,var_0B);
	}

	scripts\anim\shared::func_592B("sideToSide");
	self method_8272(param_02.origin);
	self method_8016("none");
	self method_8221("face default");
	self.var_10170 = undefined;
	wait(0.2);
	return 1;
}

//Function Number: 38
func_89E3(param_00)
{
	if(param_00 == "slide_start")
	{
		return 1;
	}
}

//Function Number: 39
func_102E9(param_00,param_01)
{
	self endon("killanimscript");
	self endon("goal_changed");
	while(param_01 > 0)
	{
		self method_8272(self.origin + param_00);
		param_01--;
		wait(0.05);
	}
}

//Function Number: 40
func_BCF8(param_00,param_01)
{
	self endon("movemode");
	self method_806F(%combatrun,0.6);
	self method_82A5(%combatrun,%body,1,0.5,self.var_BCD6);
	if(isdefined(self.var_E1B0) && gettime() - self.var_E1B0 < 100 && isdefined(self.var_E80D) && randomfloat(1) < self.var_1491.var_DD61)
	{
		scripts\anim\run::func_4C9A();
		return;
	}

	if(isarray(param_00))
	{
		if(isdefined(self.var_E80B))
		{
			var_02 = scripts\common\utility::func_3E83(param_00,param_01);
		}
		else
		{
			var_02 = param_01[randomint(param_01.size)];
		}
	}
	else
	{
		var_02 = param_01;
	}

	self method_82E2("moveanim",var_02,1,0.2,self.var_BCD6);
	scripts\anim\shared::func_592B("moveanim");
}

//Function Number: 41
func_AD66()
{
	thread scripts\anim\cover_arrival::func_FA90(1);
}