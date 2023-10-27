/*******************************************************************
 * Decompiled By: Bog
 * Decompiled File: scripts\anim\atv.gsc
 * Game: Call of Duty: Infinite Warfare
 * Platform: PC
 * Function Count: 27
 * Decompile Time: 1352 ms
 * Timestamp: 10/26/2023 11:59:54 PM
*******************************************************************/

//Function Number: 1
main()
{
	self.var_4B71 = "none";
	self.var_FE91 = undefined;
	func_255B();
	func_B1C3();
}

//Function Number: 2
func_255B()
{
	self.var_163 = 0;
	self.var_1491.var_D6A5 = "crouch";
	scripts\sp\_utility::func_558D();
	self.allowpain = 0;
	self.var_6EC4 = 1;
	self.var_8020 = ::func_255A;
	self.var_10957 = ::func_255F;
	self.var_55B5 = 1;
}

//Function Number: 3
func_255A()
{
	self.allowpain = 1;
	self.var_6EC4 = 0;
	scripts\sp\_utility::func_86E2();
	self.var_C4C7 = undefined;
	self.var_4C37["combat"] = undefined;
	self.var_4C37["stop"] = undefined;
	self.var_8020 = undefined;
	self.var_10957 = undefined;
	self.var_1491.var_1096D = undefined;
	self.var_55B5 = undefined;
}

//Function Number: 4
func_B1C3()
{
	var_00 = self.var_E500.var_5BCB || self.var_E500.var_E4FB.size == 1;
	func_2565(var_00);
	if(var_00)
	{
		scripts\anim\shared::func_CC2C(self.var_D8E1,"left");
		self.var_268 = -90;
		self.var_1B7 = 90;
		scripts\anim\track::func_F641(1,0.2);
		thread func_256A();
		thread func_255E();
	}
	else
	{
		scripts\anim\shared::func_CC2C(self.var_D8E1,"none");
		thread func_255D();
	}

	func_255C("driver");
}

