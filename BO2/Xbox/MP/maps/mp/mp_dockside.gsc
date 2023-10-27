/*******************************************************************
 * Decompiled By: Bog
 * Decompiled File: maps\mp\mp_dockside.gsc
 * Game: Call of Duty: Black Ops 2
 * Platform: Console
 * Function Count: 10
 * Decompile Time: 155 ms
 * Timestamp: 10/27/2023 3:05:20 AM
*******************************************************************/

#include maps/mp/_compass;
#include maps/mp/_load;
#include maps/mp/_utility;
#include maps/mp/mp_dockside_amb;
#include maps/mp/mp_dockside_crane;
#include maps/mp/mp_dockside_fx;

//Function Number: 1
main()
{
	level.levelspawndvars = ::levelspawndvars;
	maps/mp/mp_dockside_fx::main();
	precachemodel("collision_clip_64x64x64");
	precachemodel("collision_clip_32x32x32");
	precachemodel("collision_missile_128x128x10");
	precachemodel("collision_missile_32x32x128");
	maps/mp/_load::main();
	maps/mp/mp_dockside_amb::main();
	maps/mp/_compass::setupminimap("compass_map_mp_dockside");
	level.overrideplayerdeathwatchtimer = ::leveloverridetime;
	level.useintermissionpointsonwavespawn = ::useintermissionpointsonwavespawn;
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
	spawncollision("collision_clip_64x64x64","collider",(1095,1489,-111),(0,0,0));
	spawncollision("collision_clip_32x32x32","collider",(1079,1441,-97),(0,0,0));
	spawncollision("collision_clip_wall_128x128x10","collider",(-1791,2954,-23),VectorScale((0,1,0)));
	setdvar("sm_sunsamplesizenear",0.39);
	setdvar("sm_sunshadowsmall",1);
	if(getgametypesetting("allowMapScripting"))
	{
		level maps/mp/mp_dockside_crane::init();
	}
	else
	{
		crate_triggers = getentarray("crate_kill_trigger","targetname");
		for(i = 0;i < crate_triggers.size;i++)
		{
			crate_triggers[i] delete();
		}
	}

	setheliheightpatchenabled("war_mode_heli_height_lock",0);
	level thread water_trigger_init();
	rts_remove();
/#
	level thread devgui_dockside();
	execdevgui("devgui_mp_dockside");
#/
}

//Function Number: 2
levelspawndvars(reset_dvars)
{
	ss = level.spawnsystem;
	ss.enemy_influencer_radius = set_dvar_float_if_unset("scr_spawn_enemy_influencer_radius","2700",reset_dvars);
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
			entity playsound("mpl_splash_death");
			playfx(level._effect["water_splash"],40 + VectorScale((0,0,1)));
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
		else if(self istouching(trigger))
		{
			return 1;
		}
	}

	return 0;
}

//Function Number: 8
rts_remove()
{
	removes = getentarray("rts_only","targetname");
	foreach(remove in removes)
	{
		if(IsDefined(remove))
		{
			remove delete();
		}
	}
}

//Function Number: 9
devgui_dockside()
{
/#
	setdvar("devgui_notify","");
	for(;;)
	{
		wait(0.5);
		devgui_string = GetDvar(#"9488D1C1");
		switch(devgui_string)
		{
			case "€GSC\r\n":
				break;
			case "€GSC\r\n":
				crane_print_dvars();
				break;
			default:
				break;
		}
		setdvar("devgui_notify","");
	}
GetDvar(#"9488D1C1") != ""
#/
}

//Function Number: 10
crane_print_dvars()
{
/#
	dvars = [];
	dvars[dvars.size] = "scr_crane_claw_move_time";
	dvars[dvars.size] = "scr_crane_crate_lower_time";
	dvars[dvars.size] = "scr_crane_crate_raise_time";
	dvars[dvars.size] = "scr_crane_arm_y_move_time";
	dvars[dvars.size] = "scr_crane_arm_z_move_time";
	dvars[dvars.size] = "scr_crane_claw_drop_speed";
	dvars[dvars.size] = "scr_crane_claw_drop_time_min";
	_a211 = dvars;
	_k211 = FirstArrayKey(_a211);
	for(;;)
	{
		dvar = _a211[_k211];
		print(dvar + ": ");
		println(GetDvar(dvar));
		_k211 = NextArrayKey(_a211);
	}
_k211
IsDefined(_k211)
#/
}