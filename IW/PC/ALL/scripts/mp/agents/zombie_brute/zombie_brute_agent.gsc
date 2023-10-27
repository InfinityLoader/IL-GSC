/*******************************************************************
 * Decompiled By: Bog
 * Decompiled File: scripts\mp\agents\zombie_brute\zombie_brute_agent.gsc
 * Game: Call of Duty: Infinite Warfare
 * Platform: PC
 * Function Count: 34
 * Decompile Time: 1247 ms
 * Timestamp: 10/27/2023 12:31:49 AM
*******************************************************************/

//Function Number: 1
registerscriptedagent()
{
	lib_0A02::init();
	lib_03B3::func_DEE8();
	lib_0F45::func_2371();
	func_AEB0();
	thread func_FAB0();
}

//Function Number: 2
func_FAB0()
{
	level endon("game_ended");
	if(!isdefined(level.agent_definition))
	{
		level waittill("scripted_agents_initialized");
	}

	level.agent_definition["zombie_brute"]["setup_func"] = ::setupagent;
	level.agent_definition["zombie_brute"]["setup_model_func"] = ::func_FACE;
	level.agent_funcs["zombie_brute"]["on_killed"] = ::func_C4D1;
	level.agent_funcs["zombie_brute"]["on_damaged_finished"] = ::func_C4D0;
	level.var_3111 = ::func_3110;
	level.brute_loot_check = [];
}

//Function Number: 3
setupagent()
{
	self.var_4004 = undefined;
	self.var_BCF6 = undefined;
	self.var_26B9 = undefined;
	self.var_86BD = undefined;
	self.name = undefined;
	self.var_EB6A = undefined;
	self.var_CA5B = undefined;
	self.var_13CA0 = undefined;
	self.var_C2AD = undefined;
	self.sessionteam = undefined;
	self.sessionstate = undefined;
	self.var_55E6 = undefined;
	self.disabledweaponswitch = undefined;
	self.var_55D9 = undefined;
	self.var_55E4 = 1;
	self.nocorpse = undefined;
	self.ignoreme = 0;
	self.var_180 = 0;
	self.var_116D4 = undefined;
	self.var_441A = undefined;
	self.var_4B82 = undefined;
	self.do_immediate_ragdoll = undefined;
	self.var_37FD = 0;
	self.var_24CA = undefined;
	self.entered_playspace = 0;
	self.var_B36E = undefined;
	self.var_126A3 = undefined;
	self.var_8C35 = 0;
	self.var_9342 = 1;
	self.var_9341 = 1;
	self.var_1B03 = "idle";
	self.var_1F5 = "run";
	self.sharpturnnotifydist = 150;
	self.var_257 = 20;
	self.height = 53;
	self.var_252B = 26 + self.var_257;
	self.var_B640 = "normal";
	self.var_B641 = 50;
	self.var_2539 = 54;
	self.var_253A = -64;
	self.var_4D45 = 2250000;
	self.var_181 = 1;
	self.var_86BD = self getentitynumber();
	self.var_BCE4 = 1;
	self.var_C081 = 1;
	self.var_126E8 = 1;
	self.var_772A = 1;
	self.var_2AB2 = 0;
	self.var_2AB8 = 1;
	self.var_118FC = 0;
	self.var_2F = 1;
	self.var_B5F9 = 40;
	self.var_B62E = 100;
	self.var_B62F = squared(self.var_B62E);
	self.var_503C = self.var_257 + 1;
	self.var_B607 = 0.5;
	self.var_565C = 0;
	self.var_54CB = 0;
	self.var_9E0C = undefined;
	self.flung = undefined;
	self.var_565C = 0;
	self.var_B0FC = 1;
	self.full_gib = 0;
	lib_0F74::func_F794(self.var_B62E);
	self.var_B631 = 100;
	self.croc_chomp = 0;
	self.spawn_round_num = level.wave_num;
	self.footstepdetectdist = 600;
	self.footstepdetectdistwalk = 600;
	self.footstepdetectdistsprint = 600;
	self.allowpain = 1;
	if(getdvarint("scr_zombie_left_foot_sharp_turn_only",0) == 1)
	{
		self.var_AB3F = 1;
	}

	self.var_1009D = ::func_3121;
	thread func_B9B9();
	thread func_BA27();
	thread func_899C();
	var_00 = getdvarint("scr_zombie_traversal_push",1);
	if(var_00 == 1)
	{
		thread func_311D();
	}

	thread func_89C9();
	func_108D6();
	thread func_3112();
	thread func_88F5();
	thread func_88BA();
}

//Function Number: 4
func_89C9()
{
	scripts\common\utility::func_136F7();
	lib_0A1B::func_2968("run");
	level thread lib_0D62::func_CE9C(self,"run_grunt",1);
}

