/*******************************************************************
 * Decompiled By: Bog
 * Decompiled File: maps\mp\_javelin.gsc
 * Game: Call of Duty: Ghosts
 * Platform: PC
 * Function Count: 15
 * Decompile Time: 267 ms
 * Timestamp: 10/27/2023 1:22:20 AM
*******************************************************************/

//Function Number: 1
func_4631()
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
func_660C()
{
	if(!isdefined(self.javelinuseentered))
	{
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
	func_4631();
}

//Function Number: 3
func_3110()
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
	var_06[0] = var_04["position"];
	var_06[1] = var_04["normal"];
	return var_06;
}

//Function Number: 4
func_4EDF()
{
	self.javelinlockmisses = undefined;
}

//Function Number: 5
func_4EDD()
{
	if(!isdefined(self.javelinlockmisses))
	{
		self.javelinlockmisses = 1;
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
func_4F81(param_00,param_01)
{
	self endon("death");
	self endon("disconnect");
	self endon("stop_lockon_sound");
	for(;;)
	{
		self playlocalsound(param_00);
		wait(param_01);
	}
}

//Function Number: 9
topattackpasses(param_00,param_01)
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
func_49E3()
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
	func_4631();
	for(;;)
	{
		wait(0.05);
		var_07 = self getcurrentweapon();
		if((isbot(self) && var_07 != "javelin_mp") || !issubstr(var_07,"javelin") || maps\mp\_utility::func_48B2())
		{
			if(isdefined(self.javelinuseentered))
			{
				func_660C();
			}

			continue;
		}

		if(self playerads() < 0.95)
		{
			var_06 = gettime();
			func_660C();
			continue;
		}

		var_08 = 0;
		if(getdvar("missileDebugDraw") == "1")
		{
			var_08 = 1;
		}

		var_09 = 0;
		if(getdvar("missileDebugText") == "1")
		{
			var_09 = 1;
		}

		self.javelinuseentered = 1;
		if(!isdefined(self.javelinstage))
		{
			self.javelinstage = 1;
		}

		if(self.javelinstage == 1)
		{
			var_0A = maps\mp\gametypes\_weapons::func_4EE2();
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
					if(!func_8956(var_10[0]))
					{
						continue;
					}

					if(var_09)
					{
					}

					self.javelintarget = var_10[0];
					if(!isdefined(self.javelinlockstarttime))
					{
						self.javelinlockstarttime = gettime();
					}

					self.javelinstage = 2;
					self.javelinlostsightlinetime = 0;
					func_49DA(var_00);
					self.javelinstage = 1;
					continue;
				}
			}

			if(lockmissespassedthreshold())
			{
				func_660C();
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
			var_15 = func_3110();
			if(!isdefined(var_15))
			{
				func_4EDD();
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
					func_4EDD();
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
			func_4EDF();
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
			thread func_4F81("javelin_clu_aquiring_lock",0.6);
			self.javelinstage = 2;
		}

		if(self.javelinstage == 2)
		{
			var_0E = self worldpointinreticle_circle(self.javelintargetpoint,65,45);
			if(!var_0E)
			{
				func_660C();
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
				func_660C();
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
debugsightline(param_00,param_01,param_02)
{
}

//Function Number: 12
func_8956(param_00)
{
	var_01 = self geteye();
	var_02 = param_00 getpointinbounds(0,0,0);
	var_03 = sighttracepassed(var_01,var_02,0,param_00);
	debugsightline(var_01,var_02,var_03);
	if(var_03)
	{
		return 1;
	}

	var_04 = param_00 getpointinbounds(1,0,0);
	var_03 = sighttracepassed(var_01,var_04,0,param_00);
	debugsightline(var_01,var_04,var_03);
	if(var_03)
	{
		return 1;
	}

	var_05 = param_00 getpointinbounds(-1,0,0);
	var_03 = sighttracepassed(var_01,var_05,0,param_00);
	debugsightline(var_01,var_05,var_03);
	if(var_03)
	{
		return 1;
	}

	return 0;
}

//Function Number: 13
func_49DA(param_00)
{
	if(self.javelinstage == 2)
	{
		self weaponlockstart(self.javelintarget);
		if(!func_7BF7(self.javelintarget))
		{
			func_660C();
			self.javelinlockstarttime = undefined;
		}

		var_01 = func_76B2();
		if(!var_01)
		{
			self.javelinlockstarttime = undefined;
		}

		if(!isdefined(self.currentlylocking) || !self.currentlylocking)
		{
			thread func_4F81("javelin_clu_aquiring_lock",0.6);
			self.currentlylocking = 1;
		}

		var_02 = gettime() - self.javelinlockstarttime;
		if(maps\mp\_utility::_hasperk("specialty_fasterlockon"))
		{
			if(var_02 < param_00 * 0.5)
			{
			}
		}
		else if(var_02 < param_00)
		{
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
		var_01 = func_76B2();
		if(!var_01)
		{
		}

		if(!func_7BF7(self.javelintarget))
		{
			func_660C();
		}
	}
}

//Function Number: 14
func_7BF7(param_00)
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
func_76B2()
{
	var_00 = 500;
	if(func_8956(self.javelintarget))
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
		func_660C();
		return 0;
	}

	return 1;
}