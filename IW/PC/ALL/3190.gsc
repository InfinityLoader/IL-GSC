/*******************************************************************
 * Decompiled By: Bog
 * Decompiled File: 3190.gsc
 * Game: Call of Duty: Infinite Warfare
 * Platform: PC
 * Function Count: 43
 * Decompile Time: 9 ms
 * Timestamp: 10/27/2023 12:26:29 AM
*******************************************************************/

//Function Number: 1
func_8E15(param_00,param_01,param_02,param_03)
{
	if(param_00 == "remove_helmet")
	{
		if(self.var_8E14 == "head")
		{
			scripts\mp\agents\zombie_brute\zombie_brute_agent::func_BCBC();
			return;
		}

		return;
	}

	if(param_00 == "put_on_helmet")
	{
		if(self.var_8E14 == "hand")
		{
			scripts\mp\agents\zombie_brute\zombie_brute_agent::func_BCBD();
			return;
		}
	}
}

//Function Number: 2
func_11809(param_00,param_01,param_02,param_03)
{
	if(param_00 == "hit")
	{
		self.var_13F9D unlink();
		self.var_13F9D delete();
		self.var_13F9D = undefined;
		var_04 = self gettagorigin("J_Wrist_ri");
		if(!isdefined(self.var_10C))
		{
			return;
		}

		var_05 = self.var_10C.origin + (0,0,0);
		magicbullet("iw7_zombiepiece_mp",var_04,var_05,self);
	}
}

//Function Number: 3
func_8485(param_00,param_01,param_02,param_03)
{
	if(param_00 == "hit")
	{
		if(isdefined(self.var_13FAB) && !isdefined(self.var_13F9D) && isalive(self.var_13FAB))
		{
			self.var_13FAB.full_gib = 1;
			self.var_13FAB.nocorpse = 1;
			self.var_13FAB.var_54CB = 1;
			self.var_13FAB.deathmethod = "grabbed";
			self.var_13FAB dodamage(self.var_13FAB.health + -15536,self.origin);
			var_04 = self gettagorigin("J_Wrist_ri");
			var_05 = spawn("script_model",var_04);
			var_05 setmodel("tag_origin");
			var_05 linkto(self,"J_Wrist_ri",(0,0,0),(0,0,0));
			self.var_13F9D = var_05;
		}
	}
}

//Function Number: 4
func_116EF(param_00,param_01,param_02)
{
	self.var_AA2C = gettime();
	self.var_3322 = 0;
	self.var_29D1 = undefined;
}

//Function Number: 5
func_D54C(param_00,param_01,param_02,param_03)
{
	self endon(param_01 + "_finished");
	self.var_29D1 = 1;
	level thread lib_0D62::func_CE9C(self,"attack_toss",1);
	lib_0A1D::func_2364(param_00,param_01,param_02,param_03);
}

//Function Number: 6
func_116EB(param_00,param_01,param_02)
{
	self.var_13FAB = undefined;
	self.var_13F9E = undefined;
	self.var_3324 = undefined;
}

//Function Number: 7
func_D48E(param_00,param_01,param_02,param_03)
{
	self endon(param_01 + "_finished");
	self.var_13FAB = self.var_13F9E;
	lib_0A1D::func_2364(param_00,param_01,param_02,param_03);
}

//Function Number: 8
func_D48D(param_00,param_01,param_02,param_03)
{
	self endon(param_01 + "_finished");
	self.var_13FAB = self.var_13F9E;
	var_04 = self.var_13FAB.origin - self.origin;
	var_05 = vectornormalize(var_04);
	var_06 = vectortoangles(var_05);
	self method_8289("face angle abs",var_06);
	lib_0A1D::func_2364(param_00,param_01,param_02,param_03);
}

//Function Number: 9
func_1001D(param_00,param_01,param_02,param_03)
{
	if(isdefined(self.var_13F9D))
	{
		return 0;
	}

	if(!isdefined(self.var_13F9E))
	{
		return 0;
	}

	if(scripts\common\utility::istrue(self.var_3324))
	{
		return 1;
	}

	return 0;
}

