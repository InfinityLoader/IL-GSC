/*******************************************************************
 * Decompiled By: Bog
 * Decompiled File: animscripts\cover_behavior.gsc
 * Game: Call of Duty: Ghosts
 * Platform: PC
 * Function Count: 38
 * Decompile Time: 656 ms
 * Timestamp: 10/27/2023 1:23:45 AM
*******************************************************************/

//Function Number: 1
func_4FDD(param_00)
{
	self.var_1F80 = self.origin;
	var_01 = gettime();
	var_02 = spawnstruct();
	var_02.nextallowedlooktime = var_01 - 1;
	var_02.var_55E4 = var_01 - 1;
	func_660D();
	func_6616();
	self.seekoutenemytime = gettime();
	self.a.var_4C5A = var_01;
	self.a.idlingatcover = 0;
	self.a.var_5486 = "stop";
	self.var_519E = var_01 + 3000;
	thread watchsuppression();
	var_03 = gettime() > 2500;
	for(;;)
	{
		if(isdefined(self.cover) && isdefined(self.cover.fnoverlord))
		{
			var_04 = gettime();
			thread func_2D5F();
			[[ self.cover.fnoverlord ]]();
			if(gettime() == var_04)
			{
				self notify("dont_end_idle");
			}
		}

		if(animscripts/combat_utility::shouldhelpadvancingteammate())
		{
			if(animscripts/combat_utility::func_8405(1))
			{
				wait(0.05);
				continue;
			}
		}

		if(isdefined(param_00.mainloopstart))
		{
			var_04 = gettime();
			thread func_2D5F();
			[[ param_00.mainloopstart ]]();
			if(gettime() == var_04)
			{
				self notify("dont_end_idle");
			}
		}

		if(isdefined(param_00.var_54BE))
		{
			if([[ param_00.var_54BE ]]())
			{
				continue;
			}
		}

		if(animscripts/utility::func_4965())
		{
			self safeteleport(self.var_1FCA.origin);
		}
		else
		{
			self safeteleport(self.var_1FCA.origin,getcorrectcoverangles());
		}

		if(!var_03)
		{
			func_43C6(param_00,0.05 + randomfloat(1.5));
			var_03 = 1;
			continue;
		}

		if(dononattackcoverbehavior(param_00))
		{
			continue;
		}

		if(isdefined(level.var_80AD) && isalive(level.player))
		{
			if(func_8406(param_00,level.player))
			{
				continue;
			}
		}

		if(func_663A())
		{
			return;
		}

		var_05 = 0;
		var_06 = 0;
		if(isalive(self.enemy))
		{
			var_05 = func_48B5();
			var_06 = animscripts/utility::func_1A00();
		}

		if(var_05)
		{
			if(self.a.var_3A44 < gettime())
			{
				if(animscripts/combat_utility::func_4F55())
				{
					return;
				}
			}

			func_1021(param_00);
			continue;
		}

		if(isdefined(self.aggressivemode) || func_2F25())
		{
			if(advanceonhidingenemy())
			{
				return;
			}
		}

		if(var_06)
		{
			attacksuppressableenemy(param_00,var_02);
			continue;
		}

		if(attacknothingtodo(param_00,var_02))
		{
			return;
		}
	}
}

//Function Number: 2
end_script(param_00)
{
	self.var_84C0 = undefined;
	self.a.prevattack = undefined;
	if(isdefined(self.var_519E) && self.var_519E <= gettime())
	{
		self.var_519D = gettime() + 5000;
		self.var_519E = undefined;
	}

	self clearanim(%head,0.2);
	self.facialidx = undefined;
}

//Function Number: 3
getcorrectcoverangles()
{
	if(self.swimmer)
	{
		return animscripts/swim::getnodeforwardangles(self.var_1FCA);
	}

	var_00 = (self.var_1FCA.angles[0],animscripts/utility::getnodeforwardyaw(self.var_1FCA),self.var_1FCA.angles[2]);
	return var_00;
}

//Function Number: 4
func_663A()
{
	if(self atdangerousnode() && self.a.var_663B < gettime())
	{
		if(animscripts/combat_utility::func_4F55())
		{
			return 1;
		}

		self.a.var_663B = gettime() + 30000;
	}

	return 0;
}

//Function Number: 5
dononattackcoverbehavior(param_00)
{
	if(func_7D65(param_00))
	{
		if(func_48B5())
		{
			func_6617();
		}

		self.a.var_4C5A = gettime();
		return 1;
	}

	if(coverreload(param_00,0))
	{
		return 1;
	}

	return 0;
}

