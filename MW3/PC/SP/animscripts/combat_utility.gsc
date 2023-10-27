/*******************************************************************
 * Decompiled By: Bog
 * Decompiled File: animscripts\combat_utility.gsc
 * Game: Call of Duty: Modern Warfare 3
 * Platform: PC
 * Function Count: 84
 * Decompile Time: 1377 ms
 * Timestamp: 10/27/2023 2:18:00 AM
*******************************************************************/

//Function Number: 1
func_2373(param_00)
{
	var_01 = self getshootatpos() + (0,0,-3);
	var_02 = (var_01[0] - param_00[0],var_01[1] - param_00[1],var_01[2] - param_00[2]);
	var_02 = vectornormalize(var_02);
	var_03 = var_02[2] * -1;
	return var_03;
}

//Function Number: 2
func_2374()
{
	if(isplayer(self.enemy))
	{
		return randomfloatrange(self.enemy.gs.min_sniper_burst_delay_time,self.enemy.gs.max_sniper_burst_delay_time);
	}

	return randomfloatrange(level.min_sniper_burst_delay_time,level.max_sniper_burst_delay_time);
}

//Function Number: 3
func_2375()
{
	var_00 = gettime() - self.a.lastshoottime / 1000;
	var_01 = func_2376();
	if(var_01 > var_00)
	{
		return var_01 - var_00;
	}

	return 0;
}

//Function Number: 4
func_2376()
{
	if(animscripts/utility::func_C95())
	{
		return randomfloatrange(0.15,0.55);
	}

	if(animscripts/utility::func_C97())
	{
		return randomfloatrange(1,1.7);
	}

	if(issniper())
	{
		return func_2374();
	}

	if(self.var_CDB)
	{
		return randomfloatrange(0.1,0.35);
	}

	return randomfloatrange(0.4,0.9);
}

//Function Number: 5
func_2377()
{
	if(self.bulletsinclip)
	{
		if(self.var_CDA == "full" && !self.var_CDB)
		{
			if(self.a.lastshoottime == gettime())
			{
				wait 0.05;
			}

			return;
		}

		var_00 = func_2375();
		if(var_00)
		{
			wait var_00;
		}
	}
}

//Function Number: 6
func_10BB()
{
	if(!isdefined(self.enemy))
	{
		return 0;
	}

	if(self.team != "allies")
	{
		if(!isplayer(self.enemy))
		{
			return 0;
		}

		if(self.enemy maps\_utility::ent_flag("player_is_invulnerable"))
		{
			return 0;
		}
	}

	if(animscripts/utility::func_C95() || animscripts/utility::func_BB6())
	{
		return 0;
	}

	if(gettime() - self.var_10BA < self.var_20B7)
	{
		return 0;
	}

	if(!self cansee(self.enemy) && distancesquared(self.origin,self.enemy.origin) > 65536)
	{
		return 0;
	}

	self.bulletsinclip = int(weaponclipsize(self.weapon) / 2);
	if(self.bulletsinclip > weaponclipsize(self.weapon))
	{
		self.bulletsinclip = weaponclipsize(self.weapon);
	}

	self.var_10BA = gettime();
	return 1;
}

//Function Number: 7
func_2378()
{
	for(var_00 = int(60);var_00 > 0;var_00--)
	{
		if(isdefined(self.dontevershoot) || isdefined(self.enemy) && isdefined(self.enemy.var_FA0))
		{
			wait 0.05;
			continue;
		}

		return 0;
	}

	return 1;
}

//Function Number: 8
func_0F06()
{
	self endon("shoot_behavior_change");
	self endon("stopShooting");
	if(func_23BD())
	{
		if(isdefined(self.enemy) && isai(self.enemy) && distancesquared(level.player.origin,self.enemy.origin) < 147456)
		{
			self.enemy animscripts/battlechatter_ai::func_AD5("infantry",self,1);
		}

		if(animscripts/utility::func_BB6() && issentient(self.enemy))
		{
			wait randomfloat(2);
		}
	}

	if(isdefined(self.enemy) && distancesquared(self.origin,self.enemy.origin) > squared(400))
	{
		var_00 = randomintrange(1,5);
	}
	else
	{
		var_00 = 10;
	}

	for(;;)
	{
		func_2377();
		if(func_2378())
		{
			break;
		}

		if(self.var_CDA == "full")
		{
			func_237E(animscripts/utility::func_D4D("fire"),1,animscripts/shared::func_2379());
		}
		else if(self.var_CDA == "burst" || self.var_CDA == "semi")
		{
			var_01 = animscripts/shared::func_237A();
			if(var_01 == 1)
			{
				func_237E(animscripts/utility::func_CA8("single"),1,var_01);
			}
			else
			{
				func_237E(animscripts/utility::func_D4D(self.var_CDA + var_01),1,var_01);
			}
		}
		else if(self.var_CDA == "single")
		{
			func_237E(animscripts/utility::func_CA8("single"),1,1);
		}
		else
		{
			self waittill("hell freezes over");
		}

		if(!self.bulletsinclip)
		{
			break;
		}

		var_00--;
		if(var_00 < 0)
		{
			self.var_CDC = 1;
			break;
		}
	}
}

