/*******************************************************************
 * Decompiled By: Bog
 * Decompiled File: scripts\mp\killstreaks\_jammer_drone.gsc
 * Game: Call of Duty: Infinite Warfare
 * Platform: PC
 * Function Count: 26
 * Decompile Time: 1317 ms
 * Timestamp: 10/27/2023 12:28:56 AM
*******************************************************************/

//Function Number: 1
init()
{
	level.var_115C9["allies"] = 0;
	level.var_115C9["axis"] = 0;
	level.var_61AD = undefined;
	level.var_61B5 = 10;
	level.var_61B6 = int(level.var_61B5);
	scripts\mp\killstreaks\_killstreaks::func_DEFB("jammer",::func_618B);
	level.var_A434["air_patrol"] = spawnstruct();
	level.var_A434["air_patrol"].var_AC75 = 60;
	level.var_A434["air_patrol"].health = 99999;
	level.var_A434["air_patrol"].maxhealth = 1000;
	level.var_A434["air_patrol"].var_110EA = "jammer";
	level.var_A434["air_patrol"].var_13260 = "veh_jammer_drone_mp";
	level.var_A434["air_patrol"].var_F268 = "sentry_offline";
	level.var_A434["air_patrol"].var_B91A = "veh_jammer_drone_model";
	level.var_A434["air_patrol"].var_A84D = "killstreak_remote_tank_laptop_mp";
	level.var_A434["air_patrol"].var_DF7B = "killstreak_remote_tank_remote_mp";
	level.var_A434["air_patrol"].var_12A72 = "sentry_shock_mp";
	level._effect["jammer_drone_explode"] = loadfx("vfx/iw7/_requests/mp/vfx_jammer_drone_explosion");
	level._effect["jammer_drone_spark"] = loadfx("vfx/core/impacts/large_metal_painted_hit");
	level._effect["jammer_drone_pulse"] = loadfx("vfx/iw7/_requests/mp/vfx_jammer_drone_emp_pulse");
	level._effect["jammer_drone_charge"] = loadfx("vfx/iw7/_requests/mp/vfx_jammer_drone_emp_charge");
	level._effect["jammer_drone_shockwave"] = loadfx("vfx/iw7/_requests/mp/vfx_jammer_drone_emp_shockwave");
	func_F764();
	func_F765();
}

//Function Number: 2
func_F764()
{
	level.var_A433 = scripts\common\utility::getstructarray("jammer_drone_start","targetname");
}

//Function Number: 3
func_F765()
{
	level.var_A432 = scripts\common\utility::getstructarray("jammer_drone_emp","script_noteworthy");
}

//Function Number: 4
func_618B(param_00)
{
	var_01 = 1;
	var_02 = func_7E37(self.origin);
	var_03 = func_6CBF(var_02);
	var_04 = vectortoangles(var_03.origin - var_02.origin);
	if(!isdefined(level.var_A433) || !isdefined(var_02) || !isdefined(var_03))
	{
		scripts\mp\_hud_message::func_10122("KILLSTREAKS_UNAVAILABLE_IN_LEVEL");
		return 0;
	}

	if(scripts\mp\_utility::func_4BD7() >= scripts\mp\_utility::func_B4D2() || level.var_6BAA + var_01 >= scripts\mp\_utility::func_B4D2())
	{
		scripts\mp\_hud_message::func_10122("KILLSTREAKS_TOO_MANY_VEHICLES");
		return 0;
	}

	scripts\mp\_utility::func_93FA();
	var_05 = func_49DE(self,var_02,var_03,var_04,"air_patrol",param_00.var_110EA,param_00.var_AC68);
	if(!isdefined(var_05))
	{
		return 0;
	}

	thread func_376F(var_05);
	return 1;
}

