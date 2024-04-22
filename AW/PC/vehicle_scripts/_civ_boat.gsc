/*******************************************************************
 * Decompiled By: Bog
 * Decompiled File: _civ_boat.gsc
 * Game: Call of Duty: Advanced Warfare
 * Platform: PC
 * Function Count: 4
 * Decompile Time: 71 ms
 * Timestamp: 4/22/2024 2:04:34 AM
*******************************************************************/

//Function Number: 1
main(param_00,param_01,param_02)
{
	maps\_vehicle::build_template("civ_domestic_boat",param_00,param_01,param_02);
	maps\_vehicle::build_localinit(::init_local);
	maps\_vehicle::build_deathfx("vfx/explosion/vehicle_civ_boat_explosion",undefined,"explo_metal_rand");
	maps\_vehicle::build_life(999,500,1500);
	maps\_vehicle::build_team("allies");
	maps\_vehicle::build_aianims(::setanims,::set_vehicle_anims);
}

//Function Number: 2
init_local()
{
	soundscripts\_snd::snd_message("civ_boat_spawn",self);
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
	var_00[0].idle = %humvee_idle_frontl;
	var_00[1].sittag = "tag_passenger";
	var_00[1].idle = %humvee_idle_frontr;
	return var_00;
}