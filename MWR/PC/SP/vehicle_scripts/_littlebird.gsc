/*******************************************************************
 * Decompiled By: Bog
 * Decompiled File: vehicle_scripts\_littlebird.gsc
 * Game: Call of Duty: Modern Warfare Remastered
 * Platform: PC
 * Function Count: 15
 * Decompile Time: 233 ms
 * Timestamp: 10/27/2023 2:51:06 AM
*******************************************************************/

//Function Number: 1
armed(param_00,param_01)
{
	return issubstr(param_00,"armed") || issubstr(param_01,"armed");
}

//Function Number: 2
main(param_00,param_01,param_02)
{
	if(armed(param_00,param_02))
	{
		vehicle_scripts\_attack_heli::preload();
	}

	if(issubstr(param_02,"bench"))
	{
		precachemodel("vehicle_sentinel_littlebird_benchleft");
		precachemodel("vehicle_sentinel_littlebird_benchright");
	}

	maps\_vehicle::build_template("littlebird",param_00,param_01,param_02);
	maps\_vehicle::build_localinit(::init_local);
	maps\_vehicle::build_deathmodel("vehicle_little_bird_armed");
	maps\_vehicle::build_deathmodel("vehicle_little_bird_bench");
	if(issubstr(param_02,"kva") || issubstr(param_02,"atlas") || issubstr(param_02,"sentinel"))
	{
		maps\_vehicle::build_drive(%mil_helicopter_littlebird_ai_rotors,undefined,0,3);
	}
	else
	{
		maps\_vehicle::build_drive(%mi28_rotors,undefined,0,3);
	}

	maps\_vehicle::build_deathfx("fx/explosions/helicopter_explosion_secondary_small","tag_engine","littlebird_helicopter_secondary_exp",undefined,undefined,undefined,0,1);
	maps\_vehicle::build_deathfx("vfx/trail/trail_fire_smoke_l","tag_engine","littlebird_helicopter_dying_loop",1,0.05,1,0.5,1);
	maps\_vehicle::build_deathfx("fx/explosions/helicopter_explosion_secondary_small","tag_engine",undefined,undefined,undefined,undefined,2.5,1);
	maps\_vehicle::build_deathfx("vfx/explosion/vehicle_littlebird_explosion_a",undefined,"littlebird_helicopter_crash",undefined,undefined,undefined,-1,undefined,"stop_crash_loop_sound");
	maps\_vehicle::build_rocket_deathfx("vfx/explosion/vehicle_littlebird_explosion_a","tag_deathfx","littlebird_helicopter_crash",undefined,undefined,undefined,undefined,1,undefined,0);
	maps\_vehicle::build_deathquake(0.8,1.6,2048);
	maps\_vehicle::build_treadfx(param_02,"default","vfx/treadfx/heli_dust_default");
	maps\_vehicle::build_life(799);
	maps\_vehicle::build_team("axis");
	maps\_vehicle::build_mainturret();
	maps\_vehicle::build_unload_groups(::unload_groups);
	maps\_vehicle::build_aianims(::setanims,::set_vehicle_anims);
	var_03 = randomfloatrange(0,1);
	maps\_vehicle::build_light(param_02,"white_blink","TAG_LIGHT_BELLY","vfx/lights/aircraft_light_white_blink","running",var_03);
	maps\_vehicle::build_light(param_02,"red_blink1","TAG_LIGHT_TAIL1","vfx/lights/aircraft_light_red_blink","running",var_03);
	maps\_vehicle::build_light(param_02,"red_blink2","TAG_LIGHT_TAIL2","vfx/lights/aircraft_light_red_blink","running",var_03);
	maps\_vehicle::build_light(param_02,"headlight_nose","tag_light_nose","vfx/lights/headlight_gaz","headlights",0);
	var_04 = "littlebird_gunpod";
	maps\_vehicle::build_turret(var_04,"TAG_MINIGUN_ATTACH_LEFT","vehicle_mil_helicopter_littlebird_gunpodleft");
	maps\_vehicle::build_turret(var_04,"TAG_MINIGUN_ATTACH_RIGHT","vehicle_mil_helicopter_littlebird_gunpodright");
	maps\_vehicle::build_is_helicopter();
	vehicle_scripts\_littlebird_landing::init_littlebird_landing();
}

