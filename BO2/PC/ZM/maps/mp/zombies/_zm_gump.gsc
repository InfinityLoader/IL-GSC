/*******************************************************************
 * Decompiled By: Bog
 * Decompiled File: maps\mp\zombies\_zm_gump.gsc
 * Game: Call of Duty: Black Ops 2
 * Platform: PC
 * Function Count: 5
 * Decompile Time: 10 ms
 * Timestamp: 10/27/2023 3:03:08 AM
*******************************************************************/

#include common_scripts/utility;
#include maps/mp/_utility;
#include maps/mp/zombies/_zm_utility;

//Function Number: 1
init()
{
	if(!(IsDefined(level.disable_blackscreen_clientfield) && level.disable_blackscreen_clientfield))
	{
		registerclientfield("toplayer","blackscreen",1,1,"int");
	}

	if(!(IsDefined(level.uses_gumps)))
	{
		level.uses_gumps = 0;
	}

	if(IsDefined(level.uses_gumps) && level.uses_gumps)
	{
		onplayerconnect_callback(::player_connect_gump);
	}
}

//Function Number: 2
player_teleport_blackscreen_on()
{
	if(IsDefined(level.disable_blackscreen_clientfield) && level.disable_blackscreen_clientfield)
	{
		return;
	}

	if(IsDefined(level.uses_gumps) && level.uses_gumps)
	{
		self setclientfieldtoplayer("blackscreen",1);
		wait(0.05);
		self setclientfieldtoplayer("blackscreen",0);
	}
}

//Function Number: 3
player_connect_gump()
{
}

//Function Number: 4
player_watch_spectate_change()
{
	if(IsDefined(level.disable_blackscreen_clientfield) && level.disable_blackscreen_clientfield)
	{
		return;
	}

	self endon("disconnect");
	while(1)
	{
		self waittill("spectator_cycle");
		self setclientfieldtoplayer("blackscreen",1);
		wait(0.05);
		self setclientfieldtoplayer("blackscreen",0);
	}
}

//Function Number: 5
gump_test()
{
/#
	wait(10);
	pos1 = (-4904,-7657,4);
	pos3 = (7918,-6506,177);
	pos2 = (1986,-73,4);
	players = get_players();
	players[0] setorigin(pos1);
	wait(0.05);
	players[1] setorigin(pos2);
	wait(0.05);
	players[2] setorigin(pos3);
IsDefined(players[2])
IsDefined(players[1])
IsDefined(players[0])
#/
}