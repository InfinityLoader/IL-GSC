/*******************************************************************
 * Decompiled By: Bog
 * Decompiled File: animscripts\cover_behavior.gsc
 * Game: Call of Duty: Modern Warfare 3
 * Platform: Console
 * Function Count: 37
 * Decompile Time: 659 ms
 * Timestamp: 10/27/2023 2:30:13 AM
*******************************************************************/

//Function Number: 1
main(param_00)
{
	self.var_8E4 = self.origin;
	var_01 = gettime();
	var_02 = spawnstruct();
	var_02.nextallowedlooktime = var_01 - 1;
	var_02.nextallowedsuppresstime = var_01 - 1;
	resetlookforbettercovertime();
	resetrespondtodeathtime();
	self.seekoutenemytime = gettime();
	self.a.lastencountertime = var_01;
	self.a.idlingatcover = 0;
	self.a.movement = "stop";
	self.meleecoverchargemintime = var_01 + 3000;
	thread func_0B3B();
	var_03 = gettime() > 2500;
	var_04 = getcorrectcoverangles();
	for(;;)
	{
		if(animscripts/combat_utility::shouldhelpadvancingteammate())
		{
			if(animscripts/combat_utility::tryrunningtoenemy(1))
			{
				wait 0.05;
				continue;
			}
		}

		if(isdefined(param_00.mainloopstart))
		{
			var_05 = gettime();
			thread endidleatframeend();
			[[ param_00.mainloopstart ]]();
			if(gettime() == var_05)
			{
				self notify("dont_end_idle");
			}
		}

		if(isdefined(param_00.var_B22))
		{
			if([[ param_00.var_B22 ]]())
			{
				continue;
			}
		}

		self safeteleport(self.covernode.origin,var_04);
		if(!var_03)
		{
			idle(param_00,0.05 + randomfloat(1.5));
			var_03 = 1;
			continue;
		}

		if(dononattackcoverbehavior(param_00))
		{
			continue;
		}

		if(isdefined(level.throwgrenadeatplayerasap) && isalive(level.player))
		{
			if(trythrowinggrenade(param_00,level.player))
			{
				continue;
			}
		}

		if(respondtodeadteammate())
		{
			return;
		}

		var_06 = 0;
		var_07 = 0;
		if(isalive(self.enemy))
		{
			var_06 = isenemyvisiblefromexposed();
			var_07 = animscripts/utility::cansuppressenemyfromexposed();
		}

		if(var_06)
		{
			if(self.a.var_B25 < gettime())
			{
				if(animscripts/combat_utility::func_B26())
				{
					return;
				}
			}

			attackvisibleenemy(param_00);
			continue;
		}

		if(isdefined(self.aggressivemode) || enemyishiding())
		{
			if(advanceonhidingenemy())
			{
				return;
			}
		}

		if(var_07)
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
	self.turntomatchnode = undefined;
	self.a.prevattack = undefined;
	if(isdefined(self.meleecoverchargemintime) && self.meleecoverchargemintime <= gettime())
	{
		self.meleecoverchargegraceendtime = gettime() + 5000;
		self.meleecoverchargemintime = undefined;
	}
}

//Function Number: 3
getcorrectcoverangles()
{
	var_00 = (self.covernode.angles[0],animscripts/utility::getnodeforwardyaw(self.covernode),self.covernode.angles[2]);
	return var_00;
}

//Function Number: 4
respondtodeadteammate()
{
	if(self atdangerousnode() && self.a.respondtodeathtime < gettime())
	{
		if(animscripts/combat_utility::func_B26())
		{
			return 1;
		}

		self.a.respondtodeathtime = gettime() + 30000;
	}

	return 0;
}

//Function Number: 5
dononattackcoverbehavior(param_00)
{
	if(suppressedbehavior(param_00))
	{
		if(isenemyvisiblefromexposed())
		{
			resetseekoutenemytime();
		}

		self.a.lastencountertime = gettime();
		return 1;
	}

	if(coverreload(param_00,0))
	{
		return 1;
	}

	return 0;
}

//Function Number: 6
attackvisibleenemy(param_00)
{
	if(distancesquared(self.origin,self.enemy.origin) > 562500)
	{
		if(trythrowinggrenade(param_00,self.enemy))
		{
			return;
		}
	}

	if(leavecoverandshoot(param_00,"normal"))
	{
		resetseekoutenemytime();
		self.a.lastencountertime = gettime();
		return;
	}

	idle(param_00);
}

//Function Number: 7
attacksuppressableenemy(param_00,param_01)
{
	if(self.doingambush)
	{
		if(leavecoverandshoot(param_00,"ambush"))
		{
			return;
		}
	}
	else if(self.providecoveringfire || gettime() >= param_01.nextallowedsuppresstime)
	{
		var_02 = "suppress";
		if(!self.providecoveringfire && gettime() - self.var_B32 > 5000 && randomint(3) < 2)
		{
			var_02 = "ambush";
		}
		else if(!animscripts/shoot_behavior::shouldsuppress())
		{
			var_02 = "ambush";
		}

		if(leavecoverandshoot(param_00,var_02))
		{
			param_01.nextallowedsuppresstime = gettime() + randomintrange(3000,20000);
			if(isenemyvisiblefromexposed())
			{
				self.a.lastencountertime = gettime();
			}

			return;
		}
	}

	if(trythrowinggrenade(param_00,self.enemy))
	{
		return;
	}

	idle(param_00);
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
		if(trythrowinggrenade(param_00,self.enemy))
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

	if(gettime() > self.a.var_B25)
	{
		if(cantfindanythingtodo())
		{
			return 1;
		}
	}

	if(self.doingambush || gettime() >= param_01.nextallowedsuppresstime && isdefined(self.enemy))
	{
		if(leavecoverandshoot(param_00,"ambush"))
		{
			if(isenemyvisiblefromexposed())
			{
				resetseekoutenemytime();
			}

			self.a.lastencountertime = gettime();
			param_01.nextallowedsuppresstime = gettime() + randomintrange(6000,20000);
			return 0;
		}
	}

	idle(param_00);
	return 0;
}

//Function Number: 9
isenemyvisiblefromexposed()
{
	if(!isdefined(self.enemy))
	{
		return 0;
	}

	if(distancesquared(self.enemy.origin,self.var_8E4) < 256)
	{
		return 0;
	}

	return animscripts/utility::func_B35();
}

//Function Number: 10
suppressedbehavior(param_00)
{
	if(!animscripts/utility::issuppressedwrapper())
	{
		return 0;
	}

	var_01 = gettime();
	var_02 = 1;
	while(animscripts/utility::issuppressedwrapper())
	{
		var_02 = 0;
		self safeteleport(self.covernode.origin);
		var_03 = 1;
		if(isdefined(self.favor_blindfire))
		{
			var_03 = common_scripts\utility::cointoss();
		}

		if(var_03)
		{
			if(trytogetoutofdangeroussituation(param_00))
			{
				self notify("killanimscript");
				return 1;
			}
		}

		if(self.a.atconcealmentnode && animscripts/utility::canseeenemy())
		{
			return 0;
		}

		if(isenemyvisiblefromexposed() || animscripts/utility::cansuppressenemyfromexposed())
		{
			if(isdefined(level.throwgrenadeatplayerasap) && isalive(level.player))
			{
				if(trythrowinggrenade(param_00,level.player))
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
					if(!isdefined(self.favor_blindfire))
					{
						var_01 = var_01 + randomintrange(3000,12000);
					}

					continue;
				}
			}

			if(trythrowinggrenade(param_00,self.enemy))
			{
				var_02 = 1;
				continue;
			}
		}

		if(coverreload(param_00,0.1))
		{
			continue;
		}

		idle(param_00);
	}

	if(!var_02 && randomint(2) == 0)
	{
		lookfast(param_00);
	}

	return 1;
}

