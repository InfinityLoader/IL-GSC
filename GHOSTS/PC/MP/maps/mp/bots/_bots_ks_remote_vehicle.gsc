/*******************************************************************
 * Decompiled By: Bog
 * Decompiled File: maps\mp\bots\_bots_ks_remote_vehicle.gsc
 * Game: Call of Duty: Ghosts
 * Platform: PC
 * Function Count: 80
 * Decompile Time: 1609 ms
 * Timestamp: 10/27/2023 1:17:34 AM
*******************************************************************/

//Function Number: 1
func_64D4()
{
	while(!isdefined(level.bot_variables_initialized))
	{
		wait(0.05);
	}

	if(isdefined(level.bot_initialized_remote_vehicles))
	{
		return;
	}

	level.bot_ks_heli_offset["heli_pilot"] = (0,0,350);
	level.bot_ks_heli_offset["heli_sniper"] = (0,0,228);
	level.bot_ks_funcs["isUsing"]["odin_assault"] = ::maps\mp\_utility::func_4995;
	level.bot_ks_funcs["isUsing"]["odin_support"] = ::maps\mp\_utility::func_4995;
	level.bot_ks_funcs["isUsing"]["heli_pilot"] = ::maps\mp\_utility::func_4995;
	level.bot_ks_funcs["isUsing"]["heli_sniper"] = ::maps\mp\killstreaks\_killstreaks::func_4994;
	level.bot_ks_funcs["isUsing"]["switchblade_cluster"] = ::maps\mp\_utility::func_4995;
	level.bot_ks_funcs["isUsing"]["vanguard"] = ::func_4997;
	level.bot_ks_funcs["waittill_initial_goal"]["heli_pilot"] = ::heli_pilot_waittill_initial_goal;
	level.bot_ks_funcs["waittill_initial_goal"]["heli_sniper"] = ::heli_sniper_waittill_initial_goal;
	level.bot_ks_funcs["control_aiming"]["heli_pilot"] = ::func_40FD;
	level.bot_ks_funcs["control_aiming"]["heli_sniper"] = ::common_scripts\utility::empty_init_func;
	level.bot_ks_funcs["control_aiming"]["vanguard"] = ::func_8821;
	level.bot_ks_funcs["control_other"]["heli_pilot"] = ::heli_pilot_monitor_flares;
	level.bot_ks_funcs["heli_pick_node"]["heli_pilot"] = ::heli_pilot_pick_node;
	level.bot_ks_funcs["heli_pick_node"]["heli_sniper"] = ::func_410E;
	level.bot_ks_funcs["heli_pick_node"]["vanguard"] = ::vanguard_pick_node;
	level.bot_ks_funcs["heli_node_get_origin"]["heli_pilot"] = ::heli_get_node_origin;
	level.bot_ks_funcs["heli_node_get_origin"]["heli_sniper"] = ::heli_get_node_origin;
	level.bot_ks_funcs["heli_node_get_origin"]["vanguard"] = ::func_8826;
	level.bot_ks_funcs["odin_perform_action"]["odin_assault"] = ::odin_assault_perform_action;
	level.bot_ks_funcs["odin_perform_action"]["odin_support"] = ::func_583A;
	level.bot_ks_funcs["odin_get_target"]["odin_assault"] = ::func_57FC;
	level.bot_ks_funcs["odin_get_target"]["odin_support"] = ::func_5839;
	var_00 = common_scripts\utility::func_3C1A("so_chopper_boss_path_struct","script_noteworthy");
	level.bot_heli_nodes = [];
	foreach(var_02 in var_00)
	{
		if(isdefined(var_02.script_linkname))
		{
			level.bot_heli_nodes = common_scripts\utility::array_add(level.bot_heli_nodes,var_02);
		}
	}

	level.bot_heli_pilot_traceoffset = maps\mp\_utility::func_3AC9();
	foreach(var_05 in level.bot_heli_nodes)
	{
		var_05.vanguard_origin = var_05.origin;
		var_06 = var_05.origin + (0,0,50);
		var_05.valid_for_vanguard = 1;
		while(!func_59F0(var_06) && var_06[2] > var_05.origin[2] - 1000)
		{
			var_06 = var_06 - (0,0,25);
		}

		if(var_06[2] <= var_05.origin[2] - 1000)
		{
			var_05.valid_for_vanguard = 0;
		}

		var_06 = var_06 - (0,0,50);
		var_05.vanguard_origin = var_06;
	}

	var_08 = -99999999;
	foreach(var_05 in level.bot_heli_nodes)
	{
		var_08 = max(var_08,var_05.origin[2]);
	}

	level.bot_vanguard_height_trace_size = var_08 - level.bot_map_min_z + 100;
	level.odin_large_rod_radius = getweaponexplosionradius("odin_projectile_large_rod_mp");
	level.odin_small_rod_radius = getweaponexplosionradius("odin_projectile_small_rod_mp");
	level.vanguard_missile_radius = getweaponexplosionradius("remote_tank_projectile_mp");
	level.heli_pilot_missile_radius = getdvarfloat("bg_bulletExplRadius");
	while(!isdefined(level.odin_marking_flash_radius_max) || !isdefined(level.odin_marking_flash_radius_min))
	{
		wait(0.05);
	}

	level.odin_flash_radius = level.odin_marking_flash_radius_max + level.odin_marking_flash_radius_min / 2;
	level.outside_zones = [];
	if(isdefined(level.teleportgetactivepathnodezonesfunc))
	{
		var_0B = [[ level.teleportgetactivepathnodezonesfunc ]]();
	}
	else
	{
		var_0B = [];
		for(var_0C = 0;var_0C < level.zonecount;var_0C++)
		{
			var_0B[var_0B.size] = var_0C;
		}
	}

	foreach(var_0E in var_0B)
	{
		if(botzonegetindoorpercent(var_0E) < 0.25)
		{
			level.outside_zones = common_scripts\utility::array_add(level.outside_zones,var_0E);
		}
	}

	level.bot_odin_time_to_move["recruit"] = 1;
	level.bot_odin_time_to_move["regular"] = 0.7;
	level.bot_odin_time_to_move["hardened"] = 0.4;
	level.bot_odin_time_to_move["veteran"] = 0.05;
	level.bot_initialized_remote_vehicles = 1;
}

//Function Number: 2
bot_killstreak_remote_control(param_00,param_01,param_02,param_03,param_04)
{
	if(!isdefined(param_03))
	{
		return 0;
	}

	var_05 = 1;
	var_06 = 1;
	var_07 = undefined;
	if(isdefined(self.node_ambushing_from))
	{
		var_08 = self botgetscriptgoalradius();
		var_09 = distancesquared(self.origin,self.node_ambushing_from.origin);
		if(var_09 < squared(var_08))
		{
			var_05 = 0;
			var_06 = 0;
		}
		else if(var_09 < squared(200))
		{
			var_05 = 0;
		}
	}

	var_0A = param_00.streakname == "vanguard" && is_indoor_map();
	if(var_0A || var_05)
	{
		var_0B = getnodesinradius(self.origin,500,0,512);
		if(isdefined(var_0B) && var_0B.size > 0)
		{
			if(isdefined(param_04) && param_04)
			{
				var_0C = var_0B;
				var_0B = [];
				foreach(var_0E in var_0C)
				{
					if(nodeexposedtosky(var_0E))
					{
						var_0F = getlinkednodes(var_0E);
						var_10 = 0;
						foreach(var_12 in var_0F)
						{
							if(nodeexposedtosky(var_12))
							{
								var_10++;
							}
						}

						if(var_10 / var_0F.size > 0.5)
						{
							var_0B = common_scripts\utility::array_add(var_0B,var_0E);
						}
					}
				}
			}

			if(var_0A)
			{
				var_15 = self botnodescoremultiple(var_0B,"node_exposed");
				foreach(var_0E in var_15)
				{
					if(bullettracepassed(var_0E.origin + (0,0,30),var_0E.origin + (0,0,400),0,self))
					{
						var_07 = var_0E;
						break;
					}

					wait(0.05);
				}
			}
			else if(var_0B.size > 0)
			{
				var_07 = self botnodepick(var_0B,min(3,var_0B.size),"node_hide");
			}

			if(!isdefined(var_07))
			{
				return 0;
			}

			self botsetscriptgoalnode(var_07,"tactical");
		}
	}

	if(var_06)
	{
		var_18 = maps/mp/bots/_bots_util::bot_waittill_goal_or_fail();
		if(var_18 != "goal")
		{
			func_83E3(var_07);
			return 1;
		}
	}

	if(isdefined(param_02) && !self [[ param_02 ]]())
	{
		func_83E3(var_07);
		return 0;
	}

	if(!maps/mp/bots/_bots_util::bot_allowed_to_use_killstreaks())
	{
		func_83E3(var_07);
		return 1;
	}

	if(!isdefined(var_07))
	{
		if(self getstance() == "prone")
		{
			self botsetstance("prone");
		}
		else if(self getstance() == "crouch")
		{
			self botsetstance("crouch");
		}
	}
	else if(self botgetdifficultysetting("strategyLevel") > 0)
	{
		if(randomint(100) > 50)
		{
			self botsetstance("prone");
		}
		else
		{
			self botsetstance("crouch");
		}
	}

	maps/mp/bots/_bots_ks::bot_switch_to_killstreak_weapon(param_00,param_01,param_00.weapon);
	self.vehicle_controlling = undefined;
	self thread [[ param_03 ]]();
	thread bot_end_control_on_respawn();
	thread bot_end_control_watcher(var_07);
	self waittill("control_func_done");
	return 1;
}

