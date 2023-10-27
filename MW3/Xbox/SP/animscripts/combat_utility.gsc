/*******************************************************************
 * Decompiled By: Bog
 * Decompiled File: animscripts\combat_utility.gsc
 * Game: Call of Duty: Modern Warfare 3
 * Platform: Console
 * Function Count: 84
 * Decompile Time: 1409 ms
 * Timestamp: 10/27/2023 2:30:04 AM
*******************************************************************/

//Function Number: 1
gettargetangleoffset(param_00)
{
	var_01 = self getshootatpos() + (0,0,-3);
	var_02 = (var_01[0] - param_00[0],var_01[1] - param_00[1],var_01[2] - param_00[2]);
	var_02 = vectornormalize(var_02);
	var_03 = var_02[2] * -1;
	return var_03;
}

//Function Number: 2
getsniperburstdelaytime()
{
	if(isplayer(self.enemy))
	{
		return randomfloatrange(self.enemy.var_1C74.min_sniper_burst_delay_time,self.enemy.var_1C74.max_sniper_burst_delay_time);
	}

	return randomfloatrange(level.min_sniper_burst_delay_time,level.max_sniper_burst_delay_time);
}

//Function Number: 3
func_1EF7()
{
	var_00 = gettime() - self.a.lastshoottime / 1000;
	var_01 = getburstdelaytime();
	if(var_01 > var_00)
	{
		return var_01 - var_00;
	}

	return 0;
}

//Function Number: 4
getburstdelaytime()
{
	if(animscripts/utility::usingsidearm())
	{
		return randomfloatrange(0.15,0.55);
	}

	if(animscripts/utility::weapon_pump_action_shotgun())
	{
		return randomfloatrange(1,1.7);
	}

	if(issniper())
	{
		return getsniperburstdelaytime();
	}

	if(self.fastburst)
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
		if(self.shootstyle == "full" && !self.fastburst)
		{
			if(self.a.lastshoottime == gettime())
			{
				wait 0.05;
			}

			return;
		}

		var_00 = func_1EF7();
		if(var_00)
		{
			wait var_00;
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

	if(animscripts/utility::usingsidearm() || animscripts/utility::usingrocketlauncher())
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
		if(isdefined(self.dontevershoot) || isdefined(self.enemy) && isdefined(self.enemy.dontattackme))
		{
			wait 0.05;
			continue;
		}

		return 0;
	}

	return 1;
}

//Function Number: 8
shootuntilshootbehaviorchange()
{
	self endon("shoot_behavior_change");
	self endon("stopShooting");
	if(islongrangeai())
	{
		if(isdefined(self.enemy) && isai(self.enemy) && distancesquared(level.player.origin,self.enemy.origin) < 147456)
		{
			self.enemy animscripts/battlechatter_ai::addthreatevent("infantry",self,1);
		}

		if(animscripts/utility::usingrocketlauncher() && issentient(self.enemy))
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
		burstdelay();
		if(aimbutdontshoot())
		{
			break;
		}

		if(self.shootstyle == "full")
		{
			fireuntiloutofammo(animscripts/utility::animarray("fire"),1,animscripts/shared::func_1EFB());
		}
		else if(self.shootstyle == "burst" || self.shootstyle == "semi")
		{
			var_01 = animscripts/shared::decidenumshotsforburst();
			if(var_01 == 1)
			{
				fireuntiloutofammo(animscripts/utility::animarraypickrandom("single"),1,var_01);
			}
			else
			{
				fireuntiloutofammo(animscripts/utility::animarray(self.shootstyle + var_01),1,var_01);
			}
		}
		else if(self.shootstyle == "single")
		{
			fireuntiloutofammo(animscripts/utility::animarraypickrandom("single"),1,1);
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
	level.var_1C4B++;
	return level.var_1C4B;
}

//Function Number: 10
setupaim(param_00)
{
	self setanim(%exposed_aiming,1,0.2);
	self setanimknoblimited(animscripts/utility::animarray("straight_level"),1,param_00);
	self setanimknoblimited(animscripts/utility::animarray("add_aim_up"),1,param_00);
	self setanimknoblimited(animscripts/utility::animarray("add_aim_down"),1,param_00);
	self setanimknoblimited(animscripts/utility::animarray("add_aim_left"),1,param_00);
	self setanimknoblimited(animscripts/utility::animarray("add_aim_right"),1,param_00);
}

//Function Number: 11
startfireandaimidlethread()
{
	if(!isdefined(self.a.aimidlethread))
	{
		setupaim(0.2);
		thread aimidlethread();
		thread animscripts/track::trackshootentorpos();
	}
}

//Function Number: 12
endfireandanimidlethread()
{
	endaimidlethread();
	self clearanim(%add_fire,0.1);
	self notify("stop tracking");
}

//Function Number: 13
func_1EFD()
{
	if(isdefined(self.a.aimidlethread))
	{
		self setanim(%add_idle,0,0.2);
	}

	self setanim(%add_fire,1,0.1);
}

//Function Number: 14
hidefireshowaimidle()
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
		if(isdefined(self.a.var_1EFE))
		{
			var_03 = animscripts/utility::animarraypickrandom("lean_idle");
		}
		else
		{
			var_03 = animscripts/utility::animarraypickrandom("exposed_idle");
		}

		self setflaggedanimknoblimitedrestart(var_02,var_03,1,0.2);
		self waittillmatch("end",var_02);
		var_01++;
	}

	self clearanim(%add_idle,0.1);
}

