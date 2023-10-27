/*******************************************************************
 * Decompiled By: Bog
 * Decompiled File: maps\_stealth_vehicle.gsc
 * Game: Call of Duty: Modern Warfare 3
 * Platform: PC
 * Function Count: 24
 * Decompile Time: 284 ms
 * Timestamp: 10/27/2023 2:20:24 AM
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
increase_fov_when_player_is_near()
{
	self endon("death");
	self endon("enemy");
	for(;;)
	{
		if(player_is_near())
		{
			self.fovcosine = 0.01;
			return;
		}

		wait 0.5;
	}
}

//Function Number: 3
player_is_near()
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
	thread base_truck_think();
	thread truck_headlights();
	self waittill("death");
	common_scripts\utility::flag_set("jeep_blown_up");
}

//Function Number: 5
base_truck_guys_think()
{
	self endon("death");
	level endon("_stealth_spotted");
	self endon("_stealth_attack");
	maps\_utility::ent_flag_init("jumped_out");
	thread truck_guys_think_jumpout();
	var_00 = [];
	var_01 = [];
	var_02 = [];
	lib_055A::func_41CF("animation","wrapper",::truck_animation_wrapper);
	lib_0559::func_4304(var_01);
	lib_0559::func_4309(var_7B);
	foreach(var_05, var_04 in var_02)
	{
		lib_0563::func_42C1(var_05,var_04);
	}

	maps\_utility::ent_flag_set("_stealth_behavior_reaction_anim");
}

//Function Number: 6
truck_guys_base_search_behavior(param_00)
{
	self endon("_stealth_enemy_alert_level_change");
	level endon("_stealth_spotted");
	self endon("_stealth_attack");
	self endon("death");
	self endon("pain_death");
	thread base_truck_guys_attacked_again();
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
		set_search_walk();
		lib_055A::func_41F2(param_00);
	}
}

//Function Number: 7
base_truck_guys_attacked_again()
{
	self endon("death");
	self endon("_stealth_attack");
	level endon("_stealth_spotted");
	wait 2;
	self waittill("_stealth_bad_event_listener");
	lib_055A::func_41EB();
	maps\_utility::ent_flag_set("not_first_attack");
}

//Function Number: 8
set_search_walk()
{
	maps\_utility::disable_cqbwalk();
	maps\_utility::set_generic_run_anim("patrol_cold_gunup_search",1);
	self.disablearrivals = 1;
	self.disableexits = 1;
}

//Function Number: 9
truck_guys_think_jumpout()
{
	self endon("death");
	self endon("pain_death");
	for(;;)
	{
		self waittill("jumpedout");
		lib_055A::func_41F1(self.origin);
		self.got_off_truck_origin = self.origin;
		maps\_utility::ent_flag_set("jumped_out");
		self waittill("enteredvehicle");
		wait 0.15;
		maps\_utility::ent_flag_clear("jumped_out");
		maps\_utility::ent_flag_set("_stealth_behavior_reaction_anim");
	}
}

//Function Number: 10
truck_animation_wrapper(param_00)
{
	self endon("death");
	self endon("pain_death");
	common_scripts\utility::flag_set("truck_guys_alerted");
	maps\_utility::ent_flag_wait("jumped_out");
	lib_055A::func_4200(param_00);
}

//Function Number: 11
truck_guys_reaction_behavior(param_00)
{
	self endon("death");
	self endon("pain_death");
	level endon("_stealth_spotted");
	self endon("_stealth_attack");
	common_scripts\utility::flag_set("truck_guys_alerted");
	maps\_utility::ent_flag_wait("jumped_out");
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
		var_01 = maps\_utility::get_closest_player(self.origin);
		var_02 = lib_055A::func_41F3(var_01.origin,1500,128);
		if(isdefined(var_02))
		{
			thread truck_guys_base_search_behavior(var_02);
		}
	}

	var_03 = lib_055A::func_41DB("_stealth_spotted");
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
	maps\_utility::ent_flag_wait("jumped_out");
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
		var_01 = self._stealth.logic.event.awareness_param[param_00];
		var_02 = lib_055A::func_41F3(var_01,300,40);
		thread lib_055A::func_41F4();
		if(isdefined(var_02))
		{
			thread truck_guys_base_search_behavior(var_02);
		}
	}

	var_03 = lib_055A::func_41DB("_stealth_spotted");
	if(common_scripts\utility::flag(var_03))
	{
		common_scripts\utility::flag_waitopen(var_03);
		return;
	}

	self waittill("normal");
}

//Function Number: 13
truck_alert_level_attack(param_00)
{
	self endon("death");
	self endon("pain_death");
	common_scripts\utility::flag_set("truck_guys_alerted");
	maps\_utility::ent_flag_wait("jumped_out");
}

//Function Number: 14
set_alert_cold_patrol_anims()
{
	self.patrol_walk_anim = "patrol_cold_gunup";
	self.patrol_walk_twitch = "patrol_gunup_twitch_weights";
}

//Function Number: 15
wait_reaction_time()
{
	var_00 = distance(self.origin,maps\_utility::get_closest_player(self.origin).origin);
	var_01 = var_00 - 200 / 1000;
	var_01 = clamp(var_01,0,0.5);
	wait var_01;
}

//Function Number: 16
base_truck_think()
{
	self endon("death");
	thread dialog_truck_coming();
	thread dialog_jeep_stopped();
	thread unload_and_attack_if_stealth_broken_and_close();
	common_scripts\utility::flag_wait("truck_guys_alerted");
	var_00 = maps\_utility::get_living_ai_array("truck_guys","script_noteworthy");
	if(var_00.size == 0)
	{
		self vehicle_setspeed(0,15);
		return;
	}

	var_01 = common_scripts\utility::random(var_00);
	var_01 lib_055A::func_41F4();
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
		delete_truck_headlights();
	}
}

//Function Number: 20
delete_truck_headlights()
{
	stopfxontag(level._effect["lighthaze_snow_headlights"],self,"TAG_LIGHT_RIGHT_FRONT");
	stopfxontag(level._effect["lighthaze_snow_headlights"],self,"TAG_LIGHT_LEFT_FRONT");
	stopfxontag(level._effect["car_taillight_uaz_l"],self,"TAG_LIGHT_LEFT_TAIL");
	stopfxontag(level._effect["car_taillight_uaz_l"],self,"TAG_LIGHT_RIGHT_TAIL");
}

//Function Number: 21
dialog_truck_coming()
{
	level endon("special_op_terminated");
	level endon("jeep_stopped");
	level endon("jeep_blown_up");
	var_00 = 1;
	for(;;)
	{
		waittill_player_in_truck_range();
		var_01 = maps\_utility::within_fov(self.origin,self.angles,self.close_player.origin,cos(45));
		if(var_01)
		{
			if(!var_00 && common_scripts\utility::cointoss())
			{
				maps\_utility::radio_dialogue("cliff_pri_truckcomingback");
			}
			else
			{
				maps\_utility::radio_dialogue("cliff_pri_truckiscoming");
			}

			var_00 = 0;
			wait 10;
		}

		wait 1;
	}
}

//Function Number: 22
waittill_player_in_truck_range()
{
	self.close_player = undefined;
	foreach(var_01 in level.players)
	{
		var_01 thread watch_for_truck(self);
	}

	level waittill("player_in_truck_range");
}

//Function Number: 23
watch_for_truck(param_00)
{
	level endon("player_in_truck_range");
	param_00 maps\_utility::waittill_entity_in_range(self,1200);
	param_00.close_player = self;
	level notify("player_in_truck_range");
}

//Function Number: 24
dialog_jeep_stopped()
{
	level endon("special_op_terminated");
	self waittill("unloading");
	if(common_scripts\utility::flag("_stealth_spotted"))
	{
		return;
	}

	maps\_utility::radio_dialogue("cliff_pri_headsup");
	if(common_scripts\utility::flag("_stealth_spotted"))
	{
		return;
	}

	maps\_utility::radio_dialogue("cliff_pri_lookingaround");
}