//Function Number: 9
func_0FF4()
{
	level.var_20C9++;
	return level.var_20C9;
}

//Function Number: 10
func_110B(param_00)
{
	self setanim(%exposed_aiming,1,0.2);
	self setanimknoblimited(animscripts/utility::func_D4D("straight_level"),1,param_00);
	self setanimknoblimited(animscripts/utility::func_D4D("add_aim_up"),1,param_00);
	self setanimknoblimited(animscripts/utility::func_D4D("add_aim_down"),1,param_00);
	self setanimknoblimited(animscripts/utility::func_D4D("add_aim_left"),1,param_00);
	self setanimknoblimited(animscripts/utility::func_D4D("add_aim_right"),1,param_00);
}

//Function Number: 11
func_1114()
{
	if(!isdefined(self.a.aimidlethread))
	{
		func_110B(0.2);
		thread aimidlethread();
		thread animscripts/track::func_CA9();
	}
}

//Function Number: 12
func_0F85()
{
	func_0F9D();
	self clearanim(%add_fire,0.1);
	self notify("stop tracking");
}

//Function Number: 13
func_237B()
{
	if(isdefined(self.a.aimidlethread))
	{
		self setanim(%add_idle,0,0.2);
	}

	self setanim(%add_fire,1,0.1);
}

//Function Number: 14
func_111E()
{
	if(isdefined(self.a.aimidlethread))
	{
		self setanim(%add_idle,1,0.2);
	}

	self setanim(%add_fire,0,0.1);
}

//Function Number: 15
aimidlethread(param_00)
{
	self endon("killanimscript");
	self endon("end_aim_idle_thread");
	if(isdefined(self.a.aimidlethread))
	{
		return;
	}

	self.a.aimidlethread = 1;
	wait 0.1;
	self setanimlimited(%add_idle,1,0.2);
	var_01 = 0;
	for(;;)
	{
		var_02 = "idle" + var_01;
		if(isdefined(self.a.var_237C))
		{
			var_03 = animscripts/utility::func_CA8("lean_idle");
		}
		else
		{
			var_03 = animscripts/utility::func_CA8("exposed_idle");
		}

		self setflaggedanimknoblimitedrestart(var_02,var_03,1,0.2);
		self waittillmatch("end",var_02);
		var_01++;
	}

	self clearanim(%add_idle,0.1);
}

//Function Number: 16
func_0F9D()
{
	self notify("end_aim_idle_thread");
	self.a.aimidlethread = undefined;
	self clearanim(%add_idle,0.1);
}

//Function Number: 17
func_237D()
{
	if(animscripts/utility::func_C97())
	{
		return 1;
	}

	if(animscripts/weaponlist::func_CCA())
	{
		return animscripts/weaponlist::func_CCC() * 0.7;
	}

	return 0.4;
}

//Function Number: 18
func_237E(param_00,param_01,param_02)
{
	var_03 = "fireAnim_" + func_0FF4();
	maps\_gameskill::resetmisstime();
	while(!func_10E4())
	{
		wait 0.05;
	}

	func_237B();
	var_04 = 1;
	if(isdefined(self.var_237F))
	{
		var_04 = self.var_237F;
	}
	else if(self.var_CDA == "full")
	{
		var_04 = animscripts/weaponlist::func_CCC() * randomfloatrange(0.5,1);
	}
	else if(self.var_CDA == "burst")
	{
		var_04 = animscripts/weaponlist::func_CCD();
	}
	else if(animscripts/utility::func_C95())
	{
		var_04 = 3;
	}
	else if(animscripts/utility::func_2380())
	{
		var_04 = func_237D();
	}

	self setflaggedanimknobrestart(var_03,param_00,1,0.2,var_04);
	self updateplayersightaccuracy();
	if(!isdefined(self.var_23F))
	{
		self.var_23F = 0;
	}

	self.var_23F++;
	func_2381(var_03,param_00,param_01,param_02);
	self.var_23F = 0;
	func_111E();
}

