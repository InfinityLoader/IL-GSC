/*******************************************************************
 * Decompiled By: Bog
 * Decompiled File: irons_estate_drone.gsc
 * Game: Call of Duty: Advanced Warfare
 * Platform: PC
 * Function Count: 13
 * Decompile Time: 214 ms
 * Timestamp: 4/22/2024 2:31:53 AM
*******************************************************************/

//Function Number: 1
main()
{
	common_scripts\utility::flag_init("force_stealth_spotted_drones");
	common_scripts\utility::flag_init("drones_investigating");
	level.dronespawnertemplate = getent("droneSpawnerTemplate","targetname");
	level.dronespawners = common_scripts\utility::getstructarray("droneSpawner","targetname");
	level.dronespawnerexits = [];
	foreach(var_01 in level.dronespawners)
	{
		if(isdefined(var_01.script_noteworthy) && var_01.script_noteworthy == "droneDespawner")
		{
			level.dronespawnerexits[level.dronespawnerexits.size] = var_01;
		}
	}

	if(!isdefined(level.stealth_spotted_drones))
	{
		level.stealth_spotted_drones = [];
	}

	thread drones_can_see_enemy_test();
	thread drones_stealth_detect();
}

//Function Number: 2
drones_stealth_detect()
{
	for(;;)
	{
		wait(0.05);
		if(!isdefined(level.active_drones))
		{
			continue;
		}

		foreach(var_01 in level.active_drones)
		{
			if(isdefined(var_01.threatsightdelay) && var_01.threatsightdelay > 0)
			{
				level.player maps\_stealth_display::stealth_display_seed(var_01,var_01.threatsightdelay,var_01.canseeplayer);
			}
		}
	}
}

//Function Number: 3
stealth_alerted_drone_monitor()
{
	level notify("stealth_alerted_drone_monitor");
	level endon("stealth_alerted_drone_monitor");
	level.player endon("death");
	level endon("meet_cormack_end");
}

//Function Number: 4
drone_investigate_monitor()
{
	level notify("drone_investigate_monitor");
	level endon("drone_investigate_monitor");
	if(!isdefined(level.drone_investigates))
	{
		level.drone_investigates = [];
	}

	for(;;)
	{
		level waittill("drone_investigate",var_00,var_01,var_02,var_03);
		level thread drone_investigate_initiate(var_00,var_01,var_02,var_03);
	}
}

//Function Number: 5
drone_investigate_initiate(param_00,param_01,param_02,param_03)
{
	if(isdefined(level.stealth_spotted_drones) && level.stealth_spotted_drones.size > 0)
	{
		return;
	}

	if(isdefined(param_01))
	{
		var_04 = param_01 common_scripts\utility::waittill_any_timeout_no_endon_death(5,"death");
		if(var_04 != "timeout")
		{
			return;
		}
	}

	if(!vehicle_scripts\_pdrone_security::drone_investigate_try_location(param_00,param_02,param_03) && isdefined(param_01))
	{
		vehicle_scripts\_pdrone_security::drone_investigate_try_location(param_01.origin,param_02,param_03);
	}
}

//Function Number: 6
stealth_spotted_drone_monitor()
{
	level.player endon("death");
	level endon("stop_stealth_spotted_drone_monitor");
	level endon("meet_cormack_end");
	for(;;)
	{
		common_scripts\utility::flag_waitopen("_stealth_spotted");
		var_00 = common_scripts\utility::flag_wait_any_return("_stealth_spotted","force_stealth_spotted_drones");
		level.abort_drones = 0;
		level thread level_drone_abort_monitor();
		if(var_00 == "_stealth_spotted" || var_00 == "force_stealth_spotted_drones")
		{
			if(var_00 == "_stealth_spotted")
			{
				wait(4);
				if(!common_scripts\utility::flag("_stealth_spotted"))
				{
					continue;
				}
			}

			foreach(var_02 in level.stealth_spotted_drones)
			{
				var_02.pacifist = 0;
				var_02 maps\_utility::ent_flag_clear("fire_disabled");
			}

			var_04 = sortbydistance(level.dronespawners,level.player.origin);
			var_05 = sortbydistance(level.active_drones,level.player.origin,4000);
			var_06 = 0;
			var_07 = cos(60);
			var_08 = 0;
			while(!level.abort_drones && common_scripts\utility::flag("_stealth_spotted") && var_08 < 4)
			{
				var_05 = maps\_utility::remove_dead_from_array(var_05);
				if(var_06 >= var_04.size)
				{
					var_06 = 0;
				}

				if(var_05.size > 0)
				{
					var_05[0] vehicle_scripts\_pdrone_security::drone_set_mode("attack",0);
					var_05[0] thread drone_abort_monitor();
					var_05 = common_scripts\utility::array_remove(var_05,var_05[0]);
					var_08 = var_08 + 1;
					continue;
				}

				var_09 = anglestoforward(level.player getplayerangles());
				while(var_06 < var_04.size)
				{
					var_0A = vectornormalize(var_04[var_06].origin - level.player.origin);
					if(vectordot(var_0A,var_09) < var_07)
					{
						break;
					}

					var_06++;
				}

				if(var_06 < var_04.size)
				{
					var_02 = vehicle_scripts\_pdrone_security::drone_spawn(var_04[var_06],"attack");
					var_02 thread drone_stealth_display_seed_always();
					var_02 thread stealth_spotted_drone_death_monitor();
					if(isdefined(level.stealth_spotted_drones))
					{
						level.stealth_spotted_drones = common_scripts\utility::array_add(level.stealth_spotted_drones,var_02);
					}

					var_08 = var_08 + 1;
					var_02 thread drone_damage_monitor();
					var_02 thread drone_abort_monitor();
					var_06++;
				}
				else
				{
					var_06 = 0;
				}

				wait(0.5);
			}
		}

		wait(1);
	}
}

