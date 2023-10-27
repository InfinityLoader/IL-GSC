/*******************************************************************
 * Decompiled By: Bog
 * Decompiled File: scripts\anim\run.gsc
 * Game: Call of Duty: Infinite Warfare
 * Platform: PC
 * Function Count: 46
 * Decompile Time: 2378 ms
 * Timestamp: 10/27/2023 12:00:53 AM
*******************************************************************/

//Function Number: 1
func_BCEB()
{
	var_00 = [[ self.var_3EF3 ]]("stand");
	switch(var_00)
	{
		case "stand":
			if(scripts\anim\setposemovement::func_10B76())
			{
				return;
			}
	
			if(isdefined(self.var_E80C))
			{
				scripts\anim\move::func_BCF8(self.var_E80C,self.var_E80B);
				return;
			}
	
			if(func_10B77())
			{
				return;
			}
	
			if(func_10B78())
			{
				return;
			}
	
			scripts\anim\utility::func_12EB9();
			if(scripts\anim\utility::func_9E40())
			{
				func_10B79();
			}
			else
			{
				func_10B7A();
			}
			break;

		case "crouch":
			if(scripts\anim\setposemovement::func_4A9E())
			{
				return;
			}
	
			if(isdefined(self.var_4A9F))
			{
				func_4AA1();
			}
			else
			{
				func_4AA0();
			}
			break;

		default:
			if(scripts\anim\setposemovement::func_DA84())
			{
				return;
			}
	
			func_DA7F();
			break;
	}
}

//Function Number: 2
func_80FB()
{
	if(!isdefined(self.var_1491.var_BCA5))
	{
		return scripts\anim\utility::func_B027("run","straight");
	}

	if(!self.var_12A)
	{
		if(self.var_2C0 == "none" || abs(self method_813E()) > 45)
		{
			return scripts\anim\utility::func_7FCC("move_f");
		}
	}

	if(self.var_2C0 == "up")
	{
		return scripts\anim\utility::func_7FCC("stairs_up");
	}
	else if(self.var_2C0 == "down")
	{
		return scripts\anim\utility::func_7FCC("stairs_down");
	}

	if(scripts\anim\utility::func_9E40() || isdefined(self.var_1491.var_29CE) && self.var_1491.var_29CE)
	{
		return scripts\anim\utility::func_7FCC("straight");
	}

	var_00 = scripts\anim\utility::func_7FCC("straight_twitch");
	if(!isdefined(var_00) || var_00.size == 0)
	{
		return scripts\anim\utility::func_7FCC("straight");
	}

	var_01 = scripts\anim\utility::func_80BD(self.var_1491.var_E860,4);
	if(var_01 == 0)
	{
		var_01 = scripts\anim\utility::func_80BD(self.var_1491.var_E860,var_00.size);
		return var_00[var_01];
	}

	return scripts\anim\utility::func_7FCC("straight");
}

//Function Number: 3
func_7E47()
{
	if(!isdefined(self.var_1491.var_BCA5))
	{
		return scripts\anim\utility::func_B027("run","crouch");
	}

	return scripts\anim\utility::func_7FCC("crouch");
}

//Function Number: 4
func_DA7F()
{
	self.var_1491.var_BCC8 = "run";
	self method_82E2("runanim",scripts\anim\utility::func_7FCC("prone"),1,0.3,self.var_BCD6);
	func_E7E5();
	scripts\anim\notetracks::func_5931(0.25,"runanim");
}

//Function Number: 5
func_98C6()
{
	if(!isdefined(self.var_E873))
	{
		self notify("stop_move_anim_update");
		self.var_12DEF = undefined;
		self method_806F(%combatrun_backward,0.2);
		self method_806F(%combatrun_right,0.2);
		self method_806F(%combatrun_left,0.2);
		self method_806F(%w_aim_2,0.2);
		self method_806F(%w_aim_4,0.2);
		self method_806F(%w_aim_6,0.2);
		self method_806F(%w_aim_8,0.2);
		self.var_E873 = 1;
	}
}

