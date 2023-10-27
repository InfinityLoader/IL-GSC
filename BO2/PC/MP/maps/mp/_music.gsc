/*******************************************************************
 * Decompiled By: Bog
 * Decompiled File: maps\mp\_music.gsc
 * Game: Call of Duty: Black Ops 2
 * Platform: PC
 * Function Count: 2
 * Decompile Time: 4 ms
 * Timestamp: 10/27/2023 3:01:29 AM
*******************************************************************/

#include maps/mp/_utility;

//Function Number: 1
music_init()
{
/#
	assert(level.clientscripts);
#/
	level.musicstate = "";
	registerclientsys("musicCmd");
}

//Function Number: 2
setmusicstate(state,player)
{
	if(IsDefined(level.musicstate))
	{
		if(IsDefined(player))
		{
			setclientsysstate("musicCmd",state,player);
			return;
		}
		else if(level.musicstate != state)
		{
			setclientsysstate("musicCmd",state);
		}
	}

	level.musicstate = state;
}