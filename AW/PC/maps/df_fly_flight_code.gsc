/*******************************************************************
 * Decompiled By: Bog
 * Decompiled File: df_fly_flight_code.gsc
 * Game: Call of Duty: Advanced Warfare
 * Platform: PC
 * Function Count: 161
 * Decompile Time: 2283 ms
 * Timestamp: 4/22/2024 2:28:49 AM
*******************************************************************/

//Function Number: 1
flight_code_main()
{
	level.user_controlled_plane = 1;
	level.fps_controls = 1;
	level.plane_intialized = 0;
	level.num_objectives_visable = 0;
	level.player_boosting = 0;
	level.player_braking = 0;
	level.enemy_locking_on_to_player = 0;
	level.last_missile_fired_at_player = 0;
	level.default_player_dist = 2000;
	level.flares_active = 0;
	level.friend_jets = [];
	precacheitem("s19_cannon_player_test");
	precacheitem("s19_cannon_AI");
	precacheitem("sidewinder_atlas_jet");
	precachemodel("vehicle_s19");
	precachemodel("vfx_atlas_fighter_jet_dest_body_01");
	precachemodel("vfx_atlas_fighter_jet_dest_wing_lt");
	precachemodel("vfx_atlas_fighter_jet_dest_wing_rt");
	precacheshader("jet_HUD_hex_blue");
	precacheshader("jet_HUD_hex_orange");
	precacheshader("jet_hud_target_bullet_lock");
	precacheshader("jet_HUD_diamond_green");
	precacheshader("jet_HUD_ground_target");
	precacheshader("coop_class_icon_vangard");
	precacheshader("veh_hud_target");
	precacheshader("jet_hud_overlay_cannon_1");
	precacheshader("jet_hud_overlay_cannon_boresight");
	precacheshader("jet_hud_overlay_cannon_boresight_lockon");
	precacheshader("jet_hud_overlay_cannon_reticle");
	precacheshader("jet_hud_overlay_cannon_reticle_lockon");
	precacheshader("jet_hud_overlay_missile_1");
	precacheshader("jet_hud_missile_circle");
	precacheshader("jet_hud_red_doublecircle");
	precacheshader("jet_hud_overlay_bomb_1");
	precacheshader("jet_hud_incoming_missile");
	precacheshader("jet_hud_locking_on");
	precacheshader("jet_hud_locking_on_small");
	precacheshader("jet_hud_lockon_missile");
	precacheshader("jet_hud_overlay_missile_lockon");
	precacheshader("jet_hud_overlay_cannon_lockon");
	precacheshader("jet_hud_overlay_bomb_lockon");
	precacheshader("jet_hud_ground_target_lockon");
	precacheshader("jet_hud_pip_missile_1");
	precacheshader("jet_hud_overlay_bomb_flight");
	precacheshader("jet_hud_follow");
	precacheshader("jet_hud_missile_indicator");
	precacheshader("jet_hud_ammo_missile_0");
	precacheshader("jet_hud_ammo_missile_1");
	precacheshader("jet_hud_follow_white");
	precacheshader("jet_hud_lockon_bomb_1");
	precacheshader("jet_hud_lockon_bomb_2");
	precacheshader("jet_hud_overlay_reentry");
	precacheshader("jet_reentry_target");
	precacheshader("jet_hud_locking_on_1");
	precacheshader("jet_hud_locking_on_2");
	precacheshader("jet_hud_locking_on_3");
	precacheshader("jet_hud_locking_on_4");
	precacheshader("jet_hud_locking_on_5");
	precacheshader("jet_hud_locking_on_6");
	precacheshader("jet_hud_locking_on_7");
	precacheshader("jet_hud_locking_on_8");
	precacheshader("jet_hud_locking_on_9");
	precacheshader("jet_hud_locking_on_10");
	precacheshader("jet_hud_locking_on_11");
	precacheshader("jet_hud_locking_on_12");
	precacheshader("jet_hud_locking_on_13");
	precacheshader("jet_hud_locking_on_14");
	precacheshader("jet_hud_locking_on_15");
	precacheshader("jet_hud_locking_on_16");
	precacheshader("jet_hud_bomb_locking_on_1");
	precacheshader("jet_hud_bomb_locking_on_2");
	precacheshader("jet_hud_bomb_locking_on_3");
	precacheshader("jet_hud_bomb_locking_on_4");
	precacheshader("jet_hud_bomb_locking_on_5");
	precacheshader("jet_hud_bomb_locking_on_6");
	precacheshader("jet_hud_bomb_locking_on_7");
	precacheshader("jet_hud_bomb_locking_on_8");
	precacheshader("jet_hud_bomb_locking_on_9");
	precacheshader("jet_hud_bomb_locking_on_10");
	precacheshader("jet_hud_bomb_locking_on_11");
	precacheshader("jet_hud_bomb_locking_on_12");
	precacheshader("jet_hud_bomb_locking_on_13");
	precacheshader("jet_hud_bomb_locking_on_14");
	precacheshader("jet_hud_bomb_locking_on_15");
	precacheshader("jet_hud_bomb_locking_on_16");
	precacheshader("jet_hud_hex_blue_distort_1");
	precacheshader("jet_hud_hex_blue_distort_2");
	precacheshader("hud_plane_enemy");
	precacheshader("hud_fofbox_hostile_obstructed");
	precacheshader("hud_plane_horizon");
	precacheshader("hud_plane_mg");
	precacheshader("hud_plane_missile");
	precacheshader("hud_plane_reticle");
	precacheshader("hud_plane_controls_button");
	precacheshader("hud_plane_mg_button");
	precacheshader("hud_plane_missile_button");
	precacheshader("hud_plane_thrust_button");
	precachedigitaldistortcodeassets();
}

//Function Number: 2
change_optimal_flight_distance(param_00)
{
	self.default_player_dist = self.default_player_dist + param_00;
	self.infront_dist_min = self.infront_dist_min + param_00;
	self.infront_dist_max = self.infront_dist_max + param_00;
}

//Function Number: 3
set_optimal_flight_dist(param_00,param_01)
{
	if(isdefined(self))
	{
		self.default_player_dist = param_00;
		self.infront_dist_min = param_00 - 500;
		self.infront_dist_max = param_00 + 500;
	}
}

//Function Number: 4
steering_hack()
{
	setsaveddvar("vehPlanePathAllowance",45);
	common_scripts\utility::flag_wait("go_wide");
	setsaveddvar("vehPlanePathAllowance",60);
}

//Function Number: 5
flight_code_start(param_00,param_01)
{
	if(!isdefined(param_00))
	{
		param_00 = "player_mig";
	}

	setsaveddvar("vehPlanePathAllowance",60);
	level.plane = getent(param_00,"targetname");
	level.plane maps\_vehicle::godon();
	level.plane maps\_utility::ent_flag_clear("engineeffects");
	level.plane.lock_targets = [];
	level.plane.bomb_tag = level.plane common_scripts\utility::spawn_tag_origin();
	level.plane.bomb_tag linkto(level.plane,"tag_origin");
	thread init_jet_crash_points();
	var_02 = getentarray("player_vehicle","script_noteworthy");
	foreach(var_04 in var_02)
	{
		if(var_04 != level.plane)
		{
			var_04 delete();
		}
	}

	if(level.mini_version)
	{
		level.plane plane_test(50);
		return;
	}

	level.plane plane_test(undefined,undefined,param_01);
}

//Function Number: 6
debug_friendly_death()
{
	while(isdefined(self) && self.health > 1)
	{
		wait(0.05);
	}

	if(isdefined(self) && isdefined(self.targetname))
	{
		var_00 = self.targetname;
		iprintlnbold("friendly dead",var_00);
	}
}

//Function Number: 7
target_cycleshader(param_00,param_01,param_02,param_03)
{
	param_00 endon("death");
	param_00 endon("stop_target_cycle");
	if(!isdefined(param_03))
	{
		param_03 = 0.5;
	}

	while(target_istarget(param_00))
	{
		target_setshadersafe(param_00,param_01);
		wait(param_03);
		target_setshadersafe(param_00,param_02);
		wait(param_03);
	}
}

//Function Number: 8
make_ally_jet(param_00,param_01,param_02)
{
	if(!isdefined(param_01))
	{
		param_01 = 1;
	}

	var_03 = self;
	var_04 = var_03 maps\_vehicle::spawn_vehicle_and_gopath();
	if(isdefined(var_03.script_parameters))
	{
		var_05 = int(var_03.script_parameters);
	}
	else
	{
		var_05 = 3000;
	}

	var_04 set_optimal_flight_dist(var_05,is_true(param_02) || !is_true(param_01));
	var_04.missiletags_right = ["tag_right_wingtip"];
	var_04.missiletags_left = ["tag_left_wingtip"];
	var_04.salvo_ammo = [];
	var_04.salvo_ammo[0] = 4;
	var_04.mgun_left = "tag_left_wingtip";
	var_04.mgun_right = "tag_right_wingtip";
	var_04.has_flares = 999;
	var_04 thread fly_think(param_00,1,1,0);
	if(param_01)
	{
		level.allies[level.allies.size] = var_04;
		var_04 thread ally_jet_shoot_think();
	}
	else
	{
		var_04 hide();
		var_04 maps\_utility::ent_flag_clear("engineeffects");
		level.friend_jets[level.friend_jets.size] = var_04;
		var_04 maps\_vehicle::godon();
	}

	return var_04;
}

//Function Number: 9
spawn_enemy_jets(param_00,param_01,param_02)
{
	if(!isdefined(param_01))
	{
		param_01 = "targetname";
	}

	var_03 = getentarray(param_00,param_01);
	var_04 = [];
	foreach(var_06 in var_03)
	{
		var_07 = var_06 maps\_vehicle::spawn_vehicle_and_gopath();
		if(is_true(param_02))
		{
			var_07 maps\_vehicle::godon();
		}

		if(isdefined(var_06.script_parameters))
		{
			var_08 = int(var_06.script_parameters);
		}
		else
		{
			var_08 = 3000;
		}

		var_07 set_optimal_flight_dist(var_08);
		var_07 thread make_enemy_jet();
		var_04[var_04.size] = var_07;
	}

	return var_04;
}

//Function Number: 10
make_enemy_jet(param_00,param_01,param_02)
{
	if(!isdefined(level.vehicle_death_jolt))
	{
		level.vehicle_death_jolt = [];
	}

	var_03 = spawnstruct();
	var_03.delay = 9999;
	level.vehicle_death_jolt["script_vehicle_mig29"] = var_03;
	self.salvo_ammo = [];
	self.salvo_ammo[0] = 4;
	self.mgun_left = "tag_gun_left";
	self.mgun_right = "tag_gun_right";
	self.has_flares = 1;
	self.last_flare_time = 0;
	self.ignore_death_fx = 1;
	self.script_ai_invulnerable = 1;
	level.enemy_units[level.enemy_units.size] = self;
	thread monitor_enemy_jet_health();
	self.default_hud = "hud_fofbox_hostile_obstructed";
	thread hud_target_think();
	thread fly_think(level.plane,1,1,param_01);
	if(isdefined(param_02))
	{
		if(level.next_obj_pos == 0)
		{
			objective_onentity(maps\_utility::obj(param_02),self);
		}

		objective_additionalentity(maps\_utility::obj(param_02),level.next_obj_pos,self);
		level.next_obj_pos++;
	}

	thread wait_for_death();
	thread enemy_jet_shoot_think();
}

//Function Number: 11
wait_for_death()
{
	self waittill("death",var_00);
	if(isdefined(var_00) && var_00 == level.player)
	{
		level notify("enemy_dead_by_player");
		return;
	}

	level notify("enemy_dead");
}

//Function Number: 12
make_enemy_jet_special(param_00,param_01)
{
	target_setsafe(self);
	thread target_cycleshader(self,"jet_hud_hex_blue_distort_1","jet_hud_hex_blue_distort_2",0.1);
	var_02 = [level.plane];
	thread monitor_enemy_jet_health();
	thread fly_think(level.plane,1,1,param_01);
}

//Function Number: 13
monitor_enemy_jet_health()
{
	level endon("end_canyon");
	self.script_crashtypeoverride = "none";
	var_00 = check_health();
	burn_and_crash(var_00);
}

//Function Number: 14
physics_crash(param_00)
{
	if(isdefined(self))
	{
		self delete();
	}

	var_01 = spawn("script_model",param_00["org"]);
	var_01.angles = param_00["ang"];
	var_01 setmodel("vehicle_mig29");
	var_01 thread add_damage_fx();
	var_02 = 10;
	var_03 = param_00["velocity"] * var_02;
	var_04 = vectorlerp(param_00["org"],param_00["point"],0.5);
	var_01 physicslaunchserver(var_04,var_03);
	delete_on_crash(var_01);
}

//Function Number: 15
burn_and_crash(param_00)
{
	if(!isdefined(self) || isremovedentity(self))
	{
		return;
	}

	if(target_istarget(self))
	{
		target_remove(self);
	}

	level.enemy_units = common_scripts\utility::array_remove(level.enemy_units,self);
	var_01 = vectornormalize(self.origin - param_00["point"]);
	var_02 = var_01 * 50 * 17.6;
	var_03 = (0,0,100);
	self vehicle_addvelocity(var_02,var_03);
	var_04 = choose_crash_path();
	var_05 = 0;
	maps\_utility::ent_flag_clear("engineeffects");
	if(isdefined(var_04))
	{
		var_06 = playfxontag(common_scripts\utility::getfx("bagh_aircraft_damage_fire_trail"),self,"tag_origin");
		playfx(common_scripts\utility::getfx("missile_explode"),self.origin,anglestoforward(self.angles) * -1);
		var_04.claimed = 1;
		self notify("newpath");
		self vehicledriveto(var_04.origin,self.veh_pathspeed);
		if(isdefined(var_04.target))
		{
			follow_crash_path(var_04);
		}
	}
	else
	{
		maps\df_fly_fx::vfx_handle_disintegrating_jet();
		var_05 = 1;
	}

	if(!var_05)
	{
		var_07 = gettime();
		var_08 = self.origin;
		var_09 = var_07 + randomfloatrange(2,3) * 1000;
		var_0A = 0;
		while(isdefined(self) && isdefined(var_04) || gettime() < var_09)
		{
			if(isdefined(self.dragging) && self.dragging)
			{
				return;
			}

			if(!bullettracepassed(var_08,self.origin,0,self))
			{
				var_0A = 1;
				break;
			}

			var_08 = self.origin;
			wait 0.05;
		}

		if(isdefined(self) && !var_0A)
		{
			var_0B = [];
			var_0B["org"] = self.origin;
			var_0B["ang"] = self.angles;
			var_0B["velocity"] = param_00["velocity"];
			var_0B["point"] = self.origin;
			var_0B["direction_vec"] = self.angles;
			physics_crash(var_0B);
		}

		if(isdefined(self))
		{
			stopfxontag(common_scripts\utility::getfx("bagh_aircraft_damage_fire_trail"),self,"tag_origin");
			playfx(level._effect["canyon_jet_impact"],self.origin);
			self delete();
		}
	}
}

//Function Number: 16
follow_crash_path(param_00)
{
	while(isdefined(self) && isdefined(param_00.target))
	{
		if(distancesquared(self.origin,param_00.origin) < 62500)
		{
			if(isdefined(param_00.script_noteworthy) && param_00.script_noteworthy == "drag" && !is_true(self.dragging))
			{
				self.dragging = 1;
				self cancelaimove();
				self hide();
				var_01 = spawn("script_model",self.origin);
				var_01.angles = self.angles;
				var_01 setmodel(self.model);
				var_01 show();
				stopfxontag(common_scripts\utility::getfx("bagh_aircraft_damage_fire_trail"),self,"tag_origin");
				playfx(common_scripts\utility::getfx("canyon_jet_impact"),var_01.origin,anglestoforward(var_01.angles) * -1);
				playfxontag(common_scripts\utility::getfx("bagh_tanker_dust_trail_small"),var_01,"tag_origin");
				var_02 = self.veh_pathspeed;
				while(isdefined(param_00.target))
				{
					param_00 = getvehiclenode(param_00.target,"targetname");
					var_03 = distance(var_01.origin,param_00.origin) / var_02 * 17.6;
					var_01 moveto(param_00.origin,var_03);
					var_01 rotateto(param_00.angles,var_03);
					wait(var_03);
				}

				playfx(level._effect["canyon_jet_impact"],var_01.origin);
				var_01 delete();
				if(isdefined(self))
				{
					self delete();
				}

				return;
			}

			var_03 = getvehiclenode(var_03.target,"targetname");
			if(isdefined(var_03))
			{
				self vehicledriveto(var_03.origin,self.veh_pathspeed);
				continue;
			}

			break;
		}

		wait(0.05);
	}
}

//Function Number: 17
delete_on_crash(param_00)
{
	var_01 = 0;
	while(isdefined(param_00) && length(param_00 maps\_shg_utility::get_differentiated_acceleration()) < 1000 || var_01 < 3 && var_01 < 100)
	{
		var_01++;
		wait 0.05;
	}

	var_02 = param_00.differentiated_last_velocity;
	if(var_02 == (0,0,0))
	{
		var_02 = -1 * anglestoforward(param_00.angles);
	}

	playfx(level._effect["canyon_jet_impact"],param_00.origin,param_00.differentiated_last_velocity);
	param_00 delete();
}

//Function Number: 18
add_damage_fx()
{
	level endon("finale");
	var_00 = ["tag_right_wingtip","tag_left_wingtip"];
	var_01 = randomint(var_00.size);
	var_02 = playfxontag(common_scripts\utility::getfx("bagh_aircraft_damage_trail"),self,"tag_origin");
	while(isalive(self) && self.health > self.healthbuffer)
	{
		if(!isdefined(self))
		{
			break;
		}

		wait(0.05);
	}

	if(isdefined(self))
	{
		stopfxontag(common_scripts\utility::getfx("bagh_aircraft_damage_trail"),self,"tag_origin");
	}
}

