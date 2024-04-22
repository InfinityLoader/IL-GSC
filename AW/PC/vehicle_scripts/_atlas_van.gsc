/*******************************************************************
 * Decompiled By: Bog
 * Decompiled File: _atlas_van.gsc
 * Game: Call of Duty: Advanced Warfare
 * Platform: PC
 * Function Count: 5
 * Decompile Time: 87 ms
 * Timestamp: 4/22/2024 2:04:20 AM
*******************************************************************/

//Function Number: 1
main(param_00,param_01,param_02)
{
	maps\_vehicle::build_template("atlas_van",param_00,param_01,param_02);
	maps\_vehicle::build_localinit(::init_local);
	maps\_vehicle::build_deathmodel("vehicle_armored_van","vehicle_civ_workvan_dstrypv");
	maps\_vehicle::build_deathfx("vfx/explosion/vehicle_civ_ai_explo_med_runner","TAG_DEATH_FX","car_explode",undefined,undefined,undefined,0);
	maps\_vehicle::build_light(param_02,"brakelight_set","tag_origin","vfx/lights/veh_ind_van_utility_stop_light","brakelights");
	maps\_vehicle::build_radiusdamage((0,0,32),300,200,100,0);
	maps\_vehicle::build_drive(%uaz_driving_idle_forward,%uaz_driving_idle_backward,10);
	maps\_vehicle::build_deathquake(1,1.6,500);
	maps\_vehicle::build_life(999,5000,6000);
	maps\_vehicle::build_team("axis");
	maps\_vehicle::build_treadfx(param_02,"default","vfx/treadfx/tread_dust_default");
	maps\_vehicle::build_aianims(::setanims,::set_vehicle_anims);
	maps\_vehicle::build_unload_groups(::unload_groups);
}

//Function Number: 2
init_local()
{
	self hidepart("rear_handle_obj_left_jnt");
	self hidepart("rear_handle_obj_right_jnt");
}

//Function Number: 3
set_vehicle_anims(param_00)
{
	param_00[0].vehicle_getoutanim = %russian_swat_van_driver_getout_door;
	param_00[0].vehicle_getoutsoundtag = "front_door_left_jnt";
	param_00[0].vehicle_getoutanim_clear = 1;
	param_00[1].vehicle_getoutanim_clear = 0;
	param_00[2].vehicle_getoutanim_clear = 0;
	param_00[3].vehicle_getoutanim_clear = 0;
	param_00[4].vehicle_getoutanim_clear = 0;
	param_00[5].vehicle_getoutanim_clear = 0;
	param_00[6].vehicle_getoutanim_clear = 0;
	param_00[7].vehicle_getoutanim_clear = 0;
	param_00[8].vehicle_getoutanim_clear = 0;
	return param_00;
}

//Function Number: 4
setanims()
{
	var_00 = [];
	for(var_01 = 0;var_01 < 9;var_01++)
	{
		var_00[var_01] = spawnstruct();
	}

	var_00[0].sittag = "tag_driver";
	var_00[0].idle = %russian_swat_van_driver_idle;
	var_00[0].getout = %russian_swat_van_driver_getout;
	var_00[1].sittag = "tag_detach";
	var_00[1].idle = %humvee_idle_frontl;
	var_00[1].getout = %russian_swat_van_guyl1_getout;
	var_00[1].getout_secondary = %russian_swat_van_guyl_runoff;
	var_00[1].explosion_death = %death_explosion_stand_b_v1;
	var_00[2].sittag = "tag_detach";
	var_00[2].idle = %russian_swat_van_guyr1_idle;
	var_00[2].getout = %russian_swat_van_guyr1_getout;
	var_00[2].getout_secondary = %russian_swat_van_guyr_runoff;
	var_00[2].explosion_death = %death_explosion_stand_b_v2;
	var_00[3].sittag = "tag_detach";
	var_00[3].idle = %russian_swat_van_guyl2_idle;
	var_00[3].getout = %russian_swat_van_guyl2_getout;
	var_00[3].getout_secondary = %russian_swat_van_guyl_runoff;
	var_00[3].explosion_death = %death_explosion_stand_b_v3;
	var_00[4].sittag = "tag_detach";
	var_00[4].idle = %russian_swat_van_guyr2_idle;
	var_00[4].getout = %russian_swat_van_guyr2_getout;
	var_00[4].getout_secondary = %russian_swat_van_guyr_runoff;
	var_00[4].explosion_death = %death_explosion_stand_b_v4;
	var_00[5].sittag = "tag_detach";
	var_00[5].idle = %russian_swat_van_guyl3_idle;
	var_00[5].getout = %russian_swat_van_guyl3_getout;
	var_00[5].getout_secondary = %russian_swat_van_guyl_runoff;
	var_00[5].explosion_death = %death_explosion_stand_b_v2;
	var_00[6].sittag = "tag_detach";
	var_00[6].idle = %russian_swat_van_guyr3_idle;
	var_00[6].getout = %russian_swat_van_guyr3_getout;
	var_00[6].getout_secondary = %russian_swat_van_guyr_runoff;
	var_00[6].explosion_death = %death_explosion_stand_b_v1;
	var_00[7].sittag = "tag_detach";
	var_00[7].idle = %russian_swat_van_guyl4_idle;
	var_00[7].getout = %russian_swat_van_guyl4_getout;
	var_00[7].getout_secondary = %russian_swat_van_guyl_runoff;
	var_00[7].explosion_death = %death_explosion_stand_b_v4;
	var_00[8].sittag = "tag_detach";
	var_00[8].idle = %russian_swat_van_guyr4_idle;
	var_00[8].getout = %russian_swat_van_guyr4_getout;
	var_00[8].getout_secondary = %russian_swat_van_guyr_runoff;
	var_00[8].explosion_death = %death_explosion_stand_b_v3;
	return var_00;
}

//Function Number: 5
unload_groups()
{
	var_00 = [];
	var_00["passengers"] = [];
	var_00["all"] = [];
	var_01 = "passengers";
	var_00[var_01][var_00[var_01].size] = 1;
	var_00[var_01][var_00[var_01].size] = 2;
	var_00[var_01][var_00[var_01].size] = 3;
	var_00[var_01][var_00[var_01].size] = 4;
	var_00[var_01][var_00[var_01].size] = 5;
	var_00[var_01][var_00[var_01].size] = 6;
	var_00[var_01][var_00[var_01].size] = 7;
	var_00[var_01][var_00[var_01].size] = 8;
	var_01 = "all";
	var_00[var_01][var_00[var_01].size] = 0;
	var_00[var_01][var_00[var_01].size] = 1;
	var_00[var_01][var_00[var_01].size] = 2;
	var_00[var_01][var_00[var_01].size] = 3;
	var_00[var_01][var_00[var_01].size] = 4;
	var_00[var_01][var_00[var_01].size] = 5;
	var_00[var_01][var_00[var_01].size] = 6;
	var_00[var_01][var_00[var_01].size] = 7;
	var_00[var_01][var_00[var_01].size] = 8;
	var_00["default"] = var_00["all"];
	return var_00;
}