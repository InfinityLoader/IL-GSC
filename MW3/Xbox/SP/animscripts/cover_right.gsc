/*******************************************************************
 * Decompiled By: Bog
 * Decompiled File: animscripts\cover_right.gsc
 * Game: Call of Duty: Modern Warfare 3
 * Platform: Console
 * Function Count: 4
 * Decompile Time: 84 ms
 * Timestamp: 10/27/2023 2:30:15 AM
*******************************************************************/

//Function Number: 1
main()
{
	self.animarrayfuncs = [];
	self.animarrayfuncs["hiding"]["stand"] = ::func_3AE2;
	self.animarrayfuncs["hiding"]["crouch"] = ::set_animarray_crouching_right;
	self endon("killanimscript");
	animscripts/utility::initialize("cover_right");
	animscripts/corner::corner_think("right",-90);
}

//Function Number: 2
end_script()
{
	animscripts/corner::func_1FCB();
	animscripts/cover_behavior::end_script("right");
}

//Function Number: 3
func_3AE2()
{
	var_00 = [];
	if(isdefined(level.ramboanims))
	{
	}

	self.hideyawoffset = -90;
	self.a.array = var_41;
}

//Function Number: 4
set_animarray_crouching_right()
{
	var_00 = [];
	self.hideyawoffset = -90;
	self.a.array = var_41;
}