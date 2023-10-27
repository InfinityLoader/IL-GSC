/*******************************************************************
 * Decompiled By: Bog
 * Decompiled File: 3137.gsc
 * Game: Call of Duty: Infinite Warfare
 * Platform: PC
 * Function Count: 68
 * Decompile Time: 46 ms
 * Timestamp: 10/27/2023 12:26:14 AM
*******************************************************************/

//Function Number: 1
func_3629()
{
	anim.var_362A = [];
	level.var_362A["left"] = [];
	level.var_362A["left"]["rail"]["height"] = 120.336;
	level.var_362A["left"]["rail"]["max"] = 147.938;
	level.var_362A["left"]["rail"]["min"] = 72.6321;
	level.var_362A["left"]["rail"]["radius"] = 41.6399;
	level.var_362A["left"]["rail"]["center_offset"] = 13.7184;
	level.var_362A["left"]["rail"]["rate"] = 1.52309;
	level.var_362A["left"]["pitch"] = [];
	level.var_362A["left"]["pitch"]["max"] = -81.8474;
	level.var_362A["left"]["pitch"]["min"] = 81.8623;
	level.var_362A["left"]["pitch"]["rate"] = 1.35075;
	level.var_362A["right"] = [];
	level.var_362A["right"]["rail"]["height"] = 119.798;
	level.var_362A["right"]["rail"]["max"] = -147.617;
	level.var_362A["right"]["rail"]["min"] = -72.5554;
	level.var_362A["right"]["rail"]["radius"] = 41.7472;
	level.var_362A["right"]["rail"]["center_offset"] = 13.7055;
	level.var_362A["right"]["rail"]["rate"] = 1.52613;
	level.var_362A["right"]["pitch"] = [];
	level.var_362A["right"]["pitch"]["max"] = -81.8536;
	level.var_362A["right"]["pitch"]["min"] = 81.8683;
	level.var_362A["right"]["pitch"]["rate"] = 1.35211;
	level.var_362A["main"] = [];
	level.var_362A["main"]["hex"]["max"] = 67.5246;
	level.var_362A["main"]["hex"]["min"] = -72.8348;
	level.var_362A["main"]["hex"]["rate"] = 1.15538;
	level.var_362A["main"]["minigun"]["yaw_delta"] = 2.73737;
	level.var_362A["main"]["minigun"]["pitch_offset"] = 7.1249;
	level.var_362A["main"]["minigun"][2] = 32.8453;
	level.var_362A["main"]["minigun"][4] = 13.2259;
	level.var_362A["main"]["minigun"][6] = -13.7964;
	level.var_362A["main"]["minigun"][8] = 0.938614;
	level.var_362A["main"]["rocket"]["yaw_delta"] = -2.78845;
	level.var_362A["main"]["rocket"]["pitch_delta"] = -5.96385;
}

//Function Number: 2
func_3628(param_00,param_01,param_02)
{
	return level.var_362A[param_00][param_01][param_02];
}

//Function Number: 3
func_3627(param_00)
{
	self endon("death");
	self endon("self_destruct");
	self endon("stop_c12trackloop");
	self.var_2303.var_11AC7 = param_00;
	self.var_2303.var_11B08 = spawnstruct();
	self.var_2303.var_11B08.var_3140 = 0;
	self.var_2303.var_11B08.var_30E6 = 0;
	wait(0.5);
	func_362C();
}

//Function Number: 4
func_358A()
{
	return lib_0A1E::func_2356("aim_parent_knob","aim_knob");
}

//Function Number: 5
func_9E4D()
{
	var_00 = lib_0A1A::func_233A(self.var_2303.var_11AC7);
	switch(var_00)
	{
		case "exposed_exit":
		case "stand_turn":
		case "run_turn":
			return 1;
	}

	return 0;
}

//Function Number: 6
func_35FF()
{
	var_00 = self.var_180;
	self.var_180 = 1;
	var_01 = func_358A();
	self method_82A2(var_01,1000,0.1,1);
	self.var_2303.var_11B08.var_DCCF = [];
	func_3600();
	func_3601();
	func_3604();
	self.var_2303.var_11B08.var_3140 = 1;
	self.var_180 = var_00;
}

//Function Number: 7
func_3583()
{
	var_00 = self gettagangles("j_spineupper");
	var_01 = anglestoaxis(var_00);
	var_02 = rotatevectorinverted(var_01["right"],self.angles);
	var_03 = vectortoyaw(var_02);
	return angleclamp180(var_03);
}

//Function Number: 8
func_357E(param_00)
{
	if(!isdefined(param_00))
	{
		var_01 = lib_0A1E::func_2356("aim_body","hexapod");
		param_00 = self method_8102(var_01);
	}

	var_02 = func_3628("main","hex","min");
	var_03 = func_3628("main","hex","max");
	var_04 = var_02 + param_00 * var_03 - var_02;
	return var_04;
}

//Function Number: 9
func_3600()
{
	var_00 = self.var_2303.var_11B08;
	var_01 = lib_0A1E::func_2356("aim_body","hexapod");
	self method_82A2(var_01,1,0,0);
	wait(0.1);
	var_02 = [];
	var_03 = func_3583();
	var_02["min"] = var_03;
	var_04 = var_03 < 0;
	var_05 = 0;
	self method_82B1(var_01,1);
	var_06 = 0;
	while(var_06 < 1)
	{
		var_07 = self gettagorigin("j_spineupper");
		var_08 = self gettagangles("j_spineupper");
		var_09 = anglestoaxis(var_08);
		func_3547(var_09,var_07);
		var_06 = self method_8102(var_01);
		if(!var_05)
		{
			var_0A = func_3583();
			var_0B = var_0A < 0;
			if(var_04 != var_0B)
			{
				var_02["zero"] = var_06;
				var_05 = 1;
			}
		}

		wait(0.05);
	}

	if(!var_05)
	{
		var_02["zero"] = 0;
	}

	var_02["max"] = func_3583();
	if(var_02["max"] < var_02["min"])
	{
		var_02["max"] = var_02["max"] + 360;
	}

	var_02["rate"] = 0.05 * abs(var_02["max"] - var_02["min"]) / getanimlength(var_01);
	var_00.var_DCCF["main"] = [];
	var_00.var_DCCF["main"]["hex"] = var_02;
	func_3608(var_01,"main","hex",0);
}

//Function Number: 10
func_358D(param_00)
{
	var_01 = func_3628(param_00,"rail","center_offset");
	var_02 = func_3628(param_00,"rail","height");
	var_03 = anglestoforward(self.angles);
	return self.origin + var_03 * var_01 + (0,0,var_02);
}

