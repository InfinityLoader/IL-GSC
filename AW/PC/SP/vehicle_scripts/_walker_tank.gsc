/*******************************************************************
 * Decompiled By: Bog
 * Decompiled File: vehicle_scripts/_walker_tank.gsc
 * Game: Call of Duty: Advanced Warfare
 * Platform: PC
 * Function Count: 23
 * Decompile Time: 281 ms
 * Timestamp: 10/27/2023 2:06:46 AM
*******************************************************************/

//Function Number: 1
main(param_00,param_01,param_02)
{
	maps\_vehicle::build_template("walker_tank",param_00,param_01,param_02);
	maps\_vehicle::build_localinit(::init_local);
	maps\_vehicle::build_shoot_shock("tankblast_walker");
	maps\_vehicle::build_treadfx();
	maps\_vehicle::build_life(999,500,1500);
	maps\_vehicle::build_team("axis");
	precacheturret("enemy_walker_top_left_turret");
	precachemodel("vehicle_walker_tank_dstrypv");
	maps\_vehicle::build_bulletshield(1);
	maps\_vehicle::build_grenadeshield(1);
	maps\_vehicle::build_turret("enemy_walker_belly_turret","TAG_TURRET_BELLY","vehicle_walker_tank_turret_belly",undefined,undefined,undefined,0,0,undefined);
	maps\_vehicle::build_turret("enemy_walker_top_left_turret","TAG_TURRET_TOP_LEFT","vehicle_walker_tank_turret_top_left",undefined,undefined,undefined,0,0,undefined);
	maps\_vehicle::build_turret("enemy_walker_top_right_turret","TAG_TURRET_TOP_RIGHT","vehicle_walker_tank_turret_top_right",undefined,undefined,undefined,0,0,undefined);
	maps\_vehicle::build_missile_launcher("enemy_walker_left_launcher","launcher_left","projectile_rpg7","rpg_guided",::launchers_rotate_up,::launchers_rotate_down);
	maps\_vehicle::build_missile_launcher("enemy_walker_right_launcher","launcher_right","projectile_rpg7","rpg_guided",::launchers_rotate_up,::launchers_rotate_down);
	if(param_02 == "script_vehicle_walker_tank_generic")
	{
		maps\_vehicle::build_deathmodel(param_00,"vehicle_walker_tank_dstrypv",undefined,param_02);
		maps\_vehicle::build_deathfx("vfx/explosion/vehicle_walker_tank_explosion","TAG_DEATH_FX","exp_armor_vehicle");
	}

	setdvar("walker_tank_debug",0);
}

