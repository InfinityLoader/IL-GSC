/*******************************************************************
 * Decompiled By: Bog
 * Decompiled File: 1371.gsc
 * Game: Call of Duty: WWII
 * Platform: PC
 * Function Count: 56
 * Decompile Time: 76 ms
 * Timestamp: 10/27/2023 3:25:50 AM
*******************************************************************/

//Function Number: 1
func_00D5()
{
	if(!isdefined(level.scaretable))
	{
		level.scaretable = "mp/zombieJumpScareTable.csv";
	}

	var_00 = getentarray("zombie_fall_ambush","targetname");
	setdvarifuninitialized("drop_js_lead_time",-1);
	setdvarifuninitialized("drop_js_cam_jump",-1);
	setdvarifuninitialized("drop_js_cam_jump_need_look",-1);
	setdvarifuninitialized("drop_js_debug",-1);
	setdvarifuninitialized("drop_js_height",-1);
	setdvarifuninitialized("drop_js_affect_all_players",-1);
	setdvarifuninitialized("drop_js_fall_quicker",-1);
	setdvarifuninitialized("drop_js_dist",-1);
	foreach(var_02 in var_00)
	{
		var_02 thread func_347E();
	}

	level.var_2F29 = 0;
	var_04 = getentarray("valve","script_noteworthy");
	func_AA30(var_04);
}

//Function Number: 2
func_AA36(param_00)
{
	self.var_75F0 = param_00;
	foreach(var_02 in self.var_75EF)
	{
		setnavlinkenabled(var_02,param_00);
	}
}

//Function Number: 3
func_AA35(param_00,param_01,param_02)
{
	func_AA36(1);
	var_03 = 10;
	var_04 = 30;
	var_05 = 0.5;
	var_06 = 15;
	var_07 = 75;
	var_08 = 1;
	var_09 = self.var_5978;
	if(isdefined(self.var_AA3B) || isdefined(self.var_AA39))
	{
		if(isdefined(self.var_AA3B))
		{
			var_08 = function_01CB(self.var_AA3B);
			var_09 = getglassorigin(self.var_AA3B);
		}
		else if(isdefined(self.var_AA39))
		{
			var_09 = self.var_AA39.var_116;
		}

		if(isdefined(self.var_AA39))
		{
			self.var_AA39 delete();
			physicsexplosionsphere(var_09,var_04,var_03,var_05);
			if(isdefined(self.var_AA3A))
			{
				foreach(var_0B in self.var_AA3A)
				{
					var_0B delete();
				}
			}
		}

		glassradiusdamage(var_09,var_04,var_07,var_06);
	}

	param_01 lib_0378::func_8D74("window_jumpscare",param_00,self.var_5978,var_08);
	if(param_02)
	{
		param_01 thread func_598A();
		param_01 setangles(vectortoangles(self.var_5978 - param_01 geteye()));
	}
}

//Function Number: 4
func_AA33(param_00,param_01,param_02,param_03)
{
	var_04 = self;
	switch(param_00)
	{
		case "breach":
			var_04.var_186 func_AA35(var_04,var_04.var_5979,var_04.var_597A);
			break;
	}
}

//Function Number: 5
func_AA34(param_00)
{
	self endon("death");
	var_01 = 0.2;
	wait(param_00 - var_01);
	maps/mp/agents/_scripted_agent_anim_util::func_8732(0,"ZomWindowScare");
	self scragentsetscripted(0);
	self method_839D("gravity");
}

//Function Number: 6
func_AA2E(param_00,param_01)
{
	func_5976(param_00);
	var_02 = lib_054D::func_90BA("zombie_generic",self,"window jumpscare",0,1,1);
	var_03 = self.var_8109;
	var_04 = var_02 maps/mp/agents/_scripted_agent_anim_util::func_434D(var_03);
	var_02.var_5979 = param_00;
	var_02.var_597A = param_01;
	var_02 thread maps/mp/agents/humanoid/_humanoid_util::func_8318(var_02.var_116,var_02.var_1D,var_04,undefined,1,::func_AA33,1);
	var_05 = common_scripts\utility::func_46B7("window_shatter","targetname");
	var_06 = undefined;
	foreach(var_08 in var_05)
	{
		if(distance(var_02.var_116,var_08.var_116) <= 100)
		{
			if(isdefined(self.var_AA3B) && !function_01CB(self.var_AA3B))
			{
				playfx(level.var_611["zmb_window_shatter_01"],var_08.var_116,anglestoforward(var_08.var_1D));
				var_06 = var_08.var_116;
			}

			break;
		}
	}
}

//Function Number: 7
func_8CAA(param_00)
{
	if(!isdefined(param_00))
	{
		return;
	}

	var_01 = anglestoforward(self.var_1D);
	var_02 = vectorcross(var_01,param_00);
	if(var_02[2] > 0)
	{
		var_03 = 1;
	}
	else
	{
		var_03 = -1;
	}

	for(;;)
	{
		var_01 = rotatevector(var_01,(0,0,5 * var_03));
		self setangles(vectortoangles(var_01));
		wait 0.05;
	}
}

