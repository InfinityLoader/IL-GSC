/*******************************************************************
 * Decompiled By: Bog
 * Decompiled File: _attack_drone_common.gsc
 * Game: Call of Duty: Advanced Warfare
 * Platform: PC
 * Function Count: 55
 * Decompile Time: 786 ms
 * Timestamp: 4/22/2024 2:04:25 AM
*******************************************************************/

//Function Number: 1
attack_drone_init()
{
	level.player_test_points = common_scripts\utility::getstructarray("player_test_point","targetname");
	if(!isdefined(level.player_test_points) || level.player_test_points.size < 1)
	{
		level.player_test_points = getentarray("player_test_point","targetname");
	}

	level.drone_air_spaces = getentarray("drone_air_space","script_noteworthy");
	if(!isdefined(level.flying_attack_drones))
	{
		level.flying_attack_drones = [];
	}
}

//Function Number: 2
attack_drone_formation_init()
{
	precacheshader("sentinel_drone_overlay");
	precacheshader("warbird_hud_overlay_cannon");
	level.formation_volumes = getentarray("drone_formation_volume","targetname");
}

//Function Number: 3
spawn_attack_drone(param_00,param_01)
{
	if(isdefined(param_01))
	{
		var_02 = param_01 maps\_vehicle::spawn_vehicle_and_gopath();
	}
	else
	{
		var_02 = maps\_vehicle::spawn_vehicle_from_targetname_and_drive(param_01);
	}

	return var_02;
}

//Function Number: 4
queen_drone_gopath(param_00)
{
	if(isdefined(param_00))
	{
		thread maps\_vehicle::vehicle_paths(param_00);
	}

	maps\_vehicle::gopath();
}

//Function Number: 5
setup_queen_drone()
{
	var_00 = self;
	var_00.ignoreall = 1;
	var_00.ignoreme = 1;
	var_00.maxhealth = 30000;
	var_00.health = 30000;
	var_00 vehicle_setspeed(5,60,60);
}

//Function Number: 6
skip_helicopter_death_logic()
{
	for(;;)
	{
		if(isdefined(self))
		{
			self notify("in_air_explosion");
		}
		else
		{
			break;
		}

		wait(0.05);
	}
}

//Function Number: 7
make_non_sentient()
{
	while(!issentient(self))
	{
		wait(0.05);
	}

	self freeentitysentient();
}

//Function Number: 8
drone_lerp_to_position(param_00,param_01,param_02)
{
	if(!isdefined(self))
	{
		return;
	}

	self endon("death");
	self notify("kill_lerp_process");
	self endon("kill_lerp_process");
	var_03 = distance(param_00,self.origin);
	var_04 = 0;
	var_05 = self.origin;
	while(var_04 < var_03)
	{
		if(!isdefined(self))
		{
			return;
		}

		var_06 = drone_getlerpfraction(self.origin,param_00,param_01,param_02);
		self.origin = vectorlerp(self.origin,param_00,var_06);
		var_04 = distance(self.origin,var_05);
		wait(0.05);
	}

	self notify("drone_lerped");
}

//Function Number: 9
drone_getlerpfraction(param_00,param_01,param_02,param_03)
{
	var_04 = distance(param_00,param_01);
	var_05 = param_02 / var_04 * 0.05;
	if(var_05 > 0)
	{
		return var_05;
	}

	return 0;
}

//Function Number: 10
make_queen_invulnerable(param_00)
{
	level endon("delete_drone_cloud");
	level endon("end_drone_cloud");
	self endon("death");
	while(isdronevehiclealive(self))
	{
		self.maxhealth = 500000;
		self.health = self.maxhealth;
		wait(0.05);
	}

	if(!isdefined(param_00) && self == level.cloud_queen)
	{
		level.cloud_queen = common_scripts\utility::random(level.drone_swarm_queens);
	}
}

//Function Number: 11
cloud_queen_fly()
{
	maps\_vehicle::gopath();
	for(;;)
	{
		common_scripts\utility::flag_wait("cloud_in_formation");
		maps\_utility::vehicle_detachfrompath();
		self notify("drone_path_detach");
		level waittill("drone_cloud_formation_end");
	}
}

//Function Number: 12
is_real_vehicle()
{
	if(isdefined(self) && self.health > 0 && maps\_vehicle::isvehicle())
	{
		return 1;
	}

	return 0;
}

//Function Number: 13
add_to_flock(param_00)
{
	self.boids = common_scripts\utility::array_removeundefined(self.boids);
	self.boids[self.boids.size] = param_00;
}

