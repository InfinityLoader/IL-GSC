/*******************************************************************
 * Decompiled By: Bog
 * Decompiled File: animscripts\snowmobile.gsc
 * Game: Call of Duty: Modern Warfare 3
 * Platform: PC
 * Function Count: 32
 * Decompile Time: 526 ms
 * Timestamp: 10/27/2023 2:18:47 AM
*******************************************************************/

//Function Number: 1
main()
{
	self.var_EE8 = "none";
	self.var_EE9 = undefined;
	func_0EEB();
	if(isdefined(self.drivingvehicle))
	{
		func_0EF0();
		return;
	}

	func_0EF3();
}

//Function Number: 2
func_0EEB()
{
	self.grenadeawareness = 0;
	self.a.pose = "crouch";
	maps\_utility::disable_surprise();
	self.allowpain = 0;
	self.getoffvehiclefunc = ::func_0EEF;
	self.var_D4B = ::func_0F16;
	self.disablebulletwhizbyreaction = 1;
}

//Function Number: 3
func_0EEF()
{
	self.allowpain = 1;
	self.getoffvehiclefunc = undefined;
	self.var_D4B = undefined;
	self.a.var_CE6 = undefined;
	self.disablebulletwhizbyreaction = undefined;
}

//Function Number: 4
func_0EF0()
{
	var_00 = self.ridingvehicle.var_EF2 || self.ridingvehicle.riders.size == 1;
	func_0F1A(var_00);
	if(var_00)
	{
		animscripts/shared::func_C9B(self.primaryweapon,"left");
		self.var_716 = 90;
		self.var_717 = -90;
		animscripts/track::func_CC4(1,0.2);
		thread func_0F0F();
		thread func_0EFA();
	}
	else
	{
		animscripts/shared::func_C9B(self.primaryweapon,"none");
		thread func_0EF6();
	}

	func_0EFD("driver");
}

//Function Number: 5
func_0EF3()
{
	func_0F1B(self.ridingvehicle.var_EF4);
	if(self.ridingvehicle.var_EF4)
	{
		self.var_716 = 180;
		self.var_717 = -180;
		self.var_EF5 = 1;
		animscripts/track::func_CC4(1,0.2);
		thread func_0F10();
		thread func_0EFB();
	}
	else
	{
		thread func_0EF9();
	}

	func_0EFD("passenger");
}

//Function Number: 6
func_0EF6()
{
	self endon("death");
	self endon("killanimscript");
	var_00 = "left2right";
	var_01 = [];
	self setanimknoball(%sm_turn,%body,1,0);
	self setanim(animscripts/utility::func_D4D("drive"),1,0);
	self setanimknob(animscripts/utility::func_D4D(var_01),1,0);
	self setanimtime(animscripts/utility::func_D4D(var_01),0.5);
	for(;;)
	{
		if(self.ridingvehicle.steering_enable)
		{
			var_02 = 0.5 * 1 + maps\_vehicle::update_steering(self.ridingvehicle);
			var_03 = self getanimtime(animscripts/utility::func_D4D(var_01));
			if(var_01 == "right2left")
			{
				var_03 = 1 - var_03;
			}

			var_04 = 20 * abs(var_03 - var_02);
			if(var_03 < var_02)
			{
				var_01 = "left2right";
				var_04 = var_04 * var_7B["left2right"];
			}
			else
			{
				var_01 = "right2left";
				var_04 = var_04 * var_7B["right2left"];
				var_03 = 1 - var_03;
			}
		}
		else
		{
			var_01 = "left2right";
			var_04 = 0;
			var_03 = 0.5;
		}

		self setanimknoblimited(animscripts/utility::func_D4D(var_01),1,0.1,var_04);
		self setanimtime(animscripts/utility::func_D4D(var_01),var_03);
		wait 0.05;
	}
}

