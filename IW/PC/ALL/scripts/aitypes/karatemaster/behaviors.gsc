/*******************************************************************
 * Decompiled By: Bog
 * Decompiled File: scripts\aitypes\karatemaster\behaviors.gsc
 * Game: Call of Duty: Infinite Warfare
 * Platform: PC
 * Function Count: 30
 * Decompile Time: 1198 ms
 * Timestamp: 10/26/2023 11:58:48 PM
*******************************************************************/

//Function Number: 1
init(param_00)
{
	var_01 = gettime();
	self.var_3135.nextteleporttime = var_01 + 1000;
	self.var_3135.lastflyingkicktime = 0;
	self.var_3135.var_AA2C = var_01;
	return level.var_111AE;
}

//Function Number: 2
pickdesiredmeleeanimindex(param_00)
{
	var_01 = param_00 + "_melee";
	if(isdefined(level.karatemastermeleedist[var_01]))
	{
		var_02 = scripts\mp\agents\karatemaster\karatemaster_agent::getenemy();
		if(isdefined(var_02))
		{
			var_03 = [];
			var_04 = distance2dsquared(self.origin,var_02.origin);
			for(var_05 = 0;var_05 < level.karatemastermeleedist[var_01].size;var_05++)
			{
				var_06 = level.karatemastermeleedist[var_01][var_05];
				if(var_06 * var_06 < var_04)
				{
					var_03[var_03.size] = var_05;
					continue;
				}

				break;
			}

			var_05 = 0;
			if(var_03.size > 0)
			{
				var_07 = randomint(var_03.size);
				var_05 = var_03[var_07];
				self.desiredmovemeleeindex[var_01] = var_05;
			}

			self.desiredmovemeleedist = level.karatemastermeleedist[var_01][var_05] + scripts\mp\agents\karatemaster\karatemaster_tunedata::gettunedata().cwiggleroom;
			self.desiredmovemeleetimetoimpact = level.karatemastermeleetimetoimpact[var_01][var_05];
		}

		self.lastdesiredmovemeleetime = gettime();
	}
}

//Function Number: 3
pickbetterenemy(param_00,param_01)
{
	var_02 = self method_805F(param_00);
	var_03 = self method_805F(param_01);
	if(var_02 != var_03)
	{
		if(var_02)
		{
			return param_00;
		}

		return param_01;
	}

	var_04 = distancesquared(self.origin,param_00.origin);
	var_05 = distancesquared(self.origin,param_01.origin);
	if(var_04 < var_05)
	{
		return param_00;
	}

	return param_01;
}

//Function Number: 4
shouldignoreenemy(param_00)
{
	if(!isalive(param_00))
	{
		return 1;
	}

	if(param_00.ignoreme || isdefined(param_00.var_222) && param_00.var_222.ignoreme)
	{
		return 1;
	}

	if(lib_0F74::func_1002C(param_00))
	{
		return 1;
	}

	return 0;
}

//Function Number: 5
func_12E8A()
{
	if(isdefined(self.myenemy) && !shouldignoreenemy(self.myenemy))
	{
		if(gettime() - self.myenemystarttime < 3000)
		{
			return self.myenemy;
		}
	}

	var_00 = undefined;
	foreach(var_02 in level.players)
	{
		if(shouldignoreenemy(var_02))
		{
			continue;
		}

		if(scripts\common\utility::istrue(var_02.isfasttravelling))
		{
			continue;
		}

		if(!isdefined(var_00))
		{
			var_00 = var_02;
			continue;
		}

		var_00 = pickbetterenemy(var_00,var_02);
	}

	if(!isdefined(var_00))
	{
		self.myenemy = undefined;
		return undefined;
	}

	if(!isdefined(self.myenemy) || var_00 != self.myenemy)
	{
		self.myenemy = var_00;
		self.myenemystarttime = gettime();
	}
}

//Function Number: 6
updateeveryframe(param_00)
{
	lib_0A1B::func_2968(self.desiredmovemode);
	func_12E8A();
	if(!isdefined(self.desiredmovemeleeindex[self.desiredmovemode]))
	{
		pickdesiredmeleeanimindex(self.desiredmovemode);
	}

	return level.var_6AD5;
}

//Function Number: 7
candostandmelee()
{
	if(isdefined(self.var_233))
	{
		return 0;
	}

	return 1;
}

//Function Number: 8
getmovemeleedistsq()
{
	if(isdefined(self.desiredmovemeleedist))
	{
		return self.desiredmovemeleedist * self.desiredmovemeleedist;
	}

	return scripts\mp\agents\karatemaster\karatemaster_tunedata::gettunedata().cmeleemaxstanddistsq;
}

