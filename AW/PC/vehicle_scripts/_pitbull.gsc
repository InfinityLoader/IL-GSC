/*******************************************************************
 * Decompiled By: Bog
 * Decompiled File: _pitbull.gsc
 * Game: Call of Duty: Advanced Warfare
 * Platform: PC
 * Function Count: 6
 * Decompile Time: 112 ms
 * Timestamp: 4/22/2024 2:05:26 AM
*******************************************************************/

//Function Number: 1
main(param_00,param_01,param_02)
{
	maps\_vehicle::build_template("pitbull",param_00,param_01,param_02);
	maps\_vehicle::build_localinit(::init_local);
	if(param_00 == "vehicle_pitbull")
	{
		maps\_vehicle::build_deathmodel("vehicle_pitbull","vehicle_pitbull_dstrypv");
		var_03 = [];
		var_03["vehicle_pitbull"] = "vfx/explosion/vehicle_civ_ai_explo_med_runner";
		maps\_vehicle::build_deathfx(var_03[param_00],"tag_death_fx","car_explode");
		maps\_vehicle::build_drive(%humvee_50cal_driving_idle_forward,%humvee_50cal_driving_idle_backward,50);
		maps\_vehicle::build_light(param_02,"brakelight_set","tag_origin","vfx/lights/veh_pitbull_stop_light","brakelights");
	}

	if(param_02 == "script_vehicle_mil_avt_ai")
	{
		maps\_vehicle::build_drive(%humvee_50cal_driving_idle_forward,%humvee_50cal_driving_idle_backward,50);
	}
	else if(param_02 == "script_vehicle_pitbull_physics_alt")
	{
		maps\_vehicle::build_turret("pitbull_turret_bullet","tag_turret","weapon_pitbull_turret",undefined,"manual",0.2,10,-14);
	}
	else
	{
		maps\_vehicle::build_turret("pitbull_turret","tag_turret","weapon_pitbull_turret",undefined,"manual",0.2,10,-14);
	}

	maps\_vehicle::build_unload_groups(::unload_groups);
	maps\_vehicle::build_treadfx(param_02,"default","vfx/treadfx/tread_dust_default");
	maps\_vehicle::build_life(999,500,1500);
	maps\_vehicle::build_team("allies");
	maps\_vehicle::build_aianims(::setanims,::set_vehicle_anims);
}

//Function Number: 2
init_local()
{
	if(issubstr(self.vehicletype,"physics"))
	{
		var_00 = [];
		var_00["idle"] = %humvee_antennas_idle_movement;
		var_00["rot_l"] = %humvee_antenna_l_rotate_360;
		var_00["rot_r"] = %humvee_antenna_r_rotate_360;
		thread maps\_vehicle_code::humvee_antenna_animates(var_00);
	}

	if(self.model == "vehicle_vm_pitbull")
	{
		self hidepart("TAG_WINDSHIELD1");
		self hidepart("TAG_WINDSHIELD2");
		self hidepart("TAG_WINDSHIELD3");
	}
}

//Function Number: 3
handle_pitbull_audio()
{
	soundscripts\_snd::snd_message("snd_register_vehicle","pitbull",::vehicle_scripts\_pitbull_aud::snd_pitbull_constructor);
	soundscripts\_snd::snd_message("snd_start_vehicle","pitbull");
}

//Function Number: 4
unload_groups()
{
	var_00 = [];
	return var_00;
}

//Function Number: 5
set_vehicle_anims(param_00)
{
	param_00[0].vehicle_getoutanim = %uaz_driver_exit_into_run_door;
	param_00[1].vehicle_getoutanim = %uaz_rear_driver_exit_into_run_door;
	param_00[2].vehicle_getoutanim = %uaz_passenger_exit_into_run_door;
	param_00[3].vehicle_getoutanim = %uaz_passenger2_exit_into_run_door;
	param_00[0].vehicle_getinanim = %humvee_mount_frontl_door;
	param_00[1].vehicle_getinanim = %humvee_mount_frontr_door;
	param_00[2].vehicle_getinanim = %humvee_mount_backl_door;
	param_00[3].vehicle_getinanim = %humvee_mount_backr_door;
	param_00[0].vehicle_getoutsound = "hummer_door_open";
	param_00[1].vehicle_getoutsound = "hummer_door_open";
	param_00[2].vehicle_getoutsound = "hummer_door_open";
	param_00[3].vehicle_getoutsound = "hummer_door_open";
	param_00[0].vehicle_getinsound = "hummer_door_close";
	param_00[1].vehicle_getinsound = "hummer_door_close";
	param_00[2].vehicle_getinsound = "hummer_door_close";
	param_00[3].vehicle_getinsound = "hummer_door_close";
	return param_00;
}

//Function Number: 6
setanims()
{
	var_00 = [];
	for(var_01 = 0;var_01 < 4;var_01++)
	{
		var_00[var_01] = spawnstruct();
	}

	var_00[0].sittag = "tag_driver";
	var_00[1].sittag = "tag_passenger";
	var_00[2].sittag = "tag_guy0";
	var_00[3].sittag = "tag_guy1";
	var_00[0].bhasgunwhileriding = 0;
	var_00[0].idle = %humvee_idle_frontl;
	var_00[1].idle = %humvee_idle_frontr;
	var_00[2].idle = %humvee_idle_backl;
	var_00[3].idle = %humvee_idle_backr;
	var_00[0].getout = %humvee_driver_climb_out;
	var_00[1].getout = %humvee_passenger_out_r;
	var_00[2].getout = %humvee_passenger_out_l;
	var_00[3].getout = %humvee_passenger_out_r;
	var_00[0].getin = %humvee_mount_frontl;
	var_00[1].getin = %humvee_mount_frontr;
	var_00[2].getin = %humvee_mount_backl;
	var_00[3].getin = %humvee_mount_backr;
	return var_00;
}