//Function Number: 3
init_local()
{
	self endon("death");
	self.originheightoffset = distance(self gettagorigin("tag_origin"),self gettagorigin("tag_ground"));
	self.script_badplace = 0;
	self.dontdisconnectpaths = 1;
	self.vehicle_loaded_notify_size = 6;
	thread vehicle_scripts\_littlebird_landing::littlebird_landing();
	thread attach_littlebird_parts();
	thread maps\_vehicle::vehicle_lights_on("running");
	if(issubstr(self.classname,"sentinel"))
	{
		self hidepart("main_rotor_static_jnt");
	}

	waittillframeend;
	if(!armed(self.model,self.classname))
	{
		maps\_vehicle::mgoff();
		foreach(var_01 in self.mgturret)
		{
			var_01 hide();
		}
	}

	thread vehicle_scripts\_littlebird_aud::handle_littlebird_audio();
	self.emp_death_function = ::littlebird_emp_death;
	maps\_utility::add_damage_function(::littlebird_emp_damage_function);
}

//Function Number: 4
show_blurry_rotors()
{
	if(issubstr(self.classname,"sentinel"))
	{
		self hidepart("main_rotor_static_jnt");
		self showpart("main_rotor_jnt");
	}
}

//Function Number: 5
show_static_rotors()
{
	if(issubstr(self.classname,"sentinel"))
	{
		self showpart("main_rotor_static_jnt");
		self hidepart("main_rotor_jnt");
	}
}

//Function Number: 6
attach_littlebird_parts()
{
	switch(self.classname)
	{
		case "script_vehicle_littlebird_atlas_bench":
		case "script_vehicle_littlebird_sentinel_bench":
			break;

		default:
			break;
	}
}

//Function Number: 7
set_vehicle_anims(param_00)
{
	return param_00;
}