//Function Number: 19
check_health(param_00)
{
	level endon("end_canyon");
	maps\_vehicle::vehicle_set_health(3000);
	self.script_bulletshield = undefined;
	self.script_explosive_bullet_shield = undefined;
	self.script_ai_invulnerable = undefined;
	self.script_grenadeshield = undefined;
	self.vehicle_stays_alive = 1;
	var_01 = [];
	var_01["org"] = self.origin;
	var_01["ang"] = self.angles;
	var_01["velocity"] = self vehicle_getvelocity();
	var_01["point"] = self.origin;
	var_01["direction_vec"] = self.angles;
	var_02 = 0;
	var_03 = self.health - self.healthbuffer;
	var_04 = undefined;
	var_05 = undefined;
	var_06 = undefined;
	while(isalive(self) && self.health > self.healthbuffer)
	{
		self waittill("damage",var_07,var_08,var_09,var_0A,var_0B,var_0C,var_0D,var_0E,var_0F,var_10);
		var_04 = var_08;
		var_05 = var_0B;
		var_06 = var_10;
		if(isalive(self))
		{
			if(var_08 == level.player)
			{
				if(var_0B == "MOD_EXPLOSIVE")
				{
					self dodamage(var_07,var_0A,var_08);
				}
				else
				{
					self dodamage(self.maxhealth / 100,var_0A,var_08);
				}

				self playsound("enemy_jet_mid_air_damage");
			}

			var_01["direction_vec"] = var_09;
			var_01["point"] = var_0A;
			var_01["org"] = self.origin;
			var_01["ang"] = self.angles;
			var_01["velocity"] = self vehicle_getvelocity();
			if(!var_02 && self.health > self.healthbuffer)
			{
				thread add_damage_fx();
				var_02 = 1;
			}
		}
	}

	if(var_04 == level.player)
	{
		level.player maps\_upgrade_challenge::give_player_challenge_kill(1);
		if(isdefined(var_06) && var_06 == "s19_cannon_player_test")
		{
			if(!isdefined(level.maverick_counter))
			{
				level.maverick_counter = 0;
			}

			level.maverick_counter++;
			if(level.maverick_counter == 10)
			{
				maps\_utility::giveachievement_wrapper("LEVEL_13A");
			}
		}
	}

	var_11 = self.origin;
	var_12 = self.angles;
	if(isdefined(var_11))
	{
		var_01["org"] = var_11;
	}

	if(isdefined(var_12))
	{
		var_01["ang"] = var_12;
	}

	return var_01;
}

//Function Number: 20
fly_think(param_00,param_01,param_02,param_03)
{
	if(!isdefined(param_03))
	{
		param_03 = 0;
	}

	if(!isdefined(param_01))
	{
		param_01 = 1;
	}

	if(!isdefined(param_02))
	{
		param_02 = 1;
	}

	if(common_scripts\utility::flag("end_fighter_jet_sequence"))
	{
		return;
	}

	if(!param_03)
	{
		thread fly_think_constrained(param_00,param_01,param_02);
		return;
	}

	thread fly_think_autopilot(param_00,param_01,param_02);
}

//Function Number: 21
check_flight_distances()
{
	if(!isdefined(self.default_player_dist))
	{
		self.default_player_dist = level.default_player_dist;
	}

	self.infront_dist_min = self.default_player_dist - 500;
	self.infront_dist_max = self.default_player_dist + 500;
}

//Function Number: 22
fly_think_constrained(param_00,param_01,param_02)
{
	level endon("end_canyon");
	self endon("death");
	if(isdefined(self.no_path))
	{
		thread fly_think_formation(param_00);
		return;
	}

	check_flight_distances();
	if(self.default_player_dist != 0)
	{
		var_03 = level.plane vehicle_getspeed();
		self vehicle_setspeedimmediate(var_03 * 0.75,100,50);
	}

	for(;;)
	{
		if(!isdefined(self))
		{
			break;
		}

		if(self.default_player_dist == 0)
		{
			wait(0.1);
			continue;
		}

		var_04 = maps\_utility::get_dot(self.origin,self.angles,param_00.origin);
		var_05 = anglestoforward(param_00.angles) * self.default_player_dist;
		var_06 = distance(param_00.missile_target.origin,self.origin);
		var_07 = distance(param_00.origin,self.origin);
		var_08 = var_07;
		if(var_04 > 0)
		{
			var_08 = self.default_player_dist + var_07;
		}
		else
		{
			var_08 = var_07 - self.default_player_dist;
		}

		var_03 = param_00 vehicle_getspeed();
		var_03 = var_03 + randomfloatrange(-5,5);
		var_09 = 1;
		var_0A = 1;
		if(level.player_boosting && self.default_player_dist > 0)
		{
			var_0B = 10;
			var_0C = gettime() - level.player_boost_time + 1;
			var_0D = clamp(var_0C / var_0B * 1000,0.5,1);
			var_09 = var_0D - 1 * self.default_player_dist;
			if(self.script_team == "allies")
			{
				var_0A = var_0A * var_0D;
			}
			else
			{
				var_0A = var_0A * var_0D;
			}
		}

		if(level.player_braking)
		{
			var_09 = 10000;
			var_0A = var_0A * 10;
			if(self.default_player_dist < 0)
			{
				var_0A = var_0A * 10;
			}
		}

		if(var_04 > 0 && self.default_player_dist > 0)
		{
			var_0A = var_0A * 2;
		}

		var_0E = 5000;
		var_0F = 1 / abs(var_04);
		var_0F = var_0F * var_08 / 1000;
		var_0F = var_0F * var_0A;
		var_0F = clamp(var_0F,0.5,100);
		var_10 = self.default_player_dist + var_09;
		if(var_10 < 0)
		{
			if(var_04 < 0)
			{
				var_03 = var_03 + var_0F * randomfloatrange(-65,-40);
			}
			else if(var_08 > abs(self.infront_dist_min + var_09) * param_01)
			{
				var_03 = var_03 + var_0F * randomfloatrange(100,300);
			}
			else
			{
				var_03 = var_03 - var_0F * randomfloatrange(6,9);
			}
		}
		else if(var_04 > 0 || var_07 < var_09 + self.infront_dist_min * param_01)
		{
			var_03 = var_03 + var_0F * randomfloatrange(20,25);
		}
		else if(var_04 < 0)
		{
			if(var_08 < var_09 + self.infront_dist_max * param_02)
			{
				var_03 = var_03 + var_0F * randomfloatrange(6,9);
			}
			else
			{
				var_03 = var_03 + var_0F * randomfloatrange(-20,-15);
			}
		}

		var_03 = clamp(var_03,300,800);
		self vehicle_setspeed(var_03,100,50);
		wait(0.25);
	}
}

//Function Number: 23
fly_think_autopilot(param_00,param_01,param_02)
{
	level endon("end_canyon");
	self endon("death");
	self.is_autopilot = 1;
	if(isdefined(self.no_path))
	{
		thread fly_think_formation(param_00);
		return;
	}

	setsaveddvar("vehPlaneAiRollResponseRate",0.1);
	setsaveddvar("vehPlaneAiPitchResponseRate",0.1);
	setsaveddvar("vehPlaneAiYawResponseRate",0.2);
	var_03 = 1;
	var_04 = 1;
	var_05 = getvehiclenode(self.target,"targetname");
	var_06 = 0;
	var_07 = self.origin;
	var_08 = 1;
	var_09 = var_05.origin;
	var_0A = var_05.speed;
	check_flight_distances();
	while(isdefined(var_05.target))
	{
		var_0B = getvehiclenodearray(var_05.target,"targetname");
		var_0C = var_0B[0];
		if(!isdefined(var_0C))
		{
			break;
		}

		var_06 = 0;
		var_0D = 0;
		while(var_06 < 1)
		{
			while(var_06 < 1)
			{
				var_0E = vectorlerp(var_05.origin,var_0C.origin,var_06);
				var_0A = maps\_utility::linear_interpolate(var_06,var_05.speed,var_0C.speed);
				var_08 = maps\_utility::linear_interpolate(var_06,var_05.lookahead,var_0C.lookahead) * var_04;
				var_0D = var_08 * var_0A;
				if(vectordot(var_0E - self.origin,vectornormalize(var_0C.origin - var_05.origin)) > var_0D)
				{
					break;
				}

				var_07 = var_0E;
				var_06 = var_06 + 0.01;
			}

			if(var_06 < 1)
			{
				if(!isdefined(self))
				{
					break;
				}

				if(var_03)
				{
					var_0F = vectornormalize(var_07 - self.origin);
					var_10 = vectortoangles(var_0F);
					var_10 = (var_10[0],var_10[1],var_05.angles[2]);
					self vehicle_teleport(self.origin,var_10);
					self vehicle_setvelocity(var_0F * var_0C.speed,(0,0,0));
					var_03 = 0;
				}

				var_11 = vectordot(anglestoforward(param_00.angles),self.origin - param_00.origin);
				var_12 = clamp(var_11,self.infront_dist_min * param_01,self.infront_dist_max * param_02);
				var_13 = var_11 - var_12;
				if(var_13 > 0)
				{
					var_14 = -87.5;
				}
				else
				{
					var_14 = 55;
				}

				var_15 = param_00 vehicle_getspeed() + var_14;
				var_15 = clamp(var_15,50,800);
				var_16 = var_09;
				var_09 = var_07 + vectornormalize(var_09 - var_07) * var_0D;
				var_17 = project_perpendicular(var_09 - self.origin,self vehicle_getvelocity());
				var_18 = var_17 * 2;
				var_19 = var_07;
				var_1A = vectorlerp(anglestoup(var_05.angles),anglestoup(var_0C.angles),var_06);
				self vehicledriveto(var_19,var_15,var_1A);
				wait 0.05;
			}
		}

		var_05 = var_0C;
	}
}

//Function Number: 24
project_perpendicular(param_00,param_01)
{
	param_01 = vectornormalize(param_01);
	return param_00 - param_01 * vectordot(param_00,vectornormalize(param_01));
}

//Function Number: 25
debug_graph(param_00,param_01,param_02)
{
	debug_graph_init();
	debug_graph_init_key(param_00,param_01);
	level.debug_graph.graphs[param_00].cur_point = level.debug_graph.graphs[param_00].cur_point + 1 % level.debug_graph.graphs[param_00].num_points;
	level.debug_graph.graphs[param_00].values[level.debug_graph.graphs[param_00].cur_point] = param_02;
	debug_graph_draw(level.debug_graph.graphs[param_00]);
}

//Function Number: 26
debug_graph_init()
{
	if(!isdefined(level.debug_graph))
	{
		level.debug_graph = spawnstruct();
		level.debug_graph.graphs = [];
	}
}

//Function Number: 27
debug_graph_init_key(param_00,param_01)
{
	if(!isdefined(level.debug_graph.graphs[param_00]))
	{
		level.debug_graph.graphs[param_00] = spawnstruct();
		level.debug_graph.graphs[param_00].values = [];
		level.debug_graph.graphs[param_00].values[0] = 0;
		level.debug_graph.graphs[param_00].cur = 0;
		level.debug_graph.graphs[param_00].num_points = 20;
		level.debug_graph.graphs[param_00].cur_point = 0;
		level.debug_graph.graphs[param_00].color = param_01;
	}
}

//Function Number: 28
debug_graph_draw(param_00)
{
	var_01 = 50000;
	var_02 = undefined;
	var_03 = undefined;
	for(var_04 = 0;var_04 < param_00.num_points;var_04++)
	{
		var_03 = var_02;
		var_02 = param_00.values[param_00.cur_point + 1 + var_04 % param_00.num_points];
		if(isdefined(var_03) && isdefined(var_02))
		{
			var_05 = level.player getplayerangles();
			var_06 = anglestoforward(var_05);
			var_07 = anglestoright(var_05) * var_01 * 0.01;
			var_08 = anglestoup(var_05) * var_01 * 0.25;
			var_09 = level.player geteye() + var_06 * var_01;
		}
	}
}

//Function Number: 29
fly_think_autopilot_player(param_00)
{
	level endon("end_canyon");
	self endon("death");
	setsaveddvar("vehPlaneAiRollResponseRate",0.05);
	setsaveddvar("vehPlaneAiPitchResponseRate",0.05);
	setsaveddvar("vehPlaneAiYawResponseRate",0.1);
	var_01 = self;
	var_02 = 0;
	var_03 = self.origin;
	var_04 = 1;
	while(isdefined(var_01.target))
	{
		var_05 = getvehiclenode(var_01.target,"targetname");
		if(!isdefined(var_05))
		{
			break;
		}

		var_02 = 0;
		var_06 = var_04 * self vehicle_getspeed() * 17.6;
		var_06 = clamp(var_06,1950,7800);
		while(var_02 < 1)
		{
			while(var_02 < 1)
			{
				var_07 = vectorlerp(var_01.origin,var_05.origin,var_02);
				if(vectordot(var_07 - self.origin,anglestoforward(self.angles)) > var_06)
				{
					break;
				}

				var_03 = var_07;
				var_02 = var_02 + 0.1;
			}

			if(var_02 < 1)
			{
				var_08 = param_00;
				self vehicledriveto(var_03,var_08);
				wait 0.05;
			}
		}

		var_01 = var_05;
	}
}

//Function Number: 30
fly_think_formation(param_00)
{
	level endon("end_canyon");
	self endon("death");
	setsaveddvar("vehPlaneAiRollResponseRate",0.05);
	setsaveddvar("vehPlaneAiPitchResponseRate",0.05);
	setsaveddvar("vehPlaneAiYawResponseRate",0.1);
	var_01 = self.formation_pos;
	for(;;)
	{
		var_02 = level.plane vehicle_getspeed();
		var_03 = distance(var_01.origin,self.origin);
		if(target_is_in_front(var_01) && var_03 > 1000)
		{
			var_02 = var_02 - 15;
			while(target_is_in_front(var_01))
			{
				wait(0.05);
			}
		}
		else if(target_is_in_front(var_01) && var_03 < 500)
		{
			var_02 = var_02 - 5;
			while(target_is_in_front(var_01))
			{
				wait(0.05);
			}
		}
		else if(!target_is_in_front(var_01) && var_03 > 500)
		{
			var_02 = var_02 + 10;
		}
		else if(!target_is_in_front(var_01) && var_03 < 500)
		{
			var_02 = var_02;
		}

		self vehicledriveto(var_01.origin,var_02);
		wait(0.1);
	}
}

//Function Number: 31
target_is_in_front(param_00,param_01)
{
	if(!isdefined(param_01))
	{
		param_01 = 50;
	}

	var_02 = offset_position_from_tag("forward","tag_origin",param_01);
	var_03 = distance(var_02,param_00.origin);
	var_04 = distance(self.origin,param_00.origin);
	if(var_03 < var_04)
	{
		return 0;
	}

	return 1;
}

//Function Number: 32
is_in_lockon_bounds(param_00)
{
	if(target_istarget(param_00) && target_isincircle(param_00,level.player,65,level.plane.lockon_fov))
	{
		return 1;
	}

	return 0;
}

//Function Number: 33
try_to_lock_on(param_00)
{
	param_00 endon("death");
	var_01 = 10;
	var_02 = cos(var_01);
	if(level.plane islockedonto(param_00))
	{
		return 0;
	}

	if(is_true(param_00.ground_target))
	{
		var_03 = 1;
	}

	var_03 = 1;
	level.plane.acquiring_lock_target = param_00;
	for(var_04 = 0;var_04 < var_03;var_04++)
	{
		var_05 = maps\_utility::get_dot(level.player.eye_origin,vectortoangles(level.player.reticle_origin - level.player.eye_origin),param_00.origin);
		if(target_istarget(param_00) && distancesquared(param_00.origin,level.player.origin) <= 1600000000 && var_05 > var_02)
		{
			wait(0.05);
			continue;
		}

		level.plane.acquiring_lock_target = undefined;
		return 0;
	}

	return 1;
}

//Function Number: 34
try_to_dogfight(param_00)
{
	if(!isdefined(level.plane.acquiring_dogfight_target) || level.plane.acquiring_dogfight_target == param_00)
	{
		var_01 = distance(level.plane.origin,param_00.origin) * 0.0254;
		if(var_01 <= 150)
		{
			if(target_istarget(param_00) && target_isincircle(param_00,level.player,65,130))
			{
				var_02 = gettime();
				if(!isdefined(level.plane.acquiring_dogfight_target))
				{
					level.plane.acquiring_dogfight_target = param_00;
					level.plane.dogfight_time = var_02 + 3000;
				}

				if(var_02 >= level.plane.dogfight_time)
				{
					level.plane.dogfight_engaged_target = param_00;
					return 1;
				}
			}
			else
			{
				level.plane.acquiring_dogfight_target = undefined;
			}
		}
		else
		{
			level.plane.acquiring_dogfight_target = undefined;
		}
	}

	return 0;
}

//Function Number: 35
switch_node_now(param_00,param_01)
{
	param_00 endon("death");
	if(!isdefined(param_01))
	{
		return;
	}

	param_00.attachedpath = undefined;
	param_00 notify("newpath");
	param_00 thread maps\_vehicle::vehicle_paths(param_01);
	param_00 startpath(param_01);
}

//Function Number: 36
has_los(param_00)
{
	if(!isdefined(param_00))
	{
		param_00 = 0;
	}

	if(bullettracepassed(level.player geteye() + anglestoforward(level.player getgunangles()) * 100,self.origin + (0,0,param_00),0,self))
	{
		return 1;
	}

	return 0;
}

//Function Number: 37
player_targeting_think()
{
	level notify("kill_player_targeting_think");
	level endon("kill_player_targeting_think");
	level endon("controlling_missile");
	level endon("finale");
	while(!isdefined(level.enemy_units))
	{
		wait(0.05);
	}

	while(isdefined(self))
	{
		foreach(var_01 in level.enemy_units)
		{
			if(!isdefined(var_01.classname))
			{
				level.enemy_units common_scripts\utility::array_remove(level.enemy_units,var_01);
			}
		}

		var_03 = [];
		foreach(var_01 in level.enemy_units)
		{
			if(!isdefined(var_01))
			{
				continue;
			}

			if(isdefined(var_01.ground_target))
			{
				var_05 = var_01;
			}
			else
			{
				var_05 = var_01;
			}

			if(isdefined(var_05) && !isremovedentity(var_05))
			{
				var_06 = try_to_lock_on(var_05);
				if(isdefined(var_06) && var_06)
				{
					self.lock_targets[self.lock_targets.size] = var_05;
					thread monitor_lockon(var_05);
					var_05 thread lockon_behavior();
				}
			}
		}

		wait(0.05);
	}
}

