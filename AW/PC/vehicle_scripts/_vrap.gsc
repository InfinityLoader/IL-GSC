/*******************************************************************
 * Decompiled By: Bog
 * Decompiled File: _vrap.gsc
 * Game: Call of Duty: Advanced Warfare
 * Platform: PC
 * Function Count: 8
 * Decompile Time: 140 ms
 * Timestamp: 4/22/2024 2:05:39 AM
*******************************************************************/

//Function Number: 1
main(param_00,param_01,param_02)
{
	maps\_vehicle::build_template("vrap_base",param_00,param_01,param_02);
	maps\_vehicle::build_localinit(::init_local);
	maps\_vehicle::build_unload_groups(::unload_groups);
	maps\_vehicle::build_drive(%humvee_50cal_driving_idle_forward,%humvee_50cal_driving_idle_backward,10);
	maps\_vehicle::build_treadfx();
	maps\_vehicle::build_life(999,500,1500);
	maps\_vehicle::build_team("axis");
	if(issubstr(param_02,"turret"))
	{
		maps\_vehicle::build_aianims(::setanims_turret,::set_vehicle_anims);
		maps\_vehicle::build_turret("vrap_turret","tag_turret","weapon_vrap_turret",undefined,"auto_nonai",0.2,10,-14);
	}
	else
	{
		maps\_vehicle::build_aianims(::setanims,::set_vehicle_anims);
	}

	build_vrap_death(param_02);
	maps\_vehicle::build_light(param_02,"headlight_L","TAG_HEADLIGHT_LEFT","vfx/lights/headlight_gaz_bright","running",0);
	maps\_vehicle::build_light(param_02,"headlight_R","TAG_HEADLIGHT_RIGHT","vfx/lights/headlight_gaz_bright","running",0);
	maps\_vehicle::build_light(param_02,"brakelight_L","TAG_BRAKELIGHT_LEFT","vfx/lights/taillight_gaz","running",0);
	maps\_vehicle::build_light(param_02,"brakelight_R","TAG_BRAKELIGHT_RIGHT","vfx/lights/taillight_gaz","running",0);
	maps\_vehicle::build_light(param_02,"headlight_L","TAG_HEADLIGHT_LEFT","vfx/lights/headlight_gaz_bright","headlights",0);
	maps\_vehicle::build_light(param_02,"headlight_R","TAG_HEADLIGHT_RIGHT","vfx/lights/headlight_gaz_bright","headlights",0);
	maps\_vehicle::build_light(param_02,"brakelight_L","TAG_BRAKELIGHT_LEFT","vfx/lights/taillight_gaz","headlights",0);
	maps\_vehicle::build_light(param_02,"brakelight_R","TAG_BRAKELIGHT_RIGHT","vfx/lights/taillight_gaz","headlights",0);
	maps\_vehicle::build_deathfx("vfx/explosion/vehicle_civ_ai_explo_lrg_runner","TAG_DEATH_FX");
}

//Function Number: 2
init_local()
{
	soundscripts\_snd::snd_message("vrap_spawn",self);
	soundscripts\_snd::snd_message("vrap_explode");
	self.playermech_rocket_targeting_allowed = 1;
}

//Function Number: 3
unload_groups()
{
	var_00 = [];
	var_01 = "passengers";
	var_00[var_01] = [];
	var_00[var_01][var_00[var_01].size] = 1;
	var_00[var_01][var_00[var_01].size] = 2;
	var_00[var_01][var_00[var_01].size] = 3;
	var_01 = "all_but_gunner";
	var_00[var_01] = [];
	var_00[var_01][var_00[var_01].size] = 0;
	var_00[var_01][var_00[var_01].size] = 1;
	var_00[var_01][var_00[var_01].size] = 2;
	var_01 = "rear_driver_side";
	var_00[var_01] = [];
	var_00[var_01][var_00[var_01].size] = 2;
	var_01 = "all";
	var_00[var_01] = [];
	var_00[var_01][var_00[var_01].size] = 0;
	var_00[var_01][var_00[var_01].size] = 1;
	var_00[var_01][var_00[var_01].size] = 2;
	var_00[var_01][var_00[var_01].size] = 3;
	var_00["default"] = var_00["all"];
	return var_00;
}

