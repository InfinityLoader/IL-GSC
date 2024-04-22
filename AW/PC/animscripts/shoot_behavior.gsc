/*******************************************************************
 * Decompiled By: Bog
 * Decompiled File: shoot_behavior.gsc
 * Game: Call of Duty: Advanced Warfare
 * Platform: PC
 * Function Count: 27
 * Decompile Time: 393 ms
 * Timestamp: 4/22/2024 2:00:56 AM
*******************************************************************/

//Function Number: 1
decidewhatandhowtoshoot(param_00)
{
	self endon("killanimscript");
	self notify("stop_deciding_how_to_shoot");
	self endon("stop_deciding_how_to_shoot");
	self endon("death");
	maps\_gameskill::resetmisstime();
	self.shootobjective = param_00;
	self.shootent = undefined;
	self.shootpos = undefined;
	self.shootstyle = "none";
	self.fastburst = 0;
	self.shouldreturntocover = undefined;
	if(!isdefined(self.changingcoverpos))
	{
		self.changingcoverpos = 0;
	}

	var_01 = isdefined(self.covernode) && self.covernode.type != "Cover Prone" && self.covernode.type != "Conceal Prone";
	if(var_01)
	{
		wait(0.05);
	}

	var_02 = self.shootent;
	var_03 = self.shootpos;
	var_04 = self.shootstyle;
	if(!isdefined(self.has_no_ir))
	{
		self.a.laseron = 1;
		animscripts\shared::updatelaserstatus();
	}

	if(animscripts\combat_utility::issniper())
	{
		resetsniperaim();
	}

	if(var_01 && !self.a.atconcealmentnode || !animscripts\utility::canseeenemy())
	{
		thread watchforincomingfire();
	}

	thread runonshootbehaviorend();
	self.ambushendtime = undefined;
	for(;;)
	{
		if(isdefined(self.shootposoverride))
		{
			if(!isdefined(self.enemy))
			{
				self.shootpos = self.shootposoverride;
				self.shootposoverride = undefined;
				waitabit();
			}
			else
			{
				self.shootposoverride = undefined;
			}
		}

		var_05 = undefined;
		if(self.weapon == "none")
		{
			nogunshoot();
		}
		else if(animscripts\utility::usingrocketlauncher())
		{
			var_05 = rpgshoot();
		}
		else if(animscripts\utility::usingsidearm() || isdefined(self.alwaysusepistol))
		{
			var_05 = pistolshoot();
		}
		else
		{
			var_05 = rifleshoot();
		}

		if(isdefined(self.a.specialshootbehavior))
		{
			[[ self.a.specialshootbehavior ]]();
		}

		if(checkchanged(var_02,self.shootent) || !isdefined(self.shootent) && checkchanged(var_03,self.shootpos) || checkchanged(var_04,self.shootstyle))
		{
			self notify("shoot_behavior_change");
		}

		var_02 = self.shootent;
		var_03 = self.shootpos;
		var_04 = self.shootstyle;
		if(!isdefined(var_05))
		{
			waitabit();
		}
	}
}

//Function Number: 2
waitabit()
{
	self endon("enemy");
	self endon("done_changing_cover_pos");
	self endon("weapon_position_change");
	self endon("enemy_visible");
	if(isdefined(self.shootent))
	{
		self.shootent endon("death");
		self endon("do_slow_things");
		wait(0.05);
		while(isdefined(self.shootent))
		{
			if(common_scripts\utility::flag("_cloaked_stealth_enabled"))
			{
				self.shootpos = animscripts\combat_utility::get_last_known_shoot_pos(self.shootent);
				continue;
			}

			self.shootpos = self.shootent getshootatpos();
			wait(0.05);
		}

		return;
	}

	self waittill("do_slow_things");
}

//Function Number: 3
nogunshoot()
{
	self.shootent = undefined;
	self.shootpos = undefined;
	self.shootstyle = "none";
	self.shootobjective = "normal";
}

//Function Number: 4
shouldsuppress()
{
	return !animscripts\combat_utility::issniper() && !animscripts\utility::isshotgun(self.weapon);
}

//Function Number: 5
shouldshootenemyent()
{
	if(!animscripts\utility::canseeenemy())
	{
		return 0;
	}

	if(!isdefined(self.covernode) && !self canshootenemy())
	{
		return 0;
	}

	return 1;
}

