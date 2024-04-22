/*******************************************************************
 * Decompiled By: Bog
 * Decompiled File: mp\agents\humanoid\_humanoid_util.gsc
 * Game: Call of Duty: Advanced Warfare
 * Platform: PC
 * Function Count: 52
 * Decompile Time: 780 ms
 * Timestamp: 4/22/2024 2:08:15 AM
*******************************************************************/

//Function Number: 1
canhumanoidmovepointtopoint(param_00,param_01,param_02)
{
	if(!isdefined(param_02))
	{
		param_02 = 6;
	}

	var_03 = (0,0,1) * param_02;
	var_04 = param_00 + var_03;
	var_05 = param_01 + var_03;
	return capsuletracepassed(var_04,self.radius,self.height - param_02,self,1,0,0,var_05);
}

//Function Number: 2
getnummeleesectors()
{
	return 8;
}

//Function Number: 3
getmeleeanglestep()
{
	return 360 / getnummeleesectors();
}

//Function Number: 4
meleesectortargetposition(param_00,param_01,param_02)
{
	var_03 = param_01 * getmeleeanglestep() - 180;
	var_04 = param_00 + anglestoforward((0,var_03,0)) * param_02;
	return var_04;
}

//Function Number: 5
getmeleesectors(param_00)
{
	return self.meleesectors[param_00];
}

//Function Number: 6
validatemeleesectors(param_00)
{
	if(!isdefined(self.meleesectors))
	{
		self.meleesectors = [];
	}

	if(!isdefined(self.meleesectors[param_00]))
	{
		self.meleesectors[param_00] = [];
		for(var_01 = 0;var_01 < getnummeleesectors();var_01++)
		{
			self.meleesectors[param_00][var_01] = spawnstruct();
			self.meleesectors[param_00][var_01].timestamp = 0;
			self.meleesectors[param_00][var_01].claimer = undefined;
			self.meleesectors[param_00][var_01].origin = undefined;
			self.meleesectors[param_00][var_01].num = var_01;
		}
	}
}

//Function Number: 7
getoriginformeleesectors(param_00)
{
	var_01 = param_00.origin;
	if(isdefined(param_00.groundpos))
	{
		var_01 = param_00.groundpos;
		if(isdefined(self.distractiondrone) && param_00 == self.distractiondrone && hascalculatednearestnodetounreachabledrone())
		{
			var_02 = getnearestnodetounreachabledrone();
			if(isdefined(var_02))
			{
				var_01 = var_02.origin;
			}
		}
	}
	else if(isplayer(param_00) && param_00 isjumping() || param_00 ishighjumping())
	{
		if(!isdefined(param_00.playergroundpostime))
		{
			param_00.playergroundpostime = 0;
		}

		if(gettime() > param_00.playergroundpostime)
		{
			param_00.playergroundpos = getgroundposition(param_00.origin,15);
			param_00.playergroundpostime = gettime();
		}

		if(isdefined(param_00.playergroundpos))
		{
			var_01 = param_00.playergroundpos;
		}
	}

	return var_01;
}

//Function Number: 8
hasvalidmeleesectorsfortype(param_00,param_01)
{
	for(var_02 = 0;var_02 < getnummeleesectors();var_02++)
	{
		var_03 = param_00 getmeleesectors(param_01);
		var_04 = var_03[var_02];
		if(isdefined(var_04.origin))
		{
			return 1;
		}
	}

	return 0;
}

