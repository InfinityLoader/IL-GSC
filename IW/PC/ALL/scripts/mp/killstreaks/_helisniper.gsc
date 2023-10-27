/*******************************************************************
 * Decompiled By: Bog
 * Decompiled File: scripts\mp\killstreaks\_helisniper.gsc
 * Game: Call of Duty: Infinite Warfare
 * Platform: PC
 * Function Count: 32
 * Decompile Time: 1664 ms
 * Timestamp: 10/27/2023 12:28:47 AM
*******************************************************************/

//Function Number: 1
init()
{
	scripts\mp\killstreaks\_helicopter_guard::func_AADA();
	scripts\mp\killstreaks\_helicopter_guard::func_AAD8();
	scripts\mp\killstreaks\_killstreaks::func_DEFB("heli_sniper",::func_128E8);
	var_00 = spawnstruct();
	var_00.var_EC44 = "destroyed_helo_scout";
	var_00.var_3774 = "callout_destroyed_helo_scout";
	var_00.var_EB11 = 0.09;
	var_00.var_65D0 = "tag_engine_right";
	level.var_8DA6["heli_sniper"] = var_00;
}

//Function Number: 2
func_128E8(param_00,param_01)
{
	var_02 = func_7E37(self.origin);
	var_03 = func_7E34(self.origin);
	var_04 = vectortoangles(var_03.origin - var_02.origin);
	if(isdefined(self.var_12B90) && self.var_12B90)
	{
		return 0;
	}

	if(isdefined(self.var_9E5C) && self.var_9E5C == 1)
	{
		return 0;
	}
	else if(!isdefined(level.var_1A66) || !isdefined(var_02) || !isdefined(var_03))
	{
		self iprintlnbold(&"KILLSTREAKS_UNAVAILABLE_IN_LEVEL");
		return 0;
	}

	var_05 = 1;
	if(func_68C2())
	{
		self iprintlnbold(&"KILLSTREAKS_AIR_SPACE_TOO_CROWDED");
		return 0;
	}

	if(scripts\mp\_utility::func_4BD7() >= scripts\mp\_utility::func_B4D2() || level.var_6BAA + var_05 >= scripts\mp\_utility::func_B4D2())
	{
		self iprintlnbold(&"KILLSTREAKS_TOO_MANY_VEHICLES");
		return 0;
	}

	if(isdefined(self.var_9D7F) && self.var_9D7F)
	{
		return 0;
	}

	if(isdefined(self.var_9F28) && self.var_9F28)
	{
		return 0;
	}

	var_06 = func_49D1(self,var_02,var_03,var_04,param_01,param_00);
	if(!isdefined(var_06))
	{
		return 0;
	}

	var_07 = func_8DC0(var_06,param_01);
	if(isdefined(var_07) && var_07 == "fail")
	{
		return 0;
	}

	return 1;
}

//Function Number: 3
func_68C2()
{
	return isdefined(level.var_AAC8);
}

//Function Number: 4
func_7E37(param_00)
{
	var_01 = undefined;
	var_02 = 999999;
	foreach(var_04 in level.var_1A6B)
	{
		var_05 = distance(var_04.origin,param_00);
		if(var_05 < var_02)
		{
			var_01 = var_04;
			var_02 = var_05;
		}
	}

	return var_01;
}

