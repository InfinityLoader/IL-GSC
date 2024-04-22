/*******************************************************************
 * Decompiled By: Bog
 * Decompiled File: _generic_script_model_lagos.gsc
 * Game: Call of Duty: Advanced Warfare
 * Platform: PC
 * Function Count: 4
 * Decompile Time: 67 ms
 * Timestamp: 4/22/2024 2:04:52 AM
*******************************************************************/

//Function Number: 1
main(param_00,param_01,param_02)
{
	maps\_vehicle::build_template("script_model",param_00,param_01,param_02);
	maps\_vehicle::build_life(999,500,1500);
	maps\_vehicle::build_deathmodel("ac_prs_veh_civ_car_a_1","ac_prs_veh_civ_car_a_dam1",0);
	maps\_vehicle::build_deathmodel("ac_prs_veh_civ_car_a_2","ac_prs_veh_civ_car_a_dam2",0);
	maps\_vehicle::build_deathmodel("ac_prs_veh_civ_car_a_3","ac_prs_veh_civ_car_a_dam3",0);
	maps\_vehicle::build_deathmodel("ac_prs_veh_civ_car_a_4","ac_prs_veh_civ_car_a_dam4",0);
	maps\_vehicle::build_deathmodel("ac_prs_veh_civ_car_a_5","ac_prs_veh_civ_car_a_dam5",0);
	maps\_vehicle::build_deathmodel("ac_prs_veh_civ_car_a_6","ac_prs_veh_civ_car_a_dam6",0);
	maps\_vehicle::build_deathmodel("ac_prs_veh_civ_car_a_7","ac_prs_veh_civ_car_a_dam7",0);
	maps\_vehicle::build_deathfx_generic_script_model("vfx/explosion/vehicle_civ_ai_explo_small_runner","TAG_ORIGIN","lag_rndabt_car_small_explo",undefined,undefined,undefined,0);
}

//Function Number: 2
init_local()
{
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
	for(var_01 = 0;var_01 < 1;var_01++)
	{
		var_00[var_01] = spawnstruct();
	}

	var_00[0].sittag = "tag_driver";
	var_00[0].idle = %civ_domestic_smartcar_driver_idle;
	return var_00;
}