//Function Number: 6
func_1021(param_00)
{
	if(distancesquared(self.origin,self.enemy.origin) > 562500)
	{
		if(func_8406(param_00,self.enemy))
		{
		}
	}

	if(leavecoverandshoot(param_00,"normal"))
	{
		func_6617();
		self.a.var_4C5A = gettime();
	}

	func_43C6(param_00);
}

//Function Number: 7
attacksuppressableenemy(param_00,param_01)
{
	if(self.doingambush)
	{
		if(leavecoverandshoot(param_00,"ambush"))
		{
		}
	}
	else if(self.providecoveringfire || gettime() >= param_01.var_55E4)
	{
		var_02 = "suppress";
		if(!self.providecoveringfire && gettime() - self.var_4CC3 > 5000 && randomint(3) < 2)
		{
			var_02 = "ambush";
		}
		else if(!animscripts/shoot_behavior::func_74CC())
		{
			var_02 = "ambush";
		}

		if(leavecoverandshoot(param_00,var_02))
		{
			param_01.var_55E4 = gettime() + randomintrange(3000,20000);
			if(func_48B5())
			{
				self.a.var_4C5A = gettime();
			}
		}
	}

	if(func_8406(param_00,self.enemy))
	{
	}

	func_43C6(param_00);
}

//Function Number: 8
attacknothingtodo(param_00,param_01)
{
	if(coverreload(param_00,0.1))
	{
		return 0;
	}

	if(isdefined(self.enemy))
	{
		if(func_8406(param_00,self.enemy))
		{
			return 0;
		}
	}

	if(!self.doingambush && gettime() >= param_01.nextallowedlooktime)
	{
		if(lookforenemy(param_00))
		{
			param_01.nextallowedlooktime = gettime() + randomintrange(4000,15000);
			return 0;
		}
	}

	if(gettime() > self.a.var_3A44)
	{
		if(cantfindanythingtodo())
		{
			return 1;
		}
	}

	if(self.doingambush || gettime() >= param_01.var_55E4 && isdefined(self.enemy))
	{
		if(leavecoverandshoot(param_00,"ambush"))
		{
			if(func_48B5())
			{
				func_6617();
			}

			self.a.var_4C5A = gettime();
			param_01.var_55E4 = gettime() + randomintrange(6000,20000);
			return 0;
		}
	}

	func_43C6(param_00);
	return 0;
}

//Function Number: 9
func_48B5()
{
	if(!isdefined(self.enemy))
	{
		return 0;
	}

	if(distancesquared(self.enemy.origin,self.var_1F80) < 256)
	{
		return 0;
	}

	return animscripts/utility::canseeenemyfromexposed();
}

//Function Number: 10
func_7D65(param_00)
{
	if(!animscripts/utility::func_4979())
	{
		return 0;
	}

	var_01 = gettime();
	var_02 = 1;
	while(animscripts/utility::func_4979())
	{
		var_02 = 0;
		self safeteleport(self.var_1FCA.origin);
		var_03 = 1;
		if(isdefined(self.var_31F8))
		{
			var_03 = common_scripts\utility::func_1DE9();
		}

		if(var_03)
		{
			if(func_8408(param_00))
			{
				self notify("killanimscript");
				return 1;
			}
		}

		if(self.a.atconcealmentnode && animscripts/utility::func_19F6())
		{
			return 0;
		}

		if(func_48B5() || animscripts/utility::func_1A00())
		{
			if(isdefined(level.var_80AD) && isalive(level.player))
			{
				if(func_8406(param_00,level.player))
				{
					continue;
				}
			}

			if(coverreload(param_00,0))
			{
				continue;
			}

			if(self.team != "allies" && gettime() >= var_01)
			{
				if(blindfire(param_00))
				{
					var_01 = gettime();
					if(!isdefined(self.var_31F8))
					{
						var_01 = var_01 + randomintrange(3000,12000);
					}

					continue;
				}
			}

			if(func_8406(param_00,self.enemy))
			{
				var_02 = 1;
				continue;
			}
		}

		if(coverreload(param_00,0.1))
		{
			continue;
		}

		func_43C6(param_00);
	}

	if(!var_02 && randomint(2) == 0)
	{
		func_4F54(param_00);
	}

	return 1;
}

