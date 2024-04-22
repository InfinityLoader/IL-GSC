/*******************************************************************
 * Decompiled By: Bog
 * Decompiled File: _uk_delivery_truck.gsc
 * Game: Call of Duty: Advanced Warfare
 * Platform: PC
 * Function Count: 5
 * Decompile Time: 92 ms
 * Timestamp: 4/22/2024 2:05:35 AM
*******************************************************************/

//Function Number: 1
main(param_00,param_01,param_02)
{
	maps\_vehicle::build_template("uk_delivery_truck",param_00,param_01,param_02);
	maps\_vehicle::build_localinit(::init_local);
	maps\_vehicle::build_deathmodel(param_00,"vehicle_uk_delivery_truck_destroyed");
	maps\_vehicle::build_deathfx("fx/explosions/large_vehicle_explosion",undefined,"car_explode",undefined,undefined,undefined,0);
	maps\_vehicle::build_radiusdamage((0,0,32),300,200,100,0);
	maps\_vehicle::build_drive(%uaz_driving_idle_forward,%uaz_driving_idle_backward,10);
	maps\_vehicle::build_deathquake(1,1.6,500);
	maps\_vehicle::build_treadfx();
	maps\_vehicle::build_life(999,500,1500);
	maps\_vehicle::build_team("axis");
	var_03 = ::setanims;
	maps\_vehicle::build_aianims(var_03,::set_vehicle_anims);
}

//Function Number: 2
init_local()
{
}

//Function Number: 3
unload_groups()
{
	var_00 = [];
	var_01 = "passengers";
	var_00[var_01] = [];
	var_00[var_01][var_00[var_01].size] = 1;
	var_01 = "all";
	var_00[var_01] = [];
	var_00[var_01][var_00[var_01].size] = 0;
	var_00[var_01][var_00[var_01].size] = 1;
	var_00["default"] = var_00["all"];
	return var_00;
}

//Function Number: 4
set_vehicle_anims(param_00)
{
	param_00[0].vehicle_getoutanim = %uaz_driver_exit_into_run_door;
	param_00[0].vehicle_getoutanim_clear = 0;
	param_00[1].vehicle_getoutanim = %innocent_truck_exit_passenger_fwd_truck;
	param_00[1].vehicle_getoutanim_clear = 0;
	param_00[0].vehicle_getinanim = %humvee_mount_frontl_door;
	param_00[1].vehicle_getinanim = %humvee_mount_frontr_door;
	param_00[0].vehicle_getoutsound = "ukdelivery_door_open";
	param_00[1].vehicle_getoutsound = "ukdelivery_door_open";
	param_00[0].vehicle_getinsound = "ukdelivery_door_close";
	param_00[1].vehicle_getinsound = "ukdelivery_door_close";
	return param_00;
}

//Function Number: 5
setanims()
{
	var_00 = [];
	for(var_01 = 0;var_01 < 4;var_01++)
	{
		var_00[var_01] = spawnstruct();
	}

	var_00[0].sittag = "tag_driver";
	var_00[1].sittag = "tag_passenger";
	var_00[0].bhasgunwhileriding = 0;
	var_00[0].idle = %technical_driver_idle;
	var_00[1].idle = %technical_passenger_idle;
	var_00[0].getout = %pickup_passenger_climb_out;
	var_00[1].getout = %innocent_truck_exit_passenger_fwd;
	var_00[0].getin = %pickup_driver_climb_in;
	var_00[1].getin = %pickup_passenger_climb_in;
	return var_00;
}