//Function Number: 10
func_100AC(param_00,param_01,param_02,param_03)
{
	if(!isdefined(self.var_13F9D) || !isdefined(self.var_3322))
	{
		return 0;
	}

	if(!isdefined(self.var_10C))
	{
		return 0;
	}

	if(self.var_8E14 == "hand")
	{
		return 0;
	}

	var_04 = anglestoforward(self.angles);
	var_05 = self.var_10C.origin - self.origin;
	var_05 = (var_05[0],var_05[1],0);
	var_05 = vectornormalize(var_05);
	if(vectordot(var_04,var_05) < 0)
	{
		return 0;
	}

	return 1;
}

//Function Number: 11
func_10055(param_00,param_01,param_02,param_03)
{
	var_04 = sortbydistance(level.players,self.origin);
	var_05 = 0;
	for(var_06 = 0;var_06 < var_04.size;var_06++)
	{
		if(distancesquared(self.origin,var_04[var_06].origin) < -25536)
		{
			var_05++;
			continue;
		}

		break;
	}

	if(var_05 > 1)
	{
		return 1;
	}

	return randomint(100) < 50;
}

//Function Number: 12
func_3EFA(param_00,param_01,param_02)
{
	if(self.var_8E14 == "hand")
	{
		return lib_0A1A::func_2358(param_01,"attack_slam_helmet");
	}

	return lib_0A1A::func_2358(param_01,"attack_slam");
}

//Function Number: 13
func_D51C(param_00,param_01,param_02,param_03)
{
	self endon(param_01 + "_finished");
	var_04 = lib_0A1D::func_2337(param_00,param_01);
	var_05 = self method_80FD(param_01,var_04);
	var_06 = getanimlength(var_05);
	var_07 = var_06 * 0.33;
	level thread lib_0D62::func_CE9C(self,"attack_ground_pound",1);
	thread func_895D(var_07);
	lib_0A1D::func_2364(param_00,param_01,param_02,param_03);
}

//Function Number: 14
func_FFE2(param_00,param_01,param_02,param_03)
{
	if(scripts\common\utility::istrue(self.var_2997))
	{
		return 1;
	}

	return 0;
}

//Function Number: 15
func_895D(param_00)
{
	self endon("death");
	wait(param_00);
	var_01 = lib_0C73::func_7AD3();
	self setscriptablepartstate("slam_blast","active");
	foreach(var_03 in level.players)
	{
		if(isalive(var_03))
		{
			if(distancesquared(self.origin,var_03.origin) < -25536)
			{
				lib_0C73::func_5904(var_03,var_01,"MOD_IMPACT");
			}
		}
	}

	if(scripts\common\utility::istrue(self.var_2997))
	{
		self.var_2997 = undefined;
		var_05 = scripts\mp\_mp_agent::func_7D95("all");
		foreach(var_07 in var_05)
		{
			if(var_07 == self)
			{
				continue;
			}

			if(!scripts\common\utility::istrue(var_07.var_9E0C))
			{
				continue;
			}

			var_07 dodamage(var_07.health + 100,self.origin,undefined,undefined,"MOD_IMPACT");
		}
	}

	wait(0.25);
	self setscriptablepartstate("slam_blast","inactive");
}

//Function Number: 16
func_100A0(param_00,param_01,param_02,param_03)
{
	return 0;
}

//Function Number: 17
func_FFF1(param_00,param_01,param_02,param_03)
{
	if(!isdefined(self.var_10C))
	{
		return 0;
	}

	if(scripts\common\utility::istrue(self.var_2B5A))
	{
		return 1;
	}

	return 0;
}

//Function Number: 18
func_10063(param_00,param_01,param_02,param_03)
{
	if(!isdefined(self.var_527A) || !isdefined(self.var_8E14))
	{
		return 0;
	}

	if(self.var_8E14 != self.var_527A && self.var_527A == "head")
	{
		return 1;
	}

	return 0;
}

//Function Number: 19
func_10069(param_00,param_01,param_02,param_03)
{
	if(!isdefined(self.var_527A) || !isdefined(self.var_8E14))
	{
		return 0;
	}

	if(self.var_8E14 != self.var_527A && self.var_527A == "hand")
	{
		return 1;
	}

	return 0;
}

//Function Number: 20
func_390C(param_00,param_01,param_02,param_03)
{
	return isdefined(self.var_10C) && self.var_8E14 == "head";
}

//Function Number: 21
func_9E70(param_00,param_01,param_02,param_03)
{
	return !scripts\common\utility::istrue(self.var_2B5A);
}