//Function Number: 11
func_3580(param_00,param_01)
{
	var_02 = func_3628(param_00,"rail","center_offset");
	var_03 = func_3628(param_00,"rail","height");
	var_04 = (var_02,0,0);
	if(!isdefined(param_01))
	{
		param_01 = func_357E();
	}

	var_04 = rotatevector(var_04,(0,param_01,0));
	var_04 = rotatevector(var_04,self.angles);
	return self.origin + var_04 + (0,0,var_03);
}

//Function Number: 12
func_358F(param_00)
{
	var_01 = undefined;
	if(param_00 == "left")
	{
		var_01 = "j_clavicle_track_le";
	}
	else
	{
		var_01 = "j_clavicle_track_ri";
	}

	var_02 = self gettagorigin(var_01);
	return var_02;
}

//Function Number: 13
func_358C(param_00,param_01)
{
	var_02 = undefined;
	if(param_01 == "left")
	{
		var_02 = "j_clavicle_track_le";
	}
	else
	{
		var_02 = "j_clavicle_track_ri";
	}

	var_03 = self gettagorigin(var_02);
	var_04 = self.origin;
	var_05 = var_03 - var_04;
	var_05 = (var_05[0],var_05[1],0);
	var_06 = rotatevectorinverted(var_05,self.angles);
	var_07 = vectortoangles(var_06);
	return angleclamp180(var_07[1]);
}

//Function Number: 14
func_358B(param_00)
{
	var_01 = undefined;
	if(param_00 == "left")
	{
		var_01 = "j_clavicle_track_le";
	}
	else
	{
		var_01 = "j_clavicle_track_ri";
	}

	var_02 = self gettagorigin(var_01);
	var_03 = func_358D(param_00);
	var_04 = var_02 - var_03;
	var_04 = (var_04[0],var_04[1],0);
	var_05 = rotatevectorinverted(var_04,self.angles);
	var_06 = vectortoangles(var_05);
	return angleclamp180(var_06[1]);
}

//Function Number: 15
func_357F(param_00,param_01)
{
	if(!isdefined(param_01))
	{
		var_02 = lib_0A1E::func_2356("aimset_" + param_00,"arm_rail");
		param_01 = self method_8102(var_02);
	}

	var_03 = func_3628(param_00,"rail","min");
	var_04 = func_3628(param_00,"rail","max");
	var_05 = var_04 - var_03;
	var_06 = var_03 + param_01 * var_05;
	return var_06;
}

//Function Number: 16
func_3581(param_00,param_01)
{
	if(!isdefined(param_01))
	{
		var_02 = lib_0A1E::func_2356("aimset_" + param_00,"arm_pitch");
		param_01 = self method_8102(var_02);
	}

	var_03 = func_3628(param_00,"pitch","min");
	var_04 = func_3628(param_00,"pitch","max");
	var_05 = var_04 - var_03;
	var_06 = var_03 + param_01 * var_05;
	return var_06;
}

//Function Number: 17
func_3590(param_00)
{
	var_01 = undefined;
	if(param_00 == "left")
	{
		var_01 = "j_clavicle_track_le";
	}
	else
	{
		var_01 = "j_clavicle_track_ri";
	}

	var_02 = self gettagorigin(var_01);
	var_03 = var_02 - self.origin;
	return length2d(var_03);
}

//Function Number: 18
func_3591(param_00)
{
	var_01 = undefined;
	if(param_00 == "left")
	{
		var_01 = "j_clavicle_track_le";
	}
	else
	{
		var_01 = "j_clavicle_track_ri";
	}

	var_02 = self gettagorigin(var_01);
	return var_02[2] - self.origin[2];
}

//Function Number: 19
func_358E(param_00,param_01)
{
	var_02 = undefined;
	if(param_01 == "left")
	{
		var_02 = "j_clavicle_x_le";
	}
	else
	{
		var_02 = "j_clavicle_x_ri";
	}

	var_03 = self gettagangles(var_02);
	var_04 = anglestoright(var_03);
	var_05 = rotatevectorinverted(var_04,self.angles);
	var_06 = vectortoangles(var_05);
	return angleclamp180(var_06[0]);
}

//Function Number: 20
func_351F(param_00,param_01,param_02,param_03)
{
	var_04 = param_03 * param_03 - param_01 * param_01;
	var_05 = 180 - param_00;
	var_06 = 180 - param_02;
	var_07 = -0.5 * var_04 / param_03 * cos(var_06) - param_01 * cos(var_05);
	return var_07;
}

//Function Number: 21
func_3603(param_00)
{
	var_01 = self.var_2303.var_11B08;
	var_02 = 0;
	if(param_00 == "left")
	{
		var_02 = 90;
	}
	else
	{
		var_02 = -90;
	}

	var_01.var_DCCF[param_00] = [];
	var_01.var_DCCF[param_00]["rail"] = [];
	var_03 = lib_0A1E::func_2356("aimset_" + param_00,"arm_rail");
	self method_82A2(var_03,1,0,0);
	wait(0.1);
	var_04 = func_3591(param_00);
	var_01.var_DCCF[param_00]["rail"]["height"] = var_04;
	var_05 = func_358F(param_00);
	var_06 = func_358C(var_03,param_00);
	var_07 = func_3590(param_00);
	self method_82B0(var_03,1);
	wait(0.1);
	var_08 = func_358F(param_00);
	var_09 = func_358C(var_03,param_00);
	var_0A = func_3590(param_00);
	var_0B = func_351F(var_06,var_07,var_09,var_0A);
	var_01.var_DCCF[param_00]["rail"]["center_offset"] = var_0B;
	var_0C = func_358D(param_00);
	var_0D = distance(var_05,var_0C);
	var_0E = distance(var_08,var_0C);
	var_01.var_DCCF[param_00]["rail"]["radius"] = var_0D + var_0E * 0.5;
	self method_82B0(var_03,0);
	wait(0.1);
	var_01.var_DCCF[param_00]["rail"]["min"] = func_358B(param_00);
	self method_82B0(var_03,1);
	wait(0.1);
	var_01.var_DCCF[param_00]["rail"]["max"] = func_358B(param_00);
	var_01.var_DCCF[param_00]["rail"]["rate"] = 0.05 * abs(var_01.var_DCCF[param_00]["rail"]["max"] - var_01.var_DCCF[param_00]["rail"]["min"]) / getanimlength(var_03);
	if(param_00 == "left")
	{
		func_3608(var_03,param_00,"rail",90);
	}
	else
	{
		func_3608(var_03,param_00,"rail",-90);
	}

	var_03 = lib_0A1E::func_2356("aimset_" + param_00,"arm_pitch");
	self method_82A2(var_03,1,0,0);
	wait(0.05);
	var_01.var_DCCF[param_00]["pitch"] = [];
	var_01.var_DCCF[param_00]["pitch"]["min"] = func_358E(var_03,param_00);
	self method_82B0(var_03,1);
	wait(0.1);
	var_01.var_DCCF[param_00]["pitch"]["max"] = func_358E(var_03,param_00);
	var_01.var_DCCF[param_00]["pitch"]["rate"] = 0.05 * abs(var_01.var_DCCF[param_00]["pitch"]["max"] - var_01.var_DCCF[param_00]["pitch"]["min"]) / getanimlength(var_03);
	var_0F = 0;
	self method_82B0(var_03,0);
	self method_82B1(var_03,1);
	while(var_0F < 8)
	{
		var_10 = undefined;
		if(param_00 == "left")
		{
			var_10 = "j_clavicle_x_le";
		}
		else
		{
			var_10 = "j_clavicle_x_ri";
		}

		var_11 = func_358E(var_03,param_00);
		var_12 = self method_8102(var_03);
		var_13 = self gettagangles(var_10);
		func_3547(anglestoaxis(var_13),self gettagorigin(var_10));
		wait(0.05);
		var_0F = var_0F + 0.05;
	}

	self method_82B1(var_03,0);
	func_3608(var_03,param_00,"pitch",0);
}

