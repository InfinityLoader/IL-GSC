/*******************************************************************
 * Decompiled By: Bog
 * Decompiled File: maps\mp\_stinger.gsc
 * Game: Call of Duty: Modern Warfare 2
 * Platform: PC
*******************************************************************/

initstingerusage()
{
	self.stingerstage = undefined;
	self.stingertarget = undefined;
	self.stingerlockstarttime = undefined;
	self.stingerlostsightlinetime = undefined;
	thread resetstingerlockingondeath();
	level.stingertargets = [];
}

resetstingerlocking()
{
	if(!isdefined(self.stingeruseentered))
	{
		return;
	}

	self.stingeruseentered = undefined;
	self notify("stop_javelin_locking_feedback");
	self notify("stop_javelin_locked_feedback");
	self weaponlockfree();
	initstingerusage();
}

resetstingerlockingondeath()
{
	self endon("disconnect");
	self notify("ResetStingerLockingOnDeath");
	self endon("ResetStingerLockingOnDeath");
	for(;;)
	{
		self waittill("death");
		resetstingerlocking();
	}
}

stillvalidstingerlock(ent)
{
	if(!isdefined(ent))
	{
		return 0;
	}

	if(!self worldpointinreticle_circle(ent.origin, 65, 85))
	{
		return 0;
	}

	if(self.stingertarget == level.ac130.planemodel && !isdefined(level.ac130player))
	{
		return 0;
	}

	return 1;
}

loopstingerlockingfeedback()
{
	self endon("stop_javelin_locking_feedback");
	for(;;)
	{
		if(isdefined(level.chopper) && isdefined(level.chopper.gunner) && isdefined(self.stingertarget) && self.stingertarget == level.chopper.gunner)
		{
			level.chopper.gunner playlocalsound("missile_locking");
		}

		if(isdefined(level.ac130player) && isdefined(self.stingertarget) && self.stingertarget == level.ac130.planemodel)
		{
			level.ac130player playlocalsound("missile_locking");
		}

		self playlocalsound("stinger_locking");
		self method_0004("ac130_25mm_fire");
		wait 0.6;
	}
}

loopstingerlockedfeedback()
{
	self endon("stop_javelin_locked_feedback");
	for(;;)
	{
		if(isdefined(level.chopper) && isdefined(level.chopper.gunner) && isdefined(self.stingertarget) && self.stingertarget == level.chopper.gunner)
		{
			level.chopper.gunner playlocalsound("missile_locking");
		}

		if(isdefined(level.ac130player) && isdefined(self.stingertarget) && self.stingertarget == level.ac130.planemodel)
		{
			level.ac130player playlocalsound("missile_locking");
		}

		self playlocalsound("stinger_locked");
		self method_0004("ac130_25mm_fire");
		wait 0.25;
	}
}

locksighttest(target)
{
	eyepos = self geteye();
	if(!isdefined(target))
	{
		return 0;
	}

	passed = bullettracepassed(eyepos, target.origin, 0, target);
	if(passed)
	{
		return 1;
	}

	front = target getpointinbounds(1, 0, 0);
	passed = bullettracepassed(eyepos, front, 0, target);
	if(passed)
	{
		return 1;
	}

	back = target getpointinbounds(-1, 0, 0);
	passed = bullettracepassed(eyepos, back, 0, target);
	if(passed)
	{
		return 1;
	}

	return 0;
}

stingerdebugdraw(target)
{
}

softsighttest()
{
	lost_sight_limit = 500;
	if(locksighttest(self.stingertarget))
	{
		self.stingerlostsightlinetime = 0;
		return 1;
	}

	if(self.stingerlostsightlinetime == 0)
	{
		self.stingerlostsightlinetime = gettime();
	}

	timepassed = gettime() - self.stingerlostsightlinetime;
	if(timepassed >= lost_sight_limit)
	{
		resetstingerlocking();
		return 0;
	}

	return 1;
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

		if(isdefined(level.ac130player) && level.ac130player.team != self.team)
		{
			targets[targets.size] = level.ac130.planemodel;
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

		if(isdefined(level.littlebird))
		{
			foreach(bird in level.littlebird)
			{
				if(!isdefined(bird))
				{
					continue;
				}

				if(self.team != bird.owner.team || self == bird.owner)
				{
					targets[targets.size] = bird;
				}
			}
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
			targets[targets.size] = level.ac130.planemodel;
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

stingerusageloop()
{
	self endon("death");
	self endon("disconnect");
	lock_length = 1000;
	initstingerusage();
	for(;;)
	{
		wait 0.05;
		weapon = self getcurrentweapon();
		if(weapon != "stinger_mp" && weapon != "at4_mp")
		{
			resetstingerlocking();
			continue;
		}

		if(self playerads() < 0.95)
		{
			resetstingerlocking();
			continue;
		}

		self.stingeruseentered = 1;
		if(!isdefined(self.stingerstage))
		{
			self.stingerstage = 0;
		}

		stingerdebugdraw(self.stingertarget);
		if(self.stingerstage == 0)
		{
			targets = gettargetlist();
			if(targets.size == 0)
			{
				continue;
			}

			targetsinreticle = [];
			foreach(target in targets)
			{
				if(!isdefined(target))
				{
					continue;
				}

				insidereticle = self worldpointinreticle_circle(target.origin, 65, 75);
				if(insidereticle)
				{
					targetsinreticle[targetsinreticle.size] = target;
				}
			}

			if(targetsinreticle.size == 0)
			{
				continue;
			}

			sortedtargets = sortbydistance(targetsinreticle, self.origin);
			if(!locksighttest(sortedtargets[0]))
			{
				continue;
			}

			thread loopstingerlockingfeedback();
			self.stingertarget = sortedtargets[0];
			self.stingerlockstarttime = gettime();
			self.stingerstage = 1;
			self.stingerlostsightlinetime = 0;
		}

		if(self.stingerstage == 1)
		{
			if(!stillvalidstingerlock(self.stingertarget))
			{
				resetstingerlocking();
				continue;
			}

			passed = softsighttest();
			if(!passed)
			{
				continue;
			}

			timepassed = gettime() - self.stingerlockstarttime;
			if(timepassed < lock_length)
			{
				continue;
			}

			self notify("stop_javelin_locking_feedback");
			thread loopstingerlockedfeedback();
			if(self.stingertarget.model == "vehicle_av8b_harrier_jet_mp" || self.stingertarget.model == "vehicle_little_bird_armed")
			{
				self weaponlockfinalize(self.stingertarget);
			}
			else
			{
				self weaponlockfinalize(self.stingertarget, (100,0,-32));
			}

			self.stingerstage = 2;
		}

		if(self.stingerstage == 2)
		{
			passed = softsighttest();
			if(!passed)
			{
				continue;
			}

			if(!stillvalidstingerlock(self.stingertarget))
			{
				resetstingerlocking();
				continue;
			}
		}
	}
}