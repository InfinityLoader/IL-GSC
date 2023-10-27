/*******************************************************************
 * Decompiled By: Bog
 * Decompiled File: maps\mp\animscripts\dog_pain.gsc
 * Game: Call of Duty: Black Ops 2
 * Platform: Console
 * Function Count: 1
 * Decompile Time: 9 ms
 * Timestamp: 10/27/2023 3:04:07 AM
*******************************************************************/

#include maps/mp/animscripts/shared;
#include maps/mp/animscripts/utility;

//Function Number: 1
main()
{
	debug_anim_print("dog_pain::main() ");
	self endon("killanimscript");
	self setaimanimweights(0,0);
	if(IsDefined(self.enemy) && IsDefined(self.enemy.syncedmeleetarget) && self.enemy.syncedmeleetarget == self)
	{
		self unlink();
		self.enemy.syncedmeleetarget = undefined;
	}

	speed = length(self getvelocity());
	pain_anim = getanimdirection(self.damageyaw);
	if(speed > level.dogrunpainspeed)
	{
		pain_anim = "pain_run_" + pain_anim;
	}
	else
	{
		pain_anim = "pain_" + pain_anim;
	}

	self setanimstate(pain_anim);
	self maps/mp/animscripts/shared::donotetracksfortime(0.2,"done");
}