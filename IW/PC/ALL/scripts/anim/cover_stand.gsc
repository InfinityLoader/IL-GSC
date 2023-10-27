/*******************************************************************
 * Decompiled By: Bog
 * Decompiled File: scripts\anim\cover_stand.gsc
 * Game: Call of Duty: Infinite Warfare
 * Platform: PC
 * Function Count: 2
 * Decompile Time: 139 ms
 * Timestamp: 10/27/2023 12:00:26 AM
*******************************************************************/

//Function Number: 1
main()
{
	self endon("killanimscript");
	scripts\anim\utility::func_9832("cover_stand");
	scripts\anim\cover_wall::func_470E("stand");
}

//Function Number: 2
func_010B()
{
	scripts\anim\cover_behavior::func_10B("stand");
}