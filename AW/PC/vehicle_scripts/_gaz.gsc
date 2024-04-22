/*******************************************************************
 * Decompiled By: Bog
 * Decompiled File: _gaz.gsc
 * Game: Call of Duty: Advanced Warfare
 * Platform: PC
 * Function Count: 9
 * Decompile Time: 155 ms
 * Timestamp: 4/22/2024 2:04:50 AM
*******************************************************************/

//Function Number: 1
main(param_00,param_01,param_02)
{
	maps\_vehicle::build_template("gaz_tigr_harbor",param_00,param_01,param_02);
	maps\_vehicle::build_localinit(::init_local);
	maps\_vehicle::build_unload_groups(::unload_groups);
	maps\_vehicle::build_drive(%humvee_50cal_driving_idle_forward,%humvee_50cal_driving_idle_backward,10);
	maps\_vehicle::build_treadfx();
	maps\_vehicle::build_life(999,500,1500);
	maps\_vehicle::build_team("axis");
	if(issubstr(param_02,"turret"))
	{
		maps\_vehicle::build_aianims(::setanims_turret,::set_vehicle_anims_turret);
		if(issubstr(param_02,"_paris") || issubstr(param_02,"_hijack"))
		{
			maps\_vehicle::build_turret("dshk_gaz_damage_player","tag_turret","weapon_dshk_turret",undefined,"auto_ai",0.2,-20,-14);
		}
		else if(issubstr(param_02,"_recovery"))
		{
			maps\_vehicle::build_turret("dshk_gaz_recovery","tag_turret","weapon_dshk_turret",undefined,"auto_ai",0.2,-20,-14);
		}
		else if(issubstr(param_02,"_factory"))
		{
			maps\_vehicle::build_turret("dshk_gaz_factory","tag_turret","weapon_dshk_turret",undefined,"auto_ai",0.2,-20,-14);
		}
		else
		{
			maps\_vehicle::build_turret("dshk_gaz","tag_turret","weapon_dshk_turret",undefined,"auto_ai",0.2,-20,-14);
		}
	}
	else
	{
		maps\_vehicle::build_aianims(::setanims,::set_vehicle_anims);
	}

	if(param_02 == "script_vehicle_gaz_tigr_turret_physics_paris")
	{
	}
	else
	{
		build_gaz_death(param_02);
	}

	maps\_vehicle::build_light(param_02,"running_headlight_L","TAG_HEADLIGHT_LEFT","vfx/lights/headlight_gaz","running",0);
	maps\_vehicle::build_light(param_02,"running_headlight_R","TAG_HEADLIGHT_RIGHT","vfx/lights/headlight_gaz","running",0);
	maps\_vehicle::build_light(param_02,"running_brakelight_L","TAG_BRAKELIGHT_LEFT","vfx/lights/taillight_gaz","running",0);
	maps\_vehicle::build_light(param_02,"running_brakelight_R","TAG_BRAKELIGHT_RIGHT","vfx/lights/taillight_gaz","running",0);
	maps\_vehicle::build_light(param_02,"headlights_headlight_L","TAG_HEADLIGHT_LEFT","vfx/lights/headlight_gaz","headlights",0);
	maps\_vehicle::build_light(param_02,"headlights_headlight_R","TAG_HEADLIGHT_RIGHT","vfx/lights/headlight_gaz","headlights",0);
	maps\_vehicle::build_light(param_02,"headlights_brakelight_L","TAG_BRAKELIGHT_LEFT","vfx/lights/taillight_gaz","headlights",0);
	maps\_vehicle::build_light(param_02,"headlights_brakelight_R","TAG_BRAKELIGHT_RIGHT","vfx/lights/taillight_gaz","headlights",0);
	maps\_vehicle::build_light(param_02,"headlights_cheap_headlight_L_cheap","TAG_HEADLIGHT_LEFT","vfx/lights/headlight_gaz_cheap","headlights_cheap",0);
	maps\_vehicle::build_light(param_02,"headlights_cheap_headlight_R_cheap","TAG_HEADLIGHT_RIGHT","vfx/lights/headlight_gaz_cheap","headlights_cheap",0);
	maps\_vehicle::build_light(param_02,"headlights_cheap_brakelight_L_cheap","TAG_BRAKELIGHT_LEFT","vfx/lights/taillight_gaz_cheap","headlights_cheap",0);
	maps\_vehicle::build_light(param_02,"headlights_cheap_brakelight_R_cheap","TAG_BRAKELIGHT_RIGHT","vfx/lights/taillight_gaz_cheap","headlights_cheap",0);
	maps\_vehicle::build_light(param_02,"taillights_cheap_headlight_L_cheap","TAG_HEADLIGHT_LEFT","vfx/lights/headlight_gaz","taillights_cheap",0);
	maps\_vehicle::build_light(param_02,"taillights_cheap_headlight_R_cheap","TAG_HEADLIGHT_RIGHT","vfx/lights/headlight_gaz","taillights_cheap",0);
	maps\_vehicle::build_light(param_02,"taillights_cheap_brakelight_L_cheap","TAG_BRAKELIGHT_LEFT","vfx/lights/taillight_gaz_cheap","taillights_cheap",0);
	maps\_vehicle::build_light(param_02,"taillights_cheap_brakelight_R_cheap","TAG_BRAKELIGHT_RIGHT","vfx/lights/taillight_gaz_cheap","taillights_cheap",0);
}

