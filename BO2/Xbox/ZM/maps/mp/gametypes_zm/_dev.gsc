/*******************************************************************
 * Decompiled By: Bog
 * Decompiled File: maps\mp\gametypes_zm\_dev.gsc
 * Game: Call of Duty: Black Ops 2
 * Platform: Console
 * Function Count: 2
 * Decompile Time: 1 ms
 * Timestamp: 10/28/2023 12:14:09 AM
*******************************************************************/

#include common_scripts/utility;
#include maps/mp/_utility;

//Function Number: 1
init()
{
/#
	for(;;)
	{
		updatedevsettingszm();
		wait(0.5);
	}
#/
}

//Function Number: 2
updatedevsettingszm()
{
/#
	if(level.players.size > 0)
	{
		if(GetDvar(#"7B03E923") == "3")
		{
			if(!(IsDefined(level.streamdumpteamindex)))
			{
				level.streamdumpteamindex = 0;
			}
			else
			{
				level.streamdumpteamindex++;
			}

			numpoints = 0;
			spawnpoints = [];
			location = level.scr_zm_map_start_location;
			if((location == "default" || location == "") && IsDefined(level.default_start_location))
			{
				location = level.default_start_location;
			}

			match_string = level.scr_zm_ui_gametype + "_" + location;
			if(level.streamdumpteamindex < level.teams.size)
			{
				structs = getstructarray("initial_spawn","script_noteworthy");
				if(IsDefined(structs))
				{
					foreach(struct in structs)
					{
						if(IsDefined(struct.script_string))
						{
							tokens = strtok(struct.script_string," ");
							foreach(token in tokens)
							{
								if(token == match_string)
								{
									spawnpoints[spawnpoints.size] = struct;
								}
							}
						}
					}
				}

				if(!IsDefined(spawnpoints) || spawnpoints.size == 0)
				{
					spawnpoints = getstructarray("initial_spawn_points","targetname");
				}

				if(IsDefined(spawnpoints))
				{
					numpoints = spawnpoints.size;
				}
			}

			if(numpoints == 0)
			{
				setdvar("r_streamDumpDistance","0");
				level.streamdumpteamindex = -1;
			}
			else
			{
				averageorigin = (0,0,0);
				averageangles = (0,0,0);
				foreach(spawnpoint in spawnpoints)
				{
					averageorigin = averageorigin + spawnpoint.origin / numpoints;
					averageangles = averageangles + spawnpoint.angles / numpoints;
				}

				level.players[0] setplayerangles(averageangles);
				level.players[0] setorigin(averageorigin);
				wait(0.05);
				setdvar("r_streamDumpDistance","2");
			}
		}
	}
#/
}