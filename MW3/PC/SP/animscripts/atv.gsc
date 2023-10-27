/*******************************************************************
 * Decompiled By: Bog
 * Decompiled File: animscripts\atv.gsc
 * Game: Call of Duty: Modern Warfare 3
 * Platform: PC
 * Function Count: 27
 * Decompile Time: 478 ms
 * Timestamp: 10/27/2023 2:17:39 AM
*******************************************************************/

//Function Number: 1
main()
{
	self.var_EE8 = "none";
	self.var_EE9 = undefined;
	func_24CB();
	func_0EF0();
}

//Function Number: 2
func_24CB()
{
	self.grenadeawareness = 0;
	self.a.pose = "crouch";
	maps\_utility::disable_surprise();
	self.allowpain = 0;
	self.getoffvehiclefunc = ::func_24CC;
	self.var_D4B = ::func_24E1;
	self.disablebulletwhizbyreaction = 1;
}

//Function Number: 3
func_24CC()
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
	func_24E4(var_00);
	if(var_00)
	{
		animscripts/shared::func_C9B(self.primaryweapon,"left");
		self.var_716 = 90;
		self.var_717 = -90;
		animscripts/track::func_CC4(1,0.2);
		thread func_24DC();
		thread func_24CE();
	}
	else
	{
		animscripts/shared::func_C9B(self.primaryweapon,"none");
		thread func_24CD();
	}

	func_24D0("driver");
}

//Function Number: 5
func_24CD()
{
	self endon("death");
	self endon("killanimscript");
	var_00 = "left2right";
	var_01 = [];
	self setanimknoball(%atv_turn,%body,1,0);
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

//Function Number: 6
func_24CE()
{
	self endon("death");
	self endon("killanimscript");
	var_00 = 0.05;
	var_01 = 0;
	self setanimknoball(%atv_aiming,%body,1,0);
	self setanimknob(animscripts/utility::func_D4D("idle"),1,0);
	for(;;)
	{
		if(self.var_EE8 != "none")
		{
			self waittill("atv_event_finished");
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
			func_24D1();
		}

		self setanimknoblimited(animscripts/utility::func_D4D("add_aim_left_center"),var_03,var_00);
		self setanimlimited(animscripts/utility::func_D4D("add_aim_left_left"),var_04,var_00);
		self setanimlimited(animscripts/utility::func_D4D("add_aim_left_right"),var_05,var_00);
		self setanimknoblimited(animscripts/utility::func_D4D("add_aim_right_center"),var_03,var_00);
		self setanimlimited(animscripts/utility::func_D4D("add_aim_right_left"),var_04,var_00);
		self setanimlimited(animscripts/utility::func_D4D("add_aim_right_right"),var_05,var_00);
		thread func_24D2();
		wait 0.05;
	}
}

//Function Number: 7
func_24CF(param_00)
{
	self endon("death");
	self.ridingvehicle.steering_enable = 0;
	self setflaggedanimknoblimitedrestart("atv_event",param_00,1,0.17);
	animscripts/shared::donotetracks("atv_event",::func_24DB);
	self setanimknoblimited(animscripts/utility::func_D4D("event_restore"),1,0.1);
	self.ridingvehicle.steering_enable = 1;
	self.var_EE8 = "none";
	self notify("atv_event_finished");
}

//Function Number: 8
func_24D0(param_00)
{
	self endon("death");
	self endon("killanimscript");
	var_01 = self.ridingvehicle;
	for(;;)
	{
		if(var_01.event["jump"][param_00])
		{
			var_01.event["jump"][param_00] = 0;
			self notify("atv_event_occurred");
			self.var_EE8 = "jump";
			var_01.steering_enable = 0;
			self setflaggedanimknoblimitedrestart("jump",animscripts/utility::func_D4D("event_jump"),1,0.17);
		}

		if(var_01.event["bump"][param_00])
		{
			var_01.event["bump"][param_00] = 0;
			self notify("atv_event_occurred");
			if(self.var_EE8 != "bump_big")
			{
				thread func_24CF(animscripts/utility::func_D4D("event_bump"));
			}
		}

		if(var_01.event["bump_big"][param_00])
		{
			var_01.event["bump_big"][param_00] = 0;
			self notify("atv_event_occurred");
			self.var_EE8 = "bump_big";
			thread func_24CF(animscripts/utility::func_D4D("event_bump_big"));
		}

		if(var_01.event["sway_left"][param_00])
		{
			var_01.event["sway_left"][param_00] = 0;
			self notify("atv_event_occurred");
			if(self.var_EE8 != "bump_big")
			{
				thread func_24CF(animscripts/utility::func_D4D("event_sway")["left"]);
			}
		}

		if(var_01.event["sway_right"][param_00])
		{
			var_01.event["sway_right"][param_00] = 0;
			self notify("atv_event_occurred");
			if(self.var_EE8 != "bump_big")
			{
				thread func_24CF(animscripts/utility::func_D4D("event_sway")["right"]);
			}
		}

		wait 0.05;
	}
}

//Function Number: 9
func_24D1()
{
	self notify("want_shoot_while_driving");
	self setanim(%atv_add_fire,1,0.2);
	if(isdefined(self.var_EE9))
	{
		return;
	}

	self.var_EE9 = 1;
	thread func_24D3();
	thread func_24D6();
}

//Function Number: 10
func_24D2()
{
	self endon("killanimscript");
	self endon("want_shoot_while_driving");
	wait 0.05;
	self notify("end_shoot_while_driving");
	self.var_EE9 = undefined;
	self clearanim(%atv_add_fire,0.2);
}

//Function Number: 11
func_24D3()
{
	self endon("killanimscript");
	self endon("end_shoot_while_driving");
	self.a.var_CE6 = ::func_24D5;
	func_24D4();
	self.var_EE9 = undefined;
}

//Function Number: 12
func_24D4()
{
	self endon("atv_event_occurred");
	animscripts/shoot_behavior::func_CD7("normal");
}

//Function Number: 13
func_24D5()
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

//Function Number: 14
func_24D6()
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

//Function Number: 15
func_24D7()
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

	func_24D8();
	self notify("abort_reload");
	return 1;
}