//Function Number: 16
endaimidlethread()
{
	self notify("end_aim_idle_thread");
	self.a.aimidlethread = undefined;
	self clearanim(%add_idle,0.1);
}

//Function Number: 17
func_1EFF()
{
	if(animscripts/utility::weapon_pump_action_shotgun())
	{
		return 1;
	}

	if(animscripts/weaponlist::usingautomaticweapon())
	{
		return animscripts/weaponlist::autoshootanimrate() * 0.7;
	}

	return 0.4;
}

//Function Number: 18
fireuntiloutofammo(param_00,param_01,param_02)
{
	var_03 = "fireAnim_" + getuniqueflagnameindex();
	maps\_gameskill::resetmisstime();
	while(!func_0CCF())
	{
		wait 0.05;
	}

	func_1EFD();
	var_04 = 1;
	if(isdefined(self.shootrateoverride))
	{
		var_04 = self.shootrateoverride;
	}
	else if(self.shootstyle == "full")
	{
		var_04 = animscripts/weaponlist::autoshootanimrate() * randomfloatrange(0.5,1);
	}
	else if(self.shootstyle == "burst")
	{
		var_04 = animscripts/weaponlist::burstshootanimrate();
	}
	else if(animscripts/utility::usingsidearm())
	{
		var_04 = 3;
	}
	else if(animscripts/utility::func_1F02())
	{
		var_04 = func_1EFF();
	}

	self setflaggedanimknobrestart(var_03,param_00,1,0.2,var_04);
	self updateplayersightaccuracy();
	if(!isdefined(self.var_8099))
	{
		self.var_8099 = 0;
	}

	self.var_8099++;
	fireuntiloutofammointernal(var_03,param_00,param_01,param_02);
	self.var_8099 = 0;
	hidefireshowaimidle();
}

//Function Number: 19
fireuntiloutofammointernal(param_00,param_01,param_02,param_03)
{
	self endon("enemy");
	if(isplayer(self.enemy) && self.shootstyle == "full" || self.shootstyle == "semi")
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

		if(!func_0CCF())
		{
			break;
		}

		shootatshootentorpos();
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
				self.a.rocketvisible = 0;
			}
		}

		var_04++;
		thread shotgunpumpsound(param_00);
		if(self.fastburst && var_04 == param_03)
		{
			break;
		}

		if(!var_05 || param_03 == 1 && self.shootstyle == "single")
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
func_0CCF()
{
	if(!isdefined(self.shootpos))
	{
		return 1;
	}

	var_00 = self getmuzzleangle();
	var_01 = animscripts/shared::func_89B();
	var_02 = vectortoangles(self.shootpos - var_01);
	var_03 = animscripts/utility::absangleclamp180(var_00[1] - var_02[1]);
	if(var_03 > level.aimyawdifffartolerance)
	{
		if(distancesquared(self geteye(),self.shootpos) > level.aimyawdiffclosedistsq || var_03 > level.aimyawdiffclosetolerance)
		{
			return 0;
		}
	}

	return animscripts/utility::absangleclamp180(var_00[0] - var_02[0]) <= level.aimpitchdifftolerance;
}

