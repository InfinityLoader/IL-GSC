/*******************************************************************
 * Decompiled By: Bog
 * Decompiled File: maps\mp\animscripts\zm_run.gsc
 * Game: Call of Duty: Black Ops 2
 * Platform: PC
 * Function Count: 4
 * Decompile Time: 0 ms
 * Timestamp: 10/28/2023 12:11:31 AM
*******************************************************************/

#include maps/mp/animscripts/shared;
#include maps/mp/animscripts/utility;
#include maps/mp/animscripts/zm_shared;
#include maps/mp/animscripts/zm_utility;

//Function Number: 1
moverun()
{
	self endon("death");
	if(IsDefined(self.needs_run_update) && !self.needs_run_update)
	{
		self waittill("needs_run_update");
	}

	if(IsDefined(self.is_inert) && self.is_inert)
	{
		wait(0.1);
		return;
	}

	self setaimanimweights(0,0);
	self setanimstatefromspeed();
	maps/mp/animscripts/zm_shared::donotetracksfortime(0.05,"move_anim");
	self.needs_run_update = 0;
}

//Function Number: 2
setanimstatefromspeed()
{
	animstate = self append_missing_legs_suffix("zm_move_" + self.zombie_move_speed);
	if(IsDefined(self.a.gib_ref) && self.a.gib_ref == "no_legs")
	{
		animstate = "zm_move_stumpy";
	}

	if(IsDefined(self.preserve_asd_substates) && self.preserve_asd_substates && animstate == self getanimstatefromasd())
	{
		substate = self getanimsubstatefromasd();
		self setanimstatefromasd(animstate,substate);
	}
	else
	{
		self setanimstatefromasd(animstate);
	}

	if(IsDefined(self.setanimstatefromspeed))
	{
		self [[ self.setanimstatefromspeed ]](animstate,substate);
	}
}

//Function Number: 3
needsupdate()
{
	self.needs_run_update = 1;
	self notify("needs_run_update");
}

//Function Number: 4
needsdelayedupdate()
{
	self endon("death");
	while(IsDefined(self.needs_run_update) && self.needs_run_update)
	{
		wait(0.1);
	}

	self.needs_run_update = 1;
	self notify("needs_run_update");
}