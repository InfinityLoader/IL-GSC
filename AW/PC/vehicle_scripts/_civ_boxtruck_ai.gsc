/*******************************************************************
 * Decompiled By: Bog
 * Decompiled File: _civ_boxtruck_ai.gsc
 * Game: Call of Duty: Advanced Warfare
 * Platform: PC
 * Function Count: 4
 * Decompile Time: 66 ms
 * Timestamp: 4/22/2024 2:04:34 AM
*******************************************************************/

//Function Number: 1
main(param_00,param_01,param_02)
{
	maps\_vehicle::build_template("civ_boxtruck_ai",param_00,param_01,param_02);
	maps\_vehicle::build_localinit(::init_local);
	maps\_vehicle::build_drive(%technical_driving_idle_forward,%technical_driving_idle_backward,10);
	maps\_vehicle::build_treadfx(param_02,"default","vfx/treadfx/tread_dust_default");
	maps\_vehicle::build_life(999,500,1500);
	maps\_vehicle::build_team("axis");
	maps\_vehicle::build_deathmodel("vehicle_civ_boxtruck_ai","vehicle_civ_boxtruck_dstrypv",0);
	maps\_vehicle::build_deathfx("vfx/explosion/vehicle_civ_ai_explo_lrg_runner","TAG_DEATH_FX","lag_rndabt_car_large_explo",undefined,undefined,undefined,0);
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
	var_00[0].idle = %civ_workvan_driver_idle;
	return var_00;
}