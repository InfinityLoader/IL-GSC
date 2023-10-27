/*******************************************************************
 * Decompiled By: Bog
 * Decompiled File: animscripts\cover_swim_up.gsc
 * Game: Call of Duty: Ghosts
 * Platform: Console
 * Function Count: 3
 * Decompile Time: 47 ms
 * Timestamp: 10/27/2023 1:36:21 AM
*******************************************************************/

//Function Number: 1
func_4FDD()
{
	self.animarrayfuncs = [];
	self.animarrayfuncs["hiding"]["stand"] = ::func_6FE2;
	self.animarrayfuncs["hiding"]["crouch"] = ::func_6FE2;
	self endon("killanimscript");
	animscripts/utility::func_4622("cover_swim_up");
	if(!isdefined(self.var_EB9) || self.var_EB9 != "cover_u")
	{
		self.var_EB9 = "cover_u";
	}

	animscripts/corner::func_1F52("up",0);
}

//Function Number: 2
end_script()
{
	animscripts/corner::end_script_corner();
	animscripts/cover_behavior::end_script("up");
}

//Function Number: 3
func_6FE2()
{
	self.a.var_ED8 = animscripts/swim::func_3C1D("cover_u");
	self.var_420F = 0;
}