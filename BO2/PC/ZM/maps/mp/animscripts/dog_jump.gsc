/*******************************************************************
 * Decompiled By: Bog
 * Decompiled File: maps\mp\animscripts\dog_jump.gsc
 * Game: Call of Duty: Black Ops 2
 * Platform: PC
 * Function Count: 1
 * Decompile Time: 7 ms
 * Timestamp: 10/27/2023 3:02:03 AM
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