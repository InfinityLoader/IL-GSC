/*******************************************************************
 * Decompiled By: Bog
 * Decompiled File: animscripts\cover_crouch.gsc
 * Game: Call of Duty: Ghosts
 * Platform: Console
 * Function Count: 2
 * Decompile Time: 43 ms
 * Timestamp: 10/27/2023 1:36:17 AM
*******************************************************************/

//Function Number: 1
func_4FDD()
{
	self endon("killanimscript");
	animscripts/utility::func_4622("cover_crouch");
	animscripts/cover_wall::func_1FA9("crouch");
}

//Function Number: 2
end_script()
{
	self.covercrouchlean_aimmode = undefined;
	animscripts/cover_behavior::end_script("crouch");
}