//Function Number: 16
func_24D8()
{
	self endon("atv_event_occurred");
	self.var_F0A = 1;
	self waittill("start_blending_reload");
	self setanim(%atv_aiming,0,0.25);
	self setflaggedanimrestart("gun_down",animscripts/utility::func_D4D("gun_down"),1,0.25);
	animscripts/shared::donotetracks("gun_down");
	self clearanim(animscripts/utility::func_D4D("gun_down"),0);
	self setflaggedanimknoballrestart("reload_anim",animscripts/utility::func_D4D("reload"),%body,1,0.25);
	animscripts/shared::donotetracks("reload_anim");
	self clearanim(%atv_reload,0.2);
	self setflaggedanimrestart("gun_up",animscripts/utility::func_D4D("gun_up"),1,0.25);
	self.var_F0B = 1;
	animscripts/shared::donotetracks("gun_up",::func_24D9);
	self.var_F0A = undefined;
	self clearanim(%atv_reload,0.1);
	self setanim(%atv_aiming,1,0.1);
	if(isdefined(self.var_F0B))
	{
		self.var_F0B = undefined;
		animscripts/shared::donotetracks("gun_up",::func_24DA);
		self clearanim(animscripts/utility::func_D4D("gun_up"),0);
	}
}

//Function Number: 17
func_24D9(param_00)
{
	if(param_00 == "start_aim")
	{
		return 1;
	}
}

//Function Number: 18
func_24DA(param_00)
{
	if(param_00 == "end")
	{
		return 1;
	}
}

//Function Number: 19
func_24DB(param_00)
{
	if(param_00 == "start_lean")
	{
		return 1;
	}
}

//Function Number: 20
func_24DC()
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
		self setanimlimited(%atv_aim_4,var_0B,var_00);
		self setanimlimited(%atv_aim_6,var_0C,var_00);
		wait 0.05;
	}
}

//Function Number: 21
func_24DD(param_00,param_01,param_02)
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
	if(isdefined(level.var_24DE) && var_08 == level.var_24DE && gettime() - level.var_24DF < 500)
	{
		var_08 = var_04;
	}

	anim.var_24DE = var_08;
	anim.var_24DF = gettime();
	return var_08;
}

//Function Number: 22
func_24E0()
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

//Function Number: 23
func_24E1()
{
	var_00 = [];
	var_01 = [];
	var_02 = func_24DD(var_7B,var_01,self.var_723);
	animscripts/death::func_D56(var_02);
	return 1;
}