//Function Number: 8
func_5987()
{
	if(isdefined(self.var_117))
	{
		self.var_117.var_5986 = undefined;
	}

	self.var_CA5 = 1;
	if(isdefined(self.var_1A5))
	{
		if(self.var_1A5 == "sewage_jumpscare")
		{
			self delete();
		}
	}

	if(isdefined(self.var_AA3B) || isdefined(self.var_AA39))
	{
		wait(30);
		if(isdefined(self.var_AA3B))
		{
			deleteglass(self.var_AA3B);
			self.var_AA3B = undefined;
		}

		if(isdefined(self.var_AA39))
		{
			self.var_AA39 delete();
			self.var_AA39 = undefined;
		}
	}
}

//Function Number: 9
func_AA2F(param_00)
{
	var_01 = self.var_5978 - param_00 geteye();
	var_02 = vectornormalize((var_01[0],var_01[1],0));
	var_03 = anglestoforward(param_00.var_1D);
	var_04 = vectornormalize((var_03[0],var_03[1],0));
	var_05 = vectordot(var_02,var_04);
	var_05 = clamp(var_05,-1,1);
	var_06 = acos(var_05);
	return var_06;
}

//Function Number: 10
func_AA31(param_00)
{
	var_01 = param_00 < 40;
	return var_01;
}

//Function Number: 11
func_AA32(param_00)
{
	var_01 = func_AA2F(param_00);
	var_02 = func_AA31(var_01);
	return var_02;
}

//Function Number: 12
func_AA30(param_00)
{
	var_01 = common_scripts\utility::func_46B7("jumpscare_spawner","targetname");
	foreach(var_03 in var_01)
	{
		var_04 = common_scripts\utility::func_4461(var_03.var_116,param_00);
		if(isdefined(var_04))
		{
			if(distance(var_04.var_116,var_03.var_116) > 100)
			{
				var_04 = undefined;
			}
			else
			{
				param_00 = common_scripts\utility::func_F93(param_00,var_03);
				var_04.var_5986 = var_03;
				var_03.var_117 = var_04;
			}
		}

		var_05 = getnodesinradius(var_03.var_116,90,0,90);
		var_03.var_75EF = [];
		foreach(var_07 in var_05)
		{
			if(lib_0547::func_55C2(var_07))
			{
				var_03.var_75EF[var_03.var_75EF.size] = var_07;
			}
		}

		var_03 func_AA36(0);
		var_09 = getent(var_03.var_1A2,"targetname");
		if(isdefined(var_09) && isdefined(var_09.var_165) && var_09.var_165 == "js_trigger")
		{
			var_03.var_597B = var_09;
		}

		var_0A = common_scripts\utility::func_46B5(var_03.var_1A2,"targetname");
		if(isdefined(var_0A))
		{
			var_03.var_5978 = var_0A.var_116;
		}
		else
		{
			var_03.var_5978 = var_03.var_116;
		}

		var_0B = getglassarray("window_shatter");
		if(isdefined(var_0B))
		{
			foreach(var_0D in var_0B)
			{
				var_0E = getglassorigin(var_0D);
				if(distancesquared(var_03.var_116,var_0E) <= 10000)
				{
					var_03.var_AA3B = var_0D;
					break;
				}
			}
		}

		var_10 = getentarray("window_shatter","targetname");
		if(isdefined(var_10))
		{
			foreach(var_12 in var_10)
			{
				if(var_12.var_3A == "script_model" && distancesquared(var_03.var_116,var_12.var_116) <= 10000)
				{
					var_03.var_AA39 = var_12;
					if(isdefined(var_12.var_1A2))
					{
						var_03.var_AA3A = getentarray(var_12.var_1A2,"targetname");
					}

					break;
				}
			}
		}

		if(isdefined(var_03.var_117))
		{
			var_03 thread func_AA37();
			continue;
		}

		if(isdefined(var_03.var_597B))
		{
			var_03 thread func_681B();
		}
	}
}

//Function Number: 13
func_52E5(param_00,param_01)
{
	if(!isdefined(param_00.var_5988))
	{
		param_00.var_5988 = [];
	}

	if(!isdefined(param_00.var_5988[param_01]))
	{
		param_00.var_5988[param_01] = 0;
	}
}

//Function Number: 14
func_42A1(param_00,param_01)
{
	func_52E5(param_00,param_01);
	return param_00.var_5988[param_01];
}

//Function Number: 15
is_jumpscare_playerdata_disabled()
{
	var_00 = common_scripts\utility::func_562E(level.disable_jumpscare_playerdata);
	return var_00;
}

//Function Number: 16
func_42A0(param_00,param_01)
{
	if(is_jumpscare_playerdata_disabled())
	{
		return 0;
	}

	var_02 = param_00 getrankedplayerdata(common_scripts\utility::func_46A8(),"jumpScareTimesSeen",param_01);
	return var_02;
}

//Function Number: 17
func_50F5(param_00,param_01)
{
	func_52E5(param_00,param_01);
	param_00.var_5988[param_01]++;
}

//Function Number: 18
func_50F4(param_00,param_01)
{
	if(is_jumpscare_playerdata_disabled())
	{
		return;
	}

	var_02 = param_00 getrankedplayerdata(common_scripts\utility::func_46A8(),"jumpScareTimesSeen",param_01);
	var_02++;
	param_00.var_598C++;
	if(var_02 <= 255)
	{
		param_00 setrankedplayerdata(common_scripts\utility::func_46A8(),"jumpScareTimesSeen",param_01,var_02);
	}
}

//Function Number: 19
func_178C(param_00,param_01,param_02,param_03)
{
	return common_scripts\utility::func_5D93(param_03,0,param_01,param_00,param_02);
}