//Function Number: 14
boid_flock_think()
{
	level endon("delete_drone_cloud");
	level endon("end_drone_cloud");
	while(isalive(self.queen))
	{
		var_00 = [];
		foreach(var_02 in self.boids)
		{
			if(isdefined(var_02) && !isdefined(var_02.remove_from_flock))
			{
				var_00[var_00.size] = var_02;
			}
		}

		self.boids = var_00;
		if(randomfloat(1) < 0.05)
		{
			self.boid_settings.queen_curl = self.boid_settings.queen_curl * -1;
		}

		var_04 = self.boid_settings.min_speed;
		var_05 = self.boid_settings.max_speed;
		var_06 = [];
		if(self.boid_settings.emp_mode)
		{
			var_06[var_06.size] = [self.queen.origin - (0,0,1000000),(0,0,0),0,1,0];
		}
		else
		{
			var_07 = self.queen vehicle_getvelocity();
			var_08 = length(var_07);
			var_09 = max(87.5,var_08);
			var_0A = clamp(var_09 / 262.5,0,0.8);
			var_0B = vectornormalize(var_07) * var_0A;
			var_0C = self.boid_settings.queen_deadzone * 1 - var_0A;
			var_06[var_06.size] = [self.queen.origin,var_0B,self.boid_settings.queen_deadzone,1,self.boid_settings.queen_curl];
			if(self.boid_settings.dodge_player_shots && level.player attackbuttonpressed())
			{
				var_0D = level.player geteye();
				var_0E = 0.15 * distance(self.queen.origin,var_0D);
				var_06[var_06.size] = [var_0D,anglestoforward(level.player getplayerangles()),var_0E,0,0];
			}

			if(isdefined(level.player.magnet_radius))
			{
				var_0E = level.player.magnet_radius;
			}
			else
			{
				var_0E = 192;
			}

			var_06[var_06.size] = [level.player.origin,(0,0,0),var_0E,0,0];
			if(isdefined(level.no_fly_zone))
			{
				var_06[var_06.size] = [level.no_fly_zone,(0,0,0),level.attack_drones_nofly_zone_radius,0,0];
			}

			if(isdefined(level.controllable_cloud_queen) && isdefined(level.controllable_cloud_queen.camera_tag))
			{
				var_06[var_06.size] = [level.controllable_cloud_queen.camera_tag,(0,0,0),150,0,0];
			}

			if(self.boid_settings.queen_relative_speed)
			{
				var_04 = max(var_09 * 0.25,87.5);
				var_05 = var_09 * 3;
			}
		}

		boidflockupdate(self.boids,var_06,self.boid_settings.neighborhood_radius,self.boid_settings.separation_factor,self.boid_settings.alignment_factor,self.boid_settings.cohesion_factor,self.boid_settings.magnet_factor,self.boid_settings.random_factor,self.boid_settings.max_accel,var_04,var_05,self.boid_settings.drag_amount,self.boid_settings.random_drag_amount);
		wait 0.05;
	}
}

//Function Number: 15
drone_find_ground()
{
	var_00 = bullettrace(self.origin - (0,0,5),self.origin - (0,0,1000),0,self,0,0,0);
	return var_00["position"];
}

//Function Number: 16
offset_position_from_drone(param_00,param_01,param_02)
{
	var_03 = self gettagangles(param_01);
	var_04 = self gettagorigin(param_01);
	if(param_00 == "up")
	{
		return var_04 + anglestoup(var_03) * param_02;
	}

	if(param_00 == "down")
	{
		return var_04 + anglestoup(var_03) * param_02 * -1;
	}

	if(param_00 == "right")
	{
		return var_04 + anglestoright(var_03) * param_02;
	}

	if(param_00 == "left")
	{
		return var_04 + anglestoright(var_03) * param_02 * -1;
	}

	if(param_00 == "forward")
	{
		return var_04 + anglestoforward(var_03) * param_02;
	}

	if(param_00 == "backward")
	{
		return var_04 + anglestoforward(var_03) * param_02 * -1;
	}

	if(param_00 == "backwardright")
	{
		var_04 = var_04 + anglestoright(var_03) * param_02;
		return var_04 + anglestoforward(var_03) * param_02 * -1;
	}

	if(param_00 == "backwardleft")
	{
		var_04 = var_04 + anglestoright(var_03) * param_02 * -1;
		return var_04 + anglestoforward(var_03) * param_02 * -1;
	}

	if(param_00 == "forwardright")
	{
		var_04 = var_04 + anglestoright(var_03) * param_02 * 1;
		return var_04 + anglestoforward(var_03) * param_02;
	}

	if(param_00 == "forwardleft")
	{
		var_04 = var_04 + anglestoright(var_03) * param_02 * -1;
		return var_04 + anglestoforward(var_03) * param_02;
	}
}