//Function Number: 9
getpredictedenemypos()
{
	var_00 = scripts\mp\agents\karatemaster\karatemaster_agent::getenemy();
	var_01 = var_00 getvelocity();
	var_02 = length2d(var_01);
	var_03 = self.desiredmovemeleetimetoimpact;
	var_04 = var_00.origin + var_01 * var_03;
	return var_04;
}

//Function Number: 10
getstandmeleeattackswithinrange(param_00,param_01)
{
	var_02 = [];
	var_03 = scripts\mp\agents\karatemaster\karatemaster_tunedata::gettunedata();
	for(var_04 = level.karatemastermeleedist["stand_melee"].size - 1;var_04 >= 0;var_04--)
	{
		var_05 = param_00 + param_01 * level.karatemastermeleetimetoimpact["stand_melee"][var_04];
		var_06 = distance2d(var_05,self.origin);
		if(var_06 > level.karatemastermeleedist["stand_melee"][var_04] + var_03.cstandattackwiggleroom)
		{
			break;
		}

		var_02[var_02.size] = var_04;
	}

	if(var_02.size == 0)
	{
		return undefined;
	}

	return var_02;
}

//Function Number: 11
pickstandmeleeattack(param_00)
{
	var_01 = getstandmeleeattackswithinrange(param_00.origin,param_00 getvelocity());
	if(!isdefined(var_01))
	{
		return 0;
	}

	var_02 = randomint(var_01.size);
	var_03 = var_01[var_02];
	self.desiredmovemeleeindex["stand_melee"] = var_03;
	self.desiredmovemeleedist = level.karatemastermeleedist["stand_melee"][var_03] + scripts\mp\agents\karatemaster\karatemaster_tunedata::gettunedata().cwiggleroom;
	self.desiredmovemeleetimetoimpact = level.karatemastermeleetimetoimpact["stand_melee"][var_03];
	self.var_1198.meleetype = "stand_melee";
	return 1;
}

//Function Number: 12
func_10039(param_00)
{
	var_01 = scripts\mp\agents\karatemaster\karatemaster_agent::getenemy();
	if(!isdefined(var_01))
	{
		return level.var_6AD5;
	}

	if(abs(var_01.origin[2] - self.origin[2]) > scripts\mp\agents\karatemaster\karatemaster_tunedata::gettunedata().cmeleemaxzdiff)
	{
		return level.var_6AD5;
	}

	if(candostandmelee())
	{
		if(!pickstandmeleeattack(var_01))
		{
			return level.var_6AD5;
		}

		return level.var_111AE;
	}

	var_02 = scripts\mp\agents\karatemaster\karatemaster_tunedata::gettunedata();
	var_03 = var_01.origin;
	if(isdefined(self.var_233))
	{
		var_03 = getpredictedenemypos();
	}

	if(gettime() > self.lastdesiredmovemeleetime + var_02.crethinkmovemeleetime)
	{
		pickdesiredmeleeanimindex(self.desiredmovemode);
	}

	var_04 = distance2dsquared(var_03,self.origin);
	if(var_04 > getmovemeleedistsq())
	{
		return level.var_6AD5;
	}

	var_05 = self method_84AC();
	var_06 = getclosestpointonnavmesh(var_01.origin,self);
	if(!navisstraightlinereachable(var_05,var_06,self))
	{
		return level.var_6AD5;
	}

	self.var_1198.meleetype = self.desiredmovemode + "_melee";
	return level.var_111AE;
}

//Function Number: 13
func_B599(param_00)
{
	var_01 = scripts\mp\agents\karatemaster\karatemaster_agent::getenemy();
	self.var_3135.var_9928[param_00] = spawnstruct();
	self.var_3135.var_9928[param_00].var_B64D = var_01;
	self.var_3135.var_9928[param_00].var_10DFF = gettime();
	self.var_1198.bmeleerequested = 1;
	self.var_1198.var_B64D = var_01;
	self.var_4B26 = var_01;
}

//Function Number: 14
func_5902(param_00)
{
	var_01 = 5000;
	if(gettime() > self.var_3135.var_9928[param_00].var_10DFF + var_01)
	{
		return level.var_6AD5;
	}

	if(lib_0A1A::func_232A("melee_anim","end"))
	{
		return level.var_111AE;
	}

	self method_8286(self.origin);
	self method_8287(36);
	return level.var_E87A;
}

