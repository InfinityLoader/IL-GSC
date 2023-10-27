/*******************************************************************
 * Decompiled By: Bog
 * Decompiled File: scripts\mp\_healthoverlay.gsc
 * Game: Call of Duty: Infinite Warfare
 * Platform: PC
 * Function Count: 8
 * Decompile Time: 346 ms
 * Timestamp: 10/27/2023 12:20:31 AM
*******************************************************************/

//Function Number: 1
init()
{
	level.var_8CBC = 0.55;
	var_00 = scripts\mp\_tweakables::func_81E7("player","healthregentime");
	level.var_8CC1 = var_00 <= 0;
	level.var_D3A4 = var_00;
	level thread func_C56E();
}

//Function Number: 2
func_C56E()
{
	for(;;)
	{
		level waittill("connected",var_00);
		var_00 thread func_C57B();
	}
}

//Function Number: 3
func_C57B()
{
	self endon("disconnect");
	for(;;)
	{
		self waittill("spawned_player");
		thread func_D3A5();
		self visionsetthermalforplayer(game["thermal_vision"]);
	}
}

//Function Number: 4
func_D3A5()
{
	self endon("death");
	self endon("disconnect");
	self endon("joined_team");
	self endon("joined_spectators");
	self endon("faux_spawn");
	level endon("game_ended");
	if(self.health <= 0)
	{
		return;
	}

	var_00 = 0;
	var_01 = 0;
	thread func_D368(self.maxhealth * 0.55);
	for(;;)
	{
		scripts\common\utility::waittill_any_3("damage","force_regen","force_regeneration");
		if(self.health <= 0)
		{
			return;
		}

		if(scripts\mp\_utility::func_9E59())
		{
			continue;
		}

		var_01 = gettime();
		var_02 = self.health / self.maxhealth;
		self.var_DE8E = level.var_D3A4;
		if(scripts\mp\_utility::_hasperk("specialty_regenfaster"))
		{
			self.var_DE8E = self.var_DE8E * level.var_DE8A;
		}

		if(var_02 <= level.var_8CBC)
		{
			self.var_2410 = 1;
		}

		thread func_8CC4(var_01,var_02);
	}
}

//Function Number: 5
func_D367()
{
	self notify("playerBreathingBetterSound");
	self endon("playerBreathingBetterSound");
	self endon("death");
	self endon("disconnect");
	self endon("joined_team");
	self endon("joined_spectators");
	level endon("game_ended");
	if(level.var_7669)
	{
		return;
	}

	if(!isplayer(self))
	{
		return;
	}

	if(scripts\mp\_utility::func_9FC6())
	{
		return;
	}

	if(scripts\mp\_utility::func_9D48("archetype_scout"))
	{
		self playlocalsound("breathing_better_c6");
		return;
	}

	if(scripts\mp\_utility::isfemale())
	{
		self playlocalsound("Fem_breathing_better");
		return;
	}

	self playlocalsound("breathing_better");
}

//Function Number: 6
func_8CC4(param_00,param_01)
{
	self notify("healthRegeneration");
	self endon("healthRegeneration");
	self endon("death");
	self endon("disconnect");
	self endon("joined_team");
	self endon("joined_spectators");
	level endon("game_ended");
	if(!scripts\mp\_utility::_hasperk("specialty_adrenaline"))
	{
		if(level.var_8CC1)
		{
			return;
		}

		while(scripts\mp\_utility::func_9FB3(self.var_8CC1))
		{
			wait(0.5);
		}
	}

	if(!scripts\mp\_utility::_hasperk("specialty_adrenaline"))
	{
		scripts\mp\_utility::wait_endon(self.var_DE8E,"force_regeneration");
	}

	if(param_01 < 0.55)
	{
		var_02 = 1;
	}
	else
	{
		var_02 = 0;
	}

	if(scripts\mp\_utility::_hasperk("specialty_adrenaline") || scripts\mp\_utility::_hasperk("specialty_regenfaster"))
	{
		self setclientomnvar("ui_health_regen_hud",1);
	}

	var_03 = self.maxhealth / 50;
	var_04 = 0;
	var_05 = gettime();
	for(;;)
	{
		if(scripts\mp\_utility::func_9FB3(self.var_8CC1) && !scripts\mp\_utility::_hasperk("specialty_adrenaline"))
		{
			return;
		}

		wait(0.05);
		var_06 = 0;
		if(scripts\mp\_utility::_hasperk("specialty_adrenaline") || scripts\mp\_utility::_hasperk("specialty_adrenaline_lite"))
		{
			var_06 = lib_0DD5::func_7EF5();
		}
		else if(scripts\mp\_utility::_hasperk("specialty_regenfaster"))
		{
			var_06 = var_03 * level.var_DE89;
		}
		else
		{
			var_06 = var_03;
		}

		var_07 = 0;
		if(self.health < self.maxhealth)
		{
			var_07 = 1;
			var_08 = self.health + var_06 + var_04;
			var_09 = int(min(self.maxhealth,var_08));
			self.health = var_09;
			var_04 = var_08 - var_09;
		}

		if(self.health >= self.maxhealth)
		{
			self.health = self.maxhealth;
			if(var_07 && scripts\mp\_utility::_hasperk("specialty_regenfaster"))
			{
				scripts\mp\_missions::func_D991("ch_trait_icu");
			}

			break;
		}
	}

	self notify("healed");
	thread scripts\mp\_damage::func_E143();
	func_D367();
	self setclientomnvar("ui_health_regen_hud",0);
}

//Function Number: 7
func_135F0()
{
	self notify("waiting_to_stop_remote");
	self endon("waiting_to_stop_remote");
	self endon("death");
	level endon("game_ended");
	self waittill("stopped_using_remote");
	scripts\mp\_utility::func_E2D8(0);
}

//Function Number: 8
func_D368(param_00)
{
	level endon("game_ended");
	self endon("death");
	self endon("disconnect");
	self endon("joined_team");
	self endon("joined_spectators");
	if(!isplayer(self))
	{
		return;
	}

	self.hardcoreinjuredlooopsplayed = 0;
	wait(2);
	for(;;)
	{
		wait(0.2);
		if(self.health <= 0)
		{
			return;
		}

		if(self.health >= param_00)
		{
			continue;
		}

		var_01 = level.var_8CC1 || isdefined(self.var_8CC1) && self.var_8CC1;
		if(scripts\mp\_utility::func_9FC6())
		{
			continue;
		}

		if(scripts\mp\_utility::func_9D48("archetype_scout"))
		{
			self playlocalsound("breathing_hurt_c6");
		}
		else if(scripts\mp\_utility::isfemale())
		{
			self playlocalsound("Fem_breathing_hurt");
		}
		else
		{
			self playlocalsound("breathing_hurt");
		}

		wait(1.5);
		if(level.var_8B38)
		{
			self.hardcoreinjuredlooopsplayed++;
			if(self.hardcoreinjuredlooopsplayed > 3)
			{
				return;
			}
		}
	}
}