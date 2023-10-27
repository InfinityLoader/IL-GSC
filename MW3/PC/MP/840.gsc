/*******************************************************************
 * Decompiled By: Bog
 * Decompiled File: 840.gsc
 * Game: Call of Duty: Modern Warfare 3
 * Platform: PC
 * Function Count: 9
 * Decompile Time: 1 ms
 * Timestamp: 10/27/2023 2:16:50 AM
*******************************************************************/

//Function Number: 1
init()
{
	precacheshellshock("flashbang_mp");
	thread onplayerconnect();
}

//Function Number: 2
onplayerconnect()
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
		thread func_2C55();
	}
}

//Function Number: 4
func_2C55()
{
	self endon("death");
	self endon("disconnect");
	self endon("faux_spawn");
	self.empendtime = 0;
	for(;;)
	{
		self waittill("emp_grenaded",var_00);
		if(!isalive(self))
		{
			continue;
		}

		if(isdefined(self.usingremote))
		{
			continue;
		}

		if(maps\mp\_utility::_hasperk("specialty_empimmune"))
		{
			continue;
		}

		var_01 = 1;
		var_02 = 0;
		if(level.teambased && isdefined(var_00) && isdefined(var_00.pers["team"]) && var_00.pers["team"] == self.pers["team"] && var_00 != self)
		{
			if(level.friendlyfire == 0)
			{
				continue;
			}
			else if(level.friendlyfire == 1)
			{
				var_02 = 0;
				var_01 = 1;
			}
			else if(level.friendlyfire == 2)
			{
				var_01 = 0;
				var_02 = 1;
			}
			else if(level.friendlyfire == 3)
			{
				var_02 = 1;
				var_01 = 1;
			}
		}
		else if(isdefined(var_00))
		{
			var_00 notify("emp_hit");
			if(var_00 != self)
			{
				var_00 maps\mp\gametypes\_missions::processchallenge("ch_onthepulse");
			}
		}

		if(var_01 && isdefined(self))
		{
			thread func_2C58();
		}

		if(var_02 && isdefined(var_00))
		{
			var_00 thread func_2C58();
		}
	}
}

//Function Number: 5
func_2C58()
{
	self notify("applyEmp");
	self endon("applyEmp");
	self endon("death");
	wait 0.05;
	self.var_2C59 = 10;
	self.empgrenaded = 1;
	self shellshock("flashbang_mp",1);
	self.empendtime = gettime() + self.var_2C59 * 1000;
	thread func_2C5F(0.75);
	self setempjammed(1);
	thread func_2C5B();
	wait self.var_2C59;
	self notify("empGrenadeTimedOut");
	func_2C5C();
}

//Function Number: 6
func_2C5B()
{
	self notify("empGrenadeDeathWaiter");
	self endon("empGrenadeDeathWaiter");
	self endon("empGrenadeTimedOut");
	self waittill("death");
	func_2C5C();
}

//Function Number: 7
func_2C5C()
{
	self.empgrenaded = 0;
	if((level.teambased && level.teamemped[self.team] || level.teamnukeemped[self.team]) || !level.teambased && isdefined(level.empplayer) && level.empplayer != self || !level.teambased && isdefined(level.nukeinfo.player) && level.nukeinfo.player != self)
	{
		return;
	}

	self setempjammed(0);
}

//Function Number: 8
func_2C5F(param_00)
{
	self endon("emp_rumble_loop");
	self notify("emp_rumble_loop");
	var_01 = gettime() + param_00 * 1000;
	while(gettime() < var_01)
	{
		self playrumbleonentity("damage_heavy");
		wait 0.05;
	}
}

//Function Number: 9
func_2C60()
{
	return isdefined(self.empendtime) && gettime() < self.empendtime;
}