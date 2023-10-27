/*******************************************************************
 * Decompiled By: Bog
 * Decompiled File: maps\mp\_stinger.gsc
 * Game: Call of Duty: Ghosts
 * Platform: Console
 * Function Count: 11
 * Decompile Time: 177 ms
 * Timestamp: 10/27/2023 1:30:06 AM
*******************************************************************/

//Function Number: 1
func_4654()
{
	self.stingerstage = undefined;
	self.stingertarget = undefined;
	self.stingerlockstarttime = undefined;
	self.stingerlostsightlinetime = undefined;
	thread func_661C();
	level.stingertargets = [];
}

//Function Number: 2
func_661B()
{
	if(!isdefined(self.stingeruseentered))
	{
	}

	self.stingeruseentered = undefined;
	self notify("stop_javelin_locking_feedback");
	self notify("stop_javelin_locked_feedback");
	self weaponlockfree();
	func_4654();
}

//Function Number: 3
func_661C()
{
	self endon("disconnect");
	self notify("ResetStingerLockingOnDeath");
	self endon("ResetStingerLockingOnDeath");
	for(;;)
	{
		self waittill("death");
		func_661B();
	}
}

//Function Number: 4
func_7BF8(param_00)
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
func_4F88()
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
		wait(0.6);
	}
}

//Function Number: 6
func_4F87()
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
		wait(0.25);
	}
}

//Function Number: 7
func_4EE9(param_00)
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
func_7BFA(param_00)
{
}

//Function Number: 9
func_76B2()
{
	var_00 = 500;
	if(func_4EE9(self.stingertarget))
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
		func_661B();
		return 0;
	}

	return 1;
}

//Function Number: 10
func_7C02()
{
	if(!isplayer(self))
	{
	}

	self endon("death");
	self endon("disconnect");
	self endon("faux_spawn");
	var_00 = 1000;
	func_4654();
	for(;;)
	{
		wait(0.05);
		if(self playerads() < 0.95)
		{
			func_661B();
			continue;
		}

		var_01 = self getcurrentweapon();
		if(var_01 != "stinger_mp" && var_01 != "at4_mp" && var_01 != "iw5_smaw_mp")
		{
			func_661B();
			continue;
		}

		self.stingeruseentered = 1;
		if(!isdefined(self.stingerstage))
		{
			self.stingerstage = 0;
		}

		func_7BFA(self.stingertarget);
		if(self.stingerstage == 0)
		{
			var_02 = maps\mp\gametypes\_weapons::func_4EE2();
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
			if(!func_4EE9(var_08[0]))
			{
				continue;
			}

			thread func_4F88();
			self.stingertarget = var_08[0];
			self.stingerlockstarttime = gettime();
			self.stingerstage = 1;
			self.stingerlostsightlinetime = 0;
		}

		if(self.stingerstage == 1)
		{
			if(!func_7BF8(self.stingertarget))
			{
				func_661B();
				continue;
			}

			var_09 = func_76B2();
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
			thread func_4F87();
			if(func_1BDF(self.stingertarget.model))
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
			var_09 = func_76B2();
			if(!var_09)
			{
				continue;
			}

			if(!func_7BF8(self.stingertarget))
			{
				func_661B();
				continue;
			}
		}
	}
}

//Function Number: 11
func_1BDF(param_00)
{
	switch(param_00)
	{
		case "vehicle_ugv_talon_mp":
		case "vehicle_av8b_harrier_jet_opfor_mp":
		case "vehicle_av8b_harrier_jet_mp":
			return 1;

		default:
			if(param_00 == level.littlebird_model)
			{
				return 1;
			}
	
			break;
	}

	return 0;
}