//Function Number: 19
func_2381(param_00,param_01,param_02,param_03)
{
	self endon("enemy");
	if(isplayer(self.enemy) && self.var_CDA == "full" || self.var_CDA == "semi")
	{
		level endon("player_becoming_invulnerable");
	}

	if(param_02)
	{
		thread func_2382(param_00,"fireAnimEnd");
		self endon("fireAnimEnd");
	}

	if(!isdefined(param_03))
	{
		param_03 = -1;
	}

	var_04 = 0;
	var_05 = animhasnotetrack(param_01,"fire");
	var_06 = weaponclass(self.weapon) == "rocketlauncher";
	while(var_04 < param_03 && param_03 > 0)
	{
		if(var_05)
		{
			self waittillmatch("fire",param_00);
		}

		if(!self.bulletsinclip)
		{
			if(!func_10BB())
			{
				break;
			}
		}

		if(!func_10E4())
		{
			break;
		}

		func_2383();
		if(isplayer(self.enemy) && self.enemy maps\_utility::ent_flag("player_is_invulnerable"))
		{
			if(randomint(3) == 0)
			{
				self.bulletsinclip--;
			}
		}
		else
		{
			self.bulletsinclip--;
		}

		if(var_06)
		{
			self.a.rockets--;
			if(self.weapon == "rpg")
			{
				self hidepart("tag_rocket");
				self.a.var_CD2 = 0;
			}
		}

		var_04++;
		thread func_2387(param_00);
		if(self.var_CDB && var_04 == param_03)
		{
			break;
		}

		if(!var_05 || param_03 == 1 && self.var_CDA == "single")
		{
			self waittillmatch("end",param_00);
		}
	}

	if(param_02)
	{
		self notify("fireAnimEnd");
	}
}

//Function Number: 20
func_10E4()
{
	if(!isdefined(self.var_CB1))
	{
		return 1;
	}

	var_00 = self getmuzzleangle();
	var_01 = animscripts/shared::func_CB0();
	var_02 = vectortoangles(self.var_CB1 - var_01);
	var_03 = animscripts/utility::func_D61(var_00[1] - var_02[1]);
	if(var_03 > level.var_209E)
	{
		if(distancesquared(self geteye(),self.var_CB1) > level.var_209F || var_03 > level.var_20A0)
		{
			return 0;
		}
	}

	return animscripts/utility::func_D61(var_00[0] - var_02[0]) <= level.var_20A1;
}

//Function Number: 21
func_2382(param_00,param_01)
{
	self endon("killanimscript");
	self endon(param_01);
	self waittillmatch("end",param_00);
	self notify(param_01);
}

//Function Number: 22
func_2383()
{
	if(isdefined(self.var_CAB))
	{
		if(isdefined(self.enemy) && self.var_CAB == self.enemy)
		{
			animscripts/utility::func_D5F();
		}
	}
	else
	{
		animscripts/utility::func_2384(self.var_CB1);
	}
}

//Function Number: 23
func_2385()
{
	if(self.weapon != "rpg")
	{
		return;
	}

	self.a.var_CD2 = 1;
	self showpart("tag_rocket");
	self notify("showing_rocket");
}

//Function Number: 24
func_0CD3()
{
	if(self.weapon != "rpg")
	{
		return;
	}

	self endon("death");
	self endon("showing_rocket");
	self waittill("killanimscript");
	func_2385();
}

//Function Number: 25
func_2386()
{
	if(self.bulletsinclip)
	{
		self.bulletsinclip--;
	}
}

//Function Number: 26
func_2387(param_00)
{
	if(!animscripts/utility::func_C97())
	{
		return;
	}

	self endon("killanimscript");
	self notify("shotgun_pump_sound_end");
	self endon("shotgun_pump_sound_end");
	thread func_2388(2);
	self waittillmatch("rechamber",param_00);
	self playsound("ai_shotgun_pump");
	self notify("shotgun_pump_sound_end");
}

//Function Number: 27
func_2388(param_00)
{
	self endon("killanimscript");
	self endon("shotgun_pump_sound_end");
	wait param_00;
	self notify("shotgun_pump_sound_end");
}

//Function Number: 28
func_2389(param_00)
{
}

//Function Number: 29
func_0F08(param_00)
{
	if(self.weapon == "none")
	{
		return 0;
	}

	if(isdefined(self.var_238A))
	{
		if(self.bulletsinclip < weaponclipsize(self.weapon) * 0.5)
		{
			self.bulletsinclip = int(weaponclipsize(self.weapon) * 0.5);
		}

		if(self.bulletsinclip <= 0)
		{
			self.bulletsinclip = 0;
		}

		return 0;
	}

	if(self.bulletsinclip <= weaponclipsize(self.weapon) * param_00)
	{
		if(param_00 == 0)
		{
			if(func_10BB())
			{
				return 0;
			}
		}

		return 1;
	}

	return 0;
}

//Function Number: 30
func_1153()
{
	self endon("weapon_switch_done");
	self endon("death");
	self waittill("killanimscript");
	animscripts/shared::func_C9B(self.primaryweapon,"right");
}

//Function Number: 31
func_0F54(param_00,param_01)
{
	self endon("killanimscript");
	if(!func_0F08(param_00))
	{
		return 0;
	}

	animscripts/battlechatter_ai::func_B36();
	animscripts/battlechatter::func_ABF();
	if(isdefined(param_01))
	{
		self setflaggedanimknoball("reloadanim",param_01,%body,1,0.1,1);
		animscripts/shared::donotetracks("reloadanim");
		animscripts/weaponlist::func_CD0();
		self.a.var_114D = 0;
	}
	else
	{
		if(self.a.pose == "prone")
		{
			self setflaggedanimknoball("reloadanim",%prone_reload,%body,1,0.1,1);
			self updateprone(%prone_legs_up,%prone_legs_down,1,0.1,1);
		}
		else
		{
			wait 2;
			return;
		}

		animscripts/shared::donotetracks("reloadanim");
		animscripts/weaponlist::func_CD0();
		self.a.var_114D = 0;
	}

	return 1;
}

