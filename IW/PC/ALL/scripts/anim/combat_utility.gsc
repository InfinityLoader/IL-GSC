/*******************************************************************
 * Decompiled By: Bog
 * Decompiled File: scripts\anim\combat_utility.gsc
 * Game: Call of Duty: Infinite Warfare
 * Platform: PC
 * Function Count: 80
 * Decompile Time: 3996 ms
 * Timestamp: 10/27/2023 12:00:16 AM
*******************************************************************/

//Function Number: 1
func_8197(param_00)
{
	var_01 = self method_815B() + (0,0,-3);
	var_02 = (var_01[0] - param_00[0],var_01[1] - param_00[1],var_01[2] - param_00[2]);
	var_02 = vectornormalize(var_02);
	var_03 = var_02[2] * -1;
	return var_03;
}

//Function Number: 2
func_8130()
{
	if(isplayer(self.var_10C))
	{
		return randomfloatrange(self.var_10C.var_86A9.var_B750,self.var_10C.var_86A9.var_B461);
	}

	return randomfloatrange(level.var_B750,level.var_B461);
}

//Function Number: 3
func_80E7()
{
	var_00 = gettime() - self.var_1491.var_A9ED / 1000;
	var_01 = func_7E12();
	if(var_01 > var_00)
	{
		return var_01 - var_00;
	}

	return 0;
}

//Function Number: 4
func_7E12()
{
	if(scripts\anim\utility_common::func_9FCA())
	{
		return randomfloatrange(0.15,0.55);
	}

	if(scripts\anim\utility_common::func_13C40())
	{
		return randomfloatrange(1,1.7);
	}

	if(scripts\anim\utility_common::func_9D4D())
	{
		return func_8130();
	}

	if(self.var_6B92)
	{
		return randomfloatrange(0.1,0.35);
	}

	return randomfloatrange(0.4,0.9);
}

//Function Number: 5
func_32BE()
{
	if(self.var_3250)
	{
		if(self.var_FED7 == "full" && !self.var_6B92)
		{
			if(self.var_1491.var_A9ED == gettime())
			{
				wait(0.05);
			}

			return;
		}

		var_00 = func_80E7();
		if(var_00)
		{
			wait(var_00);
		}
	}
}

//Function Number: 6
func_1A39()
{
	for(var_00 = int(60);var_00 > 0;var_00--)
	{
		if(isdefined(self.var_595D) || isdefined(self.var_10C) && isdefined(self.var_10C.var_5951))
		{
			wait(0.05);
			continue;
		}

		return 0;
	}

	return 1;
}

//Function Number: 7
func_FEDF()
{
	self endon("shoot_behavior_change");
	self endon("stopShooting");
	if(scripts\anim\utility_common::func_9E83())
	{
		if(isdefined(self.var_10C) && isai(self.var_10C) && distancesquared(level.player.origin,self.var_10C.origin) < 147456)
		{
			self.var_10C scripts\anim\battlechatter_ai::func_183F("infantry",self,1);
		}

		if(scripts\anim\utility_common::func_1311B() && issentient(self.var_10C))
		{
			wait(randomfloat(2));
		}
	}

	if(isdefined(self.var_10C) && distancesquared(self.origin,self.var_10C.origin) > 160000)
	{
		var_00 = randomintrange(1,5);
	}
	else
	{
		var_00 = 10;
	}

	for(;;)
	{
		func_32BE();
		if(func_1A39())
		{
			break;
		}

		if(self.var_FED7 == "full")
		{
			func_6D97(scripts\anim\utility::func_1F64("fire"),1,scripts\anim\shared::func_4F66());
		}
		else if(self.var_FED7 == "burst" || self.var_FED7 == "semi")
		{
			var_01 = scripts\anim\shared::func_4F65();
			if(var_01 == 1)
			{
				func_6D97(scripts\anim\utility::func_1F67("single"),1,var_01);
			}
			else
			{
				func_6D97(scripts\anim\utility::func_1F64(self.var_FED7 + var_01),1,var_01);
			}
		}
		else if(self.var_FED7 == "single")
		{
			func_6D97(scripts\anim\utility::func_1F67("single"),1,1);
		}
		else
		{
			self waittill("hell freezes over");
		}

		if(!self.var_3250)
		{
			break;
		}

		var_00--;
		if(var_00 < 0)
		{
			self.var_1006D = 1;
			break;
		}
	}
}

//Function Number: 8
func_81EB()
{
	level.var_1FB5++;
	return level.var_1FB5;
}