//Function Number: 6
rifleshootobjectivenormal()
{
	if(!shouldshootenemyent())
	{
		if(animscripts\combat_utility::issniper())
		{
			resetsniperaim();
		}

		if(self.doingambush)
		{
			self.shootobjective = "ambush";
			return "retry";
		}

		if(!isdefined(self.enemy))
		{
			havenothingtoshoot();
			return;
		}

		markenemyposinvisible();
		if((self.providecoveringfire || randomint(5) > 0) && shouldsuppress())
		{
			self.shootobjective = "suppress";
		}
		else
		{
			self.shootobjective = "ambush";
		}

		return "retry";
	}

	setshootenttoenemy();
	setshootstyleforvisibleenemy();
}

//Function Number: 7
rifleshootobjectivesuppress(param_00)
{
	if(!param_00)
	{
		havenothingtoshoot();
		return;
	}

	self.shootent = undefined;
	self.shootpos = animscripts\utility::getenemysightpos();
	setshootstyleforsuppression();
}

//Function Number: 8
rifleshootobjectiveambush(param_00)
{
	self.shootstyle = "none";
	self.shootent = undefined;
	if(!param_00)
	{
		getambushshootpos();
		if(shouldstopambushing())
		{
			self.ambushendtime = undefined;
			self notify("return_to_cover");
			self.shouldreturntocover = 1;
			return;
		}

		return;
	}

	self.shootpos = animscripts\utility::getenemysightpos();
	if(shouldstopambushing())
	{
		self.ambushendtime = undefined;
		if(shouldsuppress())
		{
			self.shootobjective = "suppress";
		}

		if(randomint(3) == 0)
		{
			self notify("return_to_cover");
			self.shouldreturntocover = 1;
		}

		return "retry";
	}
}

//Function Number: 9
getambushshootpos()
{
	if(isdefined(self.enemy) && self cansee(self.enemy))
	{
		setshootenttoenemy();
		return;
	}

	var_00 = self getanglestolikelyenemypath();
	if(!isdefined(var_00))
	{
		if(isdefined(self.covernode))
		{
			var_00 = self.covernode.angles;
		}
		else if(isdefined(self.ambushnode))
		{
			var_00 = self.ambushnode.angles;
		}
		else if(isdefined(self.enemy))
		{
			var_00 = vectortoangles(self lastknownpos(self.enemy) - self.origin);
		}
		else
		{
			var_00 = self.angles;
		}
	}

	var_01 = 1024;
	if(isdefined(self.enemy))
	{
		var_01 = distance(self.origin,self.enemy.origin);
	}

	var_02 = self geteye() + anglestoforward(var_00) * var_01;
	if(!isdefined(self.shootpos) || distancesquared(var_02,self.shootpos) > 25)
	{
		self.shootpos = var_02;
	}
}

//Function Number: 10
rifleshoot()
{
	if(self.shootobjective == "normal")
	{
		rifleshootobjectivenormal();
		return;
	}

	if(shouldshootenemyent())
	{
		self.shootobjective = "normal";
		self.ambushendtime = undefined;
		return "retry";
	}

	markenemyposinvisible();
	if(animscripts\combat_utility::issniper())
	{
		resetsniperaim();
	}

	var_00 = animscripts\utility::cansuppressenemy();
	if(self.shootobjective == "suppress" || self.team == "allies" && !isdefined(self.enemy) && !var_00)
	{
		rifleshootobjectivesuppress(var_00);
		return;
	}

	rifleshootobjectiveambush(var_00);
}

//Function Number: 11
shouldstopambushing()
{
	if(!isdefined(self.ambushendtime))
	{
		if(self isbadguy())
		{
			self.ambushendtime = gettime() + randomintrange(10000,60000);
		}
		else
		{
			self.ambushendtime = gettime() + randomintrange(4000,10000);
		}
	}

	return self.ambushendtime < gettime();
}

//Function Number: 12
rpgshoot()
{
	if(!shouldshootenemyent())
	{
		markenemyposinvisible();
		havenothingtoshoot();
		return;
	}

	setshootenttoenemy();
	setshootstyle("single",0);
	var_00 = lengthsquared(self.origin - self.shootpos);
	if(var_00 < squared(512))
	{
		self notify("return_to_cover");
		self.shouldreturntocover = 1;
	}
}