//Function Number: 32
func_238B(param_00,param_01)
{
	if(!isdefined(level.var_238C))
	{
		anim.var_238C = [];
		anim.var_238D = [];
	}

	var_02 = level.var_238C.size;
	level.var_238C[var_02] = param_00;
	level.var_238D[var_02] = param_01;
}

//Function Number: 33
func_20E7()
{
	func_238B(%exposed_grenadethrowb,(41.5391,7.28883,72.2128));
	func_238B(%exposed_grenadethrowc,(34.8849,-4.77048,74.0488));
	func_238B(%corner_standl_grenade_a,(41.605,6.80107,81.4785));
	func_238B(%corner_standl_grenade_b,(24.1585,-14.7221,29.2992));
	func_238B(%cornercrl_grenadea,(25.8988,-10.2811,30.4813));
	func_238B(%cornercrl_grenadeb,(24.688,45.0702,64.377));
	func_238B(%corner_standr_grenade_a,(37.1254,-32.7053,76.5745));
	func_238B(%corner_standr_grenade_b,(19.356,15.5341,16.5036));
	func_238B(%cornercrr_grenadea,(39.8857,5.92472,24.5878));
	func_238B(%covercrouch_grenadea,(-1.6363,-0.693674,60.1009));
	func_238B(%covercrouch_grenadeb,(-1.6363,-0.693674,60.1009));
	func_238B(%coverstand_grenadea,(10.8573,7.12614,77.2356));
	func_238B(%coverstand_grenadeb,(19.1804,5.68214,73.2278));
	func_238B(%prone_grenade_a,(12.2859,-1.3019,33.4307));
	func_238B(%cqb_stand_grenade_throw,(35.7494,26.6052,37.7086));
}

//Function Number: 34
func_1094(param_00)
{
	var_01 = (0,0,64);
	if(isdefined(param_00))
	{
		foreach(var_04, var_03 in level.var_238C)
		{
			if(param_00 == var_03)
			{
				var_01 = level.var_238D[var_04];
				break;
			}
		}
	}

	if(var_01[2] == 64)
	{
		if(isdefined(param_00))
		{
		}
		else
		{
		}
	}

	return var_01;
}

//Function Number: 35
func_238E()
{
	for(var_00 = 0;var_00 < level.players.size;var_00++)
	{
		if(level.players[var_00].var_20E4 == 0)
		{
			level.players[var_00].var_20E3["fraggrenade"] = 0;
			level.players[var_00].var_20E3["flash_grenade"] = 0;
		}
	}

	anim.throwgrenadeatplayerasap = 1;
}

//Function Number: 36
func_1093(param_00)
{
	self.var_238F = spawnstruct();
	if(isplayer(param_00))
	{
		self.var_238F.var_2390 = 1;
		self.var_238F.player = param_00;
		self.var_238F.var_2391 = self.grenadeweapon;
		return;
	}

	self.var_238F.var_2390 = 0;
	self.var_238F.var_2391 = "AI_" + self.grenadeweapon;
}

//Function Number: 37
func_2392()
{
	return self.var_238F.var_2390;
}

//Function Number: 38
func_2393(param_00,param_01)
{
	if(param_00.var_2390)
	{
		var_02 = param_00.player;
		var_03 = var_02.var_20E3[param_00.var_2391];
		var_02.var_20E3[param_00.var_2391] = max(param_01,var_03);
		return;
	}

	var_03 = level.var_20E3[param_01.var_2391];
	level.var_20E3[param_00.var_2391] = max(param_01,var_03);
}

//Function Number: 39
func_2394()
{
	var_00 = undefined;
	if(func_2392())
	{
		var_01 = self.var_238F.player;
		var_00 = gettime() + var_01.gs.playergrenadebasetime + randomint(var_01.gs.playergrenaderangetime);
	}
	else
	{
		var_00 = gettime() + 30000 + randomint(30000);
	}

	return var_00;
}

//Function Number: 40
func_2395(param_00)
{
	if(param_00.var_2390)
	{
		return param_00.player.var_20E3[param_00.var_2391];
	}

	return level.var_20E3[param_00.var_2391];
}

