/*******************************************************************
 * Decompiled By: Bog
 * Decompiled File: scripts\asm\slasher\slasher_asm.gsc
 * Game: Call of Duty: Infinite Warfare
 * Platform: PC
 * Function Count: 58
 * Decompile Time: 3073 ms
 * Timestamp: 10/27/2023 12:02:12 AM
*******************************************************************/

//Function Number: 1
slasherinit(param_00,param_01,param_02,param_03)
{
	lib_0C75::func_13F9A(param_00,param_01,param_02,param_03);
	self.var_71D0 = ::scripts\mp\agents\slasher\slasher_agent::shouldslasherplaypainanim;
	self setscriptablepartstate("slasher_audio","normal");
}

//Function Number: 2
isvalidslasheraction(param_00)
{
	switch(param_00)
	{
		case "grenade_throw":
		case "melee_spin":
		case "swipe_attack":
		case "block":
		case "ram_attack":
		case "sawblade_attack":
		case "summon":
		case "teleport":
		case "ground_pound":
		case "taunt":
			return 1;
	}

	return 0;
}

//Function Number: 3
setslasheraction(param_00)
{
	self.requested_action = param_00;
}

//Function Number: 4
clearslasheraction()
{
	self.requested_action = undefined;
}

//Function Number: 5
issawbladeattackdone(param_00,param_01,param_02,param_03)
{
	if(!isdefined(self.requested_action))
	{
		return 1;
	}

	if(self.requested_action != "sawblade_attack")
	{
		return 1;
	}

	return 0;
}

//Function Number: 6
shouldendblock(param_00,param_01,param_02,param_03)
{
	if(!isdefined(self.requested_action) || self.requested_action != "block")
	{
		return 1;
	}

	return 0;
}

//Function Number: 7
shouldshootsawblade(param_00,param_01,param_02,param_03)
{
	if(!isdefined(self.requested_action))
	{
		return 0;
	}

	if(!lib_0A1B::func_291C())
	{
		return 0;
	}

	return 1;
}

//Function Number: 8
shouldstopshootingsawblade(param_00,param_01,param_02,param_03)
{
	return !shouldshootsawblade(param_00,param_01,param_02,param_03);
}

//Function Number: 9
shouldplayentranceanim(param_00,param_01,param_02,param_03)
{
	return 0;
}

//Function Number: 10
playanimandlookatenemy(param_00,param_01,param_02,param_03)
{
	thread lib_0C73::func_6A6A(param_01,scripts\mp\agents\slasher\slasher_agent::getenemy());
	var_04 = lib_0A1D::func_2337(param_00,param_01);
	lib_0A1D::func_2365(param_00,param_01,param_02,var_04,1);
}

//Function Number: 11
isanimdone(param_00,param_01,param_02,param_03)
{
	if(lib_0A1A::func_232B(param_01,"end"))
	{
		return 1;
	}

	if(lib_0A1A::func_232B(param_01,"early_end"))
	{
		return 1;
	}

	if(lib_0A1A::func_232B(param_01,"finish_early"))
	{
		return 1;
	}

	if(lib_0A1A::func_232B(param_01,"code_move"))
	{
		return 1;
	}

	return 0;
}

//Function Number: 12
playtauntanim(param_00,param_01,param_02,param_03)
{
	self notify("taunt");
	thread lib_0C73::func_6A6A(param_01,scripts\mp\agents\slasher\slasher_agent::getenemy());
	lib_0A1D::func_2364(param_00,param_01,param_02,param_03);
}

//Function Number: 13
dosummonspawn()
{
}

//Function Number: 14
dogroundpounddamage(param_00,param_01)
{
	if(isdefined(param_00))
	{
		self endon(param_00 + "_finished");
	}

	if(isdefined(param_01))
	{
		wait(param_01);
	}

	var_02 = scripts\mp\agents\slasher\slasher_tunedata::gettunedata();
	foreach(var_04 in level.players)
	{
		if(isalive(var_04))
		{
			if(distancesquared(self.origin,var_04.origin) < var_02.ground_pound_damage_radius_sq)
			{
				lib_0C73::func_5904(var_04,self.ground_pound_damage,"MOD_IMPACT");
			}
		}
	}
}

//Function Number: 15
groundpoundnotehandler(param_00,param_01,param_02,param_03)
{
	if(param_00 == "groundpound")
	{
		dogroundpounddamage();
	}
}