//Function Number: 22
func_3585(param_00)
{
	var_01 = undefined;
	if(param_00 == "left")
	{
		var_01 = "tag_weapon_rotate_le";
	}
	else
	{
		var_01 = "tag_weapon_rotate_ri";
	}

	return self gettagangles(var_01);
}

//Function Number: 23
func_3587(param_00)
{
	var_01 = undefined;
	if(param_00 == "left")
	{
		var_01 = "tag_weapon_rotate_le";
	}
	else
	{
		var_01 = "tag_weapon_rotate_ri";
	}

	return self gettagorigin(var_01);
}

//Function Number: 24
func_3586(param_00)
{
	var_01 = undefined;
	if(param_00 == "left")
	{
		var_01 = "j_weaponshoulder_x_le";
	}
	else
	{
		var_01 = "j_weaponshoulder_x_ri";
	}

	return self gettagorigin(var_01);
}

//Function Number: 25
func_3588(param_00)
{
	var_01 = undefined;
	if(param_00 == "left")
	{
		var_01 = "j_weaponshoulder_le";
	}
	else
	{
		var_01 = "j_weaponshoulder_ri";
	}

	return self gettagorigin(var_01);
}

//Function Number: 26
func_3602(param_00)
{
	wait(0.2);
	var_01 = self.var_2303.var_11B08;
	var_02 = lib_0A1E::func_2356("aimset_minigun","aim_5");
	self method_82A2(var_02,0.01,0,1);
	wait(0.05);
	var_03 = func_3585(param_00);
	var_01.var_DCCF["main"]["minigun"]["yaw_delta"] = angleclamp180(var_03[1] - self.angles[1]);
	var_04 = func_3587(param_00);
	var_05 = func_3588(param_00);
	var_06 = func_3586(param_00);
	var_07 = vectornormalize(var_04 - var_06);
	var_08 = var_04 - var_05;
	var_09 = vectordot(var_07,var_08);
	var_01.var_DCCF["main"]["minigun"]["pitch_offset"] = distance(var_05,var_06);
	var_0A = lib_0A1E::func_2356("aimset_minigun","aim_2");
	self method_82A2(var_0A,1,0,1,0);
	wait(0.1);
	var_04 = func_3587(param_00);
	var_06 = func_3586(param_00);
	var_0B = var_04 - var_06;
	var_0C = var_0B[2];
	var_01.var_DCCF["main"]["minigun"][2] = 0 - asin(var_0C / length(var_0B));
	self method_806F(var_0A,0);
	var_0D = lib_0A1E::func_2356("aimset_minigun","aim_8");
	self method_82A2(var_0D,1,0,1,0);
	wait(0.1);
	var_04 = func_3587(param_00);
	var_06 = func_3586(param_00);
	var_0B = var_04 - var_06;
	var_0C = var_0B[2];
	var_01.var_DCCF["main"]["minigun"][8] = 0 - asin(var_0C / length(var_0B));
	self method_806F(var_0D,0);
	var_0E = anglestoright(self.angles);
	var_0F = lib_0A1E::func_2356("aimset_minigun","aim_4");
	self method_82A2(var_0F,1,0,1,0);
	wait(0.1);
	var_04 = func_3587(param_00);
	var_06 = func_3586(param_00);
	var_0B = var_04 - var_06;
	var_10 = vectordot(var_0B,var_0E) * -1;
	var_01.var_DCCF["main"]["minigun"][4] = asin(var_10 / length(var_0B));
	self method_806F(var_0F,0);
	var_11 = lib_0A1E::func_2356("aimset_minigun","aim_6");
	self method_82A2(var_11,1,0,1,0);
	wait(0.1);
	var_04 = func_3587(param_00);
	var_06 = func_3586(param_00);
	var_0B = var_04 - var_06;
	var_10 = vectordot(var_0B,var_0E) * -1;
	var_01.var_DCCF["main"]["minigun"][6] = asin(var_10 / length(var_0B));
	self method_806F(var_11,0);
	var_12 = lib_0A1E::func_2356("aimset_minigun","aim_knob_28");
	self method_806F(var_12,0);
	var_13 = lib_0A1E::func_2356("aimset_minigun","aim_knob_46");
	self method_806F(var_13,0);
}

//Function Number: 27
func_3594(param_00,param_01)
{
	var_02 = undefined;
	if(param_00 == "left")
	{
		if(param_01 == "top")
		{
			var_02 = "tag_missile_top_le";
		}
		else
		{
			var_02 = "tag_missile_bottom_le";
		}
	}
	else if(param_01 == "top")
	{
		var_02 = "tag_missile_top_ri";
	}
	else
	{
		var_02 = "tag_missile_bottom_ri";
	}

	return var_02;
}

//Function Number: 28
func_3593(param_00,param_01)
{
	var_02 = func_3594(param_00,param_01);
	return self gettagorigin(var_02);
}

//Function Number: 29
func_3592(param_00,param_01)
{
	var_02 = func_3594(param_00,param_01);
	return self gettagangles(var_02);
}

//Function Number: 30
func_3605(param_00)
{
	wait(0.2);
	var_01 = func_3592(param_00,"top");
	self.var_2303.var_11B08.var_DCCF["main"]["rocket"]["yaw_delta"] = angleclamp180(var_01[1] - self.angles[1]);
	self.var_2303.var_11B08.var_DCCF["main"]["rocket"]["pitch_delta"] = -1 * var_01[0];
}

//Function Number: 31
func_3601()
{
	func_3603("left");
	func_3602("left");
}

//Function Number: 32
func_3604()
{
	func_3603("right");
	func_3605("right");
}

