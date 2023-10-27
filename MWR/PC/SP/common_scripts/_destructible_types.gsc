/*******************************************************************
 * Decompiled By: Bog
 * Decompiled File: common_scripts\_destructible_types.gsc
 * Game: Call of Duty: Modern Warfare Remastered
 * Platform: PC
 * Function Count: 33
 * Decompile Time: 581 ms
 * Timestamp: 10/27/2023 2:45:28 AM
*******************************************************************/

//Function Number: 1
maketype(param_00)
{
	var_01 = getinfoindex(param_00);
	if(var_01 >= 0)
	{
		return var_01;
	}

	switch(param_00)
	{
		case "vehicle_80s_sedan1_green":
			break;

		case "vehicle_80s_sedan1_red":
			break;

		case "vehicle_80s_sedan1_silv":
			break;

		case "vehicle_80s_sedan1_tan":
			break;

		case "vehicle_80s_sedan1_yel":
			break;

		case "vehicle_80s_sedan1_brn":
			break;

		case "vehicle_80s_sedan1_green_side":
			break;

		case "vehicle_80s_sedan1_red_side":
			break;

		case "vehicle_80s_sedan1_silv_side":
			break;

		case "vehicle_80s_sedan1_tan_side":
			break;

		case "vehicle_80s_sedan1_yel_side":
			break;

		case "vehicle_80s_sedan1_brn_side":
			break;

		case "vehicle_bus_destructible":
			break;

		case "vehicle_80s_wagon1_green":
			break;

		case "vehicle_80s_wagon1_red":
			break;

		case "vehicle_80s_wagon1_silv":
			break;

		case "vehicle_80s_wagon1_tan":
			break;

		case "vehicle_80s_wagon1_yel":
			break;

		case "vehicle_80s_wagon1_brn":
			break;

		case "vehicle_80s_wagon1_decayed_green":
			break;

		case "vehicle_80s_wagon1_decayed_red":
			break;

		case "vehicle_80s_wagon1_decayed_silv":
			break;

		case "vehicle_80s_wagon1_decayed_white":
			break;

		case "vehicle_80s_wagon1_decayed_yel":
			break;

		case "vehicle_80s_wagon1_decayed_brn":
			break;

		case "vehicle_80s_hatch1_green":
			break;

		case "vehicle_80s_hatch1_red":
			break;

		case "vehicle_80s_hatch1_silv":
			break;

		case "vehicle_80s_hatch1_tan":
			break;

		case "vehicle_80s_hatch1_yel":
			break;

		case "vehicle_80s_hatch1_brn":
			break;

		case "vehicle_80s_hatch1_decayed_green":
			break;

		case "vehicle_80s_hatch1_decayed_red":
			break;

		case "vehicle_80s_hatch1_decayed_silv":
			break;

		case "vehicle_80s_hatch1_decayed_white":
			break;

		case "vehicle_80s_hatch1_decayed_yel":
			break;

		case "vehicle_80s_hatch1_decayed_brn":
			break;

		case "vehicle_80s_hatch2_green":
			break;

		case "vehicle_80s_hatch2_red":
			break;

		case "vehicle_80s_hatch2_silv":
			break;

		case "vehicle_80s_hatch2_tan":
			break;

		case "vehicle_80s_hatch2_yel":
			break;

		case "vehicle_80s_hatch2_brn":
			break;

		case "vehicle_small_wagon_blue":
			break;

		case "vehicle_small_wagon_green":
			break;

		case "vehicle_small_wagon_turq":
			break;

		case "vehicle_small_wagon_white":
			break;

		case "vehicle_small_hatch_blue":
			break;

		case "vehicle_small_hatch_green":
			break;

		case "vehicle_small_hatch_turq":
			break;

		case "vehicle_small_hatch_white":
			break;

		case "vehicle_bm21_cover":
			break;

		case "vehicle_bm21_cover_under":
			break;

		case "vehicle_bm21_mobile_bed":
			break;

		case "vehicle_bm21_bed_under":
			break;

		case "vehicle_uaz_fabric":
			break;

		case "vehicle_uaz_open":
			break;

		case "vehicle_uaz_light":
			break;

		case "vehicle_uaz_hardtop":
			break;

		case "vehicle_pickup":
			break;

		case "vehicle_80s_hatch1_thermal":
			break;

		case "vehicle_80s_hatch2_thermal":
			break;

		case "vehicle_80s_sedan1_thermal":
			break;

		case "vehicle_80s_wagon1_thermal":
			break;

		case "vehicle_luxurysedan_thermal":
			break;

		case "vehicle_small_hatch_thermal":
			break;

		case "vehicle_80s_hatch1_lowres_brn":
			break;

		case "vehicle_80s_hatch2_lowres_green":
			break;

		case "vehicle_small_hatchback_lowres_turq":
			break;

		case "vehicle_80s_sedan1_lowres_red":
			break;

		case "vehicle_80s_sedan1_lowres_green":
			break;

		case "vehicle_80s_wagon1_lowres_silv":
			break;

		case "vehicle_luxurysedan_lowres":
			break;

		case "vehicle_tanker_truck":
			break;

		case "vehicle_80s_sedan1_silv_nofire":
			break;

		case "vehicle_80s_sedan1_tan_nofire":
			break;

		case "vehicle_80s_wagon1_red_nofire":
			break;

		default:
			break;
	}
}

//Function Number: 2
getinfoindex(param_00)
{
	if(!isdefined(level.destructible_type))
	{
		return -1;
	}

	if(level.destructible_type.size == 0)
	{
		return -1;
	}

	for(var_01 = 0;var_01 < level.destructible_type.size;var_01++)
	{
		if(param_00 == level.destructible_type[var_01].v["type"])
		{
			return var_01;
		}
	}

	return -1;
}