//Function Number: 17
monitor_drone_cloud_health(param_00)
{
	self notify("kill_drone_cloud_health_process");
	self endon("kill_drone_cloud_health_process");
	if(isdefined(self))
	{
		self.can_be_damaged = 0;
	}

	if(!isdefined(self))
	{
		return;
	}

	if(!isdefined(param_00))
	{
		param_00 = 0;
	}

	if(!param_00 && randomint(100) > 20)
	{
		return;
	}

	if(!param_00)
	{
		wait(randomfloat(1));
	}

	if(isremovedentity(self))
	{
		return;
	}

	self setcandamage(1);
	self.can_be_damaged = 1;
	var_01 = 0;
	for(;;)
	{
		self waittill("damage",var_02,var_03,var_04,var_05,var_06);
		thread fake_drone_death();
		break;
	}
}

//Function Number: 18
fake_drone_death(param_00,param_01,param_02,param_03)
{
	if(!isdefined(self))
	{
		return;
	}

	self.dying = 1;
	self.remove_from_flock = 1;
	var_04 = randomfloat(0.15);
	var_05 = 0.15;
	var_06 = 0.0085;
	var_07 = (0,0,-800);
	var_08 = 1930 * anglestoforward(self.angles);
	var_09 = self.origin;
	var_0A = undefined;
	var_0B = randomint(16);
	var_0C = randomint(16);
	var_0D = randomint(16);
	var_0E = 0;
	if(common_scripts\utility::cointoss())
	{
		var_0E = 1;
	}

	var_0F = 0;
	while(var_0F < var_05)
	{
		if(!isdefined(self))
		{
			return;
		}

		var_09 = var_09 + var_07 * 0.05;
		if(var_0F < var_04)
		{
			var_09 = var_09 + var_08 * 0.05;
		}

		var_10 = min(var_06 * lengthsquared(var_09) * 0.05,length(var_09));
		var_09 = var_09 - vectornormalize(var_09) * var_10;
		var_11 = self.origin + var_09 * 0.05;
		var_0A = bullettrace(self.origin + (0,0,3),var_11,1,self,0);
		if(var_0A["fraction"] >= 1)
		{
			self.origin = var_11;
			var_05 = var_05 + 0.05;
		}
		else
		{
			break;
		}

		self addyaw(var_0B);
		self addroll(var_0D);
		self addpitch(var_0C);
		if(var_0E && randomint(100) > 95)
		{
			drone_explode();
			return;
		}

		wait(0.05);
		var_0F = var_0F + 0.05;
	}

	self.origin = var_0A["position"];
	self.angles = var_0A["normal"];
	drone_explode();
}

//Function Number: 19
totally_fake_drone_death(param_00,param_01,param_02,param_03,param_04)
{
	if(isdefined(param_04) && param_04)
	{
		playfx(common_scripts\utility::getfx("drone_sparks"),self.origin);
	}
	else if(isdefined(param_03) && param_03)
	{
		thread vehicle_scripts\_attack_drone::spawn_drone_physics();
	}
	else if(isdefined(param_02) && param_02)
	{
		playfx(common_scripts\utility::getfx("drone_death_nexus"),self.origin);
	}
	else if(param_00)
	{
		playfx(common_scripts\utility::getfx("drone_death_nexus"),self.origin);
	}
	else if(level.drone_turret_fake_death_awesome)
	{
		if(randomint(100) < 5)
		{
			playfx(common_scripts\utility::getfx("drone_death_explode1"),self.origin);
		}
		else if(randomint(100) < 15)
		{
			thread vehicle_scripts\_attack_drone::spawn_drone_physics();
		}
		else if(randomint(100) < 25)
		{
			playfx(common_scripts\utility::getfx("drone_death_nexus"),self.origin);
		}
	}
	else
	{
		playfx(common_scripts\utility::getfx("drone_death_nexus"),self.origin);
		if(randomint(100) < 10)
		{
			thread vehicle_scripts\_attack_drone::spawn_drone_physics();
		}
	}

	if(isdefined(param_01) && param_01 && isdefined(self))
	{
		self delete();
	}

	level notify("drone_swarm_hit");
}