//Function Number: 16
playgroundpound(param_00,param_01,param_02,param_03)
{
	self endon(param_01 + "_finished");
	thread dogroundpounddamage(param_01,0.75);
	lib_0A1D::func_2364(param_00,param_01,param_02,param_03);
}

//Function Number: 17
summonnotehandler(param_00,param_01,param_02,param_03)
{
	if(param_00 == "start_summon_zombies")
	{
		dosummonspawn();
	}
}

//Function Number: 18
meleenotehandler(param_00,param_01,param_02,param_03)
{
	if(param_00 == "hit")
	{
		var_04 = scripts\mp\agents\slasher\slasher_agent::getenemy();
		if(isdefined(var_04))
		{
			if(distancesquared(var_04.origin,self.origin) < -25536)
			{
				self notify("attack_hit",var_04);
				lib_0C73::func_5904(var_04,self.var_B601,"MOD_IMPACT");
			}
			else
			{
				self notify("attack_miss",var_04);
			}
		}

		if(!scripts\common\utility::istrue(self.bmovingmelee))
		{
			self notify("stop_melee_face_enemy");
			return;
		}

		return;
	}

	if(param_00 == "spin_attack_damage_begin")
	{
		thread startspinattackdamage(param_01);
		return;
	}

	if(param_00 == "spin_attack_damage_end")
	{
		stopspinattackdamage();
		return;
	}
}

//Function Number: 19
shouldstartramanim(param_00,param_01,param_02,param_03)
{
	if(lib_0A1B::func_2953(param_00,param_01,param_02,param_03))
	{
		return 1;
	}

	return 0;
}

//Function Number: 20
func_100AD(param_00,param_01,param_02,param_03)
{
	if(!lib_0A1B::func_298A())
	{
		return 0;
	}

	return 1;
}

//Function Number: 21
func_2481(param_00,param_01,param_02)
{
	self attach(param_01,param_02);
	thread func_5392(param_00,param_01,param_02);
	return param_02;
}

//Function Number: 22
func_5392(param_00,param_01,param_02)
{
	self endon("stop grenade check");
	self waittill(param_00 + "_finished");
	if(!isdefined(self))
	{
		return;
	}

	self detach(param_01,param_02);
}

//Function Number: 23
grenadethrownotehandler(param_00,param_01,param_02,param_03)
{
	switch(param_00)
	{
		case "grenade_right":
		case "grenade_left":
			break;

		case "grenade_throw":
			if(scripts\common\utility::istrue(self.grenade_thrown))
			{
				return;
			}
	
			self.grenade_thrown = 1;
			self notify("stop grenade check");
			var_04 = lib_0A1B::func_2930();
			if(isdefined(var_04))
			{
				var_05 = self.var_1B2;
				var_06 = self method_806C(scripts\mp\agents\slasher\slasher_agent::getslashergrenadehandoffset(),var_05,0,"min time","min energy");
				if(isdefined(var_06))
				{
					self method_83C2();
					lib_0A1A::func_232F("grenade_throw","thrown");
				}
				else if(isdefined(self.enemygrenadepos))
				{
					var_06 = self method_806C(scripts\mp\agents\slasher\slasher_agent::getslashergrenadehandoffset(),self.enemygrenadepos,0,"min time","min energy");
					if(isdefined(var_06))
					{
						self method_83C2();
						lib_0A1A::func_232F("grenade_throw","thrown");
					}
				}
			}
			break;
	}
}

//Function Number: 24
playgrenadethrowanim(param_00,param_01,param_02,param_03)
{
	self endon(param_01 + "_finished");
	scripts\mp\agents\slasher\slasher_agent::lookatslasherenemy();
	lib_0A1D::func_2364(param_00,param_01,param_02,param_03);
}

//Function Number: 25
grenadethrowterminate(param_00,param_01,param_02)
{
	self.grenade_thrown = undefined;
}

//Function Number: 26
shouldabortaction(param_00,param_01,param_02,param_03)
{
	if(scripts\common\utility::istrue(self.btraversalteleport))
	{
		return 0;
	}

	if(!isdefined(self.requested_action))
	{
		return 1;
	}

	if(isdefined(param_03))
	{
		if(self.requested_action != param_03)
		{
			return 1;
		}
	}

	return 0;
}