//Function Number: 5
func_255D()
{
	self endon("death");
	self endon("killanimscript");
	var_00 = "left2right";
	var_01 = [];
	var_01["left2right"] = getanimlength(scripts\anim\utility::func_1F64("left2right"));
	var_01["right2left"] = getanimlength(scripts\anim\utility::func_1F64("right2left"));
	self method_82A5(%atv_turn,%body,1,0);
	self method_82A2(scripts\anim\utility::func_1F64("drive"),1,0);
	self method_82A4(scripts\anim\utility::func_1F64(var_00),1,0);
	self method_82B0(scripts\anim\utility::func_1F64(var_00),0.5);
	for(;;)
	{
		if(self.var_E500.var_10F83)
		{
			var_02 = 0.5 * 1 + scripts\sp\_vehicle_code::func_12E33(self.var_E500);
			var_03 = self method_8102(scripts\anim\utility::func_1F64(var_00));
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

		self method_82A9(scripts\anim\utility::func_1F64(var_00),1,0.1,var_04);
		self method_82B0(scripts\anim\utility::func_1F64(var_00),var_03);
		wait(0.05);
	}
}

//Function Number: 6
func_255E()
{
	self endon("death");
	self endon("killanimscript");
	var_00 = 0.05;
	var_01 = 0;
	self method_82A5(%atv_aiming,%body,1,0);
	self method_82A4(scripts\anim\utility::func_1F64("idle"),1,0);
	for(;;)
	{
		if(self.var_4B71 != "none")
		{
			self waittill("atv_event_finished");
			continue;
		}

		var_02 = scripts\sp\_vehicle_code::func_12E33(self.var_E500);
		var_03 = 1 - abs(var_02);
		var_04 = max(0,0 - var_02);
		var_05 = max(0,var_02);
		self method_82AC(scripts\anim\utility::func_1F64("straight_level_center"),var_03,var_00);
		self method_82AC(scripts\anim\utility::func_1F64("straight_level_left"),var_04,var_00);
		self method_82AC(scripts\anim\utility::func_1F64("straight_level_right"),var_05,var_00);
		if(self.var_3250 <= 0)
		{
			scripts\anim\weaponlist::func_DE4D();
			var_01 = gettime() + 3000;
		}

		if(var_01 <= gettime())
		{
			func_2568();
		}

		self method_82A9(scripts\anim\utility::func_1F64("add_aim_left_center"),var_03,var_00);
		self method_82AC(scripts\anim\utility::func_1F64("add_aim_left_left"),var_04,var_00);
		self method_82AC(scripts\anim\utility::func_1F64("add_aim_left_right"),var_05,var_00);
		self method_82A9(scripts\anim\utility::func_1F64("add_aim_right_center"),var_03,var_00);
		self method_82AC(scripts\anim\utility::func_1F64("add_aim_right_left"),var_04,var_00);
		self method_82AC(scripts\anim\utility::func_1F64("add_aim_right_right"),var_05,var_00);
		thread func_2569();
		wait(0.05);
	}
}

//Function Number: 7
func_2558(param_00)
{
	self endon("death");
	self.var_E500.var_10F83 = 0;
	self method_82E6("atv_event",param_00,1,0.17);
	scripts\anim\shared::func_592B("atv_event",::func_256F);
	self method_82A9(scripts\anim\utility::func_1F64("event_restore"),1,0.1);
	self.var_E500.var_10F83 = 1;
	self.var_4B71 = "none";
	self notify("atv_event_finished");
}

//Function Number: 8
func_255C(param_00)
{
	self endon("death");
	self endon("killanimscript");
	var_01 = self.var_E500;
	for(;;)
	{
		if(var_01.var_67E5["jump"][param_00])
		{
			var_01.var_67E5["jump"][param_00] = 0;
			self notify("atv_event_occurred");
			self.var_4B71 = "jump";
			var_01.var_10F83 = 0;
			self method_82E6("jump",scripts\anim\utility::func_1F64("event_jump"),1,0.17);
		}

		if(var_01.var_67E5["bump"][param_00])
		{
			var_01.var_67E5["bump"][param_00] = 0;
			self notify("atv_event_occurred");
			if(self.var_4B71 != "bump_big")
			{
				thread func_2558(scripts\anim\utility::func_1F64("event_bump"));
			}
		}

		if(var_01.var_67E5["bump_big"][param_00])
		{
			var_01.var_67E5["bump_big"][param_00] = 0;
			self notify("atv_event_occurred");
			self.var_4B71 = "bump_big";
			thread func_2558(scripts\anim\utility::func_1F64("event_bump_big"));
		}

		if(var_01.var_67E5["sway_left"][param_00])
		{
			var_01.var_67E5["sway_left"][param_00] = 0;
			self notify("atv_event_occurred");
			if(self.var_4B71 != "bump_big")
			{
				thread func_2558(scripts\anim\utility::func_1F64("event_sway")["left"]);
			}
		}

		if(var_01.var_67E5["sway_right"][param_00])
		{
			var_01.var_67E5["sway_right"][param_00] = 0;
			self notify("atv_event_occurred");
			if(self.var_4B71 != "bump_big")
			{
				thread func_2558(scripts\anim\utility::func_1F64("event_sway")["right"]);
			}
		}

		wait(0.05);
	}
}

//Function Number: 9
func_2568()
{
	self notify("want_shoot_while_driving");
	self method_82A2(%atv_add_fire,1,0.2);
	if(isdefined(self.var_FE91))
	{
		return;
	}

	self.var_FE91 = 1;
	thread func_2556();
	thread func_2566();
}

//Function Number: 10
func_2569()
{
	self endon("killanimscript");
	self endon("want_shoot_while_driving");
	wait(0.05);
	self notify("end_shoot_while_driving");
	self.var_FE91 = undefined;
	self method_806F(%atv_add_fire,0.2);
}

//Function Number: 11
func_2556()
{
	self endon("killanimscript");
	self endon("end_shoot_while_driving");
	self.var_1491.var_1096D = ::func_2570;
	func_2557();
	self.var_FE91 = undefined;
}

//Function Number: 12
func_2557()
{
	self endon("atv_event_occurred");
	scripts\anim\shoot_behavior::func_4F69("normal");
}

//Function Number: 13
func_2570()
{
	if(!isdefined(self.var_10C))
	{
		self.var_FE9E = undefined;
		self.var_FECF = undefined;
		self.var_FED7 = "none";
		return;
	}

	self.var_FE9E = self.var_10C;
	self.var_FECF = self.var_10C method_815B();
	var_00 = distancesquared(self.origin,self.var_10C.origin);
	if(var_00 < 1000000)
	{
		self.var_FED7 = "full";
	}
	else if(var_00 < 4000000)
	{
		self.var_FED7 = "burst";
	}
	else
	{
		self.var_FED7 = "single";
	}

	if(isdefined(self.var_10C.var_131A0))
	{
		var_01 = 0.5;
		var_02 = self.var_FE9E.var_131A0;
		var_03 = self.var_E500;
		var_04 = var_03.origin - var_02.origin;
		var_05 = anglestoforward(var_02.angles);
		var_06 = anglestoright(var_02.angles);
		var_07 = vectordot(var_04,var_05);
		if(var_07 < 0)
		{
			var_08 = var_02 method_83DD() * var_01;
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

				self.var_FE9E = undefined;
				self.var_FECF = var_02.origin + var_08 * var_05 + var_09 * var_06;
				return;
			}
		}
	}
}