//Function Number: 5
func_49D1(param_00,param_01,param_02,param_03,param_04,param_05)
{
	var_06 = getent("airstrikeheight","targetname");
	var_07 = param_02.origin;
	var_08 = anglestoforward(param_03);
	var_09 = param_01.origin;
	var_0A = spawnhelicopter(param_00,var_09,var_08,"attack_littlebird_mp","vehicle_aas_72x_killstreak");
	if(!isdefined(var_0A))
	{
		return;
	}

	var_0B = scripts\mp\_utility::func_7EFA();
	var_0C = var_07 + scripts\mp\_utility::func_7EF9() + var_0B;
	var_0D = var_07 + scripts\mp\_utility::func_7EF9() - var_0B;
	var_0E = bullettrace(var_0C,var_0D,0,0,0,0,1);
	if(isdefined(var_0E["entity"]) && var_0E["normal"][2] > 0.1)
	{
		var_07 = var_0E["position"] - scripts\mp\_utility::func_7EF9() + (0,0,384);
	}

	var_0A scripts\mp\killstreaks\_helicopter::func_1852("lbSniper");
	var_0A thread scripts\mp\killstreaks\_helicopter::func_E111();
	var_0A thread func_136B6();
	var_0A.var_AC68 = param_05;
	var_0A.var_143 = var_08;
	var_0A.var_C973 = var_09;
	var_0A.var_C96C = var_07;
	var_0A.var_C96B = param_01.origin;
	var_0A.var_7003 = var_07[2];
	var_0A.var_B4A3 = var_06.origin;
	var_0A.var_C537 = param_01.origin;
	var_0A.var_CB45 = var_0A.var_C537 + (0,0,300);
	var_0A.var_90F1 = var_0A.var_C537 + (0,0,600);
	var_0A.var_7338 = var_08[1];
	var_0A.var_273E = var_08[1] + 180;
	if(var_0A.var_273E > 360)
	{
		var_0A.var_273E = var_0A.var_273E - 360;
	}

	var_0A.var_8DD9 = "littlebird";
	var_0A.var_8DA0 = "littlebird";
	var_0A.var_AED3 = param_01.var_C6F9;
	var_0A.var_1CA6 = 1;
	var_0A.var_2550 = missile_createattractorent(var_0A,level.var_8D2E,level.var_8D2D);
	var_0A.var_9DBF = 0;
	var_0A.maxhealth = level.var_8D73;
	var_0A thread scripts\mp\killstreaks\_flares::func_6EAD(1);
	var_0A thread scripts\mp\killstreaks\_helicopter::func_8D40("heli_sniper",1);
	var_0A thread func_8DB4(param_04);
	var_0A.var_222 = param_00;
	var_0A.team = param_00.team;
	var_0A thread func_AB2F();
	var_0A.var_2B3 = 100;
	var_0A.var_1E2D = 100;
	var_0A.var_7247 = 40;
	var_0A setcandamage(1);
	var_0A method_830A(45,45);
	var_0A method_83E5(var_0A.var_2B3,100,40);
	var_0A method_8378(120,60);
	var_0A method_82F6(10,10,60);
	var_0A method_8316(512);
	var_0A.var_A644 = 0;
	var_0A.var_110EA = "heli_sniper";
	var_0A.var_1C79 = 0;
	var_0A.var_C834 = 0;
	var_0A method_8187("tag_wings");
	return var_0A;
}

//Function Number: 6
func_7DFC(param_00)
{
	self endon("death");
	self endon("crashing");
	self endon("helicopter_removed");
	self endon("heightReturned");
	var_01 = getent("airstrikeheight","targetname");
	if(isdefined(var_01))
	{
		var_02 = var_01.origin[2];
	}
	else if(isdefined(level.var_1AF8))
	{
		var_02 = 850 * level.var_1AF8;
	}
	else
	{
		var_02 = 850;
	}

	var_03 = bullettrace(param_00,param_00 - (0,0,10000),0,self,0,0,0,0);
	var_04 = var_03["position"][2];
	var_05 = 0;
	var_06 = 0;
	for(var_07 = 0;var_07 < 30;var_07++)
	{
		wait(0.05);
		var_08 = var_07 % 8;
		var_09 = var_07 * 7;
		switch(var_08)
		{
			case 0:
				var_05 = var_09;
				var_06 = var_09;
				break;

			case 1:
				var_05 = var_09 * -1;
				var_06 = var_09 * -1;
				break;

			case 2:
				var_05 = var_09 * -1;
				var_06 = var_09;
				break;

			case 3:
				var_05 = var_09;
				var_06 = var_09 * -1;
				break;

			case 4:
				var_05 = 0;
				var_06 = var_09 * -1;
				break;

			case 5:
				var_05 = var_09 * -1;
				var_06 = 0;
				break;

			case 6:
				var_05 = var_09;
				var_06 = 0;
				break;

			case 7:
				var_05 = 0;
				var_06 = var_09;
				break;

			default:
				break;
		}

		var_0A = bullettrace(param_00 + (var_05,var_06,1000),param_00 - (var_05,var_06,10000),0,self,0,0,0,0,0);
		if(isdefined(var_0A["entity"]))
		{
			continue;
		}

		if(var_0A["position"][2] + 145 > var_04)
		{
			var_04 = var_0A["position"][2] + 145;
		}
	}

	return var_04;
}

