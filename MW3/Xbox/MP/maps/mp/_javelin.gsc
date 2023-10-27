/*******************************************************************
 * Decompiled By: Bog
 * Decompiled File: maps\mp\_javelin.gsc
 * Game: Call of Duty: Modern Warfare 3
 * Platform: Console
 * Function Count: 15
 * Decompile Time: 281 ms
 * Timestamp: 10/27/2023 2:27:47 AM
*******************************************************************/

//Function Number: 1
func_27D0()
{
	self.javelinstage = undefined;
	self.javelinpoints = undefined;
	self.javelinnormals = undefined;
	self.javelinlockmisses = undefined;
	self.javelintargetpoint = undefined;
	self.javelintargetnormal = undefined;
	self.javelinlockstarttime = undefined;
}

//Function Number: 2
func_27D8()
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
	func_27D0();
}

//Function Number: 3
func_27DD()
{
	var_00 = self geteye();
	var_01 = self getplayerangles();
	var_02 = anglestoforward(var_01);
	var_03 = var_00 + var_02 * 15000;
	var_04 = bullettrace(var_00,var_03,0,undefined);
	if(var_04["surfacetype"] == "none")
	{
		return undefined;
	}

	if(var_04["surfacetype"] == "default")
	{
		return undefined;
	}

	var_05 = var_04["entity"];
	if(isdefined(var_05))
	{
		if(var_05 == level.ac130.planemodel)
		{
			return undefined;
		}
	}

	var_06 = [];
	return var_41;
}

//Function Number: 4
func_27DE()
{
	self.javelinlockmisses = undefined;
}

//Function Number: 5
lockmissesincr()
{
	if(!isdefined(self.javelinlockmisses))
	{
		self.javelinlockmisses = 1;
		return;
	}

	self.javelinlockmisses++;
}

//Function Number: 6
lockmissespassedthreshold()
{
	var_00 = 4;
	if(isdefined(self.javelinlockmisses) && self.javelinlockmisses >= var_00)
	{
		return 1;
	}

	return 0;
}

//Function Number: 7
targetpointtooclose(param_00)
{
	var_01 = 1100;
	var_02 = distance(self.origin,param_00);
	if(var_02 < var_01)
	{
		return 1;
	}

	return 0;
}

//Function Number: 8
func_27E2(param_00,param_01)
{
	self endon("death");
	self endon("disconnect");
	self endon("stop_lockon_sound");
	for(;;)
	{
		self playlocalsound(param_00);
		wait param_01;
	}
}

//Function Number: 9
func_27E3(param_00,param_01)
{
	var_02 = param_00 + param_01 * 10;
	var_03 = var_02 + (0,0,2000);
	var_04 = bullettrace(var_02,var_03,0,undefined);
	if(sighttracepassed(var_02,var_03,0,undefined))
	{
		return 1;
	}

	return 0;
}