//Function Number: 14
func_2566()
{
	self endon("killanimscript");
	self endon("end_shoot_while_driving");
	self notify("doing_shootWhileDriving");
	self endon("doing_shootWhileDriving");
	for(;;)
	{
		if(!self.var_3250)
		{
			wait(0.5);
			continue;
		}

		scripts\anim\combat_utility::func_FEDF();
	}
}

//Function Number: 15
func_2560()
{
	if(!self.var_E500.var_10F83)
	{
		return 0;
	}

	if(!scripts\anim\utility_common::func_BE9E(0))
	{
		return 0;
	}

	if(!scripts\anim\utility_common::func_1311A())
	{
		return 0;
	}

	func_2561();
	self notify("abort_reload");
	return 1;
}

//Function Number: 16
func_2561()
{
	self endon("atv_event_occurred");
	self.var_10FB2 = 1;
	self waittill("start_blending_reload");
	self method_82A2(%atv_aiming,0,0.25);
	self method_82EA("gun_down",scripts\anim\utility::func_1F64("gun_down"),1,0.25);
	scripts\anim\shared::func_592B("gun_down");
	self method_806F(scripts\anim\utility::func_1F64("gun_down"),0);
	self method_82E4("reload_anim",scripts\anim\utility::func_1F64("reload"),%body,1,0.25);
	scripts\anim\shared::func_592B("reload_anim");
	self method_806F(%atv_reload,0.2);
	self method_82EA("gun_up",scripts\anim\utility::func_1F64("gun_up"),1,0.25);
	self.var_86EC = 1;
	scripts\anim\shared::func_592B("gun_up",::func_256E);
	self.var_10FB2 = undefined;
	self method_806F(%atv_reload,0.1);
	self method_82A2(%atv_aiming,1,0.1);
	if(isdefined(self.var_86EC))
	{
		self.var_86EC = undefined;
		scripts\anim\shared::func_592B("gun_up",::func_256D);
		self method_806F(scripts\anim\utility::func_1F64("gun_up"),0);
	}
}

//Function Number: 17
func_256E(param_00)
{
	if(param_00 == "start_aim")
	{
		return 1;
	}
}

//Function Number: 18
func_256D(param_00)
{
	if(param_00 == "end")
	{
		return 1;
	}
}

//Function Number: 19
func_256F(param_00)
{
	if(param_00 == "start_lean")
	{
		return 1;
	}
}

