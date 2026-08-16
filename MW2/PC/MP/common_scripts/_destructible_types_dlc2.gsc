/*******************************************************************
 * Decompiled By: Bog
 * Decompiled File: common_scripts\_destructible_types_dlc2.gsc
 * Game: Call of Duty: Modern Warfare 2
 * Platform: PC
*******************************************************************/

maketype_dlc2(destructibletype)
{
	infoindex = common_scripts\_destructible_types::getinfoindex(destructibletype);
	if(infoindex >= 0)
	{
		return infoindex;
	}

	found_dlc2_destructible = 1;
	switch(destructibletype)
	{
		case "toy_fortune_machine":
			toy_fortune_machine(destructibletype);
			break;

		case "toy_trashcan_clown":
			toy_trashcan_clown(destructibletype);
			break;

		case "toy_popcorn_cart":
			toy_popcorn_cart(destructibletype);
			break;

		case "vehicle_theme_park_truck":
			vehicle_theme_park_truck(destructibletype);
			break;

		case "vehicle_delivery_truck_white":
			vehicle_delivery_truck_white(destructibletype);
			break;

		case "toy_keg":
			toy_keg(destructibletype);
			break;

		case "toy_propane_tank03":
			toy_propane_tank03(destructibletype);
			break;

		case "toy_propane_tank03b":
			toy_propane_tank03b(destructibletype);
			break;

		default:
			found_dlc2_destructible = 0;
			break;
	}

	if(!found_dlc2_destructible)
	{
		return undefined;
	}

	infoindex = common_scripts\_destructible_types::getinfoindex(destructibletype);
	return infoindex;
}

toy_fortune_machine(destructibletype)
{
	common_scripts\_destructible::destructible_create(destructibletype, "tag_origin", 0, undefined, 32);
	common_scripts\_destructible::destructible_loopsound("fortune_machine_idle");
	common_scripts\_destructible::destructible_loopfx("J_Eye_RI", "props/fortune_machine_glow_eyes", 2.9);
	common_scripts\_destructible::destructible_loopfx("J_Eye_LE", "props/fortune_machine_glow_eyes", 2.9);
	common_scripts\_destructible::destructible_loopfx("tag_fx3", "props/fortune_machine_glow_ball", 4);
	common_scripts\_destructible::destructible_anim(common_scripts\_destructible_types::get_precached_anim("fortune_machine_anim"), 5, "setanimknob", undefined, undefined, "fortune_machine_anim");
	common_scripts\_destructible::destructible_state("tag_origin", "fortune_machine", 75);
	common_scripts\_destructible::destructible_fx("tag_fx", "props/fortune_machine_exp", undefined, undefined, undefined, 1);
	common_scripts\_destructible::destructible_fx("tag_fx2", "props/fortune_machine_tickets");
	common_scripts\_destructible::destructible_sound("fortune_machine_destroy");
	common_scripts\_destructible::destructible_anim(common_scripts\_destructible_types::get_precached_anim("fortune_machine_des"), 5, "setanimknob", undefined, 0, "fortune_machine_des");
	common_scripts\_destructible::destructible_explode(20, 2000, 20, 20, 40, 40, undefined, 64);
	common_scripts\_destructible::destructible_state(undefined, "fortune_machine_des", undefined, undefined, "no_melee");
}

toy_trashcan_clown(destructibletype)
{
	common_scripts\_destructible::destructible_create(destructibletype, "tag_origin", 120, undefined, 32);
	common_scripts\_destructible::destructible_fx("tag_fx", "props/garbage_spew_des", 1, "splash");
	common_scripts\_destructible::destructible_fx("tag_fx", "props/garbage_spew", 1, common_scripts\_destructible::damage_not("splash"));
	common_scripts\_destructible::destructible_sound("exp_trashcan_sweet");
	common_scripts\_destructible::destructible_explode(600, 651, 1, 1, 10, 20);
	common_scripts\_destructible::destructible_state("tag_origin", "trashcan_clown_base", undefined, undefined, undefined, undefined, undefined, 0);
	common_scripts\_destructible::destructible_part("tag_fx", "trashcan_clown_lid", undefined, undefined, undefined, undefined, 1, 1);
}