//Function Number: 21
notifyonanimend(param_00,param_01)
{
	self endon("killanimscript");
	self endon(param_01);
	self waittillmatch("end",param_00);
	self notify(param_01);
}

//Function Number: 22
shootatshootentorpos()
{
	if(isdefined(self.shootent))
	{
		if(isdefined(self.enemy) && self.shootent == self.enemy)
		{
			animscripts/utility::shootenemywrapper();
		}
	}
	else
	{
		animscripts/utility::shootposwrapper(self.shootpos);
	}
}

//Function Number: 23
showrocket()
{
	if(self.weapon != "rpg")
	{
		return;
	}

	self.a.rocketvisible = 1;
	self showpart("tag_rocket");
	self notify("showing_rocket");
}

//Function Number: 24
showrocketwhenreloadisdone()
{
	if(self.weapon != "rpg")
	{
		return;
	}

	self endon("death");
	self endon("showing_rocket");
	self waittill("killanimscript");
	showrocket();
}

//Function Number: 25
decrementbulletsinclip()
{
	if(self.bulletsinclip)
	{
		self.bulletsinclip--;
	}
}

//Function Number: 26
shotgunpumpsound(param_00)
{
	if(!animscripts/utility::weapon_pump_action_shotgun())
	{
		return;
	}

	self endon("killanimscript");
	self notify("shotgun_pump_sound_end");
	self endon("shotgun_pump_sound_end");
	thread stopshotgunpumpaftertime(2);
	self waittillmatch("rechamber",param_00);
	self playsound("ai_shotgun_pump");
	self notify("shotgun_pump_sound_end");
}

//Function Number: 27
stopshotgunpumpaftertime(param_00)
{
	self endon("killanimscript");
	self endon("shotgun_pump_sound_end");
	wait param_00;
	self notify("shotgun_pump_sound_end");
}

//Function Number: 28
rechamber(param_00)
{
}

//Function Number: 29
needtoreload(param_00)
{
	if(self.weapon == "none")
	{
		return 0;
	}

	if(isdefined(self.var_1F0C))
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
func_0D3E()
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
	if(!needtoreload(param_00))
	{
		return 0;
	}

	animscripts/battlechatter_ai::evaluatereloadevent();
	animscripts/battlechatter::playbattlechatter();
	if(isdefined(param_01))
	{
		self setflaggedanimknoball("reloadanim",param_01,%body,1,0.1,1);
		animscripts/shared::donotetracks("reloadanim");
		animscripts/weaponlist::refillclip();
		self.a.needstorechamber = 0;
	}
	else
	{
		if(self.a.var_911 == "prone")
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
		animscripts/weaponlist::refillclip();
		self.a.needstorechamber = 0;
	}

	return 1;
}

//Function Number: 32
addgrenadethrowanimoffset(param_00,param_01)
{
	if(!isdefined(level.grenadethrowanims))
	{
		anim.grenadethrowanims = [];
		anim.grenadethrowoffsets = [];
	}

	var_02 = level.grenadethrowanims.size;
	level.grenadethrowanims[var_02] = param_00;
	level.grenadethrowoffsets[var_02] = param_01;
}