//Function Number: 3
bot_end_control_on_respawn()
{
	self endon("disconnect");
	self endon("control_func_done");
	level endon("game_ended");
	self waittill("spawned_player");
	self notify("control_func_done");
}

//Function Number: 4
bot_end_control_watcher(param_00)
{
	self endon("disconnect");
	self waittill("control_func_done");
	func_83E3(param_00);
	self botsetstance("none");
	self botsetscriptmove(0,0);
	self botsetflag("disable_movement",0);
	self botsetflag("disable_rotation",0);
	self.vehicle_controlling = undefined;
}

//Function Number: 5
func_83E3(param_00)
{
	if(isdefined(param_00) && self bothasscriptgoal() && isdefined(self botgetscriptgoalnode()) && self botgetscriptgoalnode() == param_00)
	{
		self botclearscriptgoal();
	}
}

//Function Number: 6
bot_end_control_on_vehicle_death(param_00)
{
	param_00 waittill("death");
	self notify("control_func_done");
}

//Function Number: 7
bot_waittill_using_vehicle(param_00)
{
	var_01 = gettime();
	while(!self [[ level.bot_ks_funcs["isUsing"][param_00] ]]())
	{
		wait(0.05);
		if(gettime() - var_01 > 5000)
		{
			return 0;
		}
	}

	return 1;
}

//Function Number: 8
func_159C()
{
	self endon("spawned_player");
	self endon("disconnect");
	self endon("control_func_done");
	level endon("game_ended");
	childthread func_3ECA();
	var_00 = bot_waittill_using_vehicle("switchblade_cluster");
	if(!var_00)
	{
		self notify("control_func_done");
	}

	thread func_7E1A();
	var_01 = func_3263(self);
	wait(0.1);
	self.oldmaxsightdistsqrd = self.maxsightdistsqrd;
	self.maxsightdistsqrd = 256000000;
	thread func_8C69();
	var_02 = undefined;
	var_03 = 0;
	var_04 = 0;
	var_05 = [];
	var_06 = undefined;
	var_07 = 0;
	var_08 = 0;
	var_09 = undefined;
	var_0A = undefined;
	var_0B = 0;
	var_0C = is_indoor_map();
	while(self [[ level.bot_ks_funcs["isUsing"]["switchblade_cluster"] ]]() && isdefined(var_01))
	{
		foreach(var_0E in level.rockets)
		{
			if(isdefined(var_0E) && var_0E.owner == self && var_0E.weapon_name == "switch_blade_child_mp")
			{
				var_0F = 1;
				foreach(var_11 in var_05)
				{
					if(var_11.rocket == var_0E)
					{
						var_0F = 0;
					}
				}

				if(var_0F)
				{
					var_13 = spawnstruct();
					var_13.rocket = var_0E;
					var_13.target = var_06;
					var_06 = undefined;
					var_05 = common_scripts\utility::array_add(var_05,var_13);
				}
			}
		}

		for(var_15 = 0;var_15 < var_05.size;var_15++)
		{
			var_11 = var_05[var_15];
			if(isdefined(var_11) && isdefined(var_11.rocket) && !common_scripts\utility::array_contains(level.rockets,var_11.rocket))
			{
				var_05[var_15] = var_05[var_05.size - 1];
				var_05[var_05.size - 1] = undefined;
				var_15--;
			}
		}

		if(var_0B)
		{
			wait(0.05);
			continue;
		}

		var_16 = undefined;
		if(isdefined(var_0A))
		{
			var_16 = var_0A;
			if(!isalive(var_0A) || !self botcanseeentity(var_16))
			{
				if(!isalive(var_0A))
				{
					var_0B = 1;
				}

				wait(0.05);
				continue;
			}
		}

		var_17 = [];
		if(!isdefined(var_16))
		{
			var_18 = bot_killstreak_get_all_outside_enemies(0);
			var_19 = [];
			foreach(var_11 in var_05)
			{
				if(isdefined(var_11.target))
				{
					var_19 = common_scripts\utility::array_add(var_19,var_11.target);
				}
			}

			var_18 = common_scripts\utility::array_remove_array(var_18,var_19);
			foreach(var_1D in var_18)
			{
				if(var_1D maps\mp\_utility::_hasperk("specialty_noplayertarget"))
				{
					continue;
				}

				if(self botcanseeentity(var_1D) || var_0C && common_scripts\utility::func_8E18(self geteye(),var_01.angles,var_1D.origin,self botgetfovdot()))
				{
					if(!bot_body_is_dead() && distancesquared(var_1D.origin,self.origin) < -25536)
					{
						continue;
					}

					var_17 = common_scripts\utility::array_add(var_17,var_1D);
					if(!isdefined(var_16))
					{
						var_16 = var_1D;
						continue;
					}

					var_1E = vectornormalize(var_16.origin - var_01.origin);
					var_1F = vectornormalize(var_1D.origin - var_01.origin);
					var_20 = anglestoforward(var_01.angles);
					var_21 = vectordot(var_1E,var_20);
					var_22 = vectordot(var_1F,var_20);
					if(var_22 > var_21)
					{
						var_16 = var_1D;
					}
				}
			}
		}

		if(isdefined(var_16))
		{
			var_02 = undefined;
			var_24 = var_01.origin[2] - var_16.origin[2];
			var_25 = self botgetdifficulty();
			if(var_25 == "recruit")
			{
				var_09 = var_16.origin;
			}
			else if(var_24 < 5000)
			{
				var_09 = var_16.origin;
			}
			else if(length(var_16 getentityvelocity()) < 25)
			{
				var_09 = var_16.origin;
			}
			else if(gettime() - var_08 > 500)
			{
				var_08 = gettime();
				var_26 = 3;
				if(var_25 == "regular")
				{
					var_26 = 1;
				}

				var_09 = getpredictedentityposition(var_16,var_26);
			}

			var_27 = func_529A(var_01,var_09);
			var_28 = func_529B(var_01,var_09);
			if(var_28 < 30)
			{
				var_29 = 0;
			}
			else if(var_29 < 100)
			{
				var_29 = 0.15;
			}
			else if(var_29 < 200)
			{
				var_29 = 0.3;
			}
			else if(var_29 < 400)
			{
				var_29 = 0.6;
			}
			else
			{
				var_29 = 1;
			}

			if(var_07)
			{
				var_29 = min(var_29 * 3,1);
			}

			if(var_29 > 0)
			{
				self botsetscriptmove(var_27[1],0.05,var_29,1,1);
			}
			else if(gettime() > var_04)
			{
				if(var_03 < 2)
				{
					self botpressbutton("attack");
					var_03++;
					var_04 = gettime() + 200;
					if((var_25 == "regular" && var_03 == 2) || var_25 == "hardened" || var_25 == "veteran")
					{
						var_2A = var_03 == 1 && var_17.size == 1;
						if(!var_2A)
						{
							var_06 = var_16;
							var_04 = var_04 + 800;
						}
					}
				}
				else if(!var_07 && var_24 < 5000 || var_25 == "recruit")
				{
					var_07 = 1;
					self botpressbutton("attack");
					if(var_25 == "recruit")
					{
						var_0A = var_16;
					}
				}
			}

			continue;
		}

		if(!isdefined(var_02))
		{
			var_02 = common_scripts\utility::func_6306(level.outside_zones);
		}

		var_2B = getzonenodeforindex(var_02).origin;
		if(func_529B(var_01,var_2B) < 200)
		{
			var_02 = common_scripts\utility::func_6306(level.outside_zones);
			var_2B = getzonenodeforindex(var_02).origin;
		}

		var_27 = func_529A(var_01,var_2B);
		self botsetscriptmove(var_27[1],0.05,0.75,1,1);
		wait(0.05);
	}

	self notify("control_func_done");
}

