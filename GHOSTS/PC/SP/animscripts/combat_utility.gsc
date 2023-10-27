/*******************************************************************
 * Decompiled By: Bog
 * Decompiled File: animscripts\combat_utility.gsc
 * Game: Call of Duty: Ghosts
 * Platform: PC
 * Function Count: 85
 * Decompile Time: 1456 ms
 * Timestamp: 10/27/2023 1:23:37 AM
*******************************************************************/

//Function Number: 1
func_3C21(param_00)
{
	var_01 = self getshootatpos() + (0,0,-3);
	var_02 = (var_01[0] - param_00[0],var_01[1] - param_00[1],var_01[2] - param_00[2]);
	var_02 = vectornormalize(var_02);
	var_03 = var_02[2] * -1;
	return var_03;
}

//Function Number: 2
func_3BEA()
{
	if(isplayer(self.enemy))
	{
		return randomfloatrange(self.enemy.var_3DE2.var_522F,self.enemy.var_3DE2.var_50E0);
	}

	return randomfloatrange(level.var_522F,level.var_50E0);
}

//Function Number: 3
getremainingburstdelaytime()
{
	var_00 = gettime() - self.a.lastshoottime / 1000;
	var_01 = func_3A46();
	if(var_01 > var_00)
	{
		return var_01 - var_00;
	}

	return 0;
}

//Function Number: 4
func_3A46()
{
	if(animscripts/utility::func_87FE())
	{
		return randomfloatrange(0.15,0.55);
	}

	if(animscripts/utility::func_8D9B())
	{
		return randomfloatrange(1,1.7);
	}

	if(issniper())
	{
		return func_3BEA();
	}

	if(self.var_31EA)
	{
		return randomfloatrange(0.1,0.35);
	}

	return randomfloatrange(0.4,0.9);
}

//Function Number: 5
burstdelay()
{
	if(self.bulletsinclip)
	{
		if(self.var_744B == "full" && !self.var_31EA)
		{
			if(self.a.lastshoottime == gettime())
			{
				wait(0.05);
			}
		}

		var_00 = getremainingburstdelaytime();
		if(var_00)
		{
			wait(var_00);
		}
	}
}

//Function Number: 6
cheatammoifnecessary()
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

	if(animscripts/utility::func_87FE() || animscripts/utility::func_87FA())
	{
		return 0;
	}

	if(gettime() - self.ammocheattime < self.ammocheatinterval)
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

	self.ammocheattime = gettime();
	return 1;
}

//Function Number: 7
aimbutdontshoot()
{
	for(var_00 = int(60);var_00 > 0;var_00--)
	{
		if(isdefined(self.var_29AA) || isdefined(self.enemy) && isdefined(self.enemy.var_29A1))
		{
			wait(0.05);
			continue;
		}

		return 0;
	}

	return 1;
}

//Function Number: 8
func_744D()
{
	self endon("shoot_behavior_change");
	self endon("stopShooting");
	if(islongrangeai())
	{
		if(isdefined(self.enemy) && isai(self.enemy) && distancesquared(level.player.origin,self.enemy.origin) < 147456)
		{
			self.enemy animscripts/battlechatter_ai::addthreatevent("infantry",self,1);
		}

		if(animscripts/utility::func_87FA() && issentient(self.enemy))
		{
			wait(randomfloat(2));
		}
	}

	if(isdefined(self.enemy) && distancesquared(self.origin,self.enemy.origin) > 160000)
	{
		var_00 = randomintrange(1,5);
	}
	else
	{
		var_00 = 10;
	}

	for(;;)
	{
		burstdelay();
		if(aimbutdontshoot())
		{
			break;
		}

		if(self.var_744B == "full")
		{
			func_3326(animscripts/utility::animarray("fire"),1,animscripts/shared::func_2438());
		}
		else if(self.var_744B == "burst" || self.var_744B == "semi")
		{
			var_01 = animscripts/shared::func_2437();
			if(var_01 == 1)
			{
				func_3326(animscripts/utility::animarraypickrandom("single"),1,var_01);
			}
			else
			{
				func_3326(animscripts/utility::animarray(self.var_744B + var_01),1,var_01);
			}
		}
		else if(self.var_744B == "single")
		{
			func_3326(animscripts/utility::animarraypickrandom("single"),1,1);
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
			self.shouldreturntocover = 1;
			break;
		}
	}
}

//Function Number: 9
getuniqueflagnameindex()
{
	level.animflagnameindex++;
	return level.animflagnameindex;
}

