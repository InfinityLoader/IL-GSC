/*******************************************************************
 * Decompiled By: Bog
 * Decompiled File: maps\mp\_empgrenade.gsc
 * Game: Call of Duty: Ghosts
 * Platform: Console
 * Function Count: 9
 * Decompile Time: 134 ms
 * Timestamp: 10/27/2023 1:29:50 AM
*******************************************************************/

//Function Number: 1
func_44DF()
{
	thread func_595D();
}

//Function Number: 2
func_595D()
{
	for(;;)
	{
		level waittill("connected",var_00);
		var_00 thread onplayerspawned();
	}
}

//Function Number: 3
onplayerspawned()
{
	self endon("disconnect");
	for(;;)
	{
		self waittill("spawned_player");
		thread func_5382();
	}
}

//Function Number: 4
func_5382()
{
	self endon("death");
	self endon("disconnect");
	self endon("faux_spawn");
	self.empendtime = 0;
	for(;;)
	{
		self waittill("emp_damage",var_00,var_01);
		if(!isalive(self) || isdefined(self.usingremote) || maps\mp\_utility::_hasperk("specialty_empimmune") || !isdefined(var_00))
		{
			continue;
		}

		var_02 = 1;
		var_03 = 0;
		if(level.teambased && var_00 != self && isdefined(var_00.pers["team"]) && var_00.pers["team"] == self.pers["team"])
		{
			if(level.friendlyfire == 0)
			{
				continue;
			}
			else if(level.friendlyfire == 1)
			{
				var_03 = 0;
				var_02 = 1;
			}
			else if(level.friendlyfire == 2)
			{
				var_02 = 0;
				var_03 = 1;
			}
			else if(level.friendlyfire == 3)
			{
				var_03 = 1;
				var_02 = 1;
			}
		}
		else
		{
			var_00 notify("emp_hit");
			if(var_00 != self)
			{
				var_00 maps\mp\gametypes\_missions::func_61CE("ch_onthepulse");
			}
		}

		if(var_02 && isdefined(self))
		{
			thread func_0EAA(var_01);
		}

		if(var_03)
		{
			var_00 thread func_0EAA(var_01);
		}
	}
}

//Function Number: 5
func_0EAA(param_00)
{
	self notify("applyEmp");
	self endon("applyEmp");
	self endon("disconnect");
	self endon("death");
	wait(0.05);
	self.empgrenaded = 1;
	self shellshock("flashbang_mp",1);
	self.empendtime = gettime() + param_00 * 1000;
	lib_05FE::applyperplayerempeffects_ondetonate();
	lib_05FE::applyperplayerempeffects();
	thread emprumbleloop(0.75);
	thread func_2C85();
	wait(param_00);
	self notify("empGrenadeTimedOut");
	func_1BDC();
}

//Function Number: 6
func_2C85()
{
	self notify("empGrenadeDeathWaiter");
	self endon("empGrenadeDeathWaiter");
	self endon("empGrenadeTimedOut");
	self waittill("death");
	func_1BDC();
}

//Function Number: 7
func_1BDC()
{
	self.empgrenaded = 0;
	if(!lib_05FE::func_74B9())
	{
		lib_05FE::func_65A7();
	}
}

//Function Number: 8
emprumbleloop(param_00)
{
	self endon("emp_rumble_loop");
	self notify("emp_rumble_loop");
	var_01 = gettime() + param_00 * 1000;
	while(gettime() < var_01)
	{
		self playrumbleonentity("damage_heavy");
		wait(0.05);
	}
}

//Function Number: 9
func_48B3()
{
	return isdefined(self.empendtime) && gettime() < self.empendtime;
}