//Function Number: 41
func_2396(param_00)
{
	if(!isplayer(param_00) && self isbadguy())
	{
		if(gettime() < func_2395(self.var_238F))
		{
			if(level.player.ignoreme)
			{
				return param_00;
			}

			var_01 = self getthreatbiasgroup();
			var_02 = level.player getthreatbiasgroup();
			if(var_01 != "" && var_02 != "" && getthreatbias(var_02,var_01) < -10000)
			{
				return param_00;
			}

			if(self cansee(level.player) || isai(param_00) && param_00 cansee(level.player))
			{
				if(isdefined(self.var_CAF))
				{
					var_03 = vectortoangles(level.player.origin - self.origin);
					var_04 = angleclamp180(self.var_CAF.angles[1] - var_03[1]);
				}
				else
				{
					var_04 = animscripts/utility::func_113E(level.player.origin);
				}

				if(abs(var_04) < 60)
				{
					param_00 = level.player;
					func_1093(param_00);
				}
			}
		}
	}

	return param_00;
}

//Function Number: 42
func_2397(param_00)
{
	if(maps\_utility::player_died_recently())
	{
		return 0;
	}

	if(!param_00.gs.double_grenades_allowed)
	{
		return 0;
	}

	var_01 = gettime();
	if(var_01 < param_00.var_20E3["double_grenade"])
	{
		return 0;
	}

	if(var_01 > param_00.var_20E6 + 3000)
	{
		return 0;
	}

	if(var_01 < param_00.var_20E6 + 500)
	{
		return 0;
	}

	return param_00.var_20E4 < 2;
}

//Function Number: 43
func_1138()
{
	return gettime() >= self.a.var_113A;
}

//Function Number: 44
func_113D(param_00)
{
	if(maps\_utility::player_died_recently())
	{
		return 0;
	}

	if(self.script_forcegrenade == 1)
	{
		return 1;
	}

	if(!func_1138())
	{
		return 0;
	}

	if(gettime() >= func_2395(self.var_238F))
	{
		return 1;
	}

	if(self.var_238F.var_2390 && self.var_238F.var_2391 == "fraggrenade")
	{
		return func_2397(param_00);
	}

	return 0;
}

//Function Number: 45
func_2399(param_00,param_01,param_02,param_03)
{
	if(!self isgrenadepossafe(param_00,param_01))
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
	return func_1095(param_00,var_04,param_02,param_03);
}

//Function Number: 46
func_0FA1(param_00,param_01)
{
	if(self.weapon == "mg42" || self.grenadeammo <= 0)
	{
		return 0;
	}

	func_1093(param_00);
	param_00 = func_2396(param_00);
	if(!func_113D(param_00))
	{
		return 0;
	}

	var_02 = func_1094(param_01);
	if(isdefined(self.enemy) && param_00 == self.enemy)
	{
		if(!func_23B7())
		{
			return 0;
		}

		if(isplayer(self.enemy) && maps\_utility::is_player_down(self.enemy))
		{
			return 0;
		}

		if(animscripts/utility::func_F4A())
		{
			if(!self isgrenadepossafe(param_00,param_00.origin))
			{
				return 0;
			}

			return func_1095(param_00,undefined,param_01,var_02);
		}
		else if(animscripts/utility::func_F39())
		{
			return func_2399(param_00,animscripts/utility::func_CEE(),param_01,var_02);
		}
		else
		{
			if(!self isgrenadepossafe(param_00,param_00.origin))
			{
				return 0;
			}

			return func_1095(param_00,undefined,param_01,var_02);
		}

		return 0;
	}

	return func_2399(param_00,param_00.origin,param_01,var_02);
}

//Function Number: 47
func_1095(param_00,param_01,param_02,param_03,param_04,param_05,param_06)
{
	if(gettime() < 10000 && !isdefined(level.var_239A))
	{
		return 0;
	}

	if(!isdefined(param_05))
	{
		param_05 = 1;
	}

	if(isdefined(param_02))
	{
		var_07 = param_02;
		var_08 = self.a.var_20A7;
	}
	else
	{
		switch(self.a.var_D19)
		{
			case "cover_crouch":
			case "none":
				if(self.a.pose == "stand")
				{
					param_05 = (0,0,80);
					var_07 = %stand_grenade_throw;
				}
				else
				{
					param_05 = (0,0,65);
					var_07 = %crouch_grenade_throw;
				}
	
				var_08 = "left";
				break;

			default:
				var_07 = undefined;
				var_08 = undefined;
				break;
		}
	}

	if(!isdefined(var_07))
	{
		return 0;
	}

	if(isdefined(param_01))
	{
		if(!isdefined(param_04))
		{
			var_09 = self checkgrenadethrowpos(param_03,param_01,param_05,"min energy","min time","max time");
		}
		else
		{
			var_09 = self checkgrenadethrowpos(param_04,param_02,param_06,"min time","min energy");
		}
	}
	else
	{
		var_0A = self.var_20B6;
		var_0B = distance(param_00.origin,self.origin);
		if(var_0B < 800)
		{
			if(var_0B < 256)
			{
				var_0A = 0;
			}
			else
			{
				var_0A = var_0A * var_0B - 256 / 544;
			}
		}

		if(!isdefined(param_04))
		{
			var_09 = self checkgrenadethrow(param_03,var_0A,"min energy","min time","max time");
		}
		else
		{
			var_09 = self checkgrenadethrow(param_03,var_0A,"min time","min energy");
		}
	}

	self.a.var_113A = gettime() + randomintrange(1000,2000);
	if(isdefined(var_09))
	{
		if(!isdefined(self.var_239B))
		{
			self.var_239B = self.grenadeawareness;
		}

		self.grenadeawareness = 0;
		var_0C = func_2394();
		func_2393(self.var_238F,min(gettime() + 3000,var_0C));
		var_0D = 0;
		if(func_2392())
		{
			param_00.var_20E4++;
			thread func_239C(param_00);
			if(param_00.var_20E4 > 1)
			{
				var_0D = 1;
			}

			if(self.var_238F.var_2391 == "fraggrenade")
			{
				if(param_00.var_20E4 <= 1)
				{
					param_00.var_20E6 = gettime();
				}
			}
		}

		if(isdefined(param_06))
		{
			thread func_239D(var_07,var_09,var_0C,var_0D);
		}
		else
		{
			func_239D(var_07,var_09,var_0C,var_0D);
		}

		return 1;
	}
	else
	{
	}

	return 0;
}