//Function Number: 20
func_5977(param_00)
{
	var_01 = func_41E1();
	var_02 = level.scaretable;
	var_03 = float(tablelookup(var_02,0,var_01,1));
	var_04 = float(tablelookup(var_02,0,var_01,2));
	var_05 = float(tablelookup(var_02,0,var_01,3));
	var_06 = float(tablelookup(var_02,0,var_01,4));
	var_07 = float(tablelookup(var_02,0,var_01,5));
	var_08 = func_42A0(param_00,var_01);
	var_09 = func_42A1(param_00,var_01);
	var_0A = func_178C(var_03,var_06,var_07,var_08);
	var_0B = func_178C(var_0A,var_04,var_05,var_09);
	var_0C = randomfloat(1);
	if(var_0C < var_03)
	{
		var_0D = 1;
	}
	else
	{
		var_0D = 0;
	}

	var_0E = 0;
	if(isdefined(level.zmb_jumpscares_optional_cooldown_override))
	{
		var_0F = level.zmb_jumpscares_optional_cooldown_override;
	}
	else
	{
		var_0F = 10;
	}

	if(isdefined(level.var_5B2D) && gettime() - level.var_5B2D < 1000 * var_0F)
	{
		var_0E = 1;
		var_0D = 0;
	}

	if(isdefined(self.var_8FA9) && self.var_8FA9 == "force_scare_always")
	{
		var_0D = 1;
	}

	if(common_scripts\utility::func_562E(param_00.var_569F))
	{
		var_0D = 0;
	}

	var_11 = lib_0547::func_AC4B(param_00.var_116,"jumpscare_roll");
	var_11 lib_0547::func_AC47(param_00);
	var_11 lib_0547::func_AC48("type",var_01);
	var_11 lib_0547::func_AC43("chance",var_0B);
	var_11 lib_0547::func_AC42("execute",var_0D);
	var_11 lib_0547::func_AC4D();
	return var_0D;
}

//Function Number: 21
set_optional_new_cooldown()
{
	if(!isdefined(level.zmb_jumpscares_optional_cooldown_override_range))
	{
		return;
	}

	level.zmb_jumpscares_optional_cooldown_override = 60 * randomintrange(level.zmb_jumpscares_optional_cooldown_override_range[0],level.zmb_jumpscares_optional_cooldown_override_range[1]);
}

//Function Number: 22
func_5976(param_00)
{
	level.var_5B2D = gettime();
	set_optional_new_cooldown();
	var_01 = func_41E1();
	func_50F5(param_00,var_01);
	func_50F4(param_00,var_01);
	var_02 = lib_0547::func_AC4B(param_00.var_116,"jumpscare");
	var_02 lib_0547::func_AC47(param_00);
	var_02 lib_0547::func_AC48("type",var_01);
	var_02 lib_0547::func_AC4D();
}

//Function Number: 23
func_681B()
{
	level endon("game_ended");
	func_84F0("window_no_valve");
	var_00 = 0;
	for(;;)
	{
		self.var_597B waittill("trigger",var_01);
		if(!isplayer(var_01))
		{
			continue;
		}

		var_02 = func_5977(var_01);
		if(!var_02)
		{
			wait(1);
			continue;
		}

		if(func_AA32(var_01))
		{
			thread func_AA2E(var_01,0);
			if(var_00 == 0)
			{
				func_5987();
			}
			else
			{
				wait(var_00);
			}
		}

		if(common_scripts\utility::func_562E(self.var_CA5))
		{
			break;
		}

		wait 0.05;
	}
}

//Function Number: 24
func_AA37()
{
	self endon("valve_complete");
	func_84F0("window_valve");
	var_00 = 0;
	for(;;)
	{
		self waittill("valve_start",var_01);
		self.var_6DB0 = "started";
		var_02 = func_5977(var_01);
		wait(1.5);
		for(;;)
		{
			if(self.var_6DB0 == "stopped")
			{
				break;
			}

			if(var_02 && func_AA32(var_01))
			{
				thread func_AA2E(var_01,1);
				if(var_00 == 0)
				{
					func_5987();
				}
				else
				{
					wait(var_00);
				}
			}

			if(common_scripts\utility::func_562E(self.var_CA5))
			{
				break;
			}

			wait 0.05;
		}

		if(common_scripts\utility::func_562E(self.var_CA5))
		{
			break;
		}
	}
}

//Function Number: 25
func_5989()
{
	self.var_6DB0 = "stopped";
}

//Function Number: 26
func_598A()
{
	self playrumbleonentity("grenade_rumble");
	earthquake(0.2,1.5,self.var_116,850,self);
}

//Function Number: 27
func_8A74()
{
	self endon("end_jumpscare");
	func_84F0("sewer_grate");
	thread func_8A71();
	self.var_CA5 = 0;
	var_00 = 0;
	var_01 = common_scripts\utility::func_44BE(self.var_1A2,"targetname");
	foreach(var_03 in var_01)
	{
		if(!isdefined(var_03.var_165))
		{
			var_03.var_165 = "spawner";
		}

		switch(var_03.var_165)
		{
			case "spawner":
				self.var_186 = var_03;
				break;

			case "lookat_pos":
				self.var_5EC8 = var_03;
				break;
		}
	}

	if(isdefined(self.var_5EC8))
	{
		self.var_5978 = self.var_5EC8.var_116;
	}
	else
	{
		self.var_5978 = self.var_116;
	}

	if(!isdefined(self.var_186))
	{
		return;
	}

	for(;;)
	{
		self waittill("trigger",var_05);
		if(!isplayer(var_05))
		{
			continue;
		}

		if(!func_5977(var_05))
		{
			wait(1);
			continue;
		}

		var_06 = var_05 geteye();
		var_07 = var_05 geteyeangles();
		var_08 = anglestoforward(var_07);
		var_09 = vectornormalize(self.var_5978 - var_06);
		if(vectordot(var_08,var_09) > 0.766)
		{
			thread func_8A72(var_05,self.var_116,self.var_1D);
			if(var_00 == 0)
			{
				self notify("end_jumpscare");
				break;
			}
			else
			{
				wait(var_00);
			}

			continue;
		}

		wait 0.05;
	}
}

