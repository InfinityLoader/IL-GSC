/*******************************************************************
 * Decompiled By: Bog
 * Decompiled File: animscripts\cover_right.gsc
 * Game: Call of Duty: Modern Warfare 3
 * Platform: PC
 * Function Count: 4
 * Decompile Time: 78 ms
 * Timestamp: 10/27/2023 2:18:11 AM
*******************************************************************/

//Function Number: 1
main()
{
	self.var_2443 = [];
	self.var_2443["hiding"]["stand"] = ::func_3FDE;
	self.var_2443["hiding"]["crouch"] = ::func_3FDF;
	self endon("killanimscript");
	animscripts/utility::func_D15("cover_right");
	animscripts/corner::func_2442("right",-90);
}

//Function Number: 2
func_067F()
{
	animscripts/corner::func_2449();
	animscripts/cover_behavior::func_67F("right");
}

//Function Number: 3
func_3FDE()
{
	var_00 = [];
	if(isdefined(level.ramboanims))
	{
	}

	self.var_2474 = -90;
	self.a.array = var_7B;
}

//Function Number: 4
func_3FDF()
{
	var_00 = [];
	self.var_2474 = -90;
	self.a.array = var_7B;
}