//Function Number: 10
func_71EA(param_00)
{
	self setanim(%exposed_aiming,1,0.2);
	self setanimknoblimited(animscripts/utility::animarray("straight_level"),1,param_00);
	self setanimknoblimited(animscripts/utility::animarray("add_aim_up"),1,param_00);
	self setanimknoblimited(animscripts/utility::animarray("add_aim_down"),1,param_00);
	self setanimknoblimited(animscripts/utility::animarray("add_aim_left"),1,param_00);
	self setanimknoblimited(animscripts/utility::animarray("add_aim_right"),1,param_00);
	self.facialidx = animscripts/face::func_6004(undefined,"aim",self.facialidx);
}

//Function Number: 11
startfireandaimidlethread()
{
	if(!isdefined(self.a.aimidlethread))
	{
		func_71EA(0.2);
		thread aimidlethread();
		thread animscripts/track::trackshootentorpos();
	}
}

//Function Number: 12
func_2D52()
{
	func_2D4B();
	self clearanim(%add_fire,0.1);
	self notify("stop tracking");
}

//Function Number: 13
func_750F()
{
	if(isdefined(self.a.aimidlethread))
	{
		self setanim(%add_idle,0,0.2);
	}

	self setanim(%add_fire,1,0.1);
}

//Function Number: 14
func_4204()
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
	}

	self.a.aimidlethread = 1;
	wait(0.1);
	self setanimlimited(%add_idle,1,0.2);
	var_01 = %add_idle;
	var_02 = 0;
	for(;;)
	{
		var_03 = "idle" + var_02;
		if(isdefined(self.a.var_4D3C))
		{
			var_04 = animscripts/utility::animarraypickrandom("lean_idle");
		}
		else if(animscripts/utility::animarrayanyexist("exposed_idle"))
		{
			var_04 = animscripts/utility::animarraypickrandom("exposed_idle");
		}
		else
		{
			wait(0.5);
		}
		else
		{
			if(var_04 == var_01)
			{
				self setflaggedanimlimitedrestart(var_03,var_04,1,0.2);
			}
			else
			{
				self setflaggedanimknoblimitedrestart(var_03,var_04,1,0.2);
			}

			var_01 = var_04;
			self waittillmatch("end",var_03);
		}

		var_02++;
	}

	self clearanim(%add_idle,0.1);
}

//Function Number: 16
func_2D4B()
{
	self notify("end_aim_idle_thread");
	self.a.aimidlethread = undefined;
	self clearanim(%add_idle,0.1);
}

//Function Number: 17
func_745E()
{
	if(animscripts/utility::func_8D9B())
	{
		return 1;
	}

	if(animscripts/weaponlist::func_87EF())
	{
		return animscripts/weaponlist::autoshootanimrate() * 0.7;
	}

	return 0.4;
}

//Function Number: 18
func_3326(param_00,param_01,param_02)
{
	var_03 = "fireAnim_" + getuniqueflagnameindex();
	maps\_gameskill::func_660F();
	while(!aimedatshootentorpos())
	{
		wait(0.05);
	}

	func_750F();
	var_04 = 1;
	if(isdefined(self.var_744A))
	{
		var_04 = self.var_744A;
	}
	else if(self.var_744B == "full")
	{
		var_04 = animscripts/weaponlist::autoshootanimrate() * randomfloatrange(0.5,1);
	}
	else if(self.var_744B == "burst")
	{
		var_04 = animscripts/weaponlist::burstshootanimrate();
	}
	else if(animscripts/utility::func_87FE())
	{
		var_04 = 3;
	}
	else if(animscripts/utility::func_87FD())
	{
		var_04 = func_745E();
	}

	self setflaggedanimknobrestart(var_03,param_00,1,0.2,var_04);
	self updateplayersightaccuracy();
	fireuntiloutofammointernal(var_03,param_00,param_01,param_02);
	func_4204();
}

//Function Number: 19
func_3327()
{
	self endon("killanimscript");
	self endon("fireAnimEnd");
	var_00 = thisthread;
	for(;;)
	{
		waittillframeend;
		if(!isdefined(var_00))
		{
			self shootstopsound();
		}

		wait(0.05);
	}
}

