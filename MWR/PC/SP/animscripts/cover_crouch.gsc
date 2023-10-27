/*******************************************************************
 * Decompiled By: Bog
 * Decompiled File: animscripts\cover_crouch.gsc
 * Game: Call of Duty: Modern Warfare Remastered
 * Platform: PC
 * Function Count: 2
 * Decompile Time: 44 ms
 * Timestamp: 10/27/2023 2:43:53 AM
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