/*******************************************************************
 * Decompiled By: Bog
 * Decompiled File: animscripts\snowmobile.gsc
 * Game: Call of Duty: Ghosts
 * Platform: PC
 * Function Count: 32
 * Decompile Time: 559 ms
 * Timestamp: 10/27/2023 1:24:29 AM
*******************************************************************/

//Function Number: 1
func_4FDD()
{
	self.current_event = "none";
	self.var_742C = undefined;
	func_7682();
	if(isdefined(self.drivingvehicle))
	{
		func_4FE7();
		return;
	}

	func_4FF2();
}

//Function Number: 2
func_7682()
{
	self.grenadeawareness = 0;
	self.a.var_60B1 = "crouch";
	maps\_utility::func_2788();
	self.allowpain = 0;
	self.flashbangimmunity = 1;
	self.var_3B63 = ::func_7681;
	self.var_78EB = ::func_7689;
	self.var_279D = 1;
}

//Function Number: 3
func_7681()
{
	self.allowpain = 1;
	self.flashbangimmunity = 0;
	maps\_utility::gun_recall();
	self.var_5974 = undefined;
	self.var_3B63 = undefined;
	self.var_78EB = undefined;
	self.a.var_78F5 = undefined;
	self.var_279D = undefined;
}

//Function Number: 4
func_4FE7()
{
	var_00 = self.var_66AC.driver_shooting || self.var_66AC.var_66A8.size == 1;
	func_768E(var_00);
	if(var_00)
	{
		animscripts/shared::placeweaponon(self.primaryweapon,"left");
		self.rightaimlimit = 90;
		self.leftaimlimit = -90;
		animscripts/track::setanimaimweight(1,0.2);
		thread func_7694();
		thread snowmobile_loop_driver_shooting();
	}
	else
	{
		animscripts/shared::placeweaponon(self.primaryweapon,"none");
		thread snowmobile_loop_driver();
	}

	func_7683("driver");
}

//Function Number: 5
func_4FF2()
{
	func_768F(self.var_66AC.var_5B15);
	if(self.var_66AC.var_5B15)
	{
		self.rightaimlimit = 180;
		self.leftaimlimit = -180;
		self.diraimlimit = 1;
		animscripts/track::setanimaimweight(1,0.2);
		thread func_7695();
		thread func_7687();
	}
	else
	{
		thread func_7686();
	}

	func_7683("passenger");
}

//Function Number: 6
snowmobile_loop_driver()
{
	self endon("death");
	self endon("killanimscript");
	var_00 = "left2right";
	var_01 = [];
	var_01["left2right"] = getanimlength(animscripts/utility::animarray("left2right"));
	var_01["right2left"] = getanimlength(animscripts/utility::animarray("right2left"));
	self setanimknoball(%sm_turn,%body,1,0);
	self setanim(animscripts/utility::animarray("drive"),1,0);
	self setanimknob(animscripts/utility::animarray(var_00),1,0);
	self setanimtime(animscripts/utility::animarray(var_00),0.5);
	for(;;)
	{
		if(self.var_66AC.var_7BE7)
		{
			var_02 = 0.5 * 1 + maps\_vehicle_code::update_steering(self.var_66AC);
			var_03 = self getanimtime(animscripts/utility::animarray(var_00));
			if(var_00 == "right2left")
			{
				var_03 = 1 - var_03;
			}

			var_04 = 20 * abs(var_03 - var_02);
			if(var_03 < var_02)
			{
				var_00 = "left2right";
				var_04 = var_04 * var_01["left2right"];
			}
			else
			{
				var_00 = "right2left";
				var_04 = var_04 * var_01["right2left"];
				var_03 = 1 - var_03;
			}
		}
		else
		{
			var_00 = "left2right";
			var_04 = 0;
			var_03 = 0.5;
		}

		self setanimknoblimited(animscripts/utility::animarray(var_00),1,0.1,var_04);
		self setanimtime(animscripts/utility::animarray(var_00),var_03);
		wait(0.05);
	}
}