//Function Number: 7
func_0EF9()
{
	self endon("death");
	self endon("killanimscript");
	self setanimknoball(animscripts/utility::func_D4D("hide"),%body,1,0);
	self setanimknob(animscripts/utility::func_D4D("drive"),1,0);
	for(;;)
	{
		var_00 = maps\_vehicle::update_steering(self.ridingvehicle);
		self setanimlimited(%sm_lean,abs(var_00),0.05);
		if(var_00 >= 0)
		{
			self setanimknoblimited(animscripts/utility::func_D4D("lean_right"),1,0.05);
		}
		else
		{
			self setanimknoblimited(animscripts/utility::func_D4D("lean_left"),1,0.05);
		}

		wait 0.05;
	}
}

//Function Number: 8
func_0EFA()
{
	self endon("death");
	self endon("killanimscript");
	var_00 = 0.05;
	var_01 = 0;
	self setanimknoball(%sm_aiming,%body,1,0);
	self setanimknob(animscripts/utility::func_D4D("idle"),1,0);
	for(;;)
	{
		if(self.var_EE8 != "none")
		{
			self waittill("snowmobile_event_finished");
			continue;
		}

		var_02 = maps\_vehicle::update_steering(self.ridingvehicle);
		var_03 = 1 - abs(var_02);
		var_04 = max(0,0 - var_02);
		var_05 = max(0,var_02);
		self setanimlimited(animscripts/utility::func_D4D("straight_level_center"),var_03,var_00);
		self setanimlimited(animscripts/utility::func_D4D("straight_level_left"),var_04,var_00);
		self setanimlimited(animscripts/utility::func_D4D("straight_level_right"),var_05,var_00);
		if(self.bulletsinclip <= 0)
		{
			animscripts/weaponlist::func_CD0();
			var_01 = gettime() + 3000;
		}

		if(var_01 <= gettime())
		{
			func_0EFF();
		}

		self setanimknoblimited(animscripts/utility::func_D4D("add_aim_left_center"),var_03,var_00);
		self setanimlimited(animscripts/utility::func_D4D("add_aim_left_left"),var_04,var_00);
		self setanimlimited(animscripts/utility::func_D4D("add_aim_left_right"),var_05,var_00);
		self setanimknoblimited(animscripts/utility::func_D4D("add_aim_right_center"),var_03,var_00);
		self setanimlimited(animscripts/utility::func_D4D("add_aim_right_left"),var_04,var_00);
		self setanimlimited(animscripts/utility::func_D4D("add_aim_right_right"),var_05,var_00);
		thread func_0F00();
		wait 0.05;
	}
}

//Function Number: 9
func_0EFB()
{
	self endon("death");
	self endon("killanimscript");
	var_00 = 0.05;
	self setanimknoball(%sm_aiming,%body,1,0);
	self setanimknob(animscripts/utility::func_D4D("idle"),1,0);
	for(;;)
	{
		if(self.var_EE8 != "none")
		{
			self waittill("snowmobile_event_finished");
			continue;
		}

		if(func_0F07())
		{
			continue;
		}

		var_01 = maps\_vehicle::update_steering(self.ridingvehicle);
		var_02 = 1 - abs(var_01);
		var_03 = max(0,0 - var_01);
		var_04 = max(0,var_01);
		self setanimlimited(animscripts/utility::func_D4D("straight_level_center"),var_02,var_00);
		self setanimlimited(animscripts/utility::func_D4D("straight_level_left"),var_03,var_00);
		self setanimlimited(animscripts/utility::func_D4D("straight_level_right"),var_04,var_00);
		func_0EFF();
		self setanimlimited(animscripts/utility::func_D4D("aim_left_center"),var_02,var_00);
		self setanimlimited(animscripts/utility::func_D4D("aim_left_left"),var_03,var_00);
		self setanimlimited(animscripts/utility::func_D4D("aim_left_right"),var_04,var_00);
		self setanimlimited(animscripts/utility::func_D4D("aim_right_center"),var_02,var_00);
		self setanimlimited(animscripts/utility::func_D4D("aim_right_left"),var_03,var_00);
		self setanimlimited(animscripts/utility::func_D4D("aim_right_right"),var_04,var_00);
		self setanimlimited(animscripts/utility::func_D4D("add_aim_backleft_center"),var_02,var_00);
		self setanimlimited(animscripts/utility::func_D4D("add_aim_backleft_left"),var_03,var_00);
		self setanimlimited(animscripts/utility::func_D4D("add_aim_backleft_right"),var_04,var_00);
		self setanimlimited(animscripts/utility::func_D4D("add_aim_backright_center"),var_02,var_00);
		self setanimlimited(animscripts/utility::func_D4D("add_aim_backright_left"),var_03,var_00);
		self setanimlimited(animscripts/utility::func_D4D("add_aim_backright_right"),var_04,var_00);
		if(isplayer(self.enemy))
		{
			self updateplayersightaccuracy();
		}

		wait 0.05;
		thread func_0F00();
	}
}

