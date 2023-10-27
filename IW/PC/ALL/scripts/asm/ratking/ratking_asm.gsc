/*******************************************************************
 * Decompiled By: Bog
 * Decompiled File: scripts\asm\ratking\ratking_asm.gsc
 * Game: Call of Duty: Infinite Warfare
 * Platform: PC
 * Function Count: 58
 * Decompile Time: 2988 ms
 * Timestamp: 10/27/2023 12:02:07 AM
*******************************************************************/

//Function Number: 1
ratkinginit(param_00,param_01,param_02,param_03)
{
	lib_0C75::func_13F9A(param_00,param_01,param_02,param_03);
	self.var_71D0 = ::scripts\mp\agents\ratking\ratking_agent::shouldratkingplaypainanim;
	self.var_1198.requestedshieldstate = "equipped";
	self.var_2303.shieldstate = "equipped";
}

//Function Number: 2
isvalidaction(param_00)
{
	switch(param_00)
	{
		case "shield_throw":
		case "shield_throw_at_spot":
		case "teleport":
		case "staff_projectile":
		case "block":
		case "summon":
		case "staff_stomp":
		case "melee_attack":
			return 1;
	}

	return 0;
}

//Function Number: 3
setaction(param_00)
{
	self.requested_action = param_00;
}

//Function Number: 4
clearaction()
{
	self.requested_action = undefined;
}

//Function Number: 5
shouldendblock(param_00,param_01,param_02,param_03)
{
	if(!isdefined(self.requested_action) || self.requested_action != "block")
	{
		return 1;
	}

	return 0;
}

//Function Number: 6
shouldplayentranceanim(param_00,param_01,param_02,param_03)
{
	return 1;
}

//Function Number: 7
playanimandlookatenemy(param_00,param_01,param_02,param_03)
{
	thread lib_0C73::func_6A6A(param_01,scripts\mp\agents\ratking\ratking_agent::getenemy());
	var_04 = lib_0A1D::func_2337(param_00,param_01);
	lib_0A1D::func_2365(param_00,param_01,param_02,var_04,1);
}

//Function Number: 8
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

//Function Number: 9
playtauntanim(param_00,param_01,param_02,param_03)
{
	self notify("taunt");
	thread lib_0C73::func_6A6A(param_01,scripts\mp\agents\ratking\ratking_agent::getenemy());
	lib_0A1D::func_2364(param_00,param_01,param_02,param_03);
}

//Function Number: 10
dosummonspawn()
{
	var_00 = scripts\mp\agents\ratking\ratking_tunedata::gettunedata();
	foreach(var_02 in self.var_108FB)
	{
		var_03 = scripts\cp\zombies\zombies_spawning::func_13F53(var_00.summon_agent_type,var_02,self.angles,"axis");
		if(!isdefined(var_03))
		{
			break;
		}

		var_03 thread scripts\cp\zombies\zombies_spawning::func_64E7(var_00.summon_agent_type);
	}
}

//Function Number: 11
damagezombies(param_00,param_01)
{
	var_02 = scripts\mp\_mp_agent::func_7D95("generic_zombie");
	var_03 = param_01 * param_01;
	foreach(var_05 in var_02)
	{
		var_06 = distancesquared(var_05.origin,param_00);
		if(var_06 > var_03)
		{
			continue;
		}

		var_05 dodamage(var_05.health * 10,param_00,self,self,"MOD_IMPACT");
	}
}

//Function Number: 12
dostaffstompdamage(param_00,param_01)
{
	if(isdefined(param_00))
	{
		self endon(param_00 + "_finished");
	}

	if(isdefined(param_01))
	{
		wait(param_01);
	}

	var_02 = scripts\mp\agents\ratking\ratking_tunedata::gettunedata();
	self setscriptablepartstate("attacks","staff_stomp");
	self radiusdamage(self.origin,var_02.staff_stomp_damage_radius,var_02.staff_stomp_max_damage,var_02.staff_stomp_min_damage,self,"MOD_IMPACT");
	if(scripts\common\utility::istrue(self.battackzombies))
	{
		damagezombies(self.origin,var_02.staff_stomp_damage_radius);
	}
}

//Function Number: 13
staffstompnotehandler(param_00,param_01,param_02,param_03)
{
	if(param_00 == "hit")
	{
		dostaffstompdamage(param_01);
	}
}

