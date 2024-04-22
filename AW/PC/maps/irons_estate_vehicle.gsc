/*******************************************************************
 * Decompiled By: Bog
 * Decompiled File: irons_estate_vehicle.gsc
 * Game: Call of Duty: Advanced Warfare
 * Platform: PC
 * Function Count: 6
 * Decompile Time: 102 ms
 * Timestamp: 4/22/2024 2:32:14 AM
*******************************************************************/

//Function Number: 1
irons_estate_vehicle_guy_stealth_setup(param_00,param_01,param_02,param_03,param_04,param_05,param_06)
{
	var_07 = maps\_vehicle::spawn_vehicle_from_targetname(param_00);
	var_07 maps\_vehicle::godon();
	var_07.vehicle_driver = maps\_utility::spawn_targetname(param_01,1);
	var_08["reset"] = ::irons_estate_vehicle_passenger_normal;
	var_08["normal"] = ::irons_estate_vehicle_passenger_normal;
	var_07.vehicle_driver maps\_stealth_utility::stealth_threat_behavior_custom(var_08);
	var_07 maps\irons_estate_stealth::stealth_ai_idle_and_react_custom(var_07.vehicle_driver,param_03,param_04,param_02,param_05);
	if(isdefined(param_06))
	{
		var_07 thread irons_estate_vehicle_open_door_anim(var_07.vehicle_driver,param_06);
	}

	var_07 thread irons_estate_vehicle_damaged_watcher();
}

//Function Number: 2
irons_estate_vehicle_open_door_anim(param_00,param_01)
{
	self endon("death");
	param_00 endon("death");
	param_00 maps\_utility::ent_flag_waitopen("_stealth_normal");
	maps\_vehicle_aianim::setanimrestart_once(param_01,1);
}

//Function Number: 3
irons_estate_vehicle_damaged_watcher()
{
	self endon("death");
	for(;;)
	{
		self waittill("damage",var_00,var_01,var_02,var_03);
		if(isdefined(var_01) && var_01 == level.player)
		{
			break;
		}

		wait(0.05);
	}

	if(isdefined(self.vehicle_driver) && isalive(self.vehicle_driver) && !common_scripts\utility::flag("_stealth_spotted") && isdefined(self.vehicle_driver._stealth))
	{
		self.vehicle_driver endon("death");
		if(isdefined(var_03))
		{
			self.vehicle_driver notify("vehicle_damaged",var_03);
		}
		else
		{
			self.vehicle_driver notify("vehicle_damaged",self.origin);
		}

		var_04 = maps\_stealth_shared_utilities::group_get_ai_in_group(self.vehicle_driver.script_stealthgroup);
		if(isdefined(var_04))
		{
			foreach(var_06 in var_04)
			{
				if(var_06 == self)
				{
					continue;
				}

				if(isdefined(var_06.enemy) || isdefined(var_06.favoriteenemy))
				{
					continue;
				}

				var_06 thread maps\irons_estate_code::notify_delay_param("vehicle_damaged",randomfloatrange(0.25,1.5),self.origin);
			}
		}
	}
}

//Function Number: 4
irons_estate_vehicle_passenger_normal()
{
	thread maps\_stealth_shared_utilities::enemy_announce_hmph();
	irons_estate_vehicle_passenger_go_back();
}

//Function Number: 5
irons_estate_vehicle_passenger_go_back()
{
	self notify("going_back");
	self endon("death");
	self notify("stop_loop");
	if(!isdefined(self.script_patroller))
	{
		self.script_patroller = 1;
	}

	self._stealth.debug_state = "Going Back";
	if(isdefined(self._stealth.behavior.goback_startfunc))
	{
		self [[ self._stealth.behavior.goback_startfunc ]]();
	}

	var_00 = self._stealth.behavior.last_spot;
	if(isdefined(var_00) && self.type != "dog" && !isdefined(self.custommovetransition) && !isdefined(self.mech))
	{
		self.custommovetransition = ::maps\_patrol::patrol_resume_move_start_func;
	}

	if(isdefined(self.custommovetransition) && isdefined(self.pathgoalpos))
	{
		self setgoalpos(self.origin);
		wait(0.05);
	}

	if(isdefined(self.script_patroller))
	{
		var_01 = common_scripts\utility::getstructarray(self.script_parameters,"script_noteworthy");
		var_02 = common_scripts\utility::getclosest(self.origin,var_01);
		var_03 = common_scripts\utility::getstruct(var_02.target,"targetname");
		self.target = var_03.targetname;
		thread maps\_patrol::patrol();
	}
	else if(isalive(self.patrol_master))
	{
		thread maps\_patrol::pet_patrol();
		maps\_utility::set_dog_walk_anim();
		self.script_growl = undefined;
	}
	else if(isdefined(var_00))
	{
		if(self.type != "dog")
		{
			maps\_stealth_shared_utilities::stealth_set_run_anim("_stealth_patrol_walk",1);
		}
		else
		{
			maps\_utility::set_dog_walk_anim();
			self.script_growl = undefined;
		}

		self.disablearrivals = 1;
		self.disableexits = 1;
		self setgoalpos(var_00);
		self.goalradius = 40;
	}

	waittillframeend;
	maps\_utility::ent_flag_clear("_stealth_override_goalpos");
	if(isdefined(var_00))
	{
		thread maps\_stealth_shared_utilities::enemy_go_back_clear_lastspot(var_00);
	}
}

//Function Number: 6
irons_estate_vehicle_passenger_death_watcher()
{
}