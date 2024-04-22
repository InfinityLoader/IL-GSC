/*******************************************************************
 * Decompiled By: Bog
 * Decompiled File: cover_crouch.gsc
 * Game: Call of Duty: Advanced Warfare
 * Platform: PC
 * Function Count: 2
 * Decompile Time: 41 ms
 * Timestamp: 4/22/2024 2:00:17 AM
*******************************************************************/

//Function Number: 1
main()
{
	self endon("killanimscript");
	animscripts\utility::initialize("cover_crouch");
	animscripts\cover_wall::cover_wall_think("crouch");
}

//Function Number: 2
end_script()
{
	self.covercrouchlean_aimmode = undefined;
	animscripts\cover_behavior::end_script("crouch");
}