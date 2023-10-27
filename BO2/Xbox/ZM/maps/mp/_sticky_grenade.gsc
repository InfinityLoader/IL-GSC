/*******************************************************************
 * Decompiled By: Bog
 * Decompiled File: maps\mp\_sticky_grenade.gsc
 * Game: Call of Duty: Black Ops 2
 * Platform: Console
 * Function Count: 2
 * Decompile Time: 1 ms
 * Timestamp: 10/27/2023 3:06:30 AM
*******************************************************************/

#include common_scripts/utility;
#include maps/mp/_utility;

//Function Number: 1
init()
{
	loadfx("weapon/crossbow/fx_trail_crossbow_blink_grn_os");
	loadfx("weapon/crossbow/fx_trail_crossbow_blink_red_os");
}

//Function Number: 2
watch_bolt_detonation(owner)
{
}