//Function Number: 38
lockon_behavior()
{
	set_optimal_flight_dist(3500 + randomfloatrange(-1000,500));
	self.player_locked_on = 1;
}

//Function Number: 39
islockedonto(param_00)
{
	foreach(var_02 in self.lock_targets)
	{
		if(var_02 == param_00)
		{
			return 1;
		}
	}

	return 0;
}

//Function Number: 40
hud_target_think(param_00)
{
	self notify("kill_target_think");
	self endon("kill_target_think");
	self endon("death");
	if(!isdefined(param_00))
	{
		param_00 = 0;
	}

	var_01 = 0;
	var_02 = 0;
	var_03 = 0;
	for(;;)
	{
		waittillframeend;
		if(should_show_hud_element(param_00))
		{
			var_02 = 0;
			if(is_true(self.player_shooting_at))
			{
				var_04 = level.plane.locked_guns_hud;
				var_03 = 0;
				var_05 = (1,0,0);
				var_02 = 1;
			}
			else if(level.plane islockedonto(self))
			{
				var_04 = self.default_hud;
				var_04 = 0;
				var_05 = (1,0,0);
				var_02 = 1;
			}
			else if(isdefined(level.plane.acquiring_lock_target) && level.plane.acquiring_lock_target == self)
			{
				var_05 = var_05 % 16;
				var_04 = level.plane.in_sights_hud + var_05 + 1;
				var_04++;
				var_05 = (1,1,0);
			}
			else
			{
				var_04 = self.default_hud;
				var_05 = (0,1,1);
				var_03 = 0;
			}

			if(!var_01)
			{
				target_setsafe(self);
				target_hidefromplayer(self,level.player);
				var_01 = 1;
			}

			if(target_istarget(self))
			{
				if(var_02)
				{
					target_showtoplayer(self,level.player);
				}

				target_setshadersafe(self,var_04);
			}
		}
		else
		{
			if(target_istarget(self))
			{
				target_hidefromplayer(self,level.player);
				target_remove(self);
				var_01 = 0;
				var_02 = 0;
			}

			var_03 = 0;
		}

		wait 0.05;
	}
}

//Function Number: 41
monitor_lockon(param_00)
{
	level.player notify("locked_on");
	var_01 = level.plane.currentweapon;
	while(isdefined(param_00) && islockedonto(param_00) && is_in_lockon_bounds(param_00))
	{
		wait(0.05);
	}

	level.player.jethud["LockOn_Overlay"].alpha = 0;
	level.player notify("locked_on_off");
	if(islockedonto(param_00))
	{
		self.lock_targets = common_scripts\utility::array_remove(self.lock_targets,param_00);
	}
}

//Function Number: 42
should_show_hud_element(param_00)
{
	if(!isalive(self))
	{
		return 0;
	}

	if(!has_los(param_00))
	{
		return 0;
	}

	return 1;
}

//Function Number: 43
plane_init()
{
	self.missiletags_right = ["tag_weapon_pod_right"];
	self.missiletags_left = ["tag_weapon_pod_left"];
	self.last_missile_side = 0;
	self.mgun_left = "tag_gun_left";
	self.mgun_right = "tag_gun_right";
	self.salvo_ammo = [];
	self.salvo_ammo[0] = 2;
	self.salvo_ammo[1] = 2;
	var_00 = self gettagangles("tag_origin");
	var_01 = anglestoforward(var_00);
	var_02 = self gettagorigin("tag_origin");
	var_03 = var_02 + var_01 * 1500;
	self.missile_target = common_scripts\utility::spawn_tag_origin();
	self.missile_target.origin = var_03;
	self.missile_target linkto(self,"tag_origin");
	var_03 = var_02 + var_01 * 5000;
	self.fake_missile_target = common_scripts\utility::spawn_tag_origin();
	self.fake_missile_target.origin = var_03;
	self.fake_missile_target linkto(self,"tag_origin");
	var_03 = var_02 + var_01 * -3000;
	self.fake_enemy_missile_spawn = common_scripts\utility::spawn_tag_origin();
	self.fake_enemy_missile_spawn.origin = var_03;
	self.fake_enemy_missile_spawn linkto(self,"tag_origin");
	level.player notifyonplayercommand("dpad_down","+actionslot 2");
	level.player notifyonplayercommand("dpad_left","+actionslot 3");
	level.player notifyonplayercommand("dpad_right","+actionslot 4");
	level.player notifyonplayercommand("dpad_up","+actionslot 1");
	level.player notifyonplayercommand("a_pressed","+gostand");
	level.player notifyonplayercommand("b_pressed","+stance");
	level.player notifyonplayercommand("b_pressed","+prone");
	level.player notifyonplayercommand("b_pressed","toggleprone");
	level.player notifyonplayercommand("y_pressed","weapnext");
	level.player notifyonplayercommand("fire_guns","+speed_throw");
	level.player notifyonplayercommand("fire_guns","+toggleads_throw");
	level.player notifyonplayercommand("fire_guns","+ads_akimbo_accessible");
}

//Function Number: 44
debug_enemy_jets_die()
{
}

//Function Number: 45
handle_evasive_controls()
{
	level.player notifyonplayercommand("pop_flares","+smoke");
	wait 0.05;
	for(;;)
	{
		level.player waittill("pop_flares");
		level.plane playsound("plr_jet_deploy_flares");
		var_00 = level.plane offset_position_from_tag("backward","tag_origin",120);
		playfx(common_scripts\utility::getfx("missile_repel"),var_00);
		level.player_popped_flares = 1;
		level.flares_active = 1;
		thread turn_off_flares();
		wait(3);
	}
}

//Function Number: 46
turn_off_flares()
{
	wait(2);
	level.flares_active = 0;
}

//Function Number: 47
monitor_player_shooting()
{
	level notify("kill_monitor_player_shooting");
	level endon("kill_monitor_player_shooting");
	level endon("controlling_missile");
	level endon("missionfailed");
	level endon("end_canyon");
	thread player_shooting_logic(level.player);
	self.currentweapon = "none";
	self.on_radar_hud = "hud_fofbox_hostile_obstructed";
	self.in_sights_hud = "jet_hud_locking_on_";
	self.lock_on_hud = "jet_hud_lockon_missile";
	self.locked_guns_hud = "jet_hud_target_bullet_lock";
	self.target_fov = 30;
	self.lockon_fov = 240;
	self.lockon_time = 1;
	level waittill("jetHUD_init");
	level.player.jethud["weaponOverlay"].alpha = 0;
	level.player.jethud["weapon_boresight"].alpha = 0;
	level.player.jethud["weapon_reticle"].alpha = 0;
	while(!common_scripts\utility::flag("canyon_finished"))
	{
		level.player waittill("fire_guns");
		if(common_scripts\utility::flag("canyon_finished"))
		{
			return;
		}

		level.player playrumblelooponentity("damage_light");
		level.player.jethud["weapon_boresight"].alpha = 0.8;
		while(level.player adsbuttonpressed(1) && !common_scripts\utility::flag("canyon_finished"))
		{
			wait(0.05);
		}

		level.player stoprumble("damage_light");
		level.player.jethud["weapon_boresight"].alpha = 0;
	}
}

//Function Number: 48
thermaloff_vianotify(param_00)
{
	self waittill(param_00);
	self thermalvisionoff();
}

//Function Number: 49
can_shoot_weapons(param_00)
{
	if(level.plane.currentweapon == "missiles")
	{
		return 1;
	}
	else if(level.plane.currentweapon == "guns" && level.plane can_shoot_guns(param_00))
	{
		return 1;
	}
	else if(level.plane.currentweapon == "bombs")
	{
		return 1;
	}

	return 0;
}

//Function Number: 50
check_missile_ammo()
{
	if(self.salvo_ammo[0] > 0 || self.salvo_ammo[1] > 0)
	{
		return self.salvo_ammo[1] > self.salvo_ammo[0];
	}

	return -1;
}

//Function Number: 51
can_shoot_missiles(param_00)
{
	if(param_00 == 0 && self.salvo0)
	{
		return 1;
	}
	else if(param_00 == 1 && self.salvo1)
	{
		return 1;
	}

	return 0;
}

//Function Number: 52
can_shoot_guns(param_00)
{
	if(!isdefined(param_00))
	{
		return 0;
	}

	if(distance(self.origin,param_00.origin) < 8100)
	{
		return 1;
	}

	return 0;
}

//Function Number: 53
player_guns_cooldown_think()
{
	self endon("death");
	self.guns_max_fire_time = 8;
	self.guns_complete_cooldown_time = 1;
	self.guns_last_fire_time = 0;
	self.guns_fire_time = 0;
	for(;;)
	{
		if(gettime() - self.guns_last_fire_time <= 50)
		{
			self.guns_fire_time = self.guns_fire_time + 0.05;
		}
		else
		{
			self.guns_fire_time = max(0,self.guns_fire_time - self.guns_max_fire_time / self.guns_complete_cooldown_time * 0.05);
		}

		wait 0.05;
	}
}

//Function Number: 54
player_guns_cooldown_shoot_notify()
{
	self.guns_last_fire_time = gettime();
}

//Function Number: 55
player_guns_cooldown_can_shoot()
{
	return self.guns_fire_time < self.guns_max_fire_time;
}

//Function Number: 56
player_guns_cooldown_get_heat()
{
	return clamp(self.guns_fire_time / self.guns_max_fire_time,0,1);
}

//Function Number: 57
player_shooting_logic(param_00)
{
	level notify("kill_player_shooting_logic");
	level endon("kill_player_shooting_logic");
	level endon("controlling_missile");
	self endon("death");
	var_01 = gettime() * 0.001;
	self.salvo0 = 1;
	self.salvo1 = 1;
	var_02 = 0;
	var_03 = 0;
	var_04 = 0;
	childthread player_missile_firing_logic(param_00);
	while(!common_scripts\utility::flag("canyon_finished"))
	{
		param_00 waittill("fire_guns");
		if(common_scripts\utility::flag("canyon_finished"))
		{
			return;
		}

		if(param_00 adsbuttonpressed(1))
		{
			level.player_shot_guns = 1;
			thread gun_sound();
			while(param_00 adsbuttonpressed(1) && !common_scripts\utility::flag("canyon_finished"))
			{
				jet_shoot_gun(var_04);
				var_04 = !var_04;
				wait(0.05);
			}

			self notify("gun_sound_stop");
		}
	}
}

//Function Number: 58
player_missile_firing_logic(param_00)
{
	level endon("finale");
	param_00 notifyonplayercommand("fire_missile","+attack");
	param_00 notifyonplayercommand("fire_missile","+attack_akimbo_accessible");
	for(;;)
	{
		param_00 waittill("fire_missile");
		var_01 = check_missile_ammo();
		if(var_01 > -1)
		{
			level.player_fired_missiles = 1;
			var_02 = undefined;
			if(level.plane.lock_targets.size > 0)
			{
				foreach(var_04 in level.plane.lock_targets)
				{
					if(!is_true(var_04.player_shooting_at))
					{
						var_02 = var_04;
						break;
					}
				}
			}

			if(isdefined(var_02))
			{
				var_01 = check_missile_ammo();
				if(var_01 > -1)
				{
					var_02.player_shooting_at = 1;
					level.plane spawn_cbdr_missile(var_02,undefined,var_01);
					var_02 notify("missile_fired_at");
				}
			}
			else
			{
				level.plane spawn_cbdr_missile(undefined,undefined,var_01);
			}

			continue;
		}

		level.plane playsound("plr_jet_missile_ammo_out");
	}
}

//Function Number: 59
re_target(param_00)
{
	param_00.player_shooting_at = 0;
}

//Function Number: 60
gun_sound()
{
	var_00 = common_scripts\utility::spawn_tag_origin();
	var_00 linkto(self,"tag_origin",(0,0,0),(0,0,0));
	level.plane playsound("s19_mgun_trigger_plr");
	var_00 playloopsound("s19_mgun_shot_lp_plr");
	common_scripts\utility::waittill_any("gun_sound_stop","finale");
	var_00 stoploopsound();
	if(isdefined(level.plane))
	{
		level.plane playsound("s19_mgun_shot_lp_end_plr");
	}

	var_00 delete();
}

//Function Number: 61
print_distance_on_ent(param_00)
{
	var_01 = (0.1,0.2,1);
	var_02 = 0.7;
	var_03 = 1;
	if(!isdefined(param_00))
	{
		return;
	}

	param_00 endon("death");
	if(!isdefined(param_00.is_objective) || !param_00.is_objective)
	{
		param_00.hudelements = [];
		param_00.is_objective = 1;
		param_00.hudelements[0] = newclienthudelem(self);
		param_00.hudelements[0].positioninworld = 1;
		param_00.hudelements[0] settargetent(param_00);
		param_00.hudelements[0].color = var_01;
		param_00.hudelements[0].alpha = var_02;
		param_00.hudelements[0].alignx = "center";
		param_00.hudelements[0].aligny = "top";
		param_00.hudelements[0].fontscale = var_03;
		param_00.hudelements[1] = newclienthudelem(self);
		param_00.hudelements[1].positioninworld = 1;
		param_00.hudelements[1] settargetent(param_00);
		param_00.hudelements[1].color = var_01;
		param_00.hudelements[1].alpha = var_02;
		param_00.hudelements[1].alignx = "center";
		param_00.hudelements[1].aligny = "middle";
		param_00.hudelements[1].fontscale = var_03;
		param_00 thread keep_active_distance_text(param_00.hudelements);
	}
}

//Function Number: 62
keep_active_distance_text(param_00)
{
	var_01 = (0.2,1,0.2);
	while(isdefined(self))
	{
		var_02 = int(distance(self.origin,level.player.origin));
		var_03 = int(var_02 / 12);
		if(!level.player can_see_ent(self,self))
		{
			param_00[0].alpha = 0;
			wait(0.1);
			continue;
		}

		if((level.plane.currentweapon == "guns" && var_02 < 8100) || level.plane islockedonto(self))
		{
			param_00[0].alpha = 0;
		}
		else if(level.plane.currentweapon != "guns")
		{
			param_00[0].alpha = 0.7;
			param_00[0].color = (0.1,1,0.1);
		}
		else if(level.plane.currentweapon == "guns" && var_02 > 8100)
		{
			param_00[0].alpha = 0.7;
			param_00[0].color = (1,0.9,0.1);
			var_03 = int(8100 - var_02 / 12);
		}
		else
		{
			param_00[0].alpha = 0.7;
			param_00[0].color = (0.1,1,0.1);
		}

		param_00[0] settext(var_03);
		wait(0.05);
	}

	param_00[0] destroy();
	param_00[1] destroy();
}

//Function Number: 63
can_see_ent(param_00,param_01)
{
	if(bullettracepassed(self.origin,param_00.origin,0,param_01))
	{
		return 1;
	}

	return 0;
}

//Function Number: 64
monitor_missile_target(param_00)
{
	self endon("death");
	while(isdefined(self.missiletag))
	{
		wait(0.05);
	}

	if(isdefined(self) && isdefined(param_00))
	{
		self missile_settargetent(param_00);
	}
}

//Function Number: 65
offset_debug(param_00,param_01)
{
	param_00 endon("death");
	self endon("death");
	param_00.tags = [];
	param_00.tags[0] = common_scripts\utility::spawn_tag_origin();
	param_00.tags[1] = common_scripts\utility::spawn_tag_origin();
	param_00.tags[2] = common_scripts\utility::spawn_tag_origin();
	param_00.tags[3] = common_scripts\utility::spawn_tag_origin();
	param_00.tags[1].origin = param_00 offset_position_from_tag("up","tag_origin",256);
	param_00.tags[2].origin = param_00 offset_position_from_tag("down","tag_origin",256);
	param_00.tags[3].origin = param_00 offset_position_from_tag("left","tag_origin",256);
	param_00.tags[1] linkto(param_00.tags[0],"tag_origin");
	param_00.tags[2] linkto(param_00.tags[0],"tag_origin");
	param_00.tags[3] linkto(param_00.tags[0],"tag_origin");
	param_00 thread rotate_missile_targets();
	return param_00;
}

//Function Number: 66
rotate_missile_targets()
{
	var_00 = self.tags[0];
	var_01 = self.tags;
	for(;;)
	{
		if(!isdefined(self))
		{
			break;
		}

		var_00.origin = self.origin;
		var_02 = var_00.angles;
		var_00.angles = (var_02[0],var_02[1] + 5,var_02[2]);
		wait(0.05);
	}

	foreach(var_00 in var_01)
	{
		if(isdefined(var_00))
		{
			var_00 delete();
		}
	}
}

//Function Number: 67
player_chooses_manual_control()
{
	return 1;
}

//Function Number: 68
move_target_for_squirly_effect(param_00)
{
	self endon("death");
	var_01 = param_00 common_scripts\utility::spawn_tag_origin();
	self.tag_targ = var_01;
	self.bomb_target = param_00;
	self missile_settargetent(var_01);
	thread make_squirly_path(var_01,param_00);
	var_02 = (param_00.origin[0],param_00.origin[1],level.player.origin[2]);
	var_03 = param_00.origin;
	var_04 = distance(self.origin,var_01.origin);
	var_05 = var_04;
	while(var_05 > var_04 * 0.2)
	{
		var_05 = distance(self.origin,var_02);
		wait(0.05);
	}

	self notify("end_squirel");
	var_01.origin = var_03;
}

//Function Number: 69
make_squirly_path(param_00,param_01)
{
	self endon("end_squirel");
	var_02 = max(param_01.origin[2] + 2000,level.player.origin[2]);
	var_03 = (param_01.origin[0],param_01.origin[1],var_02);
	var_04 = param_01.origin;
	var_05 = 0.1;
	var_06 = distance(self.origin,param_00.origin);
	var_07 = var_06;
	for(;;)
	{
		var_08 = randomfloatrange(var_07 * var_05 * -1,var_07 * var_05);
		var_09 = randomfloatrange(var_07 * var_05 * -1,var_07 * var_05);
		var_0A = randomfloatrange(var_07 * var_05 * -1,var_07 * var_05);
		param_00 moveto(var_03 + (var_08,var_09,var_0A),0.25);
		var_07 = distance(self.origin,var_03);
		wait(0.25);
	}
}

