/*******************************************************************
 * Decompiled By: Bog
 * Decompiled File: mp\agents\humanoid\_humanoid.gsc
 * Game: Call of Duty: Advanced Warfare
 * Platform: PC
 * Function Count: 20
 * Decompile Time: 335 ms
 * Timestamp: 4/22/2024 2:08:08 AM
*******************************************************************/

//Function Number: 1
setuphumanoidstate()
{
	self.attackoffset = 26 + self.radius;
	self.meleesectortype = "normal";
	self.meleesectorupdatetime = 50;
	self.attackzheight = 54;
	self.attackzheightdown = -64;
	self.damagedradiussq = 2250000;
	self.ignoreclosefoliage = 1;
	self.moveratescale = 1;
	self.nonmoveratescale = 1;
	self.traverseratescale = 1;
	self.generalspeedratescale = 1;
	self.bhasbadpath = 0;
	self.bhasnopath = 1;
	self.timeoflastdamage = 0;
	self.allowcrouch = 1;
	self.meleecheckheight = 40;
	self.meleeradiusbase = 60;
	self.meleeradiusbasesq = squared(self.meleeradiusbase);
	maps\mp\zombies\_util::setmeleeradius(self.meleeradiusbase);
	self.defaultgoalradius = self.radius + 1;
	self scragentsetgoalradius(self.defaultgoalradius);
	self.meleedot = 0.5;
}

//Function Number: 2
init()
{
	self.animcbs = spawnstruct();
	self.animcbs.onenter = [];
	self.animcbs.onenter["idle"] = ::maps\mp\agents\humanoid\_humanoid_idle::main;
	self.animcbs.onenter["move"] = ::maps\mp\agents\humanoid\_humanoid_move::main;
	self.animcbs.onenter["traverse"] = ::maps\mp\agents\humanoid\_humanoid_traverse::main;
	self.animcbs.onenter["melee"] = ::maps\mp\agents\humanoid\_humanoid_melee::main;
	self.animcbs.onenter["scripted"] = ::onscriptedbegin;
	self.animcbs.onexit = [];
	self.animcbs.onexit["idle"] = ::maps\mp\agents\humanoid\_humanoid_idle::end_script;
	self.animcbs.onexit["move"] = ::maps\mp\agents\humanoid\_humanoid_move::end_script;
	self.animcbs.onexit["melee"] = ::maps\mp\agents\humanoid\_humanoid_melee::end_script;
	self.animcbs.onexit["traverse"] = ::maps\mp\agents\humanoid\_humanoid_traverse::end_script;
	self.animcbs.onexit["scripted"] = ::onscriptedend;
	self.animcbs.ondamage = [];
	self.animcbs.ondamage["move"] = ::maps\mp\agents\humanoid\_humanoid_move::ondamage;
	self.aistate = "idle";
	self.movemode = "walk";
	self.sharpturnnotifydist = 100;
	self.radius = 15;
	self.height = 40;
}

//Function Number: 3
onscriptedbegin()
{
	self.isscripted = 1;
}

//Function Number: 4
onscriptedend()
{
	self.isscripted = undefined;
}

//Function Number: 5
spawn_humanoid(param_00,param_01,param_02,param_03)
{
	self setmodel("tag_origin");
	self.species = "humanoid";
	self.onenteranimstate = ::maps\mp\agents\_scripted_agent_anim_util::onenteranimstate;
	if(isdefined(param_01) && isdefined(param_02))
	{
		var_04 = param_01;
		var_05 = param_02;
	}
	else
	{
		var_06 = self [[ level.getspawnpoint ]]();
		var_04 = var_06.origin;
		var_05 = var_06.angles;
	}

	maps\mp\agents\_agent_utility::activateagent();
	self.spawntime = gettime();
	self.lastspawntime = gettime();
	init();
	var_07 = 15;
	var_08 = 60;
	if(isdefined(level.getradiusandheight) && isdefined(level.getradiusandheight[self.agent_type]))
	{
		var_09 = [[ level.getradiusandheight[self.agent_type] ]]();
		var_07 = var_09[0];
		var_08 = var_09[1];
	}

	self spawnagent(var_04,var_05,param_00,var_07,var_08,param_03);
	level notify("spawned_agent",self);
	maps\mp\agents\_agent_common::set_agent_health(100);
	if(isdefined(param_03))
	{
		maps\mp\agents\_agent_utility::set_agent_team(param_03.team,param_03);
	}

	self takeallweapons();
	self scragentsetspecies("human");
	self scragentsetnopenetrate(1);
	self scragentsetorienttoground(0);
	self scragentsetobstacleavoid(0);
	self scragentsetlateralcodemove(0);
	self scragentsetpathteamspread(1);
	self scragentsetallowragdoll(1);
	self thread [[ maps\mp\agents\_agent_utility::agentfunc("think") ]]();
}