//Function Number: 9
func_529A(param_00,param_01)
{
	var_02 = missile_find_ground_target(param_00,param_01[2]);
	var_03 = vectornormalize(param_01 - var_02);
	return vectortoangles(var_03);
}

//Function Number: 10
func_529B(param_00,param_01)
{
	var_02 = missile_find_ground_target(param_00,param_01[2]);
	return distance(var_02,param_01);
}

//Function Number: 11
func_3ECA()
{
	self botsetflag("disable_rotation",1);
	self botsetflag("disable_movement",1);
	func_3263(self);
	self botsetflag("disable_rotation",0);
	self botsetflag("disable_movement",0);
}

//Function Number: 12
func_7E1A()
{
	self endon("disconnect");
	self botsetawareness(2.5);
	self waittill("control_func_done");
	self botsetawareness(1);
}

//Function Number: 13
missile_find_ground_target(param_00,param_01)
{
	var_02 = anglestoforward(param_00.angles);
	var_03 = param_01 - param_00.origin[2] / var_02[2];
	var_04 = param_00.origin + var_02 * var_03;
	return var_04;
}

//Function Number: 14
func_8C69()
{
	self endon("disconnect");
	self waittill("control_func_done");
	self.maxsightdistsqrd = self.oldmaxsightdistsqrd;
}

//Function Number: 15
func_3263(param_00)
{
	for(;;)
	{
		foreach(var_02 in level.rockets)
		{
			if(isdefined(var_02) && var_02.owner == param_00)
			{
				return var_02;
			}
		}

		wait(0.05);
	}
}

//Function Number: 16
func_881F()
{
	if(!maps/mp/bots/_bots_ks::aerial_vehicle_allowed())
	{
		return 0;
	}

	if(maps\mp\killstreaks\_vanguard::func_3043(self.team) || level.littlebirds.size >= 4)
	{
		return 0;
	}

	if(maps/mp/bots/_bots_ks::iskillstreakblockedforbots("vanguard"))
	{
		return 0;
	}

	return 1;
}

//Function Number: 17
func_1618(param_00,param_01,param_02,param_03)
{
	bot_killstreak_remote_control(param_00,param_01,param_02,param_03,1);
}

//Function Number: 18
func_4997()
{
	return maps\mp\_utility::func_4995() && self.usingremote == "vanguard" && isdefined(self.remoteuav);
}

//Function Number: 19
bot_control_vanguard()
{
	self endon("spawned_player");
	self endon("disconnect");
	self endon("control_func_done");
	level endon("game_ended");
	var_00 = bot_waittill_using_vehicle("vanguard");
	if(!var_00)
	{
		self notify("control_func_done");
	}

	self.vehicle_controlling = self.remoteuav;
	childthread bot_end_control_on_vehicle_death(self.vehicle_controlling);
	self.vehicle_controlling endon("death");
	wait(0.5);
	var_01 = 0;
	var_02 = !self.vehicle_controlling func_8829();
	var_03 = undefined;
	var_04 = 0;
	var_05 = is_indoor_map();
	while(var_02 && !var_05)
	{
		var_06 = getnodesinradiussorted(self.vehicle_controlling.origin,1024,64,512,"path");
		if(isdefined(var_03))
		{
			var_06 = common_scripts\utility::array_remove(var_06,var_03);
		}

		foreach(var_08 in var_06)
		{
			if(node_is_valid_outside_for_vanguard(var_08))
			{
				var_03 = var_08;
				break;
			}

			wait(0.05);
			var_01 = var_01 + 0.05;
		}

		if(var_01 < 1)
		{
			wait(1 - var_01);
		}

		if(!isdefined(var_03))
		{
			self botpressbutton("use",4);
			wait(4);
		}

		var_0A = maps/mp/bots/_bots_util::bot_queued_process("GetNodesOnPathVanguard",::maps/mp/bots/_bots_util::func_get_nodes_on_path,self.vehicle_controlling.origin,var_03.origin);
		if(!isdefined(var_0A))
		{
			if(var_04 == 0)
			{
				var_04++;
				wait(0.05);
				continue;
			}
			else
			{
				self botpressbutton("use",4);
				wait(4);
			}
		}

		for(var_0B = 0;var_0B < var_0A.size;var_0B++)
		{
			var_0C = var_0A[var_0B];
			if(var_0B == 0 && distancesquared(self.origin,var_0C.origin) < 1600)
			{
				continue;
			}

			var_0D = 32;
			if(var_0B == var_0A.size - 1)
			{
				var_0D = 16;
			}

			var_0E = self.vehicle_controlling.origin;
			var_0F = gettime() + 2500;
			while(distance2dsquared(var_0C.origin,self.vehicle_controlling.origin) > var_0D * var_0D)
			{
				if(self.vehicle_controlling func_8829())
				{
					var_0B = var_0A.size;
					break;
				}

				if(gettime() > var_0F)
				{
					var_0F = gettime() + 2500;
					var_10 = distancesquared(self.vehicle_controlling.origin,var_0E);
					if(var_10 < 1)
					{
						var_0B++;
						break;
					}

					var_0E = self.vehicle_controlling.origin;
				}

				var_11 = vectornormalize(var_0C.origin - self.vehicle_controlling.origin);
				self botsetscriptmove(vectortoangles(var_11)[1],0.2);
				self botlookatpoint(var_0C.origin,0.2,"script_forced");
				var_12 = var_0C.origin[2] + 64;
				var_13 = var_12 - self.vehicle_controlling.origin[2];
				if(var_13 > 10)
				{
					self botpressbutton("lethal");
					continue;
				}

				if(var_13 < -10)
				{
					self botpressbutton("tactical");
				}

				wait(0.05);
			}
		}

		var_02 = 0;
		if(!self.vehicle_controlling func_8829())
		{
			var_02 = 1;
		}
	}

	self botsetscriptmove(0,0);
	self botlookatpoint(undefined);
	self childthread [[ level.bot_ks_funcs["control_aiming"]["vanguard"] ]]();
	var_15 = self.vehicle_controlling.origin[2];
	var_16 = undefined;
	var_17 = gettime() + 2000;
	var_18 = [];
	var_18[0] = (1,0,0);
	var_18[1] = (-1,0,0);
	var_18[2] = (0,1,0);
	var_18[3] = (0,-1,0);
	var_18[4] = (1,1,0);
	var_18[5] = (1,-1,0);
	var_18[6] = (-1,1,0);
	var_18[7] = (-1,-1,0);
	var_19 = func_3261(self.vehicle_controlling.origin,"vanguard");
	while(var_19.vanguard_origin[2] - self.vehicle_controlling.origin[2] > 20)
	{
		if(!self.vehicle_controlling maps\mp\killstreaks\_vanguard::func_8828())
		{
			break;
		}

		if(gettime() > var_17)
		{
			var_17 = gettime() + 2000;
			if(isdefined(var_16))
			{
				var_16 = undefined;
			}
			else
			{
				var_13 = self.vehicle_controlling.origin[2] - var_15;
				if(var_13 < 20 && !var_05)
				{
					var_1A = common_scripts\utility::array_randomize(var_18);
					foreach(var_1C in var_1A)
					{
						if(func_60AF(self.vehicle_controlling.origin + var_1C * 64))
						{
							if(!bullettracepassed(self.vehicle_controlling.origin,self.vehicle_controlling.origin + var_1C * 64,0,self.vehicle_controlling))
							{
								wait(0.05);
								continue;
							}

							var_16 = var_1C;
							break;
						}

						wait(0.05);
					}
				}
			}

			var_15 = self.vehicle_controlling.origin[2];
		}

		if(isdefined(var_16))
		{
			self botsetscriptmove(vectortoangles(var_16)[1],0.05);
			if(common_scripts\utility::func_1DE9())
			{
				self botpressbutton("tactical");
			}

			continue;
		}

		self botpressbutton("lethal");
		wait(0.05);
	}

	wait(1);
	while(!self.vehicle_controlling maps\mp\killstreaks\_vanguard::func_8828())
	{
		self botpressbutton("tactical");
		wait(0.1);
	}

	wait(1);
	self botsetflag("disable_movement",0);
	bot_control_heli_main_move_loop("vanguard",0);
	self notify("control_func_done");
}