//Function Number: 4
build_vrap_death(param_00)
{
	maps\_vehicle::build_deathmodel("vehicle_mil_humvee","vehicle_atlas_humvee_dstrypv");
	maps\_vehicle::build_deathquake(1,1.6,500);
	maps\_vehicle::build_radiusdamage((0,0,32),300,200,0,0);
}

//Function Number: 5
set_vehicle_anims(param_00)
{
	param_00[0].vehicle_getoutanim = %mil_humvee_vrap_driver_out_door;
	param_00[1].vehicle_getoutanim = %mil_humvee_vrap_passenger_out_door;
	param_00[2].vehicle_getoutanim = %gaz_dismount_backl_door;
	param_00[3].vehicle_getoutanim = %gaz_dismount_backr_door;
	param_00[0].vehicle_getinanim = %mil_humvee_vrap_driver_in_m_door;
	param_00[1].vehicle_getinanim = %mil_humvee_vrap_passenger_in_m_door;
	param_00[2].vehicle_getinanim = %gaz_enter_back_door;
	param_00[3].vehicle_getinanim = %gaz_enter_back_door;
	param_00[0].vehicle_getoutsound = "gaz_door_open";
	param_00[1].vehicle_getoutsound = "gaz_door_open";
	param_00[2].vehicle_getoutsound = "gaz_door_open";
	param_00[3].vehicle_getoutsound = "gaz_door_open";
	param_00[0].vehicle_getinsound = "gaz_door_close";
	param_00[1].vehicle_getinsound = "gaz_door_close";
	param_00[2].vehicle_getinsound = "gaz_door_close";
	param_00[3].vehicle_getinsound = "gaz_door_close";
	return param_00;
}

//Function Number: 6
setanims()
{
	var_00 = [];
	for(var_01 = 0;var_01 < 4;var_01++)
	{
		var_00[var_01] = spawnstruct();
	}

	var_00[0].sittag = "tag_driver";
	var_00[1].sittag = "tag_passenger";
	var_00[2].sittag = "tag_guy0";
	var_00[3].sittag = "tag_guy1";
	var_00[0].bhasgunwhileriding = 0;
	var_00[0].death = %gaz_dismount_frontl;
	var_00[0].death_delayed_ragdoll = 3;
	var_00[0].idle = %mil_humvee_vrap_driver_idle;
	var_00[1].idle = %mil_humvee_vrap_passenger_idle;
	var_00[2].idle = %gaz_idle_backl;
	var_00[3].idle = %gaz_idle_backr;
	var_00[0].getout = %mil_humvee_vrap_driver_out;
	var_00[1].getout = %mil_humvee_vrap_passenger_out;
	var_00[2].getout = %gaz_dismount_backl;
	var_00[3].getout = %gaz_dismount_backr;
	var_00[0].getin = %mil_humvee_vrap_driver_in_m;
	var_00[1].getin = %mil_humvee_vrap_passenger_in_m;
	var_00[2].getin = %gaz_enter_backr;
	var_00[3].getin = %gaz_enter_backl;
	var_00[0].death_flop_dir = (0,2500,0);
	var_00[1].death_flop_dir = (0,-2500,0);
	var_00[2].death_flop_dir = (-2500,0,0);
	var_00[3].death_flop_dir = (-2500,0,0);
	var_00[0].min_unload_frac_to_flop = undefined;
	var_00[1].min_unload_frac_to_flop = undefined;
	var_00[2].min_unload_frac_to_flop = 0.6;
	var_00[3].min_unload_frac_to_flop = 0.45;
	return var_00;
}

//Function Number: 7
setanims_turret()
{
	var_00 = setanims();
	var_00[3].mgturret = 0;
	var_00[3].passenger_2_turret_func = ::gaz_turret_guy_gettin_func;
	var_00[3].sittag = "tag_guy_turret";
	return var_00;
}

//Function Number: 8
gaz_turret_guy_gettin_func(param_00,param_01,param_02,param_03)
{
}