//Function Number: 6
func_11088()
{
	if(isdefined(self.var_E873))
	{
		self method_806F(%run_n_gun,0.2);
		self.var_E873 = undefined;
	}

	return 0;
}

//Function Number: 7
func_E873(param_00)
{
	if(param_00)
	{
		var_01 = func_8096(0.2);
		var_02 = var_01 < 0;
	}
	else
	{
		var_01 = 0;
		var_02 = self.var_E879 < 0;
	}

	var_03 = 1 - var_02;
	var_04 = self.var_B4C3;
	var_05 = self.var_E878;
	var_06 = self.var_E876;
	if(!param_00 || squared(var_01) > var_04 * var_04)
	{
		self method_806F(%add_fire,0);
		if(squared(self.var_E879) < var_06 * var_06)
		{
			self.var_E879 = 0;
			self.var_E873 = undefined;
			return 0;
		}
		else if(self.var_E879 > 0)
		{
			self.var_E879 = self.var_E879 - var_06;
		}
		else
		{
			self.var_E879 = self.var_E879 + var_06;
		}
	}
	else
	{
		var_07 = var_01 / var_04;
		var_08 = var_07 - self.var_E879;
		if(abs(var_08) < var_05 * 0.7)
		{
			self.var_E879 = var_07;
		}
		else if(var_08 > 0)
		{
			self.var_E879 = self.var_E879 + var_06;
		}
		else
		{
			self.var_E879 = self.var_E879 - var_06;
		}
	}

	func_98C6();
	var_09 = abs(self.var_E879);
	var_0A = scripts\anim\utility::func_B028("run_n_gun");
	if(var_09 > var_05)
	{
		var_0B = var_09 - var_05 / var_05;
		var_0B = clamp(var_0B,0,1);
		self method_806F(var_0A["F"],0.2);
		self method_82AC(var_0A["L"],1 - var_0B * var_02,0.2);
		self method_82AC(var_0A["R"],1 - var_0B * var_03,0.2);
		self method_82AC(var_0A["LB"],var_0B * var_02,0.2);
		self method_82AC(var_0A["RB"],var_0B * var_03,0.2);
	}
	else
	{
		var_0B = clamp(var_0A / var_06,0,1);
		self method_82AC(var_0A["F"],1 - var_0B,0.2);
		self method_82AC(var_0A["L"],var_0B * var_02,0.2);
		self method_82AC(var_0A["R"],var_0B * var_03,0.2);
		if(var_05 < 1)
		{
			self method_806F(var_0A["LB"],0.2);
			self method_806F(var_0A["RB"],0.2);
		}
	}

	self method_82E2("runanim",%run_n_gun,1,0.3,0.8);
	func_E80F(undefined);
	self.var_1491.var_1C8D = gettime() + 500;
	if(param_00 && isplayer(self.var_10C))
	{
		self method_83CE();
	}

	return 1;
}

//Function Number: 8
func_E874()
{
	func_98C6();
	var_00 = scripts\anim\utility::func_B027("run_n_gun","move_back");
	self method_82E2("runanim",var_00,1,0.3,0.8);
	func_E80F(var_00);
	if(isplayer(self.var_10C))
	{
		self method_83CE();
	}

	scripts\anim\notetracks::func_5931(0.2,"runanim");
	self method_806F(var_00,0.2);
}

//Function Number: 9
func_DD62()
{
	self endon("killanimscript");
	for(;;)
	{
		wait(0.2);
		if(!isdefined(self.var_DD39))
		{
			break;
		}

		if(!isdefined(self.var_233) || distancesquared(self.var_233,self.origin) < squared(80))
		{
			func_6382();
			self notify("interrupt_react_to_bullet");
			break;
		}
	}
}

//Function Number: 10
func_6382()
{
	self method_8221("face default");
	self.var_DD39 = undefined;
	self.var_E1B0 = undefined;
}