//Function Number: 9
calculatenearestnodetounreachabledrone()
{
	var_00 = self getnearestnode();
	if(isdefined(var_00))
	{
		var_01 = nodegetsplitgroup(var_00);
		if(!isdefined(self.distractiondrone.nearestnodeforgroup))
		{
			self.distractiondrone.nearestnodeforgroup = [];
		}

		var_02 = 0;
		var_03 = 500;
		var_04 = undefined;
		var_05 = undefined;
		while(!isdefined(var_04) && var_03 <= 1500)
		{
			var_06 = [];
			if(isdefined(level.nearestnodetounreachabledronesearchheight))
			{
				var_06 = getnodesinradiussorted(self.distractiondrone.groundpos,var_03,var_02,level.nearestnodetounreachabledronesearchheight);
			}
			else
			{
				var_06 = getnodesinradiussorted(self.distractiondrone.groundpos,var_03,var_02);
			}

			var_07 = undefined;
			foreach(var_09 in var_06)
			{
				if(nodegetsplitgroup(var_09) == var_01)
				{
					if(!isdefined(var_07) || nodesvisible(var_09,var_07,1))
					{
						var_04 = var_09;
						break;
					}
					else if(!isdefined(var_05))
					{
						var_05 = var_09;
					}
				}
			}

			var_02 = var_03;
			var_03 = var_03 + 500;
		}

		if(isdefined(var_04))
		{
			self.distractiondrone.nearestnodeforgroup[var_01] = var_04;
			return;
		}

		if(isdefined(var_05))
		{
			self.distractiondrone.nearestnodeforgroup[var_01] = var_05;
			return;
		}

		self.distractiondrone.nearestnodeforgroup[var_01] = 0;
		return;
	}
}

//Function Number: 10
hascalculatednearestnodetounreachabledrone()
{
	var_00 = self getnearestnode();
	if(isdefined(var_00) && isdefined(self.distractiondrone.nearestnodeforgroup))
	{
		var_01 = self.distractiondrone.nearestnodeforgroup[nodegetsplitgroup(var_00)];
		if(isdefined(var_01))
		{
			return 1;
		}
	}

	return 0;
}

//Function Number: 11
getnearestnodetounreachabledrone()
{
	var_00 = self getnearestnode();
	var_01 = self.distractiondrone.nearestnodeforgroup[nodegetsplitgroup(var_00)];
	if(!isnumber(var_01))
	{
		return var_01;
	}

	return undefined;
}

//Function Number: 12
shouldtargetdistractiondrone()
{
	if(hascalculatednearestnodetounreachabledrone())
	{
		var_00 = getnearestnodetounreachabledrone();
		if(!isdefined(var_00))
		{
			return 0;
		}
	}

	return 1;
}

//Function Number: 13
isentunreachabledrone(param_00)
{
	if(isdefined(self.distractiondrone) && param_00 == self.distractiondrone)
	{
		if(self.distractiondronebadpathcount > 5)
		{
			return 1;
		}
	}

	return 0;
}

//Function Number: 14
getmeleetargetpoint(param_00,param_01)
{
	param_00 validatemeleesectors(self.meleesectortype);
	var_02 = param_00 getmeleesectors(self.meleesectortype);
	var_04 = param_01;
	var_05 = self.origin - var_04;
	var_06 = lengthsquared(var_05);
	if(var_06 < 256)
	{
		var_07 = -1;
		for(var_08 = 0;var_08 < getnummeleesectors();var_08++)
		{
			var_09 = var_02[var_08];
			if(isdefined(var_09.claimer) && var_09.claimer == self)
			{
				var_07 = var_09.num;
			}
		}

		if(var_07 < 0)
		{
			var_07 = self getentitynumber() % getnummeleesectors();
		}

		var_0A = var_07;
	}
	else
	{
		var_0B = angleclamp180(vectortoyaw(var_07)) + 180;
		var_0A = var_0B / getmeleeanglestep();
		var_07 = int(var_0A + 0.5);
	}

	var_0C = undefined;
	var_0D = -1;
	var_0E = 3;
	var_0F = 2;
	if(var_0A > var_07)
	{
		var_0D = var_0D * -1;
		var_0E = var_0E * -1;
		var_0F = var_0F * -1;
	}

	var_10 = getnummeleesectors();
	for(var_11 = 0;var_11 < var_10 / 2 + 1;var_11++)
	{
		for(var_12 = var_0D;var_12 != var_0E;var_12 = var_12 + var_0F)
		{
			var_13 = var_07 + var_11 * var_12;
			if(var_13 >= var_10)
			{
				var_13 = var_13 - var_10;
			}
			else if(var_13 < 0)
			{
				var_13 = var_13 + var_10;
			}

			var_09 = var_02[var_13];
			if(!isdefined(var_0C) && gettime() - var_09.timestamp >= self.meleesectorupdatetime)
			{
				if(isdefined(level.trycalculatesectororigin) && isdefined(level.trycalculatesectororigin[self.agent_type]))
				{
					[[ level.trycalculatesectororigin[self.agent_type] ]](var_09,var_04,self.attackoffset,self.radius);
				}
				else
				{
					trycalculatesectororigin(var_09,var_04,self.attackoffset,self.radius);
				}
			}

			if(!isdefined(var_0C) && isdefined(var_09.origin))
			{
				var_14 = 0;
				if(isdefined(var_09.claimer) && var_09.claimer != self)
				{
					var_15 = vectornormalize(var_04 - var_09.claimer.origin) * self.radius * 2;
					var_14 = distancesquared(var_09.claimer.origin + var_15,var_04);
				}

				if(!isalive(var_09.claimer) || !isdefined(var_09.claimer.curmeleetarget) || var_09.claimer.curmeleetarget != param_00 || var_09.claimer == self || var_06 < var_14)
				{
					if(isalive(var_09.claimer) && var_09.claimer != self)
					{
						var_09.claimer notify("lostSectorClaim");
						var_09.claimer.sector_claimed = undefined;
					}

					if(isdefined(self.sector_claimed) && self.sector_claimed != var_09)
					{
						self.sector_claimed.claimer = undefined;
					}

					self.sector_claimed = var_09;
					var_09.claimer = self;
					var_0C = var_09.origin;
					thread monitorsectorclaim(var_09);
				}
			}

			if(var_11 == 0)
			{
				break;
			}
		}
	}

	return var_0C;
}