//Function Number: 20
func_60AD(param_00)
{
	var_01 = getclosestnodeinsight(param_00);
	if(isdefined(var_01))
	{
		return node_is_valid_outside_for_vanguard(var_01);
	}

	return 0;
}

//Function Number: 21
node_is_valid_outside_for_vanguard(param_00)
{
	if(nodeexposedtosky(param_00))
	{
		return func_60AF(param_00.origin);
	}

	return 0;
}

//Function Number: 22
func_60AF(param_00)
{
	var_01 = param_00;
	for(var_02 = param_00 + (0,0,level.bot_vanguard_height_trace_size);!func_59F0(var_02) && var_02[2] > var_01[2];var_02 = var_02 - (0,0,50))
	{
	}

	if(var_02[2] <= var_01[2])
	{
		return 0;
	}

	var_03 = bullettracepassed(var_01,var_02,0,undefined);
	return var_03;
}

//Function Number: 23
func_8829()
{
	var_00 = getclosestnodeinsight(self.origin);
	if(isdefined(var_00) && !nodeexposedtosky(var_00))
	{
		return 0;
	}

	wait(0.05);
	if(!func_60AF(self.origin + (18,0,25)))
	{
		return 0;
	}

	wait(0.05);
	if(!func_60AF(self.origin + (-18,0,25)))
	{
		return 0;
	}

	wait(0.05);
	if(!func_60AF(self.origin + (0,18,25)))
	{
		return 0;
	}

	wait(0.05);
	if(!func_60AF(self.origin + (0,-18,25)))
	{
		return 0;
	}

	return 1;
}

//Function Number: 24
func_8821()
{
	self notify("vanguard_control_aiming");
	self endon("vanguard_control_aiming");
	var_00 = undefined;
	var_01 = 0;
	var_02 = gettime();
	var_03 = 0;
	var_04 = undefined;
	var_05 = 0;
	while(self [[ level.bot_ks_funcs["isUsing"]["vanguard"] ]]())
	{
		var_06 = undefined;
		var_07 = self geteye();
		var_08 = self getplayerangles();
		var_09 = self botgetfovdot();
		if(isalive(self.enemy) && self botcanseeentity(self.enemy))
		{
			var_0A = 1;
			var_06 = self.enemy;
			var_05 = 0;
		}
		else if(var_05 < 10)
		{
			foreach(var_0C in level.characters)
			{
				if(var_0C == self || !isalive(var_0C))
				{
					continue;
				}

				if(var_0C maps\mp\_utility::_hasperk("specialty_noplayertarget"))
				{
					continue;
				}

				if(!isdefined(var_0C.team))
				{
					continue;
				}

				if(!level.teambased || self.team != var_0C.team)
				{
					if(common_scripts\utility::func_8E18(var_07,var_08,var_0C.origin,var_09))
					{
						var_05 = var_05 + 0.05;
						if(isdefined(var_06))
						{
							var_0D = distancesquared(self.vehicle_controlling.origin,var_06.origin);
							var_0E = distancesquared(self.vehicle_controlling.origin,var_0C.origin);
							if(var_0E < var_0D)
							{
								var_06 = var_0C;
							}

							continue;
						}

						var_06 = var_0C;
					}
				}
			}
		}

		if(isdefined(var_06))
		{
			if((isai(var_06) || isplayer(var_06)) && length(var_06 getentityvelocity()) < 25)
			{
				var_00 = var_06.origin;
			}
			else if(gettime() - var_03 < 500)
			{
				if(var_04 != var_06)
				{
					var_00 = var_06.origin;
				}
			}
			else if(gettime() - var_03 > 500)
			{
				var_03 = gettime();
				var_00 = getpredictedentityposition(var_06,3);
				var_04 = var_06;
			}

			var_10 = 165;
			if(gettime() - var_02 > 10000)
			{
				var_10 = 200;
			}

			if(distancesquared(self.vehicle_controlling.attackarrow.origin,var_00) < level.vanguard_missile_radius * level.vanguard_missile_radius)
			{
				if(bot_body_is_dead() || distancesquared(self.vehicle_controlling.attackarrow.origin,self.origin) > level.vanguard_missile_radius * level.vanguard_missile_radius)
				{
					var_02 = gettime();
					self botpressbutton("attack");
				}
			}
		}
		else if(gettime() > var_01)
		{
			var_01 = gettime() + randomintrange(1000,2000);
			var_00 = func_3976();
			self.next_goal_time = gettime();
		}

		if(length(var_00) == 0)
		{
			var_00 = (0,0,10);
		}

		self botlookatpoint(var_00,0.2,"script_forced");
		wait(0.05);
	}
}

//Function Number: 25
vanguard_pick_node(param_00)
{
	param_00.bot_visited_times[self.entity_number]++;
	var_01 = [[ level.bot_ks_funcs["heli_node_get_origin"]["vanguard"] ]](param_00);
	var_02 = bot_vanguard_find_unvisited_nodes(param_00);
	var_03 = var_02;
	var_02 = [];
	foreach(var_05 in var_03)
	{
		if(var_05.valid_for_vanguard)
		{
			if(param_00.origin[2] != param_00.vanguard_origin[2] || var_05.origin[2] != var_05.vanguard_origin[2])
			{
				var_06 = [[ level.bot_ks_funcs["heli_node_get_origin"]["vanguard"] ]](var_05);
				var_07 = playerphysicstrace(var_01,var_06);
				if(distancesquared(var_07,var_06) < 1)
				{
					var_02 = common_scripts\utility::array_add(var_02,var_05);
				}

				wait(0.05);
				continue;
			}

			var_02 = common_scripts\utility::array_add(var_02,var_05);
		}
	}

	if(var_02.size == 0 && var_03.size > 0)
	{
		foreach(var_05 in var_03)
		{
			var_05.bot_visited_times[self.entity_number]++;
		}
	}

	return func_40FA(var_02,"vanguard");
}

//Function Number: 26
bot_vanguard_find_unvisited_nodes(param_00)
{
	var_01 = 99;
	var_02 = [];
	foreach(var_04 in param_00.neighbors)
	{
		if(isdefined(var_04.script_linkname) && var_04.valid_for_vanguard)
		{
			var_05 = var_04.bot_visited_times[self.entity_number];
			if(var_05 < var_01)
			{
				var_02 = [];
				var_02[0] = var_04;
				var_01 = var_05;
			}
			else if(var_05 == var_01)
			{
				var_02[var_02.size] = var_04;
			}
		}
	}

	return var_02;
}

//Function Number: 27
func_8826(param_00)
{
	return param_00.vanguard_origin;
}

//Function Number: 28
func_59F0(param_00)
{
	var_01 = common_scripts\utility::func_7836();
	var_01.origin = param_00;
	var_02 = var_01 maps\mp\killstreaks\_vanguard::func_8828();
	var_01 delete();
	return var_02;
}