//Function Number: 9
func_FA8C(param_00)
{
	self method_82A2(%exposed_aiming,1,0.2);
	if(scripts\common\utility::func_167E())
	{
		self method_82E5("exposed_aim",scripts\anim\utility::func_1F64("straight_level"),1,param_00);
	}
	else
	{
		self method_82A9(scripts\anim\utility::func_1F64("straight_level"),1,param_00);
	}

	self method_82A9(scripts\anim\utility::func_1F64("add_aim_up"),1,param_00);
	self method_82A9(scripts\anim\utility::func_1F64("add_aim_down"),1,param_00);
	self method_82A9(scripts\anim\utility::func_1F64("add_aim_left"),1,param_00);
	self method_82A9(scripts\anim\utility::func_1F64("add_aim_right"),1,param_00);
	self.var_6A89 = scripts\anim\face::func_D475(undefined,"aim",self.var_6A89);
}

//Function Number: 10
func_10D9A()
{
	if(!isdefined(self.var_1491.var_1A3E))
	{
		func_FA8C(0.2);
		thread func_1A3E();
		thread scripts\anim\track::func_11B07();
	}
}

//Function Number: 11
func_631A()
{
	func_6309();
	self method_806F(%add_fire,0.1);
	self notify("stop tracking");
}

//Function Number: 12
func_10126()
{
	if(isdefined(self.var_1491.var_1A3E))
	{
		self method_82A2(%add_idle,0,0.2);
	}

	self method_82A2(%add_fire,1,0.1);
}

//Function Number: 13
func_8EBF()
{
	if(isdefined(self.var_1491.var_1A3E))
	{
		self method_82A2(%add_idle,1,0.2);
	}

	self method_82A2(%add_fire,0,0.1);
}

//Function Number: 14
func_1A3E(param_00)
{
	self endon("killanimscript");
	self endon("end_aim_idle_thread");
	if(isdefined(self.var_1491.var_1A3E))
	{
		return;
	}

	self.var_1491.var_1A3E = 1;
	wait(0.1);
	self method_82AC(%add_idle,1,0.2);
	var_01 = %add_idle;
	var_02 = 0;
	for(;;)
	{
		var_03 = "idle" + var_02;
		if(isdefined(self.var_1491.var_AAF2))
		{
			var_04 = scripts\anim\utility::func_1F67("lean_idle");
		}
		else if(scripts\anim\utility::func_1F65("exposed_idle"))
		{
			var_04 = scripts\anim\utility::func_1F67("exposed_idle");
		}
		else
		{
			wait(0.5);
		}
		else
		{
			if(var_04 == var_01)
			{
				self method_82E9(var_03,var_04,1,0.2);
			}
			else
			{
				self method_82E6(var_03,var_04,1,0.2);
			}

			var_01 = var_04;
			self waittillmatch("end",var_03);
		}

		var_02++;
	}

	self method_806F(%add_idle,0.1);
}

//Function Number: 15
func_6309()
{
	self notify("end_aim_idle_thread");
	self.var_1491.var_1A3E = undefined;
	self method_806F(%add_idle,0.1);
}

//Function Number: 16
func_FEFE()
{
	if(scripts\anim\utility_common::func_13C40())
	{
		return 1;
	}

	if(scripts\anim\weaponlist::func_1310F())
	{
		return scripts\anim\weaponlist::func_2691() * 0.7;
	}

	return 0.4;
}

//Function Number: 17
func_6D97(param_00,param_01,param_02)
{
	var_03 = "fireAnim_" + func_81EB();
	scripts\sp\_gameskill::func_E259();
	while(!func_1A3B())
	{
		wait(0.05);
	}

	func_10126();
	var_04 = 1;
	if(isdefined(self.var_FED4))
	{
		var_04 = self.var_FED4;
	}
	else if(self.var_FED7 == "full")
	{
		var_04 = scripts\anim\weaponlist::func_2691() * randomfloatrange(0.5,1);
	}
	else if(self.var_FED7 == "burst")
	{
		var_04 = scripts\anim\weaponlist::func_32C3();
	}
	else if(scripts\anim\utility_common::func_9FCA())
	{
		var_04 = 3;
	}
	else if(scripts\anim\utility_common::func_9FC9())
	{
		var_04 = func_FEFE();
	}

	self method_82E7(var_03,param_00,1,0.2,var_04);
	self method_83CE();
	func_6D99(var_03,param_00,param_01,param_02);
	func_8EBF();
}

//Function Number: 18
func_6D98()
{
	self endon("killanimscript");
	self endon("fireAnimEnd");
	var_00 = thisthread;
	for(;;)
	{
		waittillframeend;
		if(!isdefined(var_00))
		{
			self method_837D();
			return;
		}

		wait(0.05);
	}
}

