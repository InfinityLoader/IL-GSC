/*******************************************************************
 * Decompiled By: Bog
 * Decompiled File: maps\mp\animscripts\traverse\through_hole_42.gsc
 * Game: Call of Duty: Black Ops 2
 * Platform: PC
 * Function Count: 1
 * Decompile Time: 0 ms
 * Timestamp: 10/28/2023 12:10:22 AM
*******************************************************************/

#include maps/mp/animscripts/shared;
#include maps/mp/animscripts/traverse/shared;
#include maps/mp/animscripts/utility;

//Function Number: 1
main()
{
	self endon("killanimscript");
	self traversemode("nogravity");
	self traversemode("noclip");
	startnode = self getnegotiationstartnode();
/#
	assert(IsDefined(startnode));
#/
	self orientmode("face angle",startnode.angles[1]);
	if(IsDefined(startnode.traverse_height))
	{
		realheight = startnode.traverse_height - startnode.origin[2];
		self thread teleportthread(realheight);
	}

	debug_anim_print("traverse::through_hole()");
	self setanimstate("traverse_through_hole_42");
	maps/mp/animscripts/shared::donotetracksfortime(1,"done");
	debug_anim_print("traverse::through_hole()");
	self.traversecomplete = 1;
}