//Function Number: 7
func_8DC0(param_00,param_01)
{
	level endon("game_ended");
	param_00 endon("death");
	param_00 endon("crashing");
	param_00 endon("owner_disconnected");
	param_00 endon("killstreakExit");
	var_02 = func_7E37(self.origin);
	level thread scripts\mp\_utility::func_115DE("used_heli_sniper",self,self.team);
	if(isdefined(var_02.angles))
	{
		var_03 = var_02.angles;
	}
	else
	{
		var_03 = (0,0,0);
	}

	scripts\common\utility::func_1C6E(0);
	var_04 = param_00.var_7003;
	if(isdefined(var_02.var_BEAA[0]))
	{
		var_05 = var_02.var_BEAA[0];
	}
	else
	{
		var_05 = func_7E34(self.origin);
	}

	var_06 = anglestoforward(self.angles);
	var_07 = var_05.origin * (1,1,0) + (0,0,1) * var_04 + var_06 * -100;
	param_00.var_1157A = var_07;
	param_00.var_4BF7 = var_05;
	var_08 = func_BCD7(param_00);
	if(isdefined(var_08) && var_08 == "fail")
	{
		param_00 thread func_8DBE();
		return var_08;
	}

	thread func_C53A(param_00);
	return var_08;
}

//Function Number: 8
func_C53A(param_00)
{
	level endon("game_ended");
	param_00 endon("death");
	param_00 endon("crashing");
	param_00 endon("owner_disconnected");
	param_00 endon("killstreakExit");
	if(isdefined(self.var_9382))
	{
		func_52CD();
	}

	param_00 thread func_835D();
	param_00 method_8378(1,1,1,0.1);
	param_00 notify("picked_up_passenger");
	scripts\common\utility::func_1C6E(1);
	param_00 method_83E5(param_00.var_2B3,100,40);
	self.var_C53B = 1;
	self.var_8DD6 = param_00;
	param_00 endon("owner_death");
	param_00 thread func_DB16();
	param_00 thread func_AB2E();
	param_00 method_8362(param_00.var_1157A,1);
	param_00 thread func_8DB3();
	param_00 waittill("near_goal");
	param_00 thread func_8DBF();
	thread func_13A0D(param_00);
	wait(45);
	self notify("heli_sniper_timeout");
	func_5820(param_00);
}

//Function Number: 9
func_5820(param_00)
{
	param_00 notify("dropping");
	param_00 thread func_8DD1();
	param_00 waittill("at_dropoff");
	param_00 method_83E5(60);
	param_00 method_8378(180,180,180,0.3);
	wait(1);
	if(!scripts\mp\_utility::func_9F19(self))
	{
		return;
	}

	thread func_F881();
	self method_83A8();
	self allowjump(1);
	self setstance("stand");
	self.var_C53B = 0;
	self.var_8DD6 = undefined;
	param_00.var_C834 = 0;
	scripts\mp\_utility::func_141E("iw6_gm6helisnipe_mp_gm6scope");
	self enableweaponswitch();
	scripts\mp\_utility::setrecoilscale();
	var_01 = scripts\common\utility::getlastweapon();
	if(!self hasweapon(var_01))
	{
		var_01 = scripts\mp\killstreaks\_utility::func_7EB7();
	}

	scripts\mp\_utility::func_1136C(var_01);
	wait(1);
	if(isdefined(param_00))
	{
		param_00 thread func_8DBE();
	}
}

//Function Number: 10
func_13A0D(param_00)
{
	self endon("heli_sniper_timeout");
	param_00 thread scripts\mp\killstreaks\_killstreaks::func_1CA5("dropping");
	param_00 waittill("killstreakExit");
	func_5820(param_00);
}