//Function Number: 10
func_0EFC(param_00)
{
	self endon("death");
	self.ridingvehicle.steering_enable = 0;
	self setflaggedanimknoblimitedrestart("snowmobile_event",param_00,1,0.17);
	animscripts/shared::donotetracks("snowmobile_event",::func_0F0E);
	self setanimknoblimited(animscripts/utility::func_D4D("event_restore"),1,0.1);
	self.ridingvehicle.steering_enable = 1;
	self.var_EE8 = "none";
	self notify("snowmobile_event_finished");
}

//Function Number: 11
func_0EFD(param_00)
{
	self endon("death");
	self endon("killanimscript");
	var_01 = self.ridingvehicle;
	for(;;)
	{
		if(var_01.event["jump"][param_00])
		{
			var_01.event["jump"][param_00] = 0;
			self notify("snowmobile_event_occurred");
			self.var_EE8 = "jump";
			var_01.steering_enable = 0;
			self setflaggedanimknoblimitedrestart("jump",animscripts/utility::func_D4D("event_jump"),1,0.17);
		}

		if(var_01.event["bump"][param_00])
		{
			var_01.event["bump"][param_00] = 0;
			self notify("snowmobile_event_occurred");
			if(self.var_EE8 != "bump_big")
			{
				thread func_0EFC(animscripts/utility::func_D4D("event_bump"));
			}
		}

		if(var_01.event["bump_big"][param_00])
		{
			var_01.event["bump_big"][param_00] = 0;
			self notify("snowmobile_event_occurred");
			self.var_EE8 = "bump_big";
			thread func_0EFC(animscripts/utility::func_D4D("event_bump_big"));
		}

		if(var_01.event["sway_left"][param_00])
		{
			var_01.event["sway_left"][param_00] = 0;
			self notify("snowmobile_event_occurred");
			if(self.var_EE8 != "bump_big")
			{
				thread func_0EFC(animscripts/utility::func_D4D("event_sway")["left"]);
			}
		}

		if(var_01.event["sway_right"][param_00])
		{
			var_01.event["sway_right"][param_00] = 0;
			self notify("snowmobile_event_occurred");
			if(self.var_EE8 != "bump_big")
			{
				thread func_0EFC(animscripts/utility::func_D4D("event_sway")["right"]);
			}
		}

		wait 0.05;
	}
}

//Function Number: 12
func_0EFF()
{
	self notify("want_shoot_while_driving");
	self setanim(%sm_add_fire,1,0.2);
	if(isdefined(self.var_EE9))
	{
		return;
	}

	self.var_EE9 = 1;
	thread func_0F01();
	thread func_0F05();
}

//Function Number: 13
func_0F00()
{
	self endon("killanimscript");
	self endon("want_shoot_while_driving");
	wait 0.05;
	self notify("end_shoot_while_driving");
	self.var_EE9 = undefined;
	self clearanim(%sm_add_fire,0.2);
}

//Function Number: 14
func_0F01()
{
	self endon("killanimscript");
	self endon("end_shoot_while_driving");
	self.a.var_CE6 = ::func_0F03;
	func_0F02();
	self.var_EE9 = undefined;
}