//Function Number: 7
func_7686()
{
	self endon("death");
	self endon("killanimscript");
	self setanimknoball(animscripts/utility::animarray("hide"),%body,1,0);
	self setanimknob(animscripts/utility::animarray("drive"),1,0);
	for(;;)
	{
		var_00 = maps\_vehicle_code::update_steering(self.var_66AC);
		self setanimlimited(%sm_lean,abs(var_00),0.05);
		if(var_00 >= 0)
		{
			self setanimknoblimited(animscripts/utility::animarray("lean_right"),1,0.05);
		}
		else
		{
			self setanimknoblimited(animscripts/utility::animarray("lean_left"),1,0.05);
		}

		wait(0.05);
	}
}

//Function Number: 8
snowmobile_loop_driver_shooting()
{
	self endon("death");
	self endon("killanimscript");
	var_00 = 0.05;
	var_01 = 0;
	self setanimknoball(%sm_aiming,%body,1,0);
	self setanimknob(animscripts/utility::animarray("idle"),1,0);
	for(;;)
	{
		if(self.current_event != "none")
		{
			self waittill("snowmobile_event_finished");
			continue;
		}

		var_02 = maps\_vehicle_code::update_steering(self.var_66AC);
		var_03 = 1 - abs(var_02);
		var_04 = max(0,0 - var_02);
		var_05 = max(0,var_02);
		self setanimlimited(animscripts/utility::animarray("straight_level_center"),var_03,var_00);
		self setanimlimited(animscripts/utility::animarray("straight_level_left"),var_04,var_00);
		self setanimlimited(animscripts/utility::animarray("straight_level_right"),var_05,var_00);
		if(self.bulletsinclip <= 0)
		{
			animscripts/weaponlist::refillclip();
			var_01 = gettime() + 3000;
		}

		if(var_01 <= gettime())
		{
			func_7692();
		}

		self setanimknoblimited(animscripts/utility::animarray("add_aim_left_center"),var_03,var_00);
		self setanimlimited(animscripts/utility::animarray("add_aim_left_left"),var_04,var_00);
		self setanimlimited(animscripts/utility::animarray("add_aim_left_right"),var_05,var_00);
		self setanimknoblimited(animscripts/utility::animarray("add_aim_right_center"),var_03,var_00);
		self setanimlimited(animscripts/utility::animarray("add_aim_right_left"),var_04,var_00);
		self setanimlimited(animscripts/utility::animarray("add_aim_right_right"),var_05,var_00);
		thread func_7693();
		wait(0.05);
	}
}

//Function Number: 9
func_7687()
{
	self endon("death");
	self endon("killanimscript");
	var_00 = 0.05;
	self setanimknoball(%sm_aiming,%body,1,0);
	self setanimknob(animscripts/utility::animarray("idle"),1,0);
	for(;;)
	{
		if(self.current_event != "none")
		{
			self waittill("snowmobile_event_finished");
			continue;
		}

		if(snowmobile_reload())
		{
			continue;
		}

		var_01 = maps\_vehicle_code::update_steering(self.var_66AC);
		var_02 = 1 - abs(var_01);
		var_03 = max(0,0 - var_01);
		var_04 = max(0,var_01);
		self setanimlimited(animscripts/utility::animarray("straight_level_center"),var_02,var_00);
		self setanimlimited(animscripts/utility::animarray("straight_level_left"),var_03,var_00);
		self setanimlimited(animscripts/utility::animarray("straight_level_right"),var_04,var_00);
		func_7692();
		self setanimlimited(animscripts/utility::animarray("aim_left_center"),var_02,var_00);
		self setanimlimited(animscripts/utility::animarray("aim_left_left"),var_03,var_00);
		self setanimlimited(animscripts/utility::animarray("aim_left_right"),var_04,var_00);
		self setanimlimited(animscripts/utility::animarray("aim_right_center"),var_02,var_00);
		self setanimlimited(animscripts/utility::animarray("aim_right_left"),var_03,var_00);
		self setanimlimited(animscripts/utility::animarray("aim_right_right"),var_04,var_00);
		self setanimlimited(animscripts/utility::animarray("add_aim_backleft_center"),var_02,var_00);
		self setanimlimited(animscripts/utility::animarray("add_aim_backleft_left"),var_03,var_00);
		self setanimlimited(animscripts/utility::animarray("add_aim_backleft_right"),var_04,var_00);
		self setanimlimited(animscripts/utility::animarray("add_aim_backright_center"),var_02,var_00);
		self setanimlimited(animscripts/utility::animarray("add_aim_backright_left"),var_03,var_00);
		self setanimlimited(animscripts/utility::animarray("add_aim_backright_right"),var_04,var_00);
		if(isplayer(self.enemy))
		{
			self updateplayersightaccuracy();
		}

		wait(0.05);
		thread func_7693();
	}
}

