/*******************************************************************
 * Decompiled By: Bog
 * Decompiled File: maps\_stealth_vehicle.gsc
 * Game: Call of Duty: Modern Warfare 3
 * Platform: Console
 * Function Count: 24
 * Decompile Time: 482 ms
 * Timestamp: 10/27/2023 2:34:40 AM
*******************************************************************/

//Function Number: 1
flags_init()
{
	level._effect["lighthaze_snow_headlights"] = loadfx("misc/lighthaze_snow_headlights");
	level._effect["car_taillight_uaz_l"] = loadfx("misc/car_taillight_uaz_l");
	common_scripts\utility::flag_init("truck_guys_alerted");
	common_scripts\utility::flag_init("jeep_blown_up");
	common_scripts\utility::flag_init("jeep_stopped");
}

//Function Number: 2
func_3E4A()
{
	self endon("death");
	self endon("enemy");
	for(;;)
	{
		if(func_3E4B())
		{
			self.fovcosine = 0.01;
			return;
		}

		wait 0.5;
	}
}

//Function Number: 3
func_3E4B()
{
	foreach(var_01 in level.players)
	{
		if(distancesquared(self.origin,var_01.origin) < squared(self.footstepdetectdistsprint))
		{
			return 1;
		}
	}

	return 0;
}

//Function Number: 4
stealth_truck_think()
{
	thread func_3E59();
	thread truck_headlights();
	self waittill("death");
	common_scripts\utility::flag_set("jeep_blown_up");
}

//Function Number: 5
func_3E4D()
{
	self endon("death");
	level endon("_stealth_spotted");
	self endon("_stealth_attack");
	maps\_utility::ent_flag_init("jumped_out");
	thread func_3E51();
	var_00 = [];
	var_01 = [];
	var_02 = [];
	maps\_stealth_shared_utilities::ai_create_behavior_function("animation","wrapper",::func_3E53);
	maps\_stealth_utility::stealth_threat_behavior_custom(var_01);
	maps\_stealth_utility::stealth_corpse_behavior_custom(var_41);
	foreach(var_05, var_04 in var_02)
	{
		maps\_stealth_event_enemy::func_3DC5(var_05,var_04);
	}

	maps\_utility::func_FA4("_stealth_behavior_reaction_anim");
}

//Function Number: 6
func_3E4E(param_00)
{
	self endon("_stealth_enemy_alert_level_change");
	level endon("_stealth_spotted");
	self endon("_stealth_attack");
	self endon("death");
	self endon("pain_death");
	thread func_3E4F();
	self.disablearrivals = 0;
	self.disableexits = 0;
	var_01 = distance(param_00.origin,self.origin);
	self setgoalnode(param_00);
	self.goalradius = var_01 * 0.5;
	wait 0.05;
	maps\_utility::set_generic_run_anim("_stealth_patrol_cqb");
	self waittill("goal");
	if(!common_scripts\utility::flag("_stealth_spotted") && !isdefined(self.enemy) || !self cansee(self.enemy))
	{
		func_3E50();
		maps\_stealth_shared_utilities::enemy_runto_and_lookaround(param_00);
	}
}

//Function Number: 7
func_3E4F()
{
	self endon("death");
	self endon("_stealth_attack");
	level endon("_stealth_spotted");
	wait 2;
	self waittill("_stealth_bad_event_listener");
	maps\_stealth_shared_utilities::func_3CEF();
	maps\_utility::func_FA4("not_first_attack");
}

//Function Number: 8
func_3E50()
{
	maps\_utility::disable_cqbwalk();
	maps\_utility::set_generic_run_anim("patrol_cold_gunup_search",1);
	self.disablearrivals = 1;
	self.disableexits = 1;
}

//Function Number: 9
func_3E51()
{
	self endon("death");
	self endon("pain_death");
	for(;;)
	{
		self waittill("jumpedout");
		maps\_stealth_shared_utilities::enemy_set_original_goal(self.origin);
		self.got_off_truck_origin = self.origin;
		maps\_utility::func_FA4("jumped_out");
		self waittill("enteredvehicle");
		wait 0.15;
		maps\_utility::ent_flag_clear("jumped_out");
		maps\_utility::func_FA4("_stealth_behavior_reaction_anim");
	}
}

