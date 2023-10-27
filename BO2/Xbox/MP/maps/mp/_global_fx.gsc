/*******************************************************************
 * Decompiled By: Bog
 * Decompiled File: maps\mp\_global_fx.gsc
 * Game: Call of Duty: Black Ops 2
 * Platform: Console
 * Function Count: 3
 * Decompile Time: 20 ms
 * Timestamp: 10/27/2023 3:05:02 AM
*******************************************************************/

#include common_scripts/utility;
#include maps/mp/_utility;

//Function Number: 1
main()
{
	randomstartdelay = randomfloatrange(-20,-15);
	global_fx("barrel_fireFX_origin","global_barrel_fire","fire/firelp_barrel_pm",randomstartdelay,"fire_barrel_small");
	global_fx("ch_streetlight_02_FX_origin","ch_streetlight_02_FX","misc/lighthaze",randomstartdelay);
	global_fx("me_streetlight_01_FX_origin","me_streetlight_01_FX","misc/lighthaze_bog_a",randomstartdelay);
	global_fx("ch_street_light_01_on","lamp_glow_FX","misc/light_glow_white",randomstartdelay);
	global_fx("highway_lamp_post","ch_streetlight_02_FX","misc/lighthaze_villassault",randomstartdelay);
	global_fx("cs_cargoship_spotlight_on_FX_origin","cs_cargoship_spotlight_on_FX","misc/lighthaze",randomstartdelay);
	global_fx("me_dumpster_fire_FX_origin","me_dumpster_fire_FX","fire/firelp_med_pm_nodistort",randomstartdelay,"fire_dumpster_medium");
	global_fx("com_tires_burning01_FX_origin","com_tires_burning01_FX","fire/tire_fire_med",randomstartdelay);
	global_fx("icbm_powerlinetower_FX_origin","icbm_powerlinetower_FX","misc/power_tower_light_red_blink",randomstartdelay);
}

//Function Number: 2
global_fx(targetname,fxname,fxfile,delay,soundalias)
{
	ents = getstructarray(targetname,"targetname");
	if(!(IsDefined(ents)))
	{
		return;
	}

	if(ents.size <= 0)
	{
		return;
	}

	for(i = 0;i < ents.size;i++)
	{
		ents[i] global_fx_create(fxname,fxfile,delay,soundalias);
	}
}

//Function Number: 3
global_fx_create(fxname,fxfile,delay,soundalias)
{
	if(!(IsDefined(level._effect)))
	{
		level._effect = [];
	}

	if(!(IsDefined(level._effect[fxname])))
	{
		level._effect[fxname] = loadfx(fxfile);
	}

	if(!(IsDefined(self.angles)))
	{
		self.angles = (0,0,0);
	}

	ent = createoneshoteffect(fxname);
	ent.v["origin"] = self.origin;
	ent.v["angles"] = self.angles;
	ent.v["fxid"] = fxname;
	ent.v["delay"] = delay;
	if(IsDefined(soundalias))
	{
		ent.v["soundalias"] = soundalias;
	}
}