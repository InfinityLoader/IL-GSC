/*******************************************************************
 * Decompiled By: Bog
 * Decompiled File: _civ_domestic_truck.gsc
 * Game: Call of Duty: Advanced Warfare
 * Platform: PC
 * Function Count: 4
 * Decompile Time: 84 ms
 * Timestamp: 4/22/2024 2:04:39 AM
*******************************************************************/

//Function Number: 1
main(param_00,param_01,param_02)
{
	maps\_vehicle::build_template("civ_domestic_truck",param_00,param_01,param_02);
	maps\_vehicle::build_localinit(::init_local);
	maps\_vehicle::build_drive(%technical_driving_idle_forward,%technical_driving_idle_backward,10);
	maps\_vehicle::build_treadfx(param_02,"default","vfx/treadfx/tread_dust_default");
	maps\_vehicle::build_treadfx_script_model(param_02,"default","vfx/treadfx/tread_dust_van_bright");
	maps\_vehicle::build_life(999,500,1500);
	maps\_vehicle::build_team("allies");
	maps\_vehicle::build_aianims(::setanims,::set_vehicle_anims);
	maps\_vehicle::build_deathmodel("vehicle_civ_domestic_truck","vehicle_civ_domestic_truck_dstrypv",0);
	maps\_vehicle::build_deathmodel("vehicle_civ_domestic_truck_blue","vehicle_civ_domestic_truck_dstrypv",0);
	maps\_vehicle::build_deathmodel("vehicle_civ_domestic_truck_gold","vehicle_civ_domestic_truck_dstrypv",0);
	maps\_vehicle::build_deathmodel("vehicle_civ_domestic_truck_grn","vehicle_civ_domestic_truck_dstrypv",0);
	maps\_vehicle::build_deathmodel("vehicle_civ_domestic_truck_slvr","vehicle_civ_domestic_truck_dstrypv",0);
	maps\_vehicle::build_deathfx("vfx/explosion/vehicle_civ_ai_explo_med_runner","TAG_DEATH_FX","lag_rndabt_car_large_explo",undefined,undefined,undefined,0);
}

//Function Number: 2
init_local()
{
	soundscripts\_snd::snd_message("civ_domestic_truck_spawn",self);
	soundscripts\_snd::snd_message("atlas_van_explode");
}

//Function Number: 3
set_vehicle_anims(param_00)
{
	return param_00;
}

//Function Number: 4
setanims()
{
	var_00 = [];
	for(var_01 = 0;var_01 < 2;var_01++)
	{
		var_00[var_01] = spawnstruct();
	}

	var_00[0].sittag = "tag_driver";
	var_00[1].sittag = "tag_passenger";
	var_00[0].idle = %civ_domestic_truck_driver_idle;
	var_00[1].idle = %civ_domestic_truck_passenger_idle;
	return var_00;
}