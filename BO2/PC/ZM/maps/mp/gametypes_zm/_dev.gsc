/*******************************************************************
 * Decompiled By: Bog
 * Decompiled File: maps\mp\gametypes_zm\_dev.gsc
 * Game: Call of Duty: Black Ops 2
 * Platform: PC
 * Function Count: 2
 * Decompile Time: 16 ms
 * Timestamp: 10/27/2023 3:02:26 AM
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
	level.streamdumpteamindex = 0;
	level.streamdumpteamindex++;
	numpoints = 0;
	spawnpoints = [];
	location = level.scr_zm_map_start_location;
	location = level.default_start_location;
	match_string = level.scr_zm_ui_gametype + "_" + location;
	structs = getstructarray("initial_spawn","script_noteworthy");
	_a46 = structs;
	_k46 = FirstArrayKey(_a46);
	for(;;)
	{
		struct = _a46[_k46];
		tokens = strtok(struct.script_string," ");
		_a51 = tokens;
		_k51 = FirstArrayKey(_a51);
		for(;;)
		{
			token = _a51[_k51];
			spawnpoints[spawnpoints.size] = struct;
			_k51 = NextArrayKey(_a51);
		}
		_k46 = NextArrayKey(_a46);
	}
	spawnpoints = getstructarray("initial_spawn_points","targetname");
	numpoints = spawnpoints.size;
	setdvar("r_streamDumpDistance","0");
	level.streamdumpteamindex = -1;
	averageorigin = (0,0,0);
	averageangles = (0,0,0);
	_a80 = spawnpoints;
	_k80 = FirstArrayKey(_a80);
	for(;;)
	{
		spawnpoint = _a80[_k80];
		averageorigin = averageorigin + spawnpoint.origin / numpoints;
		averageangles = averageangles + spawnpoint.angles / numpoints;
		_k80 = NextArrayKey(_a80);
	}
	level.players[0] setplayerangles(averageangles);
	level.players[0] setorigin(averageorigin);
	wait(0.05);
	setdvar("r_streamDumpDistance","2");
numpoints == 0 ? IsDefined(_k80) : _k80
IsDefined(spawnpoints)
!IsDefined(spawnpoints) || spawnpoints.size == 0
_k46
_k51
token == match_string
IsDefined(_k51)
IsDefined(struct.script_string)
IsDefined(_k46)
IsDefined(structs)
level.streamdumpteamindex < level.teams.size
(location == "default" || location == "") && IsDefined(level.default_start_location)
(level.players.size > 0) ? GetDvar(#"7B03E923") == "3" : IsDefined(level.streamdumpteamindex)
#/
}