//Function Number: 20
fireuntiloutofammointernal(param_00,param_01,param_02,param_03)
{
	self endon("enemy");
	if(isplayer(self.enemy) && self.var_744B == "full" || self.var_744B == "semi")
	{
		level endon("player_becoming_invulnerable");
	}

	if(param_02)
	{
		thread notifyonanimend(param_00,"fireAnimEnd");
		self endon("fireAnimEnd");
	}

	if(!isdefined(param_03))
	{
		param_03 = -1;
	}

	var_04 = 0;
	var_05 = animhasnotetrack(param_01,"fire");
	var_06 = weaponclass(self.weapon) == "rocketlauncher";
	thread func_3327();
	while(var_04 < param_03 && param_03 > 0)
	{
		if(var_05)
		{
			self waittillmatch("fire",param_00);
		}

		if(!self.bulletsinclip)
		{
			if(!cheatammoifnecessary())
			{
				break;
			}
		}

		if(!aimedatshootentorpos())
		{
			break;
		}

		func_7431();
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
			if(issubstr(tolower(self.weapon),"rpg") || issubstr(tolower(self.weapon),"panzerfaust"))
			{
				self hidepart("tag_rocket");
				self.a.var_66F8 = 0;
			}
		}

		var_04++;
		thread func_745F(param_00);
		if(self.var_31EA && var_04 == param_03)
		{
			break;
		}

		if(!var_05 || param_03 == 1 && self.var_744B == "single")
		{
			self waittillmatch("end",param_00);
		}
	}

	self shootstopsound();
	if(param_02)
	{
		self notify("fireAnimEnd");
	}
}

//Function Number: 21
aimedatshootentorpos()
{
	if(!isdefined(self.var_7445))
	{
		return 1;
	}

	var_00 = self getmuzzleangle();
	var_01 = animscripts/shared::func_3BE5();
	var_02 = vectortoangles(self.var_7445 - var_01);
	var_03 = animscripts/utility::absangleclamp180(var_00[1] - var_02[1]);
	if(var_03 > level.var_A54)
	{
		if(distancesquared(self geteye(),self.var_7445) > level.aimyawdiffclosedistsq || var_03 > level.var_A53)
		{
			return 0;
		}
	}

	return animscripts/utility::absangleclamp180(var_00[0] - var_02[0]) <= level.aimpitchdifftolerance;
}

//Function Number: 22
notifyonanimend(param_00,param_01)
{
	self endon("killanimscript");
	self endon(param_01);
	self waittillmatch("end",param_00);
	self notify(param_01);
}

//Function Number: 23
issingleshot()
{
	if(weaponburstcount(self.weapon) > 0)
	{
		return 0;
	}
	else if(weaponisauto(self.weapon))
	{
		return 0;
	}

	return 1;
}

//Function Number: 24
func_7431()
{
	var_00 = issingleshot();
	if(isdefined(self.var_7439))
	{
		if(isdefined(self.enemy) && self.var_7439 == self.enemy)
		{
			animscripts/utility::func_7435(var_00);
		}
	}
	else
	{
		self [[ level.var_7449 ]](self.var_7445,var_00);
	}
}

//Function Number: 25
func_2467()
{
	if(self.bulletsinclip)
	{
		self.bulletsinclip--;
	}
}

//Function Number: 26
func_745F(param_00)
{
	if(!animscripts/utility::func_8D9B())
	{
	}

	self endon("killanimscript");
	self notify("shotgun_pump_sound_end");
	self endon("shotgun_pump_sound_end");
	thread func_7C71(2);
	self waittillmatch("rechamber",param_00);
	self playsound("ai_shotgun_pump");
	self notify("shotgun_pump_sound_end");
}

//Function Number: 27
func_7C71(param_00)
{
	self endon("killanimscript");
	self endon("shotgun_pump_sound_end");
	wait(param_00);
	self notify("shotgun_pump_sound_end");
}

//Function Number: 28
func_6400(param_00)
{
}

//Function Number: 29
func_5596(param_00)
{
	if(self.weapon == "none")
	{
		return 0;
	}

	if(isdefined(self.var_5676))
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
			if(cheatammoifnecessary())
			{
				return 0;
			}
		}

		return 1;
	}

	return 0;
}

//Function Number: 30
func_6255()
{
	self endon("weapon_switch_done");
	self endon("death");
	self waittill("killanimscript");
	animscripts/shared::placeweaponon(self.primaryweapon,"right");
}

//Function Number: 31
reload(param_00,param_01)
{
	self endon("killanimscript");
	if(!func_5596(param_00))
	{
		return 0;
	}

	animscripts/battlechatter_ai::func_2FE7();
	animscripts/battlechatter::func_5D4E();
	if(isdefined(param_01))
	{
		self setflaggedanimknoball("reloadanim",param_01,%body,1,0.1,1);
		animscripts/shared::func_2986("reloadanim");
		animscripts/weaponlist::refillclip();
		self.a.var_5593 = 0;
	}
	else
	{
		if(self.a.var_60B1 == "prone")
		{
			self setflaggedanimknoball("reloadanim",%prone_reload,%body,1,0.1,1);
			self updateprone(%prone_legs_up,%prone_legs_down,1,0.1,1);
		}
		else
		{
			wait(2);
		}

		animscripts/shared::func_2986("reloadanim");
		animscripts/weaponlist::refillclip();
		self.a.var_5593 = 0;
	}

	return 1;
}