//Function Number: 11
getpermutation(param_00)
{
	var_01 = [];
	if(param_00 == 1)
	{
		var_01[0] = 0;
	}
	else if(param_00 == 2)
	{
		var_01[0] = randomint(2);
		var_01[1] = 1 - var_01[0];
	}
	else
	{
		for(var_02 = 0;var_02 < param_00;var_02++)
		{
			var_01[var_02] = var_02;
		}

		for(var_02 = 0;var_02 < param_00;var_02++)
		{
			var_03 = var_02 + randomint(param_00 - var_02);
			var_04 = var_01[var_03];
			var_01[var_03] = var_01[var_02];
			var_01[var_02] = var_04;
		}
	}

	return var_01;
}

//Function Number: 12
calloptionalbehaviorcallback(param_00,param_01,param_02,param_03)
{
	if(!isdefined(param_00))
	{
		return 0;
	}

	thread func_2D5F();
	var_04 = gettime();
	var_05 = undefined;
	if(isdefined(param_03))
	{
		var_05 = [[ param_00 ]](param_01,param_02,param_03);
	}
	else if(isdefined(param_02))
	{
		var_05 = [[ param_00 ]](param_01,param_02);
	}
	else if(isdefined(param_01))
	{
		var_05 = [[ param_00 ]](param_01);
	}
	else
	{
		var_05 = [[ param_00 ]]();
	}

	if(!var_05)
	{
		self notify("dont_end_idle");
	}

	return var_05;
}

//Function Number: 13
watchsuppression()
{
	self endon("killanimscript");
	self.var_4CC3 = gettime() - 100000;
	self.var_7D69 = self.var_4CC3;
	for(;;)
	{
		self waittill("suppression");
		var_00 = gettime();
		if(self.var_4CC3 < var_00 - 700)
		{
			self.var_7D69 = var_00;
		}

		self.var_4CC3 = var_00;
	}
}

//Function Number: 14
coverreload(param_00,param_01)
{
	if(self.bulletsinclip > weaponclipsize(self.weapon) * param_01)
	{
		return 0;
	}

	self.isreloading = 1;
	var_02 = calloptionalbehaviorcallback(param_00.reload);
	self.isreloading = 0;
	return var_02;
}

//Function Number: 15
leavecoverandshoot(param_00,param_01)
{
	thread animscripts/shoot_behavior::func_2439(param_01);
	if(!self.fixednode && !self.doingambush)
	{
		thread func_17C4();
	}

	var_02 = calloptionalbehaviorcallback(param_00.leavecoverandshoot);
	self notify("stop_deciding_how_to_shoot");
	return var_02;
}

//Function Number: 16
lookforenemy(param_00)
{
	if(self.a.atconcealmentnode && animscripts/utility::func_19F6())
	{
		return 0;
	}

	if(self.a.var_4C5A + 6000 > gettime())
	{
		return func_4F54(param_00);
	}

	var_01 = calloptionalbehaviorcallback(param_00.look,2 + randomfloat(2));
	if(var_01)
	{
		return 1;
	}

	return calloptionalbehaviorcallback(param_00.var_31EF);
}

//Function Number: 17
func_4F54(param_00)
{
	var_01 = calloptionalbehaviorcallback(param_00.var_31EF);
	if(var_01)
	{
		return 1;
	}

	return calloptionalbehaviorcallback(param_00.look,0);
}

//Function Number: 18
func_43C6(param_00,param_01)
{
	self.flinching = 0;
	if(isdefined(param_00.var_3427))
	{
		if(!self.a.idlingatcover && gettime() - self.var_7D69 < 600)
		{
			if([[ param_00.var_3427 ]]())
			{
				return 1;
			}
		}
		else
		{
			thread func_3429(param_00);
		}
	}

	if(!self.a.idlingatcover)
	{
		thread func_43EA(param_00.var_43C6);
		self.a.idlingatcover = 1;
	}

	if(isdefined(param_01))
	{
		idlewait(param_01);
	}
	else
	{
		func_43ED();
	}

	if(self.flinching)
	{
		self waittill("flinch_done");
	}

	self notify("stop_waiting_to_flinch");
}

//Function Number: 19
idlewait(param_00)
{
	self endon("end_idle");
	wait(param_00);
}

//Function Number: 20
func_43ED()
{
	self endon("end_idle");
	wait(0.3 + randomfloat(0.1));
	self waittill("do_slow_things");
}

//Function Number: 21
func_43EA(param_00)
{
	self endon("killanimscript");
	self [[ param_00 ]]();
}