//Function Number: 5
func_49DE(param_00,param_01,param_02,param_03,param_04,param_05,param_06)
{
	var_07 = getent("airstrikeheight","targetname");
	var_08 = param_02.origin;
	var_09 = anglestoforward(param_03);
	var_0A = param_01.origin;
	var_0B = spawnhelicopter(param_00,var_0A,var_09,level.var_A434[param_04].var_13260,level.var_A434[param_04].var_B91A);
	if(!isdefined(var_0B))
	{
		return;
	}

	var_0B method_80C7();
	var_0B method_81FA(1);
	var_0B.health = level.var_A434[param_04].health;
	var_0B.maxhealth = level.var_A434[param_04].maxhealth;
	var_0B.var_E1 = 0;
	var_0B.var_10955 = ::func_3758;
	var_0B.var_AC68 = param_06;
	var_0B.var_2B3 = 200;
	var_0B.var_222 = param_00;
	var_0B.team = param_00.team;
	var_0B.var_52D0 = 0;
	var_0B.var_A436 = param_04;
	var_0B.var_110EA = param_05;
	var_0B.var_61A3 = 0;
	var_0B.var_143 = var_09;
	var_0B.var_C973 = var_0A;
	var_0B.var_C96C = var_08;
	var_0B.var_4BF7 = param_02;
	var_0B.var_A435 = 0;
	var_0B scripts\mp\killstreaks\_utility::func_1843(param_05,"Killstreak_Air",param_00,1);
	var_0B method_83E5(var_0B.var_2B3,70,50);
	var_0B method_8378(120,90);
	var_0B method_8316(150);
	var_0B method_82F6(20,10,5);
	var_0B method_831F(param_00);
	var_0B setcandamage(1);
	var_0B scripts\mp\sentientpoolmanager::registersentient("Killstreak_Air",param_00);
	var_0B thread func_5C29();
	var_0B thread func_5C2A();
	var_0B thread func_5C26();
	var_0B thread func_5C28();
	var_0B thread func_5C2B();
	var_0B thread func_5C27();
	return var_0B;
}

//Function Number: 6
func_376F(param_00)
{
	self endon("disconnect");
	level endon("game_ended");
	param_00 endon("death");
	var_01 = 1;
	var_02 = undefined;
	thread scripts\mp\_utility::func_115DE("used_jammer",self);
	for(;;)
	{
		if(param_00.var_A435 && !isdefined(var_02))
		{
			playfxontag(scripts\common\utility::getfx("jammer_drone_pulse"),param_00,"tag_origin");
			var_02 = 1;
		}
		else if(!param_00.var_A435 && isdefined(var_02))
		{
			stopfxontag(scripts\common\utility::getfx("jammer_drone_pulse"),param_00,"tag_origin");
			var_02 = undefined;
		}

		param_00 method_8362(param_00.var_C96C,var_01);
		param_00 waittill("near_goal");
		if(func_9DD5(param_00.var_4BF7) && !param_00.var_A435)
		{
			param_00 waittill("goal");
		}

		if(!isdefined(param_00.var_DD1C))
		{
			param_00 method_83E5(10,5,500);
			param_00.var_DD1C = 1;
		}

		if(func_9DD5(param_00.var_4BF7) && !param_00.var_A435)
		{
			param_00 thread func_5C83(self);
			param_00 waittill("finished_emp_pulse");
		}

		param_00.var_4BF7 = func_6CBF(param_00.var_4BF7);
		param_00.var_C96C = param_00.var_4BF7.origin;
		if(func_9DD5(param_00.var_4BF7) && !param_00.var_A435)
		{
			var_01 = 1;
			continue;
		}

		var_01 = 0;
	}
}

//Function Number: 7
func_9DD5(param_00)
{
	var_01 = 0;
	foreach(var_03 in level.var_A432)
	{
		if(param_00 == var_03)
		{
			var_01 = 1;
			break;
		}
	}

	return var_01;
}

//Function Number: 8
func_6CBF(param_00)
{
	var_01 = param_00.target;
	var_02 = scripts\common\utility::getstruct(var_01,"targetname");
	return var_02;
}

