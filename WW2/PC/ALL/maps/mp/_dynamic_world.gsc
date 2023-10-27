/*******************************************************************
 * Decompiled By: Bog
 * Decompiled File: maps\mp\_dynamic_world.gsc
 * Game: Call of Duty: WWII
 * Platform: PC
 * Function Count: 73
 * Decompile Time: 1243 ms
 * Timestamp: 10/27/2023 3:21:14 AM
*******************************************************************/

//Function Number: 1
func_00D5()
{
	common_scripts\utility::func_FB2(getentarray("com_wall_fan_blade_rotate_slow","targetname"),::func_3A1E,"veryslow");
	common_scripts\utility::func_FB2(getentarray("com_wall_fan_blade_rotate","targetname"),::func_3A1E,"slow");
	common_scripts\utility::func_FB2(getentarray("com_wall_fan_blade_rotate_fast","targetname"),::func_3A1E,"fast");
	var_00 = [];
	var_00["trigger_multiple_dyn_metal_detector"] = ::func_6121;
	var_00["trigger_multiple_dyn_creaky_board"] = ::func_2776;
	var_00["trigger_multiple_dyn_photo_copier"] = ::func_6F8C;
	var_00["trigger_multiple_dyn_copier_no_light"] = ::func_6F90;
	var_00["trigger_radius_motion_light"] = ::func_6462;
	var_00["trigger_radius_dyn_motion_dlight"] = ::func_6C69;
	var_00["trigger_multiple_dyn_dog_bark"] = ::func_3198;
	var_00["trigger_radius_bird_startle"] = ::func_1762;
	var_00["trigger_multiple_dyn_motion_light"] = ::func_6462;
	var_00["trigger_multiple_dyn_door"] = ::func_9D70;
	func_72B0();
	foreach(var_04, var_02 in var_00)
	{
		var_03 = getentarray(var_04,"classname");
		common_scripts\utility::func_FB2(var_03,::func_9DC3);
		common_scripts\utility::func_FB2(var_03,var_02);
	}

	common_scripts\utility::func_FB2(getentarray("vending_machine","targetname"),::func_A403);
	common_scripts\utility::func_FB2(getentarray("toggle","targetname"),::func_A1F6);
	common_scripts\utility::func_FB2(getentarray("sliding_door","targetname"),::func_8CA1);
	level thread func_6B6C();
	var_05 = getent("civilian_jet_origin","targetname");
	if(isdefined(var_05))
	{
		var_05 thread func_2301();
	}

	thread func_5409();
}

//Function Number: 2
func_6B6C()
{
	for(;;)
	{
		level waittill("connecting",var_00);
		var_00 thread func_64B5();
	}
}

//Function Number: 3
func_72B0()
{
	if(common_scripts\utility::func_57D7())
	{
		foreach(var_01 in level.var_744A)
		{
			var_01.var_9AC5 = [];
			var_01 thread func_64B5();
		}
	}
}

//Function Number: 4
func_0AAB()
{
	self.var_9AC5 = [];
	thread func_64B5();
}

//Function Number: 5
func_2301()
{
	level endon("game_ended");
	func_5963();
	level waittill("prematch_over");
	for(;;)
	{
		thread func_5967();
		self waittill("start_flyby");
		thread func_5961();
		self waittill("flyby_done");
		func_5966();
	}
}

//Function Number: 6
func_5963()
{
	self.var_5964 = getentarray(self.var_1A2,"targetname");
	self.var_5962 = getent("civilian_jet_flyto","targetname");
	self.var_3776 = getentarray("engine_fx","targetname");
	self.var_3D3F = getentarray("flash_fx","targetname");
	self.var_595B = loadfx("vfx/test/test_fx");
	self.var_595E = loadfx("vfx/lights/aircraft_light_wingtip_red");
	self.var_595D = loadfx("vfx/lights/aircraft_light_wingtip_green");
	self.var_595C = loadfx("vfx/lights/aircraft_light_red_blink");
	level.var_2304 = undefined;
	var_00 = vectornormalize(self.var_116 - self.var_5962.var_116) * 20000;
	self.var_5962.var_116 = self.var_5962.var_116 - var_00;
	self.var_116 = self.var_116 + var_00;
	foreach(var_02 in self.var_5964)
	{
		var_02.var_116 = var_02.var_116 + var_00;
		var_02.var_6A43 = var_02.var_116;
		var_02 method_805C();
	}

	foreach(var_05 in self.var_3776)
	{
		var_05.var_116 = var_05.var_116 + var_00;
	}

	foreach(var_08 in self.var_3D3F)
	{
		var_08.var_116 = var_08.var_116 + var_00;
	}

	var_0A = self.var_116;
	var_0B = self.var_5962.var_116;
	self.var_5960 = var_0B - var_0A;
	var_0C = 2000;
	var_0D = abs(distance(var_0A,var_0B));
	self.var_595F = var_0D / var_0C;
}

//Function Number: 7
func_5966()
{
	foreach(var_01 in self.var_5964)
	{
		var_01.var_116 = var_01.var_6A43;
		var_01 method_805C();
	}
}

//Function Number: 8
func_5967()
{
	level endon("game_ended");
	var_00 = func_46E1();
	var_01 = max(10,var_00);
	var_01 = min(var_01,100);
	if(getdvar("jet_flyby_timer") != "")
	{
		level.var_2305 = 5 + getdvarint("jet_flyby_timer");
	}
	else
	{
		level.var_2305 = 0.25 + randomfloatrange(0.3,0.7) * 60 * var_01;
	}

	wait(level.var_2305);
	while(isdefined(level.var_B97) || isdefined(level.var_84B) || isdefined(level.var_2210) || isdefined(level.var_7C66))
	{
		wait 0.05;
	}

	self notify("start_flyby");
	level.var_2304 = 1;
	self waittill("flyby_done");
	level.var_2304 = undefined;
}

