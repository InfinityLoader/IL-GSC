/*******************************************************************
 * Decompiled By: Bog
 * Decompiled File: maps\mp\_medals.gsc
 * Game: Call of Duty: Black Ops 2
 * Platform: PC
 * Function Count: 6
 * Decompile Time: 7 ms
 * Timestamp: 10/27/2023 3:01:27 AM
*******************************************************************/

#include common_scripts/utility;
#include maps/mp/_scoreevents;
#include maps/mp/_utility;

//Function Number: 1
init()
{
	level.medalinfo = [];
	level.medalcallbacks = [];
	level.numkills = 0;
	level thread onplayerconnect();
}

//Function Number: 2
onplayerconnect()
{
	for(;;)
	{
		level waittill("connected",player);
		player.lastkilledby = undefined;
	}
}

//Function Number: 3
setlastkilledby(attacker)
{
	self.lastkilledby = attacker;
}

//Function Number: 4
offenseglobalcount()
{
	level.globalteammedals++;
}

//Function Number: 5
defenseglobalcount()
{
	level.globalteammedals++;
}

//Function Number: 6
codecallback_medal(medalindex)
{
	self luinotifyevent(&"medal_received",1,medalindex);
	self luinotifyeventtospectators(&"medal_received",1,medalindex);
}