//Function Number: 70
monitor_missile_death(param_00,param_01,param_02,param_03)
{
	if(!isdefined(param_01))
	{
		param_01 = level.player;
	}

	self waittill("explode",var_04);
	if(isdefined(param_03) && param_03 != level.plane && distance(param_03.origin,var_04) < 500)
	{
		if(param_03 trytorepelmissile(self,2,3000,1))
		{
			return;
		}

		param_03 delete();
	}

	if(param_00 && isalive(param_01))
	{
		radiusdamage(var_04,1500,3000,1500,param_01);
	}

	if(isdefined(param_02))
	{
		param_02 delete();
	}
}

//Function Number: 71
get_plane_gun_origin(param_00)
{
	if(!isdefined(self))
	{
		return;
	}

	var_01 = self gettagangles(self.mgun_left);
	if(isdefined(param_00))
	{
		if(param_00)
		{
			var_02 = offset_position_from_tag("forward",self.mgun_left,500);
			var_03 = anglestoright(var_01);
		}
		else
		{
			var_02 = offset_position_from_tag("forward",self.mgun_right,500);
			var_03 = anglestoright(var_02) * -1;
		}
	}
	else
	{
		var_02 = self gettagorigin(self.mgun_left) + self gettagorigin(self.mgun_right) * 0.5;
		var_03 = (0,0,0);
	}

	var_04 = anglestoforward(var_01);
	var_05 = anglestoup(var_01) * -1;
	if(getdvar("vehCam_mode") == "chase")
	{
		var_02 = var_02 + var_05 * 0 + var_04 * 500 + var_03 * 16;
	}
	else
	{
		var_02 = var_02 + var_05 * 150 + var_04 * 500 + var_03 * -50;
	}

	return var_02;
}

//Function Number: 72
get_plane_gun_angles(param_00)
{
	var_01 = self gettagangles(self.mgun_left);
	if(getdvar("vehCam_mode") != "chase")
	{
		var_01 = var_01 + (6,0,0);
	}

	return var_01;
}

//Function Number: 73
jet_shoot_gun(param_00)
{
	var_01 = 0.05;
	var_02 = get_plane_gun_origin(param_00);
	waittillframeend;
	if(isdefined(self.player_gun_lock_target_origin))
	{
		var_03 = self.player_gun_lock_target_origin;
	}
	else
	{
		var_03 = level.player.jethud["hud_tag"].origin;
	}

	var_03 = var_03 + common_scripts\utility::randomvector(2 * tan(var_01) * distance(var_02,var_03));
	var_04 = magicbullet("s19_cannon_player_test",var_02,var_03,level.player);
}

//Function Number: 74
jet_shoot_missile_cbdr(param_00,param_01,param_02)
{
	for(var_03 = 0;var_03 < param_01;var_03++)
	{
		spawn_cbdr_missile(param_00,param_02,0);
	}
}

//Function Number: 75
spawn_cbdr_missile(param_00,param_01,param_02)
{
	self notify("salvo" + param_02 + "_fired");
	self.salvo_ammo[param_02]--;
	var_03 = spawn("script_model",(0,0,0));
	var_03 playsound("s19_missile_fire_plr");
	var_03 hide();
	self.last_missile_side++;
	if(self.last_missile_side > 1)
	{
		self.last_missile_side = 0;
	}

	var_03.origin = offset_position_from_tag("right",self.missiletags_right[0],1000);
	if(self.last_missile_side == 1)
	{
		var_03.origin = offset_position_from_tag("left",self.missiletags_left[0],1000);
	}

	var_03.origin = var_03.origin - (0,0,50);
	var_03.angles = get_plane_gun_angles();
	var_03.velocity = self vehicle_getvelocity();
	var_03.target_entity = param_00;
	var_03 setmodel("projectile_sidewinder_missile");
	playfxontag(common_scripts\utility::getfx("missile_trail"),var_03,"tag_origin");
	var_03 thread cbdr_missile_think(param_01);
	thread reload_ammo(param_02,3);
}

//Function Number: 76
reload_ammo(param_00,param_01)
{
	self endon("death");
	wait(param_01);
	self.salvo_ammo[param_00]++;
}

//Function Number: 77
cbdr_missile_think(param_00)
{
	var_01 = 17600;
	var_02 = 0.05;
	var_03 = 40500;
	var_04 = 17280;
	var_05 = 0.5;
	var_06 = 0.1;
	if(!isdefined(param_00))
	{
		param_00 = 10;
	}

	var_07 = 1950;
	var_08 = (0,0,0);
	var_09 = 1.5;
	var_0A = 600;
	var_0B = cos(30);
	var_0C = 4000;
	self.velocity = self.velocity * 3;
	var_0D = 0;
	while(var_0D < 0.5)
	{
		self.origin = self.origin + self.velocity * 0.05;
		self.angles = vectortoangles(self.velocity);
		self.velocity = self.velocity * 0.9;
		wait(0.05);
		self show();
		if(isdefined(self.target_entity) && isdefined(self.target_entity.origin))
		{
			var_0E = distancesquared(self.origin,self.target_entity.origin);
			var_0F = vectordot(vectornormalize(self.velocity),vectornormalize(self.target_entity.origin - self.origin));
			if(var_0E < 144000000 || var_0F < var_0B)
			{
				break;
			}
		}

		var_0D = var_0D + 0.05;
	}

	var_10 = vectornormalize(self.velocity);
	var_11 = length(self.velocity);
	self.velocity = var_10 + common_scripts\utility::randomvector(var_02) * var_11 + var_01;
	var_12 = self.origin + vectornormalize(self.velocity) * 10000;
	var_13 = vectornormalize(self.velocity);
	var_14 = var_13;
	var_15 = 0;
	var_16 = 0;
	var_17 = 0;
	var_18 = 0;
	while(var_15 < param_00 && !common_scripts\utility::flag("canyon_finished"))
	{
		var_19 = 0;
		if(isdefined(self.target_entity) && isdefined(self.target_entity.origin))
		{
			var_19 = 1;
			var_16 = 1;
		}

		if(var_19)
		{
			var_12 = self.target_entity.origin;
		}
		else if(!var_16)
		{
			var_12 = var_12 + length(self.velocity) * var_10 * 0.05;
		}

		var_1A = var_12 - self.origin;
		var_13 = vectornormalize(var_1A);
		var_1B = var_13 - var_14 * 20 + var_08 + common_scripts\utility::randomvector(var_09);
		var_14 = var_13;
		if(!var_17 && var_19 && self.target_entity trytorepelmissile(self,var_15,length(var_1A),undefined,1))
		{
			var_17 = 1;
			self.player_shooting_at = 0;
			var_08 = common_scripts\utility::randomvector(100);
		}

		if(var_17)
		{
			var_1B = var_1B * -1;
		}

		var_1C = length(self.velocity);
		var_1D = vectornormalize(self.velocity);
		if(var_1C < var_03)
		{
			var_1E = min(var_1C + var_04 * 0.05,var_03);
		}
		else
		{
			var_1E = max(var_1C - var_04 * 0.05,var_03);
		}

		var_1F = var_06;
		var_20 = vector_clamp(var_1B * var_1F,var_05);
		var_21 = vectornormalize(var_1D + var_20);
		self.velocity = var_21 * var_1E;
		var_22 = self.origin + self.velocity * 0.05;
		if(!var_17 && distance(var_22,var_12) < var_0A)
		{
			var_18 = 1;
			break;
		}

		if(!bullettracepassed(self.origin,var_22,0,self))
		{
			break;
		}

		self.origin = var_22;
		self.angles = vectortoangles(self.velocity);
		if(!var_17 && vectordot(self.velocity,var_12 - var_22) < 0)
		{
			break;
		}

		var_15 = var_15 + 0.05;
		wait 0.05;
	}

	if(!var_17)
	{
		if(var_18)
		{
			self.target_entity notify("damage",var_0C,level.player,(0,0,0),(0,0,0),"MOD_EXPLOSIVE","","");
		}

		radiusdamage(self.origin,var_0A * 3,var_0C,var_0C,level.player);
	}

	if(var_18 && isdefined(self.target_entity))
	{
		if(!is_true(self.target_entity.ground_target))
		{
		}
	}
	else if(var_15 >= param_00)
	{
		playfx(common_scripts\utility::getfx("missile_explode"),self.origin,vectornormalize(self.velocity) * -1);
	}
	else
	{
		playfx(common_scripts\utility::getfx("canyon_impact"),self.origin,vectornormalize(self.velocity) * -1);
	}

	if(isdefined(self.target_entity) && !var_18)
	{
		re_target(self.target_entity);
	}

	self delete();
}

//Function Number: 78
trytorepelmissile(param_00,param_01,param_02,param_03,param_04)
{
	if(!is_true(param_04) && is_true(self.player_shooting_at))
	{
		return 0;
	}

	if(!isdefined(self.has_flares) || self.has_flares < 1)
	{
		return 0;
	}

	if(param_01 < 0.5)
	{
		return 0;
	}

	if(param_02 > 3000)
	{
		return 0;
	}

	if(is_true(param_03) == 0 && isdefined(self.last_flare_time) && self.last_flare_time + 2000 > gettime())
	{
		return 0;
	}

	if(is_true(param_04))
	{
		var_05 = 20000;
		var_06 = maps\_utility::getdifficulty();
		switch(var_06)
		{
			case "medium":
				var_05 = 18000;
				break;

			case "hard":
				var_05 = 15000;
				break;

			case "fu":
				var_05 = 10000;
				break;
		}

		var_05 = var_05 * var_05;
		if(!common_scripts\utility::flag("ai_repel_missiles_ok") || distancesquared(level.plane.origin,self.origin) < var_05)
		{
			return 0;
		}

		if(is_true(level.repel_player_missile))
		{
			level.repel_player_missile = 0;
			return 0;
		}
		else
		{
			level.repel_player_missile = 1;
		}
	}

	playfx(common_scripts\utility::getfx("missile_repel"),param_00.origin);
	self.has_flares--;
	self.last_flare_time = gettime();
	return 1;
}

//Function Number: 79
vector_clamp(param_00,param_01)
{
	var_02 = length(param_00);
	if(var_02 > param_01)
	{
		return param_00 * param_01 / var_02;
	}

	return param_00;
}

//Function Number: 80
monitor_plane_speed()
{
	level notify("kill_monitor_plane_speed");
	level endon("kill_monitor_plane_speed");
	level endon("controlling_missile");
	self endon("death");
	var_00 = 35;
	var_01 = 45;
	for(;;)
	{
		var_02 = self vehicle_getspeed();
		setsaveddvar("vehPlaneControlForceReferenceSpeed",var_02);
		setsaveddvar("vehPlaneMaxControlForceScale",150);
		setsaveddvar("vehPlaneMaxControlForcePitch",0.8);
		setsaveddvar("vehPlaneMaxControlForceRoll",1);
		setsaveddvar("vehPlaneMaxControlForceYaw",0.8);
		var_03 = var_00 + var_02 / 50;
		var_04 = var_01 + var_02 / 50;
		setsaveddvar("vehPlaneWingLoading",var_03);
		setsaveddvar("vehPlaneFuselageLoading",var_01);
		wait(0.1);
	}
}

//Function Number: 81
standard_plane_controls()
{
	regular_plane_controls();
	if(getdvarint("vehPlaneControlScheme") >= 2)
	{
		self vehicle_setspeedimmediate(333,10);
		arcade_plane_controls();
		return;
	}

	if(level.mini_version)
	{
		self vehicle_setspeedimmediate(500,50);
		mini_plane_controls();
		return;
	}

	self vehicle_setspeedimmediate(500,50);
	regular_plane_controls();
}

//Function Number: 82
regular_plane_controls()
{
	setsaveddvar("vehPlaneGravity",386);
	setsaveddvar("vehPlaneMass",15000);
	setsaveddvar("vehPlaneWingLoading",85);
	setsaveddvar("vehPlaneFuselageLoading",105);
	setsaveddvar("vehPlaneThrustToWeightRatio",2.5);
	setsaveddvar("vehPlaneParasiticDragCoeff",0.03);
	setsaveddvar("vehPlaneMaxControlForceScale",40);
	setsaveddvar("vehPlaneMaxControlForceRoll",1);
	setsaveddvar("vehPlaneMaxControlForcePitch",0.5);
	setsaveddvar("vehPlaneMaxControlForceYaw",0.5);
	setsaveddvar("vehPlaneControlForceReferenceSpeed",200);
	setsaveddvar("vehPlaneMaxRightingForceScale",3);
	setsaveddvar("vehPlaneRightingForceReferenceSpeed",450);
	setsaveddvar("vehPlaneDihedralCoeff",3);
	setsaveddvar("vehPlaneDampingRoll",0.15);
	setsaveddvar("vehPlaneDampingYaw",0.4);
	setsaveddvar("vehPlaneDampingPitch",0.2);
	setsaveddvar("vehPlaneControlSquaring",0.1);
	setsaveddvar("vehPlaneControlExponent",1.5);
	setsaveddvar("vehPlaneControlYawRollCoupling",0);
	setsaveddvar("vehPlaneControlRollYawCoupling",0.2);
	setsaveddvar("vehPlaneControlLowpassCoeff",0);
	setsaveddvar("vehPlaneTurbulenceStrength",0);
	setsaveddvar("vehPlaneWingLeveling",0.15);
}

//Function Number: 83
mini_plane_controls()
{
	setsaveddvar("vehPlaneGravity",77);
	setsaveddvar("vehPlaneMass",3000);
	setsaveddvar("vehPlaneWingLoading",17);
	setsaveddvar("vehPlaneFuselageLoading",20);
	setsaveddvar("vehPlaneThrustToWeightRatio",3);
	setsaveddvar("vehPlaneParasiticDragCoeff",0.03);
	setsaveddvar("vehPlaneMaxControlForceScale",20);
	setsaveddvar("vehPlaneMaxControlForceRoll",1);
	setsaveddvar("vehPlaneMaxControlForcePitch",1);
	setsaveddvar("vehPlaneMaxControlForceYaw",0.5);
	setsaveddvar("vehPlaneControlForceReferenceSpeed",40);
	setsaveddvar("vehPlaneMaxRightingForceScale",3);
	setsaveddvar("vehPlaneRightingForceReferenceSpeed",200);
	setsaveddvar("vehPlaneDihedralCoeff",3);
	setsaveddvar("vehPlaneDampingRoll",0.15);
	setsaveddvar("vehPlaneDampingYaw",0.4);
	setsaveddvar("vehPlaneDampingPitch",0.2);
	setsaveddvar("vehPlaneControlSquaring",0.1);
	setsaveddvar("vehPlaneControlExponent",1.5);
	setsaveddvar("vehPlaneControlYawRollCoupling",0);
	setsaveddvar("vehPlaneControlRollYawCoupling",0.2);
	setsaveddvar("vehPlaneControlLowpassCoeff",0);
	setsaveddvar("vehPlaneTurbulenceStrength",0);
	setsaveddvar("vehPlaneWingLeveling",0.15);
}

//Function Number: 84
boost_plane_controls()
{
	setsaveddvar("vehPlaneGravity",386);
	setsaveddvar("vehPlaneMass",15000);
	setsaveddvar("vehPlaneWingLoading",105);
	setsaveddvar("vehPlaneFuselageLoading",125);
	setsaveddvar("vehPlaneThrustToWeightRatio",8.5);
	setsaveddvar("vehPlaneParasiticDragCoeff",0.03);
	setsaveddvar("vehPlaneMaxControlForceScale",50);
	setsaveddvar("vehPlaneMaxControlForceRoll",1);
	setsaveddvar("vehPlaneMaxControlForcePitch",0.5);
	setsaveddvar("vehPlaneMaxControlForceYaw",0.5);
	setsaveddvar("vehPlaneControlForceReferenceSpeed",800);
	setsaveddvar("vehPlaneMaxRightingForceScale",3);
	setsaveddvar("vehPlaneRightingForceReferenceSpeed",650);
	setsaveddvar("vehPlaneDihedralCoeff",3);
	setsaveddvar("vehPlaneDampingRoll",0.15);
	setsaveddvar("vehPlaneDampingYaw",0.4);
	setsaveddvar("vehPlaneDampingPitch",0.2);
	setsaveddvar("vehPlaneControlSquaring",0.1);
	setsaveddvar("vehPlaneControlExponent",1.5);
	setsaveddvar("vehPlaneControlYawRollCoupling",0);
	setsaveddvar("vehPlaneControlRollYawCoupling",0.2);
	setsaveddvar("vehPlaneControlLowpassCoeff",0);
	setsaveddvar("vehPlaneTurbulenceStrength",0);
	setsaveddvar("vehPlaneWingLeveling",0.15);
}

//Function Number: 85
slow_plane_controls()
{
	setsaveddvar("vehPlaneGravity",386);
	setsaveddvar("vehPlaneMass",15000);
	setsaveddvar("vehPlaneWingLoading",65);
	setsaveddvar("vehPlaneFuselageLoading",105);
	setsaveddvar("vehPlaneThrustToWeightRatio",1.3);
	setsaveddvar("vehPlaneParasiticDragCoeff",0.03);
	setsaveddvar("vehPlaneMaxControlForceScale",40);
	setsaveddvar("vehPlaneMaxControlForceRoll",1);
	setsaveddvar("vehPlaneMaxControlForcePitch",0.5);
	setsaveddvar("vehPlaneMaxControlForceYaw",0.5);
	setsaveddvar("vehPlaneControlForceReferenceSpeed",160);
	setsaveddvar("vehPlaneMaxRightingForceScale",3);
	setsaveddvar("vehPlaneRightingForceReferenceSpeed",300);
	setsaveddvar("vehPlaneDihedralCoeff",3);
	setsaveddvar("vehPlaneDampingRoll",0.15);
	setsaveddvar("vehPlaneDampingYaw",0.4);
	setsaveddvar("vehPlaneDampingPitch",0.2);
	setsaveddvar("vehPlaneControlSquaring",0.1);
	setsaveddvar("vehPlaneControlExponent",1.5);
	setsaveddvar("vehPlaneControlYawRollCoupling",0);
	setsaveddvar("vehPlaneControlRollYawCoupling",0.2);
	setsaveddvar("vehPlaneControlLowpassCoeff",0);
	setsaveddvar("vehPlaneTurbulenceStrength",0);
	setsaveddvar("vehPlaneWingLeveling",0.15);
}

