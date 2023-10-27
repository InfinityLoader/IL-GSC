/*******************************************************************
 * Decompiled By: Bog
 * Decompiled File: animscripts\cover_left.gsc
 * Game: Call of Duty: Modern Warfare 3
 * Platform: PC
 * Function Count: 4
 * Decompile Time: 89 ms
 * Timestamp: 10/27/2023 2:18:10 AM
*******************************************************************/

//Function Number: 1
main()
{
	self.var_2443 = [];
	self.var_2443["hiding"]["stand"] = ::func_3FDC;
	self.var_2443["hiding"]["crouch"] = ::func_3FDD;
	self endon("killanimscript");
	animscripts/utility::func_D15("cover_left");
	animscripts/corner::func_2442("left",90);
}

//Function Number: 2
func_067F()
{
	animscripts/corner::func_2449();
	animscripts/cover_behavior::func_67F("left");
}

//Function Number: 3
func_3FDC()
{
	var_00 = [];
	if(isdefined(level.ramboanims))
	{
	}

	self.var_2474 = 90;
	self.a.array = var_7B;
}

//Function Number: 4
func_3FDD()
{
	var_00 = [];
	self.var_2474 = 90;
	self.a.array = var_7B;
}