//Function Number: 9
func_46E1()
{
	if(common_scripts\utility::func_57D7())
	{
		return 10;
	}

	if(isdefined(game["status"]) && game["status"] == "overtime")
	{
		return 1;
	}

	return func_471A("timelimit");
}

//Function Number: 10
func_471A(param_00)
{
	param_00 = "scr_" + level.var_3FDC + "_" + param_00;
	if(isdefined(level.var_6CC8) && isdefined(level.var_6CC8[param_00]))
	{
		return level.var_6CC8[param_00];
	}

	return level.var_A901[param_00].var_A281;
}

//Function Number: 11
func_5961()
{
	foreach(var_01 in self.var_5964)
	{
		var_01 method_805B();
	}

	var_03 = [];
	var_04 = [];
	foreach(var_06 in self.var_3776)
	{
		var_07 = spawn("script_model",var_06.var_116);
		var_07 setmodel("tag_origin");
		var_07.var_1D = var_06.var_1D;
		var_03[var_03.size] = var_07;
	}

	foreach(var_0A in self.var_3D3F)
	{
		var_0B = spawn("script_model",var_0A.var_116);
		var_0B setmodel("tag_origin");
		var_0B.var_56 = var_0A.var_165;
		var_0B.var_1D = var_0A.var_1D;
		var_04[var_04.size] = var_0B;
	}

	thread func_5965(self.var_5964[0],level.var_5FEB);
	wait 0.05;
	foreach(var_07 in var_03)
	{
		playfxontag(self.var_595B,var_07,"tag_origin");
	}

	foreach(var_0B in var_04)
	{
		if(isdefined(var_0B.var_56) && var_0B.var_56 == "blink")
		{
			playfxontag(self.var_595C,var_0B,"tag_origin");
			continue;
		}

		if(isdefined(var_0B.var_56) && var_0B.var_56 == "red")
		{
			playfxontag(self.var_595E,var_0B,"tag_origin");
			continue;
		}

		playfxontag(self.var_595D,var_0B,"tag_origin");
	}

	foreach(var_01 in self.var_5964)
	{
		var_01 moveto(var_01.var_116 + self.var_5960,self.var_595F);
	}

	foreach(var_07 in var_03)
	{
		var_07 moveto(var_07.var_116 + self.var_5960,self.var_595F);
	}

	foreach(var_0B in var_04)
	{
		var_0B moveto(var_0B.var_116 + self.var_5960,self.var_595F);
	}

	wait(self.var_595F + 1);
	foreach(var_07 in var_03)
	{
		var_07 delete();
	}

	foreach(var_0B in var_04)
	{
		var_0B delete();
	}

	self notify("flyby_done");
}

//Function Number: 12
func_5965(param_00,param_01)
{
	param_00 thread func_74D6("veh_mig29_dist_loop");
	while(!func_982B(param_00,param_01))
	{
		wait 0.05;
	}

	param_00 thread func_74D6("veh_mig29_close_loop");
	while(func_982C(param_00,param_01))
	{
		wait 0.05;
	}

	wait(0.5);
	param_00 thread func_74D5("veh_mig29_sonic_boom");
	while(func_982B(param_00,param_01))
	{
		wait 0.05;
	}

	param_00 notify("stop soundveh_mig29_close_loop");
	self waittill("flyby_done");
	param_00 notify("stop soundveh_mig29_dist_loop");
}

//Function Number: 13
func_74D5(param_00,param_01,param_02)
{
	var_03 = spawn("script_origin",(0,0,1));
	var_03 method_805C();
	if(!isdefined(param_01))
	{
		param_01 = self.var_116;
	}

	var_03.var_116 = param_01;
	if(isdefined(param_02) && param_02)
	{
		var_03 method_861C(param_00);
	}
	else
	{
		var_03 method_8617(param_00);
	}

	wait(10);
	var_03 delete();
}

//Function Number: 14
func_74D6(param_00,param_01)
{
	var_02 = spawn("script_origin",(0,0,0));
	var_02 method_805C();
	var_02 endon("death");
	thread common_scripts\utility::func_2D18(var_02);
	if(isdefined(param_01))
	{
		var_02.var_116 = self.var_116 + param_01;
		var_02.var_1D = self.var_1D;
		var_02 linkto(self);
	}
	else
	{
		var_02.var_116 = self.var_116;
		var_02.var_1D = self.var_1D;
		var_02 linkto(self);
	}

	var_02 method_861D(param_00);
	self waittill("stop sound" + param_00);
	var_02 stoploopsound(param_00);
	var_02 delete();
}

//Function Number: 15
func_982C(param_00,param_01)
{
	var_02 = anglestoforward(common_scripts\utility::func_3D5C(param_00.var_1D));
	var_03 = vectornormalize(common_scripts\utility::func_3D5D(param_01) - param_00.var_116);
	var_04 = vectordot(var_02,var_03);
	if(var_04 > 0)
	{
		return 1;
	}

	return 0;
}

//Function Number: 16
func_982B(param_00,param_01)
{
	var_02 = func_982C(param_00,param_01);
	if(var_02)
	{
		var_03 = 1;
	}
	else
	{
		var_03 = -1;
	}

	var_04 = common_scripts\utility::func_3D5D(param_00.var_116);
	var_05 = var_04 + anglestoforward(common_scripts\utility::func_3D5C(param_00.var_1D)) * var_03 * 100000;
	var_06 = pointonsegmentnearesttopoint(var_04,var_05,param_01);
	var_07 = distance(var_04,var_06);
	if(var_07 < 3000)
	{
		return 1;
	}

	return 0;
}

