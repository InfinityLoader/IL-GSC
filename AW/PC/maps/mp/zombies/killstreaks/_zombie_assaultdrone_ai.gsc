/*******************************************************************
 * Decompiled By: Bog
 * Decompiled File: mp\zombies\killstreaks\_zombie_assaultdrone_ai.gsc
 * Game: Call of Duty: Advanced Warfare
 * Platform: PC
 * Function Count: 26
 * Decompile Time: 404 ms
 * Timestamp: 4/22/2024 2:12:59 AM
*******************************************************************/

//Function Number: 1
assault_vehicle_ai_init()
{
}

//Function Number: 2
aistartusingassaultvehicle(param_00)
{
	param_00.ignoreme = 1;
	param_00.enemy_target_last_vis_time = 0;
	param_00.enemy_target_visible = 0;
	param_00 thread assault_vehicle_ai_threat();
	param_00 thread assault_vehicle_ai_weapons(!param_00.hasturret);
	param_00 thread assault_vehicle_ai_aerial_movement_zombies(self);
}

//Function Number: 3
assault_vehicle_ai_aerial_movement_zombies(param_00)
{
	self endon("death");
	self sethoverparams(100,30,5);
	var_01 = self vehicle_gettopspeed();
	self vehicle_setspeed(var_01,8,60);
	for(;;)
	{
		assault_vehicle_ai_travel(param_00);
		assault_vehicle_ai_wait();
	}
}

//Function Number: 4
assault_vehicle_ai_travel(param_00)
{
	self endon("enemy");
	self endon("enemyLost");
	var_01 = (0,-100,70);
	var_02 = param_00;
	if(isdefined(self.enemy_target))
	{
		var_02 = self.enemy_target;
		var_01 = (0,-200,120);
	}

	for(;;)
	{
		self setdronegoalpos(var_02,var_01);
		wait(1);
	}
}

//Function Number: 5
assault_vehicle_ai_wait()
{
	self endon("enemy");
	self endon("enemyLost");
	var_00 = gettime() + 2000;
	while(!isdefined(self.enemy_target) && gettime() < var_00)
	{
		var_01 = maps\mp\zombies\_util::get_round_enemy_array();
		if(var_01.size == 0)
		{
			break;
		}

		wait 0.05;
	}
}

//Function Number: 6
assault_vehicle_horde_monitor_death(param_00)
{
	self waittill("death");
	self.aerialassaultdrone = undefined;
}

//Function Number: 7
assault_vehicle_ai_end_on_owner_disconnect(param_00)
{
	param_00 endon("death");
	self waittill("disconnect");
	param_00 notify("death");
}

//Function Number: 8
assault_vehicle_ai_aerial_movement()
{
	self notify("assault_vehicle_ai_aerial_movement");
	self endon("assault_vehicle_ai_aerial_movement");
	self endon("death");
	var_00 = self vehicle_gettopspeed();
	self vehicle_setspeed(var_00,8,60);
	self sethoverparams(0,0,0);
	var_01 = undefined;
	var_02 = assault_vehicle_ai_get_nearest_node();
	if(!isdefined(var_02))
	{
		return;
	}

	var_03 = var_02;
	if(!maps\mp\_aerial_pathnodes::node_is_aerial(var_03))
	{
		var_04 = maps\mp\_aerial_pathnodes::get_ent_closest_aerial_node(64,0);
		if(isdefined(var_04))
		{
			var_03 = var_04;
		}
	}

	if(maps\mp\_aerial_pathnodes::node_is_aerial(var_03))
	{
		var_01 = getnodesonpath(self.origin,var_03.origin,1,var_02);
	}

	if(!isdefined(var_01))
	{
		var_05 = 1500;
		for(var_06 = 0;!isdefined(var_01) && var_06 < var_05;var_06 = var_05 + 1)
		{
			var_07 = maps\mp\_aerial_pathnodes::get_ent_closest_aerial_node(var_05,var_06);
			if(isdefined(var_07))
			{
				var_01 = getnodesonpath(self.origin,var_07.origin,1,var_02);
				if(!isdefined(var_01))
				{
					var_06 = distance(self.origin,var_07.origin) + 1;
				}

				continue;
			}
		}

		if(var_06 > var_05)
		{
			return;
		}
	}

	var_08 = assault_vehicle_ai_aerial_follow_path_outside(var_01);
	assault_vehicle_ai_move_to_aerial_node(var_08);
	wait(0.85);
	var_09 = 1;
	if(var_09)
	{
		self notify("in_air");
		assault_vehicle_ai_aerial_pathing_turret(var_08);
	}
}

