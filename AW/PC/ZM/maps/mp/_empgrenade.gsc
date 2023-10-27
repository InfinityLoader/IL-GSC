/*******************************************************************
 * Decompiled By: Bog
 * Decompiled File: maps/mp/_empgrenade.gsc
 * Game: Call of Duty: Advanced Warfare
 * Platform: PC
 * Function Count: 12
 * Decompile Time: 173 ms
 * Timestamp: 10/27/2023 2:08:07 AM
*******************************************************************/

//Function Number: 1
init()
{
	precachedigitaldistortcodeassets();
	thread onplayerconnect();
	precachestring(&"MP_EMP_REBOOTING");
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
		thread monitorempgrenade();
	}
}

//Function Number: 4
monitorempgrenade()
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
			thread applyemp();
		}

		if(var_02 && isdefined(var_00))
		{
			var_00 thread applyemp();
		}
	}
}

//Function Number: 5
emp_hide_hud(param_00)
{
	maps\mp\gametypes\_scrambler::playersethudempscrambledoff(param_00);
}

//Function Number: 6
applyemp()
{
	self notify("applyEmp");
	self endon("applyEmp");
	self endon("death");
	self endon("disconnect");
	wait(0.05);
	self.empduration = 3;
	var_00 = 2;
	if(maps\mp\_utility::isaugmentedgamemode())
	{
		var_00 = 1;
		maps\mp\_utility::playerallowhighjump(0,"empgrenade");
		maps\mp\_utility::playerallowhighjumpdrop(0,"empgrenade");
		maps\mp\_utility::playerallowboostjump(0,"empgrenade");
		maps\mp\_utility::playerallowpowerslide(0,"empgrenade");
		maps\mp\_utility::playerallowdodge(0,"empgrenade");
	}

	self.empgrenaded = 1;
	self.empendtime = gettime() + self.empduration * 1000;
	var_01 = maps\mp\gametypes\_scrambler::playersethudempscrambled(self.empendtime,var_00,"emp");
	thread digitaldistort(self.empduration,var_01);
	thread emprumbleloop(0.75);
	self setempjammed(1);
	thread empgrenadedeathwaiter(var_01);
	wait(self.empduration);
	self notify("empGrenadeTimedOut");
	checktoturnoffemp(var_01);
}

//Function Number: 7
digitaldistort(param_00,param_01)
{
	self endon("death");
	self endon("disconnect");
	self endon("faux_spawn");
	self endon("joined_team");
	self digitaldistortsetmaterial("digital_distort_mp");
	self digitaldistortsetparams(1,1);
	thread watchdistortdisconnectdeath(param_01);
	wait(0.1);
	var_02 = param_00;
	var_03 = 0.95;
	var_04 = 0.2;
	var_05 = var_03 - var_04;
	var_06 = 0.1;
	var_07 = var_03;
	while(var_02 > 0)
	{
		var_07 = var_05 * var_02 / param_00 + var_04;
		self digitaldistortsetparams(var_07,1);
		var_02 = var_02 - var_06;
		wait(var_06);
	}

	self digitaldistortsetparams(0,0);
}

//Function Number: 8
watchdistortdisconnectdeath(param_00)
{
	common_scripts\utility::waittill_any("death","disconnect","faux_spawn","joined_team");
	if(isdefined(self))
	{
		self digitaldistortsetparams(0,0);
		emp_hide_hud(param_00);
	}
}

//Function Number: 9
empgrenadedeathwaiter(param_00)
{
	self notify("empGrenadeDeathWaiter");
	self endon("empGrenadeDeathWaiter");
	self endon("empGrenadeTimedOut");
	self waittill("death");
	checktoturnoffemp(param_00);
}

//Function Number: 10
checktoturnoffemp(param_00)
{
	self.empgrenaded = 0;
	self setempjammed(0);
	if(maps\mp\_utility::isaugmentedgamemode())
	{
		maps\mp\_utility::playerallowhighjump(1,"empgrenade");
		maps\mp\_utility::playerallowhighjumpdrop(1,"empgrenade");
		maps\mp\_utility::playerallowboostjump(1,"empgrenade");
		maps\mp\_utility::playerallowpowerslide(1,"empgrenade");
		maps\mp\_utility::playerallowdodge(1,"empgrenade");
	}

	self digitaldistortsetparams(0,0);
	emp_hide_hud(param_00);
}

//Function Number: 11
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

//Function Number: 12
isempgrenaded()
{
	return isdefined(self.empendtime) && gettime() < self.empendtime;
}