//Function Number: 32
addgrenadethrowanimoffset(param_00,param_01)
{
	if(!isdefined(level.var_3DBB))
	{
		anim.var_3DBB = [];
		anim.grenadethrowoffsets = [];
	}

	var_02 = level.var_3DBB.size;
	level.var_3DBB[var_02] = param_00;
	level.grenadethrowoffsets[var_02] = param_01;
}

//Function Number: 33
func_4614()
{
	addgrenadethrowanimoffset(%exposed_grenadethrowb,(41.5391,7.28883,72.2128));
	addgrenadethrowanimoffset(%exposed_grenadethrowc,(34.8849,-4.77048,74.0488));
	addgrenadethrowanimoffset(%corner_standl_grenade_a,(41.605,6.80107,81.4785));
	addgrenadethrowanimoffset(%corner_standl_grenade_b,(24.1585,-14.7221,29.2992));
	addgrenadethrowanimoffset(%cornercrl_grenadea,(25.8988,-10.2811,30.4813));
	addgrenadethrowanimoffset(%cornercrl_grenadeb,(24.688,45.0702,64.377));
	addgrenadethrowanimoffset(%corner_standr_grenade_a,(37.1254,-32.7053,76.5745));
	addgrenadethrowanimoffset(%corner_standr_grenade_b,(19.356,15.5341,16.5036));
	addgrenadethrowanimoffset(%cornercrr_grenadea,(39.8857,5.92472,24.5878));
	addgrenadethrowanimoffset(%covercrouch_grenadea,(-1.6363,-0.693674,60.1009));
	addgrenadethrowanimoffset(%covercrouch_grenadeb,(-1.6363,-0.693674,60.1009));
	addgrenadethrowanimoffset(%coverstand_grenadea,(10.8573,7.12614,77.2356));
	addgrenadethrowanimoffset(%coverstand_grenadeb,(19.1804,5.68214,73.2278));
	addgrenadethrowanimoffset(%prone_grenade_a,(12.2859,-1.3019,33.4307));
	addgrenadethrowanimoffset(%cqb_stand_grenade_throw,(35.7494,26.6052,37.7086));
}