//Function Number: 15
func_0F02()
{
	self endon("snowmobile_event_occurred");
	animscripts/shoot_behavior::func_CD7("normal");
}

//Function Number: 16
func_0F03()
{
	if(!isdefined(self.enemy))
	{
		self.var_CAB = undefined;
		self.var_CB1 = undefined;
		self.var_CDA = "none";
		return;
	}

	self.var_CAB = self.enemy;
	self.var_CB1 = self.enemy getshootatpos();
	var_00 = distancesquared(self.origin,self.enemy.origin);
	if(var_00 < 1000000)
	{
		self.var_CDA = "full";
	}
	else if(var_00 < 4000000)
	{
		self.var_CDA = "burst";
	}
	else
	{
		self.var_CDA = "single";
	}

	if(isdefined(self.enemy.vehicle))
	{
		var_01 = 0.5;
		var_02 = self.var_CAB.vehicle;
		var_03 = self.ridingvehicle;
		var_04 = var_03.origin - var_02.origin;
		var_05 = anglestoforward(var_02.angles);
		var_06 = anglestoright(var_02.angles);
		var_07 = vectordot(var_04,var_05);
		if(var_07 < 0)
		{
			var_08 = var_02 vehicle_getspeed() * var_01;
			var_08 = var_08 * 17.6;
			if(var_08 > 50)
			{
				var_09 = vectordot(var_04,var_06);
				var_09 = var_09 / 3;
				if(var_09 > 128)
				{
					var_09 = 128;
				}
				else if(var_09 < -128)
				{
					var_09 = -128;
				}

				if(var_09 > 0)
				{
					var_09 = 128 - var_09;
				}
				else
				{
					var_09 = -128 - var_09;
				}

				self.var_CAB = undefined;
				self.var_CB1 = var_02.origin + var_08 * var_05 + var_09 * var_06;
				return;
			}
		}
	}
}

//Function Number: 17
func_0F05()
{
	self endon("killanimscript");
	self endon("end_shoot_while_driving");
	self notify("doing_shootWhileDriving");
	self endon("doing_shootWhileDriving");
	for(;;)
	{
		if(!self.bulletsinclip)
		{
			wait 0.5;
			continue;
		}

		animscripts/combat_utility::func_F06();
	}
}

//Function Number: 18
func_0F07()
{
	if(!self.ridingvehicle.steering_enable)
	{
		return 0;
	}

	if(!animscripts/combat_utility::func_F08(0))
	{
		return 0;
	}

	if(!animscripts/utility::func_EE3())
	{
		return 0;
	}

	func_0F09();
	self notify("abort_reload");
	return 1;
}

//Function Number: 19
func_0F09()
{
	self endon("snowmobile_event_occurred");
	self.var_F0A = 1;
	self waittill("start_blending_reload");
	self setanim(%sm_aiming,0,0.25);
	self setflaggedanimrestart("gun_down",animscripts/utility::func_D4D("gun_down"),1,0.25);
	animscripts/shared::donotetracks("gun_down");
	self clearanim(animscripts/utility::func_D4D("gun_down"),0);
	self setflaggedanimknoballrestart("reload_anim",animscripts/utility::func_D4D("reload"),%body,1,0.25);
	animscripts/shared::donotetracks("reload_anim");
	self clearanim(%sm_reload,0.2);
	self setflaggedanimrestart("gun_up",animscripts/utility::func_D4D("gun_up"),1,0.25);
	self.var_F0B = 1;
	animscripts/shared::donotetracks("gun_up",::func_0F0C);
	self.var_F0A = undefined;
	self clearanim(%sm_reload,0.1);
	self setanim(%sm_aiming,1,0.1);
	if(isdefined(self.var_F0B))
	{
		self.var_F0B = undefined;
		animscripts/shared::donotetracks("gun_up",::func_0F0D);
		self clearanim(animscripts/utility::func_D4D("gun_up"),0);
	}
}

