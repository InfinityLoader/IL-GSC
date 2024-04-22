/*******************************************************************
 * Decompiled By: Bog
 * Decompiled File: _juggernaut.gsc
 * Game: Call of Duty: Advanced Warfare
 * Platform: PC
 * Function Count: 5
 * Decompile Time: 85 ms
 * Timestamp: 4/22/2024 2:21:36 AM
*******************************************************************/

//Function Number: 1
main()
{
	if(isdefined(level.juggernaut_initialized))
	{
		return;
	}

	level.juggernaut_initialized = 1;
	if(!isdefined(level.subclass_spawn_functions))
	{
		level.subclass_spawn_functions = [];
	}

	level.subclass_spawn_functions["juggernaut"] = ::subclass_juggernaut;
	level.juggernaut_next_alert_time = 0;
}

//Function Number: 2
subclass_juggernaut()
{
	self.juggernaut = 1;
	self.minpaindamage = 200;
	self.grenadeammo = 0;
	self.doorflashchance = 0.05;
	self.aggressivemode = 1;
	self.ignoresuppression = 1;
	self.no_pistol_switch = 1;
	self.norunngun = 1;
	self.dontmelee = 1;
	self.disableexits = 1;
	self.disablearrivals = 1;
	self.disablebulletwhizbyreaction = 1;
	self.combatmode = "no_cover";
	self.neversprintforvariation = 1;
	self.a.disablelongdeath = 1;
	maps\_utility::disable_turnanims();
	maps\_utility::disable_surprise();
	init_juggernaut_animsets();
	maps\_utility::add_damage_function(::animscripts\pain::additive_pain);
	maps\_utility::add_damage_function(::maps\_spawner::pain_resistance);
	if(!self isbadguy())
	{
		return;
	}

	self.bullet_resistance = 40;
	maps\_utility::add_damage_function(::maps\_spawner::bullet_resistance);
	thread juggernaut_hunt_immediately_behavior();
	thread juggernaut_sound_when_player_close();
	self.pathenemyfightdist = 128;
	self.pathenemylookahead = 128;
	self setstompbreakthrough(0);
	level notify("juggernaut_spawned");
	self waittill("death",var_00,var_01,var_02);
	if(isdefined(self) && isdefined(self.nodrop))
	{
		var_03 = [];
		var_03[var_03.size] = "left";
		var_03[var_03.size] = "right";
		var_03[var_03.size] = "chest";
		var_03[var_03.size] = "back";
		animscripts\shared::detachallweaponmodels();
		foreach(var_05 in var_03)
		{
			var_02 = self.a.weaponpos[var_05];
			if(var_02 == "none")
			{
				continue;
			}

			self.weaponinfo[var_02].position = "none";
			self.a.weaponpos[var_05] = "none";
		}

		self.weapon = "none";
		animscripts\shared::updateattachedweaponmodels();
	}

	level notify("juggernaut_died");
	if(!isdefined(self))
	{
		return;
	}

	if(!isdefined(var_00))
	{
		return;
	}

	if(!isplayer(var_00))
	{
	}
}

//Function Number: 3
juggernaut_hunt_immediately_behavior()
{
	self endon("death");
	self endon("stop_hunting");
	self.usechokepoints = 0;
	for(;;)
	{
		wait(0.5);
		if(isdefined(self.enemy))
		{
			self setgoalpos(self.enemy.origin);
			self.goalradius = 128;
			self.goalheight = 81;
		}
	}
}

//Function Number: 4
juggernaut_sound_when_player_close()
{
	self endon("death");
	level endon("special_op_terminated");
	if(isdefined(level.skip_juggernaut_intro_sound) && level.skip_juggernaut_intro_sound)
	{
		return;
	}

	var_00 = 2500;
	if(level.script == "ending")
	{
		common_scripts\utility::flag_wait("panic_button");
		var_00 = 750;
	}

	for(;;)
	{
		wait(0.05);
		if(gettime() < level.juggernaut_next_alert_time)
		{
			continue;
		}

		var_01 = maps\_utility::get_closest_player(self.origin);
		if(!isalive(var_01))
		{
			continue;
		}

		if(distance(var_01.origin,self.origin) > var_00)
		{
			continue;
		}

		if(isdefined(level.pmc_alljuggernauts) && level.pmc_alljuggernauts)
		{
			var_02 = self gettagorigin("tag_flash");
			if(!bullettracepassed(self geteye(),var_01 geteye(),0,undefined))
			{
				wait(0.25);
				continue;
			}
		}

		break;
	}

	level.juggernaut_next_alert_time = gettime() + 15000;
	level notify("juggernaut_attacking");
}

//Function Number: 5
init_juggernaut_animsets()
{
	self.walkdist = 500;
	self.walkdistfacingmotion = 500;
	maps\_utility::set_move_animset("run",%juggernaut_runf,%juggernaut_sprint);
	maps\_utility::set_move_animset("walk",%juggernaut_walkf);
	maps\_utility::set_move_animset("cqb",%juggernaut_walkf);
	maps\_utility::set_combat_stand_animset(%juggernaut_stand_fire_burst,%juggernaut_aim5,%juggernaut_stand_idle,%juggernaut_stand_reload);
}