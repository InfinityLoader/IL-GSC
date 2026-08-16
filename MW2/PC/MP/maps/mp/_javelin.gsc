/*******************************************************************
 * Decompiled By: Bog
 * Decompiled File: maps\mp\_javelin.gsc
 * Game: Call of Duty: Modern Warfare 2
 * Platform: PC
*******************************************************************/

initjavelinusage()
{
	self.javelinstage = undefined;
	self.javelinpoints = undefined;
	self.javelinnormals = undefined;
	self.javelinlockmisses = undefined;
	self.javelintargetpoint = undefined;
	self.javelintargetnormal = undefined;
	self.javelinlockstarttime = undefined;
}

resetjavelinlocking()
{
	if(!isdefined(self.javelinuseentered))
	{
		return;
	}

	self.javelinuseentered = undefined;
	self notify("stop_lockon_sound");
	self weaponlockfree();
	self weaponlocktargettooclose(0);
	self weaponlocknoclearance(0);
	self.currentlylocking = 0;
	self.currentlylocked = 0;
	self.javelintarget = undefined;
	self stoplocalsound("javelin_clu_lock");
	self stoplocalsound("javelin_clu_aquiring_lock");
	initjavelinusage();
}

eyetraceforward()
{
	origin = self geteye();
	angles = self getplayerangles();
	forward = anglestoforward(angles);
	endpoint = origin + forward * 15000;
	res = bullettrace(origin, endpoint, 0, undefined);
	if(res["surfacetype"] == "none")
	{
		return undefined;
	}

	if(res["surfacetype"] == "default")
	{
		return undefined;
	}

	ent = res["entity"];
	if(isdefined(ent))
	{
		if(ent == level.ac130.planemodel)
		{
			return undefined;
		}
	}

	results = [];
	results[0] = res["position"];
	results[1] = res["normal"];
	return results;
}

lockmissesreset()
{
	self.javelinlockmisses = undefined;
}

lockmissesincr()
{
	if(!isdefined(self.javelinlockmisses))
	{
		self.javelinlockmisses = 1;
		return;
	}

	self.javelinlockmisses++;
}

lockmissespassedthreshold()
{
	max_misses = 4;
	if(isdefined(self.javelinlockmisses) && self.javelinlockmisses >= max_misses)
	{
		return 1;
	}

	return 0;
}

targetpointtooclose(targetpoint)
{
	my_min_dist = 1100;
	dist = distance(self.origin, targetpoint);
	if(dist < my_min_dist)
	{
		return 1;
	}

	return 0;
}

looplocalseeksound(alias, interval)
{
	self endon("death");
	self endon("disconnect");
	self endon("stop_lockon_sound");
	for(;;)
	{
		self playlocalsound(alias);
		wait interval;
	}
}

topattackpasses(targpoint, targnormal)
{
	origin = targpoint + targnormal * 10;
	endpoint = origin + (0,0,2000);
	result = bullettrace(origin, endpoint, 0, undefined);
	if(bullettracepassed(origin, endpoint, 0, undefined))
	{
		return 1;
	}

	return 0;
}

