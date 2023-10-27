/*******************************************************************
 * Decompiled By: Bog
 * Decompiled File: 3118.gsc
 * Game: Call of Duty: Infinite Warfare
 * Platform: PC
 * Function Count: 69
 * Decompile Time: 14 ms
 * Timestamp: 10/27/2023 12:26:09 AM
*******************************************************************/

//Function Number: 1
func_13F8D(param_00)
{
	if(!isdefined(self.var_394))
	{
		return level.var_6AD5;
	}

	if(isdefined(self.var_595D) && self.var_595D)
	{
		return level.var_6AD5;
	}

	if(!func_10076())
	{
		return level.var_6AD5;
	}

	return level.var_111AE;
}

//Function Number: 2
func_10076()
{
	if(isdefined(self.var_595D) && self.var_595D)
	{
		return 0;
	}

	if(!isdefined(self.var_10C))
	{
		return 0;
	}

	if(self.var_3250 == 0)
	{
		return 0;
	}

	if(self method_805F(self.var_10C))
	{
		scripts\anim\utility_common::func_5962();
		self.var_8451 = self.var_10C method_815B();
		return 1;
	}

	return 0;
}

//Function Number: 3
func_13F90(param_00)
{
	if(!func_9E1A())
	{
		return level.var_6AD5;
	}

	if(![[ self.var_71AF ]](self.var_10C,1))
	{
		return level.var_6AD5;
	}

	return level.var_111AE;
}

//Function Number: 4
func_9E1A(param_00)
{
	if(!isdefined(param_00))
	{
		param_00 = self.var_10C;
	}

	if(isdefined(self.var_5966))
	{
		return 0;
	}

	if(isdefined(self.var_3135.var_38E1))
	{
		return 0;
	}

	if(!isdefined(param_00))
	{
		return 0;
	}

	if(isdefined(param_00.var_5966))
	{
		return 0;
	}

	if(isdefined(self.var_1412) && !lib_0A0E::func_38CD())
	{
		return 0;
	}

	if(gettime() < self.next_melee_time)
	{
		return 0;
	}

	return 1;
}

//Function Number: 5
func_13F86(param_00)
{
	self.var_1548 = 0.95;
	self.var_71AF = ::func_9E99;
	self.var_71C0 = ::func_B5E9;
	self.var_71C1 = ::func_B5EF;
	self.var_71C2 = ::func_B654;
	self.var_71C3 = ::func_B656;
	self.var_7199 = ::func_38CF;
	set_next_melee_time(self);
	return level.var_111AE;
}

//Function Number: 6
func_13F8B(param_00)
{
	func_F2F4(self,0);
	func_F49D(self);
	return level.var_111AE;
}

//Function Number: 7
func_13F88(param_00)
{
	func_F2F1(self,0);
	func_F499(self);
	func_E223(self);
	return level.var_111AE;
}

//Function Number: 8
func_13F8A(param_00)
{
	func_F2F3(self,1);
	func_F49B(self);
	return level.var_111AE;
}

//Function Number: 9
func_13F89(param_00)
{
	func_F2F2(self,1);
	func_F49A(self);
	return level.var_111AE;
}

//Function Number: 10
func_13F84(param_00)
{
	self.var_380E = 0;
	self.var_1272C = self.maxhealth * 0.33;
	return level.var_111AE;
}

//Function Number: 11
func_13F85(param_00)
{
	self.var_15B5 = int(self.health * 0.2);
	self.var_4C17 = self.maxhealth;
	self.var_B43F = int(self.maxhealth * 0.33);
	self.var_B748 = int(self.maxhealth * 0.33);
	self.var_8CB2 = 0;
	self.var_380F = 1;
	var_01 = self.maxhealth - self.var_15B5;
	var_02 = 120;
	self.var_8CAA = int(var_01 / var_02);
	return level.var_111AE;
}