toy_popcorn_cart(destructibletype)
{
	common_scripts\_destructible::destructible_create(destructibletype, "tag_glass", 5);
	common_scripts\_destructible::destructible_fx("tag_fx", "props/popcorn_cart_glass_dmg");
	common_scripts\_destructible::destructible_sound("popcorn_cart_glass_dmg");
	common_scripts\_destructible::destructible_state(undefined, "popcorn_cart_glass_dmg", 100, undefined, undefined, "splash");
	common_scripts\_destructible::destructible_fx("tag_fx", "props/popcorn_cart_exp");
	common_scripts\_destructible::destructible_sound("popcorn_cart_destroy");
	common_scripts\_destructible::destructible_state(undefined, "popcorn_cart_damaged", undefined, undefined, undefined, undefined, undefined, 0);
	common_scripts\_destructible::destructible_part("tag_glass", "popcorn_cart_damaged", 4, undefined, undefined, undefined, 1, 1);
}

vehicle_theme_park_truck(destructibletype)
{
	common_scripts\_destructible::destructible_create(destructibletype, "tag_body", 300, undefined, 32, "no_melee");
	common_scripts\_destructible::destructible_loopfx("tag_hood_fx", "smoke/car_damage_whitesmoke", 0.4);
	common_scripts\_destructible::destructible_state(undefined, undefined, 200, undefined, 32, "no_melee");
	common_scripts\_destructible::destructible_loopfx("tag_hood_fx", "smoke/car_damage_blacksmoke", 0.4);
	common_scripts\_destructible::destructible_state(undefined, undefined, 100, undefined, 32, "no_melee");
	common_scripts\_destructible::destructible_loopfx("tag_hood_fx", "smoke/car_damage_blacksmoke_fire", 0.4);
	common_scripts\_destructible::destructible_sound("fire_vehicle_flareup_med");
	common_scripts\_destructible::destructible_loopsound("fire_vehicle_med");
	common_scripts\_destructible::destructible_healthdrain(15, 0.25, 210, "allies");
	common_scripts\_destructible::destructible_state(undefined, undefined, 300, "player_only", 32, "no_melee");
	common_scripts\_destructible::destructible_loopsound("fire_vehicle_med");
	common_scripts\_destructible::destructible_state(undefined, undefined, 400, undefined, 32, "no_melee");
	common_scripts\_destructible::destructible_fx("tag_death_fx", "explosions/vehicle_explosion_medium", 0);
	common_scripts\_destructible::destructible_sound("car_explode");
	common_scripts\_destructible::destructible_explode(4000, 5000, 210, 250, 50, 300, undefined, undefined, 0.3, 500);
	common_scripts\_destructible::destructible_anim(%anim_0003, 5, "setanimknob", undefined, undefined, "vehicle_80s_sedan1_destroy");
	common_scripts\_destructible::destructible_state(undefined, "vehicle_theme_park_truck_destroyed", undefined, 32, "no_melee");
	common_scripts\_destructible::destructible_part("left_wheel_01_jnt", undefined, 20, undefined, undefined, "no_melee");
	common_scripts\_destructible::destructible_anim(%anim_0006, 5, "setanim");
	common_scripts\_destructible::destructible_sound("veh_tire_deflate", "bullet");
	common_scripts\_destructible::destructible_part("left_wheel_02_jnt", undefined, 20, undefined, undefined, "no_melee");
	common_scripts\_destructible::destructible_anim(%anim_0007, 5, "setanim");
	common_scripts\_destructible::destructible_sound("veh_tire_deflate", "bullet");
	common_scripts\_destructible::destructible_part("right_wheel_01_jnt", undefined, 20, undefined, undefined, "no_melee");
	common_scripts\_destructible::destructible_anim(%anim_0004, 5, "setanim");
	common_scripts\_destructible::destructible_sound("veh_tire_deflate", "bullet");
	common_scripts\_destructible::destructible_part("right_wheel_02_jnt", undefined, 20, undefined, undefined, "no_melee");
	common_scripts\_destructible::destructible_anim(%anim_0005, 5, "setanim");
	common_scripts\_destructible::destructible_sound("veh_tire_deflate", "bullet");
	tag = "tag_glass_front";
	common_scripts\_destructible::destructible_part(tag, undefined, 40, undefined, undefined, undefined, undefined, undefined, 1);
	common_scripts\_destructible::destructible_state(tag + "_d", undefined, 60, undefined, undefined, undefined, 1);
	common_scripts\_destructible::destructible_fx(tag + "_fx", "props/car_glass_large");
	common_scripts\_destructible::destructible_sound("veh_glass_break_large");
	common_scripts\_destructible::destructible_state(undefined);
	tag = "tag_glass_front2";
	common_scripts\_destructible::destructible_part(tag, undefined, 40, undefined, undefined, undefined, undefined, undefined, 1);
	common_scripts\_destructible::destructible_state(tag + "_d", undefined, 60, undefined, undefined, undefined, 1);
	common_scripts\_destructible::destructible_fx(tag + "_fx", "props/car_glass_large");
	common_scripts\_destructible::destructible_sound("veh_glass_break_large");
	common_scripts\_destructible::destructible_state(undefined);
	tag = "tag_glass_side_left";
	common_scripts\_destructible::destructible_part(tag, undefined, 20, undefined, undefined, undefined, undefined, undefined, 1);
	common_scripts\_destructible::destructible_state(tag + "_d", undefined, 60, undefined, undefined, undefined, 1);
	common_scripts\_destructible::destructible_fx(tag + "_fx", "props/car_glass_med");
	common_scripts\_destructible::destructible_sound("veh_glass_break_large");
	common_scripts\_destructible::destructible_state(undefined);
	tag = "tag_glass_left_front";
	common_scripts\_destructible::destructible_part(tag, undefined, 20, undefined, undefined, undefined, undefined, undefined, 1);
	common_scripts\_destructible::destructible_state(tag + "_d", undefined, 60, undefined, undefined, undefined, 1);
	common_scripts\_destructible::destructible_fx(tag + "_fx", "props/car_glass_med");
	common_scripts\_destructible::destructible_sound("veh_glass_break_large");
	common_scripts\_destructible::destructible_state(undefined);
	tag = "tag_glass_side_right";
	common_scripts\_destructible::destructible_part(tag, undefined, 20, undefined, undefined, undefined, undefined, undefined, 1);
	common_scripts\_destructible::destructible_state(tag + "_d", undefined, 60, undefined, undefined, undefined, 1);
	common_scripts\_destructible::destructible_fx(tag + "_fx", "props/car_glass_med");
	common_scripts\_destructible::destructible_sound("veh_glass_break_large");
	common_scripts\_destructible::destructible_state(undefined);
	tag = "tag_glass_right_front";
	common_scripts\_destructible::destructible_part(tag, undefined, 20, undefined, undefined, undefined, undefined, undefined, 1);
	common_scripts\_destructible::destructible_state(tag + "_d", undefined, 60, undefined, undefined, undefined, 1);
	common_scripts\_destructible::destructible_fx(tag + "_fx", "props/car_glass_med");
	common_scripts\_destructible::destructible_sound("veh_glass_break_large");
	common_scripts\_destructible::destructible_state(undefined);
}