//Function Number: 20
func_0F0C(param_00)
{
	if(param_00 == "start_aim")
	{
		return 1;
	}
}

//Function Number: 21
func_0F0D(param_00)
{
	if(param_00 == "end")
	{
		return 1;
	}
}

//Function Number: 22
func_0F0E(param_00)
{
	if(param_00 == "start_lean")
	{
		return 1;
	}
}

//Function Number: 23
func_0F0F()
{
	self endon("killanimscript");
	self endon("stop tracking");
	var_00 = 0.05;
	var_01 = 8;
	var_02 = 0;
	var_03 = 0;
	var_04 = 1;
	for(;;)
	{
		animscripts/track::func_CC9();
		var_05 = (self.origin[0],self.origin[1],self geteye()[2]);
		var_06 = self.var_CB1;
		if(isdefined(self.var_CAB))
		{
			var_06 = self.var_CAB getshootatpos();
		}

		if(!isdefined(var_06))
		{
			var_03 = 0;
			var_07 = self getanglestolikelyenemypath();
			if(isdefined(var_07))
			{
				var_03 = angleclamp180(self.angles[1] - var_07[1]);
			}
		}
		else
		{
			var_08 = var_06 - var_05;
			var_09 = vectortoangles(var_08);
			var_03 = self.angles[1] - var_09[1];
			var_03 = angleclamp180(var_03);
		}

		if(var_03 > self.var_716 || var_03 < self.var_717)
		{
			var_03 = 0;
		}

		if(var_04)
		{
			var_04 = 0;
		}
		else
		{
			var_0A = var_03 - var_02;
			if(abs(var_0A) > var_01)
			{
				var_03 = var_02 + var_01 * common_scripts\utility::sign(var_0A);
			}
		}

		var_02 = var_03;
		var_0B = min(max(0 - var_03,0),90) / 90 * self.a.var_CC3;
		var_0C = min(max(var_03,0),90) / 90 * self.a.var_CC3;
		self setanimlimited(%sm_aim_4,var_0B,var_00);
		self setanimlimited(%sm_aim_6,var_0C,var_00);
		wait 0.05;
	}
}

//Function Number: 24
func_0F10()
{
	self endon("killanimscript");
	self endon("stop tracking");
	var_00 = 0.05;
	var_01 = 5;
	var_02 = 20;
	var_03 = 15;
	var_04 = 40;
	var_05 = 30;
	var_06 = 0;
	var_07 = 0;
	var_08 = 1;
	for(;;)
	{
		animscripts/track::func_CC9();
		var_09 = (self.origin[0],self.origin[1],self geteye()[2]);
		var_0A = self.var_CB1;
		if(isdefined(self.var_CAB))
		{
			var_0A = self.var_CAB getshootatpos();
		}

		if(!isdefined(var_0A))
		{
			var_07 = 0;
			var_0B = self getanglestolikelyenemypath();
			if(isdefined(var_0B))
			{
				var_07 = angleclamp180(self.angles[1] - var_0B[1]);
			}
		}
		else
		{
			var_0C = var_0A - var_09;
			var_0D = vectortoangles(var_0C);
			var_07 = self.angles[1] - var_0D[1];
			var_07 = angleclamp180(var_07);
		}

		if(isdefined(self.var_F0A) || var_07 > 0 && var_07 - self.var_716 * self.var_EF5 > 0 || var_07 < 0 && var_07 - self.var_717 * self.var_EF5 < 0)
		{
			var_07 = 0;
		}

		if(var_08)
		{
			var_08 = 0;
		}
		else
		{
			if(var_06 < -180 + var_04 && var_07 > 180 - var_05)
			{
				var_07 = -179;
			}

			if(var_06 > 180 - var_04 && var_07 < -180 + var_05)
			{
				var_07 = 179;
			}

			var_0E = var_07 - var_06;
			var_0F = var_02 - var_01 * abs(var_0E) / 180 + var_01;
			if(isdefined(self.var_F0A))
			{
				var_0F = var_03;
				if(abs(var_06) < 45)
				{
					self notify("start_blending_reload");
				}
			}

			if(abs(var_0E) > var_0F)
			{
				var_07 = var_06 + var_0F * common_scripts\utility::sign(var_0E);
			}
		}

		var_06 = var_07;
		var_10 = max(-90 - var_07,0) / 90 * self.a.var_CC3;
		var_11 = min(max(0 - var_07,0),90) / 90 * self.a.var_CC3;
		var_12 = max(90 - abs(var_07),0) / 90 * self.a.var_CC3;
		var_13 = min(max(var_07,0),90) / 90 * self.a.var_CC3;
		var_14 = max(-90 + var_07,0) / 90 * self.a.var_CC3;
		self setanimlimited(%sm_aim_1,var_10,var_00);
		self setanimlimited(%sm_aim_4_delta,var_11,var_00);
		self setanimlimited(%sm_aim_5_delta,var_12,var_00);
		self setanimlimited(%sm_aim_6_delta,var_13,var_00);
		self setanimlimited(%sm_aim_3,var_14,var_00);
		wait 0.05;
	}
}

