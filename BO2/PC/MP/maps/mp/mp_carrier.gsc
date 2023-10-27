/*******************************************************************
 * Decompiled By: Bog
 * Decompiled File: maps\mp\mp_carrier.gsc
 * Game: Call of Duty: Black Ops 2
 * Platform: PC
 * Function Count: 7
 * Decompile Time: 42 ms
 * Timestamp: 10/27/2023 3:01:40 AM
*******************************************************************/

#include maps/mp/_compass;
#include maps/mp/_load;
#include maps/mp/_utility;
#include maps/mp/mp_carrier_amb;
#include maps/mp/mp_carrier_fx;

//Function Number: 1
main()
{
	level.levelspawndvars = ::levelspawndvars;
	level.overrideplayerdeathwatchtimer = ::leveloverridetime;
	level.useintermissionpointsonwavespawn = ::useintermissionpointsonwavespawn;
	maps/mp/mp_carrier_fx::main();
	precachemodel("collision_physics_wall_512x512x10");
	precachemodel("collision_clip_cylinder_32x128");
	precachemodel("collision_physics_cylinder_32x128");
	precachemodel("collision_clip_wall_32x32x10");
	precachemodel("collision_physics_wall_32x32x10");
	precachemodel("collision_physics_64x64x128");
	precachemodel("collision_physics_32x32x128");
	precachemodel("collision_physics_wall_128x128x10");
	precachemodel("collision_clip_wall_64x64x10");
	precachemodel("collision_physics_32x32x32");
	precachemodel("collision_physics_cylinder_32x128");
	precachemodel("ac_prs_fps_road_chunk_lrg_a04");
	precachemodel("collision_clip_32x32x32");
	maps/mp/_load::main();
	maps/mp/mp_carrier_amb::main();
	maps/mp/_compass::setupminimap("compass_map_mp_carrier");
	game["strings"]["war_callsign_a"] = &"MPUI_CALLSIGN_MAPNAME_A";
	game["strings"]["war_callsign_b"] = &"MPUI_CALLSIGN_MAPNAME_B";
	game["strings"]["war_callsign_c"] = &"MPUI_CALLSIGN_MAPNAME_C";
	game["strings"]["war_callsign_d"] = &"MPUI_CALLSIGN_MAPNAME_D";
	game["strings"]["war_callsign_e"] = &"MPUI_CALLSIGN_MAPNAME_E";
	game["strings_menu"]["war_callsign_a"] = "@MPUI_CALLSIGN_MAPNAME_A";
	game["strings_menu"]["war_callsign_b"] = "@MPUI_CALLSIGN_MAPNAME_B";
	game["strings_menu"]["war_callsign_c"] = "@MPUI_CALLSIGN_MAPNAME_C";
	game["strings_menu"]["war_callsign_d"] = "@MPUI_CALLSIGN_MAPNAME_D";
	game["strings_menu"]["war_callsign_e"] = "@MPUI_CALLSIGN_MAPNAME_E";
	spawncollision("collision_physics_wall_512x512x10","collider",(-3733,-1301.22,-204.5),VectorScale((0,0,1)));
	spawncollision("collision_physics_wall_512x512x10","collider",(-3509,-1301.22,-204.56),VectorScale((0,0,1)));
	spawncollision("collision_physics_wall_512x512x10","collider",(-3733,-808.22,-334.56),VectorScale((0,0,1)));
	spawncollision("collision_physics_wall_512x512x10","collider",(-3509,-808.22,-334.56),VectorScale((0,0,1)));
	spawncollision("collision_clip_cylinder_32x128","collider",(-4821,951,82),VectorScale((0,1,0)));
	spawncollision("collision_clip_wall_32x32x10","collider",(-4820.39,930.19,123),VectorScale((0,1,0)));
	spawncollision("collision_clip_wall_32x32x10","collider",(-4820.39,930.19,91),VectorScale((0,1,0)));
	spawncollision("collision_clip_wall_32x32x10","collider",(-4820.39,930.19,59),VectorScale((0,1,0)));
	spawncollision("collision_physics_cylinder_32x128","collider",(-4821,951,82),VectorScale((0,1,0)));
	spawncollision("collision_physics_wall_32x32x10","collider",(-4820.39,930.19,123),VectorScale((0,1,0)));
	spawncollision("collision_physics_wall_32x32x10","collider",(-4820.39,930.19,91),VectorScale((0,1,0)));
	spawncollision("collision_physics_wall_32x32x10","collider",(-4820.39,930.19,59),VectorScale((0,1,0)));
	spawncollision("collision_physics_cylinder_32x128","collider",(-5448,912,268),VectorScale((0,1,0)));
	spawncollision("collision_physics_64x64x128","collider",(-2434,806,66),(270,25,0));
	spawncollision("collision_physics_32x32x128","collider",(-5003,-963,-100),VectorScale((1,1,0)));
	spawncollision("collision_physics_32x32x128","collider",(-5003,-1091,-100),VectorScale((1,1,0)));
	spawncollision("collision_physics_32x32x128","collider",(-5003,-1219,-88),VectorScale((1,1,0)));
	spawncollision("collision_physics_wall_128x128x10","collider",(-5013,-1128,-32),(270,270,180));
	spawncollision("collision_physics_wall_128x128x10","collider",(-3257.5,-1184.5,-45),(270,270,180));
	spawncollision("collision_physics_wall_128x128x10","collider",(-3257.5,-1128,-45),(270,270,180));
	spawncollision("collision_clip_wall_64x64x10","collider",(-4696.5,662.5,163.5),VectorScale((0,1,0)));
	spawncollision("collision_clip_wall_64x64x10","collider",(-5017,-1083.5,40),(1,270,180));
	spawncollision("collision_clip_wall_64x64x10","collider",(-6316,-1554.5,-30),VectorScale((0,1,0)));
	spawncollision("collision_physics_32x32x32","collider",(-5852.5,-886,159.5),VectorScale((0,1,0)));
	spawncollision("collision_physics_32x32x32","collider",(-5875.5,-887,159.5),VectorScale((0,1,0)));
	spawncollision("collision_physics_cylinder_32x128","collider",(-5331.5,727,247.5),VectorScale((0,0,-1)));
	spawncollision("collision_clip_wall_64x64x10","collider",(-5838,-913.5,85),VectorScale((0,0,-1)));
	greenbarrel1 = spawn("script_model",(-5979.48,-347.391,53.8051));
	greenbarrel1.angles = (0,0,0);
	greenbarrel1 setmodel("ac_prs_fps_road_chunk_lrg_a04");
	greenbarrel2 = spawn("script_model",(-5960.64,-349.489,59.663));
	greenbarrel2.angles = (5.97936,96.3096,13.1076);
	greenbarrel2 setmodel("ac_prs_fps_road_chunk_lrg_a04");
	spawncollision("collision_clip_32x32x32","collider",(-5987.5,-347.5,47),VectorScale((0,1,0)));
	spawncollision("collision_clip_32x32x32","collider",(-5957.2,-356.902,47.25),VectorScale((0,1,0)));
	level thread water_trigger_init();
}