//Function Number: 10
func_27E4()
{
	self endon("death");
	self endon("disconnect");
	self endon("faux_spawn");
	var_00 = 1150;
	var_01 = 25;
	var_02 = 100;
	var_03 = 400;
	var_04 = 12;
	var_05 = 0;
	var_06 = 0;
	self.javelintarget = undefined;
	func_27D0();
	for(;;)
	{
		wait 0.05;
		var_07 = 0;
		if(getdvar("missileDebugDraw") == "1")
		{
			var_07 = 1;
		}

		var_08 = 0;
		if(getdvar("missileDebugText") == "1")
		{
			var_08 = 1;
		}

		var_09 = self getcurrentweapon();
		if(!issubstr(var_09,"javelin") || maps\mp\_utility::func_27E5())
		{
			func_27D8();
			continue;
		}

		if(self playerads() < 0.95)
		{
			var_06 = gettime();
			func_27D8();
			continue;
		}

		self.javelinuseentered = 1;
		if(!isdefined(self.javelinstage))
		{
			self.javelinstage = 1;
		}

		if(self.javelinstage == 1)
		{
			var_0A = maps\mp\_stinger::gettargetlist();
			if(var_0A.size != 0)
			{
				var_0B = [];
				foreach(var_0D in var_0A)
				{
					var_0E = self worldpointinreticle_circle(var_0D.origin,65,40);
					if(var_0E)
					{
						var_0B[var_0B.size] = var_0D;
					}
				}

				if(var_0B.size != 0)
				{
					var_10 = sortbydistance(var_0B,self.origin);
					if(!vehiclelocksighttest(var_10[0]))
					{
						continue;
					}

					if(var_08)
					{
					}

					self.javelintarget = var_10[0];
					if(!isdefined(self.javelinlockstarttime))
					{
						self.javelinlockstarttime = gettime();
					}

					self.javelinstage = 2;
					self.javelinlostsightlinetime = 0;
					javelinlockvehicle(var_00);
					self.javelinstage = 1;
					continue;
				}
			}

			if(lockmissespassedthreshold())
			{
				func_27D8();
				continue;
			}

			var_11 = gettime() - var_06;
			if(var_11 < var_02)
			{
				continue;
			}

			var_11 = gettime() - var_05;
			if(var_11 < var_01)
			{
				continue;
			}

			var_05 = gettime();
			var_15 = func_27DD();
			if(!isdefined(var_15))
			{
				lockmissesincr();
				continue;
			}

			if(targetpointtooclose(var_15[0]))
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
				var_16 = averagepoint(self.javelinpoints);
				var_17 = distance(var_16,var_15[0]);
				if(var_17 > var_03)
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

			self.javelinpoints[self.javelinpoints.size] = var_15[0];
			self.javelinnormals[self.javelinnormals.size] = var_15[1];
			func_27DE();
			if(self.javelinpoints.size < var_04)
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
			thread func_27E2("javelin_clu_aquiring_lock",0.6);
			self.javelinstage = 2;
		}

		if(self.javelinstage == 2)
		{
			var_0E = self worldpointinreticle_circle(self.javelintargetpoint,65,45);
			if(!var_0E)
			{
				func_27D8();
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

			var_11 = gettime() - self.javelinlockstarttime;
			if(var_11 < var_00)
			{
				continue;
			}

			self weaponlockfinalize(self.javelintargetpoint,(0,0,0),1);
			self notify("stop_lockon_sound");
			self playlocalsound("javelin_clu_lock");
			self.javelinstage = 3;
		}

		if(self.javelinstage == 3)
		{
			var_0E = self worldpointinreticle_circle(self.javelintargetpoint,65,45);
			if(!var_0E)
			{
				func_27D8();
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

//Function Number: 11
func_27E7(param_00,param_01,param_02)
{
}

//Function Number: 12
vehiclelocksighttest(param_00)
{
	var_01 = self geteye();
	var_02 = param_00 getpointinbounds(0,0,0);
	var_03 = sighttracepassed(var_01,var_02,0,param_00);
	func_27E7(var_01,var_02,var_03);
	if(var_03)
	{
		return 1;
	}

	var_04 = param_00 getpointinbounds(1,0,0);
	var_03 = sighttracepassed(var_01,var_04,0,param_00);
	func_27E7(var_01,var_04,var_03);
	if(var_03)
	{
		return 1;
	}

	var_05 = param_00 getpointinbounds(-1,0,0);
	var_03 = sighttracepassed(var_01,var_05,0,param_00);
	func_27E7(var_01,var_05,var_03);
	if(var_03)
	{
		return 1;
	}

	return 0;
}

//Function Number: 13
javelinlockvehicle(param_00)
{
	if(self.javelinstage == 2)
	{
		self weaponlockstart(self.javelintarget);
		if(!stillvalidjavelinlock(self.javelintarget))
		{
			func_27D8();
			self.javelinlockstarttime = undefined;
			return;
		}

		var_01 = func_27C9();
		if(!var_01)
		{
			self.javelinlockstarttime = undefined;
			return;
		}

		if(!isdefined(self.currentlylocking) || !self.currentlylocking)
		{
			thread func_27E2("javelin_clu_aquiring_lock",0.6);
			self.currentlylocking = 1;
		}

		var_02 = gettime() - self.javelinlockstarttime;
		if(maps\mp\_utility::func_27AF("specialty_fasterlockon"))
		{
			if(var_02 < param_00 * 0.5)
			{
				return;
			}
		}
		else if(var_02 < param_00)
		{
			return;
		}

		if(isplayer(self.javelintarget))
		{
			self weaponlockfinalize(self.javelintarget,(0,0,64),0);
		}
		else
		{
			self weaponlockfinalize(self.javelintarget,(0,0,0),0);
		}

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
		var_01 = func_27C9();
		if(!var_01)
		{
			return;
		}

		if(!stillvalidjavelinlock(self.javelintarget))
		{
			func_27D8();
			return;
		}
	}
}

//Function Number: 14
stillvalidjavelinlock(param_00)
{
	if(!isdefined(param_00))
	{
		return 0;
	}

	if(!self worldpointinreticle_circle(param_00.origin,65,85))
	{
		return 0;
	}

	return 1;
}

//Function Number: 15
func_27C9()
{
	var_00 = 500;
	if(vehiclelocksighttest(self.javelintarget))
	{
		self.javelinlostsightlinetime = 0;
		return 1;
	}

	if(self.javelinlostsightlinetime == 0)
	{
		self.javelinlostsightlinetime = gettime();
	}

	var_01 = gettime() - self.javelinlostsightlinetime;
	if(var_01 >= var_00)
	{
		func_27D8();
		return 0;
	}

	return 1;
}