//Function Number: 12
func_13F8F(param_00)
{
	if(!self.var_380E)
	{
		return level.var_6AD5;
	}

	if(scripts\common\utility::istrue(self.var_927D))
	{
		return level.var_6AD5;
	}

	if(scripts\common\utility::istrue(self.var_9C9D))
	{
		return level.var_6AD5;
	}

	if(scripts\common\utility::istrue(self.var_58D3))
	{
		return level.var_6AD5;
	}

	if(self.health < self.var_1272C)
	{
		func_F6DA(self,max(level.players.size,2));
		return level.var_111AE;
	}

	return level.var_6AD5;
}

//Function Number: 13
func_F6DA(param_00,param_01)
{
	param_00 setscriptablepartstate("health_light","no_light");
	lib_0C78::func_F3E7(param_00);
	param_00.var_58CD = 1;
	param_00.var_C1F4 = param_01;
	level.var_424E = int(param_00.maxhealth / param_01);
	level.var_4D26 = 0;
}

//Function Number: 14
func_13F7C(param_00)
{
	if(scripts\common\utility::istrue(self.var_58CD))
	{
		return level.var_E87A;
	}

	return level.var_6AD5;
}

//Function Number: 15
func_13F95(param_00)
{
	if(!scripts\common\utility::istrue(self.var_3811))
	{
		return level.var_6AD5;
	}

	if(scripts\common\utility::istrue(self.var_927D))
	{
		return level.var_6AD5;
	}

	if(scripts\common\utility::istrue(self.var_9C9D))
	{
		return level.var_6AD5;
	}

	if(scripts\common\utility::istrue(self.var_58D5))
	{
		return level.var_6AD5;
	}

	if(scripts\common\utility::istrue(self.var_58D4))
	{
		return level.var_6AD5;
	}

	if(isdefined(self.var_11630))
	{
		return level.var_6AD5;
	}

	var_01 = gettime();
	if(var_01 < self.var_BF66)
	{
		return level.var_6AD5;
	}

	if(var_01 < self.var_BF63)
	{
		return level.var_6AD5;
	}

	if(var_01 < self.var_BF35)
	{
		return level.var_6AD5;
	}

	if(!func_B54B(self))
	{
		func_E223(self);
		return level.var_6AD5;
	}

	func_E223(self);
	self.var_58D3 = 1;
	return level.var_111AE;
}

//Function Number: 16
func_13F97(param_00)
{
	if(!scripts\common\utility::istrue(self.var_3813))
	{
		return level.var_6AD5;
	}

	if(scripts\common\utility::istrue(self.var_927D))
	{
		return level.var_6AD5;
	}

	if(scripts\common\utility::istrue(self.var_58D3))
	{
		return level.var_6AD5;
	}

	if(scripts\common\utility::istrue(self.var_58D4))
	{
		return level.var_6AD5;
	}

	if(scripts\common\utility::istrue(self.var_9C9D))
	{
		return level.var_6AD5;
	}

	if(isdefined(self.var_11630))
	{
		return level.var_6AD5;
	}

	var_01 = gettime();
	if(var_01 < self.var_BF66)
	{
		return level.var_6AD5;
	}

	if(var_01 < self.var_BF65)
	{
		return level.var_6AD5;
	}

	self.var_58D5 = 1;
	return level.var_111AE;
}

//Function Number: 17
func_13F96(param_00)
{
	if(!scripts\common\utility::istrue(self.var_3812))
	{
		return level.var_6AD5;
	}

	if(scripts\common\utility::istrue(self.var_927D))
	{
		return level.var_6AD5;
	}

	if(scripts\common\utility::istrue(self.var_58D3))
	{
		return level.var_6AD5;
	}

	if(scripts\common\utility::istrue(self.var_58D5))
	{
		return level.var_6AD5;
	}

	if(scripts\common\utility::istrue(self.var_9C9D))
	{
		return level.var_6AD5;
	}

	if(isdefined(self.var_11630))
	{
		return level.var_6AD5;
	}

	var_01 = gettime();
	if(var_01 < self.var_BF66)
	{
		return level.var_6AD5;
	}

	if(var_01 < self.var_BF64)
	{
		return level.var_6AD5;
	}

	if(isdefined(self.var_11539) && distancesquared(self.origin,self.var_11539.origin) > 1000000)
	{
		return level.var_6AD5;
	}

	self.var_58D4 = 1;
	return level.var_111AE;
}