//Function Number: 25
func_0F11(param_00,param_01,param_02)
{
	var_03 = undefined;
	var_04 = undefined;
	var_05 = 0;
	for(var_06 = 0;var_06 < param_00.size;var_06++)
	{
		var_07 = animscripts/utility::func_D61(param_02 - param_01[var_06]);
		if(!isdefined(var_03) || var_07 < var_05)
		{
			var_04 = var_03;
			var_03 = param_00[var_06];
			var_05 = var_07;
			continue;
		}

		if(!isdefined(var_04))
		{
			var_04 = param_00[var_06];
		}
	}

	var_08 = var_03;
	if(isdefined(level.var_F12) && var_08 == level.var_F12 && gettime() - level.var_F13 < 500)
	{
		var_08 = var_04;
	}

	anim.var_F12 = var_08;
	anim.var_F13 = gettime();
	return var_08;
}

//Function Number: 26
func_0F14()
{
	var_00 = self.ridingvehicle;
	var_01 = var_00.var_F15;
	var_01 = (var_01[0],var_01[1],randomfloatrange(200,400)) * 0.75;
	if(lengthsquared(var_01) > 1000000)
	{
		var_01 = vectornormalize(var_01) * 1000;
	}

	var_02 = spawn("script_origin",self.origin);
	var_02 moveslide((0,0,40),15,var_01);
	self linkto(var_02);
	var_02 thread func_0F18();
}

//Function Number: 27
func_0F16()
{
	var_00 = [];
	var_01 = [];
	var_02 = func_0F11(var_7B,var_01,self.var_723);
	animscripts/death::func_D56(var_02);
	return 1;
}

//Function Number: 28
func_0F17()
{
	var_00 = self.ridingvehicle;
	if(!isdefined(var_00))
	{
		return func_0F16();
	}

	var_01 = var_00.var_F15;
	func_0F14();
	var_02 = vectortoangles(var_01);
	var_03 = angleclamp180(var_02[1] - self.angles[1]);
	var_04 = [];
	var_05 = [];
	var_06 = func_0F11(var_7B,var_05,var_04);
	animscripts/death::func_D56(var_06);
	return 1;
}

//Function Number: 29
func_0F18()
{
	var_00 = self.origin;
	for(var_01 = 0;var_01 < 60;var_01++)
	{
		wait 0.05;
		var_00 = self.origin;
	}

	wait 3;
	if(isdefined(self))
	{
		self delete();
	}
}