//Function Number: 11
func_BCD7(param_00)
{
	self endon("disconnect");
	self visionsetnakedforplayer("black_bw",0.5);
	scripts\mp\_utility::func_F607("black_bw",0.5,1);
	var_01 = scripts\common\utility::waittill_any_timeout_1(0.5,"death");
	scripts\mp\_hostmigration::func_13834();
	if(var_01 == "death")
	{
		thread scripts\mp\killstreaks\_killstreaks::func_41D6(1);
		return "fail";
	}

	self cancelmantle();
	if(var_01 != "disconnect")
	{
		thread scripts\mp\killstreaks\_killstreaks::func_41D6(1,0.75);
		if(self.team == "spectator")
		{
			return "fail";
		}
	}

	param_00 func_24A6();
	if(!isalive(self))
	{
		return "fail";
	}

	level.var_8DD7 = param_00;
	level notify("update_uplink");
}

//Function Number: 12
func_52CD()
{
	foreach(var_01 in self.var_9382)
	{
		if(isdefined(var_01.var_3A9D) && var_01.var_3A9D == self)
		{
			self method_80F3();
			self.var_9D81 = undefined;
			self.var_3AA0 = undefined;
			if(isdefined(var_01.var_2C68))
			{
				var_01.var_2C68 delete();
			}

			var_01 delete();
			self enableweapons();
		}
	}
}

//Function Number: 13
func_8DB3()
{
	level endon("game_ended");
	self endon("death");
	self endon("crashing");
	self endon("leaving");
	self.var_222 endon("death");
	var_00 = self.origin + anglestoright(self.var_222.angles) * 1000;
	self.var_B00E = spawn("script_origin",var_00);
	self method_8305(self.var_B00E);
	self method_8378(360,120);
	for(;;)
	{
		wait(0.25);
		var_00 = self.origin + anglestoright(self.var_222.angles) * 1000;
		self.var_B00E.origin = var_00;
	}
}

//Function Number: 14
func_24A6()
{
	self.var_222 notify("force_cancel_sentry");
	self.var_222 notify("force_cancel_ims");
	self.var_222 notify("force_cancel_placement");
	self.var_222 notify("cancel_carryRemoteUAV");
	self.var_222 setplayerangles(self gettagangles("TAG_RIDER"));
	self.var_222 ridevehicle(self,40,70,10,70,1);
	self.var_222 setstance("crouch");
	self.var_222 allowjump(0);
	thread func_DE3E();
	self.var_C834 = 1;
	self notify("boarded");
	self.var_222.var_3F14 = self;
}

//Function Number: 15
func_8DD1()
{
	level endon("game_ended");
	self endon("death");
	self endon("crashing");
	self endon("owner_disconnected");
	self endon("owner_death");
	var_00 = undefined;
	var_01 = undefined;
	var_02 = undefined;
	var_03 = 0;
	foreach(var_05 in level.var_1A66)
	{
		if(!isdefined(var_05.var_EE79) || !issubstr(var_05.var_EE79,"pickupNode"))
		{
			continue;
		}

		var_06 = distancesquared(var_05.origin,self.origin);
		if(!isdefined(var_02) || var_06 < var_02)
		{
			var_01 = var_05;
			var_02 = var_06;
			if(var_05.var_EE79 == "pickupNodehigh")
			{
				var_03 = 1;
				continue;
			}

			var_03 = 0;
		}
	}

	if(scripts\mp\_utility::func_7F8B() == "mp_chasm")
	{
		if(var_01.origin == (-224,-1056,2376))
		{
			var_01.origin = (-304,-896,2376);
		}
	}

	if(var_03 && !bullettracepassed(self.origin,var_01.origin,0,self))
	{
		self method_8362(self.origin + (0,0,2300),1);
		func_137AB("near_goal","goal",5);
		var_08 = var_01.origin;
		var_08 = var_08 + (0,0,1500);
	}
	else if(var_02.origin[2] > self.origin[2])
	{
		var_08 = var_02.origin;
	}
	else
	{
		var_08 = var_02.origin * (1,1,0);
		var_08 = var_08 + (0,0,self.origin[2]);
	}

	self method_8362(var_08,1);
	var_09 = func_7DFC(var_08);
	var_0A = var_08 * (1,1,0);
	var_0B = var_0A + (0,0,var_09);
	func_137AB("near_goal","goal",5);
	self.var_BCB4 = 0;
	self method_8362(var_0B + (0,0,200),1);
	self.var_5D43 = 1;
	func_137AB("near_goal","goal",5);
	self.var_BCB4 = 1;
	self notify("at_dropoff");
}