//Function Number: 20
func_256A()
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
		scripts\anim\track::func_93E2();
		var_05 = (self.origin[0],self.origin[1],self geteye()[2]);
		var_06 = self.var_FECF;
		if(isdefined(self.var_FE9E))
		{
			var_06 = self.var_FE9E method_815B();
		}

		if(!isdefined(var_06))
		{
			var_03 = 0;
			var_07 = self method_80FC();
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

		if(var_03 < self.var_268 || var_03 > self.var_1B7)
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
				var_03 = var_02 + var_01 * scripts\common\utility::func_101EA(var_0A);
			}
		}

		var_02 = var_03;
		var_0B = min(max(0 - var_03,0),90) / 90 * self.var_1491.var_1A4B;
		var_0C = min(max(var_03,0),90) / 90 * self.var_1491.var_1A4B;
		self method_82AC(%atv_aim_4,var_0B,var_00);
		self method_82AC(%atv_aim_6,var_0C,var_00);
		wait(0.05);
	}
}

//Function Number: 21
func_2559(param_00,param_01,param_02)
{
	var_03 = undefined;
	var_04 = undefined;
	var_05 = 0;
	for(var_06 = 0;var_06 < param_00.size;var_06++)
	{
		var_07 = scripts\common\utility::func_152F(param_02 - param_01[var_06]);
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
	if(isdefined(level.var_D893) && var_08 == level.var_D893 && gettime() - level.var_D894 < 500)
	{
		var_08 = var_04;
	}

	anim.var_D893 = var_08;
	anim.var_D894 = gettime();
	return var_08;
}

//Function Number: 22
func_2555()
{
	var_00 = self.var_E500;
	var_01 = var_00.var_D89A;
	var_01 = (var_01[0],var_01[1],randomfloatrange(200,400)) * 0.75;
	if(lengthsquared(var_01) > 1000000)
	{
		var_01 = vectornormalize(var_01) * 1000;
	}

	var_02 = spawn("script_origin",self.origin);
	var_02 method_820E((0,0,40),15,var_01);
	self linkto(var_02);
	var_02 thread func_51D1();
}

//Function Number: 23
func_255F()
{
	var_00 = [];
	var_00[0] = level.var_EC85["atv"]["small"]["death"]["back"];
	var_00[1] = level.var_EC85["atv"]["small"]["death"]["right"];
	var_00[2] = level.var_EC85["atv"]["small"]["death"]["left"];
	var_01 = [];
	var_01[0] = -180;
	var_01[1] = -90;
	var_01[2] = 90;
	var_02 = func_2559(var_00,var_01,self.var_E3);
	scripts\anim\death::func_CF0E(var_02);
	return 1;
}

//Function Number: 24
func_2554()
{
	var_00 = self.var_E500;
	if(!isdefined(var_00))
	{
		return func_255F();
	}

	var_01 = var_00.var_D89A;
	func_2555();
	var_02 = vectortoangles(var_01);
	var_03 = angleclamp180(var_02[1] - self.angles[1]);
	var_04 = [];
	var_04[0] = level.var_EC85["atv"]["big"]["death"]["back"];
	var_04[1] = level.var_EC85["atv"]["big"]["death"]["left"];
	var_04[2] = level.var_EC85["atv"]["big"]["death"]["front"];
	var_04[3] = level.var_EC85["atv"]["big"]["death"]["right"];
	var_05 = [];
	var_05[0] = -180;
	var_05[1] = -90;
	var_05[2] = 0;
	var_05[3] = 90;
	var_06 = func_2559(var_04,var_05,var_03);
	scripts\anim\death::func_CF0E(var_06);
	return 1;
}

//Function Number: 25
func_51D1()
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

//Function Number: 26
func_2564(param_00)
{
	self.var_1491.var_2274["idle"] = level.var_EC85["atv"][param_00]["idle"];
	self.var_1491.var_2274["drive"] = level.var_EC85["atv"][param_00]["drive"];
	self.var_1491.var_2274["fire"] = level.var_EC85["atv"][param_00]["fire"];
	self.var_1491.var_2274["single"] = scripts\anim\utility::func_2274(level.var_EC85["atv"][param_00]["single"]);
	self.var_1491.var_2274["burst2"] = level.var_EC85["atv"][param_00]["fire"];
	self.var_1491.var_2274["burst3"] = level.var_EC85["atv"][param_00]["fire"];
	self.var_1491.var_2274["burst4"] = level.var_EC85["atv"][param_00]["fire"];
	self.var_1491.var_2274["burst5"] = level.var_EC85["atv"][param_00]["fire"];
	self.var_1491.var_2274["burst6"] = level.var_EC85["atv"][param_00]["fire"];
	self.var_1491.var_2274["semi2"] = level.var_EC85["atv"][param_00]["fire"];
	self.var_1491.var_2274["semi3"] = level.var_EC85["atv"][param_00]["fire"];
	self.var_1491.var_2274["semi4"] = level.var_EC85["atv"][param_00]["fire"];
	self.var_1491.var_2274["semi5"] = level.var_EC85["atv"][param_00]["fire"];
}

//Function Number: 27
func_2565(param_00)
{
	self.var_1491.var_2274 = [];
	func_2564("driver");
	self.var_1491.var_2274["left2right"] = level.var_EC85["atv"]["driver"]["left2right"];
	self.var_1491.var_2274["right2left"] = level.var_EC85["atv"]["driver"]["right2left"];
	self.var_1491.var_2274["straight_level_left"] = level.var_EC85["atv"]["driver"]["straight_level"]["left"];
	self.var_1491.var_2274["straight_level_center"] = level.var_EC85["atv"]["driver"]["straight_level"]["center"];
	self.var_1491.var_2274["straight_level_right"] = level.var_EC85["atv"]["driver"]["straight_level"]["right"];
	self.var_1491.var_2274["add_aim_left_left"] = level.var_EC85["atv"]["driver"]["add_aim_left"]["left"];
	self.var_1491.var_2274["add_aim_left_center"] = level.var_EC85["atv"]["driver"]["add_aim_left"]["center"];
	self.var_1491.var_2274["add_aim_left_right"] = level.var_EC85["atv"]["driver"]["add_aim_left"]["right"];
	self.var_1491.var_2274["add_aim_right_left"] = level.var_EC85["atv"]["driver"]["add_aim_right"]["left"];
	self.var_1491.var_2274["add_aim_right_center"] = level.var_EC85["atv"]["driver"]["add_aim_right"]["center"];
	self.var_1491.var_2274["add_aim_right_right"] = level.var_EC85["atv"]["driver"]["add_aim_right"]["right"];
	if(param_00)
	{
		self.var_1491.var_2274["event_jump"] = level.var_EC85["atv"]["driver"]["shoot_jump"];
		self.var_1491.var_2274["event_bump"] = level.var_EC85["atv"]["driver"]["shoot_bump"];
		self.var_1491.var_2274["event_bump_big"] = level.var_EC85["atv"]["driver"]["shoot_bump_big"];
		self.var_1491.var_2274["event_sway"] = [];
		self.var_1491.var_2274["event_sway"]["left"] = level.var_EC85["atv"]["driver"]["shoot_sway_left"];
		self.var_1491.var_2274["event_sway"]["right"] = level.var_EC85["atv"]["driver"]["shoot_sway_right"];
		self.var_1491.var_2274["event_restore"] = %atv_aiming;
		return;
	}

	self.var_1491.var_2274["event_jump"] = level.var_EC85["atv"]["driver"]["drive_jump"];
	self.var_1491.var_2274["event_bump"] = level.var_EC85["atv"]["driver"]["drive_bump"];
	self.var_1491.var_2274["event_bump_big"] = level.var_EC85["atv"]["driver"]["drive_bump_big"];
	self.var_1491.var_2274["event_sway"] = [];
	self.var_1491.var_2274["event_sway"]["left"] = level.var_EC85["atv"]["driver"]["drive_sway_left"];
	self.var_1491.var_2274["event_sway"]["right"] = level.var_EC85["atv"]["driver"]["drive_sway_right"];
	self.var_1491.var_2274["event_restore"] = %atv_turn;
}