//Function Number: 19
func_6D99(param_00,param_01,param_02,param_03)
{
	self endon("enemy");
	if(isplayer(self.var_10C) && self.var_FED7 == "full" || self.var_FED7 == "semi")
	{
		level endon("player_becoming_invulnerable");
	}

	if(param_02)
	{
		thread func_C168(param_00,"fireAnimEnd");
		self endon("fireAnimEnd");
	}

	if(!isdefined(param_03))
	{
		param_03 = -1;
	}

	var_04 = 0;
	var_05 = animhasnotetrack(param_01,"fire");
	var_06 = scripts\common\utility::func_13C07(self.var_394) == "rocketlauncher";
	thread func_6D98();
	while(var_04 < param_03 && param_03 > 0)
	{
		if(var_05)
		{
			self waittillmatch("fire",param_00);
		}

		if(!self.var_3250)
		{
			if(!scripts\anim\utility_common::func_3D55())
			{
				break;
			}
		}

		if(!func_1A3B())
		{
			break;
		}

		func_FE96();
		if(isplayer(self.var_10C) && self.var_10C scripts\sp\_utility::func_65DB("player_is_invulnerable"))
		{
			if(randomint(3) == 0)
			{
				self.var_3250--;
			}
		}
		else
		{
			self.var_3250--;
		}

		if(var_06)
		{
			self.var_1491.var_E5DE--;
			if(issubstr(tolower(self.var_394),"rpg") || issubstr(tolower(self.var_394),"panzerfaust"))
			{
				self method_8187("tag_rocket");
				self.var_1491.var_E5E3 = 0;
			}
		}

		var_04++;
		thread func_FEFF(param_00);
		if(self.var_6B92 && var_04 == param_03)
		{
			break;
		}

		if(!var_05 || param_03 == 1 && self.var_FED7 == "single")
		{
			self waittillmatch("end",param_00);
		}
	}

	self method_837D();
	if(param_02)
	{
		self notify("fireAnimEnd");
	}
}

//Function Number: 20
func_1A3B()
{
	if(!isdefined(self.var_FECF))
	{
		return 1;
	}

	var_00 = self method_8141();
	var_01 = scripts\anim\shared::func_811C();
	var_02 = vectortoangles(self.var_FECF - var_01);
	var_03 = scripts\common\utility::func_152F(var_00[1] - var_02[1]);
	if(var_03 > level.var_1A52)
	{
		if(distancesquared(self geteye(),self.var_FECF) > level.var_1A50 || var_03 > level.var_1A51)
		{
			return 0;
		}
	}

	return scripts\common\utility::func_152F(var_00[0] - var_02[0]) <= level.var_1A44;
}

//Function Number: 21
func_C168(param_00,param_01)
{
	self endon("killanimscript");
	self endon(param_01);
	self waittillmatch("end",param_00);
	self notify(param_01);
}

//Function Number: 22
func_9F57()
{
	if(function_023C(self.var_394) > 0)
	{
		return 0;
	}
	else if(function_0245(self.var_394) || function_02BE(self.var_394))
	{
		return 0;
	}

	return 1;
}

//Function Number: 23
func_FE96()
{
	var_00 = func_9F57();
	if(isdefined(self.var_FE9E))
	{
		if(isdefined(self.var_10C) && self.var_FE9E == self.var_10C)
		{
			scripts\anim\utility_common::func_FE9A(var_00);
		}
	}
	else
	{
		self [[ level.var_FED3 ]](self.var_FECF,var_00);
	}
}

//Function Number: 24
func_4FBE()
{
	if(self.var_3250)
	{
		self.var_3250--;
	}
}

//Function Number: 25
func_FEFF(param_00)
{
	if(!scripts\anim\utility_common::func_13C40())
	{
		return;
	}

	self endon("killanimscript");
	self notify("shotgun_pump_sound_end");
	self endon("shotgun_pump_sound_end");
	thread func_1108B(2);
	self waittillmatch("rechamber",param_00);
	self playsound("ai_shotgun_pump");
	self notify("shotgun_pump_sound_end");
}

//Function Number: 26
func_1108B(param_00)
{
	self endon("killanimscript");
	self endon("shotgun_pump_sound_end");
	wait(param_00);
	self notify("shotgun_pump_sound_end");
}

//Function Number: 27
func_DDCF(param_00)
{
}

//Function Number: 28
func_DB37()
{
	self endon("weapon_switch_done");
	self endon("death");
	self waittill("killanimscript");
	scripts\anim\shared::func_CC2C(self.var_D8E1,"right");
}

//Function Number: 29
func_0260(param_00,param_01)
{
}

//Function Number: 30
func_17CC(param_00,param_01)
{
	if(!isdefined(level.var_85DF))
	{
		anim.var_85DF = [];
		anim.var_85E1 = [];
	}

	var_02 = level.var_85DF.size;
	level.var_85DF[var_02] = param_00;
	level.var_85E1[var_02] = param_01;
}