//Function Number: 6
didpastmeleefail()
{
	if(isdefined(self.lastmeleefailedpos) && isdefined(self.lastmeleefailedmypos) && distance2dsquared(self.curmeleetarget.origin,self.lastmeleefailedpos) < 4 && distancesquared(self.origin,self.lastmeleefailedmypos) < 2500)
	{
		return 1;
	}

	return 0;
}

//Function Number: 7
didpastlungemeleefail()
{
	if(isdefined(self.lastlungemeleefailedpos) && isdefined(self.lastlungemeleefailedmypos) && distance2dsquared(self.curmeleetarget.origin,self.lastlungemeleefailedpos) < 4 && distancesquared(self.origin,self.lastlungemeleefailedmypos) < 2500)
	{
		return 1;
	}

	return 0;
}

//Function Number: 8
iswithinattackheight(param_00)
{
	var_01 = 0;
	var_02 = param_00[2] - self.origin[2];
	var_01 = var_02 <= self.attackzheight && var_02 >= self.attackzheightdown;
	if(!var_01 && isplayer(self.curmeleetarget) && maps\mp\zombies\_util::is_true(self.curmeleetarget.isinexploitspot))
	{
		if(length(self getvelocity()) < 5)
		{
			var_01 = var_02 <= self.attackzheight * 2 && var_02 >= self.attackzheightdown;
		}
	}

	return var_01;
}

//Function Number: 9
wanttoattacktargetbutcant()
{
	if(maps\mp\agents\humanoid\_humanoid_util::isentstandingonme(self.curmeleetarget))
	{
		return 0;
	}

	return !iswithinattackheight(self.curmeleetarget.origin) && distance2dsquared(self.origin,self.curmeleetarget.origin) < maps\mp\agents\humanoid\_humanoid_util::getmeleeradiussq() * 0.75 * 0.75;
}

//Function Number: 10
readytomeleetarget(param_00)
{
	if(!isdefined(self.curmeleetarget))
	{
		return 0;
	}

	if(!maps\mp\_utility::isreallyalive(self.curmeleetarget))
	{
		return 0;
	}

	if(self.aistate == "traverse")
	{
		return 0;
	}

	if(!maps\mp\agents\humanoid\_humanoid_util::isentstandingonme(self.curmeleetarget))
	{
		if(!iswithinattackheight(self.curmeleetarget.origin))
		{
			return 0;
		}

		if(param_00 == "normal" && !maps\mp\agents\humanoid\_humanoid_util::withinmeleeradius())
		{
			return 0;
		}
		else if(param_00 == "base" && !maps\mp\agents\humanoid\_humanoid_util::withinmeleeradiusbase())
		{
			return 0;
		}
	}

	if(maps\mp\agents\humanoid\_humanoid_melee::ismeleeblocked())
	{
		return 0;
	}

	return 1;
}

