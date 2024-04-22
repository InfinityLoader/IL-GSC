/*******************************************************************
 * Decompiled By: Bog
 * Decompiled File: _ind_semi_truck_fuel_tanker.gsc
 * Game: Call of Duty: Advanced Warfare
 * Platform: PC
 * Function Count: 4
 * Decompile Time: 67 ms
 * Timestamp: 4/22/2024 2:04:58 AM
*******************************************************************/

//Function Number: 1
main(param_00,param_01,param_02)
{
	maps\_vehicle::build_template("ind_semi_truck_fuel_tanker",param_00,param_01,param_02);
	maps\_vehicle::build_localinit(::init_local);
	maps\_vehicle::build_drive(%technical_driving_idle_forward,%technical_driving_idle_backward,10);
	maps\_vehicle::build_treadfx(param_02,"default","vfx/treadfx/tread_dust_default");
	maps\_vehicle::build_life(999,500,1500);
	maps\_vehicle::build_team("allies");
	maps\_vehicle::build_aianims(::setanims,::set_vehicle_anims);
	maps\_vehicle::build_light(param_02,"headlight_left","tag_headlight_left","vfx/lights/veh_default_front_signal_light_l","headlights");
	maps\_vehicle::build_light(param_02,"headlight_right","tag_headlight_right","vfx/lights/veh_default_front_signal_light_r","headlights");
	maps\_vehicle::build_light(param_02,"taillight_right","tag_brakelight_right","vfx/lights/veh_default_tail_light_r","taillights");
	maps\_vehicle::build_light(param_02,"taillight_left","tag_brakelight_left","vfx/lights/veh_default_tail_light_l","taillights");
	maps\_vehicle::build_deathfx("vfx/explosion/vehicle_generic_ai_explo_lrg_runner","TAG_DEATH_FX",undefined,undefined,undefined,undefined,0);
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
	return var_00;
	return var_00;
}