//Function Number: 16
func_137AB(param_00,param_01,param_02)
{
	level endon("game_ended");
	self endon(param_00);
	self endon(param_01);
	wait(param_02);
}

//Function Number: 17
func_8DBF()
{
	level endon("game_ended");
	self endon("death");
	self endon("crashing");
	self.var_222 endon("death");
	self.var_222 endon("disconnect");
	self endon("dropping");
	self method_83E5(60,45,20);
	self method_8316(8);
	for(;;)
	{
		var_00 = self.var_222 getnormalizedmovement();
		if(var_00[0] >= 0.15 || var_00[1] >= 0.15 || var_00[0] <= -0.15 || var_00[1] <= -0.15)
		{
			thread func_B31F(var_00);
		}

		wait(0.05);
	}
}

//Function Number: 18
func_8DB8()
{
	self method_83E5(80,60,20);
	self method_8316(8);
	for(;;)
	{
		var_00 = self.var_222 getnormalizedmovement();
		if(var_00[0] >= 0.15 || var_00[1] >= 0.15 || var_00[0] <= -0.15 || var_00[1] <= -0.15)
		{
			thread func_B320(var_00);
		}

		wait(0.05);
	}
}

//Function Number: 19
func_B320(param_00)
{
	level endon("game_ended");
	self endon("death");
	self endon("crashing");
	self.var_222 endon("death");
	self.var_222 endon("disconnect");
	self endon("dropping");
	self notify("manualMove");
	self endon("manualMove");
	var_01 = anglestoforward(self.var_222.angles) * 350 * param_00[0];
	var_02 = anglestoright(self.var_222.angles) * 250 * param_00[1];
	var_03 = var_01 + var_02;
	var_04 = self.origin + var_03;
	var_04 = var_04 * (1,1,0);
	var_04 = var_04 + (0,0,self.var_B4A3[2]);
	if(distance2dsquared((0,0,0),var_04) > 8000000)
	{
		return;
	}

	self method_8362(var_04,1);
	self waittill("goal");
}

//Function Number: 20
func_B31F(param_00)
{
	level endon("game_ended");
	self endon("death");
	self endon("crashing");
	self.var_222 endon("death");
	self.var_222 endon("disconnect");
	self endon("dropping");
	self notify("manualMove");
	self endon("manualMove");
	var_01 = anglestoforward(self.var_222.angles) * 250 * param_00[0];
	var_02 = anglestoright(self.var_222.angles) * 250 * param_00[1];
	var_03 = var_01 + var_02;
	var_04 = 256;
	var_05 = self.origin + var_03;
	var_06 = scripts\mp\_utility::func_7EFA();
	var_07 = var_05 + scripts\mp\_utility::func_7EF9() + var_06;
	var_08 = var_05 + scripts\mp\_utility::func_7EF9() - var_06;
	var_09 = bullettrace(var_07,var_08,0,0,0,0,1);
	if(isdefined(var_09["entity"]) && var_09["normal"][2] > 0.1)
	{
		var_05 = var_09["position"] - scripts\mp\_utility::func_7EF9() + (0,0,var_04);
		var_0A = var_05[2] - self.origin[2];
		if(var_0A > 1000)
		{
			return;
		}

		self method_8362(var_05,1);
		self waittill("goal");
	}
}