//Function Number: 5
func_899C()
{
	self endon("death");
	level waittill("game_ended");
	self method_841F();
	foreach(var_04, var_01 in self.var_164D)
	{
		var_02 = var_01.var_4BC0;
		var_03 = level.var_2303[var_04].var_10E2F[var_02];
		lib_0A1A::func_2388(var_04,var_02,var_03,var_03.var_116FB);
		lib_0A1A::func_238A(var_04,"idle",0.2,undefined,undefined,undefined);
	}
}

//Function Number: 6
func_FACE(param_00)
{
	self setmodel(func_7D86());
	thread func_50EF();
}

//Function Number: 7
func_7D86()
{
	var_00 = ["zmb_brute_mascot_body"];
	return scripts\common\utility::random(var_00);
}

//Function Number: 8
func_50EF()
{
	self endon("death");
	wait(0.5);
	if(isdefined(level.var_C01F))
	{
		return;
	}

	self method_80BB(1,0.1);
}

//Function Number: 9
func_AEB0()
{
	level._effect["laser_muzzle_flash"] = loadfx("vfx/iw7/core/zombie/vfx_zmb_brute_lensf.vfx");
}

//Function Number: 10
func_3110(param_00,param_01,param_02,param_03,param_04,param_05,param_06,param_07,param_08,param_09,param_0A,param_0B)
{
	var_0C = 25;
	var_0D = var_0C * var_0C;
	var_0E = self gettagorigin("tag_eye");
	var_0F = (param_08 == "head" || param_08 == "helmet" || param_08 == "neck") && param_04 != "MOD_MELEE" && param_04 != "MOD_IMPACT" && param_04 != "MOD_CRUSH";
	if(!var_0F && param_08 == "torso_upper" && self.var_8E14 == "hand" && distancesquared(param_06,var_0E) < var_0D)
	{
		var_0F = 1;
	}

	if(var_0F)
	{
		param_02 = func_EBAC(param_02,param_05);
		var_10 = param_02 / 3;
		if(isdefined(param_05) && param_05 == "zmb_imsprojectile_mp" || param_05 == "zmb_fireworksprojectile_mp")
		{
			param_02 = 0;
		}
		else
		{
			param_02 = max(10,var_10);
		}

		if(self.var_8E14 == "head")
		{
			if(!isdefined(self.var_8DDE))
			{
				self.var_8DDE = 0;
			}

			self.var_8DDE = self.var_8DDE + param_02;
			param_02 = 1;
		}
	}
	else
	{
		param_02 = 1;
	}

	return param_02;
}

//Function Number: 11
func_EBAC(param_00,param_01)
{
	var_02 = getweaponbasename(param_01);
	if(!isdefined(var_02))
	{
		return;
	}

	var_03 = 2000;
	switch(var_02)
	{
		case "iw7_headcutter_zm_pap1":
		case "iw7_headcutter_zm":
		case "iw7_facemelter_zm_pap1":
		case "iw7_facemelter_zm":
		case "iw7_dischord_zm_pap1":
		case "iw7_dischord_zm":
		case "iw7_shredder_zm_pap1":
		case "iw7_shredder_zm":
			param_00 = var_03;
			break;
	}

	return param_00;
}

//Function Number: 12
func_108D6()
{
	self.var_527A = "head";
	self.var_8E14 = "head";
}

//Function Number: 13
func_BCBC()
{
	self.var_8E14 = "hand";
	self setscriptablepartstate("eyes","yellow_eyes");
	self.var_BCE4 = 1;
	lib_0A1B::func_2968("sprint");
}

//Function Number: 14
func_BCBD()
{
	self setscriptablepartstate("eyes","eye_glow_off");
	self.var_8E14 = "head";
	self.var_BCE4 = 1;
	lib_0A1B::func_2968("run");
}

//Function Number: 15
func_DB25(param_00)
{
	self endon("death");
	self notify("reset_helmet_timer");
	self endon("reset_helmet_timer");
	wait(param_00);
	if(self.var_8E14 == "hand")
	{
		self.var_527A = "head";
	}
}

//Function Number: 16
func_3112()
{
	self endon("death");
	if(!isdefined(self.var_8DDE))
	{
		self.var_8DDE = 0;
	}

	while(!isdefined(self.maxhealth))
	{
		wait(0.1);
	}

	self.var_8E09 = 0;
	for(;;)
	{
		var_00 = self.health / self.maxhealth;
		var_01 = max(self.var_8DF0 * var_00,1000);
		if(self.var_8E09 == 1)
		{
			var_01 = var_01 * 0.5;
		}

		self waittill("helmet_damage");
		if(self.var_8DDE > var_01)
		{
			self.var_8E09++;
			self.var_527A = "hand";
			self.var_8DDE = 0;
			if(self.var_8E09 < 2)
			{
				thread func_DB25(20);
			}
		}
	}
}