//Function Number: 28
func_8A71()
{
	self waittill("end_jumpscare");
	func_5987();
}

//Function Number: 29
func_8A72(param_00,param_01,param_02)
{
	func_5976(param_00);
	var_03 = 100;
	var_04 = lib_054D::func_90BA("zombie_generic",undefined,"sewage jumpscare",0,1,1);
	var_05 = "s2_grate_jumpscare";
	var_06 = var_04 method_83D8(var_05,0);
	var_07 = getanimlength(var_06);
	var_08 = getstartorigin(param_01,param_02,var_06);
	var_09 = getstartangles(param_01,param_02,var_06);
	var_04 setorigin(var_08);
	var_04.var_FB = int(var_04.var_FB * var_03);
	var_04.var_BC = var_04.var_FB;
	var_04 childthread lib_0547::func_AB18(var_07,1);
	var_04 thread maps/mp/agents/humanoid/_humanoid_util::func_8318(var_08,var_09,var_05,undefined,0,undefined,1);
	var_0A = param_01 + (0,0,-30);
	param_00 lib_0378::func_8D74("sewage_jumpscare",var_04,var_0A);
	var_04 maps/mp/agents/_scripted_agent_anim_util::func_A79F("scripted_anim","cam_shake");
	var_0B = var_0A - param_00 geteye();
	param_00 setangles(vectortoangles(var_0B));
	param_00 thread func_598A();
}

//Function Number: 30
func_8A73()
{
	self endon("end_jumpscare");
	self method_805C();
	for(;;)
	{
		self waittill("trigger",var_00);
		if(!isplayer(var_00))
		{
			continue;
		}

		var_01 = getentarray(self.var_1A5,"script_noteworthy");
		foreach(var_03 in var_01)
		{
			var_03 notify("end_jumpscare");
		}

		break;
	}
}

//Function Number: 31
func_9053(param_00,param_01)
{
	func_84F0(param_00);
	foreach(var_03 in common_scripts\utility::func_44BE(self.var_1A2,"targetname"))
	{
		if(!isdefined(var_03.var_165))
		{
			var_03.var_165 = "spawner";
		}

		switch(var_03.var_165)
		{
			case "spawner":
				self.var_873 = var_03.var_8260;
				self.var_8FA9 = var_03.var_81C7;
				self.var_186 = var_03;
				self.var_606E = var_03.var_818A;
				break;

			case "breach_destructible":
				self.var_1B83 = var_03;
				break;

			case "ideal_player_pos":
				self.var_502E = var_03;
				break;

			case "ideal_zombie_pos":
				self.var_502F = var_03;
				break;

			case "lookat_pos":
				self.var_5EC8 = var_03;
				break;
		}
	}

	if(!isdefined(self.var_873) || !isdefined(self.var_186) || !isdefined(self.var_502E) || !isdefined(self.var_502E.var_8276) || !isdefined(self.var_502E.var_82E5) || !isdefined(self.var_502F) || !isdefined(self.var_5EC8) || !isdefined(self.var_5EC8.var_8276))
	{
		return;
	}

	if(!isdefined(self.var_606E))
	{
		self.var_606E = 0;
	}

	self.var_CA5 = 0;
	for(;;)
	{
		if(isdefined(self.var_81A1))
		{
			common_scripts\utility::func_3C9F(self.var_81A1);
		}

		self waittill("trigger",var_05);
		if(!isplayer(var_05))
		{
			continue;
		}

		if(isdefined(self.var_81A1) && !common_scripts\utility::func_3C77(self.var_81A1))
		{
			continue;
		}

		while(isdefined(var_05) && var_05 istouching(self))
		{
			var_06 = var_05 getvelocity();
			var_07 = var_05 geteye() + self.var_502E.var_82E5 * var_06;
			if(self.var_606E > 0)
			{
				var_08 = vectortoangles(self.var_502E.var_116 - self.var_186.var_116)[1];
				var_09 = vectortoangles(var_07 - self.var_186.var_116)[1];
				var_0A = angleclamp180(var_09 - var_08);
				var_0A = clamp(var_0A,0 - self.var_606E,self.var_606E);
				var_0B = transformmove(self.var_186.var_116,(0,var_0A,0),self.var_186.var_116,(0,0,0),self.var_5EC8.var_116,self.var_5EC8.var_1D)["origin"];
				var_0C = transformmove(self.var_186.var_116,(0,var_0A,0),self.var_186.var_116,(0,0,0),self.var_502E.var_116,self.var_502E.var_1D)["origin"];
			}
			else
			{
				var_0A = 0;
				var_0B = self.var_5EC8.var_116;
				var_0C = self.var_502E.var_116;
			}

			var_0D = distance2d(var_07,var_0C);
			if(var_0D < self.var_502E.var_8276 && vectordot(vectornormalize(var_06),vectornormalize(var_0B - var_0C)) > 0.5)
			{
				var_10 = var_05 geteye() + self.var_502E.var_82E5 + 0.05 * var_06;
				var_11 = distance2d(var_10,var_0C);
				if(var_0D <= var_11)
				{
					var_12 = anglestoforward(var_05 geteyeangles());
					if(lib_0547::func_3048(var_0B,var_07,var_07 + 9999 * var_12) < self.var_5EC8.var_8276 && vectordot(var_12,var_0B - var_07) > 0)
					{
						var_13 = 0;
						foreach(var_15 in level.var_744A)
						{
							if(var_15 != var_05)
							{
								var_16 = var_15 geteye();
								if(distance(var_16,var_0C) < 195 || vectordot(vectornormalize(var_0C - var_16),anglestoforward(var_15 geteyeangles())) > 0 && sighttracepassed(var_16,var_0C + (0,0,60),0,undefined) || sighttracepassed(var_16,self.var_186.var_116,0,undefined))
								{
									var_13 = 1;
									break;
								}
							}
						}

						if(!var_13 && func_5977(var_05))
						{
							thread func_9052(param_01,var_05,var_0A);
							var_18 = 0;
							if(var_18)
							{
								wait(var_18);
							}
							else
							{
								self.var_CA2 = 1;
								return;
							}
						}
						else
						{
							while(isdefined(var_05) && var_05 istouching(self))
							{
								wait(1);
							}
						}
					}
				}
			}

			wait 0.05;
		}
	}
}