//Function Number: 30
func_0F19(param_00)
{
	self.a.array["idle"] = level.scr_anim["snowmobile"][param_00]["idle"];
	self.a.array["drive"] = level.scr_anim["snowmobile"][param_00]["drive"];
	self.a.array["fire"] = level.scr_anim["snowmobile"][param_00]["fire"];
	self.a.array["single"] = animscripts/utility::array(level.scr_anim["snowmobile"][param_00]["single"]);
	self.a.array["burst2"] = level.scr_anim["snowmobile"][param_00]["fire"];
	self.a.array["burst3"] = level.scr_anim["snowmobile"][param_00]["fire"];
	self.a.array["burst4"] = level.scr_anim["snowmobile"][param_00]["fire"];
	self.a.array["burst5"] = level.scr_anim["snowmobile"][param_00]["fire"];
	self.a.array["burst6"] = level.scr_anim["snowmobile"][param_00]["fire"];
	self.a.array["semi2"] = level.scr_anim["snowmobile"][param_00]["fire"];
	self.a.array["semi3"] = level.scr_anim["snowmobile"][param_00]["fire"];
	self.a.array["semi4"] = level.scr_anim["snowmobile"][param_00]["fire"];
	self.a.array["semi5"] = level.scr_anim["snowmobile"][param_00]["fire"];
}

//Function Number: 31
func_0F1A(param_00)
{
	self.a.array = [];
	func_0F19("driver");
	self.a.array["left2right"] = level.scr_anim["snowmobile"]["driver"]["left2right"];
	self.a.array["right2left"] = level.scr_anim["snowmobile"]["driver"]["right2left"];
	self.a.array["straight_level_left"] = level.scr_anim["snowmobile"]["driver"]["straight_level"]["left"];
	self.a.array["straight_level_center"] = level.scr_anim["snowmobile"]["driver"]["straight_level"]["center"];
	self.a.array["straight_level_right"] = level.scr_anim["snowmobile"]["driver"]["straight_level"]["right"];
	self.a.array["add_aim_left_left"] = level.scr_anim["snowmobile"]["driver"]["add_aim_left"]["left"];
	self.a.array["add_aim_left_center"] = level.scr_anim["snowmobile"]["driver"]["add_aim_left"]["center"];
	self.a.array["add_aim_left_right"] = level.scr_anim["snowmobile"]["driver"]["add_aim_left"]["right"];
	self.a.array["add_aim_right_left"] = level.scr_anim["snowmobile"]["driver"]["add_aim_right"]["left"];
	self.a.array["add_aim_right_center"] = level.scr_anim["snowmobile"]["driver"]["add_aim_right"]["center"];
	self.a.array["add_aim_right_right"] = level.scr_anim["snowmobile"]["driver"]["add_aim_right"]["right"];
	if(param_00)
	{
		self.a.array["event_jump"] = level.scr_anim["snowmobile"]["driver"]["shoot_jump"];
		self.a.array["event_bump"] = level.scr_anim["snowmobile"]["driver"]["shoot_bump"];
		self.a.array["event_bump_big"] = level.scr_anim["snowmobile"]["driver"]["shoot_bump_big"];
		self.a.array["event_sway"] = [];
		self.a.array["event_sway"]["left"] = level.scr_anim["snowmobile"]["driver"]["shoot_sway_left"];
		self.a.array["event_sway"]["right"] = level.scr_anim["snowmobile"]["driver"]["shoot_sway_right"];
		self.a.array["event_restore"] = %sm_aiming;
		return;
	}

	self.a.array["event_jump"] = level.scr_anim["snowmobile"]["driver"]["drive_jump"];
	self.a.array["event_bump"] = level.scr_anim["snowmobile"]["driver"]["drive_bump"];
	self.a.array["event_bump_big"] = level.scr_anim["snowmobile"]["driver"]["drive_bump_big"];
	self.a.array["event_sway"] = [];
	self.a.array["event_sway"]["left"] = level.scr_anim["snowmobile"]["driver"]["drive_sway_left"];
	self.a.array["event_sway"]["right"] = level.scr_anim["snowmobile"]["driver"]["drive_sway_right"];
	self.a.array["event_restore"] = %sm_turn;
}