//Function Number: 20
is_bullet_damage(param_00)
{
	if(param_00 == "MOD_CRUSH")
	{
		return 0;
	}

	var_01 = ["MOD_PISTOL_BULLET","MOD_RIFLE_BULLET","mod_pistol_bullet","mod_rifle_bullet","mod_explosive_bullet","mod_grenade","mod_projecile","mod_grenade_splash","mod_projectile_splash","mod_melee","mod_melee_alt","mod_explosive","MOD_EXPLOSIVE_BULLET"];
	foreach(var_03 in var_01)
	{
		if(param_00 == var_03)
		{
			return 1;
		}
	}

	return 0;
}

//Function Number: 21
fly_to_target(param_00,param_01,param_02)
{
	self endon("death");
	self endon("im_dying");
	thread explode_drone_on_impact(param_00);
	if(!isdefined(self))
	{
		return;
	}

	self.angles = vectortoangles(param_00.origin - self.origin);
	var_03 = param_00.origin + (0,0,40);
	thread lerp_drone_to_position(var_03,2700);
	thread kamikaze_shooter(var_03);
	self waittill("lerp_complete");
	self notify("explode");
}

//Function Number: 22
find_unique_offset(param_00)
{
	self endon("im_dying");
	var_01 = self.origin;
	var_02 = (randomintrange(-300,300),randomintrange(-300,300),100);
	var_03 = bullettrace(self.origin,param_00.origin + var_02,1,self);
	if(isdefined(var_03["entity"]) && var_03["entity"] == param_00)
	{
		return var_03["position"];
	}

	wait(0.05);
}

//Function Number: 23
explode_drone_on_impact(param_00)
{
	self waittill("explode");
	if(!isdefined(param_00))
	{
		return;
	}

	var_01 = self.origin;
	if(!isdefined(var_01))
	{
		var_01 = param_00.origin;
	}

	playfx(common_scripts\utility::getfx("drone_explode"),var_01);
	radiusdamage(var_01,400,param_00.maxhealth / 3,param_00.maxhealth / 4);
	if(isdefined(self))
	{
		self delete();
	}
}

//Function Number: 24
lerp_drone_to_position(param_00,param_01,param_02,param_03)
{
	if(!isdefined(self))
	{
		return;
	}

	var_04 = distance(param_00,self.origin);
	var_05 = 0;
	var_06 = self.origin;
	while(var_05 < var_04 && isdefined(self))
	{
		var_07 = getdronelerpfraction(self.origin,param_00,param_01,param_02);
		self.origin = vectorlerp(self.origin,param_00,var_07);
		if(isdefined(param_03))
		{
			self.angles = self.angles + param_03;
		}

		var_05 = distance(self.origin,var_06);
		wait(0.05);
	}

	self notify("lerp_complete");
}

//Function Number: 25
getdronelerpfraction(param_00,param_01,param_02,param_03)
{
	var_04 = distance(param_00,param_01);
	var_05 = param_02 / var_04 * 0.05;
	if(var_05 > 0)
	{
		return var_05;
	}

	return 0;
}

//Function Number: 26
kamikaze_shooter(param_00)
{
	self endon("death");
	self endon("im_dying");
	self endon("explode");
	while(isdefined(self))
	{
		magicbullet("iw5_attackdronemagicbullet",self.origin,param_00);
		wait(0.05);
	}
}

//Function Number: 27
boid_vehicle_targets(param_00,param_01)
{
	self endon("im_dying");
	if(!isdefined(param_01))
	{
		param_01 = 300;
	}

	if(!isdefined(self))
	{
		return;
	}

	if(!isdefined(param_00))
	{
		return;
	}

	self notify("im_attacking");
	self.remove_from_flock = 1;
	fly_to_target(param_00,300);
	wait(0.15);
}

//Function Number: 28
make_no_fly_zone(param_00,param_01)
{
	level.no_fly_zone = param_00;
	wait(param_01);
	level.no_fly_zone = undefined;
}

//Function Number: 29
drone_explode()
{
	playfx(common_scripts\utility::getfx(common_scripts\utility::random(["drone_death_explode1","drone_sparks"])),self.origin);
	if(level.smart_drone_think)
	{
		thread make_no_fly_zone(self.origin,2);
	}

	self delete();
}

