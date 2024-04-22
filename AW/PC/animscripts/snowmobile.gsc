/*******************************************************************
 * Decompiled By: Bog
 * Decompiled File: snowmobile.gsc
 * Game: Call of Duty: Advanced Warfare
 * Platform: PC
 * Function Count: 32
 * Decompile Time: 458 ms
 * Timestamp: 4/22/2024 2:00:57 AM
*******************************************************************/

//Function Number: 1
main()
{
	self.current_event = "none";
	self.shoot_while_driving_thread = undefined;
	snowmobile_geton();
	if(isdefined(self.drivingvehicle))
	{
		main_driver();
		return;
	}

	main_passenger();
}

//Function Number: 2
snowmobile_geton()
{
	self.grenadeawareness = 0;
	self.a.pose = "crouch";
	maps\_utility::disable_surprise();
	self.allowpain = 0;
	self.flashbangimmunity = 1;
	self.getoffvehiclefunc = ::snowmobile_getoff;
	self.specialdeathfunc = ::snowmobile_normal_death;
	self.disablebulletwhizbyreaction = 1;
}

//Function Number: 3
snowmobile_getoff()
{
	self.allowpain = 1;
	self.flashbangimmunity = 0;
	maps\_utility::gun_recall();
	self.onsnowmobile = undefined;
	self.getoffvehiclefunc = undefined;
	self.specialdeathfunc = undefined;
	self.a.specialshootbehavior = undefined;
	self.disablebulletwhizbyreaction = undefined;
}

//Function Number: 4
main_driver()
{
	var_00 = self.ridingvehicle.driver_shooting || self.ridingvehicle.riders.size == 1;
	snowmobile_setanim_driver(var_00);
	if(var_00)
	{
		animscripts\shared::placeweaponon(self.primaryweapon,"left");
		self.rightaimlimit = 90;
		self.leftaimlimit = -90;
		animscripts\track::setanimaimweight(1,0.2);
		thread snowmobile_trackshootentorpos_driver();
		thread snowmobile_loop_driver_shooting();
	}
	else
	{
		animscripts\shared::placeweaponon(self.primaryweapon,"none");
		thread snowmobile_loop_driver();
	}

	snowmobile_handle_events("driver");
}

//Function Number: 5
main_passenger()
{
	snowmobile_setanim_passenger(self.ridingvehicle.passenger_shooting);
	if(self.ridingvehicle.passenger_shooting)
	{
		self.rightaimlimit = 180;
		self.leftaimlimit = -180;
		self.diraimlimit = 1;
		animscripts\track::setanimaimweight(1,0.2);
		thread snowmobile_trackshootentorpos_passenger();
		thread snowmobile_loop_passenger_shooting();
	}
	else
	{
		thread snowmobile_loop_passenger();
	}

	snowmobile_handle_events("passenger");
}

