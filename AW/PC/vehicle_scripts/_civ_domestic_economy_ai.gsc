/*******************************************************************
 * Decompiled By: Bog
 * Decompiled File: _civ_domestic_economy_ai.gsc
 * Game: Call of Duty: Advanced Warfare
 * Platform: PC
 * Function Count: 4
 * Decompile Time: 81 ms
 * Timestamp: 4/22/2024 2:04:35 AM
*******************************************************************/

//Function Number: 1
main(param_00,param_01,param_02)
{
	maps\_vehicle::build_template("civ_domestic_economy_ai",param_00,param_01,param_02);
	maps\_vehicle::build_localinit(::init_local);
	maps\_vehicle::build_drive(%technical_driving_idle_forward,%technical_driving_idle_backward,10);
	maps\_vehicle::build_treadfx(param_02,"default","vfx/treadfx/tread_dust_default");
	maps\_vehicle::build_treadfx_script_model(param_02,"default","vfx/treadfx/tread_dust_sedan_bright");
	maps\_vehicle::build_life(999,500,1500);
	maps\_vehicle::build_team("allies");
	maps\_vehicle::build_aianims(::setanims,::set_vehicle_anims);
	maps\_vehicle::build_light(param_02,"headlight_set","tag_origin","vfx/lights/veh_compact_head_light","headlights");
	maps\_vehicle::build_light(param_02,"taillight_scroll_right","tag_brakelight_right","vfx/lights/veh_compact_signal_light_back_rt","taillights");
	maps\_vehicle::build_light(param_02,"taillight_scroll_left","tag_brakelight_left","vfx/lights/veh_compact_signal_light_back_lt","taillights");
	maps\_vehicle::build_light(param_02,"frontsignal_right","tag_headlight_right","vfx/lights/veh_compact_signal_light_front_rt","taillights");
	maps\_vehicle::build_light(param_02,"frontsignal_left","tag_headlight_left","vfx/lights/veh_compact_signal_light_front_lt","taillights");
	maps\_vehicle::build_light(param_02,"brakelight_set","tag_origin","vfx/lights/veh_compact_stop_light","brakelights");
	maps\_vehicle::build_deathmodel("vehicle_civ_domestic_economy_ai","vehicle_civ_domestic_economy_dstrypv",0);
	maps\_vehicle::build_deathmodel("vehicle_civ_domestic_economy_clr02_ai","vehicle_civ_domestic_economy_dstrypv",0);
	maps\_vehicle::build_deathmodel("vehicle_civ_domestic_economy_clr03_ai","vehicle_civ_domestic_economy_dstrypv",0);
	maps\_vehicle::build_deathmodel("vehicle_civ_domestic_economy_clr04_ai","vehicle_civ_domestic_economy_dstrypv",0);
	maps\_vehicle::build_deathmodel("vehicle_civ_domestic_economy_clr05_ai","vehicle_civ_domestic_economy_dstrypv",0);
	maps\_vehicle::build_deathmodel("vehicle_civ_domestic_economy_clr06_ai","vehicle_civ_domestic_economy_dstrypv",0);
	maps\_vehicle::build_deathfx("vfx/explosion/vehicle_civ_ai_explo_small_runner","TAG_DEATH_FX","lag_rndabt_car_small_explo",undefined,undefined,undefined,0);
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
	var_00[0].idle = %humvee_idle_frontl;
	return var_00;
}