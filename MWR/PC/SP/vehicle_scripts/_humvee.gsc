/*******************************************************************
 * Decompiled By: Bog
 * Decompiled File: vehicle_scripts\_humvee.gsc
 * Game: Call of Duty: Modern Warfare Remastered
 * Platform: PC
 * Function Count: 4
 * Decompile Time: 73 ms
 * Timestamp: 10/27/2023 2:46:18 AM
*******************************************************************/

//Function Number: 1
main(param_00,param_01,param_02)
{
	maps\_vehicle::build_template("humvee",param_00,param_01,param_02);
	maps\_vehicle::build_localinit(::init_local);
	maps\_vehicle::build_deathmodel("vehicle_humvee_camo");
	maps\_vehicle::build_deathmodel("vehicle_humvee_camo_50cal_doors");
	maps\_vehicle::build_deathmodel("vehicle_humvee_camo_50cal_nodoors");
	maps\_vehicle::build_deathfx("fx/explosions/large_vehicle_explosion",undefined,"car_explode");
	maps\_vehicle::build_treadfx();
	maps\_vehicle::build_life(999,500,1500);
	maps\_vehicle::build_team("allies");
	maps\_vehicle::build_aianims(::setanims,::set_vehicle_anims);
}

//Function Number: 2
init_local()
{
}

//Function Number: 3
set_vehicle_anims(param_00)
{
	param_00[0].vehicle_getoutanim = %uaz_driver_exit_into_run_door;
	param_00[1].vehicle_getoutanim = %uaz_rear_driver_exit_into_run_door;
	param_00[2].vehicle_getoutanim = %uaz_passenger_exit_into_run_door;
	param_00[3].vehicle_getoutanim = %uaz_passenger2_exit_into_run_door;
	param_00[0].vehicle_getinanim = %uaz_driver_enter_from_huntedrun_door;
	param_00[1].vehicle_getinanim = %uaz_rear_driver_enter_from_huntedrun_door;
	param_00[2].vehicle_getinanim = %uaz_passenger_enter_from_huntedrun_door;
	param_00[3].vehicle_getinanim = %uaz_passenger2_enter_from_huntedrun_door;
	return param_00;
}

//Function Number: 4
setanims()
{
	var_00 = [];
	for(var_01 = 0;var_01 < 4;var_01++)
	{
		var_00[var_01] = spawnstruct();
	}

	var_00[0].sittag = "body_animate_jnt";
	var_00[1].sittag = "body_animate_jnt";
	var_00[2].sittag = "tag_passenger";
	var_00[3].sittag = "body_animate_jnt";
	var_00[0].idle = %humvee_driver_climb_idle;
	var_00[1].idle = %humvee_passenger_idle_l;
	var_00[2].idle = %humvee_passenger_idle_r;
	var_00[3].idle = %humvee_passenger_idle_r;
	var_00[0].getout = %humvee_driver_climb_out;
	var_00[1].getout = %humvee_passenger_out_l;
	var_00[2].getout = %humvee_passenger_out_r;
	var_00[3].getout = %humvee_passenger_out_r;
	var_00[0].getin = %humvee_driver_climb_in;
	var_00[1].getin = %humvee_passenger_in_l;
	var_00[2].getin = %humvee_passenger_in_r;
	var_00[3].getin = %humvee_passenger_in_r;
	return var_00;
}