//Function Number: 7
drone_stealth_display_seed_always()
{
	self notify("drone_stealth_display_seed_always");
	self endon("drone_stealth_display_seed_always");
	self endon("death");
	for(;;)
	{
		if(common_scripts\utility::flag("_stealth_spotted"))
		{
			level.player maps\_stealth_display::stealth_display_seed(self,1,1);
		}

		wait(0.05);
	}
}

//Function Number: 8
drones_can_see_enemy_test()
{
	level.player endon("death");
	for(;;)
	{
		level.drones_lost_player_time = 0;
		while(!common_scripts\utility::flag("_stealth_spotted"))
		{
			while(level.stealth_spotted_drones.size > 0 && level.drones_lost_player_time <= 6)
			{
				var_00 = 0;
				foreach(var_02 in level.stealth_spotted_drones)
				{
					var_03 = var_02.origin;
					if(var_02 gettagindex("tag_flash") != -1)
					{
						var_03 = var_02 gettagorigin("tag_flash");
					}

					if(sighttracepassed(var_03,level.player geteye(),0,var_02,level.player))
					{
						var_00 = 1;
						break;
					}
				}

				if(var_00)
				{
					level.drones_lost_player_time = 0;
				}
				else
				{
					level.drones_lost_player_time = level.drones_lost_player_time + 0.05;
				}

				if(level.drones_lost_player_time >= 6)
				{
					foreach(var_02 in level.stealth_spotted_drones)
					{
						var_02 thread drone_fly_away();
					}

					common_scripts\utility::flag_clear("force_stealth_spotted_drones");
				}

				wait(0.05);
			}

			wait(0.05);
		}

		wait(0.05);
	}
}

//Function Number: 9
stealth_spotted_drone_death_monitor()
{
	self notify("stealth_spotted_drone_death_monitor");
	self endon("stealth_spotted_drone_death_monitor");
	self waittill("death");
	if(isdefined(self) && isdefined(level.stealth_spotted_drones))
	{
		level.stealth_spotted_drones = common_scripts\utility::array_remove(level.stealth_spotted_drones,self);
	}
}

//Function Number: 10
drone_fly_away()
{
	self endon("death");
	self.pacifist = 1;
	maps\_utility::ent_flag_set("fire_disabled");
	var_00 = self.origin + (0,0,1000);
	self vehicle_setspeed(20,20,20);
	self setvehgoalpos(var_00,1);
	common_scripts\utility::waittill_any("near_goal","goal");
	level.stealth_spotted_drones = common_scripts\utility::array_remove(level.stealth_spotted_drones,self);
	self delete();
}

//Function Number: 11
drone_damage_monitor()
{
	self endon("death");
	for(;;)
	{
		var_00 = common_scripts\utility::waittill_any_return_parms("damage");
		if(var_00[0] == "damage" && isdefined(var_00[2]) && var_00[2] == level.player)
		{
			if(!common_scripts\utility::flag("force_stealth_spotted_drones") && !common_scripts\utility::flag("_stealth_spotted"))
			{
				common_scripts\utility::flag_set("force_stealth_spotted_drones");
			}
		}

		wait(0.05);
	}
}

//Function Number: 12
drone_abort_monitor()
{
	self notify("drone_abort_monitor");
	self endon("drone_abort_monitor");
	self endon("death");
	level waittill("drones_abort");
	vehicle_scripts\_pdrone_security::drone_set_mode("patrol",isdefined(self.prev_attachedpath));
	wait(0.5);
	thread vehicle_scripts\_pdrone_security::drone_return_home(undefined,self.prev_attachedpath);
}

//Function Number: 13
level_drone_abort_monitor()
{
	self notify("level_drone_abort_monitor");
	self endon("level_drone_abort_monitor");
	level waittill("drones_abort");
	level.abort_drones = 1;
}