//Function Number: 21
func_8DBE()
{
	level endon("game_ended");
	self endon("death");
	self endon("crashing");
	self notify("end_disconnect_check");
	self notify("end_death_check");
	self notify("leaving");
	if(isdefined(self.var_A79F))
	{
		self.var_A79F delete();
	}

	if(isdefined(self.trigger))
	{
		self.trigger delete();
	}

	if(isdefined(self.var_129B9))
	{
		self.var_129B9 delete();
	}

	if(isdefined(self.var_BD6D))
	{
		self.var_BD6D scripts\mp\_hud_util::destroyelem();
	}

	if(isdefined(self.var_1137A))
	{
		self.var_1137A scripts\mp\_hud_util::destroyelem();
	}

	if(isdefined(self.var_BCCF))
	{
		self.var_BCCF scripts\mp\_hud_util::destroyelem();
	}

	self method_8076();
	level.var_8DD7 = undefined;
	level notify("update_uplink");
	self method_8378(220,220,220,0.3);
	self method_83E5(120,60);
	self method_8362(self.origin + (0,0,1200),1);
	self waittill("goal");
	var_00 = self.var_C96B - self.var_C96C * 5000;
	self method_8362(var_00,1);
	self method_83E5(300,75);
	self.var_AB32 = 1;
	scripts\common\utility::waittill_any_timeout_1(5,"goal");
	if(isdefined(level.var_AAC8) && level.var_AAC8 == self)
	{
		level.var_AAC8 = undefined;
	}

	self notify("delete");
	self delete();
}

//Function Number: 22
func_8DB4(param_00)
{
	level endon("game_ended");
	self endon("leaving");
	self waittill("death");
	scripts\mp\_hostmigration::func_13834();
	thread scripts\mp\killstreaks\_helicopter::func_AAC7();
	if(isdefined(self.var_A79F))
	{
		self.var_A79F delete();
	}

	if(isdefined(self.trigger))
	{
		self.trigger delete();
	}

	if(isdefined(self.var_129B9))
	{
		self.var_129B9 delete();
	}

	if(isdefined(self.var_BD6D))
	{
		self.var_BD6D scripts\mp\_hud_util::destroyelem();
	}

	if(isdefined(self.var_1137A))
	{
		self.var_1137A scripts\mp\_hud_util::destroyelem();
	}

	if(isdefined(self.var_BCCF))
	{
		self.var_BCCF scripts\mp\_hud_util::destroyelem();
	}

	if(isdefined(self.var_222) && isalive(self.var_222) && self.var_C834 == 1)
	{
		self.var_222 method_83A8();
		var_01 = undefined;
		var_02 = undefined;
		if(isdefined(self.var_2507))
		{
			var_03 = 0;
			foreach(var_06, var_05 in self.var_2507)
			{
				if(var_05 >= var_03)
				{
					var_03 = var_05;
					var_01 = var_06;
				}
			}
		}

		if(isdefined(var_01))
		{
			foreach(var_08 in level.var_C928)
			{
				if(var_08 scripts\mp\_utility::func_81EC() == var_01)
				{
					var_02 = var_08;
				}
			}
		}

		var_0A = getdvarint("scr_team_fftype");
		if(isdefined(self.var_A667) && isdefined(self.var_A667.var_9E20))
		{
			self.var_A667 radiusdamage(self.var_222.origin,200,2600,2600,self.var_A667);
		}
		else if(isdefined(var_02) && var_0A != 2)
		{
			radiusdamage(self.var_222.origin,200,2600,2600,var_02);
		}
		else if(var_0A == 2 && isdefined(var_02) && scripts\mp\_utility::func_24F0(var_02,self.var_222))
		{
			radiusdamage(self.var_222.origin,200,2600,2600,var_02);
			radiusdamage(self.var_222.origin,200,2600,2600);
		}
		else
		{
			radiusdamage(self.var_222.origin,200,2600,2600);
		}

		self.var_222.var_C53B = 0;
		self.var_222.var_8DD6 = undefined;
	}
}

