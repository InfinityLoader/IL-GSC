/*******************************************************************
 * Decompiled By: Bog
 * Decompiled File: maps\mp\mp_meltdown.gsc
 * Game: Call of Duty: Black Ops 2
 * Platform: Console
 * Function Count: 2
 * Decompile Time: 10 ms
 * Timestamp: 10/28/2023 12:13:58 AM
*******************************************************************/

#include maps/mp/_compass;
#include maps/mp/_load;
#include maps/mp/_utility;
#include maps/mp/mp_meltdown_amb;
#include maps/mp/mp_meltdown_fx;

//Function Number: 1
main()
{
	level.levelspawndvars = ::levelspawndvars;
	maps/mp/mp_meltdown_fx::main();
	precachemodel("collision_physics_128x128x128");
	precachemodel("collision_physics_wall_256x256x10");
	precachemodel("collision_clip_wall_32x32x10");
	precachemodel("collision_clip_wall_64x64x10");
	precachemodel("collision_clip_64x64x10");
	precachemodel("collision_clip_wall_128x128x10");
	precachemodel("collision_physics_wall_64x64x10");
	precachemodel("collision_clip_32x32x32");
	maps/mp/_load::main();
	maps/mp/mp_meltdown_amb::main();
	spawncollision("collision_physics_128x128x128","collider",(224,4558.5,-117.5),(0,0,0));
	spawncollision("collision_physics_wall_256x256x10","collider",(216.5,4526.5,-86),VectorScale((0,1,0)));
	spawncollision("collision_clip_wall_32x32x10","collider",(486,3219.5,-53),VectorScale((0,1,0)));
	spawncollision("collision_clip_wall_64x64x10","collider",(505.5,3197,-56.5),VectorScale((0,1,0)));
	spawncollision("collision_clip_wall_64x64x10","collider",(545,3181.5,-72.5),VectorScale((0,1,0)));
	spawncollision("collision_clip_wall_64x64x10","collider",(582,3194,-56.5),VectorScale((0,1,0)));
	spawncollision("collision_clip_wall_32x32x10","collider",(602.5,3221.5,-54),VectorScale((0,1,0)));
	spawncollision("collision_clip_64x64x10","collider",(348.5,615,24),VectorScale((0,0,1)));
	spawncollision("collision_clip_wall_64x64x10","collider",(1005.5,1466,173),VectorScale((0,1,0)));
	spawncollision("collision_clip_wall_128x128x10","collider",(808,-1434.5,-120),(0,0,0));
	spawncollision("collision_physics_wall_64x64x10","collider",(1266,1873.5,86),VectorScale((0,1,0)));
	spawncollision("collision_physics_wall_64x64x10","collider",(1266,1873.5,126),VectorScale((0,1,0)));
	spawncollision("collision_physics_32x32x32","collider",(1183,1927,73),(0,0,0));
	spawncollision("collision_physics_32x32x32","collider",(555.5,2976,-47.5),(0,0,0));
	maps/mp/_compass::setupminimap("compass_map_mp_meltdown");
}

//Function Number: 2
levelspawndvars(reset_dvars)
{
	ss = level.spawnsystem;
	ss.enemy_influencer_radius = set_dvar_float_if_unset("scr_spawn_enemy_influencer_radius","2100",reset_dvars);
}