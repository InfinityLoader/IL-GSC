/*******************************************************************
 * Decompiled By: Bog
 * Decompiled File: animscripts\cover_crouch.gsc
 * Game: Call of Duty: Modern Warfare 3
 * Platform: Console
 * Function Count: 2
 * Decompile Time: 43 ms
 * Timestamp: 10/27/2023 2:30:13 AM
*******************************************************************/

//Function Number: 1
main()
{
	self endon("killanimscript");
	animscripts/utility::initialize("cover_crouch");
	animscripts/cover_wall::cover_wall_think("crouch");
}

//Function Number: 2
end_script()
{
	self.var_897 = undefined;
	animscripts/cover_behavior::end_script("crouch");
}