//Function Number: 17
func_A403()
{
	level endon("game_ended");
	self endon("death");
	self setcursorhint("HINT_ACTIVATE");
	self.var_A5B1 = getent(self.var_1A2,"targetname");
	var_00 = getent(self.var_A5B1.var_1A2,"targetname");
	var_01 = getent(var_00.var_1A2,"targetname");
	var_02 = getent(var_01.var_1A2,"targetname");
	self.var_A5AC = var_02.var_116;
	var_03 = getent(var_02.var_1A2,"targetname");
	self.var_A5AD = var_03.var_116;
	if(isdefined(var_03.var_1A2))
	{
		self.var_A5A7 = getent(var_03.var_1A2,"targetname").var_116;
	}

	self.var_A5B1 setcandamage(1);
	self.var_A5B2 = self.var_A5B1.var_106;
	self.var_A5A5 = self.var_A5B1.var_165;
	self.var_A5C0 = var_00.var_106;
	self.var_A5C2 = var_00.var_116;
	self.var_A5C1 = var_00.var_1D;
	self.var_A5C4 = var_01.var_116;
	self.var_A5C3 = var_01.var_1D;
	precachemodel(self.var_A5A5);
	var_00 delete();
	var_01 delete();
	var_02 delete();
	var_03 delete();
	self.var_8ED8 = [];
	self.var_8EDB = 12;
	self.var_8EDC = undefined;
	self.var_4F00 = 400;
	thread func_A404(self.var_A5B1);
	self method_861D("vending_machine_hum");
	for(;;)
	{
		self waittill("trigger",var_04);
		self method_8617("vending_machine_button_press");
		if(!self.var_8EDB)
		{
			continue;
		}

		if(isdefined(self.var_8EDC))
		{
			func_8EDA();
		}

		func_8ED9(func_8FF4());
		wait 0.05;
	}
}

//Function Number: 18
func_A404(param_00)
{
	level endon("game_ended");
	var_01 = "mod_grenade mod_projectile mod_explosive mod_grenade_splash mod_projectile_splash splash";
	var_02 = loadfx("vfx/test/test_fx");
	for(;;)
	{
		var_03 = undefined;
		var_04 = undefined;
		var_05 = undefined;
		var_06 = undefined;
		var_07 = undefined;
		param_00 waittill("damage",var_03,var_04,var_05,var_06,var_07);
		if(isdefined(var_07))
		{
			if(issubstr(var_01,tolower(var_07)))
			{
				var_03 = var_03 * 3;
			}

			self.var_4F00 = self.var_4F00 - var_03;
			if(self.var_4F00 > 0)
			{
				continue;
			}

			self notify("death");
			self.var_116 = self.var_116 + (0,0,10000);
			if(!isdefined(self.var_A5A7))
			{
				var_08 = self.var_A5B1.var_116 + (37,-31,52);
			}
			else
			{
				var_08 = self.var_A5A7;
			}

			playfx(var_02,var_08);
			self.var_A5B1 setmodel(self.var_A5A5);
			while(self.var_8EDB > 0)
			{
				if(isdefined(self.var_8EDC))
				{
					func_8EDA();
				}

				func_8ED9(func_8FF4());
				wait 0.05;
			}

			self stoploopsound("vending_machine_hum");
			return;
		}
	}
}

//Function Number: 19
func_8FF4()
{
	var_00 = spawn("script_model",self.var_A5C2);
	var_00 setmodel(self.var_A5C0);
	var_00.var_116 = self.var_A5C2;
	var_00.var_1D = self.var_A5C1;
	return var_00;
}

//Function Number: 20
func_8ED9(param_00)
{
	param_00 moveto(self.var_A5C4,0.2);
	param_00 method_8617("vending_machine_soda_drop");
	wait(0.2);
	self.var_8EDC = param_00;
	self.var_8EDB--;
}

//Function Number: 21
func_8EDA()
{
	self endon("death");
	if(isdefined(self.var_8EDC.var_35AB) && self.var_8EDC.var_35AB == 1)
	{
		return;
	}

	var_00 = 1;
	var_01 = var_00 * -999;
	var_02 = int(-25536);
	var_03 = (int(var_02 / 2),int(var_02 / 2),0) - (randomint(var_02),randomint(var_02),0);
	var_04 = vectornormalize(self.var_A5AD - self.var_A5AC + var_03);
	var_05 = var_04 * randomfloatrange(var_01,var_00);
	self.var_8EDC method_82C5(self.var_A5AC,var_05);
	self.var_8EDC.var_35AB = 1;
}

//Function Number: 22
func_3E88()
{
	level endon("game_ended");
	var_00 = "briefcase_bomb_mp";
	for(;;)
	{
		self waittill("trigger_enter",var_01);
		if(!var_01 hasweapon(var_00))
		{
			var_01 method_8617("freefall_death");
			var_01 maps\mp\_utility::func_642(var_00);
			var_01 setweaponammostock(var_00,0);
			var_01 method_82FA(var_00,0);
			var_01 switchtoweapon(var_00);
		}
	}
}