//Function Number: 8
setanims()
{
	var_00 = [];
	for(var_01 = 0;var_01 < 8;var_01++)
	{
		var_00[var_01] = spawnstruct();
	}

	var_00[0].sittag = "tag_pilot1";
	var_00[1].sittag = "tag_pilot2";
	var_00[2].sittag = "tag_detach_right";
	var_00[3].sittag = "tag_detach_right";
	var_00[4].sittag = "tag_detach_right";
	var_00[5].sittag = "tag_detach_left";
	var_00[6].sittag = "tag_detach_left";
	var_00[7].sittag = "tag_detach_left";
	var_00[0].idle[0] = %helicopter_pilot1_idle;
	var_00[0].idle[1] = %helicopter_pilot1_twitch_clickpannel;
	var_00[0].idle[2] = %helicopter_pilot1_twitch_lookback;
	var_00[0].idle[3] = %helicopter_pilot1_twitch_lookoutside;
	var_00[0].idleoccurrence[0] = 500;
	var_00[0].idleoccurrence[1] = 100;
	var_00[0].idleoccurrence[2] = 100;
	var_00[0].idleoccurrence[3] = 100;
	var_00[1].idle[0] = %helicopter_pilot2_idle;
	var_00[1].idle[1] = %helicopter_pilot2_twitch_clickpannel;
	var_00[1].idle[2] = %helicopter_pilot2_twitch_lookoutside;
	var_00[1].idle[3] = %helicopter_pilot2_twitch_radio;
	var_00[1].idleoccurrence[0] = 450;
	var_00[1].idleoccurrence[1] = 100;
	var_00[1].idleoccurrence[2] = 100;
	var_00[1].idleoccurrence[3] = 100;
	var_00[2].idle[0] = %little_bird_casual_idle_guy1;
	var_00[3].idle[0] = %little_bird_casual_idle_guy3;
	var_00[4].idle[0] = %little_bird_casual_idle_guy2;
	var_00[5].idle[0] = %little_bird_casual_idle_guy1;
	var_00[6].idle[0] = %little_bird_casual_idle_guy3;
	var_00[7].idle[0] = %little_bird_casual_idle_guy2;
	var_00[2].idleoccurrence[0] = 100;
	var_00[3].idleoccurrence[0] = 166;
	var_00[4].idleoccurrence[0] = 122;
	var_00[5].idleoccurrence[0] = 177;
	var_00[6].idleoccurrence[0] = 136;
	var_00[7].idleoccurrence[0] = 188;
	var_00[2].idle[1] = %little_bird_aim_idle_guy1;
	var_00[3].idle[1] = %little_bird_aim_idle_guy3;
	var_00[4].idle[1] = %little_bird_aim_idle_guy2;
	var_00[5].idle[1] = %little_bird_aim_idle_guy1;
	var_00[7].idle[1] = %little_bird_aim_idle_guy2;
	var_00[2].idleoccurrence[1] = 200;
	var_00[3].idleoccurrence[1] = 266;
	var_00[4].idleoccurrence[1] = 156;
	var_00[5].idleoccurrence[1] = 277;
	var_00[7].idleoccurrence[1] = 288;
	var_00[2].idle_alert = %little_bird_alert_idle_guy1;
	var_00[3].idle_alert = %little_bird_alert_idle_guy3;
	var_00[4].idle_alert = %little_bird_alert_idle_guy2;
	var_00[5].idle_alert = %little_bird_alert_idle_guy1;
	var_00[6].idle_alert = %little_bird_alert_idle_guy3;
	var_00[7].idle_alert = %little_bird_alert_idle_guy2;
	var_00[2].idle_alert_to_casual = %little_bird_alert_2_aim_guy1;
	var_00[3].idle_alert_to_casual = %little_bird_alert_2_aim_guy3;
	var_00[4].idle_alert_to_casual = %little_bird_alert_2_aim_guy2;
	var_00[5].idle_alert_to_casual = %little_bird_alert_2_aim_guy1;
	var_00[6].idle_alert_to_casual = %little_bird_alert_2_aim_guy3;
	var_00[7].idle_alert_to_casual = %little_bird_alert_2_aim_guy2;
	var_00[2].getout = %little_bird_dismount_guy1;
	var_00[3].getout = %little_bird_dismount_guy3;
	var_00[4].getout = %little_bird_dismount_guy2;
	var_00[5].getout = %little_bird_dismount_guy1;
	var_00[6].getout = %little_bird_dismount_guy3;
	var_00[7].getout = %little_bird_dismount_guy2;
	var_00[2].littlebirde_getout_unlinks = 1;
	var_00[3].littlebirde_getout_unlinks = 1;
	var_00[4].littlebirde_getout_unlinks = 1;
	var_00[5].littlebirde_getout_unlinks = 1;
	var_00[6].littlebirde_getout_unlinks = 1;
	var_00[7].littlebirde_getout_unlinks = 1;
	var_00[2].getin = %little_bird_mount_guy1;
	var_00[2].getin_enteredvehicletrack = "mount_finish";
	var_00[3].getin = %little_bird_mount_guy3;
	var_00[3].getin_enteredvehicletrack = "mount_finish";
	var_00[4].getin = %little_bird_mount_guy2;
	var_00[4].getin_enteredvehicletrack = "mount_finish";
	var_00[5].getin = %little_bird_mount_guy1;
	var_00[5].getin_enteredvehicletrack = "mount_finish";
	var_00[6].getin = %little_bird_mount_guy3;
	var_00[6].getin_enteredvehicletrack = "mount_finish";
	var_00[7].getin = %little_bird_mount_guy2;
	var_00[7].getin_enteredvehicletrack = "mount_finish";
	var_00[2].getin_idle_func = ::maps\_vehicle_aianim::guy_idle_alert;
	var_00[3].getin_idle_func = ::maps\_vehicle_aianim::guy_idle_alert;
	var_00[4].getin_idle_func = ::maps\_vehicle_aianim::guy_idle_alert;
	var_00[5].getin_idle_func = ::maps\_vehicle_aianim::guy_idle_alert;
	var_00[6].getin_idle_func = ::maps\_vehicle_aianim::guy_idle_alert;
	var_00[7].getin_idle_func = ::maps\_vehicle_aianim::guy_idle_alert;
	var_00[2].pre_unload = %little_bird_aim_2_prelanding_guy1;
	var_00[3].pre_unload = %little_bird_aim_2_prelanding_guy3;
	var_00[4].pre_unload = %little_bird_aim_2_prelanding_guy2;
	var_00[5].pre_unload = %little_bird_aim_2_prelanding_guy1;
	var_00[6].pre_unload = %little_bird_aim_2_prelanding_guy3;
	var_00[7].pre_unload = %little_bird_aim_2_prelanding_guy2;
	var_00[2].pre_unload_idle = %little_bird_prelanding_idle_guy1;
	var_00[3].pre_unload_idle = %little_bird_prelanding_idle_guy3;
	var_00[4].pre_unload_idle = %little_bird_prelanding_idle_guy2;
	var_00[5].pre_unload_idle = %little_bird_prelanding_idle_guy1;
	var_00[6].pre_unload_idle = %little_bird_prelanding_idle_guy3;
	var_00[7].pre_unload_idle = %little_bird_prelanding_idle_guy2;
	var_00[0].bhasgunwhileriding = 0;
	var_00[1].bhasgunwhileriding = 0;
	return var_00;
}