//Function Number: 11
getmeleeattackpoint(param_00)
{
	if(!isdefined(self.meleeattackpoint))
	{
		self.meleeattackpoint = spawnstruct();
	}

	if(maps\mp\agents\humanoid\_humanoid_util::isentunreachabledrone(param_00) && !maps\mp\agents\humanoid\_humanoid_util::hascalculatednearestnodetounreachabledrone())
	{
		maps\mp\agents\humanoid\_humanoid_util::calculatenearestnodetounreachabledrone();
	}

	var_01 = maps\mp\agents\humanoid\_humanoid_util::getoriginformeleesectors(param_00);
	self.meleeattackpoint.enemysectororigin = var_01;
	var_02 = maps\mp\agents\humanoid\_humanoid_util::getmeleetargetpoint(param_00,var_01);
	if(isdefined(var_02))
	{
		self.meleeattackpoint.valid = 1;
		self.meleeattackpoint.origin = var_02;
	}
	else
	{
		self.meleeattackpoint.valid = 0;
		self.meleeattackpoint.origin = var_01;
		if(isdefined(self.distractiondrone))
		{
			if(!isdefined(maps\mp\agents\humanoid\_humanoid_util::dropsectorpostoground(self.meleeattackpoint.origin,15,55)))
			{
				if(!isdefined(self.random_sector_order))
				{
					self.random_sector_order = [];
					for(var_03 = 0;var_03 < maps\mp\agents\humanoid\_humanoid_util::getnummeleesectors();var_03++)
					{
						self.random_sector_order[self.random_sector_order.size] = var_03;
					}

					self.random_sector_order = common_scripts\utility::array_randomize(self.random_sector_order);
				}

				foreach(var_05 in self.random_sector_order)
				{
					var_06 = param_00 maps\mp\agents\humanoid\_humanoid_util::getmeleesectors(self.meleesectortype);
					var_07 = var_06[var_05];
					if(isdefined(var_07.origin))
					{
						self.meleeattackpoint.origin = var_07.origin;
						break;
					}
				}
			}
		}
	}

	return self.meleeattackpoint;
}

//Function Number: 12
watchfavoriteenemydeath()
{
	self notify("watchFavoriteEnemyDeath");
	self endon("watchFavoriteEnemyDeath");
	self endon("death");
	self endon("disconnect");
	self.favoriteenemy common_scripts\utility::waittill_any_timeout(5,"death","disconnect");
	maps\mp\agents\humanoid\_humanoid_util::setfavoriteenemy(undefined);
}

//Function Number: 13
dostophitreaction(param_00,param_01,param_02,param_03,param_04)
{
	self endon("death");
	if(maps\mp\agents\_scripted_agent_anim_util::isstatelocked())
	{
		return;
	}

	if(maps\mp\agents\humanoid\_humanoid_util::iscrawling())
	{
		return;
	}

	self scragentsetscripted(1);
	maps\mp\agents\_scripted_agent_anim_util::setstatelocked(1,"DoStopHitReaction");
	self.inpain = 1;
	var_05 = "pain_stand";
	if(isdefined(param_01) && param_01 == "head")
	{
		var_05 = "pain_stand_head";
	}

	var_06 = 0;
	var_07 = angleclamp180(param_00 - self.angles[1]);
	if(isdefined(param_02) && param_02 == "boost_slam_mp")
	{
		if(param_04 / self.maxhealth > 0.2)
		{
			if(abs(var_07) < 45)
			{
				var_05 = "pain_knockback_front";
			}
			else if(abs(var_07) > 135)
			{
				var_05 = "pain_knockback_back";
			}
			else if(var_07 > 0)
			{
				var_05 = "pain_knockback_right";
			}
			else
			{
				var_05 = "pain_knockback_left";
			}
		}
		else
		{
			var_05 = "pain_stun";
		}

		var_08 = self getanimentrycount(var_05);
		var_06 = randomint(var_08);
	}
	else if(isdefined(param_03) && param_03 == "iw5_linegundamagezm_mp")
	{
		if(abs(var_08) < 45)
		{
			var_06 = "pain_knockback_front";
		}
		else if(abs(var_08) > 135)
		{
			var_06 = "pain_knockback_back";
		}
		else if(var_08 > 0)
		{
			var_06 = "pain_knockback_right";
		}
		else
		{
			var_06 = "pain_knockback_left";
		}

		var_08 = self getanimentrycount(var_06);
		var_06 = randomint(var_08);
	}
	else
	{
		var_08 = self getanimentrycount(var_06);
		var_06 = maps\mp\agents\humanoid\_humanoid_util::getpainangleindexvariable(var_07,var_08);
	}

	self scragentsetanimmode("anim deltas");
	self scragentsetorientmode("face angle abs",self.angles);
	maps\mp\agents\_scripted_agent_anim_util::playanimnatrateuntilnotetrack_safe(var_05,var_06,self.nonmoveratescale,"pain_anim");
	maps\mp\agents\_scripted_agent_anim_util::setstatelocked(0,"DoStopHitReaction");
	self.inpain = undefined;
	self scragentsetscripted(0);
}