//Function Number: 13
pistolshoot()
{
	if(self.shootobjective == "normal")
	{
		if(!shouldshootenemyent())
		{
			if(!isdefined(self.enemy))
			{
				havenothingtoshoot();
				return;
			}

			markenemyposinvisible();
			self.shootobjective = "ambush";
			return "retry";
		}

		setshootenttoenemy();
		setshootstyle("single",0);
		return;
	}

	if(shouldshootenemyent())
	{
		self.shootobjective = "normal";
		self.ambushendtime = undefined;
		return "retry";
	}

	markenemyposinvisible();
	self.shootent = undefined;
	self.shootstyle = "none";
	self.shootpos = animscripts\utility::getenemysightpos();
	if(!isdefined(self.ambushendtime))
	{
		self.ambushendtime = gettime() + randomintrange(4000,8000);
	}

	if(self.ambushendtime < gettime())
	{
		self.shootobjective = "normal";
		self.ambushendtime = undefined;
		return "retry";
	}
}

//Function Number: 14
markenemyposinvisible()
{
	if(isdefined(self.enemy) && !self.changingcoverpos && self.script != "combat")
	{
		if(isai(self.enemy) && isdefined(self.enemy.script) && self.enemy.script == "cover_stand" || self.enemy.script == "cover_crouch")
		{
			if(isdefined(self.enemy.a.covermode) && self.enemy.a.covermode == "hide")
			{
				return;
			}
		}

		self.couldntseeenemypos = self.enemy.origin;
	}
}

//Function Number: 15
watchforincomingfire()
{
	self endon("killanimscript");
	self endon("stop_deciding_how_to_shoot");
	for(;;)
	{
		self waittill("suppression");
		if(self.suppressionmeter > self.suppressionthreshold)
		{
			if(readytoreturntocover())
			{
				self notify("return_to_cover");
				self.shouldreturntocover = 1;
			}
		}
	}
}

//Function Number: 16
readytoreturntocover()
{
	if(self.changingcoverpos)
	{
		return 0;
	}

	if(!isdefined(self.enemy) || !self cansee(self.enemy))
	{
		return 1;
	}

	if(gettime() < self.coverposestablishedtime + 800)
	{
		return 0;
	}

	if(isplayer(self.enemy) && self.enemy.health < self.enemy.maxhealth * 0.5)
	{
		if(gettime() < self.coverposestablishedtime + 3000)
		{
			return 0;
		}
	}

	return 1;
}

//Function Number: 17
runonshootbehaviorend()
{
	self endon("death");
	common_scripts\utility::waittill_any("killanimscript","stop_deciding_how_to_shoot");
	self.a.laseron = 0;
	animscripts\shared::updatelaserstatus();
}

//Function Number: 18
checkchanged(param_00,param_01)
{
	if(isdefined(param_00) != isdefined(param_01))
	{
		return 1;
	}

	if(!isdefined(param_01))
	{
		return 0;
	}

	return param_00 != param_01;
}

//Function Number: 19
setshootenttoenemy()
{
	self.shootent = self.enemy;
	if(common_scripts\utility::flag("_cloaked_stealth_enabled"))
	{
		if(isdefined(self.enemy_who_surprised_me) && self.enemy_who_surprised_me == self.enemy)
		{
			self.shootpos = self.shootent getshootatpos();
			return;
		}

		self.shootpos = animscripts\combat_utility::get_last_known_shoot_pos(self.shootent);
		return;
	}

	self.shootpos = self.shootent getshootatpos();
}

//Function Number: 20
havenothingtoshoot()
{
	self.shootent = undefined;
	self.shootpos = undefined;
	self.shootstyle = "none";
	if(self.doingambush)
	{
		self.shootobjective = "ambush";
	}

	if(!self.changingcoverpos)
	{
		self notify("return_to_cover");
		self.shouldreturntocover = 1;
	}
}

//Function Number: 21
shouldbeajerk()
{
	return level.gameskill == 3 && isplayer(self.enemy);
}