//Function Number: 9
unload_groups()
{
	var_00 = [];
	var_00["first_guy_left"] = [];
	var_00["first_guy_right"] = [];
	var_00["left"] = [];
	var_00["right"] = [];
	var_00["passengers"] = [];
	var_00["default"] = [];
	var_00["first_guy_left"][0] = 5;
	var_00["first_guy_right"][0] = 2;
	var_00["stage_guy_left"][0] = 7;
	var_00["stage_guy_right"][0] = 4;
	var_00["left"][var_00["left"].size] = 5;
	var_00["left"][var_00["left"].size] = 6;
	var_00["left"][var_00["left"].size] = 7;
	var_00["right"][var_00["right"].size] = 2;
	var_00["right"][var_00["right"].size] = 3;
	var_00["right"][var_00["right"].size] = 4;
	var_00["passengers"][var_00["passengers"].size] = 2;
	var_00["passengers"][var_00["passengers"].size] = 3;
	var_00["passengers"][var_00["passengers"].size] = 4;
	var_00["passengers"][var_00["passengers"].size] = 5;
	var_00["passengers"][var_00["passengers"].size] = 6;
	var_00["passengers"][var_00["passengers"].size] = 7;
	var_00["default"] = var_00["passengers"];
	return var_00;
}

//Function Number: 10
littlebird_emp_damage_function(param_00,param_01,param_02,param_03,param_04,param_05,param_06)
{
	if(param_04 == "MOD_ENERGY" && isdefined(self.emp_death_function))
	{
		self thread [[ self.emp_death_function ]](param_01,param_04);
	}
}

//Function Number: 11
littlebird_emp_death(param_00,param_01)
{
	self endon("death");
	self endon("in_air_explosion");
	self notify("emp_death");
	maps\_vehicle::vehicle_lights_off("all");
	self.vehicle_stays_alive = 1;
	var_02 = self vehicle_getvelocity();
	var_03 = 250;
	if(isdefined(level.get_littlebird_crash_location_override))
	{
		var_04 = [[ level.get_littlebird_crash_location_override ]]();
	}
	else
	{
		var_05 = (self.origin[0] + var_03[0] * 5,self.origin[1] + var_03[1] * 5,self.origin[2] - 2000);
		var_04 = bullettrace(self.origin,var_05,0,self)["position"];
	}

	self notify("newpath");
	self notify("deathspin");
	thread littlebird_deathspin();
	var_06 = 1000;
	self vehicle_setspeed(var_06,40,1000);
	self neargoalnotifydist(var_03);
	self setgoalpos(var_04,0);
	thread littlebird_emp_crash_movement(var_04,var_03,var_06);
	common_scripts\utility::waittill_any("goal","near_goal");
	self notify("stop_crash_loop_sound");
	self notify("crash_done");
	self.alwaysrocketdeath = 1;
	self.enablerocketdeath = 1;
	maps\_vehicle_code::vehicle_kill_common(param_00,param_01);
	if(getdvar("mapname") == "lab")
	{
		check_lab_achievement();
	}

	self kill(self.origin,param_00);
}

//Function Number: 12
check_lab_achievement()
{
	if(!isdefined(level.restricted_airspace))
	{
		level.restricted_airspace = 0;
	}

	level.restricted_airspace++;
	if(level.restricted_airspace >= 10)
	{
		maps\_utility::giveachievement_wrapper("LEVEL_10A");
	}
}

//Function Number: 13
littlebird_deathspin()
{
	self endon("crash_done");
	self clearlookatent();
	self setyawspeed(400,100,100);
	for(;;)
	{
		if(!isdefined(self))
		{
			return;
		}

		var_00 = randomintrange(90,120);
		self settargetyaw(self.angles[1] + var_00);
		wait(0.5);
	}
}

//Function Number: 14
littlebird_emp_crash_movement(param_00,param_01,param_02)
{
	self endon("crash_done");
	self clearlookatent();
	self setyawspeed(400,100,100);
	var_03 = 400;
	var_04 = 100;
	var_05 = undefined;
	var_06 = 90 * randomintrange(-2,3);
	for(;;)
	{
		if(self.origin[2] < param_00[2] + param_01)
		{
			self notify("near_goal");
		}

		wait(0.05);
	}
}

//Function Number: 15
helicopter_crash_rotate()
{
	self endon("crash_done");
	self clearlookatent();
	self setyawspeed(400,100,100);
	for(;;)
	{
		if(!isdefined(self))
		{
			return;
		}

		var_00 = randomintrange(90,120);
		self settargetyaw(self.angles[1] + var_00);
		wait(0.5);
	}
}