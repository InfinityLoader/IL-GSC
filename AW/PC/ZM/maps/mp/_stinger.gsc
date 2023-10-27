/*******************************************************************
 * Decompiled By: Bog
 * Decompiled File: maps/mp/_stinger.gsc
 * Game: Call of Duty: Advanced Warfare
 * Platform: PC
 * Function Count: 11
 * Decompile Time: 158 ms
 * Timestamp: 10/27/2023 2:08:33 AM
*******************************************************************/

//Function Number: 1
initstingerusage()
{
	self.stingerstage = undefined;
	self.stingertarget = undefined;
	self.stingerlockstarttime = undefined;
	self.stingerlostsightlinetime = undefined;
	thread resetstingerlockingondeath();
}

//Function Number: 2
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

//Function Number: 3
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

//Function Number: 4
stillvalidstingerlock(param_00)
{
	if(!isdefined(param_00))
	{
		return 0;
	}

	if(!self worldpointinreticle_circle(param_00.origin,65,85))
	{
		return 0;
	}

	if(isdefined(level.ac130) && self.stingertarget == level.ac130.planemodel && !isdefined(level.ac130player))
	{
		return 0;
	}

	if(isdefined(level.orbitalsupport_planemodel) && self.stingertarget == level.orbitalsupport_planemodel && !isdefined(level.orbitalsupport_player))
	{
		return 0;
	}

	return 1;
}

//Function Number: 5
loopstingerlockingfeedback()
{
	self endon("faux_spawn");
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
		self playrumbleonentity("ac130_25mm_fire");
		wait(0.6);
	}
}

//Function Number: 6
loopstingerlockedfeedback()
{
	self endon("faux_spawn");
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
		self playrumbleonentity("ac130_25mm_fire");
		wait(0.25);
	}
}

//Function Number: 7
locksighttest(param_00)
{
	var_01 = self geteye();
	if(!isdefined(param_00))
	{
		return 0;
	}

	var_02 = sighttracepassed(var_01,param_00.origin,0,param_00);
	if(var_02)
	{
		return 1;
	}

	var_03 = param_00 getpointinbounds(1,0,0);
	var_02 = sighttracepassed(var_01,var_03,0,param_00);
	if(var_02)
	{
		return 1;
	}

	var_04 = param_00 getpointinbounds(-1,0,0);
	var_02 = sighttracepassed(var_01,var_04,0,param_00);
	if(var_02)
	{
		return 1;
	}

	return 0;
}

//Function Number: 8
stingerdebugdraw(param_00)
{
}

//Function Number: 9
softsighttest()
{
	var_00 = 500;
	if(locksighttest(self.stingertarget))
	{
		self.stingerlostsightlinetime = 0;
		return 1;
	}

	if(self.stingerlostsightlinetime == 0)
	{
		self.stingerlostsightlinetime = gettime();
	}

	var_01 = gettime() - self.stingerlostsightlinetime;
	if(var_01 >= var_00)
	{
		resetstingerlocking();
		return 0;
	}

	return 1;
}

