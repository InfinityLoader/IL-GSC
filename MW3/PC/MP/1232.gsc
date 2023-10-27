/*******************************************************************
 * Decompiled By: Bog
 * Decompiled File: 1232.gsc
 * Game: Call of Duty: Modern Warfare 3
 * Platform: PC
 * Function Count: 4
 * Decompile Time: 0 ms
 * Timestamp: 10/27/2023 2:15:27 AM
*******************************************************************/

//Function Number: 1
main(param_00,param_01,param_02)
{
	maps\_vehicle::build_template("c130",param_00,param_01,param_02);
	maps\_vehicle::build_localinit(::init_local);
	maps\_vehicle::build_deathmodel("vehicle_ac130_low");
	maps\_vehicle::build_deathfx("explosions/large_vehicle_explosion",undefined,"explo_metal_rand");
	maps\_vehicle::build_life(999,500,1500);
	maps\_vehicle::build_team("allies");
	maps\_vehicle::build_mainturret();
	var_03 = maps\_vehicle::get_light_model(param_00,param_02);
	maps\_vehicle::build_light(var_03,"wingtip_green","tag_light_L_wing","misc/aircraft_light_wingtip_green","running",0);
	maps\_vehicle::build_light(var_03,"wingtip_red","tag_light_R_wing","misc/aircraft_light_wingtip_red","running",0.05);
	maps\_vehicle::build_light(var_03,"tail_red","tag_light_tail","misc/aircraft_light_white_blink","running",0.05);
	maps\_vehicle::build_light(var_03,"white_blink","tag_light_belly","misc/aircraft_light_red_blink","running",1);
}

//Function Number: 2
init_local()
{
	maps\_vehicle::lights_on("running");
	self hidepart("tag_25mm");
	self hidepart("tag_40mm");
	self hidepart("tag_105mm");
}

//Function Number: 3
func_3A9C(param_00)
{
	return param_00;
}

//Function Number: 4
func_3A9D()
{
	var_00 = [];
	for(var_01 = 0;var_01 < 1;var_01++)
	{
		var_00[var_01] = spawnstruct();
	}

	return var_00;
}