//Function Number: 11
func_E87E()
{
	func_6318();
	self endon("interrupt_react_to_bullet");
	self.var_DD39 = 1;
	self method_8221("face motion");
	var_00 = scripts\anim\utility::func_B028("running_react_to_bullets");
	var_01 = randomint(var_00.size);
	if(var_01 == level.var_A9E6)
	{
		var_01 = var_01 + 1 % var_00.size;
	}

	anim.var_A9E6 = var_01;
	var_02 = var_00[var_01];
	self method_82E7("reactanim",var_02,1,0.5,self.var_BCD6);
	func_E80F(var_02);
	thread func_DD62();
	scripts\anim\shared::func_592B("reactanim");
	func_6382();
}

//Function Number: 12
func_4C9A()
{
	func_6318();
	self.var_DD39 = 1;
	self method_8221("face motion");
	var_00 = randomint(self.var_E80D.size);
	var_01 = self.var_E80D[var_00];
	self method_82E7("reactanim",var_01,1,0.5,self.var_BCD6);
	func_E80F(var_01);
	thread func_DD62();
	scripts\anim\shared::func_592B("reactanim");
	func_6382();
}

//Function Number: 13
func_8150()
{
	var_00 = undefined;
	if(isdefined(self.var_15F))
	{
		var_00 = scripts\anim\utility::func_7FCC("sprint_short");
	}

	if(!isdefined(var_00))
	{
		var_00 = scripts\anim\utility::func_7FCC("sprint");
	}

	return var_00;
}

//Function Number: 14
func_10086()
{
	if(isdefined(self.var_10AB7))
	{
		return 1;
	}

	if(isdefined(self.var_15F) && isdefined(self.var_10C) && self.var_14F == 1)
	{
		return distancesquared(self.origin,self.var_10C.origin) > 90000;
	}

	return 0;
}

//Function Number: 15
func_10087()
{
	if(isdefined(self.var_BEFA))
	{
		return 0;
	}

	if(!self.var_12A || self.var_2C0 != "none")
	{
		return 0;
	}

	var_00 = gettime();
	if(isdefined(self.var_4D85))
	{
		if(var_00 < self.var_4D85)
		{
			return 1;
		}

		if(var_00 - self.var_4D85 < 6000)
		{
			return 0;
		}
	}

	if(!isdefined(self.var_10C) || !issentient(self.var_10C))
	{
		return 0;
	}

	if(randomint(100) < 25 && self lastknowntime(self.var_10C) + 2000 > var_00)
	{
		self.var_4D85 = var_00 + 2000 + randomint(1000);
		return 1;
	}

	return 0;
}

//Function Number: 16
func_7FCF()
{
	var_00 = self.var_BCD6;
	if(self.var_1C0 && self.var_2C0 == "none" && self.var_1BF < 300)
	{
		var_00 = var_00 * 0.75;
	}

	return var_00;
}

