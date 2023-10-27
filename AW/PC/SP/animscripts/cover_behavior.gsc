/*******************************************************************
 * Decompiled By: Bog
 * Decompiled File: animscripts\cover_behavior.gsc
 * Game: Call of Duty: Advanced Warfare
 * Platform: PC
 * Function Count: 39
 * Decompile Time: 614 ms
 * Timestamp: 10/27/2023 1:54:46 AM
*******************************************************************/

//Function Number: 1
main(param_00)
{
	self.couldntseeenemypos = self.origin;
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
	thread watchsuppression();
	var_03 = gettime() > 2500;
	for(;;)
	{
		if(isdefined(self.cover) && isdefined(self.cover.fnoverlord))
		{
			var_04 = gettime();
			thread endidleatframeend();
			[[ self.cover.fnoverlord ]]();
			if(gettime() == var_04)
			{
				self notify("dont_end_idle");
			}
		}

		if(animscripts\combat_utility::shouldhelpadvancingteammate())
		{
			if(animscripts\combat_utility::tryrunningtoenemy(1))
			{
				wait(0.05);
				continue;
			}
		}

		if(isdefined(param_00.mainloopstart))
		{
			var_04 = gettime();
			thread endidleatframeend();
			[[ param_00.mainloopstart ]]();
			if(gettime() == var_04)
			{
				self notify("dont_end_idle");
			}
		}

		if(isdefined(param_00.movetonearbycover))
		{
			if([[ param_00.movetonearbycover ]]())
			{
				continue;
			}
		}

		if(animscripts\utility::isspaceai())
		{
			self safeteleport(self.covernode.origin);
		}
		else
		{
			self safeteleport(self.covernode.origin,getcorrectcoverangles());
		}

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

		var_05 = 0;
		var_06 = 0;
		if(isalive(self.enemy))
		{
			var_05 = isenemyvisiblefromexposed();
			var_06 = animscripts\utility::cansuppressenemyfromexposed();
		}

		if(var_05)
		{
			if(self.a.getboredofthisnodetime < gettime())
			{
				if(animscripts\combat_utility::lookforbettercover())
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
	self.turntomatchnode = undefined;
	self.a.prevattack = undefined;
	if(isdefined(self.meleecoverchargemintime) && self.meleecoverchargemintime <= gettime())
	{
		self.meleecoverchargegraceendtime = gettime() + 5000;
		self.meleecoverchargemintime = undefined;
	}

	self clearanim(%head,0.2);
	self.facialidx = undefined;
}

//Function Number: 3
getcorrectcoverangles()
{
	if(self.swimmer)
	{
		return animscripts\swim::getnodeforwardangles(self.covernode);
	}

	var_00 = (self.covernode.angles[0],animscripts\utility::getnodeforwardyaw(self.covernode),self.covernode.angles[2]);
	return var_00;
}

//Function Number: 4
respondtodeadteammate()
{
	if(self atdangerousnode() && self.a.respondtodeathtime < gettime())
	{
		if(animscripts\combat_utility::lookforbettercover())
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
		if(!self.providecoveringfire && gettime() - self.lastsuppressiontime > 5000 && randomint(3) < 2)
		{
			var_02 = "ambush";
		}
		else if(!animscripts\shoot_behavior::shouldsuppress())
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

	if(gettime() > self.a.getboredofthisnodetime)
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

	if(distancesquared(self.enemy.origin,self.couldntseeenemypos) < 256)
	{
		return 0;
	}

	return animscripts\utility::canseeenemyfromexposed();
}

//Function Number: 10
suppressedbehavior(param_00)
{
	if(!animscripts\utility::issuppressedwrapper())
	{
		return 0;
	}

	var_01 = gettime();
	var_02 = 1;
	while(animscripts\utility::issuppressedwrapper())
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

		if(self.a.atconcealmentnode && animscripts\utility::canseeenemy())
		{
			return 0;
		}

		if(isenemyvisiblefromexposed() || animscripts\utility::cansuppressenemyfromexposed())
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
watchsuppression()
{
	self endon("killanimscript");
	self.lastsuppressiontime = gettime() - 100000;
	self.suppressionstart = self.lastsuppressiontime;
	for(;;)
	{
		self waittill("suppression");
		var_00 = gettime();
		if(self.lastsuppressiontime < var_00 - 700)
		{
			self.suppressionstart = var_00;
		}

		self.lastsuppressiontime = var_00;
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
	thread animscripts\shoot_behavior::decidewhatandhowtoshoot(param_01);
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
	if(self.a.atconcealmentnode && animscripts\utility::canseeenemy())
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
			thread flinchwhensuppressed(param_00);
		}
	}

	if(!self.a.idlingatcover)
	{
		thread idlethread(param_00.idle);
		self.a.idlingatcover = 1;
	}

	if(isdefined(param_01))
	{
		idlewait(param_01);
	}
	else
	{
		idlewaitabit();
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
idlewaitabit()
{
	self endon("end_idle");
	wait(0.3 + randomfloat(0.1));
	self waittill("do_slow_things");
}

//Function Number: 21
idlethread(param_00)
{
	self endon("killanimscript");
	self [[ param_00 ]]();
}

//Function Number: 22
flinchwhensuppressed(param_00)
{
	self endon("killanimscript");
	self endon("stop_waiting_to_flinch");
	var_01 = self.lastsuppressiontime;
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

	if(self.doingambush && !animscripts\utility::recentlysawenemy())
	{
		return 0;
	}

	if(animscripts\utility::ispartiallysuppressedwrapper())
	{
		return calloptionalbehaviorcallback(param_00.grenadehidden,param_01);
	}

	return calloptionalbehaviorcallback(param_00.grenade,param_01);
}

//Function Number: 25
blindfire(param_00)
{
	if(!animscripts\utility::canblindfire())
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

		wait(0.5 + randomfloat(0.75));
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

		if(!animscripts\utility::recentlysawenemy() && !animscripts\utility::cansuppressenemy())
		{
			if(gettime() > self.a.getboredofthisnodetime)
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
	else if(isai(self.enemy) && self.enemy animscripts\utility::issuppressedwrapper())
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
	if(isdefined(self.didshufflemove) && var_00 > self.a.getboredofthisnodetime)
	{
		self.a.getboredofthisnodetime = var_00 + randomintrange(2000,5000);
		return;
	}

	if(isdefined(self.enemy))
	{
		var_01 = distance2d(self.origin,self.enemy.origin);
		if(var_01 < self.engagemindist)
		{
			self.a.getboredofthisnodetime = var_00 + randomintrange(5000,10000);
			return;
		}

		if(var_01 > self.engagemaxdist && var_01 < self.goalradius)
		{
			self.a.getboredofthisnodetime = var_00 + randomintrange(2000,5000);
			return;
		}

		self.a.getboredofthisnodetime = var_00 + randomintrange(10000,15000);
		return;
	}

	self.a.getboredofthisnodetime = var_00 + randomintrange(5000,15000);
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
		return animscripts\combat_utility::tryrunningtoenemy(0);
	}

	var_00 = 0;
	if(!isdefined(self.enemy) || !self.enemy common_scripts\utility::isflashed())
	{
		var_00 = animscripts\combat_utility::lookforbettercover();
	}

	if(!var_00 && isdefined(self.enemy) && !animscripts\utility::canseeenemyfromexposed())
	{
		if(gettime() >= self.seekoutenemytime)
		{
			return animscripts\combat_utility::tryrunningtoenemy(0);
		}
	}

	return var_00;
}

//Function Number: 33
trytogetoutofdangeroussituation(param_00)
{
	if(isdefined(param_00.movetonearbycover))
	{
		if([[ param_00.movetonearbycover ]]())
		{
			return 1;
		}
	}

	return animscripts\combat_utility::lookforbettercover();
}

//Function Number: 34
set_standing_turns()
{
	var_00 = animscripts\utility::lookupanimarray("exposed_turn");
	foreach(var_03, var_02 in var_00)
	{
		self.a.array[var_03] = var_02;
	}
}

//Function Number: 35
set_standing_cover_turns()
{
	var_00 = animscripts\utility::lookupanimarray("coverstand_turn");
	foreach(var_03, var_02 in var_00)
	{
		self.a.array[var_03] = var_02;
	}
}

//Function Number: 36
set_crouching_turns()
{
	var_00 = animscripts\utility::lookupanimarray("exposed_turn_crouch");
	foreach(var_03, var_02 in var_00)
	{
		self.a.array[var_03] = var_02;
	}
}

//Function Number: 37
set_swimming_turns()
{
	self.a.array["turn_left_45"] = animscripts\swim::getswimanim("turn_left_45");
	self.a.array["turn_left_90"] = animscripts\swim::getswimanim("turn_left_90");
	self.a.array["turn_left_135"] = animscripts\swim::getswimanim("turn_left_135");
	self.a.array["turn_left_180"] = animscripts\swim::getswimanim("turn_left_180");
	self.a.array["turn_right_45"] = animscripts\swim::getswimanim("turn_right_45");
	self.a.array["turn_right_90"] = animscripts\swim::getswimanim("turn_right_90");
	self.a.array["turn_right_135"] = animscripts\swim::getswimanim("turn_right_135");
	self.a.array["turn_right_180"] = animscripts\swim::getswimanim("turn_right_180");
}

//Function Number: 38
turntomatchnodedirection(param_00)
{
	if(isdefined(self.node))
	{
		var_01 = self.node;
		var_02 = abs(angleclamp180(self.angles[1] - var_01.angles[1] + param_00));
		if(self.a.pose == "stand" && var_01 gethighestnodestance() != "stand")
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
			var_04 = %exposed_stand_2_crouch;
			if(isdefined(self.animarchetype) && self.animarchetype == "s1_soldier")
			{
				var_04 = %s1_exposed_stand_2_crouch;
			}

			var_05 = getnotetracktimes(var_04,"anim_pose = \"crouch\")[0];
			var_05 = min(1,var_05 * 1.1);
			var_06 = var_05 * getanimlength(var_04) / var_03;
			self setflaggedanimknoballrestart("crouchanim",var_04,%body,1,0.2,var_03);
			animscripts\notetracks::donotetracksfortime(var_06,"crouchanim");
			self clearanim(%body,0.2);
		}

		if(animscripts\utility::isspaceai())
		{
			self notify("force_space_rotation_update",0,0);
			return;
		}
		else
		{
			self orientmode("face angle",self.angles[1]);
		}

		var_07 = angleclamp180(self.angles[1] - var_01.angles[1] + param_00);
		if(abs(var_07) > 45)
		{
			if(self.swimmer)
			{
				set_swimming_turns();
			}
			else if(self.a.pose == "stand")
			{
				if(isdefined(self.animarchetype) && self.animarchetype == "s1_soldier")
				{
					if(isdefined(self.covertype))
					{
						if(self.covertype == "stand")
						{
							set_standing_cover_turns();
						}
						else
						{
							set_standing_turns();
						}
					}
					else
					{
						set_standing_turns();
					}
				}
				else
				{
					set_standing_turns();
				}
			}
			else
			{
				set_crouching_turns();
			}

			self.turnthreshold = 45;
			self.turntomatchnode = 1;
			animscripts\combat::turntofacerelativeyaw(var_07);
			self.turntomatchnode = undefined;
		}
	}
}

//Function Number: 39
movetonearbycover()
{
	if(!isdefined(self.enemy))
	{
		return 0;
	}

	if(isdefined(self.didshufflemove))
	{
		self.didshufflemove = undefined;
		return 0;
	}

	if(!isdefined(self.node))
	{
		return 0;
	}

	if(animscripts\utility::isnodecover3d(self.node))
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
		self.didshufflemove = 1;
		wait(0.5);
		return 1;
	}

	return 0;
}