//Function Number: 10
func_767E(param_00)
{
	self endon("death");
	self.var_66AC.var_7BE7 = 0;
	self setflaggedanimknoblimitedrestart("snowmobile_event",param_00,1,0.17);
	animscripts/shared::func_2986("snowmobile_event",::func_7698);
	self setanimknoblimited(animscripts/utility::animarray("event_restore"),1,0.1);
	self.var_66AC.var_7BE7 = 1;
	self.current_event = "none";
	self notify("snowmobile_event_finished");
}

//Function Number: 11
func_7683(param_00)
{
	self endon("death");
	self endon("killanimscript");
	var_01 = self.var_66AC;
	for(;;)
	{
		if(var_01.event["jump"][param_00])
		{
			var_01.event["jump"][param_00] = 0;
			self notify("snowmobile_event_occurred");
			self.current_event = "jump";
			var_01.var_7BE7 = 0;
			self setflaggedanimknoblimitedrestart("jump",animscripts/utility::animarray("event_jump"),1,0.17);
		}

		if(var_01.event["bump"][param_00])
		{
			var_01.event["bump"][param_00] = 0;
			self notify("snowmobile_event_occurred");
			if(self.current_event != "bump_big")
			{
				thread func_767E(animscripts/utility::animarray("event_bump"));
			}
		}

		if(var_01.event["bump_big"][param_00])
		{
			var_01.event["bump_big"][param_00] = 0;
			self notify("snowmobile_event_occurred");
			self.current_event = "bump_big";
			thread func_767E(animscripts/utility::animarray("event_bump_big"));
		}

		if(var_01.event["sway_left"][param_00])
		{
			var_01.event["sway_left"][param_00] = 0;
			self notify("snowmobile_event_occurred");
			if(self.current_event != "bump_big")
			{
				thread func_767E(animscripts/utility::animarray("event_sway")["left"]);
			}
		}

		if(var_01.event["sway_right"][param_00])
		{
			var_01.event["sway_right"][param_00] = 0;
			self notify("snowmobile_event_occurred");
			if(self.current_event != "bump_big")
			{
				thread func_767E(animscripts/utility::animarray("event_sway")["right"]);
			}
		}

		wait(0.05);
	}
}

//Function Number: 12
func_7692()
{
	self notify("want_shoot_while_driving");
	self setanim(%sm_add_fire,1,0.2);
	if(isdefined(self.var_742C))
	{
	}

	self.var_742C = 1;
	thread snowmobile_decide_shoot();
	thread func_7690();
}

//Function Number: 13
func_7693()
{
	self endon("killanimscript");
	self endon("want_shoot_while_driving");
	wait(0.05);
	self notify("end_shoot_while_driving");
	self.var_742C = undefined;
	self clearanim(%sm_add_fire,0.2);
}

//Function Number: 14
snowmobile_decide_shoot()
{
	self endon("killanimscript");
	self endon("end_shoot_while_driving");
	self.a.var_78F5 = ::func_769B;
	snowmobile_decide_shoot_internal();
	self.var_742C = undefined;
}

//Function Number: 15
snowmobile_decide_shoot_internal()
{
	self endon("snowmobile_event_occurred");
	animscripts/shoot_behavior::func_2439("normal");
}

//Function Number: 16
func_769B()
{
	if(!isdefined(self.enemy))
	{
		self.var_7439 = undefined;
		self.var_7445 = undefined;
		self.var_744B = "none";
	}

	self.var_7439 = self.enemy;
	self.var_7445 = self.enemy getshootatpos();
	var_00 = distancesquared(self.origin,self.enemy.origin);
	if(var_00 < 1000000)
	{
		self.var_744B = "full";
	}
	else if(var_00 < 4000000)
	{
		self.var_744B = "burst";
	}
	else
	{
		self.var_744B = "single";
	}

	if(isdefined(self.enemy.vehicle))
	{
		var_01 = 0.5;
		var_02 = self.var_7439.vehicle;
		var_03 = self.var_66AC;
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

				self.var_7439 = undefined;
				self.var_7445 = var_02.origin + var_08 * var_05 + var_09 * var_06;
			}
		}
	}
}