//Function Number: 9
assault_vehicle_ai_aerial_follow_path_outside(param_00)
{
	var_01 = (0,0,40);
	for(var_02 = 0;var_02 < param_00.size;var_02++)
	{
		var_03 = param_00[var_02];
		assault_vehicle_ai_air_movement_func(var_03.origin + var_01);
		var_04 = 0;
		while(distance2dsquared(var_03.origin,self.origin) > squared(24))
		{
			var_04 = var_04 + 0.05;
			if(var_04 > assault_vehicle_ai_path_timeout_time())
			{
				return;
			}

			wait(0.05);
		}

		if(maps\mp\_aerial_pathnodes::node_is_aerial(var_03))
		{
			return var_03;
		}
	}

	return param_00[param_00.size - 1];
}

//Function Number: 10
assault_vehicle_ai_move_to_aerial_node(param_00)
{
	var_01 = param_00.origin + maps\mp\_aerial_pathnodes::get_aerial_offset();
	assault_vehicle_ai_air_movement_func(var_01);
	while(distancesquared(self.origin,var_01) > 576)
	{
		wait(0.05);
	}
}

//Function Number: 11
assault_vehicle_ai_aerial_pathing_turret(param_00)
{
	var_01 = param_00;
	var_02 = [];
	var_02[var_01 getnodenumber()] = 1;
	for(;;)
	{
		var_01 = assault_vehicle_ai_pick_aerial_node(var_01,var_02);
		assault_vehicle_ai_move_to_aerial_node(var_01);
		var_03 = var_01 getnodenumber();
		if(!isdefined(var_02[var_03]))
		{
			var_02[var_03] = 0;
		}

		var_02[var_03]++;
		wait(randomfloatrange(0.05,2));
	}
}

//Function Number: 12
assault_vehicle_ai_aerial_pathing_c4()
{
	for(;;)
	{
		var_00 = undefined;
		if(assault_vehicle_ai_enemy_exists_and_is_alive())
		{
			var_00 = self.enemy_target maps\mp\_aerial_pathnodes::get_ent_closest_aerial_node();
		}

		if(!isdefined(var_00))
		{
			var_00 = common_scripts\utility::random(level.aerial_pathnodes);
		}

		var_01 = maps\mp\_aerial_pathnodes::get_ent_closest_aerial_node();
		var_02 = maps\mp\_aerial_pathnodes::find_path_between_aerial_nodes(var_01,var_00);
		if(isdefined(var_02))
		{
			assault_vehicle_ai_follow_path(var_02,::assault_vehicle_ai_air_movement_func,::assault_vehicle_ai_enemy_moved_air,maps\mp\_aerial_pathnodes::get_aerial_offset()[2]);
		}

		if(assault_vehicle_ai_enemy_exists_and_is_alive())
		{
			if(!assault_vehicle_ai_enemy_moved_air(var_00) || distance2dsquared(self.origin,self.enemy_target.origin) < squared(200))
			{
				var_03 = self.enemy_target.origin + (0,0,40);
				self setvehgoalpos(var_03,1);
				while(assault_vehicle_ai_enemy_exists_and_is_alive() && distancesquared(var_03,self.origin) > squared(24))
				{
					wait(0.05);
				}

				wait(0.8);
				assault_vehicle_ai_ground_movement(::assault_vehicle_ai_air_movement_func,::assault_vehicle_ai_enemy_moved_ground);
			}
		}

		wait(0.05);
	}
}