vehicle_delivery_truck_white(destructibletype)
{
	common_scripts\_destructible::destructible_create(destructibletype, "tag_body", 300, undefined, 32, "no_melee");
	common_scripts\_destructible::destructible_loopfx("tag_hood_fx", "smoke/car_damage_whitesmoke", 0.4);
	common_scripts\_destructible::destructible_state(undefined, undefined, 200, undefined, 32, "no_melee");
	common_scripts\_destructible::destructible_loopfx("tag_hood_fx", "smoke/car_damage_blacksmoke", 0.4);
	common_scripts\_destructible::destructible_state(undefined, undefined, 100, undefined, 32, "no_melee");
	common_scripts\_destructible::destructible_loopfx("tag_hood_fx", "smoke/car_damage_blacksmoke_fire", 0.4);
	common_scripts\_destructible::destructible_sound("fire_vehicle_flareup_med");
	common_scripts\_destructible::destructible_loopsound("fire_vehicle_med");
	common_scripts\_destructible::destructible_healthdrain(15, 0.25, 210, "allies");
	common_scripts\_destructible::destructible_state(undefined, undefined, 300, "player_only", 32, "no_melee");
	common_scripts\_destructible::destructible_loopsound("fire_vehicle_med");
	common_scripts\_destructible::destructible_state(undefined, undefined, 400, undefined, 32, "no_melee");
	common_scripts\_destructible::destructible_fx("tag_death_fx", "explosions/vehicle_explosion_medium", 0);
	common_scripts\_destructible::destructible_sound("car_explode");
	common_scripts\_destructible::destructible_explode(4000, 5000, 210, 250, 50, 300, undefined, undefined, 0.3, 500);
	common_scripts\_destructible::destructible_anim(%anim_0003, 5, "setanimknob", undefined, undefined, "vehicle_80s_sedan1_destroy");
	common_scripts\_destructible::destructible_state(undefined, "vehicle_delivery_truck_white_destroyed", undefined, 32, "no_melee");
	common_scripts\_destructible::destructible_part("left_wheel_01_jnt", undefined, 20, undefined, undefined, "no_melee");
	common_scripts\_destructible::destructible_anim(%anim_0006, 5, "setanim");
	common_scripts\_destructible::destructible_sound("veh_tire_deflate", "bullet");
	common_scripts\_destructible::destructible_part("left_wheel_02_jnt", undefined, 20, undefined, undefined, "no_melee");
	common_scripts\_destructible::destructible_anim(%anim_0007, 5, "setanim");
	common_scripts\_destructible::destructible_sound("veh_tire_deflate", "bullet");
	common_scripts\_destructible::destructible_part("right_wheel_01_jnt", undefined, 20, undefined, undefined, "no_melee");
	common_scripts\_destructible::destructible_anim(%anim_0004, 5, "setanim");
	common_scripts\_destructible::destructible_sound("veh_tire_deflate", "bullet");
	common_scripts\_destructible::destructible_part("right_wheel_02_jnt", undefined, 20, undefined, undefined, "no_melee");
	common_scripts\_destructible::destructible_anim(%anim_0005, 5, "setanim");
	common_scripts\_destructible::destructible_sound("veh_tire_deflate", "bullet");
	tag = "tag_glass_front";
	common_scripts\_destructible::destructible_part(tag, undefined, 40, undefined, undefined, undefined, undefined, undefined, 1);
	common_scripts\_destructible::destructible_state(tag + "_d", undefined, 60, undefined, undefined, undefined, 1);
	common_scripts\_destructible::destructible_fx(tag + "_fx", "props/car_glass_large");
	common_scripts\_destructible::destructible_sound("veh_glass_break_large");
	common_scripts\_destructible::destructible_state(undefined);
	tag = "tag_glass_front2";
	common_scripts\_destructible::destructible_part(tag, undefined, 40, undefined, undefined, undefined, undefined, undefined, 1);
	common_scripts\_destructible::destructible_state(tag + "_d", undefined, 60, undefined, undefined, undefined, 1);
	common_scripts\_destructible::destructible_fx(tag + "_fx", "props/car_glass_large");
	common_scripts\_destructible::destructible_sound("veh_glass_break_large");
	common_scripts\_destructible::destructible_state(undefined);
	tag = "tag_glass_side_left";
	common_scripts\_destructible::destructible_part(tag, undefined, 20, undefined, undefined, undefined, undefined, undefined, 1);
	common_scripts\_destructible::destructible_state(tag + "_d", undefined, 60, undefined, undefined, undefined, 1);
	common_scripts\_destructible::destructible_fx(tag + "_fx", "props/car_glass_med");
	common_scripts\_destructible::destructible_sound("veh_glass_break_large");
	common_scripts\_destructible::destructible_state(undefined);
	tag = "tag_glass_left_front";
	common_scripts\_destructible::destructible_part(tag, undefined, 20, undefined, undefined, undefined, undefined, undefined, 1);
	common_scripts\_destructible::destructible_state(tag + "_d", undefined, 60, undefined, undefined, undefined, 1);
	common_scripts\_destructible::destructible_fx(tag + "_fx", "props/car_glass_med");
	common_scripts\_destructible::destructible_sound("veh_glass_break_large");
	common_scripts\_destructible::destructible_state(undefined);
	tag = "tag_glass_side_right";
	common_scripts\_destructible::destructible_part(tag, undefined, 20, undefined, undefined, undefined, undefined, undefined, 1);
	common_scripts\_destructible::destructible_state(tag + "_d", undefined, 60, undefined, undefined, undefined, 1);
	common_scripts\_destructible::destructible_fx(tag + "_fx", "props/car_glass_med");
	common_scripts\_destructible::destructible_sound("veh_glass_break_large");
	common_scripts\_destructible::destructible_state(undefined);
	tag = "tag_glass_right_front";
	common_scripts\_destructible::destructible_part(tag, undefined, 20, undefined, undefined, undefined, undefined, undefined, 1);
	common_scripts\_destructible::destructible_state(tag + "_d", undefined, 60, undefined, undefined, undefined, 1);
	common_scripts\_destructible::destructible_fx(tag + "_fx", "props/car_glass_med");
	common_scripts\_destructible::destructible_sound("veh_glass_break_large");
	common_scripts\_destructible::destructible_state(undefined);
}