//Function Number: 9
func_3758(param_00,param_01,param_02,param_03,param_04,param_05,param_06,param_07,param_08,param_09,param_0A,param_0B)
{
	var_0C = self;
	if(isdefined(var_0C.var_1D41) && var_0C.var_1D41)
	{
		return;
	}

	if(!scripts\mp\_weapons::func_7415(var_0C.var_222,param_01))
	{
		return;
	}

	if(isdefined(param_03) && param_03 & level.var_92C4)
	{
		var_0C.var_1390E = 1;
	}

	if(isdefined(param_03) && param_03 & level.var_92C6)
	{
		self.var_1390F = 1;
	}

	var_0C.var_1390B = 1;
	if(isdefined(param_05))
	{
		switch(param_05)
		{
			case "precision_airstrike_mp":
				param_02 = param_02 * 4;
				break;
		}
	}

	if(param_04 == "MOD_MELEE")
	{
		param_02 = var_0C.maxhealth * 0.5;
	}

	var_0D = param_02;
	if(isplayer(param_01))
	{
		param_01 scripts\mp\_damagefeedback::func_12E84("");
		if(param_04 == "MOD_RIFLE_BULLET" || param_04 == "MOD_PISTOL_BULLET")
		{
			if(param_01 scripts\mp\_utility::_hasperk("specialty_armorpiercing"))
			{
				var_0D = var_0D + param_02 * level.var_218B;
			}
		}

		if(function_0107(param_04))
		{
			var_0D = var_0D + param_02;
		}
	}

	if(function_0107(param_04) && isdefined(param_05) && param_05 == "destructible_car")
	{
		var_0D = var_0C.maxhealth;
	}

	if(isdefined(param_01.var_222) && isplayer(param_01.var_222))
	{
		param_01.var_222 scripts\mp\_damagefeedback::func_12E84("");
	}

	if(isdefined(param_05))
	{
		switch(param_05)
		{
			case "remotemissile_projectile_mp":
			case "javelin_mp":
			case "remote_mortar_missile_mp":
			case "stinger_mp":
			case "ac130_40mm_mp":
			case "ac130_105mm_mp":
				var_0C.var_A859 = 1;
				var_0D = var_0C.maxhealth + 1;
				break;

			case "stealth_bomb_mp":
			case "artillery_mp":
				var_0C.var_A859 = 0;
				var_0D = var_0C.maxhealth * 0.5;
				break;

			case "bomb_site_mp":
				var_0C.var_A859 = 0;
				var_0D = var_0C.maxhealth + 1;
				break;

			case "emp_grenade_mp":
				var_0D = 0;
				break;

			case "ims_projectile_mp":
				var_0C.var_A859 = 1;
				var_0D = var_0C.maxhealth * 0.5;
				break;
		}

		scripts\mp\killstreaks\_killstreaks::func_A6A0(param_01,param_05,self);
	}

	var_0C.var_E1 = var_0C.var_E1 + var_0D;
	if(var_0C.var_E1 >= var_0C.maxhealth)
	{
		if(isplayer(param_01) && !isdefined(var_0C.var_222) || param_01 != var_0C.var_222)
		{
			var_0C.var_1D41 = 1;
			var_0C scripts\mp\_damage::func_C548("jammer",param_01,param_05,param_04,param_02,"destroyed_" + var_0C.var_110EA,var_0C.var_110EA + "_destroyed","callout_destroyed_" + var_0C.var_110EA,1);
		}

		var_0C notify("death");
	}
}

//Function Number: 10
func_5C29()
{
	self endon("death");
	self.var_222 waittill("disconnect");
	self notify("death");
}

//Function Number: 11
func_5C2A()
{
	self endon("death");
	self.var_222 waittill("stop_using_remote");
	self notify("death");
}

//Function Number: 12
func_5C26()
{
	self endon("death");
	self.var_222 scripts\common\utility::waittill_any_3("joined_team","joined_spectators");
	self notify("death");
}

//Function Number: 13
func_5C2B()
{
	self endon("death");
	var_00 = level.var_A434[self.var_A436].var_AC75;
	scripts\mp\_hostmigration::func_13708(var_00);
	self notify("death");
}

