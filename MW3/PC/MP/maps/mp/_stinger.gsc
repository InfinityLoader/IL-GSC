/*******************************************************************
 * Decompiled By: Bog
 * Decompiled File: maps\mp\_stinger.gsc
 * Game: Call of Duty: Modern Warfare 3
 * Platform: PC
 * Function Count: 11
 * Decompile Time: 222 ms
 * Timestamp: 10/27/2023 2:15:09 AM
*******************************************************************/

//Function Number: 1
initstingerusage()
{
	self.stingerstage = undefined;
	self.stingertarget = undefined;
	self.stingerlockstarttime = undefined;
	self.stingerlostsightlinetime = undefined;
	thread resetstingerlockingondeath();
	level.stingertargets = [];
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

	if(self.stingertarget == level.ac130.planemodel && !isdefined(level.ac130player))
	{
		return 0;
	}

	return 1;
}

//Function Number: 5
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
		self playrumbleonentity("ac130_25mm_fire");
		wait 0.6;
	}
}

//Function Number: 6
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
		self playrumbleonentity("ac130_25mm_fire");
		wait 0.25;
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
	if(level.teambased)
	{
		if(isdefined(level.chopper) && level.chopper.team != self.team || level.chopper.owner == self)
		{
		}

		if(isdefined(level.ac130player) && level.ac130player.team != self.team)
		{
		}

		if(isdefined(level.harriers))
		{
			foreach(var_02 in level.harriers)
			{
				if(isdefined(var_02) && var_02.team != self.team || isdefined(var_02.owner) && var_02.owner == self)
				{
					var_7B[var_7B.size] = var_02;
				}
			}
		}

		if(level.uavmodels[level.otherteam[self.team]].size)
		{
			foreach(var_05 in level.uavmodels[level.otherteam[self.team]])
			{
				var_7B[var_7B.size] = var_05;
			}
		}

		if(isdefined(level.littlebirds))
		{
			foreach(var_08 in level.littlebirds)
			{
				if(!isdefined(var_08))
				{
					continue;
				}

				if(self.team != var_08.owner.team || self == var_08.owner)
				{
					var_7B[var_7B.size] = var_08;
				}
			}
		}

		if(isdefined(level.ugvs))
		{
			foreach(var_0B in level.ugvs)
			{
				if(!isdefined(var_0B))
				{
					continue;
				}

				if(self.team != var_0B.owner.team || self == var_0B.owner)
				{
					var_7B[var_7B.size] = var_0B;
				}
			}
		}
	}
	else
	{
		if(isdefined(level.chopper))
		{
		}

		if(isdefined(level.ac130player))
		{
		}

		if(isdefined(level.harriers))
		{
			foreach(var_02 in level.harriers)
			{
				if(isdefined(var_02))
				{
					var_7B[var_7B.size] = var_02;
				}
			}
		}

		if(level.uavmodels.size)
		{
			foreach(var_05 in level.uavmodels)
			{
				if(isdefined(var_05.owner) && var_05.owner == self)
				{
					continue;
				}

				var_7B[var_7B.size] = var_05;
			}
		}

		if(isdefined(level.littlebirds))
		{
			foreach(var_08 in level.littlebirds)
			{
				if(!isdefined(var_08))
				{
					continue;
				}

				var_7B[var_7B.size] = var_08;
			}
		}

		if(isdefined(level.ugvs))
		{
			foreach(var_0B in level.ugvs)
			{
				if(!isdefined(var_0B))
				{
					continue;
				}

				var_7B[var_7B.size] = var_0B;
			}
		}

		foreach(var_16 in level.players)
		{
			if(!isalive(var_16))
			{
				continue;
			}

			if(level.teambased && var_16.team == self.team)
			{
				continue;
			}

			if(var_16 == self)
			{
				continue;
			}

			if(var_16 maps\mp\_utility::isjuggernaut())
			{
				var_7B[var_7B.size] = var_16;
			}
		}
	}

	return var_7B;
}

//Function Number: 11
stingerusageloop()
{
	self endon("death");
	self endon("disconnect");
	self endon("faux_spawn");
	var_00 = 1000;
	initstingerusage();
	for(;;)
	{
		wait 0.05;
		var_01 = self getcurrentweapon();
		if(var_01 != "stinger_mp" && var_01 != "at4_mp" && var_01 != "iw5_smaw_mp")
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
			if(self.stingertarget.model == "vehicle_av8b_harrier_jet_opfor_mp" || self.stingertarget.model == "vehicle_av8b_harrier_jet_mp" || self.stingertarget.model == "vehicle_little_bird_armed")
			{
				self weaponlockfinalize(self.stingertarget);
			}
			else if(isplayer(self.stingertarget))
			{
				self weaponlockfinalize(self.stingertarget,(100,0,64));
			}
			else
			{
				self weaponlockfinalize(self.stingertarget,(100,0,-32));
			}

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