//Function Number: 6
snowmobile_loop_driver()
{
	self endon("death");
	self endon("killanimscript");
	var_00 = "left2right";
	var_01 = [];
	var_01["left2right"] = getanimlength(animscripts\utility::animarray("left2right"));
	var_01["right2left"] = getanimlength(animscripts\utility::animarray("right2left"));
	self setanimknoball(%sm_turn,%body,1,0);
	self setanim(animscripts\utility::animarray("drive"),1,0);
	self setanimknob(animscripts\utility::animarray(var_00),1,0);
	self setanimtime(animscripts\utility::animarray(var_00),0.5);
	for(;;)
	{
		if(self.ridingvehicle.steering_enable)
		{
			var_02 = 0.5 * 1 + maps\_vehicle_code::update_steering(self.ridingvehicle);
			var_03 = self getanimtime(animscripts\utility::animarray(var_00));
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

		self setanimknoblimited(animscripts\utility::animarray(var_00),1,0.1,var_04);
		self setanimtime(animscripts\utility::animarray(var_00),var_03);
		wait(0.05);
	}
}

//Function Number: 7
snowmobile_loop_passenger()
{
	self endon("death");
	self endon("killanimscript");
	self setanimknoball(animscripts\utility::animarray("hide"),%body,1,0);
	self setanimknob(animscripts\utility::animarray("drive"),1,0);
	for(;;)
	{
		var_00 = maps\_vehicle_code::update_steering(self.ridingvehicle);
		self setanimlimited(%sm_lean,abs(var_00),0.05);
		if(var_00 >= 0)
		{
			self setanimknoblimited(animscripts\utility::animarray("lean_right"),1,0.05);
		}
		else
		{
			self setanimknoblimited(animscripts\utility::animarray("lean_left"),1,0.05);
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
	self setanimknob(animscripts\utility::animarray("idle"),1,0);
	for(;;)
	{
		if(self.current_event != "none")
		{
			self waittill("snowmobile_event_finished");
			continue;
		}

		var_02 = maps\_vehicle_code::update_steering(self.ridingvehicle);
		var_03 = 1 - abs(var_02);
		var_04 = max(0,0 - var_02);
		var_05 = max(0,var_02);
		self setanimlimited(animscripts\utility::animarray("straight_level_center"),var_03,var_00);
		self setanimlimited(animscripts\utility::animarray("straight_level_left"),var_04,var_00);
		self setanimlimited(animscripts\utility::animarray("straight_level_right"),var_05,var_00);
		if(self.bulletsinclip <= 0)
		{
			animscripts\weaponlist::refillclip();
			var_01 = gettime() + 3000;
		}

		if(var_01 <= gettime())
		{
			snowmobile_start_shooting();
		}

		self setanimknoblimited(animscripts\utility::animarray("add_aim_left_center"),var_03,var_00);
		self setanimlimited(animscripts\utility::animarray("add_aim_left_left"),var_04,var_00);
		self setanimlimited(animscripts\utility::animarray("add_aim_left_right"),var_05,var_00);
		self setanimknoblimited(animscripts\utility::animarray("add_aim_right_center"),var_03,var_00);
		self setanimlimited(animscripts\utility::animarray("add_aim_right_left"),var_04,var_00);
		self setanimlimited(animscripts\utility::animarray("add_aim_right_right"),var_05,var_00);
		thread snowmobile_stop_shooting();
		wait(0.05);
	}
}

//Function Number: 9
snowmobile_loop_passenger_shooting()
{
	self endon("death");
	self endon("killanimscript");
	var_00 = 0.05;
	self setanimknoball(%sm_aiming,%body,1,0);
	self setanimknob(animscripts\utility::animarray("idle"),1,0);
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

		var_01 = maps\_vehicle_code::update_steering(self.ridingvehicle);
		var_02 = 1 - abs(var_01);
		var_03 = max(0,0 - var_01);
		var_04 = max(0,var_01);
		self setanimlimited(animscripts\utility::animarray("straight_level_center"),var_02,var_00);
		self setanimlimited(animscripts\utility::animarray("straight_level_left"),var_03,var_00);
		self setanimlimited(animscripts\utility::animarray("straight_level_right"),var_04,var_00);
		snowmobile_start_shooting();
		self setanimlimited(animscripts\utility::animarray("aim_left_center"),var_02,var_00);
		self setanimlimited(animscripts\utility::animarray("aim_left_left"),var_03,var_00);
		self setanimlimited(animscripts\utility::animarray("aim_left_right"),var_04,var_00);
		self setanimlimited(animscripts\utility::animarray("aim_right_center"),var_02,var_00);
		self setanimlimited(animscripts\utility::animarray("aim_right_left"),var_03,var_00);
		self setanimlimited(animscripts\utility::animarray("aim_right_right"),var_04,var_00);
		self setanimlimited(animscripts\utility::animarray("add_aim_backleft_center"),var_02,var_00);
		self setanimlimited(animscripts\utility::animarray("add_aim_backleft_left"),var_03,var_00);
		self setanimlimited(animscripts\utility::animarray("add_aim_backleft_right"),var_04,var_00);
		self setanimlimited(animscripts\utility::animarray("add_aim_backright_center"),var_02,var_00);
		self setanimlimited(animscripts\utility::animarray("add_aim_backright_left"),var_03,var_00);
		self setanimlimited(animscripts\utility::animarray("add_aim_backright_right"),var_04,var_00);
		if(isplayer(self.enemy))
		{
			self updateplayersightaccuracy();
		}

		wait(0.05);
		thread snowmobile_stop_shooting();
	}
}

//Function Number: 10
snowmobile_do_event(param_00)
{
	self endon("death");
	self.ridingvehicle.steering_enable = 0;
	self setflaggedanimknoblimitedrestart("snowmobile_event",param_00,1,0.17);
	animscripts\shared::donotetracks("snowmobile_event",::snowmobile_waitfor_start_lean);
	self setanimknoblimited(animscripts\utility::animarray("event_restore"),1,0.1);
	self.ridingvehicle.steering_enable = 1;
	self.current_event = "none";
	self notify("snowmobile_event_finished");
}

//Function Number: 11
snowmobile_handle_events(param_00)
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
			self.current_event = "jump";
			var_01.steering_enable = 0;
			self setflaggedanimknoblimitedrestart("jump",animscripts\utility::animarray("event_jump"),1,0.17);
		}

		if(var_01.event["bump"][param_00])
		{
			var_01.event["bump"][param_00] = 0;
			self notify("snowmobile_event_occurred");
			if(self.current_event != "bump_big")
			{
				thread snowmobile_do_event(animscripts\utility::animarray("event_bump"));
			}
		}

		if(var_01.event["bump_big"][param_00])
		{
			var_01.event["bump_big"][param_00] = 0;
			self notify("snowmobile_event_occurred");
			self.current_event = "bump_big";
			thread snowmobile_do_event(animscripts\utility::animarray("event_bump_big"));
		}

		if(var_01.event["sway_left"][param_00])
		{
			var_01.event["sway_left"][param_00] = 0;
			self notify("snowmobile_event_occurred");
			if(self.current_event != "bump_big")
			{
				thread snowmobile_do_event(animscripts\utility::animarray("event_sway")["left"]);
			}
		}

		if(var_01.event["sway_right"][param_00])
		{
			var_01.event["sway_right"][param_00] = 0;
			self notify("snowmobile_event_occurred");
			if(self.current_event != "bump_big")
			{
				thread snowmobile_do_event(animscripts\utility::animarray("event_sway")["right"]);
			}
		}

		wait(0.05);
	}
}