//Function Number: 30
drone_fx()
{
	level._effect["drone_death_explode1"] = loadfx("vfx/explosion/vehicle_pdrone_large_explosion");
	level._effect["drone_death_extra"] = loadfx("vfx/sparks/microwave_grenade_sparks_1");
	level._effect["drone_death_cheap"] = loadfx("vfx/sparks/drone_swarm_damage_spark");
	level._effect["drone_explode"] = loadfx("vfx/explosion/drone_swarm_projectile_explode");
	level._effect["drone_sparks"] = loadfx("vfx/sparks/sparks_pdrone_hit");
	level._effect["drone_smoke"] = loadfx("vfx/sparks/sparks_pdrone_smoldering");
	level._effect["drone_death_nexus"] = loadfx("vfx/explosion/drone_swarm_queen_explode");
}

//Function Number: 31
isdronevehiclealive(param_00)
{
	if(!isdefined(param_00))
	{
		return 0;
	}

	if(!param_00 maps\_vehicle::isvehicle())
	{
		return 0;
	}

	if(isdefined(param_00.classname) && issubstr(param_00.classname,"corpse"))
	{
		return 0;
	}

	if(param_00.health < 1)
	{
		return 0;
	}

	return 1;
}

//Function Number: 32
spawn_snake_cloud(param_00,param_01,param_02,param_03,param_04,param_05)
{
	if(!isdefined(param_02))
	{
		if(level.nextgen)
		{
			param_02 = 32;
		}
		else
		{
			param_02 = 10;
		}
	}

	if(!isdefined(param_03))
	{
		if(level.nextgen)
		{
			param_03 = 18;
		}
		else
		{
			param_03 = 6;
		}
	}

	var_06 = spawnstruct();
	var_06.snakes = [];
	for(var_07 = 0;var_07 < param_02;var_07++)
	{
		var_08 = spawn_snake(param_00,param_03,param_04,param_05);
		if(isdefined(param_01))
		{
			var_08 snake_set_points(param_01);
		}

		var_08 thread snake_dyanamic_control();
		var_06.snakes[var_06.snakes.size] = var_08;
		wait(0.1);
	}

	return var_06;
}

//Function Number: 33
spawn_snake_no_drones(param_00,param_01,param_02,param_03,param_04)
{
	if(!isdefined(param_02))
	{
		param_02 = 32;
	}

	var_05 = spawnstruct();
	var_05.snakes = [];
	var_06 = int(param_03.size / param_02);
	for(var_07 = 0;var_07 < param_02;var_07++)
	{
		var_08 = [];
		for(var_09 = 0;var_09 < var_06;var_09++)
		{
			if(isdefined(param_03[var_09]))
			{
				var_08[var_08.size] = param_03[var_09];
			}
		}

		param_03 = common_scripts\utility::array_remove_array(param_03,var_08);
		var_0A = spawn_snake_queen(param_00,var_08,param_04);
		if(isdefined(param_01))
		{
			var_0A snake_set_points(param_01);
		}

		var_0A thread snake_dyanamic_control();
		var_05.snakes[var_05.snakes.size] = var_0A;
		wait(0.1);
	}

	return var_05;
}

//Function Number: 34
cleanup_snake_cloud()
{
	level notify("end_drone_snake_processes");
	foreach(var_01 in self.snakes)
	{
		var_01 cleanup_snake();
	}
}

//Function Number: 35
snake_cloud_goto_points(param_00,param_01,param_02,param_03,param_04,param_05)
{
	if(!isdefined(param_02))
	{
		param_02 = 0;
	}

	self.snakes = common_scripts\utility::array_removeundefined(self.snakes);
	foreach(var_07 in self.snakes)
	{
		if(isdefined(var_07))
		{
			if(isdefined(param_05))
			{
				var_07.flock.boid_settings = param_05;
			}

			var_07 snake_set_points(param_00,param_01,param_03,param_04);
			wait(param_02 / self.snakes.size);
		}
	}
}

//Function Number: 36
snake_cloud_stop_dynamic_control()
{
	foreach(var_01 in self.snakes)
	{
		var_01 notify("stop_snake_control");
	}
}

//Function Number: 37
snake_cloud_resume_dynamic_control()
{
	foreach(var_01 in self.snakes)
	{
		var_01 thread snake_dyanamic_control();
	}
}

//Function Number: 38
snake_cloud_set_boid_settings(param_00)
{
	self.snakes = common_scripts\utility::array_removeundefined(self.snakes);
	foreach(var_02 in self.snakes)
	{
		var_02 snake_set_boid_settings(param_00);
	}
}

//Function Number: 39
snake_set_boid_settings(param_00)
{
	self.flock.boid_settings = param_00;
}

