/*******************************************************************
 * Decompiled By: Bog
 * Decompiled File: maps\mp\animscripts\zm_dog_death.gsc
 * Game: Call of Duty: Black Ops 2
 * Platform: PC
 * Function Count: 1
 * Decompile Time: 10 ms
 * Timestamp: 10/27/2023 3:02:09 AM
*******************************************************************/

#include maps/mp/animscripts/utility;
#include maps/mp/animscripts/zm_shared;

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
	self animmode("gravity");
	debug_anim_print("dog_death::main() - Setting " + death_anim);
	self setanimstatefromasd(death_anim);
	maps/mp/animscripts/zm_shared::donotetracks("dead_dog");
}