//Function Number: 17
func_7690()
{
	self endon("killanimscript");
	self endon("end_shoot_while_driving");
	self notify("doing_shootWhileDriving");
	self endon("doing_shootWhileDriving");
	for(;;)
	{
		if(!self.bulletsinclip)
		{
			wait(0.5);
			continue;
		}

		animscripts/combat_utility::func_744D();
	}
}

//Function Number: 18
snowmobile_reload()
{
	if(!self.var_66AC.var_7BE7)
	{
		return 0;
	}

	if(!animscripts/combat_utility::func_5596(0))
	{
		return 0;
	}

	if(!animscripts/utility::usingriflelikeweapon())
	{
		return 0;
	}

	snowmobile_reload_internal();
	self notify("abort_reload");
	return 1;
}

//Function Number: 19
snowmobile_reload_internal()
{
	self endon("snowmobile_event_occurred");
	self.var_7C07 = 1;
	self waittill("start_blending_reload");
	self setanim(%sm_aiming,0,0.25);
	self setflaggedanimrestart("gun_down",animscripts/utility::animarray("gun_down"),1,0.25);
	animscripts/shared::func_2986("gun_down");
	self clearanim(animscripts/utility::animarray("gun_down"),0);
	self setflaggedanimknoballrestart("reload_anim",animscripts/utility::animarray("reload"),%body,1,0.25);
	animscripts/shared::func_2986("reload_anim");
	self clearanim(%sm_reload,0.2);
	self setflaggedanimrestart("gun_up",animscripts/utility::animarray("gun_up"),1,0.25);
	self.gun_up_for_reload = 1;
	animscripts/shared::func_2986("gun_up",::func_7697);
	self.var_7C07 = undefined;
	self clearanim(%sm_reload,0.1);
	self setanim(%sm_aiming,1,0.1);
	if(isdefined(self.gun_up_for_reload))
	{
		self.gun_up_for_reload = undefined;
		animscripts/shared::func_2986("gun_up",::func_7696);
		self clearanim(animscripts/utility::animarray("gun_up"),0);
	}
}

//Function Number: 20
func_7697(param_00)
{
	if(param_00 == "start_aim")
	{
		return 1;
	}
}

//Function Number: 21
func_7696(param_00)
{
	if(param_00 == "end")
	{
		return 1;
	}
}

//Function Number: 22
func_7698(param_00)
{
	if(param_00 == "start_lean")
	{
		return 1;
	}
}

//Function Number: 23
func_7694()
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
		animscripts/track::incranimaimweight();
		var_05 = (self.origin[0],self.origin[1],self geteye()[2]);
		var_06 = self.var_7445;
		if(isdefined(self.var_7439))
		{
			var_06 = self.var_7439 getshootatpos();
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

		if(var_03 > self.rightaimlimit || var_03 < self.leftaimlimit)
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
		var_0B = min(max(0 - var_03,0),90) / 90 * self.a.aimweight;
		var_0C = min(max(var_03,0),90) / 90 * self.a.aimweight;
		self setanimlimited(%sm_aim_4,var_0B,var_00);
		self setanimlimited(%sm_aim_6,var_0C,var_00);
		wait(0.05);
	}
}

//Function Number: 24
func_7695()
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
		animscripts/track::incranimaimweight();
		var_09 = (self.origin[0],self.origin[1],self geteye()[2]);
		var_0A = self.var_7445;
		if(isdefined(self.var_7439))
		{
			var_0A = self.var_7439 getshootatpos();
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

		if(isdefined(self.var_7C07) || var_07 > 0 && var_07 - self.rightaimlimit * self.diraimlimit > 0 || var_07 < 0 && var_07 - self.leftaimlimit * self.diraimlimit < 0)
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
			if(isdefined(self.var_7C07))
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
		var_10 = max(-90 - var_07,0) / 90 * self.a.aimweight;
		var_11 = min(max(0 - var_07,0),90) / 90 * self.a.aimweight;
		var_12 = max(90 - abs(var_07),0) / 90 * self.a.aimweight;
		var_13 = min(max(var_07,0),90) / 90 * self.a.aimweight;
		var_14 = max(-90 + var_07,0) / 90 * self.a.aimweight;
		self setanimlimited(%sm_aim_1,var_10,var_00);
		self setanimlimited(%sm_aim_4_delta,var_11,var_00);
		self setanimlimited(%sm_aim_5_delta,var_12,var_00);
		self setanimlimited(%sm_aim_6_delta,var_13,var_00);
		self setanimlimited(%sm_aim_3,var_14,var_00);
		wait(0.05);
	}
}