//Function Number: 15
monitorsectorclaim(param_00)
{
	level endon("game_ended");
	self notify("monitorSectorClaim");
	self endon("monitorSectorClaim");
	self endon("lostSectorClaim");
	common_scripts\utility::waittill_any("death","disconnect");
	param_00.claimer = undefined;
}

//Function Number: 16
trycalculatesectororigin(param_00,param_01,param_02,param_03)
{
	if(gettime() - param_00.timestamp >= 50)
	{
		param_00.origin = meleesectortargetposition(param_01,param_00.num,param_02);
		param_00.origin = dropsectorpostoground(param_00.origin,param_03,55);
		param_00.timestamp = gettime();
	}
}

//Function Number: 17
dropsectorpostoground(param_00,param_01,param_02,param_03)
{
	if(!isdefined(param_03))
	{
		param_03 = 18;
	}

	var_04 = param_00 + (0,0,param_03);
	var_05 = param_00 + (0,0,param_03 * -1);
	var_06 = self aiphysicstrace(var_04,var_05,param_01,param_02,1);
	if(abs(var_06[2] - var_04[2]) < 0.1)
	{
		return undefined;
	}

	if(abs(var_06[2] - var_05[2]) < 0.1)
	{
		return undefined;
	}

	return var_06;
}

//Function Number: 18
iscrawling()
{
	return isdefined(self.dismember_crawl) && self.dismember_crawl;
}

//Function Number: 19
getmeleeradius()
{
	if(!isdefined(self.lungemeleeenabled) || self.lungemeleeenabled)
	{
		return self.meleeradius;
	}

	return self.meleeradiusbase;
}

//Function Number: 20
getmeleeradiussq()
{
	if(!isdefined(self.lungemeleeenabled) || self.lungemeleeenabled)
	{
		return self.meleeradiussq;
	}

	return self.meleeradiusbasesq;
}

//Function Number: 21
lungemeleeupdate(param_00,param_01,param_02,param_03,param_04,param_05,param_06)
{
	self.lungedebouncems = param_00 * 1000;
	self.lungefx = param_04;
	self.lungeanimstate = param_03;
	self.lungeanimratescale = isdefined(param_05) && param_05;
	self.lungelerprange = param_06;
	self.lungeminrange = param_02;
	self.lungeminrangesq = squared(self.lungeminrange);
	maps\mp\zombies\_util::setmeleeradius(param_01);
}

//Function Number: 22
lungemeleeenable()
{
	if(isdefined(self.disabledlungerefcount) && self.disabledlungerefcount > 0)
	{
		self.disabledlungerefcount--;
		if(self.disabledlungerefcount > 0)
		{
			return;
		}
	}

	self.lungemeleeenabled = 1;
}