//Function Number: 11
getpermutation(param_00)
{
	var_01 = [];
	if(param_00 == 1)
	{
	}
	else if(var_01 == 2)
	{
	}
	else
	{
		for(var_02 = 0;var_02 < var_01;var_02++ = var_41[1])
		{
			var_41[var_02] = var_02;
		}

		for(var_02 = 0;var_02 < var_01;var_02++ = 1 - var_41[0])
		{
			var_03 = var_02 + randomint(var_01 - var_02);
			var_04 = var_41[var_03];
			var_41[var_03] = var_41[var_02];
			var_41[var_02] = var_04;
		}
	}

	return var_41;
}

//Function Number: 12
calloptionalbehaviorcallback(param_00,param_01,param_02,param_03)
{
	if(!isdefined(param_00))
	{
		return 0;
	}

	thread endidleatframeend();
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
func_0B3B()
{
	self endon("killanimscript");
	self.var_B32 = gettime() - 100000;
	self.suppressionstart = self.var_B32;
	for(;;)
	{
		self waittill("suppression");
		var_00 = gettime();
		if(self.var_B32 < var_00 - 700)
		{
			self.suppressionstart = var_00;
		}

		self.var_B32 = var_00;
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
	thread animscripts/shoot_behavior::decidewhatandhowtoshoot(param_01);
	if(!self.fixednode && !self.doingambush)
	{
		thread breakoutofshootingifwanttomoveup();
	}

	var_02 = calloptionalbehaviorcallback(param_00.leavecoverandshoot);
	self notify("stop_deciding_how_to_shoot");
	return var_02;
}

//Function Number: 16
lookforenemy(param_00)
{
	if(self.a.atconcealmentnode && animscripts/utility::canseeenemy())
	{
		return 0;
	}

	if(self.a.lastencountertime + 6000 > gettime())
	{
		return lookfast(param_00);
	}

	var_01 = calloptionalbehaviorcallback(param_00.look,2 + randomfloat(2));
	if(var_01)
	{
		return 1;
	}

	return calloptionalbehaviorcallback(param_00.fastlook);
}

//Function Number: 17
lookfast(param_00)
{
	var_01 = calloptionalbehaviorcallback(param_00.fastlook);
	if(var_01)
	{
		return 1;
	}

	return calloptionalbehaviorcallback(param_00.look,0);
}

//Function Number: 18
idle(param_00,param_01)
{
	self.flinching = 0;
	if(isdefined(param_00.flinch))
	{
		if(!self.a.idlingatcover && gettime() - self.suppressionstart < 600)
		{
			if([[ param_00.flinch ]]())
			{
				return 1;
			}
		}
		else
		{
			thread func_0B4A(param_00);
		}
	}

	if(!self.a.idlingatcover)
	{
		thread func_0B49(param_00.idle);
		self.a.idlingatcover = 1;
	}

	if(isdefined(param_01))
	{
		idlewait(param_01);
	}
	else
	{
		func_0B48();
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
	wait param_00;
}

//Function Number: 20
func_0B48()
{
	self endon("end_idle");
	wait 0.3 + randomfloat(0.1);
	self waittill("do_slow_things");
}

//Function Number: 21
func_0B49(param_00)
{
	self endon("killanimscript");
	self [[ param_00 ]]();
}

//Function Number: 22
func_0B4A(param_00)
{
	self endon("killanimscript");
	self endon("stop_waiting_to_flinch");
	var_01 = self.var_B32;
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
	thread endidleatframeend();
	var_03 = [[ param_00.flinch ]]();
	if(!var_03)
	{
		self notify("dont_end_idle");
	}

	self.flinching = 0;
	self notify("flinch_done");
}

//Function Number: 23
endidleatframeend()
{
	self endon("killanimscript");
	self endon("dont_end_idle");
	waittillframeend;
	if(!isdefined(self))
	{
		return;
	}

	self notify("end_idle");
	self.a.idlingatcover = 0;
}

//Function Number: 24
trythrowinggrenade(param_00,param_01)
{
	var_02 = anglestoforward(self.angles);
	var_03 = vectornormalize(param_01.origin - self.origin);
	if(vectordot(var_02,var_03) < 0)
	{
		return 0;
	}

	if(self.doingambush && !animscripts/utility::recentlysawenemy())
	{
		return 0;
	}

	if(animscripts/utility::ispartiallysuppressedwrapper())
	{
		return calloptionalbehaviorcallback(param_00.grenadehidden,param_01);
	}

	return calloptionalbehaviorcallback(param_00.grenade,param_01);
}

//Function Number: 25
blindfire(param_00)
{
	if(!animscripts/utility::canblindfire())
	{
		return 0;
	}

	return calloptionalbehaviorcallback(param_00.blindfire);
}

//Function Number: 26
breakoutofshootingifwanttomoveup()
{
	self endon("killanimscript");
	self endon("stop_deciding_how_to_shoot");
	for(;;)
	{
		if(self.fixednode || self.doingambush)
		{
			return;
		}

		wait 0.5 + randomfloat(0.75);
		if(!isdefined(self.enemy))
		{
			continue;
		}

		if(enemyishiding())
		{
			if(advanceonhidingenemy())
			{
				return;
			}
		}

		if(!animscripts/utility::recentlysawenemy() && !animscripts/utility::cansuppressenemy())
		{
			if(gettime() > self.a.var_B25)
			{
				if(cantfindanythingtodo())
				{
					return;
				}
			}
		}
	}
}

//Function Number: 27
enemyishiding()
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
	else if(isai(self.enemy) && self.enemy animscripts/utility::issuppressedwrapper())
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
resetrespondtodeathtime()
{
	self.a.respondtodeathtime = 0;
}

//Function Number: 29
resetlookforbettercovertime()
{
	var_00 = gettime();
	if(isdefined(self.var_B55) && var_00 > self.a.var_B25)
	{
		self.a.var_B25 = var_00 + randomintrange(2000,5000);
		return;
	}

	if(isdefined(self.enemy))
	{
		var_01 = distance2d(self.origin,self.enemy.origin);
		if(var_01 < self.engagemindist)
		{
			self.a.var_B25 = var_00 + randomintrange(5000,10000);
			return;
		}

		if(var_01 > self.engagemaxdist && var_01 < self.goalradius)
		{
			self.a.var_B25 = var_00 + randomintrange(2000,5000);
			return;
		}

		self.a.var_B25 = var_00 + randomintrange(10000,15000);
		return;
	}

	self.a.var_B25 = var_00 + randomintrange(5000,15000);
}

//Function Number: 30
resetseekoutenemytime()
{
	if(isdefined(self.aggressivemode))
	{
		self.seekoutenemytime = gettime() + randomintrange(500,1000);
		return;
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
		return animscripts/combat_utility::tryrunningtoenemy(0);
	}

	var_00 = 0;
	if(!isdefined(self.enemy) || !self.enemy common_scripts\utility::isflashed())
	{
		var_00 = animscripts/combat_utility::func_B26();
	}

	if(!var_00 && isdefined(self.enemy) && !animscripts/utility::func_B35())
	{
		if(gettime() >= self.seekoutenemytime)
		{
			return animscripts/combat_utility::tryrunningtoenemy(0);
		}
	}

	return var_00;
}

//Function Number: 33
trytogetoutofdangeroussituation(param_00)
{
	if(isdefined(param_00.var_B22))
	{
		if([[ param_00.var_B22 ]]())
		{
			return 1;
		}
	}

	return animscripts/combat_utility::func_B26();
}

//Function Number: 34
set_standing_turns()
{
	self.a.array["turn_left_45"] = %exposed_tracking_turn45l;
	self.a.array["turn_left_90"] = %exposed_tracking_turn90l;
	self.a.array["turn_left_135"] = %exposed_tracking_turn135l;
	self.a.array["turn_left_180"] = %exposed_tracking_turn180l;
	self.a.array["turn_right_45"] = %exposed_tracking_turn45r;
	self.a.array["turn_right_90"] = %exposed_tracking_turn90r;
	self.a.array["turn_right_135"] = %exposed_tracking_turn135r;
	self.a.array["turn_right_180"] = %exposed_tracking_turn180r;
}

//Function Number: 35
set_crouching_turns()
{
	self.a.array["turn_left_45"] = %exposed_crouch_turn_90_left;
	self.a.array["turn_left_90"] = %exposed_crouch_turn_90_left;
	self.a.array["turn_left_135"] = %exposed_crouch_turn_180_left;
	self.a.array["turn_left_180"] = %exposed_crouch_turn_180_left;
	self.a.array["turn_right_45"] = %exposed_crouch_turn_90_right;
	self.a.array["turn_right_90"] = %exposed_crouch_turn_90_right;
	self.a.array["turn_right_135"] = %exposed_crouch_turn_180_right;
	self.a.array["turn_right_180"] = %exposed_crouch_turn_180_right;
}

//Function Number: 36
func_0B5C(param_00)
{
	if(isdefined(self.node))
	{
		var_01 = self.node;
		var_02 = abs(angleclamp180(self.angles[1] - var_01.angles[1] + param_00));
		if(self.a.var_911 == "stand" && var_01 gethighestnodestance() != "stand")
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

		self orientmode("face angle",self.angles[1]);
		var_06 = angleclamp180(self.angles[1] - var_01.angles[1] + param_00);
		if(abs(var_06) > 45)
		{
			if(self.a.var_911 == "stand")
			{
				set_standing_turns();
			}
			else
			{
				set_crouching_turns();
			}

			self.turnthreshold = 45;
			self.turntomatchnode = 1;
			animscripts/combat::turntofacerelativeyaw(var_06);
			self.turntomatchnode = undefined;
		}
	}
}

//Function Number: 37
func_0B22()
{
	if(!isdefined(self.enemy))
	{
		return 0;
	}

	if(isdefined(self.var_B55))
	{
		self.var_B55 = undefined;
		return 0;
	}

	if(!isdefined(self.node))
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
		self.shufflemove = 1;
		self.shufflenode = var_00;
		self.var_B55 = 1;
		wait 0.5;
		return 1;
	}

	return 0;
}