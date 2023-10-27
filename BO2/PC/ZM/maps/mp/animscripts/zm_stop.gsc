/*******************************************************************
 * Decompiled By: Bog
 * Decompiled File: maps\mp\animscripts\zm_stop.gsc
 * Game: Call of Duty: Black Ops 2
 * Platform: PC
 * Function Count: 1
 * Decompile Time: 10 ms
 * Timestamp: 10/27/2023 3:02:23 AM
*******************************************************************/

#include maps/mp/animscripts/shared;
#include maps/mp/animscripts/utility;
#include maps/mp/animscripts/zm_shared;
#include maps/mp/animscripts/zm_utility;

//Function Number: 1
main()
{
	self endon("killanimscript");
	for(;;)
	{
		if(IsDefined(level.ignore_stop_func))
		{
			if(self [[ level.ignore_stop_func ]]())
			{
				return;
			}
		}

		if(!(self hasanimstatefromasd("zm_idle")))
		{
			return;
		}

		animstate = maps/mp/animscripts/zm_utility::append_missing_legs_suffix("zm_idle");
		self setanimstatefromasd(animstate);
		maps/mp/animscripts/zm_shared::donotetracks("idle_anim");
	}
}