//Function Number: 2
init_local()
{
	self useanimtree(#animtree);
	handle_vehicle_ai();
	self.shock_distance = 1500;
	self.black_distance = 1500;
	if(self.script_team == "allies")
	{
		self.shock_distance = 500;
	}

	self.missile_target_onscreen_guys_first = 1;
	thread death_cleanup();
}

//Function Number: 3
handle_vehicle_ai()
{
	thread vehicle_scripts\_vehicle_turret_ai::vehicle_turret_settings_target(1.5);
	thread vehicle_scripts\_vehicle_turret_ai::vehicle_turret_settings_shoot(3,5,3,5);
	thread vehicle_scripts\_vehicle_turret_ai::vehicle_turret_default_ai();
	thread setup_mg_turrets();
	thread setup_missile_launchers();
}

//Function Number: 4
setup_missile_launchers()
{
	self.missiletags = [];
	self.missiletagsready = [];
	self.missiletags[0] = "tag_missile_1_L";
	self.missiletags[1] = "tag_missile_2_L";
	self.missiletags[2] = "tag_missile_3_L";
	self.missiletags[3] = "tag_missile_4_L";
	self.missiletags[4] = "tag_missile_5_L";
	self.missiletags[5] = "tag_missile_6_L";
	self.missiletags[6] = "tag_missile_7_L";
	self.missiletags[7] = "tag_missile_8_L";
	self.missiletags[8] = "tag_missile_9_L";
	self.missiletags[9] = "tag_missile_10_L";
	self.missiletags[10] = "tag_missile_1_R";
	self.missiletags[11] = "tag_missile_2_R";
	self.missiletags[12] = "tag_missile_3_R";
	self.missiletags[13] = "tag_missile_4_R";
	self.missiletags[14] = "tag_missile_5_R";
	self.missiletags[15] = "tag_missile_6_R";
	self.missiletags[16] = "tag_missile_7_R";
	self.missiletags[17] = "tag_missile_8_R";
	self.missiletags[18] = "tag_missile_9_R";
	self.missiletags[19] = "tag_missile_10_R";
	thread vehicle_scripts\_vehicle_missile_launcher_ai::reload_launchers();
}

//Function Number: 5
setup_mg_turrets()
{
	waittillframeend;
	waittillframeend;
	var_00 = 0;
	foreach(var_02 in self.mgturret)
	{
		var_02 thread walker_tank_turret_think(var_00);
		var_02 thread stop_firing_for_death_anim(self);
		var_00++;
	}
}

//Function Number: 6
set_forced_target(param_00,param_01)
{
	vehicle_scripts\_vehicle_multiweapon_util::set_forced_target(param_00,param_01);
}

//Function Number: 7
disable_firing(param_00)
{
	vehicle_scripts\_vehicle_multiweapon_util::disable_firing(param_00);
}

//Function Number: 8
enable_firing(param_00)
{
	vehicle_scripts\_vehicle_multiweapon_util::enable_firing(param_00);
}

//Function Number: 9
disable_tracking(param_00)
{
	vehicle_scripts\_vehicle_multiweapon_util::disable_tracking(param_00);
}

//Function Number: 10
enable_tracking(param_00)
{
	vehicle_scripts\_vehicle_multiweapon_util::enable_tracking(param_00);
}

//Function Number: 11
launchers_enable_threat_grenade_response()
{
	vehicle_scripts\_vehicle_multiweapon_util::set_threat_grenade_response(1,-2);
	vehicle_scripts\_vehicle_multiweapon_util::set_threat_grenade_response(1,-3);
}

//Function Number: 12
launchers_disable_threat_grenade_response()
{
	vehicle_scripts\_vehicle_multiweapon_util::set_threat_grenade_response(0,-2);
	vehicle_scripts\_vehicle_multiweapon_util::set_threat_grenade_response(0,-3);
}

//Function Number: 13
enable_threat_grenade_response(param_00)
{
	vehicle_scripts\_vehicle_multiweapon_util::set_threat_grenade_response(1,param_00);
}

//Function Number: 14
disable_threat_grenade_response(param_00)
{
	vehicle_scripts\_vehicle_multiweapon_util::set_threat_grenade_response(0,param_00);
}

//Function Number: 15
fire_missles_at_target_array(param_00,param_01)
{
	vehicle_scripts\_vehicle_missile_launcher_ai::fire_missles_at_target_array(param_00,param_01);
}

//Function Number: 16
walker_tank_turret_think(param_00)
{
	self endon("death");
	self endon("stop_vehicle_turret_ai");
	for(;;)
	{
		waittillframeend;
		if(isdefined(self.disable_target_tracking) && self.disable_target_tracking)
		{
			self.ai_target = undefined;
			wait 0.05;
			continue;
		}

		if(isdefined(self.ai_target_force))
		{
			if(!vehicle_scripts\_vehicle_turret_ai::is_valid_target(self.ai_target_force))
			{
				self.ai_target_force = undefined;
			}
			else
			{
				self.ai_target = self.ai_target_force;
			}
		}

		if(!isdefined(self.ai_target))
		{
			var_01 = common_scripts\utility::get_enemy_team(self.script_team);
			var_02 = getaiarray(var_01);
			if(isenemyteam(level.player.team,self.script_team))
			{
				var_02 = common_scripts\utility::array_add(var_02,level.player);
			}

			var_02 = sortbydistance(var_02,self.origin);
			var_03 = 0;
			for(var_04 = 0;var_04 < var_02.size;var_04++)
			{
				if(!isdefined(var_02[var_04].claimed_walker_turret_target))
				{
					self.ai_target = var_02[var_04];
					break;
				}
			}

			if(!isdefined(self.ai_target))
			{
				for(var_04 = 0;var_04 < var_02.size;var_04++)
				{
					self.ai_target = var_02[var_04];
					break;
				}
			}
		}

		if(isdefined(self.ai_target) && !isdefined(self.disable_firing) || !self.disable_firing)
		{
			increment_claimed_refcount(self.ai_target);
			fire_at_target_until_dead(self.ai_target);
			continue;
		}

		wait(1);
	}
}

//Function Number: 17
increment_claimed_refcount(param_00)
{
	if(!isdefined(param_00.claimed_walker_turret_target))
	{
		param_00.claimed_walker_turret_target = 1;
		return;
	}

	param_00.claimed_walker_turret_target++;
}

//Function Number: 18
decrement_claimed_refcount(param_00)
{
	if(!isdefined(param_00.claimed_walker_turret_target) || param_00.claimed_walker_turret_target == 0)
	{
		return;
	}

	if(param_00.claimed_walker_turret_target == 1)
	{
		param_00.claimed_walker_turret_target = undefined;
		return;
	}

	param_00.claimed_walker_turret_target--;
}

//Function Number: 19
fire_at_target_until_dead(param_00)
{
	self endon("death");
	self endon("stop_vehicle_turret_ai");
	self endon("mgturret_acquire_new_target");
	var_01 = 2;
	var_02 = 4;
	var_03 = randomfloatrange(var_01,var_02);
	var_04 = 2;
	var_05 = 5;
	var_06 = randomfloatrange(var_04,var_05);
	var_07 = 0;
	self setturretteam(self.script_team);
	self setmode("manual");
	self settargetentity(param_00);
	self turretfireenable();
	self startfiring();
	while(var_07 < var_03 && vehicle_scripts\_vehicle_turret_ai::is_valid_target(param_00))
	{
		var_07 = var_07 + 0.05;
		wait(0.05);
	}

	self stopfiring();
	self turretfiredisable();
	self cleartargetentity();
	if(vehicle_scripts\_vehicle_turret_ai::is_valid_target(param_00))
	{
		decrement_claimed_refcount(param_00);
	}

	wait(var_06);
	self notify("mgturret_acquire_new_target");
}

//Function Number: 20
launchers_rotate_up()
{
	var_00 = 1;
	self setanimknoblimited(%walker_launcher_up_left_add,1,0,1);
	self setanimtime(%walker_launcher_up_left_add,1);
	self setanimknoblimited(%walker_launcher_up_right_add,1,0,1);
	self setanimtime(%walker_launcher_up_right_add,1);
	self setanimlimited(%walker_launcher_left_root,1,var_00,1);
	self setanimlimited(%walker_launcher_right_root,1,var_00,1);
	wait(var_00);
}

//Function Number: 21
launchers_rotate_down()
{
	var_00 = 1;
	self setanimknoblimited(%walker_launcher_up_left_add,1,0,1);
	self setanimtime(%walker_launcher_up_left_add,1);
	self setanimknoblimited(%walker_launcher_up_right_add,1,0,1);
	self setanimtime(%walker_launcher_up_right_add,1);
	self setanimlimited(%walker_launcher_left_root,0.01,var_00,1);
	self setanimlimited(%walker_launcher_right_root,0.01,var_00,1);
	wait(var_00);
}

//Function Number: 22
death_cleanup()
{
	self waittill("death");
	if(isdefined(self))
	{
		self detachall();
	}
}

//Function Number: 23
stop_firing_for_death_anim(param_00)
{
	param_00 waittill("stop_vehicle_turret_ai");
	self stopfiring();
	self turretfiredisable();
	self cleartargetentity();
}