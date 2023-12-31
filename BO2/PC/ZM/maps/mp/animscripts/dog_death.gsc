/*******************************************************************
 * Decompiled By: Bog
 * Decompiled File: maps\mp\animscripts\dog_death.gsc
 * Game: Call of Duty: Black Ops 2
 * Platform: PC
 * Function Count: 1
 * Decompile Time: 0 ms
 * Timestamp: 10/28/2023 12:11:26 AM
*******************************************************************/

#include maps/mp/animscripts/shared;
#include maps/mp/animscripts/utility;

//Function Number: 1
main()
{
	debug_anim_print("dog_death::main()");
	self setaimanimweights(0,0);
	self endon("killanimscript");
	if(IsDefined(self.a.nodeath))
	{
/#
		assert(self.a.nodeath,"Nodeath needs to be set to true or undefined.");
#/
		wait(3);
		return;
	}

	self unlink();
	if(IsDefined(self.enemy) && IsDefined(self.enemy.syncedmeleetarget) && self.enemy.syncedmeleetarget == self)
	{
		self.enemy.syncedmeleetarget = undefined;
	}

	death_anim = "death_" + getanimdirection(self.damageyaw);
/#
	println(death_anim);
#/
	self animmode("gravity",0);
	debug_anim_print("dog_death::main() - Setting " + death_anim);
	self setanimstate(death_anim);
	self maps/mp/animscripts/shared::donotetracks("done");
}