/*******************************************************************
 * Decompiled By: Bog
 * Decompiled File: animscripts\cover_left.gsc
 * Game: Call of Duty: Modern Warfare 3
 * Platform: Console
 * Function Count: 4
 * Decompile Time: 82 ms
 * Timestamp: 10/27/2023 2:30:14 AM
*******************************************************************/

//Function Number: 1
main()
{
	self.animarrayfuncs = [];
	self.animarrayfuncs["hiding"]["stand"] = ::func_3AE0;
	self.animarrayfuncs["hiding"]["crouch"] = ::func_3AE1;
	self endon("killanimscript");
	animscripts/utility::initialize("cover_left");
	animscripts/corner::corner_think("left",90);
}

//Function Number: 2
end_script()
{
	animscripts/corner::func_1FCB();
	animscripts/cover_behavior::end_script("left");
}

//Function Number: 3
func_3AE0()
{
	var_00 = [];
	if(isdefined(level.ramboanims))
	{
	}

	self.hideyawoffset = 90;
	self.a.array = var_41;
}

//Function Number: 4
func_3AE1()
{
	var_00 = [];
	self.hideyawoffset = 90;
	self.a.array = var_41;
}