//Function Number: 86
arcade_plane_controls()
{
	setsaveddvar("vehPlaneControlSquaring",0.1);
	setsaveddvar("vehPlaneControlYawRollCoupling",0);
	setsaveddvar("vehPlaneControlRollYawCoupling",0);
	setsaveddvar("vehPlaneControlLowpassCoeff",0.8);
	setsaveddvar("vehPlanePitchDeadZoneWhileRolling",0.3);
	setsaveddvar("vehPlaneRollLerpRate",0.1);
	setsaveddvar("vehPlaneControlExponent",3);
	setsaveddvar("vehPlaneMaxYawRatePerSec",330);
	setsaveddvar("vehPlaneMaxPitchDiffPerSec",45);
	setsaveddvar("vehPlaneCollisionLookAheadTime",0);
}

//Function Number: 87
plane_test(param_00,param_01,param_02)
{
	if(!isdefined(param_01))
	{
		param_01 = 1;
	}

	level notify("reset_plane_monitoring");
	common_scripts\utility::flag_set("playerPlaneNoDeath");
	level.player enableinvulnerability();
	level.fake_plane = maps\_utility::spawn_anim_model("cockpit");
	level.fake_plane hidepart("TAG_SCREEN_JOINT_LOAD");
	level.fake_plane hidepart("TAG_TRANSFER_AR");
	thread maps\_anim::anim_loop_solo(level.fake_plane,"idle");
	self.healthbuffer = 0;
	self.maxhealth = 100000;
	self.health = 100000;
	level.player.ads_on = 0;
	level.repel_player_missile = 0;
	if(level.nextgen)
	{
		setsaveddvar("r_mbEnable","2");
		setsaveddvar("r_mbVelocityScalar",2);
		setsaveddvar("r_mbCameraRotationInfluence","0");
	}

	if(!isdefined(self.plane_intialized) || isdefined(self.plane_intialized) && !self.plane_intialized)
	{
		plane_init();
		self.plane_intialized = 1;
	}

	thread plane_health_monitor();
	thread monitor_player_shooting();
	wait 0.05;
	thread player_targeting_think();
	if(param_01)
	{
		self makeunusable();
		level.player mountvehicle(self);
		setsaveddvar("vehCam_mode","1");
		setsaveddvar("sv_znear","16");
	}

	setomnvar("ui_playerplane_hud",1);
	thread fighter_jet_hud(level.player,self);
	thread fighter_jet_sounds(level.player,self);
	thread fighter_jet_crash_detection(level.player,self);
	thread fighter_jet_gun_hud();
	setdvar("cockpit_offset",(0,0,0));
	setdvar("cockpit_angles",(0,0,0));
	thread fighter_jet_handle_cockpit(level.player,self);
	thread fighter_jet_handle_throttle(level.player,self,param_02);
	if(!isdefined(param_00))
	{
		param_00 = 333;
	}

	self vehicle_setspeedimmediate(param_00,10);
	if(is_true(level.old_controls))
	{
		setsaveddvar("vehPlaneControlScheme",1);
	}
	else
	{
		setsaveddvar("vehPlaneControlScheme",3);
	}

	standard_plane_controls();
}

//Function Number: 88
handle_chase_cam_toggle()
{
	self notifyonplayercommand("toggle_chase_cam","+actionslot 1");
	for(;;)
	{
		self waittill("toggle_chase_cam");
		toggle_chase_cam();
	}
}

//Function Number: 89
toggle_chase_cam()
{
	if(!isdefined(level.plane_chase_cam))
	{
		level.plane_chase_cam = getdvar("vehCam_mode") == "chase";
	}

	var_00 = anglestoforward((6,0,0)) * 10000;
	if(level.plane_chase_cam)
	{
		setsaveddvar("vehCam_mode","1");
		level.fake_plane show();
		level.plane hide();
		setsaveddvar("vehPlaneRollLerpRate",0.1);
		thread fighter_jet_handle_cockpit(level.player,level.plane);
	}
	else
	{
		setsaveddvar("vehCam_mode","3");
		level.fake_plane hide();
		level.plane show();
		setsaveddvar("vehPlaneRollLerpRate",0.25);
		var_00 = getdvarvector("vehCam_chaseOffset");
		var_00 = var_00 + anglestoforward(getdvarvector("vehCam_chaseAngleOffset")) * 10000;
	}

	level.player.jethud["hud_tag"] unlink();
	level.player.jethud["hud_tag"] linkto(level.plane,"tag_origin",var_00,(0,0,0));
	level.player.jethud["hud_tag"] dontinterpolate();
	level.plane_chase_cam = !level.plane_chase_cam;
}

//Function Number: 90
fighter_jet_max_altitude(param_00,param_01)
{
	var_02 = -1000;
	var_03 = 1000;
	var_04 = 0.05;
	for(;;)
	{
		var_05 = (0,0,var_02);
		var_06 = (0,0,-1);
		var_07 = param_01.origin - var_05;
		var_08 = vectordot(var_07,var_06);
		if(var_08 < var_03)
		{
			var_09 = maps\_shg_utility::linear_map_clamp(var_08,var_03,0 - var_03,0,2);
			var_0A = param_01 vehicle_getvelocity();
			var_0B = vectornormalize(var_0A);
			var_0C = vectordot(var_0B,var_06);
			if(var_0C < var_04)
			{
				var_0D = length(var_0A);
				var_0E = vectordot(var_0A,var_06) * var_09 - var_04 * var_0D;
				var_0F = vectornormalize(var_0A - var_0E * var_06) * var_0D;
				param_01 vehicle_setvelocity(var_0F);
			}
		}

		wait 0.05;
	}
}

//Function Number: 91
fighter_jet_handle_cockpit(param_00,param_01)
{
	param_01 hide();
	var_02 = level.fake_plane;
	var_02 notsolid();
	var_03 = getdvarvector("cockpit_offset");
	var_04 = getdvarvector("cockpit_angles");
	var_02 linktoplayerview(param_00,"tag_origin",var_03,var_04,1);
	fighter_jet_handle_cockpit_motion(param_00,param_01,var_02,var_03,var_04);
}

//Function Number: 92
remove_cockpit_from_view(param_00,param_01,param_02)
{
	level endon("finale");
	level.player common_scripts\utility::waittill_any("player_eject","toggle_chase_cam");
	param_02 unlinkfromplayerview(param_00);
}

//Function Number: 93
fighter_jet_set_shake(param_00,param_01)
{
	level notify("jet_shake");
	level endon("jet_shake");
	level.jet_shake = param_00;
	var_02 = param_00 / param_01 / 0.05;
	while(param_01 > 0)
	{
		wait(0.05);
		level.jet_shake = level.jet_shake - var_02;
		param_01 = param_01 - 0.05;
	}

	level.jet_shake = 0;
}

//Function Number: 94
fighter_jet_handle_cockpit_motion(param_00,param_01,param_02,param_03,param_04)
{
	level.player endon("toggle_chase_cam");
	thread remove_cockpit_from_view(param_00,param_01,param_02);
	var_05 = 0.1;
	var_06 = 0.1;
	var_07 = 0.975;
	var_08 = 0.002;
	var_09 = 0.005;
	var_0A = 0.002;
	var_0B = 10;
	var_0C = 5;
	var_0D = 5;
	var_0E = 6E-05;
	var_0F = 0.006;
	for(var_10 = 1;var_10 < 8;var_10++)
	{
		if(isdefined(param_01))
		{
			param_01 maps\_shg_utility::get_differentiated_acceleration();
		}

		wait 0.05;
	}

	var_11 = param_01.angles;
	var_12 = (0,0,0);
	var_13 = (0,0,0);
	var_14 = (0,0,0);
	var_15 = (0,0,0);
	var_16 = (0,0,0);
	while(isalive(level.player))
	{
		if(isdefined(param_01))
		{
			var_17 = param_01 maps\_shg_utility::get_differentiated_acceleration() + (0,0,386);
			var_18 = transformmove((0,0,0),(0,0,0),(0,0,0),param_01.angles,var_17,(0,0,0))["origin"];
			var_19 = angles_clamp_180(transformmove((0,0,0),(0,0,0),(0,0,0),var_11,(0,0,0),param_01.angles)["angles"]) * 20;
			var_11 = param_01.angles;
			var_1A = var_19 - var_12 * 20;
			var_12 = var_19;
			var_13 = vectorlerp(var_13,var_18,var_05);
			var_1B = var_18 - var_13;
			var_14 = vectorlerp(var_14,var_19,var_05);
			var_1C = var_19 - var_14;
			var_1D = (var_1B[0] * var_06 * var_08,var_1B[1] * var_06 * var_09,var_1B[2] * var_06 * var_0A);
			if(level.player_boosting)
			{
				var_1D = var_1D * 1.25;
			}

			var_15 = vectorlerp(var_1D,var_15,var_07);
			var_1E = (var_1C[0] * var_06 * var_0C,var_1C[1] * var_06 * var_0D,var_1C[2] * var_06 * var_0B);
			var_16 = euler_lerp(var_1E,var_16,var_07);
			var_1F = var_15 + common_scripts\utility::randomvector(var_0E * length(var_18));
			var_20 = var_16 + common_scripts\utility::randomvector(var_0F * length(var_19));
			if(isdefined(level.jet_shake) && level.jet_shake > 0)
			{
				var_1F = var_1F + common_scripts\utility::randomvector(level.jet_shake);
			}

			var_21 = transformmove(var_1F,var_20,(0,0,0),(0,0,0),param_03,param_04);
			param_02 unlinkfromplayerview(param_00);
			param_02 linktoplayerview(param_00,"tag_origin",var_21["origin"],var_21["angles"],1);
		}

		wait 0.05;
	}
}

//Function Number: 95
fighter_jet_handle_throttle(param_00,param_01,param_02)
{
	param_01 endon("death");
	if(!isdefined(param_02))
	{
		param_01 vehicle_planethrottleoverride(level.current_median_speed);
	}
	else
	{
		var_03 = 0;
		while(var_03 < level.current_median_speed)
		{
			param_01 vehicle_planethrottleoverride(var_03);
			wait(0.2);
			var_03 = var_03 + 0.05;
		}
	}

	param_00 notifyonplayercommand("boost_start","+gostand");
	param_00 notifyonplayercommand("boost_stop","-gostand");
	param_00 notifyonplayercommand("brake_click","+stance");
	param_00 notifyonplayercommand("brake_click","+prone");
	param_00 notifyonplayercommand("brake_click","toggleprone");
	thread handle_jet_brake(param_00,param_01);
	thread handle_jet_boost(param_00,param_01);
}

//Function Number: 96
watch_player_braking(param_00)
{
	common_scripts\utility::flag_set("player_braking");
	wait(2);
	param_00 notify("brake_abort");
	common_scripts\utility::flag_clear("player_braking");
}

//Function Number: 97
process_flight_path(param_00)
{
	level notify("new_flight_path");
	level endon("new_flight_path");
	var_01 = 0;
	var_02 = [];
	var_03 = 0;
	var_04 = undefined;
	var_05 = common_scripts\utility::getstruct(param_00,"targetname");
	for(var_02[var_01] = var_05;isdefined(var_05.target);var_02[var_01] = var_05)
	{
		var_05 = common_scripts\utility::getstruct(var_05.target,"targetname");
		var_01++;
	}

	var_06 = var_02[var_03 + 1].origin - var_02[var_03].origin;
	var_06 = (var_06[0],var_06[1],0);
	var_07 = vectortoangles(var_06)[1];
	setsaveddvar("vehPlanePathAngle",var_07);
	if(var_03 + 2 < var_02.size)
	{
		var_04 = var_02[var_03 + 2].origin - var_02[var_03 + 1].origin;
	}
	else
	{
		var_04 = var_06;
	}

	for(;;)
	{
		wait(0.5);
		var_08 = level.player.origin - var_02[var_03 + 1].origin;
		var_09 = vectordot(var_04,var_08);
		if(var_09 > 0)
		{
			var_03++;
			if(var_03 == var_02.size - 1)
			{
				break;
			}

			var_06 = var_04;
			var_06 = (var_06[0],var_06[1],0);
			var_07 = vectortoangles(var_06)[1];
			setsaveddvar("vehPlanePathAngle",var_07);
			if(var_03 + 2 < var_02.size)
			{
				var_04 = var_02[var_03 + 2].origin - var_02[var_03 + 1].origin;
			}
			else
			{
				var_04 = var_06;
			}
		}

		if(common_scripts\utility::flag("canyon_finished"))
		{
			break;
		}
	}

	setsaveddvar("vehPlanePathAngle",-1);
	setsaveddvar("vehPlanePathAllowance",0);
}

//Function Number: 98
handle_jet_brake(param_00,param_01)
{
	level.player_airbraked = 0;
	while(!common_scripts\utility::flag("canyon_finished"))
	{
		param_00 waittill("brake_click");
		if(common_scripts\utility::flag("canyon_finished"))
		{
			return;
		}

		level.player_airbraked = 1;
		thread watch_player_braking(param_00);
		param_01 playsound("plr_jet_airbrake");
		if(level.nextgen)
		{
			setsaveddvar("r_mbVelocityScalar",1.1);
		}

		param_01 vehicle_planethrottleoverride(0.01);
		level.player_braking = 1;
		param_00 playrumblelooponentity("damage_heavy");
		if(!level.player.ads_on)
		{
			param_00 lerpfov(60,1);
		}

		if(level.player_boosting)
		{
			param_00 notify("boost_stop");
			wait 0.05;
		}

		param_00 common_scripts\utility::waittill_notify_or_timeout("brake_abort",2);
		param_01 vehicle_planethrottleoverride(0.25);
		common_scripts\utility::flag_waitopen("player_braking");
		level.player_braking = 0;
		param_00 stoprumble("damage_heavy");
		if(!level.player.ads_on)
		{
			param_00 lerpfov(65,1);
		}

		if(level.nextgen)
		{
			setsaveddvar("r_mbVelocityScalar",2);
		}

		param_01 vehicle_planethrottleoverride(level.current_median_speed);
		wait(0);
		wait 0.05;
	}
}

//Function Number: 99
handle_jet_boost(param_00,param_01)
{
	level endon("death");
	var_02 = common_scripts\utility::spawn_tag_origin();
	var_02 linkto(param_00,"",(0,0,0),(0,0,0));
	while(!common_scripts\utility::flag("canyon_finished"))
	{
		param_00 waittill("boost_start");
		if(common_scripts\utility::flag("canyon_finished"))
		{
			return;
		}

		param_01 playsound("plr_jet_boost_start");
		if(level.nextgen)
		{
			setsaveddvar("r_mbEnable","2");
			setsaveddvar("r_mbVelocityScalar",10);
			setsaveddvar("r_mbCameraRotationInfluence","0");
		}

		param_01 vehicle_planethrottleoverride(1);
		level.player_boosting = 1;
		level.player_boost_time = gettime();
		level notify("player_boost_start");
		param_00 playrumblelooponentity("damage_heavy");
		earthquake(0.5,1,level.player.origin,512);
		if(!level.player.ads_on)
		{
			param_00 lerpfov(75,1);
		}

		var_02 playloopsound("plr_jet_boost_loop");
		if(level.player_braking)
		{
			param_00 notify("brake_abort");
			wait 0.05;
		}

		while(level.player jumpbuttonpressed() && !common_scripts\utility::flag("canyon_finished"))
		{
			thread fighter_jet_set_shake(0.25,0.25);
			wait(0.05);
		}

		level.player_boosting = 0;
		param_00 stoprumble("damage_heavy");
		if(!level.player.ads_on)
		{
			param_00 lerpfov(65,1);
		}

		if(level.nextgen)
		{
			setsaveddvar("r_mbVelocityScalar",2);
		}

		param_01 vehicle_planethrottleoverride(level.current_median_speed);
		var_02 stoploopsound();
		param_01 playsound("plr_jet_boost_stop");
		wait 0.05;
	}
}

//Function Number: 100
handle_ads()
{
	level endon("death");
	while(!common_scripts\utility::flag("finale"))
	{
		var_00 = level.player adsbuttonpressed();
		var_01 = undefined;
		if(var_00 && !level.player.ads_on)
		{
			level.player.ads_on = 1;
			var_01 = 30;
		}
		else if(!var_00 && level.player.ads_on)
		{
			level.player.ads_on = 0;
			var_01 = 65;
			if(level.player_braking)
			{
				var_01 = 60;
			}

			if(level.player_boosting)
			{
				var_01 = 75;
			}
		}

		if(isdefined(var_01))
		{
			level.player lerpfov(var_01,0.25);
		}

		wait(0.05);
	}
}

//Function Number: 101
angles_clamp_180(param_00)
{
	return (angleclamp180(param_00[0]),angleclamp180(param_00[1]),angleclamp180(param_00[2]));
}

//Function Number: 102
angle_lerp(param_00,param_01,param_02)
{
	return angleclamp(param_00 + angleclamp180(param_01 - param_00) * param_02);
}

//Function Number: 103
euler_lerp(param_00,param_01,param_02)
{
	return (angle_lerp(param_00[0],param_01[0],param_02),angle_lerp(param_00[1],param_01[1],param_02),angle_lerp(param_00[2],param_01[2],param_02));
}

//Function Number: 104
remove_fighter_jet_hud()
{
	self waittill("remove_jet_hud");
	foreach(var_01 in self.jethud)
	{
		if(isarray(var_01))
		{
			foreach(var_03 in var_01)
			{
				if(!isarray(var_03))
				{
					var_03.alpha = 0;
				}
			}

			continue;
		}

		var_01.alpha = 0;
	}
}