//Function Number: 14
dostaffstomp(param_00,param_01,param_02,param_03)
{
	self endon(param_01 + "_finished");
	thread lib_0C73::func_6A6A(param_01,scripts\mp\agents\ratking\ratking_agent::getenemy());
	self notify("stomp");
	lib_0A1D::func_2364(param_00,param_01,param_02,param_03);
}

//Function Number: 15
summonnotehandler(param_00,param_01,param_02,param_03)
{
	if(param_00 == "start_summon_zombies")
	{
		self notify("summon");
		dosummonspawn();
	}
}

//Function Number: 16
ratkingturnnotehandler(param_00,param_01,param_02,param_03)
{
	if(isdefined(param_00))
	{
		switch(param_00)
		{
			case "right":
				self setscriptablepartstate("turns","right");
				break;

			case "left":
				self setscriptablepartstate("turns","left");
				break;

			default:
				self setscriptablepartstate("turns","forward");
				break;
		}
	}
}

//Function Number: 17
meleenotehandler(param_00,param_01,param_02,param_03)
{
	if(param_00 == "hit")
	{
		var_04 = scripts\mp\agents\ratking\ratking_agent::getenemy();
		if(isdefined(var_04))
		{
			if(distancesquared(var_04.origin,self.origin) < -25536)
			{
				self notify("attack_hit",var_04);
				if(var_04.team == "axis" && scripts\common\utility::istrue(self.battackzombies))
				{
					lib_0C73::func_5904(var_04,var_04.health * 10,"MOD_IMPACT");
				}
				else
				{
					lib_0C73::func_5904(var_04,self.var_B601,"MOD_IMPACT");
				}
			}
			else
			{
				self notify("attack_miss",var_04);
			}
		}

		if(!scripts\common\utility::istrue(self.bmovingmelee))
		{
			self notify("stop_melee_face_enemy");
		}
	}
}

//Function Number: 18
shieldthrowatspotnotehandler(param_00,param_01,param_02,param_03)
{
	if(param_00 == "hit")
	{
		var_04 = scripts\mp\agents\ratking\ratking_agent::getstructpos();
		if(!isdefined(var_04))
		{
			return;
		}

		var_05 = self gettagorigin("J_Shield_LE");
		var_06 = var_04.origin;
		var_07 = magicbullet("iw7_ratking_shield_projectile",var_05,var_06,self);
		self setscriptablepartstate("shield","neutral");
		thread scripts\aitypes\ratking\behaviors::throwandrecovershield(1);
	}
}

//Function Number: 19
shieldthrownotehandler(param_00,param_01,param_02,param_03)
{
	if(param_00 == "hit")
	{
		var_04 = scripts\mp\agents\ratking\ratking_agent::getenemy();
		if(!isdefined(var_04))
		{
			return;
		}

		var_05 = self gettagorigin("J_Shield_LE");
		var_06 = var_04 geteye() - (0,0,12);
		magicbullet("iw7_ratking_shield_projectile",var_05,var_06,self);
		self setscriptablepartstate("shield","neutral");
		thread scripts\aitypes\ratking\behaviors::throwandrecovershield(5);
	}
}

//Function Number: 20
shieldthrowatspothack(param_00)
{
	self endon(param_00 + "_finished");
	wait(0.8);
	shieldthrowatspotnotehandler("hit",param_00,1,0);
}

//Function Number: 21
doshieldthrowatspot(param_00,param_01,param_02,param_03)
{
	self endon(param_01 + "_finished");
	var_04 = scripts\mp\agents\ratking\ratking_agent::getstructpos();
	if(isdefined(var_04))
	{
		self.var_1C2 = var_04.origin;
	}

	scripts\mp\agents\ratking\ratking_agent::lookatspot();
	self notify("shield_throw");
	lib_0A1D::func_2364(param_00,param_01,param_02,param_03);
	self.var_1C2 = undefined;
}

//Function Number: 22
aimatenemy(param_00,param_01)
{
	self endon(param_00 + "_finished");
	while(isdefined(param_01) && isalive(param_01))
	{
		self.var_1C2 = param_01 method_815B();
		scripts\common\utility::func_136F7();
	}
}

//Function Number: 23
clearlooktarget(param_00,param_01,param_02)
{
	self.var_1C2 = undefined;
}