//Function Number: 18
func_13F7D(param_00)
{
	if(scripts\common\utility::istrue(self.var_58D3))
	{
		return level.var_E87A;
	}

	return level.var_6AD5;
}

//Function Number: 19
func_13F7F(param_00)
{
	if(scripts\common\utility::istrue(self.var_58D5))
	{
		return level.var_E87A;
	}

	return level.var_6AD5;
}

//Function Number: 20
func_13F7E(param_00)
{
	if(scripts\common\utility::istrue(self.var_58D4))
	{
		return level.var_E87A;
	}

	return level.var_6AD5;
}

//Function Number: 21
func_13F98(param_00)
{
	if(!scripts\common\utility::istrue(self.var_3814))
	{
		return level.var_6AD5;
	}

	if(scripts\common\utility::istrue(self.var_927D))
	{
		return level.var_6AD5;
	}

	if(scripts\common\utility::istrue(self.var_9C9D))
	{
		return level.var_6AD5;
	}

	if(scripts\common\utility::istrue(self.var_58D3))
	{
		return level.var_6AD5;
	}

	var_01 = gettime();
	if(var_01 < self.var_BF67)
	{
		return level.var_6AD5;
	}

	var_02 = func_81BF(self);
	if(isdefined(var_02))
	{
		self.var_11630 = var_02;
		func_F49D(self);
		return level.var_111AE;
	}

	return level.var_6AD5;
}

//Function Number: 22
func_13F80(param_00)
{
	if(isdefined(self.var_11630))
	{
		return level.var_E87A;
	}

	return level.var_6AD5;
}

//Function Number: 23
func_81BF(param_00)
{
	var_01 = [];
	foreach(var_03 in level.players)
	{
		if(!isdefined(var_03.var_C205))
		{
			var_03.var_C205 = 0;
		}

		if(distancesquared(param_00.origin,var_03.origin) < 250000)
		{
			continue;
		}

		if(scripts\cp\_laststand::player_in_laststand(var_03))
		{
			continue;
		}

		var_01[var_01.size] = var_03;
	}

	if(var_01.size == 0)
	{
		return undefined;
	}

	var_05 = undefined;
	var_06 = 999;
	foreach(var_03 in var_01)
	{
		if(var_03.var_C205 < var_06)
		{
			var_06 = var_03.var_C205;
			var_05 = var_03;
		}
	}

	var_05.var_C205++;
	return var_05;
}

//Function Number: 24
func_13F7B(param_00)
{
	if(scripts\common\utility::istrue(self.var_927D))
	{
		return level.var_6AD5;
	}

	if(scripts\common\utility::istrue(self.var_9C9D))
	{
		return level.var_E87A;
	}

	return level.var_6AD5;
}

//Function Number: 25
zombiegreyassigntargetplayer(param_00)
{
	if(isdefined(self.favorite_target_player) && !scripts\cp\_laststand::player_in_laststand(self.favorite_target_player))
	{
		assigntargetplayer(self,self.favorite_target_player);
		return level.var_6AD5;
	}
	else
	{
		var_01 = level.players;
		var_01 = scripts\common\utility::func_22A9(var_01,self.favorite_target_player);
		var_01 = scripts\common\utility::array_randomize(var_01);
		foreach(var_03 in var_01)
		{
			if(isdefined(var_03) && !scripts\cp\_laststand::player_in_laststand(var_03))
			{
				assigntargetplayer(self,var_03);
				return level.var_6AD5;
			}

			assigntargetplayer(self,self.favorite_target_player);
			return level.var_6AD5;
		}
	}

	return level.var_6AD5;
}

//Function Number: 26
assigntargetplayer(param_00,param_01)
{
	param_00.var_11539 = param_01;
}