//Function Number: 27
shoulddoaction(param_00,param_01,param_02,param_03)
{
	if(!isdefined(self.requested_action))
	{
		return 0;
	}

	if(self.requested_action == param_02)
	{
		return 1;
	}

	return 0;
}

//Function Number: 28
firebladeburst(param_00,param_01,param_02)
{
	self endon(param_00 + "_finished");
	var_03 = scripts\mp\agents\slasher\slasher_tunedata::gettunedata();
	var_04 = randomintrange(var_03.min_burst_count,var_03.max_burst_count);
	for(var_05 = 0;var_05 < var_04;var_05++)
	{
		var_06 = (randomfloatrange(var_03.sawblade_min_offset,var_03.sawblade_max_offset),randomfloatrange(var_03.sawblade_min_offset,var_03.sawblade_max_offset),randomfloatrange(var_03.sawblade_min_offset,var_03.sawblade_max_offset));
		var_07 = magicbullet("iw7_slasher_sawblade_mp",param_01,param_02 + var_06,self);
		var_08 = getdvar("ui_mapname");
		if(var_08 != "cp_final")
		{
			var_07 thread hide_and_show_blade();
		}

		wait(var_03.sawblade_burst_interval);
	}
}

//Function Number: 29
fireblades(param_00)
{
	self endon(param_00 + "_finished");
	wait(0.2);
	var_01 = scripts\mp\agents\slasher\slasher_tunedata::gettunedata();
	for(;;)
	{
		var_02 = scripts\mp\agents\slasher\slasher_agent::getenemy();
		if(isdefined(var_02) && isdefined(self.var_1C2))
		{
			var_03 = self gettagorigin("j_wrist_ri");
			var_04 = self.var_1C2;
			if(randomint(100) < var_01.sawblade_burst_chance)
			{
				self notify("attack_shoot",var_02);
				firebladeburst(param_00,var_03,var_04);
			}
			else
			{
				var_05 = (randomfloatrange(var_01.sawblade_min_offset,var_01.sawblade_max_offset),randomfloatrange(var_01.sawblade_min_offset,var_01.sawblade_max_offset),randomfloatrange(var_01.sawblade_min_offset,var_01.sawblade_max_offset));
				var_06 = magicbullet("iw7_slasher_sawblade_mp",var_03,var_04 + var_05,self);
				var_07 = getdvar("ui_mapname");
				if(var_07 != "cp_final")
				{
					var_06 thread hide_and_show_blade();
				}
			}

			var_08 = randomfloatrange(var_01.min_sawblade_fire_interval,var_01.max_sawblade_fire_interval);
			wait(var_08);
			continue;
		}

		wait(0.1);
	}
}

//Function Number: 30
hide_and_show_blade()
{
	level endon("game_ended");
	self endon("death");
	foreach(var_01 in level.players)
	{
		if(!scripts\common\utility::istrue(var_01.var_DCEB))
		{
			self method_8429(var_01);
		}
	}
}

//Function Number: 31
shootsawblades(param_00,param_01,param_02,param_03)
{
	self endon(param_01 + "_finished");
	thread fireblades(param_01);
	lib_0A1D::func_2364(param_00,param_01,param_02,param_03);
}

//Function Number: 32
playanimwithplaybackrate(param_00,param_01,param_02,param_03)
{
	self endon(param_01 + "_finished");
	var_04 = param_03;
	var_05 = lib_0A1D::func_2337(param_00,param_01);
	lib_0A1D::func_2365(param_00,param_01,param_02,var_05,var_04);
}

//Function Number: 33
playblockanim(param_00,param_01,param_02,param_03)
{
	self endon(param_01 + "_finished");
	var_04 = vectortoangles(self.damageaccumulator.lastdir * -1);
	var_04 = (0,var_04[1],0);
	self method_8289("face angle abs",var_04);
	self method_8281("anim deltas");
	lib_0A1D::func_2364(param_00,param_01,param_02,param_03);
}