//Function Number: 31
func_9812()
{
}

//Function Number: 32
func_7EE8(param_00)
{
	var_01 = (0,0,64);
	return var_01;
}

//Function Number: 33
func_11814()
{
	for(var_00 = 0;var_00 < level.players.size;var_00++)
	{
		if(level.players[var_00].var_C231 == 0)
		{
			level.players[var_00].var_85E4["frag"] = 0;
			level.players[var_00].var_85E4["flash_grenade"] = 0;
			level.players[var_00].var_85E4["seeker"] = 0;
		}
	}

	anim.var_11813 = 1;
}

//Function Number: 34
func_F62B(param_00)
{
	self.var_1652 = spawnstruct();
	if(isplayer(param_00))
	{
		self.var_1652.var_9EFB = 1;
		self.var_1652.player = param_00;
		self.var_1652.var_1191A = self.var_166;
		return;
	}

	self.var_1652.var_9EFB = 0;
	self.var_1652.var_1191A = "AI_" + self.var_166;
}

//Function Number: 35
func_13116()
{
	return self.var_1652.var_9EFB;
}

//Function Number: 36
func_F72C(param_00,param_01)
{
	if(param_00.var_9EFB)
	{
		var_02 = param_00.player;
		var_03 = var_02.var_85E4[param_00.var_1191A];
		var_02.var_85E4[param_00.var_1191A] = max(param_01,var_03);
		return;
	}

	var_03 = level.var_85E4[param_01.var_1191A];
	level.var_85E4[param_00.var_1191A] = max(param_01,var_03);
}

//Function Number: 37
func_7E6D()
{
	var_00 = undefined;
	if(func_13116())
	{
		var_01 = self.var_1652.player;
		var_00 = gettime() + var_01.var_86A9.var_D396 + randomint(var_01.var_86A9.var_D397);
	}
	else
	{
		var_00 = gettime() + 30000 + randomint(30000);
	}

	return var_00;
}

//Function Number: 38
func_7EE9(param_00)
{
	if(param_00.var_9EFB)
	{
		return param_00.player.var_85E4[param_00.var_1191A];
	}

	return level.var_85E4[param_00.var_1191A];
}

//Function Number: 39
func_453D(param_00)
{
	if(!isplayer(param_00) && self method_8198())
	{
		if(gettime() < func_7EE9(self.var_1652))
		{
			if(level.player.ignoreme)
			{
				return param_00;
			}

			var_01 = self method_8163();
			var_02 = level.player method_8163();
			if(var_01 != "" && var_02 != "" && function_00D7(var_02,var_01) < -10000)
			{
				return param_00;
			}

			if(self method_805F(level.player) || isai(param_00) && param_00 method_805F(level.player))
			{
				if(isdefined(self.var_473C))
				{
					var_03 = vectortoangles(level.player.origin - self.origin);
					var_04 = angleclamp180(self.var_473C.angles[1] - var_03[1]);
				}
				else
				{
					var_04 = scripts\common\utility::func_824D(level.player.origin);
				}

				if(abs(var_04) < 60)
				{
					param_00 = level.player;
					func_F62B(param_00);
				}
			}
		}
	}

	return param_00;
}

//Function Number: 40
func_B4EF(param_00)
{
	if(scripts\sp\_utility::func_D022())
	{
		return 0;
	}

	if(!param_00.var_86A9.var_5ACF)
	{
		return 0;
	}

	var_01 = gettime();
	if(var_01 < param_00.var_85E4["double_grenade"])
	{
		return 0;
	}

	if(var_01 > param_00.var_A98C + 3000)
	{
		return 0;
	}

	if(var_01 < param_00.var_A98C + 500)
	{
		return 0;
	}

	return param_00.var_C231 < 2;
}

//Function Number: 41
func_BE18()
{
	return gettime() >= self.var_1491.var_BF84;
}

//Function Number: 42
func_85B5(param_00)
{
	if(scripts\sp\_utility::func_D022())
	{
		return 0;
	}

	if(self.var_EDB1 == 1)
	{
		return 1;
	}

	if(!func_BE18())
	{
		return 0;
	}

	if(gettime() >= func_7EE9(self.var_1652))
	{
		return 1;
	}

	if(self.var_1652.var_9EFB && self.var_1652.var_1191A == "fraggrenade")
	{
		return func_B4EF(param_00);
	}

	return 0;
}

