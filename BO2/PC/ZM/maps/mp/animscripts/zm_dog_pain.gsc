/*******************************************************************
 * Decompiled By: Bog
 * Decompiled File: maps\mp\animscripts\zm_dog_pain.gsc
 * Game: Call of Duty: Black Ops 2
 * Platform: PC
 * Function Count: 1
 * Decompile Time: 3 ms
 * Timestamp: 10/27/2023 3:02:12 AM
*******************************************************************/

#include maps/mp/animscripts/utility;

//Function Number: 1
main()
{
	debug_anim_print("dog_pain::main() ");
	self endon("killanimscript");
	self setaimanimweights(0,0);
}