//Function Number: 15
melee_cleanup(param_00)
{
	self.var_3135.var_9928[param_00] = undefined;
	self.var_1198.bmeleerequested = undefined;
	self.var_1198.var_B64D = undefined;
	self.var_1198.meleetype = undefined;
	var_01 = scripts\mp\agents\karatemaster\karatemaster_tunedata::gettunedata();
	var_02 = gettime() + var_01.cminteleportwaittimeaftermelee;
	if(!isdefined(self.var_3135.nextteleporttime) || self.var_3135.nextteleporttime <= var_02)
	{
		self.var_3135.nextteleporttime = var_02;
	}

	pickdesiredmeleeanimindex(self.desiredmovemode);
}

//Function Number: 16
ispositiontooclosetoaplayer(param_00)
{
	foreach(var_02 in level.players)
	{
		var_03 = abs(var_02.origin[2] - param_00[2]);
		if(var_03 > 128)
		{
			continue;
		}

		var_04 = distancesquared(param_00,var_02.origin);
		if(var_04 < 10000)
		{
			return 1;
		}
	}

	return 0;
}

//Function Number: 17
findteleportspotinfrontofsprinter(param_00,param_01)
{
	var_02 = param_00.angles[1];
	var_03 = param_00.angles;
	var_04 = undefined;
	for(var_05 = 0;var_05 < 5;var_05++)
	{
		var_06 = randomintrange(param_01.csprinterteleportminangledelta,param_01.csprinterteleportmaxangledelta);
		if(randomint(100) < 50)
		{
			var_06 = var_06 * -1;
		}

		var_07 = randomfloatrange(param_01.csprinterteleportmindist,param_01.csprinterteleportmaxdist);
		var_08 = angleclamp180(var_03[1] + var_06);
		var_09 = anglestoforward((0,var_08,0));
		var_0A = param_00.origin + var_09 * var_07;
		var_04 = getclosestpointonnavmesh(var_0A,self);
		if(ispositiontooclosetoaplayer(var_04))
		{
			var_04 = undefined;
			continue;
		}

		if(navisstraightlinereachable(var_04,param_00.origin))
		{
			break;
		}

		var_04 = undefined;
	}

	if(!isdefined(var_04))
	{
		return undefined;
	}

	var_0B = self method_8428(var_04,param_00.origin,0,0,"seeker");
	if(!isdefined(var_0B) || var_0B.size < 2)
	{
		self.var_3135.nextteleporttime = gettime() + 150;
		return undefined;
	}

	var_0C = getgroundposition(var_04,8);
	if(abs(var_0C[2] - var_04[2]) > 60)
	{
		return undefined;
	}

	return var_0C;
}

//Function Number: 18
findteleportspotinenemyview(param_00,param_01)
{
	var_02 = param_00.angles[1];
	var_03 = param_00.angles;
	var_04 = param_00.origin + param_00 getvelocity() * 0.5;
	var_05 = distance(self.origin,var_04);
	var_06 = undefined;
	for(var_07 = 0;var_07 < 4;var_07++)
	{
		var_08 = randomintrange(param_01.cfastteleportminangledelta,param_01.cfastteleportmaxangledelta);
		if(randomint(100) < 50)
		{
			var_08 = var_08 * -1;
		}

		var_09 = randomfloatrange(param_01.cfastteleportcloseindistpctmin,param_01.cfastteleportcloseindistpctmax);
		var_0A = var_05 * var_09;
		if(var_0A < param_01.cfastteleportmindisttoenemytoteleport)
		{
			var_0A = param_01.cfastteleportmindisttoenemytoteleport;
		}

		var_0B = angleclamp180(var_03[1] + var_08);
		var_0C = anglestoforward((0,var_0B,0));
		var_0D = var_04 + var_0C * var_0A;
		var_06 = getclosestpointonnavmesh(var_0D,self);
		if(!isdefined(var_06))
		{
			continue;
		}

		if(ispositiontooclosetoaplayer(var_06))
		{
			var_06 = undefined;
			continue;
		}

		break;
	}

	if(!isdefined(var_06))
	{
		return undefined;
	}

	var_0E = self method_8428(var_06,param_00.origin,0,0);
	if(!isdefined(var_0E) || var_0E.size < 2)
	{
		return undefined;
	}

	var_0F = getgroundposition(var_06,8);
	if(abs(var_0F[2] - var_06[2]) > 60)
	{
		return undefined;
	}

	return var_0F;
}

//Function Number: 19
findbunchedupteleportspot(param_00,param_01)
{
	return findteleportspotinenemyview(param_00,param_01.bunchedupteleportparams);
}

