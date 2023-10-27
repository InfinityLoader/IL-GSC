/*******************************************************************
 * Decompiled By: Bog
 * Decompiled File: animscripts\cover_stand.gsc
 * Game: Call of Duty: Modern Warfare Remastered
 * Platform: PC
 * Function Count: 2
 * Decompile Time: 49 ms
 * Timestamp: 10/27/2023 2:43:58 AM
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