//Function Number: 48
func_239C(param_00)
{
	self endon("dont_reduce_giptp_on_killanimscript");
	self waittill("killanimscript");
	param_00.var_20E4--;
}

//Function Number: 49
func_239D(param_00,param_01,param_02,param_03)
{
	self endon("killanimscript");
	if(self.script == "combat" || self.script == "move")
	{
		self orientmode("face direction",param_01);
	}

	animscripts/battlechatter_ai::func_B3A(self.grenadeweapon);
	self notify("stop_aiming_at_enemy");
	self setflaggedanimknoballrestart("throwanim",param_00,%body,func_0F7B(),0.1,1);
	thread animscripts/notetracks::func_239E("throwanim","killanimscript");
	var_04 = animscripts/utility::func_239F();
	var_05 = "none";
	for(;;)
	{
		self waittill("throwanim",var_06);
		if(var_06 == "grenade_left" || var_06 == "grenade_right")
		{
			var_05 = func_23A6(var_04,"TAG_INHAND");
			self.var_23A0 = 1;
		}

		if(var_06 == "grenade_throw" || var_06 == "grenade throw")
		{
			break;
		}

		if(var_06 == "end")
		{
			self.var_238F.player.var_20E4--;
			self notify("dont_reduce_giptp_on_killanimscript");
			return 0;
		}
	}

	self notify("dont_reduce_giptp_on_killanimscript");
	if(func_2392())
	{
		thread func_23A1(self.var_238F.player,param_02);
	}

	self throwgrenade();
	if(!func_2392())
	{
		func_2393(self.var_238F,param_02);
	}

	if(param_03)
	{
		var_0D = self.var_238F.player;
		if(var_0D.var_20E4 > 1 || gettime() - var_0D.var_20E5 < 2000)
		{
			var_0D.var_20E3["double_grenade"] = gettime() + min(5000,var_0D.gs.playerdoublegrenadetime);
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

	self.var_23A0 = undefined;
	self.grenadeawareness = self.var_239B;
	self.var_239B = undefined;
	self waittillmatch("end","throwanim");
	self notify("done_grenade_throw");
	self notify("weapon_switch_done");
	self setanim(%exposed_modern,1,0.2);
	self setanim(%exposed_aiming,1);
	self clearanim(param_00,0.2);
}

//Function Number: 50
func_23A1(param_00,param_01)
{
	param_00 endon("death");
	func_23A2(param_01);
	param_00.var_20E4--;
}

//Function Number: 51
func_23A2(param_00)
{
	var_01 = self.var_238F;
	var_02 = spawnstruct();
	var_02 thread func_23A5(5);
	var_02 endon("watchGrenadeTowardsPlayerTimeout");
	var_03 = self.grenadeweapon;
	var_04 = func_23A4();
	if(!isdefined(var_04))
	{
		return;
	}

	func_2393(var_01,min(gettime() + 5000,param_00));
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
		wait 0.1;
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
					var_0B func_23A3(var_01,param_00);
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

//Function Number: 52
func_23A3(param_00,param_01)
{
	var_02 = self;
	anim.throwgrenadeatplayerasap = undefined;
	if(gettime() - var_02.var_20E5 < 3000)
	{
		var_02.var_20E3["double_grenade"] = gettime() + var_02.gs.playerdoublegrenadetime;
	}

	var_02.var_20E5 = gettime();
	var_03 = var_02.var_20E3[param_00.var_2391];
	var_02.var_20E3[param_00.var_2391] = max(param_01,var_03);
}

//Function Number: 53
func_23A4()
{
	self endon("killanimscript");
	self waittill("grenade_fire",var_00);
	return var_00;
}

//Function Number: 54
func_23A5(param_00)
{
	wait param_00;
	self notify("watchGrenadeTowardsPlayerTimeout");
}

//Function Number: 55
func_23A6(param_00,param_01)
{
	self attach(param_00,param_01);
	thread func_23A7(param_00,param_01);
	return param_01;
}

//Function Number: 56
func_23A7(param_00,param_01)
{
	self endon("stop grenade check");
	self waittill("killanimscript");
	if(!isdefined(self))
	{
		return;
	}

	if(isdefined(self.var_239B))
	{
		self.grenadeawareness = self.var_239B;
		self.var_239B = undefined;
	}

	self detach(param_00,param_01);
}

//Function Number: 57
func_23A8(param_00)
{
	var_01 = anglestoforward(self.angles);
	var_02 = anglestoright(self.angles);
	var_03 = anglestoup(self.angles);
	var_01 = var_01 * param_00[0];
	var_02 = var_02 * param_00[1];
	var_03 = var_03 * param_00[2];
	return var_01 + var_02 + var_03;
}

//Function Number: 58
func_23A9(param_00,param_01)
{
	level notify("armoffset");
	level endon("armoffset");
	param_00 = self.origin + func_23A8(param_00);
	wait 0.05;
}

//Function Number: 59
func_0D7E()
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

//Function Number: 60
func_23AA()
{
	var_00 = self gettagorigin("tag_inhand");
	var_01 = func_0D7E();
	self magicgrenademanual(var_00,var_01,3);
}

//Function Number: 61
func_0F3B()
{
	if(!isdefined(self.enemy))
	{
		return 0;
	}

	if(self.fixednode || self.var_748)
	{
		return 0;
	}

	var_00 = func_23AB();
	if(isdefined(var_00))
	{
		return func_23AC(var_00);
	}

	return 0;
}

//Function Number: 62
func_23AB()
{
	var_00 = self findbestcovernode();
	if(!isdefined(var_00))
	{
		return undefined;
	}

	var_01 = animscripts/utility::func_BEE();
	if(isdefined(var_01) && var_00 == var_01)
	{
		return undefined;
	}

	if(isdefined(self.var_CAF) && var_00 == self.var_CAF)
	{
		return undefined;
	}

	return var_00;
}

//Function Number: 63
func_23AC(param_00)
{
	var_01 = self.keepclaimednodeifvalid;
	var_02 = self.var_766;
	self.keepclaimednodeifvalid = 0;
	self.var_766 = 0;
	if(self usecovernode(param_00))
	{
		return 1;
	}
	else
	{
	}

	self.keepclaimednodeifvalid = var_01;
	self.var_766 = var_02;
	return 0;
}

//Function Number: 64
func_0F34()
{
	if(level.var_20ED[self.team] > 0 && level.var_20ED[self.team] < level.advancetoenemygroupmax)
	{
		if(gettime() - level.lastadvancetoenemytime[self.team] > 4000)
		{
			return 0;
		}

		var_00 = level.var_20EC[self.team];
		var_01 = isdefined(var_00) && distancesquared(self.origin,var_00.origin) < 65536;
		if((var_01 || distancesquared(self.origin,level.var_20EB[self.team]) < 65536) && !isdefined(self.enemy) || distancesquared(self.enemy.origin,level.var_20EA[self.team]) < 262144)
		{
			return 1;
		}
	}

	return 0;
}

//Function Number: 65
func_23AD()
{
	if(!isdefined(level.lastadvancetoenemytime[self.team]))
	{
		return 0;
	}

	if(func_0F34())
	{
		return 1;
	}

	if(gettime() - level.lastadvancetoenemytime[self.team] < level.advancetoenemyinterval)
	{
		return 0;
	}

	if(!issentient(self.enemy))
	{
		return 0;
	}

	if(level.var_20ED[self.team])
	{
		level.var_20ED[self.team] = 0;
	}

	var_00 = isdefined(self.advance_regardless_of_numbers) && self.advance_regardless_of_numbers;
	if(!var_00 && getaicount(self.team) < getaicount(self.enemy.team))
	{
		return 0;
	}

	return 1;
}

//Function Number: 66
func_0F35(param_00)
{
	if(!isdefined(self.enemy))
	{
		return 0;
	}

	if(self.fixednode)
	{
		return 0;
	}

	if(self.combatmode == "ambush" || self.combatmode == "ambush_nodes_only")
	{
		return 0;
	}

	if(!self isingoal(self.enemy.origin))
	{
		return 0;
	}

	if(func_23BD())
	{
		return 0;
	}

	if(!func_23AD())
	{
		return 0;
	}

	self findreacquiredirectpath(param_00);
	if(self reacquiremove())
	{
		self.keepclaimednodeifvalid = 0;
		self.var_766 = 0;
		self.a.var_1111 = 1;
		if(level.var_20ED[self.team] == 0)
		{
			level.lastadvancetoenemytime[self.team] = gettime();
			level.var_20EC[self.team] = self;
		}

		level.var_20EB[self.team] = self.origin;
		level.var_20EA[self.team] = self.enemy.origin;
		level.var_20ED[self.team]++;
		return 1;
	}

	return 0;
}

//Function Number: 67
func_23AE(param_00)
{
	self endon("death");
	wait 0.5;
	var_01 = "" + level.var_20DD;
	badplace_cylinder(var_01,5,param_00,16,64,self.team);
	level.badplaces[level.badplaces.size] = var_01;
	if(level.badplaces.size >= 10)
	{
		var_02 = [];
		for(var_03 = 1;var_03 < level.badplaces.size;var_03++)
		{
			var_02[var_02.size] = level.badplaces[var_03];
		}

		badplace_delete(level.badplaces[0]);
		anim.badplaces = var_02;
	}

	level.var_20DD++;
	if(level.var_20DD > 10)
	{
		anim.var_20DD = level.var_20DD - 20;
	}
}

//Function Number: 68
func_23AF(param_00,param_01,param_02)
{
	if(param_00 > param_01 && param_00 < param_02)
	{
		return 1;
	}

	return 0;
}

//Function Number: 69
func_23B0()
{
	if(!isdefined(self.var_CB1))
	{
		return 0;
	}

	var_00 = self getmuzzleangle()[1] - animscripts/utility::func_101A(self.var_CB1);
	var_00 = angleclamp180(var_00);
	return var_00;
}

//Function Number: 70
func_23B1()
{
	if(!isdefined(self.var_CB1))
	{
		return 0;
	}

	var_00 = self getmuzzleangle()[0] - vectortoangles(self.var_CB1 - self getmuzzlepos())[0];
	var_00 = angleclamp180(var_00);
	return var_00;
}

//Function Number: 71
func_23B2()
{
	if(!isdefined(self.enemy))
	{
		return 0;
	}

	var_00 = self.enemy getshootatpos() - self getshootatpos();
	var_00 = vectornormalize(var_00);
	var_01 = 360 - vectortoangles(var_00)[0];
	return angleclamp180(var_01);
}

//Function Number: 72
func_23B3(param_00)
{
	if(!isdefined(param_00))
	{
		return 0;
	}

	var_01 = param_00 - self getshootatpos();
	var_01 = vectornormalize(var_01);
	var_02 = 360 - vectortoangles(var_01)[0];
	return angleclamp180(var_02);
}

//Function Number: 73
func_20DE()
{
	self.var_F53 = 0;
	self.var_23B4 = -1;
	for(;;)
	{
		self waittill("reload_start");
		self.var_F53 = 1;
		self.var_23B4 = gettime();
		func_23B5();
		self.var_F53 = 0;
	}
}

//Function Number: 74
func_23B5()
{
	thread func_23B6(4,"reloadtimeout");
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

		if(self getcurrentweaponclipammo() >= weaponclipsize(var_00))
		{
			break;
		}
	}

	self notify("reloadtimeout");
}

//Function Number: 75
func_23B6(param_00,param_01)
{
	self endon(param_01);
	wait param_00;
	self notify(param_01);
}

//Function Number: 76
func_23B7()
{
	var_00 = self.enemy.origin - self.origin;
	var_01 = lengthsquared((var_00[0],var_00[1],0));
	if(self.grenadeweapon == "flash_grenade")
	{
		return var_01 < 589824;
	}

	return var_01 >= -25536 && var_01 <= 1562500;
}

//Function Number: 77
monitorflash()
{
	self endon("death");
	if(!isdefined(level.var_23B8))
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
		if(isdefined(self.flashbangimmunity) && self.flashbangimmunity)
		{
			continue;
		}

		if(isdefined(self.var_23B9) && self.var_23B9 != 0)
		{
			continue;
		}

		if(isdefined(self.onsnowmobile) || isdefined(self.onatv))
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

			if(isdefined(self.teamflashbangimmunity))
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

		self.flashingteam = var_04;
		maps\_utility::flashbangstart(var_06);
		self notify("doFlashBanged",var_01,var_03);
	}
}

//Function Number: 78
func_23BC()
{
	return animscripts/utility::func_CEA(self.primaryweapon);
}

//Function Number: 79
issniper()
{
	return animscripts/utility::func_BEB(self.primaryweapon);
}

//Function Number: 80
func_23BD()
{
	return issniper() || animscripts/utility::func_BB6();
}

//Function Number: 81
func_0F7B()
{
	return 1.5;
}

//Function Number: 82
func_0F97()
{
	return randomfloatrange(1,1.2);
}

//Function Number: 83
func_0FB6(param_00)
{
	if(param_00.size == 0)
	{
		return undefined;
	}

	if(param_00.size == 1)
	{
		return param_00[0];
	}

	if(isdefined(self.a.var_F3E) && randomint(100) > 20)
	{
		foreach(var_03, var_02 in param_00)
		{
			if(var_02 == self.a.var_F3E)
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

//Function Number: 84
func_0D0E()
{
	var_00 = self geteye();
	foreach(var_02 in level.players)
	{
		if(!self cansee(var_02))
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

		if(common_scripts\utility::cointoss() && var_08 >= 0.996)
		{
			continue;
		}

		return 1;
	}

	return 0;
}