//Function Number: 22
func_D4BB(param_00,param_01,param_02,param_03)
{
	self.var_2B5B = 1;
	thread func_CD6C();
	lib_0A1D::func_2364(param_00,param_01,param_02,param_03);
}

//Function Number: 23
func_CD6C()
{
	playfxontag(level._effect["vfx_zmb_brute_warn_01"],self,"tag_eye");
	level thread lib_0D62::func_CE9C(self,"attack_laser",1);
}

//Function Number: 24
func_58E5(param_00,param_01,param_02,param_03)
{
	self.var_1C2 = self.var_10C.origin + (0,0,40);
	self.var_1C4 = undefined;
	thread func_8979(param_01);
	lib_0A1D::func_2364(param_00,param_01,param_02,param_03);
}

//Function Number: 25
func_116F8(param_00,param_01,param_02)
{
	self.var_1C4 = undefined;
	self.var_1C2 = undefined;
	self.var_2B5A = undefined;
	self.var_2B5B = undefined;
	self setscriptablepartstate("laser_flare","inactive");
}

//Function Number: 26
terminatelaserattackprep(param_00,param_01,param_02)
{
	if(!func_1FB4(param_00,param_01,undefined,param_02))
	{
		func_116F8(param_00,param_01,param_02);
	}
}

//Function Number: 27
func_8979(param_00)
{
	self endon(param_00 + "_finished");
	self setscriptablepartstate("laser_hint","off");
	self setscriptablepartstate("laser_flare","active");
	var_01 = getdvarint("scr_debugLaser",0);
	if(!isdefined(var_01))
	{
		var_01 = 0;
	}

	var_02 = distance(self.origin,self.var_1C2);
	wait(0.2);
	var_03 = 8;
	for(var_04 = 0;var_04 < var_03;var_04++)
	{
		self method_837B(1,undefined,1,1);
		wait(0.05);
	}

	if(var_01)
	{
		var_03 = 99999999;
	}
	else
	{
		var_03 = 60;
	}

	for(var_04 = 0;var_04 < var_03;var_04++)
	{
		if(isdefined(self.var_10C))
		{
			var_05 = self.var_10C.origin + (0,0,40);
			var_06 = var_05 - self.var_1C2;
			var_07 = length(var_06);
			if(var_07 < 10)
			{
				self.var_1C2 = var_05;
			}
			else
			{
				var_08 = vectornormalize(var_06);
				var_09 = var_08 * 200 * 0.05;
				self.var_1C2 = self.var_1C2 + var_09;
			}
		}

		self method_837B(1,self.var_1C2,1,1);
		func_FF5C();
		wait(0.05);
	}

	self setscriptablepartstate("laser_flare","inactive");
	self.var_1C2 = undefined;
	self.var_1C4 = self.var_10C;
	self.var_2B5A = 0;
}

//Function Number: 28
func_FF5C()
{
	if(func_8BB1(self.model,"tag_flash"))
	{
		var_00 = anglestoforward(self gettagangles("tag_flash"));
		var_01 = var_00 * 1000;
		var_02 = self gettagorigin("tag_flash");
	}
	else
	{
		var_00 = anglestoforward(self gettagangles("tag_eye"));
		var_01 = var_02 * 1000;
		var_02 = self gettagorigin("tag_eye");
	}

	var_03 = bullettrace(var_02,var_02 + var_01,1,self,0,1);
	if(isdefined(var_03["entity"]))
	{
		var_04 = var_03["entity"];
		if(isdefined(var_04.agent_type) && var_04.agent_type == "generic_zombie" && !isdefined(var_04.flung))
		{
			var_04 thread func_A869(self);
		}
	}
}

//Function Number: 29
func_8BB1(param_00,param_01)
{
	var_02 = function_00BC(param_00);
	for(var_03 = 0;var_03 < var_02;var_03++)
	{
		if(tolower(function_00BF(param_00,var_03)) == tolower(param_01))
		{
			return 1;
		}
	}

	return 0;
}