//Function Number: 23
func_6121()
{
	level endon("game_ended");
	var_00 = getent(self.var_1A2,"targetname");
	var_00 method_81AE();
	var_01 = getent(var_00.var_1A2,"targetname");
	var_02 = getent(var_01.var_1A2,"targetname");
	var_03 = getent(var_02.var_1A2,"targetname");
	var_04 = getent(var_03.var_1A2,"targetname");
	var_05 = [];
	var_06 = min(var_01.var_116[0],var_02.var_116[0]);
	var_05[0] = var_06;
	var_07 = max(var_01.var_116[0],var_02.var_116[0]);
	var_05[1] = var_07;
	var_08 = min(var_01.var_116[1],var_02.var_116[1]);
	var_05[2] = var_08;
	var_09 = max(var_01.var_116[1],var_02.var_116[1]);
	var_05[3] = var_09;
	var_0A = min(var_01.var_116[2],var_02.var_116[2]);
	var_05[4] = var_0A;
	var_0B = max(var_01.var_116[2],var_02.var_116[2]);
	var_05[5] = var_0B;
	var_01 delete();
	var_02 delete();
	if(!common_scripts\utility::func_57D7())
	{
		self.var_BAB = 7;
	}
	else
	{
		self.var_BAB = 2;
	}

	self.var_BAC = 0;
	self.var_BAA = 0;
	self.var_9A89 = 0;
	thread func_6122(var_00);
	thread func_6123();
	thread func_6124(var_05,"weapon_claymore","weapon_c4");
	var_0C = (var_03.var_116[0],var_03.var_116[1],var_0B);
	var_0D = (var_04.var_116[0],var_04.var_116[1],var_0B);
	var_0E = loadfx("vfx/test/test_fx");
	for(;;)
	{
		common_scripts\utility::knock_off_battery("dmg_triggered","touch_triggered","weapon_triggered");
		thread func_74D4("alarm_metal_detector",var_0E,var_0C,var_0D);
	}
}

//Function Number: 24
func_74D4(param_00,param_01,param_02,param_03)
{
	level endon("game_ended");
	if(!self.var_BAC)
	{
		self.var_BAC = 1;
		thread func_0F06();
		if(!self.var_BAA)
		{
			self method_8617(param_00);
		}

		playfx(param_01,param_02);
		playfx(param_01,param_03);
		wait(self.var_BAB);
		self.var_BAC = 0;
	}
}

//Function Number: 25
func_0F06()
{
	level endon("game_ended");
	if(!self.var_9A89)
	{
		return;
	}

	var_00 = self.var_BAB + 0.15;
	if(self.var_9A89)
	{
		self.var_9A89--;
	}
	else
	{
		self.var_BAA = 1;
	}

	var_01 = gettime();
	var_02 = 7;
	if(common_scripts\utility::func_57D7())
	{
		var_02 = 2;
	}

	func_A714("dmg_triggered","touch_triggered","weapon_triggered",var_02 + 2);
	var_03 = gettime() - var_01;
	if(var_03 > var_02 * 1000 + 1150)
	{
		self.var_BAA = 0;
		self.var_9A89 = 0;
	}
}

//Function Number: 26
func_A714(param_00,param_01,param_02,param_03)
{
	level endon("game_ended");
	self endon(param_00);
	self endon(param_01);
	self endon(param_02);
	wait(param_03);
}

//Function Number: 27
func_6124(param_00,param_01,param_02)
{
	level endon("game_ended");
	for(;;)
	{
		func_A773();
		var_03 = getentarray("grenade","classname");
		foreach(var_05 in var_03)
		{
			if(isdefined(var_05.var_106) && var_05.var_106 == param_01 || var_05.var_106 == param_02)
			{
				if(func_5719(var_05,param_00))
				{
					thread func_A9AE(var_05,param_00);
				}
			}
		}
	}
}

//Function Number: 28
func_A773()
{
	level endon("game_ended");
	self endon("dmg_triggered");
	self waittill("touch_triggered");
}

//Function Number: 29
func_A9AE(param_00,param_01)
{
	param_00 endon("death");
	while(func_5719(param_00,param_01))
	{
		self notify("weapon_triggered");
		wait(self.var_BAB);
	}
}

//Function Number: 30
func_5719(param_00,param_01)
{
	var_02 = param_01[0];
	var_03 = param_01[1];
	var_04 = param_01[2];
	var_05 = param_01[3];
	var_06 = param_01[4];
	var_07 = param_01[5];
	var_08 = param_00.var_116[0];
	var_09 = param_00.var_116[1];
	var_0A = param_00.var_116[2];
	if(func_571A(var_08,var_02,var_03))
	{
		if(func_571A(var_09,var_04,var_05))
		{
			if(func_571A(var_0A,var_06,var_07))
			{
				return 1;
			}
		}
	}

	return 0;
}

//Function Number: 31
func_571A(param_00,param_01,param_02)
{
	if(param_00 > param_01 && param_00 < param_02)
	{
		return 1;
	}

	return 0;
}

//Function Number: 32
func_6122(param_00)
{
	level endon("game_ended");
	for(;;)
	{
		param_00 waittill("damage",var_01,var_02,var_03,var_04,var_05);
		if(isdefined(var_05) && func_0BAD(var_05))
		{
			self notify("dmg_triggered");
		}
	}
}

//Function Number: 33
func_6123()
{
	level endon("game_ended");
	for(;;)
	{
		self waittill("trigger_enter");
		while(func_0F13(self))
		{
			self notify("touch_triggered");
			wait(self.var_BAB);
		}
	}
}

//Function Number: 34
func_0BAD(param_00)
{
	var_01 = "mod_melee melee mod_grenade mod_projectile mod_explosive mod_impact";
	var_02 = strtok(var_01," ");
	foreach(var_04 in var_02)
	{
		if(tolower(var_04) == tolower(param_00))
		{
			return 1;
		}
	}

	return 0;
}

//Function Number: 35
func_2776()
{
	level endon("game_ended");
	for(;;)
	{
		self waittill("trigger_enter",var_00);
		var_00 thread func_30A4(self);
	}
}