javelinusageloop()
{
	self endon("death");
	self endon("disconnect");
	lock_length = 1150;
	gather_delay = 25;
	ads_delay = 100;
	max_point_peer_dist = 400;
	points_needed_to_start_lock = 12;
	lastgathertime = 0;
	lastoutofads = 0;
	self.javelintarget = undefined;
	initjavelinusage();
	for(;;)
	{
		wait 0.05;
		debugdraw = 0;
		if(getdvar("missileDebugDraw") == "1")
		{
			debugdraw = 1;
		}

		debugtext = 0;
		if(getdvar("missileDebugText") == "1")
		{
			debugtext = 1;
		}

		weapon = self getcurrentweapon();
		if(!issubstr(weapon, "javelin") || maps\mp\_utility::isemped())
		{
			resetjavelinlocking();
			continue;
		}

		if(self playerads() < 0.95)
		{
			lastoutofads = gettime();
			resetjavelinlocking();
			continue;
		}

		self.javelinuseentered = 1;
		if(!isdefined(self.javelinstage))
		{
			self.javelinstage = 1;
		}

		if(self.javelinstage == 1)
		{
			targets = gettargetlist();
			if(targets.size != 0)
			{
				targetsinreticle = [];
				foreach(target in targets)
				{
					insidereticle = self worldpointinreticle_circle(target.origin, 65, 40);
					if(insidereticle)
					{
						targetsinreticle[targetsinreticle.size] = target;
					}
				}

				if(targetsinreticle.size != 0)
				{
					sortedtargets = sortbydistance(targetsinreticle, self.origin);
					if(!vehiclelocksighttest(sortedtargets[0]))
					{
						continue;
					}

					if(debugtext)
					{
					}

					self.javelintarget = sortedtargets[0];
					if(!isdefined(self.javelinlockstarttime))
					{
						self.javelinlockstarttime = gettime();
					}

					self.javelinstage = 2;
					self.javelinlostsightlinetime = 0;
					javelinlockvehicle(lock_length);
					self.javelinstage = 1;
					continue;
				}
			}

			if(lockmissespassedthreshold())
			{
				resetjavelinlocking();
				continue;
			}

			timepassed = gettime() - lastoutofads;
			if(timepassed < ads_delay)
			{
				continue;
			}

			timepassed = gettime() - lastgathertime;
			if(timepassed < gather_delay)
			{
				continue;
			}

			lastgathertime = gettime();
			traceres = eyetraceforward();
			if(!isdefined(traceres))
			{
				lockmissesincr();
				continue;
			}

			if(targetpointtooclose(traceres[0]))
			{
				self weaponlocktargettooclose(1);
				continue;
			}
			else
			{
				self weaponlocktargettooclose(0);
			}

			if(isdefined(self.javelinpoints))
			{
				prevavgpoint = averagepoint(self.javelinpoints);
				dist = distance(prevavgpoint, traceres[0]);
				if(dist > max_point_peer_dist)
				{
					lockmissesincr();
					continue;
				}
			}
			else
			{
				self.javelinpoints = [];
				self.javelinnormals = [];
			}

			self.javelinpoints[self.javelinpoints.size] = traceres[0];
			self.javelinnormals[self.javelinnormals.size] = traceres[1];
			lockmissesreset();
			if(self.javelinpoints.size < points_needed_to_start_lock)
			{
				continue;
			}

			self.javelintargetpoint = averagepoint(self.javelinpoints);
			self.javelintargetnormal = averagenormal(self.javelinnormals);
			self.javelinlockmisses = undefined;
			self.javelinpoints = undefined;
			self.javelinnormals = undefined;
			self.javelinlockstarttime = gettime();
			self weaponlockstart(self.javelintargetpoint);
			thread looplocalseeksound("javelin_clu_aquiring_lock", 0.6);
			self.javelinstage = 2;
		}

		if(self.javelinstage == 2)
		{
			insidereticle = self worldpointinreticle_circle(self.javelintargetpoint, 65, 45);
			if(!insidereticle)
			{
				resetjavelinlocking();
				continue;
			}

			if(targetpointtooclose(self.javelintargetpoint))
			{
				self weaponlocktargettooclose(1);
			}
			else
			{
				self weaponlocktargettooclose(0);
			}

			timepassed = gettime() - self.javelinlockstarttime;
			if(timepassed < lock_length)
			{
				continue;
			}

			self weaponlockfinalize(self.javelintargetpoint, (0,0,0), 1);
			self notify("stop_lockon_sound");
			self playlocalsound("javelin_clu_lock");
			self.javelinstage = 3;
		}

		if(self.javelinstage == 3)
		{
			insidereticle = self worldpointinreticle_circle(self.javelintargetpoint, 65, 45);
			if(!insidereticle)
			{
				resetjavelinlocking();
				continue;
			}

			if(targetpointtooclose(self.javelintargetpoint))
			{
				self weaponlocktargettooclose(1);
			}
			else
			{
				self weaponlocktargettooclose(0);
			}

			continue;
		}
	}
}