//Function Number: 33
func_35A7()
{
	var_00 = 0.3;
	var_01 = 0.2;
	var_02 = lib_0A1E::func_2356("aim_body","hexapod");
	func_3608(var_02,"main","hex",0,var_00);
	var_02 = lib_0A1E::func_2356("aimset_left","arm_rail");
	func_3608(var_02,"left","rail",100,var_00);
	var_02 = lib_0A1E::func_2356("aimset_left","arm_pitch");
	func_3608(var_02,"left","pitch",0,var_00);
	var_02 = lib_0A1E::func_2356("aimset_right","arm_rail");
	func_3608(var_02,"right","rail",-100,var_00);
	var_02 = lib_0A1E::func_2356("aimset_right","arm_pitch");
	func_3608(var_02,"right","pitch",0,var_00);
	var_03 = func_358A();
	thread func_3632(var_03,var_00,var_01);
	self.var_2303.var_11B08.var_3140 = 1;
}

//Function Number: 34
func_3632(param_00,param_01,param_02)
{
	self endon("death");
	self method_82A2(param_00,5,param_01,1);
	wait(param_01);
	if(!self.var_2303.var_11B08.var_3140)
	{
		return;
	}

	self method_82A2(param_00,15,param_02);
	wait(param_02);
	if(!self.var_2303.var_11B08.var_3140)
	{
		return;
	}

	self method_82A2(param_00,1000,1);
}

//Function Number: 35
func_3529()
{
	var_00 = func_358A();
	self method_806F(var_00,0.2);
	self.var_2303.var_11B08.var_3140 = 0;
}

//Function Number: 36
func_3582()
{
	var_00 = self.var_1198.var_FECD;
	var_01 = lib_0C42::func_3518("left");
	var_02 = lib_0C42::func_3518("right");
	if(var_01 && var_02)
	{
		var_03 = func_3595("left");
		var_04 = func_3595("right");
		if(isdefined(var_03) && isdefined(var_04))
		{
			var_05 = 0.5 * var_03 + var_04;
			if(distancesquared(var_05,self.origin) < 10000 && distancesquared(var_03,var_04) > 0)
			{
				var_06 = scripts\common\utility::func_6EE6(var_03 - self.origin);
				var_07 = scripts\common\utility::func_6EE6(var_04 - self.origin);
				var_08 = vectortoyaw(var_06);
				var_09 = vectortoyaw(var_07);
				var_0A = angleclamp180(var_08 + var_09 * 0.5);
				var_0B = anglestoforward((0,var_0A,0));
				var_05 = self.origin + var_0B * 256;
			}

			return var_05;
		}
		else if(isdefined(var_04))
		{
			return var_04;
		}
		else if(isdefined(var_05))
		{
			return var_05;
		}
	}

	if(var_02)
	{
		return func_3595("left");
	}
	else
	{
		return func_3595("right");
	}

	return undefined;
}

//Function Number: 37
func_3595(param_00,param_01)
{
	var_02 = self.var_1198.var_FECD;
	if(!isdefined(var_02))
	{
		return undefined;
	}

	var_03 = var_02.var_13CC3[param_00];
	if(!isdefined(var_03))
	{
		return undefined;
	}

	if(!isdefined(param_01))
	{
		param_01 = 0;
	}

	if(!param_01 && !var_03.var_312A)
	{
		return undefined;
	}

	if(isdefined(var_03.var_1A46) && var_03.var_1A47 != gettime())
	{
		var_04 = 0;
		if(lib_0C08::func_A007(param_00,"rocket"))
		{
			var_04 = 1;
		}

		return lib_0C08::func_FE67(var_03,var_04);
	}

	return var_04.var_1A46;
}

//Function Number: 38
func_351E(param_00,param_01,param_02,param_03,param_04)
{
	var_05 = self.var_1198.var_FECD;
	var_06 = func_3595(param_00);
	if(!isdefined(var_06))
	{
		param_04.var_B7A9 = 0;
		param_04.var_B7A6 = 0;
		return;
	}

	var_07 = func_3588(param_00);
	var_08 = func_357F(param_00,param_02);
	if(param_00 == "left")
	{
		var_08 = var_08 - 90;
	}
	else
	{
		var_08 = var_08 + 90;
	}

	if(!isdefined(param_01))
	{
		param_01 = func_357E();
	}

	var_09 = anglestoaxis(self.angles + (0,param_01 + var_08,0));
	var_0A = var_06 - var_07;
	var_0B = vectordot(var_0A,var_09["right"]) * -1;
	var_0C = vectordot(var_0A,var_09["up"]);
	var_0D = var_0A - var_0C * var_09["up"];
	var_0E = length(var_0D);
	var_0F = var_0A + var_0B * var_09["right"];
	var_10 = length(var_0F);
	var_11 = clamp(func_3628("main","minigun","pitch_offset") / var_10,-1,1);
	var_12 = 90 - acos(var_11);
	var_13 = clamp(var_0B / var_0E,-1,1);
	param_04.var_B7A9 = asin(var_13) - func_3628("main","minigun","yaw_delta");
	var_13 = clamp(var_0C / var_10,-1,1);
	param_04.var_B7A6 = -1 * asin(var_13) - func_3581(param_00,param_03) + var_12;
}

//Function Number: 39
func_3521(param_00,param_01,param_02,param_03,param_04)
{
	var_05 = param_01 - param_03;
	var_05 = (var_05[0],var_05[1],0);
	var_06 = length(var_05);
	if(param_04 > var_06)
	{
		var_07 = -90;
		if(param_00 == "right")
		{
			var_07 = 90;
		}
	}
	else
	{
		var_06 = var_06 / var_07;
		var_08 = anglestoforward((0,param_03 + self.angles[1],0));
		var_07 = acos(param_04 / var_06);
		var_09 = vectordot(var_05,var_08);
		if(param_00 == "right")
		{
			var_07 = -1 * var_07;
		}

		if(-1 < var_09 && var_09 < 1)
		{
			var_0A = vectorcross(var_05,var_08);
			if(var_0A[2] > 0)
			{
				var_07 = var_07 - acos(var_09);
			}
			else
			{
				var_07 = var_07 + acos(var_09);
			}
		}
	}

	return var_07;
}

//Function Number: 40
func_3520(param_00,param_01,param_02,param_03,param_04,param_05)
{
	var_06 = self.angles + (0,param_05 + param_02,0);
	var_07 = anglestoforward(var_06);
	var_08 = param_03 + param_04 * var_07;
	var_09 = param_01 - var_08;
	var_0A = var_09[2];
	var_0B = clamp(var_0A / length(var_09),-1,1);
	var_0C = asin(var_0B);
	return -1 * var_0C;
}