//Function Number: 17
func_10B79()
{
	var_00 = func_7FCF();
	self method_82A4(%combatrun,1,0.5,var_00);
	var_01 = 0;
	var_02 = isdefined(self.var_E1B0) && gettime() - self.var_E1B0 < 100;
	if(var_02 && randomfloat(1) < self.var_1491.var_DD61)
	{
		func_11088();
		func_F843(0);
		func_E87E();
		return;
	}

	if(func_10086())
	{
		var_03 = func_8150();
		self method_82E2("runanim",var_03,1,0.5,self.var_BCD6);
		func_E80F(var_03);
		func_F843(0);
		var_01 = 1;
	}
	else if(isdefined(self.var_10C) && scripts\anim\move::func_B4EC())
	{
		func_F843(1);
		if(!self.var_12A)
		{
			thread func_6A6B();
		}
		else if(self.var_FED7 != "none" && !isdefined(self.var_C09F))
		{
			func_6318();
			if(func_390F())
			{
				var_01 = func_E873(1);
			}
			else if(func_390E())
			{
				func_E874();
				return;
			}
		}
		else if(isdefined(self.var_E879) && self.var_E879 != 0)
		{
			var_01 = func_E873(0);
		}
	}
	else if(isdefined(self.var_E879) && self.var_E879 != 0)
	{
		func_F843(0);
		var_01 = func_E873(0);
	}
	else
	{
		func_F843(0);
	}

	if(!var_01)
	{
		func_11088();
		if(var_02 && self.var_1491.var_DD61 != 0)
		{
			func_E87E();
			return;
		}

		if(func_BC1D())
		{
			return;
		}

		self method_806F(%stair_transitions,0.1);
		if(func_10087())
		{
			var_04 = scripts\anim\utility::func_7FCC("sprint_short");
		}
		else
		{
			var_04 = func_80FB();
		}

		self method_82E5("runanim",var_04,1,0.1,self.var_BCD6,1);
		func_E80F(var_04);
		func_F7A9(scripts\anim\utility::func_7FCC("move_b"),scripts\anim\utility::func_7FCC("move_l"),scripts\anim\utility::func_7FCC("move_r"),self.var_101BB);
		thread func_F69A("run");
	}

	scripts\anim\notetracks::func_5931(0.2,"runanim");
}

//Function Number: 18
func_815A(param_00,param_01)
{
	if(!isdefined(param_00))
	{
		param_00 = "none";
	}

	if(param_00 == param_01)
	{
		return undefined;
	}

	if(param_00 == "up")
	{
		return scripts\anim\utility::func_7FCC("stairs_up_out");
	}

	if(param_00 == "down")
	{
		return scripts\anim\utility::func_7FCC("stairs_down_out");
	}

	if(param_01 == "up")
	{
		return scripts\anim\utility::func_7FCC("stairs_up_in");
	}

	if(param_01 == "down")
	{
		return scripts\anim\utility::func_7FCC("stairs_down_in");
	}
}

//Function Number: 19
func_6A6B()
{
	if(isdefined(self.var_1A32))
	{
		return;
	}

	self.var_1A32 = 1;
	self endon("killanimscript");
	self endon("end_face_enemy_tracking");
	self method_82D0();
	var_00 = undefined;
	if(isdefined(self.var_440C) && isdefined(self.var_440C["walk_aims"]))
	{
		self method_82AC(self.var_440C["walk_aims"]["walk_aim_2"]);
		self method_82AC(self.var_440C["walk_aims"]["walk_aim_4"]);
		self method_82AC(self.var_440C["walk_aims"]["walk_aim_6"]);
		self method_82AC(self.var_440C["walk_aims"]["walk_aim_8"]);
	}
	else
	{
		var_01 = "walk";
		if(scripts\anim\utility::func_FFDB() && isdefined(scripts\anim\utility::func_B027("cqb","aim_2")))
		{
			var_01 = "cqb";
		}

		var_02 = scripts\anim\utility::func_B028(var_01);
		self method_82AC(var_02["aim_2"]);
		self method_82AC(var_02["aim_4"]);
		self method_82AC(var_02["aim_6"]);
		self method_82AC(var_02["aim_8"]);
		if(isdefined(var_02["aim_5"]))
		{
			self method_82AC(var_02["aim_5"]);
			var_00 = %w_aim_5;
		}
	}

	scripts\anim\track::func_11AF8(%w_aim_2,%w_aim_4,%w_aim_6,%w_aim_8,var_00);
}

//Function Number: 20
func_6318()
{
	self.var_1A32 = undefined;
	self notify("end_face_enemy_tracking");
}