//Function Number: 32
func_9052(param_00,param_01,param_02)
{
	func_5976(param_01);
	var_03 = lib_054D::func_90BA("zombie_generic",self.var_186,"jumpscare: " + func_41E1(),0,1,1);
	param_01 lib_0378::func_8D74("simple_jump_scare",var_03);
	var_03.var_5979 = param_01;
	var_03.var_597A = 0;
	level notify("jumpscare_triggered",param_01,var_03);
	var_03 thread func_4A11(self,param_01,param_02);
	param_01 thread func_598A();
	if(isdefined(param_00))
	{
		var_03 thread [[ param_00 ]]();
	}

	if(isdefined(self.var_1B83))
	{
		var_03 thread func_4A12(self.var_1B83);
	}
}

//Function Number: 33
func_4A11(param_00,param_01,param_02)
{
	self.var_116 = param_00.var_186.var_116;
	self.var_1D = param_00.var_186.var_1D + (0,param_02,0);
	self scragentsetscripted(1);
	maps/mp/agents/_scripted_agent_anim_util::func_8732(1,"handle_js_lerp");
	self.var_53D9 = 1;
	self method_839C("anim deltas");
	self scragentsetorientmode("face angle abs",param_00.var_186.var_1D);
	self method_839A(1,1);
	self method_839D("noclip");
	var_03 = maps/mp/agents/_scripted_agent_anim_util::func_434D(param_00.var_873);
	var_04 = maps/mp/agents/_scripted_agent_anim_util::func_7A35(var_03);
	var_05 = self method_83D8(var_03,var_04);
	maps/mp/agents/_scripted_agent_anim_util::func_8415(var_03,var_04);
	var_06 = getanimlength(var_05);
	var_07 = maps/mp/agents/_scripted_agent_anim_util::func_45B9(var_05,"lerp_origin_begin",2);
	var_08 = maps/mp/agents/_scripted_agent_anim_util::func_45B9(var_05,"lerp_origin_end",2);
	var_09 = maps/mp/agents/_scripted_agent_anim_util::func_45B9(var_05,"lerp_angles_begin",2);
	var_0A = maps/mp/agents/_scripted_agent_anim_util::func_45B9(var_05,"lerp_angles_end",2);
	var_0B = maps/mp/agents/_scripted_agent_anim_util::func_45B9(var_05,"code_move",clamp(var_06 - 0.2 / var_06,0,1)) * var_06;
	var_0C = undefined;
	var_0D = 0;
	var_0E = 0;
	var_0F = param_00.var_502E.var_116;
	var_10 = param_00.var_502E.var_1D;
	var_11 = 0;
	while(var_11 < var_0B && isalive(self))
	{
		waittillframeend;
		var_12 = clamp(var_11 - 0.05 / var_06,0,1);
		var_13 = var_11 / var_06;
		if(isalive(param_01))
		{
			var_0F = param_01.var_116;
			var_10 = param_01.var_1D;
		}

		var_14 = transformmove(param_00.var_186.var_116,param_00.var_186.var_1D,(0,0,0),(0,0,0),getmovedelta(var_05,0,var_13),getangledelta3d(var_05,0,var_13));
		var_15 = transformmove(param_01.var_116,param_01.var_1D,param_00.var_502E.var_116,param_00.var_502E.var_1D,var_14["origin"],var_14["angles"]);
		if(!isdefined(var_0C))
		{
			var_0C = param_00.var_186 common_scripts\utility::func_8FFC();
			var_0C method_805C();
		}

		var_0C.var_116 = var_15["origin"];
		var_0C.var_1D = var_15["angles"];
		if(!self.var_D7)
		{
			var_0D = 1;
		}

		var_16 = var_13 >= var_07 && var_13 < var_08 && var_0D && isalive(param_01);
		var_17 = var_13 >= var_09 && var_13 < var_0A && var_0D && isalive(param_01);
		if(var_0D && abs(getmovedelta(var_05,var_12,var_13)[2]) < 1 && var_16 || var_17)
		{
			self method_839D("gravity");
			var_0E = 1;
		}

		if(!var_0E)
		{
			var_16 = 0;
			var_17 = 0;
		}

		if(var_16)
		{
			var_18 = 1;
		}
		else
		{
			var_18 = 9999;
		}

		if(var_17)
		{
			var_19 = 0.1;
		}
		else
		{
			var_19 = 9999;
		}

		self method_855A(var_18,var_19,var_0C,"tag_origin","tag_origin");
		wait 0.05;
		var_11 = var_11 + 0.05;
	}

	if(isalive(self))
	{
		maps/mp/agents/_scripted_agent_anim_util::func_8732(0,"handle_js_lerp");
		self.var_53D9 = undefined;
		lib_0547::func_84CB();
		self scragentsetscripted(0);
	}

	var_0C delete();
}