//Function Number: 40
snake_cloud_teleport_to_point(param_00)
{
	foreach(var_02 in self.snakes)
	{
		var_02 notify("stop_snake_control");
		var_02 vehicle_teleport(param_00.origin,(0,0,0));
		var_02.snake_points = [param_00];
		var_02.snake_points_center = getaverageorigin(var_02.snake_points);
		var_02 thread snake_dyanamic_control();
		foreach(var_04 in var_02.flock.boids)
		{
			var_04.origin = var_02.origin;
		}
	}
}

//Function Number: 41
snake_swarm_attack_vehicle(param_00,param_01)
{
}

//Function Number: 42
spawn_snake(param_00,param_01,param_02,param_03)
{
	if(!isdefined(param_01))
	{
		if(level.nextgen)
		{
			param_01 = 18;
		}
		else
		{
			param_01 = 6;
		}
	}

	var_04 = getent(param_00,"targetname");
	var_04.count++;
	var_05 = var_04 maps\_utility::spawn_vehicle();
	var_05 setcontents(0);
	if(isdefined(param_02))
	{
		var_05 vehicle_teleport(param_02,(0,0,0));
	}

	var_05.godmode = 1;
	var_05.ignoreme = 1;
	var_06 = var_05 vehicle_scripts\_attack_drone::make_boidcloud(level.boid_settings_presets["default_snake"],param_01,param_03);
	level.flock_drones = common_scripts\utility::array_combine(common_scripts\utility::array_removeundefined(level.flock_drones),var_06.boids);
	if(!isdefined(level.snakes))
	{
		level.snakes = [];
	}

	level.snakes = common_scripts\utility::array_removeundefined(level.snakes);
	level.snakes[level.snakes.size] = var_05;
	return var_05;
}

//Function Number: 43
spawn_snake_queen(param_00,param_01,param_02)
{
	var_03 = getent(param_00,"targetname");
	var_03.count++;
	var_04 = var_03 maps\_utility::spawn_vehicle();
	var_04 setcontents(0);
	if(isdefined(param_02))
	{
		var_04 vehicle_teleport(param_02,(0,0,0));
	}

	var_04.godmode = 1;
	var_04.ignoreme = 1;
	var_05 = var_04 vehicle_scripts\_attack_drone::make_boidcloud_from_spawned_models(level.boid_settings_presets["default_snake"],param_01);
	level.flock_drones = common_scripts\utility::array_combine(common_scripts\utility::array_removeundefined(level.flock_drones),var_05.boids);
	if(!isdefined(level.snakes))
	{
		level.snakes = [];
	}

	level.snakes = common_scripts\utility::array_removeundefined(level.snakes);
	level.snakes[level.snakes.size] = var_04;
	return var_04;
}

//Function Number: 44
cleanup_snake()
{
	if(!isdefined(self))
	{
		return;
	}

	foreach(var_01 in self.flock.boids)
	{
		if(isdefined(var_01))
		{
			var_01 delete();
		}
	}

	self delete();
}

//Function Number: 45
snake_set_points(param_00,param_01,param_02,param_03)
{
	if(!isdefined(self))
	{
		return;
	}

	self.snake_points = common_scripts\utility::getstructarray(param_00,"script_noteworthy");
	if(self.snake_points.size == 0)
	{
		return;
	}

	self.snake_goal_origin = param_01;
	if(isdefined(param_02))
	{
		param_02 = param_02 * 17.6;
	}

	self.snake_speed_override = param_02;
	if(isdefined(param_03) && param_03)
	{
		self.first_point = common_scripts\utility::getstruct(param_00,"targetname");
	}

	self.snake_points_center = getaverageorigin(self.snake_points);
}

//Function Number: 46
getaverageorigin(param_00)
{
	var_01 = (0,0,0);
	foreach(var_03 in param_00)
	{
		var_01 = var_01 + var_03.origin;
	}

	if(param_00.size > 0)
	{
		var_01 = var_01 * 1 / param_00.size;
	}

	return var_01;
}

//Function Number: 47
debug_snake_points(param_00)
{
	level notify("debug_snake_points");
	level endon("debug_snake_points");
	for(;;)
	{
		foreach(var_02 in common_scripts\utility::getstructarray(param_00,"script_noteworthy"))
		{
			if(isdefined(var_02.last_score))
			{
				continue;
			}
		}

		wait(0.05);
	}
}