//Function Number: 2
levelspawndvars(reset_dvars)
{
	ss = level.spawnsystem;
	ss.enemy_influencer_radius = set_dvar_float_if_unset("scr_spawn_enemy_influencer_radius","2600",reset_dvars);
}

//Function Number: 3
water_trigger_init()
{
	wait(3);
	triggers = getentarray("trigger_hurt","classname");
	foreach(trigger in triggers)
	{
		if(trigger.origin[2] > level.mapcenter[2])
		{
		}
		else
		{
			trigger thread water_trigger_think();
		}
	}
}

//Function Number: 4
water_trigger_think()
{
	for(;;)
	{
		self waittill("trigger",entity);
		if(isplayer(entity))
		{
			trace = worldtrace(30 + VectorScale((0,0,1)),entity.origin);
			if(trace["surfacetype"] == "none")
			{
				entity playsound("mpl_splash_death");
				playfx(level._effect["water_splash"],40 + VectorScale((0,0,1)));
			}
		}
	}
}

//Function Number: 5
leveloverridetime(defaulttime)
{
	if(self isinwater())
	{
		return 0.4;
	}
}

//Function Number: 6
useintermissionpointsonwavespawn()
{
	return self isinwater();
}

//Function Number: 7
isinwater()
{
	triggers = getentarray("trigger_hurt","classname");
	foreach(trigger in triggers)
	{
		if(trigger.origin[2] > level.mapcenter[2])
		{
		}
		else if(self.origin[2] < trigger.origin[2])
		{
			trace = worldtrace(30 + VectorScale((0,0,1)),self.origin);
			return trace["surfacetype"] == "none";
		}
	}

	return 0;
}