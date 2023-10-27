/*******************************************************************
 * Decompiled By: Bog
 * Decompiled File: animscripts\cover_crouch.gsc
 * Game: Call of Duty: Modern Warfare 3
 * Platform: PC
 * Function Count: 2
 * Decompile Time: 45 ms
 * Timestamp: 10/27/2023 2:18:09 AM
*******************************************************************/

//Function Number: 1
main()
{
	self endon("killanimscript");
	animscripts/utility::func_D15("cover_crouch");
	animscripts/cover_wall::func_F76("crouch");
}

//Function Number: 2
func_067F()
{
	self.var_CAC = undefined;
	animscripts/cover_behavior::func_67F("crouch");
}