//Function Number: 34
func_4A12(param_00)
{
	self endon("death");
	self waittillmatch("breach","scripted_anim");
	param_00 setmodel(param_00.var_8260);
	wait 0.05;
	physicsexplosionsphere(self.var_116 + (0,0,32),128,64,0.0001,0);
}

//Function Number: 35
func_3D86()
{
	func_9053("floor",::func_3D87);
}

//Function Number: 36
func_3D87()
{
	playfx(level.var_611["zmb_jump_scare_ground_snow"],self.var_116 + (0,0,64));
}

//Function Number: 37
func_3266()
{
	func_9053("door",undefined);
}

//Function Number: 38
func_1D91()
{
	func_9053("bunker_drop",undefined);
}

//Function Number: 39
func_1DA1()
{
	func_9053("bunker_window",undefined);
}

//Function Number: 40
sidestep_js_thinker()
{
	func_9053("sidestep",undefined);
}

//Function Number: 41
sidestep_left_js_thinker()
{
	func_9053("sidestep_left",undefined);
}

//Function Number: 42
func_347E()
{
	func_84F0("drop");
	self.var_72E2 = undefined;
	self.var_3A14 = [];
	self.var_3A10 = 300;
	self.var_5C38 = 0.8;
	self.var_61A4 = 120;
	self.var_1E8F = 0;
	self.var_1E90 = 1;
	self.var_5974 = 150;
	self.var_A30 = 1;
	self.var_3A13 = 1;
	var_00 = common_scripts\utility::func_46B7(self.var_1A2,"targetname");
	var_01 = undefined;
	foreach(var_03 in var_00)
	{
		var_04 = 0;
		if(isdefined(var_03.var_165))
		{
			switch(var_03.var_165)
			{
				case "zombie_sky_spawner":
					if(isdefined(var_03.var_81E1))
					{
						self.var_3A14[var_03.var_81E1] = var_03;
						var_01 = 1;
						var_03.var_8FCA = var_03.var_81E1;
					}
					else
					{
						var_01 = 0;
						var_03.var_8FCA = self.var_3A14.size;
						self.var_3A14[self.var_3A14.size] = var_03;
					}
	
					var_05 = lib_0547::func_4282(var_03);
					var_06 = var_05["height"];
					if(isdefined(var_06))
					{
						var_03.var_3A10 = int(var_06);
					}
	
					var_06 = var_05["impact_delay"];
					if(isdefined(var_06))
					{
						var_03.var_50B1 = float(var_06);
					}
	
					var_03.var_873 = var_03.var_8109;
					var_04 = 1;
					break;

				case "player_line":
					self.var_72E2 = var_03;
					var_04 = 1;
					break;

				case "lookat_target":
					self.var_5ECA = var_03;
					self.var_5978 = var_03.var_116;
					var_04 = 1;
					break;
			}
		}
	}

	if(!isdefined(self.var_72E2) || self.var_3A14.size == 0)
	{
		return;
	}

	thread lib_0547::func_AC0D(self.var_3A14,"Drop Jumpscare");
	thread func_347F();
}

//Function Number: 43
func_347F()
{
	var_00 = anglestoaxis(self.var_72E2.var_1D);
	for(;;)
	{
		if(isdefined(self.var_81A1))
		{
			common_scripts\utility::func_3C9F(self.var_81A1);
		}

		self waittill("trigger",var_01);
		if(isdefined(self.var_81A1) && !common_scripts\utility::func_3C77(self.var_81A1))
		{
			continue;
		}

		if(!isdefined(var_01) || !isplayer(var_01))
		{
			continue;
		}

		var_05 = 0;
		var_06 = var_01 getvelocity();
		var_07 = self.var_72E2.var_116 - var_01.var_116;
		var_08 = undefined;
		var_0D = vectordot(var_07,var_00["forward"]);
		if(var_0D < 0)
		{
			continue;
		}

		if(var_0D < self.var_61A4)
		{
			var_05 = 1;
		}

		var_0E = vectordot(var_06,var_00["forward"]);
		if(var_0E > 0)
		{
			var_0F = var_0D / var_0E;
			if(var_0F < self.var_5C38)
			{
				var_08 = gettime() + var_0F * 1000;
				var_05 = 1;
			}
		}

		if(var_05)
		{
			if(func_5977(var_01) && isdefined(level.var_2F29) && level.var_2F29 != 1)
			{
				func_347D(var_01,var_08);
			}

			return;
		}
	}
}

