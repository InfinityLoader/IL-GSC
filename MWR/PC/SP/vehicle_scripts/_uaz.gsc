/*******************************************************************
 * Decompiled By: Bog
 * Decompiled File: vehicle_scripts\_uaz.gsc
 * Game: Call of Duty: Modern Warfare Remastered
 * Platform: PC
 * Function Count: 4
 * Decompile Time: 81 ms
 * Timestamp: 10/27/2023 2:46:21 AM
*******************************************************************/

//Function Number: 1
main(param_00,param_01,param_02)
{
	maps\_vehicle::build_template("uaz",param_00,param_01,param_02);
	maps\_vehicle::build_localinit(::init_local);
	maps\_vehicle::build_destructible("vehicle_uaz_hardtop_destructible","vehicle_uaz_hardtop");
	maps\_vehicle::build_destructible("vehicle_uaz_light_destructible","vehicle_uaz_light");
	maps\_vehicle::build_destructible("vehicle_uaz_open_destructible","vehicle_uaz_open");
	maps\_vehicle::build_destructible("vehicle_uaz_open_for_ride","vehicle_uaz_open");
	maps\_vehicle::build_destructible("vehicle_uaz_fabric_destructible","vehicle_uaz_fabric");
	maps\_vehicle::build_bulletshield(1);
	maps\_vehicle::build_deathmodel("vehicle_uaz_fabric","vehicle_uaz_fabric_dsr");
	maps\_vehicle::build_deathmodel("vehicle_uaz_hardtop","vehicle_uaz_hardtop_dsr");
	maps\_vehicle::build_deathmodel("vehicle_uaz_open","vehicle_uaz_open_dsr");
	maps\_vehicle::build_deathmodel("vehicle_uaz_hardtop_thermal","vehicle_uaz_hardtop_thermal");
	maps\_vehicle::build_deathmodel("vehicle_uaz_open_for_ride");
	maps\_vehicle::build_deathfx("fx/explosions/small_vehicle_explosion",undefined,"explo_metal_rand");
	maps\_vehicle::build_radiusdamage((0,0,32),300,200,100,0);
	maps\_vehicle::build_drive(%uaz_driving_idle_forward,%uaz_driving_idle_backward,10);
	maps\_vehicle::build_deathquake(1,1.6,500);
	maps\_vehicle::build_treadfx();
	maps\_vehicle::build_life(999,500,1500);
	maps\_vehicle::build_team("axis");
	maps\_vehicle::build_aianims(::setanims,::set_vehicle_anims);
}

//Function Number: 2
init_local()
{
	self.clear_anims_on_death = 1;
}

//Function Number: 3
set_vehicle_anims(param_00)
{
	if(getdvarint("use_old_uaz_anims") == 1)
	{
		param_00[0].vehicle_getoutanim = %uaz_driver_exit_into_run_door;
		param_00[1].vehicle_getoutanim = %uaz_passenger_exit_into_run_door;
	}
	else
	{
		param_00[0].vehicle_getoutanim = %h1_uaz_driver_exit_into_idle_door;
		param_00[1].vehicle_getoutanim = %h1_uaz_passenger_exit_into_idle_door;
	}

	param_00[0].vehicle_getinanim = %uaz_driver_enter_from_huntedrun_door;
	param_00[1].vehicle_getinanim = %uaz_passenger_enter_from_huntedrun_door;
	param_00[0].vehicle_getoutsoundtag = "front_door_left_jnt";
	param_00[1].vehicle_getoutsoundtag = "front_door_right_jnt";
	param_00[2].vehicle_getoutsoundtag = "rear_door_left_jnt";
	param_00[3].vehicle_getoutsoundtag = "rear_door_right_jnt";
	param_00[0].vehicle_getinsound = "truck_door_open";
	param_00[1].vehicle_getinsound = "truck_door_open";
	param_00[2].vehicle_getinsound = "truck_door_open";
	param_00[3].vehicle_getinsound = "truck_door_open";
	param_00[0].vehicle_getinsoundtag = "front_door_left_jnt";
	param_00[1].vehicle_getinsoundtag = "front_door_right_jnt";
	param_00[2].vehicle_getinsoundtag = "rear_door_left_jnt";
	param_00[3].vehicle_getinsoundtag = "rear_door_right_jnt";
	return param_00;
}

//Function Number: 4
setanims()
{
	var_00 = [];
	for(var_01 = 0;var_01 < 6;var_01++)
	{
		var_00[var_01] = spawnstruct();
	}

	var_00[0].sittag = "tag_driver";
	var_00[1].sittag = "tag_passenger";
	var_00[2].sittag = "tag_guy0";
	var_00[3].sittag = "tag_guy1";
	var_00[4].sittag = "tag_guy2";
	var_00[5].sittag = "tag_guy3";
	var_00[0].idle = %uaz_driver_idle_drive;
	var_00[1].idle = %uaz_passenger_idle_drive;
	var_00[2].idle = %uaz_passenger_idle_drive;
	var_00[3].idle = %uaz_passenger_idle_drive;
	var_00[4].idle = %uaz_passenger_idle_drive;
	var_00[5].idle = %uaz_passenger_idle_drive;
	if(getdvarint("use_old_uaz_anims") == 1)
	{
		var_00[0].getout = %uaz_driver_exit_into_run;
		var_00[1].getout = %uaz_passenger_exit_into_run;
		var_00[2].getout = %uaz_driver_exit_into_run;
		var_00[3].getout = %uaz_passenger_exit_into_run;
	}
	else
	{
		var_00[0].getout = %h1_uaz_driver_exit_into_idle;
		var_00[0].getout_ik = 1;
		var_00[1].getout = %h1_uaz_passenger_exit_into_idle;
		var_00[1].getout_ik = 1;
		var_00[2].getout = %h1_uaz_driver_exit_into_idle;
		var_00[2].getout_ik = 1;
		var_00[3].getout = %h1_uaz_passenger_exit_into_idle;
		var_00[3].getout_ik = 1;
	}

	var_00[0].getin = %uaz_driver_enter_from_huntedrun;
	var_00[1].getin = %uaz_passenger_enter_from_huntedrun;
	return var_00;
}