//Function Number: 24
func_24E2()
{
	var_00 = self.ridingvehicle;
	if(!isdefined(var_00))
	{
		return func_24E1();
	}

	var_01 = var_00.var_F15;
	func_24E0();
	var_02 = vectortoangles(var_01);
	var_03 = angleclamp180(var_02[1] - self.angles[1]);
	var_04 = [];
	var_05 = [];
	var_06 = func_24DD(var_7B,var_05,var_04);
	animscripts/death::func_D56(var_06);
	return 1;
}

//Function Number: 25
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

//Function Number: 26
func_24E3(param_00)
{
	self.a.array["idle"] = level.scr_anim["atv"][param_00]["idle"];
	self.a.array["drive"] = level.scr_anim["atv"][param_00]["drive"];
	self.a.array["fire"] = level.scr_anim["atv"][param_00]["fire"];
	self.a.array["single"] = animscripts/utility::array(level.scr_anim["atv"][param_00]["single"]);
	self.a.array["burst2"] = level.scr_anim["atv"][param_00]["fire"];
	self.a.array["burst3"] = level.scr_anim["atv"][param_00]["fire"];
	self.a.array["burst4"] = level.scr_anim["atv"][param_00]["fire"];
	self.a.array["burst5"] = level.scr_anim["atv"][param_00]["fire"];
	self.a.array["burst6"] = level.scr_anim["atv"][param_00]["fire"];
	self.a.array["semi2"] = level.scr_anim["atv"][param_00]["fire"];
	self.a.array["semi3"] = level.scr_anim["atv"][param_00]["fire"];
	self.a.array["semi4"] = level.scr_anim["atv"][param_00]["fire"];
	self.a.array["semi5"] = level.scr_anim["atv"][param_00]["fire"];
}

//Function Number: 27
func_24E4(param_00)
{
	self.a.array = [];
	func_24E3("driver");
	self.a.array["left2right"] = level.scr_anim["atv"]["driver"]["left2right"];
	self.a.array["right2left"] = level.scr_anim["atv"]["driver"]["right2left"];
	self.a.array["straight_level_left"] = level.scr_anim["atv"]["driver"]["straight_level"]["left"];
	self.a.array["straight_level_center"] = level.scr_anim["atv"]["driver"]["straight_level"]["center"];
	self.a.array["straight_level_right"] = level.scr_anim["atv"]["driver"]["straight_level"]["right"];
	self.a.array["add_aim_left_left"] = level.scr_anim["atv"]["driver"]["add_aim_left"]["left"];
	self.a.array["add_aim_left_center"] = level.scr_anim["atv"]["driver"]["add_aim_left"]["center"];
	self.a.array["add_aim_left_right"] = level.scr_anim["atv"]["driver"]["add_aim_left"]["right"];
	self.a.array["add_aim_right_left"] = level.scr_anim["atv"]["driver"]["add_aim_right"]["left"];
	self.a.array["add_aim_right_center"] = level.scr_anim["atv"]["driver"]["add_aim_right"]["center"];
	self.a.array["add_aim_right_right"] = level.scr_anim["atv"]["driver"]["add_aim_right"]["right"];
	if(param_00)
	{
		self.a.array["event_jump"] = level.scr_anim["atv"]["driver"]["shoot_jump"];
		self.a.array["event_bump"] = level.scr_anim["atv"]["driver"]["shoot_bump"];
		self.a.array["event_bump_big"] = level.scr_anim["atv"]["driver"]["shoot_bump_big"];
		self.a.array["event_sway"] = [];
		self.a.array["event_sway"]["left"] = level.scr_anim["atv"]["driver"]["shoot_sway_left"];
		self.a.array["event_sway"]["right"] = level.scr_anim["atv"]["driver"]["shoot_sway_right"];
		self.a.array["event_restore"] = %atv_aiming;
		return;
	}

	self.a.array["event_jump"] = level.scr_anim["atv"]["driver"]["drive_jump"];
	self.a.array["event_bump"] = level.scr_anim["atv"]["driver"]["drive_bump"];
	self.a.array["event_bump_big"] = level.scr_anim["atv"]["driver"]["drive_bump_big"];
	self.a.array["event_sway"] = [];
	self.a.array["event_sway"]["left"] = level.scr_anim["atv"]["driver"]["drive_sway_left"];
	self.a.array["event_sway"]["right"] = level.scr_anim["atv"]["driver"]["drive_sway_right"];
	self.a.array["event_restore"] = %atv_turn;
}