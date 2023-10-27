/*******************************************************************
 * Decompiled By: Bog
 * Decompiled File: animscripts\cover_stand.gsc
 * Game: Call of Duty: Modern Warfare 3
 * Platform: PC
 * Function Count: 2
 * Decompile Time: 44 ms
 * Timestamp: 10/27/2023 2:18:12 AM
*******************************************************************/

//Function Number: 1
main()
{
	self endon("killanimscript");
	animscripts/utility::func_D15("cover_stand");
	animscripts/cover_wall::func_F76("stand");
}

//Function Number: 2
func_067F()
{
	animscripts/cover_behavior::func_67F("stand");
}