//Function Number: 27
func_9E99(param_00,param_01)
{
	if(distancesquared(self.origin,param_00.origin) > self.meleerangesq)
	{
		return 0;
	}

	if(lib_0A1B::func_2942())
	{
		return 0;
	}

	if(!lib_0A0E::func_9E9A(param_00,param_01))
	{
		return 0;
	}

	var_02 = lib_0A0E::func_8198(param_00);
	if(!isdefined(var_02))
	{
		return 0;
	}

	if(!func_38CF(self.origin,var_02))
	{
		return 0;
	}

	return 1;
}

//Function Number: 28
func_B5E9(param_00)
{
	self method_828B(1);
}

//Function Number: 29
func_B5EF(param_00)
{
	self method_828B(0);
}

//Function Number: 30
func_B654(param_00)
{
	self method_828B(1);
}

//Function Number: 31
func_B656(param_00)
{
	self method_828B(0);
}

//Function Number: 32
func_38CF(param_00,param_01)
{
	var_02 = navtrace(param_00,param_01,self,1);
	var_03 = var_02["fraction"];
	if(var_03 >= self.var_1548)
	{
		var_04 = 0;
	}
	else
	{
		var_04 = 1;
	}

	return !var_04;
}

//Function Number: 33
func_13F83(param_00)
{
	if(isdefined(self.var_394))
	{
		return level.var_111AE;
	}

	return level.var_6AD5;
}

//Function Number: 34
func_9D0C(param_00,param_01)
{
	var_02 = anglestoforward(param_01.angles);
	var_02 = (var_02[0],var_02[1],0);
	return vectordot(param_00,var_02) > 0.5;
}

//Function Number: 35
func_12870(param_00)
{
	if(!func_383F(param_00))
	{
		return;
	}

	param_00 thread func_DE83(param_00);
}

//Function Number: 36
func_383F(param_00)
{
	if(!scripts\common\utility::istrue(param_00.var_380F))
	{
		return 0;
	}

	if(param_00.health > param_00.var_15B5)
	{
		return 0;
	}

	if(isdefined(level.var_A8CA) && gettime() - level.var_A8CA < 50)
	{
		return 0;
	}

	if(scripts\common\utility::istrue(param_00.var_927D))
	{
		return 0;
	}

	return 1;
}

//Function Number: 37
func_DE83(param_00)
{
	param_00 endon("death");
	param_00.var_1B6C = undefined;
	param_00.var_9C9D = 1;
	param_00 notify("update_mobile_shield_visibility",0);
	param_00 waittill("grey play regen");
	func_DE82(param_00);
}

//Function Number: 38
func_DE82(param_00)
{
	level.var_A8CA = gettime();
	param_00.var_FF88 = 0;
	param_00.var_1B6C = scripts\common\utility::random(param_00.var_269C);
	if(isdefined(level.var_D7C2))
	{
		[[ level.var_D7C2 ]](param_00);
	}

	lib_0C78::func_5CF8();
	param_00.health = param_00.maxhealth;
	param_00 notify("update_health_light");
	var_01 = scripts\common\utility::waittill_any_timeout_1(6,"stop_regen_health");
	if(var_01 == "stop_regen_health")
	{
		func_D986(param_00);
		param_00.var_FF88 = 1;
		if(isdefined(level.var_85F9))
		{
			[[ level.var_85F9 ]](param_00.var_B570,param_00.var_1B6C);
		}
	}

	param_00.var_9C9D = 0;
	param_00.actually_doing_regen = 0;
	if(isdefined(level.var_D6D2))
	{
		[[ level.var_D6D2 ]]();
	}
}

//Function Number: 39
func_D986(param_00)
{
	if(!isdefined(param_00.var_C1FA))
	{
		param_00.var_C1FA = 0;
	}

	param_00.var_C1FA++;
	if(param_00.var_C1FA == 1)
	{
		param_00.var_8CB2 = int(param_00.maxhealth * 0.33);
		param_00.var_FF83 = 1;
		return;
	}

	if(param_00.var_C1FA >= 2)
	{
		param_00.var_380F = 0;
	}
}

