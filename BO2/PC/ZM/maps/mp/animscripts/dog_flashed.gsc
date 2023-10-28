/*******************************************************************
 * Decompiled By: Bog
 * Decompiled File: maps\mp\animscripts\dog_flashed.gsc
 * Game: Call of Duty: Black Ops 2
 * Platform: PC
 * Function Count: 2
 * Decompile Time: 0 ms
 * Timestamp: 10/28/2023 12:11:26 AM
*******************************************************************/

#include maps/mp/animscripts/shared;

//Function Number: 1
main()
{
	self endon("killanimscript");
	self endon("stop_flashbang_effect");
	wait(randomfloatrange(0,0.4));
	duration = self startflashbanged() * 0.001;
	self setanimstate("flashed");
	self maps/mp/animscripts/shared::donotetracks("done");
	self setflashbanged(0);
	self.flashed = 0;
	self notify("stop_flashbang_effect");
}

//Function Number: 2
startflashbanged()
{
	if(IsDefined(self.flashduration))
	{
		duration = self.flashduration;
	}
	else
	{
		duration = self getflashbangedstrength() * 1000;
	}

	self.flashendtime = GetTime() + duration;
	self notify("flashed");
	return duration;
}