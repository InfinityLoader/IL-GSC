/*******************************************************************
 * Decompiled By: Bog
 * Decompiled File: maps\mp\animscripts\zm_dog_pain.gsc
 * Game: Call of Duty: Black Ops 2
 * Platform: PC
 * Function Count: 1
 * Decompile Time: 0 ms
 * Timestamp: 10/28/2023 12:11:29 AM
*******************************************************************/

#include maps/mp/animscripts/utility;

//Function Number: 1
main()
{
	debug_anim_print("dog_pain::main() ");
	self endon("killanimscript");
	self setaimanimweights(0,0);
}