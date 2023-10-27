/*******************************************************************
 * Decompiled By: Bog
 * Decompiled File: animscripts\first_frame.gsc
 * Game: Call of Duty: Modern Warfare 3
 * Platform: Console
 * Function Count: 1
 * Decompile Time: 38 ms
 * Timestamp: 10/27/2023 2:30:23 AM
*******************************************************************/

//Function Number: 1
main()
{
	self endon("death");
	self endon("stop_first_frame");
	self notify("killanimscript");
	self.pushable = 0;
	self clearanim(self.root_anim,0.3);
	self orientmode("face angle",self.angles[1]);
	self setanim(level.scr_anim[self._animname][self._first_frame_anim],1,0,0);
	self._first_frame_anim = undefined;
	self waittill("killanimscript");
}