//Function Number: 48
snake_dyanamic_control()
{
	self endon("death");
	self endon("stop_snake_control");
	var_00 = 334.4;
	while(!isdefined(self.snake_points))
	{
		wait(0.05);
	}

	var_01 = self.origin;
	var_02 = common_scripts\utility::getclosest(self.origin,self.snake_points);
	for(;;)
	{
		if(isdefined(self.first_point))
		{
			var_02 = self.first_point;
			self.first_point = undefined;
		}
		else
		{
			for(;;)
			{
				var_02 = snake_choose_next_point(self.snake_points,var_02);
				if(isdefined(var_02))
				{
					break;
				}

				wait 0.05;
			}
		}

		if(isdefined(var_02) && isdefined(var_02.script_flag_set))
		{
			if(!common_scripts\utility::flag(var_02.script_flag_set))
			{
				level notify(var_02.script_flag_set,self);
				wait 0.05;
				common_scripts\utility::flag_set(var_02.script_flag_set);
				self.lead_snake = 1;
				foreach(var_04 in level.snake_cloud.snakes)
				{
					if(var_04 == self)
					{
						continue;
					}
					else
					{
						var_04.lead_snake = undefined;
					}
				}
			}
		}

		if(isdefined(self.snake_speed_override))
		{
			var_06 = self.snake_speed_override;
		}
		else if(isdefined(var_02) && isdefined(var_02.speed))
		{
			var_06 = var_02.speed * 17.6;
		}
		else
		{
			var_06 = var_00;
		}

		for(;;)
		{
			var_07 = var_06;
			if(isdefined(level.snake_swarm_speed_scale))
			{
				var_07 = var_07 * level.snake_swarm_speed_scale;
			}

			var_08 = var_02.origin - var_01;
			var_09 = var_07 * 0.05;
			if(length(var_08) < var_09)
			{
				break;
			}

			var_01 = var_01 + vectornormalize(var_08) * var_09;
			self vehicle_helisetai(var_01,var_07,var_07,var_07,0,(0,0,0),0,0,0,1,0,0,0);
			wait(0.05);
		}

		wait(0.05);
		while(self.snake_points.size == 1)
		{
			wait(0.05);
		}
	}
}

//Function Number: 49
snake_kamikaze_control()
{
	self endon("death");
	self endon("stop_snake_control");
	var_00 = 175;
	self vehicle_helisetai(self.origin + (0,0,156),var_00,var_00,var_00,0,(0,0,0),0,0,0,1,0,0,0);
	wait(3);
	self vehicle_helisetai(level.player.origin,var_00,var_00,var_00,0,(0,0,0),0,0,0,1,0,0,0);
	var_01 = self.health;
	while(distance(self.origin,level.player.origin > 195))
	{
		if(self.health != self.init_health)
		{
			foreach(var_03 in self.flock)
			{
				var_03 delete();
			}

			self delete();
		}
	}

	level.player dodamage(25,self.origin);
	thread snake_dyanamic_control();
}

//Function Number: 50
draw_line_from_self_to_origin(param_00)
{
	self notify("draw_line_from_self_to_origin");
	self endon("draw_line_from_self_to_origin");
	self endon("death");
	wait(0.05);
}

//Function Number: 51
snake_choose_next_point(param_00,param_01)
{
	if(isdefined(param_01) && isdefined(param_01.target))
	{
		var_02 = common_scripts\utility::getstructarray(param_01.target,"targetname");
		var_03 = common_scripts\utility::random(var_02);
		if(common_scripts\utility::array_contains(param_00,param_01))
		{
			self.current_point_was_authored = 1;
			return var_03;
		}
	}

	if(!common_scripts\utility::array_contains(param_00,param_01))
	{
		self.current_point_was_authored = 0;
		return common_scripts\utility::getclosest(self.origin,param_00);
	}

	var_04 = 0.25;
	var_05 = 2;
	var_06 = 0.001;
	var_07 = 2;
	var_08 = 0;
	var_09 = 1;
	var_0A = 0.003;
	var_0B = 10;
	var_0C = 1500;
	var_0D = anglestoforward(level.player getgunangles());
	var_0E = undefined;
	var_0F = undefined;
	foreach(var_11 in param_00)
	{
		if(isdefined(var_11.target))
		{
			continue;
		}

		if(var_11.origin == param_01.origin)
		{
			continue;
		}

		var_12 = randomfloat(var_04);
		var_13 = vectornormalize(maps\_shg_utility::get_differentiated_velocity());
		var_14 = var_11.origin - self.origin;
		var_15 = vectornormalize(var_14);
		var_12 = var_12 + vectordot(var_13,var_15) + 1 / 2 * var_05;
		var_16 = var_11.origin - level.player.origin;
		var_17 = vectornormalize(var_16);
		var_12 = var_12 + vectordot(var_17,var_0D) + 1 / 2 * var_07;
		var_12 = var_12 - distance(param_01.origin,var_11.origin) * var_06;
		var_12 = var_12 - distance(level.player.origin,var_11.origin) * var_08;
		var_12 = var_12 + vectorcross(vectornormalize(self.snake_points_center - self.origin),var_15)[2] * var_09;
		if(isdefined(self.snake_goal_origin))
		{
			var_12 = var_12 - distance(self.snake_goal_origin,var_11.origin) * var_0A;
		}

		if(isdefined(param_01) && isdefined(param_01.went_thither) && param_01.went_thither == var_11 && gettime() - param_01.went_thither_time < var_0C)
		{
			var_12 = var_12 + randomfloat(var_0B);
		}

		if((!isdefined(var_0F) || var_12 > var_0F) && sighttracepassed(self.origin,var_11.origin,0,self))
		{
			var_0F = var_12;
			var_0E = var_11;
		}

		var_11.last_score = var_12;
	}

	if(!isdefined(var_0E))
	{
		var_0E = common_scripts\utility::random(param_00);
	}

	if(isdefined(param_01))
	{
		param_01.went_thither = var_0E;
		param_01.went_thither_time = gettime();
	}

	self.current_point_was_authored = 0;
	return var_0E;
}

