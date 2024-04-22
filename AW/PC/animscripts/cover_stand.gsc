/*******************************************************************
 * Decompiled By: Bog
 * Decompiled File: cover_stand.gsc
 * Game: Call of Duty: Advanced Warfare
 * Platform: PC
 * Function Count: 2
 * Decompile Time: 38 ms
 * Timestamp: 4/22/2024 2:00:20 AM
*******************************************************************/

//Function Number: 1
main()
{
	self endon("killanimscript");
	animscripts\utility::initialize("cover_stand");
	animscripts\cover_wall::cover_wall_think("stand");
}

//Function Number: 2
end_script()
{
	animscripts\cover_behavior::end_script("stand");
}