//Function Number: 2
init_local()
{
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
build_gaz_death(param_00)
{
	level._effect["gazfire"] = loadfx("vfx/fire/fire_lp_s_no_light");
	level._effect["gazexplode"] = loadfx("vfx/explosion/vehicle_civ_ai_explo_lrg_runner");
	level._effect["gazsmfire"] = loadfx("vfx/fire/fire_lp_xs_no_light");
	maps\_vehicle::build_deathmodel("vehicle_gaz_tigr_harbor","vehicle_gaz_tigr_harbor_destroyed");
	maps\_vehicle::build_deathmodel("vehicle_gaz_tigr_base","vehicle_gaz_tigr_harbor_destroyed");
	maps\_vehicle::build_deathmodel("vehicle_mil_gaz_ai","vehicle_mil_gaz_dstrypv");
	maps\_vehicle::build_deathmodel("vehicle_mil_humvee_north_korean_01_ai","vehicle_gaz_tigr_harbor_destroyed");
	if(param_00 != "script_vehicle_gaz_tigr_cleanup" && param_00 != "script_vehicle_gaz_tigr_cleanup_phys")
	{
		maps\_vehicle::build_deathfx("vfx/explosion/vehicle_civ_ai_explo_lrg_runner","tag_death_fx","veh_gaz_expl_3d");
		maps\_vehicle::build_deathfx("vfx/fire/fire_lp_s_no_light","tag_cab_fx",undefined,undefined,undefined,1,0);
		maps\_vehicle::build_deathfx("vfx/fire/firelp_small","tag_trunk_fx",undefined,undefined,undefined,1,3);
	}

	maps\_vehicle::build_deathquake(1,1.6,500);
	if(param_00 != "script_vehicle_gaz_tigr_turret_physics_factory")
	{
		maps\_vehicle::build_radiusdamage((0,0,32),300,200,0,0);
	}
}

//Function Number: 5
set_vehicle_anims(param_00)
{
	param_00[0].vehicle_getoutanim = %gaz_dismount_frontl_door;
	param_00[1].vehicle_getoutanim = %gaz_dismount_frontr_door;
	param_00[2].vehicle_getoutanim = %gaz_dismount_backl_door;
	param_00[3].vehicle_getoutanim = %gaz_dismount_backr_door;
	param_00[0].vehicle_getinanim = %gaz_mount_frontl_door;
	param_00[1].vehicle_getinanim = %gaz_mount_frontr_door;
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
set_vehicle_anims_turret(param_00)
{
	param_00 = set_vehicle_anims(param_00);
	param_00[3].vehicle_getoutanim = %gaz_turret_getout_gaz;
	return param_00;
}

//Function Number: 7
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
	var_00[0].idle = %gaz_idle_frontl;
	var_00[1].idle = %gaz_idle_frontr;
	var_00[2].idle = %gaz_idle_backl;
	var_00[3].idle = %gaz_idle_backr;
	var_00[0].getout = %gaz_dismount_frontl;
	var_00[1].getout = %gaz_dismount_frontr;
	var_00[2].getout = %gaz_dismount_backl;
	var_00[3].getout = %gaz_dismount_backr;
	var_00[0].getin = %gaz_mount_frontl;
	var_00[1].getin = %gaz_mount_frontr;
	var_00[2].getin = %gaz_enter_backr;
	var_00[3].getin = %gaz_enter_backl;
	var_00[0].death_flop_dir = (0,2500,0);
	var_00[1].death_flop_dir = (0,-2500,0);
	var_00[2].death_flop_dir = (0,2500,0);
	var_00[3].death_flop_dir = (0,-2500,0);
	var_00[0].min_unload_frac_to_flop = undefined;
	var_00[1].min_unload_frac_to_flop = undefined;
	var_00[2].min_unload_frac_to_flop = 0.6;
	var_00[3].min_unload_frac_to_flop = 0.45;
	return var_00;
}

//Function Number: 8
setanims_turret()
{
	var_00 = setanims();
	var_01 = 0;
	foreach(var_03 in var_00)
	{
		if(isdefined(var_03.getout))
		{
			var_04 = getanimlength(var_03.getout);
			if(var_04 > var_01)
			{
				var_01 = var_04;
			}
		}
	}

	var_00[3].mgturret = 0;
	var_00[3].passenger_2_turret_func = ::gaz_turret_guy_gettin_func;
	var_00[3].sittag = "tag_guy_turret";
	var_00[3].getout = %gaz_turret_getout_guy1;
	var_00[3].delay = var_01;
	return var_00;
}

//Function Number: 9
gaz_turret_guy_gettin_func(param_00,param_01,param_02,param_03)
{
}