//Function Number: 32
func_0F1B(param_00)
{
	self.a.array = [];
	func_0F19("passenger");
	self.a.array["hide"] = level.scr_anim["snowmobile"]["passenger"]["hide"];
	self.a.array["lean_left"] = level.scr_anim["snowmobile"]["passenger"]["add_lean"]["left"];
	self.a.array["lean_right"] = level.scr_anim["snowmobile"]["passenger"]["add_lean"]["right"];
	self.a.array["reload"] = level.scr_anim["snowmobile"]["passenger"]["reload"];
	self.a.array["gun_up"] = level.scr_anim["snowmobile"]["passenger"]["gun_up"];
	self.a.array["gun_down"] = level.scr_anim["snowmobile"]["passenger"]["gun_down"];
	self.a.array["aim_left_left"] = level.scr_anim["snowmobile"]["passenger"]["aim_left"]["left"];
	self.a.array["aim_left_center"] = level.scr_anim["snowmobile"]["passenger"]["aim_left"]["center"];
	self.a.array["aim_left_right"] = level.scr_anim["snowmobile"]["passenger"]["aim_left"]["right"];
	self.a.array["aim_right_left"] = level.scr_anim["snowmobile"]["passenger"]["aim_right"]["left"];
	self.a.array["aim_right_center"] = level.scr_anim["snowmobile"]["passenger"]["aim_right"]["center"];
	self.a.array["aim_right_right"] = level.scr_anim["snowmobile"]["passenger"]["aim_right"]["right"];
	self.a.array["add_aim_backleft_left"] = level.scr_anim["snowmobile"]["passenger"]["add_aim_backleft"]["left"];
	self.a.array["add_aim_backleft_center"] = level.scr_anim["snowmobile"]["passenger"]["add_aim_backleft"]["center"];
	self.a.array["add_aim_backleft_right"] = level.scr_anim["snowmobile"]["passenger"]["add_aim_backleft"]["right"];
	self.a.array["add_aim_backright_left"] = level.scr_anim["snowmobile"]["passenger"]["add_aim_backright"]["left"];
	self.a.array["add_aim_backright_center"] = level.scr_anim["snowmobile"]["passenger"]["add_aim_backright"]["center"];
	self.a.array["add_aim_backright_right"] = level.scr_anim["snowmobile"]["passenger"]["add_aim_backright"]["right"];
	self.a.array["straight_level_left"] = level.scr_anim["snowmobile"]["passenger"]["straight_level"]["left"];
	self.a.array["straight_level_center"] = level.scr_anim["snowmobile"]["passenger"]["straight_level"]["center"];
	self.a.array["straight_level_right"] = level.scr_anim["snowmobile"]["passenger"]["straight_level"]["right"];
	if(param_00)
	{
		self.a.array["event_jump"] = level.scr_anim["snowmobile"]["passenger"]["drive_jump"];
		self.a.array["event_bump"] = level.scr_anim["snowmobile"]["passenger"]["drive_bump"];
		self.a.array["event_bump_big"] = level.scr_anim["snowmobile"]["passenger"]["drive_bump_big"];
		self.a.array["event_sway"] = [];
		self.a.array["event_sway"]["left"] = level.scr_anim["snowmobile"]["passenger"]["drive_sway_left"];
		self.a.array["event_sway"]["right"] = level.scr_anim["snowmobile"]["passenger"]["drive_sway_right"];
		self.a.array["event_restore"] = %sm_aiming;
		return;
	}

	self.a.array["event_jump"] = level.scr_anim["snowmobile"]["passenger"]["hide_jump"];
	self.a.array["event_bump"] = level.scr_anim["snowmobile"]["passenger"]["hide_bump"];
	self.a.array["event_bump_big"] = level.scr_anim["snowmobile"]["passenger"]["hide_bump_big"];
	self.a.array["event_sway"] = [];
	self.a.array["event_sway"]["left"] = level.scr_anim["snowmobile"]["passenger"]["hide_sway_left"];
	self.a.array["event_sway"]["right"] = level.scr_anim["snowmobile"]["passenger"]["hide_sway_right"];
	self.a.array["event_restore"] = %sm_turn;
}