//Function Number: 22
func_3429(param_00)
{
	self endon("killanimscript");
	self endon("stop_waiting_to_flinch");
	var_01 = self.var_4CC3;
	for(;;)
	{
		self waittill("suppression");
		var_02 = gettime();
		if(var_01 < var_02 - 2000)
		{
			break;
		}

		var_01 = var_02;
	}

	self.flinching = 1;
	thread func_2D5F();
	var_03 = [[ param_00.var_3427 ]]();
	if(!var_03)
	{
		self notify("dont_end_idle");
	}

	self.flinching = 0;
	self notify("flinch_done");
}

//Function Number: 23
func_2D5F()
{
	self endon("killanimscript");
	self endon("dont_end_idle");
	waittillframeend;
	if(!isdefined(self))
	{
	}

	self notify("end_idle");
	self.a.idlingatcover = 0;
}

//Function Number: 24
func_8406(param_00,param_01)
{
	var_02 = anglestoforward(self.angles);
	var_03 = vectornormalize(param_01.origin - self.origin);
	if(vectordot(var_02,var_03) < 0)
	{
		return 0;
	}

	if(self.doingambush && !animscripts/utility::func_63FE())
	{
		return 0;
	}

	if(animscripts/utility::ispartiallysuppressedwrapper())
	{
		return calloptionalbehaviorcallback(param_00.var_3DB1,param_01);
	}

	return calloptionalbehaviorcallback(param_00.grenade,param_01);
}

//Function Number: 25
blindfire(param_00)
{
	if(!animscripts/utility::func_199A())
	{
		return 0;
	}

	return calloptionalbehaviorcallback(param_00.blindfire);
}

//Function Number: 26
func_17C4()
{
	self endon("killanimscript");
	self endon("stop_deciding_how_to_shoot");
	for(;;)
	{
		if(self.fixednode || self.doingambush)
		{
		}

		wait(0.5 + randomfloat(0.75));
		if(!isdefined(self.enemy))
		{
			continue;
		}

		if(func_2F25())
		{
			if(advanceonhidingenemy())
			{
			}
		}

		if(!animscripts/utility::func_63FE() && !animscripts/utility::cansuppressenemy())
		{
			if(gettime() > self.a.var_3A44)
			{
				if(cantfindanythingtodo())
				{
				}
			}
		}
	}
}

//Function Number: 27
func_2F25()
{
	if(!isdefined(self.enemy))
	{
		return 0;
	}

	if(self.enemy common_scripts\utility::isflashed())
	{
		return 1;
	}

	if(isplayer(self.enemy))
	{
		if(isdefined(self.enemy.health) && self.enemy.health < self.enemy.maxhealth)
		{
			return 1;
		}
	}
	else if(isai(self.enemy) && self.enemy animscripts/utility::func_4979())
	{
		return 1;
	}

	if(isdefined(self.enemy.isreloading) && self.enemy.isreloading)
	{
		return 1;
	}

	return 0;
}

//Function Number: 28
func_6616()
{
	self.a.var_663B = 0;
}

//Function Number: 29
func_660D()
{
	var_00 = gettime();
	if(isdefined(self.var_271E) && var_00 > self.a.var_3A44)
	{
		self.a.var_3A44 = var_00 + randomintrange(2000,5000);
	}

	if(isdefined(self.enemy))
	{
		var_01 = distance2d(self.origin,self.enemy.origin);
		if(var_01 < self.engagemindist)
		{
			self.a.var_3A44 = var_00 + randomintrange(5000,10000);
		}

		if(var_01 > self.engagemaxdist && var_01 < self.goalradius)
		{
			self.a.var_3A44 = var_00 + randomintrange(2000,5000);
		}

		self.a.var_3A44 = var_00 + randomintrange(10000,15000);
	}

	self.a.var_3A44 = var_00 + randomintrange(5000,15000);
}

//Function Number: 30
func_6617()
{
	if(isdefined(self.aggressivemode))
	{
		self.seekoutenemytime = gettime() + randomintrange(500,1000);
	}

	self.seekoutenemytime = gettime() + randomintrange(3000,5000);
}

//Function Number: 31
cantfindanythingtodo()
{
	return advanceonhidingenemy();
}

//Function Number: 32
advanceonhidingenemy()
{
	if(self.fixednode || self.doingambush)
	{
		return 0;
	}

	if(isdefined(self.aggressivemode) && gettime() >= self.seekoutenemytime)
	{
		return animscripts/combat_utility::func_8405(0);
	}

	var_00 = 0;
	if(!isdefined(self.enemy) || !self.enemy common_scripts\utility::isflashed())
	{
		var_00 = animscripts/combat_utility::func_4F55();
	}

	if(!var_00 && isdefined(self.enemy) && !animscripts/utility::canseeenemyfromexposed())
	{
		if(gettime() >= self.seekoutenemytime)
		{
			return animscripts/combat_utility::func_8405(0);
		}
	}

	return var_00;
}