//Function Number: 12
snowmobile_start_shooting()
{
	self notify("want_shoot_while_driving");
	self setanim(%sm_add_fire,1,0.2);
	if(isdefined(self.shoot_while_driving_thread))
	{
		return;
	}

	self.shoot_while_driving_thread = 1;
	thread snowmobile_decide_shoot();
	thread snowmobile_shoot();
}

//Function Number: 13
snowmobile_stop_shooting()
{
	self endon("killanimscript");
	self endon("want_shoot_while_driving");
	wait(0.05);
	self notify("end_shoot_while_driving");
	self.shoot_while_driving_thread = undefined;
	self clearanim(%sm_add_fire,0.2);
}

//Function Number: 14
snowmobile_decide_shoot()
{
	self endon("killanimscript");
	self endon("end_shoot_while_driving");
	self.a.specialshootbehavior = ::snowmobileshootbehavior;
	snowmobile_decide_shoot_internal();
	self.shoot_while_driving_thread = undefined;
}

//Function Number: 15
snowmobile_decide_shoot_internal()
{
	self endon("snowmobile_event_occurred");
	animscripts\shoot_behavior::decidewhatandhowtoshoot("normal");
}

//Function Number: 16
snowmobileshootbehavior()
{
	if(!isdefined(self.enemy))
	{
		self.shootent = undefined;
		self.shootpos = undefined;
		self.shootstyle = "none";
		return;
	}

	self.shootent = self.enemy;
	self.shootpos = self.enemy getshootatpos();
	var_00 = distancesquared(self.origin,self.enemy.origin);
	if(var_00 < 1000000)
	{
		self.shootstyle = "full";
	}
	else if(var_00 < 4000000)
	{
		self.shootstyle = "burst";
	}
	else
	{
		self.shootstyle = "single";
	}

	if(isdefined(self.enemy.vehicle))
	{
		var_01 = 0.5;
		var_02 = self.shootent.vehicle;
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

				self.shootent = undefined;
				self.shootpos = var_02.origin + var_08 * var_05 + var_09 * var_06;
				return;
			}
		}
	}
}

//Function Number: 17
snowmobile_shoot()
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

		animscripts\combat_utility::shootuntilshootbehaviorchange();
	}
}

//Function Number: 18
snowmobile_reload()
{
	if(!self.ridingvehicle.steering_enable)
	{
		return 0;
	}

	if(!animscripts\combat_utility::needtoreload(0))
	{
		return 0;
	}

	if(!animscripts\utility::usingriflelikeweapon())
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
	self.stop_aiming_for_reload = 1;
	self waittill("start_blending_reload");
	self setanim(%sm_aiming,0,0.25);
	self setflaggedanimrestart("gun_down",animscripts\utility::animarray("gun_down"),1,0.25);
	animscripts\shared::donotetracks("gun_down");
	self clearanim(animscripts\utility::animarray("gun_down"),0);
	self setflaggedanimknoballrestart("reload_anim",animscripts\utility::animarray("reload"),%body,1,0.25);
	animscripts\shared::donotetracks("reload_anim");
	self clearanim(%sm_reload,0.2);
	self setflaggedanimrestart("gun_up",animscripts\utility::animarray("gun_up"),1,0.25);
	self.gun_up_for_reload = 1;
	animscripts\shared::donotetracks("gun_up",::snowmobile_waitfor_start_aim);
	self.stop_aiming_for_reload = undefined;
	self clearanim(%sm_reload,0.1);
	self setanim(%sm_aiming,1,0.1);
	if(isdefined(self.gun_up_for_reload))
	{
		self.gun_up_for_reload = undefined;
		animscripts\shared::donotetracks("gun_up",::snowmobile_waitfor_end);
		self clearanim(animscripts\utility::animarray("gun_up"),0);
	}
}