//Function Number: 43
func_128A1(param_00,param_01,param_02,param_03)
{
	if(!self method_81A2(param_00,param_01))
	{
		return 0;
	}
	else if(distancesquared(self.origin,param_01) < -25536)
	{
		return 0;
	}

	var_04 = physicstrace(param_01 + (0,0,1),param_01 + (0,0,-500));
	if(var_04 == param_01 + (0,0,-500))
	{
		return 0;
	}

	var_04 = var_04 + (0,0,0.1);
	return func_128A2(param_00,var_04,param_02,param_03);
}

//Function Number: 44
func_128A0(param_00,param_01)
{
	if(self.var_394 == "mg42" || self.var_162 <= 0)
	{
		return 0;
	}

	func_F62B(param_00);
	param_00 = func_453D(param_00);
	if(!func_85B5(param_00))
	{
		return 0;
	}

	var_02 = func_7EE8(param_01);
	if(isdefined(self.var_10C) && param_00 == self.var_10C)
	{
		if(!func_3E1C())
		{
			return 0;
		}

		if(scripts\anim\utility_common::func_3908())
		{
			if(!self method_81A2(param_00,param_00.origin))
			{
				return 0;
			}

			return func_128A2(param_00,undefined,param_01,var_02);
		}
		else if(scripts\anim\utility_common::func_3918())
		{
			return func_128A1(param_00,scripts\anim\utility::func_7E90(),param_01,var_02);
		}
		else
		{
			if(!self method_81A2(param_00,param_00.origin))
			{
				return 0;
			}

			return func_128A2(param_00,undefined,param_01,var_02);
		}

		return 0;
	}

	return func_128A1(param_00,param_00.origin,param_01,var_02);
}

//Function Number: 45
func_128A2(param_00,param_01,param_02,param_03,param_04,param_05,param_06)
{
}

//Function Number: 46
func_DE37(param_00)
{
	self endon("dont_reduce_giptp_on_killanimscript");
	self waittill("killanimscript");
	param_00.var_C231--;
}

//Function Number: 47
func_58BA(param_00,param_01,param_02,param_03)
{
	self endon("killanimscript");
	if(self.script == "combat" || self.script == "move")
	{
		self method_8221("face direction",param_01);
	}

	scripts\anim\battlechatter_ai::func_67CF(self.var_166);
	self notify("stop_aiming_at_enemy");
	self method_82E4("throwanim",param_00,%body,func_6B9A(),0.1,1);
	thread scripts\anim\notetracks::func_592D("throwanim","killanimscript");
	var_04 = scripts\anim\utility_common::func_7EE7();
	var_05 = "none";
	for(;;)
	{
		self waittill("throwanim",var_06);
		if(var_06 == "grenade_left" || var_06 == "grenade_right")
		{
			var_05 = func_2481(var_04,"TAG_INHAND");
			self.var_9E33 = 1;
		}

		if(var_06 == "grenade_throw" || var_06 == "grenade throw")
		{
			break;
		}

		if(var_06 == "end")
		{
			self.var_1652.player.var_C231--;
			self notify("dont_reduce_giptp_on_killanimscript");
			return 0;
		}
	}

	self notify("dont_reduce_giptp_on_killanimscript");
	if(func_13116())
	{
		thread func_13A98(self.var_1652.player,param_02);
	}

	self method_83C2();
	if(!func_13116())
	{
		func_F72C(self.var_1652,param_02);
	}

	if(param_03)
	{
		var_0D = self.var_1652.player;
		if(var_0D.var_C231 > 1 || gettime() - var_0D.var_A990 < 2000)
		{
			var_0D.var_85E4["double_grenade"] = gettime() + min(5000,var_0D.var_86A9.var_D382);
		}
	}

	self notify("stop grenade check");
	if(var_05 != "none")
	{
		self detach(var_04,var_05);
	}
	else
	{
	}

	self.var_9E33 = undefined;
	self.var_163 = self.var_C3F3;
	self.var_C3F3 = undefined;
	self waittillmatch("end","throwanim");
	self notify("done_grenade_throw");
	self notify("weapon_switch_done");
	self method_82A2(%exposed_modern,1,0.2);
	self method_82A2(%exposed_aiming,1);
	self method_806F(param_00,0.2);
}

//Function Number: 48
func_13A98(param_00,param_01)
{
	param_00 endon("death");
	func_13A99(param_01);
	param_00.var_C231--;
}