//Function Number: 13
assault_vehicle_ai_pick_aerial_node(param_00,param_01)
{
	var_02 = undefined;
	var_03 = 9999;
	var_04 = common_scripts\utility::array_randomize(param_00.aerial_neighbors);
	foreach(var_06 in var_04)
	{
		var_07 = var_06 getnodenumber();
		var_08 = param_01[var_07];
		if(!isdefined(var_08))
		{
			return var_06;
		}

		if(var_08 < var_03)
		{
			var_02 = var_06;
			var_03 = var_08;
		}
	}

	return var_02;
}

//Function Number: 14
assault_vehicle_ai_get_nearest_node()
{
	var_00 = getclosestnodeinsight(self.origin,1);
	if(!isdefined(var_00))
	{
		var_01 = getnodesinradiussorted(self.origin,1000,0);
		if(var_01.size > 0)
		{
			var_00 = var_01[0];
		}
	}

	return var_00;
}

//Function Number: 15
assault_vehicle_ai_ground_movement(param_00,param_01)
{
	self endon("death");
	var_02 = assault_vehicle_ai_get_nearest_node();
	if(!isdefined(var_02))
	{
		return;
	}

	for(;;)
	{
		childthread assault_vehicle_ai_ground_movement_loop(param_00,param_01);
		common_scripts\utility::waittill_any("enemy");
	}
}

//Function Number: 16
assault_vehicle_ai_ground_movement_loop(param_00,param_01)
{
	self notify("assault_vehicle_ai_ground_movement_loop");
	self endon("assault_vehicle_ai_ground_movement_loop");
	var_02 = [];
	for(;;)
	{
		var_03 = undefined;
		var_04 = undefined;
		if(assault_vehicle_ai_enemy_exists_and_is_alive())
		{
			var_04 = self.enemy_target.origin;
		}
		else
		{
			var_05 = 0;
			while(!isdefined(var_03) && var_05 < 20)
			{
				var_03 = getrandomnodedestination(self.origin,self.angles);
				if(isdefined(var_03))
				{
					if(common_scripts\utility::array_contains(var_02,var_03))
					{
						var_03 = undefined;
					}
					else
					{
						var_04 = var_03.origin;
					}
				}

				var_05++;
				wait(0.05);
			}
		}

		if(isdefined(var_04))
		{
			var_06 = assault_vehicle_ai_get_nearest_node();
			if(!isdefined(var_06))
			{
				return;
			}

			var_07 = getnodesonpath(self.origin,var_04,0,var_06);
			if(isdefined(var_07))
			{
				assault_vehicle_ai_follow_path(var_07,param_00,param_01);
			}
			else
			{
				var_02[var_02.size] = var_03;
			}
		}

		wait(0.05);
	}
}

//Function Number: 17
assault_vehicle_ai_get_camera_position()
{
	var_00 = self vehicleget3pcameraoffset();
	var_01 = self.origin + rotatevector(var_00,self.angles);
	return var_01;
}

//Function Number: 18
assault_vehicle_ai_threat()
{
	self endon("death");
	for(;;)
	{
		var_00 = [];
		var_01 = 0;
		if(isdefined(self.enemy_target) && !isalive(self.enemy_target))
		{
			var_02 = self.enemy_target.lastinflictor;
			if(isdefined(var_02))
			{
				if(var_02 == self || isdefined(var_02.tank) && var_02.tank == self)
				{
					self.fire_at_dead_time = gettime() + 1000;
					wait(1);
				}
			}
		}

		var_03 = maps\mp\zombies\_util::get_round_enemy_array();
		foreach(var_05 in var_03)
		{
			if(isalive(var_05) && !isalliedsentient(self,var_05) && self.owner != var_05)
			{
				if(var_05 maps\mp\_utility::_hasperk("specialty_blindeye"))
				{
					continue;
				}

				var_06 = 0;
				var_07 = assault_vehicle_ai_get_camera_position();
				var_08 = var_05.origin + (0,0,40);
				if(self.hasarhud)
				{
					var_06 = 1;
				}

				if(isdefined(var_05.lastshotfiredtime) && gettime() - var_05.lastshotfiredtime < 3)
				{
					var_06 = 1;
				}
				else if(getteamradarstrength(self.team) > getuavstrengthlevelneutral())
				{
					var_06 = 1;
				}
				else if(sighttracepassed(var_07,var_08,0,self,var_05))
				{
					var_06 = 1;
				}

				if(var_06 && self.hasturret)
				{
					var_09 = self vehicleget3ppitchclamp();
					var_0A = var_08 - var_07;
					var_0B = vectortoangles(var_0A);
					var_0C = angleclamp180(var_0B[0]);
					if(var_0C > var_09 || var_0C < -1 * var_09)
					{
						var_06 = 0;
					}
				}

				if(var_06)
				{
					var_00[var_00.size] = var_05;
				}

				if(var_01)
				{
					wait(0.05);
				}

				var_01 = !var_01;
			}
		}

		if(var_00.size > 0)
		{
			var_0E = common_scripts\utility::get_array_of_closest(self.origin,var_00);
			var_0F = self.enemy_target;
			self.enemy_target = var_0E[0];
			if(!isdefined(var_0F) || var_0F != self.enemy_target)
			{
				self notify("enemy");
			}
		}
		else if(isdefined(self.enemy_target))
		{
			self.enemy_target = undefined;
			self notify("enemyLost");
		}

		wait(0.05);
	}
}

