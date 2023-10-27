/*******************************************************************
 * Decompiled By: Bog
 * Decompiled File: animscripts\first_frame.gsc
 * Game: Call of Duty: Ghosts
 * Platform: Console
 * Function Count: 1
 * Decompile Time: 22 ms
 * Timestamp: 10/27/2023 1:36:24 AM
*******************************************************************/

//Function Number: 1
func_4FDD()
{
	self endon("death");
	self endon("stop_first_frame");
	self notify("killanimscript");
	self.pushable = 0;
	self method_8253(self.root_anim,0.3);
	self method_820E("face angle",self.angles[1]);
	self method_825C(level.scr_anim[self._animname][self._first_frame_anim],1,0,0);
	self._first_frame_anim = undefined;
	self waittill("killanimscript");
}