//Function Number: 49
func_13A99(param_00)
{
	var_01 = self.var_1652;
	var_02 = spawnstruct();
	var_02 thread func_13A9A(5);
	var_02 endon("watchGrenadeTowardsPlayerTimeout");
	var_03 = self.var_166;
	var_04 = func_7EE6();
	if(!isdefined(var_04))
	{
		return;
	}

	func_F72C(var_01,min(gettime() + 5000,param_00));
	var_05 = -3036;
	var_06 = 160000;
	if(var_03 == "flash_grenade")
	{
		var_05 = 810000;
		var_06 = 1690000;
	}

	var_07 = level.players;
	var_08 = var_04.origin;
	for(;;)
	{
		wait(0.1);
		if(!isdefined(var_04))
		{
			break;
		}

		if(distancesquared(var_04.origin,var_08) < 400)
		{
			var_09 = [];
			for(var_0A = 0;var_0A < var_07.size;var_0A++)
			{
				var_0B = var_07[var_0A];
				var_0C = distancesquared(var_04.origin,var_0B.origin);
				if(var_0C < var_05)
				{
					var_0B func_85C8(var_01,param_00);
					continue;
				}

				if(var_0C < var_06)
				{
					var_09[var_09.size] = var_0B;
				}
			}

			var_07 = var_09;
			if(var_07.size == 0)
			{
				break;
			}
		}

		var_08 = var_04.origin;
	}
}

//Function Number: 50
func_85C8(param_00,param_01)
{
	var_02 = self;
	anim.var_11813 = undefined;
	if(gettime() - var_02.var_A990 < 3000)
	{
		var_02.var_85E4["double_grenade"] = gettime() + var_02.var_86A9.var_D382;
	}

	var_02.var_A990 = gettime();
	var_03 = var_02.var_85E4[param_00.var_1191A];
	var_02.var_85E4[param_00.var_1191A] = max(param_01,var_03);
}

//Function Number: 51
func_7EE6()
{
	self endon("killanimscript");
	self waittill("grenade_fire",var_00);
	return var_00;
}

//Function Number: 52
func_13A9A(param_00)
{
	wait(param_00);
	self notify("watchGrenadeTowardsPlayerTimeout");
}

//Function Number: 53
func_2481(param_00,param_01)
{
	self attach(param_00,param_01);
	thread func_5392(param_00,param_01);
	return param_01;
}

//Function Number: 54
func_5392(param_00,param_01)
{
	self endon("stop grenade check");
	self waittill("killanimscript");
	if(!isdefined(self))
	{
		return;
	}

	if(isdefined(self.var_C3F3))
	{
		self.var_163 = self.var_C3F3;
		self.var_C3F3 = undefined;
	}

	self detach(param_00,param_01);
}

//Function Number: 55
func_C371(param_00)
{
	var_01 = anglestoforward(self.angles);
	var_02 = anglestoright(self.angles);
	var_03 = anglestoup(self.angles);
	var_01 = var_01 * param_00[0];
	var_02 = var_02 * param_00[1];
	var_03 = var_03 * param_00[2];
	return var_01 + var_02 + var_03;
}

//Function Number: 56
func_85C9(param_00,param_01)
{
	level notify("armoffset");
	level endon("armoffset");
	param_00 = self.origin + func_C371(param_00);
	wait(0.05);
}

//Function Number: 57
func_7EE3()
{
	var_00 = randomfloat(360);
	var_01 = randomfloatrange(30,75);
	var_02 = sin(var_01);
	var_03 = cos(var_01);
	var_04 = cos(var_00) * var_03;
	var_05 = sin(var_00) * var_03;
	var_06 = randomfloatrange(100,200);
	var_07 = (var_04,var_05,var_02) * var_06;
	return var_07;
}

//Function Number: 58
func_5D29()
{
	var_00 = self gettagorigin("tag_accessory_right");
	var_01 = func_7EE3();
	self method_81EE(var_00,var_01,3);
}

//Function Number: 59
func_B019()
{
	if(!isdefined(self.var_10C))
	{
		return 0;
	}

	if(self.var_132 || self.var_FC)
	{
		return 0;
	}

	var_00 = func_7DFB();
	if(isdefined(var_00))
	{
		return func_13059(var_00);
	}

	return 0;
}

//Function Number: 60
func_7DFB()
{
	var_00 = self method_80E3();
	if(!isdefined(var_00))
	{
		return undefined;
	}

	var_01 = scripts\anim\utility_common::func_7E28();
	if(isdefined(var_01) && var_00 == var_01)
	{
		return undefined;
	}

	if(isdefined(self.var_473C) && var_00 == self.var_473C)
	{
		return undefined;
	}

	return var_00;
}

//Function Number: 61
func_13059(param_00)
{
	var_01 = self.var_1A4;
	var_02 = self.var_1A3;
	self.var_1A4 = 0;
	self.var_1A3 = 0;
	if(self method_83D4(param_00))
	{
		return 1;
	}
	else
	{
	}

	self.var_1A4 = var_01;
	self.var_1A3 = var_02;
	return 0;
}

