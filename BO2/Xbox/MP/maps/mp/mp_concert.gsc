/*******************************************************************
 * Decompiled By: Bog
 * Decompiled File: maps\mp\mp_concert.gsc
 * Game: Call of Duty: Black Ops 2
 * Platform: Console
 * Function Count: 9
 * Decompile Time: 39 ms
 * Timestamp: 10/27/2023 3:05:18 AM
*******************************************************************/

#include maps/mp/_compass;
#include maps/mp/_load;
#include maps/mp/_utility;
#include maps/mp/gametypes/_spawning;
#include maps/mp/mp_concert_amb;
#include maps/mp/mp_concert_fx;

//Function Number: 1
main()
{
	level.levelspawndvars = ::levelspawndvars;
	level.overrideplayerdeathwatchtimer = ::leveloverridetime;
	level.useintermissionpointsonwavespawn = ::useintermissionpointsonwavespawn;
	maps/mp/mp_concert_fx::main();
	maps/mp/_load::main();
	maps/mp/mp_concert_amb::main();
	maps/mp/_compass::setupminimap("compass_map_mp_concert");
	setdvar("compassmaxrange","2100");
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
	maps/mp/gametypes/_spawning::level_use_unified_spawning(1);
	level.remotemotarviewup = 18;
	level thread water_trigger_init();
}

//Function Number: 2
levelspawndvars(reset_dvars)
{
	ss = level.spawnsystem;
	ss.enemy_influencer_radius = set_dvar_float_if_unset("scr_spawn_enemy_influencer_radius","2300",reset_dvars);
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

	triggers = getentarray("water_killbrush","targetname");
	foreach(trigger in triggers)
	{
		trigger thread player_splash_think();
	}
}

//Function Number: 4
player_splash_think()
{
	for(;;)
	{
		self waittill("trigger",entity);
		if(isplayer(entity) && isalive(entity))
		{
			self thread trigger_thread(entity,::player_water_fx);
		}
	}
}

//Function Number: 5
player_water_fx(player,endon_condition)
{
	maxs = self.origin + self getmaxs();
	if(maxs[2] > 60)
	{
		maxs = 10 + VectorScale((0,0,1));
	}

	origin = (player.origin[0],player.origin[1],maxs[2]);
	playfx(level._effect["water_splash_sm"],origin);
}

//Function Number: 6
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

//Function Number: 7
leveloverridetime(defaulttime)
{
	if(self isinwater())
	{
		return 0.4;
	}
}

//Function Number: 8
useintermissionpointsonwavespawn()
{
	return self isinwater();
}

//Function Number: 9
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