/*******************************************************************
 * Decompiled By: Bog
 * Decompiled File: maps\mp\mp_express.gsc
 * Game: Call of Duty: Black Ops 2
 * Platform: PC
 * Function Count: 3
 * Decompile Time: 15 ms
 * Timestamp: 10/27/2023 3:01:44 AM
*******************************************************************/

#include common_scripts/utility;
#include maps/mp/_compass;
#include maps/mp/_load;
#include maps/mp/_utility;
#include maps/mp/mp_express_amb;
#include maps/mp/mp_express_fx;
#include maps/mp/mp_express_train;

//Function Number: 1
main()
{
	level.levelspawndvars = ::levelspawndvars;
	maps/mp/mp_express_fx::main();
	precachemodel("collision_physics_cylinder_32x128");
	maps/mp/_load::main();
	maps/mp/_compass::setupminimap("compass_map_mp_express");
	maps/mp/mp_express_amb::main();
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
	spawncollision("collision_physics_cylinder_32x128","collider",(200.735,759.059,136),(0,248.6,90));
	spawncollision("collision_physics_cylinder_32x128","collider",(229.73,748.06,151),(0,248.6,90));
	spawncollision("collision_physics_cylinder_32x128","collider",(379.816,1141.39,136),(0,244.8,90));
	spawncollision("collision_physics_cylinder_32x128","collider",(408.023,1128.5,151),(0,244.8,90));
	registerclientfield("vehicle","train_moving",1,1,"int");
	registerclientfield("scriptmover","train_moving",1,1,"int");
	if(getgametypesetting("allowMapScripting"))
	{
		level thread maps/mp/mp_express_train::init();
	}

/#
	level thread devgui_express();
	execdevgui("devgui_mp_express");
#/
}

//Function Number: 2
levelspawndvars(reset_dvars)
{
	ss = level.spawnsystem;
	ss.enemy_influencer_radius = set_dvar_float_if_unset("scr_spawn_enemy_influencer_radius","1900",reset_dvars);
}

//Function Number: 3
devgui_express()
{
/#
	setdvar("devgui_notify","");
	for(;;)
	{
		wait(0.5);
		devgui_string = GetDvar(#"9488D1C1");
		switch(devgui_string)
		{
			case "":
				break;
			case "train_start":
				level notify("train_start");
				break;
			default:
				break;
		}
		setdvar("devgui_notify","");
	}
GetDvar(#"9488D1C1") != ""
#/
}