//Function Number: 14
func_5C27()
{
	self endon("death");
	level endon("game_ended");
	for(;;)
	{
		self waittill("damage",var_00,var_01,var_02,var_03,var_04,var_05,var_06,var_07,var_08,var_09);
		if(isdefined(self.var_10955))
		{
			self [[ self.var_10955 ]](undefined,var_01,var_00,var_08,var_04,var_09,var_03,var_02,undefined,undefined,var_05,var_07);
		}
	}
}

//Function Number: 15
func_5C28()
{
	level endon("game_ended");
	self waittill("death");
	self playsound("sentry_explode");
	playfx(level._effect["jammer_drone_explode"],self.origin);
	scripts\mp\_utility::func_4FC1();
	self delete();
}

//Function Number: 16
func_5C83(param_00)
{
	self endon("death");
	self.var_A435 = 1;
	self playsound("jammer_drone_charge");
	playfxontag(scripts\common\utility::getfx("jammer_drone_charge"),self,"tag_origin");
	wait(1.5);
	stopfxontag(scripts\common\utility::getfx("jammer_drone_charge"),self,"tag_origin");
	playfxontag(scripts\common\utility::getfx("jammer_drone_shockwave"),self,"tag_origin");
	self playsound("jammer_drone_shockwave");
	thread func_61AF();
	var_01 = param_00.pers["team"];
	if(level.teambased)
	{
		var_02 = scripts\mp\_utility::getotherteam(var_01);
		thread func_6165(var_02,param_00);
	}
	else
	{
		thread func_6164(param_00);
	}

	param_00 scripts\mp\_matchdata::func_AFC9("jammer",self.origin);
	level notify("emp_used");
	self notify("finished_emp_pulse");
}

//Function Number: 17
func_61AF()
{
	self endon("death");
	level waittill("player_spawned",var_00);
	if(level.teambased)
	{
		if(var_00 scripts\mp\killstreaks\_emp_common::func_FFC5() && var_00 != self.var_222 && var_00.team != self.var_222.team)
		{
			var_00 scripts\mp\killstreaks\_emp_common::func_20C3();
			var_00 shellshock("flashbang_mp",0.5);
			var_00 thread func_DF77(self);
			return;
		}

		return;
	}

	if(var_00 scripts\mp\killstreaks\_emp_common::func_FFC5() && var_00 != self.var_222)
	{
		var_00 scripts\mp\killstreaks\_emp_common::func_20C3();
		var_00 shellshock("flashbang_mp",0.5);
		var_00 thread func_DF77(self);
	}
}

//Function Number: 18
func_6165(param_00,param_01)
{
	level endon("game_ended");
	wait(0.5);
	level notify("EMP_JamTeam" + param_00);
	level endon("EMP_JamTeam" + param_00);
	foreach(var_03 in level.players)
	{
		if(var_03 scripts\mp\killstreaks\_emp_common::func_FFC5() && var_03 != param_01 && var_03.team != param_01.team)
		{
			var_03 scripts\mp\killstreaks\_emp_common::func_20C3();
			var_03 shellshock("flashbang_mp",0.5);
			var_03 thread func_DF77(self);
		}
	}

	level thread scripts\mp\killstreaks\_emp_common::func_20CD();
	level notify("emp_update");
	level func_52C5(param_01,param_00);
	level.var_115C9[param_00] = 1;
	scripts\mp\_hostmigration::func_13708(60);
	level.var_115C9[param_00] = 0;
	if(isdefined(self))
	{
		self.var_A435 = 0;
	}

	level notify("emp_update");
}