//Function Number: 21
func_F843(param_00)
{
	var_01 = isdefined(self.var_3129);
	if(param_00)
	{
		self.var_3129 = param_00;
		if(!var_01)
		{
			thread func_E843();
			thread func_E89B();
			return;
		}

		return;
	}

	self.var_3129 = undefined;
	if(var_01)
	{
		self notify("end_shoot_while_moving");
		self notify("end_face_enemy_tracking");
		self.var_FE92 = undefined;
		self.var_1A32 = undefined;
		self.var_E873 = undefined;
	}
}

//Function Number: 22
func_E843()
{
	self endon("killanimscript");
	self endon("end_shoot_while_moving");
	scripts\anim\shoot_behavior::func_4F69("normal");
}

//Function Number: 23
func_E89B()
{
	self endon("killanimscript");
	self endon("end_shoot_while_moving");
	scripts\anim\move::func_FEEB();
}

//Function Number: 24
func_1A3C()
{
	var_00 = self method_8141();
	var_01 = vectortoangles(self.var_10C method_815B() - self method_8142());
	if(scripts\common\utility::func_152F(var_00[1] - var_01[1]) > 15)
	{
		return 0;
	}

	return scripts\common\utility::func_152F(var_00[0] - var_01[0]) <= 20;
}

//Function Number: 25
func_390F()
{
	if((!isdefined(self.var_E879) || self.var_E879 == 0) && abs(self method_813E()) > self.var_B4C3)
	{
		return 0;
	}

	return 1;
}

//Function Number: 26
func_390E()
{
	if(180 - abs(self method_813E()) >= 45)
	{
		return 0;
	}

	var_00 = func_8096(0.2);
	if(abs(var_00) > 30)
	{
		return 0;
	}

	return 1;
}

//Function Number: 27
func_390D()
{
	return scripts\anim\move::func_B4EC() && isdefined(self.var_10C) && func_390F() || func_390E();
}

//Function Number: 28
func_8096(param_00)
{
	var_01 = self.origin;
	var_02 = self.angles[1] + self method_813E();
	var_01 = var_01 + (cos(var_02),sin(var_02),0) * length(self.var_381) * param_00;
	var_03 = self.angles[1] - vectortoyaw(self.var_10C.origin - var_01);
	var_03 = angleclamp180(var_03);
	return var_03;
}

//Function Number: 29
func_BC1D()
{
	var_00 = 0;
	var_01 = undefined;
	if(self.var_2C0 == "none" && self.var_1C0)
	{
		if(scripts\anim\utility::func_FFDB())
		{
			var_02 = 32;
		}
		else
		{
			var_02 = 48;
		}

		var_03 = self.origin + (0,0,6);
		var_04 = vectornormalize((self.var_1BE[0],self.var_1BE[1],0));
		var_05 = var_03 + var_02 * var_04;
		var_06 = self method_8007(var_03,var_05,15,48,1,1);
		if(var_06["fraction"] < 1)
		{
			if(!isdefined(var_06["stairs"]))
			{
				return 0;
			}

			var_01 = func_815A("none","up");
		}
		else
		{
			var_07 = 18;
			var_08 = var_05 + (0,0,var_07);
			var_09 = var_05 - (0,0,var_07);
			var_06 = self method_8007(var_08,var_09,15,48,1,1);
			if(var_06["fraction"] >= 1)
			{
				return 0;
			}

			if(!isdefined(var_06["stairs"]))
			{
				return 0;
			}

			var_01 = func_815A("none","down");
		}
	}
	else if(self.var_2C0 == "up")
	{
		var_02 = 24;
		var_07 = 18;
		var_05 = self.origin + var_02 * self.var_1BE;
		var_08 = var_05 + (0,0,var_07);
		var_09 = var_05 - (0,0,var_07);
		var_06 = self method_8007(var_08,var_09,15,48,1,1);
		if(var_06["fraction"] <= 0 || var_06["fraction"] >= 1)
		{
			return 0;
		}

		if(isdefined(var_06["stairs"]))
		{
			return 0;
		}

		var_01 = func_815A("up","none");
	}
	else if(self.var_2C0 == "down" && !self.var_1C0)
	{
		var_02 = 24;
		var_07 = 18;
		var_05 = self.origin + var_02 * self.var_1BE;
		var_08 = var_05 + (0,0,var_07);
		var_09 = var_05 - (0,0,var_07);
		var_06 = self method_8007(var_08,var_09,15,48,1,1);
		if(var_06["fraction"] <= 0 || var_06["fraction"] >= 1)
		{
			return 0;
		}

		if(isdefined(var_06["stairs"]))
		{
			return 0;
		}

		var_01 = func_815A("down","none");
	}

	if(!isdefined(var_01))
	{
		return 0;
	}

	self notify("stop_move_anim_update");
	self.var_12DEF = undefined;
	self method_82E4("runanim",var_01,%body,1,0.1,self.var_BCD6);
	func_E80F(var_01);
	scripts\anim\shared::func_592B("runanim");
	return 1;
}