gettargetlist()
{
	targets = [];
	if(level.teambased)
	{
		if(isdefined(level.chopper) && level.chopper.team != self.team || level.chopper.owner == self)
		{
			targets[targets.size] = level.chopper;
		}

		if(isdefined(level.harriers))
		{
			foreach(harrier in level.harriers)
			{
				if(isdefined(harrier) && harrier.team != self.team || isdefined(harrier.owner) && harrier.owner == self)
				{
					targets[targets.size] = harrier;
				}
			}
		}

		if(level.uavmodels[level.otherteam[self.team]].size)
		{
			foreach(uav in level.uavmodels[level.otherteam[self.team]])
			{
				targets[targets.size] = uav;
			}
		}

		if(isdefined(level.ac130player) && level.ac130player.team != self.team)
		{
			targets[targets.size] = level.ac130.planemodel;
		}
	}
	else
	{
		if(isdefined(level.chopper) && level.chopper.owner != self)
		{
			targets[targets.size] = level.chopper;
		}

		if(isdefined(level.ac130player))
		{
			targets[targets.size] = level.ac130;
		}

		if(isdefined(level.harriers))
		{
			foreach(harrier in level.harriers)
			{
				if(isdefined(harrier))
				{
					targets[targets.size] = harrier;
				}
			}
		}

		if(level.uavmodels.size)
		{
			foreach(uav in level.uavmodels)
			{
				if(isdefined(uav.owner) && uav.owner == self)
				{
					continue;
				}

				targets[targets.size] = uav;
			}
		}
	}

	return targets;
}

debugsightline(start, end, passed)
{
}

vehiclelocksighttest(target)
{
	eyepos = self geteye();
	center = target getpointinbounds(0, 0, 0);
	passed = bullettracepassed(eyepos, center, 0, target);
	debugsightline(eyepos, center, passed);
	if(passed)
	{
		return 1;
	}

	front = target getpointinbounds(1, 0, 0);
	passed = bullettracepassed(eyepos, front, 0, target);
	debugsightline(eyepos, front, passed);
	if(passed)
	{
		return 1;
	}

	back = target getpointinbounds(-1, 0, 0);
	passed = bullettracepassed(eyepos, back, 0, target);
	debugsightline(eyepos, back, passed);
	if(passed)
	{
		return 1;
	}

	return 0;
}

javelinlockvehicle(locklength)
{
	if(self.javelinstage == 2)
	{
		self weaponlockstart(self.javelintarget);
		if(!stillvalidjavelinlock(self.javelintarget))
		{
			resetjavelinlocking();
			self.javelinlockstarttime = undefined;
			return;
		}

		passed = softsighttest();
		if(!passed)
		{
			self.javelinlockstarttime = undefined;
			return;
		}

		if(!isdefined(self.currentlylocking) || !self.currentlylocking)
		{
			thread looplocalseeksound("javelin_clu_aquiring_lock", 0.6);
			self.currentlylocking = 1;
		}

		timepassed = gettime() - self.javelinlockstarttime;
		if(timepassed < locklength)
		{
			return;
		}

		self weaponlockfinalize(self.javelintarget, (0,0,0), 0);
		self notify("stop_lockon_sound");
		if(!isdefined(self.currentlylocked) || !self.currentlylocked)
		{
			self playlocalsound("javelin_clu_lock");
			self.currentlylocked = 1;
		}

		self.javelinstage = 3;
	}

	if(self.javelinstage == 3)
	{
		passed = softsighttest();
		if(!passed)
		{
			return;
		}

		if(!stillvalidjavelinlock(self.javelintarget))
		{
			resetjavelinlocking();
			return;
		}
	}
}

stillvalidjavelinlock(ent)
{
	if(!isdefined(ent))
	{
		return 0;
	}

	if(!self worldpointinreticle_circle(ent.origin, 65, 85))
	{
		return 0;
	}

	return 1;
}

softsighttest()
{
	lost_sight_limit = 500;
	if(vehiclelocksighttest(self.javelintarget))
	{
		self.javelinlostsightlinetime = 0;
		return 1;
	}

	if(self.javelinlostsightlinetime == 0)
	{
		self.javelinlostsightlinetime = gettime();
	}

	timepassed = gettime() - self.javelinlostsightlinetime;
	if(timepassed >= lost_sight_limit)
	{
		resetjavelinlocking();
		return 0;
	}

	return 1;
}