//Function Number: 24
doshieldthrow(param_00,param_01,param_02,param_03)
{
	self endon(param_01 + "_finished");
	scripts\mp\agents\ratking\ratking_agent::lookatenemy();
	thread aimatenemy(param_01,scripts\mp\agents\ratking\ratking_agent::getenemy());
	lib_0A1D::func_2364(param_00,param_01,param_02,param_03);
	self.var_1C2 = undefined;
}

//Function Number: 25
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

//Function Number: 26
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

//Function Number: 27
playanimwithplaybackrate(param_00,param_01,param_02,param_03)
{
	self endon(param_01 + "_finished");
	var_04 = param_03;
	var_05 = lib_0A1D::func_2337(param_00,param_01);
	lib_0A1D::func_2365(param_00,param_01,param_02,var_05,var_04);
}

//Function Number: 28
playblockanim(param_00,param_01,param_02,param_03)
{
	self endon(param_01 + "_finished");
	var_04 = vectortoangles(self.damageaccumulator.lastdir * -1);
	var_04 = (0,var_04[1],0);
	self method_8289("face angle abs",var_04);
	self method_8281("anim deltas");
	lib_0A1D::func_2364(param_00,param_01,param_02,param_03);
}

//Function Number: 29
func_BEA0(param_00,param_01,param_02,param_03)
{
	var_04 = undefined;
	var_05 = scripts\mp\agents\ratking\ratking_agent::getenemy();
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

//Function Number: 30
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

	var_03 = scripts\mp\agents\ratking\ratking_agent::getenemy();
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

//Function Number: 31
choosestaffornostaffanim(param_00,param_01,param_02)
{
	if(scripts\common\utility::istrue(self.nostaff))
	{
		return lib_0A1A::func_2358(param_01,"nostaff");
	}

	return lib_0A1A::func_2358(param_01,"staff");
}

//Function Number: 32
chooseshieldornoshieldanim(param_00,param_01,param_02)
{
	if(self.var_2303.shieldstate == "equipped")
	{
		return lib_0A1A::func_2358(param_01,"shield");
	}

	return lib_0A1A::func_2358(param_01,"noshield");
}

//Function Number: 33
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

//Function Number: 34
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

//Function Number: 35
playmeleeattack(param_00,param_01,param_02,param_03)
{
	self endon(param_01 + "_finished");
	thread lib_0C73::func_6A6A(param_01,self.var_4B26);
	var_04 = lib_0A1D::func_2337(param_00,param_01);
	self notify("melee");
	lib_0A1D::func_2365(param_00,param_01,param_02,var_04);
}

//Function Number: 36
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

//Function Number: 37
func_3EE4(param_00,param_01,param_02)
{
	return lib_0F3C::func_3EF4(param_00,param_01,param_02);
}

//Function Number: 38
playmovingpainanim(param_00,param_01,param_02,param_03)
{
	self endon(param_01 + "_finished");
	if(!isdefined(self.var_233) || self method_841E() < scripts\mp\agents\ratking\ratking_tunedata::gettunedata().min_moving_pain_dist)
	{
		var_04 = func_3EE4(param_00,"pain_generic",param_03);
		self method_8289("face angle abs",self.angles);
		self notify("pain");
		lib_0A1D::func_2365(param_00,"pain_generic",param_02,var_04,1);
		return;
	}

	self notify("pain");
	lib_0A1D::func_2364(param_01,param_02,param_03,var_04);
}

//Function Number: 39
playteleportin(param_00,param_01,param_02,param_03)
{
	self endon(param_01 + "_finished");
	if(!scripts\aitypes\ratking\behaviors::rk_isonplatform())
	{
		self setscriptablepartstate("movement","dematerialize");
	}

	playanimwithplaybackrate(param_00,param_01,param_02,param_03);
}

//Function Number: 40
terminate_teleportout(param_00,param_01,param_02)
{
}

//Function Number: 41
shouldconsiderabortingteleport(param_00,param_01,param_02,param_03)
{
	if(scripts\common\utility::istrue(self.ishidden))
	{
		return 0;
	}

	return shouldabortaction(param_00,param_01,param_02,"teleport");
}

//Function Number: 42
playteleportout(param_00,param_01,param_02,param_03)
{
	self endon(param_01 + "_finished");
	self endon("death");
	var_04 = lib_0A1D::func_2337(param_00,param_01);
	var_05 = scripts\mp\agents\ratking\ratking_agent::getenemy();
	self.ishidden = 1;
	wait(0.1);
	self dontinterpolate();
	self hide();
	if(scripts\common\utility::istrue(self.fake_death))
	{
		scripts\mp\agents\ratking\ratking_agent::executefakedeath();
	}

	scripts\aitypes\ratking\behaviors::setplatformstate();
	var_06 = undefined;
	if(!scripts\aitypes\ratking\behaviors::rk_isonplatform())
	{
		var_06 = spawnfx(level._effect["rk_tele_spot"],self.teleportpos);
		triggerfx(var_06);
	}

	self setorigin(self.teleportpos,0);
	if(isdefined(var_05))
	{
		self.angles = vectortoangles(var_05.origin - self.origin);
	}

	self.teleportpos = undefined;
	self method_8286(self.origin);
	self method_841F();
	thread showmelater(var_06);
	if(!scripts\common\utility::istrue(self.btraversalteleport))
	{
		scripts\mp\agents\ratking\ratking_agent::lookatenemy();
	}

	lib_0A1D::func_2365(param_00,param_01,param_02,var_04,1);
	if(scripts\common\utility::istrue(self.btraversalteleport))
	{
		self.var_9CEC = undefined;
		self.btraversalteleport = undefined;
		self notify("traverse_end");
		lib_0A1A::func_237C("decide_idle",param_03);
	}
}

//Function Number: 43
showmelater(param_00)
{
	if(scripts\aitypes\ratking\behaviors::rk_isonplatform())
	{
		self setscriptablepartstate("rat_skirt","platform");
	}
	else
	{
		self setscriptablepartstate("movement","materialize");
		self setscriptablepartstate("rat_skirt","active");
	}

	wait(0.1);
	self show();
	self.ishidden = 0;
	thread gibnearbyzombies(0.1);
	wait(1);
	if(isdefined(param_00))
	{
		param_00 delete();
	}

	if(scripts\aitypes\ratking\behaviors::rk_isonplatform())
	{
		self setscriptablepartstate("movement","neutral");
	}
}

//Function Number: 44
gibnearbyzombies(param_00)
{
	if(isdefined(param_00))
	{
		wait(param_00);
	}

	var_01 = scripts\mp\_mp_agent::func_7DAF();
	var_02 = scripts\mp\agents\ratking\ratking_agent::getenemy();
	var_03 = scripts\mp\agents\ratking\ratking_tunedata::gettunedata();
	foreach(var_05 in var_01)
	{
		if(var_05 == self)
		{
			continue;
		}

		if(var_05.team == "allies")
		{
			continue;
		}

		if(isdefined(var_02) && var_05 == var_02)
		{
			continue;
		}

		var_06 = distancesquared(self.origin,var_05.origin);
		if(var_06 > var_03.telefrag_dist_sq)
		{
			continue;
		}

		var_05 gibthyself();
	}
}

//Function Number: 45
gibthyself()
{
	self.nocorpse = 1;
	self.full_gib = 1;
	self dodamage(self.health + -15536,self.origin);
}

//Function Number: 46
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

//Function Number: 47
ontraversalteleport(param_00,param_01,param_02,param_03)
{
	self.teleportpos = self method_8146();
	self.btraversalteleport = 1;
	return 1;
}

//Function Number: 48
platformfaceenemy(param_00)
{
	self endon(param_00 + "_finished");
	for(;;)
	{
		var_01 = scripts\mp\agents\ratking\ratking_agent::getenemy();
		if(isdefined(var_01) && isalive(var_01))
		{
			self method_8289("face angle abs",(0,vectortoyaw(var_01.origin - self.origin),0));
		}

		scripts\common\utility::func_136F7();
	}
}

//Function Number: 49
playplatformidle(param_00,param_01,param_02,param_03)
{
	self endon(param_01 + "_finished");
	self method_841F();
	thread platformfaceenemy(param_01);
	lib_0A1D::func_2364(param_00,param_01,param_02,param_03);
}

//Function Number: 50
dostaffprojectile(param_00,param_01,param_02,param_03)
{
	self endon(param_01 + "_finished");
	thread lib_0C73::func_6A6A(param_01,scripts\mp\agents\ratking\ratking_agent::getenemy());
	lib_0A1D::func_2364(param_00,param_01,param_02,param_03);
}

//Function Number: 51
dostaffprojectiledamage(param_00,param_01,param_02,param_03)
{
	var_04 = param_01 * param_01;
	var_05 = scripts\common\trace::func_48CC(1);
	var_06 = scripts\common\trace::func_DCED(param_00 + (0,0,param_02),param_00 - (0,0,param_02),self,var_05);
	param_00 = getgroundposition(param_00,8);
	foreach(var_08 in level.players)
	{
		if(!isalive(var_08))
		{
			continue;
		}

		if(var_08.ignoreme || isdefined(var_08.var_222) && var_08.var_222.ignoreme)
		{
			continue;
		}

		if(lib_0F74::func_1002C(var_08))
		{
			continue;
		}

		var_09 = distance2dsquared(param_00,var_08.origin);
		if(var_09 > var_04)
		{
			continue;
		}

		if(abs(param_00[2] - var_08.origin[2]) > param_02)
		{
			continue;
		}

		var_08 dodamage(param_03,param_00,self,self,"MOD_IMPACT");
	}
}

//Function Number: 52
handlestaffprojectile()
{
	var_00 = scripts\mp\agents\ratking\ratking_tunedata::gettunedata();
	var_01 = anglestoforward(self.angles);
	var_02 = var_00.staff_projectile_range / var_00.staff_projectile_speed;
	var_03 = var_00.staff_projectile_speed * var_00.staff_projectile_interval;
	var_04 = var_03 / 2;
	var_05 = self.origin + var_01 * var_04;
	var_06 = gettime() + var_02 * 1000;
	var_07 = spawn("script_model",var_05);
	var_07 setmodel("tag_origin_staff_proj");
	var_07 show();
	var_07.angles = var_01;
	playsoundatpos(var_05,"rk_fissure_deploy_lr");
	thread delayprojectileloopsound(var_07,var_00.staff_projectile_interval);
	while(gettime() < var_06)
	{
		dostaffprojectiledamage(var_05,var_04,var_00.staff_projectile_z_delta,var_00.staff_projectile_damage);
		var_07 moveto(var_05,var_00.staff_projectile_interval);
		wait(var_00.staff_projectile_interval);
		var_05 = var_05 + var_01 * var_03;
		var_07.angles = vectortoangles(var_05 - var_07.origin);
	}

	var_07 stoploopsound();
	var_07 delete();
}

//Function Number: 53
delayprojectileloopsound(param_00,param_01)
{
	level endon("game_ended");
	wait(param_01);
	param_00 scripts\common\utility::func_CD7F("rk_fissure_ground_lp",(0,0,12));
}

//Function Number: 54
staffprojectilenotehandler(param_00,param_01,param_02,param_03)
{
	if(param_00 == "hit")
	{
		handlestaffprojectile();
	}
}

//Function Number: 55
lostorfoundstaff(param_00,param_01,param_02,param_03)
{
	if(scripts\common\utility::istrue(self.bstaffchanged))
	{
		self.bstaffchanged = undefined;
		return 1;
	}

	return 0;
}

//Function Number: 56
lostorfoundshield(param_00,param_01,param_02,param_03)
{
	if(self.var_1198.requestedshieldstate == self.var_2303.shieldstate)
	{
		return 0;
	}

	if(self.var_1198.requestedshieldstate == "equipped" && self.var_2303.shieldstate != "equipped")
	{
		return 1;
	}

	if(self.var_1198.requestedshieldstate == "dropped" && self.var_2303.shieldstate == "equipped")
	{
		return 1;
	}

	self.var_2303.shieldstate = self.var_1198.requestedshieldstate;
	return 0;
}

//Function Number: 57
playshieldlostandfound(param_00,param_01,param_02,param_03)
{
	switch(self.var_1198.requestedshieldstate)
	{
		case "equipped":
			self setscriptablepartstate("shield","shield_activate");
			break;

		case "dropped":
			self setscriptablepartstate("shield","shield_dissolve");
			break;

		default:
			break;
	}

	self.var_2303.shieldstate = self.var_1198.requestedshieldstate;
	lib_0F3C::func_CEA8(param_00,param_01,param_02,param_03);
}

//Function Number: 58
ratking_chooseanim_exit(param_00,param_01,param_02)
{
	var_03 = lib_0F3B::func_53CA(param_01);
	return var_03;
}