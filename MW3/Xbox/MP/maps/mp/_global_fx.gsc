/*******************************************************************
 * Decompiled By: Bog
 * Decompiled File: maps\mp\_global_fx.gsc
 * Game: Call of Duty: Modern Warfare 3
 * Platform: Console
 * Function Count: 3
 * Decompile Time: 64 ms
 * Timestamp: 10/27/2023 2:27:45 AM
*******************************************************************/

//Function Number: 1
main()
{
	var_00 = randomfloatrange(-20,-15);
	global_fx("barrel_fireFX_origin","global_barrel_fire","fire/firelp_barrel_pm",var_00,"fire_barrel_small");
	global_fx("ch_streetlight_02_FX_origin","ch_streetlight_02_FX","misc/lighthaze",var_00);
	global_fx("me_streetlight_01_FX_origin","me_streetlight_01_FX","misc/lighthaze_bog_a",var_00);
	global_fx("ch_street_light_01_on","lamp_glow_FX","misc/light_glow_white",var_00);
	global_fx("lamp_post_globe_on","lamp_glow_FX","misc/light_glow_white",var_00);
	global_fx("highway_lamp_post","ch_streetlight_02_FX","misc/lighthaze_villassault",var_00);
	global_fx("cs_cargoship_spotlight_on_FX_origin","cs_cargoship_spotlight_on_FX","misc/lighthaze",var_00);
	global_fx("me_dumpster_fire_FX_origin","me_dumpster_fire_FX","fire/firelp_med_pm",var_00,"fire_dumpster_medium");
	global_fx("com_tires_burning01_FX_origin","com_tires_burning01_FX","fire/tire_fire_med",var_00);
	global_fx("icbm_powerlinetower_FX_origin","icbm_powerlinetower_FX","misc/power_tower_light_red_blink",var_00);
	global_fx("icbm_mainframe_FX_origin","icbm_mainframe_FX","props/icbm_mainframe_lightblink",var_00);
	global_fx("light_pulse_red_FX_origin","light_pulse_red_FX","misc/light_glow_red_generic_pulse",-2);
	global_fx("light_pulse_red_FX_origin","light_pulse_red_FX","misc/light_glow_red_generic_pulse",-2);
	global_fx("light_pulse_orange_FX_origin","light_pulse_orange_FX","misc/light_glow_orange_generic_pulse",-2);
	global_fx("light_red_blink_FX_origin","light_red_blink","misc/power_tower_light_red_blink",-2);
	global_fx("lighthaze_oilrig_FX_origin","lighthaze_oilrig","misc/lighthaze_oilrig",var_00);
	global_fx("lighthaze_white_FX_origin","lighthaze_white","misc/lighthaze_white",var_00);
	global_fx("light_glow_walllight_white_FX_origin","light_glow_walllight_white","misc/light_glow_walllight_white",var_00);
	global_fx("fluorescent_glow_FX_origin","fluorescent_glow","misc/fluorescent_glow",var_00);
	global_fx("light_glow_industrial_FX_origin","light_glow_industrial","misc/light_glow_industrial",var_00);
	global_fx("light_red_steady_FX_origin","light_red_steady","misc/tower_light_red_steady",-2);
	global_fx("light_blue_steady_FX_origin","light_blue_steady","misc/tower_light_blue_steady",-2);
	global_fx("light_orange_steady_FX_origin","light_orange_steady","misc/tower_light_orange_steady",-2);
	global_fx("glow_stick_pile_FX_origin","glow_stick_pile","misc/glow_stick_glow_pile",-2);
	global_fx("glow_stick_orange_pile_FX_origin","glow_stick_pile_orange","misc/glow_stick_glow_pile_orange",-2);
	global_fx("highrise_blinky_tower","highrise_blinky_tower_FX","misc/power_tower_light_red_blink_large",var_00);
	global_fx("flare_ambient_FX_origin","flare_ambient_FX","misc/flare_ambient",var_00,"emt_road_flare_burn");
	global_fx("light_glow_white_bulb_FX_origin","light_glow_white_bulb_FX","misc/light_glow_white_bulb",var_00);
	global_fx("light_glow_white_lamp_FX_origin","light_glow_white_lamp_FX","misc/light_glow_white_lamp",var_00);
}

//Function Number: 2
global_fx(param_00,param_01,param_02,param_03,param_04)
{
	var_05 = common_scripts\utility::getstructarray(param_00,"targetname");
	if(!isdefined(var_05))
	{
		return;
	}

	if(var_05.size <= 0)
	{
		return;
	}

	for(var_06 = 0;var_06 < var_05.size;var_06++)
	{
		var_05[var_06] func_1798(param_01,param_02,param_03,param_04);
	}
}

//Function Number: 3
func_1798(param_00,param_01,param_02,param_03)
{
	if(!isdefined(level._effect))
	{
		level._effect = [];
	}

	if(!isdefined(level._effect[param_00]))
	{
		level._effect[param_00] = loadfx(param_01);
	}

	if(!isdefined(self.angles))
	{
		self.angles = (0,0,0);
	}

	var_04 = common_scripts\utility::createoneshoteffect(param_00);
	var_04.v["origin"] = self.origin;
	var_04.v["angles"] = self.angles;
	var_04.v["fxid"] = param_00;
	var_04.v["delay"] = param_02;
	if(isdefined(param_03))
	{
		var_04.v["soundalias"] = param_03;
	}
}