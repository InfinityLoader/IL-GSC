/*******************************************************************
 * Decompiled By: Bog
 * Decompiled File: maps\mp\animscripts\dog_jump.gsc
 * Game: Call of Duty: Black Ops 2
 * Platform: Console
 * Function Count: 1
 * Decompile Time: 0 ms
 * Timestamp: 10/28/2023 12:13:29 AM
*******************************************************************/

#include maps/mp/animscripts/shared;
#include maps/mp/animscripts/utility;

//Function Number: 1
main()
{
	self endon("killanimscript");
	debug_anim_print("dog_jump::main()");
	self setaimanimweights(0,0);
	self.safetochangescript = 0;
	self setanimstate("traverse_wallhop");
	maps/mp/animscripts/shared::donotetracks("done");
	self.safetochangescript = 1;
}