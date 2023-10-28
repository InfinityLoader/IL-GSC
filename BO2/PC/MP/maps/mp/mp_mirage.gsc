/*******************************************************************
 * Decompiled By: Bog
 * Decompiled File: maps\mp\mp_mirage.gsc
 * Game: Call of Duty: Black Ops 2
 * Platform: PC
 * Function Count: 2
 * Decompile Time: 0 ms
 * Timestamp: 10/28/2023 12:11:10 AM
*******************************************************************/

#include maps/mp/_compass;
#include maps/mp/_load;
#include maps/mp/_utility;
#include maps/mp/gametypes/_spawning;
#include maps/mp/mp_mirage_amb;
#include maps/mp/mp_mirage_fx;

//Function Number: 1
main()
{
	level.levelspawndvars = ::levelspawndvars;
	maps/mp/mp_mirage_fx::main();
	precachemodel("collision_physics_256x256x10");
	precachemodel("collision_physics_cylinder_32x128");
	precachemodel("collision_clip_128x128x10");
	precachemodel("collision_clip_256x256x10");
	maps/mp/_load::main();
	maps/mp/mp_mirage_amb::main();
	maps/mp/_compass::setupminimap("compass_map_mp_mirage");
	setdvar("compassmaxrange","2400");
	visionsetnaked("mp_mirage",1);
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
	spawncollision("collision_physics_256x256x10","collider",(58.5,3360,53.5),VectorScale((0,1,0)));
	spawncollision("collision_physics_cylinder_32x128","collider",(3029,1571.5,129.5),VectorScale((0,0,-1)));
	spawncollision("collision_physics_cylinder_32x128","collider",(-1341,517.5,-35.5),(354.7,0,-0.6));
	spawncollision("collision_clip_256x256x10","collider",(1744,482,16),(270,183.902,86.0983));
	maps/mp/gametypes/_spawning::level_use_unified_spawning(1);
}

//Function Number: 2
levelspawndvars(reset_dvars)
{
	ss = level.spawnsystem;
	ss.enemy_influencer_radius = set_dvar_float_if_unset("scr_spawn_enemy_influencer_radius","2500",reset_dvars);
}