//Function Number: 40
func_B54B(param_00)
{
	if(param_00.var_111BF > 500)
	{
		return 1;
	}

	if(param_00.var_DDBA.size >= 2)
	{
		return 1;
	}

	return 0;
}

//Function Number: 41
func_7BFE()
{
	return 500;
}

//Function Number: 42
func_E223(param_00)
{
	param_00.var_BF35 = gettime() + 1000;
	param_00.var_111BF = 0;
	param_00.var_DDBA = [];
}

//Function Number: 43
func_F499(param_00)
{
	param_00.var_BF63 = gettime() + randomintrange(2000,5000);
	func_F49C(param_00);
}

//Function Number: 44
func_F49B(param_00)
{
	param_00.var_BF65 = gettime() + randomintrange(12000,15000);
	func_F49C(param_00);
}

//Function Number: 45
func_F49A(param_00)
{
	param_00.var_BF64 = gettime() + randomintrange(6000,9000);
	func_F49C(param_00);
}

//Function Number: 46
set_next_melee_time(param_00)
{
	var_01 = 3;
	if(scripts\cp\zombies\direct_boss_fight::should_directly_go_to_boss_fight())
	{
		var_01 = 0.5;
	}

	param_00.next_melee_time = gettime() + var_01 * 1000;
}

//Function Number: 47
func_F49C(param_00)
{
	param_00.var_BF66 = gettime() + randomintrange(2000,3000);
}

//Function Number: 48
func_F49D(param_00)
{
	param_00.var_BF67 = gettime() + randomintrange(12000,18000);
}

//Function Number: 49
func_85FA(param_00)
{
	func_B599(param_00);
	if(isdefined(self.var_71C2))
	{
		self [[ self.var_71C2 ]](param_00);
	}

	thread lib_0A0E::func_B602(self.var_10C);
}

//Function Number: 50
func_B599(param_00,param_01)
{
	if(!isdefined(param_01))
	{
		param_01 = self.var_10C;
	}

	if(isdefined(self.var_B55B))
	{
		lib_0A0E::func_B580();
	}

	lib_0A1B::func_297F(param_01);
	self.var_B55B.var_1158F = param_00;
	param_01.var_B55B.var_1158F = param_00;
	return level.var_111AE;
}

//Function Number: 51
func_85FC(param_00)
{
	return lib_0A0E::func_B657(param_00);
}

//Function Number: 52
func_85FB(param_00)
{
	lib_0A0E::func_B655(param_00);
}

//Function Number: 53
func_F2F1(param_00,param_01)
{
	param_00.var_3811 = param_01;
}

//Function Number: 54
func_F2F3(param_00,param_01)
{
	param_00.var_3813 = param_01;
}

//Function Number: 55
func_F2F2(param_00,param_01)
{
	param_00.var_3812 = param_01;
}

//Function Number: 56
func_F2F4(param_00,param_01)
{
	param_00.var_3814 = param_01;
}

//Function Number: 57
func_4DC9(param_00)
{
	foreach(var_02 in param_00.var_B8F2)
	{
		var_02 delete();
	}

	param_00.var_B8F2 = undefined;
}

//Function Number: 58
func_15D2(param_00)
{
	param_00 endon("death");
	level endon("game_ended");
	param_00 waittill("shockwave_deploy");
	param_00.var_B8F2 = [];
	foreach(var_03, var_02 in level.players)
	{
		func_15D1(var_02,param_00,80 + var_03 * 20);
	}
}