//Function Number: 34
func_BEA0(param_00,param_01,param_02,param_03)
{
	var_04 = undefined;
	var_05 = scripts\mp\agents\slasher\slasher_agent::getenemy();
	if(isdefined(self.var_1198.var_FECD) && isdefined(self.var_1198.var_FECD.var_65D3))
	{
		var_04 = self.var_1198.var_FECD.var_65D3.origin;
	}
	else if(isdefined(self.var_1198.var_FECD) && isdefined(self.var_1198.var_FECD.var_D699))
	{
		var_04 = self.var_1198.var_FECD.var_D699;
	}
	else if(isdefined(var_05))
	{
		var_04 = var_05.origin;
	}

	if(!isdefined(var_04))
	{
		return 0;
	}

	var_06 = self.angles[1] - vectortoyaw(var_04 - self.origin);
	var_07 = distancesquared(self.origin,var_04);
	if(var_07 < 65536)
	{
		var_08 = sqrt(var_07);
		if(var_08 > 3)
		{
			var_06 = var_06 + asin(-3 / var_08);
		}
	}

	if(abs(angleclamp180(var_06)) > self.var_129AF)
	{
		return 1;
	}

	return 0;
}

//Function Number: 35
func_81DE()
{
	var_00 = 0.25;
	var_01 = undefined;
	var_02 = undefined;
	if(isdefined(self.var_1198.var_FECD))
	{
		if(isdefined(self.var_1198.var_FECD.var_65D3))
		{
			var_01 = self.var_1198.var_FECD.var_65D3;
		}
		else if(isdefined(self.var_1198.var_FECD.var_D699))
		{
			var_02 = self.var_1198.var_FECD.var_D699;
		}
	}

	var_03 = scripts\mp\agents\slasher\slasher_agent::getenemy();
	if(isdefined(var_03))
	{
		if(!isdefined(var_01) && !isdefined(var_02))
		{
			var_01 = var_03;
		}
	}

	if(isdefined(var_01) && !issentient(var_01))
	{
		var_00 = 1.5;
	}

	var_04 = scripts\common\utility::func_8094(var_00,var_01,var_02);
	return var_04;
}

//Function Number: 36
func_3F0A(param_00,param_01,param_02)
{
	var_03 = func_81DE();
	if(var_03 < 0)
	{
		var_04 = "right";
	}
	else
	{
		var_04 = "left";
	}

	var_03 = abs(var_03);
	var_05 = 0;
	if(var_03 > 157.5)
	{
		var_05 = 180;
	}
	else if(var_03 > 112.5)
	{
		var_05 = 135;
	}
	else if(var_03 > 67.5)
	{
		var_05 = 90;
	}
	else
	{
		var_05 = 45;
	}

	var_06 = var_04 + "_" + var_05;
	var_07 = lib_0A1A::func_2358(param_01,var_06);
	var_08 = self method_8101(param_01,var_07);
	return var_07;
}

//Function Number: 37
func_D56A(param_00,param_01,param_02,param_03)
{
	self endon(param_01 + "_finished");
	var_04 = lib_0A1D::func_2337(param_00,param_01);
	var_05 = self.var_233;
	self method_8289("face angle abs",self.angles);
	self method_8281("anim deltas");
	lib_0A1D::func_2365(param_00,param_01,param_02,var_04);
	if(!isdefined(var_05) && isdefined(self.var_233))
	{
		self method_841F();
	}

	lib_0A1D::func_237F("face current");
	lib_0A1D::func_237E("code_move");
}

//Function Number: 38
doramattackdamage(param_00)
{
	param_00 endon("death");
	if(scripts\common\utility::istrue(self.bramattackdamageoccured))
	{
		return;
	}

	var_01 = vectornormalize(self getvelocity());
	var_02 = scripts\mp\agents\slasher\slasher_tunedata::gettunedata();
	self.bramattackdamageoccured = 1;
	param_00 method_84DC(var_01,var_02.ram_attack_push);
	wait(0.2);
	var_03 = int(var_02.ram_attack_damage / 100 * param_00.maxhealth);
	lib_0C73::func_5904(param_00,var_03,"MOD_IMPACT");
}

//Function Number: 39
ramattacknotehandler(param_00,param_01,param_02,param_03)
{
	if(param_00 == "hit")
	{
		if(isdefined(self.var_4B26))
		{
			var_04 = scripts\mp\agents\slasher\slasher_tunedata::gettunedata();
			var_05 = distancesquared(self.origin,self.var_4B26.origin);
			if(var_05 < var_04.ram_attack_melee_dist_sq && lib_0C73::func_9DD7(self.var_4B26,var_04.ram_attack_dot))
			{
				thread doramattackdamage(self.var_4B26);
				return;
			}
		}
	}
}