//Function Number: 52
snake_cloud_pester_helicopter(param_00)
{
	self.snakes = common_scripts\utility::array_removeundefined(self.snakes);
	foreach(var_02 in self.snakes)
	{
		var_02 thread snake_pester_helicopter(param_00);
	}

	while(isdefined(param_00))
	{
		param_00 waittill("death");
	}

	if(isdefined(self))
	{
		cleanup_snake_cloud();
	}
}

//Function Number: 53
snake_pester_helicopter(param_00)
{
	self notify("stop_snake_control");
	self endon("death");
	self endon("stop_snake_control");
	var_01 = 50;
	var_02 = 47;
	var_03 = 195;
	var_04 = 85;
	var_05 = 117;
	var_06 = 270;
	var_07 = 300;
	var_08 = squared(var_03 + var_05);
	var_09 = 3.141593;
	var_0A = sqrt(squared(var_02 * var_03 + var_05 * var_09 / 180) + squared(var_04 * var_05 * var_09 / 180));
	var_0A = var_0A * 3;
	var_0B = var_0A / 17.6;
	var_0C = param_00.origin;
	while(distancesquared(self.origin,var_0C) > var_08)
	{
		if(isdefined(param_00))
		{
			var_0C = param_00.origin;
		}

		self vehicle_helisetai(var_0C,var_01,var_01,var_01,0,(0,0,0),0,0,0,1,0,0,0);
		wait(0.05);
	}

	var_0D = randomfloat(60);
	if(common_scripts\utility::cointoss())
	{
		var_0E = 180;
	}
	else
	{
		var_0E = 0;
	}

	for(;;)
	{
		if(isdefined(param_00))
		{
			var_0C = param_00.origin;
		}

		var_0F = gettime() * 0.001 - var_0D;
		var_10 = var_02 * var_0F;
		var_11 = angleclamp(var_04 * var_0F + var_0E);
		if(var_11 > var_06 && var_11 < var_07)
		{
			if(isdefined(param_00))
			{
				param_00.godmode = 0;
				param_00 dodamage(100,self.origin);
			}

			snake_cheap_death();
			if(self.flock.boids.size == 0)
			{
				self delete();
				return;
			}
		}

		var_12 = (cos(var_10),sin(var_10),0);
		var_13 = var_0C + var_12 * var_03 + cos(var_11) * var_05 + (0,0,sin(var_11) * var_05);
		self vehicle_helisetai(var_13,var_0B,var_0B,var_0B,0,(0,0,0),0,0,0,1,0,0,0);
		wait(0.05);
	}
}

//Function Number: 54
snake_cheap_death()
{
	self.flock.boids = common_scripts\utility::array_removeundefined(self.flock.boids);
	if(self.flock.boids.size != 0)
	{
		self.flock.boids[self.flock.boids.size - 1] boid_cheap_death();
	}
}

//Function Number: 55
boid_cheap_death()
{
	if(randomfloat(1) < 0.1)
	{
		playfx(common_scripts\utility::getfx("drone_death_explode1"),self.origin);
	}

	self delete();
}