//Function Number: 30
func_10B7A()
{
	self endon("movemode");
	self method_806F(%combatrun,0.6);
	var_00 = func_7FCF();
	if(func_BC1D())
	{
		return;
	}

	self method_806F(%stair_transitions,0.1);
	self method_82A5(%combatrun,%body,1,0.2,var_00);
	if(func_10086())
	{
		var_01 = func_8150();
	}
	else
	{
		var_01 = func_80FB();
	}

	if(self.var_2C0 == "none")
	{
		var_02 = 0.3;
	}
	else
	{
		var_02 = 0.1;
	}

	self method_82E2("runanim",var_01,1,var_02,self.var_BCD6,1);
	func_E80F(var_01);
	func_F7A9(scripts\anim\utility::func_7FCC("move_b"),scripts\anim\utility::func_7FCC("move_l"),scripts\anim\utility::func_7FCC("move_r"));
	thread func_F69A("run");
	var_03 = 0;
	if(self.var_1B4 > 0 && self.var_1B4 < 0.998)
	{
		var_03 = 1;
	}
	else if(self.var_1B4 < 0 && self.var_1B4 > -0.998)
	{
		var_03 = -1;
	}

	var_04 = max(0.2,var_02);
	scripts\anim\notetracks::func_5931(var_04,"runanim");
}

//Function Number: 31
func_4AA1()
{
	self endon("movemode");
	self method_82E3("runanim",self.var_4A9F,%body,1,0.4,self.var_BCD6);
	func_E80F(self.var_4A9F);
	scripts\anim\shared::func_592B("runanim");
}

//Function Number: 32
func_4AA0()
{
	self endon("movemode");
	var_00 = func_7E47();
	self method_82A4(var_00,1,0.4);
	thread func_12ED3("crouchrun",var_00,scripts\anim\utility::func_B027("run","crouch_b"),scripts\anim\utility::func_B027("run","crouch_l"),scripts\anim\utility::func_B027("run","crouch_r"));
	self method_82E3("runanim",%crouchrun,%body,1,0.2,self.var_BCD6);
	func_E80F(undefined);
	scripts\anim\notetracks::func_5931(0.2,"runanim");
}

//Function Number: 33
func_10B78()
{
	var_00 = isdefined(self.var_1491.var_1C8D) && self.var_1491.var_1C8D > gettime();
	var_00 = var_00 || isdefined(self.var_10C) && distancesquared(self.origin,self.var_10C.origin) < 65536;
	if(var_00)
	{
		if(!scripts\anim\utility_common::func_BE9E(0))
		{
			return 0;
		}
	}
	else if(!scripts\anim\utility_common::func_BE9E(0.5))
	{
		return 0;
	}

	if(isdefined(self.var_15F))
	{
		return 0;
	}

	if(!self.var_12A || self.var_2C0 != "none")
	{
		return 0;
	}

	if(isdefined(self.var_596C) || isdefined(self.var_C0A0))
	{
		return 0;
	}

	if(func_390D() && !scripts\anim\utility_common::func_BE9E(0))
	{
		return 0;
	}

	if(!isdefined(self.var_233) || distancesquared(self.origin,self.var_233) < 65536)
	{
		return 0;
	}

	var_01 = angleclamp180(self method_813E());
	if(abs(var_01) > 25)
	{
		return 0;
	}

	if(!scripts\anim\utility_common::func_1311A())
	{
		return 0;
	}

	if(!func_E861())
	{
		return 0;
	}

	if(scripts\anim\utility::func_FFDB())
	{
		scripts\anim\cqb::func_4790();
	}
	else
	{
		func_10B7B();
	}

	self notify("abort_reload");
	self method_8221("face default");
	return 1;
}