//Function Number: 41
func_3522(param_00)
{
	var_01 = self.var_1198.var_FECD;
	var_02 = spawnstruct();
	var_03 = func_3582();
	if(isdefined(var_03))
	{
		var_04 = var_03 - self.origin;
		var_05 = rotatevectorinverted(var_04,self.angles);
		var_06 = vectortoyaw(var_05);
		var_02.var_8E55 = angleclamp180(var_06);
	}
	else
	{
		var_02.var_8E55 = 0;
	}

	if(func_9E4D())
	{
		var_08 = func_3583();
	}
	else
	{
		var_08 = func_357E(var_01.var_8E54);
	}

	var_09 = func_3595("left");
	if(isdefined(var_09))
	{
		var_0A = func_3580("left",var_08);
		var_0B = func_3628("left","rail","radius");
		var_02.var_AB57 = func_3521("left",var_09,var_08,var_0A,var_0B);
		var_02.var_AB56 = func_3520("left",var_09,var_08,var_0A,var_0B,var_02.var_AB57);
		if(self.var_13CC3["left"] == "minigun")
		{
			func_351E("left",var_08,param_00.var_AB57,param_00.var_AB56,var_02);
		}
		else if(self.var_13CC3["left"] == "rocket")
		{
			var_02.var_AB57 = var_02.var_AB57 + func_3628("main","rocket","yaw_delta");
			var_02.var_AB56 = var_02.var_AB56 + func_3628("main","rocket","pitch_delta");
			if(isdefined(self.var_E5C4))
			{
				var_02.var_AB56 = var_02.var_AB56 - self.var_E5C4;
			}
		}
	}
	else
	{
		var_02.var_AB57 = 90;
		var_02.var_AB56 = 0;
	}

	var_0C = func_3595("right");
	if(isdefined(var_0C))
	{
		var_0A = func_3580("right",var_08);
		var_0B = func_3628("right","rail","radius");
		var_02.var_E530 = func_3521("right",var_0C,var_08,var_0A,var_0B);
		var_02.var_E52F = func_3520("right",var_0C,var_08,var_0A,var_0B,var_02.var_E530);
		if(self.var_13CC3["right"] == "minigun")
		{
			func_351E("right",var_08,param_00.var_E530,param_00.var_E52F,var_02);
		}
		else if(self.var_13CC3["right"] == "rocket")
		{
			var_02.var_E530 = var_02.var_E530 - func_3628("main","rocket","yaw_delta");
			var_02.var_E52F = var_02.var_E52F + func_3628("main","rocket","pitch_delta");
			if(isdefined(self.var_E5C4))
			{
				var_02.var_E52F = var_02.var_E52F - self.var_E5C4;
			}
		}
	}
	else
	{
		var_02.var_E530 = -90;
		var_02.var_E52F = 0;
	}

	return var_02;
}

//Function Number: 42
func_3630()
{
	func_3574();
	var_00 = 0.75;
	thread func_3631(var_00);
}

//Function Number: 43
func_3631(param_00)
{
	self endon("death");
	self endon("terminate_ai_threads");
	var_01 = lib_0A1E::func_2356("aim_body","hexapod");
	self method_806F(var_01,param_00);
	var_01 = lib_0A1E::func_2356("aimset_left","arm_rail");
	self method_806F(var_01,param_00);
	var_01 = lib_0A1E::func_2356("aimset_left","arm_pitch");
	self method_806F(var_01,param_00);
	var_01 = lib_0A1E::func_2356("aimset_right","arm_rail");
	self method_806F(var_01,param_00);
	var_01 = lib_0A1E::func_2356("aimset_right","arm_pitch");
	self method_806F(var_01,param_00);
	var_02 = func_358A();
	var_03 = self method_8103(var_02);
	var_04 = 2;
	if(var_03 <= var_04)
	{
		var_05 = min(param_00,0.2 * var_03 / var_04);
		self method_806F(var_02,var_05);
		return;
	}

	while(var_04 > var_05)
	{
		self method_82A2(var_03,var_04 * 0.5,0.05);
		wait(0.05);
		if(self.var_2303.var_11B08.var_3140)
		{
			break;
		}

		var_01 = var_01 - 0.05;
		var_04 = self method_8103(var_03);
	}

	if(!self.var_2303.var_11B08.var_3140)
	{
		self method_806F(var_03,var_01);
	}
}

//Function Number: 44
func_3574()
{
	var_00 = lib_0A1E::func_2356("aim_body","hexapod");
	self method_82B1(var_00,0);
	var_00 = lib_0A1E::func_2356("aimset_left","arm_rail");
	self method_82B1(var_00,0);
	var_00 = lib_0A1E::func_2356("aimset_left","arm_pitch");
	self method_82B1(var_00,0);
	var_00 = lib_0A1E::func_2356("aimset_right","arm_rail");
	self method_82B1(var_00,0);
	var_00 = lib_0A1E::func_2356("aimset_right","arm_pitch");
	self method_82B1(var_00,0);
}

//Function Number: 45
func_363C()
{
	var_00 = lib_0A1E::func_2356("aim_body","hexapod");
	func_3607(var_00,undefined,"main","hex",0,6);
	var_00 = lib_0A1E::func_2356("aimset_left","arm_rail");
	func_3607(var_00,undefined,"left","rail",100,8);
	var_00 = lib_0A1E::func_2356("aimset_left","arm_pitch");
	func_3607(var_00,undefined,"left","pitch",0,8);
	var_00 = lib_0A1E::func_2356("aimset_right","arm_rail");
	func_3607(var_00,undefined,"right","rail",-100,8);
	var_00 = lib_0A1E::func_2356("aimset_right","arm_pitch");
	func_3607(var_00,undefined,"right","pitch",0,8);
}

//Function Number: 46
func_3608(param_00,param_01,param_02,param_03,param_04)
{
	var_05 = func_3628(param_01,param_02,"min");
	var_06 = func_3628(param_01,param_02,"max");
	var_07 = var_06 - var_05;
	if(var_05 < var_06)
	{
		param_03 = clamp(angleclamp180(param_03),var_05,var_06);
	}
	else
	{
		param_03 = clamp(angleclamp180(param_03),var_06,var_05);
	}

	if(!isdefined(param_04))
	{
		param_04 = 0;
	}

	var_08 = param_03 - var_05 / var_07;
	var_08 = clamp(var_08,0,1);
	self method_82A2(param_00,1,param_04,0);
	self method_82B0(param_00,var_08);
}

//Function Number: 47
func_3607(param_00,param_01,param_02,param_03,param_04,param_05)
{
	self method_82A2(param_00,1,0,0);
	var_06 = func_3628(param_02,param_03,"min");
	var_07 = func_3628(param_02,param_03,"max");
	var_08 = var_07 - var_06;
	if(var_06 < var_07)
	{
		param_04 = clamp(param_04,var_06,var_07);
	}
	else
	{
		param_04 = clamp(param_04,var_07,var_06);
	}

	var_09 = param_04 - var_06 / var_08;
	var_09 = clamp(var_09,0,1);
	if(!isdefined(param_01))
	{
		param_01 = self method_8102(param_00);
	}

	var_0A = var_06 + param_01 * var_08;
	var_0B = abs(param_04 - var_0A);
	if(var_0B > param_05)
	{
		var_0B = param_05;
	}

	if(-0.002 < var_0B && var_0B < 0.002)
	{
		var_0B = 0;
		self method_82B0(param_00,var_09);
	}

	var_0C = 1;
	if(var_09 < param_01)
	{
		var_0C = -1;
	}

	var_0D = func_3628(param_02,param_03,"rate");
	self method_82B1(param_00,var_0C * var_0B / var_0D);
}