//Function Number: 105
fighter_jet_hud(param_00,param_01)
{
	param_00 thread remove_fighter_jet_hud();
	self endon("end_canyon");
	var_02 = 600;
	var_03 = (0.2,1,0.2);
	var_04 = (0.4,1,0.4);
	var_05 = 0.5;
	var_06 = 1.5;
	var_07 = 0.868976;
	var_08 = 9;
	var_09 = 10;
	var_0A = 5;
	var_0B = 25;
	var_0C = 10;
	var_0D = 5;
	var_0E = 2;
	var_0F = 5;
	var_10 = 0.5;
	if(!isdefined(param_00.jethud))
	{
		param_00.jethud = [];
	}
	else
	{
		level notify("jetHUD_init");
		return;
	}

	var_11 = anglestoforward((6,0,0)) * 10000;
	if(getdvar("vehCam_mode") == "chase")
	{
		var_11 = getdvarvector("vehCam_chaseOffset");
		var_11 = var_11 + anglestoforward(getdvarvector("vehCam_chaseAngleOffset")) * 10000;
	}

	param_00.jethud["hud_tag"] = common_scripts\utility::spawn_tag_origin();
	param_00.jethud["hud_tag"] linkto(param_01,"tag_origin",var_11,(0,0,0));
	param_00.jethud["weapon_bore_tag"] = common_scripts\utility::spawn_tag_origin();
	param_00.jethud["weapon_bore_tag"] linkto(param_01,"tag_origin",var_11,(0,0,0));
	param_00.jethud["weapon_reticle_tag"] = common_scripts\utility::spawn_tag_origin();
	param_00.jethud["weapon_reticle_tag"] linkto(param_01,"tag_origin",var_11,(0,0,0));
	param_00.jethud["boresight"] = newclienthudelem(param_00);
	param_00.jethud["boresight"].positioninworld = 1;
	param_00.jethud["boresight"] settargetent(param_00.jethud["hud_tag"]);
	param_00.jethud["boresight"].alignx = "center";
	param_00.jethud["boresight"].aligny = "middle";
	param_00.jethud["boresight"] setshader("hud_plane_reticle",40,40);
	param_00.jethud["boresight"].alpha = var_05;
	param_00.jethud["lockon_warning"] = newclienthudelem(param_00);
	param_00.jethud["lockon_warning"].hidewheninmenu = 1;
	param_00.jethud["lockon_warning"].hidewhendead = 1;
	param_00.jethud["lockon_warning"].alignx = "center";
	param_00.jethud["lockon_warning"].aligny = "middle";
	param_00.jethud["lockon_warning"].x = 320;
	param_00.jethud["lockon_warning"].y = 320;
	param_00.jethud["lockon_warning"] settext("ENEMY LOCK");
	param_00.jethud["lockon_warning"].color = (1,0.2,0.2);
	param_00.jethud["lockon_warning"].alpha = 0;
	param_00.jethud["lockon_warning"].fontscale = 3;
	param_00.jethud["speed_indicator"] = newclienthudelem(param_00);
	param_00.jethud["speed_indicator"].positioninworld = 1;
	param_00.jethud["speed_indicator"] settargetent(param_00.jethud["hud_tag"]);
	param_00.jethud["speed_indicator"].alignx = "right";
	param_00.jethud["speed_indicator"].aligny = "middle";
	param_00.jethud["speed_indicator"].x = -300;
	param_00.jethud["speed_indicator"].y = 0;
	param_00.jethud["speed_indicator"].color = var_03;
	param_00.jethud["speed_indicator"].alpha = 0;
	param_00.jethud["speed_indicator"].fontscale = var_06;
	param_00.jethud["jetWeapons"] = newclienthudelem(param_00);
	param_00.jethud["jetWeapons"].positioninworld = 1;
	param_00.jethud["jetWeapons"] settargetent(param_00.jethud["hud_tag"]);
	param_00.jethud["jetWeapons"].alignx = "center";
	param_00.jethud["jetWeapons"].aligny = "top";
	param_00.jethud["jetWeapons"].y = -50;
	param_00.jethud["jetWeapons"].color = var_03;
	param_00.jethud["jetWeapons"].glowcolor = var_04;
	param_00.jethud["jetWeapons"].alpha = 0;
	param_00.jethud["jetWeapons"].fontscale = var_06;
	param_00.jethud["weaponOverlay"] = newclienthudelem(param_00);
	param_00.jethud["weaponOverlay"].positioninworld = 1;
	param_00.jethud["weaponOverlay"] settargetent(param_00.jethud["hud_tag"]);
	param_00.jethud["weaponOverlay"] setshader("jet_hud_overlay_cannon_1",640,480);
	param_00.jethud["weaponOverlay"].alignx = "center";
	param_00.jethud["weaponOverlay"].aligny = "middle";
	param_00.jethud["weaponOverlay"].alpha = 0.35;
	param_00.jethud["weaponOverlay"].fontscale = var_06;
	param_00.jethud["weapon_boresight"] = newclienthudelem(param_00);
	param_00.jethud["weapon_boresight"].positioninworld = 1;
	param_00.jethud["weapon_boresight"] settargetent(param_00.jethud["weapon_bore_tag"]);
	param_00.jethud["weapon_boresight"] setshader("jet_hud_overlay_cannon_boresight",640,480);
	param_00.jethud["weapon_boresight"].alignx = "center";
	param_00.jethud["weapon_boresight"].aligny = "middle";
	param_00.jethud["weapon_boresight"].alpha = 0.8;
	param_00.jethud["weapon_boresight"].fontscale = var_06;
	param_00.jethud["weapon_reticle"] = newclienthudelem(param_00);
	param_00.jethud["weapon_reticle"].positioninworld = 1;
	param_00.jethud["weapon_reticle"] settargetent(param_00.jethud["weapon_reticle_tag"]);
	param_00.jethud["weapon_reticle"] setshader("jet_hud_overlay_cannon_boresight",640,480);
	param_00.jethud["weapon_reticle"].alignx = "center";
	param_00.jethud["weapon_reticle"].aligny = "middle";
	param_00.jethud["weapon_reticle"].alpha = 0.8;
	param_00.jethud["weapon_reticle"].fontscale = var_06;
	var_12 = 4;
	var_13 = -325;
	var_14 = 325;
	var_15 = -120;
	var_16 = 35;
	var_17 = [];
	var_17[0] = make_missile_ammo_hud(0,level.plane.salvo_ammo[0],var_13,var_15,param_00.jethud["hud_tag"]);
	var_17[1] = make_missile_ammo_hud(1,level.plane.salvo_ammo[1],var_13,var_16,param_00.jethud["hud_tag"]);
	param_00.jethud["missile_ammo"] = array_combine_all(var_17[0],var_17[1]);
	param_00.jethud["weapon_bore"] = newclienthudelem(param_00);
	param_00.jethud["weapon_bore"].positioninworld = 1;
	param_00.jethud["weapon_bore"] settargetent(param_00.jethud["weapon_bore_tag"]);
	param_00.jethud["weapon_bore"].alignx = "center";
	param_00.jethud["weapon_bore"].aligny = "middle";
	param_00.jethud["weapon_bore"].alpha = 0;
	param_00.jethud["weapon_bore"].fontscale = var_06;
	param_00.jethud["LockOn_Overlay"] = newclienthudelem(param_00);
	param_00.jethud["LockOn_Overlay"].positioninworld = 1;
	param_00.jethud["LockOn_Overlay"] settargetent(param_00.jethud["weapon_bore_tag"]);
	param_00.jethud["LockOn_Overlay"].alignx = "center";
	param_00.jethud["LockOn_Overlay"].aligny = "middle";
	param_00.jethud["LockOn_Overlay"].alpha = 0;
	param_00.jethud["LockOn_Overlay"].fontscale = var_06;
	param_00.jethud["altitude_indicator"] = newclienthudelem(param_00);
	param_00.jethud["altitude_indicator"].positioninworld = 1;
	param_00.jethud["altitude_indicator"] settargetent(param_00.jethud["hud_tag"]);
	param_00.jethud["altitude_indicator"].alignx = "left";
	param_00.jethud["altitude_indicator"].aligny = "middle";
	param_00.jethud["altitude_indicator"].x = 300;
	param_00.jethud["altitude_indicator"].y = 0;
	param_00.jethud["altitude_indicator"].color = var_03;
	param_00.jethud["altitude_indicator"].alpha = 0;
	param_00.jethud["altitude_indicator"].fontscale = var_06;
	level notify("jetHUD_init");
	var_18 = 0;
	if(!isdefined(level.base_agl))
	{
		level.base_agl = 0;
	}

	for(;;)
	{
		if(!isdefined(param_01))
		{
			break;
		}

		var_19 = param_01 vehicle_getvelocity();
		var_1A = transformmove((0,0,0),(0,0,0),(0,0,0),param_01.angles,var_19,(0,0,0))["origin"];
		var_1B = param_01 vehicle_getspeed();
		if(level.mini_version)
		{
			var_1B = var_1B * 5;
		}

		param_00.jethud["speed_indicator"] settext("" + var_1B + " mph");
		var_1C = bullettrace(param_01.origin,param_01.origin + (0,0,-66000),0,param_01,0);
		if(isdefined(var_1C["position"]))
		{
			var_1D = param_01.origin[2] - var_1C["position"][2];
		}
		else
		{
			var_1D = 119988;
		}

		param_00.jethud["altitude_indicator"] settext("" + int(level.base_agl + var_1D / 12) + " ft agl");
		var_1E = param_01 gettagorigin("tag_player") + anglestoup(param_01 gettagangles("tag_player")) * var_02;
		for(var_1F = 0;var_1F < var_17.size;var_1F++)
		{
			var_20 = var_17[var_1F];
			var_12 = level.plane.salvo_ammo[var_1F];
			foreach(var_22 in var_20)
			{
				var_22.alpha = 0;
				var_12--;
			}
		}

		wait 0.05;
	}
}

//Function Number: 106
fighter_jet_sounds(param_00,param_01)
{
	level endon("finale");
	thread canyon_whizby_sounds(param_00,param_01);
	thread missile_lock_sounds(param_00,param_01);
	thread gun_lock_sounds(param_00,param_01);
	var_02 = common_scripts\utility::spawn_tag_origin();
	var_02 linkto(param_00,"",(0,0,0),(0,0,0));
	var_02 playloopsound("dogfight_player_plane_low");
	var_03 = common_scripts\utility::spawn_tag_origin();
	var_03 linkto(param_00,"",(0,0,0),(0,0,0));
	var_03 playloopsound("dogfight_player_plane_turbulence");
	var_04 = 2;
	var_05 = 0.05 / var_04;
	var_06 = 0;
	while(isalive(param_00) && isdefined(param_01))
	{
		var_07 = param_01 vehicle_getthrottle();
		var_06 = clamp(var_07,var_06 - var_05,var_06 + var_05);
		var_08 = vectordot(param_01 maps\_shg_utility::get_differentiated_acceleration() + (0,0,384),anglestoup(param_01.angles)) / 384;
		var_02 scalepitch(maps\_shg_utility::linear_map_clamp(var_06,0,1,0.8,1.2),0.05);
		var_02 scalevolume(maps\_shg_utility::linear_map_clamp(var_07,0,1,0.5,1),0.05);
		var_09 = maps\_shg_utility::linear_map_clamp(abs(var_08),0,8,0.2,1);
		var_03 scalevolume(var_09,0.05);
		wait 0.05;
	}

	var_02 stoploopsound();
	var_03 stoploopsound();
	level.player playsound("dogfight_player_plane_death");
}

//Function Number: 107
missile_lock_sounds(param_00,param_01)
{
	level endon("finale");
	var_02 = common_scripts\utility::spawn_tag_origin();
	var_02 linkto(param_00,"",(0,0,0),(0,0,0));
	var_03 = 0;
	var_04 = common_scripts\utility::spawn_tag_origin();
	var_04 linkto(param_00,"",(0,0,0),(0,0,0));
	var_05 = 0;
	var_06 = param_01.lock_targets.size;
	while(isalive(level.player))
	{
		var_07 = "none";
		if(isdefined(param_01.lock_targets))
		{
			if(param_01.lock_targets.size > 0)
			{
				var_07 = "locked";
				if(param_01.lock_targets.size > var_06)
				{
					param_01 playsound("dogfight_player_guns_locked");
				}
			}

			var_06 = param_01.lock_targets.size;
			var_07 = "locking";
		}

		var_08 = var_07 == "locked";
		var_09 = var_07 == "locking";
		wait 0.05;
	}
}

//Function Number: 108
gun_lock_sounds(param_00,param_01)
{
	level endon("finale");
	var_02 = 0;
	var_03 = 0;
	while(isalive(level.player))
	{
		var_04 = "none";
		if(isdefined(param_01.lock_target))
		{
			var_04 = "locked";
		}

		var_05 = var_04 == "locked";
		var_06 = var_04 == "locking";
		if(var_06 && !var_02)
		{
			param_01 playsound("dogfight_player_guns_targeting");
			var_02 = 1;
		}
		else if(!var_06 && var_02)
		{
			var_02 = 0;
		}

		if(var_05 && !var_03)
		{
			param_01 playsound("dogfight_player_guns_locked");
			var_03 = 1;
			continue;
		}

		if(!var_05 && var_03)
		{
			var_03 = 0;
		}

		wait 0.05;
	}
}

//Function Number: 109
canyon_whizby_sounds(param_00,param_01)
{
	foreach(var_03 in [-1,0,1])
	{
		foreach(var_05 in [-1,0,1])
		{
			if(var_03 != 0 || var_05 != 0)
			{
				thread canyon_whizby_sound(param_00,param_01,vectornormalize((0,var_03,var_05)));
			}
		}
	}
}

//Function Number: 110
canyon_whizby_sound(param_00,param_01,param_02)
{
	level endon("end_canyon");
	var_03 = common_scripts\utility::spawn_tag_origin();
	var_03 playloopsound("dogfight_player_plane_canyon_reflection");
	var_04 = 3000;
	var_05 = 0.1;
	var_06 = var_04;
	var_07 = param_01.origin;
	for(;;)
	{
		var_08 = param_01.origin + param_01 maps\_shg_utility::get_differentiated_velocity() * var_05;
		var_09 = transformmove(var_08,param_01.angles,(0,0,0),(0,0,0),param_02 * var_04,(0,0,0))["origin"];
		var_0A = bullettrace(var_08,var_09,0,param_01);
		if(var_0A["fraction"] < 1)
		{
			var_03.origin = var_0A["position"];
		}

		var_0B = soundscripts\_audio_vehicle_manager::avm_compute_doppler_pitch(var_03.origin,(0,0,0),param_00.origin,param_00 maps\_shg_utility::get_differentiated_velocity(),1,1);
		var_03 scalepitch(var_0B,0.05);
		wait 0.05;
	}
}

//Function Number: 111
get_crash_deflection_angle()
{
	var_00 = 30;
	var_01 = maps\_utility::getdifficulty();
	switch(var_01)
	{
		case "medium":
			var_00 = 25;
			break;

		case "hard":
			var_00 = 20;
			break;

		case "fu":
			var_00 = 10;
			break;
	}

	return var_00;
}

//Function Number: 112
fighter_jet_crash_detection(param_00,param_01)
{
	param_00 endon("death");
	param_01 endon("death");
	var_02 = 7744;
	var_03 = param_01.origin;
	var_04 = 1;
	var_05 = -30;
	var_06 = 50;
	var_07 = -1;
	var_08 = 20;
	var_09 = 0 - var_08;
	var_0A = 0;
	var_0B = 0;
	var_0C = 0;
	var_0D = 0;
	var_0E = maps\_utility::getdifficulty();
	var_0F = get_crash_deflection_angle();
	var_10 = cos(var_0F);
	for(;;)
	{
		if(maps\_utility::getdifficulty() != var_0E)
		{
			var_0E = maps\_utility::getdifficulty();
			var_0F = get_crash_deflection_angle();
			var_10 = cos(var_0F);
		}

		param_01 waittill("veh_collision",var_11,var_12,var_13);
		var_14 = vectordot(vectornormalize(var_11),vectornormalize(param_01 vehicle_getvelocity()));
		var_15 = 0;
		var_16 = var_14 < var_10;
		var_17 = gettime();
		if(isdefined(var_13) && var_13 maps\_vehicle::isvehicle())
		{
			continue;
		}

		if((!isdefined(var_13) || isdefined(var_13) && isdefined(var_13.targetname) && var_13.targetname != "turnaround_vol") && getdvarfloat("vehPlanePathAngle") >= 0 && getdvarfloat("vehPlanePathAllowance") > 0)
		{
			var_18 = angleclamp(level.player.angles[1]);
			var_19 = angleclamp180(var_18 - getdvarfloat("vehPlanePathAngle"));
			if(abs(var_19) >= 60)
			{
				if(var_17 - var_0B >= 500)
				{
					var_0A = 0;
					var_0B = gettime();
				}

				var_0A++;
				if(var_0A >= 3)
				{
					var_15 = 1;
				}
			}
		}

		if(distancesquared(param_01.origin,var_03) < var_02)
		{
			var_15 = 1;
		}

		var_03 = param_01.origin;
		if(!var_15 && isdefined(var_13) && isdefined(var_13.targetname) && var_13.targetname == "turnaround_vol" && var_0A < 3)
		{
			continue;
		}

		var_1A = getbumpallowancebasedondifficulty();
		if(!var_15)
		{
			if(isdefined(var_13) && var_13.targetname == "floor_clip")
			{
				thread reversegravity(1);
				var_0C++;
				var_1B = gettimeallowancebasedondifficulty();
				if(var_1B > 0 && var_17 > var_0D + var_1B)
				{
					var_0D = var_17;
					var_0C = 1;
				}
				else if(var_1A > 0 && var_0C > var_1A)
				{
					var_15 = 1;
				}

				if(var_16 && maps\_utility::getdifficulty() == "fu")
				{
					var_15 = 1;
				}

				if(var_1A > 0 && var_0C > var_1A - 15)
				{
					thread fake_damage_indicator((0,0,-1),var_1B - var_17 - var_0D / 1000,0,undefined,1);
				}
			}
			else if(var_16)
			{
				var_15 = 1;
			}
		}

		if((isdefined(var_13) && var_13.targetname != "floor_clip") || var_1A > 0)
		{
			param_01 notify("damage",1,level,undefined,param_01.origin,"COLLISION","","");
		}

		thread fighter_jet_set_shake(5,1);
		param_01 playsound("plr_jet_bounce_hit");
		if(var_15)
		{
			thread common_scripts\utility::play_sound_in_space("plr_jet_crash_hit",level.player.origin);
			level.player digitaldistortsetparams(1,1);
			thread fadeupstatic(0.05,1);
			level notify("kill_player_targeting_think");
			var_1C = target_getarray();
			foreach(var_1E in var_1C)
			{
				target_hidefromplayer(var_1E,level.player);
				target_remove(var_1E);
			}

			level.plane.lock_targets = [];
			wait(0.05);
			param_00 dismountvehicle();
			wait(0.25);
			setdvar("ui_deadquote",&"PLAYERPLANE_YOU_CRASHED");
			maps\_utility::missionfailedwrapper();
			continue;
		}

		param_01 notify("plane_bump");
	}
}