//Function Number: 3
vehicle_80s_sedan1(param_00)
{
	common_scripts\_destructible::destructible_create("vehicle_80s_sedan1_" + param_00,300,undefined,32,"no_melee");
	common_scripts\_destructible::destructible_loopfx("tag_hood_fx","fx/smoke/car_damage_whitesmoke",0.4);
	common_scripts\_destructible::destructible_state(undefined,"vehicle_80s_sedan1_" + param_00 + "_destructible",200,undefined,32,"no_melee");
	common_scripts\_destructible::destructible_loopfx("tag_hood_fx","fx/smoke/car_damage_blacksmoke",0.4);
	common_scripts\_destructible::destructible_state(undefined,"vehicle_80s_sedan1_" + param_00 + "_destructible",100,undefined,32,"no_melee");
	common_scripts\_destructible::destructible_loopfx("tag_hood_fx","fx/smoke/car_damage_blacksmoke_fire",0.4);
	common_scripts\_destructible::destructible_sound("fire_vehicle_flareup_med");
	common_scripts\_destructible::destructible_loopsound("fire_vehicle_med");
	common_scripts\_destructible::destructible_healthdrain(12,0.2,210,"allies");
	common_scripts\_destructible::destructible_state(undefined,"vehicle_80s_sedan1_" + param_00 + "_destructible",300,"player_only",32,"no_melee");
	common_scripts\_destructible::destructible_loopsound("fire_vehicle_med");
	common_scripts\_destructible::destructible_state(undefined,"vehicle_80s_sedan1_" + param_00 + "_destructible",400,undefined,32,"no_melee");
	common_scripts\_destructible::destructible_fx("tag_death_fx","fx/explosions/small_vehicle_explosion",0);
	common_scripts\_destructible::destructible_sound("car_explode");
	common_scripts\_destructible::destructible_sound("fire_vehicle_small");
	common_scripts\_destructible::destructible_explode(4000,5000,200,150,300);
	common_scripts\_destructible::destructible_anim(%vehicle_80s_sedan1_destroy,#animtree,"setanimknob");
	common_scripts\_destructible::destructible_state(undefined,"vehicle_80s_sedan1_" + param_00 + "_destroyed",undefined,32,"no_melee");
	var_01 = "tag_hood";
	common_scripts\_destructible::destructible_part(var_01,"vehicle_80s_sedan1_" + param_00 + "_hood",800,undefined,undefined,undefined,1,2.5);
	common_scripts\_destructible::destructible_state(var_01,"vehicle_80s_sedan1_" + param_00 + "_hood_dam");
	var_01 = "tag_trunk";
	common_scripts\_destructible::destructible_part(var_01,"vehicle_80s_sedan1_" + param_00 + "_trunk",1000,undefined,undefined,undefined,1);
	common_scripts\_destructible::destructible_state(var_01,"vehicle_80s_sedan1_" + param_00 + "_trunk_dam",2000);
	common_scripts\_destructible::destructible_part("left_wheel_01_jnt","vehicle_80s_sedan1_" + param_00 + "_wheel_LF",20,undefined,undefined,"no_melee",undefined,0,undefined,1);
	common_scripts\_destructible::destructible_anim(%vehicle_80s_sedan1_flattire_lf,#animtree,"setanim");
	common_scripts\_destructible::destructible_anim(%vehicle_80s_sedan1_flattire_tire,#animtree,"setanim",1);
	common_scripts\_destructible::destructible_sound("veh_tire_deflate","bullet");
	common_scripts\_destructible::destructible_part("left_wheel_02_jnt","vehicle_80s_sedan1_" + param_00 + "_wheel_LF",20,undefined,undefined,"no_melee",undefined,0,undefined,1);
	common_scripts\_destructible::destructible_anim(%vehicle_80s_sedan1_flattire_lb,#animtree,"setanim");
	common_scripts\_destructible::destructible_anim(%vehicle_80s_sedan1_flattire_tire,#animtree,"setanim",1);
	common_scripts\_destructible::destructible_sound("veh_tire_deflate","bullet");
	common_scripts\_destructible::destructible_part("right_wheel_01_jnt","vehicle_80s_sedan1_" + param_00 + "_wheel_LF",20,undefined,undefined,"no_melee",undefined,1.7,undefined,1);
	common_scripts\_destructible::destructible_anim(%vehicle_80s_sedan1_flattire_rf,#animtree,"setanim");
	common_scripts\_destructible::destructible_anim(%vehicle_80s_sedan1_flattire_tire,#animtree,"setanim",1);
	common_scripts\_destructible::destructible_sound("veh_tire_deflate","bullet");
	common_scripts\_destructible::destructible_part("right_wheel_02_jnt","vehicle_80s_sedan1_" + param_00 + "_wheel_LF",20,undefined,undefined,"no_melee",undefined,2.3,undefined,1);
	common_scripts\_destructible::destructible_anim(%vehicle_80s_sedan1_flattire_rb,#animtree,"setanim");
	common_scripts\_destructible::destructible_anim(%vehicle_80s_sedan1_flattire_tire,#animtree,"setanim",1);
	common_scripts\_destructible::destructible_sound("veh_tire_deflate","bullet");
	common_scripts\_destructible::destructible_part("tag_door_left_front","vehicle_80s_sedan1_" + param_00 + "_door_LF",undefined,undefined,undefined,undefined,1);
	common_scripts\_destructible::destructible_part("tag_door_left_back","vehicle_80s_sedan1_" + param_00 + "_door_LB",undefined,undefined,undefined,undefined,1);
	common_scripts\_destructible::destructible_part("tag_door_right_front","vehicle_80s_sedan1_" + param_00 + "_door_RF",undefined,undefined,undefined,undefined,1,1);
	common_scripts\_destructible::destructible_part("tag_door_right_back","vehicle_80s_sedan1_" + param_00 + "_door_RB",undefined,undefined,undefined,undefined,1,1);
	var_01 = "tag_glass_front";
	common_scripts\_destructible::destructible_part(var_01,"vehicle_80s_sedan1_glass_F",10,undefined,undefined,undefined,undefined,undefined,1);
	common_scripts\_destructible::destructible_state(var_01,"vehicle_80s_sedan1_glass_F_dam",200,undefined,undefined,undefined,1);
	common_scripts\_destructible::destructible_fx("tag_glass_front_fx","fx/props/car_glass_large");
	common_scripts\_destructible::destructible_sound("veh_glass_break_large");
	common_scripts\_destructible::destructible_state(undefined);
	var_01 = "tag_glass_back";
	common_scripts\_destructible::destructible_part(var_01,"vehicle_80s_sedan1_glass_B",10,undefined,undefined,undefined,undefined,undefined,1);
	common_scripts\_destructible::destructible_state(var_01,"vehicle_80s_sedan1_glass_B_dam",200,undefined,undefined,undefined,1);
	common_scripts\_destructible::destructible_fx("tag_glass_back_fx","fx/props/car_glass_large");
	common_scripts\_destructible::destructible_sound("veh_glass_break_large");
	common_scripts\_destructible::destructible_state(undefined);
	var_01 = "tag_glass_left_front";
	common_scripts\_destructible::destructible_part(var_01,"vehicle_80s_sedan1_glass_LF",10,undefined,undefined,undefined,undefined,undefined,1);
	common_scripts\_destructible::destructible_state(var_01,"vehicle_80s_sedan1_glass_LF_dam",200,undefined,undefined,undefined,1);
	common_scripts\_destructible::destructible_fx("tag_glass_left_front_fx","fx/props/car_glass_med");
	common_scripts\_destructible::destructible_sound("veh_glass_break_large");
	common_scripts\_destructible::destructible_state(undefined);
	var_01 = "tag_glass_right_front";
	common_scripts\_destructible::destructible_part(var_01,"vehicle_80s_sedan1_glass_RF",10,undefined,undefined,undefined,undefined,undefined,1);
	common_scripts\_destructible::destructible_state(var_01,"vehicle_80s_sedan1_glass_RF_dam",200,undefined,undefined,undefined,1);
	common_scripts\_destructible::destructible_fx("tag_glass_right_front_fx","fx/props/car_glass_med");
	common_scripts\_destructible::destructible_sound("veh_glass_break_large");
	common_scripts\_destructible::destructible_state(undefined);
	var_01 = "tag_glass_left_back";
	common_scripts\_destructible::destructible_part(var_01,"vehicle_80s_sedan1_glass_LB",10,undefined,undefined,undefined,undefined,undefined,1);
	common_scripts\_destructible::destructible_state(var_01,"vehicle_80s_sedan1_glass_LB_dam",200,undefined,undefined,undefined,1);
	common_scripts\_destructible::destructible_fx("tag_glass_left_back_fx","fx/props/car_glass_med");
	common_scripts\_destructible::destructible_sound("veh_glass_break_large");
	common_scripts\_destructible::destructible_state(undefined);
	var_01 = "tag_glass_right_back";
	common_scripts\_destructible::destructible_part(var_01,"vehicle_80s_sedan1_glass_RB",10,undefined,undefined,undefined,undefined,undefined,1);
	common_scripts\_destructible::destructible_state(var_01,"vehicle_80s_sedan1_glass_RB_dam",200,undefined,undefined,undefined,1);
	common_scripts\_destructible::destructible_fx("tag_glass_right_back_fx","fx/props/car_glass_med");
	common_scripts\_destructible::destructible_sound("veh_glass_break_large");
	common_scripts\_destructible::destructible_state(undefined);
	var_01 = "tag_light_left_front";
	common_scripts\_destructible::destructible_part(var_01,"vehicle_80s_sedan1_" + param_00 + "_light_LF",10,undefined,undefined,undefined,0.5);
	common_scripts\_destructible::destructible_fx(var_01,"fx/props/car_glass_headlight");
	common_scripts\_destructible::destructible_sound("veh_glass_break_small");
	common_scripts\_destructible::destructible_state(var_01,"vehicle_80s_sedan1_" + param_00 + "_light_LF_dam");
	var_01 = "tag_light_right_front";
	common_scripts\_destructible::destructible_part(var_01,"vehicle_80s_sedan1_" + param_00 + "_light_RF",10,undefined,undefined,undefined,0.5);
	common_scripts\_destructible::destructible_fx(var_01,"fx/props/car_glass_headlight");
	common_scripts\_destructible::destructible_sound("veh_glass_break_small");
	common_scripts\_destructible::destructible_state(var_01,"vehicle_80s_sedan1_" + param_00 + "_light_RF_dam");
	var_01 = "tag_light_left_back";
	common_scripts\_destructible::destructible_part(var_01,"vehicle_80s_sedan1_" + param_00 + "_light_LB",10);
	common_scripts\_destructible::destructible_fx(var_01,"fx/props/car_glass_brakelight");
	common_scripts\_destructible::destructible_sound("veh_glass_break_small");
	common_scripts\_destructible::destructible_state(var_01,"vehicle_80s_sedan1_" + param_00 + "_light_LB_dam");
	var_01 = "tag_light_right_back";
	common_scripts\_destructible::destructible_part(var_01,"vehicle_80s_sedan1_" + param_00 + "_light_RB",10);
	common_scripts\_destructible::destructible_fx(var_01,"fx/props/car_glass_brakelight");
	common_scripts\_destructible::destructible_sound("veh_glass_break_small");
	common_scripts\_destructible::destructible_state(var_01,"vehicle_80s_sedan1_" + param_00 + "_light_RB_dam");
	common_scripts\_destructible::destructible_part("tag_bumper_front","vehicle_80s_sedan1_" + param_00 + "_bumper_F",undefined,undefined,undefined,undefined,1,1);
	common_scripts\_destructible::destructible_part("tag_bumper_back","vehicle_80s_sedan1_" + param_00 + "_bumper_B",undefined,undefined,undefined,undefined,undefined,1);
	common_scripts\_destructible::destructible_part("tag_mirror_left","vehicle_80s_sedan1_" + param_00 + "_mirror_L",10);
	common_scripts\_destructible::destructible_physics();
	common_scripts\_destructible::destructible_part("tag_mirror_right","vehicle_80s_sedan1_" + param_00 + "_mirror_R",10,undefined,undefined,undefined,undefined,1);
	common_scripts\_destructible::destructible_physics();
}

//Function Number: 4
vehicle_80s_sedan1_side(param_00)
{
	common_scripts\_destructible::destructible_create("vehicle_80s_sedan1_" + param_00 + "_side",300,undefined,32,"no_melee");
	common_scripts\_destructible::destructible_loopfx("tag_hood_fx","fx/smoke/car_damage_whitesmoke",0.4);
	common_scripts\_destructible::destructible_state(undefined,"vehicle_80s_sedan1_" + param_00 + "_destructible",200,undefined,32,"no_melee");
	common_scripts\_destructible::destructible_loopfx("tag_hood_fx","fx/smoke/car_damage_blacksmoke",0.4);
	common_scripts\_destructible::destructible_state(undefined,"vehicle_80s_sedan1_" + param_00 + "_destructible",100,undefined,32,"no_melee");
	common_scripts\_destructible::destructible_loopfx("tag_hood_fx","fx/smoke/car_damage_blacksmoke_fire",0.4);
	common_scripts\_destructible::destructible_sound("fire_vehicle_flareup_med");
	common_scripts\_destructible::destructible_loopsound("fire_vehicle_med");
	common_scripts\_destructible::destructible_healthdrain(12,0.2,210,"allies");
	common_scripts\_destructible::destructible_state(undefined,"vehicle_80s_sedan1_" + param_00 + "_destructible",300,"player_only",32,"no_melee");
	common_scripts\_destructible::destructible_loopsound("fire_vehicle_med");
	common_scripts\_destructible::destructible_state(undefined,"vehicle_80s_sedan1_" + param_00 + "_destructible",400,undefined,32,"no_melee");
	common_scripts\_destructible::destructible_fx("tag_death_fx","fx/explosions/small_vehicle_explosion",0);
	common_scripts\_destructible::destructible_sound("car_explode");
	common_scripts\_destructible::destructible_sound("fire_vehicle_small");
	common_scripts\_destructible::destructible_explode(4000,5000,200,150,300);
	common_scripts\_destructible::destructible_state(undefined,"vehicle_80s_sedan1_" + param_00 + "_destroyed",undefined,32,"no_melee");
	var_01 = "tag_hood";
	common_scripts\_destructible::destructible_part(var_01,"vehicle_80s_sedan1_" + param_00 + "_hood",800,undefined,undefined,undefined,1,2.5);
	common_scripts\_destructible::destructible_state(var_01,"vehicle_80s_sedan1_" + param_00 + "_hood_dam");
	var_01 = "tag_trunk";
	common_scripts\_destructible::destructible_part(var_01,"vehicle_80s_sedan1_" + param_00 + "_trunk",1000,undefined,undefined,undefined,1);
	common_scripts\_destructible::destructible_state(var_01,"vehicle_80s_sedan1_" + param_00 + "_trunk_dam",2000);
	common_scripts\_destructible::destructible_part("left_wheel_01_jnt","vehicle_80s_sedan1_" + param_00 + "_wheel_LF",20,undefined,undefined,"no_melee",undefined,1);
	common_scripts\_destructible::destructible_sound("veh_tire_deflate","bullet");
	common_scripts\_destructible::destructible_part("left_wheel_02_jnt","vehicle_80s_sedan1_" + param_00 + "_wheel_LF",20,undefined,undefined,"no_melee",undefined,1);
	common_scripts\_destructible::destructible_sound("veh_tire_deflate","bullet");
	common_scripts\_destructible::destructible_part("right_wheel_01_jnt","vehicle_80s_sedan1_" + param_00 + "_wheel_LF",20,undefined,undefined,"no_melee");
	common_scripts\_destructible::destructible_sound("veh_tire_deflate","bullet");
	common_scripts\_destructible::destructible_part("right_wheel_02_jnt","vehicle_80s_sedan1_" + param_00 + "_wheel_LF",20,undefined,undefined,"no_melee");
	common_scripts\_destructible::destructible_sound("veh_tire_deflate","bullet");
	common_scripts\_destructible::destructible_part("tag_door_left_front","vehicle_80s_sedan1_" + param_00 + "_door_LF",undefined,undefined,undefined,undefined,1);
	common_scripts\_destructible::destructible_part("tag_door_left_back","vehicle_80s_sedan1_" + param_00 + "_door_LB",undefined,undefined,undefined,undefined,1);
	common_scripts\_destructible::destructible_part("tag_door_right_front","vehicle_80s_sedan1_" + param_00 + "_door_RF",undefined,undefined,undefined,undefined,undefined,1);
	common_scripts\_destructible::destructible_part("tag_door_right_back","vehicle_80s_sedan1_" + param_00 + "_door_RB",undefined,undefined,undefined,undefined,undefined,1);
	var_01 = "tag_glass_front";
	common_scripts\_destructible::destructible_part(var_01,"vehicle_80s_sedan1_glass_F",10,undefined,undefined,undefined,undefined,undefined,1);
	common_scripts\_destructible::destructible_state(var_01,"vehicle_80s_sedan1_glass_F_dam",200,undefined,undefined,undefined,1);
	common_scripts\_destructible::destructible_fx("tag_glass_front_fx","fx/props/car_glass_large");
	common_scripts\_destructible::destructible_sound("veh_glass_break_large");
	common_scripts\_destructible::destructible_state(undefined);
	var_01 = "tag_glass_back";
	common_scripts\_destructible::destructible_part(var_01,"vehicle_80s_sedan1_glass_B",10,undefined,undefined,undefined,undefined,undefined,1);
	common_scripts\_destructible::destructible_state(var_01,"vehicle_80s_sedan1_glass_B_dam",200,undefined,undefined,undefined,1);
	common_scripts\_destructible::destructible_fx("tag_glass_back_fx","fx/props/car_glass_large");
	common_scripts\_destructible::destructible_sound("veh_glass_break_large");
	common_scripts\_destructible::destructible_state(undefined);
	var_01 = "tag_glass_left_front";
	common_scripts\_destructible::destructible_part(var_01,"vehicle_80s_sedan1_glass_LF",10,undefined,undefined,undefined,undefined,undefined,1);
	common_scripts\_destructible::destructible_state(var_01,"vehicle_80s_sedan1_glass_LF_dam",200,undefined,undefined,undefined,1);
	common_scripts\_destructible::destructible_fx("tag_glass_left_front_fx","fx/props/car_glass_med");
	common_scripts\_destructible::destructible_sound("veh_glass_break_large");
	common_scripts\_destructible::destructible_state(undefined);
	var_01 = "tag_glass_right_front";
	common_scripts\_destructible::destructible_part(var_01,"vehicle_80s_sedan1_glass_RF",10,undefined,undefined,undefined,undefined,undefined,1);
	common_scripts\_destructible::destructible_state(var_01,"vehicle_80s_sedan1_glass_RF_dam",200,undefined,undefined,undefined,1);
	common_scripts\_destructible::destructible_fx("tag_glass_right_front_fx","fx/props/car_glass_med");
	common_scripts\_destructible::destructible_sound("veh_glass_break_large");
	common_scripts\_destructible::destructible_state(undefined);
	var_01 = "tag_glass_left_back";
	common_scripts\_destructible::destructible_part(var_01,"vehicle_80s_sedan1_glass_LB",10,undefined,undefined,undefined,undefined,undefined,1);
	common_scripts\_destructible::destructible_state(var_01,"vehicle_80s_sedan1_glass_LB_dam",200,undefined,undefined,undefined,1);
	common_scripts\_destructible::destructible_fx("tag_glass_left_back_fx","fx/props/car_glass_med");
	common_scripts\_destructible::destructible_sound("veh_glass_break_large");
	common_scripts\_destructible::destructible_state(undefined);
	var_01 = "tag_glass_right_back";
	common_scripts\_destructible::destructible_part(var_01,"vehicle_80s_sedan1_glass_RB",10,undefined,undefined,undefined,undefined,undefined,1);
	common_scripts\_destructible::destructible_state(var_01,"vehicle_80s_sedan1_glass_RB_dam",200,undefined,undefined,undefined,1);
	common_scripts\_destructible::destructible_fx("tag_glass_right_back_fx","fx/props/car_glass_med");
	common_scripts\_destructible::destructible_sound("veh_glass_break_large");
	common_scripts\_destructible::destructible_state(undefined);
	var_01 = "tag_light_left_front";
	common_scripts\_destructible::destructible_part(var_01,"vehicle_80s_sedan1_" + param_00 + "_light_LF",10,undefined,undefined,undefined,0.5);
	common_scripts\_destructible::destructible_fx(var_01,"fx/props/car_glass_headlight");
	common_scripts\_destructible::destructible_sound("veh_glass_break_small");
	common_scripts\_destructible::destructible_state(var_01,"vehicle_80s_sedan1_" + param_00 + "_light_LF_dam");
	var_01 = "tag_light_right_front";
	common_scripts\_destructible::destructible_part(var_01,"vehicle_80s_sedan1_" + param_00 + "_light_RF",10,undefined,undefined,undefined,0.5);
	common_scripts\_destructible::destructible_fx(var_01,"fx/props/car_glass_headlight");
	common_scripts\_destructible::destructible_sound("veh_glass_break_small");
	common_scripts\_destructible::destructible_state(var_01,"vehicle_80s_sedan1_" + param_00 + "_light_RF_dam");
	var_01 = "tag_light_left_back";
	common_scripts\_destructible::destructible_part(var_01,"vehicle_80s_sedan1_" + param_00 + "_light_LB",10);
	common_scripts\_destructible::destructible_fx(var_01,"fx/props/car_glass_brakelight");
	common_scripts\_destructible::destructible_sound("veh_glass_break_small");
	common_scripts\_destructible::destructible_state(var_01,"vehicle_80s_sedan1_" + param_00 + "_light_LB_dam");
	var_01 = "tag_light_right_back";
	common_scripts\_destructible::destructible_part(var_01,"vehicle_80s_sedan1_" + param_00 + "_light_RB",10);
	common_scripts\_destructible::destructible_fx(var_01,"fx/props/car_glass_brakelight");
	common_scripts\_destructible::destructible_sound("veh_glass_break_small");
	common_scripts\_destructible::destructible_state(var_01,"vehicle_80s_sedan1_" + param_00 + "_light_RB_dam");
	common_scripts\_destructible::destructible_part("tag_bumper_front","vehicle_80s_sedan1_" + param_00 + "_bumper_F",undefined,undefined,undefined,undefined,1,1);
	common_scripts\_destructible::destructible_part("tag_bumper_back","vehicle_80s_sedan1_" + param_00 + "_bumper_B",undefined,undefined,undefined,undefined,undefined,1);
	common_scripts\_destructible::destructible_part("tag_mirror_left","vehicle_80s_sedan1_" + param_00 + "_mirror_L",10);
	common_scripts\_destructible::destructible_physics();
	common_scripts\_destructible::destructible_part("tag_mirror_right","vehicle_80s_sedan1_" + param_00 + "_mirror_R",10,undefined,undefined,undefined,undefined,1);
	common_scripts\_destructible::destructible_physics();
}

//Function Number: 5
vehicle_bus_destructible()
{
	common_scripts\_destructible::destructible_create("vehicle_bus_destructible");
	var_00 = "tag_window_front_left";
	common_scripts\_destructible::destructible_part(var_00,"vehicle_bus_glass_fl",10,undefined,undefined,undefined,undefined,undefined,1);
	common_scripts\_destructible::destructible_state(var_00,"vehicle_bus_glass_fl_dest",200,undefined,undefined,undefined,1);
	common_scripts\_destructible::destructible_fx("tag_window_front_left","fx/props/car_glass_large");
	common_scripts\_destructible::destructible_sound("veh_glass_break_large");
	common_scripts\_destructible::destructible_state(undefined);
	var_00 = "tag_window_front_right";
	common_scripts\_destructible::destructible_part(var_00,"vehicle_bus_glass_fr",10,undefined,undefined,undefined,undefined,undefined,1);
	common_scripts\_destructible::destructible_state(var_00,"vehicle_bus_glass_fr_dest",200,undefined,undefined,undefined,1);
	common_scripts\_destructible::destructible_fx("tag_window_front_right","fx/props/car_glass_large");
	common_scripts\_destructible::destructible_sound("veh_glass_break_large");
	common_scripts\_destructible::destructible_state(undefined);
	var_00 = "tag_window_driver";
	common_scripts\_destructible::destructible_part(var_00,"vehicle_bus_glass_driver",10,undefined,undefined,undefined,undefined,undefined,1);
	common_scripts\_destructible::destructible_state(var_00,"vehicle_bus_glass_driver_dest",200,undefined,undefined,undefined,1);
	common_scripts\_destructible::destructible_fx("tag_window_driver","fx/props/car_glass_large");
	common_scripts\_destructible::destructible_sound("veh_glass_break_large");
	common_scripts\_destructible::destructible_state(undefined);
	var_00 = "tag_window_back";
	common_scripts\_destructible::destructible_part(var_00,"vehicle_bus_glass_back",10,undefined,undefined,undefined,undefined,undefined,1);
	common_scripts\_destructible::destructible_state(var_00,"vehicle_bus_glass_back_dest",200,undefined,undefined,undefined,1);
	common_scripts\_destructible::destructible_fx("tag_window_back","fx/props/car_glass_large");
	common_scripts\_destructible::destructible_sound("veh_glass_break_large");
	common_scripts\_destructible::destructible_state(undefined);
	var_00 = "tag_window_side_1";
	common_scripts\_destructible::destructible_part(var_00,"vehicle_bus_glass_side",10,undefined,undefined,undefined,undefined,undefined,1);
	common_scripts\_destructible::destructible_state(var_00,"vehicle_bus_glass_side_dest",200,undefined,undefined,undefined,1);
	common_scripts\_destructible::destructible_fx("tag_window_side_1","fx/props/car_glass_large");
	common_scripts\_destructible::destructible_sound("veh_glass_break_large");
	common_scripts\_destructible::destructible_state(undefined);
	var_00 = "tag_window_side_2";
	common_scripts\_destructible::destructible_part(var_00,"vehicle_bus_glass_side",10,undefined,undefined,undefined,undefined,undefined,1);
	common_scripts\_destructible::destructible_state(var_00,"vehicle_bus_glass_side_dest",200,undefined,undefined,undefined,1);
	common_scripts\_destructible::destructible_fx("tag_window_side_2","fx/props/car_glass_large");
	common_scripts\_destructible::destructible_sound("veh_glass_break_large");
	common_scripts\_destructible::destructible_state(undefined);
	var_00 = "tag_window_side_3";
	common_scripts\_destructible::destructible_part(var_00,"vehicle_bus_glass_side",10,undefined,undefined,undefined,undefined,undefined,1);
	common_scripts\_destructible::destructible_state(var_00,"vehicle_bus_glass_side_dest",200,undefined,undefined,undefined,1);
	common_scripts\_destructible::destructible_fx("tag_window_side_3","fx/props/car_glass_large");
	common_scripts\_destructible::destructible_sound("veh_glass_break_large");
	common_scripts\_destructible::destructible_state(undefined);
	var_00 = "tag_window_side_4";
	common_scripts\_destructible::destructible_part(var_00,"vehicle_bus_glass_side",10,undefined,undefined,undefined,undefined,undefined,1);
	common_scripts\_destructible::destructible_state(var_00,"vehicle_bus_glass_side_dest",200,undefined,undefined,undefined,1);
	common_scripts\_destructible::destructible_fx("tag_window_side_4","fx/props/car_glass_large");
	common_scripts\_destructible::destructible_sound("veh_glass_break_large");
	common_scripts\_destructible::destructible_state(undefined);
	var_00 = "tag_window_side_5";
	common_scripts\_destructible::destructible_part(var_00,"vehicle_bus_glass_side",10,undefined,undefined,undefined,undefined,undefined,1);
	common_scripts\_destructible::destructible_state(var_00,"vehicle_bus_glass_side_dest",200,undefined,undefined,undefined,1);
	common_scripts\_destructible::destructible_fx("tag_window_side_5","fx/props/car_glass_large");
	common_scripts\_destructible::destructible_sound("veh_glass_break_large");
	common_scripts\_destructible::destructible_state(undefined);
	var_00 = "tag_window_side_6";
	common_scripts\_destructible::destructible_part(var_00,"vehicle_bus_glass_side",10,undefined,undefined,undefined,undefined,undefined,1);
	common_scripts\_destructible::destructible_state(var_00,"vehicle_bus_glass_side_dest",200,undefined,undefined,undefined,1);
	common_scripts\_destructible::destructible_fx("tag_window_side_6","fx/props/car_glass_large");
	common_scripts\_destructible::destructible_sound("veh_glass_break_large");
	common_scripts\_destructible::destructible_state(undefined);
	var_00 = "tag_window_side_7";
	common_scripts\_destructible::destructible_part(var_00,"vehicle_bus_glass_side",10,undefined,undefined,undefined,undefined,undefined,1);
	common_scripts\_destructible::destructible_state(var_00,"vehicle_bus_glass_side_dest",200,undefined,undefined,undefined,1);
	common_scripts\_destructible::destructible_fx("tag_window_side_7","fx/props/car_glass_large");
	common_scripts\_destructible::destructible_sound("veh_glass_break_large");
	common_scripts\_destructible::destructible_state(undefined);
	var_00 = "tag_window_side_8";
	common_scripts\_destructible::destructible_part(var_00,"vehicle_bus_glass_side",10,undefined,undefined,undefined,undefined,undefined,1);
	common_scripts\_destructible::destructible_state(var_00,"vehicle_bus_glass_side_dest",200,undefined,undefined,undefined,1);
	common_scripts\_destructible::destructible_fx("tag_window_side_8","fx/props/car_glass_large");
	common_scripts\_destructible::destructible_sound("veh_glass_break_large");
	common_scripts\_destructible::destructible_state(undefined);
	var_00 = "tag_window_side_9";
	common_scripts\_destructible::destructible_part(var_00,"vehicle_bus_glass_side",10,undefined,undefined,undefined,undefined,undefined,1);
	common_scripts\_destructible::destructible_state(var_00,"vehicle_bus_glass_side_dest",200,undefined,undefined,undefined,1);
	common_scripts\_destructible::destructible_fx("tag_window_side_9","fx/props/car_glass_large");
	common_scripts\_destructible::destructible_sound("veh_glass_break_large");
	common_scripts\_destructible::destructible_state(undefined);
	var_00 = "tag_window_side_10";
	common_scripts\_destructible::destructible_part(var_00,"vehicle_bus_glass_side",10,undefined,undefined,undefined,undefined,undefined,1);
	common_scripts\_destructible::destructible_state(var_00,"vehicle_bus_glass_side_dest",200,undefined,undefined,undefined,1);
	common_scripts\_destructible::destructible_fx("tag_window_side_10","fx/props/car_glass_large");
	common_scripts\_destructible::destructible_sound("veh_glass_break_large");
	common_scripts\_destructible::destructible_state(undefined);
	var_00 = "tag_window_side_11";
	common_scripts\_destructible::destructible_part(var_00,"vehicle_bus_glass_side",10,undefined,undefined,undefined,undefined,undefined,1);
	common_scripts\_destructible::destructible_state(var_00,"vehicle_bus_glass_side_dest",200,undefined,undefined,undefined,1);
	common_scripts\_destructible::destructible_fx("tag_window_side_11","fx/props/car_glass_large");
	common_scripts\_destructible::destructible_sound("veh_glass_break_large");
	common_scripts\_destructible::destructible_state(undefined);
}

//Function Number: 6
vehicle_80s_wagon1(param_00)
{
	common_scripts\_destructible::destructible_create("vehicle_80s_wagon1_" + param_00,300,undefined,32,"no_melee");
	common_scripts\_destructible::destructible_loopfx("tag_hood_fx","fx/smoke/car_damage_whitesmoke",0.4);
	common_scripts\_destructible::destructible_state(undefined,"vehicle_80s_wagon1_" + param_00 + "_destructible",200,undefined,32,"no_melee");
	common_scripts\_destructible::destructible_loopfx("tag_hood_fx","fx/smoke/car_damage_blacksmoke",0.4);
	common_scripts\_destructible::destructible_state(undefined,"vehicle_80s_wagon1_" + param_00 + "_destructible",100,undefined,32,"no_melee");
	common_scripts\_destructible::destructible_loopfx("tag_hood_fx","fx/smoke/car_damage_blacksmoke_fire",0.4);
	common_scripts\_destructible::destructible_sound("fire_vehicle_flareup_med");
	common_scripts\_destructible::destructible_loopsound("fire_vehicle_med");
	common_scripts\_destructible::destructible_healthdrain(12,0.2,210,"allies");
	common_scripts\_destructible::destructible_state(undefined,"vehicle_80s_wagon1_" + param_00 + "_destructible",300,"player_only",32,"no_melee");
	common_scripts\_destructible::destructible_loopsound("fire_vehicle_med");
	common_scripts\_destructible::destructible_state(undefined,"vehicle_80s_wagon1_" + param_00 + "_destructible",400,undefined,32,"no_melee");
	common_scripts\_destructible::destructible_fx("tag_death_fx","fx/explosions/small_vehicle_explosion",0);
	common_scripts\_destructible::destructible_sound("car_explode");
	common_scripts\_destructible::destructible_sound("fire_vehicle_small");
	common_scripts\_destructible::destructible_explode(4000,5000,200,150,300);
	common_scripts\_destructible::destructible_anim(%vehicle_80s_sedan1_destroy,#animtree,"setanimknob");
	common_scripts\_destructible::destructible_state(undefined,"vehicle_80s_wagon1_" + param_00 + "_destroyed",undefined,32,"no_melee");
	var_01 = "tag_hood";
	common_scripts\_destructible::destructible_part(var_01,"vehicle_80s_wagon1_" + param_00 + "_hood",800,undefined,undefined,undefined,1,1.5);
	common_scripts\_destructible::destructible_state(var_01,"vehicle_80s_wagon1_" + param_00 + "_hood_dam");
	common_scripts\_destructible::destructible_part("left_wheel_01_jnt","vehicle_80s_wagon1_" + param_00 + "_wheel_LF",20,undefined,undefined,"no_melee",undefined,0,undefined,1);
	common_scripts\_destructible::destructible_anim(%vehicle_80s_sedan1_flattire_lf,#animtree,"setanim");
	common_scripts\_destructible::destructible_anim(%vehicle_80s_sedan1_flattire_tire,#animtree,"setanim",1);
	common_scripts\_destructible::destructible_sound("veh_tire_deflate","bullet");
	common_scripts\_destructible::destructible_part("left_wheel_02_jnt","vehicle_80s_wagon1_" + param_00 + "_wheel_LF",20,undefined,undefined,"no_melee",undefined,1.7,undefined,1);
	common_scripts\_destructible::destructible_anim(%vehicle_80s_sedan1_flattire_lb,#animtree,"setanim");
	common_scripts\_destructible::destructible_anim(%vehicle_80s_sedan1_flattire_tire,#animtree,"setanim",1);
	common_scripts\_destructible::destructible_sound("veh_tire_deflate","bullet");
	common_scripts\_destructible::destructible_part("right_wheel_01_jnt","vehicle_80s_wagon1_" + param_00 + "_wheel_LF",20,undefined,undefined,"no_melee",undefined,0,undefined,1);
	common_scripts\_destructible::destructible_anim(%vehicle_80s_sedan1_flattire_rf,#animtree,"setanim");
	common_scripts\_destructible::destructible_anim(%vehicle_80s_sedan1_flattire_tire,#animtree,"setanim",1);
	common_scripts\_destructible::destructible_sound("veh_tire_deflate","bullet");
	common_scripts\_destructible::destructible_part("right_wheel_02_jnt","vehicle_80s_wagon1_" + param_00 + "_wheel_LF",20,undefined,undefined,"no_melee",undefined,1.7,undefined,1);
	common_scripts\_destructible::destructible_anim(%vehicle_80s_sedan1_flattire_rb,#animtree,"setanim");
	common_scripts\_destructible::destructible_anim(%vehicle_80s_sedan1_flattire_tire,#animtree,"setanim",1);
	common_scripts\_destructible::destructible_sound("veh_tire_deflate","bullet");
	common_scripts\_destructible::destructible_part("tag_door_left_front","vehicle_80s_wagon1_" + param_00 + "_door_LF",undefined,undefined,undefined,undefined,1);
	common_scripts\_destructible::destructible_part("tag_door_left_back","vehicle_80s_wagon1_" + param_00 + "_door_LB",undefined,undefined,undefined,undefined,1);
	common_scripts\_destructible::destructible_part("tag_door_right_front","vehicle_80s_wagon1_" + param_00 + "_door_RF",undefined,undefined,undefined,undefined,1);
	common_scripts\_destructible::destructible_part("tag_door_right_back","vehicle_80s_wagon1_" + param_00 + "_door_RB",undefined,undefined,undefined,undefined,1,1);
	var_01 = "tag_glass_front";
	common_scripts\_destructible::destructible_part(var_01,"vehicle_80s_wagon1_glass_F",200,undefined,undefined,undefined,undefined,undefined,1);
	common_scripts\_destructible::destructible_fx("tag_glass_front_fx","fx/props/car_glass_large");
	common_scripts\_destructible::destructible_sound("veh_glass_break_large");
	common_scripts\_destructible::destructible_state(undefined);
	var_01 = "tag_glass_back";
	common_scripts\_destructible::destructible_part(var_01,"vehicle_80s_wagon1_glass_B",200,undefined,undefined,undefined,undefined,undefined,1);
	common_scripts\_destructible::destructible_fx("tag_glass_back_fx","fx/props/car_glass_large");
	common_scripts\_destructible::destructible_sound("veh_glass_break_large");
	common_scripts\_destructible::destructible_state(undefined);
	var_01 = "tag_glass_left_front";
	common_scripts\_destructible::destructible_part(var_01,"vehicle_80s_wagon1_glass_LF",200,undefined,undefined,undefined,undefined,undefined,1);
	common_scripts\_destructible::destructible_fx("tag_glass_left_front_fx","fx/props/car_glass_med");
	common_scripts\_destructible::destructible_sound("veh_glass_break_large");
	common_scripts\_destructible::destructible_state(undefined);
	var_01 = "tag_glass_right_front";
	common_scripts\_destructible::destructible_part(var_01,"vehicle_80s_wagon1_glass_RF",200,undefined,undefined,undefined,undefined,undefined,1);
	common_scripts\_destructible::destructible_fx("tag_glass_right_front_fx","fx/props/car_glass_med");
	common_scripts\_destructible::destructible_sound("veh_glass_break_large");
	common_scripts\_destructible::destructible_state(undefined);
	var_01 = "tag_glass_left_back";
	common_scripts\_destructible::destructible_part(var_01,"vehicle_80s_wagon1_glass_LB",200,undefined,undefined,undefined,undefined,undefined,1);
	common_scripts\_destructible::destructible_fx("tag_glass_left_back_fx","fx/props/car_glass_med");
	common_scripts\_destructible::destructible_sound("veh_glass_break_large");
	common_scripts\_destructible::destructible_state(undefined);
	var_01 = "tag_glass_right_back";
	common_scripts\_destructible::destructible_part(var_01,"vehicle_80s_wagon1_glass_RB",200,undefined,undefined,undefined,undefined,undefined,1);
	common_scripts\_destructible::destructible_fx("tag_glass_right_back_fx","fx/props/car_glass_med");
	common_scripts\_destructible::destructible_sound("veh_glass_break_large");
	common_scripts\_destructible::destructible_state(undefined);
	var_01 = "tag_glass_left_back2";
	common_scripts\_destructible::destructible_part(var_01,"vehicle_80s_wagon1_glass_LB2",200,undefined,undefined,undefined,undefined,undefined,1);
	common_scripts\_destructible::destructible_fx("tag_glass_left_back2_fx","fx/props/car_glass_med");
	common_scripts\_destructible::destructible_sound("veh_glass_break_large");
	common_scripts\_destructible::destructible_state(undefined);
	var_01 = "tag_glass_right_back2";
	common_scripts\_destructible::destructible_part(var_01,"vehicle_80s_wagon1_glass_RB2",200,undefined,undefined,undefined,undefined,undefined,1);
	common_scripts\_destructible::destructible_fx("tag_glass_right_back2_fx","fx/props/car_glass_med");
	common_scripts\_destructible::destructible_sound("veh_glass_break_large");
	common_scripts\_destructible::destructible_state(undefined);
	var_01 = "tag_light_left_front";
	common_scripts\_destructible::destructible_part(var_01,"vehicle_80s_wagon1_" + param_00 + "_light_LF",10,undefined,undefined,undefined,0.5);
	common_scripts\_destructible::destructible_fx(var_01,"fx/props/car_glass_headlight");
	common_scripts\_destructible::destructible_sound("veh_glass_break_small");
	common_scripts\_destructible::destructible_state(var_01,"vehicle_80s_wagon1_" + param_00 + "_light_LF_dam");
	var_01 = "tag_light_right_front";
	common_scripts\_destructible::destructible_part(var_01,"vehicle_80s_wagon1_" + param_00 + "_light_RF",10,undefined,undefined,undefined,0.5);
	common_scripts\_destructible::destructible_fx(var_01,"fx/props/car_glass_headlight");
	common_scripts\_destructible::destructible_sound("veh_glass_break_small");
	common_scripts\_destructible::destructible_state(var_01,"vehicle_80s_wagon1_" + param_00 + "_light_RF_dam");
	var_01 = "tag_light_left_back";
	common_scripts\_destructible::destructible_part(var_01,"vehicle_80s_wagon1_" + param_00 + "_light_LB",10);
	common_scripts\_destructible::destructible_fx(var_01,"fx/props/car_glass_brakelight");
	common_scripts\_destructible::destructible_sound("veh_glass_break_small");
	common_scripts\_destructible::destructible_state(var_01,"vehicle_80s_wagon1_" + param_00 + "_light_LB_dam");
	var_01 = "tag_light_right_back";
	common_scripts\_destructible::destructible_part(var_01,"vehicle_80s_wagon1_" + param_00 + "_light_RB",10);
	common_scripts\_destructible::destructible_fx(var_01,"fx/props/car_glass_brakelight");
	common_scripts\_destructible::destructible_sound("veh_glass_break_small");
	common_scripts\_destructible::destructible_state(var_01,"vehicle_80s_wagon1_" + param_00 + "_light_RB_dam");
	common_scripts\_destructible::destructible_part("tag_bumper_front","vehicle_80s_wagon1_" + param_00 + "_bumper_F",undefined,undefined,undefined,undefined,1,0.7);
	common_scripts\_destructible::destructible_part("tag_bumper_back","vehicle_80s_wagon1_" + param_00 + "_bumper_B",undefined,undefined,undefined,undefined,undefined,0.6);
	common_scripts\_destructible::destructible_part("tag_mirror_left","vehicle_80s_wagon1_" + param_00 + "_mirror_L",10);
	common_scripts\_destructible::destructible_physics();
	common_scripts\_destructible::destructible_part("tag_mirror_right","vehicle_80s_wagon1_" + param_00 + "_mirror_R",10);
	common_scripts\_destructible::destructible_physics();
}

//Function Number: 7
vehicle_80s_hatch1(param_00)
{
	common_scripts\_destructible::destructible_create("vehicle_80s_hatch1_" + param_00,300,undefined,32,"no_melee");
	common_scripts\_destructible::destructible_loopfx("tag_hood_fx","fx/smoke/car_damage_whitesmoke",0.4);
	common_scripts\_destructible::destructible_state(undefined,"vehicle_80s_hatch1_" + param_00 + "_destructible",200,undefined,32,"no_melee");
	common_scripts\_destructible::destructible_loopfx("tag_hood_fx","fx/smoke/car_damage_blacksmoke",0.4);
	common_scripts\_destructible::destructible_state(undefined,"vehicle_80s_hatch1_" + param_00 + "_destructible",100,undefined,32,"no_melee");
	common_scripts\_destructible::destructible_loopfx("tag_hood_fx","fx/smoke/car_damage_blacksmoke_fire",0.4);
	common_scripts\_destructible::destructible_sound("fire_vehicle_flareup_med");
	common_scripts\_destructible::destructible_loopsound("fire_vehicle_med");
	common_scripts\_destructible::destructible_healthdrain(12,0.2,210,"allies");
	common_scripts\_destructible::destructible_state(undefined,"vehicle_80s_hatch1_" + param_00 + "_destructible",300,"player_only",32,"no_melee");
	common_scripts\_destructible::destructible_loopsound("fire_vehicle_med");
	common_scripts\_destructible::destructible_state(undefined,"vehicle_80s_hatch1_" + param_00 + "_destructible",400,undefined,32,"no_melee");
	common_scripts\_destructible::destructible_fx("tag_death_fx","fx/explosions/small_vehicle_explosion",0);
	common_scripts\_destructible::destructible_sound("car_explode");
	common_scripts\_destructible::destructible_sound("fire_vehicle_small");
	common_scripts\_destructible::destructible_explode(4000,5000,200,150,300);
	common_scripts\_destructible::destructible_anim(%vehicle_80s_sedan1_destroy,#animtree,"setanimknob");
	common_scripts\_destructible::destructible_state(undefined,"vehicle_80s_hatch1_" + param_00 + "_destroyed",undefined,32,"no_melee");
	var_01 = "tag_hood";
	common_scripts\_destructible::destructible_part(var_01,"vehicle_80s_hatch1_" + param_00 + "_hood",800,undefined,undefined,undefined,1,1.5);
	common_scripts\_destructible::destructible_state(var_01,"vehicle_80s_hatch1_" + param_00 + "_hood_dam");
	common_scripts\_destructible::destructible_part("left_wheel_01_jnt","vehicle_80s_hatch1_" + param_00 + "_wheel_LF",20,undefined,undefined,"no_melee",undefined,1.7,undefined,1);
	common_scripts\_destructible::destructible_anim(%vehicle_80s_sedan1_flattire_lf,#animtree,"setanim");
	common_scripts\_destructible::destructible_anim(%vehicle_80s_sedan1_flattire_tire,#animtree,"setanim",1);
	common_scripts\_destructible::destructible_sound("veh_tire_deflate","bullet");
	common_scripts\_destructible::destructible_part("left_wheel_02_jnt","vehicle_80s_hatch1_" + param_00 + "_wheel_LF",20,undefined,undefined,"no_melee",undefined,0,undefined,1);
	common_scripts\_destructible::destructible_anim(%vehicle_80s_sedan1_flattire_lb,#animtree,"setanim");
	common_scripts\_destructible::destructible_anim(%vehicle_80s_sedan1_flattire_tire,#animtree,"setanim",1);
	common_scripts\_destructible::destructible_sound("veh_tire_deflate","bullet");
	common_scripts\_destructible::destructible_part("right_wheel_01_jnt","vehicle_80s_hatch1_" + param_00 + "_wheel_LF",20,undefined,undefined,"no_melee",undefined,1.7,undefined,1);
	common_scripts\_destructible::destructible_anim(%vehicle_80s_sedan1_flattire_rf,#animtree,"setanim");
	common_scripts\_destructible::destructible_anim(%vehicle_80s_sedan1_flattire_tire,#animtree,"setanim",1);
	common_scripts\_destructible::destructible_sound("veh_tire_deflate","bullet");
	common_scripts\_destructible::destructible_part("right_wheel_02_jnt","vehicle_80s_hatch1_" + param_00 + "_wheel_LF",20,undefined,undefined,"no_melee",undefined,0,undefined,1);
	common_scripts\_destructible::destructible_anim(%vehicle_80s_sedan1_flattire_rb,#animtree,"setanim");
	common_scripts\_destructible::destructible_anim(%vehicle_80s_sedan1_flattire_tire,#animtree,"setanim",1);
	common_scripts\_destructible::destructible_sound("veh_tire_deflate","bullet");
	common_scripts\_destructible::destructible_part("tag_door_left_front","vehicle_80s_hatch1_" + param_00 + "_door_LF",undefined,undefined,undefined,undefined,1);
	common_scripts\_destructible::destructible_part("tag_door_right_front","vehicle_80s_hatch1_" + param_00 + "_door_RF",undefined,undefined,undefined,undefined,1,1);
	var_01 = "tag_glass_front";
	common_scripts\_destructible::destructible_part(var_01,"vehicle_80s_hatch1_glass_F",10,undefined,undefined,undefined,undefined,undefined,1);
	common_scripts\_destructible::destructible_state(var_01,"vehicle_80s_hatch1_glass_F_dam",200,undefined,undefined,undefined,1);
	common_scripts\_destructible::destructible_fx("tag_glass_front_fx","fx/props/car_glass_large");
	common_scripts\_destructible::destructible_sound("veh_glass_break_large");
	common_scripts\_destructible::destructible_state(undefined);
	var_01 = "tag_glass_back";
	common_scripts\_destructible::destructible_part(var_01,"vehicle_80s_hatch1_glass_B",10,undefined,undefined,undefined,undefined,undefined,1);
	common_scripts\_destructible::destructible_state(var_01,"vehicle_80s_hatch1_glass_B_dam",200,undefined,undefined,undefined,1);
	common_scripts\_destructible::destructible_fx("tag_glass_back_fx","fx/props/car_glass_large");
	common_scripts\_destructible::destructible_sound("veh_glass_break_large");
	common_scripts\_destructible::destructible_state(undefined);
	var_01 = "tag_glass_left_front";
	common_scripts\_destructible::destructible_part(var_01,"vehicle_80s_hatch1_glass_LF",10,undefined,undefined,undefined,undefined,undefined,1);
	common_scripts\_destructible::destructible_state(var_01,"vehicle_80s_hatch1_glass_LF_dam",200,undefined,undefined,undefined,1);
	common_scripts\_destructible::destructible_fx("tag_glass_left_front_fx","fx/props/car_glass_med");
	common_scripts\_destructible::destructible_sound("veh_glass_break_large");
	common_scripts\_destructible::destructible_state(undefined);
	var_01 = "tag_glass_right_front";
	common_scripts\_destructible::destructible_part(var_01,"vehicle_80s_hatch1_glass_RF",10,undefined,undefined,undefined,undefined,undefined,1);
	common_scripts\_destructible::destructible_state(var_01,"vehicle_80s_hatch1_glass_RF_dam",200,undefined,undefined,undefined,1);
	common_scripts\_destructible::destructible_fx("tag_glass_right_front_fx","fx/props/car_glass_med");
	common_scripts\_destructible::destructible_sound("veh_glass_break_large");
	common_scripts\_destructible::destructible_state(undefined);
	var_01 = "tag_glass_left_back";
	common_scripts\_destructible::destructible_part(var_01,"vehicle_80s_hatch1_glass_LB",10,undefined,undefined,undefined,undefined,undefined,1);
	common_scripts\_destructible::destructible_state(var_01,"vehicle_80s_hatch1_glass_LB_dam",200,undefined,undefined,undefined,1);
	common_scripts\_destructible::destructible_fx("tag_glass_left_back_fx","fx/props/car_glass_med");
	common_scripts\_destructible::destructible_sound("veh_glass_break_large");
	common_scripts\_destructible::destructible_state(undefined);
	var_01 = "tag_glass_right_back";
	common_scripts\_destructible::destructible_part(var_01,"vehicle_80s_hatch1_glass_RB",10,undefined,undefined,undefined,undefined,undefined,1);
	common_scripts\_destructible::destructible_state(var_01,"vehicle_80s_hatch1_glass_RB_dam",200,undefined,undefined,undefined,1);
	common_scripts\_destructible::destructible_fx("tag_glass_right_back_fx","fx/props/car_glass_med");
	common_scripts\_destructible::destructible_sound("veh_glass_break_large");
	common_scripts\_destructible::destructible_state(undefined);
	var_01 = "tag_light_left_front";
	common_scripts\_destructible::destructible_part(var_01,"vehicle_80s_hatch1_" + param_00 + "_light_LF",10,undefined,undefined,undefined,0.5);
	common_scripts\_destructible::destructible_fx(var_01,"fx/props/car_glass_headlight");
	common_scripts\_destructible::destructible_sound("veh_glass_break_small");
	common_scripts\_destructible::destructible_state(var_01,"vehicle_80s_hatch1_" + param_00 + "_light_LF_dam");
	var_01 = "tag_light_right_front";
	common_scripts\_destructible::destructible_part(var_01,"vehicle_80s_hatch1_" + param_00 + "_light_RF",10,undefined,undefined,undefined,0.5);
	common_scripts\_destructible::destructible_fx(var_01,"fx/props/car_glass_headlight");
	common_scripts\_destructible::destructible_sound("veh_glass_break_small");
	common_scripts\_destructible::destructible_state(var_01,"vehicle_80s_hatch1_" + param_00 + "_light_RF_dam");
	var_01 = "tag_light_left_back";
	common_scripts\_destructible::destructible_part(var_01,"vehicle_80s_hatch1_" + param_00 + "_light_LB",10);
	common_scripts\_destructible::destructible_fx(var_01,"fx/props/car_glass_brakelight");
	common_scripts\_destructible::destructible_sound("veh_glass_break_small");
	common_scripts\_destructible::destructible_state(var_01,"vehicle_80s_hatch1_" + param_00 + "_light_LB_dam");
	var_01 = "tag_light_right_back";
	common_scripts\_destructible::destructible_part(var_01,"vehicle_80s_hatch1_" + param_00 + "_light_RB",10);
	common_scripts\_destructible::destructible_fx(var_01,"fx/props/car_glass_brakelight");
	common_scripts\_destructible::destructible_sound("veh_glass_break_small");
	common_scripts\_destructible::destructible_state(var_01,"vehicle_80s_hatch1_" + param_00 + "_light_RB_dam");
	common_scripts\_destructible::destructible_part("tag_bumper_front","vehicle_80s_hatch1_" + param_00 + "_bumper_F");
	common_scripts\_destructible::destructible_part("tag_bumper_back","vehicle_80s_hatch1_" + param_00 + "_bumper_B");
	common_scripts\_destructible::destructible_part("tag_mirror_left","vehicle_80s_hatch1_" + param_00 + "_mirror_L",10);
	common_scripts\_destructible::destructible_physics();
	common_scripts\_destructible::destructible_part("tag_mirror_right","vehicle_80s_hatch1_" + param_00 + "_mirror_R",10);
	common_scripts\_destructible::destructible_physics();
}

//Function Number: 8
vehicle_80s_hatch2(param_00)
{
	common_scripts\_destructible::destructible_create("vehicle_80s_hatch2_" + param_00,300,undefined,32,"no_melee");
	common_scripts\_destructible::destructible_loopfx("tag_hood_fx","fx/smoke/car_damage_whitesmoke",0.4);
	common_scripts\_destructible::destructible_state(undefined,"vehicle_80s_hatch2_" + param_00 + "_destructible",200,undefined,32,"no_melee");
	common_scripts\_destructible::destructible_loopfx("tag_hood_fx","fx/smoke/car_damage_blacksmoke",0.4);
	common_scripts\_destructible::destructible_state(undefined,"vehicle_80s_hatch2_" + param_00 + "_destructible",100,undefined,32,"no_melee");
	common_scripts\_destructible::destructible_loopfx("tag_hood_fx","fx/smoke/car_damage_blacksmoke_fire",0.4);
	common_scripts\_destructible::destructible_sound("fire_vehicle_flareup_med");
	common_scripts\_destructible::destructible_loopsound("fire_vehicle_med");
	common_scripts\_destructible::destructible_healthdrain(12,0.2,210,"allies");
	common_scripts\_destructible::destructible_state(undefined,"vehicle_80s_hatch2_" + param_00 + "_destructible",300,"player_only",32,"no_melee");
	common_scripts\_destructible::destructible_loopsound("fire_vehicle_med");
	common_scripts\_destructible::destructible_state(undefined,"vehicle_80s_hatch2_" + param_00 + "_destructible",400,undefined,32,"no_melee");
	common_scripts\_destructible::destructible_fx("tag_death_fx","fx/explosions/small_vehicle_explosion",0);
	common_scripts\_destructible::destructible_sound("car_explode");
	common_scripts\_destructible::destructible_sound("fire_vehicle_small");
	common_scripts\_destructible::destructible_explode(4000,5000,200,150,300);
	common_scripts\_destructible::destructible_anim(%vehicle_80s_sedan1_destroy,#animtree,"setanimknob");
	common_scripts\_destructible::destructible_state(undefined,"vehicle_80s_hatch2_" + param_00 + "_destroyed",undefined,32,"no_melee");
	var_01 = "tag_hood";
	common_scripts\_destructible::destructible_part(var_01,"vehicle_80s_hatch2_" + param_00 + "_hood",800,undefined,undefined,undefined,1,1.5);
	common_scripts\_destructible::destructible_state(var_01,"vehicle_80s_hatch2_" + param_00 + "_hood_dam");
	common_scripts\_destructible::destructible_part("left_wheel_01_jnt","vehicle_80s_hatch2_" + param_00 + "_wheel_LF",20,undefined,undefined,"no_melee",undefined,1.7,undefined,1);
	common_scripts\_destructible::destructible_anim(%vehicle_80s_sedan1_flattire_lf,#animtree,"setanim");
	common_scripts\_destructible::destructible_anim(%vehicle_80s_sedan1_flattire_tire,#animtree,"setanim",1);
	common_scripts\_destructible::destructible_sound("veh_tire_deflate","bullet");
	common_scripts\_destructible::destructible_part("left_wheel_02_jnt","vehicle_80s_hatch2_" + param_00 + "_wheel_LF",20,undefined,undefined,"no_melee",undefined,0,undefined,1);
	common_scripts\_destructible::destructible_anim(%vehicle_80s_sedan1_flattire_lb,#animtree,"setanim");
	common_scripts\_destructible::destructible_anim(%vehicle_80s_sedan1_flattire_tire,#animtree,"setanim",1);
	common_scripts\_destructible::destructible_sound("veh_tire_deflate","bullet");
	common_scripts\_destructible::destructible_part("right_wheel_01_jnt","vehicle_80s_hatch2_" + param_00 + "_wheel_LF",20,undefined,undefined,"no_melee",undefined,1.7,undefined,1);
	common_scripts\_destructible::destructible_anim(%vehicle_80s_sedan1_flattire_rf,#animtree,"setanim");
	common_scripts\_destructible::destructible_anim(%vehicle_80s_sedan1_flattire_tire,#animtree,"setanim",1);
	common_scripts\_destructible::destructible_sound("veh_tire_deflate","bullet");
	common_scripts\_destructible::destructible_part("right_wheel_02_jnt","vehicle_80s_hatch2_" + param_00 + "_wheel_LF",20,undefined,undefined,"no_melee",undefined,0,undefined,1);
	common_scripts\_destructible::destructible_anim(%vehicle_80s_sedan1_flattire_rb,#animtree,"setanim");
	common_scripts\_destructible::destructible_anim(%vehicle_80s_sedan1_flattire_tire,#animtree,"setanim",1);
	common_scripts\_destructible::destructible_sound("veh_tire_deflate","bullet");
	common_scripts\_destructible::destructible_part("tag_door_left_front","vehicle_80s_hatch2_" + param_00 + "_door_LF",undefined,undefined,undefined,undefined,1);
	common_scripts\_destructible::destructible_part("tag_door_right_front","vehicle_80s_hatch2_" + param_00 + "_door_RF",undefined,undefined,undefined,undefined,1,1);
	var_01 = "tag_glass_front";
	common_scripts\_destructible::destructible_part(var_01,"vehicle_80s_hatch2_glass_F",10,undefined,undefined,undefined,undefined,undefined,1);
	common_scripts\_destructible::destructible_state(var_01,"vehicle_80s_hatch2_glass_F_dam",200,undefined,undefined,undefined,1);
	common_scripts\_destructible::destructible_fx("tag_glass_front_fx","fx/props/car_glass_large");
	common_scripts\_destructible::destructible_sound("veh_glass_break_large");
	common_scripts\_destructible::destructible_state(undefined);
	var_01 = "tag_glass_back";
	common_scripts\_destructible::destructible_part(var_01,"vehicle_80s_hatch2_glass_B",10,undefined,undefined,undefined,undefined,undefined,1);
	common_scripts\_destructible::destructible_state(var_01,"vehicle_80s_hatch2_glass_B_dam",200,undefined,undefined,undefined,1);
	common_scripts\_destructible::destructible_fx("tag_glass_back_fx","fx/props/car_glass_large");
	common_scripts\_destructible::destructible_sound("veh_glass_break_large");
	common_scripts\_destructible::destructible_state(undefined);
	var_01 = "tag_glass_left_front";
	common_scripts\_destructible::destructible_part(var_01,"vehicle_80s_hatch2_glass_LF",10,undefined,undefined,undefined,undefined,undefined,1);
	common_scripts\_destructible::destructible_state(var_01,"vehicle_80s_hatch2_glass_LF_dam",200,undefined,undefined,undefined,1);
	common_scripts\_destructible::destructible_fx("tag_glass_left_front_fx","fx/props/car_glass_med");
	common_scripts\_destructible::destructible_sound("veh_glass_break_large");
	common_scripts\_destructible::destructible_state(undefined);
	var_01 = "tag_glass_right_front";
	common_scripts\_destructible::destructible_part(var_01,"vehicle_80s_hatch2_glass_RF",10,undefined,undefined,undefined,undefined,undefined,1);
	common_scripts\_destructible::destructible_state(var_01,"vehicle_80s_hatch2_glass_RF_dam",200,undefined,undefined,undefined,1);
	common_scripts\_destructible::destructible_fx("tag_glass_right_front_fx","fx/props/car_glass_med");
	common_scripts\_destructible::destructible_sound("veh_glass_break_large");
	common_scripts\_destructible::destructible_state(undefined);
	var_01 = "tag_glass_left_back";
	common_scripts\_destructible::destructible_part(var_01,"vehicle_80s_hatch2_glass_LB",10,undefined,undefined,undefined,undefined,undefined,1);
	common_scripts\_destructible::destructible_state(var_01,"vehicle_80s_hatch2_glass_LB_dam",200,undefined,undefined,undefined,1);
	common_scripts\_destructible::destructible_fx("tag_glass_left_back_fx","fx/props/car_glass_med");
	common_scripts\_destructible::destructible_sound("veh_glass_break_large");
	common_scripts\_destructible::destructible_state(undefined);
	var_01 = "tag_glass_right_back";
	common_scripts\_destructible::destructible_part(var_01,"vehicle_80s_hatch2_glass_RB",10,undefined,undefined,undefined,undefined,undefined,1);
	common_scripts\_destructible::destructible_state(var_01,"vehicle_80s_hatch2_glass_RB_dam",200,undefined,undefined,undefined,1);
	common_scripts\_destructible::destructible_fx("tag_glass_right_back_fx","fx/props/car_glass_med");
	common_scripts\_destructible::destructible_sound("veh_glass_break_large");
	common_scripts\_destructible::destructible_state(undefined);
	var_01 = "tag_light_left_front";
	common_scripts\_destructible::destructible_part(var_01,"vehicle_80s_hatch2_" + param_00 + "_light_LF",10,undefined,undefined,undefined,0.5);
	common_scripts\_destructible::destructible_fx(var_01,"fx/props/car_glass_headlight");
	common_scripts\_destructible::destructible_sound("veh_glass_break_small");
	common_scripts\_destructible::destructible_state(var_01,"vehicle_80s_hatch2_" + param_00 + "_light_LF_dam");
	var_01 = "tag_light_right_front";
	common_scripts\_destructible::destructible_part(var_01,"vehicle_80s_hatch2_" + param_00 + "_light_RF",10,undefined,undefined,undefined,0.5);
	common_scripts\_destructible::destructible_fx(var_01,"fx/props/car_glass_headlight");
	common_scripts\_destructible::destructible_sound("veh_glass_break_small");
	common_scripts\_destructible::destructible_state(var_01,"vehicle_80s_hatch2_" + param_00 + "_light_RF_dam");
	var_01 = "tag_light_left_back";
	common_scripts\_destructible::destructible_part(var_01,"vehicle_80s_hatch2_" + param_00 + "_light_LB",10);
	common_scripts\_destructible::destructible_fx(var_01,"fx/props/car_glass_brakelight");
	common_scripts\_destructible::destructible_sound("veh_glass_break_small");
	common_scripts\_destructible::destructible_state(var_01,"vehicle_80s_hatch2_" + param_00 + "_light_LB_dam");
	var_01 = "tag_light_right_back";
	common_scripts\_destructible::destructible_part(var_01,"vehicle_80s_hatch2_" + param_00 + "_light_RB",10);
	common_scripts\_destructible::destructible_fx(var_01,"fx/props/car_glass_brakelight");
	common_scripts\_destructible::destructible_sound("veh_glass_break_small");
	common_scripts\_destructible::destructible_state(var_01,"vehicle_80s_hatch2_" + param_00 + "_light_RB_dam");
	common_scripts\_destructible::destructible_part("tag_bumper_front","vehicle_80s_hatch2_" + param_00 + "_bumper_F");
	common_scripts\_destructible::destructible_part("tag_bumper_back","vehicle_80s_hatch2_" + param_00 + "_bumper_B");
	common_scripts\_destructible::destructible_part("tag_mirror_left","vehicle_80s_hatch2_" + param_00 + "_mirror_L",10);
	common_scripts\_destructible::destructible_physics();
	common_scripts\_destructible::destructible_part("tag_mirror_right","vehicle_80s_hatch2_" + param_00 + "_mirror_R",10);
	common_scripts\_destructible::destructible_physics();
}

//Function Number: 9
vehicle_small_wagon(param_00)
{
	common_scripts\_destructible::destructible_create("vehicle_small_wagon_" + param_00,300,undefined,32,"no_melee");
	common_scripts\_destructible::destructible_loopfx("tag_hood_fx","fx/smoke/car_damage_whitesmoke",0.4);
	common_scripts\_destructible::destructible_state(undefined,"vehicle_small_wagon_" + param_00 + "_destructible",200,undefined,32,"no_melee");
	common_scripts\_destructible::destructible_loopfx("tag_hood_fx","fx/smoke/car_damage_blacksmoke",0.4);
	common_scripts\_destructible::destructible_state(undefined,"vehicle_small_wagon_" + param_00 + "_destructible",100,"player_only",32,"no_melee");
	common_scripts\_destructible::destructible_loopfx("tag_hood_fx","fx/smoke/car_damage_blacksmoke_fire",0.4);
	common_scripts\_destructible::destructible_sound("fire_vehicle_flareup_med");
	common_scripts\_destructible::destructible_loopsound("fire_vehicle_med");
	common_scripts\_destructible::destructible_healthdrain(12,0.2,210,"allies");
	common_scripts\_destructible::destructible_state(undefined,"vehicle_small_wagon_" + param_00 + "_destructible",300,"player_only",32,"no_melee");
	common_scripts\_destructible::destructible_loopsound("fire_vehicle_med");
	common_scripts\_destructible::destructible_state(undefined,"vehicle_small_wagon_" + param_00 + "_destructible",400,undefined,32,"no_melee");
	common_scripts\_destructible::destructible_fx("tag_death_fx","fx/explosions/small_vehicle_explosion",0);
	common_scripts\_destructible::destructible_sound("car_explode");
	common_scripts\_destructible::destructible_sound("fire_vehicle_small");
	common_scripts\_destructible::destructible_explode(4000,5000,200,150,300);
	common_scripts\_destructible::destructible_anim(%vehicle_80s_sedan1_destroy,#animtree,"setanimknob");
	common_scripts\_destructible::destructible_state(undefined,"vehicle_small_wagon_" + param_00 + "_destroyed",undefined,32,"no_melee");
	var_01 = "tag_hood";
	common_scripts\_destructible::destructible_part(var_01,"vehicle_small_wagon_" + param_00 + "_hood",800,undefined,undefined,undefined,1,1.5);
	common_scripts\_destructible::destructible_state(var_01,"vehicle_small_wagon_" + param_00 + "_hood_dam");
	common_scripts\_destructible::destructible_part("left_wheel_01_jnt","vehicle_small_wagon_" + param_00 + "_wheel_LF",20,undefined,undefined,"no_melee",undefined,0,undefined,1);
	common_scripts\_destructible::destructible_anim(%vehicle_80s_sedan1_flattire_lf,#animtree,"setanim");
	common_scripts\_destructible::destructible_anim(%vehicle_80s_sedan1_flattire_tire,#animtree,"setanim",1);
	common_scripts\_destructible::destructible_sound("veh_tire_deflate","bullet");
	common_scripts\_destructible::destructible_part("left_wheel_02_jnt","vehicle_small_wagon_" + param_00 + "_wheel_LF",20,undefined,undefined,"no_melee",undefined,0,undefined,1);
	common_scripts\_destructible::destructible_anim(%vehicle_80s_sedan1_flattire_lb,#animtree,"setanim");
	common_scripts\_destructible::destructible_anim(%vehicle_80s_sedan1_flattire_tire,#animtree,"setanim",1);
	common_scripts\_destructible::destructible_sound("veh_tire_deflate","bullet");
	common_scripts\_destructible::destructible_part("right_wheel_01_jnt","vehicle_small_wagon_" + param_00 + "_wheel_LF",20,undefined,undefined,"no_melee",undefined,0,undefined,1);
	common_scripts\_destructible::destructible_anim(%vehicle_80s_sedan1_flattire_rf,#animtree,"setanim");
	common_scripts\_destructible::destructible_anim(%vehicle_80s_sedan1_flattire_tire,#animtree,"setanim",1);
	common_scripts\_destructible::destructible_sound("veh_tire_deflate","bullet");
	common_scripts\_destructible::destructible_part("right_wheel_02_jnt","vehicle_small_wagon_" + param_00 + "_wheel_LF",20,undefined,undefined,"no_melee",undefined,0,undefined,1);
	common_scripts\_destructible::destructible_anim(%vehicle_80s_sedan1_flattire_rb,#animtree,"setanim");
	common_scripts\_destructible::destructible_anim(%vehicle_80s_sedan1_flattire_tire,#animtree,"setanim",1);
	common_scripts\_destructible::destructible_sound("veh_tire_deflate","bullet");
	common_scripts\_destructible::destructible_part("tag_door_left_front","vehicle_small_wagon_" + param_00 + "_door_LF",undefined,undefined,undefined,undefined,1,1);
	common_scripts\_destructible::destructible_state("tag_door_left_front","vehicle_small_wagon_" + param_00 + "_door_lf_dam");
	common_scripts\_destructible::destructible_part("tag_door_right_front","vehicle_small_wagon_" + param_00 + "_door_RF",undefined,undefined,undefined,undefined,1,1);
	common_scripts\_destructible::destructible_state("tag_door_right_front","vehicle_small_wagon_" + param_00 + "_door_rf_dam");
	var_01 = "tag_glass_front";
	common_scripts\_destructible::destructible_part(var_01,"vehicle_small_wagon_glass_F",10,undefined,undefined,undefined,undefined,undefined,1);
	common_scripts\_destructible::destructible_state(var_01,"vehicle_small_wagon_glass_F_dam",200,undefined,undefined,undefined,1);
	common_scripts\_destructible::destructible_fx("tag_glass_front_fx","fx/props/car_glass_large");
	common_scripts\_destructible::destructible_sound("veh_glass_break_large");
	common_scripts\_destructible::destructible_state(undefined);
	var_01 = "tag_glass_back";
	common_scripts\_destructible::destructible_part(var_01,"vehicle_small_wagon_glass_B",10,undefined,undefined,undefined,undefined,undefined,1);
	common_scripts\_destructible::destructible_state(var_01,"vehicle_small_wagon_glass_B_dam",200,undefined,undefined,undefined,1);
	common_scripts\_destructible::destructible_fx("tag_glass_back_fx","fx/props/car_glass_large");
	common_scripts\_destructible::destructible_sound("veh_glass_break_large");
	common_scripts\_destructible::destructible_state(undefined);
	var_01 = "tag_glass_left_front";
	common_scripts\_destructible::destructible_part(var_01,"vehicle_small_wagon_glass_LF",10,undefined,undefined,undefined,undefined,undefined,1);
	common_scripts\_destructible::destructible_state(var_01,"vehicle_small_wagon_glass_LF_dam",200,undefined,undefined,undefined,1);
	common_scripts\_destructible::destructible_fx("tag_glass_left_front_fx","fx/props/car_glass_med");
	common_scripts\_destructible::destructible_sound("veh_glass_break_large");
	common_scripts\_destructible::destructible_state(undefined);
	var_01 = "tag_glass_right_front";
	common_scripts\_destructible::destructible_part(var_01,"vehicle_small_wagon_glass_RF",10,undefined,undefined,undefined,undefined,undefined,1);
	common_scripts\_destructible::destructible_state(var_01,"vehicle_small_wagon_glass_RF_dam",200,undefined,undefined,undefined,1);
	common_scripts\_destructible::destructible_fx("tag_glass_right_front_fx","fx/props/car_glass_med");
	common_scripts\_destructible::destructible_sound("veh_glass_break_large");
	common_scripts\_destructible::destructible_state(undefined);
	var_01 = "tag_glass_left_back";
	common_scripts\_destructible::destructible_part(var_01,"vehicle_small_wagon_glass_LB",10,undefined,undefined,undefined,undefined,undefined,1);
	common_scripts\_destructible::destructible_state(var_01,"vehicle_small_wagon_glass_LB_dam",200,undefined,undefined,undefined,1);
	common_scripts\_destructible::destructible_fx("tag_glass_left_back_fx","fx/props/car_glass_med");
	common_scripts\_destructible::destructible_sound("veh_glass_break_large");
	common_scripts\_destructible::destructible_state(undefined);
	var_01 = "tag_glass_right_back";
	common_scripts\_destructible::destructible_part(var_01,"vehicle_small_wagon_glass_RB",10,undefined,undefined,undefined,undefined,undefined,1);
	common_scripts\_destructible::destructible_state(var_01,"vehicle_small_wagon_glass_RB_dam",200,undefined,undefined,undefined,1);
	common_scripts\_destructible::destructible_fx("tag_glass_right_back_fx","fx/props/car_glass_med");
	common_scripts\_destructible::destructible_sound("veh_glass_break_large");
	common_scripts\_destructible::destructible_state(undefined);
	var_01 = "tag_light_left_front";
	common_scripts\_destructible::destructible_part(var_01,"vehicle_small_wagon_" + param_00 + "_light_LF",10,undefined,undefined,undefined,0.5);
	common_scripts\_destructible::destructible_fx(var_01,"fx/props/car_glass_headlight");
	common_scripts\_destructible::destructible_sound("veh_glass_break_small");
	common_scripts\_destructible::destructible_state(var_01,"vehicle_small_wagon_" + param_00 + "_light_LF_dam");
	var_01 = "tag_light_right_front";
	common_scripts\_destructible::destructible_part(var_01,"vehicle_small_wagon_" + param_00 + "_light_RF",10,undefined,undefined,undefined,0.5);
	common_scripts\_destructible::destructible_fx(var_01,"fx/props/car_glass_headlight");
	common_scripts\_destructible::destructible_sound("veh_glass_break_small");
	common_scripts\_destructible::destructible_state(var_01,"vehicle_small_wagon_" + param_00 + "_light_RF_dam");
	var_01 = "tag_light_left_back";
	common_scripts\_destructible::destructible_part(var_01,"vehicle_small_wagon_" + param_00 + "_light_LB",10,undefined,undefined,undefined,0.5);
	common_scripts\_destructible::destructible_fx(var_01,"fx/props/car_glass_brakelight");
	common_scripts\_destructible::destructible_sound("veh_glass_break_small");
	common_scripts\_destructible::destructible_state(var_01,"vehicle_small_wagon_" + param_00 + "_light_LB_dam");
	var_01 = "tag_light_right_back";
	common_scripts\_destructible::destructible_part(var_01,"vehicle_small_wagon_" + param_00 + "_light_RB",10,undefined,undefined,undefined,0.5);
	common_scripts\_destructible::destructible_fx(var_01,"fx/props/car_glass_brakelight");
	common_scripts\_destructible::destructible_sound("veh_glass_break_small");
	common_scripts\_destructible::destructible_state(var_01,"vehicle_small_wagon_" + param_00 + "_light_RB_dam");
	common_scripts\_destructible::destructible_part("tag_bumper_front","vehicle_small_wagon_" + param_00 + "_bumper_F",undefined,undefined,undefined,undefined,1);
	common_scripts\_destructible::destructible_part("tag_bumper_back","vehicle_small_wagon_" + param_00 + "_bumper_B",undefined,undefined,undefined,undefined,0.5);
	common_scripts\_destructible::destructible_part("tag_mirror_left","vehicle_small_wagon_" + param_00 + "_mirror_L",10,undefined,undefined,undefined,undefined,1);
	common_scripts\_destructible::destructible_physics();
	common_scripts\_destructible::destructible_part("tag_mirror_right","vehicle_small_wagon_" + param_00 + "_mirror_R",10,undefined,undefined,undefined,undefined,1);
	common_scripts\_destructible::destructible_physics();
}

//Function Number: 10
vehicle_small_hatch(param_00)
{
	common_scripts\_destructible::destructible_create("vehicle_small_hatch_" + param_00,300,undefined,32,"no_melee");
	common_scripts\_destructible::destructible_loopfx("tag_hood_fx","fx/smoke/car_damage_whitesmoke",0.4);
	common_scripts\_destructible::destructible_state(undefined,"vehicle_small_hatch_" + param_00 + "_destructible",200,undefined,32,"no_melee");
	common_scripts\_destructible::destructible_loopfx("tag_hood_fx","fx/smoke/car_damage_blacksmoke",0.4);
	common_scripts\_destructible::destructible_state(undefined,"vehicle_small_hatch_" + param_00 + "_destructible",100,undefined,32,"no_melee");
	common_scripts\_destructible::destructible_loopfx("tag_hood_fx","fx/smoke/car_damage_blacksmoke_fire",0.4);
	common_scripts\_destructible::destructible_sound("fire_vehicle_flareup_med");
	common_scripts\_destructible::destructible_loopsound("fire_vehicle_med");
	common_scripts\_destructible::destructible_healthdrain(15,0.25,210,"allies");
	common_scripts\_destructible::destructible_state(undefined,"vehicle_small_hatch_" + param_00 + "_destructible",300,"player_only",32,"no_melee");
	common_scripts\_destructible::destructible_loopsound("fire_vehicle_med");
	common_scripts\_destructible::destructible_state(undefined,"vehicle_small_hatch_" + param_00 + "_destructible",400,undefined,32,"no_melee");
	common_scripts\_destructible::destructible_fx("tag_death_fx","fx/explosions/small_vehicle_explosion",0);
	common_scripts\_destructible::destructible_sound("car_explode");
	common_scripts\_destructible::destructible_sound("fire_vehicle_small");
	common_scripts\_destructible::destructible_explode(4000,5000,200,150,300);
	common_scripts\_destructible::destructible_anim(%vehicle_80s_sedan1_destroy,#animtree,"setanimknob");
	common_scripts\_destructible::destructible_state(undefined,"vehicle_small_hatch_" + param_00 + "_destroyed",undefined,32,"no_melee");
	var_01 = "tag_hood";
	common_scripts\_destructible::destructible_part(var_01,"vehicle_small_hatch_" + param_00 + "_hood",800,undefined,undefined,undefined,1,1.5);
	common_scripts\_destructible::destructible_state(var_01,"vehicle_small_hatch_" + param_00 + "_hood_dam");
	common_scripts\_destructible::destructible_part("left_wheel_01_jnt","vehicle_small_hatch_" + param_00 + "_wheel_LF",20,undefined,undefined,"no_melee",undefined,0,undefined,1);
	common_scripts\_destructible::destructible_anim(%vehicle_80s_sedan1_flattire_lf,#animtree,"setanim");
	common_scripts\_destructible::destructible_anim(%vehicle_80s_sedan1_flattire_tire,#animtree,"setanim",1);
	common_scripts\_destructible::destructible_sound("veh_tire_deflate","bullet");
	common_scripts\_destructible::destructible_part("left_wheel_02_jnt","vehicle_small_hatch_" + param_00 + "_wheel_LF",20,undefined,undefined,"no_melee",undefined,0,undefined,1);
	common_scripts\_destructible::destructible_anim(%vehicle_80s_sedan1_flattire_lb,#animtree,"setanim");
	common_scripts\_destructible::destructible_anim(%vehicle_80s_sedan1_flattire_tire,#animtree,"setanim",1);
	common_scripts\_destructible::destructible_sound("veh_tire_deflate","bullet");
	common_scripts\_destructible::destructible_part("right_wheel_01_jnt","vehicle_small_hatch_" + param_00 + "_wheel_LF",20,undefined,undefined,"no_melee",undefined,0,undefined,1);
	common_scripts\_destructible::destructible_anim(%vehicle_80s_sedan1_flattire_rf,#animtree,"setanim");
	common_scripts\_destructible::destructible_anim(%vehicle_80s_sedan1_flattire_tire,#animtree,"setanim",1);
	common_scripts\_destructible::destructible_sound("veh_tire_deflate","bullet");
	common_scripts\_destructible::destructible_part("right_wheel_02_jnt","vehicle_small_hatch_" + param_00 + "_wheel_LF",20,undefined,undefined,"no_melee",undefined,0,undefined,1);
	common_scripts\_destructible::destructible_anim(%vehicle_80s_sedan1_flattire_rb,#animtree,"setanim");
	common_scripts\_destructible::destructible_anim(%vehicle_80s_sedan1_flattire_tire,#animtree,"setanim",1);
	common_scripts\_destructible::destructible_sound("veh_tire_deflate","bullet");
	common_scripts\_destructible::destructible_part("tag_door_left_front","vehicle_small_hatch_" + param_00 + "_door_LF",undefined,undefined,undefined,undefined,1,1);
	common_scripts\_destructible::destructible_part("tag_door_right_front","vehicle_small_hatch_" + param_00 + "_door_RF",undefined,undefined,undefined,undefined,1,1);
	var_01 = "tag_glass_front";
	common_scripts\_destructible::destructible_part(var_01,"vehicle_small_hatch_glass_F",10,undefined,undefined,undefined,undefined,undefined,1);
	common_scripts\_destructible::destructible_state(var_01,"vehicle_small_hatch_glass_F_dam",200,undefined,undefined,undefined,1);
	common_scripts\_destructible::destructible_fx("tag_glass_front_fx","fx/props/car_glass_large");
	common_scripts\_destructible::destructible_sound("veh_glass_break_large");
	common_scripts\_destructible::destructible_state(undefined);
	var_01 = "tag_glass_back";
	common_scripts\_destructible::destructible_part(var_01,"vehicle_small_hatch_glass_B",10,undefined,undefined,undefined,undefined,undefined,1);
	common_scripts\_destructible::destructible_state(var_01,"vehicle_small_hatch_glass_B_dam",200,undefined,undefined,undefined,1);
	common_scripts\_destructible::destructible_fx("tag_glass_back_fx","fx/props/car_glass_large");
	common_scripts\_destructible::destructible_sound("veh_glass_break_large");
	common_scripts\_destructible::destructible_state(undefined);
	var_01 = "tag_glass_left_front";
	common_scripts\_destructible::destructible_part(var_01,"vehicle_small_hatch_glass_LF",10,undefined,undefined,undefined,undefined,undefined,1);
	common_scripts\_destructible::destructible_state(var_01,"vehicle_small_hatch_glass_LF_dam",200,undefined,undefined,undefined,1);
	common_scripts\_destructible::destructible_fx("tag_glass_left_front_fx","fx/props/car_glass_med");
	common_scripts\_destructible::destructible_sound("veh_glass_break_large");
	common_scripts\_destructible::destructible_state(undefined);
	var_01 = "tag_glass_right_front";
	common_scripts\_destructible::destructible_part(var_01,"vehicle_small_hatch_glass_RF",10,undefined,undefined,undefined,undefined,undefined,1);
	common_scripts\_destructible::destructible_state(var_01,"vehicle_small_hatch_glass_RF_dam",200,undefined,undefined,undefined,1);
	common_scripts\_destructible::destructible_fx("tag_glass_right_front_fx","fx/props/car_glass_med");
	common_scripts\_destructible::destructible_sound("veh_glass_break_large");
	common_scripts\_destructible::destructible_state(undefined);
	var_01 = "tag_glass_left_back";
	common_scripts\_destructible::destructible_part(var_01,"vehicle_small_hatch_glass_LB",10,undefined,undefined,undefined,undefined,undefined,1);
	common_scripts\_destructible::destructible_state(var_01,"vehicle_small_hatch_glass_LB_dam",200,undefined,undefined,undefined,1);
	common_scripts\_destructible::destructible_fx("tag_glass_left_back_fx","fx/props/car_glass_med");
	common_scripts\_destructible::destructible_sound("veh_glass_break_large");
	common_scripts\_destructible::destructible_state(undefined);
	var_01 = "tag_glass_right_back";
	common_scripts\_destructible::destructible_part(var_01,"vehicle_small_hatch_glass_RB",10,undefined,undefined,undefined,undefined,undefined,1);
	common_scripts\_destructible::destructible_state(var_01,"vehicle_small_hatch_glass_RB_dam",200,undefined,undefined,undefined,1);
	common_scripts\_destructible::destructible_fx("tag_glass_right_back_fx","fx/props/car_glass_med");
	common_scripts\_destructible::destructible_sound("veh_glass_break_large");
	common_scripts\_destructible::destructible_state(undefined);
	var_01 = "tag_light_left_front";
	common_scripts\_destructible::destructible_part(var_01,"vehicle_small_hatch_" + param_00 + "_light_LF",10,undefined,undefined,undefined,0.5);
	common_scripts\_destructible::destructible_fx(var_01,"fx/props/car_glass_headlight");
	common_scripts\_destructible::destructible_sound("veh_glass_break_small");
	common_scripts\_destructible::destructible_state(var_01,"vehicle_small_hatch_" + param_00 + "_light_LF_dam");
	var_01 = "tag_light_right_front";
	common_scripts\_destructible::destructible_part(var_01,"vehicle_small_hatch_" + param_00 + "_light_RF",10,undefined,undefined,undefined,0.5);
	common_scripts\_destructible::destructible_fx(var_01,"fx/props/car_glass_headlight");
	common_scripts\_destructible::destructible_sound("veh_glass_break_small");
	common_scripts\_destructible::destructible_state(var_01,"vehicle_small_hatch_" + param_00 + "_light_RF_dam");
	var_01 = "tag_light_left_back";
	common_scripts\_destructible::destructible_part(var_01,"vehicle_small_hatch_" + param_00 + "_light_LB",10,undefined,undefined,undefined,0.5);
	common_scripts\_destructible::destructible_fx(var_01,"fx/props/car_glass_brakelight");
	common_scripts\_destructible::destructible_sound("veh_glass_break_small");
	common_scripts\_destructible::destructible_state(var_01,"vehicle_small_hatch_" + param_00 + "_light_LB_dam");
	var_01 = "tag_light_right_back";
	common_scripts\_destructible::destructible_part(var_01,"vehicle_small_hatch_" + param_00 + "_light_RB",10,undefined,undefined,undefined,0.5);
	common_scripts\_destructible::destructible_fx(var_01,"fx/props/car_glass_brakelight");
	common_scripts\_destructible::destructible_sound("veh_glass_break_small");
	common_scripts\_destructible::destructible_state(var_01,"vehicle_small_hatch_" + param_00 + "_light_RB_dam");
	common_scripts\_destructible::destructible_part("tag_bumper_front","vehicle_small_hatch_" + param_00 + "_bumper_F",undefined,undefined,undefined,undefined,1);
	common_scripts\_destructible::destructible_part("tag_bumper_back","vehicle_small_hatch_" + param_00 + "_bumper_B",undefined,undefined,undefined,undefined,0.5);
	common_scripts\_destructible::destructible_part("tag_mirror_left","vehicle_small_hatch_" + param_00 + "_mirror_L",10,undefined,undefined,undefined,undefined,1);
	common_scripts\_destructible::destructible_physics();
	common_scripts\_destructible::destructible_part("tag_mirror_right","vehicle_small_hatch_" + param_00 + "_mirror_R",10,undefined,undefined,undefined,undefined,1);
	common_scripts\_destructible::destructible_physics();
}

//Function Number: 11
vehicle_80s_wagon1_thermal(param_00)
{
	common_scripts\_destructible::destructible_create("vehicle_80s_wagon1_" + param_00,300,undefined,32,"no_melee");
	common_scripts\_destructible::destructible_state(undefined,"vehicle_80s_wagon1_" + param_00 + "_destructible",800,"player_only",32,"no_melee");
	common_scripts\_destructible::destructible_fx(undefined,"fx/explosions/large_vehicle_explosion_IR");
	common_scripts\_destructible::destructible_sound("car_explode");
	common_scripts\_destructible::destructible_explode(4000,5000,200,150,300);
	common_scripts\_destructible::destructible_state(undefined,"vehicle_80s_wagon1_" + param_00 + "_destroyed");
}

//Function Number: 12
vehicle_80s_hatch1_thermal(param_00)
{
	common_scripts\_destructible::destructible_create("vehicle_80s_hatch1_" + param_00,300,undefined,32,"no_melee");
	common_scripts\_destructible::destructible_state(undefined,"vehicle_80s_hatch1_" + param_00 + "_destructible",800,"player_only",32,"no_melee");
	common_scripts\_destructible::destructible_fx(undefined,"fx/explosions/large_vehicle_explosion_IR");
	common_scripts\_destructible::destructible_sound("car_explode");
	common_scripts\_destructible::destructible_explode(4000,5000,200,150,300);
	common_scripts\_destructible::destructible_state(undefined,"vehicle_80s_hatch1_" + param_00 + "_destroyed");
}

//Function Number: 13
vehicle_80s_hatch2_thermal(param_00)
{
	common_scripts\_destructible::destructible_create("vehicle_80s_hatch2_" + param_00,300,undefined,32,"no_melee");
	common_scripts\_destructible::destructible_state(undefined,"vehicle_80s_hatch2_" + param_00 + "_destructible",800,"player_only",32,"no_melee");
	common_scripts\_destructible::destructible_fx(undefined,"fx/explosions/large_vehicle_explosion_IR");
	common_scripts\_destructible::destructible_sound("car_explode");
	common_scripts\_destructible::destructible_explode(4000,5000,200,150,300);
	common_scripts\_destructible::destructible_state(undefined,"vehicle_80s_hatch2_" + param_00 + "_destroyed");
}

//Function Number: 14
vehicle_80s_sedan1_thermal(param_00)
{
	common_scripts\_destructible::destructible_create("vehicle_80s_sedan1_" + param_00,300,undefined,32,"no_melee");
	common_scripts\_destructible::destructible_state(undefined,"vehicle_80s_sedan1_" + param_00 + "_destructible",800,"player_only",32,"no_melee");
	common_scripts\_destructible::destructible_fx(undefined,"fx/explosions/large_vehicle_explosion_IR");
	common_scripts\_destructible::destructible_sound("car_explode");
	common_scripts\_destructible::destructible_explode(4000,5000,200,150,300);
	common_scripts\_destructible::destructible_state(undefined,"vehicle_80s_sedan1_" + param_00 + "_destroyed");
}

//Function Number: 15
vehicle_small_hatch_thermal(param_00)
{
	common_scripts\_destructible::destructible_create("vehicle_small_hatch_" + param_00,300,undefined,32,"no_melee");
	common_scripts\_destructible::destructible_state(undefined,"vehicle_small_hatch_" + param_00 + "_destructible",800,"player_only",32,"no_melee");
	common_scripts\_destructible::destructible_fx(undefined,"fx/explosions/large_vehicle_explosion_IR");
	common_scripts\_destructible::destructible_sound("car_explode");
	common_scripts\_destructible::destructible_explode(4000,5000,200,150,300);
	common_scripts\_destructible::destructible_state(undefined,"vehicle_small_hatch_" + param_00 + "_destroyed");
}

//Function Number: 16
vehicle_luxurysedan_thermal(param_00)
{
	common_scripts\_destructible::destructible_create("vehicle_luxurysedan_" + param_00,300,undefined,32,"no_melee");
	common_scripts\_destructible::destructible_state(undefined,"vehicle_luxurysedan_" + param_00 + "_static",800,"player_only",32,"no_melee");
	common_scripts\_destructible::destructible_fx(undefined,"fx/explosions/large_vehicle_explosion_IR");
	common_scripts\_destructible::destructible_sound("car_explode");
	common_scripts\_destructible::destructible_explode(4000,5000,200,150,300);
	common_scripts\_destructible::destructible_state(undefined,"vehicle_luxurysedan_" + param_00 + "_destroy");
}

//Function Number: 17
vehicle_80s_hatch1_lowres(param_00,param_01)
{
	common_scripts\_destructible::destructible_create(param_00,300,undefined,32,"no_melee");
	common_scripts\_destructible::destructible_state(undefined,"vehicle_80s_hatch1_" + param_01,800,"no_ai",32,"no_melee");
	common_scripts\_destructible::destructible_fx(undefined,"fx/explosions/small_vehicle_explosion_airlift");
	common_scripts\_destructible::destructible_sound("car_explode");
	common_scripts\_destructible::destructible_explode(4000,5000,200,150,300);
	common_scripts\_destructible::destructible_state(undefined,"vehicle_80s_hatch1_" + param_01 + "_destroyed");
}

//Function Number: 18
vehicle_80s_hatch2_lowres(param_00,param_01)
{
	common_scripts\_destructible::destructible_create(param_00,300,undefined,32,"no_melee");
	common_scripts\_destructible::destructible_state(undefined,"vehicle_80s_hatch2_" + param_01,800,"no_ai",32,"no_melee");
	common_scripts\_destructible::destructible_fx(undefined,"fx/explosions/small_vehicle_explosion_airlift");
	common_scripts\_destructible::destructible_sound("car_explode");
	common_scripts\_destructible::destructible_explode(4000,5000,200,150,300);
	common_scripts\_destructible::destructible_state(undefined,"vehicle_80s_hatch2_" + param_01 + "_destroyed");
}

//Function Number: 19
vehicle_small_hatchback_lowres(param_00,param_01)
{
	common_scripts\_destructible::destructible_create(param_00,300,undefined,32,"no_melee");
	common_scripts\_destructible::destructible_state(undefined,"vehicle_small_hatchback_" + param_01,800,"no_ai",32,"no_melee");
	common_scripts\_destructible::destructible_fx(undefined,"fx/explosions/small_vehicle_explosion_airlift");
	common_scripts\_destructible::destructible_sound("car_explode");
	common_scripts\_destructible::destructible_explode(4000,5000,200,150,300);
	common_scripts\_destructible::destructible_state(undefined,"vehicle_small_hatchback_d_" + param_01);
}

//Function Number: 20
vehicle_80s_sedan1_lowres_red(param_00)
{
	common_scripts\_destructible::destructible_create(param_00,300,undefined,32,"no_melee");
	common_scripts\_destructible::destructible_state(undefined,"vehicle_80s_sedan1_red_low",800,"no_ai",32,"no_melee");
	common_scripts\_destructible::destructible_fx(undefined,"fx/explosions/small_vehicle_explosion_airlift");
	common_scripts\_destructible::destructible_sound("car_explode");
	common_scripts\_destructible::destructible_explode(4000,5000,200,150,300);
	common_scripts\_destructible::destructible_state(undefined,"vehicle_80s_sedan1_red_destroyed");
}

//Function Number: 21
vehicle_80s_sedan1_lowres(param_00,param_01)
{
	common_scripts\_destructible::destructible_create(param_00,300,undefined,32,"no_melee");
	common_scripts\_destructible::destructible_state(undefined,"vehicle_80s_sedan1_" + param_01,800,"no_ai",32,"no_melee");
	common_scripts\_destructible::destructible_fx(undefined,"fx/explosions/small_vehicle_explosion_airlift");
	common_scripts\_destructible::destructible_sound("car_explode");
	common_scripts\_destructible::destructible_explode(4000,5000,200,150,300);
	var_02 = undefined;
	if(param_01 == "green")
	{
		var_02 = "dest";
	}
	else
	{
		var_02 = "_destroyed";
	}

	common_scripts\_destructible::destructible_state(undefined,"vehicle_80s_sedan1_" + param_01 + var_02);
}

//Function Number: 22
vehicle_80s_wagon1_lowres(param_00,param_01)
{
	common_scripts\_destructible::destructible_create(param_00,300,undefined,32,"no_melee");
	common_scripts\_destructible::destructible_state(undefined,"vehicle_80s_wagon1_" + param_01,800,"no_ai",32,"no_melee");
	common_scripts\_destructible::destructible_fx(undefined,"fx/explosions/small_vehicle_explosion_airlift");
	common_scripts\_destructible::destructible_sound("car_explode");
	common_scripts\_destructible::destructible_explode(4000,5000,200,150,300);
	common_scripts\_destructible::destructible_state(undefined,"vehicle_80s_wagon1_" + param_01 + "_destroyed");
}

//Function Number: 23
vehicle_luxurysedan_lowres(param_00,param_01)
{
	common_scripts\_destructible::destructible_create(param_00,300,undefined,32,"no_melee");
	common_scripts\_destructible::destructible_state(undefined,"vehicle_luxurysedan",800,"no_ai",32,"no_melee");
	common_scripts\_destructible::destructible_fx(undefined,"fx/explosions/small_vehicle_explosion_airlift");
	common_scripts\_destructible::destructible_sound("car_explode");
	common_scripts\_destructible::destructible_explode(4000,5000,200,150,300);
	common_scripts\_destructible::destructible_state(undefined,"vehicle_luxurysedan_destroy");
}

//Function Number: 24
vehicle_tanker_truck(param_00)
{
	common_scripts\_destructible::destructible_create(param_00,600,undefined,32,"no_melee");
	common_scripts\_destructible::destructible_state(undefined,"vehicle_tanker_truck_static_low",800,"no_ai",32,"no_melee");
	common_scripts\_destructible::destructible_fx(undefined,"fx/explosions/tanker_explosion");
	common_scripts\_destructible::destructible_sound("exp_tanker_vehicle");
	common_scripts\_destructible::destructible_explode(4000,5000,768,150,300);
	common_scripts\_destructible::destructible_state(undefined,"vehicle_tanker_truck_d2");
}

//Function Number: 25
vehicle_bm21(param_00,param_01,param_02)
{
	common_scripts\_destructible::destructible_create("vehicle_bm21" + param_01,1500,undefined,32,"no_melee");
	common_scripts\_destructible::destructible_state(undefined,"vehicle_bm21" + param_01 + "_destructible",100,"player_only",32,"no_melee");
	common_scripts\_destructible::destructible_fx("tag_origin","fx/explosions/large_vehicle_explosion",0);
	common_scripts\_destructible::destructible_sound("car_explode");
	common_scripts\_destructible::destructible_explode(4000,5000,200,150,300);
	common_scripts\_destructible::destructible_anim(%vehicle_80s_sedan1_destroy,#animtree,"setanimknob");
	common_scripts\_destructible::destructible_state(undefined,"vehicle_bm21_mobile_bed_dstry");
	var_03 = "tag_glass_front";
	common_scripts\_destructible::destructible_part(var_03,"vehicle_bm21_glass_F",800,undefined,undefined,undefined,undefined,undefined,1);
	common_scripts\_destructible::destructible_state(var_03,"vehicle_bm21_glass_F_dam",800,undefined,undefined,undefined,1);
	common_scripts\_destructible::destructible_fx("tag_glass_front_fx","fx/props/car_glass_large");
	common_scripts\_destructible::destructible_sound("veh_glass_break_large");
	common_scripts\_destructible::destructible_state(undefined);
	var_03 = "tag_glass_back";
	common_scripts\_destructible::destructible_part(var_03,"vehicle_bm21_glass_B",250,undefined,undefined,undefined,undefined,undefined,1);
	common_scripts\_destructible::destructible_state(var_03,"vehicle_bm21_glass_B_dam",400,undefined,undefined,undefined,1);
	common_scripts\_destructible::destructible_fx("tag_glass_back_fx","fx/props/car_glass_large");
	common_scripts\_destructible::destructible_sound("veh_glass_break_large");
	common_scripts\_destructible::destructible_state(undefined);
	var_03 = "tag_glass_left_front";
	common_scripts\_destructible::destructible_part(var_03,"vehicle_bm21_glass_LF",250,undefined,undefined,undefined,undefined,undefined,1);
	common_scripts\_destructible::destructible_state(var_03,"vehicle_bm21_glass_LF_dam",400,undefined,undefined,undefined,1);
	common_scripts\_destructible::destructible_fx("tag_glass_left_front_fx","fx/props/car_glass_med");
	common_scripts\_destructible::destructible_sound("veh_glass_break_large");
	common_scripts\_destructible::destructible_state(undefined);
	var_03 = "tag_glass_right_front";
	common_scripts\_destructible::destructible_part(var_03,"vehicle_bm21_glass_RF",250,undefined,undefined,undefined,undefined,undefined,1);
	common_scripts\_destructible::destructible_state(var_03,"vehicle_bm21_glass_RF_dam",400,undefined,undefined,undefined,1);
	common_scripts\_destructible::destructible_fx("tag_glass_right_front_fx","fx/props/car_glass_med");
	common_scripts\_destructible::destructible_sound("veh_glass_break_large");
	common_scripts\_destructible::destructible_state(undefined);
	common_scripts\_destructible::destructible_part("left_wheel_01_jnt","vehicle_bm21_wheel_LF",0,undefined,undefined,undefined,undefined);
	common_scripts\_destructible::destructible_part("left_wheel_02_jnt","vehicle_bm21_wheel_LF",0,undefined,undefined,undefined);
	common_scripts\_destructible::destructible_part("left_wheel_03_jnt","vehicle_bm21_wheel_LF",0,undefined,undefined,undefined);
	common_scripts\_destructible::destructible_part("right_wheel_01_jnt","vehicle_bm21_wheel_RF",0,undefined,undefined,undefined,undefined);
	common_scripts\_destructible::destructible_part("right_wheel_02_jnt","vehicle_bm21_wheel_RF",0,undefined,undefined,undefined,undefined);
	common_scripts\_destructible::destructible_part("right_wheel_03_jnt","vehicle_bm21_wheel_RF",0,undefined,undefined,undefined,undefined);
}

//Function Number: 26
vehicle_uaz_fabric(param_00)
{
	common_scripts\_destructible::destructible_create("vehicle_uaz_fabric",550,undefined,32,"no_melee");
	common_scripts\_destructible::destructible_loopfx("tag_hood_fx","fx/smoke/car_damage_whitesmoke",0.4);
	common_scripts\_destructible::destructible_state(undefined,"vehicle_uaz_fabric_destructible",200,undefined,32,"no_melee");
	common_scripts\_destructible::destructible_loopfx("tag_hood_fx","fx/smoke/car_damage_blacksmoke",0.4);
	common_scripts\_destructible::destructible_state(undefined,"vehicle_uaz_fabric_destructible",100,undefined,32,"no_melee");
	common_scripts\_destructible::destructible_loopfx("tag_hood_fx","fx/smoke/car_damage_blacksmoke_fire",0.4);
	common_scripts\_destructible::destructible_sound("fire_vehicle_flareup_med");
	common_scripts\_destructible::destructible_loopsound("fire_vehicle_med");
	common_scripts\_destructible::destructible_healthdrain(12,0.2,210,"allies");
	common_scripts\_destructible::destructible_state(undefined,"vehicle_uaz_fabric_destructible",300,"player_only",32,"no_melee");
	common_scripts\_destructible::destructible_loopsound("fire_vehicle_med");
	common_scripts\_destructible::destructible_state(undefined,"vehicle_uaz_fabric_destructible",100,"player_only",32,"no_melee");
	common_scripts\_destructible::destructible_fx("tag_origin","fx/explosions/small_vehicle_explosion",0);
	common_scripts\_destructible::destructible_sound("car_explode");
	common_scripts\_destructible::destructible_sound("fire_vehicle_small");
	common_scripts\_destructible::destructible_explode(4000,5000,200,150,300);
	common_scripts\_destructible::destructible_state(undefined,"vehicle_uaz_fabric_dsr");
	common_scripts\_destructible::destructible_part("left_wheel_01_jnt","vehicle_uaz_wheel_LF",20,undefined,undefined,"no_melee",undefined,undefined);
	common_scripts\_destructible::destructible_part("left_wheel_02_jnt","vehicle_uaz_wheel_LF",20,undefined,undefined,"no_melee");
	common_scripts\_destructible::destructible_part("right_wheel_01_jnt","vehicle_uaz_wheel_RF",20,undefined,undefined,"no_melee",undefined,undefined);
	common_scripts\_destructible::destructible_part("right_wheel_02_jnt","vehicle_uaz_wheel_RF",20,undefined,undefined,"no_melee");
	common_scripts\_destructible::destructible_part("tag_door_left_front","vehicle_uaz_door_LF",undefined,undefined,undefined,undefined,1);
	common_scripts\_destructible::destructible_part("tag_door_right_front","vehicle_uaz_door_RF",undefined,undefined,undefined,undefined,1);
	common_scripts\_destructible::destructible_part("tag_door_left_back","vehicle_uaz_door_LB",undefined,undefined,undefined,undefined,1);
	common_scripts\_destructible::destructible_part("tag_door_right_back","vehicle_uaz_door_RB",undefined,undefined,undefined,undefined,1);
	var_01 = "tag_glass_front";
	common_scripts\_destructible::destructible_part(var_01,"vehicle_uaz_glass_F",10,undefined,undefined,undefined,undefined,undefined,1);
	common_scripts\_destructible::destructible_state(var_01,"vehicle_uaz_glass_F_dam",200,undefined,undefined,undefined,1);
	common_scripts\_destructible::destructible_fx("tag_glass_front_fx","fx/props/car_glass_large");
	common_scripts\_destructible::destructible_sound("veh_glass_break_large");
	common_scripts\_destructible::destructible_state(undefined);
	var_01 = "tag_glass_back";
	common_scripts\_destructible::destructible_part(var_01,"vehicle_uaz_fabric_glass_B",10,undefined,undefined,undefined,undefined,undefined,1);
	common_scripts\_destructible::destructible_state(var_01,"vehicle_uaz_fabric_glass_B_dam",200,undefined,undefined,undefined,1);
	common_scripts\_destructible::destructible_fx("tag_glass_back_fx","fx/props/car_glass_large");
	common_scripts\_destructible::destructible_sound("veh_glass_break_large");
	common_scripts\_destructible::destructible_state(undefined);
	var_01 = "tag_glass_left_front";
	common_scripts\_destructible::destructible_part(var_01,"vehicle_uaz_glass_LF",10,undefined,undefined,undefined,undefined,undefined,1);
	common_scripts\_destructible::destructible_state(var_01,"vehicle_uaz_glass_LF_dam",200,undefined,undefined,undefined,1);
	common_scripts\_destructible::destructible_fx("tag_glass_left_front_fx","fx/props/car_glass_med");
	common_scripts\_destructible::destructible_sound("veh_glass_break_large");
	common_scripts\_destructible::destructible_state(undefined);
	var_01 = "tag_glass_right_front";
	common_scripts\_destructible::destructible_part(var_01,"vehicle_uaz_glass_RF",10,undefined,undefined,undefined,undefined,undefined,1);
	common_scripts\_destructible::destructible_state(var_01,"vehicle_uaz_glass_RF_dam",200,undefined,undefined,undefined,1);
	common_scripts\_destructible::destructible_fx("tag_glass_right_front_fx","fx/props/car_glass_med");
	common_scripts\_destructible::destructible_sound("veh_glass_break_large");
	common_scripts\_destructible::destructible_state(undefined);
	var_01 = "tag_glass_left_back";
	common_scripts\_destructible::destructible_part(var_01,"vehicle_uaz_glass_LB",10,undefined,undefined,undefined,undefined,undefined,1);
	common_scripts\_destructible::destructible_state(var_01,"vehicle_uaz_glass_LB_dam",200,undefined,undefined,undefined,1);
	common_scripts\_destructible::destructible_fx("tag_glass_left_back_fx","fx/props/car_glass_med");
	common_scripts\_destructible::destructible_sound("veh_glass_break_large");
	common_scripts\_destructible::destructible_state(undefined);
	var_01 = "tag_glass_right_back";
	common_scripts\_destructible::destructible_part(var_01,"vehicle_uaz_glass_RB",10,undefined,undefined,undefined,undefined,undefined,1);
	common_scripts\_destructible::destructible_state(var_01,"vehicle_uaz_glass_RB_dam",200,undefined,undefined,undefined,1);
	common_scripts\_destructible::destructible_fx("tag_glass_right_back_fx","fx/props/car_glass_med");
	common_scripts\_destructible::destructible_sound("veh_glass_break_large");
	common_scripts\_destructible::destructible_state(undefined);
	var_01 = "tag_light_left_front";
	common_scripts\_destructible::destructible_part(var_01,"vehicle_uaz_light_LF",99,undefined,undefined,undefined,0.5);
	common_scripts\_destructible::destructible_fx(var_01,"fx/props/car_glass_headlight");
	common_scripts\_destructible::destructible_sound("veh_glass_break_small");
	common_scripts\_destructible::destructible_state(var_01,"vehicle_uaz_light_LF_dam");
	var_01 = "tag_light_right_front";
	common_scripts\_destructible::destructible_part(var_01,"vehicle_uaz_light_RF",99,undefined,undefined,undefined,0.5);
	common_scripts\_destructible::destructible_fx(var_01,"fx/props/car_glass_headlight");
	common_scripts\_destructible::destructible_sound("veh_glass_break_small");
	common_scripts\_destructible::destructible_state(var_01,"vehicle_uaz_light_RF_dam");
	common_scripts\_destructible::destructible_part("tag_mirror_left","vehicle_uaz_mirror_L",99);
	common_scripts\_destructible::destructible_physics();
	common_scripts\_destructible::destructible_part("tag_mirror_right","vehicle_uaz_mirror_R",99);
	common_scripts\_destructible::destructible_physics();
}

//Function Number: 27
vehicle_uaz_open(param_00)
{
	common_scripts\_destructible::destructible_create("vehicle_uaz_open",550,undefined,32,"no_melee");
	common_scripts\_destructible::destructible_loopfx("tag_hood_fx","fx/smoke/car_damage_whitesmoke",0.4);
	common_scripts\_destructible::destructible_state(undefined,"vehicle_uaz_open_destructible",200,undefined,32,"no_melee");
	common_scripts\_destructible::destructible_loopfx("tag_hood_fx","fx/smoke/car_damage_blacksmoke",0.4);
	common_scripts\_destructible::destructible_state(undefined,"vehicle_uaz_open_destructible",100,undefined,32,"no_melee");
	common_scripts\_destructible::destructible_loopfx("tag_hood_fx","fx/smoke/car_damage_blacksmoke_fire",0.4);
	common_scripts\_destructible::destructible_sound("fire_vehicle_flareup_med");
	common_scripts\_destructible::destructible_loopsound("fire_vehicle_med");
	common_scripts\_destructible::destructible_healthdrain(12,0.2,210,"allies");
	common_scripts\_destructible::destructible_state(undefined,"vehicle_uaz_open_destructible",300,"player_only",32,"no_melee");
	common_scripts\_destructible::destructible_loopsound("fire_vehicle_med");
	common_scripts\_destructible::destructible_state(undefined,"vehicle_uaz_open_destructible",100,"player_only",32,"no_melee");
	common_scripts\_destructible::destructible_fx("tag_origin","fx/explosions/small_vehicle_explosion",0);
	common_scripts\_destructible::destructible_sound("car_explode");
	common_scripts\_destructible::destructible_sound("fire_vehicle_small");
	common_scripts\_destructible::destructible_explode(4000,5000,200,150,300);
	common_scripts\_destructible::destructible_state(undefined,"vehicle_uaz_open_dsr");
	var_01 = "tag_glass_front";
	common_scripts\_destructible::destructible_part(var_01,"vehicle_uaz_glass_F",10,undefined,undefined,undefined,undefined,undefined,1);
	common_scripts\_destructible::destructible_state(var_01,"vehicle_uaz_glass_F_dam",200,undefined,undefined,undefined,1);
	common_scripts\_destructible::destructible_fx("tag_glass_front_fx","fx/props/car_glass_large");
	common_scripts\_destructible::destructible_sound("veh_glass_break_large");
	common_scripts\_destructible::destructible_state(undefined);
	common_scripts\_destructible::destructible_part("left_wheel_01_jnt","vehicle_uaz_wheel_LF",20,undefined,undefined,"no_melee",undefined);
	common_scripts\_destructible::destructible_part("left_wheel_02_jnt","vehicle_uaz_wheel_LF",20,undefined,undefined,"no_melee");
	common_scripts\_destructible::destructible_part("right_wheel_01_jnt","vehicle_uaz_wheel_RF",20,undefined,undefined,"no_melee",undefined);
	common_scripts\_destructible::destructible_part("right_wheel_02_jnt","vehicle_uaz_wheel_RF",20,undefined,undefined,"no_melee");
	common_scripts\_destructible::destructible_part("tag_door_left_front","vehicle_uaz_open_door_LF",undefined,undefined,undefined,undefined,1);
	common_scripts\_destructible::destructible_part("tag_door_right_front","vehicle_uaz_open_door_RF",undefined,undefined,undefined,undefined,1);
	common_scripts\_destructible::destructible_part("tag_door_left_back","vehicle_uaz_open_door_LB",undefined,undefined,undefined,undefined,1);
	common_scripts\_destructible::destructible_part("tag_door_right_back","vehicle_uaz_open_door_RB",undefined,undefined,undefined,undefined,1);
	var_01 = "tag_light_left_front";
	common_scripts\_destructible::destructible_part(var_01,"vehicle_uaz_light_LF",99,undefined,undefined,undefined,0.5);
	common_scripts\_destructible::destructible_fx(var_01,"fx/props/car_glass_headlight");
	common_scripts\_destructible::destructible_sound("veh_glass_break_small");
	common_scripts\_destructible::destructible_state(var_01,"vehicle_uaz_light_LF_dam");
	var_01 = "tag_light_right_front";
	common_scripts\_destructible::destructible_part(var_01,"vehicle_uaz_light_RF",99,undefined,undefined,undefined,0.5);
	common_scripts\_destructible::destructible_fx(var_01,"fx/props/car_glass_headlight");
	common_scripts\_destructible::destructible_sound("veh_glass_break_small");
	common_scripts\_destructible::destructible_state(var_01,"vehicle_uaz_light_RF_dam");
	common_scripts\_destructible::destructible_part("tag_mirror_left","vehicle_uaz_mirror_L",99);
	common_scripts\_destructible::destructible_physics();
	common_scripts\_destructible::destructible_part("tag_mirror_right","vehicle_uaz_mirror_R",99);
	common_scripts\_destructible::destructible_physics();
}

//Function Number: 28
vehicle_uaz_light(param_00)
{
	common_scripts\_destructible::destructible_create("vehicle_uaz_light",350,undefined,32,"no_melee");
	common_scripts\_destructible::destructible_loopfx("tag_hood_fx","fx/smoke/car_damage_whitesmoke",0.4);
	common_scripts\_destructible::destructible_state(undefined,"vehicle_uaz_light_destructible",200,undefined,32,"no_melee");
	common_scripts\_destructible::destructible_loopfx("tag_hood_fx","fx/smoke/car_damage_blacksmoke",0.4);
	common_scripts\_destructible::destructible_state(undefined,"vehicle_uaz_light_destructible",100,undefined,32,"no_melee");
	common_scripts\_destructible::destructible_loopfx("tag_hood_fx","fx/smoke/car_damage_blacksmoke_fire",0.4);
	common_scripts\_destructible::destructible_sound("fire_vehicle_flareup_med");
	common_scripts\_destructible::destructible_loopsound("fire_vehicle_med");
	common_scripts\_destructible::destructible_healthdrain(12,0.2,210,"allies");
	common_scripts\_destructible::destructible_state(undefined,"vehicle_uaz_light_destructible",300,"player_only",32,"no_melee");
	common_scripts\_destructible::destructible_loopsound("fire_vehicle_med");
	common_scripts\_destructible::destructible_state(undefined,"vehicle_uaz_light_destructible",100,"player_only",32,"no_melee");
	common_scripts\_destructible::destructible_fx("tag_origin","fx/explosions/small_vehicle_explosion",0);
	common_scripts\_destructible::destructible_sound("car_explode");
	common_scripts\_destructible::destructible_sound("fire_vehicle_small");
	common_scripts\_destructible::destructible_explode(4000,5000,200,150,300);
	common_scripts\_destructible::destructible_state(undefined,"vehicle_uaz_light_dsr");
	var_01 = "tag_glass_front";
	common_scripts\_destructible::destructible_part(var_01,"vehicle_uaz_glass_F",10,undefined,undefined,undefined,undefined,undefined,1);
	common_scripts\_destructible::destructible_state(var_01,"vehicle_uaz_glass_F_dam",200,undefined,undefined,undefined,1);
	common_scripts\_destructible::destructible_fx("tag_glass_front_fx","fx/props/car_glass_large");
	common_scripts\_destructible::destructible_sound("veh_glass_break_large");
	common_scripts\_destructible::destructible_state(undefined);
	var_01 = "tag_glass_left_front";
	common_scripts\_destructible::destructible_part(var_01,"vehicle_uaz_glass_LF",10,undefined,undefined,undefined,undefined,undefined,1);
	common_scripts\_destructible::destructible_state(var_01,"vehicle_uaz_glass_LF_dam",200,undefined,undefined,undefined,1);
	common_scripts\_destructible::destructible_fx("tag_glass_left_front_fx","fx/props/car_glass_med");
	common_scripts\_destructible::destructible_sound("veh_glass_break_large");
	common_scripts\_destructible::destructible_state(undefined);
	var_01 = "tag_glass_right_front";
	common_scripts\_destructible::destructible_part(var_01,"vehicle_uaz_glass_RF",10,undefined,undefined,undefined,undefined,undefined,1);
	common_scripts\_destructible::destructible_state(var_01,"vehicle_uaz_glass_RF_dam",200,undefined,undefined,undefined,1);
	common_scripts\_destructible::destructible_fx("tag_glass_right_front_fx","fx/props/car_glass_med");
	common_scripts\_destructible::destructible_sound("veh_glass_break_large");
	common_scripts\_destructible::destructible_state(undefined);
	var_01 = "tag_glass_left_back";
	common_scripts\_destructible::destructible_part(var_01,"vehicle_uaz_glass_LB",10,undefined,undefined,undefined,undefined,undefined,1);
	common_scripts\_destructible::destructible_state(var_01,"vehicle_uaz_glass_LB_dam",200,undefined,undefined,undefined,1);
	common_scripts\_destructible::destructible_fx("tag_glass_left_back_fx","fx/props/car_glass_med");
	common_scripts\_destructible::destructible_sound("veh_glass_break_large");
	common_scripts\_destructible::destructible_state(undefined);
	var_01 = "tag_glass_right_back";
	common_scripts\_destructible::destructible_part(var_01,"vehicle_uaz_glass_RB",10,undefined,undefined,undefined,undefined,undefined,1);
	common_scripts\_destructible::destructible_state(var_01,"vehicle_uaz_glass_RB_dam",200,undefined,undefined,undefined,1);
	common_scripts\_destructible::destructible_fx("tag_glass_right_back_fx","fx/props/car_glass_med");
	common_scripts\_destructible::destructible_sound("veh_glass_break_large");
	common_scripts\_destructible::destructible_state(undefined);
	common_scripts\_destructible::destructible_part("left_wheel_01_jnt","vehicle_uaz_wheel_LF",20,undefined,undefined,"no_melee",undefined);
	common_scripts\_destructible::destructible_part("left_wheel_02_jnt","vehicle_uaz_wheel_LF",20,undefined,undefined,"no_melee");
	common_scripts\_destructible::destructible_part("right_wheel_01_jnt","vehicle_uaz_wheel_RF",20,undefined,undefined,"no_melee",undefined);
	common_scripts\_destructible::destructible_part("right_wheel_02_jnt","vehicle_uaz_wheel_RF",20,undefined,undefined,"no_melee");
	common_scripts\_destructible::destructible_part("tag_door_left_front","vehicle_uaz_door_LF",undefined,undefined,undefined,undefined,1);
	common_scripts\_destructible::destructible_part("tag_door_right_front","vehicle_uaz_door_RF",undefined,undefined,undefined,undefined,1);
	common_scripts\_destructible::destructible_part("tag_door_left_back","vehicle_uaz_door_LB",undefined,undefined,undefined,undefined,1);
	common_scripts\_destructible::destructible_part("tag_door_right_back","vehicle_uaz_door_RB",undefined,undefined,undefined,undefined,1);
	var_01 = "tag_light_left_front";
	common_scripts\_destructible::destructible_part(var_01,"vehicle_uaz_light_LF",99,undefined,undefined,undefined,0.5);
	common_scripts\_destructible::destructible_fx(var_01,"fx/props/car_glass_headlight");
	common_scripts\_destructible::destructible_sound("veh_glass_break_small");
	common_scripts\_destructible::destructible_state(var_01,"vehicle_uaz_light_LF_dam");
	var_01 = "tag_light_right_front";
	common_scripts\_destructible::destructible_part(var_01,"vehicle_uaz_light_RF",99,undefined,undefined,undefined,0.5);
	common_scripts\_destructible::destructible_fx(var_01,"fx/props/car_glass_headlight");
	common_scripts\_destructible::destructible_sound("veh_glass_break_small");
	common_scripts\_destructible::destructible_state(var_01,"vehicle_uaz_light_RF_dam");
	common_scripts\_destructible::destructible_part("tag_mirror_left","vehicle_uaz_mirror_L",99);
	common_scripts\_destructible::destructible_physics();
	common_scripts\_destructible::destructible_part("tag_mirror_right","vehicle_uaz_mirror_R",99);
	common_scripts\_destructible::destructible_physics();
}

//Function Number: 29
vehicle_uaz_hardtop(param_00)
{
	common_scripts\_destructible::destructible_create("vehicle_uaz_hardtop",550,undefined,32,"no_melee");
	common_scripts\_destructible::destructible_loopfx("tag_hood_fx","fx/smoke/car_damage_whitesmoke",0.4);
	common_scripts\_destructible::destructible_state(undefined,"vehicle_uaz_hardtop_destructible",200,undefined,32,"no_melee");
	common_scripts\_destructible::destructible_loopfx("tag_hood_fx","fx/smoke/car_damage_blacksmoke",0.4);
	common_scripts\_destructible::destructible_state(undefined,"vehicle_uaz_hardtop_destructible",100,undefined,32,"no_melee");
	common_scripts\_destructible::destructible_loopfx("tag_hood_fx","fx/smoke/car_damage_blacksmoke_fire",0.4);
	common_scripts\_destructible::destructible_sound("fire_vehicle_flareup_med");
	common_scripts\_destructible::destructible_loopsound("fire_vehicle_med");
	common_scripts\_destructible::destructible_healthdrain(12,0.2,210,"allies");
	common_scripts\_destructible::destructible_state(undefined,"vehicle_uaz_hardtop_destructible",300,"player_only",32,"no_melee");
	common_scripts\_destructible::destructible_loopsound("fire_vehicle_med");
	common_scripts\_destructible::destructible_state(undefined,"vehicle_uaz_hardtop_destructible",100,"player_only",32,"no_melee");
	common_scripts\_destructible::destructible_fx("tag_origin","fx/explosions/small_vehicle_explosion",0);
	common_scripts\_destructible::destructible_sound("car_explode");
	common_scripts\_destructible::destructible_sound("fire_vehicle_small");
	common_scripts\_destructible::destructible_explode(4000,5000,200,150,300);
	common_scripts\_destructible::destructible_state(undefined,"vehicle_uaz_hardtop_dsr");
	common_scripts\_destructible::destructible_part("tag_door_left_front","vehicle_uaz_door_LF",undefined,undefined,undefined,undefined,1);
	common_scripts\_destructible::destructible_part("tag_door_right_front","vehicle_uaz_door_RF",undefined,undefined,undefined,undefined,1);
	common_scripts\_destructible::destructible_part("tag_door_left_back","vehicle_uaz_door_LB",undefined,undefined,undefined,undefined,1);
	common_scripts\_destructible::destructible_part("tag_door_right_back","vehicle_uaz_door_RB",undefined,undefined,undefined,undefined,1);
	var_01 = "tag_glass_front";
	common_scripts\_destructible::destructible_part(var_01,"vehicle_uaz_glass_F",10,undefined,undefined,undefined,undefined,undefined,1);
	common_scripts\_destructible::destructible_state(var_01,"vehicle_uaz_glass_F_dam",200,undefined,undefined,undefined,1);
	common_scripts\_destructible::destructible_fx("tag_glass_front_fx","fx/props/car_glass_large");
	common_scripts\_destructible::destructible_sound("veh_glass_break_large");
	common_scripts\_destructible::destructible_state(undefined);
	var_01 = "tag_glass_back";
	common_scripts\_destructible::destructible_part(var_01,"vehicle_uaz_glass_B",10,undefined,undefined,undefined,undefined,undefined,1);
	common_scripts\_destructible::destructible_state(var_01,"vehicle_uaz_glass_B_dam",200,undefined,undefined,undefined,1);
	common_scripts\_destructible::destructible_fx("tag_glass_back_fx","fx/props/car_glass_large");
	common_scripts\_destructible::destructible_sound("veh_glass_break_large");
	common_scripts\_destructible::destructible_state(undefined);
	var_01 = "tag_glass_left_front";
	common_scripts\_destructible::destructible_part(var_01,"vehicle_uaz_glass_LF",10,undefined,undefined,undefined,undefined,undefined,1);
	common_scripts\_destructible::destructible_state(var_01,"vehicle_uaz_glass_LF_dam",200,undefined,undefined,undefined,1);
	common_scripts\_destructible::destructible_fx("tag_glass_left_front_fx","fx/props/car_glass_med");
	common_scripts\_destructible::destructible_sound("veh_glass_break_large");
	common_scripts\_destructible::destructible_state(undefined);
	var_01 = "tag_glass_right_front";
	common_scripts\_destructible::destructible_part(var_01,"vehicle_uaz_glass_RF",10,undefined,undefined,undefined,undefined,undefined,1);
	common_scripts\_destructible::destructible_state(var_01,"vehicle_uaz_glass_RF_dam",200,undefined,undefined,undefined,1);
	common_scripts\_destructible::destructible_fx("tag_glass_right_front_fx","fx/props/car_glass_med");
	common_scripts\_destructible::destructible_sound("veh_glass_break_large");
	common_scripts\_destructible::destructible_state(undefined);
	var_01 = "tag_glass_left_back";
	common_scripts\_destructible::destructible_part(var_01,"vehicle_uaz_glass_LB",10,undefined,undefined,undefined,undefined,undefined,1);
	common_scripts\_destructible::destructible_state(var_01,"vehicle_uaz_glass_LB_dam",200,undefined,undefined,undefined,1);
	common_scripts\_destructible::destructible_fx("tag_glass_left_back_fx","fx/props/car_glass_med");
	common_scripts\_destructible::destructible_sound("veh_glass_break_large");
	common_scripts\_destructible::destructible_state(undefined);
	var_01 = "tag_glass_right_back";
	common_scripts\_destructible::destructible_part(var_01,"vehicle_uaz_glass_RB",10,undefined,undefined,undefined,undefined,undefined,1);
	common_scripts\_destructible::destructible_state(var_01,"vehicle_uaz_glass_RB_dam",200,undefined,undefined,undefined,1);
	common_scripts\_destructible::destructible_fx("tag_glass_right_back_fx","fx/props/car_glass_med");
	common_scripts\_destructible::destructible_sound("veh_glass_break_large");
	common_scripts\_destructible::destructible_state(undefined);
	var_01 = "tag_glass_left_back2";
	common_scripts\_destructible::destructible_part(var_01,"vehicle_uaz_glass_LB2",10,undefined,undefined,undefined,undefined,undefined,1);
	common_scripts\_destructible::destructible_state(var_01,"vehicle_uaz_glass_LB2_dam",200,undefined,undefined,undefined,1);
	common_scripts\_destructible::destructible_fx("tag_glass_left_back2_fx","fx/props/car_glass_med");
	common_scripts\_destructible::destructible_sound("veh_glass_break_large");
	common_scripts\_destructible::destructible_state(undefined);
	var_01 = "tag_glass_right_back2";
	common_scripts\_destructible::destructible_part(var_01,"vehicle_uaz_glass_RB2",10,undefined,undefined,undefined,undefined,undefined,1);
	common_scripts\_destructible::destructible_state(var_01,"vehicle_uaz_glass_RB2_dam",200,undefined,undefined,undefined,1);
	common_scripts\_destructible::destructible_fx("tag_glass_right_back2_fx","fx/props/car_glass_med");
	common_scripts\_destructible::destructible_sound("veh_glass_break_large");
	common_scripts\_destructible::destructible_state(undefined);
	common_scripts\_destructible::destructible_part("left_wheel_01_jnt","vehicle_uaz_wheel_LF",20,undefined,undefined,"no_melee",undefined);
	common_scripts\_destructible::destructible_part("left_wheel_02_jnt","vehicle_uaz_wheel_LF",20,undefined,undefined,"no_melee");
	common_scripts\_destructible::destructible_part("right_wheel_01_jnt","vehicle_uaz_wheel_RF",20,undefined,undefined,"no_melee",undefined);
	common_scripts\_destructible::destructible_part("right_wheel_02_jnt","vehicle_uaz_wheel_RF",20,undefined,undefined,"no_melee");
	var_01 = "tag_light_left_front";
	common_scripts\_destructible::destructible_part(var_01,"vehicle_uaz_light_LF",99,undefined,undefined,undefined,0.5);
	common_scripts\_destructible::destructible_fx(var_01,"fx/props/car_glass_headlight");
	common_scripts\_destructible::destructible_sound("veh_glass_break_small");
	common_scripts\_destructible::destructible_state(var_01,"vehicle_uaz_light_LF_dam");
	var_01 = "tag_light_right_front";
	common_scripts\_destructible::destructible_part(var_01,"vehicle_uaz_light_RF",99,undefined,undefined,undefined,0.5);
	common_scripts\_destructible::destructible_fx(var_01,"fx/props/car_glass_headlight");
	common_scripts\_destructible::destructible_sound("veh_glass_break_small");
	common_scripts\_destructible::destructible_state(var_01,"vehicle_uaz_light_RF_dam");
	common_scripts\_destructible::destructible_part("tag_mirror_left","vehicle_uaz_mirror_L",99);
	common_scripts\_destructible::destructible_physics();
	common_scripts\_destructible::destructible_part("tag_mirror_right","vehicle_uaz_mirror_R",99);
	common_scripts\_destructible::destructible_physics();
}

//Function Number: 30
vehicle_uaz_open_for_ride(param_00)
{
	common_scripts\_destructible::destructible_create("vehicle_uaz_open_for_ride",550,undefined,32,"no_melee");
	common_scripts\_destructible::destructible_state(undefined,"vehicle_uaz_open_destructible",100,"player_only",32,"no_melee");
	common_scripts\_destructible::destructible_fx("tag_origin","fx/explosions/small_vehicle_explosion",0);
	common_scripts\_destructible::destructible_sound("car_explode");
	common_scripts\_destructible::destructible_sound("fire_vehicle_small");
	common_scripts\_destructible::destructible_explode(4000,5000,200,150,300);
	var_01 = "tag_glass_front";
	common_scripts\_destructible::destructible_part(var_01,"vehicle_uaz_glass_F",10,undefined,undefined,undefined,undefined,undefined,1);
	common_scripts\_destructible::destructible_state(var_01,"vehicle_uaz_glass_F_dam",200,undefined,undefined,undefined,1);
	common_scripts\_destructible::destructible_fx("tag_glass_front_fx","fx/props/car_glass_large");
	common_scripts\_destructible::destructible_sound("veh_glass_break_large");
	common_scripts\_destructible::destructible_state(undefined);
}

//Function Number: 31
vehicle_80s_sedan1_nofire(param_00)
{
	common_scripts\_destructible::destructible_create("vehicle_80s_sedan1_" + param_00 + "_nofire",300,undefined,32,"no_melee");
	common_scripts\_destructible::destructible_loopfx("tag_hood_fx","fx/smoke/car_damage_whitesmoke",0.4);
	common_scripts\_destructible::destructible_state(undefined,"vehicle_80s_sedan1_" + param_00 + "_destructible",200,undefined,32,"no_melee");
	common_scripts\_destructible::destructible_loopfx("tag_hood_fx","fx/smoke/car_damage_blacksmoke",0.4);
	common_scripts\_destructible::destructible_state(undefined,"vehicle_80s_sedan1_" + param_00 + "_destructible",100,undefined,32,"no_melee");
	common_scripts\_destructible::destructible_loopfx("tag_hood_fx","fx/smoke/car_damage_blacksmoke_fire",0.4);
	common_scripts\_destructible::destructible_sound("fire_vehicle_flareup_med");
	common_scripts\_destructible::destructible_loopsound("fire_vehicle_med");
	common_scripts\_destructible::destructible_healthdrain(12,0.2,210,"allies");
	common_scripts\_destructible::destructible_state(undefined,"vehicle_80s_sedan1_" + param_00 + "_destructible",300,"player_only",32,"no_melee");
	common_scripts\_destructible::destructible_loopsound("fire_vehicle_med");
	common_scripts\_destructible::destructible_state(undefined,"vehicle_80s_sedan1_" + param_00 + "_destructible",400,undefined,32,"no_melee");
	common_scripts\_destructible::destructible_fx("tag_death_fx","fx/explosions/small_vehicle_explosion_nofire",0);
	common_scripts\_destructible::destructible_sound("car_explode");
	common_scripts\_destructible::destructible_explode(4000,5000,200,150,300);
	common_scripts\_destructible::destructible_anim(%vehicle_80s_sedan1_destroy,#animtree,"setanimknob");
	common_scripts\_destructible::destructible_state(undefined,"vehicle_80s_sedan1_" + param_00 + "_destroyed",undefined,32,"no_melee");
	var_01 = "tag_hood";
	common_scripts\_destructible::destructible_part(var_01,"vehicle_80s_sedan1_" + param_00 + "_hood",800,undefined,undefined,undefined,1,2.5);
	common_scripts\_destructible::destructible_state(var_01,"vehicle_80s_sedan1_" + param_00 + "_hood_dam");
	var_01 = "tag_trunk";
	common_scripts\_destructible::destructible_part(var_01,"vehicle_80s_sedan1_" + param_00 + "_trunk",1000,undefined,undefined,undefined,1);
	common_scripts\_destructible::destructible_state(var_01,"vehicle_80s_sedan1_" + param_00 + "_trunk_dam",2000);
	common_scripts\_destructible::destructible_part("left_wheel_01_jnt","vehicle_80s_sedan1_" + param_00 + "_wheel_LF",20,undefined,undefined,"no_melee",undefined,0,undefined,1);
	common_scripts\_destructible::destructible_anim(%vehicle_80s_sedan1_flattire_lf,#animtree,"setanim");
	common_scripts\_destructible::destructible_anim(%vehicle_80s_sedan1_flattire_tire,#animtree,"setanim",1);
	common_scripts\_destructible::destructible_sound("veh_tire_deflate","bullet");
	common_scripts\_destructible::destructible_part("left_wheel_02_jnt","vehicle_80s_sedan1_" + param_00 + "_wheel_LF",20,undefined,undefined,"no_melee",undefined,0,undefined,1);
	common_scripts\_destructible::destructible_anim(%vehicle_80s_sedan1_flattire_lb,#animtree,"setanim");
	common_scripts\_destructible::destructible_anim(%vehicle_80s_sedan1_flattire_tire,#animtree,"setanim",1);
	common_scripts\_destructible::destructible_sound("veh_tire_deflate","bullet");
	common_scripts\_destructible::destructible_part("right_wheel_01_jnt","vehicle_80s_sedan1_" + param_00 + "_wheel_LF",20,undefined,undefined,"no_melee",undefined,1.7,undefined,1);
	common_scripts\_destructible::destructible_anim(%vehicle_80s_sedan1_flattire_rf,#animtree,"setanim");
	common_scripts\_destructible::destructible_anim(%vehicle_80s_sedan1_flattire_tire,#animtree,"setanim",1);
	common_scripts\_destructible::destructible_sound("veh_tire_deflate","bullet");
	common_scripts\_destructible::destructible_part("right_wheel_02_jnt","vehicle_80s_sedan1_" + param_00 + "_wheel_LF",20,undefined,undefined,"no_melee",undefined,1.7,undefined,1);
	common_scripts\_destructible::destructible_anim(%vehicle_80s_sedan1_flattire_rb,#animtree,"setanim");
	common_scripts\_destructible::destructible_anim(%vehicle_80s_sedan1_flattire_tire,#animtree,"setanim",1);
	common_scripts\_destructible::destructible_sound("veh_tire_deflate","bullet");
	common_scripts\_destructible::destructible_part("tag_door_left_front","vehicle_80s_sedan1_" + param_00 + "_door_LF",undefined,undefined,undefined,undefined,1);
	common_scripts\_destructible::destructible_part("tag_door_left_back","vehicle_80s_sedan1_" + param_00 + "_door_LB",undefined,undefined,undefined,undefined,1);
	common_scripts\_destructible::destructible_part("tag_door_right_front","vehicle_80s_sedan1_" + param_00 + "_door_RF",undefined,undefined,undefined,undefined,1,1);
	common_scripts\_destructible::destructible_part("tag_door_right_back","vehicle_80s_sedan1_" + param_00 + "_door_RB",undefined,undefined,undefined,undefined,1,1);
	var_01 = "tag_glass_front";
	common_scripts\_destructible::destructible_part(var_01,"vehicle_80s_sedan1_glass_F",10,undefined,undefined,undefined,undefined,undefined,1);
	common_scripts\_destructible::destructible_state(var_01,"vehicle_80s_sedan1_glass_F_dam",200,undefined,undefined,undefined,1);
	common_scripts\_destructible::destructible_fx("tag_glass_front_fx","fx/props/car_glass_large");
	common_scripts\_destructible::destructible_sound("veh_glass_break_large");
	common_scripts\_destructible::destructible_state(undefined);
	var_01 = "tag_glass_back";
	common_scripts\_destructible::destructible_part(var_01,"vehicle_80s_sedan1_glass_B",10,undefined,undefined,undefined,undefined,undefined,1);
	common_scripts\_destructible::destructible_state(var_01,"vehicle_80s_sedan1_glass_B_dam",200,undefined,undefined,undefined,1);
	common_scripts\_destructible::destructible_fx("tag_glass_back_fx","fx/props/car_glass_large");
	common_scripts\_destructible::destructible_sound("veh_glass_break_large");
	common_scripts\_destructible::destructible_state(undefined);
	var_01 = "tag_glass_left_front";
	common_scripts\_destructible::destructible_part(var_01,"vehicle_80s_sedan1_glass_LF",10,undefined,undefined,undefined,undefined,undefined,1);
	common_scripts\_destructible::destructible_state(var_01,"vehicle_80s_sedan1_glass_LF_dam",200,undefined,undefined,undefined,1);
	common_scripts\_destructible::destructible_fx("tag_glass_left_front_fx","fx/props/car_glass_med");
	common_scripts\_destructible::destructible_sound("veh_glass_break_large");
	common_scripts\_destructible::destructible_state(undefined);
	var_01 = "tag_glass_right_front";
	common_scripts\_destructible::destructible_part(var_01,"vehicle_80s_sedan1_glass_RF",10,undefined,undefined,undefined,undefined,undefined,1);
	common_scripts\_destructible::destructible_state(var_01,"vehicle_80s_sedan1_glass_RF_dam",200,undefined,undefined,undefined,1);
	common_scripts\_destructible::destructible_fx("tag_glass_right_front_fx","fx/props/car_glass_med");
	common_scripts\_destructible::destructible_sound("veh_glass_break_large");
	common_scripts\_destructible::destructible_state(undefined);
	var_01 = "tag_glass_left_back";
	common_scripts\_destructible::destructible_part(var_01,"vehicle_80s_sedan1_glass_LB",10,undefined,undefined,undefined,undefined,undefined,1);
	common_scripts\_destructible::destructible_state(var_01,"vehicle_80s_sedan1_glass_LB_dam",200,undefined,undefined,undefined,1);
	common_scripts\_destructible::destructible_fx("tag_glass_left_back_fx","fx/props/car_glass_med");
	common_scripts\_destructible::destructible_sound("veh_glass_break_large");
	common_scripts\_destructible::destructible_state(undefined);
	var_01 = "tag_glass_right_back";
	common_scripts\_destructible::destructible_part(var_01,"vehicle_80s_sedan1_glass_RB",10,undefined,undefined,undefined,undefined,undefined,1);
	common_scripts\_destructible::destructible_state(var_01,"vehicle_80s_sedan1_glass_RB_dam",200,undefined,undefined,undefined,1);
	common_scripts\_destructible::destructible_fx("tag_glass_right_back_fx","fx/props/car_glass_med");
	common_scripts\_destructible::destructible_sound("veh_glass_break_large");
	common_scripts\_destructible::destructible_state(undefined);
	var_01 = "tag_light_left_front";
	common_scripts\_destructible::destructible_part(var_01,"vehicle_80s_sedan1_" + param_00 + "_light_LF",10,undefined,undefined,undefined,0.5);
	common_scripts\_destructible::destructible_fx(var_01,"fx/props/car_glass_headlight");
	common_scripts\_destructible::destructible_sound("veh_glass_break_small");
	common_scripts\_destructible::destructible_state(var_01,"vehicle_80s_sedan1_" + param_00 + "_light_LF_dam");
	var_01 = "tag_light_right_front";
	common_scripts\_destructible::destructible_part(var_01,"vehicle_80s_sedan1_" + param_00 + "_light_RF",10,undefined,undefined,undefined,0.5);
	common_scripts\_destructible::destructible_fx(var_01,"fx/props/car_glass_headlight");
	common_scripts\_destructible::destructible_sound("veh_glass_break_small");
	common_scripts\_destructible::destructible_state(var_01,"vehicle_80s_sedan1_" + param_00 + "_light_RF_dam");
	var_01 = "tag_light_left_back";
	common_scripts\_destructible::destructible_part(var_01,"vehicle_80s_sedan1_" + param_00 + "_light_LB",10);
	common_scripts\_destructible::destructible_fx(var_01,"fx/props/car_glass_brakelight");
	common_scripts\_destructible::destructible_sound("veh_glass_break_small");
	common_scripts\_destructible::destructible_state(var_01,"vehicle_80s_sedan1_" + param_00 + "_light_LB_dam");
	var_01 = "tag_light_right_back";
	common_scripts\_destructible::destructible_part(var_01,"vehicle_80s_sedan1_" + param_00 + "_light_RB",10);
	common_scripts\_destructible::destructible_fx(var_01,"fx/props/car_glass_brakelight");
	common_scripts\_destructible::destructible_sound("veh_glass_break_small");
	common_scripts\_destructible::destructible_state(var_01,"vehicle_80s_sedan1_" + param_00 + "_light_RB_dam");
	common_scripts\_destructible::destructible_part("tag_bumper_front","vehicle_80s_sedan1_" + param_00 + "_bumper_F",undefined,undefined,undefined,undefined,1,1);
	common_scripts\_destructible::destructible_part("tag_bumper_back","vehicle_80s_sedan1_" + param_00 + "_bumper_B",undefined,undefined,undefined,undefined,undefined,1);
	common_scripts\_destructible::destructible_part("tag_mirror_left","vehicle_80s_sedan1_" + param_00 + "_mirror_L",10);
	common_scripts\_destructible::destructible_physics();
	common_scripts\_destructible::destructible_part("tag_mirror_right","vehicle_80s_sedan1_" + param_00 + "_mirror_R",10,undefined,undefined,undefined,undefined,1);
	common_scripts\_destructible::destructible_physics();
}

//Function Number: 32
vehicle_80s_wagon1_nofire(param_00)
{
	common_scripts\_destructible::destructible_create("vehicle_80s_wagon1_" + param_00 + "_nofire",300,undefined,32,"no_melee");
	common_scripts\_destructible::destructible_loopfx("tag_hood_fx","fx/smoke/car_damage_whitesmoke",0.4);
	common_scripts\_destructible::destructible_state(undefined,"vehicle_80s_wagon1_" + param_00 + "_destructible",200,undefined,32,"no_melee");
	common_scripts\_destructible::destructible_loopfx("tag_hood_fx","fx/smoke/car_damage_blacksmoke",0.4);
	common_scripts\_destructible::destructible_state(undefined,"vehicle_80s_wagon1_" + param_00 + "_destructible",100,undefined,32,"no_melee");
	common_scripts\_destructible::destructible_loopfx("tag_hood_fx","fx/smoke/car_damage_blacksmoke_fire",0.4);
	common_scripts\_destructible::destructible_sound("fire_vehicle_flareup_med");
	common_scripts\_destructible::destructible_loopsound("fire_vehicle_med");
	common_scripts\_destructible::destructible_healthdrain(12,0.2,210,"allies");
	common_scripts\_destructible::destructible_state(undefined,"vehicle_80s_wagon1_" + param_00 + "_destructible",300,"player_only",32,"no_melee");
	common_scripts\_destructible::destructible_loopsound("fire_vehicle_med");
	common_scripts\_destructible::destructible_state(undefined,"vehicle_80s_wagon1_" + param_00 + "_destructible",400,undefined,32,"no_melee");
	common_scripts\_destructible::destructible_fx("tag_death_fx","fx/explosions/small_vehicle_explosion_nofire",0);
	common_scripts\_destructible::destructible_sound("car_explode");
	common_scripts\_destructible::destructible_explode(4000,5000,200,150,300);
	common_scripts\_destructible::destructible_anim(%vehicle_80s_sedan1_destroy,#animtree,"setanimknob");
	common_scripts\_destructible::destructible_state(undefined,"vehicle_80s_wagon1_" + param_00 + "_destroyed",undefined,32,"no_melee");
	var_01 = "tag_hood";
	common_scripts\_destructible::destructible_part(var_01,"vehicle_80s_wagon1_" + param_00 + "_hood",800,undefined,undefined,undefined,1,1.5);
	common_scripts\_destructible::destructible_state(var_01,"vehicle_80s_wagon1_" + param_00 + "_hood_dam");
	common_scripts\_destructible::destructible_part("left_wheel_01_jnt","vehicle_80s_wagon1_" + param_00 + "_wheel_LF",20,undefined,undefined,"no_melee",undefined,0,undefined,1);
	common_scripts\_destructible::destructible_anim(%vehicle_80s_sedan1_flattire_lf,#animtree,"setanim");
	common_scripts\_destructible::destructible_anim(%vehicle_80s_sedan1_flattire_tire,#animtree,"setanim",1);
	common_scripts\_destructible::destructible_sound("veh_tire_deflate","bullet");
	common_scripts\_destructible::destructible_part("left_wheel_02_jnt","vehicle_80s_wagon1_" + param_00 + "_wheel_LF",20,undefined,undefined,"no_melee",undefined,1.7,undefined,1);
	common_scripts\_destructible::destructible_anim(%vehicle_80s_sedan1_flattire_lb,#animtree,"setanim");
	common_scripts\_destructible::destructible_anim(%vehicle_80s_sedan1_flattire_tire,#animtree,"setanim",1);
	common_scripts\_destructible::destructible_sound("veh_tire_deflate","bullet");
	common_scripts\_destructible::destructible_part("right_wheel_01_jnt","vehicle_80s_wagon1_" + param_00 + "_wheel_LF",20,undefined,undefined,"no_melee",undefined,0,undefined,1);
	common_scripts\_destructible::destructible_anim(%vehicle_80s_sedan1_flattire_rf,#animtree,"setanim");
	common_scripts\_destructible::destructible_anim(%vehicle_80s_sedan1_flattire_tire,#animtree,"setanim",1);
	common_scripts\_destructible::destructible_sound("veh_tire_deflate","bullet");
	common_scripts\_destructible::destructible_part("right_wheel_02_jnt","vehicle_80s_wagon1_" + param_00 + "_wheel_LF",20,undefined,undefined,"no_melee",undefined,1.7,undefined,1);
	common_scripts\_destructible::destructible_anim(%vehicle_80s_sedan1_flattire_rb,#animtree,"setanim");
	common_scripts\_destructible::destructible_anim(%vehicle_80s_sedan1_flattire_tire,#animtree,"setanim",1);
	common_scripts\_destructible::destructible_sound("veh_tire_deflate","bullet");
	common_scripts\_destructible::destructible_part("tag_door_left_front","vehicle_80s_wagon1_" + param_00 + "_door_LF",undefined,undefined,undefined,undefined,1);
	common_scripts\_destructible::destructible_part("tag_door_left_back","vehicle_80s_wagon1_" + param_00 + "_door_LB",undefined,undefined,undefined,undefined,1);
	common_scripts\_destructible::destructible_part("tag_door_right_front","vehicle_80s_wagon1_" + param_00 + "_door_RF",undefined,undefined,undefined,undefined,1);
	common_scripts\_destructible::destructible_part("tag_door_right_back","vehicle_80s_wagon1_" + param_00 + "_door_RB",undefined,undefined,undefined,undefined,1,1);
	var_01 = "tag_glass_front";
	common_scripts\_destructible::destructible_part(var_01,"vehicle_80s_wagon1_glass_F",10,undefined,undefined,undefined,undefined,undefined,1);
	common_scripts\_destructible::destructible_state(var_01,"vehicle_80s_wagon1_glass_F_dam",200,undefined,undefined,undefined,1);
	common_scripts\_destructible::destructible_fx("tag_glass_front_fx","fx/props/car_glass_large");
	common_scripts\_destructible::destructible_sound("veh_glass_break_large");
	common_scripts\_destructible::destructible_state(undefined);
	var_01 = "tag_glass_back";
	common_scripts\_destructible::destructible_part(var_01,"vehicle_80s_wagon1_glass_B",10,undefined,undefined,undefined,undefined,undefined,1);
	common_scripts\_destructible::destructible_state(var_01,"vehicle_80s_wagon1_glass_B_dam",200,undefined,undefined,undefined,1);
	common_scripts\_destructible::destructible_fx("tag_glass_back_fx","fx/props/car_glass_large");
	common_scripts\_destructible::destructible_sound("veh_glass_break_large");
	common_scripts\_destructible::destructible_state(undefined);
	var_01 = "tag_glass_left_front";
	common_scripts\_destructible::destructible_part(var_01,"vehicle_80s_wagon1_glass_LF",10,undefined,undefined,undefined,undefined,undefined,1);
	common_scripts\_destructible::destructible_state(var_01,"vehicle_80s_wagon1_glass_LF_dam",200,undefined,undefined,undefined,1);
	common_scripts\_destructible::destructible_fx("tag_glass_left_front_fx","fx/props/car_glass_med");
	common_scripts\_destructible::destructible_sound("veh_glass_break_large");
	common_scripts\_destructible::destructible_state(undefined);
	var_01 = "tag_glass_right_front";
	common_scripts\_destructible::destructible_part(var_01,"vehicle_80s_wagon1_glass_RF",10,undefined,undefined,undefined,undefined,undefined,1);
	common_scripts\_destructible::destructible_state(var_01,"vehicle_80s_wagon1_glass_RF_dam",200,undefined,undefined,undefined,1);
	common_scripts\_destructible::destructible_fx("tag_glass_right_front_fx","fx/props/car_glass_med");
	common_scripts\_destructible::destructible_sound("veh_glass_break_large");
	common_scripts\_destructible::destructible_state(undefined);
	var_01 = "tag_glass_left_back";
	common_scripts\_destructible::destructible_part(var_01,"vehicle_80s_wagon1_glass_LB",10,undefined,undefined,undefined,undefined,undefined,1);
	common_scripts\_destructible::destructible_state(var_01,"vehicle_80s_wagon1_glass_LB_dam",200,undefined,undefined,undefined,1);
	common_scripts\_destructible::destructible_fx("tag_glass_left_back_fx","fx/props/car_glass_med");
	common_scripts\_destructible::destructible_sound("veh_glass_break_large");
	common_scripts\_destructible::destructible_state(undefined);
	var_01 = "tag_glass_right_back";
	common_scripts\_destructible::destructible_part(var_01,"vehicle_80s_wagon1_glass_RB",10,undefined,undefined,undefined,undefined,undefined,1);
	common_scripts\_destructible::destructible_state(var_01,"vehicle_80s_wagon1_glass_RB_dam",200,undefined,undefined,undefined,1);
	common_scripts\_destructible::destructible_fx("tag_glass_right_back_fx","fx/props/car_glass_med");
	common_scripts\_destructible::destructible_sound("veh_glass_break_large");
	common_scripts\_destructible::destructible_state(undefined);
	var_01 = "tag_glass_left_back2";
	common_scripts\_destructible::destructible_part(var_01,"vehicle_80s_wagon1_glass_LB2",10,undefined,undefined,undefined,undefined,undefined,1);
	common_scripts\_destructible::destructible_state(var_01,"vehicle_80s_wagon1_glass_LB2_dam",200,undefined,undefined,undefined,1);
	common_scripts\_destructible::destructible_fx("tag_glass_left_back2_fx","fx/props/car_glass_med");
	common_scripts\_destructible::destructible_sound("veh_glass_break_large");
	common_scripts\_destructible::destructible_state(undefined);
	var_01 = "tag_glass_right_back2";
	common_scripts\_destructible::destructible_part(var_01,"vehicle_80s_wagon1_glass_RB2",10,undefined,undefined,undefined,undefined,undefined,1);
	common_scripts\_destructible::destructible_state(var_01,"vehicle_80s_wagon1_glass_RB2_dam",200,undefined,undefined,undefined,1);
	common_scripts\_destructible::destructible_fx("tag_glass_right_back2_fx","fx/props/car_glass_med");
	common_scripts\_destructible::destructible_sound("veh_glass_break_large");
	common_scripts\_destructible::destructible_state(undefined);
	var_01 = "tag_light_left_front";
	common_scripts\_destructible::destructible_part(var_01,"vehicle_80s_wagon1_" + param_00 + "_light_LF",10,undefined,undefined,undefined,0.5);
	common_scripts\_destructible::destructible_fx(var_01,"fx/props/car_glass_headlight");
	common_scripts\_destructible::destructible_sound("veh_glass_break_small");
	common_scripts\_destructible::destructible_state(var_01,"vehicle_80s_wagon1_" + param_00 + "_light_LF_dam");
	var_01 = "tag_light_right_front";
	common_scripts\_destructible::destructible_part(var_01,"vehicle_80s_wagon1_" + param_00 + "_light_RF",10,undefined,undefined,undefined,0.5);
	common_scripts\_destructible::destructible_fx(var_01,"fx/props/car_glass_headlight");
	common_scripts\_destructible::destructible_sound("veh_glass_break_small");
	common_scripts\_destructible::destructible_state(var_01,"vehicle_80s_wagon1_" + param_00 + "_light_RF_dam");
	var_01 = "tag_light_left_back";
	common_scripts\_destructible::destructible_part(var_01,"vehicle_80s_wagon1_" + param_00 + "_light_LB",10);
	common_scripts\_destructible::destructible_fx(var_01,"fx/props/car_glass_brakelight");
	common_scripts\_destructible::destructible_sound("veh_glass_break_small");
	common_scripts\_destructible::destructible_state(var_01,"vehicle_80s_wagon1_" + param_00 + "_light_LB_dam");
	var_01 = "tag_light_right_back";
	common_scripts\_destructible::destructible_part(var_01,"vehicle_80s_wagon1_" + param_00 + "_light_RB",10);
	common_scripts\_destructible::destructible_fx(var_01,"fx/props/car_glass_brakelight");
	common_scripts\_destructible::destructible_sound("veh_glass_break_small");
	common_scripts\_destructible::destructible_state(var_01,"vehicle_80s_wagon1_" + param_00 + "_light_RB_dam");
	common_scripts\_destructible::destructible_part("tag_bumper_front","vehicle_80s_wagon1_" + param_00 + "_bumper_F",undefined,undefined,undefined,undefined,1,0.7);
	common_scripts\_destructible::destructible_part("tag_bumper_back","vehicle_80s_wagon1_" + param_00 + "_bumper_B",undefined,undefined,undefined,undefined,undefined,0.6);
	common_scripts\_destructible::destructible_part("tag_mirror_left","vehicle_80s_wagon1_" + param_00 + "_mirror_L",10);
	common_scripts\_destructible::destructible_physics();
	common_scripts\_destructible::destructible_part("tag_mirror_right","vehicle_80s_wagon1_" + param_00 + "_mirror_R",10);
	common_scripts\_destructible::destructible_physics();
}

//Function Number: 33
vehicle_pickup(param_00)
{
	common_scripts\_destructible::destructible_create(param_00,300,undefined,32,"no_melee");
	common_scripts\_destructible::destructible_loopfx("tag_hood_fx","fx/smoke/car_damage_whitesmoke",0.4);
	common_scripts\_destructible::destructible_state(undefined,"vehicle_pickup_destructible",200,undefined,32,"no_melee");
	common_scripts\_destructible::destructible_loopfx("tag_hood_fx","fx/smoke/car_damage_blacksmoke",0.4);
	common_scripts\_destructible::destructible_state(undefined,"vehicle_pickup_destructible",100,undefined,32,"no_melee");
	common_scripts\_destructible::destructible_loopfx("tag_hood_fx","fx/smoke/car_damage_blacksmoke_fire",0.4);
	common_scripts\_destructible::destructible_sound("fire_vehicle_flareup_med");
	common_scripts\_destructible::destructible_loopsound("fire_vehicle_med");
	common_scripts\_destructible::destructible_healthdrain(12,0.2,210,"allies");
	common_scripts\_destructible::destructible_state(undefined,"vehicle_pickup_destructible",300,"player_only",32,"no_melee");
	common_scripts\_destructible::destructible_loopsound("fire_vehicle_med");
	common_scripts\_destructible::destructible_state(undefined,"vehicle_pickup_destructible",400,undefined,32,"no_melee");
	common_scripts\_destructible::destructible_fx("tag_death_fx","fx/explosions/small_vehicle_explosion",0);
	common_scripts\_destructible::destructible_sound("car_explode");
	common_scripts\_destructible::destructible_sound("fire_vehicle_small");
	common_scripts\_destructible::destructible_explode(4000,5000,200,150,300);
	common_scripts\_destructible::destructible_anim(%vehicle_80s_sedan1_destroy,#animtree,"setanimknob");
	common_scripts\_destructible::destructible_state(undefined,"vehicle_pickup_destroyed",undefined,32,"no_melee");
	var_01 = "tag_hood";
	common_scripts\_destructible::destructible_part(var_01,"vehicle_pickup_hood",800,undefined,undefined,undefined,1,2.5);
	common_scripts\_destructible::destructible_state(var_01,"vehicle_pickup_hood_dam");
	common_scripts\_destructible::destructible_part("left_wheel_01_jnt","vehicle_pickup_wheel_LF",20,undefined,undefined,"no_melee",undefined,0,undefined,1);
	common_scripts\_destructible::destructible_anim(%vehicle_80s_sedan1_flattire_lf,#animtree,"setanim");
	common_scripts\_destructible::destructible_anim(%vehicle_80s_sedan1_flattire_tire,#animtree,"setanim",1);
	common_scripts\_destructible::destructible_sound("veh_tire_deflate","bullet");
	common_scripts\_destructible::destructible_part("left_wheel_02_jnt","vehicle_pickup_wheel_LF",20,undefined,undefined,"no_melee",undefined,0,undefined,1);
	common_scripts\_destructible::destructible_anim(%vehicle_80s_sedan1_flattire_lb,#animtree,"setanim");
	common_scripts\_destructible::destructible_anim(%vehicle_80s_sedan1_flattire_tire,#animtree,"setanim",1);
	common_scripts\_destructible::destructible_sound("veh_tire_deflate","bullet");
	common_scripts\_destructible::destructible_part("right_wheel_01_jnt","vehicle_pickup_wheel_LF",20,undefined,undefined,"no_melee",undefined,0,undefined,1);
	common_scripts\_destructible::destructible_anim(%vehicle_80s_sedan1_flattire_rf,#animtree,"setanim");
	common_scripts\_destructible::destructible_anim(%vehicle_80s_sedan1_flattire_tire,#animtree,"setanim",1);
	common_scripts\_destructible::destructible_sound("veh_tire_deflate","bullet");
	common_scripts\_destructible::destructible_part("right_wheel_02_jnt","vehicle_pickup_wheel_LF",20,undefined,undefined,"no_melee",undefined,0,undefined,1);
	common_scripts\_destructible::destructible_anim(%vehicle_80s_sedan1_flattire_rb,#animtree,"setanim");
	common_scripts\_destructible::destructible_anim(%vehicle_80s_sedan1_flattire_tire,#animtree,"setanim",1);
	common_scripts\_destructible::destructible_sound("veh_tire_deflate","bullet");
	common_scripts\_destructible::destructible_part("tag_door_left_front","vehicle_pickup_door_LF",undefined,undefined,undefined,undefined,1,1);
	common_scripts\_destructible::destructible_part("tag_door_right_front","vehicle_pickup_door_RF",undefined,undefined,undefined,undefined,1,1);
	common_scripts\_destructible::destructible_part("tag_rear_tailgate","vehicle_pickup_rear_tailgate",undefined,undefined,undefined,undefined,1,1);
	var_01 = "tag_glass_front";
	common_scripts\_destructible::destructible_part(var_01,"vehicle_pickup_glass_F",10,undefined,undefined,undefined,undefined,undefined,1);
	common_scripts\_destructible::destructible_state(var_01,"vehicle_pickup_glass_F_dam",200,undefined,undefined,undefined,1);
	common_scripts\_destructible::destructible_fx("tag_glass_front_fx","fx/props/car_glass_large");
	common_scripts\_destructible::destructible_sound("veh_glass_break_large");
	common_scripts\_destructible::destructible_state(undefined);
	var_01 = "tag_glass_back";
	common_scripts\_destructible::destructible_part(var_01,"vehicle_pickup_glass_B",10,undefined,undefined,undefined,undefined,undefined,1);
	common_scripts\_destructible::destructible_state(var_01,"vehicle_pickup_glass_B_dam",200,undefined,undefined,undefined,1);
	common_scripts\_destructible::destructible_fx("tag_glass_back_fx","fx/props/car_glass_large");
	common_scripts\_destructible::destructible_sound("veh_glass_break_large");
	common_scripts\_destructible::destructible_state(undefined);
	var_01 = "tag_glass_left_front";
	common_scripts\_destructible::destructible_part(var_01,"vehicle_pickup_glass_LF",10,undefined,undefined,undefined,undefined,undefined,1);
	common_scripts\_destructible::destructible_state(var_01,"vehicle_pickup_glass_LF_dam",200,undefined,undefined,undefined,1);
	common_scripts\_destructible::destructible_fx("tag_glass_left_front_fx","fx/props/car_glass_med");
	common_scripts\_destructible::destructible_sound("veh_glass_break_large");
	common_scripts\_destructible::destructible_state(undefined);
	var_01 = "tag_glass_right_front";
	common_scripts\_destructible::destructible_part(var_01,"vehicle_pickup_glass_RF",10,undefined,undefined,undefined,undefined,undefined,1);
	common_scripts\_destructible::destructible_state(var_01,"vehicle_pickup_glass_RF_dam",200,undefined,undefined,undefined,1);
	common_scripts\_destructible::destructible_fx("tag_glass_right_front_fx","fx/props/car_glass_med");
	common_scripts\_destructible::destructible_sound("veh_glass_break_large");
	common_scripts\_destructible::destructible_state(undefined);
	var_01 = "tag_glass_left_back";
	common_scripts\_destructible::destructible_part(var_01,"vehicle_pickup_glass_LB",10,undefined,undefined,undefined,undefined,undefined,1);
	common_scripts\_destructible::destructible_state(var_01,"vehicle_pickup_glass_LB_dam",200,undefined,undefined,undefined,1);
	common_scripts\_destructible::destructible_fx("tag_glass_left_back_fx","fx/props/car_glass_med");
	common_scripts\_destructible::destructible_sound("veh_glass_break_large");
	common_scripts\_destructible::destructible_state(undefined);
	var_01 = "tag_glass_right_back";
	common_scripts\_destructible::destructible_part(var_01,"vehicle_pickup_glass_RB",10,undefined,undefined,undefined,undefined,undefined,1);
	common_scripts\_destructible::destructible_state(var_01,"vehicle_pickup_glass_RB_dam",200,undefined,undefined,undefined,1);
	common_scripts\_destructible::destructible_fx("tag_glass_right_back_fx","fx/props/car_glass_med");
	common_scripts\_destructible::destructible_sound("veh_glass_break_large");
	common_scripts\_destructible::destructible_state(undefined);
	var_01 = "tag_light_left_front";
	common_scripts\_destructible::destructible_part(var_01,"vehicle_pickup_light_LF",10,undefined,undefined,undefined,0.5);
	common_scripts\_destructible::destructible_fx(var_01,"fx/props/car_glass_headlight");
	common_scripts\_destructible::destructible_sound("veh_glass_break_small");
	common_scripts\_destructible::destructible_state(var_01,"vehicle_pickup_light_LF_dam");
	var_01 = "tag_light_right_front";
	common_scripts\_destructible::destructible_part(var_01,"vehicle_pickup_light_RF",10,undefined,undefined,undefined,0.5);
	common_scripts\_destructible::destructible_fx(var_01,"fx/props/car_glass_headlight");
	common_scripts\_destructible::destructible_sound("veh_glass_break_small");
	common_scripts\_destructible::destructible_state(var_01,"vehicle_pickup_light_RF_dam");
	common_scripts\_destructible::destructible_part("tag_bumper_front","vehicle_pickup_bumper_F",undefined,undefined,undefined,undefined,1,1);
	common_scripts\_destructible::destructible_state("tag_bumper_front","vehicle_pickup_bumper_f_dam");
	common_scripts\_destructible::destructible_part("tag_bumper_back","vehicle_pickup_bumper_B",undefined,undefined,undefined,undefined,undefined,1);
	common_scripts\_destructible::destructible_state("tag_bumper_back","vehicle_pickup_bumper_b_dam");
	common_scripts\_destructible::destructible_part("tag_mirror_left","vehicle_pickup_mirror_L",10,undefined,undefined,undefined,undefined,1);
	common_scripts\_destructible::destructible_physics();
	common_scripts\_destructible::destructible_part("tag_mirror_right","vehicle_pickup_mirror_R",10,undefined,undefined,undefined,undefined,1);
	common_scripts\_destructible::destructible_physics();
}