//Function Number: 40
handleramattackprocessing(param_00,param_01,param_02)
{
	self endon(param_00 + "_finished");
	if(!isdefined(param_01))
	{
		return;
	}

	self setscriptablepartstate("slasher_audio","charge");
	var_03 = 1;
	var_04 = scripts\mp\agents\slasher\slasher_tunedata::gettunedata();
	self notify("attack_charge");
	for(;;)
	{
		var_05 = distance2dsquared(self.origin,param_01.origin);
		if(var_03 && var_05 > var_04.ram_attack_go_straight_radius_sq)
		{
			var_06 = param_01 getvelocity();
			var_07 = param_01.origin + var_06 * 0.15;
			var_08 = var_07 - self.origin;
			var_08 = (var_08[0],var_08[1],0);
			var_08 = vectornormalize(var_08);
			self method_8289("face angle abs",vectortoangles(var_08));
		}
		else if(var_03)
		{
			var_03 = 0;
		}

		if(param_02 && var_05 < var_04.ram_attack_collision_dist_sq)
		{
			if(lib_0C73::func_9DD7(param_01,var_04.ram_attack_dot))
			{
				thread doramattackdamage(param_01);
				break;
			}
		}

		scripts\common\utility::func_136F7();
		if(!isdefined(param_01) || !isalive(param_01))
		{
			break;
		}
	}

	self setscriptablepartstate("slasher_audio","normal");
}

//Function Number: 41
playramattackanim(param_00,param_01,param_02,param_03)
{
	self endon(param_01 + "_finished");
	thread handleramattackprocessing(param_01,self.var_4B26,0);
	playanimwithplaybackrate(param_00,param_01,param_02,param_03);
	self setscriptablepartstate("slasher_audio","normal");
}

//Function Number: 42
playramattackloop(param_00,param_01,param_02,param_03)
{
	self endon(param_01 + "_finished");
	thread handleramattackprocessing(param_01,self.var_4B26,1);
	playanimwithplaybackrate(param_00,param_01,param_02,param_03);
}

//Function Number: 43
playmeleeattack(param_00,param_01,param_02,param_03)
{
	self endon(param_01 + "_finished");
	thread lib_0C73::func_6A6A(param_01,self.var_4B26);
	var_04 = lib_0A1D::func_2337(param_00,param_01);
	lib_0A1D::func_2365(param_00,param_01,param_02,var_04);
}

//Function Number: 44
playmeleespinattack(param_00,param_01,param_02,param_03)
{
	self endon(param_01 + "_finished");
	thread lib_0C73::func_6A6A(param_01,self.var_4B26);
	var_04 = lib_0A1D::func_2337(param_00,param_01);
	lib_0A1D::func_2365(param_00,param_01,param_02,var_04);
}

//Function Number: 45
startspinattackdamage(param_00)
{
	self endon(param_00 + "_finished");
	self endon("StopSpinAttackDamage");
	var_01 = [];
	var_02 = scripts\mp\agents\slasher\slasher_tunedata::gettunedata();
	for(;;)
	{
		var_03 = self gettagangles("tag_eye");
		var_03 = (0,var_03[1],0);
		var_04 = anglestoforward(var_03);
		foreach(var_06 in level.players)
		{
			if(lib_0F74::func_1002C(var_06))
			{
				continue;
			}

			if(!isalive(var_06))
			{
				continue;
			}

			var_07 = distance2dsquared(var_06.origin,self.origin);
			if(var_07 > var_02.slasher_spin_damage_range_sq)
			{
				continue;
			}

			var_08 = var_01[var_06 getentitynumber()];
			if(isdefined(var_08))
			{
				if(gettime() - var_08 < 250)
				{
					continue;
				}
			}

			var_09 = abs(var_06.origin[2] - self.origin[2]);
			if(var_09 > 64)
			{
				continue;
			}

			var_0A = var_06.origin - self.origin * (1,1,0);
			var_0B = vectornormalize(var_0A);
			var_0C = vectordot(var_0B,var_04);
			if(var_0C < 0.966)
			{
				continue;
			}

			var_01[var_06 getentitynumber()] = gettime();
			lib_0C73::func_5904(var_06,var_02.slasher_spin_damage_amt,"MOD_IMPACT");
		}

		scripts\common\utility::func_136F7();
	}
}

//Function Number: 46
stopspinattackdamage()
{
	self notify("StopSpinAttackDamage");
}