//Function Number: 44
func_347D(param_00,param_01)
{
	func_5976(param_00);
	for(var_03 = 0;var_03 < self.var_3A14.size;var_03++)
	{
		var_04 = self.var_3A14[var_03];
		thread func_347C(var_04,param_01,param_00);
	}
}

//Function Number: 45
func_347C(param_00,param_01,param_02)
{
	var_03 = undefined;
	var_04 = 0.2 * param_00.var_8FCA;
	wait(var_04);
	if(self.var_3A13 && isdefined(param_01))
	{
		if(isdefined(param_00.var_50B1))
		{
			var_03 = param_01 + param_00.var_50B1 * 1000;
		}
		else
		{
			var_03 = param_01 + var_04;
		}
	}

	var_05 = lib_054D::func_90BA("zombie_generic",param_00,"drop scare",0,1,1);
	if(param_00.var_8FCA == 0)
	{
		thread func_347B(var_05,param_02);
	}

	var_06 = self.var_3A10;
	if(isdefined(param_00.var_3A10))
	{
		var_06 = max(var_06,param_00.var_3A10);
	}

	var_05 thread lib_0540::func_ABA4(param_00.var_116,param_00.var_1D,var_06,param_00.var_873,param_00,var_03);
}

//Function Number: 46
func_347B(param_00,param_01)
{
	param_00 endon("death");
	param_00 waittill("zombie_fall_impact");
	var_02 = [param_01];
	if(common_scripts\utility::func_562E(self.var_A30))
	{
		var_02 = level.var_744A;
	}

	if(!isdefined(self.var_5ECA))
	{
		self.var_5978 = param_00 gettagorigin("J_Knee_RI");
	}

	foreach(var_05 in var_02)
	{
		if(!maps\mp\_utility::func_57A0(var_05) || !self istouching(var_05) && distance2d(var_05.var_116,self.var_5978) > self.var_5974)
		{
			continue;
		}

		var_05 lib_0378::func_8D74("fall_jumpscare",param_00,self);
		if(self.var_1E8F)
		{
			var_08 = 1;
			if(self.var_1E90)
			{
				var_08 = func_AA32(var_05);
			}

			if(var_08)
			{
				var_09 = self.var_5978 - var_05 geteye();
				var_05 setangles(vectortoangles(var_09));
				var_05 thread func_598A();
			}
		}
	}
}

//Function Number: 47
waittill_jumpscare_initialized()
{
	while(!isdefined(level.scaretable))
	{
		wait 0.05;
	}
}

//Function Number: 48
func_84F0(param_00)
{
	var_01 = level.scaretable;
	self.var_598B = param_00;
}

//Function Number: 49
func_41E1()
{
	var_00 = level.scaretable;
	return self.var_598B;
}

//Function Number: 50
func_3DB1()
{
	var_00 = common_scripts\utility::func_46B7("fol_incubator_spawn","targetname");
	var_01 = common_scripts\utility::func_46B7("fol_incubator_dormant","targetname");
	var_02 = common_scripts\utility::func_F73(var_00,var_01);
	common_scripts\utility::func_3C87("flag_first_fol_inc_selected");
	common_scripts\utility::func_3C87("flag_fol_inc_armed");
	foreach(var_04 in var_02)
	{
		var_05 = common_scripts\utility::func_44BE(var_04.var_1A2,"targetname");
		foreach(var_07 in var_05)
		{
			var_08 = var_07.var_165;
			if(!isdefined(var_08))
			{
				continue;
			}

			switch(var_08)
			{
				case "inc_js_trig":
					var_04.var_9D5E = var_07;
					break;

				case "inc_js_head_pos":
					var_04.var_4BDE = var_07;
					break;

				case "inc_js_door":
					var_04.var_3255 = var_07;
					break;

				case "inc_js_door_dest":
					var_04.var_325B = var_07;
					break;

				case "inc_js_door_exp_fx":
					if(!isdefined(var_04.var_3F2F))
					{
						var_04.var_3F2F = [];
					}
	
					var_04.var_3F2F[var_04.var_3F2F.size] = var_07;
					break;
			}
		}

		if(isdefined(var_04.var_9D5E))
		{
			var_04.var_CA6 = 0;
			var_04.var_5975 = 0;
			var_04.var_5973 = 0;
			var_04.var_5972 = 0;
			var_04.var_5971 = 0;
		}

		if(isdefined(var_04.var_4BDE))
		{
			var_04.var_39F8 = spawn("script_model",var_04.var_4BDE.var_116);
			var_04.var_39F8 setmodel("zom_follower_justhead");
			var_04.var_39F8.var_1D = var_04.var_4BDE.var_1D;
			var_04.var_39F8 scriptmodelplayanim("s2_zom_fol_pass_idle_1");
		}
	}
}

//Function Number: 51
func_3DB0()
{
	return common_scripts\utility::func_46B7("fol_incubator_spawn","targetname");
}

//Function Number: 52
func_3DAF()
{
	return common_scripts\utility::func_46B7("fol_incubator_dormant","targetname");
}