//Function Number: 34
func_10B7B()
{
	self endon("movemode");
	self method_8221("face motion");
	var_00 = "reload_" + scripts\anim\combat_utility::func_81EB();
	var_01 = scripts\anim\utility::func_B027("run","reload");
	if(isarray(var_01))
	{
		var_01 = var_01[randomint(var_01.size)];
	}

	self method_82E4(var_00,var_01,%body,1,0.25);
	func_E80F(var_01);
	self.var_12DF0 = 1;
	func_F7A9(scripts\anim\utility::func_7FCC("move_b"),scripts\anim\utility::func_7FCC("move_l"),scripts\anim\utility::func_7FCC("move_r"));
	thread func_F69A("run");
	scripts\anim\shared::func_592B(var_00);
	self.var_12DF0 = undefined;
}

//Function Number: 35
func_E861()
{
	var_00 = self method_8102(%walk_and_run_loops);
	var_01 = getanimlength(scripts\anim\utility::func_B027("run","straight")) / 3;
	var_00 = var_00 * 3;
	if(var_00 > 3)
	{
		var_00 = var_00 - 2;
	}
	else if(var_00 > 2)
	{
		var_00 = var_00 - 1;
	}

	if(var_00 < 0.15 / var_01)
	{
		return 1;
	}

	if(var_00 > 1 - 0.3 / var_01)
	{
		return 1;
	}

	return 0;
}

//Function Number: 36
func_F7A9(param_00,param_01,param_02,param_03)
{
	if(!isdefined(param_03))
	{
		param_03 = 1;
	}

	self method_82A9(param_00,1,0.1,param_03,1);
	self method_82A9(param_01,1,0.1,param_03,1);
	self method_82A9(param_02,1,0.1,param_03,1);
}

//Function Number: 37
func_F69A(param_00)
{
	func_12ED3(param_00,%combatrun_forward,%combatrun_backward,%combatrun_left,%combatrun_right);
}

//Function Number: 38
func_12ED3(param_00,param_01,param_02,param_03,param_04)
{
	if(isdefined(self.var_12DEF) && self.var_12DEF == param_00)
	{
		return;
	}

	self notify("stop_move_anim_update");
	self.var_12DEF = param_00;
	self.var_13910 = undefined;
	self endon("killanimscript");
	self endon("move_interrupt");
	self endon("stop_move_anim_update");
	for(;;)
	{
		func_12F08(param_01,param_02,param_03,param_04);
		wait(0.05);
		waittillframeend;
	}
}

//Function Number: 39
func_12F08(param_00,param_01,param_02,param_03)
{
	if(self.var_12A && !scripts\anim\utility::func_FFDB() && !isdefined(self.var_12DF0))
	{
		if(!isdefined(self.var_13910))
		{
			self.var_13910 = 1;
			self method_82A2(param_00,1,0.2,1,1);
			self method_82A2(param_01,0,0.2,1,1);
			self method_82A2(param_02,0,0.2,1,1);
			self method_82A2(param_03,0,0.2,1,1);
			return;
		}

		return;
	}

	self.var_13910 = undefined;
	var_04 = scripts\anim\utility_common::func_DB51(self method_813E());
	if(isdefined(self.var_12DF0))
	{
		var_04["back"] = 0;
		if(var_04["front"] < 0.2)
		{
			var_04["front"] = 0.2;
		}
	}

	self method_82A2(param_00,var_04["front"],0.2,1,1);
	self method_82A2(param_01,var_04["back"],0.2,1,1);
	self method_82A2(param_02,var_04["left"],0.2,1,1);
	self method_82A2(param_03,var_04["right"],0.2,1,1);
}

