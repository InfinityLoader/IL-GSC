/*******************************************************************
 * Decompiled By: Bog
 * Decompiled File: scripts\anim\cover_crouch.gsc
 * Game: Call of Duty: Infinite Warfare
 * Platform: PC
 * Function Count: 2
 * Decompile Time: 136 ms
 * Timestamp: 10/27/2023 12:00:24 AM
*******************************************************************/

//Function Number: 1
main()
{
	self endon("killanimscript");
	scripts\anim\utility::func_9832("cover_crouch");
	scripts\anim\cover_wall::func_470E("crouch");
}

//Function Number: 2
func_010B()
{
	self.var_4716 = undefined;
	scripts\anim\cover_behavior::func_10B("crouch");
}