/*******************************************************************
 * Decompiled By: Bog
 * Decompiled File: animscripts\cover_stand.gsc
 * Game: Call of Duty: Ghosts
 * Platform: Console
 * Function Count: 2
 * Decompile Time: 34 ms
 * Timestamp: 10/27/2023 1:36:20 AM
*******************************************************************/

//Function Number: 1
func_4FDD()
{
	self endon("killanimscript");
	animscripts/utility::func_4622("cover_stand");
	animscripts/cover_wall::func_1FA9("stand");
}

//Function Number: 2
end_script()
{
	animscripts/cover_behavior::end_script("stand");
}