//Function Number: 17
func_C4D0(param_00,param_01,param_02,param_03,param_04,param_05,param_06,param_07,param_08,param_09,param_0A,param_0B,param_0C)
{
	if(!isdefined(self.var_8E09))
	{
		self.var_8E09 = 0;
	}

	if(self.croc_chomp)
	{
		param_02 = 1;
	}
	else if(param_08 == "head" || param_02 > 1)
	{
		var_0D = "standard";
		if(self.var_8E14 == "head")
		{
			if(!isdefined(self.var_8DDE))
			{
				self.var_8DDE = 0;
			}

			self notify("helmet_damage");
			param_02 = 0;
		}
		else
		{
			var_0D = "hitcritical";
			if(self.var_8E09 < 2)
			{
				thread func_DB25(5);
			}
		}

		if(isplayer(param_01))
		{
			param_01 thread scripts\cp\_damage::func_12E84(var_0D,undefined,param_02);
		}
	}
	else if(param_08 == "helmet")
	{
		var_0D = "standard";
		if(self.var_8E14 == "head")
		{
			if(!isdefined(self.var_8DDE))
			{
				self.var_8DDE = 0;
			}

			self notify("helmet_damage");
			if(isplayer(param_01))
			{
				param_01 thread scripts\cp\_damage::func_12E84(var_0D,undefined,param_02);
			}

			param_02 = 0;
		}
		else
		{
			param_02 = 0;
		}
	}
	else
	{
		param_02 = 0;
	}

	scripts\mp\_mp_agent::func_5004(param_00,param_01,param_02,param_03,param_04,param_05,param_06,param_07,param_08,param_09,param_0A,param_0B,param_0C);
}

//Function Number: 18
brute_killed_vo(param_00)
{
	if(isplayer(param_00))
	{
		param_00 thread scripts\cp\_vo::try_to_play_vo("killfirm_brute","zmb_comment_vo","medium",10,0,0,0,20);
	}

	wait(4);
	level thread scripts\cp\_vo::try_to_play_vo("ww_brute_death","zmb_ww_vo","highest",60,0,0,1);
}

//Function Number: 19
func_C4D1(param_00,param_01,param_02,param_03,param_04,param_05,param_06,param_07,param_08)
{
	level thread brute_killed_vo(param_01);
	func_10838(self.var_1657,param_03,param_04);
	self.death_anim_no_ragdoll = 1;
	scripts\mp\_mp_agent::func_5006(param_00,param_01,param_02,param_03,param_04,param_05,param_06,param_07,param_08);
	var_09 = scripts\common\utility::random(["ammo_max","instakill_30","cash_2","instakill_30","cash_2","instakill_30","cash_2"]);
	if(isdefined(var_09) && !isdefined(self.var_72AC))
	{
		if(!isdefined(level.brute_loot_check[self.spawn_round_num]))
		{
			level.brute_loot_check[self.spawn_round_num] = 1;
			level thread scripts\cp\zombies\_powerups::drop_loot(self.origin,param_01,var_09);
		}
	}

	var_0A = 400;
	foreach(var_0C in level.players)
	{
		var_0C scripts\cp\_persistence::func_82F9(var_0A);
		var_0C lib_0D2A::func_12D7C("THE_BIGGER_THEY_ARE",1);
	}
}

//Function Number: 20
func_10838(param_00,param_01,param_02)
{
	self.var_CE65 = 1;
}

//Function Number: 21
func_10840(param_00)
{
}

//Function Number: 22
func_B9B9()
{
	self endon("death");
	level endon("game_ended");
}

//Function Number: 23
func_BA27()
{
	self endon("death");
	level endon("game_ended");
}

//Function Number: 24
func_A012()
{
	if(!isdefined(level.var_13F60))
	{
		return 0;
	}

	return level.var_13F60;
}

//Function Number: 25
func_A632(param_00)
{
	param_00 dodamage(param_00.health + 500000,param_00.origin);
}