//Function Number: 23
lungemeleedisable()
{
	if(!isdefined(self.disabledlungerefcount))
	{
		self.disabledlungerefcount = 0;
	}

	self.disabledlungerefcount++;
	self.lungemeleeenabled = 0;
}

//Function Number: 24
dodgeupdate(param_00,param_01,param_02,param_03)
{
	self.dodgedebouncems = param_00 * 1000;
	self.dodgechance = param_01;
	self.dodgeanimstate = param_02;
	self.dodge_dirs = ["back","right","left"];
	self.dodge_fx = [];
	foreach(var_06, var_05 in self.dodge_dirs)
	{
		self.dodge_fx[var_06] = level._effect[param_03 + var_05];
	}
}

//Function Number: 25
dodgeenable()
{
	if(isdefined(self.disableddodgerefcount) && self.disableddodgerefcount > 0)
	{
		self.disableddodgerefcount--;
		if(self.disableddodgerefcount > 0)
		{
			return;
		}
	}

	self.dodgeenabled = 1;
}

//Function Number: 26
dodgedisable()
{
	if(!isdefined(self.disableddodgerefcount))
	{
		self.disableddodgerefcount = 0;
	}

	self.disableddodgerefcount++;
	self.dodgeenabled = 0;
}

//Function Number: 27
leapupdate(param_00,param_01,param_02,param_03,param_04,param_05,param_06)
{
	self.leapdebouncems = param_00 * 1000;
	self.leapchecktimems = param_01 * 1000;
	self.leapchance = param_02;
	self.leapmaxrange = param_03;
	self.leapmaxrangesq = squared(self.leapmaxrange);
	self.leapminrange = param_04;
	self.leapminrangesq = squared(self.leapminrange);
	self.leapfx = param_06;
	self.leapanimstate = param_05;
	self.leaplastcheck = 0;
	self.leaplastperform = 0;
}

//Function Number: 28
leapenable()
{
	if(isdefined(self.disabledleaprefcount) && self.disabledleaprefcount > 0)
	{
		self.disabledleaprefcount--;
		if(self.disabledleaprefcount > 0)
		{
			return;
		}
	}

	self.leapenabled = 1;
}

//Function Number: 29
leapdisable()
{
	if(!isdefined(self.disabledleaprefcount))
	{
		self.disabledleaprefcount = 0;
	}

	self.disabledleaprefcount++;
	self.leapenabled = 0;
}

//Function Number: 30
changeanimclass(param_00,param_01)
{
	self endon("death");
	self scragentsetscripted(1);
	maps\mp\agents\_scripted_agent_anim_util::setstatelocked(1,"ChangeAnimClass");
	self.inpain = 1;
	self scragentsetorientmode("face angle abs",(0,self.angles[1],0));
	self scragentsetanimmode("anim deltas");
	self scragentsetanimscale(1,1);
	maps\mp\agents\_scripted_agent_anim_util::playanimnuntilnotetrack_safe(param_01,randomint(self getanimentrycount(param_01)),"change_anim_class");
	self setanimclass(param_00);
	maps\mp\agents\_scripted_agent_anim_util::setstatelocked(0,"ChangeAnimClass");
	self.inpain = 0;
	self scragentsetscripted(0);
}

//Function Number: 31
scriptedanimation(param_00,param_01,param_02,param_03,param_04,param_05)
{
	self endon("death");
	if(!isdefined(param_05))
	{
		param_05 = 0;
	}

	var_06 = self getanimentrycount(param_02);
	param_03 = isdefined(param_03) && param_03;
	if(isdefined(var_06) && var_06 > 0)
	{
		self scragentsetscripted(1);
		maps\mp\agents\_scripted_agent_anim_util::setstatelocked(1,"ScriptedAnimation");
		if(param_03)
		{
			self.inspawnanim = 1;
		}

		self scragentsetanimmode("anim deltas");
		self scragentsetorientmode("face angle abs",param_01);
		self scragentsetanimscale(1,1);
		self scragentsetphysicsmode("noclip");
		var_06 = self getanimentrycount(param_02);
		var_07 = randomint(var_06);
		if(!param_05)
		{
			lerptoendonground(param_02,var_07);
		}

		self.origin = param_00;
		self.angles = param_01;
		maps\mp\agents\_scripted_agent_anim_util::playanimnuntilnotetrack_safe(param_02,var_07,"scripted_anim","end",param_04);
		maps\mp\agents\_scripted_agent_anim_util::setstatelocked(0,"ScriptedAnimation");
		if(param_03)
		{
			self.inspawnanim = undefined;
			self.hastraversed = 1;
		}

		self scragentsetscripted(0);
	}
}