//Function Number: 10
func_3E53(param_00)
{
	self endon("death");
	self endon("pain_death");
	common_scripts\utility::flag_set("truck_guys_alerted");
	maps\_utility::func_121C("jumped_out");
	maps\_stealth_shared_utilities::func_3D04(param_00);
}

//Function Number: 11
func_3E54(param_00)
{
	self endon("death");
	self endon("pain_death");
	level endon("_stealth_spotted");
	self endon("_stealth_attack");
	common_scripts\utility::flag_set("truck_guys_alerted");
	maps\_utility::func_121C("jumped_out");
	if(!common_scripts\utility::flag("truck_guys_alerted"))
	{
		return;
	}

	if(common_scripts\utility::flag_exist("truck_guys_not_going_back") && common_scripts\utility::flag("truck_guys_not_going_back"))
	{
		return;
	}

	if(!common_scripts\utility::flag("_stealth_spotted") && !maps\_utility::ent_flag("_stealth_attack"))
	{
		var_01 = maps\_utility::func_218A(self.origin);
		var_02 = maps\_stealth_shared_utilities::func_3CF7(var_01.origin,1500,128);
		if(isdefined(var_02))
		{
			thread func_3E4E(var_02);
		}
	}

	var_03 = maps\_stealth_shared_utilities::func_3CDF("_stealth_spotted");
	if(common_scripts\utility::flag(var_03))
	{
		common_scripts\utility::flag_waitopen(var_03);
		return;
	}

	self waittill("normal");
}

//Function Number: 12
truck_guys_no_enemy_reaction_behavior(param_00)
{
	self endon("death");
	self endon("pain_death");
	level endon("_stealth_spotted");
	self endon("_stealth_attack");
	common_scripts\utility::flag_set("truck_guys_alerted");
	maps\_utility::func_121C("jumped_out");
	if(!common_scripts\utility::flag("truck_guys_alerted"))
	{
		return;
	}

	if(common_scripts\utility::flag_exist("truck_guys_not_going_back") && common_scripts\utility::flag("truck_guys_not_going_back"))
	{
		return;
	}

	if(!common_scripts\utility::flag("_stealth_spotted") && !maps\_utility::ent_flag("_stealth_attack"))
	{
		var_01 = self._stealth.var_3CF1.event.awareness_param[param_00];
		var_02 = maps\_stealth_shared_utilities::func_3CF7(var_01,300,40);
		thread maps\_stealth_shared_utilities::func_3CF8();
		if(isdefined(var_02))
		{
			thread func_3E4E(var_02);
		}
	}

	var_03 = maps\_stealth_shared_utilities::func_3CDF("_stealth_spotted");
	if(common_scripts\utility::flag(var_03))
	{
		common_scripts\utility::flag_waitopen(var_03);
		return;
	}

	self waittill("normal");
}

//Function Number: 13
func_3E56(param_00)
{
	self endon("death");
	self endon("pain_death");
	common_scripts\utility::flag_set("truck_guys_alerted");
	maps\_utility::func_121C("jumped_out");
}

//Function Number: 14
set_alert_cold_patrol_anims()
{
	self.patrol_walk_anim = "patrol_cold_gunup";
	self.patrol_walk_twitch = "patrol_gunup_twitch_weights";
}

//Function Number: 15
func_3E58()
{
	var_00 = distance(self.origin,maps\_utility::func_218A(self.origin).origin);
	var_01 = var_00 - 200 / 1000;
	var_01 = clamp(var_01,0,0.5);
	wait var_01;
}