//Function Number: 20
iscrowded(param_00,param_01)
{
	var_02 = scripts\mp\_mp_agent::func_7D95(self.agent_type);
	var_03 = [];
	var_04 = 0;
	foreach(var_06 in var_02)
	{
		var_07 = distancesquared(var_06.origin,self.origin);
		if(var_07 > param_01.ccrowdedradiussq)
		{
			continue;
		}

		if(!var_06 lib_0A1A::func_2354("run_loop") && !var_06 lib_0A1A::func_2354("sprint_loop") && !var_06 lib_0A1A::func_2354("walk_loop") && !var_06 lib_0A1A::func_2354("slow_walk_loop"))
		{
			continue;
		}

		if(isdefined(var_06.var_10C) && var_06.var_10C == param_00)
		{
			var_04++;
		}
	}

	if(var_04 >= param_01.ccrowdedcount)
	{
		return 1;
	}

	return 0;
}

//Function Number: 21
getfastteleportdest(param_00,param_01)
{
	if(lib_0A1A::func_2354("teleport_in"))
	{
		return undefined;
	}

	if(lib_0A1A::func_2354("teleport_out"))
	{
		return undefined;
	}

	var_02 = distance(param_00.origin,self.origin);
	if(!isdefined(self.var_233) || var_02 > param_01.cminenemydistforlongpathteleport)
	{
		if(!isdefined(self.var_233) || self method_841E() > var_02 * param_01.cfastteleportduetolongpathmultiplier)
		{
			var_03 = findteleportspotinenemyview(param_00,param_01.fastteleportparams);
			if(isdefined(var_03))
			{
				return var_03;
			}
		}
	}

	var_04 = scripts\mp\agents\karatemaster\karatemaster_agent::getdamageaccumulator();
	if(isdefined(var_04))
	{
		if(param_01.cfastteleportduetodamagechance > 0 && var_04.accumulateddamage > 0)
		{
			var_05 = var_04.accumulateddamage / self.maxhealth;
			if(var_05 >= param_01.cfastteleportdamagepct)
			{
				scripts\mp\agents\karatemaster\karatemaster_agent::cleardamageaccumulator();
				var_06 = randomint(100);
				if(var_06 < param_01.cfastteleportduetodamagechance)
				{
					self.var_1198.bfastteleport = 1;
					return findteleportspotinenemyview(param_00,param_01.fastteleportparams);
				}
			}
		}
	}

	if(param_01.ballowteleportinfrontofsprinter && param_00 method_81BD())
	{
		var_07 = param_00.origin - self.origin;
		var_08 = anglestoforward(param_00.angles);
		var_09 = vectordot(var_07,var_08);
		if(var_09 > 0)
		{
			var_0A = findteleportspotinfrontofsprinter(param_00,param_01.sprinterteleportparams);
			if(isdefined(var_0A))
			{
				self.var_1198.bfastteleport = 1;
				return var_0A;
			}
		}
	}

	if(iscrowded(param_00,param_01))
	{
		self.var_1198.bfastteleport = 1;
		if(!param_00 method_81BD())
		{
			var_0B = param_00 getvelocity();
			var_0C = length2dsquared(var_0B);
			if(var_0C > 16129)
			{
				var_07 = vectornormalize(param_00.origin - self.origin);
				var_08 = anglestoforward(param_00.angles);
				var_0D = vectordot(var_07,var_08);
				var_0E = vectornormalize(var_0B);
				var_0F = vectordot(var_08,var_0E);
				if(var_0D > param_01.cplayerfacingawayfrommedot && var_0F > 0.9)
				{
					var_0A = findteleportspotinfrontofsprinter(param_00,param_01.runnerteleportparams);
					if(isdefined(var_0A))
					{
						self.var_1198.bfastteleport = 1;
						return var_0A;
					}
				}
			}
		}

		return findbunchedupteleportspot(param_00,param_01);
	}

	return undefined;
}