//Function Number: 53
func_3DB3()
{
	func_84F0("follower_incubator");
	if(common_scripts\utility::func_562E(self.var_5972) || common_scripts\utility::func_562E(self.var_CA6))
	{
		return;
	}

	self.var_5978 = self.var_9D5E.var_116;
	var_00 = 1;
	var_01 = undefined;
	while(!common_scripts\utility::func_3C77("flag_first_fol_inc_selected"))
	{
		var_02 = 0;
		if(isdefined(self.var_81A1))
		{
			common_scripts\utility::func_3C9F(self.var_81A1);
		}

		self.var_9D5E waittill("trigger",var_01);
		if(isdefined(self.var_81A1) && !common_scripts\utility::func_3C77(self.var_81A1))
		{
			wait(var_00);
			continue;
		}

		if(!isdefined(var_01) || !isplayer(var_01))
		{
			wait(var_00);
			continue;
		}

		if(self.var_5973)
		{
			var_02 = 1;
		}
		else
		{
			if(!sighttracepassed(var_01.var_116,self.var_5978,0,self.var_3255))
			{
				wait(var_00);
				continue;
			}

			var_03 = var_01 geteye();
			var_04 = var_01 geteyeangles();
			var_05 = anglestoforward(var_04);
			var_06 = vectornormalize(self.var_5978 - var_03);
			if(vectordot(var_05,var_06) > 0.766)
			{
				var_02 = 1;
			}
			else
			{
			}
		}

		if(var_02)
		{
			if(self.var_5971)
			{
				break;
			}
			else if(!self.var_5975)
			{
				if(isdefined(var_01) && isplayer(var_01))
				{
					var_07 = func_5977(var_01);
					if(var_07)
					{
						func_3DB2(var_01);
						self.var_5975 = 1;
					}
				}
			}
		}

		wait(var_00);
	}

	var_07 = 0;
	if(self.var_5971)
	{
		if(self.var_5973)
		{
			var_07 = 1;
		}
		else if(isdefined(var_01) && isplayer(var_01))
		{
			var_07 = func_5977(var_01);
		}

		if(var_07)
		{
			func_3DAE(var_01);
			return;
		}

		self.var_5972 = 1;
		thread func_3DAD();
	}
}

//Function Number: 54
func_3DB2(param_00)
{
	earthquake(0.1,0.2,self.var_3255.var_116,250);
	var_01 = common_scripts\utility::func_4461(self.var_116,level.var_744A,250);
	lib_0378::func_8D74("fol_tube_jumpscare_rattle",var_01);
	if(!common_scripts\utility::func_562E(var_01.var_3067))
	{
		var_02 = var_01 lib_0367::func_8E3D("followertanklook");
		if(isdefined(var_02))
		{
			var_01.var_3067 = 1;
		}
	}

	self.var_3255 vibrate(anglestoforward(self.var_3255.var_1D),0.3,0.4,0.2);
}

//Function Number: 55
func_3DAE(param_00)
{
	if(common_scripts\utility::func_3C77("flag_first_fol_inc_selected"))
	{
		return;
	}
	else
	{
		common_scripts\utility::func_3C8F("flag_first_fol_inc_selected");
	}

	self.var_CA5 = 1;
	if(!isdefined(self.var_3255))
	{
		return;
	}

	lib_0378::func_8D74("fol_tube_jumpscare_execute");
	var_01 = 3.8;
	var_02 = 1.933333;
	if(isdefined(self.var_3255))
	{
		self.var_3255 scriptmodelplayanim("zmb_incubator_panel_fol_intro_spawn");
		lib_0378::func_8D74("fol_tube_jumpscare_door_fall");
	}

	if(isdefined(param_00))
	{
		func_5976(param_00);
	}

	var_03 = lib_054D::func_90BA("zombie_heavy",self,"follower incubator spawn",0,1,0,undefined,0);
	if(!isdefined(var_03))
	{
		return;
	}

	var_03 method_805C();
	wait(var_02);
	if(isdefined(self.var_39F8))
	{
		self.var_39F8 delete();
	}

	var_03 method_805B();
	if(isdefined(self.var_3255))
	{
		self.var_3255 method_805C();
	}

	foreach(var_05 in self.var_3F2F)
	{
		var_06 = anglestoforward(var_05.var_1D);
		var_07 = anglestoup(var_05.var_1D);
		playfx(common_scripts\utility::func_44F5("zmb_incubator_js_explosion"),var_05.var_116,var_06,var_07);
	}

	if(!isdefined(param_00) && isdefined(self.var_3255))
	{
		param_00 = common_scripts\utility::func_4461(self.var_3255.var_116,level.var_744A);
	}

	if(isdefined(self.var_3255))
	{
		self.var_3255 scriptmodelclearanim();
		self.var_3255 delete();
	}

	if(isdefined(param_00))
	{
		param_00 thread lib_0367::func_8E3C("followersurprise");
	}
}

//Function Number: 56
func_3DAD()
{
	var_00 = lib_055A::func_4562(self.var_116);
	for(;;)
	{
		var_01 = 1;
		foreach(var_03 in level.var_744A)
		{
			if(lib_055A::func_7413(var_03,var_00))
			{
				var_01 = 0;
			}
		}

		if(var_01)
		{
			break;
		}

		wait(10);
	}

	if(common_scripts\utility::func_562E(self.var_CA6))
	{
		return;
	}

	if(isdefined(self.var_9D5E))
	{
		self.var_9D5E delete();
	}

	if(isdefined(self.var_3255))
	{
		self.var_3255 delete();
	}

	if(isdefined(self.var_39F8))
	{
		self.var_39F8 delete();
	}

	self.var_CA6 = 1;
}