//Function Number: 113
reversegravity(param_00)
{
	level notify("reverse_gravity");
	level endon("reverse_gravity");
	if(!isdefined(level.old_gravity))
	{
		level.old_gravity = getdvarfloat("vehPlaneGravityVelocity");
	}

	setsaveddvar("vehPlaneGravityVelocity",level.old_gravity * -0.5);
	wait(param_00);
	setsaveddvar("vehPlaneGravityVelocity",level.old_gravity);
}

//Function Number: 114
gettimeallowancebasedondifficulty()
{
	var_00 = maps\_utility::getdifficulty();
	var_01 = -1;
	switch(var_00)
	{
		case "medium":
			var_01 = 3;
			break;

		case "hard":
			var_01 = 1.5;
			break;

		case "fu":
			var_01 = 3;
			break;
	}

	return var_01 * 1000;
}

//Function Number: 115
getbumpallowancebasedondifficulty()
{
	var_00 = maps\_utility::getdifficulty();
	var_01 = -1;
	switch(var_00)
	{
		case "medium":
			var_01 = 50;
			break;

		case "hard":
			var_01 = 15;
			break;

		case "fu":
			var_01 = 15;
			break;
	}

	return var_01;
}

//Function Number: 116
monitor_missile_firing()
{
	self.depleted = 0;
	for(;;)
	{
		level.player waittill("missile_shot",var_00,var_01);
		if(self.salvo_idx == var_00 && self.missile_idx == var_01)
		{
			self setshader("jet_hud_ammo_missile_0",self.dimensionsx,self.dimensionsy);
			self.depleted = 1;
			wait(12);
			self setshader("jet_hud_ammo_missile_1",self.dimensionsx,self.dimensionsy);
			self.depleted = 0;
		}
	}
}

//Function Number: 117
monitor_missile_indication()
{
	level.player endon("death");
	level endon("end_canyon");
	for(;;)
	{
		var_00 = level.player common_scripts\utility::waittill_any_return("lock_on","locked_on_off","y_pressed");
		if(isdefined(var_00) && var_00 == "locked_on")
		{
			self.alpha = 0.75;
			self.color = (1,0.2,0.2);
		}

		if(var_00 == "locked_on_off" || var_00 == "y_pressed")
		{
			self.alpha = 0.75;
			self.color = (0.2,0.3,1);
		}
	}
}

//Function Number: 118
make_missile_ammo_hud(param_00,param_01,param_02,param_03,param_04)
{
	var_05 = [];
	var_06 = 5;
	var_07 = 20;
	for(var_08 = 0;var_08 < param_01;var_08++)
	{
		var_09 = newclienthudelem(level.player);
		var_09.positioninworld = 1;
		var_09 settargetent(param_04);
		var_09 setshader("jet_hud_ammo_missile_1",var_07,var_06);
		var_09.alignx = "center";
		var_09.aligny = "middle";
		var_09.x = param_02;
		var_09.y = param_03 + var_06 * var_05.size + 20 * var_05.size;
		var_09.alpha = 0.1;
		var_09.salvo_idx = param_00;
		var_09.missile_idx = var_08;
		var_09.dimensionsx = var_07;
		var_09.dimensionsy = var_06;
		var_09 thread monitor_missile_firing();
		var_05[var_05.size] = var_09;
	}

	return var_05;
}

//Function Number: 119
rotate_axis_angle(param_00,param_01,param_02)
{
	var_03 = vectortoangles(param_00);
	return transformmove((0,0,0),var_03 + (0,0,param_01),(0,0,0),var_03,param_02,(0,0,0))["origin"];
}

//Function Number: 120
fighter_jet_gun_hud()
{
	level.player endon("death");
	level endon("end_canyon");
	var_00 = 0;
	var_01 = 0;
	var_02 = 0.99;
	var_03 = 0;
	var_04 = 10;
	var_05 = cos(5);
	var_06 = 50000;
	var_07 = 250000;
	var_08 = 13000;
	var_09 = get_plane_gun_angles();
	var_0A = anglestoforward(get_plane_gun_angles());
	var_0B = var_0A;
	var_0C = var_0A;
	while(isdefined(level.plane))
	{
		var_0D = get_plane_gun_origin();
		var_0E = level.player geteye();
		level.player.eye_origin = var_0E;
		var_0F = get_plane_gun_angles();
		var_10 = anglestoforward(var_0F);
		var_11 = anglestoup(var_0F);
		var_12 = anglestoright(var_0F);
		var_0C = vectornormalize(transformmove((0,0,0),var_0F,(0,0,0),var_09,var_0C,(0,0,0))["origin"]);
		var_13 = var_10 - anglestoforward(var_09) * 20;
		var_09 = var_0F;
		var_14 = undefined;
		var_15 = vectornormalize(var_10 + var_13 * var_00);
		var_0B = vectornormalize(vectorlerp(var_15,var_0B,var_01));
		var_16 = undefined;
		var_16 = compute_best_gun_target(var_10,var_0E,var_0D,var_06,level.plane.lock_target);
		if(isdefined(var_16))
		{
			compute_target_lead_origin(var_16,var_0D,var_06);
			var_17 = vectornormalize(var_16.lead_origin - var_0E);
			var_18 = vectornormalize(vectorlerp(var_10,var_17,var_02));
			var_19 = 1;
		}
		else
		{
			var_18 = vectornormalize(level.player.jethud["hud_tag"].origin - var_0D);
			var_19 = 0;
		}

		var_1A = constrain_vector_to_cone(var_18,var_0B,var_04);
		var_0C = vectornormalize(vectorlerp(var_1A,var_0C,var_03));
		if(isdefined(var_16))
		{
			var_1B = distance(var_16.lead_origin,var_0E);
		}
		else
		{
			var_1B = 25000;
		}

		level.plane.player_gun_lock_target_origin = var_0E + var_1B * var_0C;
		var_1C = 0;
		if(isdefined(var_16))
		{
			if(vectordot(vectornormalize(var_16.lead_origin - var_0E),var_0C) > var_05)
			{
				var_1C = 1;
			}
		}

		level.player.jethud["weapon_reticle"] setshader("jet_hud_overlay_cannon_reticle_lockon",640,480);
		level.plane.lock_target = var_16;
		var_1D = var_0E + var_0C * var_07;
		level.player.jethud["weapon_bore_tag"] unlink();
		level.player.jethud["weapon_bore_tag"].origin = var_1D;
		level.player.jethud["weapon_bore_tag"] linkto(level.plane,"tag_player");
		var_1E = var_0E + var_0B * var_07;
		level.player.reticle_origin = var_1E;
		level.player.jethud["weapon_reticle_tag"] unlink();
		level.player.jethud["weapon_reticle_tag"].origin = var_1E;
		level.player.jethud["weapon_reticle_tag"] linkto(level.plane,"tag_player");
		wait 0.05;
	}
}

//Function Number: 121
compute_best_gun_target(param_00,param_01,param_02,param_03,param_04)
{
	var_05 = cos(25);
	var_06 = cos(25);
	var_07 = 15000;
	var_08 = 0;
	var_09 = 10;
	var_0A = 0;
	if(level.player adsbuttonpressed(1))
	{
		var_0A = 0;
	}

	var_0B = undefined;
	var_0C = 0;
	if(isdefined(level.enemy_units))
	{
		foreach(var_0E in level.enemy_units)
		{
			if(!isdefined(var_0E) || !isdefined(var_0E.origin))
			{
				continue;
			}

			compute_target_lead_origin(var_0E,param_02,param_03);
			if(!isdefined(var_0E.lead_origin))
			{
				continue;
			}

			var_0F = distance(var_0E.origin,param_01);
			if(var_0F > var_07)
			{
				continue;
			}

			var_10 = isdefined(param_04) && var_0E == param_04;
			var_11 = vectordot(vectornormalize(var_0E.origin - param_01),param_00);
			if(var_10 && var_11 < var_06)
			{
				continue;
			}
			else if(!var_10 && var_11 < var_05)
			{
				continue;
			}

			if(!var_0E has_los())
			{
				continue;
			}

			var_12 = 0;
			var_12 = var_12 + maps\_shg_utility::linear_map_clamp(var_11,1,var_05,var_09,0);
			var_12 = var_12 + maps\_shg_utility::linear_map_clamp(var_0F,0,var_07,var_08,0);
			if(var_10)
			{
				var_12 = var_12 + var_0A;
			}

			if(var_12 > var_0C)
			{
				var_0B = var_0E;
			}
		}
	}

	return var_0B;
}

//Function Number: 122
compute_target_lead_origin(param_00,param_01,param_02)
{
	var_03 = param_00 maps\_shg_utility::get_differentiated_velocity();
	var_04 = param_00.origin - param_01;
	var_05 = lengthsquared(var_03) - squared(param_02);
	var_06 = 2 * vectordot(var_03,var_04);
	var_07 = lengthsquared(var_04);
	var_08 = squared(var_06) - 4 * var_05 * var_07;
	if(var_08 > 0)
	{
		var_09 = 2 * var_07 / sqrt(var_08) - var_06;
		var_09 = var_09 + 0.05;
		param_00.lead_origin = param_00.origin + param_00 maps\_shg_utility::get_differentiated_velocity() * var_09;
		return;
	}

	param_00.lead_origin = undefined;
}

//Function Number: 123
constrain_vector_to_cone(param_00,param_01,param_02)
{
	var_03 = vectordot(param_01,param_00);
	if(var_03 < cos(param_02))
	{
		var_04 = param_00 - param_01 * var_03;
		var_05 = length(var_04);
		var_06 = var_05 / tan(param_02);
		return vectornormalize(param_00 + param_01 * var_06 - var_03);
	}

	return var_03;
}

//Function Number: 124
is_true(param_00)
{
	return isdefined(param_00) && param_00;
}

//Function Number: 125
waittill_any_trigger(param_00,param_01,param_02,param_03,param_04,param_05)
{
	var_06 = spawnstruct();
	var_07 = [param_00,param_01,param_02,param_03,param_04,param_05];
	foreach(var_0A, var_09 in var_07)
	{
		if(isdefined(var_09))
		{
			var_06 thread notify_on_trigger("trig" + var_0A,var_09);
		}
	}

	var_06 common_scripts\utility::waittill_any("trig0","trig1","trig2","trig3","trig4","trig5");
}

//Function Number: 126
waittill_trigger_with_name(param_00)
{
	var_01 = getent(param_00,"targetname");
	if(!isdefined(var_01))
	{
		var_01 = getent(param_00,"script_noteworthy");
	}

	if(!isdefined(var_01))
	{
		return;
	}

	var_01 waittill("trigger");
}

//Function Number: 127
sortbydistanceauto(param_00,param_01,param_02)
{
	return sortbydistance(param_00,param_01,param_02,1);
}

//Function Number: 128
target_setsafe(param_00,param_01)
{
	if(!isdefined(param_01))
	{
		param_01 = 0;
	}

	var_02 = getentarray();
	var_03 = 0;
	var_04 = 60;
	var_05 = [];
	foreach(var_07 in var_02)
	{
		if(target_istarget(var_07))
		{
			var_03++;
			var_05[var_05.size] = var_07;
		}
	}

	if(var_03 < var_04)
	{
		target_set(param_00);
		return;
	}

	if(param_01)
	{
		var_05 = sortbydistanceauto(var_05,param_00.origin);
		var_05 = common_scripts\utility::array_reverse(var_05);
		param_00.forcetarget = 1;
		foreach(var_0A in var_05)
		{
			if(!isdefined(var_0A.forcetarget) || !var_0A.forcetarget)
			{
				target_remove(var_0A);
				target_set(param_00);
				break;
			}
		}
	}
}

//Function Number: 129
notify_on_trigger_with_name(param_00,param_01)
{
	waittill_trigger_with_name(param_01);
	if(isdefined(self))
	{
		self notify(param_00);
		return;
	}

	level notify(param_00);
}

//Function Number: 130
notify_on_trigger(param_00,param_01)
{
	param_01 waittill("trigger");
	if(isdefined(self))
	{
		self notify(param_00);
		return;
	}

	level notify(param_00);
}

//Function Number: 131
notify_on_use_trigger(param_00,param_01)
{
	param_01 waittill("trigger");
	self notify(param_00);
}

//Function Number: 132
target_setshadersafe(param_00,param_01)
{
	if(target_istarget(param_00))
	{
		target_setshader(param_00,param_01);
	}
}

//Function Number: 133
offset_position_from_tag(param_00,param_01,param_02)
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
}

//Function Number: 134
is_ground_enemy(param_00)
{
	if(isdefined(param_00.ground_target))
	{
		return 1;
	}

	return 0;
}

//Function Number: 135
generic_human()
{
}

//Function Number: 136
fx_init()
{
}

//Function Number: 137
array_combine_all(param_00,param_01,param_02,param_03,param_04,param_05,param_06,param_07,param_08)
{
	var_09 = [param_00,param_01,param_02,param_03,param_04,param_05,param_06,param_07,param_08];
	var_0A = [];
	foreach(var_0C in var_09)
	{
		if(isdefined(var_0C))
		{
			var_0A = common_scripts\utility::array_combine(var_0A,var_0C);
		}
	}

	return var_0A;
}

//Function Number: 138
shoot_target_till_dead(param_00,param_01,param_02)
{
	self endon("death");
	self endon("stop_engaging");
	while(isdefined(self) && isalive(param_00) && isalive(self))
	{
		var_03 = maps\_utility::get_dot(self.origin,self.angles,param_00.origin);
		if(var_03 > 0.15)
		{
			thread ai_shoot_missile_salvo(param_00,param_01);
			param_00 notify("missile_fired_at");
		}

		wait(param_02);
	}
}

//Function Number: 139
ai_shoot_missile_salvo(param_00,param_01)
{
	if(isalive(param_00))
	{
		for(var_02 = 0;var_02 < param_01;var_02++)
		{
			thread ai_shoot_missile(param_00);
		}
	}
}

//Function Number: 140
ai_shoot_missile(param_00)
{
	var_01 = offset_position_from_tag("forward","tag_origin",1000);
	self playsound("canyon_missile_fire_npc");
	var_02 = magicbullet("sidewinder_atlas_jet",var_01,param_00.origin);
	var_02 missile_settargetent(param_00);
	var_02 thread monitor_missile_death(1,self,undefined,param_00);
	return var_02;
}

//Function Number: 141
get_jet_array(param_00,param_01)
{
	if(!isdefined(param_01))
	{
		param_01 = "script_noteworthy";
	}

	var_02 = getentarray(param_00,param_01);
	var_03 = [];
	foreach(var_05 in var_02)
	{
		if(isalive(var_05))
		{
			var_03[var_03.size] = var_05;
		}
	}

	return var_03;
}

//Function Number: 142
engage_enemies(param_00,param_01,param_02,param_03,param_04,param_05)
{
	level endon("finale");
	if(!isdefined(param_05))
	{
		param_05 = 1;
	}

	if(!isdefined(param_04))
	{
		param_04 = 1;
	}

	param_00 = maps\_utility::remove_dead_from_array(param_00);
	var_06 = param_00;
	if(param_00.size < 1 || param_01.size < 1)
	{
		return;
	}

	while(param_00.size < param_01.size * param_04)
	{
		param_00 = common_scripts\utility::array_combine(param_00,var_06);
	}

	if(!isdefined(param_02))
	{
		param_02 = 0;
	}

	if(!isdefined(param_03))
	{
		param_03 = 10;
	}

	var_07 = 0;
	foreach(var_09 in param_01)
	{
		if(is_true(var_09.ground_target))
		{
			continue;
		}

		if(param_00.size <= 0)
		{
			break;
		}

		for(var_0A = 0;var_0A < param_04;var_0A++)
		{
			if(param_00.size <= 0)
			{
				continue;
			}

			if(param_00[var_07].script_team == "allies")
			{
				level notify("ally_targeting_enemy");
			}

			param_00[var_07] thread shoot_target_till_dead(var_09,param_05,param_03);
			wait(param_02);
			param_00 = maps\_utility::remove_dead_from_array(param_00);
			var_07++;
			if(var_07 >= param_00.size)
			{
				var_07 = 0;
			}
		}
	}
}

//Function Number: 143
rake_with_bullets(param_00,param_01,param_02)
{
	self endon("death");
	if(!isdefined(param_02))
	{
		param_02 = 1;
	}

	if(!isdefined(param_01))
	{
		param_01 = 0.5;
	}

	var_03 = gettime();
	var_04 = var_03 + randomfloatrange(param_01,param_02) * 1000;
	var_05 = maps\_utility::get_dot(self.origin,self.angles,param_00.origin);
	self playloopsound("s19_mgun_shot_lp_npc");
	while(var_03 < var_04 && var_05 > 0 && isdefined(param_00) && isalive(param_00))
	{
		if(!isdefined(param_00.model) || param_00.model == "")
		{
			break;
		}

		var_06 = offset_position_from_tag("forward",self.mgun_left,1000);
		var_07 = param_00.origin;
		if(maps\_utility::hastag(param_00.model,"tag_origin"))
		{
			var_07 = param_00 offset_position_from_tag("forward","tag_origin",1200);
		}

		var_08 = magicbullet("s19_cannon_AI",var_06,var_07);
		wait(0.1);
		var_09 = offset_position_from_tag("forward",self.mgun_right,1000);
		var_08 = magicbullet("s19_cannon_AI",var_09,var_07);
		wait(0.2);
		if(isdefined(param_00) && isalive(param_00))
		{
			var_05 = maps\_utility::get_dot(self.origin,self.angles,param_00.origin);
			var_03 = gettime();
		}
	}

	self stoploopsound("s19_mgun_shot_lp_npc");
	self playsound("s19_mgun_shot_lp_end_npc");
	wait(randomfloatrange(0.3,1));
}