//Function Number: 19
func_6164(param_00)
{
	level notify("EMP_JamPlayers");
	level endon("EMP_JamPlayers");
	wait(0.5);
	if(!isdefined(param_00))
	{
		return;
	}

	level.var_61AD = param_00;
	foreach(var_02 in level.players)
	{
		if(var_02 scripts\mp\killstreaks\_emp_common::func_FFC5() && var_02 != param_00)
		{
			var_02 scripts\mp\killstreaks\_emp_common::func_20C3();
			var_02 shellshock("flashbang_mp",0.5);
			var_02 thread func_DF77(self);
		}
	}

	level thread scripts\mp\killstreaks\_emp_common::func_20CD();
	level notify("emp_update");
	level.var_61AD thread func_61AE();
	level func_52C5(param_00);
	scripts\mp\_hostmigration::func_13708(60);
	if(isdefined(self))
	{
		self.var_A435 = 0;
	}

	level notify("emp_update");
	level notify("emp_ended");
}

//Function Number: 20
func_A577()
{
	level notify("keepEMPTimeRemaining");
	level endon("keepEMPTimeRemaining");
	level endon("emp_ended");
	level.var_61B6 = int(level.var_61B5);
	while(level.var_61B6)
	{
		wait(1);
		level.var_61B6--;
	}
}

//Function Number: 21
func_61AE()
{
	level endon("EMP_JamPlayers");
	level endon("emp_ended");
	self waittill("disconnect");
	level notify("emp_update");
}

//Function Number: 22
func_531D(param_00,param_01,param_02)
{
	var_03 = "killstreak_jammer_mp";
	if(isdefined(param_02))
	{
		var_03 = param_02;
	}

	scripts\mp\killstreaks\_killstreaks::func_532A(param_00,param_01,var_03,level.var_12A83);
	scripts\mp\killstreaks\_killstreaks::func_532A(param_00,param_01,var_03,level.var_CC11);
	scripts\mp\killstreaks\_killstreaks::func_532A(param_00,param_01,var_03,level.var_27EF);
	scripts\mp\killstreaks\_killstreaks::func_532A(param_00,param_01,var_03,level.var_B779);
}

//Function Number: 23
func_52CA(param_00,param_01,param_02)
{
	var_03 = "aamissile_projectile_mp";
	if(isdefined(param_02))
	{
		var_03 = param_02;
	}

	scripts\mp\killstreaks\_killstreaks::func_532A(param_00,param_01,var_03,level.var_8DD3);
	scripts\mp\killstreaks\_killstreaks::func_532A(param_00,param_01,var_03,level.var_AD8B);
	scripts\mp\killstreaks\_killstreaks::func_532A(param_00,param_01,var_03,level.var_DF74);
	scripts\mp\killstreaks\_killstreaks::func_532A(param_00,param_01,var_03,level.var_CC46);
	scripts\mp\killstreaks\_killstreaks::func_532A(param_00,param_01,var_03,level.var_105EA);
	if(isdefined(param_01))
	{
		scripts\mp\killstreaks\_killstreaks::func_532A(param_00,param_01,var_03,level.var_12AF3[param_01]);
	}
	else
	{
		var_04 = [];
		foreach(var_07, var_06 in level.var_12AF3)
		{
			if(issubstr(var_07,param_00.var_86BD))
			{
				continue;
			}

			var_04[var_04.size] = var_06;
		}

		scripts\mp\killstreaks\_killstreaks::func_532A(param_00,param_01,var_03,var_04);
	}

	var_08 = [];
	if(isdefined(param_01))
	{
		foreach(var_0A in level.players)
		{
			if(var_0A.team == param_00.team)
			{
				continue;
			}

			if(scripts\mp\_utility::func_9EF0(var_0A))
			{
				var_08[var_08.size] = var_0A;
			}
		}

		scripts\mp\killstreaks\_killstreaks::func_532A(param_00,param_01,var_03,var_08);
	}
}

//Function Number: 24
func_52C5(param_00,param_01,param_02)
{
	level func_531D(param_00,param_01,param_02);
	level func_52CA(param_00,param_01,param_02);
}

//Function Number: 25
func_7E37(param_00)
{
	var_01 = undefined;
	var_02 = 999999;
	foreach(var_04 in level.var_A433)
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

//Function Number: 26
func_DF77(param_00)
{
	self endon("death");
	self endon("disconnect");
	param_00 waittill("death");
	scripts\mp\killstreaks\_emp_common::func_E0F3();
}