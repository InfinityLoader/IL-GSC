/*******************************************************************
 * Decompiled By: Bog
 * Decompiled File: _civ_domestic_bus.gsc
 * Game: Call of Duty: Advanced Warfare
 * Platform: PC
 * Function Count: 4
 * Decompile Time: 81 ms
 * Timestamp: 4/22/2024 2:04:35 AM
*******************************************************************/

//Function Number: 1
main(param_00,param_01,param_02)
{
	maps\_vehicle::build_template("civ_domestic_bus",param_00,param_01,param_02);
	maps\_vehicle::build_localinit(::init_local);
	maps\_vehicle::build_drive(%civ_domestic_bus_driving_idle_forward,%civ_domestic_bus_driving_idle_backward,10);
	maps\_vehicle::build_treadfx(param_02,"default","vfx/treadfx/tread_dust_default");
	maps\_vehicle::build_treadfx_script_model(param_02,"default","vfx/treadfx/tread_dust_van_bright");
	maps\_vehicle::build_life(999,500,1500);
	maps\_vehicle::build_team("allies");
	maps\_vehicle::build_aianims(::setanims,::set_vehicle_anims);
	maps\_vehicle::build_light(param_02,"headlight_left","tag_headlight_left","vfx/lights/veh_default_front_signal_light_l","headlights");
	maps\_vehicle::build_light(param_02,"headlight_right","tag_headlight_right","vfx/lights/veh_default_front_signal_light_r","headlights");
	maps\_vehicle::build_light(param_02,"taillight_right","tag_brakelight_right","vfx/lights/veh_default_tail_light_r","taillights");
	maps\_vehicle::build_light(param_02,"taillight_left","tag_brakelight_left","vfx/lights/veh_default_tail_light_l","taillights");
	maps\_vehicle::build_light(param_02,"brakelight_set","tag_origin","vfx/lights/veh_civ_domestic_bus_stop_light","brakelights");
	maps\_vehicle::build_deathfx("vfx/explosion/vehicle_generic_ai_explo_lrg_runner","TAG_DEATH_FX","lag_rndabt_car_large_explo",undefined,undefined,undefined,0);
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
	for(var_01 = 0;var_01 < 2;var_01++)
	{
		var_00[var_01] = spawnstruct();
	}

	var_00[0].sittag = "tag_driver";
	var_00[1].sittag = "tag_passenger";
	var_00[0].idle = %gaz_idle_frontl;
	var_00[1].idle = %gaz_idle_frontr;
	return var_00;
}