//Function Number: 48
func_360B(param_00,param_01,param_02,param_03,param_04,param_05,param_06,param_07,param_08)
{
	var_09 = 0;
	var_0A = 0;
	var_0B = 0;
	var_0C = 0;
	var_0D = 0.1;
	self method_82A2(param_04,0.01,0,1);
	if(param_00 > 0)
	{
		var_0A = param_00 / func_3628("main","minigun",4);
		var_0A = clamp(var_0A,0,1);
		self method_806F(param_05,var_0D);
		self method_82A2(param_03,1,var_0D);
		self method_82A2(param_08,var_0A,var_0D);
	}
	else if(param_00 < 0)
	{
		var_0B = param_00 / func_3628("main","minigun",6);
		var_0B = clamp(var_0B,0,1);
		self method_806F(param_03,var_0D);
		self method_82A2(param_05,1,var_0D);
		self method_82A2(param_08,var_0B,var_0D);
	}

	if(param_01 > 0)
	{
		var_09 = param_01 / func_3628("main","minigun",2);
		var_09 = clamp(var_09,0,1);
		self method_806F(param_06,var_0D);
		self method_82A2(param_02,1,var_0D);
		self method_82A2(param_07,var_09,var_0D);
		return;
	}

	if(param_01 < 0)
	{
		var_0C = param_01 / func_3628("main","minigun",8);
		var_0C = clamp(var_0C,0,1);
		self method_806F(param_02,var_0D);
		self method_82A2(param_06,1,var_0D);
		self method_82A2(param_07,var_0C,var_0D);
	}
}

//Function Number: 49
func_362C()
{
	var_00 = lib_0A1E::func_2356("aim_body","hexapod");
	var_01 = lib_0A1E::func_2356("aimset_left","arm_rail");
	var_02 = lib_0A1E::func_2356("aimset_left","arm_pitch");
	var_03 = lib_0A1E::func_2356("aimset_right","arm_rail");
	var_04 = lib_0A1E::func_2356("aimset_right","arm_pitch");
	var_05 = lib_0A1E::func_2356("aimset_minigun","aim_2");
	var_06 = lib_0A1E::func_2356("aimset_minigun","aim_4");
	var_07 = lib_0A1E::func_2356("aimset_minigun","aim_6");
	var_08 = lib_0A1E::func_2356("aimset_minigun","aim_8");
	var_09 = lib_0A1E::func_2356("aimset_minigun","aim_5");
	var_0A = lib_0A1E::func_2356("aimset_minigun","aim_knob_28");
	var_0B = lib_0A1E::func_2356("aimset_minigun","aim_knob_46");
	var_0C = func_358A();
	var_0D = 0;
	var_0E = 0;
	var_0F = 6;
	var_10 = spawnstruct();
	for(;;)
	{
		var_11 = lib_0A1A::func_231B(self.var_2303.var_11AC7,"aim");
		if(isdefined(self.var_1198.var_E5F9))
		{
			var_11 = 0;
		}
		else if(isdefined(self.var_1198.var_E5FF))
		{
			var_11 = 1;
		}

		if(var_11)
		{
			if(!self.var_2303.var_11B08.var_3140)
			{
				func_35A7();
			}

			if(isdefined(self.var_1198.var_E5FF))
			{
				if(!self.var_2303.var_11B08.var_30E6)
				{
					self.var_2303.var_11B08.var_30E6 = 1;
					thread lib_0C47::func_351B();
					func_3608(var_00,"main","hex",0);
				}
			}
			else if(isdefined(self.var_1198.var_FECD) && self.var_13C83["left"] || self.var_13C83["right"])
			{
				var_10.var_8E54 = self method_8102(var_00);
				var_10.var_AB57 = self method_8102(var_01);
				var_10.var_E530 = self method_8102(var_03);
				var_10.var_AB56 = self method_8102(var_02);
				var_10.var_E52F = self method_8102(var_04);
				var_12 = func_3522(var_10);
				self method_82A2(var_0C,1000,0.1,1);
				func_3607(var_00,var_10.var_8E54,"main","hex",var_12.var_8E55,6 * self.var_1A48);
				if(isdefined(var_12.var_AB57))
				{
					func_3607(var_01,var_10.var_AB57,"left","rail",var_12.var_AB57,8 * self.var_1A48);
				}

				if(isdefined(var_12.var_AB56))
				{
					func_3607(var_02,var_10.var_AB56,"left","pitch",var_12.var_AB56,8 * self.var_1A48);
				}

				if(isdefined(var_12.var_E530))
				{
					func_3607(var_03,var_10.var_E530,"right","rail",var_12.var_E530,8 * self.var_1A48);
				}

				if(isdefined(var_12.var_E52F))
				{
					func_3607(var_04,var_10.var_E52F,"right","pitch",var_12.var_E52F,8 * self.var_1A48);
				}

				if(isdefined(var_12.var_B7A9) && isdefined(var_12.var_B7A6))
				{
					var_13 = var_12.var_B7A9;
					var_14 = var_12.var_B7A6;
					var_15 = var_0D - var_13;
					var_16 = var_0E - var_14;
					if(var_15 > var_0F)
					{
						var_13 = var_0D - var_0F;
					}
					else if(var_15 < -1 * var_0F)
					{
						var_13 = var_0D + var_0F;
					}

					if(var_16 > var_0F)
					{
						var_14 = var_0E - var_0F;
					}
					else if(var_16 < -1 * var_0F)
					{
						var_14 = var_0E + var_0F;
					}

					func_360B(var_13,var_14,var_05,var_06,var_09,var_07,var_08,var_0A,var_0B);
					var_0D = var_12.var_B7A9;
					var_0E = var_12.var_B7A6;
				}
			}
			else
			{
				func_363C();
				var_0D = 0;
				var_0E = 0;
			}
		}
		else if(self.var_2303.var_11B08.var_3140)
		{
			func_3630();
			var_0D = 0;
			var_0E = 0;
			self.var_2303.var_11B08.var_3140 = 0;
		}

		wait(0.05);
	}
}

//Function Number: 50
func_FE84(param_00,param_01,param_02)
{
	self endon(param_01);
	wait(param_02);
	self notify(param_00);
}

//Function Number: 51
func_35D3(param_00,param_01,param_02)
{
	var_03 = param_00 + "_finished";
	var_04 = param_00 + "_waitfor_note";
	thread func_FE84(var_04,var_03,param_02);
	self endon(var_03);
	self endon(var_04);
	self waittillmatch(param_01,param_00);
}