//Function Number: 33
initgrenadethrowanims()
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
getgrenadethrowoffset(param_00)
{
	var_01 = (0,0,64);
	if(isdefined(param_00))
	{
		foreach(var_04, var_03 in level.grenadethrowanims)
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
throwgrenadeatplayerasap_combat_utility()
{
	for(var_00 = 0;var_00 < level.players.size;var_00++)
	{
		if(level.players[var_00].var_1C66 == 0)
		{
			level.players[var_00].grenadetimers["fraggrenade"] = 0;
			level.players[var_00].grenadetimers["flash_grenade"] = 0;
		}
	}

	anim.throwgrenadeatplayerasap = 1;
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
		return;
	}

	self.activegrenadetimer.isplayertimer = 0;
	self.activegrenadetimer.timername = "AI_" + self.grenadeweapon;
}

//Function Number: 37
usingplayergrenadetimer()
{
	return self.activegrenadetimer.isplayertimer;
}

//Function Number: 38
func_1F15(param_00,param_01)
{
	if(param_00.isplayertimer)
	{
		var_02 = param_00.player;
		var_03 = var_02.grenadetimers[param_00.timername];
		var_02.grenadetimers[param_00.timername] = max(param_01,var_03);
		return;
	}

	var_03 = level.grenadetimers[param_01.timername];
	level.grenadetimers[param_00.timername] = max(param_01,var_03);
}

//Function Number: 39
getdesiredgrenadetimervalue()
{
	var_00 = undefined;
	if(usingplayergrenadetimer())
	{
		var_01 = self.activegrenadetimer.player;
		var_00 = gettime() + var_01.var_1C74.playergrenadebasetime + randomint(var_01.var_1C74.var_1C75);
	}
	else
	{
		var_00 = gettime() + 30000 + randomint(30000);
	}

	return var_00;
}

//Function Number: 40
func_1F17(param_00)
{
	if(param_00.isplayertimer)
	{
		return param_00.player.grenadetimers[param_00.timername];
	}

	return level.grenadetimers[param_00.timername];
}

//Function Number: 41
func_1F18(param_00)
{
	if(!isplayer(param_00) && self isbadguy())
	{
		if(gettime() < func_1F17(self.activegrenadetimer))
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
				if(isdefined(self.covernode))
				{
					var_03 = vectortoangles(level.player.origin - self.origin);
					var_04 = angleclamp180(self.covernode.angles[1] - var_03[1]);
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
func_1F19(param_00)
{
	if(maps\_utility::func_1F1A())
	{
		return 0;
	}

	if(!param_00.var_1C74.double_grenades_allowed)
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

	return param_00.var_1C66 < 2;
}

//Function Number: 43
func_0D23()
{
	return gettime() >= self.a.nextgrenadetrytime;
}

//Function Number: 44
grenadecooldownelapsed(param_00)
{
	if(maps\_utility::func_1F1A())
	{
		return 0;
	}

	if(self.script_forcegrenade == 1)
	{
		return 1;
	}

	if(!func_0D23())
	{
		return 0;
	}

	if(gettime() >= func_1F17(self.activegrenadetimer))
	{
		return 1;
	}

	if(self.activegrenadetimer.isplayertimer && self.activegrenadetimer.timername == "fraggrenade")
	{
		return func_1F19(param_00);
	}

	return 0;
}

//Function Number: 45
trygrenadeposproc(param_00,param_01,param_02,param_03)
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
	return trygrenadethrow(param_00,var_04,param_02,param_03);
}

//Function Number: 46
trygrenade(param_00,param_01)
{
	if(self.weapon == "mg42" || self.grenadeammo <= 0)
	{
		return 0;
	}

	setactivegrenadetimer(param_00);
	param_00 = func_1F18(param_00);
	if(!grenadecooldownelapsed(param_00))
	{
		return 0;
	}

	var_02 = getgrenadethrowoffset(param_01);
	if(isdefined(self.enemy) && param_00 == self.enemy)
	{
		if(!checkgrenadethrowdist())
		{
			return 0;
		}

		if(isplayer(self.enemy) && maps\_utility::is_player_down(self.enemy))
		{
			return 0;
		}

		if(animscripts/utility::func_B35())
		{
			if(!self isgrenadepossafe(param_00,param_00.origin))
			{
				return 0;
			}

			return trygrenadethrow(param_00,undefined,param_01,var_02);
		}
		else if(animscripts/utility::cansuppressenemyfromexposed())
		{
			return trygrenadeposproc(param_00,animscripts/utility::getenemysightpos(),param_01,var_02);
		}
		else
		{
			if(!self isgrenadepossafe(param_00,param_00.origin))
			{
				return 0;
			}

			return trygrenadethrow(param_00,undefined,param_01,var_02);
		}

		return 0;
	}

	return trygrenadeposproc(param_00,param_00.origin,param_01,var_02);
}

//Function Number: 47
trygrenadethrow(param_00,param_01,param_02,param_03,param_04,param_05,param_06)
{
	if(gettime() < 10000 && !isdefined(level.ignoregrenadesafetime))
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
		var_08 = self.a.gunhand;
	}
	else
	{
		switch(self.a.special)
		{
			case "cover_crouch":
			case "none":
				if(self.a.var_911 == "stand")
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
		var_0A = self.var_1C38;
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

	self.a.nextgrenadetrytime = gettime() + randomintrange(1000,2000);
	if(isdefined(var_09))
	{
		if(!isdefined(self.oldgrenawareness))
		{
			self.oldgrenawareness = self.grenadeawareness;
		}

		self.grenadeawareness = 0;
		var_0C = getdesiredgrenadetimervalue();
		func_1F15(self.activegrenadetimer,min(gettime() + 3000,var_0C));
		var_0D = 0;
		if(usingplayergrenadetimer())
		{
			param_00.var_1C66++;
			thread func_1F1E(param_00);
			if(param_00.var_1C66 > 1)
			{
				var_0D = 1;
			}

			if(self.activegrenadetimer.timername == "fraggrenade")
			{
				if(param_00.var_1C66 <= 1)
				{
					param_00.lastfraggrenadetoplayerstart = gettime();
				}
			}
		}

		if(isdefined(param_06))
		{
			thread dogrenadethrow(var_07,var_09,var_0C,var_0D);
		}
		else
		{
			dogrenadethrow(var_07,var_09,var_0C,var_0D);
		}

		return 1;
	}
	else
	{
	}

	return 0;
}

//Function Number: 48
func_1F1E(param_00)
{
	self endon("dont_reduce_giptp_on_killanimscript");
	self waittill("killanimscript");
	param_00.var_1C66--;
}

//Function Number: 49
dogrenadethrow(param_00,param_01,param_02,param_03)
{
	self endon("killanimscript");
	if(self.script == "combat" || self.script == "move")
	{
		self orientmode("face direction",param_01);
	}

	animscripts/battlechatter_ai::evaluateattackevent(self.grenadeweapon);
	self notify("stop_aiming_at_enemy");
	self setflaggedanimknoballrestart("throwanim",param_00,%body,fasteranimspeed(),0.1,1);
	thread animscripts/notetracks::donotetracksforever("throwanim","killanimscript");
	var_04 = animscripts/utility::getgrenademodel();
	var_05 = "none";
	for(;;)
	{
		self waittill("throwanim",var_06);
		if(var_06 == "grenade_left" || var_06 == "grenade_right")
		{
			var_05 = func_1F28(var_04,"TAG_INHAND");
			self.isholdinggrenade = 1;
		}

		if(var_06 == "grenade_throw" || var_06 == "grenade throw")
		{
			break;
		}

		if(var_06 == "end")
		{
			self.activegrenadetimer.player.var_1C66--;
			self notify("dont_reduce_giptp_on_killanimscript");
			return 0;
		}
	}

	self notify("dont_reduce_giptp_on_killanimscript");
	if(usingplayergrenadetimer())
	{
		thread func_1F23(self.activegrenadetimer.player,param_02);
	}

	self throwgrenade();
	if(!usingplayergrenadetimer())
	{
		func_1F15(self.activegrenadetimer,param_02);
	}

	if(param_03)
	{
		var_0D = self.activegrenadetimer.player;
		if(var_0D.var_1C66 > 1 || gettime() - var_0D.lastgrenadelandednearplayertime < 2000)
		{
			var_0D.grenadetimers["double_grenade"] = gettime() + min(5000,var_0D.var_1C74.var_1C76);
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

	self.isholdinggrenade = undefined;
	self.grenadeawareness = self.oldgrenawareness;
	self.oldgrenawareness = undefined;
	self waittillmatch("end","throwanim");
	self notify("done_grenade_throw");
	self notify("weapon_switch_done");
	self setanim(%exposed_modern,1,0.2);
	self setanim(%exposed_aiming,1);
	self clearanim(param_00,0.2);
}

//Function Number: 50
func_1F23(param_00,param_01)
{
	param_00 endon("death");
	func_1F24(param_01);
	param_00.var_1C66--;
}

//Function Number: 51
func_1F24(param_00)
{
	var_01 = self.activegrenadetimer;
	var_02 = spawnstruct();
	var_02 thread func_1F27(5);
	var_02 endon("watchGrenadeTowardsPlayerTimeout");
	var_03 = self.grenadeweapon;
	var_04 = func_1F26();
	if(!isdefined(var_04))
	{
		return;
	}

	func_1F15(var_01,min(gettime() + 5000,param_00));
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
					var_0B grenadelandednearplayer(var_01,param_00);
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
grenadelandednearplayer(param_00,param_01)
{
	var_02 = self;
	anim.throwgrenadeatplayerasap = undefined;
	if(gettime() - var_02.lastgrenadelandednearplayertime < 3000)
	{
		var_02.grenadetimers["double_grenade"] = gettime() + var_02.var_1C74.var_1C76;
	}

	var_02.lastgrenadelandednearplayertime = gettime();
	var_03 = var_02.grenadetimers[param_00.timername];
	var_02.grenadetimers[param_00.timername] = max(param_01,var_03);
}

//Function Number: 53
func_1F26()
{
	self endon("killanimscript");
	self waittill("grenade_fire",var_00);
	return var_00;
}

//Function Number: 54
func_1F27(param_00)
{
	wait param_00;
	self notify("watchGrenadeTowardsPlayerTimeout");
}

//Function Number: 55
func_1F28(param_00,param_01)
{
	self attach(param_00,param_01);
	thread detachgrenadeonscriptchange(param_00,param_01);
	return param_01;
}

//Function Number: 56
detachgrenadeonscriptchange(param_00,param_01)
{
	self endon("stop grenade check");
	self waittill("killanimscript");
	if(!isdefined(self))
	{
		return;
	}

	if(isdefined(self.oldgrenawareness))
	{
		self.grenadeawareness = self.oldgrenawareness;
		self.oldgrenawareness = undefined;
	}

	self detach(param_00,param_01);
}

//Function Number: 57
offsettoorigin(param_00)
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
grenadeline(param_00,param_01)
{
	level notify("armoffset");
	level endon("armoffset");
	param_00 = self.origin + offsettoorigin(param_00);
	wait 0.05;
}

//Function Number: 59
getgrenadedropvelocity()
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
func_1F2C()
{
	var_00 = self gettagorigin("tag_inhand");
	var_01 = getgrenadedropvelocity();
	self magicgrenademanual(var_00,var_01,3);
}

//Function Number: 61
func_0B26()
{
	if(!isdefined(self.enemy))
	{
		return 0;
	}

	if(self.fixednode || self.doingambush)
	{
		return 0;
	}

	var_00 = func_1F2D();
	if(isdefined(var_00))
	{
		return usecovernodeifpossible(var_00);
	}

	return 0;
}

//Function Number: 62
func_1F2D()
{
	var_00 = self findbestcovernode();
	if(!isdefined(var_00))
	{
		return undefined;
	}

	var_01 = animscripts/utility::getclaimednode();
	if(isdefined(var_01) && var_00 == var_01)
	{
		return undefined;
	}

	if(isdefined(self.covernode) && var_00 == self.covernode)
	{
		return undefined;
	}

	return var_00;
}

//Function Number: 63
usecovernodeifpossible(param_00)
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
	if(level.var_1C6F[self.team] > 0 && level.var_1C6F[self.team] < level.advancetoenemygroupmax)
	{
		if(gettime() - level.var_1C6B[self.team] > 4000)
		{
			return 0;
		}

		var_00 = level.lastadvancetoenemyattacker[self.team];
		var_01 = isdefined(var_00) && distancesquared(self.origin,var_00.origin) < 65536;
		if((var_01 || distancesquared(self.origin,level.lastadvancetoenemysrc[self.team]) < 65536) && !isdefined(self.enemy) || distancesquared(self.enemy.origin,level.var_1C6C[self.team]) < 262144)
		{
			return 1;
		}
	}

	return 0;
}

//Function Number: 65
checkadvanceonenemyconditions()
{
	if(!isdefined(level.var_1C6B[self.team]))
	{
		return 0;
	}

	if(shouldhelpadvancingteammate())
	{
		return 1;
	}

	if(gettime() - level.var_1C6B[self.team] < level.advancetoenemyinterval)
	{
		return 0;
	}

	if(!issentient(self.enemy))
	{
		return 0;
	}

	if(level.var_1C6F[self.team])
	{
		level.var_1C6F[self.team] = 0;
	}

	var_00 = isdefined(self.var_3F1C) && self.var_3F1C;
	if(!var_00 && getaicount(self.team) < getaicount(self.enemy.team))
	{
		return 0;
	}

	return 1;
}

//Function Number: 66
tryrunningtoenemy(param_00)
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
		self.a.magicreloadwhenreachenemy = 1;
		if(level.var_1C6F[self.team] == 0)
		{
			level.var_1C6B[self.team] = gettime();
			level.lastadvancetoenemyattacker[self.team] = self;
		}

		level.lastadvancetoenemysrc[self.team] = self.origin;
		level.var_1C6C[self.team] = self.enemy.origin;
		level.var_1C6F[self.team]++;
		return 1;
	}

	return 0;
}

//Function Number: 67
func_1F30(param_00)
{
	self endon("death");
	wait 0.5;
	var_01 = "" + level.var_1C5F;
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

	level.var_1C5F++;
	if(level.var_1C5F > 10)
	{
		anim.var_1C5F = level.var_1C5F - 20;
	}
}

//Function Number: 68
func_1F31(param_00,param_01,param_02)
{
	if(param_00 > param_01 && param_00 < param_02)
	{
		return 1;
	}

	return 0;
}

//Function Number: 69
getgunyawtoshootentorpos()
{
	if(!isdefined(self.shootpos))
	{
		return 0;
	}

	var_00 = self getmuzzleangle()[1] - animscripts/utility::func_C05(self.shootpos);
	var_00 = angleclamp180(var_00);
	return var_00;
}

//Function Number: 70
func_1F33()
{
	if(!isdefined(self.shootpos))
	{
		return 0;
	}

	var_00 = self getmuzzleangle()[0] - vectortoangles(self.shootpos - self getmuzzlepos())[0];
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
getpitchtospot(param_00)
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
watchreloading()
{
	self.isreloading = 0;
	self.var_1F36 = -1;
	for(;;)
	{
		self waittill("reload_start");
		self.isreloading = 1;
		self.var_1F36 = gettime();
		waittillreloadfinished();
		self.isreloading = 0;
	}
}

//Function Number: 74
waittillreloadfinished()
{
	thread func_1F38(4,"reloadtimeout");
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
func_1F38(param_00,param_01)
{
	self endon(param_01);
	wait param_00;
	self notify(param_01);
}

//Function Number: 76
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

//Function Number: 77
monitorflash()
{
	self endon("death");
	if(!isdefined(level.neverstopmonitoringflash))
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

		if(isdefined(self.script_immunetoflash) && self.script_immunetoflash != 0)
		{
			continue;
		}

		if(isdefined(self.var_89E) || isdefined(self.onatv))
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

			if(isdefined(self.var_C76))
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
		maps\_utility::func_1F3D(var_06);
		self notify("doFlashBanged",var_01,var_03);
	}
}

//Function Number: 78
func_1F3E()
{
	return animscripts/utility::isshotgun(self.primaryweapon);
}

//Function Number: 79
issniper()
{
	return animscripts/utility::issniperrifle(self.primaryweapon);
}

//Function Number: 80
islongrangeai()
{
	return issniper() || animscripts/utility::usingrocketlauncher();
}

//Function Number: 81
fasteranimspeed()
{
	return 1.5;
}

//Function Number: 82
randomfasteranimspeed()
{
	return randomfloatrange(1,1.2);
}

//Function Number: 83
getrandomcovermode(param_00)
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

//Function Number: 84
player_sees_my_scope()
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