//Function Number: 22
setshootstyleforvisibleenemy()
{
	if(isdefined(self.shootent.enemy) && isdefined(self.shootent.enemy.syncedmeleetarget))
	{
		return setshootstyle("single",0);
	}

	if(animscripts\combat_utility::issniper())
	{
		return setshootstyle("single",0);
	}

	if(animscripts\utility::isshotgun(self.weapon))
	{
		if(animscripts\utility::weapon_pump_action_shotgun())
		{
			return setshootstyle("single",0);
		}
		else
		{
			return setshootstyle("semi",0);
		}
	}

	if(weaponclass(self.weapon) == "grenade")
	{
		return setshootstyle("single",0);
	}

	if(weaponburstcount(self.weapon) > 0)
	{
		return setshootstyle("burst",0);
	}

	if((isdefined(self.juggernaut) && self.juggernaut) || isdefined(self.mech) && self.mech)
	{
		return setshootstyle("full",1);
	}

	var_00 = distancesquared(self getshootatpos(),self.shootpos);
	var_01 = weaponclass(self.weapon) == "mg";
	if(self.providecoveringfire && var_01)
	{
		return setshootstyle("full",0);
	}

	if(var_00 < 62500)
	{
		if(isdefined(self.shootent) && isdefined(self.shootent.magic_bullet_shield))
		{
			return setshootstyle("single",0);
		}
		else
		{
			return setshootstyle("full",0);
		}
	}
	else if(var_00 < 810000 || shouldbeajerk())
	{
		if(weaponissemiauto(self.weapon) || shoulddosemiforvariety())
		{
			return setshootstyle("semi",1);
		}
		else
		{
			return setshootstyle("burst",1);
		}
	}
	else if(self.providecoveringfire || var_01 || var_00 < 2560000)
	{
		if(shoulddosemiforvariety())
		{
			return setshootstyle("semi",0);
		}
		else
		{
			return setshootstyle("burst",0);
		}
	}

	return setshootstyle("single",0);
}

//Function Number: 23
setshootstyleforsuppression()
{
	var_00 = distancesquared(self getshootatpos(),self.shootpos);
	if(weaponissemiauto(self.weapon))
	{
		if(var_00 < 2560000)
		{
			return setshootstyle("semi",0);
		}

		return setshootstyle("single",0);
	}

	if(weaponclass(self.weapon) == "mg")
	{
		return setshootstyle("full",0);
	}

	if(self.providecoveringfire || var_00 < 2560000)
	{
		if(shoulddosemiforvariety())
		{
			return setshootstyle("semi",0);
		}
		else
		{
			return setshootstyle("burst",0);
		}
	}

	return setshootstyle("single",0);
}

//Function Number: 24
setshootstyle(param_00,param_01)
{
	self.shootstyle = param_00;
	self.fastburst = param_01;
}

//Function Number: 25
shoulddosemiforvariety()
{
	if(weaponclass(self.weapon) != "rifle")
	{
		return 0;
	}

	if(self.team != "allies")
	{
		return 0;
	}

	var_00 = animscripts\utility::safemod(int(self.origin[1]),10000) + 2000;
	var_01 = int(self.origin[0]) + gettime();
	return var_01 % 2 * var_00 > var_00;
}

//Function Number: 26
resetsniperaim()
{
	self.snipershotcount = 0;
	self.sniperhitcount = 0;
	thread sniper_glint_behavior();
}

//Function Number: 27
sniper_glint_behavior()
{
	self endon("killanimscript");
	self endon("enemy");
	self endon("return_to_cover");
	self notify("new_glint_thread");
	self endon("new_glint_thread");
	if(isdefined(self.disable_sniper_glint) && self.disable_sniper_glint)
	{
		return;
	}

	if(!isdefined(level._effect["sniper_glint"]))
	{
		return;
	}

	if(!isalive(self.enemy))
	{
		return;
	}

	var_00 = common_scripts\utility::getfx("sniper_glint");
	wait(0.2);
	for(;;)
	{
		if(self.weapon == self.primaryweapon && animscripts\combat_utility::player_sees_my_scope())
		{
			if(distancesquared(self.origin,self.enemy.origin) > 65536)
			{
				playfxontag(var_00,self,"tag_flash");
			}

			var_01 = randomfloatrange(3,5);
			wait(var_01);
		}

		wait(0.2);
	}
}