//Function Number: 32
lerptoendonground(param_00,param_01)
{
	var_02 = 2;
	var_03 = self getanimentry(param_00,param_01);
	var_04 = getlerptime(var_03);
	var_05 = getposinspaceatanimtime(var_03,var_04);
	var_06 = getverticaldeltatogroundatanimend(var_03);
	var_05 = var_05 + (0,0,var_06 + var_02);
	thread performlerp(var_05,var_04);
}

//Function Number: 33
getverticaldeltatogroundatanimend(param_00)
{
	var_01 = 50;
	var_02 = 32;
	var_03 = 72;
	var_04 = getmovedelta(param_00);
	var_04 = rotatevector(var_04,self.angles);
	var_05 = self.origin + var_04;
	var_06 = (0,0,var_01);
	var_07 = self aiphysicstrace(var_05 + var_06,var_05 - var_06,var_02,var_03);
	var_08 = var_07 - var_05;
	return var_08[2];
}

//Function Number: 34
getposinspaceatanimtime(param_00,param_01)
{
	var_02 = getanimlength(param_00);
	var_03 = param_01 / var_02;
	var_04 = getmovedelta(param_00,0,var_03);
	var_05 = rotatevector(var_04,self.angles);
	return self.origin + var_05;
}

//Function Number: 35
getlerptime(param_00)
{
	var_01 = 0.2;
	var_02 = getanimlength(param_00);
	return min(var_01,var_02);
}

//Function Number: 36
performlerp(param_00,param_01)
{
	self endon("death");
	level endon("game_ended");
	self scragentdoanimlerp(self.origin,param_00,param_01);
	wait(param_01);
	self scragentsetanimmode("anim deltas");
}

//Function Number: 37
getpainangleindexvariable(param_00,param_01)
{
	var_02 = 0;
	if(param_01 > 1)
	{
		var_03 = int(param_01 * 0.5);
		var_04 = var_03 + param_01 % 2;
		if(param_00 < 0)
		{
			var_02 = randomint(var_04);
		}
		else
		{
			var_02 = var_03 + randomint(var_04);
		}
	}

	return var_02;
}

//Function Number: 38
isentstandingonme(param_00)
{
	var_01 = self.origin[2] + self.height;
	if(param_00.origin[2] < var_01)
	{
		return 0;
	}

	var_02 = self.origin[2] + self.height + 2 * self.radius;
	if(param_00.origin[2] > var_02)
	{
		return 0;
	}

	if(isplayer(param_00))
	{
		var_03 = param_00 getvelocity()[2];
		if(abs(var_03) > 12)
		{
			return 0;
		}
	}

	var_04 = 15;
	if(isdefined(param_00.radius))
	{
		var_04 = param_00.radius;
	}

	var_05 = self.radius + var_04;
	var_05 = var_05 * var_05;
	if(distance2dsquared(self.origin,param_00.origin) > var_05)
	{
		return 0;
	}

	return 1;
}

//Function Number: 39
setfavoriteenemy(param_00)
{
	self.favoriteenemy = param_00;
	self agentsetfavoriteenemy(param_00);
}

//Function Number: 40
damagehitangle(param_00,param_01)
{
	var_02 = 0;
	if(isdefined(param_00))
	{
		var_03 = param_00 - self gettagorigin("J_SpineLower");
		var_03 = (var_03[0],var_03[1],0);
		var_04 = vectortoangles(vectornormalize(var_03));
		var_02 = var_04[1];
	}
	else if(isdefined(param_01))
	{
		var_04 = vectortoangles(param_01);
		var_02 = var_04[1] - 180;
	}

	return var_02;
}

//Function Number: 41
enable_humanoid_exo_abilities()
{
	if(isdefined(self.disabledhumanoidexoabilities) && self.disabledhumanoidexoabilities > 0)
	{
		self.disabledhumanoidexoabilities--;
		if(self.disabledhumanoidexoabilities > 0)
		{
			return;
		}
	}

	self.hashumanoidexoabilities = 1;
	enable_humanoid_exo_traverse();
	setup_humanoid_exo_combat();
	enable_humanoid_exo_combat();
}