//Function Number: 62
func_10026()
{
	if(level.var_18D5[self.team] > 0 && level.var_18D5[self.team] < level.var_18D6)
	{
		if(gettime() - level.var_A936[self.team] > 4000)
		{
			return 0;
		}

		var_00 = level.var_A933[self.team];
		if(var_00 == self)
		{
			return 0;
		}

		var_01 = isdefined(var_00) && distancesquared(self.origin,var_00.origin) < 65536;
		if((var_01 || distancesquared(self.origin,level.var_A935[self.team]) < 65536) && !isdefined(self.var_10C) || distancesquared(self.var_10C.origin,level.var_A934[self.team]) < 262144)
		{
			return 1;
		}
	}

	return 0;
}

//Function Number: 63
func_3DE5()
{
	if(!isdefined(level.var_A936[self.team]))
	{
		return 0;
	}

	if(func_10026())
	{
		return 1;
	}

	if(gettime() - level.var_A936[self.team] < level.var_18D7)
	{
		return 0;
	}

	if(!issentient(self.var_10C))
	{
		return 0;
	}

	if(level.var_18D5[self.team])
	{
		level.var_18D5[self.team] = 0;
	}

	var_00 = isdefined(self.var_18CC) && self.var_18CC;
	if(!var_00 && function_0073(self.team) < function_0073(self.var_10C.team))
	{
		return 0;
	}

	return 1;
}

//Function Number: 64
func_128AA(param_00)
{
	if(!isdefined(self.var_10C))
	{
		return 0;
	}

	if(self.var_132)
	{
		return 0;
	}

	if(self.var_BC == "ambush" || self.var_BC == "ambush_nodes_only")
	{
		return 0;
	}

	if(!self method_81A5(self.var_10C.origin))
	{
		return 0;
	}

	if(scripts\anim\utility_common::func_9E83())
	{
		return 0;
	}

	if(!func_3DE5())
	{
		return 0;
	}

	if(isdefined(self.var_36F) && self.var_36F)
	{
		return 0;
	}

	self method_80E6(param_00);
	if(self method_8254())
	{
		self.var_1A4 = 0;
		self.var_1A3 = 0;
		self.var_1491.var_B168 = 1;
		if(level.var_18D5[self.team] == 0)
		{
			level.var_A936[self.team] = gettime();
			level.var_A933[self.team] = self;
		}

		level.var_A935[self.team] = self.origin;
		level.var_A934[self.team] = self.var_10C.origin;
		level.var_18D5[self.team]++;
		return 1;
	}

	return 0;
}

//Function Number: 65
func_50FB(param_00)
{
	self endon("death");
	wait(0.5);
	var_01 = "" + level.var_2755;
	badplace_cylinder(var_01,5,param_00,16,64,self.team);
	level.var_2759[level.var_2759.size] = var_01;
	if(level.var_2759.size >= 10)
	{
		var_02 = [];
		for(var_03 = 1;var_03 < level.var_2759.size;var_03++)
		{
			var_02[var_02.size] = level.var_2759[var_03];
		}

		badplace_delete(level.var_2759[0]);
		anim.var_2759 = var_02;
	}

	level.var_2755++;
	if(level.var_2755 > 10)
	{
		anim.var_2755 = level.var_2755 - 20;
	}
}

//Function Number: 66
func_13156(param_00,param_01,param_02)
{
	if(param_00 > param_01 && param_00 < param_02)
	{
		return 1;
	}

	return 0;
}

//Function Number: 67
func_7EEC()
{
	if(!isdefined(self.var_FECF))
	{
		return 0;
	}

	var_00 = self method_8141()[1] - scripts\common\utility::func_8246(self.var_FECF);
	var_00 = angleclamp180(var_00);
	return var_00;
}

//Function Number: 68
func_7EEB()
{
	if(!isdefined(self.var_FECF))
	{
		return 0;
	}

	var_00 = self method_8141()[0] - vectortoangles(self.var_FECF - self method_8142())[0];
	var_00 = angleclamp180(var_00);
	return var_00;
}

//Function Number: 69
func_8062()
{
	if(!isdefined(self.var_10C))
	{
		return 0;
	}

	var_00 = self.var_10C method_815B() - self method_815B();
	var_00 = vectornormalize(var_00);
	var_01 = vectortoangles(var_00)[0];
	return angleclamp180(var_01);
}

//Function Number: 70
func_8065(param_00)
{
	if(!isdefined(param_00))
	{
		return 0;
	}

	var_01 = param_00 - self method_815B();
	var_01 = vectornormalize(var_01);
	var_02 = vectortoangles(var_01)[0];
	return angleclamp180(var_02);
}