//Function Number: 36
func_30A4(param_00)
{
	self endon("disconnect");
	self endon("death");
	self method_8617("step_walk_plr_woodcreak_on");
	for(;;)
	{
		self waittill("trigger_leave",var_01);
		if(param_00 != var_01)
		{
			continue;
		}

		self method_8617("step_walk_plr_woodcreak_off");
	}
}

//Function Number: 37
func_6462()
{
	level endon("game_ended");
	self.var_64DD = 1;
	self.var_5D7C = 0;
	var_00 = getentarray(self.var_1A2,"targetname");
	common_scripts\utility::func_6753(["com_two_light_fixture_off","com_two_light_fixture_on"],::precachemodel);
	foreach(var_02 in var_00)
	{
		var_02.var_5D71 = [];
		var_03 = getent(var_02.var_1A2,"targetname");
		if(!isdefined(var_03.var_1A2))
		{
			continue;
		}

		var_02.var_5D71 = getentarray(var_03.var_1A2,"targetname");
	}

	for(;;)
	{
		self waittill("trigger_enter");
		while(func_0F13(self))
		{
			var_05 = 0;
			foreach(var_07 in self.var_9AC3)
			{
				if(isdefined(var_07.var_3040) && var_07.var_3040 > 5)
				{
					var_05 = 1;
				}
			}

			if(var_05)
			{
				if(!self.var_5D7C)
				{
					self.var_5D7C = 1;
					var_00[0] method_8617("switch_auto_lights_on");
					foreach(var_02 in var_00)
					{
						var_02 method_81DF(1);
						if(isdefined(var_02.var_5D71))
						{
							foreach(var_0B in var_02.var_5D71)
							{
								var_0B setmodel("com_two_light_fixture_on");
							}
						}
					}
				}

				thread func_6463(var_00,10);
			}

			wait 0.05;
		}
	}
}

//Function Number: 38
func_6463(param_00,param_01)
{
	self notify("motion_light_timeout");
	self endon("motion_light_timeout");
	wait(param_01);
	foreach(var_03 in param_00)
	{
		var_03 method_81DF(0);
		if(isdefined(var_03.var_5D71))
		{
			foreach(var_05 in var_03.var_5D71)
			{
				var_05 setmodel("com_two_light_fixture_off");
			}
		}
	}

	param_00[0] method_8617("switch_auto_lights_off");
	self.var_5D7C = 0;
}

//Function Number: 39
func_6C69()
{
	if(!isdefined(level.var_6C6B))
	{
		level.var_6C6B = loadfx("vfx/lights/outdoor_motion_light");
	}

	level endon("game_ended");
	self.var_64DD = 1;
	self.var_5D7C = 0;
	var_00 = getent(self.var_1A2,"targetname");
	var_01 = getentarray(var_00.var_1A2,"targetname");
	common_scripts\utility::func_6753(["com_two_light_fixture_off","com_two_light_fixture_on"],::precachemodel);
	for(;;)
	{
		self waittill("trigger_enter");
		while(func_0F13(self))
		{
			var_02 = 0;
			foreach(var_04 in self.var_9AC3)
			{
				if(isdefined(var_04.var_3040) && var_04.var_3040 > 5)
				{
					var_02 = 1;
				}
			}

			if(var_02)
			{
				if(!self.var_5D7C)
				{
					self.var_5D7C = 1;
					var_00 method_8617("switch_auto_lights_on");
					var_00 setmodel("com_two_light_fixture_on");
					foreach(var_07 in var_01)
					{
						var_07.var_5D2F = spawn("script_model",var_07.var_116);
						var_07.var_5D2F setmodel("tag_origin");
						playfxontag(level.var_6C6B,var_07.var_5D2F,"tag_origin");
					}
				}

				thread func_6C6A(var_00,var_01,10);
			}

			wait 0.05;
		}
	}
}

//Function Number: 40
func_6C6A(param_00,param_01,param_02)
{
	self notify("motion_light_timeout");
	self endon("motion_light_timeout");
	wait(param_02);
	foreach(var_04 in param_01)
	{
		var_04.var_5D2F delete();
	}

	param_00 method_8617("switch_auto_lights_off");
	param_00 setmodel("com_two_light_fixture_off");
	self.var_5D7C = 0;
}

//Function Number: 41
func_3198()
{
	level endon("game_ended");
	self.var_64DD = 1;
	var_00 = getent(self.var_1A2,"targetname");
	for(;;)
	{
		self waittill("trigger_enter",var_01);
		while(func_0F13(self))
		{
			var_02 = 0;
			foreach(var_04 in self.var_9AC3)
			{
				if(isdefined(var_04.var_3040) && var_04.var_3040 > var_02)
				{
					var_02 = var_04.var_3040;
				}
			}

			if(var_02 > 6)
			{
				var_00 method_8617("dyn_anml_dog_bark");
				wait(randomfloatrange(16 / var_02,16 / var_02 + randomfloat(1)));
				continue;
			}

			wait 0.05;
		}
	}
}

//Function Number: 42
func_9D70()
{
	var_00 = getent(self.var_1A2,"targetname");
	self.var_3288 = var_00;
	self.var_3282 = func_4710(vectornormalize(self getorigin() - var_00 getorigin()));
	var_00.var_1631 = var_00.var_1D[1];
	var_01 = 1;
	for(;;)
	{
		self waittill("trigger_enter",var_02);
		var_00 thread func_328D(var_01,func_44A7(var_02));
		if(func_0F13(self))
		{
			self waittill("trigger_empty");
		}

		wait(3);
		if(func_0F13(self))
		{
			self waittill("trigger_empty");
		}

		var_00 thread func_3285(var_01);
	}
}