//Function Number: 19
assault_vehicle_ai_weapons(param_00)
{
	self endon("death");
	if(param_00)
	{
		self waittill("in_air");
	}

	self.last_rocket_time = 0;
	self.initial_enemy_target = 1;
	var_01 = squared(maps\mp\killstreaks\_drone_assault::getassaultvehiclec4radius() * 0.75);
	for(;;)
	{
		if(isdefined(self.targetent))
		{
			if(assault_vehicle_ai_enemy_exists_and_is_alive())
			{
				if(assault_vehicle_ai_can_see_living_enemy())
				{
					if(isdefined(level.ishorde) && level.ishorde)
					{
						if(isdefined(self.enemy_target.ishordedrone) && self.enemy_target.ishordedrone)
						{
							self.targetent.origin = self.enemy_target.origin;
						}
						else
						{
							self.targetent.origin = self.enemy_target.origin + (0,0,40);
						}
					}
					else if(self.hasturret)
					{
						self.targetent.origin = self.enemy_target.origin + (0,0,40);
					}
					else
					{
						self.targetent.origin = self.enemy_target.origin + anglestoforward(self.enemy_target.angles) * 100;
					}

					var_02 = vectortoangles(self.targetent.origin - self.origin);
					for(var_03 = var_02[1] - self.angles[1];var_03 > 180;var_03 = var_03 - 360)
					{
					}

					while(var_03 < -180)
					{
						var_03 = var_03 + 360;
					}

					var_04 = 10;
					if(abs(var_03) < var_04)
					{
						var_05 = var_02[1];
					}
					else
					{
						var_05 = self.angles[1] + var_04 * var_03 / abs(var_03);
					}

					self vehicle_teleport(self.origin,(var_02[0],var_05,var_02[2]),1,1,1);
					if(self.initial_enemy_target)
					{
						wait(0.1);
						self.initial_enemy_target = 0;
						if(!assault_vehicle_ai_can_see_living_enemy())
						{
							continue;
						}
					}

					var_06 = self.hasrockets && self.rocketammo > 0;
					if(self.hasturret)
					{
						var_07 = self.mgturret gettagorigin("tag_flash");
					}
					else
					{
						var_07 = self.origin;
					}

					if(var_06)
					{
						var_06 = distancesquared(var_07,self.enemy_target.origin) > 17424;
					}

					var_08 = self.targetent.origin - var_07;
					var_09 = vectortoangles(var_08);
					var_0A = self vehicleget3ppitchclamp();
					var_0B = angleclamp180(var_09[0]);
					var_0C = var_0B < var_0A && var_0B > -1 * var_0A;
					var_0D = vectornormalize(anglestoforward(self.angles) * (1,1,0));
					var_0E = vectornormalize(var_08 * (1,1,0));
					var_0F = vectordot(var_0D,var_0E) > 0.9;
					if(var_0C && var_0F)
					{
						if(self.hasrockets && var_06)
						{
							if(gettime() > self.last_rocket_time + 1000)
							{
								if(self.hasmg)
								{
									self notify("FireSecondaryWeapon");
								}
								else
								{
									self notify("FirePrimaryWeapon");
								}

								self.last_rocket_time = gettime();
							}
						}
						else if(self.hasmg)
						{
							self.mgturret shootturret();
						}
						else if(!self.hasturret)
						{
							if(sighttracepassed(var_07,self.targetent.origin,0,self,self.enemy_target))
							{
								self notify("FirePrimaryWeapon");
							}
						}
					}
				}
				else
				{
					self.initial_enemy_target = 1;
				}
			}
			else if(isdefined(self.enemy_target) && !isalive(self.enemy_target))
			{
				if(self.hasmg)
				{
					if(isdefined(self.fire_at_dead_time) && gettime() < self.fire_at_dead_time)
					{
						self.mgturret shootturret();
					}
				}
			}
		}

		if(self.hascloak && !maps\mp\killstreaks\_drone_common::droneiscloaked(self))
		{
			if(!isdefined(self.cloakcooldown) || self.cloakcooldown == 0)
			{
				self notify("Cloak");
			}
		}

		wait(0.05);
	}
}