//Function Number: 47
slasherplaysharpturnanim(param_00,param_01,param_02,param_03)
{
	self endon(param_01 + "_finished");
	lib_0A1A::func_237B(1.5);
	lib_0F3B::func_D514(param_00,param_01,param_02,param_03);
	lib_0A1A::func_237B(1);
}

//Function Number: 48
slashershouldstartarrival(param_00,param_01,param_02,param_03)
{
	var_04 = scripts\mp\agents\slasher\slasher_agent::getenemy();
	if(isdefined(var_04))
	{
		var_05 = distancesquared(self.origin,var_04.origin);
		if(var_05 < 65536)
		{
			return 0;
		}
	}

	return lib_0C75::func_10092(param_00,param_01,param_02,param_03);
}

//Function Number: 49
choosemeleeattack(param_00,param_01,param_02)
{
	if(lib_0A1B::func_2955())
	{
		var_03 = lib_0A1A::func_2358(param_01,"attack_moving");
	}
	else
	{
		var_03 = lib_0A1A::func_2358(param_02,"attack");
	}

	return var_03;
}

//Function Number: 50
func_3EE4(param_00,param_01,param_02)
{
	return lib_0F3C::func_3EF4(param_00,param_01,param_02);
}

//Function Number: 51
playmovingpainanim(param_00,param_01,param_02,param_03)
{
	self endon(param_01 + "_finished");
	if(!isdefined(self.var_233) || self method_841E() < scripts\mp\agents\slasher\slasher_tunedata::gettunedata().min_moving_pain_dist)
	{
		var_04 = func_3EE4(param_00,"pain_generic",param_03);
		self method_8289("face angle abs",self.angles);
		lib_0A1D::func_2365(param_00,"pain_generic",param_02,var_04,1);
		return;
	}

	lib_0A1D::func_2364(param_01,param_02,param_03,var_04);
}

//Function Number: 52
playteleportout(param_00,param_01,param_02,param_03)
{
	self endon(param_01 + "_finished");
	var_04 = lib_0A1D::func_2337(param_00,param_01);
	var_05 = scripts\mp\agents\slasher\slasher_agent::getenemy();
	self setscriptablepartstate("teleport","hide");
	if(soundexists("slasher_teleport_in"))
	{
		play_teleport_sound_to_players("slasher_teleport_in");
	}

	wait(0.1);
	self hide();
	self setorigin(self.teleportpos,0);
	if(isdefined(var_05))
	{
		self.angles = vectortoangles(var_05.origin - self.origin);
	}

	self.teleportpos = undefined;
	self method_8286(self.origin);
	self method_841F();
	thread showmelater();
	if(!scripts\common\utility::istrue(self.btraversalteleport))
	{
		scripts\mp\agents\slasher\slasher_agent::lookatslasherenemy();
	}

	lib_0A1D::func_2365(param_00,param_01,param_02,var_04,1.5);
	if(scripts\common\utility::istrue(self.btraversalteleport))
	{
		self.var_9CEC = undefined;
		self.btraversalteleport = undefined;
		self notify("traverse_end");
		lib_0A1A::func_237C("decide_idle",param_03);
	}
}

//Function Number: 53
showmelater()
{
	wait(0.1);
	if(soundexists("slasher_teleport_out"))
	{
		play_teleport_sound_to_players("slasher_teleport_out");
	}

	self setscriptablepartstate("teleport","show");
	self show();
}

//Function Number: 54
play_teleport_sound_to_players(param_00)
{
	foreach(var_02 in level.players)
	{
		if(!self method_85B8() || scripts\common\utility::istrue(var_02.var_DCEB))
		{
			self playsoundtoplayer(param_00,var_02);
		}
	}
}

//Function Number: 55
ontraversalteleport(param_00,param_01,param_02,param_03)
{
	self.teleportpos = self method_8146();
	self.btraversalteleport = 1;
	return 1;
}

//Function Number: 56
ram_attack_anim_terminate(param_00,param_01,param_02)
{
	self setscriptablepartstate("slasher_audio","normal");
}

//Function Number: 57
ram_attack_start_terminate(param_00,param_01,param_02)
{
	self setscriptablepartstate("slasher_audio","normal");
}

//Function Number: 58
ram_attack_loop_terminate(param_00,param_01,param_02)
{
	self setscriptablepartstate("slasher_audio","normal");
}