//Function Number: 59
func_15D1(param_00,param_01,param_02)
{
	var_03 = func_36F7(param_00,param_01,param_02);
	var_04 = spawnhelicopter(level.players[0],var_03.var_B8EF,vectortoangles(var_03.var_B8EB),"zombie_grey_shield","zmb_temp_grey_shield_des");
	var_04 method_81FA(1);
	var_04 method_83E5(100,200,200);
	var_04 method_8354(1);
	var_04 method_8316(10);
	var_04 method_82F6(1,0,0);
	var_04 method_8378(360,360);
	var_05 = spawn("script_model",var_03.var_B8EE);
	var_04 method_8305(var_05);
	var_04.var_B8EC = var_05;
	var_04.var_56FA = param_02;
	var_04.var_5266 = param_00;
	var_04.var_9394 = 0;
	var_04 thread func_B8E8(param_01,var_04);
	var_04 thread func_B8E9(var_04);
	var_04 thread func_B8F0(var_04,param_00,param_01);
	var_04 thread func_B8F1(param_01,var_04);
	var_05 thread func_B8ED(var_04,var_05);
	param_01.var_B8F2[param_01.var_B8F2.size] = var_04;
}

//Function Number: 60
func_36F7(param_00,param_01,param_02)
{
	var_03 = param_01.origin + (0,0,45);
	var_04 = vectornormalize(param_00 geteye() - var_03);
	var_05 = spawnstruct();
	var_05.var_B8EF = var_03 + var_04 * param_02;
	var_05.var_B8EE = var_05.var_B8EF + var_04 * 10;
	var_05.var_B8EB = var_04;
	return var_05;
}

//Function Number: 61
func_B8E8(param_00,param_01)
{
	param_01 endon("death");
	param_00 waittill("death");
	param_01 delete();
}

//Function Number: 62
func_B8ED(param_00,param_01)
{
	param_00 waittill("death");
	param_01 delete();
}

//Function Number: 63
func_B8F0(param_00,param_01,param_02)
{
	param_00 endon("death");
	param_02 endon("death");
	param_01 endon("disconnect");
	for(;;)
	{
		var_03 = func_36F7(param_01,param_02,param_00.var_56FA);
		param_00 method_8362(var_03.var_B8EF,1);
		param_00.var_B8EC.origin = var_03.var_B8EE;
		scripts\common\utility::func_136F7();
	}
}

//Function Number: 64
func_B8F1(param_00,param_01)
{
	param_00 endon("death");
	param_01 endon("death");
	func_12DF1(param_01,5);
	for(;;)
	{
		var_02 = func_3DAB(param_01,param_00);
		if(var_02 && scripts\common\utility::istrue(param_00.var_9CBD))
		{
			param_01 hide();
		}
		else
		{
			var_03 = gettime();
			if(var_03 < param_01.var_BF44)
			{
				param_01 show();
			}
			else
			{
				param_01 hide();
			}
		}

		scripts\common\utility::func_136F7();
	}
}

//Function Number: 65
func_3DAB(param_00,param_01)
{
	var_02 = param_00.origin - param_01.origin;
	var_02 = (var_02[0],var_02[1],0);
	var_02 = vectornormalize(var_02);
	var_03 = anglestoforward(param_01.angles);
	return vectordot(var_02,var_03) > 0.525;
}

//Function Number: 66
func_12DF1(param_00,param_01)
{
	param_00.var_BF44 = gettime() + param_01 * 1000;
}

//Function Number: 67
func_B8E9(param_00)
{
	param_00 endon("death");
	param_00 setcandamage(1);
	param_00.health = 99999999;
	for(;;)
	{
		param_00 waittill("damage",var_01);
		param_00.health = param_00.health + var_01;
		func_12DF1(param_00,2);
	}
}

//Function Number: 68
func_12888(param_00,param_01)
{
	if(!isdefined(param_01) && isplayer(param_01))
	{
		return;
	}

	if(!isdefined(param_00.var_B8F2))
	{
		return;
	}

	foreach(var_03 in param_00.var_B8F2)
	{
		if(var_03.var_5266 == param_01)
		{
			var_03 thread func_50D7(var_03);
		}
	}
}

//Function Number: 69
func_50D7(param_00)
{
	param_00 endon("death");
	if(scripts\common\utility::istrue(param_00.var_9394))
	{
		return;
	}

	param_00.var_9394 = 1;
	wait(1.5);
	func_12DF1(param_00,3);
	param_00.var_9394 = 0;
}