//Function Number: 43
func_328D(param_00,param_01)
{
	if(param_01)
	{
		self rotateto((0,self.var_1631 + 90,1),param_00,0.1,0.75);
	}
	else
	{
		self rotateto((0,self.var_1631 - 90,1),param_00,0.1,0.75);
	}

	self method_8617("door_generic_house_open");
	wait(param_00 + 0.05);
}

//Function Number: 44
func_3285(param_00)
{
	self rotateto((0,self.var_1631,1),param_00);
	self method_8617("door_generic_house_close");
	wait(param_00 + 0.05);
}

//Function Number: 45
func_44A7(param_00)
{
	return vectordot(self.var_3282,vectornormalize(param_00.var_116 - self.var_3288 getorigin())) > 0;
}

//Function Number: 46
func_4710(param_00)
{
	return (param_00[1],0 - param_00[0],param_00[2]);
}

//Function Number: 47
func_A1F6()
{
	if(self.var_3A != "trigger_use_touch")
	{
		return;
	}

	var_00 = getentarray(self.var_1A2,"targetname");
	self.var_5D7C = 1;
	foreach(var_02 in var_00)
	{
		var_02 method_81DF(1.5 * self.var_5D7C);
	}

	for(;;)
	{
		self waittill("trigger");
		self.var_5D7C = !self.var_5D7C;
		if(self.var_5D7C)
		{
			foreach(var_02 in var_00)
			{
				var_02 method_81DF(1.5);
			}

			self method_8617("switch_auto_lights_on");
			continue;
		}

		foreach(var_02 in var_00)
		{
			var_02 method_81DF(0);
		}

		self method_8617("switch_auto_lights_off");
	}
}

//Function Number: 48
func_1762()
{
}

//Function Number: 49
func_6F8E(param_00)
{
	self.var_2660 = func_4290(param_00);
	if(isdefined(self.var_2660))
	{
		var_01 = getent(self.var_2660.var_1A2,"targetname");
		if(isdefined(var_01))
		{
			var_02 = getent(var_01.var_1A2,"targetname");
			if(isdefined(var_02))
			{
				var_02.var_D8 = var_02 method_81DE();
				var_02 method_81DF(0);
				param_00.var_2664 = var_01;
				param_00.var_9269 = var_01.var_116;
				param_00.var_5CCE = var_02;
				var_03 = self.var_2660.var_1D + (0,90,0);
				var_04 = anglestoforward(var_03);
				param_00.var_369A = param_00.var_9269 + var_04 * 30;
				return;
			}
		}
	}
}

//Function Number: 50
func_4290(param_00)
{
	if(!isdefined(param_00.var_1A2))
	{
		var_01 = getentarray("destructible_toy","targetname");
		var_02 = var_01[0];
		foreach(var_04 in var_01)
		{
			if(isdefined(var_04.var_75) && var_04.var_75 == "toy_copier")
			{
				if(distance(param_00.var_116,var_02.var_116) > distance(param_00.var_116,var_04.var_116))
				{
					var_02 = var_04;
				}
			}
		}
	}
	else
	{
		var_02 = getent(var_02.var_1A2,"targetname");
		if(isdefined(var_02))
		{
			var_02 setcandamage(1);
		}
	}

	return var_02;
}

//Function Number: 51
func_A724()
{
	if(!isdefined(self.var_2660))
	{
		return;
	}

	self.var_2660 endon("FX_State_Change0");
	self.var_2660 endon("death");
	self waittill("trigger_enter");
}

//Function Number: 52
func_6F8C()
{
	level endon("game_ended");
	func_6F8E(self);
	if(!isdefined(self.var_2660))
	{
		return;
	}

	self.var_2660 endon("FX_State_Change0");
	thread func_6F91();
	for(;;)
	{
		func_A724();
		self method_8617("mach_copier_run");
		if(isdefined(self.var_2664))
		{
			func_7D2E(self);
			thread func_6F8D();
			thread func_6F8F();
		}

		wait(3);
	}
}

//Function Number: 53
func_6F90()
{
	level endon("game_ended");
	self endon("death");
	if(common_scripts\utility::func_4381() == "hamburg")
	{
		return;
	}

	self.var_2660 = func_4290(self);
	if(!isdefined(self.var_2660))
	{
		return;
	}

	self.var_2660 endon("FX_State_Change0");
	for(;;)
	{
		func_A724();
		self method_8617("mach_copier_run");
		wait(3);
	}
}

//Function Number: 54
func_7D2E(param_00)
{
	param_00.var_2664 moveto(param_00.var_9269,0.2);
	param_00.var_5CCE method_81DF(0);
}

//Function Number: 55
func_6F8D()
{
	self.var_2660 notify("bar_goes");
	self.var_2660 endon("bar_goes");
	self.var_2660 endon("FX_State_Change0");
	self.var_2660 endon("death");
	var_00 = self.var_2664;
	wait(2);
	var_00 moveto(self.var_369A,1.6);
	wait(1.8);
	var_00 moveto(self.var_9269,1.6);
	wait(1.6);
	var_01 = self.var_5CCE;
	var_02 = 0.2;
	var_03 = var_02 / 0.05;
	for(var_04 = 0;var_04 < var_03;var_04++)
	{
		var_05 = var_04 * 0.05;
		var_05 = var_05 / var_02;
		var_05 = 1 - var_05 * var_01.var_D8;
		if(var_05 > 0)
		{
			var_01 method_81DF(var_05);
		}

		wait 0.05;
	}
}

//Function Number: 56
func_6F8F()
{
	self.var_2660 notify("light_on");
	self.var_2660 endon("light_on");
	self.var_2660 endon("FX_State_Change0");
	self.var_2660 endon("death");
	var_00 = self.var_5CCE;
	var_01 = 0.2;
	var_02 = var_01 / 0.05;
	for(var_03 = 0;var_03 < var_02;var_03++)
	{
		var_04 = var_03 * 0.05;
		var_04 = var_04 / var_01;
		var_00 method_81DF(var_04 * var_00.var_D8);
		wait 0.05;
	}

	func_6F92(var_00);
}