toy_keg(destructibletype)
{
	common_scripts\_destructible::destructible_create(destructibletype, "tag_origin", 250, undefined, 32, "no_melee");
	common_scripts\_destructible::destructible_splash_damage_scaler(11);
	common_scripts\_destructible::destructible_state(undefined, undefined, 500, undefined, 32, "no_melee");
	common_scripts\_destructible::destructible_loopfx("tag_fx", "props/keg_leak", 0.1);
	common_scripts\_destructible::destructible_loopsound("keg_spray_loop");
	common_scripts\_destructible::destructible_healthdrain(12, 0.2);
	common_scripts\_destructible::destructible_state(undefined, undefined, 800, undefined, 5, "no_melee");
	common_scripts\_destructible::destructible_fx("tag_fx", "props/keg_exp", 0);
	common_scripts\_destructible::destructible_fx("tag_fx", "props/keg_spray_10sec", 0);
	common_scripts\_destructible::destructible_sound("keg_burst");
	common_scripts\_destructible::destructible_explode(17000, 18000, 96, 96, 32, 48);
	common_scripts\_destructible::destructible_state(undefined, "prop_trailerpark_beer_keg_dest", undefined, undefined, "no_melee");
}

toy_propane_tank03(destructibletype)
{
	common_scripts\_destructible::destructible_create(destructibletype, "tag_origin", 50, undefined, 32, "no_melee");
	common_scripts\_destructible::destructible_splash_damage_scaler(10);
	common_scripts\_destructible::destructible_state(undefined, undefined, 350, undefined, 32, "no_melee");
	common_scripts\_destructible::destructible_loopsound("propanetank03_gas_leak_loop");
	common_scripts\_destructible::destructible_loopfx("tag_cap", "distortion/propane_cap_distortion_small", 0.1);
	common_scripts\_destructible::destructible_state(undefined, undefined, 350, undefined, 32, "no_melee");
	common_scripts\_destructible::destructible_loopfx("tag_cap", "fire/propane_capfire_leak", 0.1);
	common_scripts\_destructible::destructible_sound("propanetank03_flareup_med");
	common_scripts\_destructible::destructible_loopsound("propanetank03_fire_med");
	common_scripts\_destructible::destructible_healthdrain(12, 0.2, 210, "allies");
	common_scripts\_destructible::destructible_state(undefined, undefined, 200, undefined, 32, "no_melee");
	common_scripts\_destructible::destructible_physics("tag_cap", (50,0,0));
	common_scripts\_destructible::destructible_fx("tag_cap", "fire/propane_valvefire_flareup");
	common_scripts\_destructible::destructible_loopfx("tag_cap", "fire/propane_valvefire", 0.1);
	common_scripts\_destructible::destructible_sound("propanetank03_flareup_med");
	common_scripts\_destructible::destructible_loopsound("propanetank03_fire_med");
	common_scripts\_destructible::destructible_state(undefined, undefined, 200, undefined, 5, "no_melee");
	common_scripts\_destructible::destructible_fx("tag_fx", "fire/firelp_med_pm");
	common_scripts\_destructible::destructible_fx("tag_fx", "explosions/propane_small_exp", 0);
	common_scripts\_destructible::destructible_sound("propanetank03_explode");
	common_scripts\_destructible::destructible_explode(3500, 4000, 300, 300, 32, 200, undefined, 32);
	common_scripts\_destructible::destructible_state(undefined, "com_propane_tank03_d", undefined, undefined, "no_melee");
	common_scripts\_destructible::destructible_part("tag_cap", "com_propane_tank_lid_03");
}