//Function Number: 23
func_F881()
{
	if(!scripts\mp\_utility::_hasperk("specialty_falldamage"))
	{
		level endon("game_ended");
		self endon("death");
		self endon("disconnect");
		scripts\mp\_utility::func_8387("specialty_falldamage");
		wait(2);
		scripts\mp\_utility::func_E150("specialty_falldamage");
	}
}

//Function Number: 24
func_DE3E()
{
	level endon("game_ended");
	self endon("death");
	self endon("crashing");
	self.var_222 endon("death");
	self.var_222 endon("disconnect");
	self endon("dropping");
	var_00 = 0;
	for(;;)
	{
		wait(0.05);
		if(!isdefined(self.var_222.var_ACAE) && !self.var_222 scripts\mp\_utility::func_9E59())
		{
			self.var_222 scripts\mp\perks\_perkfunctions::func_F785();
			var_00++;
			if(var_00 >= 2)
			{
				break;
			}
		}
	}
}

//Function Number: 25
func_A576()
{
	level endon("game_ended");
	self endon("death");
	self endon("crashing");
	self.var_222 endon("death");
	self.var_222 endon("disconnect");
	self endon("dropping");
	for(;;)
	{
		if(self.var_222 getstance() != "crouch")
		{
			self.var_222 setstance("crouch");
		}

		wait(0.05);
	}
}

//Function Number: 26
func_835D()
{
	level endon("game_ended");
	self endon("death");
	self endon("crashing");
	self endon("dropping");
	self.var_222 endon("disconnect");
	for(;;)
	{
		if(!isalive(self.var_222))
		{
			return "fail";
		}

		if(self.var_222 getcurrentprimaryweapon() != "iw6_gm6helisnipe_mp_gm6scope")
		{
			self.var_222 giveweapon("iw6_gm6helisnipe_mp_gm6scope");
			self.var_222 scripts\mp\_utility::_switchtoweaponimmediate("iw6_gm6helisnipe_mp_gm6scope");
			self.var_222 method_80AB();
			self.var_222 scripts\mp\_utility::setrecoilscale(0,100);
			self.var_222 givemaxammo("iw6_gm6helisnipe_mp_gm6scope");
		}
		else
		{
			return;
		}

		wait(0.05);
	}
}

//Function Number: 27
func_E2B9()
{
	level endon("game_ended");
	self endon("death");
	self endon("crashing");
	self.var_222 endon("death");
	self.var_222 endon("disconnect");
	self.var_222 endon("dropping");
	for(;;)
	{
		self.var_222 waittill("weapon_fired");
		self.var_222 givemaxammo("iw6_gm6helisnipe_mp_gm6scope");
	}
}

//Function Number: 28
func_DB16()
{
	level endon("game_ended");
	self.var_222 endon("disconnect");
	self endon("death");
	self endon("crashing");
	self.var_222 waittill("death");
	self.var_222.var_C53B = 0;
	self.var_222.var_8DD6 = undefined;
	self.var_C834 = 0;
	if(isdefined(self.origin))
	{
		physicsexplosionsphere(self.origin,200,200,1);
	}
}

//Function Number: 29
func_AB2F()
{
	level endon("game_ended");
	self endon("death");
	self endon("crashing");
	self endon("end_disconnect_check");
	self.var_222 waittill("disconnect");
	self notify("owner_disconnected");
	thread func_8DBE();
}

//Function Number: 30
func_AB2E()
{
	level endon("game_ended");
	self endon("death");
	self endon("crashing");
	self endon("end_death_check");
	self.var_222 waittill("death");
	self notify("owner_death");
	thread func_8DBE();
}

//Function Number: 31
func_7E34(param_00)
{
	var_01 = undefined;
	var_02 = 999999;
	foreach(var_04 in level.var_1A66)
	{
		var_05 = distance(var_04.origin,param_00);
		if(var_05 < var_02)
		{
			var_01 = var_04;
			var_02 = var_05;
		}
	}

	return var_01;
}

//Function Number: 32
func_136B6()
{
	var_00 = self getentitynumber();
	self waittill("death");
	level.var_AAC8 = undefined;
	if(isdefined(level.var_8DD7))
	{
		level.var_8DD7 = undefined;
		level notify("update_uplink");
	}
}