//Function Number: 30
func_A869(param_00)
{
	self endon("death");
	if(isdefined(self.var_B36E))
	{
		return;
	}

	var_01 = param_00.origin;
	var_02 = randomint(100);
	if(var_02 > 75)
	{
		self.var_B36E = 1;
		self.do_immediate_ragdoll = 1;
		self.var_4C87 = 1;
		self.disable_armor = 1;
		self setvelocity(vectornormalize(self.origin - var_01) * 200 + (0,0,100));
		wait(0.1);
		self.var_54CB = 1;
		self dodamage(1000000,var_01,undefined,undefined,"MOD_UNKNOWN");
		return;
	}

	if(var_02 > 50)
	{
		self.var_B36E = 1;
		thread scripts\cp\zombies\zombie_scriptable_states::applyzombiescriptablestate(self);
		wait(1);
		self.var_54CB = 1;
		self.var_B36E = undefined;
		self dodamage(1000000,var_01,undefined,undefined,"MOD_UNKNOWN");
		return;
	}

	self.var_54CB = 1;
	self.var_B36E = 1;
	self.nocorpse = 1;
	self.var_4C87 = 1;
	self.disable_armor = 1;
	playfx(level._effect["blackhole_trap_death"],self.origin + (0,0,40),anglestoforward((-90,0,0)),anglestoup((-90,0,0)));
	self dodamage(1000000,var_01,undefined,undefined,"MOD_UNKNOWN");
}

//Function Number: 31
func_1FB4(param_00,param_01,param_02,param_03)
{
	return lib_0A1A::func_232B(param_01,"end");
}

//Function Number: 32
func_CC1A(param_00,param_01)
{
	self endon(param_01 + "_finished");
	self endon("death");
	wait(0.5);
	func_8E15("put_on_helmet");
}

//Function Number: 33
func_E12C(param_00,param_01)
{
	self endon(param_01 + "_finished");
	self endon("death");
	wait(0.5);
	func_8E15("remove_helmet");
}

//Function Number: 34
func_D498(param_00,param_01,param_02,param_03)
{
	self endon("death");
	lib_0A1D::func_2364(param_00,param_01,param_02,param_03);
	func_8E15("put_on_helmet");
}

//Function Number: 35
func_D499(param_00,param_01,param_02,param_03)
{
	self endon("death");
	self setscriptablepartstate("eyes","yellow_eyes");
	lib_0A1D::func_2364(param_00,param_01,param_02,param_03);
	func_8E15("remove_helmet");
}

//Function Number: 36
func_3EC3(param_00,param_01,param_02)
{
	var_03 = self method_8100(param_01);
	if(var_03 == 1)
	{
		return "helmet";
	}

	if(self.var_8E14 == "head")
	{
		return "helmet";
	}

	return "no_helmet";
}

//Function Number: 37
func_3EC1(param_00,param_01,param_02)
{
	var_03 = self method_8100(param_01);
	if(var_03 == 1)
	{
		return 0;
	}

	return randomintrange(0,var_03);
}

//Function Number: 38
func_3EC2(param_00,param_01,param_02)
{
	var_03 = self method_8100(param_01);
	if(var_03 == 1)
	{
		return "duck_run";
	}

	if(self.var_8E14 == "head")
	{
		return "duck_run";
	}

	return "sprint_run";
}

//Function Number: 39
func_1003B(param_00,param_01,param_02,param_03)
{
	var_04 = self method_855B("door",300);
	if(isdefined(var_04))
	{
		self.var_A8AF = var_04;
		return 1;
	}

	return 0;
}

//Function Number: 40
func_D4E7(param_00,param_01,param_02,param_03)
{
	self endon(param_01 + "_finished");
	lib_0A1D::func_2364(param_00,param_01,param_02,param_03);
}

//Function Number: 41
func_3EC0(param_00,param_01,param_02)
{
	var_03 = self method_8100(param_01);
	if(var_03 == 1)
	{
		return "helmet_on";
	}

	if(self.var_8E14 == "head")
	{
		return "helmet_on";
	}

	return "helmet_off";
}

//Function Number: 42
func_FFEB(param_00,param_01,param_02,param_03)
{
	return isdefined(self.croc_chomp) && self.croc_chomp;
}

//Function Number: 43
func_3EC9(param_00,param_01,param_02)
{
	var_03 = self method_8100(param_01);
	if(var_03 == 1)
	{
		param_02 = param_02 + "_helmet";
	}

	if(self.var_8E14 == "head")
	{
		param_02 = param_02 + "_helmet";
	}
	else
	{
		param_02 = param_02 + "_no_helmet";
	}

	return lib_0A1A::func_2358(param_01,param_02);
}