//Function Number: 25
func_7680(param_00,param_01,param_02)
{
	var_03 = undefined;
	var_04 = undefined;
	var_05 = 0;
	for(var_06 = 0;var_06 < param_00.size;var_06++)
	{
		var_07 = animscripts/utility::absangleclamp180(param_02 - param_01[var_06]);
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
	if(isdefined(level.var_6177) && var_08 == level.var_6177 && gettime() - level.var_6178 < 500)
	{
		var_08 = var_04;
	}

	anim.var_6177 = var_08;
	anim.var_6178 = gettime();
	return var_08;
}

//Function Number: 26
func_767B()
{
	var_00 = self.var_66AC;
	var_01 = var_00.var_6164;
	var_01 = (var_01[0],var_01[1],randomfloatrange(200,400)) * 0.75;
	if(lengthsquared(var_01) > 1000000)
	{
		var_01 = vectornormalize(var_01) * 1000;
	}

	var_02 = spawn("script_origin",self.origin);
	var_02 moveslide((0,0,40),15,var_01);
	self linkto(var_02);
	var_02 thread func_2597();
}

//Function Number: 27
func_7689()
{
	var_00 = [];
	var_00[0] = level.scr_anim["snowmobile"]["small"]["death"]["back"];
	var_00[1] = level.scr_anim["snowmobile"]["small"]["death"]["right"];
	var_00[2] = level.scr_anim["snowmobile"]["small"]["death"]["left"];
	var_01 = [];
	var_01[0] = -180;
	var_01[1] = -90;
	var_01[2] = 90;
	var_02 = func_7680(var_00,var_01,self.damageyaw);
	animscripts/death::func_5D59(var_02);
	return 1;
}

//Function Number: 28
func_767A()
{
	var_00 = self.var_66AC;
	if(!isdefined(var_00))
	{
		return func_7689();
	}

	var_01 = var_00.var_6164;
	func_767B();
	var_02 = vectortoangles(var_01);
	var_03 = angleclamp180(var_02[1] - self.angles[1]);
	var_04 = [];
	var_04[0] = level.scr_anim["snowmobile"]["big"]["death"]["back"];
	var_04[1] = level.scr_anim["snowmobile"]["big"]["death"]["left"];
	var_04[2] = level.scr_anim["snowmobile"]["big"]["death"]["front"];
	var_04[3] = level.scr_anim["snowmobile"]["big"]["death"]["right"];
	var_05 = [];
	var_05[0] = -180;
	var_05[1] = -90;
	var_05[2] = 0;
	var_05[3] = 90;
	var_06 = func_7680(var_04,var_05,var_03);
	animscripts/death::func_5D59(var_06);
	return 1;
}

//Function Number: 29
func_2597()
{
	var_00 = self.origin;
	for(var_01 = 0;var_01 < 60;var_01++)
	{
		wait(0.05);
		var_00 = self.origin;
	}

	wait(3);
	if(isdefined(self))
	{
		self delete();
	}
}

//Function Number: 30
func_768D(param_00)
{
	self.a.var_ED8["idle"] = level.scr_anim["snowmobile"][param_00]["idle"];
	self.a.var_ED8["drive"] = level.scr_anim["snowmobile"][param_00]["drive"];
	self.a.var_ED8["fire"] = level.scr_anim["snowmobile"][param_00]["fire"];
	self.a.var_ED8["single"] = animscripts/utility::func_ED8(level.scr_anim["snowmobile"][param_00]["single"]);
	self.a.var_ED8["burst2"] = level.scr_anim["snowmobile"][param_00]["fire"];
	self.a.var_ED8["burst3"] = level.scr_anim["snowmobile"][param_00]["fire"];
	self.a.var_ED8["burst4"] = level.scr_anim["snowmobile"][param_00]["fire"];
	self.a.var_ED8["burst5"] = level.scr_anim["snowmobile"][param_00]["fire"];
	self.a.var_ED8["burst6"] = level.scr_anim["snowmobile"][param_00]["fire"];
	self.a.var_ED8["semi2"] = level.scr_anim["snowmobile"][param_00]["fire"];
	self.a.var_ED8["semi3"] = level.scr_anim["snowmobile"][param_00]["fire"];
	self.a.var_ED8["semi4"] = level.scr_anim["snowmobile"][param_00]["fire"];
	self.a.var_ED8["semi5"] = level.scr_anim["snowmobile"][param_00]["fire"];
}

//Function Number: 31
func_768E(param_00)
{
	self.a.var_ED8 = [];
	func_768D("driver");
	self.a.var_ED8["left2right"] = level.scr_anim["snowmobile"]["driver"]["left2right"];
	self.a.var_ED8["right2left"] = level.scr_anim["snowmobile"]["driver"]["right2left"];
	self.a.var_ED8["straight_level_left"] = level.scr_anim["snowmobile"]["driver"]["straight_level"]["left"];
	self.a.var_ED8["straight_level_center"] = level.scr_anim["snowmobile"]["driver"]["straight_level"]["center"];
	self.a.var_ED8["straight_level_right"] = level.scr_anim["snowmobile"]["driver"]["straight_level"]["right"];
	self.a.var_ED8["add_aim_left_left"] = level.scr_anim["snowmobile"]["driver"]["add_aim_left"]["left"];
	self.a.var_ED8["add_aim_left_center"] = level.scr_anim["snowmobile"]["driver"]["add_aim_left"]["center"];
	self.a.var_ED8["add_aim_left_right"] = level.scr_anim["snowmobile"]["driver"]["add_aim_left"]["right"];
	self.a.var_ED8["add_aim_right_left"] = level.scr_anim["snowmobile"]["driver"]["add_aim_right"]["left"];
	self.a.var_ED8["add_aim_right_center"] = level.scr_anim["snowmobile"]["driver"]["add_aim_right"]["center"];
	self.a.var_ED8["add_aim_right_right"] = level.scr_anim["snowmobile"]["driver"]["add_aim_right"]["right"];
	if(param_00)
	{
		self.a.var_ED8["event_jump"] = level.scr_anim["snowmobile"]["driver"]["shoot_jump"];
		self.a.var_ED8["event_bump"] = level.scr_anim["snowmobile"]["driver"]["shoot_bump"];
		self.a.var_ED8["event_bump_big"] = level.scr_anim["snowmobile"]["driver"]["shoot_bump_big"];
		self.a.var_ED8["event_sway"] = [];
		self.a.var_ED8["event_sway"]["left"] = level.scr_anim["snowmobile"]["driver"]["shoot_sway_left"];
		self.a.var_ED8["event_sway"]["right"] = level.scr_anim["snowmobile"]["driver"]["shoot_sway_right"];
		self.a.var_ED8["event_restore"] = %sm_aiming;
	}

	self.a.var_ED8["event_jump"] = level.scr_anim["snowmobile"]["driver"]["drive_jump"];
	self.a.var_ED8["event_bump"] = level.scr_anim["snowmobile"]["driver"]["drive_bump"];
	self.a.var_ED8["event_bump_big"] = level.scr_anim["snowmobile"]["driver"]["drive_bump_big"];
	self.a.var_ED8["event_sway"] = [];
	self.a.var_ED8["event_sway"]["left"] = level.scr_anim["snowmobile"]["driver"]["drive_sway_left"];
	self.a.var_ED8["event_sway"]["right"] = level.scr_anim["snowmobile"]["driver"]["drive_sway_right"];
	self.a.var_ED8["event_restore"] = %sm_turn;
}

//Function Number: 32
func_768F(param_00)
{
	self.a.var_ED8 = [];
	func_768D("passenger");
	self.a.var_ED8["hide"] = level.scr_anim["snowmobile"]["passenger"]["hide"];
	self.a.var_ED8["lean_left"] = level.scr_anim["snowmobile"]["passenger"]["add_lean"]["left"];
	self.a.var_ED8["lean_right"] = level.scr_anim["snowmobile"]["passenger"]["add_lean"]["right"];
	self.a.var_ED8["reload"] = level.scr_anim["snowmobile"]["passenger"]["reload"];
	self.a.var_ED8["gun_up"] = level.scr_anim["snowmobile"]["passenger"]["gun_up"];
	self.a.var_ED8["gun_down"] = level.scr_anim["snowmobile"]["passenger"]["gun_down"];
	self.a.var_ED8["aim_left_left"] = level.scr_anim["snowmobile"]["passenger"]["aim_left"]["left"];
	self.a.var_ED8["aim_left_center"] = level.scr_anim["snowmobile"]["passenger"]["aim_left"]["center"];
	self.a.var_ED8["aim_left_right"] = level.scr_anim["snowmobile"]["passenger"]["aim_left"]["right"];
	self.a.var_ED8["aim_right_left"] = level.scr_anim["snowmobile"]["passenger"]["aim_right"]["left"];
	self.a.var_ED8["aim_right_center"] = level.scr_anim["snowmobile"]["passenger"]["aim_right"]["center"];
	self.a.var_ED8["aim_right_right"] = level.scr_anim["snowmobile"]["passenger"]["aim_right"]["right"];
	self.a.var_ED8["add_aim_backleft_left"] = level.scr_anim["snowmobile"]["passenger"]["add_aim_backleft"]["left"];
	self.a.var_ED8["add_aim_backleft_center"] = level.scr_anim["snowmobile"]["passenger"]["add_aim_backleft"]["center"];
	self.a.var_ED8["add_aim_backleft_right"] = level.scr_anim["snowmobile"]["passenger"]["add_aim_backleft"]["right"];
	self.a.var_ED8["add_aim_backright_left"] = level.scr_anim["snowmobile"]["passenger"]["add_aim_backright"]["left"];
	self.a.var_ED8["add_aim_backright_center"] = level.scr_anim["snowmobile"]["passenger"]["add_aim_backright"]["center"];
	self.a.var_ED8["add_aim_backright_right"] = level.scr_anim["snowmobile"]["passenger"]["add_aim_backright"]["right"];
	self.a.var_ED8["straight_level_left"] = level.scr_anim["snowmobile"]["passenger"]["straight_level"]["left"];
	self.a.var_ED8["straight_level_center"] = level.scr_anim["snowmobile"]["passenger"]["straight_level"]["center"];
	self.a.var_ED8["straight_level_right"] = level.scr_anim["snowmobile"]["passenger"]["straight_level"]["right"];
	if(param_00)
	{
		self.a.var_ED8["event_jump"] = level.scr_anim["snowmobile"]["passenger"]["drive_jump"];
		self.a.var_ED8["event_bump"] = level.scr_anim["snowmobile"]["passenger"]["drive_bump"];
		self.a.var_ED8["event_bump_big"] = level.scr_anim["snowmobile"]["passenger"]["drive_bump_big"];
		self.a.var_ED8["event_sway"] = [];
		self.a.var_ED8["event_sway"]["left"] = level.scr_anim["snowmobile"]["passenger"]["drive_sway_left"];
		self.a.var_ED8["event_sway"]["right"] = level.scr_anim["snowmobile"]["passenger"]["drive_sway_right"];
		self.a.var_ED8["event_restore"] = %sm_aiming;
	}

	self.a.var_ED8["event_jump"] = level.scr_anim["snowmobile"]["passenger"]["hide_jump"];
	self.a.var_ED8["event_bump"] = level.scr_anim["snowmobile"]["passenger"]["hide_bump"];
	self.a.var_ED8["event_bump_big"] = level.scr_anim["snowmobile"]["passenger"]["hide_bump_big"];
	self.a.var_ED8["event_sway"] = [];
	self.a.var_ED8["event_sway"]["left"] = level.scr_anim["snowmobile"]["passenger"]["hide_sway_left"];
	self.a.var_ED8["event_sway"]["right"] = level.scr_anim["snowmobile"]["passenger"]["hide_sway_right"];
	self.a.var_ED8["event_restore"] = %sm_turn;
}