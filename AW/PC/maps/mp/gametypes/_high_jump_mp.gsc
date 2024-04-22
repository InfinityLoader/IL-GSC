/*******************************************************************
 * Decompiled By: Bog
 * Decompiled File: mp\gametypes\_high_jump_mp.gsc
 * Game: Call of Duty: Advanced Warfare
 * Platform: PC
 * Function Count: 7
 * Decompile Time: 113 ms
 * Timestamp: 4/22/2024 2:09:34 AM
*******************************************************************/

//Function Number: 1
init()
{
	if(!maps\mp\_utility::isaugmentedgamemode())
	{
		return;
	}

	level.map_border_trig_array = getentarray("boost_jump_border_trig","targetname");
	high_jump_enable();
	thread high_jump_host_migration();
	thread high_jump_on_player_spawn();
}

//Function Number: 2
high_jump_enable()
{
}

//Function Number: 3
high_jump_on_player_spawn()
{
	level endon("game_ended");
	for(;;)
	{
		level waittill("player_spawned",var_00);
		var_00 thread map_border_hud_updater();
		var_00 maps\mp\_utility::playerallowhighjump(1);
		var_00 maps\mp\_utility::playerallowhighjumpdrop(1);
		var_00 maps\mp\_utility::playerallowboostjump(1);
		var_00 maps\mp\_utility::playerallowpowerslide(1);
		var_00 maps\mp\_utility::playerallowdodge(1);
		var_00 thread exo_dodge_think();
		var_00 setclientomnvar("ui_border_warning_toggle",0);
	}
}

//Function Number: 4
high_jump_host_migration()
{
	level endon("game_ended");
	for(;;)
	{
		level waittill("host_migration_end");
		high_jump_enable();
	}
}

//Function Number: 5
map_border_hud_updater()
{
	level endon("game_ended");
	self endon("death");
	self endon("disconnect");
	self endon("joined_team");
	self.touching_border = undefined;
	for(;;)
	{
		if(isdefined(level.map_border_trig_array))
		{
			var_00 = 0;
			foreach(var_02 in level.map_border_trig_array)
			{
				var_03 = self istouching(var_02);
				if(var_03)
				{
					var_00 = 1;
					break;
				}
			}

			if(!isdefined(self.touching_border) || self.touching_border != var_00)
			{
				if(var_00)
				{
					self setclientomnvar("ui_border_warning_toggle",1);
				}
				else
				{
					self setclientomnvar("ui_border_warning_toggle",0);
				}

				self.touching_border = var_00;
			}
		}

		wait(0.05);
	}
}

//Function Number: 6
exo_dodge_think()
{
	self endon("death");
	self endon("disconnect");
	self endon("faux_spawn");
	for(;;)
	{
		self waittill("exo_dodge");
		var_00 = getdvarfloat("dodge_cooldown_time_sec",0.2);
		thread exo_dodge_cooldown();
		maps\mp\_exo_suit::exo_power_cooldown(var_00);
		var_01 = gettime();
		if(isdefined(self.lastdamagedtime) && var_01 - self.lastdamagedtime < 1000)
		{
			maps\mp\gametypes\_missions::processchallengedaily(38,undefined,undefined);
		}
	}
}

//Function Number: 7
exo_dodge_cooldown()
{
	var_00 = getdvarfloat("dodge_weapon_enable",1);
	if(!var_00)
	{
		var_01 = getdvarint("exo_dodge_weapon_disable_time",0.2);
		common_scripts\utility::_disableweapon();
		wait(var_01);
		common_scripts\utility::_enableweapon();
	}
}