//Function Number: 22
shouldteleport(param_00)
{
	if(scripts\common\utility::istrue(self.bdisableteleport))
	{
		return level.var_6AD5;
	}

	var_01 = scripts\mp\agents\karatemaster\karatemaster_agent::getenemy();
	if(!isdefined(var_01))
	{
		return level.var_6AD5;
	}

	if(gettime() < self.var_3135.nextteleporttime)
	{
		return level.var_6AD5;
	}

	var_02 = scripts\mp\agents\karatemaster\karatemaster_tunedata::gettunedata();
	if(!isdefined(level.last_karatemaster_teleport_time))
	{
		level.last_karatemaster_teleport_time = gettime();
	}
	else if(gettime() - level.last_karatemaster_teleport_time < var_02.cteleportmintimebetween_global)
	{
		return level.var_6AD5;
	}

	if(isdefined(self.var_233))
	{
		var_03 = self method_841E();
		var_04 = self method_84F9(var_03);
		if(isdefined(var_04))
		{
			var_05 = var_04["node"];
			var_06 = var_04["position"];
			var_07 = var_05.var_48;
			if(isdefined(var_07))
			{
				var_08 = self.var_238F;
				var_09 = level.var_2303[var_08];
				var_0A = var_09.var_10E2F[var_07];
				if(!isdefined(var_0A))
				{
					var_07 = "traverse_external";
				}

				if(var_07 == "traverse_external")
				{
					self.initialteleportpos = var_06;
					self.btraversalteleport = 1;
					level.last_karatemaster_teleport_time = gettime();
					return level.var_111AE;
				}
			}
		}
	}

	if(scripts\common\utility::istrue(self.var_9CEC))
	{
		return level.var_6AD5;
	}

	self.initialteleportpos = getfastteleportdest(var_01,var_02);
	if(isdefined(self.initialteleportpos))
	{
		level.last_karatemaster_teleport_time = gettime();
		return level.var_111AE;
	}

	return level.var_6AD5;
}

//Function Number: 23
teleport_init(param_00)
{
	self.var_3135.var_9928[param_00] = spawnstruct();
	self.var_3135.var_9928[param_00].var_10DFF = gettime();
	if(scripts\common\utility::istrue(self.var_1198.bfastteleport) || scripts\common\utility::istrue(self.btraversalteleport))
	{
		var_01 = self.initialteleportpos;
	}
	else
	{
		var_01 = scripts\mp\agents\karatemaster\karatemaster_agent::findgoodteleportcloserspot();
	}

	self.var_3135.var_9928[param_00].teleportspot = var_01;
	if(isdefined(var_01))
	{
		self.var_1198.bteleportrequested = 1;
		self.var_1198.teleportspot = var_01;
	}

	self method_841F();
}

//Function Number: 24
doteleport(param_00)
{
	if(!isdefined(self.var_3135.var_9928[param_00].teleportspot))
	{
		return level.var_6AD5;
	}

	var_01 = 10000;
	if(gettime() > self.var_3135.var_9928[param_00].var_10DFF + var_01)
	{
		return level.var_6AD5;
	}

	if(lib_0A1A::func_232A("teleport_anim","end"))
	{
		self.var_3135.nextteleporttime = gettime() + scripts\mp\agents\karatemaster\karatemaster_tunedata::gettunedata().cteleportmintimebetween;
		return level.var_111AE;
	}

	return level.var_E87A;
}

//Function Number: 25
teleport_cleanup(param_00)
{
	self.var_3135.var_9928[param_00] = undefined;
	self.var_1198.bteleportrequested = undefined;
	self.var_1198.teleportspot = undefined;
}

//Function Number: 26
followenemy_begin(param_00)
{
	self.var_3135.var_9928[param_00] = gettime();
}

//Function Number: 27
findclosestenemy()
{
	var_00 = 99999999;
	var_01 = undefined;
	foreach(var_03 in level.players)
	{
		if(!isalive(var_03))
		{
			continue;
		}

		if(var_03.ignoreme || isdefined(var_03.var_222) && var_03.var_222.ignoreme)
		{
			continue;
		}

		if(lib_0F74::func_1002C(var_03))
		{
			continue;
		}

		var_04 = distancesquared(self.origin,var_03.origin);
		if(!isdefined(var_01) || var_04 < var_00)
		{
			var_01 = var_03;
			var_00 = var_04;
		}
	}

	return var_01;
}

//Function Number: 28
followenemy_tick(param_00)
{
	var_01 = scripts\mp\agents\karatemaster\karatemaster_agent::getenemy();
	if(!isdefined(var_01))
	{
		var_01 = findclosestenemy();
	}

	if(!isdefined(var_01))
	{
		return level.var_6AD5;
	}

	var_02 = gettime();
	if(var_02 >= self.var_3135.var_9928[param_00] || distancesquared(self.origin,var_01.origin) < 10000)
	{
		var_03 = getclosestpointonnavmesh(var_01.origin,self);
		self method_8286(var_03);
		self.var_3135.var_9928[param_00] = var_02 + 200;
	}

	return level.var_E87A;
}

//Function Number: 29
followenemy_end(param_00)
{
	self.var_3135.var_9928[param_00] = undefined;
}

//Function Number: 30
spawnkaratemaster(param_00)
{
	param_00 endon("death");
}