//Function Number: 34
func_3AC0(param_00)
{
	var_01 = (0,0,64);
	if(isdefined(param_00))
	{
		foreach(var_04, var_03 in level.var_3DBB)
		{
			if(param_00 == var_03)
			{
				var_01 = level.grenadethrowoffsets[var_04];
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
func_80AE()
{
	for(var_00 = 0;var_00 < level.players.size;var_00++)
	{
		if(level.players[var_00].numgrenadesinprogresstowardsplayer == 0)
		{
			level.players[var_00].grenadetimers["fraggrenade"] = 0;
			level.players[var_00].grenadetimers["flash_grenade"] = 0;
		}
	}

	anim.var_80AD = 1;
}

//Function Number: 36
setactivegrenadetimer(param_00)
{
	self.activegrenadetimer = spawnstruct();
	if(isplayer(param_00))
	{
		self.activegrenadetimer.isplayertimer = 1;
		self.activegrenadetimer.player = param_00;
		self.activegrenadetimer.timername = self.grenadeweapon;
	}

	self.activegrenadetimer.isplayertimer = 0;
	self.activegrenadetimer.timername = "AI_" + self.grenadeweapon;
}

//Function Number: 37
func_87F5()
{
	return self.activegrenadetimer.isplayertimer;
}

//Function Number: 38
func_7044(param_00,param_01)
{
	if(param_00.isplayertimer)
	{
		var_02 = param_00.player;
		var_03 = var_02.grenadetimers[param_00.timername];
		var_02.grenadetimers[param_00.timername] = max(param_01,var_03);
	}

	var_03 = level.grenadetimers[param_01.timername];
	level.grenadetimers[param_00.timername] = max(param_01,var_03);
}

//Function Number: 39
func_3A7D()
{
	var_00 = undefined;
	if(func_87F5())
	{
		var_01 = self.activegrenadetimer.player;
		var_00 = gettime() + var_01.var_3DE2.var_5FAE + randomint(var_01.var_3DE2.playergrenaderangetime);
	}
	else
	{
		var_00 = gettime() + 30000 + randomint(30000);
	}

	return var_00;
}

//Function Number: 40
func_3AC1(param_00)
{
	if(param_00.isplayertimer)
	{
		return param_00.player.grenadetimers[param_00.timername];
	}

	return level.grenadetimers[param_00.timername];
}

//Function Number: 41
func_1EC4(param_00)
{
	if(!isplayer(param_00) && self isbadguy())
	{
		if(gettime() < func_3AC1(self.activegrenadetimer))
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
				if(isdefined(self.var_1FCA))
				{
					var_03 = vectortoangles(level.player.origin - self.origin);
					var_04 = angleclamp180(self.var_1FCA.angles[1] - var_03[1]);
				}
				else
				{
					var_04 = animscripts/utility::getyawtospot(level.player.origin);
				}

				if(abs(var_04) < 60)
				{
					param_00 = level.player;
					setactivegrenadetimer(param_00);
				}
			}
		}
	}

	return param_00;
}

//Function Number: 42
func_5129(param_00)
{
	if(maps\_utility::player_died_recently())
	{
		return 0;
	}

	if(!param_00.var_3DE2.var_2A26)
	{
		return 0;
	}

	var_01 = gettime();
	if(var_01 < param_00.grenadetimers["double_grenade"])
	{
		return 0;
	}

	if(var_01 > param_00.lastfraggrenadetoplayerstart + 3000)
	{
		return 0;
	}

	if(var_01 < param_00.lastfraggrenadetoplayerstart + 500)
	{
		return 0;
	}

	return param_00.numgrenadesinprogresstowardsplayer < 2;
}

//Function Number: 43
func_554D()
{
	return gettime() >= self.a.var_55EC;
}

//Function Number: 44
grenadecooldownelapsed(param_00)
{
	if(maps\_utility::player_died_recently())
	{
		return 0;
	}

	if(self.script_forcegrenade == 1)
	{
		return 1;
	}

	if(!func_554D())
	{
		return 0;
	}

	if(gettime() >= func_3AC1(self.activegrenadetimer))
	{
		return 1;
	}

	if(self.activegrenadetimer.isplayertimer && self.activegrenadetimer.timername == "fraggrenade")
	{
		return func_5129(param_00);
	}

	return 0;
}

//Function Number: 45
func_8401(param_00,param_01,param_02,param_03)
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
	return func_8402(param_00,var_04,param_02,param_03);
}

//Function Number: 46
func_8400(param_00,param_01)
{
	if(self.weapon == "mg42" || self.grenadeammo <= 0)
	{
		return 0;
	}

	setactivegrenadetimer(param_00);
	param_00 = func_1EC4(param_00);
	if(!grenadecooldownelapsed(param_00))
	{
		return 0;
	}

	var_02 = func_3AC0(param_01);
	if(isdefined(self.enemy) && param_00 == self.enemy)
	{
		if(!checkgrenadethrowdist())
		{
			return 0;
		}

		if(isplayer(self.enemy) && maps\_utility::func_4825(self.enemy))
		{
			return 0;
		}

		if(animscripts/utility::canseeenemyfromexposed())
		{
			if(!self isgrenadepossafe(param_00,param_00.origin))
			{
				return 0;
			}

			return func_8402(param_00,undefined,param_01,var_02);
		}
		else if(animscripts/utility::func_1A00())
		{
			return func_8401(param_00,animscripts/utility::func_3A97(),param_01,var_02);
		}
		else
		{
			if(!self isgrenadepossafe(param_00,param_00.origin))
			{
				return 0;
			}

			return func_8402(param_00,undefined,param_01,var_02);
		}

		return 0;
	}

	return func_8401(param_00,param_00.origin,param_01,var_02);
}

//Function Number: 47
func_8402(param_00,param_01,param_02,param_03,param_04,param_05,param_06)
{
	if(gettime() < 10000 && !isdefined(level.var_440E))
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
		var_08 = self.a.var_3E10;
	}
	else
	{
		switch(self.a.var_78D0)
		{
			case "cover_crouch":
			case "none":
				if(self.a.var_60B1 == "stand")
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
		var_0A = self.var_6333;
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

	self.a.var_55EC = gettime() + randomintrange(1000,2000);
	if(isdefined(var_09))
	{
		if(!isdefined(self.var_58C2))
		{
			self.var_58C2 = self.grenadeawareness;
		}

		self.grenadeawareness = 0;
		var_0C = func_3A7D();
		func_7044(self.activegrenadetimer,min(gettime() + 3000,var_0C));
		var_0D = 0;
		if(func_87F5())
		{
			param_00.numgrenadesinprogresstowardsplayer++;
			thread func_641C(param_00);
			if(param_00.numgrenadesinprogresstowardsplayer > 1)
			{
				var_0D = 1;
			}

			if(self.activegrenadetimer.timername == "fraggrenade")
			{
				if(param_00.numgrenadesinprogresstowardsplayer <= 1)
				{
					param_00.lastfraggrenadetoplayerstart = gettime();
				}
			}
		}

		if(isdefined(param_06))
		{
			thread func_2944(var_07,var_09,var_0C,var_0D);
		}
		else
		{
			func_2944(var_07,var_09,var_0C,var_0D);
		}

		return 1;
	}
	else
	{
	}

	return 0;
}

//Function Number: 48
func_641C(param_00)
{
	self endon("dont_reduce_giptp_on_killanimscript");
	self waittill("killanimscript");
	param_00.numgrenadesinprogresstowardsplayer--;
}

//Function Number: 49
func_2944(param_00,param_01,param_02,param_03)
{
	self endon("killanimscript");
	if(self.script == "combat" || self.script == "move")
	{
		self orientmode("face direction",param_01);
	}

	animscripts/battlechatter_ai::func_2FE3(self.grenadeweapon);
	self notify("stop_aiming_at_enemy");
	self setflaggedanimknoballrestart("throwanim",param_00,%body,func_31EE(),0.1,1);
	thread animscripts/notetracks::donotetracksforever("throwanim","killanimscript");
	var_04 = animscripts/utility::func_3ABF();
	var_05 = "none";
	for(;;)
	{
		self waittill("throwanim",var_06);
		if(var_06 == "grenade_left" || var_06 == "grenade_right")
		{
			var_05 = attachgrenademodel(var_04,"TAG_INHAND");
			self.var_48D8 = 1;
		}

		if(var_06 == "grenade_throw" || var_06 == "grenade throw")
		{
			break;
		}

		if(var_06 == "end")
		{
			self.activegrenadetimer.player.numgrenadesinprogresstowardsplayer--;
			self notify("dont_reduce_giptp_on_killanimscript");
			return 0;
		}
	}

	self notify("dont_reduce_giptp_on_killanimscript");
	if(func_87F5())
	{
		thread func_8CF4(self.activegrenadetimer.player,param_02);
	}

	self throwgrenade();
	if(!func_87F5())
	{
		func_7044(self.activegrenadetimer,param_02);
	}

	if(param_03)
	{
		var_0D = self.activegrenadetimer.player;
		if(var_0D.numgrenadesinprogresstowardsplayer > 1 || gettime() - var_0D.lastgrenadelandednearplayertime < 2000)
		{
			var_0D.grenadetimers["double_grenade"] = gettime() + min(5000,var_0D.var_3DE2.var_5FA5);
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

	self.var_48D8 = undefined;
	self.grenadeawareness = self.var_58C2;
	self.var_58C2 = undefined;
	self waittillmatch("end","throwanim");
	self notify("done_grenade_throw");
	self notify("weapon_switch_done");
	self setanim(%exposed_modern,1,0.2);
	self setanim(%exposed_aiming,1);
	self clearanim(param_00,0.2);
}

//Function Number: 50
func_8CF4(param_00,param_01)
{
	param_00 endon("death");
	func_8CF5(param_01);
	param_00.numgrenadesinprogresstowardsplayer--;
}

//Function Number: 51
func_8CF5(param_00)
{
	var_01 = self.activegrenadetimer;
	var_02 = spawnstruct();
	var_02 thread func_8CF6(5);
	var_02 endon("watchGrenadeTowardsPlayerTimeout");
	var_03 = self.grenadeweapon;
	var_04 = func_3ABE();
	if(!isdefined(var_04))
	{
	}

	func_7044(var_01,min(gettime() + 5000,param_00));
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
					var_0B func_3DB2(var_01,param_00);
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
func_3DB2(param_00,param_01)
{
	var_02 = self;
	anim.var_80AD = undefined;
	if(gettime() - var_02.lastgrenadelandednearplayertime < 3000)
	{
		var_02.grenadetimers["double_grenade"] = gettime() + var_02.var_3DE2.var_5FA5;
	}

	var_02.lastgrenadelandednearplayertime = gettime();
	var_03 = var_02.grenadetimers[param_00.timername];
	var_02.grenadetimers[param_00.timername] = max(param_01,var_03);
}

//Function Number: 53
func_3ABE()
{
	self endon("killanimscript");
	self waittill("grenade_fire",var_00);
	return var_00;
}

//Function Number: 54
func_8CF6(param_00)
{
	wait(param_00);
	self notify("watchGrenadeTowardsPlayerTimeout");
}

//Function Number: 55
attachgrenademodel(param_00,param_01)
{
	self attach(param_00,param_01);
	thread func_26B9(param_00,param_01);
	return param_01;
}

//Function Number: 56
func_26B9(param_00,param_01)
{
	self endon("stop grenade check");
	self waittill("killanimscript");
	if(!isdefined(self))
	{
	}

	if(isdefined(self.var_58C2))
	{
		self.grenadeawareness = self.var_58C2;
		self.var_58C2 = undefined;
	}

	self detach(param_00,param_01);
}

//Function Number: 57
func_5870(param_00)
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
func_3DB3(param_00,param_01)
{
	level notify("armoffset");
	level endon("armoffset");
	param_00 = self.origin + func_5870(param_00);
	wait(0.05);
}

//Function Number: 59
func_3ABD()
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
func_2B4E()
{
	var_00 = self gettagorigin("tag_inhand");
	var_01 = func_3ABD();
	self magicgrenademanual(var_00,var_01,3);
}

//Function Number: 61
func_4F55()
{
	if(!isdefined(self.enemy))
	{
		return 0;
	}

	if(self.fixednode || self.doingambush)
	{
		return 0;
	}

	var_00 = func_3A39();
	if(isdefined(var_00))
	{
		return func_87AA(var_00);
	}

	return 0;
}

//Function Number: 62
func_3A39()
{
	var_00 = self findbestcovernode();
	if(!isdefined(var_00))
	{
		return undefined;
	}

	var_01 = animscripts/utility::func_3A52();
	if(isdefined(var_01) && var_00 == var_01)
	{
		return undefined;
	}

	if(isdefined(self.var_1FCA) && var_00 == self.var_1FCA)
	{
		return undefined;
	}

	return var_00;
}

//Function Number: 63
func_87AA(param_00)
{
	var_01 = self.keepclaimednodeifvalid;
	var_02 = self.keepclaimednode;
	self.keepclaimednodeifvalid = 0;
	self.keepclaimednode = 0;
	if(self usecovernode(param_00))
	{
		return 1;
	}
	else
	{
	}

	self.keepclaimednodeifvalid = var_01;
	self.keepclaimednode = var_02;
	return 0;
}

//Function Number: 64
shouldhelpadvancingteammate()
{
	if(level.advancetoenemygroup[self.team] > 0 && level.advancetoenemygroup[self.team] < level.advancetoenemygroupmax)
	{
		if(gettime() - level.var_4C39[self.team] > 4000)
		{
			return 0;
		}

		var_00 = level.lastadvancetoenemyattacker[self.team];
		if(var_00 == self)
		{
			return 0;
		}

		var_01 = isdefined(var_00) && distancesquared(self.origin,var_00.origin) < 65536;
		if((var_01 || distancesquared(self.origin,level.lastadvancetoenemysrc[self.team]) < 65536) && !isdefined(self.enemy) || distancesquared(self.enemy.origin,level.lastadvancetoenemydest[self.team]) < 262144)
		{
			return 1;
		}
	}

	return 0;
}

//Function Number: 65
checkadvanceonenemyconditions()
{
	if(!isdefined(level.var_4C39[self.team]))
	{
		return 0;
	}

	if(shouldhelpadvancingteammate())
	{
		return 1;
	}

	if(gettime() - level.var_4C39[self.team] < level.advancetoenemyinterval)
	{
		return 0;
	}

	if(!issentient(self.enemy))
	{
		return 0;
	}

	if(level.advancetoenemygroup[self.team])
	{
		level.advancetoenemygroup[self.team] = 0;
	}

	var_00 = isdefined(self.advance_regardless_of_numbers) && self.advance_regardless_of_numbers;
	if(!var_00 && getaicount(self.team) < getaicount(self.enemy.team))
	{
		return 0;
	}

	return 1;
}

//Function Number: 66
func_8405(param_00)
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

	if(islongrangeai())
	{
		return 0;
	}

	if(!checkadvanceonenemyconditions())
	{
		return 0;
	}

	self findreacquiredirectpath(param_00);
	if(self reacquiremove())
	{
		self.keepclaimednodeifvalid = 0;
		self.keepclaimednode = 0;
		self.a.var_4FDC = 1;
		if(level.advancetoenemygroup[self.team] == 0)
		{
			level.var_4C39[self.team] = gettime();
			level.lastadvancetoenemyattacker[self.team] = self;
		}

		level.lastadvancetoenemysrc[self.team] = self.origin;
		level.lastadvancetoenemydest[self.team] = self.enemy.origin;
		level.advancetoenemygroup[self.team]++;
		return 1;
	}

	return 0;
}

//Function Number: 67
delayedbadplace(param_00)
{
	self endon("death");
	wait(0.5);
	var_01 = "" + level.badplaceint;
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

	level.badplaceint++;
	if(level.badplaceint > 10)
	{
		anim.badplaceint = level.badplaceint - 20;
	}
}

//Function Number: 68
func_881E(param_00,param_01,param_02)
{
	if(param_00 > param_01 && param_00 < param_02)
	{
		return 1;
	}

	return 0;
}

//Function Number: 69
func_3AC3()
{
	if(!isdefined(self.var_7445))
	{
		return 0;
	}

	var_00 = self getmuzzleangle()[1] - animscripts/utility::func_3C87(self.var_7445);
	var_00 = angleclamp180(var_00);
	return var_00;
}

//Function Number: 70
getgunpitchtoshootentorpos()
{
	if(!isdefined(self.var_7445))
	{
		return 0;
	}

	var_00 = self getmuzzleangle()[0] - vectortoangles(self.var_7445 - self getmuzzlepos())[0];
	var_00 = angleclamp180(var_00);
	return var_00;
}

//Function Number: 71
getpitchtoenemy()
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
func_3B91(param_00)
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
func_3B8F(param_00,param_01)
{
	if(!isdefined(param_00) || !isdefined(param_01))
	{
		return 0;
	}

	if(isdefined(self) && animscripts/utility::func_4965())
	{
		var_02 = anglestoforward(self.angles);
		var_03 = rotatepointaroundvector(var_02,param_00 - self.origin,self.angles[2] * -1);
		param_00 = var_03 + self.origin;
	}

	var_04 = param_00 - param_01;
	var_04 = vectornormalize(var_04);
	var_05 = 360 - vectortoangles(var_04)[0];
	return angleclamp180(var_05);
}

//Function Number: 74
func_8D14()
{
	self.isreloading = 0;
	self.var_4C93 = -1;
	for(;;)
	{
		self waittill("reload_start");
		self.isreloading = 1;
		self.var_4C93 = gettime();
		func_8BBF();
		self.isreloading = 0;
	}
}

//Function Number: 75
func_8BBF()
{
	thread func_811B(4,"reloadtimeout");
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

//Function Number: 76
func_811B(param_00,param_01)
{
	self endon(param_01);
	wait(param_00);
	self notify(param_01);
}

//Function Number: 77
checkgrenadethrowdist()
{
	var_00 = self.enemy.origin - self.origin;
	var_01 = lengthsquared((var_00[0],var_00[1],0));
	if(self.grenadeweapon == "flash_grenade")
	{
		return var_01 < 589824;
	}

	return var_01 >= -25536 && var_01 <= 1562500;
}

//Function Number: 78
func_538C()
{
	self endon("death");
	if(!isdefined(level.var_55AA))
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

		if(isdefined(self.var_6C01) && self.var_6C01 != 0)
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

		self.var_3405 = var_04;
		maps\_utility::flashbangstart(var_06);
		self notify("doFlashBanged",var_01,var_03);
	}
}

//Function Number: 79
isshotgunai()
{
	return animscripts/utility::isshotgun(self.primaryweapon);
}

//Function Number: 80
issniper()
{
	return animscripts/utility::issniperrifle(self.primaryweapon);
}

//Function Number: 81
islongrangeai()
{
	return issniper() || animscripts/utility::func_87FA();
}

//Function Number: 82
func_31EE()
{
	return 1.5;
}

//Function Number: 83
func_6332()
{
	return randomfloatrange(1,1.2);
}

//Function Number: 84
func_3BB6(param_00)
{
	if(param_00.size == 0)
	{
		return undefined;
	}

	if(param_00.size == 1)
	{
		return param_00[0];
	}

	if(isdefined(self.a.prevattack) && randomint(100) > 20)
	{
		foreach(var_03, var_02 in param_00)
		{
			if(var_02 == self.a.prevattack)
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

//Function Number: 85
func_5EFE()
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

		if(common_scripts\utility::func_1DE9() && var_08 >= 0.996)
		{
			continue;
		}

		return 1;
	}

	return 0;
}