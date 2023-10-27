/*******************************************************************
 * Decompiled By: Bog
 * Decompiled File: maps\mp\animscripts\zm_dog_jump.gsc
 * Game: Call of Duty: Black Ops 2
 * Platform: PC
 * Function Count: 1
 * Decompile Time: 60 ms
 * Timestamp: 10/27/2023 3:02:10 AM
*******************************************************************/

#include maps/mp/animscripts/shared;
#include maps/mp/animscripts/utility;
#include maps/mp/animscripts/zm_shared;

//Function Number: 1
main()
{
	self endon("killanimscript");
	debug_anim_print("dog_jump::main()");
	self setaimanimweights(0,0);
	self.safetochangescript = 0;
	self setanimstatefromasd("zm_traverse_wallhop");
	maps/mp/animscripts/zm_shared::donotetracks("traverse_wallhop");
	self.safetochangescript = 1;
}