//Function Number: 33
func_8408(param_00)
{
	if(isdefined(param_00.var_54BE))
	{
		if([[ param_00.var_54BE ]]())
		{
			return 1;
		}
	}

	return animscripts/combat_utility::func_4F55();
}

//Function Number: 34
set_standing_turns()
{
	var_00 = animscripts/utility::func_4F5D("exposed_turn");
	foreach(var_03, var_02 in var_00)
	{
		self.a.var_ED8[var_03] = var_02;
	}
}

//Function Number: 35
func_6E6A()
{
	var_00 = animscripts/utility::func_4F5D("exposed_turn_crouch");
	foreach(var_03, var_02 in var_00)
	{
		self.a.var_ED8[var_03] = var_02;
	}
}

//Function Number: 36
func_6FA3()
{
	self.a.var_ED8["turn_left_45"] = animscripts/swim::func_3C1D("turn_left_45");
	self.a.var_ED8["turn_left_90"] = animscripts/swim::func_3C1D("turn_left_90");
	self.a.var_ED8["turn_left_135"] = animscripts/swim::func_3C1D("turn_left_135");
	self.a.var_ED8["turn_left_180"] = animscripts/swim::func_3C1D("turn_left_180");
	self.a.var_ED8["turn_right_45"] = animscripts/swim::func_3C1D("turn_right_45");
	self.a.var_ED8["turn_right_90"] = animscripts/swim::func_3C1D("turn_right_90");
	self.a.var_ED8["turn_right_135"] = animscripts/swim::func_3C1D("turn_right_135");
	self.a.var_ED8["turn_right_180"] = animscripts/swim::func_3C1D("turn_right_180");
}

//Function Number: 37
func_84C1(param_00)
{
	if(isdefined(self.node))
	{
		var_01 = self.node;
		var_02 = abs(angleclamp180(self.angles[1] - var_01.angles[1] + param_00));
		if(self.a.var_60B1 == "stand" && var_01 gethighestnodestance() != "stand")
		{
			if(var_02 > 45 && var_02 < 90)
			{
				self orientmode("face angle",self.angles[1]);
			}
			else
			{
				self orientmode("face current");
			}

			var_03 = 1.5;
			var_04 = getnotetracktimes(%exposed_stand_2_crouch,"anim_pose = \"crouch\")[0];
			var_04 = min(1,var_04 * 1.1);
			var_05 = var_04 * getanimlength(%exposed_stand_2_crouch) / var_03;
			self setflaggedanimknoballrestart("crouchanim",%exposed_stand_2_crouch,%body,1,0.2,var_03);
			animscripts/notetracks::donotetracksfortime(var_05,"crouchanim");
			self clearanim(%body,0.2);
		}

		if(animscripts/utility::func_4965())
		{
			self notify("force_space_rotation_update",0,0);
		}
		else
		{
			self orientmode("face angle",self.angles[1]);
		}

		var_06 = angleclamp180(self.angles[1] - var_01.angles[1] + param_00);
		if(abs(var_06) > 45)
		{
			if(self.swimmer)
			{
				func_6FA3();
			}
			else if(self.a.var_60B1 == "stand")
			{
				set_standing_turns();
			}
			else
			{
				func_6E6A();
			}

			self.var_84BC = 45;
			self.var_84C0 = 1;
			animscripts/combat::func_84BF(var_06);
			self.var_84C0 = undefined;
		}
	}
}

//Function Number: 38
func_54BE()
{
	if(!isdefined(self.enemy))
	{
		return 0;
	}

	if(isdefined(self.var_271E))
	{
		self.var_271E = undefined;
		return 0;
	}

	if(!isdefined(self.node))
	{
		return 0;
	}

	if(animscripts/utility::func_4916(self.node))
	{
		return 0;
	}

	if(randomint(3) == 0)
	{
		return 0;
	}

	if(self.fixednode || self.doingambush || self.keepclaimednode || self.keepclaimednodeifvalid)
	{
		return 0;
	}

	if(distancesquared(self.origin,self.node.origin) > 256)
	{
		return 0;
	}

	var_00 = self findshufflecovernode();
	if(isdefined(var_00) && var_00 != self.node && self usecovernode(var_00))
	{
		self.var_752E = 1;
		self.var_7530 = var_00;
		self.var_271E = 1;
		wait(0.5);
		return 1;
	}

	return 0;
}