//Function Number: 29
func_410C()
{
	if(!maps/mp/bots/_bots_ks::aerial_vehicle_allowed())
	{
		return 0;
	}

	if(maps\mp\killstreaks\_helisniper::func_3040())
	{
		return 0;
	}

	return 1;
}

//Function Number: 30
heli_sniper_waittill_initial_goal()
{
	self.vehicle_controlling waittill("near_goal");
}

//Function Number: 31
bot_control_heli_sniper()
{
	thread func_410D();
	bot_control_heli("heli_sniper");
}

//Function Number: 32
func_410D()
{
	self endon("spawned_player");
	self endon("disconnect");
	self endon("control_func_done");
	level endon("game_ended");
	while(!maps\mp\killstreaks\_killstreaks::func_4994() && self islinked())
	{
		wait(0.05);
	}

	self botclearscriptgoal();
}

//Function Number: 33
func_410E(param_00)
{
	param_00.bot_visited_times[self.entity_number]++;
	var_01 = bot_heli_find_unvisited_nodes(param_00);
	return func_40FA(var_01,"heli_sniper");
}

//Function Number: 34
func_40FC()
{
	if(!maps/mp/bots/_bots_ks::aerial_vehicle_allowed())
	{
		return 0;
	}

	if(maps\mp\killstreaks\_helicopter_pilot::func_303F(self.team))
	{
		return 0;
	}

	return 1;
}

//Function Number: 35
heli_pilot_waittill_initial_goal()
{
	self.vehicle_controlling waittill("goal_reached");
}

//Function Number: 36
bot_control_heli_pilot()
{
	bot_control_heli("heli_pilot");
}

//Function Number: 37
heli_pilot_pick_node(param_00)
{
	param_00.bot_visited_times[self.entity_number]++;
	var_01 = bot_heli_find_unvisited_nodes(param_00);
	var_02 = common_scripts\utility::func_6306(var_01);
	return var_02;
}

//Function Number: 38
heli_pilot_monitor_flares()
{
	self notify("heli_pilot_monitor_flares");
	self endon("heli_pilot_monitor_flares");
	var_00 = [];
	while(self [[ level.bot_ks_funcs["isUsing"]["heli_pilot"] ]]())
	{
		self.vehicle_controlling waittill("targeted_by_incoming_missile",var_01);
		if(!maps\mp\killstreaks\_flares::func_33CD(self.vehicle_controlling))
		{
			break;
		}

		var_02 = 1;
		foreach(var_04 in var_01)
		{
			if(isdefined(var_04) && !common_scripts\utility::array_contains(var_00,var_04))
			{
				var_02 = 0;
			}
		}

		if(!var_02)
		{
			var_06 = clamp(0.34 * self botgetdifficultysetting("strategyLevel"),0,1);
			if(randomfloat(1) < var_06)
			{
				self notify("manual_flare_popped");
			}

			var_00 = common_scripts\utility::array_combine(var_00,var_01);
			var_00 = common_scripts\utility::array_removeundefined(var_00);
			wait(3);
		}
	}
}

//Function Number: 39
func_40FD()
{
	self notify("heli_pilot_control_heli_aiming");
	self endon("heli_pilot_control_heli_aiming");
	var_00 = undefined;
	var_01 = undefined;
	var_02 = undefined;
	var_03 = 0;
	var_04 = 0;
	var_05 = undefined;
	var_06 = self botgetdifficultysetting("minInaccuracy") + self botgetdifficultysetting("maxInaccuracy") / 2;
	var_07 = 0;
	while(self [[ level.bot_ks_funcs["isUsing"]["heli_pilot"] ]]())
	{
		var_08 = 0;
		var_09 = 0;
		if(isdefined(var_01) && var_01.health <= 0 && gettime() - var_01.deathtime < 2000)
		{
			var_08 = 1;
			var_09 = 1;
		}
		else if(isalive(self.enemy) && self botcanseeentity(self.enemy) || gettime() - self lastknowntime(self.enemy) <= 300)
		{
			var_08 = 1;
			var_01 = self.enemy;
			var_00 = self.enemy.origin;
			if(self botcanseeentity(self.enemy))
			{
				var_07 = 0;
				var_09 = 1;
				var_0A = gettime();
			}
			else
			{
				var_07 = var_07 + 0.05;
				if(var_07 > 5)
				{
					var_08 = 0;
				}
			}
		}

		if(var_08)
		{
			var_02 = var_00 - (0,0,50);
			if(var_09 && bot_body_is_dead() || distancesquared(var_02,self.origin) > level.heli_pilot_missile_radius * level.heli_pilot_missile_radius)
			{
				self botpressbutton("attack");
			}

			if(gettime() > var_04 + 500)
			{
				var_0B = randomfloatrange(-1 * var_06 / 2,var_06 / 2);
				var_0C = randomfloatrange(-1 * var_06 / 2,var_06 / 2);
				var_0D = randomfloatrange(-1 * var_06 / 2,var_06 / 2);
				var_05 = (150 * var_0B,150 * var_0C,150 * var_0D);
				var_04 = gettime();
			}

			var_02 = var_02 + var_05;
			var_0E = self.vehicle_controlling gettagorigin("tag_player");
			var_0F = vectornormalize(var_02 - var_0E);
			var_10 = anglestoforward(self getplayerangles());
			var_11 = vectordot(var_0F,var_10);
			if(var_11 > 0.5)
			{
				self botpressbutton("ads",0.1);
			}
		}
		else if(gettime() > var_03)
		{
			var_03 = gettime() + randomintrange(1000,2000);
			var_02 = func_3976();
			self.next_goal_time = gettime();
		}

		var_12 = var_02 - self.vehicle_controlling.origin;
		var_13 = length(var_12);
		var_14 = vectortoangles(var_12);
		var_15 = angleclamp(self.vehicle_controlling.angles[0]);
		var_16 = angleclamp(var_14[0]);
		var_17 = int(var_15 - var_16) % 360;
		if(var_17 > 180)
		{
			var_17 = 360 - var_17;
		}
		else if(var_17 < -180)
		{
			var_17 = -360 + var_17;
		}

		if(var_17 > 15)
		{
			var_16 = var_15 - 15;
		}
		else if(var_17 < -15)
		{
			var_16 = var_15 + 15;
		}

		var_14 = (var_16,var_14[1],var_14[2]);
		var_12 = anglestoforward(var_14);
		var_02 = self.vehicle_controlling.origin + var_12 * var_13;
		if(length(var_02) == 0)
		{
			var_02 = (0,0,10);
		}

		self botlookatpoint(var_02,0.2,"script_forced");
		wait(0.05);
	}
}

//Function Number: 40
func_159A()
{
	bot_control_odin("odin_assault");
}

//Function Number: 41
odin_assault_perform_action()
{
	if(bot_odin_try_spawn_juggernaut())
	{
		return 1;
	}

	if(bot_odin_try_rods())
	{
		return 1;
	}

	if(bot_odin_try_airdrop())
	{
		return 1;
	}

	return 0;
}

//Function Number: 42
func_57FC()
{
	return bot_odin_find_target_for_rods();
}

//Function Number: 43
bot_odin_find_target_for_rods()
{
	var_00 = undefined;
	if(isdefined(self.last_large_rod_target) && gettime() - self.last_large_rod_time < 5000)
	{
		var_00 = self.last_large_rod_target;
	}

	return bot_odin_get_closest_visible_outside_player("enemy",1,var_00);
}

//Function Number: 44
bot_odin_try_rods()
{
	var_00 = bot_odin_should_fire_rod_at_marker();
	if(var_00 == "large")
	{
		self notify("large_rod_action");
		return 1;
	}

	if(var_00 == "small")
	{
		self notify("small_rod_action");
		return 1;
	}

	return 0;
}