//Function Number: 14
ondamage(param_00,param_01,param_02,param_03,param_04,param_05,param_06,param_07,param_08,param_09)
{
	self.timeoflastdamage = gettime();
	if(isdefined(self.owner))
	{
		self.damagedownertome = vectornormalize(self.origin - self.owner.origin);
	}

	if(shouldplaystophitreaction(param_02,param_05,param_04,param_08))
	{
		thread dostophitreaction(maps\mp\agents\humanoid\_humanoid_util::damagehitangle(param_06,param_07),param_08,param_05,param_04,param_02);
		return;
	}

	if(isdefined(self.animcbs.ondamage[self.aistate]))
	{
		self [[ self.animcbs.ondamage[self.aistate] ]](param_00,param_01,param_02,param_03,param_04,param_05,param_06,param_07,param_08,param_09);
	}
}

//Function Number: 15
shouldplaystophitreaction(param_00,param_01,param_02,param_03)
{
	if(isdefined(param_01) && maps\mp\zombies\_util::iszombiednagrenade(param_01) || param_01 == "trap_zm_mp" || param_01 == "zombie_water_trap_mp")
	{
		return 0;
	}

	if(maps\mp\agents\_scripted_agent_anim_util::isstatelocked())
	{
		return 0;
	}

	if(self.aistate == "traverse")
	{
		return 0;
	}

	if(isdefined(param_03) && param_03 == "head" && !isdefined(self.lastheadshot) || gettime() - self.lastheadshot > 10000)
	{
		if(!maps\mp\zombies\_util::is_true(self.noheadshotpainreaction))
		{
			self.lastheadshot = gettime();
			return 1;
		}
	}

	if(shouldboostslamhitreaction(param_01))
	{
		return 1;
	}

	if(shouldrepulsorhitreaction(param_01) && param_00 < self.health)
	{
		return 1;
	}

	if(shouldlinegunhitreaction(param_01) && param_00 < self.health)
	{
		return 1;
	}

	if(!maps\mp\zombies\_zombies::shouldplayhitreactionpainsensor())
	{
		return 0;
	}

	if(isdefined(param_01) && weaponclass(param_01) == "sniper")
	{
		return 1;
	}

	if(isdefined(param_02) && isexplosivedamagemod(param_02) && param_00 >= 10)
	{
		return 1;
	}

	if(isdefined(param_02) && param_02 == "MOD_MELEE")
	{
		return 1;
	}

	if(isdefined(param_01) && param_01 == "concussion_grenade_mp")
	{
		return 1;
	}

	if(isdefined(self.shouldplaystophitreactionfunc) && [[ self.shouldplaystophitreactionfunc ]]())
	{
		return 1;
	}

	return 0;
}

//Function Number: 16
shouldboostslamhitreaction(param_00)
{
	if(maps\mp\zombies\_util::nohitreactions())
	{
		return 0;
	}

	if(isdefined(param_00) && param_00 == "boost_slam_mp")
	{
		return 1;
	}

	return 0;
}

//Function Number: 17
shouldrepulsorhitreaction(param_00)
{
	if(maps\mp\zombies\_util::nohitreactions())
	{
		return 0;
	}

	if(isdefined(param_00) && param_00 == "repulsor_zombie_mp")
	{
		return 1;
	}

	return 0;
}

//Function Number: 18
shouldlinegunhitreaction(param_00)
{
	if(maps\mp\zombies\_util::nohitreactions())
	{
		return 0;
	}

	if(isdefined(param_00) && param_00 == "iw5_linegundamagezm_mp")
	{
		return 1;
	}

	return 0;
}

//Function Number: 19
monitorflash()
{
	self endon("death");
	for(;;)
	{
		self waittill("flashbang",var_00,var_01,var_02,var_03,var_04,var_05);
		if(isdefined(var_03) && var_03 == self.owner)
		{
			continue;
		}

		if(!maps\mp\agents\_scripted_agent_anim_util::isstatelocked())
		{
			onflashbanged();
		}
	}
}

//Function Number: 20
onflashbanged(param_00,param_01,param_02,param_03,param_04,param_05)
{
	dostophitreaction(self.angles[1] + 180);
}