//Function Number: 42
disable_humanoid_exo_abilities()
{
	if(!isdefined(self.disabledhumanoidexoabilities))
	{
		self.disabledhumanoidexoabilities = 0;
	}

	self.disabledhumanoidexoabilities++;
	disable_humanoid_exo_combat();
	disable_humanoid_exo_traverse();
}

//Function Number: 43
has_humanoid_exo_abilities()
{
	return maps\mp\zombies\_util::is_true(self.hashumanoidexoabilities);
}

//Function Number: 44
enable_humanoid_exo_traverse()
{
	self scragentallowboost(1);
}

//Function Number: 45
disable_humanoid_exo_traverse()
{
	self scragentallowboost(0);
}

//Function Number: 46
setup_humanoid_exo_combat()
{
	var_00 = clamp(level.wavecounter / 20,0,1);
	var_01 = maps\mp\zombies\_util::lerp(var_00,0.35,0.55);
	var_02 = maps\mp\zombies\_util::lerp(var_00,0.06,0.12);
	lungemeleeupdate(5,self.meleeradiusbase * 2,self.meleeradiusbase * 1.5,"attack_lunge_boost",level._effect["boost_lunge"]);
	dodgeupdate(5,var_01,"dodge_boost","boost_dodge_");
	leapupdate(10,2,var_02,550,350,"leap_boost",level._effect["boost_jump"]);
}

//Function Number: 47
enable_humanoid_exo_combat()
{
	lungemeleeenable();
	dodgeenable();
	leapenable();
}

//Function Number: 48
disable_humanoid_exo_combat()
{
	lungemeleedisable();
	dodgedisable();
	leapdisable();
}

//Function Number: 49
play_boost_fx(param_00)
{
	if(!isdefined(self.boostfxtag))
	{
		return;
	}

	if(self.boostfxtag != "no_boost_fx")
	{
		playfxontag(param_00,self,self.boostfxtag);
	}
}

//Function Number: 50
find_valid_pathnodes_for_random_pathing(param_00)
{
	var_01 = [];
	foreach(var_03 in level.players)
	{
		if(maps\mp\zombies\_util::isplayerinlaststand(var_03))
		{
			var_01[var_01.size] = var_03;
		}
	}

	var_05 = [];
	foreach(var_07 in param_00)
	{
		if(maps\mp\zombies\_util::nodeisinspawncloset(var_07))
		{
			continue;
		}

		var_08 = 0;
		foreach(var_03 in var_01)
		{
			if(distancesquared(var_07.origin,var_03.origin) < 65536)
			{
				var_08 = 1;
				break;
			}
		}

		if(var_08)
		{
			continue;
		}

		var_05[var_05.size] = var_07;
	}

	return var_05;
}

//Function Number: 51
withinmeleeradius()
{
	if(getmeleeradius() == self.meleeradiusbase)
	{
		return withinmeleeradiusbase();
	}

	var_00 = distancesquared(self.origin,self.curmeleetarget.origin) <= getmeleeradiussq();
	return var_00;
}

//Function Number: 52
withinmeleeradiusbase()
{
	var_00 = distancesquared(self.origin,self.curmeleetarget.origin) <= self.meleeradiusbasesq;
	if(!var_00 && isplayer(self.curmeleetarget) || isagent(self.curmeleetarget) && isalive(self.curmeleetarget))
	{
		var_01 = self.curmeleetarget getgroundentity();
		if(isdefined(var_01) && isdefined(var_01.targetname) && var_01.targetname == "care_package")
		{
			var_00 = distancesquared(self.origin,self.curmeleetarget.origin) <= self.meleeradiusbasesq * 4;
		}
	}

	if(!var_00 && isplayer(self.curmeleetarget) && maps\mp\zombies\_util::is_true(self.curmeleetarget.isinexploitspot))
	{
		if(length(self getvelocity()) < 5)
		{
			var_00 = distancesquared(self.origin,self.curmeleetarget.origin) <= self.meleeradiusbasesq * 4;
		}
	}

	return var_00;
}