//Function Number: 45
bot_odin_should_fire_rod_at_marker()
{
	var_00 = gettime() >= self.odin.odin_largerodusetime;
	var_01 = gettime() >= self.odin.odin_smallrodusetime;
	if(var_00 || var_01)
	{
		var_02 = bot_odin_get_visible_outside_players("enemy",0);
		var_03 = [];
		var_04 = distancesquared(self.origin,self.odin.targeting_marker.origin);
		for(var_05 = 0;var_05 < var_02.size;var_05++)
		{
			var_06 = bot_odin_get_player_target_point(var_02[var_05]);
			var_03[var_05] = distancesquared(self.odin.targeting_marker.origin,var_06);
		}

		if(var_00)
		{
			if(!bot_body_is_dead() && var_04 < level.odin_large_rod_radius * level.odin_large_rod_radius)
			{
				return "none";
			}

			for(var_05 = 0;var_05 < var_02.size;var_05++)
			{
				if(var_03[var_05] < squared(level.odin_large_rod_radius))
				{
					self.last_large_rod_target = var_02[var_05];
					self.last_large_rod_time = gettime();
					return "large";
				}
			}
		}

		if(var_01)
		{
			if(!bot_body_is_dead() && var_04 < level.odin_small_rod_radius * level.odin_small_rod_radius)
			{
				return "none";
			}

			for(var_05 = 0;var_05 < var_02.size;var_05++)
			{
				if(var_03[var_05] < squared(level.odin_small_rod_radius))
				{
					if(isdefined(self.last_large_rod_target) && self.last_large_rod_target == var_02[var_05] && gettime() - self.last_large_rod_time < 5000)
					{
						continue;
					}

					return "small";
				}
			}
		}
	}

	return "none";
}

//Function Number: 46
func_159B()
{
	bot_control_odin("odin_support");
}

//Function Number: 47
func_583A()
{
	if(bot_odin_try_spawn_juggernaut())
	{
		return 1;
	}

	if(bot_odin_try_airdrop())
	{
		return 1;
	}

	if(bot_odin_try_smoke())
	{
		return 1;
	}

	if(bot_odin_try_flash())
	{
		return 1;
	}

	return 0;
}

//Function Number: 48
bot_odin_try_flash()
{
	if(bot_odin_should_fire_flash_at_marker())
	{
		self notify("marking_action");
		return 1;
	}

	return 0;
}

//Function Number: 49
bot_odin_should_fire_flash_at_marker()
{
	if(gettime() < self.odin.odin_markingusetime)
	{
		return 0;
	}

	var_00 = bot_odin_get_visible_outside_players("enemy",0);
	var_01 = [];
	for(var_02 = 0;var_02 < var_00.size;var_02++)
	{
		var_03 = bot_odin_get_player_target_point(var_00[var_02]);
		var_01[var_02] = distancesquared(self.odin.targeting_marker.origin,var_03);
		if(var_01[var_02] < squared(level.odin_flash_radius / 2))
		{
			return 1;
		}
	}

	return 0;
}

//Function Number: 50
bot_odin_try_smoke()
{
	if(func_1649())
	{
		self notify("smoke_action");
		return 1;
	}

	return 0;
}

//Function Number: 51
func_1649()
{
	if(gettime() < self.odin.odin_smokeusetime)
	{
		return 0;
	}

	var_00 = func_1644();
	foreach(var_02 in var_00)
	{
		if(distancesquared(var_02,self.odin.targeting_marker.origin) < 2500)
		{
			return 1;
		}
	}

	var_04 = undefined;
	if(isdefined(self.odin.targeting_marker.nearest_node))
	{
		var_04 = getnodezone(self.odin.targeting_marker.nearest_node);
	}

	if(!isdefined(var_04))
	{
		return 0;
	}

	var_05 = bot_killstreak_get_zone_enemies_outside(1);
	var_06 = var_05[var_04].size;
	if(var_06 >= 2)
	{
		return 1;
	}

	return 0;
}

//Function Number: 52
func_1644()
{
	var_00 = [];
	if(gettime() < self.odin.odin_smokeusetime)
	{
		return var_00;
	}

	foreach(var_05, var_02 in level.carepackages)
	{
		if(maps/mp/bots/_bots::func_2032(var_02))
		{
			var_00[0] = self;
			var_04 = common_scripts\utility::func_37D5(var_01.origin,level.players,var_05);
			if(var_04.size > 0 && var_04[0].team == self.team)
			{
				var_00 = common_scripts\utility::array_add(var_00,var_01.origin);
			}
		}
	}

	var_06 = bot_odin_get_visible_outside_players("ally",0);
	foreach(var_08 in var_06)
	{
		if(isai(var_08) && var_08 maps/mp/bots/_bots_util::bot_is_capturing())
		{
			var_00 = common_scripts\utility::array_add(var_00,var_08.origin);
		}
	}

	return var_00;
}

//Function Number: 53
func_5839()
{
	var_00 = func_1644();
	if(var_00.size > 0)
	{
		return var_00[0];
	}

	return bot_odin_get_closest_visible_outside_player("enemy",1);
}

//Function Number: 54
func_5352()
{
	for(;;)
	{
		self.odin.targeting_marker.nearest_node = getclosestnodeinsight(self.odin.targeting_marker.origin);
		if(maps/mp/bots/_bots_util::bot_point_is_on_pathgrid(self.odin.targeting_marker.origin,200))
		{
			self.odin.targeting_marker.nearest_point_on_pathgrid = self.odin.targeting_marker.origin;
		}
		else
		{
			self.odin.targeting_marker.nearest_point_on_pathgrid = undefined;
		}

		wait(0.25);
	}
}

//Function Number: 55
bot_control_odin(param_00)
{
	self endon("spawned_player");
	self endon("disconnect");
	self endon("control_func_done");
	level endon("game_ended");
	var_01 = bot_waittill_using_vehicle(param_00);
	if(!var_01)
	{
		self notify("control_func_done");
	}

	self.vehicle_controlling = self.odin;
	childthread bot_end_control_on_vehicle_death(self.odin);
	self.odin endon("death");
	wait(1.4);
	self botsetawareness(0.7);
	thread bot_end_odin_watcher();
	self.odin_predicted_loc_for_player = [];
	self.odin_predicted_loc_time_for_player = [];
	self.odin_last_predict_position_time = 0;
	var_02 = undefined;
	var_03 = 0;
	var_04 = undefined;
	childthread func_5352();
	var_05 = self.odin.targeting_marker.origin;
	var_06 = gettime();
	while(self [[ level.bot_ks_funcs["isUsing"][param_00] ]]())
	{
		var_07 = self [[ level.bot_ks_funcs["odin_perform_action"][param_00] ]]();
		if(gettime() > var_06 + 2000)
		{
			var_06 = gettime();
			var_08 = distance(var_05,self.odin.targeting_marker.origin);
			var_05 = self.odin.targeting_marker.origin;
			if(var_08 < 100)
			{
				var_04 = undefined;
				var_02 = undefined;
			}
		}

		if(gettime() > var_03 || !isdefined(var_04))
		{
			var_09 = level.bot_odin_time_to_move[self botgetdifficulty()];
			var_03 = gettime() + var_09 * 1000;
			var_0A = self [[ level.bot_ks_funcs["odin_get_target"][param_00] ]]();
			if(isdefined(var_0A))
			{
				var_02 = undefined;
				if(isplayer(var_0A))
				{
					var_04 = bot_odin_get_player_target_point(var_0A);
				}
				else
				{
					var_04 = var_0A;
				}
			}
			else
			{
				if(!isdefined(var_02))
				{
					var_02 = common_scripts\utility::func_6306(level.outside_zones);
				}

				var_0B = getzonenodeforindex(var_02).origin;
				if(distance2dsquared(self.odin.targeting_marker.origin,var_0B) < 10000)
				{
					var_02 = common_scripts\utility::func_6306(level.outside_zones);
					var_0B = getzonenodeforindex(var_02).origin;
					var_06 = gettime();
				}

				var_04 = var_0B;
			}
		}

		var_0C = var_04 - self.odin.targeting_marker.origin;
		if(lengthsquared(var_0C) > 100)
		{
			var_0D = vectortoangles(var_0C);
			self botsetscriptmove(var_0D[1],0.05);
			self botlookatpoint(var_04,0.1,"script_forced");
			continue;
		}

		var_06 = gettime();
		wait(0.05);
	}

	self notify("control_func_done");
}