toy_propane_tank03b(destructibletype)
{
	common_scripts\_destructible::destructible_create(destructibletype, "tag_origin", 50, undefined, 32, "no_melee");
	common_scripts\_destructible::destructible_splash_damage_scaler(10);
	common_scripts\_destructible::destructible_state(undefined, undefined, 350, undefined, 32, "no_melee");
	common_scripts\_destructible::destructible_loopsound("propanetank03_gas_leak_loop");
	common_scripts\_destructible::destructible_loopfx("tag_cap", "distortion/propane_cap_distortion_small", 0.1);
	common_scripts\_destructible::destructible_state(undefined, undefined, 350, undefined, 32, "no_melee");
	common_scripts\_destructible::destructible_loopfx("tag_cap", "fire/propane_capfire_leak", 0.1);
	common_scripts\_destructible::destructible_sound("propanetank03_flareup_med");
	common_scripts\_destructible::destructible_loopsound("propanetank03_fire_med");
	common_scripts\_destructible::destructible_healthdrain(12, 0.2, 210, "allies");
	common_scripts\_destructible::destructible_state(undefined, undefined, 200, undefined, 32, "no_melee");
	common_scripts\_destructible::destructible_physics("tag_cap", (50,0,0));
	common_scripts\_destructible::destructible_fx("tag_cap", "fire/propane_valvefire_flareup");
	common_scripts\_destructible::destructible_loopfx("tag_cap", "fire/propane_valvefire", 0.1);
	common_scripts\_destructible::destructible_sound("propanetank03_flareup_med");
	common_scripts\_destructible::destructible_loopsound("propanetank03_fire_med");
	common_scripts\_destructible::destructible_state(undefined, undefined, 200, undefined, 5, "no_melee");
	common_scripts\_destructible::destructible_fx("tag_fx", "fire/firelp_med_pm");
	common_scripts\_destructible::destructible_fx("tag_fx", "explosions/propane_small_exp", 0);
	common_scripts\_destructible::destructible_sound("propanetank03_explode");
	common_scripts\_destructible::destructible_explode(3500, 4000, 300, 300, 32, 200, undefined, 32);
	common_scripts\_destructible::destructible_state(undefined, "com_propane_tank03_d", undefined, undefined, "no_melee");
	common_scripts\_destructible::destructible_part("tag_cap", "com_propane_tank_lid_03b");
}