//Function Number: 40
func_10B77()
{
	var_00 = isdefined(self.var_138DF) && self.var_138DF;
	var_01 = scripts\anim\utility_common::func_9F4F(self.var_394);
	if(var_00 == var_01)
	{
		return 0;
	}

	if(!isdefined(self.var_233) || distancesquared(self.origin,self.var_233) < 65536)
	{
		return 0;
	}

	if(scripts\anim\utility_common::func_9FCA())
	{
		return 0;
	}

	if(self.var_394 == self.var_D8E1)
	{
		if(!var_00)
		{
			return 0;
		}

		if(scripts\anim\utility_common::func_9F4F(self.var_F0C4))
		{
			return 0;
		}
	}
	else
	{
		if(var_00)
		{
			return 0;
		}

		if(scripts\anim\utility_common::func_9F4F(self.var_D8E1))
		{
			return 0;
		}
	}

	var_02 = angleclamp180(self method_813E());
	if(abs(var_02) > 25)
	{
		return 0;
	}

	if(!func_E861())
	{
		return 0;
	}

	if(var_00)
	{
		func_FF02("shotgunPullout",scripts\anim\utility::func_B027("cqb","shotgun_pullout"),"gun_2_chest","none",self.var_F0C4,"shotgun_pickup");
	}
	else
	{
		func_FF02("shotgunPutaway",scripts\anim\utility::func_B027("cqb","shotgun_putaway"),"gun_2_back","back",self.var_D8E1,"shotgun_pickup");
	}

	self notify("switchEnded");
	return 1;
}

//Function Number: 41
func_FF02(param_00,param_01,param_02,param_03,param_04,param_05)
{
	self endon("movemode");
	self method_82E4(param_00,param_01,%body,1,0.25);
	func_E80F(param_01);
	self.var_12DF0 = 1;
	func_F7A9(scripts\anim\utility::func_7FCC("move_b"),scripts\anim\utility::func_7FCC("move_l"),scripts\anim\utility::func_7FCC("move_r"));
	thread func_F69A("run");
	thread func_13B40(param_00,param_02,param_03,param_04,param_05);
	scripts\anim\notetracks::func_5933(getanimlength(param_01) - 0.25,param_00,::func_9A61);
	self.var_12DF0 = undefined;
}

//Function Number: 42
func_9A61(param_00)
{
	if(param_00 == "gun_2_chest" || param_00 == "gun_2_back")
	{
		return 1;
	}
}

//Function Number: 43
func_13B40(param_00,param_01,param_02,param_03,param_04)
{
	self endon("killanimscript");
	self endon("movemode");
	self endon("switchEnded");
	self waittillmatch(param_01,param_00);
	scripts\anim\shared::func_CC2C(self.var_394,param_02);
	thread func_FF01(param_03);
	self waittillmatch(param_04,param_00);
	self notify("complete_weapon_switch");
}

//Function Number: 44
func_FF01(param_00)
{
	self endon("death");
	scripts\common\utility::waittill_any_3("killanimscript","movemode","switchEnded","complete_weapon_switch");
	self.var_AA45 = self.var_394;
	scripts\anim\shared::func_CC2C(param_00,"right");
	self.var_3250 = weaponclipsize(self.var_394);
}

//Function Number: 45
func_E80F(param_00)
{
	self.var_6A89 = scripts\anim\face::func_D475(param_00,"run",self.var_6A89);
}

//Function Number: 46
func_E7E5()
{
	self.var_6A89 = undefined;
	self method_806F(%head,0.2);
}