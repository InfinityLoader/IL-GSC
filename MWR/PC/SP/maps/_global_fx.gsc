/*******************************************************************
 * Decompiled By: Bog
 * Decompiled File: maps\_global_fx.gsc
 * Game: Call of Duty: Modern Warfare Remastered
 * Platform: PC
 * Function Count: 4
 * Decompile Time: 92 ms
 * Timestamp: 10/27/2023 2:47:52 AM
*******************************************************************/

//Function Number: 1
main()
{
	maps\_global_fx_code::global_fx("ch_streetlight_02_FX_origin","fx/misc/lighthaze");
	maps\_global_fx_code::global_fx("me_streetlight_01_FX_origin","fx/misc/lighthaze_bog_a");
	maps\_global_fx_code::global_fx("ch_street_light_01_on","fx/misc/lighthaze");
	maps\_global_fx_code::global_fx("com_wall_streetlamp_on","fx/misc/light_glow_white_dim");
	maps\_global_fx_code::global_fx("lamp_post_globe_on","fx/misc/light_glow_white");
	maps\_global_fx_code::global_fx("highway_lamp_post","fx/misc/lighthaze_villassault");
	maps\_global_fx_code::global_fx("cs_cargoship_spotlight_on_FX_origin","fx/misc/lighthaze");
	maps\_global_fx_code::global_fx("com_tires_burning01_FX_origin","fx/fire/tire_fire_med");
	maps\_global_fx_code::global_fx("icbm_powerlinetower_FX_origin","fx/misc/power_tower_light_red_blink");
	maps\_global_fx_code::global_fx("icbm_mainframe_FX_origin","fx/props/icbm_mainframe_lightblink");
	maps\_global_fx_code::global_fx("lighthaze_oilrig_FX_origin","fx/misc/lighthaze_oilrig");
	maps\_global_fx_code::global_fx("lighthaze_white_FX_origin","fx/misc/lighthaze_white");
	maps\_global_fx_code::global_fx("light_glow_walllight_white_FX_origin","fx/misc/light_glow_walllight_white");
	maps\_global_fx_code::global_fx("fluorescent_glow_FX_origin","fx/misc/fluorescent_glow");
	maps\_global_fx_code::global_fx("light_glow_industrial_FX_origin","fx/misc/light_glow_industrial");
	maps\_global_fx_code::global_fx("light_glow_white_bulb_FX_origin","fx/misc/light_glow_white_bulb");
	maps\_global_fx_code::global_fx("light_glow_white_lamp_FX_origin","fx/misc/light_glow_white_lamp");
	maps\_global_fx_code::global_fx("highrise_blinky_tower","fx/misc/power_tower_light_red_blink_large");
	maps\_global_fx_code::global_fx("light_red_steady_FX_origin","fx/misc/tower_light_red_steady",-2);
	maps\_global_fx_code::global_fx("light_blue_steady_FX_origin","fx/misc/tower_light_blue_steady",-2);
	maps\_global_fx_code::global_fx("light_orange_steady_FX_origin","fx/misc/tower_light_orange_steady",-2);
	maps\_global_fx_code::global_fx("glow_stick_pile_FX_origin","fx/misc/glow_stick_glow_pile",-2);
	maps\_global_fx_code::global_fx("light_pulse_red_FX_origin","fx/misc/light_glow_red_generic_pulse",-2);
	maps\_global_fx_code::global_fx("light_pulse_red_FX_origin","fx/misc/light_glow_red_generic_pulse",-2);
	maps\_global_fx_code::global_fx("light_pulse_orange_FX_origin","fx/misc/light_glow_orange_generic_pulse",-2);
	maps\_global_fx_code::global_fx("light_red_blink_FX_origin","fx/misc/power_tower_light_red_blink",-2);
	maps\_global_fx_code::global_fx("flare_ambient_FX_origin","fx/misc/flare_ambient",undefined,undefined,"emt_road_flare_burn");
	maps\_global_fx_code::global_fx("me_dumpster_fire_FX_origin","fx/fire/firelp_med_pm",undefined,undefined,"fire_dumpster_medium");
	maps\_global_fx_code::global_fx("barrel_fireFX_origin","fx/fire/firelp_barrel_pm",undefined,undefined,"fire_barrel_small");
	maps\_global_fx_code::global_fx("cnd_laptop_001_open_on_FX_origin","vfx/ambient/props/laptop_dust");
	maps\_global_fx_code::global_fx("cnd_glowstick_FX_origin","fx/misc/glow_stick_glow_orange");
}

//Function Number: 2
override_global_fx(param_00,param_01,param_02,param_03,param_04)
{
	var_05 = [];
	var_05["targetname"] = param_00;
	var_05["fxFile"] = param_01;
	var_05["delay"] = param_02;
	var_05["fxName"] = param_03;
	var_05["soundalias"] = param_04;
	level.global_fx_override[param_00] = var_05;
}

//Function Number: 3
set_custom_global_fx(param_00,param_01,param_02,param_03,param_04)
{
	var_05 = [];
	var_05["targetname"] = param_00;
	var_05["fxFile"] = param_01;
	var_05["delay"] = param_02;
	var_05["fxName"] = param_03;
	var_05["soundalias"] = param_04;
	level.global_fx_custom[param_00] = var_05;
}

//Function Number: 4
create_custom_global_fx()
{
	if(!isdefined(level.global_fx_custom))
	{
		return;
	}

	foreach(var_01 in level.global_fx_custom)
	{
		var_02 = var_01["targetname"];
		var_03 = var_01["fxFile"];
		var_04 = var_01["delay"];
		var_05 = var_01["fxName"];
		var_06 = var_01["soundalias"];
		maps\_global_fx_code::global_fx(var_02,var_03,var_04,var_05,var_06);
	}
}