//Function Number: 20
assault_vehicle_ai_enemy_exists_and_is_alive()
{
	if(isdefined(level.ishorde) && level.ishorde)
	{
		if(isdefined(self.enemy_target) && isdefined(self.enemy_target.ishordeenemysentry) && self.enemy_target.ishordeenemysentry)
		{
			return self.enemy_target.isalive;
		}

		return isdefined(self.enemy_target) && isalive(self.enemy_target);
	}

	return isdefined(self.enemy_target) && isalive(self.enemy_target);
}

//Function Number: 21
assault_vehicle_ai_can_see_living_enemy()
{
	if(!assault_vehicle_ai_enemy_exists_and_is_alive())
	{
		return 0;
	}

	if(gettime() > self.enemy_target_last_vis_time)
	{
		self.enemy_target_last_vis_time = gettime();
		self.enemy_target_visible = sighttracepassed(assault_vehicle_ai_get_camera_position(),self.enemy_target.origin + (0,0,40),0,self,self.enemy_target);
	}

	return self.enemy_target_visible;
}

//Function Number: 22
assault_vehicle_ai_follow_path(param_00,param_01,param_02,param_03)
{
	if(!isdefined(param_03))
	{
		param_03 = 0;
	}

	var_04 = (0,0,param_03);
	for(var_05 = 0;var_05 < param_00.size;var_05++)
	{
		var_06 = param_00[var_05];
		self [[ param_01 ]](var_06.origin + var_04);
		var_07 = 0;
		while(distance2dsquared(var_06.origin,self.origin) > squared(24))
		{
			var_07 = var_07 + 0.05;
			var_08 = var_07 > assault_vehicle_ai_path_timeout_time();
			if(!var_08 && assault_vehicle_ai_enemy_exists_and_is_alive())
			{
				var_08 = self [[ param_02 ]](param_00[param_00.size - 1]);
			}

			if(var_08)
			{
				return;
			}

			if(self.hasturret && assault_vehicle_ai_can_see_living_enemy())
			{
				self [[ param_01 ]](self.origin);
				while(assault_vehicle_ai_can_see_living_enemy())
				{
					wait(0.05);
				}

				self [[ param_01 ]](var_06.origin);
			}

			wait(0.05);
		}
	}
}

//Function Number: 23
assault_vehicle_ai_enemy_moved_air(param_00)
{
	var_01 = self.enemy_target maps\mp\_aerial_pathnodes::get_ent_closest_aerial_node();
	return var_01 != param_00;
}

//Function Number: 24
assault_vehicle_ai_enemy_moved_ground(param_00)
{
	return distancesquared(param_00.origin,self.enemy_target.origin) > squared(128);
}

//Function Number: 25
assault_vehicle_ai_path_timeout_time()
{
	return 7.5;
}

//Function Number: 26
assault_vehicle_ai_air_movement_func(param_00)
{
	self setvehgoalpos(param_00,1);
}