//Function Number: 144
lock_on_warning(param_00)
{
	level.player.jethud["lockon_warning"].color = (1,0.2,0.2);
	level.player.jethud["lockon_warning"] settext("ENEMY LOCK");
	var_01 = common_scripts\utility::spawn_tag_origin();
	var_01 linkto(self,"",(0,0,0),(0,0,0));
	level.player.jethud["lockon_warning"].alpha = 1;
	var_01 playloopsound("dogfight_player_missile_locked_lp");
	param_00 common_scripts\utility::waittill_any("stop_lock_on_warning","death");
	level.player.jethud["lockon_warning"].alpha = 0;
	var_01 stoploopsound();
	wait 0.05;
	var_01 delete();
}

//Function Number: 145
lock_on_to_player()
{
	if(1)
	{
		if(gettime() > level.last_missile_fired_at_player + 2500)
		{
			level.plane thread fake_damage_indicator(vectornormalize(level.plane.origin - self.origin));
			thread missile_miss_player();
			level.last_missile_fired_at_player = gettime();
			return;
		}

		return;
	}

	if(common_scripts\utility::flag("target_player") && !level.enemy_locking_on_to_player && gettime() >= level.last_missile_fired_at_player + 5000)
	{
		level.player notify("enemy_lock_on");
		level.enemy_locking_on_to_player = 1;
		level.player_popped_flares = 0;
		level.player thread maps\_utility::display_hint_timeout("flares_hint",2);
		level.player thread lock_on_warning(self);
		var_00 = level common_scripts\utility::waittill_notify_or_timeout_return("pop_flares",1);
		wait 0.05;
		if(level.flares_active)
		{
			thread missile_miss_player();
		}
		else if(isalive(self))
		{
			var_01 = maps\_utility::get_dot(self.origin,self.angles,level.player.origin);
			if(var_00 == "timeout" && var_01 > 0)
			{
				level.player.jethud["lockon_warning"].color = (1,0,0);
				level.player.jethud["lockon_warning"] settext("FIRING");
				level common_scripts\utility::waittill_notify_or_timeout("pop_flares",1);
				if(level.flares_active)
				{
					thread missile_miss_player();
				}
				else
				{
					level.player playsound("plr_jet_hit_by_missile_lyr1");
					var_02 = magicbullet("sidewinder_atlas_jet",level.plane.fake_enemy_missile_spawn.origin,level.plane.missile_target.origin);
					var_02 missile_settargetent(level.plane.missile_target);
					wait(0.25);
					playfxontag(level._effect["explosion"],level.plane,"tag_origin");
					level.plane dodamage(10,level.plane.origin,self,self,"MOD_EXPLOSIVE","sidewinder_atlas_jet");
					level.plane vehicle_teleport(level.plane.origin,level.plane.angles + (0,0,45));
				}
			}
		}

		self notify("stop_lock_on_warning");
		level.last_missile_fired_at_player = gettime();
		level.enemy_locking_on_to_player = 0;
		wait(5);
	}
}

//Function Number: 146
missile_miss_player(param_00)
{
	var_01 = maps\_utility::get_dot(level.player.origin,level.player.angles,self.origin);
	var_02 = level.plane offset_position_from_tag("forward","tag_origin",10000) + (0,0,200);
	var_03 = self.origin;
	if(var_01 > 0)
	{
		var_03 = offset_position_from_tag("forward","tag_origin",1000);
	}
	else
	{
		var_03 = level.plane offset_position_from_tag("backward","tag_origin",500);
		if(level.plane.angles[0] > 0 && level.plane.angles[0] < 180)
		{
			var_03 = var_03 + (0,0,500);
		}
		else
		{
			var_03 = var_03 - (0,0,500);
		}

		var_03 = var_03 + (randomintrange(-256,256),randomintrange(-256,256),randomintrange(-256,256));
	}

	var_04 = magicbullet("sidewinder_atlas_jet",var_03,var_02);
	var_04 thread monitor_missile_death(1,self);
	if(!is_true(param_00) && randomint(100) > 25)
	{
		maps\_utility::delaythread(0.25,::missile_miss_player,1);
	}
}

//Function Number: 147
enemy_jet_shoot_think()
{
	self endon("death");
	var_00 = 225000000;
	var_01 = 36000000;
	var_02 = 100000000;
	var_03 = 0;
	for(;;)
	{
		if(common_scripts\utility::flag("target_player"))
		{
			var_04 = maps\_utility::get_dot(self.origin,self.angles,level.player.origin);
			if(var_04 > 0)
			{
				var_05 = distancesquared(self.origin,level.player.origin);
				if(var_05 < var_01 || !common_scripts\utility::flag("target_player"))
				{
					rake_with_bullets(level.plane);
				}
				else
				{
					lock_on_to_player();
				}
			}
		}

		var_06 = level.friend_jets;
		foreach(var_08 in var_06)
		{
			if(isremovedentity(var_08))
			{
				level.friend_jets = common_scripts\utility::array_remove(level.friend_jets,var_08);
				wait(0.1);
				break;
			}

			var_09 = gettime();
			var_04 = maps\_utility::get_dot(self.origin,self.angles,var_08.origin);
			if(var_04 > 0.93)
			{
				var_05 = distancesquared(self.origin,level.player.origin);
				if(var_05 < var_02)
				{
					rake_with_bullets(var_08);
					break;
				}
				else if(var_09 >= var_03)
				{
					thread ai_shoot_missile(var_08);
					var_03 = var_09 + 5000;
					break;
				}
			}

			wait(0.05);
		}

		wait(0.1);
	}
}

//Function Number: 148
ally_jet_shoot_think()
{
	self endon("death");
	var_00 = 225000000;
	var_01 = 36000000;
	var_02 = 100000000;
	var_03 = 0;
	if(!isdefined(level.enemy_units))
	{
		level.enemy_units = [];
	}

	for(;;)
	{
		if(level.ally_ai_active)
		{
			var_04 = 0;
			var_05 = maps\_utility::get_dot(self.origin,self.angles,level.player.origin);
			if(var_05 > 0)
			{
				var_04 = 1;
			}

			var_06 = level.enemy_units;
			foreach(var_08 in var_06)
			{
				if(!isdefined(var_08))
				{
					level.enemy_units = common_scripts\utility::array_remove(level.enemy_units,var_08);
					wait(0.1);
					break;
				}

				var_09 = gettime();
				var_05 = maps\_utility::get_dot(self.origin,self.angles,var_08.origin);
				if(var_05 > 0.93)
				{
					var_0A = distancesquared(self.origin,level.player.origin);
					if(var_0A < var_02)
					{
						rake_with_bullets(var_08,0.3,0.6);
						wait(randomfloatrange(0.2,1));
						break;
					}
				}

				wait(0.05);
			}
		}

		wait(0.1);
	}
}

//Function Number: 149
plane_health_monitor()
{
	level endon("finale");
	self.almost_dead = 0;
	self.current_hit_count = 0;
	self.invulnerabletime = 0;
	self.lasthit = 0;
	if(level.gameskill == 3)
	{
		self.max_hit_count = 1;
	}
	else if(level.gameskill == 2)
	{
		self.max_hit_count = 2;
	}
	else
	{
		self.max_hit_count = 2;
	}

	self.max_health = self.health;
	while(!common_scripts\utility::flag("final_hit"))
	{
		self waittill("damage",var_00,var_01,var_02,var_03,var_04);
		var_04 = tolower(var_04);
		self.health = self.max_health;
		if(isdefined(var_01) && (isdefined(var_01.script_team) && var_01.script_team == "allies") || var_01 == level.player)
		{
			continue;
		}

		if(var_04 == "collision")
		{
			thread fake_damage_indicator(var_02,undefined,0);
		}
		else
		{
			thread fake_damage_indicator(var_02);
		}

		if(var_04 == "mod_impact")
		{
			thread fake_bullet_damage_sounds();
			thread fighter_jet_set_shake(2,0.5);
			continue;
		}

		var_05 = 1;
		if(var_04 == "flak_hit")
		{
			var_05 = 0.5;
		}

		if(var_04 == "flak_pepper")
		{
			thread fake_bullet_damage_sounds();
			var_05 = 0.05;
		}

		if(var_04 == "mod_projectile" || var_04 == "mod_projectile_splash" || var_04 == "flak_hit")
		{
			thread fighter_jet_set_shake(4,1.5);
			if(self.current_hit_count / self.max_hit_count < 0.5)
			{
				var_05 = 0.1;
			}
			else
			{
				var_05 = 0;
			}
		}

		var_06 = gettime();
		if(var_06 <= self.invulnerabletime && var_05 < 1)
		{
			continue;
		}

		if(!common_scripts\utility::flag("playerPlaneNoDeath"))
		{
			self.current_hit_count = self.current_hit_count + var_05;
		}
		else if(self.current_hit_count < self.max_hit_count - 1)
		{
			self.current_hit_count = self.current_hit_count + var_05;
		}
		else
		{
			self.current_hit_count = self.max_hit_count - 1;
		}

		if(self.current_hit_count < 0)
		{
			self.current_hit_count = 0;
		}

		earthquake(0.5,1,self.origin,512);
		level.player playrumbleonentity("damage_heavy");
		level.player viewkick(1,var_03);
		self.lasthit = var_06;
		if(self.current_hit_count >= self.max_hit_count)
		{
			if(!self.almost_dead || var_04 == "mod_projectile" || var_04 == "mod_projectile_splash" || var_04 == "flak_hit")
			{
				self.current_hit_count = self.max_hit_count - 0.1;
				continue;
			}

			self makeusable();
			self useby(level.player);
			level.player disableinvulnerability();
			level.player kill();
			self kill();
			return;
		}
	}
}

//Function Number: 150
fake_bullet_damage_sounds()
{
	var_00 = randomintrange(3,7);
	for(var_01 = 1;var_01 <= var_00;var_01++)
	{
		level.player playsound("plr_jet_bullet_imp");
		wait(randomfloatrange(0.1,0.22));
	}
}

//Function Number: 151
fake_damage_indicator(param_00,param_01,param_02,param_03,param_04)
{
	if(!isdefined(param_01))
	{
		param_01 = 0.5;
	}

	if(!isdefined(param_02))
	{
		param_02 = 3;
	}

	if(!isdefined(param_03))
	{
		param_03 = 0.5;
	}

	if(!is_true(param_04) && is_true(self.showing_damage))
	{
		return;
	}

	if(is_true(param_04))
	{
		self notify("fake_damage_indicator");
		self endon("fake_damage_indicator");
	}

	self.showing_damage = 1;
	level.player playsound("plr_jet_missile_imp_snap");
	if(isdefined(param_00) && param_00 != (0,0,0))
	{
		var_05 = 0.5;
		var_06 = anglestoforward(self.angles) + param_00 * var_05;
		var_06 = vectortoangles(var_06);
		var_06 = self.angles + (0,0,var_06[2]);
		level.plane vehicle_teleport(level.plane.origin,var_06);
	}

	earthquake(0.5,1,self.origin,512);
	level.player playrumbleonentity("damage_heavy");
	level.player viewkick(1,level.player.origin);
	level.player digitaldistortsetparams(param_03,1.5);
	thread chromo_anim2(param_01,0.5);
	wait(param_01);
	level.player digitaldistortsetparams(0,1);
	wait(param_02);
	self.showing_damage = 0;
}

//Function Number: 152
chromo_anim2(param_00,param_01)
{
	level notify("chromo_anim");
	level endon("chromo_anim");
	setsaveddvar("r_chromaticAberrationTweaks",1);
	var_02 = 1;
	if(param_01)
	{
		var_02 = param_01;
	}

	setsaveddvar("r_chromaticAberration",1);
	var_03 = param_00 * 20;
	var_04 = 0;
	level.chromo_offset = 20 * var_02;
	var_05 = level.chromo_offset;
	for(var_04 = 0;var_04 < var_03;var_04++)
	{
		var_06 = 1 / var_03 * var_05;
		level.chromo_offset = level.chromo_offset - var_06;
		setsaveddvar("r_chromaticSeparationG",level.chromo_offset * -1);
		setsaveddvar("r_chromaticSeparationR",level.chromo_offset);
		wait(0.05);
	}

	level.chromo_offset = 0;
	setsaveddvar("r_chromaticSeparationG",0);
	setsaveddvar("r_chromaticSeparationR",0);
}

//Function Number: 153
plane_health_regen()
{
	level endon("finale");
	for(;;)
	{
		wait(0.05);
		waittillframeend;
		var_00 = gettime();
		if(self.current_hit_count > 0 && var_00 >= self.lasthit + level.player.gs.playerhealth_regularregendelay / 2)
		{
			self.current_hit_count = self.current_hit_count - 1;
			if(self.current_hit_count < 0)
			{
				self.current_hit_count = 0;
			}

			self notify("regen");
		}

		var_01 = clamp(self.current_hit_count / self.max_hit_count,0,0.5);
		level.player digitaldistortsetparams(var_01,1.5);
		if(var_01 >= 0.5 && !self.almost_dead)
		{
			self.almost_dead = 1;
			fadeupstatic(0.25);
			self.invulnerabletime = var_00 + level.player.gs.invultime_onshield * 5;
		}

		if(var_01 == 0 && self.almost_dead)
		{
			thread fadedownstatic(1);
			level.player digitaldistortsetparams(0,1);
			self.current_hit_count = 0;
			self.almost_dead = 0;
		}
	}

	level.player painvisionoff();
}

//Function Number: 154
fadeupstatic(param_00,param_01)
{
	if(!isdefined(param_01))
	{
		param_01 = 0.05;
	}

	if(!isdefined(level.overlaystatic))
	{
		level.overlaystatic = newhudelem(level.player);
		level.overlaystatic.x = 0;
		level.overlaystatic.y = 0;
		level.overlaystatic.alpha = 0;
		level.overlaystatic.horzalign = "fullscreen";
		level.overlaystatic.vertalign = "fullscreen";
		level.overlaystatic.sort = 4;
		level.overlaystatic setshader("overlay_static_digital",640,480);
		var_02 = param_01 / param_00 / 0.05;
		while(level.overlaystatic.alpha < param_01)
		{
			level.overlaystatic.alpha = level.overlaystatic.alpha + var_02;
			wait(0.05);
		}

		level.overlaystatic.alpha = param_01;
	}
}

//Function Number: 155
fadedownstatic(param_00)
{
	if(isdefined(level.overlaystatic))
	{
		var_01 = 0.05 / param_00;
		while(isdefined(level.overlaystatic) && level.overlaystatic.alpha > 0)
		{
			level.overlaystatic.alpha = level.overlaystatic.alpha - var_01;
			wait(0.05);
		}

		level.overlaystatic destroy();
		level.overlaystatic = undefined;
	}
}

//Function Number: 156
init_jet_crash_points()
{
	level.jet_crash_points = getvehiclenodearray("jet_crash_location","targetname");
}

//Function Number: 157
available_crash_paths()
{
	var_00 = [];
	foreach(var_02 in level.jet_crash_points)
	{
		if(!isdefined(var_02.claimed))
		{
			var_00[var_00.size] = var_02;
		}
	}

	return var_00;
}

//Function Number: 158
choose_crash_path()
{
	var_00 = available_crash_paths();
	var_01 = getclosest_in_front(self.origin,var_00);
	return var_01;
}

//Function Number: 159
getclosest_in_front(param_00,param_01,param_02,param_03)
{
	if(!isdefined(param_02))
	{
		param_02 = 20000;
	}

	if(!isdefined(param_03))
	{
		param_03 = 0.94;
	}

	var_04 = undefined;
	foreach(var_06 in param_01)
	{
		if(!isdefined(var_06))
		{
			continue;
		}

		var_07 = distance(var_06.origin,param_00);
		if(var_07 >= param_02)
		{
			continue;
		}

		var_08 = maps\_utility::get_dot(self.origin,self.angles,var_06.origin);
		if(var_08 < param_03)
		{
			continue;
		}

		param_02 = var_07;
		var_04 = var_06;
	}

	return var_04;
}

//Function Number: 160
jet_crash_move(param_00,param_01,param_02)
{
	self endon("in_air_explosion");
	param_00.claimed = 1;
	self notify("newpath");
	self notify("deathspin");
	if(!isdefined(param_01))
	{
		param_01 = 0;
	}

	if(!isdefined(param_02))
	{
		param_02 = 2400;
	}

	var_03 = self.origin[2] + param_02;
	var_04 = gettime();
	var_05 = var_04 + param_01 * 1000;
	while(isdefined(self) && var_04 < var_05 && self.origin[2] < var_03)
	{
		wait(0.05);
		var_04 = gettime();
	}

	var_06 = 700;
	self setneargoalnotifydist(param_00.radius);
	thread maps\_vehicle::vehicle_paths(param_00);
	self startpath(param_00);
	self vehicle_setspeed(var_06,50,50);
	common_scripts\utility::waittill_any("goal","near_goal");
	jet_crash_path(param_00);
	param_00.claimed = undefined;
	self notify("stop_crash_loop_sound");
	self notify("crash_done");
}

//Function Number: 161
jet_crash_path(param_00)
{
	self endon("death");
	while(isdefined(param_00.target))
	{
		param_00 = common_scripts\utility::getstruct(param_00.target,"targetname");
		var_01 = 512;
		if(isdefined(param_00.radius))
		{
			var_01 = param_00.radius;
		}

		var_02 = self vehicle_getspeed();
		if(isdefined(param_00.script_parameters))
		{
			self vehicle_setspeed(param_00.script_parameters,50,60);
			var_02 = param_00.script_parameters;
		}

		self setneargoalnotifydist(var_01);
		thread maps\_vehicle::vehicle_paths(param_00);
		self startpath(param_00);
		common_scripts\utility::waittill_any("goal","near_goal");
	}
}