//Function Number: 56
bot_end_odin_watcher(param_00)
{
	self endon("disconnect");
	self waittill("control_func_done");
	self.odin_predicted_loc_for_player = undefined;
	self.odin_predicted_loc_time_for_player = undefined;
	self.odin_last_predict_position_time = undefined;
	self botsetawareness(1);
}

//Function Number: 57
bot_odin_get_player_target_point(param_00)
{
	if(level.teambased && self.team == param_00.team)
	{
		return param_00.origin;
	}

	if(length(param_00 getentityvelocity()) < 25)
	{
		return param_00.origin;
	}

	var_01 = param_00 getentitynumber();
	if(!isdefined(self.odin_predicted_loc_time_for_player[var_01]))
	{
		self.odin_predicted_loc_time_for_player[var_01] = 0;
	}

	var_02 = gettime();
	var_03 = var_02 - self.odin_predicted_loc_time_for_player[var_01];
	if(var_03 <= 400)
	{
		var_04 = vectornormalize(param_00 getentityvelocity());
		var_05 = vectornormalize(self.odin_predicted_loc_for_player[var_01] - param_00.origin);
		if(vectordot(var_04,var_05) < -0.5)
		{
			return param_00.origin;
		}
	}

	if(var_03 > 400)
	{
		if(var_02 == self.odin_last_predict_position_time)
		{
			if(var_03 > 1000)
			{
				return param_00.origin;
			}
		}
		else
		{
			self.odin_predicted_loc_for_player[var_01] = getpredictedentityposition(param_00,1.5);
			self.odin_predicted_loc_time_for_player[var_01] = var_02;
			self.odin_last_predict_position_time = var_02;
		}
	}

	return self.odin_predicted_loc_for_player[var_01];
}

//Function Number: 58
bot_odin_get_closest_visible_outside_player(param_00,param_01,param_02)
{
	var_03 = bot_odin_get_visible_outside_players(param_00,param_01);
	if(isdefined(param_02))
	{
		var_03 = common_scripts\utility::array_remove(var_03,param_02);
	}

	if(var_03.size > 0)
	{
		var_04 = common_scripts\utility::func_37D5(self.odin.targeting_marker.origin,var_03);
		return var_04[0];
	}

	return undefined;
}

//Function Number: 59
bot_odin_try_spawn_juggernaut()
{
	if(gettime() >= self.odin.odin_juggernautusetime)
	{
		if(!isdefined(self.odin.targeting_marker.nearest_node))
		{
			return 0;
		}

		var_00 = maps\mp\killstreaks\_odin::func_3AE2(self.odin.targeting_marker.origin);
		if(isdefined(var_00))
		{
			self notify("juggernaut_action");
			return 1;
		}
	}

	return 0;
}

//Function Number: 60
bot_odin_find_target_for_airdrop()
{
	return bot_odin_get_closest_visible_outside_player("ally",0);
}

//Function Number: 61
bot_odin_try_airdrop()
{
	if(bot_odin_should_airdrop_at_marker())
	{
		self notify("airdrop_action");
		self notify("juggernaut_action");
		return 1;
	}

	return 0;
}

//Function Number: 62
bot_odin_should_airdrop_at_marker()
{
	if(gettime() < self.odin.odin_airdropusetime)
	{
		return 0;
	}

	if(!isdefined(self.odin.targeting_marker.nearest_node))
	{
		return 0;
	}

	if(func_1645() > 2)
	{
		return 0;
	}

	if(!isdefined(self.odin.targeting_marker.nearest_point_on_pathgrid))
	{
		return 0;
	}

	var_00 = getnodezone(self.odin.targeting_marker.nearest_node);
	if(!isdefined(var_00))
	{
		return 0;
	}

	var_01 = bot_killstreak_get_zone_allies_outside(1);
	var_02 = var_01[var_00].size;
	var_03 = bot_killstreak_get_zone_enemies_outside(1);
	var_04 = var_03[var_00].size;
	if(var_02 == 0)
	{
		return 0;
	}

	if(var_04 == 0)
	{
		var_05 = 0;
		var_06 = bot_odin_get_visible_outside_players("enemy",1);
		foreach(var_08 in var_06)
		{
			if(distancesquared(var_08.origin,self.odin.targeting_marker.origin) < 14400)
			{
				var_05 = 1;
			}
		}

		if(!var_05)
		{
			return 1;
		}
	}

	if(var_02 - var_04 >= 2)
	{
		var_0A = common_scripts\utility::func_37D5(self.odin.targeting_marker.origin,var_01[var_00]);
		var_0B = common_scripts\utility::func_37D5(self.odin.targeting_marker.origin,var_03[var_00]);
		var_0C = distance(self.odin.targeting_marker.origin,var_0A[0].origin);
		var_0D = distance(self.odin.targeting_marker.origin,var_0B[0].origin);
		if(var_0C + 120 < var_0D)
		{
			return 1;
		}
	}

	return 0;
}

//Function Number: 63
func_1645()
{
	var_00 = 0;
	foreach(var_02 in level.carepackages)
	{
		if(isdefined(var_02) && maps/mp/bots/_bots::func_2032(var_02))
		{
			var_00++;
		}
	}

	return var_00;
}

//Function Number: 64
bot_odin_get_visible_outside_players(param_00,param_01,param_02)
{
	var_03 = func_160D(self.team,param_00,param_01);
	var_04 = self botgetfovdot();
	var_05 = [];
	foreach(var_07 in var_03)
	{
		var_08 = 0;
		var_09 = var_04;
		if(param_00 == "enemy")
		{
			if(maps\mp\killstreaks\_odin::func_2F28(var_07))
			{
				var_08 = 1;
			}
			else
			{
				var_09 = var_09 * 0.9;
			}
		}

		if(common_scripts\utility::func_8E18(self.vehicle_controlling.origin,self getplayerangles(),var_07.origin,var_09))
		{
			if(!var_08 || self botcanseeentity(var_07))
			{
				var_05 = common_scripts\utility::array_add(var_05,var_07);
			}
		}
	}

	return var_05;
}

//Function Number: 65
is_indoor_map()
{
	return level.script == "mp_sovereign";
}

//Function Number: 66
bot_body_is_dead()
{
	return isdefined(self.fauxdead) && self.fauxdead;
}

//Function Number: 67
func_40FA(param_00,param_01)
{
	var_02 = undefined;
	var_03 = 0;
	foreach(var_05 in param_00)
	{
		var_06 = distancesquared(level.bot_map_center,[[ level.bot_ks_funcs["heli_node_get_origin"][param_01] ]](var_05));
		if(var_06 > var_03)
		{
			var_03 = var_06;
			var_02 = var_05;
		}
	}

	if(isdefined(var_02))
	{
		return var_02;
	}

	return common_scripts\utility::func_6306(param_00);
}

//Function Number: 68
heli_get_node_origin(param_00)
{
	return param_00.origin;
}

//Function Number: 69
func_3261(param_00,param_01)
{
	var_02 = undefined;
	var_03 = 99999999;
	foreach(var_05 in level.bot_heli_nodes)
	{
		var_06 = distance2dsquared(param_00,[[ level.bot_ks_funcs["heli_node_get_origin"][param_01] ]](var_05));
		if(var_06 < var_03)
		{
			var_02 = var_05;
			var_03 = var_06;
		}
	}

	return var_02;
}

//Function Number: 70
bot_killstreak_get_zone_allies_outside(param_00)
{
	var_01 = bot_killstreak_get_all_outside_allies(param_00);
	var_02 = [];
	for(var_03 = 0;var_03 < level.zonecount;var_03++)
	{
		var_02[var_03] = [];
	}

	foreach(var_05 in var_01)
	{
		var_06 = var_05 getnearestnode();
		var_07 = getnodezone(var_06);
		if(isdefined(var_07))
		{
			var_02[var_07] = common_scripts\utility::array_add(var_02[var_07],var_05);
		}
	}

	return var_02;
}

//Function Number: 71
bot_killstreak_get_zone_enemies_outside(param_00)
{
	var_01 = bot_killstreak_get_all_outside_enemies(param_00);
	var_02 = [];
	for(var_03 = 0;var_03 < level.zonecount;var_03++)
	{
		var_02[var_03] = [];
	}

	foreach(var_05 in var_01)
	{
		var_06 = var_05 getnearestnode();
		var_07 = getnodezone(var_06);
		var_02[var_07] = common_scripts\utility::array_add(var_02[var_07],var_05);
	}

	return var_02;
}

