/*******************************************************************
 * Decompiled By: Bog
 * Decompiled File: maps\mp\_global_fx.gsc
 * Game: Call of Duty: Modern Warfare 2
 * Platform: PC
*******************************************************************/

main()
{
	randomstartdelay = randomfloatrange(-20, -15);
	global_fx("barrel_fireFX_origin", "global_barrel_fire", "fire/firelp_barrel_pm", randomstartdelay, "fire_barrel_small");
	global_fx("ch_streetlight_02_FX_origin", "ch_streetlight_02_FX", "misc/lighthaze", randomstartdelay);
	global_fx("me_streetlight_01_FX_origin", "me_streetlight_01_FX", "misc/lighthaze_bog_a", randomstartdelay);
	global_fx("ch_street_light_01_on", "lamp_glow_FX", "misc/light_glow_white", randomstartdelay);
	global_fx("lamp_post_globe_on", "lamp_glow_FX", "misc/light_glow_white", randomstartdelay);
	global_fx("highway_lamp_post", "ch_streetlight_02_FX", "misc/lighthaze_villassault", randomstartdelay);
	global_fx("cs_cargoship_spotlight_on_FX_origin", "cs_cargoship_spotlight_on_FX", "misc/lighthaze", randomstartdelay);
	global_fx("me_dumpster_fire_FX_origin", "me_dumpster_fire_FX", "fire/firelp_med_pm", randomstartdelay, "fire_dumpster_medium");
	global_fx("com_tires_burning01_FX_origin", "com_tires_burning01_FX", "fire/tire_fire_med", randomstartdelay);
	global_fx("icbm_powerlinetower_FX_origin", "icbm_powerlinetower_FX", "misc/power_tower_light_red_blink", randomstartdelay);
	global_fx("icbm_mainframe_FX_origin", "icbm_mainframe_FX", "props/icbm_mainframe_lightblink", randomstartdelay);
	global_fx("light_pulse_red_FX_origin", "light_pulse_red_FX", "misc/light_glow_red_generic_pulse", -2);
	global_fx("light_pulse_red_FX_origin", "light_pulse_red_FX", "misc/light_glow_red_generic_pulse", -2);
	global_fx("light_pulse_orange_FX_origin", "light_pulse_orange_FX", "misc/light_glow_orange_generic_pulse", -2);
	global_fx("light_red_blink_FX_origin", "light_red_blink", "misc/power_tower_light_red_blink", -2);
	global_fx("lighthaze_oilrig_FX_origin", "lighthaze_oilrig", "misc/lighthaze_oilrig", randomstartdelay);
	global_fx("lighthaze_white_FX_origin", "lighthaze_white", "misc/lighthaze_white", randomstartdelay);
	global_fx("light_glow_walllight_white_FX_origin", "light_glow_walllight_white", "misc/light_glow_walllight_white", randomstartdelay);
	global_fx("fluorescent_glow_FX_origin", "fluorescent_glow", "misc/fluorescent_glow", randomstartdelay);
	global_fx("light_glow_industrial_FX_origin", "light_glow_industrial", "misc/light_glow_industrial", randomstartdelay);
	global_fx("light_red_steady_FX_origin", "light_red_steady", "misc/tower_light_red_steady", -2);
	global_fx("light_blue_steady_FX_origin", "light_blue_steady", "misc/tower_light_blue_steady", -2);
	global_fx("light_orange_steady_FX_origin", "light_orange_steady", "misc/tower_light_orange_steady", -2);
	global_fx("glow_stick_pile_FX_origin", "glow_stick_pile", "misc/glow_stick_glow_pile", -2);
	global_fx("glow_stick_orange_pile_FX_origin", "glow_stick_pile_orange", "misc/glow_stick_glow_pile_orange", -2);
	global_fx("highrise_blinky_tower", "highrise_blinky_tower_FX", "misc/power_tower_light_red_blink_large", randomstartdelay);
	global_fx("flare_ambient_FX_origin", "flare_ambient_FX", "misc/flare_ambient", randomstartdelay, "emt_road_flare_burn");
	global_fx("light_glow_white_bulb_FX_origin", "light_glow_white_bulb_FX", "misc/light_glow_white_bulb", randomstartdelay);
	global_fx("light_glow_white_lamp_FX_origin", "light_glow_white_lamp_FX", "misc/light_glow_white_lamp", randomstartdelay);
}

global_fx(targetname, fxname, param_A42, delay, soundalias)
{
	ents = common_scripts\utility::getstructarray(targetname, "targetname");
	if(!isdefined(ents))
	{
		return;
	}

	if(ents.size <= 0)
	{
		return;
	}

	for(i = 0;i < ents.size;i++)
	{
		ents[i] global_fx_create(fxname, param_A42, delay, soundalias);
	}
}

global_fx_create(fxname, param_A42, delay, soundalias)
{
	if(!isdefined(level._effect))
	{
		level._effect = [];
	}

	if(!isdefined(level._effect[fxname]))
	{
		level._effect[fxname] = loadfx(param_A42);
	}

	if(!isdefined(self.angles))
	{
		self.angles = (0,0,0);
	}

	ent = common_scripts\utility::createoneshoteffect(fxname);
	ent.v["origin"] = self.origin;
	ent.v["angles"] = self.angles;
	ent.v["fxid"] = fxname;
	ent.v["delay"] = delay;
	if(isdefined(soundalias))
	{
		ent.v["soundalias"] = soundalias;
		return;
	}
}