//Function Number: 52
func_35D6(param_00,param_01,param_02,param_03)
{
	self endon(param_01 + "_finished");
	var_04 = lib_0A1E::func_2336(param_00,param_01);
	var_05 = self.var_1198.var_FECD;
	var_06 = self.var_164D[param_00].var_10307;
	var_07 = var_05.var_13CC3[var_06];
	self.var_164D[param_00].var_4C1A = var_07;
	if(var_06 == "left")
	{
		var_08 = self.var_F0C4;
	}
	else
	{
		var_08 = self.var_D8E1;
	}

	var_09 = var_07.var_C241;
	var_0A = [];
	if(isdefined(var_07.var_EF76))
	{
		foreach(var_0C in var_07.var_EF76)
		{
			var_0A[var_0A.size] = var_0C;
		}
	}
	else
	{
		var_0A[0] = var_07.var_65D3;
	}

	if(var_0A.size == 0)
	{
		wait(1);
		lib_0A1A::func_2330(param_01,"end");
		return;
	}

	var_0E = ["top","bottom"];
	if(isdefined(self.var_1198.var_EF3B))
	{
		var_0F = self.var_1198.var_EF3B[var_06 + "_arm"];
		if(isdefined(var_0F))
		{
			if(var_0F.var_10E19 == "dmg_upper")
			{
				var_0E = ["bottom"];
			}

			if(var_0F.var_10E19 == "dmg_lower")
			{
				var_0E = ["top"];
			}
		}
	}

	var_10 = getnotetracktimes(var_04,"fire");
	var_11 = var_10.size > 0;
	var_12 = lib_0C08::func_FE67(var_07,1);
	var_07.var_E5E0 = var_12;
	var_13 = [];
	foreach(var_15, var_0C in var_0A)
	{
		var_13[var_15] = var_0C.origin;
	}

	thread func_35E9(var_06,var_0E[0],var_12,var_07.var_DCE8 * var_09,param_01 + "_finished");
	self waittill("rocket_ready");
	self method_82EA(param_01,var_04,1,param_02,1);
	thread func_360F(param_01);
	var_16 = 0;
	var_17 = 0;
	while(var_16 < var_09)
	{
		if(isdefined(var_07.var_E5E0) || isdefined(var_0A[var_17]))
		{
			if(var_16 == 0)
			{
				if(var_16 < var_10.size)
				{
					func_35D3(param_01,"fire",1);
				}
				else
				{
					wait(0.1);
				}
			}
			else
			{
				wait(var_07.var_DCE8 / 1000);
			}

			var_18 = var_16 == 0;
			if(func_3615(var_06,var_07,var_18))
			{
				func_3509(var_07);
				break;
			}

			var_19 = int(var_16 / 4) % 2;
			var_1A = func_3593(var_06,var_0E[var_19]);
			var_1B = func_3592(var_06,var_0E[var_19]);
			var_1C = anglestoforward(var_1B);
			if(var_06 == "left")
			{
				var_1D = self.var_F0C4;
			}
			else
			{
				var_1D = self.var_D8E1;
			}

			if(scripts\sp\_utility::func_93A6() || level.var_7683 == 2 && isdefined(self.var_32D5) && self.var_32D5)
			{
				var_1D = "iw7_c12rocket_specialist_mode";
			}

			var_1E = magicbullet(var_1D,var_1A,var_13[var_17]);
			playfxontag(level.var_7649["muz_c12_rocket"],self,func_3594(var_06,var_0E[var_19]));
			if(isdefined(self.var_11B06))
			{
				func_362D(var_1E);
			}

			if(isdefined(var_07.var_E5E0))
			{
				var_1E.var_1155F = var_0A[var_17];
				var_1E missile_settargetpos(var_13[var_17]);
			}
			else if(isdefined(var_0A[var_17]))
			{
				var_1E.var_1155F = var_0A[var_17];
				var_1E missile_settargetent(var_0A[var_17]);
			}

			var_16++;
		}

		var_17 = var_17 + 1 % var_0A.size;
	}

	wait(3);
	lib_0A1A::func_2330(param_01,"end");
}

//Function Number: 53
func_3635(param_00,param_01,param_02)
{
	var_03 = 4;
	var_04 = 360 / var_03;
	var_05 = 45;
	var_06 = 9;
	var_07 = self gettagorigin(param_00);
	var_08 = self gettagangles(param_00);
	var_09 = invertangles(var_08);
	var_0A = combineangles(var_08,(0,0,-90 * 1 - param_02));
	for(var_0B = 0;var_0B < var_03;var_0B++)
	{
		var_0C = self.var_E5DB[var_0B];
		var_0D = var_0B + 0.5 * var_04;
		var_0E = var_06 * (0,cos(var_0D),sin(var_0D));
		var_0F = var_07 + rotatevector(var_0E,var_08);
		var_10 = var_05 * (-1 * sin(var_0D),cos(var_0D),0);
		var_11 = vectortoangles(param_01 - var_0F);
		var_12 = combineangles(var_09,var_11);
		var_13 = function_02EC(var_10,var_12,param_02);
		var_13 = combineangles(var_0A,var_13);
		var_0C.origin = var_0F;
		var_0C.angles = var_13;
	}
}

//Function Number: 54
func_35E9(param_00,param_01,param_02,param_03,param_04)
{
	self endon(param_04);
	var_05 = func_3594(param_00,param_01);
	var_06 = 4;
	var_07 = 360 / var_06;
	var_08 = 45;
	var_09 = 9;
	var_0A = 1;
	var_0B = param_03 / 1000;
	var_0C = var_0A + level.var_35EC + var_0B;
	function_0277("c12_rocket",var_0C,param_02,256,1);
	self notify("rocket_targeting");
	lib_0A16::func_17BA("targeting");
	self method_857A("target",param_02);
	self.var_E5DB = [];
	for(var_0D = 0;var_0D < var_06;var_0D++)
	{
		var_0E = spawn("script_model",(0,0,0));
		self.var_E5DB[var_0D] = var_0E;
		var_0E setmodel("tag_flash");
		var_0E method_81D6();
		var_0E method_831F(self);
		var_0E method_8575(self.var_F0C4);
	}

	func_3635(var_05,param_02,0);
	foreach(var_0E in self.var_E5DB)
	{
		var_0E linkto(self,var_05);
	}

	wait(var_0A);
	wait(level.var_35EC);
	self notify("rocket_ready");
	var_11 = int(var_0B * 20);
	while(var_11 > 0)
	{
		if(!isdefined(self.var_E5DB))
		{
			return;
		}

		var_11--;
		scripts\common\utility::func_136F7();
	}

	func_35EB();
}