//Function Number: 26
func_311E(param_00,param_01)
{
	foreach(var_03 in level.players)
	{
		var_04 = self.origin[2] - var_03.origin[2];
		if(abs(var_04) < param_01)
		{
			var_05 = distance2dsquared(self.origin,var_03.origin);
			if(var_05 < param_00)
			{
				var_06 = self.var_381;
				var_07 = length2d(var_06);
				if(var_07 == 0)
				{
					break;
				}

				var_08 = var_03.origin - self.origin;
				var_08 = (var_08[0],var_08[1],0);
				var_09 = vectornormalize(var_08);
				if(var_07 < 60)
				{
					var_07 = 60;
				}

				var_0A = var_03 getvelocity();
				var_0A = (var_0A[0],var_0A[1],0);
				var_0B = length2d(var_0A);
				if(var_0B > 0)
				{
					var_0C = var_09 * var_07;
					var_0D = var_0A + var_0C;
					var_0E = length2d(var_0D);
					if(vectordot(var_0D,var_0C) < 0)
					{
						var_0F = vectorcross((0,0,1),var_09);
						if(vectordot(var_0F,var_0A) > 0)
						{
							var_0B = length2d(var_0A);
							var_0A = var_0F * var_0B;
						}
						else
						{
							var_10 = var_0F * -1;
							var_0B = length2d(var_0A);
							var_0A = var_10 * var_0B;
						}

						var_0D = var_0A + var_0C;
						var_07 = length2d(var_0D);
					}
					else
					{
						if(var_0B > var_07)
						{
							var_07 = var_0B;
						}

						var_09 = vectornormalize(var_0D);
					}
				}

				var_03 method_84DC(var_09,var_07);
			}
		}
	}
}

//Function Number: 27
func_311F()
{
	self endon("death");
	level endon("game_ended");
	self endon("traverse_end");
	for(;;)
	{
		func_311E(3600,100);
		scripts\common\utility::func_136F7();
	}
}

//Function Number: 28
func_311D()
{
	self endon("death");
	self endon("game_ended");
	for(;;)
	{
		self waittill("traverse_begin");
		func_311F();
	}
}

//Function Number: 29
func_3121()
{
	if(!isdefined(self.var_527A) || !isdefined(self.var_8E14))
	{
		return 0;
	}

	if(self.var_8E14 != self.var_527A)
	{
		return 1;
	}

	return 0;
}

//Function Number: 30
func_88F5()
{
	self endon("death");
	level endon("game_ended");
	for(;;)
	{
		self waittill("large_footstep");
		var_00 = scripts\common\utility::func_782F(self.origin,level.players,undefined,undefined,500);
		foreach(var_02 in var_00)
		{
			var_02 earthquakeforplayer(0.2,0.25,self.origin,500);
			var_02 method_8246("artillery_rumble",self.origin);
		}
	}
}

//Function Number: 31
func_3116()
{
	self endon("death");
	var_00 = 0;
	for(;;)
	{
		if(scripts\common\utility::istrue(self.var_3117))
		{
			var_00 = 0;
			wait(1);
			continue;
		}

		if(scripts\common\utility::istrue(self.var_9CEC))
		{
			var_00 = 0;
			wait(1);
			continue;
		}

		var_01 = undefined;
		var_02 = level.var_10816;
		foreach(var_04 in var_02)
		{
			if(!var_04.var_19)
			{
				continue;
			}

			if(self istouching(var_04))
			{
				var_01 = var_04;
				break;
			}
		}

		if(!isdefined(var_01))
		{
			var_00 = 0;
			self notify("no_path_to_targets");
		}
		else
		{
			var_06 = lib_0D60::func_800B(var_01);
			if(var_06 == 0)
			{
				var_07 = 0;
				var_02 = var_01.var_186E;
				if(isdefined(var_02))
				{
					foreach(var_04 in var_02)
					{
						var_06 = lib_0D60::func_800B(var_04);
						if(var_06 > 0)
						{
							var_07 = 1;
							break;
						}
					}
				}

				if(!var_07)
				{
					var_00++;
				}
				else
				{
					var_00 = 0;
				}
			}
			else
			{
				var_00 = 0;
			}

			if(var_00 > 5)
			{
				self notify("no_path_to_targets");
				var_00 = 0;
			}
		}

		wait(1);
	}
}

//Function Number: 32
func_88BA()
{
	self endon("death");
	level endon("game_ended");
	thread func_3116();
	for(;;)
	{
		self waittill("no_path_to_targets");
		self.var_3117 = 1;
		func_1164D();
		self.var_3117 = 0;
	}
}

//Function Number: 33
func_6CA4()
{
	var_00 = scripts\cp\zombies\zombies_spawning::func_7C2E();
	return var_00;
}

//Function Number: 34
func_1164D()
{
	var_00 = spawnstruct();
	var_00.origin = self.origin;
	scripts\cp\zombies\zombies_spawning::func_3115(var_00);
	self.var_180 = 1;
	var_01 = scripts\common\utility::getstruct("brute_hide_org","targetname");
	self setorigin(var_01.origin,1);
	self method_82EF(self.origin);
	wait(3);
	var_02 = func_6CA4();
	scripts\cp\zombies\zombies_spawning::func_3115(var_02);
	self setorigin(var_02.origin + (0,0,3),1);
	self.var_180 = 0;
	wait(3);
}