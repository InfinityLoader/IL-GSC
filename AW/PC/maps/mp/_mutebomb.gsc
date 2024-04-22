/*******************************************************************
 * Decompiled By: Bog
 * Decompiled File: mp\_mutebomb.gsc
 * Game: Call of Duty: Advanced Warfare
 * Platform: PC
 * Function Count: 7
 * Decompile Time: 124 ms
 * Timestamp: 4/22/2024 2:16:07 AM
*******************************************************************/

//Function Number: 1
watchmutebombusage()
{
	self endon("spawned_player");
	self endon("disconnect");
	self endon("death");
	self endon("faux_spawn");
	if(!isdefined(level.adrenalinesettings))
	{
		mutebombinit();
	}

	for(;;)
	{
		self waittill("grenade_fire",var_00,var_01);
		if(var_01 == "mute_bomb_mp")
		{
			if(!isalive(self))
			{
				var_00 delete();
				return;
			}

			thread tryusemutebomb(var_00);
		}
	}
}

//Function Number: 2
mutebombinit()
{
	self.adrenalinesettings = spawnstruct();
}

//Function Number: 3
tryusemutebomb(param_00)
{
	if(!isdefined(self.adrenalinesettings))
	{
		mutebombinit();
	}

	thread startmutebomb(param_00);
	thread monitorplayerdeath(param_00);
	param_00 thread monitormutebombdeath();
	return 1;
}

//Function Number: 4
startmutebomb(param_00)
{
	self endon("ClearMuteBomb");
	self endon("death");
	param_00 endon("death");
	param_00 playsound("mute_device_activate");
	wait(0.75);
	param_00 addsoundmutedevice(350,600,0.25);
	param_00 playloopsound("mute_device_active_lp");
	param_00 thread monitormutebombplayers();
	wait(20);
	param_00 scalevolume(0,0.25);
	param_00 removesoundmutedevice(0.25);
	param_00 notify("ShutdownMuteBomb");
	wait(0.25);
	param_00 stoploopsound();
}

//Function Number: 5
monitorplayerdeath(param_00)
{
	param_00 endon("ShutdownMuteBomb");
	self waittill("death");
	if(isdefined(param_00))
	{
		param_00 removesoundmutedevice(0.25);
		param_00 notify("ShutdownMuteBomb");
	}
}

//Function Number: 6
monitormutebombdeath()
{
	self endon("ShutdownMuteBomb");
	self waittill("death");
	if(isdefined(self))
	{
		self removesoundmutedevice(0.25);
		self notify("ShutdownMuteBomb");
	}
}

//Function Number: 7
monitormutebombplayers()
{
	self endon("ShutdownMuteBomb");
	var_00 = 475;
	self.touchingplayers = [];
	for(;;)
	{
		foreach(var_02 in level.players)
		{
			var_03 = distance(self.origin,var_02.origin);
			var_04 = common_scripts\utility::array_contains(self.touchingplayers,var_02);
			if(var_03 <= var_00)
			{
				if(!var_04)
				{
					self.touchingplayers = common_scripts\utility::array_add(self.touchingplayers,var_02);
					var_02 playlocalsound("mute_device_active_enter");
				}

				continue;
			}

			if(var_04)
			{
				self.touchingplayers = common_scripts\utility::array_remove(self.touchingplayers,var_02);
				var_02 playlocalsound("mute_device_active_exit");
			}
		}

		wait(0.05);
	}
}