//Function Number: 16
func_3E59()
{
	self endon("death");
	thread func_3E5E();
	thread func_3E62();
	thread unload_and_attack_if_stealth_broken_and_close();
	common_scripts\utility::flag_wait("truck_guys_alerted");
	var_00 = maps\_utility::get_living_ai_array("truck_guys","script_noteworthy");
	if(var_00.size == 0)
	{
		self vehicle_setspeed(0,15);
		return;
	}

	var_01 = common_scripts\utility::random(var_00);
	var_01 maps\_stealth_shared_utilities::func_3CF8();
	self waittill("safe_to_unload");
	self vehicle_setspeed(0,15);
	wait 1;
	maps\_vehicle::vehicle_unload();
	common_scripts\utility::flag_set("jeep_stopped");
}

//Function Number: 17
unload_and_attack_if_stealth_broken_and_close()
{
	self endon("truck_guys_alerted");
	for(;;)
	{
		common_scripts\utility::flag_wait("_stealth_spotted");
		foreach(var_01 in level.players)
		{
			thread waittill_player_in_range(var_01);
		}

		self waittill("player_in_range");
		if(!common_scripts\utility::flag("_stealth_spotted"))
		{
			continue;
		}
		else
		{
			break;
		}
	}

	common_scripts\utility::flag_set("truck_guys_alerted");
}

//Function Number: 18
waittill_player_in_range(param_00)
{
	self endon("player_in_range");
	param_00 maps\_utility::waittill_entity_in_range(self,800);
	self notify("player_in_range");
}

//Function Number: 19
truck_headlights()
{
	playfxontag(level._effect["lighthaze_snow_headlights"],self,"TAG_LIGHT_RIGHT_FRONT");
	playfxontag(level._effect["lighthaze_snow_headlights"],self,"TAG_LIGHT_LEFT_FRONT");
	playfxontag(level._effect["car_taillight_uaz_l"],self,"TAG_LIGHT_LEFT_TAIL");
	playfxontag(level._effect["car_taillight_uaz_l"],self,"TAG_LIGHT_RIGHT_TAIL");
	self waittill("death");
	if(isdefined(self))
	{
		func_3E5D();
	}
}

//Function Number: 20
func_3E5D()
{
	stopfxontag(level._effect["lighthaze_snow_headlights"],self,"TAG_LIGHT_RIGHT_FRONT");
	stopfxontag(level._effect["lighthaze_snow_headlights"],self,"TAG_LIGHT_LEFT_FRONT");
	stopfxontag(level._effect["car_taillight_uaz_l"],self,"TAG_LIGHT_LEFT_TAIL");
	stopfxontag(level._effect["car_taillight_uaz_l"],self,"TAG_LIGHT_RIGHT_TAIL");
}

//Function Number: 21
func_3E5E()
{
	level endon("special_op_terminated");
	level endon("jeep_stopped");
	level endon("jeep_blown_up");
	var_00 = 1;
	for(;;)
	{
		func_3E60();
		var_01 = maps\_utility::within_fov(self.origin,self.angles,self.var_3E5F.origin,cos(45));
		if(var_01)
		{
			if(!var_00 && common_scripts\utility::cointoss())
			{
				maps\_utility::func_DDF("cliff_pri_truckcomingback");
			}
			else
			{
				maps\_utility::func_DDF("cliff_pri_truckiscoming");
			}

			var_00 = 0;
			wait 10;
		}

		wait 1;
	}
}

//Function Number: 22
func_3E60()
{
	self.var_3E5F = undefined;
	foreach(var_01 in level.players)
	{
		var_01 thread func_3E61(self);
	}

	level waittill("player_in_truck_range");
}

//Function Number: 23
func_3E61(param_00)
{
	level endon("player_in_truck_range");
	param_00 maps\_utility::waittill_entity_in_range(self,1200);
	param_00.var_3E5F = self;
	level notify("player_in_truck_range");
}

//Function Number: 24
func_3E62()
{
	level endon("special_op_terminated");
	self waittill("unloading");
	if(common_scripts\utility::flag("_stealth_spotted"))
	{
		return;
	}

	maps\_utility::func_DDF("cliff_pri_headsup");
	if(common_scripts\utility::flag("_stealth_spotted"))
	{
		return;
	}

	maps\_utility::func_DDF("cliff_pri_lookingaround");
}