//Function Number: 71
func_8063(param_00,param_01)
{
	if(!isdefined(param_00) || !isdefined(param_01))
	{
		return 0;
	}

	if(isdefined(self) && scripts\common\utility::func_167E())
	{
		var_02 = anglestoforward(self.angles);
		var_03 = rotatepointaroundvector(var_02,param_00 - self.origin,self.angles[2] * -1);
		param_00 = var_03 + self.origin;
	}

	var_04 = param_00 - param_01;
	var_04 = vectornormalize(var_04);
	var_05 = vectortoangles(var_04)[0];
	return angleclamp180(var_05);
}

//Function Number: 72
func_13B22()
{
	self.var_9F21 = 0;
	self.var_A9DC = -1;
	for(;;)
	{
		self waittill("reload_start");
		self.var_9F21 = 1;
		self.var_A9DC = gettime();
		scripts\anim\battlechatter_ai::func_67D4();
		func_1383F();
		self.var_9F21 = 0;
	}
}

//Function Number: 73
func_1383F()
{
	thread func_118EC(4,"reloadtimeout");
	self endon("reloadtimeout");
	self endon("weapon_taken");
	for(;;)
	{
		self waittill("reload");
		var_00 = self getcurrentweapon();
		if(var_00 == "none")
		{
			break;
		}

		if(self method_8118() >= weaponclipsize(var_00))
		{
			break;
		}
	}

	self notify("reloadtimeout");
}

//Function Number: 74
func_118EC(param_00,param_01)
{
	self endon(param_01);
	wait(param_00);
	self notify(param_01);
}

//Function Number: 75
func_3E1C()
{
	var_00 = self.var_10C.origin - self.origin;
	var_01 = lengthsquared((var_00[0],var_00[1],0));
	if(self.var_166 == "flash_grenade")
	{
		return var_01 < 589824;
	}

	return var_01 >= -25536 && var_01 <= 1562500;
}

//Function Number: 76
func_B9D9()
{
	self endon("death");
	if(!isdefined(level.var_BEFB))
	{
		self endon("stop_monitoring_flash");
	}

	for(;;)
	{
		var_00 = undefined;
		var_01 = undefined;
		var_02 = undefined;
		var_03 = undefined;
		var_04 = undefined;
		self waittill("flashbang",var_01,var_00,var_02,var_03,var_04);
		if(isdefined(self.var_6EC4) && self.var_6EC4)
		{
			continue;
		}

		if(isdefined(self.var_EDE6) && self.var_EDE6 != 0)
		{
			continue;
		}

		if(isdefined(self.team) && isdefined(var_04) && self.team == var_04)
		{
			var_00 = 3 * var_00 - 0.75;
			if(var_00 < 0)
			{
				continue;
			}

			if(isdefined(self.var_115CE))
			{
				continue;
			}
		}

		var_05 = 0.2;
		if(var_00 > 1 - var_05)
		{
			var_00 = 1;
		}
		else
		{
			var_00 = var_00 / 1 - var_05;
		}

		var_06 = 4.5 * var_00;
		if(var_06 < 0.25)
		{
			continue;
		}

		self.var_6ECE = var_04;
		scripts\sp\_utility::func_6EC6(var_06);
		self notify("doFlashBanged",var_01,var_03);
	}
}

//Function Number: 77
func_6B9A()
{
	return 1.5;
}

//Function Number: 78
func_DCAD()
{
	return randomfloatrange(1,1.2);
}

//Function Number: 79
func_80B5(param_00)
{
	if(param_00.size == 0)
	{
		return undefined;
	}

	if(param_00.size == 1)
	{
		return param_00[0];
	}

	if(isdefined(self.var_1491.var_D892) && randomint(100) > 20)
	{
		foreach(var_03, var_02 in param_00)
		{
			if(var_02 == self.var_1491.var_D892)
			{
				if(var_03 < param_00.size - 1)
				{
					param_00[var_03] = param_00[param_00.size - 1];
				}

				param_00[param_00.size - 1] = undefined;
				break;
			}
		}
	}

	return param_00[randomint(param_00.size)];
}

//Function Number: 80
func_D285()
{
	var_00 = self geteye();
	foreach(var_02 in level.players)
	{
		if(!self method_805F(var_02))
		{
			continue;
		}

		var_03 = var_02 geteye();
		var_04 = vectortoangles(var_00 - var_03);
		var_05 = anglestoforward(var_04);
		var_06 = var_02 getplayerangles();
		var_07 = anglestoforward(var_06);
		var_08 = vectordot(var_05,var_07);
		if(var_08 < 0.805)
		{
			continue;
		}

		if(scripts\common\utility::func_4347() && var_08 >= 0.996)
		{
			continue;
		}

		return 1;
	}

	return 0;
}