//Function Number: 20
snowmobile_waitfor_start_aim(param_00)
{
	if(param_00 == "start_aim")
	{
		return 1;
	}
}

//Function Number: 21
snowmobile_waitfor_end(param_00)
{
	if(param_00 == "end")
	{
		return 1;
	}
}

//Function Number: 22
snowmobile_waitfor_start_lean(param_00)
{
	if(param_00 == "start_lean")
	{
		return 1;
	}
}

//Function Number: 23
snowmobile_trackshootentorpos_driver()
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
		animscripts\track::incranimaimweight();
		var_05 = (self.origin[0],self.origin[1],self geteye()[2]);
		var_06 = self.shootpos;
		if(isdefined(self.shootent))
		{
			var_06 = self.shootent getshootatpos();
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
snowmobile_trackshootentorpos_passenger()
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
		animscripts\track::incranimaimweight();
		var_09 = (self.origin[0],self.origin[1],self geteye()[2]);
		var_0A = self.shootpos;
		if(isdefined(self.shootent))
		{
			var_0A = self.shootent getshootatpos();
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

		if(isdefined(self.stop_aiming_for_reload) || var_07 > 0 && var_07 - self.rightaimlimit * self.diraimlimit > 0 || var_07 < 0 && var_07 - self.leftaimlimit * self.diraimlimit < 0)
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
			if(isdefined(self.stop_aiming_for_reload))
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
snowmobile_get_death_anim(param_00,param_01,param_02)
{
	var_03 = undefined;
	var_04 = undefined;
	var_05 = 0;
	for(var_06 = 0;var_06 < param_00.size;var_06++)
	{
		var_07 = animscripts\utility::absangleclamp180(param_02 - param_01[var_06]);
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
	if(isdefined(level.prevsnowmobiledeath) && var_08 == level.prevsnowmobiledeath && gettime() - level.prevsnowmobiledeathtime < 500)
	{
		var_08 = var_04;
	}

	anim.prevsnowmobiledeath = var_08;
	anim.prevsnowmobiledeathtime = gettime();
	return var_08;
}

//Function Number: 26
snowmobile_death_launchslide()
{
	var_00 = self.ridingvehicle;
	var_01 = var_00.prevframevelocity;
	var_01 = (var_01[0],var_01[1],randomfloatrange(200,400)) * 0.75;
	if(lengthsquared(var_01) > 1000000)
	{
		var_01 = vectornormalize(var_01) * 1000;
	}

	var_02 = spawn("script_origin",self.origin);
	var_02 moveslide((0,0,40),15,var_01);
	self linkto(var_02);
	var_02 thread deleteshortly();
}

//Function Number: 27
snowmobile_normal_death()
{
	var_00 = [];
	var_00[0] = level.scr_anim["snowmobile"]["small"]["death"]["back"];
	var_00[1] = level.scr_anim["snowmobile"]["small"]["death"]["right"];
	var_00[2] = level.scr_anim["snowmobile"]["small"]["death"]["left"];
	var_01 = [];
	var_01[0] = -180;
	var_01[1] = -90;
	var_01[2] = 90;
	var_02 = snowmobile_get_death_anim(var_00,var_01,self.damageyaw);
	animscripts\death::playdeathanim(var_02);
	return 1;
}

//Function Number: 28
snowmobile_collide_death()
{
	var_00 = self.ridingvehicle;
	if(!isdefined(var_00))
	{
		return snowmobile_normal_death();
	}

	var_01 = var_00.prevframevelocity;
	snowmobile_death_launchslide();
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
	var_06 = snowmobile_get_death_anim(var_04,var_05,var_03);
	animscripts\death::playdeathanim(var_06);
	return 1;
}

//Function Number: 29
deleteshortly()
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
snowmobile_setanim_common(param_00)
{
	self.a.array["idle"] = level.scr_anim["snowmobile"][param_00]["idle"];
	self.a.array["drive"] = level.scr_anim["snowmobile"][param_00]["drive"];
	self.a.array["fire"] = level.scr_anim["snowmobile"][param_00]["fire"];
	self.a.array["single"] = animscripts\utility::array(level.scr_anim["snowmobile"][param_00]["single"]);
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
snowmobile_setanim_driver(param_00)
{
	self.a.array = [];
	snowmobile_setanim_common("driver");
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
snowmobile_setanim_passenger(param_00)
{
	self.a.array = [];
	snowmobile_setanim_common("passenger");
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