//Function Number: 57
func_6F91()
{
	self.var_2660 waittill("FX_State_Change0");
	self.var_2660 endon("death");
	func_7D2E(self);
}

//Function Number: 58
func_6F92(param_00)
{
	param_00 method_81DF(1);
	wait 0.05;
	param_00 method_81DF(0);
	wait(0.1);
	param_00 method_81DF(1);
	wait 0.05;
	param_00 method_81DF(0);
	wait(0.1);
	param_00 method_81DF(1);
}

//Function Number: 59
func_3A1E(param_00)
{
	var_01 = 0;
	var_02 = 20000;
	var_03 = 1;
	if(isdefined(self.var_18A))
	{
		var_03 = self.var_18A;
	}

	if(param_00 == "slow")
	{
		if(isdefined(self.var_165) && self.var_165 == "lockedspeed")
		{
			var_01 = 180;
		}
		else
		{
			var_01 = randomfloatrange(100 * var_03,360 * var_03);
		}
	}
	else if(param_00 == "fast")
	{
		var_01 = randomfloatrange(720 * var_03,1000 * var_03);
	}
	else if(param_00 == "veryslow")
	{
		var_01 = randomfloatrange(1 * var_03,2 * var_03);
	}
	else
	{
	}

	if(isdefined(self.var_165) && self.var_165 == "lockedspeed")
	{
		wait(0);
	}
	else
	{
		wait(randomfloatrange(0,1));
	}

	if(!isdefined(self))
	{
		return;
	}

	var_04 = self.var_1D;
	var_05 = anglestoright(self.var_1D) * 100;
	var_05 = vectornormalize(var_05);
	for(;;)
	{
		var_06 = abs(vectordot(var_05,(1,0,0)));
		var_07 = abs(vectordot(var_05,(0,1,0)));
		var_08 = abs(vectordot(var_05,(0,0,1)));
		if(var_06 > 0.9)
		{
			self rotatevelocity((var_01,0,0),var_02);
		}
		else if(var_07 > 0.9)
		{
			self rotatevelocity((var_01,0,0),var_02);
		}
		else if(var_08 > 0.9)
		{
			self rotatevelocity((0,var_01,0),var_02);
		}
		else
		{
			self rotatevelocity((0,var_01,0),var_02);
		}

		wait(var_02);
	}
}

//Function Number: 60
func_9DC3(param_00,param_01)
{
	level endon("game_ended");
	self endon("deleted");
	self.var_37D8 = self getentitynumber();
	for(;;)
	{
		self waittill("trigger",var_02);
		if(!isplayer(var_02) && !isdefined(var_02.var_3BAA))
		{
			continue;
		}

		if(!isalive(var_02))
		{
			continue;
		}

		if(isdefined(var_02.var_9AC5) && !isdefined(var_02.var_9AC5[self.var_37D8]))
		{
			var_02 thread func_7477(self,param_00,param_01);
		}
	}
}

//Function Number: 61
func_7477(param_00,param_01,param_02)
{
	param_00 endon("deleted");
	if(!isplayer(self))
	{
		self endon("death");
	}

	if(!common_scripts\utility::func_57D7())
	{
		var_03 = self.var_48CA;
	}
	else
	{
		var_03 = "player" + gettime();
	}

	param_00.var_9AC3[var_03] = self;
	if(isdefined(param_00.var_64DD))
	{
		self.var_64DE++;
	}

	param_00 notify("trigger_enter",self);
	self notify("trigger_enter",param_00);
	if(isdefined(param_01))
	{
		self thread [[ param_01 ]](param_00);
	}

	self.var_9AC5[param_00.var_37D8] = param_00;
	while(isalive(self) && self istouching(param_00) && common_scripts\utility::func_57D7() || !level.var_3F9D)
	{
		wait 0.05;
	}

	if(isdefined(self))
	{
		self.var_9AC5[param_00.var_37D8] = undefined;
		if(isdefined(param_00.var_64DD))
		{
			self.var_64DE--;
		}

		self notify("trigger_leave",param_00);
		if(isdefined(param_02))
		{
			self thread [[ param_02 ]](param_00);
		}
	}

	if(!common_scripts\utility::func_57D7() && level.var_3F9D)
	{
		return;
	}

	param_00.var_9AC3[var_03] = undefined;
	param_00 notify("trigger_leave",self);
	if(!func_0F13(param_00))
	{
		param_00 notify("trigger_empty");
	}
}

//Function Number: 62
func_64B5()
{
	if(isdefined(level.var_2F91))
	{
		return;
	}

	self endon("disconnect");
	if(!isplayer(self))
	{
		self endon("death");
	}

	self.var_64DE = 0;
	self.var_3040 = 0;
	for(;;)
	{
		self waittill("trigger_enter");
		var_00 = self.var_116;
		while(self.var_64DE)
		{
			self.var_3040 = distance(var_00,self.var_116);
			var_00 = self.var_116;
			wait 0.05;
		}

		self.var_3040 = 0;
	}
}

//Function Number: 63
func_0F13(param_00)
{
	return param_00.var_9AC3.size;
}

//Function Number: 64
func_7476(param_00,param_01)
{
	return isdefined(param_00.var_9AC5[param_01.var_37D8]);
}

