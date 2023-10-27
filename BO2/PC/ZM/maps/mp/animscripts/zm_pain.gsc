/*******************************************************************
 * Decompiled By: Bog
 * Decompiled File: maps\mp\animscripts\zm_pain.gsc
 * Game: Call of Duty: Black Ops 2
 * Platform: PC
 * Function Count: 1
 * Decompile Time: 122 ms
 * Timestamp: 10/27/2023 3:02:19 AM
*******************************************************************/

#include common_scripts/utility;
#include maps/mp/animscripts/shared;
#include maps/mp/animscripts/utility;
#include maps/mp/animscripts/zm_utility;

//Function Number: 1
main()
{
	self setflashbanged(0);
	if(IsDefined(self.longdeathstarting))
	{
		self waittill("killanimscript");
		return;
	}

	if(self.a.disablepain)
	{
	}