//Function Number: 72
bot_killstreak_get_all_outside_enemies(param_00)
{
	return func_160D(self.team,"enemy",param_00);
}

//Function Number: 73
bot_killstreak_get_all_outside_allies(param_00)
{
	return func_160D(self.team,"ally",param_00);
}

//Function Number: 74
func_160D(param_00,param_01,param_02)
{
	var_03 = [];
	var_04 = level.participants;
	if(isdefined(param_02) && param_02)
	{
		var_04 = level.players;
	}

	foreach(var_06 in var_04)
	{
		if(var_06 == self || !isalive(var_06))
		{
			continue;
		}

		var_07 = 0;
		if(param_01 == "ally")
		{
			var_07 = level.teambased && param_00 == var_06.team;
		}
		else if(param_01 == "enemy")
		{
			var_07 = !level.teambased || param_00 != var_06.team;
		}

		if(var_07)
		{
			var_08 = var_06 getnearestnode();
			if(isdefined(var_08) && nodeexposedtosky(var_08))
			{
				var_03 = common_scripts\utility::array_add(var_03,var_06);
			}
		}
	}

	var_03 = common_scripts\utility::array_remove(var_03,self);
	return var_03;
}

//Function Number: 75
bot_heli_find_unvisited_nodes(param_00)
{
	var_01 = 99;
	var_02 = [];
	foreach(var_04 in param_00.neighbors)
	{
		if(isdefined(var_04.script_linkname))
		{
			var_05 = var_04.bot_visited_times[self.entity_number];
			if(var_05 < var_01)
			{
				var_02 = [];
				var_02[0] = var_04;
				var_01 = var_05;
			}
			else if(var_05 == var_01)
			{
				var_02[var_02.size] = var_04;
			}
		}
	}

	return var_02;
}

//Function Number: 76
bot_control_heli(param_00)
{
	self endon("spawned_player");
	self endon("disconnect");
	self endon("control_func_done");
	level endon("game_ended");
	var_01 = bot_waittill_using_vehicle(param_00);
	if(!var_01)
	{
		self notify("control_func_done");
	}

	foreach(var_03 in level.littlebirds)
	{
		if(var_03.owner == self)
		{
			self.vehicle_controlling = var_03;
		}
	}

	childthread bot_end_control_on_vehicle_death(self.vehicle_controlling);
	self.vehicle_controlling endon("death");
	if(isdefined(level.bot_ks_funcs["control_other"][param_00]))
	{
		self childthread [[ level.bot_ks_funcs["control_other"][param_00] ]]();
	}

	self [[ level.bot_ks_funcs["waittill_initial_goal"][param_00] ]]();
	self childthread [[ level.bot_ks_funcs["control_aiming"][param_00] ]]();
	bot_control_heli_main_move_loop(param_00,1);
	self notify("control_func_done");
}

//Function Number: 77
bot_get_heli_goal_dist_sq(param_00)
{
	if(param_00)
	{
		return squared(100);
	}

	return squared(30);
}

//Function Number: 78
bot_get_heli_slowdown_dist_sq(param_00)
{
	if(param_00)
	{
		return squared(300);
	}

	return squared(90);
}

//Function Number: 79
bot_control_heli_main_move_loop(param_00,param_01)
{
	foreach(var_03 in level.bot_heli_nodes)
	{
		var_03.bot_visited_times[self.entity_number] = 0;
	}

	var_05 = func_3261(self.vehicle_controlling.origin,param_00);
	var_06 = undefined;
	self.next_goal_time = 0;
	var_07 = "needs_new_goal";
	var_08 = undefined;
	var_09 = self.vehicle_controlling.origin;
	var_0A = 3;
	var_0B = 0.05;
	while(self [[ level.bot_ks_funcs["isUsing"][param_00] ]]())
	{
		if(gettime() > self.next_goal_time && var_07 == "needs_new_goal")
		{
			var_0C = var_05;
			var_05 = [[ level.bot_ks_funcs["heli_pick_node"][param_00] ]](var_05);
			var_06 = undefined;
			if(isdefined(var_05))
			{
				var_0D = [[ level.bot_ks_funcs["heli_node_get_origin"][param_00] ]](var_05);
				if(param_01)
				{
					var_0E = var_05.origin + maps\mp\_utility::gethelipilotmeshoffset() + level.bot_heli_pilot_traceoffset;
					var_0F = var_05.origin + maps\mp\_utility::gethelipilotmeshoffset() - level.bot_heli_pilot_traceoffset;
					var_10 = bullettrace(var_0E,var_0F,0,undefined,0,0,1);
					var_06 = var_10["position"] - maps\mp\_utility::gethelipilotmeshoffset() + level.bot_ks_heli_offset[param_00];
				}
				else
				{
					var_06 = var_0D;
				}
			}

			if(isdefined(var_06))
			{
				self botsetflag("disable_movement",0);
				var_07 = "waiting_till_goal";
				var_0A = 3;
				var_09 = self.vehicle_controlling.origin;
			}
			else
			{
				var_05 = var_0C;
				self.next_goal_time = gettime() + 2000;
			}

			continue;
		}

		if(var_07 == "waiting_till_goal")
		{
			if(!param_01)
			{
				var_11 = var_06[2] - self.vehicle_controlling.origin[2];
				if(var_11 > 10)
				{
					self botpressbutton("lethal");
				}
				else if(var_11 < -10)
				{
					self botpressbutton("tactical");
				}
			}

			var_12 = var_06 - self.vehicle_controlling.origin;
			if(param_01)
			{
				var_08 = length2dsquared(var_12);
			}
			else
			{
				var_08 = lengthsquared(var_12);
			}

			if(var_08 < bot_get_heli_goal_dist_sq(param_01))
			{
				self botsetscriptmove(0,0);
				self botsetflag("disable_movement",1);
				if(self botgetdifficulty() == "recruit")
				{
					self.next_goal_time = gettime() + randomintrange(5000,7000);
				}
				else
				{
					self.next_goal_time = gettime() + randomintrange(3000,5000);
				}

				var_07 = "needs_new_goal";
			}
			else
			{
				var_12 = var_06 - self.vehicle_controlling.origin;
				var_13 = vectortoangles(var_12);
				var_14 = common_scripts\utility::func_803F(var_08 < bot_get_heli_slowdown_dist_sq(param_01),0.5,1);
				self botsetscriptmove(var_13[1],var_0B,var_14);
				var_0A = var_0A - var_0B;
				if(var_0A <= 0)
				{
					if(distancesquared(self.vehicle_controlling.origin,var_09) < 225)
					{
						var_05.bot_visited_times[self.entity_number]++;
						var_07 = "needs_new_goal";
					}

					var_09 = self.vehicle_controlling.origin;
					var_0A = 3;
				}
			}
		}

		wait(var_0B);
	}
}

//Function Number: 80
func_3976()
{
	var_00 = [];
	foreach(var_02 in level.outside_zones)
	{
		var_03 = botzonegetcount(var_02,self.team,"enemy_predict");
		if(var_03 > 0)
		{
			var_00 = common_scripts\utility::array_add(var_00,var_02);
		}
	}

	var_05 = undefined;
	if(var_00.size > 0)
	{
		var_06 = common_scripts\utility::func_6306(var_00);
		var_07 = common_scripts\utility::func_6306(getzonenodes(var_06));
		var_05 = var_07.origin;
	}
	else
	{
		if(isdefined(level.teleportgetactivenodesfunc))
		{
			var_08 = [[ level.teleportgetactivenodesfunc ]]();
		}
		else
		{
			var_08 = getallnodes();
		}

		var_09 = 0;
		while(var_09 < 10)
		{
			var_09++;
			var_0A = var_08[randomint(var_08.size)];
			var_05 = var_0A.origin;
			if(nodeexposedtosky(var_0A) && distance2dsquared(var_0A.origin,self.vehicle_controlling.origin) > -3036)
			{
				break;
			}
		}
	}

	return var_05;
}