//Function Number: 65
func_5409()
{
	var_00 = getentarray("interactive_tv","targetname");
	if(var_00.size)
	{
		common_scripts\utility::func_6753(["com_tv2_d","com_tv1_d","com_tv1","com_tv2","com_tv1_testpattern","com_tv2_testpattern"],::precachemodel);
		level.var_1BB0["tv_explode"] = loadfx("vfx/test/test_fx");
	}

	level.var_9FB8 = getentarray("interactive_tv_light","targetname");
	common_scripts\utility::func_FB2(getentarray("interactive_tv","targetname"),::func_9FB9);
}

//Function Number: 66
func_9FB9()
{
	self setcandamage(1);
	self.var_29D1 = undefined;
	self.var_6A14 = undefined;
	self.var_29D1 = "com_tv2_d";
	self.var_6A14 = "com_tv2";
	self.var_6B58 = "com_tv2_testpattern";
	if(issubstr(self.var_106,"1"))
	{
		self.var_6A14 = "com_tv1";
		self.var_6B58 = "com_tv1_testpattern";
	}

	if(isdefined(self.var_1A2))
	{
		if(isdefined(level.var_2F49))
		{
			var_00 = getent(self.var_1A2,"targetname");
			if(isdefined(var_00))
			{
				var_00 delete();
			}
		}
		else
		{
			self.var_A241 = getent(self.var_1A2,"targetname");
			self.var_A241 usetriggerrequirelookat();
			self.var_A241 setcursorhint("HINT_NOICON");
		}
	}

	var_01 = common_scripts\utility::func_40B0(self.var_116,level.var_9FB8,undefined,undefined,64);
	if(var_01.size)
	{
		self.var_5DD4 = var_01[0];
		level.var_9FB8 = common_scripts\utility::func_F93(level.var_9FB8,self.var_5DD4);
		self.var_5DD6 = self.var_5DD4 method_81DE();
	}

	thread func_9FB7();
	if(isdefined(self.var_A241))
	{
		thread func_9FBA();
	}
}

//Function Number: 67
func_9FBA()
{
	self.var_A241 endon("death");
	for(;;)
	{
		wait(0.2);
		self.var_A241 waittill("trigger");
		self notify("off");
		if(self.var_106 == self.var_6A14)
		{
			self setmodel(self.var_6B58);
			if(isdefined(self.var_5DD4))
			{
				self.var_5DD4 method_81DF(self.var_5DD6);
			}

			continue;
		}

		self setmodel(self.var_6A14);
		if(isdefined(self.var_5DD4))
		{
			self.var_5DD4 method_81DF(0);
		}
	}
}

//Function Number: 68
func_9FB7()
{
	self waittill("damage",var_00,var_01,var_02,var_03,var_04);
	self notify("off");
	if(isdefined(self.var_A241))
	{
		self.var_A241 notify("death");
	}

	self setmodel(self.var_29D1);
	if(isdefined(self.var_5DD4))
	{
		self.var_5DD4 method_81DF(0);
	}

	playfxontag(level.var_1BB0["tv_explode"],self,"tag_fx");
	self method_8617("tv_shot_burst");
	if(isdefined(self.var_A241))
	{
		self.var_A241 delete();
	}
}

//Function Number: 69
func_8CA1()
{
	if(!isdefined(self.var_6BF5))
	{
		self.var_6BF5 = 1;
	}

	var_00 = getentarray(self.var_1A2,"script_linkname");
	var_01 = [];
	foreach(var_03 in var_00)
	{
		if(var_03.var_3A == "script_origin")
		{
			var_01[var_01.size] = var_03;
			continue;
		}

		var_03 func_3265(self.var_6BF5);
	}

	var_00 = common_scripts\utility::func_F94(var_00,var_01);
	for(;;)
	{
		if(!isdefined(function_02D1()))
		{
			wait(1);
			continue;
		}

		var_05 = vehicle_getarray();
		var_06 = common_scripts\utility::func_F73(function_02D1(),var_05);
		var_07 = 0;
		foreach(var_09 in var_06)
		{
			if((isdefined(var_09.var_1A7) && var_09.var_1A7 == "spectator") || isdefined(var_09.var_178) && var_09.var_178 == "spectator")
			{
				continue;
			}

			if(var_09 istouching(self))
			{
				var_07++;
				break;
			}
		}

		if(var_07 > 0)
		{
			func_6BE2(var_00);
		}
		else
		{
			var_0B = 1;
			thread func_2430(var_00,var_0B);
		}

		wait 0.05;
	}
}

//Function Number: 70
func_3265(param_00)
{
	self.var_926A = self.var_116;
	self.var_8CA2 = "closed";
	var_01 = getent(self.var_1A2,"targetname");
	self.var_6BF3 = var_01.var_116;
	self.var_6BF8 = distance(self.var_6BF3,self.var_116) / param_00;
}

//Function Number: 71
func_6BE2(param_00)
{
	foreach(var_02 in param_00)
	{
		if(var_02.var_8CA2 == "open" || var_02.var_8CA2 == "opening")
		{
			continue;
		}

		var_02 thread func_6BE8();
	}
}

//Function Number: 72
func_6BE8()
{
	self.var_8CA2 = "opening";
	var_00 = distance(self.var_116,self.var_6BF3) / self.var_6BF8;
	if(var_00 < 0.05)
	{
		var_00 = 0.05;
	}

	self moveto(self.var_6BF3,var_00);
	self method_8617("glass_door_open");
	wait(var_00);
	self.var_8CA2 = "open";
}

//Function Number: 73
func_2430(param_00,param_01)
{
	foreach(var_03 in param_00)
	{
		if(var_03.var_8CA2 == "closed" || var_03.var_8CA2 == "opening")
		{
			continue;
		}

		var_03 moveto(var_03.var_926A,param_01);
		self method_8617("glass_door_close");
		var_03.var_8CA2 = "closed";
	}
}