//Function Number: 55
func_35EB()
{
	if(isdefined(self.var_E5DB))
	{
		self method_857A("none");
		foreach(var_01 in self.var_E5DB)
		{
			var_01 method_81D5();
			var_01 delete();
		}

		self.var_E5DB = undefined;
	}
}

//Function Number: 56
func_35EA(param_00)
{
	param_00.var_E5E0 = undefined;
	function_0278("c12_rocket");
	func_35EB();
}

//Function Number: 57
func_362D(param_00)
{
	if(!isdefined(self.var_6D6C))
	{
		self.var_6D6C = [];
	}

	var_01 = [];
	foreach(var_03 in self.var_6D6C)
	{
		if(!isdefined(var_03))
		{
			continue;
		}

		var_01[var_01.size] = var_03;
	}

	var_01[var_01.size] = param_00;
	self.var_6D6C = var_01;
	self notify("rocket_fired",param_00);
	var_01 = undefined;
}

//Function Number: 58
func_360F(param_00)
{
	self endon(param_00 + "_finished");
	for(;;)
	{
		self waittill(param_00,var_01);
		if(!isarray(var_01))
		{
			var_01 = [var_01];
		}

		foreach(var_03 in var_01)
		{
			if(var_03 == "end")
			{
				lib_0A1A::func_2330(param_00,var_03);
				return;
			}
		}
	}
}

//Function Number: 59
func_35D5(param_00,param_01,param_02,param_03)
{
	self endon(param_01 + "_finished");
	var_04 = lib_0A1E::func_2336(param_00,param_01);
	var_05 = self.var_1198.var_FECD;
	var_06 = self.var_164D[param_00].var_10307;
	var_07 = var_05.var_13CC3[var_06];
	var_08 = var_07.var_32BC;
	var_09 = var_07.var_DCE8;
	var_0A = 1.5;
	self method_82A2(var_04,1,param_02,var_0A);
	var_0B = lib_0A1E::func_2356(param_01,"recoil");
	self method_82A2(var_0B,1,param_02,1);
	var_0C = gettime();
	var_0D = var_0C;
	var_0E = var_0C + var_09;
	self.var_164D[param_00].var_4C1A = var_07;
	self playsound("weap_c12_minigun_spinup");
	self playloopsound("weap_c12_minigun_fire");
	var_0F = lib_0C08::func_9F7B(var_06);
	while(var_0C < var_08)
	{
		if(func_3615(var_06,var_07,var_0F))
		{
			func_3509(var_07);
			break;
		}

		if(var_0C >= var_0E)
		{
			if(lib_0C08::func_8BEC(var_07))
			{
				var_10 = var_08 - var_0C < 0.05;
				func_35C5(var_06,var_10,var_0F);
			}

			var_0E = var_0E + var_09;
		}

		wait(0.05);
		var_0C = gettime();
	}
}

//Function Number: 60
func_35C5(param_00,param_01,param_02)
{
	var_03 = undefined;
	if(param_00 == "left")
	{
		var_04 = self.var_F0C4;
		var_03 = "tag_weapon_rotate_le";
	}
	else
	{
		var_04 = self.var_D8E1;
		var_03 = "tag_weapon_rotate_ri";
	}

	var_05 = func_3587(param_00);
	var_06 = func_3585(param_00);
	var_07 = self.var_1198.var_FECD.var_13CC3[param_00];
	var_08 = 1;
	var_09 = 0;
	if(var_07.var_29A1 && !param_02)
	{
		var_0A = undefined;
		if(isdefined(var_07.var_65D3))
		{
			var_0A = var_07.var_65D3;
		}
		else if(isdefined(var_07.var_EF76))
		{
			var_0A = var_07.var_EF76[0];
		}

		self method_8494(var_04,var_05,var_06,var_08,var_0A,var_09,param_01,var_03);
		return;
	}

	var_0B = func_3595(param_00,param_02);
	var_0C = function_002C(var_05,var_0B,4);
	self method_8494(var_04,var_05,var_06,var_08,var_0C,var_09,param_01,var_03);
}

//Function Number: 61
func_3615(param_00,param_01,param_02)
{
	var_03 = self.var_1198.var_FECD;
	if(!isdefined(var_03))
	{
		return 1;
	}

	var_04 = var_03.var_13CC3[param_00];
	if(!isdefined(var_04))
	{
		return 1;
	}

	if(!lib_0C08::func_9F5B(param_00))
	{
		return 1;
	}

	if(var_04 != param_01)
	{
		return 1;
	}

	if(!isdefined(param_02))
	{
		param_02 = 0;
	}

	if(!param_02 && !var_04.var_312A)
	{
		return 1;
	}

	if(isdefined(self.var_9DD2) && self.var_9DD2)
	{
		return 1;
	}

	return 0;
}

//Function Number: 62
func_3509(param_00)
{
	param_00.var_2720 = 1;
}

//Function Number: 63
func_3612(param_00,param_01,param_02)
{
	var_03 = lib_0A1E::func_2356(param_01,"loop");
	var_04 = lib_0A1E::func_2356(param_01,"recoil_knob");
	self method_806F(var_03,0.2);
	self method_806F(var_04,0.2);
	self method_837D();
	self stoploopsound();
	self playsound("weap_c12_minigun_release");
	var_05 = self.var_164D[param_00].var_4C1A;
	var_06 = self.var_164D[param_00].var_10307;
	if(isdefined(self.var_EF6F) && isdefined(var_05.var_EF76))
	{
		self notify(var_05.var_EF6F);
	}

	self.var_164D[param_00].var_4C1A = undefined;
}

//Function Number: 64
func_3613(param_00,param_01,param_02)
{
	var_03 = lib_0A1E::func_2356(param_01,"shoot_knob");
	self method_806F(var_03,0.2);
	var_04 = self.var_164D[param_00].var_10307;
	lib_0A1A::func_232F("rocket_shoot_complete",var_04);
	var_05 = self.var_164D[param_00].var_4C1A;
	if(isdefined(var_05.var_EF77))
	{
		self notify(var_05.var_EF77);
	}

	self.var_164D[param_00].var_4C1A = undefined;
	func_35EA(var_05);
}

//Function Number: 65
func_35D4(param_00,param_01,param_02,param_03)
{
}

//Function Number: 66
func_3526(param_00,param_01,param_02,param_03)
{
	var_04 = self.var_1198.var_FECD;
	var_05 = self.var_164D[param_00].var_10307;
	var_06 = var_04.var_13CC3[var_05];
	if(var_06.var_C241 == 1)
	{
		var_07 = var_05 + "_1";
	}
	else
	{
		var_07 = var_06 + "_4";
	}

	return lib_0A1E::func_2356(param_01,var_07);
}

//Function Number: 67
func_3525(param_00,param_01,param_02,param_03)
{
	var_04 = lib_0A1E::func_2356(param_01,"loop");
	return var_04;
}

//Function Number: 68
func_3547(param_00,param_01)
{
}