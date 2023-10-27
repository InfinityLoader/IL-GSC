/*******************************************************************
 * Decompiled By: Bog
 * Decompiled File: maps/mp/_trackrounds.gsc
 * Game: Call of Duty: Advanced Warfare
 * Platform: PC
 * Function Count: 5
 * Decompile Time: 71 ms
 * Timestamp: 10/27/2023 2:08:40 AM
*******************************************************************/

//Function Number: 1
trackrounds_think()
{
	if(getdvar("mapname") == getdvar("virtualLobbyMap"))
	{
		return;
	}

	self endon("death");
	self endon("disconnect");
	self endon("faux_spawn");
	self.trackrounds = spawnstruct();
	self.trackrounds.has_paint_pro = 0;
	self.trackrounds.has_trackrounds = 0;
	if(maps\mp\_utility::_hasperk("specialty_paint_pro"))
	{
		self.trackrounds.has_paint_pro = 1;
	}

	var_00 = self getcurrentweapon();
	toggle_has_trackrounds(var_00);
	for(;;)
	{
		self waittill("weapon_change",var_00);
		if(var_00 == "none")
		{
			wait(0.4);
			var_00 = self getcurrentweapon();
			if(var_00 == "none")
			{
				return;
			}
		}

		toggle_has_trackrounds(var_00);
		wait(0.05);
	}
}

//Function Number: 2
toggle_has_trackrounds(param_00)
{
	var_01 = undefined;
	if(isdefined(param_00))
	{
		var_01 = getweaponattachments(param_00);
	}

	if(isdefined(var_01))
	{
		foreach(var_03 in var_01)
		{
			if(var_03 == "trackrounds")
			{
				self.trackrounds.has_trackrounds = 1;
				maps\mp\_utility::giveperk("specialty_paint_pro",0,0);
				return;
			}
		}

		self.trackrounds.has_trackrounds = 0;
		if(!self.trackrounds.has_paint_pro)
		{
			maps\mp\_utility::_unsetperk("specialty_paint_pro");
		}
	}
}

//Function Number: 3
set_painted_trackrounds(param_00)
{
	if(isplayer(self))
	{
		if(isdefined(self.painted_tracked) && self.painted_tracked)
		{
			return;
		}

		self.painted_tracked = 1;
		thread trackrounds_mark_till_death();
	}
}

//Function Number: 4
trackrounds_death()
{
	self endon("disconnect");
	level endon("game_ended");
	self waittill("death");
	self.painted_tracked = 0;
}

//Function Number: 5
trackrounds_mark_till_death()
{
	self endon("disconnect");
	self endon("death");
	level endon("game_ended");
	thread trackrounds_death();
	for(;;)
	{
		wait(0.1);
		if(self hasperk("specialty_radararrow",1))
		{
			continue;
		}

		if(self hasperk("specialty_radarblip",1))
		{
			continue;
		}

		self setperk("specialty_radarblip",1,0);
	}
}