//Function Number: 10
gettargetlist()
{
	var_00 = [];
	if(maps\mp\_utility::invirtuallobby())
	{
		return var_00;
	}

	if(level.teambased)
	{
		if(isdefined(level.chopper) && level.chopper.team != self.team || isdefined(level.chopper.owner) && level.chopper.owner == self)
		{
			var_00[var_00.size] = level.chopper;
		}

		if(isdefined(level.ac130player) && level.ac130player.team != self.team)
		{
			var_00[var_00.size] = level.ac130.planemodel;
		}

		if(isdefined(level.orbitalsupport_player) && level.orbitalsupport_player.team != self.team)
		{
			var_00[var_00.size] = level.orbitalsupport_planemodel;
		}

		if(isdefined(level.spawnedwarbirds))
		{
			foreach(var_02 in level.spawnedwarbirds)
			{
				if(isdefined(var_02) && var_02.team != self.team)
				{
					var_00[var_00.size] = var_02;
				}
			}
		}

		if(isdefined(level.harriers))
		{
			foreach(var_05 in level.harriers)
			{
				if(isdefined(var_05) && var_05.team != self.team || isdefined(var_05.owner) && var_05.owner == self)
				{
					var_00[var_00.size] = var_05;
				}
			}
		}

		if(level.multiteambased)
		{
			for(var_07 = 0;var_07 < level.teamnamelist.size;var_07++)
			{
				if(self.team != level.teamnamelist[var_07])
				{
					if(level.uavmodels[level.teamnamelist[var_07]].size)
					{
						foreach(var_09 in level.uavmodels[level.teamnamelist[var_07]])
						{
							var_00[var_00.size] = var_09;
						}
					}
				}
			}
		}
		else if(level.uavmodels[level.otherteam[self.team]].size)
		{
			foreach(var_09 in level.uavmodels[level.otherteam[self.team]])
			{
				var_00[var_00.size] = var_09;
			}
		}

		if(isdefined(level.littlebirds))
		{
			foreach(var_0E in level.littlebirds)
			{
				if(isdefined(var_0E) && var_0E.team != self.team || isdefined(var_0E.owner) && var_0E.owner == self)
				{
					var_00[var_00.size] = var_0E;
				}
			}
		}

		if(isdefined(level.ugvs))
		{
			foreach(var_11 in level.ugvs)
			{
				if(isdefined(var_11) && var_11.team != self.team || isdefined(var_11.owner) && var_11.owner == self)
				{
					var_00[var_00.size] = var_11;
				}
			}
		}
	}
	else
	{
		if(isdefined(level.chopper))
		{
			var_00[var_00.size] = level.chopper;
		}

		if(isdefined(level.ac130player))
		{
			var_00[var_00.size] = level.ac130.planemodel;
		}

		if(isdefined(level.harriers))
		{
			foreach(var_05 in level.harriers)
			{
				if(isdefined(var_05))
				{
					var_00[var_00.size] = var_05;
				}
			}
		}

		if(level.uavmodels.size)
		{
			foreach(var_09 in level.uavmodels)
			{
				if(isdefined(var_09.owner) && var_09.owner == self)
				{
					continue;
				}

				var_00[var_00.size] = var_09;
			}
		}

		if(isdefined(level.littlebirds))
		{
			foreach(var_0E in level.littlebirds)
			{
				if(!isdefined(var_0E))
				{
					continue;
				}

				var_00[var_00.size] = var_0E;
			}
		}

		if(isdefined(level.ugvs))
		{
			foreach(var_11 in level.ugvs)
			{
				if(!isdefined(var_11))
				{
					continue;
				}

				var_00[var_00.size] = var_11;
			}
		}
	}

	return var_00;
}

//Function Number: 11
stingerusageloop()
{
	if(!isplayer(self))
	{
		return;
	}

	self endon("death");
	self endon("disconnect");
	self endon("faux_spawn");
	var_00 = 1000;
	initstingerusage();
	for(;;)
	{
		wait(0.05);
		if(self playerads() < 0.95)
		{
			resetstingerlocking();
			continue;
		}

		var_01 = self getcurrentweapon();
		if(issubstr(var_01,"stingerm7"))
		{
			continue;
		}

		if(var_01 != "stinger_mp" && var_01 != "iw5_maaws_mp")
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
			var_02 = gettargetlist();
			if(var_02.size == 0)
			{
				continue;
			}

			var_03 = [];
			foreach(var_05 in var_02)
			{
				if(!isdefined(var_05))
				{
					continue;
				}

				var_06 = self worldpointinreticle_circle(var_05.origin,65,75);
				if(var_06)
				{
					var_03[var_03.size] = var_05;
				}
			}

			if(var_03.size == 0)
			{
				continue;
			}

			var_08 = sortbydistance(var_03,self.origin);
			if(!locksighttest(var_08[0]))
			{
				continue;
			}

			thread loopstingerlockingfeedback();
			self.stingertarget = var_08[0];
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

			var_09 = softsighttest();
			if(!var_09)
			{
				continue;
			}

			var_0A = gettime() - self.stingerlockstarttime;
			if(maps\mp\_utility::_hasperk("specialty_fasterlockon"))
			{
				if(var_0A < var_00 * 0.5)
				{
					continue;
				}
			}
			else if(var_0A < var_00)
			{
				continue;
			}

			self notify("stop_javelin_locking_feedback");
			thread loopstingerlockedfeedback();
			self weaponlockfinalize(self.stingertarget);
			self.stingerstage = 2;
		}

		if(self.stingerstage == 2)
		{
			var_09 = softsighttest();
			if(!var_09)
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